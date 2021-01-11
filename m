Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC31C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 04:55:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF9E8224D2
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 04:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9E8224D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C87489BAC;
	Mon, 11 Jan 2021 04:55:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59FB189BA3
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 04:55:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gf34wBQjTSZFweVcorWZ/youT9ojgEur7GtyTP9CUuCv+vhvVxkuOARO2Hf5GuxAUUOIzONTvMfJJvj3en5e5FQ/9IaxwwvmyV/rhXi03miF2t5Ws3mTnq3j5w080MKef20X2YQNnrjr+GNRE3aTgJUydAWg9EQwF93mrQ94YFb4OSalqxYHBFciEChSQtKVmtuvGec81prkulS6La9xfuLIffQfHxorLsmbel2oTCL+de7CBKEjibg2uQXEMEg1CjfUJB+h2Wlho66gBnnleUa6C330oVk+LNauilBQokE5DrJLlZXaKqArTz/CWlE37+GYNjXnYqzt53yDWwfQtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBLF7R3v0LZ+3sqvnhUy92a6NqKAe68Gngnz+QwC0pY=;
 b=df73Bz9jEavbjpXkfmACVMi4UGBaoHvti7y0+TQJTu7HLlfNnCV1g91wREnZwAo6NIEYMxkcdaxNnLczj4L8XdY0mFUNoj03CJnySj5x4Z7p7B12y9k2BzDNHJJG1mQf2+p2Tt9H0tmv0cZSjjEc76v+mIV/Gp6vD53ZD4WgjYAircL3Msto/wG4Z4gtf3uwgHX6/kQ0brNu2b9Y4F/NyUNCxzRN/YIUB8Z1j+X7Vfz6WYAd5jyxanzJ6btGxq924XkEux2g1qKkDaiwCiLSZi8wPOkg+v3VosOx6MdojtE5x6tEg94Cj2h403jlBePPE+urval4I25WG01amrg/bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBLF7R3v0LZ+3sqvnhUy92a6NqKAe68Gngnz+QwC0pY=;
 b=JoqtUdmJfMIJZzVMskM2bEBVHdiuHoR5HNrnTiXVjkBLtvuxRT5AbZhjxmFzli+Dpge5cqzU14RUqUjHHjkUQE7v4qMlmQIqRjsZ8lGoW1iHfisSJIbh0KhUoetspDPKM5FAddse5wbI7o2lD4cMT6C8jWHrDN0a+cbb2SbUJ5E=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB3414.namprd12.prod.outlook.com (2603:10b6:a03:aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 04:55:45 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145%5]) with mapi id 15.20.3742.006; Mon, 11 Jan 2021
 04:55:44 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH v2] drm/amdgpu:Limit the resolution for virtual_display
Thread-Topic: [PATCH v2] drm/amdgpu:Limit the resolution for virtual_display
Thread-Index: AQHW5KVRqTF27MuwQkGt+AIkPIfolKoc9qJggADh7YCABAnEIA==
Date: Mon, 11 Jan 2021 04:55:44 +0000
Message-ID: <BY5PR12MB411578DED560A6B45727AA2C8FAB0@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210107032927.660772-1-Emily.Deng@amd.com>
 <BY5PR12MB4115BE023BAF8FE53E2070158FAE0@BY5PR12MB4115.namprd12.prod.outlook.com>
 <CADnq5_N0hYURmnApHxhk3xmY426jyRNCBn97JoNxAq8t3f=Ojw@mail.gmail.com>
In-Reply-To: <CADnq5_N0hYURmnApHxhk3xmY426jyRNCBn97JoNxAq8t3f=Ojw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=2c731637-2d1d-4d61-b8ae-b251a9dd8660;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-11T04:54:14Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fd1afd37-31dd-42b4-c4e5-08d8b5ed27a4
x-ms-traffictypediagnostic: BYAPR12MB3414:
x-microsoft-antispam-prvs: <BYAPR12MB3414BC9D12C5C2751E15334E8FAB0@BYAPR12MB3414.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qlEneYLm6XwOdVPCGsWg+eYE2mAMChWtHBeCdTYrwwIZm7MtOgiN92Qr8RbZuxya6RJc4xgW5SFICs72asitSjaB4K8OIXOoISfRmHkuFWf4mZXrU10M5e0ms80qlF80Rct0oE6rws1gEnYJpjvsCBFcHp+0ibpgP2y2pbb+R8GdMd6RuMvMLjlF/ABybYstZCAeIyJ3GIFrQ7kE98lxBr18MJVdvr6NgKmhf1hz0RRxcs16Nvxtcb2Hk7dWw4fNtswTZStR30Tyry+I4ODpGw9FaM3PjlUD1KAK79j8MLqmyi1gDxxR5zRZbearl5xf4qxMAXusFZo4pMVDYj9jxnCv9VrHHrJV7evEU9MQirlmO37W7jyU05F8CFJa/mFbpmknmmdjqXVH5P0dj7mt26N8yM9U/g9uNuUR345daZBh2e7yHr/qxNlQbgQGgwDEYDGGAapUnMg829TQa1vp9A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(71200400001)(86362001)(66446008)(52536014)(64756008)(8936002)(8676002)(76116006)(2906002)(186003)(83380400001)(6916009)(5660300002)(4326008)(55016002)(66556008)(66476007)(66946007)(9686003)(33656002)(478600001)(6506007)(45080400002)(316002)(26005)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?PWLx/ULvHBv4yy/PlVGk1YNhCXEdanttVJGyr1KGLTCB9uSfItU9nQgvcNuV?=
 =?us-ascii?Q?WgGD+sdqrN1ObsdyPBbYEuCBCFJVTGE4EgJ0JjrfwMI5XHueTv5a5xvVygML?=
 =?us-ascii?Q?uBlQuxoA/dXlbQEeL9/guvg9BIfhQIWEzFgERwW3fOMifA5XmBsBkGMFw67S?=
 =?us-ascii?Q?GGCRaSHF8IENkm4TPYyTEgqTrsxvwhIiGApJdLuUJwUHXPRy0GPctzDFAAiU?=
 =?us-ascii?Q?igwuaOkHzvcU0BIfsIk4td3BW5ASMEVZZdtNGDrjshA80Mb1YugOKg6zKkba?=
 =?us-ascii?Q?/O6+avdWL2f1dt31WqxVMVDyJpVbXzd2gGHa0xv920J/ya02jlxTSFLM9+JR?=
 =?us-ascii?Q?YLbo/6KEXMse3AQ/mlhAIYxGMKTuopA3Z8UE4ZbF6yceqqf7NnDzkOpcYR7p?=
 =?us-ascii?Q?nGi4J8zbz1Eeu/cZ9X9WVXJkwe4ErXlTJzJAe/1Pfsqzo/lkedReKpO5UrVW?=
 =?us-ascii?Q?Oa5RqK8kNOuoNtFfpVgWkhPV9KC2nCg7wvfan36CBBY4scCgmHAxAct/F5zV?=
 =?us-ascii?Q?TZAvPZNmKqTjhjXGHk666mURru+8tq+Pq0DMPhN7gMGnH42fFwg5wyXzHxEt?=
 =?us-ascii?Q?pViI3iE/vWQhxux6T24cuJAwj0lDDcu+RQj1i+pheLJzw6WMvPZLj5nBiAq+?=
 =?us-ascii?Q?pHxMZl1VKgSA/GFpFs0R6h3Pi4eIeVqrU5CjelcT0PngvuGnRRuarvQS+Gwb?=
 =?us-ascii?Q?6LvJD2hsJG1VlrXYMMBMdHs9GFlVLD7YyeeTZoYuDrlp+Xze/f6Va7ygVfPS?=
 =?us-ascii?Q?g8X5dnmcxbtEOvT5iedSpawz+HddDV5Iuo5Rt7fYtUcEP9wdZNIRBQ4XmsMW?=
 =?us-ascii?Q?W3uvumEcvbcTPYtYEBurf7jQA6F4MPKCStl1CpCO6kqdv7M16PBDEyutPOO4?=
 =?us-ascii?Q?LE5tGhy3k/G7BY3A0neRSPROvn1jm9P2Fyqs+Xu4WOoR2mA4OIeW26kp6fJ1?=
 =?us-ascii?Q?O86f/H8zQzKV3LkacEaLS1mn6ZcYNIn+jmAi8nZORyE=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1afd37-31dd-42b4-c4e5-08d8b5ed27a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2021 04:55:44.8886 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZB+DNEDLGcVfY1pV1LbGPxX8rjlnjmp4satfxkNbgbktzHDC416N+vR5UTILVidY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3414
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Yes, it just won't report bigger than 16384 mode to user mode, as it won't work properly.

Best wishes
Emily Deng



>-----Original Message-----
>From: Alex Deucher <alexdeucher@gmail.com>
>Sent: Friday, January 8, 2021 11:14 PM
>To: Deng, Emily <Emily.Deng@amd.com>
>Cc: amd-gfx@lists.freedesktop.org
>Subject: Re: [PATCH v2] drm/amdgpu:Limit the resolution for virtual_display
>
>On Thu, Jan 7, 2021 at 8:45 PM Deng, Emily <Emily.Deng@amd.com> wrote:
>>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>> Ping ......
>>
>
>It's not clear what problem this solves.
>
>Alex
>
>
>> Best wishes
>> Emily Deng
>>
>>
>>
>> >-----Original Message-----
>> >From: Emily Deng <Emily.Deng@amd.com>
>> >Sent: Thursday, January 7, 2021 11:29 AM
>> >To: amd-gfx@lists.freedesktop.org
>> >Cc: Deng, Emily <Emily.Deng@amd.com>
>> >Subject: [PATCH v2] drm/amdgpu:Limit the resolution for
>> >virtual_display
>> >
>> >From: "Emily.Deng" <Emily.Deng@amd.com>
>> >
>> >Limit the resolution not bigger than 16384, which means
>> >dev->mode_info.num_crtc * common_modes[i].w not bigger than 16384.
>> >
>> >v2:
>> >  Refine the code
>> >
>> >Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
>> >---
>> > drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 7 +++++--
>> > 1 file changed, 5 insertions(+), 2 deletions(-)
>> >
>> >diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>> >b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>> >index 2b16c8faca34..fd2b3a6dfd60 100644
>> >--- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>> >+++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>> >@@ -319,6 +319,7 @@ dce_virtual_encoder(struct drm_connector
>> >*connector)  static int dce_virtual_get_modes(struct drm_connector
>> >*connector)  {
>> > struct drm_device *dev = connector->dev;
>> >+struct amdgpu_device *adev = dev->dev_private;
>> > struct drm_display_mode *mode = NULL;  unsigned i;  static const
>> >struct mode_size { @@ -350,8 +351,10 @@ static int
>> >dce_virtual_get_modes(struct drm_connector *connector)  };
>> >
>> > for (i = 0; i < ARRAY_SIZE(common_modes); i++) { -mode =
>> >drm_cvt_mode(dev, common_modes[i].w, common_modes[i].h, 60, false,
>> >false, false); -drm_mode_probed_add(connector, mode);
>> >+if (adev->mode_info.num_crtc * common_modes[i].w <=
>> >16384) {
>> >+mode = drm_cvt_mode(dev, common_modes[i].w,
>> >common_modes[i].h, 60, false, false, false);
>> >+drm_mode_probed_add(connector, mode); }
>> > }
>> >
>> > return 0;
>> >--
>> >2.25.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>>
>https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
>reedesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=04%7C01%7CEmily.Deng%40amd.com%7C74bdfb637c914153
>938508d8b3e81705%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7
>C637457156687621480%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
>MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sda
>ta=nDMymiTnfGo3ScIogcE8bch6ptCULS2GXSnuLcYQZEA%3D&amp;reserved=
>0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37307C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 10:40:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE2712310E
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 10:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2712310E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23B7989C9C;
	Wed,  6 Jan 2021 10:40:57 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680068.outbound.protection.outlook.com [40.107.68.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34F2B89C9C
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 10:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyVO5O/uIGiXAluS6HbeRkv6jTfd5rj/pf+ZKnGlypr51a+i53cj/dx+XTKRVLK10aL9EAP7YXHzNGGHshiYMV2l024VXiDbcfWRbUDEEl4YM9p45EaMgBsjaXhaFkjZzGe7e0NDO/ynHhEOr4MQZs6WD8tYQD9Xr7vDzXAlu4CYq/WkZacaUvRpgK9/yrDhOQkQCb29uV9CPJ8YnYHmCa47lhcInouNbsMv22GUB3K5HeDw7XgNBL0CjHmAha9qxfCLoSJ+JH3cyU+5iYcOVtTedrNwvcFjb3jn+/bgTF+LyhQuxDUHTZ532JLoJt3o8mvyfaISKxIQIpr4Ow6qjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCYclFbdMBLhPjZ8UX287OxylR2mak/4sPWee4ykLT4=;
 b=CrIsrImroBBblLXmr8EkKwCMi7nkyrqCHBzIpYVMtk9riYiqde7nPjxwj6dLJi9CJhrhouJ5SUabVOYvjiZu3zWPMFi4baGb1BSAreyAc7N/DCIi49i5z0KeqKFFP/NFsY4LGOAUTbikvjhasq6KOnGX13uVcoyZYYJpSKIeBUbqKUKpyx1TdxUGavihuSXGcf8TfCmSBE7FTqsuqtzoFDyyh9x+3COMTd0bvdwoU8nzqusbdp7CCCJVcbbdcuzcsA3x+a2/LZ/vzAh6mfBLeTz+VuIz/wYVGDKPsfJGGVtjpjn7v4F1S+8BelCMs+m27bALvleTC0B0GQrjnKXoTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCYclFbdMBLhPjZ8UX287OxylR2mak/4sPWee4ykLT4=;
 b=l9SvmP5HdxcFCV1tQD7gfhxg1d23MPq/w1xMfQ4SXS3MX3t45uPjCnpddhnPq/y/cgLfrn28WwSezJUDiwthI7uAZ22pjg+Ehy+54MTF5kvF3vNuxwmz4+v60eChlvOSL1Txl8weKwZUHuTNDCAR9Ue4Oi39gbBQfmlzdKYj5Ck=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB2966.namprd12.prod.outlook.com (2603:10b6:a03:df::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 6 Jan
 2021 10:40:52 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::5541:9960:80b9:b145%6]) with mapi id 15.20.3721.024; Wed, 6 Jan 2021
 10:40:52 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 3/3] drm/amdgpu:Limit the resolution for virtual_display
Thread-Topic: [PATCH 3/3] drm/amdgpu:Limit the resolution for virtual_display
Thread-Index: AQHW4z4GwhrQynjb806wl7ptVhaxTaoZSHuAgAEhW+A=
Date: Wed, 6 Jan 2021 10:40:51 +0000
Message-ID: <BY5PR12MB411509E4392319DED71623C28FD00@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210105083717.468585-1-Emily.Deng@amd.com>
 <20210105083717.468585-3-Emily.Deng@amd.com>
 <CADnq5_MdF6WUTyOWs1NEO_gZtQknwTsGECs-uXVsfLPU8HOhGw@mail.gmail.com>
In-Reply-To: <CADnq5_MdF6WUTyOWs1NEO_gZtQknwTsGECs-uXVsfLPU8HOhGw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=8f9b830e-44f2-4f43-bb65-d281a71b3b14;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-06T10:39:08Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [139.226.113.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 68913612-d39a-40c6-e86c-08d8b22f89f9
x-ms-traffictypediagnostic: BYAPR12MB2966:
x-microsoft-antispam-prvs: <BYAPR12MB29666424C18528DD284C1DE58FD00@BYAPR12MB2966.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2399;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Iu7v3SVIoSe5hNEklr/WhISZiGSaBN8799KdrSFOQt5lnG6JHuts0QZakqJl+LdmxYAZcgoTrfxABDcVeQeB/VpwkcBay9/h4UeEtETtr/Del/gUbR7dpjArHpYWgBTwE83Y86ciiqu7iWMXfhD+gu8HBZiYy+LLdpbs0HQAUMdT6TJkufTZTezld0JKOqppHX0laWwCxwYWkNghf8BATKJDJOy2OZlmTJoa7W5SA5iumOa7NxFamVYRIs4y23rQyvdYSW01uJ12Ff7t0NuzsLA87hgRhbNA8ECPt/gQ+09x1JAV60eOiqHf79YdZD9UWinAdSz//MK0YGeP1W3vLwQBQTiSB7Fm7B0hcu1uzvJ+z8yZryEvn5/Ndj9I1IyTlUJtMxKwvvwtjHsYQc7GNIDkBGndA9OG/KUWw4cTmTQUqeGSuuVV+FQQXOCdnE18UAj6C63iORw52Fvz9FyHqA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(64756008)(966005)(66446008)(66476007)(66556008)(26005)(478600001)(6916009)(186003)(45080400002)(8676002)(7696005)(86362001)(33656002)(66946007)(76116006)(9686003)(316002)(4326008)(52536014)(2906002)(55016002)(71200400001)(5660300002)(83380400001)(6506007)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YJrRysKfe7E4QDcnAAKVznYB+YYLioYmFAU7ZmKSe66Z59dvKjar3s0Otnno?=
 =?us-ascii?Q?2cwxMnQgVPTHF8ytxgOPbgCYre01Wb0fBb7OqaMfXwkrqUTMHQCCdNUufZQa?=
 =?us-ascii?Q?chpBL/iEQeiy1aSYu4CSCYUTTsNlXAqAvYbRdZSry2U3Tz8lmv+uo5e7xc7R?=
 =?us-ascii?Q?R0aAor9Ke71m2j6iFktfp1NzhUJBCnqPvNpesLPZRZoAJ+B73fDAwUQCW7M+?=
 =?us-ascii?Q?IhfoZPe9YcyvpDnPQj2oKG5kUW4o1blqy/xHWZ1644E4xAnPaJFQ0j+rJd1O?=
 =?us-ascii?Q?azuOtRGhjfmzi7AKw4Ig0SDpSBjalQhJT9JSGGj1SxvkDzkwlsRu2+2XcHeR?=
 =?us-ascii?Q?cLCUw8qeP+u/9FRv7LsU4D0YRtFJ8RewAKXy+XeLXa1lbPG1k8Ma+vOkRljm?=
 =?us-ascii?Q?WvtcVVAV0HKjHOQXl2rFwfidffzWbjfohHEYZYMKdNs27jPrvicWHy077mkx?=
 =?us-ascii?Q?V4DE3hdMVWvZNRI29zh4nzgr+2EeecHkfJ7x94lx7AeTkuVZLvUSB0R77ILd?=
 =?us-ascii?Q?7syOhigELdIdykQuB9pBr4RRwY6szgdOtTp9QcpFwhojXM/XsDoTbNfCP0ZY?=
 =?us-ascii?Q?qJCmD0TwegrswA/mHD14Vjq8oMLERqXy1VNQHimZjXf25rGByE7mmZTFT6JR?=
 =?us-ascii?Q?akXHE0oPMoMpMrJ0+kKS90fZO/Zkui3Rr6ChURzyberNipCFCWbVtdusSt4/?=
 =?us-ascii?Q?r2PTR2I69BHw8+6r1KivH8FhDhEnTx4zGaVaOnSrIOOH3aQROqDv89UggXKw?=
 =?us-ascii?Q?W8afA5M0356lSLSOJVTfhFvOLqDJowJrHYwwLtikpbwUHlt9ioBg5SkWsMhm?=
 =?us-ascii?Q?pCNZrqCrkk86UKdJOi/huEx71tmuKalp7BjE0t0IlQUGj3ZvuIFNixxnd16z?=
 =?us-ascii?Q?CV5/MbwusR2XDpF8ro5XR4qs0VQFTgH53WIl9C0wYWoNEvvRJNfhga8Nj3to?=
 =?us-ascii?Q?iqlf+b6YS9zaEdMpwjLmyjdL6rgFaqIJSyi/wxBI3oY=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68913612-d39a-40c6-e86c-08d8b22f89f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2021 10:40:51.9873 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D0xWyl5iTbEswWZRXzByJ2EvwGgfdSnZLTkH/UTCCqfqd13/0GPowuPhiQ4vDCTl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2966
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

>-----Original Message-----
>From: Alex Deucher <alexdeucher@gmail.com>
>Sent: Wednesday, January 6, 2021 1:23 AM
>To: Deng, Emily <Emily.Deng@amd.com>
>Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
>Subject: Re: [PATCH 3/3] drm/amdgpu:Limit the resolution for virtual_display
>
>On Tue, Jan 5, 2021 at 3:37 AM Emily.Deng <Emily.Deng@amd.com> wrote:
>>
>> Limit the resolution not bigger than 16384, which means
>> dev->mode_info.num_crtc * common_modes[i].w not bigger than 16384.
>>
>> Signed-off-by: Emily.Deng <Emily.Deng@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/dce_virtual.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>> b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>> index 2b16c8faca34..c23d37b02fd7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
>> @@ -319,6 +319,7 @@ dce_virtual_encoder(struct drm_connector
>> *connector)  static int dce_virtual_get_modes(struct drm_connector
>> *connector)  {
>>         struct drm_device *dev = connector->dev;
>> +       struct amdgpu_device *adev = dev->dev_private;
>>         struct drm_display_mode *mode = NULL;
>>         unsigned i;
>>         static const struct mode_size { @@ -350,8 +351,10 @@ static
>> int dce_virtual_get_modes(struct drm_connector *connector)
>>         };
>>
>>         for (i = 0; i < ARRAY_SIZE(common_modes); i++) {
>> -               mode = drm_cvt_mode(dev, common_modes[i].w,
>common_modes[i].h, 60, false, false, false);
>> -               drm_mode_probed_add(connector, mode);
>> +               if (adev->mode_info.num_crtc <= 4 ||
>> + common_modes[i].w <= 2560) {
>
>You are also limiting the number of crtcs here.  Intended?  Won't this break 5
>or 6 crtc configs?
>
>Alex
Yes, it is intended,  for num_crtc bigger then 4, don't support resolution bigger then 2560, because of the max supported width is 16384 for xcb protocol.
>
>> +                       mode = drm_cvt_mode(dev, common_modes[i].w,
>common_modes[i].h, 60, false, false, false);
>> +                       drm_mode_probed_add(connector, mode);
>> +               }
>>         }
>>
>>         return 0;
>> --
>> 2.25.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
>> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-
>gfx&amp;data=04%7C01%7CEm
>>
>ily.Deng%40amd.com%7Ce17ab0515ecf483eff6a08d8b19ea565%7C3dd8961f
>e4884e
>>
>608e11a82d994e183d%7C0%7C0%7C637454642229402978%7CUnknown%7
>CTWFpbGZsb3
>>
>d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
>3D%7
>>
>C1000&amp;sdata=YEVtCVJZ8JSe3kjyAGmjltHN1O4i4yvjvXjDZhWhZSY%3D&a
>mp;res
>> erved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

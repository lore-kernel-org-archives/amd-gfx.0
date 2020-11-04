Return-Path: <SRS0=wluJ=EK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C33C2D0A3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 01:39:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A6A223C7
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 01:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Z9KikKW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A6A223C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB7FE6E928;
	Wed,  4 Nov 2020 01:39:04 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760042.outbound.protection.outlook.com [40.107.76.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81C516E928
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2020 01:39:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BErhrsxzkNoFOHJRSRjEzJK2kZk482HA6rbiMlClZqwLFttl699C88BEy3pHeODj8avHeiNSrWzGOhuVorftyNdeUb6241Rl7524rJCF2Dmuxtv7oCOO3pDPGuzXCB1wQ4+wCHQqgpVAJA/GV6/50NydT9APSvwZVKvvwrbz0Zu0LE2uj35uqwvxqvGx/h9dOibRmu4iNMoZqXQHPX9njq34jAm0y4P3NEyKJWnn3VfKLmFYxMLihb5rti0b6g3ncMBEAHPyIzr/WJ9/Dh9GlBfP6MErgpEp007N2xHc5NztiWsjeHH2JePZu/vBr8OSNH0Z4qLVYiYacAtJ0dAx9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=II5fr8W4vI1faqX1Y3IPD5+sNybvb+7bddVXKBPSLZQ=;
 b=dDWLZEwuDSPLBsnnXJtRGVMoJ+GBOG1tYoFfB6rpklGKl7NLlgZ+UEGtIRV67DflQ96f+UtL8ySoG3+4dW1CNiTErpODR0QUZhr9edAFz7R39m1WfO9GCgqfKGWl1zzRsRmv1ITy5qZSpzN5pk5I9TKgmjDDh5HjOCJSD7F11e5WMsflnHpaYVNDIAuff08zj2Gb16DoCJ4fOizIPIY9yj4Tv32pT5+PXdUZwUNHCsO38fveeQp1CL2Y/Ve6HeIRdNV3u/wtL+EXx7HtFlBfdD0O7W0RPawUUOp/AWK00Q7ov3mAVIx4vzamAOU3iJt+8cReqbmPntjtWPimryXlcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=II5fr8W4vI1faqX1Y3IPD5+sNybvb+7bddVXKBPSLZQ=;
 b=Z9KikKW3oT/DmKlR/bzQiMxuu1iH2XDnouhp4DILiiTwkkbbl3SZ/cgh2ul/hN4i3oKqNFiSCIMkhTHD921+lMSt+6Ta4UPlav83Qo8BTspLmGOB29sQb8GBnyQn1cWe8se/i+CXVwmfNo5/VAayYcm5ZtNTKylAi9OjcqdmdU8=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1866.namprd12.prod.outlook.com (2603:10b6:3:10c::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.27; Wed, 4 Nov 2020 01:38:59 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5a6:dfb2:fdfd:2d91%6]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 01:38:59 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu/swsmu: remove duplicate call to
 smu_set_default_dpm_table
Thread-Topic: [PATCH] drm/amdgpu/swsmu: remove duplicate call to
 smu_set_default_dpm_table
Thread-Index: AQHWsjiHk6UPofFMn0yXUFKJG36Qwqm3KcjAgAAC3ICAAAVFEA==
Date: Wed, 4 Nov 2020 01:38:58 +0000
Message-ID: <DM6PR12MB2619FB0F0DC887039BE0D22FE4EF0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201103232434.832933-1-alexander.deucher@amd.com>
 <DM6PR12MB261967F844E1050529EFAC71E4EF0@DM6PR12MB2619.namprd12.prod.outlook.com>
 <CADnq5_N3TiUfKNjhhg0uctgS9Bw7o81GSPgx9=pCh2DCREfiKw@mail.gmail.com>
In-Reply-To: <CADnq5_N3TiUfKNjhhg0uctgS9Bw7o81GSPgx9=pCh2DCREfiKw@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=aa9bb6eb-45be-433f-993f-c941f7501715;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-04T01:38:21Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 96a9693e-1bf4-4433-d912-08d8806266a9
x-ms-traffictypediagnostic: DM5PR12MB1866:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB18660F8EC1574DFFCC620F6BE4EF0@DM5PR12MB1866.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n2nxEAIjlwX4PR7mGqR+AM2gIssyWLPiw6b5kLz3gLrk0+3kIWxWmTvCkSiZy21UW2BK6ny5qBoWRUJgytN8O3WaByV0capeKnzZ/FD5XgRYV+Fix/Lu5GBhqxxJeBpku5boXSft1XF/qAzO5Sz9rEkOi5/WM46Kx+4Tv1JYGLSGg6nxZL9zceEsWWiFl/z2yIbPofOgr4P4fczczPJOo+FIoxezokgWMTLGzGbIG0wdJJ4gB/DNdAjqypPWGCUgllkOc8Ts6uKk1VfKBWXtU0EOwdFVU5SmEg+0zAcqHhC9Zo7OpIqi0e1F4889fN08Ovy7ZgleaSiPiHjg62zidw/AjFZviku5CR5GGl5mKm0J6AmJ36C+I4IwFwFCCqsIRNuKDbOzQmpiukGP7/uvkw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(366004)(396003)(376002)(6916009)(2906002)(33656002)(7696005)(66476007)(66556008)(64756008)(66446008)(54906003)(966005)(478600001)(9686003)(8936002)(5660300002)(66946007)(76116006)(55016002)(45080400002)(6506007)(53546011)(316002)(86362001)(83380400001)(8676002)(52536014)(4326008)(71200400001)(186003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: fWMlVuM1maQ9CLnfEMogaM7VQD6gsv+PobQdWsSBWMa3TNOP+uen4KC9yDVQIA+GUaV3dgVkzYfoPSYsnu2lTHaNjGeeRJup8stxeibKMqRRIFt2ox82y+63djXFq4P/jsC6+z2xVbyxdNgNRkJwmTBJFWjXOV5j2y9ppj/G8aJbAQVWOb/CMs6xm49N0mkE9YNjm7+bZIWqfjvrDFRALFex5sh+oPIeFlzaZeMicZCms5zoNoSq4+A3gs1r+8JgopDQvATwC8duiefmsWGFcacsOTFvg8gO1HuzIIShPfsBFkVfLgvoT7iBDtvYtS10b99uNhSiOFi0qiSdrzZ4QRbVnAFHNyYCaa7CUIXTlutQ6uZrg/WtMCP+snmGvvAUm7G1GM5MlRlZXVpTR+c+l7VOaNge9x6tblyemmKrOUC+jF3nDHr3wwZ2azGFtXx0YnzbZcCo1+707+DHNHbJCRG7XTT8xosxsvG83PO5+zTSXwSlwgAl2qA33TiAFxkHfVoQDifw3tJI5ZN9SV5y6alTDzWZvM33t61qaSWyxq6gaOxu5M7ID4CXkTa34uQu9b47ZQauWIq6kaIOMjIxKDZGXNaFB95cZwaZSopo8WOmnjdE4Rz8acHWu+0HVm+S+9qgTIpm9PEacmFW89DntQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a9693e-1bf4-4433-d912-08d8806266a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 01:38:58.9683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EEuhxl4KvErLGaYEMwTaeRfe9Fz9Hlg7Fn1TNlGcnRgKvIRwcexjYoGKbILrwYyG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1866
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

OK. That will be fine then.
Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Wednesday, November 4, 2020 9:19 AM
To: Quan, Evan <Evan.Quan@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu/swsmu: remove duplicate call to smu_set_default_dpm_table

On Tue, Nov 3, 2020 at 8:12 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Alex,
>
> Where is the other place the smu_set_default_dpm_table get called? smu_late_init()?
> If yes, you probably need to leave the one from smu_smc_hw_setup but drop another one from smu_late_init().

Right above it.  See:
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Ftree%2Fdrivers%2Fgpu%2Fdrm%2Famd%2Fpm%2Fswsmu%2Famdgpu_smu.c%23n1020&amp;data=04%7C01%7CEvan.Quan%40amd.com%7Ca8968603f87a43bef29308d8805fb530%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637400495838063628%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=d2byGlfRMd3%2FTkuwbCmr4QxEL1CIVxYTIg5OI9Utk8A%3D&amp;reserved=0

Alex


>
> BR
> Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Alex Deucher
> Sent: Wednesday, November 4, 2020 7:25 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/swsmu: remove duplicate call to
> smu_set_default_dpm_table
>
> For kernel 5.10, this function was called twice due to what looks like a mis-merge.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index fc4f95fa87cf..b1e5ec01527b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -1029,17 +1029,6 @@ static int smu_smc_hw_setup(struct smu_context
> *smu)  return ret;  }
>
> -/*
> - * Set initialized values (get from vbios) to dpm tables context such
> as
> - * gfxclk, memclk, dcefclk, and etc. And enable the DPM feature for
> each
> - * type of clks.
> - */
> -ret = smu_set_default_dpm_table(smu); -if (ret) { -dev_err(adev->dev,
> "Failed to setup default dpm clock tables!\n"); -return ret; -}
> -
>  ret = smu_notify_display_change(smu);  if (ret)  return ret;
> --
> 2.25.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CEv
> an.Quan%40amd.com%7Ca8968603f87a43bef29308d8805fb530%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637400495838063628%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 1000&amp;sdata=CV4QagcDUCDKFiwx3YG%2F8Wt9nR2MRSrIXhBTZZ0FwsY%3D&amp;re
> served=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

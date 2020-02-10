Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB21DC2BA83
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 02:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 674EA2086A
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 02:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LxyYhycE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674EA2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D79B06E89B;
	Mon, 10 Feb 2020 02:58:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A22766E89B
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2020 02:58:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+LNVQuQ05sUkwogxW316KeOaZwabtxiLGX2y8aM+hb3+azid+i5jUUbSq1zTp0Qh+H7R+c2ErbE7HaNEe9jdwwBm2q8A2CNB6dQS6xl+p+euepJwZG5B0X71FOB6LYMBk6TTDMmmGYui8qA/7vsIrwzap8Wh+hXMXJY5mAiRhFoOCz9UX2NvOPuv1+2T/A9VMgVKCbQ+EUWnVndSzjBHo2Es0RicWIxt9sjEC2MAAOpMGlQUmhClDPTWFKfi/OihxkRcQMxPQVkEAHQA53dFkSphTPYxR0+T7bCeHKYha9PXAOFS9dzQuILHOvEz0Y/btf73SI9sebYLw1a4STl4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AODv7TPCBDxZxE22eAxIbViWYeqgxR7ABUmJOKrZdE=;
 b=X1xyLO6QEr4RGXDTjXiVCRqOeT8IPbFVSSfTDlqZLXXvp09TH36eLVInZEBp5uYdnvHVh79pwJ1qC3tWO1AY0Rc7kvfwZlM4IknfFkEZMORpTKOA5D2DK/2+s4Jo+j010oZF6us8SIivbBq3QtHBANe04QvDPdoTEIsTGs9EQudaCCB+smTlVrhjrkWPYFZ2pKxPoNaM4KgZqX6iafI9qLYyxziT1OvpoOrHGC8HmSMWB6zkyax0ICGrtmPZWRnoAVbmiIsFwXTUepS9Uz7TKOiahHnjnT/pWZG/JUOBA+T4QykBljNyj6HvL58ceLZm4SoXFg/9ngFGnPqwzP3rrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AODv7TPCBDxZxE22eAxIbViWYeqgxR7ABUmJOKrZdE=;
 b=LxyYhycE4n7upM7VPDlWPNopkGgbDvsnSKtVsP04mfqrugcn1q6LlHbCgzvcg/zrPNFhxEi/23GwAJVOOZLAEUKhdUvDzryz8vTMT4x3UhgrtI4PtK+S2gfWFgC/T5/1ygGLooUrQpqkQTq7P0Hd7DBmrNJ2gbIaajz+thy/mK4=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3278.namprd12.prod.outlook.com (20.179.81.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Mon, 10 Feb 2020 02:58:05 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2707.028; Mon, 10 Feb 2020
 02:58:05 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/3] drm/amdgpu/powerplay: fix baco check for vega20
Thread-Topic: [PATCH 3/3] drm/amdgpu/powerplay: fix baco check for vega20
Thread-Index: AQHV3coA8KakU9c/t0O5imISDu565agTv8rQ
Date: Mon, 10 Feb 2020 02:58:05 +0000
Message-ID: <MN2PR12MB33448BB2544ED4588C10DF75E4190@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200207151842.802638-1-alexander.deucher@amd.com>
 <20200207151842.802638-3-alexander.deucher@amd.com>
In-Reply-To: <20200207151842.802638-3-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4873ab44-f567-408c-8888-08d7add50d04
x-ms-traffictypediagnostic: MN2PR12MB3278:|MN2PR12MB3278:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3278B7C56278C610F310C1DFE4190@MN2PR12MB3278.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03094A4065
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(189003)(199004)(5660300002)(110136005)(52536014)(45080400002)(66446008)(2906002)(26005)(64756008)(7696005)(478600001)(66556008)(66476007)(966005)(66946007)(76116006)(8676002)(316002)(8936002)(81166006)(81156014)(186003)(9686003)(6506007)(86362001)(33656002)(4326008)(53546011)(71200400001)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3278;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LJl0nzgKzQDKsyBZs6vA3hpqj5vBIGBm0oOUHqMQ5pnHKnqY1RC00f5D4SqSLqqJpp9p+xYMOCnAqlASi5GkUdQHUx9r8yYxnq233Jn9qeIjemZHTKTvtrP+NB5UkXW4xh9/E+yqnnctIIbPrxcWyvU6uWquWNPTf7GU2nUKHR8PMhlobBtKW9P615jyo6g8G3z/QIl1Ug4S7cHawxrCF6RtfbtAzjSqtb0F4SPh3v4XXdswRojh7EC1Y3MeMqUggoUOJHrrE4W2qnOil+E+P0gE9e5xz2eiM6Lb/W3iUzlU/86dWAu5o1JTIG5MhyVMDd8mmNUfM3j4d8RaF/I1uCJK8mXboAfBCGijbwne7k2F1aUDtJxNdE91O/HxZJq5Jmw8dMR7eO9uIb5A0xqKzTBpze/nAx9ziNWfovH2TO2b75b+J37urywIMt8474NOG7ovN6KkIq9fEEooGMCm0HlyUyHWGiEGwJ1r/YVBZV9VecoCx619YDW0hTpGhQyaptnRn33ENrZihkVsI0CU0F587epEKr/KjWaUqRnX832Bs8Mbtm6tHsArIgYp2C6QAgGIO/Pc/ZJjEpPDa3LDibqFJ0RiJEURNy91Ma+JOfW2Cf2h8MUUhp0GW1RsXIO9
x-ms-exchange-antispam-messagedata: cQvyuNoDCIaGZZOoPq11Rou6QiL1rUB+A8bB0pyNR/drMiwInLS6COBJH+Necimzb1MBME+54FN3UG/tK++Ra9FqAyDe6D/JT20XRt0ozd/dFn6TpHj2vrTxwcJ4t1eIRne3WOeHCQiOPlJDk/UIqQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4873ab44-f567-408c-8888-08d7add50d04
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2020 02:58:05.2555 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CnFH5aNAmbtgkuwsAkyQ+4UeMYjNMn1/FgwcT9LGDshTfmNs95/TGz2EMWYPO7UO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3278
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks for the fixes. The series is reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Friday, February 7, 2020 11:19 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu/powerplay: fix baco check for vega20
> 
> We need to handle the runpm case as well as GPU reset.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> index 3b3ec5666051..08b6ba39a6d7 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c
> @@ -487,15 +487,16 @@ static int vega20_setup_asic_task(struct pp_hwmgr
> *hwmgr)  {
>  	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr-
> >adev);
>  	int ret = 0;
> +	bool use_baco = (adev->in_gpu_reset &&
> +			 (amdgpu_asic_reset_method(adev) ==
> AMD_RESET_METHOD_BACO)) ||
> +		(adev->in_runpm && amdgpu_asic_supports_baco(adev));
> 
>  	ret = vega20_init_sclk_threshold(hwmgr);
>  	PP_ASSERT_WITH_CODE(!ret,
>  			"Failed to init sclk threshold!",
>  			return ret);
> 
> -	if (adev->in_gpu_reset &&
> -	    (amdgpu_asic_reset_method(adev) ==
> AMD_RESET_METHOD_BACO)) {
> -
> +	if (use_baco) {
>  		ret = vega20_baco_apply_vdci_flush_workaround(hwmgr);
>  		if (ret)
>  			pr_err("Failed to apply vega20 baco workaround!\n");
> --
> 2.24.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C781e5f8feb044301f
> 50408d7abe11d18%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6
> 37166855729019493&amp;sdata=L8aUO%2F8ut25Yf7zVSfMDE207bcyYnYi2hd
> 7ANXL6vEk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

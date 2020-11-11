Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9789C388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 03:19:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E591205ED
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 03:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Z40plFil"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E591205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C93A76E039;
	Wed, 11 Nov 2020 03:19:18 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760041.outbound.protection.outlook.com [40.107.76.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 815AF6E039
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 03:19:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZCosp0xI0fPpuFcRGYs3SmcTIzp26ZRhSPD+rryOXADCCcVV2yHFFl35FmRpKGzA/gxdpqHQ53X+CIBaVjHPo7yZnX6bz2h1EQBw7pCOdpezx69nb9vnW1nQKYZHrDZiZR1/TexL14eRadenMzZJNLHAzD6FbDVKj4VybYjIa4leVSN4Nsp7isiS0NEPOxrBG6S3cWfuwsdzbkjuFcSc27iXvDIC6CYuRHQuKYT/XxhtFWczBGD3kx96DBYPba1uWoTBBQ5/r2u9qNGKW2JsJ+ITox8VEtbtJyYFxlqdEY74Aq5SjESxRAh57WNgeI9IG2Wty8TZ3CpTDO/Wj2FDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aOreZ3mLI+3gwSkbQmDiQ0JMhLjp7NCPkn3EjOKwtY=;
 b=DuIMQooRxbEMxYnFJKZoPOejKBeEufiz8VCU4+sg2pp1gm5oOGAT9IP7YIxx8z+3b+RBeuNXCisih6fmL0G+CELJtbRvshkSMMZK3kvnBCb9WN4+dPPmiHApJwf7R2VcdxjUOcVCBnFSBRnXBT/Su5S9WWBkxj6q1eoqDzTO6HlA3LbLzl6x697Nqh7/L0JB7fQFUhwi2nMnQv5lvobal+rDPALLGJBZ/3iiQafohebkB9sdm/PkvK3gxqgE2j2ipD6CwMwlID8D17l29gOQH87VoWobzbiBPiKO2KdjrYmWmDfHPb7B2ZAxVu/hA5VOwDuk3ggmHLtCV3R08v05QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aOreZ3mLI+3gwSkbQmDiQ0JMhLjp7NCPkn3EjOKwtY=;
 b=Z40plFil6dbpbN1oO82AWnrW3uXz25HQhH5py2R2vBmVV2HwFyPs6W9uxVjoE3d3K4b5OyFcNI70uyaMPCTCjjSF79AXfqUEvq85HH9OFmPBVR8Xs/OZv5S1gRAA/tn3N7qAYLPe5yYZDHMDnb4ztynR657KWj+FJeayA/HCeeg=
Received: from MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32)
 by MN2PR12MB4269.namprd12.prod.outlook.com (2603:10b6:208:1d4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 03:19:15 +0000
Received: from MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::c535:c5bd:8c12:6b63]) by MN2PR12MB4032.namprd12.prod.outlook.com
 ([fe80::c535:c5bd:8c12:6b63%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 03:19:15 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] drm/amdgpu: disable rom clock gating support for APUs
Thread-Topic: [PATCH 5/5] drm/amdgpu: disable rom clock gating support for APUs
Thread-Index: AQHWtnDEand6HDcnl0CR83FdMZoKEKnCRcAw
Date: Wed, 11 Nov 2020 03:19:15 +0000
Message-ID: <MN2PR12MB40329CBED3435C3C8869C418FBE80@MN2PR12MB4032.namprd12.prod.outlook.com>
References: <20201109081652.1964-1-Hawking.Zhang@amd.com>
 <20201109081652.1964-5-Hawking.Zhang@amd.com>
In-Reply-To: <20201109081652.1964-5-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-11T03:19:07Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=fffca12a-fcdb-4e03-b6b7-00003f6b0961;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-11T03:19:07Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: ef9d1a73-457c-490d-8669-000088976c52
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4fe09d1e-4e52-4229-93c0-08d885f09199
x-ms-traffictypediagnostic: MN2PR12MB4269:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4269F62AD0F5F23E2CD71A23FBE80@MN2PR12MB4269.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NiHAA6ju5B3kQwjNTRf5bNuGpqGPpGsZbYjBk1CBFd0A/Hib8bkmbtmuPdsTx8qF2tci02chuV23pjz4HUt229sajJFHdeNbxrtmIdiZyt6z98oMJeNvtGHi0WfuSRoizpEvzNIKLQikysQcN58WQB0CTig9fFIjRRfoSRGJA4Wm5TRXyFhC64YHhKPe3r8kxgP1oEH6qfWsjXTREMZ22oh48Do/Tus6y9y5EaI1IOvLWNdHzKmHQk963iC6wQ+DykhJw/+6jEqkLcH9/zd39U8NryyfJS8TzRMjVuXRledHXk0xL84r/7HIg8MaGkkA9wKC3AgX2Ycv4bXjhHvBUcSHYjw5oMcn/f30y8BcnBc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(316002)(71200400001)(7696005)(478600001)(6506007)(53546011)(8936002)(83380400001)(110136005)(86362001)(8676002)(5660300002)(33656002)(52536014)(26005)(186003)(55016002)(966005)(76116006)(66946007)(66556008)(66476007)(64756008)(2906002)(45080400002)(66446008)(4326008)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: wcZ6QFHMsy9+ufyRERFKiJRtdptUTbenQgu+sawUePPaV+mqGltJYCt7zL9Bwt8rzPnJT/KERB9riV8+oAj/CBtwRjH9XHmdlXl6Rh7DqcVkFdU16IwXXmg2t4vj44hAASCxbiXzFHl8qTSPvBSUhR60iqzFQunrpsE3JmfGO11R4R+TlMJ3CbU77OgWG1TypyKtRbYWKL8l+X8xwDgBCeGeySlxPFD1Lph1aTDiwhx2gBdB9mXwiWhSAmxegxxVS6HuoT4bQ4YNDOVP1umTulHUiMlkPnvmEwYkgsLZhBDoFX1M9c1/Yb6HDUlNbidDAV/LyoTtajz341xKtgr/h2CjmlHBDsUlCzIi8hd111RYuRi/NRCqYauInLi158TjZYvSwW4Fsvpg7VzYOAmb6KTm1t5i5d2I1waxPKojMzmh3PPWafP5fXNZ27i6Y19yRwSBoyY+gSsFZV6xchRXRFViKHj7kXEjw8X9vxSRBDx9r2YL9i18Rr+PuPBH9TgwZT+WPjN6KoUTbjbHMLCfsPrAni+00vFek+hY4NJminOPh777hf/TsWSm/pyhNUSeEbMwuQlQGqeq3v424BmDHH1Cln3sybDzYnohx++uPzQ5ZITf/VxWsE+KMt1qXZ8FogXKjauXHv2wd6OLlSl8jA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4032.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe09d1e-4e52-4229-93c0-08d885f09199
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 03:19:15.3861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dB+evg+ylKfSjz9l7WO7vMHduFee72E5NK/lkHZ9CRB61XzNkO+YLFPvza/tkk2FXTnGM4p7SBIxlurFXIIIhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4269
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: John Clements <john.clements@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hawking Zhang
Sent: Monday, November 9, 2020 4:17 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: disable rom clock gating support for APUs

ROM clock gating enable/disable is not supported on APU platform. (i.e. CGTT_ROM_CLK_CTRL0 register is not availabe on APU). SMUIO callbacks will check APU flag before enable/disable rom clock gating, and skip the programming. Accordingly, query clock gating status through CGTT_ROM_CLK_CTRL0 also doesn't support on APU platform.

The change applies to RAVEN/RAVEN2/PICASSO/RENOIR.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 7d3788c..8a23636 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1169,7 +1169,6 @@ static int soc15_common_early_init(void *handle)
 				AMD_CG_SUPPORT_GFX_CGLS |
 				AMD_CG_SUPPORT_BIF_LS |
 				AMD_CG_SUPPORT_HDP_LS |
-				AMD_CG_SUPPORT_ROM_MGCG |
 				AMD_CG_SUPPORT_MC_MGCG |
 				AMD_CG_SUPPORT_MC_LS |
 				AMD_CG_SUPPORT_SDMA_MGCG |
@@ -1187,7 +1186,6 @@ static int soc15_common_early_init(void *handle)
 				AMD_CG_SUPPORT_GFX_CGLS |
 				AMD_CG_SUPPORT_BIF_LS |
 				AMD_CG_SUPPORT_HDP_LS |
-				AMD_CG_SUPPORT_ROM_MGCG |
 				AMD_CG_SUPPORT_MC_MGCG |
 				AMD_CG_SUPPORT_MC_LS |
 				AMD_CG_SUPPORT_SDMA_MGCG |
@@ -1211,7 +1209,6 @@ static int soc15_common_early_init(void *handle)
 				AMD_CG_SUPPORT_HDP_LS |
 				AMD_CG_SUPPORT_DRM_MGCG |
 				AMD_CG_SUPPORT_DRM_LS |
-				AMD_CG_SUPPORT_ROM_MGCG |
 				AMD_CG_SUPPORT_MC_MGCG |
 				AMD_CG_SUPPORT_MC_LS |
 				AMD_CG_SUPPORT_SDMA_MGCG |
@@ -1264,7 +1261,6 @@ static int soc15_common_early_init(void *handle)
 				 AMD_CG_SUPPORT_SDMA_LS |
 				 AMD_CG_SUPPORT_BIF_LS |
 				 AMD_CG_SUPPORT_HDP_LS |
-				 AMD_CG_SUPPORT_ROM_MGCG |
 				 AMD_CG_SUPPORT_VCN_MGCG |
 				 AMD_CG_SUPPORT_JPEG_MGCG |
 				 AMD_CG_SUPPORT_IH_CG |
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cjohn.clements%40amd.com%7C5304c5c8408143f3733e08d88487e5ca%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637405066507439386%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ZGqNyyHZ3Fy%2Fe3SpP9nbSCaR%2FXHAnQIaVv414Tdg1iM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

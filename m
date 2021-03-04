Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD9BC433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 12:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C576464F27
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 12:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C576464F27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43D526E4A6;
	Thu,  4 Mar 2021 12:02:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA6FA6E4A6
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 12:02:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDX/fld1mUJgcY6n82bNerzA/7c4oJgrTKro1VPRfxvid1Vn3Qqf2EmQnYTMDC2fv3ADipCHXftibjDiNO48rYVWTEobVL8+QqZjlKmMBLLrtYyfR4XKrr1ud8Ybf8twOFBVHy8Vg0VHE6jFvQTvp/BAyBrn0hy18fwjE+vSBDJTYUdYjCyhn7XQc1SSQxVFQ60+vs6aue7NdJCYvyvK+s7y8Oir9RTJcUbVtrH6g+ccrInXMF1mCj1uzpvJTWRQMbEcfwodwXoh+6jZMtsr1TdeRn8BBdgXLBrXo8x2hMa/U2G+03xHg3Fin3HO0/NIvw3fusxBEhaHj9pFEyDv7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ys0Yvh6Twm+odHr1nKiAn1HwwzufiZ1pBr1IGg3LEvw=;
 b=gXMZ/3WGOzDA1XV3j6K15+hBp0y/aEGv2iIaleByVjHHNWzthlXyK74002BNk8tH7p75rId7xdIxFvFkVgq3wFINrI6p8TcLo/KA7aQNdCRaLbX8Vz4BMnRSa7dGOz9Pn/kQB05u4hbBbcWVEx27fItFWfYea2HgDA8VEZjV5ZkaZrXoCnkYi4IaorrL+QgHtQAvW3ua/y6Q7IxChvdaLac3w+DwPjtt75gBnEgWf140pBX3FMiGNA/xga1bK5pDXdxFywkYza8Ku6kC0DTFcYx8ZSMhXbF9a739KUQ+/yJzv9dOR3ICtsXpUCcwDFFD9dEyPORQ6qHEGt7TqryiNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ys0Yvh6Twm+odHr1nKiAn1HwwzufiZ1pBr1IGg3LEvw=;
 b=noJ9vDFXGMLeKvtobQSuB2pAeqQ5Vk3fMU1MVp55mMsNOhqzgjpApBP31fe6jmCp0jPscwYQ1PJTBVL0e/uoXif2OLg+JqrxMbIgIEoUvb1LxtGXZcDm/faWrj4ZF2PUkGS5+QpERs/uVqB0It4YV4Vfwc7sW3CDRn/0zL6b8Hs=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 12:02:47 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%4]) with mapi id 15.20.3890.029; Thu, 4 Mar 2021
 12:02:47 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.
Thread-Topic: [PATCH] drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.
Thread-Index: AQHXEMJ01ChAFPHK80mvMX6SjGVGO6pzurhg
Date: Thu, 4 Mar 2021 12:02:46 +0000
Message-ID: <MN2PR12MB45493154B8DFB577690E9D6B97979@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210304064850.40488-1-Feifei.Xu@amd.com>
In-Reply-To: <20210304064850.40488-1-Feifei.Xu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-04T12:02:44Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=0f09a96b-6c33-47a2-8c49-66b9e2f23a5d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.217.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c7314687-cbaf-4c6c-b83e-08d8df056d14
x-ms-traffictypediagnostic: MN2PR12MB4255:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB425526755987C1A483E1C77397979@MN2PR12MB4255.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XP4PnTf4DSpv/Y4pCnj+8khUPZVILFtdrHHzMePPBEiXtxen8pn+TjxJwc7HDbR6E9qmiY8kmhOE741w1aFjP5gnV+huawXyuW89RYzfdAr9YfGaqFgXriWxWZvEiXpRKmxvqHpqmi5DHiGfP/fSO7XlmqTlcCWffNzFzirhXNVuMcdqyaklbPrqxcZ+A6tKZb0sXtxciBt1CH57bGsxSEO5+NpoE3JRpTu2YXaHWbO02iisCgHnln6dM0iOKHJ0Fmftp7LBHtU0GMWrNnXuXWy35p3BJw80l9K4r/JGxx6BbWn/3touGmsyhY7qmg4ltnD167QW7drjA0EdRYryknwyM/AiDnSM11MmkgXFlgOAuZpWgyD29PMNwD/11J0+aKzEKSi2Z2W0f5V6r/PsvCzy8wvejAsutnMjrAqRipzX7BkibwBx8xVHt2EcqMxKEbDV0jj3kUKXf1Qv5ClWzwSWS9D6Fa8RuFX/GfI6q5xRDlevEZXBMroJ9cYiQzTnoAKatgg9hW/pRIzCo3TH3A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(26005)(54906003)(33656002)(110136005)(83380400001)(8936002)(186003)(55016002)(52536014)(53546011)(2906002)(7696005)(9686003)(86362001)(5660300002)(8676002)(66446008)(6506007)(76116006)(66556008)(55236004)(64756008)(66946007)(4326008)(316002)(478600001)(71200400001)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jCuAhiCBb3qDITGDagyOGDnJVOMmYnAFftWIntgxgG6beW2lQ7ExU4tt2cpY?=
 =?us-ascii?Q?pmkXMmaY/neWocHC5mpRhUXODP1t9gHSO1OrHePacEG9YSP7n+q4p4E0NZOQ?=
 =?us-ascii?Q?kJcgL+7PGGNlHsZUtBDAly4QXy7QJpgsmThnDOi9fTcD1zYJVGPKSwUty7sW?=
 =?us-ascii?Q?zAZJ3RXTscHcSe6SrUMcbbiVL/94CuxuiGD9fqSMqkOZPEbjA/luY2GqBqXn?=
 =?us-ascii?Q?myGPgva3cyx4/NfLvgrQ5LCD9Azg90JMOiR7N5efiwK+QzjwG9s+2lvydgvm?=
 =?us-ascii?Q?xwXRwFpgSkIrrDz8Xvw/DP9ka3Dvu+t8dymrr2I5iuBcTE5iV9vugE4HCnpG?=
 =?us-ascii?Q?2+YM0upCNWCNPwfZpquieqYp8yz3mTQoe6RzbQSQMZiR/m+mryB1VMe8gime?=
 =?us-ascii?Q?mSjvxi0fAUYhtkOW5PHNTwJJ0IkRdRX9r8GW21fx3sNF/YQabnMkfycB+A9k?=
 =?us-ascii?Q?KBW1JaN65RtVrVCLLgcuUtXf0nO8tiK4EdISUcb3qvX7ioqsKYnIgag2KYW+?=
 =?us-ascii?Q?GMEnc87lWswMkCJfNsQ2AUMSWNw3K07F8Y4RZy/db8/hjHDtl7yd12BZklKN?=
 =?us-ascii?Q?r+xc9/M7B1U/YBLTILG6fOnqEQQsuSFMbN+TnOVXrgM4c534q/6N1VxskjDM?=
 =?us-ascii?Q?3JuppoW20ti0qjQvgk3N2/xyD0qoAhM1oP9x477eIkiOwzVXjA1LxUoLItQF?=
 =?us-ascii?Q?s/UTVfoB3Db70d2YqHPc+4PbRTJsyffWAiiYuvf7dIWSrU6uLX64uS2NZWBI?=
 =?us-ascii?Q?joaxIXHPmkOtMi/oXh9sU+mUo3fZp/rfYEBhZzUEEPbOc/QQ17owu5by+goS?=
 =?us-ascii?Q?pkVdY/GeDRrClDeWX+DNITiuSSD/jIVVyYAT2Kb2utTvZoq/la4FR8AbiGoi?=
 =?us-ascii?Q?oNeMM52BBVmleLTZYiG1JZJJPIDW2Bju2/Afa2Cj28nWbyjJjYOEuP+cyBb0?=
 =?us-ascii?Q?Ld9SwGJ8Iv4OQnMQBKAJ171bIBF+LbtCK+6aujnt6xb4OCsyVCnLEfKcTTN+?=
 =?us-ascii?Q?Ft0rI6P81hXhiXtV+VsBrmUm9xZHwEL/o1UfAlsu4k1dBFWKKb0ztGG1uwBa?=
 =?us-ascii?Q?sRgezSIEtF8gABHFVeiU4JVXhGSBO2fSW/oBtrw28pD+p3uIPXFzSMDYrOAQ?=
 =?us-ascii?Q?PbafKPeXaE5YEzqxVHE0UXOxk2fJn+ZsCG/KfOTeJJ2dOe6DuKZoNwa4sou3?=
 =?us-ascii?Q?pbFR85l0oCl4d1XnvtSK2U4BWmSbOThFWAr4XFt86geZVXMWjc6hYtHIYyNq?=
 =?us-ascii?Q?BupTM2XrnssAYlruu6xT6PCrTNOgqld9LT4H1n47yLkhO+NK4wuBZ3XOiKxp?=
 =?us-ascii?Q?Eljo8fM7lyXCUVKlZyUQtFy+?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7314687-cbaf-4c6c-b83e-08d8df056d14
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 12:02:46.9705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZpCw7hD2dchVsKVQIvRvahk9Xz4B0NxOPExcz3LFCybW//+og6iV/X+L8Z3hhJxx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255
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
Cc: "alexdeucher@gmail.com" <alexdeucher@gmail.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: Feifei Xu <Feifei.Xu@amd.com> 
Sent: Thursday, March 4, 2021 12:19 PM
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com; Lazar, Lijo <Lijo.Lazar@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>
Subject: [PATCH] drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.

SDMA 4_x asics share the same MGCG/MGLS setting.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 3bede8a70d7e..70d247841d14 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2271,22 +2271,10 @@ static int sdma_v4_0_set_clockgating_state(void *handle,
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-	case CHIP_VEGA20:
-	case CHIP_RAVEN:
-	case CHIP_ARCTURUS:
-	case CHIP_RENOIR:
-	case CHIP_ALDEBARAN:
-		sdma_v4_0_update_medium_grain_clock_gating(adev,
-				state == AMD_CG_STATE_GATE);
-		sdma_v4_0_update_medium_grain_light_sleep(adev,
-				state == AMD_CG_STATE_GATE);
-		break;
-	default:
-		break;
-	}
+	sdma_v4_0_update_medium_grain_clock_gating(adev,
+			state == AMD_CG_STATE_GATE);
+	sdma_v4_0_update_medium_grain_light_sleep(adev,
+			state == AMD_CG_STATE_GATE);
 	return 0;
 }
 
-- 
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

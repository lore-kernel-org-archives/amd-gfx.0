Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A632DC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 19:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 634A02067D
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 19:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EJVH1Try"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634A02067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C1DF89B42;
	Thu, 23 Jul 2020 19:28:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3BD389B42
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 19:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l97RlFX6Mq6Z5PRhnP6idJM3mb8InbWOuJHj2xgzwrrGHV/z5xn3Fcrjl+QCteAcJpiWgBX++6Q4ZZGwBoRV4Mt6icEzhe5Lnci+w78BSOSYO5tvFbsq1sGeJurWtc4+mQi/QsLfTYvkz9I3mpoaAFcpNzRNLhLeH6QeF8U76Iw6fv9iGsPDx70lD2BE+WE9x7fFSEAsmT3N9yHahl1cEty+3HcbF+2BxdpwA+ibgxtnTvbwxyrVZRJrxI5ozb4+jhRZcHgS4SOicEBzDeGFIn2NtANIDswoM/LtI2znk5oxk56NNfyQQPYXsoq6whnl5u3wkfiBSBz5UAUM5Zs3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6uSUAsnwYxKK1H9g6VWm5vHk0BYn32TJhUaWMxW+xo=;
 b=HT73iLMiMbrAydWW7m2AqTWqx8plZs18uIBgrkEfcTaDHWQxeB6FU8AC99jvBJX/UAeCVSGQ/5aJAjthg7kv3FkIhIAzqU9oRxkRky9oGVi7MtwGyKkncQtWr9nCPOTQtJUPPYUvq1sjIw8jaeKEESLkhUgXntfcHdQo+bWIjcOH1wk80VbeDVfH6fGYiDoQlF8YywafCWqYvnBwiLjjlxYPHG9TXDFxcMT9zHy06A/ZHtSGSAA4oGK2hUp+0LKSFLBd10iN1/o95ouNYjO0Ald5M/JSssrqU9bSE5TDfYkzTvMvVNdvFgzm1Shc4RJJLrvhmgysPY74UvuHq4VKPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6uSUAsnwYxKK1H9g6VWm5vHk0BYn32TJhUaWMxW+xo=;
 b=EJVH1Try90xHoM01jDDb8QJlugNzlQDzZMetdPhPlDFr5rz61vKtcRHrPljsOwAqPDZyQNds36CKoDuWhGL3+G5TOrA7qMn/yNDIX8qbwhlMpyeeEzH/oW7/xIUjcL17eCoUKjnbjRKAom5jBj/ndQWh6c5vc9cA06hZTKsVgE4=
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM5PR12MB1915.namprd12.prod.outlook.com (2603:10b6:3:10c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Thu, 23 Jul
 2020 19:28:20 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::fcaf:8267:b3d6:32ee]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::fcaf:8267:b3d6:32ee%7]) with mapi id 15.20.3216.020; Thu, 23 Jul 2020
 19:28:20 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu/vcn3.0: remove extra asic type check
Thread-Topic: [PATCH 2/2] drm/amdgpu/vcn3.0: remove extra asic type check
Thread-Index: AQHWYQvOb9AIDjL07kCwRhGUmw8YNqkVjG7g
Date: Thu, 23 Jul 2020 19:28:19 +0000
Message-ID: <DM5PR12MB178761CADC6EA0661B33ACF2E5760@DM5PR12MB1787.namprd12.prod.outlook.com>
References: <1595520621-8216-1-git-send-email-James.Zhu@amd.com>
 <1595520621-8216-2-git-send-email-James.Zhu@amd.com>
In-Reply-To: <1595520621-8216-2-git-send-email-James.Zhu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:a3c0:203:7101:5c38:8381:4a8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f1a638f-c695-4309-6f19-08d82f3e8ec1
x-ms-traffictypediagnostic: DM5PR12MB1915:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1915785892014F592E41C95AE5760@DM5PR12MB1915.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4T/20Rnzrvnh9Ya/O89ZNY3eM2L7pT1vlwFmZAcpoiwm+o0x+6v/9tBf6+7k9QRysr5QED3dlrgYxPl5uQTRq7rtVD6MrEQKFKGZZGDlpip8cjIhX2WfRm+j1nwbc5sgZvix0PGjIDSjNtbkkyS1k1YI4+Ecp2Pyb5ExtKsM+SsCVNBqgsQhGdhPdIUQVNg4usF2XbRvHWBveLi9SH1hAf4fpjy5rNuFtw0EU1j/ymG6nl5XjyJESY5XCgfROXZZ8kzZ2wPqO11/5mYugh1uwXLTVz3CcNinUvZ0AyT8Af9lUKlL+7hFY7YCrsjqeCBz3fRtgG31zbKTMPngcu1zmEMox7T27rg9PfnDwdzlqNg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(66476007)(64756008)(66556008)(66946007)(5660300002)(66446008)(76116006)(316002)(9686003)(186003)(52536014)(110136005)(33656002)(966005)(8676002)(55016002)(478600001)(45080400002)(8936002)(7696005)(86362001)(53546011)(4326008)(71200400001)(83380400001)(2906002)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: GGg53jsYOFrh7mn0S6qNM/FHMFWiuVNQciydXxjjqSWlwTP9xcuYxuys7b4zsEg60SPwz9vjweDOWAymGZJTXPgbjbHD3bEwHdT+7z8BkwjPQmd6tdEgyB3pPWdCYt8CIrud1Vre19B1Sm7yydelkCXZKeuBhQtPsQWjlPPbXtFAryeDqvM0Ddh+cBh8JJXsVnZwkHzDruoXZkFKR0aaaOf0yTmI373FBPuxZc6PcEIQu63JDz1TEaMchW6815Z5z+jIVHt43FLQGhwxQe9FSaWoj7W+Vcnhl7ba9HL9WrTbuRuw/B40p8D0GXb9GuKNuAhgX1rMP7XDeTLzT/G0Uz17jPU6BrXILA08r1wPz6wbtBKaWrw8qSHIfousRjXqnGFIg9wLgTyVkgaFVzLFiDo0gpj8EqTZG1uJJ/64eiGeNnvmAxcdUnxN1Imcheh/hDpR8Suxx5IByxCAd5qqwu6h1K/vg1AejuS8D6IGlt8gEenWVZlY+/bcnvQibv2lGSlBmb36UKmU69lpsSGQRFMvosMak4vLb4PWFDycLsE=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f1a638f-c695-4309-6f19-08d82f3e8ec1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 19:28:20.0685 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bxaywy01do3ik+mjoCVMPIodbKlaxSLxTJ7qlcnWCFqSBFba1RDNd9mR5b1PcOvf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1915
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
Cc: "Zhu, James" <James.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These 2 patches are:

Reviewed-by: Leo Liu <leo.liu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of James Zhu
Sent: July 23, 2020 12:10 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhu, James <James.Zhu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/vcn3.0: remove extra asic type check

vcn ip block is already selected based on ASIC type during set_ip_blocks.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 910a4a3..4edd5c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -88,23 +88,20 @@ static int vcn_v3_0_early_init(void *handle)
 		adev->vcn.num_enc_rings = 1;
 
 	} else {
-		if (adev->asic_type == CHIP_SIENNA_CICHLID) {
-			u32 harvest;
-			int i;
-
-			adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
-			for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-				harvest = RREG32_SOC15(VCN, i, mmCC_UVD_HARVESTING);
-				if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
-					adev->vcn.harvest_config |= 1 << i;
-			}
+		u32 harvest;
+		int i;
+
+		adev->vcn.num_vcn_inst = VCN_INSTANCES_SIENNA_CICHLID;
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			harvest = RREG32_SOC15(VCN, i, mmCC_UVD_HARVESTING);
+			if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
+				adev->vcn.harvest_config |= 1 << i;
+		}
 
-			if (adev->vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
-						AMDGPU_VCN_HARVEST_VCN1))
-				/* both instances are harvested, disable the block */
-				return -ENOENT;
-		} else
-			adev->vcn.num_vcn_inst = 1;
+		if (adev->vcn.harvest_config == (AMDGPU_VCN_HARVEST_VCN0 |
+					AMDGPU_VCN_HARVEST_VCN1))
+			/* both instances are harvested, disable the block */
+			return -ENOENT;
 
 		adev->vcn.num_enc_rings = 2;
 	}
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cleo.liu%40amd.com%7C23554320c84840aed3ed08d82f22eeff%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637311174385768765&amp;sdata=K4vaByea4r0vu%2FZbcDjEwxeU20pxOonxghrGA9jhmgw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

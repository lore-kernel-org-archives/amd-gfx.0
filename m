Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25A2C0044D
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 02:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18A1120735
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 02:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nrshHYLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18A1120735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F8816E040;
	Thu, 12 Mar 2020 02:55:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A5F66E040
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 02:55:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNDTe1z2nE+GNdOpD9XnQCqmX6SM8uyBiVLllaUm4goLCH7nMWH9gTvRaZ+BdbO5zRI4CRZBecqh/P9L5BKXQ3z8icvbVVyPWmGDZPzhINzUMQxKGwwMAlOacTfVoc75hXpc/Xk7pFCafGWRsXyXYbSMNXWlpjsS4eUkF00EBSFtoN+s4q5eZ6byjdt52Gu3ooAzhNcZZDJaHnBqAv0eNJRg39jdKgQOXMv/ravMLzKRoVsbi1M2kn5Gm/vuL/gUjg9y1AS/XXt6Qdoqy5YwBdvVbhxNetlzN+r0mLRLzvrZ3Jo13BfPWd5F1X1Xsf22HD+iY0H8P+qFNhHlWmNA5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDRoUd2xWKvrSnPPj/xFkn1JS/aS5mTQvk94dtQMA3k=;
 b=bXRSXzPef+BxVaMktRx+NecgpM2uJ5q4n2Sf7s3itnLCHKl4lZ43tUA3k2bTjyLX6pxzCrOI9/Ee8Ck5KQA1xOHPt4uQeADYZqx36/Z94GdCRfqi1gRUjWt1wRnTh130Nl/EpR9a39QSRvO4TtYTiV5xcXUGzkVa07FQcUqSGbGwucmBVIe1oGqm3WHmyp+XavyPoLDfd+Zn1rB2x2b8IFe4e9tpx21gKsvZjEKcFAZ1wS5oTpCsu0TOGeFkWlI8SZcevc1+zzGWlP5QUexMbBjz70BkNEeb3XMsrAgus3SQYyKkj0oLuoSRO5Cal3NA8BN0FJedlAKOnrK5ePKPcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDRoUd2xWKvrSnPPj/xFkn1JS/aS5mTQvk94dtQMA3k=;
 b=nrshHYLoWR1zmLuiQFHudLCyViEJ6oZmrFziaWLJ2XDvWQZcA+S64x8LIztN1UZTk0489TW8wxCNKQD2pTImgjFfXHnNMV3HBolfJhUDUDoChl5BQoOM2saoZplvgVThA13dn3D4g0Ndf77ltWRBta7Ym915qslmVfvOkIQQlps=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1941.namprd12.prod.outlook.com (2603:10b6:903:11a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Thu, 12 Mar
 2020 02:55:18 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::74d2:68e2:beee:e901]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::74d2:68e2:beee:e901%11]) with mapi id 15.20.2793.018; Thu, 12 Mar
 2020 02:55:18 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Dennis.Li@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com
Subject: [PATCH 1/2] drm/amdgpu: update ras support capability with different
 sram ecc configuration
Date: Thu, 12 Mar 2020 10:54:46 +0800
Message-Id: <20200312025447.21000-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK0PR01CA0069.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::33) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (180.167.199.189) by
 HK0PR01CA0069.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend
 Transport; Thu, 12 Mar 2020 02:55:15 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9db57c24-c724-43e4-949f-08d7c630cc32
X-MS-TrafficTypeDiagnostic: CY4PR12MB1941:|CY4PR12MB1941:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1941B74BB2DDAB05F50A0406F1FD0@CY4PR12MB1941.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(199004)(7696005)(5660300002)(1076003)(52116002)(8936002)(81156014)(81166006)(86362001)(15650500001)(478600001)(66556008)(8676002)(66476007)(44832011)(66946007)(2906002)(36756003)(316002)(4326008)(6666004)(2616005)(186003)(6486002)(26005)(6636002)(16526019)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1941;
 H:CY4PR12MB1287.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lv5n41DchCfzwnc1ORKYJmHwW6L9mGgFKn19Q4Z5q/06KrEOgBVMTPFNIOSLMECsfs3Pt2HhbaEsAhaS0o0OYmGCc98tc1a811RXe9NA4PUQIgHfVAYI3THDUx12hGH75vd5MjyBLSL8m3x0LPZ33Ryu7GEJuWGGcvNuPHKVaqp1+e3BJwU1nnzbxhYgFxVTsucwEmf7395SjgOBAy0YmCR2y42oRe6StM9LVsBqGWAOd/0WtHZaytvy3MIKe4O88C9ueKGRmC2Wbc13lRXGzznln6+DdLbWyWzNwvIK1uNcg0sR68roI/KGAAFWFksvFOhByIJ5I+3PHdFsAjkR2Is7gGsv8M70IXkeq9vB0CzA6aY0sk/swgXszalyTcsu4ZTvN2SHL+WY749il1a0jgv6mI2rckGNwG6VjDhHdTjoTlcHibUih0ZPktnTsoe7
X-MS-Exchange-AntiSpam-MessageData: 54QKb5+lQMuocbiMVd15fsNm67dEH6c+ruVKtUw9K/JOxfl3WLMHdRAZ3rSpjFmxZb9alp8MjpJ/HKU0Tbu8E2RE00he6VPcWMaq8pFFO631umfKuqjyvMiwOhLK5sUOZcIjYxYpV151C9AYZu9Ukg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db57c24-c724-43e4-949f-08d7c630cc32
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 02:55:18.6759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5MJ34ovjccjLkDC2TKH+cs20OrHo7mBJ6ciRjKYNVVnAArEjahm0scWgnrJUg+pcz0QVKXpfPAPaJOUYlecHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1941
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When sram ecc is disabled by vbios, ras initialization
process in the corrresponding IPs that suppport sram ecc
needs to be skipped. So update ras support capability
accordingly on top of this configuration. This capability
will block further ras operations to the unsupported IPs.

v2: check HBM ECC enablement and set ras mask accordingly.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 37 +++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 69b02b9d4131..b08226c10d95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1748,8 +1748,41 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev,
 			 amdgpu_atomfirmware_sram_ecc_supported(adev)))
 		*hw_supported = AMDGPU_RAS_BLOCK_MASK;
 
-	*supported = amdgpu_ras_enable == 0 ?
-				0 : *hw_supported & amdgpu_ras_mask;
+	/* Both HBM and SRAM ECC are disabled in vbios. */
+	if (*hw_supported == 0) {
+		DRM_INFO("RAS HW support is disabled as HBM"
+			" and SRAM ECC are not presented.\n");
+		return;
+	}
+
+	if (amdgpu_ras_enable) {
+		*supported = *hw_supported;
+
+		/*
+		 * When HBM ECC is disabled in vbios, remove
+		 * UMC's and DF's ras support.
+		 */
+		if (!amdgpu_atomfirmware_mem_ecc_supported(adev)) {
+			DRM_INFO("HBM ECC is disabled and "
+					"remove UMC and DF ras support.\n");
+			*supported &= ~(1 << AMDGPU_RAS_BLOCK__UMC |
+					1 << AMDGPU_RAS_BLOCK__DF);
+		}
+
+		/*
+		 * When sram ecc is disabled in vbios, bypass those IP
+		 * blocks that support sram ecc, and only hold UMC and DF.
+		 */
+		if (!amdgpu_atomfirmware_sram_ecc_supported(adev)) {
+			DRM_INFO("SRAM ECC is disabled and remove ras support "
+					"from IPs that support sram ecc.\n");
+			*supported &= (1 << AMDGPU_RAS_BLOCK__UMC |
+					1 << AMDGPU_RAS_BLOCK__DF);
+		}
+
+		/* ras support needs to align with module parmeter */
+		*supported &= amdgpu_ras_mask;
+	}
 }
 
 int amdgpu_ras_init(struct amdgpu_device *adev)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

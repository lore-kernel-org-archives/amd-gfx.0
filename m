Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65952606A324
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xFduhqN8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE5BC10F0A0;
	Thu, 19 Nov 2026 18:57:19 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010049.outbound.protection.outlook.com [52.101.56.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEDEF89167
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 18:57:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QS0o5/Rrc1Ba0C/U3DNU/rJDwgTGk0HKMq/iEXpoisU96gEbSBL24maTkEJNCiB/hMptJ/JkfVc1LNodNkjURj+Di+sN/jyFc312+BhW72kEfx3qNYMpl/UWCqfTeK1YqdZ8Ob7gvoWIGHjmdKz+CzCGSsrE2dmzd2PVeIu+CpE7RfuaDC8LF7JZnIz3Am+FFuWfiWnj+vTnn6+008cixfywEbViQnqPHexwgN2vUbPdCubO/lRoR015RFEJpt9zgAWmUiVW+h7hUPVj0u8/Ox9aUKJe/jANrvgYIBJ+9iGdaLV382wXiVmRMBUCR5uBsjpK1dYeWIrG5thBXKHMFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgedx2UelDJszWPxTEUOk1dvCqjFVc2EUc02lxMHaPc=;
 b=LApaMOfwbZriDDLbf5Pg+vg6HXS/A27iysEYBnmvVL4bhnlNUiPIWezASgz7gsigdvIhen4XbrJ09sDqQyxeHDHmjSExW3/b7YqX8QIng3Wk49X7DqxHxvaUikuWSNzD0zqlLc9mpI2HaU7a8wBZ3Or2QrcD5YcrkOBh4SoZsWcV5cPpo4Kdx3v5fYQKz9MIyxXsKgV9+3ZER5Cdq9bMh8SHjiE8IOfa81MqIvLlez8i14Vrbldj3HkOt6TGBqICpbtmc3jauK8My3bJkh6C5qmW4PVmS25ux40+HEHzlYUgvHZ+gwAhedOlSH8Sn2XJxproDALkJGuP520bw23z3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgedx2UelDJszWPxTEUOk1dvCqjFVc2EUc02lxMHaPc=;
 b=xFduhqN8aPY0u3nDwyFCITld1fTBID9yI05KZdoyPtcTDmpKYM3BoEFuS8Kh017hu8lCRllExM6LqRKZNi70LVNRGwS3Dwkg5LQOM1RTFAEq13/iX+AuUL21BUOzR4GT80NxcVLR/7Wn5d6ywU9c25Io9c9gOo/7ryTqK6apGfI=
Received: from PH0PR07CA0082.namprd07.prod.outlook.com (2603:10b6:510:f::27)
 by DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 18:57:10 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:510:f:cafe::8c) by PH0PR07CA0082.outlook.office365.com
 (2603:10b6:510:f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Thu,
 19 Nov 2026 18:57:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 18:57:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 12:57:04 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 12:57:04 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 12:57:04 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gfx11: don't enable gfx on pipe1 with tmz
Date: Thu, 19 Nov 2026 13:56:57 -0500
Message-ID: <20261119185657.4071721-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|DS0PR12MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 61659fba-bfbf-486f-e3b1-08df466ee9cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|18002099003|56012099006|11063799006|261026121527099003|10067099003|261102123227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 45xVKKo3WXwuINSnWO+PBcS6BsTdzU2uDSN15dyhARhnGJAT5Rx8Rq08YZrTDR1LwFsJS28sifPGd5r8Ye8VsYKyL4HP0eUgfBmPrbO/VeJ3qxXWoNT77isP6MvcZdejMSes7NrSrjWjbJsIt+EG7esXfqpl8FG6304GE+xJJCT/HBEonimD3hPjadaafw8c61m2WbA1TPuT5L/gqi8ysChzU7CU4OeahIF3j+W4J1wN9DYG7uNvQxSJ354iRrstC1uPV5ip8OKo7xvDADPjx6q6S70YKW5fVLRSaSUvPMfuW+56wg2ZBlmMEmLcKuCQlgtvdV2tKQrb2fkwSQzQOSwkECnVVZkfbFeylN2u4Gi41qnZc4HbZlqM6oOiKF2HU5Vz0r83A30FkBThA21j0YGSLlpGfYKxAtXoQ5m3hjU40DnTBjkPJLDV6LEISnXGGalbzPuq5FQ2WtPSV7D1HDd3J2uu1k8kXL2soNSt7Q42U47PTVLQIOHHBrHdEbRKP3il2DXzxe93MDBc4nVpIuBw8FrT0halyxzfK2mVWhgSTnDoYncL5YNPp0iGxlKAZY1uzDJpx15H8pNme85MX7H9DzAzDwN3VcniVkNw4kV8rZqAITdPbflGkDRJuR0FEs+y+pR214SpF6hjjIe2FOQ3XF9ahUrAl/TxY13OIqYZaij9PVUjgZKcFe68yquuf5QtNMTlNfXU0kY26f4Ecg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(18002099003)(56012099006)(11063799006)(261026121527099003)(10067099003)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KTwmxuiGSr2czioMfmD4hH9GFnn5Bt63DFz5gXcsuX96O8RmI+P45iyfg5/qZOqlgnBSsgcZE4KVcwXwWxH0nfjuNDrHPG2wGZ2uIbjYThou1lWtKB5Bx5M9NlHf/g6rRRY7SLnHXAxZTYS53wnl2ELjB2FZ/M9SfvRPOaS028HncXbXpZfZbxnX6wv41LtxdLNHCUi/5bCVx9F1LP5DAu0yiVc1OCJrcrvzSOZi4FzUcbc2bgQsXhONLotbJZ4fWV3sciC0/t7x+EMevuhZ6E50LgLhOrORgcHye2IkDVlcSe+68vb7XppSPwAdmhx82NqhMHx+uAjg6TGBN5LzzE6mvIdZV8/AtQ0k3rnMQPRNFOxrRjpnHpovAtSYa2lg/T+mnWkszG5ObsQrgg5Lnd626Owlkra8y+3H0Y8EaQ1+0RuN54e5TjaA0bKtGDSd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 18:57:09.2341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61659fba-bfbf-486f-e3b1-08df466ee9cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7726
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

FW doesn't support tmz on pipe one.  Only use pipe 0 if
tmz is enabled.

Fixes: fec62b5e1425 ("drm/amdgpu/gfx11: enable gfx pipe1 hardware support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 6283adec811a3..69ec1d13c4a88 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5334,10 +5334,15 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.num_compute_rings = 0;
 	} else {
 		/* rs64 only supports one gfx pipe */
-		if (adev->gfx.rs64_enable)
+		if (adev->gfx.rs64_enable) {
 			adev->gfx.num_gfx_rings = 1;
-		else
-			adev->gfx.num_gfx_rings = GFX11_NUM_GFX_RINGS;
+		} else {
+			/* FW doesn't support TMZ on gfx pipe1 */
+			if (adev->gmc.tmz_enabled)
+				adev->gfx.num_gfx_rings = 1;
+			else
+				adev->gfx.num_gfx_rings = GFX11_NUM_GFX_RINGS;
+		}
 		adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
 						  AMDGPU_MAX_COMPUTE_RINGS);
 	}
-- 
2.56.1


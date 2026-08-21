Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E355EC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 10:37:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74C5210E234;
	Fri, 21 Aug 2026 10:37:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BbeN+J4j";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C106C10E234
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 10:37:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXkEx13m9Ijqyex0mddPobwoeDnESPZZfSYV9oPnGSdauTDCoKTsip/zOHDt9PGQX3UJd9Xid7Ii0fAG01kkmOn3PDGUZjZ5Z90JGa3MSxlgxflQkdwzegBXsf8/+E7kqpPr4cBfcQXF39A8RNUV5/9oiaBlMBYpUKUIAZne7wGBlfnXO0hSIjLZ7VYIGtEIHdYku497oPE0wKuhab0ofCx0DGFzAyqXS7C/PEIrcZpByFxHYW2LDkwhPhcNoenNLqpZ4Q5+cvfQr71I/ET+x/3vSUoBIXUcz4HlSQ26bLKfNmBzLg6XtIuCrQYZDPkXOQwN6a9oe/0q3cpTl5hA+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7SQggrCPLLn7WuO75bbsSCw3c5bHtsaUSB8QS4cPo4=;
 b=uYn2jLM0oUXH62L9FvRnXBzLmJplhf9Hrz0CDpw+k7v840Jh7vEFsuAU78razwANtlP3178/qMaB3CBCwVh5yymBE2P4PJntBOabb8yKdiwGKjk7mEmtltH3H5uhfHT+87pXdhFmyyhUb9vizgR2Jmtyn/D/pvB7WQ8Y68sPeGanFvUJ+TexzVFTXpF/c30wa5WbbkEDHJxEi3c77H3j2GHEFPlywj9/enYE4zPZDVRqClK/au2TiyravSg5SOMVXHbwrPO7QdO6vAAxTTOU9iE7YPWfI+41OXUy98VKCY7CvlD6RLhQyduDn4E/QS6IlbEmtAQHn0yfcisrgcRQng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7SQggrCPLLn7WuO75bbsSCw3c5bHtsaUSB8QS4cPo4=;
 b=BbeN+J4jZmEwSmDsXNXmm2KTtXkdNc8PXbELUo40U91Mord4pi1WCCK24LgyUrtTA1DwUrFlTuTV8LaTO89VegNhXSqrBLp6Vi7pPNZHVFz3j+4K9YNqa7A2URMPhJOyUtgnjgUGwjjn1ugtBblpw3bttLh095LtD4CQPT323ZA=
Received: from BN0PR03CA0030.namprd03.prod.outlook.com (2603:10b6:408:e6::35)
 by BN5PR12MB9485.namprd12.prod.outlook.com (2603:10b6:408:2a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 10:37:09 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::69) by BN0PR03CA0030.outlook.office365.com
 (2603:10b6:408:e6::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 10:37:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 21 Aug 2026 10:37:08 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 05:37:06 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amd/ras: skip the RAS firmware reload when the block is
 down
Date: Fri, 21 Aug 2026 18:36:28 +0800
Message-ID: <20260821103628.1666226-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|BN5PR12MB9485:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d6994c-85a4-478f-0136-08deff7026df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|10067099003|56012099006|11063799006|5023799004|18002099003;
X-Microsoft-Antispam-Message-Info: oHyimTYrRhXDVtOc+tVrea3IZmKhOV4K12lZEKtrwKLFs1ngtrErD1sRhlSlPTW7nP2V/sLSyMyn4WvAXKO9NNomsAaP+V+1TGvZxleHGeMybkvshIKkMpFdHuE/x3G4Ooa4AMzeWY5ZCftBSdqYU/6qfDjjLtkOGeC6u5VMjel3b/0P9+iRUdpMMqUmwqo+vi6NDcCYqZcIxaFDbEpR3nx7iW+n/TbiO7VcWbe3Eqle8Wyyoci6KCEqqtSLwE263JKb5VDt7+jR3FQnfzFN9xaeEKtlJ8Rhp5xHXJkHIc4YJP/twL+hfeWGGat9ph3BIT13IwcStyKjZVwr80iOq9UdyNdSQh55YHVQjwCSn7GkPjoufY7DasiXIGXF3cs8kTz3yw51I4fLk/Amgm9bH1BlvZs7eVpjFsiFksVwUWUEsbd7Dkz3yX2ew85FHQkgUPVUjKKxJyMfZD/s97/Ahrm7gsA6QpbRZ3Tr73FGc9bLtBOv1Qw6yq2fKLqsI562D1QNtvQVQs4h9iSnLIcJgc7mfA3DNOopnUtmoUVaIisI84zqqxZTlUz14zDh/Gk3SIxuCYQNZOOy3nZz49vwHbQgciP96ivJU6pQdp+aEH4hgqRClIxjX+at7rEgwYvaPEzuRC9sIdyfTki+lw0TIivtNEhMfAddupDXjj0UEgF/UKuOPfIvxNcn4ED00bnGXSY9GfTw5Xd+mfut1G7+IA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(10067099003)(56012099006)(11063799006)(5023799004)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5TvLiT1cGjFwzuH5b3ImXSHtbHiSx/pLcbwpYE94LIXpgpQKvbDl7Yx7oJttv927fKUeLIxZrJbxwb2OTfcgkopiiqh74Cj6uzyyjYFa3MmnBWW8Irqr/EDiCd7C36wW9d4ByKf23wPVeIEbDTwZHwyRbAXmIeZDTiXcm8KQBDWOnnlJzOXwLldOSgml1OIu4jo+sWwu1XmIK+HzSnx41RcY6QNkKFfxAD4Vx/YY1oTwryF7rgUJJuPzE4kCDeucsc5yTn1P5mbSKwiha2sZKh7hg6AI78HAQ6EKzTIPnBs6gRwJNeVfRmnd9nB1PqMkTExoPdmmu02FTra2xdGB8Ss+H+W0B6JW3bfwaCwNwSIvO/cUmJ4Xmb6q2SohiCmQkTm9OJstDQZD2ZDBvHfviNtNXhUmFrULx8woh7kJvpWw/YafTRdUPH8fJq3YsVSg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 10:37:08.6401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d6994c-85a4-478f-0136-08deff7026df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9485
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A reset on init lowers the init level to the minimal XGMI set, which
leaves out the RAS IP block, so its hw_init never runs and the PSP
buffers stay unallocated. The resume that follows the reset tries to
reload the RAS firmware into those buffers, fails with -ENOMEM and
aborts the whole resume, taking every device of the hive down with it.

There is nothing to reload in that case. Leave the block alone and let
amdgpu_ras_resume_after_reset() bring it up, which is where it has to
happen anyway: the RAS hardware init reads the EEPROM and so takes the
reset domain lock for read, while the reset on init path still holds it
for write, so doing it here deadlocks.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 3d806e35382a..b41117deb5f3 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -518,6 +518,13 @@ static int amdgpu_ras_mgr_resume(struct amdgpu_ip_block *ip_block)
 	if (!ras_mgr || !ras_mgr->ras_core)
 		return 0;
 
+	/* Nothing was loaded, so nothing to reload. The hw_init has to run
+	 * from amdgpu_ras_resume_after_reset() instead: it reads the EEPROM,
+	 * which takes the reset domain lock that reset on init still holds.
+	 */
+	if (!ras_mgr->ras_is_ready)
+		return 0;
+
 	ret = ras_psp_reload_firmwares(ras_mgr->ras_core, 0);
 	if (ret)
 		RAS_DEV_ERR(adev,
-- 
2.34.1


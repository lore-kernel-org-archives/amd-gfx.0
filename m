Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6497BC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 05:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2378F611C0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 05:07:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2378F611C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7017C6F606;
	Wed,  6 Oct 2021 05:07:20 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3B1C6F606
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 05:07:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqC2ySr3MB4lin6hWU/nkH0nswX+iAL2xLC0+SHzAbzTAZNDTMMUoVyP6t9qWGt5ValmtBvyky2CpdzlaiwjKq/e8czZnm12wXnbPWI4PDNqXRXjYyfhBRFZ+dDGOrbVZjf1RWsDPOQJJpSTXBOff3WAr4qu5grfxGHGQ+xXQK8Hvu3/YsN0TP63+ra/H8AJVl8YvRRbbOCjedechLbNljMcUh534lRfPMoZ0TxHdJeg+I5NOsNSD1UzWlouPMqucBxdolUPCei7J0fhFaKb2VfWrMnZZsIRC3VSOhdgnPLr04x2LzY2f5gTG0z3sn/XnxYEp9XMN7E3/oyhHBhC5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmewROiIkcjSHkJ+rlSgcXsab/uclvpbi7RkZxeO3tI=;
 b=ZcrNgC3YN0fdZOji6S815hCCQLWhyjfelzbcJfLXoNe4aInQt7MFvTjhB8MRK3zR1VlbfWy8/zLBxcIIoO1sn8JEonr0+kcOFQ+DVu+1cpjR10Py0RgTnzbM5uX2tNCKfUhMiWTeDXHACX+CDB0c2SRJueqyhuFQ0zu6IKwVfhSPmhudds1GH6LdhCPp9ZGxQLB3jWJbH9V9TTQyVf4p3jqYpwlPzHYAXyv8enCLVPsUUS5APHKZVnJ/v90J8MN38+F2k1NjxiAqcgEt2DGhf7V3GwvRj/59yrThydpTQmbVYjMsLttWuW+OYuq/SXi1EqQvTMFLOuYfm8LV49foWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmewROiIkcjSHkJ+rlSgcXsab/uclvpbi7RkZxeO3tI=;
 b=M2nD/BgyRQU1WOZiLUcodfRPVIZPjsAiuePmEsgjHB28UGloip7gFOjNtxmIcVn8U/jYaW0Fp8fgx9drhJKmdYEnPFFI2/ug9kxuMSbqjrHsz9X1bGQcIcKLc60vnZJ9iXfia+PHfZEIWUdngu6q61+p7EywgSW3ceQjApWjF/8=
Received: from DM5PR07CA0155.namprd07.prod.outlook.com (2603:10b6:3:ee::21) by
 BY5PR12MB4936.namprd12.prod.outlook.com (2603:10b6:a03:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 6 Oct
 2021 05:07:16 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ee:cafe::cd) by DM5PR07CA0155.outlook.office365.com
 (2603:10b6:3:ee::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Wed, 6 Oct 2021 05:07:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Wed, 6 Oct 2021 05:07:15 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 6 Oct 2021 00:07:14 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Darren Powell <darren.powell@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: Fix incorrect power limit readback in smu11
 if POWER_SOURCE_DC
Date: Wed, 6 Oct 2021 01:06:55 -0400
Message-ID: <20211006050655.6220-3-darren.powell@amd.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006050655.6220-1-darren.powell@amd.com>
References: <20211006050655.6220-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed3c7928-1ed7-45f1-2088-08d988872a39
X-MS-TrafficTypeDiagnostic: BY5PR12MB4936:
X-Microsoft-Antispam-PRVS: <BY5PR12MB49365C8FEA0BEF9FCAEEB5DCF0B09@BY5PR12MB4936.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NyPSgxszIF6KBq72L55T/UpGzHD+tA46nTbhlh1coDjhid0RJxSsX7qJFGY0WtPzMCEfRr2pAVDplCP9F+mol4qp3pReDNoEQ1+jDCEhQilBKmKg9QnCVdV0Q88N/K5AutHvjLMLSCfCWhNgy89x2MHbc6p4AbEIlSmXrimh3YA/DQM+0R4T6kY9CwcS5hjs2Ai5BcCqEwmBXETLY2qCE1kkk9qF+G3Br2jdaOFYYJVYSGbTVB+vZs2sV/uadwWIWwBCaevV4XMduu30K8IN+HnLSKpEm2ac5fkHUcFyi2sNqlJjO5cbIaW1LxjwPFqM7/cra9a3SccWic16jLqGGu5bedcj4u0adp2fno/re3qSnG3pSiqFwSkRlzX7BNy0e/qDF7NOTxcSgQzoUV0KiprCzFu8KOdn7Xpjm+WxvnQOhHMGOO3X7gxCAVstK5jPcHsO1NhNFgf001aw8fEsyzn1JZXzIoi1GKVRqJrKRewCkXo/DjOsm7iuNLwdm/qFSeOvsFNfaiX/CiSjp++Rx110ENLUeZtfldg2VTyer53n3ejmsn7LJk1qeW0ZfhFl1X9Uao9bswjX3JAswi1k/Qkksn2urWv95u4xv4jF+M09vg3iXONs6n7T2CXZ4PVTKb8B54qNEKC8HORwTv6tes0sxeLHazaKf9tI5EUk4TngHhZYpUCgmgsMXB1bU/FOMYSkdaVoWxGcignBZDOUnjlrmL06caESTwCJ5vFs1/8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(81166007)(36756003)(1076003)(4326008)(356005)(8676002)(316002)(5660300002)(82310400003)(16526019)(186003)(26005)(70206006)(70586007)(6916009)(44832011)(6666004)(83380400001)(47076005)(336012)(2616005)(426003)(86362001)(8936002)(36860700001)(7696005)(2906002)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 05:07:15.9245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3c7928-1ed7-45f1-2088-08d988872a39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4936
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

 when smu->adev->pm.ac_power == 0, message parameter with bit 16 set is saved
 to smu->current_power_limit.

 Fixes: 0cb4c62125a9 ("drm/amd/pm: correct power limit setting for SMU V11)"

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index b9386c55bd85..aa4d34f35c33 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -984,6 +984,7 @@ int smu_v11_0_set_power_limit(struct smu_context *smu,
 {
 	int power_src;
 	int ret = 0;
+	uint32_t limit_param;
 
 	if (limit_type != SMU_DEFAULT_PPT_LIMIT)
 		return -EINVAL;
@@ -1006,10 +1007,10 @@ int smu_v11_0_set_power_limit(struct smu_context *smu,
 	 * BIT 16-23: PowerSource
 	 * BIT 0-15: PowerLimit
 	 */
-	limit &= 0xFFFF;
-	limit |= 0 << 24;
-	limit |= (power_src) << 16;
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, limit, NULL);
+	limit_param  = (limit & 0xFFFF);
+	limit_param |= 0 << 24;
+	limit_param |= (power_src) << 16;
+	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, limit_param, NULL);
 	if (ret) {
 		dev_err(smu->adev->dev, "[%s] Set power limit Failed!\n", __func__);
 		return ret;
-- 
2.33.0


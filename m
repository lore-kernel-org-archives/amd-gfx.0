Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BDCC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Feb 2022 03:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3252610E313;
	Tue,  8 Feb 2022 03:20:52 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2060.outbound.protection.outlook.com [40.107.102.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61EEF10E313
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Feb 2022 03:20:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIbLEwKmyLKBBOkVthKTroifTDqzWEAPvUrqJqSS9cwttX/Zi2f5U8tu/6tWo0TbvD2ZXqotQwntbSY+4ZLRg28IYrErj0q2b40xn33GU00NmhnE5KUPRT5MevtmBMXQgjav/+/O2vpx+m1H6Gbt9rBDoe6NtUbLRTCabCmrzt1WjdbJ6xxJqh/8MYxuxbE2+eKHyJtKTqCJvWGSSshkLGS6tZzSUXdQxblGtaviB+ku3uFbF37bFDw+ttYlBEAU6PRRGcE1yiBukwRd6rRH9VYnEsnqMix3GaMANbxcMihmpk5L27lPdyIx907HZUO/erU7zSr56YF38WI67oB4fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQ7VPPM8qZIfxrc6NKwUzQi1Vaoo997R4qOQkgcZMEM=;
 b=KRldPNkaA/UNBWc3LpjIY+oDB83ZCmDs5NMdjmO1K3dmKq5KzjhCK5IdFm4x0vUSwVyEzRnU5BxnXtvNmtjvkjJfqGX/jZJOpw2ff4rDemajJxWNrSFJOmHjUI8q9DDx1g17hS2migFikfmjiR8W33UTso9hQQ5KKW531V086u/sJob7ZwNDGEAiUGttnxvpvl65EcyjFN8tLzc15pIOyFKiutMDDaZFEi4nK6DzY3BswP8HXuNHT+KmpCcW75gbdLw2fVhE3LhcyZwUhIIJ1BlRTUr0brAKuDZTJdutzlrFXvo4gTsZVtOhX9y0sdF1RYa3snWntpf2q3az6052Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQ7VPPM8qZIfxrc6NKwUzQi1Vaoo997R4qOQkgcZMEM=;
 b=YqSHuujDn2w+FO8ectrNqup/XvZtBXxc08+S2AEbbKyoWu5ZQ1a5jkSrptVO6hxbIrT/UKEZXSQckb7UIiYyA2j1Z7PQ6kQ9Tn0B6+6REsPoDeh9cq6sgAj5i4k+tX0A8z5M+LzL6nGqF5Tzc4J0P+5YBSy9/hblaLuHsRFTzSc=
Received: from DM5PR05CA0021.namprd05.prod.outlook.com (2603:10b6:3:d4::31) by
 BYAPR12MB3480.namprd12.prod.outlook.com (2603:10b6:a03:aa::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.17; Tue, 8 Feb 2022 03:20:42 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::38) by DM5PR05CA0021.outlook.office365.com
 (2603:10b6:3:d4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Tue, 8 Feb 2022 03:20:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Tue, 8 Feb 2022 03:20:41 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Feb
 2022 21:20:40 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/7] drm/amdgpu: disable MMHUB PG for Picasso
Date: Tue, 8 Feb 2022 11:20:08 +0800
Message-ID: <20220208032009.763982-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220208032009.763982-1-evan.quan@amd.com>
References: <20220208032009.763982-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dcff654-9254-4c94-6f01-08d9eab1fcbb
X-MS-TrafficTypeDiagnostic: BYAPR12MB3480:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3480C08C3D8EBD044830193DE42D9@BYAPR12MB3480.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l6jnkC+8dCnM+mGO5YxMCeLe+8IXh2em4MB3sNoIeVRVQH0a5I4WFqAgRP3sKknOekRGPQUTDVcAgpBo1IxefZtCePbFlU/kO2JNmPX8e4iGI0raGgZeSu8oN0bCn+xXX7/elAOnVBRAUSbVTfuhZUe5RRafTHX4f6wxJc5ootETWVBbee9vYZmqbCI7z4UCZeyqgs14KqSWpefS1LBADAJOjD13AVkUCSbqJ6aupaC3eexrzhaGdN3auEjPhairHFPO1u5FmnpHCrpMpzSgM1uq4KYSlxMSWL0591cwAPLTGOshK8e+ad+FzeF5PNInAxV6MtgjegzJhI/tul6xTjME7zBWsLIwM7bVHAD/BCFG5ktDI1T6E9Uy9mBZYrPYXUH3D6x4zsHRv6Mhs95YzspEg78qsVdzX/mlpns6K8BzMZxS9R18bag/tDD0m7OeSd7OsKrrbFCu6f6N4tQ/mYv9FTuPFmEwzCalf72Pl48SvGreL5o5LvX87NQE8sSmVPNbFMxthJ+NOOsXQsKOwjaTP/0hx+j/9WHzaoeVOFMybzX3BdLi+Z1rCG9TOrTR3gRwzXa0oQTtahuVBF4OJJ0kAxuehSQ3JFqCvcXBV1qz7lx2LfrJLKd16VRCI4x5UvXBrjRPE3f8133i+xUZkyqp4IT98tE3GZTpMsmoVXkx9jghOO875Lgp20YL2yau02ocqiPCYCRB5xfb5DdLVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(44832011)(4744005)(86362001)(82310400004)(5660300002)(54906003)(40460700003)(81166007)(6916009)(4326008)(70586007)(316002)(8936002)(8676002)(16526019)(70206006)(426003)(336012)(356005)(1076003)(186003)(508600001)(2906002)(26005)(6666004)(7696005)(2616005)(83380400001)(36756003)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 03:20:41.8795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dcff654-9254-4c94-6f01-08d9eab1fcbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3480
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MMHUB PG needs to be disabled for Picasso for stability reasons.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Iea0ec757582a764ab5a000d7cc411fb814ffb19f
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index e07a5fd09d06..15ee56406bc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1081,8 +1081,11 @@ static int soc15_common_early_init(void *handle)
 				AMD_CG_SUPPORT_SDMA_LS |
 				AMD_CG_SUPPORT_VCN_MGCG;
 
+			/*
+			 * MMHUB PG needs to be disabled for Picasso for
+			 * stability reasons.
+			 */
 			adev->pg_flags = AMD_PG_SUPPORT_SDMA |
-				AMD_PG_SUPPORT_MMHUB |
 				AMD_PG_SUPPORT_VCN;
 		} else {
 			adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
-- 
2.29.0


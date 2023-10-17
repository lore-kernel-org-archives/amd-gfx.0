Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F36CCDB474
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 04:28:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F30F210E058;
	Tue, 17 Oct 2023 04:28:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEB0E10E058
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 04:28:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RV0bM2swwB/dvWRVfy1e/FOwM91Lzcrl0nHnDSjrK3Yg4ovhmbMcx3IgQEtskaRvEeHDrFAyWB/NE/azyW08Gd6qN1UUeUffsPM/dSB4eH5DfczshfXO1P6LHRYb0zo/0BGncuI0/QUgIlbi6TLR1YIazimXmiCk4R4ZzZPPtCqVnIFF/wA3FQtBvlEqmlxeKytIsr1TRskNewHYLkk9agUQdXkKN+9bI+nEF390ZBP+4JVKkQFpDfZ4GLDq8XCl5ZC9Bxt9Sr7zen+xR0VfhLHfFyMCcCfxonnPu1xlBUjBuPVxk/PGCRZbwLRDheTVpNL1l0FFIA0R7ef/cjBhcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FILOE45qYYxokRqBEmsT0z3X0e46cZvTx/Tg9jQlcuo=;
 b=XFw2WTFrznuYzEGVpWdszxriXzCmEJKgXBbsxksVF/JCdM4127OUDOv3c3FXXHelc3SZUTGG6XeMzdrAPkPTiFCYoVxqf9YvqHQ5qzGomxcJOuD9bbzpfy2z3mrGrAtI97+OPGGSZKqgspiUJkus8C0e28kdlSwudqyNKegeyFvnVwV+msNfB+S97Af939+LK89DQCPbLZ/DroDuAZR8QIx1nrj/sYKgPgNGc0p6TJC0nNfbNt+Q/tyHrFKhT1fIeR4TP79yOI8m4Hdde1ONL4Ppvubsh42Lv6fDIRc31I04yJ9Sdh8Llxuj9b9hvXu7QmdVSDUNtNrH7bfXvWyt0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FILOE45qYYxokRqBEmsT0z3X0e46cZvTx/Tg9jQlcuo=;
 b=zZFiysoCztUp/FGkcd3IZ32dd5kX3kj95wnE2+HtZ6L0QaJkkLVTq88vyIIzx9yjxD8HiCfkG77dWlWEFiOMxmUJGxyV9jC8HpULm5ZvDQntfXWDlSlZkIR0Mq2NnDSXdmXC0bkOTvxazt0P+boLpgq2o1hDd6j9lrfQS2VMpWw=
Received: from DS7PR03CA0200.namprd03.prod.outlook.com (2603:10b6:5:3b6::25)
 by CH0PR12MB8532.namprd12.prod.outlook.com (2603:10b6:610:191::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 04:28:29 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::c5) by DS7PR03CA0200.outlook.office365.com
 (2603:10b6:5:3b6::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Tue, 17 Oct 2023 04:28:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 04:28:29 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 23:28:26 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: update retry times for psp BL wait
Date: Tue, 17 Oct 2023 12:28:10 +0800
Message-ID: <20231017042810.15675-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017042810.15675-1-asad.kamal@amd.com>
References: <20231017042810.15675-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|CH0PR12MB8532:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd61e67-3091-4773-7568-08dbcec9838f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZhARMZtS9LMUOMtMoxGZC4urIfPqyS9Plrz/B6tTBJhnJEdOMdsDTlhVcvmxHS//AB+GC1PjQiNQWo31ZfnAgu6FBfwcDPHJ63Ezs2Vn98JdDAqW6v8TU6qsQ0sohAyQ1bxc0w9sa/ucvsOZlPEtqOXQhaROjgzdeuoQiWbdyzfb9YGAwvSEAKbGD75Pr2R+rs1Q7yzrXRAm8yQ5HxLE7IIbaLl/B8iXa/c0qi2av/ijotXEKeoGWVEOQmFrI3kZRHy+d/iamerxQuoyVrkfLe5HEmcp2sQLfQEZCcy2ICmRvSXyKE4hHtSEKYy2AFNMpBsMM/GoG5wMoyZ70vzUpl7zQAIIOeNxARAljRmlNFddlOrJJ2sD6wvFaYbrvh3L+Gp+nmmsdBbsQ3OSvSPzJrEaJXg8ZJcDTwkmOHYrHVz32HF2mSCirlF/OU+aGcALizYcQhwvJ6Cn3/uU/UD5BzYpECEOsDFyOMxVxXoanzs2iSKa/PUmJkG+7hBpL0PRIkIP6TIcr8b4pWjZBMj1vo8niU8/ciIpv1ion5r9pTwrRTQn5pNaOckIUyLsvwjRWVSz5fDAs0gIwuWfxkGSlFLHZ5pvtmTqrTRi16Q07v1nw9OejwXIpvukrsipD4FAgQzmHl6QamD5M74eVNMNkgVz/HmZ+7fyoc+/WXtDW9Sv62UO0/itRP41jWvg0bOb4UtZXtGjktrgA7oj/orRZ+RHRkO+Vhly6+E7y8yzuPoXDreszQ0CBmxsvW4r16YJDN4MmxqVLOvc0qMdY3Tnyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(64100799003)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(36860700001)(47076005)(356005)(40480700001)(81166007)(82740400003)(478600001)(4744005)(2906002)(6666004)(7696005)(316002)(70586007)(70206006)(6916009)(54906003)(41300700001)(4326008)(5660300002)(8676002)(44832011)(8936002)(2616005)(83380400001)(26005)(336012)(426003)(16526019)(1076003)(40460700003)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 04:28:29.3084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd61e67-3091-4773-7568-08dbcec9838f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8532
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
Cc: tao.zhou1@amd.com, Lijo.Lazar@amd.com, asad.kamal@amd.com, le.ma@amd.com,
 stanley.yang@amd.com, shiwu.zhang@amd.com,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Increase retry time for PSP BL wait, to compensate
for longer time to set c2pmsg 35 ready bit during
mode1 with RAS

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index b7bc00d4c696..e6d78e2a9376 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -168,7 +168,7 @@ static int psp_v13_0_wait_for_bootloader(struct psp_context *psp)
 	 * If there is an error in processing command, bits[7:0] will be set.
 	 * This is applicable for PSP v13.0.6 and newer.
 	 */
-	for (retry_loop = 0; retry_loop < 10; retry_loop++) {
+	for (retry_loop = 0; retry_loop < PSP_VMBX_POLLING_LIMIT; retry_loop++) {
 		ret = psp_wait_for(
 			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_35),
 			0x80000000, 0xffffffff, false);
-- 
2.42.0


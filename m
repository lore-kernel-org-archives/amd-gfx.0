Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E21C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jan 2022 21:40:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36A6A10E9E9;
	Fri,  7 Jan 2022 21:40:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FEE410E8E2
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jan 2022 21:40:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdU63j4xFoNGwtXrQc1J0FbRAt4ftWCe0F+PIYuS2WmGMsC3p1BM5s2FAFiTJN9rexsYY/eCp8NgjUTiLMS/l3EsoG2Sg6f4NJ+WQ+FhXnR8otVsH9E+KUqdxDf+Dyukoga7u+k0E7QY3mJ/y5A7YtFYDaos72IHFSNnedpIz2XHVfxraL+Y1py99jbCYZ3T3NgVkTEvtyyGTq85M96M5jRXAy5O0fuo9r2yYIjPQxydHBNV1NwUwz0XdSLuZzYx+xCNGi/F4LoxUB5GFg9z1tnfcfqoOjdA2XIAMs0Tbvu5K9yArFKgrJHP5FlCndmrX0o9Tu7mOBrAxtuj/IcuUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alK9eNEzfBn1Df4x+IddXaEye2MoFC5f/XFhk1RK5VQ=;
 b=Wf9JuQDPKUa6CwTdRX5LmqeVYO14ZQgezbCJxyVOhOjj/P1eLV3r9JXOqfptZDZDEV4fsG4EmFLbvIRelv//jvM8/fx4+JIZaDtfHc5zkNeDJ54k/L1bRKRVOIGiovnMkexBmcC1sKRSW20FNl7sCH+o5kuWD0WSa9k9kMVJgSEv1kx9txjgK1qUX0QZGArtglNZsaRmn4BrrfwmwrJKIlgrFTZvZgscpiJOYwaC7RMW+VreT4nB26l7eeEcTngz4Xps+AOE3x+j3k/g4/C1r51WhCASvaZUWth73F9NE+rtU+9DxZLlqsvaZr1gk3ArSFrkmYuvZlOP1BgwXHyE6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alK9eNEzfBn1Df4x+IddXaEye2MoFC5f/XFhk1RK5VQ=;
 b=V1/HSpnv/CyRpyTVgimJpSuuVzP+O99oIitJrGDkT7vApdeijx7VuvcKomGvCuK0gq4OSwoo/bKeRquDs1Cm/awpcw5s7+C3jleDyx4z9EevVTmcdysDbjuY9LBo+gv//1GXcUMMRdit96efcB/ACr3a7IBebz7/oxsOEJkZ1Xk=
Received: from DS7PR05CA0003.namprd05.prod.outlook.com (2603:10b6:5:3b9::8) by
 DM6PR12MB2889.namprd12.prod.outlook.com (2603:10b6:5:18a::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.9; Fri, 7 Jan 2022 21:40:09 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::9e) by DS7PR05CA0003.outlook.office365.com
 (2603:10b6:5:3b9::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.6 via Frontend
 Transport; Fri, 7 Jan 2022 21:40:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Fri, 7 Jan 2022 21:40:09 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 7 Jan
 2022 15:40:08 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: reset dcn31 SMU mailbox on failures
Date: Fri, 7 Jan 2022 15:40:10 -0600
Message-ID: <20220107214010.12977-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56e4f4b7-b142-4650-9407-08d9d226470d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2889:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB288903FE212364A2203CE61AE24D9@DM6PR12MB2889.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xD396Yr+ArrydeBJukzQWJ50WyXVwM0YC2Jl3F/2dWpp0qpTiMWb5DprQ31jZD2jfdZFF/JB53o9HiOZgTRSKoW5TNQgzcIK52vNa3Wkq8Ut3PGQFaoLba1QS9MAcLt3de+rMnvPyMS80JMf0Bf6H9UHykVfipozd2a4qOgom6GB+xPhtD4nOXIWQh4gKxi6TvrVUebElSrGr6vo/jc6LbNAPmCKuFiXUoNi/GYkxZNMyxjcoUc56j8/ch33mMjpZBdLGQbY6T9rPqXkFQeuhVw/OWZnDkJYOfWyrizh3sxvONKLkSpqMrAruo9y6JKMqsWzl3WDfiUDbCxonIo+bcksHlMjUYqDr6QRCX45GXiEUilwbDbF6kZTW1+QSOK9PeOKSwAQl5JFmEmEav1cGc329FTlQft6NdPR4QrCEx90hnwGzulB4cRAawe5v5h9fGf7AGri5dEmJerRuw8fankpcVT3Pq5cJc3qQnKHkPu26HGAfN21teXmEcHryNXMlzocayIkkL9UmmAhe/IuGQjdJeWypxEKxwoZPR/8NbUKLJ37GiNieZkJEJhCgAsottyA0KWc/ZBkMJaiwa2HGAjGkF/bY/8MmW8rBmI2E2Xn2hF7tvNyfyT6uf897KYNl05IJAwmlmuDRKv1zX0h6+sZDXl8R8jEX5XZH0zy4q05d4EfofHQdWEtk4FwH6n14wac0qnTmWlFiGGKn+kU8TSRuKGKh4yf+dnl1k/4Q5EaJ9z8R5jy4rvNGnvgMO3ocuR+z2R70nUGICYBF/QcnNQxZhEQcufEtU7pCzXTxKs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(2616005)(426003)(1076003)(316002)(40460700001)(36860700001)(82310400004)(44832011)(8676002)(336012)(5660300002)(8936002)(86362001)(6916009)(4744005)(70206006)(508600001)(81166007)(4326008)(2906002)(36756003)(186003)(16526019)(6666004)(47076005)(70586007)(356005)(26005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 21:40:09.1517 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e4f4b7-b142-4650-9407-08d9d226470d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2889
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise future commands may fail as well leading to downstream
problems that look like they stemmed from a timeout the first time
but really didn't.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
index 8c2b77eb9459..162ae7186124 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
@@ -119,6 +119,12 @@ int dcn31_smu_send_msg_with_param(
 
 	result = dcn31_smu_wait_for_response(clk_mgr, 10, 200000);
 
+	if (result == VBIOSSMC_Result_Failed) {
+		ASSERT(0);
+		REG_WRITE(MP1_SMN_C2PMSG_91, VBIOSSMC_Result_OK);
+		return -1;
+	}
+
 	if (IS_SMU_TIMEOUT(result)) {
 		ASSERT(0);
 		dm_helpers_smu_timeout(CTX, msg_id, param, 10 * 200000);
-- 
2.25.1


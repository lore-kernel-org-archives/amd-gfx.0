Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C99E7C4D8
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 16:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C6B710E10B;
	Wed,  4 Oct 2023 16:00:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C688010E10B
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 16:00:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+h7SAQJG6cDsFY9+T1oZE9Zh/VSZ2Lh2MLwS23vXfW1LbUgeTaAN/pDLF8wsysXDY/05rhMO73YH4QdSu0yyQDRoy461AQgaXvrUgfSqC/MnuSq8hqkWRKBdxUwiz1dwZdMDQb616sA4JcgFoxT9AFcWqL2bgV4cadN9k1k9MsTeU1zouB/eYxVZKVHX+P4u3s94gxmBqA2gAY6PY+1RJRBIklJtd1SOsOgp3woAGL/xLQxUdRM0CMdetqtV5ogKxN05+IEJ2THl1uMrNIJdVx8DE5PteY/P5ZzPj4I8qLhZuKc8Lo+XhGp52NdhN1JK4dONPLGCdTbgiT7By97Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Jf7vb8zKfgo3LTUu059CQF048UKpCMEbzXlSU2R1Gw=;
 b=dXueQR7jCKvwWDwzfELzqYtWmnjth2ojixszErj1MYGF6+DiGqMpJz1inYhz4MOJ5NH9hqIoUIrvnhn0gJlicp0nVRhc1dRHzJK7Q53zBBORkJ3TdzK+57VdR1uhUvWGc0u3G4+RHmGidk0AFwrY7QQQAyKsQDhF6jfqxffqZ22LOBon4Un31bp1ZBoH/RNCkNYgGWLV3y4Ilkq1VtzdTeMwWwE9o1ZADMlIrCgb51Ugr+ORnUoSZPjVJo6/SKc0/mczuZJ5RjguyFaMktXswvaFXh4STRuL+8Qz5w0ptnZSs4xNMgpXxRAkkN2yxLBndo4v/GaAcv/+1X/UKXKrgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Jf7vb8zKfgo3LTUu059CQF048UKpCMEbzXlSU2R1Gw=;
 b=iJZYiHJ6nU+z225LvfwfMvdEvUW7/orjIuZ+mWWs3ajQ+7jAJF4RvH/EOESjg6vrdNbCc8az5EVlJRiM4dmliCzWI9HYGPZaVuKhXNRO5ZtNXJ3w/+dTncHtnx5zxYrm+5A5LVhW42g1YFMfCNBqiMW9s1gEWa/Qr0HNJp/OUrc=
Received: from DM6PR10CA0018.namprd10.prod.outlook.com (2603:10b6:5:60::31) by
 BL1PR12MB5897.namprd12.prod.outlook.com (2603:10b6:208:395::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 16:00:11 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::8b) by DM6PR10CA0018.outlook.office365.com
 (2603:10b6:5:60::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Wed, 4 Oct 2023 16:00:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 16:00:11 +0000
Received: from jc-d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 11:00:10 -0500
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Improve MES responsiveness during oversubscription
Date: Wed, 4 Oct 2023 10:59:50 -0500
Message-ID: <20231004155950.1194972-1-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|BL1PR12MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: e009f80a-7203-4cc6-3e9b-08dbc4f2fd3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rrGUON+un06PclxNYYu+ns5K9L5sBVYWoWmPx2pAgsKLWWExJArk9ibBm26aFzzlXK08TAin00CF8ULNXQQofs4UlPOl4BFWu9aCxgf4PTj8n3/M0FwFC4N8xwZ6KQ8VKw1Fv9lH7u3TvPuQ6JPAh2JvQ7ZOL2wYBQXtL9IcYAXStdC+3j+fWYQpfewIYmqqSlXSuQTtUfL5Tr0YC7IfpI2NoxyjDj7rlikqbOitZzOYtxOcZ87YJx0VOzDlPS1K90YTCFWWUmPO+5ZixPgqJucUDmWXL1WxO9qttyjQk69sA+PHQ5JhthxiFmnM2+aJOZHbooxF3t48zNjn8t9UODTTpvTsWe8qN/0IzyBKL6wk7A+T6OPEigSSX8YszGtMAbwyRuIX8BBIl8tqhn7CoqopC5xzXocd8AiW/PVt3RTVKECNaKkMAW9HdPsdgVT1+medTtnYtJiJaLy2VNnVQIaBhyfdcBx9jWxqTPsJthw6nF4N6Z9vVaGw5Zz/b0tOjeQOi36Jj7mNtgD83IP1dMASHjo+O7HjXW6Se15v2dk5MOEIuaD/p7czhUQ0oQrH/+mhdVdrf/10wLdSNGCqsxCgTlBX8whwDVWAu5ckTYUgc5hAfL8Nj2X8bftYotndHGioa5VvsGu84MfSg7hzjKzWHWXyxZPXSDdC2OES9oMAZYYMpKpmeZVCVphD2Etp9PD9BlZWPBbcq9RZicKvlHP6AohusTNbxnxDR+KEP4FF9j2bc/o/jxsK5TBJs2IMO0sb3lSiLhx5dWQGIRlqYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(7696005)(2616005)(36756003)(40460700003)(82740400003)(40480700001)(81166007)(356005)(86362001)(36860700001)(426003)(336012)(26005)(47076005)(2906002)(1076003)(478600001)(6666004)(8676002)(316002)(8936002)(4326008)(41300700001)(5660300002)(44832011)(70586007)(70206006)(6916009)(54906003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 16:00:11.1808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e009f80a-7203-4cc6-3e9b-08dbc4f2fd3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5897
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
Cc: Jay Cornwall <jay.cornwall@amd.com>,
 Alexandru Tudor <alexandru.tudor@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When MES is oversubscribed it may not frequently check for new
command submissions from driver if the scheduling load is high.
Response latency as high as 5 seconds has been observed.

Enable a flag which adds a check for new commands between
scheduling quantums.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Alexandru Tudor <alexandru.tudor@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 4a3020b5b30f..31b26e6f0b30 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -406,6 +406,7 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.disable_mes_log = 1;
 	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
+	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
 	mes_set_hw_res_pkt.oversubscription_timer = 50;
 
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
-- 
2.25.1


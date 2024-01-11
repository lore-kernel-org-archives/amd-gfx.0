Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CDAC4725D
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 10:32:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9D3310E05E;
	Thu, 11 Jan 2024 10:32:31 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0225210E05E
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 10:32:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaGzMssVHOXckLKotgnL9lD5fsGy1FNZ4HegF5PFpa/dUIyOjmtyDMWoiejE93ijMnkbyRjl+D7C18h+50qfgn2fIB81i+3sxrZHXttY+f2TztpnJof1TOdy2AEBytdvHOWNjFDe2bGib9j6og6MScm0kmJsQJKVYD5/3hAGc4CbHFwZqhKLfXz5BrOTQJMwA/qMznlWVW4PgL4uC+sqNesk0SjHlzfClwnatp4+UuabGTpwrKeNom17i66Rh5m4OWJHoB6WFoDuCCwrLDHRBwhxdGHEG4lMVSidPlSU7svL4vg2QUtQ6svaMSx0kpgcJV0XjPLzKXvQxt+nTVYFfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pbGqud7iJTavLqhVfA5CkOHu7soxccpm8hb508JqSU=;
 b=RPgZlc1SUnMxHq3I50+2c0DlH51WEJzdRXXtSvK8TSDRWx5qV7eWdPanZKbXEKQSqkYJAbrG5C2ToivLfyoR+B1XPGa6QdEjXWomUrfTicWXq/8Yt+pwhSzRNcXxx8sRCSZsrroSMnes6vTB0Bxr11HG0jxEFwcHZEbN789yfJC3DE5F71ATzszxqJaI7zryQBNXBy1B6rjFLQDh0yDVCkHN1Es1esi1HChwTj0QCr6IP/IKiLTGk6MT7kY6rHtprWY7jNyi/WYmayTbsjbB6YUXE1xM3vJ3Dw6WQz4WkD2pvTSS9+9YHJgSIgkqa3WiUKZVYUPfXOhS9/RGWA6yTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pbGqud7iJTavLqhVfA5CkOHu7soxccpm8hb508JqSU=;
 b=hgRQ7B6rRWWzp/fLLx/Y9lhqybUsfJwQd2S3mKC0sTgXYB92bwbRhzSp1Mb1vYc1aL2YWMrtCFFFB4JBYV7O4OqEGqBan/sagsi7+qvqub/elamYwuMAIw+c2qo/u7W9/3a7V57sbFvSf1Cu2JxSQ3/1NljySP6CveT8u7C1KoU=
Received: from BYAPR07CA0008.namprd07.prod.outlook.com (2603:10b6:a02:bc::21)
 by IA1PR12MB6409.namprd12.prod.outlook.com (2603:10b6:208:38b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 11 Jan
 2024 10:32:27 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a02:bc:cafe::b6) by BYAPR07CA0008.outlook.office365.com
 (2603:10b6:a02:bc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19 via Frontend
 Transport; Thu, 11 Jan 2024 10:32:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Thu, 11 Jan 2024 10:32:27 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 11 Jan
 2024 04:32:22 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Fix smuv13.0.6 current clock reporting
Date: Thu, 11 Jan 2024 16:02:05 +0530
Message-ID: <20240111103205.124017-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|IA1PR12MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: fbec84ba-5c56-469e-af8e-08dc12909b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NUJxSXYI4Ut9nk9HCUcseEC22NlTjKoEQBR2xXFso3rWzzkcisjHOKq/ptpT1gWyYrd7VAjDJ0C2qUfvN6RLXuP0eLsTOVjxVCUlX7zCaSasakMbfRaIdW3k7uXKt0ND9Yhoe5tfvvadoKtmnRpiP4JyP8dvz/uNfjpCKMuEey4C0BSTG932JRvsbun9Uy/gKNqgQ8PbkejaMgCf7qoeUJfanlSu3+XOynY1SJLUEXwVX4Sn642CuGW2q0mb1Z0+ljN1JNArOYFSSeaCRumTDBecAWi7n8C9NETlEbiFhsjV5zAPX6rbPJ9mOJpa4KUjknVi0LocpT3ZNLhozYeCm6aOHUG0N5AXDdAp6K95epfGPVWEKEGQ5pZyATDWN9FHdJxT7zGJO+gcQTlZNsSpL9Kq1DODlpj4f6Lsfx/Puclb9dgBCT7tAH77lGrdFcfQsa8CDMeGkGsLh0zOcwDAmu3/mEoIgYkx04Iem1Y49ZFn7j/3fuBelQaLlAwj2ulANll7h/KbntV9lywJZfTlCaNqPSqTvqn1ykzKx+8BL4nYl1jrtqNY6YRizNLKumQBfLNIorvcqVXz5wQYtSR1AKhTo36iw9YOcDzpvS4JKDAVF88XCe75zF7CqDpzJkJXa1iWHFcFTdtzcbVI5kWrarUEGt+hlSptXiTPXnDmNjj00HO0vmMDjLV32Y6kXGb8QR8lWaN6xVW9nPs0vpTxALTyyQ5GW/uq8rX2Anbc0KsfFedklDtQNv6/0ux9/olXTUjucsCZLMds9RxElLZchw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(2616005)(1076003)(336012)(7696005)(6666004)(478600001)(26005)(426003)(36756003)(86362001)(36860700001)(81166007)(356005)(82740400003)(47076005)(4326008)(6916009)(41300700001)(83380400001)(70586007)(4744005)(8676002)(5660300002)(16526019)(70206006)(8936002)(2906002)(316002)(44832011)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 10:32:27.1264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbec84ba-5c56-469e-af8e-08dc12909b77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6409
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, kevinyang.wang@amd.com,
 Asad.Kamal@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When current clock is equal to max dpm level clock, the level is not
indicated correctly with *. Fix by comparing current clock against dpm
level value.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 7513d1cfeebd..a28649f21093 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -970,7 +970,9 @@ static int smu_v13_0_6_print_clks(struct smu_context *smu, char *buf, int size,
 			if (i < (clocks.num_levels - 1))
 				clk2 = clocks.data[i + 1].clocks_in_khz / 1000;
 
-			if (curr_clk >= clk1 && curr_clk < clk2) {
+			if (curr_clk == clk1) {
+				level = i;
+			} else if (curr_clk >= clk1 && curr_clk < clk2) {
 				level = (curr_clk - clk1) <= (clk2 - curr_clk) ?
 						i :
 						i + 1;
-- 
2.25.1


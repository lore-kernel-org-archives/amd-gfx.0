Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FCFC07E9D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 03:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 023A110E00B;
	Tue, 27 Sep 2022 03:38:12 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7AFD10E00B
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 03:38:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCdB6QHOi5mNr1LLrfpa+FedMfZvyr1NbUnyLwXqUM4V1puPKfRmsrReqlwzyzxuhbAGzMfcQDDk8aCTQ5IkW8kCopGlS3RqJQa/slCR4yjMQ82E3tAuR8lS9nPX/3wPxMNsQYBa/P0P5AStuav3mdnIju7ddbh8+ZhmLpTQi8PakzppfbUtKrULQTPPtAES1ZX7P2KuEdWtFkPQLFIfutWHJuqLUS+Jjdn0nP35MeMBIb3Ybum3GRp9Wn77KAd51q8sR4dwZbN+1hEchhQFtdmyX2nol0FZ5qZVt+VKuyh1/bunpUw224ohCKx1JDVebYp9UwoHc1jgn5GDnJygIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdg0h2T2ReeujX9D/7Y7PVAKKA0lTV/rQrXZdnZg9JM=;
 b=lbbJ/1X1ID8fNjg/Yjw0/Wl4+/d7LPvWV6gPb8SJGQ112OYpMVg70+ov+Kz/YC6YJbTm72PRzdi8oefru96pgCA8rKjNc4J3lyzKy4pIobPdFEEoBkrgGyoFSOjczxZeMSlCJPTl4fZQg+08pzTk3/0boxbFlpVlAPJZZo8rWMLxxRio8MP/nloJH6XOu0xQ+REEDrsf274sbMnbn5hY4rf+nUpP9Rh2AwguDnBEw4pUuGYrTbFtpvyI6Ai7GoRe9DZ2Qym5HRoft4i+njPtYnX06u2D9lV6rJaVx4Cg+MFY1qGIe/qhWKJVcLyP9KMzF5c5myMTEoPeMjbM7xSxew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdg0h2T2ReeujX9D/7Y7PVAKKA0lTV/rQrXZdnZg9JM=;
 b=uYIPPHvGuoJ5maIHtktZzFvzeHTf4gTbTpC4TljbDKAMQxQHPHWbkkSgS7iEbbQAC+AL4+OvTyo38ZyBox+Gnd0WdHIkUwLyOSWkAq6Rh1SRyj+FLv2XYvQHYrRvFvOyZgmylE66u+bCn5o4u5tTjiJCMJOVJIywPklgS0gRjEQ=
Received: from DM6PR04CA0018.namprd04.prod.outlook.com (2603:10b6:5:334::23)
 by IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Tue, 27 Sep
 2022 03:38:07 +0000
Received: from DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::82) by DM6PR04CA0018.outlook.office365.com
 (2603:10b6:5:334::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Tue, 27 Sep 2022 03:38:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT078.mail.protection.outlook.com (10.13.173.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 03:38:07 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 26 Sep
 2022 22:38:04 -0500
From: Asher Song <Asher.Song@amd.com>
To: <Guchun.Chen@amd.com>, <flora.cui@amd.com>, <yuliang.shi@amd.com>,
 <jun.ma2@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix a compiling error in old kernels
Date: Tue, 27 Sep 2022 11:37:43 +0800
Message-ID: <20220927033743.107390-1-Asher.Song@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT078:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c98a93d-064b-46f3-3f77-08daa039b143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sjF8jktqgqkB1LAgRWkUh2xXcltqfmfHPac40wQQVLwpCoQCLo55ufakp217xCtEIgEdq9lFBtwRGF0GE0G8hu9vUoFa7QNzWLCG8v7fhfLgdMIbLBpDVOD3jXlhloDYJPcNRKhXt8pSPMA0PoPOqZyvBvCF7UuXYZS7yoX2aSa4QUTVzeChFnQPHyCMszeAeFPi4Obv3qDV7qKU9QnXmg4hHbqzS67zkXu84DTMSr8RRsKbdkabxUv34ju1uhw4o1G6T7cyWRDKYOb+r6r2zkXM8ir/rqKbY4g4Rocg+0dO5dx87nENls6NkGSWNZfmvU0MbCFqZSYhnDGrmSyFYL7pMmM1zOy1avGHCv3E9xz4Z8pQh3rwb4HDmPzMPnAmSP301ZcI2VI0jUJYyxpHrGo4p7PkL2a5qZeFZKv4nGQvWpEQGIFq+2XbO3M/1o/y6BbDokwtUD6m49NBXn6BxRFC/edHlKDgQ54Mam/SPgftufddxZm9DouUqOOqTzKcF3+37i3Zi0eQsAS/GgI1haVD4xwuQHSUIP+vs2o4kZ+KpiZYooM0VS+G77zahplsbRCSd8nO0Y9WsFUBFADYfMRTIPKXw5duDfmRw8DDqiMSPwIctsi2KOhmfY5fLtmoKGkQ3io3SQrkxVHiXDeMAWyrxz0yqqkppBFb1owHa+6chQSXqmoO7djyrt0jREGgq/9dDvqzxwiyukJqIJBTs8YvdphbYT6/rCR5Q62O4KaP/kfW6YEz5H1wceNmYUthj1JxIrBIViDbKJtHL4nBLXwvbDqVWboda4pBSpGg5W3wKRQyqFXdmab1mShx6y9b
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199015)(40470700004)(36840700001)(46966006)(82740400003)(82310400005)(70586007)(16526019)(81166007)(1076003)(110136005)(336012)(426003)(5660300002)(47076005)(70206006)(86362001)(4326008)(8676002)(356005)(6666004)(36756003)(8936002)(40460700003)(40480700001)(478600001)(2616005)(41300700001)(316002)(2906002)(26005)(186003)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 03:38:07.2807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c98a93d-064b-46f3-3f77-08daa039b143
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089
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
Cc: Asher Song <Asher.Song@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is used to fix following compiling error that occurs in some
old kernels.

error: ‘for’ loop initial declarations are only allowed in C99 mode
  for (int i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {

Signed-off-by: Asher Song <Asher.Song@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 772ad200c5da..c91fcde7a16c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1405,8 +1405,9 @@ void dcn32_update_dsc_pg(struct dc *dc,
 		bool safe_to_disable)
 {
 	struct dce_hwseq *hws = dc->hwseq;
+	int i;
 
-	for (int i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
+	for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
 		struct display_stream_compressor *dsc = dc->res_pool->dscs[i];
 		bool is_dsc_ungated = hws->funcs.dsc_pg_status(hws, dsc->inst);
 
-- 
2.25.1


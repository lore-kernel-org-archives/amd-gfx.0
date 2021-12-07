Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB16C4167E
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 16:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E84ABEBEE6;
	Tue,  7 Dec 2021 16:58:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59FE4EBEE5
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 16:58:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RICgtMf+dB7NpE7eueg4rL6ZC1Db24hmviqCrQ8E4oJM9I0uqhtp3534+mErpdyHDmDPzR/8w1kRvKLZpmyWf2ieeOTAKp3V8eXaOHnq2uzRpft5LggC+oeUZAeJ4yvRA2dBPoWRQUGMAqNDWbaoWBJu+0cIP2Cz8UKCNRKoaXYQcC0FvjSiqx9GBdquW/HN7GdfyvX7U49gJEUtkhUi1p/K9XQgbg1W4++OZJZaA2DgHdnBKO8b6BEUhgNCn6seeaZt8TZ6ZNUUVz9wCxvRBf4/deI2npMewwp6wfBiE/NNVxnreQbFnw012FYBZ7x48jIAibfVqtS7kLsnlB2i/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5svEYYGSisE172jusTkdGGgqJIqYtzJA+SaL5Nbfa6g=;
 b=QdvuBoWwNE8i1vnrGibauvnMQu5tS2C+O7EbGhGel7grq5oLWIxHISrFvkAjmn04kAXWVWGSvPmFgjkNw2oonLVkEdZNVYeFLyaHN5XcgouO1p74nEiQVl5lRfVFNQ9BuDJ5mtuzjiR8GCayx/g1k/RXyvuUWlg8id4ZpjueRC8TUd4zyVNEgWvdTyk50X6LduPU1gpPf7Veyq+CW0urMzfe9AkDpECFFmof4UPvnAyq2tR5qYOUkXksFIWmt2wKCwfleTAJrHK0L6ibQEazAIG4XI4gyV/G69pRbbJLGiwF3y3r6TrF1fjpAF9+N7mhvYorNTviyTqBvDY+fW7PLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5svEYYGSisE172jusTkdGGgqJIqYtzJA+SaL5Nbfa6g=;
 b=4swSh5CPrZKNkHYQblaQwkeOZ9bqLpo2PxwU2oJvkAbhhAbuxi0NyW7Z4cuKgHutOHUNOTF6LPiiwuTkeFqqDls1WZZjmbjhX6hpXOPTX8EfrRn0fNSl+vZgxS2UMalKZlqkjR7Gtawag73qP8sD5v0+qtKDTJ69FDhonkyHz/o=
Received: from DM5PR18CA0089.namprd18.prod.outlook.com (2603:10b6:3:3::27) by
 BY5PR12MB3732.namprd12.prod.outlook.com (2603:10b6:a03:196::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Tue, 7 Dec
 2021 16:58:47 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::4a) by DM5PR18CA0089.outlook.office365.com
 (2603:10b6:3:3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Tue, 7 Dec 2021 16:58:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Tue, 7 Dec 2021 16:58:46 +0000
Received: from Zhigang-WS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 10:58:26 -0600
From: Zhigang Luo <zhigang.luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: extended waiting SRIOV VF reset completion
 timeout to 10s
Date: Tue, 7 Dec 2021 11:57:27 -0500
Message-ID: <20211207165727.25109-4-zhigang.luo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211207165727.25109-1-zhigang.luo@amd.com>
References: <20211207165727.25109-1-zhigang.luo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d64a737f-41f8-4a2d-53c2-08d9b9a2d5a1
X-MS-TrafficTypeDiagnostic: BY5PR12MB3732:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3732C3E86F1E5CC639348B30F16E9@BY5PR12MB3732.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JH96/zcjUSFDbe+q+FtZIff/zDMsZAW3QEq80JlJkBkvwgTFKO8aJiQKhd1rwaGHGNQJBxxRYGUhLOuKFTIPDCxBGaIPYMHV7vKLpA6uqpMYzTDxh8k0Xu6TPXE/U3DPa7vHmY9jjjkBH833+9+PYcm0/NPyargCgYsqJyinzHDD5uK5WWQ1DibCWkw1AAJPeLXjQ50tP2V2mLdqLLZJw7rENqb1Cug8fR7/beex0ZH4ZwVpZSPGHhH6h0+lBMKvCTuhHGj0AwcjeRZSrh7z/+rbvbUsEZALLclDPzboHbzYckdnUaAfxyrpIzFjpV+yk88ylzoi9c/oQ9pZqq4E8295E6lwMRmG8z3MMezp/76mnxRDmDWbN3cFfSVUmBPCk227hTQYERT1QvX7k/24tFvryLB7iXkZrfYRpyXvpwGbH6BIdPSR/RKoliL7+VQLpPnKEGSH/l9rl13ffNuycN15lKuVRl+bS5YS8ZsQ74+MbK+Vv81nqYCEHa//48K9MOC1FmSQbxOzmxQ9oBGfXajpjw0V2b2o6r35VV6mvfXuEaZXLsaRYg26kmpACeMa+ca8qs3aFjg9zdUwB/UXP5OLxQpA18rOxB4emd8Hu1DC3ULzLVtMBOp4R+ncVR2bQboD95UOV/4fvrAVL5Ie/9MP3Z5L2zRFSaGxDqQCrPn2oVwcjz3NcR/pLnKUzsQK6I28M/OfQoMbNE0QSNniiEPY+iyHTZQULLx7XbreCHTfirc1JqGgO2D4fFywRNTVMJ4DfYEIe2tPG6Nupv9KvGcUDnT0xR/Vr8vMztAO8v0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(83380400001)(44832011)(8936002)(82310400004)(8676002)(86362001)(16526019)(36756003)(26005)(2906002)(47076005)(186003)(426003)(40460700001)(70206006)(70586007)(316002)(508600001)(4744005)(6916009)(81166007)(7696005)(336012)(2616005)(4326008)(36860700001)(5660300002)(1076003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 16:58:46.8782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d64a737f-41f8-4a2d-53c2-08d9b9a2d5a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3732
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
Cc: Zhigang Luo <zhigang.luo@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For the ASIC has big FB, it need more time to clear FB during reset.
This change extended SRIOV VF waiting reset completion timeout from 5s
to 10s.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
index bd3b23171579..f9aa4d0bb638 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -26,7 +26,7 @@
 
 #define AI_MAILBOX_POLL_ACK_TIMEDOUT	500
 #define AI_MAILBOX_POLL_MSG_TIMEDOUT	6000
-#define AI_MAILBOX_POLL_FLR_TIMEDOUT	5000
+#define AI_MAILBOX_POLL_FLR_TIMEDOUT	10000
 #define AI_MAILBOX_POLL_MSG_REP_MAX	11
 
 enum idh_request {
-- 
2.17.1


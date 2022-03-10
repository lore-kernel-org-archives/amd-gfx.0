Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C61DC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 00:42:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A947710E2F7;
	Thu, 10 Mar 2022 00:42:57 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66A1810E23F
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 00:42:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DasWv+JMRunxFfAiGKjGhVfUQR3HdzeGhxFKzMCwPYiyx/SCI+Wkgp6agE3FR2trgks+d8rrhysBEr5FnhSUWMUcZe5Wv0YdJim0K6D7f5NgQBWsEC238OEe6WyKht4eWo9WwqneBT347wSadppyhjmnX4tyWaDIH4GjXB/AUM/cyXTgHcUleMcBG7VxIsbtU1fQXGC2EP4ATkOX8N+wncLMfzisdDZR2m6+OOsttD9naP4jWApVgVAk8JStRxuxTj2NZY+UbkYMGMPxoydBEhQm9Z6nMM+4mqIwddxYLPLBlCvL8u5UfdxNwCfQS+qxQQLA5r0JRlH2lM1ZbF8U0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/rmAEjir/NnFmXsVqxHrIe2x8ffDoWr/k+nnLH8mBw=;
 b=RjVtFoYA9E8OrXQi/zy1AZmbjP57xXKhMB0/xIeBeQirI7K0UevWXSKt8ZTnL8MpTDdtUP4ltHF7c9bGNKwYAQibuPstKJwIkIxqTRpslUUg76DF6H7TjqfAKQAuN0P5RJLcesmPjtNBxiZimxychWRwA3dHUVABiN4SUA+HEwkMGr0yZ3P6oy9shLXLT+sQ6DFGXQqNREQ2Ws3C5MpzfJuvb8OHTh0M3CufyEzYeSQH9HjEVvuG5PlquClXR7FlXISCAhMuyMdIsRuTpMKoOC/X7ebzIU7nQAhbAzTYuuquCls9Bk7+28ZA86Nt/zs8W4e5YFMNcBm6Ng6LV2rSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/rmAEjir/NnFmXsVqxHrIe2x8ffDoWr/k+nnLH8mBw=;
 b=EXKKamZFAkSW5SvYMOWSTWV2A5n28E13gCqzBkcsQMTOsHQGPdCdKwcrk+YevkaYJitZwKCEqr2nXiR9WUbhZ1is1eZNqfAXJ2jRMIkzA4jcg8PqZ5vYAYNmNnI/0iglLtxfzjuic89RcY8q2plTwB+QVfd94NFpjq7/ZxDt3KE=
Received: from CO2PR05CA0054.namprd05.prod.outlook.com (2603:10b6:102:2::22)
 by DM5PR1201MB2505.namprd12.prod.outlook.com (2603:10b6:3:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Thu, 10 Mar
 2022 00:42:52 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::e4) by CO2PR05CA0054.outlook.office365.com
 (2603:10b6:102:2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.7 via Frontend
 Transport; Thu, 10 Mar 2022 00:42:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 10 Mar 2022 00:42:51 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 9 Mar
 2022 18:42:49 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] umr: Fix ring-stream segmentation fault
Date: Wed, 9 Mar 2022 19:42:24 -0500
Message-ID: <20220310004226.50895-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.1.291.gdab1b7905d
In-Reply-To: <20220310004226.50895-1-luben.tuikov@amd.com>
References: <20220310004226.50895-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87683f13-f569-4c89-4571-08da022ee82d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2505:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB25051B74A4E471BB00054F12990B9@DM5PR1201MB2505.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WAmhYCBz4OsJ/Y+pDKBgXk20TE7j6Ebe1LKOLbERIrqKSZ6xa3sLODGx0Lcw9ZpfSys58ojSmmp5Tzq0DO8hsHpefjLEu2lNVMRc5KY/w7GEBBlG8wyaQY6UpgIyyLVWO68iqVEpQZDzb/BJ+dh7ow8dSdP46s5NM4ZZXODp0DnV6WQzoagpmMX3TtwvTTqelhZcKJzHCyLWhPLnme8ho58HxzvO3sQQeI1IWc7BGlPjimtIyBD7TIVuZmdxUbTJ1qP6i8J50eK0dc0yRDfdeAMqEowz+hc4/JwI4cMXBIrbEo/8ZipAFSz9EzFBt0yIQVtIfwS3RNzKfNJZuGyYq9rwiewXsm+RUOLHAE+w2nwc4o28jhvT8jTsxJWULvdyJeOB7d4UZbq0xQ2iV8BET/F/6BCZLFV8om8f+sJqbkgPQpnNGCuXZpxdKr7G20dC0iG5f2sIhX1apYi9VY3N/mB0s/tWpM+krZURV6xdzFvcbaI/e0goA4OZctvxF++NW+jorPPrl/n5mhy8oYP3o2SFSmgQjN3Lme4WZDgHnd3n9ejDBOK/bFkD2bGJqJroAUkp8jftvBtUK7icY5CAWGBoZT9jncYe0sDmbXqo/nSRPFZxtRPBymqjDUbotPqM76mb9G6203TrO1soVod3N9mnM5KU7qHuTr7ZMG6kpGLu2u1FBxueAvupUoOGfCaQhVhqVnXjHEUuV2342qDo9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(336012)(36756003)(40460700003)(1076003)(5660300002)(70586007)(426003)(2906002)(26005)(6666004)(70206006)(86362001)(16526019)(47076005)(81166007)(508600001)(2616005)(36860700001)(82310400004)(356005)(186003)(4326008)(83380400001)(8936002)(7696005)(54906003)(316002)(8676002)(44832011)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 00:42:51.1347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87683f13-f569-4c89-4571-08da022ee82d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2505
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Tom StDenis <tom.stdenis@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix a segmentation fault when running --ring-stream for a ring and no
bounds are specified. For instance "umr --ring-stream sdma0" on Sienna
Cichlid, generates the following segmentation fault:

Core was generated by `umr --ring-stream sdma0'.
Program terminated with signal SIGSEGV, Segmentation fault.
0  umr_sdma_decode_ring (asic=0x86cff0, ringname=0x7ffe92844ae0 "sdma0", start=1484, stop=10000) at /home/ltuikov/proj/open/umr/src/lib/read_sdma_stream.c:68
68				lineardata[linearsize++] = ringdata[3 + start];  // first 3 words are rptr/wptr/dwptr
Missing separate debuginfos, use: dnf debuginfo-install SDL2-2.0.14-1.fc33.x86_64 glibc-2.32-10.fc33.x86_64 libedit-3.1-38.20210714cvs.fc33.x86_64 libffi-3.1-26.fc33.x86_64 libgcc-10.3.1-1.fc33.x86_64 libpciaccess-0.16-3.fc33.x86_64 libstdc++-10.3.1-1.fc33.x86_64 llvm-libs-11.0.0-1.fc33.x86_64 nanomsg-1.1.5-6.fc33.x86_64 ncurses-libs-6.2-3.20200222.fc33.x86_64 zlib-1.2.11-23.fc33.x86_64
(gdb) bt
0  umr_sdma_decode_ring (asic=0x86cff0, ringname=0x7ffe92844ae0 "sdma0", start=1484, stop=10000) at /home/ltuikov/proj/open/umr/src/lib/read_sdma_stream.c:68
1  0x0000000000473b71 in present_sdma (asic=0x86cff0, ringname=0x7ffe92844ae0 "sdma0", start=0, end=10000, vmid=4294967295, addr=139867074238864, nwords=0)
    at /home/ltuikov/proj/open/umr/src/app/ring_stream_read.c:1214
2  0x00000000004740c9 in umr_read_ring_stream (asic=0x86cff0, ringpath=0x7ffe92847190 "sdma0") at /home/ltuikov/proj/open/umr/src/app/ring_stream_read.c:1325
3  0x0000000000457567 in main (argc=3, argv=0x7ffe92845268) at /home/ltuikov/proj/open/umr/src/app/main.c:473
(gdb) l
63
64			// copy ring data into linear array
65			lineardata = calloc(ringsize, sizeof(*lineardata));
66			linearsize = 0;
67			while (start != stop) {
68				lineardata[linearsize++] = ringdata[3 + start];  // first 3 words are rptr/wptr/dwptr
69				start = (start + 1) % ringsize;
70			}
71
72			ps = umr_sdma_decode_stream(asic, -1, 0, 0, lineardata, linearsize);
(gdb) p ringsize
$1 = 2048
(gdb) p linearsize
$2 = 30157
(gdb)

Where "linearsize" of 30157 is clearly out of bounds of "lineardata."

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Tom StDenis <tom.stdenis@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 src/lib/read_sdma_stream.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/src/lib/read_sdma_stream.c b/src/lib/read_sdma_stream.c
index 63c4fc284afa17..863d251ef64a63 100644
--- a/src/lib/read_sdma_stream.c
+++ b/src/lib/read_sdma_stream.c
@@ -63,11 +63,10 @@ struct umr_sdma_stream *umr_sdma_decode_ring(struct umr_asic *asic, char *ringna
 
 		// copy ring data into linear array
 		lineardata = calloc(ringsize, sizeof(*lineardata));
-		linearsize = 0;
-		while (start != stop) {
-			lineardata[linearsize++] = ringdata[3 + start];  // first 3 words are rptr/wptr/dwptr
-			start = (start + 1) % ringsize;
-		}
+		for (linearsize = 0;
+		     start != stop && linearsize < ringsize;
+		     linearsize++, start = (start + 1) % ringsize)
+			lineardata[linearsize] = ringdata[3 + start];  // first 3 words are rptr/wptr/dwptr
 
 		ps = umr_sdma_decode_stream(asic, -1, 0, 0, lineardata, linearsize);
 		free(lineardata);
-- 
2.35.1.291.gdab1b7905d


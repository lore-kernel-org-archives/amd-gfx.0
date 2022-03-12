Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CB0C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Mar 2022 00:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BEEE10E069;
	Sat, 12 Mar 2022 00:52:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE8C310E069
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Mar 2022 00:52:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQD7bNDgpyl1w3TVhEqb0FfMpm9/Rkmli/LoR5+VRv1re6iJdyUOHBczGTcO35nfqAdvLW/vacGOEfHsHqQtqZUNSAxfumjKCLc1/fNTTrWTWoWOOoA/vXKngsBxjLGGUnS9SWaeSTML9jjAV4wdVXCW06WGQ81LnyMD1VmbhbiyTBLpMsDRep/MJSOH6WelHHw5+KP11iGhtfYo2kVEPqBxyoskFqFcP+8Gm49TeBwwnf4PEUJLsUrvfY8NkgIglaqE4C6OKJh9MQeptTuugbbY8tOrM5WOYO4gwKkmb/pi/eLgaiDXMH97uO4cJbBpMaopItbq30+v7Gvef2ZJdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35nDhqwiz0h9Yeb9kzE8SJg56OO6F9L9N826ikmbVAE=;
 b=VImjag6f577Mp3AfqCK/tYpvJSUOJHRvQ6j1IO8HMxFusxVgnuMdx1X47qgwiZ672fHp+hiSkIkscoWTjthvC1JLLQ8JfpsEZ8LMw31CuHHNkDT12FQ4QbBEDlJxR3pidwhPfK24ShwQmfKrs4eebzoZdUzEH7yqQhmhHERRkvsXC98zmMFoV9qWxp3WPZliECb4ftbxoWkJbyFfLE8URHGwztFd2OfrMOHZFc9EiOQWd3lEEUlM6y65+eyLCIRPGnUAnGirf/rNP1+VJ3Kk/ZSpONdGEW7Q/w5GLddwRqAdngUK/7LcioTwY2xspcCwPuwrAVPCZg4BW5rLCTgSHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35nDhqwiz0h9Yeb9kzE8SJg56OO6F9L9N826ikmbVAE=;
 b=qrfpaoCq1N+OQ2R1Gbc/gHWqiSXHU98mk+Mif1rYj2uKENQHH4YOw5CzhOD8Ykfkos3SmxingmSVwQb0n3QAeN+skN0Vy06YShwij/BB9vi9iOWs75mkjE8BkMb4vizxUVkCifzekJchlOHYM1X4nkECqD8BDJH4dqW3UMnIfAg=
Received: from DM5PR1401CA0008.namprd14.prod.outlook.com (2603:10b6:4:4a::18)
 by BY5PR12MB4934.namprd12.prod.outlook.com (2603:10b6:a03:1db::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Sat, 12 Mar
 2022 00:52:38 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4a:cafe::5a) by DM5PR1401CA0008.outlook.office365.com
 (2603:10b6:4:4a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23 via Frontend
 Transport; Sat, 12 Mar 2022 00:52:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Sat, 12 Mar 2022 00:52:38 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 18:52:36 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v1 2/4] umr: Fix ring-stream segmentation fault
Date: Fri, 11 Mar 2022 19:52:04 -0500
Message-ID: <20220312005206.26588-2-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.1.291.gdab1b7905d
In-Reply-To: <20220312005206.26588-1-luben.tuikov@amd.com>
References: <20220312005206.26588-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 149778d2-37d0-4be0-b595-08da03c29aee
X-MS-TrafficTypeDiagnostic: BY5PR12MB4934:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB49346713C51FA32BC2852ADA990D9@BY5PR12MB4934.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oVn955aBStPLUYyLJlwXSW71XsmF5b1joBRhgovrwv5PMMxM/qqRLtpTTTZgKEcjQnf3GF/unBabrnv0GlSlA5xYpr5U0YL8oM5dech80eSSRmDqcsZkKBejHXAm/lfeXRqiU8aMFXabnB6u9YxaF/tDaKDbGDbQqh4Jd5bTbtu8Ld5VMk19npOIH7+MF9hOlRvOn2vlB6qDiz7Y2XrciTBHOEanQ9INDrRL0By7h7PoI4MIJRRNFM8NYuSP1SWYcGbFGUUsbZMIYquWd7jsfYINGR5K+RiNi5u0Cc6N1s3GnvZ5eKSlnmyHUk7UAmGtUHyAqt+lqD2PQdlWCXdKFR9KE+OgjVh/0pwhuuiUAikU8Vhp+t5nRcNKQj3o05ahlbRjKtL6aVluD9bPmYMBsuA50DWdBzyJLuIxx+D3bGwad+YjOT8YcuKv2O13r1hr/AzOyzSrF1WdYhdnlCv7hZe7YALeEI7X76MXCFE/e0ZfxvU/ricjsHI53OKH3tZBYpWbexytIMyiCjUnf8hf0xXJRSVFIxPovLMU0q7Iq8tR+UpEKH4YD2z4gt5HdjUf+zEklsEwdbMLL9/XpgwaGjzJ5ot97THJdNgO55DC+cV6/42eeJ9MkxOuc9aPo4vaEwJoGjkSTStz/zczE5+2dRWXdzK7NB+dSh94ectciEqcRRMpoQYps+KtsgckcxLIcnmh/lJqUuc7nzOoCCYGSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(81166007)(356005)(7696005)(83380400001)(336012)(426003)(40460700003)(2616005)(44832011)(8936002)(5660300002)(2906002)(36756003)(82310400004)(70586007)(316002)(6666004)(47076005)(508600001)(70206006)(1076003)(16526019)(26005)(186003)(86362001)(36860700001)(54906003)(6916009)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2022 00:52:38.3126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 149778d2-37d0-4be0-b595-08da03c29aee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4934
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
Reviewed-by: Tom StDenis <tom.stdenis@amd.com>
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


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E351C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Feb 2022 22:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BBE410E4AE;
	Mon, 21 Feb 2022 22:31:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9346810E4A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Feb 2022 22:30:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCerNIrFQtUSsk6oyWtwwTMptXa8BQOl84xkbb4nCHMvsRRy8LC7BqzxwGk78t6sIOz6EkDW7FrhNk4k1naTYJVtmVuHcRZmWsCosBZnZQoypmvaWpRCNmIm3wHz6oRFV0Yvx/KaD5K1+v91ba7EzZi9t+UurPjAhcx9dhJ6sxRDHz5qeTebH7JNnlaGzPEDrUkiRWSz0tA+ex8LdLZRsn5tafVTbP9xlQWg0S4Ro2FNw3VzzJ5ZM/B5lfpPUZo1AEnhpQfWcOx/MBPUWbDxERxK2FPZruYl+4PfYkNlGnp5hulwJUHaujXOYTxapAQhdp8pYfMmDgQJuFbEDJznrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whfGOEx51I01sR1mjmN9Gexm+9/g9HDqw7KrmBKEihY=;
 b=Q3GYuAcJRdOjhboYjS8ROhu7LwdGboKsCodxngpiIucfjHjSr55XqqUxibYZG5hQDOLMie7+wmkDm2Ke1S3osUYFA6LV3y412Pj/bkopPxmU5bmTtj6TcvrP4NBcabfCX8TerICmv5qkP9WVgaLlLlDuOuBFyxiUmzDDaFNbHUK6QsWwzfHBnWTjDznCdll7JWQLe3pJnqAh8eIqRLZ0qXzCZwOTrC9HxNKjKA+0ggNas8mbTezIB4WWw/UBkNiGu/z5W/afbY1HWVFbdbfbrs1oDwkyM20jOhS2RDXnrVjWlOApMwEDuMbrhO7BoibRVCRL4QttwCAInP7oSFthCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whfGOEx51I01sR1mjmN9Gexm+9/g9HDqw7KrmBKEihY=;
 b=1/6vzvvo3m+3JKPkca3HcdcOFMImvreLVe6ATNVW8TnNoE83JBWWRW3079WZ7PBrm40gEQfmxICta17vABlynDPiY0+1+mQsncqFVtsBnC3UgnNG6FL+wZNT2bPRKv7nMW65w2/Lw7SoJsLTME4RV7KhjTVfXcF4hkOFZS2++dk=
Received: from MW4PR04CA0286.namprd04.prod.outlook.com (2603:10b6:303:89::21)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Mon, 21 Feb
 2022 22:30:58 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::58) by MW4PR04CA0286.outlook.office365.com
 (2603:10b6:303:89::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.19 via Frontend
 Transport; Mon, 21 Feb 2022 22:30:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Mon, 21 Feb 2022 22:30:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 21 Feb
 2022 16:30:55 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: use ktime rather than jiffies for benchmark
 results
Date: Mon, 21 Feb 2022 17:30:30 -0500
Message-ID: <20220221223030.5672-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221223030.5672-1-alexander.deucher@amd.com>
References: <20220221223030.5672-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5eb9b453-2ae3-4ebf-abef-08d9f589d4e9
X-MS-TrafficTypeDiagnostic: MN2PR12MB4406:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB440617F6A47B90ED4EC9C122F73A9@MN2PR12MB4406.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KkWZuAUtg/bxeVPKZJXqN8CTeprI3Os1+93Y9sAJZyAc5sei6wBSwhpJIZokwDqkO4Lpi5S4JmLlysf8nGUpZpzK8xliAbtAftwrW6oeHd/VB3bwavg4vUOrw99W4lh9n/QGzvjGzI5YHaxN8xFzwbqnnGjDCwn1utpULxDWiXEyXGOdQXcPcpu6m5doqmGV4yQdcnBBgOooPtst/B50Kns63ufzkGbjjXywzw6uG589+anOvlhK6s/G2TG3YfzaPCRoDcl7q0HPSv25Ws23kDzlWcAYUlptogox4R1YR1xbSabLbDwm/GDZjug//U/ox131y0L+/yX3+5XMcoUAvFehf7aTUtDsQWt2tvETmIHcBKZh2IKoj0kqwKNI/o+EmkW3+dd+YKmxc2U+ESgmvqYhJPdUKhuXjpLdkOTBAcR1BzRlGaBAyAz/fw0HPBRPPWtE86tMEZGmm7rrZHbeumc3qPe9ig6VttgA00Qr9dG/ams/HVWEY9copBghQdldSN2/Umuzax5j0m7+99cR40X+ogrCIo6Gt/nN3rKrnXmFUf89uwnUG+5YSz/s6PL4lsWga/FTXFVEu8vyPX9aZ+X5bwdV+OKfFvsZXbILoU6y4vPrtKGhZWkuyOvVyIs+8amaFj9I5Ko856bCEfDYnGQRUn7HzA/H4L4xfVLS6ZhENWgRnLVxCC8N/I6p7E4TB4H9K0tQQ0sypVoXUp61Fg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400004)(4326008)(83380400001)(426003)(336012)(70206006)(8676002)(70586007)(508600001)(6916009)(316002)(1076003)(8936002)(5660300002)(2616005)(36756003)(2906002)(81166007)(6666004)(356005)(40460700003)(26005)(186003)(86362001)(7696005)(16526019)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2022 22:30:57.9169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb9b453-2ae3-4ebf-abef-08d9f589d4e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To protect against wraparounds.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 31 ++++++++++---------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
index 92a2ffefe62e..3136a9ad2d54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
@@ -29,14 +29,13 @@
 #define AMDGPU_BENCHMARK_COMMON_MODES_N 17
 
 static int amdgpu_benchmark_do_move(struct amdgpu_device *adev, unsigned size,
-				    uint64_t saddr, uint64_t daddr, int n)
+				    uint64_t saddr, uint64_t daddr, int n, s64 *time_ms)
 {
-	unsigned long start_jiffies;
-	unsigned long end_jiffies;
+	ktime_t stime, etime;
 	struct dma_fence *fence;
 	int i, r;
 
-	start_jiffies = jiffies;
+	stime = ktime_get();
 	for (i = 0; i < n; i++) {
 		struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
 		r = amdgpu_copy_buffer(ring, saddr, daddr, size, NULL, &fence,
@@ -48,25 +47,28 @@ static int amdgpu_benchmark_do_move(struct amdgpu_device *adev, unsigned size,
 		if (r)
 			goto exit_do_move;
 	}
-	end_jiffies = jiffies;
-	r = jiffies_to_msecs(end_jiffies - start_jiffies);
 
 exit_do_move:
+	etime = ktime_get();
+	*time_ms = ktime_ms_delta(etime, stime);
+
 	return r;
 }
 
 
 static void amdgpu_benchmark_log_results(struct amdgpu_device *adev,
 					 int n, unsigned size,
-					 unsigned int time,
+					 s64 time_ms,
 					 unsigned sdomain, unsigned ddomain,
 					 char *kind)
 {
-	unsigned int throughput = (n * (size >> 10)) / time;
+	s64 throughput = (n * (size >> 10));
+
+	throughput = div64_s64(throughput, time_ms);
 
 	dev_info(adev->dev, "amdgpu: %s %u bo moves of %u kB from"
-		 " %d to %d in %u ms, throughput: %u Mb/s or %u MB/s\n",
-		 kind, n, size >> 10, sdomain, ddomain, time,
+		 " %d to %d in %lld ms, throughput: %lld Mb/s or %lld MB/s\n",
+		 kind, n, size >> 10, sdomain, ddomain, time_ms,
 		 throughput * 8, throughput);
 }
 
@@ -76,6 +78,7 @@ static int amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
 	struct amdgpu_bo *dobj = NULL;
 	struct amdgpu_bo *sobj = NULL;
 	uint64_t saddr, daddr;
+	s64 time_ms;
 	int r, n;
 
 	n = AMDGPU_BENCHMARK_ITERATIONS;
@@ -96,11 +99,11 @@ static int amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
 		goto out_cleanup;
 
 	if (adev->mman.buffer_funcs) {
-		r = amdgpu_benchmark_do_move(adev, size, saddr, daddr, n);
-		if (r < 0)
+		r = amdgpu_benchmark_do_move(adev, size, saddr, daddr, n, &time_ms);
+		if (r)
 			goto out_cleanup;
-		if (r > 0)
-			amdgpu_benchmark_log_results(adev, n, size, r,
+		else
+			amdgpu_benchmark_log_results(adev, n, size, time_ms,
 						     sdomain, ddomain, "dma");
 	}
 
-- 
2.35.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A41EC02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 08:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34FDC10EBE8;
	Fri, 14 Feb 2025 08:08:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fk7ASZuB";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F95110EBF8
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 08:08:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nR5bBkG7Iyct/df55vLzCuY/6kzRaBnFAk2/y6By+6nc+b4rkbysJQFaPSvbn0L1fZSnVARH5jMfmw2QecFfe81SonQ0Olw1uKHwS2F5PSTqQ1dpOngvcWgiIAcBG5EUCXZgTWoG11MCl5c74gTB1MIkhN0SJHBwfygWd9pLbVoXmko6cDa6yuXvJccjWHCOjwm+MKF7Bum8i9tgNn2y7GO8Yzlm+L9krplT8Qw2JHnXEepa6YBso0/5bjJYzw7WJtE1njzJqzCEhvJQWjbYrjgrxB+PEh2gIhNPJGhgm70f7ugk5TUUN25ekk/d5YlMwe3SOJMU45bsdoKIM0CiCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1jq87LM2QuntYNxHXojz5hfN/VTI5SkohI8NYyyPag=;
 b=GBZ0A7HlA2ZOOgIwDqHOO9+rVkfyOzDBkKuV47NIwN6i7Y2s5ogk4HeH3dEOZkpTO/MvCcIvkcComJ1//McDVHQxJUJOaNCKVmjUsGylf/yED2ccFQmCjcg2o/Mmc9uF58M/tESWEQC9eZ9KbVIG6NcQD+rqv30U3WJCxLhstF5S0bKGZ8mRPHgTCvJxkIbn0Q86kJF+beq6Pg/NYwIlFvOYr6Yd/d24ZlP3sh/bRgWOJudADHtYKOU6CscJ8DrlALYIL0tdO+d+3btmxyf+8APPJENMZM+FEiBxnlBwkT/37+TfFZVE8Ad6VCi147HyvnJ5IfgUsvQNFhHQdMxfCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1jq87LM2QuntYNxHXojz5hfN/VTI5SkohI8NYyyPag=;
 b=fk7ASZuBsLwK+sHBBc90rJlcbCovZB63msDQ7BVX4Xevn/kWmK8a6LwTZq4D5ICJRGp1eV4xQVQJT9AmLOwYQq9rG4cmnX68Nn7Cl8DL7kLrXPtCCKhei7QlJ7lKpufwwx/hD2T8NGCvzFkCN7mrHbz77DXlC1C+6/oKArEXz7w=
Received: from BN1PR14CA0020.namprd14.prod.outlook.com (2603:10b6:408:e3::25)
 by PH7PR12MB5782.namprd12.prod.outlook.com (2603:10b6:510:1d1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Fri, 14 Feb
 2025 08:08:03 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::d8) by BN1PR14CA0020.outlook.office365.com
 (2603:10b6:408:e3::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Fri,
 14 Feb 2025 08:08:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.0 via Frontend Transport; Fri, 14 Feb 2025 08:08:02 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Feb
 2025 02:08:00 -0600
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>
Subject: [PATCH v2 08/12] drm/amdgpu: add data write function for CPER ring
Date: Fri, 14 Feb 2025 16:07:15 +0800
Message-ID: <7dd95a880d205059cc21a4f44d9606e7053cdf4b.1739519672.git.xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739519672.git.xiang.liu@amd.com>
References: <cover.1739519672.git.xiang.liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|PH7PR12MB5782:EE_
X-MS-Office365-Filtering-Correlation-Id: f498b28e-1af9-4328-ae86-08dd4cceb435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NOVu2qOmq2q7LGRscU2gjRPGm3ClWc0f8LpiMvwjoNJYvlRzYZDy4ev7r8FE?=
 =?us-ascii?Q?JzhHFDZgu9qBeVTiL8o8YtyBA6FmcyqCvc0IlGfYy/wXSqiD9TPUMrTp6pcw?=
 =?us-ascii?Q?6S0yi4SL84p4MMotUm+CAkn+luQv2qs8qvdFAK2Q9+3d5dSJNByb0AovNtSD?=
 =?us-ascii?Q?buW03kwS+wWUsb3wCfOW/nkoYGlOiil9QYQ7cfr8f+wdPC45ifNJLdPFKNfy?=
 =?us-ascii?Q?681bIPs8aM7s9kM8r+1H3xGpFED9Nz0yhC32wZhKrOAtHlGllHIbM92DDhTU?=
 =?us-ascii?Q?dwBRr1qlEz1eG7ZOtvJehGk/cHDXYmnIF/qsKntKURl0PCBQEWXClA/wK+V0?=
 =?us-ascii?Q?F7/lIPUKNk9V2mOo2RZkzukK0dKkkz/DzDhNlSyZxKDXYXQ1xGBUvgsP/HUv?=
 =?us-ascii?Q?+DTXUDPHJyJXcA9dONo47Zg4nmFyVYeRaZQy3jeky6BQKCxX72nVY9bURhrb?=
 =?us-ascii?Q?y7l6qZ8bM3O6MWOHdlXdQpwQZ/cdNa8BXTP0EYKdqu9ey7wyNPyC6IjfrbIo?=
 =?us-ascii?Q?QXBooSmxd1ARs87hly5VidmiTaAnTzJrQ/ZaKLgq4RqxEw5aYA9dmYmZPGDK?=
 =?us-ascii?Q?PQaCpiebUWU3L11fN7OH6WDDl7HI9JhPNxI5chQBT1VU9+UEI1vQHiNQQvpp?=
 =?us-ascii?Q?Ll+d6YR8sSJWPzTfYnW211RRUJQNzfTgrCBw3tTyivMe1GSeKg9KspFrT8MU?=
 =?us-ascii?Q?FzO00Ff38DM9WmFNB/OMDIURS6WtjCjtONGGmPvEOgwpnQCNqySX/H+mIK00?=
 =?us-ascii?Q?ZHMVIyCHy+PSSybWefH3HtoSylaADqYzHaanofTMkDNzn8bqC7NX5ZVhCVGm?=
 =?us-ascii?Q?P6hdWRe6KHtlpZj7Br6YFd/GuUhL6/3bcOZzzAp9Jf/XcjJlzSRyq8CmWHkU?=
 =?us-ascii?Q?QWUZ/hesWXWSWcUnx/hHJ+KoocKXdWRQvq94mv2gAS9SqDFtvzy0v2QqF6EK?=
 =?us-ascii?Q?jIAx+W1eqGDqS704AEPmlskdhDZ2fLt0io8zGtMRXJhm0T4s71j0NBkoP9/g?=
 =?us-ascii?Q?oI3+LM1ChiIxiLojVfoExGwuyIzh1Zu0aL0ruBWVDqLSF4r7XUfG2OY0rPjN?=
 =?us-ascii?Q?OBxHjO92qjtFEhwWHyqRkekPsBrHG2+FtFlmCHOqZ7Ksgxpu3wQOUZuD7qqq?=
 =?us-ascii?Q?zlR9QPuHn0CYVvTVu4W+i+okq4Yqo00C6DCI2E5UR3Kx4AVpgZwm8ncPIfL0?=
 =?us-ascii?Q?gz15sPHaTFWPBIIBNiLg+Eez1657pT7vTY3Yp94/LM0QRKtsp7U9YwEivF6b?=
 =?us-ascii?Q?LxRfQSz0zAgtRTh5OwKLTIqnLZpR6gTc9SqSh92K4sZvao3VwCEcHNJqlXa6?=
 =?us-ascii?Q?U68W2ZIc+LVmbrJ4ouQb4rzOfVUZmLcBLcLyLrcbC2xUflhj470+ZOmsNZzB?=
 =?us-ascii?Q?mDfg2O0FdAzfiUDBaOSHFQPI28i4MgCafOy6qMoEXRsy7ciwHLzuGa0V4ulk?=
 =?us-ascii?Q?0wuhyTUD88zwPxkVackmalK60w+k2kQc0FwASoF9bAosTdxS7+0seyCOFi2R?=
 =?us-ascii?Q?elQLYrNqmtC4WIo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 08:08:02.6088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f498b28e-1af9-4328-ae86-08dd4cceb435
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5782
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Old CPER data will be overwritten if ring buffer is full, and read
pointer always points to CPER header.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 93 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h |  2 +
 2 files changed, 95 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index cef7c1ec0d7c..64624b8b0cbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -365,6 +365,99 @@ int amdgpu_cper_generate_ce_records(struct amdgpu_device *adev,
 	return 0;
 }
 
+static bool amdgpu_cper_is_hdr(struct amdgpu_ring *ring, u64 pos)
+{
+	struct cper_hdr *chdr;
+
+	chdr = (struct cper_hdr *)&(ring->ring[pos]);
+	return strcmp(chdr->signature, "CPER") ? false : true;
+}
+
+static u32 amdgpu_cper_ring_get_ent_sz(struct amdgpu_ring *ring, u64 pos)
+{
+	struct cper_hdr *chdr;
+	u64 p;
+	u32 chunk, rec_len = 0;
+
+	chdr = (struct cper_hdr *)&(ring->ring[pos]);
+	chunk = ring->ring_size - (pos << 2);
+
+	if (!strcmp(chdr->signature, "CPER")) {
+		rec_len = chdr->record_length;
+		goto calc;
+	}
+
+	/* ring buffer is not full, no cper data after ring->wptr */
+	if (ring->count_dw)
+		goto calc;
+
+	for (p = pos + 1; p <= ring->buf_mask; p++) {
+		chdr = (struct cper_hdr *)&(ring->ring[p]);
+		if (!strcmp(chdr->signature, "CPER")) {
+			rec_len = (p - pos) << 2;
+			goto calc;
+		}
+	}
+
+calc:
+	if (!rec_len)
+		return chunk;
+	else
+		return min(rec_len, chunk);
+}
+
+void amdgpu_cper_ring_write(struct amdgpu_ring *ring,
+					      void *src, int count)
+{
+	u64 pos, wptr_old, rptr = *ring->rptr_cpu_addr & ring->ptr_mask;
+	u32 chunk, ent_sz;
+	u8 *s = (u8 *)src;
+
+	if (count >= ring->ring_size - 4) {
+		dev_err(ring->adev->dev,
+			"CPER data size(%d) is larger than ring size(%d)\n",
+			count, ring->ring_size - 4);
+
+		return;
+	}
+
+	wptr_old = ring->wptr;
+
+	while (count) {
+		ent_sz = amdgpu_cper_ring_get_ent_sz(ring, ring->wptr);
+		chunk = min(ent_sz, count);
+
+		memcpy(&ring->ring[ring->wptr], s, chunk);
+
+		ring->wptr += (chunk >> 2);
+		ring->wptr &= ring->ptr_mask;
+		count -= chunk;
+		s += chunk;
+	}
+
+	/* the buffer is overflow, adjust rptr */
+	if (((wptr_old < rptr) && (rptr <= ring->wptr)) ||
+	    ((ring->wptr < wptr_old) && (wptr_old < rptr)) ||
+	    ((rptr <= ring->wptr) && (ring->wptr < wptr_old))) {
+		pos = (ring->wptr + 1) & ring->ptr_mask;
+
+		do {
+			ent_sz = amdgpu_cper_ring_get_ent_sz(ring, pos);
+
+			rptr += (ent_sz >> 2);
+			rptr &= ring->ptr_mask;
+			*ring->rptr_cpu_addr = rptr;
+
+			pos = rptr;
+		} while (!amdgpu_cper_is_hdr(ring, rptr));
+	}
+
+	if (ring->count_dw >= (count >> 2))
+		ring->count_dw - (count >> 2);
+	else
+		ring->count_dw = 0;
+}
+
 static u64 amdgpu_cper_ring_get_rptr(struct amdgpu_ring *ring)
 {
 	return *(ring->rptr_cpu_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
index 80c8571cff9d..1fa41858f22e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.h
@@ -93,6 +93,8 @@ int amdgpu_cper_generate_ue_record(struct amdgpu_device *adev,
 int amdgpu_cper_generate_ce_records(struct amdgpu_device *adev,
 				    struct aca_banks *banks,
 				    uint16_t bank_count);
+void amdgpu_cper_ring_write(struct amdgpu_ring *ring,
+			void *src, int count);
 int amdgpu_cper_init(struct amdgpu_device *adev);
 int amdgpu_cper_fini(struct amdgpu_device *adev);
 
-- 
2.34.1


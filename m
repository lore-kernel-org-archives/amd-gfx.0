Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB8FCD343B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2026 14:02:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 650FF10F154;
	Thu,  7 May 2026 14:02:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mLSoONe4";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C011710F154
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2026 14:02:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOR12KjGLCXDBTYiOxR4L311kCf9THjvCOuaI3NP6GqrWxBgctb5YqAH4l30hkB0zpWfCFJgqIElCBZo+hcFL5hGTyxfiQinlurkk2kxbZdEKqzrVM2H/1g1jmyRvmom4aY2ELabH/0TmoR/b818Xzz0B3I5+Wsx2rjyxbDJIGLRHw+n7k1u1jIL2O+uXjGLAeZXa96LTnnmCAXIUskX3gSs8ALBY/zDwGfPz+50SJa7TmhtxV4pIedwsxEKd4nebX7HkOQMiheat2QeNxWNHJm/yfPHBsyuscfAx5/tmVeEKrowc74gxuFAggnFvwevdn9fyL1NA4+k9VMdYaH4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfE9QbMqsvoH1MbReqP5cYI+sMxlNsHdIhP1bnGYnWo=;
 b=rEin29PMEAyLmb4AzX4kB1T9BPCooj91v7jPqd2OlEezBqPfAwfdDIR13Z2vgTt7wBG1zytpnrM+Im55+rtrElJqtAq6vTFCDhliUWzkRXnn80JU4EbQkvEcnmUvhroJ3eVztiYZUpB10QVatLMyhxs+hdbiJYR3Uy4WG0N89QR2LvMwtSL0aJGxUgTLARwb/mttC5JRrJUs3h1AIftXIk6QD4UlFk93A1XM2fTNcVylLmaEvkjUZ2ljH3Kpam8l4crL8weXLtODlR2IdGM8yYXcDednjEIp0pxzr1ayEH4reHZFiM9cYpqVQ7RrcWnenpIlZDLPM1kYpaeSJLwYKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfE9QbMqsvoH1MbReqP5cYI+sMxlNsHdIhP1bnGYnWo=;
 b=mLSoONe41vZg5a9MTzXFH3mXcBl1SluYlo4dtEQpw2En7b7RmNeszZkpN4EuHulXho4/RG47UWPZzoRbHp5i+IFQcFvuCEXY9Nqx1ipnhvdVzjJZpN1aqhRcZ+ApOUe285zjzOve8UqVznIfIDD8sCG3ZsrWErJvyuEvJdDoaRU=
Received: from SA9PR13CA0013.namprd13.prod.outlook.com (2603:10b6:806:21::18)
 by CH3PR12MB8536.namprd12.prod.outlook.com (2603:10b6:610:15e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 14:02:17 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::3) by SA9PR13CA0013.outlook.office365.com
 (2603:10b6:806:21::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.9 via Frontend Transport; Thu, 7
 May 2026 14:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 14:02:16 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 7 May
 2026 09:02:15 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amd/ras: Fix CPER ring debugfs read overflow
Date: Thu, 7 May 2026 22:00:04 +0800
Message-ID: <20260507140004.244348-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|CH3PR12MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: dca5c298-ef5e-4b21-406f-08deac413f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4nKkRKGDCbUNBzz5UMTe+TlOuki/bIBTe1v59Wi3lDEApsQPDeM0j5Luk+dJLeKrk26vN48KGElqCXVeky/BkX4WAekb4j/urmr05h+qd2gHahcQURLtL/vFSSQKlEkzjxTtbjjrASggv1TjK3eQOB8YoGUXbQS37gDeGbUDiwszFSyK70Bw63A5kZlSfhFdcmtL/wpYbrL8WrxlNSnJKrMmPdlKKeY30vpyC24wIWwkJJUTq9Va9erSuIk9mvV/Fc0NM+nHoiJXHka5S21ItP0CsDMHv4G7BncgKldOpSLFVVB5U2mBeiAIt8IS8pOot6HdZLpKzz5tpWkIzJwHiIZ/Z7t6j5q7ZR/NEkYC9LvgfYl4rp0Aruqbzq9NHlaHFFEUk7NMVV0uZgNj8bRfh9eFfApy+pcfkg9YBrYdr4wPm5B8ERiP8Ih97eqbHHn+qtwtspM2PTkNNH4bStxaeJ0erFJ58FV7bCvp9ajhp8OrxTMRwLKwL729egUvuXy+XYWHurVkya7tCfg904h5CdX/0cKriaK9hu38C7ZD4EdjHuCKEikMtahuGh5ViOKfQwMowXrBFpMdURBRia/XaIyuDuol07DLRuk3HGN+ys6zPGuM2rxDpC32RcMWqhL38D0u5A74NzH2hJ6TbpwWQXZkiAIhu7QSzpAdk0LfCi1XkbAKq8uZ49331oydvWD1sNg6mfpsD6PJBpj7oeSYcP4c9tv0X0fFnpieaUIRFcU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9iYawSL5LM1QPtnRY+IzY1P697t1RdFtyHeS9/WBl10B7cJwvhiUgEg9/qqIopwtFYFVufoIhFlQ7YguA41YiYLZg3kkY9cu6e8S0mnftsAeSvDnCRC4oEQV8+36l9cwyImVXQsPjCGiLhVakeg90wE7mQhF688Zzbwionr7rJdcFVI4nnhVmxWplBViSL7lzcLJDsYwbwfR6r14gx5grdF5SHMUtu6ohifj2GWSwGey1hGUDbLWksFivxLYB9fxcig5UHe+AxHl32iTDVwtHGJICCRqO40BmeDBSrBWElt5FPRWEs10EtVfWqZgT1o3hhJ2Vy8cfcEH52wyhtS8bT7YexfvcuMAsQlKo03+wMB8RQqFPSDethPXtjf4HZKxm2VGAi80SEs4jw5TFhn83E3IJZVPVQrsroV7KyO+CPhs2K4o20gULBotfyW1IPq5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 14:02:16.7590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dca5c298-ef5e-4b21-406f-08deac413f4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8536
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

The legacy CPER debugfs reader can reach the payload path without a
valid pointer snapshot. The remaining user byte count is also treated as
the ring occupancy in dwords, so reads past the header can copy more than
requested.

Take the CPER lock before sampling pointers. Resample rptr/wptr for
payload reads, bound the payload copy by available dwords and the
remaining user size, and advance the file position for each dword copied.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 29 +++++++++++++++++-------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 5de786551aaa..e47a155f4bb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -552,8 +552,9 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 					size_t size, loff_t *pos)
 {
 	struct amdgpu_ring *ring = file_inode(f)->i_private;
-	uint32_t value, result, early[3];
+	u32 value, result, early[3] = { 0 };
 	uint64_t p;
+	u32 avail_dw, start_dw, read_dw;
 	loff_t i;
 	int r;
 
@@ -565,10 +566,10 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 
 	result = 0;
 
-	if (*pos < 12) {
-		if (ring->funcs->type == AMDGPU_RING_TYPE_CPER)
-			mutex_lock(&ring->adev->cper.ring_lock);
+	if (ring->funcs->type == AMDGPU_RING_TYPE_CPER)
+		mutex_lock(&ring->adev->cper.ring_lock);
 
+	if (*pos < 12) {
 		early[0] = amdgpu_ring_get_rptr(ring) & ring->buf_mask;
 		early[1] = amdgpu_ring_get_wptr(ring) & ring->buf_mask;
 		early[2] = ring->wptr & ring->buf_mask;
@@ -600,13 +601,24 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 			*pos += 4;
 		}
 	} else {
+		early[0] = amdgpu_ring_get_rptr(ring) & ring->buf_mask;
+		early[1] = amdgpu_ring_get_wptr(ring) & ring->buf_mask;
+
 		p = early[0];
 		if (early[0] <= early[1])
-			size = (early[1] - early[0]);
+			avail_dw = early[1] - early[0];
 		else
-			size = ring->ring_size - (early[0] - early[1]);
+			avail_dw = ring->buf_mask + 1 - (early[0] - early[1]);
 
-		while (size) {
+		start_dw = (*pos > 12) ? ((*pos - 12) >> 2) : 0;
+		if (start_dw >= avail_dw)
+			goto out;
+
+		p = (p + start_dw) & ring->ptr_mask;
+		avail_dw -= start_dw;
+		read_dw = min_t(u32, avail_dw, size >> 2);
+
+		while (read_dw) {
 			if (p == early[1])
 				goto out;
 
@@ -619,9 +631,10 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 
 			buf += 4;
 			result += 4;
-			size--;
+			read_dw--;
 			p++;
 			p &= ring->ptr_mask;
+			*pos += 4;
 		}
 	}
 
-- 
2.54.0


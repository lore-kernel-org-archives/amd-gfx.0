Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70826CD6E4A
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 15:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B1E81120BE;
	Fri, 29 May 2026 15:17:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nlaXSGff";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E6821120BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 15:17:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+Nd50PBOkKv4F/QVFNk+3e/alqYetl570JHEIegUK96P/71om6IR2Rs8s6pzxzzX8MAe2nVpIWpz4jcyKxCnx0vk0yL/22cJ0gEigMT4NSEZOZvM4KHzbCP12lmfzcmoyxIUk/rOaZ2dYssAUJCkNupLUiJmNQqZp5hfRbi+enL6AFwLZhQvtGFf/PbGwuapEi3dkQe+77r3ecYogIZajYb5CFsWCAYcCzco+124Qu2NZZunUuOEZV5NpnZdHXtzYv6O4afjRw/NvjXvV+U1B1j1tWSvacZ+qXTdh3WvIdeFsXxp8ioVQRBYLuWoIhl0uuP+c6k3V75m7WPfrWdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkQrcpKidRIFgPHeX6B3sopeqUPeJJmo6nU+PZxswDg=;
 b=Y4N7J3S8Xt99BBQAlkIYW0KrV9l8Rhx3GxmptbEHP1nyJe/cH9PQdw0zbO9mJSc5+JjRHrCrSx+FNeGZLEO0sgg/wJIP9gu0vmTCm+V6t+2lPA1LVV6GAw5lHj4DgyiGSjjfeHHUmR1omoezvepNQzLCUKkPmj0yjHxye4Yiunk6Xdbj8ahFJNN7s6VvYotWQ1euOtuzoKrV1S1q5pGLJ99S0W5fogbjwyg+45dgExGc5CV8Fw/9ZYNyvB+rUH7EZ4BfKbvo7RqSFB2WSkUjaTcQ0VYgbF7QbcW3twJReSCKgFMJZzZrTecoJxaayq1LoK5uQgzdvYq90yyYjjtepg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkQrcpKidRIFgPHeX6B3sopeqUPeJJmo6nU+PZxswDg=;
 b=nlaXSGffHzZnLctDpDzVkE+xlfskx/Hm3tnxxYMyRwn978/bO3reh1JsJE8SXrs+IXP1/txQvjin2qsyMF+Xplypn2u4Lj8U8kZW4NTzWW7zJ1ct26Sl6p97o4TmolCl3QgX9rVAtPI66uFO90WbxcbEoWldGtp3tIEGMlczGeI=
Received: from BN9PR03CA0416.namprd03.prod.outlook.com (2603:10b6:408:111::31)
 by LV8PR12MB9360.namprd12.prod.outlook.com (2603:10b6:408:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 15:16:59 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::66) by BN9PR03CA0416.outlook.office365.com
 (2603:10b6:408:111::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 15:16:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 15:16:59 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 10:16:57 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 1/2] drm/amd/ras: make UNIRAS CPER debugfs header
 legacy-compatible
Date: Fri, 29 May 2026 23:16:23 +0800
Message-ID: <20260529151624.1144318-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|LV8PR12MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f4bd918-33c7-4f0a-419b-08debd955443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: 0vzoGYC+M2C0cvL5OiQJ+r/AFcy3RzWGmbE7YgnyxUVN/nM2EtO29SzckyyVWT/+On+46DSEO5V7MjkijgHdKab0YvUyyKHix2YbE6wVtJlQorsp3REJMWP5nKSzR+uZEMA8I5xFZPVb7NjXAu4oMhrY2zy0EMe/GFaY91TpbqeX++XmIF5XR6tkWFZ/2w0O6yvnKZDj3qIv57BUrqdccIA8bibCuktgZyYqBtnRu1zweRAkU3VVk559HyKIqKmLaSRxuaHqUXOF+p3ZK5YqF6YmOJOgCKTKIcyYdlYaiaNcn8bqCFIr/n9hBgu5lrsC5kh3Qev/0kd3w7LzrwB28aQ6q0bFKvoBT/TU88F2B8dpdwaTTFojFfHRw9iEIvrLbTUtFK0TlGAKnHpe2UOxPMBQa8DumRlGE6amNfxpgl+9uh8gPBzXJ0vrvlHuke+rfuU34mlD7Wi5U+l349xt/0G/7Vper3SkaUd7vZXA1cygUJWmQJt9g8RsH5Lb3txDv3w+Etp12viIA3R2jCwreFUgfk/rl1/ismzhcaHxr0PcKJFgAPjndj1qCqjrisaT/iTLGY+h3Sst7N8SYfCtS9wN4hv0C596rCXkbAxBS4d2j/gqXyPwUYCH7qOuDlxh8oUV/4wpmDYhwVz9jXC0bIwIgMOvmR6WtleYEAHbuagAMQOAaXDZf/VGoBj8jrLXEuSv7zCpPH5MB69DkXYvvjKuEUgadurVnk/0s9GyYGU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Y/aY0C6A3Pmm0j9ArkD6bC77MO4YwvY9WHyrEosoHIcYTKAzeXUT97p+QEqut7Pjnc7xqsBVSYr42kQKmbsicl5oraINNAAVO9vMr6WqIWgeibxKKQ6YcxxTkCfTRrxbzp/NJ5AGDsry9wyh2agHIVVVKYfzFh2NmXWUwmsnSppyH339fZtx2RPBKJg69zLBUWy93USPOIKCO/jNix5ZmdadQmbaRnP0n1sAsnW/xD47xTEbydZEoULiv937pqMKiIgx4q/90ZCRQmjz1RNjNEPBXRZcycEcsjhLuLsHIvTE92E2+sAcDACGc/jPSrKDE6KPDHlb88SNH6/RTpBw0GVIdzg2AOyLrY0AFxe8u8Ln8i47rK9GfefdlYM8cxcUvNmZZamA0G81WXg2MTOAj3FFDlkAOkRJtArDzXgs7S1+DvWdJNWcavFVBWeBZdvI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 15:16:59.4223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4bd918-33c7-4f0a-419b-08debd955443
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9360
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

The UNIRAS CPER debugfs path returned a zeroed 12-byte prefix and used
file offset directly as the CPER record index. Legacy CPER ring readers
expect the prefix to contain three 32-bit ring pointers followed
immediately by CPER payload data.

Build the same header shape for UNIRAS reads by reporting a zero read
pointer and matching write pointers for the returned payload size. Keep
an internal record cursor behind the debugfs offset so follow-up reads
continue from the correct CPER record while first reads still expose the
legacy prefix.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 73 ++++++++++++++++++------
 1 file changed, 55 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index e47a155f4bb1..e8cee3728ade 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -484,7 +484,7 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
 static ssize_t amdgpu_ras_cper_debugfs_read(struct file *f, char __user *buf,
 					    size_t size, loff_t *offset)
 {
-	const uint8_t ring_header_size = 12;
+	const u8 ring_header_size = 12;
 	struct amdgpu_ring *ring = file_inode(f)->i_private;
 	struct ras_cmd_cper_snapshot_req *snapshot_req __free(kfree) =
 		kzalloc(sizeof(struct ras_cmd_cper_snapshot_req), GFP_KERNEL);
@@ -494,49 +494,86 @@ static ssize_t amdgpu_ras_cper_debugfs_read(struct file *f, char __user *buf,
 		kzalloc(sizeof(struct ras_cmd_cper_record_req), GFP_KERNEL);
 	struct ras_cmd_cper_record_rsp *record_rsp __free(kfree) =
 		kzalloc(sizeof(struct ras_cmd_cper_record_rsp), GFP_KERNEL);
-	uint8_t *ring_header __free(kfree) =
+	u32 *ring_header __free(kfree) =
 		kzalloc(ring_header_size, GFP_KERNEL);
-	uint32_t total_cper_num;
-	uint64_t start_cper_id;
+	char __user *data_buf = buf;
+	size_t data_size = size;
+	u32 total_cper_num;
+	u64 start_cper_id;
+	u64 cper_offset;
+	bool read_header;
 	int r;
 
 	if (!snapshot_req || !snapshot_rsp || !record_req || !record_rsp ||
 	    !ring_header)
 		return -ENOMEM;
 
-	if (!(*offset)) {
+	read_header = !(*offset);
+	cper_offset = read_header ? 0 : *offset - 1;
+
+	if (read_header) {
 		/* Need at least 12 bytes for the header on the first read */
 		if (size < ring_header_size)
 			return -EINVAL;
-
-		if (copy_to_user(buf, ring_header, ring_header_size))
-			return -EFAULT;
-		buf += ring_header_size;
-		size -= ring_header_size;
+		data_buf += ring_header_size;
+		data_size -= ring_header_size;
 	}
 
 	r = amdgpu_ras_mgr_handle_ras_cmd(ring->adev,
 					  RAS_CMD__GET_CPER_SNAPSHOT,
 					  snapshot_req, sizeof(struct ras_cmd_cper_snapshot_req),
 					  snapshot_rsp, sizeof(struct ras_cmd_cper_snapshot_rsp));
-	if (r || !snapshot_rsp->total_cper_num)
+	if (r)
 		return r;
 
+	if (!snapshot_rsp->total_cper_num) {
+		if (!read_header)
+			return 0;
+
+		if (copy_to_user(buf, ring_header, ring_header_size))
+			return -EFAULT;
+
+		*offset = 1;
+		return ring_header_size;
+	}
+
 	start_cper_id = snapshot_rsp->start_cper_id;
 	total_cper_num = snapshot_rsp->total_cper_num;
+	if (read_header && !data_size) {
+		if (copy_to_user(buf, ring_header, ring_header_size))
+			return -EFAULT;
+
+		*offset = cper_offset + 1;
+		return ring_header_size;
+	}
 
-	record_req->buf_ptr = (uint64_t)(uintptr_t)buf;
-	record_req->buf_size = size;
-	record_req->cper_start_id = start_cper_id + *offset;
-	record_req->cper_num = total_cper_num;
-	r = amdgpu_ras_mgr_handle_ras_cmd(ring->adev, RAS_CMD__GET_CPER_RECORD,
+	if (!data_size)
+		return 0;
+
+	record_req->buf_ptr = (u64)(uintptr_t)data_buf;
+	record_req->buf_size = data_size;
+	record_req->cper_start_id = start_cper_id + cper_offset;
+	record_req->cper_num = total_cper_num - cper_offset;
+	r = amdgpu_ras_mgr_handle_ras_cmd(ring->adev,
+					  RAS_CMD__GET_CPER_RECORD,
 					  record_req, sizeof(struct ras_cmd_cper_record_req),
 					  record_rsp, sizeof(struct ras_cmd_cper_record_rsp));
 	if (r)
 		return r;
+	if (record_rsp->real_data_size > data_size)
+		return -EIO;
+
+	if (read_header) {
+		ring_header[1] = record_rsp->real_data_size >> 2;
+		ring_header[2] = ring_header[1];
+
+		if (copy_to_user(buf, ring_header, ring_header_size))
+			return -EFAULT;
+	}
 
-	r = *offset ? record_rsp->real_data_size : record_rsp->real_data_size + ring_header_size;
-	(*offset) += record_rsp->real_cper_num;
+	r = read_header ? record_rsp->real_data_size + ring_header_size :
+				record_rsp->real_data_size;
+	*offset = cper_offset + record_rsp->real_cper_num + 1;
 
 	return r;
 }
-- 
2.34.1


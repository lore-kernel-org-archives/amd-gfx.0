Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FDBCCD1A5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 04:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B12D210E9CC;
	Fri, 24 Oct 2025 04:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CyJ6lJq/";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010006.outbound.protection.outlook.com [52.101.46.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 352FA10E9CC
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 04:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4NZJcIwhnssfgyeOZaxhmfun4C4hm/33/Xw4uOdwYcr7tIoCP8Ycg4ZzwZhvXPtVcyxKr7TD2eZPvXs8s9fXQSGoZWtFanwy+LJ9IcA/Ogp3Za0X96slkuMSBGf0jnDxTT1XBQu77J8OK33Q2G0Q97oCXnVqe1c0j3G4KRnLHv3xBYbJn3TSg3IM90bjiYMFRiSxtnvwiGAMLXMjVyKIq02S6JcNArsh5n/28R4yL3hh9LDn3KZ8yCcVpzw91KVWG8pWxJy9NE+qhL9/UghJfmSLLjovPMhu3Xc0D1mxPTNGkS+N0M2hCRVfD2J5YIP1oscRIujl7CUaAC6qY27bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmYuytUzjx3eXgQfMYbt2aCxxqZ+whhsclAu9Q4NekE=;
 b=NSi96Vy5059BZK0Zq3VgCUYJG413Yd/7rCN+6q5fn7JuyHqHwXAVl8a8Xel9KPoDCMob5qw71TmVSrUq2ZFVUH66aSJjvSrmcRZeVpiM59wO0gzveq/n6QA8AsGxPf86ALofS6/HRFUxpLrCNP5nhHohviupei4o/vo0DLJqDW9iqSQwvSvLvd4U1pIg2sbbMqJ7+rRP17u+19h5fh0Y/82F+W5eVftBtCQMHzwrNW1uakcPGhAcoMU/z3mzgb9OraHaXGz+Svg6I+6x2tOXwDXP3pgqF4DfVDrDR916guzrI2Bv5goFJq0MYWSoqVdcMKZtk8+6xVdwHPpBKAOCqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmYuytUzjx3eXgQfMYbt2aCxxqZ+whhsclAu9Q4NekE=;
 b=CyJ6lJq/oYZlCyLxOwPf+nvNQ8MMJnVwrJNsHl4TtK/yixb/Y2Uh1LaZ68Bqef4+VEQQKTBploZhTdrNQt+hs0f2njYCeyZbLIQeLYbYrKn7qDTM/vElDviU87hf2bVpvQNEHKqxDWe6++nO00qLupjdBKubYEZIE6D9cUbOdNY=
Received: from BN9PR03CA0621.namprd03.prod.outlook.com (2603:10b6:408:106::26)
 by BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 04:48:11 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::dd) by BN9PR03CA0621.outlook.office365.com
 (2603:10b6:408:106::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Fri,
 24 Oct 2025 04:48:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 24 Oct 2025 04:48:10 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 23 Oct
 2025 21:48:07 -0700
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Stanley.Yang@amd.com>,
 <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>, Xiang Liu
 <xiang.liu@amd.com>, Tao Zhou <tao.zhou1@amd.com>, Yang Wang
 <kevinyang.wang@amd.com>
Subject: [PATCH v3] drm/amd/ras: Add CPER ring read for uniras
Date: Fri, 24 Oct 2025 12:47:52 +0800
Message-ID: <20251024044752.1448944-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|BY5PR12MB4209:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a0ac518-7767-4178-da57-08de12b888b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7iNVKPfzym6evITsiAXX+PM4iCnNWPB0pD4rK8C1IW+6MB5zdgNtaEWOZ/Ld?=
 =?us-ascii?Q?UR7f+9bkkSURtzBBVO/eSsAZnTfpcl+unFl6OgDfh6Gxis+RQzjyKMiYnrK6?=
 =?us-ascii?Q?NrI9MtfEXmNGER46mjrsjjhXOeNm/C8+AYJNOWBd8BE5RJKz4hSRiHwEt5lV?=
 =?us-ascii?Q?7toD4cM6lMZkVjALhZytvI/5HPlX3a5b7KiVGQEnRUsWs2VofphPJyiCMV2z?=
 =?us-ascii?Q?LzAWpVXalH9p9qUEyrfii9hkwAs0yz3/Z1wE7Y06IAr2gOFXq236/hMfeNmm?=
 =?us-ascii?Q?xlLZD64KW19rMyEvCqHarKZT9UK6hrPF11WdAPk1gZiXkJXGaMJILSztwh3I?=
 =?us-ascii?Q?V1NEHQzr3jV4p54QwEiQu3N5BO0o0fyXJdOMXKHpcuWYIpkCaPLMr43eJ3kS?=
 =?us-ascii?Q?VVHlmUGiAxydY4eBGu+VLLVxL1OLR4oObcyeGg6tQUmcMI4RrQ7y6kfrt6/1?=
 =?us-ascii?Q?Ruzdy+7C62JDwmxuhlcwTp/Ya2xCBMjA3TEEQon9uKnZnfXaQaeMvr59Rn4S?=
 =?us-ascii?Q?31P1RrWxg30P/+zYcXRSUbwFG7vOdB+sCKlSKBb9z2ATs/t4mhPFzm+RitCw?=
 =?us-ascii?Q?BYHAHPbJJC7yvHCVYbeslOu/RoDSA/C9wIdZEVWLmijw8110SmB/w7r5Es6z?=
 =?us-ascii?Q?W8mguR0wgLXn71EUUmjARyIxl5/k2mp9ga2j0QP0lw7amGs9l+yVTmJS4Rg5?=
 =?us-ascii?Q?QiJ4sQhIWkLjnHY4bWbSdYHxv1JgRzOZrzHA8n4VjO2aF5CWbFd+SvPFee9H?=
 =?us-ascii?Q?RHf6ktLXOTC3P7cHUMcjrd6+TwjHtldJYaY7nG/yAkbN6sQI6WWtpvkg7DdC?=
 =?us-ascii?Q?m4KPw49/0E1843GkZstc30weXwz2rdkRMrVReAQIy9DZMWDJx8DRZ/vt9NDI?=
 =?us-ascii?Q?lzxL04O7KGgqQcMC79WAiXn07FpUs8gM1jywF8JPrktBTNf9OlwTkGW1EzHY?=
 =?us-ascii?Q?lkkbfo5nkUDFJKWSOndbLnoC3eDD/Qj+/ZdfvL0NHEE1xpfg0vO1Xm1HLwKe?=
 =?us-ascii?Q?sbUqp+gsiAskyDv8z18vYKkDVC2ThvtOr6+M7RSPZuibJKx64pIgNYfkYquo?=
 =?us-ascii?Q?y5ptyztKUDD6HpnnM83QgPEcrU2r3SdIdht7sMGK71p+nmu/bOq2oWAJOU+3?=
 =?us-ascii?Q?VSjwokbgEcFhrNPD0KSUcd/TVe5jOWU2sD7cpNP51WIz44WVt1TBJk65sS1Y?=
 =?us-ascii?Q?naBA6efbizEIjy1E4jrQVVsfE55ml95cKJQnf0/sIFkI+9NmFb8O8eXK1bPr?=
 =?us-ascii?Q?zoo0eRRLxiZcthjHvIXC4fCQ9RwOmh+eX5xTntyHA8pYf/uc/uymJkrbK4xJ?=
 =?us-ascii?Q?jbaiwo4JXM3p73m0CJ2VNQAY1L28adZOoUpCYgky7y6lgrlQT88gosksT8Bf?=
 =?us-ascii?Q?p9G2UN00dtU2brMfYLIk29+1B3mXGWl3SBcsSOMIcmOXZfIoMvAUBeConaQS?=
 =?us-ascii?Q?8w7zzEx12VE+o3Sn9RGYgnYkXpqk5BzrGCAveGScjXs3uDEundWAXCc+3Y83?=
 =?us-ascii?Q?J/ksMs6cRXZwUOXzVjS0M6x9XHF1GyIlw289hGBKauOE1kHOpJk2W+NfIDG/?=
 =?us-ascii?Q?bcT/ZGf4X5B8/PFGjmU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 04:48:10.9337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0ac518-7767-4178-da57-08de12b888b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209
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

Read CPER raw data from debugfs node "/sys/kernel/debug/dri/*/
amdgpu_ring_cper".

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c      | 87 +++++++++++++++++++
 3 files changed, 90 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 603cc155fd9b..66ccd31f1e8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -110,6 +110,7 @@
 #include "amdgpu_mca.h"
 #include "amdgpu_aca.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_ras_mgr.h"
 #include "amdgpu_cper.h"
 #include "amdgpu_xcp.h"
 #include "amdgpu_seq64.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 5a7bf0661dbf..011fa4748084 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -770,7 +770,8 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eeprom_control *control)
 			"Saved bad pages %d reaches threshold value %d\n",
 			control->ras_num_bad_pages, ras->bad_page_cnt_threshold);
 
-		if (adev->cper.enabled && amdgpu_cper_generate_bp_threshold_record(adev))
+		if (adev->cper.enabled && !amdgpu_uniras_enabled(adev) &&
+		    amdgpu_cper_generate_bp_threshold_record(adev))
 			dev_warn(adev->dev, "fail to generate bad page threshold cper records\n");
 
 		if ((amdgpu_bad_page_threshold != -1) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index f26002b25de4..8637d924cd48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -491,6 +491,90 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
  */
 #if defined(CONFIG_DEBUG_FS)
 
+static ssize_t amdgpu_ras_cper_debugfs_read(struct file *f, char __user *buf,
+					    size_t size, loff_t *offset)
+{
+	struct amdgpu_ring *ring = file_inode(f)->i_private;
+	struct ras_cmd_cper_snapshot_req *snapshot_req;
+	struct ras_cmd_cper_snapshot_rsp *snapshot_rsp;
+	struct ras_cmd_cper_record_req *record_req;
+	struct ras_cmd_cper_record_rsp *record_rsp;
+	const uint8_t ring_header_size = 12;
+	uint8_t *ring_header;
+	uint32_t total_cper_num;
+	uint64_t start_cper_id;
+	int r;
+
+	ring_header = kzalloc(ring_header_size, GFP_KERNEL);
+	if (!ring_header) {
+		r = -ENOMEM;
+		goto out;
+	}
+
+	snapshot_req = kzalloc(sizeof(struct ras_cmd_cper_snapshot_req), GFP_KERNEL);
+	if (!snapshot_req) {
+		r = -ENOMEM;
+		goto out;
+	}
+
+	snapshot_rsp = kzalloc(sizeof(struct ras_cmd_cper_snapshot_rsp), GFP_KERNEL);
+	if (!snapshot_rsp) {
+		r = -ENOMEM;
+		goto out;
+	}
+
+	record_req = kzalloc(sizeof(struct ras_cmd_cper_record_req), GFP_KERNEL);
+	if (!record_req) {
+		r = -ENOMEM;
+		goto out;
+	}
+
+	record_rsp = kzalloc(sizeof(struct ras_cmd_cper_record_rsp), GFP_KERNEL);
+	if (!record_rsp) {
+		r = -ENOMEM;
+		goto out;
+	}
+
+	if (!(*offset)) {
+		if (copy_to_user(buf, ring_header, ring_header_size)) {
+			r = -EFAULT;
+			goto out;
+		}
+		buf += ring_header_size;
+	}
+
+	r = amdgpu_ras_mgr_handle_ras_cmd(ring->adev,
+					  RAS_CMD__GET_CPER_SNAPSHOT,
+					  snapshot_req, sizeof(struct ras_cmd_cper_snapshot_req),
+					  snapshot_rsp, sizeof(struct ras_cmd_cper_snapshot_rsp));
+	if (r || !snapshot_rsp->total_cper_num)
+		goto out;
+
+	start_cper_id = snapshot_rsp->start_cper_id;
+	total_cper_num = snapshot_rsp->total_cper_num;
+
+	record_req->buf_ptr = (uint64_t)(uintptr_t)buf;
+	record_req->buf_size = size;
+	record_req->cper_start_id = start_cper_id + *offset;
+	record_req->cper_num = total_cper_num;
+	r = amdgpu_ras_mgr_handle_ras_cmd(ring->adev, RAS_CMD__GET_CPER_RECORD,
+					  record_req, sizeof(struct ras_cmd_cper_record_req),
+					  record_rsp, sizeof(struct ras_cmd_cper_record_rsp));
+	if (r)
+		goto out;
+
+	r = *offset ? record_rsp->real_data_size : record_rsp->real_data_size + ring_header_size;
+	(*offset) += record_rsp->real_cper_num;
+
+out:
+	kfree(record_rsp);
+	kfree(record_req);
+	kfree(snapshot_rsp);
+	kfree(snapshot_req);
+	kfree(ring_header);
+	return r;
+}
+
 /* Layout of file is 12 bytes consisting of
  * - rptr
  * - wptr
@@ -507,6 +591,9 @@ static ssize_t amdgpu_debugfs_ring_read(struct file *f, char __user *buf,
 	loff_t i;
 	int r;
 
+	if (ring->funcs->type == AMDGPU_RING_TYPE_CPER && amdgpu_uniras_enabled(ring->adev))
+		return amdgpu_ras_cper_debugfs_read(f, buf, size, pos);
+
 	if (*pos & 3 || size & 3)
 		return -EINVAL;
 
-- 
2.34.1


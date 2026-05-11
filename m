Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB60CD37BE
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 19:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 400A110E8A2;
	Mon, 11 May 2026 19:29:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NzrUabWu";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012033.outbound.protection.outlook.com [52.101.48.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD0E710E889
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 19:29:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQin5Td1gl10ZTASGWyKksqms2HCjQ4ANb+udMD6A6tN3IfUfCZwASpaNSIHAa3pd5CSlmCdJjeYnl/1HWB9aWZ+E7KPjm+VQcM4wDsOpRBqD1Bgz2/HjPgMz6Zf+4tuLDigIV6h5IJhxcq/z89PKsCUQQfyPzsvVJn3AoKcAlo1hFq50gOykfnpTD6OkaWnO6C0viPvzmR5tjLrADkPpzO1EBk1GflihJK7MVnwYXhYOLdNWgscZEtePYLj/vsc6OGxrYbWyZCpM6mD1U6lFe65PRPzyi0TN9ae3FwMxQvUP7Jyxc/ta0jlFFgmbsqsMyowDSSN9acUnw/ywcjOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EFOePZW6GXhRffwp3Kwpo6tm9cH3AOOA0piQkVquKzQ=;
 b=YVXzBE7sfwLf3IPkzpupAR0M8fZ7OJXrv8zrf2oOrER12JoPY4ulIhTN2QEB9cKmPjrzOEyhOZcDSylMPvrnkl/pIOZjWjPylPrBD88OKLL62V39n4RvvG0YeVwLuEm4HHwwHJ+b1CK6kMjVIqLXD2q8K/hRP2eA9KnD8bUnaC7KcN8zB82cgdwrbv1cGPS7YfC7d5Tp3cqe08xq9UxyYYYW4NDcZrmrvWFKi1PbC/xlhmAgVt2DhjQp7440wOLwVq9/uAjCHUUluPSrBK3ckzWGBnyBEKxnTkciTdIrpQ+54Pve7F13EgoZBa0I1Noo+PxlCpcESOGZ574r66RovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFOePZW6GXhRffwp3Kwpo6tm9cH3AOOA0piQkVquKzQ=;
 b=NzrUabWuz3wC3F3qfaGTWrChpZF6EWL4UEBGr9w9lB8h7QCVSfZZgsrqpZf5MEzebARJduzNOC8zDP1VVWIfXAnYDZV4FtPaBqwXfkYnQC5rvTu+pnIpQsbIqhH+fMZfZPidy7u0n0bopFaH4jZ9b5uuus5/DgwJarkbdhe4dEk=
Received: from MN0P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::25)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 19:29:24 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::60) by MN0P221CA0021.outlook.office365.com
 (2603:10b6:208:52a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 19:29:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 19:29:19 +0000
Received: from MKM-D1-FRANKSU9.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 11 May
 2026 14:29:18 -0500
From: Chenglei Xie <Chenglei.Xie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <jeffrey.chan@amd.com>, <zhigang.luo@amd.com>,
 <alexander.deucher@amd.com>, <chenglei.xie@amd.com>, <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: bound SR-IOV RAS CPER dump parsing against
 used_size
Date: Mon, 11 May 2026 15:29:12 -0400
Message-ID: <20260511192912.55862-1-Chenglei.Xie@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|DS7PR12MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 83bc65d3-c191-42ff-3475-08deaf9398db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: 3QZrxo4nc2WEBFfoSyEUZOVF/uIpCAo6pKxy+rOSUJIgcFHF/zMyYZNSiR2DQxVdL9fcFMZjfkdX0CDqvXR0DQscC70XAQtuocKbr4Wg0mIc1fBF4B05BePWIuNRhWe1IJv3ZWOxv3omFFPW7uPqoVN50iqLGgvW05Q1Ekv1rpJ2nh71Rg2VwSKJSDu3N1S7T7rcSyPpTWFvSgXPLIy3n7fPPAtquruPruXPB97aApBJQN4F9K34XWOhlDxvwkxDpDSnUWpa8zBqp/HlSL55Pw6YSEN7T4uAMp1KV/QotzjsfBeQnEQSRolpuLMzOTzh9XS0sjclPi9ak2rn8WWCG7I4B/1YWcss5wZmsDAPJ51tA3AqMSh9TsqR6R1+/5o39jhsqIFr9UTrQZCMA8WDVtzEtJ+2GHQyDmMnUFo47TqCVvIyS3Q2m1tpnwD0eVxF9EKCGkI5v04DLGfr/s9xKkQTcjaix0Vk2rSTDqZPS3aCe28OEnK3MpUGtmR/8ptC6JSBvGBjbVC2usr/dRPhMnivmW6fIK6XdHS3koxvdoAj8J/8QM2l8jvC1HHX43CUR9JtUALg2BD9u+K4NbabbIVTLto1Z5fFYqgFgpwFENjvYngs3EEpvyfH8EV9KwdS9bwXcXWLxR+TzDAiP/6gTx5QWQui7XjuTqn9VvWmCLu7oCQpEkd+2xhWs88XRjqMtGOmcHK+D7132xEMv/ZXEXQKhANwxgR6q+rphovN2wU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XyrvDc5YEwvLwCYhoMQn6ahCsV4P3RogrZ0VbXb9DQSqLv9qUMNFwNpEn2Nb/wAQVXvgQJdpD1st39eEZ/Yr0YrgrW70PByfsDCmpHQl6SLdYhgsGKSvFOKbyEX6lkaoRUq4xfZ1dHeyEu8FGi3yxshSH9R3ZbarWhCTlxeGHyIvWtiWriMCqD1Dxv+IwQxU6uYg1hkmmO0Eya7bhDrVoEF+ThXjWCgHnKCZJTcguw1rcK3sjuUt++aeE3O6X591af+vwbtIoOgBVuc99xdhZ5/KCBzENPmcrRuL9TkvQfLHDt918m+G3dXk5Ynmv2cFc6SUK9Rs5rwhsGahvplMdaw+QFLWTxO5e8USf/YEVaU3k2xBh/0oxjgt4akyH7KVrYkmxjchl9+Z5R6mf2/RoVgYSjP23kJS+luq4iM91s1cOx0Jvj3oAGHGIupk5dyU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 19:29:19.2309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bc65d3-c191-42ff-3475-08deaf9398db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239
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

The VF copies a PF-provided CPER telemetry blob and walks records using
cper_dump->count and each entry's record_length. count is u64 while the
loop used u32, so a large count could loop indefinitely. record_length was
not limited to the kmemdup'd region, so the first iteration could read far
past the allocation; record_length == 0 could spin forever on the same
entry. Together that allowed a malicious hypervisor to leak heap past the
blob into the CPER ring or hang the guest.

Require used_size to cover the fixed header before buf and stay within the
telemetry cap. Track remaining bytes in buf, cap iterations with u64 and
CPER_MAX_ALLOWED_COUNT, and reject record_length outside
[sizeof(cper_hdr), remaining] before writing to the ring.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Change-Id: Ic21f4523eebc6c4b4f8c6b62b84104b18cf86a48
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 6974b1c5b56c2..c8bec62bdffb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1798,13 +1798,15 @@ amdgpu_virt_write_cpers_to_ring(struct amdgpu_device *adev,
 	struct amd_sriov_ras_cper_dump *cper_dump = NULL;
 	struct cper_hdr *entry = NULL;
 	struct amdgpu_ring *ring = &adev->cper.ring_buf;
-	uint32_t checksum, used_size, i;
+	uint32_t checksum, used_size;
+	u64 remaining, cnt, i;
 	int ret = 0;
 
 	checksum = host_telemetry->header.checksum;
 	used_size = host_telemetry->header.used_size;
 
-	if (used_size > (AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 << 10))
+	if (used_size < offsetof(struct amd_sriov_ras_cper_dump, buf) ||
+	    used_size > (AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 << 10))
 		return -EINVAL;
 
 	cper_dump = kmemdup(&host_telemetry->body.cper_dump, used_size, GFP_KERNEL);
@@ -1829,11 +1831,19 @@ amdgpu_virt_write_cpers_to_ring(struct amdgpu_device *adev,
 	}
 
 	entry = (struct cper_hdr *)&cper_dump->buf[0];
+	remaining = (u64)used_size - offsetof(struct amd_sriov_ras_cper_dump, buf);
+	cnt = min_t(u64, cper_dump->count, CPER_MAX_ALLOWED_COUNT);
+
+	for (i = 0; i < cnt; i++) {
+		if (entry->record_length < sizeof(struct cper_hdr) ||
+		    entry->record_length > remaining) {
+			ret = -EINVAL;
+			goto out;
+		}
 
-	for (i = 0; i < cper_dump->count; i++) {
 		amdgpu_cper_ring_write(ring, entry, entry->record_length);
-		entry = (struct cper_hdr *)((char *)entry +
-					    entry->record_length);
+		remaining -= entry->record_length;
+		entry = (struct cper_hdr *)((char *)entry + entry->record_length);
 	}
 
 	if (cper_dump->overflow_count)
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4867ACD6E43
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 01:56:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC4F510F7B3;
	Fri, 29 May 2026 01:56:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KXSU80UU";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013050.outbound.protection.outlook.com
 [40.107.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F29810F7B3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 01:56:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2zuCVlFM6Cyf0TqieKmwCg2mYNL+m+mtfxt0EdAF/26FhGU1R1SIrgK+9snrRdibibtUAi3jh3zkT/cM2f9K8VPocHAupZjSn32UR1rieumqOaImoVsB7Cw+CRESwX45H5i9fOvgnWZ6ECFhvTpwypAQpkhezue6n4h6cdFeAJ7dqjPP1BWHELPfya2cYBvlCBBdY7+15WTr0IaYGdKq35ubJsGv6vKBIlUcjDaiZb9zH6znBY8gK4SOa2HjV7N+ZwVXEYq+PwKqW1UCf8TkllMRmpHHzw1d3RaobPDJlucwPGIRlM8MI7LSZhhjYtXHpaQ6JQEHzPtzcze3uif5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RO25M3+A5hLwM/5qOYh2rXsvBAWK3r/wl70nRrswBo=;
 b=noY4CMOGcs65itKTR9kfbIpVW12/OHYnFdUmB7pgp2O53mEucQk4K2NqQHjGOIkmcP97EVwVtA37w833HnYwUJ/0WgEVssf4N8I+enGA71Ii9jiIvzp1G2bfazIEAtN/7LCIuCw0nDYTxUamOaoE2HlzMBgtq0TWZsgkaMR5ZPn6IL3UN0shZ6BDZUVn86hMX+Hl7szawWMUzvx+jR7HQuBCG/XE9nrF7GUDRNYS48j9gsoDPCuIPrs/wSMYL/8siRpO8VA3os/2fRI4DKVjBDTfpzjVRTSoJ6lc5G9P+gKk1UtDEctXoiP+C4lYl7+w1BHp/7qrS2jYCT0+CeQNcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RO25M3+A5hLwM/5qOYh2rXsvBAWK3r/wl70nRrswBo=;
 b=KXSU80UUNOrNTdyC6NzNBrLVVNU16z2LbRfaAJftl4OAeB0qITwfAAR0XPnLzu8+LcCcAH+M3amK+NZltIAIdl7DqATdNk9rcQ+xCSqf7k3OARezP7pACcPprMwK6p6aXF6hXaXIcnSqVDu7m/spAW8NNN5yl9NmrFGcsgV8KoE=
Received: from SJ0PR05CA0153.namprd05.prod.outlook.com (2603:10b6:a03:339::8)
 by DS0PR12MB8477.namprd12.prod.outlook.com (2603:10b6:8:15b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Fri, 29 May
 2026 01:56:26 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::1) by SJ0PR05CA0153.outlook.office365.com
 (2603:10b6:a03:339::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Fri, 29
 May 2026 01:56:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 01:56:26 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 20:56:24 -0500
From: Qiang Yu <qiang.yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Pierre-Eric
 Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>, Qiang Yu
 <Qiang.Yu@amd.com>
Subject: [PATCH] drm/amdgpu: initialize iter.start in amdgpu_devcoredump_format
Date: Fri, 29 May 2026 01:55:28 +0000
Message-ID: <20260529015528.524595-1-qiang.yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|DS0PR12MB8477:EE_
X-MS-Office365-Filtering-Correlation-Id: 0329ed1c-04f2-4d32-cb06-08debd257e55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info: MaeGr/BFRsjB9n+ZzrTAX7lsEg36vwXE0naSJdtH+D9JxF2n8KXMEq7sOdqeSUqRrEPxCFFnrDel0d2PO+ED0ytUeARq9LXnCju8wDNlbIbNOvIDDZUPMOMj5j7O5E59hyoWaddIfKhIUgoIweDUlljIlWYgU5oHQuB/E+QMaUXBc1GY6Fqt9dloDXOKDnNVTV+oTZy5QWsc7w8TZ0zHc2WOYjDOW+D5qgVumihSHvW/iAFW4oVrJrY4grXg91fdK5JHqXthsd0Tl6rvtH5i7VYoUYAbl1P8MKvVJnEf92zbGn24tBmFn7wx05QavfZ2n4+ZXVJAJyI4tfciPeIi9dmhzwHYeye6FUEcdFO0wneG0CS2lpo5852inH4soVuwcvKSurQLd7OXJ036qbf5jEj3Qrpx2iIrVeyiNzNxrw71POuT83LE1qd+RB5goLp5XIwSTvYbVh8n98eavp1DmoCkeZENX4JstQGVzzIW/Fz8kw41WJCyuwYGRs6GNDX2IUWMYY7yjL1XxlUkDFmG8TnGHGbdHDFi+ptDf5ozvPF+JSyiPgwtQmwcKCdpDZOhWHvNEPs9KbULdYVuKisEOF2nQHRCeKjQxVbc5snov17wt+OhqhJsLhZro7s+VApgiCQ55dcNA/W3/8jR81x+tEx9HA/tEdOzCS9OjSVKQsV9Xr/dzENj6q1pN+6fGy6z9GJe5KVwBmBi8O73BAwzjR5CZuqFBLB3WdyQRGLq2PU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(56012099006)(6133799003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oJM0fmSD4z7Gf9T0R+NYLWucm1cV/u1usIodCUn/5xLQj36eWjUhSu60i2qhk5rzaeOPQDWwncC3bRk6dQLqpkXejaGhF5eAqNJUsbFB7eWd5UnJluXSMVH0/2tMuOvA8ALnMdNieWNWbbjRnkmlZckyjgeLs/FVAdSx7ExbE6ztDxB4sKI3XOEuOhJ5B52EAefRMVT5b6pCef99ZtKpHpY+pQGCMj0CyxT//gA8sVilP7XPvu0QErRmNgO3lINW2oxvmi4nuJfZFf9s5a9IWi1qduXaBPsqJuwcCbud+ymina7oP7PQ9XveC6Z1W7xEw46Ub0pur/VP159XtoufcKC3vl5llpTvZHaM9BXxFhSZHOWyUgb777FG2KxWJNIIl5k6ZOyeAv6whiQpAoZNeKVUnR9Xz4CAyKr0ReFkAMzSMpkfXM9NtAtJidy7sh3N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 01:56:26.2845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0329ed1c-04f2-4d32-cb06-08debd257e55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8477
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

From: Qiang Yu <Qiang.Yu@amd.com>

This fixes read /sys/class/drm/cardN/device/devcoredump/data
return empty content sometimes.

amdgpu_devcoredump_format() leaves struct drm_print_iterator's
.start field uninitialized on the stack before passing it to
drm_coredump_printer(). __drm_puts_coredump() compares the running
.offset against .start to decide whether to skip or copy each
chunk:

	if (iterator->offset < iterator->start) {
		if (iterator->offset + len <= iterator->start) {
			iterator->offset += len;
			return;
		}
		...
	}

Fixes: 4f28b4930f8e ("drm/amdgpu: move devcoredump generation to a worker")
Signed-off-by: Qiang Yu <Qiang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 46043a1479e4..63d7ef78c025 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -219,6 +219,7 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
 	u32 ring_idx, off;
 
 	iter.data = buffer;
+	iter.start = 0;
 	iter.offset = 0;
 	iter.remain = count;
 
-- 
2.43.0


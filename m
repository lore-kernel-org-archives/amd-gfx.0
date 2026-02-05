Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4967E9126C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 06:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BAF510E389;
	Thu,  5 Feb 2026 06:51:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bRgzETPJ";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013056.outbound.protection.outlook.com
 [40.93.201.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E882110E389
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 06:51:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCZPgPHuAGRnyP38aW5syotMptCqAW5VYKvGkuN0ZpkYfcZk1ctoJ5yGGRkiM15XZGNxf9pzy1p0qE/Ju6TaIM9bWCpU1d7jTN+3v3HhmOQBdL4ZHjfhWsrJ0HGZFm5IXT5hB1ROCx8MlgoR85edGvwxn/JlvSn7AE85WFx7zPqHONAsEE8JG4v/DGgVJORKNPh4zl7Zp6LNrv1pTEg/PzU9m8QhPVQvhcLkjWSQ7ueu6Q6MGNupLJiOf9EvQQTa93d3UV6xLedqKnyevgzcvpXV5DxtmVowvS4EqjfOGne3JEawKXE1w9aGG7jwnU3ZMMpxWoDQNhC69k/tw+Nt1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIuljcJuU6PAqsLHLL/4juPyfIs6TnAm7yMS67rfixE=;
 b=EbUmDCGkz7lZ1YdTsSq5+H4ikAzKyUNwGHav9Q86sRYmRQumPQ4dMKGJ+y2fxb3Jb4/H8M7TLGPkdWxlwuihg+A/k6a/TBCeHloI6BiXRPKKIm9e4jmirsvbAfCYIYBcwzNfPMn2jzZK+niiHnuAYufQK25lWLbVoFo46HrpGH4MDsAR5O3S/vKgqubV6bxvrLjgp4z3RwBrP0bQFSki+nDRe43WvEJi7URxE6cVj4afeBlTS+WPjQU64IVCs5SmHBFLtOlUqy0Z0BpwF0QietrZe84KMD449kPZZ0kbnL9RelSkypa8/n2SoJ9XC0Jn+3tSoSBA1948mtZA9u5v3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIuljcJuU6PAqsLHLL/4juPyfIs6TnAm7yMS67rfixE=;
 b=bRgzETPJfRxao9UGK0oPRvAcRS9tCSwlv2dmvN1lsiWd4wBOytZv/OpD9wBB3a7jBpvxDhoB79Jgk89sM+GSHm5AfTMmUS57V91s6rl/4LRmlQx7AA2NCuG8MXbIOJXrVFRkL4kCUwe4ww68a0jkFGrV7J7ExlezF9jZIt/W3/Q=
Received: from DS7PR06CA0035.namprd06.prod.outlook.com (2603:10b6:8:54::9) by
 SJ0PR12MB5664.namprd12.prod.outlook.com (2603:10b6:a03:42b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 06:51:49 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::32) by DS7PR06CA0035.outlook.office365.com
 (2603:10b6:8:54::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 06:51:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 06:51:48 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 00:51:46 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <yifan1.zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 07/22] Documentation/amdgpu: Add documentation for Peak Tops
 Limiter (PTL) sysfs interface
Date: Thu, 5 Feb 2026 14:51:15 +0800
Message-ID: <20260205065130.654921-7-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205065130.654921-1-perry.yuan@amd.com>
References: <20260205065130.654921-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|SJ0PR12MB5664:EE_
X-MS-Office365-Filtering-Correlation-Id: 93843cd3-21df-4d02-1a06-08de648308db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yK66FZ5Il7xRzxRVLTDyJoJwlLSxdE7iXvXuF36oXsPEYTYWZY/P4OBCWGzL?=
 =?us-ascii?Q?+TfxLi9frH+6/kyhDo6xQbSH3RmUbJauW6NwVfwDS/sesWHTujcsB2WgALit?=
 =?us-ascii?Q?3Cp2MX9JRFl0ZmLv1igCyiXnslstiJ28bYaStnSBhu55jlJ+/8CGp6yVRgoa?=
 =?us-ascii?Q?1gDKTDpxMRMLcRiGpmWQ2ha0HBflDAPmTQY0a+j3h3pd4b1QLCMlO0w3oq//?=
 =?us-ascii?Q?krgZVlEezMtlvoQF8xzrp8UQEvH/DXn7stGS1msq2eroQIlIAytCgoJVT+4R?=
 =?us-ascii?Q?cQXKjQ7gN7Ywax8597y6k9/knOU6JfG9X9H/rjdPrh0kNQAq1u4c0Nd2Pssa?=
 =?us-ascii?Q?ac9+FGz6j/uKLV7HehRO5EkgB1xDbjJdLi6iffGgB5kttpZkOHdKK1pAlpSG?=
 =?us-ascii?Q?BBQ7rmQLtguZ1B9pi4xVFHbsNf0f/LhaxJVPTwox1vUKQzKSDFGekQnp4z44?=
 =?us-ascii?Q?CvNx6jar3k3se1RM4ErIXXOV+LJ8RjrefDNitW1IQI4PQR+Sq+EehcJRpQbv?=
 =?us-ascii?Q?I4mRmu/OivxeQOybRyT1PCsrL6D8eui4socW9hvOuOQDQbVV/MhbTydin8N2?=
 =?us-ascii?Q?nCn8itDRvk4gdAHwkETBx8MhJwC8OGV5Qe3DMKhK8O/PLvQ9O1Jr+rYoaT4H?=
 =?us-ascii?Q?7BVhbaAOOPx3mCBz9N9/iIeaQad8ZxqDapknf3Zs2bwbLAcLn5nx1OpgcUZW?=
 =?us-ascii?Q?6ZZl+1Ng4SwM3uJXpce9CudK8SrMhspqjYOIkTptY8SfJqwEbsAJOXnP18hJ?=
 =?us-ascii?Q?XHF/JqbhNYZr4OOFhwmACg2v5TAmaMW/m5FPC93RyJUIECaJtLGCZ6V4RlkK?=
 =?us-ascii?Q?mSBiJ39ePoRkPv9zb6tCZdM6cT4pkZ8Mus2JeV0h7qCrCcRhGaH8/Pm+cs2l?=
 =?us-ascii?Q?mZ0FPlllQkla5yT0dCG+bqspKI6bC6UgumqYJDWrFQeL7mJivpchVQx5iirY?=
 =?us-ascii?Q?isW5lmUNOsSZdK++4bBJApcs9+Y6dXfsV0qJ1sDQw8BVlolsWiRAVW7/b2Jf?=
 =?us-ascii?Q?xcK9e/tCOwwz/vKBzZSIm1g9lE9iE9iLONUNDcA61ywmDfqpYIbVsOloS6Ob?=
 =?us-ascii?Q?Oj6wzvZLH9LWkybTz/cyDcc+tnA7KH/rY4S+U6MRB18crTG39rmfMdu+oD2X?=
 =?us-ascii?Q?6mhocLJtGvqH21NR29C0dk/FYHGt4Bkn9vnpO9pT+v5ZNZ6mIywg2zCq2GY5?=
 =?us-ascii?Q?/GmLs0g11nwEOk2vPteNJjSz2mr3408TeQxrKdd+HHOZRcUEUseXRA+/O24l?=
 =?us-ascii?Q?pL6OWTe0LrM8fjZuNcfJp0g178LZDP/VroXNkHAtYnpVB3hIjiH5fT7rqnBw?=
 =?us-ascii?Q?rGiodU8IJFhzIZAMt8WkB+vDf4uJ4a2GCQO6MKDaa3B5P8FZOD3UG57NsXYT?=
 =?us-ascii?Q?ztOMWbUYJyBR1pIX5TudrQz64VNA3cB457Y9ydx2Pzdx5Lq1sXB2oQNBZNVe?=
 =?us-ascii?Q?fEAxlhb8TDdaho4f2ahawAU6nQXZZOEBkVXehhUQNSyqJ+cJpFiF2UBN+vIi?=
 =?us-ascii?Q?PzvOgchhvTXt0FKTgVUpAbswYU2Rlm2dPNrlk32wQx8wU6Qsm2MMnRHD/bYY?=
 =?us-ascii?Q?ZhQGhq6x+ubNY8fhEqfV7KopI2Hja7QHHkj+Lte0E5WwO8t9aG+toCS5VPnG?=
 =?us-ascii?Q?/RXvXZa+MPKtOZ3LmY+Vg2R6Nn/H4WwlIpC5itoij15lin47/Q4pCVz7Z9Xy?=
 =?us-ascii?Q?0qkZAw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pqpp7XmNDN1n7014l7d07VXAGxV0jUMl1OsR+YRNTdxeegKEdW4b5tmHjD6OEb08RJ9JTBlFaVZoLuuzJvHzhsT6SbQZIjxOCT6w82TrUDoHdZrdOLlNR0zLzmExw+ZPD48vy5ebJsvrWyCeegoNOtonQ6KkiCV08HU1i/A/iM9oPr2J2Dv3GJQjlykufAeqerU4ggRaqWG4sFYoqwc2cX1sIy+hpZ0PiFVzKyifd5+qJe0NZtxqQKB8n6I1T+HrXlxhw79iqdvW5aam5cBdenHT72RcbuSGOOzhZ0UXDCLb/0yHyHtJ81HshxWfGVBxw5JvSu4ZIsTeNHu6kUwqLfdJ6OYExzB23mDFTicM5hgyb9nOc02E8ZNmOOqM3QdHkZYRLF2zS10MGlNb7ddMBjIJHNX+AXqI1MiuWuxpT/bo95KfGfLOQhCgCNU981iq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:51:48.4863 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93843cd3-21df-4d02-1a06-08de648308db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5664
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

The PTL (Peak Tops Limiter) feature exposes per-GPU sysfs files under
/sys/class/drm/cardX/device/ptl/ to allow users to enable or disable PTL,
configure preferred data formats, and query supported formats. The usage
of these sysfs files is not always obvious, so add documentation to
describe their purpose and provide concrete usage examples.

V3 changes:
 * format show will display preferred formats instead of N/A (Alex)

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 Documentation/gpu/amdgpu/index.rst |  1 +
 Documentation/gpu/amdgpu/ptl.rst   | 94 ++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+)
 create mode 100644 Documentation/gpu/amdgpu/ptl.rst

diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgpu/index.rst
index 8732084186a4..b2ab182236ef 100644
--- a/Documentation/gpu/amdgpu/index.rst
+++ b/Documentation/gpu/amdgpu/index.rst
@@ -23,3 +23,4 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA) architectures.
    debugfs
    process-isolation
    amdgpu-glossary
+   ptl
diff --git a/Documentation/gpu/amdgpu/ptl.rst b/Documentation/gpu/amdgpu/ptl.rst
new file mode 100644
index 000000000000..c7f16dea7954
--- /dev/null
+++ b/Documentation/gpu/amdgpu/ptl.rst
@@ -0,0 +1,94 @@
+=======================================
+Peak Tops Limiter (PTL) sysfs Interface
+=======================================
+
+Overview
+--------
+The Peak Tops Limiter (PTL) sysfs interface enables users to control and
+configure the PTL feature for each GPU individually.  All PTL-related
+sysfs files are located under `/sys/class/drm/cardX/device/ptl/`, where
+`X` is the GPU index.  Through these files, users can enable or disable
+PTL, set preferred data formats, and query supported formats for each GPU.
+
+PTL sysfs files
+----------------
+The following files are available under `/sys/class/drm/cardX/device/ptl/`:
+
+- `ptl_enable`
+- `ptl_format`
+- `ptl_supported_formats`
+
+PTL Enable/Disable
+------------------
+File: `ptl_enable`
+Type: Read/Write (rw)
+
+Read: Returns the current PTL status as a string: `enabled` if PTL
+is active, or `disabled` if inactive.
+
+Write:
+
+- Write `1` or `enabled` to enable PTL
+- Write `0` or `disabled` to disable PTL
+
+Examples::
+
+    # Query PTL status
+    cat /sys/class/drm/card1/device/ptl/ptl_enable
+    # Output: enabled
+
+    # Enable PTL
+    sudo bash -c "echo 1 > /sys/class/drm/card1/device/ptl/ptl_enable"
+
+    # Disable PTL
+    sudo bash -c "echo 0 > /sys/class/drm/card1/device/ptl/ptl_enable"
+
+PTL Format (Preferred Data Formats)
+-----------------------------------
+File: `ptl_format`
+Type: Read/Write (rw)
+
+Read: Returns the two preferred formats, e.g. `I8,F32`.
+
+Write: Accepts two formats separated by a comma, e.g. `I8,F32`.
+
+- Both formats must be supported and different.
+- If an invalid format is provided (not supported, or both formats are the
+  same), the driver will return "write error: Invalid argument".
+
+Examples::
+
+    # Query PTL formats
+    cat /sys/class/drm/card1/device/ptl/ptl_format
+    # Output: I8,F32
+
+    # Set PTL formats
+    sudo bash -c "echo I8,F32 > /sys/class/drm/card1/device/ptl/ptl_format"
+
+Supported Formats
+-----------------
+File: `ptl_supported_formats`
+Type: Read-only (r)
+
+Read: Returns a comma-separated list of supported formats, e.g.
+`I8,F16,BF16,F32,F64`.
+
+Example::
+
+    # Check supported formats
+    cat /sys/class/drm/card1/device/ptl/ptl_supported_formats
+    # Output: I8,F16,BF16,F32,F64
+
+Behavioral Notes
+----------------
+- PTL formats can only be set when PTL is enabled.
+- If PTL is disabled, `ptl_format` returns `N/A`.
+- Only two formats can be set at a time, and they must be from the supported set and different..
+- All commands support per-GPU targeting.
+- Root permission is required to enable/disable PTL or change formats.
+- If the hardware does not support PTL, the PTL sysfs directory will not
+  be created.
+
+Implementation
+--------------
+The PTL sysfs nodes are implemented in `drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c`.
-- 
2.34.1


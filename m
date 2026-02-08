Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53BDEF06E1
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Feb 2026 16:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A73D10E307;
	Sun,  8 Feb 2026 16:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eGxEIZBr";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1162410E302
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Feb 2026 16:43:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErkA26Il7YsnEDOQSevEOU8bUrnqC1+SdaFCgpg1nLt3HlYLNs+fviXB7Z9wGOiJ+uKVBpJsb6V+QvYxya06+XfJD3N4nTiWF8QbPktoSUDO1r8mlkWpYmIhKl3PKMU26EaKI9tHHqUvXhhvtSxCUsHlkIEpyg6XJhkhbwqkzh/vcETr+Lr1yhC9Yp5sqoVnTOc7mHbfeC2INhHzcDe0qeFj64rKBFZ/YrWIyEbFiwPcGXivK2KHkJMbsBOo5UoJHWMHa3gU9roqgakGPJfHEsiDG1LNEFo9PIZ/A+2hzTdCUJ7iismQXWCGndwWMwGbwCU6fPRZ5uyBKjUzzZBG2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIuljcJuU6PAqsLHLL/4juPyfIs6TnAm7yMS67rfixE=;
 b=y12bH/M1772hxn21JetnXyZty6XRdllZ4M/HtjozpDcfWOUWr5VrikEYgE5q8pi6/GLz0+IcqUW1qqliakQIeewyBQr7t01C1IDqNb3gp1A8IUt2nt0Dgs0XQAFAm4/ZXViCjqenUa+/EJ9Ulafu5p0scNCAl+FDz6BWWIpdxPH3r8bvj3OdwsJzRFXbeLLmpcqdmwI6RvwE2ZaGm3DrO8uLKTJP8H67eyQhCgWznW1YhhnxUkGigbjsNLPjXE+VY3c0vOT/MnO8cyAGVCUM5iU9faH9Y9QlkXBrku9J29hSHkKKfo8NO+zxEjNkhx3uKeq/DgcOynpAi/cJWo3NdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIuljcJuU6PAqsLHLL/4juPyfIs6TnAm7yMS67rfixE=;
 b=eGxEIZBrs+ujXIaWPBbW+puXW/HKpeiMVt4RggVdiUXFUti9n6y36OWZtVAJ3/YsKVuZ8wb1nBswwop9voexsIjwc1659++PRGY4GSOBhW6kVU6gKiAhfE0X+UvpBVZ7WnZBhk38DA1itW7SRuvl8eZykAtL2F6K7EkYtejVKR8=
Received: from SJ0PR05CA0164.namprd05.prod.outlook.com (2603:10b6:a03:339::19)
 by CY8PR12MB8409.namprd12.prod.outlook.com (2603:10b6:930:7f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sun, 8 Feb
 2026 16:43:43 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::a0) by SJ0PR05CA0164.outlook.office365.com
 (2603:10b6:a03:339::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.5 via Frontend Transport; Sun, 8
 Feb 2026 16:43:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 16:43:43 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 8 Feb 2026 10:43:40 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
CC: <Yifan1.Zhang@amd.com>
Subject: [PATCH v2 06/13] Documentation/amdgpu: Add documentation for Peak
 Tops Limiter (PTL) sysfs interface
Date: Mon, 9 Feb 2026 00:42:05 +0800
Message-ID: <08d213dbbd96673aa4ddeac201f3afdfcfca303d.1770568163.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1770568163.git.perry.yuan@amd.com>
References: <cover.1770568163.git.perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|CY8PR12MB8409:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4e57fc-a7ec-4ddd-e9fd-08de673138c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2wMyspbg3P+l37NTGbP6HB7fRcL6XhTQYQYbZNDkwKycTRa5Xw+FaOd2hrpO?=
 =?us-ascii?Q?x3tgf1x3DKmkyvUZVEJp+rW/YjI5HvR/80/mj4v+q3i+b+XtgfDB+RE07PZQ?=
 =?us-ascii?Q?6ZJgXW0VgjGfW0d8DSyKkRvdRMzHfdiW3INDPqZoK9g9vszjK6ubNW0Vlfg/?=
 =?us-ascii?Q?n6txnm3m8LCz7erlvb/SsdQgZB89sXM3D7ubXn0lLKIGBXviM8Q5wkj/PnJe?=
 =?us-ascii?Q?yCRTHHI5kRfiiupvLv+JKWD1j6RbFzGA4/rQhPcDxeM+32/9vQnF8NUKg/zn?=
 =?us-ascii?Q?xf7q3V3hAaoqJcIEPXXsIFx3rhcO/r7JyQlztf3S37XFiXozDGcO9U9hZsls?=
 =?us-ascii?Q?nFyAyxEUBG7ERfb/ASiddDRAbopNi5Lcy7ZT9+wcdtCrdkvsUNp+IEjuwN8C?=
 =?us-ascii?Q?Va9qU2gaBawd5sWEt1K8wLv4rpqwQN1TQ2fHHQYbCF4yv8gSuXeyMkM4eUj+?=
 =?us-ascii?Q?XCUGo2dhIZrfy+9qQ08G8ui0moRFaLhad2mY+N4t02PyfrfD/EVsgOLj1m9q?=
 =?us-ascii?Q?UDD2ImieqLTQQIa83Tk+Um+hXrBWWwWz+2IrHKM5F7sAjHhvCBJXhs7DkLlH?=
 =?us-ascii?Q?0QyexwnMISOrqlk/n9Ijeb3w2n0syLHJAXZhmKHDF2mDi78dUQBgUqSDWrB/?=
 =?us-ascii?Q?bFkcOScB/HPFz61malo0KnYFknIxj7zuCGq6wqJWbDD/uUkLWignk1zrmvpw?=
 =?us-ascii?Q?byDAQQcu+1lrQBunE04HFUUI85+DdQ70VpQFS39Y0oD+Bz0dQ+PifngeWvE8?=
 =?us-ascii?Q?kfcdvyI4W3TpCguUga9UbiAfkZP65zB4bBcbGiq215GplVu/Baqnrp1SE2pc?=
 =?us-ascii?Q?ogLOhCZfhyw/bXfqmKRMkzXwQhU5wiH+DhDt76pUUNhqrdLS+MsEb0uR16+s?=
 =?us-ascii?Q?6VMzHQe44i9svGaT/8Uy01w9WUR+zqqad2OJvd9rgt1iyxLpGGXQDDWDW6LU?=
 =?us-ascii?Q?PS0uuPTjm39XBHek42uXV6wdkZL5BtrZgVCS08+CfUruX6jZrfbxnedLBdOr?=
 =?us-ascii?Q?ALrVfL7gSCCPsCzo0lVg2ejKeNwCY//IQNZL7Ou7CJCk4ugFftorrSX0MbrJ?=
 =?us-ascii?Q?TXyODN1J9HDBURrdIi6inh386UcfvxsVHU5XA+VVP8hFr7jB23HjGNW6Kw9h?=
 =?us-ascii?Q?9fOkV9p/pMg9VAhKBa7m0oT6r5xSc+o9cjXzwWQyWqB//nE34rojlmmQvTrU?=
 =?us-ascii?Q?UyHVbYnL8Oe/atBIg+Os5AUctlHr+d3L7yRKcMShIWGAYDi5/nmR9doSI0gz?=
 =?us-ascii?Q?tDAZgb3uSTsmJk4qvov/y5l8vup0d8CmtNae2OICNNg96D+AHw3aInj3CUXC?=
 =?us-ascii?Q?nzpOYLU6ZH4bZ9bC+dAULRHObQwFRsQ0Krz7LYol5PVss9tjyZzntLSVKt/v?=
 =?us-ascii?Q?6S9i18jHe5c65ty58s2V+FEcng+LF4qToMPXPtiOE+bbiC7OXj7vksuCJuum?=
 =?us-ascii?Q?PrvVFgnVcbI1SHj8N21l9BerIOBzLVcJe6HiLhTs2Glrf7Qxa3MH4gsyGP1D?=
 =?us-ascii?Q?f6qyJMfEQuQ5FS7knEIc5AzCbaPrST2qeD9lvpDH0yuvVR9WbU3mYl2+NJxr?=
 =?us-ascii?Q?UzlDr70CEJK2lor3LUTxq0C2ibHc0c4lB9NEhytS3op7+30JeP73nEf4/oYt?=
 =?us-ascii?Q?SVIqkaTEQSUf1NSBbRgocGhxinAqldleaOQTcE+yXC//?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tooZsf8Xj2GMdNtePdplMlOfEMO/3+M/WRY1BcqjuXRyY7UdQwxDtOggswLlOLvYaMHIJsu+GEmCrKGmc3frBUWEQg3CVCYq8FlS4P7dsOkj8XPtQzlUNer1tAymrvDxVGyCJshHx8/pfH2/eqReH6XYtsQU+L859FsbujWR7ElsS2Bz7OdAYIZvA6M0yQVAsEJABGWKaXUDb5Ewy8TaxC0EW8NHYHB/6bP01DKVNX2TKVs2JqE7F5pB/HaqR8a+Tv0FltP/wzKbs+kiBIoDMp+oRr7PfYmuR8odTpPwh5clRu1i1+NbLgnS5+RuwNG0V0GsfQ46R2LNUW+uyk3ss3DanRRlVlrDQqf1IyYPo1Q11Cx8wH36kEqpIgo6E188VFgUSn+09fJMDaivaQZARpN/yoAVajJoqrl67FpVp98dKVTTVw+oRSLNfycKBybi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 16:43:43.5543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4e57fc-a7ec-4ddd-e9fd-08de673138c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8409
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


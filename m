Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1430FC369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 15:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B8FD10E00F;
	Wed, 30 Apr 2025 15:48:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gu7l7N2n";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5273610E302
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 15:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bati0UfDOhyTtKmz6aLV7Uru3UpIuDbgbhVluYZvDzjRKNkq7lSiLqVKuWQusB7RhE5v1yJAoiz0h0Y7ZoSrzDn1ChU/nOJ1BdCeljei2YullJvyTdnjVOYGHVpmB6D0TT71c8+D1QqDxmuhKlCVFU1jqpyppiXtYRLuO5v2tpEO/OW6eE1NbQzDkVrfVRYwjO8WEf9w60K2EUtvg7i2Qq43vrWinGVgcxRDyyBiy8hUBYa5xEh0nJExwH7paHlgW9H8TNzWlwcMORwqssxwxNiGmyEPEnjFiINZ41GF+QZN/cC5hhd2ekDd/OHTD8HImKmwL5uegj4hXKklaaHQeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNGAakzjb16INrbYYeCND+lWhrRHz2gYmqZWotZGyZg=;
 b=mL6JIbVXONPcugJ62f8Cct1l1PRHaUNRHuUqTiRjIpQTZinXX6B9Qyv7leRYL+lzAz5EJEp1D75gsJXEUG+Yw0NpHFl+faCAksRgKM/R4gXcC00Xs/8ocVPgb2OuEXtFQEKf1nxZYxdlSMarpyUh9iUpMpG3NLh9Qhy/ylF1SN73T+OkGLE7Rq7e62A4XCdLHeNVVlJkbQnS84CtFSff1Cr5AYWub88TOSGRNCrYbwYL1FiBPqns1jiYt95Jdm2FaKNi+Ruxi/hiKdWjCChf15XbOUYBFGAzXXCUBESRzzvnmkin4cY7AX55kNXxhMP71szBMkfVf/CViFaD2S5N1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNGAakzjb16INrbYYeCND+lWhrRHz2gYmqZWotZGyZg=;
 b=gu7l7N2nAx703HqvsfZ0rxR+N8omOGi3u0SvgzIhr0XkVvdJE+WZPat8t8ir8Cw7A67seyQdtgI05hmkk4NtZ2FxxAlvdYU/R3Kkt0mDftKbSW+IQhGqnVnFyHauP7NQf0yyfGJmD+qsd1oKQ7WlRc9TUxfMpEawFyX+r4nepCQ=
Received: from MN2PR20CA0008.namprd20.prod.outlook.com (2603:10b6:208:e8::21)
 by DS7PR12MB5864.namprd12.prod.outlook.com (2603:10b6:8:7b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 15:48:26 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::7) by MN2PR20CA0008.outlook.office365.com
 (2603:10b6:208:e8::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Wed,
 30 Apr 2025 15:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 15:48:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 10:48:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 6/7] drm/amdgpu: add UAPI for user queue query status
Date: Wed, 30 Apr 2025 11:48:08 -0400
Message-ID: <20250430154809.2665473-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430154809.2665473-1-alexander.deucher@amd.com>
References: <20250430154809.2665473-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|DS7PR12MB5864:EE_
X-MS-Office365-Filtering-Correlation-Id: aa32ac6d-7a9d-4a62-f6ad-08dd87fe7265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7FxSLK3RgxlLCsMaYOUDfD5iDhmTgGrLkTdJtxzujCcKquglrUhaXxmd+O8O?=
 =?us-ascii?Q?mhqH2CF0i9HKIMkPcuD16OuIX7jGbLneYh9uEgCgWIj2TTqtpjgZAqd8w/Lo?=
 =?us-ascii?Q?KaFMds1fqfnwlJ4z4zH6YKTB682AqKqUYmZMnCdXXvZGUsILwLwBoNLOpf4p?=
 =?us-ascii?Q?8QsXD1ZSK3C/DvpNYFtZnNTZ7dTDgeW0YJ3nr7Kt04EdKraCjIto0SylZGgp?=
 =?us-ascii?Q?H3sE2onE0TwxLtnnoPeYEoh0C0bQkuj3ipWLk8/YTxwH2fVs1zYpK+zyhoHn?=
 =?us-ascii?Q?qGkCuqd7Vs8T5IDqMhFoMwYrJawUmvQU0yNPPb0WulkN+q5jeJM6EMunfvyK?=
 =?us-ascii?Q?7qp1u9vvMJSLsfyXlEL8DQczOg4e3wz+VujefH/0vSbjsiyBnUg1F3QbHDon?=
 =?us-ascii?Q?fih31U4tBrf9dwh34aXQv2c1QincHBGaAbyeJoygRg11NbraZGV9uyaEg840?=
 =?us-ascii?Q?9eEYpSLnv7Q3Olkyktz16Y2GQJ/OMCkaeSPkP+VCHUIthiwRr45RZJ7CmL0l?=
 =?us-ascii?Q?i+3yqoO7XZEvvex8i+Uw8F05HBHS1Qjdfj6k+A4Jiaa7I5okwmnjd7dRgFZy?=
 =?us-ascii?Q?l/45ZvEx3zkf26J4zEDac3BPTa/s8zBlnLRByA8TmxvNmYBwMNahC1fdRxSJ?=
 =?us-ascii?Q?2iz+YDidh/VEiUORJdpXy0nortMN6bdJoUAJTFd/am4mAEZx6Xb/AlL4EI8h?=
 =?us-ascii?Q?A4ZqOYGaMHlStzVpAkMj7kfG2dJDM8FrD8n5hKXM/tak4MWOTXFCwhDVjy6r?=
 =?us-ascii?Q?vjDhQWxR0Fp0i2pqu4q7eXmrlILGn/wunPEOgKRnBcu8gGTuHFzn2xtUBc5/?=
 =?us-ascii?Q?YesUbmwwACjhWcWwcyvCMhAEJBRGnUddPcw6HyXBZn2AG2oEc6fXv47/Yy4o?=
 =?us-ascii?Q?YMh3C8L+plzq/QnlRAy+40LQX1U1pzqOziWgbD7T3RbRukdNLRMeC8iTPk31?=
 =?us-ascii?Q?BLGCzLTvGJC8CS6GqEfa+u0k4KTBiZ8kmdbLyjdfE39NvWWkETvsDh7Cxgbh?=
 =?us-ascii?Q?e+c/a6Qz6xc81ciQhg0NyJYcpnLegYew0nOgYimvWW2N5FfL1M7KeL908mIY?=
 =?us-ascii?Q?Sb+xhP7uAyleO3AQIJx8ct+HpTnK77+5nB+8O/1Oj+hulwpHuRJVDF+/UIPa?=
 =?us-ascii?Q?3P1ijd25qQanzMZIOXWHy2dG+8nVBqzEDWz1ke6arjkxHLAj6JNvNZ8HOnD4?=
 =?us-ascii?Q?EHT6uf81BEe2mHPd2NqeAfmruHtGWMN+qmez8CvWeR9KB6rgxz323uboYrum?=
 =?us-ascii?Q?DfBQGTkscY7rJwiHyyL2u6IanNVSkFoARrHHZzSnIBU0+p4cS/VunOmfeziW?=
 =?us-ascii?Q?KkjwuW6YOfJngcTtoqSLWrEei9PLj7DkSOUcMDfv+t05cGKEtr/LqHSIMIcP?=
 =?us-ascii?Q?tzdtOx6rzuarp/BjNZf5nJ5koA15RjYeEKoReTupQpt02pQfGITtIIdegY1e?=
 =?us-ascii?Q?qIdwazRDug5QuXJ46oQHOWfsBzvimISGEWXwhxu+1OXU+v/NL0wp7hItw1Ng?=
 =?us-ascii?Q?LEXNDFrvEbBg+lyzqhKwq3Q3eWZpx6k3bGGU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 15:48:26.6754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa32ac6d-7a9d-4a62-f6ad-08dd87fe7265
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5864
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

Add an API to query queue status such as whether the
queue is hung or whether vram is lost.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 1fd96474e64c0..56f052a10ff38 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -328,6 +328,7 @@ union drm_amdgpu_ctx {
 /* user queue IOCTL operations */
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
+#define AMDGPU_USERQ_OP_QUERY_STATUS	3
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -340,6 +341,12 @@ union drm_amdgpu_ctx {
 /* for queues that need access to protected content */
 #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
 
+
+/* the queue is hung */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
+/* indicate vram lost since queue was created */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
+
 /*
  * This structure is a container to pass input configuration
  * info for all supported userqueue related operations.
@@ -421,9 +428,16 @@ struct drm_amdgpu_userq_out {
 	__u32 _pad;
 };
 
+/* The structure to carry output of userqueue ops */
+struct drm_amdgpu_userq_out_query_state {
+	__u32 flags;
+	__u32 _pad;
+};
+
 union drm_amdgpu_userq {
 	struct drm_amdgpu_userq_in in;
 	struct drm_amdgpu_userq_out out;
+	struct drm_amdgpu_userq_out_query_state out_qs;
 };
 
 /* GFX V11 IP specific MQD parameters */
-- 
2.49.0


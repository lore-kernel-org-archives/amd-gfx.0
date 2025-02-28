Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02ECC282CD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 13:25:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EA6510ECA6;
	Fri, 28 Feb 2025 13:25:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xb7zA5iF";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2DD910E2A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 13:25:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BT6dzCrXYlCXXjYVpa6w2ulSkE4LWxApNONZVI7VWk2CxUZf8e+VeQNsYh4QmsrZMdm+lqrORjlQzsiYy4Vkye+q6SpcLiLi203Rjj8IA8H8GKUF8h+ncK0dN65os8Y1xGIB3sCYtCdpwCkm5dUxaizt3J/Wy0oXB7YW3yrhDU+m6Bu4aLwyp7LPrsomGzSQz4n05wywM3Ku9Bq89MoEst+LsYitwVA9Rg32kkXctzjZFzBklD39yMhWqwtImXu4pkPQcNRI0VeFziqzoItnbNU4jUghRL5dJgp9KaqKd0q+VSKAH5KOeAkFkbklhAnp3iLtyPs72fq2cPNK6HU8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pijp1ZD2Z4Mgbqae/o3yKX1G0vHn6u9nNUiToDQaP1w=;
 b=r8uTKJgRgxdPPKxP4+6J9WV9RNY3UgKF9bAGJCiBvTsLD/x89wCK5+YBH2mkmjYcWlMtraRZtBBk/Da1/nVMs7AYD81uY2/F8glqPTmg/e2YPbSWtW4Ukpk3Td+yN0QVBGe4gjVEoBQvhbk9pTp61Ur0CAO+aPGtXZ4NBOhC/FknFAxQlujfAUZHNArMtiADg9CixFV7CruTpbWdD+6JFQ6fHSTx27lyK9F0T6ZYq/0mVMUhZwNFtDPDuFvnV5KXBt4LxdWHthz02Wm40nRCk8H1ewz2HVSbkmOg4GgngxsVHJR2F+Q2qKqKVqM2F6Zn8uSSVIqfr6f2BZ7eQ5c3sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pijp1ZD2Z4Mgbqae/o3yKX1G0vHn6u9nNUiToDQaP1w=;
 b=xb7zA5iFbFkrpAAotpgoBkaCKondlhvPdHPntuPmQTq7aw0lWx1dsojeSARGGIjKnjVFwi3AQFmcuj5l4OL7LYRI2UaAp7VdJENHyHJfC7EPJizXN+7a12N5ME9WDIopyLp2Zs/vJJQs1B0glRvfP6qb2DlnMXVfia+BSLsLPxs=
Received: from SN4PR0501CA0123.namprd05.prod.outlook.com
 (2603:10b6:803:42::40) by DM6PR12MB4449.namprd12.prod.outlook.com
 (2603:10b6:5:2a5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 13:25:41 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:803:42:cafe::4e) by SN4PR0501CA0123.outlook.office365.com
 (2603:10b6:803:42::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.5 via Frontend Transport; Fri,
 28 Feb 2025 13:25:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 13:25:41 +0000
Received: from work.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 07:25:40 -0600
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Fix JPEG video caps max size for navi1x and
 raven
Date: Fri, 28 Feb 2025 14:24:30 +0100
Message-ID: <20250228132429.4842-5-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228132429.4842-4-david.rosca@amd.com>
References: <20250228132429.4842-4-david.rosca@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|DM6PR12MB4449:EE_
X-MS-Office365-Filtering-Correlation-Id: cc2713b8-229c-4947-808b-08dd57fb65ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?huJ9bNXlEw8aD1XKQu0nMU1NMDhpU1b4hnzpfE3Uyhi5mgEdTaDJ44s2odaZ?=
 =?us-ascii?Q?Wkd+sMbpmQAsz5i5+S9h9lGr2i2uT8FpILnKcqHzF2QLhEOVqnY5S3J6Z0+j?=
 =?us-ascii?Q?uowxuUb0oAz2x6/KjuCJZh3gfh4fSU8sQarcT8yh94CU0iAm7Zj8cnm2uJkZ?=
 =?us-ascii?Q?DOYzWURsQnTpoZsnSznDH3RjgqhGu9JdWmDmNpssu/grkFkIV7flzn6AqxGG?=
 =?us-ascii?Q?TptWMOwYLPbWdYJvsn0PwwHq6gqvTGf5l2E/wy7r4yikeT5pn4vXAJUWhUCA?=
 =?us-ascii?Q?onMDXq5PtpHLSeeNM7xz15Nv6YmSJ+VP8jcRw6DG/3um/BMwzH3TYKECCouj?=
 =?us-ascii?Q?KNmQyNT0Ume3xP1GhqvML6GOELVEN3INw7GjD3pyyybQ/6u0AdpY+fTzsJjw?=
 =?us-ascii?Q?PTZhigXVJZG5nJkVm8M0V9J3lAhNkZRzbQry2T4/mkuQoId/f3qCINvsyGlR?=
 =?us-ascii?Q?JjjH6zc7KD3SuJg7KQ+Lf1jfanoHRXJC63U6WGGNniUkCWpUgTI1U6e85A6H?=
 =?us-ascii?Q?krLfguVuqTSS/sYAHv03WsiggtC5ia+Xe0DmRQe3P+fhkV1cRGLOQVC6D5BF?=
 =?us-ascii?Q?VBRPu4/zi4OWrKjldtxybcpa58UoFRFf4lZYvvXAL7qJS5nILRy5HKFUOBJT?=
 =?us-ascii?Q?KpXXj6TStS6fg9rz5AHQKcCFdswQtTiy1taqpU3YCZU9WeCZ6rvOORUdNaiq?=
 =?us-ascii?Q?qopuDocLim78imxUU30r8/iUTyaTsuJW7EDSNy5xdV05A24eyyaDHrRx3tQq?=
 =?us-ascii?Q?RuJJdSGJrX8EU1xA30MJfep9GweZ5PtrEsPaNSuJyqKhpwVwq7GaMGwfYjGv?=
 =?us-ascii?Q?2AnWVPQdHJgFXu+90SnjQVO0SYyyG1WLE/diZKA5ZlrLBrsizyyH9wz9dfHA?=
 =?us-ascii?Q?cOKCDh8IuF97fBX/04ojNSj9g0R+DPHWMLF/dB0Ws8gNWif7mx6ciXRxCt1F?=
 =?us-ascii?Q?kxfJ4kxmL/A0tLty0EWDHjgvVf5+RDJ4LlGmZLGudXKO5aoSB8cySRX3OJia?=
 =?us-ascii?Q?CTSui2x+lGtKGP+/5833l/sFoC4X3zyrZ3Bcg+jAgSrJBJ4/M9R6KHtGzJkS?=
 =?us-ascii?Q?MAmvkiZ2bFbIUih2QHUTwQl72UJ2gn2B9Rg50veYxOwZtikR1Jh/Itxsr3+I?=
 =?us-ascii?Q?IWb9wp0Pfy7csy78UaF5Us2MQZbfwrF6LZSlIocXA3zjis0aldLAo7/0bVry?=
 =?us-ascii?Q?bov80IWAFZ9eVYI2MjBzMPhvFmfVNqHv/teXwLfC+obUV4bJI8PPMhpt6RYA?=
 =?us-ascii?Q?BYx53KbZuaU0DzA+S8v+35Gk6XvwY7p/5j4IfYKwDO8az9Cei/kwrNHWrWpe?=
 =?us-ascii?Q?65cIBzbbGwKZOCVHGRqIEcX+tOlz6Nx8WHvA+J1GhBHGAJigH4w6XbQjn7Nr?=
 =?us-ascii?Q?wqa6L4C973wAclwv0Sx0VAZ3fSa7Ov76lMk6PTMhhv7pbn0qCcjJ4RrUJMsK?=
 =?us-ascii?Q?Bd9+DrukJYrKwO3Dv/8i0LgrU0VhX+paukeE/bdwLD0df7NpGdtTucl5xDUf?=
 =?us-ascii?Q?o+WnOGg9BExzgMk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 13:25:41.4234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2713b8-229c-4947-808b-08dd57fb65ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4449
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

8192x8192 is the maximum supported resolution.

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index a18e6fb9fa3f..32b824c3658f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -83,7 +83,7 @@ static const struct amdgpu_video_codec_info nv_video_codecs_decode_array[] = {
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 1920, 1088, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 8192, 8192, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 8732f766947e..f01176da8b3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -124,7 +124,7 @@ static const struct amdgpu_video_codec_info rv_video_codecs_decode_array[] =
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 4096, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 8192, 8192, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 4096, 4096, 0)},
 };
 
-- 
2.43.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEB9C561E6
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 19:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1813210E371;
	Fri, 20 Feb 2026 19:23:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XkxPFzac";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010064.outbound.protection.outlook.com [52.101.56.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E6D010E370
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 19:23:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWV6TTDSvZJ3ydbZYMY5fUqK43F1L2oP9cuguzfVy5G2CbBypahKkSQLCcesRqRj1TgaKMnnXUwD4oMTUd3uB+ZDL5D5aVrl/aNATN8PbiSdFtysWE7a63jFwvDU3T+MFlHrK2rCIlkWT5RgwMTk+ip/VNUD5+DHcPHFL9die/GXlt9ncIdW7dviohGJBdK2a8qbRAlaJOEAdjEVENikHn7Os/KNv7Km8/nMsJxzS+AxvBCmJ4p2S9rek255SIsIVclSdM3jh5PIxONUL3UmJ+URBNQDNr9CDuWcFaSKMEtLQ9CaTX/4WBy5uQaHmgiAY9rWPObFIfUhjA4Zr+NshQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnLJYGSBLs2Dafx66XkQ0/LhZNa5TjfmJkweuSv/Jv0=;
 b=YdVUKAYLgie6LKsQZQLz3jNcfvetbCU6FNYVelXs2N+FsqxOI+HAjy7G10GUre2EFM+/etvgXw15811H+omtDv5CbpKyTD6r9o8+8WmdaSiTG3gHSl46PKnb9yzDJ0uz/HSXBH4miyCS9iZXfgLfaKRhp0PZMeXKqd96sTISwKKoBkgVJUtccmDL38xmJ1jg8pm6Nhtwu/3WJmlSk1HZ/FxzaD35xgSAkIKhRZ8B9kSTmr0NDlRuTq8nP41CP5P7UsxH+UbuuYfxO5t35Pbw8eCpd6DhU+/rywSvVBjwVGRm7PLs9doopO8XEkAJ8tKGBNKf2Uv+n95PQiFzxMfRaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnLJYGSBLs2Dafx66XkQ0/LhZNa5TjfmJkweuSv/Jv0=;
 b=XkxPFzacFt77YyqucdMb3hfNy+OR+2i3PfiYX/7HShfbRT+AeGFeP4qhM7kKV0fFcWZieJOV5n9XWI6WoeBJ1ShIS1dMqC+6ldnXokMYWDh47a/07fRRlMt1hnDF99nUfUUbg+swPbjtuR1aRlt8NezR+HHJeli5+JbcqyiV2/A=
Received: from PH1PEPF0001330E.namprd07.prod.outlook.com (2603:10b6:518:1::9)
 by MW4PR12MB7167.namprd12.prod.outlook.com (2603:10b6:303:225::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Fri, 20 Feb
 2026 19:22:55 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH1PEPF0001330E.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Fri,
 20 Feb 2026 19:22:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Fri, 20 Feb 2026 19:22:55 +0000
Received: from work-495456.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Feb
 2026 13:22:52 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <Bing.Ma@amd.com>, <jamesz@amd.com>
Subject: [PATCH 04/17] drm/amdgpu: implement profiler ioctl
Date: Fri, 20 Feb 2026 14:22:23 -0500
Message-ID: <20260220192236.3121556-4-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260220192236.3121556-1-James.Zhu@amd.com>
References: <20260220192236.3121556-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|MW4PR12MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: fc5ab950-2b7a-4040-4bdd-08de70b57316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+DbeqZnBa6p1J7p0TK8C39MmR1o4mxf2tZiXlqXRQTuxbUNLKeAqeQMEvVlG?=
 =?us-ascii?Q?8qszu/5jLzs82r9YTmYNeLsJHiVaAJfHHSZbxBu4F7WukI49+6m5GZ1lqH4V?=
 =?us-ascii?Q?Vn9bYIR4LXGXsJwhczw0XEJHSiI86Q+cbi5fQeqbESxayR/DeWC1YoGyuz7D?=
 =?us-ascii?Q?ICLurZGuYkG+CkD/C1P322v+PkqL9veEfGssmdzz+/psN+gC+BVxhyIv4cJV?=
 =?us-ascii?Q?1gCuU3d5cTaTkJk8yqvaMS4RJJS4nUiWGRodRAHF0P/Vhmr1xUT+LPnKoq2d?=
 =?us-ascii?Q?jsExxGJR+Qt3kKnFfJZwtNR5N/EiQhm+xc4NtA77kdtD45afGqPk28v/5HXH?=
 =?us-ascii?Q?Yl7t+wz6acQ77JweBW+eus3ZzbGSqgTJnVKO0hgXVbSw9RVxDHAnn6Ds69ys?=
 =?us-ascii?Q?UflbFh4B+/xB7/N1qzXS9kHtmlw6vmTB3NQ5MtfdqgYI3E6enZtCA0LtSSMj?=
 =?us-ascii?Q?8JxQ/CnmfCiLrIxgmCI1Yfzq39uQV2wcGD7nUMdqTrvU5RPIWU/7fsS0kHUp?=
 =?us-ascii?Q?xLQgTMZ4G8M7Bu0zD+wvUp4awtMpCNYOns1HTI+QGMhopmNEy4M7ORA8+uJk?=
 =?us-ascii?Q?VgwzrAtZyYhXpCkk5Fm6L6+PrTxBZ1DxjjhsmDHomCzf9ILfPU+xaS5h9j6a?=
 =?us-ascii?Q?H5Y/lwWxMfCyQN+CuhlrDKZ6+Yuy1sSmxSxitg67Fg9Kk/u0EETI3HMPDHNv?=
 =?us-ascii?Q?GOpXj4/aZRvQOhFeRUS8lxdZmI8Frq3fMnh5QE/z/WIFXZGx1tqiamK3AZ/s?=
 =?us-ascii?Q?Hf4S3DLhD/E5qIQQhS7vx9YmJKVKgXDAjraI0j+7YeQKGIDeusHyCkufEtaO?=
 =?us-ascii?Q?U+sOkhQVdUbZRSwN1In14kxAGzuQvbSPxIIx3mMzh4MoQI8pcBsDqcCPx5g3?=
 =?us-ascii?Q?V0fVHZ+9532a8hWqTvmzyMTW5k+EWt7GXLFGq1l5R37SGJJD+yCREe40svmF?=
 =?us-ascii?Q?m7sf4vwYDtx3XnXjqpZCpJFUDS4mT2NMhz03hmryebci+6+WeNtjRZ7CIK5p?=
 =?us-ascii?Q?9PObgTXWFzKaLWbMHCMjVQLEom9n1J4C++62d9g78R/PW0QpeIhE5933tRAh?=
 =?us-ascii?Q?3f9OixCn4HJdlmJt1oPJHzLzvjfePTm1g8fAuHL0By+tBX64w9Eem+fLoEjk?=
 =?us-ascii?Q?2GSbab94AuUZcfkZGnjYXgPUPdjwpOdqUESZajii9WZWnnIuFXKV/uoePPma?=
 =?us-ascii?Q?c8fK1xSgQ9/8iJZYSe9qY3jU637PDzlzYXVksaxOxaFMFQGbkwgd6KcK1/mI?=
 =?us-ascii?Q?ACxTg0rMMpWOL8dR3It2NVZedRV2jGtEN5PA2vwUELwEGXXZ+BnxVSfWwWnP?=
 =?us-ascii?Q?vxH8q5LM9a7v3C8nPYurR4cVvveVDYg2wvftaCbFma1lU9rj8SvtNVtzjzD/?=
 =?us-ascii?Q?8BuKVnpbgbExCr83XaUv+KcIRDDhAyWHVe0i9qfZuH1/BBv+d6xtj/BrP7ZL?=
 =?us-ascii?Q?+VD7edrhEj+UMtMprL/1NJznZeM8QTojOyXk7WtCLA5lZHLhBBd1wlv4YG9P?=
 =?us-ascii?Q?6mg1uO8zb1WzPuXSmmH9I8mIi+gZF48G+on/R/Pjl+hADsRfX+BM0TwUNM96?=
 =?us-ascii?Q?6VhjDuBwMHJbaDhtnI5iq6brf7tn938TIxbDZ5NnnmglxiTEzzk/84sIoplK?=
 =?us-ascii?Q?8GRiWjNesn9rIXXVpwexcK3GqdkN6gCl/zgEJVS4wmn1FeDLwF5lQO10HPNf?=
 =?us-ascii?Q?a2yLeg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VIunL9VTgz2sxgk24CmJ3R8RBYoSWGWyMLaDs7bhNz8FTQRNzapTZ3tlOtI7pzDXi86oD7LaC14H+3lLZn4a4Alb1Bd1v+LZfH1/a6NHFpJzqWPlDxn7vC6bzbMXKZcZuy/PGvK/eoX+kB9E/d6xg04eP08+0gFXv7iF+TymbFMkGWzPnbRVi+rves2Fwp6dOCGct232a2E28UMXPF9AuFC1NYMugR16In2CDvINYSvRxcRwujCG+HCt2kciFT4V1jou+cDXcBjr2/7I75g8O1zFekx1iNxnGaZ0ErEZyoGk1jgozx8/vYrG8S71mhyU2ORw2uGmQ7D3PqTMtK7RCymk+xM45UrBV1yXbB3XbZrcbxX9eaPx5239fGT1dfdSxAwU0jZ7M1Ol/QC1pWfzNWQS0zOAPD5Mm765VJkL8hUydRG73UUKrGu05A7iVWmU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 19:22:55.4473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5ab950-2b7a-4040-4bdd-08de70b57316
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7167
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

operation AMDGPU_PROFILER_VERSION.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 25 ++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ed58931de804..18d83f0c47a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3045,6 +3045,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(AMDGPU_PROFILER, amdgpu_profiler_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
 };
 
 static const struct drm_driver amdgpu_kms_driver = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
index 98c04ab01132..5e4a1c36198c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -32,6 +32,31 @@
 #define AMDGPU_PROFILER_VERSION_MAJOR 1
 #define AMDGPU_PROFILER_VERSION_MINOR 1
 
+int amdgpu_profiler_ioctl(
+		struct drm_device *dev,
+		void __user *data,
+		struct drm_file *filp)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+	struct amdgpu_device *adev = fpriv_to_adev(fpriv);
+	struct drm_amdgpu_profiler_args *args = data;
+
+	dev_dbg(adev->dev, "Profiler IOCTL op %d on render node %d xcp %d",
+		args->op, adev->ddev.render->index, AMDGPU_XCP_ID(fpriv->xcp_id));
+
+	switch (args->op) {
+	case AMDGPU_PROFILER_VERSION:
+		args->version = AMDGPU_PROFILER_VERSION_MAJOR << 16 |
+					AMDGPU_PROFILER_VERSION_MINOR;
+		return 0;
+
+	default:
+		dev_err(adev->dev, "Invalid option: %i", args->op);
+		return -EINVAL;
+	}
+	return -EINVAL;
+}
+
 int amdgpu_profiler_mgr_init(
 		struct amdgpu_profiler_mgr *prof_mgr,
 		struct amdgpu_fpriv *fpriv)
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D97C7EE32
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 09:52:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11E6910E34A;
	Mon, 23 Jun 2025 09:52:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ctJV5vYt";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1D4410E346
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 09:52:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVrDydRY+sQhcfmDOBO7/B8G/bYGShFP+Lk2Co+XJ857QkltVTm8wBaomTMEDCLGhGtCczlr83PVkkVC682+JZHhpglB2wP9wPMvP/pUCCDVL39sGpZFppMzoxJKTWV8Df/Cw9I/jqp0Mr5tvUMD4nTP7i9jU63fkkHS4BXVhxPYh3l0Ij5E4u22tI9dYD+YLN8yHlZERBFzbt3exS5Wj3ayqfrstv6VYFvQ+JBXqAo3jCzcWx/cjDWQ7X19r4dMhXCUi0eaowuuR+5qodG1PtTodbkl2JJLhqTUBdoxMP0o40PDFF6/1Qj0stjAuYWXzd0GkTJXGLinRGwylhP55Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pznexdbHZ8oLlfgIYp2aBkqZRQl/Y2fszZ/OxiPjWWA=;
 b=u5pLLbuWBFphit1wBjRQL3KDnP5nX1lq099j3FiWIRN0VjyyP+BVlnVMJH1r4yjdNHpaz/BcxKMze2ZSDZ+pExC2OPcNOrrG2hdBPd/CpIrfW/sxzodGyclQVssCdO4DsrgF0RlCrMTaof7eKBs1ly0Xd/IUS6GBw/7U2f+8cTjzEtSWhPUvJElMmdce3cbnT3m7j53i2oGoo2yWI8TwQyR/9jG2UrNC7jqz2sDf90QukHSTOHl9a6taa+fYcMuDtDpohPLx6ONb0jOw82zeRDAFomB58vs52NFWlpC2q7AjQhf0QSLeowm8nmQeslW/I2sV9D5Gudywt3o4orbM7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pznexdbHZ8oLlfgIYp2aBkqZRQl/Y2fszZ/OxiPjWWA=;
 b=ctJV5vYtc4J3dbW24omjn2+ar7Sc7iZ/AXF9xdiNddxUKw/W818XsO8VNm0lXfBw6g9OTt5Z2kPYNDYzsXH8WGhTnLVNFBODn8/iwaAwFrZuj+4q/pokyQRwCWX2H1W2iTOPX2V0pCgJRXPbsj4bsI4muioif7ek8fVr99Uu650=
Received: from DM6PR17CA0018.namprd17.prod.outlook.com (2603:10b6:5:1b3::31)
 by BN5PR12MB9509.namprd12.prod.outlook.com (2603:10b6:408:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 09:52:14 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:1b3:cafe::54) by DM6PR17CA0018.outlook.office365.com
 (2603:10b6:5:1b3::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.28 via Frontend Transport; Mon,
 23 Jun 2025 09:52:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 09:52:14 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 04:52:12 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v3 06/11] drm/amdgpu: track the userq bo va for its obj
 management
Date: Mon, 23 Jun 2025 17:51:49 +0800
Message-ID: <20250623095154.1150830-6-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623095154.1150830-1-Prike.Liang@amd.com>
References: <20250623095154.1150830-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|BN5PR12MB9509:EE_
X-MS-Office365-Filtering-Correlation-Id: d4691dd7-a979-4e0d-0800-08ddb23ba1a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OwTJD18xR7cxdikGNppw50W5IB+spF/PNTpoev5dr4xRGBxV780Mwxdy4wWn?=
 =?us-ascii?Q?XpFjj6cWVLksZDPNLR8smgvOGAKHwrPvazpKpXIUwq1DIDVU5+Ox+YEF0BSz?=
 =?us-ascii?Q?hYEfzqwwfNi0HI/V+Or0G46i4NknRZ3OUDXOyJG4axYQYC/3ikeqVwTKwHz6?=
 =?us-ascii?Q?0cRbK0D4o4q1fYB26pOMe1tnCGHp6v1O3+88L4ikIoofqfQXEehrNPQJMQTz?=
 =?us-ascii?Q?dIxHMY46O0qkK6dxs7JnoUJWOtfEf2zdQ1Xd5L9aJC9lGcuLe5RB/rsvzWux?=
 =?us-ascii?Q?DeiFzfKDJg+MuCAXYpMxXG69t2FJNgsmiq8DmAxjQ9+ymrF0Eu16i6LdFo2B?=
 =?us-ascii?Q?Ea/UcSzyoiTKgPADViEsshthC1uAP24DNP1vV2hn58Z2ugAbXIdG7Z9ZE2yR?=
 =?us-ascii?Q?xcsKR5zWQnBaDy39l80sWI8By7K+JkvdkCgH/GoXC47+Xsc1X8t553/LEVX+?=
 =?us-ascii?Q?IPxBmYeVzJ5h63Bi3LakFWHqz15OGZRCCNltGiz1edV1S8sMZMwPh0mJHRH3?=
 =?us-ascii?Q?Y1TQRYsOrqNrokZ+NWeE0W4aWpCA/2O6zq/9VhuvqoGZryLZ9NSN1KWU+2al?=
 =?us-ascii?Q?TGYBBPieSl8VoEmfxC/JX8xfDCMVJvtWR5D7NQspgmcWwJp0fFK2KWM2pML5?=
 =?us-ascii?Q?WtUMK0RqD1llg78TpJXVQjDCCh6+mDyzUlXi4UKmzswqEYI8x1Xgf8H2jdvO?=
 =?us-ascii?Q?Hj/aFUoJBJVCHGNE4tjZkyWqZxxdyYJgfkLTyg7tYbE+/ao2vhZyLDbQqU7c?=
 =?us-ascii?Q?Zh1V8gHt2pxZwLgvnzFf1fOKy9DDYyDkOvaGOI6xbBvZ9x7i8dZrn7AUSbjj?=
 =?us-ascii?Q?Yo1uBxANCuVrISG7bt4tsnjZ3cWfir1b1sAhmzFQ3Ib4n55riezOKr+vmMSA?=
 =?us-ascii?Q?fx8CXsEUBqzovYusRD3/xB8sr2vCnccgrVbaTMMs5+q8H0OLINui5Rr8NatA?=
 =?us-ascii?Q?U3OBUNMip6SyhQGItH6enuh0SBDHsecvbfP9iedigbGyItlpsS8v5mQ1Ivdi?=
 =?us-ascii?Q?jdWMAE1+544ZMCo4ZzuZfiEtyZJ7qJUbYPXjmk/xKpMQnVqfzrZNHEGAYHA2?=
 =?us-ascii?Q?ME2pGDDa0wGw9+MNktQ0rozzZscwZuPPCGItAFFT4wDvNsLP7n3ILwAXFztf?=
 =?us-ascii?Q?yl3L7Lfkh/4ovVNHVTIIdsPpa0M7RzxNpBTPDfguahFbS5pHqq865+pMN1eu?=
 =?us-ascii?Q?v6COpd8zFdUtugKNHDZU5mLSkzKT/tfs1Vdrcpg8jQ4nrudxP6KxfDbC9UNf?=
 =?us-ascii?Q?C16a8/mQa81fXdsDMrIpTYIQTwD1O3Og/EO+9+OdffzRYyzqQsFBYgzL5jbC?=
 =?us-ascii?Q?vcI6/kvbCSj9ZbyxHlXQFQdg/Kl5W/nJgQRi+as5/qillbukBkuwz3aag0FW?=
 =?us-ascii?Q?9G+UmN0YE7jqc/YWaYDzIruezbOfNudL6p/lPaRNjbKN1BUZn5E5pvwLqmhn?=
 =?us-ascii?Q?Spwj5Ifon3McVkbVhA7XJ4bl+PpCQKxttMAjVwEd+54oK664QIYJWXP6mnAy?=
 =?us-ascii?Q?LwPJ+d36kKsw0/43wGgxp2j9HTjk4MehVrtR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 09:52:14.0619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4691dd7-a979-4e0d-0800-08ddb23ba1a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9509
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

The user queue object destroy requires ensuring its
VA has been unmapped prior to the queue being destroyed.
Otherwise, the kernel driver should report an invalidated
error to the user IOCLT request.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index cbbd1860a69a..79b263c18eb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -477,12 +477,24 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		amdgpu_bo_unpin(queue->db_obj.obj);
 		amdgpu_bo_unreserve(queue->db_obj.obj);
 	}
+
+	/*
+	 * At this point the userq obj va should be unmapped,
+	 * otherwise will return error to user.
+	 */
+	if (amdgpu_userq_buffer_vas_mapped(&fpriv->vm, queue)) {
+		drm_warn(adev_to_drm(uq_mgr->adev), "the userq obj va shouldn't be mapped during destroying userq\n");
+		r=  -EINVAL;
+	}
+
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
 	/*TODO: It requires a reset for unmap error*/
 	if (r != AMDGPU_USERQ_STATE_UNMAPPED) {
 		drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a HW mapping userq\n");
 		r = -ETIMEDOUT;
 	}
+
+	amdgpu_userq_buffer_vas_put(&fpriv->vm, queue);
 	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
@@ -603,6 +615,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
+	/* refer to the userq objects vm bo*/
+	amdgpu_userq_buffer_vas_get(queue->vm, queue);
+
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
-- 
2.34.1


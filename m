Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71114D7236A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 10:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12F7310EA92;
	Fri, 23 Jan 2026 10:11:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AhZ/szY8";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C198C10EA92
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 10:11:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmcR7IU0OMOlO0w2soGj3PAc3d0CaDMF7H1zz2lkleMFCR1HZB3csot7XcmelBLcqd078L595G0JB4gOD2i94ii+1f31EBX19YU1dva7uFgC82ko3qZP4bp7xnvwr1x0QvcbYHq1YKNjQatMVWPocxOLPVPXnLe01LvvEmUTx+cN8YipD5Mo637ZYxn+Rna8m567cSKzzeb1TU2xc7rUKPyQQrG3UOdv7jPy6hozZaeNCW2qP4T4H/fA/P8xEYVGAC9kZHjdxY+sLiEPfTgva5mTQDgj5l3iMAowZXrpkwCC2+E/OdDAap3zTfYCkrxcyirqqDc7kDWKdh/wkTqRWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4lYmfJ4fdSsqFQXoQWwCWfw0sVXfocg5zSAV15TIOI=;
 b=Yb1GF7E1dvPeAbl3J3uQmdDflC5ffOA9jPtOBGuOpuESwstI/O4BtqXGngVf6vXspFpfdMLlAqmYxWgr0BMxUvqTdhl0vz2R6QelkmdxqSIfX7V/m/gphy94DhR1LQ6mdF3Yfv4p8r1dD1w3z3v/jAtUR3RffRD/0WDGU+4CXL/aACMoMdd5Xxhv7S++Yt1iJIhfCkpOV5f8AzLS6zjUMCdo87FCYXPUEG3ikSaPuKhaY9aYLxlwe045qE8530P93HewRuHEkqAmzMaW+Tp84/4NGAkzKgwxIrKkxsS0U8x0T/39WMcXlkhB4CxLmZDg+u5pz7p247lwbfy8gKdU6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4lYmfJ4fdSsqFQXoQWwCWfw0sVXfocg5zSAV15TIOI=;
 b=AhZ/szY8+Wtp5tP9Ef+TxGTnaJmcsIX1mr0qxNKwrG1ljB08xeufb/roKdahF/6Y9MIwDkc8pTJEEah2ivxG1LNUEBQlcP+xd1X+k6SDvKIqkGaPONj9bMNxqnGmvH6RbmKoH+QxayxWK7jdHMy2WR3F44c+xsqejCiNHJWH8/8=
Received: from MN2PR14CA0027.namprd14.prod.outlook.com (2603:10b6:208:23e::32)
 by DS5PPFDB3A23D1A.namprd12.prod.outlook.com (2603:10b6:f:fc00::663)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:11:07 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::33) by MN2PR14CA0027.outlook.office365.com
 (2603:10b6:208:23e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 10:11:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 10:11:07 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 04:10:58 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 02:03:04 -0800
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 23 Jan 2026 02:02:53 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 5/7] amdgpu: Add MQD update functionality for user queues
Date: Fri, 23 Jan 2026 18:01:23 +0800
Message-ID: <20260123100219.1693990-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260123100219.1693990-1-Jesse.Zhang@amd.com>
References: <20260123100219.1693990-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|DS5PPFDB3A23D1A:EE_
X-MS-Office365-Filtering-Correlation-Id: be7a940b-fbf5-46ce-5809-08de5a67b975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p8w5Kuvo7k7+u/aqyVWOdnT+lS+oXoY5PN6mjsWcjHFkRcpArnMsSe6aRC53?=
 =?us-ascii?Q?HDRZ/n9Rb9rS8KD3EC+xfB2aiFMyIhsSi2FyNYjNc08CogSVWDA9Kvk+kHTa?=
 =?us-ascii?Q?B+XvAIKaDJ9oYK2eCpDDIAZ+frlZjsm9CLIGzcRV8woyZMty/4v5Znc02Jgf?=
 =?us-ascii?Q?kEC1NDjESQgTL03fmCtHM5ShLMLqRl0hpRem6NdUijq2M51EJ47GCBsSP3I+?=
 =?us-ascii?Q?V9EyJBFjqxnjbT1DrIN6BA8dN8DM0365YScxWho9pCbWdrWG/vH79EGMZpUc?=
 =?us-ascii?Q?pKu6KDUmF/Mw7zLSWM128KirEU/MerP2v72ow4H3T7vpcbbPUVbs/Bhk7Hhz?=
 =?us-ascii?Q?c1R6x/lBTPbEs7bhMtMHP1mY/eYWoyR3dqOxIYd/Sd7ILnaq052/PYrx2yrE?=
 =?us-ascii?Q?SLBEbfXTTT/pP2MUTyfrcas3VyBpU73RbU/bF+8vFY5Ei/7O8ULfe3eEnRHz?=
 =?us-ascii?Q?7Qc6hjTwTbOs7SdAmvpoTLLJMCl6KOV8hoslyYITMzrnX4eazNgVTYyib+3E?=
 =?us-ascii?Q?UC2kcL0VDX/YqqkCGZdlcitlj9zeCbwJfUJBWyrvioc8YOy0RSMkyQK21q0G?=
 =?us-ascii?Q?2qJgYcRT9w8q9r150wkm7wf371YOMWRL/vYioOPlyFKZYT/3Uw5oELscwYaY?=
 =?us-ascii?Q?xrEV3NAX+y9ZXs8ex9yh4jIzGvONTbOckhijyHlH8QU9cU1hnGdAkDxkQs1Y?=
 =?us-ascii?Q?nTdKxZ9GVuLpW9mJeNnJLC+MXovLU6PuyHuG2S2SyYcQoPgert3VS/aC3/ca?=
 =?us-ascii?Q?YPo89A3o1/P7Z702VzoO+fapxFL6FCOt4O3FFBvX5jUI1m0/+KoqgPQBCUsb?=
 =?us-ascii?Q?zuEUgi/3Mt/220pjohjZRr1nfmFoiqyZ5BRyRt9mGawWSQUbIPV3foxLAgZr?=
 =?us-ascii?Q?WOov1qkc4jLyBJfjk9HiZenvPBlWpA1flNyrVjdMTjvdt/x9CrVh8nO9eK8j?=
 =?us-ascii?Q?mNoYbVcfOL+IVjGEn55oM3VWGqH+iTHYBsVBE9hXvW9lKI0tBMqj/0N35B+X?=
 =?us-ascii?Q?gqESJtlURaVDS1o5clv1i55vgkOCi3VwcvJRTG56TIeh2LWAgHBowOL2U/qK?=
 =?us-ascii?Q?e/MrWBXB09rBCrH/6vmkV63FSIBneZX2spe6OKI0J4Q2Cpy8y8mzeh+e/iDz?=
 =?us-ascii?Q?POasfk7686te/2jQZdE38eoj+CPSgb5ivW4QzX1PuZHE9HgInGihCKWKT+yk?=
 =?us-ascii?Q?KpTaCnd29CGVssfswxbNkfzRvZ2h5obEBrL45JU6RdfyoMSMqUfI2wPsVB2o?=
 =?us-ascii?Q?4LHo6c10oRRn0EwghMpQgZsCRRAnod8ztEFv3m58vWtXoq+MQhJLA2hlXfm6?=
 =?us-ascii?Q?ioH4hV53kQf/wvuMDRuL/Z9vzh1dB2/IaLfUnGe+IRH7+yx3haVdZMlIkblI?=
 =?us-ascii?Q?FqmVcsKmbaaFQCwutxnOW/Ag2AruOfty4u1pYlzJGuqcdNwMqJxTGQmom7tz?=
 =?us-ascii?Q?Dc//85uX2gMQjzH89bb0Qm6AHSYw3pu+/xoY/OTTqCdBU+Eu3zhAWh2vZjeJ?=
 =?us-ascii?Q?8LwKYa9ojhF2wuCk9E/1y3pJm6rWUhE877WbH790l0mv3cAPnSmeaMlxiWz+?=
 =?us-ascii?Q?R2VgVsIf4Wl2zTNjXDYqYJ2wAjLd4wMukbkv2oiMc2JBOMZ3H/Rgw0BBl2MN?=
 =?us-ascii?Q?0VMR/TQRR3fEfp/NILiJx6gmO0S2/h2afmlI+ER9tYOnRYU10nmiUAdxK4Mt?=
 =?us-ascii?Q?jCXM6Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:11:07.2423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be7a940b-fbf5-46ce-5809-08de5a67b975
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDB3A23D1A
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

This patch adds support for updating MQD
properties for user queues, specifically focusing on CU mask updates.

v2: Return an error for non-compute queues. (Alex)
    remove the parameter minfo

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index f2309d72bbe6..0565986949bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -432,6 +432,33 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
 	return r;
 }
 
+/**
+ * mes_userq_mqd_update - Core MQD update logic for user queues
+ * @queue: Target mes_user_queue structure
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue)
+{
+	int retval = 0;
+	struct amdgpu_device *adev = queue->userq_mgr->adev;
+	struct amdgpu_mqd_prop *props = queue->userq_prop;
+	struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
+
+	if (!queue || !props)
+		return -EINVAL;
+
+	if (queue->queue_type != AMDGPU_HW_IP_COMPUTE)
+		return -EINVAL;
+
+	retval = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, props);
+
+	if (!retval && props->cu_mask_count && props->cu_mask)
+		props->is_user_cu_masked = true;
+
+	return retval;
+}
+
 static void mes_userq_mqd_destroy(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_userq_mgr *uq_mgr = queue->userq_mgr;
@@ -513,6 +540,7 @@ static int mes_userq_restore(struct amdgpu_usermode_queue *queue)
 
 const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.mqd_create = mes_userq_mqd_create,
+	.mqd_update = mes_userq_mqd_update,
 	.mqd_destroy = mes_userq_mqd_destroy,
 	.unmap = mes_userq_unmap,
 	.map = mes_userq_map,
-- 
2.49.0


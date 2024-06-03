Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B9FC25B75
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 18:13:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0747610E1D7;
	Mon,  3 Jun 2024 18:13:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xjd2C8mO";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 729C810E1D7
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 18:13:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R28pzDbJe1+rZ00bYYzlTuTsx26g5SmRsZr5fuNHnC7A2meedFHIA+gjrczVzMXo7C/E4mGWrJRaq0KbY4VKqusXvia+AEtGBVOJh4GHNW0slSKejNcxsg+fZ05jESpwFUCo33j4LXa5ezVkdjnGnYOXPMyzZSmuR8r0w57LL2ip4lPv5YigmlOmhTbXJrTZp1x0VZdjoXhAaO+jlEiZvpyFcsEuWO1NXjyJnVpP+6JvbTA+MBJ0r3YsHPvWthwEsf1GXZvbzg6VAdjbaFDSxr0ydXGiBThmznA57UhqFbP0Uu7WtWTftdd0MOYQFvMYyE/SMAMantELxQYfaN2nRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTxpyFMFzrGWR2zbOCbfsWMNDqQySYJUroCTOOdv0aE=;
 b=ZeHFWrY1Vj47b/YSQpm92Q1GdQLVZgqD3MEjWoZ5Ln4hB3tEpXu2qjGvGT37ftq5wr+/P+dkYir/jQORJF76OjXeWn21Zsqwdyw+BBkDmAS88xfvanxf/DZ8zM4B5lwGNsBuTyzg7YR2mm6SP+3TRMyfrb/CEPCdhYOdgrYPd9NnOJQKgL0Zzv9mLgkH+STQF1aL0y76PRVrpMKGVznhZlQwPB+/oYDV52if/V7TzhfWhH1E5ztQD35u2OrgtJPzQDiA4zXED6hGCeFR4kXFGXi3sF2eUydGUCqBWeK3DGT2w7AzlFxPUeeXJscUIuhS9LaZxfeMqwx2BrTcf9pkWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTxpyFMFzrGWR2zbOCbfsWMNDqQySYJUroCTOOdv0aE=;
 b=Xjd2C8mOX90nfY1WUp2BaYeeslwbJP/9UvtinU5vSS3iw17k7OrKOJJYjw7zB5kS0qY7TH2m/SeRWWJ7D0fJmQTcCfV8F3M2SLxddIKq7pnsSUBlSg7B+DoCMDiusfy/toXlFwX5+Xh18I21ipOaQlIlpdPMcs+7ZzB+St00Yj8=
Received: from BYAPR05CA0078.namprd05.prod.outlook.com (2603:10b6:a03:e0::19)
 by SJ0PR12MB7068.namprd12.prod.outlook.com (2603:10b6:a03:4ae::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 3 Jun
 2024 18:13:23 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::f) by BYAPR05CA0078.outlook.office365.com
 (2603:10b6:a03:e0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.14 via Frontend
 Transport; Mon, 3 Jun 2024 18:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 18:13:23 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 3 Jun 2024 13:13:21 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, <Harish.Kasiviswanathan@amd.com>, Eric Huang
 <jinhuieric.huang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add reset sources in gpu reset context
Date: Mon, 3 Jun 2024 14:12:57 -0400
Message-ID: <20240603181258.170580-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|SJ0PR12MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a1a73a-c5ff-4bac-9f9e-08dc83f8db77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?K2mD+6v+A5g73KUiEbgj61o9pTuyaSpfGMZcvArST0VsWX3jbh4fsQMv5VZ3?=
 =?us-ascii?Q?AqB4thwLwa2LaY7i3cyByX4KblZO3/ySM+OamCtwH9kEamODrbWg+m99Dxu8?=
 =?us-ascii?Q?m+0WjI6+Q2gfenfMcWXoIy25LR2n8J6JpTZymvzzv7tIUjDgXAP809u0yVYh?=
 =?us-ascii?Q?ZVEPm33/wVs6nEJZmSQJGeO/rjns0huarJHjdNPgql1fd8ftzeKfN4oQKO+d?=
 =?us-ascii?Q?tpPeWaIl3Kait6PkG5k65aTb9wKkSMepgX/8PF6RNRw8VFr0tZLTLr2brXt8?=
 =?us-ascii?Q?188XNZnB/UjX64txcaVBs6B/+BQmyI2bawfF3HxZG0L6oq1BNMXnzfz42Qdz?=
 =?us-ascii?Q?h2XSUP1ZlpP3x2LpnjFLbj0Es31TfXm8y5gIyVCsWu1JJUaMzaQC6/rGSCJg?=
 =?us-ascii?Q?G9vp6rI16KGGf4rj0KuzgBbe4D0/NbgZbTXOJEhF5vVFzr7uhtc9E2F+8FUW?=
 =?us-ascii?Q?gjtZIqx4goVfEBwqrM7gUmXDoBCvBTQdmCFgrRGH/VpX0wNFDzK2ve4MP5ne?=
 =?us-ascii?Q?8v3SG4Xm8eAOOx96r9i+y/3iQ3NXcGjovufkMM1rKtAB5BdjVHvltJ/vgW3o?=
 =?us-ascii?Q?dtSW7HZ5AaDAzkvl5NDz+jlF6maaMicXYn7I1TWWstfZv+lCfgUabN/rsa7w?=
 =?us-ascii?Q?g9N/NefowQbdWtwkzYnDPguFM87CO0RR4F0AlrpwI9pqGwPduXOiB1PmVcvq?=
 =?us-ascii?Q?hq3sDuU1CRbvkKpTrUfqsgtMQwlDC+7kDASGNPqSGiHIWC4zAkB6MXnvzqm3?=
 =?us-ascii?Q?oQ+ORH9cBiRM5AH5AlC5FHygyjmnAocsEK99e8DupeNHbf/Oz8WLNwrXjXdp?=
 =?us-ascii?Q?INsjD7JwZCG8f9VgD44p0Gt9/TxmgDefxvHl3hEQk/7vnBy3JpExyjvH7Ct4?=
 =?us-ascii?Q?fyOiD6JhoU50y6s9hAJnBUFE7rjv+zqzx4hpAPQvX+YxW3kLtwufrzyYoiyy?=
 =?us-ascii?Q?fOll5HkRvRt21bXllFfcmirwutMP6r4alLdh2Q/53LtLcLrDpSluWXjM0eDg?=
 =?us-ascii?Q?gl5dqiLBfiUSaEP4U6wna7E/Bb5XWTxMRag9WE+W4GV9eSs8gQKibS67NEai?=
 =?us-ascii?Q?iJ+EjlQ5EJz8A8HYL6T4cP4lV65DZ8Kea6x/dh3zJzZSRNCVWxgfO4dSsLDQ?=
 =?us-ascii?Q?+hoeTst878SMj+RFLKrkDuqHAPu7ADRgDVYYeTwGYOMPJDmhZQORwnCuoB9H?=
 =?us-ascii?Q?4xb4Q9GtCR8pkealY2aLQXbMUTTJW4LIvj/pufkf0bpHS7ghd0oSU05Li/dc?=
 =?us-ascii?Q?412DDcdsShm2ZOlh9iUmVNFpc8wttsY/0o+3/LO6K0tuBMcruHGdu9fnr/ls?=
 =?us-ascii?Q?63Vse/NfkSxPrPH1hXOQ8jJ/2dUTmeWFMqjCKPR+9pC8O7ncXibJ3Mk0ZqRB?=
 =?us-ascii?Q?yw3CPmSOwGjlOI9LtCT3NmeT3nVI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 18:13:23.5695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a1a73a-c5ff-4bac-9f9e-08dc83f8db77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7068
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

reset source or reset cause is very useful info
for reset context, it will be used by events API.

Suggested-by: Lijo Lazar <Lijo.Lazar@amd.com>
Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 34 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 13 +++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index bfdde772b7ee..f07f0fb9f827 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -160,3 +160,37 @@ void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain)
 	atomic_set(&reset_domain->in_gpu_reset, 0);
 	up_write(&reset_domain->sem);
 }
+
+void amdgpu_reset_get_desc(struct amdgpu_reset_context *rst_ctxt, char *buf,
+			     size_t len)
+{
+	struct amdgpu_ring *ring;
+
+	if (!buf || !len)
+		return;
+
+	switch (rst_ctxt->src) {
+	case AMDGPU_RESET_SRC_JOB:
+		if (rst_ctxt->job) {
+			ring = amdgpu_job_ring(rst_ctxt->job);
+			snprintf(buf, len, "job hang on ring:%s", ring->name);
+		} else {
+			strscpy(buf, "job hang", len);
+		}
+		break;
+	case AMDGPU_RESET_SRC_RAS:
+		strscpy(buf, "RAS error", len);
+		break;
+	case AMDGPU_RESET_SRC_MES:
+		strscpy(buf, "MES hang", len);
+		break;
+	case AMDGPU_RESET_SRC_HWS:
+		strscpy(buf, "HWS hang", len);
+		break;
+	case AMDGPU_RESET_SRC_USER:
+		strscpy(buf, "user trigger", len);
+		break;
+	default:
+		strscpy(buf, "unknown", len);
+	}
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 5a9cc043b858..9de8e4157a4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -36,6 +36,15 @@ enum AMDGPU_RESET_FLAGS {
 	AMDGPU_HOST_FLR = 3,
 };
 
+enum AMDGPU_RESET_SRCS {
+	AMDGPU_RESET_SRC_UNKNOWN,
+	AMDGPU_RESET_SRC_JOB,
+	AMDGPU_RESET_SRC_RAS,
+	AMDGPU_RESET_SRC_MES,
+	AMDGPU_RESET_SRC_HWS,
+	AMDGPU_RESET_SRC_USER,
+};
+
 struct amdgpu_reset_context {
 	enum amd_reset_method method;
 	struct amdgpu_device *reset_req_dev;
@@ -43,6 +52,7 @@ struct amdgpu_reset_context {
 	struct amdgpu_hive_info *hive;
 	struct list_head *reset_device_list;
 	unsigned long flags;
+	enum AMDGPU_RESET_SRCS src;
 };
 
 struct amdgpu_reset_handler {
@@ -130,6 +140,9 @@ void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain);
 
 void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain);
 
+void amdgpu_reset_get_desc(struct amdgpu_reset_context *rst_ctxt, char *buf,
+			     size_t len);
+
 #define for_each_handler(i, handler, reset_ctl)                  \
 	for (i = 0; (i < AMDGPU_RESET_MAX_HANDLERS) &&           \
 		    (handler = (*reset_ctl->reset_handlers)[i]); \
-- 
2.34.1


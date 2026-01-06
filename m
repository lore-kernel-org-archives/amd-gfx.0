Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DC7C47BE0
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 10:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD57A10E4D1;
	Tue,  6 Jan 2026 10:14:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CkaS5qXN";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010055.outbound.protection.outlook.com
 [52.101.193.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5438610E4D1
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 10:14:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zs5fO+aGTJqXnApEzigzF+fiCX7fYbYJPpOePUSf4XzMjvXEkPu9pZMBBENyBKb7mh/WhrFrGSGURhHo3qRnqXzlvYqboN3sDBA2SWdF11njiHHWywH0+2eqlVPY9uXAKyq454eHPhaNOeUKI2Ruk/bnE4fn7H1c3gk8ShCGEkfjOL7W6WCFVlTn0IQHxj6MSd8MBtfjsbMoCT3t0JjdRYpVelc4lejjy91Gmg/Rlvjxv/GjENnxW+J6+3ugSQnG37AsZprKu4yWqZfLA4/LNBrW+cdvrMtcjfvHuuy4rO8lzC8ZhsNFA8Rpxyl8TFg8RWz2Quak8fXIROPUXzbbYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJtxLOSNjNpYzgLt+zWOqSHUmBfRsf+uAuR9F5ckSig=;
 b=Er3xbczD+daqbTA5kuJ9R/OXGYjYUrRpTx9REdc60fePMsodKGqDytRMFRcTLdoZA2CUAnGyVn6mFPq2OiE98VyPZYN5JNb+mHj2xKMAfYsiDMVG41Z6V6eNfShYYBS1JzHuXBFG3oeJdtIdu6DsGVEHRr+QpgN2K+osvTT7tKov9w61HeY1mBXYj3oHnNjWYxzbK4g9j76okEs7k14ACERQWy4oOuXhkn8mJx3pG7Wn4wGMCKh2IYlBmdPi8UsRw8DnaDFmSxeKTzZZwUVqU6xUlyQgyBR9MDIaqt3apM7Xfcn91gvM4OT3LF1G8Tc0LUH4attSjTRol/h/+4mDLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJtxLOSNjNpYzgLt+zWOqSHUmBfRsf+uAuR9F5ckSig=;
 b=CkaS5qXNJPtgGftGzOriHJSAswfDVFMVJewtZ7+tY843E+PhZC/hBIy+xeckYi44zJuYcTY/GR3DSJyNjU3wRBDVSRxW2UnYnILMKHzI6CrVE8brwwe5rjkexntH9VNB+nKZ+v8tQBbEU1rwCKEg9X9KnPegPGrED4E7PAEFJTc=
Received: from SA1P222CA0118.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::6)
 by DS0PR12MB7533.namprd12.prod.outlook.com (2603:10b6:8:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 10:14:15 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::c7) by SA1P222CA0118.outlook.office365.com
 (2603:10b6:806:3c5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.5 via Frontend Transport; Tue, 6
 Jan 2026 10:14:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 10:14:14 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 04:14:12 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 19/21] drm/amd/pm: Drop unused ppt callback definitions
Date: Tue, 6 Jan 2026 15:42:39 +0530
Message-ID: <20260106101317.3856153-20-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260106101317.3856153-1-lijo.lazar@amd.com>
References: <20260106101317.3856153-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|DS0PR12MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: e88324fc-14b0-426b-8a44-08de4d0c584e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2gROha+jIGCpC0VPbDO2IsXwRB+jFztqPC09OOI/dMxhQdFWtkNYYHmO328x?=
 =?us-ascii?Q?ImKwieqKQSd98us0N9Cmg1FzNjJZOkoQJdd8kjmikaLU+ZaV8H0cOjKWeOvV?=
 =?us-ascii?Q?q/ktTj9fBioMMpx2I5AiEPZQen7GWsUJuTzbrXWDDnc/93xsBYt82M6Uv7yI?=
 =?us-ascii?Q?i+uWoicJ+obQdXoZJ2vip3HNCQ+oy7NVPpnSNBBqzkrGj5vEH0L3rtosgfhi?=
 =?us-ascii?Q?Vg+XPVuO8FAWL7LTWdNaTsCdxDC7X1wIrk/ZYiQaA7B0PghIsQ472V7B1kji?=
 =?us-ascii?Q?84wg+vtrPN4CoYSz1sZPeY67xCh972lCH1OcM1Horfp+xF0kShISg+FRj5Cx?=
 =?us-ascii?Q?aFvT8+whR0A44/SYWH1ztGWGQ1rIfGoY7+WDGLpgMjzLARgF6jw1ePPKilhK?=
 =?us-ascii?Q?9GJNa1tt1wujsWqbohn5dwGXjROlC33g7dYavLwIzrNgVvqSPsDaadwAUwfV?=
 =?us-ascii?Q?Uvh+J3YVQgc3n0UgARJZBIOjb9hLFpMMstC0O9+BjB6ZDwK2ibY9jYgAZaMb?=
 =?us-ascii?Q?7xPqhxIDpmNfYax6B0DxKU++KR7a47QBo7BZ0Bjns80yyYRZ9ig83u9GHTaP?=
 =?us-ascii?Q?1ROp1ZxeX9YMvBrcya60rEnJh0a6eDlITmQAINYzrmTKRxW3ZLcHM3HRz7JU?=
 =?us-ascii?Q?NtIrkGjmJu9SeSeqc+aBKl1BJCsgBG821ivu1wIJ5bkfSIJG5ocLPAwasaoM?=
 =?us-ascii?Q?nEEZy4ynhiTAVJyRONB6pgA0PyO+7ScnJPVanQ0GpGgI4w8CQBEM+P58n1Q9?=
 =?us-ascii?Q?CLMrIhq8MgsglkGF/vlMyd8LI2mQx9ZODD/ReILKitJPY+jRU6I8Izrt7lWc?=
 =?us-ascii?Q?B6WvM8BaHcnrgwybIvmDUJ4OAB6Oi17oUIJWVSkN1iW2sDRvbOy6PZMA98jM?=
 =?us-ascii?Q?Obsj/Gyghx7mzCMESlzawYQXoL6zugcUZ/f8xvTnOT39LPlDjXZt9lxsQXY2?=
 =?us-ascii?Q?/FCOj/+Nwa5GymxJFuJd+HonDewVsASTT1ctQPTyz2pPkCnzeAiDYnrWrBPC?=
 =?us-ascii?Q?/APuJ4Uqj4cwNcLWqZ1aH7LOnY0P2ByStVLgCw6w07Ns7Is0bNvUU2iLSYQi?=
 =?us-ascii?Q?pf65DNCL4+Vj8r4pLWVsDfvtugVxgdiaC0uKySzOaQfyc2JiIRfAdqqtHQZQ?=
 =?us-ascii?Q?++H1fP4u9GofCCyQDSPYwc9o5fqAFt7tzyXPmBwYcPqFI4irLiFqs4AS0cWK?=
 =?us-ascii?Q?qznkxQlRiRIol/Qhbmr5ExAQJwLGUnnXkozjqAb8RoX907uKslGQY1kkZ2BK?=
 =?us-ascii?Q?BDo8pRZRbiTw5OpiFWAypCsynDS009v+6xWFI7mkBBm448KIMsrWwYxt2DAk?=
 =?us-ascii?Q?IDxGb6qj8lQ7VGaGBzv1hua5ly51wtQloyLvZB4B1GEpjYr9WF7BOyB43VGb?=
 =?us-ascii?Q?i9RqG+dptFW7rDpkvuTxJ7iPtnWEhlBFoi3Epp0lsDf452kbtjtcHaaxaTKg?=
 =?us-ascii?Q?AZ8fvcMydj+rzOLyHSvqp3fTZZ75u20Hr/yYyEsjCDgCBb9+/yZwzwpOTMOJ?=
 =?us-ascii?Q?jp1zTydLod2k9MMWKxFl1by2VEH8Z9PmPtiDYPEFI7mWo9hi9PoALXUVuv5D?=
 =?us-ascii?Q?dVCuWxCuBuzPuBkFGYQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:14:14.9073 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e88324fc-14b0-426b-8a44-08de4d0c584e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7533
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

SMU message related ppt callbacks are not used. Drop from ppt_funcs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 18 ------------------
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  2 --
 2 files changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index a403e3a45e59..93c943151721 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1187,24 +1187,6 @@ struct pptable_funcs {
 	 */
 	int (*system_features_control)(struct smu_context *smu, bool en);
 
-	/**
-	 * @send_smc_msg_with_param: Send a message with a parameter to the SMU.
-	 * &msg: Type of message.
-	 * &param: Message parameter.
-	 * &read_arg: SMU response (optional).
-	 */
-	int (*send_smc_msg_with_param)(struct smu_context *smu,
-				       enum smu_message_type msg, uint32_t param, uint32_t *read_arg);
-
-	/**
-	 * @send_smc_msg: Send a message to the SMU.
-	 * &msg: Type of message.
-	 * &read_arg: SMU response (optional).
-	 */
-	int (*send_smc_msg)(struct smu_context *smu,
-			    enum smu_message_type msg,
-			    uint32_t *read_arg);
-
 	/**
 	 * @init_display_count: Notify the SMU of the number of display
 	 *                      components in current display configuration.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index 34f6b4b1c3ba..0f7778410a3a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -54,8 +54,6 @@
 #define smu_system_features_control(smu, en)				smu_ppt_funcs(system_features_control, 0, smu, en)
 #define smu_init_max_sustainable_clocks(smu)				smu_ppt_funcs(init_max_sustainable_clocks, 0, smu)
 #define smu_set_default_od_settings(smu)				smu_ppt_funcs(set_default_od_settings, 0, smu)
-#define smu_send_smc_msg_with_param(smu, msg, param, read_arg)		smu_ppt_funcs(send_smc_msg_with_param, 0, smu, msg, param, read_arg)
-#define smu_send_smc_msg(smu, msg, read_arg)				smu_ppt_funcs(send_smc_msg, 0, smu, msg, read_arg)
 #define smu_init_display_count(smu, count)				smu_ppt_funcs(init_display_count, 0, smu, count)
 #define smu_feature_set_allowed_mask(smu)				smu_ppt_funcs(set_allowed_mask, 0, smu)
 #define smu_feature_get_enabled_mask(smu, mask)				smu_ppt_funcs(get_enabled_mask, -EOPNOTSUPP, smu, mask)
-- 
2.49.0


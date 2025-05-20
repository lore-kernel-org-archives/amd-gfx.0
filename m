Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44371C54756
	for <amd-gfx@archiver.kernel.org>; Tue, 20 May 2025 04:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D040010E034;
	Tue, 20 May 2025 04:26:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NyoPeofR";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4431410E034
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 04:26:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlbJSbzDEbOK/KMjJ/VR+shzoNKlufGIY8EbYer0xkTQIjmqVY1AMt4E8tvfEFCRMvL4qQ2/Jd3QcjSce90u6sPvADtnn4BLx7fNe4TLfisDvlEFR5NnpJA83Qlzk3tKR33x0Bdc0xY94D5e8g5RqBGy+6F2g8NAGnMa2QIoiaN+dL1k8biKG5z+5Pg3k1qTg54PfElNKo34wV6gWS8J0FzBv7CuwU1Ne3sTW4XmAlW9JVVBY6Wc2nMdd7zwlCgCp/nvFnBetcI+dDZKnI+2kRgpNCwOe6r1aapiPvz7pvuLxKgmVyH49agaa8iV8IgI030tRdHIaEvcj+Y15dQG+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SlpKEnpoxym+FskoM2ZXcEjwr7ufusttaAd7p8bKEd8=;
 b=RazqbOgmnJAy3s36IEHtHiiedic0O//9Y9zNozqoqq+FLl1MA1ayiA1gc/UC+cxvw6b6PWrx+AFsLk2LCnWWCXzSqSN18ijr1ZAXKtVjF2J7TmgHiWILmyvfjVHxIlHXTPQjxXcNnftSWhACBvtnUDy8F1zesiEuTlMiSEehAvnVuv2chMSIqX/BJB13DRzhUfip2s4AcmeRFjLJ4mDT+yXvznLXrN7S91JWDB2dJYDLd9pkyr3l0YAki4578S2ilKyWjIZ+8QETt4UGjyrbJleWyXdDmNrz0SJ8NMDClzkaFtg+MxlYi97XF+iT4poJQ4FDMUTpQcQLT6XhxruHYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlpKEnpoxym+FskoM2ZXcEjwr7ufusttaAd7p8bKEd8=;
 b=NyoPeofRx8HFgy3ZndRAvm8MoZOh62EI9rZFwOR9kEXEc685NPJKJrCqcabpNv+3SNU0C31Adm/13k5lgVrzsqJO9J53W0ms/BCGlsg+JT40k+rPS2SLhFi7hV+JL7MDVPv29rtMY/XWTQW+/ElIRCKYGUxh8ceoJlu0SijZYDc=
Received: from BY5PR04CA0010.namprd04.prod.outlook.com (2603:10b6:a03:1d0::20)
 by DM4PR12MB5843.namprd12.prod.outlook.com (2603:10b6:8:66::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 04:26:05 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::f3) by BY5PR04CA0010.outlook.office365.com
 (2603:10b6:a03:1d0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Tue,
 20 May 2025 04:26:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Tue, 20 May 2025 04:26:05 +0000
Received: from amd-mlse-mangesh.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 23:26:01 -0500
From: Mangesh Gadre <Mangesh.Gadre@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Stanley.Yang@amd.com>, <Tao.Zhou1@amd.com>
CC: Mangesh Gadre <Mangesh.Gadre@amd.com>
Subject: [PATCH v2 3/5] drm/amdgpu: Add jpeg poison status reg
Date: Tue, 20 May 2025 12:25:45 +0800
Message-ID: <20250520042545.1606694-1-Mangesh.Gadre@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|DM4PR12MB5843:EE_
X-MS-Office365-Filtering-Correlation-Id: f750f6b5-8d9b-41c3-3897-08dd97566fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kb256WA7wIIXJcmZgRPNU1XfbEIZNSJucsxQgjrsxE4oPUbVOhEJ85TWvBvN?=
 =?us-ascii?Q?Bux+PqmeDWPDdG9VdX036XLXQwpWsPGgkfIkM0W30jhs+ET6T2wJ1z7fRmtO?=
 =?us-ascii?Q?w9o/0xsuv7IIu+zT9wg6uXA0vh0bY6tHAUSymDeBvDFNvbKIc69AG/COrwE3?=
 =?us-ascii?Q?A50yGzw+PC8PB20mPcXv8WZwDnC2RWgBAOkVdxszdt1lrgQvXYRMKK4Scylb?=
 =?us-ascii?Q?VyFtwegKDNFf2Q2cWimAI/iECls2qDPWVD+BSNfnpSwNtvVrkCRD29c/cLWR?=
 =?us-ascii?Q?3OX7oOlJOaWdzeXMzUb8PI1VOHA9voU/HwwuNQnpGegF7wxolLOewCOMmLRk?=
 =?us-ascii?Q?GNeEFz8iHpbKVzlHCrnaSYApTxgP+fcjPv85tTQypE9Kd6aOJDw8WSMa+pYn?=
 =?us-ascii?Q?RvJvcH89Ng/4CyoEGhQeAE7N7DyA2rSK/UlQjO1fJbEnNOw+0RU124K+7G9r?=
 =?us-ascii?Q?c6i306epRW7LT5GDQgs5+DwcJ2XkOOnirpLdVTgPoZhcGJB98urf3Pky8EqW?=
 =?us-ascii?Q?xEKQylzfDfzHkaieW9cmUxlRS2LhUaLwpXTrRnie3xNxszRTvbDRTJfIFeUy?=
 =?us-ascii?Q?lpK1QOck8g2Sfn2+FtkPaMjqbs3fq2xZv4yE3LNmMFik+xzUyxYNtXZmqneE?=
 =?us-ascii?Q?Wjv6J/eoAqvy9ftHukm0WtgiY1F0J34aHX8iKRtiI4x5ZonAgXXGJmrx5sOJ?=
 =?us-ascii?Q?kDBDcMLsvNdC8pFmLPyuwkNRYCudUavDYRIK6VrSrf3wsJWjkcUxEjzI/srB?=
 =?us-ascii?Q?4q9AIUQiARd+vTj2ZpFHl6kjHhhuQ0JqRqP2op2RWIvqCPcJZ4HEEW3vk+jz?=
 =?us-ascii?Q?LdEwi7qJTSpbOPBjDA9QyTUI7DBtjl8Ctq0B2VJMgwXEeOZ0TBz3K7NBB5HP?=
 =?us-ascii?Q?lLCxjO+dFIjjsNVCT5sPhuR55qZDSogKjLRPoAUBfjyvQh0m6+FsAFaPki99?=
 =?us-ascii?Q?Mm4rs70AUdllwYht6YJ9PP0tNDb7IoHeQh6/5kBMWmqOay6G2whtTwBQTD2B?=
 =?us-ascii?Q?elsWBvl3SFw2Mmgq/o2NDddCMWgm1r8vQb600yDNyasx8RGbX6jLP00ng+za?=
 =?us-ascii?Q?OqZWLBlEKA9i6p83KJDJT5tWW88DjdPdJ1YCgiYrKOjG9g4Qfr8+nttS+sK6?=
 =?us-ascii?Q?7hehr9dVTTj1aFmNm5+zx9rWgmpzIyo9Ega0ykDqkdNU2pVNK/TCDDD7i6q8?=
 =?us-ascii?Q?pm/tuzk/VFh67j9lXiYcQZvsrD61U1syhEGQ5LmzIOAlsSO0rR7Ise06kpd4?=
 =?us-ascii?Q?hkHdTgEDV8epYlCI1LYNYRXwS7q0DdAXbBRC2Z1Fdh1WY7G7/lyzb6eS5esl?=
 =?us-ascii?Q?xjbc3VI/M0gSZeKJVB/T8Qe2RCW6rYDXPKIaYxjPWG0ST/s3J/bc9UB1aMtO?=
 =?us-ascii?Q?fjUp1pTgIkqkXmfo/JY+Y4thk8sZScPMLnhKtz1rfttwjl0vJqWy7+i0Nrmx?=
 =?us-ascii?Q?ARd1Sb+A7YPRCTGOvREkkEklmUAdBH8BrvtrH6t2Not9NBflaGrqMwJh0aBA?=
 =?us-ascii?Q?85NMV52NNoCcAvkYCITzZqsNYehBk+BPFr1Q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 04:26:05.4005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f750f6b5-8d9b-41c3-3897-08dd97566fcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5843
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

added registers to enable jpeg ras

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 .../drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h    |  4 ++++
 .../drm/amd/include/asic_reg/vcn/vcn_5_0_0_sh_mask.h   | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h
index f45155280ff5..72a118b2af69 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h
@@ -1070,6 +1070,10 @@
 #define regUVD_RAS_VCPU_VCODEC_STATUS                                                                   0x0057
 #define regUVD_RAS_VCPU_VCODEC_STATUS_BASE_IDX                                                          1
 #define regUVD_SCRATCH15                                                                                0x005c
+#define regUVD_RAS_JPEG0_STATUS                                                                         0x0059
+#define regUVD_RAS_JPEG0_STATUS_BASE_IDX                                                                1
+#define regUVD_RAS_JPEG1_STATUS                                                                         0x005a
+#define regUVD_RAS_JPEG1_STATUS_BASE_IDX                                                                1
 #define regUVD_SCRATCH15_BASE_IDX                                                                       1
 #define regUVD_VERSION                                                                                  0x005d
 #define regUVD_VERSION_BASE_IDX                                                                         1
diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_sh_mask.h
index eb8ff9de5826..c78b09d6fbae 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_sh_mask.h
@@ -5720,6 +5720,16 @@
 #define UVD_RAS_VCPU_VCODEC_STATUS__POISONED_VF_MASK                                                          0x7FFFFFFFL
 #define UVD_RAS_VCPU_VCODEC_STATUS__POISONED_PF_MASK                                                          0x80000000L
 
+//UVD_RAS_JPEG0_STATUS
+#define UVD_RAS_JPEG0_STATUS__POISONED_VF__SHIFT                                                              0x0
+#define UVD_RAS_JPEG0_STATUS__POISONED_PF__SHIFT                                                              0x1f
+#define UVD_RAS_JPEG0_STATUS__POISONED_VF_MASK                                                                0x7FFFFFFFL
+#define UVD_RAS_JPEG0_STATUS__POISONED_PF_MASK                                                                0x80000000L
+//UVD_RAS_JPEG1_STATUS
+#define UVD_RAS_JPEG1_STATUS__POISONED_VF__SHIFT                                                              0x0
+#define UVD_RAS_JPEG1_STATUS__POISONED_PF__SHIFT                                                              0x1f
+#define UVD_RAS_JPEG1_STATUS__POISONED_VF_MASK                                                                0x7FFFFFFFL
+#define UVD_RAS_JPEG1_STATUS__POISONED_PF_MASK                                                                0x80000000L
 //UVD_SCRATCH15
 #define UVD_SCRATCH15__SCRATCH15_DATA__SHIFT                                                                  0x0
 #define UVD_SCRATCH15__SCRATCH15_DATA_MASK                                                                    0xFFFFFFFFL
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646DDE77188
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2025 19:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED13210E46D;
	Tue, 14 Jan 2025 19:54:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a4qJ6brD";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 420DF10E46D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2025 19:54:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cT9cDRFVLowubH1BpV1VOQ671ObeKMWrZQFAVFhQWRadUQdJGjvNc1JPVYo52M+X3zVCMBMuAHSBq6NsUr1QtKjlbRmRekzS148sonG1ygRifkDRxGcNZPLcTJTXgC1l9/GEhxyOQtaqy0MOWlG+1Gwe4c2DuGAxeuOqfwLayEGUh6i2yZkEzdvmGCUORssdtnMY5m6WI5nFL1LcIy4KKfVBH7cYKh6+0vbFYaCsnH1yin0DDKWruYPfNdBPvdaNB3ojLIAEkClXVqTlUhKApxgHKGiXOgfOnNhTnjr5rBsQ20Q21KcFCWC4YY46vUfvrlw52WmKLY1jlpkGJ9FwcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEoDmMao1yhh0ASG0TH3BHr8TZ+UG0Wbukx7W3SvDGI=;
 b=n9l1NfUmpIJgzVT7N4OCedXi/d0wbwN/QyiyxCdFu3/7aPRBepAqRd7wV+2kSSS1avjnEAUvojxfMKhn4Pu+/yLuTdDBXHWbP+tY4K8yNgNVPcLsy/3cpXg8C/OJvuJIHxQD/Lt5fxpuFB08njlncbCjcX5++r0eoBwXdOpcW1p0+D8bFuo1mD2Y5ZCp3dplzLtOemMXMe8fT56kyk0bvUyaYIu2xjANdY5yms1X5RJaLKtpaETXNXFSIFcjkyRWI+rYSPZSxYRJP0ybLmTIOGkM8rp1grO9TDaHWKfj+BrDWsver5cx8jNZQOdS1oRZ+dc7lPxMUpgYnRVGV43E0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEoDmMao1yhh0ASG0TH3BHr8TZ+UG0Wbukx7W3SvDGI=;
 b=a4qJ6brDxYqp+73rZdQcyBKUVplBpeaNdDc0urnT4M0p8suswMTruIzYeneRrK/xGUQRXpZfbG5lGtnklkEjsR5DlHfacbGBTS9k3dml/Ph5llRZJDxB57joKTdCPmNJxpy2ZnZPuaaVZljLooVY4cBtp6v65Qh22YHVW3fQPW4=
Received: from SJ0PR05CA0082.namprd05.prod.outlook.com (2603:10b6:a03:332::27)
 by DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 19:53:58 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::5b) by SJ0PR05CA0082.outlook.office365.com
 (2603:10b6:a03:332::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.10 via Frontend Transport; Tue,
 14 Jan 2025 19:53:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 19:53:58 +0000
Received: from elenaOnsiteDevTest.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 14 Jan 2025 13:53:57 -0600
From: Elena Sakhnovitch <Elena.Sakhnovitch@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <elena.sakhnovitch@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Elena Sakhnovitch
 <Elena.Sakhnovitch@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Don't modify grace_period in helper function
Date: Tue, 14 Jan 2025 14:52:50 -0500
Message-ID: <20250114195251.42661-2-Elena.Sakhnovitch@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250114195251.42661-1-Elena.Sakhnovitch@amd.com>
References: <20250114195251.42661-1-Elena.Sakhnovitch@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|DM4PR12MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ea2e78b-1817-4101-8f0c-08dd34d52f51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?imch4zA68tt7ct+TaQ4IMgZWxlWnBzElCVYzUF4Mcpl2wJ13TgM+2UpDaxNQ?=
 =?us-ascii?Q?GvRTysVs3fpNDRiXm1Fpzcc5GKgxvPIS0rMObGQsXzBLhoZZ0N8MCeduzRf2?=
 =?us-ascii?Q?D07W5B8C4iWSF3Ck2BJAz9Mmb/Gx+yWPAykfWetPGqF0iG5O7qvq5Uq6ue/n?=
 =?us-ascii?Q?ZtbSFY7tgJdK0rqszjqaHg6HY/j0bhWNUgDxlInmleUdwpLvwraauBlqn1Vf?=
 =?us-ascii?Q?axlxuEQol799Y8E8k0pkG5SItPPp+yohehJhqnb5h5VL/DRj8C5x/R734tgH?=
 =?us-ascii?Q?NMQB3UQTz5Vdw/L5iM0wR27n1C/L0oGp1HiyYYq/ZF6AEeV4PE/eATweCxtI?=
 =?us-ascii?Q?h8Av3um0dnNYZqJ4VsVCqHbK0kPFohJxzVYJBItTHXw6iUlrxIojLG2y3de6?=
 =?us-ascii?Q?8ERYZo1Valoj4gJMjPfZXR7nWst81ZfcfSEcyEOcHfWjMb9dW9p1xolH1OwB?=
 =?us-ascii?Q?Xa3bCMVckjJxm7ZlYlwYVFGDJd8r1g3dc+DbDFDpyZngrSeW8dcbZdbMM3Ua?=
 =?us-ascii?Q?QHPQLbrhFmlNAVByI0cX7fz6Rmsbr2OXADRGfv7UQm3zmHBmfy8tFg+twp6D?=
 =?us-ascii?Q?whAThsPlmVk92woAn9WARrTQFjr8bKcbuDBJTdO1HxyX6q22ul588KmkNNWA?=
 =?us-ascii?Q?0FBHLjzjQe6eLDc2/VEuSaqj+1jPmvMMQEaRD76/NYEKI8HUyx3QjFObIdu9?=
 =?us-ascii?Q?3LF3uEY7qylsc6t0nQvZPALCkBXr5UsXHr/jSkSobKeQwn+8Or8LiCmmA2t5?=
 =?us-ascii?Q?rMRXpxU1R67NUAaEmWBbBsj4y/eh+7lDa/gTbyaP7Qcw69psHpdmAJ2UV0aw?=
 =?us-ascii?Q?0mPvJ5Hwxw61HTUc5Tz74Bw40P4HuHpPpBgQ4gtjegTmWc1P+O6Wk/F7QKR9?=
 =?us-ascii?Q?GeKBqIQ73ieBh5sv6Vn7kFvLLiR2ZXjb10/Cp5W9vVTJpVkkw2GLJHdp7A6r?=
 =?us-ascii?Q?CH0pKAhiNkvG4LwpFzgzJY0MWuVeeOWmC5Yh81X5kesos5MjQo3VTyEPuB4S?=
 =?us-ascii?Q?fz+LSbZasMyQ5QSfWRILJcDyhUXH56wDhQRK1WUwDp3kl6H8zuuYYmVhWaAd?=
 =?us-ascii?Q?Acr6r1H0wIIwk11e9JxXckY1GKIrdZr92dH7uewAvPaDBHJuqU6XImzZIX9Y?=
 =?us-ascii?Q?aVOStHaT9jA4Qw6/DGeG3B3yqyr424fOjDqS5xLbyrGECWR25lOi7veKlCoV?=
 =?us-ascii?Q?W+Tm77JgLRn5CRkEAwhKaY1f4QrULsZSwWv+gtYUKmI6tEHuWvbH9TtNs8q9?=
 =?us-ascii?Q?jbHzN2UrbqqaAh5sH1uyBQCLIeiV+ngqoUaquZlSTJcKLPSZezttQvdMztXQ?=
 =?us-ascii?Q?76l5KSDyE1u1UJIEdCLYuwrFFfSpPpwdcKo1G+hW6uJV3vTjLjFNhYb0kDXk?=
 =?us-ascii?Q?/Sim4Q6oqp7Iw5moza9SH57dtIFK/QTm7yvtYfCoPcH5Av7BNz1P8fWzStMU?=
 =?us-ascii?Q?vUUSQxLa6sTXCSNoRYn9EByTym50OXj1j0flyIGlEBfS75qKTDeMceAFDBtr?=
 =?us-ascii?Q?hVrKyFa1w6Xr0Jc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 19:53:58.1468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea2e78b-1817-4101-8f0c-08dd34d52f51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253
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

From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

build_grace_period_packet_info is asic helper function that fetches the
correct format. It is the responsibility of the caller to validate the
value.

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Elena Sakhnovitch <Elena.Sakhnovitch@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c | 18 ++++++------------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  | 17 ++++++-----------
 .../gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 12 ++++++++++++
 3 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 62176d607bef..8e72dcff8867 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -1029,18 +1029,12 @@ void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
 {
 	*reg_data = wait_times;
 
-	/*
-	 * The CP cannont handle a 0 grace period input and will result in
-	 * an infinite grace period being set so set to 1 to prevent this.
-	 */
-	if (grace_period == 0)
-		grace_period = 1;
-
-	*reg_data = REG_SET_FIELD(*reg_data,
-			CP_IQ_WAIT_TIME2,
-			SCH_WAVE,
-			grace_period);
-
+	if (grace_period) {
+		*reg_data = REG_SET_FIELD(*reg_data,
+				CP_IQ_WAIT_TIME2,
+				SCH_WAVE,
+				grace_period);
+	}
 	*reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 441568163e20..04c86a229a23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1085,17 +1085,12 @@ void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
 {
 	*reg_data = wait_times;
 
-	/*
-	 * The CP cannot handle a 0 grace period input and will result in
-	 * an infinite grace period being set so set to 1 to prevent this.
-	 */
-	if (grace_period == 0)
-		grace_period = 1;
-
-	*reg_data = REG_SET_FIELD(*reg_data,
-			CP_IQ_WAIT_TIME2,
-			SCH_WAVE,
-			grace_period);
+	if (grace_period) {
+		*reg_data = REG_SET_FIELD(*reg_data,
+				CP_IQ_WAIT_TIME2,
+				SCH_WAVE,
+				grace_period);
+	}
 
 	*reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index fde212242129..adc7f7c78a18 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -306,6 +306,18 @@ static int pm_set_grace_period_v9(struct packet_manager *pm,
 	uint32_t reg_offset = 0;
 	uint32_t reg_data = 0;
 
+	/*
+	 * The CP cannot handle a 0 grace period input and will result in
+	 * an infinite grace period being set so set to 1 to prevent this.
+	 */
+	if (!grace_period) {
+		pr_debug("Invalid grace_period. Setting default value 0x%x\n",
+			 pm->dqm->wait_times);
+		if (WARN_ON((pm->dqm->wait_times & CP_IQ_WAIT_TIME2__SCH_WAVE_MASK)
+			== 0))
+			return -EINVAL;
+	}
+
 	if (grace_period == SET_ASIC_OPTIMIZED_GRACE_PERIOD) {
 		/* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
 		if (amdgpu_emu_mode == 0 && dqm->dev->adev->gmc.is_app_apu &&
-- 
2.34.1


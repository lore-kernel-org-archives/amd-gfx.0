Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2D2CD11DB
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Mar 2024 10:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB96910E70D;
	Mon, 25 Mar 2024 10:16:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CBBGMwtA";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 598EB10E713
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Mar 2024 10:16:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m71XuILx+Onu971rhiDl8z/pZtJoEuPfi86Z+pyfLPSzKcK6Llb3OwtyF6KOpVVDKVXaNvcqHsQbGQlCQWgI+nNdbyigfwGvPAwPPCKDISVh6QPr9NPNDwellxmRHCX6wv6PGGpo1xSISVqvplEEie5x75cSXwM9bF8zFbWb+E5BFqNszz29GuW+71R7oPkF1qgobYe8lmHFs7dqVpveNmCS+Zg0w66jT5eZGW4TKvea+tYa+eDlLy3uzcCpdMiMFyUmjfb7rPjFFuH52/Dy6zphGryoIgxEc61E8kCqwNI2VAjhLw47InvTuM9GgUgecT7XTMf38vyic658sE/OQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aY83yzXbqK7Kuj4WIg9HeWaxbeBD4J2w0DN9RmfJSM=;
 b=LqK6fC9xA88YRQMbGM34g2xeFbHVTqEoqoOKR2uDFNRSb86qe3lD2HIYekFrnVXAkYSd7gSJA5n433egtzMfqDd2f1dESA+sZVlwMmxRa+XuJVI+ZCeBcmF8TAGXsLHmtJ6NrHL8yfwGAWuXzlT1iM1EXhje1ui+kF2/pw3VKzoLvUOCeiabVex/Oq739rOrdaeqPdtgJJjrKB4/qq4gfdxK9W99Gqp7jrjC6anYebhxXDCmCKADiUdofHkjLCgEv+MXwo4QSttVoBeOx+Pm0DtToo8Ji3cB/qWoUjRLWTe0IDtYw5nWkhSqcUruXGKzRceD6HWftzG9UsG1XPqtiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aY83yzXbqK7Kuj4WIg9HeWaxbeBD4J2w0DN9RmfJSM=;
 b=CBBGMwtAX5CAUhElYs+WSh9ODEcspMo1Bt2cED2N5RNvXb6GYKHl3BSmtLPmgDOwv0TsoY3n/CEsun7XnOEsJ0rVqA2fPO0Pu6SiIfZnfHRuDOH3z/ksIHqBIlzHR+BZJlBu5+cFmSZBT6bKJBd88/xqkfMfXYpPdjTrajOOwPM=
Received: from BYAPR06CA0005.namprd06.prod.outlook.com (2603:10b6:a03:d4::18)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 10:16:31 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::90) by BYAPR06CA0005.outlook.office365.com
 (2603:10b6:a03:d4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 10:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 10:16:31 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 25 Mar
 2024 05:16:29 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH 5/5] drm/amdgpu/pm: Check AMDGPU_RUNPM_BAMACO when setting
 baco state
Date: Mon, 25 Mar 2024 18:15:59 +0800
Message-ID: <20240325101559.2807629-5-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325101559.2807629-1-Jun.Ma2@amd.com>
References: <20240325101559.2807629-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: a7409e87-593b-4264-06d7-08dc4cb4a458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4gLrpRonwsvpW4VUtzq+eYadA49PpzoOqgXwtnZce7cfELBdtKBueDTr4/s0yXk1R/0yh5J+7voA+ZVKNgJx+O6zke0bdPe4cQShkKqYWgaFQ6b+ZoYHZmgAQrwTXYgGMCzhHEPi0pi3a6M5jKtrSaoUcbElmMiU+voQICG/WemK0rMY4kLudCtQ+hAwEDDY6n1uT7A6dDbm8cay9NlSGRrtl34htxyObT8dEyLQG11JqiadzfQnvcWeEzXccBsvTTj/eLLq4/fzBIseh8DjdiEGF8q2oO8pAR+EGAPC90BaOO4FcuLgMDHwsMnyZGpkmAtSlaHRRgaIhHphF0LUyAhhikisWCAYECvcqU0W99LK1VcgDulXP5nDgbYh79pZ+C7pavtv/seG/+mWCdnH3eRT+YMTbSJyixIwNAYjdD6k3wSm9IwmMioN8+Hjxn3y3GdnxSUdtjTzCOWE70hdlvq8/1fCGISH6Cd9oZps4eB9pNTcCc5PhXLPskxju4RJJ3aNQP5zU23N3GpqpwxUpUdK6q+vECjyGui41DlBLao4ei4LJifFLqPHioVuqv/L5zwdgUQ8lKUV3VwtyWG+Kj0RjH498f/dbPgtFS4Tl9lMFweYT7m7k8zgIQet1+Cal9YJJhJWYe+OVry8erKr2MBKXOoR/hD1fPbDPcBaLqZMnWdomftxHej2sXA3M0c79fFpl81SfByF1Vj+Vh6MRMtUNF5kqLpBqH/ABtXWs82wcnq+aGrbs0fiWMoPLkBc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 10:16:31.3105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7409e87-593b-4264-06d7-08dc4cb4a458
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785
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

Check AMDGPU_RUNPM_BAMACO intead of amdgpu_runtime_pm
when setting baco state.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 5 ++---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index d0c6dad24458..a8046aaca936 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1607,7 +1607,7 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 		case IP_VERSION(11, 0, 11):
 		case IP_VERSION(11, 0, 12):
 		case IP_VERSION(11, 0, 13):
-			if (amdgpu_runtime_pm == 2)
+			if (adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO)
 				ret = smu_cmn_send_smc_msg_with_param(smu,
 								      SMU_MSG_EnterBaco,
 								      D3HOT_BAMACO_SEQUENCE,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index a65877eeaa8d..8247eeab3bd2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2247,7 +2247,7 @@ static int smu_v13_0_baco_set_state(struct smu_context *smu,
 	if (state == SMU_BACO_STATE_ENTER) {
 		ret = smu_cmn_send_smc_msg_with_param(smu,
 						      SMU_MSG_EnterBaco,
-						      (smu_baco->maco_support && amdgpu_runtime_pm != 1) ?
+						      (adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) ?
 						      BACO_SEQ_BAMACO : BACO_SEQ_BACO,
 						      NULL);
 	} else {
@@ -2292,13 +2292,12 @@ int smu_v13_0_baco_is_support(struct smu_context *smu)
 
 int smu_v13_0_baco_enter(struct smu_context *smu)
 {
-	struct smu_baco_context *smu_baco = &smu->smu_baco;
 	struct amdgpu_device *adev = smu->adev;
 	int ret;
 
 	if (adev->in_runpm && smu_cmn_is_audio_func_enabled(adev)) {
 		return smu_v13_0_baco_set_armd3_sequence(smu,
-				(smu_baco->maco_support && amdgpu_runtime_pm != 1) ?
+				(adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) ?
 					BACO_SEQ_BAMACO : BACO_SEQ_BACO);
 	} else {
 		ret = smu_v13_0_baco_set_state(smu, SMU_BACO_STATE_ENTER);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index cc7cc2a6d871..39f130035ec8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1633,7 +1633,7 @@ int smu_v14_0_baco_set_state(struct smu_context *smu,
 	if (state == SMU_BACO_STATE_ENTER) {
 		ret = smu_cmn_send_smc_msg_with_param(smu,
 						      SMU_MSG_EnterBaco,
-						      smu_baco->maco_support ?
+						      (adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO) ?
 						      BACO_SEQ_BAMACO : BACO_SEQ_BACO,
 						      NULL);
 	} else {
-- 
2.34.1


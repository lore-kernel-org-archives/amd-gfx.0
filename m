Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20777C55838
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 11:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1B6110E683;
	Tue,  4 Aug 2026 11:30:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EZs8TJJL";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012035.outbound.protection.outlook.com
 [40.93.195.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D870110E9E6
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 11:30:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B+i9QaejvmMOLc2msezVNbHlUOl5SAsL/dLxapXloEtKusZ1Gcg/MbfDuSKEV0koZ34+I7cBC4VF/eOFJKU20aFlNA7Xib6SYnh6WrOOi/71CQShn2MbVahdgC7mOJP1IyC4AJjlBucUdkNYh+aKRAHHh6YZnc/KU0KoY7WFNOVO3SMTArdJVrQCGWMn6GqZqXB5NpLOTe/7PZesc+GBk4qrDG2jzoVQuULypk2RsBNWbZwTuHGlijuk7GQuTHMmPit970bs/OrmHxHEsSJIoTW0LMZUfGzm5c6xA76DuZyCDtTp8Kg3vZ6mQxWeFLIanIvkiJD1KzZFpPA2CIXPxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ys6i6KVZxeQpiQpfqdXwNVpeVr43Ib59U6+m2rquxjk=;
 b=dLK7vuvJqyMecJB9LAIIU9cTRwEb7YLT8edfJpBSNWoGOFWgU+/E0vUUau7bnU5foMYXGb6QAFWH1wRRvEiJrK39isfOtvgT5KX/+gjrOjbserrBTcwAE3O07D678fOqKU5c+tPFqa/gBc5tHqIfG7lSAgTJZoZzVWUGfAiuuS2oLbqv9k0QfN6REsrc/tVyPjFEIUJtjP/1fYdmXTppuUwbTW8wKn7oi18FqvSCBEzIQIpGnJWelf2M0lRQwLxqhcCIkqxPWBbCgfTLahtE4bqvtq6v6fCOEsEJxcDYDYle6L7umUTYIbFx87YllGAWT23HYsSMe2zD17UoHcaj4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ys6i6KVZxeQpiQpfqdXwNVpeVr43Ib59U6+m2rquxjk=;
 b=EZs8TJJLk/f0VWBl6UDxTWwt+8USgmtvHTa4Nm035Tx8eb3754zvS9FjRKueUcYnit1xU5X/GPVhZ7CsrHz+wBgHEml9667+ibOJS3Qw/x1xiDhILAjyEBFP+Da6jJZBYH8uJzTPARjzBoAiCfWC4DR6xVITrcgF5K2HwQz3NfE=
Received: from DS7P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25c::16) by
 SN7PR12MB6767.namprd12.prod.outlook.com (2603:10b6:806:269::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.17; Tue, 4 Aug 2026 11:30:10 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:8:25c:cafe::37) by DS7P221CA0020.outlook.office365.com
 (2603:10b6:8:25c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 11:30:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 11:30:10 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 06:30:05 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: Separate PPT limit restore from smu_set_ac_dc
Date: Tue, 4 Aug 2026 16:59:45 +0530
Message-ID: <20260804112945.2974903-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260804112945.2974903-1-lijo.lazar@amd.com>
References: <20260804112945.2974903-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|SN7PR12MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b5bd22-6653-4fa4-f0eb-08def21bbe37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: W7ca73MSy58Q9xqiHg7Q4mNNCqg7iQfoyBtUu18VCzLIaFVe9M78h8gXDOMT43Qsc/KWM0QfVAN1Q1LENNF8xBcY1NK7OMLjLitK/2rT6/HQ/oSNjcRQrCzf0h559Am+KMbrNVuqbNUQ2MRhxIdgZtalQ1Yu0WDCJt4ueawdCFQbigRI15znrsVc3QO7EKocNGmgtJ/X7KAvIKmzERFJDeg4Hcst1bQuoNLhWlElJe92Jh5FbTs4IkhkJGaK+ewIA/qdVCLWBmGOeHB9o/ERVz+HeBT3E5h5lbPE3dyGLo3x24ub3zUh4As5h4XkwozGLkOtTerw4JlO374oezg8pM5wnrlPXZncmBhNTR98CLFeG6FbmBVWKeqPccmg2udrDB0O/Q1C+LsODM4tWft6IArd+vociS93Jp8D3W1Tksa/gTFp6G5otdgxSiKlQtR954GrET6VrT0eLMwOnR2flfda2p9/IQookgOvLPAuwOna8h1tKzP65hl/jzlwsWTAIV+j3t+WHjJIsf2PJ8x6RfP9JN4ThiM7bBLbcOf7WyQR1JuYiLNgKKTp4wEshvon7MntyNm1hzHUssEnxrWkz5C6lhUoLcCBWMT/akTko3PwwrdSjDmeZQSv9qsJIc7QwmmgCucbDBnkTMjp8FPLKYXLF7wJRjBZQNMx5dDYZlGuGMiY6BZyO0sz2AryXFQtE2jJibRmN594tgL1zcj9Kg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E7YDjgpI0YE71nFnFh2gwX0H13ZCCpBudLTJNPQ3ZAW2j1UIMlEgP9Mz4r/YoRZw5xNlJ68NzmFF+qhg4CYdbvhHjkeCKoViS+Ojo2qXtXfIAA97QO1V25AosU0oAUSSd0oDSiJX0y6Z6fPJ+hKB+4uCgr0mcwIMwPmgHcYxOkmmj61pSLejr5xLKkF68qr7SiN3KcROgamkr76+rDSfFKufydHQw0g6q8zHvrKNxhQksQw+PnheCAhMaxu9iVvVsAohX3DpWNu4cg+qCrmAr6flFGXlYVZe8OZBfs/RIpwFARQOzLT5TFTsj65w+0aRkuMyuDToArbxBabvJBAdsTRLuk60h6s6daAu3IbpOIKK7gv5TNbQotvnX/AggsvdpC+rHgatY3m8x+CmzyFXW7Hvv2bBsUfgXm+gAB2b/ZtKq6SZAN+UYxMeTvX8VReO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 11:30:10.2114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b5bd22-6653-4fa4-f0eb-08def21bbe37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6767
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

Move the PPT limit restore out of smu_set_ac_dc. Keep smu_set_ac_dc only
for switching the power source. Drop the restore ppt limit policy
parameter and add the restore logic to ac/dc notification path.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 84ac824837ac..bcb74bb2bd60 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -960,7 +960,7 @@ static int smu_late_init(struct amdgpu_ip_block *ip_block)
 	 * is unnecessary.
 	 */
 	adev->pm.ac_power = power_supply_is_system_supplied() > 0;
-	smu_set_ac_dc(smu, false);
+	smu_set_ac_dc(smu);
 
 	if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 1)) ||
 	    (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 3)))
@@ -2774,7 +2774,7 @@ static int smu_set_watermarks_for_clock_ranges(void *handle,
 	return smu_set_watermarks_table(smu, clock_ranges);
 }
 
-static int smu_set_ac_dc(struct smu_context *smu, bool restore_ppt_policy)
+static int smu_set_ac_dc(struct smu_context *smu)
 {
 	int ret = 0;
 
@@ -2794,9 +2794,6 @@ static int smu_set_ac_dc(struct smu_context *smu, bool restore_ppt_policy)
 		}
 	}
 
-	if (restore_ppt_policy)
-		smu_restore_ppt_limits(smu, true);
-
 	return 0;
 }
 
@@ -2804,7 +2801,10 @@ static void smu_notify_ac_dc(void *handle)
 {
 	struct smu_context *smu = handle;
 
-	smu_set_ac_dc(smu, true);
+	if (smu_set_ac_dc(smu))
+		return;
+
+	smu_restore_ppt_limits(smu, true);
 }
 
 const struct amd_ip_funcs smu_ip_funcs = {
-- 
2.49.0


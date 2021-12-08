Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DA8C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 02:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BD7B6E086;
	Wed,  8 Dec 2021 02:37:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17E296E073
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 02:37:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bG9KoQpDm3M+Fm7z8YBYYwWDAcTZdZDjWWOT71ZvMyFtOrG5MzQE9IQB3oacI/7ViNAEpvBs6KRibqNyzx8XE7o0k8/UML87gQPJxNH4uc9+4qixHIWVBV2Qqr2DfruUWfXEsIPWw5RbRcmZL99xWmGoqPS8q4SouNbtDC4AUpVavuzCDOjmPTqxi5QfaDXlj40+7sv82Dw2oH8x82nJ8LR5yholV/9affbDHV5HFu//+IonSJcU1stjf5POHuK9XC3SQkAPT8z5teArNhDT5p2sJD3cfA+HqmTqEkfCb+R/xBVdfE/qWIuSz8d+W2h+Og25OWj8WINA8AimFC+Xhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15yVHkPRM8fVpvGkPJRMDqKdGZPAyo43PKhRxHDqF5w=;
 b=m2+025Fm/nwyPFATlzP6y9mgMTwn/uOyuiKcYNOwBj0wVlG6r7p3TSNzRwIc8xr+kehUjq4yUl4hh6YSQGN+vctolqNX8qs5pf5eOE3k/6/NWAWMhap6Vmvb2CsRppUGX4OaiyJbqmLih+RTg02CAyWiGbLvOVj7RQFXkCJ102utjhczdbeXRQUTQZ6rdKs8xC9FYH5N5Qb5AkCBkvJgXeVLVtYvo+pZTLmR/VUpVDT1NpueJ8xfcv6LNk52aGg4X2343/Rn+y71t00KnmfMgNO5EXXDUKYihen/D+PfZGg08HfNBR191EBWN9XCHmVR3WxLjst+O8wTeB12TBgLFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15yVHkPRM8fVpvGkPJRMDqKdGZPAyo43PKhRxHDqF5w=;
 b=HoPLzEMfeEdp4xblGOAe613CMUASSMMuVxSenOnMusDtEY6vMsnpfQX+Xl77JMnsyz2IjguvgsCKoNzkkPSgtIzBT5Hpoc9lj6AtxD/85joGUWElK129+0qaFEFWaPYR7eaJf+mVSqQ682A5Awi3PzJLmpYfwcDABasLBx1onWU=
Received: from MW2PR16CA0030.namprd16.prod.outlook.com (2603:10b6:907::43) by
 CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.14; Wed, 8 Dec 2021 02:37:43 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::9c) by MW2PR16CA0030.outlook.office365.com
 (2603:10b6:907::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12 via Frontend
 Transport; Wed, 8 Dec 2021 02:37:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 02:37:42 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 20:37:40 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amd/pm: drop unneeded smu_baco->mutex
Date: Wed, 8 Dec 2021 10:37:05 +0800
Message-ID: <20211208023707.1814122-6-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211208023707.1814122-1-evan.quan@amd.com>
References: <20211208023707.1814122-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5092ec30-3d12-4a70-37b4-08d9b9f3b5e1
X-MS-TrafficTypeDiagnostic: CH2PR12MB4296:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4296213E2729A9A5C89CA57FE46F9@CH2PR12MB4296.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UOVRXqYfLXGWCtlRCK54ssqMgrVccZ8Kd5FcLwr58hDntvPeiAbiSr4DxpBQzloSJoe1ZK5vMqnE9CU7AWeQVOPDtj/1yHDI6xRfxoyOLcA9X+XKgMmOu2RHpCjVSbwHjde0YAhlW+wBperp9SH6410hMWOX4kOIGnVk0rDJ+t8idUESlYC1+6vXsUkWeU6ZR1Wdv23wAYrFDGK8Aflje0Xk2hEBroAAzRSqcfC6tKapYclGaG4OpHsXTdYgZ3dwpBrNVFJgbaoOgEiOxujeJDfarTG6Vm0rvFfZ+2I0WgX+LK7UPzI7AsO/IxBSocawiZ+zfgtP4SB7AyqZGjEr/rOv9yajBS2nx8tPHGd2gQKKQLWX/XMKoTZ+UpZ/X4H/P7gGDMwaSo6yezdNG10ZzcPlcz4m2KAa/QuXoVk2YJ1tOWXPGZTc2ktr5jKnTY8LqY8fNE5dm5QMnDw9BEvu+4wpxfqP2vRysCuHv6eS/2L/+JzHtMUXz11499aC2bigjIuFHbVLXZJAw3oNSlPXorkvXhmOn5uBVP01eupj7MqFwPKVguYQtj6O4be3W9UUC37e4duEf0mxOq2Yg9m6uNcki1QxPz+NeKyDjrydBm+snuE2Q4GkmHjhlnDxZg+fIRG4pPHJpyT3ATmaVMIuhkhHK/K8xUvmJDjBelcxLozQR5z527V1P5+ntkwgOyhQozthE3CU7NPk007mzJa80d6HBssLN6ZNM7zpvq1jSQcgBnUfcKJHAT0N3zDO21pz6htQ8HV2cj8n3kEWDwCtzYnUlyNRoAW40JP8wvya5LtFaJRZz8gXMEyE9HCeXK8u
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(186003)(356005)(40460700001)(16526019)(1076003)(6666004)(2616005)(336012)(26005)(6916009)(426003)(2906002)(86362001)(5660300002)(44832011)(81166007)(508600001)(36860700001)(36756003)(82310400004)(70206006)(70586007)(83380400001)(54906003)(8936002)(4326008)(7696005)(47076005)(316002)(8676002)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 02:37:42.7516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5092ec30-3d12-4a70-37b4-08d9b9f3b5e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As those APIs related are already well protected by adev->pm.mutex.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I8a7d8da5710698a98dd0f7e70c244be57474b573
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  1 -
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 -
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 19 +++++--------------
 3 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f9886423eec3..81ecbeae18cd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -566,7 +566,6 @@ static int smu_early_init(void *handle)
 	smu->adev = adev;
 	smu->pm_enabled = !!amdgpu_dpm;
 	smu->is_apu = false;
-	mutex_init(&smu->smu_baco.mutex);
 	smu->smu_baco.state = SMU_BACO_STATE_EXIT;
 	smu->smu_baco.platform_support = false;
 	smu->user_dpm_profile.fan_mode = -1;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index f0d7953ffdc9..313266e4ab13 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -428,7 +428,6 @@ enum smu_baco_state
 
 struct smu_baco_context
 {
-	struct mutex mutex;
 	uint32_t state;
 	bool platform_support;
 };
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index fd188ee3ab54..8992355c8c06 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1615,13 +1615,8 @@ bool smu_v11_0_baco_is_support(struct smu_context *smu)
 enum smu_baco_state smu_v11_0_baco_get_state(struct smu_context *smu)
 {
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
-	enum smu_baco_state baco_state;
 
-	mutex_lock(&smu_baco->mutex);
-	baco_state = smu_baco->state;
-	mutex_unlock(&smu_baco->mutex);
-
-	return baco_state;
+	return smu_baco->state;
 }
 
 #define D3HOT_BACO_SEQUENCE 0
@@ -1638,8 +1633,6 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 	if (smu_v11_0_baco_get_state(smu) == state)
 		return 0;
 
-	mutex_lock(&smu_baco->mutex);
-
 	if (state == SMU_BACO_STATE_ENTER) {
 		switch (adev->ip_versions[MP1_HWIP][0]) {
 		case IP_VERSION(11, 0, 7):
@@ -1680,18 +1673,16 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 	} else {
 		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_ExitBaco, NULL);
 		if (ret)
-			goto out;
+			return ret;
 
 		/* clear vbios scratch 6 and 7 for coming asic reinit */
 		WREG32(adev->bios_scratch_reg_offset + 6, 0);
 		WREG32(adev->bios_scratch_reg_offset + 7, 0);
 	}
-	if (ret)
-		goto out;
 
-	smu_baco->state = state;
-out:
-	mutex_unlock(&smu_baco->mutex);
+	if (!ret)
+		smu_baco->state = state;
+
 	return ret;
 }
 
-- 
2.29.0


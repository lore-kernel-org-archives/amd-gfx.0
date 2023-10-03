Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1666E75459
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 19:07:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6632C10E068;
	Tue,  3 Oct 2023 19:07:51 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F91710E068
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 19:07:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPA45AvQruUylijHZ6JtcOPqoDHG+Eeux0mpGAbfWAbLbx3utW9+beDoEFP8xA+sHNVcDZLuRSmm0f41xgmazeRS/bTXQXPFv/9quBYOWD/57bBKhfrijvtK7tG3ftJY8iQ3V8q3EyS++p1t+GpnacO8hRFp6Gf/E3fsJDkILnBbrry7631H6IET+bVbwKJ2Qgkz2lG14ZFrph5xIr+2a9MyIGiFnDx/AZaak8/AC7ixhzg+AFKvO14OFzYjkmDDBNJ5YEhUms7CxE8EEeSSopD+kmCFCzWGwXdktX9p+WM4Q3BWDLg+rP0BSxEb1MnWQWog2w8G21rzDPTJwRHmCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Md/AEnbbmdmqCzXSEHlcDgf4DnKqgDK4nrTwA4/TbY=;
 b=S3TkGqNij+di7OsQEF0kqTit6ZZag5DIAALu4c90RimPaANtVQiL1j38O6UlU87soQN6G6D33NA81WFclQqgCql4pV6PJAqsaG6lCkdc7IIC7+bTcB9nGbQcONOJbUcmqxNWNAIYcvMsOw8IvPM209cvwCCO80+0jxihmXlRGIOyTQF869L40rXOz4D3zWXklCiUogHXRqB+Ve/60HoE0xVVo/9Xp68TxKE0wfUMtXXE6MSiPVISxxhB7OoViANfFwnAoxewXbSNfdh71oMZSDuezA+pHhnXY+J2WqJwJDyiNTgd7y3y1dU9BSjtgYEIr/BWYYMKa5KcpNPWkEUgiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Md/AEnbbmdmqCzXSEHlcDgf4DnKqgDK4nrTwA4/TbY=;
 b=GYBDKqq2qb6C1PEMWJBJedYaBKSRqo/7lvlQYOhYEkKTWYFQ3+lT6b4NNBhQ7jZMy1cVoqyHLhSukrYBspnZP5NBWAyN2ZnTU/jr0pSlAp1As2LMF1eedFDpJfvsT/cIxjTNB3Ljsh3JZ11sc6o/wSzago6Sya+3h+LsqgTMVWQ=
Received: from CH5P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::25)
 by PH7PR12MB6442.namprd12.prod.outlook.com (2603:10b6:510:1fa::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.35; Tue, 3 Oct
 2023 19:07:46 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::65) by CH5P221CA0023.outlook.office365.com
 (2603:10b6:610:1f2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Tue, 3 Oct 2023 19:07:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 19:07:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 14:07:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable SMU 13.0.0 optimizations when ROCm is
 active
Date: Tue, 3 Oct 2023 15:07:31 -0400
Message-ID: <20231003190731.106594-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|PH7PR12MB6442:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f59b130-7fff-49cc-397a-08dbc4440734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HxmgVv9LpD+SmbNYPtzahUeLM+NDFUXipHcmkj9l703D/vcCsA9TFp3ghgc8oeqObPBw0jtheUWU8FuvCW+wHAA+2SVXBAOvN8jFXww6bBDk2BW+CPdU0PF0mptIZ8Yxh5lskLFiZdBu0M8C7cIGV+aUQ+0VMq6AIAsvcv6uPmPYw04JtmIhnudIHesR5Npq3b+RqFrxt9XMEIawcZU9FJYb7ufeD6Xa+ZQB9fmpBemUOGdC6c7b+D6TcySdmwoJ3jRXCoRzh8AXlQeP4Fgv5TJFaqeNXzv+BZ8A2gpOIqJsKdmpT8EAXlYI+O6/EjQsHGBEQv/Uidi3WljdX0wXGsXA1oDV8imK7I7kUxI/uvIFzLF3zuSYeuIfGCPLxe7rq8FOAL70ORXqv8oJCPGrmbEwOiXEoN4j/NafXjIRgEU8q4iajnWVA9GSbP9CB/XxiofYsy4FH48bTZFhUizup2jsKOI9povi/jssgvtJyb11Iey9E/XvklKvGNKq67mCyuJgo38bSO4us5Iz6FY9AcoixvfnnnM3CkQgnJlkWwtJsci8liZ1IvZGC84wLiQatmKEzXOMxH1Mh9LjLsg7lsG9pIYEpRLrnbCPWaAt2pZr/bzg+j337ocO8WQu5+kPIIfNOe6AoVtClFf1O5KqGu02erS1C0myPTogar1WZZpHaUHxdwUDF/u1gZzt6fwcYBNEMfhgU23rt6fJMzvGOxj4xaMStM5v7+piuyH814ZbciDxzEAMjSIqqsCAYTUlbmcGpzpv/QIws1t0enKwRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(6666004)(7696005)(478600001)(1076003)(26005)(36860700001)(81166007)(82740400003)(86362001)(316002)(356005)(6916009)(70206006)(16526019)(8676002)(2616005)(426003)(336012)(41300700001)(36756003)(70586007)(4326008)(2906002)(47076005)(8936002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 19:07:45.9959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f59b130-7fff-49cc-397a-08dbc4440734
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6442
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When ROCm is active enable additional SMU 13.0.0 optimizations.
This reuses the unused powersave profile on PMFW.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 38b5457baded..b6c0c42de725 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -714,6 +714,14 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 	amdgpu_dpm_switch_power_profile(adev,
 					PP_SMC_POWER_PROFILE_COMPUTE,
 					!idle);
+	/* Add optimizations for SMU13.0.0.  Reuse the power saving profile */
+	if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 0)) &&
+	    ((adev->pm.fw_version == 0x004e6601) ||
+	     (adev->pm.fw_version >= 0x004e7300))) {
+		amdgpu_dpm_switch_power_profile(adev,
+						PP_SMC_POWER_PROFILE_POWERSAVING,
+						!idle);
+	}
 }
 
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
-- 
2.41.0


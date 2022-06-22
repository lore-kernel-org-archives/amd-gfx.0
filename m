Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0F0C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jun 2022 14:24:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38DD789DF9;
	Wed, 22 Jun 2022 14:24:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFE0889DF9
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jun 2022 14:24:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQ65DPT2goyGvOCo+OuL+AzYd/EoTNNp90+PzKzG/JHmtacivWuQYAr0cAB5kERNA29qAstZR++hETZRcOagHhApf68pZd2JzQy+kfFwZInQRfQgoXoREgRXpeQOyCvJLxFSRWqISXzmrZNwdGVHEWKojlo+Q07l9GvFHZel7plQhCL1PbDZn52Al9FrRssPD+KTj7ndrTWmvGAqSiJbXKa1TjA8uWwFF9mvAUfW7d2DyjmbI5+naCRo5f0/4dPIMDcmvskzX600zgWuzoOJfZlsHnD3N/gcgc28xFGyLRRDYmCUayQ3q6fT3uzx88Aosmutx2w0TWthsy9S7Bq04g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u78RNRF7d/71J84wxlm/DqqnTrPpg5kH8P3WQm0mudw=;
 b=F6cKvP/HL7kTYZ15r5XGUXjZ3Cehi+GZbpDewtUr7isK9y59lUyj67Mhp2GBr5MhUy+ta0gNYssDux+wBbRmo8Gfz3CWOt+DX738ukUpWoPfJRc6ZlU9wjKzJdlV46tYFn0TPpkX0+WRtujIUIbB35FkK9u1OJwqIXpX8YH1ymgP6IcrcQebdUk21wo3YqgKM3jAXdLbR0Ek35DBbUNaeuYhn4eg65U154gAOaRrTFvVCkEGai6K5dI3ufZVSjsUgv6L21MKVZD1hvGbz2QrFz8S8CEcchmgD+ArztQfJzepNGH400nR9HivKhY4gsD8UYcp9VWq1KU/3msaqaaPKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u78RNRF7d/71J84wxlm/DqqnTrPpg5kH8P3WQm0mudw=;
 b=t3RgvN60Xri1/K4B9JXRbTGQbBxUkMu9u0vD98R5jThcUdw85EEEtqWjpAV4A1M8yZMPzQM0Y8CXTxqKHJsCy+wvvrH/y33ZVoMhV2scs9VdimLuViLGhpfENvajg4/o3RhTVwI6vjIl8O1YPSQhGoyc0GV8AB9/agYfIyzJdiU=
Received: from BN9PR03CA0588.namprd03.prod.outlook.com (2603:10b6:408:10d::23)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 22 Jun
 2022 14:24:42 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::f7) by BN9PR03CA0588.outlook.office365.com
 (2603:10b6:408:10d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Wed, 22 Jun 2022 14:24:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 22 Jun 2022 14:24:41 +0000
Received: from ruiliji2-lsy-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 09:24:39 -0500
From: "Ji, Ruili" <ruili.ji@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu: To flush tlb for MMHUB of RAVEN series
Date: Wed, 22 Jun 2022 22:24:18 +0800
Message-ID: <20220622142418.547480-1-ruili.ji@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e47b6cf-f154-4da6-2c8c-08da545af24f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4081:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB40817739F5273876900A66CA9BB29@BY5PR12MB4081.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TYENUfptmmR61+8whYYqvJWmZ1j3C38NoYtJewywUSilSkl1rv6caW6m1wNUoXaWQIrQxK+UdMdArqGKIsZtnNEFFWuHr/C9U6JjTAIkMGEkJoilH/ZGxzEN9iKYCxs/+haEtozoNstGtW4PjJ/ugY48IejmA1Ti74jtHIvdKYAVbNFimMl/8nTE9peZlB02dBw/G1XS5cYllBXQjGl2j9jDQ9pltZwuMmV6zAhrsGKV0N6UlSUEuxa7EWCfXOPngmBmAriFiSgSF17fjxtbCK9PVQ02oQa3RnZnjqWGJQ56WvLCDnMsyTc4Gen7KR+leDvYKdEXLXIU8z9uiF7YxUwe2b02pqJ7hmi2bPKHYqlzCSifNwRRbHzKrCM9QmzB0q2WidXhZeJ5yDEDBDoN3gHgGC8SVDSZkDgDu1ZO6Nva7DW4ogN7OARDwMoaahPpRM5Qogu/54+gzYQv7p9ewuyMPb/ZrX5H6swlQ2fq7cBFkPVNbAUZTqzYgyNU3aTBPEfWPiKXk0dV2Uh/zztZy3jw96JWbPH31iEa8Ub2mhD4kahKEc5GJe0LIcWfV30V8nC7mOvQ12iDVgQBoWN982PZ6xhUjgjmlojhred4aPByhn4UCJse0ii0YgcFwzxrXQdfwjRto2noBLaNSUXy7oGpazV3tYWH8aq0DQetv6JSm3BNMcv1IEVDay8M2K5ijqTNQg5uwJqIrA4Cu/fnTh95dMAn/ZSNQOlSy8jz8VxnjBofg3IevTjHieI6WPw3v3rSkUq63g+WSngEMOiFg9SFhLX2FROgem7dpalku10=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(46966006)(36840700001)(40470700004)(7696005)(26005)(8936002)(356005)(41300700001)(478600001)(81166007)(6666004)(2906002)(83380400001)(82310400005)(40480700001)(5660300002)(82740400003)(4326008)(2616005)(36860700001)(86362001)(1076003)(426003)(40460700003)(47076005)(16526019)(186003)(336012)(6916009)(54906003)(316002)(36756003)(70206006)(8676002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 14:24:41.4786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e47b6cf-f154-4da6-2c8c-08da545af24f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <philip.yang@amd.com>,
 Ruili Ji <ruiliji2@amd.com>, Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ruili Ji <ruiliji2@amd.com>

amdgpu: [mmhub0] no-retry page fault (src_id:0 ring:40 vmid:8 pasid:32769, for process test_basic pid 3305 thread test_basic pid 3305)
amdgpu: in page starting at address 0x00007ff990003000 from IH client 0x12 (VMC)
amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00840051
amdgpu: Faulty UTCL2 client ID: MP1 (0x0)
amdgpu: MORE_FAULTS: 0x1
amdgpu: WALKER_ERROR: 0x0
amdgpu: PERMISSION_FAULTS: 0x5
amdgpu: MAPPING_ERROR: 0x0
amdgpu: RW: 0x1

When memory is allocated by kfd, no one triggers the tlb flush for MMHUB0.
There is page fault from MMHUB0.

v2:fix indentation
v3:change subject and fix indentation

Signed-off-by: Ruili Ji <ruiliji2@amd.com>
Reviewed-by: Philip Yang <philip.yang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 1d0c9762ebfb..a6801df038a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -739,7 +739,8 @@ int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 {
 	bool all_hub = false;
 
-	if (adev->family == AMDGPU_FAMILY_AI)
+	if (adev->family == AMDGPU_FAMILY_AI ||
+	    adev->family == AMDGPU_FAMILY_RV)
 		all_hub = true;
 
 	return amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, flush_type, all_hub);
-- 
2.25.1


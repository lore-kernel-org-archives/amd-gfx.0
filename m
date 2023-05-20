Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C84C77B7D
	for <amd-gfx@archiver.kernel.org>; Sat, 20 May 2023 09:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DA1310E06B;
	Sat, 20 May 2023 09:25:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4591810E06B
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 May 2023 09:25:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWUfPkl6Ep4lssAjJDSVuaTjcdgtwJBiTsJTsOLB7/JMIAu7QQcPZg4FmlYA1mzpOEuni+5Z8QdyfACllC3P+F5wvxkAoni62z+J2mHzvJntSM8QZ3p/bmfJkq5mlTIJivJ1+NQ1nvbuHgTH4CkmgEEZh7rs/GO3EsXZniHzwQuHZKihgxa7EThlFThycYRJ4KNmMT9dL9aRknsTSnzsrCNokrBBU7e4LMHD/JclziGDKbvGtfw4XvYcqmxoUJnF1nZ99EByzxMuhGDYxnH9wtE6afbV4e7E0NYL1WTnwC1xnj3LEFDmmtl9hqi4DkVnux+GPQ1pYxaQ08QJclj/gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/Ri4i+mswNvwh+3brYElzL7+jU3Y/pFOKJs1BuZyEw=;
 b=kJi47RzwhxBvB7Eb02IBwWdgs+0KietHHoZ4+Nw5yecBacGsk7UaCmY5sHKK1Vscjsc53STRpPU+Tz8CHGGmsh4YI+lNrDgaMRIcEa0MAMhmA496cA9X363TCD7ZriDwknCrG25ZLpgS0Hk6sa8IgxEfBmu/fEdIQywmYaBBWVKDJcowrEdDm1FI2QE8S9MV3HNZoZ1MGfshaJ/pJi/ryPzUZqP+Vj0ICeUgqTvOjIynVgSNMchQlcrmKSK7SdeL04UX66REGW3g5i9SqEyGSawZuaqcYDvDO8OhSa2XH9MS8UXPTeLvf6TB0nf3k8Sse5vzRxQ4XPyldkoACx4htw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/Ri4i+mswNvwh+3brYElzL7+jU3Y/pFOKJs1BuZyEw=;
 b=cNbRr4zRzPzcdTbgsQzc8dSbhOklHe3rnnqY2Rpbi41R6V8FyDTZ/O/SjDpZbYn+SkrmE2pWHxraGQfqaqjEGjJWq24PN5TC+Njx3P6ACZeLCWEPtvft9quWThl84T0hSbi+DF8yMCc/SzY1M9Wo2Ws2zuAQnyw4u/hhptfJfN8=
Received: from BN9PR03CA0117.namprd03.prod.outlook.com (2603:10b6:408:fd::32)
 by DS0PR12MB7747.namprd12.prod.outlook.com (2603:10b6:8:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Sat, 20 May
 2023 09:25:48 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::cd) by BN9PR03CA0117.outlook.office365.com
 (2603:10b6:408:fd::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.22 via Frontend
 Transport; Sat, 20 May 2023 09:25:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.21 via Frontend Transport; Sat, 20 May 2023 09:25:47 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 20 May 2023 04:25:45 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "drm/amdgpu: remove TOPDOWN flags when allocating VRAM
 in large bar system"
Date: Sat, 20 May 2023 02:25:18 -0700
Message-ID: <20230520092518.1993-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT041:EE_|DS0PR12MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: a98544b8-77bf-4203-f19d-08db5914322f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m6FMn5lDZR+eJpJbJsFPtbqGeM/wqQmuNLlve3CmMObH02SRLoxyffR0buNLvRNOaAqIWv0EGhrdhm04CbT6AeKVAgO4Acp3CjfojFI4SLUFR8KimK2JZ530LXbIlNpPHoltGXgzLphyNdVAYaMYXA6JsBoKj8JgH1f29B13vyrBLk2iqYxluxDhNr148GVFDtw4haAg8qEs4Qapwe51JLI9DZHMt5T7xHgKs7+98dqF7z+cOFojINtj1aOY5wQr9OHSSKVHPWrhKOAtNjehBbY0KyHjiQHv0JbVsixs558hZrsdzhT5oczerlFGzebjEWeYKZtW4/bNHiooNiwPrR4yhTSwiI6gw1Z+/Dx0i5iOgYaucBgeFEVDMM10bRx03z7cdJkrXcLWabXAJIp4faQD+ya6gU09PEFsZ43tEcrmbRHP4Kbj/R588T2kmkQhGtMAyvS8RRRy2jT+qRUK5kY58o3zHHHGbEOZQS35+X25yp+BvK8dMmIzA0q2KtoN2w+Iv2fR7+atNtflGxKKmtznvhBYZxaoLbIwULg8FNzIYcyFCkph/ubRTNk7LEj3eKmGafh5dOjTL1Kr8OI2cvt1ZMv8qg/Dqtt/EWPbza2Ir6GHrDUO2sXbHxR1cBBoR31vbrMaL8TNPvOsK53qNFKH9YiDpwQWasFlAYvHkut9T5DoGDOD0xLIKhiW2FQf8axmyyQs3R2ymyGXOZW3A5UMFKxL4nCt0yRsmWozdO8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(86362001)(36756003)(47076005)(316002)(478600001)(70586007)(966005)(6916009)(4326008)(54906003)(70206006)(6666004)(8936002)(82310400005)(8676002)(5660300002)(2906002)(40480700001)(82740400003)(356005)(7696005)(81166007)(41300700001)(426003)(336012)(186003)(1076003)(26005)(36860700001)(16526019)(83380400001)(2616005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2023 09:25:47.8809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a98544b8-77bf-4203-f19d-08db5914322f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7747
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
Cc: alexander.deucher@amd.com,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 christian.koenig@amd.com, shane.xiao@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit c105518679b6e87232874ffc989ec403bee59664.

This patch disables the TOPDOWN flag for APU and few dGPU cards
which has the VRAM size equal to the BAR size.

When we enable the TOPDOWN flag, we get the free blocks at
the highest available memory region and we don't split the
lower order blocks. This change is required to keep off
the fragmentation related issues particularly in ASIC
which has VRAM space <= 500MiB

Hence, we are reverting this patch.

Gitlab issue link - https://gitlab.freedesktop.org/drm/amd/-/issues/2270

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 2bd1a54ee866..ca5fc07faf6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -139,7 +139,7 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 
 		if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
 			places[c].lpfn = visible_pfn;
-		else if (adev->gmc.real_vram_size != adev->gmc.visible_vram_size)
+		else
 			places[c].flags |= TTM_PL_FLAG_TOPDOWN;
 
 		if (flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
-- 
2.34.1


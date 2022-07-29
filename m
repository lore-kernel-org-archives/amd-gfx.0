Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125F4C00140
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jul 2022 03:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 639AB1120D5;
	Fri, 29 Jul 2022 03:16:59 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2786113E3C
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jul 2022 03:16:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/3iEQotz/MpvJqLW10JI0L0w3LZRhBSWTl6BZ76bRfd0ytfmW0WzTngCPmcTejuUiJeh29OZFe+yTc5MxkXyQ+S1lsUQbYPuIuskmztgVzhwTh08+CVXZUmmTJcs1HOF4ah1vPNFCIiLPwz8CfTP6L2Vv2A1jwIEZlOVjAAuzS2KKi07ggZUYAovq38La4oSZnzN4pY0UbdjDZRdWNV1pMIng9yklUb+4jtvftmCeslWbnFLLWm6AIq/U2mw8YUjGb9YdPE+4MMKdQRrFa6nD0liVUuGBKxXglcagJef0XrDsgTZvqHacEikFFPdCclg6DiYIa3STQd9rAw/lkoRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o76KX9KEiXhgsxnzt0gTbmrbiUH3yGiKIxD8uGaEUdQ=;
 b=eBOQxJ5JxTHLzJFcuFfOAsFJLoCxPe6pjvqBIpCemhkfaVhfh88xe9IlZSeZs7cp4vW3MX5A+zGKLrI+otslMAwN9FECY1gA2Q0ub3DS+IAjWPkZAPFqLFPHffdN1841TySIQXeBJZSDzAiZUb6plcFESnhqvzg+mZYMlYjui9/9/CJFfAqg2ClpFyVlUUMywRQebJTxG5jf7QDctNlJa60522OKgzzrQb20rMKxcD7NG6MMgj5PPtf6hjQvg0ccN+Aj/UO6GMQ80TGcdHk12JjjuC83ZUKnTn3VJCwmkBATX9VN46xGtuN2N6soJehJyIsdpg1mVee7X7QrB/Jb8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o76KX9KEiXhgsxnzt0gTbmrbiUH3yGiKIxD8uGaEUdQ=;
 b=FhPhwB57sB0k2b9NcMvYXO8UFe2UHcU3AXd9EqQVbg8qIJU0sCOEjkEywYTjnfjq/hP2xxd/TXOcFugnigsxUITTRpAhdqb4BZdr7h7TLDmAfK0KfrrLmVkAlSsPImiE/uicOK9vzD4Vvs+tohTciAcZ+hxgVTzuGrFUof9La8o=
Received: from DS7PR06CA0002.namprd06.prod.outlook.com (2603:10b6:8:2a::16) by
 DM5PR12MB1625.namprd12.prod.outlook.com (2603:10b6:4:b::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.19; Fri, 29 Jul 2022 03:16:44 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::e1) by DS7PR06CA0002.outlook.office365.com
 (2603:10b6:8:2a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.7 via Frontend
 Transport; Fri, 29 Jul 2022 03:16:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Fri, 29 Jul 2022 03:16:44 +0000
Received: from magnus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 28 Jul
 2022 22:16:42 -0500
From: Daniel Phillips <daniel.phillips@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Pessimistic availability based on rounded up
 allocations
Date: Thu, 28 Jul 2022 20:16:12 -0700
Message-ID: <20220729031612.120310-2-daniel.phillips@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220729031612.120310-1-daniel.phillips@amd.com>
References: <20220729031612.120310-1-daniel.phillips@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89670aa8-4b0c-438c-649a-08da7110c3a1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1625:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SONSQGtbJ0NNyRynJo+BBSiqOeAHLMVmc4mTssFjuSFk5bAHuoqB5HHgbeDPJucFUOEyGH+aQuRGmfmavcImPVT7UFmRld4F3Ues82SPPToHmvelrka78PTBK7UbAr3acsCo5C2meI2OOOHT3XS4gW6B5oTXzsgGEMYUcBR204rt0LpPCd+91STZydzqyxAypkdkUgIZBGY66ugoVV9cJ/AnCPc6Kkrj7VzY22a1mZ4/ICSUdr411RdYO8LjJVQg75e3hN+4izVblTEfwMvuuKw49jlB+2kaFHRA8GmP1ipEBO7v8Ssd3u4h2L3GJkwqoxZb9J65WOlR1mTfOYhN9SbpQ6s1tcQ6PyueEZ54DB4zy5s7+ysP5Jtq7t2azRI3ZzDKfr/axLc5hbxNqoZhl9S8XtjGMZ1uk7HGqur1UuVZvDXtH63f9J7X3E96I6XH3eHW698UngKkxpCsbQZa51qikg+F26/E8Ds1a9IOFs81fNxTLvLQMEZDK2G8jqT0WoSonjMf+ZGrjs1OXDdqMcJHMD/IJAXKiLctaJRagx7FILwcfHlPgZaGyxU8nBUIDsms2WabuadkPIH8AH5bi0FYDLxyor6T+CZ171QeO98eYia/xG4UGrQQ7+KebOPgM/B5GnTvmInSc/NCou5/aHOJFiy7JHQykJkPX1ysCXJCUK+LxkgzhyCtD/PnEMb904B1c2p/xx8/e8lZpUD0tbnBjRmK/AT0kZ69oqACMoJ792A7FZtq/7kXXwB0CPHJm1/xsmuzya81RuKrgHUEMv3z6NhGv6AmHKyZTUf8Xh66qtRIV7JxjFsBdjRSczilieAFSZCklz/p2O3y6RqsLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(39860400002)(346002)(376002)(40470700004)(36840700001)(46966006)(8676002)(82740400003)(4326008)(36860700001)(40480700001)(2616005)(70206006)(5660300002)(70586007)(356005)(44832011)(2906002)(8936002)(47076005)(1076003)(316002)(186003)(6666004)(41300700001)(81166007)(7696005)(86362001)(26005)(36756003)(54906003)(478600001)(6916009)(336012)(40460700003)(83380400001)(82310400005)(426003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 03:16:44.0802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89670aa8-4b0c-438c-649a-08da7110c3a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1625
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
Cc: Daniel Phillips <daniel.phillips@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Seperately accumulate a statistic of rounded up allocations to use
to report availability, with a view to increasing the likelihood a
buffer object can be successfully allocated at exactly the size
reported by the availability API.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 73bf8b5f2aa9..781274be5f27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -96,6 +96,7 @@ struct amdgpu_amdkfd_fence {
 struct amdgpu_kfd_dev {
 	struct kfd_dev *dev;
 	uint64_t vram_used;
+	uint64_t vram_used_aligned;
 	bool init_complete;
 	struct work_struct reset_work;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 014a594899fb..e5ea897f56bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -181,6 +181,7 @@ static int amdgpu_amdkfd_reserve_mem_limit(struct amdgpu_device *adev,
 	 * memory, TTM memory and GPU memory as computed above
 	 */
 	adev->kfd.vram_used += vram_needed;
+	adev->kfd.vram_used_aligned += ALIGN(vram_needed, VRAM_AVAILABLITY_ALIGN);
 	kfd_mem_limit.system_mem_used += system_mem_needed;
 	kfd_mem_limit.ttm_mem_used += ttm_mem_needed;
 
@@ -199,6 +200,7 @@ static void unreserve_mem_limit(struct amdgpu_device *adev,
 		kfd_mem_limit.ttm_mem_used -= size;
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
 		adev->kfd.vram_used -= size;
+		adev->kfd.vram_used_aligned -= ALIGN(size, VRAM_AVAILABLITY_ALIGN);
 	} else if (alloc_flag & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
 		kfd_mem_limit.system_mem_used -= size;
 	} else if (!(alloc_flag &
@@ -1644,7 +1646,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
 	size_t available;
 	spin_lock(&kfd_mem_limit.mem_limit_lock);
 	available = adev->gmc.real_vram_size
-		- adev->kfd.vram_used
+		- adev->kfd.vram_used_aligned
 		- atomic64_read(&adev->vram_pin_size)
 		- reserved_for_pt;
 	spin_unlock(&kfd_mem_limit.mem_limit_lock);
-- 
2.34.1


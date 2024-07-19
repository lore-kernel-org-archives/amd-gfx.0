Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83E4C3DA59
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jul 2024 09:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75E5410EB85;
	Fri, 19 Jul 2024 09:19:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pX72JkBD";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D06C410EB85
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jul 2024 09:19:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vO8OYHZWH3bhIoX2XKqZ9CU58QcATopwtKprxHhG3fZk6nyF2EoP7Yr5dt+jd2YNgfoH8Yr5ypDLUcullaMQyaHlg9qdquFQEjDxmIxnNHb879eXqhq79TbXdLrxOLbNvYpeMDjHlSBAdJ2Fls2/tHSAyd1UZLZ8ONPgZ3oTovkpoaZrxMUIRteTHNAFf2Xu7mbK2a2QIHV47p6gu7DkmiPt6LxWBl9LEWPyIDBKMeGgd5Akv/F+5aQLNTghfHvizYuvtIQcYTCcaxD9vHEuL2cdYV76f0tioYapxHEZYdYvUdjNjfesgSgeyn0USMGYgriPoIaljzeiv6a22O4Ajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41a4yFH50MGPYTCIDjShfh8/uQWcwmTOv1sZgD22RzY=;
 b=xoHaAfIqSgyxq0dKuD713Cy5EV+dJMZoDo2isgRstRDk1yCYvO1GfUATZJ5XpYza1BWK6u2HbR1mJxZPSmPg6+nrC5VOKKM1Z0fEvK2gNV2FAGJ10KLSjelOaG7Z48EliWrJYh/TTlVRJXvObhjys9Pq33JxDW6Fv64DqYp6YXLnQdMtyH3D+CAfnH9k9DXYqLxJxvwGlMc8ueF4s18uljWRIVG3e8El4/vZV4Vj4+6jdl998WwFN6njZhAQcgJB9BpMdavj7inBgClboBBWL10+Bp+Qmv2Q0DXYoY1Z3kGdGiaobe/1EHKe0a1zoOPrkT+WDOQ/8B9jNnz2u/SZ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41a4yFH50MGPYTCIDjShfh8/uQWcwmTOv1sZgD22RzY=;
 b=pX72JkBDTNSzSPtDucw08TTf48eZVyqZpQMruvaeNMyouWqUVYJD02XCB6O/TH7oBbTM/uVpPNZ4otN70tmMAHRWYiuSnTXs4JNKd78uSWh1hPzyV7vVTf/YPPiLztiFyV4Q1YZTFOHVB8uIo2id6Gyy90LpcUGUFI2iSYvo4vQ=
Received: from BN9PR03CA0364.namprd03.prod.outlook.com (2603:10b6:408:f7::9)
 by PH7PR12MB6788.namprd12.prod.outlook.com (2603:10b6:510:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Fri, 19 Jul
 2024 09:19:37 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:408:f7:cafe::e0) by BN9PR03CA0364.outlook.office365.com
 (2603:10b6:408:f7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14 via Frontend
 Transport; Fri, 19 Jul 2024 09:19:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Fri, 19 Jul 2024 09:19:37 +0000
Received: from amdoffice.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 19 Jul
 2024 04:19:35 -0500
From: ZhenGuo Yin <zhenguo.yin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, ZhenGuo Yin <zhenguo.yin@amd.com>
Subject: [PATCH] drm/amdgpu: reset vm state machine after gpu reset(vram lost)
Date: Fri, 19 Jul 2024 17:19:21 +0800
Message-ID: <20240719091921.1213270-1-zhenguo.yin@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|PH7PR12MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 16aeae3b-7e35-445f-bc22-08dca7d3e928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o+kClInDDQPTLl/ooomUED1JWw32tLf7FX50bYN6XE0XJ/099oAgsyuzLtX6?=
 =?us-ascii?Q?axyR+lHh8I1wTW0odv28VeiC7kKr177UJWm3p477QeUGB0uZaCzK50lxmHls?=
 =?us-ascii?Q?pb7WCgDyYsKIZkrPyQRPXlI3c+B8d+lSgMk5+dINIGNfidF/IVhYNn/+ibvq?=
 =?us-ascii?Q?orMqZtphVOV/LTAG+D2ES/IvVoMUsjrScOsh3VWMmEJG1A/f7GPRU8BiRr4u?=
 =?us-ascii?Q?apehB8aUvbKPWV9hW0oqRBLgvlwm3dMUkNDMx7gigEtTc40d0TAD+rGRcUY4?=
 =?us-ascii?Q?vZXQsaUFzcZ3I4lLp/2WESBC2y/lX/beVJ6EkXHUSNi77ix/PGJmTTaxrQm4?=
 =?us-ascii?Q?VeuiLIZICjhQpB9E+aiDw306dHsxmZvsO97Y+IEQCHd1WdeWUpWRF459HSEW?=
 =?us-ascii?Q?5jQAJdU2dNZaajr7SsJgmW9Hco5XKln0kBOPZd9RxfQQzGAAm6SCsmBgLNa8?=
 =?us-ascii?Q?v9fsg3UKdDf+u6nmfcxzafEYo/Q2UpqBlV6wEQ/P9RGG0DbzTGcqDdw4zVE9?=
 =?us-ascii?Q?ijafvW3lJrp60oHCji7ElXNoiklYRFC4wv//I9ICaRmLGWlFkxyTyeHvFUqR?=
 =?us-ascii?Q?MhHO1T92U/8S06Orz+hzpw8jIWBn0wFajMV4lxPYCFtJ8xuqfJeGvoMxtfQA?=
 =?us-ascii?Q?2Lv5sIEziJ4YjcSmT1JFltBwBwngMDTrmDXgiXMY/t8ztnGgyiiAb333Ne04?=
 =?us-ascii?Q?xRaxgfwrqGiblOgkbtvZ7FQYo/ZLn+SboXyTkoBMyMCf8cz/rVfkFViJztID?=
 =?us-ascii?Q?cdV8Qarq0SVp1cI5s47i+PP3w/gLNGA/BLRk4TXhKjAFZNy6jI7UmBJRqGtA?=
 =?us-ascii?Q?y0O1y3A310K3puWWNcAyri+w+eHgOv0ktwUyYr0+WVT897pjcOeHmEU3VZAx?=
 =?us-ascii?Q?nXWrkbUlUjygKtDUxa7hb5GgOOm3r8yL4+As1+AseWnpZeDlgUx46/funz8p?=
 =?us-ascii?Q?uZSgMXLpnNoCwmi1zOye9YxA8RU0RKefSqabhJounrcWCS7AhfSbSkqpAp+d?=
 =?us-ascii?Q?+GNr357vmNcrOxuRwAFsRt1l1630AxoNTrIeP4hQdMpza9+ahyDpcL0IOSnN?=
 =?us-ascii?Q?Pj2o775NdFfXLtW2V3TztkIIsES+yvmSMuThEbMcwNndBcY/oIoxUl6q3eo3?=
 =?us-ascii?Q?skP0xMODThRV63SuY8VdyS5v2PJDUfFtgu6D5fXmsfSQEkYZ4Y/TAtjY/N7S?=
 =?us-ascii?Q?OhnevzwlX1r25UCCcnLnfArdKy9IMeq6r7Mltx3dC0GcPH6RAZ9mnaZW6t45?=
 =?us-ascii?Q?srr64FvrYYKWGXZtNTBZSR4HSLA+44jA/6kndIl2Uyce4ooS2T2ZjdtIUiy+?=
 =?us-ascii?Q?8S4l8tihL+4BABOs+1VVrVg8AShTOLbPeI3QmEeWeoIGZdGSvll9wRXIcPUD?=
 =?us-ascii?Q?1zFYQNZ7tzy8zpsQhf0B5f8pgWgvbt2ChsdfO3oVrvnvmb0KXxrQKzJmjQFV?=
 =?us-ascii?Q?fpzXE8SjNh47YHe3B8w0V1AEaUIhDpQe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 09:19:37.0841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16aeae3b-7e35-445f-bc22-08dca7d3e928
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6788
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

[Why]
Page table of compute VM in the VRAM will lost after gpu reset.
VRAM won't be restored since compute VM has no shadows.

[How]
Use higher 32-bit of vm->generation to record a vram_lost_counter.
Reset the VM state machine when the counter is not equal to current
vram_lost_counter of the device.

Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3abfa66d72a2..fd7f912816dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -434,7 +434,7 @@ uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	if (!vm)
 		return result;
 
-	result += vm->generation;
+	result += (vm->generation & 0xFFFFFFFF);
 	/* Add one if the page tables will be re-generated on next CS */
 	if (drm_sched_entity_error(&vm->delayed))
 		++result;
@@ -467,6 +467,12 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	struct amdgpu_bo *shadow;
 	struct amdgpu_bo *bo;
 	int r;
+	uint32_t vram_lost_counter = atomic_read(&adev->vram_lost_counter);
+
+	if ((vm->generation >> 32) != vram_lost_counter) {
+		amdgpu_vm_bo_reset_state_machine(vm);
+		vm->generation = (u64)vram_lost_counter << 32 | (vm->generation & 0xFFFFFFFF);
+	}
 
 	if (drm_sched_entity_error(&vm->delayed)) {
 		++vm->generation;
@@ -2439,7 +2445,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->last_update = dma_fence_get_stub();
 	vm->last_unlocked = dma_fence_get_stub();
 	vm->last_tlb_flush = dma_fence_get_stub();
-	vm->generation = 0;
+	vm->generation = (u64)atomic_read(&adev->vram_lost_counter) << 32;
 
 	mutex_init(&vm->eviction_lock);
 	vm->evicting = false;
-- 
2.35.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB00C55184
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 12:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4C1A10EA24;
	Tue,  4 Aug 2026 12:51:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2Ws2wJEZ";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBC0A10EA24
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 12:51:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJJ4XTbXxJS6p4DUBlJ6cPZ9lqy6rs5ZqvGBzmCaBlJlkHOKUd2Mrlgar37lpFBokZf2GE0YT+oxrR42RU3LnkTv8J4yi4YVJXdrQsvoHRv56Z390OaW1hd1Mdqkyx+MSvif7ODsh5ikvDxp89vWmsFkc7ceu7T+b8SjpYFp0xcTPjRNMghenNwUMtXxZa4+xtaiTgzKLepp1zzLoNbdkHeDRWRo2EeqKg+6Vg/4/YLDJsCIONGNvmHu7tgDBOHELCjmeSMCSJjRQh4obObWs2/s5rlQUOJWfErTmUwBVBRzRGsz9wRi+VAnCVArx0SvCAInXCTN150Yre9gimmPpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woHDKikKrj7vWCu6DMPoF39g7bolNFIfCjAYJFZbFIk=;
 b=POeOKpa7whq3FUycXf1cbm8TMHI8d1xPXVnoNtJhIbqXmXAELVUaAoES7eTX7gjAPXd56IKWuq4bw20HNa1OzIhFtI2Y7RqBBz0f0VpH0z9kgzdJxC9IzKvtq7s+Ew75CFE5AMO5R3AfwHueEAfCd2kcWww2ihmEpBRiUQyudRIEQGEaa0+3H0pjYnn91Z7UfLhFUzoN4My+GT4HJldtbhK+moPZtfZs5njv98u/We/bW/OyL0cLI3aPOWFiF8JVODg1oZSIUnAqbUXqkAYnYwe8Heq6VJr6XpObQ1jfIOGovuKFXnJlmF4z/2KTIgyNPnoeUhyuGG70mZTFYKbo0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woHDKikKrj7vWCu6DMPoF39g7bolNFIfCjAYJFZbFIk=;
 b=2Ws2wJEZq4+fuD7oth4qkQpOkR+h7SlW1DyC7xdW0xMoB0og0xB4MqsvYIkR/CPOJ6vkgRCYNdWhpMBIMRQuwnv15Homg4MmNdmV76nYrZ/WrFgL/vMMluotVXIqnpXR10yNxAR09STUz/o56lF0pifPQwWu67tdNWqHP+b38mQ=
Received: from BLAPR05CA0017.namprd05.prod.outlook.com (2603:10b6:208:36e::29)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 12:51:37 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:36e:cafe::13) by BLAPR05CA0017.outlook.office365.com
 (2603:10b6:208:36e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 12:51:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 12:51:36 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 07:51:33 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <YuanShang.Mao@amd.com>,
 <Tiantian.Zhang@amd.com>, <lijo.lazar@amd.com>, <hawking.zhang@amd.com>,
 <le.ma@amd.com>, <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>,
 <kevinyang.wang@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix aperture iounmap skipped on device removal
Date: Tue, 4 Aug 2026 20:51:16 +0800
Message-ID: <20260804125116.2196299-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260804125116.2196299-1-asad.kamal@amd.com>
References: <20260804125116.2196299-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: e9da96fe-af95-4fc9-9f4c-08def2271eb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GKnmLooqM//xH70x7pFEllHIn0/bNzZd2pKIPivKbNObukfW0C64ZlSH+3PSKpsdC0ngnkh6XaxcZoaAo9zmy8g2Zu/fSrkX04RuhiQ2VLpWkiujIojJH78OvR79mvi7JGH1ITh4r7l9okcF3YIYvQlrZ//w7VETUBns5wg/vLA/pKocZWbJ6ugCG26YBq/WRn7DvcXVLL87g6TEDgU1XQU+cvFVrSjHpH0bmCSJrs0kYDmEVLJqc0LsK4zrgKq+YyWjc+cvW4YjzBs81YhdXilTamMPgAaRlvQd5/ZTnZnpRHmJe1xjEWSFgtc2Li3ifMgenm6fPzR3/ZgVN0kcpJYWoutWGrZwdR5iGFqD8q/f7k2jr5xfZ8QRxSpQDy9KLxhXVVP20602G8SuKx+ic5ThCuvkjnDENvbo5eZzh2gjsNx4uY8a1B7ua+vXcvMbefMiPhxDJpkqhA0hKzjFEIpAbmgLkwtboNaiC1rCqKF42PKWlT4iM/QyxgQI4MKjjFi0rIZLi1NFjkbRZQ6lkdvr7355cEqPC/iea4QwAmUhGTwCN/0IYOQesHCV1QJcObQ+2MUAI3Ix20DAzwV3YwmT71xLPCJfSGElmZOGmdxHuOoJeEzfoVNIVHtrvk8Le+68D5rnrN0QsP+HOhHdYS7BQXLWwGdjRQwO2MqZNdro+iKw9Q4R+9nAdUsIYccU/dXn0AkmY40re8eNL+/peQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mcOTmyYrP0yoEpcKTLkJf55QoO0+7lsXv14qZvA352ZkEs/Yldaq1bIvJUTy+usbEtVnYXiXRIHBLHznwtoTX4ByGJRt50T1xKcF0AA8qdUuGoNSHtFUBVG/TrPcr49yKO9ee5wGxRlRuaAM6l6W81su+KL76KZCKTFegSRAdL5CkzEuIlGuCKb+nF6pD/+ial+MtPECnGwmXIxhHUOyQlLarhY7LJLA7wZXXJPbj12t/QyxiIK9M5pUAmtLsDYWh9TJcQ3gxX2p+57zu4IFau35kFkDcHLClWEpobEePMMgoLlDYRvVK+5YG6cCnM3DuO1GGKfzBEM7zoZxi3Oa+Kp/xTK3PxkLvdmo6q/522vY45iTd+6Lk2NDL/UegEFKRxy+jaY5h0EZiorCuRKpY7Clf24nSUtWpoIhbsS+NKpcgnU6rWW+KosVQA4DjCur
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 12:51:36.5823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9da96fe-af95-4fc9-9f4c-08def2271eb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210
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

amdgpu_pci_remove() calls drm_dev_unplug() before invoking the fini
routines. After drm_dev_unplug() the drm_dev_enter() guard in
amdgpu_ttm_fini() always returns false, so iounmap() for
aper_base_kaddr is silently skipped. On reload the PAT entry for the
aperture range is still live and ioremap_wc() returns -ENXIO, making
the driver fail to re-probe.

Remove the drm_dev_enter() guard and call iounmap() unconditionally.

Fixes: 9d0af8b4def0 ("drm/amdgpu: pre-map device buffer as cached for A+A config")
Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 0b00625603c0..5bcb6a966941 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2278,7 +2278,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
  */
 void amdgpu_ttm_fini(struct amdgpu_device *adev)
 {
-	int idx;
 	if (!adev->mman.initialized)
 		return;
 
@@ -2301,13 +2300,9 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_FW_VRAM_USAGE);
 	amdgpu_ttm_unmark_vram_reserved(adev, AMDGPU_RESV_DRV_VRAM_USAGE);
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-
-		if (adev->mman.aper_base_kaddr)
-			iounmap(adev->mman.aper_base_kaddr);
+	if (adev->mman.aper_base_kaddr) {
+		iounmap(adev->mman.aper_base_kaddr);
 		adev->mman.aper_base_kaddr = NULL;
-
-		drm_dev_exit(idx);
 	}
 
 	if (!adev->gmc.is_app_apu)
-- 
2.46.0


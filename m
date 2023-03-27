Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79383C77B60
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:36:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3474E10E742;
	Mon, 27 Mar 2023 19:36:50 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D16F410E728
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:36:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZ/f6CUfRyrC86zPEfaw/zj6kwB3S9TX8BdIqoniwDuxHdUWtDiZ7f1dPgHMZ8ZzAu69Xy9qSaPWkCaV4plGOolFmOsmBXySN693eDyBn3AHtvFCGJxt6IpEYk1JB993ukE4olG4D2h163PGaiH6P2rLnayWQmA8lrtgFqKRaAqGgG2iRuM24ZJoKuiKp2uZ7FCtWrfnWdnQYRdAyJQIPn8omNf+ijBViZNLRYDtNgf18ge8Df5VhS6CmxN7JqppkxFcR1EYGhgvOWg8Nn2AdqQWIvDUJloQJj5MpXt3p4TqOWAx9qWE4+eC2nYl/8xuVK0O+jGT4TwCR8O6zmFj0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwLf34otxJr3OsaDQIBlceNlgrGbTlQTdBd4MNZE7kI=;
 b=SsvL9qk/wNfovjjfl3/7Ekj8+En8byy8kimhSkrG+rmX5JHxdQ44toPRWB+qt2yoBnRSUvVEUAv6BsHYCdWK3+poNfdoJyz1tDQnhnCOY0dTHeYUMTjLvcVHB+lJBlvpeV2Myp1ZfvzfmSLvUUNgH4aCo3EHYt+OIv9d28wvvv6D0VjrZiUxKMH7pT3cjW4XdNZU0DLHEIOu67XliPsX9Jhas4Uy+OMm9ta103q4rPA5LcKUpZsFw8pYMrtSGv3at5550ycsyz04Kxqy5nADARcQGov560tq1T1EShRXl+nZSNX5XKSnAqQBBAuGPtC8YFSTvnsedfDZWEVRBcNU6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwLf34otxJr3OsaDQIBlceNlgrGbTlQTdBd4MNZE7kI=;
 b=PoRq3NTCNfscGXXNTBI31zOUsyQyACvYrijvcvaE89NTrMeZtImVXXmI/yZqHlPHURQnTVHOX0fckV08+IKGec9xgyV2L5MhFsIp6PEqRzbVK4qYNfEq+ywOuZJ0cFkxZNwF2h8WjH2f8KIIWuGpmrw4Dhphwtg8dn5OLejiGts=
Received: from BL1PR13CA0389.namprd13.prod.outlook.com (2603:10b6:208:2c0::34)
 by PH7PR12MB8793.namprd12.prod.outlook.com (2603:10b6:510:27a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Mon, 27 Mar
 2023 19:36:37 +0000
Received: from BL02EPF000100D2.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::e8) by BL1PR13CA0389.outlook.office365.com
 (2603:10b6:208:2c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Mon, 27 Mar 2023 19:36:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 19:36:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:36:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/28] drm/amdgpu: alloc vm inv engines for every vmhub
Date: Mon, 27 Mar 2023 15:35:59 -0400
Message-ID: <20230327193602.7901-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327193602.7901-1-alexander.deucher@amd.com>
References: <20230327193602.7901-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D2:EE_|PH7PR12MB8793:EE_
X-MS-Office365-Filtering-Correlation-Id: af1234d5-ba56-4dba-9c84-08db2efa9499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7NT1imKOfukH+NbZpLUX4VFvpNte6HvcvkbTiEmqvhkCfcufbSa7bR7GlGRU8LNRl5H/pJgSfXTp/d2z4kg7pDhwwgGmLh+BYLf6Xqxp0imcp+1K02B6gLElBVb7/v7XkhRmT9RiMtCjoXOHwfs2wnICNEvWyXmYUurMF4n0pg3VhGEfBa9dnMWIMEKOR3qsTABrIyY6kW5vzsJfN6rj2w8Q6rtJjt2Pk0tSsTW2qJxBfOHifh43gl+588enWcUxkx+CZ/XW5tUkNL3q2vlEnywWlD8oA/rxJyADXcIe5v4SyxZLz5CkH6OrzES75XOobFNNHnZXaWArZkkJMSlWdSkt5me6+q3tPU4dN7tTpfQF1pA8TDr8aUE6Erq7ZvGUm6V59xLHjFTKB4XNo/zQCPf2E8BvZWXsyIU5pJFpDlhUBvuZHxFa8gfca2o9Px2mIT0r3UScVbYVm+4TaJYBXnzwitIF+6LLIC4+U/Mu+8Q5c5MhrfSFNRle30wWJRADpeuE7/3UOPq0Jnu3Jzv/gQIJqSr3bFKS5ZsGzgBjbyO5RpUlQozb2ElBJ63hx64CRSZYAymaGjkOON7qg8SHMjHb75WHWvMRb/wtIRFpFcibkyJOm/PEPcs6xZaRHx1Ij63xNW0eu/sZEbGuIpGjzkhaEOBebuoEiT009UgYpeTr/TvbB1i9oiZH+nk3Q13ENyUV1QGYNImQMIvmzIxUaBDJmah8GWIHjCy9a3SQCAU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(70206006)(70586007)(41300700001)(478600001)(54906003)(6916009)(4326008)(8676002)(316002)(8936002)(82310400005)(5660300002)(356005)(81166007)(7696005)(426003)(336012)(186003)(40460700003)(82740400003)(83380400001)(26005)(40480700001)(2906002)(16526019)(36756003)(1076003)(2616005)(36860700001)(6666004)(86362001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:36:37.2385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af1234d5-ba56-4dba-9c84-08db2efa9499
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8793
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>, Shiwu Zhang <shiwu.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shiwu Zhang <shiwu.zhang@amd.com>

There are AMDGPU_MAX_VMHUBS of vmhub in maximum and need to init the
vm_inv_engs for all of them.

In this way, the below error can be ruled out.
[  217.317752] amdgpu 0000:02:00.0: amdgpu: no VM inv eng for ring sdma0

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Christian Koenig <Christian.Koenig@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c6b2452e8258..14789a0ad6e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -503,22 +503,21 @@ void amdgpu_gmc_ras_fini(struct amdgpu_device *adev)
 	 *                    subject to change when ring number changes
 	 * Engine 17: Gart flushes
 	 */
-#define GFXHUB_FREE_VM_INV_ENGS_BITMAP		0x1FFF3
-#define MMHUB_FREE_VM_INV_ENGS_BITMAP		0x1FFF3
+#define AMDGPU_VMHUB_INV_ENG_BITMAP		0x1FFF3
 
 int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
-	unsigned vm_inv_engs[AMDGPU_MAX_VMHUBS] =
-		{GFXHUB_FREE_VM_INV_ENGS_BITMAP, MMHUB_FREE_VM_INV_ENGS_BITMAP,
-		GFXHUB_FREE_VM_INV_ENGS_BITMAP};
+	unsigned vm_inv_engs[AMDGPU_MAX_VMHUBS] = {0};
 	unsigned i;
 	unsigned vmhub, inv_eng;
 
-	if (adev->enable_mes) {
+	/* init the vm inv eng for all vmhubs */
+	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS) {
+		vm_inv_engs[i] = AMDGPU_VMHUB_INV_ENG_BITMAP;
 		/* reserve engine 5 for firmware */
-		for (vmhub = 0; vmhub < AMDGPU_MAX_VMHUBS; vmhub++)
-			vm_inv_engs[vmhub] &= ~(1 << 5);
+		if (adev->enable_mes)
+			vm_inv_engs[i] &= ~(1 << 5);
 	}
 
 	for (i = 0; i < adev->num_rings; ++i) {
-- 
2.39.2


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E17C3ABDD
	for <amd-gfx@archiver.kernel.org>; Wed, 14 May 2025 17:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E69F810E6B2;
	Wed, 14 May 2025 17:11:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qFjs0HYu";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8F9F10E691
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 May 2025 17:11:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVWahMHlSq4rVN2AXfBg1dlWF9h+6lb4voCJy7qGUt4aff7I329ls8I70wpiVJOMcs3IhK0kRBG1mZ+P4BIP7l7QEwHK5cNkAvfgz20oXZg8t0KSG4MEzNn8bz3iknU4OffB78H4f8iUM2RLW51r38r/uZs6GSUMYEk1rH/qAky+CCq+lbH5olrHpInTH2BWgt1ekQVnvAcZwpGP8yEiI2uKwpxt5QbGyNB0bUqeIECFIpVcAE9ymA9kxRexWtzzmtOxpgiTd8nd1kx8PYZesgl/nSWTtVNnvwnolWqDSRLZrh9jspP9EcwyjkYiEBVYNd7U61H4gsMEs/6bEAIFxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ecb7BTosRzus8uI+JiJ/777hkaHTeSb3980SCYxdUMg=;
 b=ZPOFrYxGksin/erWi/hH8oKdSX0BVRL/CxHzwoS0G9u7UuftqILXN1N2QJvTtk+/GB3ZE+P6svXJmLomAm2Vb042XotrSxBLElTFaE5sX34+2dNmPy+ljm9Q1WKO1X2eRNHiRAXuZpX4Rtw0pjbCcrPHsEnAjYkFYnzWuQGgk4eSCdRvbDT38+EMCgD6PewoF0JULN+yM1xBbmn4bBOfDB88ZM8wEzkQPn5xA+Nyvib72LlnY8kc1TB2p0vxNs3wZdkSL3l22JD51UXJRM5JceB0c9qDpy0uh2WhQOkY39hOUL4uzJ6LppeDcE3Sfd/+70XRJAk+fOiDOXvbJKEsAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ecb7BTosRzus8uI+JiJ/777hkaHTeSb3980SCYxdUMg=;
 b=qFjs0HYu+VNdhQ+iEifFGxUtMpPAeOK5wWo+Tw2POP+HpKGnWbz+TQCo0IZPrdB33qmetKlmAK0RA7jxiN+DerL2JiWvJ39WBwyl/fG/eNQ6kRwI82xsrgJ718iL+Wa+fVOQWsSiH1xE3BAPd2Fguks0o2sqnTdvZY+H5lvG7tY=
Received: from MW4PR03CA0243.namprd03.prod.outlook.com (2603:10b6:303:b4::8)
 by SN7PR12MB8791.namprd12.prod.outlook.com (2603:10b6:806:32a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 17:11:12 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::e5) by MW4PR03CA0243.outlook.office365.com
 (2603:10b6:303:b4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.17 via Frontend Transport; Wed,
 14 May 2025 17:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 17:11:11 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 12:11:08 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: seq64 memory unmap uses uninterruptible lock
Date: Wed, 14 May 2025 13:10:02 -0400
Message-ID: <20250514171004.4259-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514171004.4259-1-Philip.Yang@amd.com>
References: <20250514171004.4259-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SN7PR12MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e239eb-28a4-413d-2943-08dd930a536b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m+tqcRD31xJiwHTtpamnyyplkKHJtSqQeJTTGzq6h0RYl9DKl4ADmm5ONYE9?=
 =?us-ascii?Q?JVCNOz8wafTGpPy66rxYkOGAmCf7Z1zee4dVx5Grs4h66ex7rNieM9moihcM?=
 =?us-ascii?Q?WKWrIrgYTjRnHw8GIXkRiX11zBtAFRS+E4NKwq73u2nm9QoXGJL+HlC/aZ6W?=
 =?us-ascii?Q?U6EUAJ3s9I5xRe+EJo187yWVkzN2qvNNSTPQeEsJKVMoWvri+WFv3KcXnzOR?=
 =?us-ascii?Q?6xsyODA5y/BZt/TrQot+Qk/azvM9MiSeXnyqMqOm1hg+HnHlhKvArPDlfGC9?=
 =?us-ascii?Q?Q7ADzeBA/Nsumms8HJXoi60iJCGAQ/xkQ8sBrcKexSfA5JpPlrpdj+I3qUEW?=
 =?us-ascii?Q?N6Zm9GaCUCKFrjHqLLck6OVps/1X9vnKqTBqh18VADxKIPQyJhZd2U6LXics?=
 =?us-ascii?Q?+1mvPg0cOIxcpwc4jm9FnUR/8BiaOq2g29PcLtYjySx4nWzAJM0L7koGcocy?=
 =?us-ascii?Q?IGn2SKCJzE0NWaVwTnIrLbZBYglZVb/DypUkFyuXJg/kvSj5g5P8bgG1WGCA?=
 =?us-ascii?Q?xlLQSS0JVtoecD/VVjdA+Wx5WxD6mVupOm2rDTR+R9Xkl5ynvoTeWbG/3GDA?=
 =?us-ascii?Q?GwyYSFHaV8lEQvpHgJ94sPJq8ReUVtwkDWwSWtMaVH+O6BXNsIfliIVJNDC3?=
 =?us-ascii?Q?+f3IgE4WHw3yX7Zfc9Q2FqNSL8bSFbg96xsXqhDf0/cZYAFULX3GXeMUNNbC?=
 =?us-ascii?Q?X6YSONPU1SBVOW5QlOgWqbyFi+zvMbXVntIF0vk5xeQ1tAPVrTp4PX4CATa4?=
 =?us-ascii?Q?ByyLvvGVY5/pnTwEMlgmDUzlFQq8/HGzGXXc1aC7JF3vafByCG/UKOibZ4ri?=
 =?us-ascii?Q?Yi7zvwzSsTYnbXvXY3T8Dzg1x5t0OFv2TvVrdqkG229y02BqgfrC/DwFbq1C?=
 =?us-ascii?Q?H6dURHSy8WWCaBmsDIraRmoaLkKf0e1/EFvoWVryfB8tRh4mj/knS/mKOFzX?=
 =?us-ascii?Q?zr18GLUR/J5L28+LlXPi15iNsMJsAkOUjwtBH1zXEZwBGwHfqkNkIhjzLcJW?=
 =?us-ascii?Q?dywr87l+WRGcE0+XA8Mz1aWf+KaO8k5rhmyjrJH/xHra70gMmZEUXBzbxX/I?=
 =?us-ascii?Q?y51xjMmgUFZuqNidk1gHwBEbs8Xv1/FXMliuzbgaVCyxAUfpUP5RX4oup8Sz?=
 =?us-ascii?Q?jNr6w3Pbgip1H7Zg2iJWMVpM8TUPIPIWlt+/JK5T08cmWGONQ0kIpkBTxEiJ?=
 =?us-ascii?Q?0Z0O7iJFfTG/HmuGl/0jcfyfPxBdXYDHD1cEc/Wt4S2yMDKQhc2cg2GjliYp?=
 =?us-ascii?Q?zLPu15G4pyi7KPL2h/lUHMHLcd8MqJaaoOMwaoPmimzZkdAvSWwmYdVHFLqF?=
 =?us-ascii?Q?/G7AGnEJejTlA3g8YYUDMIiOO3fNfB/Sup751BucRE1w7rT2MA6G4VOgcnWc?=
 =?us-ascii?Q?A3O5Nh6c3K+OFi6/YnfgD8jB+iaJEP+S9WYlkzhdALCizXkQdBXQZ0gX2sr+?=
 =?us-ascii?Q?N5woY7ko4+FGKGY9FeA2YgI8NkRPyv6S8eGBHNgQIGEBTqeQ4vJAw7sSscA0?=
 =?us-ascii?Q?8JFo15yRlkfWEtQjwt1AoRML2dU/cpg9XzCc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 17:11:11.3488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e239eb-28a4-413d-2943-08dd930a536b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8791
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

To unmap and free seq64 memory when drm node close to free vm, if there
is signal accepted, then taking vm lock failed and leaking seq64 va
mapping, and then dmesg has error log "still active bo inside vm".

Change to use uninterruptible lock fix the mapping leaking and no dmesg
error log.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index 3939761be31c..d45ebfb642ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -139,7 +139,7 @@ void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv)
 
 	vm = &fpriv->vm;
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_init(&exec, 0, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = amdgpu_vm_lock_pd(vm, &exec, 0);
 		if (likely(!r))
-- 
2.49.0


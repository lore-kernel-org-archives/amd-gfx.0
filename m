Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42BA1C87FD2
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 10:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA4CC10E4EC;
	Fri,  8 Aug 2025 10:32:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fdVzayIR";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB1AB10E4EC
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 10:32:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfHqgwCq8feMgCTS8svPrkeQRoWak/AQgraLAsFijMNefiuBCeNPfngbzQUowSxruJgz53+HsQTwS0YbO6Up6w8YBqW+73TjNKuuEXGqZ5blRuya1pMBlYeJR0A35UZxtuC9vJumo3GwvCpa16HW1VOO8sMgSECRiGEWa6j1TPR8EmymzKWG/k7fAXO8BasrQgy6sCMJNcOb5qlxQ2Iey2vsphg/00OpBNCwAcGv728SkDakBjOzeOeW/CVGBDhvLN3yEwqMYYqdQZttiNNflP1pRMrkeUspbKNjw0/35dQmYaw7R51OpYphl/U4eEudSRhcA04W39qJBZUPcL7f8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eeahcJNMxjaDeSvF1Mf8HCe/Jw6ezI04bPd7ww8xcY=;
 b=swIrybcNcliEVvRlTxWQx3OuKg7btFss2tA2pB3CaMskPtbGMQlXXVShDCXWXCaT94ddZWzPFDYJAnqlQK7oSGDsKhjAMbEQkGxzMHSgrrg4DP9pohMRMCcF+IsMgbg6OhGBkt5z+8r6IR424t1/TCPcKZBNxS704F2aKj9lbeSVbGr7EY6633/B10SWEsL3jFmjxpru8XG2R8gHpgC/gBeNZt5Zkdha4wdN+3KjiLDXckGVhHnDgcdjltI47yqRvOgLLse5rSXhRT7L5uEN2h6nn39bRXMcPGKCg3Am5icQ6u/cuT+ALasgpzeOt2uMfF4dpFPO0GgvzqrIjj971Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eeahcJNMxjaDeSvF1Mf8HCe/Jw6ezI04bPd7ww8xcY=;
 b=fdVzayIR81twMLGV4dYmfcCQj7MUX38Yv0+BdnxUWdYJ08PRBzudx/Dd+Q6zxyz6ayGs1gwhHAptwlxMYPXIZg7wCMZAvVJdojdGLErvQerjv2pPusq1av6xgA2oA7FqpMzPVqIqz6ctQxjir7CGcMGAJUl7xHih4ThndVXjano=
Received: from BN9PR03CA0317.namprd03.prod.outlook.com (2603:10b6:408:112::22)
 by IA0PR12MB8746.namprd12.prod.outlook.com (2603:10b6:208:490::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Fri, 8 Aug
 2025 10:32:30 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:112:cafe::5c) by BN9PR03CA0317.outlook.office365.com
 (2603:10b6:408:112::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.16 via Frontend Transport; Fri,
 8 Aug 2025 10:32:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 8 Aug 2025 10:32:30 +0000
Received: from marui-Super-Server.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 8 Aug 2025 05:32:27 -0500
From: Heng Zhou <Heng.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, <Christian.Koenig@amd.com>, <Emily.Deng@amd.com>,
 <Victor.Zhao@amd.com>, <Felix.Kuehling@amd.com>, <phasta@kernel.org>,
 <Qing.Ma@amd.com>, Heng Zhou <Heng.Zhou@amd.com>
Subject: [PATCH] drm/amdgpu: fix nullptr error of amdgpu_vm_handle_moved
Date: Fri, 8 Aug 2025 18:32:04 +0800
Message-ID: <20250808103204.3919298-1-Heng.Zhou@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|IA0PR12MB8746:EE_
X-MS-Office365-Filtering-Correlation-Id: 75dc18a9-1959-4a6b-44c3-08ddd666e0fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V8Xd3b5Y3KGhE+LNJgRAD2Le7mANIhdKNc9wV7g7Lz4KC/a5SSURi+1yZHlN?=
 =?us-ascii?Q?7LZWUWZuaUKMwXt3sCi2Zf9TkBS2ptNCPrtqF/kdgl8K6lNZYes8FmlpFmxG?=
 =?us-ascii?Q?WQC01zHCE6KAdYJRf29os/ccV92XiToFC2yXX88JzAa4lb5ZxArU1O+GGTKQ?=
 =?us-ascii?Q?oH9ORdB1ThppWZdYzXn1nnGISrUBOU1GEWz2MZabE+sw8ipEi5eN2gFaRchM?=
 =?us-ascii?Q?qhhzeBcqW0dE6my3yZqEfXXfOoxCgMw6284n//Vt+mB8r2gX7I8JmcoVrCEN?=
 =?us-ascii?Q?KWFIHZh3YfB8Hb/iYzFc64me896/2UWb6bMgoIXZ/63ruA7svqv8AD26OovO?=
 =?us-ascii?Q?xVcZAl88Z8C6sCWn0mWCniO/C7x9nZcruuMbdxEv7DwMTT1AOmRiC6Wn5Qg7?=
 =?us-ascii?Q?dJn6aGo2KfydQrjevA6U4aLwNELWx7NEtyK1xj1ECxaCFstF3apjReS//S28?=
 =?us-ascii?Q?nMZQRJzoXwk+M3AzSMgkKrYHA2PrJkQB+zv/JzwYqBKoq96x66woR1FV9ACJ?=
 =?us-ascii?Q?lI7D8Cb2ZcZdOpt38BRp/Y6kvY6YEuO9b0mzzqLpweY/rMyfz6FwtxJHabco?=
 =?us-ascii?Q?+i6/r3lo0oSBbdTDUmpcC0DqTI6066go8wkGDeBZ7/dX+Kj3RPR5YTyJtpVo?=
 =?us-ascii?Q?50ai46yFtUk5dsdZx9ny6iJG2i9Z194GnpcKSFDGFsOyaxDsLbJQeVoK90Ce?=
 =?us-ascii?Q?TFANmePBuf/cmVdjcYmbW+0Bf4jGh4IH6RbvyGAfjLTytIBw0eIeAh584qSY?=
 =?us-ascii?Q?SxCQaJLzFzrYlGd8XTtwQUlX64gLd+pnktm14n5v9hdzXslWenCAeZLVz/Sb?=
 =?us-ascii?Q?6fWTb7V58jxrz97J7VfwFMBKERO36W5+uUmcBCqs3Jf4Gqy5XJr7YEYqMOTW?=
 =?us-ascii?Q?3L0VFu6HGvLbGsB/DdbFxyaQDFhteE7PP2wY21MUDGr5LVfP1x2ivXCv9RJ0?=
 =?us-ascii?Q?mtRiixhx9RLzlYY6VbbFgh2RIvMi8cc261BF3qLA/DDNmDl5HYcAVNjBOCXz?=
 =?us-ascii?Q?i50FxXRrHo1Z+XgoA/JS5yXsgPyIXJPhb0Wf59fhH2JTJNDyaDRlcA2xmmiv?=
 =?us-ascii?Q?0xGxWYFIDoYKWBIYGJ/3QJZKRO/ctPFy4+hf7/bvArym2Uylx6eVJ29Dl+Sv?=
 =?us-ascii?Q?aUl/ZlhXRgX1cUQSBq35iz+yV1avlG6Ruw+UwJPqkCD4KWd9/N9Gu3jOZiGZ?=
 =?us-ascii?Q?2zSnm5+ckRyU26RuFYxH060YzGk0o4ME3i/11uGsX0ojSB+LSAteSJwI/3bM?=
 =?us-ascii?Q?CqZcHUNjEjNzGSCCS2RERzIciNZvavuM4WLwqTWB5t/guPad3qWOPcS5iwho?=
 =?us-ascii?Q?VIiiJ8pog48RLvfD8plN5WAwZL+5cJTsgyegBRJIe6o7jnIfzUgX0bV3w5d4?=
 =?us-ascii?Q?Psx45+Pczc+lZaehqXB5wkCyNgQXf6fQMQrDsfnuD8dGdUp9NlZQ2txPa2F4?=
 =?us-ascii?Q?CC7DBx7SDdikrn1c6IfoVKTy3A8WUdyT0PAXc2twRKUuV4UnyO3u9e6BLFJa?=
 =?us-ascii?Q?XPKAWjXuLVpFKu5+02c4sZR4Cc08uQNs09cj?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 10:32:30.5685 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75dc18a9-1959-4a6b-44c3-08ddd666e0fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8746
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

If a amdgpu_bo_va is fpriv->prt_va, the bo of this one is always NULL.
So, such kind of amdgpu_bo_va should be updated separately before
amdgpu_vm_handle_moved.

Signed-off-by: Heng Zhou <Heng.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 37d8a7034a7e..f0af292fa326 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2970,9 +2970,22 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 		struct amdgpu_device *adev = amdgpu_ttm_adev(
 			peer_vm->root.bo->tbo.bdev);
 
+		struct amdgpu_fpriv *fpriv =
+			container_of(peer_vm, struct amdgpu_fpriv, vm);
+		
+		ret = amdgpu_vm_bo_update(adev, fpriv->prt_va, false);
+		if (ret) {
+			dev_dbg(adev->dev,
+				"Memory eviction: handle PRT moved failed, pid %8d. Try again.\n",
+				pid_nr(process_info->pid));
+			goto validate_map_fail;
+		}
+
 		ret = amdgpu_vm_handle_moved(adev, peer_vm, &exec.ticket);
 		if (ret) {
-			pr_debug("Memory eviction: handle moved failed. Try again\n");
+			dev_dbg(adev->dev,
+				"Memory eviction: handle moved failed, pid %8d. Try again.\n",
+				pid_nr(process_info->pid));
 			goto validate_map_fail;
 		}
 	}
-- 
2.43.0


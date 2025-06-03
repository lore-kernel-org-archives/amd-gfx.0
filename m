Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA54C5AD49
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jun 2025 02:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3FB110E597;
	Tue,  3 Jun 2025 02:19:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L4SVlVks";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E82010E597
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jun 2025 02:19:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsai8W9wEjKkJsbwoVfYSUCozw7sEP4iyLVx1jQQ/WwCzLkp8WuNZhzZdxW2+aIqCR4yg7vrul8ofC4z8mh9hfOgEsWTbnbrq2gyqUfOo1Ewb3iTke04aOapaGJSjKJtz79f8+p91lwieyJvuJ0UKvB8K86c7QBzxYJWzPPop4NoblQvh51re13ydAUbML7bJsboVYJfsdT9ilGPC9xfM02H0dIUnCUqYC+GF3FCNkrNqXEjdN3U2W80mC5RCpmOGER6hC1jnIK89Y2xite40Bx32/67Dk7cPf0G0utxd7CrDLH7EXdhhfnuUg4OOSRwq7PGyDRkDBvgrVviOoELkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bh4uV3H24FBYP6yK1tC25rA2oPC7Fm6vD2ZQ/BsnSPY=;
 b=vSqiDtrtiB6lyZKc+jdhgtXUNbS+4E/+VGEmo+iSW/LSFJuCDQI9xsJSAu6AhDfiuaD9V74dUE9wVvu/ZzieRVkuAhxNG9/ij9iOec7JqaibTj/ibzgDEbck/fv0A8QxEXeNTLmP/7loMOMtuCyCVJyyteVv0oiUkV56HO27fSnoKUptydxKPd155LFwXoNkN8X1re9C2wESLH8/nCCQQM2NTb8sw6J5+J6pRXexor9zcR+Qilcr9dGRDr4KnwafzictBjOQz3D+gnamjtUkO75vhJM8yebJSC7Jr1Zu6nJIJ6Z99Am+s7ieOFd8+hw9bScxexnvINB40lAqT/LdeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bh4uV3H24FBYP6yK1tC25rA2oPC7Fm6vD2ZQ/BsnSPY=;
 b=L4SVlVksqbrRbKl3oH+EQA9oNptROvCNbEszaMekh81Gdy2VkpFgcCfVwRUbnEeb3XSrzCqISWlFmDcy0bBvZAMTN3GEG+VS66KWC5NMbC/gqBNarB4iZ4kaMiOP8bE2prE8w3s2QtY1dnmKuarKrVUaIyDKCUAKk8+lPSfa7ek=
Received: from SN6PR04CA0098.namprd04.prod.outlook.com (2603:10b6:805:f2::39)
 by CY8PR12MB7363.namprd12.prod.outlook.com (2603:10b6:930:51::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Tue, 3 Jun
 2025 02:19:51 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:805:f2:cafe::ce) by SN6PR04CA0098.outlook.office365.com
 (2603:10b6:805:f2::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Tue,
 3 Jun 2025 02:19:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 02:19:50 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Jun
 2025 21:19:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Jun
 2025 21:19:49 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 2 Jun 2025 21:19:46 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, <Lijo.Lazar@amd.com>,
 <Emily.Deng@amd.com>
Subject: [PATCH v10 4/4] drm/amdgpu: fix fence fallback timer expired error
Date: Tue, 3 Jun 2025 10:19:09 +0800
Message-ID: <20250603021909.841690-5-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250603021909.841690-1-guoqing.zhang@amd.com>
References: <20250603021909.841690-1-guoqing.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|CY8PR12MB7363:EE_
X-MS-Office365-Filtering-Correlation-Id: 69813b07-5ac8-4642-86ab-08dda2451e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pMeGDTm79GjeVR6Ncd201aJAaTE3HG525XBvTr0fUuUj1XiOKg+Ha6MEdFUY?=
 =?us-ascii?Q?ARJMYoVBOZeznoVrkogQvPmyloate6x4dEqf4EUXj8K5uRuEJkPmGGsGG+oL?=
 =?us-ascii?Q?jLj2nc9PwVxEtHHxosC5He1R0d0zNqh1mAWtrIhiPRQ7mf77Kex1lMraDx+5?=
 =?us-ascii?Q?RY0mAu/buD2Yx/Q7jS4UfpEYkpyRAvaQLsLV0O5Q8dt+8/WGzrst1s3OeOIy?=
 =?us-ascii?Q?7BxuhW7xMpZp1Pji9ixzEeOBySlU/2C3hTOoHJmc0OehSFLoDIAjCLCqPduu?=
 =?us-ascii?Q?AFKUJhFfsEqVp9Lcj6WhxGyKMRaSV1+Er9tBqSDB6+EbsaQH2xGk0ev/XruD?=
 =?us-ascii?Q?UUYVUT4gf6wTBNbQEAZhP4o+r/mV947ZPtxWMrKDUC2anb4DLt/tT7vZesOV?=
 =?us-ascii?Q?PXfni5hfVs2r2FghGGk3eCwzQ5Pyq8hNgJOcoufkzngHt78Zvw7QohFH3vWo?=
 =?us-ascii?Q?EWolxLBu0NkNZRMRTpJSEeNryFiZ1Ricb6cNwwAh5UpveN8I6ZShoH+lLaJl?=
 =?us-ascii?Q?xC4qyrQGfKz8Q5Eamc/9LW1oYZ7jgZNCyQ73loHh5+GtrSBGEqqO3JqYY3+z?=
 =?us-ascii?Q?pM7Nzo1Sr6XUE93lKQuk/RGowLyU+U40YQcDD0HrOA3A5VzLolcpfSgYI6cM?=
 =?us-ascii?Q?WAKv1B6UJXB0iQuObsdQdkhTHbqxS/ouBjcyFVfJRKp6O+RGiqk3CaoV3uan?=
 =?us-ascii?Q?tHJkSYSQWas9IOmsNgzGUUg+cvj41vvdlbC+SGzKTR5imSLy/S7/cmFXrKLG?=
 =?us-ascii?Q?Wtde8Dnz/JNGnrmRaNPWJZWiqmkZJQ58IN7CTOjCmk5Tcwa9cCZmGA9q9xO9?=
 =?us-ascii?Q?hbIb2PvS4hLC4uiJK0LoVKRlkAeR+4/KwZRmsPg23amr5lrbiKFkyupiv5Oh?=
 =?us-ascii?Q?X6MhGj0nuOY6+AArLpQrouPHkojxUjPtZxW/ztpMeAVSEl8+ASw4aqZcwiwx?=
 =?us-ascii?Q?77kkSj8PHO+Ne/SGyg1tQuo6Dy9pTBgO20LsLLdSemsvgOxImanU/3DgdbN6?=
 =?us-ascii?Q?nyHRlDMw6KBm2WEx5EsppGh0KAunAqNKLpI1QkmZctMMqMNWDAgycjAR50BE?=
 =?us-ascii?Q?R5mDUi99bdJ+fv8+D/HQ2PNpTC55HFiFHU5nuL3LazzczDZNUvUUBOjafrkW?=
 =?us-ascii?Q?eMIj+G4nE5nnK24KknjJLccXloheSQBfWBCS1Atr3Thrvp30Pv5KB7tVMHnd?=
 =?us-ascii?Q?gTjczOj9J4+Iwc+cw4TM8iWac/f7TbCMNVHbF0mPi9VLuXHaER+S1yJuIkf8?=
 =?us-ascii?Q?LUqjofdf3vdZFnIf/U7ZqAMs45lddB0BE82VL5lYfdVCu0QhA83ob1s0jS66?=
 =?us-ascii?Q?DGqZVymLjAsw7kiqBWqhcst4hnvAbVb/ETMJuvZi2SDZORn7k5VIoN9rpOlc?=
 =?us-ascii?Q?0WWX6Gzy536pGzQUBAbU/zmV+oTeDunR12tzJ2ayeG8xJRmqtVhfGC2pdyVk?=
 =?us-ascii?Q?68AXlB75sINJp7iFkaWOKvmClgB1bh60GFBl7PdwyqaHmg64R6t16jawjSaD?=
 =?us-ascii?Q?uKvHE0eLNLEa4eKyw8m+URwranwh7dDUy7MX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 02:19:50.0531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69813b07-5ac8-4642-86ab-08dda2451e4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7363
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

IH is not working after switching a new gpu index for the first time.

During VM resume, QEMU programming of VF MSIX table (register GFXMSIX_VECT0_ADDR_LO)
may not work.The access could be blocked by nBIF protection as VF isn't in
exclusive access mode. Exclusive access is enabled now, disable/enable MSIX
so that QEMU reprograms MSIX table.

call amdgpu_restore_msix on resume to restore msix table.

Signed-off-by: Samuel Zhang <guoqing.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0246a33b90af..f67bc9a52d53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5051,6 +5051,13 @@ static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
 	int r;
 	unsigned int prev_physical_node_id = adev->gmc.xgmi.physical_node_id;
 
+	/* During VM resume, QEMU programming of VF MSIX table (register GFXMSIX_VECT0_ADDR_LO)
+	 * may not work. The access could be blocked by nBIF protection as VF isn't in
+	 * exclusive access mode. Exclusive access is enabled now, disable/enable MSIX
+	 * so that QEMU reprograms MSIX table.
+	 */
+	amdgpu_restore_msix(adev);
+
 	r = adev->gfxhub.funcs->get_xgmi_info(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 0e890f2785b1..f080354efec8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -245,7 +245,7 @@ static bool amdgpu_msi_ok(struct amdgpu_device *adev)
 	return true;
 }
 
-static void amdgpu_restore_msix(struct amdgpu_device *adev)
+void amdgpu_restore_msix(struct amdgpu_device *adev)
 {
 	u16 ctrl;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
index aef5c216b191..f52bd7e6d988 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h
@@ -149,5 +149,6 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu_device *adev);
 int amdgpu_irq_add_domain(struct amdgpu_device *adev);
 void amdgpu_irq_remove_domain(struct amdgpu_device *adev);
 unsigned amdgpu_irq_create_mapping(struct amdgpu_device *adev, unsigned src_id);
+void amdgpu_restore_msix(struct amdgpu_device *adev);
 
 #endif
-- 
2.43.5


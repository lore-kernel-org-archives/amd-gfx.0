Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8951C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 20:16:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08AC66E85B;
	Wed,  8 Dec 2021 20:16:59 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2067.outbound.protection.outlook.com [40.107.96.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD1D36E85B
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 20:16:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cu2qqEpr/qlCh20co13A1CrFw1PLKFq3Xa98hmuj2nNvm0Gh0k8wkIQnvBK2oAUfey4juK48vgtfeNdF3qWVdohgl9IKTJ+JagOwMRRLkRTG6Gs/HeUr3MBOdTL/REklnUUv+t0HkMTZh9XYsa1ahQ58F/JVwSF/EZMOO3apN0/UoHar3gkGjKqDVljKRA/PASYGJbJXX8IxmTiWXjDuMmEpl/7uPAsdpWGjfMUfxLbtsZ42QBUS9lgt8oKif46ZBNot/1ED3ECBDcZPUxYYFBmGXPpbO913d+ivVn2piqA7qqNgvDR/5oo+YetI7OJi7al5MZRTOmnMsH4XkUR4aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfkxqMWe6Ge20PN0XwP5YUE75wZWr14hnR5Iib9gI5w=;
 b=b6koy+tX7Gvkqac0Yl9HR+SqafK+2Nj10gS3yznuAkgcGDk4kKES9oKP3s3M1/keHFHkmukPpmrwgR5Qda/CMzd+J00ivYwYMGEVaJ7ddCznMzIr5tXZSDP6PwFsmqV/rpuU2XvPfdqvPf/mZ6GT26FEeYnajzFRHc6NOsaqYJbBXZcMEwbDDaOsvjqkjnOdMIr6e3zpDVwGlXut9MkaDWQCumSdJptLBtJ9DajVN6iPXl4aNGDRLegT7+jd59PUlUGYCyPMeG4Jg6ChOrnuSOKA8FT1+1S5Hmp1wHtiuGZKTZdlO0iEPeawFFKmYFFIck+VPVfRtPTS/ilE/A6UCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfkxqMWe6Ge20PN0XwP5YUE75wZWr14hnR5Iib9gI5w=;
 b=qpPJGATpoyUoshBiVN5byxnKlxNv6OvGI6jfSsNSHz2o9w81wuhe2nw7H79BbtbOtUYfYnq8z/Dw1rtYWoLulxzQ/D9sMnlu9RDMwxOeqYN99BlqM51Q64BTiFzetevFUXGCv0BCnkDJBSIM3oNJ7KZD0QUJ4P67zwlwotC1twE=
Received: from BN1PR14CA0004.namprd14.prod.outlook.com (2603:10b6:408:e3::9)
 by BY5PR12MB4901.namprd12.prod.outlook.com (2603:10b6:a03:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 20:16:54 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::96) by BN1PR14CA0004.outlook.office365.com
 (2603:10b6:408:e3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Wed, 8 Dec 2021 20:16:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 20:16:53 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 14:16:48 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Handle fault with same timestamp
Date: Wed, 8 Dec 2021 15:16:18 -0500
Message-ID: <20211208201618.10551-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29a6b9a6-ef5d-4b21-12cd-08d9ba87ad11
X-MS-TrafficTypeDiagnostic: BY5PR12MB4901:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB490157370E2617041DC341E8E66F9@BY5PR12MB4901.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iVNzOIazhovFirt/oa5kwgNoTXmp85sACqUfqadRiBbAh4OOJC+jrzwzqcyUXBMOwoYe8hBduQw/sYiXRzQB4yMYlxqVY1iEDScHexWhpVw9ckdzX4XuzKl5SRtJMKl+WW4pu0d6+w69My2+PSDnebnX6k1MVWzWO35W/zOkBaH1JgMXLmTrVHvbS7cZRHSKOsO5+0Tkv/YKf+ouKGZPHoaOTSSGPqHZkyviCF3yeY5CcNYgAlZ+ndxTqFcYkHcpdIH6iYmAdy3poTxyfQc31acTCnKDOz8YlRquy4/U4cbkJkR77HVYLrIa8t2LHa3d4LbuG8honlVYJOaH/iLTBqbLFpQP5Qes4DZnvS6U/dnAhvU02qoS0Pqolh8FrP5tCGySCIZAbwaK0Wz/pOLCQLb+OrU/4hts6IgUuaRoxGqnl/u0svOX1DhyEvgdOnkcm2oApO8n9n/vK2jyvBE6JPWx7tmYfeXImPPEksJr9q/tfhB8o9DyKoSkNXmNKxVuIBl0h91UNX7YSdLXD7lGBqmUT94E/iT3YexqheXO2a51EM3Nzl0eEH7PTMqMR0YmOyvksmjqaDjaqDfWzM+Fl0KnLkdxUdVRGTiyNxFdtqkX8GIEST39NEzmrpSHHARFoxuhRruYk5qP53EdwuDOV+FSm9Y3Bz4hGRsl3Dsxcjg/8VNZuIjA2Lzx+0ZMRa7bSkQS6BEWn5Kvq6IyrbFaWM73Q2f18MU8cQhI99OeqkGV9ycmYFyqHrm8i3hwF2q4CZRwzjQ6b5HNm7+T6bZJOJy7HecK1ZWPxFsIrwflW2k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(70586007)(7696005)(336012)(1076003)(508600001)(2616005)(47076005)(186003)(86362001)(4326008)(16526019)(70206006)(36860700001)(426003)(8676002)(36756003)(40460700001)(6666004)(316002)(54906003)(83380400001)(6916009)(81166007)(356005)(82310400004)(8936002)(2906002)(5660300002)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 20:16:53.6095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a6b9a6-ef5d-4b21-12cd-08d9ba87ad11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4901
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove not unique timestamp WARNING as same timestamp interrupt happens
on some chips,

Drain fault need to wait for the processed_timestamp to be truly greater
than the checkpoint or the ring to be empty to be sure no stale faults
are handled.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index 8050f7ba93ad..3df146579ad9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -188,8 +188,8 @@ int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
 	checkpoint_ts = amdgpu_ih_decode_iv_ts(adev, ih, checkpoint_wptr, -1);
 
 	return wait_event_interruptible_timeout(ih->wait_process,
-		    !amdgpu_ih_ts_after(ih->processed_timestamp, checkpoint_ts),
-		    timeout);
+		    amdgpu_ih_ts_after(checkpoint_ts, ih->processed_timestamp) ||
+		    ih->rptr == amdgpu_ih_get_wptr(adev, ih), timeout);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index e031f0cf93a2..571b11117992 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -522,9 +522,6 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
 	if (!handled)
 		amdgpu_amdkfd_interrupt(adev, entry.iv_entry);
 
-	dev_WARN_ONCE(adev->dev, ih->processed_timestamp == entry.timestamp,
-		      "IH timestamps are not unique");
-
 	if (amdgpu_ih_ts_after(ih->processed_timestamp, entry.timestamp))
 		ih->processed_timestamp = entry.timestamp;
 }
-- 
2.17.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C01CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Feb 2022 18:56:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D521510EA6A;
	Tue, 22 Feb 2022 18:56:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B52F10EA6A
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Feb 2022 18:56:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Adw8h9dYa48XkPlXjRh9+MA0mS52OeJaltj2vN/6vhB95NncY6Yp1wP8qX4LQasWT6fwjoZrojvHCVQuwhCKsYHsrsAajXF65/LlGiVXWHaGoVfAMJ9oNQtcq3CzoR741p8NOCUBidSitbQcwwM3ccwA0XvVFEwPruNJy+VWavJy5EUtwN/9R3gWLuT8/3rDopGAH5WaL7F01c5zvAhhnN2iY9Hpn0MrTVcZl/Dnt0Ae+DIpLTtsJ8xINE4oizbleuNzW+ThKKkxdACFGmhUTSN+2gqcOMR/jJO55NDCWIeitPkqeKHf/dWl3kK0lspytfzmR1auus3ExZdzmLO4+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3OnzJlLUYdLk9PLVqCWnGVuICdhMDReUouTY2lNRWU=;
 b=BYGfw3ga7bf0H7xe0r8Lz3aIpLvT4LgA5Ot3aFzaqJJKGUt6yMyY3WQhib4sCLXfaJTZnWdE1iI0Ga6kcA4ekaSQqikiUieG6VeSY17p2tu9jJBX7ShEC+6Nytb0U9Rh3GvGDtHvfWoHsZmfvUeIJzsL/FyUSVpeR67pPCpQS/H38/Rbgn6GEAMB+iMdqONxrWeN2xP+VdF4cHJoGCEwOtHFQ7n6X1WnQg139SWTD0lnVBDSYbc1J9lWzO4W4MNFywW0/RGgGV+Cq7DP+D9a1pWkMp56hxavZFilYiakbKV8H+nP/hLCyprGctMUFcQcATSsUdRTouDTsxooujLlTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3OnzJlLUYdLk9PLVqCWnGVuICdhMDReUouTY2lNRWU=;
 b=RK9Ng7QlyX2UeO3DSPKndbDWtnze/NP6NhDe3/+wp3HMUiwW82NQHjYXX/Wgqz9ky2qjALRbeQqZIjzc2fP3FAvrrYPLKE+sA91cXrzySZNkFYVvora5l0ouBmJQFU0S9Ea5QjVKmj5AeMYUYMVpEb/23uEQNQawXHaXbnxfoD4=
Received: from BN1PR12CA0004.namprd12.prod.outlook.com (2603:10b6:408:e1::9)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Tue, 22 Feb
 2022 18:56:02 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::89) by BN1PR12CA0004.outlook.office365.com
 (2603:10b6:408:e1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Tue, 22 Feb 2022 18:56:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 18:56:02 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 22 Feb 2022 12:56:01 -0600
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdkfd: Print bdf in peer map failure message
Date: Tue, 22 Feb 2022 13:55:31 -0500
Message-ID: <20220222185531.421535-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d7422e30-a926-a723-f30c-b414f42075be@amd.com>
References: <d7422e30-a926-a723-f30c-b414f42075be@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a78481bb-2cd9-45bb-47af-08d9f634f8c9
X-MS-TrafficTypeDiagnostic: DM6PR12MB4185:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB41853860B588AC2B3925D1E78C3B9@DM6PR12MB4185.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Uo6RVY/7I98TeDxLRNi63dFJtcZXSLk0QjQ85WHqrDnhJ/8eM4ts3/afJF6DufvpbT5k02Gt9PtyxSgb2DGV1quqTwpnZViMzl2TRKX1osmbp6Q4/Rtrke87f+7Nv+F6SM73kgob91k7Nz1gh2FKHvcEsNYQoVrNOB88DELjI1QtY7MVat8jck09m1fR4g8Ioyw5Wn883zyiZ1wCkWneJOo5INVjlxxgZ3JE0UVjFK8c9Q6SHg0mAESkG5+TNAd5KZEY91Gx6OF1Uw/fmK3n/RjrK1dGTNUzotpDn6QjZSWZjgNkOmMvI6nXUDV/YZH4P1zkU1OmX8/pfDoEo+um/42BEHR7gmNvlhDsB76OO8Eqalkyza/kku7kbS+dL7i/EUQbvPaGPT/kueQvx0CTzfFDMba0ngvk8C62lq+C9Pqcax1fLDZT0I22HTTtZeiDU/Wt2p/PbBjCtq+8SUJLe0XEytMFud63rLOJ/ansvytVO2c1iCPYbj79lBySmFmn8XeB3SyO6HBvxCHghpGcBYI58zLv66rVcRXb/wJXv4sJXnSWpWMKQJXm8HNqedx9cZ0AibQa+N299mM1y33XwhaT2lXypjzzHt7VvrtLz8u9JkwrNeJMPNqdgfu/KSlb+Vc8tDs4xCHhXLVDdAMMJzUFu4CKfB/5m1yZB6eP2i/NlLlUX8ix3+2ELFluiiUr4HTw9Ul3wWQw8zgSP97Rw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4326008)(47076005)(336012)(83380400001)(426003)(8936002)(40460700003)(36756003)(5660300002)(2906002)(2616005)(7696005)(82310400004)(16526019)(186003)(26005)(36860700001)(70586007)(70206006)(356005)(81166007)(1076003)(6666004)(86362001)(508600001)(316002)(8676002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 18:56:02.1527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a78481bb-2cd9-45bb-47af-08d9f634f8c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
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
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Print alloc node, peer node and memory domain when peer map fails. This
is more useful

v2: use dev_err instead of pr_err
    use bdf for identify peer gpu

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 965af2a08bc0..9141b674947d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1215,8 +1215,15 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 			peer_pdd->dev->adev, (struct kgd_mem *)mem,
 			peer_pdd->drm_priv, &table_freed);
 		if (err) {
-			pr_err("Failed to map to gpu %d/%d\n",
-			       i, args->n_devices);
+			struct pci_dev *pdev = peer_pdd->dev->adev->pdev;
+
+			dev_err(dev->adev->dev,
+			       "Failed to map peer:%04x:%02x:%02x.%d mem_domain:%d\n",
+			       pci_domain_nr(pdev->bus),
+			       pdev->bus->number,
+			       PCI_SLOT(pdev->devfn),
+			       PCI_FUNC(pdev->devfn),
+			       ((struct kgd_mem *)mem)->domain);
 			goto map_memory_to_gpu_failed;
 		}
 		args->n_success = i+1;
-- 
2.25.1


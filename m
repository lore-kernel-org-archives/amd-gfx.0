Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5782DC48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 19:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08807613B0
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 19:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08807613B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B17D36E0AF;
	Thu, 10 Jun 2021 19:00:29 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2066.outbound.protection.outlook.com [40.107.101.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11F736E0AF
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 19:00:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ABYwzMIIsIxArObwYV9tNCePcgY6OxCJKmr0cr75fxAiuIA8RIvIDmHtm8Omm8kzIpTTqzRk3F3dpo9oFoE/pksJIwFzwSmZEo6i7ien+yXt/3UfhuVkQcBsFNpUGDY7Oks41cvzLkcfSecjTJk5PrViidVvk/kvsZF8Ck/bCDlKecfxp2LNGZsPnWnCOBHcJriHNpliy2gQUSjVMyaq02E1QdAnNj66PRbmYydPQYwoYjuMZ8E2W12hhuJQHVY1pCjNo+zPQdIzAQtf9Xqi5TY50f4WG2I+011U5BDiT+NNBBrgAnij31YXWffYPbX7dDbuRiu8Um508/m3E3/YwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFJvwFlSqzHWs5YTpQrkYGyY6taUTk5rEvxo/m5SZ50=;
 b=dGOdwNqCWoYxWj/XFOskmc59sf8WoL5lXEZzmD0PgIOsvdjxj4ZTTe4MAPkyxKZ+ifxw7/JUWXrv69WPnguBYH8V2qY8+2FhzloC3UCcu/cEKpdZhijBbk/LMnfm5FBqtjwSMGn/unjRUjFSu5PCHvIFgk1l/NmxO/upz+KoTAeX3RmAVJopA/2Y7FQCwm2tOMVXeUMhVSIok12R3kCh4PX8UOdPt8iEEnArBtI4YMZZ+tCmgXAHG5MKGnuGuzMRE0sIavNWe+ugoc3WXkddiTYCdkabLTKRyR36veZVXolvYXftfrDlyOGNYVL2SgtF8oz7AkMrOYlE8Nw9UjYbBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFJvwFlSqzHWs5YTpQrkYGyY6taUTk5rEvxo/m5SZ50=;
 b=2Cf6Yy9GpTtm4Col3/diSVE8poUIJ1sWt77S79U7mwSPjIt7NrBpAiM/56ZVWFQfsLg3mb/ZM8y2kj2zRhi3RLyg6gKagyXr9gPCLYGgLaootDz7VRIOehMVOeLBJKq70W+ldgEZujhiAwvah95QOq/2imKBjsQeBogwsbJdW7k=
Received: from BN6PR1701CA0007.namprd17.prod.outlook.com
 (2603:10b6:405:15::17) by MW3PR12MB4505.namprd12.prod.outlook.com
 (2603:10b6:303:5a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Thu, 10 Jun
 2021 19:00:27 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::5a) by BN6PR1701CA0007.outlook.office365.com
 (2603:10b6:405:15::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26 via Frontend
 Transport; Thu, 10 Jun 2021 19:00:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 19:00:27 +0000
Received: from eric-HP-EliteBook-745-G4.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 10 Jun 2021 14:00:26 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Add memory sync before TLB flush on unmap
Date: Thu, 10 Jun 2021 15:00:09 -0400
Message-ID: <20210610190009.202645-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0aa65bd-76c1-4e89-5512-08d92c4202da
X-MS-TrafficTypeDiagnostic: MW3PR12MB4505:
X-Microsoft-Antispam-PRVS: <MW3PR12MB45050E79EE3FBE811F3002F982359@MW3PR12MB4505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EFRzQg8aOWJxlfSDXhOellrySHhN/UhrAD6zkf9alTocyDSwVW4zVXXLLi/c0X6UHBr1lYF2QK0ugIJnsvZlTGtK0hMNpw2z+GKBOPmjSihwEyuNP/EUGg+ZWX9d3t6O5OOWxJR1wC89PfxMZkO/fIvbhl5t8nYMOt1Gr3SMmXt8qkF/kvcu8aW34AzYhoEvidMDAhmgok/rhucKg7tzJrHtYwSElEEo/xjfEC6eowNWI7cN7WAVCfYFECjtCujDXf14F0uN+5MkomIT9zoDBxTn9TY6BA4S6dZGkucd9gJi1q+cmORrgx1cixxb3+ahLI7EeeRFrQRZJutQ68VR9RGER9ccfXOTJdYnyqaxjgtutDpesirvHdxwYN83KJgFU0vJ7zrxhj8o2fyB3veC8wjMGDPlZsGVjcXthGxv0DSSZK2Ce2Cpoq9eSJ7DTNMcXV86M58xhD0AXoVsMAv5DiLhAn4Fbie/XKVn1riPc3EKC9pnS2CfYSe3OBhkocWEqwpj1bGWRosRS9Q80YY/EYsBNmWX3z8odj5P272A41QGlHFipLsVhZCl2/ieaMzVcur8rwzwkrcKb95zpw4jRwyzgbrbe2PvSeXqYVAyxLqMlolmA5JfjmbQ+HdyKvGmZqt2m/VGBBXJhMS0GTKTlcJTwGtkpViRAraZEp7unh9Nd2DefzRyIJjK0WopuC3M
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(36840700001)(26005)(16526019)(6916009)(36860700001)(1076003)(36756003)(7696005)(6666004)(70586007)(186003)(83380400001)(8936002)(82740400003)(47076005)(336012)(70206006)(82310400003)(478600001)(426003)(8676002)(2616005)(316002)(356005)(81166007)(5660300002)(4326008)(2906002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 19:00:27.5783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0aa65bd-76c1-4e89-5512-08d92c4202da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4505
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is to fix a failure for SDMA updating PTEs.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 26 +++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 98f1d2b586c5..17d0a318b708 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1766,14 +1766,33 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 			amdgpu_read_unlock(peer->ddev);
 			goto unmap_memory_from_gpu_failed;
 		}
-		kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
 		amdgpu_read_unlock(peer->ddev);
 		args->n_success = i+1;
 	}
-	kfree(devices_arr);
-
 	mutex_unlock(&p->mutex);
 
+	err = amdgpu_amdkfd_gpuvm_sync_memory(dev->kgd, (struct kgd_mem *) mem, true);
+	if (err) {
+		pr_debug("Sync memory failed, wait interrupted by user signal\n");
+		goto sync_memory_failed;
+	}
+
+	/* Flush TLBs after waiting for the page table updates to complete */
+	for (i = 0; i < args->n_devices; i++) {
+		peer = kfd_device_by_id(devices_arr[i]);
+		if (WARN_ON_ONCE(!peer))
+			continue;
+		peer_pdd = kfd_get_process_device_data(peer, p);
+		if (WARN_ON_ONCE(!peer_pdd))
+			continue;
+		if (!amdgpu_read_lock(peer->ddev, true)) {
+			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
+			amdgpu_read_unlock(peer->ddev);
+		}
+	}
+
+	kfree(devices_arr);
+
 	return 0;
 
 bind_process_to_device_failed:
@@ -1781,6 +1800,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 unmap_memory_from_gpu_failed:
 	mutex_unlock(&p->mutex);
 copy_from_user_failed:
+sync_memory_failed:
 	kfree(devices_arr);
 	return err;
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

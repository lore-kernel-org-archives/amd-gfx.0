Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8906EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Apr 2022 08:04:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BAE410E8AE;
	Fri, 15 Apr 2022 08:04:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0836010E919
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Apr 2022 08:04:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ki+7mHqsZggIO4FEvZBTFfANdxcMjP0BEjwgWmlfp1g7cvuUI+YELoccixsvloepuQMSmB1WoDj65ZSIK2D0syCeMgEtmCM+hK3jsNZMzMBhnyK0WIedXRgm8LSkJSAWZyNFu5babcGne1lajQk5r8YUbQV718GWQEAtrqUmDrsTDGAsbXAfFIFS5xvQStahjmMwaUTIMLn7//HLeIktycr5GzfJbwhJCfevm9D5rt+uWyWqMNK3rs1a/A6OwNeKBz5wvEczWkBzGDNvGqLNXdXMu1KJdew6Bf0ZX3hIKGGeyxuH/Gc51i5Dpg0dsLueeMOx7EJf2196MqvuVBhczA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58A04iVnoQteCxGIlFXA8iVSjbnOdjuQjVJ4NZgrtK8=;
 b=g+eRoMPuQdwrrE4DbFTEWAPTwk2GgLIth11lMdLVZ2FwyAeEQDBR6Ll0gMhLFoOUq/IZ8Q40u4WhLfZWuq1JEgu8RSsMvATgGbRqSfYKwTEz8Hh0/9GkfOcrZHIk2IA5nyJbCFs6U7a/Nft02c7MjFt5Bkz06QOoEpTjVHrL3qAY3WLRqrTg3TgqEZx+VzsYQEtKRSfuUK8X5L4aFwYFBpVO/d+zPH5tiRJJ3WG65Ht7FBiSgVbPZkEhzFo8GblZY2RGMPMVGdOkeKTKafGT7OaCByYgNGT6QMmIGUVAifBytA67E0XI/JGWjzgasVDje7SbQW6dEqnS/UusZPCZnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58A04iVnoQteCxGIlFXA8iVSjbnOdjuQjVJ4NZgrtK8=;
 b=iOtgWVJrSkSU5EFK+BFIv5wB41/o+M1iPkyrkU2Xu/gKs2J9vSFZTS+/zT+2eCofQlA+obFx/7+B7HQJ97FWSTWJfHudyl8+BgOstlbgI66HZR8e3er5CQvbuhRxjTKCvu63xSCRxyUOqT1tBaOOlfK1uOCh5tZ7BwRblV0zuOg=
Received: from DS7PR03CA0324.namprd03.prod.outlook.com (2603:10b6:8:2b::24) by
 DM5PR1201MB0106.namprd12.prod.outlook.com (2603:10b6:4:4f::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.18; Fri, 15 Apr 2022 08:04:28 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::20) by DS7PR03CA0324.outlook.office365.com
 (2603:10b6:8:2b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Fri, 15 Apr 2022 08:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Fri, 15 Apr 2022 08:04:28 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 15 Apr
 2022 03:04:26 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdkfd: move kfd_flush_tlb_after_unmap into kfd_priv.h
Date: Fri, 15 Apr 2022 16:04:11 +0800
Message-ID: <20220415080412.844980-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09cf4bb2-db4b-4f0a-ed02-08da1eb690b2
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0106:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01060EA8B99D1A8B06A3A12FFBEE9@DM5PR1201MB0106.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iI0ONimcy0rbJw6LIkyKSZVvB9EbxzY+YHjoAYrBHnenm52LtZiVooAg9OvcfbTlIJHgfPtMgIksTSWw8fjZnsGkHx1dMX8sTGvTLUbbpf6l4mHKCBxo0cn93vvBeU+EauSDTcbtRfpeD8/DvHi7FxXps7QKU+GzyE2DJF8EfVilukOSC3ai40nyY6pNmHyg77zzIPwq/5BI6RAnX+faPfaw4mWX3Jsex95zReF/oDKGcss7YlJIgNk0+kIvQERD9rUuDlJbonO4BDS4ZRIWwZmg9JKHwsMo8364iDsyDe9FkhHCmFjof8SV/sC2TMtsEndLTBx82zPDTXiC2T6E0dqVhzeQ1Sq1ZIJrNB9VDGQeEVWlqmShMlzSNLYHAivDk7+6mysr0itgF7/neQAMXXVwxQiYeJbRT4ih+YkWNWQxeqfGGsTy8M/f6ztgnXl/3QF0JPESOhTzvHesT+CJNjYnP3qgG6R12j1rO2PdxM965jXQIk6KusirQJolYHQuWRwd3QTvjKwKbSxyx9iAmDp+0VJrhicq3pbJ/khSmMC1M2ijHH4240AYMSAMGz/CNpMSLXqo0GjImI33aZ8rG3JWjr/+0Ia8Of6fXa6aMyaLFuVCcYDrb4l4V2DVrajtvwcCI9FketZ166WqtMonEMpxOkOAV4reqDTB8z9mj1hb+GBXMJ6kThsIyyE3Gne+3yraWShKuuK3aI/yLouUA73wGU9KzgH0YTcOtsuIPZ1Al3xSasZIBWtdkirOmNApbtts6xN//65fFUFtMKJAKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(316002)(336012)(5660300002)(426003)(47076005)(8936002)(40460700003)(356005)(6666004)(1076003)(186003)(70206006)(8676002)(16526019)(86362001)(83380400001)(6916009)(54906003)(508600001)(36756003)(70586007)(2616005)(7696005)(4326008)(26005)(82310400005)(81166007)(36860700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 08:04:28.5779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cf4bb2-db4b-4f0a-ed02-08da1eb690b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0106
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
Cc: Eric Huang <jinhuieric.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang
 Rui <ray.huang@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To make kfd_flush_tlb_after_unmap visible in kfd_svm.c,
move it into kfd_priv.h. And change it to an inline function.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 8 --------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 91f82a9ccdaf..459f59e3d0ed 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1128,14 +1128,6 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
 	return ret;
 }
 
-static bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
-{
-	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
-		(KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
-		dev->adev->sdma.instance[0].fw_version >= 18) ||
-		KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
-}
-
 static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 					struct kfd_process *p, void *data)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 8a43def1f638..aff6f598ff2c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1328,6 +1328,14 @@ void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid);
 
 void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
 
+static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
+{
+	return KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2) ||
+	       (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 1) &&
+	       dev->adev->sdma.instance[0].fw_version >= 18) ||
+	       KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 0);
+}
+
 bool kfd_is_locked(void);
 
 /* Compute profile */
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74EEC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DF1910E9C1;
	Fri,  3 Nov 2023 13:12:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D7AA10E9BD
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:12:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1oyXeYlkIpTSBcGtCkaw0Kw5tQ9F38+iaQsjXCDIeprOeQ5a3DdnkuHj/zu21xrC85QMmB09ZtcxPhaUQUOLfS3s8WiZVcIFRJxQ4Pcl4QXPg9E8Jh0weAuIdq5N+UsomZ3/mReK4YDofd35kve+w7J2SnxPPv3VqdCVydlG4duflXG+smsK812goiiU8e10JPE00gaCFUfEX73mRB5sZvttGHpwtukT2w29oHFUEg9W6XT0+r4hHhlNwdxF5K/kHB4/Vium5qUq/s7VYh/ZN3l642s/2tBcnOoWbO1bBgM4Uf/uJfKIXIQ3N46wg89BW4MHQIVIz9v4Y0b6rC4tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbjQq5ood9zaHsmUupNkP4SQpQ2qqWsZ7bEHGQoXeJE=;
 b=PbH4zEopyshFNiSprsf/i+f8CGkFTAKKihq/OWqGkkpqirzGp5ycl/PtIqEmgNVzfdpWSNI+tOk7S04LF+OLhntuzdKmJ2MypV3dnn7eXMc8IDlhiOnrAmJ2Lm3po10XI2Ggc+V2LNTY5gMqFEt99vpfUrl8n1Bk2y33S9FJymMFsKAwnw0k75JSx1Cv/4+bJTZRh1Yvw2TflZpwlBqcEUAagi/r6AvV6e0t6ntxMW8RaC5QY65JUjTz+PMrdmohn0pSbGQ+FtiH+CSQM5FPghTdwZJWWGw7rDQh2/dg9Wv41WgZnnUAMJ3iErWyBiEUNlJCqon2Tda+dDpqmGo+fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbjQq5ood9zaHsmUupNkP4SQpQ2qqWsZ7bEHGQoXeJE=;
 b=132sBuDf7y8N6qtwxjrDiPCL9JOuku5XDWTOpqdrALMPaYUgNgxPI1hdG0nk0plQD7CZ1rjVGclToiEziB51yRX0L51jS1IwivrCg3HDnjJr0j/5NzfpHw+4xiVgTe1+WureqVISPC4CEkOy9+6sY5om6z+cIN+I4rOgOqu1iz8=
Received: from DS7PR03CA0093.namprd03.prod.outlook.com (2603:10b6:5:3b7::8) by
 MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 13:12:02 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::64) by DS7PR03CA0093.outlook.office365.com
 (2603:10b6:5:3b7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 13:12:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 13:12:02 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 08:12:00 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/24] drm/amdkfd: add trace_id return
Date: Fri, 3 Nov 2023 09:11:21 -0400
Message-ID: <20231103131139.766920-7-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-1-James.Zhu@amd.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e78c0c1-db99-47e0-1600-08dbdc6e7825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aU+0NUncl3d/t+KDrVsDF0QI6IbvZ73tBjW0FXZQQjrPO7vU+Te37XY3thtx/vfB2/pQH2VK/SponlRsSvL/q+BsH/XbQtN8WhjkhVoQI2YHp9bAgPj9iqdwtuDTvCG0WvmSVTE10lGgkVWl04DfKw1zDMxpHtUd8CflAh/TylLSF1B9NpndtzUNOjzbE/MC2qBX1eBAXvPZA977ZpPiTsqNZITk6IsrxScvFDGdSyQHX7jmqxeHIJtBZOm7EeyEv/S9+fRQS7QiWkL/ayoik64vq+QU3tXZak5x6u7RvCDm2FSRq2ZN3tNBE3TRgUGvMIXUDv2IWd00ysN5+a3xIgOojfHUzchWXrqLBx/wX3dUaFQQx/Mh6q/RGx2TAWY75X6J6cuaH92p8nTfyp3MSNuTVSDG3pD8BdkSeL/UAgrY6Ltv2HGvha1R2PgkRzyj9nN7FVcEwJ4tUJqn2RhYLnPcMp4G6t4Sbr78TXX3KZVt9M8wDelYW2/sBfq5kHNu92f7AO7k/35/Br98OeNHMyTfoLmcWBRrYMCQybKN1HzAx4Yu0Bqbp2YEyK+02B70RPu1yEsM/611mQoklY3svXWXYj5VI4C+8VFMisp4rOSGPUTD8FRQa8o+ZUxFnQsizxhVSaxECTxwY+EFxkl9iXpnKVevazPTc7y+BFQ1GLft54qSyS7j1PI7Pp8XdkmsrjpqgZ57jOPOsw3W1IyxpzCzxE326zCf4QII3z8hI1IYl517EdA7eOFl2TsjZf7qAeoIZSrNkv9fe26ctlyUmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(1800799009)(82310400011)(451199024)(186009)(64100799003)(36840700001)(40470700004)(46966006)(40480700001)(2906002)(81166007)(2616005)(70586007)(70206006)(1076003)(6666004)(16526019)(7696005)(26005)(36756003)(478600001)(82740400003)(47076005)(40460700003)(54906003)(316002)(6916009)(426003)(336012)(41300700001)(5660300002)(356005)(83380400001)(86362001)(36860700001)(4326008)(8936002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:12:02.2485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e78c0c1-db99-47e0-1600-08dbdc6e7825
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add trace_id return for new pc sampling creation per device,
Use IDR to quickly locate pc_sampling_entry for reference.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c      |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 20 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  6 ++++++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 0e24e011f66b..bcaeedac8fe0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -536,10 +536,12 @@ static void kfd_smi_init(struct kfd_node *dev)
 static void kfd_pc_sampling_init(struct kfd_node *dev)
 {
 	mutex_init(&dev->pcs_data.mutex);
+	idr_init_base(&dev->pcs_data.hosttrap_entry.base.pc_sampling_idr, 1);
 }
 
 static void kfd_pc_sampling_exit(struct kfd_node *dev)
 {
+	idr_destroy(&dev->pcs_data.hosttrap_entry.base.pc_sampling_idr);
 	mutex_destroy(&dev->pcs_data.mutex);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index f0d910ee730c..4c9fc48e1a6a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -99,6 +99,7 @@ static int kfd_pc_sample_create(struct kfd_process_device *pdd,
 {
 	struct kfd_pc_sample_info *supported_format = NULL;
 	struct kfd_pc_sample_info user_info;
+	struct pc_sampling_entry *pcs_entry;
 	int ret;
 	int i;
 
@@ -140,7 +141,19 @@ static int kfd_pc_sample_create(struct kfd_process_device *pdd,
 		return ret ? ret : -EEXIST;
 	}
 
-	/* TODO: add trace_id return */
+	pcs_entry = kvzalloc(sizeof(*pcs_entry), GFP_KERNEL);
+	if (!pcs_entry) {
+		mutex_unlock(&pdd->dev->pcs_data.mutex);
+		return -ENOMEM;
+	}
+
+	i = idr_alloc_cyclic(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_idr,
+				pcs_entry, 1, 0, GFP_KERNEL);
+	if (i < 0) {
+		mutex_unlock(&pdd->dev->pcs_data.mutex);
+		kvfree(pcs_entry);
+		return i;
+	}
 
 	if (!pdd->dev->pcs_data.hosttrap_entry.base.use_count)
 		memcpy(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info,
@@ -149,6 +162,11 @@ static int kfd_pc_sample_create(struct kfd_process_device *pdd,
 	pdd->dev->pcs_data.hosttrap_entry.base.use_count++;
 	mutex_unlock(&pdd->dev->pcs_data.mutex);
 
+	pcs_entry->pdd = pdd;
+	user_args->trace_id = (uint32_t)i;
+
+	pr_debug("alloc pcs_entry = %p, trace_id = 0x%x on gpu 0x%x", pcs_entry, i, pdd->dev->id);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 81c925fb2952..642558026d16 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -258,6 +258,7 @@ struct kfd_dev;
 
 struct kfd_dev_pc_sampling_data {
 	uint32_t use_count;         /* Num of PC sampling sessions */
+	struct idr pc_sampling_idr;
 	struct kfd_pc_sample_info pc_sample_info;
 };
 
@@ -743,6 +744,11 @@ enum kfd_pdd_bound {
  */
 #define SDMA_ACTIVITY_DIVISOR  100
 
+struct pc_sampling_entry {
+	bool enabled;
+	struct kfd_process_device *pdd;
+};
+
 /* Data that is per-process-per device. */
 struct kfd_process_device {
 	/* The device that owns this data. */
-- 
2.25.1


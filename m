Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00113C35274
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:01:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C95910E235;
	Fri, 15 Dec 2023 16:01:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4B7110EA47
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:01:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYF+V6xdxYtSLCQJ2ChykAKKwqaorAwSSNB/fTWZj2vLu/c4ntarqZWh0E511NZGbm+GEn5xlY5ats3ROkQnv0chcuZV1omL0gy6Jt9ARqMv9OwnD5hj8bD+Tfg8bMoUOJ6Oe/adiPHT1LwANbMVDH7WV2Ofx/ZjLw0bZ6rkKfSPDKHjpk0bMj/wuc5jKHMml7pnDCJLZb9IrEVDj41uq74db/6Oyw4bGgT9+YLDYEtfreLMA/EGAdqqJJm8OcmUpDP5mTlMWjbozajtLkMWLYCXURocDHXdatga9mhjZ6Am8eCLX8t9eoEmhTuftAoyobFhjbDLZ0dXx2li5rjxGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOzk6/eEvGGTIOSAiklD6AdMcA40oa1wIpnxDpC1LKc=;
 b=Dny5dxR+VSIrG5bKdjFWPJdD3iKjBAjZGjLjh8SLZu0gJh3aSstMz9ckotg28zb2XXJUrm75cUb/My0+HGMUqiK4nQaj5y09aLG/E2wM2VLycd3it9tZ3PxBCFRHPWY2GrPZ0fthT59r33OyzzCjJblcI3a0xzuQOAONeaMPoEVw6tiFVIw2RklqsTMlt3dQdyZLhdZ+OVYBo+pQ/I7iO1GBfoY0y3VkbLzWB6QC7txLOAQyC1m3DqzNZo3e2FwHSeuRrImEpPnZ5t00SOhvQ9bekB+uYO/neh48cTB8PIz0O/lqpevkt7585TlFRgLaBZRVOvJ1Q6H85TkaaHsbhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOzk6/eEvGGTIOSAiklD6AdMcA40oa1wIpnxDpC1LKc=;
 b=SXCl4DCLXUUty6PxsQkZxKeIb7H4nS0WoTCxEotDeYSKCusn04z89yPgOuZflHaTa0kbe2sAZ2+atBcjQ06mBauOHPUCdumYHNBC937YgVm0uGGZ/O8dVnsaqv8uI07KqtZv5FPqK55P1FILNLrZgHgH2tPF7/3W654baa/yQmw=
Received: from SA0PR13CA0005.namprd13.prod.outlook.com (2603:10b6:806:130::10)
 by DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 16:01:05 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::2c) by SA0PR13CA0005.outlook.office365.com
 (2603:10b6:806:130::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.13 via Frontend
 Transport; Fri, 15 Dec 2023 16:01:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 16:01:05 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 10:00:47 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 22/24] drm/amdkfd: add pc sampling release when process
 release
Date: Fri, 15 Dec 2023 10:59:49 -0500
Message-ID: <20231215155951.811884-23-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215155951.811884-1-James.Zhu@amd.com>
References: <20231215155951.811884-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|DM4PR12MB6254:EE_
X-MS-Office365-Filtering-Correlation-Id: a5528a8a-2c0b-43c1-ca08-08dbfd870b2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NWeY+FfyAQU68dhK/JcPZaXKG4XaLtFXIwkasIBowop2pA7iTCkcyPHF9LpGuCwIjyFwYnq3nX4YCZ77YH76Hjzl305OmdNAPq+142eXF5k1VL1izc+9Vh+uikWlnlSu7rYHoIeV8zx71EJUdwEtHpkFJBJt6XuwOyQkSKNgc/FIIPtNUaYpsXBo6Xkt5ZoQ9L2T/j/A5giimUXexZb1x2xANEjvE2IkLYP0cBUVUBTG0x700GQZ8m+eE0bPxnrQEjK5CzR8FuTvtLG1IejawLycfLH050sKd0w+WctRVhxC0nZ7hE//LhAJCNljmekpcUfeEygfwbrHT7yA5TGPZfwesedBzMkB7IXlou3pB0veDO6EF4U+6tz1sufAufy0u3msODArlYsR53oK2jw97IUEkZIXa7EnbrqH8hlvCee7NYOJHouFxHbRKdhk8xgvc3Ocx94VK4VXxQkqvNvhfL0XDCZ5JLxHqtk/HWBMhdyPsLP3JP3ft73rT8aB3ODrwIs5uMtDrPfyLnd9YoNbViQFZXy8fgElFvT6gkfh4Rq/TISAWlD64TBBgEMOvOzAalMDFalNhIBuIk2RifssCBfOpZQMGAWYyJaUBtpi+cX3rl1/jaXXwdFalUuAcSL5KOo8lt1MpKd2l0CsKI6uBJCEgh9k5zRERj6xP3HxSHJOvPGAlzCMMs/AxR8A28eS6aLUAS478dapTTRkq5eCGCL1cx5P8keB5SH92XPzREHxefhLT7w9OoqNChXhVYRr5FCaU2czc23O3kv/+F8b5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(64100799003)(1800799012)(82310400011)(451199024)(186009)(40470700004)(46966006)(36840700001)(5660300002)(2616005)(1076003)(26005)(47076005)(16526019)(336012)(426003)(36860700001)(83380400001)(2906002)(478600001)(316002)(6916009)(54906003)(36756003)(41300700001)(70206006)(70586007)(7696005)(4326008)(8676002)(8936002)(40460700003)(40480700001)(82740400003)(86362001)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:01:05.2525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5528a8a-2c0b-43c1-ca08-08dbfd870b2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6254
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

Add pc sampling release when process release, it will force to
stop all activate sessions with this process.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 21 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c     |  3 +++
 3 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index c95d9ff08f6a..d8286aabd5a7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -300,6 +300,27 @@ static int kfd_pc_sample_destroy(struct kfd_process_device *pdd, uint32_t trace_
 	return 0;
 }
 
+void kfd_pc_sample_release(struct kfd_process_device *pdd)
+{
+	struct pc_sampling_entry *pcs_entry;
+	struct idr *idp;
+	uint32_t id;
+
+	/* force to release all PC sampling task for this process */
+	idp = &pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_idr;
+	mutex_lock(&pdd->dev->pcs_data.mutex);
+	idr_for_each_entry(idp, pcs_entry, id) {
+		if (pcs_entry->pdd != pdd)
+			continue;
+		mutex_unlock(&pdd->dev->pcs_data.mutex);
+		if (pcs_entry->enabled)
+			kfd_pc_sample_stop(pdd, pcs_entry);
+		kfd_pc_sample_destroy(pdd, id, pcs_entry);
+		mutex_lock(&pdd->dev->pcs_data.mutex);
+	}
+	mutex_unlock(&pdd->dev->pcs_data.mutex);
+}
+
 int kfd_pc_sample(struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *args)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
index 4eeded4ea5b6..6175563ca9be 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
@@ -30,5 +30,6 @@
 
 int kfd_pc_sample(struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *args);
+void kfd_pc_sample_release(struct kfd_process_device *pdd);
 
 #endif /* KFD_PC_SAMPLING_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 6bc9dcfad484..1f8d6098dfb2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -43,6 +43,7 @@ struct mm_struct;
 #include "kfd_svm.h"
 #include "kfd_smi_events.h"
 #include "kfd_debug.h"
+#include "kfd_pc_sampling.h"
 
 /*
  * List of struct kfd_process (field kfd_process).
@@ -1021,6 +1022,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		pr_debug("Releasing pdd (topology id %d) for process (pasid 0x%x)\n",
 				pdd->dev->id, p->pasid);
 
+		kfd_pc_sample_release(pdd);
+
 		kfd_process_device_destroy_cwsr_dgpu(pdd);
 		kfd_process_device_destroy_ib_mem(pdd);
 
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE719CCFA18
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Nov 2025 07:02:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 666E710E11B;
	Tue, 11 Nov 2025 07:02:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QKV6BiV/";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012051.outbound.protection.outlook.com [52.101.48.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8829710E11B
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Nov 2025 07:02:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/lQRTi2qxsiclj0MrvdVCtgZjlqzRQwjpb2ZbJ06n23qjwewIitrdIswPP7nvp4WDZYrHNYEMBLGEd7+5grVXHnk5URs8m1sY9MxmRPgNW1cfpjsCsWFUUrpHD578QE8Ip+1x+jWBV1PcJ6Oo+IkgMBVbD+ugYHKAC7BNKcyvmzPEb3rXHUBjKxnNRJ+egPTiD7Q/+yU1TqZ1Xd37mPfZz2j7JAbHUostaETqGQ0NlEhxWjg4Tvu+FB5Xmlb0Cuz/wWmsd5QPTb0z0U52bAssSLd3QgWIrYP8C7iyflgbR0cKsgVkMDEyhpA/1ZkvmaVXaLw18ErOyG7qrmZVsilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xliQn4MfCITpLpQr9lWZS64CXn5mYyYv82Ft09zfMqA=;
 b=CQmnfTNBXy0LYHD39mMJEULdB083uDbWr+TYGys7SPaDh46mRYTHlf2RYQpFWBGvistv7LXjGN1VUcRcJ4pBcP5D8nh0H9+j418BVKFZJUNcYJ2x93UUyFp+REFOAXCQ2Ns0jH73xJA8uOOR0d/XwNNsQjXMACNMzZDYW4KO/0K1Gi3s1w0YV3srblqhaYkohPakPOFl8rtkhR+JoJT03YDtTErdfPbufbIYORVY3v984jwr7+ARDtS22sNSpthsn2Yie2dJxDMZ3FOgWmg1jxhEZ1hVnDdThB80d4BSqOmkqtpwbhyTQMJtTjsPv0TdtX5tthj5w0Bw/vrrufU36w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xliQn4MfCITpLpQr9lWZS64CXn5mYyYv82Ft09zfMqA=;
 b=QKV6BiV/xrrdO1IDhDes85Y0iHMAqTKhdTPr8FJI521YTXogFl5+R6goa3t9Lh9aOuRSUoL0Ir6XVaWM2WAcOREEd7GnYjjSVoTQvJ83x0Eq2SvxZ4lloCt6oXgCVtAcfoEOJyVgfJaOp//1W/ZI+2v7BTH6wuEEvWs2I++TFF0=
Received: from CH0PR03CA0203.namprd03.prod.outlook.com (2603:10b6:610:e4::28)
 by SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 07:02:23 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::17) by CH0PR03CA0203.outlook.office365.com
 (2603:10b6:610:e4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 07:01:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 07:02:22 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 23:02:20 -0800
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Emily.Deng@amd.com>, <Victor.Zhao@amd.com>, <philip.yang@amd.com>,
 <felix.kuehling@amd.com>, chong li <chongli2@amd.com>
Subject: [PATCH] drm/amdgpu: reduce the full gpu access time in
 amdgpu_device_init.
Date: Tue, 11 Nov 2025 15:02:01 +0800
Message-ID: <20251111070201.1968780-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|SA0PR12MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: 72052ffe-35b6-4eca-6a9e-08de20f04321
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VlLfCqIHs/mE1L/f8XOLkWA6kFicwmcfeGWTiCSC/sPr30uucJJ8maZ7NILJ?=
 =?us-ascii?Q?t1HONFyHnoOm5iwhahhNB1RzSIv2JnD0E6YTU1bpS/3XLIcOpOG3+6TktgMY?=
 =?us-ascii?Q?6VSREHGvT/3GrDJRvOC0hPS5wrw7i55K+M8l8F7fB3Yz+CwMA3SIDHqesoVj?=
 =?us-ascii?Q?Dc2oqaeylY3G0Awj5i8jPvDkMrUzOnr2X5GzV9C87lfcIhvwIFUhhzQ1GLjt?=
 =?us-ascii?Q?F1HrnC006Xfq26iZC9XP6BWxZsvrFMH/V8Xh4kwmMoOaSjsjRLBhmDcRdS54?=
 =?us-ascii?Q?2x8Ls465LE69xxBRENoa684XeCtFnwyM5a3EnHMhnzTFEEEUWzG2v0wr9+Zs?=
 =?us-ascii?Q?PFgzlNIntJif/yrUWHO1XJbXOMt/KXemicYy5in/IIaX75R1ibZE7rTsLv4v?=
 =?us-ascii?Q?KaYWVpzPmEUyudMODQlDJA5FDWUnnEVyRbUs8LeYkfexEjJ94X2cHUd3LjTf?=
 =?us-ascii?Q?icThaYxf43FseupBLuTSMXOEW9ZczgSIA6bLfN9NOV+E7zv3wzPIky/fuFst?=
 =?us-ascii?Q?D/R1YLJvlhMOzWWzlwxgs/3QQdDNtUceHBBvICBzn1GaquEb3dk7E0PvwdNB?=
 =?us-ascii?Q?Oukkr2DPafF/pW7kIPfPPsyuEe5Pf8Fk8B9j0/OzHfef+IUJQfgQLm7e7E/s?=
 =?us-ascii?Q?qGLgfeGhj7HznFwPAPGD6JdLRCkdBHJ9LEFBZLxhk8o9H8zIVcujkJaTs8wz?=
 =?us-ascii?Q?sy6+wGnP/jrdQbpQ0MW0VPZ213D6mwBrUJ6PSh1P50xpp3Wp69XD656jSMxT?=
 =?us-ascii?Q?oU20YC4BeChKSJCJVXj9TMKwPAutGmIA2FsnPwXIa+dwhu/XE+UAQaKGxgnb?=
 =?us-ascii?Q?CM1ISYfAFxPBYfxd19OFSmAxv390LZinxL/62Zanxt13zPPyfmGoqMocSl26?=
 =?us-ascii?Q?RCOa9nHVqYu/0buA3C78bf4LfF0q+WAXfSnY90DgeE33Yi9PnIYw8WU6n46K?=
 =?us-ascii?Q?0EzFTzryGJjEE0l5ObvE0nwlxCdDbNsi1yhuZMhRAcQcnnRmCfopXNZvjfZY?=
 =?us-ascii?Q?ma0+2q+YNy2XYmxdbJjLe3nKLl83/iDLcix3c6zuq2eYl4LrdVubavIkaUiF?=
 =?us-ascii?Q?pT/twLQwbceJpJ3RoH603VLzJyim/fYfdi6OIbTMj6z8Se8xMx7mIhy+5/t7?=
 =?us-ascii?Q?j3yJL+4FQsay5djhfBQHod3C1U6LLjTcQ7wk92BJILi78Cc9jjh8VmOOfGjI?=
 =?us-ascii?Q?9HNm7afL2x+hPHcWidVzaWZuRFYLSIPrGFQlcOjrNhLpd2xlFS1vzNoDpiTI?=
 =?us-ascii?Q?KcapscdEJXDSs/Uelc5h7b9XbC72gy4gvLf92KC0s6GbLi+ogaMFCjfboMN8?=
 =?us-ascii?Q?WA3ajYvs/eLaoUjBdp8OxH0pcDDeibRX9IrLSF28wph702C5DEHwYpDXsxE1?=
 =?us-ascii?Q?7HzhYBbV3RF5h80y6QWBPM3zjlGbi5lgT601CO2+RZYKTNs46pJDwxK+bU/z?=
 =?us-ascii?Q?UgCCmmUBYTNTwL1zsOCEhwtLDpJUSnhoIP46aXDi8T9P6+eFAmWiUq1miBSd?=
 =?us-ascii?Q?tsGcaT24j08t8r9W0tg8PozxG02duoTIe6towWrU/QrQGs/KPiy0+oUnqTpB?=
 =?us-ascii?Q?paEzAzEZeoE5L1MpAXo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 07:02:22.3163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72052ffe-35b6-4eca-6a9e-08de20f04321
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398
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

[Why]
function "devm_memremap_pages" in function "kgd2kfd_init_zone_device",
sometimes cost too much time.

[How]
move the function "kgd2kfd_init_zone_device"
after release full gpu access(amdgpu_virt_release_full_gpu).

Signed-off-by: chong li <chongli2@amd.com>
Change-Id: I3eebd7272b8f0c85d08fec80acee67a2c9e59e52
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 24 ++++++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 860ac1f9e35d..c293e9a24d48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -84,6 +84,8 @@
 
 #include <drm/drm_drv.h>
 
+#include <kfd_priv.h>
+
 #if IS_ENABLED(CONFIG_X86)
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
@@ -3314,7 +3316,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 	/* Don't init kfd if whole hive need to be reset during init */
 	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
-		kgd2kfd_init_zone_device(adev);
 		amdgpu_amdkfd_device_init(adev);
 	}
 
@@ -4918,6 +4919,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL_XGMI)
 		amdgpu_xgmi_reset_on_init(adev);
+
+	/* Don't init kfd if whole hive need to be reset during init */
+	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
+		kgd2kfd_init_zone_device(adev);
+		kfd_update_svm_support_properties(adev);
+	}
+
 	/*
 	 * Place those sysfs registering after `late_init`. As some of those
 	 * operations performed in `late_init` might affect the sysfs
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 70ef051511bb..bd1c6d1742c8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1358,6 +1358,7 @@ struct process_queue_node {
 
 void kfd_process_dequeue_from_device(struct kfd_process_device *pdd);
 void kfd_process_dequeue_from_all_devices(struct kfd_process *p);
+void kfd_update_svm_support_properties(struct amdgpu_device *adev);
 int pqm_init(struct process_queue_manager *pqm, struct kfd_process *p);
 void pqm_uninit(struct process_queue_manager *pqm);
 int pqm_create_queue(struct process_queue_manager *pqm,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 5c98746eb72d..f25d867ec40a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2401,4 +2401,28 @@ int kfd_debugfs_rls_by_device(struct seq_file *m, void *data)
 	return r;
 }
 
+void kfd_update_svm_support_properties(struct amdgpu_device *adev)
+{
+	struct kfd_topology_device *dev;
+	int ret;
+	down_write(&topology_lock);
+
+	list_for_each_entry(dev, &topology_device_list, list) {
+		if (dev->gpu && dev->gpu->adev == adev) {
+			if (KFD_IS_SVM_API_SUPPORTED(adev)) {
+				dev->node_props.capability |= HSA_CAP_SVMAPI_SUPPORTED;
+				ret = kfd_topology_update_sysfs();
+				if (!ret)
+					sys_props.generation_count++;
+				else
+					dev_err(adev->dev, "Failed to update SVM support properties. ret=%d\n", ret);			}
+			else
+				dev->node_props.capability &= ~HSA_CAP_SVMAPI_SUPPORTED;
+		}
+	}
+
+	up_write(&topology_lock);
+	return ;
+}
+
 #endif
-- 
2.48.1


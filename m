Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A237C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3890E610CF
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3890E610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82C586E987;
	Thu, 19 Aug 2021 13:38:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB9E16E94F
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 13:38:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiYy2b1GJTcH1BrPW+qKcPsHGMTCVsk0ZRME8lwC8B63fRF6nicehqj2wvg8FfA06vzEPVFnvtJVMDa1VIPqcQPEVnxjwKi27kwDgyJSQv8ZGR9MyDp/9eVvHzUhfZCLdJL3U0umSyvNUYm9pkzEAqYoJ6cv+vdOJiJD7Ku6X8JwQ2kU0gqzi/eY4/qsfbwacoB3qgK+GFdcAte2mJFCL8j9pRREFh1744VYfecURuraQTtKXTurIbBbCSzsbrR8ogcpduUy0rX4fnqeDNTYoQu+oGDInqyBhLy/noAVY7z8qb4tGcsApmewydw6TKOw8vIY2rW4DfHed8qdJGhtWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNTlEvLvW6lRuukf8wC8vfQHa404hA95kTjmlcwSG3w=;
 b=PdlJy94nL87VgyZuLmuC6j4c/1KFoCk9i/zvei42+pwUEtEQeQfAqCuPtRS0pDhX5B2pkJC7HihndwP1KXa1jstPva1/23egrTsveo+2VhM4hDTwzqGmPfhEALsSViLGshHwb1mmycMCuYd/52vQq6/UIlXe1KGzrQFQyVWzwSb/m9vQXGU4xeK8vQO5gLoQEYShx5lowkzWbQCayUsnNoddGBkG7AhhInCUxiCu4P7JpNF1eE2qE5DWMy1cYT+f6q8eMh2ubJY5jJ7VnxpUHZe8zYuD9ZG9UBwG8dkjRwY1t2mcqfTxkLoRiEQO1I5142aVud6xzXWCrI4HIHg7JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNTlEvLvW6lRuukf8wC8vfQHa404hA95kTjmlcwSG3w=;
 b=j0IZy6SZpV7TDe0FXNaE5UqJ+ftLGwuqnusIg6KY21j8DBuJMmDAE0k1SJFkCxizSq+dYPovUq+lI9MJMSTUQbfxVuY1ORa1agRFksD0/fwPrYTOzV6oxFDfXNc6Dd5CeDtHJEYJC2ZQQN6rfxLKcQcTOzh2reAH8IyZ3Q7IxOE=
Received: from MW4PR04CA0174.namprd04.prod.outlook.com (2603:10b6:303:85::29)
 by CH0PR12MB5153.namprd12.prod.outlook.com (2603:10b6:610:b8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 13:38:00 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::2e) by MW4PR04CA0174.outlook.office365.com
 (2603:10b6:303:85::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend
 Transport; Thu, 19 Aug 2021 13:37:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 13:37:59 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 19 Aug
 2021 08:37:55 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH 16/18] drm/amdkfd: CRIU implement gpu_id remapping
Date: Thu, 19 Aug 2021 09:37:11 -0400
Message-ID: <20210819133713.4168-17-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210819133713.4168-1-david.yatsin@amd.com>
References: <20210819133713.4168-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3825e50b-43a5-43a1-eace-08d963168f8f
X-MS-TrafficTypeDiagnostic: CH0PR12MB5153:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5153895568D3C2F1F271455D95C09@CH0PR12MB5153.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yf+mjTPU9zYOCnSv2iBnAgC9Pto+2GimqyxSVdq3/CSu8wQD1s7NPsS2Iwgj9NWmjkrOiQOW8oiZFAnvdbE45d5gi8jh/ygaZR9mxI4NR9VgRp2CL/TOnMXM2WtDsORSjNgmylw9LZukgfY1BXuXcB9fzD0AGi3Hb8AEHgnRbYDpvVNLUvC8WyQ5l6vyh+l2ZvBIQW52NcP0fWsD0gLvraer/2b3nQVRmf43CLe5p7pULpxk5H8OUNteRYaFlg530wzdJA8BdFImfns4hz02XBxMrkLVCkAztsGAPWzhDlzJGR+LIQh/6rcizmynxkI6ET86yqRmWBSIuln4Z9LJXTZ33DdEWb+Zj7c4glHU8ZoDdENXeYiJkeGIS6cXayd5y0ysERH3/z9iY7OsMWF5vDjBsIDo5OwgBxWGz2MnJ5Buj0ICkdtpwaTxqlRPDXXOrTbkRDTmakDw5eVNmnZV5N5p8qpkeb94I7BqbCRRHeV4Lh6/ExRo1/ch3wWJtIYpMC0BUtjqF2G9FuXHLHWkSkNjwqV9KWw5KHVdeisD32qvxCEUIvb+mhEYGdmJG/mbZ5yyblMhuBO8P2MWGN23fdI91HsGUFBGAmr7A3MSroPjnBFaw/gbUdP+ynBBuh51780y64jLTPsvBWLFoZqSop31v8x8cECiH+vudqujrzbmdqnKPBbZOpwSSijR9ceIWh+g/CRJ0ojk112JnyXB8Mk/N9L2qQA4AgdVS6xAICGSB5JDfl9VvEqmMl6TtkIQ6KxpYANnk8bWlgHGKJBpaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(36840700001)(46966006)(70206006)(70586007)(54906003)(4326008)(86362001)(2616005)(47076005)(16526019)(26005)(36756003)(478600001)(186003)(336012)(82310400003)(34020700004)(426003)(1076003)(83380400001)(7696005)(6916009)(8936002)(82740400003)(2906002)(356005)(30864003)(36860700001)(81166007)(5660300002)(6666004)(8676002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 13:37:59.7050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3825e50b-43a5-43a1-eace-08d963168f8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5153
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

When doing a restore on a different node, the gpu_id's on the restore
node may be different. But the user space application will still refer
use the original gpu_id's in the ioctl calls. Adding code to create a
gpu id mapping so that kfd can determine actual gpu_id during the user
ioctl's.

Signed-off-by: David Yat Sin <david.yatsin@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 400 +++++++++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_events.c  |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  10 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |  18 +
 4 files changed, 324 insertions(+), 109 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index c8f523d8ab81..90e4d4ce4398 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -294,13 +294,14 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 		return err;
 
 	pr_debug("Looking for gpu id 0x%x\n", args->gpu_id);
-	dev = kfd_device_by_id(args->gpu_id);
-	if (!dev) {
+
+	mutex_lock(&p->mutex);
+	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
+	if (!pdd) {
 		pr_debug("Could not find gpu id 0x%x\n", args->gpu_id);
 		return -EINVAL;
 	}
-
-	mutex_lock(&p->mutex);
+	dev = pdd->dev;
 
 	pdd = kfd_bind_process_to_device(dev, p);
 	if (IS_ERR(pdd)) {
@@ -491,7 +492,6 @@ static int kfd_ioctl_set_memory_policy(struct file *filep,
 					struct kfd_process *p, void *data)
 {
 	struct kfd_ioctl_set_memory_policy_args *args = data;
-	struct kfd_dev *dev;
 	int err = 0;
 	struct kfd_process_device *pdd;
 	enum cache_policy default_policy, alternate_policy;
@@ -506,13 +506,15 @@ static int kfd_ioctl_set_memory_policy(struct file *filep,
 		return -EINVAL;
 	}
 
-	dev = kfd_device_by_id(args->gpu_id);
-	if (!dev)
-		return -EINVAL;
-
 	mutex_lock(&p->mutex);
+	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
+	if (!pdd) {
+		pr_debug("Could not find gpu id 0x%x\n", args->gpu_id);
+		err = -EINVAL;
+		goto out;
+	}
 
-	pdd = kfd_bind_process_to_device(dev, p);
+	pdd = kfd_bind_process_to_device(pdd->dev, p);
 	if (IS_ERR(pdd)) {
 		err = -ESRCH;
 		goto out;
@@ -525,7 +527,7 @@ static int kfd_ioctl_set_memory_policy(struct file *filep,
 		(args->alternate_policy == KFD_IOC_CACHE_POLICY_COHERENT)
 		   ? cache_policy_coherent : cache_policy_noncoherent;
 
-	if (!dev->dqm->ops.set_cache_memory_policy(dev->dqm,
+	if (!pdd->dev->dqm->ops.set_cache_memory_policy(pdd->dev->dqm,
 				&pdd->qpd,
 				default_policy,
 				alternate_policy,
@@ -543,17 +545,18 @@ static int kfd_ioctl_set_trap_handler(struct file *filep,
 					struct kfd_process *p, void *data)
 {
 	struct kfd_ioctl_set_trap_handler_args *args = data;
-	struct kfd_dev *dev;
 	int err = 0;
 	struct kfd_process_device *pdd;
 
-	dev = kfd_device_by_id(args->gpu_id);
-	if (!dev)
-		return -EINVAL;
-
 	mutex_lock(&p->mutex);
 
-	pdd = kfd_bind_process_to_device(dev, p);
+	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
+	if (!pdd) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	pdd = kfd_bind_process_to_device(pdd->dev, p);
 	if (IS_ERR(pdd)) {
 		err = -ESRCH;
 		goto out;
@@ -577,16 +580,20 @@ static int kfd_ioctl_dbg_register(struct file *filep,
 	bool create_ok;
 	long status = 0;
 
-	dev = kfd_device_by_id(args->gpu_id);
-	if (!dev)
-		return -EINVAL;
+	mutex_lock(&p->mutex);
+	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
+	if (!pdd) {
+		status = -EINVAL;
+		goto out_unlock_p;
+	}
+	dev = pdd->dev;
 
 	if (dev->device_info->asic_family == CHIP_CARRIZO) {
 		pr_debug("kfd_ioctl_dbg_register not supported on CZ\n");
-		return -EINVAL;
+		status = -EINVAL;
+		goto out_unlock_p;
 	}
 
-	mutex_lock(&p->mutex);
 	mutex_lock(kfd_get_dbgmgr_mutex());
 
 	/*
@@ -596,7 +603,7 @@ static int kfd_ioctl_dbg_register(struct file *filep,
 	pdd = kfd_bind_process_to_device(dev, p);
 	if (IS_ERR(pdd)) {
 		status = PTR_ERR(pdd);
-		goto out;
+		goto out_unlock_dbg;
 	}
 
 	if (!dev->dbgmgr) {
@@ -614,8 +621,9 @@ static int kfd_ioctl_dbg_register(struct file *filep,
 		status = -EINVAL;
 	}
 
-out:
+out_unlock_dbg:
 	mutex_unlock(kfd_get_dbgmgr_mutex());
+out_unlock_p:
 	mutex_unlock(&p->mutex);
 
 	return status;
@@ -625,12 +633,18 @@ static int kfd_ioctl_dbg_unregister(struct file *filep,
 				struct kfd_process *p, void *data)
 {
 	struct kfd_ioctl_dbg_unregister_args *args = data;
+	struct kfd_process_device *pdd;
 	struct kfd_dev *dev;
 	long status;
 
-	dev = kfd_device_by_id(args->gpu_id);
-	if (!dev || !dev->dbgmgr)
+	mutex_lock(&p->mutex);
+	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
+	if (!pdd || !pdd->dev->dbgmgr) {
+		mutex_unlock(&p->mutex);
 		return -EINVAL;
+	}
+	dev = pdd->dev;
+	mutex_unlock(&p->mutex);
 
 	if (dev->device_info->asic_family == CHIP_CARRIZO) {
 		pr_debug("kfd_ioctl_dbg_unregister not supported on CZ\n");
@@ -664,6 +678,7 @@ static int kfd_ioctl_dbg_address_watch(struct file *filep,
 {
 	struct kfd_ioctl_dbg_address_watch_args *args = data;
 	struct kfd_dev *dev;
+	struct kfd_process_device *pdd;
 	struct dbg_address_watch_info aw_info;
 	unsigned char *args_buff;
 	long status;
@@ -673,9 +688,15 @@ static int kfd_ioctl_dbg_address_watch(struct file *filep,
 
 	memset((void *) &aw_info, 0, sizeof(struct dbg_address_watch_info));
 
-	dev = kfd_device_by_id(args->gpu_id);
-	if (!dev)
+	mutex_lock(&p->mutex);
+	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
+	if (!pdd) {
+		mutex_unlock(&p->mutex);
+		pr_debug("Could not find gpu id 0x%x\n", args->gpu_id);
 		return -EINVAL;
+	}
+	dev = pdd->dev;
+	mutex_unlock(&p->mutex);
 
 	if (dev->device_info->asic_family == CHIP_CARRIZO) {
 		pr_debug("kfd_ioctl_dbg_wave_control not supported on CZ\n");
@@ -764,6 +785,7 @@ static int kfd_ioctl_dbg_wave_control(struct file *filep,
 {
 	struct kfd_ioctl_dbg_wave_control_args *args = data;
 	struct kfd_dev *dev;
+	struct kfd_process_device *pdd;
 	struct dbg_wave_control_info wac_info;
 	unsigned char *args_buff;
 	uint32_t computed_buff_size;
@@ -781,9 +803,15 @@ static int kfd_ioctl_dbg_wave_control(struct file *filep,
 				sizeof(wac_info.dbgWave_msg.MemoryVA) +
 				sizeof(wac_info.trapId);
 
-	dev = kfd_device_by_id(args->gpu_id);
-	if (!dev)
+	mutex_lock(&p->mutex);
+	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
+	if (!pdd) {
+		mutex_unlock(&p->mutex);
+		pr_debug("Could not find gpu id 0x%x\n", args->gpu_id);
 		return -EINVAL;
+	}
+	dev = pdd->dev;
+	mutex_unlock(&p->mutex);
 
 	if (dev->device_info->asic_family == CHIP_CARRIZO) {
 		pr_debug("kfd_ioctl_dbg_wave_control not supported on CZ\n");
@@ -847,16 +875,19 @@ static int kfd_ioctl_get_clock_counters(struct file *filep,
 				struct kfd_process *p, void *data)
 {
 	struct kfd_ioctl_get_clock_counters_args *args = data;
-	struct kfd_dev *dev;
+	struct kfd_process_device *pdd;
 
-	dev = kfd_device_by_id(args->gpu_id);
-	if (dev)
+	mutex_lock(&p->mutex);
+	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
+	if (pdd)
 		/* Reading GPU clock counter from KGD */
-		args->gpu_clock_counter = amdgpu_amdkfd_get_gpu_clock_counter(dev->kgd);
+		args->gpu_clock_counter = amdgpu_amdkfd_get_gpu_clock_counter(pdd->dev->kgd);
 	else
 		/* Node without GPU resource */
 		args->gpu_clock_counter = 0;
 
+	mutex_unlock(&p->mutex);
+
 	/* No access to rdtsc. Using raw monotonic time */
 	args->cpu_clock_counter = ktime_get_raw_ns();
 	args->system_clock_counter = ktime_get_boottime_ns();
@@ -1070,11 +1101,13 @@ static int kfd_ioctl_set_scratch_backing_va(struct file *filep,
 	struct kfd_dev *dev;
 	long err;
 
-	dev = kfd_device_by_id(args->gpu_id);
-	if (!dev)
-		return -EINVAL;
-
 	mutex_lock(&p->mutex);
+	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
+	if (!pdd) {
+		err = -EINVAL;
+		goto bind_process_to_device_fail;
+	}
+	dev = pdd->dev;
 
 	pdd = kfd_bind_process_to_device(dev, p);
 	if (IS_ERR(pdd)) {
@@ -1102,15 +1135,20 @@ static int kfd_ioctl_get_tile_config(struct file *filep,
 		struct kfd_process *p, void *data)
 {
 	struct kfd_ioctl_get_tile_config_args *args = data;
-	struct kfd_dev *dev;
+	struct kfd_process_device *pdd;
 	struct tile_config config;
 	int err = 0;
 
-	dev = kfd_device_by_id(args->gpu_id);
-	if (!dev)
+	mutex_lock(&p->mutex);
+	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
+	if (!pdd) {
+		mutex_unlock(&p->mutex);
 		return -EINVAL;
+	}
 
-	amdgpu_amdkfd_get_tile_config(dev->kgd, &config);
+	amdgpu_amdkfd_get_tile_config(pdd->dev->kgd, &config);
+
+	mutex_unlock(&p->mutex);
 
 	args->gb_addr_config = config.gb_addr_config;
 	args->num_banks = config.num_banks;
@@ -1145,21 +1183,15 @@ static int kfd_ioctl_acquire_vm(struct file *filep, struct kfd_process *p,
 {
 	struct kfd_ioctl_acquire_vm_args *args = data;
 	struct kfd_process_device *pdd;
-	struct kfd_dev *dev;
 	struct file *drm_file;
 	int ret;
 
-	dev = kfd_device_by_id(args->gpu_id);
-	if (!dev)
-		return -EINVAL;
-
 	drm_file = fget(args->drm_fd);
 	if (!drm_file)
 		return -EINVAL;
 
 	mutex_lock(&p->mutex);
-
-	pdd = kfd_get_process_device_data(dev, p);
+	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
 	if (!pdd) {
 		ret = -EINVAL;
 		goto err_unlock;
@@ -1218,19 +1250,23 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	if (args->size == 0)
 		return -EINVAL;
 
-	dev = kfd_device_by_id(args->gpu_id);
-	if (!dev)
-		return -EINVAL;
+	mutex_lock(&p->mutex);
+	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
+	if (!pdd) {
+		err = -EINVAL;
+		goto err_unlock;
+	}
+
+	dev = pdd->dev;
 
 	if ((flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) &&
 		(flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) &&
 		!kfd_dev_is_large_bar(dev)) {
 		pr_err("Alloc host visible vram on small bar is not allowed\n");
-		return -EINVAL;
+		err = -EINVAL;
+		goto err_unlock;
 	}
 
-	mutex_lock(&p->mutex);
-
 	pdd = kfd_bind_process_to_device(dev, p);
 	if (IS_ERR(pdd)) {
 		err = PTR_ERR(pdd);
@@ -1301,17 +1337,12 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
 	struct kfd_ioctl_free_memory_of_gpu_args *args = data;
 	struct kfd_process_device *pdd;
 	void *mem;
-	struct kfd_dev *dev;
 	int ret;
 	uint64_t size = 0;
 
-	dev = kfd_device_by_id(GET_GPU_ID(args->handle));
-	if (!dev)
-		return -EINVAL;
-
 	mutex_lock(&p->mutex);
 
-	pdd = kfd_get_process_device_data(dev, p);
+	pdd = kfd_process_device_data_by_id(p, GET_GPU_ID(args->handle));
 	if (!pdd) {
 		pr_err("Process device data doesn't exist\n");
 		ret = -EINVAL;
@@ -1325,7 +1356,7 @@ static int kfd_ioctl_free_memory_of_gpu(struct file *filep,
 		goto err_unlock;
 	}
 
-	ret = amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd,
+	ret = amdgpu_amdkfd_gpuvm_free_memory_of_gpu(pdd->dev->kgd,
 				(struct kgd_mem *)mem, pdd->drm_priv, &size);
 
 	/* If freeing the buffer failed, leave the handle in place for
@@ -1348,15 +1379,11 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 	struct kfd_ioctl_map_memory_to_gpu_args *args = data;
 	struct kfd_process_device *pdd, *peer_pdd;
 	void *mem;
-	struct kfd_dev *dev, *peer;
+	struct kfd_dev *dev;
 	long err = 0;
 	int i;
 	uint32_t *devices_arr = NULL;
 
-	dev = kfd_device_by_id(GET_GPU_ID(args->handle));
-	if (!dev)
-		return -EINVAL;
-
 	if (!args->n_devices) {
 		pr_debug("Device IDs array empty\n");
 		return -EINVAL;
@@ -1380,6 +1407,12 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 	}
 
 	mutex_lock(&p->mutex);
+	pdd = kfd_process_device_data_by_id(p, GET_GPU_ID(args->handle));
+	if (!pdd) {
+		err = -EINVAL;
+		goto get_process_device_data_failed;
+	}
+	dev = pdd->dev;
 
 	pdd = kfd_bind_process_to_device(dev, p);
 	if (IS_ERR(pdd)) {
@@ -1395,21 +1428,21 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 	}
 
 	for (i = args->n_success; i < args->n_devices; i++) {
-		peer = kfd_device_by_id(devices_arr[i]);
-		if (!peer) {
+		peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
+		if (!peer_pdd) {
 			pr_debug("Getting device by id failed for 0x%x\n",
 				 devices_arr[i]);
 			err = -EINVAL;
 			goto get_mem_obj_from_handle_failed;
 		}
 
-		peer_pdd = kfd_bind_process_to_device(peer, p);
+		peer_pdd = kfd_bind_process_to_device(peer_pdd->dev, p);
 		if (IS_ERR(peer_pdd)) {
 			err = PTR_ERR(peer_pdd);
 			goto get_mem_obj_from_handle_failed;
 		}
 		err = amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
-			peer->kgd, (struct kgd_mem *)mem, peer_pdd->drm_priv);
+			peer_pdd->dev->kgd, (struct kgd_mem *)mem, peer_pdd->drm_priv);
 		if (err) {
 			pr_err("Failed to map to gpu %d/%d\n",
 			       i, args->n_devices);
@@ -1428,12 +1461,10 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 
 	/* Flush TLBs after waiting for the page table updates to complete */
 	for (i = 0; i < args->n_devices; i++) {
-		peer = kfd_device_by_id(devices_arr[i]);
-		if (WARN_ON_ONCE(!peer))
-			continue;
-		peer_pdd = kfd_get_process_device_data(peer, p);
+		peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
 		if (WARN_ON_ONCE(!peer_pdd))
 			continue;
+
 		kfd_flush_tlb(peer_pdd);
 	}
 
@@ -1441,6 +1472,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 
 	return err;
 
+get_process_device_data_failed:
 bind_process_to_device_failed:
 get_mem_obj_from_handle_failed:
 map_memory_to_gpu_failed:
@@ -1458,14 +1490,9 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 	struct kfd_ioctl_unmap_memory_from_gpu_args *args = data;
 	struct kfd_process_device *pdd, *peer_pdd;
 	void *mem;
-	struct kfd_dev *dev, *peer;
 	long err = 0;
 	uint32_t *devices_arr = NULL, i;
 
-	dev = kfd_device_by_id(GET_GPU_ID(args->handle));
-	if (!dev)
-		return -EINVAL;
-
 	if (!args->n_devices) {
 		pr_debug("Device IDs array empty\n");
 		return -EINVAL;
@@ -1489,8 +1516,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 	}
 
 	mutex_lock(&p->mutex);
-
-	pdd = kfd_get_process_device_data(dev, p);
+	pdd = kfd_process_device_data_by_id(p, GET_GPU_ID(args->handle));
 	if (!pdd) {
 		err = -EINVAL;
 		goto bind_process_to_device_failed;
@@ -1504,19 +1530,13 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 	}
 
 	for (i = args->n_success; i < args->n_devices; i++) {
-		peer = kfd_device_by_id(devices_arr[i]);
-		if (!peer) {
-			err = -EINVAL;
-			goto get_mem_obj_from_handle_failed;
-		}
-
-		peer_pdd = kfd_get_process_device_data(peer, p);
+		peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
 		if (!peer_pdd) {
-			err = -ENODEV;
+			err = -EINVAL;
 			goto get_mem_obj_from_handle_failed;
 		}
 		err = amdgpu_amdkfd_gpuvm_unmap_memory_from_gpu(
-			peer->kgd, (struct kgd_mem *)mem, peer_pdd->drm_priv);
+			peer_pdd->dev->kgd, (struct kgd_mem *)mem, peer_pdd->drm_priv);
 		if (err) {
 			pr_err("Failed to unmap from gpu %d/%d\n",
 			       i, args->n_devices);
@@ -1645,23 +1665,26 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
 	void *mem;
 	int r;
 
-	dev = kfd_device_by_id(args->gpu_id);
-	if (!dev)
-		return -EINVAL;
+	mutex_lock(&p->mutex);
+	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
+	if (!pdd) {
+		r = -EINVAL;
+		goto err_unlock;
+	}
 
 	dmabuf = dma_buf_get(args->dmabuf_fd);
-	if (IS_ERR(dmabuf))
-		return PTR_ERR(dmabuf);
-
-	mutex_lock(&p->mutex);
+	if (IS_ERR(dmabuf)) {
+		r = PTR_ERR(dmabuf);
+		goto err_unlock;
+	}
 
-	pdd = kfd_bind_process_to_device(dev, p);
+	pdd = kfd_bind_process_to_device(pdd->dev, p);
 	if (IS_ERR(pdd)) {
 		r = PTR_ERR(pdd);
 		goto err_unlock;
 	}
 
-	r = amdgpu_amdkfd_gpuvm_import_dmabuf(dev->kgd, dmabuf,
+	r = amdgpu_amdkfd_gpuvm_import_dmabuf(pdd->dev->kgd, dmabuf,
 					      args->va_addr, pdd->drm_priv,
 					      (struct kgd_mem **)&mem, &size,
 					      NULL);
@@ -1695,13 +1718,19 @@ static int kfd_ioctl_smi_events(struct file *filep,
 				struct kfd_process *p, void *data)
 {
 	struct kfd_ioctl_smi_events_args *args = data;
-	struct kfd_dev *dev;
+	struct kfd_process_device *pdd;
 
-	dev = kfd_device_by_id(args->gpuid);
-	if (!dev)
+	mutex_lock(&p->mutex);
+
+	pdd = kfd_process_device_data_by_id(p, args->gpuid);
+	if (!pdd) {
+		mutex_unlock(&p->mutex);
 		return -EINVAL;
+	}
 
-	return kfd_smi_event_open(dev, &args->anon_fd);
+	mutex_unlock(&p->mutex);
+
+	return kfd_smi_event_open(pdd->dev, &args->anon_fd);
 }
 
 static int kfd_ioctl_set_xnack_mode(struct file *filep,
@@ -1800,6 +1829,57 @@ static int criu_dump_process(struct kfd_process *p, struct kfd_ioctl_criu_dumper
 	return ret;
 }
 
+static int criu_dump_devices(struct kfd_process *p, struct kfd_ioctl_criu_dumper_args *args)
+{
+	struct kfd_criu_device_bucket *device_buckets;
+	int ret = 0, i;
+
+	if (args->num_objects != p->n_pdds) {
+		pr_err("Mismatch with number of devices (current:%d user:%lld)\n",
+							p->n_pdds, args->num_objects);
+		return -EINVAL;
+	}
+
+	if (args->objects_size != args->num_objects *
+		(sizeof(*device_buckets) + sizeof(struct kfd_criu_device_priv_data))) {
+		pr_err("Invalid objects size for devices\n");
+		return -EINVAL;
+	}
+
+	device_buckets = kvzalloc(args->objects_size, GFP_KERNEL);
+	if (!device_buckets)
+		return -ENOMEM;
+
+	/* Private data for devices it not currently used. To set private data
+	 * struct kfd_criu_device_priv_data * device_privs = (struct kfd_criu_device_priv_data*)
+	 *				((uint8_t*)device_buckets +
+	 *				 (args->num_objects * (sizeof(*device_buckets))));
+	 */
+
+	for (i = 0; i < args->num_objects; i++) {
+		struct kfd_process_device *pdd = p->pdds[i];
+
+		device_buckets[i].user_gpu_id = pdd->user_gpu_id;
+		device_buckets[i].actual_gpu_id = pdd->dev->id;
+
+		/* priv_data does not contain useful information for now and is reserved for
+		 * future use, so we do not set its contents
+		 */
+		device_buckets[i].priv_data_offset = i * sizeof(struct kfd_criu_device_priv_data);
+		device_buckets[i].priv_data_size = sizeof(struct kfd_criu_device_priv_data);
+	}
+
+	ret = copy_to_user((void __user *)args->objects, device_buckets, args->objects_size);
+
+	if (ret) {
+		pr_err("Failed to copy device information to user\n");
+		ret = -EFAULT;
+	}
+
+	kvfree(device_buckets);
+	return ret;
+}
+
 uint64_t get_process_num_bos(struct kfd_process *p)
 {
 	uint64_t num_of_bos = 0, i;
@@ -2231,6 +2311,9 @@ static int kfd_ioctl_criu_dumper(struct file *filep,
 	case KFD_CRIU_OBJECT_TYPE_PROCESS:
 		ret = criu_dump_process(p, args);
 		break;
+	case KFD_CRIU_OBJECT_TYPE_DEVICE:
+		ret = criu_dump_devices(p, args);
+		break;
 	case KFD_CRIU_OBJECT_TYPE_BO:
 		ret = criu_dump_bos(p, args);
 		break;
@@ -2240,7 +2323,6 @@ static int kfd_ioctl_criu_dumper(struct file *filep,
 	case KFD_CRIU_OBJECT_TYPE_EVENT:
 		ret = criu_dump_events(p, args);
 		break;
-	case KFD_CRIU_OBJECT_TYPE_DEVICE:
 	case KFD_CRIU_OBJECT_TYPE_SVM_RANGE:
 	default:
 		pr_err("Unsupported object type:%d\n", args->type);
@@ -2301,6 +2383,102 @@ static int criu_restore_process(struct kfd_process *p, struct kfd_ioctl_criu_res
 	return ret;
 }
 
+static int criu_restore_devices(struct kfd_process *p, struct kfd_ioctl_criu_restorer_args *args)
+{
+	int ret = 0, i;
+	uint8_t *objects;
+	struct kfd_criu_device_bucket *device_buckets;
+
+	if (args->num_objects != p->n_pdds)
+		return -EINVAL;
+
+	if (args->objects_size != args->num_objects *
+		(sizeof(*device_buckets) + sizeof(struct kfd_criu_device_priv_data))) {
+		pr_err("Invalid objects size for devices\n");
+		return -EINVAL;
+	}
+
+	objects = kmalloc(args->objects_size, GFP_KERNEL);
+	if (!objects)
+		return -ENOMEM;
+
+	ret = copy_from_user(objects, (void __user *)args->objects, args->objects_size);
+	if (ret) {
+		pr_err("Failed to copy devices information from user\n");
+		ret = -EFAULT;
+		goto exit;
+	}
+
+	device_buckets = (struct kfd_criu_device_bucket *) objects;
+
+	for (i = 0; i < args->num_objects; i++) {
+		struct kfd_dev *dev;
+		struct kfd_process_device *pdd;
+		struct file *drm_file;
+
+		/* device private data is not currently used. To access device private data:
+		 * uint8_t *private_datas = objects +
+		 *				(args->num_objects * sizeof(*device_buckets));
+		 *
+		 * struct kfd_criu_device_priv_data *device_priv =
+		 *			(struct kfd_criu_device_priv_data*)
+		 *			(private_datas + device_buckets[i].priv_data_offset);
+		 */
+
+		dev = kfd_device_by_id(device_buckets[i].actual_gpu_id);
+		if (!dev) {
+			pr_err("Failed to find device with gpu_id = %x\n",
+				device_buckets[i].actual_gpu_id);
+			ret = -EINVAL;
+			goto exit;
+		}
+
+		pdd = kfd_get_process_device_data(dev, p);
+		if (!pdd) {
+			pr_err("Failed to get pdd for gpu_id = %x\n",
+					device_buckets[i].actual_gpu_id);
+			ret = -EINVAL;
+			goto exit;
+		}
+		pdd->user_gpu_id = device_buckets[i].user_gpu_id;
+
+		drm_file = fget(device_buckets[i].drm_fd);
+		if (!drm_file) {
+			pr_err("Invalid render node file descriptor sent from plugin (%d)\n",
+				device_buckets[i].drm_fd);
+			ret = -EINVAL;
+			goto exit;
+		}
+
+		if (pdd->drm_file) {
+			ret = -EINVAL;
+			goto exit;
+		}
+
+		/* create the vm using render nodes for kfd pdd */
+		if (kfd_process_device_init_vm(pdd, drm_file)) {
+			pr_err("could not init vm for given pdd\n");
+			/* On success, the PDD keeps the drm_file reference */
+			fput(drm_file);
+			ret = -EINVAL;
+			goto exit;
+		}
+		/*
+		 * pdd now already has the vm bound to render node so below api won't create a new
+		 * exclusive kfd mapping but use existing one with renderDXXX but is still needed
+		 * for iommu v2 binding  and runtime pm.
+		 */
+		pdd = kfd_bind_process_to_device(dev, p);
+		if (IS_ERR(pdd)) {
+			ret = PTR_ERR(pdd);
+			goto exit;
+		}
+	}
+exit:
+	kvfree(objects);
+	return ret;
+}
+
 static int criu_restore_bos(struct kfd_process *p, struct kfd_ioctl_criu_restorer_args *args)
 {
 	uint8_t *objects, *private_data;
@@ -2719,6 +2897,9 @@ static int kfd_ioctl_criu_restorer(struct file *filep,
 	case KFD_CRIU_OBJECT_TYPE_PROCESS:
 		ret = criu_restore_process(p, args);
 		break;
+	case KFD_CRIU_OBJECT_TYPE_DEVICE:
+		ret = criu_restore_devices(p, args);
+		break;
 	case KFD_CRIU_OBJECT_TYPE_BO:
 		ret = criu_restore_bos(p, args);
 		break;
@@ -2728,7 +2909,6 @@ static int kfd_ioctl_criu_restorer(struct file *filep,
 	case KFD_CRIU_OBJECT_TYPE_EVENT:
 		ret = criu_restore_events(filep, p, args);
 		break;
-	case KFD_CRIU_OBJECT_TYPE_DEVICE:
 	case KFD_CRIU_OBJECT_TYPE_SVM_RANGE:
 	default:
 		pr_err("Unsupported object type:%d\n", args->type);
@@ -2819,6 +2999,11 @@ static int kfd_ioctl_criu_process_info(struct file *filep,
 
 	args->process_priv_data_size = sizeof(struct kfd_criu_process_priv_data);
 
+	args->total_devices = p->n_pdds;
+	/* devices_priv_data_size does not contain any useful information for now */
+	args->devices_priv_data_size = args->total_devices *
+					sizeof(struct kfd_criu_device_priv_data);
+
 	args->total_bos = get_process_num_bos(p);
 	args->bos_priv_data_size = args->total_bos * sizeof(struct kfd_criu_bo_priv_data);
 
@@ -2832,7 +3017,8 @@ static int kfd_ioctl_criu_process_info(struct file *filep,
 	args->total_events = kfd_get_num_events(p);
 	args->events_priv_data_size = args->total_events * sizeof(struct kfd_criu_event_priv_data);
 
-	dev_dbg(kfd_device, "Num of bos:%llu queues:%u events:%u\n",
+	dev_dbg(kfd_device, "Num of devices:%u bos:%llu queues:%u events:%u\n",
+				args->total_devices,
 				args->total_bos,
 				args->total_queues,
 				args->total_events);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 18362478e351..5e9067b70908 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -343,11 +343,12 @@ int kfd_kmap_event_page(struct kfd_process *p, uint64_t event_page_offset)
 		return -EINVAL;
 	}
 
-	kfd = kfd_device_by_id(GET_GPU_ID(event_page_offset));
-	if (!kfd) {
+	pdd = kfd_process_device_data_by_id(p, GET_GPU_ID(event_page_offset));
+	if (!pdd) {
 		pr_err("Getting device by id failed in %s\n", __func__);
 		return -EINVAL;
 	}
+	kfd = pdd->dev;
 
 	pdd = kfd_bind_process_to_device(kfd, p);
 	if (IS_ERR(pdd))
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index bf10a5305ef7..1912df8d9101 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -759,6 +759,13 @@ struct kfd_process_device {
 	 *  number of CU's a device has along with number of other competing processes
 	 */
 	struct attribute attr_cu_occupancy;
+
+	/*
+	 * If this process has been checkpointed before, then the user
+	 * application will use the original gpu_id on the
+	 * checkpointed node to refer to this device.
+	 */
+	uint32_t user_gpu_id;
 };
 
 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
@@ -914,6 +921,9 @@ int kfd_process_restore_queues(struct kfd_process *p);
 void kfd_suspend_all_processes(void);
 int kfd_resume_all_processes(void);
 
+struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *process,
+				uint32_t gpu_id);
+
 int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 			       struct file *drm_file);
 struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index e4cb2f778590..a23f2162eb8b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1425,6 +1425,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
 	pdd->runtime_inuse = false;
 	pdd->vram_usage = 0;
 	pdd->sdma_past_activity_counter = 0;
+	pdd->user_gpu_id = dev->id;
 	atomic64_set(&pdd->evict_duration_counter, 0);
 	p->pdds[p->n_pdds++] = pdd;
 
@@ -1898,6 +1899,23 @@ void kfd_flush_tlb(struct kfd_process_device *pdd)
 	}
 }
 
+struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *p, uint32_t gpu_id)
+{
+	int i;
+
+	if (gpu_id) {
+		for (i = 0; i < p->n_pdds; i++) {
+			struct kfd_process_device *pdd = p->pdds[i];
+
+			if (pdd->user_gpu_id == gpu_id)
+				return pdd;
+		}
+
+		WARN_ONCE(1, "Failed to find mapping for gpu = 0x%x\n",  gpu_id);
+	}
+	return NULL;
+}
+
 #if defined(CONFIG_DEBUG_FS)
 
 int kfd_debugfs_mqds_by_process(struct seq_file *m, void *data)
-- 
2.17.1


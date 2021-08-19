Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C21C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D84BC610CF
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D84BC610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52F766E948;
	Thu, 19 Aug 2021 13:37:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D7A76E948
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 13:37:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTSB3Uoa8ffVXfpKgWKQ9ZcAFB8RYQgDUq9RKqyPz2SKW8jxuGQ9aCaSLDqPeIVoIDq+eyYJRhaG2W5kYsV4CxloVvnl6rKnWYFgzyo7myTq+XkCNHolXa+tgylvydHVVcrVXew7sfLr67XoqEzgv0xpMF2Kitsl+Sfw7kdasYH6859Zp/oySTCUxheMQavSgXIqsIFNSTPYjGa1LzPeo1OtSDwZYQiooNb2hEy2HOhFp8WQFfV2tgLDn2gdaDVubvjhUFBBcI6A5RKSCaAqCRfzoxUuEE94G3mR995HXfD4nG+7hWxARMUoGRVD6Z9GsTsZDtklXJ/MlB18BAx1jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjwBk71/oDSX3HWqVHOCb7Xgy58BIRmAh0+FBQCF+iA=;
 b=TtKUSa/MfWeWjo5oO5bukiILxoCyNjfE7HRp5ou4AO3T+dEhRIzI43fgosnajV9+cQsK13egntBAJqUYJ3LpuzCMQzc7svDzK2PDedTZoIJ9p9CDI8RiLcbQvosInn1KYFUl3CEOtMrmI2H8JQckHqf9bEnACtFh5xG6dpPG2yoKnxZulX1ua+gkSJIVhmUVV5sno0o277zpdw92IFb62vXqYQ3YTrCLXopTsBQhDMn8Z8PF0hYnb2gwi4UjfClxhGpAzabKfuklIArUaVQiCY0+XxxydmcwQqsVhqS4cJMDfSzjXVkoc1pcd/C5GepUfDZ10G22pf59ddJ89zwEYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjwBk71/oDSX3HWqVHOCb7Xgy58BIRmAh0+FBQCF+iA=;
 b=QwG2Ar0Ii/34pf5SvdUcV/NZDa92GHSfsNcUZIPMGd8K+VZPeUys2M73/2/fKkv+y5460Arqx9wLfmlyx4sP+T2naWwYyCNyOak6SbgYNLXlC7x0OYe9X54CnvqqCaK/uGKassKC5hXsJ0ah7Aj4JcH2kY8rNaF4eaO0XVOPnfM=
Received: from MWHPR2201CA0057.namprd22.prod.outlook.com
 (2603:10b6:301:16::31) by BN6PR12MB1395.namprd12.prod.outlook.com
 (2603:10b6:404:1f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Thu, 19 Aug
 2021 13:37:49 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::80) by MWHPR2201CA0057.outlook.office365.com
 (2603:10b6:301:16::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Thu, 19 Aug 2021 13:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 13:37:48 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 19 Aug
 2021 08:37:47 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH 04/18] drm/amdkfd: CRIU Implement KFD process_info ioctl
Date: Thu, 19 Aug 2021 09:36:59 -0400
Message-ID: <20210819133713.4168-5-david.yatsin@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b2c2cc1f-ceb6-4993-5516-08d963168923
X-MS-TrafficTypeDiagnostic: BN6PR12MB1395:
X-Microsoft-Antispam-PRVS: <BN6PR12MB139528BE7B4ED0B7E69F50B295C09@BN6PR12MB1395.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sFgwpq1Ng27CUDZZyG+fEZT1BDIZZRQIS7oZtqIaW72yp2yHEZyXtivx6ohYz+mNhhFOGq7O7Eohm8ewiY2M/npmhDnMa7z8auo8u+hIGZP+kmhHWbNQzYSQ/hBB/x4d+k8oYxRZS3K09mGe2tszqhoH4x9767Z0Y2GVgH6W/D25JzzbNTP6jWsTf7oWK4T2nesUlHQWwGZlT+KHFqArFrIN0gH4Hp+gjEW9ilqbrETd6CJRS9Sgf3nYQbYb2qMWoMNEjfwAbKyZMYgXAZGcLrnl5qW1aWva5MHZJVSFWMGNjqYAyDTMeFEJyxTdNiz2MHGmoyD6G6eyFk0nPMAWVNbFH50GV6qVcpNR+n1HuhzIn03Qc+gbIcEVv6sTVummP/vdLQ1mxGCUtEoZtspj5iaVwS5dxYrWmUavQdvAWYBQWZcHgXV/9fYXboI4W5Xzh2FtmySm4vm3kdW7qIHqTtRF/eeuAcu7SGluzxMerbqki7pQBnNuVvelOU+AffbnoDo+tf0g6Cz835gHznISCUhv8LxWQXAlqvAZsRxEUkpwOl1aezxbkClF6ku3MjWXFof2o9QFMDqdOctYMOSUnKDL+0roPIg4Jc+XbfnuHLlo4SICRCq7gd/8YT1iDrs3/R/hQ6bgYl+mAHnA58nZXjJMXtRRVfhBA0aoLSRc6PFBaZSEPS4MdZwx5mNMg7v+64+Af/UDPPm2chjIl+uGQkMzcjT9WGs1NnCyg3jaJmZaA/4p79D+XbvMbWqfEoPwzS8PR/PxT/TRI7SrXVQdYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(36840700001)(16526019)(26005)(36860700001)(7696005)(82310400003)(336012)(186003)(8936002)(426003)(2616005)(5660300002)(86362001)(8676002)(6666004)(6916009)(356005)(70206006)(82740400003)(81166007)(54906003)(36756003)(2906002)(47076005)(4326008)(478600001)(83380400001)(34020700004)(1076003)(316002)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 13:37:48.9291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c2cc1f-ceb6-4993-5516-08d963168923
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1395
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

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

This IOCTL is expected to be called as a precursor to the actual
Checkpoint operation. This does the basic discovery into the target
process seized by CRIU and relays the information to the userspace that
utilizes it to start the Checkpoint operation via another dedicated
IOCTL.

The process_info IOCTL determines the number of GPUs, buffer objects that
are associated with the target process, its process id in caller's
namespace since /proc/pid/mem interface maybe used to drain the contents of
the discovered buffer objects in userspace and getpid returns the pid of
CRIU dumper process. Also the pid of a process inside a container might
be different than its global pid so return the ns pid.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
(cherry picked from commit b2fa92d0a8f1de51013cd6742b4996b38c285ffc)
(cherry picked from commit 8b44c466ce53162603cd8ae49624462902541a47)
Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 44 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 14 ++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index a1b60d29aae1..09e2d30515e2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1803,6 +1803,27 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 	return -EPERM;
 }
 #endif
+
+uint64_t get_process_num_bos(struct kfd_process *p)
+{
+	uint64_t num_of_bos = 0, i;
+
+	/* Run over all PDDs of the process */
+	for (i = 0; i < p->n_pdds; i++) {
+		struct kfd_process_device *pdd = p->pdds[i];
+		void *mem;
+		int id;
+
+		idr_for_each_entry(&pdd->alloc_idr, mem, id) {
+			struct kgd_mem *kgd_mem = (struct kgd_mem *)mem;
+
+			if ((uint64_t)kgd_mem->va > pdd->gpuvm_base)
+				num_of_bos++;
+		}
+	}
+	return num_of_bos;
+}
+
 static int kfd_ioctl_criu_dumper(struct file *filep,
 				struct kfd_process *p, void *data)
 {
@@ -1837,9 +1858,30 @@ static int kfd_ioctl_criu_resume(struct file *filep,
 static int kfd_ioctl_criu_process_info(struct file *filep,
 				struct kfd_process *p, void *data)
 {
+	struct kfd_ioctl_criu_process_info_args *args = data;
+	int ret = 0;
+
 	pr_debug("Inside %s\n", __func__);
+	mutex_lock(&p->mutex);
 
-	return 0;
+	if (!kfd_has_process_device_data(p)) {
+		pr_err("No pdd for given process\n");
+		ret = -ENODEV;
+		goto err_unlock;
+	}
+
+	args->task_pid = task_pid_nr_ns(p->lead_thread,
+					task_active_pid_ns(p->lead_thread));
+
+	args->process_priv_data_size = sizeof(struct kfd_criu_process_priv_data);
+
+	args->total_bos = get_process_num_bos(p);
+	args->bos_priv_data_size = args->total_bos * sizeof(struct kfd_criu_bo_priv_data);
+
+	dev_dbg(kfd_device, "Num of bos:%llu\n", args->total_bos);
+err_unlock:
+	mutex_unlock(&p->mutex);
+	return ret;
 }
 
 #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 768cc3fe95d2..4e390006b4b6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -932,6 +932,8 @@ void *kfd_process_device_translate_handle(struct kfd_process_device *p,
 void kfd_process_device_remove_obj_handle(struct kfd_process_device *pdd,
 					int handle);
 
+bool kfd_has_process_device_data(struct kfd_process *p);
+
 /* PASIDs */
 int kfd_pasid_init(void);
 void kfd_pasid_exit(void);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 9d4f527bda7c..bc133c3789d8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1359,6 +1359,20 @@ static int init_doorbell_bitmap(struct qcm_process_device *qpd,
 	return 0;
 }
 
+bool kfd_has_process_device_data(struct kfd_process *p)
+{
+	int i;
+
+	for (i = 0; i < p->n_pdds; i++) {
+		struct kfd_process_device *pdd = p->pdds[i];
+
+		if (pdd)
+			return true;
+	}
+
+	return false;
+}
+
 struct kfd_process_device *kfd_get_process_device_data(struct kfd_dev *dev,
 							struct kfd_process *p)
 {
-- 
2.17.1


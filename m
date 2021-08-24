Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDDEC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE60C61163
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DE60C61163
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C936E0BC;
	Tue, 24 Aug 2021 19:22:09 +0000 (UTC)
X-Greylist: delayed 865 seconds by postgrey-1.36 at gabe;
 Tue, 24 Aug 2021 19:22:06 UTC
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (unknown
 [40.107.212.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64D3389A9F
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 19:22:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWZPCZ+foUIWjFkvWdRatQcNtrRsQW3oUYLQ5Z17C1EAiJ/Iy2ocO86Pvijq6nR01unDu0HAiT7tmsK5k0KW79kT19laSLKpNTFtIqv+hxh74kBnCh5bbcDKO9UoMGAI8XvHanaczGt8ODBe3IEycwfCJg+lK6CW0G/NINxwMZhjTL+JSpG2EWVMnjr9QWEhwFcYYYv0ttu7B6fMpqtLMrqEeNga0tSDnhv6C2S7Ei9eilCev9p9ahmnG9ALvTf1z3+3GssOBSavZqeamPRdclDHVzQrSOklEglhlhLu8TKcTGXC32AfdFJlFe4d1NWO6UKxEmYyFVWF2nqiysCOPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjwBk71/oDSX3HWqVHOCb7Xgy58BIRmAh0+FBQCF+iA=;
 b=fGK8DrzknYPd7oS8jFKpqRL6Y2uspcV0RMspVIywOneC+pDQnn8RxCXeYOM2uHIdCZIxwBhdkNZ1flC8PxdpdjRhRXB0Yc2Au7mErsnlAZTTG5n3eiy80CHHKhm/3e8w4CIDZc1HlDYO0ucL/k4Lbqnj9XkEhkTuXU3Z3QqDXwARwzSkhqbSV3cFeU7Q3Hsjl4/VZcc6Aq7ACaYQPcHsVl/tE3qEO2rNJy4u0AsgWgUfYagwyfl+I0XRMcnb4gOiblq4xfUyRVaoKT5Q+bGKlYXB6nn2ouoRKLSzZomwPar52NBZsalDTcE/osb7W2yIKf4E8m+F8KyLPLYSvj7cyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjwBk71/oDSX3HWqVHOCb7Xgy58BIRmAh0+FBQCF+iA=;
 b=jL53G7ilfj8+DA6eMyF98MDAzK0fPfDVBNzUY0XK6jWd3p4cb2NzvtvHCA9/rlmu8vYzBZtujNb6xxwLpHzh3WNtlWWpyXgThoQjH1CxipnWypzOgqt4LEr9o1ZP3eT4EBxBmzNjVwi80OuZQMc1+72kosGmcGXkL0IoGlleYNQ=
Received: from DM6PR13CA0004.namprd13.prod.outlook.com (2603:10b6:5:bc::17) by
 BN6PR12MB1505.namprd12.prod.outlook.com (2603:10b6:405:5::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.21; Tue, 24 Aug 2021 19:07:35 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::51) by DM6PR13CA0004.outlook.office365.com
 (2603:10b6:5:bc::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.6 via Frontend
 Transport; Tue, 24 Aug 2021 19:07:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 19:07:34 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 14:07:31 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH v2 04/18] drm/amdkfd: CRIU Implement KFD process_info ioctl
Date: Tue, 24 Aug 2021 15:06:25 -0400
Message-ID: <20210824190639.6288-5-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210824190639.6288-1-david.yatsin@amd.com>
References: <20210824190639.6288-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad020150-c736-4c78-3a1f-08d967326e81
X-MS-TrafficTypeDiagnostic: BN6PR12MB1505:
X-Microsoft-Antispam-PRVS: <BN6PR12MB15053E292D342335C478C56895C59@BN6PR12MB1505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zi70+JDERWvThqzgBR0b2810k4lKmhAy/5P6ohVD91FIwBuNzaftHv+uTzgEV88mtOUgPe9m5PKFQczdgiUb/YMMSm5BMQl3thk3zVernnd+WLTnMwYCUQ3m9y4CkxeuNgu/IeiDKe8jXdmm5qwyM+ASVrqoLA2enpF/+riL6rQTm0yfFulAJJyZKD7viO5j+NFnvhw8ibZGFaIEh8whXE8ee9c/A71xzsAsZ91wULCJmmLeVCax4UkYt135SeEc3ylTDgDCuENHVYMRzXOcP/ppKhgz+WKwa9fQgxdUan7n4NV4sQMX5ZUfNf9CkGQtjmN3EDLT0fJ7n6pDgDpOgJfilVlGWjJEFA1en3Ns825FscxT0yOs9MXhR4+bpxhcVh0qW3FmSYs/J72WZiQP2WvXR2jYA/Zkfn+mlgzFPW8A9fJ+nwXRVg/ObGn117K8/++1PmlV0MjXzfwKovw63J3wZ1S8eJxpr2i8gt+RFLygo+sYuxjrFJzkRS3kloetjw6FC+SLYEowUwqjJrqn+QQb0Jpugx973hfhi4oviQsEHvtu21qFPPClpqxK3F1+iTIXUn3xezSXw9xPdlOHnkd+I5Pz6INZCyDvHeInSlYu4EjrwMWD3AcxykidGIznGAnCxWlsBRsQZJW7mMEaeUJ0DyyVAxjIlnXaI1kEFpFPb8fk3ID7nuPE2Jy35KrJqOaaqtTwjTbmaj/3HzlvhRHt9D70ealQHdZ6H58kWeY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(36840700001)(46966006)(4326008)(7696005)(6916009)(86362001)(186003)(47076005)(82310400003)(36860700001)(83380400001)(16526019)(336012)(6666004)(8676002)(1076003)(26005)(478600001)(426003)(70206006)(82740400003)(70586007)(8936002)(54906003)(316002)(36756003)(2616005)(81166007)(2906002)(5660300002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 19:07:34.8564 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad020150-c736-4c78-3a1f-08d967326e81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1505
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


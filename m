Return-Path: <SRS0=/upn=OT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F22C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 12:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7DE961452
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Sep 2021 12:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C7DE961452
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23C4E6EA49;
	Wed, 29 Sep 2021 12:01:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69FD16EA46
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Sep 2021 12:01:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2yFIJvTyiooJ4YQjIMdd4TSPfF2A1ukhXSl0YykQegSRuFkEnOxregogj24fE9NxTjUiA3sr8lMJ/3xlg85exIWpzmnIrrGWt1vZpjYYrE01HgD8j2dXDO80ZHlLf67UvMNQxnHKsspvUNiWHDRdGQIqQE3/8KdtHbverBFZ3ES6B8Z8psO37FUHjIPUrc/2W7p03vrf72a0ySwN/Hlz8zdc4+mwqC+aAxAHhmoIYzF4///w4mlbDiQii96eZjOdq9X+BKNsNmo4AirPsmszftDpxazHfvSV1M9HXZQFzqiI3EEtWH/r2MHgiiDaVE/quwIf2vlDljfOVYSoQaRNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=MhLytlXAOp7I4JR1bVdjv/cFrqBFJOqd6BMHyF5T1Ec=;
 b=lLPF60mZVhMxdTi4lckITR2rxRrJdv4uqmTY0jIHKstJ2oZqCoVdOjdDa493c6P/sjvAPF26/iSG92JoAm/GQ3d03zXw1e6OnIrb+c8K39uR4e+a8su+ms9eJRke4gY+EmW05Ia85By4RHH7TMguZImHivU4Ac+PkhJg/EFdgkbdCfF+oIUc83AFbK9bYKfqRDdgxg3REyt73McR2kAf8XCrjYUf8MX5lhg2nUxlj8y6YUbzoVyMixfREDtciEcw+dlTSUnDN/7wymq9eaSVEuhwjNTgwwbpwrnw7mvyiuZP8sw7dv6XWOyA3dNz9yyHHlyV4N4f0SlIivmMoJ50xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhLytlXAOp7I4JR1bVdjv/cFrqBFJOqd6BMHyF5T1Ec=;
 b=tzPBJOoGHjFyEmrRWrs+mV2HgJoWHEvlJMYMamKfxKQFJf4y4WlaIcQUYNV+CqiibO7sEYAFo4oC7NUbMG8LyGlAUjc+y53mJwxFAksOw7wiFNbOwmQh7oXDjxwYidPjen6h2EOY9OeuIbj8lb9KgPPK6+hmH4TotBPWa4FkKPo=
Received: from MW4P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::11)
 by BN6PR1201MB0130.namprd12.prod.outlook.com (2603:10b6:405:59::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 29 Sep
 2021 12:01:07 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::4f) by MW4P223CA0006.outlook.office365.com
 (2603:10b6:303:80::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Wed, 29 Sep 2021 12:01:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Wed, 29 Sep 2021 12:01:06 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 29 Sep
 2021 07:01:03 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH v3 03/16] drm/amdkfd: CRIU Implement KFD process_info ioctl
Date: Wed, 29 Sep 2021 08:00:25 -0400
Message-ID: <20210929120038.6485-4-david.yatsin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210929120038.6485-1-david.yatsin@amd.com>
References: <20210929120038.6485-1-david.yatsin@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 985da3fe-7743-4bee-9f44-08d98340d1c4
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0130:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0130728A500B4B71DCD36D9695A99@BN6PR1201MB0130.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d0EV7Om3XTPm1wD92MtDQNeUGOqsC/vZ+qWWdYghlaSU9zVQsRSHvr8y628wy8+7cxwplxQwMNloTImVpaw2aEQoW/Z0+cg5dy2pK4PG3pARYUv4y06TWN/mhILuANGc6RaM3w9t+E6SYTWaRJ9AFW/K5MEk3KqMDovpU7ioLyBSL+XSlwgsa2DXGmqToim/iM5pvV8a8SOvkWCQQft6RKclW0nEYTZOECrzKnk8FJEvUJ0UA4Rz7XH7MgNAN5VvYZJRz/PtbBn70fD06cJ4VJrVE48Owadt7vatIWB3f5PgCg/xcMbthxlzmkJWVb943RwmRiMyULlgTAC/zEh0/BKIebkjMynUW8xBzXtNRpWYC9Umk+nLJS4Cyo86jLYLkOp1PkUlWOBZa3mgMScTl4rsPHguaKqw9yyzAC9/6BXk5vYuYDwqcS2g8pX2jJHdsVbf+++1Z8Nmvqoa2xVEQdxn4+rW/mtLXvfvIHNA1MjCt1aK1FCv37p3Islhxc9bab7nNa0fd9si4JK+JAssHunuDc8HovvWs0dKIWfDPeR8i3mfvs9dCtABBS5PZvkn5pvETsLfchxBv4kFisk5BFLiifTK3iXeMb3UzLXiUesw4IZz1mONKtRfRMmuPxQ9fe8soCTBS4RkfzpadfjS/Nk3BDezNysvy+hCMlWDqffmN4y5Taz8FXP9I/WJmwDc+jUhfENegQAyg7k0kjRJJ2/J5dMWqID9s83O+xCHUdc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(82310400003)(86362001)(83380400001)(356005)(47076005)(8676002)(81166007)(1076003)(36860700001)(7696005)(8936002)(6916009)(5660300002)(26005)(186003)(16526019)(70586007)(316002)(6666004)(336012)(70206006)(508600001)(4326008)(2616005)(426003)(54906003)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2021 12:01:06.8578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 985da3fe-7743-4bee-9f44-08d98340d1c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0130
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

The process_info IOCTL determines the number of GPUs, buffer objects
that are associated with the target process, its process id in
caller's namespace since /proc/pid/mem interface maybe used to drain
the contents of the discovered buffer objects in userspace and getpid
returns the pid of CRIU dumper process. Also the pid of a process
inside a container might be different than its global pid so return
the ns pid.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 44 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 14 ++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 231f8e3b43f6..1906ded40698 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1841,6 +1841,26 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 	return -EPERM;
 }
 #endif
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
@@ -1867,7 +1887,29 @@ static int kfd_ioctl_criu_resume(struct file *filep,
 static int kfd_ioctl_criu_process_info(struct file *filep,
 				struct kfd_process *p, void *data)
 {
-	return 0;
+	struct kfd_ioctl_criu_process_info_args *args = data;
+	int ret = 0;
+
+	mutex_lock(&p->mutex);
+
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
index da70c96e5bb0..914306209c9c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -943,6 +943,8 @@ void *kfd_process_device_translate_handle(struct kfd_process_device *p,
 void kfd_process_device_remove_obj_handle(struct kfd_process_device *pdd,
 					int handle);
 
+bool kfd_has_process_device_data(struct kfd_process *p);
+
 /* PASIDs */
 int kfd_pasid_init(void);
 void kfd_pasid_exit(void);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 21ec8a18cad2..9f2b4d8a5247 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1406,6 +1406,20 @@ static int init_doorbell_bitmap(struct qcm_process_device *qpd,
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


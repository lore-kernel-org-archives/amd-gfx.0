Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F77C4320A
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7926661163
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 19:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7926661163
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D9CC6E0B9;
	Tue, 24 Aug 2021 19:22:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (unknown
 [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D98F6E0B9
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 19:22:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X15Llw069SM/LW/gZRsAqCKppNBOp4SGutTY0PJBFubrD+EOF8xbx+om4G/s9I0A+0/0j2yJmuub6siXw9NjPt1rXWaflBN97mCOLNJktQb5NZAf7OhAjKMSC0Jls0OCJ8Cg9ycVIB/QRktPkgvqoIQNIX5afTTBWsFYSQqoajFVfA6PoaXkL3+Mp9WAaU59LvQPtk16DxAxFZlUE5uvafx0xL6YXaxqX+IbIHuGLpZ1/LqCjf3Rwrv0iY8ZbjyN2V2pe8QeUvjNA2GyZrGZ4XLXPkMImLmm+sQdmnEJcCMVg22GK+I56byWTbIeXMl4L4oCZn4YF0U7IfN9jSDKBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPeDqFuQY0bA8V9hKSUG+LQC/16tTc8IcrZ5t95w/Pc=;
 b=gwBjBcRZtnKX9UjhUC+bfAW+WQIPd7nnZGfE2yr8ysREOrLvY0wtXCvsUk4HXF9hYuE2VrUx7lGTr9VUilAfSblwcfCVliUmmGjHkWzgM2lUcnOHAakjSKV8+VoCr2P0jh6GTZqqx/esONRa/PCu30/zw3DC4o+nWfKeWtKSJA6InsgywFKPYLK5uuy9Jh/wU9D9/QDYnvbjiI5y23Tqfq3fssGQXto9XhKCe3iWA4cbMrB9av9pQGwozQSU1X0B5g99Z7ZUNOI2OJmI9nLua5KF3nTpObnpJZjg8LoHqLk/hBQmsV6+fPnmdI4g+gt9QgbBhIu6vS+dyXLNcLQoaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPeDqFuQY0bA8V9hKSUG+LQC/16tTc8IcrZ5t95w/Pc=;
 b=LtPqxUeMyWD1Yrt2vfYf1U5/zk0xx2/wbeU+N7aesufblZpf0gPOz7GA1H+V4fGiqWpdxITZkM3O4SjOttxyPRgTas2Vlwe59HBUmYwb7YDirfC1f0dLqv0635UM8Spj4rElrXc4K5zIGbBsJ53ZvO2DcZ26YrwFBhXM0D1x+fs=
Received: from DM6PR13CA0005.namprd13.prod.outlook.com (2603:10b6:5:bc::18) by
 DM6PR12MB5566.namprd12.prod.outlook.com (2603:10b6:5:20d::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.16; Tue, 24 Aug 2021 19:07:38 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::3d) by DM6PR13CA0005.outlook.office365.com
 (2603:10b6:5:bc::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.8 via Frontend
 Transport; Tue, 24 Aug 2021 19:07:38 +0000
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
 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 19:07:38 +0000
Received: from dayatsin-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 24 Aug
 2021 14:07:33 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH v2 08/18] drm/amdkfd: CRIU Implement KFD pause ioctl
Date: Tue, 24 Aug 2021 15:06:29 -0400
Message-ID: <20210824190639.6288-9-david.yatsin@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d7de2377-fb10-407f-9367-08d9673270c4
X-MS-TrafficTypeDiagnostic: DM6PR12MB5566:
X-Microsoft-Antispam-PRVS: <DM6PR12MB556622A2EC33D60ED6B61DBE95C59@DM6PR12MB5566.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C5b3ZVne+itP5qfFMtF1JCYJQ/6yeeFSz4H8+vLIGYZRCiw/Da2m3Wsz3mlDNMJZ7tBVqgk8J4bW9JbiFzoUPbWtU1QmgsgkSBVXMvhInVYdBtjzcxR/AJZNpu6ZDRUa1ZjnRJGWT/TAQ0Ec0meswy0t+clNLZxtCqtIwqCp6Ahbkqkpk/XYXVTZaV3mc+iaZDvd8NYEnCmCSVMzXM2cKfE7oRobVsNPod8I38szWbt92WOlw7p5O4MflaLzE298iyB02zIhJAZ4bvej6j9uHTQSshK+Ch8gNSOOWELsircLGPisN3CxHm07xG0j18OZkmKemLE4Wd3WqgIdsEtJIAWP6eFyTUMQ1kj6xU7ypACrmVl/E7myqxCVthF3x/d5/IJ13mfyej2xBRUGJcbx0umJOMfRGDzSo392auY4mLWP67GHK1Lx6qZTLNbysFzpGca1r+cLyRB2alEoylQqChr80uDdl2UpgYOL7ujCx2J3Lax5Cutd3PiY0XCYAuHTpgDvcLx6hPU9C8CauinwHkhnoB7MJo/jCX4PqTsfx/3OHI+gMNEswGvc8tJDeyoG4MawKo5DhAuBCiHYVVFgoBQciJ+9w9b5ZmUg44htdY8VpKQsWEVddRDUPJtEUeCzRvyIajKqLKYXh0KXdaSaH4pIatGKrnowZVWrwIaPYqvH5HMK6JTvvDBF+4LxiK2FqvxE/4t2s0+2AMzx46Z3QZqU/7KhrV/a+A5ggVnbB7Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(36840700001)(46966006)(16526019)(2906002)(6916009)(82310400003)(6666004)(478600001)(186003)(5660300002)(7696005)(54906003)(26005)(47076005)(83380400001)(1076003)(356005)(316002)(4326008)(8936002)(336012)(36756003)(81166007)(82740400003)(70586007)(8676002)(36860700001)(70206006)(86362001)(2616005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 19:07:38.6513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7de2377-fb10-407f-9367-08d9673270c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5566
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

Introducing pause IOCTL. The CRIU amdgpu plugin is needs
to call AMDKFD_IOC_CRIU_PAUSE(pause = 1) before starting dump and
AMDKFD_IOC_CRIU_PAUSE(pause = 0) when dump is complete. This ensures
that the queues are not modified between each CRIU dump ioctl.

Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 23 +++++++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |  1 +
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 7ca56ed02694..821b7663fa5d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1990,6 +1990,14 @@ static int kfd_ioctl_criu_dumper(struct file *filep,
 		goto err_unlock;
 	}
 
+	/* Confirm all process queues are evicted */
+	if (!p->queues_paused) {
+		pr_err("Cannot dump process when queues are not in evicted state\n");
+		/* CRIU plugin did not call AMDKFD_IOC_CRIU_PAUSE before dumping */
+		ret = -EINVAL;
+		goto err_unlock;
+	}
+
 	switch (args->type) {
 	case KFD_CRIU_OBJECT_TYPE_PROCESS:
 		ret = criu_dump_process(p, args);
@@ -2318,9 +2326,20 @@ static int kfd_ioctl_criu_restorer(struct file *filep,
 
 static int kfd_ioctl_criu_pause(struct file *filep, struct kfd_process *p, void *data)
 {
-	pr_debug("Inside %s\n", __func__);
+	int ret;
+	struct kfd_ioctl_criu_pause_args *args = data;
 
-	return 0;
+	if (args->pause)
+		ret = kfd_process_evict_queues(p);
+	else
+		ret = kfd_process_restore_queues(p);
+
+	if (ret)
+		pr_err("Failed to %s queues ret:%d\n", args->pause ? "evict" : "restore", ret);
+	else
+		p->queues_paused = !!(args->pause);
+
+	return ret;
 }
 
 static int kfd_ioctl_criu_resume(struct file *filep,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 719982605587..0b8165729cde 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -857,6 +857,9 @@ struct kfd_process {
 	bool svm_disabled;
 
 	bool xnack_enabled;
+
+	/* Queues are in paused stated because we are in the process of doing a CRIU checkpoint */
+	bool queues_paused;
 };
 
 #define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index bbf21395fb06..e4cb2f778590 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1268,6 +1268,7 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 	process->lead_thread = thread->group_leader;
 	process->n_pdds = 0;
 	process->svm_disabled = false;
+	process->queues_paused = false;
 	INIT_DELAYED_WORK(&process->eviction_work, evict_process_worker);
 	INIT_DELAYED_WORK(&process->restore_work, restore_process_worker);
 	process->last_restore_timestamp = get_jiffies_64();
-- 
2.17.1


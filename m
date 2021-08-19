Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D81C4320A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 322DA610A1
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 13:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 322DA610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33B836E97F;
	Thu, 19 Aug 2021 13:38:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B282A6E979
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 13:38:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQiPcuDPrTgkTuV6TqgEhTKw8Pdip6XLqYju8CHMYATc2JR6YxMrvo3w1uRUZ9IpS4sLB8A/3yut8BXXU2FC5CAF+lZIM4FiCQELQEhmOV13rGOA7F9XpUK9xwO+3i4a0r3h8oOmJHdOyyITyziffGUiyaMeHIcU6FsDAAJTF3CgzygATNUrOf6kop6lw1f9iLSVBmysBV7Iq/cM1SwAOa0dQs59prvelWKmbwrc68XnAxE7AFbUN4B5c6NlggpSjqTQkMdnd+3NI49MG0lFtqcioa3GbrU839E/g33yOd85x36Qwy/aG1daSX/aMPm0dXg3Lj75V7FPX+kRk1+WXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPbjKSzzpFRfQHHQxa9SleTHUYKPnPpz7TchwSr5uK0=;
 b=b5dbuSAB2vGZb56QBQJHGw9+5zahXVhff5kgxt6EF4Gn0jnQNqv8+AuFkGh4whlS36s5z9OXZngAWwEMPU2sMjZV81WdxYoShnnXj8IwL7iuiogQcHyNE7vEyWUxtfafIG2prdK/GZOaNQOCqWIDeiGGnzsJZkzp+Vblm/S61j1lj6UfrkxJZ66OEquoF0VkXn52vfwdCrgoRa6brsJz1Wva77jH/15yAq6H2V28Yj18ksnntDuiyP654FRKKIe3DBtwFmCtrtn3Mzg0N22K20rezk5/ON/A+OPzsd3U6l+qlQHICVrpVKw/KX14PMG7fqFWB5VBO8UwRoWTNdCIFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPbjKSzzpFRfQHHQxa9SleTHUYKPnPpz7TchwSr5uK0=;
 b=V58yGt8zpTTRuRafcIpPLklbXWwwXzRJ+j1XdbwvvIcHRR62iEo6u7oTQ6vgr9euKaGaZOKPls3akUtwIiDujcilRd9fBS1S00Driem9nR6+wxZIXeqm40Pz1xzYS6ofRG5dqCi/S9Diy28BoI78Xcp2POjp+A05OQ1Y3cgkr6Q=
Received: from MW4PR04CA0177.namprd04.prod.outlook.com (2603:10b6:303:85::32)
 by DM6PR12MB3385.namprd12.prod.outlook.com (2603:10b6:5:39::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 13:37:59 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::4c) by MW4PR04CA0177.outlook.office365.com
 (2603:10b6:303:85::32) with Microsoft SMTP Server (version=TLS1_2,
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
 2021 08:37:54 -0500
From: David Yat Sin <david.yatsin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <rajneesh.bhardwaj@amd.com>, David Yat Sin
 <david.yatsin@amd.com>
Subject: [PATCH 15/18] drm/amdkfd: CRIU dump and restore events
Date: Thu, 19 Aug 2021 09:37:10 -0400
Message-ID: <20210819133713.4168-16-david.yatsin@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e47be51d-7b8b-4321-3bcc-08d963168f2f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3385:
X-Microsoft-Antispam-PRVS: <DM6PR12MB338592D87D167763474D05A695C09@DM6PR12MB3385.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:121;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WBPds3mBoGdxw/ZCucDSRcm2LM3cYd7SAgeWVylCH6SWyF9F89ePlUL6tYsQRu1T99BYQbwu42BquR8/CE8vy9z6H6ooKCMpdS6TjRwo+Xk0bxZ23RjdfOKDyEN9PJkt+ihsPJcptKe/h5SfVlcbseaJzPNXVjV1jquDIVHae3bS+2ctuRbpA1Uy+gcpgfxTHtokN1Ac9jC07ZwpCCtCbSXNSGbfTnKosv6R51d+NP+XX+zkV6HfdNqUG4eNjm2P40UTGvmB0LBsMoBLDP2LLbiTUD9snURSreAYiUjYA8b4cWcwPWoULatmly87AvEY+xCnLj24QaPVFeoI26+t8RZv5I6og3u9nR9W7iONrnQwxkEAC1ZIDc3Lpg/uVWmb7KcwV2Z2u9R079zm7GwjPhoCxmGAybdDSdZeuecQIIm5sjYesAUIKMBD37m1yd+DK/IXwwyWTk01V4/zwfj6iyGthdE5RPFsY0rXqnkmN5uRlw1n9oHev76ioV5YgSQRnNL5qHj3stw1mrkIaap3Yu7aWey/NhDwW0qdPHbAc/sgfo+sEbPWERYwaawQw6uFpXJ2jwACDdNK+XDq7IXJtQsQQtZ2u9sn1JlhiEQK6Owe0DM8OAw+9wr10aallL6iYVymUTTlVFoa+syZJfmC7a4suFBH7mc291XT7gPJBiDDa8LMVf7qc5qlkl+C776O5L7jEhtp+GqHnOz9mHwFfgi2MCIvj3uKXjhY4Kg2YXrk5Dmw1esvaaFTSzZGxjsp9msGfGPOsTGkWQwUNZ/wyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(36840700001)(46966006)(8676002)(8936002)(336012)(356005)(6916009)(26005)(34020700004)(2906002)(82310400003)(81166007)(426003)(316002)(86362001)(2616005)(47076005)(82740400003)(83380400001)(30864003)(54906003)(4326008)(5660300002)(36756003)(7696005)(1076003)(16526019)(6666004)(478600001)(186003)(70206006)(70586007)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 13:37:59.0724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e47be51d-7b8b-4321-3bcc-08d963168f2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3385
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

Add support to existing CRIU ioctl's to save and restore events during
criu checkpoint and restore.

Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 130 +++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_events.c  | 253 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  25 ++-
 3 files changed, 329 insertions(+), 79 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 19f16e3dd769..c8f523d8ab81 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1008,51 +1008,11 @@ static int kfd_ioctl_create_event(struct file *filp, struct kfd_process *p,
 	 * through the event_page_offset field.
 	 */
 	if (args->event_page_offset) {
-		struct kfd_dev *kfd;
-		struct kfd_process_device *pdd;
-		void *mem, *kern_addr;
-		uint64_t size;
-
-		if (p->signal_page) {
-			pr_err("Event page is already set\n");
-			return -EINVAL;
-		}
-
-		kfd = kfd_device_by_id(GET_GPU_ID(args->event_page_offset));
-		if (!kfd) {
-			pr_err("Getting device by id failed in %s\n", __func__);
-			return -EINVAL;
-		}
-
 		mutex_lock(&p->mutex);
-		pdd = kfd_bind_process_to_device(kfd, p);
-		if (IS_ERR(pdd)) {
-			err = PTR_ERR(pdd);
-			goto out_unlock;
-		}
-
-		mem = kfd_process_device_translate_handle(pdd,
-				GET_IDR_HANDLE(args->event_page_offset));
-		if (!mem) {
-			pr_err("Can't find BO, offset is 0x%llx\n",
-			       args->event_page_offset);
-			err = -EINVAL;
-			goto out_unlock;
-		}
+		err = kfd_kmap_event_page(p, args->event_page_offset);
 		mutex_unlock(&p->mutex);
-
-		err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(kfd->kgd,
-						mem, &kern_addr, &size);
-		if (err) {
-			pr_err("Failed to map event page to kernel\n");
-			return err;
-		}
-
-		err = kfd_event_page_set(p, kern_addr, size);
-		if (err) {
-			pr_err("Failed to set event page\n");
+		if (err)
 			return err;
-		}
 	}
 
 	err = kfd_event_create(filp, p, args->event_type,
@@ -1061,10 +1021,7 @@ static int kfd_ioctl_create_event(struct file *filp, struct kfd_process *p,
 				&args->event_page_offset,
 				&args->event_slot_index);
 
-	return err;
-
-out_unlock:
-	mutex_unlock(&p->mutex);
+	pr_debug("Created event (id:0x%08x) (%s)\n", args->event_id, __func__);
 	return err;
 }
 
@@ -2208,6 +2165,41 @@ static int criu_dump_queues(struct kfd_process *p, struct kfd_ioctl_criu_dumper_
 	return ret;
 }
 
+static int criu_dump_events(struct kfd_process *p, struct kfd_ioctl_criu_dumper_args *args)
+{
+	struct kfd_criu_event_bucket *ev_buckets;
+	uint32_t num_events;
+	int ret =  0;
+
+	num_events = kfd_get_num_events(p);
+	if (args->num_objects != num_events) {
+		pr_err("Mismatch with number of events (current:%d user:%lld)\n",
+							num_events, args->num_objects);
+
+	}
+
+	if (args->objects_size != args->num_objects *
+				  (sizeof(*ev_buckets) + sizeof(struct kfd_criu_event_priv_data))) {
+		pr_err("Invalid objects size for events\n");
+		return -EINVAL;
+	}
+
+	ev_buckets = kvzalloc(args->objects_size, GFP_KERNEL);
+	if (!ev_buckets)
+		return -ENOMEM;
+
+	ret = kfd_event_dump(p, ev_buckets, args->num_objects);
+	if (!ret) {
+		ret = copy_to_user((void __user *)args->objects, ev_buckets, args->objects_size);
+		if (ret) {
+			pr_err("Failed to copy events information to user\n");
+			ret = -EFAULT;
+		}
+	}
+	kvfree(ev_buckets);
+	return ret;
+}
+
 static int kfd_ioctl_criu_dumper(struct file *filep,
 				struct kfd_process *p, void *data)
 {
@@ -2246,6 +2238,8 @@ static int kfd_ioctl_criu_dumper(struct file *filep,
 		ret = criu_dump_queues(p, args);
 		break;
 	case KFD_CRIU_OBJECT_TYPE_EVENT:
+		ret = criu_dump_events(p, args);
+		break;
 	case KFD_CRIU_OBJECT_TYPE_DEVICE:
 	case KFD_CRIU_OBJECT_TYPE_SVM_RANGE:
 	default:
@@ -2676,6 +2670,40 @@ static int criu_restore_queues(struct kfd_process *p,
 	return ret;
 }
 
+static int criu_restore_events(struct file *filp, struct kfd_process *p,
+			struct kfd_ioctl_criu_restorer_args *args)
+{
+	int ret = 0, i;
+	uint8_t *objects, *private_data;
+	struct kfd_criu_event_bucket *ev_buckets;
+
+	objects = kvzalloc(args->objects_size, GFP_KERNEL);
+	if (!objects)
+		return -ENOMEM;
+
+	ret = copy_from_user(objects, (void __user *)args->objects, args->objects_size);
+	if (ret) {
+		pr_err("Failed to copy event information from user\n");
+		ret = -EFAULT;
+		goto exit;
+	}
+
+	ev_buckets = (struct kfd_criu_event_bucket *) objects;
+	private_data = (void *)(ev_buckets + args->num_objects);
+
+	for (i = 0; i < args->num_objects; i++) {
+		ret = kfd_event_restore(filp, p, &ev_buckets[i], private_data);
+		if (ret) {
+			pr_err("Failed to restore event (%d)\n", ret);
+			goto exit;
+		}
+	}
+
+exit:
+	kvfree(ev_buckets);
+	return ret;
+}
+
 static int kfd_ioctl_criu_restorer(struct file *filep,
 				struct kfd_process *p, void *data)
 {
@@ -2698,6 +2726,8 @@ static int kfd_ioctl_criu_restorer(struct file *filep,
 		ret = criu_restore_queues(p, args);
 		break;
 	case KFD_CRIU_OBJECT_TYPE_EVENT:
+		ret = criu_restore_events(filep, p, args);
+		break;
 	case KFD_CRIU_OBJECT_TYPE_DEVICE:
 	case KFD_CRIU_OBJECT_TYPE_SVM_RANGE:
 	default:
@@ -2799,9 +2829,13 @@ static int kfd_ioctl_criu_process_info(struct file *filep,
 	args->queues_priv_data_size = queues_extra_data_size +
 				(args->total_queues * sizeof(struct kfd_criu_queue_priv_data));
 
-	dev_dbg(kfd_device, "Num of bos:%llu queues:%u\n",
+	args->total_events = kfd_get_num_events(p);
+	args->events_priv_data_size = args->total_events * sizeof(struct kfd_criu_event_priv_data);
+
+	dev_dbg(kfd_device, "Num of bos:%llu queues:%u events:%u\n",
 				args->total_bos,
-				args->total_queues);
+				args->total_queues,
+				args->total_events);
 err_unlock:
 	mutex_unlock(&p->mutex);
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index ba2c2ce0c55a..18362478e351 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -53,9 +53,9 @@ struct kfd_signal_page {
 	uint64_t *kernel_address;
 	uint64_t __user *user_address;
 	bool need_to_free_pages;
+	uint64_t user_handle; /* Needed for CRIU dumped and restore */
 };
 
-
 static uint64_t *page_slots(struct kfd_signal_page *page)
 {
 	return page->kernel_address;
@@ -92,7 +92,8 @@ static struct kfd_signal_page *allocate_signal_page(struct kfd_process *p)
 }
 
 static int allocate_event_notification_slot(struct kfd_process *p,
-					    struct kfd_event *ev)
+					    struct kfd_event *ev,
+					    const int *restore_id)
 {
 	int id;
 
@@ -104,14 +105,19 @@ static int allocate_event_notification_slot(struct kfd_process *p,
 		p->signal_mapped_size = 256*8;
 	}
 
-	/*
-	 * Compatibility with old user mode: Only use signal slots
-	 * user mode has mapped, may be less than
-	 * KFD_SIGNAL_EVENT_LIMIT. This also allows future increase
-	 * of the event limit without breaking user mode.
-	 */
-	id = idr_alloc(&p->event_idr, ev, 0, p->signal_mapped_size / 8,
-		       GFP_KERNEL);
+	if (restore_id) {
+		id = idr_alloc(&p->event_idr, ev, *restore_id, *restore_id + 1,
+				GFP_KERNEL);
+	} else {
+		/*
+		 * Compatibility with old user mode: Only use signal slots
+		 * user mode has mapped, may be less than
+		 * KFD_SIGNAL_EVENT_LIMIT. This also allows future increase
+		 * of the event limit without breaking user mode.
+		 */
+		id = idr_alloc(&p->event_idr, ev, 0, p->signal_mapped_size / 8,
+				GFP_KERNEL);
+	}
 	if (id < 0)
 		return id;
 
@@ -178,9 +184,8 @@ static struct kfd_event *lookup_signaled_event_by_partial_id(
 	return ev;
 }
 
-static int create_signal_event(struct file *devkfd,
-				struct kfd_process *p,
-				struct kfd_event *ev)
+static int create_signal_event(struct file *devkfd, struct kfd_process *p,
+				struct kfd_event *ev, const int *restore_id)
 {
 	int ret;
 
@@ -193,7 +198,7 @@ static int create_signal_event(struct file *devkfd,
 		return -ENOSPC;
 	}
 
-	ret = allocate_event_notification_slot(p, ev);
+	ret = allocate_event_notification_slot(p, ev, restore_id);
 	if (ret) {
 		pr_warn("Signal event wasn't created because out of kernel memory\n");
 		return ret;
@@ -209,16 +214,22 @@ static int create_signal_event(struct file *devkfd,
 	return 0;
 }
 
-static int create_other_event(struct kfd_process *p, struct kfd_event *ev)
+static int create_other_event(struct kfd_process *p, struct kfd_event *ev, const int *restore_id)
 {
-	/* Cast KFD_LAST_NONSIGNAL_EVENT to uint32_t. This allows an
-	 * intentional integer overflow to -1 without a compiler
-	 * warning. idr_alloc treats a negative value as "maximum
-	 * signed integer".
-	 */
-	int id = idr_alloc(&p->event_idr, ev, KFD_FIRST_NONSIGNAL_EVENT_ID,
-			   (uint32_t)KFD_LAST_NONSIGNAL_EVENT_ID + 1,
-			   GFP_KERNEL);
+	int id;
+
+	if (restore_id)
+		id = idr_alloc(&p->event_idr, ev, *restore_id, *restore_id + 1,
+			GFP_KERNEL);
+	else
+		/* Cast KFD_LAST_NONSIGNAL_EVENT to uint32_t. This allows an
+		 * intentional integer overflow to -1 without a compiler
+		 * warning. idr_alloc treats a negative value as "maximum
+		 * signed integer".
+		 */
+		id = idr_alloc(&p->event_idr, ev, KFD_FIRST_NONSIGNAL_EVENT_ID,
+				(uint32_t)KFD_LAST_NONSIGNAL_EVENT_ID + 1,
+				GFP_KERNEL);
 
 	if (id < 0)
 		return id;
@@ -295,8 +306,8 @@ static bool event_can_be_cpu_signaled(const struct kfd_event *ev)
 	return ev->type == KFD_EVENT_TYPE_SIGNAL;
 }
 
-int kfd_event_page_set(struct kfd_process *p, void *kernel_address,
-		       uint64_t size)
+static int kfd_event_page_set(struct kfd_process *p, void *kernel_address,
+		       uint64_t size, uint64_t user_handle)
 {
 	struct kfd_signal_page *page;
 
@@ -315,10 +326,55 @@ int kfd_event_page_set(struct kfd_process *p, void *kernel_address,
 
 	p->signal_page = page;
 	p->signal_mapped_size = size;
-
+	p->signal_page->user_handle = user_handle;
 	return 0;
 }
 
+int kfd_kmap_event_page(struct kfd_process *p, uint64_t event_page_offset)
+{
+	struct kfd_dev *kfd;
+	struct kfd_process_device *pdd;
+	void *mem, *kern_addr;
+	uint64_t size;
+	int err = 0;
+
+	if (p->signal_page) {
+		pr_err("Event page is already set\n");
+		return -EINVAL;
+	}
+
+	kfd = kfd_device_by_id(GET_GPU_ID(event_page_offset));
+	if (!kfd) {
+		pr_err("Getting device by id failed in %s\n", __func__);
+		return -EINVAL;
+	}
+
+	pdd = kfd_bind_process_to_device(kfd, p);
+	if (IS_ERR(pdd))
+		return PTR_ERR(pdd);
+
+	mem = kfd_process_device_translate_handle(pdd,
+			GET_IDR_HANDLE(event_page_offset));
+	if (!mem) {
+		pr_err("Can't find BO, offset is 0x%llx\n", event_page_offset);
+		return -EINVAL;
+	}
+
+	err = amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(kfd->kgd,
+					mem, &kern_addr, &size);
+	if (err) {
+		pr_err("Failed to map event page to kernel\n");
+		return err;
+	}
+
+	err = kfd_event_page_set(p, kern_addr, size, event_page_offset);
+	if (err) {
+		pr_err("Failed to set event page\n");
+		return err;
+	}
+	return err;
+}
+
 int kfd_event_create(struct file *devkfd, struct kfd_process *p,
 		     uint32_t event_type, bool auto_reset, uint32_t node_id,
 		     uint32_t *event_id, uint32_t *event_trigger_data,
@@ -343,14 +399,14 @@ int kfd_event_create(struct file *devkfd, struct kfd_process *p,
 	switch (event_type) {
 	case KFD_EVENT_TYPE_SIGNAL:
 	case KFD_EVENT_TYPE_DEBUG:
-		ret = create_signal_event(devkfd, p, ev);
+		ret = create_signal_event(devkfd, p, ev, NULL);
 		if (!ret) {
 			*event_page_offset = KFD_MMAP_TYPE_EVENTS;
 			*event_slot_index = ev->event_id;
 		}
 		break;
 	default:
-		ret = create_other_event(p, ev);
+		ret = create_other_event(p, ev, NULL);
 		break;
 	}
 
@@ -366,6 +422,147 @@ int kfd_event_create(struct file *devkfd, struct kfd_process *p,
 	return ret;
 }
 
+int kfd_event_restore(struct file *devkfd, struct kfd_process *p,
+		      struct kfd_criu_event_bucket *ev_bucket,
+		      uint8_t *priv_datas)
+{
+	int ret = 0;
+	struct kfd_criu_event_priv_data *ev_priv;
+	struct kfd_event *ev;
+
+	ev_priv = (struct kfd_criu_event_priv_data *)(priv_datas + ev_bucket->priv_data_offset);
+
+	if (ev_priv->user_handle) {
+		ret = kfd_kmap_event_page(p, ev_priv->user_handle);
+		if (ret)
+			return ret;
+	}
+
+	ev = kzalloc(sizeof(*ev), GFP_KERNEL);
+	if (!ev)
+		return -ENOMEM;
+
+	ev->type = ev_priv->type;
+	ev->auto_reset = ev_priv->auto_reset;
+	ev->signaled = ev_priv->signaled;
+
+	init_waitqueue_head(&ev->wq);
+
+	mutex_lock(&p->event_mutex);
+	switch (ev->type) {
+	case KFD_EVENT_TYPE_SIGNAL:
+	case KFD_EVENT_TYPE_DEBUG:
+		ret = create_signal_event(devkfd, p, ev, &ev_priv->event_id);
+		break;
+	case KFD_EVENT_TYPE_MEMORY:
+		memcpy(&ev->memory_exception_data,
+			&ev_priv->memory_exception_data,
+			sizeof(struct kfd_hsa_memory_exception_data));
+
+		ev->memory_exception_data.gpu_id = ev_bucket->gpu_id;
+		ret = create_other_event(p, ev, &ev_priv->event_id);
+		break;
+	case KFD_EVENT_TYPE_HW_EXCEPTION:
+		memcpy(&ev->hw_exception_data,
+			&ev_priv->hw_exception_data,
+			sizeof(struct kfd_hsa_hw_exception_data));
+
+		ev->hw_exception_data.gpu_id = ev_bucket->gpu_id;
+		ret = create_other_event(p, ev, &ev_priv->event_id);
+		break;
+	}
+
+	if (ret)
+		kfree(ev);
+
+	mutex_unlock(&p->event_mutex);
+
+	return ret;
+}
+
+int kfd_event_dump(struct kfd_process *p,
+		   struct kfd_criu_event_bucket *ev_buckets,
+		   uint32_t num_events)
+{
+	struct kfd_event *ev;
+	struct kfd_criu_event_priv_data *ev_privs;
+	uint32_t ev_id;
+	int i = 0;
+
+	/* Private data for first event starts after all ev_buckets */
+	ev_privs = (struct kfd_criu_event_priv_data *)((uint8_t *)ev_buckets +
+						   (num_events * (sizeof(*ev_buckets))));
+
+
+	idr_for_each_entry(&p->event_idr, ev, ev_id) {
+		struct kfd_criu_event_bucket *ev_bucket;
+		struct kfd_criu_event_priv_data *ev_priv;
+
+		if (i >= num_events) {
+			pr_err("Number of events exceeds number allocated\n");
+			return -ENOMEM;
+		}
+
+		ev_bucket = &ev_buckets[i];
+
+		/* Currently, all events have same size of private_data, but the current ioctl's
+		 * and CRIU plugin supports private_data of variable sizes
+		 */
+		ev_priv = &ev_privs[i];
+
+		ev_bucket->priv_data_offset = i * sizeof(*ev_priv);
+		ev_bucket->priv_data_size = sizeof(*ev_priv);
+
+		/* We store the user_handle with the first event */
+		if (i == 0 && p->signal_page)
+			ev_priv->user_handle = p->signal_page->user_handle;
+
+		ev_priv->event_id = ev->event_id;
+		ev_priv->auto_reset = ev->auto_reset;
+		ev_priv->type = ev->type;
+		ev_priv->signaled = ev->signaled;
+
+		/* We store the gpu_id in the bucket section so that the userspace CRIU plugin can
+		 * modify it if needed.
+		 */
+		if (ev_priv->type == KFD_EVENT_TYPE_MEMORY) {
+			memcpy(&ev_priv->memory_exception_data,
+				&ev->memory_exception_data,
+				sizeof(struct kfd_hsa_memory_exception_data));
+
+			ev_bucket->gpu_id = ev_priv->memory_exception_data.gpu_id;
+		} else if (ev_priv->type == KFD_EVENT_TYPE_HW_EXCEPTION) {
+			memcpy(&ev_priv->hw_exception_data,
+				&ev->hw_exception_data,
+				sizeof(struct kfd_hsa_hw_exception_data));
+
+			ev_bucket->gpu_id = ev_priv->hw_exception_data.gpu_id;
+		} else
+			ev_bucket->gpu_id = 0;
+
+		pr_debug("Dumped event[%d] id = 0x%08x auto_reset = %x type = %x signaled = %x\n",
+			  i,
+			  ev_priv->event_id,
+			  ev_priv->auto_reset,
+			  ev_priv->type,
+			  ev_priv->signaled);
+		i++;
+	}
+	return 0;
+}
+
+int kfd_get_num_events(struct kfd_process *p)
+{
+	struct kfd_event *ev;
+	uint32_t id;
+	u32 num_events = 0;
+
+	idr_for_each_entry(&p->event_idr, ev, id)
+		num_events++;
+
+	return num_events++;
+}
+
 /* Assumes that p is current. */
 int kfd_event_destroy(struct kfd_process *p, uint32_t event_id)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 7ed6f831109d..bf10a5305ef7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1069,9 +1069,26 @@ struct kfd_criu_queue_priv_data {
 };
 
 struct kfd_criu_event_priv_data {
-	uint64_t reserved;
+	uint64_t user_handle;
+	uint32_t event_id;
+	uint32_t auto_reset;
+	uint32_t type;
+	uint32_t signaled;
+
+	union {
+		struct kfd_hsa_memory_exception_data memory_exception_data;
+		struct kfd_hsa_hw_exception_data hw_exception_data;
+	};
 };
 
+int kfd_event_restore(struct file *devkfd, struct kfd_process *p,
+		      struct kfd_criu_event_bucket *ev_bucket,
+		      uint8_t *priv_datas);
+
+int kfd_event_dump(struct kfd_process *p,
+		   struct kfd_criu_event_bucket *ev_buckets,
+		   uint32_t num_events);
+
 /* CRIU - End */
 
 /* Queue Context Management */
@@ -1238,12 +1255,14 @@ void kfd_signal_iommu_event(struct kfd_dev *dev,
 void kfd_signal_hw_exception_event(u32 pasid);
 int kfd_set_event(struct kfd_process *p, uint32_t event_id);
 int kfd_reset_event(struct kfd_process *p, uint32_t event_id);
-int kfd_event_page_set(struct kfd_process *p, void *kernel_address,
-		       uint64_t size);
+int kfd_kmap_event_page(struct kfd_process *p, uint64_t event_page_offset);
+
 int kfd_event_create(struct file *devkfd, struct kfd_process *p,
 		     uint32_t event_type, bool auto_reset, uint32_t node_id,
 		     uint32_t *event_id, uint32_t *event_trigger_data,
 		     uint64_t *event_page_offset, uint32_t *event_slot_index);
+
+int kfd_get_num_events(struct kfd_process *p);
 int kfd_event_destroy(struct kfd_process *p, uint32_t event_id);
 
 void kfd_signal_vm_fault_event(struct kfd_dev *dev, u32 pasid,
-- 
2.17.1


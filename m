Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE41C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B7656509A
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7656509A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA1196EC47;
	Fri,  5 Mar 2021 20:11:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B124B6EC47
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 20:11:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihTM1p6ln1+ZHvyrNwRUpkskG0FlqsAU+46mL1n0BrXlnKWWkCt8B3t/9GagnAwzO00NVKyBmQ5s3ayLv9VsrGVfHvQ3UWC4oSW/v/r9SSZ1nzIQ628NKPpXOzZs5nmgHzF9EP+HHRkiDtzVC7f2BmDsM+cKh9rXGV3aDADCbQXwH78He3mMFdVLlUozjwxYq/vkyh/tgDt4drYjV6FdAH9Z0tnfuyvgW0VKrHjZEeiPEcOF4Ftp4zr5DU0WOO+vtqT+TgYSTKcUBD1nc+8dhWN+WyKDkJCz+twyPFac+Wa5mzLq7lhv6oUrEYr29WAQOK9jV1v97dKouRe7JM8DAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qG74Qczd0YK1JJ6k5XLf90ELiEybp8Hh3Akzlz2fbdE=;
 b=WibdCNn1o9JQAQ+eTc39G38kM6lQJ9P9iWIiqngCyTUjSIdbyyTsXCY6aj4U8WkfXTAAkUe0yZwxTAl01jWwRuxbUfK1P8vuJq/RfAoaM71fNB9mc8HWRz5vl3Ie5gDxX18pKNNOVG/J6YP02HRBmUs7SFLQDBEM69FFJNQRULNxEljE+nyVCH3QHABKpFfcriuP0Jxh16gVF61C/rvQMjvHZq7F0W/Pni1wgA1+L676Za+QazOIK2/Kea7NXWEkRjOwepQvbdZH0V/jfhNagqT+j67QXD1Y1AghClVGqi9eM+tAx26+SCF9tuy0XputVuQ2SYv/ed2+WzxYEsqylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qG74Qczd0YK1JJ6k5XLf90ELiEybp8Hh3Akzlz2fbdE=;
 b=jJr3oed7r/09kKpDBWpjD+8ktk35WcmIYBrXvX6C9UeXCvnrHM/bC2H6adc88rBHqGpwK0Bi+mCEfNtIrzEm427oDhJqHRHOQwlMMTFDBZGHI2QbIYUkzg49lN2911mJjIImsl+OqOMBSa83NIlMlrR7dbG8LSXIeyFqO7KhYM0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) by
 DM6PR12MB4530.namprd12.prod.outlook.com (2603:10b6:5:2aa::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Fri, 5 Mar 2021 20:11:35 +0000
Received: from DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::b193:3bb1:c6d8:aeec]) by DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::b193:3bb1:c6d8:aeec%3]) with mapi id 15.20.3890.028; Fri, 5 Mar 2021
 20:11:35 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add ih waiter on process until checkpoint
Date: Fri,  5 Mar 2021 15:11:21 -0500
Message-Id: <20210305201121.55036-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT2PR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::16) To DM5PR12MB4680.namprd12.prod.outlook.com
 (2603:10b6:4:a6::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YT2PR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.25 via Frontend Transport; Fri, 5 Mar 2021 20:11:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5c4845ea-1677-49ad-59da-08d8e012e087
X-MS-TrafficTypeDiagnostic: DM6PR12MB4530:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB45300A6D8A95BA63DBFABDE185969@DM6PR12MB4530.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q0nov7QroZiiEBvPPoSseYUmN8DTAcmFFtL4ix1yptEmOXRvCvZZNSFZJVWDqItdPG13T/rOQHWiHnLd0emUX43joDtFXwT+ErpgMN0Vkbc0bfnyVxF7Q/+YrznK6dP+UIp0x1QqFdtDcPzUGF01JpkWML6H7RKRlsnOAUvZOsUiCGt0iq+f6EG0EgXfs6OeTDT2os6sULWbrwAlt53f3ZGm5JTnxXvmt3v5h9LcvfREwYV35v8d3ql0rwtTmEUf03iLFTvUpNfGPGGR6mADSBWdMm+d21kCHZ12BLL6lmfQxQlo6jzVe2UjI11/dlLBXxpoWeMfmo5p3VoSXuHY0Ih7GU0VwbbEqUmjyTr7+UnJEUwbHT0CJxluSX4viBnFwls+N7Z+7C/V0xMsP5ad/as5ix4u5cs368PAHIpTTf1xM+Bz3vioOFNIt9E5SHiUvtXvVpm+ocFeKaqfvjnE5MdppPF6qnXdfCwNqEiVwitw0JUlKO8CDgMSEYP5/+EKtSivpx3awHITmdyoiVJlDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(8936002)(36756003)(2906002)(956004)(6486002)(2616005)(44832011)(66946007)(5660300002)(86362001)(478600001)(1076003)(66476007)(6666004)(316002)(8676002)(16526019)(7696005)(26005)(186003)(66556008)(52116002)(83380400001)(6916009)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZvSh1xzCvZZ8/pBbcclKu8k7DiKQ5DBxEibeqKgH9jsdMvgR/OB5t++80EDD?=
 =?us-ascii?Q?o4FzZXsEpLMbHf+rrOLSaBdp66TWGkcji4s/SUDJjBTo/bHadH1+8sb42eZO?=
 =?us-ascii?Q?f9tHVyko0FXjSdmPBoC7do9EAaS9QOkkyMEvQj7h0uU0eFyXQtlJNjAbo6mQ?=
 =?us-ascii?Q?V2hlQwcR2Mvgayw1ZoCMf4ZcE7DsR2+akgYYGQExH/MZcknRhC79UClslEIf?=
 =?us-ascii?Q?EZqNfHIVS38Ama6rsjeQBRp9Ggd/NE6X+xU4hSC1sRpiLm7DvYzjIcuquwUB?=
 =?us-ascii?Q?aQJQ8jsIb3jNhYEeiPT+qdzeHalyqvbl3izfBzsDGLgKpYkotROhMgLDlv86?=
 =?us-ascii?Q?ZGZR57Bcdl7zAW9I+ybd33JUmoud3AVb7JnDF9TI0ap64cnKx3F9YT/7+chl?=
 =?us-ascii?Q?e8hSvWw5EnKgKLb1880aYGcVy4IV8BU6uLW6PKP+q1n3fG2/YTtnb88EO08x?=
 =?us-ascii?Q?qa7RamvyBhgDqUpuJ1mJpwUS6/K3M1s7k/JEJWpJEltFvMldVCKpczdrQcqH?=
 =?us-ascii?Q?tMc6U2arKM8bhbKYUnnPZGrtalunQ9po+aItFdjCnxLp3WRsCm3dV0UChah0?=
 =?us-ascii?Q?ygzs+M9Xisa72q6CXcdpn3ykhKh5+49h2rqzpZeGZZ0EfZdg5UPpJCccogB0?=
 =?us-ascii?Q?zBIcz1h943RuGMzQ0vQL8RXjtIlqHFp7DLCCJyEjxusSy5WRkazsGj3PU9DE?=
 =?us-ascii?Q?gvK+Px5sfzhO0el4YEbNalWch6+6tgftYYBuC8qOd/AqQCC3r/vsEmmt7Wgh?=
 =?us-ascii?Q?z0WpX9/AKxtB5A14G50yTCUElaEWnalP3KWshym3ev71wN2imyom/wob5Q+e?=
 =?us-ascii?Q?uN/R69JMlN6XghdlSdO1LUKLJXst8EDRj/jphGYPXp9bEIHlltITKWnl0gYP?=
 =?us-ascii?Q?sWtiODlVydY+4US3fBwB3Vsq4OZlWVzQ5kRDTc8e2Qpqne67bS1fF0LCD2gO?=
 =?us-ascii?Q?6ZF/kfWQ1RshFHOuQQDb8JicdTiWrui5SUhmbdvWaHd16E4ZxEPtNDvmsm/F?=
 =?us-ascii?Q?bnbu/AwHnQrnRTB97L48FoBfbwTWbK9VCJrLXPfeZK0CCxBxur4+qDEbQDUc?=
 =?us-ascii?Q?W0ou0l48CGGjQMJzj8VxmpobIlZb8yLiolpOzzvcHd2/c1BCTIXGTk1NT2LW?=
 =?us-ascii?Q?ak0EG0Efai5cRzbWP8cNiPvCwcoo3RR49ux+LU3vbNpfI7+kLz4l2rE1RWiX?=
 =?us-ascii?Q?uEy91RHmIlU+7OeBUso3HZAltvBQQiewrT1YAQ8k8tc7qonOmIekVQxz7Gus?=
 =?us-ascii?Q?+2sxieDgfI4i3/1CayvunGrzQP4h6z9hFA8n+bcr2XjmpS8WfvPNPbFb3hHQ?=
 =?us-ascii?Q?I7NSrX99hi2vq7DoCRS9pzIC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4845ea-1677-49ad-59da-08d8e012e087
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 20:11:35.7443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: blf4mM62zFVUryq0+BM7HYmJ1EXbl2iHSr8N74IotnxkGgSWB6ev/tIgIK2lWAsL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4530
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
Cc: Philip.Yang@amd.com, Felix.Kuehling@amd.com,
 Jonathan Kim <jonathan.kim@amd.com>, Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add IH function to allow caller to wait until ring entries are processed
until the checkpoint write pointer.

This will be primarily used by HMM to drain pending page fault interrupts
before memory unmap to prevent HMM from handling stale interrupts.

v2: Update title and description to clarify use.
Add rptr/wptr wrap counter checks to guarantee ring entries are processed
until the checkpoint.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 68 +++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h |  2 +
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index dc852af4f3b7..954518b4fb79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -22,7 +22,7 @@
  */
 
 #include <linux/dma-mapping.h>
-
+#include <linux/processor.h>
 #include "amdgpu.h"
 #include "amdgpu_ih.h"
 
@@ -160,6 +160,72 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
 	}
 }
 
+/**
+ * amdgpu_ih_wait_on_checkpoint_process - wait to process IVs up to checkpoint
+ *
+ * @adev: amdgpu_device pointer
+ * @ih: ih ring to process
+ *
+ * Used to ensure ring has processed IVs up to the checkpoint write pointer.
+ */
+int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
+					struct amdgpu_ih_ring *ih)
+{
+	u64 rptr_check, wptr_check, rptr_wrap = 0, wptr_wrap = 0;
+	u32 prev_rptr, prev_wptr;
+
+	if (!ih->enabled || adev->shutdown)
+		return -ENODEV;
+
+	prev_wptr = amdgpu_ih_get_wptr(adev, ih);
+	/* Order wptr with rptr. */
+	rmb();
+	prev_rptr = READ_ONCE(ih->rptr);
+	rptr_check = prev_rptr | (rptr_wrap << 32);
+	wptr_check = prev_wptr | (wptr_wrap << 32);
+
+	spin_begin();
+	while (true) {
+		bool rptr_wrapped = false, wptr_wrapped = false;
+		u32 rptr, wptr;
+
+		spin_cpu_relax();
+
+		/* Update wptr checkpoint/wrap count compare. */
+		wptr = amdgpu_ih_get_wptr(adev, ih);
+		if (wptr < prev_wptr) {
+			wptr_wrap++;
+			wptr_check = wptr | (wptr_wrap << 32);
+			wptr_wrapped = true;
+		}
+		prev_wptr = wptr;
+
+		/* Order wptr with rptr. */
+		rmb();
+
+		/* Update rptr/wrap count compare. */
+		rptr = READ_ONCE(ih->rptr);
+		if (rptr < prev_rptr) {
+			rptr_wrap++;
+			rptr_wrapped = true;
+		}
+		rptr_check = rptr | (rptr_wrap << 32);
+		prev_rptr = rptr;
+
+		/* Wrapping occurred so restart. */
+		if (rptr_wrapped || wptr_wrapped)
+			continue;
+
+		/* Exit on reaching or passing checkpoint. */
+		if (rptr_check >= wptr_check &&
+					rptr >= (wptr_check & ih->ptr_mask))
+			break;
+	}
+	spin_end();
+
+	return 0;
+}
+
 /**
  * amdgpu_ih_process - interrupt handler
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index 6ed4a85fc7c3..6817f0a812d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -87,6 +87,8 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
 void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
 void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
 			  unsigned int num_dw);
+int amdgpu_ih_wait_on_checkpoint_process(struct amdgpu_device *adev,
+					struct amdgpu_ih_ring *ih);
 int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
 void amdgpu_ih_decode_iv_helper(struct amdgpu_device *adev,
 				struct amdgpu_ih_ring *ih,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C919FC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 01:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66C28206D7
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 01:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0YPWNh68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C28206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 118906E0F8;
	Tue, 28 Jul 2020 01:00:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D1636E0F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 01:00:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5308pc71hxDwfvpBPE/a/xkZGu1YGgxAYNv1ZINdMO3rNZHybroShqdvZkj8PfEXM+L1U4QknfaJuVIW8m46cbF0+l/BVL+eCclPJ6qHfykzI0beF/i00Km8xnAb/1+HmjOlBreadYSLAJYrYz0HQzAG9MmlX7cZZf0rrTj6vmfqxMDBH74Yvbej27KmGyuRZvfoOPnHhfN4zJnQBAvBandhK4C/e58FK2wfHUYQCrTYOLHkXp86mTqalQxyKcoMJBiKmGXEF9u0c3GO1DcF8L1+xX/BmtEZfUUd67wq1T8ZiTVQCyTxNJl34RAdx/rPK0gfMyIS0GqJdYqMK37cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOBm27Z1PyCmPSxsoh7uj9b7iAZvCjBblugRg2Cr6UE=;
 b=SOhmTTyTbeX4RGzGp64snbRvUPgU2EW594Jh0vnKk/0/tOgHJt615AH9kNq7z4DOFn04Bxf3ObBOmGOY5+Vq0uETxVtIQPwHnsDX877Y/dgiDdZtQl5tpy4uQaqhrzQkSxhW/GltkItrUVmqVxCpvGaWFZXHPql1RgnTq/HXVuOLPi2z0CUlErXsduj8f9A3eQWlpio/1l6i02cmd8tFKG7IxglQD58TH9cA8TVFOXcPgivecOOkp8g48UIJmJJBzsw5MV/XTn6oP3AvuNw3+htCdj9Blr8As8HSVSoLfTW18GhEN4awhbTl1YhPGvePwvFY7MmFSmFueKbuCGlYfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOBm27Z1PyCmPSxsoh7uj9b7iAZvCjBblugRg2Cr6UE=;
 b=0YPWNh680Xn4Vqr120K3jYK1FyAUQsgpLKEJ1U/ElHjamrEq6DrYRFRqVsoEnrLItvgH/dtChV1m7DCgh/FPl+e5StdDX24mfGNDII4kQ7CgC+/zNtpKBTySZxwAmJXRDk/kFzpS+JdkdPxa7rfvEKCaZ0f+5UtD8Gk+CdEC814=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4272.namprd12.prod.outlook.com (2603:10b6:208:1de::14)
 by MN2PR12MB3759.namprd12.prod.outlook.com (2603:10b6:208:163::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Tue, 28 Jul
 2020 01:00:47 +0000
Received: from MN2PR12MB4272.namprd12.prod.outlook.com
 ([fe80::d0b0:991f:89a3:2a06]) by MN2PR12MB4272.namprd12.prod.outlook.com
 ([fe80::d0b0:991f:89a3:2a06%3]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 01:00:47 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Add GPU reset SMI event
Date: Mon, 27 Jul 2020 21:00:28 -0400
Message-Id: <20200728010028.4752-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::17) To MN2PR12MB4272.namprd12.prod.outlook.com
 (2603:10b6:208:1de::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Ryzen-3700X.amd.com (165.204.55.251) by
 YTXPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.20 via Frontend Transport; Tue, 28 Jul 2020 01:00:46 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c6e50d55-586c-427b-7270-08d83291a96c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3759:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB375934830887E1C7C36E4C24EE730@MN2PR12MB3759.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wy5YP3/vAvTgc3FItGGjAqnRUJ8QPQK4hEHp50TWi0eAJNbxgDjBEWyEVk2jSkDTiZ+F/ylEreHz6nDAhEUC+yaI/8mar7Z25f4MQbOHozmpseFYpxzn+QDMiwRFig0W1fqTC1QLVDD6eUvurKyHlR/nHAIr2sH19ipnVF5Oz8F/eSmLWhdjUY44mbL3x7bA1r7uk9b3iVQX9W7LcVPHKY8nOiN6q20l3u18qjFVQOWtHjYWxqAuej/jzDbC0v2KAOtsgHfwuVnY+Qx1CREEhASKZD8oE3xvGIHX+qoYTlRx+rOjKmJwhJrlVXTnYihOBtQ24u44d23FWDDG/papVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4272.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(83380400001)(66476007)(956004)(66946007)(86362001)(6916009)(2616005)(5660300002)(66556008)(36756003)(2906002)(26005)(186003)(16526019)(7696005)(478600001)(52116002)(1076003)(6666004)(316002)(8936002)(6486002)(4326008)(8676002)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: CRc9sr7bXrtOb0gSh1NhFN5DRf2LHOpYKjrHlCqBw54ePSYyib5Uwe/z52UMqvsGqbIBTWH/h3G1LVR2GhnM0h00JQ+jRl/wnLUlhYzUbbZ40hDr4mW6u8VNcHqVekhYi9yZc+YKVSZ1wzaNsSWyKUjXEN62e8qlN61vYqxowGDFPISU6gABWUV9YFXDPdlD5Cv/+76vH30d+Ny/lihafzzfXLEODS9uGleMWC1UZsevgwnuTPcL4VkvCY16Kxhy3NWTo8FV9hAkQsl2Bf2g1bAAoy61djpvAtphi6DzyjHeGNr9JGLFazeSu+yN/9R3k+QVZpHYao61uXrpsQvdISQqoE+SxBfaZVTQEXkpgDUmlfaix2n+IQ/FT9/MurRunYPeSFs8z1cnqO58V8WpcETHM66bYNghTlJ4679pPby4fgtYQY4BOY4ShOJrq8gRicROOV1zV/YIEMPy1oYm1iz3N7a9sEfUDpY0VeGWnVE2upW97yhfquPuGAlqe7I6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e50d55-586c-427b-7270-08d83291a96c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4272.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 01:00:46.8681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhiqeEBBkR7STxeh4Bx4aWmRzYHA+OziPkECyUVxVWBwGCPqcFjCBqK0pt4dbBA+N58yNaLW1R51BaQwjAOkkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3759
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add support for reporting GPU reset events through SMI.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c     |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  1 +
 include/uapi/linux/kfd_ioctl.h              |  1 +
 4 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index d5e790f046b4..d788aa24ef3f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -811,6 +811,8 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
 	if (!kfd->init_complete)
 		return 0;
 
+	kfd_smi_event_update_gpu_reset(kfd);
+
 	kfd->dqm->ops.pre_reset(kfd->dqm);
 
 	kgd2kfd_suspend(kfd, false);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 4d4b6e3ab697..4de57923d9f5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -174,6 +174,24 @@ static void add_event_to_kfifo(struct kfd_dev *dev, unsigned int smi_event,
 	rcu_read_unlock();
 }
 
+void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev)
+{
+	/*
+	 * GpuReset msg = empty
+	 * 1 byte event + 1 byte space + 1 byte \n + 1 byte \0 = 4
+	 */
+	char fifo_in[4];
+	int len;
+
+	if (list_empty(&dev->smi_clients)) {
+		return;
+	}
+
+	len = snprintf(fifo_in, 4, "%x \n", KFD_SMI_EVENT_GPU_RESET);
+
+	add_event_to_kfifo(dev, KFD_SMI_EVENT_GPU_RESET, fifo_in, len);
+}
+
 void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
 					     uint32_t throttle_bitmask)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index 15537b2cccb5..ffdb822d120b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -27,5 +27,6 @@ int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd);
 void kfd_smi_event_update_vmfault(struct kfd_dev *dev, uint16_t pasid);
 void kfd_smi_event_update_thermal_throttling(struct kfd_dev *dev,
 					     uint32_t throttle_bitmask);
+void kfd_smi_event_update_gpu_reset(struct kfd_dev *dev);
 
 #endif
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index cb1f963a84e0..128b6235b540 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -453,6 +453,7 @@ enum kfd_smi_event {
         KFD_SMI_EVENT_NONE = 0, /* not used */
         KFD_SMI_EVENT_VMFAULT = 1, /* event start counting at 1 */
         KFD_SMI_EVENT_THERMAL_THROTTLE = 2,
+	KFD_SMI_EVENT_GPU_RESET = 3,
 };
 
 #define KFD_SMI_EVENT_MASK_FROM_INDEX(i) (1ULL << ((i) - 1))
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

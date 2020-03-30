Return-Path: <SRS0=xvO7=5P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CA6C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 12:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15C5F20714
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 12:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Xs9FiRJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15C5F20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 909156E26C;
	Mon, 30 Mar 2020 12:14:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E95A6E26C
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2020 12:14:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feg7L2m5AeMgR5r2bAJXgG6rycPXliUB4OsHeE+raSnefQhx9iq2h/L1lIhurf5HypoqVNiT0SOmmhAdg94itduuRhexn6dvYuPcvjinxBTnvxgPGwcp3gp1TUyiN9uSebpVCEdVlWF/kbzey4cAn0AwcgSoCQpxdMUhmeGbtux675PORupSTrhFf9tCI2dTlmVZDaSHFtCHHzql6cu0aIN+s9qGRuIdaD+XPzDKJE8cdKB2Yq074ea2u0qfRbo6qqb/S0b1+sKRs3rYpUQwRTkEflR2frZvQIY4PzutW1dwF1NCIlYTdmVfFGGPYvRaGgC2yd1gsvfK0K3+9tA4kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmqX8vhnQulqmiHZ/Bkt9KhbvwxR1dP68qkcFVkJjkc=;
 b=fDD7Asqp0JfjBWJ076q9hFI6MXBjIrlxVjZ2FgJizNLg5X+4LGLosQgk8s0fRF2l76mplZsQ9u7YyI25A7mvcMAsMIhQviRIhvZPuVChabtnGp9g71wOP7lNy7bsWA08Ili+ykTYTmVcK4qDl5Op1Qqj7bU0kr3HQ/Q8O4yvjy5MylfoYCF6bRuKULf7ySnk6iwLHTSHEJGR04+SL1mUkcCPXhfo0Zfzb+oGzubJxlt6EZSL7Z97ML2eZWo38M5eUpRml0twprSuKdTYTGR/57f4F9ONLQPtuARiSrOxnf/pvwPZ4W3haTmUmZe0Z6XGzHRaXrkxDKxu7jEV6e5J7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmqX8vhnQulqmiHZ/Bkt9KhbvwxR1dP68qkcFVkJjkc=;
 b=Xs9FiRJ5D+Epf1fezTaMb6lT/qB4OdHEASHnN8/gtyXBf84oNCycBXbpNE3itYOrqr4jRStUFzQtE7BzNbVJ3kVcbiHOEtrvzc6gizV1O7h6F9ru3ziXvBsJE5B8lmR42fmE/Mk0vnyTq/kYBId6NgHUCUMrUXKgd9uo8V/pfH0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB2358.namprd12.prod.outlook.com (2603:10b6:4:b3::34) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Mon, 30 Mar 2020 12:14:30 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::bcb9:8228:818:6129]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::bcb9:8228:818:6129%3]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 12:14:30 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/5] drm/amdgpu/vcn: Add firmware share memory support
Date: Mon, 30 Mar 2020 08:13:36 -0400
Message-Id: <1585570418-13894-3-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585570418-13894-1-git-send-email-James.Zhu@amd.com>
References: <1585570418-13894-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTBPR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::15) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTBPR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2856.18 via Frontend Transport; Mon, 30 Mar 2020 12:14:30 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b02d638a-3ca7-4358-21e1-08d7d4a3e63c
X-MS-TrafficTypeDiagnostic: DM5PR12MB2358:|DM5PR12MB2358:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB23588FBE2E691C101893095AE4CB0@DM5PR12MB2358.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(66946007)(81166006)(86362001)(8676002)(81156014)(8936002)(6486002)(2616005)(956004)(478600001)(66556008)(66476007)(52116002)(5660300002)(16526019)(4326008)(7696005)(316002)(2906002)(26005)(6916009)(186003)(36756003);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kH7SmOE4w1vygzWQDbZkAQ81sIqyUosrVafw8b6B4GbLNl6FdPcvNqk1QsaqEj1BAjM7oEpG4RFa6ydhKQqYzBJ2FL0O/YQFMmNdShj0efAYD3V7WMCH+/Fz0mO1If9kMzjECMAhAg25c1JjHd5TV+eEmh2vr6H/8tjqherPwT4n3cCRhWlIV34tD0YtWT1TVL4wSaC5f8WnUXWFXalm/PR7fOJ8/QkFzFFrAYAkMHL2WYTH9nEkN0pzHc8Pi/JEy0yptf6f+gxTqImhpAFQLyhsNaxF9mAfXF4VC/eTSVg21rJBQBlP47Ej6UogreWqh6uFadZGyHIKtmYZYXW/0GHwTVS3MJbI8bt6v47EqTtgVzAxQHrBhbjh8d69sJmyynoilu8Clz0INEUK7PDhVV0BzXEd8PGA1Jg9edvXMEz2W+M0lE/R22rJ+niFNcwL
X-MS-Exchange-AntiSpam-MessageData: yTL3Hs030zBADQd1SU+NbZQLivWeDQn73BwHUnL9K27Ngjtu1hTR0PkntXbc7U1wSzWuCxWjWgZ9auGLp4z016FROh32yK4z4NTEJtYGEhSNXJjU8kTyKbASIiROoAlnDWQOwR865XNygJRYWE5Nww==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b02d638a-3ca7-4358-21e1-08d7d4a3e63c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 12:14:30.6351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9bcBdJtxV4ahNBRUAyNuo9psuJkpddz1q8GZi09sip9eWHHWwlw9yUczthTl57x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2358
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Added firmware share memory support for VCN. Current multiple
queue mode is enabled only.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 24 ++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 7a0b074..328b6ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -182,6 +182,14 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 				return r;
 			}
 		}
+
+		r = amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)),
+				PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM, &adev->vcn.inst[i].fw_shared_bo,
+				&adev->vcn.inst[i].fw_shared_gpu_addr, &adev->vcn.inst[i].fw_shared_cpu_addr);
+		if (r) {
+			dev_err(adev->dev, "VCN %d (%d) failed to allocate fimware shared bo\n", i, r);
+			return r;
+		}
 	}
 
 	return 0;
@@ -196,6 +204,11 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
 		if (adev->vcn.harvest_config & (1 << j))
 			continue;
+
+		amdgpu_bo_free_kernel(&adev->vcn.inst[j].fw_shared_bo,
+					  &adev->vcn.inst[j].fw_shared_gpu_addr,
+					  (void **)&adev->vcn.inst[j].fw_shared_cpu_addr);
+
 		if (adev->vcn.indirect_sram) {
 			amdgpu_bo_free_kernel(&adev->vcn.inst[j].dpg_sram_bo,
 						  &adev->vcn.inst[j].dpg_sram_gpu_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index e913de8..853f0cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -179,11 +179,14 @@ struct amdgpu_vcn_inst {
 	struct amdgpu_irq_src	irq;
 	struct amdgpu_vcn_reg	external;
 	struct amdgpu_bo	*dpg_sram_bo;
+	struct amdgpu_bo	*fw_shared_bo;
 	struct dpg_pause_state	pause_state;
 	void			*dpg_sram_cpu_addr;
 	uint64_t		dpg_sram_gpu_addr;
 	uint32_t		*dpg_sram_curr_addr;
 	atomic_t		dpg_enc_submission_cnt;
+	void			*fw_shared_cpu_addr;
+	uint64_t		fw_shared_gpu_addr;
 };
 
 struct amdgpu_vcn {
@@ -209,6 +212,27 @@ struct amdgpu_vcn {
 		int inst_idx, struct dpg_pause_state *new_state);
 };
 
+#define AMDGPU_VCN_MULTI_QUEUE_FLAG        (1 << 8)
+
+enum fw_queue_mode {
+	fw_queue_ring_reset = 1,
+	fw_queue_dpg_hold_off = 2,
+};
+
+struct amdgpu_fw_shared_multi_queue {
+	uint8_t decode_queue_mode;
+	uint8_t encode_generalpurpose_queue_mode;
+	uint8_t encode_lowlatency_queue_mode;
+	uint8_t encode_realtime_queue_mode;
+	uint8_t padding[4];
+};
+
+struct amdgpu_fw_shared {
+	uint32_t present_flag_0;
+	uint8_t pad[53];
+	struct amdgpu_fw_shared_multi_queue multi_queue;
+} __attribute__((__packed__));
+
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
 int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
 int amdgpu_vcn_suspend(struct amdgpu_device *adev);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

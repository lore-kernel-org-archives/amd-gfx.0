Return-Path: <SRS0=Rejl=EY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95128C6369E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 16:24:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE65246B2
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 16:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iIaHPHUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE65246B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2D6E6E44D;
	Wed, 18 Nov 2020 16:24:12 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 811E46E44D
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2020 16:24:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxbQn6FOtXAX6fEg3dmRaly7L5UIQJ1Nt2afJ9roqJyV2/zX053w5z6lhBehTPvaAY6NvwDNj6emLsK0U/MruNBtl211KdOWcT3AsPcPTg8B2WWb8iZ/pyighnv37868275Ct4Pl2ZGM/2Et27uAsK3F7gAhupat41vxR/mRDxQJDp6UYbPIL1BUZ7i0J0eql4T75dkvOf6O0d/f11Td/Ymp48Y8cKWBZnyaS/Oyxx0+Wf7G7DpeFmkouT5FIL/AHfWXsdXFCr6DPAEErWPxYsN7JRwd4yIS3kP67P2cjFh3YEjduhaP2wHOhoW+w3dk2Rb/MqTmKZOWqBEtNR7L1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vurWr3buz9HUoSpqoiR1434YlWA7r1m0pRO0CLNlJRI=;
 b=XHJlMUM1sU/uAOr03Dywv4YZnFrmEjJx6+7thqgf48mffUKaloTKzEZaSuoMd9jgu9MRrvxvEW52Z7NdpFnzu+QNwFtXX9D4VvIJcdJvk2/2J8DGvFCfUzi1tMzl0kOe2h/O2KCM2XAzN98dqvXEjkTcfJVWHQd69ahLmT8AcmPEo6Xh6pLGTNz2cleIcL53R/USMrbzFEBqjukEVw80Ikp5KuLfdgtgX889Hwhyr7jcEGXf4QNrY0ooJfcQU1iJI8nqhHthVPuBxacuaTCVYmwh4TcAnyfHD+99H0YZw7s7MQm61x7gRzLielvEUYAMfRvuyuSoSA2cF+Xoi4cn2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vurWr3buz9HUoSpqoiR1434YlWA7r1m0pRO0CLNlJRI=;
 b=iIaHPHUs6IxJCGDkO01WXsvyGyu7HUU2H0JXvSel9cYig+cYKSYKcNSlqN9hZ4KqEDKxQYoBxGC/VIT1ptRCXsTkF7J+VGBddNAlKleH/w4IIVAD4pRPz1b/aihocEYYYE9z8MbLrXiv2JR1Kvas3tS5Tkh0gcXPsgSCk9xC2ss=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Wed, 18 Nov 2020 16:24:10 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a%7]) with mapi id 15.20.3564.026; Wed, 18 Nov 2020
 16:24:10 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 2/5] drm/amdgpu/vcn: update header to support dec vcn
 software ring
Date: Wed, 18 Nov 2020 11:23:58 -0500
Message-Id: <1605716641-22176-3-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605716641-22176-1-git-send-email-James.Zhu@amd.com>
References: <1605716641-22176-1-git-send-email-James.Zhu@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: CH2PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:610:4c::38) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 CH2PR10CA0028.namprd10.prod.outlook.com (2603:10b6:610:4c::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3589.20 via Frontend Transport; Wed, 18 Nov 2020 16:24:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be145edb-5d07-4446-b681-08d88bde6103
X-MS-TrafficTypeDiagnostic: DM6PR12MB4314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43143B2F64A3368FE879A59DE4E10@DM6PR12MB4314.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FDLxI/5fD3Q2sHWQuQ7zTlUfCLUyNm44Sw+GjEPvlNwuP5e0neNK5YXshVZ2H9ktjdZTRZPiRstEPzezJiELZGnwJ8aPR7uyEhUUhqNdrVexJ3+gfaaJox9mxE4lbrIKzPJMq1n+yGGsN2oBervNEBzRvuGrn8PwXXu9GTWy0+liswIb+pZE7lcpnpFoi9o4ZuwV887Dv1k3IKKN53lKYH+Q11BlbAeM8vNljGlopVCCLpN4Pcn5+HVW9aTjUdHDb/wZt0lntzXi/27nXsNzqEcLIrXSTVzQox6k7PQhlvmAzNLgh7ANWb+qHUSvFUhWFC3qLPzvSpcwVKuJ0pO65A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(6666004)(478600001)(36756003)(6486002)(26005)(16526019)(52116002)(83380400001)(86362001)(186003)(316002)(7696005)(2906002)(2616005)(4326008)(956004)(8676002)(66476007)(66946007)(66556008)(8936002)(5660300002)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 2ZUoArHYu4Rzv9yokINnIq1L+GdB+ZpL6cPb2JxrBDi8+ElBIWAvjUDXssyRPFzY0cGrDKCLwV/ECZEBaLJsj27DHv2MGBWAcxQQ2z1bu+8rqtRLXJixiGNYcqjrgUcbMmvH0PwR5zhrpwF7ihibz3XtX0v9m+QNP1WBsg9OErzYlFZfjoOeNacpYI/13oS5cZtFRYugGx9nuUR99v6cfP1dyqrse3SGXUdNRkpV2NRtKG5mlkrgZaKywq7hu1/TZGV2WXqQfAhkjqXEsho/8DQ55lpUoLYOxw/geFz1/jNZSvrig+9VZ+wF0S7AdwQLup2dIYn4K3RGr/uJLMALVyZUCjrjgKf/yV8EIJR8+YXwmYSprw23ijUZARhnqP5k0VHjXlRAnEZ5q5NszXFREVWXzluY0RAcMUGGIs0fGDADmUkcM8uQOeEZh4VnTuSsAqqD/XKXj8i1WovE1vPWeKg8L69/jX75kkUcGKpPfAF9Kk0hI4c38ni65PEewYWF6eeAiVW6fqjgbsE0Fx+mPC36A6xHIMVUm1ar0HJryTF6dtS9Ngvov3COr2Iu74DMvu/SsXrh6BbLLU0buaF+A4yYxXVSMdD8b9shCqBn9/hpZkbqnXwxYiYXDwbtoMbHkKu/Osqaq0ojUrIqCFtsWYbjBKuMAiufDP4yrpM6Q+zGCuqfyCjRpBbNDUva9o5Xr6mltpewos08KeOrKVWdodupcdrmn5Qm23LpC6rnZ5oaZ2DLri/hl8vILK5yU27Hdrv8eMgDBP1Tqd/D0ZW0AylSsEG4TIkreBD2A1nuDnsCEFAf06g66jS6FD5a16SEp3WEdzFCTScsJ567FPzTx5u1xo4sawRWY3pWQKuHcP56shpc+SyLbbwmTwmED+YeFoyv6rRzwKbOcLcEQj1RDg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be145edb-5d07-4446-b681-08d88bde6103
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 16:24:10.4056 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nGNdFy1XaUVGBadfVPzvzwZyHF+XM5a4CXxC3sRxNF2fC2pKD8cWIB9m2KWV/cc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314
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

Add macro, structure and function prototype to
support dec vcn software ring.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 1769115..13aa417 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -44,6 +44,17 @@
 #define VCN_DEC_CMD_PACKET_START	0x0000000a
 #define VCN_DEC_CMD_PACKET_END		0x0000000b
 
+#define VCN_DEC_SW_CMD_NO_OP		0x00000000
+#define VCN_DEC_SW_CMD_END		0x00000001
+#define VCN_DEC_SW_CMD_IB		0x00000002
+#define VCN_DEC_SW_CMD_FENCE		0x00000003
+#define VCN_DEC_SW_CMD_TRAP		0x00000004
+#define VCN_DEC_SW_CMD_IB_AUTO		0x00000005
+#define VCN_DEC_SW_CMD_SEMAPHORE	0x00000006
+#define VCN_DEC_SW_CMD_PREEMPT_FENCE	0x00000009
+#define VCN_DEC_SW_CMD_REG_WRITE	0x0000000b
+#define VCN_DEC_SW_CMD_REG_WAIT		0x0000000c
+
 #define VCN_ENC_CMD_NO_OP		0x00000000
 #define VCN_ENC_CMD_END 		0x00000001
 #define VCN_ENC_CMD_IB			0x00000002
@@ -145,6 +156,10 @@
 	} while (0)
 
 #define AMDGPU_VCN_MULTI_QUEUE_FLAG	(1 << 8)
+#define AMDGPU_VCN_SW_RING_FLAG		(1 << 9)
+
+#define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER	0x00000001
+#define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER		0x00000001
 
 enum fw_queue_mode {
 	FW_QUEUE_RING_RESET = 1,
@@ -236,12 +251,25 @@ struct amdgpu_fw_shared_multi_queue {
 	uint8_t padding[4];
 };
 
+struct amdgpu_fw_shared_sw_ring {
+	uint8_t is_enabled;
+	uint8_t padding[3];
+};
+
 struct amdgpu_fw_shared {
 	uint32_t present_flag_0;
 	uint8_t pad[53];
 	struct amdgpu_fw_shared_multi_queue multi_queue;
+	struct amdgpu_fw_shared_sw_ring sw_ring;
 } __attribute__((__packed__));
 
+struct amdgpu_vcn_decode_buffer {
+	uint32_t valid_buf_flag;
+	uint32_t msg_buffer_address_hi;
+	uint32_t msg_buffer_address_lo;
+	uint32_t pad[30];
+};
+
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
 int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
 int amdgpu_vcn_suspend(struct amdgpu_device *adev);
@@ -251,6 +279,8 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
 
 int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring);
 int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout);
+int amdgpu_vcn_dec_sw_ring_test_ring(struct amdgpu_ring *ring);
+int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout);
 
 int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring);
 int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

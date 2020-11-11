Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F624C56201
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 22:28:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F2FE208FE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 22:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AsLS/Oyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2FE208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D34F6E0C5;
	Wed, 11 Nov 2020 22:28:05 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AB616E0AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 22:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXQSlRN8U7Scgj0id0zhkqIQhKkQlIPNn4AH56dME4L1iqT3CqX07EIQ73c0UJqWi26kHfoLZOSFrlvuKO4KI3YjkmDjemdjFO7k2sejWrDXna7w89J9y8sMkQEZly1ywUh86NpneD1b9IT2dTs7YM45KZjWYyVDnK4VKuSbRiBLPRBiwbuj1+sEZvSdsre0UTiiIW+zw3XVbfAw+ElVSI7lUU/JBl4mh4HJy4vj5H41hpaEK43DjUaAZtqhCYzbfQ/mFP6LMNGdHOyh7SJm8y+EBNY/+AP4fW/NV/AkbeVJCPY++2bqzoKiNZG/cdWC+M2jOqnUZierFFP7LSQ8yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vurWr3buz9HUoSpqoiR1434YlWA7r1m0pRO0CLNlJRI=;
 b=iBHouqDe2manD4+eVvsNf+sj8dlo6XMWETCuhhXCkx8hLiFctSdd0E1hMBw7VqYZJ+qKKh4Fcdw8O9adTp733osMMWpHg1LFAI1Ux6qR5dwBGXyzBp4OtWlqOM1PD+9xD0+wjkkjDtwR1qexjiV3xQs9dPuIUqMGQtgUVVmWWvjMIQ05SzX8xIp9fg1ZXzOzbbOmeSn166BxcCBGzPIPI/RY7+wgu2O1RdSNqZVF78PHeW2RlNsb12t5zgImSgj4KF2N3sHy9wsuLo98tMWOMIqhmGaBCpM5kfbjsShOhvpugm7n7n78o570ufJywt/chDfT5VR5E04pEafrsldzKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vurWr3buz9HUoSpqoiR1434YlWA7r1m0pRO0CLNlJRI=;
 b=AsLS/Oyb33PWgu87kzMUId9uV8oiNxexpFXrELmpsXj+v84DUoIdWHSt6+7k9OltTM6eY89EUpQJlKCVosHWJc5yHIeVcNf17d22m6/OkBd2Yj+B7LINxCY+f9jh/N9ESTqtq+zDsqrnbVICJXsUVOUqHpBzoaDStaniY5OC3i4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB2746.namprd12.prod.outlook.com (2603:10b6:5:41::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Wed, 11 Nov 2020 22:28:02 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a%7]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 22:28:02 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amdgpu/vcn: update header to support dec vcn software
 ring
Date: Wed, 11 Nov 2020 17:27:51 -0500
Message-Id: <1605133674-21093-2-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605133674-21093-1-git-send-email-James.Zhu@amd.com>
References: <1605133674-21093-1-git-send-email-James.Zhu@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::17) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTXPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3541.21 via Frontend
 Transport; Wed, 11 Nov 2020 22:28:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 30c3d686-3285-4ca0-8475-08d886910cf7
X-MS-TrafficTypeDiagnostic: DM6PR12MB2746:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2746CB219E945B9DE7912DA2E4E80@DM6PR12MB2746.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPaE5wF5NaEYUWaYkI6C/XVmogiizHTkgI4uedGr9ShIFLUbTslF07nRv83etWl3LLepwqBD3gVnJY5LeTG87fKseLUGJmtvZV/vWJNjuqSscA5qpwptCFkMqiUSBoVXOol1v+pMZ2l1BwHNmBYj0fsN0zb3VogQj1KrvIwyj/WwVHhI5WutspH9dIFex9WcCxorsJs2YqpsPekE4JaJaC0ra+7NG3Bd+Y1O4JjD4Fs54dLHqTQaAo29ptcLPgw9bIZj20HfOkqKsH4y7E6FQWUhVTQynM0gyF6kwFp5wNAzBSRIb/7J27pvAaMtfAJWscwC8OfCzSlrm+zDadZgEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(66476007)(66946007)(8676002)(6666004)(8936002)(2906002)(316002)(83380400001)(52116002)(478600001)(86362001)(6486002)(26005)(7696005)(66556008)(2616005)(186003)(956004)(6916009)(16526019)(36756003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: aTYst9sLMlM2gN4emM3evvZmattHW14T3EoPFOm/JeB7PzvzEgc0Jty6R7m7YUg8MXtoOoqvb7ek/paP1XGdtcc9Tp9ZMjR/1cnz7P22+lTa/ACT+2ZH5q4XPOXV2SAJzwwuU75vi0kfhj9HNr/bSOukD3a82+ghqwJIwZVVsRVrxOz3fPV5KRHVNroFYT6Xjxh0K5SSfrm9rTiLPsccHrb+73nowBP7C2PAGVDLELTp/Hq+3Zb0crUsuEkut/XWi8cdmMq5M3bpHHsYPgjf41oql9cel7CmN9i20gPv5hJYFvbvKFZ/QfI2qXwVFor3T/+7pBwQjxplSRLPl56QmDInpgegezsGICVhfGJGrlDAbthzv3uQhCEtGvCmcLHOC3uNWPxAocl0JxYy0JijfWGRjTXxicdjj4IG5nF+20ACrch+Hwz044FhgqCjtVcjqY7Hhb6221iJ0RZdzOote0L5qE7Vfl9fViwl9vQSuKGEB+gkbKT/ZFKvFFcoV+3ZGdvvry6MPo51uuDifU060KDsUltmGm14KkZhwKwPMNZiEhkxI/+t0w7wH9ZMSaYZP/yi6jXF91FYcr2D9Z3LdE66Oy2sGZXOZ5qGSunXEKWu7DrybzG7gI6SqgndlzEhCzslX+gJrPOSD5DDk/s5vQ8ELgv3o+QgzF10W8gdzhnQTw5fRQ+wlme9xEzJqNJy8rsNofm15FQTj5s9kBwfq/hLH6aobp4axChqNeQQ1Gjs7G5z73ESr6Q9WIzg7+w1gjKaBa1L2Avn/B1TIrbuBbUHLMZ0UeLP+77By9S0mty9PJ4eDex3NDBMqwSlWRgvcc5yYw14RowkG9FyKiHJH34CsqF7XNcu8RDp7YkOOx8H4ehk2tpvhYjzm0h9EhKGdLD/c9GaOwkAv0mdXITmqA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c3d686-3285-4ca0-8475-08d886910cf7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 22:28:02.1051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SbfQqXg6iPKXmmxawuA475WC98EZnUPoOliJ6H7ey4goo1OK8l557fKKbhelDbCG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2746
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

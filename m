Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E8DC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 16:21:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6306664F0F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 16:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6306664F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBC026E11C;
	Wed, 17 Mar 2021 16:21:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1971B6E11C
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 16:21:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXaNyqEzc9Ja+jaAmcMRQxrEQD4ZiodwLNQwSlKjJLSGF0POonfEHG6cCUmeh9WOU5wEXCEKuVRWKWl1PERqOaDpXDo/4DIeeqrusIH1QzWxUn42b+LJfLgoLELOvPISXYc2PDwUCk1bxk3a4Qx4O/ZqnVk9M/UKMy9DBAgjhLdCV4WdW8yWcg7MfDq4QaYAl/7Y0jC/hfDMEim1U620uGlIdU9e6YfqUNiT23noSj93woq/pAyDHmGYEOVbZHLHQ/zkLsAi5xXeR531pjPzWzgbUQrBGviCd5XSISqQYqOn5asfpm7U0H+re0+TPTk0E415RZDSPSEjP1XJ9akEhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wooL4EB63obQhG4ovVB2W7gv/6DIRrP96V5TedmBMIs=;
 b=bkCYyYSGswARTOP+yOKq4I2k1CdqLKMWSDMJDhpzsge8GYRvz26ScVgKOsx3L3wSEbzjNx6doh39hF6fSzYOVccrGu/ii+gxsudjuQo8ezBj2MWUVCybKSPLu7UyyOX8jrajEQezv7GezSNk44nFRrJZaLMzmldkzApDfXXZsMCNpwUc4BUCHYfonxk6+TE9xg73DQ11VoDXP/6oFJoV8EBIGX4BKvScBmfGscf21IkwD3ZHxrNrqDPMG37DvD9k1eBgV6xT4rR86R9JJyIBJYUHnCQSbVx2bLmQCZj0E1xlvgo1Dkq6UnP9H3zaXWWOVuiWeoBFVmNZL/KGhuXYRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wooL4EB63obQhG4ovVB2W7gv/6DIRrP96V5TedmBMIs=;
 b=of+rQXUSv4kjFeDYHjrlNkT1+w/+4+8A0N9F95VqSGHfEb+yzDRgFh/c4pngTwUPiyo5b/yjx0eNKJQzjt6P6N8IBvaQJzdpQ345/UhGOP8xBh0gtMaHf8wwkqkFfulqzr5sBu93d81kNky7Mz5W0Ex2wRuoK+WMwuKSzBWBxRM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB3402.namprd12.prod.outlook.com (2603:10b6:5:3b::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Wed, 17 Mar 2021 16:21:17 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%7]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 16:21:17 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Add irq register entry for dmub
Date: Wed, 17 Mar 2021 12:21:05 -0400
Message-Id: <20210317162105.845084-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [2607:fea8:56e0:6d60:2066:87be:b836:35e]
X-ClientProxiedBy: MN2PR11CA0014.namprd11.prod.outlook.com
 (2603:10b6:208:23b::19) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:2066:87be:b836:35e)
 by MN2PR11CA0014.namprd11.prod.outlook.com (2603:10b6:208:23b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Wed, 17 Mar 2021 16:21:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e33f6c68-2df6-4eef-fafd-08d8e960b10b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB34028930343FF743BBAE4C75986A9@DM6PR12MB3402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:161;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v5LHpp1dlI4vaxR2JVdpVRsRzUJ4RKxwT/86Dp3yqNXsbp+vN41hSMCinE0m7ZnbR1sNBws/iTnV7Rmc4YnL2JKDtDASt0je2FZtASX3wV8rYHkGbJDdtTFd3JvZrejssBusQNTmEJG6w3HD5jg99oiQCC4o2wiSB0E9TPwohUrrs7i+J+jq6RJH/49bIR/jjkAQpHAza0FoVfdnV2ce9vE7iiPYbgopCqe12GU15a3RQReg4fGLiIXiPM5GYk5/W7CssRDINlvkSu9g4vhD2Z9enAl7CqlbVeB3cZO+7uqWe2yHMh/VO6ZCsUpo1Ho6bjkZ0rm7imSqV7Zl6zZz0QkVoo5/A0HMVB81EFBADHHBOXxlgVPcbjbKMELxTb+zGu2+2sxOsPvdha76j8Ami6x0PpTYqHVB/E8uzXfPdmBC9vLqqKACXJaqgDk0Z3kP8bOQ7R2RljHsMOMTF/kwKSrtpnYSov8DMrT4Vbn+IVjTHuY+ZezTZbSW4SEWd0meQHqIccqiI3PptmDDOdEzeEREHk3T/XN3wKVOTinxTUqn6v3WXqJqeobp/X9aWLJH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(36756003)(4326008)(316002)(110136005)(54906003)(86362001)(1076003)(8936002)(6512007)(2616005)(66946007)(66556008)(5660300002)(52116002)(8676002)(66476007)(6486002)(6666004)(6506007)(83380400001)(2906002)(16526019)(186003)(6636002)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?s+oD92RxExEva/kAFwB02yYwzrziZTSnsntDldUjz0kyog+G10FgVJxas83L?=
 =?us-ascii?Q?Q08yerG6pz10+S0vXvfyrbTDJ1CJj/ePo//+2hgSWljj0hXP/3ncAl0vIcWH?=
 =?us-ascii?Q?D6ClSUEpJl7awJs1SM9UGxfgdTq/ja/dMH1mIU9/tW/iyOQl2CzAcZf5+jMS?=
 =?us-ascii?Q?PsrYYJiIIx6uyvzGJipTt7szueXRp07bD79nMgmy4vj+H8eiRH0NYZVwcb21?=
 =?us-ascii?Q?vL3bEEs780Hw68fJhSCv/rNAyRu4XjBIJQS9+nqWX9wXkm93/q+ZUAMASzzo?=
 =?us-ascii?Q?J2dw8rI4oP88KQcNmH685CSBDAki6jJHEuyf0KR3QxhEBoHpzPTk+FSb5N7d?=
 =?us-ascii?Q?B6XpDoyg9oXzzKtT/TVcp1EQlwQgj9y44webfeV29UlHgKT9rnS4WY9S9U9w?=
 =?us-ascii?Q?7j6hEMSV/HD9doVajlWuLUHQVICuG8h6GXWTRqMWwQy7yOOPVaCcEhkmbPHU?=
 =?us-ascii?Q?WNQaUr1fzZ6KpZwPy7TGV57e+9SLbe6W6xuTYVn+myVGAr6qGpnnTi5hgENm?=
 =?us-ascii?Q?IM9XWYZJE/1Ie+p3U1kehN8vsLGgr6Srkewk5ZOWm3ME6HZQVYFLrD5rtuPI?=
 =?us-ascii?Q?jVSNeamAFgSbdBgP4NlnW/A8gAEDsMeP/sObzxItbI1/8JjMNGLRgm813IHF?=
 =?us-ascii?Q?zH4CgTAHVdutIM8DvuK+oFmfjatfim7QGl0IzwDzSa7JbIhfw8BcFZQyltsS?=
 =?us-ascii?Q?/OwsKPIAmB6vlfQ5kVRY0pYN8EDWUHDhZUbLvfYegJqSvayP/d1XgwuH0smJ?=
 =?us-ascii?Q?s4Y5V73EiPGiMZG/d71UIpXtjWfIa1SOlpbwcaiDBcwMHFdLz1Q9fGkwyBDU?=
 =?us-ascii?Q?Vv77Qm/e7zUHQ1KLSHuM5CBuUVFBL0DpuKtZnUJiPqQDl+8loeke46QtwEu+?=
 =?us-ascii?Q?lckZAMWTOrkRuEolHuWE5yWXB1Ov/HKCE1Q6B+WQMUJY4Lqn35mPldnt1q4X?=
 =?us-ascii?Q?9GQ2CXyCE6DFGJj1OaqzEhNiSC8MyhrslBh/Dpq9zUxgfSUge6xxqaN+JCl1?=
 =?us-ascii?Q?lOcS5EriLYvjwuAi1GMcI7sh9KW/l0x1ChjmZyff805HG6GUCHK99DDM62YJ?=
 =?us-ascii?Q?xme/5K6+9/P1Q1OAC3I3FB6h/FVg0/39tgZRxH1KmdbN6Iy89ddwMg/KJIDN?=
 =?us-ascii?Q?9euU8HzCeLkPgZDyU9TBDGq/Gp40F/S2KEunWH9SOqnNCZFSberu7WVyTdZX?=
 =?us-ascii?Q?nnwBftDTSAzIaZp938nQoqvFquDLzMaFNraBYoJqh9b88KZKhY/YCzRYe6au?=
 =?us-ascii?Q?Hw34haa19blcphHCrcEVUXLiUTPIiwDySCbtpM5w3sqXZPeElNg7rIM/C7RM?=
 =?us-ascii?Q?Cdq2KD1eYLKQVuBqD8tL+1PwSEJKrSG73+h9V8hF7+rLvIYfx19QZlNa/ufB?=
 =?us-ascii?Q?DAy4BaVJrQ7RyfK70y1dLvHqGXjN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e33f6c68-2df6-4eef-fafd-08d8e960b10b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 16:21:17.0409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JlNoYRNRvuO4HvlmwiSQQ6jKvTZgk/47DOQ+UmTxwtwmbFcDCBJujio0LzN2jeovQdnhiHpheWFDJ/j8vSQaoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3402
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
Cc: Solomon Chiu <solomon.chiu@amd.com>, amd-gfx@lists.freedesktop.org,
 Wayne Lin <Wayne.Lin@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DCN2.1 and DCN3.0 are missing some macros that register irq entries
which cause compilation errors. This commit introduces those macros and
fix the compilation error.

Cc: Wayne Lin <Wayne.Lin@amd.com>
Cc: Solomon Chiu <solomon.chiu@amd.com>
Fixes: 53e9c0f651421136 ("drm/amd/display: Support vertical interrupt 0 for all dcn ASIC")
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../display/dc/irq/dcn21/irq_service_dcn21.c   | 17 +++++++++++++++++
 .../display/dc/irq/dcn30/irq_service_dcn30.c   | 18 ++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
index 48a3c360174e..bc1249a9858c 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
@@ -209,6 +209,23 @@ static const struct irq_source_info_funcs vline0_irq_info_funcs = {
 	BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
 			mm ## block ## id ## _ ## reg_name
 
+#define SRI_DMUB(reg_name)\
+	BASE(mm ## reg_name ## _BASE_IDX) + \
+			mm ## reg_name
+
+#define IRQ_REG_ENTRY_DMUB(reg1, mask1, reg2, mask2)\
+	.enable_reg = SRI_DMUB(reg1),\
+	.enable_mask = \
+		reg1 ## __ ## mask1 ## _MASK,\
+	.enable_value = {\
+		reg1 ## __ ## mask1 ## _MASK,\
+		~reg1 ## __ ## mask1 ## _MASK \
+	},\
+	.ack_reg = SRI_DMUB(reg2),\
+	.ack_mask = \
+		reg2 ## __ ## mask2 ## _MASK,\
+	.ack_value = \
+		reg2 ## __ ## mask2 ## _MASK \
 
 #define IRQ_REG_ENTRY(block, reg_num, reg1, mask1, reg2, mask2)\
 	.enable_reg = SRI(reg1, block, reg_num),\
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
index 68f8f554c925..5af52ad49d7c 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
@@ -276,6 +276,24 @@ static const struct irq_source_info_funcs vline0_irq_info_funcs = {
 		.funcs = &vblank_irq_info_funcs\
 	}
 
+#define SRI_DMUB(reg_name)\
+	BASE(mm ## reg_name ## _BASE_IDX) + \
+			mm ## reg_name
+
+#define IRQ_REG_ENTRY_DMUB(reg1, mask1, reg2, mask2)\
+	.enable_reg = SRI_DMUB(reg1),\
+	.enable_mask = \
+		reg1 ## __ ## mask1 ## _MASK,\
+	.enable_value = {\
+		reg1 ## __ ## mask1 ## _MASK,\
+		~reg1 ## __ ## mask1 ## _MASK \
+	},\
+	.ack_reg = SRI_DMUB(reg2),\
+	.ack_mask = \
+		reg2 ## __ ## mask2 ## _MASK,\
+	.ack_value = \
+		reg2 ## __ ## mask2 ## _MASK \
+
 #define dmub_trace_int_entry()\
 	[DC_IRQ_SOURCE_DMCUB_OUTBOX0] = {\
 		IRQ_REG_ENTRY_DMUB(DMCUB_INTERRUPT_ENABLE, DMCUB_OUTBOX0_READY_INT_EN,\
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

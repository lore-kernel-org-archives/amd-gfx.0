Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73308C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 416AF64E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416AF64E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA66F6EB38;
	Wed, 24 Feb 2021 22:20:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B8986EB38
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSKwCYDnvTcVmEB9FbGhIFaRMgq+HBIKdglmRe0MpuyJMnyjKIBKX/icNytmyT8i6UbeZvmCzoFY5srjBB05KWW3sevnTCvWeLn/t7UNCZg0YBujDcg/1B34cAYzAMPY0y1tmjsrrIhz/31tYNfLC0iO2PrTbkm4CRdKPXOU3UaMwCd71QSgfsVa0fKyjtIS+hVL2rE21FWKT6EsIuC4FJTrlK+Fhtao+2Xfw5yMVro4RCs8MdV1dTZyBOHsdIlOHoYGoMlSKFQUb2LqAJF2P3yySLfjKctpNqz3yPlB2A8PpnU2BRvPX9Dxg+nA19N8Uoe+iSLKzMcuXFl1W3tVJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FS9yxlFTmiRBGgpNxFKfiMqbrboXL1T72Ko7uVKbI8=;
 b=geKDmRE3dV/8eYwkodK/VOrnqcnVWJDrsqhVshvunEutNlygFPBIMf3ca9eY46ZDV7+YKohoGL5Cis0dxWVEXnVGye/nmwCSym9fwsJdRi8e1Vp94/6ZyeRiZW3XNMMAYGMQRDdhzoFUs/D0b6hrAEN4kBTb1amvCdo5BEO51BPXqg2PU4R83fPqiyRrcaFH5zLSUUi/eK+X6lcTnsDC5ZzF/2Dq2TTz8NXSL55oPwHgUFrlkhTlPhB4vs+rjsDzBuly+ONp5Q/+fMSBNXBg1yOmgjl1AFVTMsh6U3x28ADggGGOX2E+9n98CnvPrfUj/EM/jwF7CugPCMpSsQnkIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FS9yxlFTmiRBGgpNxFKfiMqbrboXL1T72Ko7uVKbI8=;
 b=fnC74N0bb71B+6Y57cA+6uwbtQePYDrTol0k5fC1AENkLJUriz6DPneFLAO9IVRcU8d3bLOq0ehyNirCXCulDPq3dwuK71bn31aFFR7xzAKX6d28MvS8NXklX1P+6RloZ41Xc5N+JJtDgb8DzL+QaXs6/baKX5UDGwPzcZ6oJXE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4175.namprd12.prod.outlook.com (2603:10b6:208:1d3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 22:20:18 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:18 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 044/159] drm/amdgpu/vcn2.6: Add vcn2.6 support
Date: Wed, 24 Feb 2021 17:17:04 -0500
Message-Id: <20210224221859.3068810-37-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:19:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0ca5bd99-e924-4e8c-db60-08d8d9124d5d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41753DB88D44B035B3A55D6FF79F9@MN2PR12MB4175.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NSn8Vp8JrV2B+Dtbso19jLq3KYP34wHtM9q/QIIqRsKpQCAr0B/GC2m4J1fpz+8V+25YvCTTBzOnS5VcrGEADoe2BJWzfvpXdhv4yfNjLTdEjcWc7LprF0vJBBTVlvDiwyH5hPs8/9Nf8t8nNDb4EfmAQDtB7nXsxmAj3mdjmAG1Y5938iiXvmX5tQ1VF9ymglMeAhpsVUHlEwI4iLGNTSjikYWOaUQxSx1PAn+P7fwRtvvhMWt1L0eyzuS9+GU5Nj9wnh56sLkMS93FZW+iCnMZm2QzyAxCBmM4Dkoowyq4//jm+wXPxAH4oNzQVqkPl14xMhwE0LqTJOAYkh1uipj5EWU+/2vPk73xDeguszcv1zhgY6fRQAzhB1ECHi48KczOdVAo+ZgoGCuPeB0AAzCvdFt9R65hcewmlO07/3XWqX9AmCdg/tLMboOlJx/2ElEKfvg4c9yGn6gWgaAjPC8JQyGQeOCC9LZsNpzok4l1lbRfT6m4kxjegZQxmrrtZNKDiROwn+MA8QQ32eygQrsInO/TPaOZgj8dqGRS+qAvUomQEZ5LTmSHDWWvll3Rfpb2Gkj+wmz+bzRSUHrHyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(66946007)(5660300002)(4326008)(6512007)(66476007)(6916009)(26005)(36756003)(66556008)(2616005)(186003)(956004)(16526019)(478600001)(8936002)(6506007)(2906002)(69590400012)(86362001)(1076003)(54906003)(6666004)(83380400001)(52116002)(8676002)(6486002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?wgfXUk/dBfJEACUe8QrzvLIM8R6ZpsMv6QOFWAt0mb3LmKL91iCpgBw46uGh?=
 =?us-ascii?Q?VfUO8JBI8ctNUxafB9R0x2Dm5NGKLyPK01DrupRJ3dkyhRpfcuTZOzfH9CAt?=
 =?us-ascii?Q?35bqjQjwCmQC/RszNDbSPudnjOgbG85x7RlLZ1DBnq+wOuEiPIV590ZC50gi?=
 =?us-ascii?Q?KN0pIsGAxMlNcTjrQWkrjb9Fp9pk5TU2G9GSFp/kauL0RnfpIuikSbCyypJ+?=
 =?us-ascii?Q?Gae8SmorA6EE9cd4b7HIHPwNUEgaNrNB9nGeItR3pxio0A1YtL8w+61Cmqfh?=
 =?us-ascii?Q?/wPG9A3kI2LfmwHARaylnQTd3ShJ2OA1uNLOmTgpVJWhSjxFrCY9nc6MmvaQ?=
 =?us-ascii?Q?7fXTsn7Yt8ViX+l5b2pqStP08lTQAWDgdcWLSZbLiE8EtEOFe4CCYrfA4nKM?=
 =?us-ascii?Q?z1Hni1mRN84I7uTh3xWiZcJ4f3eGqRHEImJRzlZWtDmJYWrAEVf32jkcknOQ?=
 =?us-ascii?Q?q93eZ7UiuAKnWvw4eYzs8zdoFwOesQrDrr8dQ4BQtbTG/uEU/ixrIb7KfV9B?=
 =?us-ascii?Q?bFQEGG/cqVa9rZ0e0dwykxmVa1eAMp65K9TZGDmbBEaE5fHxHU+1IxBzVXDG?=
 =?us-ascii?Q?8iM6HJIryRwbsGHqiVSn7Wd7OxlM7yV8rJirpu7f5mnIHAg9LQsqndUL28Nr?=
 =?us-ascii?Q?J5tK/9XYmhiq3sKeQrgRTfq68rxOIcggIIHlGV4tzw40GBqE3+CMEKkvSWCq?=
 =?us-ascii?Q?8CFNJSsMsMFTVpZpMgW8DMD+ob84TpM0JRnvbMswMwdyvJQ85gfy9AMlPIc7?=
 =?us-ascii?Q?vd8YZSQ98qw2+VuNAPdB+PFXA4tGiB+sKCBzPVVCa1Okltp3f+OwzrWXF3M4?=
 =?us-ascii?Q?qqXcp4GIg/ne/JXdC2Aqsf3Xr4nzfyREvuyoyoNdVAYlRf88/anMub4CZV9o?=
 =?us-ascii?Q?/r5FA9AQopZpWJXkics5VFhfD+cjCip6OcXhhwxGM2S1T86Pv8sLMqnVuJiE?=
 =?us-ascii?Q?wmngTJzbRPoTOV/83WGaINRs4nNSmEObpnVsu9Gpakl1/nTtQNnr/4JlKf8g?=
 =?us-ascii?Q?IWxgOh72mhVbe55nvhLlNAiXD4hF93kSy7mEx1Q0KVKSGLs21nh7wQ+wYhSp?=
 =?us-ascii?Q?i0pKJFbtAqk+K/s47ByAuWJz4kQ/8ZaE2Enzhjatuh2OwaawY3HF7VgrwHSz?=
 =?us-ascii?Q?B9Qgj4CLNi3kgvPdUFC6e6CeOAXyBqeH8Gn2NjAon0bwksoCVC+kGxwjDvUw?=
 =?us-ascii?Q?A5lObTjBgmHm4CZG1Jq9/M265rtw6kFKsaYejRdEYUEGBONOM2fR79jFz09B?=
 =?us-ascii?Q?rQqqiWAo2g9zIR7qEWVNskhiEq9Gy2AigTlF43E6Sswn3sj7JmZP5RJMyE3o?=
 =?us-ascii?Q?ZmGNmj7ClN+WoqwoiqviCafd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca5bd99-e924-4e8c-db60-08d8d9124d5d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:50.5681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAynMFxyE985XPAgl5zRVGjzWOOaefXq4pjAMOJB+E1Yyo2KkS38uApjydRYNOGM9IxKJyS9Eq/0vw8gjOHhVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4175
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Aldebaran is using vcn2.6, and the main change is vcn2.6 using
AMDGPU_MMHUB_0, and vcn2.5 using AMDGPU_MMHUB_1

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 99 ++++++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.h |  1 +
 2 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index b6e0f4ba6272..87ec883f7e06 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1545,6 +1545,36 @@ static const struct amdgpu_ring_funcs vcn_v2_5_dec_ring_vm_funcs = {
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 };
 
+static const struct amdgpu_ring_funcs vcn_v2_6_dec_ring_vm_funcs = {
+	.type = AMDGPU_RING_TYPE_VCN_DEC,
+	.align_mask = 0xf,
+	.vmhub = AMDGPU_MMHUB_0,
+	.get_rptr = vcn_v2_5_dec_ring_get_rptr,
+	.get_wptr = vcn_v2_5_dec_ring_get_wptr,
+	.set_wptr = vcn_v2_5_dec_ring_set_wptr,
+	.emit_frame_size =
+		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
+		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
+		8 + /* vcn_v2_0_dec_ring_emit_vm_flush */
+		14 + 14 + /* vcn_v2_0_dec_ring_emit_fence x2 vm fence */
+		6,
+	.emit_ib_size = 8, /* vcn_v2_0_dec_ring_emit_ib */
+	.emit_ib = vcn_v2_0_dec_ring_emit_ib,
+	.emit_fence = vcn_v2_0_dec_ring_emit_fence,
+	.emit_vm_flush = vcn_v2_0_dec_ring_emit_vm_flush,
+	.test_ring = vcn_v2_0_dec_ring_test_ring,
+	.test_ib = amdgpu_vcn_dec_ring_test_ib,
+	.insert_nop = vcn_v2_0_dec_ring_insert_nop,
+	.insert_start = vcn_v2_0_dec_ring_insert_start,
+	.insert_end = vcn_v2_0_dec_ring_insert_end,
+	.pad_ib = amdgpu_ring_generic_pad_ib,
+	.begin_use = amdgpu_vcn_ring_begin_use,
+	.end_use = amdgpu_vcn_ring_end_use,
+	.emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
+	.emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
+	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+};
+
 /**
  * vcn_v2_5_enc_ring_get_rptr - get enc read pointer
  *
@@ -1644,6 +1674,36 @@ static const struct amdgpu_ring_funcs vcn_v2_5_enc_ring_vm_funcs = {
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 };
 
+static const struct amdgpu_ring_funcs vcn_v2_6_enc_ring_vm_funcs = {
+        .type = AMDGPU_RING_TYPE_VCN_ENC,
+        .align_mask = 0x3f,
+        .nop = VCN_ENC_CMD_NO_OP,
+        .vmhub = AMDGPU_MMHUB_0,
+        .get_rptr = vcn_v2_5_enc_ring_get_rptr,
+        .get_wptr = vcn_v2_5_enc_ring_get_wptr,
+        .set_wptr = vcn_v2_5_enc_ring_set_wptr,
+        .emit_frame_size =
+                SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
+                SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
+                4 + /* vcn_v2_0_enc_ring_emit_vm_flush */
+                5 + 5 + /* vcn_v2_0_enc_ring_emit_fence x2 vm fence */
+                1, /* vcn_v2_0_enc_ring_insert_end */
+        .emit_ib_size = 5, /* vcn_v2_0_enc_ring_emit_ib */
+        .emit_ib = vcn_v2_0_enc_ring_emit_ib,
+        .emit_fence = vcn_v2_0_enc_ring_emit_fence,
+        .emit_vm_flush = vcn_v2_0_enc_ring_emit_vm_flush,
+        .test_ring = amdgpu_vcn_enc_ring_test_ring,
+        .test_ib = amdgpu_vcn_enc_ring_test_ib,
+        .insert_nop = amdgpu_ring_insert_nop,
+        .insert_end = vcn_v2_0_enc_ring_insert_end,
+        .pad_ib = amdgpu_ring_generic_pad_ib,
+        .begin_use = amdgpu_vcn_ring_begin_use,
+        .end_use = amdgpu_vcn_ring_end_use,
+        .emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
+        .emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
+        .emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+};
+
 static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev)
 {
 	int i;
@@ -1651,7 +1711,10 @@ static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
-		adev->vcn.inst[i].ring_dec.funcs = &vcn_v2_5_dec_ring_vm_funcs;
+		if (adev->asic_type == CHIP_ARCTURUS)
+			adev->vcn.inst[i].ring_dec.funcs = &vcn_v2_5_dec_ring_vm_funcs;
+		else /* CHIP_ALDEBARAN */
+			adev->vcn.inst[i].ring_dec.funcs = &vcn_v2_6_dec_ring_vm_funcs;
 		adev->vcn.inst[i].ring_dec.me = i;
 		DRM_INFO("VCN(%d) decode is enabled in VM mode\n", i);
 	}
@@ -1665,7 +1728,10 @@ static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << j))
 			continue;
 		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
-			adev->vcn.inst[j].ring_enc[i].funcs = &vcn_v2_5_enc_ring_vm_funcs;
+			if (adev->asic_type == CHIP_ARCTURUS)
+				adev->vcn.inst[j].ring_enc[i].funcs = &vcn_v2_5_enc_ring_vm_funcs;
+			else /* CHIP_ALDEBARAN */
+				adev->vcn.inst[j].ring_enc[i].funcs = &vcn_v2_6_enc_ring_vm_funcs;
 			adev->vcn.inst[j].ring_enc[i].me = j;
 		}
 		DRM_INFO("VCN(%d) encode is enabled in VM mode\n", j);
@@ -1830,6 +1896,26 @@ static const struct amd_ip_funcs vcn_v2_5_ip_funcs = {
 	.set_powergating_state = vcn_v2_5_set_powergating_state,
 };
 
+static const struct amd_ip_funcs vcn_v2_6_ip_funcs = {
+        .name = "vcn_v2_6",
+        .early_init = vcn_v2_5_early_init,
+        .late_init = NULL,
+        .sw_init = vcn_v2_5_sw_init,
+        .sw_fini = vcn_v2_5_sw_fini,
+        .hw_init = vcn_v2_5_hw_init,
+        .hw_fini = vcn_v2_5_hw_fini,
+        .suspend = vcn_v2_5_suspend,
+        .resume = vcn_v2_5_resume,
+        .is_idle = vcn_v2_5_is_idle,
+        .wait_for_idle = vcn_v2_5_wait_for_idle,
+        .check_soft_reset = NULL,
+        .pre_soft_reset = NULL,
+        .soft_reset = NULL,
+        .post_soft_reset = NULL,
+        .set_clockgating_state = vcn_v2_5_set_clockgating_state,
+        .set_powergating_state = vcn_v2_5_set_powergating_state,
+};
+
 const struct amdgpu_ip_block_version vcn_v2_5_ip_block =
 {
 		.type = AMD_IP_BLOCK_TYPE_VCN,
@@ -1838,3 +1924,12 @@ const struct amdgpu_ip_block_version vcn_v2_5_ip_block =
 		.rev = 0,
 		.funcs = &vcn_v2_5_ip_funcs,
 };
+
+const struct amdgpu_ip_block_version vcn_v2_6_ip_block =
+{
+		.type = AMD_IP_BLOCK_TYPE_VCN,
+		.major = 2,
+		.minor = 6,
+		.rev = 0,
+		.funcs = &vcn_v2_6_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.h b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.h
index 8d9c0800b8e0..e72f799ed0fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.h
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.h
@@ -25,5 +25,6 @@
 #define __VCN_V2_5_H__
 
 extern const struct amdgpu_ip_block_version vcn_v2_5_ip_block;
+extern const struct amdgpu_ip_block_version vcn_v2_6_ip_block;
 
 #endif /* __VCN_V2_5_H__ */
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

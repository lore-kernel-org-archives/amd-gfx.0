Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2857AC43461
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 16:21:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90C5922403
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 16:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ESXtW7wT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90C5922403
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E17936EA61;
	Wed, 16 Sep 2020 16:21:42 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750075.outbound.protection.outlook.com [40.107.75.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85D836EA61
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 16:21:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ucj9qlI/FEnixMK/muX8/zJknTPUZGNHKCFAn8aW8d6jW5QhePArRSLm/3UkUE7cvu5qc8IcKSmNgYAwC0V0rm5S9HqHXVB/QQrX5R+KCwahUpO3wMTwkl3jsr+iXGM8IRD6ONVAA3Tm6WeI7D+KCpeFfV0t9diaXFnZSsky3F7pQPAnU8EzS1ZCryF6ziDqwy0T6MIxGs6m8DkvBB9PITgi/urzIJ5LHL9CNk+UxdnQ35HZyciutNb4Hog5Oc8qIq6uMtfIR3u4G2A8i8xm20xTFX/y8+tMNdmoljFbGgnZ3y3ll1UdJRULYd3T/pSJAwlqa3MDxD6tK7Xi+GqLtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sftOWPShKm7w7RQTpX1G1fBWwg6I8rpGgEWfJKYv8NE=;
 b=Laj+R+bKBZ53vZEJxP2JlOUil6aLhYra8lY0n9m70pZY1FWcZPqL7LxWDGkLhxHJkKrdXyVVtzVq2ZVzySEc6a4Bn9v/DmKHfAnQWtfCWOYlaDwTWZ7RLC6cfkH+6YhiLsmBoUdnLaVj9AEUvrBWGvO0sfxN+kRMur8N8fXmVsRQUtsRKG+fQA5dtKMEI7w9FFGSQ0LUrwlfujWXoUpwI+NHfX0/auC2Mj2lDCX/4EvIFSTV+Sg4ZztArKvl6S0zuB/bgJV7FdWcqqmU0DH4tvkEFExG/e8JbmUENULbOkKgcO0YyrQ7O9fHlzZ4+5tKuW8/oCVQ3Yhj92hz4WUUEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sftOWPShKm7w7RQTpX1G1fBWwg6I8rpGgEWfJKYv8NE=;
 b=ESXtW7wTfEi1QZe8pjX9gjMzDSTq4ju2HPBy4vqRdm7Z3Fhy/tJr3t7O02kWmZ7lCp0JZN+SKVPq/iWov7bUPsKFRJWqxV5q7lph0/SdsBCfl8zzawlcHgbtIRPv65rMbHMxPiMM3wAcWfNg6vaJC0Mw05QvDQx9C/W3OmNPr4M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM6PR12MB4106.namprd12.prod.outlook.com (2603:10b6:5:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 16:21:40 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::c0a8:314d:61b9:24ce]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::c0a8:314d:61b9:24ce%5]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 16:21:40 +0000
From: Tom St Denis <tom.stdenis@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: add mmUVD_FW_STATUS register to uvd700
Date: Wed, 16 Sep 2020 12:21:30 -0400
Message-Id: <20200916162130.1562572-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: BN6PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:404:13e::13) To DM6PR12MB3547.namprd12.prod.outlook.com
 (2603:10b6:5:18a::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ws.amd.com (165.204.84.11) by
 BN6PR13CA0027.namprd13.prod.outlook.com (2603:10b6:404:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5 via Frontend
 Transport; Wed, 16 Sep 2020 16:21:38 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 51bed57c-e05a-47ca-2925-08d85a5c9737
X-MS-TrafficTypeDiagnostic: DM6PR12MB4106:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4106661D2132498EDCB8A227F7210@DM6PR12MB4106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YW7c2QU8HwgPR2GH/hfTnDPm/vwIMGXF2t9o/wAek9m2LqwkZDS9hM1hihz4bT4/vIg63F0nGjs8PddU6Qk3c0ELkAXfGIWpv+E//bKFxXDGrTaJO1RUdTHcdzuogcgC0ghYoPi3FxdPiVO6k3ia4LD5WU6SzwaBe6/In23X3RdWHQn29fI9sdK6CZ+j6U14WyhJBnc2qqk9MTKsxJWy7qbKrWhPlDwbOo9LeltavugkPg/QZE39nU8ydRF2Blly0Fn8xPJ5qUS2BLnC7IuGkoYIeisl98IZlK4MugKkaUJvgBzlHys632KW5HAW7rJcN6oq/WqZo9YDr8k6duKomA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(6666004)(956004)(6486002)(2616005)(86362001)(478600001)(6916009)(26005)(316002)(4326008)(36756003)(2906002)(186003)(8676002)(1076003)(83380400001)(66476007)(7696005)(52116002)(66556008)(16526019)(5660300002)(66946007)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ByhPmSw9PED/YR2rEc5bp+rvl759mLLNGfsCOkptVolayLOjMM+J47tq4i/4l3FEO17Bq5IyVTbzn0AbXxcTlIfOFkMy4aTelD06DtVbLLhzrwe7jp6sUZrKyvhnU1iuWYNRn2vZ/ivbtqzcQ1UT8+3kFw+u0S5WuUyQ15XAaPFAklk5foWRbLzYqOegOiUUw8bIjcfaQRxOrxxuqTuk4oRuSysCha+CL+HUlh0/2fyFfMPb57Apsg4vtMNZz04W5ezXcl2xCOgd16qEIJVR7Wx9x80V0YOQIgmRwHEXVFvEqrEp5VmrLmZ2HKyUEKSlLDyTkB6OnoadTbxFefEyem/Xkf5JHAj9DfApjKNJ6PbhiV/9eEg7QSnFWC4Wk2Wc2OLPtaOVqjoJHr6RnRIlkv7pWj/be11fVSL0jY6HnB+5Es4tJnEQBpWvpYHWQ6RRoTCehFpqOz9C45/ZZ/1Jjc1HmD1LLwohRYN27/h0yKqSVwH94qAuSWURg5a5mUZRac50s0iFk8DBkJwJakllsL0vNDfv51L0RX/g28FhzDmOeT1cnbSNWdN9MtfKxKcFWmXrE6tfLHiotJXNxYpooqerNFm2waMSnMBxRVlSDIMbp5f92QbdfWRoWbP3WmyxRituzC292BO9rTtn/ZrzqA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51bed57c-e05a-47ca-2925-08d85a5c9737
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 16:21:39.8797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tkRBB/hyTyzZlDtDCT2CuQhINp1rX1CSMdIxDmhEFF6B2jLeI8P+EYOqOABDa7pwVlaLKH6sNRoh0kZlQEMqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4106
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This register was requested for umr debugging support.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 .../amd/include/asic_reg/uvd/uvd_7_0_offset.h |  3 +++
 .../include/asic_reg/uvd/uvd_7_0_sh_mask.h    | 20 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_7_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_7_0_offset.h
index 07aceffb108a..524ba4421c17 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_7_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_7_0_offset.h
@@ -151,6 +151,8 @@
 #define mmUVD_LMI_CTRL2_BASE_IDX                                                                       1
 #define mmUVD_MASTINT_EN                                                                               0x0540
 #define mmUVD_MASTINT_EN_BASE_IDX                                                                      1
+#define mmUVD_FW_STATUS                                                                                0x0557
+#define mmUVD_FW_STATUS_BASE_IDX                                                                       1
 #define mmJPEG_CGC_CTRL                                                                                0x0565
 #define mmJPEG_CGC_CTRL_BASE_IDX                                                                       1
 #define mmUVD_LMI_CTRL                                                                                 0x0566
@@ -219,4 +221,5 @@
 #define mmUVD_CONTEXT_ID2_BASE_IDX                                                                     1
 
 
+
 #endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_7_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_7_0_sh_mask.h
index b427f73bd536..919be1842bd5 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_7_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_7_0_sh_mask.h
@@ -807,5 +807,25 @@
 #define UVD_CONTEXT_ID2__CONTEXT_ID2__SHIFT                                                                   0x0
 #define UVD_CONTEXT_ID2__CONTEXT_ID2_MASK                                                                     0xFFFFFFFFL
 
+//UVD_FW_STATUS
+#define UVD_FW_STATUS__BUSY__SHIFT                                                                            0x0
+#define UVD_FW_STATUS__ACTIVE__SHIFT                                                                          0x1
+#define UVD_FW_STATUS__SEND_EFUSE_REQ__SHIFT                                                                  0x2
+#define UVD_FW_STATUS__DONE__SHIFT                                                                            0x8
+#define UVD_FW_STATUS__PASS__SHIFT                                                                            0x10
+#define UVD_FW_STATUS__FAIL__SHIFT                                                                            0x11
+#define UVD_FW_STATUS__INVALID_LEN__SHIFT                                                                     0x12
+#define UVD_FW_STATUS__INVALID_0_PADDING__SHIFT                                                               0x13
+#define UVD_FW_STATUS__INVALID_NONCE__SHIFT                                                                   0x14
+#define UVD_FW_STATUS__BUSY_MASK                                                                              0x00000001L
+#define UVD_FW_STATUS__ACTIVE_MASK                                                                            0x00000002L
+#define UVD_FW_STATUS__SEND_EFUSE_REQ_MASK                                                                    0x00000004L
+#define UVD_FW_STATUS__DONE_MASK                                                                              0x00000100L
+#define UVD_FW_STATUS__PASS_MASK                                                                              0x00010000L
+#define UVD_FW_STATUS__FAIL_MASK                                                                              0x00020000L
+#define UVD_FW_STATUS__INVALID_LEN_MASK                                                                       0x00040000L
+#define UVD_FW_STATUS__INVALID_0_PADDING_MASK                                                                 0x00080000L
+#define UVD_FW_STATUS__INVALID_NONCE_MASK                                                                     0x00100000L
+
 
 #endif
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

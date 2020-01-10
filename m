Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B961DC33CA1
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 02:34:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 899302073A
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 02:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mINGeBqs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899302073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AEDA6E98A;
	Fri, 10 Jan 2020 02:34:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E94806E98A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 02:34:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvukgC4wUUvSWvEa6+1ajyuz0v69hWIDnI5QSEFxvICl5COhtQ00o6Ky52eVYJ72adIdSDZd20hJmVyZQe/2C78nDw6Jv07KCX9QZ7GXxePNCG7pL/dAzh1pvZEu4AA8blmiVPBm5IVeahAe5sXRSAEk/npvkMBlwp2iIAzbZiqo7gg3gHwbRJznrvgWeH36ZqeyCarOvzZiWrknv5tKqrftB36OH3CRLhScoM7x7mklE4PFo961Iq3+q7Z/5lC3AzDarZlPC1PK1DUOu9+h4gz+tm82mYfh59auEwBdF9KbM+XXU5LQ045gsUaEa9OMJqvZkYDY8+qTxp3n9J9q3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Cscl8yLMacA0NtwMizcQb2ExRQYJ08TsECUiA8S6DE=;
 b=ismaVwdp/CcpAfG/CccrstodoC1rL8vZhKL8UIjgMFA5I99fD5xc6rLiZlWMU4jcDg2sLxrFBJltmqq7RuH2OerShOxVcBNzGtOIDBALarRyHjGimRUgbw8kEyEtsoaTBdP4KR5K4orw0vNwdFHd8GzoZPQpd4q3hSf79KWnx+TmW1p/r5TFRFYdUumuxfbaPv0SSdu12KHYMxhLlmJhukroACz9AzdBKVwi3aGk+A1NUvjOvLC4ZKffXo1sOK0Ti9ODc+JqsDQVtzHXshDx/WRfS2utQ4Nz2adaluNC899H4jbo9ZD7+tDChud2N5OS0l4Iw2Dwc0To0UE2qjD14Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Cscl8yLMacA0NtwMizcQb2ExRQYJ08TsECUiA8S6DE=;
 b=mINGeBqsO91VdPirVcvRU/Vyr9Y2R8MKqKM59DqbWX7txHSGXCzZJq/8U+HAO/0mJ5hhR4DFh8mwBpIvcuFwj9OtzkdB2jIO6a5A5OGGh8cooAx8lG6IgGJfqKoBH26+yG/7K5KAlA6RHu0DBtQLdMQC0Xp46mrCLxIEV2aCNBs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Joseph.Greathouse@amd.com; 
Received: from DM5PR1201MB2472.namprd12.prod.outlook.com (10.172.86.151) by
 DM5PR1201MB0089.namprd12.prod.outlook.com (10.174.104.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Fri, 10 Jan 2020 02:34:21 +0000
Received: from DM5PR1201MB2472.namprd12.prod.outlook.com
 ([fe80::7c50:5e2f:e0a:3721]) by DM5PR1201MB2472.namprd12.prod.outlook.com
 ([fe80::7c50:5e2f:e0a:3721%6]) with mapi id 15.20.2623.010; Fri, 10 Jan 2020
 02:34:21 +0000
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: add defines for DF and TCP Hashing
Date: Thu,  9 Jan 2020 20:02:05 -0600
Message-Id: <20200110020206.676605-3-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200110020206.676605-1-Joseph.Greathouse@amd.com>
References: <20200110020206.676605-1-Joseph.Greathouse@amd.com>
X-ClientProxiedBy: SN4PR0601CA0008.namprd06.prod.outlook.com
 (2603:10b6:803:2f::18) To DM5PR1201MB2472.namprd12.prod.outlook.com
 (2603:10b6:3:e1::23)
MIME-Version: 1.0
Received: from rocm-perf01.amd.com (165.204.78.2) by
 SN4PR0601CA0008.namprd06.prod.outlook.com (2603:10b6:803:2f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13 via Frontend
 Transport; Fri, 10 Jan 2020 02:34:21 +0000
X-Mailer: git-send-email 2.19.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3416640a-db36-4c9d-4e0e-08d79575996f
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0089:|DM5PR1201MB0089:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0089B958A91584F6424DD735F9380@DM5PR1201MB0089.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(199004)(189003)(8676002)(6666004)(3450700001)(81156014)(81166006)(19627235002)(1076003)(316002)(86362001)(66556008)(66476007)(66946007)(4326008)(6916009)(52116002)(7696005)(5660300002)(956004)(478600001)(2616005)(186003)(6486002)(8936002)(16526019)(36756003)(26005)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0089;
 H:DM5PR1201MB2472.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hSg/4KU+zn8Ix6emxapc69/Nv4zPdk8Ms+aghcFddofO6TRSBZDcWcU2fIIVdfQYLH9t+DdS1PMYgTJbjC/txG6pHJvvTFV34tQI7xTchO4rHzKIm9FUHaQE6/zMmFjwaSw97YLw2YuBegD9VgatTeQ9Sl6BodZmQ5kjx9bd5fCYgF1MFA9sTSJFIWH+dS4+blFQG4bKYeYn3UoktG7AZfE60mParClolastMC8jRanfT1QP7GBpXmFITaWbCJTIQUYbCI26/yJSQYreEaEgYOhU14rQr3gu+/lU5yTwtvY07JH1qRFYrnmG1AeADNnuaVaREojRM3ZjLRne4gH9f81GBcyiEPF1B+uVe7v0D8HpTFbiZ3dfwoOG/RLXcLmuNp8ma/tQ9uZ2Bs7wLp1dJ5BzzesG/NjQRTPeRUbdrIg1Wyrjyj/KfT3FbXqT+TAi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3416640a-db36-4c9d-4e0e-08d79575996f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 02:34:21.5404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qiBjm+dSqak5h0afLU5Dmn0vQ2Q19iUzLDowtloLrlCWyuYii464LWEQY9XxQmRcmXmVdLje0vCgO1ZdTOfKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0089
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
Reply-To: Joseph Greathouse <Joseph.Greathouse@amd.com>
Cc: Joseph Greathouse <Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Arcturus, we need TC channel hashing, which is set by the
driver, to match DF hashing, which is set by VBIOS. To match
these, we plan to query the DF information and then properly
set the TC configuration bits to match them.

This patch adds the required fields to register definitions
in preparation for a future patch which will use them.

Change-Id: Ia405ee9aeec6fc22303a7376ec3d714e3f93af1d
Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
---
 drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_offset.h  | 3 +++
 drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h | 8 ++++++++
 drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h | 6 ++++++
 3 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_offset.h b/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_offset.h
index f301e5fe2109..32a336a450ae 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_offset.h
@@ -27,6 +27,9 @@
 #define mmDF_PIE_AON0_DfGlobalClkGater									0x00fc
 #define mmDF_PIE_AON0_DfGlobalClkGater_BASE_IDX								0
 
+#define mmDF_CS_UMC_AON0_DfGlobalCtrl								  	0x00fe
+#define mmDF_CS_UMC_AON0_DfGlobalCtrl_BASE_IDX							 	0
+
 #define mmDF_CS_UMC_AON0_DramBaseAddress0								0x0044
 #define mmDF_CS_UMC_AON0_DramBaseAddress0_BASE_IDX							0
 
diff --git a/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h
index 06fac509e987..65e9f756e86e 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/df/df_3_6_sh_mask.h
@@ -33,6 +33,14 @@
 #define DF_PIE_AON0_DfGlobalClkGater__MGCGMode__SHIFT							0x0
 #define DF_PIE_AON0_DfGlobalClkGater__MGCGMode_MASK							0x0000000FL
 
+/* DF_CS_UMC_AON0_DfGlobalCtrl */
+#define DF_CS_UMC_AON0_DfGlobalCtrl__GlbHashIntlvCtl64K__SHIFT						0x14
+#define DF_CS_UMC_AON0_DfGlobalCtrl__GlbHashIntlvCtl2M__SHIFT						0x15
+#define DF_CS_UMC_AON0_DfGlobalCtrl__GlbHashIntlvCtl1G__SHIFT						0x16
+#define DF_CS_UMC_AON0_DfGlobalCtrl__GlbHashIntlvCtl64K_MASK						0x00100000L
+#define DF_CS_UMC_AON0_DfGlobalCtrl__GlbHashIntlvCtl2M_MASK						0x00200000L
+#define DF_CS_UMC_AON0_DfGlobalCtrl__GlbHashIntlvCtl1G_MASK						0x00400000L
+
 /* DF_CS_AON0_DramBaseAddress0 */
 #define DF_CS_UMC_AON0_DramBaseAddress0__AddrRngVal__SHIFT						0x0
 #define DF_CS_UMC_AON0_DramBaseAddress0__LgcyMmioHoleEn__SHIFT						0x1
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
index d4c613a85352..c9e3f6d849a8 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
@@ -8739,10 +8739,16 @@
 #define TCP_ADDR_CONFIG__NUM_BANKS__SHIFT                                                                     0x4
 #define TCP_ADDR_CONFIG__COLHI_WIDTH__SHIFT                                                                   0x6
 #define TCP_ADDR_CONFIG__RB_SPLIT_COLHI__SHIFT                                                                0x9
+#define TCP_ADDR_CONFIG__ENABLE64KHASH__SHIFT                                                                 0xb
+#define TCP_ADDR_CONFIG__ENABLE2MHASH__SHIFT                                                                  0xc
+#define TCP_ADDR_CONFIG__ENABLE1GHASH__SHIFT                                                                  0xd
 #define TCP_ADDR_CONFIG__NUM_TCC_BANKS_MASK                                                                   0x0000000FL
 #define TCP_ADDR_CONFIG__NUM_BANKS_MASK                                                                       0x00000030L
 #define TCP_ADDR_CONFIG__COLHI_WIDTH_MASK                                                                     0x000001C0L
 #define TCP_ADDR_CONFIG__RB_SPLIT_COLHI_MASK                                                                  0x00000200L
+#define TCP_ADDR_CONFIG__ENABLE64KHASH_MASK                                                                   0x00000800L
+#define TCP_ADDR_CONFIG__ENABLE2MHASH_MASK                                                                    0x00001000L
+#define TCP_ADDR_CONFIG__ENABLE1GHASH_MASK                                                                    0x00002000L
 //TCP_CREDIT
 #define TCP_CREDIT__LFIFO_CREDIT__SHIFT                                                                       0x0
 #define TCP_CREDIT__REQ_FIFO_CREDIT__SHIFT                                                                    0x10
-- 
2.19.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

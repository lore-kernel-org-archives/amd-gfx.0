Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319DBC433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 22:01:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 012A121852
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 22:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ilU60Q44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012A121852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 923046E8E7;
	Wed, 17 Jun 2020 22:00:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADE3F6E1F1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 22:00:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIgeOAT3e8SuiOO828zFSji9UzCAoF0vJQ1/g07h4bHCqv8A9N1yCRJL5rwljeTh90b0zc/UxAcx/QsiSTuo61K/ftSWTZXZ4u5yXagct58YkuXUROVUam9TVasTpeMrOZiWND9Q1gGK/GaLHGDhmxCiCpjIpRNhrZOoHOpE04rCSx/OtWDgIYOF9b8smfO2Db68OB/AGn4waFkeEuMhzkvUdqPA5dvPE/qPuzul3H6a1jF4KM6IPD1j36+PqbVUOW+avK7/VgZ8Sq0DBERjIp+y48Abog7VCeP+ZBSXB9MNgSmI+2dBRnLCs6r7DVvElVX7sf+LjFvrBm3xstWtDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4s9Q6TnVXefAiat5l783uf+7ldwrPzjyegmVLPoPS3o=;
 b=H0UyhKNHe9YPhdAj2shK2N9qYcIKjQTTZpLnaAJ+tVx0KDKlJGYc4/MMXDS3NfB+MtOs4GFBfy2YSp+13bNuKbu98PvmHXiw3IlWAHPr0/70d1StbBoFMU0VmEfT+++uah8x8jwsdPxXInWfz6o1vg9g16xSXXPlfjC6W8Jch02LWYv1WeqxbpWcE6bZc4PAYiXXr0dv0MBy/aC4uumdahezJQLFZPRf1b3jS0CrxFUXQFheSEfiY7z7/fzbZf3QO8oF7NaoEKISjZ1qTE6aQK0Y3w5R/ceLYQikMmbTWRT/Eko40rAaQpBcVbbU1K4JRJ0qiVQ4NFGDxnzFSj9eJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4s9Q6TnVXefAiat5l783uf+7ldwrPzjyegmVLPoPS3o=;
 b=ilU60Q44hMFb63RABrUHDpaRfdNyJkMnTj8Tmuz3zM3rswbyzVirG64AJJX9HAb3PcpPSYFizpicviIMx2dBEWXwBUe+C3X8VnMaZXVCXG0V6Ykh3XZ+4I/mUvsHJ+FVSrB7fHpbh1IDk4ZuFmnbzgJXQf8Oege9EdkAvXSDpwk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3433.namprd12.prod.outlook.com (2603:10b6:5:38::14) by
 DM5PR1201MB0185.namprd12.prod.outlook.com (2603:10b6:4:55::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22; Wed, 17 Jun 2020 22:00:54 +0000
Received: from DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::64ab:bf43:33df:e88c]) by DM6PR12MB3433.namprd12.prod.outlook.com
 ([fe80::64ab:bf43:33df:e88c%7]) with mapi id 15.20.3109.021; Wed, 17 Jun 2020
 22:00:54 +0000
From: Sonny Jiang <sonny.jiang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/7] drm amdgpu: SI UVD registers
Date: Wed, 17 Jun 2020 18:00:11 -0400
Message-Id: <20200617220016.4844-2-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200617220016.4844-1-sonny.jiang@amd.com>
References: <20200617220016.4844-1-sonny.jiang@amd.com>
X-ClientProxiedBy: BN6PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:404:8c::31) To DM6PR12MB3433.namprd12.prod.outlook.com
 (2603:10b6:5:38::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.84.11) by
 BN6PR07CA0021.namprd07.prod.outlook.com (2603:10b6:404:8c::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Wed, 17 Jun 2020 22:00:53 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 866e11ab-99c3-4e22-77a0-08d81309e7c2
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0185:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01856393315D007AC19ACE58FD9A0@DM5PR1201MB0185.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sMTlkK0SPZmRJCeT3PhpFY4YFaz8EqxL8gms/ucRO2+XUn/h8TozRtkM3Qi4rCi1+Y+f1Qdr2jwVEJASDvqI0AG9t3UEKLbjj+m+ct6elrs9tMaVUQ0kZiUu3x7L29FGxNV3JSZtszShZhrPT6vb41E82fVaysza+07nA6pN29f1prjoODTncZct4x59R8ZlYRB+wGYJoag1/cyIWnXiYnSi2xDIdl0ZiBBlDGuqk88Rr/rojg6IcNeR6W0n1xR1Vl1GfpD+r/VfN7wu+NiXHFnvt9UZS7zmuc43txVWMhj6ukakViMQHjf9JppkA/0NKzSAJIgMrGoU2stZGNZbjiNdEI7kVgKZDD1PTQ80RA6OPf06RcGz0Dm7tnMd8V5D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(5660300002)(316002)(6666004)(30864003)(86362001)(6512007)(186003)(4326008)(1076003)(16526019)(26005)(66946007)(2616005)(8676002)(6916009)(44832011)(6486002)(66476007)(66556008)(478600001)(36756003)(52116002)(6506007)(8936002)(83380400001)(69590400007)(956004)(2906002)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: P09LpavRm8LugK3y0L9Q1KivL8/w5fhfMj4iZBUR+rZXx5ktzoS+Xt6h03prOdkOhsQTLs0PCtuAgYYeS1jGIeuw/7qWrYfVkilTStzHzeyVNSfY5joznOSrPMSqQxddwTj1JgraibOU1CYsQIEtYYr4yVuG+aUgK1XSMQvBRB6iWNHEkYu/oROW6hQYahHGI2S3Np8EGG6QyFcISdr98ud/Bm9M/OqgM414VZVZpMA+R/tSEiPIAgyCvrjnGRAX84xOaSEEpidB4qCSSyAcZ4nxJwCPaCMRw/xGplMBZQC2zD/R+Q+C/huXBOSOIwG4MZLR2YQ3gOebi1uAQ6ubcSg3OzEDmhREJtwx/MFeyiX8ma8ZZUZiW68LLoPdrROelxS51FUZXIZf6yW6ZuDMzxUUx4rpR5JzVVO87ugSC8RJkC6sHIQNgtseDEzgUMziZppg4FqszzQ5W9RQ5HXeKb3P68S68pTN5crT4iqVIPI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866e11ab-99c3-4e22-77a0-08d81309e7c2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 22:00:54.2276 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QBXO5UvzJgNRVi+B+foTK23+r1DP8B+t8KXVwYDDwit3C3Tt6A3NxA3cvamNlybxETl/ZoD1zloHucpt+o6Jyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0185
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
Cc: Sonny Jiang <sonny.jiang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

---
 .../drm/amd/include/asic_reg/uvd/uvd_3_1_d.h  |  98 +++
 .../include/asic_reg/uvd/uvd_3_1_sh_mask.h    | 804 ++++++++++++++++++
 2 files changed, 902 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_3_1_d.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_3_1_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_3_1_d.h b/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_3_1_d.h
new file mode 100644
index 000000000000..0d78806938f2
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_3_1_d.h
@@ -0,0 +1,98 @@
+/*
+ * UVD_3_1 Register documentation
+ *
+ * Copyright (C) 2020  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef UVD_3_1_D_H
+#define UVD_3_1_D_H
+
+#define mmUVD_SEMA_ADDR_LOW                                                     0x3bc0
+#define mmUVD_SEMA_ADDR_HIGH                                                    0x3bc1
+#define mmUVD_SEMA_CMD                                                          0x3bc2
+#define mmUVD_GPCOM_VCPU_CMD                                                    0x3bc3
+#define mmUVD_GPCOM_VCPU_DATA0                                                  0x3bc4
+#define mmUVD_GPCOM_VCPU_DATA1                                                  0x3bc5
+#define mmUVD_ENGINE_CNTL                                                       0x3bc6
+#define mmUVD_UDEC_ADDR_CONFIG                                                  0x3bd3
+#define mmUVD_UDEC_DB_ADDR_CONFIG                                               0x3bd4
+#define mmUVD_UDEC_DBW_ADDR_CONFIG                                              0x3bd5
+#define mmUVD_NO_OP                                                             0x3bff
+#define mmUVD_SEMA_CNTL                                                         0x3d00
+#define mmUVD_LMI_EXT40_ADDR                                                    0x3d26
+#define mmUVD_CTX_INDEX                                                         0x3d28
+#define mmUVD_CTX_DATA                                                          0x3d29
+#define mmUVD_CGC_GATE                                                          0x3d2a
+#define mmUVD_CGC_STATUS                                                        0x3d2b
+#define mmUVD_CGC_CTRL                                                          0x3d2c
+#define mmUVD_CGC_UDEC_STATUS                                                   0x3d2d
+#define mmUVD_LMI_CTRL2                                                         0x3d3d
+#define mmUVD_MASTINT_EN                                                        0x3d40
+#define mmUVD_FW_START                                                          0x3d47
+#define mmUVD_FW_STATUS                                                         0x3d57
+#define mmUVD_LMI_ADDR_EXT                                                      0x3d65
+#define mmUVD_LMI_CTRL                                                          0x3d66
+#define mmUVD_LMI_STATUS                                                        0x3d67
+#define mmUVD_LMI_SWAP_CNTL                                                     0x3d6d
+#define mmUVD_MP_SWAP_CNTL                                                      0x3d6f
+#define mmUVD_MPC_CNTL                                                          0x3d77
+#define mmUVD_MPC_SET_MUXA0                                                     0x3d79
+#define mmUVD_MPC_SET_MUXA1                                                     0x3d7a
+#define mmUVD_MPC_SET_MUXB0                                                     0x3d7b
+#define mmUVD_MPC_SET_MUXB1                                                     0x3d7c
+#define mmUVD_MPC_SET_MUX                                                       0x3d7d
+#define mmUVD_MPC_SET_ALU                                                       0x3d7e
+#define mmUVD_VCPU_CACHE_OFFSET0                                                0x3d82
+#define mmUVD_VCPU_CACHE_SIZE0                                                  0x3d83
+#define mmUVD_VCPU_CACHE_OFFSET1                                                0x3d84
+#define mmUVD_VCPU_CACHE_SIZE1                                                  0x3d85
+#define mmUVD_VCPU_CACHE_OFFSET2                                                0x3d86
+#define mmUVD_VCPU_CACHE_SIZE2                                                  0x3d87
+#define mmUVD_VCPU_CNTL                                                         0x3d98
+#define mmUVD_SOFT_RESET                                                        0x3da0
+#define mmUVD_RBC_IB_BASE                                                       0x3da1
+#define mmUVD_RBC_IB_SIZE                                                       0x3da2
+#define mmUVD_RBC_RB_BASE                                                       0x3da3
+#define mmUVD_RBC_RB_RPTR                                                       0x3da4
+#define mmUVD_RBC_RB_WPTR                                                       0x3da5
+#define mmUVD_RBC_RB_WPTR_CNTL                                                  0x3da6
+#define mmUVD_RBC_RB_CNTL                                                       0x3da9
+#define mmUVD_RBC_RB_RPTR_ADDR                                                  0x3daa
+#define mmUVD_STATUS                                                            0x3daf
+#define mmUVD_SEMA_TIMEOUT_STATUS                                               0x3db0
+#define mmUVD_SEMA_WAIT_INCOMPLETE_TIMEOUT_CNTL                                 0x3db1
+#define mmUVD_SEMA_WAIT_FAULT_TIMEOUT_CNTL                                      0x3db2
+#define mmUVD_SEMA_SIGNAL_INCOMPLETE_TIMEOUT_CNTL                               0x3db3
+#define mmUVD_CONTEXT_ID                                                        0x3dbd
+#define mmUVD_RBC_IB_SIZE_UPDATE                                                0x3df1
+#define ixUVD_LMI_CACHE_CTRL                                                    0x9b
+#define ixUVD_LMI_SWAP_CNTL2                                                    0xaa
+#define ixUVD_LMI_ADDR_EXT2                                                     0xab
+#define ixUVD_CGC_MEM_CTRL                                                      0xc0
+#define ixUVD_CGC_CTRL2                                                         0xc1
+#define mmUVD_PGFSM_CONFIG                                                      0x38f8
+#define mmUVD_PGFSM_READ_TILE1                                                  0x38fa
+#define mmUVD_PGFSM_READ_TILE2                                                  0x38fb
+#define mmUVD_POWER_STATUS                                                      0x38fc
+#define ixUVD_MIF_CURR_ADDR_CONFIG                                              0x48
+#define ixUVD_MIF_REF_ADDR_CONFIG                                               0x4c
+#define ixUVD_MIF_RECON1_ADDR_CONFIG                                            0x114
+
+#endif /* UVD_3_1_D_H */
diff --git a/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_3_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_3_1_sh_mask.h
new file mode 100644
index 000000000000..eb6d9b62496b
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/uvd/uvd_3_1_sh_mask.h
@@ -0,0 +1,804 @@
+/*
+ * UVD_3_1 Register documentation
+ *
+ * Copyright (C) 2020  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#ifndef UVD_3_1_SH_MASK_H
+#define UVD_3_1_SH_MASK_H
+
+#define UVD_SEMA_ADDR_LOW__ADDR_22_3_MASK 0xfffff
+#define UVD_SEMA_ADDR_LOW__ADDR_22_3__SHIFT 0x0
+#define UVD_SEMA_ADDR_HIGH__ADDR_42_23_MASK 0xfffff
+#define UVD_SEMA_ADDR_HIGH__ADDR_42_23__SHIFT 0x0
+#define UVD_SEMA_CMD__REQ_CMD_MASK 0xf
+#define UVD_SEMA_CMD__REQ_CMD__SHIFT 0x0
+#define UVD_SEMA_CMD__WR_PHASE_MASK 0x30
+#define UVD_SEMA_CMD__WR_PHASE__SHIFT 0x4
+#define UVD_SEMA_CMD__MODE_MASK 0x40
+#define UVD_SEMA_CMD__MODE__SHIFT 0x6
+#define UVD_SEMA_CMD__VMID_EN_MASK 0x80
+#define UVD_SEMA_CMD__VMID_EN__SHIFT 0x7
+#define UVD_SEMA_CMD__VMID_MASK 0xf00
+#define UVD_SEMA_CMD__VMID__SHIFT 0x8
+#define UVD_GPCOM_VCPU_CMD__CMD_SEND_MASK 0x1
+#define UVD_GPCOM_VCPU_CMD__CMD_SEND__SHIFT 0x0
+#define UVD_GPCOM_VCPU_CMD__CMD_MASK 0x7ffffffe
+#define UVD_GPCOM_VCPU_CMD__CMD__SHIFT 0x1
+#define UVD_GPCOM_VCPU_CMD__CMD_SOURCE_MASK 0x80000000
+#define UVD_GPCOM_VCPU_CMD__CMD_SOURCE__SHIFT 0x1f
+#define UVD_GPCOM_VCPU_DATA0__DATA0_MASK 0xffffffff
+#define UVD_GPCOM_VCPU_DATA0__DATA0__SHIFT 0x0
+#define UVD_GPCOM_VCPU_DATA1__DATA1_MASK 0xffffffff
+#define UVD_GPCOM_VCPU_DATA1__DATA1__SHIFT 0x0
+#define UVD_ENGINE_CNTL__ENGINE_START_MASK 0x1
+#define UVD_ENGINE_CNTL__ENGINE_START__SHIFT 0x0
+#define UVD_ENGINE_CNTL__ENGINE_START_MODE_MASK 0x2
+#define UVD_ENGINE_CNTL__ENGINE_START_MODE__SHIFT 0x1
+#define UVD_UDEC_ADDR_CONFIG__NUM_PIPES_MASK 0x7
+#define UVD_UDEC_ADDR_CONFIG__NUM_PIPES__SHIFT 0x0
+#define UVD_UDEC_ADDR_CONFIG__PIPE_INTERLEAVE_SIZE_MASK 0x70
+#define UVD_UDEC_ADDR_CONFIG__PIPE_INTERLEAVE_SIZE__SHIFT 0x4
+#define UVD_UDEC_ADDR_CONFIG__BANK_INTERLEAVE_SIZE_MASK 0x700
+#define UVD_UDEC_ADDR_CONFIG__BANK_INTERLEAVE_SIZE__SHIFT 0x8
+#define UVD_UDEC_ADDR_CONFIG__NUM_SHADER_ENGINES_MASK 0x3000
+#define UVD_UDEC_ADDR_CONFIG__NUM_SHADER_ENGINES__SHIFT 0xc
+#define UVD_UDEC_ADDR_CONFIG__SHADER_ENGINE_TILE_SIZE_MASK 0x70000
+#define UVD_UDEC_ADDR_CONFIG__SHADER_ENGINE_TILE_SIZE__SHIFT 0x10
+#define UVD_UDEC_ADDR_CONFIG__NUM_GPUS_MASK 0x700000
+#define UVD_UDEC_ADDR_CONFIG__NUM_GPUS__SHIFT 0x14
+#define UVD_UDEC_ADDR_CONFIG__MULTI_GPU_TILE_SIZE_MASK 0x3000000
+#define UVD_UDEC_ADDR_CONFIG__MULTI_GPU_TILE_SIZE__SHIFT 0x18
+#define UVD_UDEC_ADDR_CONFIG__ROW_SIZE_MASK 0x30000000
+#define UVD_UDEC_ADDR_CONFIG__ROW_SIZE__SHIFT 0x1c
+#define UVD_UDEC_ADDR_CONFIG__NUM_LOWER_PIPES_MASK 0x40000000
+#define UVD_UDEC_ADDR_CONFIG__NUM_LOWER_PIPES__SHIFT 0x1e
+#define UVD_UDEC_DB_ADDR_CONFIG__NUM_PIPES_MASK 0x7
+#define UVD_UDEC_DB_ADDR_CONFIG__NUM_PIPES__SHIFT 0x0
+#define UVD_UDEC_DB_ADDR_CONFIG__PIPE_INTERLEAVE_SIZE_MASK 0x70
+#define UVD_UDEC_DB_ADDR_CONFIG__PIPE_INTERLEAVE_SIZE__SHIFT 0x4
+#define UVD_UDEC_DB_ADDR_CONFIG__BANK_INTERLEAVE_SIZE_MASK 0x700
+#define UVD_UDEC_DB_ADDR_CONFIG__BANK_INTERLEAVE_SIZE__SHIFT 0x8
+#define UVD_UDEC_DB_ADDR_CONFIG__NUM_SHADER_ENGINES_MASK 0x3000
+#define UVD_UDEC_DB_ADDR_CONFIG__NUM_SHADER_ENGINES__SHIFT 0xc
+#define UVD_UDEC_DB_ADDR_CONFIG__SHADER_ENGINE_TILE_SIZE_MASK 0x70000
+#define UVD_UDEC_DB_ADDR_CONFIG__SHADER_ENGINE_TILE_SIZE__SHIFT 0x10
+#define UVD_UDEC_DB_ADDR_CONFIG__NUM_GPUS_MASK 0x700000
+#define UVD_UDEC_DB_ADDR_CONFIG__NUM_GPUS__SHIFT 0x14
+#define UVD_UDEC_DB_ADDR_CONFIG__MULTI_GPU_TILE_SIZE_MASK 0x3000000
+#define UVD_UDEC_DB_ADDR_CONFIG__MULTI_GPU_TILE_SIZE__SHIFT 0x18
+#define UVD_UDEC_DB_ADDR_CONFIG__ROW_SIZE_MASK 0x30000000
+#define UVD_UDEC_DB_ADDR_CONFIG__ROW_SIZE__SHIFT 0x1c
+#define UVD_UDEC_DB_ADDR_CONFIG__NUM_LOWER_PIPES_MASK 0x40000000
+#define UVD_UDEC_DB_ADDR_CONFIG__NUM_LOWER_PIPES__SHIFT 0x1e
+#define UVD_UDEC_DBW_ADDR_CONFIG__NUM_PIPES_MASK 0x7
+#define UVD_UDEC_DBW_ADDR_CONFIG__NUM_PIPES__SHIFT 0x0
+#define UVD_UDEC_DBW_ADDR_CONFIG__PIPE_INTERLEAVE_SIZE_MASK 0x70
+#define UVD_UDEC_DBW_ADDR_CONFIG__PIPE_INTERLEAVE_SIZE__SHIFT 0x4
+#define UVD_UDEC_DBW_ADDR_CONFIG__BANK_INTERLEAVE_SIZE_MASK 0x700
+#define UVD_UDEC_DBW_ADDR_CONFIG__BANK_INTERLEAVE_SIZE__SHIFT 0x8
+#define UVD_UDEC_DBW_ADDR_CONFIG__NUM_SHADER_ENGINES_MASK 0x3000
+#define UVD_UDEC_DBW_ADDR_CONFIG__NUM_SHADER_ENGINES__SHIFT 0xc
+#define UVD_UDEC_DBW_ADDR_CONFIG__SHADER_ENGINE_TILE_SIZE_MASK 0x70000
+#define UVD_UDEC_DBW_ADDR_CONFIG__SHADER_ENGINE_TILE_SIZE__SHIFT 0x10
+#define UVD_UDEC_DBW_ADDR_CONFIG__NUM_GPUS_MASK 0x700000
+#define UVD_UDEC_DBW_ADDR_CONFIG__NUM_GPUS__SHIFT 0x14
+#define UVD_UDEC_DBW_ADDR_CONFIG__MULTI_GPU_TILE_SIZE_MASK 0x3000000
+#define UVD_UDEC_DBW_ADDR_CONFIG__MULTI_GPU_TILE_SIZE__SHIFT 0x18
+#define UVD_UDEC_DBW_ADDR_CONFIG__ROW_SIZE_MASK 0x30000000
+#define UVD_UDEC_DBW_ADDR_CONFIG__ROW_SIZE__SHIFT 0x1c
+#define UVD_UDEC_DBW_ADDR_CONFIG__NUM_LOWER_PIPES_MASK 0x40000000
+#define UVD_UDEC_DBW_ADDR_CONFIG__NUM_LOWER_PIPES__SHIFT 0x1e
+#define UVD_SEMA_CNTL__SEMAPHORE_EN_MASK 0x1
+#define UVD_SEMA_CNTL__SEMAPHORE_EN__SHIFT 0x0
+#define UVD_SEMA_CNTL__ADVANCED_MODE_DIS_MASK 0x2
+#define UVD_SEMA_CNTL__ADVANCED_MODE_DIS__SHIFT 0x1
+#define UVD_LMI_EXT40_ADDR__ADDR_MASK 0xff
+#define UVD_LMI_EXT40_ADDR__ADDR__SHIFT 0x0
+#define UVD_LMI_EXT40_ADDR__INDEX_MASK 0x1f0000
+#define UVD_LMI_EXT40_ADDR__INDEX__SHIFT 0x10
+#define UVD_LMI_EXT40_ADDR__WRITE_ADDR_MASK 0x80000000
+#define UVD_LMI_EXT40_ADDR__WRITE_ADDR__SHIFT 0x1f
+#define UVD_CTX_INDEX__INDEX_MASK 0x1ff
+#define UVD_CTX_INDEX__INDEX__SHIFT 0x0
+#define UVD_CTX_DATA__DATA_MASK 0xffffffff
+#define UVD_CTX_DATA__DATA__SHIFT 0x0
+#define UVD_CGC_GATE__SYS_MASK 0x1
+#define UVD_CGC_GATE__SYS__SHIFT 0x0
+#define UVD_CGC_GATE__UDEC_MASK 0x2
+#define UVD_CGC_GATE__UDEC__SHIFT 0x1
+#define UVD_CGC_GATE__MPEG2_MASK 0x4
+#define UVD_CGC_GATE__MPEG2__SHIFT 0x2
+#define UVD_CGC_GATE__REGS_MASK 0x8
+#define UVD_CGC_GATE__REGS__SHIFT 0x3
+#define UVD_CGC_GATE__RBC_MASK 0x10
+#define UVD_CGC_GATE__RBC__SHIFT 0x4
+#define UVD_CGC_GATE__LMI_MC_MASK 0x20
+#define UVD_CGC_GATE__LMI_MC__SHIFT 0x5
+#define UVD_CGC_GATE__LMI_UMC_MASK 0x40
+#define UVD_CGC_GATE__LMI_UMC__SHIFT 0x6
+#define UVD_CGC_GATE__IDCT_MASK 0x80
+#define UVD_CGC_GATE__IDCT__SHIFT 0x7
+#define UVD_CGC_GATE__MPRD_MASK 0x100
+#define UVD_CGC_GATE__MPRD__SHIFT 0x8
+#define UVD_CGC_GATE__MPC_MASK 0x200
+#define UVD_CGC_GATE__MPC__SHIFT 0x9
+#define UVD_CGC_GATE__LBSI_MASK 0x400
+#define UVD_CGC_GATE__LBSI__SHIFT 0xa
+#define UVD_CGC_GATE__LRBBM_MASK 0x800
+#define UVD_CGC_GATE__LRBBM__SHIFT 0xb
+#define UVD_CGC_GATE__UDEC_RE_MASK 0x1000
+#define UVD_CGC_GATE__UDEC_RE__SHIFT 0xc
+#define UVD_CGC_GATE__UDEC_CM_MASK 0x2000
+#define UVD_CGC_GATE__UDEC_CM__SHIFT 0xd
+#define UVD_CGC_GATE__UDEC_IT_MASK 0x4000
+#define UVD_CGC_GATE__UDEC_IT__SHIFT 0xe
+#define UVD_CGC_GATE__UDEC_DB_MASK 0x8000
+#define UVD_CGC_GATE__UDEC_DB__SHIFT 0xf
+#define UVD_CGC_GATE__UDEC_MP_MASK 0x10000
+#define UVD_CGC_GATE__UDEC_MP__SHIFT 0x10
+#define UVD_CGC_GATE__WCB_MASK 0x20000
+#define UVD_CGC_GATE__WCB__SHIFT 0x11
+#define UVD_CGC_GATE__VCPU_MASK 0x40000
+#define UVD_CGC_GATE__VCPU__SHIFT 0x12
+#define UVD_CGC_GATE__SCPU_MASK 0x80000
+#define UVD_CGC_GATE__SCPU__SHIFT 0x13
+#define UVD_CGC_STATUS__SYS_SCLK_MASK 0x1
+#define UVD_CGC_STATUS__SYS_SCLK__SHIFT 0x0
+#define UVD_CGC_STATUS__SYS_DCLK_MASK 0x2
+#define UVD_CGC_STATUS__SYS_DCLK__SHIFT 0x1
+#define UVD_CGC_STATUS__SYS_VCLK_MASK 0x4
+#define UVD_CGC_STATUS__SYS_VCLK__SHIFT 0x2
+#define UVD_CGC_STATUS__UDEC_SCLK_MASK 0x8
+#define UVD_CGC_STATUS__UDEC_SCLK__SHIFT 0x3
+#define UVD_CGC_STATUS__UDEC_DCLK_MASK 0x10
+#define UVD_CGC_STATUS__UDEC_DCLK__SHIFT 0x4
+#define UVD_CGC_STATUS__UDEC_VCLK_MASK 0x20
+#define UVD_CGC_STATUS__UDEC_VCLK__SHIFT 0x5
+#define UVD_CGC_STATUS__MPEG2_SCLK_MASK 0x40
+#define UVD_CGC_STATUS__MPEG2_SCLK__SHIFT 0x6
+#define UVD_CGC_STATUS__MPEG2_DCLK_MASK 0x80
+#define UVD_CGC_STATUS__MPEG2_DCLK__SHIFT 0x7
+#define UVD_CGC_STATUS__MPEG2_VCLK_MASK 0x100
+#define UVD_CGC_STATUS__MPEG2_VCLK__SHIFT 0x8
+#define UVD_CGC_STATUS__REGS_SCLK_MASK 0x200
+#define UVD_CGC_STATUS__REGS_SCLK__SHIFT 0x9
+#define UVD_CGC_STATUS__REGS_VCLK_MASK 0x400
+#define UVD_CGC_STATUS__REGS_VCLK__SHIFT 0xa
+#define UVD_CGC_STATUS__RBC_SCLK_MASK 0x800
+#define UVD_CGC_STATUS__RBC_SCLK__SHIFT 0xb
+#define UVD_CGC_STATUS__LMI_MC_SCLK_MASK 0x1000
+#define UVD_CGC_STATUS__LMI_MC_SCLK__SHIFT 0xc
+#define UVD_CGC_STATUS__LMI_UMC_SCLK_MASK 0x2000
+#define UVD_CGC_STATUS__LMI_UMC_SCLK__SHIFT 0xd
+#define UVD_CGC_STATUS__IDCT_SCLK_MASK 0x4000
+#define UVD_CGC_STATUS__IDCT_SCLK__SHIFT 0xe
+#define UVD_CGC_STATUS__IDCT_VCLK_MASK 0x8000
+#define UVD_CGC_STATUS__IDCT_VCLK__SHIFT 0xf
+#define UVD_CGC_STATUS__MPRD_SCLK_MASK 0x10000
+#define UVD_CGC_STATUS__MPRD_SCLK__SHIFT 0x10
+#define UVD_CGC_STATUS__MPRD_DCLK_MASK 0x20000
+#define UVD_CGC_STATUS__MPRD_DCLK__SHIFT 0x11
+#define UVD_CGC_STATUS__MPRD_VCLK_MASK 0x40000
+#define UVD_CGC_STATUS__MPRD_VCLK__SHIFT 0x12
+#define UVD_CGC_STATUS__MPC_SCLK_MASK 0x80000
+#define UVD_CGC_STATUS__MPC_SCLK__SHIFT 0x13
+#define UVD_CGC_STATUS__MPC_DCLK_MASK 0x100000
+#define UVD_CGC_STATUS__MPC_DCLK__SHIFT 0x14
+#define UVD_CGC_STATUS__LBSI_SCLK_MASK 0x200000
+#define UVD_CGC_STATUS__LBSI_SCLK__SHIFT 0x15
+#define UVD_CGC_STATUS__LBSI_VCLK_MASK 0x400000
+#define UVD_CGC_STATUS__LBSI_VCLK__SHIFT 0x16
+#define UVD_CGC_STATUS__LRBBM_SCLK_MASK 0x800000
+#define UVD_CGC_STATUS__LRBBM_SCLK__SHIFT 0x17
+#define UVD_CGC_STATUS__WCB_SCLK_MASK 0x1000000
+#define UVD_CGC_STATUS__WCB_SCLK__SHIFT 0x18
+#define UVD_CGC_STATUS__VCPU_SCLK_MASK 0x2000000
+#define UVD_CGC_STATUS__VCPU_SCLK__SHIFT 0x19
+#define UVD_CGC_STATUS__VCPU_VCLK_MASK 0x4000000
+#define UVD_CGC_STATUS__VCPU_VCLK__SHIFT 0x1a
+#define UVD_CGC_STATUS__SCPU_SCLK_MASK 0x8000000
+#define UVD_CGC_STATUS__SCPU_SCLK__SHIFT 0x1b
+#define UVD_CGC_STATUS__SCPU_VCLK_MASK 0x10000000
+#define UVD_CGC_STATUS__SCPU_VCLK__SHIFT 0x1c
+#define UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK 0x1
+#define UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT 0x0
+#define UVD_CGC_CTRL__CLK_GATE_DLY_TIMER_MASK 0x3c
+#define UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT 0x2
+#define UVD_CGC_CTRL__CLK_OFF_DELAY_MASK 0x7c0
+#define UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT 0x6
+#define UVD_CGC_CTRL__UDEC_RE_MODE_MASK 0x800
+#define UVD_CGC_CTRL__UDEC_RE_MODE__SHIFT 0xb
+#define UVD_CGC_CTRL__UDEC_CM_MODE_MASK 0x1000
+#define UVD_CGC_CTRL__UDEC_CM_MODE__SHIFT 0xc
+#define UVD_CGC_CTRL__UDEC_IT_MODE_MASK 0x2000
+#define UVD_CGC_CTRL__UDEC_IT_MODE__SHIFT 0xd
+#define UVD_CGC_CTRL__UDEC_DB_MODE_MASK 0x4000
+#define UVD_CGC_CTRL__UDEC_DB_MODE__SHIFT 0xe
+#define UVD_CGC_CTRL__UDEC_MP_MODE_MASK 0x8000
+#define UVD_CGC_CTRL__UDEC_MP_MODE__SHIFT 0xf
+#define UVD_CGC_CTRL__SYS_MODE_MASK 0x10000
+#define UVD_CGC_CTRL__SYS_MODE__SHIFT 0x10
+#define UVD_CGC_CTRL__UDEC_MODE_MASK 0x20000
+#define UVD_CGC_CTRL__UDEC_MODE__SHIFT 0x11
+#define UVD_CGC_CTRL__MPEG2_MODE_MASK 0x40000
+#define UVD_CGC_CTRL__MPEG2_MODE__SHIFT 0x12
+#define UVD_CGC_CTRL__REGS_MODE_MASK 0x80000
+#define UVD_CGC_CTRL__REGS_MODE__SHIFT 0x13
+#define UVD_CGC_CTRL__RBC_MODE_MASK 0x100000
+#define UVD_CGC_CTRL__RBC_MODE__SHIFT 0x14
+#define UVD_CGC_CTRL__LMI_MC_MODE_MASK 0x200000
+#define UVD_CGC_CTRL__LMI_MC_MODE__SHIFT 0x15
+#define UVD_CGC_CTRL__LMI_UMC_MODE_MASK 0x400000
+#define UVD_CGC_CTRL__LMI_UMC_MODE__SHIFT 0x16
+#define UVD_CGC_CTRL__IDCT_MODE_MASK 0x800000
+#define UVD_CGC_CTRL__IDCT_MODE__SHIFT 0x17
+#define UVD_CGC_CTRL__MPRD_MODE_MASK 0x1000000
+#define UVD_CGC_CTRL__MPRD_MODE__SHIFT 0x18
+#define UVD_CGC_CTRL__MPC_MODE_MASK 0x2000000
+#define UVD_CGC_CTRL__MPC_MODE__SHIFT 0x19
+#define UVD_CGC_CTRL__LBSI_MODE_MASK 0x4000000
+#define UVD_CGC_CTRL__LBSI_MODE__SHIFT 0x1a
+#define UVD_CGC_CTRL__LRBBM_MODE_MASK 0x8000000
+#define UVD_CGC_CTRL__LRBBM_MODE__SHIFT 0x1b
+#define UVD_CGC_CTRL__WCB_MODE_MASK 0x10000000
+#define UVD_CGC_CTRL__WCB_MODE__SHIFT 0x1c
+#define UVD_CGC_CTRL__VCPU_MODE_MASK 0x20000000
+#define UVD_CGC_CTRL__VCPU_MODE__SHIFT 0x1d
+#define UVD_CGC_CTRL__SCPU_MODE_MASK 0x40000000
+#define UVD_CGC_CTRL__SCPU_MODE__SHIFT 0x1e
+#define UVD_CGC_UDEC_STATUS__RE_SCLK_MASK 0x1
+#define UVD_CGC_UDEC_STATUS__RE_SCLK__SHIFT 0x0
+#define UVD_CGC_UDEC_STATUS__RE_DCLK_MASK 0x2
+#define UVD_CGC_UDEC_STATUS__RE_DCLK__SHIFT 0x1
+#define UVD_CGC_UDEC_STATUS__RE_VCLK_MASK 0x4
+#define UVD_CGC_UDEC_STATUS__RE_VCLK__SHIFT 0x2
+#define UVD_CGC_UDEC_STATUS__CM_SCLK_MASK 0x8
+#define UVD_CGC_UDEC_STATUS__CM_SCLK__SHIFT 0x3
+#define UVD_CGC_UDEC_STATUS__CM_DCLK_MASK 0x10
+#define UVD_CGC_UDEC_STATUS__CM_DCLK__SHIFT 0x4
+#define UVD_CGC_UDEC_STATUS__CM_VCLK_MASK 0x20
+#define UVD_CGC_UDEC_STATUS__CM_VCLK__SHIFT 0x5
+#define UVD_CGC_UDEC_STATUS__IT_SCLK_MASK 0x40
+#define UVD_CGC_UDEC_STATUS__IT_SCLK__SHIFT 0x6
+#define UVD_CGC_UDEC_STATUS__IT_DCLK_MASK 0x80
+#define UVD_CGC_UDEC_STATUS__IT_DCLK__SHIFT 0x7
+#define UVD_CGC_UDEC_STATUS__IT_VCLK_MASK 0x100
+#define UVD_CGC_UDEC_STATUS__IT_VCLK__SHIFT 0x8
+#define UVD_CGC_UDEC_STATUS__DB_SCLK_MASK 0x200
+#define UVD_CGC_UDEC_STATUS__DB_SCLK__SHIFT 0x9
+#define UVD_CGC_UDEC_STATUS__DB_DCLK_MASK 0x400
+#define UVD_CGC_UDEC_STATUS__DB_DCLK__SHIFT 0xa
+#define UVD_CGC_UDEC_STATUS__DB_VCLK_MASK 0x800
+#define UVD_CGC_UDEC_STATUS__DB_VCLK__SHIFT 0xb
+#define UVD_CGC_UDEC_STATUS__MP_SCLK_MASK 0x1000
+#define UVD_CGC_UDEC_STATUS__MP_SCLK__SHIFT 0xc
+#define UVD_CGC_UDEC_STATUS__MP_DCLK_MASK 0x2000
+#define UVD_CGC_UDEC_STATUS__MP_DCLK__SHIFT 0xd
+#define UVD_CGC_UDEC_STATUS__MP_VCLK_MASK 0x4000
+#define UVD_CGC_UDEC_STATUS__MP_VCLK__SHIFT 0xe
+#define UVD_LMI_CTRL2__SPH_DIS_MASK 0x1
+#define UVD_LMI_CTRL2__SPH_DIS__SHIFT 0x0
+#define UVD_LMI_CTRL2__STALL_ARB_MASK 0x2
+#define UVD_LMI_CTRL2__STALL_ARB__SHIFT 0x1
+#define UVD_LMI_CTRL2__ASSERT_UMC_URGENT_MASK 0x4
+#define UVD_LMI_CTRL2__ASSERT_UMC_URGENT__SHIFT 0x2
+#define UVD_LMI_CTRL2__MASK_UMC_URGENT_MASK 0x8
+#define UVD_LMI_CTRL2__MASK_UMC_URGENT__SHIFT 0x3
+#define UVD_LMI_CTRL2__MCIF_WR_WATERMARK_MASK 0x70
+#define UVD_LMI_CTRL2__MCIF_WR_WATERMARK__SHIFT 0x4
+#define UVD_LMI_CTRL2__DRCITF_BUBBLE_FIX_DIS_MASK 0x80
+#define UVD_LMI_CTRL2__DRCITF_BUBBLE_FIX_DIS__SHIFT 0x7
+#define UVD_LMI_CTRL2__STALL_ARB_UMC_MASK 0x100
+#define UVD_LMI_CTRL2__STALL_ARB_UMC__SHIFT 0x8
+#define UVD_LMI_CTRL2__MC_READ_ID_SEL_MASK 0x600
+#define UVD_LMI_CTRL2__MC_READ_ID_SEL__SHIFT 0x9
+#define UVD_LMI_CTRL2__MC_WRITE_ID_SEL_MASK 0x1800
+#define UVD_LMI_CTRL2__MC_WRITE_ID_SEL__SHIFT 0xb
+#define UVD_LMI_CTRL2__VCPU_NC0_EXT_EN_MASK 0x2000
+#define UVD_LMI_CTRL2__VCPU_NC0_EXT_EN__SHIFT 0xd
+#define UVD_LMI_CTRL2__VCPU_NC1_EXT_EN_MASK 0x4000
+#define UVD_LMI_CTRL2__VCPU_NC1_EXT_EN__SHIFT 0xe
+#define UVD_LMI_CTRL2__SPU_EXTRA_CID_EN_MASK 0x8000
+#define UVD_LMI_CTRL2__SPU_EXTRA_CID_EN__SHIFT 0xf
+#define UVD_MASTINT_EN__OVERRUN_RST_MASK 0x1
+#define UVD_MASTINT_EN__OVERRUN_RST__SHIFT 0x0
+#define UVD_MASTINT_EN__VCPU_EN_MASK 0x2
+#define UVD_MASTINT_EN__VCPU_EN__SHIFT 0x1
+#define UVD_MASTINT_EN__SYS_EN_MASK 0x4
+#define UVD_MASTINT_EN__SYS_EN__SHIFT 0x2
+#define UVD_MASTINT_EN__INT_OVERRUN_MASK 0x7ffff0
+#define UVD_MASTINT_EN__INT_OVERRUN__SHIFT 0x4
+#define UVD_LMI_ADDR_EXT__VCPU_ADDR_EXT_MASK 0xf
+#define UVD_LMI_ADDR_EXT__VCPU_ADDR_EXT__SHIFT 0x0
+#define UVD_LMI_ADDR_EXT__CM_ADDR_EXT_MASK 0xf0
+#define UVD_LMI_ADDR_EXT__CM_ADDR_EXT__SHIFT 0x4
+#define UVD_LMI_ADDR_EXT__IT_ADDR_EXT_MASK 0xf00
+#define UVD_LMI_ADDR_EXT__IT_ADDR_EXT__SHIFT 0x8
+#define UVD_LMI_ADDR_EXT__VCPU_VM_ADDR_EXT_MASK 0xf000
+#define UVD_LMI_ADDR_EXT__VCPU_VM_ADDR_EXT__SHIFT 0xc
+#define UVD_LMI_ADDR_EXT__RE_ADDR_EXT_MASK 0xf0000
+#define UVD_LMI_ADDR_EXT__RE_ADDR_EXT__SHIFT 0x10
+#define UVD_LMI_ADDR_EXT__MP_ADDR_EXT_MASK 0xf00000
+#define UVD_LMI_ADDR_EXT__MP_ADDR_EXT__SHIFT 0x14
+#define UVD_LMI_ADDR_EXT__VCPU_NC0_ADDR_EXT_MASK 0xf000000
+#define UVD_LMI_ADDR_EXT__VCPU_NC0_ADDR_EXT__SHIFT 0x18
+#define UVD_LMI_ADDR_EXT__VCPU_NC1_ADDR_EXT_MASK 0xf0000000
+#define UVD_LMI_ADDR_EXT__VCPU_NC1_ADDR_EXT__SHIFT 0x1c
+#define UVD_LMI_CTRL__WRITE_CLEAN_TIMER_MASK 0xff
+#define UVD_LMI_CTRL__WRITE_CLEAN_TIMER__SHIFT 0x0
+#define UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK 0x100
+#define UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN__SHIFT 0x8
+#define UVD_LMI_CTRL__REQ_MODE_MASK 0x200
+#define UVD_LMI_CTRL__REQ_MODE__SHIFT 0x9
+#define UVD_LMI_CTRL__ASSERT_MC_URGENT_MASK 0x800
+#define UVD_LMI_CTRL__ASSERT_MC_URGENT__SHIFT 0xb
+#define UVD_LMI_CTRL__MASK_MC_URGENT_MASK 0x1000
+#define UVD_LMI_CTRL__MASK_MC_URGENT__SHIFT 0xc
+#define UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK 0x2000
+#define UVD_LMI_CTRL__DATA_COHERENCY_EN__SHIFT 0xd
+#define UVD_LMI_CTRL__CRC_RESET_MASK 0x4000
+#define UVD_LMI_CTRL__CRC_RESET__SHIFT 0xe
+#define UVD_LMI_CTRL__CRC_SEL_MASK 0xf8000
+#define UVD_LMI_CTRL__CRC_SEL__SHIFT 0xf
+#define UVD_LMI_CTRL__DISABLE_ON_FWV_FAIL_MASK 0x100000
+#define UVD_LMI_CTRL__DISABLE_ON_FWV_FAIL__SHIFT 0x14
+#define UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK 0x200000
+#define UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN__SHIFT 0x15
+#define UVD_LMI_CTRL__CM_DATA_COHERENCY_EN_MASK 0x400000
+#define UVD_LMI_CTRL__CM_DATA_COHERENCY_EN__SHIFT 0x16
+#define UVD_LMI_CTRL__DB_DB_DATA_COHERENCY_EN_MASK 0x800000
+#define UVD_LMI_CTRL__DB_DB_DATA_COHERENCY_EN__SHIFT 0x17
+#define UVD_LMI_CTRL__DB_IT_DATA_COHERENCY_EN_MASK 0x1000000
+#define UVD_LMI_CTRL__DB_IT_DATA_COHERENCY_EN__SHIFT 0x18
+#define UVD_LMI_CTRL__IT_IT_DATA_COHERENCY_EN_MASK 0x2000000
+#define UVD_LMI_CTRL__IT_IT_DATA_COHERENCY_EN__SHIFT 0x19
+#define UVD_LMI_CTRL__MIF_MIF_DATA_COHERENCY_EN_MASK 0x4000000
+#define UVD_LMI_CTRL__MIF_MIF_DATA_COHERENCY_EN__SHIFT 0x1a
+#define UVD_LMI_CTRL__RFU_MASK 0xf8000000
+#define UVD_LMI_CTRL__RFU__SHIFT 0x1b
+#define UVD_LMI_STATUS__READ_CLEAN_MASK 0x1
+#define UVD_LMI_STATUS__READ_CLEAN__SHIFT 0x0
+#define UVD_LMI_STATUS__WRITE_CLEAN_MASK 0x2
+#define UVD_LMI_STATUS__WRITE_CLEAN__SHIFT 0x1
+#define UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK 0x4
+#define UVD_LMI_STATUS__WRITE_CLEAN_RAW__SHIFT 0x2
+#define UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK 0x8
+#define UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN__SHIFT 0x3
+#define UVD_LMI_STATUS__UMC_READ_CLEAN_MASK 0x10
+#define UVD_LMI_STATUS__UMC_READ_CLEAN__SHIFT 0x4
+#define UVD_LMI_STATUS__UMC_WRITE_CLEAN_MASK 0x20
+#define UVD_LMI_STATUS__UMC_WRITE_CLEAN__SHIFT 0x5
+#define UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK 0x40
+#define UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW__SHIFT 0x6
+#define UVD_LMI_STATUS__PENDING_UVD_MC_WRITE_MASK 0x80
+#define UVD_LMI_STATUS__PENDING_UVD_MC_WRITE__SHIFT 0x7
+#define UVD_LMI_STATUS__READ_CLEAN_RAW_MASK 0x100
+#define UVD_LMI_STATUS__READ_CLEAN_RAW__SHIFT 0x8
+#define UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK 0x200
+#define UVD_LMI_STATUS__UMC_READ_CLEAN_RAW__SHIFT 0x9
+#define UVD_LMI_STATUS__UMC_UVD_IDLE_MASK 0x400
+#define UVD_LMI_STATUS__UMC_UVD_IDLE__SHIFT 0xa
+#define UVD_LMI_STATUS__UMC_AVP_IDLE_MASK 0x800
+#define UVD_LMI_STATUS__UMC_AVP_IDLE__SHIFT 0xb
+#define UVD_LMI_STATUS__ADP_MC_READ_CLEAN_MASK 0x1000
+#define UVD_LMI_STATUS__ADP_MC_READ_CLEAN__SHIFT 0xc
+#define UVD_LMI_STATUS__ADP_UMC_READ_CLEAN_MASK 0x2000
+#define UVD_LMI_STATUS__ADP_UMC_READ_CLEAN__SHIFT 0xd
+#define UVD_LMI_SWAP_CNTL__RB_MC_SWAP_MASK 0x3
+#define UVD_LMI_SWAP_CNTL__RB_MC_SWAP__SHIFT 0x0
+#define UVD_LMI_SWAP_CNTL__IB_MC_SWAP_MASK 0xc
+#define UVD_LMI_SWAP_CNTL__IB_MC_SWAP__SHIFT 0x2
+#define UVD_LMI_SWAP_CNTL__RB_RPTR_MC_SWAP_MASK 0x30
+#define UVD_LMI_SWAP_CNTL__RB_RPTR_MC_SWAP__SHIFT 0x4
+#define UVD_LMI_SWAP_CNTL__VCPU_R_MC_SWAP_MASK 0xc0
+#define UVD_LMI_SWAP_CNTL__VCPU_R_MC_SWAP__SHIFT 0x6
+#define UVD_LMI_SWAP_CNTL__VCPU_W_MC_SWAP_MASK 0x300
+#define UVD_LMI_SWAP_CNTL__VCPU_W_MC_SWAP__SHIFT 0x8
+#define UVD_LMI_SWAP_CNTL__CM_MC_SWAP_MASK 0xc00
+#define UVD_LMI_SWAP_CNTL__CM_MC_SWAP__SHIFT 0xa
+#define UVD_LMI_SWAP_CNTL__IT_MC_SWAP_MASK 0x3000
+#define UVD_LMI_SWAP_CNTL__IT_MC_SWAP__SHIFT 0xc
+#define UVD_LMI_SWAP_CNTL__DB_R_MC_SWAP_MASK 0xc000
+#define UVD_LMI_SWAP_CNTL__DB_R_MC_SWAP__SHIFT 0xe
+#define UVD_LMI_SWAP_CNTL__DB_W_MC_SWAP_MASK 0x30000
+#define UVD_LMI_SWAP_CNTL__DB_W_MC_SWAP__SHIFT 0x10
+#define UVD_LMI_SWAP_CNTL__CSM_MC_SWAP_MASK 0xc0000
+#define UVD_LMI_SWAP_CNTL__CSM_MC_SWAP__SHIFT 0x12
+#define UVD_LMI_SWAP_CNTL__MP_REF16_MC_SWAP_MASK 0xc00000
+#define UVD_LMI_SWAP_CNTL__MP_REF16_MC_SWAP__SHIFT 0x16
+#define UVD_LMI_SWAP_CNTL__DBW_MC_SWAP_MASK 0x3000000
+#define UVD_LMI_SWAP_CNTL__DBW_MC_SWAP__SHIFT 0x18
+#define UVD_LMI_SWAP_CNTL__RB_WR_MC_SWAP_MASK 0xc000000
+#define UVD_LMI_SWAP_CNTL__RB_WR_MC_SWAP__SHIFT 0x1a
+#define UVD_LMI_SWAP_CNTL__RE_MC_SWAP_MASK 0x30000000
+#define UVD_LMI_SWAP_CNTL__RE_MC_SWAP__SHIFT 0x1c
+#define UVD_LMI_SWAP_CNTL__MP_MC_SWAP_MASK 0xc0000000
+#define UVD_LMI_SWAP_CNTL__MP_MC_SWAP__SHIFT 0x1e
+#define UVD_MP_SWAP_CNTL__MP_REF0_MC_SWAP_MASK 0x3
+#define UVD_MP_SWAP_CNTL__MP_REF0_MC_SWAP__SHIFT 0x0
+#define UVD_MP_SWAP_CNTL__MP_REF1_MC_SWAP_MASK 0xc
+#define UVD_MP_SWAP_CNTL__MP_REF1_MC_SWAP__SHIFT 0x2
+#define UVD_MP_SWAP_CNTL__MP_REF2_MC_SWAP_MASK 0x30
+#define UVD_MP_SWAP_CNTL__MP_REF2_MC_SWAP__SHIFT 0x4
+#define UVD_MP_SWAP_CNTL__MP_REF3_MC_SWAP_MASK 0xc0
+#define UVD_MP_SWAP_CNTL__MP_REF3_MC_SWAP__SHIFT 0x6
+#define UVD_MP_SWAP_CNTL__MP_REF4_MC_SWAP_MASK 0x300
+#define UVD_MP_SWAP_CNTL__MP_REF4_MC_SWAP__SHIFT 0x8
+#define UVD_MP_SWAP_CNTL__MP_REF5_MC_SWAP_MASK 0xc00
+#define UVD_MP_SWAP_CNTL__MP_REF5_MC_SWAP__SHIFT 0xa
+#define UVD_MP_SWAP_CNTL__MP_REF6_MC_SWAP_MASK 0x3000
+#define UVD_MP_SWAP_CNTL__MP_REF6_MC_SWAP__SHIFT 0xc
+#define UVD_MP_SWAP_CNTL__MP_REF7_MC_SWAP_MASK 0xc000
+#define UVD_MP_SWAP_CNTL__MP_REF7_MC_SWAP__SHIFT 0xe
+#define UVD_MP_SWAP_CNTL__MP_REF8_MC_SWAP_MASK 0x30000
+#define UVD_MP_SWAP_CNTL__MP_REF8_MC_SWAP__SHIFT 0x10
+#define UVD_MP_SWAP_CNTL__MP_REF9_MC_SWAP_MASK 0xc0000
+#define UVD_MP_SWAP_CNTL__MP_REF9_MC_SWAP__SHIFT 0x12
+#define UVD_MP_SWAP_CNTL__MP_REF10_MC_SWAP_MASK 0x300000
+#define UVD_MP_SWAP_CNTL__MP_REF10_MC_SWAP__SHIFT 0x14
+#define UVD_MP_SWAP_CNTL__MP_REF11_MC_SWAP_MASK 0xc00000
+#define UVD_MP_SWAP_CNTL__MP_REF11_MC_SWAP__SHIFT 0x16
+#define UVD_MP_SWAP_CNTL__MP_REF12_MC_SWAP_MASK 0x3000000
+#define UVD_MP_SWAP_CNTL__MP_REF12_MC_SWAP__SHIFT 0x18
+#define UVD_MP_SWAP_CNTL__MP_REF13_MC_SWAP_MASK 0xc000000
+#define UVD_MP_SWAP_CNTL__MP_REF13_MC_SWAP__SHIFT 0x1a
+#define UVD_MP_SWAP_CNTL__MP_REF14_MC_SWAP_MASK 0x30000000
+#define UVD_MP_SWAP_CNTL__MP_REF14_MC_SWAP__SHIFT 0x1c
+#define UVD_MP_SWAP_CNTL__MP_REF15_MC_SWAP_MASK 0xc0000000
+#define UVD_MP_SWAP_CNTL__MP_REF15_MC_SWAP__SHIFT 0x1e
+#define UVD_MPC_CNTL__REPLACEMENT_MODE_MASK 0x38
+#define UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT 0x3
+#define UVD_MPC_CNTL__PERF_RST_MASK 0x40
+#define UVD_MPC_CNTL__PERF_RST__SHIFT 0x6
+#define UVD_MPC_CNTL__DBG_MUX_MASK 0x700
+#define UVD_MPC_CNTL__DBG_MUX__SHIFT 0x8
+#define UVD_MPC_CNTL__AVE_WEIGHT_MASK 0x30000
+#define UVD_MPC_CNTL__AVE_WEIGHT__SHIFT 0x10
+#define UVD_MPC_CNTL__URGENT_EN_MASK 0x40000
+#define UVD_MPC_CNTL__URGENT_EN__SHIFT 0x12
+#define UVD_MPC_SET_MUXA0__VARA_0_MASK 0x3f
+#define UVD_MPC_SET_MUXA0__VARA_0__SHIFT 0x0
+#define UVD_MPC_SET_MUXA0__VARA_1_MASK 0xfc0
+#define UVD_MPC_SET_MUXA0__VARA_1__SHIFT 0x6
+#define UVD_MPC_SET_MUXA0__VARA_2_MASK 0x3f000
+#define UVD_MPC_SET_MUXA0__VARA_2__SHIFT 0xc
+#define UVD_MPC_SET_MUXA0__VARA_3_MASK 0xfc0000
+#define UVD_MPC_SET_MUXA0__VARA_3__SHIFT 0x12
+#define UVD_MPC_SET_MUXA0__VARA_4_MASK 0x3f000000
+#define UVD_MPC_SET_MUXA0__VARA_4__SHIFT 0x18
+#define UVD_MPC_SET_MUXA1__VARA_5_MASK 0x3f
+#define UVD_MPC_SET_MUXA1__VARA_5__SHIFT 0x0
+#define UVD_MPC_SET_MUXA1__VARA_6_MASK 0xfc0
+#define UVD_MPC_SET_MUXA1__VARA_6__SHIFT 0x6
+#define UVD_MPC_SET_MUXA1__VARA_7_MASK 0x3f000
+#define UVD_MPC_SET_MUXA1__VARA_7__SHIFT 0xc
+#define UVD_MPC_SET_MUXB0__VARB_0_MASK 0x3f
+#define UVD_MPC_SET_MUXB0__VARB_0__SHIFT 0x0
+#define UVD_MPC_SET_MUXB0__VARB_1_MASK 0xfc0
+#define UVD_MPC_SET_MUXB0__VARB_1__SHIFT 0x6
+#define UVD_MPC_SET_MUXB0__VARB_2_MASK 0x3f000
+#define UVD_MPC_SET_MUXB0__VARB_2__SHIFT 0xc
+#define UVD_MPC_SET_MUXB0__VARB_3_MASK 0xfc0000
+#define UVD_MPC_SET_MUXB0__VARB_3__SHIFT 0x12
+#define UVD_MPC_SET_MUXB0__VARB_4_MASK 0x3f000000
+#define UVD_MPC_SET_MUXB0__VARB_4__SHIFT 0x18
+#define UVD_MPC_SET_MUXB1__VARB_5_MASK 0x3f
+#define UVD_MPC_SET_MUXB1__VARB_5__SHIFT 0x0
+#define UVD_MPC_SET_MUXB1__VARB_6_MASK 0xfc0
+#define UVD_MPC_SET_MUXB1__VARB_6__SHIFT 0x6
+#define UVD_MPC_SET_MUXB1__VARB_7_MASK 0x3f000
+#define UVD_MPC_SET_MUXB1__VARB_7__SHIFT 0xc
+#define UVD_MPC_SET_MUX__SET_0_MASK 0x7
+#define UVD_MPC_SET_MUX__SET_0__SHIFT 0x0
+#define UVD_MPC_SET_MUX__SET_1_MASK 0x38
+#define UVD_MPC_SET_MUX__SET_1__SHIFT 0x3
+#define UVD_MPC_SET_MUX__SET_2_MASK 0x1c0
+#define UVD_MPC_SET_MUX__SET_2__SHIFT 0x6
+#define UVD_MPC_SET_ALU__FUNCT_MASK 0x7
+#define UVD_MPC_SET_ALU__FUNCT__SHIFT 0x0
+#define UVD_MPC_SET_ALU__OPERAND_MASK 0xff0
+#define UVD_MPC_SET_ALU__OPERAND__SHIFT 0x4
+#define UVD_VCPU_CACHE_OFFSET0__CACHE_OFFSET0_MASK 0x1ffffff
+#define UVD_VCPU_CACHE_OFFSET0__CACHE_OFFSET0__SHIFT 0x0
+#define UVD_VCPU_CACHE_SIZE0__CACHE_SIZE0_MASK 0x1fffff
+#define UVD_VCPU_CACHE_SIZE0__CACHE_SIZE0__SHIFT 0x0
+#define UVD_VCPU_CACHE_OFFSET1__CACHE_OFFSET1_MASK 0x1ffffff
+#define UVD_VCPU_CACHE_OFFSET1__CACHE_OFFSET1__SHIFT 0x0
+#define UVD_VCPU_CACHE_SIZE1__CACHE_SIZE1_MASK 0x1fffff
+#define UVD_VCPU_CACHE_SIZE1__CACHE_SIZE1__SHIFT 0x0
+#define UVD_VCPU_CACHE_OFFSET2__CACHE_OFFSET2_MASK 0x1ffffff
+#define UVD_VCPU_CACHE_OFFSET2__CACHE_OFFSET2__SHIFT 0x0
+#define UVD_VCPU_CACHE_SIZE2__CACHE_SIZE2_MASK 0x1fffff
+#define UVD_VCPU_CACHE_SIZE2__CACHE_SIZE2__SHIFT 0x0
+#define UVD_VCPU_CNTL__IRQ_ERR_MASK 0xf
+#define UVD_VCPU_CNTL__IRQ_ERR__SHIFT 0x0
+#define UVD_VCPU_CNTL__AXI_MAX_BRST_SIZE_IS_4_MASK 0x10
+#define UVD_VCPU_CNTL__AXI_MAX_BRST_SIZE_IS_4__SHIFT 0x4
+#define UVD_VCPU_CNTL__PMB_ED_ENABLE_MASK 0x20
+#define UVD_VCPU_CNTL__PMB_ED_ENABLE__SHIFT 0x5
+#define UVD_VCPU_CNTL__PMB_SOFT_RESET_MASK 0x40
+#define UVD_VCPU_CNTL__PMB_SOFT_RESET__SHIFT 0x6
+#define UVD_VCPU_CNTL__RBBM_SOFT_RESET_MASK 0x80
+#define UVD_VCPU_CNTL__RBBM_SOFT_RESET__SHIFT 0x7
+#define UVD_VCPU_CNTL__ABORT_REQ_MASK 0x100
+#define UVD_VCPU_CNTL__ABORT_REQ__SHIFT 0x8
+#define UVD_VCPU_CNTL__CLK_EN_MASK 0x200
+#define UVD_VCPU_CNTL__CLK_EN__SHIFT 0x9
+#define UVD_VCPU_CNTL__TRCE_EN_MASK 0x400
+#define UVD_VCPU_CNTL__TRCE_EN__SHIFT 0xa
+#define UVD_VCPU_CNTL__TRCE_MUX_MASK 0x1800
+#define UVD_VCPU_CNTL__TRCE_MUX__SHIFT 0xb
+#define UVD_VCPU_CNTL__DBG_MUX_MASK 0xe000
+#define UVD_VCPU_CNTL__DBG_MUX__SHIFT 0xd
+#define UVD_VCPU_CNTL__JTAG_EN_MASK 0x10000
+#define UVD_VCPU_CNTL__JTAG_EN__SHIFT 0x10
+#define UVD_VCPU_CNTL__CLK_ACTIVE_MASK 0x20000
+#define UVD_VCPU_CNTL__CLK_ACTIVE__SHIFT 0x11
+#define UVD_VCPU_CNTL__TIMEOUT_DIS_MASK 0x40000
+#define UVD_VCPU_CNTL__TIMEOUT_DIS__SHIFT 0x12
+#define UVD_VCPU_CNTL__PRB_TIMEOUT_VAL_MASK 0xff00000
+#define UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT 0x14
+#define UVD_VCPU_CNTL__CABAC_MB_ACC_MASK 0x10000000
+#define UVD_VCPU_CNTL__CABAC_MB_ACC__SHIFT 0x1c
+#define UVD_VCPU_CNTL__ECPU_AM32_EN_MASK 0x20000000
+#define UVD_VCPU_CNTL__ECPU_AM32_EN__SHIFT 0x1d
+#define UVD_VCPU_CNTL__WMV9_EN_MASK 0x40000000
+#define UVD_VCPU_CNTL__WMV9_EN__SHIFT 0x1e
+#define UVD_SOFT_RESET__RBC_SOFT_RESET_MASK 0x1
+#define UVD_SOFT_RESET__RBC_SOFT_RESET__SHIFT 0x0
+#define UVD_SOFT_RESET__LBSI_SOFT_RESET_MASK 0x2
+#define UVD_SOFT_RESET__LBSI_SOFT_RESET__SHIFT 0x1
+#define UVD_SOFT_RESET__LMI_SOFT_RESET_MASK 0x4
+#define UVD_SOFT_RESET__LMI_SOFT_RESET__SHIFT 0x2
+#define UVD_SOFT_RESET__VCPU_SOFT_RESET_MASK 0x8
+#define UVD_SOFT_RESET__VCPU_SOFT_RESET__SHIFT 0x3
+#define UVD_SOFT_RESET__UDEC_SOFT_RESET_MASK 0x10
+#define UVD_SOFT_RESET__UDEC_SOFT_RESET__SHIFT 0x4
+#define UVD_SOFT_RESET__CSM_SOFT_RESET_MASK 0x20
+#define UVD_SOFT_RESET__CSM_SOFT_RESET__SHIFT 0x5
+#define UVD_SOFT_RESET__CXW_SOFT_RESET_MASK 0x40
+#define UVD_SOFT_RESET__CXW_SOFT_RESET__SHIFT 0x6
+#define UVD_SOFT_RESET__TAP_SOFT_RESET_MASK 0x80
+#define UVD_SOFT_RESET__TAP_SOFT_RESET__SHIFT 0x7
+#define UVD_SOFT_RESET__MPC_SOFT_RESET_MASK 0x100
+#define UVD_SOFT_RESET__MPC_SOFT_RESET__SHIFT 0x8
+#define UVD_SOFT_RESET__FWV_SOFT_RESET_MASK 0x200
+#define UVD_SOFT_RESET__FWV_SOFT_RESET__SHIFT 0x9
+#define UVD_SOFT_RESET__IH_SOFT_RESET_MASK 0x400
+#define UVD_SOFT_RESET__IH_SOFT_RESET__SHIFT 0xa
+#define UVD_SOFT_RESET__MPRD_SOFT_RESET_MASK 0x800
+#define UVD_SOFT_RESET__MPRD_SOFT_RESET__SHIFT 0xb
+#define UVD_SOFT_RESET__IDCT_SOFT_RESET_MASK 0x1000
+#define UVD_SOFT_RESET__IDCT_SOFT_RESET__SHIFT 0xc
+#define UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK 0x2000
+#define UVD_SOFT_RESET__LMI_UMC_SOFT_RESET__SHIFT 0xd
+#define UVD_SOFT_RESET__SPH_SOFT_RESET_MASK 0x4000
+#define UVD_SOFT_RESET__SPH_SOFT_RESET__SHIFT 0xe
+#define UVD_SOFT_RESET__MIF_SOFT_RESET_MASK 0x8000
+#define UVD_SOFT_RESET__MIF_SOFT_RESET__SHIFT 0xf
+#define UVD_SOFT_RESET__LCM_SOFT_RESET_MASK 0x10000
+#define UVD_SOFT_RESET__LCM_SOFT_RESET__SHIFT 0x10
+#define UVD_RBC_IB_BASE__IB_BASE_MASK 0xffffffc0
+#define UVD_RBC_IB_BASE__IB_BASE__SHIFT 0x6
+#define UVD_RBC_IB_SIZE__IB_SIZE_MASK 0x7ffff0
+#define UVD_RBC_IB_SIZE__IB_SIZE__SHIFT 0x4
+#define UVD_RBC_RB_BASE__RB_BASE_MASK 0xffffffc0
+#define UVD_RBC_RB_BASE__RB_BASE__SHIFT 0x6
+#define UVD_RBC_RB_RPTR__RB_RPTR_MASK 0x7ffff0
+#define UVD_RBC_RB_RPTR__RB_RPTR__SHIFT 0x4
+#define UVD_RBC_RB_WPTR__RB_WPTR_MASK 0x7ffff0
+#define UVD_RBC_RB_WPTR__RB_WPTR__SHIFT 0x4
+#define UVD_RBC_RB_CNTL__RB_BUFSZ_MASK 0x1f
+#define UVD_RBC_RB_CNTL__RB_BUFSZ__SHIFT 0x0
+#define UVD_RBC_RB_CNTL__RB_BLKSZ_MASK 0x1f00
+#define UVD_RBC_RB_CNTL__RB_BLKSZ__SHIFT 0x8
+#define UVD_RBC_RB_CNTL__RB_NO_FETCH_MASK 0x10000
+#define UVD_RBC_RB_CNTL__RB_NO_FETCH__SHIFT 0x10
+#define UVD_RBC_RB_CNTL__RB_WPTR_POLL_EN_MASK 0x100000
+#define UVD_RBC_RB_CNTL__RB_WPTR_POLL_EN__SHIFT 0x14
+#define UVD_RBC_RB_CNTL__RB_NO_UPDATE_MASK 0x1000000
+#define UVD_RBC_RB_CNTL__RB_NO_UPDATE__SHIFT 0x18
+#define UVD_RBC_RB_CNTL__RB_RPTR_WR_EN_MASK 0x10000000
+#define UVD_RBC_RB_CNTL__RB_RPTR_WR_EN__SHIFT 0x1c
+#define UVD_RBC_RB_RPTR_ADDR__RB_RPTR_ADDR_MASK 0xffffffff
+#define UVD_RBC_RB_RPTR_ADDR__RB_RPTR_ADDR__SHIFT 0x0
+#define UVD_STATUS__RBC_BUSY_MASK 0x1
+#define UVD_STATUS__RBC_BUSY__SHIFT 0x0
+#define UVD_STATUS__VCPU_REPORT_MASK 0xfe
+#define UVD_STATUS__VCPU_REPORT__SHIFT 0x1
+#define UVD_SEMA_TIMEOUT_STATUS__SEMAPHORE_WAIT_INCOMPLETE_TIMEOUT_STAT_MASK 0x1
+#define UVD_SEMA_TIMEOUT_STATUS__SEMAPHORE_WAIT_INCOMPLETE_TIMEOUT_STAT__SHIFT 0x0
+#define UVD_SEMA_TIMEOUT_STATUS__SEMAPHORE_WAIT_FAULT_TIMEOUT_STAT_MASK 0x2
+#define UVD_SEMA_TIMEOUT_STATUS__SEMAPHORE_WAIT_FAULT_TIMEOUT_STAT__SHIFT 0x1
+#define UVD_SEMA_TIMEOUT_STATUS__SEMAPHORE_SIGNAL_INCOMPLETE_TIMEOUT_STAT_MASK 0x4
+#define UVD_SEMA_TIMEOUT_STATUS__SEMAPHORE_SIGNAL_INCOMPLETE_TIMEOUT_STAT__SHIFT 0x2
+#define UVD_SEMA_TIMEOUT_STATUS__SEMAPHORE_TIMEOUT_CLEAR_MASK 0x8
+#define UVD_SEMA_TIMEOUT_STATUS__SEMAPHORE_TIMEOUT_CLEAR__SHIFT 0x3
+#define UVD_SEMA_WAIT_INCOMPLETE_TIMEOUT_CNTL__WAIT_INCOMPLETE_EN_MASK 0x1
+#define UVD_SEMA_WAIT_INCOMPLETE_TIMEOUT_CNTL__WAIT_INCOMPLETE_EN__SHIFT 0x0
+#define UVD_SEMA_WAIT_INCOMPLETE_TIMEOUT_CNTL__WAIT_INCOMPLETE_COUNT_MASK 0x1ffffe
+#define UVD_SEMA_WAIT_INCOMPLETE_TIMEOUT_CNTL__WAIT_INCOMPLETE_COUNT__SHIFT 0x1
+#define UVD_SEMA_WAIT_INCOMPLETE_TIMEOUT_CNTL__RESEND_TIMER_MASK 0x7000000
+#define UVD_SEMA_WAIT_INCOMPLETE_TIMEOUT_CNTL__RESEND_TIMER__SHIFT 0x18
+#define UVD_SEMA_WAIT_FAULT_TIMEOUT_CNTL__WAIT_FAULT_EN_MASK 0x1
+#define UVD_SEMA_WAIT_FAULT_TIMEOUT_CNTL__WAIT_FAULT_EN__SHIFT 0x0
+#define UVD_SEMA_WAIT_FAULT_TIMEOUT_CNTL__WAIT_FAULT_COUNT_MASK 0x1ffffe
+#define UVD_SEMA_WAIT_FAULT_TIMEOUT_CNTL__WAIT_FAULT_COUNT__SHIFT 0x1
+#define UVD_SEMA_WAIT_FAULT_TIMEOUT_CNTL__RESEND_TIMER_MASK 0x7000000
+#define UVD_SEMA_WAIT_FAULT_TIMEOUT_CNTL__RESEND_TIMER__SHIFT 0x18
+#define UVD_SEMA_SIGNAL_INCOMPLETE_TIMEOUT_CNTL__SIGNAL_INCOMPLETE_EN_MASK 0x1
+#define UVD_SEMA_SIGNAL_INCOMPLETE_TIMEOUT_CNTL__SIGNAL_INCOMPLETE_EN__SHIFT 0x0
+#define UVD_SEMA_SIGNAL_INCOMPLETE_TIMEOUT_CNTL__SIGNAL_INCOMPLETE_COUNT_MASK 0x1ffffe
+#define UVD_SEMA_SIGNAL_INCOMPLETE_TIMEOUT_CNTL__SIGNAL_INCOMPLETE_COUNT__SHIFT 0x1
+#define UVD_SEMA_SIGNAL_INCOMPLETE_TIMEOUT_CNTL__RESEND_TIMER_MASK 0x7000000
+#define UVD_SEMA_SIGNAL_INCOMPLETE_TIMEOUT_CNTL__RESEND_TIMER__SHIFT 0x18
+#define UVD_CONTEXT_ID__CONTEXT_ID_MASK 0xffffffff
+#define UVD_CONTEXT_ID__CONTEXT_ID__SHIFT 0x0
+#define UVD_LMI_CACHE_CTRL__IT_EN_MASK 0x1
+#define UVD_LMI_CACHE_CTRL__IT_EN__SHIFT 0x0
+#define UVD_LMI_CACHE_CTRL__IT_FLUSH_MASK 0x2
+#define UVD_LMI_CACHE_CTRL__IT_FLUSH__SHIFT 0x1
+#define UVD_LMI_CACHE_CTRL__CM_EN_MASK 0x4
+#define UVD_LMI_CACHE_CTRL__CM_EN__SHIFT 0x2
+#define UVD_LMI_CACHE_CTRL__CM_FLUSH_MASK 0x8
+#define UVD_LMI_CACHE_CTRL__CM_FLUSH__SHIFT 0x3
+#define UVD_LMI_CACHE_CTRL__VCPU_EN_MASK 0x10
+#define UVD_LMI_CACHE_CTRL__VCPU_EN__SHIFT 0x4
+#define UVD_LMI_CACHE_CTRL__VCPU_FLUSH_MASK 0x20
+#define UVD_LMI_CACHE_CTRL__VCPU_FLUSH__SHIFT 0x5
+#define UVD_LMI_SWAP_CNTL2__SCPU_R_MC_SWAP_MASK 0x3
+#define UVD_LMI_SWAP_CNTL2__SCPU_R_MC_SWAP__SHIFT 0x0
+#define UVD_LMI_SWAP_CNTL2__SCPU_W_MC_SWAP_MASK 0xc
+#define UVD_LMI_SWAP_CNTL2__SCPU_W_MC_SWAP__SHIFT 0x2
+#define UVD_LMI_ADDR_EXT2__SCPU_ADDR_EXT_MASK 0xf
+#define UVD_LMI_ADDR_EXT2__SCPU_ADDR_EXT__SHIFT 0x0
+#define UVD_LMI_ADDR_EXT2__SCPU_VM_ADDR_EXT_MASK 0xf0
+#define UVD_LMI_ADDR_EXT2__SCPU_VM_ADDR_EXT__SHIFT 0x4
+#define UVD_LMI_ADDR_EXT2__SCPU_NC0_ADDR_EXT_MASK 0xf00
+#define UVD_LMI_ADDR_EXT2__SCPU_NC0_ADDR_EXT__SHIFT 0x8
+#define UVD_LMI_ADDR_EXT2__SCPU_NC1_ADDR_EXT_MASK 0xf000
+#define UVD_LMI_ADDR_EXT2__SCPU_NC1_ADDR_EXT__SHIFT 0xc
+#define UVD_CGC_MEM_CTRL__LMI_MC_LS_EN_MASK 0x1
+#define UVD_CGC_MEM_CTRL__LMI_MC_LS_EN__SHIFT 0x0
+#define UVD_CGC_MEM_CTRL__MPC_LS_EN_MASK 0x2
+#define UVD_CGC_MEM_CTRL__MPC_LS_EN__SHIFT 0x1
+#define UVD_CGC_MEM_CTRL__MPRD_LS_EN_MASK 0x4
+#define UVD_CGC_MEM_CTRL__MPRD_LS_EN__SHIFT 0x2
+#define UVD_CGC_MEM_CTRL__WCB_LS_EN_MASK 0x8
+#define UVD_CGC_MEM_CTRL__WCB_LS_EN__SHIFT 0x3
+#define UVD_CGC_MEM_CTRL__UDEC_RE_LS_EN_MASK 0x10
+#define UVD_CGC_MEM_CTRL__UDEC_RE_LS_EN__SHIFT 0x4
+#define UVD_CGC_MEM_CTRL__UDEC_CM_LS_EN_MASK 0x20
+#define UVD_CGC_MEM_CTRL__UDEC_CM_LS_EN__SHIFT 0x5
+#define UVD_CGC_MEM_CTRL__UDEC_IT_LS_EN_MASK 0x40
+#define UVD_CGC_MEM_CTRL__UDEC_IT_LS_EN__SHIFT 0x6
+#define UVD_CGC_MEM_CTRL__UDEC_DB_LS_EN_MASK 0x80
+#define UVD_CGC_MEM_CTRL__UDEC_DB_LS_EN__SHIFT 0x7
+#define UVD_CGC_MEM_CTRL__UDEC_MP_LS_EN_MASK 0x100
+#define UVD_CGC_MEM_CTRL__UDEC_MP_LS_EN__SHIFT 0x8
+#define UVD_CGC_MEM_CTRL__SYS_LS_EN_MASK 0x200
+#define UVD_CGC_MEM_CTRL__SYS_LS_EN__SHIFT 0x9
+#define UVD_CGC_MEM_CTRL__VCPU_LS_EN_MASK 0x400
+#define UVD_CGC_MEM_CTRL__VCPU_LS_EN__SHIFT 0xa
+#define UVD_CGC_MEM_CTRL__SCPU_LS_EN_MASK 0x800
+#define UVD_CGC_MEM_CTRL__SCPU_LS_EN__SHIFT 0xb
+#define UVD_CGC_MEM_CTRL__MIF_LS_EN_MASK 0x1000
+#define UVD_CGC_MEM_CTRL__MIF_LS_EN__SHIFT 0xc
+#define UVD_CGC_MEM_CTRL__LCM_LS_EN_MASK 0x2000
+#define UVD_CGC_MEM_CTRL__LCM_LS_EN__SHIFT 0xd
+#define UVD_CGC_MEM_CTRL__LS_SET_DELAY_MASK 0xf0000
+#define UVD_CGC_MEM_CTRL__LS_SET_DELAY__SHIFT 0x10
+#define UVD_CGC_MEM_CTRL__LS_CLEAR_DELAY_MASK 0xf00000
+#define UVD_CGC_MEM_CTRL__LS_CLEAR_DELAY__SHIFT 0x14
+#define UVD_CGC_CTRL2__DYN_OCLK_RAMP_EN_MASK 0x1
+#define UVD_CGC_CTRL2__DYN_OCLK_RAMP_EN__SHIFT 0x0
+#define UVD_CGC_CTRL2__DYN_RCLK_RAMP_EN_MASK 0x2
+#define UVD_CGC_CTRL2__DYN_RCLK_RAMP_EN__SHIFT 0x1
+#define UVD_CGC_CTRL2__GATER_DIV_ID_MASK 0x1c
+#define UVD_CGC_CTRL2__GATER_DIV_ID__SHIFT 0x2
+#define UVD_PGFSM_CONFIG__UVD_PGFSM_FSM_ADDR_MASK 0xff
+#define UVD_PGFSM_CONFIG__UVD_PGFSM_FSM_ADDR__SHIFT 0x0
+#define UVD_PGFSM_CONFIG__UVD_PGFSM_POWER_DOWN_MASK 0x100
+#define UVD_PGFSM_CONFIG__UVD_PGFSM_POWER_DOWN__SHIFT 0x8
+#define UVD_PGFSM_CONFIG__UVD_PGFSM_POWER_UP_MASK 0x200
+#define UVD_PGFSM_CONFIG__UVD_PGFSM_POWER_UP__SHIFT 0x9
+#define UVD_PGFSM_CONFIG__UVD_PGFSM_P1_SELECT_MASK 0x400
+#define UVD_PGFSM_CONFIG__UVD_PGFSM_P1_SELECT__SHIFT 0xa
+#define UVD_PGFSM_CONFIG__UVD_PGFSM_P2_SELECT_MASK 0x800
+#define UVD_PGFSM_CONFIG__UVD_PGFSM_P2_SELECT__SHIFT 0xb
+#define UVD_PGFSM_CONFIG__UVD_PGFSM_WRITE_MASK 0x1000
+#define UVD_PGFSM_CONFIG__UVD_PGFSM_WRITE__SHIFT 0xc
+#define UVD_PGFSM_CONFIG__UVD_PGFSM_READ_MASK 0x2000
+#define UVD_PGFSM_CONFIG__UVD_PGFSM_READ__SHIFT 0xd
+#define UVD_PGFSM_CONFIG__UVD_PGFSM_REG_ADDR_MASK 0xf0000000
+#define UVD_PGFSM_CONFIG__UVD_PGFSM_REG_ADDR__SHIFT 0x1c
+#define UVD_PGFSM_READ_TILE1__UVD_PGFSM_READ_TILE1_VALUE_MASK 0xffffff
+#define UVD_PGFSM_READ_TILE1__UVD_PGFSM_READ_TILE1_VALUE__SHIFT 0x0
+#define UVD_PGFSM_READ_TILE2__UVD_PGFSM_READ_TILE2_VALUE_MASK 0xffffff
+#define UVD_PGFSM_READ_TILE2__UVD_PGFSM_READ_TILE2_VALUE__SHIFT 0x0
+#define UVD_POWER_STATUS__UVD_POWER_STATUS_MASK 0x1
+#define UVD_POWER_STATUS__UVD_POWER_STATUS__SHIFT 0x0
+#define UVD_MIF_CURR_ADDR_CONFIG__NUM_PIPES_MASK 0x7
+#define UVD_MIF_CURR_ADDR_CONFIG__NUM_PIPES__SHIFT 0x0
+#define UVD_MIF_CURR_ADDR_CONFIG__PIPE_INTERLEAVE_SIZE_MASK 0x70
+#define UVD_MIF_CURR_ADDR_CONFIG__PIPE_INTERLEAVE_SIZE__SHIFT 0x4
+#define UVD_MIF_CURR_ADDR_CONFIG__BANK_INTERLEAVE_SIZE_MASK 0x700
+#define UVD_MIF_CURR_ADDR_CONFIG__BANK_INTERLEAVE_SIZE__SHIFT 0x8
+#define UVD_MIF_CURR_ADDR_CONFIG__NUM_SHADER_ENGINES_MASK 0x3000
+#define UVD_MIF_CURR_ADDR_CONFIG__NUM_SHADER_ENGINES__SHIFT 0xc
+#define UVD_MIF_CURR_ADDR_CONFIG__SHADER_ENGINE_TILE_SIZE_MASK 0x70000
+#define UVD_MIF_CURR_ADDR_CONFIG__SHADER_ENGINE_TILE_SIZE__SHIFT 0x10
+#define UVD_MIF_CURR_ADDR_CONFIG__NUM_GPUS_MASK 0x700000
+#define UVD_MIF_CURR_ADDR_CONFIG__NUM_GPUS__SHIFT 0x14
+#define UVD_MIF_CURR_ADDR_CONFIG__MULTI_GPU_TILE_SIZE_MASK 0x3000000
+#define UVD_MIF_CURR_ADDR_CONFIG__MULTI_GPU_TILE_SIZE__SHIFT 0x18
+#define UVD_MIF_CURR_ADDR_CONFIG__ROW_SIZE_MASK 0x30000000
+#define UVD_MIF_CURR_ADDR_CONFIG__ROW_SIZE__SHIFT 0x1c
+#define UVD_MIF_CURR_ADDR_CONFIG__NUM_LOWER_PIPES_MASK 0x40000000
+#define UVD_MIF_CURR_ADDR_CONFIG__NUM_LOWER_PIPES__SHIFT 0x1e
+#define UVD_MIF_REF_ADDR_CONFIG__NUM_PIPES_MASK 0x7
+#define UVD_MIF_REF_ADDR_CONFIG__NUM_PIPES__SHIFT 0x0
+#define UVD_MIF_REF_ADDR_CONFIG__PIPE_INTERLEAVE_SIZE_MASK 0x70
+#define UVD_MIF_REF_ADDR_CONFIG__PIPE_INTERLEAVE_SIZE__SHIFT 0x4
+#define UVD_MIF_REF_ADDR_CONFIG__BANK_INTERLEAVE_SIZE_MASK 0x700
+#define UVD_MIF_REF_ADDR_CONFIG__BANK_INTERLEAVE_SIZE__SHIFT 0x8
+#define UVD_MIF_REF_ADDR_CONFIG__NUM_SHADER_ENGINES_MASK 0x3000
+#define UVD_MIF_REF_ADDR_CONFIG__NUM_SHADER_ENGINES__SHIFT 0xc
+#define UVD_MIF_REF_ADDR_CONFIG__SHADER_ENGINE_TILE_SIZE_MASK 0x70000
+#define UVD_MIF_REF_ADDR_CONFIG__SHADER_ENGINE_TILE_SIZE__SHIFT 0x10
+#define UVD_MIF_REF_ADDR_CONFIG__NUM_GPUS_MASK 0x700000
+#define UVD_MIF_REF_ADDR_CONFIG__NUM_GPUS__SHIFT 0x14
+#define UVD_MIF_REF_ADDR_CONFIG__MULTI_GPU_TILE_SIZE_MASK 0x3000000
+#define UVD_MIF_REF_ADDR_CONFIG__MULTI_GPU_TILE_SIZE__SHIFT 0x18
+#define UVD_MIF_REF_ADDR_CONFIG__ROW_SIZE_MASK 0x30000000
+#define UVD_MIF_REF_ADDR_CONFIG__ROW_SIZE__SHIFT 0x1c
+#define UVD_MIF_REF_ADDR_CONFIG__NUM_LOWER_PIPES_MASK 0x40000000
+#define UVD_MIF_REF_ADDR_CONFIG__NUM_LOWER_PIPES__SHIFT 0x1e
+#define UVD_MIF_RECON1_ADDR_CONFIG__NUM_PIPES_MASK 0x7
+#define UVD_MIF_RECON1_ADDR_CONFIG__NUM_PIPES__SHIFT 0x0
+#define UVD_MIF_RECON1_ADDR_CONFIG__PIPE_INTERLEAVE_SIZE_MASK 0x70
+#define UVD_MIF_RECON1_ADDR_CONFIG__PIPE_INTERLEAVE_SIZE__SHIFT 0x4
+#define UVD_MIF_RECON1_ADDR_CONFIG__BANK_INTERLEAVE_SIZE_MASK 0x700
+#define UVD_MIF_RECON1_ADDR_CONFIG__BANK_INTERLEAVE_SIZE__SHIFT 0x8
+#define UVD_MIF_RECON1_ADDR_CONFIG__NUM_SHADER_ENGINES_MASK 0x3000
+#define UVD_MIF_RECON1_ADDR_CONFIG__NUM_SHADER_ENGINES__SHIFT 0xc
+#define UVD_MIF_RECON1_ADDR_CONFIG__SHADER_ENGINE_TILE_SIZE_MASK 0x70000
+#define UVD_MIF_RECON1_ADDR_CONFIG__SHADER_ENGINE_TILE_SIZE__SHIFT 0x10
+#define UVD_MIF_RECON1_ADDR_CONFIG__NUM_GPUS_MASK 0x700000
+#define UVD_MIF_RECON1_ADDR_CONFIG__NUM_GPUS__SHIFT 0x14
+#define UVD_MIF_RECON1_ADDR_CONFIG__MULTI_GPU_TILE_SIZE_MASK 0x3000000
+#define UVD_MIF_RECON1_ADDR_CONFIG__MULTI_GPU_TILE_SIZE__SHIFT 0x18
+#define UVD_MIF_RECON1_ADDR_CONFIG__ROW_SIZE_MASK 0x30000000
+#define UVD_MIF_RECON1_ADDR_CONFIG__ROW_SIZE__SHIFT 0x1c
+#define UVD_MIF_RECON1_ADDR_CONFIG__NUM_LOWER_PIPES_MASK 0x40000000
+#define UVD_MIF_RECON1_ADDR_CONFIG__NUM_LOWER_PIPES__SHIFT 0x1e
+// UVD_FW_STATUS
+#define UVD_FW_STATUS__BUSY_MASK                           0x00000001L
+#define UVD_FW_STATUS__ACTIVE_MASK                         0x00000002L
+#define UVD_FW_STATUS__SEND_EFUSE_REQ_MASK                 0x00000004L
+#define UVD_FW_STATUS__DONE_MASK                           0x00000100L
+#define UVD_FW_STATUS__PASS_MASK                           0x00010000L
+#define UVD_FW_STATUS__FAIL_MASK                           0x00020000L
+#define UVD_FW_STATUS__INVALID_LEN_MASK                    0x00040000L
+#define UVD_FW_STATUS__INVALID_0_PADDING_MASK              0x00080000L
+#define UVD_FW_STATUS__INVALID_NONCE_MASK                  0x00100000L
+
+#endif /* UVD_3_1_SH_MASK_H */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

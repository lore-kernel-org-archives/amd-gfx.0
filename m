Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65075C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 02:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6278A10E04C;
	Wed,  2 Nov 2022 02:38:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E20AD10E04C
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 02:38:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLHaKonzNY6WLWtwxUvVsB4udF4ATVZQNA9VP5g/5yiMwgpFcD0oZITpfF4QD6lEltt5W73TGBpvvbYgbmJDKShuCmCRd0kBHpnhzEckoP0EAxr6VcSJ7Fpjit6sZVAlzwHT6I+Ztz47vRo7nukfDefDAumxM2n7JEH4KXZ9q7AnuHQUJeEzafOn/paURESugAX8MJuqra0AckadGf98qxO4Jb6qWhDfBRyYt0EJVoBynOSKuDM46PZUikFT79BaZaalst+lRK4nV5qIY3tUYUluGpcZ8QDUig26NJjiemYJfJerDt6bUM72WFFCL+T9E4Eb7M2AkX/nwGgl6Sp4JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aB3p8hzdD3l8tEGhkjTcpDR0l2kmSQgfwV4to6gLZt8=;
 b=IMXInzJS/2chPsD4MtLDwJTmOHX2yQN4jqJNONhcjMx73UWiGAWKotapnjh6Kq8Z/0LRa16mK2ukplimt4RCnR9mgvE936Q5XXce/sGHZlmmJqk/jcPeK4q/UkVt8a+3Kz1YVgBIgw5LsMEYnZ3Fqb4np6MOVxVxoYFxHnVB3fwhOYLG2MTSNETEdXvy7ef+sbBAwjxTzvC23K9oacE4y3geo4X5wOyRHvDrcukZjLJocElmN3dcgTTY8V+5YVj2DXGXO7uiwZLyb2TXhZ2SUOPRG4xNn4Gr0S1/5zG2IJq0Fs0Hf9Ed8iMmSBXavVfWqVvOOBVw9VgKMyvjnwaPMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aB3p8hzdD3l8tEGhkjTcpDR0l2kmSQgfwV4to6gLZt8=;
 b=Ua8hr1Gx/jagzkREpoBEs4m4SefxJLQEacSexx4f+8pCcuVecXXx2DTap6hw3fej/itolWY4RlQqHttdfDAZZVTm5GH3njfxfJ+mqdMV90o6k1Hm8VELbNKzEvFStAs+6iSqLTA7QqEs9dVXIM1b7pQy+8+eDlHkYMCVIttDta0=
Received: from BN6PR17CA0032.namprd17.prod.outlook.com (2603:10b6:405:75::21)
 by CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 2 Nov
 2022 02:38:36 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::7e) by BN6PR17CA0032.outlook.office365.com
 (2603:10b6:405:75::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20 via Frontend
 Transport; Wed, 2 Nov 2022 02:38:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 02:38:36 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 21:36:22 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add register definition for VCN RAS
 initialization
Date: Wed, 2 Nov 2022 10:36:07 +0800
Message-ID: <20221102023608.17242-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT036:EE_|CY8PR12MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: f3703c4a-b7fd-4ffc-5603-08dabc7b57a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rwFZ3vflaHg7MfdrstCo5Ybt5NiznCl6p8t999TNW2JzHnANfCpP3R0R3wwwUrPLBKB51qJMBhFPLX23SePFnqNB0iKlT140Kbc1ko8U8zCJPm8WtwpyFqremRnmgS6Y2D+ZbkCUYtyFtVlIk8+FT8X6mvJNhHZhRQE00nYer24n5wm88YvaY92bOQ6PnMWIsyx+yNMnLJtZqKUWYceJFadPN4yORPIFT2VXpImd8WbdsPRoX9YLSjEVETIOIElsGvT+xvVYURz6she0jH2+pk780xMzLRc64lRX03X78qVb7U1gNQbLSZmOd4Ldi66btmlsoM6h67HuHxQGOX28VuAlM9IFQN9+uivb5uCd9kOcCnypjBIUMaMX0lbMfcx/ipRCZeBkXWjelNdoJ79flJ/emW9WB2+1JCXdgo8hkpXv04t+CtBKJAQoiN2CdQWgVP6BzJxnDq5d2g3EaOSiJEJ7TCkgfmP1ExPdH1TJu0Z3RNKkMBjRnc4/s1XwOrE5mwhacYcLN89BdL0QYywKOYepY81KM+mS6L64B37V3Rc5Cc2RLuaEtMhqJy1nDZFlSBdlc9vL2GPdGK2TZf95uys1eYC3eanYMXGZYz4b088IwuBkc/fWHu8sVkpYY33PqIBbCdOhGVAo1WlV4o8SYOs36KQmeJ/vB1aTcXtF0I21MkKsKpfoRev31leeU6Ql8fshthT3wErt4GXQc8i7ZE2X4xomR1ogRGzWTEd+h1HiOmATmGj7brrcUvbLkxke/c9/XzLAxU9vfCpmIspAPUZcVnYtU3ouz5V6zmXz3JuFXisG3jez+wiS6qR/Zzha
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(82310400005)(40460700003)(36756003)(86362001)(41300700001)(82740400003)(356005)(81166007)(36860700001)(316002)(16526019)(110136005)(70206006)(2906002)(336012)(7696005)(1076003)(186003)(54906003)(478600001)(4326008)(2616005)(47076005)(5660300002)(8936002)(40480700001)(26005)(6636002)(70586007)(426003)(6666004)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 02:38:36.3133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3703c4a-b7fd-4ffc-5603-08dabc7b57a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Prepare for enableing VCN RAS poison.

v2: move SHIFT and MASK definitions to related sh_mask.h file.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../amd/include/asic_reg/vcn/vcn_2_5_offset.h |  8 ++
 .../include/asic_reg/vcn/vcn_2_5_sh_mask.h    | 77 +++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_5_offset.h b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_5_offset.h
index 363d2139cea2..02fa5b5c3d01 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_5_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_5_offset.h
@@ -994,6 +994,14 @@
 #define mmUVD_RAS_MMSCH_FATAL_ERROR                            0x0058
 #define mmUVD_RAS_MMSCH_FATAL_ERROR_BASE_IDX                   1
 
+#define regVCN_RAS_CNTL                                                                                 0x04b9
+#define regVCN_RAS_CNTL_BASE_IDX                                                                        1
+
+#define regUVD_VCPU_INT_EN                                                                              0x0095
+#define regUVD_VCPU_INT_EN_BASE_IDX                                                                     1
+
+#define regUVD_SYS_INT_EN                                                                               0x00a2
+#define regUVD_SYS_INT_EN_BASE_IDX                                                                      1
 
 /* JPEG 2_6_0 regs */
 #define mmUVD_RAS_JPEG0_STATUS                                 0x0059
diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_5_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_5_sh_mask.h
index 8de883b76d90..9bfc9794722d 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_5_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_5_sh_mask.h
@@ -3618,6 +3618,83 @@
 #define UVD_RAS_MMSCH_FATAL_ERROR__POISONED_VF_MASK             0x7FFFFFFFL
 #define UVD_RAS_MMSCH_FATAL_ERROR__POISONED_PF_MASK             0x80000000L
 
+//VCN 2_6_0 VCN_RAS_CNTL
+#define VCN_RAS_CNTL__VCPU_VCODEC_IH_EN__SHIFT                                                                0x0
+#define VCN_RAS_CNTL__MMSCH_FATAL_ERROR_EN__SHIFT                                                             0x1
+#define VCN_RAS_CNTL__VCPU_VCODEC_PMI_EN__SHIFT                                                               0x4
+#define VCN_RAS_CNTL__MMSCH_PMI_EN__SHIFT                                                                     0x5
+#define VCN_RAS_CNTL__VCPU_VCODEC_REARM__SHIFT                                                                0x8
+#define VCN_RAS_CNTL__MMSCH_REARM__SHIFT                                                                      0x9
+#define VCN_RAS_CNTL__VCPU_VCODEC_STALL_EN__SHIFT                                                             0xc
+#define VCN_RAS_CNTL__VCPU_VCODEC_READY__SHIFT                                                                0x10
+#define VCN_RAS_CNTL__MMSCH_READY__SHIFT                                                                      0x11
+#define VCN_RAS_CNTL__VCPU_VCODEC_IH_EN_MASK                                                                  0x00000001L
+#define VCN_RAS_CNTL__MMSCH_FATAL_ERROR_EN_MASK                                                               0x00000002L
+#define VCN_RAS_CNTL__VCPU_VCODEC_PMI_EN_MASK                                                                 0x00000010L
+#define VCN_RAS_CNTL__MMSCH_PMI_EN_MASK                                                                       0x00000020L
+#define VCN_RAS_CNTL__VCPU_VCODEC_REARM_MASK                                                                  0x00000100L
+#define VCN_RAS_CNTL__MMSCH_REARM_MASK                                                                        0x00000200L
+#define VCN_RAS_CNTL__VCPU_VCODEC_STALL_EN_MASK                                                               0x00001000L
+#define VCN_RAS_CNTL__VCPU_VCODEC_READY_MASK                                                                  0x00010000L
+#define VCN_RAS_CNTL__MMSCH_READY_MASK                                                                        0x00020000L
+
+//VCN 2_6_0 UVD_VCPU_INT_EN
+#define UVD_VCPU_INT_EN__PIF_ADDR_ERR_EN__SHIFT                                                               0x0
+#define UVD_VCPU_INT_EN__SEMA_WAIT_FAULT_TIMEOUT_EN__SHIFT                                                    0x1
+#define UVD_VCPU_INT_EN__SEMA_SIGNAL_INCOMPLETE_TIMEOUT_EN__SHIFT                                             0x2
+#define UVD_VCPU_INT_EN__NJ_PF_RPT_EN__SHIFT                                                                  0x3
+#define UVD_VCPU_INT_EN__SW_RB1_INT_EN__SHIFT                                                                 0x4
+#define UVD_VCPU_INT_EN__SW_RB2_INT_EN__SHIFT                                                                 0x5
+#define UVD_VCPU_INT_EN__RBC_REG_PRIV_FAULT_EN__SHIFT                                                         0x6
+#define UVD_VCPU_INT_EN__SW_RB3_INT_EN__SHIFT                                                                 0x7
+#define UVD_VCPU_INT_EN__SW_RB4_INT_EN__SHIFT                                                                 0x9
+#define UVD_VCPU_INT_EN__SW_RB5_INT_EN__SHIFT                                                                 0xa
+#define UVD_VCPU_INT_EN__LBSI_EN__SHIFT                                                                       0xb
+#define UVD_VCPU_INT_EN__UDEC_EN__SHIFT                                                                       0xc
+#define UVD_VCPU_INT_EN__SUVD_EN__SHIFT                                                                       0xf
+#define UVD_VCPU_INT_EN__RPTR_WR_EN__SHIFT                                                                    0x10
+#define UVD_VCPU_INT_EN__JOB_START_EN__SHIFT                                                                  0x11
+#define UVD_VCPU_INT_EN__NJ_PF_EN__SHIFT                                                                      0x12
+#define UVD_VCPU_INT_EN__RASCNTL_VCPU_VCODEC_EN__SHIFT                                                        0x16
+#define UVD_VCPU_INT_EN__SEMA_WAIT_FAIL_SIG_EN__SHIFT                                                         0x17
+#define UVD_VCPU_INT_EN__IDCT_EN__SHIFT                                                                       0x18
+#define UVD_VCPU_INT_EN__MPRD_EN__SHIFT                                                                       0x19
+#define UVD_VCPU_INT_EN__AVM_INT_EN__SHIFT                                                                    0x1a
+#define UVD_VCPU_INT_EN__CLK_SWT_EN__SHIFT                                                                    0x1b
+#define UVD_VCPU_INT_EN__MIF_HWINT_EN__SHIFT                                                                  0x1c
+#define UVD_VCPU_INT_EN__MPRD_ERR_EN__SHIFT                                                                   0x1d
+#define UVD_VCPU_INT_EN__DRV_FW_REQ_EN__SHIFT                                                                 0x1e
+#define UVD_VCPU_INT_EN__DRV_FW_ACK_EN__SHIFT                                                                 0x1f
+#define UVD_VCPU_INT_EN__PIF_ADDR_ERR_EN_MASK                                                                 0x00000001L
+#define UVD_VCPU_INT_EN__SEMA_WAIT_FAULT_TIMEOUT_EN_MASK                                                      0x00000002L
+#define UVD_VCPU_INT_EN__SEMA_SIGNAL_INCOMPLETE_TIMEOUT_EN_MASK                                               0x00000004L
+#define UVD_VCPU_INT_EN__NJ_PF_RPT_EN_MASK                                                                    0x00000008L
+#define UVD_VCPU_INT_EN__SW_RB1_INT_EN_MASK                                                                   0x00000010L
+#define UVD_VCPU_INT_EN__SW_RB2_INT_EN_MASK                                                                   0x00000020L
+#define UVD_VCPU_INT_EN__RBC_REG_PRIV_FAULT_EN_MASK                                                           0x00000040L
+#define UVD_VCPU_INT_EN__SW_RB3_INT_EN_MASK                                                                   0x00000080L
+#define UVD_VCPU_INT_EN__SW_RB4_INT_EN_MASK                                                                   0x00000200L
+#define UVD_VCPU_INT_EN__SW_RB5_INT_EN_MASK                                                                   0x00000400L
+#define UVD_VCPU_INT_EN__LBSI_EN_MASK                                                                         0x00000800L
+#define UVD_VCPU_INT_EN__UDEC_EN_MASK                                                                         0x00001000L
+#define UVD_VCPU_INT_EN__SUVD_EN_MASK                                                                         0x00008000L
+#define UVD_VCPU_INT_EN__RPTR_WR_EN_MASK                                                                      0x00010000L
+#define UVD_VCPU_INT_EN__JOB_START_EN_MASK                                                                    0x00020000L
+#define UVD_VCPU_INT_EN__NJ_PF_EN_MASK                                                                        0x00040000L
+#define UVD_VCPU_INT_EN__RASCNTL_VCPU_VCODEC_EN_MASK                                                          0x00400000L
+#define UVD_VCPU_INT_EN__SEMA_WAIT_FAIL_SIG_EN_MASK                                                           0x00800000L
+#define UVD_VCPU_INT_EN__IDCT_EN_MASK                                                                         0x01000000L
+#define UVD_VCPU_INT_EN__MPRD_EN_MASK                                                                         0x02000000L
+#define UVD_VCPU_INT_EN__AVM_INT_EN_MASK                                                                      0x04000000L
+#define UVD_VCPU_INT_EN__CLK_SWT_EN_MASK                                                                      0x08000000L
+#define UVD_VCPU_INT_EN__MIF_HWINT_EN_MASK                                                                    0x10000000L
+#define UVD_VCPU_INT_EN__MPRD_ERR_EN_MASK                                                                     0x20000000L
+#define UVD_VCPU_INT_EN__DRV_FW_REQ_EN_MASK                                                                   0x40000000L
+#define UVD_VCPU_INT_EN__DRV_FW_ACK_EN_MASK                                                                   0x80000000L
+
+//VCN 2_6_0 UVD_SYS_INT_EN
+#define UVD_SYS_INT_EN__RASCNTL_VCPU_VCODEC_EN_MASK                                                           0x04000000L
+
 /* JPEG 2_6_0 UVD_RAS_JPEG0_STATUS */
 #define UVD_RAS_JPEG0_STATUS__POISONED_VF__SHIFT                0x0
 #define UVD_RAS_JPEG0_STATUS__POISONED_PF__SHIFT                0x1f
-- 
2.35.1


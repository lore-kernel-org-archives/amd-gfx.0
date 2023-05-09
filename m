Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37116C7EE2A
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:21:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 301D210E42F;
	Tue,  9 May 2023 22:21:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 857F710E42C
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:21:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DT8pRiphw0nATrzYsKmtXd51iiliPXmeMUJUtftctH2kynAUCjhbZb7G3yF+RqkAFxqfDsqk0MbIpFm0JOY8ckxsrA1k8Pioa6MXNF+UmZlu8r4pWLgnmlqnxIHDZLb3EBQyGNo4KeO93ZsIe6R0eUvSdj20XO9/7YmyxtS/Rj4BDIVKOJhXQfVn1XoS8DCtkOHqTgb2sWXuodzzUDATPvr6NbxC1yb3xfqG2rd7hGPG9nPE+wY78ZygHDpgVTZRjrQn4SRfCMAj4rKNdGPtPxrSHLlecS/2FPfQJsE5CIk7ITQNJiyhb55NeFQDux7tuGgADpSV0M6mCbuQ+scIwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0uhymh5cCG1d9KHJ/rvJevbJp7kyLQw9XCYGFHfGqM=;
 b=LgImKMmedDsSTV+vhvX6lrlpoO0vdHkJ2LVk+lJNwFfFxnod7bEmjsZHiFzSUQlvXA9JxH1zLKyOBAkGuXrBFmURs7aW9InIQe320io1ys60koiFdCZjmaZ9vMSv4IolbCoT3juQ1Pdxc1Bg9LvKRNhWZzTMuePtwydRnSQx+L5G+/eGfVUyBB4rZRHqxsQX8EqAw6rW7bS4Hzyd8ttOzkGBS1zl2mIAgU20O1cOhrQrJm4abM4pTAJO15CuiFZmYneiQDnG2yDYXk/7cMWAascxUxRzmKAe6HkaPlIlf4RqNB6JBn65TbXJznOZWSqVGl7CpHGYCj4F56SzA5GfMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0uhymh5cCG1d9KHJ/rvJevbJp7kyLQw9XCYGFHfGqM=;
 b=JXCFVslOZyVgtNQkjy5BwZbqBbzsCRPM110gW4gUzGrRURycMnCWi8BiK0Etfnhf8oRBVRKvwv4z/TCE/cO3XZAj8/7WyiP3BpbGa2g/3uYXw4XGWiKOeP6OcKkQkmt69e85OxER5q6NxR8ysgWlrGMmEI3bPpb9XDK6QF6EE3s=
Received: from BN9PR03CA0955.namprd03.prod.outlook.com (2603:10b6:408:108::30)
 by IA0PR12MB7508.namprd12.prod.outlook.com (2603:10b6:208:440::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:21:39 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::b1) by BN9PR03CA0955.outlook.office365.com
 (2603:10b6:408:108::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:21:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 22:21:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:21:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/9] drm/amdgpu: Add vcn/jpeg ras err status registers
Date: Tue, 9 May 2023 18:21:18 -0400
Message-ID: <20230509222126.477847-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|IA0PR12MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a6990a-3893-43e8-fdf7-08db50dbc2a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n3rG3+joZy3wjMvcNP3j8ClFgxi/lWV0cE/ph8IDGmxjYqOZGqlkvbwybNxa9C/DwRr/B3kK56BH/4SCLRSsD7vRE/K91fzTNjvbJogvejFQ3v5lPse5iWTlH9NpX2l+tBsTqkSpjaGXl606q5g/zCvkJ7Ftg/WRpnRjRzLLvcof8zv4eD8vEPHm7JRGbEyJ6646lHoOgjwTtKKK3WTrzO6N1m0DsFPK6UbkCbh0nz+lgPfcHYx2N1PgQUZlPfrRS88dWoQpss1er//6gl4GZjadyTVbhAVTlk6QNQkr5FutZficklBQurYXuKcIb9zBSaDKF4l4kEi61D+UA9NuCQZjlkM9GzlLoEmHFCh42U6X9qK4xJDA50oM9kEXTA6NEupICF550Y74wlt1hGQbXnZUQx8+sDFUxDvoNkU7dS9nurrSh49NoSn70THsq2hefS+iW2dz8t4zXbVN+/hnna76Vwp4z8a8Mg/Scdk3MgRGJBX09HydwTlUWfpaBf6wYxXUnGwmYm5eLpneNMvM5b07MxOzdhIu0yF1fFszgAEuO7gfg1mzEulfI1GTiq/S8vMjnmL/DXmsENj7MxBRIcwmR+8yToO2Wl1bSrEJ7KnlSJ2tkzL+Ytc+hOHhc5G1pvagPgeilTymCn118+PGiSjGFmlbjhUY1LqMrNqlnOmSbdLa7hP/PbP2scpd3qPELqz/RwCJzHDbGETFG8f/6IvXuOpuvbZgURntRwFoFDo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(46966006)(36840700001)(40470700004)(356005)(81166007)(26005)(1076003)(82740400003)(7696005)(6666004)(2616005)(426003)(83380400001)(186003)(16526019)(36756003)(36860700001)(2906002)(30864003)(40460700003)(70206006)(86362001)(70586007)(19627235002)(40480700001)(5660300002)(54906003)(41300700001)(478600001)(8936002)(8676002)(4326008)(336012)(316002)(6916009)(82310400005)(47076005)(36900700001)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:21:39.5525 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a6990a-3893-43e8-fdf7-08db50dbc2a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7508
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add new ras error status registers introduced in
vcn v4_0_3 to log vcn and jpeg ras error.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../include/asic_reg/vcn/vcn_4_0_3_offset.h   |  78 +++
 .../include/asic_reg/vcn/vcn_4_0_3_sh_mask.h  | 495 ++++++++++++++++++
 2 files changed, 573 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_3_offset.h b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_3_offset.h
index facad93cd06f..e9742d10de1c 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_3_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_3_offset.h
@@ -1500,6 +1500,84 @@
 #define regVCN_RAS_CNTL_MMSCH                                                                           0x0914
 #define regVCN_RAS_CNTL_MMSCH_BASE_IDX                                                                  1
 
+// addressBlock: aid_uvd0_vcn_edcc_dec
+// base address: 0x21d20
+#define regVCN_UE_ERR_STATUS_LO_VIDD                                                                    0x094c
+#define regVCN_UE_ERR_STATUS_LO_VIDD_BASE_IDX                                                           1
+#define regVCN_UE_ERR_STATUS_HI_VIDD                                                                    0x094d
+#define regVCN_UE_ERR_STATUS_HI_VIDD_BASE_IDX                                                           1
+#define regVCN_UE_ERR_STATUS_LO_VIDV                                                                    0x094e
+#define regVCN_UE_ERR_STATUS_LO_VIDV_BASE_IDX                                                           1
+#define regVCN_UE_ERR_STATUS_HI_VIDV                                                                    0x094f
+#define regVCN_UE_ERR_STATUS_HI_VIDV_BASE_IDX                                                           1
+#define regVCN_CE_ERR_STATUS_LO_MMSCHD                                                                  0x0950
+#define regVCN_CE_ERR_STATUS_LO_MMSCHD_BASE_IDX                                                         1
+#define regVCN_CE_ERR_STATUS_HI_MMSCHD                                                                  0x0951
+#define regVCN_CE_ERR_STATUS_HI_MMSCHD_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_LO_JPEG0S                                                                  0x0952
+#define regVCN_UE_ERR_STATUS_LO_JPEG0S_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_HI_JPEG0S                                                                  0x0953
+#define regVCN_UE_ERR_STATUS_HI_JPEG0S_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_LO_JPEG0D                                                                  0x0954
+#define regVCN_UE_ERR_STATUS_LO_JPEG0D_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_HI_JPEG0D                                                                  0x0955
+#define regVCN_UE_ERR_STATUS_HI_JPEG0D_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_LO_JPEG1S                                                                  0x0956
+#define regVCN_UE_ERR_STATUS_LO_JPEG1S_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_HI_JPEG1S                                                                  0x0957
+#define regVCN_UE_ERR_STATUS_HI_JPEG1S_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_LO_JPEG1D                                                                  0x0958
+#define regVCN_UE_ERR_STATUS_LO_JPEG1D_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_HI_JPEG1D                                                                  0x0959
+#define regVCN_UE_ERR_STATUS_HI_JPEG1D_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_LO_JPEG2S                                                                  0x095a
+#define regVCN_UE_ERR_STATUS_LO_JPEG2S_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_HI_JPEG2S                                                                  0x095b
+#define regVCN_UE_ERR_STATUS_HI_JPEG2S_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_LO_JPEG2D                                                                  0x095c
+#define regVCN_UE_ERR_STATUS_LO_JPEG2D_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_HI_JPEG2D                                                                  0x095d
+#define regVCN_UE_ERR_STATUS_HI_JPEG2D_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_LO_JPEG3S                                                                  0x095e
+#define regVCN_UE_ERR_STATUS_LO_JPEG3S_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_HI_JPEG3S                                                                  0x095f
+#define regVCN_UE_ERR_STATUS_HI_JPEG3S_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_LO_JPEG3D                                                                  0x0960
+#define regVCN_UE_ERR_STATUS_LO_JPEG3D_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_HI_JPEG3D                                                                  0x0961
+#define regVCN_UE_ERR_STATUS_HI_JPEG3D_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_LO_JPEG4S                                                                  0x0962
+#define regVCN_UE_ERR_STATUS_LO_JPEG4S_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_HI_JPEG4S                                                                  0x0963
+#define regVCN_UE_ERR_STATUS_HI_JPEG4S_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_LO_JPEG4D                                                                  0x0964
+#define regVCN_UE_ERR_STATUS_LO_JPEG4D_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_HI_JPEG4D                                                                  0x0965
+#define regVCN_UE_ERR_STATUS_HI_JPEG4D_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_LO_JPEG5S                                                                  0x0966
+#define regVCN_UE_ERR_STATUS_LO_JPEG5S_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_HI_JPEG5S                                                                  0x0967
+#define regVCN_UE_ERR_STATUS_HI_JPEG5S_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_LO_JPEG5D                                                                  0x0968
+#define regVCN_UE_ERR_STATUS_LO_JPEG5D_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_HI_JPEG5D                                                                  0x0969
+#define regVCN_UE_ERR_STATUS_HI_JPEG5D_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_LO_JPEG6S                                                                  0x096a
+#define regVCN_UE_ERR_STATUS_LO_JPEG6S_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_HI_JPEG6S                                                                  0x096b
+#define regVCN_UE_ERR_STATUS_HI_JPEG6S_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_LO_JPEG6D                                                                  0x096c
+#define regVCN_UE_ERR_STATUS_LO_JPEG6D_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_HI_JPEG6D                                                                  0x096d
+#define regVCN_UE_ERR_STATUS_HI_JPEG6D_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_LO_JPEG7S                                                                  0x096e
+#define regVCN_UE_ERR_STATUS_LO_JPEG7S_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_HI_JPEG7S                                                                  0x096f
+#define regVCN_UE_ERR_STATUS_HI_JPEG7S_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_LO_JPEG7D                                                                  0x0970
+#define regVCN_UE_ERR_STATUS_LO_JPEG7D_BASE_IDX                                                         1
+#define regVCN_UE_ERR_STATUS_HI_JPEG7D                                                                  0x0971
+#define regVCN_UE_ERR_STATUS_HI_JPEG7D_BASE_IDX                                                         1
 
 // addressBlock: aid_uvd0_uvd_jrbc1_uvd_jrbc_dec
 // base address: 0x1e000
diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_3_sh_mask.h
index be643ea0e569..5bd8111bf04a 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_3_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_3_sh_mask.h
@@ -5312,6 +5312,501 @@
 #define UVD_JPEG_DEC_SOFT_RST__SOFT_RESET_MASK                                                                0x00000001L
 #define UVD_JPEG_DEC_SOFT_RST__RESET_STATUS_MASK                                                              0x00010000L
 
+// addressBlock: aid_uvd0_vcn_edcc_dec
+//VCN_UE_ERR_STATUS_LO_VIDD
+#define VCN_UE_ERR_STATUS_LO_VIDD__Err_Status_Valid_Flag__SHIFT                                               0x0
+#define VCN_UE_ERR_STATUS_LO_VIDD__Address_Valid_Flag__SHIFT                                                  0x1
+#define VCN_UE_ERR_STATUS_LO_VIDD__Address__SHIFT                                                             0x2
+#define VCN_UE_ERR_STATUS_LO_VIDD__Memory_id__SHIFT                                                           0x18
+#define VCN_UE_ERR_STATUS_LO_VIDD__Err_Status_Valid_Flag_MASK                                                 0x00000001L
+#define VCN_UE_ERR_STATUS_LO_VIDD__Address_Valid_Flag_MASK                                                    0x00000002L
+#define VCN_UE_ERR_STATUS_LO_VIDD__Address_MASK                                                               0x00FFFFFCL
+#define VCN_UE_ERR_STATUS_LO_VIDD__Memory_id_MASK                                                             0xFF000000L
+//VCN_UE_ERR_STATUS_HI_VIDD
+#define VCN_UE_ERR_STATUS_HI_VIDD__ECC__SHIFT                                                                 0x0
+#define VCN_UE_ERR_STATUS_HI_VIDD__Parity__SHIFT                                                              0x1
+#define VCN_UE_ERR_STATUS_HI_VIDD__Err_Info_Valid_Flag__SHIFT                                                 0x2
+#define VCN_UE_ERR_STATUS_HI_VIDD__Err_Info__SHIFT                                                            0x3
+#define VCN_UE_ERR_STATUS_HI_VIDD__UE_Cnt__SHIFT                                                              0x17
+#define VCN_UE_ERR_STATUS_HI_VIDD__FED_Cnt__SHIFT                                                             0x1a
+#define VCN_UE_ERR_STATUS_HI_VIDD__RESERVED__SHIFT                                                            0x1d
+#define VCN_UE_ERR_STATUS_HI_VIDD__Err_clr__SHIFT                                                             0x1f
+#define VCN_UE_ERR_STATUS_HI_VIDD__ECC_MASK                                                                   0x00000001L
+#define VCN_UE_ERR_STATUS_HI_VIDD__Parity_MASK                                                                0x00000002L
+#define VCN_UE_ERR_STATUS_HI_VIDD__Err_Info_Valid_Flag_MASK                                                   0x00000004L
+#define VCN_UE_ERR_STATUS_HI_VIDD__Err_Info_MASK                                                              0x007FFFF8L
+#define VCN_UE_ERR_STATUS_HI_VIDD__UE_Cnt_MASK                                                                0x03800000L
+#define VCN_UE_ERR_STATUS_HI_VIDD__FED_Cnt_MASK                                                               0x1C000000L
+#define VCN_UE_ERR_STATUS_HI_VIDD__RESERVED_MASK                                                              0x60000000L
+#define VCN_UE_ERR_STATUS_HI_VIDD__Err_clr_MASK                                                               0x80000000L
+//VCN_UE_ERR_STATUS_LO_VIDV
+#define VCN_UE_ERR_STATUS_LO_VIDV__Err_Status_Valid_Flag__SHIFT                                               0x0
+#define VCN_UE_ERR_STATUS_LO_VIDV__Address_Valid_Flag__SHIFT                                                  0x1
+#define VCN_UE_ERR_STATUS_LO_VIDV__Address__SHIFT                                                             0x2
+#define VCN_UE_ERR_STATUS_LO_VIDV__Memory_id__SHIFT                                                           0x18
+#define VCN_UE_ERR_STATUS_LO_VIDV__Err_Status_Valid_Flag_MASK                                                 0x00000001L
+#define VCN_UE_ERR_STATUS_LO_VIDV__Address_Valid_Flag_MASK                                                    0x00000002L
+#define VCN_UE_ERR_STATUS_LO_VIDV__Address_MASK                                                               0x00FFFFFCL
+#define VCN_UE_ERR_STATUS_LO_VIDV__Memory_id_MASK                                                             0xFF000000L
+//VCN_UE_ERR_STATUS_HI_VIDV
+#define VCN_UE_ERR_STATUS_HI_VIDV__ECC__SHIFT                                                                 0x0
+#define VCN_UE_ERR_STATUS_HI_VIDV__Parity__SHIFT                                                              0x1
+#define VCN_UE_ERR_STATUS_HI_VIDV__Err_Info_Valid_Flag__SHIFT                                                 0x2
+#define VCN_UE_ERR_STATUS_HI_VIDV__Err_Info__SHIFT                                                            0x3
+#define VCN_UE_ERR_STATUS_HI_VIDV__UE_Cnt__SHIFT                                                              0x17
+#define VCN_UE_ERR_STATUS_HI_VIDV__FED_Cnt__SHIFT                                                             0x1a
+#define VCN_UE_ERR_STATUS_HI_VIDV__RESERVED__SHIFT                                                            0x1d
+#define VCN_UE_ERR_STATUS_HI_VIDV__Err_clr__SHIFT                                                             0x1f
+#define VCN_UE_ERR_STATUS_HI_VIDV__ECC_MASK                                                                   0x00000001L
+#define VCN_UE_ERR_STATUS_HI_VIDV__Parity_MASK                                                                0x00000002L
+#define VCN_UE_ERR_STATUS_HI_VIDV__Err_Info_Valid_Flag_MASK                                                   0x00000004L
+#define VCN_UE_ERR_STATUS_HI_VIDV__Err_Info_MASK                                                              0x007FFFF8L
+#define VCN_UE_ERR_STATUS_HI_VIDV__UE_Cnt_MASK                                                                0x03800000L
+#define VCN_UE_ERR_STATUS_HI_VIDV__FED_Cnt_MASK                                                               0x1C000000L
+#define VCN_UE_ERR_STATUS_HI_VIDV__RESERVED_MASK                                                              0x60000000L
+#define VCN_UE_ERR_STATUS_HI_VIDV__Err_clr_MASK                                                               0x80000000L
+//VCN_CE_ERR_STATUS_LO_MMSCHD
+#define VCN_CE_ERR_STATUS_LO_MMSCHD__Err_Status_Valid_Flag__SHIFT                                             0x0
+#define VCN_CE_ERR_STATUS_LO_MMSCHD__Address_Valid_Flag__SHIFT                                                0x1
+#define VCN_CE_ERR_STATUS_LO_MMSCHD__Address__SHIFT                                                           0x2
+#define VCN_CE_ERR_STATUS_LO_MMSCHD__Memory_id__SHIFT                                                         0x18
+#define VCN_CE_ERR_STATUS_LO_MMSCHD__Err_Status_Valid_Flag_MASK                                               0x00000001L
+#define VCN_CE_ERR_STATUS_LO_MMSCHD__Address_Valid_Flag_MASK                                                  0x00000002L
+#define VCN_CE_ERR_STATUS_LO_MMSCHD__Address_MASK                                                             0x00FFFFFCL
+#define VCN_CE_ERR_STATUS_LO_MMSCHD__Memory_id_MASK                                                           0xFF000000L
+//VCN_CE_ERR_STATUS_HI_MMSCHD
+#define VCN_CE_ERR_STATUS_HI_MMSCHD__ECC__SHIFT                                                               0x0
+#define VCN_CE_ERR_STATUS_HI_MMSCHD__Other__SHIFT                                                             0x1
+#define VCN_CE_ERR_STATUS_HI_MMSCHD__Err_Info_Valid_Flag__SHIFT                                               0x2
+#define VCN_CE_ERR_STATUS_HI_MMSCHD__Err_Info__SHIFT                                                          0x3
+#define VCN_CE_ERR_STATUS_HI_MMSCHD__CE_Cnt__SHIFT                                                            0x17
+#define VCN_CE_ERR_STATUS_HI_MMSCHD__Poison__SHIFT                                                            0x1c
+#define VCN_CE_ERR_STATUS_HI_MMSCHD__RESERVED__SHIFT                                                          0x1d
+#define VCN_CE_ERR_STATUS_HI_MMSCHD__Err_clr__SHIFT                                                           0x1f
+#define VCN_CE_ERR_STATUS_HI_MMSCHD__ECC_MASK                                                                 0x00000001L
+#define VCN_CE_ERR_STATUS_HI_MMSCHD__Other_MASK                                                               0x00000002L
+#define VCN_CE_ERR_STATUS_HI_MMSCHD__Err_Info_Valid_Flag_MASK                                                 0x00000004L
+#define VCN_CE_ERR_STATUS_HI_MMSCHD__Err_Info_MASK                                                            0x007FFFF8L
+#define VCN_CE_ERR_STATUS_HI_MMSCHD__CE_Cnt_MASK                                                              0x03800000L
+#define VCN_CE_ERR_STATUS_HI_MMSCHD__Poison_MASK                                                              0x10000000L
+#define VCN_CE_ERR_STATUS_HI_MMSCHD__RESERVED_MASK                                                            0x60000000L
+#define VCN_CE_ERR_STATUS_HI_MMSCHD__Err_clr_MASK                                                             0x80000000L
+//VCN_UE_ERR_STATUS_LO_JPEG0S
+#define VCN_UE_ERR_STATUS_LO_JPEG0S__Err_Status_Valid_Flag__SHIFT                                             0x0
+#define VCN_UE_ERR_STATUS_LO_JPEG0S__Address_Valid_Flag__SHIFT                                                0x1
+#define VCN_UE_ERR_STATUS_LO_JPEG0S__Address__SHIFT                                                           0x2
+#define VCN_UE_ERR_STATUS_LO_JPEG0S__Memory_id__SHIFT                                                         0x18
+#define VCN_UE_ERR_STATUS_LO_JPEG0S__Err_Status_Valid_Flag_MASK                                               0x00000001L
+#define VCN_UE_ERR_STATUS_LO_JPEG0S__Address_Valid_Flag_MASK                                                  0x00000002L
+#define VCN_UE_ERR_STATUS_LO_JPEG0S__Address_MASK                                                             0x00FFFFFCL
+#define VCN_UE_ERR_STATUS_LO_JPEG0S__Memory_id_MASK                                                           0xFF000000L
+//VCN_UE_ERR_STATUS_HI_JPEG0S
+#define VCN_UE_ERR_STATUS_HI_JPEG0S__ECC__SHIFT                                                               0x0
+#define VCN_UE_ERR_STATUS_HI_JPEG0S__Parity__SHIFT                                                            0x1
+#define VCN_UE_ERR_STATUS_HI_JPEG0S__Err_Info_Valid_Flag__SHIFT                                               0x2
+#define VCN_UE_ERR_STATUS_HI_JPEG0S__Err_Info__SHIFT                                                          0x3
+#define VCN_UE_ERR_STATUS_HI_JPEG0S__UE_Cnt__SHIFT                                                            0x17
+#define VCN_UE_ERR_STATUS_HI_JPEG0S__FED_Cnt__SHIFT                                                           0x1a
+#define VCN_UE_ERR_STATUS_HI_JPEG0S__RESERVED__SHIFT                                                          0x1d
+#define VCN_UE_ERR_STATUS_HI_JPEG0S__Err_clr__SHIFT                                                           0x1f
+#define VCN_UE_ERR_STATUS_HI_JPEG0S__ECC_MASK                                                                 0x00000001L
+#define VCN_UE_ERR_STATUS_HI_JPEG0S__Parity_MASK                                                              0x00000002L
+#define VCN_UE_ERR_STATUS_HI_JPEG0S__Err_Info_Valid_Flag_MASK                                                 0x00000004L
+#define VCN_UE_ERR_STATUS_HI_JPEG0S__Err_Info_MASK                                                            0x007FFFF8L
+#define VCN_UE_ERR_STATUS_HI_JPEG0S__UE_Cnt_MASK                                                              0x03800000L
+#define VCN_UE_ERR_STATUS_HI_JPEG0S__FED_Cnt_MASK                                                             0x1C000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG0S__RESERVED_MASK                                                            0x60000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG0S__Err_clr_MASK                                                             0x80000000L
+//VCN_UE_ERR_STATUS_LO_JPEG0D
+#define VCN_UE_ERR_STATUS_LO_JPEG0D__Err_Status_Valid_Flag__SHIFT                                             0x0
+#define VCN_UE_ERR_STATUS_LO_JPEG0D__Address_Valid_Flag__SHIFT                                                0x1
+#define VCN_UE_ERR_STATUS_LO_JPEG0D__Address__SHIFT                                                           0x2
+#define VCN_UE_ERR_STATUS_LO_JPEG0D__Memory_id__SHIFT                                                         0x18
+#define VCN_UE_ERR_STATUS_LO_JPEG0D__Err_Status_Valid_Flag_MASK                                               0x00000001L
+#define VCN_UE_ERR_STATUS_LO_JPEG0D__Address_Valid_Flag_MASK                                                  0x00000002L
+#define VCN_UE_ERR_STATUS_LO_JPEG0D__Address_MASK                                                             0x00FFFFFCL
+#define VCN_UE_ERR_STATUS_LO_JPEG0D__Memory_id_MASK                                                           0xFF000000L
+//VCN_UE_ERR_STATUS_HI_JPEG0D
+#define VCN_UE_ERR_STATUS_HI_JPEG0D__ECC__SHIFT                                                               0x0
+#define VCN_UE_ERR_STATUS_HI_JPEG0D__Parity__SHIFT                                                            0x1
+#define VCN_UE_ERR_STATUS_HI_JPEG0D__Err_Info_Valid_Flag__SHIFT                                               0x2
+#define VCN_UE_ERR_STATUS_HI_JPEG0D__Err_Info__SHIFT                                                          0x3
+#define VCN_UE_ERR_STATUS_HI_JPEG0D__UE_Cnt__SHIFT                                                            0x17
+#define VCN_UE_ERR_STATUS_HI_JPEG0D__FED_Cnt__SHIFT                                                           0x1a
+#define VCN_UE_ERR_STATUS_HI_JPEG0D__RESERVED__SHIFT                                                          0x1d
+#define VCN_UE_ERR_STATUS_HI_JPEG0D__Err_clr__SHIFT                                                           0x1f
+#define VCN_UE_ERR_STATUS_HI_JPEG0D__ECC_MASK                                                                 0x00000001L
+#define VCN_UE_ERR_STATUS_HI_JPEG0D__Parity_MASK                                                              0x00000002L
+#define VCN_UE_ERR_STATUS_HI_JPEG0D__Err_Info_Valid_Flag_MASK                                                 0x00000004L
+#define VCN_UE_ERR_STATUS_HI_JPEG0D__Err_Info_MASK                                                            0x007FFFF8L
+#define VCN_UE_ERR_STATUS_HI_JPEG0D__UE_Cnt_MASK                                                              0x03800000L
+#define VCN_UE_ERR_STATUS_HI_JPEG0D__FED_Cnt_MASK                                                             0x1C000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG0D__RESERVED_MASK                                                            0x60000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG0D__Err_clr_MASK                                                             0x80000000L
+//VCN_UE_ERR_STATUS_LO_JPEG1S
+#define VCN_UE_ERR_STATUS_LO_JPEG1S__Err_Status_Valid_Flag__SHIFT                                             0x0
+#define VCN_UE_ERR_STATUS_LO_JPEG1S__Address_Valid_Flag__SHIFT                                                0x1
+#define VCN_UE_ERR_STATUS_LO_JPEG1S__Address__SHIFT                                                           0x2
+#define VCN_UE_ERR_STATUS_LO_JPEG1S__Memory_id__SHIFT                                                         0x18
+#define VCN_UE_ERR_STATUS_LO_JPEG1S__Err_Status_Valid_Flag_MASK                                               0x00000001L
+#define VCN_UE_ERR_STATUS_LO_JPEG1S__Address_Valid_Flag_MASK                                                  0x00000002L
+#define VCN_UE_ERR_STATUS_LO_JPEG1S__Address_MASK                                                             0x00FFFFFCL
+#define VCN_UE_ERR_STATUS_LO_JPEG1S__Memory_id_MASK                                                           0xFF000000L
+//VCN_UE_ERR_STATUS_HI_JPEG1S
+#define VCN_UE_ERR_STATUS_HI_JPEG1S__ECC__SHIFT                                                               0x0
+#define VCN_UE_ERR_STATUS_HI_JPEG1S__Parity__SHIFT                                                            0x1
+#define VCN_UE_ERR_STATUS_HI_JPEG1S__Err_Info_Valid_Flag__SHIFT                                               0x2
+#define VCN_UE_ERR_STATUS_HI_JPEG1S__Err_Info__SHIFT                                                          0x3
+#define VCN_UE_ERR_STATUS_HI_JPEG1S__UE_Cnt__SHIFT                                                            0x17
+#define VCN_UE_ERR_STATUS_HI_JPEG1S__FED_Cnt__SHIFT                                                           0x1a
+#define VCN_UE_ERR_STATUS_HI_JPEG1S__RESERVED__SHIFT                                                          0x1d
+#define VCN_UE_ERR_STATUS_HI_JPEG1S__Err_clr__SHIFT                                                           0x1f
+#define VCN_UE_ERR_STATUS_HI_JPEG1S__ECC_MASK                                                                 0x00000001L
+#define VCN_UE_ERR_STATUS_HI_JPEG1S__Parity_MASK                                                              0x00000002L
+#define VCN_UE_ERR_STATUS_HI_JPEG1S__Err_Info_Valid_Flag_MASK                                                 0x00000004L
+#define VCN_UE_ERR_STATUS_HI_JPEG1S__Err_Info_MASK                                                            0x007FFFF8L
+#define VCN_UE_ERR_STATUS_HI_JPEG1S__UE_Cnt_MASK                                                              0x03800000L
+#define VCN_UE_ERR_STATUS_HI_JPEG1S__FED_Cnt_MASK                                                             0x1C000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG1S__RESERVED_MASK                                                            0x60000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG1S__Err_clr_MASK                                                             0x80000000L
+//VCN_UE_ERR_STATUS_LO_JPEG1D
+#define VCN_UE_ERR_STATUS_LO_JPEG1D__Err_Status_Valid_Flag__SHIFT                                             0x0
+#define VCN_UE_ERR_STATUS_LO_JPEG1D__Address_Valid_Flag__SHIFT                                                0x1
+#define VCN_UE_ERR_STATUS_LO_JPEG1D__Address__SHIFT                                                           0x2
+#define VCN_UE_ERR_STATUS_LO_JPEG1D__Memory_id__SHIFT                                                         0x18
+#define VCN_UE_ERR_STATUS_LO_JPEG1D__Err_Status_Valid_Flag_MASK                                               0x00000001L
+#define VCN_UE_ERR_STATUS_LO_JPEG1D__Address_Valid_Flag_MASK                                                  0x00000002L
+#define VCN_UE_ERR_STATUS_LO_JPEG1D__Address_MASK                                                             0x00FFFFFCL
+#define VCN_UE_ERR_STATUS_LO_JPEG1D__Memory_id_MASK                                                           0xFF000000L
+//VCN_UE_ERR_STATUS_HI_JPEG1D
+#define VCN_UE_ERR_STATUS_HI_JPEG1D__ECC__SHIFT                                                               0x0
+#define VCN_UE_ERR_STATUS_HI_JPEG1D__Parity__SHIFT                                                            0x1
+#define VCN_UE_ERR_STATUS_HI_JPEG1D__Err_Info_Valid_Flag__SHIFT                                               0x2
+#define VCN_UE_ERR_STATUS_HI_JPEG1D__Err_Info__SHIFT                                                          0x3
+#define VCN_UE_ERR_STATUS_HI_JPEG1D__UE_Cnt__SHIFT                                                            0x17
+#define VCN_UE_ERR_STATUS_HI_JPEG1D__FED_Cnt__SHIFT                                                           0x1a
+#define VCN_UE_ERR_STATUS_HI_JPEG1D__RESERVED__SHIFT                                                          0x1d
+#define VCN_UE_ERR_STATUS_HI_JPEG1D__Err_clr__SHIFT                                                           0x1f
+#define VCN_UE_ERR_STATUS_HI_JPEG1D__ECC_MASK                                                                 0x00000001L
+#define VCN_UE_ERR_STATUS_HI_JPEG1D__Parity_MASK                                                              0x00000002L
+#define VCN_UE_ERR_STATUS_HI_JPEG1D__Err_Info_Valid_Flag_MASK                                                 0x00000004L
+#define VCN_UE_ERR_STATUS_HI_JPEG1D__Err_Info_MASK                                                            0x007FFFF8L
+#define VCN_UE_ERR_STATUS_HI_JPEG1D__UE_Cnt_MASK                                                              0x03800000L
+#define VCN_UE_ERR_STATUS_HI_JPEG1D__FED_Cnt_MASK                                                             0x1C000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG1D__RESERVED_MASK                                                            0x60000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG1D__Err_clr_MASK                                                             0x80000000L
+//VCN_UE_ERR_STATUS_LO_JPEG2S
+#define VCN_UE_ERR_STATUS_LO_JPEG2S__Err_Status_Valid_Flag__SHIFT                                             0x0
+#define VCN_UE_ERR_STATUS_LO_JPEG2S__Address_Valid_Flag__SHIFT                                                0x1
+#define VCN_UE_ERR_STATUS_LO_JPEG2S__Address__SHIFT                                                           0x2
+#define VCN_UE_ERR_STATUS_LO_JPEG2S__Memory_id__SHIFT                                                         0x18
+#define VCN_UE_ERR_STATUS_LO_JPEG2S__Err_Status_Valid_Flag_MASK                                               0x00000001L
+#define VCN_UE_ERR_STATUS_LO_JPEG2S__Address_Valid_Flag_MASK                                                  0x00000002L
+#define VCN_UE_ERR_STATUS_LO_JPEG2S__Address_MASK                                                             0x00FFFFFCL
+#define VCN_UE_ERR_STATUS_LO_JPEG2S__Memory_id_MASK                                                           0xFF000000L
+//VCN_UE_ERR_STATUS_HI_JPEG2S
+#define VCN_UE_ERR_STATUS_HI_JPEG2S__ECC__SHIFT                                                               0x0
+#define VCN_UE_ERR_STATUS_HI_JPEG2S__Parity__SHIFT                                                            0x1
+#define VCN_UE_ERR_STATUS_HI_JPEG2S__Err_Info_Valid_Flag__SHIFT                                               0x2
+#define VCN_UE_ERR_STATUS_HI_JPEG2S__Err_Info__SHIFT                                                          0x3
+#define VCN_UE_ERR_STATUS_HI_JPEG2S__UE_Cnt__SHIFT                                                            0x17
+#define VCN_UE_ERR_STATUS_HI_JPEG2S__FED_Cnt__SHIFT                                                           0x1a
+#define VCN_UE_ERR_STATUS_HI_JPEG2S__RESERVED__SHIFT                                                          0x1d
+#define VCN_UE_ERR_STATUS_HI_JPEG2S__Err_clr__SHIFT                                                           0x1f
+#define VCN_UE_ERR_STATUS_HI_JPEG2S__ECC_MASK                                                                 0x00000001L
+#define VCN_UE_ERR_STATUS_HI_JPEG2S__Parity_MASK                                                              0x00000002L
+#define VCN_UE_ERR_STATUS_HI_JPEG2S__Err_Info_Valid_Flag_MASK                                                 0x00000004L
+#define VCN_UE_ERR_STATUS_HI_JPEG2S__Err_Info_MASK                                                            0x007FFFF8L
+#define VCN_UE_ERR_STATUS_HI_JPEG2S__UE_Cnt_MASK                                                              0x03800000L
+#define VCN_UE_ERR_STATUS_HI_JPEG2S__FED_Cnt_MASK                                                             0x1C000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG2S__RESERVED_MASK                                                            0x60000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG2S__Err_clr_MASK                                                             0x80000000L
+//VCN_UE_ERR_STATUS_LO_JPEG2D
+#define VCN_UE_ERR_STATUS_LO_JPEG2D__Err_Status_Valid_Flag__SHIFT                                             0x0
+#define VCN_UE_ERR_STATUS_LO_JPEG2D__Address_Valid_Flag__SHIFT                                                0x1
+#define VCN_UE_ERR_STATUS_LO_JPEG2D__Address__SHIFT                                                           0x2
+#define VCN_UE_ERR_STATUS_LO_JPEG2D__Memory_id__SHIFT                                                         0x18
+#define VCN_UE_ERR_STATUS_LO_JPEG2D__Err_Status_Valid_Flag_MASK                                               0x00000001L
+#define VCN_UE_ERR_STATUS_LO_JPEG2D__Address_Valid_Flag_MASK                                                  0x00000002L
+#define VCN_UE_ERR_STATUS_LO_JPEG2D__Address_MASK                                                             0x00FFFFFCL
+#define VCN_UE_ERR_STATUS_LO_JPEG2D__Memory_id_MASK                                                           0xFF000000L
+//VCN_UE_ERR_STATUS_HI_JPEG2D
+#define VCN_UE_ERR_STATUS_HI_JPEG2D__ECC__SHIFT                                                               0x0
+#define VCN_UE_ERR_STATUS_HI_JPEG2D__Parity__SHIFT                                                            0x1
+#define VCN_UE_ERR_STATUS_HI_JPEG2D__Err_Info_Valid_Flag__SHIFT                                               0x2
+#define VCN_UE_ERR_STATUS_HI_JPEG2D__Err_Info__SHIFT                                                          0x3
+#define VCN_UE_ERR_STATUS_HI_JPEG2D__UE_Cnt__SHIFT                                                            0x17
+#define VCN_UE_ERR_STATUS_HI_JPEG2D__FED_Cnt__SHIFT                                                           0x1a
+#define VCN_UE_ERR_STATUS_HI_JPEG2D__RESERVED__SHIFT                                                          0x1d
+#define VCN_UE_ERR_STATUS_HI_JPEG2D__Err_clr__SHIFT                                                           0x1f
+#define VCN_UE_ERR_STATUS_HI_JPEG2D__ECC_MASK                                                                 0x00000001L
+#define VCN_UE_ERR_STATUS_HI_JPEG2D__Parity_MASK                                                              0x00000002L
+#define VCN_UE_ERR_STATUS_HI_JPEG2D__Err_Info_Valid_Flag_MASK                                                 0x00000004L
+#define VCN_UE_ERR_STATUS_HI_JPEG2D__Err_Info_MASK                                                            0x007FFFF8L
+#define VCN_UE_ERR_STATUS_HI_JPEG2D__UE_Cnt_MASK                                                              0x03800000L
+#define VCN_UE_ERR_STATUS_HI_JPEG2D__FED_Cnt_MASK                                                             0x1C000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG2D__RESERVED_MASK                                                            0x60000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG2D__Err_clr_MASK                                                             0x80000000L
+//VCN_UE_ERR_STATUS_LO_JPEG3S
+#define VCN_UE_ERR_STATUS_LO_JPEG3S__Err_Status_Valid_Flag__SHIFT                                             0x0
+#define VCN_UE_ERR_STATUS_LO_JPEG3S__Address_Valid_Flag__SHIFT                                                0x1
+#define VCN_UE_ERR_STATUS_LO_JPEG3S__Address__SHIFT                                                           0x2
+#define VCN_UE_ERR_STATUS_LO_JPEG3S__Memory_id__SHIFT                                                         0x18
+#define VCN_UE_ERR_STATUS_LO_JPEG3S__Err_Status_Valid_Flag_MASK                                               0x00000001L
+#define VCN_UE_ERR_STATUS_LO_JPEG3S__Address_Valid_Flag_MASK                                                  0x00000002L
+#define VCN_UE_ERR_STATUS_LO_JPEG3S__Address_MASK                                                             0x00FFFFFCL
+#define VCN_UE_ERR_STATUS_LO_JPEG3S__Memory_id_MASK                                                           0xFF000000L
+//VCN_UE_ERR_STATUS_HI_JPEG3S
+#define VCN_UE_ERR_STATUS_HI_JPEG3S__ECC__SHIFT                                                               0x0
+#define VCN_UE_ERR_STATUS_HI_JPEG3S__Parity__SHIFT                                                            0x1
+#define VCN_UE_ERR_STATUS_HI_JPEG3S__Err_Info_Valid_Flag__SHIFT                                               0x2
+#define VCN_UE_ERR_STATUS_HI_JPEG3S__Err_Info__SHIFT                                                          0x3
+#define VCN_UE_ERR_STATUS_HI_JPEG3S__UE_Cnt__SHIFT                                                            0x17
+#define VCN_UE_ERR_STATUS_HI_JPEG3S__FED_Cnt__SHIFT                                                           0x1a
+#define VCN_UE_ERR_STATUS_HI_JPEG3S__RESERVED__SHIFT                                                          0x1d
+#define VCN_UE_ERR_STATUS_HI_JPEG3S__Err_clr__SHIFT                                                           0x1f
+#define VCN_UE_ERR_STATUS_HI_JPEG3S__ECC_MASK                                                                 0x00000001L
+#define VCN_UE_ERR_STATUS_HI_JPEG3S__Parity_MASK                                                              0x00000002L
+#define VCN_UE_ERR_STATUS_HI_JPEG3S__Err_Info_Valid_Flag_MASK                                                 0x00000004L
+#define VCN_UE_ERR_STATUS_HI_JPEG3S__Err_Info_MASK                                                            0x007FFFF8L
+#define VCN_UE_ERR_STATUS_HI_JPEG3S__UE_Cnt_MASK                                                              0x03800000L
+#define VCN_UE_ERR_STATUS_HI_JPEG3S__FED_Cnt_MASK                                                             0x1C000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG3S__RESERVED_MASK                                                            0x60000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG3S__Err_clr_MASK                                                             0x80000000L
+//VCN_UE_ERR_STATUS_LO_JPEG3D
+#define VCN_UE_ERR_STATUS_LO_JPEG3D__Err_Status_Valid_Flag__SHIFT                                             0x0
+#define VCN_UE_ERR_STATUS_LO_JPEG3D__Address_Valid_Flag__SHIFT                                                0x1
+#define VCN_UE_ERR_STATUS_LO_JPEG3D__Address__SHIFT                                                           0x2
+#define VCN_UE_ERR_STATUS_LO_JPEG3D__Memory_id__SHIFT                                                         0x18
+#define VCN_UE_ERR_STATUS_LO_JPEG3D__Err_Status_Valid_Flag_MASK                                               0x00000001L
+#define VCN_UE_ERR_STATUS_LO_JPEG3D__Address_Valid_Flag_MASK                                                  0x00000002L
+#define VCN_UE_ERR_STATUS_LO_JPEG3D__Address_MASK                                                             0x00FFFFFCL
+#define VCN_UE_ERR_STATUS_LO_JPEG3D__Memory_id_MASK                                                           0xFF000000L
+//VCN_UE_ERR_STATUS_HI_JPEG3D
+#define VCN_UE_ERR_STATUS_HI_JPEG3D__ECC__SHIFT                                                               0x0
+#define VCN_UE_ERR_STATUS_HI_JPEG3D__Parity__SHIFT                                                            0x1
+#define VCN_UE_ERR_STATUS_HI_JPEG3D__Err_Info_Valid_Flag__SHIFT                                               0x2
+#define VCN_UE_ERR_STATUS_HI_JPEG3D__Err_Info__SHIFT                                                          0x3
+#define VCN_UE_ERR_STATUS_HI_JPEG3D__UE_Cnt__SHIFT                                                            0x17
+#define VCN_UE_ERR_STATUS_HI_JPEG3D__FED_Cnt__SHIFT                                                           0x1a
+#define VCN_UE_ERR_STATUS_HI_JPEG3D__RESERVED__SHIFT                                                          0x1d
+#define VCN_UE_ERR_STATUS_HI_JPEG3D__Err_clr__SHIFT                                                           0x1f
+#define VCN_UE_ERR_STATUS_HI_JPEG3D__ECC_MASK                                                                 0x00000001L
+#define VCN_UE_ERR_STATUS_HI_JPEG3D__Parity_MASK                                                              0x00000002L
+#define VCN_UE_ERR_STATUS_HI_JPEG3D__Err_Info_Valid_Flag_MASK                                                 0x00000004L
+#define VCN_UE_ERR_STATUS_HI_JPEG3D__Err_Info_MASK                                                            0x007FFFF8L
+#define VCN_UE_ERR_STATUS_HI_JPEG3D__UE_Cnt_MASK                                                              0x03800000L
+#define VCN_UE_ERR_STATUS_HI_JPEG3D__FED_Cnt_MASK                                                             0x1C000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG3D__RESERVED_MASK                                                            0x60000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG3D__Err_clr_MASK                                                             0x80000000L
+//VCN_UE_ERR_STATUS_LO_JPEG4S
+#define VCN_UE_ERR_STATUS_LO_JPEG4S__Err_Status_Valid_Flag__SHIFT                                             0x0
+#define VCN_UE_ERR_STATUS_LO_JPEG4S__Address_Valid_Flag__SHIFT                                                0x1
+#define VCN_UE_ERR_STATUS_LO_JPEG4S__Address__SHIFT                                                           0x2
+#define VCN_UE_ERR_STATUS_LO_JPEG4S__Memory_id__SHIFT                                                         0x18
+#define VCN_UE_ERR_STATUS_LO_JPEG4S__Err_Status_Valid_Flag_MASK                                               0x00000001L
+#define VCN_UE_ERR_STATUS_LO_JPEG4S__Address_Valid_Flag_MASK                                                  0x00000002L
+#define VCN_UE_ERR_STATUS_LO_JPEG4S__Address_MASK                                                             0x00FFFFFCL
+#define VCN_UE_ERR_STATUS_LO_JPEG4S__Memory_id_MASK                                                           0xFF000000L
+//VCN_UE_ERR_STATUS_HI_JPEG4S
+#define VCN_UE_ERR_STATUS_HI_JPEG4S__ECC__SHIFT                                                               0x0
+#define VCN_UE_ERR_STATUS_HI_JPEG4S__Parity__SHIFT                                                            0x1
+#define VCN_UE_ERR_STATUS_HI_JPEG4S__Err_Info_Valid_Flag__SHIFT                                               0x2
+#define VCN_UE_ERR_STATUS_HI_JPEG4S__Err_Info__SHIFT                                                          0x3
+#define VCN_UE_ERR_STATUS_HI_JPEG4S__UE_Cnt__SHIFT                                                            0x17
+#define VCN_UE_ERR_STATUS_HI_JPEG4S__FED_Cnt__SHIFT                                                           0x1a
+#define VCN_UE_ERR_STATUS_HI_JPEG4S__RESERVED__SHIFT                                                          0x1d
+#define VCN_UE_ERR_STATUS_HI_JPEG4S__Err_clr__SHIFT                                                           0x1f
+#define VCN_UE_ERR_STATUS_HI_JPEG4S__ECC_MASK                                                                 0x00000001L
+#define VCN_UE_ERR_STATUS_HI_JPEG4S__Parity_MASK                                                              0x00000002L
+#define VCN_UE_ERR_STATUS_HI_JPEG4S__Err_Info_Valid_Flag_MASK                                                 0x00000004L
+#define VCN_UE_ERR_STATUS_HI_JPEG4S__Err_Info_MASK                                                            0x007FFFF8L
+#define VCN_UE_ERR_STATUS_HI_JPEG4S__UE_Cnt_MASK                                                              0x03800000L
+#define VCN_UE_ERR_STATUS_HI_JPEG4S__FED_Cnt_MASK                                                             0x1C000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG4S__RESERVED_MASK                                                            0x60000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG4S__Err_clr_MASK                                                             0x80000000L
+//VCN_UE_ERR_STATUS_LO_JPEG4D
+#define VCN_UE_ERR_STATUS_LO_JPEG4D__Err_Status_Valid_Flag__SHIFT                                             0x0
+#define VCN_UE_ERR_STATUS_LO_JPEG4D__Address_Valid_Flag__SHIFT                                                0x1
+#define VCN_UE_ERR_STATUS_LO_JPEG4D__Address__SHIFT                                                           0x2
+#define VCN_UE_ERR_STATUS_LO_JPEG4D__Memory_id__SHIFT                                                         0x18
+#define VCN_UE_ERR_STATUS_LO_JPEG4D__Err_Status_Valid_Flag_MASK                                               0x00000001L
+#define VCN_UE_ERR_STATUS_LO_JPEG4D__Address_Valid_Flag_MASK                                                  0x00000002L
+#define VCN_UE_ERR_STATUS_LO_JPEG4D__Address_MASK                                                             0x00FFFFFCL
+#define VCN_UE_ERR_STATUS_LO_JPEG4D__Memory_id_MASK                                                           0xFF000000L
+//VCN_UE_ERR_STATUS_HI_JPEG4D
+#define VCN_UE_ERR_STATUS_HI_JPEG4D__ECC__SHIFT                                                               0x0
+#define VCN_UE_ERR_STATUS_HI_JPEG4D__Parity__SHIFT                                                            0x1
+#define VCN_UE_ERR_STATUS_HI_JPEG4D__Err_Info_Valid_Flag__SHIFT                                               0x2
+#define VCN_UE_ERR_STATUS_HI_JPEG4D__Err_Info__SHIFT                                                          0x3
+#define VCN_UE_ERR_STATUS_HI_JPEG4D__UE_Cnt__SHIFT                                                            0x17
+#define VCN_UE_ERR_STATUS_HI_JPEG4D__FED_Cnt__SHIFT                                                           0x1a
+#define VCN_UE_ERR_STATUS_HI_JPEG4D__RESERVED__SHIFT                                                          0x1d
+#define VCN_UE_ERR_STATUS_HI_JPEG4D__Err_clr__SHIFT                                                           0x1f
+#define VCN_UE_ERR_STATUS_HI_JPEG4D__ECC_MASK                                                                 0x00000001L
+#define VCN_UE_ERR_STATUS_HI_JPEG4D__Parity_MASK                                                              0x00000002L
+#define VCN_UE_ERR_STATUS_HI_JPEG4D__Err_Info_Valid_Flag_MASK                                                 0x00000004L
+#define VCN_UE_ERR_STATUS_HI_JPEG4D__Err_Info_MASK                                                            0x007FFFF8L
+#define VCN_UE_ERR_STATUS_HI_JPEG4D__UE_Cnt_MASK                                                              0x03800000L
+#define VCN_UE_ERR_STATUS_HI_JPEG4D__FED_Cnt_MASK                                                             0x1C000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG4D__RESERVED_MASK                                                            0x60000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG4D__Err_clr_MASK                                                             0x80000000L
+//VCN_UE_ERR_STATUS_LO_JPEG5S
+#define VCN_UE_ERR_STATUS_LO_JPEG5S__Err_Status_Valid_Flag__SHIFT                                             0x0
+#define VCN_UE_ERR_STATUS_LO_JPEG5S__Address_Valid_Flag__SHIFT                                                0x1
+#define VCN_UE_ERR_STATUS_LO_JPEG5S__Address__SHIFT                                                           0x2
+#define VCN_UE_ERR_STATUS_LO_JPEG5S__Memory_id__SHIFT                                                         0x18
+#define VCN_UE_ERR_STATUS_LO_JPEG5S__Err_Status_Valid_Flag_MASK                                               0x00000001L
+#define VCN_UE_ERR_STATUS_LO_JPEG5S__Address_Valid_Flag_MASK                                                  0x00000002L
+#define VCN_UE_ERR_STATUS_LO_JPEG5S__Address_MASK                                                             0x00FFFFFCL
+#define VCN_UE_ERR_STATUS_LO_JPEG5S__Memory_id_MASK                                                           0xFF000000L
+//VCN_UE_ERR_STATUS_HI_JPEG5S
+#define VCN_UE_ERR_STATUS_HI_JPEG5S__ECC__SHIFT                                                               0x0
+#define VCN_UE_ERR_STATUS_HI_JPEG5S__Parity__SHIFT                                                            0x1
+#define VCN_UE_ERR_STATUS_HI_JPEG5S__Err_Info_Valid_Flag__SHIFT                                               0x2
+#define VCN_UE_ERR_STATUS_HI_JPEG5S__Err_Info__SHIFT                                                          0x3
+#define VCN_UE_ERR_STATUS_HI_JPEG5S__UE_Cnt__SHIFT                                                            0x17
+#define VCN_UE_ERR_STATUS_HI_JPEG5S__FED_Cnt__SHIFT                                                           0x1a
+#define VCN_UE_ERR_STATUS_HI_JPEG5S__RESERVED__SHIFT                                                          0x1d
+#define VCN_UE_ERR_STATUS_HI_JPEG5S__Err_clr__SHIFT                                                           0x1f
+#define VCN_UE_ERR_STATUS_HI_JPEG5S__ECC_MASK                                                                 0x00000001L
+#define VCN_UE_ERR_STATUS_HI_JPEG5S__Parity_MASK                                                              0x00000002L
+#define VCN_UE_ERR_STATUS_HI_JPEG5S__Err_Info_Valid_Flag_MASK                                                 0x00000004L
+#define VCN_UE_ERR_STATUS_HI_JPEG5S__Err_Info_MASK                                                            0x007FFFF8L
+#define VCN_UE_ERR_STATUS_HI_JPEG5S__UE_Cnt_MASK                                                              0x03800000L
+#define VCN_UE_ERR_STATUS_HI_JPEG5S__FED_Cnt_MASK                                                             0x1C000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG5S__RESERVED_MASK                                                            0x60000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG5S__Err_clr_MASK                                                             0x80000000L
+//VCN_UE_ERR_STATUS_LO_JPEG5D
+#define VCN_UE_ERR_STATUS_LO_JPEG5D__Err_Status_Valid_Flag__SHIFT                                             0x0
+#define VCN_UE_ERR_STATUS_LO_JPEG5D__Address_Valid_Flag__SHIFT                                                0x1
+#define VCN_UE_ERR_STATUS_LO_JPEG5D__Address__SHIFT                                                           0x2
+#define VCN_UE_ERR_STATUS_LO_JPEG5D__Memory_id__SHIFT                                                         0x18
+#define VCN_UE_ERR_STATUS_LO_JPEG5D__Err_Status_Valid_Flag_MASK                                               0x00000001L
+#define VCN_UE_ERR_STATUS_LO_JPEG5D__Address_Valid_Flag_MASK                                                  0x00000002L
+#define VCN_UE_ERR_STATUS_LO_JPEG5D__Address_MASK                                                             0x00FFFFFCL
+#define VCN_UE_ERR_STATUS_LO_JPEG5D__Memory_id_MASK                                                           0xFF000000L
+//VCN_UE_ERR_STATUS_HI_JPEG5D
+#define VCN_UE_ERR_STATUS_HI_JPEG5D__ECC__SHIFT                                                               0x0
+#define VCN_UE_ERR_STATUS_HI_JPEG5D__Parity__SHIFT                                                            0x1
+#define VCN_UE_ERR_STATUS_HI_JPEG5D__Err_Info_Valid_Flag__SHIFT                                               0x2
+#define VCN_UE_ERR_STATUS_HI_JPEG5D__Err_Info__SHIFT                                                          0x3
+#define VCN_UE_ERR_STATUS_HI_JPEG5D__UE_Cnt__SHIFT                                                            0x17
+#define VCN_UE_ERR_STATUS_HI_JPEG5D__FED_Cnt__SHIFT                                                           0x1a
+#define VCN_UE_ERR_STATUS_HI_JPEG5D__RESERVED__SHIFT                                                          0x1d
+#define VCN_UE_ERR_STATUS_HI_JPEG5D__Err_clr__SHIFT                                                           0x1f
+#define VCN_UE_ERR_STATUS_HI_JPEG5D__ECC_MASK                                                                 0x00000001L
+#define VCN_UE_ERR_STATUS_HI_JPEG5D__Parity_MASK                                                              0x00000002L
+#define VCN_UE_ERR_STATUS_HI_JPEG5D__Err_Info_Valid_Flag_MASK                                                 0x00000004L
+#define VCN_UE_ERR_STATUS_HI_JPEG5D__Err_Info_MASK                                                            0x007FFFF8L
+#define VCN_UE_ERR_STATUS_HI_JPEG5D__UE_Cnt_MASK                                                              0x03800000L
+#define VCN_UE_ERR_STATUS_HI_JPEG5D__FED_Cnt_MASK                                                             0x1C000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG5D__RESERVED_MASK                                                            0x60000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG5D__Err_clr_MASK                                                             0x80000000L
+//VCN_UE_ERR_STATUS_LO_JPEG6S
+#define VCN_UE_ERR_STATUS_LO_JPEG6S__Err_Status_Valid_Flag__SHIFT                                             0x0
+#define VCN_UE_ERR_STATUS_LO_JPEG6S__Address_Valid_Flag__SHIFT                                                0x1
+#define VCN_UE_ERR_STATUS_LO_JPEG6S__Address__SHIFT                                                           0x2
+#define VCN_UE_ERR_STATUS_LO_JPEG6S__Memory_id__SHIFT                                                         0x18
+#define VCN_UE_ERR_STATUS_LO_JPEG6S__Err_Status_Valid_Flag_MASK                                               0x00000001L
+#define VCN_UE_ERR_STATUS_LO_JPEG6S__Address_Valid_Flag_MASK                                                  0x00000002L
+#define VCN_UE_ERR_STATUS_LO_JPEG6S__Address_MASK                                                             0x00FFFFFCL
+#define VCN_UE_ERR_STATUS_LO_JPEG6S__Memory_id_MASK                                                           0xFF000000L
+//VCN_UE_ERR_STATUS_HI_JPEG6S
+#define VCN_UE_ERR_STATUS_HI_JPEG6S__ECC__SHIFT                                                               0x0
+#define VCN_UE_ERR_STATUS_HI_JPEG6S__Parity__SHIFT                                                            0x1
+#define VCN_UE_ERR_STATUS_HI_JPEG6S__Err_Info_Valid_Flag__SHIFT                                               0x2
+#define VCN_UE_ERR_STATUS_HI_JPEG6S__Err_Info__SHIFT                                                          0x3
+#define VCN_UE_ERR_STATUS_HI_JPEG6S__UE_Cnt__SHIFT                                                            0x17
+#define VCN_UE_ERR_STATUS_HI_JPEG6S__FED_Cnt__SHIFT                                                           0x1a
+#define VCN_UE_ERR_STATUS_HI_JPEG6S__RESERVED__SHIFT                                                          0x1d
+#define VCN_UE_ERR_STATUS_HI_JPEG6S__Err_clr__SHIFT                                                           0x1f
+#define VCN_UE_ERR_STATUS_HI_JPEG6S__ECC_MASK                                                                 0x00000001L
+#define VCN_UE_ERR_STATUS_HI_JPEG6S__Parity_MASK                                                              0x00000002L
+#define VCN_UE_ERR_STATUS_HI_JPEG6S__Err_Info_Valid_Flag_MASK                                                 0x00000004L
+#define VCN_UE_ERR_STATUS_HI_JPEG6S__Err_Info_MASK                                                            0x007FFFF8L
+#define VCN_UE_ERR_STATUS_HI_JPEG6S__UE_Cnt_MASK                                                              0x03800000L
+#define VCN_UE_ERR_STATUS_HI_JPEG6S__FED_Cnt_MASK                                                             0x1C000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG6S__RESERVED_MASK                                                            0x60000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG6S__Err_clr_MASK                                                             0x80000000L
+//VCN_UE_ERR_STATUS_LO_JPEG6D
+#define VCN_UE_ERR_STATUS_LO_JPEG6D__Err_Status_Valid_Flag__SHIFT                                             0x0
+#define VCN_UE_ERR_STATUS_LO_JPEG6D__Address_Valid_Flag__SHIFT                                                0x1
+#define VCN_UE_ERR_STATUS_LO_JPEG6D__Address__SHIFT                                                           0x2
+#define VCN_UE_ERR_STATUS_LO_JPEG6D__Memory_id__SHIFT                                                         0x18
+#define VCN_UE_ERR_STATUS_LO_JPEG6D__Err_Status_Valid_Flag_MASK                                               0x00000001L
+#define VCN_UE_ERR_STATUS_LO_JPEG6D__Address_Valid_Flag_MASK                                                  0x00000002L
+#define VCN_UE_ERR_STATUS_LO_JPEG6D__Address_MASK                                                             0x00FFFFFCL
+#define VCN_UE_ERR_STATUS_LO_JPEG6D__Memory_id_MASK                                                           0xFF000000L
+//VCN_UE_ERR_STATUS_HI_JPEG6D
+#define VCN_UE_ERR_STATUS_HI_JPEG6D__ECC__SHIFT                                                               0x0
+#define VCN_UE_ERR_STATUS_HI_JPEG6D__Parity__SHIFT                                                            0x1
+#define VCN_UE_ERR_STATUS_HI_JPEG6D__Err_Info_Valid_Flag__SHIFT                                               0x2
+#define VCN_UE_ERR_STATUS_HI_JPEG6D__Err_Info__SHIFT                                                          0x3
+#define VCN_UE_ERR_STATUS_HI_JPEG6D__UE_Cnt__SHIFT                                                            0x17
+#define VCN_UE_ERR_STATUS_HI_JPEG6D__FED_Cnt__SHIFT                                                           0x1a
+#define VCN_UE_ERR_STATUS_HI_JPEG6D__RESERVED__SHIFT                                                          0x1d
+#define VCN_UE_ERR_STATUS_HI_JPEG6D__Err_clr__SHIFT                                                           0x1f
+#define VCN_UE_ERR_STATUS_HI_JPEG6D__ECC_MASK                                                                 0x00000001L
+#define VCN_UE_ERR_STATUS_HI_JPEG6D__Parity_MASK                                                              0x00000002L
+#define VCN_UE_ERR_STATUS_HI_JPEG6D__Err_Info_Valid_Flag_MASK                                                 0x00000004L
+#define VCN_UE_ERR_STATUS_HI_JPEG6D__Err_Info_MASK                                                            0x007FFFF8L
+#define VCN_UE_ERR_STATUS_HI_JPEG6D__UE_Cnt_MASK                                                              0x03800000L
+#define VCN_UE_ERR_STATUS_HI_JPEG6D__FED_Cnt_MASK                                                             0x1C000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG6D__RESERVED_MASK                                                            0x60000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG6D__Err_clr_MASK                                                             0x80000000L
+//VCN_UE_ERR_STATUS_LO_JPEG7S
+#define VCN_UE_ERR_STATUS_LO_JPEG7S__Err_Status_Valid_Flag__SHIFT                                             0x0
+#define VCN_UE_ERR_STATUS_LO_JPEG7S__Address_Valid_Flag__SHIFT                                                0x1
+#define VCN_UE_ERR_STATUS_LO_JPEG7S__Address__SHIFT                                                           0x2
+#define VCN_UE_ERR_STATUS_LO_JPEG7S__Memory_id__SHIFT                                                         0x18
+#define VCN_UE_ERR_STATUS_LO_JPEG7S__Err_Status_Valid_Flag_MASK                                               0x00000001L
+#define VCN_UE_ERR_STATUS_LO_JPEG7S__Address_Valid_Flag_MASK                                                  0x00000002L
+#define VCN_UE_ERR_STATUS_LO_JPEG7S__Address_MASK                                                             0x00FFFFFCL
+#define VCN_UE_ERR_STATUS_LO_JPEG7S__Memory_id_MASK                                                           0xFF000000L
+//VCN_UE_ERR_STATUS_HI_JPEG7S
+#define VCN_UE_ERR_STATUS_HI_JPEG7S__ECC__SHIFT                                                               0x0
+#define VCN_UE_ERR_STATUS_HI_JPEG7S__Parity__SHIFT                                                            0x1
+#define VCN_UE_ERR_STATUS_HI_JPEG7S__Err_Info_Valid_Flag__SHIFT                                               0x2
+#define VCN_UE_ERR_STATUS_HI_JPEG7S__Err_Info__SHIFT                                                          0x3
+#define VCN_UE_ERR_STATUS_HI_JPEG7S__UE_Cnt__SHIFT                                                            0x17
+#define VCN_UE_ERR_STATUS_HI_JPEG7S__FED_Cnt__SHIFT                                                           0x1a
+#define VCN_UE_ERR_STATUS_HI_JPEG7S__RESERVED__SHIFT                                                          0x1d
+#define VCN_UE_ERR_STATUS_HI_JPEG7S__Err_clr__SHIFT                                                           0x1f
+#define VCN_UE_ERR_STATUS_HI_JPEG7S__ECC_MASK                                                                 0x00000001L
+#define VCN_UE_ERR_STATUS_HI_JPEG7S__Parity_MASK                                                              0x00000002L
+#define VCN_UE_ERR_STATUS_HI_JPEG7S__Err_Info_Valid_Flag_MASK                                                 0x00000004L
+#define VCN_UE_ERR_STATUS_HI_JPEG7S__Err_Info_MASK                                                            0x007FFFF8L
+#define VCN_UE_ERR_STATUS_HI_JPEG7S__UE_Cnt_MASK                                                              0x03800000L
+#define VCN_UE_ERR_STATUS_HI_JPEG7S__FED_Cnt_MASK                                                             0x1C000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG7S__RESERVED_MASK                                                            0x60000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG7S__Err_clr_MASK                                                             0x80000000L
+//VCN_UE_ERR_STATUS_LO_JPEG7D
+#define VCN_UE_ERR_STATUS_LO_JPEG7D__Err_Status_Valid_Flag__SHIFT                                             0x0
+#define VCN_UE_ERR_STATUS_LO_JPEG7D__Address_Valid_Flag__SHIFT                                                0x1
+#define VCN_UE_ERR_STATUS_LO_JPEG7D__Address__SHIFT                                                           0x2
+#define VCN_UE_ERR_STATUS_LO_JPEG7D__Memory_id__SHIFT                                                         0x18
+#define VCN_UE_ERR_STATUS_LO_JPEG7D__Err_Status_Valid_Flag_MASK                                               0x00000001L
+#define VCN_UE_ERR_STATUS_LO_JPEG7D__Address_Valid_Flag_MASK                                                  0x00000002L
+#define VCN_UE_ERR_STATUS_LO_JPEG7D__Address_MASK                                                             0x00FFFFFCL
+#define VCN_UE_ERR_STATUS_LO_JPEG7D__Memory_id_MASK                                                           0xFF000000L
+//VCN_UE_ERR_STATUS_HI_JPEG7D
+#define VCN_UE_ERR_STATUS_HI_JPEG7D__ECC__SHIFT                                                               0x0
+#define VCN_UE_ERR_STATUS_HI_JPEG7D__Parity__SHIFT                                                            0x1
+#define VCN_UE_ERR_STATUS_HI_JPEG7D__Err_Info_Valid_Flag__SHIFT                                               0x2
+#define VCN_UE_ERR_STATUS_HI_JPEG7D__Err_Info__SHIFT                                                          0x3
+#define VCN_UE_ERR_STATUS_HI_JPEG7D__UE_Cnt__SHIFT                                                            0x17
+#define VCN_UE_ERR_STATUS_HI_JPEG7D__FED_Cnt__SHIFT                                                           0x1a
+#define VCN_UE_ERR_STATUS_HI_JPEG7D__RESERVED__SHIFT                                                          0x1d
+#define VCN_UE_ERR_STATUS_HI_JPEG7D__Err_clr__SHIFT                                                           0x1f
+#define VCN_UE_ERR_STATUS_HI_JPEG7D__ECC_MASK                                                                 0x00000001L
+#define VCN_UE_ERR_STATUS_HI_JPEG7D__Parity_MASK                                                              0x00000002L
+#define VCN_UE_ERR_STATUS_HI_JPEG7D__Err_Info_Valid_Flag_MASK                                                 0x00000004L
+#define VCN_UE_ERR_STATUS_HI_JPEG7D__Err_Info_MASK                                                            0x007FFFF8L
+#define VCN_UE_ERR_STATUS_HI_JPEG7D__UE_Cnt_MASK                                                              0x03800000L
+#define VCN_UE_ERR_STATUS_HI_JPEG7D__FED_Cnt_MASK                                                             0x1C000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG7D__RESERVED_MASK                                                            0x60000000L
+#define VCN_UE_ERR_STATUS_HI_JPEG7D__Err_clr_MASK                                                             0x80000000L
 
 // addressBlock: aid_uvd0_uvd_jrbc0_uvd_jrbc_dec
 //UVD_JRBC0_UVD_JRBC_RB_WPTR
-- 
2.40.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C69BC88CB4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 10:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B43FA10E386;
	Tue, 13 Jun 2023 10:54:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E09E210E376
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 10:54:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bA6Wl1pL/3frWQlVEwL5qG5vNfa9ZFoEVLIe6GqNvhCiap+rH1t3E6jumdO3Xkpicbe8XsCQd+z5uUtPOhRUYLabExQa/NS3Bt64BBubKp8RkTPCC/s67x/FvBSfqKE1STn4QQQvgKRBJnEuuHDUMywqfdo2mgoAuY1zgbLaX9+OIabwgXY2q2+G5kvf26mwrtXhLWqYyN08Ydhqhs320nxbOKF0zsW+wLcDLWFB4E4JbHWwVP49BJFJPA3ztuTcQ3Wk5inPKSMzAu6NBCfebSyxdyrbZC7enihRhvU68WwuP72ZdoryBceAsjBTrNZO3mCEL0b0Dp6MhC38rA5IKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEJ9k4XKROgz2h9nX5+A4wrR5GT0O918fyGjU4KKdms=;
 b=DA95KaSqQv58Ph/PjDTQ0a+S60bH3NojDHjFABkAGnJsXTDbmbHat5eHTskVsST2VG1p7fxq9JyaEY2CI9YQsPVcSys+BDgeiVxFAT//zLMtuasv9Z/VHMOsvB8hj0tEJeTXxSbBxcAoMfbhIgzgKBJDQWI4y0FE2KIJsmkR671RPi5Id5DgxZfG6UZIaVDx1s8iOleis86rdQuBzwaHxtJrHy8JosBEEh9PiN2BAn5itHZyozj/xC5Yj9agKkPWqNs1r3JAEzPN+lYxUkuIRD8VYKf3s82sVmw5XIJZynG5zhrjT7G2ueqsbPUtlvRQ13HzQps9XAO/8uSlWldy4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEJ9k4XKROgz2h9nX5+A4wrR5GT0O918fyGjU4KKdms=;
 b=5MaWRu4u5hgQkBtCSGGmpSnnKaS29ISpHxPAiPntxOGKXfyqlfAtmkVTzH4mDlRdnhjwgd3gNPwQmEbGHcvjdJggYT3jbIQsLnQV/V9yvIGZqQIt/vrSOf271CVlhjGsNYZo6R0/2L9YN9i9y1PLq0mUq0amqecGBJPDuqONE0c=
Received: from DM6PR08CA0003.namprd08.prod.outlook.com (2603:10b6:5:80::16) by
 BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 10:54:12 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::66) by DM6PR08CA0003.outlook.office365.com
 (2603:10b6:5:80::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 10:54:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.22 via Frontend Transport; Tue, 13 Jun 2023 10:54:12 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 05:54:10 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: Use PSP FW API for partition switch
Date: Tue, 13 Jun 2023 16:23:53 +0530
Message-ID: <20230613105354.1561876-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613105354.1561876-1-lijo.lazar@amd.com>
References: <20230613105354.1561876-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT013:EE_|BL1PR12MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af79f3b-8889-492a-d055-08db6bfc8619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6x8wuZgbT1mZQjPH97fxgvlStHMrzRSoaTIN7os2Ia6Bw+rLyXOKdL0oSK22mRLL+pqbUmBiE238GfZ3roRYZHjvMKespJL+2t/GcBtNuTBzFM12cB5qVaolz53TrDZZaaGJDklq9f8nfqS9lP4rIADV9+Q//+Gnwv0HIcwwQ68qNGzSKkrQkK8Unn2fc6XpGKkBWTHkWnYsG1cZouDChspjbWCdw+T0ezWpnjYF52X8NBN8GppOtky+IDcNU0qtXwlQnYQFV1qwjZFI2U2xAzeLYNvuhQfKppNBRqckfpe1zOUfHRgAIeSy75P6wXFIbYW5GEdWzMCwys6wUpRknCRZQxBJxdFnWbXd/yN3orc4Kp56wTpWk/5NEf63ze02cTmj11A9zwFHzhFy4duLr8jOytN3khiMGkIB5gRMwOKz5oUsldc4/kmYOUHwWw1TgZEpq3sP6hlDWvJFt/6DDOY9MJ4Olchn5pfH3aNXdHgC+ynOd4CS9FDnllra1VM/w1tYUFAG3Snj/072qWCnScTw5sSK3ZM5yq5YFXsoOD2W69AB9surZATBMztXQLl/N9YQEmtX55w/bJGkS75HO28vTFNd47ysUtja4QrsMukldFeIw+B9XiI+YDk50/BKR6UYkLLDtbpnY+nhcC73iVB4XXxXZQ374TW/QqAOkgnQIRGMs9e8IXPj86Y3dFKBvOOe7lvk3yO68ayO3CHFB4cFotsFBIWE2R4cs10JqojwoJ0iGR0EJVqmZb/NuaPIE1S75D45R6fZdw/pl31EMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(70206006)(70586007)(54906003)(478600001)(8676002)(5660300002)(8936002)(36756003)(6916009)(6666004)(4326008)(316002)(40460700003)(336012)(426003)(41300700001)(7696005)(82740400003)(356005)(81166007)(40480700001)(83380400001)(186003)(1076003)(86362001)(36860700001)(44832011)(2906002)(26005)(47076005)(2616005)(82310400005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 10:54:12.8201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af79f3b-8889-492a-d055-08db6bfc8619
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Asad.Kamal@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use PSP firmware interface for switching compute partitions.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/amdgpu/aqua_vanjaram_reg_init.c    |  3 ---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c        | 18 ++++++------------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index a595bb958215..16471b81a1f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -518,9 +518,6 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 		adev->gfx.funcs->switch_partition_mode(xcp_mgr->adev,
 						       num_xcc_per_xcp);
 
-	if (adev->nbio.funcs->set_compute_partition_mode)
-		adev->nbio.funcs->set_compute_partition_mode(adev, mode);
-
 	/* Init info about new xcps */
 	*num_xcps = num_xcc / num_xcc_per_xcp;
 	amdgpu_xcp_init(xcp_mgr, *num_xcps, mode);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index f5b8d3f388ff..9e3e4fcf344d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -623,22 +623,16 @@ static void gfx_v9_4_3_select_me_pipe_q(struct amdgpu_device *adev,
 static int gfx_v9_4_3_switch_compute_partition(struct amdgpu_device *adev,
 						int num_xccs_per_xcp)
 {
-	int i, num_xcc;
-	u32 tmp = 0;
-
-	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	u32 ret;
 
-	for (i = 0; i < num_xcc; i++) {
-		tmp = REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, NUM_XCC_IN_XCP,
-				    num_xccs_per_xcp);
-		tmp = REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, VIRTUAL_XCC_ID,
-				    i % num_xccs_per_xcp);
-		WREG32_SOC15(GC, GET_INST(GC, i), regCP_HYP_XCP_CTL, tmp);
-	}
+	ret = psp_spatial_partition(&adev->psp, NUM_XCC(adev->gfx.xcc_mask) /
+							num_xccs_per_xcp);
+	if (ret)
+		return ret;
 
 	adev->gfx.num_xcc_per_xcp = num_xccs_per_xcp;
 
-	return 0;
+	return ret;
 }
 
 static int gfx_v9_4_3_ih_to_xcc_inst(struct amdgpu_device *adev, int ih_node)
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAAF2EB64D9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jun 2023 05:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 619CF10E28C;
	Tue, 27 Jun 2023 05:19:48 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6461F10E28C
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jun 2023 05:19:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8cYyOj6YNlygy2JVLo9qXANUHdptj/LYd+pcHla0jqCprgIuyj7NeJSg9Ag0hJsoYoRRb1C/2eQKnO3zvQArPntDVo45AjxCYPmuRQFeYpqkN3FOIfLTFJ9UeDZPJC3Qr8IEZMmZQHFWDEsFm4Ke50jPuFl4w2TBqgv2mkiOYV9HVKIlaKhBP5hNTCP2yxCHAusZFQUJTckXuklSfhB4VktLJS+QisArssT/yYFEu9+i2BDA/qox82fWe9x8Cep/bQXfIM+Ku62tNjE/P3DHtZBvByu6LgIW7dKIYZb5Wx2SviJN56az+eO8MYPIU4OJt9QLUcJmRdJ1bYaUxCANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYyNVPMvnvFqqjtpiu12ZqEh8G09yF/ybq0TdBfElZI=;
 b=iUrFJEC4YhCMPQm9tZ9Kj2gpNMF3q4BLCCM2cgVcvyAtrAWX504sEiwGRyN89YbmZJHHfqOsPxUDRi5wowEb8LMP/GG335ErBf80YxSfySB1d4LI3RgKH0723gCVADwgPBQR7elyrjc49PX2jQOd4TLjD1OQ10+f0hUmHr9fD848P8WvZIkFpu/sQT5NFqcKcshXLbNy9vIeEXAR/Bzg2ccXX3pY0gTxaKaRuHW8gTyWx9395j+sbfTK1vAT8LxqTapJuCMLu3MjQ8yjKtbhCPQkncfGRDqKuN8rgMD/nWehTpacGYoBuYZSvJjgWsh7bdYOA0sdwHVk9Q3YYaGAtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYyNVPMvnvFqqjtpiu12ZqEh8G09yF/ybq0TdBfElZI=;
 b=B+lHRQGBoib/ytzJYeQm9v13mBYzqcGklgA1XjKqxm8/22NOnadBBT0UI1NNhuIt0AGZjG85r/MeshYrRnrFUbPb5DGoSArKiqueoMxAydbp7aC+HA4OizhZK8hGRgSdxX/H45ml82105yY296NhcfS90+urOFUlxN6xo/I1YOU=
Received: from SJ0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:a03:33a::29)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 05:19:44 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33a:cafe::f5) by SJ0PR03CA0024.outlook.office365.com
 (2603:10b6:a03:33a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Tue, 27 Jun 2023 05:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Tue, 27 Jun 2023 05:19:44 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 27 Jun
 2023 00:19:42 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Keep non-psp path for partition switch
Date: Tue, 27 Jun 2023 10:49:22 +0530
Message-ID: <20230627051922.2644853-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|MN2PR12MB4205:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd684c0-d4f1-4398-7eeb-08db76ce1e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 61yr7FKALmHxpq9FPd1s+Hg5+dzexEMbFxVdlWjU8GKRb65/RQogk0pQswmo8JxsFfakuWb9ZzU0hWObUQwgQk1dFeaSjcONmc1iFKTZHahSw0MH40bSamYFX/aw/fdAjYkoD25Xicp+fSyrsRdlAyw3epLS+kEdo3Lx5L0znnrNW7PFjOt8tS9KBpZbZInNW0npqLAkNHEWaJKMlnJZXx3nXH/lzGn2y9aqVkfDUEOkmiGCVtkKltojNwFI+4TGwz/hyTrNHol2EWAJomdRw926Q4mgTY6NwGycSbIwieWJD+1csM7l+YGBYD56fwXkwD9+7JZa/YBlisToasI4D2lmbeJblQeYB5IECjWBXlUTH7LvqugiThy/hp3Ya1xkb4zaoN3H/5YkVQatGIT4a1WQBiXYG00DgNKWQDun5k7gN1BSm0fcpjmuai7EOQyQpMuFVLgy8lQ6bD5djwCZ0dtrbXFbWbAhE0eGi/oBf2YCjACZh0R+ZTvfAlYRoeGQhb+wP8jh89vYfRlrEOniUerNR8whpqFccZ7k5svyPjtYFJHj6ex5jys+OwrpUI8h3rhP4BE2LyZXZ1g5Prj8eqereOBOCPWKSotJIQvqFlo5bomfS7La+X+/4w4uMBzZ715Gl54HP801COHn0EiQG47pEIWG7uMNI31zrp0JJZyQAGeyWmFJwlB4mXHFgp5mv2gIekcJtLUdi8L86qUT9TK5S8H+maYNI97v5db91Ksl3hn+O8O780rjTb+yPXl9sKsTGbzCsD1X/rZWchxbsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(36840700001)(46966006)(40470700004)(36756003)(82310400005)(36860700001)(70206006)(40460700003)(5660300002)(44832011)(356005)(316002)(86362001)(4326008)(6916009)(41300700001)(8936002)(8676002)(82740400003)(40480700001)(81166007)(70586007)(47076005)(1076003)(26005)(2906002)(186003)(16526019)(426003)(336012)(478600001)(83380400001)(7696005)(2616005)(6666004)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 05:19:44.2840 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd684c0-d4f1-4398-7eeb-08db76ce1e1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
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
Cc: Alexander.Deucher@amd.com, Mangesh.Gadre@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When PSP block is not present, use direct programming.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Tested-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 28 +++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 76b189bd244a..9e3b835bdbb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -623,12 +623,28 @@ static void gfx_v9_4_3_select_me_pipe_q(struct amdgpu_device *adev,
 static int gfx_v9_4_3_switch_compute_partition(struct amdgpu_device *adev,
 						int num_xccs_per_xcp)
 {
-	int ret;
-
-	ret = psp_spatial_partition(&adev->psp, NUM_XCC(adev->gfx.xcc_mask) /
-							num_xccs_per_xcp);
-	if (ret)
-		return ret;
+	int ret, i, num_xcc;
+	u32 tmp = 0;
+
+	if (adev->psp.funcs) {
+		ret = psp_spatial_partition(&adev->psp,
+					    NUM_XCC(adev->gfx.xcc_mask) /
+						    num_xccs_per_xcp);
+		if (ret)
+			return ret;
+	} else {
+		num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+
+		for (i = 0; i < num_xcc; i++) {
+			tmp = REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, NUM_XCC_IN_XCP,
+					    num_xccs_per_xcp);
+			tmp = REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, VIRTUAL_XCC_ID,
+					    i % num_xccs_per_xcp);
+			WREG32_SOC15(GC, GET_INST(GC, i), regCP_HYP_XCP_CTL,
+				     tmp);
+		}
+		ret = 0;
+	}
 
 	adev->gfx.num_xcc_per_xcp = num_xccs_per_xcp;
 
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5864C77B7C
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 05:29:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8621F10E22B;
	Tue,  9 May 2023 05:29:27 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5529510E22B
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 05:29:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfQh75MoB6AP0wrt2YOcRG+WEG2II2lDbyRclYAyYRZD/FMUz68MItu4OSoHxOM/CXeZhAlvxYX7eLqZKyxWD//DBj6AzfmNRlaG3hwxYNe9iLp2MmvtYCMR1e4hEVwBd56SvJuvxI5enYQy2BhH3HyHJj0kR4M8kJ9LFeUzncczJ563Z/K3cHr6eeKK2hitNlIkmdTiORUNlvyyYDc47YqVieoBQKJRGP8aZD78OydCyPcU75pxtV3L4SsyDNn8zjNOWgG0Juhe0UJbcSfQGAMPg+lgaXe9QGTPnvTyfCmDcyJiOq3iBGzrrY4oYXDX5uv5wOluPyyvcgCmw6yDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+OP2RfsRQpXnWk5iZ0novIGve3gtcY0O4NnS2435ZY=;
 b=OZwlQJsFBjqCnGwk8dVc+MRXvT3fcL3CvnbfHejl9MUWbnBWmz3Tkv0Kt27mfrXPP+3/E0Fla3WIinfsTdfCQ7xl3mUzufomsLhuSzqEFwy3vsDlNcT6s8rqT87tEmCW4ti/fQ22A1NTE1T2X6F+Wxx5xjAc8t4zTxVliBrW0y6ZIOoLy8MsdpcVdQb2/w79Nx/YYOfxVObrUKNMKRQni8ZH5V8fF3KeG3lmcF1vpAQJ18jJSbt6Nqh2zksm3n4vXXYRB8ld+PB3DY34cWAonqMOwOzihZMk0SS0ItoHJkdp7fZrDmbhPHcNnfZB6377Euj0R6SW+IYIMG2H7ZzAcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+OP2RfsRQpXnWk5iZ0novIGve3gtcY0O4NnS2435ZY=;
 b=HUo8+bvmG7yCcN+GeLbIPN0LtANuc5GvXtL+LFzs1WIv+oWYOgCUtGG5YdR7XSOldGL3tH9CW5UOdgNu4OwBN292POc6TjZskO/Had9h5BGiH4fDSvK919kqxB7D4lNaHKtTlfutC+T8wmg7y8zn5bOzUNNmP4VkXRVeXRevG6M=
Received: from BN9PR03CA0136.namprd03.prod.outlook.com (2603:10b6:408:fe::21)
 by DS0PR12MB8501.namprd12.prod.outlook.com (2603:10b6:8:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 05:29:22 +0000
Received: from BN8NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::7c) by BN9PR03CA0136.outlook.office365.com
 (2603:10b6:408:fe::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 05:29:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT104.mail.protection.outlook.com (10.13.177.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 05:29:21 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 9 May 2023 00:29:19 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>
Subject: [PATCH] drm/amd/pm: avoid potential UBSAN issue on legacy asics
Date: Tue, 9 May 2023 13:29:06 +0800
Message-ID: <20230509052906.2142723-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT104:EE_|DS0PR12MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2ddf1c-e2ed-4ed7-7657-08db504e582a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ozS46J8JSyg+/bQjrmt4eJTu78T9+o98EA6K71hHfek8NWDUC6KQ00nX9JU2m5s5KCgwzJcqR9ahoeXrWxVtR6B6kuePEoFM9O5JSthnhuoZ/mVdKYqIjp1ujGXSScby8oKe3nqNGfIuhic0/0BlUoI/muScXZnZf3SGjPypVyM5Rqw2VRymTvmYHSo/VBdNW2vUpgLFK53sBPi/+Adjs/FqPAgB7UrZ2fjjSpH04CNM+5OnPNsUN5SpmskCD54qhcunH+Rufce/tOtJlyzXwx3OtxiAXj8utoZ50bb2PrPlx0jymi+EREun4S6NGFP1hfRkMztrCiNQhewW3VlQgD4iNEhstv3nHAKuQaD51lWjSYIUjRrRlnFkZynk67UpEXiKGpPVjzpxXAGrPMfGT8KY2QbN68/2Hv5hEb5E19s2tSrMaJl0TZoMBgM8SOr5+U3mgxhTrE71V2f9qmkWjJyLsP9Z1caELKyUPtoCsijGkbGQJHg99HFTyx/Fxb2j5u2nN1tX+MdcUrVXwEs0+zKUsGSzMzDchNeTOY10JUxeY5g5EAc/NKo/UaFUqaV0IGAmwtzYXfitwD3RehRgwOAoKG2kdlAZGLOcEPM4C853zw23Qwa7ecm8NOMfwYLf7Xr8Yx1/Sk84rtFbnptPlCGjNAPKOX+bRIJ32STVXqkreXr+X9EVk9vDuVqM9p9sPVdfga+KoK1cvlvVAtcY/4vU7KO6yCfZJBLfYR0hn2eFkUZiKbs5rX4Piobfv22o
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(46966006)(40470700004)(36840700001)(4326008)(2906002)(8936002)(478600001)(316002)(6636002)(5660300002)(8676002)(41300700001)(16526019)(110136005)(6666004)(70586007)(44832011)(70206006)(7696005)(1076003)(26005)(186003)(82740400003)(47076005)(40460700003)(2616005)(36756003)(36860700001)(426003)(336012)(83380400001)(40480700001)(82310400005)(86362001)(356005)(81166007)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 05:29:21.9437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2ddf1c-e2ed-4ed7-7657-08db504e582a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8501
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Prevent further dpm casting on legacy asics without od_enabled in
amdgpu_dpm_is_overdrive_supported. This can avoid UBSAN complain
in init sequence.

v2: add a macro to check legacy dpm instead of checking asic family/type

Suggested-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 86246f69dbe1..4b28fd62ed7a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -36,6 +36,8 @@
 #define amdgpu_dpm_enable_bapm(adev, e) \
 		((adev)->powerplay.pp_funcs->enable_bapm((adev)->powerplay.pp_handle, (e)))
 
+#define is_legacy_dpm(adev) ((adev)->powerplay.pp_handle == (adev))
+
 int amdgpu_dpm_get_sclk(struct amdgpu_device *adev, bool low)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
@@ -1467,8 +1469,11 @@ int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
 	} else {
 		struct pp_hwmgr *hwmgr;
 
-		/* SI asic does not carry od_enabled */
-		if (adev->family == AMDGPU_FAMILY_SI)
+		/*
+		 * dpm on some legacy asics don't carry od_enabled member
+		 * as its pp_handle is casted directly from adev.
+		 */
+		if (is_legacy_dpm(adev))
 			return false;
 
 		hwmgr = (struct pp_hwmgr *)adev->powerplay.pp_handle;
-- 
2.25.1


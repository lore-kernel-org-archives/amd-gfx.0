Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D89C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C448D10EFB7;
	Thu, 30 Mar 2023 19:18:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 200E710EFBE
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:18:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCgBpyfv52PBREG2lHzRSiw/cI1FIaB8UqYfUPxl7wTfpN7o21LUIX3vfdRrHsAz1WIWAV+F2E4O6f8OTXymwlF6Z1Kodz31cbWPAOCgqM314RU3u/LH5V+xx6JXHpCzKFwqsMEJ06MjSnmM3P3KG6XZjINA4XdsUdgi0KEvriZfW/Gku3ZW9/gms7bAUqoFoLfdA2jO2N+vwYa3Ixouk/dm2qY1hjlpVvil/63EA5cp7q4/A3WDXoK50oQXoTiJ36W+cL83XFQqD96ofsddwFeMmWAGNTmE8G/DDdhbvjbhVtYFdHD3g01e9cMgWTZoZxAH8IBYo/NuVuUrUDl6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCDa+Lb9LANyo1b6sbxc2z9Vw/fSmxR2fcSsg+61UbY=;
 b=L/cMZ2ChxVeKtujU3vx4bzltR0rJL15qzjkMuQUPObrTgQwKnNQF3eaYj3sHeyQ2FDOoFPs1G09Z6Ot86dNyaFoLWp2NhVfeFH8cSbfWkzBdSMlJxTi6lq+Wa3ZtmJH4WlIhkn2YIMTpNGGIVMtffMyoVMKQxY+oX3pz4W+mZDKeuThHDIXIbbP49Ns11XkCIR3lR/4o6BqhcmJ3GGabzaSEWH8DlR+aNiSimTMNDEZVPsllQcIdRliehNQNf3eLtsWuY/0paCZxh/e69qH3fYDPgupwBCMjq6zuIZZgHAuk/bGp1q1qiTozg7+9KmAacqddoM7WY0183hvyZgAMBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCDa+Lb9LANyo1b6sbxc2z9Vw/fSmxR2fcSsg+61UbY=;
 b=d5RML01TKObB0PVPzW/yf+s439RxzYzPG6N85uL20HTT/3Htjbgmw1uIU8GEjkW4IwvrTKq/zeacSYfthybsbu1F+q5wHa8khDS0Ez4RqS9cEApnqzJY7PRNgk6WPCnRL3p6W1q1moIcs3HgN2TRcODXpg+JGViiqWs2TEF1drk=
Received: from BN9P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::12)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 19:18:08 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::47) by BN9P223CA0007.outlook.office365.com
 (2603:10b6:408:10b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:18:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 19:18:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:18:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/13] drm/amdgpu: add get_gfx_shadow_info callback for gfx11
Date: Thu, 30 Mar 2023 15:17:46 -0400
Message-ID: <20230330191750.1134210-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330191750.1134210-1-alexander.deucher@amd.com>
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|BL1PR12MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: 3067f035-f2de-4b99-7f4a-08db31537ea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Li5HLXQ5xKXuJgMoqYVtYW3HGEhmvH84lHGNayDozYTlcPycMrYslOHJ+5PEzoHcWtOdXXPmVQ8KktSs3hYpOKTS05bch4D6USPpMO22AoXnr7n3DLqc+44GU0FHFiam9E+ZjfKQB8Gh66B3LYzML2IFkuTUWf3RH05O+j0ep5OfYG19cnKgkmiOmZlnRLi/KxOvMdAgvgIZy+6nssEEiPRogaqXw99js593TEjmC/tc6rzusCMOEcHPXdq09zib5CWdgXrqKnHUsgF39a94mTVkbuZ5459OEFz2Wqrw3/LJDhwZ3ZhkfiQDvz6Pua2rK5G31SZW4vQgYMwxDQpZ+RWDt4GPI5FTfAygHrsoU0dE7kzXWtglhqQfGWijFKCQ+X57i1GDgHxxm2g7j+Fl6GaiF4QBMT/fyBxSOcP+iIBFC+E5+qbaCdBkVKoShD10cwx+y9XJ6vRYPWCgkF5FeWVF8jF+yDftP/apv1CTaKLPAzA3WgrcF2HAQ2EA4ZwmteFituhBvW4Vjp0Xq+xS7BqWkx8c4lFqe+FHU/mc8//+ZzsmctyU09ZmREhWWQV4KF89+tohEWE13MKrwOf1vDqMwmVj53+IlTEtPoLu0fZoj/n+Z9/U2+Jd0r65EwUmQvqk44iXeGnTbIwd3epxnLrqlbfpUaX87OjwWIhixPqgqSz8+N75UwtfKeY1Og5g2zn+OdXg3nRizZ5C73WOxX7X7Z+HVdN4sbW7cD3Qv30=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(46966006)(36840700001)(40470700004)(86362001)(7696005)(356005)(81166007)(36860700001)(82310400005)(26005)(2906002)(36756003)(83380400001)(47076005)(1076003)(316002)(478600001)(186003)(40460700003)(6666004)(8936002)(41300700001)(336012)(8676002)(16526019)(5660300002)(426003)(70586007)(82740400003)(70206006)(6916009)(4326008)(2616005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:18:07.9410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3067f035-f2de-4b99-7f4a-08db31537ea5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Used to get the size and alignment requirements for
the gfx shadow buffer for preemption.

v2: use FW version check to determine whether to
    return a valid size here
    return an error if not supported (Alex)
v3: drop GDS (Alex)
v4: make amdgpu_gfx_shadow_info mandatory (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 1fc1e941f7df..7a5da13cffa0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -822,6 +822,27 @@ static void gfx_v11_0_select_me_pipe_q(struct amdgpu_device *adev,
 	soc21_grbm_select(adev, me, pipe, q, vm);
 }
 
+/* all sizes are in bytes */
+#define MQD_SHADOW_BASE_SIZE      73728
+#define MQD_SHADOW_BASE_ALIGNMENT 256
+#define MQD_FWWORKAREA_SIZE       484
+#define MQD_FWWORKAREA_ALIGNMENT  256
+
+static int gfx_v11_0_get_gfx_shadow_info(struct amdgpu_device *adev,
+					 struct amdgpu_gfx_shadow_info *shadow_info)
+{
+	if (adev->gfx.cp_gfx_shadow) {
+		shadow_info->shadow_size = MQD_SHADOW_BASE_SIZE;
+		shadow_info->shadow_alignment = MQD_SHADOW_BASE_ALIGNMENT;
+		shadow_info->csa_size = MQD_FWWORKAREA_SIZE;
+		shadow_info->csa_alignment = MQD_FWWORKAREA_ALIGNMENT;
+		return 0;
+	} else {
+		memset(shadow_info, 0, sizeof(struct amdgpu_gfx_shadow_info));
+		return -ENOTSUPP;
+	}
+}
+
 static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.get_gpu_clock_counter = &gfx_v11_0_get_gpu_clock_counter,
 	.select_se_sh = &gfx_v11_0_select_se_sh,
@@ -830,6 +851,7 @@ static const struct amdgpu_gfx_funcs gfx_v11_0_gfx_funcs = {
 	.read_wave_vgprs = &gfx_v11_0_read_wave_vgprs,
 	.select_me_pipe_q = &gfx_v11_0_select_me_pipe_q,
 	.update_perfmon_mgcg = &gfx_v11_0_update_perf_clk,
+	.get_gfx_shadow_info = &gfx_v11_0_get_gfx_shadow_info,
 };
 
 static int gfx_v11_0_gpu_early_init(struct amdgpu_device *adev)
-- 
2.39.2


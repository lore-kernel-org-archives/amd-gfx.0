Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250B7C28CF5
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 07:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74CE410E13D;
	Wed, 26 Jan 2022 07:53:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1AB810E547
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 07:53:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixrlapyFF6qoBNZ1wwwiGbhnQDe3Qlv2dFqFqgC3aAukK+dcoCbryUnDkoG+/M0Km/jpX7ZHTAOzClEZbSacJeElaHI6YjitQzvxgKnCoO/R53ryQ5ae9v5kcl+AlYpf/EnyphN5N9Wm83Ms4f0v0cJB1xAuUColKnetnjYWpu8/5bi/gy5jOROWq182KCnK+GBhjhK6h/FpAxqns5SnNu0RJLhtH4IOe9d13rvZfQhBil3ME/VfR8juiPz/dWDh2P6Fd11XoWqCxdwuqfc/qH1EqCPS7RATTvSumMlmglbURknsInxwUndgOIS9O6Bc+XM3Hrz9Pb+UpvgRMS0oeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSarCbVRYMpVwoT+uuQVgKfwPqn7fFs1QfkhETlhUWQ=;
 b=Z+ZZ29/n36LEg93R3NCRTn2xj+9VIO2bNGzGVDNKZfGiQcEYbhtwNR3tlTOP4EB1a/cbiHuGlvWhVczLe6Uqa8I1/bXEja46PY3e1ytSO8mygE8I38ncmykoi2jrv3QOnhcV6tnlxKcl+1JF4/660IyfcR1bNVWPG9YhKmReTEcpechro/5FPXzcV1FnShuT8hLrt78Ooc1LNe3aHejI4fvka2Qcb2qqJGRVdpGEgBYTdW7/upREeoh2uuT3QC/2P6kW6htR8R5uq7FpmjMyy2PLmUB5tSZoAnvZnrU4rX5CSfkpR/PndGkmJgvTmDXEexhqz8QkVawQuer7Bg96WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSarCbVRYMpVwoT+uuQVgKfwPqn7fFs1QfkhETlhUWQ=;
 b=CwGnoHatqZnr1H95gUSlwcKruDPOLGquira5p4/iYPU+v1aMRRE5MOQ6pJ/m50PWW05paiYC6LJGDdKn+MLTpyFy44makgR4P3MQr2uAO4wQEAe2lkF47w7Mt9y2G/K724BV9ZQpgV4kkhDBevKsHJH953a3g8E1H5E3DZNG+rk=
Received: from DM5PR06CA0074.namprd06.prod.outlook.com (2603:10b6:3:4::12) by
 BY5PR12MB4870.namprd12.prod.outlook.com (2603:10b6:a03:1de::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4909.11; Wed, 26 Jan 2022 07:53:52 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::68) by DM5PR06CA0074.outlook.office365.com
 (2603:10b6:3:4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Wed, 26 Jan 2022 07:53:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Wed, 26 Jan 2022 07:53:52 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 26 Jan
 2022 01:53:49 -0600
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add safeguards for accessing mmhub CG registers
Date: Wed, 26 Jan 2022 15:53:26 +0800
Message-ID: <20220126075326.1134770-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4bc0f77-9928-4160-6139-08d9e0a0febb
X-MS-TrafficTypeDiagnostic: BY5PR12MB4870:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4870A9D39FD8FEB842A5BB72FB209@BY5PR12MB4870.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWbkA2XsRwgrr5vXrQjEl+GoRWa/1/Z+YtQXELxCoFX7VFnB678rMQTWbSEYfyroEG5pxMwXDW/h9CLJJ7oK8cPKzGz+cRVAQW5uJLS65219lNOuKOCH4KZMIacYJUdGNxMOgfVqrlv7tSabeaSA6vdCK5YIWwFlZkzltq699OJg8Z3LcMBXpjsB95hYkBhGA7Ja0/kbEtM3L2+47tUS32Q5YTEIuyt56bWoPob+ufXru6CydNJF497gf+FyuSjzyATfFR5JXSrck2UDg2FZ7kGyIS3+wgDeTZUm59E1c5FQKXKiuaxYCZ0PksCs1tgy89LjxSZuKfsE5DX7VObM5ONStLmEg+bDja7oC/r6IoFyfCBPFtUPDHlsDQ+10CEjdYo9tQ3Tgw3I4dfCfb1jIZvIX3gFQSrPNptJSsCgj7RFZ0VSl+ejTgnZ1BFVu5wZ0tkcH2dKeloIcIteErfNEilURpwGsMLY7VnLzJ+gvb/YoHcmAQFXRy9ZXZsHHly5MypHtqe9GvAT1g4QGDr6liSVmyOmG/oauZD1392MINN9hHgdYYTbFnGi92bjB3TtKs0ah0492cz1VTw97GOa+7hwXNZGId3J2flRf2vziiqf1W0vZAevVvDJT/znJl5dpwufP4SuQYBrUEEUEx9ux1T1DCr2MLIPBO0s1JUMvFsny9HAucut78d5Vyg4BT2B7+onvPzD6Iq5erdmXHehcgapP99+AurEKeBIlDoxpNl6YJNnHrj1Qq4uAPHgE1opVzDAKvwICZommANTlpMhgSwVC7pn7qMrGlOFXDZQS+8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700004)(7696005)(5660300002)(70206006)(36860700001)(336012)(26005)(16526019)(426003)(82310400004)(6916009)(1076003)(508600001)(47076005)(8676002)(4326008)(316002)(2906002)(40460700003)(70586007)(83380400001)(356005)(2616005)(186003)(8936002)(86362001)(81166007)(6666004)(36756003)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 07:53:52.1468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4bc0f77-9928-4160-6139-08d9e0a0febb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4870
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We observed a gpu hang when querying mmhub CG status(i.e.,
cat amdgpu_pm_info) on cyan skillfish. Acctually, cyan
skillfish doesn't support any CG features.

Only allow asics which support CG features accessing related
registers. Will add similar safeguards for other IPs in the
furture.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c | 3 +++
 5 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 4c9f0c0f3116..1869e2019461 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -550,6 +550,9 @@ static void mmhub_v1_0_get_clockgating(struct amdgpu_device *adev, u32 *flags)
 {
 	int data, data1;
 
+	if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))
+		return;
+
 	if (amdgpu_sriov_vf(adev))
 		*flags = 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 3b901f941627..f7b9843b36e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -546,6 +546,9 @@ static void mmhub_v1_7_get_clockgating(struct amdgpu_device *adev, u32 *flags)
 {
 	int data, data1;
 
+	if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))
+		return;
+
 	if (amdgpu_sriov_vf(adev))
 		*flags = 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 3718ff610ab2..3f5f326379b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -686,6 +686,9 @@ static void mmhub_v2_0_get_clockgating(struct amdgpu_device *adev, u32 *flags)
 {
 	int data, data1;
 
+	if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))
+		return;
+
 	if (amdgpu_sriov_vf(adev))
 		*flags = 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index 9e16da28505a..b23dd9ddfb5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -580,6 +580,9 @@ static void mmhub_v2_3_get_clockgating(struct amdgpu_device *adev, u32 *flags)
 {
 	int data, data1, data2, data3;
 
+	if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))
+		return;
+
 	if (amdgpu_sriov_vf(adev))
 		*flags = 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index 619106f7d23d..a2d5c8424e2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -651,6 +651,9 @@ static void mmhub_v9_4_get_clockgating(struct amdgpu_device *adev, u32 *flags)
 {
 	int data, data1;
 
+	if (!(adev->cg_flags & (AMD_CG_SUPPORT_MC_MGCG | AMD_CG_SUPPORT_MC_LS)))
+		return;
+
 	if (amdgpu_sriov_vf(adev))
 		*flags = 0;
 
-- 
2.25.1


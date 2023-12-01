Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD5FC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 07:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC04910E7FB;
	Fri,  1 Dec 2023 07:38:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77BB810E7F7
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 07:37:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUiXgGCy6o2suopPoPRIFn5WrjYGA9Az8+NdstqqfCPWWJA/pE9k+IQMSIMV+TMf1zR38fRVz54vBqlir8fTqJ6UCvyloR/Tc/xnpZ6emsUEPUmMCLaxwwF3CcPAFD7xOz63MfIWXFZjV4HMZza7QwueFL7uta/RrCjW6vFsTM6EE7Ges6kHZvuXAbBKlvwnMjMK+rfqX7YVqqHDB0mWMYhkOSWdTvVavDCEeAP/tHiMAUno/tKPyhoGfQ0mYd4VbQzEO15PODiMHgxEC29p3aMrX78cCFXA2JtYP2uolMayjeImpEh3E6RobLOwFF3wkfkLom3mQ6w/JmfxBEUV9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JgfBYJfB+ugHbIEAYgfXTDR3vyc1ImAfO5F5l4oDpxE=;
 b=O3PDvluBXQBujTc0b/thXcNYQvjqabuW7hPk+2FSVBol99JaVOnagv3eHZmG7/RyaDlQjJDN/vDruvOIPw2MnOhB6oD6Uq/tlgxTKFmyBAEmsIuI5AStaJg9XhRtAssVXbpl5xyEzygBR2Fm+hpDQzNr2e5Jzp/t0nrcyu98uu8AjiYdMdi3phf4NQUR47XdJG5oxOmZjtcImfMqVWrpCCKJkZmMmOSKOu5eGGqvTFbiZ/MuPYtoRMsk0cQfwpEzF6ZbSc3Bl6umm30srcpmQL6SSX8AyFC5zsrHiTX4trzjr3Qd0z5+cPYZEY0pyY2aX6B53X+Vf4hr/5niEMKQ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgfBYJfB+ugHbIEAYgfXTDR3vyc1ImAfO5F5l4oDpxE=;
 b=d0len5xyOVBn+zqaKmA5WO+ZqC6wj2pWLTiT6wKkJ8zh3zKosFW3iei/juorLqySmByZmHpZJX65+vZ5c76gaeHXreWRHJ1VpxtJgQEhzWiVvgB5SyAJgrGd4p/ko7bNQ3AT18BIcrB+8nezaCZXrZaTbSe6R6utt3bdG98HSrI=
Received: from DS7PR03CA0237.namprd03.prod.outlook.com (2603:10b6:5:3ba::32)
 by MW4PR12MB6924.namprd12.prod.outlook.com (2603:10b6:303:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Fri, 1 Dec
 2023 07:37:27 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::22) by DS7PR03CA0237.outlook.office365.com
 (2603:10b6:5:3ba::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28 via Frontend
 Transport; Fri, 1 Dec 2023 07:37:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 07:37:27 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 01:37:25 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: Add NULL checks for function pointers
Date: Fri, 1 Dec 2023 13:06:34 +0530
Message-ID: <20231201073636.1190113-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|MW4PR12MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: 34892421-54c2-4e7c-b9d8-08dbf2405e16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rYJN9E9GQRbOeVAODA+6mJwU0TRQ1nXDq14WksI6Wa/VrEVGowppVIQXQFtH/oihtxjVT2+8F6ltYAUUb/sH0mkG+mTw6kKgXz986EklHhvwTLf8E8waij0jDEWdrXZWE3UR3bU2ipO7asekWNKWZdT/K/FboMBS1NHZ4gay3aovJbto+A91lkLtmuyra7h5OExxXaSwjmKjHEFC4WP6Q4atMagcsnRTkqYJpskVlHUFOagYFS6S8FVdFPfPLaKrk+DzjN2MZNGAvT27zNd7khLNGg/afp3ZzNESPDMFsjvVE990qMdifze+v5S3iAJOaeYWESanahAKlVyq0GgjkF2Drg9M3NxOvxzwydHfHG6XvHZsUQ10x+YWCFFY5b/AtdFILniBgymUEVWQUQt+pdke+FXm13rKIHDz5sjaLp9Q7YIDWETD++86xZKp40r0mxASXXOpe+pBGlcYJHnBHoSyTCXwR2fyweP11NayaqHbuaNP3YnKa5X7RD8jtRxAvs44+e0m2YeUys8iZtJ8SfROx+no/i63HWaLHopzDPSUk885LZb5m/x8BGH8npC1iBEjxtdpQBURe7TzMb6EACI4OUehzoU/Dq9aTorEjGDvURXyDuD7GM3HmyJjLfN7JMRQ5A7tZ6fCvfOrZjlwi0T9SHJSti/zOgrm+/hPFQ50skzqfAo5qlG2Vz62jkC7ZQb/sMyZsKTV2pN+bwPqVSqETct+QmW38TOYhtPaqZMX2eYE06VGGZc0HkkJFfkY/0waw+c4gomD1m8q6meVHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(186009)(1800799012)(82310400011)(64100799003)(451199024)(36840700001)(40470700004)(46966006)(41300700001)(44832011)(54906003)(70586007)(70206006)(40480700001)(83380400001)(6916009)(8676002)(36860700001)(4326008)(478600001)(8936002)(2906002)(5660300002)(316002)(86362001)(6666004)(356005)(7696005)(36756003)(40460700003)(47076005)(2616005)(81166007)(1076003)(16526019)(26005)(82740400003)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 07:37:27.2652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34892421-54c2-4e7c-b9d8-08dbf2405e16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6924
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check if function is implemented before making the call.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 9ad4d6d3122b..9043ebf1e161 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1424,9 +1424,11 @@ static void soc15_common_get_clockgating_state(void *handle, u64 *flags)
 	if (amdgpu_sriov_vf(adev))
 		*flags = 0;
 
-	adev->nbio.funcs->get_clockgating_state(adev, flags);
+	if (adev->nbio.funcs && adev->nbio.funcs->get_clockgating_state)
+		adev->nbio.funcs->get_clockgating_state(adev, flags);
 
-	adev->hdp.funcs->get_clock_gating_state(adev, flags);
+	if (adev->hdp.funcs && adev->hdp.funcs->get_clock_gating_state)
+		adev->hdp.funcs->get_clock_gating_state(adev, flags);
 
 	if (amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 2)) {
 		/* AMD_CG_SUPPORT_DRM_MGCG */
@@ -1441,9 +1443,11 @@ static void soc15_common_get_clockgating_state(void *handle, u64 *flags)
 	}
 
 	/* AMD_CG_SUPPORT_ROM_MGCG */
-	adev->smuio.funcs->get_clock_gating_state(adev, flags);
+	if (adev->smuio.funcs && adev->smuio.funcs->get_clock_gating_state)
+		adev->smuio.funcs->get_clock_gating_state(adev, flags);
 
-	adev->df.funcs->get_clockgating_state(adev, flags);
+	if (adev->df.funcs && adev->df.funcs->get_clockgating_state)
+		adev->df.funcs->get_clockgating_state(adev, flags);
 }
 
 static int soc15_common_set_powergating_state(void *handle,
-- 
2.25.1


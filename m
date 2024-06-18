Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0382C2BA18
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 16:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C58510E70D;
	Tue, 18 Jun 2024 16:40:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JYQcLvHy";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3700210E70D
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 16:40:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d3Wlf/tzMFFWW28JRUDSSl0si8ZmyZ0Gm3x+7FCGR9/7LA2Ek0fUiFzhxVtWHy7IYWelfoRcB7BC1rRIJhQP/ZAQDljigbZsCByyZBsHRFSWFhgGc6/CNAeaLqYmikKqe6kT4+faqYImHiEM6dqzffsUCeE6lcyN/T2ywwrHo761dLCSffF/sk2h769luTAN3nD9srNz5K5DoPbv6b0DRBL/YlbJns5mTpUKirRhMOQxlyzD95EYTh95TYgYvM/kDLsuSFCcEbB3Ky7cKIEkY29TnlTP808gVCd1Y5HQEYYc8mCWt3mLZFOV7MjDe+0xxyBeEuGUq/c+TqO8r95Y0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vef6LloKrbNuvod+rQXqQjcLe05jJ2ffdA8SbaUv24A=;
 b=kQxPICBh5aiAlWtwN7UCwg4K4DMypn5yZzsvNLB/KPdX79CfU4jtfUcunzHAZurJMY+Lpc3ZgVa6QmlFiCA6AFKxdgsFBZW825Qt6d4GndAyaOJlfe3CzcSeGxDSyuJdSI4Ve1cc1j2DYKuc5RaEOAB9w72qXyyOapPMmtV8Hrp82yDqnpgIm2VvpLebnCySfCenFM4l2lZAwJ7jrThnDs7J2M2wWsQBSvKohDEvEI1mNJNceVNu0FENXCboSikGxc1hHrtI1eoyRcHe98YJZ63c9efcRq0z9z3YpKBsQUk+2s8qWetZiH49cTauq6CKlpuDvNHNC/OS4tQLFvMhog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vef6LloKrbNuvod+rQXqQjcLe05jJ2ffdA8SbaUv24A=;
 b=JYQcLvHykFkPyX+PF1684qx+nuHCdpRXcfFMUP0632eKshrqlX+RjWGNA+4+iYshh/jdjUEcpRpjKcxXONaFle1KzKIBnHcdNu18mzpLCtGH+VSct6gHXGDtOmtc3hovaerIuO6jyPISikvtyLavQ1It0AOwwyF2caiCAx7RjFQ=
Received: from SA0PR11CA0157.namprd11.prod.outlook.com (2603:10b6:806:1bb::12)
 by MN2PR12MB4240.namprd12.prod.outlook.com (2603:10b6:208:1d3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Tue, 18 Jun
 2024 16:40:16 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::97) by SA0PR11CA0157.outlook.office365.com
 (2603:10b6:806:1bb::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Tue, 18 Jun 2024 16:40:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 16:40:15 +0000
Received: from sonny-B650.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Jun
 2024 11:40:14 -0500
From: Sonny Jiang <sonny.jiang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Sonny Jiang <sonjiang@amd.com>
Subject: [PATCH] drm/amdgpu/jpeg5: reprogram doorbell setting after power up
 for each playback
Date: Tue, 18 Jun 2024 12:39:53 -0400
Message-ID: <20240618163953.699473-1-sonny.jiang@amd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|MN2PR12MB4240:EE_
X-MS-Office365-Filtering-Correlation-Id: cc6e308e-20be-4e35-1ad6-08dc8fb55511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|36860700010|376011; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5B8KOtSfO42OTr8Tx7jsLzchrYYLkTzSQN7jtQFeGBPQeGhAFjF5x9JGjCih?=
 =?us-ascii?Q?yWJDfleb06/AnHETBXPwMs5r2nsdrYuxlE7qboEnLbpUPcAj2S7I4T8IVTDU?=
 =?us-ascii?Q?n2yrOSes3bZJiCE43PmsBmZopnGXlcU2ara9PrQnWsZf/rG/u/wh2m4YxCLP?=
 =?us-ascii?Q?8o0esbvuqF/ZBnAUD+PEHTj38VZ/NUXFr0eMuu6Ip/gTsJEKrAbwTx0Hqimy?=
 =?us-ascii?Q?CU8bcX6h3hYHZGKDQjExIvWTyDa/sP7+o7u4+p5dT8XwC4r7JHRL8ndd+px0?=
 =?us-ascii?Q?CVGoDo1azLIqn7SEnSRi0arCfMxOatZZTUwjXtaPrWfmcEYiUCH8Ar0TlYr3?=
 =?us-ascii?Q?XtoFsIOBGiTlFG4AsGjq83tHQad9HgqaHolLq5idjaPJf96iBzkW+Dg3fdjX?=
 =?us-ascii?Q?ntyYfON17Bl3Ypfzr1BXvKekNLPeRulmmTNSqJvCv+Z/F8cpkZT+MJGW3Pcr?=
 =?us-ascii?Q?wN0cOFnMjXXMq8IADEI0mDQfIQplhVgIL4hVByYQ02oq2aDA5lvX3kAvQXvL?=
 =?us-ascii?Q?x5W5yTyY28vKf9rY83BWkphhNiGlbjdsbwbDL6Iw22rd3PmoTjdq2BsBehN9?=
 =?us-ascii?Q?TA1GvTW7T6xrBlcrD83nr2mWpvwyA9mRFwxFxUeDCtHrNVW1BJEQkBT7mv1N?=
 =?us-ascii?Q?eadheQnOM4evfK3S0YxK9iS6dyIgRgpqbhcQoOyQ+jgjSRC1wIyYXwwRNKu9?=
 =?us-ascii?Q?QmrKIOWnoe4LkWThTPYBdows5PgnejUXU39lxSIx/f0EUo9wtQ1mGbU2F/2z?=
 =?us-ascii?Q?K/+fBiyBLVvkhVGX2y5ACDwFENhk5YxIBLZTV/dFm1jOcjdlRDDlrOR2JAQU?=
 =?us-ascii?Q?O6EU/CBNmvlMxDb17E/Rk0k9+TV+hyWoEEQSCzAdFgAz3QL6oQG/3hwehTIl?=
 =?us-ascii?Q?EvkYzWGSBF0Sxy8pYKDZ9PfNmIXFn2Af9aREJbZUfDjpDowjHNF6LTuDLxat?=
 =?us-ascii?Q?W0ES9ASlH971i3+VH9cZRLNNde5LZx/BMVQVWn0H5fmGRlItlH0Buqtb6KOb?=
 =?us-ascii?Q?pXPzVYIK7CKrCmpa2rHD2tW/8b45XmMlJ/Tv9yaJV8qgPxE7tOgK4vGbLd6j?=
 =?us-ascii?Q?C17abMbJSyhnIgDDjQeszIctjVYbrXKqnw5EvLVz/OxFyd9h6S9/dz+pbVm0?=
 =?us-ascii?Q?OCLuC4cQG6Elij6cImGB9/bPLdRG5Oc2zGu2jffsTMDCfddpoqsziwgjitT1?=
 =?us-ascii?Q?U/eHulVRHjoyMhw06T1PlaKhGfcTQCQ3QGqw76nT8JkAZ5rbYNbi4jLiI+uu?=
 =?us-ascii?Q?8MrMOWsax2+CLkPd3fnJtJ5STJ7TtieulSu1FgafxaDz2nG58eOf+mOSBxwz?=
 =?us-ascii?Q?ibZhm0qscxEBAdINg+cwVwy8Fz5S7jJDdSxq3zEJEzhrxNvqf4oSvDCCzVdI?=
 =?us-ascii?Q?9WlmTImxXcUtUGIjg69GKPMAoy4uufK/4db2ZjITSE47lFcD+Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 16:40:15.8023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6e308e-20be-4e35-1ad6-08dc8fb55511
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4240
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sonny Jiang <sonjiang@amd.com>

Doorbell needs to be configured after power up during each playback

Signed-off-by: Sonny Jiang <sonjiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 68ef29bc70e2..e766b9463759 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -137,10 +137,6 @@ static int jpeg_v5_0_0_hw_init(void *handle)
 	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
 			(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
 
-	WREG32_SOC15(VCN, 0, regVCN_JPEG_DB_CTRL,
-			ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
-			VCN_JPEG_DB_CTRL__EN_MASK);
-
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		return r;
@@ -314,6 +310,10 @@ static int jpeg_v5_0_0_start(struct amdgpu_device *adev)
 		JPEG_SYS_INT_EN__DJRBC0_MASK,
 		~JPEG_SYS_INT_EN__DJRBC0_MASK);
 
+	WREG32_SOC15(VCN, 0, regVCN_JPEG_DB_CTRL,
+		ring->doorbell_index << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
+		VCN_JPEG_DB_CTRL__EN_MASK);
+
 	WREG32_SOC15(JPEG, 0, regUVD_LMI_JRBC_RB_VMID, 0);
 	WREG32_SOC15(JPEG, 0, regUVD_JRBC_RB_CNTL, (0x00000001L | 0x00000002L));
 	WREG32_SOC15(JPEG, 0, regUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
-- 
2.45.1


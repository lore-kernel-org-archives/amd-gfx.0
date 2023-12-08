Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71813C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 22:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D26C710EB45;
	Fri,  8 Dec 2023 22:19:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67C2D10EB45
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 22:19:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3ktoJUmXwRjGB4S9sSFHH61tgbeRww9KlysaClSr0/FBbm7HMuEK2SDuzSKfFi1/9+3Fxa87/vql0ysFOHKHYd7UdPxRtS+nN5dx/rA9e7e+tPLYllMBUp138uYsKZyTFK4R/yEDVeCO3FAtrgF6W6OtXWl4dGImQy9KdWCLEBcieEHKwV4NiFwQG5Bqd3c3cVDCD3G9edGhXGMBoM5R5P8S2nqfeee4rOThWgQMONYj7uxp6BAopoBWxiUysCX1IoHhTui4aFRmGX0t1oZacHUUkOJrzzrFqI5M9j637yKO1Ht7ollOjMpgQW7UIRUlILI/PpLxDb3oOKg4Akrjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzjqFBbfGHANBkPnia+BK6AjCC3QwdRJHLDCauGyBg0=;
 b=SYWOVp9sP9a9H9C/V215mDKorsUDynpGx4JjjuMinouZvKkXNdnMS+d/duy8OujHEkOWQtsGYQgiIG4f2FmA/mX+0u74rGqAz/RH1Zh42EbrVdtGJPzTF4uJEwzAziUc1H/AeObQWAButmtzg1GkfA3CU9bktanKjTHP4ciONiXf/MJ5EgIgomRkeOxf195zwpOsHZXS2cu1MKx9X8XcvlYREW6yMIcr6prOJpB2WlHgRnTZ/xlCrCfOYxGoV0NxY6jFbx4T7G+rYKSN3fJFByXrT6Ro1z1BHVqOYh6NM7JJWBT4SnBShNXarp+XaIp4c23jwPY3deCZK7Be08RhHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzjqFBbfGHANBkPnia+BK6AjCC3QwdRJHLDCauGyBg0=;
 b=agndmBFCUV0q/GX3+qbaa70iYmL0aeFfOwsrusz6baB8SDBMVRms+kT36F4do6yVv9vOsx/Ytp2sCDZrJoRx0nMbM5DQTtb9rVJlZmy9Mnm2uiNzFylJNfpkVa9akHS8AM++RbQ+7Qdtp6isVtzky36RbOIHMGfJE68T+Rq9tog=
Received: from CH0P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::34)
 by SJ0PR12MB8168.namprd12.prod.outlook.com (2603:10b6:a03:4e7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 22:19:44 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::a8) by CH0P220CA0017.outlook.office365.com
 (2603:10b6:610:ef::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27 via Frontend
 Transport; Fri, 8 Dec 2023 22:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Fri, 8 Dec 2023 22:19:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 8 Dec
 2023 16:19:42 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu/sdma5.0: add begin/end_use ring callbacks
Date: Fri, 8 Dec 2023 17:19:27 -0500
Message-ID: <20231208221928.5679-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208221928.5679-1-alexander.deucher@amd.com>
References: <20231208221928.5679-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|SJ0PR12MB8168:EE_
X-MS-Office365-Filtering-Correlation-Id: 482b3d27-dfc2-42b3-841e-08dbf83bc7bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bhjkbWP5gOt1eGzNljP4OslQ0fmUPDmI6wQ/XJXBhychDSKbo5Lhx6KAIV4bA6xqY8m8dQrwD3I257Bd6N0oaiqfP7SBFS482VsOSHU0fO66pZjuzjsaaHjCQt/NRWKKPRF8EZeVy3HkmcClTzoMnCtuMDDgSiHUdCPd96wxi+rRa7YLNXQ7JjdU2rr70q9+ZrOG8BiJZtbK4CwwlypdTPclKNFJzUGFvZJL4Ub9npnVWyz118JJZjFJj9odzswUi3MqWEVtd88p+yMm2U5joAWUPF5SWQRC6Se5NNGeAqXxcLkjlRJPsbAI7vabdmYyhpgoCt1l8Vd0bXUKebQU9zhi3hxBYhSSCq/NsrLq7upnWx4+rjHbwmNpTux9RPZBFGadmq1C+neyXdU4ScRCWeKaM+rkITMKrLicT/o2XzYKcVNKSpq867uP3A+XwpTVHWuSb9iJIeMPQfcx2O4WM5TtZx3nrAxHaXVqyowV0wkbRvkzR7pYG1mxrryGzfkPUHC0XXphutvmCdpA2sDEoIINhMRwg8s7jJIEQcG/kQuwfbyghwhtq2n8x2se9EUyG+R4Sw4ejT5EF0ACOqBgfzZcORdL+E02ECKirZnaR4fKvRaIG5aECwgcwy77w3Jzsrwxq+iR66gdWWavYgCh+Se8JsCJsabmtleQuaCa3yzN7Dwf3gIqmwQKcdmuRWdkQnFl75sbOt0Ju8A/v0fnvSE2hFqQbWPHDOgkA6ZzIkdANcpXexpce0ir7lyvTWTHDm3pOchpiQGH8BTaztrUZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(47076005)(6666004)(7696005)(478600001)(82740400003)(36860700001)(81166007)(40480700001)(356005)(336012)(426003)(5660300002)(1076003)(16526019)(40460700003)(26005)(2616005)(6916009)(4744005)(2906002)(70206006)(8676002)(8936002)(86362001)(4326008)(41300700001)(70586007)(316002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 22:19:44.0120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 482b3d27-dfc2-42b3-841e-08dbf83bc7bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8168
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

Add begin/end_use ring callbacks to disallow GFXOFF when
SDMA work is submitted and allow it again afterward.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 5c1bb6d07a76..1a68cd2de522 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1790,6 +1790,8 @@ static const struct amdgpu_ring_funcs sdma_v5_0_ring_funcs = {
 	.test_ib = sdma_v5_0_ring_test_ib,
 	.insert_nop = sdma_v5_0_ring_insert_nop,
 	.pad_ib = sdma_v5_0_ring_pad_ib,
+	.begin_use = amdgpu_sdma_ring_begin_use,
+	.end_use = amdgpu_sdma_ring_end_use,
 	.emit_wreg = sdma_v5_0_ring_emit_wreg,
 	.emit_reg_wait = sdma_v5_0_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = sdma_v5_0_ring_emit_reg_write_reg_wait,
-- 
2.42.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF45C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Apr 2022 18:28:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2498810E44B;
	Tue, 26 Apr 2022 18:28:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1017110E44B
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Apr 2022 18:28:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIEvvJtU7bD2pusooV5/OMFrY/LTRRMBR6+A8SrTsbV/pq837VmjoaI/SVGcp5XbSSIP14vmbA5bKNkM3CvhAwmso/qjKX8I5zkr5g6XEEWBeNzy+bOybYhf5ZblIKbW7JKci3/tfzOxml/rVl1xMSUaUgZsG7Fl1PHfhg8cCE8y4pPOPjmBM1y7O9/5g41L/dEXqlgZdiZ/1HYGWaMy4Nkntjxtsb8jml2bD9r4uSRyMx+/VeY4jBsovlaSHdtv3dhnVYPsjqoOwR+bvCj2FubM48rJw6eKi/4PwAS/N/Q2a90izy0U0p4kt0EN+PN5DyLSlAbQx/0UcBJ0r+3ZCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEfjYBaQ0tg6kfKZw0jeHFzlBcIQPLgzOKL3UXvOh+Y=;
 b=bqS7awNZgPUgKxraYU4BIrtsmnuug+YgVZwms3lNkmyMkKuUPgjKs1eDSIP11TvwdoI4CClVOXdyKO+fkYppvdQK1i7VvYRprBoiHEsSTjlcxU2Y729H0rUh+bZyvGfdFnJXqlUjPgdeixFMB190lHu6kZfyFFoNlt0qIWz1M1bKUrCMR1CR4OXNjGA3QoqLaG8mT+wMjr3rjPVuQVuTay7MlbHDcEQEHAzslEqjgnf7JpVz9A2WCmGvPg4v7nkeLmYDBREANUcu17u1+ncsJRZtlY2v9CZ5GVz66iLXpeHL88xBXfsLb0XJ8VjDHPzNgcxvrDuaULdvcpg1uZARgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEfjYBaQ0tg6kfKZw0jeHFzlBcIQPLgzOKL3UXvOh+Y=;
 b=ORdqvAz8ieXWaKWU2LkSq4fTpqAHC2R/jx+50xBgHpcteHXKNNiJqhm/pKmu812Z62pjWkqXHPQyUEz7jac7WQMvyoJ+96Uaigp97Eb+zY8JPDkVF25czqBEZ3ObidV5DsDAHh0Ps3fbXzjP/6ITuOT8x1e6Kt7om9jDY1PJLfI=
Received: from BN9PR03CA0614.namprd03.prod.outlook.com (2603:10b6:408:106::19)
 by PH7PR12MB5654.namprd12.prod.outlook.com (2603:10b6:510:137::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 18:28:34 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::2e) by BN9PR03CA0614.outlook.office365.com
 (2603:10b6:408:106::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Tue, 26 Apr 2022 18:28:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 18:28:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 13:28:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: switch to atomfirmware_asic_init
Date: Tue, 26 Apr 2022 14:28:20 -0400
Message-ID: <20220426182820.3006877-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426182820.3006877-1-alexander.deucher@amd.com>
References: <20220426182820.3006877-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9935de95-a0c7-4e18-c0ca-08da27b29271
X-MS-TrafficTypeDiagnostic: PH7PR12MB5654:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5654A0B00C0BEEBB5B8DFE9DF7FB9@PH7PR12MB5654.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IK5Z+8CD+l8reJtyprfXIpYBWKvU2i6AbyOnXnr4agi3uBxtmPYSj3UaplzyUTPiwO/caM+9IBlLTJ6FD8q0l4PQ2/NscVTwoapNIRucXOM0W5xnT15tIUSEMGg0ukxIUFddzoxWHtMJGfbT3qDMasBEpAHQBF1zKGYaKsNyQj5FlgcIpW0DbA3tv83ldcT8POpAYzvc1RxyQjvZNE5yLPEYhRPNpjJDH/1/z2HholW3rZV8rtT9BBq9Ah2MOAEk3NUP1hcBtFHFDXVU7dXrAY+fFs+cDRIyVRIwrTBTR9QYaLXU2BQyQD0tZRh+2jzLS0te98echuhpTlepC9svnsqOuNLVp1zfSM2XwHeXp4s4Q5DDQ8wM2/2Z4SML3qe6PsYtc655Z8KKsLf5RAKxxxqw6UlTJhqhJSN2UNMI8Jrsnx0Y9XWCn9In2OrTg/2TwEEBca7QhKXNYNKpiJP+Ao9ceGYknhDmGTOcFUTEyymcdjtHfYth7HFCskjPo587/pYWD4T+O9ABAAvmesmlEa31TzLjFDQ6xat10mLH5akwEHC+0E5OZoOQWG+utKKTFbeNmPdBTHSp7z8CHFp5cPxX6DA8OyeJpU4nRIKwHS5TBNW9uqLsZPeoiA2eiv63jiRkgvv6ly0mF+NmWCYdOlVw3Pk3hKZ3OKPLii1onuT5TxNq2GG3xcZuBimxwFQcf7l5ZPWNfrp7WOcTdD2oPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(426003)(47076005)(336012)(26005)(36860700001)(4326008)(8676002)(54906003)(36756003)(6916009)(82310400005)(2616005)(316002)(81166007)(356005)(83380400001)(6666004)(2906002)(86362001)(508600001)(8936002)(70206006)(70586007)(186003)(1076003)(16526019)(5660300002)(40460700003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 18:28:34.0312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9935de95-a0c7-4e18-c0ca-08da27b29271
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5654
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Some initial settings now are not available from
the atom data table. The assumption that !ps[0]
|| !ps[1] in amdgpu_atom_asic_init is not valid.
In addition, driver needs to strictly follow
atomfirmware structure (asic_init_parameters) to
initialize parameters used to execute asic_init
function, otherwise, the execution of asic_init
would fail.

This shall be applicable to all soc15 adapters,but
let make the transition on soc21 first.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bbd5c2570e92..f33e3c341f8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -913,7 +913,10 @@ static int amdgpu_device_asic_init(struct amdgpu_device *adev)
 {
 	amdgpu_asic_pre_asic_init(adev);
 
-	return amdgpu_atom_asic_init(adev->mode_info.atom_context);
+	if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(11, 0, 0))
+		return amdgpu_atomfirmware_asic_init(adev, true);
+	else
+		return amdgpu_atom_asic_init(adev->mode_info.atom_context);
 }
 
 /**
-- 
2.35.1


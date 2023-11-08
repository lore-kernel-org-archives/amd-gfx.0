Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DF4C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 15:25:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 310A110E79B;
	Wed,  8 Nov 2023 15:25:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18F5F10E79B
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 15:25:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESdJfDIzGdsskwL/rI1zQeG4osGdTRPxseeL2/apSAgkGjouReInCwMsY/VmfTWjs/XajdPaIIjJXipe2jpxLIsHy9nZGFSD+xMXARckhlxTuH7BgwqvxTWxD7sRwc8iwaIH1hPKWSuyObhdMtANtF26NNaAKMr54GDgRIbOErOLMNoLeTbRTlbdVDspjUiLkU2BE7N0+xDgTRCiJlydaUx7gQyfz+kLt1eVAX3fsQ/p7XkTxU7jkKFq5naOhu4YFTQIW7OGaGgxm4fnSunegR7Exo3hfeDn/FRKkZNVbtWFAOwxNGoGoFdzknEn1FhlIj1l03NDPJjLJA1rHpkW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAKUg/2QguolI2iyb7D4UdSVsIWQ/aVNehBMtr5L8C0=;
 b=AB7IkWimMpbywOmPu1pC17v9eutlCVy6t6Kr/2JrrCe/WOlEYZkXmLK4TVFhFZPAbeNkohGjZhoWI7BB5PcU5IxlLw6OYTQX1unG8q5u7McCburLUM5Xv4IFj44JY7PInG6ZzrG8LHVNKb4f3WDAVsoHSvIsPoe/GF7cOtIqEi3S9Q1xGgcyd+cwROrk6qt39aCS3kmpbKSdcrcs/096C9+KhMpojcYu7mj+FRBrrKUenumYyJTX9RiCvenNZmTxby1cdCPXbGFOBdPXsYkRj6a4EazhIcoieV7ncC880QDEBA7x3du8uD0Zj6Kfsust4KOIZXqehxo52a8XT6WuCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAKUg/2QguolI2iyb7D4UdSVsIWQ/aVNehBMtr5L8C0=;
 b=e7IEPWaeyL8sZ9j7yKr6OVUT8ciqOasXo+m+y/202YtHu5tsi+mMfKhO5U1qqnrliQ6W9i0sUoY892lIlYG+Ni4unBCy38FTeNhWSMYg858oViae3pS5YYXTc7WRGev/PNk/fc3Wl2MV3Avyo56x5sKt/djIbLSWyV1dmwaD4/E=
Received: from DM6PR10CA0034.namprd10.prod.outlook.com (2603:10b6:5:60::47) by
 DS7PR12MB6287.namprd12.prod.outlook.com (2603:10b6:8:94::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Wed, 8 Nov 2023 15:25:09 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:5:60:cafe::79) by DM6PR10CA0034.outlook.office365.com
 (2603:10b6:5:60::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18 via Frontend
 Transport; Wed, 8 Nov 2023 15:25:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Wed, 8 Nov 2023 15:25:09 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 8 Nov
 2023 09:25:06 -0600
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Do not program PF-only regs in hdp_v4_0.c
 under SRIOV (v2)
Date: Wed, 8 Nov 2023 10:24:31 -0500
Message-ID: <20231108152431.3301-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <DS0PR12MB8503AA16A3EB7149CC7A4600FAA8A@DS0PR12MB8503.namprd12.prod.outlook.com>
References: <DS0PR12MB8503AA16A3EB7149CC7A4600FAA8A@DS0PR12MB8503.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|DS7PR12MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: db5d334b-0342-4900-06b6-08dbe06ee4f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +uLB2dCkJthQ4UvRsSjBcT4Z0l1KF+7hMgFSzX4vDNflSSwfoZv9AsixCRtd/lmKNYiGzdhmMAZvZ/+r5S8+pT0inOtIQfYFaNqOAzgiSWgcfVMxRSE4ITZFT9/iZD7RJK1nuiaYSVPHDA2d3QsxTgByEniaQNLPqM32TJda3kKLoO4+udrkYbOmdOzUcQ107onvWgbA8klc1q31H0fDEcK/FjYmvgMC6Z/+gncHiXBgrpu82K3ZiSdbBo/O9sycndqNeFh1XmntsXp62rccSNtYAT0H/mARDSgF1vRyuI36N8EOodh4uaefHh9rjq9qFiCQy7GCeVk3kPX+c9Djz8wW1y9IT+5AaftBZwAODFaI+3tO8gjHdaiCJCncblO2ETDu55b8INAWx3yCWeiRh7icw16VDhGe6cxCjjo2QtCFm7egqBWpYkmLoq2bDZc0qKSLWpZVyGNjgh7E6s48TWKMVWWUlUFzgQr/aQPL6+vhxGkGItFavvBAgDS0TonN3mP9Z+S8F7LADm2tTSyvT7Rpv58pybpkye0ht8vYlEoUhRwX0UienFlUqRYANyO5thwoLP//RP8/GcTNhnxA75RQYPu90RdBZdxR3zr3oAHl9r3w6czl4GwHMRu3TlizoJAx6QOyOBG73ujZ2qdwKVc4Y3B/kiFhIfgCbQ/BGR0l9xWAFYjLXthqTJCV6vf3QCUzu7TUeIBD2+L7a8T4IZ5rt8UoKJruWz1/wTCASCsEjkKaYwnw8wfdyucTpmSh5FWl58VS59kLBZK1opcnYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(82740400003)(1076003)(336012)(2616005)(40460700003)(83380400001)(70586007)(16526019)(26005)(478600001)(7696005)(6666004)(426003)(70206006)(2906002)(8936002)(4326008)(41300700001)(36756003)(40480700001)(36860700001)(6916009)(5660300002)(356005)(4744005)(47076005)(86362001)(81166007)(316002)(8676002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 15:25:09.2623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db5d334b-0342-4900-06b6-08dbe06ee4f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6287
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
Cc: samir.dhume@amd.com, Victor Lu <victorchengchi.lu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The following regs can only be programmed by the PF:
HDP_MISC_CNTL
HDP_NONSURFACE_BASE
HDP_NONSURFACE_BASE_HI

v2: update commit message

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index 3f3a6445c006..bf3bdf67abb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -145,6 +145,11 @@ static void hdp_v4_0_init_registers(struct amdgpu_device *adev)
 		break;
 	}
 
+	/* Do not program registers if VF */
+	if (amdgpu_sriov_vf(adev)) {
+		return;
+	}
+
 	WREG32_FIELD15(HDP, 0, HDP_MISC_CNTL, FLUSH_INVALIDATE_CACHE, 1);
 
 	if (amdgpu_ip_version(adev, HDP_HWIP, 0) == IP_VERSION(4, 4, 0))
-- 
2.34.1


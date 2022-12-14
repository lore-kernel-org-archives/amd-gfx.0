Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0047AC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 22:17:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DB6610E4B5;
	Wed, 14 Dec 2022 22:17:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8107C10E4AC
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 22:17:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVNrrlNU1xRdDtKsKjxcXfKaXPgorN9oAKI0Dfvj0cTs2ak5MsYC3+bE9kjTbNRqcylON/KnhDRjyK+mBHM/nyfLXUe07E8xEH9YXMBh7IeQa/4ki5e4ouJgAXdWMMRd8Uv7AvB/72EzKWTZtWwCRR69UU72jLGJrJmd2Ik22krIn5m1xbdJdtL+8ibAmCtsLH/gFxNgm4ZkIEDKsY6Tg6IVBMlHJz8UmhAbM5vnt85YhNjg2pMZ/QQNj78MIwOLWEUk95BXlTZCWgFT5B7NhSqEf7wprZcdvEC4jhO5NmBXdEVf/YF05Dqv0iidQYCdpSY+0gTFJo5//mqhb55sVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxmUlAZ20+OaQ8pjRYvngmLY6KktUf83pzEYK9cdxK0=;
 b=B4KBKUB6Uzx+dX1o+SGPjGT7F61yz1WO1WiX88YfyuLdMBVLomrVicWhYdPJc7RVouEJoFMZCePMcdPobgyHK4lU4yz0Hv3Cod5OdvaL+orh6JGFQUBCmb0VHRDQTXa6fLtIQsj93nJxJ6NUZS+I+2KHYuC1FasTksIrWS3tvwg7397y4k1KveEVbctc4sPPGBxs2+O3lq7wE8PGvJBXPw6phFb3qCXcfT+fY+Fj/rxXrF1bB60wYJ3FM/LRiPMMRwlXxKb782YPS7P1WWTPa3/sBDUbYTEq6ubPQ9DVsLbtgAC3e46AKBb4Fs8eYVynj/631169VF88KSjgzBtpWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxmUlAZ20+OaQ8pjRYvngmLY6KktUf83pzEYK9cdxK0=;
 b=1ahwJPA48RjMNPdPwyt1XaEPuFzW6VXO6vmNHKG8fqDvV9VWUKuZ/MzoJ4ozUCEslMNNpJB6O+0o7zDZAix6JulT3Pj529lkzLapjb9T06Fr84G+9uYfaN5CVWHjUiHyLc61NNCiU4sFHaCKU/JaRFsr5/wiRpbSss0zcw2TXBs=
Received: from DS7PR03CA0318.namprd03.prod.outlook.com (2603:10b6:8:2b::32) by
 MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.11; Wed, 14 Dec 2022 22:17:13 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::14) by DS7PR03CA0318.outlook.office365.com
 (2603:10b6:8:2b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 22:17:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 22:17:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 16:17:11 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amdgpu: for S0ix, skip SMDA 5.x+ suspend/resume
Date: Wed, 14 Dec 2022 17:16:52 -0500
Message-ID: <20221214221654.1625194-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221214221654.1625194-1-alexander.deucher@amd.com>
References: <20221214221654.1625194-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT031:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c2bb3b5-bcd1-4f2c-ac04-08dade20f3b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J10ozIK3/rUAMIRPytrk40clSEsR/w/O8Eh5jXzOG651A+nNCpEI4ecORcJQaE65flEAdHtewjtm9Ix+yhKqsgcbBs6P3teyHJylh5p3Srn3j+dKtNQM6qg9TGzaZIpas0WCc7Kcdb0ifXdMWzAPpvyK3RVSEHG+mewO75UAqndSf+IeftgX6b7sw6FOOn9Iumttd8h/oaAoTcy6KJIvo421OWF1arZfrHMhqru5s/DWuSSLg+4xH9sDjQU6s2vg1FMHUYtwS4obFxVn2gl5bUj3h69LVoSzWtMg0IZQAYiuECmVa/H+2LZY2xyO3Xv1VAc5wZ35O/Jr0i9cOxCI8fCyX+Rwm4H0g61t8CzKNoyl0e/wvbEVpHAu3rm2pXwZcUmsysatD/buwP81vEw7LC80Gr0VfZepP4oFhdzKgXPHEK3D3BAeGf/w0BMV9QHNVnDnr40ioTbF0DUP4yYdQ98MuNDddSvQFBBVoeg9/abqjJWrG5SjDcdLsaFuJni/c2bs7AX4HSLW+WCAU/OOoVrdT4PVKXdfN+kSfPqLgSCorAs6hsgi/8WEvInaba7xq14YQnzpan/XWeI8FYyPH/xwXIc50av5wmy9BnQiM9on9r5BdXQNQvtffsBRbdUchni3mUHErlPTu0dHh3hieAj+1+LBtWCdwFaTaO9EkWelHwS/QmZsAvW5J87Jziwtvmy056KhLqVqAK9mODEV+d86dEIY1o/O6EpyYeIhmBJ83k9WXAyAHhFA9b2ESXs/PhMKGqUVbCHnn+RtzTyEZtxIt8mQDkkYhqay8dmNGt0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(36756003)(2906002)(40480700001)(40460700003)(36860700001)(5660300002)(336012)(8936002)(86362001)(1076003)(15650500001)(2616005)(81166007)(356005)(426003)(47076005)(83380400001)(82740400003)(6916009)(186003)(316002)(16526019)(6666004)(4326008)(82310400005)(41300700001)(26005)(8676002)(70206006)(478600001)(7696005)(70586007)(21314003)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 22:17:13.5007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c2bb3b5-bcd1-4f2c-ac04-08dade20f3b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224
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

SDMA 5.x is part of the GFX block so it's controlled via
GFXOFF.  Skip suspend as it should be handled the same
as GFX.

v2: drop SDMA 4.x.  That requires special handling.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a99b327d5f09..5c0719c03c37 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3028,6 +3028,12 @@ static int amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
 		     adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GFX))
 			continue;
 
+		/* SDMA 5.x+ is part of GFX power domain so it's covered by GFXOFF */
+		if (adev->in_s0ix &&
+		    (adev->ip_versions[SDMA0_HWIP][0] >= IP_VERSION(5, 0, 0)) &&
+		    (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SDMA))
+			continue;
+
 		/* XXX handle errors */
 		r = adev->ip_blocks[i].version->funcs->suspend(adev);
 		/* XXX handle errors */
-- 
2.38.1


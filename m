Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A76C43217
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FA4410F378;
	Tue,  3 May 2022 20:29:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD4AA10EE60
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:29:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTYefwPnygbHyl1ixHwfRODxakIRzYObMgrxXO5+5oeyqrfeM/FZn94ngzYTOJHK3l2waIpBQjUm1UiTSB0j24zVkzY3XM4AHL8bAt0yZbr+O7Abt7LRavJavlFhPPT0JZimryFe6viOBUSb7oSy9zdL6rEZpfvbVXDB8ub2piiQlbtMQowj7ihueC6Vx9zGei/quI2rbFPyFhllyIlPWzfp0Ejuc2oBp97dLOJPTqzdQ/bQe40Y25fTfVNZ1IoRlQFfoGfFHQ3JHc6VnRaaA+vdAhXVWfC8f6DB9uUqLxZuN63EOQCeSnTPhMaEo4H7RC+COuwofaCo9M3YeKpdmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lMopbQ7Q/2D1i5d1gI9tn1U8DfwfxgWU7HRzr+3f87o=;
 b=fPFzcIQzTEMQufCECn0rFE0DSlgXTYA9dJ7kuMl8FPWcDga2S9oaRyeaYNUefiHGBBTPM6Mh0gG7u1D3UMbRj9Z7UokqSyOa0+WYAGB0Pc1n8449icgVBuTSkQEMbFJd/9QTV3Z1xT/c/McsRvIPig2EqRRiuxRndyqYcoeEfCq2k9ltc0Cn/cevrLw7weoR1K7ZGXUSR+gkNel+G35/VEtFG6QBHc9/foXrUhKFANqNkzUvtn7jWjB3C0xbql4MH6hN2MmV3yPQtI5B40T8EtH6txW97PTfCcW3a3Fp4TICdS1zecC/v65ADPVQh+r5cOBsSAEPsAdOYu1j1OoeKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMopbQ7Q/2D1i5d1gI9tn1U8DfwfxgWU7HRzr+3f87o=;
 b=vOyBR4MAedl0NZRSKgeGXd45606HgsOeW2GHgoyXzI8y8QxtTeSbf1sJY9CYmtswOYhRuBQ6+3EEldKqieOkh9DTh6Gb5K0wudZ0moP3tkzC+hZoXNkLibTcI5mmCnWeWrR1Zu4aWTIaUEFoMe3/+E0Fq4pyPYwoFiOKTZLuBg0=
Received: from DM6PR13CA0034.namprd13.prod.outlook.com (2603:10b6:5:bc::47) by
 LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 20:29:28 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::32) by DM6PR13CA0034.outlook.office365.com
 (2603:10b6:5:bc::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.8 via Frontend
 Transport; Tue, 3 May 2022 20:29:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 3 May 2022 20:29:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:29:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: add psp13 support for PSP 13.0.7
Date: Tue, 3 May 2022 16:28:52 -0400
Message-ID: <20220503202912.1211009-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503202912.1211009-1-alexander.deucher@amd.com>
References: <20220503202912.1211009-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91ca90ed-a090-4ba9-fa6e-08da2d439f05
X-MS-TrafficTypeDiagnostic: LV2PR12MB5966:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB59668D2E01865858D841FD1BF7C09@LV2PR12MB5966.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: byihoP3YYz9XCEbizvlm3a+B1tE6eAMRx9KQAi+FzAFZOAXLqjIaPUIoWPU1OCDkCLuKNtFbPlVRlEz7nnUs2IxG67R+bJjbcjetC9dBm9eddI7v5qnFKcl+zuCKEwFLLcS9Rfv0QrLnIYFVFotSzCAmAVDwqQOzkJ6mF3L0z1nmwRdfdyAJe0QMxxAVHl0BuUFV1Q664wh+3V7WZ5J9feFlqw9GGxucxVlo2bJcQso/1aVieSiUmBGMWGWRHVYmba6gtS+cueJEO90CI1gHsGpQ+7dxrZGx2gG5TkFDzKCOlUF9v6ddyg8FeKsNnrHHmTk6NLjdSry1Z+gUyTmYHr/508iFE6fWD5FwdJqzDxM7NB1K5d5up9uCFiblZwqHX+Dte/WbvEoSa3BxhRv4rKF3vCGObEciSANhww/PJMzKdxNiUq6072UOq76spPtt9AYCrLo17wihddh38y3k94oKTwEtPJq0blswvflIAn7MOyrwHoRUqGYQ5UCrFeYVsnKIwMmYD3n/IgFgHjmYBUsqmRS3q3ajYoJyZlS4UB2EXhxksdAEJpyJlXpIJF1nxict8o9WaiyBh3SN4Rm1QaibbwVV8fvzs/MpIS7ChuY7uh13deYh0kGwn1vG8CfhmFfGe1yU+nY7QI1BLJvONgI4QLY6kw8X94j31mR0TxeHaRx3SPeP7QGngwYgRCDAnRnDEWSZPiP+DmzfLEWiFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(40460700003)(86362001)(82310400005)(2906002)(508600001)(54906003)(81166007)(356005)(70206006)(70586007)(6916009)(316002)(6666004)(26005)(7696005)(36860700001)(4744005)(8936002)(5660300002)(8676002)(4326008)(16526019)(1076003)(426003)(336012)(36756003)(2616005)(186003)(47076005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:29:27.9436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ca90ed-a090-4ba9-fa6e-08da2d439f05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Chengming Gui <Jack.Gui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Enable psp 13 support.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 6771eb798de8..da2466b37839 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1603,6 +1603,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 3):
 	case IP_VERSION(13, 0, 5):
+	case IP_VERSION(13, 0, 7):
 	case IP_VERSION(13, 0, 8):
 		amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
 		break;
-- 
2.35.1


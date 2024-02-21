Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA16C48BEB
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Feb 2024 17:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65D2410E1B6;
	Wed, 21 Feb 2024 17:00:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="soFPwp8Q";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C142410E279
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Feb 2024 17:00:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dW0zkRmEvycOmm3uvbHZ2aee+YdwvxHOTZCm3hKkN3IQvpRBdeSqErlm1Iu1gl1VOLnflTQ5d9fsY0BNjnlXVujh/0cg+CyW5f6MEUYn1Fj7QXrNilUQnPwg7tWnFJ69l3QUju1nBof0+UsXDMllOo21JCgGBWcPE4JSyYlquSMdoGQs46+JkFJoXup4nwhIzpVZQ3AgoAZVCIuBL7jVKmv0KCnxxGF8SMjwvep2OWCKTj3tZA6/xArL2aLTRRHSD/vdk+9HTojGf1m/G/cjFygJe5dHEKEIzyXgOdN2Zq0NV5iIlHP2wsFSBi5tLIbONOLK9WufM8a+pfHs7gxxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTOlv0oYfofIZGHm6SnRRR6OyIMFVqMJRElzy3WS+LE=;
 b=Wa1//H/0vw5EYUKoFh+JShTGa7Mx5d75UsYYl+ZrzhnuaVZMr9wYJm0WHXdowuAfYwZto0qNU/cmXaDUXRFhlpCROxOGXtF/utA5wtTTNyjHV7A8mdLVmUrLkTrZhoie71tsZL+WMyveKb7sdONhiZV+S35yagofD0EC6XvpHZIxAPet3aA5YY5ejkz+29Vtzj7UFpTcSrX5JlAOlSGWnZrHh6Q4gGMhcjxc1PKFtxSzmZ+I/wpQzq7x9Jk/KF8uDNAMRgJE1GVaRKNqN7cylscFJvYlP7XTdVBosaZYcjripeoyyPwgubwpYTqzWq+mIsfPHA2WjLBmdGZriBdmEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTOlv0oYfofIZGHm6SnRRR6OyIMFVqMJRElzy3WS+LE=;
 b=soFPwp8QGbs1la5rn4VQQbdTPgVEs6PgfCHrvok5mmpICjR06QJBSs00flbYKEK/26e6iLDsyee8gP8Knr7Ozq/DDNEjlck4eDJ/gPNnAo0R0wvdxiXymFuiPFqz2h+2UeH3wkpRO5TVnIe7I7sOvVZihptI+axtrDa4PEW6bVs=
Received: from CH2PR04CA0026.namprd04.prod.outlook.com (2603:10b6:610:52::36)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Wed, 21 Feb
 2024 17:00:33 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::f0) by CH2PR04CA0026.outlook.office365.com
 (2603:10b6:610:52::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.40 via Frontend
 Transport; Wed, 21 Feb 2024 17:00:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 21 Feb 2024 17:00:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 21 Feb
 2024 11:00:30 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: add vcn 4.0.6 discovery support
Date: Wed, 21 Feb 2024 12:00:15 -0500
Message-ID: <20240221170015.8866-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221170015.8866-1-alexander.deucher@amd.com>
References: <20240221170015.8866-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 156ef356-01c5-4425-197d-08dc32fe9e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q09eS0L7zFnKIqiRecawkHLVpNzq5YkunehJInRhQCW7EwAjd8V8lB8T7LfutidCaoF4gYvYzIQSXlNJ6H5Vcot7WLf21rZeYSvr6dGYr+qjOmQrr3ZETpNHKmkUtV4pNq2tKV4aEJ3hKq/DQXyrk7vGidU/br3/B8uoBVyn+ciB7M85D1mxbGD25JTLFOpmnOqdzCJ7HFy9LRd2eQTBqxUUYfNCSIgUvRB8qL/MG618rLw/+ILpmhPhnxAag7ngkJcLU13XcApKmzbjJGDBRq8PAKHDQ1VGpt83u08h8B5hxF+Ar+UV6F5QA1ubebBwMUIuuEuydbQRbb+U+ZSH1nAHZR2YjkgAfZOLluy0cSDBId8axedaxKCb9Dy7gviNyqjH9Ev4CMT2EBsimHijWL30tH4dkuuqjws7pHFPEv7MkdzJiNN/elgcSlLDDdN+TFsvyPOeGCLcmE20c4t0DnljTJG9dECKTKRPR/hPdrMr9s/f6i5/L0bEvPJsTUNIVpmHv5Qwf2fd2YJwLZGMPdQ3zPKrgOhAHwyK3g52GnMdHUDL4AN/rISGCvQqcBRlrHcpxKFu398VoGtls3zwUwdZbXqNUMh/Gft+q0pVIMGqHdOE9aB/HSLDo2RL31h/OZC+reLTOZxgABd9rwWfRbtr2CnDJcPrqdWPhHemlfA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(40470700004)(46966006); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 17:00:33.3439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 156ef356-01c5-4425-197d-08dc32fe9e0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327
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

From: Yifan Zhang <yifan1.zhang@amd.com>

This patch is to add vcn 4.0.6 support

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 704b7820c47c..6e4d26753aac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2140,6 +2140,7 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &jpeg_v4_0_3_ip_block);
 			break;
 		case IP_VERSION(4, 0, 5):
+		case IP_VERSION(4, 0, 6):
 			amdgpu_device_ip_block_add(adev, &vcn_v4_0_5_ip_block);
 			amdgpu_device_ip_block_add(adev, &jpeg_v4_0_5_ip_block);
 			break;
-- 
2.43.2


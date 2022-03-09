Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A309C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Mar 2022 18:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACDD410E342;
	Wed,  9 Mar 2022 18:58:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F75410E342
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Mar 2022 18:58:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMb7VRPDhvCItqJte2pG02hrq/SIqcHEt9kxQlLdBcT4/v0//drxzsEKg89qn2vfmHfQ2zdMKuAOCsZIPaC3LJ7XptvU2l+PC47+4GdCskhMB6ctJ+PxJsRfTLoNRGV9sX10GQxDmRcgWhK0rHj1vFOA51JZqRLXHBlZGig1NF53d5ZBAqrPGAbUJoxaOG/2HqOLcs3wdqg27ZEh8lwuSX00HSjlI80dOSKKrFmLWJyoOLPJwnQqzOX5Ex7uqTgk/5AOlkqP7dKD3PXp7YAyWU2Maz1rYS1CScb+JRmAeECTqrqzzL/IUzTG+bqn+X8ndJ8M7HhLrPm2uUsIiMnLZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5puGjzYJFxrsiq+jpl83QBduNbMlKURWAv5uzIJAdA=;
 b=dn3XPsxuWgVKo4R2T7/GIPFTqMyf58Ejp2BDR5o2XcKmsQBQ7n7y2EFI4SYggw16Ld3S22D97FAAzxmckek3VwrsYNXFhc6sfZ7kAXzE65wx2WN/hsAn200Vtk1V3P2LtfNmD8JtvK8HJ5/PXFk0JQVJPALVff2axQg7G04yZAi+Yq19f3Uh6iansO3IiORM3oEVQmrHShKG1lb3lj06JZRlldgcWs7K7V0rZ9NjCThQqu2QKjxoFj0+h6PHyq7wRsZCVIZhBGlK1cUInr9VsrCKr0oyE1lD4oChEZ9K03g27SjL7B1VuqB1ZzMMk70857EIoD0sGYtpqf3ghMg1RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5puGjzYJFxrsiq+jpl83QBduNbMlKURWAv5uzIJAdA=;
 b=qLEOTHBeAiRdWrhPMkW2ESokuB6E/gHdvxUQ6HI/EcZ85jEvV6WIBWiyyBibs67CH/oZ7n/fYrJ5gnjEjHq5vu99x11JEBc88R78PxlLik8Y1EebuxQH7af5WWOQoxkE12tdWOiR3U3VlqccvtPlIetXiJtZzLkFgLwGAsTGlY0=
Received: from DM5PR22CA0020.namprd22.prod.outlook.com (2603:10b6:3:101::30)
 by DS7PR12MB5792.namprd12.prod.outlook.com (2603:10b6:8:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Wed, 9 Mar
 2022 18:58:47 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::f8) by DM5PR22CA0020.outlook.office365.com
 (2603:10b6:3:101::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29 via Frontend
 Transport; Wed, 9 Mar 2022 18:58:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 18:58:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 9 Mar
 2022 12:58:45 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/display: enable scatter/gather display for DCN
 3.1.6
Date: Wed, 9 Mar 2022 13:58:32 -0500
Message-ID: <20220309185832.1324487-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1308db12-ba8c-484c-bd32-08da01fed70c
X-MS-TrafficTypeDiagnostic: DS7PR12MB5792:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB5792DF1CCF368B9F69A2A6F2F70A9@DS7PR12MB5792.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QxaiSLbzb7WGZqbP9M0QdjsgpO2is0eHRCHEl7ffoQj3u6bsO1q0VvhntyM0qcEnnlVfHaDKpdhpm6Fq0iY3NFl63sMdXd5wtZ2e1wdsoEP2/6c3guoy9gVQuUIKveuaZtOlGaL3X2rID3Jus+sdjPmStENn5Vt8SbaynE5W6djZYhBkziXjMXZ/DgkbLpkbJG/0bnwhd6LPNJKrzWALkzLSj/zlGMixX/ATSjZN7Sela6JHZKCHUnzp/pmKOc7tlYANPEvGqcjq83o8SIlKBe/dRl3U14vgnKU037emragMzV4LCWKxHvJ1ad+2Egp7IcpI1Hb6Y0JOQrupTsHIFQuIAaTNZKZyPCZje3YxCcz/uVZgX8ZhqYtQY1Nx2gfluTOLRPkwaVQki7hz9nI6jAi8noCyefh83/AsJ3em7QQqFsZ5/eTSqQIt9g/F2YaIR9FvLB+PbbOV0sU6pWmmvCJ2x8vlg3TaorbXweggYn0mifOWj0qzkxPn7x1XFoUlHVRAxiOPUu/YT7TnbxWpSUBWVjJkSW4COlS1yiHHT+MyKqtCkWvqWypMimSwYfk5AaE2XXpAuOOgVNeYDTxiaBoMC+KsIsxuDP6JINJ9Ag6ByeODKbyuZIlwdhir3nUFCBS1+1hlnukxGDYrt2NnibxjD1akCydC21m1qr4+drwID2RSU+KBGgcC24jn+cpmT3w0xtFNVGqzDE8sL8MnPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400004)(8936002)(356005)(508600001)(36756003)(4744005)(86362001)(70586007)(4326008)(70206006)(8676002)(81166007)(6916009)(316002)(5660300002)(2906002)(7696005)(6666004)(1076003)(336012)(2616005)(26005)(186003)(426003)(16526019)(36860700001)(40460700003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 18:58:46.6510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1308db12-ba8c-484c-bd32-08da01fed70c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5792
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

Enable scatter/gather display for DCN 3.1.6.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a47370058088..da9628a0212e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1481,6 +1481,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
 		case IP_VERSION(3, 1, 5):
+		case IP_VERSION(3, 1, 6):
 			init_data.flags.gpu_vm_support = true;
 			break;
 		default:
-- 
2.35.1


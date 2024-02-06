Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AC2C4828D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 18:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD7CF10F2C7;
	Tue,  6 Feb 2024 18:06:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TsPs5v6l";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48F4D10F2C7
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 18:06:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLem4dkqu2i6fpiDB17J/GR2mu5fn4XFudoXMrWI1XgyU+DALqnuPmfxwe8OwNoNobjyWS/JG3sbZNUck4pRFFGcuRKC1PxbSs5w4UfJLtsoV+T+UchVZ0jObsmPb2WuTNFkqRftpwFCOUQ4zxKxMb2oSrLLXxU5qoZN16yydf8q+/PlbU2F50IXKMMeCuDlNuHJ9dINwCH5ymrDNvEiwVkTHwLLeCuZWp7k3OPTyJQR+CvJLeoFfXFHX3vNq6rwTnye/sd/s5B7/jZW/wyEPhIK5R+0Lk6SpJ1Z//rl6kWiutw0Xou1HaT9lYlBf0Qkyzfv2W9riR4qZCJz0UpA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYG2oFRDDNDRq7fp341B/vCp8Soad/mI7EusWBUCP+Q=;
 b=UMVw7eqdlp2/E6v6Slz4y6rSfr01njFzBuNgYxqmRTP2h5/1HqdsMagiub87GcGQBiDum7eBsh3efO7WuNu4WM3B1nTYGzjA5UUkcbczxJ5jionY8aLZlNt3DElXpN7IcavbXuCt6yhJ+vvMQBA1nMQDkhnfm0VdHc9ni3O3gvag0Wm/jgKxhZtg8zrZG2pld20sGtNMxHcs04JxtU1DQDtzJsyadjo3s+Ofw1EfyPPJPP2Uh3sSEp/WldJ6i1EXDdx+v7vfO7MIV4BHgO73ViOQEMUSb917JRDYzwk8lTCu2XrclY4xzBsxxQxPb3e6Pr9gjgKg9IxTjr+D9ZXy6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYG2oFRDDNDRq7fp341B/vCp8Soad/mI7EusWBUCP+Q=;
 b=TsPs5v6l+9lhHJ2ecoPExXIEai0bB+7VVodlf436EtfdKL0iv9ghxCkJGLD+gmk9i+zn5ObuyUd49vCxzjcRA0i9zGT8xgyfhNK95COxB/HIg5ESWodZV45H4BcoSfuVTJ8TnFNEaaxKrDIvKg9tGIC9tLGGeSsnV1LwsJWHncQ=
Received: from PR1P264CA0162.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:347::16)
 by LV3PR12MB9268.namprd12.prod.outlook.com (2603:10b6:408:216::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 18:06:05 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10a6:102:347:cafe::dc) by PR1P264CA0162.outlook.office365.com
 (2603:10a6:102:347::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 18:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 18:06:04 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 12:06:01 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <mukul.joshi@amd.com>, Kent Russell <kent.russell@amd.com>
Subject: [PATCH] drm/amdkfd: Fix L2 cache size reporting in GFX9.4.3
Date: Tue, 6 Feb 2024 13:05:45 -0500
Message-ID: <20240206180545.626910-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|LV3PR12MB9268:EE_
X-MS-Office365-Filtering-Correlation-Id: 0957d505-1899-4671-c31a-08dc273e48cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J8Aw4PDsvYRYMhiJZIsmXlw3e70Jsq6UPLs0vwMRx+oUesWxTiotrG8EKXBTY7U4IKfij7OCuexF2LEBIvqt53FozRpoVvkmHNkFSuBMKs63u6gkEJsPOEmQ/dv0YG7COBI/F9MBB8DM1SCwAYVPKrj8NliJGJIZ0By01sk4DCv4Gb14+6r2FeOBC0GOeCWBXUEAu8EiISsYwTsKE6bwnNGYnOwYngyWF+shKLawFTg+bJ7z82LvNWtj3sheBzKaMqzXQ4mcSPMg8bfS13pJokJ7f31NJonaOmsEShCqq3SeF/ZmbcQia+xt7nv47BHd8aMH9vQ+LANPV8Ba+KG92A46CvsBy+QtbJYqRDycJfFu7few5tH9hOtMrhl6eZg6KqudYBQfKIWjKlJYQPllGTOkP9EduRp9J88OBQrnOy7LNvWJOOztdUJu4Uvg1St7QIYaC1z7MhUGoaubhJTHTkWqNFL788r6jMHuaHO5LqrYtLItyLsTWYC7H/qAS/MnROjyfjDb+difAcudB3dNalfa66VTgEKUsxxXG2Fe74lhnwQlrMsOpi41qzXtGxiXR8rTMPqpc7fuQNzJL2MbA03aKSqJsSCC1W/YMIzIfR8uD/+BB2MHQB3CKPZmtDUvGTAlzu1lY9FoXJex9z9RdcsG0n/JXeH9E9/2pPZuzkIfqnj9f+NCauAq8X3D1Tuv8ClsEckHOjPr1jGR9+HjzrF4ATRyviXOrFxrIXSjf/RT73Vaj6KNRUAZjwzChsy3DIhAFICDtBXiQh2E8v6fYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(41300700001)(36860700001)(47076005)(4744005)(2616005)(2906002)(83380400001)(336012)(7696005)(1076003)(82740400003)(36756003)(356005)(426003)(6666004)(81166007)(16526019)(26005)(54906003)(70206006)(478600001)(86362001)(70586007)(44832011)(8936002)(316002)(6916009)(8676002)(4326008)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 18:06:04.2042 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0957d505-1899-4671-c31a-08dc273e48cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9268
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

Its currently incorrectly multiplied by number of XCCs in the partition

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 3df2a8ad86fb..64bf2a56f010 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1640,9 +1640,7 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 		else
 			mode = UNKNOWN_MEMORY_PARTITION_MODE;
 
-		if (pcache->cache_level == 2)
-			pcache->cache_size = pcache_info[cache_type].cache_size * num_xcc;
-		else if (mode)
+		if (mode)
 			pcache->cache_size = pcache_info[cache_type].cache_size / mode;
 		else
 			pcache->cache_size = pcache_info[cache_type].cache_size;
-- 
2.34.1


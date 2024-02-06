Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F95C4828D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 21:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CFF0112E73;
	Tue,  6 Feb 2024 21:31:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xmVWn23c";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBA8A112E73
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 21:31:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCfoaGBbNYkMfvexKSmYE4Kc/LDuoBwpW6HCyTxfu/qOmv5+wz6n93+dfxO7XdB4Mndmi+wXIqW+D2Dkan7C0VXo7PVEwgpv6v8OsnsHzvPRavZEOBvLMjt0TbvAuxhjCA6FipAyMSwpGLU2tQorfesYzjrT+DPtrQnBAMzsQAX9LpUqklPjAABKFPglf6Qb3Dgopbw7SZ9Zh2km8tB8qZ7xgfp+IF3oXPNPwSWGWFfsg3xCp5iSde6VRTEx1curXqOXdUr3iKq4sMIHGXcQvApKUUauf8dmpdemsRmMjVAlJmIiY/0eE9Yz71Oiz/gOFY24WSr5nRypFHfrVER8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwEDD6AbPt6vdVSk9XDXi2rO7yppRzzmVstEusAz+FA=;
 b=lMHA/HCp1O/pGKrEQ07UM5QBDXFXFfblv+ncTT8LCppUdSQh8xnGxNmzmYu1337N5SBuxdhJ3rEi4XH3OmrYgXQh6Gc6gKDZnvLF8EPD3EMliIPZfaA+KlhiR7CBsKVFHHNdlc////fDRf0rULrzyDS9AyZHA0iEpmcKiE2CS8JZcF7sN2OEI3xtsHl0i7ZpluKdM5L+WiMJOZqO90hwEbPM0Ee4ulB5JRU2HDIM9yfEZPdEOCsVqnmQ5FtV+25Fx0cCYcu/JThY/x02hi+dZPpD4ehWB7v7jZSgUULkDdXkVc8iICqMWaX+eI9n5UDU90bAYA2eXAVpj/NQi4LzHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwEDD6AbPt6vdVSk9XDXi2rO7yppRzzmVstEusAz+FA=;
 b=xmVWn23cgYBClQUxXvrYUquTWqSnNgJfJYzGCzKa3qtAmQMWWSFq81CaX1yZF5eaYey8HmItlYaFtV79GWYg/kRlt38sdUYRxTz0gJmWiHQn5Pz4YcS8aHhv9fR9Vy5qGG67qnMzP3WoLuB84UGmvTUlKjFv9Z8j0xs1YIELRwo=
Received: from BLAPR03CA0129.namprd03.prod.outlook.com (2603:10b6:208:32e::14)
 by CH3PR12MB9099.namprd12.prod.outlook.com (2603:10b6:610:1a5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Tue, 6 Feb
 2024 21:31:50 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:32e:cafe::7a) by BLAPR03CA0129.outlook.office365.com
 (2603:10b6:208:32e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 21:31:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 21:31:49 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 15:31:48 -0600
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <mukul.joshi@amd.com>, Kent Russell <kent.russell@amd.com>
Subject: [PATCH v2] drm/amdkfd: Fix L2 cache size reporting in GFX9.4.3
Date: Tue, 6 Feb 2024 16:31:40 -0500
Message-ID: <20240206213140.629705-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|CH3PR12MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: 667c4f0b-1c91-46af-9c7e-08dc275b0711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N3NtXr8YFtHHfxAJQnt/kMYr6HeG3kgxJXJaxeLqAA7YIvUN4fSW+u8jQ7tPOSULtrdgyZK1N3FgAlQddgznklTsC2TuEsjn6Y3MZ8IZcABu5fk9r/cZX2SxpZOhWQxEKRFqVOa0xehLsVgP4BlhlMoAhG8lxbQqPFjRJ/d8CLtjCs2eOV8J3sBeGME4R4Tj4wCUVIjzF550FjWLAAds50e4NN8t1uohXe4zi881yNp7Oryq+ypCJHgm+fytxEwm1mUFxRiC5vOMbYLGJsag+rCqX9U0nkxEMtl6pTYxUB0l7V64DAyBX2LuMorTf7fnQA+VTzsdb0INNLx1fsMn65huIyoWxzhQOeLdIErZYVWDH3ntVot7MJNeUkNlGDw5uL4moUTT/JQGx4Ast9mBPRWH2gxcUY5UV6VNHbx9xS3R5yM0P5qQ4a9D2YcabRoxIuCEaZ0mTQqcSu9TzQeIzfFOS2xEmoN0U4jc1nQ+8fZlQ3GVBgvvRSkzLUL7ftB2wSU83jzPtiPsph7s6Vu0FTbwAlOHBO3EB0JAauoMP3E5QQDLsj2290iPJ9hMGGYo59+tef68orA4rXgRdH6D/EcgOz3/BbLSGq7AWu3QmCtE/Xo5tqxrskXXHHL4FzsCp4Ya6fA60m9/tubWoZg38EdAPwBE1pott7xmUjaXRYihxsPMomcDTH9oPg13/UMZ022NVdNeNf7hq5+i8LQoCm9ZHDFVzHEomUNawBlfWqsCMOEDrDVN5DbFUqbeLX14eXzQDszF8rStoM3T6LbO6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(186009)(451199024)(82310400011)(1800799012)(64100799003)(46966006)(36840700001)(40470700004)(47076005)(2616005)(16526019)(26005)(83380400001)(336012)(1076003)(82740400003)(41300700001)(426003)(356005)(81166007)(6666004)(8936002)(316002)(8676002)(70586007)(2906002)(36860700001)(6916009)(5660300002)(4326008)(70206006)(54906003)(44832011)(7696005)(86362001)(478600001)(36756003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 21:31:49.3557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 667c4f0b-1c91-46af-9c7e-08dc275b0711
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9099
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

Fixes: 6b537864925e ("drm/amdkfd: Update cache info for GFX 9.4.3")
Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 3df2a8ad86fb..533b8292b136 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1640,12 +1640,10 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 		else
 			mode = UNKNOWN_MEMORY_PARTITION_MODE;
 
-		if (pcache->cache_level == 2)
-			pcache->cache_size = pcache_info[cache_type].cache_size * num_xcc;
-		else if (mode)
-			pcache->cache_size = pcache_info[cache_type].cache_size / mode;
-		else
-			pcache->cache_size = pcache_info[cache_type].cache_size;
+		pcache->cache_size = pcache_info[cache_type].cache_size;
+		/* Partition mode only affects L3 cache size */
+		if (mode && pcache->cache_level == 3)
+			pcache->cache_size /= mode;
 
 		if (pcache_info[cache_type].flags & CRAT_CACHE_FLAGS_DATA_CACHE)
 			pcache->cache_type |= HSA_CACHE_TYPE_DATA;
-- 
2.34.1


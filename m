Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B2FC77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 18:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 777C810E392;
	Thu, 27 Apr 2023 18:34:56 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 940B510E377
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 18:34:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBk45ll5aKQ37lYqK5XVKpQd3p1Y/LvrwtclLm1g3Rv6fkyBTWklvsXw153PO+Mihzb8wZs2nffPV+hQuvufAQ0QjCC/6nQMdfqjQ3dxcdz3xxwaDRM4p+31YjD6QvdpUXjttp88B7Jy7b6zjhHuv1AZ87fHQU0W/IyiVAnJM90qBCdJ0+BPqDg9XjcMoBfJU80J6CwnfIIwa4rXlIzzejKibo9dLLCqCTAItfcWfOyPiM28e2WGTlCwvExdHxtp2mH07Th2fNyufRMPsZHfwlcsLy+T8vmAmsphIlH1cZTgYNwkqakf6Owi33sRqwLSW3yTuT75juaYI2e4O+h/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YC+ivOLNBbgs1ayjHieDMnYr8tXZBT1GPO8u9ddb/I=;
 b=b+KGEnKAMlcVBjqzwuqvduA9tNjMZliuNBJZ0EnRIeGDia1ycUqn9Y+yFxzwT/FzH3PMtJPzOURQZK+iFpuC6D+TY9epPawwEdQoKT3HUy8Lqf/zeyr/2qF5Uatjh0yRsNE78Z8N8GanDb9CXEma5jLbE5UmyHFN5cbAJqA85r7Hx7AdzvkAGS1eDcky2dRy7iNTdQhZ8vxdlh22Qk2pHVXZIZnWSNz8dCPzV/jg8CfrWAOhXCqNXXJJTplsMnGk4whyjwHLhG7VFcdlPO8Fze6Cbr5RM6kivEjLHwWc9cjrRbzzww9Jda7Pn3vbHdoXgYsiKwOzurQcbF56pp0Ghg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YC+ivOLNBbgs1ayjHieDMnYr8tXZBT1GPO8u9ddb/I=;
 b=hqrgQdHLkXJTTCMuxpPGaOm+g1aT+BkOeIKq6GwmK8+586kOp2w8t7dXXItH+4r3UM1yOMeZc+awTBF+YBHiKYeGW1FwZ3r13J5fjXmd2JZQ0xtSoElYCnR6m+9xU+AwmL7Xk25m9Iu99uaeFfvBgAxqlp2wxfZ9uRkffP/md74=
Received: from DS7PR03CA0097.namprd03.prod.outlook.com (2603:10b6:5:3b7::12)
 by CY5PR12MB6346.namprd12.prod.outlook.com (2603:10b6:930:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 18:34:49 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::7e) by DS7PR03CA0097.outlook.office365.com
 (2603:10b6:5:3b7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23 via Frontend
 Transport; Thu, 27 Apr 2023 18:34:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.23 via Frontend Transport; Thu, 27 Apr 2023 18:34:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 13:34:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: drop unused function
Date: Thu, 27 Apr 2023 14:34:29 -0400
Message-ID: <20230427183429.599578-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427183429.599578-1-alexander.deucher@amd.com>
References: <20230427183429.599578-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT050:EE_|CY5PR12MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a44fd6d-2fb9-4856-dfdb-08db474e150c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0qkVIAg48R/xrx6DTb0fenxnJuaK41NjkhP5BTPjDwlgclYbZTntWiolguw8qON7+8ig9IENvdYS296SjXFiKI3/fEd0bPHnn2eetk1Ucr5na6WZjwH81jWLZNhYi74Zcjn90xJiiZ08mucUhbcWUIv8zetFg9aFj0Cs4TJJ/Rl2yFLKqkLTqj+zTlMfPwBHiGBexfMjjQXQ58mSFGbup7xsNQ3EFXcpgKqmX6A4PNjWTuMvJ4zEFfl055V+Fjbo8xT8h52eIH8+qN9ZQxaaqm7rgmzAtqYSKWeL4LMhOmBlGewIM66H0zCxm84luzLCMlWBTSApUfp2WMyUvtoESudBZB6JCQPK30d77qRQlzfBcocUATfIOGk2Cz+nfHulExnKFeTnBKW/9dbEz8QYppO0x8ecatFAldodYbshuxBgFaU5XM/XqS7Q78Hn3MhggtTtWVVlZmLGqcQIihBduEJvGq8EAiAMQvK0wB8f+XW6Dc4lxmv2VWSJYe4aZanbHBcvXMxzy18yVQFoReZSRqeAB3uCQEPJblngI5a+rvX9YlcrDhmhxuUEVnjkPX9e3kvVFyW/wWQZrnFtUsTWEs52wAEog9mbgiEtafPmBxaRfP6F/l1euxka9TOUM0LXSu9iwwOlq5wP8SqphnXRhc8eI2ZzufR24ImrrcV0THQQDoCDGCuYFbPeC00ynDwAUsI6t27BwiLJ9o0K1JFgVeNhrNjfBGPEIRNujjcGRLE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(86362001)(82310400005)(2906002)(36756003)(40460700003)(40480700001)(7696005)(6666004)(36860700001)(186003)(83380400001)(47076005)(336012)(426003)(16526019)(1076003)(2616005)(26005)(70586007)(6916009)(4326008)(478600001)(316002)(356005)(82740400003)(70206006)(5660300002)(81166007)(8676002)(8936002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 18:34:48.8462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a44fd6d-2fb9-4856-dfdb-08db474e150c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6346
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

amdgpu_discovery_get_ip_version() has not been used since
commit c40bdfb2ffa4 ("drm/amdgpu: fix incorrect VCN revision in SRIOV")
so drop it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 48 -------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  2 -
 2 files changed, 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 76ceca05452e..b58d94dc1924 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1208,54 +1208,6 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int number_instance,
-				    int *major, int *minor, int *revision)
-{
-	struct binary_header *bhdr;
-	struct ip_discovery_header *ihdr;
-	struct die_header *dhdr;
-	struct ip *ip;
-	uint16_t die_offset;
-	uint16_t ip_offset;
-	uint16_t num_dies;
-	uint16_t num_ips;
-	int i, j;
-
-	if (!adev->mman.discovery_bin) {
-		DRM_ERROR("ip discovery uninitialized\n");
-		return -EINVAL;
-	}
-
-	bhdr = (struct binary_header *)adev->mman.discovery_bin;
-	ihdr = (struct ip_discovery_header *)(adev->mman.discovery_bin +
-			le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset));
-	num_dies = le16_to_cpu(ihdr->num_dies);
-
-	for (i = 0; i < num_dies; i++) {
-		die_offset = le16_to_cpu(ihdr->die_info[i].die_offset);
-		dhdr = (struct die_header *)(adev->mman.discovery_bin + die_offset);
-		num_ips = le16_to_cpu(dhdr->num_ips);
-		ip_offset = die_offset + sizeof(*dhdr);
-
-		for (j = 0; j < num_ips; j++) {
-			ip = (struct ip *)(adev->mman.discovery_bin + ip_offset);
-
-			if ((le16_to_cpu(ip->hw_id) == hw_id) && (ip->number_instance == number_instance)) {
-				if (major)
-					*major = ip->major;
-				if (minor)
-					*minor = ip->minor;
-				if (revision)
-					*revision = ip->revision;
-				return 0;
-			}
-			ip_offset += struct_size(ip, base_address, ip->num_base_address);
-		}
-	}
-
-	return -EINVAL;
-}
-
 static void amdgpu_discovery_harvest_ip(struct amdgpu_device *adev)
 {
 	int vcn_harvest_count = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index 8563dd4a7dc2..63ec6924b907 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -28,8 +28,6 @@
 #define DISCOVERY_TMR_OFFSET    (64 << 10)
 
 void amdgpu_discovery_fini(struct amdgpu_device *adev);
-int amdgpu_discovery_get_ip_version(struct amdgpu_device *adev, int hw_id, int number_instance,
-                                    int *major, int *minor, int *revision);
 int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);
 
 #endif /* __AMDGPU_DISCOVERY__ */
-- 
2.40.0


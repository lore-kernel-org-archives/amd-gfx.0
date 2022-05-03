Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853E3C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:51:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E68E10F60A;
	Tue,  3 May 2022 20:51:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 777DC10F532
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:51:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/7tzSxXlzdKoEOgXdapIqArkI0UWYGPlmq9wNSbFKH3ABLeUArE+IjQ4X7mjg0fgCQdkRjOlPCsPtiC6mFBRnw3tSatYKzbzaqN64jYlInbsUXNAAmxKYO8RG+WrIK9zmhlH8BAcDjaNFYVD1rqWbr3M7cutdSZh1rghBd2obONCrTcOegIOxcwcSGYfmxFdBl4+kEgD5UdftmCwv2tqPkU3FsOt42/9Py+75Rn3EGKigESd0aFRMSJ9r1cstUnvfRqV4azMhrDPJ4J/8Sbecx+QlPjGw2NqAZZefiZC1mnsFh8OlW+svPjnG7Wd7Pp4WBEFhyDMzg54lumy6P2CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZa15bCFotfQdAqaa2taujO0K6fCPiELr3MIlzzryK4=;
 b=WOKgjMGeR7NC66BC4JZFM25QsVGtYxusLcOnBSINy4FU6x8jBZ6HuGbP12fhJOC8sWsnS5JO2E6kTBN1FEKQHcmN+//aOolPwux6UArjvUNyUXww0ZvqfhOURarISFamWGZ2+N0sqnI5FkqqNVjOLF80Sw3D+w3O45qiRfN6cXuAkDK6NrX64aSS4czYGLF74rYW0lNWWRqh6VmYHlPdS8a33nI1kcwUEBu8UZgjvA2gE3h+gL4QPVu0y9D7LTEQfSZt57HjchSm+ZxkDphNSdSS/ghT1BoHK6btC9MsTNK7aiGJ49Z8YrIBmLd93f4PSxTruiSlDtjJnu6OmviHGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZa15bCFotfQdAqaa2taujO0K6fCPiELr3MIlzzryK4=;
 b=tOpUbBfCVoNaiL0MU/6EWWzjNKlZv+pNu+YU1GfId2xfH5afmeVBsBPQ98NWp1WAQJOwfTYxIWGul9cDRz/FQsGwdeYQcgAAsWD2zlODGIadc6iz451p1PoW3r9iBUAPOTUDS+U2lJyBcv2phz2s4QFBT9cFKbe9dMs/IJ5iwZk=
Received: from DM6PR08CA0044.namprd08.prod.outlook.com (2603:10b6:5:1e0::18)
 by IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 20:51:33 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::76) by DM6PR08CA0044.outlook.office365.com
 (2603:10b6:5:1e0::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Tue, 3 May 2022 20:51:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:51:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:51:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: enable gfx v11 for GC 11.0.1
Date: Tue, 3 May 2022 16:51:11 -0400
Message-ID: <20220503205112.1285958-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503205112.1285958-1-alexander.deucher@amd.com>
References: <20220503205112.1285958-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d6f083e-a142-4986-770d-08da2d46b535
X-MS-TrafficTypeDiagnostic: IA1PR12MB6092:EE_
X-Microsoft-Antispam-PRVS: <IA1PR12MB6092D272EF9808DFC4A13F20F7C09@IA1PR12MB6092.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iKOqBMYUjQ2lKknRud47aUbvfLbFksU5E1r+1+C08UHIoATA3euDcNXHNQCOCuc+V+jDxe7KewAsKVWUenXat1cFSYwlklVEZksxRpwlESvkeqy/GjDUK9flFmJnr+X+eQrJWE41yuzqTU/aHuNIN8f+s5BQ143+QzRLztvwRi6I8kZ22b1hq/h++4EoB3621V02lWMe3JxrCFdsJrQ2Z//WSOh4pNOG6qARFrq/0qa6LmeUDQW+nXrMlq+FUQWADtOgBLAZfm+5zNcUUmgm83m1AduKfzPpO1o7qiLWc5bRsesD/3+tyKbqAj6JRvijEc/IwhuZVdrtzddFF+TPigsC5ZsGmdJ5fUFXf4kWA1mCAYC+jAEweHaZe4O+hv3vdoFB9YoIF2geF0vb6mDmTUKKzWOxz5MCRygtux5wd1pxxQdQwDM0KaMLFUeJw8Co7c43Dxi6XxWpojhMQP1oTynHaSifzw9ScROc+5IUd/chokKPbljGqiNN8biyFTHH/3s1NKX4H24rKNv7z3ixFWN7Ert2S+hnF68RV5wyq5KMMWjc5kbDp6kDNbno62uz5CnlGo5A2pdyzJ3sScfEls+oVO+SRrW9YGtNWgdXl6bLUraJgpy6o4JdWeqhgJpgUerlbbEiSNnWmRBZMm72pHQuG2D6WLBvlCiM+j4zyfsQybt99ZUv2wSdNjIQ3bsHut6Zx99JVmuCco24cSxeCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(186003)(47076005)(26005)(7696005)(336012)(426003)(2616005)(16526019)(1076003)(6916009)(54906003)(8936002)(70206006)(70586007)(4326008)(8676002)(6666004)(83380400001)(356005)(40460700003)(5660300002)(316002)(508600001)(2906002)(4744005)(81166007)(36860700001)(82310400005)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:51:33.6549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6f083e-a142-4986-770d-08da2d46b535
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

Enable gfx v11 for GC 11.0.1.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 8621e30b52ba..9c44b2250a3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1749,6 +1749,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		break;
 	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
 		amdgpu_device_ip_block_add(adev, &gfx_v11_0_ip_block);
 		break;
-- 
2.35.1


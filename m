Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C062BC7EE29
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 15:53:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EEBD10E22A;
	Fri,  2 Jun 2023 15:53:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 336D510E22A
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 15:53:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhKzHhw2062EpQmBY/c8PdqM9DdQA4fnawlkl8tGI49QlA+TUYwUUsBWfGQP0W0METUP35gFkfAsgkayiowL4xJ4bMRbcqxFXFYZ/hQudRVynLpI1nazcY1p4mXvjHuC6lZ9L+9VM7De1WYlvpETW5w2x/vG4KA9OjIxnO1OxTMBGaTAzpjH6k/fb5hC80ceVUgbmtnNmSbR3LMu7nyez7osxIaLUaRdFMRrSUKu6tOTd/hOxr58cKKb+SSpe6GLWtcqBGS0AlbL14AacLzTal54YvIzuhCLS86KnAqywx2DNcXVehvDpO6kpk79CsXvDn114OY7dclmyYxVxjR1qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGvXexjvVy/ShhsuBXPxiG6xOau4MzTcKbGY3pDMHec=;
 b=VFMYLAEFC2x//7fE/HXjaO41rhguhs/MMrvzYdiSdE78padjbdtgPmDg2ah25Hp5vy1qIO6zK53nfItEQGhLgslE1x3jKqb7NkzX6m68JeEzg1MbOsHAnCujEBL6necccD+NpPzjYgX1QeVRGbpmFSKYDPePC/hGiheymHoHLd0eZqz/bEBN5xbu4fsBYa+VCtzZNRXCjbII5gJpEDbKB+hdwMy1AoITHV8TcLOVPm/AqPUU4XKnZ5rR/9KLKWDnIyT6HjkUI6nfC1bjJih9Oq/Kg8yQSl+bDK2IATZ+hVw3Jrhwv744mazHVlknTC2eq+t1iXnLPwShk7patSC15Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGvXexjvVy/ShhsuBXPxiG6xOau4MzTcKbGY3pDMHec=;
 b=3m1w4GZT503uYDe6833+IB02ZYGqOtLa/CoVW1n1/aLX1/wC3lBLmB0BO1ztO0Z/nBkg+w9ui8H0uMdBDtTKQhckdf6MUTZ8G6+AEh/AlLHFhCDGjKXiHLNTxREvRafP6NH9tvHsUS9tUjeRkg0a+4L0j297EvOinfvMoZlNnSA=
Received: from DS7P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::34) by
 MW4PR12MB7439.namprd12.prod.outlook.com (2603:10b6:303:22b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.26; Fri, 2 Jun 2023 15:53:13 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::e8) by DS7P222CA0014.outlook.office365.com
 (2603:10b6:8:2e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 15:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.26 via Frontend Transport; Fri, 2 Jun 2023 15:53:13 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 10:53:11 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdgpu: Mark 'kgd_gfx_aldebaran_clear_address_watch' &
 'kgd_gfx_v11_clear_address_watch' functions as static
Date: Fri, 2 Jun 2023 21:22:51 +0530
Message-ID: <20230602155251.1729429-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT044:EE_|MW4PR12MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: 55a72689-f6d4-4feb-e7c9-08db638178f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TWmVUA/qfxmYK6Oi6xKq9tdPX9vjVuAi4ICkvGNKeDzqYAkmPR6E4v6BjMdpUKeDIvzScSVbcM2PluS+WNIHBiNPwsw896lxL/cQxULZX6be0wng7VYuEabCov4TLKhIGkZuLCP8k+6dTSBTzfuxmk5QzjTm97bGlM2TsHfygCsYc0Bwz8UrcrhT2jyMmtx5ldzR2Qek26+qSoW6qSuTrqvVizUxPYIwJx3S66Rxh9t2cahDzWWvu1ERfNOYfy7XV9hR6ov6Pj+G8eQdIv06Of62X1KkqgRZnbw/LThexOntR99XU5fxoEnEdzBq2/ztQPIoSdNDZmfo6qrYzJBii3K5dbXQ5H3sIdoRa5OOwaTkOEUofveAuG7ShiFo9KBJbThwoJO55Y1vLa78JUD4iLzGiinO+5wWFOL5tJUSbeMj0rTv/YOBE2h9J7mQ0jEswCj17i5QvOHOnGAF+IXJiomEc1N3wPOHY6qhY1UwMRv1/myTyvujvMh8Js/gyEdzA9xg46IQfquncmvE8TIzcGoUeA8ymagylmsdZ2uDg5fwkkDgoOI9tYmPgEZegBlFdyueO6iRx//bf4FD/KBMBFIBP849s80v/2p+Z2LbWw648x6wLhAS2oI08NXq0szVW90akVyfWmhEXU4E3TAaorHv6gcj9B+Z+oG2d+ZfUqKYeC/Dd72qIiVhVDPqE0wOmUhCemXWMpQ4NjqzUWJKPTQujq+OGTMZhWXTQHkiacMZ5UQa9qK+QFeJzMJpvayF/akL5TbVV7oRp0hXvyfJwg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(336012)(44832011)(81166007)(82740400003)(356005)(40480700001)(426003)(83380400001)(1076003)(26005)(2616005)(186003)(16526019)(2906002)(66574015)(47076005)(36860700001)(5660300002)(8936002)(8676002)(36756003)(478600001)(316002)(6666004)(7696005)(40460700003)(4326008)(110136005)(6636002)(41300700001)(70586007)(54906003)(86362001)(70206006)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 15:53:13.3391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a72689-f6d4-4feb-e7c9-08db638178f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7439
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Below two functions cause a warning because they lack a prototype:

drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c:164:10: warning: no previous prototype for ‘kgd_gfx_aldebaran_clear_address_watch’ [-Wmissing-prototypes]
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c:782:10: warning: no previous prototype for ‘kgd_gfx_v11_clear_address_watch’ [-Wmissing-prototypes]

There are no callers from other files, so just mark them as 'static'.

Also fixes the following checks:

CHECK: Alignment should match open parenthesis +static uint32_t
kgd_gfx_aldebaran_clear_address_watch(struct amdgpu_device *adev,
uint32_t watch_id)

CHECK: Alignment should match open parenthesis +static uint32_t
kgd_gfx_v11_clear_address_watch(struct amdgpu_device *adev, uint32_t
watch_id)

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index efd6a72aab4e..60f9e027fb66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -161,8 +161,8 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(
 	return watch_address_cntl;
 }
 
-uint32_t kgd_gfx_aldebaran_clear_address_watch(struct amdgpu_device *adev,
-					uint32_t watch_id)
+static uint32_t kgd_gfx_aldebaran_clear_address_watch(struct amdgpu_device *adev,
+						      uint32_t watch_id)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index 52efa690a3c2..91c3574ebed3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -779,8 +779,8 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct amdgpu_device *adev,
 	return watch_address_cntl;
 }
 
-uint32_t kgd_gfx_v11_clear_address_watch(struct amdgpu_device *adev,
-					uint32_t watch_id)
+static uint32_t kgd_gfx_v11_clear_address_watch(struct amdgpu_device *adev,
+						uint32_t watch_id)
 {
 	return 0;
 }
-- 
2.25.1


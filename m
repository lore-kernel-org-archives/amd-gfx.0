Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6014E95A91
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 14:59:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04E5810E10A;
	Mon,  9 Oct 2023 14:59:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE56D10E10A
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 14:59:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGhkK4wW0OT6oL3OofIrKcmwTOAQLk3p40gaQT9LtlwgHi5qVxx/VM9/D4tvjJ+09xKwJtc0rL7ev1TYxLYidxrPqm2EvYCCbDIDroM6HAOqvJ8ecrUWo84mJEcsjIsFRpuDSdLvZRb+md7Uho0Y/M2bqJw6nUaQha1lQltDS3376zcvXGco+sKBoZeTDs3EujkV/GTaeXNXs6F8pKrXdZyH81oJjfZzLosx7nyN2aUbL1UIwRXqYk9uwNpqHK7Qk3yxnl0C82ypkr/ApkQ7NXtMDGrpQWuAgga45/4jmkKHQU45odGjFn1vdSrLxldDDNDArxWLiwhu7l617HxG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osQwIKwNx9RCJA/Gz54dfJaIHmNv0Swei/VpWI59Vr8=;
 b=aahrOAwok2Z46ssaLUMfKLjFvrvGRAZo0KGWwHQHcjJomP9IvZnl/hlG7xM3+yh0hR6QOl7e3oMEhN4fLcpPtQPiZKJIvU/lBHOeR/WNEdLFGxtsFaHu+/DzUpzghrqLqlOIcpoNITe94+kr8jDkfla/dzSUX3CEIq6fvKsGwVR2qSJP0kegQEr5dh8LK2dYoxjUO1ZS/0v4iY8eLr9Qi84+yyeNyFbR3+ak+iIOjHVnf+kZ+Z4Yg26y9HLRWBiXQqCDqNtc4dXMFF1/KnqUld11pEDbSmbRm6Q30fcUAHeUrV95mrvcSXigmXyK3jJxENFiJyzwev0ig6XvBhPAEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osQwIKwNx9RCJA/Gz54dfJaIHmNv0Swei/VpWI59Vr8=;
 b=b8Wb0JhUBgWEGDQOcIyb+7tW1lafWL8U9awPY8lY3qklwK7fdAIy2KmYx4UxEOQ6MY+kL8YlR22hmVLTYAjjLuTmVD2rx3++6xETM9Mv+XSYahPpxjI8kDcWFvrrM5FDuU57leJsKRaHDjp8OE62p59YssHefgLD0wLNBrRkWWQ=
Received: from MN2PR01CA0020.prod.exchangelabs.com (2603:10b6:208:10c::33) by
 PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.36; Mon, 9 Oct 2023 14:59:51 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::74) by MN2PR01CA0020.outlook.office365.com
 (2603:10b6:208:10c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36 via Frontend
 Transport; Mon, 9 Oct 2023 14:59:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 14:59:51 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 9 Oct 2023 09:59:49 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Address member 'gart_placement' not described in
 'amdgpu_gmc_gart_location'
Date: Mon, 9 Oct 2023 20:29:33 +0530
Message-ID: <20231009145933.164871-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|PH8PR12MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 902cf2c4-160a-44c7-cdbe-08dbc8d86388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ydjpokITm2tg1f/86M0Ez2BE1wbyNij/OoWaq8MV0Q4kp6FW5Otk31V6cnM45hxRrkCctDGsbrC/vVgS9Uv58WvqCS6/pNpJaC456ck+JLko5BXvqNixnUJZUzU9NV1grIPGGdHk0tEka4qgxaZBvdT0bpwiOK60TSmjOQPd9GMbYWj9vRjenb9BF0Zors1xUP7Z5kykjAVRvgC3w66FMfhQf/r9LvQQzFVNg9coyuemb8gUJS0nLwrhVPbpL00TgHK1WJYbCs0m1BES0iz4gA5TKhT6ViiCeTNzcazk7ZIvgG8odY8ABpKOFTJg7UJ2aQJ3m+FxTt9JhvC0AnDqbl9WjxYQ6p9wT64zS9KRofzKkRGX4dG7c4Ie54tSpbpb0MO2rrZ9N+ULiO2FDxbK7aqTjnrCgAueCQladAIrlgJ2/CqsDVW2S08YM6Ym4rz+V2LRrGy4cp91xp0A3TJqUcy/419zmPKUz2o3+/UMKurocJaPT1xKl+CDlmtnyMEOoy1hk1vbRI5WyPyIsWaiFIP3l/TyNE0lBaqHZmIP+raEztbhJYmdu3RMJIbJbk18drebt/5CtNatsR7XQZ9vFLYuEzbpiA9ez2BMMSF6aY8mr5y1urr8bCAtEiOThQRvPrQf/TvwrifU/Y5RuxCqDWhFyK5wbVTm9w0wYI2xA4Ff4YasT9reaSUBuy1i6zIr9yp9cSJFKatbq9kWTbOtOFFLUL1RZRu+aZAVvcdM+uhaoeAKnWKQBIggUoyagD3t5fKeXJj210tEr0mtdzqsaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(82310400011)(451199024)(64100799003)(1800799009)(186009)(40470700004)(36840700001)(46966006)(336012)(2616005)(26005)(1076003)(426003)(16526019)(8936002)(6666004)(478600001)(66574015)(8676002)(47076005)(36860700001)(83380400001)(4326008)(2906002)(110136005)(54906003)(5660300002)(70206006)(70586007)(44832011)(6636002)(316002)(41300700001)(81166007)(36756003)(40480700001)(86362001)(40460700003)(82740400003)(356005)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 14:59:51.0989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 902cf2c4-160a-44c7-cdbe-08dbc8d86388
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c:274: warning: Function parameter or member 'gart_placement' not described in 'amdgpu_gmc_gart_location'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 60c81c3d29d5..8864bdc63dba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -264,6 +264,7 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
  *
  * @adev: amdgpu device structure holding all necessary information
  * @mc: memory controller structure holding memory information
+ * @gart_placement: GART placement region in VRAM
  *
  * Function will place try to place GART before or after VRAM.
  * If GART size is bigger than space left then we ajust GART size.
-- 
2.34.1


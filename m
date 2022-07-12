Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1883FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 16:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8C1A112E99;
	Tue, 12 Jul 2022 16:28:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78BF790B3D
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 16:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdteG+wjaasCNKFdnjngAOckX0fncZcCa99l51hiQGT1OSlkjn3wdmlxqIVjWVn4mDwK86funokxcEw5YVxUhl92wEKMZLd7V3A2mUZrXMQiBfV4lIaDNmT+GBm937M1QVieOnt+czXiSPPnV3nZoBnb5cnsBlq6iRxm2uTRYf0j+/RwIvMgMcC0owUElU4KrFYKrYl2Je/34+8qmKlPW4xMt5DE9BypPwRowyy9Piz0EXblMmkbY69p5PutYtGzcOAhiDh27Z71NqqcXDXeKw5A+usLGlTyvD9uOxJM7aQ0KKXjHaj4GqhJhfDb9WnC3Vv0sv37ewcV7E6Yxr28bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWq7H0odm6y1/GG7782Nkutk4J46p5xxi25dZtmq9Ss=;
 b=hX2WVmlYkFegeL9Ulwbkhlrrfcj4DStv7bU011a6zi/nMmFWIkk7slqueaGyuxe5CbJrhZVwC1pBCeiaB9jlUJUvHQ4zzw+E2AHl1Zf5mFj82gi2MTbFdWMlCdiIKnM6jNRY2B8lc6CbG3ve/JnRgVYOXFXvmrIqaW5dMVb6fqErF/qU87vbLJLCDDulCduYrU5jXabkhFtmR4CcExnNpiN10Nfk0tSI1JQkQaqHK9CqLkw2MOO8wlcA43c8ltNpqeY9xAYgwoMD786Sx2/bkQrvIgyOIWJgevki2ganG/sf9TF8w/ian4D1ANomjBhQta2vxMVML1ZmwG9KcW1/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWq7H0odm6y1/GG7782Nkutk4J46p5xxi25dZtmq9Ss=;
 b=bnWxdTTFRWVxLFlY1E7vFKAQfLc1woxzVToSfxgtWuNX6uTfoo/HAzDmayDRspiudc6ybDRsFj1ZcwxlnV8YQex1XSNDiKDcxiiXxIGBlV0q9JTVifpZQltK7RE3JIClaAtp3Z1ZU20rFkaXMUfbUo26+wGbFaf3f3J3E6927mE=
Received: from BN9PR03CA0139.namprd03.prod.outlook.com (2603:10b6:408:fe::24)
 by BN9PR12MB5322.namprd12.prod.outlook.com (2603:10b6:408:103::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 16:28:01 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::ce) by BN9PR03CA0139.outlook.office365.com
 (2603:10b6:408:fe::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Tue, 12 Jul 2022 16:28:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 16:28:01 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 11:28:01 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 09:28:00 -0700
Received: from manjarobook.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 12 Jul 2022 11:28:00 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Check BO's requested pinning domains against
 its preferred_domains
Date: Tue, 12 Jul 2022 12:30:29 -0400
Message-ID: <20220712163029.43581-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220711224443.1157747-1-sunpeng.li@amd.com>
References: <20220711224443.1157747-1-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18ea7e46-9006-4fe5-60e0-08da64237d37
X-MS-TrafficTypeDiagnostic: BN9PR12MB5322:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BCfaHC+w+/fGd2UMDvMHnLzl3VXSMxWKORCkV30pSOuKSqsN3EUJhIbURc0utSqxYoiU1vQ37z9187W6r776LlsGVe42iL7K/Eo+0XR44Xe0ZkhVs6Bl2Ee9kusVFlYhMiKqrwxYYcNKUEOJQdvgacyzO6H0zVqQ9nea50F2GOBP/CSckvH59H0fR8j1fdOdEYWmL6kl3bLRS50E2WIT3Zxzd0d0e9CBP3hUwFFpu3XHgZIXJZsExtb8AtBbV42UD4Y8UIis06LuEWM6Dv6PyDqVclZ/ennMKgRy35RVoB4mmZFF0/L7FFZvybsjNKdEW+M3p1Lbb/YoEx6YxgR2p/z44CaJ2rEkDwruukvF6lPgR+dWfrMeAp1P6WpYNULBzXmHsE0kPZriL6NcoGpnEZYceZW+dYL3dVaSThkkUkEY9gwrxec3INBswQT6FTK/h50c9jrePJxRIeQqdBUAoLnoUNTgKtc84vxGKipAHeSgAQUT49EQqf+CY97hgs/KT38dpXFs+2CEQalidcrE+2ErfGZqIJACCFT7xdoUYB//6yBFV9VgCW7Hd7P6Wq8slRFtaJYGOHftf7NUdZWAP01DX6gdzcYAVh6R1P5udF8A/OvQGFlUbb0+v2hHkkx9dxto7A+JQu9dQP5Eg+a+BXBtda3qQlfHaAi6LsqOsPxlTq0LQ2XlGZ++TSc10ITebBKhzxdonsZLFG1/ctLEU7a51lBqPl4hDycWIykJWlfpLugo8uQa9jp/iKcCv5IoSZhxXPeiHtw+c57b5M5A5o8LjTbzk/WHxU9YTenxTlhPMnu3ygf9dux4GHVB1npekqtfIg6l0bGMMsvQxIvT9sJ/DmH9uFOxDohrxx8Vmuw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(136003)(36840700001)(46966006)(40470700004)(41300700001)(316002)(2906002)(6916009)(6666004)(54906003)(70206006)(4326008)(2876002)(478600001)(1076003)(7696005)(82310400005)(40480700001)(5660300002)(8676002)(8936002)(70586007)(426003)(40460700003)(36860700001)(86362001)(82740400003)(26005)(356005)(36756003)(81166007)(47076005)(186003)(2616005)(336012)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 16:28:01.3135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ea7e46-9006-4fe5-60e0-08da64237d37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5322
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
Cc: Leo Li <sunpeng.li@amd.com>, Leo.Liu@amd.com, Marek.Olsak@amd.com,
 Alexander.Deucher@amd.com, Harry.Wentland@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Li <sunpeng.li@amd.com>

When pinning a buffer, we should check to see if there are any
additional restrictions imposed by bo->preferred_domains. This will
prevent the BO from being moved to an invalid domain when pinning.

For example, this can happen if the user requests to create a BO in GTT
domain for display scanout. amdgpu_dm will allow pinning to either VRAM
or GTT domains, since DCN can scanout from either or. However, in
amdgpu_bo_pin_restricted(), pinning to VRAM is preferred if there is
adequate carveout. This can lead to pinning to VRAM despite the user
requesting GTT placement for the BO.

v2: Allow the kernel to override the domain, which can happen when
    exporting a BO to a V4L camera (for example).

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 8a7b0f6162da..bbd3b8b14cfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -883,6 +883,10 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 	if (WARN_ON_ONCE(min_offset > max_offset))
 		return -EINVAL;
 
+	/* Check domain to be pinned to against preferred domains */
+	if (bo->preferred_domains & domain)
+		domain = bo->preferred_domains & domain;
+
 	/* A shared bo cannot be migrated to VRAM */
 	if (bo->tbo.base.import_attach) {
 		if (domain & AMDGPU_GEM_DOMAIN_GTT)
-- 
2.37.0


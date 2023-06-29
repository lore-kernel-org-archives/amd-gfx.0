Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0CBEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 04:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E956F10E021;
	Thu, 29 Jun 2023 04:42:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2080510E021
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 04:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FC1PzaMj9D99+VGOyNIL7qj2/rq8yPOZJgcp3xH+9lwJbFjkK3A3WLmPNqapv3qk6ndDkkTjicEsrtGffDvpmVrEc6BHoOnn7fiEJxAMJiUm/uPORfwWdkcFSqgu1wcllxvbcf0Uv8yKyLJKzQp48hXQFifm8NsGtEGU7Qfotpn9qT45ybA2M5rEg1bSV5HayxaxtdsaZnBA/uuvwMek2rhM9JPZwfXmpmzdb/ULWlTWTRyCPK51JxBKeLxlGlISR3uykM7c3O6KWSX8yWtNILbSDbiT2ghEP4akJ7ECVRqUr55BeTOxqpjcjJIQ9se7tJgeauXYmZhxiukR0e8HGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkxaDT1KfcQQ5o2I9inqHs3Yx57LxvD48IxFc8ixobY=;
 b=oLwvfy3fA/uGtsjYjrG5QZXR0zB7JY5nfBT6bIz43mhVXx5WpdroZH7PSv63iRPh8B82qgk7F9ZTA1shKvBawNrc2T5Kw7oJxStXu6gwF5NboarMdiSEhckVF5cy9H0s0zcr5E6Wk/075vJjFL0e6SOsOoSVqwtJIgsi3wOFJhTuWOTZ1DJ6+3oF6ZYRqLLqlKw+19N/Y4lbWt3NQDGBspa+SJ+T43m5n+FkgoMVSLmyUX24wXpiEPHO1q/R97Dlo9xJHDFVdvJ0DRH9dfToIh7PRcUmFXBTpRLhWxEbnNCraJ4qiMh2lwMGLZMP79dEVofzkkUKWjYDKlgCkxfTxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkxaDT1KfcQQ5o2I9inqHs3Yx57LxvD48IxFc8ixobY=;
 b=RbasQAQs/SsFZF0VecS1Wp8wwHIR23K4OOxPMAriQecWjp97zaEX3cTuceUorDkSmMeBLE+X/bCL80woADRZEb71H03TR6OkFR8WyrAOR5+tIp3Y1pG6lknDSfz8F9pMGeS1n8qj0LkQRCcpPJpPQ0sMJUPud1p5Dw7lpy9lKtY=
Received: from BN9PR03CA0293.namprd03.prod.outlook.com (2603:10b6:408:f5::28)
 by SJ0PR12MB5453.namprd12.prod.outlook.com (2603:10b6:a03:37f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 04:42:34 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::e5) by BN9PR03CA0293.outlook.office365.com
 (2603:10b6:408:f5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.20 via Frontend
 Transport; Thu, 29 Jun 2023 04:42:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Thu, 29 Jun 2023 04:42:33 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 23:42:31 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 1/6] drm/amd/display: Remove unnecessary casts in
 amdgpu_dm_helpers.c
Date: Thu, 29 Jun 2023 10:12:03 +0530
Message-ID: <20230629044208.2266584-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230629044208.2266584-1-srinivasan.shanmugam@amd.com>
References: <20230629044208.2266584-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT067:EE_|SJ0PR12MB5453:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fda41a5-3df9-4da5-a6ae-08db785b4142
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwyw6zg4glhcZnRVb0EUigPBD9b/FCAxIApUo2vaOvjMYGgYgzyYWyGsIpTEj++32yVbbuEri7QmBB/5C84CIpRr2gWTGkD5XDJpDv1gcqVeR5zGiaOZGBVQ3aK7eM5rhK3GQdeJO+3EqOoVzcBMzZSncqFySQpE5Eh38UAs/gRYOAYhblCa317kLTmo8gnIQOjnU152OZzpiYKdP/+Pf/E0oVVjfdvgbPrAvCWrwxTg85AGLrctAvC7iSAwYmuSBL3ukv9wBUPhz/xytoWSDXMoxhjcfn+BZiDflpeIZc4TQUddI9f5P+HF7+4Zlzq+F8ENYAJGmswAsF6GZfsfGb2joq/0/QGbEHVap2506F2wZW90z4UgdqXBqfCBzpYWWyL0XS1VvqisAV2jmDEcNkbo3GLme48hn90GW2r/tvJlZymvX2zGXJOpL5E5klx3lJYDzDUfwtkBDPm8R6ilCK+XlHnaR86MM2GXEynOxoPeEQs9XVVovy0JwnNogCS9PEBB9WfQsYhxLpmbQaW7BLCbYZtWw0y/W06rc1VnbaFd09YRpMnJmP3QxboBs5nEDNPOw8/9tfEOj6Js61fAbJvuT/QTZm7eCy76/fdbZKO6OSJZxRKsFoqbOjGyTWdPW243a0PEjfpm1qVnvk3IZauVDmbh7Jl4lckYswLTMAg/RPMBhkGozrKqvrxUsLoTluwXbIRsyTJaTny0ovp5LbznRsKCqD4aP2QChuO4KUsj90LPr9PQJp9a6rPd+zEv4cqd1uVSJBmBlVii0+U6O07dCdoVjCtK/fANfnUL1ayibixNOl6iLGWGIg5CCHra
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(1076003)(44832011)(6636002)(4326008)(316002)(70586007)(478600001)(70206006)(8936002)(36756003)(8676002)(5660300002)(2906002)(40460700003)(26005)(110136005)(54906003)(86362001)(966005)(36860700001)(40480700001)(41300700001)(19273905006)(6666004)(7696005)(82310400005)(16526019)(66574015)(426003)(47076005)(336012)(2616005)(186003)(81166007)(83380400001)(356005)(82740400003)(562404015)(36900700001)(563064011);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 04:42:33.4832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fda41a5-3df9-4da5-a6ae-08db785b4142
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5453
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
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following category of checkpatch complaints:

WARNING: unnecessary cast may hide bugs, see http://c-faq.com/malloc/mallocnocast.html
+               char *buf = (char *)kvcalloc(total, sizeof(char), GFP_KERNEL);

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index d9a482908380..c13b70629be6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -426,7 +426,7 @@ void dm_dtn_log_append_v(struct dc_context *ctx,
 	total = log_ctx->pos + n + 1;
 
 	if (total > log_ctx->size) {
-		char *buf = (char *)kvcalloc(total, sizeof(char), GFP_KERNEL);
+		char *buf = kvcalloc(total, sizeof(char), GFP_KERNEL);
 
 		if (buf) {
 			memcpy(buf, log_ctx->buf, log_ctx->pos);
-- 
2.25.1


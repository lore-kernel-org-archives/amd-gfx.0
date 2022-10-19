Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A59C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Oct 2022 08:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A60F410F189;
	Wed, 19 Oct 2022 08:12:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB84710F181
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Oct 2022 08:12:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fX/9i2TicLQ+U8Bpg5op/qv1jbBiZDTb7Soj7yJ33c7I0IY+aCuerNF8TekfH+gUbTvGfNjJTRBOwGseXRca8uA5RdAm+nDv/W7egybmyD/qhTj3gM/El4qvH2iwEctzlnjg3dQSM6j2XNj0oaqApak8alHLwUzhvrD0VKD5Lah11qNQX6ogcFozBk71r4ZM9yu41zOUVn83zKe9obER/ahmqOfTfC+803AWqpgaH0x7vnluZSyQiQPhOse8WsGnT70XO4i7ALCZi0lacKxsHZ2kIVvAP9Lpu0PI9dkldWdj95i01OLlVlGwWiEjpmRze4Pk53/Kf8J4YcUWfi024Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxWbwTetc9xNPdvcCK9ySXJK4tIgzAMhdSQdfINvNFY=;
 b=IOoOQzTUUayym4yRci6OmqKNqhcqPGkUwSRkKD0dJ6YGtbjMB4Eki3aV6nrMq2xJ8VdH1QNDQ+m3ag2mSSLEv5vhUEHR7Q+MOVxy5g5jkH02NpLJScPeMbyQ6ZbTqANwetGson8ThX8k1SEIUxoR6lKTacYNWQYq7LkTx0fsXa7Dsm1Ptm4vc/73qmYE5sX6ATvlsxry8TUD+G58/9USyuJcwpuwc3oxOnSeurNWsOzWMdn+Ke18b5sLlasc8mPvlTDGvq9n8UIwzW7UpWnTJlpTMDgBRk/kyZjF1GaaVz42DK9sA/WE37zELvlu7eakAkmNemNrh+Lob7pG2Y51Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxWbwTetc9xNPdvcCK9ySXJK4tIgzAMhdSQdfINvNFY=;
 b=e2sEgPxelWoesjqGA1HDJopibeYPXr1KJZx33PjuPKlYS57oGO4T2WNmxIk0ALto+sZRBpWCnM+jATQniHY62HuOnXpiJT4Izy66d85dvUBTUUgNZW76H02wVUerLT9vpE7mukR+VE2+2ZjAURDR+yazXn8z2BlqkGsQ7oxJPJw=
Received: from DM6PR07CA0041.namprd07.prod.outlook.com (2603:10b6:5:74::18) by
 SN7PR12MB7249.namprd12.prod.outlook.com (2603:10b6:806:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Wed, 19 Oct
 2022 08:12:33 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::16) by DM6PR07CA0041.outlook.office365.com
 (2603:10b6:5:74::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Wed, 19 Oct 2022 08:12:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Wed, 19 Oct 2022 08:12:33 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 19 Oct
 2022 03:12:31 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <YiPeng.Chai@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: add RAS poison handling for MCA
Date: Wed, 19 Oct 2022 16:11:49 +0800
Message-ID: <20221019081150.31773-3-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221019081150.31773-1-tao.zhou1@amd.com>
References: <20221019081150.31773-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT021:EE_|SN7PR12MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: 22aa7764-36ce-484a-1b9a-08dab1a9ad0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ai1MGuG0VLfrR+a3YMizEx6yOblvXnF2OuBiKd1DFbEBdrqKblpHUfpq88KHYS9sqqB91jvNINlGwgPpRh9OdKyZOfY/bAZIOx/gCDrkwVypAk16J2cPoPrUwWl5GKaONOlRemqxMkOZdjj7mvhXnYNGmtvvfycVcssg0EgOqhH0ynzc3BCq3DaKejT0MiksQ0jtL541T55z9qFvReIxQ7j6iD9p9fFcoAGHccnp+HlBnS+hqD6d6aCXBkyo/dU8FWeP8HaRVf+vCjBxOSyP1kL+UxgyaOyOxtEC0yUwl9ooly0UUQP2KhCLV4C42m/Hb8DyII495p9XAA2ogr1aYNfuLUYUlRA9/FQDJxK/SB+hm+dMZyGEZ5nLUl4DR4lAPid1svRibl6Pp3qm8QaRE0nW9nZz4dPpgonpv/hXwRIq1NA99hP0Jn3n693Zz/O2u3A3baO1bHS9EjzKygvOB0Wel2IicwB/kJpvsbiSCCyOtCk1SVcF32A76v9xEdjA1s7Sy+7eqtGKbnCxMgIgOju8Yxl2QnH/nXDk4035P0ivN/zWYc0wgry68bLhek9a+FHopqoHzA4lyj9FHtP2PY2qM8H1fJxshtJUdPdxv7uDEmnZ7K0jXjmcb6Yqxyh817HsQTW2nlloMNHSmB/rxSYj+SWpJyG8tbLHLZLecfrruDdwrYyFZVpsgB+Lx/weUzozmvWPycM9YRAwoa2CYp60yqohKdQPSqeq7oC8OcUu/vfhfHnAwVdhQlut7kblw8K0YXduBCsq5UlnW3A2znz9ZZeM1Nb2RQ1PH+opN1nc21Z4r7WUhmYkHrL2didm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(316002)(426003)(186003)(47076005)(2906002)(336012)(83380400001)(1076003)(82310400005)(82740400003)(40460700003)(16526019)(356005)(36756003)(86362001)(40480700001)(36860700001)(81166007)(478600001)(110136005)(6636002)(2616005)(41300700001)(7696005)(5660300002)(8936002)(70586007)(26005)(4326008)(70206006)(8676002)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 08:12:33.6381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22aa7764-36ce-484a-1b9a-08dab1a9ad0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7249
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For MCA poison, if unmap queue fails, only gpu reset should be
triggered without page retirement handling, MCA notifier will do it.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 27 +++++++++++++++----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 9494fa14db9a..dd1b1a612343 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -184,18 +184,23 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
 		bool reset)
 {
 	int ret;
-	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
-	struct ras_common_if head = {
-		.block = AMDGPU_RAS_BLOCK__UMC,
-	};
-	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
 
-	ret =
-		amdgpu_umc_do_page_retirement(adev, ras_error_status, NULL, reset);
-
-	if (ret == AMDGPU_RAS_SUCCESS && obj) {
-		obj->err_data.ue_count += err_data->ue_count;
-		obj->err_data.ce_count += err_data->ce_count;
+	if (adev->gmc.xgmi.connected_to_cpu) {
+		ret = amdgpu_umc_poison_handler_mca(adev, ras_error_status, reset);
+	} else {
+		struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
+		struct ras_common_if head = {
+			.block = AMDGPU_RAS_BLOCK__UMC,
+		};
+		struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
+
+		ret =
+			amdgpu_umc_do_page_retirement(adev, ras_error_status, NULL, reset);
+
+		if (ret == AMDGPU_RAS_SUCCESS && obj) {
+			obj->err_data.ue_count += err_data->ue_count;
+			obj->err_data.ce_count += err_data->ce_count;
+		}
 	}
 
 	return ret;
-- 
2.35.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCE5C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 15:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AEB8950B3;
	Tue, 12 Jul 2022 15:41:09 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C68BB95099
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 15:41:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hieo2cJ9CymB2d+GHtYVxhC4kiaYq0kLU4nd1tP3dIKsMZjsIxFzOCzp05QyEmjohj4zPXkwlslysuQLIpQZm4J8juGlIn4QRAkBJbuVxPqb85flhWN6Yk43MlLChRioJ01urq+VuiC6/4IYFfxlQRmdBhWUocYRTg+Nlw+1sd5z3gHUAWmXSyoSE80fLTuTVxEtKZh8T+5qVugbNHUSt13MF8Ab3pWvECYZDJdFQ1cx5JzZgOM2pwXMrqXeZD4lv41yU4aT4CqeK9OAtxDe39T9vLL/Jl8I3d4CO9WuL0J2dJOHDaurkxUCd1LAwYkuigkI1WI6yNQKMshFcOYBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95jT5f11CJ7EY2hE8gkpEoCObE+fen04cE4Lhlv4hGU=;
 b=KQ8hu0+3CFT1gqxEFZ02F+EnPAqpbPedNTLkcqfWc10U40AjwUofLZKcb3/myu1MShVehHBSsyIPvYMMdjEPMk7ZG6R2aGcBszvz0OhGmplGVWup0m5spyEXhU4A0b0mf3Ju2S3mpblfCDH6omOGwa+7j03nop0e+jNCeW04bARNduDJl67s1lDsB/G4Py3/zI+PODrr9iGwGDdRdRCZ7JAiyTRc7+b8+UkeZEXhYeEcCSWn/xwi16GzITnYdzOGARcwNto5U9TgrAsdd8man9u5gqKHKpuO3BTxuBoTj263CxZRc9llLjU60mGadEhUOaLZXosxzJHxkLj8z/OJ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95jT5f11CJ7EY2hE8gkpEoCObE+fen04cE4Lhlv4hGU=;
 b=dERh6IYrV6qyEJHptQXX5HLVInwJSqxvA6TMaGTvxjdrfVv4IO8md3HFn827Y9jah4tt4a+xKJ6O63tAMoipyZZ8mh5pUYOG+rnuJSROyXXd1k4fGXybxCjwVqvljVL6KddEA8VCgm6sth6OuxKS+r3NscEpUYXqjickxHb3Tc8=
Received: from BN0PR03CA0049.namprd03.prod.outlook.com (2603:10b6:408:e7::24)
 by BN9PR12MB5292.namprd12.prod.outlook.com (2603:10b6:408:105::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 15:41:06 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::6a) by BN0PR03CA0049.outlook.office365.com
 (2603:10b6:408:e7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19 via Frontend
 Transport; Tue, 12 Jul 2022 15:41:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 15:41:06 +0000
Received: from ryzen32.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 10:41:02 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/21] drm/amd/display: Add NBIO reg offsets to DC
Date: Tue, 12 Jul 2022 23:40:46 +0800
Message-ID: <20220712154046.501508-1-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708163529.3534276-1-solomon.chiu@amd.com>
References: <20220708163529.3534276-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a484f280-db80-44d0-c8ee-08da641cef95
X-MS-TrafficTypeDiagnostic: BN9PR12MB5292:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUJhTZFWz83J5U8LQ2djhc0lHPzV10cPH3KzSeB4TFkGsRYCtsj/3EJa85Hlt5ndBsOWnealC0VUj1XV7F/doKcUFMtJI5V6bQDdG+t5vJTVjmZLOn2Qx/CK2tmjEBN5xBGGKc2xm0Trd3CVkLcwnEsVVk+1xG5Tbb2DeDiDPHMR4ZU0EgTw0BUZu1YClJ1ckO4zgO6YbIBRYNcCKUf8K+1j0/kwGnolW+S1eMS1iEsmMdA8XeLtWSABRQT9Uchhak6VoZ84/df7VgSu3kWbkVUUMCnCuEkbcnp+ZPTjyMVJuftLpiZ4CVGlch4cQefUR9SLan94jcGr7+702fVZW1kSAXCRwHOLP10z61ATxgYdRViIY5tbtQ+VGsoJNNo6d2nbuhnJ+jtkR+wTcVpOzKL/FFiYFlRedKooJmufCLI7AZ+3MGkPj0FmHkROWWXlbLS3ocq9B29usReUAgGR51v8tenk4JAsY4pzOt4P7naQhGBvxZZq3uqXXpQ24uVhzKqC7BsXWOzxQPNG1AOonJiOYjWqnNUuD+B1YctZFpAure96LttTByo0Ewow9OfqQehPS0gbjM/iw4BckpTXH8l2rTXUC1Yi8ihlWg/kg72zlr0Pa1YVNcRuKywFnS1OGkhO9+8BYSwojzNMvyUIUciEC9PkKkSZEk24nviFnqBsSWxPVIuic5Zt3fIOQkZMdfnuT+n4+kPXLPj+D4OGNoT1KoZbFmV72qxqW+DFhiL8e05SGWLaFTDYxKnjH5QWHgUI11IZf8JyZ5Qkf3KyOba8Ai+r3t8VEiaf+VH5r1QyAqF89IjA1KOIUUDOL0xwRV2orqHbM2ta8yA8Ai5hYIk7Om2I46GTJszwD9fCpPE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966006)(40470700004)(36840700001)(82310400005)(7696005)(6916009)(81166007)(6666004)(40460700003)(2616005)(82740400003)(2906002)(36860700001)(1076003)(356005)(54906003)(41300700001)(316002)(26005)(44832011)(186003)(478600001)(4326008)(336012)(70206006)(8676002)(70586007)(16526019)(426003)(5660300002)(86362001)(47076005)(36756003)(8936002)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 15:41:06.7154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a484f280-db80-44d0-c8ee-08da641cef95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5292
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
Add a field to store the NBIO IP offset for use with runtime offset
calculation

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c          | 2 ++
 drivers/gpu/drm/amd/display/dc/dc.h               | 2 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h         | 1 +
 4 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 78ba2762fe9d..476fe60f4b7d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1528,6 +1528,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	init_data.flags.enable_mipi_converter_optimization = true;
 
 	init_data.dcn_reg_offsets = adev->reg_offset[DCE_HWIP][0];
+	init_data.nbio_reg_offsets = adev->reg_offset[NBIO_HWIP][0];
 
 	INIT_LIST_HEAD(&adev->dm.da_list);
 	/* Display Core create. */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 6039b3487d4f..7453ec54420b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -863,6 +863,7 @@ static bool dc_construct_ctx(struct dc *dc,
 	dc_ctx->dc_stream_id_count = 0;
 	dc_ctx->dce_environment = init_params->dce_environment;
 	dc_ctx->dcn_reg_offsets = init_params->dcn_reg_offsets;
+	dc_ctx->nbio_reg_offsets = init_params->nbio_reg_offsets;
 
 	/* Create logger */
 
@@ -1243,6 +1244,7 @@ struct dc *dc_create(const struct dc_init_data *init_params)
 	}
 
 	dc->dcn_reg_offsets = init_params->dcn_reg_offsets;
+	dc->nbio_reg_offsets = init_params->nbio_reg_offsets;
 
 	/* Populate versioning information */
 	dc->versions.dc_ver = DC_VER;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index faa22580852b..89a3cc8f9274 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -810,6 +810,7 @@ struct dc {
 	struct vm_helper *vm_helper;
 
 	uint32_t *dcn_reg_offsets;
+	uint32_t *nbio_reg_offsets;
 };
 
 enum frame_buffer_mode {
@@ -857,6 +858,7 @@ struct dc_init_data {
 	 * before them.
 	 */
 	uint32_t *dcn_reg_offsets;
+	uint32_t *nbio_reg_offsets;
 };
 
 struct dc_callback_init {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 077a93e81561..ad9041472cca 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -877,6 +877,7 @@ struct dc_context {
 	struct cp_psp cp_psp;
 #endif
 	uint32_t *dcn_reg_offsets;
+	uint32_t *nbio_reg_offsets;
 };
 
 /* DSC DPCD capabilities */
-- 
2.25.1


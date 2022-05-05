Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFF5C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 14:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 817BD10E3B9;
	Thu,  5 May 2022 14:24:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C908110E3B2
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 14:24:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLWVbhpMvOxV7GwhQD2crYYxXaIrGBxuj27ges6DBCPGCwupp2G/YBwaTKOcZFXpmQRf2OzTNiOGzsLd9aBYquEyLLz4UNXhNkl0C3nOx8vFGERtM+ODrYaOsZAltQ+7O5eez+WF0URMqgDARszn0ccXI5OlGVKrbB4PI7zA2EhCQkC4nFXdUtmCjtdFTmxpjqt4/mdK4agZ6BGeVLTzlmutEqjiVcTsT0/82ZHDXYIxj4AGlwVF3I+RtJIFUBUUEJgU57CPkofAYOrnCymEq5quKIqiQJcNu9j+1J4se/VtR+pOBHVTeY6jePgqi+dBvnfPbSKwjh3yjVmZFg2aIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZejXsTyILsw2uFNg4uHiL390OqUDZf6lhS3eQQMVivE=;
 b=BD9E1QYv4KKeoskfRkObQifTqNqQxmeJRxVpaf/dlEIq12BwkdFF8BxCVw/t60Df8Zyz5o8uCm33pNeuiBGhAADJOyVzQcuZrT3c6b61iOl8Pe0mrohwBJ1BC1I7bgRd1zLBIE8mkGZgrm28RegXCBrlpTtJuK/I55fiRxH+LHadh4x75ZoFtdP1SHXDxCzRZzPHzhWygntoooWGkzslQ3CAkP7e1ANAAo/aL5fN66V2kCMZ/YjaxS9SerEo5cxfXIfQnoxzshxXUP6StRU9O9K2SAsxsOmZdk1TserfWZRv4GIGh67Iwa8Qs2yN2El+LmKPwVKBqpU//n6nTdZ0LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZejXsTyILsw2uFNg4uHiL390OqUDZf6lhS3eQQMVivE=;
 b=MCd75Hyf3hLXFCG+geUqfr3g2Rq4wGq17c1kWXKb3F+RP95hQNq4bZ4Ia3L5PpqZMoQ/chT899DebTmyz3YxHGh6mFC7r2fy+lEl/R76JX4x7JfAfD2tO+AXZny/HKFmnh2HpmJx3VgZhh59zOYTcgxnmb+VYoiPoJA7pJq6ODE=
Received: from DS7PR06CA0049.namprd06.prod.outlook.com (2603:10b6:8:54::35) by
 DM6PR12MB3178.namprd12.prod.outlook.com (2603:10b6:5:18d::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.27; Thu, 5 May 2022 14:24:05 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::96) by DS7PR06CA0049.outlook.office365.com
 (2603:10b6:8:54::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 5 May 2022 14:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 14:24:05 +0000
Received: from Gundam.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 09:24:03 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/17] drm/amd/display: calculate psr config settings in
 runtime in DM
Date: Thu, 5 May 2022 10:23:21 -0400
Message-ID: <20220505142323.2566949-16-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505142323.2566949-1-dingchen.zhang@amd.com>
References: <20220505142323.2566949-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b224bd4-ed49-41fb-d8c3-08da2ea2e8e8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3178:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB317853994EB19B5482743EF08DC29@DM6PR12MB3178.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HprcCy7lwwCpOwVVUNEbhjkisfaux6Xw1n8qzpo8xH0yRBvWd8SlR+f3spItZxY9+imJRVdL1pK4D8MC64HzJsplwKjTOlQJ8AKNPXcm1ORDWdK1xgZjuKRZuBQQ/sngY5MHs11f59N5h7pCHMMWk8MuYEjKED/xOCpOyHloI+VpVT433kcmQWD06nUv34Qsdcuo2u/iFAlmTkPsi7mKLhPBZqW6TBQbzkFuhshpdYXcEkuSQcoK8S1yNfaMrf0VJK/1ZyQVDEDD5MWpWfI3uLATHUShijgZ23egUufBCDzWl9RllAz+1XrgEhp6LAx/lpawHE84pe5UGvE8KbX6q+yXZIMVHdZth5Q/0CvFvckE3ruC65UhsyHXdvpL9Mg61IPa/7mBd+YP4bJrsANqeker6BP74Yoo6DHRYu7S57PKaPXM40bUogPW/9qPgKHsKrwYAEbIzRaalhkVsVYT88NQkyTqEO9sr0MjYGrN473d+mJ2yNNvVTrWbsmFfkhhpZK/hRZqZj6crMnOIuGuQwLsGUsI2DD6vTjCA9ovkby8KNKTxDRjASK3CgeIEnMyyZAFEvH9oTB7Q31Spz8WG7G1mYIgbgv5gQmP5pVP7Ue4RO0bE8ufPQrXQwaQnEFVML0Zk4lA9rgfbDavVetPFE/DzWstYndwNOniyo1z3TQANW4ctWC/7qY2V4AAGkZH7N1FjihAnWFvTsfxgle5iQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8936002)(4326008)(81166007)(356005)(70586007)(86362001)(70206006)(2906002)(5660300002)(54906003)(26005)(6916009)(508600001)(336012)(316002)(186003)(426003)(6666004)(7696005)(2616005)(36860700001)(1076003)(16526019)(47076005)(40460700003)(82310400005)(83380400001)(36756003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 14:24:05.2562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b224bd4-ed49-41fb-d8c3-08da2ea2e8e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3178
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
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
Currently the psr configuration parameters are hardcoded before
feeding into the DC helper before passing to DMUB FW. We'd rework
to call a shared helper to calculate/update generic psr config
fields which are relying on the stream timing and eDP sink PSR
caps to avoid hard-coding.

[how]
- drop part of hard-coded psr config fields by replacing w/ the
  call of helper from DM before feeding into DC link setup psr
  helper
- For those DM specific psr config fields, e.g. allow smu opt, is
  not to be set/updated from the shared helper but to rely on the
  DC feature mask
- for the psr version field in psr_config structure, since only
  the field psr_version of DC link psr_settings matters for that
  fed to DMUB FW, thus no need to set/update the psr_version field
  of psr_config structure.

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 13b1751e69bf..ab8fa42156af 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -101,19 +101,24 @@ bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream)
 	struct dc_link *link = NULL;
 	struct psr_config psr_config = {0};
 	struct psr_context psr_context = {0};
+	struct dc *dc = NULL;
 	bool ret = false;
 
 	if (stream == NULL)
 		return false;
 
 	link = stream->link;
+	dc = link->ctx->dc;
 
 	if (link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED) {
-		psr_config.psr_version = link->psr_settings.psr_version;
-		psr_config.psr_frame_capture_indication_req = 0;
-		psr_config.psr_rfb_setup_time = 0x37;
-		psr_config.psr_sdp_transmit_line_num_deadline = 0x20;
-		psr_config.allow_smu_optimizations = 0x0;
+		mod_power_calc_psr_configs(&psr_config, link, stream);
+
+		/* linux DM specific updating for psr config fields */
+		psr_config.allow_smu_optimizations =
+			(amdgpu_dc_feature_mask & DC_PSR_ALLOW_SMU_OPT) &&
+			mod_power_only_edp(dc->current_state, stream);
+		psr_config.allow_multi_disp_optimizations =
+			(amdgpu_dc_feature_mask & DC_PSR_ALLOW_MULTI_DISP_OPT);
 
 		ret = dc_link_setup_psr(link, stream, &psr_config, &psr_context);
 
-- 
2.25.1


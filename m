Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D270C606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1GHuTLzx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D18510E6FF;
	Mon, 23 Nov 2026 01:45:32 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35D3110E6FF
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 01:45:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZKttWyAUNB1SeQsAbK361ocke1KLtlLWawcxMumhJ8qx8D/ZmJoRKEsWCzyMCrFeRJFsX6GlYkj9zoXNpsNVrLOIrs6xrLFMiBn3bjW0eUD15OD/kLvPbGMoTVxdhn5q8w2qE0GkodEUc6qfaS60nIeLS8jKr8nghRn5X3kSYi86keCRfzyZ1Xgr5mY5MV6m0prGdakcxAmhoC1/q1pMfWXRnNF76z3DsQqHAKLq0bGzxCVuRdDk2bCVB5565PDcBsBHVgCpRLBD9N+PaXHDPpdCZ4+alXFc/6mp/c3VFICw4uhk7jnEmtE6KM90fufE6iR5gJtY9w/FjAqrjEdLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUg0doCpmnb14HpavaD1fUwUiH1AnYdLDPXk0E7Trgg=;
 b=TGIZgCokjOO9bz5rxjfOo+s1TyYi+BX2870nvvVp3yBgrrEWPGAeRr7E/skfR7fQyUF/C9c5yxXywcFG8TDQjeqy/+2xBCaoeYaztdFRLW9RlnaZVfp2aLeUc4BpM1GPRS/ftKFLg++JFKV2KkbS386Yg8xNnVU2UAiSS2wyLj2NKs5GeAsnNefb9oAlu40Y4yShdYJfn9DZ/BOBTRb7Bod48H7ebacY+96ezFEOvokRjyQqPGd6HTqeCrdlbiSSRuXC+pJySIb41qKuqTZYCYF6lKgu0Jt5WTDatM6WNJZwcm3ZtwZ27tXF0d2ZylhlBw+HLgEhviYvYhEX7o2haw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUg0doCpmnb14HpavaD1fUwUiH1AnYdLDPXk0E7Trgg=;
 b=1GHuTLzxD9vv/HLnheZBqWslXphdM5gI88FZxFIdz86WaQ3L177Nkj0iIT97ayDeGXHHOZoJDQfsaezZVYauZQbAJIED41xm+Y1HPFzWFX7Hk7+igPM5bFu5ma0gn1vm0Jv26dLIkZWbY3wyNQZCXiUDpXd89YmxUipQkVtXeyk=
Received: from DM6PR01CA0014.prod.exchangelabs.com (2603:10b6:5:296::19) by
 PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 01:45:19 +0000
Received: from CY8PEPF00000055.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::88) by DM6PR01CA0014.outlook.office365.com
 (2603:10b6:5:296::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 01:45:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY8PEPF00000055.mail.protection.outlook.com (10.167.247.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 01:45:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 22 Nov
 2026 19:45:18 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sun, 22 Nov
 2026 19:45:18 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Sun, 22 Nov 2026 19:45:11 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Raghavendra Prasad Mallela <raghavendraprasad.mallela@amd.com>,
 <HemaLatha.Pinnamreddy2@amd.com>, Hemalatha Pinnamreddy
 <hemalatha.pinnamreddy2@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix aux timeout callback across engines
Date: Mon, 23 Nov 2026 09:46:14 +0800
Message-ID: <20261123014614.1181287-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111093528.2918607-1-raghavendraprasad.mallela@amd.com>
References: <20261111093528.2918607-1-raghavendraprasad.mallela@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000055:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6a8757-eb2f-4c74-9325-08df49036dff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|261026140227099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|261102123227099003|11063799006|56012099006|10067099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: mmuQVAI523xXEqZqYaICZz5RQtqsCv7AUuxDejlihJP4mADUge0IB+mC/4rR56ZalCBm/o3/Z//aUXacFPPFyca7Rp5XftFOrk6HBwSPro9ViHgrrB9ocAphJzJhjdi44bfPU41i7n7jjW8j4foK/4jNY0dRTxClS+zaHL3McJjEBLnTEHjY55eCi7Duvy1vG2Q1uLb6B7SCVsTcFmYrHRWc5DHNgRLaUpbVXefymS+GBoeHUX8pG36ioHvchZ/lzZILys5ZiJ46RF6BkLVEQHKv0txVjy2oPJXKOaTBgN6orMVryHHCz35BRdj7rZ6jHz99iqeH96exDuGE0qsN+QerRnUc5iFzkfU4iitlF18r1O0ayei7zkLvTiTyDMVdVmNizND6mI1CneCcucM3D5iEdhIYF8se4YU1Tcaixy29tRuyrSYrsWDao86lq5QScmRgMzV+Qkeswqz5DvT9I3WpUgQJ15Da9RNkJ4A4rUXFTnGhyrEy8w7mQq4Yr9Mnpjpjkf3Wp5FfHglexW50kDEuQI8HLRpQfc0qqfn++0Inmrk3+kRrW8YJ9h8z5miXaA/9m/hNFC4WgcBQA0MvV1hhVbmn43Rm5Bx0g/xEQLugrwGNtt5rtdfHlGeboOmteiFsS0c71+a6qOo+a0al7msLVQru+Jl1Hr0pqLZ4SRqoEWS3XTpWCqGd/bW7JqKrEg6nCPxSKct3G1zkwhv63g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(261026140227099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BSZrZmA75oqJTjEL041q+Lf4Lx/OFPBw+0oJZ1jRel7G55ZJhQGKG8kzPa0m2j7oQz68imE+4cJlvIkbeQ7pUQgjOLlOFRF0mBZmEnhYJTBU4V/2ft1ud0fgBJ4zlFWjd31B/dsObl8hXydOc0ju0Sj/mWZkMYVtlcTU5AoFs0pJwFk/M6OxF9ikneDVuwhkwKWohYO0/LCF05mRIWOlYEDTiocq0Iie1o82R5zThRDI5ZtSYNcMhnXmAQVWFGLrymrfDjj8WO3a37Xcz0PQVM6DndSXVpql4BVqo8xoCHt2I4fMd8GwqSavN1m1Le3U4udrlJpowTDrLz9z1fJMJki/8EXDATh7IsLcxngK5LLZsQGYfpW+75DtvDrrvA2B8wCMzS7k70rveCCYAEbZhhfGOB9LtfrxOwKE2LTPdPyWVsAgIZsdTXSZzzIT/a9m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 01:45:18.8238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6a8757-eb2f-4c74-9325-08df49036dff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF00000055.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Wayne Lin <Wayne.Lin@amd.com>

On Wed, 11 Nov 2026 15:05:28 +0530, Raghavendra Prasad Mallela wrote:
> From: Hemalatha Pinnamreddy <hemalatha.pinnamreddy2@amd.com>
>
> [Why]
> Aux engines across multiple GPUs share single static
> dce_aux_funcs. When an engine supporting configurable
> AUX timeout is initialized, it updates the shared table,
> causing unsupported engines, including DCN1, to inherit
> the configure_timeout callback. As a result, these engines
> incorrectly attempt to program the AUX_RX timeout.
>
> [How]
> Embed dce_aux_funcs in each dce_aux instance to maintain a
> separate callback table per engine. Set configure_timeout
> only for engines that support configurable AUX timeout.
>
> Signed-off-by: Hemalatha Pinnamreddy <hemalatha.pinnamreddy2@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_aux.c   | 11 ++++-------
>  drivers/gpu/drm/amd/display/dc/dce/dce_aux.h   | 18 +++++++++---------
>  .../amd/display/dc/link/protocols/link_ddc.c   |  8 ++++----
>  3 files changed, 17 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> index 4abf51c8ab52..10eac67ac784 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> @@ -602,11 +602,6 @@ static uint32_t dce_aux_configure_timeout(struct ddc_service *ddc,
>  	return prev_timeout_val;
>  }
>  
> -static struct dce_aux_funcs aux_functions = {
> -	.configure_timeout = NULL,
> -	.destroy = NULL,
> -};
> -
>  struct dce_aux *dce110_aux_engine_construct(struct aux_engine_dce110 *aux_engine110,
>  		struct dc_context *ctx,
>  		uint32_t inst,
> @@ -626,9 +621,11 @@ struct dce_aux *dce110_aux_engine_construct(struct aux_engine_dce110 *aux_engine
>  
>  	aux_engine110->mask = mask;
>  	aux_engine110->shift = shift;
> -	aux_engine110->base.funcs = &aux_functions;
> +	aux_engine110->base.funcs.configure_timeout = NULL;
> +	aux_engine110->base.funcs.destroy = NULL;
> +
>  	if (is_ext_aux_timeout_configurable)
> -		aux_engine110->base.funcs->configure_timeout = &dce_aux_configure_timeout;
> +		aux_engine110->base.funcs.configure_timeout = &dce_aux_configure_timeout;
>  
>  	return &aux_engine110->base;
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
> index b2153cb03b51..126768f098c3 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.h
> @@ -238,6 +238,14 @@ enum {	/* This is the timeout as defined in DP 1.2a,
>  	SW_AUX_TIMEOUT_PERIOD_MULTIPLIER = 6
>  };
>  
> +struct dce_aux_funcs {
> +	uint32_t (*configure_timeout)
> +		(struct ddc_service *ddc,
> +		 uint32_t timeout);
> +	void (*destroy)
> +		(struct aux_engine **ptr);
> +};
> +
>  struct dce_aux {
>  	uint32_t inst;
>  	struct ddc *ddc;
> @@ -247,7 +255,7 @@ struct dce_aux {
>  	uint32_t max_defer_write_retry;
>  
>  	bool acquire_reset;
> -	struct dce_aux_funcs *funcs;
> +	struct dce_aux_funcs funcs;
>  };
>  
>  struct dce110_aux_registers_mask {
> @@ -318,12 +326,4 @@ int dce_aux_transfer_dmub_raw(struct ddc_service *ddc,
>  bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
>  		struct aux_payload *cmd);
>  
> -struct dce_aux_funcs {
> -	uint32_t (*configure_timeout)
> -		(struct ddc_service *ddc,
> -		 uint32_t timeout);
> -	void (*destroy)
> -		(struct aux_engine **ptr);
> -};
> -
>  #endif
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
> index db798656c8a8..0a44382ccfa2 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_ddc.c
> @@ -549,13 +549,13 @@ bool try_to_configure_aux_timeout(struct ddc_service *ddc,
>  		return true;
>  
>  	if (ddc->link->force_to_use_aux) {
> -		if (ddc->ctx->dc->res_pool->engines[ddc->link->aux_hw_inst]->funcs->configure_timeout) {
> -			ddc->ctx->dc->res_pool->engines[ddc->link->aux_hw_inst]->funcs->configure_timeout(ddc, timeout);
> +		if (ddc->ctx->dc->res_pool->engines[ddc->link->aux_hw_inst]->funcs.configure_timeout) {
> +			ddc->ctx->dc->res_pool->engines[ddc->link->aux_hw_inst]->funcs.configure_timeout(ddc, timeout);
>  			result = true;
>  		}
>  	} else {
> -		if (ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs->configure_timeout) {
> -			ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs->configure_timeout(ddc, timeout);
> +		if (ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs.configure_timeout) {
> +			ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en]->funcs.configure_timeout(ddc, timeout);
>  			result = true;
>  		}
>  
> -- 
> 2.17.1
>
>

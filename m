Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74073C433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E347664E38
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 22:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E347664E38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D2086E448;
	Fri, 26 Feb 2021 22:37:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B61056E44A
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 22:37:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqqrlYQUEkCbhjeCVL5kNje9AgUCl/HgEXUzYHUpM/L/djBoyie+e0C8jbMw7flJj60GbQOiA8AOf2WrUz7LeA6asPhR6IgzwBU6muUw4dPPRx7bE0xDAvbCAiSAq6F89e20k1eMzBaT4Gcn9EuaBZbtUqd2Idufl5Nbt0X1G9Zf/lYLaXAzV9zMhSrBAD9H6xDEbLiTig7DOGUOBKfeOtSSI8KZIrbwCNbPDJpuBIHCSlN/B5myFHOJagfi0GkHahXe6Lu9HUQhSA8Hhpvoaq2HdaReglIUjPoRfYaTySCfMDydU/uk53FUQ62spLYMUnGRV7eir5h2ySjXLlAaqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vF0j/jNrth5b/X4Xqy85GO/eSsEIbxiqAFgxDwCzBbI=;
 b=AFTGCmjBEOHD3sitCO9nP0B8MqPX3sl0v7e0tRjnikSYpxJE64lOzWeb4SfCrrfeaFi6PV6JuNsOlt4g54II/RKYLrY4rM6LJkEY4JngukSXgVMr31fpK3nVm0ajsRlCATPLDo1jlKsp2RTr9bAQdTQnw+iyesOnJaBfnTzQrPwJrH9rD8iLLitdSbVb/WS5J9zrblpsZl8o72GAVrra6CcKrOVkEECdiOACwgcgd4rO1JwaPXZqpRVhyMr4FksKiX3uIE1GK3jTusENTUTlLle8a4xfw+6h6TS7r6+eEC6PPFlhg6ExiDlJ2a9XhwuqinjBKhs84a0uavRxOlRizw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vF0j/jNrth5b/X4Xqy85GO/eSsEIbxiqAFgxDwCzBbI=;
 b=oJTxMGu8HVvuHwu10A8+c7g9zSEB/aa29pmEle7+VPEj7HxiD4TWZa/g9YzqxIzDrlz3ACK7117GpUbTsD2+lXcDMg+5Ag7e/R+pGgcWQ196CnqSGzkeZo/vrZYsuLGatdKsAyBOG7nkPth8A1eMK+3+BIesKbQLBL5d+nnkrTQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM5PR12MB1883.namprd12.prod.outlook.com (2603:10b6:3:113::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Fri, 26 Feb 2021 22:37:39 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%7]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 22:37:39 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/11] drm/amd/display: Update link encoder object creation
Date: Fri, 26 Feb 2021 17:36:55 -0500
Message-Id: <20210226223704.400472-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210226223704.400472-1-Rodrigo.Siqueira@amd.com>
References: <20210226223704.400472-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:acb7:edb9:ffaa:d7cf]
X-ClientProxiedBy: BN9PR03CA0067.namprd03.prod.outlook.com
 (2603:10b6:408:fc::12) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:acb7:edb9:ffaa:d7cf)
 by BN9PR03CA0067.namprd03.prod.outlook.com (2603:10b6:408:fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend
 Transport; Fri, 26 Feb 2021 22:37:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a0209f3f-7f30-4cb7-4f35-08d8daa71f18
X-MS-TrafficTypeDiagnostic: DM5PR12MB1883:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1883EB2590FD39DEE68CC74F989D9@DM5PR12MB1883.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5tBY0u0ChMwwggFkkdhCASNXR3ORhXHHwjUp/Kv1rA+1gRlAVgtheob2tWkJz7in4hja3wqbrV8swDF8ssjG4LUlxxbQ1fXA6i6JQuIUxJlkhkNtw5ORTCtMUk2HTXjSxvIV7A8h2tUv21tNFS9wNtRZLe2nKdt9gqkmqQKnq3dX3qH30c1ekwAFRogfiRsQzWVeVpjIyy8+ICGI7UEYOiTr9PHyYWH4Sbx9TVX52JTqf2QOgXo35uYraciC+FLXeBVfMTdat/22aa4Fha0b5ka/tgDu/HntPPH1ERNFMSpv7DnF9EGeYec9i3sbU9DZC7Y4a8IRKI3rjvJApHu/TajkKzLyT87c3UA1zedvMM+Lzv9+BjKPHIGdZ8E32aF8jz0my2lasxjpSwsxqofcc1SYZhxET0qX4mKIZHIYvhtPHvg1BIwIy5fWNRZ0ocfcXIAtrNp0Jy9svp6JWazl+cbpQQNS23ku3a+/AofG2818NueXQbbwxRcvtWeR1x4+4pIqMyhu+ZU3azpHnKl+PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(2906002)(6916009)(2616005)(5660300002)(66946007)(316002)(16526019)(15650500001)(186003)(1076003)(54906003)(83380400001)(36756003)(6486002)(478600001)(66556008)(52116002)(4326008)(6506007)(66476007)(6512007)(8936002)(8676002)(6666004)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6v8CPjByUFW3atOuglWwcIG6pCJcVd+YPilLyD3CsYo/cs8G8UxmOP9gkeau?=
 =?us-ascii?Q?yejBvMLoN9KyYH+gfrOIOBzwoyFFqwMQ86soFJsCXP1M3HEEVkjb6JzwE2Q2?=
 =?us-ascii?Q?nRgtGgs74REQqTzWUaYfWdLgFUseRFcEYbNjcx/b7Zc+BN+Tcwpju9skwcfk?=
 =?us-ascii?Q?MkqPJwKX6q3JMXAIlEx32lTsavfEFBdno52FqpsVwPvECmss17+qag1tmzM5?=
 =?us-ascii?Q?KeNZo/LOsjH8s8nkYFNTFfxNjHbfHetk2BJVMYVjgO4eJMBp6G5JO9g3OYJ7?=
 =?us-ascii?Q?OenLkDD6i4rrO+u2GNihhI+HZrvmCC+lQon3XdFSmlBIjoB0P61S33xdClgq?=
 =?us-ascii?Q?7JoNVz38EPqBIFPPrT9kmBQa2PhAkiebJQWobkvHQ8CTSYcFjmaurQdNSf3A?=
 =?us-ascii?Q?bGca9LOgxpixp8FVF7rT2074Z918P6XlHkTDb3jMvdhk2PMHsB937lCzKMq9?=
 =?us-ascii?Q?/aNqAgTG7OBTIYJOCnEcw5Bjd5NhBJ8UE3HFqgvzpzKBsPY3R3zH9xdW7ZpS?=
 =?us-ascii?Q?2SsVLoYtOfFUaBYDeG1iKsKQ3mB1/Pu4Dw9WyJ9X9E90DYDzu5BpSLX+sEXl?=
 =?us-ascii?Q?0bg82QPczMKms3axgnVloasBjjEL77ZYoa66cD/AQ2x8AQJNcNu/mu3d7AMm?=
 =?us-ascii?Q?m4zjtWTiwmH6z5OC9698cOwLh5vbGIgKKmSxouvCwyn+k0ZbfECD8txopp0O?=
 =?us-ascii?Q?L+KRE32KgwayV94EAUUyzmNgQmRCpvui24THaHEucqZ52Ug452DpskW1Y6vJ?=
 =?us-ascii?Q?/ySOqIOAfLo0yCFv6QiaR9U8uwPoBLtAbX42A+8+ckhiBwocXta4rKhrr5Y3?=
 =?us-ascii?Q?iLWNozQ2hq+PtmRbll3hMOG2HSKiohDQgVKkpbqYtWmpMdasVIaLTxPDlXDu?=
 =?us-ascii?Q?op5E1iZh7zjg81ZgUkXSG66ZlOGIsmH6NOPwT7wpeVszNjTbvvWcVUW7Csco?=
 =?us-ascii?Q?lT8Ziqgbgmu0mPuzxTkrDmPlxNHJK6s8vXMji8wbGJrLCCfUStKvA52bTsHY?=
 =?us-ascii?Q?OtyTbkEwtHpWCnNYuuEaFQanSkC5UV1RKDitZqwSx8kXIE0D0Se6aoiDIh5H?=
 =?us-ascii?Q?nYM4gFpHpclNUOp/OVvnjPqXnEXEMPnaLkvTIM+smsYF+u9jLFS/nBLAC+ej?=
 =?us-ascii?Q?K1HqTQ6fWPYcD3qz9QydJYCdE9Lji6Krqxf/tPulpbkTnrqsl7TUvhhpKeRH?=
 =?us-ascii?Q?X3xVyxDtSrKwHoaoALd6uj9qNOzuSOydznG1omQiZvnnqm3YR+NsA9Z5Cmd+?=
 =?us-ascii?Q?c9mkYoJypU8Z8Bx3zBP07IjFUVR3EmJQoPGRfUhDKQfzRcEqnNMsWISf2u4r?=
 =?us-ascii?Q?za1sNAS7Witf4IKqrH7WPRkBAfcGNcIQdJx3tDjfbYN3+/lWDXTU2an5wGx5?=
 =?us-ascii?Q?gJiX35RzUgl0F4ML5CFcLkJSPcqS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0209f3f-7f30-4cb7-4f35-08d8daa71f18
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 22:37:39.4132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mz/h6PMuS0zAl5TBl2ZHgJiS/J1T7DWmnTJ69dmLoOGsuAtAxZ+d64OO8dtgyGB98OYtfKsD47ULiLmU4Qd5BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1883
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com,
 Jimmy Kizito <Jimmy.Kizito@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
Currently the creation of link encoder objects is tightly coupled to the
creation of link objects. Decoupling link encoder object creation is a
preliminary step in the process of allowing link encoders to be
dynamically assigned to links.

[How]
Add "minimal" link encoder objects which are not associated with any
link until required.

Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c     | 14 +++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc_link.h          |  4 ++++
 drivers/gpu/drm/amd/display/dc/inc/core_types.h   | 13 +++++++++++++
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h |  1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h     |  1 +
 5 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 81ad546b2098..fa9a62dc174b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -91,8 +91,14 @@ static void dc_link_destruct(struct dc_link *link)
 	if (link->panel_cntl)
 		link->panel_cntl->funcs->destroy(&link->panel_cntl);
 
-	if (link->link_enc)
+	if (link->link_enc) {
+		/* Update link encoder tracking variables. These are used for the dynamic
+		 * assignment of link encoders to streams.
+		 */
+		link->dc->res_pool->link_encoders[link->link_enc->preferred_engine] = NULL;
+		link->dc->res_pool->dig_link_enc_count--;
 		link->link_enc->funcs->destroy(&link->link_enc);
+	}
 
 	if (link->local_sink)
 		dc_sink_release(link->local_sink);
@@ -1532,6 +1538,12 @@ static bool dc_link_construct(struct dc_link *link,
 
 	DC_LOG_DC("BIOS object table - DP_IS_USB_C: %d", link->link_enc->features.flags.bits.DP_IS_USB_C);
 
+	/* Update link encoder tracking variables. These are used for the dynamic
+	 * assignment of link encoders to streams.
+	 */
+	link->dc->res_pool->link_encoders[link->link_enc->preferred_engine] = link->link_enc;
+	link->dc->res_pool->dig_link_enc_count++;
+
 	link->link_enc_hw_inst = link->link_enc->transmitter;
 
 	for (i = 0; i < 4; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index e189f16bc026..df6ab333336c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -103,6 +103,10 @@ struct dc_link {
 	bool lttpr_non_transparent_mode;
 	bool is_internal_display;
 
+	/* TODO: Rename. Flag an endpoint as having a programmable mapping to a
+	 * DIG encoder. */
+	bool is_dig_mapping_flexible;
+
 	bool edp_sink_present;
 
 	/* caps is the same as reported_link_cap. link_traing use
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 8efa1b80546d..c5f483287509 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -97,6 +97,10 @@ struct resource_funcs {
 		const struct panel_cntl_init_data *panel_cntl_init_data);
 	struct link_encoder *(*link_enc_create)(
 			const struct encoder_init_data *init);
+	/* Create a minimal link encoder object with no dc_link object
+	 * associated with it. */
+	struct link_encoder *(*link_enc_create_minimal)(struct dc_context *ctx, enum engine_id eng_id);
+
 	bool (*validate_bandwidth)(
 					struct dc *dc,
 					struct dc_state *context,
@@ -210,6 +214,15 @@ struct resource_pool {
 	unsigned int underlay_pipe_index;
 	unsigned int stream_enc_count;
 
+	/* An array for accessing the link encoder objects that have been created.
+	 * Index in array corresponds to engine ID - viz. 0: ENGINE_ID_DIGA
+	 */
+	struct link_encoder *link_encoders[MAX_DIG_LINK_ENCODERS];
+	/* Number of DIG link encoder objects created - i.e. number of valid
+	 * entries in link_encoders array.
+	 */
+	unsigned int dig_link_enc_count;
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct dc_3dlut *mpc_lut[MAX_PIPES];
 	struct dc_transfer_func *mpc_shaper[MAX_PIPES];
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
index 43e33f47734d..31a1713bb49f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
@@ -36,6 +36,7 @@
 
 #define MAX_AUDIOS 7
 #define MAX_PIPES 6
+#define MAX_DIG_LINK_ENCODERS 7
 #define MAX_DWB_PIPES	1
 
 struct gamma_curve {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 3d97078d52a9..fe1e5833c96a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -48,6 +48,7 @@ struct resource_caps {
 	int num_ddc;
 	int num_vmid;
 	int num_dsc;
+	unsigned int num_dig_link_enc; // Total number of DIGs (digital encoders) in DIO (Display Input/Output).
 	int num_mpc_3dlut;
 };
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

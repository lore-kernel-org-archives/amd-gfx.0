Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDD7C433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EA066052B
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3EA066052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66BD96E114;
	Sun, 24 Oct 2021 13:32:35 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 145866E115
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ct45aSMBT+XvoqLd4r9PH+pDci9QWz4ihIrFDXZ7g8l+TjX0HZTV//UN0L0OqhhnYy83JaRGiCS1pdO5B2R1zbLJ792b5y3dr3d0RbC7hnLM9buOz6JH8+r3uV0arSj7vI/ipsDxh80vBbMez7PwTJh7uryCvewU8p5BCmEtjXrFDQhxAI0nZM6eyl+hz155M3c94m9TymqvpgfVoBP5wV9gqcGkR0t4709X3wpSl99WtZIry9ylZhjfqg9Zkrf5snb3Y+mIe68o4SAaATEnLE1x1e62XTYRS0QvwHesynQKySduc0wp9N4Lh8igpFmCIrUBp6Dp74ealhIHl7RVAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8QmOocReqbdGcYcJjwmhMt3sOST0GG+25lecnoHrqw=;
 b=Z1q10FDQAAdHU6Sijbcuf1Eww/ghoFDrC0qbVJnTSTBn4Vg3NlyMCVwgcNnnxuylsFL8N1wIkkHUbd/LYpkRvdG2h3HZffUErUIvbKauuCtznSbqKr+r5OgxlTO4gItBMfzbMwHUULkAEV9CllUIbVV+vhkOBe03VpR7etnZKqYhQ/IDaDxyfG2oIHtHSoaOaApmlMDEsN12r1561IATBRF9LKjsn7/a06r57HOiWQJU9WoUyprrh8i9QEXBRh2RhKnzKRWcnb9OxDhBiiIsNbGJSiKTYU6x72kNrdf6ZHh7J8s2VhNtfQFRvAoRiwbipfbYC5S50el7p20IGKHwgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8QmOocReqbdGcYcJjwmhMt3sOST0GG+25lecnoHrqw=;
 b=3eUKGtXZp5a/V9b8jEU8nxdXYhBSkZMMbaZ5k1Uu0IAi1sfqIa9ooaBg+zpt1XWq53MncaUDrBnCSqPPtDtepoKv3S4zAf/pimlMuVJ4Rx5RGld8zu9K2F/8J95m6qqs8xziX0nwwzhBGdRSXldmMi7otEesaatpfqPL3Qn70JU=
Received: from MWHPR1401CA0020.namprd14.prod.outlook.com
 (2603:10b6:301:4b::30) by SN6PR12MB2846.namprd12.prod.outlook.com
 (2603:10b6:805:70::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Sun, 24 Oct
 2021 13:32:29 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4b:cafe::fc) by MWHPR1401CA0020.outlook.office365.com
 (2603:10b6:301:4b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:29 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:23 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Aric Cyr <aric.cyr@amd.com>, Martin Leung
 <Martin.Leung@amd.com>
Subject: [PATCH 14/33] drm/amd/display: Handle I2C-over-AUX write channel
 status update
Date: Sun, 24 Oct 2021 09:31:22 -0400
Message-ID: <20211024133141.239861-15-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
References: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6533bc9-2aa0-4609-3908-08d996f2b9ee
X-MS-TrafficTypeDiagnostic: SN6PR12MB2846:
X-Microsoft-Antispam-PRVS: <SN6PR12MB28469C2FBC19D0A4252990D798829@SN6PR12MB2846.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wEwB0awoc/7N5f00ICtSh4996k1/qzuBdsVivwph+nNSHlYO5TR+OUkBXU4hAig5QM+j0AmbD6ISEMIUHtg2mU0viJhEqCPw0cGSIAS9IY783BYgzZkZKeCW3XQv/XgWbPiSG2x8rbnbXnqI/15F+rJYhPSb0dP595C2T3dsoFyMsb2d2Gij2vLNRxReQfEtCl+1r14DsGuU76hofyPpoqs1xn7VEaVc2VCwwhw6LHt8+ZxSvDr6C6UR/yQ5bkjEZZW4U6APMt/ij/vIhnuZ4Hf971NyixjtmkY+4Af2n1fm47Uy/HGHi3Dh9DCFvM7c/B6zpEMET8wl7m/Ehxzb78A5TTGX3iq+mTeywIM4PN+yPPXpu6sjwYSv/SaFF1szPo9TQ1CdfMVxlhUdhCp0eTDGXh87hXmjVRqnnuf1Qtueq+CO4OMpqV5+g/SoPDe1GP+HzrgQ4r6jVSSCvM2URft7utgM3VvFEeHAc1lOzw5vgUoYcEP7R91+ykCunFzzHJMogXnmZTZgrDmJfW/+KRUEz5Iv2ZpZIxFKrKMNs6+3aDhI0dKl1JK+bxwtHs8/47A0mWVsJuRh9Bthbb4SJYRS8EVKv5wVVGFSaaX8UwUbwBfRa0FTFUDmgrdr2weFVoIe/fH7hocw+EBmcE2tiJvzkJap4X3Jod+C6TU2ZhqBXfkMJzpWwKZyyVmdMQUvaqo8G2abCZlopmqV5mIwwdmT4E8mkWuLJ6jYrHxU2sA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(81166007)(47076005)(186003)(82310400003)(508600001)(16526019)(4326008)(70206006)(54906003)(316002)(426003)(83380400001)(2616005)(2906002)(336012)(8676002)(70586007)(36860700001)(6916009)(15650500001)(5660300002)(8936002)(356005)(36756003)(86362001)(26005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:29.3725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6533bc9-2aa0-4609-3908-08d996f2b9ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2846
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
When writing long AUX commands some sinks will respond will write status
update requiring source to read status.

[How]
When a write request is replied with data (AUX_ACK_M), retry a read of
write status to determine when the write is completed.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  2 ++
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c | 15 ++++----
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  | 34 +++++++++++++++++--
 .../amd/display/include/i2caux_interface.h    |  3 ++
 4 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 1a99fcc27078..874a49b605c7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -64,6 +64,8 @@ static ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 	payload.i2c_over_aux = (msg->request & DP_AUX_NATIVE_WRITE) == 0;
 	payload.write = (msg->request & DP_AUX_I2C_READ) == 0;
 	payload.mot = (msg->request & DP_AUX_I2C_MOT) != 0;
+	payload.write_status_update =
+			(msg->request & DP_AUX_I2C_WRITE_STATUS_UPDATE) != 0;
 	payload.defer_delay = 0;
 
 	result = dc_link_aux_transfer_raw(TO_DM_AUX(aux)->ddc_service, &payload,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index 471a67a64299..60539b1f2a80 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -554,6 +554,7 @@ bool dal_ddc_service_query_ddc_data(
 		payload.address = address;
 		payload.reply = NULL;
 		payload.defer_delay = get_defer_delay(ddc);
+		payload.write_status_update = false;
 
 		if (write_size != 0) {
 			payload.write = true;
@@ -625,24 +626,24 @@ bool dal_ddc_submit_aux_command(struct ddc_service *ddc,
 	do {
 		struct aux_payload current_payload;
 		bool is_end_of_payload = (retrieved + DEFAULT_AUX_MAX_DATA_SIZE) >=
-			payload->length;
+				payload->length ? true : false;
+		uint32_t payload_length = is_end_of_payload ?
+				payload->length - retrieved : DEFAULT_AUX_MAX_DATA_SIZE;
 
 		current_payload.address = payload->address;
 		current_payload.data = &payload->data[retrieved];
 		current_payload.defer_delay = payload->defer_delay;
 		current_payload.i2c_over_aux = payload->i2c_over_aux;
-		current_payload.length = is_end_of_payload ?
-			payload->length - retrieved : DEFAULT_AUX_MAX_DATA_SIZE;
-		/* set mot (middle of transaction) to false
-		 * if it is the last payload
-		 */
+		current_payload.length = payload_length;
+		/* set mot (middle of transaction) to false if it is the last payload */
 		current_payload.mot = is_end_of_payload ? payload->mot:true;
+		current_payload.write_status_update = false;
 		current_payload.reply = payload->reply;
 		current_payload.write = payload->write;
 
 		ret = dc_link_aux_transfer_with_retries(ddc, &current_payload);
 
-		retrieved += current_payload.length;
+		retrieved += payload_length;
 	} while (retrieved < payload->length && ret == true);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 95cb4d7cc76a..6d42a9cc9916 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -534,17 +534,26 @@ struct dce_aux *dce110_aux_engine_construct(struct aux_engine_dce110 *aux_engine
 static enum i2caux_transaction_action i2caux_action_from_payload(struct aux_payload *payload)
 {
 	if (payload->i2c_over_aux) {
+		if (payload->write_status_update) {
+			if (payload->mot)
+				return I2CAUX_TRANSACTION_ACTION_I2C_STATUS_REQUEST_MOT;
+			else
+				return I2CAUX_TRANSACTION_ACTION_I2C_STATUS_REQUEST;
+		}
 		if (payload->write) {
 			if (payload->mot)
 				return I2CAUX_TRANSACTION_ACTION_I2C_WRITE_MOT;
-			return I2CAUX_TRANSACTION_ACTION_I2C_WRITE;
+			else
+				return I2CAUX_TRANSACTION_ACTION_I2C_WRITE;
 		}
 		if (payload->mot)
 			return I2CAUX_TRANSACTION_ACTION_I2C_READ_MOT;
+
 		return I2CAUX_TRANSACTION_ACTION_I2C_READ;
 	}
 	if (payload->write)
 		return I2CAUX_TRANSACTION_ACTION_DP_WRITE;
+
 	return I2CAUX_TRANSACTION_ACTION_DP_READ;
 }
 
@@ -698,7 +707,8 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 		aux_defer_retries = 0,
 		aux_i2c_defer_retries = 0,
 		aux_timeout_retries = 0,
-		aux_invalid_reply_retries = 0;
+		aux_invalid_reply_retries = 0,
+		aux_ack_m_retries = 0;
 
 	if (ddc_pin) {
 		aux_engine = ddc->ctx->dc->res_pool->engines[ddc_pin->pin_data->en];
@@ -758,9 +768,27 @@ bool dce_aux_transfer_with_retries(struct ddc_service *ddc,
 									aux_defer_retries,
 									AUX_MAX_RETRIES);
 						goto fail;
-					} else {
+					} else 
 						udelay(300);
+				} else if (payload->write && ret > 0) {
+					/* sink requested more time to complete the write via AUX_ACKM */
+					if (++aux_ack_m_retries >= AUX_MAX_RETRIES) {
+						DC_TRACE_LEVEL_MESSAGE(DAL_TRACE_LEVEL_ERROR,
+								LOG_FLAG_Error_I2cAux,
+								"dce_aux_transfer_with_retries: FAILURE: aux_ack_m_retries=%d >= AUX_MAX_RETRIES=%d",
+								aux_ack_m_retries,
+								AUX_MAX_RETRIES);
+						goto fail;
 					}
+
+					/* retry reading the write status until complete
+					 * NOTE: payload is modified here
+					 */
+					payload->write = false;
+					payload->write_status_update = true;
+					payload->length = 0;
+					udelay(300);
+
 				} else
 					return true;
 			break;
diff --git a/drivers/gpu/drm/amd/display/include/i2caux_interface.h b/drivers/gpu/drm/amd/display/include/i2caux_interface.h
index c7fbb9c3ad6b..418fbf8c5c3a 100644
--- a/drivers/gpu/drm/amd/display/include/i2caux_interface.h
+++ b/drivers/gpu/drm/amd/display/include/i2caux_interface.h
@@ -41,6 +41,8 @@ struct aux_payload {
 	 * reset it to read data */
 	bool write;
 	bool mot;
+	bool write_status_update;
+
 	uint32_t address;
 	uint32_t length;
 	uint8_t *data;
@@ -53,6 +55,7 @@ struct aux_payload {
 	 * zero means "use default value"
 	 */
 	uint32_t defer_delay;
+
 };
 
 struct aux_command {
-- 
2.25.1


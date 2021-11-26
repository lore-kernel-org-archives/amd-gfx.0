Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7799EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 19:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B88A66E857;
	Fri, 26 Nov 2021 19:49:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA1B56E950
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 19:49:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMWc3seTDYAGrIUy6ob4aE4PkgsMxSwiNCGnZSalKkuO1bZelrfZ4tcR6ZYot56JUsIZBiaKpm/Qe0/3AZSx3eWli7zhF30+LwRAPVnQcN2o/YjVdQymKrURGvFlBZ9E/xnO51BkaQJxM61YnWbEh7FVy7UBRbex3fWGjZI0mZN6WkWvCRDpr007aLec3Jt4j6RkHv47t860Q4wHnzoupH6qPOkvqrs2eyzG/A77uUnxZGOxUNb6z6YwoWaOiumLYqx9YQ6y1WhdKPj6/09HhIEnNbu6W1NEAb+U6y1gEwik2QyAw9uLuimAKebkU6Nhs4at11cr+XobkSkDT1XYmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YzVciRahmdngqIMwnGIz/ZPM+LbIhzvJlyNpDVrjzc=;
 b=NKgZzqAl5nVPJ4+URDSU6R5uwT4+YFBYRBUR3YrwfSqoaopuDPMJlNlUtvCH2LjtZd8+LxwG269b06Ep6X4ngWeOPACf0SOyHx87/oJEsyUbFdawmMX8JRWSwR8XGEvI+7zN3NrpPVmtyQD0i0K8aR9Qo2is6zE9a5dwaD7jOdpbX37P7V90kfpbJgZyWxL4YUGuXMjtOH/4dCDfh40qsO/e3215aV0Mjm1/kH5olhkhJwQ3FD/VsP1Tc+/JjEK+F+zxv4nCIOvI7g3eEqSQyZhfv4CT8WnmNeAZfNMd+t1YV9Em/WbSOkKGQO1ob3fcnrsxE0xB1JDstIPKtLSLCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YzVciRahmdngqIMwnGIz/ZPM+LbIhzvJlyNpDVrjzc=;
 b=BuMaak4108J4owT0EHwbQ/Hd2nC4A5IqPl+1gpsjddyiDAkQ+QCTmXEz1NrdoTwasOCfwwVEW1OCKbB2cD/sV1Ssh7J2CAglQzF7jtjRb0HJ7G2pvngS6M/iJtQc90iDsbwNIgus+SpvM1IKIBdPGM3RkM09+YkEZZf5X7cS+ss=
Received: from MWHPR1701CA0011.namprd17.prod.outlook.com
 (2603:10b6:301:14::21) by MWHPR12MB1391.namprd12.prod.outlook.com
 (2603:10b6:300:10::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Fri, 26 Nov
 2021 19:49:43 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::45) by MWHPR1701CA0011.outlook.office365.com
 (2603:10b6:301:14::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Fri, 26 Nov 2021 19:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 19:49:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 13:49:40 -0600
Received: from blakha.ht.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 26 Nov 2021 13:49:39 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/16] drm/amd/display: Add force detile buffer size debug flag
Date: Fri, 26 Nov 2021 14:49:19 -0500
Message-ID: <20211126194922.816835-14-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
References: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b40186b-6561-44bb-e40f-08d9b115e432
X-MS-TrafficTypeDiagnostic: MWHPR12MB1391:
X-Microsoft-Antispam-PRVS: <MWHPR12MB13918D94C7D32AB7E89DDF30F9639@MWHPR12MB1391.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: if2LHM4W1LoTzr/LF7DNCxgxV0ay016gfusQOPcewKdGRGX721xa17uVQoFdC3nj0YET9hSHW5kt571OzW1zf1y76T7CxdoWj0xcvcAW8FqSWL/+FgydY1vrL+UilHqCVG4gl2/W1k5Yc/VbuRSxpUzYsDL3Kj/YicFmlivYF5o6jQAYlnI/YRUnrynYITlcEvzozPMr6lwj9RVjHyIbRuvN4HD0ZB1kjCUw83fIWvHfDovdkzH9+SKP4E5Hq+vglbMjdH9tgbssFUFfI+7nS8a9AljwatOaOMd1IyEm+tqtdZApHTK4PPZRjHm/9fWKZIdOHjUmFz0Dchxb9ZBg+EHhbKmHWJugnKBsoHALGIPl9jxbWxjVgCkgH+lOUfPZPsMk4FnDyfmAgAPxHvcygeMJWgqRGHZDSXghOccpkdBGhbaCuVwk2IWJ9c623v5GqUFGb9f453k5hAmTegtV6zVdYchLOwjzEKe3XsF0iJt4tqsoGw3UNsrtNm6qjHYrupr/44FCnEftZj81opPPbixl3kz/WWam5Uio453vcIb1CvvyAe1w5dlP0NdVtmM86M7vruFhnyj68dYPHNCRXVlf0Ikt5XSAj9t11nXSpg0XcyZDf62yCj9On12KxbdQW2HeIax7R4cJcHDZnPmO5pD5v0TtDX1d1QRA+4FuqOszOUWdcpy+yZ19eQACeq3wq9SlK7tPK7SE+2ezqOsyVNc0Vt1YC3AL1rAi4Pv50KA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(82310400004)(6666004)(4326008)(508600001)(1076003)(356005)(2616005)(36860700001)(70206006)(316002)(81166007)(36756003)(5660300002)(8936002)(2906002)(186003)(70586007)(336012)(26005)(86362001)(47076005)(426003)(6916009)(54906003)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 19:49:42.8996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b40186b-6561-44bb-e40f-08d9b115e432
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1391
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Michael Strauss <michael.strauss@amd.com>, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Allow changing DET size with debug flag for testing purposes

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                  | 12 ++++++++++++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_resource.c    |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 9f5745313e48..a6607d4e3985 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -75,6 +75,16 @@ enum dc_plane_type {
 	DC_PLANE_TYPE_DCN_UNIVERSAL,
 };
 
+// Sizes defined as multiples of 64KB
+enum det_size {
+	DET_SIZE_DEFAULT = 0,
+	DET_SIZE_192KB = 3,
+	DET_SIZE_256KB = 4,
+	DET_SIZE_320KB = 5,
+	DET_SIZE_384KB = 6
+};
+
+
 struct dc_plane_cap {
 	enum dc_plane_type type;
 	uint32_t blends_with_above : 1;
@@ -691,6 +701,8 @@ struct dc_debug_options {
 	/* FEC/PSR1 sequence enable delay in 100us */
 	uint8_t fec_enable_delay_in100us;
 	bool enable_driver_sequence_debug;
+	enum det_size crb_alloc_policy;
+	int crb_alloc_policy_min_disp_count;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool disable_z10;
 	bool enable_sw_cntl_psr;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 6187c55ac82c..dc5650212a86 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1824,6 +1824,9 @@ static int dcn31_populate_dml_pipes_from_context(
 			context->bw_ctx.dml.ip.det_buffer_size_kbytes = 192;
 			pipes[0].pipe.src.unbounded_req_mode = true;
 		}
+	} else if (context->stream_count >= dc->debug.crb_alloc_policy_min_disp_count
+			&& dc->debug.crb_alloc_policy > DET_SIZE_DEFAULT) {
+		context->bw_ctx.dml.ip.det_buffer_size_kbytes = dc->debug.crb_alloc_policy * 64;
 	}
 
 	return pipe_cnt;
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5C4EB64D8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 20:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2125410E2B0;
	Wed, 14 Jun 2023 20:42:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 059A610E177
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 20:42:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHsucRYHg+lM2TZTvjDR/TcvMzIf+8+sWqD1fmXHqim47hSZebwTJ8HPPmF3QKqU6jfiaQ+Rnk3HtDournlZrH1Xb0ExqqR/0lNbmV135FckCtPrhG+EP+l4ku8m8BrJayZFfTebwzEJ8muW2Xmcbv9BDNV0CYP5OVH6f3xtcZUPunQrLEPXDfImTh2ugutlmthGoKHCVfuOvWK5AzMKGtb3CDK5S0ewe1/isTe5vp1y7Z/NBOqrM3nSBzEhQ0cA7OSnHfGcHkdegsnB+K4GSU4h12F+44X+U8Y3YJ+7W2OLtwIUZeUywBzQf/VCzBm8YR0ywgKWUmrAhj35JQuN2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKzf6A5eceUtsHt+cwVl70gaYK5A5NuS/FDCoETe3W0=;
 b=cld/0aCgGxMf7PWWfjKuFIhhRVvTP5tD14RIqpykDHUC8es21tFotlFKp9sJurzROqLkpaHjcNjjPxdB4B3Vc5pCLapRIDjQ6C7Kgyc6TSDoAuqkqG3wNqUIpMfpFcMraoirDozZMMvbzILIHcSng6DC/7DqWzp6c27BKFN0Y7Ui6CcTF3LJAg0IfxhwKMg5M9CIlIR5AcufZmbO7rPZb0em4eowkEeUtX+lD5YiNpOoyNFVvAzyJmvh0J885takmUww/vnusk1MgGUeSorl3zfG5WUq2BsOaNgbbq5b6ziQXoFMvsLHTtkDd0G0z8H81aKdYQX0rCvSMjsKCoUobg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKzf6A5eceUtsHt+cwVl70gaYK5A5NuS/FDCoETe3W0=;
 b=DW1KJ4WU9yWRcQjp6MtQ9TOaIbu/mfCvBRy0NV5DSt/+PIEdqdY4hOv7l0OxdNX2Uw+g63yndi+omXF6dunxPJP8NISRdaVcGsHQz/jIF+ijDwjoPtTTF9hiZSJsApkL05yhQLvSrQymrob5SaqdKEl1Fva3ppT25bbKbZclGPQ=
Received: from BN9PR03CA0700.namprd03.prod.outlook.com (2603:10b6:408:ef::15)
 by SN7PR12MB6671.namprd12.prod.outlook.com (2603:10b6:806:26d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 20:42:48 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::29) by BN9PR03CA0700.outlook.office365.com
 (2603:10b6:408:ef::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Wed, 14 Jun 2023 20:42:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.26 via Frontend Transport; Wed, 14 Jun 2023 20:42:48 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 15:42:46 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/display: disable power gating for DCN314
Date: Wed, 14 Jun 2023 16:42:33 -0400
Message-ID: <20230614204234.145409-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|SN7PR12MB6671:EE_
X-MS-Office365-Filtering-Correlation-Id: eb66dd70-3e49-4bdf-5e57-08db6d17ea36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uLBFdnwnYomHaZvm41emrSjiIo45BHXO8FMgDAwTlSUh7whZMF102kUpUrIui8rye9kWEwlmLtwD5BzOeX9bygXSA6Lu/z7C18/AisoCbkyB3hIg4DM41EJ9kXqi2FDspCeuePJ/i8rwgrWTOAucauWCtF2Jv6TbDT+8z8bo9eHwkjJS8LAaNG7P7LkKFYcpBDVciQ5HpKVXTxE6P/4zfulhteNNttWxJyv+WXPtgUD4i5HeoooVvRhuQQk4qShKf9h/oeLMRSLPKVG0f2EE2wVsCgy8wE921UUpFsNjB6D0RzA5M3SSDcVIzsxjR36QE7iPKyBVY6c7Is9ovHoQiTP4jMYBNycIsZgwLgnsLxpzm3VB37ToIc39FfWB1FUJNM61Y4cKiErpoaZcrRGnStETK3HS2mGI0D/btNRbeGY9yimnF2yGyo7WR3zLhVlAvVENIqcrudHq0c4/PSrdjyeixL795bJXIbLHLG3j9uRvOc2vsRReTh5l4kgGBKYMk1gXoZFjkaXZxtukitmUAgbgMprwFub8q1qzNOKKckpmQkc/4sw6PcrWNHA/gR4NqLv6UpH2GmNiGYRWRE19+g2H6SP0iWppgS7zJ4AELkNomMdkFXn+/emSaU4rzOglvmfCYCUYGea5bwUck4mPPsmMmOnZ+FXcwhMawgPUNJLt1QKo1qKNOkn1uMpGnTIkIYP6qz6r/xxb9yx4ZNHO34IOMycRx7nUx1ZBV1J+izO32B1dfMQ+CIe+Vnhr3HI0+El4sKjcB2iWjlCSXPVvBpEm+w+ASocUbLeaPJUZXcQod55CXdugOsXEOaDAMFPp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(40470700004)(36840700001)(46966006)(26005)(1076003)(6666004)(40480700001)(16526019)(478600001)(186003)(44832011)(86362001)(40460700003)(81166007)(4326008)(6916009)(70206006)(70586007)(356005)(316002)(82310400005)(2906002)(8676002)(8936002)(5660300002)(82740400003)(41300700001)(2616005)(336012)(426003)(54906003)(36756003)(36860700001)(83380400001)(47076005)(16060500005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 20:42:48.3695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb66dd70-3e49-4bdf-5e57-08db6d17ea36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6671
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
Cc: stylon.wang@amd.com, Daniel Miess <daniel.miess@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Daniel Miess <daniel.miess@amd.com>

[Why]
Power gating is causing error messages on some DCN314 systems

[How]
Force disable power gating for DCN314

Fixes: 6d642c58a814 ("drm/amd/display: Re-enable DPP/HUBP Power Gating")
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Daniel Miess <daniel.miess@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn314/dcn314_resource.c  | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index a840b008d660..ef49b4d7742f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1883,13 +1883,6 @@ static bool dcn314_resource_construct(
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
 
-	/* Disable pipe power gating when unsupported */
-	if (ctx->asic_id.hw_internal_rev == 0x01 ||
-			ctx->asic_id.hw_internal_rev == 0x80) {
-		dc->debug.disable_dpp_power_gate = true;
-		dc->debug.disable_hubp_power_gate = true;
-	}
-
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
@@ -1910,6 +1903,11 @@ static bool dcn314_resource_construct(
 		dc->debug = debug_defaults_drv;
 	else
 		dc->debug = debug_defaults_diags;
+
+	/* Disable pipe power gating */
+	dc->debug.disable_dpp_power_gate = true;
+	dc->debug.disable_hubp_power_gate = true;
+
 	// Init the vm_helper
 	if (dc->vm_helper)
 		vm_helper_init(dc->vm_helper, 16);
-- 
2.40.1


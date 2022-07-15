Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE86C43334
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7131510FDF5;
	Sat, 16 Jul 2022 14:36:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7FB910E1EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:17:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jh578ZyH+LSzrbtRh+zQQz3h8d6RIVhbZGPiYc7Yd0QueHKq3MVg04xe5QwaRK6+jHN0iMsdq7TxC1V+cx+No1El8ZpThgTIwv68rqYvJcHHGFhSCkvAP9NIl0Ad2VHuDb+RPf4LUmExRALfpsZ8EgYWy/qB32ok3PJ3Ui0/qvDDT1Is2k5Ebp+6CQvgy7mwVFlecumJ0N+SfiKGietAd2DNpA9ZUllGHQNHg3oQlUSozPPF088zqVV8KyGLttnd00uyPS+crnTGG1sjTtMaOIRmjkydjRULr6GgLVCGdEHePF7OcYaC9sA9b1AdClotST60TvyozHkpRbID6WwWnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjwBevwJlAkYpVxsxz4m2PgHVUunj+dKs7OC147nMVE=;
 b=lOZFKlBg6gYB+O8i2AK9noZu5POzEoo3Ivjktg1r+1GrF/KkmiRODSDl6LquWd0vnZsxZJoW3hiWElDLcoNZ+5rS7S8OJHIX87tS2qyHHufQ3KWGxPW2TjY4BBIsl2E7pi6PTZQBOuWXYGDQ23DSIbp5uUDLzFV9bQVrhpn44brhXNbE9j7qJkKUab5U3yeTdtX1zr+az06sUOO19Dphc85XiesQdw7isNy279Eq3O338amcGH9OT4uaiex3jYpSvCAqNA9RrWb/+HIBXLwkhnVO2+AS28Qb4Hrtk/t06temcPJ+sNMnvAHj4Z2LsP+YeXlzjJc5k0AftX2NVlD+9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjwBevwJlAkYpVxsxz4m2PgHVUunj+dKs7OC147nMVE=;
 b=RrjnNvXc5AladHsW+ioqvbGgP30VuH9BrwNQGlomuf1yAjDQRJwO/BSEKBnX8afw+7SNleCC8gazBoQZ9xbeedk1Cn00cx8u57ANTcW4mUweYrY/okIMODGL2kJsEmsK9DJRO6SdtorAjLADn92HVZk5B/aA103e9Scj387aOmk=
Received: from DS7PR03CA0351.namprd03.prod.outlook.com (2603:10b6:8:55::16) by
 BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 18:17:44 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::2b) by DS7PR03CA0351.outlook.office365.com
 (2603:10b6:8:55::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:42 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:41 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/31] drm/amd/display: Disable GPUVM in IP resource
 configuration
Date: Fri, 15 Jul 2022 14:16:48 -0400
Message-ID: <20220715181705.1030401-15-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cbb39b4-5040-4a94-a903-08da668e4fe8
X-MS-TrafficTypeDiagnostic: BY5PR12MB4177:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /OQo+LitHoSNKYU+FYg16XEitI0B6lNDqx9lrgWoVziBhUP2blMXVXlcYH2kFzMEs8Z+md0eHzqn2K7T5OsJJIHNH56+rMmGG+ySwFCWhfjQSxhFN2QP+rXit8l+KOGKrdtas6yC98oqDV8AhL4wH+zar2viGijEEayJgWReJapguRjS6wEqUrQUsKDFAZV7vqTMH7NGX6+TAqOOozEBzQigT+pHdE5QTDiDAw2Pf3IWc3QfRl+maFuGnE7Nq5AOdLJ/WEYj3LU0VQK2PVe/oPNDvrJrPaz5QxxLzHG8hxaDrxpGttITXlj7UCVfzN6uzOT0YzfUZWWad5lUwCiGRiWtNjHxjp1wt8lde9VEB9cgVnOb0kuLSHhKFpk14kSXpscqAzgB+WoUmfspd+CPG/M4H2rYu2MUt66GN4qiMgz49e10ydwLs2zm17yIqy5BeiEyKul19KCqahxOrgkNx/qyox/1LA2VOfECJYnbs1RWXlEDqymMe9xa4SIq/+cmLVd6PZF1IS2FopFVsQgS0Jg1Km6cSM8b5TjDI3SPhnw1V5pNujEeQoHmY8QFCX6xR1WhKHfHQep2VJYjSKuCI5sjpucE7GCOC+ljcoSo86VwpudTEzZ3hGgTfuGAcTcF/c4+PLkrtZjbc3H499sX64tFP1VUckyxWRiESrgLRGunF2HT6EYh15dZO/XA8kJPoVHdltiPVbrimlwSYkBwWwKEktWjek8pHfY9KLlI7VEviaYgj5m8fRb6nB4l7TGzlBkDf4TgY0bXeBPPqf7ZyaBAHO3ehdWzaLutsOuoCr3+7HHX7Toqcg8z4fv3EuEgD+iPEfWkeLkA02Bhy73Zfq6lbADxBesi5KrMixD3qus=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966006)(40470700004)(36840700001)(26005)(8676002)(82740400003)(81166007)(5660300002)(8936002)(41300700001)(82310400005)(83380400001)(478600001)(2906002)(40480700001)(356005)(1076003)(86362001)(36860700001)(336012)(6916009)(316002)(40460700003)(186003)(426003)(47076005)(2616005)(54906003)(70206006)(70586007)(36756003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:43.7289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbb39b4-5040-4a94-a903-08da668e4fe8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4177
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Vladimir Stempen <vladimir.stempen@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vladimir Stempen <vladimir.stempen@amd.com>

[Why]
VM enabled in IP configuration causes UCLK not
reaching DPM0. The expectation for VM enable should
be that KMD will indicate to DAL when VM is enabled,
then DAL will set the bit accordingly

[How]
Set gpuvm_enable to zero in DCN3_20 and DCN3_21 resource.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Vladimir Stempen <vladimir.stempen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 631876832dfa..0cb44ea9753b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -120,7 +120,7 @@ static const struct IP_BASE DCN_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C
 #define DCN3_2_MIN_COMPBUF_SIZE_KB 128
 
 struct _vcs_dpi_ip_params_st dcn3_2_ip = {
-	.gpuvm_enable = 1,
+	.gpuvm_enable = 0,
 	.gpuvm_max_page_table_levels = 4,
 	.hostvm_enable = 0,
 	.rob_buffer_size_kbytes = 128,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index ebbeebf972dc..d218c6dd71aa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -123,7 +123,7 @@ static const struct IP_BASE DCN_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C
 #define DCN3_2_DEFAULT_DET_SIZE 256
 
 struct _vcs_dpi_ip_params_st dcn3_21_ip = {
-	.gpuvm_enable = 1,
+	.gpuvm_enable = 0,
 	.gpuvm_max_page_table_levels = 4,
 	.hostvm_enable = 0,
 	.rob_buffer_size_kbytes = 128,
-- 
2.37.0


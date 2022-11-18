Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D67C43217
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 17:02:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49D4210E795;
	Fri, 18 Nov 2022 17:02:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9BFC10E796
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 17:02:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PM4pYWrR9JYVOArN+3Tk/AoJ8Vbl+LhjgQTXtB5VYdwniiIyd9rnPN9aEMesun6DltuRG1qdyXUf6ZmNfqYv+1fo6i+5wydT5WrFFWrVFjEzeG/KIC7OIGay+cGeKvZZ9DPr2bi7yUile+rwPtsPIrhj4tQoSU/EMTNn4B9KYM+1fM1ViCp+QrLz87joSa0qtJbwVEaDvmv1WfXLuEoxAw932A+4znfiQy7MvEBZ/ijstd61wilOCbRGatMZV0Q7CKYvyw0CW5aS0s/nRUYcFaF4c2sJPgvVINTCE2jqYFF2ZoHlXd11FCPEUdP1C5MH66/ScJ0vdlD0vj9mqtu1Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bu2ukYqlPVACFgk0fNPs+2idsU3xwLG9LagA2RrkpsY=;
 b=XlV3ZX/tiUMnjAGLXZ5Cj6s/Hi4ImJUZyY0RAc4LLI+ew81dFiOV/4rBRUCAtxiJlbbxehzXBgcuCcu1fjkACACc4SoV7X/BZlCmE89Dt2CCmdiskn3dF7UanbqqkDy+f42Vwa9VWTPagdqXC4OMBtGYZurF9O61U+WkzKLywnS6UVyLppGN0OTAByRj6QKkO66KowA4eUEc6H0WKZQBBKVMR1F77u/XcvNTM0O4Fgy7Z4Z1LIcEPnm+dCPP9L11d/9EWUFF7U7CHWIYaikDU0BWmNsimVrzlauO7eq5Nc7glaWhTXORHcPA0XDkh4aSGap3IouEsvV8fu96QUstZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bu2ukYqlPVACFgk0fNPs+2idsU3xwLG9LagA2RrkpsY=;
 b=e39az6CsLeTZ92V5+8u+vDvKR3rcCNxA4i0Z2h5BSn6zRM0vHQ0uz3jlh5ZyZvm0aqSlnDOcIqqSghnoy6BAsQ8mvKaFSVI5i4MqJIdr7eCN/PVIOmeK4m5mKF86d2QMDuU0EXbhQcT3VLoVbWLK9odIDFHGqRemr7mJOfD2kuk=
Received: from MW4PR04CA0097.namprd04.prod.outlook.com (2603:10b6:303:83::12)
 by BY5PR12MB4999.namprd12.prod.outlook.com (2603:10b6:a03:1da::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 17:02:23 +0000
Received: from CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::26) by MW4PR04CA0097.outlook.office365.com
 (2603:10b6:303:83::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20 via Frontend
 Transport; Fri, 18 Nov 2022 17:02:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT017.mail.protection.outlook.com (10.13.175.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 18 Nov 2022 17:02:23 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 11:02:20 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 18 Nov
 2022 11:02:04 -0600
Received: from brianchang-HP-EliteDesk-805-G6-Small-Form-Factor-PC.amd.com
 (10.180.168.240) by SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP
 Server id 15.1.2375.34 via Frontend Transport; Fri, 18 Nov 2022 11:02:01
 -0600
From: brichang <Brian.Chang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/22] SWDEV-1 - dc: 3.2.213
Date: Fri, 18 Nov 2022 20:59:35 +0800
Message-ID: <20221118125935.4013669-23-Brian.Chang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118125935.4013669-1-Brian.Chang@amd.com>
References: <20221118125935.4013669-1-Brian.Chang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT017:EE_|BY5PR12MB4999:EE_
X-MS-Office365-Filtering-Correlation-Id: f56a3e3d-02d3-463e-03a9-08dac986a975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4u2IWGKcAQ9gkWCS1dG/BzMgAtaRIkBmN5Iv6xHvivQCncDc3fnrkrXuIrvcPCtZoHmqgze7hmesrRN6IKuoIzgmxusqK8yO3ooxkN8ko56aznehO6D8X4YvwtRkBTNEdHskeTx3nZ8SWlrzoLEOHcqzoYQ/tAX7fN70hQsOOQVOmSpvB04hmLgcVSmXrJTFFrWgULXXlVYyGKEturkWHQmf91P64rx7rKFYYM63XF8d/zRv7UVyOXKg8+bbuc+s6EmTJ41wcWft6Jx0rIjddS3Q6UeOMlBG8AvDV3qJ8jJmZIOVqiEKANP2L9Mc2j7rNa6TTuRRbIALP9ZOaATzXSt8l3bdvi/GCePPdNNthKMSdUNeEWhG4z4Cjkn2qhaw2hfvPZOqiTEWw8WuflitWd/T/lB7PeIXqbzH+8lOGmTr+6kVp74aQrEimci+4q/j4mwRC0UxpsqHVaUzdBVc0AnS0SMa8YoaD9VPm2hVasLP9SZze75Yp90k6lceLCMvqSuf/fm+5oh74azD+5srr9LMHmib95YYzxkr6Vw9R3lSAwr/SlXiGaS3QR+3qCpbi27EvVwR7Ue6ZSUqFpfW3j2sd+A2IbZym5onWKDNcKUUVzY6PEkt7TCE3TvxED+bZ71ERIZFbmBN7s0S/AyOxSOkA1ETabIGqpx3WPM4OXrI0HB8fseG6i0UEngAwQ9IZPfCICvJLbL0+8bG0bbbNRcgbyuzs4MYcFNthRCnFaYrYksSGYkfN6jpQOX1GtTm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(478600001)(82310400005)(54906003)(7696005)(6666004)(4326008)(70206006)(81166007)(86362001)(26005)(316002)(70586007)(8676002)(336012)(83380400001)(36860700001)(6916009)(356005)(82740400003)(5660300002)(41300700001)(40460700003)(8936002)(186003)(2906002)(426003)(1076003)(2616005)(36756003)(47076005)(40480700001)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 17:02:23.0446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f56a3e3d-02d3-463e-03a9-08dac986a975
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4999
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <Aric.Cyr@amd.com>

Signed-off-by: Aric Cyr <Aric.Cyr@amd.com>

This version brings along following fixes:
-Add configuration 2 for ABM 2.3/2.4.
-Add margin for HUBP for SubVp + DRR.
-Fix no display after resume from WB/CB.
-Limit HW cursor size to be less than 64 x 64 bytes when the stream is >= 4K.
-Lower watermarks for enter/enter+exit latency.
-Update support types for DCN314 to include z8 only and z8_z10 only state.
-Add new value for soc bounding box and dummy pstate.
-Override fclk chang latency when calculating prefetch schedule for subvp with low uclk.
-Add check for DET fetch latency for dcn32.
-Add check if PSR enabled when entering MALL.
-Use base MALL allocation size calculations off vewport height.
-Add YCBCR2020 to CSC matrix.
-Implement DP-Tx portion to interact with DPIA.
-Add debug option for increasing phantom lines.
-Fix phantom plane/stream retain after fail validation.
-Fix display corruption with VSR enable.
-Set valid divider value for virtual and FRL/DP2.
-Add new num clk levels struct for max mclk index.
-Fix check for phantom BPP.
-Fix rotated cursor offset calculation.
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index e827cee94e5e..feb7a7f2734e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.212"
+#define DC_VER "3.2.213"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1


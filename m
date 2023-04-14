Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE496C77B73
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DD1610EDFD;
	Fri, 14 Apr 2023 15:55:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE1A310EDF7
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:55:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGporWjRfZDG2E44oO9cNQIwiqqU8ci3OSnnC3TqfvE37MCTl4+4JtKbeWeh6meuoFjEBHk7Z0WPD5EUhR8AuENhXNNsjBlm+G3kmzmR4kHcoSwN57nXbn7JAPgRj+bF4FpzaUAxPS3UmG3FA2DRNWI1BxuJwEJ7AwUPZebMgLis7SUaY1TlDiCQ4OjeYztGjkvDEO/8Bgn4jv5hwZuFR8Cd9G2+Ux5M9/xPg4kKufJ5PyyGP5NFJGAPnb86p60yv2Lax9P0fuiNPZqlE91qiTAqXkZeuo7or55d+5SOeChh+Zb+CmggcoxCRCMDEtc5gdZaufqGkmYqNDlarp3q5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZ+fpGd/axj2VlarQc66WZy+2o3JlvTBVT1oSvIBP54=;
 b=kIiz1+ms4ot3O8o4LYDTkPbrKnT0ljchp90Va0p8DcPIpxftwrUYyt65lwGQwu0kSPknw4KqnRW0YINIxOhvNIQFKjLVV35yYCeaBr1tW5fDXlGFwZRnijzPB46MpJ1+U0fmfyZt3mOLo4zNsbL8BQmKpj1yWlpej72wU3q+KCa/95KFZNfKW1oLvDpP467I+jlwObB0wf4YhbxIqWTLKVNbeO34Aws4IlKBDJ1R+PuaQJAxm/2UrkG1HNigjBrH44lsVMNJHYfXTMYngeSFSBz4uNomEHNnjdrzLraLgZ4kuGb0Rx4paLq7hIvdw4SX4zWH94AXvtzbZDMPGLbVog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZ+fpGd/axj2VlarQc66WZy+2o3JlvTBVT1oSvIBP54=;
 b=1jj8V+CH27CxzmwdjpV+n3MGcLtkU2DHfYa8Mgs84jmeZ8FkLxhtHKHpIVoH+8XbsUUhjRFTMUk1NbAVoC+be9yDyhh1pIW0RxcEaq6q4eLgYqOHnC8dwGt4NAtwhogeWWg4btMFuow9VSqd/PnSkREbpbRDhPE9eBT9fwKJxzU=
Received: from BN0PR07CA0021.namprd07.prod.outlook.com (2603:10b6:408:141::16)
 by SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:55:19 +0000
Received: from BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::7d) by BN0PR07CA0021.outlook.office365.com
 (2603:10b6:408:141::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:55:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT075.mail.protection.outlook.com (10.13.176.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.33 via Frontend Transport; Fri, 14 Apr 2023 15:55:18 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:55:16 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 60/66] drm/amd/display: update GSP1 generic info packet for
 PSRSU
Date: Fri, 14 Apr 2023 11:53:24 -0400
Message-ID: <20230414155330.5215-61-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT075:EE_|SJ0PR12MB5469:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e7e9a9-7c17-4b5c-0118-08db3d00a562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q/AnnVpbahow2kbjPjPCc43A8q1GqNkUPIJg4kcdVJHLFa66jz+BUpAumbR9RERz5eK3Z0emFEzRK019oRNLTYJWoeMtLDjLe6ZeTKe+WhOVNwYgmBMfOOP94WQCMScj66u4xxL2z9vn3VkxoqKE+pr8iDiQOnQEX8KRHxwE18Ek6wSbuDWoWX9XRs7YubVwGS+XbHtRg7h2TY7el+FboJqvgNITs/0zSSFZks0iHA84GGSyNv738KVKX2EJPXAAZUSe7bqLm2m4/vOWRteWshpE1+W0G3NrJ/q+7BN79TJ3XnO/TfqiFy81WPWF3ZXDVj8jnUvboMW1i7utW+2LQCfl7k9rXTHhpojCs8bt/H5+VljdgguUm/dTWmIcUmhEebBb2wkZXSdIATEbJKpGXT48C4lazlfXxzY2YAUsolzrAHZ14AUtJu8krDmUtm6DgAOgwrea6Sw/TxsC0p6MVDKHkcpu3BkKHywEFmqrdnNDX8JQi4Sq1iPjeRf6berxgkqOt7s35gYFs4jr4mx9hf7QiX6viMxjMwUZx1Jef62qMfXj7Kjpn/SKriRQGkZaP+lN1iPE/3J3zheoHvOH2Ef/r1DMFiJXXlRUq7PPpCLrSuyux39HdujDe23YN8/c/ouiBStjm50e4BE897yY/aLsCy4hLYJ9bRvPln5fJmcI3BeTcup2WcSh4IawpHoQeM5qTXcrHyo2BzXl1uLKDU9EYna1GJhkc5YsD9y1Cl3HnGlhUWUCUsLk0wzt+nzMzGZd4cpKjgD1tMl59frYRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(186003)(26005)(16526019)(1076003)(54906003)(40480700001)(478600001)(81166007)(356005)(2906002)(8676002)(8936002)(36860700001)(15650500001)(83380400001)(41300700001)(426003)(5660300002)(47076005)(2616005)(336012)(82310400005)(6916009)(4326008)(316002)(70206006)(70586007)(82740400003)(86362001)(6666004)(36756003)(41533002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:55:18.6546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e7e9a9-7c17-4b5c-0118-08db3d00a562
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5469
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Po-Ting Chen <robin.chen@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Po-Ting Chen <robin.chen@amd.com>

Base on PSRSU specification, every seletive update frame need to use two
SDP to indicate the frame active range. So we occupy another GSP1 for
PSRSU execution.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Po-Ting Chen <robin.chen@amd.com>
---
 .../display/dc/dcn30/dcn30_dio_stream_encoder.c   | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
index 9d08127d209b..005dbe099a7a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
@@ -436,6 +436,21 @@ void enc3_stream_encoder_update_dp_info_packets(
 				&info_frame->vsc,
 				true);
 	}
+	/* TODO: VSC SDP at packetIndex 1 should be retricted only if PSR-SU on.
+	 * There should have another Infopacket type (e.g. vsc_psrsu) for PSR_SU.
+	 * In addition, currently the driver check the valid bit then update and
+	 * send the corresponding Infopacket. For PSR-SU, the SDP only be sent
+	 * while entering PSR-SU mode. So we need another parameter(e.g. send)
+	 * in dc_info_packet to indicate which infopacket should be enabled by
+	 * default here.
+	 */
+	if (info_frame->vsc.valid) {
+		enc->vpg->funcs->update_generic_info_packet(
+				enc->vpg,
+				1,  /* packetIndex */
+				&info_frame->vsc,
+				true);
+	}
 	/* TODO: VSC SDP at packetIndex 1 should be restricted only if PSR-SU on.
 	 * There should have another Infopacket type (e.g. vsc_psrsu) for PSR_SU.
 	 * In addition, currently the driver check the valid bit then update and
-- 
2.34.1


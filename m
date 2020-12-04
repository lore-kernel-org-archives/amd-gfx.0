Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E182AC4361A
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:30:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C3C22AED
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 21:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C3C22AED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 632636EC77;
	Fri,  4 Dec 2020 21:30:37 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 287436EC77
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 21:30:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ieemm3FQbUWYWFZWPRXgBqffqmjO5iXNb45pnHmTcm0eRZfVRpW4SOM8l8lrbYisu95yJmj0yMln3YwQOo6BQ27Xk9VC8Yhkc6TVymYELf/5J93VoX+Nmd9Qnx31lYuZDInn48RTuQ2rWt0f8BuEydr4IinCHTjG2aOsMG55ruh+0LoduDXNX7XhggOS/wYD+Q3apxcJVV75q82X050kxQ3OPown7wDGU+mZXX0bt6iBJMZ8b/ztsCIziSYcjUeA9zrK5yeg7nOmPScfacpIkBZt25q2Idv+/lXX+MONFvs7CsF1YoHz7qYHaTfsD7uizajbqk/iv394srCFMRBiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEqi19sLtJLvhkNUACZKQk6ZPdSNlpVIcSt8jGu9kcM=;
 b=oD+ritSeEvpNcWiF8wLrZfxlkKpk6kyZPHSJFrohIZ6Qbix333RHmSKdsCxFkjQbrEDc0Ns2Z1L9CSKa7W74EPdFNaDqhnoLYIuh0zmwndOt2MXfeJKf7nwGOixda8t35TVFoVXLo+MfnvzgvUIjU82Rdocy/1c3ypc3/HXqft2+/Uj1UHXgxIOuLX04f9MV/+SMfZfpqWMiWD8wtI4JNOaZGqGeRQL/nRttmx7UxT7clNu3d/3XecfZiG1jATEw0VchnEDzYGwUOjhV/bFsXPCAWU7O3yJc0jQDbqum87dlecOszA6nzPkV17lqbMHTtVYgIpAB9AKR/Q4njox2Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEqi19sLtJLvhkNUACZKQk6ZPdSNlpVIcSt8jGu9kcM=;
 b=PVeBPrNQfOiIm0nk3JMGVDFkLvB+4X4ah693pTm3C+nvb/q2rNeg0DHD2lBzaj5o/anymDD4Ja16nODmvQ7sHzxVdJleyObPDKf8EA2aE/jK0h1qjFO/2h51KP1mdgLihIEiVw0pq2DdVNmUP1sP0VsIZgBXV7/LMivjYJIoIPM=
Received: from BN0PR03CA0031.namprd03.prod.outlook.com (2603:10b6:408:e7::6)
 by DM6PR12MB2924.namprd12.prod.outlook.com (2603:10b6:5:183::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Fri, 4 Dec
 2020 21:30:32 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::60) by BN0PR03CA0031.outlook.office365.com
 (2603:10b6:408:e7::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Fri, 4 Dec 2020 21:30:32 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 21:30:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:30:30 -0600
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Dec 2020
 15:30:30 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 4 Dec 2020 15:30:24 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/17] drm/amd/display: Change to IMMEDIATE mode from FRAME
 mode
Date: Fri, 4 Dec 2020 16:28:41 -0500
Message-ID: <20201204212850.224596-9-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201204212850.224596-1-eryk.brol@amd.com>
References: <20201204212850.224596-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93ecee9c-cf57-4470-b163-08d8989bd46d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2924:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2924887D9D5FCE64E7A3FEC9E5F10@DM6PR12MB2924.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4CXpViDGgDkky/Qx9QBuKMDbp0cbCukGn8w7UK9bcrJrX3MTcf7VABNkivY3cGrfH7YRH6h6Jb97QQzlHBrKBVkMOqff4X9i+C/IUwosllFHYtmUd8Jh5S/cfz8ocjq/QB/06o2JIWuauNnWDh6ruFxeNvlNea0H4me3vfMKH+8Sv36H2eNyTsr84roMijps+2iEM/2L3q9uc5hETG9y6/trxtEqe0Drra+YTcagD+s3ouwCxcQQzA6Qjzp2auNvvDCsD/UxcW7RbGpfx3Rz5XMKYr7k4jhbv+aAJJQ7Fx4lnTDAuaBO8HSopMph1qpBV1SavkVY0PJeC+csbfUxdv7dNrwMFrGasOcDpedp9U10Bofux7KOu1kJf2/QvzzcbxoM9MFJJlwi4LjPQQG0NZiu+uIo8FneSlY3+44nfDg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966005)(6916009)(4326008)(8676002)(86362001)(478600001)(82740400003)(83380400001)(1076003)(70586007)(82310400003)(316002)(8936002)(70206006)(44832011)(2616005)(54906003)(5660300002)(426003)(356005)(336012)(47076004)(81166007)(26005)(186003)(6666004)(2906002)(36756003)(14773001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 21:30:32.3796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ecee9c-cf57-4470-b163-08d8989bd46d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2924
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Judy Cai <HuiYi.Cai@amd.com>,
 Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Judy Cai <HuiYi.Cai@amd.com>

[Why]
Change in DCN10 to use IMMEDIATE_UPDATE mode for AFMT is not
reflected in DCN30 as it uses VPG.

[How]
Use IMMEDIATE_UPDATE mode for DCN30 in VPG.

Signed-off-by: Judy Cai <HuiYi.Cai@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_vpg.c  | 62 +++++++++----------
 .../gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h  | 38 +++++++++++-
 2 files changed, 66 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.c
index 9c0020c8a730..8cfd181b4d5f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.c
@@ -103,69 +103,69 @@ static void vpg3_update_generic_info_packet(
 		}
 	}
 
-	/* atomically update double-buffered GENERIC0 registers in frame mode
+	/* atomically update double-buffered GENERIC0 registers in immediate mode
 	 * (update at next block_update when block_update_lock == 0).
 	 */
 	switch (packet_index) {
 	case 0:
-		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
-				VPG_GENERIC0_FRAME_UPDATE, 1);
+		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+				VPG_GENERIC0_IMMEDIATE_UPDATE, 1);
 		break;
 	case 1:
-		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
-				VPG_GENERIC1_FRAME_UPDATE, 1);
+		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+				VPG_GENERIC1_IMMEDIATE_UPDATE, 1);
 		break;
 	case 2:
-		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
-				VPG_GENERIC2_FRAME_UPDATE, 1);
+		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+				VPG_GENERIC2_IMMEDIATE_UPDATE, 1);
 		break;
 	case 3:
-		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
-				VPG_GENERIC3_FRAME_UPDATE, 1);
+		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+				VPG_GENERIC3_IMMEDIATE_UPDATE, 1);
 		break;
 	case 4:
-		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
-				VPG_GENERIC4_FRAME_UPDATE, 1);
+		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+				VPG_GENERIC4_IMMEDIATE_UPDATE, 1);
 		break;
 	case 5:
-		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
-				VPG_GENERIC5_FRAME_UPDATE, 1);
+		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+				VPG_GENERIC5_IMMEDIATE_UPDATE, 1);
 		break;
 	case 6:
-		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
-				VPG_GENERIC6_FRAME_UPDATE, 1);
+		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+				VPG_GENERIC6_IMMEDIATE_UPDATE, 1);
 		break;
 	case 7:
-		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
-				VPG_GENERIC7_FRAME_UPDATE, 1);
+		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+				VPG_GENERIC7_IMMEDIATE_UPDATE, 1);
 		break;
 	case 8:
-		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
-				VPG_GENERIC8_FRAME_UPDATE, 1);
+		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+				VPG_GENERIC8_IMMEDIATE_UPDATE, 1);
 		break;
 	case 9:
-		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
-				VPG_GENERIC9_FRAME_UPDATE, 1);
+		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+				VPG_GENERIC9_IMMEDIATE_UPDATE, 1);
 		break;
 	case 10:
-		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
-				VPG_GENERIC10_FRAME_UPDATE, 1);
+		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+				VPG_GENERIC10_IMMEDIATE_UPDATE, 1);
 		break;
 	case 11:
-		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
-				VPG_GENERIC11_FRAME_UPDATE, 1);
+		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+				VPG_GENERIC11_IMMEDIATE_UPDATE, 1);
 		break;
 	case 12:
-		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
-				VPG_GENERIC12_FRAME_UPDATE, 1);
+		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+				VPG_GENERIC12_IMMEDIATE_UPDATE, 1);
 		break;
 	case 13:
-		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
-				VPG_GENERIC13_FRAME_UPDATE, 1);
+		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+				VPG_GENERIC13_IMMEDIATE_UPDATE, 1);
 		break;
 	case 14:
-		REG_UPDATE(VPG_GSP_FRAME_UPDATE_CTRL,
-				VPG_GENERIC14_FRAME_UPDATE, 1);
+		REG_UPDATE(VPG_GSP_IMMEDIATE_UPDATE_CTRL,
+				VPG_GENERIC14_IMMEDIATE_UPDATE, 1);
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h
index 0284092630f1..6161e9e66355 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h
@@ -34,13 +34,15 @@
 	SRI(VPG_GENERIC_STATUS, VPG, id), \
 	SRI(VPG_GENERIC_PACKET_ACCESS_CTRL, VPG, id), \
 	SRI(VPG_GENERIC_PACKET_DATA, VPG, id), \
-	SRI(VPG_GSP_FRAME_UPDATE_CTRL, VPG, id)
+	SRI(VPG_GSP_FRAME_UPDATE_CTRL, VPG, id), \
+	SRI(VPG_GSP_IMMEDIATE_UPDATE_CTRL, VPG, id)
 
 struct dcn30_vpg_registers {
 	uint32_t VPG_GENERIC_STATUS;
 	uint32_t VPG_GENERIC_PACKET_ACCESS_CTRL;
 	uint32_t VPG_GENERIC_PACKET_DATA;
 	uint32_t VPG_GSP_FRAME_UPDATE_CTRL;
+	uint32_t VPG_GSP_IMMEDIATE_UPDATE_CTRL;
 };
 
 #define DCN3_VPG_MASK_SH_LIST(mask_sh)\
@@ -65,7 +67,22 @@ struct dcn30_vpg_registers {
 	SE_SF(VPG0_VPG_GSP_FRAME_UPDATE_CTRL, VPG_GENERIC11_FRAME_UPDATE, mask_sh),\
 	SE_SF(VPG0_VPG_GSP_FRAME_UPDATE_CTRL, VPG_GENERIC12_FRAME_UPDATE, mask_sh),\
 	SE_SF(VPG0_VPG_GSP_FRAME_UPDATE_CTRL, VPG_GENERIC13_FRAME_UPDATE, mask_sh),\
-	SE_SF(VPG0_VPG_GSP_FRAME_UPDATE_CTRL, VPG_GENERIC14_FRAME_UPDATE, mask_sh)
+	SE_SF(VPG0_VPG_GSP_FRAME_UPDATE_CTRL, VPG_GENERIC14_FRAME_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_IMMEDIATE_UPDATE_CTRL, VPG_GENERIC0_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_IMMEDIATE_UPDATE_CTRL, VPG_GENERIC1_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_IMMEDIATE_UPDATE_CTRL, VPG_GENERIC2_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_IMMEDIATE_UPDATE_CTRL, VPG_GENERIC3_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_IMMEDIATE_UPDATE_CTRL, VPG_GENERIC4_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_IMMEDIATE_UPDATE_CTRL, VPG_GENERIC5_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_IMMEDIATE_UPDATE_CTRL, VPG_GENERIC6_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_IMMEDIATE_UPDATE_CTRL, VPG_GENERIC7_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_IMMEDIATE_UPDATE_CTRL, VPG_GENERIC8_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_IMMEDIATE_UPDATE_CTRL, VPG_GENERIC9_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_IMMEDIATE_UPDATE_CTRL, VPG_GENERIC10_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_IMMEDIATE_UPDATE_CTRL, VPG_GENERIC11_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_IMMEDIATE_UPDATE_CTRL, VPG_GENERIC12_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_IMMEDIATE_UPDATE_CTRL, VPG_GENERIC13_IMMEDIATE_UPDATE, mask_sh),\
+	SE_SF(VPG0_VPG_GSP_IMMEDIATE_UPDATE_CTRL, VPG_GENERIC14_IMMEDIATE_UPDATE, mask_sh)
 
 #define VPG_DCN3_REG_FIELD_LIST(type) \
 	type VPG_GENERIC_CONFLICT_OCCURED;\
@@ -89,7 +106,22 @@ struct dcn30_vpg_registers {
 	type VPG_GENERIC11_FRAME_UPDATE;\
 	type VPG_GENERIC12_FRAME_UPDATE;\
 	type VPG_GENERIC13_FRAME_UPDATE;\
-	type VPG_GENERIC14_FRAME_UPDATE
+	type VPG_GENERIC14_FRAME_UPDATE;\
+	type VPG_GENERIC0_IMMEDIATE_UPDATE;\
+	type VPG_GENERIC1_IMMEDIATE_UPDATE;\
+	type VPG_GENERIC2_IMMEDIATE_UPDATE;\
+	type VPG_GENERIC3_IMMEDIATE_UPDATE;\
+	type VPG_GENERIC4_IMMEDIATE_UPDATE;\
+	type VPG_GENERIC5_IMMEDIATE_UPDATE;\
+	type VPG_GENERIC6_IMMEDIATE_UPDATE;\
+	type VPG_GENERIC7_IMMEDIATE_UPDATE;\
+	type VPG_GENERIC8_IMMEDIATE_UPDATE;\
+	type VPG_GENERIC9_IMMEDIATE_UPDATE;\
+	type VPG_GENERIC10_IMMEDIATE_UPDATE;\
+	type VPG_GENERIC11_IMMEDIATE_UPDATE;\
+	type VPG_GENERIC12_IMMEDIATE_UPDATE;\
+	type VPG_GENERIC13_IMMEDIATE_UPDATE;\
+	type VPG_GENERIC14_IMMEDIATE_UPDATE
 
 
 struct dcn30_vpg_shift {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

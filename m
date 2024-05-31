Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52004C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0246F10E79C;
	Fri, 31 May 2024 16:54:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="whRHcQ/0";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9658510E696
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rv8PnHT+Y9VMBbhSZGtfTQs6fN5+yTVEGSLlznpjfljOUr1v7K+iSPNHP4FZ/jKNd4RDDVyyQ/AJ5HahCN8P4MVc5Z3OekDnPrkL0ewabbqD2Utl+rTnkWpEQnqsv5KHqEt8M7IFzgZFzWxBy+r6u2DhOJcEKOr11ZN01L3HQqIO6Mr0en8tK7F2mSMyPmuYTXGtZhHaQgj0ibpzj+VaEnbueLq5/vDsKuddkbBILcr7hpUozxu7N3fqxdtA2mitC3Gv6MglP3yXfcc68R79gVOXmWDFK5uhihhykpvRdmfckuY4rX/BLhkdYxy0ZGr6KAUOHSn4tAQlWeFo5eKiOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2oDfUIfPMJMyf6ICevmsVMTGdnoVsqDzkvauafi/qYk=;
 b=an0hv9Kkt34LkFvamcPv/8G8IO7bVO1Uf7ObB6wDrmsY47CmJJpS0CjXTditW7pOO4I3Rpp8+8c3/X4ljliap5325KmKI24KevnCe9YMYtDApSyPPf7OEFE5INYPOcT/cnTnGJxrYFqRhZM73SowjMW1vGGm08InUi0TsThAoIuyvg+VdSRTLVUbw/xHe5/y0WrwRnc79cLWD3KTH+4EM2OViuE+8z+jGd8p7OuRE91yrRgJlIEJQXBhZuD1j7fmdVKCLHktLPXXOhwe8VxYE3TRNMfBfAlrgS0O01FnoO9JBTgm/d/c6PwHiBgdNRVhYj9+x4wNA7AAVqea8q7INg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2oDfUIfPMJMyf6ICevmsVMTGdnoVsqDzkvauafi/qYk=;
 b=whRHcQ/0OlB+TzBeUYQoFc6yhXU2DBwnGctfomJjCyKbA5jqpv+fOmDkPkHaQC90UagLeA5TddDEGBtssyHzTa04Tevv8wCCHpyiYw2NYLHJUrwRTvT7AC0jla7QCVZeM7hbv/qzjpYfpYv3L6SthSw3cMW+phhEckvdeHGeW4A=
Received: from PH7PR10CA0021.namprd10.prod.outlook.com (2603:10b6:510:23d::20)
 by CY5PR12MB6407.namprd12.prod.outlook.com (2603:10b6:930:3c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Fri, 31 May
 2024 16:52:44 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::57) by PH7PR10CA0021.outlook.office365.com
 (2603:10b6:510:23d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22 via Frontend
 Transport; Fri, 31 May 2024 16:52:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:43 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:41 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 21/32] drm/amd/display: Change the order of setting
 DP_IS_USB_C flag
Date: Fri, 31 May 2024 12:51:34 -0400
Message-ID: <20240531165145.1874966-22-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|CY5PR12MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: bf976bad-fd05-444c-ecb3-08dc81921758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YbuJ5N5RkmzjlxElRuHnxQYCw6GMtT+XX9bYYBeRkZLUrtXhYbl3GXNjrCJN?=
 =?us-ascii?Q?6KeoFYaAO21wC28erl5E+DNrGZMiKaUU8D7BHKR8NruwWNTNmnxnEOGjcAqn?=
 =?us-ascii?Q?TIf7xSo0Ms26DkFeTZBwFbq792i0SQsF+9yC1WCcOjy4xhuyMfscE5nAmnqi?=
 =?us-ascii?Q?7fdrKcvknV0IOC4qNV+vbheLJFdCMBOn8oyi/HtieIKxD+5lP83QOMzqr0jN?=
 =?us-ascii?Q?npvZycmQaGosbXaqhY1YI/qi4LgdkGO5qKjOw4N+oKuSekjEB9GTjGF+LTZf?=
 =?us-ascii?Q?yOUZmcYkLa6fb+gysco9oGYBOIgSUV+c3wwT3iWkqklSOAAbxERgU27Mm3Qw?=
 =?us-ascii?Q?uF27P/lnt9fdBOBV7JLzxVDXnIdAZ5DsT3IWBTAooki1sAFoD4Qbjf11CsFe?=
 =?us-ascii?Q?wULu8ElpAQjUHmWrFSXIhxcY9GlFZrvpy9nva85SqlSSuQ+5q3PVnfsPUy+i?=
 =?us-ascii?Q?VsA/FN4okMGtR/RkdLKT4Gsyk/ELBEEe2bvMNRpYDMzEVgyoHQPBuVarbJiT?=
 =?us-ascii?Q?jAVJo4QPEuL4b95dbJZ732eQ7IrqQsi4qjnJnXwqjACuOsvlKbAmaEDemDhp?=
 =?us-ascii?Q?ZWNimnKhI0HAzJEYYprUMdnNXKC9RAa3z1ka0bwCJP+ZIBY9c+Vw/QebLi5f?=
 =?us-ascii?Q?ISDZ2JkijkGx+WehCEFkaJsMLGUF/D87rDNdUdqY0o1YWV65RYD7/U9jApdO?=
 =?us-ascii?Q?/gMkzDI2n6KA0YHCu1sfbO5VSTmAuRClqDeqZylLKDhbYSplu93//9mgcydC?=
 =?us-ascii?Q?Wwl3LI9nWlvCHFmj14DpyyUtMnSrCOzCr6yruCymLMDe6HMAstbta8Gdok0H?=
 =?us-ascii?Q?SpOJN6scKqHxA33zi+MXfahjGHZGpzGWdOFbN8TkqpnKiZtlHNom1q4EGnAd?=
 =?us-ascii?Q?jkBDuI4NBjmoqQ/nUAqfJfj83fGOwnh9ovOhtNEz0G3cozxrVgPBgSzCuIsq?=
 =?us-ascii?Q?8cmCKjEpeyA1dwX0ewH5R8f7GGryIWpDV+j2qxj++rRJLrSK9Zt8yAtY5qPv?=
 =?us-ascii?Q?IFsJ92RYHpIwGsTh5pEW5dCJQh0+cBdWGNMaY3nSv1ycPYU9wZ0rnIg1bZV7?=
 =?us-ascii?Q?7tK+z2lH19yixLnDb3sHqluLKI9pR/sepgB62nHQQNZLz7YTIgV7CxZeaeRD?=
 =?us-ascii?Q?5lMGqMdTwf1HA0UB3K3XqtCtam0vXkphM2xe9NpxJXjiYZS3p9pDTMPp7hKD?=
 =?us-ascii?Q?HJYmnFRooX5K+JFpA8VaK9nvzapS44bITXK0JsSPruX4WPzxPHeM0BRH4EOs?=
 =?us-ascii?Q?pGk1icHpT1dxsw+R+393MOOMJuDmwV/7XXLQpt8Pan/O5/pfydY8XnJEFEMG?=
 =?us-ascii?Q?Q4g3nvKurCDUD4eF2sbOfE7/o6L+FK0M6P9xj/zz4t04P7OAwNLZpnBiiOD1?=
 =?us-ascii?Q?WPBt78EbVm5m/IXnoQsmR3CmVYLy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:43.5742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf976bad-fd05-444c-ecb3-08dc81921758
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407
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

From: Wayne Lin <wayne.lin@amd.com>

[Why]
enc10->base.features.flags.bits.DP_IS_USB_C will be overwritten if we set it
before initializing enc10->base.features

[How]
Determine DP_IS_USB_C after enc10->base.features is initialized. Besides,
bp_cap_info.DP_IS_USB_C will never be set in get_connector_speed_cap_info().
Remove the redudant code.

Reviewed-by: Roman Li <roman.li@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c  | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
index 20f810a6646c..d4a3e811aa39 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_link_encoder.c
@@ -183,13 +183,13 @@ void dcn35_link_encoder_construct(
 	enc10->base.hpd_source = init_data->hpd_source;
 	enc10->base.connector = init_data->connector;
 
-	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
-		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
-
 	enc10->base.preferred_engine = ENGINE_ID_UNKNOWN;
 
 	enc10->base.features = *enc_features;
 
+	if (enc10->base.connector.id == CONNECTOR_ID_USBC)
+		enc10->base.features.flags.bits.DP_IS_USB_C = 1;
+
 	enc10->base.transmitter = init_data->transmitter;
 
 	/* set the flag to indicate whether driver poll the I2C data pin
@@ -255,10 +255,6 @@ void dcn35_link_encoder_construct(
 		enc10->base.features.flags.bits.IS_UHBR10_CAPABLE = bp_cap_info.DP_UHBR10_EN;
 		enc10->base.features.flags.bits.IS_UHBR13_5_CAPABLE = bp_cap_info.DP_UHBR13_5_EN;
 		enc10->base.features.flags.bits.IS_UHBR20_CAPABLE = bp_cap_info.DP_UHBR20_EN;
-		if (bp_cap_info.DP_IS_USB_C) {
-			/*BIOS not switch to use CONNECTOR_ID_USBC = 24 yet*/
-			enc10->base.features.flags.bits.DP_IS_USB_C = 1;
-		}
 
 	} else {
 		DC_LOG_WARNING("%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
-- 
2.34.1


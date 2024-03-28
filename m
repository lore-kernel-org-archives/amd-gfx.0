Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27802CD1290
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:52:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B8E6112540;
	Thu, 28 Mar 2024 19:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MvyJZpT2";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46E7510F751
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:52:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrKQvQwhZJCO1ubMzTnyzmZSfU8ZKhZ/RyEYHH6uBG4M8Cp+9pGDH8nbWr4DGRh2MWt7HCcT7CTKcLnmXPrPLBAUFIG8z3gErqSy6jvtPa3uS3a3gjvQ3rxmA8XDL/XWTMZd6h53xRgpLiRzzkaUCH0+J1QcbjdrV/EkXlhf5Jq7Mp5RSZQPBV6LFNQJI27PigctmsaBexfArMmglY+z1vZxcSTp/c+7GyTsXVYpgvCztjoPym7dtdpSwLsLRBUqAEm1VLEGJcW27UIj5ANYKmZoJhyp+QOXtR/zeEVSujPA9F4BMItxqhRznnR2rbzaMIgp0OanQPfG/4NnaZWmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kmrBywZpOQow/+s+r/9f2y5Y1FGrffaljh9QWTNH0E=;
 b=Xnjx05fiHJbufqDcVNyarKz7n/KQ9xp8TI6pY9ORCHvwwtAIL+Bu668DUKcFgvjWtApLoArtPsnL37RFSqMctgmmwXZFY8oFq8Ot+0TO85XOHPEVFMDdSfZO4nGEYlsPbgdZr1RCepx+5sJONERZtZH/BA0/ubdsIJVUhCuNzwF5Bzhgkmf10X/oWfohxsOPVBU/8m/GFwUjp2BaAwu/5KgsxmVwH0BptwJ6kJ/c/+trrMSTEQGbyJ5mHJh4Bt7OY8ux7TU+TmHlF0vwSwC2JLC0QJgI8AyvwkUjOo+QdNrO1Rt4ozHnxe+5qulRxJgH1syyLf+Ufbi8VgWyVbLF+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kmrBywZpOQow/+s+r/9f2y5Y1FGrffaljh9QWTNH0E=;
 b=MvyJZpT25VrsAscaGhT5FhwyoROpG/DEWSIR+KwZyFfTg33Ugm0YcarBu0lFiDxPm7bGq3HJIz1/0F+q40RHhLXVjrVz94roAzGHPim/4UwVgw28InKBr4vOsLszFcQExZchmXL3Dlpnrl1eVx7sieGZhPso4mjUQEKnJhv3NRk=
Received: from CH5PR02CA0010.namprd02.prod.outlook.com (2603:10b6:610:1ed::22)
 by LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 19:52:07 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::c) by CH5PR02CA0010.outlook.office365.com
 (2603:10b6:610:1ed::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 19:52:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:52:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:06 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:06 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:52:05 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>
Subject: [PATCH 33/43] drm/amd/display: Drop legacy code
Date: Thu, 28 Mar 2024 15:50:37 -0400
Message-ID: <20240328195047.2843715-34-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|LV2PR12MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: 20a16e86-9412-45de-a535-08dc4f608cdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: amEL6r4r9H3nPzMO+p8ywG3HSL+4FtncL54r72esqn5/ZpKFcygylAAvuVV0Z8JWPmZxFWvI3GRXw0HoDTtE+DlFQAFnQO/9GgJ34w7K7KdLdaU/YRwpqSWmEQcYtnXGao9LoKx6AWHPRpDBUdpF+D+N/RbnifIC2Tknm+3B1olyTgucT8V5IuyTn9CY9jwb2HENdaZkqJF31eJGPtym8QW51+eUL97had0z667A/EplYOsDAET5UQmagt+vykttG29haIdamqo3yCQUzazAWiYWMJWTEZI0Tx6pLn33k4gjtsAnTfTJSg8udR7Gvria3wDHfH/cpGIKlGBXiUWPMvccFmJiYBxav/dyw/3Mky7WyihAKJFOmnYHIqQwicqwuMeGum+9b3OgwPOY5nVzgO95M6F8I56HCtUhzBdcEX9W2E7kxWlv2dWBeUm+90Iw7ptD6XVcqlgGDFWvhyicUnYf0HPFIeS9u3+S5id+YjFauSp/SpPcaRUsHSzTnoIHMpVSIC/TxUUovvhPcjUTdsqwMr6R+K5S99UBkAgKg7L+0q+L0ZkfDXfwISjOknRXdFN8IT8GNqgE9RcmmcWQFKV400InBDuk+k0Jug7I3r10p1fSvxe2T3YoCO/mevdOtqKHkGIhHtn57+ScnxvUllQ5r6uO8oYEd8hhic9ycVmdzICR3imtHrR0EQ2tuXIGilOVJtJVJ7rkZEJU2wiLizDGs0+1gH8GKFIPeEevbZbncIzvYV/7Eh/a0CgActjw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:52:07.6930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20a16e86-9412-45de-a535-08dc4f608cdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h        | 10 ----------
 .../amd/display/dc/gpio/dcn21/hw_translate_dcn21.c  | 13 -------------
 2 files changed, 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 1cb7765f593a..b7ad64e7b62a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -917,16 +917,6 @@ struct dpcd_usb4_dp_tunneling_info {
 	uint8_t usb4_topology_id[DPCD_USB4_TOPOLOGY_ID_LEN];
 };
 
-#ifndef DP_DFP_CAPABILITY_EXTENSION_SUPPORT
-#define DP_DFP_CAPABILITY_EXTENSION_SUPPORT		0x0A3
-#endif
-#ifndef DP_TEST_264BIT_CUSTOM_PATTERN_7_0
-#define DP_TEST_264BIT_CUSTOM_PATTERN_7_0		0X2230
-#endif
-#ifndef DP_TEST_264BIT_CUSTOM_PATTERN_263_256
-#define DP_TEST_264BIT_CUSTOM_PATTERN_263_256		0X2250
-#endif
-
 union dp_main_line_channel_coding_cap {
 	struct {
 		uint8_t DP_8b_10b_SUPPORTED	:1;
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_translate_dcn21.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_translate_dcn21.c
index d734e3a134d1..2840ed5c57d8 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_translate_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn21/hw_translate_dcn21.c
@@ -95,10 +95,6 @@ static bool offset_to_id(
 			return true;
 		default:
 			ASSERT_CRITICAL(false);
-#ifdef PALLADIUM_SUPPORTED
-		*en = GPIO_DDC_LINE_DDC1;
-		return true;
-#endif
 			return false;
 		}
 	break;
@@ -184,11 +180,6 @@ static bool offset_to_id(
 	/* UNEXPECTED */
 	default:
 /*	case REG(DC_GPIO_SYNCA_A): not exista */
-#ifdef PALLADIUM_SUPPORTED
-		*id = GPIO_ID_HPD;
-		*en = GPIO_DDC_LINE_DDC1;
-		return true;
-#endif
 		ASSERT_CRITICAL(false);
 		return false;
 	}
@@ -308,10 +299,6 @@ static bool id_to_offset(
 		break;
 		default:
 			ASSERT_CRITICAL(false);
-#ifdef PALLADIUM_SUPPORTED
-			info->mask = DC_GPIO_HPD_A__DC_GPIO_HPD1_A_MASK;
-			result = true;
-#endif
 			result = false;
 		}
 	break;
-- 
2.34.1


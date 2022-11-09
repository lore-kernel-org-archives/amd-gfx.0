Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF05C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9F4110E57B;
	Wed,  9 Nov 2022 06:15:46 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 232AF10E57B
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:15:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsOwpfhqiXMt/OT++fNHpO7EniYmTEV8GMrq05bzJtvbZnUPG9zC3sNaqaMUMPmoz0wN96itfQiCehQ19LKiIWbOWw5DyKzhE1Wm9yFC8cqNGEsaTyT/Tg0SMP6mPQCwvfWDY9+VngaXH7kEkZXCnQmPNcYh5Dt8YNtiWM5tSufbTq5j6HThb9hpikqBR6/gJpCgT+r4xNy6cnJscBlDrJDGE6mKf8Sa6eSxJDc5FKxMFyQ134H9ZvmqEt+bL7vjZG/WeWYuyg/hLq5hGtmJ1sW57b5JVijUah+TQgzXpcze6WnAQypLIYPYuCelCu0wHHgRjnmHgULLwssjzmP6Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLRsVkvXuESt8RIl/hOnIvlo93IxWeXx8uWrZ8XFlhc=;
 b=P7GUVNvFPIwm+4pvt7LVVRwuDg8cKapqdypmqjOmtUse5Yy+9mz+NnIa9xnexxaultxEgGpSuOaXxs8teT+pH+5NKZN1C/eSiTWBhhwtCcuioNAFI6R7Vy5ZKMSYdRrE8v7X9+TXZ9lofmWOLsfz2KW12KR48nQQjwdRtRhrhUXhxFwW5fhx23GhWnTLnWhmQUVuDom/VioWuKXSFu+Oh/IzJOrVanU99kG0hImh8VIXX0saAMEHzCEPGuuZwSk+1mcrFd8aG7gx+WjBGasd0qPgXuZprz4qIe8UZUjelt+lsOCrwwxyP7N05wjNfykVgPBv9LbELJmVtvZWhZe63g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLRsVkvXuESt8RIl/hOnIvlo93IxWeXx8uWrZ8XFlhc=;
 b=BOaNQQRB2C6voHb8NvWe9K5m8lK2IKPOgoEFDlYt1phvz68FJevMKFBSTDtD4cyLD7phrhLWy3ARq3J6tjdEvbt7WJgdmI2AUtJKXDwVldQjM1HbzJQ4GL2dPyeYRfkw8m+gSqZQRKLGaumjA+XSOVmtfMK9RUtvlq5obsiimHA=
Received: from BN1PR14CA0020.namprd14.prod.outlook.com (2603:10b6:408:e3::25)
 by SA0PR12MB4480.namprd12.prod.outlook.com (2603:10b6:806:99::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 06:15:42 +0000
Received: from BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::e3) by BN1PR14CA0020.outlook.office365.com
 (2603:10b6:408:e3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 06:15:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT110.mail.protection.outlook.com (10.13.176.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:15:41 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:15:41 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 22:15:34 -0800
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:15:29 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/29] drm/amd/display: Support parsing VRAM info v3.0 from
 VBIOS
Date: Wed, 9 Nov 2022 14:13:00 +0800
Message-ID: <20221109061319.2870943-11-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT110:EE_|SA0PR12MB4480:EE_
X-MS-Office365-Filtering-Correlation-Id: 511aa49d-8b7f-4824-d4d1-08dac219d43b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rW1u3X1Lu6ZLxwX26p2BnnlOWk76WfmrkpQlFqLP8oQy2DszEuWj6TnR8vdWvj8JjZqGlPVciIjjpil2G0gW4F0kP/2zQPBHIKdWD74Xs2wOVxFwWtCs/jXlEuZlWNtJEOYZq1aZB0dtSwOCQb/i44fJPC29p0GUKqU5lVC/nrgaRjGdcSf2UedsSjyUsX/RNHFGCl+8B9aa6uXVqWHBp8W61q/NAx3gkb4wi79jNPLyB/fNdfP7wtg1ye9ClR/KwC5zs+Z5kw8x4gcS1CYDGZqGjWBTaIFm0p5ajOP5U/NW78mKQ2M84AgDXqR0Ke+M9roaS3V0/JMvi7VLMxgcDIeqYDcdqaBYsEenFE12lue3cm6urdcXqdnVhstIQvD7oURdcgM/IoAkLTGHSmfnKKAa3qBNRLOqlBz1nzT6ZxPVf3mN9His7poMfyFILHek1ElV69Cpad9arMq35m3a0qTAxpaOXBIWCyWZL6PE3gzTbXRYn2+IgQR0iMKibKZh0G7IeWQsks26JRukUEkMjsMB2Cq7AhRTdbM1CPuHl1GMLlzFhqVyaBwxJmk8aUAdAmd5m/Tzd/v/cNsBl7M2M50HNJiKwyhyTDzxXEfbfyZJpOCBwbF4+xKVKay9bEP0hiHz6VWMtgojPN5WhdIowbZrVTDtW3p+k7/UvXPS0VFkaX53/cwxrPTzHNCY3GFxxFPk1HB/pyeMeYnMkgK0aaCEVBC2ns5jH7GrwRFqQQjY8x+6REi/FZxCGzKRX6p5RPnSP9hKs2FT/lBQQWoNmEAY4J3+ps3K7BS1WCyIZNefKMFcwZvIjNMGucSMIetRoAQqDniuP/SBJ6Tl7F7y1B+JTdWxq0Gm0YQlzYaSq0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(86362001)(82310400005)(40460700003)(36756003)(40480700001)(70586007)(8676002)(4326008)(70206006)(41300700001)(1076003)(336012)(186003)(8936002)(5660300002)(2616005)(26005)(478600001)(6666004)(7696005)(54906003)(6916009)(36860700001)(81166007)(356005)(316002)(82740400003)(47076005)(426003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:15:41.6539 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 511aa49d-8b7f-4824-d4d1-08dac219d43b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4480
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <george.shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
For DCN3.2 and DCN3.21, VBIOS has switch to using v3.0 of the VRAM
info struct. We should read and override the VRAM info in driver with
values provided by VBIOS to support memory downbin cases.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 .../drm/amd/display/dc/bios/bios_parser2.c    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index ee0456b5e14e..e0c8d6f09bb4 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2393,6 +2393,26 @@ static enum bp_result get_vram_info_v25(
 	return result;
 }
 
+static enum bp_result get_vram_info_v30(
+	struct bios_parser *bp,
+	struct dc_vram_info *info)
+{
+	struct atom_vram_info_header_v3_0 *info_v30;
+	enum bp_result result = BP_RESULT_OK;
+
+	info_v30 = GET_IMAGE(struct atom_vram_info_header_v3_0,
+						DATA_TABLES(vram_info));
+
+	if (info_v30 == NULL)
+		return BP_RESULT_BADBIOSTABLE;
+
+	info->num_chans = info_v30->channel_num;
+	info->dram_channel_width_bytes = (1 << info_v30->channel_width) / 8;
+
+	return result;
+}
+
+
 /*
  * get_integrated_info_v11
  *
@@ -3060,6 +3080,16 @@ static enum bp_result bios_parser_get_vram_info(
 			}
 			break;
 
+		case 3:
+			switch (revision.minor) {
+			case 0:
+				result = get_vram_info_v30(bp, info);
+				break;
+			default:
+				break;
+			}
+			break;
+
 		default:
 			return result;
 		}
-- 
2.25.1


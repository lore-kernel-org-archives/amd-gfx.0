Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1483CD128D
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CE4F10F2F8;
	Thu, 28 Mar 2024 19:51:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LqT07aj4";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5863710E652
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:51:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6oqzpV2mphMc7l0nfqo/Z5uqlb645Oiv3TQf1bmQNu+ubqtZgBBJoFo3pTFuyHlxkTCkVBPOtQHE45gy6MigwoniWiOyz7WOBkGbddtETxCvSSjhXbNzOrOZRGBORmaOWIlR0Z9espm/uHYmQAalElvPYE7b2G55kl46490F21ja2hjVkGbVKKqKAOQYmTqHGPE2KjoBNJxFMcFDKzIXGGtFLpoyHe5wVZZhRchbvTXAa8tiKnJkMkdGOLUm0aQu+U9wDiruoojxCnyYSXpqlL4QVKwIU9gse7QNlHnJxapTd4CiBmkeOu5jphnpisOtBylmAZjzl1Cm/MJhBJ6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnOSLPWWsZUOHyb45ZfSz6b1jr8JsP7/xeT1XAETDDk=;
 b=R3BGzy99SbIqhGS4xHdXDU3IjpXltqf03Zm6uZ7fochHEx4CRTsbZ4WBOhiOEp2pyaKwaRz+CMeqz05vks4cWbxRBnNaRqjXcEC8AZ1tDbpUqLvWruyzgpmHdbsZUNUG1D6W4LcHTbZafmJeOdEpU1mvki97PknAk4NQZLxnPBh7dSzSjXnt2zjbzSHf65SimNTmWW3yFbOnkBiT1BHuUEbTQYBNOBRlJj926ErrrMEWxSAj8rxk173rgSJBQD1VjPwkdEFdcO7rlFd4JTTpGArpScsMGAXlfWtb9Z12xtoVd83iFkJT621uk/XgIpS2MrEtfJkSFsuTa8ogqHtPKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnOSLPWWsZUOHyb45ZfSz6b1jr8JsP7/xeT1XAETDDk=;
 b=LqT07aj4pm0oRMH0f99kq51QobA6bCd1j4SjEfTt8FLgpb8ChQl5tmgEU9fE0tU5IkYe8MYBt7gMcU4+0Rzd9RR7PpSFRpYTf/7FeIYmCAbaOpxpCHzjyNake3xr27LrN7BYev+N+FXcK9vnBWngTJfjCDSAGmzS6Z/1UsZl9I4=
Received: from CH2PR11CA0028.namprd11.prod.outlook.com (2603:10b6:610:54::38)
 by SJ1PR12MB6244.namprd12.prod.outlook.com (2603:10b6:a03:455::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 19:51:35 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::f4) by CH2PR11CA0028.outlook.office365.com
 (2603:10b6:610:54::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Thu, 28 Mar 2024 19:51:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:51:34 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 12:51:33 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:51:28 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 06/43] drm/amd/display: Decouple dcn35 and dcn351 dmub firmware
Date: Thu, 28 Mar 2024 15:50:10 -0400
Message-ID: <20240328195047.2843715-7-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|SJ1PR12MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: c456498c-4891-4c46-14a0-08dc4f607953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MtWLrGf7Xu//gq/zSlpv7WgxAelTtKnJmbGljzbaSbDAATcmeC40686AM4HiIazcRc+6yjoGakkGQfx26UhptK1R7VHiT/zGIYIwdmN3aWzGZqhADr4KtGG1/RD5bJyRYvHVWXFNyiZdJiO0zltb7Hsa90JoRkAbKJ15lrocyDK+wqTCRvG79ceEVgzDKVD5nszm+G1qkqdXAxzgT8jLeHyWd1w7UdsGzp9HPRkghXJ67EFvVAwDbxr84BtudJ6HFN50F4pN5H2wjM2S1at6/fu2JY0/SmtYiz8ii8JHowe5KwBsfbJQnmV+X2ZWeXh4buEfVeq1OzFzKgjlGr7J+hA2LeK/IBpVFDXqPzfoCXWlRsQJQY1Uel1hD+OE67sWDKIO9jtwjqiJfGHKbK8tZPJS7ttunekagJceL86e62zB6yTHfw5A8jsJsgDeX4T6y9AU93XqjxQGDXXt8ayXrW26PuU4tqHL82Oy8fUHUpuBB3ElGVOH6NmdjN0q7jzOkS/jKbZiaJSX3JywvthZ+/IOw5Z2OJd3LEzNJn1cvV83msq2ZH4vkF0QXSrWgXPLIeoxMO6BREn02iHME4ta4p+B4XdiNTJSHSnoDmqptsd8xTsX3xC01/PNYmxEBj/AjASwD1n+UiOFhunKvN3YUwJMofVfpTtYXiTw5NZPvgD94S/Z2TlI6XzYqgtJVf88oLIMbXPcHR8hicpGs8Rsy+EoEgnlw0tD4lxyC8514jw81+ANpF0lqfdL0b1CNuZM
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:51:34.9460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c456498c-4891-4c46-14a0-08dc4f607953
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6244
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

From: Roman Li <roman.li@amd.com>

[Why]
dcn351 dmub fw was decoupled from dcn35.

[How]
Add dcn351 dmub fw load path.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ef546932f6c9..d98632f37c0d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -148,6 +148,9 @@ MODULE_FIRMWARE(FIRMWARE_NAVI12_DMCU);
 #define FIRMWARE_DCN_35_DMUB "amdgpu/dcn_3_5_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_DCN_35_DMUB);
 
+#define FIRMWARE_DCN_351_DMUB "amdgpu/dcn_3_5_1_dmcub.bin"
+MODULE_FIRMWARE(FIRMWARE_DCN_351_DMUB);
+
 /* Number of bytes in PSP header for firmware. */
 #define PSP_HEADER_BYTES 0x100
 
@@ -4820,9 +4823,11 @@ static int dm_init_microcode(struct amdgpu_device *adev)
 		fw_name_dmub = FIRMWARE_DCN_V3_2_1_DMCUB;
 		break;
 	case IP_VERSION(3, 5, 0):
-	case IP_VERSION(3, 5, 1):
 		fw_name_dmub = FIRMWARE_DCN_35_DMUB;
 		break;
+	case IP_VERSION(3, 5, 1):
+		fw_name_dmub = FIRMWARE_DCN_351_DMUB;
+		break;
 	default:
 		/* ASIC doesn't support DMUB. */
 		return 0;
-- 
2.34.1


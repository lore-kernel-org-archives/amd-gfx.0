Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27883C25B67
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 14:21:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87E6710E826;
	Thu, 26 Oct 2023 14:21:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA11110E817
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 14:21:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3awgFM7ws6VeM2nvUyqlEn873SwiutU9SmPzEQ5qAFvIqTO5TQbSLIvtMclG3p9ghLwmEC48k7dwWFPf9U+OjcXmVg7rCmGvrTdGjZeZOw4MveBagetVCMPo0RejXUcX4VbTKwAdXtXudF5fr7zUsGPyc1RZe8toidpVoPTzDXWSPQJxF5iwDL0ezu4rLVsfW13nZ9au69NNrbxGCv9X7SBkPG0g46WWhkbz6Ae5vj9FGTAxegVWu/4xqZN121DF1zjOeR6nMYdXfADZPEETAo6tgg556AzNlmnyl1jLi1has5byNzlpgpjUJ7medPG9QHDyjATpkUP0BAGlMEs6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IE69k/eeumzYJCn4FO+J4lXaOfy82lbw5rTYDULWwSY=;
 b=jiaQ7fOL3eTjINkaU3tlKxUoHTrhh02KGN+G7dvp0z352uF/lKnBe1XaiCxcGxBmkpH8mSWfHtjgEdB249jgp1XGyoJ/rdyd1JZHBlisoZlMDYKil8HUVMEm36JrLwkj0jGpnQuZ4EREWsc3v9cwxdoHDWM9jKdCif03bhlsat7lkzPSvhrmILGG9yu9tCSrl55/AnEvKrMPgTvklk0vx1JyJmjRWz5Ya/Z33NaRouBqm0nClc5i09BIxc2kZzvuhXsNngjtmPcKh7PxXVhfKvKKNcKWc86bYGD7IsV5Egg+Ly6JHP89rkgNkYZNfvLmmnVyH/tm6aGpo2vcTfyzyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IE69k/eeumzYJCn4FO+J4lXaOfy82lbw5rTYDULWwSY=;
 b=3OatmjoOkXuTOjPqQLJzodqjdL/7shLFw2sKE8X1TBSkAqfw1tHFRCkmgZiDNaI9/YqQHT9yMhOvG/ntgKS65fsjLjZOKvaMeMbeAWsFng/rBtTIDIP0hRhfYyPuD4DaM8NK6jfjIPnUOkEqbea6K81O30hcVROyvJPKs5HHClk=
Received: from SA9PR13CA0045.namprd13.prod.outlook.com (2603:10b6:806:22::20)
 by LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 14:21:00 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::9e) by SA9PR13CA0045.outlook.office365.com
 (2603:10b6:806:22::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8 via Frontend
 Transport; Thu, 26 Oct 2023 14:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 14:21:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Thu, 26 Oct
 2023 09:20:58 -0500
Received: from hersenwu-Majolica-CZN.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Thu, 26 Oct 2023 09:20:57 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/25] drm/amd/display: 3.2.258
Date: Thu, 26 Oct 2023 10:20:16 -0400
Message-ID: <20231026142020.67861-22-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026142020.67861-1-hersenxs.wu@amd.com>
References: <20231026142020.67861-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|LV2PR12MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d3618e9-88a7-44e5-30e1-08dbd62ec72a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z4lbtUkN36X3qDhFtufS3tL5UZC9OY+a8LXszSFmsNk+QRtc4wIdvAgIgY34B982XHyLTp8qcTplXUQvAmC+5Ut4TsvvCWdSrBEbo2G5OXkXds2o9EQZ4029uKXtova/MvXHRgSwDJ5UKRJyCpoq0ioybQNlJtsHdfy42iaYarl+YCg6XacHcat/FwQDlZHhLkUNczuzWm7lUDS+NWjWocshZPsXWVwUJNCMIXmVcIZUF9gnrE14UjB08wulG6/Go71NRnpi1TFHT+y5djyklN7Faa5Kr1wJgr8lHp09hC94+PdvGFDXDyNP3o146MLqAfj4ncEIHop7dmUQGPWryI5QcJGwsM0XjL2tJP9udyeZyXXQtIx//6Zx9BNpjXmMb++bXxPWyFQk1s59cB11a9owtwfE7yx6hyiv/UK2z9Llgyz9hL2NO3UKcyQ9z+55vVjWzf8bbERqZXbq5EbnhMmHcAdeLokztJh8ugUcqrBykvBofXXe2eRi2eQYawSalVIHOB7sLedZ925zC8u0dbTrjsUFTzKzoT0lNZhPNRn7B3PRdH/Ya7k5z8Nvmxg+mb7t3GuH2Gs78gPzf6WmAFhhe1HJfsn77S6Stshv5V6BSHiClH1ONGEBG3fjfpKmhfPI7DxOEY4KNAzLpXA9E/HuCnrAdSSAXWgWWgqrd1L84eldy8GkTEuK7eMqX7G/daMtX4MNpVCRIQ5FkPrqHKsTAj0nFAWiZIRGsvACMjs1VCYHs2YjP6D+TblRmRqbtP/mWITCi3nXj2FtBZ/VDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(26005)(2906002)(36756003)(86362001)(4326008)(5660300002)(6916009)(8676002)(36860700001)(41300700001)(8936002)(1076003)(6666004)(54906003)(70206006)(2616005)(356005)(81166007)(82740400003)(478600001)(316002)(70586007)(83380400001)(40460700003)(336012)(40480700001)(47076005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:21:00.0702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3618e9-88a7-44e5-30e1-08dbd62ec72a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
Update test link rate DPCD bit field to match spec
Enable RCO options for dcn35
Add missing dml2 init value for dcn35
Enable DCN clock gating
DCN35 Disable cm power optimization
Allow 16 max_slices for DP2 DSC
Fix OTG disable workaround logic
Enable more IPS options
Fix FRL assertion on boot
Fix missing blendTF programming
Update DP HPO MSA with colorimetry from test request
Fix handling duplicate planes on one stream

Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 220609361eab..09328f1670aa 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -49,7 +49,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.257"
+#define DC_VER "3.2.258"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1


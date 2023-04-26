Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A46C7618E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 16:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9E1510E262;
	Wed, 26 Apr 2023 16:28:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FF2210E262
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 16:28:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROW8koGV/r+wRMQd8C3Hit9xF1NKpl7RIaGpVcmJtkZIc2+QOt19AnVSIKPAzYJ6mhlyvlZpgxFMcek+fvphDrQ1kTJfmjklUepxannt4Ml+h8G8SQ88Af/3/HsLjNBCiuBNHQaxdLpR7rKaR8xuptfknNWNJam9uDFuhqaHxv0nXzacT1hMWix/3cFIoL79EJj0+BzJUcmkN3nSe2WMTmZkTjx6MneEiEUhD2p7CAbfK+moMtT86bbRmM3YsvYH1F6lO+Y4xBX4nkl65s9pq7Ki0efrlD+uodDrDd/3wj2bzoQjnMFpoQQ2dACuIiY46VWBvMzb2gnNd+BUiQ/DTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ih+SB0WZIsReo5sHSxkUtVxD7q3KYYIAhnSoZpeTuc4=;
 b=ZT3Rq2NawJPweAWPipzxN28/UAUAgdX2RFaso8TLvH3X0xLxUHooCM6Z/7OIFieDpyJn+/FeACcPq5MIOJSGImr/dP6TdKct7vuOible+NwLAWqwqbM3VESZVEcg3LX+ciBxXmIbxKNJ/Ef66OEqdWD+qvLUMfcmEF4vBkeCISXraD4LQJ9x8qUBSArkEWfvFTGxPyMxnBJTTAq3pScYc/WniWpMGmb42JU63GMKYRBLVl+8gP6eV7HRXDzZwlTR5BRXf0V1pA4cs64OXL8bduv+/rRDn+rWiu4gj1RwiNXKpaBkVKVJVE1TjtMw0h4qRSvHCS8hhK0fDjtl3oE8NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ih+SB0WZIsReo5sHSxkUtVxD7q3KYYIAhnSoZpeTuc4=;
 b=gHac9dCibUWPJsqE+4ZuWt4Th4PpubJFTIjPyL+pPrS0Xxvh7LUMA0VoBL6+L4hK7VE07DqaF3S8iV5IguPMhAE5U7ndNcMP0iq8QnJw2MrikUNRAtLXWe1hc50sU+J6rMvbGZbX3e+zo7Corzp9rothcB1ee8KFJ35RqgXhwcw=
Received: from DS7PR05CA0102.namprd05.prod.outlook.com (2603:10b6:8:56::22) by
 IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Wed, 26 Apr
 2023 16:28:20 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::9a) by DS7PR05CA0102.outlook.office365.com
 (2603:10b6:8:56::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Wed, 26 Apr 2023 16:28:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.21 via Frontend Transport; Wed, 26 Apr 2023 16:28:20 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 11:28:18 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 11:28:17 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 26 Apr 2023 11:28:14 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/8] drm/amd/display: 3.2.234
Date: Thu, 27 Apr 2023 00:27:12 +0800
Message-ID: <20230426162712.895717-9-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230426162712.895717-1-HaoPing.Liu@amd.com>
References: <20230426162712.895717-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT008:EE_|IA1PR12MB7616:EE_
X-MS-Office365-Filtering-Correlation-Id: 37fbd18f-065b-4715-0802-08db46733f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xz17tqk5K4nWYih6ghphebilmgm6TJXlUqU0jxeEi5lwMvWiamMzDpSGcO4XIF0606ttqI3RonvfntGGBKuamVVZ4yLpxcc1KiK63S8mSJg3CqkZ398jEgS1SVaBwDB6akM23p5HFAeP52jjoRlVdGauScABlY89RtSQZUaiLWbfU+wGiyi60uyN4it7GHQ4zYvS3ZXIfI65ryQu98dAf9RfPIm6N4rX5Qz3nMw76o01FVkcGRr59BY63MmNV8VZbTaqWiBqgA6qhcoffA5r3DrhTtwKTdb07H8R8XbiVcgPYkWu/3kGXFFU9kXqM056eNVCgKMqwOviShrw2oXYMjqyOv+8nWG8OHH54lY5+6lXSXk0CUX/ynzVMOy8xnzmbV1z6G9/gdg9QeYt4f93CBEOw1zJUTp6uaOyTl4WbSwyDV9ypOddIU26Q3H+M2HNqRfURzsk0R8+JG1SAc4kdTxU1lm+vuJdoDRoHy5YuiZHCSS9scyRT5o7JOLAibnbBUo6Cirrif81/wUwJ9EwzCPCUhR2Z/TKCnSCL7sRtYrwTo4mMzWMR/gO/c/15iffNwdqLxrr9QhcrZ1deB9+ThKZQqUhX2NoBVzcBKIxLMWAadPKEPDXFIyc0ONdE21Z3SHZ6Uq5gYElgUD5Ii2sBQ/C+6mZ2DY7pClO5XnBKQHek/PXLSPWTXlpKg7vAjsrFIr2W/Y/VmvHsy0gtxCXFc8S/G0HDLBGkCU7q3SN7eg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(36756003)(54906003)(40460700003)(478600001)(82740400003)(70586007)(316002)(6916009)(40480700001)(70206006)(4326008)(2906002)(8936002)(356005)(41300700001)(81166007)(4744005)(8676002)(5660300002)(36860700001)(186003)(426003)(86362001)(336012)(26005)(1076003)(2616005)(7696005)(47076005)(83380400001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 16:28:20.0782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fbd18f-065b-4715-0802-08db46733f61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616
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
 Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This version brings along following fixes:
- FW Release 0.0.165.0
- Add w/a to disable DP dual mode on certain ports
- Revert "Update scaler recout data for visual confirm"
- Filter out invalid bits in pipe_fuses
- Adding debug option to override Z8 watermark values
- Change default Z8 watermark values
- Workaround wrong HDR colorimetry with some receivers

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index fe60816653d0..7e3f20a3a02f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -45,7 +45,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.233"
+#define DC_VER "3.2.234"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.34.1


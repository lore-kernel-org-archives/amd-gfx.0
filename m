Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29DEBC77B6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79E9B10EDEB;
	Fri, 14 Apr 2023 15:54:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D4E310EDE0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iz8cN80qn7rEzA590PoQvuZ0iSZhHh/Mq/w7MbTQVEFXTLdqFYyyAdDs13eHTPsplBJ7XYMhKsBkGdJsF5vOSsg22yQmOgoXe6io1WRmnMjMmBL/Trvh6HggB/Yevp6g4onBiqVESd4NWTCIX5tkea64AWunNDuhj0n6wVojaaPOmSw4Hrw+E2dUiC1DogY550DRim0HMA4Lu5FxHZZJ44rbxciGbJynGY48K55Q2C/MdiKcRD5C96A/9qWdlMS9vHwUbGTTK6xGnHldtZXTxr7FJOuueoH//tKDRzW2UkjFI2hlIE5v6691U7l6biJnvrp0sIrdsclojA3/fXy2Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fahlENBEWMO38oxdYCzbi3eb5fpWAN6Q8SeIoei3P2o=;
 b=bUpQci61UsL4zyrcMGDzWhsqStIurdNJGC8miRJmofVNmiCtRPe61pqOVIP5x8JyMX2xq7yVxVT7NlrhlFxy75ybvGp7UDfLrzLmPTFDfupKrACnk1CN2gEI8nptOQ30uiFPVgoBDUn7lf+/Ki/Tp82Eb5DvQtkYoxZQqt6UdN6JONso04LSTBZJIICxeZ+M6cxWdL6J6YpBwYC8IcNQfq0GiBTiTYSvYAXDsAk1BvqVlVyomquse1hdeJ38ltyvjq/O97TyYeq6lnMLL31GQghVKtdMjprPc6ouniD3sH8nEYOU7R0Swr+YGI0pLt6hDFjvBN+KZZkJYyP4BdUz7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fahlENBEWMO38oxdYCzbi3eb5fpWAN6Q8SeIoei3P2o=;
 b=UZrT7AGXsubpHnFx5mtgkmVIsRENli53QGUDqF7ZI/P29/61Lgs0JyLSQR2Kl4JZ/mAm6Ib1RYTL0Hdn0HzSOjqTsr7dKvAH0yKXSSopBBrPj/65jyp9GjPAe/hCVQODhoWx1q9KpmPDTpkL0i5ZYS/mgvMkrwmtyTYkdz/AXiI=
Received: from BN8PR07CA0010.namprd07.prod.outlook.com (2603:10b6:408:ac::23)
 by BN9PR12MB5132.namprd12.prod.outlook.com (2603:10b6:408:119::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:52 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::4a) by BN8PR07CA0010.outlook.office365.com
 (2603:10b6:408:ac::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.33 via Frontend Transport; Fri, 14 Apr 2023 15:54:52 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:49 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 42/66] drm/amd/display: Add logging for display MALL refresh
 setting
Date: Fri, 14 Apr 2023 11:53:06 -0400
Message-ID: <20230414155330.5215-43-Qingqing.Zhuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT005:EE_|BN9PR12MB5132:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f91be3-c77c-4cdc-f175-08db3d00958f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qjl9IwhvHvHRtr+DdexNYaVt1cQ88Josz4k38TGg4qb8y1Jy0+VRQhtgnOfFD0Mgc5RzJ46HQMf8JA94z93p7jPkMjAVAEFT7fdlEOGn5BT/M1yiVd7nn5X+kc4sk3FAvASHgg1mVfWapEr57UWwIxbyWPiK5TlCdWMzMZcIIN2svU11iUwps78GAnRbjPhkXXUFHnOZbtpZqKxTTFADIl9U4wSjRrm4BcspXPY1cbu61UpIUxdzOjbCUm4p45iphUIjCPI7kj8g+W+QFlDOp5UUE4RZh55GnVDM9PpyLyLvUxMRdtjz75xLiN5EhOBk+zJhoX/D2Alw3uJpE3cU5UCF0jmZSYzcYdtUu+IPfywuZANUzZurSN5hArZT4kox2z91WTA+y5JDSaxLhgEDo5mDFwdOoObPpXpQj8S/LONTxr02V7phAD5DDpB9fWGyWSA0cIXmj27AEdCHywtOlkTGeCzkgQiKl/wk85E5hSv0cobYog2sETE+IkCvyY29Z5bxiknVrB4ZEhz4ajMi9nANWRzfbi9sbs84rZIs4ACxB8TQ0rtie5C+iuFG5e0JB/gXDnR92nSUQFSp7XcBrvCrT0vI6GUF4k29Ec1hlUJlxaz1hThc1PQwAKyLdl0azEXxV2QTewe2JkxsJmoW7FqijXg5bESxPbhlQ2CNNiVgWva2jQFb1NPuWGpQ+d95VylCjnsyuzedwkd80D6O8P6XmIMiWS0oeqNz9nWRuDM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(36756003)(5660300002)(2906002)(8936002)(86362001)(40460700003)(40480700001)(8676002)(6916009)(81166007)(356005)(316002)(41300700001)(4326008)(82740400003)(82310400005)(70586007)(426003)(336012)(70206006)(47076005)(54906003)(2616005)(26005)(1076003)(186003)(16526019)(478600001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:52.1121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f91be3-c77c-4cdc-f175-08db3d00958f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5132
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
Cc: stylon.wang@amd.com, Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
Add log entry for when display refresh from MALL
settings are sent to SMU.

Fixes: 1664641ea946 ("drm/amd/display: Add logger for SMU msg")
Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c   | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
index 1fbf1c105dc1..bdbf18306698 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c
@@ -312,6 +312,9 @@ void dcn30_smu_set_display_refresh_from_mall(struct clk_mgr_internal *clk_mgr, b
 	/* bits 8:7 for cache timer scale, bits 6:1 for cache timer delay, bit 0 = 1 for enable, = 0 for disable */
 	uint32_t param = (cache_timer_scale << 7) | (cache_timer_delay << 1) | (enable ? 1 : 0);
 
+	smu_print("SMU Set display refresh from mall: enable = %d, cache_timer_delay = %d, cache_timer_scale = %d\n",
+		enable, cache_timer_delay, cache_timer_scale);
+
 	dcn30_smu_send_msg_with_param(clk_mgr,
 			DALSMC_MSG_SetDisplayRefreshFromMall, param, NULL);
 }
-- 
2.34.1


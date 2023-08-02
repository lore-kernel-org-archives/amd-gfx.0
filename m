Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED208C001DE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 06:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EBCA10E4B9;
	Wed,  2 Aug 2023 06:53:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61ED910E4B9
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 06:53:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsGj5Ud6nvUXj+e5AdNAaSMI7S0fG851wVAoaM6WOy1ZkWNrl5aDBwUgnKXGbBJt0inypobBmbfynKzZZ0CVGxfGi0zXcIcRLEExIuqBKvXneljPo23XHdGvSdhDXzwceBNVOzy9/837GzTZRHoikQIew9AwgWmcdtITG/jo9Wgbdh6ub5hl86tmugt30Brz91IYdRd3d4xkh0rZu5W2Zdr2OIX0+1rVHmv7YObYhk1aDEyJW8qm2ushMI8qRpKuv1Be+dcfUduioYxcwNB42pc2YRwL3yM/HssyDi3/gpEZIHGiNQOFhRLM0IDDeYQtPwwW5MvzoAdhzxG5gCiBVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kN7yhkpSvGGE25uTCW+Kb36DQTTwBvUP3Q6UFmtGOso=;
 b=TBYEgzHAwFuQZwrz+WVvaK1vZHE5Lx5P5UShyunWkcYjei7hZf4Yf1RFEmmzB4A2l6MlRJCgWRMXOo2rs639WkP5I5KwmZGvWYIobiIf6iZS8E/kBEStF7Dt1ro4LRTKXYwzU6VLU57LOICR+mhpr4tax28tk6xqQerVUjGgdKWJTcFUJcUPxAjund99uD6QQsijPGjlm3ub3FuusFyuVt7s6G0OWiqXQ/OA2h0HVrrr/CeTo0pGnbSracewrCt15KVzPR99DTH4801XVQxhJv6DO5Rn7xf+xsoKXAcI0OOaSqNn6nNm4mF2zU1I7phNmM2jN2Xy3fMUPRv3oN77ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kN7yhkpSvGGE25uTCW+Kb36DQTTwBvUP3Q6UFmtGOso=;
 b=jmAMh3Q2amq4at2XNKIx1ffmZ7vSLeqgeQqXYovSlGbuylC7rMXrRFloc6MF07LxbkNpeVW+M59eXBFlAO+oZRTWcoaXEVxeYha/6+qqEuWfnLKIx1IswhxevAxH7B5f+tbc+v82aXD7sipC+J4uR0TFmMp39PDFbU9eFNLiNDI=
Received: from SN4PR0501CA0039.namprd05.prod.outlook.com
 (2603:10b6:803:41::16) by DS7PR12MB5933.namprd12.prod.outlook.com
 (2603:10b6:8:7c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:53:51 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:803:41:cafe::8a) by SN4PR0501CA0039.outlook.office365.com
 (2603:10b6:803:41::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 06:53:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 06:53:51 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:53:49 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 23:53:48 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 2 Aug 2023 01:53:45 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/22] drm/amd/display: Promote DAL to 3.2.246
Date: Wed, 2 Aug 2023 14:51:32 +0800
Message-ID: <20230802065132.3129932-23-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
References: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|DS7PR12MB5933:EE_
X-MS-Office365-Filtering-Correlation-Id: a5eb1805-92be-48af-4654-08db93253ab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rOrs7Wk+Ak8owGQDJuRanvyTI/7vJolN3pYplFSGguUlTP7mffNHXU6/vyxrwXePCjfdNCmaEi/6+A/6U1A3r0HJzQBlz4T2Yd8mdcMHpZkAZBEmwdbcuSG858mE+YJ+CWzyBd7Wq3tYEnGbGGucTmMYJv0ci9FnJxg+ow99HQeHsTR9HUecFkfYvc2HyXv72kGBM2fh/iqyNyqttRAh3MO2rEhcnPoKmQaD6peGSXW1cW5+fh69e6M4AQWt5Si8cOeiRyiHhiq/kK5JYZ9sxuqEH0CCadfNvmg3o0bBqh9QxM6u2NDdR4gkiGpsuPriZ6WXkj7uO1OHHD/nS3n/z3pLj2T54JggTMvnpHpIPw4MVf20gvRV7Xx9nSR0OMCvQbMpk6lACPHfuVaQRbx0kh8ZJc+W2OXnJd9gmXkqWXoykwN2xedqJ0zuMNY7N/scYTrevs5t0lbXdOWnPoyeiOKr0rRwCJoVeaA/5Es5bG9lH1x6WaL+IPnA/Yp/coeq+VvYRg2q3QBZVaUeJmbzWOhRZO1YFUZQmByqh9DGyI2CsEXt/4p9mQg8IKJ3/RDVmlsOurDMOebOeF7cPvEdlii1M9FMmXeAdtJVmmMO4WfSX9jgB1cGN5YVHcPq84PEgfUYMZrgkxZD/JzFPlGWziHB1kYv043e4BMmmWwGtiBq1aUry2tbehvoMfh/Cp/S7ZE0xTIaFOPoveVhVmjjttQ2XKv4aJBuJ/RByqfKCHDycjSbkBAZ8DXaJEsurDdYJu9+8UBjE3A+BJU+Jzd3kg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(6916009)(4326008)(40460700003)(70586007)(70206006)(2906002)(426003)(2616005)(81166007)(82740400003)(356005)(336012)(186003)(1076003)(26005)(83380400001)(47076005)(36860700001)(54906003)(40480700001)(86362001)(36756003)(478600001)(6666004)(7696005)(41300700001)(8936002)(8676002)(5660300002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:53:51.0463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5eb1805-92be-48af-4654-08db93253ab5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5933
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
 Martin Leung <martin.leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <martin.leung@amd.com>

This version brings along following fixes:
- Fix a regression in blank pixel data caused by coding mistake
- Fix a bug when searching for insert_above_mpcc
- Fix backlight off cmd for OLED panel
- Update add plane to context logic with a new algorithm
- Adjust visual confirm dpp height offset to be 1/240 of v addressable
- Add interface to enable DPIA trace
- Support plane clip with zero recout size
- Blocking invalid 420 modes on HDMI TMDS for DCN31 and DCN314
- Make mpc32 functions available to future DCNs
- Change HDCP update sequence for DM

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Martin Leung <martin.leung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index ee9226f3ab7c..cc0a39db8aa0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,7 +47,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.245"
+#define DC_VER "3.2.246"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1


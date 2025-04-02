Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60600C369A0
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 16:13:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4FCB10E831;
	Wed,  2 Apr 2025 16:13:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KtMij5Sy";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F56410E836
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 16:13:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiaGUgKVz6kuec+FwiBft3vyamg86UdnLtlw2HcuV/8GDvFike82++PQ4D2kscx2j3bVICeJxuLxHrBtJy9lnZxQBx2zFX1lO1GSSnY8diHLCeMJoV1S4X8Gtop5O8Z7dbJ2lDxQN3wwsWW+TmI75eVMOxLuBUswA1+Uxw5I3OBrZEZIKS5TYSwaFW89ISEOr3e3FJQcDYvyZopy0JDDic78ngaERrr3vlBZsndkjK5PYfIlxClfXgbH+3h2QzaOY+vJ4Y/T+Nns/m71DJO14PTwTX81T++KWeFOjQdQTJHpQp/eMpwyhpZf8rkUjc1MEQpjkbMdAgmUcCkKPq9QSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVXEj/8A3u9fHh/WxBdPhSWqVVHWfJ3a/jCD5NDU3hw=;
 b=ua0FnXvCbPowVCxJZHO7+goTvpBNNoNoi7gElWjmbVmWnEAFoCixVf0BQElN1pDH0/ndg/5Ih2z8QL645jGvolVXS6rSFPggy1BzAFx9cQMDeTlKTjbLr0B3ZWOXnimuGuBk/ecYiAlKT8co+8hLDG4Kgqy42qncC4JzThW6LOaR2hBIAFK0jyL2vAQpecsKJnHqcfQa4e2xaB8Y8iLi1vKdhbw34+18CHE13mWWPPsVO4fqF9wzPiwQ+tYCRcJqFtKDNEO6s7Hg53oZ6lT2mHPlY9JgSb0R1quhYlJROoB3PzjuVYm8OS5jHi1qVUyVCnY3lADdTu6+IadZl+QutQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVXEj/8A3u9fHh/WxBdPhSWqVVHWfJ3a/jCD5NDU3hw=;
 b=KtMij5SyGq9HDNk/0QpmwrHMNSjwaESTgXU7URJwDksBidgJ1GKjirGwYw+XVU7MVBTO6W3I2ZHV7BEhVAUwIzYLGj8YtVjBN7dxtHy5ITe9Y0rerq8VktO8Q1nq+n4KxuzGx+ZZ6ViP2GR+aU1Unl0H597P8KiZfmWe1wmefj8=
Received: from CH0PR03CA0394.namprd03.prod.outlook.com (2603:10b6:610:11b::28)
 by CYYPR12MB9016.namprd12.prod.outlook.com (2603:10b6:930:c4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Wed, 2 Apr
 2025 16:13:53 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::30) by CH0PR03CA0394.outlook.office365.com
 (2603:10b6:610:11b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Wed,
 2 Apr 2025 16:13:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 16:13:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:52 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 2 Apr 2025 11:13:52 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 16/16] drm/amd/display: Promote DC to 3.2.328
Date: Wed, 2 Apr 2025 12:13:20 -0400
Message-ID: <20250402161320.983072-17-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250402161320.983072-1-Roman.Li@amd.com>
References: <20250402161320.983072-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|CYYPR12MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b428af1-f102-42bb-9521-08dd72015ce3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9+ojzX0xx/cqwFMDqtuKzZVTUveQhzebDaoZuQTM0tElGuQr4ROerq6gNqhA?=
 =?us-ascii?Q?3dq0TlowyUPOnKcPZ96INu+FMzWtBp8Q/r0vSgfenO0+SutiM64s1iRshkPy?=
 =?us-ascii?Q?daQXosbE4ozxf9exW998ImVfL7u/q0l0Pz1vr0GjMx6VEB8uzB7+wQvNQY2U?=
 =?us-ascii?Q?4LwJ8eSZ174QhPvz1nJwmOZOyV+VVZI1t9lFKV+PgSEiiHq9+CfMB+LXe37S?=
 =?us-ascii?Q?MJsc2+H3bwlmK/JRsFKbg4Be+cSCgAV/2RgfaonmW4bJRXdLvmWXhQxlfFlq?=
 =?us-ascii?Q?a3kTvQV5XxZIDmLiZtfBkLoGtqvOUgTmtvbW3uA6IKdz2A7/wUOjrG1LeGrZ?=
 =?us-ascii?Q?K1KxSRs20NoAFa6OJtol0m9r8U+ajQk38au8uWpvlx6uRo82IJVJ7trJSdUO?=
 =?us-ascii?Q?shDXkbH+CNnnvwLiogdU+W0xo07yUVkN5HwosAagm/o2j/af4ok7t8WhEDog?=
 =?us-ascii?Q?W44nN55RsKNaDwb5xHfV6diIdzV/+g6BxmCUT9UcbBEiSs+5dBsRv0GDULKb?=
 =?us-ascii?Q?M5ps9rsgBUySyWQ8vgH0SZhp0fOYJNeHcgDMucndeF57EPVvgpTcgC17tLPB?=
 =?us-ascii?Q?AwprpbfoWucBslPcedllkz1EPukI4DY6LcmqBMACOLnYtLgo7SjRi771Y+ZR?=
 =?us-ascii?Q?HCE0Q396/562nBehrRjn6SCNb8fTxyAwjeF2LkHemlxhL/bQNwX1NxrzYwsl?=
 =?us-ascii?Q?aXjrxUi1IvbL1Fco2kA7Snlxq+qZtHq+lr6IT0XqxlEnel/66Egk9aAusM0/?=
 =?us-ascii?Q?oUyv2BzgAmaO8l+HQW+c8fn+pZGuBhMOg+PHw+UnevWsN14GZLzvL8rBUxy1?=
 =?us-ascii?Q?ZPHHJu3GLe02Vw5OWFOkwH71W35NQe4G1H0bDvxKuji+Srcp0qS3KbL68l5x?=
 =?us-ascii?Q?Iqlc1r82IuVto/Ecri/mbmufB4S3do+uPzWDa3l9JVCH0RLVQHzHcL7Z1cmi?=
 =?us-ascii?Q?HlTf1GHlhy4JCYBrPdIkhVQhy1FQd3/ZUHJ7JGZg6mvqvtTG3ukSz9z/G31V?=
 =?us-ascii?Q?2oaZpzO8nqjgOp3U7UvOwGvofk/4t4GkHSpG9/+lXXRbSnKAG+rBrHO38KIk?=
 =?us-ascii?Q?NlY+6Q8/wj3jYPbhQBkTNQacZUy9aQOCPD//K2yGqJNUhkDSSkogUDHR+awT?=
 =?us-ascii?Q?LuNWaaofz3fRbc3m1NF63gCuHcwcskQSSFfyIqMHxWcb5i+hUWE5o7ZmBD3/?=
 =?us-ascii?Q?mQWTIJ5PcMB9zXJr6x62MamSW+NiKJI1SZqDjcHhMdsn6TCVLoU+GhaZzpya?=
 =?us-ascii?Q?jnf9G1ks17/FXyVu7TQDFhVrupubXKm9LYpl3FasD0kAZdCfh6YZaIORQpad?=
 =?us-ascii?Q?yurDY+PmIN7RRBzVCPpEDJI++7XeHQk0irfGeAqCAbxNCuFvbq2PLvIWuj2h?=
 =?us-ascii?Q?Vk/SD0Vnu9INqodo7R7m6GeN6Ty++gU+/xDBFRdId0TFN+ndR4AJOMwwze/9?=
 =?us-ascii?Q?hIArYLFei6AzSlRVq8fbc7nhr9/9gkkkW2Lk2JpmZmOuSbHeVAMXbCLXDlE5?=
 =?us-ascii?Q?jbOqxOfE/rOAfEM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 16:13:53.4805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b428af1-f102-42bb-9521-08dd72015ce3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9016
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

From: Taimur Hassan <Syed.Hassan@amd.com>

Summary:

* Add DCN301 specific hubbub init function
* Optimize custom brightness curve
* Correct SSC enable detection for DCN351
* Turn off eDP lcdvdd and backlight if not required
* Use DMUB Fused IO interface for HDCP
* Extend eDP-on-DP1 quirk list

Reviewed-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c989bb9798dd..7624b909497e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -53,7 +53,7 @@ struct aux_payload;
 struct set_config_cmd_payload;
 struct dmub_notification;
 
-#define DC_VER "3.2.327"
+#define DC_VER "3.2.328"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.34.1


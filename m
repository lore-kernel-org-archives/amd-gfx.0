Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7019C30653
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:13:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D679F10EAC0;
	Thu, 27 Jun 2024 21:13:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kSpJC8Sg";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FC8010E4A1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:13:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uof1oWD1PDdi7a1+QW06YW3kp58Ezqu5Mfl2fE7Brr4dMVA+9wGrpVMAX4Wn9su+UTqAkBX874QB5MiYc+2Uq0PttAFofs8Wcux2MY8vqlgeGqUxU+pesxrCUoIv36Le9ag9o/ejvijh63cnHrue+YhS8501eCFfsQldlSqJSRgSCYO/McwL70wPY8RCCer5fA09I81aUB/l7AvN6kq4aZVq2FFDd6ZLCT9CLmMCwWTpkgwr8jHOazMkj1cvh84wC1ywXVEJ03zg8+wOV8luknrJQRU+PTB2hJL9XK/MvOqOE7zP0grtTrVbW9qlrTIlAMlEHPQ7hnpsX0ilLx3viw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vp5BTBHia5oX/CZhL2H0wWj21sOcsQXkurYwm6n4cek=;
 b=KneGO62AmySds/4lFY7pS8Otu5nDEitaBjeB+deh1W5zWQM8y0dbnkMFlTK+gP13qIG6b10J+TAGP52MPPKQxE6gsJTeiyyDBTwhZpQLAh03ayYCKmM0amS7M9hMSlPHvhtAWWarRaW7W1p+RljCGa3EoHUXBGEYcIdaB7gXwQZ4f7iw3fbDVuzD5zZGfZx2Tu7qao8jzv5or3DQhYfv+JkymH07l3jxkAEFHbCxoRKW+eJf83k8CFtGmqnEvkrPkUzqYVZ/E9t/TUgXDubbFZYwI8J6MXIak/hx7wThAaYv3Rs+38GAt0xKmI6iwGMh5+GIWrqsvLYF0UUgjRCeyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vp5BTBHia5oX/CZhL2H0wWj21sOcsQXkurYwm6n4cek=;
 b=kSpJC8Sg4RU383plx5f/lbcS0sNU+pDjG+eAhny4lO3FlHjZIOEGYlt+52n/ZxtThCtG2aEViAqDMg4hIAvpstZYzN7LoMnuN5i7OJVbsvT+cXLt7KHf9WfFaTHONwGl1MSA6758rFrgAdC56ojvnnjOLFXoau9+n6RrxBda9xE=
Received: from BN9P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::20)
 by DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.26; Thu, 27 Jun 2024 21:13:41 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:13e:cafe::bb) by BN9P220CA0015.outlook.office365.com
 (2603:10b6:408:13e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 21:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:13:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:13:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:13:39 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:13:38 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Anthony Koo <anthony.koo@amd.com>
Subject: [PATCH 01/26] drm/amd/display: Add replay state entry to replay_state
Date: Thu, 27 Jun 2024 17:13:04 -0400
Message-ID: <20240627211329.26386-2-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627211329.26386-1-Jerry.Zuo@amd.com>
References: <20240627211329.26386-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: 491121c7-40a7-475e-82b6-08dc96ee054f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3NTohwz1Zik+dPjhBZ62eNk/uuXnpp5X8Zj9PRIKx0Jp8sbdLMGw0Fn5hN5D?=
 =?us-ascii?Q?j+OIXRaSqsPDsxH2vNCa7zXVSKVgQsYBO+mBjtYPrRrcQohmapImqv1Pw9XP?=
 =?us-ascii?Q?uxRZYt4ebtMGozo+4j48T/quV4IP6nj/MH7hkNlksvtf/RyS6EQnvxBOIUrz?=
 =?us-ascii?Q?ac8Rd/sV8bBXrZFDINikRkLlfkiOZSty3R62cH8elRHADUjrW3tAK8J1jCWN?=
 =?us-ascii?Q?lakjDsNP+xNbgSdnE4u7ewvtDh4OV64p7w4Im2e4ijFhT5k3pYmNQruEGHu3?=
 =?us-ascii?Q?+pnJAi0dltEvfX6h4rgBTnZa8HJoZP5zz5C1i+wWHCIisjgR/T9Hg+FdM0RY?=
 =?us-ascii?Q?/Ot7gG98h097KECYvMiJgFURAbBg3OmwNeBaIOLy2vcQ1HJoInqviPW/L62d?=
 =?us-ascii?Q?IMZLH0darJmTrzNZo9JtGyYSyeWvkGQSdkr583Ag8nxrGNOTqwDXBokpiXKC?=
 =?us-ascii?Q?3NRIPn+Fp+SBga8ACZItt1XG1Vn0lcr1+Ik2/apGjzog9yCw/52y0yEXkS0X?=
 =?us-ascii?Q?gOynYYMovirc445/MVtXota9rekTqeof2K4U2oN+Tuw+0l0B/rRHsxi0kVR9?=
 =?us-ascii?Q?60Cdizcc03gnUNrp4d+JTx8/4TJEVDQ/bW9AfFFmBlz/MayoFMkCi7ky1IAz?=
 =?us-ascii?Q?xYrp+fn8u+9wVM8CGTk3XTm4sp+3ECsZwnoezxuL3Y5axVcH8W8IbH44tjeN?=
 =?us-ascii?Q?hxD/mk10OsN0tOt89f5jvS8LLXUcK7IG5bhPAyHkItljABczPRt5xCLuf7He?=
 =?us-ascii?Q?jORtLOYY6RVCxDJRn5rsxLEkJMk7pIB+zbzRMOEhr46K4qD2qTLYT4kin4BL?=
 =?us-ascii?Q?dCkySicouu6lKb8m/rnEpl6Y6n1c/FpG37hFaYPmb9FX2bR1p4O42wz0pRG3?=
 =?us-ascii?Q?ElqRoiiLg2FX5aUV/8GICLHpl+sNzC7NFFRxUrNRpxTYTv28i03vRKR3bwF4?=
 =?us-ascii?Q?bPT4TbOClSTTX5a8qDuPIWobgGpQeUvZWas+HboJDaefhKpuGehycVhFV4Nz?=
 =?us-ascii?Q?t12uV8vWlugrpuVop8JLfzf177POvvQXoCAYciabqPGb3ovcE5vmB6xbCBbe?=
 =?us-ascii?Q?ac5L2CU1fWTaQBtAVO70wz6V7enEvti+tP7eA9yikypy+UtGniwVV2QJCtTL?=
 =?us-ascii?Q?FVeFgEdaoo2X7xLUHzrtdUmrN7GiRlyjHMH4WgF2iYdZ0kk7h0ZlQhBC2NbD?=
 =?us-ascii?Q?C92pZPJxFb+Ja8fjO8fArK10EkjESAzlxUdfVrqjkplW1vUmNjtyXaDG2fHv?=
 =?us-ascii?Q?Pu5kHMHmF5k+09+amsrPWyzmHjHoarKd7iERBp48fJTIu13tyhW+4GnoqqlZ?=
 =?us-ascii?Q?px8cWfmwiBbMy2eNlA7lZimJKV9DA554yFmsRfkkldDWGWir4fx0akUulqWu?=
 =?us-ascii?Q?hoXP3Zz8kfo8BxbMw5uts3Jm7dXZFHTpG27553z3cMKdEPv4AWofvMFOU/UU?=
 =?us-ascii?Q?opZFi8eLw46dgeD47awGiR/jJgJsAjc/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:13:41.3372 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 491121c7-40a7-475e-82b6-08dc96ee054f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072
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

From: Anthony Koo <anthony.koo@amd.com>

 - Add new Replay states 2A (initial Replay entry) and 4E (frame update)
   to check is there is new frame update before sending

Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Anthony Koo <anthony.koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 78e8698fe378..605dd9d45167 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -3326,6 +3326,7 @@ enum replay_state {
 	REPLAY_STATE_1			= 0x10,
 	REPLAY_STATE_1A			= 0x11,
 	REPLAY_STATE_2			= 0x20,
+	REPLAY_STATE_2A			= 0x21,
 	REPLAY_STATE_3			= 0x30,
 	REPLAY_STATE_3INIT		= 0x31,
 	REPLAY_STATE_4			= 0x40,
@@ -3333,6 +3334,7 @@ enum replay_state {
 	REPLAY_STATE_4B			= 0x42,
 	REPLAY_STATE_4C			= 0x43,
 	REPLAY_STATE_4D			= 0x44,
+	REPLAY_STATE_4E			= 0x45,
 	REPLAY_STATE_4B_LOCKED		= 0x4A,
 	REPLAY_STATE_4C_UNLOCKED	= 0x4B,
 	REPLAY_STATE_5			= 0x50,
-- 
2.34.1


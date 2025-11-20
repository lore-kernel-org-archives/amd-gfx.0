Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D34E8CF9C7B
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 18:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 758EE10E7B6;
	Thu, 20 Nov 2025 18:19:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x6xvKwK5";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013017.outbound.protection.outlook.com
 [40.93.196.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E35D410E7B6
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 18:19:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqyMDpvB/+H4h6rjMqZnHwOHoGYIBydhd5DhHAlNyQx5omGnHOOvYlT9GFuhPerbs5dwGmXXv4XdGJ9YdRwLe8/ANbHbbW3Uyu6U2Zt89S6yMk3yHhitL4SipZRv7F80bBolEg3N00gcIVQnlu8hfHN9DzU1XL8QsblelG+bn1o5W5X8UM+9q+PcdGW4aaqbAm7ANIGGhP2ImtSLdmtSS/2ffpDB9CAhNsFGod8GOAvXPbvCYK/FjEq75/yGf/n8Gn0vJ5y81TPyBwyo11+wlc6S6wfPR27JnRMspPOO180hgARi3UMQfIi+b86UBEbVx7BdH84l6wfuqXlHT6dLrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHdRMOdLL/SX+ljcfr7SOtO3Z5piiYKjpSTaxMd8rw8=;
 b=BOvqjxo4Feg9HsswB0L2U7u/0ibRDeNkFXAWnUrXUU19e8nLXDtXqPSRANrAfkcwbQvGiMlLRBU5jp7CJpqT3XHT26GDqEJCWlk8ugH0SdvqE4j2S0FARPCduVFmtuZEBoXQLnMF7QKiZ1U+bdqQoujJ8F8xIAUU5KqZu9YTD0qk6lBIBhkfJDS9NfhCg2d2T9YLI9kgLKHBIw/bapxDFkY67s0e7vRexgy/VqGE2acNrmAwCmU2oAEA28KvTuDm2nIBN2pTTeE5RW0CFoNkxVnWI9ggg3QkHUYGH+VOta4VHlDAXsBO/C+zJwREmte+vfsv+lrdxZM5fJr3nlCqpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHdRMOdLL/SX+ljcfr7SOtO3Z5piiYKjpSTaxMd8rw8=;
 b=x6xvKwK5jHafKvN9d0etj5OSzcnLkick6KyM6kQe/5EzlOygcUuQe/D/UTlNjGmdNWvgH0lA/ptC9PeFqCD9JEJgJsHc2uuGkPcOeAZ4KlbQWscxpfOVWBYp9RRc2EwwI2GKdL58v1jd9wFPcDm+1Be4iHL1GzaPixwO01WyLbo=
Received: from DS7P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::12) by
 SA3PR12MB7808.namprd12.prod.outlook.com (2603:10b6:806:31b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:19:50 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:8:223:cafe::36) by DS7P220CA0024.outlook.office365.com
 (2603:10b6:8:223::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 18:19:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:19:50 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:19:48 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH 12/26] drm/amd/display: Drop needless check for
 link->link_id.id
Date: Thu, 20 Nov 2025 11:03:08 -0700
Message-ID: <20251120181527.317107-13-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120181527.317107-1-alex.hung@amd.com>
References: <20251120181527.317107-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|SA3PR12MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: b91b24b8-2458-4983-f828-08de286164fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xXofJV45NWqoa37dKcEa1kgmSM8jDrZhLz0bkFw7+yQx68B3sEdFWVh8OfYy?=
 =?us-ascii?Q?BalFf5mFn6u0bK4uinN3uy8bbcQYFLk9luOuLah6zO58HN8jBHuABI6+IxQJ?=
 =?us-ascii?Q?umQuDxaiwcdvshW0p7Y2WwBu8eqSerjE+q7qsDKl+Qa5liprJ3QPbwb0k+fx?=
 =?us-ascii?Q?DFUhzKWK89LQK6TlDLKglF6A/73g+0RmEG2eaux1KYRsjgMkGRjI9l+TkerQ?=
 =?us-ascii?Q?g6Ly7836udFcYG9UOj7RCv7C4eMQ7f1HvOAwCPeDZ9/oYKV+v5xlCiwjwc6C?=
 =?us-ascii?Q?yto4vPpLimeVON5CAt0fzRqqoirC3ZSdr4nsFOiHBf1DEyTk8YqBu9ck83zz?=
 =?us-ascii?Q?jqZoveKt+36+Cf0OkGPAQiOKuIYoAeAnYddPOmGB6/iMqm42E3pfqn+XLzIR?=
 =?us-ascii?Q?cN2PuSm4krsYSb9M5SZsiiLItKPoB2fdkqLk9PgOIYNlRtn89hbtUiLHWV+x?=
 =?us-ascii?Q?OI1RsVp5ZIs2N56BFFaj6kTdSrxIoPtTEZdrzOklE+bMa3Etro0CVodbjR28?=
 =?us-ascii?Q?5grFSq0QEOZsI280FrhK/bLk13AVVdRcUUNeAHq5YExUKkD6TvfBW49x68V9?=
 =?us-ascii?Q?33qmpGohdSUzyMKy+ge86Y8L6VG6j8HviRoGQWtfFdKtNG99EJHJQipOsMUu?=
 =?us-ascii?Q?dYeGLW2SpaX3ceNl4QLPk3eF00f/P6JUzQkBEOCEUkSGIjr2EOK+B1D40SrG?=
 =?us-ascii?Q?t9rOvKx/UFVi/iVv9mn19qcrdqoVpC84jH/T5gC6QZRJZq+Zjx6E0k5aUl/G?=
 =?us-ascii?Q?FshZXPrYQuk9gRbtgJ5H2pzj3IDEjkvXvVO/cYvppblN4PSKCftw7vxTE7HX?=
 =?us-ascii?Q?m6CU9WIVar6TlYmidqT15pVXi/nADwhMs2d/Jc05faQZzmwps9nCw+eSQuGh?=
 =?us-ascii?Q?KY2veqBodRwgy6Bp2VcCvJ0zBzv57pNe8OzGuz56kf1oUgUg12B00v1kFUPY?=
 =?us-ascii?Q?9ZAyRDSwe958rPwGj/Nsx2NkV8DMIQltwzaBLS4kklHBxx9cXITEBCehqWQH?=
 =?us-ascii?Q?OdBMvDChXZBbd4UOS1qZ7mwpdPtdW3uSjVYRvBMebxhiw+3DSMCIANoDU8Fi?=
 =?us-ascii?Q?S1awf/nCqOfyMsbqPfMmaLPdYoIZcOGQ2J+wVVnVPL1YIZiufOGmOp0fVEwM?=
 =?us-ascii?Q?tG+hdzk7buf2/zQGin0B1d8rpv/GFgH9d++7gJicOMJAFO8nrNN4NNWeThjw?=
 =?us-ascii?Q?uorovmmvsYl8S3xIphNCHCZfiRO3Nzao0z3XM8kaOykaM/9YPAlxcFk4zEby?=
 =?us-ascii?Q?qUh1hcbF4B4thW+1Afm/eefdTiKdgM/mBXJVIOMwlO4xrUFuWnbN8mV2kyYJ?=
 =?us-ascii?Q?tnApXXb3m4ElmtKF2XwUzT0Ujv8gowWrSAnH2uKuNDJHQgHM7qH4NquU7ETl?=
 =?us-ascii?Q?O7CUsHHhqdeqM4sh85Oe4z3PxkltGqJdO2LA2f+9zpbopzkooAJ9r0gkJZcK?=
 =?us-ascii?Q?koL4a0r1JBeLs4GGbZUzoUSaZVF5LT0+UpJXsUb3T29Uyi4T2vDdKBY6wMpG?=
 =?us-ascii?Q?1gP25KfZHL5mp3b5OsPRxV6YrHtE/pwENy/Bub6pYcdC24FBRt3JXmT+7J8W?=
 =?us-ascii?Q?IOem+0aC/YrUi1pQVAk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:19:50.3514 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b91b24b8-2458-4983-f828-08de286164fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7808
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

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

[WHY]
The switch/case in `link_detect_sink_signal_type` already detects the
link ID of `CONNECTOR_ID_HDMI_TYPE_A`.

[How]
Drop the extra match.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_detection.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 7084b1909445..e0402a04f25f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -209,8 +209,7 @@ static enum signal_type link_detect_sink_signal_type(struct dc_link *link,
 		aud_support = &link->dc->res_pool->audio_support;
 
 		if (!aud_support->hdmi_audio_native)
-			if (link->link_id.id == CONNECTOR_ID_HDMI_TYPE_A)
-				result = SIGNAL_TYPE_DVI_SINGLE_LINK;
+			result = SIGNAL_TYPE_DVI_SINGLE_LINK;
 		break;
 	case CONNECTOR_ID_DISPLAY_PORT:
 	case CONNECTOR_ID_USBC:
-- 
2.43.0


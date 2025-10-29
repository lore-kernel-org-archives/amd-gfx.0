Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA4DCCF9EA
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 03:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB7D810E0EB;
	Wed, 29 Oct 2025 03:12:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bjCiKLzg";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC9E110E0D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 03:12:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7u4Mz2ZZcjO8OYBjwrwjwcpR4KCxODhB71d9glSxdkHWr/eH2Eey46EESFOOmUsLyiyuB2kfyvOyaNoGZDDplD/1jugjcvx0unfxlh0mE7+f4DmAHofkfAtWooewKwBY4vMcFhd+GoWMJ3DbCDgPpTirZxs2Z9r7B8V8cx9+9Bt4NW2YtY8MH1VqPdZJyxHjSIJub47EJGTfHx7Kt1nmnvtRzGbMXXViV+6GU1lYgAGXYys9s9xhWYMZjD88YnUIkf14C4zg1mhj7v0hodEBO0PTk3rWGgo+PmZPG0+1R/e6TrNzjo0q/2i6NeaHwo/tpSG7udug1N2bn64fGOkiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnG6Ryl7DGHfmUBkQLuvqx8m4i1PBPh9qtILlgzhDlM=;
 b=eNr23H9FnzZEC/xNx/EWjFzoy6kHKUp+tB8hTdm00s7f4P1MqJ/5MXoEc87u+YyANQ/N8/QBqfsFtQp5FPda9wW7UmrNIGTBV0lugTs8ObljmqYzFgFa2PYM/+3Wo3HdMfmP1tEt3YBTj2fuKspL9ldgC0DHrcy0aIV9NJ/4ONVbR7OsgZCgT9sRE6Xgu41fJrZM0e+oUZ0z//jqlQrMitSepvxRqcL1I1Z/S8raeQLYnKLJvE+5x0I4RjxhXx/2J6cjY25jOxIXmMwRmv3qkxW1V80fQEBopf4rW1DZRhU2QWzR/X5LlL+otMua7d86/jidmLnrDLHOanebAtEa7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnG6Ryl7DGHfmUBkQLuvqx8m4i1PBPh9qtILlgzhDlM=;
 b=bjCiKLzgJukpSdhI7Mk4F1cyXU+kTsm9p3U3w52TZuy2ocbAg5/b5uu3lz6f3ManIxQZxpSmcepuOXoofhldv/lxGjkG0e9Y/2U35f3fDvAF0AVOzMYqUa4PQumwAecqaYwmxpr5C1fCH6c/IPf9lHqPuMH6wduCbBpItE5NmI4=
Received: from CH0PR03CA0443.namprd03.prod.outlook.com (2603:10b6:610:10e::7)
 by LV5PR12MB9804.namprd12.prod.outlook.com (2603:10b6:408:303::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 03:12:17 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::d8) by CH0PR03CA0443.outlook.office365.com
 (2603:10b6:610:10e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 03:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 03:12:16 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Oct
 2025 20:12:15 -0700
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 28 Oct 2025 20:12:02 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 13/13] drm/amd/display: Promote DC to 3.2.357
Date: Wed, 29 Oct 2025 11:03:01 +0800
Message-ID: <20251029030935.2785560-14-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029030935.2785560-1-ray.wu@amd.com>
References: <20251029030935.2785560-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|LV5PR12MB9804:EE_
X-MS-Office365-Filtering-Correlation-Id: 154bbba4-fbc9-43ea-c702-08de1698f6ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q2k+eC6OUDV2XhiklgfS1eulsPCsoan5uQR06qm/Myx9+P0BgziGrxG9Weoc?=
 =?us-ascii?Q?0A1vvRMygfXLwcL6H7BM3DBz6GG4qrzZuokCwOHBDbaqFn5YvVVMR19EVUwX?=
 =?us-ascii?Q?c9mbzCWRSEf6ineRwrhKfsirvtFRXQUv3FvEXi3cVGzOhEXIX8Nynra6uZUQ?=
 =?us-ascii?Q?QCuhaa2EphboUBo1t+1PBiyIk+oD1+kWJvXRdN5S9zeF7m3DJEPYHFCB7jJw?=
 =?us-ascii?Q?mbaMvXdfQ1I82x0RWSaZ9MgazGazKgiJw7PfKiKpKY2Gg7CUFK/45U93eRKa?=
 =?us-ascii?Q?96nYD8E/sSMMP30OJ60FdZxxRZOUTdCH1hvON3tebW63rkf3zjGsuSkHVvz1?=
 =?us-ascii?Q?foEoPDLwiJfC1PPRn4Seu4hVeEF4TTxNrRluiCgh26LvnIK71zyEKJSLW+jR?=
 =?us-ascii?Q?HLY4D3foSvrMHbRNxEYC7RPY1M0LBTOpmxMsyGgTjTDkT29re4ZyAv6DyKFa?=
 =?us-ascii?Q?MOHNyG0FsW6W+BRbKm+2bhq5crzkXW5bSc/MkqncxITHdjsOfE98vnHhMqmb?=
 =?us-ascii?Q?dbe1sy5TSEnfEkG64DMYbIKXvggTpBSXXJwV8+X416yecpIjFUedllSvu4D/?=
 =?us-ascii?Q?LaaufdAYaHbfb3oxmLAvEr5PCHAlo5iwgIjZcN/6xBiXgbORPy0oekmrCEdz?=
 =?us-ascii?Q?0nSquoZIppGrBp+/rEaro9iXFqqJ9oYamsjgkJIbCq4dEr+dRWoUyZNvAJx5?=
 =?us-ascii?Q?fVFhW9/JvXt/oB5myZ6rAXPyppNOW6hv29unsnFIuagcVLV8vH+V36vvhimc?=
 =?us-ascii?Q?p5mfcq2FR9Y+HCuOnaZ6RdxzsHrEOEOcfPfrOg7bU/UIqnX3D2wx56agLpKL?=
 =?us-ascii?Q?6HrOu+ALG92tdnvLTJ1Jij+cUVb/cfIUp0tckMBT4OvSSLs8C7AjWXKzhinK?=
 =?us-ascii?Q?oj/byuPdopCej0AA/EK8r54x/1lCR1Ses14Jk422EnvN1YLXUF7ob0gAMwj5?=
 =?us-ascii?Q?nQ6aUvE2j2z1uAqKH08j43WeQgsJ3M4zMxw/b65vaLND1iO21tF3K5QO8y9F?=
 =?us-ascii?Q?hDqI9nl7Xvdm0w1x77uss4Ys3D92Qt/ajGvhgCC7Ibiq8SNymYZ9ZptSH8OR?=
 =?us-ascii?Q?Ywzi0kKirzrRJLtwR59fHoZ7ViMqS5OvmqZkQaPaN/R96t6vmLbqRprD9Hlr?=
 =?us-ascii?Q?rklBDRXpTjF220QeHw9EYQzY+abGFkqaUQUNwboJkPcxpcWJRQO7lbYg82c7?=
 =?us-ascii?Q?nQ7NEk9FYrV1Q1slCOla00bSArJ/3J6o1xDB85yUA6LMRILW6YVur8Ztd6C2?=
 =?us-ascii?Q?fjPSrMBE+SYopY1E7Gfef19hWPLv7IH2D8EZNdkFU2WmGbxU15mNG/KqKD1O?=
 =?us-ascii?Q?1Uz9kFcVOoo7AZogbqvKioOvB6NUmeLOJUzrhaGg0iBQGo987U1fmwhmFA41?=
 =?us-ascii?Q?A5p6qmWXAXJ8civX0zDoPbbVk8WwIixh57RatY5DLNyaR4yjNk7GlfUvKfX/?=
 =?us-ascii?Q?MCZhwinmM4a30QmmhCngMVW5nXCqXLoGtZ5OZeokArBKl881ToDKtUFOiq5x?=
 =?us-ascii?Q?YqJP3L7TkCWax7e0JYQGCsg1IyacyH6Kg/mJFOVtrDf+TYPx7WbRTTl1zMU1?=
 =?us-ascii?Q?rc2IDQaRmwXLGumvqFs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 03:12:16.6391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 154bbba4-fbc9-43ea-c702-08de1698f6ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9804
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

This version brings along following update:

- HDCP2 FW locality check refactors
- Fix black screen issue with HDMI output
- Increase IB mem size
- Revert max buffered cursor size to 64
- Extend inbox0 lock to run Replay / PSR
- Refactor VActive implementation
- Add Pstate viewport reduction
- Persist stream refcount through restore

Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 75c7339bfb5b..5c19df8ef641 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.356"
+#define DC_VER "3.2.357"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0


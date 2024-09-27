Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93180CDD1BC
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Sep 2024 15:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D15010ECDE;
	Fri, 27 Sep 2024 15:38:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0hzvFcmC";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43FE910ECD6
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Sep 2024 15:38:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltQMwPewcEzO1Jmpa2haXJtqtYJ3w4gjkryAUGdVSvRW5XlDDfTTHlLyDa/M6ih46yqUBVnezVBp+4gY/qIJM70gx7YQh4wQ7qBRQdnO1Ak6v9wrSXcYUMAE7QMZ2soNbskMYJmWd3L9RxQ32m5l3ugE3BRdAlNhDQSOvJGEeX96ZBRz8S998qhgtD4NZdOanCbDlhAldnrjjwSZLdj0rDvX2eKGZ8DnqAwTSrBGLgHk3aJKvJlPvDWFPUkdahxjCA+3bldUa9dLUBE9m/PAAvZZ1D9KvLIb8wc0TYi1hLRkThV4EY6r2mcPZXbMI01BC5esoaUAIqIy6bSlecz9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwCESP2E1Gg567Hj/xJDyS3Rz6EcCahc78HvEAVKzaU=;
 b=VumRhlswGzqp2h5nJlCDrMrigCkO8jPvwnecAz9ep7C8Zdzz1baggEJpK2Ak7vwCtvjUupMvRfS5CDX6ezstwRd58Kr7CYvuDdJNo56Vi7mtTfQUee73V/UO5mxPllLio3Bg68DOvFW0aEA3TC0t7o24kL1sydkTXW5k29TqyxmYIBv8kvefC9Lh9D3gXgeufDnIzbTnESgFzSQPBSXSveJkuy2aRfoOuCl/c4YOoeCY49Ompcj2ODMsId+Jbdx4bEWNyi76Jq55HA9B2R6R57I68amhEnNp+XYaW3iT01aUtDUCVmuQlMmsPlT7OT9AXv8aAzCupoHYocCjNW3PiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwCESP2E1Gg567Hj/xJDyS3Rz6EcCahc78HvEAVKzaU=;
 b=0hzvFcmCB/n7Xal6XmuyD/PHqf8kFo2/7cHTin59kT+kQ7wx7DqU87A7cQZmp3f7Fbpy1JB48SXstlhf4pi6s3msJNhGshmjuHApZsms836xy121BcMm6VYP35CGcW45xeIZ/FPgLTzhvmD0U1PvM7jR/yuNzb9eRgYWBW4CmFI=
Received: from MW2PR16CA0064.namprd16.prod.outlook.com (2603:10b6:907:1::41)
 by MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Fri, 27 Sep
 2024 15:38:03 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:907:1:cafe::2b) by MW2PR16CA0064.outlook.office365.com
 (2603:10b6:907:1::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Fri, 27 Sep 2024 15:38:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.0 via Frontend Transport; Fri, 27 Sep 2024 15:38:02 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 10:38:02 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 10:38:01 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 10:37:56 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 00/13] DC Patches Sept 23, 2024
Date: Fri, 27 Sep 2024 11:37:07 -0400
Message-ID: <20240927153720.99916-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc1911c-c8f9-40f6-34cb-08dcdf0a5fdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OBBCwziv9CmcSNs+j6OQTLoWtiSekWuK7uNJaUlsg0I3+oz+kLcwEJEVZ3I7?=
 =?us-ascii?Q?Zjt/NOffAEwdFAHVorcTxSBboKIPff5OWfVhwuo9kNX62mteFqMpqku3/iSZ?=
 =?us-ascii?Q?ebB5SiqWaeUfgBz1+F5z200Tfdiy265JfbXzjLqdDCURR+RwT+zc/6u/4bvP?=
 =?us-ascii?Q?u5ToZc7uQ7az3GJ0v+nXjoA1U3IRyyKrv6DdiDjiVVXneWNguaV6PxaFaOXe?=
 =?us-ascii?Q?lR4QizFhojUUgvR08aLbcfk2gxqOmBDGpnE07WZoozlOYX1KQK4nREqKSbg+?=
 =?us-ascii?Q?PoDjfWn+jSQR8jHCMpp9lLoyyX/TTof8j9Qtn3j09JvjBfiks7Qja5aBeBV5?=
 =?us-ascii?Q?PmlsWcwd4mdMcMQxvwDgNnYEwaO7Qjkl3m76+iI9SBrXBBHwZK3sf7IoSym4?=
 =?us-ascii?Q?6yTHE0OofFwEZoa/YtJxSE1Sl+7szbwjusiVCBOQhbYRye7q8byT/b6i/m0k?=
 =?us-ascii?Q?gq+Es/UE6OvjtMQQJMbC+apzvrr3KRJBmuXu/AEH1Zm92QSRE9L0NrkeqQvr?=
 =?us-ascii?Q?q0jYdhlKoblqieayGpYL3Urkh3rztbn5nfQvG7frRKaYmM4p6lnKUuDHdJF8?=
 =?us-ascii?Q?6uUn6gErIyM8qNqw9+srR5BjdudiAxpD3ICCm7yardU4Tkk2MKjai2CCmEJ3?=
 =?us-ascii?Q?goOjgTJ8e7bvoPU3cAYlkZ1K2aLHDTSWhUnOYL3ZnWynzunFSxgAAllBdpby?=
 =?us-ascii?Q?fcGjM3CTwrXdkOp9yrrwk8/+LYcuqSnKk7BiZPVTcn9+kacDd0bsEZ7KWYDn?=
 =?us-ascii?Q?2l+QIfwHVupX7mAbnQKFQUY+0HG8polNnNgXj4WpNo12z4n+wUmMi+ZjZN8N?=
 =?us-ascii?Q?Tg8gi1ONoJ32+Y13So9iTn4JHFGp5FHJJLFZSFDcclJmu5uD8OFuEHQvIaet?=
 =?us-ascii?Q?iI/1m3Dw4jcdlLJpBvMIe/NI4O88oDmn+/9hmGCcCUl6+OWBfUwOHJzRrWX0?=
 =?us-ascii?Q?/lBRxtEpe7R52kIX3UI2J7ZYZ774BeAdavrOhvXAnGhi5NXjZzcwX8ZNim3N?=
 =?us-ascii?Q?QEcmLuc5OS+UQVVmnTJjwcdgW6r3GkRiymejkOEkz/7hvcLZOhLpGBv23zjq?=
 =?us-ascii?Q?9wWAHkhSxrErbtLff2Jldz25sCVHar3+a0tp5nJXM7UdhUHsnW47LPOJjAFT?=
 =?us-ascii?Q?IJ5uRc7I9V7O8KdAuf+uEh2U3/L7WqWhXG+RpGLCjB4ZetOhEr1h9bBYYNgm?=
 =?us-ascii?Q?0RgngSs0UnFfq8soKdXGnlTSPwN3VmAHnko3TA6JDyq/S0RHcXW5PEtIZ0jc?=
 =?us-ascii?Q?RbsGZ3N8mM8j7bYY5qcWADI+KZr5sQSNK90UwPNjsmMnyCRmoEq9r8srQ0g3?=
 =?us-ascii?Q?SQVESv4JdrRqApqHXGQu91lF/WXzfCqmENu3cIFMe9Uh+hTX2d9prdppOIMW?=
 =?us-ascii?Q?kPVEQogYB0bxkjsqZwe/ZxUlq2CGRsesxxHt2RgVmXqC1ooX4SI2IAtWMqij?=
 =?us-ascii?Q?TgRboRSs5ifrUFMtPwQJQKXQ2RAczNWE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 15:38:02.9023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc1911c-c8f9-40f6-34cb-08dcdf0a5fdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779
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

This DC patchset brings improvements in multiple areas.
In summary, we highlight:

* Improve brightness control
* Add support for UHBR10 eDP
* OPTC required only for DTBCLK_P for dcn401
* Fix TBT monitor resume issue
* Code cleanup

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (3):
  drm/amd/display: Remove always-false branches
  drm/amd/display: Eliminate recursive header inclusion
  drm/amd/display: Removed unused assignments and variables

Aric Cyr (1):
  drm/amd/display: 3.2.303

Dillon Varone (1):
  drm/amd/display: Configure DTBCLK_P with OPTC only for dcn401

Liu, Xi (Alex) (1):
  drm/amd/display: add more support for UHBR10 eDP

Muyuan Yang (2):
  drm/amd/display: Change Brightness Control Priority
  drm/amd/display: Introduce New ABC Framework for Brightness Control

Ovidiu Bunea (1):
  drm/amd/display: Add IPS residency capture helpers to dc_dmub_srv

Paul Hsieh (1):
  drm/amd/display: Add logs to record register read/write

Ryan Seto (1):
  drm/amd/display: Adjust PHY FSM transition to TX_EN-to-PLL_ON for TMDS

Taimur Hassan (1):
  drm/amd/display: [FW Promotion] Release 0.0.236.0

Tom Chung (1):
  drm/amd/display: Fix system hang while resume with TBT monitor

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   9 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  48 +----
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  78 ++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  39 ++++
 drivers/gpu/drm/amd/display/dc/dc_plane.h     |   1 -
 drivers/gpu/drm/amd/display/dc/dc_state.h     |   1 -
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   6 +
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |  84 --------
 .../dc/dml/dcn30/display_mode_vba_30.c        |   9 -
 .../display/dc/dml/dml1_display_rq_dlg_calc.c |   3 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 187 +++++++++++++++++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  11 ++
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   6 +-
 .../link/protocols/link_edp_panel_control.c   |  43 ++--
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   8 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 157 ++++++++++++++-
 .../drm/amd/display/include/logger_types.h    |   4 +-
 18 files changed, 521 insertions(+), 177 deletions(-)

-- 
2.34.1


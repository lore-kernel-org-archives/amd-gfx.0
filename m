Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D526FD3A674
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 16:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A55010E38E;
	Tue, 29 Oct 2024 16:57:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="isI3n+3k";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D346810E38E
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 16:57:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFnHviTM3rrlIDf/8ZU+U4Jv2dyKL0toeytpuIKTq90aBppZ00+nKdMonqeOo/R1UUtNl90ymtrRdkJWONJFzUCPrsKFIAKZVqx+FGlq6ZQHg77IdhKr3OJTs36fQTDJ2wrGtYXpH3idVpLx21uS9jy5oQvBSw4AuKE/GA8w0AWwVvUGbety+mpvGgwiCnLQ+EALR+aiQWFh8qenDQPR1RjcwYUw0eBt5QF8rA2VaXos28iqxKg5C3Z844zhPeHUeOxVfnmQ/P1Ete1cRfZYTy3tFNzD6mXWAB2FoHFZn8fFBx8L+ykX+g4aES8HNJJBtklo51aufdeMR3g/JMGWFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAO42vrsykbXjGf3HkUejbM37fBWo3h81cHR9o5WEnE=;
 b=jZ77ZiO3jMxhPjz8z/DDo6w3DDMr5XVKc8b+M1a7E4ePWPrM2C1qgwk/J7+inwBvF5mMA4Ir/UJ+qGv4RCcWtPww7Ad5nNnH5pWy88UEaq/Meo1jT4UStpCyohnhqPQZL8e/Ls2UytpBWdJQOHpp0VnnkAvI5kfsBedtEknQJ08gSma1NJUopUx1IGiXO3l0SAs8qfIPnLpX3i1Z0kNtBfrkNx8hTu/BF+k+DezElwWcfg1+G/Z5ZBTYt5WfBjn//61rYGNkxuGIHpz5Qj5rby9lCLtSzhRMcvjw6gYunOq5E/6E78I3o1PWhN3OIHa/rBokEa6TiadrnueUJzB5UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAO42vrsykbXjGf3HkUejbM37fBWo3h81cHR9o5WEnE=;
 b=isI3n+3kgAWv1KoEz3G69RrCIjWa5XPvHHmp+yn7y6m5kHGIigoNbDRg/nGdds+nlLwy1VQgDVKYPwXehqIP1LgKtLho7/ziJNWf0yUfeGoE6iIO78eIbkd8OEY2T3/ZBz+RzEA9YykjHp+o3sek1RcT4iCg/jC7G2tAGABPHvg=
Received: from BN9P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::23)
 by PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 16:57:08 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:10a:cafe::4f) by BN9P221CA0024.outlook.office365.com
 (2603:10b6:408:10a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Tue, 29 Oct 2024 16:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Tue, 29 Oct 2024 16:57:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Oct
 2024 11:57:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 0/7] Add panic support for all DCE/DCN
Date: Tue, 29 Oct 2024 12:56:46 -0400
Message-ID: <20241029165653.1873243-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|PH7PR12MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c099389-5b7f-4ae0-cf0f-08dcf83ab8fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ageBwxRtUvirvRa+YhCjlNwUEgCOU9D/v2cjIqMqckUXiVcJbihve0kE2Jr4?=
 =?us-ascii?Q?Vs/XROHtqBZW0KXI5UWmzdz08auselWAmuypbqE5fuOT2ni3e+R5dbevMQwc?=
 =?us-ascii?Q?l1XUHw7kpJsjoi+pTysj58Yu52ZGUI88fDSEyAwXw1X6Jr0DfrhBm9kpyGnp?=
 =?us-ascii?Q?QtgdPaemDMLeKgiAK50gfiyEGUZ6p59uFASatWs27F0xOzymNo4FlY6fa8I0?=
 =?us-ascii?Q?R8TN4M7rtacu5tOvF8orLUTINYshK+WEavjXBl2piOCuzHOHHv/+pgFWRQw6?=
 =?us-ascii?Q?6nZ2jQU9zdxqSkDv1DAVhiir9F+x08tOMhxrbcphM1TBAU/CRNs1c3i8NVvm?=
 =?us-ascii?Q?uCPi+AJ0Z5sAhXi9KqBeQEGVsoJ2K4SQ/Am+3QfRverX0fP0qzVQqZ4KT8uk?=
 =?us-ascii?Q?OmAFOwNypsBOov7MPDDio2DAkBx8RqLVykj/+WLzsahlxjKRhqcawKejZ04L?=
 =?us-ascii?Q?Arux7vaN99Wn9SvHPp5TsMOqbAcWO6nUQh4874xaD5zuQbaIGRE7JUFpbbH5?=
 =?us-ascii?Q?zcaWsUi5Lqi1VQ4BPGlJ0q442n3RRKi8PBCfoEU33zq9n7nVOclTxCEmR31l?=
 =?us-ascii?Q?jty8VmIJ6/A+qsXzzSpZJ9unQm1WqHXhQIhXa+GLonhBwQUjsycIGWvdVRM6?=
 =?us-ascii?Q?BYLP+5Ptmz5xgHjYi1OYWZfCAqPKQXDGN7XIMGYUmJQqKQ6EPYcxhWoDU+r3?=
 =?us-ascii?Q?dGi78H/ikPVMp0WE0ngocQN8chF8DdnY4N2kmQowxmKOFTxuDJzzp+Z5IiVQ?=
 =?us-ascii?Q?0xqn1MluG9DVNOdIT6L7mgIJmsTjWM3dB0zu9eeQIf5SH107H1+conTR9WHr?=
 =?us-ascii?Q?2nm80/tBpckRdBHvvAUNzCmkNYCzxDRHg0XbVh1CE8DL2iULkAiUL0Vd8Nes?=
 =?us-ascii?Q?Hsotu47/D18c591ua9bLOR8IAvcyWUfJhCEpbNgsJkviIF50BUSOdKK2USrU?=
 =?us-ascii?Q?7XEaRJ1b82DPzlTLuPytngk6DHzBTNP4PPyhiCFfj+bfBGAnG7fmap9duBve?=
 =?us-ascii?Q?4oZcbacG7o0ODb6wppGcADbXAp/5OIy8cL8Z6RUO23N6hxOLbUX0Js9RMG38?=
 =?us-ascii?Q?suTOgO8ngzQiyT3MiByG3qiPHd39u90ETO6r3vbm9fzuIBvwYyuJ9BE2kSuN?=
 =?us-ascii?Q?0xUQVzUAavE/ymiF5iqgCrOJPhyAqeyiMX7mjI1ykwLWics0xy6BbrKquC/l?=
 =?us-ascii?Q?4g8CmGY8Z5Y+aWuTY+Bm/vOUR/3AxHVeJnHOV7ZsCyWmw57715g6dSq3ppx8?=
 =?us-ascii?Q?awFEQzY9cpABnxB1/kSR7RD4Poh9gIYgqSOco5EX2VYtI6RNMF9woP7JFDGu?=
 =?us-ascii?Q?ymSBgOQ9fLroEspiHr9fWrxb/iOPQIrQ+qeJqrqx91QljOHprydsteZotpd2?=
 =?us-ascii?Q?hPjy7rL869hdI5cn/xRbeveFM6xLdClyPd7Bi2A85qC9hDp7Jg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:57:07.4444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c099389-5b7f-4ae0-cf0f-08dcf83ab8fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927
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

This builds on the patches from Lu and Jocelyn to fill in
panic support for all DCE/DCN variants and code pathes.

Alex Deucher (5):
  drm/amdgpu: add dce8 drm_panic support
  drm/amdgpu: add dce10 drm_panic support
  drm/amdgpu: add dce11 drm_panic support
  drm/amd/display: add clear_tiling support for all DCN families
  drm/amd/display: add panic support for DCE based IPs

Jocelyn Falempe (1):
  drm/amdgpu: Add dcn30 drm_panic support

Lu Yao (1):
  drm/amdgpu: add dce6 drm_panic support

 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  48 +++++
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |  48 +++++
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  48 +++++
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  48 +++++
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 185 +++++++++++++++++-
 .../drm/amd/display/dc/dce/dce_mem_input.c    |  34 +++-
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |  15 ++
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    |   2 +
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |  15 ++
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |   2 +
 .../amd/display/dc/hubp/dcn201/dcn201_hubp.c  |   1 +
 .../amd/display/dc/hubp/dcn21/dcn21_hubp.c    |   1 +
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |  17 ++
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.h    |   2 +
 .../amd/display/dc/hubp/dcn31/dcn31_hubp.c    |   1 +
 .../amd/display/dc/hubp/dcn32/dcn32_hubp.c    |   3 +-
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |   1 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  15 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |   2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   1 +
 .../gpu/drm/amd/display/dc/inc/hw/mem_input.h |   2 +
 21 files changed, 483 insertions(+), 8 deletions(-)

-- 
2.47.0


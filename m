Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 107EBE7B5E1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 09:24:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9145F10E359;
	Wed,  4 Oct 2023 09:24:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D68010E359
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 09:24:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsakYpNeUSEYghl6oOOKTd5Nhgw9TT4N/r2/J11iGIyrEuD0AVmXzdUlzMl6rUSXhQy5xvkFXph6w+vLzxuttMVnvTn8XrGjChdUGTXH87qrycqZO+7RC6t/LRAtth61eUuD3ZiRM6jX9Nm3H/6g6h3d6wJkVUtt+keKhT4wq3FMyHqJnPG4UA8dm4C7B1zIjI2AVu9yyfD5jkmiRvpcAt9j92BZz8v7S2XKHCnG+EqdseJktkkgU+jBY47jh6kXDtJumTBYShX3CtIEJYOBBLPWvR9lBSt4AFyYS4wRgVgaWgt7WQhVBoenQKESrAD5tc1uNm/z4uCgkRCrN4qG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvyAHdITpUrxc58v9sn7dKRrNqzfSeuhRLPpZ9UiU/E=;
 b=j30LTv/NMsqFdK4QPer4dHBiobqaneaYd1RofKvOhCZrpo/Cdy9G17lF1hkwbvy8SPbsJN/8PA5I8l/fLHCJOUrfh+7n8xkYa7RyqG5vFhOMGx1jp593utrrxms6tgPt5V8UklvzqnICM84gG1uvkmW1g0ep7pSXJAvTQA0P4cwp+jfYHkdXQHae2nP0gsIr3jw280pTM/nbMnvS+mbsIRfME4RWfM4kSk0xfnGtfW+7V2Scmn2HH2GRs4Izo53UDqJ2a+2UhnJl0FwwmRwFV4lxyvFWOeOtiJ5A/3VK+ZQ5+gvzIiarEjrZGVyLa67TzhAlPW5dCBtOcP3vO6s84Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvyAHdITpUrxc58v9sn7dKRrNqzfSeuhRLPpZ9UiU/E=;
 b=zU9AlrHwQfPQB6hH8EvMYmvm4lJUN1im/CfLXBQJ1/fLueNPzduNes7wz+K6ELjWZ+V7JO2wElMWDCAxXLlnC9XEkzBq4/GnmECk5cZrVQo1eoi2ijL98rF+SCI+LoM9VYK4lQKUrBYQlApvioSgoUcDqs1hOnZ5Ldltitw7huM=
Received: from BLAPR03CA0165.namprd03.prod.outlook.com (2603:10b6:208:32f::9)
 by DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Wed, 4 Oct
 2023 09:24:34 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::4b) by BLAPR03CA0165.outlook.office365.com
 (2603:10b6:208:32f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 09:24:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 09:24:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:24:33 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:24:32 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 04:24:27 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/16] drm/amd/display: Refactor HWSS into component folder
Date: Wed, 4 Oct 2023 17:22:57 +0800
Message-ID: <20231004092301.2371458-13-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
References: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|DM4PR12MB5229:EE_
X-MS-Office365-Filtering-Correlation-Id: c100ecc3-ae8a-4269-601c-08dbc4bbb8c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJNs+9wRwBATr+gCnZ4VybvZy2e68fQ6XYenWga/Qiy6STfpxk/R3OIT7oxZ1ofhNAqLxqH7pvy5XoWm57CExuM2jj+qMo/Rs27eAULB52ilWmPpc6Fa9DL3tiaXccfWEsxKVZu9GDci0VFzBaP5n4cNRJ/zTGF98qd3l756f9bLWzpP04MYaKo+80ISSbyFLgVZwyqpPMdi63VzXjV9FDFUckw9iA+zmjM5eKwj0adXmrhHWdQ/HEUDUTIhwCwKUuVScfIIlcWr0/tlOYu4o9JAKCLzIcD0a83LCIuQrOJ/IMxCD02rmrIn9ZIgSAqmFArbw0qvcSZIZAH65W1cAMr0UItndFjJN3EHtIgtYUZA3P4srDrL1xBpF5kUS2dpdP23/P4aWn3uOXMxSlLWleIt4qePTMoIZYF5d9i0Uz57f3YSbQj82kHbNIX98Qvpf2P568Yg7WEl2JjZQ+iPHpX/IjzWN4r9mGxUjpphYlXSw4008vTqzNS2VSCzAWsM0jbQ4YYFiekuIIzs1PHCFlquRVHw0wD5NhWBX1RRD8/QQEMea2obMVEYD0o/w9VZ56BivtgGtSzt2qGBK+jPPJHiibe82mIKxUwi+0yyYjhSmmh5Viy3urWyct2kxXrl6+ly046sNpppwDH8kDBADCv4obF2AIbWVokTQZL83mIyrlH0uTYNoAnXAj5jJ+YuDb5WCo419qwHuJ0faY3CN/X4d5TF54UahuOB/6E7OF8MQjNcCL+Wi5H+xsJkRsOPr+rT6OQLpvcxQXkcfM64Bg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(2616005)(66899024)(7696005)(478600001)(1076003)(6666004)(47076005)(54906003)(336012)(426003)(26005)(2906002)(30864003)(5660300002)(41300700001)(70206006)(6916009)(70586007)(83380400001)(4326008)(8676002)(316002)(8936002)(40460700003)(36860700001)(82740400003)(81166007)(356005)(36756003)(40480700001)(86362001)(36900700001)(579004)(559001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:24:34.0721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c100ecc3-ae8a-4269-601c-08dbc4bbb8c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5229
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <martin.leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Mounika Adhuri <moadhuri@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mounika Adhuri <moadhuri@amd.com>

[why]
Rename hw_sequencer to hwseq.
Move all hwseq files to unique
folder hwss.

[how]
creating hwss repo in dc, and moved the dcnxx_hwseq.c
and .h files into corresponding new folders inside the hwss
and cleared the linkage errors by adding relative paths
in the Makefile.template.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Mounika Adhuri <moadhuri@amd.com>
---
 drivers/gpu/drm/amd/display/Makefile          |   1 +
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 .../dc/clk_mgr/dce120/dce120_clk_mgr.c        |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/Makefile   |   2 +-
 .../gpu/drm/amd/display/dc/dce100/Makefile    |   2 +-
 .../amd/display/dc/dce100/dce100_resource.c   |   4 +-
 .../gpu/drm/amd/display/dc/dce110/Makefile    |   2 +-
 .../amd/display/dc/dce110/dce110_resource.c   |   2 +-
 .../gpu/drm/amd/display/dc/dce112/Makefile    |   2 +-
 .../amd/display/dc/dce112/dce112_resource.c   |   2 +-
 .../gpu/drm/amd/display/dc/dce120/Makefile    |   1 -
 .../amd/display/dc/dce120/dce120_resource.c   |   6 +-
 .../amd/display/dc/dce60/dce60_hw_sequencer.c |   4 +-
 drivers/gpu/drm/amd/display/dc/dce80/Makefile |   2 +-
 .../drm/amd/display/dc/dce80/dce80_resource.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile |   2 +-
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |   4 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   4 +-
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |   4 +-
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   6 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   4 +-
 .../gpu/drm/amd/display/dc/dcn201/Makefile    |   2 +-
 .../drm/amd/display/dc/dcn201/dcn201_init.c   |   6 +-
 .../amd/display/dc/dcn201/dcn201_resource.c   |   4 +-
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   6 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |   1 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   6 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn301/Makefile    |   2 +-
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |   6 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |   2 +-
 .../gpu/drm/amd/display/dc/dcn302/Makefile    |   2 +-
 .../drm/amd/display/dc/dcn302/dcn302_init.c   |   2 +-
 .../gpu/drm/amd/display/dc/dcn303/Makefile    |   2 +-
 .../drm/amd/display/dc/dcn303/dcn303_init.c   |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   4 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn314/Makefile    |   2 +-
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |   4 +-
 .../amd/display/dc/dcn314/dcn314_resource.c   |   2 +-
 .../amd/display/dc/dcn315/dcn315_resource.c   |   2 +-
 .../amd/display/dc/dcn316/dcn316_resource.c   |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |   6 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   2 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn35/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_init.c |   4 +-
 .../drm/amd/display/dc/dcn35/dcn35_resource.c |   4 +-
 drivers/gpu/drm/amd/display/dc/hwss/Makefile  | 183 ++++++++++++++++++
 .../amd/display/dc/{ => hwss}/dce/dce_hwseq.c |   0
 .../amd/display/dc/{ => hwss}/dce/dce_hwseq.h |   0
 .../dce100/dce100_hwseq.c}                    |   4 +-
 .../dce100/dce100_hwseq.h}                    |   0
 .../dce110/dce110_hwseq.c}                    |   8 +-
 .../dce110/dce110_hwseq.h}                    |   0
 .../dce112/dce112_hwseq.c}                    |   4 +-
 .../dce112/dce112_hwseq.h}                    |   0
 .../dce120/dce120_hwseq.c}                    |   4 +-
 .../dce120/dce120_hwseq.h}                    |   0
 .../dce80/dce80_hwseq.c}                      |   6 +-
 .../dce80/dce80_hwseq.h}                      |   0
 .../dcn10/dcn10_hwseq.c}                      |  16 +-
 .../dcn10/dcn10_hwseq.h}                      |   0
 .../display/dc/{ => hwss}/dcn20/dcn20_hwseq.c |   6 +-
 .../display/dc/{ => hwss}/dcn20/dcn20_hwseq.h |   0
 .../dc/{ => hwss}/dcn201/dcn201_hwseq.c       |   2 +-
 .../dc/{ => hwss}/dcn201/dcn201_hwseq.h       |   0
 .../display/dc/{ => hwss}/dcn21/dcn21_hwseq.c |   2 +-
 .../display/dc/{ => hwss}/dcn21/dcn21_hwseq.h |   0
 .../display/dc/{ => hwss}/dcn30/dcn30_hwseq.c |  10 +-
 .../display/dc/{ => hwss}/dcn30/dcn30_hwseq.h |   0
 .../dc/{ => hwss}/dcn301/dcn301_hwseq.c       |   0
 .../dc/{ => hwss}/dcn301/dcn301_hwseq.h       |   0
 .../dc/{ => hwss}/dcn302/dcn302_hwseq.c       |   0
 .../dc/{ => hwss}/dcn302/dcn302_hwseq.h       |   0
 .../dc/{ => hwss}/dcn303/dcn303_hwseq.c       |   0
 .../dc/{ => hwss}/dcn303/dcn303_hwseq.h       |   0
 .../display/dc/{ => hwss}/dcn31/dcn31_hwseq.c |   2 +-
 .../display/dc/{ => hwss}/dcn31/dcn31_hwseq.h |   0
 .../dc/{ => hwss}/dcn314/dcn314_hwseq.c       |   2 +-
 .../dc/{ => hwss}/dcn314/dcn314_hwseq.h       |   0
 .../display/dc/{ => hwss}/dcn32/dcn32_hwseq.c |   2 +-
 .../display/dc/{ => hwss}/dcn32/dcn32_hwseq.h |   0
 .../display/dc/{ => hwss}/dcn35/dcn35_hwseq.c |   2 +-
 .../display/dc/{ => hwss}/dcn35/dcn35_hwseq.h |   0
 .../display/dc/{inc => hwss}/hw_sequencer.h   |   4 +-
 .../dc/{inc => hwss}/hw_sequencer_private.h   |   0
 93 files changed, 297 insertions(+), 115 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dce/dce_hwseq.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dce/dce_hwseq.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{dce100/dce100_hw_sequencer.c => hwss/dce100/dce100_hwseq.c} (98%)
 rename drivers/gpu/drm/amd/display/dc/{dce100/dce100_hw_sequencer.h => hwss/dce100/dce100_hwseq.h} (100%)
 rename drivers/gpu/drm/amd/display/dc/{dce110/dce110_hw_sequencer.c => hwss/dce110/dce110_hwseq.c} (99%)
 rename drivers/gpu/drm/amd/display/dc/{dce110/dce110_hw_sequencer.h => hwss/dce110/dce110_hwseq.h} (100%)
 rename drivers/gpu/drm/amd/display/dc/{dce112/dce112_hw_sequencer.c => hwss/dce112/dce112_hwseq.c} (98%)
 rename drivers/gpu/drm/amd/display/dc/{dce112/dce112_hw_sequencer.h => hwss/dce112/dce112_hwseq.h} (100%)
 rename drivers/gpu/drm/amd/display/dc/{dce120/dce120_hw_sequencer.c => hwss/dce120/dce120_hwseq.c} (98%)
 rename drivers/gpu/drm/amd/display/dc/{dce120/dce120_hw_sequencer.h => hwss/dce120/dce120_hwseq.h} (100%)
 rename drivers/gpu/drm/amd/display/dc/{dce80/dce80_hw_sequencer.c => hwss/dce80/dce80_hwseq.c} (94%)
 rename drivers/gpu/drm/amd/display/dc/{dce80/dce80_hw_sequencer.h => hwss/dce80/dce80_hwseq.h} (100%)
 rename drivers/gpu/drm/amd/display/dc/{dcn10/dcn10_hw_sequencer.c => hwss/dcn10/dcn10_hwseq.c} (99%)
 rename drivers/gpu/drm/amd/display/dc/{dcn10/dcn10_hw_sequencer.h => hwss/dcn10/dcn10_hwseq.h} (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn20/dcn20_hwseq.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn20/dcn20_hwseq.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn201/dcn201_hwseq.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn201/dcn201_hwseq.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn21/dcn21_hwseq.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn21/dcn21_hwseq.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn30/dcn30_hwseq.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn30/dcn30_hwseq.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn301/dcn301_hwseq.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn301/dcn301_hwseq.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn302/dcn302_hwseq.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn302/dcn302_hwseq.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn303/dcn303_hwseq.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn303/dcn303_hwseq.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn31/dcn31_hwseq.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn31/dcn31_hwseq.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn314/dcn314_hwseq.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn314/dcn314_hwseq.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn32/dcn32_hwseq.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn32/dcn32_hwseq.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn35/dcn35_hwseq.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn35/dcn35_hwseq.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{inc => hwss}/hw_sequencer.h (99%)
 rename drivers/gpu/drm/amd/display/dc/{inc => hwss}/hw_sequencer_private.h (100%)

diff --git a/drivers/gpu/drm/amd/display/Makefile b/drivers/gpu/drm/amd/display/Makefile
index 0d610cb376bb..af17ab8027df 100644
--- a/drivers/gpu/drm/amd/display/Makefile
+++ b/drivers/gpu/drm/amd/display/Makefile
@@ -29,6 +29,7 @@ AMDDALPATH = $(RELATIVE_AMD_DISPLAY_PATH)
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/inc/
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/inc/hw
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/clk_mgr
+subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/hwss
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/inc
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/freesync
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/color
diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 2f3d9602b7a0..393ee26cfcd0 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -22,7 +22,7 @@
 #
 # Makefile for Display Core (dc) component.
 
-DC_LIBS = basics bios dml clk_mgr dce gpio irq link virtual dsc
+DC_LIBS = basics bios dml clk_mgr dce gpio hwss irq link virtual dsc
 
 ifdef CONFIG_DRM_AMD_DC_FP
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce120/dce120_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce120/dce120_clk_mgr.c
index 5399b8cf6b75..c9ba7b3fd2c3 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce120/dce120_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce120/dce120_clk_mgr.c
@@ -30,7 +30,7 @@
 #include "dce110/dce110_clk_mgr.h"
 #include "dce120_clk_mgr.h"
 #include "dce100/dce_clk_mgr.h"
-#include "dce120/dce120_hw_sequencer.h"
+#include "dce120/dce120_hwseq.h"
 
 static const struct state_dependent_clocks dce120_max_clks_by_state[] = {
 /*ClocksStateInvalid - should not be used*/
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 41c77910f046..0b9384707106 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -35,7 +35,7 @@
 #include "grph_object_ctrl_defs.h"
 #include <inc/hw/opp.h>
 
-#include "inc/hw_sequencer.h"
+#include "hwss/hw_sequencer.h"
 #include "inc/compressor.h"
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce/Makefile b/drivers/gpu/drm/amd/display/dc/dce/Makefile
index 15b64c26d5a2..986e0e7abbc2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce/Makefile
@@ -26,7 +26,7 @@
 #   - register programming through common macros that look up register 
 #     offset/shift/mask stored in dce_hw struct
 
-DCE = dce_audio.o dce_stream_encoder.o dce_link_encoder.o dce_hwseq.o \
+DCE = dce_audio.o dce_stream_encoder.o dce_link_encoder.o \
 dce_mem_input.o dce_clock_source.o dce_scl_filters.o dce_transform.o \
 dce_opp.o dce_dmcu.o dce_abm.o dce_ipp.o dce_aux.o \
 dce_i2c.o dce_i2c_hw.o dce_i2c_sw.o dmub_psr.o dmub_abm.o dmub_abm_lcd.o dce_panel_cntl.o \
diff --git a/drivers/gpu/drm/amd/display/dc/dce100/Makefile b/drivers/gpu/drm/amd/display/dc/dce100/Makefile
index ff20c47f559e..0d2f6bbf7558 100644
--- a/drivers/gpu/drm/amd/display/dc/dce100/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce100/Makefile
@@ -25,7 +25,7 @@
 
 CFLAGS_$(AMDDALPATH)/dc/dce100/dce100_resource.o = $(call cc-disable-warning, override-init)
 
-DCE100 = dce100_resource.o dce100_hw_sequencer.o
+DCE100 = dce100_resource.o
 
 AMD_DAL_DCE100 = $(addprefix $(AMDDALPATH)/dc/dce100/,$(DCE100))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
index 899b25b0bad8..53a5f4cb648c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
@@ -30,7 +30,7 @@
 
 #include "resource.h"
 #include "include/irq_service_interface.h"
-#include "../virtual/virtual_stream_encoder.h"
+#include "virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
 #include "dce110/dce110_timing_generator.h"
 #include "irq/dce110/irq_service_dce110.h"
@@ -43,7 +43,7 @@
 #include "dce/dce_clock_source.h"
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
-#include "dce100/dce100_hw_sequencer.h"
+#include "dce100/dce100_hwseq.h"
 #include "dce/dce_panel_cntl.h"
 
 #include "reg_helper.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/Makefile b/drivers/gpu/drm/amd/display/dc/dce110/Makefile
index 84ab48df0c26..695a50ed5ad2 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce110/Makefile
@@ -26,7 +26,7 @@
 CFLAGS_$(AMDDALPATH)/dc/dce110/dce110_resource.o = $(call cc-disable-warning, override-init)
 
 DCE110 = dce110_timing_generator.o \
-dce110_compressor.o dce110_hw_sequencer.o dce110_resource.o \
+dce110_compressor.o dce110_resource.o \
 dce110_opp_regamma_v.o dce110_opp_csc_v.o dce110_timing_generator_v.o \
 dce110_mem_input_v.o dce110_opp_v.o dce110_transform_v.o
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index 1289b9418877..fe518fd27b08 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -46,7 +46,7 @@
 #include "dce110/dce110_opp_v.h"
 #include "dce/dce_clock_source.h"
 #include "dce/dce_hwseq.h"
-#include "dce110/dce110_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
 #include "dce/dce_aux.h"
 #include "dce/dce_abm.h"
 #include "dce/dce_dmcu.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/Makefile b/drivers/gpu/drm/amd/display/dc/dce112/Makefile
index 9de6501702d2..e846ef58cab3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce112/Makefile
@@ -25,7 +25,7 @@
 
 CFLAGS_$(AMDDALPATH)/dc/dce112/dce112_resource.o = $(call cc-disable-warning, override-init)
 
-DCE112 = dce112_compressor.o dce112_hw_sequencer.o \
+DCE112 = dce112_compressor.o \
 dce112_resource.o
 
 AMD_DAL_DCE112 = $(addprefix $(AMDDALPATH)/dc/dce112/,$(DCE112))
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index 2b20180f1a32..d1edac46c9a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -44,7 +44,7 @@
 #include "dce/dce_clock_source.h"
 
 #include "dce/dce_hwseq.h"
-#include "dce112/dce112_hw_sequencer.h"
+#include "dce112/dce112_hwseq.h"
 #include "dce/dce_abm.h"
 #include "dce/dce_dmcu.h"
 #include "dce/dce_aux.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/Makefile b/drivers/gpu/drm/amd/display/dc/dce120/Makefile
index a9cc4b73270b..097cf407a15d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce120/Makefile
@@ -27,7 +27,6 @@
 CFLAGS_$(AMDDALPATH)/dc/dce120/dce120_resource.o = $(call cc-disable-warning, override-init)
 
 DCE120 = dce120_resource.o dce120_timing_generator.o \
-dce120_hw_sequencer.o
 
 AMD_DAL_DCE120 = $(addprefix $(AMDDALPATH)/dc/dce120/,$(DCE120))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
index 18c5a86d2d61..962de79be169 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
@@ -35,7 +35,7 @@
 #include "dce112/dce112_resource.h"
 
 #include "dce110/dce110_resource.h"
-#include "../virtual/virtual_stream_encoder.h"
+#include "virtual/virtual_stream_encoder.h"
 #include "dce120_timing_generator.h"
 #include "irq/dce120/irq_service_dce120.h"
 #include "dce/dce_opp.h"
@@ -44,8 +44,8 @@
 #include "dce/dce_mem_input.h"
 #include "dce/dce_panel_cntl.h"
 
-#include "dce110/dce110_hw_sequencer.h"
-#include "dce120/dce120_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
+#include "dce120/dce120_hwseq.h"
 #include "dce/dce_transform.h"
 #include "clk_mgr.h"
 #include "dce/dce_audio.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c
index 920c7ae29d53..1fdeef47e4dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c
@@ -29,8 +29,8 @@
 #include "dce60_hw_sequencer.h"
 
 #include "dce/dce_hwseq.h"
-#include "dce110/dce110_hw_sequencer.h"
-#include "dce100/dce100_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
+#include "dce100/dce100_hwseq.h"
 
 /* include DCE6 register header files */
 #include "dce/dce_6_0_d.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/Makefile b/drivers/gpu/drm/amd/display/dc/dce80/Makefile
index 0a9d1a350d8b..93dd68c31275 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dce80/Makefile
@@ -25,7 +25,7 @@
 
 CFLAGS_$(AMDDALPATH)/dc/dce80/dce80_resource.o = $(call cc-disable-warning, override-init)
 
-DCE80 = dce80_timing_generator.o dce80_hw_sequencer.o \
+DCE80 = dce80_timing_generator.o \
 	dce80_resource.o
 
 AMD_DAL_DCE80 = $(addprefix $(AMDDALPATH)/dc/dce80/,$(DCE80))
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
index 061221394ce0..35a2cce0c2b8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
@@ -46,7 +46,7 @@
 #include "dce/dce_clock_source.h"
 #include "dce/dce_audio.h"
 #include "dce/dce_hwseq.h"
-#include "dce80/dce80_hw_sequencer.h"
+#include "dce80/dce80_hwseq.h"
 #include "dce100/dce100_resource.h"
 #include "dce/dce_panel_cntl.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/Makefile b/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
index 62ad1a11bff9..2d2007c3e2b6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
@@ -22,7 +22,7 @@
 #
 # Makefile for DCN.
 
-DCN10 = dcn10_init.o dcn10_resource.o dcn10_ipp.o dcn10_hw_sequencer.o \
+DCN10 = dcn10_init.o dcn10_resource.o dcn10_ipp.o \
 		dcn10_hw_sequencer_debug.o \
 		dcn10_dpp.o dcn10_opp.o dcn10_optc.o \
 		dcn10_hubp.o dcn10_mpc.o \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
index 46a2ebcabd1a..92fdab731f4a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
@@ -27,8 +27,8 @@
 #include "core_types.h"
 #include "resource.h"
 #include "custom_float.h"
-#include "dcn10_hw_sequencer.h"
-#include "dce110/dce110_hw_sequencer.h"
+#include "dcn10/dcn10_hwseq.h"
+#include "dce110/dce110_hwseq.h"
 #include "dce/dce_hwseq.h"
 #include "abm.h"
 #include "dmcu.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
index f2371c948822..a5bdac79a744 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
@@ -24,8 +24,8 @@
  */
 
 #include "hw_sequencer_private.h"
-#include "dce110/dce110_hw_sequencer.h"
-#include "dcn10_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_hwseq.h"
 
 static const struct hw_sequencer_funcs dcn10_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 9f9145742f14..d1d8e904346e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -36,8 +36,8 @@
 #include "irq/dcn10/irq_service_dcn10.h"
 #include "dcn10_dpp.h"
 #include "dcn10_optc.h"
-#include "dcn10_hw_sequencer.h"
-#include "dce110/dce110_hw_sequencer.h"
+#include "dcn10/dcn10_hwseq.h"
+#include "dce110/dce110_hwseq.h"
 #include "dcn10_opp.h"
 #include "dcn10_link_encoder.h"
 #include "dcn10_stream_encoder.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index abaed2121feb..d7dc9696a8c8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile for DCN.
 
-DCN20 = dcn20_resource.o dcn20_init.o dcn20_hwseq.o dcn20_dpp.o dcn20_dpp_cm.o dcn20_hubp.o \
+DCN20 = dcn20_resource.o dcn20_init.o dcn20_dpp.o dcn20_dpp_cm.o dcn20_hubp.o \
 		dcn20_mpc.o dcn20_opp.o dcn20_hubbub.o dcn20_optc.o dcn20_mmhubbub.o \
 		dcn20_stream_encoder.o dcn20_link_encoder.o dcn20_dccg.o \
 		dcn20_vmid.o dcn20_dwb.o dcn20_dwb_scl.o
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index 15b66ed66ad6..884e3e323338 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -23,9 +23,9 @@
  *
  */
 
-#include "dce110/dce110_hw_sequencer.h"
-#include "dcn10/dcn10_hw_sequencer.h"
-#include "dcn20_hwseq.h"
+#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
+#include "dcn20/dcn20_hwseq.h"
 
 #include "dcn20_init.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 2820393d5c6f..71ced2b6f3de 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -45,8 +45,8 @@
 #include "irq/dcn20/irq_service_dcn20.h"
 #include "dcn20_dpp.h"
 #include "dcn20_optc.h"
-#include "dcn20_hwseq.h"
-#include "dce110/dce110_hw_sequencer.h"
+#include "dcn20/dcn20_hwseq.h"
+#include "dce110/dce110_hwseq.h"
 #include "dcn10/dcn10_resource.h"
 #include "dcn20_opp.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
index 5c9ce2cebb0f..3a41a97b0729 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: MIT
 #
 # Makefile for DCN.
-DCN201 = dcn201_init.o dcn201_resource.o dcn201_hwseq.o \
+DCN201 = dcn201_init.o dcn201_resource.o \
 	dcn201_hubbub.o\
 	dcn201_mpc.o dcn201_hubp.o dcn201_opp.o dcn201_optc.o dcn201_dpp.o \
 	dcn201_dccg.o dcn201_link_encoder.o
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c
index 92dd4cddbab8..a13bf6c9386e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c
@@ -23,10 +23,10 @@
  *
  */
 
-#include "dce110/dce110_hw_sequencer.h"
-#include "dcn10/dcn10_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_hwseq.h"
-#include "dcn201_hwseq.h"
+#include "dcn201/dcn201_hwseq.h"
 #include "dcn201_init.h"
 
 static const struct hw_sequencer_funcs dcn201_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
index 9389bd8df42b..a11b2f6afe4a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
@@ -43,8 +43,8 @@
 #include "dcn201/dcn201_hubbub.h"
 #include "dcn201_dccg.h"
 #include "dcn201_optc.h"
-#include "dcn201_hwseq.h"
-#include "dce110/dce110_hw_sequencer.h"
+#include "dcn201/dcn201_hwseq.h"
+#include "dce110/dce110_hwseq.h"
 #include "dcn201_opp.h"
 #include "dcn201/dcn201_link_encoder.h"
 #include "dcn20/dcn20_stream_encoder.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
index 0dc06e428999..ce1be0afae4a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
@@ -3,7 +3,7 @@
 # Makefile for DCN21.
 
 DCN21 = dcn21_init.o dcn21_hubp.o dcn21_hubbub.o dcn21_resource.o \
-	 dcn21_hwseq.o dcn21_link_encoder.o dcn21_dccg.o
+	 dcn21_link_encoder.o dcn21_dccg.o
 
 AMD_DAL_DCN21 = $(addprefix $(AMDDALPATH)/dc/dcn21/,$(DCN21))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index 647e666f692a..18249c6b6d81 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -23,10 +23,10 @@
  *
  */
 
-#include "dce110/dce110_hw_sequencer.h"
-#include "dcn10/dcn10_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_hwseq.h"
-#include "dcn21_hwseq.h"
+#include "dcn21/dcn21_hwseq.h"
 
 #include "dcn21_init.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 71e82692dd7c..f30ad4c4f407 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -49,7 +49,7 @@
 #include "dcn20/dcn20_dpp.h"
 #include "dcn20/dcn20_optc.h"
 #include "dcn21/dcn21_hwseq.h"
-#include "dce110/dce110_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
 #include "dcn20/dcn20_opp.h"
 #include "dcn20/dcn20_dsc.h"
 #include "dcn21/dcn21_link_encoder.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
index 4a3e9e47b6b6..af4d2065d2c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
@@ -30,7 +30,6 @@ DCN30 := \
 	dcn30_dpp.o \
 	dcn30_optc.o \
 	dcn30_dccg.o \
-	dcn30_hwseq.o \
 	dcn30_mpc.o dcn30_vpg.o \
 	dcn30_afmt.o \
 	dcn30_dio_stream_encoder.o \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index e56fca60a1ed..9894caedffed 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -23,11 +23,11 @@
  *
  */
 
-#include "dce110/dce110_hw_sequencer.h"
-#include "dcn10/dcn10_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn21/dcn21_hwseq.h"
-#include "dcn30_hwseq.h"
+#include "dcn30/dcn30_hwseq.h"
 
 #include "dcn30_init.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 9f3c8626c0b2..473581cff06b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -44,7 +44,7 @@
 #include "dcn30/dcn30_optc.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
-#include "dce110/dce110_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
 #include "dcn30/dcn30_opp.h"
 #include "dcn20/dcn20_dsc.h"
 #include "dcn30/dcn30_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
index 9002cb10a6ae..30fbc5e06dca 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
@@ -11,7 +11,7 @@
 # Makefile for dcn30.
 
 DCN301 = dcn301_init.o dcn301_resource.o dcn301_dccg.o \
-		dcn301_dio_link_encoder.o dcn301_hwseq.o dcn301_panel_cntl.o dcn301_hubbub.o \
+		dcn301_dio_link_encoder.o dcn301_panel_cntl.o dcn301_hubbub.o \
 		dcn301_optc.o
 
 AMD_DAL_DCN301 = $(addprefix $(AMDDALPATH)/dc/dcn301/,$(DCN301))
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
index fdbe3d42cd7b..6477009ce065 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
@@ -23,12 +23,12 @@
  *
  */
 
-#include "dce110/dce110_hw_sequencer.h"
-#include "dcn10/dcn10_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn21/dcn21_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
-#include "dcn301_hwseq.h"
+#include "dcn301/dcn301_hwseq.h"
 
 #include "dcn301_init.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 6d2f99c1fcd5..b4b3b52990b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -45,7 +45,7 @@
 #include "dcn301/dcn301_optc.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
-#include "dce110/dce110_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
 #include "dcn30/dcn30_opp.h"
 #include "dcn20/dcn20_dsc.h"
 #include "dcn30/dcn30_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
index ebd01cb467b7..95b66baf39e9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
@@ -5,7 +5,7 @@
 #
 # Makefile for dcn302.
 
-DCN3_02 = dcn302_init.o dcn302_hwseq.o dcn302_resource.o
+DCN3_02 = dcn302_init.o dcn302_resource.o
 
 AMD_DAL_DCN3_02 = $(addprefix $(AMDDALPATH)/dc/dcn302/,$(DCN3_02))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.c
index eb375f30f5bc..637f9514d37b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.c
@@ -23,7 +23,7 @@
  *
  */
 
-#include "dcn302_hwseq.h"
+#include "dcn302/dcn302_hwseq.h"
 
 #include "dcn30/dcn30_init.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/Makefile b/drivers/gpu/drm/amd/display/dc/dcn303/Makefile
index 8702e0b7fda3..d7b3ad780e5d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/Makefile
@@ -6,7 +6,7 @@
 #
 # Makefile for dcn303.
 
-DCN3_03 = dcn303_init.o dcn303_hwseq.o dcn303_resource.o
+DCN3_03 = dcn303_init.o dcn303_resource.o
 
 AMD_DAL_DCN3_03 = $(addprefix $(AMDDALPATH)/dc/dcn303/,$(DCN3_03))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
index f499f8ab5e47..39cf7a50bd26 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
@@ -5,7 +5,7 @@
  * Authors: AMD
  */
 
-#include "dcn303_hwseq.h"
+#include "dcn303/dcn303_hwseq.h"
 #include "dcn30/dcn30_init.h"
 #include "dc.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
index ec041e3cda30..996d8c1e9d2a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
@@ -10,7 +10,7 @@
 #
 # Makefile for dcn31.
 
-DCN31 = dcn31_resource.o dcn31_hubbub.o dcn31_hwseq.o dcn31_init.o dcn31_hubp.o \
+DCN31 = dcn31_resource.o dcn31_hubbub.o dcn31_init.o dcn31_hubp.o \
 	dcn31_dccg.o dcn31_optc.o dcn31_dio_link_encoder.o dcn31_panel_cntl.o \
 	dcn31_apg.o dcn31_hpo_dp_stream_encoder.o dcn31_hpo_dp_link_encoder.o \
 	dcn31_afmt.o dcn31_vpg.o
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
index 084861519e28..669f524bd064 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
@@ -23,8 +23,8 @@
  *
  */
 
-#include "dce110/dce110_hw_sequencer.h"
-#include "dcn10/dcn10_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn21/dcn21_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 239d7ce8e533..cdf005f91869 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -48,7 +48,7 @@
 #include "dcn31/dcn31_optc.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
-#include "dce110/dce110_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
 #include "dcn30/dcn30_opp.h"
 #include "dcn20/dcn20_dsc.h"
 #include "dcn30/dcn30_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/Makefile b/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
index 702c28c2560e..72456debb99f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
@@ -10,7 +10,7 @@
 #
 # Makefile for dcn314.
 
-DCN314 = dcn314_resource.o dcn314_hwseq.o dcn314_init.o \
+DCN314 = dcn314_resource.o dcn314_init.o \
 		dcn314_dio_stream_encoder.o dcn314_dccg.o dcn314_optc.o
 
 AMD_DAL_DCN314 = $(addprefix $(AMDDALPATH)/dc/dcn314/,$(DCN314))
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
index 163dd563b209..ccb7e317e86a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
@@ -24,8 +24,8 @@
  *
  */
 
-#include "dce110/dce110_hw_sequencer.h"
-#include "dcn10/dcn10_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn21/dcn21_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 64a2692fd4f6..2d7436f2ea82 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -50,7 +50,7 @@
 #include "dcn314/dcn314_optc.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
-#include "dce110/dce110_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
 #include "dcn30/dcn30_opp.h"
 #include "dcn20/dcn20_dsc.h"
 #include "dcn30/dcn30_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index ed804439fb7e..c11dbb1f4033 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -47,7 +47,7 @@
 #include "dcn31/dcn31_optc.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
-#include "dce110/dce110_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
 #include "dcn30/dcn30_opp.h"
 #include "dcn20/dcn20_dsc.h"
 #include "dcn30/dcn30_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index 9133a1ea4ca0..4220fe4cae4a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -47,7 +47,7 @@
 #include "dcn31/dcn31_optc.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
-#include "dce110/dce110_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
 #include "dcn30/dcn30_opp.h"
 #include "dcn20/dcn20_dsc.h"
 #include "dcn30/dcn30_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
index e943b643ab6b..8bb251307247 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
@@ -10,7 +10,7 @@
 #
 # Makefile for dcn32.
 
-DCN32 = dcn32_resource.o dcn32_hubbub.o dcn32_hwseq.o dcn32_init.o \
+DCN32 = dcn32_resource.o dcn32_hubbub.o dcn32_init.o dcn32_dccg.o \
 		dcn32_dccg.o dcn32_optc.o dcn32_mmhubbub.o dcn32_hubp.o dcn32_dpp.o \
 		dcn32_dio_stream_encoder.o dcn32_dio_link_encoder.o dcn32_hpo_dp_link_encoder.o \
 		dcn32_resource_helpers.o dcn32_mpc.o
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index 04309412b087..427cfc8c24a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -23,13 +23,13 @@
  *
  */
 
-#include "dce110/dce110_hw_sequencer.h"
-#include "dcn10/dcn10_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn21/dcn21_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
 #include "dcn31/dcn31_hwseq.h"
-#include "dcn32_hwseq.h"
+#include "dcn32/dcn32_hwseq.h"
 #include "dcn32_init.h"
 
 static const struct hw_sequencer_funcs dcn32_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index a74d4cab5a7d..f4cd2fcaafef 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -47,7 +47,7 @@
 #include "dcn32/dcn32_optc.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
-#include "dce110/dce110_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
 #include "dcn30/dcn30_opp.h"
 #include "dcn20/dcn20_dsc.h"
 #include "dcn30/dcn30_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index f11ff6f071e2..05693c2051da 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -50,7 +50,7 @@
 #include "dcn32/dcn32_optc.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
-#include "dce110/dce110_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
 #include "dcn30/dcn30_opp.h"
 #include "dcn20/dcn20_dsc.h"
 #include "dcn30/dcn30_vpg.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/Makefile b/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
index c01d4ab4cdb6..20d0eef1a13b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
@@ -10,7 +10,7 @@
 #
 # Makefile for DCN35.
 
-DCN35 = dcn35_resource.o dcn35_hwseq.o dcn35_init.o dcn35_dio_stream_encoder.o \
+DCN35 = dcn35_resource.o dcn35_init.o dcn35_dio_stream_encoder.o \
 	dcn35_dio_link_encoder.o dcn35_dccg.o dcn35_optc.o \
 	dcn35_dsc.o dcn35_hubp.o dcn35_hubbub.o \
 	dcn35_mmhubbub.o dcn35_opp.o dcn35_dpp.o dcn35_pg_cntl.o dcn35_dwb.o
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
index ae828d5f4e34..534223dbe595 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
@@ -22,8 +22,8 @@
  *
  */
 
-#include "dce110/dce110_hw_sequencer.h"
-#include "dcn10/dcn10_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn21/dcn21_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index d3cc8f4a82d1..b888d483e901 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -49,7 +49,7 @@
 #include "dcn35/dcn35_optc.h"
 #include "dcn20/dcn20_hwseq.h"
 #include "dcn30/dcn30_hwseq.h"
-#include "dce110/dce110_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
 #include "dcn35/dcn35_opp.h"
 #include "dcn35/dcn35_dsc.h"
 #include "dcn30/dcn30_vpg.h"
@@ -75,7 +75,7 @@
 #include "dcn35/dcn35_pg_cntl.h"
 #include "dcn10/dcn10_resource.h"
 #include "dcn31/dcn31_panel_cntl.h"
-#include "dcn35_hwseq.h"
+#include "dcn35/dcn35_hwseq.h"
 #include "dcn35_dio_link_encoder.h"
 #include "dml/dcn31/dcn31_fpu.h" /*todo*/
 #include "dml/dcn35/dcn35_fpu.h"
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/Makefile b/drivers/gpu/drm/amd/display/dc/hwss/Makefile
new file mode 100644
index 000000000000..bccd46bd1815
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/hwss/Makefile
@@ -0,0 +1,183 @@
+
+# Copyright 2022 Advanced Micro Devices, Inc.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+#
+# Makefile for the 'hwss' sub-component of DAL.
+#
+
+
+###############################################################################
+#  DCE
+###############################################################################
+
+HWSS_DCE = dce_hwseq.o
+
+AMD_DAL_HWSS_DCE = $(addprefix $(AMDDALPATH)/dc/hwss/dce/,$(HWSS_DCE))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCE)
+
+###############################################################################
+
+HWSS_DCE100 = dce100_hwseq.o
+
+AMD_DAL_HWSS_DCE100 = $(addprefix $(AMDDALPATH)/dc/hwss/dce100/,$(HWSS_DCE100))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCE100)
+
+###############################################################################
+
+HWSS_DCE110 = dce110_hwseq.o
+
+AMD_DAL_HWSS_DCE110 = $(addprefix $(AMDDALPATH)/dc/hwss/dce110/,$(HWSS_DCE110))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCE110)
+
+###############################################################################
+
+HWSS_DCE112 = dce112_hwseq.o
+
+AMD_DAL_HWSS_DCE112 = $(addprefix $(AMDDALPATH)/dc/hwss/dce112/,$(HWSS_DCE112))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCE112)
+
+###############################################################################
+
+HWSS_DCE120 = dce120_hwseq.o
+
+AMD_DAL_HWSS_DCE120 = $(addprefix $(AMDDALPATH)/dc/hwss/dce120/,$(HWSS_DCE120))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCE120)
+
+###############################################################################
+
+HWSS_DCE80 = dce80_hwseq.o
+
+AMD_DAL_HWSS_DCE80 = $(addprefix $(AMDDALPATH)/dc/hwss/dce80/,$(HWSS_DCE80))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCE80)
+
+ifdef CONFIG_DRM_AMD_DC_FP
+###############################################################################
+# DCN
+###############################################################################
+
+HWSS_DCN10 = dcn10_hwseq.o
+
+AMD_DAL_HWSS_DCN10 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn10/,$(HWSS_DCN10))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN10)
+
+###############################################################################
+
+HWSS_DCN20 = dcn20_hwseq.o
+
+AMD_DAL_HWSS_DCN20 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn20/,$(HWSS_DCN20))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN20)
+
+###############################################################################
+
+HWSS_DCN201 = dcn201_hwseq.o
+
+AMD_DAL_HWSS_DCN201 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn201/,$(HWSS_DCN201))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN201)
+
+###############################################################################
+
+HWSS_DCN21 = dcn21_hwseq.o
+
+AMD_DAL_HWSS_DCN21 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn21/,$(HWSS_DCN21))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN21)
+
+###############################################################################
+
+###############################################################################
+
+###############################################################################
+
+HWSS_DCN30 = dcn30_hwseq.o
+
+AMD_DAL_HWSS_DCN30 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn30/,$(HWSS_DCN30))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN30)
+
+###############################################################################
+
+HWSS_DCN301 = dcn301_hwseq.o
+
+AMD_DAL_HWSS_DCN301 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn301/,$(HWSS_DCN301))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN301)
+
+###############################################################################
+
+HWSS_DCN302 = dcn302_hwseq.o
+
+AMD_DAL_HWSS_DCN302 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn302/,$(HWSS_DCN302))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN302)
+
+###############################################################################
+
+HWSS_DCN303 = dcn303_hwseq.o
+
+AMD_DAL_HWSS_DCN303 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn303/,$(HWSS_DCN303))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN303)
+
+###############################################################################
+
+HWSS_DCN31 = dcn31_hwseq.o
+
+AMD_DAL_HWSS_DCN31 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn31/,$(HWSS_DCN31))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN31)
+
+###############################################################################
+
+HWSS_DCN314 = dcn314_hwseq.o
+
+AMD_DAL_HWSS_DCN314 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn314/,$(HWSS_DCN314))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN314)
+
+###############################################################################
+
+HWSS_DCN32 = dcn32_hwseq.o
+
+AMD_DAL_HWSS_DCN32 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn32/,$(HWSS_DCN32))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN32)
+
+###############################################################################
+
+HWSS_DCN35 = dcn35_hwseq.o
+
+AMD_DAL_HWSS_DCN35 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn35/,$(HWSS_DCN35))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN35)
+
+###############################################################################
+
+###############################################################################
+
+endif
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.c
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dce/dce_hwseq.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dce/dce_hwseq.h
diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/hwss/dce100/dce100_hwseq.c
similarity index 98%
rename from drivers/gpu/drm/amd/display/dc/dce100/dce100_hw_sequencer.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dce100/dce100_hwseq.c
index 753cb8edd996..f1f14796a3da 100644
--- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce100/dce100_hwseq.c
@@ -26,10 +26,10 @@
 #include "dc.h"
 #include "core_types.h"
 #include "clk_mgr.h"
-#include "dce100_hw_sequencer.h"
+#include "dce100_hwseq.h"
 #include "resource.h"
 
-#include "dce110/dce110_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
 
 /* include DCE10 register header files */
 #include "dce/dce_10_0_d.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/dce100/dce100_hwseq.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dce100/dce100_hw_sequencer.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dce100/dce100_hwseq.h
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 5e4e9c1eb4f2..4e14373da721 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -30,11 +30,11 @@
 #include "core_status.h"
 #include "resource.h"
 #include "dm_helpers.h"
-#include "dce110_timing_generator.h"
+#include "dce110/dce110_timing_generator.h"
 #include "dce/dce_hwseq.h"
 #include "gpio_service_interface.h"
 
-#include "dce110_compressor.h"
+#include "dce110/dce110_compressor.h"
 
 #include "bios/bios_parser_helper.h"
 #include "timing_generator.h"
@@ -62,9 +62,9 @@
 
 #include "atomfirmware.h"
 
-#include "dcn10/dcn10_hw_sequencer.h"
+#include "dcn10/dcn10_hwseq.h"
 
-#include "dce110_hw_sequencer.h"
+#include "dce110_hwseq.h"
 
 #define GAMMA_HW_POINTS_NUM 256
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.h
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/hwss/dce112/dce112_hwseq.c
similarity index 98%
rename from drivers/gpu/drm/amd/display/dc/dce112/dce112_hw_sequencer.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dce112/dce112_hwseq.c
index 0ef9ebb3c1e2..ed9b0113a7a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce112/dce112_hwseq.c
@@ -26,9 +26,9 @@
 #include "dm_services.h"
 #include "dc.h"
 #include "core_types.h"
-#include "dce112_hw_sequencer.h"
+#include "dce112_hwseq.h"
 
-#include "dce110/dce110_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
 
 /* include DCE11.2 register header files */
 #include "dce/dce_11_2_d.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/dce112/dce112_hwseq.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dce112/dce112_hw_sequencer.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dce112/dce112_hwseq.h
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/hwss/dce120/dce120_hwseq.c
similarity index 98%
rename from drivers/gpu/drm/amd/display/dc/dce120/dce120_hw_sequencer.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dce120/dce120_hwseq.c
index 45e08c4d5861..22ee304ef9cf 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce120/dce120_hwseq.c
@@ -26,10 +26,10 @@
 #include "dm_services.h"
 #include "dc.h"
 #include "core_types.h"
-#include "dce120_hw_sequencer.h"
+#include "dce120_hwseq.h"
 #include "dce/dce_hwseq.h"
 
-#include "dce110/dce110_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
 
 #include "dce/dce_12_0_offset.h"
 #include "dce/dce_12_0_sh_mask.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/dce120/dce120_hwseq.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dce120/dce120_hw_sequencer.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dce120/dce120_hwseq.h
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/hwss/dce80/dce80_hwseq.c
similarity index 94%
rename from drivers/gpu/drm/amd/display/dc/dce80/dce80_hw_sequencer.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dce80/dce80_hwseq.c
index d2ceebdbdf51..0a054e880801 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce80/dce80_hwseq.c
@@ -26,11 +26,11 @@
 #include "dm_services.h"
 #include "dc.h"
 #include "core_types.h"
-#include "dce80_hw_sequencer.h"
+#include "dce80_hwseq.h"
 
 #include "dce/dce_hwseq.h"
-#include "dce110/dce110_hw_sequencer.h"
-#include "dce100/dce100_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
+#include "dce100/dce100_hwseq.h"
 
 /* include DCE8 register header files */
 #include "dce/dce_8_0_d.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/dce80/dce80_hwseq.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dce80/dce80_hw_sequencer.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dce80/dce80_hwseq.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 817827fa0a0e..2b8b8366538e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -29,22 +29,22 @@
 #include "core_types.h"
 #include "resource.h"
 #include "custom_float.h"
-#include "dcn10_hw_sequencer.h"
-#include "dcn10_hw_sequencer_debug.h"
+#include "dcn10_hwseq.h"
+#include "dcn10/dcn10_hw_sequencer_debug.h"
 #include "dce/dce_hwseq.h"
 #include "abm.h"
 #include "dmcu.h"
-#include "dcn10_optc.h"
-#include "dcn10_dpp.h"
-#include "dcn10_mpc.h"
+#include "dcn10/dcn10_optc.h"
+#include "dcn10/dcn10_dpp.h"
+#include "dcn10/dcn10_mpc.h"
 #include "timing_generator.h"
 #include "opp.h"
 #include "ipp.h"
 #include "mpc.h"
 #include "reg_helper.h"
-#include "dcn10_hubp.h"
-#include "dcn10_hubbub.h"
-#include "dcn10_cm_common.h"
+#include "dcn10/dcn10_hubp.h"
+#include "dcn10/dcn10_hubbub.h"
+#include "dcn10/dcn10_cm_common.h"
 #include "dccg.h"
 #include "clk_mgr.h"
 #include "link_hwss.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index f5a7002302f8..d8c02f83b7d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -29,11 +29,11 @@
 #include "dm_helpers.h"
 #include "core_types.h"
 #include "resource.h"
-#include "dcn20_resource.h"
+#include "dcn20/dcn20_resource.h"
 #include "dcn20_hwseq.h"
 #include "dce/dce_hwseq.h"
-#include "dcn20_dsc.h"
-#include "dcn20_optc.h"
+#include "dcn20/dcn20_dsc.h"
+#include "dcn20/dcn20_optc.h"
 #include "abm.h"
 #include "clk_mgr.h"
 #include "dmcu.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
index 9e027db6d752..d3fe6092f50e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
@@ -28,7 +28,7 @@
 #include "core_types.h"
 #include "resource.h"
 #include "dcn201_hwseq.h"
-#include "dcn201_optc.h"
+#include "dcn201/dcn201_optc.h"
 #include "dce/dce_hwseq.h"
 #include "hubp.h"
 #include "dchubbub.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 43463d08f21b..467812cf3368 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -28,7 +28,7 @@
 #include "core_types.h"
 #include "resource.h"
 #include "dce/dce_hwseq.h"
-#include "dce110/dce110_hw_sequencer.h"
+#include "dce110/dce110_hwseq.h"
 #include "dcn21_hwseq.h"
 #include "vmid.h"
 #include "reg_helper.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index b6d88266e8ab..ed1b2fed696d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -31,10 +31,10 @@
 #include "dcn30_hwseq.h"
 #include "dccg.h"
 #include "dce/dce_hwseq.h"
-#include "dcn30_mpc.h"
-#include "dcn30_dpp.h"
+#include "dcn30/dcn30_mpc.h"
+#include "dcn30/dcn30_dpp.h"
 #include "dcn10/dcn10_cm_common.h"
-#include "dcn30_cm_common.h"
+#include "dcn30/dcn30_cm_common.h"
 #include "reg_helper.h"
 #include "abm.h"
 #include "clk_mgr.h"
@@ -48,8 +48,8 @@
 #include "dc_dmub_srv.h"
 #include "link_hwss.h"
 #include "dpcd_defs.h"
-#include "../dcn20/dcn20_hwseq.h"
-#include "dcn30_resource.h"
+#include "dcn20/dcn20_hwseq.h"
+#include "dcn30/dcn30_resource.h"
 #include "link.h"
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_hwseq.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hwseq.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_hwseq.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_hwseq.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hwseq.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_hwseq.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn302/dcn302_hwseq.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn302/dcn302_hwseq.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn302/dcn302_hwseq.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn302/dcn302_hwseq.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn302/dcn302_hwseq.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn302/dcn302_hwseq.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn303/dcn303_hwseq.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_hwseq.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 65e8504e6063..c339f756b8e7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -46,7 +46,7 @@
 #include "dpcd_defs.h"
 #include "dce/dmub_outbox.h"
 #include "link.h"
-#include "dcn10/dcn10_hw_sequencer.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "inc/link_enc_cfg.h"
 #include "dcn30/dcn30_vpg.h"
 #include "dce/dce_i2c_hw.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 5b197807080e..3a9cc8ac0c07 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -47,7 +47,7 @@
 #include "dpcd_defs.h"
 #include "dce/dmub_outbox.h"
 #include "link.h"
-#include "dcn10/dcn10_hw_sequencer.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "inc/link_enc_cfg.h"
 #include "dcn30/dcn30_vpg.h"
 #include "dce/dce_i2c_hw.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 67687e45f031..d1ed45b532e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -48,7 +48,7 @@
 #include "dsc.h"
 #include "dcn20/dcn20_optc.h"
 #include "dce/dmub_hw_lock_mgr.h"
-#include "dcn32_resource.h"
+#include "dcn32/dcn32_resource.h"
 #include "link.h"
 #include "../dcn20/dcn20_hwseq.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 2be2a2f91434..0e218f9e2a86 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -45,7 +45,7 @@
 #include "dpcd_defs.h"
 #include "dce/dmub_outbox.h"
 #include "link.h"
-#include "dcn10/dcn10_hw_sequencer.h"
+#include "dcn10/dcn10_hwseq.h"
 #include "inc/link_enc_cfg.h"
 #include "dcn30/dcn30_vpg.h"
 #include "dce/dce_i2c_hw.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hwseq.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
rename to drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 844ad5eb8e35..452680fe9aab 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -26,11 +26,11 @@
 #ifndef __DC_HW_SEQUENCER_H__
 #define __DC_HW_SEQUENCER_H__
 #include "dc_types.h"
-#include "clock_source.h"
+#include "inc/clock_source.h"
 #include "inc/hw/timing_generator.h"
 #include "inc/hw/opp.h"
 #include "inc/hw/link_encoder.h"
-#include "core_status.h"
+#include "inc/core_status.h"
 
 struct pipe_ctx;
 struct dc_state;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
rename to drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
-- 
2.25.1


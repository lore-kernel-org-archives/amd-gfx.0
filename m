Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B21C47409
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89CD8214AF
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KAtq3X/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89CD8214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FC8B6FD00;
	Fri,  7 Feb 2020 15:50:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A38C86FD00
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 15:50:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWAKWbTi2+0p7b3quz8mcPEBzJpqnmAk6YiFcYexxjcUEEYog+Y2rUEWfvjfw3vaBP+7lWrPUuZR/SXiV0kK3QU14K2UA56euyuv88omyridsB8DzOb02gpOUCJLrVa58HXYebIGRsW95720M7uSssSKPHe2CHAnk/VY7/yK5G377BFQG1PfPzIjuCGb85Ueh8ZEIZraR5m63bR2ibxbeix+HDQCZFj61S3+fBxsR/esAs5t3c3TwKmzWsL5DQcbK/4eLu5Idjcb3moyPbnSC7JZE5qgEPv9YK6sC9q1etc5aQFKAUKgHu+thfKw4GRxKRn7AKNfhj5YII25n/evvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0twGU/5XFSWlAQfHBHCEtWZPdShYM7trCz84iJWjgLk=;
 b=FRpkfqtz1ghnh0+SBLywnzQoLtV9A49m5WT69VGyKXv5tq4Q2vKHi9IcLHGQokV8f4tipvASTKJ3gSjYVASfO8rJCCHmqCSJ3HkyZeakwKjReb/ws9NiqlOEzBd7lcJpRA58QJ4/F4zb5J/nWQT+4N5qXj1DAjm+0ojohCrypBlQfW9e6oZCghpZbVcjeswx2iq5EKGYn7d7rB1kn+q81DxFCznwclgLY+PV2RwmevbHwwrlwuDBMrJLblslaNMjXe07mj+pIR1eMqXtrhlTiwz8F8Z7MbnflSc3hXjGbUis13BwQUoy3veGdSgSGMJfLM3cXozHGFmGipHkSKePMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0twGU/5XFSWlAQfHBHCEtWZPdShYM7trCz84iJWjgLk=;
 b=KAtq3X/c5OtDfM+CsBjZwA9Zywf9A8Gi9EaeL7xCrdrLOTHGgadecYYcfiZBTreneb1XKcOUMjGJeeGJzlwhC5LJ/U8ZuV0Ar+HuX1SWV0lEHUAGpPxDzF5pJ8C1nyPKqAtbCeHueOe/Dam6SlWt4ALQwX/bkC3bizkb1e2udlU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from DM5PR12MB2519.namprd12.prod.outlook.com (52.132.141.150) by
 DM5PR12MB2440.namprd12.prod.outlook.com (52.132.142.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 7 Feb 2020 15:50:41 +0000
Received: from DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43]) by DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 15:50:41 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/17] DC Patches February 07, 2020
Date: Fri,  7 Feb 2020 10:49:53 -0500
Message-Id: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
X-ClientProxiedBy: YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::32) To DM5PR12MB2519.namprd12.prod.outlook.com
 (2603:10b6:4:b5::22)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Fri, 7 Feb 2020 15:50:40 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb73e227-7d6c-4784-5745-08d7abe57bef
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:|DM5PR12MB2440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2440C35FB6779C3B391F7459981C0@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(8676002)(36756003)(2906002)(66556008)(186003)(6916009)(81156014)(81166006)(8936002)(16526019)(66946007)(66476007)(5660300002)(478600001)(6486002)(1076003)(956004)(2616005)(4326008)(7696005)(26005)(316002)(6666004)(52116002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2440;
 H:DM5PR12MB2519.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QjTH0N8njbEAfvwwVUjZeW6O2qtGItCguVsqhxjU29LRN/5Ra1FeJRHY2VUGa+E9YwwZ0/j40Zfo4AyJnagleVDCCMdu7zUGMOKgXdN2e8scXbD+n81IaaNO/TfNQOfpEhQdoBWP0+eqfxf72Sf3dQYKWKzpPlCA4LR6fAi4fOEUbP4SyWggEmnoHC8g5P2aoLznbZ3Kw8qyxXuCX7uMRJmgxwAyqdirshUJwnLNvNEc7OWfW1t2qSFaN/gX6c+q54v9CeKEtbyWcXv7HZvu7Bv5ljgJBjfoHGfW8dsYFQ5fW+Z1mes2+exCyccKP3TMmrQxkg9GBbOAuxJ1rMz0v88YSydfGuws5Kix2NPkPAj+7VpQXrr7brBgK70o2a97axER5lZV2AKxIvb4FmRLcItAQ6uaiYrqg9ARKl99DsIBfSE7sywPvyAc3tWKARAO
X-MS-Exchange-AntiSpam-MessageData: bDzuSqtykHUP+e7K9QeZxMqhmjhDj7yHCTNJKRlD3zleTjOE/TMID5q27lweD3SHzCAr542QIf1eljdYpun3KG1wtTu5AfOmKGbUE+BfGvZvFhfAwEy9XA1i1rRjKVx0CpHqzlpC22Qm4hITjk6DCw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb73e227-7d6c-4784-5745-08d7abe57bef
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 15:50:41.3147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODULLtXBq7JmYmrpNWT/NdQt/KPP/yqoXG8uL0OUbjbNA9dFbDX5UA9zoNRo2nxXv9DZU0zoSkpxuEfpQ1Fe/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:
 
* Enable backlight support via AUX for OLED displays.
* Improvements in the PSR.
* Improvements in the dmub code.
* ODM calculation improvements.

Anthony Koo (2):
  drm/amd/display: Update register defines
  drm/amd/display: 3.2.72

Calvin Hou (1):
  drm/amd/display: Pass override OUI in to dc_init_data

Dmytro Laktyushkin (1):
  drm/amd/display: add odm split logic to scaling calculations

Martin Leung (2):
  drm/amd/display: always apply T7/T9 delay logic
  drm/amd/display: add monitor patch to disable SCDC read/write

Nicholas Kazlauskas (3):
  drm/amd/display: Don't treat missing command table as failure
  drm/amd/display: Don't map ATOM_ENABLE to ATOM_INIT
  drm/amd/display: Use fb_base/fb_offset if available for translation

Nikola Cornij (1):
  drm/amd/display: Drop unused field from dc_panel_patch

Peikang Zhang (1):
  drm/amd/display: Toggle VSR button cause system crash

Rodrigo Siqueira (2):
  drm/amd/display: Add AUX backlight register
  drm/amd/display: Add backlight support via AUX

Sung Lee (1):
  drm/amd/display: DCN2.x Do not program DPPCLK if same value

Wyatt Wood (3):
  drm/amd/display: Remove unused values from psr struct
  drm/amd/display: Hookup psr set version call
  drm/amd/display: Add psr get_state call

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 161 ++++++++++++++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  34 +++-
 .../drm/amd/display/dc/bios/command_table2.c  |   8 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   6 +-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   8 +
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  49 +++--
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  56 +++---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 171 +++++++++++-------
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  14 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  43 ++---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |   3 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   8 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.c |   5 +
 .../drm/amd/display/dc/dcn20/dcn20_mmhubbub.h |  20 --
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  40 ++--
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |   1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_vmid.h |   7 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  10 -
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |   6 +
 .../gpu/drm/amd/display/include/dpcd_defs.h   |   8 +
 24 files changed, 433 insertions(+), 235 deletions(-)

-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

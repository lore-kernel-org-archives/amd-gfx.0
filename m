Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81814C4743F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 464AA610E5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464AA610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D0FB6E213;
	Tue,  8 Jun 2021 21:40:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B9CB6E19A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmUi0MFFxV5BvazekoRlHjxm/2Tppg7HTKXiBv+K/yDLsVR5H0Nd97XuZh5rEBoHSdKnTg+ee+ohNUGVlEjkbUdyLVIuYdzGyq/oqw2dAh0z4Jf6RHHmPuuH9771PmtyTAipbQ2niqPSBZluYxDybBWBInIScAyhSlpMBx/gUQ0yndd7Q57cOI6VIS2uK9K03RF8XUGpSjVSsCs2I1XXAajdgZmbvZdT/EdVtiTmc9tD2SG5B9z+0mqHtWgvpzGwf6zVPH4KeVCOwXj9enWFUbB6WWdTvrKUmpsPrDY9VoQ+X19vu6ZQVw7JAlWTtojJtYQsgeq9Z7HBAh8IvpLKBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrTUo+LDBRYO5I+X3dTUTrqpppaE6WI9t841fg5uJqo=;
 b=BZkwl8QXNjGWzZAoMbY0OaYVMXKJGZ7MN7g0DUxR9zh93vS42xK/oRLKquFv6Y+nWs1GS4UvmUPpEGgL/0zyH2pWJpS5nJHjs54sGB9YtWyBJ2MNbkaJbyEKf2SDi7aLslXoXa1U2QLAhwvVZdgDLSwf1GKAXMtpLL+YnETA+zd6ooqlCIVjQLIxsje7w+xhID23v9hJhX/sV3ICccytD7WBFmswbPmJtc0YIMm+Yde0l9Z2W14n8Ho83j5CUr8eVd4IxSvVxzDLlupOeCt6/wSnvhxyA9s7ImIllbZqTQHRlFvEVjQqpn7MqYSbWui/h2QLnjgbIdLqLemWgLfsfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrTUo+LDBRYO5I+X3dTUTrqpppaE6WI9t841fg5uJqo=;
 b=x3VXr9oM6Uue2xRNC1JloiRKsJPspilWmBIJTxrRe62ODpjgFQaAcK2g+Lg3ws6Ia5l287Vb5gkaEqtkCF1mnaWoEYDGMSDWZKSDUzQcGEt8ns8J/pJOxQG+imVpSjKfIuIsCchL9cpww1Aii+DjLbdBGzAsgKzfXMXLp38hZuE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3964.namprd12.prod.outlook.com (2603:10b6:5:1c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:13 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:13 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/40] I2C fixes
Date: Tue,  8 Jun 2021 17:39:14 -0400
Message-Id: <20210608213954.5517-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 857eddc4-6ebf-40d0-cbfb-08d92ac5ff50
X-MS-TrafficTypeDiagnostic: DM6PR12MB3964:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB39647EA0D776585E1BEE7A6799379@DM6PR12MB3964.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:499;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0VngIKLkYYd/leCzt3EXRGg3yTuS59YWq7XPgzX7H7eV+6y/9YBol8C67aR3IZo+5qTlxpAYH09YYv6MZ/2jBH2W9VT5SJgXYpxYT0/dFezadsP7tnbiRAgVPPrJzvGGXXz8dmORt7d8UXWJKX9rC2MNrsUcETAJQtrFQN1zM6olW5X8yNiGb/qjWvuLEczJzN98gn1Gg+Usw+jOGAZcLDAmBvUx3jw8XTVIt1e0iY1ZjIg0JRoUFxneAxv+IMq3tiX71JAEVmX2HOqEeXSUZZnZL9+zWNrp6s4R6Cp3aEO6H3E0Eh3e//fTt6AHOJaeR5ST+pVpO/McJyCe9wDVDslI8f7h0sG4KRxsVx9Jh5KhzvOu2vkrlAdDtBAd3ZLpGYGdmeCarqkfrm306wA6NEb6M4Tu+Dp1Wrye8GlI+sfrg90nAf2fOXOHK6Uk1RwJ0Bp9hrH9WsLf9zx0DleQdmU7PlLeSnZmVEH17AWbXyShOc1844nQGm7p/6PnihbjIu2QrGooeZDyRZCIsN20BSpd4k6Sql3JEKj3tn7nhcz7gk5evW1sswCNw5i+TmOkNHDxmDf2BIXbYowxN6pnXV+46btCNtbLNoqRfwV9VZn7ZjJCr1WDKYbPqbJAhxKYCZTHc4IRP2V3q/G2uLJ7QcTm+PXwmswjqMOoFi4Kl9h5SOdRQg7cVZSx7XZceW+97a6KZ5L33jCVbH29AJ3CAkXrCH0LXNA9T4nnPCfmJBeRR4urOkDYh+HP9mWgMbR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(52116002)(4326008)(38100700002)(6916009)(16526019)(5660300002)(316002)(54906003)(55236004)(6506007)(6486002)(83380400001)(186003)(6512007)(2906002)(44832011)(26005)(966005)(1076003)(8676002)(2616005)(66946007)(8936002)(38350700002)(956004)(478600001)(66556008)(66476007)(36756003)(86362001)(69590400013)(357404004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WBuZwMFV4G5eZ+fGqroJUP0x5/7Pr9TAeMZK9RBSL7UB+9i1lKBAA+XOnzsL?=
 =?us-ascii?Q?ZKYzsMirrcy0pAShC+KtN4a94TIm1TENIXPbaGj4DY+Z3wIg6XSvpzIYFhw3?=
 =?us-ascii?Q?mARWmSSnHmyk0ap/+w5z/6MqgDxVKldDEu5n9kkkdvfcwNvWnnu8ITJLd4zl?=
 =?us-ascii?Q?PV4q2ZI3Q61b7qGIZ6xxu9RB9zYktZDr5dCUbN83xyZgbL8Hg6mcrChDmH/m?=
 =?us-ascii?Q?u+5RzvjY1jZpePFqmF5zedriZhQvxUflwuMdLkoFTPxEaTQK/QqCKNC26A9N?=
 =?us-ascii?Q?zjxjdUWMjaaRhKwPUcj6eCf77o3MjJ8185zqP/UfvCR7GYrLTGHOeADDh9h5?=
 =?us-ascii?Q?5O3sOddO3zza1wKikI/NTwPdfH7mMdO4OOcYG2IA3FQQyk/jY5GxKOxIdmz+?=
 =?us-ascii?Q?BRAncswCPkt8wGtfl7QX3Ee3h/OkUFiwhqG9Dv4oeEH0eIAeILzbOo26znmX?=
 =?us-ascii?Q?8eS9Tuzr1cx4CS457qMgJzjM+QmE/vH/sGf3NPEHcG3z9+cLhZb87SGndpNW?=
 =?us-ascii?Q?z7G/RPgNStz92noioepLC44HWvFt+nfMZYW8lUk3IVwPzQcP11uddW2qKaC+?=
 =?us-ascii?Q?PshBthYHxxKdlAMG4tx4A6WPKIHiciqRntikVx2yI6hMcJuND9ZzfB/VPR4X?=
 =?us-ascii?Q?b3gHeuggQKCTFuZ0Kl/F4LMQlCWpGwkyS5LvP5vwZg8v8l20WFKhzMzvUmOA?=
 =?us-ascii?Q?QCC+3Xf+Lyj346QjEi0CFnxkPK90H4ZKmzLM+gar8RUmUs09tadHS8UnmuwM?=
 =?us-ascii?Q?Q7aX42vRVa0PGhudOuKPFaHEYZw2QdcFeYhu+XFtshCIdKvEJLrcg5FOfyFx?=
 =?us-ascii?Q?x3csgOgIagw6Lr+XZZ2XTXM/T1TdQWbriJDgcJrmJ/RLYgLYbZPHHjxxGJox?=
 =?us-ascii?Q?RztY2yedIbtKsTYBJURmzkUcxFUCGMqGD+EHOw0s7v0IykU5vLuN5Uk7Mrp0?=
 =?us-ascii?Q?5G1OU6BLWdSetdFF5kCx5LM9dSoZoXuL66MzQi4T5BLLGGxrPtldMr3+VaAB?=
 =?us-ascii?Q?eJAHhDFqyG80meK1LwEEHWz/gMYGKahqsJMcmazL4uImrdp/Bbix0Hoy8Z4/?=
 =?us-ascii?Q?AHMiVPXVRbQeb43f2BkA7mWK2fkTgA5u78ApIiLPZCNkswySSkMi79pt4yhJ?=
 =?us-ascii?Q?B8uoWn0Wi7kt6yMb3K226N4nLAYSIL7gMWAkB4UxSngPddwe+BlkRy7VwLgt?=
 =?us-ascii?Q?FxldZVOGTuEbSxSDAtZmsmWQNAm7syzdRkloTsEeKF0C3C1AqUXmtvLglAIw?=
 =?us-ascii?Q?jc8l32DeJoGl+U0LDbOt5cdRznQWCIysAARI9/mGjMRCi7CO0dSJXMIqlRsE?=
 =?us-ascii?Q?z28Vrnu9zoPz0fwsoeYg7LJ6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857eddc4-6ebf-40d0-cbfb-08d92ac5ff50
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:13.1743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3uRwWodhW3vFKMZSJpuDuEx7c3BrO/LC7BwVyr7FeP1G6mLmGAkvbL91itiUTxS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3964
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Xinhui Pan <xinhui.pan@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 John Clements <john.clements@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I2C fixes from various people. Some RAS touch-ups too.

A rebased tree can also be found here: 
https://gitlab.freedesktop.org/ltuikov/linux/-/commits/i2c-rework-luben

Aaron Rice (1):
  drm/amdgpu: rework smu11 i2c for generic operation

Alex Deucher (10):
  drm/amdgpu: add a mutex for the smu11 i2c bus (v2)
  drm/amdgpu/pm: rework i2c xfers on sienna cichlid (v3)
  drm/amdgpu/pm: rework i2c xfers on arcturus (v3)
  drm/amdgpu/pm: add smu i2c implementation for navi1x (v3)
  drm/amdgpu: add new helper for handling EEPROM i2c transfers
  drm/amdgpu/ras: switch ras eeprom handling to use generic helper
  drm/amdgpu/ras: switch fru eeprom handling to use generic helper (v2)
  drm/amdgpu: i2c subsystem uses 7 bit addresses
  drm/amdgpu: add I2C_CLASS_HWMON to SMU i2c buses
  drm/amdgpu: only set restart on first cmd of the smu i2c transaction

Andrey Grodzovsky (6):
  drm/amdgpu: Remember to wait 10ms for write buffer flush v2
  dmr/amdgpu: Add RESTART handling also to smu_v11_0_i2c (VG20)
  drm/amdgpu: Drop i > 0 restriction for issuing RESTART
  drm/amdgpu: Send STOP for the last byte of msg only
  drm/amd/pm: SMU I2C: Return number of messages processed
  drm/amdgpu/pm: ADD I2C quirk adapter table

Luben Tuikov (23):
  drm/amdgpu: Fix Vega20 I2C to be agnostic (v2)
  drm/amdgpu: Fixes to the AMDGPU EEPROM driver
  drm/amdgpu: EEPROM respects I2C quirks
  drm/amdgpu: I2C EEPROM full memory addressing
  drm/amdgpu: RAS and FRU now use 19-bit I2C address
  drm/amdgpu: Fix wrap-around bugs in RAS
  drm/amdgpu: I2C class is HWMON
  drm/amdgpu: RAS: EEPROM --> RAS
  drm/amdgpu: Rename misspelled function
  drm/amdgpu: RAS xfer to read/write
  drm/amdgpu: EEPROM: add explicit read and write
  drm/amd/pm: Extend the I2C quirk table
  drm/amd/pm: Simplify managed I2C transfer functions
  drm/amdgpu: Fix width of I2C address
  drm/amdgpu: Return result fix in RAS
  drm/amd/pm: Fix a bug in i2c_xfer
  drm/amdgpu: Fix amdgpu_ras_eeprom_init()
  drm/amdgpu: Simplify RAS EEPROM checksum calculations
  drm/amdgpu: Use explicit cardinality for clarity
  drm/amdgpu: Optimizations to EEPROM RAS table I/O
  drm/amdgpu: RAS EEPROM table is now in debugfs
  drm/amdgpu: Fix koops when accessing RAS EEPROM
  drm/amdgpu: Use a single loop

 drivers/gpu/drm/amd/amdgpu/Makefile           |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |    9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c    |  239 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h    |   37 +
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    |   32 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  114 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |    1 +
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 1253 +++++++++++------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |   68 +-
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c    |  239 ++--
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |    1 +
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  238 +---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  118 ++
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  241 +---
 14 files changed, 1620 insertions(+), 973 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Guchun Chen <guchun.chen@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Jean Delvare <jdelvare@suse.de>
Cc: John Clements <john.clements@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Xinhui Pan <xinhui.pan@amd.com>

base-commit: 84c09f365aba25d3d1d7b36791987ce088294de0
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

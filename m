Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B10C4743C
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B0AB60FF2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0AB60FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D04089C5E;
	Mon, 21 Jun 2021 17:12:38 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2087.outbound.protection.outlook.com [40.107.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13BBC89BFD
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJ14gjWU8ohiOmfPUTAxTKWf0hbFNwgQbOzj/a4DYVhN2JGsF8h7w7WU8oUVMyDWNpom/jc1fRG/YjmYtP1TOHIYKhZ2TjvPYzV6DPOHzCrYdkMKasNubnUlMTq4n99VHJQ31EqkD8VbB+4/BOaBH0K36lcAuIQkWkGu/q7ouK08gCm7gqrJxQjawTVMWr3XSw+AuZz2atDbF0wmELNargb7aFTTmtFEajByFbIy6PEmz0QQelkRNui9+4ZJya5pBiVkc3Am72wqlyGvozpAWBnqnJ3z/GXjR13FneimpbywFP4q/fPGcOh6obf0ZmA97V4Z2z18YCp0q+xMwHNAnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJfxJzn5qcAV2UsBxrYPKS386+saZATNh1EaS7oHzbg=;
 b=mTB/2rX1toRXkMYqW3q5vCwLq8J6Y+4QyHG5uS9RpI68ZMFQcd/gsZDcPRjv/j9Vf5nqGcbcTyox1x1r9scDaqLzMekeo+s0mUXfJMQSefq/SsU1GI87T5Qm4b3sNSGO16dBF4vilHCbQXeWmqqBGrr8/oYWpLHxyQnQe+iomkab/M0vaKnKT7iHcVZpnHecggHCKEkVaHV4mZE1hIhRuRzlNYG10BaCEdQU2MkpX5DarabmBiJ7u59rZpeYQNveMI/WW2sqiqpWDVCbJ+c/i+HE5urd2lrc8voTbZxOJZL8KR81JfQ8tLyAZge4XVYrpvPk1wd9Y/Wtswfdizi3IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJfxJzn5qcAV2UsBxrYPKS386+saZATNh1EaS7oHzbg=;
 b=SA3BKIZBsHjXd0xrI4P4YQLNTe1SDh0fwnr7tXV0SiU5sHNiDIanhw5jNuMteUyG3gzIyRh02toa3yIOaUVhJZQR9291gG33n+kzd6kGvd36iBHhwSFEnXCyX64RVO/+cyc+AbtcYuUqrV9hXn597dfJv5NvrMt8UnO8545oOPw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB1258.namprd12.prod.outlook.com (2603:10b6:3:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 17:12:35 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:35 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/43] I2C fixes (revision 2)
Date: Mon, 21 Jun 2021 13:11:38 -0400
Message-Id: <20210621171221.5720-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfdbc74f-6508-4fd7-4279-08d934d7c344
X-MS-TrafficTypeDiagnostic: DM5PR12MB1258:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB125882EDDA84AB5117B48782990A9@DM5PR12MB1258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:161;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A0KLpoU03Ju9Pz2uMV1VCMpL1QwBmKZMJxQLikn5nBfVJACQN56UnsWYRYs++iez6bHR9PvLdxAEa999iq1aholtO5yZDnqRaFKLQkIe2aB7wptxU5ilgpfEFYhjgedmUd3KP21Zz1P3rzt/3LWIhHAZ2iGjj2QtvuvoA7Clx0mAg4YpiduOaZPA/n8rgydSGqzWwU3QqSSzR9jeMucmrPp0W1QXM641QrYzaH4DdcLzgc5+5E/cPDxppDdTV6XYHvOrU05pWApekjGmAS2l7rBsxidedfn5oYHLWZfsSt7MhmnrLduurxftCcf3c4sOpYo7U1zSiz9lTbSnCMr4xQzCCK+RhsTQxy5Q13MnSFmeN9ITd8Z2gLxuA/UKY8YFsMjTwKCAD1uwn2p0lGYKtcz0dRtkyHr15+W09ahNSxnv5ePlj+Va1hpxtOS9BNJLHn/KHj8SQGCPk6BiAr5JGlwV4qHCEEm5VC0bjgyPmtM3UIsOsCbh9EYYK4gA4m6CrxnhkrY1Ty3LyL+d20yKOYPseNH/dyOGreIXPnSfluIoNshbHCzH9lTfjNf6b71aYkM6DJoD0R3ok1WeFgKk7SuQd+xDo2M5TbgKnLhT3nU97FZSIkR2ReWsCJfPj8j19KOiiRaWt+/183A41a7IrSHxSgBDfWXXyURqPQslpqTY7K5KdtpmPQCa59ibsqgnxO9uL9bagCoLUnx12NJWM/kvUKIOEpJgg+C30Nso2XVDRDyuIy906A8T7EQhzkZ6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(2616005)(55236004)(956004)(478600001)(8676002)(8936002)(54906003)(44832011)(6506007)(38350700002)(38100700002)(36756003)(83380400001)(2906002)(6916009)(6486002)(52116002)(86362001)(316002)(5660300002)(966005)(186003)(66476007)(66556008)(6512007)(4326008)(16526019)(66946007)(26005)(1076003)(69590400013)(357404004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rKvaVK17uTGCTpzVwfvHFkFU8mNzZV5VbF1+QvJR5FyEFssiQ0Glo3uUBuV6?=
 =?us-ascii?Q?cEq5ljnQJ0e3Ecub24lZPXt4pXPh9sYo+d4f+4MI2vKtjlDnAVKqHHBhzHxP?=
 =?us-ascii?Q?8T0MhDczNXXPVntHnCtm3JSz1KjVKVZmjwk8lE8sOMSjSHGr08lUio6XjpjL?=
 =?us-ascii?Q?8LnCcbKrZ/AZWUk2gv4pTXryqYaJ75zDEvczl+MzfIRoR7Cv7eh3O7P5L1na?=
 =?us-ascii?Q?K2Ea98O6qQmgLITAIUP1uyp+Dr/EqvCh8xr7YS/Kk0wjmWbvyH2JEkdbrURF?=
 =?us-ascii?Q?Ao6Z0nw9GTEA+3oNqlJLZbX/0mDGneBZX7+4KdShrC7tdt2off09owQu0M+L?=
 =?us-ascii?Q?WOdqjSuPJl1/Qrfj/w105tySM0ZVPtgNkTvcOrt6BsfqqfhRlFsCa11SXumd?=
 =?us-ascii?Q?9+8rVv3inm2aTXDpjR3oapSNn365PmQrZVr46DKtC7oOvC7oDd91bkBqiJdw?=
 =?us-ascii?Q?YE3tMiurC+4Iqcduu/9YgVS5LP2yoVdxhe/kX9lveTT9EB3iGkv6Tuled8Hg?=
 =?us-ascii?Q?ojy+G738yA07KeBVuDEYdfPVPnRDa3kTaiRFvebE5EhOVE7czx9NiRzMctBW?=
 =?us-ascii?Q?C9DNjMC5l/Z96Eg/REmwBX8AzU4nb870BvEzlflcfGCudjKGevhyn0oRIZpM?=
 =?us-ascii?Q?E9F0j/ilFg0DV1XN0Cw14IQr8cNzM04zvU1Q5SQpyHqCb1CkHMh2HEq1GAZu?=
 =?us-ascii?Q?1jm9AwJOfvxoaACeRchoYD2yMVGBgQoyoxgyzoYfJvrtZPehf8jKCgk0iSHO?=
 =?us-ascii?Q?dIsKgCZzRsmWDYvnFvckLEyV436e9gaEr6A3LSbZjjgPNSSevaEUgdYUicBH?=
 =?us-ascii?Q?YRYLM0uL6LwlXlVDH1jr0VpM/F4nP+9cfqy3UqGJaznkWRiZoFOSuGIwa/D7?=
 =?us-ascii?Q?hofVsMg+rpRK7+h37qhyh3ui9dOhid0IyQhhtjIvimZkITIZnclMtWLCmR2V?=
 =?us-ascii?Q?OQaM0gUMNjEP36YTup5Cf1NJngbNbns8N+inDEVr9FQRXbmRA+CNRGTfKp2q?=
 =?us-ascii?Q?V/xW0YSwI28iRcoThUg1+vKEDDxArdBr0pKkIY5shW/YhrOSPizjo4pMlRu8?=
 =?us-ascii?Q?3MtPYOW5bZaCp5GMJJn50xd7PEVXZtNjcWaBtCVkaJbSaE2z0IUob+sEgUhd?=
 =?us-ascii?Q?5qOHFyyIJpnkgebmJrywK7HRb5DI0SRP0U5DDlj6XQutPkjKd/a4Au5i2T5K?=
 =?us-ascii?Q?KIVDWVQ59ImG/X4zyCEte1PK+cYL0cq28ydmCn/F4ifes1DPj1BO6+creUs9?=
 =?us-ascii?Q?/DSzxCnuTOJGBGhXmXwzxjUh6wWbXA97+vtf61MIfWd14nKhE4DHzuXu4NmA?=
 =?us-ascii?Q?2++WoKgLbkHgF7TFroU8MyAs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfdbc74f-6508-4fd7-4279-08d934d7c344
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:34.9288 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEW9fDphcKHgmcGc661aMijBslAf159KfHvcwMHEwEye0Yvdnw3aTpF+A1o31Lf0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1258
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

Tested on Vega20 and Sienna Cichlid.

This first revision includes acks, squashes patch 33 by absolving it
into earlier commits it fixes, and includes a new patch, patch 40 to
deal with driver aborts seen on large writes to an I2C EEPROM device.

The second revision includes more Ack and R-B tags, and also includes
a break up of revision 1 patch number 36, into 4 patches, in order to
better show amdgpu_ras_eeprom.c rewrite.

Regards,
Luben

Aaron Rice (1):
  drm/amdgpu: rework smu11 i2c for generic operation

Alex Deucher (10):
  drm/amdgpu: add a mutex for the smu11 i2c bus (v2)
  drm/amdgpu/pm: rework i2c xfers on sienna cichlid (v4)
  drm/amdgpu/pm: rework i2c xfers on arcturus (v4)
  drm/amdgpu/pm: add smu i2c implementation for navi1x (v4)
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

Luben Tuikov (26):
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
  drm/amdgpu: Fix amdgpu_ras_eeprom_init()
  drm/amdgpu: Simplify RAS EEPROM checksum calculations
  drm/amdgpu: Use explicit cardinality for clarity
  drm/amdgpu: Nerf buff
  drm/amdgpu: Some renames
  drm/amdgpu: Get rid of test function
  drm/amdgpu: Optimize EEPROM RAS table I/O
  drm/amdgpu: RAS EEPROM table is now in debugfs
  drm/amdgpu: Fix koops when accessing RAS EEPROM
  drm/amdgpu: Use a single loop
  drm/amdgpu: Correctly disable the I2C IP block

 drivers/gpu/drm/amd/amdgpu/Makefile           |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |    9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c    |  239 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h    |   37 +
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    |   32 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  116 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |    1 +
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 1253 +++++++++++------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |   70 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |    2 +-
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c    |  319 +++--
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |    1 +
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  238 +---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  118 ++
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  241 +---
 15 files changed, 1685 insertions(+), 994 deletions(-)
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

base-commit: 5d880fc07b8caaf734a066af61aef8d8c84da04c
-- 
2.32.0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

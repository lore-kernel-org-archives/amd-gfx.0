Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2384DC2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E030760FDA
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E030760FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5AF86E0F0;
	Mon, 14 Jun 2021 17:46:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 886EE6E0EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:46:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwlOzOoRNU8VpK6b3MxAGnwH8LAY1Q5SjttSTZkl8w99vtyRDMcXKzw0JcYlEeOe4EFvX+Ye4C7bVeNAxWmWrPmVKhgWgYhIYLEC/Mru5nrqXiuJGhfHw0TBYdepWUTajPgxfBKfCdjuJV8jM8U/X1u33A6YE2giH4aEE3BpBqhSEAzfwPONmPRwbh8MlNjg+gW+iCJddUKHSFL5O1n7DG63GrdrgBrttYpAq3sMCj5MU5WuYrfadc6wuMOrKBWS+Uw1KbbJvqy4tgF1Rha4TlT0vRGZYOvd/MURYKHKnu0mfUi4yvTgIPpffGARzy1oD8NNqZ75X0pUwTymkwlhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kbpl/fK7WVHNVgZmgLWc3TDf0NNSdWjWov6baMKlWPs=;
 b=nCA3EIoX1m+2U+UUl5pwMn08aA715dO9DLzaCYbB7K/nFRfYNmVyrlqLh6jNt9zDDgPfdTRV/qEM/1uy6ITp3w2nulWUZYVU8dt9FPwRQyP+xoI4HOmfGz8hKQdJWCCcrIK1ax18MMbWayqeQiWqX3lPBcRmyMPvByzZFG84xIpGWxDVoMqh4/Cc9qJ1fMXxBVftyShMzFYtmVTCffHW8LKVuiXIEkfvgrIwsbQJp9ZLSF60qbIst/b+wavz7TyjuI5y/KAi6RqRgeOb5At5MlPfY0Bf58uji2CN+13ItG7xzpirXNBLSPjVg5kvcXKKfsLdAm/7tNR3HduUVdru/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kbpl/fK7WVHNVgZmgLWc3TDf0NNSdWjWov6baMKlWPs=;
 b=weaEfiMNx07RVmRCMezssG/ABbaU7kbS3l90vDJrN4NVQZotZvE+JnfGnTlhVhkkNK655VsSO/vvY1fZh+n088Txy8ASKOg5IaTK9xYFTSPrLqbhT0EnUq7Gz+ltIJgLyWJ83EJPBKFDJiPTxyCDBnjUPdPjIM2LHqlv3BhndO4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3690.namprd12.prod.outlook.com (2603:10b6:5:149::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Mon, 14 Jun
 2021 17:46:47 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:46:47 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/40] I2C fixes (revision 1)
Date: Mon, 14 Jun 2021 13:45:52 -0400
Message-Id: <20210614174632.20818-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::32) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:46:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc9b9885-5b85-4f9a-670e-08d92f5c61d1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3690:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB369075BC76270A5302A6B43099319@DM6PR12MB3690.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:372;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: el4pKrjO6Ox2hl2TW7wCyf2JwfoZauUnN32WNFRKOV8f1DrlVRqJhHhbV05wRuvnIvxQydldB6xbxbH5QaaEIiBa5vFrvABbc0wb510HibKUOYhIZzf69vutjhHqslfWRnOIU2njYnrcGxWBzHug8zzq5vM0RVaetwS8t/iHBFCNcUXlfqyEDCDIjoE5J+G4S9IkqOhbt13C/YlzIK+M7apWRLW5UgkI5vzkfYTR8W5NsXrHienbNh3D/l0n17QTuZ6VxdOmksWg0XEFINv+zEiez6eQ8X5VSMIQ/SyhpQZRWTRW8Ngd3/o4ajBh1vJeMPveTRWXCU4D73kgW+kQwtgz8zS7XJI3S6dgba1TzlmjuBtOGsQZsQTC+wN/2l+xrOlHjDMpAofj9eRI0lcSE8W5mfpB5ue5CyHY4e3fcA7JcWKLmuPJB9b8KQDZpgXfDW4kBBlZrk9HVCpATn9wy1rtbKcduBeksoqoRms2mQVzuWXYI4lsxrDnmCCORbty0oNrIgSGL8FDN7T432jCt5wgGAdXQkkube2o5/Q0LGoI02powIUxffAD442bFDDz/ZBaMA8epK01RokUJaBi2UgAiFTal/Q41wO9itOMmrVM+1ljeeqsp6zWsLMjQ0oGpwyVHU7nccNptlKACERS3i1UuH1CG5Qt4nYOiWXR5KK3Q03X5f/heMiu4kr190jkLsHKX+0PfKHueJQCqRDKY7NmAkywtoTHZ7wEoBm96CQ9EAQUiht7y4DYReT3pV9z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(66476007)(54906003)(6916009)(66556008)(6666004)(316002)(478600001)(966005)(66946007)(4326008)(83380400001)(26005)(55236004)(956004)(2616005)(6506007)(1076003)(186003)(16526019)(6486002)(52116002)(38100700002)(38350700002)(86362001)(6512007)(44832011)(36756003)(8936002)(8676002)(2906002)(5660300002)(69590400013)(357404004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?54VcfxKQN42YUSmNsdODUYeGgadizxz/sZNFVLeFoeBixbhBneTXSA9lZtDt?=
 =?us-ascii?Q?HlGixhqQyXfIkJ0+XesEn3drqa3wKrqcvu+EgnUJeqNo5kud4CA3O2Z9Qayb?=
 =?us-ascii?Q?rNQIaqt3D0tZvWKj4DdmK0y7s8vd1Gjpll3ZGaCRX/r7Ljm+JOKhbZBe3oPo?=
 =?us-ascii?Q?2PuGnVsnYyoJD5WGWI+1RNM4YpoR7RoaXKN1AxXbzXnoMm4TMyIAcZ/C2k69?=
 =?us-ascii?Q?CR+sB0rT7e/YKlETCZdt2ZqlsCjI6Fr0FlQAHnqNiGZubEDKUafojwjHHyV/?=
 =?us-ascii?Q?2zpX7KOWAU1DxjNkSAhXQ9ICPldsmoBROzy7f/kItC3gdP1LnAM2tb51z1qK?=
 =?us-ascii?Q?tWNjN+slcKT2KiJ7ED1zggEcWhnbgRNEzZVBhHwmDSt8lQVEc3o3Em9Mb8T2?=
 =?us-ascii?Q?AJ184zJcf71bKRPrjaxnqsRpNyfui1Cf9+DUsss0aujnVsj/68NtiKSJY13L?=
 =?us-ascii?Q?VKGADYbrGdj38akUR6A0pSycCoFbZtD+d4HBUDGJenLqT14paQq1DuZ5MmyB?=
 =?us-ascii?Q?/bWs2ypR9aThzE5myvzWIGpaMldEI7RXwl3JedeR01t4HJxK5Qq759oMmasj?=
 =?us-ascii?Q?AGKLkLlwjsVc1jv2LSRy3UlCafBkStVJ+ZuIbYuSLA7zOkOEe3ZI6vwvv0YZ?=
 =?us-ascii?Q?L2wkiFCQPp9dVpDFNzbymGgefchpZh23SWLI++nf79Y6x1LK8d9sQiZlQHDr?=
 =?us-ascii?Q?2BuChPokMxq+z7YSptysNHDejhjkIEW1L6SMSQ1hYaRLcBd9uVfAf1xTRRsa?=
 =?us-ascii?Q?4I81cdoFe60/12KXjsHPeEqx2WQ7jd0PJX5/aKeYWvhbVHd5Zi74lUiKa1em?=
 =?us-ascii?Q?g39HGBC+SjA4jmANKjZPyZu8wbtSnOIfGlm+3xtOC5ebCBm3BzY/EqXMC7Pi?=
 =?us-ascii?Q?DReTASHleL0tCsqd065Jf4fxrsW2U+Y5meS2dOjlkNkwfUgSo2966h0u1Ksp?=
 =?us-ascii?Q?cLdigb+IhuQCq4EoVa4EKSEkxa6JyD1UGnAB4fKF2tB2x7VBkqBHkYCYQ0dn?=
 =?us-ascii?Q?RIQNAiQgO+knBWlXFOidvSBxTvy2wfUhyBt/dbwN17pwyzfcWSOFCmJhxwFz?=
 =?us-ascii?Q?7nHYg609cUVpgmUt7iRvy6P7D/X2eG6KunSgqcENNXmAl1DjWVUvlULdnSiZ?=
 =?us-ascii?Q?6LRdJipqou7it98+DfW2A/AaF17JpT51GmLjNTvt/KzwYItjyuqVMG6E9V6o?=
 =?us-ascii?Q?73YYJrzg0TX3XO8uqH8olEu9xy6znE0l5VjrKh4TWBLSHg9WCLZXygFsU97B?=
 =?us-ascii?Q?LKO/Cmpv3NWqv7xKc9XnjPV4RDTvmQROj+2Un4qhoLGrFpq6yJZdVxyvstSF?=
 =?us-ascii?Q?Om1ypiJv0zRwmIoRrlXi1FuL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9b9885-5b85-4f9a-670e-08d92f5c61d1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:46:47.5725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/uwVUIk9msARNtYGXJI/2rRUNPcF3vjNilnv08PCjCFXaX94A6bdinGo9fk0JoT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3690
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

This first revision includes acks, squashes rev 1 patch 33 by
absolving it into earlier commits it fixes, and includes a new patch,
patch 40 to deal with driver aborts seen on large writes to an I2C
EEPROM device.

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
  drm/amdgpu: Fix amdgpu_ras_eeprom_init()
  drm/amdgpu: Simplify RAS EEPROM checksum calculations
  drm/amdgpu: Use explicit cardinality for clarity
  drm/amdgpu: Optimizations to EEPROM RAS table I/O
  drm/amdgpu: RAS EEPROM table is now in debugfs
  drm/amdgpu: Fix koops when accessing RAS EEPROM
  drm/amdgpu: Use a single loop
  drm/amdgpu: Correctly disable the I2C IP block

 drivers/gpu/drm/amd/amdgpu/Makefile           |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |    9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c    |  239 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.h    |   37 +
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    |   32 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  114 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |    1 +
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 1253 +++++++++++------
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |   68 +-
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c    |  319 +++--
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |    1 +
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  238 +---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |  118 ++
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  241 +---
 14 files changed, 1682 insertions(+), 991 deletions(-)
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

base-commit: a6e6e5fdc06791ebf5dbcd1ac64d555fe23f30e5
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

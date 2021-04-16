Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955EEC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 22:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F642613C0
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 22:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F642613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 087886E02C;
	Fri, 16 Apr 2021 22:30:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E0CD6E02C
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 22:30:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NafrKnE2qTfgirdMDeYDvFHWgvZNBxsVOL/nJWyI+syQUFL4bGf0OozrSoQQlaGPgcTe89i3ma5xGYGGtiVU1ytcYApP5/TmgvYn1xzWyXKe9Pe3dBYIurRAyqrUHd0oqp4sDQo3lrKnD+9ajc+gS2j3mNajK9gRDQ9O3KcLeN+pnqh+UxwcNWLk/DEhyq9EVNLpwvJLeVuPC9KNI0121HGS8XgwDzCUzC9FU+Z11TV8MTkwF1YPaCyGZ7vvY05LLI98Wjj0iW+vp8bY+eckU5T/v5nC43TasjNTZy66pD1o3WXswzmEIkCJom0DZmE/L8Cj9PuELgU3pYrllAPZ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6+KekSEvI743JjJyJsXBa2wnvZ6uVDNGYpgCeyz0cg=;
 b=GlZ9RcRyUwAbCZHHJk0I+n96VeEXDkP2Xg1kiPwwcq9RUsTMAP6qjSpvVt2CsbR+wsAieDw5sn0K/4uXxmL9CHRw56QaA1gzuWI5LEZCeMmR5RMl4hA7mrJln2VYpcdeVI7rAJpwP2dDZenY9Qedypor7NG+9llDwPLI9SjfVteQ0pVLEa4wO0Npv61FV3Hs8mgCFdJqjNWgJRNCITDGaGy7gtcxTeILKa9kG/ag8Y/Vb8T1wLU5nwU8fg0PE8Lz6lJWpjCKOSJW4zEaXAy0/1ua7qi2JGC8RpPBQapswDDg4H89jAyuRG81T8ywdbEt2gXkcMTVATzn4zDkXASttw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6+KekSEvI743JjJyJsXBa2wnvZ6uVDNGYpgCeyz0cg=;
 b=4J525y3TE6CybASWaMJny+qOb0GbnFQDoDg43s/+p+csH4MJA+UFnLt2xQYBEfklpEEqDnS2pQ+pDg27HVP1cnW9wMgDGsCxPWzMHXKjSb7uuLKbFqaNHywz/Po4EEiFmgJzpWpzqwCefmOpo8M2QjRjcC6TdHakR7iyR+zqs70=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM6PR12MB3452.namprd12.prod.outlook.com (2603:10b6:5:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Fri, 16 Apr
 2021 22:30:46 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::15e1:cae0:5a38:fb1a]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::15e1:cae0:5a38:fb1a%5]) with mapi id 15.20.4020.025; Fri, 16 Apr 2021
 22:30:46 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/3] Prevent set of DCEFCLK on smu_v11 gpus
Date: Fri, 16 Apr 2021 18:29:53 -0400
Message-Id: <20210416222956.4580-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [142.126.168.190]
X-ClientProxiedBy: YTXPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::15) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.168.190) by
 YTXPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19 via Frontend
 Transport; Fri, 16 Apr 2021 22:30:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2de00455-9c14-497a-5001-08d90127471f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB345271DB88D66D7B1F9250C2F04C9@DM6PR12MB3452.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:295;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/IE8LO8iYACVEzmi67rcbBJ+g0pKzNQucYmfU5pocTFsLd2IpaUbop08z9jeYgzwhoDVbGgLd4l9Tmp1EgltmFdkIUEdCHZ2wXh/4kDDCDjYa+irtpWn5zMjW3t5P9YFFGuXqcBCpm6hxcWUlJwK3cer31UWD23I7m38VRsFDciI3j7edpGQKdbUzoaHT89S9ev757EL6rIT+vUl7G1suz/SpE5xniJyfU549WmOiMTT3U98gWimFy5RRAwtvZ0ApDC6vIyJqBO7s+S9tzQk5x1F6euCnK4OGStr6Vl3P0HdRS2aKrFNCoe0JSBKCp0uaPqxrXHX3Ng3/lM8lVFzzkJiDf2Z+9/fLzAjxJYU1byFvsMAuBQRKZc2bu9dHg1nfNjIVi3w1OeH4uTIO1gHsYXUr6VLBb3btOgd22pPuPw7ZWOQ8R4nW1kfWQEildIOsDyG3MBDofn7i+TKFMBE6QTDBZYZUnqRFnoDvFWEdsk9J+wNpSO021xtKosWSmYB658UdNhWgfK9XuoJdHsX0C+1ISdgq/nkE3exre0TJjDlhH9EIg8tA9MBjyeQJaJAaxKFbB8LfTDeV+r37b7FRu05HROzrZef4rQiwj4+IMaRaAgHTEyZ4HoG8G4VaSyX+eHJ8YDZXa4xtRjoa8TfwmN5Hd7mNOJ0wlGnUX7Iq8kGBjHJ5uM9B/C+7rL1vLS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(6916009)(69590400012)(186003)(86362001)(6506007)(6486002)(6512007)(36756003)(8936002)(52116002)(8676002)(478600001)(66476007)(83380400001)(2616005)(4326008)(44832011)(956004)(6666004)(1076003)(5660300002)(66946007)(38350700002)(316002)(2906002)(16526019)(66556008)(38100700002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PGZ++o3L+HVlVXmaJQ2QvM/GUU7DucsLcbrhRY/U2cfC3gXzicnFz9c3ACgA?=
 =?us-ascii?Q?QJllurKWLUijM1As+dSUrxa7AhPghXqiq7XE25naqjnRJybkYm+01KyuFZuP?=
 =?us-ascii?Q?NKybu6lmQpFtws/VECnZEYzJDcn3uH2l6HKzh9v64iufUTKKpGb0ai6fd1xs?=
 =?us-ascii?Q?s+3Zv4SNdvOkGXa2rRFPACdGMVLcp6JNqzMy//9qGQ+SDkcASlhUtvcXnqH6?=
 =?us-ascii?Q?K/2bVd+Fh8bFnkA1mnXT2zg59YvtE9GJ+myeOEFckMHMmgCP2JDrIeu1ATd3?=
 =?us-ascii?Q?ojj4F87pL5X7uaerNAqWz18xtl27EnIVQA4g9CF8ayg4U33rF+Nk/mRGXiJl?=
 =?us-ascii?Q?0DXBxgNM3pPbdWqc0S0I6GDi9zt4FXi0LbevoDd/vWI0HM3P1ovyPWwrh4K7?=
 =?us-ascii?Q?vXmVY0/gTfkrYxYV25nLRj+Bc2rRIvJ24WygSEehrzzt9moqN+e7jYQHztal?=
 =?us-ascii?Q?WXI6jPYlSix8uqnptNA0SK8+jP4k04okFNiXAQL19yurw5bYfZLMb05cnSMW?=
 =?us-ascii?Q?XLvDgQL/o5Y3tlUzp+x3tSxv8hHHuYg3J2IsGrzLJzDGHcZdxRsJ6uBov5Kv?=
 =?us-ascii?Q?0cIKsxTe+oLt1ReR22Jjc9sIxGrVABD9o4tWHdTR4WTlrNmJDOlNt7ZYLv/k?=
 =?us-ascii?Q?iWzteO2BRcfWf4pXOdSGZhx7OduFO/K/+4vHxENY3sY/2Rj8Yys+e9SO+LYM?=
 =?us-ascii?Q?0o84RNOKyEi0712hKcWRVRkuuCLFJAXXca4Bt4RAm+eOmjYovRRFrTsUX0Qa?=
 =?us-ascii?Q?7NMrvKKs8fTvl1IptKcvloWoqRxPxf7yhxXKo1UXoLCwqkXeC3T5VcjJvMnd?=
 =?us-ascii?Q?D1da9wKUd0fDoaGWrHr1nMuXU/08nRgHdnKHBvuv3wmLJmPaF8CjTxkcslgG?=
 =?us-ascii?Q?d/0Dfn/va1EO+korfxLNDjEmIGmxPsrO+HYPETJWY918/Y9jXEZObMqFfdPM?=
 =?us-ascii?Q?fnvGDt4k3gAjZoXTKZ3qCSf2CxdNM1x5gGiXncyOZsIj/1hHVY/qmTpvvgQ3?=
 =?us-ascii?Q?WzWPqR95qTf0l2m8dqPkTA1GQ4u+ttWtAgevws25qg14eFrbZNx/Cj4qZM7P?=
 =?us-ascii?Q?UDKP1bwnFEUCC8DCK9GUtAGXaRU0/lWYaD9xjoB4sQC1TREswG7UGuizWaND?=
 =?us-ascii?Q?tyNTBTXHketNG0gDiC4VLEVR8joDXjWpT4TipQS83q8k5tbZrQIWLpklUtSg?=
 =?us-ascii?Q?AkTELWBnjFg9MQTfR8ufx67dD8A50sWslQW6LJ86PUqoRduUqBKttvY2jtgI?=
 =?us-ascii?Q?Gnb3sy8dZNa7CcU3BO5u+Dr63Qwl5PwmnDZVNdLc+QjAIuZK4QjHTvZDI1p3?=
 =?us-ascii?Q?IHpngGu1ra+6uVmO+TOqEO6c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de00455-9c14-497a-5001-08d90127471f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 22:30:46.0531 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QMgwaSvCRun1A5SaXuskKOsn6aoWuhU/wzvzkrQpEgz2kVp2SWQn1qmDJGtxCISFiOjnpkZFdafbphjtIM3xKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3452
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
Cc: Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

=== Description ===
Set of simple patches to prevent attempts to set dcefclk on NAVI10

=== Test System ===
* DESKTOP(AMD FX-8350 + NAVI10(731F/ca), BIOS: F2)
 + ISO(Ubuntu 20.04.1 LTS)
 + Kernel(5.11.0-custom-amdinternal-dirty)

=== Patch Summary ===
   linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next @ ef08e194c809
    + d3c010c89301  amdgpu/pm: add extra info to SMU msg pre-check failed message
    + 318e4244c61f  amdgpu/pm: Prevent force of DCEFCLK on NAVI10 and SIENNA_CICHLID
    + d2a9f4653269  amdgpu/pm: set pp_dpm_dcefclk to readonly on smu_v11 gpus


=== Tests ===
General Test Sequence
---------------------
* monitor dmesg output in a shell
  dmesg -w

* launch a root shell
  sudo bash

* set control to manual
  cd /sys/class/drm/card0/device
  echo manual > power_dpm_force_performance_level

* next step is expected to crash the GPU in unpatched and with patch 0001
** system usually continues operation so you can reboot gracefully

* TEST 1: modify pp_dpm_dcefclk to each level (0,1,2) and read setting after each write
  echo "1" > pp_dpm_dcefclk ; sleep 2 ; echo " ---set 1---" ; cat  pp_dpm_dcefclk ;\
  echo "2" > pp_dpm_dcefclk ; sleep 2 ; echo " ---set 2---" ; cat  pp_dpm_dcefclk ;\
  echo "0" > pp_dpm_dcefclk ; sleep 2 ; echo " ---set 0---" ; cat  pp_dpm_dcefclk 
** example output
  [   74.493190] amdgpu 0000:03:00.0: amdgpu: failed send message: SetSoftMaxByFreq (27)  param: 0x000504f2 response 0xff
  [   76.497102] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed and SMU may be not in the right state!
  [   76.497114] amdgpu 0000:03:00.0: amdgpu: Failed to export SMU metrics table!
  [   76.497649] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed and SMU may be not in the right state!
  [   78.501229] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed and SMU may be not in the right state!
  [   78.501241] amdgpu 0000:03:00.0: amdgpu: Failed to export SMU metrics table!
  [   78.501766] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed and SMU may be not in the right state!
  [   80.505401] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed and SMU may be not in the right state!
  [   80.505414] amdgpu 0000:03:00.0: amdgpu: Failed to export SMU metrics table!

* TEST 2:
   ls -la  /sys/class/drm/card0/device/pp_dpm_dcefclk 
** example output
  -rw-r--r-- 1 root root 4096 Apr  7 18:33 /sys/class/drm/card0/device/pp_dpm_dcefclk

* POST TEST
** restore dpm clock to auto 
  echo auto > power_dpm_force_performance_level


Test Results
------------
* 0001 amdgpu/pm: add extra info to SMU msg pre-check failed message
** TEST 1 dmesg output
  [  101.414826] amdgpu 0000:03:00.0: amdgpu: failed send message: SetSoftMaxByFreq (27) 	param: 0x000504f2 response 0xff
  [  103.418916] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed(0xff) and SMU may be not in the right state!
  [  103.418930] amdgpu 0000:03:00.0: amdgpu: Failed to export SMU metrics table!
  [  103.419474] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed(0xff) and SMU may be not in the right state!
  [  105.423226] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed(0xff) and SMU may be not in the right state!
  [  105.423239] amdgpu 0000:03:00.0: amdgpu: Failed to export SMU metrics table!
  [  105.423649] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed(0xff) and SMU may be not in the right state!
  [  107.427502] amdgpu 0000:03:00.0: amdgpu: Msg issuing pre-check failed(0xff) and SMU may be not in the right state!
  [  107.427516] amdgpu 0000:03:00.0: amdgpu: Failed to export SMU metrics table!

* 0002  amdgpu/pm: Prevent force of DCEFCLK on NAVI10 and SIENNA_CICHLID
** GPU remains operational after test
** TEST 1 dmesg output
  [  263.087136] amdgpu 0000:03:00.0: amdgpu: Setting DCEFCLK min/max dpm level is not supported!
  [  265.092026] amdgpu 0000:03:00.0: amdgpu: Setting DCEFCLK min/max dpm level is not supported!
  [  267.096648] amdgpu 0000:03:00.0: amdgpu: Setting DCEFCLK min/max dpm level is not supported!

* 0003  amdgpu/pm: set pp_dpm_dcefclk to readonly on smu_v11 gpus
** TEST 2 shell output
  bash: pp_dpm_dcefclk: Permission denied
   ---set 1---
  0: 506Mhz *
  1: 886Mhz 
  2: 1266Mhz 
  bash: pp_dpm_dcefclk: Permission denied
   ---set 2---
  0: 506Mhz *
  1: 886Mhz 
  2: 1266Mhz 
  bash: pp_dpm_dcefclk: Permission denied
   ---set 0---
  0: 506Mhz *
  1: 886Mhz 
  2: 1266Mhz 

Darren Powell (3):
  amdgpu/pm: add extra info to SMU msg pre-check failed message
  amdgpu/pm: Prevent force of DCEFCLK on NAVI10 and SIENNA_CICHLID
  amdgpu/pm: set pp_dpm_dcefclk to readonly on smu_v11 gpus

 drivers/gpu/drm/amd/pm/amdgpu_pm.c                  | 13 +++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c     |  5 ++++-
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c |  4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c              |  4 ++--
 4 files changed, 22 insertions(+), 4 deletions(-)


base-commit: ef08e194c80952585718ae70a32654f2c0a93bc5
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

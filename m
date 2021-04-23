Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552CEC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 03:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF56461445
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 03:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF56461445
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 492EC6EB31;
	Fri, 23 Apr 2021 03:22:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30F216E06D
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 03:22:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQxLcvZ174F9LshtSQrR2uPyooJuo/tyI/T2CSjNxEs285MwUV9+QOsaUeeSv3OgfPchgBNxGLS6rZu5pTsXG0Z9nlbW71zLJumvHBg8wsDF2zLgoyQkF4vySo6UWIxyBN9R66sql6VQMK0OkqafLOBCAG/VUd3HTIPCoacMjngIJKfgy4ajfvh/pHzV+/otXvEpyLOtKLC+wFN7m6AF0RjO5vBWRp2E7F7kctP09OwfQr4f1z/SYwLwu6fLP1WpDmLTpac2nMdNYtFzrzX3hmjNPmrUH7arsZ2ByDFMKjwRHekiL/qSNGLBkwxpkM41Cf5HJRWGj38WErVJN/0Krg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QX/Al3h7WuwtuEAn9R40QzvWt5oudgV3Enmmc0n8aZA=;
 b=QDmHBj4llkf5v3MdDtDhzVfYqDK2Nkk3viOwGv3YsqA7F7FoZV7mYE7o54mXq82ORR1ZxG/WIg7YCpRZaqx9adS3j3SZlniet19DtLWqJY0CcACigmO2FPLLJUUnqzun4/KdWJBRC48VphlUQUR8jZT9jBH9IDHrA6MuEGUMkqyQV4u8JeNwVG3oBhZgOTVuhrqU2ikBiVw4aZLz+Uv7rEQkFtrYF/AUTqEt+HRZMclUFZOyUScDf6BJFJ9dAIrpRvlneyxp/YDe06XoGxbLXWyA2aMgHauXPQRO+2qQ7gViENydOD3sr3jjvAUaQqhvbfrRT2Koz0AGR3Qhw07BbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QX/Al3h7WuwtuEAn9R40QzvWt5oudgV3Enmmc0n8aZA=;
 b=LOdmEgZu08LGSmxIfnlKcA57coIwFSvwFYGkgoI2/S28t7HnLviHBr00keIJwUz1lvXoGGUkSB+Y2sFICMuoDQuoPXRhKw43Nc+8yMTjNajPa71RzB6HSVqxsOqf8XL4y973KNgfTzQ6GV3njoC1giIUAoD17qkDzJ5RzYpT3J8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM6PR12MB2956.namprd12.prod.outlook.com (2603:10b6:5:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Fri, 23 Apr
 2021 03:22:55 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::15e1:cae0:5a38:fb1a]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::15e1:cae0:5a38:fb1a%5]) with mapi id 15.20.4020.027; Fri, 23 Apr 2021
 03:22:55 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 0/3] Prevent set of DCEFCLK on smu_v11 gpus
Date: Thu, 22 Apr 2021 23:22:33 -0400
Message-Id: <20210423032236.6379-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [142.126.168.190]
X-ClientProxiedBy: YQBPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::30) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.168.190) by
 YQBPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.21 via Frontend Transport; Fri, 23 Apr 2021 03:22:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f501a7fa-415a-4d20-e5b2-08d90607160a
X-MS-TrafficTypeDiagnostic: DM6PR12MB2956:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB29568670081001C1570AE338F0459@DM6PR12MB2956.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:295;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iqU/HX83ii52MtZ6Gs2gcLM7QHOpZTjjmAXan7LMQWBE1YouGb010/z4i6+b9DAOFCy3yt7ZQoyfS+smKMHB+PEkr3wEl8dt9XVLsxGF2clR2mPN0GUN56wqbfvn57hBXxRletjVOo95FL6EwlnRPPvFhWYl585uXbmhbS+DoQJ9pM8lRtpN9AMLWYXwOJ7S962ktGODhhzyGZWDQsV3QUAGj3qgvoRxqhkIhuxMfZpk9tvGFz+G6wmDyWZC19J5V8QDNRE8LeO0G7FU45J+53uyhQi6D4zlMuq8fuhSfOQB0bEj67pneqrHaxyZ5nZReMiviQR0XhsmLIO3Cnwq6ZOCDkU6iJ5UAK/KED85prZizBQsJyaOZM42hlHh0AqaxsqOpY82o07wnVcmc2oBdQvcOGR5bA5LYR6leiku5ZwWuitvy4sZEnM/zpGPKwSU+OwTI80CE3N7UE/xlpDhsLQZFYLMR/MjX9aYDQSrSK6u3GFOvW7JykDR1usJsYIixyheiKMCL6OKy+ZGN77SwL1dX09H70oSA0vJhUGF26lt5d3ZCrPG3ZhFfziKAANeybRSAup6PS9IzuU8wfwA9QQ7+dw04piYGYC1wlo+j7jh/vcBjhUA2MkFWZnA29ydxGDLIshrf6uf/CE2kHzx8F8efqv9AT0BZD6gpGkNl37d6qZyzIG3c52D3bOAEP4N
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(86362001)(2616005)(4326008)(8936002)(38100700002)(956004)(16526019)(2906002)(6506007)(6666004)(26005)(52116002)(8676002)(83380400001)(36756003)(6916009)(478600001)(38350700002)(66476007)(66556008)(6486002)(44832011)(66946007)(1076003)(6512007)(186003)(316002)(5660300002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PoxQz06wBf4yWILWWtsiuS/yaZr0EfygfVeP4YFCBu5lcFjCb7oLlvGhi374?=
 =?us-ascii?Q?smYoUBydEX8Y597kNTYgZQLdpduC6svz5OmF+EwHddbL2baKdUPX1bRbQ6WT?=
 =?us-ascii?Q?c1kHYseii8YJQZj+YcwYKuGAVlnlOfcVGv9iR/eOsiLPGeGhZqpoh9yhbYxs?=
 =?us-ascii?Q?OFI+7utwkL0TsQQZQiHUj3FEvu5Bz+qO+Fe14Qp6R65r1TcvDpHsHhqMR+YJ?=
 =?us-ascii?Q?bpR1aPAQriFu93Xesaz/lBZTbhL9DN/Ra3g4YNoX0mPrTOCZs4voH5NcIo1Y?=
 =?us-ascii?Q?ZoLrIBM6hm1ar0X58DrsYv43n9Ia4y2RfKnHBpV1EhlZgS0uLNEykGwlj7Sv?=
 =?us-ascii?Q?KeykfGHo/hu7umdNi1/D9BKRZ35JXQFWvUFpP5UdswxwPQhByix8rNDCVPjW?=
 =?us-ascii?Q?EP4kQywprBjSF0uQR4+Sc1AvdXs9kCIivUdAf69zwQBdKoOJ77mkIYQ/Gqb5?=
 =?us-ascii?Q?R0t8TBu4BZMMbYoAtxl0Hn+1vxVWk3mVSGOLNNC6xR9bQs+/z5bESKfcEWqe?=
 =?us-ascii?Q?XLXnk2/52M2yAOuByLVqWP2SylBPv3e6siqiIY1J4Sf91nVO7KIKD5AzDEo7?=
 =?us-ascii?Q?86d13KkPRBIqUtKuKNHBO/kZsekv0XTY8aKzDl+SGTjiiO7buChOI86r8/ZE?=
 =?us-ascii?Q?1/z5g+oL+4ts41yKAZpTVPy0v4ObnFka+/CwkjfOZS5hfEtDv6Q9Z9T/xYzt?=
 =?us-ascii?Q?IlheIBJg1oPYyVjBuVOAN/QVM5onCRis3IOoMyDyjPXXZHxqrwyZPB6lW3/g?=
 =?us-ascii?Q?OoMbR7yaGneWwj+uSoJuG+xTA43bSDP4aj7cblQjfj3rKSnciQapvTnBMqF3?=
 =?us-ascii?Q?3EPfXZZc92D1VFMSRXNppud24LCHLKS9GYbVkLUiywWjdkR3rLqHsJEth+5n?=
 =?us-ascii?Q?VH2uno+l1p9BD1DD5+LDfSt2K7dnfj5BCbb6efgws8kXiJrA38c7Ux4t+Ohs?=
 =?us-ascii?Q?4blTk/OXdpXLwH4gVKO30oe2fDLas0JULhcxKwGRI5cqeIQ7cfaTUUT+WXBq?=
 =?us-ascii?Q?dcE/FdoX/IEpqiuh2JqPLlrTqO50jd4Ki5zwUUBne0MXeZCYkbK3qAwZZrWJ?=
 =?us-ascii?Q?hjzYlsEZDeJ4DxSTzmFGq87/qlTbrm10QyvZXwQm1f6PPzXxD41Ep1VPcykk?=
 =?us-ascii?Q?LOC4uycutaAS6fc0/MBMBwl07xqqz7NX+EXHaheOuvX40GREot+uSICEKpni?=
 =?us-ascii?Q?2TYU+8mlO+OxRzJVOtVrkwJED8r6ukai8ZSaitP4XNZQLy76/0dg1a4PQY4x?=
 =?us-ascii?Q?FHQIBBl31YSww/gSOxmtbK8DlvHiwqBXfTtGAM+ezdJmeVDQ+s8xmACXcEee?=
 =?us-ascii?Q?SQXYBAT+JbIDdmO/sOzuUGqG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f501a7fa-415a-4d20-e5b2-08d90607160a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 03:22:55.5705 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gIO29DjEWsK7d+tMJm5PNnPImeSxGAvzBxBHiYOC9MWGZP+qNjm6mA2E+YHzyR0eTuFmMMrn+sS9KM1tqxNcbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2956
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
   linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next @ b54280b32ebb
    + 599f1ebb60cc  amdgpu/pm: add extra info to SMU msg pre-check failed message
    + 291dcf836f45  amdgpu/pm: Prevent force of DCEFCLK on NAVI10 and SIENNA_CICHLID
    + c8ce10fc1d99  amdgpu/pm: set pp_dpm_dcefclk to readonly on NAVI10 and newer gpus

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
  amdgpu/pm: set pp_dpm_dcefclk to readonly on NAVI10 and newer gpus

 drivers/gpu/drm/amd/pm/amdgpu_pm.c                      | 8 ++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 5 ++++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                  | 4 ++--
 4 files changed, 17 insertions(+), 4 deletions(-)


base-commit: b54280b32ebb9381e045e645eabd99dbbe607ec2
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

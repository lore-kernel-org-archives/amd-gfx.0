Return-Path: <SRS0=aySl=3V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976E4C33CB3
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Feb 2020 03:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6820020663
	for <amd-gfx@archiver.kernel.org>; Sat,  1 Feb 2020 03:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="4AJ/KAiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6820020663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1F676FC7B;
	Sat,  1 Feb 2020 03:37:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C2C26FC78
 for <amd-gfx@lists.freedesktop.org>; Sat,  1 Feb 2020 03:37:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCOR+ATz2yf+C6Y4uge9IDPAsGSO0AlAoszDj91dApHC/F+vzWYdCWj5yDLAkjWfGXqP7qLSGtC0v2bUFBr2740tzo0bj0btj+d4JZWGg1H6Ti/xkUxbhDhWYjIbdLqe3L5SM5hWrRdyWl6M398Jv11Yu1eEE3t2SGvioQv6A49q1l5Piyh0o+rXHYgxkxvFMqNOcfBMDT9/N6dHnbdKZ2C/5pmNrwLJf9Isxg2SN3hXZeEIr/czIoBs6Rs9TGD6ddhjKQCM4brWzACm7eMbhALzHsqN55x1sIncfRmYjla/OnZ0A1bz1SBshv4ljkA+ZFX3jVYeOkVEoQPzPB6MDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZJp6V8wnSC5FjgrWzUEtCSq+KjSrdnQMKv1k8jDZsY=;
 b=TRTs1q57w7RDg1EfbpJjRoWjgWyMoYBXIFthQxijb4+5tN4n2Tt11tt72lAmbdhBkvbS9zIDOVOW1DdWuzn1owTy0kREmebC0BlAYoZIFejEaUgE/B2cH73zqoh8U/2OeVO0UAojpBgFBiHA1oIW5x/7HljAmp6BuIX1QnsDX6cNW0zPLzNsiz7D3RkYaT/lPZMT2lwSEp/O1pPdWONhghK+CHCEJw5Sxl5GdsGHUThyoX4p57l8uwKyCPuyTzDOMAm7sxRLqqSISD6JCTJ801MP/SwxFr9JfnabGwscyHNUmwgv21SslYmTjHDEzs8UWIvjs2vPybqODocFcndyVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZJp6V8wnSC5FjgrWzUEtCSq+KjSrdnQMKv1k8jDZsY=;
 b=4AJ/KAiJCkz+f3M6psaZuq4yTc5noZz5W+mYdmAAmJJEOuTsXcRDJGM4ZNqrGO2eoPvaSwmiSOB0/XnwasC455g0N1xKTVOrWHNg3xaM6AMctF4rKR3nK6tKUraK93Nl6t7byjJs/Zxh6v/4fGD0OVnwLYtPLC3UORAPylhHNYI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from DM5PR12MB2359.namprd12.prod.outlook.com (52.132.141.12) by
 DM5PR12MB1849.namprd12.prod.outlook.com (10.175.85.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Sat, 1 Feb 2020 03:37:27 +0000
Received: from DM5PR12MB2359.namprd12.prod.outlook.com
 ([fe80::5539:bec0:f67:934f]) by DM5PR12MB2359.namprd12.prod.outlook.com
 ([fe80::5539:bec0:f67:934f%6]) with mapi id 15.20.2686.031; Sat, 1 Feb 2020
 03:37:26 +0000
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [Patch v2 0/4] Enable BACO with KFD
Date: Fri, 31 Jan 2020 22:37:03 -0500
Message-Id: <20200201033707.16351-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTBPR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::19) To DM5PR12MB2359.namprd12.prod.outlook.com
 (2603:10b6:4:b4::12)
MIME-Version: 1.0
Received: from rajneesh-desk.amd.com (165.204.55.251) by
 YTBPR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27 via Frontend Transport; Sat, 1 Feb 2020 03:37:26 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 75671490-3caf-4b04-d999-08d7a6c80e8d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1849:|DM5PR12MB1849:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1849F170F33C2E27BB304E14FE060@DM5PR12MB1849.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03008837BD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(189003)(199004)(478600001)(81156014)(8676002)(44832011)(4326008)(36756003)(81166006)(52116002)(7696005)(6916009)(8936002)(16526019)(6666004)(186003)(26005)(86362001)(2906002)(6486002)(2616005)(956004)(66946007)(66476007)(66556008)(5660300002)(1076003)(316002)(966005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1849;
 H:DM5PR12MB2359.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DLYuTP7Ge94LtkqWpmNFp8WESFiL5VUw0BpmCoJo0cyXvHb7T3rV5yl99KX7eKF3eavpQZwatCuzR6T/bC2KGbxPqHeXghyliGXEwBoZDU3NFdlTsgn9kpKZ6XsRZd0oZsFmMLQPLewiZjIQbKrKaur2/57a3wuVVJQW8sdFRdDTm0u7Fl17sRu+UR1w0Twignxll1FldY3Hp+Hw+crwhFCrv2ncZBR1iCUBqO8PHZeiE2xGd/8X3WqpORb/Zcz8cIrL0o2BURdUvVNU7Cdh91pTm2BnVE6UosV3YlHOxHsQgCt6AYj3QH7UkAh6KCSkOi2oP0MYgrcpzW6Rtfnngmr9aBjMZl6Y8GTdGktTjfdzWiqzwYReHpB5YNIvfbtTjirgQ7aXd60myNjr3yPjnP0Tch5nsh0r5EjAL3TfAY9D7Zt7ouVM+UF/AmoCvNzpMwkVRNMi0brBRPix17NVngz3+1h261+4II0LazTXCbX9LOe0TfuSEpyTZOoZCWXsj855WQ+HMlRxCApM0P2psg==
X-MS-Exchange-AntiSpam-MessageData: xIvMhm6xBMuqtZGo3100aoLNFK8S7MqvJRMPLPH19aCWdZry8Ji2GIEBqzLqqstw+XFDTo6HyzeYH9IchywwfugW8+Y7HzSt1ordGH1x7hI1LgEGapdcvWllWs0onOsQVY2OOVY4d180gbKv3n/BUQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75671490-3caf-4b04-d999-08d7a6c80e8d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2020 03:37:26.7080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qBLsHKuY0n55CEq/xRTH/ydBOhL+0J9xHEET/wXRCa2prrqyMZHDF159WryeOaD3s+gJTqRYSyz9EhRu2KZGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1849
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
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Changes in v2:
 * Rebased on latest amd-staging-drm-next
 * Addressed review comments from Felix, Oak and Alex for v1
 * Removed 60 second hack for auto-suspend delay and simplified the
   logic
 * Dropped kfd debugfs patch
 * Folded in Alex's patch from this series to enable and test with kfd.
   https://patchwork.freedesktop.org/series/67885/ also fixed a
   checkpatch warning.

Link to v1: https://www.spinics.net/lists/amd-gfx/msg44551.html

This series aims to enable BACO by default on supported AMD platforms
and ensures that the AMD Kernel Fusion Driver can co-exist with this
feature when the GPU devices are runtime suspended and firmware pushes
the envelop to save more power with BACO entry sequence. Current
approach makes sure that if KFD is using GPU services for compute, it
won't let AMDGPU driver suspend and if the AMDGPU driver is already
runtime suspended with GPUs in deep power saving mode with BACO, the KFD
driver wakes up the AMDGPU and then starts the compute workload
execution.

This series has been tested with a single GPU (fiji), Dual GPUs (fiji
and fiji/tonga) and seems to work fine with kfdtest. Also tested system
wide suspend to mem and suspend to idle and with this series and it
worked fine.

Alex Deucher (1):
  drm/amdgpu/runpm: enable runpm on baco capable VI+ asics

Rajneesh Bhardwaj (3):
  drm/amdgpu: Fix missing error check in suspend
  drm/amdkfd: show warning when kfd is locked
  drm/amdkfd: refactor runtime pm for baco

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 12 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  8 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  8 ++++--
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 29 +++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 33 ++++++++++++++++++++--
 9 files changed, 71 insertions(+), 29 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

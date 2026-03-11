Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BA7FD88E1
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 02:45:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9C2710E1FA;
	Wed, 11 Mar 2026 02:45:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BmFixu1W";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012014.outbound.protection.outlook.com
 [40.93.195.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2A2810E1FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 02:45:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykeKc9s33AMG6Y4TIK3/CcKooPuF3ii/kt58JWNv05aAmt8zXBXlk7+8A9Piwn0qCMwfQwQOiIfobSAtC54MJXj3UwSlMfYksatopxnbDVZQ3Z5FBOh6TuPyBD9aDItQfLg1QEL8y0CUCsBPIrEOttlWVr4hMIaCnTe1/Q0xfaurhWjaWCsRS5zBrRTxEdqvIm5lGoI0XZNGRIhkOue3regPaxyJ8/n5dyL7/0j4g3WHfqvgAXY4l4Eheu4rhO8AJZ1Te6u8r+FipkVmrtZQYGr7JQtBUifReQ6HEFz3rp+WLB+OAyzuiialdY+qcvifPlBJgUMrGebX+5FOztMXCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QimPmUuz5QvBV5Vi6nkV+ojCuMkOrQbrS4hPlemHap0=;
 b=HcwYOKfnPVugqbK0sH+NeKf6rsXa2e0Bx8X93lf1gIqvEY4yRG1AG1meC2KpQ7ARfHPv8Yz9SWYmYkI7EcCLF2c3NGUpkQULw8FnNcxNwIbrfPM0at5P9C+DJQF46rxcXBjejFNmc0MVi09L8k1rQBreVWCyr1zOXDDvlnPZyKQOvTIGvnbN/Td3Xid/My6gj/eyQPdJJG1NlkVhmpLSu76aLZb5GKynbDrstSIub5Z0AMyZ5ZpFXeknAtXbD968E6Yw63Iy4JUKmjgSrWwUofgu1FV6CcfgZ0NRlL5bAQdi8Ir1OGN3GckbvpxI6xy6bPkWLKpvoek5Y2k8AU0tdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QimPmUuz5QvBV5Vi6nkV+ojCuMkOrQbrS4hPlemHap0=;
 b=BmFixu1WGkjGLzAkdpPeyDxYqOQYm4vqaYdq7fMPh0lJ22Pc6zkEpqxtJBI5XAsaBaKaLd7x3uqj1HjxxE3WNmUo+0fi/iLXZcM92v/Xh0+1fpolvxyIBqjyPyCioy+qrM7gNtI+3ABAyM8Wg87YTV8UWkBEIcB65+RFCMfCU4w=
Received: from SJ0PR03CA0204.namprd03.prod.outlook.com (2603:10b6:a03:2ef::29)
 by SA1PR12MB6822.namprd12.prod.outlook.com (2603:10b6:806:25d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 02:45:30 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::55) by SJ0PR03CA0204.outlook.office365.com
 (2603:10b6:a03:2ef::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 02:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 02:45:29 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 21:45:25 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, ChuanYu Tseng <ChuanYu.Tseng@amd.com>
Subject: DC Patches March 10, 2026
Date: Wed, 11 Mar 2026 10:40:32 +0800
Message-ID: <20260311024652.2668570-1-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|SA1PR12MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f2e73cd-7dc5-4198-78b7-08de7f1841f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4muuxIX5jyXfC4cCMcubGUnLgNhY84k1xgCrCiY53LkAUdHHmXgInWkv58KzTHxa3bDmIwK2WWLoZl0elzfrLM+tt2KL87DqcbGS87zTahqK5XaQF2f8rygK/HANhX9HEGSvKzcysKYqiRIQ/oeNd35VS0hIYQnjEI9MCwVLonqA4mXKnMvPy6eJ/PSTSi2J3ZjYWmhVwCtoeIa8N3CUBrn3V7JMs3Ur2uH3S9LJauFxca6M00yOkmsqUKj6q8yMQybc6aRgXKSdQnzAt1OBKLs35YvG6QUe3WtsQ8jmoRSgeQgrq9zWEFJpszlWxAlKH7lucFrculqmEOUXf4Iy7J29k9R15vj4Jz4WgAlUEPUnTbCMExhhHePOOz53/B9pNjpNGlv4Ch7pvV1dVCnpD2m6TVmUPjHCczlQAWD3YjPIL2fHsuhzqNZJdipGYaqsVXwqMGV922JcqBSPofNQEYcjdaxwemifECUZ6iVNcQO/yDIE0FmVwXy8GJHNNyUXUJjKjBnWVFAMMsVE4c/+pDG6F9px11o+p0FO/QyQUrynnwqB5UiR5QahVYBX3gXUW/fob8k7yWiTPw/LzV3oxVDEzFbw/JUZMPgS7DJ9JHKOXk7y2P2KNTKe8c6afNg/bR0c8dL2dG8EpDHFLWLWITD17lcgi0aLXIcdFp+U27ZnjbPwyLq/mVczSB+hYo3mBrGM22V0Jk6PZ7dBv3UxutpbzXk+c/j4uRFUTVwQEzXQaiBxEZQx+kx53pTJNtj2KYArAKxn+2+f6s4QJCqmJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W2HrnPfAL5Rj0ugjCvKXbRRupC8fRxLlDqdh/cWb+9s5MN6AFQoIA7HVcHEEq25XT7clWGWlO9DcIHZAfrfd2c9dajhPxz6qz1aDZyRNtlUIcvYdFK4K/r0hqRgI7S0ZJ0ylJ9StRKItPAji1Qw9khcEtvLiVBaJlnKXfK53VYD084DSwOgvj1jXNI+vaLnhe1uvIA2IRgPj0ANuAU3jFCKViWO+zzSvrJKpZd8FrcrSbtLq2kB9YM8t1uH4zby0o7NcTpO3yoI0oKD0PkyLoi+79OOJ//TJZxsTyGTpJQMGm03plMaUjCOJsbRwMLA9U8qkO7MvVmalTOicvzZqMAUmzgiqdLUjn95bLWiALh7FjFHYhLKS0fGw5yq3U+WL4ohqD2AzUmtlnJN1GhQRz9io1p+yoSj855M/MizunrhEH7S/GBl+dT1wJTg/ewft
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 02:45:29.4438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2e73cd-7dc5-4198-78b7-08de7f1841f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6822
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

This DC patchset brings improvements in multiple areas. In summary, we have:

- Clamp dc_cursor_position x_hotspot to prevent integer overflow
- Query DC for gfx handling when setting linear tiling
- Add a buffer for boot time crc
- Silence C6001 warnings
- Plumb MRQ programming out of DML for dml2_1
- Add dcn_mrq_present Field
- Fix number of opp
- Add debugfs to disallow eDP Replay entry

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Austin Zheng (2):
  drm/amd/display: Fix number of opp
  drm/amd/display: Add dcn_mrq_present Field

Benjamin Nwankwo (1):
  drm/amd/display: Clamp dc_cursor_position x_hotspot to prevent integer
    overflow

Gaghik Khachatrian (1):
  drm/amd/display: Silence C6001 warnings

Nicholas Carbones (1):
  drm/amd/display: Query DC for gfx handling when setting linear tiling

Nicholas Kazlauskas (1):
  drm/amd/display: Plumb MRQ programming out of DML for dml2_1

Ray Wu (1):
  drm/amd/display: Add debugfs to disallow eDP Replay entry

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.374

Tom Chung (1):
  drm/amd/display: Add a buffer for boot time crc

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 58 +++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 21 +++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 52 +++++++++++++++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 10 ++++
 drivers/gpu/drm/amd/display/dc/dc.h           | 12 +++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 27 +++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  9 +++
 .../dc/dml/dcn21/display_mode_vba_21.c        |  2 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  6 +-
 .../dml21/inc/dml_top_soc_parameter_types.h   |  1 +
 .../dml21/src/dml2_core/dml2_core_dcn4.c      |  1 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 22 +++++++
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  7 ++-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  1 +
 .../dc/resource/dcn10/dcn10_resource.c        |  9 ++-
 .../dc/resource/dcn10/dcn10_resource.h        |  2 +
 .../dc/resource/dcn20/dcn20_resource.c        |  3 +-
 .../dc/resource/dcn201/dcn201_resource.c      |  3 +-
 .../dc/resource/dcn21/dcn21_resource.c        |  3 +-
 .../dc/resource/dcn30/dcn30_resource.c        |  3 +-
 .../dc/resource/dcn301/dcn301_resource.c      |  3 +-
 .../dc/resource/dcn302/dcn302_resource.c      |  3 +-
 .../dc/resource/dcn303/dcn303_resource.c      |  3 +-
 .../dc/resource/dcn31/dcn31_resource.c        |  1 +
 .../dc/resource/dcn314/dcn314_resource.c      |  3 +-
 .../dc/resource/dcn315/dcn315_resource.c      |  3 +-
 .../dc/resource/dcn316/dcn316_resource.c      |  3 +-
 .../dc/resource/dcn32/dcn32_resource.c        |  1 +
 .../dc/resource/dcn321/dcn321_resource.c      |  1 +
 .../dc/resource/dcn35/dcn35_resource.c        |  3 +-
 .../dc/resource/dcn351/dcn351_resource.c      |  3 +-
 .../dc/resource/dcn36/dcn36_resource.c        |  3 +-
 .../dc/resource/dcn401/dcn401_resource.c      |  9 ++-
 .../dc/resource/dcn401/dcn401_resource.h      |  2 +
 34 files changed, 270 insertions(+), 23 deletions(-)

-- 
2.43.0


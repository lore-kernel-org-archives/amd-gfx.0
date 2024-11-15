Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8F8D6DDD9
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2024 06:09:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0977F10E39B;
	Fri, 15 Nov 2024 06:09:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L8BTrwHy";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A76210E399
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 06:09:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwnjR1uOXcSc4SxH0MlsIGs7NHQ3wIncfqBm+/9FOX6//6kaZjdKKj1SgI/bICT3z87X74S9VpXajbUuoF3jsfJ3JrocFXCZpvbOlUdeq2Kp9CTxFBhtevauumHepAmDficoGIAV9xZ2sx3vRFJOgv6fulS0S8I9qhywxtMPpEuZ6RWZOmt+FGB8XlcjomePNY/+6IN8Og5xPAj4I2yphePFLQrSS3FDr5nIAxpPNjbBQLnhoZwFAHcX4zZJDquWqhh+FK8FHmLAd0jvnjXlXRN0ZZK8fINThM1spM/veC+X1lQWi+4guSYJyAEV/EjmC3Mmh+axQ5yhYPWLHK38Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVbngoasEKuwrF0bfBR412gHdMzM+7rOCRacWM5lSgk=;
 b=ybkAj0KkvnEfxIWMpaPYgs4ecp6dTH+VvF4SBLFDpHwmzSxa+vIz8gmtws6w9EAZm943KMEgcmjiA8tjRePCY4T19Y8yWY9AL5JgzPQ+8nDF0sJG2PRAKCq6zSnu8XFALjSpUpFRP7fgf+wPm04UOWgwwattdhHH/JlvgUg7RED/Oum84ZiDJjLEhzlT/lZmWOkwnAaohG1gBLHJGQ2Z6Jwwpeek6M4V6SAlnDVoE4Nr0I4nn1Nb2v93aZbcGEn2dW1QODs+NnUv9A4JvyZl91HqY523A8V+ZVWQoSBlVg1BNq9HoOXhghSVTSLvnrA874D3Tgdb2O2k/UPz2cLNHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVbngoasEKuwrF0bfBR412gHdMzM+7rOCRacWM5lSgk=;
 b=L8BTrwHywPE/W3otrsDq8+qcZcibWJFNWHjcmALKljSw5YW4Q6jtPIZUMXKItgMleXgHMkIP3zf71eXChlbivYZw42w7ju6L8nu4sQqFL/jkbGEtsIrxBmP3YXSTQUNUu1njzCmV6qBmik3RvWz//Bt0jDS5cq9WaNX9UwSggVc=
Received: from SJ0PR13CA0107.namprd13.prod.outlook.com (2603:10b6:a03:2c5::22)
 by SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 06:09:39 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::c4) by SJ0PR13CA0107.outlook.office365.com
 (2603:10b6:a03:2c5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Fri, 15 Nov 2024 06:09:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 06:09:39 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 00:09:37 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/5] Better recovery from DMUB load failures
Date: Fri, 15 Nov 2024 00:09:19 -0600
Message-ID: <20241115060924.1805-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|SA1PR12MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: 10085dc2-e1c4-454a-a24c-08dd053c16ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RshmXVi5whVJD4CcLOKcgTumkK+NurNYqcrgGuk4xhSZIQiKtwNOHhNA/EGj?=
 =?us-ascii?Q?ZrvQ1fieO7Eber49PLXzByNlEOjVGnFPB83Le+nnN3Lvy8BIoevsZxMph/qS?=
 =?us-ascii?Q?1z1O9RJCptpERLnVIMZh0Vf479DzTSl6rFldRJYMBI6/w99B1JjX3hffK7w3?=
 =?us-ascii?Q?cGZa7SOBokgDMkrZWgnHgDM6I+vmlngqaQOTaOTCEwupGpIBbIQzXw7y1d/k?=
 =?us-ascii?Q?+jTfCXQj923/U8lRvMP9ZaP0MzAWTC08O0EYFFDfl+Jjn4V+D4WO0VtOkQIs?=
 =?us-ascii?Q?DfQffjVFrUY/lB7+qqlQj6RDTxfCvZc0MpVReu9rEjioaMaCkvoCCZenN0bB?=
 =?us-ascii?Q?NdMnJFymauR8Sn6GeKdMbbn4EYLj1U1RWd/NwUe7lcBUitGebdshauiU3sgf?=
 =?us-ascii?Q?i91Sz1bD+EEUppltJ/gFDH56A3V7NhNZ68hp79tFOW1ZAMcQhwWwDx1eoapi?=
 =?us-ascii?Q?hsiax27T34c51oa0IgswwuzjyQhZDKg06eIktjQOA1xd2OK3dl2hNkP4gVK8?=
 =?us-ascii?Q?AWlobzmOmkyEl9S/TBv4tzTKG1wcA8d1J3gifeTcSSxbIcgfuuGr4gOLiAPW?=
 =?us-ascii?Q?OyPzrs4YmDZKxz2Ub1ibc3pKMQdqzX3hfBuRisH2xxkivto+PMtpGYOc3p06?=
 =?us-ascii?Q?gaQro/AWtycHHyQRNc6zd3+5SWvvUsSeG9l6AeI8HPbNCdxlnwaISPvYakwn?=
 =?us-ascii?Q?4M7boQLJ3HG2VNAiWYQh1S76/2EXCj2/wZfCIgirkNVn7uDpWN0cpAesTrfV?=
 =?us-ascii?Q?DM9fnq27ZI66jDKPkl/s/oweFHWiAuf6Dt3liVJSXerSMbjuCs4aEGkmzmE8?=
 =?us-ascii?Q?+QE3/kF8s3vZk2iWC0eTt+8mN7g+unVjdZllzVXV1u77zhQipf7gfgssXO3v?=
 =?us-ascii?Q?I1AbhgNtg4AkLCfwzBebKt+mAavd0W++dkjkBPvs42sfONpkpsJhDp8U+090?=
 =?us-ascii?Q?1eGqXW0S8jKg72IjFqK52Gb3b1UyEaub4oDkfErQ5yuId8xBcLMt5g3PEi/0?=
 =?us-ascii?Q?uWYkMuIv1GB0grpulq0mY2oi+o6hV2XhUEfEiS6C7CGGj/4yMi1LwT/Jr6fy?=
 =?us-ascii?Q?H8GsDJ9MG0oYpbW/B7lPAfB7N9/ZqliWTN7bGQCGndQGwtLycSpfgmYydd8H?=
 =?us-ascii?Q?w1R6rxgQJ6YihgQ1bRAzEj3gf3dNa0SXPVnriWK2zG+LSSfjcYB59yiwqpiA?=
 =?us-ascii?Q?mODd2FNVcyPOJ/RXQuy9AYCM8zdDMbGiV/EgP+AEtCMgDiuHUwaLSPjI4KaK?=
 =?us-ascii?Q?wvU0uoOg/4AllvcksFGbphlq9YcxusjSE+uL8dXN5Li0xzEyH16SbD2A9iyv?=
 =?us-ascii?Q?gMbsF4pfs0Y176oyN+Wx8JOdTh2+IxNalTRaV11z0N/DF7tCECMeG6HqTIhq?=
 =?us-ascii?Q?TkLYuSERDWwflgWW4xp+QUKoJKSC5m7AJKCyMfIwXjr+ijZu5Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 06:09:39.2064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10085dc2-e1c4-454a-a24c-08dd053c16ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6680
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

When a DMUB load failure occurs the amdgpu driver is left in a pretty
bad state because the display core thinks everything is fine.

This explodes once the core tries to do a register read which stalls.

Instead of papering over these errors return error codes up and do
the proper cleanup.
Mario Limonciello (5):
  drm/amd: Disable interrupts after amdgpu_fence_driver_hw_fini()
  drm/amd/display: Fix null pointer derference in amdgpu_dm_fini()
  drm/amd/display: Only free dm private atomic_obj if initialized
  drm/amd/display: convert all DRM_ERROR and DRM_WARN to drm_*
  drm/amd/display: Make DMUB auto-load failures fatal

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 388 ++++++++++--------
 2 files changed, 217 insertions(+), 173 deletions(-)

-- 
2.43.0


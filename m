Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9774DC282D0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 18:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27AE810E331;
	Fri, 28 Feb 2025 18:52:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mlg0mdwy";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D7C510E331
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 18:52:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6KuPvudiB2G64n94QnR2a1t/riG1CAHpW63mPj8+Y9KvX8Q02q4X9V24YNsoIO17EkVPcWGfolRP/6327GDtV1uNNz5tMz1pLTChZHL1V5z+bY1epo1EZ7+S79fo3gXBGP+hU+eX6m3M+WpTdYeOD1G5vLqmWCLBkSLydQe8QuYbpifgsXQfD5DJbCF5Wx5CIIk2h60LoOfMdJYV/55R+b6q5BFwg71TZmMrI+aJOT19kULCQLjt53AJQqaXcbBvGgi5Krob8s5FfGsRW0o3A5NIAdGqW/A40GO+bTaHytgrDaPQyOmkITxB9FbTOuYNlFq/TxE7yQHPqm5hQvVFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xz4WMJuR+uFPXoBP0pnoBVsnfqVlwsZPcBD+ZA2EW84=;
 b=J52qiAxO2v8j+jHpPno75oMbg7BcNpG29Sl9865YM6p4mUVMUDnPMBVL534THazq8Wfhej8MAHSU2TyLZM4OcJHNZiQl6pHL12SQs87wIhFfZ54oZys0tW7O8QQC1EBBs8Q6NpXcIUCmtjL1hYbYVUWfxSUkIo9g9k6fl2kEremj+Y5S9JXBlukb7ryW8Rokg2nKHZrwKS14PGGgk0rhG24YaKtX7AVub0V0A9FjLEqkY0APPxURpXXg2Jw+/Z0+AW9MkSdYux4Zlwivbdjb6ro6cd6faAys3TkqL8AjO7m5eV9ecbrkgUxWr7pcOZG6l5GRE72YwYA+ROd8lKigLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xz4WMJuR+uFPXoBP0pnoBVsnfqVlwsZPcBD+ZA2EW84=;
 b=mlg0mdwy1mzKIuPtK7j9XXLRUZlzzbUmG98qNVPRSCxePeOdRUgKDtJpIemOGbcwg/WjgsS6yJ+h05tO7uubeTGsr4+NqnW8UB4ZW9ihqWXVADl7cnNAPV+7nYOKyXsUy2eUsz62BOpCrHJV2cHqrDt9KyppsBQ26ZevliDQNRA=
Received: from BN9P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::18)
 by DS0PR12MB9424.namprd12.prod.outlook.com (2603:10b6:8:1b4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.26; Fri, 28 Feb
 2025 18:52:01 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:10c:cafe::19) by BN9P222CA0013.outlook.office365.com
 (2603:10b6:408:10c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.20 via Frontend Transport; Fri,
 28 Feb 2025 18:52:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 18:52:00 +0000
Received: from AUS-S16-AI-13.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Feb
 2025 12:52:00 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 0/5] Add custom brightness curve support
Date: Fri, 28 Feb 2025 12:51:40 -0600
Message-ID: <20250228185145.186319-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|DS0PR12MB9424:EE_
X-MS-Office365-Filtering-Correlation-Id: ddf11bc2-1f66-4a91-0f58-08dd5828fc05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ThGPEqCY1+BLE8ZUMWgfMm4AkAhUHjGSWjQasXOtc8+LUt+GqxkcW59I/DuS?=
 =?us-ascii?Q?uw7q6AxGwhOSLMxsMs34udO9PYk0uVkhxAhZfh9kiDl+r+wIiezRMzxY1qLX?=
 =?us-ascii?Q?6aklz1g/r9yqTo6oiUAWJTSrru3LDPQ5IrN4wSw393RhImE635ctedfHakwA?=
 =?us-ascii?Q?uUGOMixAmK2Fye/tNsJ24undeuaM3wDxV2erSSRLo0cD2cQVI1eWmiYF9JUo?=
 =?us-ascii?Q?cV6RchzSS60HrYo2t4dWnFJkCOf45Vo09GD7ja8rCfKqxUAGFSekzuPtVKak?=
 =?us-ascii?Q?IaCN0BCeupJGmNMRYTzxihWc35m7CDmO2tpLqj70Eww1eSUpdKRhA4I64koq?=
 =?us-ascii?Q?6qsjAe47kMzqEmybQvnmtvAMVLB6CXN2CrSDEK7mNRtMtNWj7wTpmx5SdqPJ?=
 =?us-ascii?Q?fsuHCiXxNggakENxcIlGERYsEWyziFdHhmTnFz/fgWauak1tpnSU7phN3A1e?=
 =?us-ascii?Q?4k1j8fBknf6zesPHQ+pxCCxKeKkAXddNASxKVQ6qhabrCMyFOYCJzREqvviw?=
 =?us-ascii?Q?xlnHpm3z+QoD7/hOVAecl9ZxJ/0BHtKY65f09mq7iHOAfptCJAm+65w8SJGD?=
 =?us-ascii?Q?xk253GzkckBAdeTd5FZg5fRdSatpkXFca23f2l8ePgASyuxmzCDgsRyCKxCV?=
 =?us-ascii?Q?9iH5paHatju87f+CDNBmM5sf2ggV14UNnnUspjaq9vihr8Bqpok6NCTHgCmy?=
 =?us-ascii?Q?bqEvgLvfiQrfxr/V5ux6F7D+c3e2ai5bLMqSx7br+2mU2VoxLNGI3Zs29bpg?=
 =?us-ascii?Q?tQYQdKPP3gNQi7UHlY7lb5kDYarVI1qtnWkqKy/BrWS2gDHYiSX40aFAs0Qr?=
 =?us-ascii?Q?5WFdEIHka7dbjGW3fP+WsaGzJ72Ytd5P3xRMPTva8V8lc3m1wIpm/tgH2V9x?=
 =?us-ascii?Q?Ji/hLL9eVW68ck7jGmC9kiIDYJSYhwusHdR4y/CKTx8dAzlPcLWG7k1GebZB?=
 =?us-ascii?Q?FnRKCzjxuYl61iTw6nQxmpb1i1NXELzl4wqeBwsoWawagaDLjBEV8Pxipncx?=
 =?us-ascii?Q?Y1AtiyiBj/SnUp/BgbwSfLX6K9EtVyO98LnX89/Zms1Cy4Yl2hOIzdiK2M1B?=
 =?us-ascii?Q?HX11CMBgdg1yjD5+xRTg6OSKxTFd5D0bnUYgkxFBfqIraSZepMOqlF5MHudt?=
 =?us-ascii?Q?RiziNv+F8IbgIJ7UVFRmbGENz+qbrCbmFI8g448sM29Ib6Ln6joBzWEoS9z5?=
 =?us-ascii?Q?5L8kJI0WRLLC6mr9x0YRfNnO8qv1Cy6/Qas/ay27CLNkqoeSO/Ck1Aqzax21?=
 =?us-ascii?Q?Mg7DjW8wOuY8iiwz1hFcsTQzyQKTalKzNOsfJV4R8mY6GDx6/kQ0x5Ioku5l?=
 =?us-ascii?Q?bD5ekrmabE2oVfrjxH1XIItQPbjJleTis4hvhgT/Pfuyb4CIHagU6rfQnIhF?=
 =?us-ascii?Q?6IMWRpj6r3Uk9Ev028Q4yiYwDIDKl0fzra1uTAoizFHYg0vXXcSH1oY1KtOx?=
 =?us-ascii?Q?VU+FCKRnX9aqrH7aiKyRy4JDJ0HXfpFnfcBdnoytJtc3LEWLlL77xsGLPyGT?=
 =?us-ascii?Q?AgFY8Q3az9zzkh8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:52:00.5979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf11bc2-1f66-4a91-0f58-08dd5828fc05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9424
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

Some OEMs support custom brightness curves where the ATIF method includes
a collection of data points where the input signal is mapped out to
percentage of luminance. This series shuffles around some code to add in
the ability to do that mapping in amdgpu_dm when brightness is set.

Mario Limonciello (5):
  drm/amd: Copy entire structure in amdgpu_acpi_get_backlight_caps()
  drm/amd: Pass luminance data to amdgpu_dm_backlight_caps
  drm/amd/display: Avoid operating on copies of backlight caps
  drm/amd/display: Add support for custom brightness curve
  drm/amd/display: Add a new dcdebugmask to allow turning off brightness
    curve

 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      | 10 +--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 82 ++++++++++++-------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 20 +++++
 drivers/gpu/drm/amd/include/amd_acpi.h        |  4 +-
 drivers/gpu/drm/amd/include/amd_shared.h      |  4 +
 5 files changed, 84 insertions(+), 36 deletions(-)

-- 
2.48.1


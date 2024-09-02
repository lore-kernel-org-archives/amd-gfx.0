Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F56CA0ED3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Sep 2024 07:34:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 343C110E214;
	Mon,  2 Sep 2024 07:34:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SXWJgMEe";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B101610E214
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Sep 2024 07:34:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U82GKxtvOe1At6utbf7BZuZWMoTwq8srEO8+5Ioe6vKD/VcBJFzw//d2MIOhGVogoPq/TZTVcpNdftl/mwPerfV+KaePEkWyKNbXNdhZautCFdCzghxmYsy8A8aslONMjiiaW5Zt8li+USc31kL8+wXqwrsWyuaukmZ0aOoHf+b6xe/vfjGIf1pZo8O5t37lPKe1AYV19LPhNFFNmlU3JM6KGyIxUN2utJ3jTYAiAAYVYEK9Q501g/RGlPbLnWCBpgrAgW5ci3MjEuC+1qXhxFiArdQ4Cr1StSOZ4dMDMUJt/xW7Rl4MHJWDfPn+SFYGj2MsAVkRqX4sR4dc7EdTeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDLRyodz08CGGXAn5HxOMXEF1oxLWKrRGuR3833mIBg=;
 b=x6DLOH9YyD1BAsvEtxgO80ZnQxikH+hy3nokIPBi4sG8Vl3S9E/0EcC+cq/8h6tlQ/5eKaQKZ3c1yopOUOHQcYpXWq0UNqQsHxiYvVLSAHbEQAv0JtJGAJomrnv7EqpPiuUS2bflGB4ezfiKdHRPbKml0WqBcpvZTmvXZ+yDYnIlaTgScI7Sy5pjkqWy1AG6wMDntcfFO3Cs9s4/QtRufJNRmcubPodXU4w3VS6Y7ZcWUVqrK+AcLS4m4Rbtgic/D+XpA/vMwwOIPj/SvB439szyk5NPZexywcVg2N3qO1XHUAQuSm4n/Ht6j8i2iLYwhwKnhuvKupWBDEAguUbsgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDLRyodz08CGGXAn5HxOMXEF1oxLWKrRGuR3833mIBg=;
 b=SXWJgMEeKPWoCzLCMyTn3N4qs26AWCh3XpmZbZNMwZaCZV3gHP5/9f+48jpt9OC8+DqW+KUignr91NitTyj+hgAtOSHuIpfoBQOIZh0+5TpB+GJKg56OIZW4Tr/g8UvISqJm/VJ+v6SVaUM7V2OKrb8EoCEh88WfiQLZ+ghnPJ4=
Received: from BN8PR07CA0033.namprd07.prod.outlook.com (2603:10b6:408:ac::46)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 07:34:35 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:ac:cafe::d2) by BN8PR07CA0033.outlook.office365.com
 (2603:10b6:408:ac::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Mon, 2 Sep 2024 07:34:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 07:34:35 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 02:34:33 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>
Subject: [PATCH 00/10] Support XGMI reset on init
Date: Mon, 2 Sep 2024 13:04:07 +0530
Message-ID: <20240902073417.2025971-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cac0dc1-faff-4e10-d63e-08dccb21b18b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v0aKYG/k4Mu77BZIZvdb6m/ZaRDelOEpQNO8ghtA0LRRmDUiqVQX2TWElUm7?=
 =?us-ascii?Q?qIHWU+BYxuMDgP+RoLSPErl5rQmcCZs4ij+tqZFq07DMBmV7aXffqOKq+XAZ?=
 =?us-ascii?Q?NKXKQFA1labBfIrjYYeTLTEJi2p0vGzOGaB1c3tM4uzeDN2IN6M+67pkT06s?=
 =?us-ascii?Q?86ei8gUUe4VIsQCARcuPmZUIXvpy/sjksoCpRUY5ife9lrfy5UDn6eaaLtT5?=
 =?us-ascii?Q?ZADCJM2lSB3OYst+jvmXDBQmwSl3xu7ulwXrYaqSELwtJNIwwyenlV5UFfzu?=
 =?us-ascii?Q?H80djbIa6Evk2TDoE9cCcLK3gdxp/tOQygSp5kpkW3eP7r05Mpr0qNsIeDrE?=
 =?us-ascii?Q?C9/UAbzxePMdzBZNSvVHjTRBYQJjC0R/oBPdaRh31e/5TKX1772RrvkgGCra?=
 =?us-ascii?Q?wfJFmYQsIlIsw2vVNLthhm5oajncI8WujClbqD97ihYCx5ACrFyiZf2rCJ0W?=
 =?us-ascii?Q?DBEPYCipa2fTKWpzquCWbhA54Yh6taoq2vw9KsSJeV5/uCJNtPwo6/F58dol?=
 =?us-ascii?Q?dsnONPPo9L/74ZcjB+FkSO7k6MVdVcR8ePfejtdPwhIpav+esunllHVVMDVt?=
 =?us-ascii?Q?jnNjRSHaeyMa9f3NWF6LGSdP2d7yJugzTqWcQ1U83VooxiaZkuR/n7p3Zqc7?=
 =?us-ascii?Q?rlw9aWtyPtZhahuH++OHxggU48L/LPcPjgat5gflCek4LqebLhDUWfz7kZS+?=
 =?us-ascii?Q?5wUEkBjjLUz8WLS8UhPCVIfL/iieSnn2JXWXJ3kf8BBpmZk8b7rRl1ar20AF?=
 =?us-ascii?Q?uqpB3cR+nOc3JXJr8f2sZVWiXikMc3aLPgAAOd2jLTC47hIL5mvtdQkl9J4E?=
 =?us-ascii?Q?7kkfPnAMLs5OuDyz047JlTTifCV9LBAnY+3KT84FwdMnkdfI9CwY0UPj/yj5?=
 =?us-ascii?Q?txR1UpRGFt03+ssRnwz2c5HRDd/H1XCgaQs8oxErIACq7LFwxEwd4n9BnPJs?=
 =?us-ascii?Q?ZONKZ3b3fqIqBnU/V9/PW4V3j4e1Ovcs8J96bLGEG1wA+nSTnFCHDQJLyYBJ?=
 =?us-ascii?Q?b5PC12mbMD5IUZZWk1+p8iwfxqpdaptpympYsyLXuPZzxYoC20Rm9/jJZ0Mu?=
 =?us-ascii?Q?AjOmPTrFslabRh334T3+9cyJzoaoiO5AXAVxbOGVu5E+jnkCiWICiFvM7k5x?=
 =?us-ascii?Q?E5E7guc1xfr2BpBaaIo0Jmgj+49yCZ1x0/HV9udySR4dnb56lyHIlKWOyqZl?=
 =?us-ascii?Q?CpJA2hhzBIESCYVvaIbrcLAwC5ZTS+SIfz++44gqBCHoc9ppWE4rc4pFDG73?=
 =?us-ascii?Q?SDmoNxGsgi+9swtEvWMj+YJESHkxGEkZXPnde/SN7Cqq6AQ+mzWJf5tHfR5i?=
 =?us-ascii?Q?UVI4Y01yKQc8dPF8byJxbKnMelKB+KQWbo0Sdq3G95cHBSZRhLUI/Jao30xK?=
 =?us-ascii?Q?eRikg7rHk+/3+glWB+sphExSTIrNxGKIBAOO6jt37sRhMvlgZ2LCJ+IGSkZr?=
 =?us-ascii?Q?eOgAmbdS6nUPKVURgWDtOw19n9wEgWRG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 07:34:35.2077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cac0dc1-faff-4e10-d63e-08dccb21b18b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468
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

There are case where a device needs to be reset first before it is fully
initialized. An example case is a driver reinstallation with a different version
of PSP TOS. In such a case, if a device supports reset in which PSP TOS is
unloaded, then driver needs to reset device first and then load the new firmware
components.

For devices in an XGMI hive, a reset needs to be sent on all devices in the
hive. Thus driver should discover first devices that belong to a hive with
PSP support.

There is an existing delayed reset handler, however it has the below
limitations- 
1) It doesn't discover devices in the hive, instead it tries to do XGMI reset
for all devices registered to mgpu struct. mgpu struct may have other devices
than the one which belong to a hive. Also, if there is more than one hive, it
doesn't work.
2) It doesn't take a reset lock and since this is a delayed reset, that could
result in unwanted hardware accesses during a reset.
3) It doesn't initialize RAS properly (left as TODO)

This series overcomes the above limitations. Instead of marking a pending reset,
init levels are defined where the level of initialization may be defined. In
case of a pending reset, only specific hardware blocks may be initialized. 

Further work (not done in this series) may be done to have fine grain controls
for init levels - say skip enabling features like DPM enablement, or skip
loading specific set of fimwares as they won't be required during a minimal init
scenario where device is going to be reset.

The series adds an API interface to check if a PSP TOS reload is required.


Lijo Lazar (10):
  drm/amdgpu: Add init levels
  drm/amdgpu: Use init level for pending_reset flag
  drm/amdgpu: Separate reinitialization after reset
  drm/amdgpu: Add reset on init handler for XGMI
  drm/amdgpu: Add helper to initialize badpage info
  drm/amdgpu: Refactor XGMI reset on init handling
  drm/amdgpu: Drop delayed reset work handler
  drm/amdgpu: Support reset-on-init on select SOCs
  drm/amdgpu: Add interface for TOS reload cases
  drm/amdgpu: Add PSP reload case to reset-on-init

 drivers/gpu/drm/amd/amdgpu/aldebaran.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 245 +++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  81 ------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h       |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  62 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     | 148 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h     |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c      |  72 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h      |   2 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  14 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        |  25 ++
 drivers/gpu/drm/amd/amdgpu/soc15.c            |   7 +
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |   3 +-
 17 files changed, 492 insertions(+), 214 deletions(-)

-- 
2.25.1


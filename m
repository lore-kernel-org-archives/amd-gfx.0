Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7239FCA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 12:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0295510F557;
	Wed,  7 Oct 2026 12:21:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Uzf6aws";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AB1C10F557
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 12:21:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8OALxhn9p1yBFsJGy+9nxo9+s09VskeALVHUSLhALlGC/JoZJhoDxYSygDqVxKvvfIC/ezfrdxpwJ1MYz9YBW6rjd7CTtDkdFKqoIIxoKuNo3E/XZNe7KqlQR9fAmFmA3/bFbQlfxkn8pIUbYLb3UaVOIrlUsCBL2rhhrZHKm4ZkH8UujMoRb0C34E3mrw5utx+iZ0lEKfQObQlAXMvhTHf+Onv1t1EzTv0LNtWiGsgv0KT6Llirtdfa6aT+BfzP18cDrN9ExOoNxsOZsVVTuF4cULrqYAU9gjMz30KHd6qnGfkPLVMABOdEeNPCC0FidVbDbIR0WpJZ7WkkMKtsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCjUNPX8Zw7DPpJx6ivPpla6CQrBoX+6th6WZ93QycI=;
 b=I/HEnbFrQpb7KjSd9Nudoc6xtxyGUIOcl0Rfb4DDLTWU3IwUIkGE2vToKO58Zj4IJQnDu+JmJwi222dvWbfXr0POUDGEEpCKfIxvt+IWZPyEFqPLyQzWKKNKJuOv9d7noCPfSagzP3IWCTaGQwbQppR0l8A9FmK0K5UjlY8VslvXntbMofC7HAFZwCJKdU3GTW+iQLOVe3jogpZuY4GyXhZl7HGp/OUwQ0sC004WkOGLnQb2jUYdxJR8+AUAEB0BOMZKOWtF5OwzU6Isznm6baLmyYsrwp60or8aDir+fHeeyjBT7M3GJedXDlPShayyvjFKx56T/YtHx5fgcFc9Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCjUNPX8Zw7DPpJx6ivPpla6CQrBoX+6th6WZ93QycI=;
 b=5Uzf6aws5TgNUUS5TuoP9E/u/V9DVRW3dIkhXK4xOl1+xpAXmICuqwYQ3ukXaBhLtM9n+1aj1jYFAqkepMZBiSNqhLxX9+gA/GQeHRiES1xjlduffRqw5p8J9RpacgH38oF+VCXmv/20PBPTq+1jz1PWK2yRooVQ7tMCTr1En4Q=
Received: from CYXPR02CA0026.namprd02.prod.outlook.com (2603:10b6:930:cc::9)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 12:21:13 +0000
Received: from CY5PEPF00000E79.namprd02.prod.outlook.com
 (2603:10b6:930:cc:cafe::61) by CYXPR02CA0026.outlook.office365.com
 (2603:10b6:930:cc::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 12:21:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY5PEPF00000E79.mail.protection.outlook.com (10.167.247.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 12:21:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 07:21:11 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 07:21:11 -0500
Received: from rtg-Cloudripper.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Wed, 7 Oct 2026 07:21:08 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Lijo.Lazar@amd.com>, <Christian.Koenig@amd.com>, <Felix.Kuehling@amd.com>
CC: <Priya.Hosur@amd.com>, <Pratik.Vishwakarma@amd.com>,
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH 0/1] drm/amd/pm: report the default performance level after a
 reset
Date: Wed, 7 Oct 2026 17:51:02 +0530
Message-ID: <20261007122103.4019578-1-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E79:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be569bf-f76c-4c38-61e6-08df246d7a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|11063799006|260925021911599003|10067099003|56012099006|260925021311599003|260925022911599003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: kWvsFHYz1n3J+C8V+OVtx/7lmh1HdA57XltpDc+n+FgDxELZRUhomMMC9CzXLOOhosQWCN7GG7LIwglT6+V+S4j5f0rsh2hPESEHMsrl2QJ4xgTlY/DBkg024DmLGuPuLA1lt9UyHTFxF82nef27yHmjijRMfNlxcX9UOlVTFCwzCYWzXJV2yR9rcLN7R8xD0Ei5lwLHOFnmqJA3Z2idjvFqmz1+JasvNciAkdSOn+VxfhcCFRM3gOjszofJlElAQMHFCbL1GkylQX5OS6VTfMzvvkrb+Wln0G7vI5xjVTQrmJMv8AFM3wUS1/4iNKhbqJTIySK4fldP9PUnSx5187DommZIDbsm9S4K8XdTqEDXC+kTnpzH2yML0aWE79DcGVD3v0LJBKamzGCYrHxJfjwpK7q+rylXBPd+HF9aLc0zfRYFDFUPWf865G7JlPeJnnbdtiNNl9ot/VGxVkMZeiyQpUyfZNUxOCGoPRXI1148WqZRobPkrziaK8woG0jKG9trFv6VTF1kcZZxWGp7ltg/tWZlQxZqsOvQrpiqlyhQ0mUGPArabwZceV7WLBFzRgK1cDbIBKYTqB390q9LUYu2keNEgtrvjbDTeiwCna2bWGHkgY1RpTp5pxpl2zMlSeQkvapxSbzzJppaJygaZb5nbdfn3KLRIwQ2noFshse7+QEC/OI42fL3FmVjHjKol6IN0sTtZCbrbNv0J4wfBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(11063799006)(260925021911599003)(10067099003)(56012099006)(260925021311599003)(260925022911599003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kxN48XVSOjzcqsBXnCDCLS9fHWU0xZdPUdHTwaqYjpo7zfsgD2eTaFjufnvWEkXvuJNBqANyvPUwC0S8dUJx4SBcRagX9SXGYUjBn6AWl/EF5acaE8jH5Efu2fXcEUjaIZhjyhx6T2SoZnHtyblrvrxtBKhTp2NqWiA1Dlxltlh2JgzniNgz0aB2t7iLWQdrv2WG+Cl9Ajyq4wmhEi2tFkITtDAsxEWUhVB58KHzv9EI0HVQwdPwgorY2e7cLHb+6O05Sk3U0y7bKixxisZB0aBgJpj27x/yuVWiShDzrnzb9AcdWzPg25mfMCYSIZYjm9an0BV1YulQ4mfUZf3B1JSEtqlOnfaG2gDBfHAjIZUNQhPk0zewpZ3GMOVwtqiCNAu5pAygg879HI0TQ3u3qN/SBkjMXggw3XERNYaHJNOZHp+tdyZoXjFANOkSbvXN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 12:21:12.8567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be569bf-f76c-4c38-61e6-08df246d7a29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY5PEPF00000E79.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989
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

After a GPU reset the level reported through
power_dpm_force_performance_level no longer describes the hardware. The
reset reinitialises PMFW, which comes back on its default curve, but
smu_dpm.dpm_level still holds the level the user forced, and that cached
value is what sysfs reports.

On an SMU 14.0.1 APU this shows up as gfxclk dropping from 2.8GHz to 600MHz
while sysfs still reports high, with no thermal or power event involved:

  before  level: high   freq: 2799000000
          amdgpu 0000:c5:00.0: MODE2 reset
          amdgpu 0000:c5:00.0: SMU is resumed successfully!
  after   level: high   freq:  600000000

The stale value also leaves the user with no way back. Writing the same
level again is dropped by amdgpu_dpm_force_performance_level(), which
returns early when the requested level matches the cached one, so only a
genuine change of level reaches the hardware:

  after reset            : 600000000
  re-write "high" (same) : 600000000
  toggle auto -> high    : 2691000000

Since the reset often goes unnoticed, the machine quietly runs at a fraction
of the requested clock with no indication to the user.

The patch resets the cached level once PMFW has been reinitialised, so that
it describes the hardware and writing the level again takes effect. It is
scoped to reset recovery only, as PMFW retains its state across s2idle and
the forced level still applies on resume.

Tested on an SMU 14.0.1 APU. For each level: set it, trigger a reset
through debugfs, then write the same level again.

  level          set        after reset    after writing it again
  high           2691MHz    auto 600MHz    high 2691MHz
  low             600MHz    auto 600MHz    low 600MHz
  auto            600MHz    auto 600MHz    auto 600MHz
  manual          600MHz    auto 600MHz    manual 600MHz
  profile_peak   2081MHz    auto 600MHz    profile_peak 2201MHz

Every level reports auto after the reset, matching the hardware, and writing
the level again takes effect in each case. profile_peak sets a ceiling
rather than a floor, so its sampled clock varies with load.

Suspend/resume is unaffected: high at 2771MHz before suspend, still high at
2799MHz after resume.

This is the only configuration I have available to test. The change is in
generic SMU code, so it applies to every ASIC going through smu_late_init().

Priya Hosur (1):
  drm/amd/pm: report the default performance level after a reset

 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.43.0


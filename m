Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228FDC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 06:37:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A4056E1E8;
	Wed,  8 Dec 2021 06:37:03 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2074.outbound.protection.outlook.com [40.107.102.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F4496E1E8
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 06:37:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lR49uoV+FMy8WT+AStnTc+Wl9g25zgf3a/UC3qcWwqhpb655028XA+KmTzlxyu+3PonkbTb6sHN/uNOtbbJxEAvcj1AKFX8DM5hJQzTdPrrhmhya1bkJZrdqqtvlSVt1FhQNrLB99PP7euHdMgeN1a1XVBwKJ+6vO7g0G3DLvFjYTO757DrDygEQ4ZJ/qZzNGTAqWmOwc3A6/PRw+RiKnC1S/sobmTR+8PNtsRKSQkeOszWzphFc4Dco/7lTVusAEIvL0XGp8sDDsj0fkhTbwN2twzkPY+l979dP8kLoX3NMy5VH8j4ztfPlF3Ue/RRoOrttEcF6JEhGwwH7aZhRIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVGY9MsuyNcX8QFIbrBqEkxD7sfBbwX2ToV2pitDzhA=;
 b=jlm2hLQQuF7pPvmrpoUTgNY9II/xdkFzzbrQdueBgVTde/Rn6mhQtb0aVB0qzUCIoHpeYYyuqpOTDa3kIqbPlmvQHH1s1nblMpZolqCPaHdL9eOTDT4SHlX8toUWQNuOaJfNMqyWZpuajchQ4BYwEkRIj49NY8GkvVO+cVvDEWlqoMv4zU4fM1Bov3G+mqzTcnAjfdPlSpPYfiiI/LO77DkFuQccbq/W5pdXs3+Wbt3bfOBZ+lEZQqIr9X7sLSyer0ulvEKRRiD/dcIzL0pdGfXjDT7+7RQcIDKXj/+oLAu3ObaxcK1CoDrEyjoC3/1NJnqotUvmUEWXb0DOicY6uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVGY9MsuyNcX8QFIbrBqEkxD7sfBbwX2ToV2pitDzhA=;
 b=DPiHCWK24WH5xFTPN82Jrot8IBLeglU5WxD0kp54J+cr068HeMjCul09vP8TlgX+zfX7NS3z/OQxcrycKy058aDKwUQbPCn2iQm1KDgz9Fgx5m8oG33INV7dN/6qA6R+bqdOlxmt8NX7RNSFXLN1bpkP2sOJ/J4tH8uXyPifaYQ=
Received: from DM6PR21CA0002.namprd21.prod.outlook.com (2603:10b6:5:174::12)
 by MWHPR1201MB2540.namprd12.prod.outlook.com (2603:10b6:300:e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 06:37:00 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::af) by DM6PR21CA0002.outlook.office365.com
 (2603:10b6:5:174::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.4 via Frontend
 Transport; Wed, 8 Dec 2021 06:37:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 06:37:00 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Dec 2021 00:36:59 -0600
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] amdgpu/pm: Implement parallel sysfs_emit solution for
 navi10 
Date: Wed, 8 Dec 2021 01:36:06 -0500
Message-ID: <20211208063609.5593-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3d41613-4c36-4115-8c9f-08d9ba15239f
X-MS-TrafficTypeDiagnostic: MWHPR1201MB2540:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB25404C8F827C3FCD58F4245DF06F9@MWHPR1201MB2540.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7XbZUJ6wRDgSkN2oJCNl5QZRkbuB0qpsTDYjrQegdcv3Hp1cDubDxoQ6bkKxn0GbeAyHyOI0YJ5f436miL3nq9GOHghFpVVf3R6/3h42gL9GcEeOvVBgRSKI5rq2dxWbfYaIo3dHUvvO+eZiNeW3wq1PkCAvFlAPoB0htPg+4+p8jiWnocBt9H5/RxMKNpsNgcuDBwNezaiqAy0ZWduPeVvR36/ot0PESmWMHk37bN45caGByVy0VBB5EH4YdjzLQmXyTE9TyNhFqaERu25ItnZ6Rh7TKIFboUnW0LJdpCp027HkTo7io1e4Te+JtQeON12QfEgnxl2JLrO5wQ75snaSTKN1iPKkJMBquzD/9nxTsbx2hT2j4UQoI4J1bS30FIODuo7aJqRmcNPkT4rsgMhIKzme2S4oqnHwixMrCKCBLG+NQn8evpkYkQ4aVcTOF9doPdKuEV48HYyocOpkLXeBs4gW2pQst64VsrNFxy2M9cFWSzMYTr/psV0u+TmGTix0zvob9k9ozJoW40l2VWL3CpXo0ICHCh+2tF5gXEcoCB484ePT+mpIN/yLdh9rKXEjJc1pxttRv1kgN2zthDByGIdC+UL+yZsEVCJjBIG0pQpeDmO1Iy0WL8K3oOGdn12jKCj09JFKKIMUDGVfF9ALJhTP3e5i/QmfzTIDc7pfOw2vxAkd4j6pMQEr2YR/xtiWyzcaraSslKDP3r4iPoIfm+zDKOlvDSVOAKrVSJFD/eYXQ41AFmUQJxrWZHK5sKNKC8Yu8ZoVChcB+ASMt/0cw51lW2UsXZc+yh5fhM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(1076003)(26005)(40460700001)(316002)(36860700001)(6916009)(7696005)(186003)(86362001)(4326008)(16526019)(2906002)(356005)(5660300002)(81166007)(508600001)(8676002)(2616005)(70206006)(47076005)(70586007)(4743002)(44832011)(83380400001)(6666004)(426003)(36756003)(8936002)(336012)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 06:37:00.3436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d41613-4c36-4115-8c9f-08d9ba15239f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB2540
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

== Description ==
Scnprintf use within the kernel is not recommended, but simple sysfs_emit replacement has
not been successful due to the page alignment requirement of the function. This patch
set implements a new api "emit_clock_levels" to facilitate passing both the base and
offset to the device rather than just the write pointer.
This patch is only implemented for navi10 for some clocks to seek comment on the
implementation before extending the implementation to other clock values and devices.

Needs to be verified on a platform that supports the overclocking

== Patch Summary ==
 linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next @ be0118f90e18
    + 351ae7734898 amdgpu/pm: Implement new API function "emit" that accepts buffer base and write offset
    + 76c13c49fc6b amdgpu/pm: insert attempt to call emit_clock_levels into amdgpu_get_pp_od_clk_voltage
    + 28c533371023 amdgpu/pm: Add Error Handling to emit_clocks stack

== System Summary ==
 * DESKTOP(AMD FX-8350 + NAVI10(731F/ca), BIOS: F2)
  + ISO(Ubuntu 20.04.3 LTS)
  + Kernel(5.13.0-20211128-be0118f90e18-fdoagd5f)

== Test ==
LOGFILE=pp_clk.test.log
AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}

lspci -nn | grep "VGA\|Display"  > $LOGFILE
FILES="pp_od_clk_voltage
pp_dpm_sclk
pp_dpm_mclk
pp_dpm_pcie
pp_dpm_socclk
pp_dpm_fclk
pp_dpm_dcefclk
pp_dpm_vclk
pp_dpm_dclk "

for f in $FILES
do
  echo === $f === >> $LOGFILE
  cat $HWMON_DIR/device/$f >> $LOGFILE
done
cat $LOGFILE

Darren Powell (3):
  amdgpu/pm: Implement new API function "emit" that accepts buffer base
    and write offset
  amdgpu/pm: insert attempt to call emit_clock_levels into
    amdgpu_get_pp_od_clk_voltage
  amdgpu/pm: Add Error Handling to emit_clocks stack

 .../gpu/drm/amd/include/kgd_pp_interface.h    |   1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  65 ++++--
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   3 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  18 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  49 ++++-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 188 ++++++++++++++++++
 6 files changed, 301 insertions(+), 23 deletions(-)


base-commit: be0118f90e18e3fb8191f17f51a9addc93d0f185
-- 
2.34.1


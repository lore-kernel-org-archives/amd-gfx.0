Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C424C77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Apr 2023 06:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92C2710EA92;
	Thu, 27 Apr 2023 06:27:54 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03B5310EA7B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Apr 2023 06:27:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANtkhOlPoBTcVBJB8Dww0S/63qaYkQH1UmmHgHsOnJD0anMbjHDRhd9HrazbB4zqaU/LkBwk4YjucOdykMK6liSX+NJsUX0B4GebcTBxlw0mUoOf87lgrCNEH5bgxanznkI2HINHML9H/WfbR1f1hTOJQQEqLkpJ43im1KVHJnVa52hfbJo4ur0heUaRHhCT01hCCSdT99EP3YA+TC+/0KJOTGKhooqca9XK9iIZ3JUrw2M75zQLcjDSdJO4FdfTsUo7dRL/0y1lRu1AOgZc9zTaIi+P1De0DJ0zZ029VMf78IUhMh3jYV+MTriXnA3ybrTd+d8MNuelB9tceIajOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4fiUTp48nY398S85AdQc9tWyIfO3MA9y41674W0jhh4=;
 b=M2WkCSVifS89BPeF2TvxQQaP3ABhdM0jmYJT0IAQgSdkWVSS7G61XCCqYpz4w7SVYTFM+7s4/zHEz4DZ4gyzJPjKlQ8i3cKbCVucePKntx+W/xTq2kkTLdPpjZR5aawwEIxncQ0RYWkgmc5ejJKuURmbdP/MU/34D95SZuZA45go44yr65smQDIjftaUZFeakg9swmFPv2Av1tTbp1c3iG7qQiijHjib5zjDm6/vlOlUAgClB1ZOvqio4+9SMGVgHUQYKwOxw1o9O1rw9sxssKCz32cvsErsotOecBFgljOxl0qpdroajML64e2xQcir+1vKg40FzOLEcoSTA7bzOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4fiUTp48nY398S85AdQc9tWyIfO3MA9y41674W0jhh4=;
 b=0Su6I3mZw5MSUDdhzXQ9PWpBbovbnBwRaQRphAsxBNe71xA2pqBKJ3FztLQ10XKlQELr0CXjApFNjaSC1mbNC1Z+3NBFxBJPEiRdUHoKNYzC9KGw3nw80Emu19nBZ7hnwN+1GcTTqT45czetJrZV1duLkKatB0Ip0LCc9AU1Rm8=
Received: from BN9PR03CA0767.namprd03.prod.outlook.com (2603:10b6:408:13a::22)
 by PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Thu, 27 Apr
 2023 06:27:50 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::d8) by BN9PR03CA0767.outlook.office365.com
 (2603:10b6:408:13a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Thu, 27 Apr 2023 06:27:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.22 via Frontend Transport; Thu, 27 Apr 2023 06:27:49 +0000
Received: from DESKTOP-U2004.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 01:27:47 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/8] amdgpu/pm: Implement emit_clock_levels for arcturus,
 aldebaran
Date: Thu, 27 Apr 2023 02:27:10 -0400
Message-ID: <20230427062718.1172269-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|PH7PR12MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: dc59d996-a228-4c9b-d5ed-08db46e88603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QB3U28fAD3shArAmng8LMd+cBi1AF5egbbp3QrifjSob1HkPIpQr7JKy+4tULOFpXBWjA0xMkxbdcNk5CuOl3IElL/g0IKQW1cIjdMIqNapGjlAKRCrCnRV4MhCQz+XmHXUdbRGKuQum9bgphaXvxS9IO1A6ljQMVmRqmQNlN67SpgOn1XcmSmhkUlMEdgd44uoThKGT0W5LaKRssXeNg6+N8djwrETamQ3P5W/tfkCJVJqgpELD50Sq/76yF6ZFidFqzQKblMNNkAGOn+tGUJBk94/OFHwK32joYLKyVzTFKvX5gZxBL2cZ6RZ7t9I4zB8kB157UUOI3SA5HslaDkoKfJudCW+SE3UHrvwT/I3WGSHebYeHtvMy6Ym4X0fmZaK4CMiDSrBmisbecs4ENeFXuIUxqc8KHaFLH62UQK97JWWLTYdCAhs8nQ6DGJ/F1AbAxddygQz5QxdDam/tM9p8pRfz7sWo1IWXkjsROxZ2qaWS9DDk2DenlS1+BEE3bQ1I9eMU7vsf8U7fQ140q7g7Nb9/gfMuBGWGhg4LEuMGRZYCXvdf8igguO5q+tne06D6mC+XW8AxgCY0D5ZGZBWPiCAwBzkbMCAuz90DfpLA40BVy9mVhBOMq0LeIniCjW64qtn+dl5grt4b9EG/dPIxcye/nYr9ByLhb5JJTIIksd3+pe4Y6prDdgGXi5rSD3yVpmTfw7vftjvK3I04yGHWQ24QRGPVBV1Yr5sYDIk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199021)(40470700004)(46966006)(36840700001)(83380400001)(70586007)(44832011)(82740400003)(4326008)(6916009)(70206006)(2906002)(36860700001)(40480700001)(26005)(1076003)(82310400005)(316002)(6666004)(47076005)(2616005)(8936002)(426003)(356005)(336012)(81166007)(8676002)(41300700001)(5660300002)(7696005)(54906003)(86362001)(478600001)(40460700003)(16526019)(36756003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 06:27:49.7343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc59d996-a228-4c9b-d5ed-08db46e88603
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7988
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
Cc: lijo.lazar@amd.com, ray.huang@amd.com,
 Darren Powell <darren.powell@amd.com>, evan.quan@amd.com, lang.yu@amd.com,
 david.nieto@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


amdgpu/pm: Implement emit_clock_levels for arcturus,aldebaran

== Description ==
Scnprintf use within the kernel is not recommended, but simple sysfs_emit replacement has
not been successful due to the page alignment requirement of the function. This patch
set implements a new api "emit_clock_levels" to facilitate passing both the base and
offset to the device rather than just the write pointer.

This patch set replaces print_clock_levels for arcturus and aldebaran platforms with 
emit_clock_levels, and also optimizes the code to reduce the code duplication for each 
different clock. This was spread into three parts to show more clearly the changes made
to the code, followed by combining the common code into a second switch statement.
It is similar to previous work on vega10 to implement emit_clk_levels
 commit a63e6b83 ("amdgpu/pm: Implement emit_clk_levels for vega10")
with the addition of the optimization to reduce code duplication.

== Patch Summary ==
   linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next @ 2d8c6b82e241
    + 9a269da4c047 amdgpu/pm: Replace print_clock_levels with emit_clock_levels for arcturus
    + 51ce0fcc9599 amdgpu/pm: Optimize emit_clock_levels for arcturus - part 1
    + dcaa5b7551dd amdgpu/pm: Optimize emit_clock_levels for arcturus - part 2
    + 1d16d820e4ee amdgpu/pm: Optimize emit_clock_levels for arcturus - part 3
    + b374fbf6013d amdgpu/pm: Replace print_clock_levels with emit_clock_levels for aldebaran
    + 2ecf48d3e83c amdgpu/pm: Optimize emit_clock_levels for aldebaran - part 1
    + fd8c21e1d1e4 amdgpu/pm: Optimize emit_clock_levels for aldebaran - part 2
    + a67ce808f18c amdgpu/pm: Optimize emit_clock_levels for aldebaran - part 3

== System Summary ==
 * DESKTOP(AMD Ryzen9 7900 + NAVI10(731f/ca), BIOS: 1.11)
  + ISO(Ubuntu 22.04.2 LTS)
  + Kernel(6.1.11-20230412-fdoagd5f-g2d8c6b82e241)

== Test ==
AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}

lspci -nn | grep "VGA\|Display"  > $LOGFILE
printf 'OD enabled = %X\n' "$(( `cat /sys/module/amdgpu/parameters/ppfeaturemask` & 0x4000 ))" >> $LOGFILE
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

Darren Powell (8):
  amdgpu/pm: Replace print_clock_levels with emit_clock_levels for
    arcturus
  amdgpu/pm: Optimize emit_clock_levels for arcturus - part 1
  amdgpu/pm: Optimize emit_clock_levels for arcturus - part 2
  amdgpu/pm: Optimize emit_clock_levels for arcturus - part 3
  amdgpu/pm: Replace print_clock_levels with emit_clock_levels for
    aldebaran
  amdgpu/pm: Optimize emit_clock_levels for aldebaran - part 1
  amdgpu/pm: Optimize emit_clock_levels for aldebaran - part 2
  amdgpu/pm: Optimize emit_clock_levels for aldebaran - part 3

 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 166 ++++++----------
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 181 +++++++-----------
 2 files changed, 132 insertions(+), 215 deletions(-)


base-commit: 2d8c6b82e241f2d1a802ae6bbc24c127e689c724
-- 
2.34.1


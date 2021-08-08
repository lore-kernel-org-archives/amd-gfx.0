Return-Path: <SRS0=EBpG=M7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8CAC432BE
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Aug 2021 05:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DDF360F42
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Aug 2021 05:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0DDF360F42
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C308A89CDD;
	Sun,  8 Aug 2021 05:30:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E6AC89C86
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Aug 2021 05:30:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXUphSJ6yrJx7l2AbQrYJDuFf+DqirtyFFSmI3tmo91UclJ3YtJShCCpX+cOAXIbJmnbGsFU03If5xCaxu6H+dfbPH0SPU3dYSUOZ3M8RYwH5GpMkHcsT0Lk9nUeRin8zFitScM/pXSsQJ0VHx2ke4xXTVFG0INmYkf4lmBSxWmiCtDTPOvZEa9eGeTUiYmQ8gQRZbe5p/o6YYw+/FSvZlQOQntnqOhmffxSrGv19prbiZUQPjsamfDnGp2calensz5pnTaQdYNlwoJtwvJdMLB37ei9/HociRl/aXk1kLCdGRfxiKIEqPYY+MNqs1YFuxuhgtEQ/aFBlr20d6HouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lF4NnR+Rp5pp8Jhf9oKRmwnLq5C///NIEuPWSgQHMJg=;
 b=ifrzTLTzG5FsREf7+N/Iep7UytTfUqhYiLlinn1Cffhs4sAMijG+TP5Hky0sOCaT2lCR1YdKE364YROM5/kyfcaSOp6JxI3G0NHGTCden/zWD5E/25tqs5tPOtXV7t0wchx81oAAWt5O6PFey+vyQAedrb/UTf0AmogfETwi6PCEeIptWH8fKZZzAoLrFGk+3AwaY4o4lagw01anKNzOSC3X+Nx0HXYDEolmApl9PZvrVaPkxiWpKJABOnNAa43VyfEZjrn5onVPxCFxDwxSgufCQa8ClkQPl+NZngrKxmjeCi4E5ulT7GcBsGESJS3ezvNtSnQNeEu3WN9uxv83dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lF4NnR+Rp5pp8Jhf9oKRmwnLq5C///NIEuPWSgQHMJg=;
 b=TgiuItGxvXTzw2u+dWmljaOMFqR8g1tlmHcOS28c9Eb/qMXHiVa+ybp00z36P/5KPO5QRSTbiNDvCRvhqq9t3pC16/kEbvyrtZ/0O9WvMZl+BG1FUBGjrSu6LqrXoLQR6vS138NLQJDBLIFZnLzgD5db/fhF4TyEA3BKw1s1Gqw=
Received: from BN9PR03CA0328.namprd03.prod.outlook.com (2603:10b6:408:112::33)
 by CY4PR12MB1144.namprd12.prod.outlook.com (2603:10b6:903:3f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Sun, 8 Aug
 2021 05:30:35 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::e4) by BN9PR03CA0328.outlook.office365.com
 (2603:10b6:408:112::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17 via Frontend
 Transport; Sun, 8 Aug 2021 05:30:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Sun, 8 Aug 2021 05:30:35 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 8 Aug 2021 00:30:34 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Darren Powell <darren.powell@amd.com>
Subject: [PATCH v2 0/3] Replace usage of sprintf with sysfs_emit in swsmu
 powerplay
Date: Sun, 8 Aug 2021 01:30:16 -0400
Message-ID: <20210808053019.3310-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4aec9f4a-2601-4a49-4271-08d95a2da5f8
X-MS-TrafficTypeDiagnostic: CY4PR12MB1144:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1144798F11787B0177D9803EF0F59@CY4PR12MB1144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:317;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u3O4RIog1NC6MoOoCAR9isTc6rBpUwvFS56liKK67naYYoeiPQ76iFXWaxMOxzimAyY5O1yBNLuWEVBExGGvkALV2t65HHSoF3u6UVJiOB6NlQ1QhXL/49V97ijOUlJQmY1MKH3BN6q66uvoB9Hhdktw7k3HV43p7wvd1KG9JzhBDO/Guh5nGyUz50b2EGXuJx3FEJv3wfWcQLJ/vxSg9AAulg4Mejd8RzyxbqdvX5IlJJczSHMN1LSOhtcKnlGgWfO0H6L7hKneRjt45oxfhe0pBkyXKCgqVESRFbukxWD76qIM6mCyln151XqDvICfUEksJArN2YNQWGykv/j7iSTPPBN7451h2L1aGjVJlpbBb5oCEI9uplCOL+ehCO8Q0oIPONgUbkKplzqBXekPcPOlLOH4cL0MYozRdn7jzQB77Aeyyod7xD5WXSvFWFXSvyLOtdmGX9opBg9XC1ceBN9HiB+MwglQPI9EhdDnBDc6XI1wF5cy0U/7ifzWxC/0VEhXu0iTyxCkqzyaq8eepkwtw1xFtoxqI9VHvMiQjYMXQSUapM8YFSHrV+ZRz2h18dxgyRnE/NR3gfEZE0DFH7fm1xmKpVL0+sJeFhtkPwyvcQXr9tPZO7juW8Vj3G5SsWoEkrNzBFKVmTS8yDoHTR4NPjKjHx/R3mkHqYdPTDqSo5F7ouBM1KjzfVIVq8LfP+O45LhM/L8PKAPIMwdbJBXdR6Mctzno7+9lczJorRdzsVnovGQidpbFvBNVsEUMdqfG7jFz0KI2WwE6Qc3qlA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966006)(36840700001)(47076005)(8936002)(81166007)(8676002)(83380400001)(356005)(86362001)(4326008)(6916009)(2906002)(316002)(82740400003)(478600001)(26005)(5660300002)(70206006)(36756003)(336012)(70586007)(82310400003)(36860700001)(426003)(44832011)(34070700002)(2616005)(6666004)(16526019)(1076003)(7696005)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2021 05:30:35.3744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aec9f4a-2601-4a49-4271-08d95a2da5f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1144
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


=== Description ===
Replace usage of sprintf with sysfs_emit in swsmu powerplay

  v2: rebased on 2f56b0d631eb

=== Test System ===
* DESKTOP(AMD FX-8350 + NAVI10(731F/ca), BIOS: F2)
 + ISO(Ubuntu 20.04.2 LTS)
 + Kernel(5.13.0-gb1d634be9673-fdoagd5f)


=== Patch Summary ===
   linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next @ 2f56b0d631eb
    + c4a20b3363cd amdgpu/pm: Replace navi10 usage of sprintf with sysfs_emit
    + cd2e3983959b amdgpu/pm: Replace smu11 usage of sprintf with sysfs_emit
    + bd82d29a9635 amdgpu/pm: Replace smu12/13 usage of sprintf with sysfs_emit


=== General Test for each platform ===
AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}
LOGFILE=pp_printf.test.log

lspci -nn | grep "VGA\|Display"  > $LOGFILE
FILES="pp_dpm_sclk
pp_sclk_od
pp_mclk_od
pp_dpm_pcie
pp_od_clk_voltage
pp_power_profile_mode "

for f in $FILES
do
  echo === $f === >> $LOGFILE
  cat $HWMON_DIR/device/$f >> $LOGFILE
done
cat $LOGFILE

Darren Powell (3):
  amdgpu/pm: Replace navi10 usage of sprintf with sysfs_emit
  amdgpu/pm: Replace smu11 usage of sprintf with sysfs_emit
  amdgpu/pm: Replace smu12/13 usage of sprintf with sysfs_emit

 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 26 ++++----
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 61 ++++++++++---------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 34 +++++------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 46 +++++++-------
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 20 +++---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 21 +++----
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 14 ++---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  6 +-
 8 files changed, 115 insertions(+), 113 deletions(-)


base-commit: 2f56b0d631eba0e76cfc789d85cc5632256ad42d
-- 
2.32.0


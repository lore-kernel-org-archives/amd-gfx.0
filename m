Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38305C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 02:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA3526E402;
	Thu, 25 Nov 2021 02:19:44 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2048.outbound.protection.outlook.com [40.107.212.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4E496E3EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 02:19:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rcc/OdMLJpeaIzLMU/+bHT1j6fLSAdyS+vSMj8gxKUM6rfHnfOxMCMVs4Z4UwNhzHFFjk9Cl76Bt0JsdFNfW1/fRIvPVVOyPyExIZcIas945kUmSvSrYRBWmZrVgn6Dl67nOzFvGF3LBB6i76DfU0uGcohtHFjn6vErvzLuRZoLqUeKaRbrItnjSlal6ldN0pPxsmrLY4a4itTo2IYDfBs11uP6e3BLdokipFW2aAaOykNYSewXf56eKe3I/gl69aHJguPJppP1NPiyOxeHt2/Lpl2QiWD52Gs1A0UXgwuoDp/bKzhMm5Og1wzaUWe9jlzRulOaB0jhbQt569PXxkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRr1EswzGFL6CS1SvovwCgOCCqm+NL0tUozrrci/r1g=;
 b=k12L3RSMMuQichZ7bRMkqM/zwg5uZpeZ3XQgrDC+SIFwSN8Zi3ODRXrEmf8JpuiRtyRen/wljyv2KiD6iZpScEIVkyJNHWfyaMLkjlGbcLuQaGpwf2hQwwily+fxJNUwwJ+2XYnAc7psmWCXsT7V7e/PsCeu0fPJsQswFaOz/f3BnDjiWKetT28G9rx3CAld+utoG6V4N63mpd8YEOFRV2KxVWhE55dZOCiyPEP5bC3U7WIbNW0cUP1tMzcnpQs95YcLFtOA4clyZndP0D2tRY7DkH+cevitUZGbN9z8tSpBBsEgeoKA77gwbJ0yY4ItKZTw/U451/vcY46IauwqIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRr1EswzGFL6CS1SvovwCgOCCqm+NL0tUozrrci/r1g=;
 b=E/k4naKaSr6HgFoEoMqYPTGxgoJK9G5pxX9PEHln/5Rzf71ClcpLKqGW6b/qxZnWwJRLI5GAB/sECm9JaDimyobL8VyPVW9iSvq3s62R51vmtUnwv4Ab16A5BQ2EiI8plawUbX+gBlGAjwwbF36kECQvucwtIJpNh/RJEDcPJ34=
Received: from BN6PR13CA0033.namprd13.prod.outlook.com (2603:10b6:404:13e::19)
 by MN2PR12MB3648.namprd12.prod.outlook.com (2603:10b6:208:c1::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 25 Nov
 2021 02:19:40 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::d8) by BN6PR13CA0033.outlook.office365.com
 (2603:10b6:404:13e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Thu, 25 Nov 2021 02:19:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 02:19:40 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 24 Nov 2021 20:19:39 -0600
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/2] Create shared array of power profile name strings
Date: Wed, 24 Nov 2021 21:19:23 -0500
Message-ID: <20211125021925.7881-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d573ac8-bfa1-4267-2135-08d9afba0944
X-MS-TrafficTypeDiagnostic: MN2PR12MB3648:
X-Microsoft-Antispam-PRVS: <MN2PR12MB36481B908491F65653150A2CF0629@MN2PR12MB3648.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bt/b0qEvq42ldWpu3qb9ob8UYGky8Z+DocoLaca7vegQcK0b4vuVgJa9HuA9ZbGg0I0B9uuCJhVKoFgayRo81sLqheF3jNPRycq6eVmmwGcebHEGRsooByqr22lTxp4vT18bKtsGPVPeBbJNkxWrNoVKJfxGX0zOiKwiGWvtFin1TAJ63uYN/MAZVYIHhRKJgEA/YbSa0x4fYeTvcNbncmPwlTg3HQqRXH4dLbf/Qcja9FpeA9+HdQyUe3UFbBAG/uQAkUywLx4u3tSY4NE0pfhittxHEwsF7NJmGlCnk6adF7cxsR6rSOk1ZpJEjvG9oq9JAqpg5r1xYWfgXUwtLuEuo0ArvRJ1GNybAcT4GnHAiPIKIj639fUTX+z6A+qrBfTqxrWW8Ygxj27fMqwy3hD/XONeaXIykoEIQDvuyDgtrcxXCFniolbDk26oestHoHSmo2k+ho0R1TIdzPPEZ6tk8Wg4KjqY6LcEpxDEqY7jPvaNjjzITTOf+5QoPqDYNDkzieEB3iQuUiJ1Sed1cwBcU2ZFT2PBkZUUhvzifBlsNeNk31lbcG9YGwEBx0iePybN5WjRINaU29FTb1P20a/z1cmydg1bzg1Q0/bC2TjetMIXOAmFGQ8ZPup/KXLI4L7aA/gQ8+7OQ8qQFB+wpfkoc9VtbKghb5QzG0h/Jb+9sWUswlzxwwnNmk0pKS3MOP176Y6JXTyi3dKIwCP/tuiBFA2czdLNsMT2Ty93/ZY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(4326008)(47076005)(5660300002)(44832011)(83380400001)(36756003)(26005)(6916009)(6666004)(8676002)(186003)(82310400004)(7696005)(508600001)(81166007)(2906002)(1076003)(36860700001)(336012)(2616005)(426003)(86362001)(316002)(70586007)(8936002)(356005)(70206006)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 02:19:40.3433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d573ac8-bfa1-4267-2135-08d9afba0944
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3648
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
 All the power profile modes use the same strings (or a subset of)
 Creating a public array of the strings will allow sharing rather than
 duplicating for each chip
 First patch only implements change for navi10
 Second patch extends the changes to all other implementations of
 pp_hwmgr_func->get_power_profile_mode  (smu10, smu7, vega10, vega20)
 and pptable_funcs->get_power_profile_mode  (arcturus, sienna_cichlid, vangogh, renoir)

=== Test System ===
 * DESKTOP(AMD FX-8350 + NAVI10(731F/ca), BIOS: F2)
  + ISO(Ubuntu 20.04.3 LTS)
  + Kernel(5.13.0-geabeb4f20a07-fdoagd5f)

=== Patch Summary ===
   linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next @ 1e7a606dca04
    + 482319edaabb amdgpu/pm: Create shared array of power profile name strings
    + 1e7a606dca04 amdgpu/pm: Modify implmentations of get_power_profile_mode to use amdgpu_pp_profile_name

=== Test ===
 LOGFILE=pp_profile_strings.test.log
 AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
 AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
 HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}

 lspci -nn | grep "VGA\|Display"  > $LOGFILE
 FILES="pp_power_profile_mode "

 for f in $FILES
 do
   echo === $f === >> $LOGFILE
   cat $HWMON_DIR/device/$f >> $LOGFILE
 done
 cat $LOGFILE

Darren Powell (2):
  amdgpu/pm: Create shared array of power profile name strings
  amdgpu/pm: Modify implmentations of get_power_profile_mode to use
    amdgpu_pp_profile_name

 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |  4 ++++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 | 10 ++++++++++
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c   |  9 +--------
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    | 14 +++-----------
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  | 12 +++---------
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  | 10 +---------
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  | 10 +---------
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    | 10 +---------
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10 +---------
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   | 10 +---------
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    | 10 +---------
 11 files changed, 27 insertions(+), 82 deletions(-)


base-commit: eabeb4f20a0786188fba07a2dd1b0a614c4e15f6
-- 
2.33.1


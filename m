Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B78C433FE
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Mar 2022 05:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4832C10E076;
	Sun, 13 Mar 2022 05:29:52 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2052.outbound.protection.outlook.com [40.107.101.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5723710E071
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Mar 2022 05:29:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g53FJYMZJex8Qe78BnRiKxvtc3e7ACJmG8bXfAiy1F2qtDBDxjMaLhHiwiX7JMFKixP3vpOVRbNNqLG0Rq2QVyqcdVnnlpAj/uxR+cuzsdJJbrxDNEyrgZcpotilyWS/r+pt+5QeTuCTY63tA2sWh7MW1/su5AqQoNIghrTZC93sHbGJLBMyk0bDMsVXKrS8DNHD6S7NIFoSzYieyD/L/zvuvol7QWFOD2K22yiYUWbLMSrNhw5/hPnNViTdG72li/ttjWfR0THvu5jXtdlJXfIATY1+wJPs68SaxdgcbovqfhQ7RjvMKNzZFFVq2/JoT7YtqpXCjXiYCvknndrXeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkvXeOTRPZVAVNwJbg0kAeEUCY+WdAS7LrRBHTeN+mI=;
 b=IJG2Pt9lp8b0Fa2H9cqE24VqkqGvIPYtWIf1M9k24a6pix5Y2oiamDUIqL78euS63HJZieJgSS4rF8y3iGvJLLwPv9K/Hd5aEEObPaZ7XztKI1H2ZrziI3v2FWTe03gd/8PKxsHHTU+XTsJKETbmb6NELUltnIRLjbbrRnJu/7/d1vdFwfcVnqMUnTb9LGYISDCePSuT+W+X+2VbG0zi33t2wbNqLnTIn7cmDb02GINFDD38SgOUfrP8/B91Z6AfAtuTeV0lWd6fpqhiudRgR8xfOZE/uEz2NAzsUOMgSmMWnvPuXGrImAlEm2DzNPwiMlw8aVXPI0ZoTqGWw3gddA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkvXeOTRPZVAVNwJbg0kAeEUCY+WdAS7LrRBHTeN+mI=;
 b=yTzVWzET+lu9CIDTgAtrFuHIqnSlJ1dZ46AiyfFXppXZnJ99ejxzBj7aL/GlJuHcN2rqfJDTTnvXaaWvM4Ctpwtxevilelg7ICgScVg/DWWlEbdpshONHnZSkG+O2UpyuZE30xx1WmJ+p1aPeZE3DVra2hv1Tsxyo7CIC4Ia3cU=
Received: from BN6PR19CA0084.namprd19.prod.outlook.com (2603:10b6:404:133::22)
 by DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Sun, 13 Mar
 2022 05:29:43 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::8e) by BN6PR19CA0084.outlook.office365.com
 (2603:10b6:404:133::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26 via Frontend
 Transport; Sun, 13 Mar 2022 05:29:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.24 via Frontend Transport; Sun, 13 Mar 2022 05:29:42 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 12 Mar 2022 23:29:41 -0600
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v1 0/2] amdgpu/pm: Implement parallel sysfs_emit solution for
 vega10
Date: Sun, 13 Mar 2022 00:28:37 -0500
Message-ID: <20220313052839.5777-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c830e3e4-bbb9-43e9-73be-08da04b27a6d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB433713FBC2DC104AFAD95186F00E9@DM6PR12MB4337.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZRKDijtIssqQ4dYe1OvEdoXSGHW09mQRn+BUnNmvYYNBCkLB6AeWh3fykKw2N4Hb079tzad5XEfZtHICRG1S5RFDejkCrwoJUsmMTJwCpt1YlFv9ZV/UwiUcyCg0mOiSDJRfVLZ8eqdQlTB6SYcT7V7IWyGGbOdYEKZJ0pz/w/5ToAwm2ECwUir0u+wGFXwrXK7aIb7HaPWIwYXVukfq5Y+EqgqHwOUunsFlYL9MwM1mtClLF4sgcSCZgYo1XmR8GGpFou7cGdih7NzVt3BxNJzPOa2bEW+5LQMt2MaqJ5uLFF1eSqVMauqZQo5oGWyCPsHYQ7cSGMRd9fIAUZvKCBFSY7IkeUXvompgf9RpaOXDV5yetBIMK4rOYvFL16ACTL9OBNznnIAnHP6UTIh6GjC81HB1g8Ru6dfUjpnLWZRBk0YIcMuZjdiEQtD5hUAPUyDKkSB5iVPTLQ1kVjkj6VXnGdUOPee63YxMARrMydukMLTk3PWjU+pSW/X9wlcseMZkAtILrD6rJr7+FF0IkFon9IOdgGGoiSK9Aj2xutbU/Cy/4CbvLQzl36mBs4pl1+xREk3NVRlQ6c1LZn6HRJZCDtbvLbs47mDfaXXhu/LBZt8mwCYGjtsjtvoJUOd8ZlqbVzKiJxEx+oXXJLFljxj8EWWWGVpF0GYxdUJxO1M7vV1KP8TSxMybmCI+j7gbw7e+k7ZGB+JLt0UCsmowoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(82310400004)(8936002)(508600001)(70586007)(44832011)(70206006)(4326008)(36756003)(8676002)(36860700001)(5660300002)(86362001)(81166007)(7696005)(356005)(6666004)(1076003)(47076005)(2906002)(6916009)(426003)(336012)(40460700003)(2616005)(83380400001)(186003)(16526019)(26005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2022 05:29:42.7436 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c830e3e4-bbb9-43e9-73be-08da04b27a6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337
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

The emit_clock_levels API for amdgpu_dpm has been duplicated to pp_dpm, based on the patch 
 commit 7f36948c92b2 ("amdgpu/pm: Implement new API function "emit" that accepts buffer base and write offset")
and vega10_emit_clock_levels has been implemented with sysfs_emit based on vega10_print_clock_levels


== Patch Summary ==
   linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next @ 6b6b9c625004
    + e94021f6c08c amdgpu/pm: Add new hwmgr API function "emit_clock_levels"
    + d83131987718 amdgpu/pm: Implement emit_clk_levels for vega10

== System Summary ==
* DESKTOP(AMD FX-8350 + VEGA10(687f/c3), BIOS: F2)
 + ISO(Ubuntu 20.04.4 LTS)
 + Kernel(5.16.0-20220307-fdoagd5f-g6b6b9c625004)
 + Overdrive Enabled(amdgpu.ppfeaturemask |= 0x4000)

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

Darren Powell (2):
  amdgpu/pm: Add new hwmgr API function "emit_clock_levels"
  amdgpu/pm: Implement emit_clk_levels for vega10

 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  17 ++
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 147 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |   2 +
 3 files changed, 166 insertions(+)


base-commit: 6b6b9c625004e07e000ca1918cadcb64439eb498
-- 
2.35.1


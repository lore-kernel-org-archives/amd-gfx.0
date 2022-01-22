Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA34CC433FE
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Jan 2022 03:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C18510E389;
	Sat, 22 Jan 2022 03:47:24 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2072.outbound.protection.outlook.com [40.107.95.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7970710E4D8
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Jan 2022 03:47:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIrxx3seHymDkjrdKdk/O/+giKovwvewBMcq5HKRN4n/BSYvk0DrpW6remGLF8sXXMTca/NRT11HWjbbzBjGtwH+UWFjJN/s3YtMFX0UuEmkRgey9U32wlAM8wZGmFIlbjOJbVXJX3ZzZgCLdxv7dkTfs7ZfaIDvkU4HA3zxPDZQGVRUeCI61DanNzYQ/aiHWTIa4msBD8Hkg4D3g/NgZWkhGYcTi54GFH5EMBKQHhoHyouFaHavmSA9J64LEnFAXO/nAuKCqDt9rVKa8ol6FNbmN4jYOvi3iLyEfFINdTmC+8YAl5kytDzBjPPqIcH9faJPdiJN9wL2pu2VBBtTVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYSU0Yb1ywrCzfqpz2v9rgy/py8D1V7bLuYTAyHP9yc=;
 b=VfwXoX/4PrMdVwu9rpRomkPRrYTIEwUqbbqqmgxIrQ4eRwOw0TVZfXZn33FLCRdAZhRvwHAR+TpwerOsK1WIoB7cWKA9Lc8YR7HKMbwMTfgMz9nSVpKB9kCojkSz75DPpUafPcQ9UZzFA2G1tP+sljYCzbfaWB76Si4H4V0m98/nOvUDceAWZfv6JrrVN6BPQRz0OuicqAwSYKbo29/BOibZ2aCQim/rO2zvMkUb+EB76xz018EJF9ihUw9Wz++WdOkKaA6xxCIXwDxJOEo1svvwQuN1oqW4nNu/2/TeRRRuKO+rNAKI3yQI6yLlL9J6F75OknW9g684dmD2sv+6sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYSU0Yb1ywrCzfqpz2v9rgy/py8D1V7bLuYTAyHP9yc=;
 b=iO88B/veVrPzDsu/uMAB1pY7ZBUxXxKCQoKQCT60baKy7iStNbQpHd/zlckL6DnTxrpjE3ziZ25ddAG0WBSqY1jEetrblHIStooh/5kUJfFh7FltQcneFzZl3AFcrypRFLisGtI0VqtecTwwkyWMO1T+3lC7wbetBRd2MKlPOnQ=
Received: from BN9PR03CA0872.namprd03.prod.outlook.com (2603:10b6:408:13c::7)
 by MN2PR12MB3648.namprd12.prod.outlook.com (2603:10b6:208:c1::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Sat, 22 Jan
 2022 03:47:13 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::7a) by BN9PR03CA0872.outlook.office365.com
 (2603:10b6:408:13c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.13 via Frontend
 Transport; Sat, 22 Jan 2022 03:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sat, 22 Jan 2022 03:47:12 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 21 Jan 2022 21:47:12 -0600
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/3] Implement parallel sysfs_emit solution for navi10
Date: Fri, 21 Jan 2022 22:46:44 -0500
Message-ID: <20220122034647.67925-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9a08628-dbf0-48cd-4cec-08d9dd59dfea
X-MS-TrafficTypeDiagnostic: MN2PR12MB3648:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3648C73341EF7633C2D15A28F05C9@MN2PR12MB3648.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s+RD1JbewywIxULa4hX7PtknbOAK/g53a8yRx8biMpHD6EG86WICizYHxOuZnNFI7PNVSj+CN+H0EJkXKL0aUz6lKYl+343ln/hDmNyv45VRF/I54vIho3hwHxRR4eaRNa8OE1ANh9vnU1jvtQ4C2hbqKY+YtEri7ug07o3krmG40i3UZrKrlbqRogVFGIOfXbR55uPWPey++jZKD3vO97ZNPL06lcgD5OGLq2PxSJSke5rUUphp1T+89HVO66Muu8uF5OHYcUQgZxEBxT0MuBcktrvAarYkSshiBJnE063WYmeezx8iYB9gHMcAnD0R2YKXgfv9248VEIMj2Y9PuAxKxDtP84nWSnr6DOgTjilGMJb3DJCgI/TeMn1Dg++VaAvqXyn3bGc1ElgqyO+zjQvUgpjUEHKu3HpaoVA9WIV9USbwm7ypak7ATx42JRh5A+6wMDiYYUXp+tsXoSPsTr2k/pHK2Gnnot9A2jkfGSaupmZWSNssWZzCIiHASe1gMWZMlQS1ZHa6BzD0snbDuj1zzRq5iKR7VrsJilhpgHiwCE/DcELNLz+xW7CdnuYQFUcBUjNQHTTvBU0zkWBAjeD+0OVEyTJ/tJ1RnPSc4UBXdEa84a1M1jQpvf8L3DeEctc/8r7XPeyjgN8PkBV4f5xZoGOjMlSgSJHPhbCMi7FWe/DX022dvl0mgv+KhDzpfy245qu5ct4+Rxz43D5doeXCgXWWkWX5kEKed1T3XgnERgdP1AiAcPAFd8au7+UnVRReH01+TubPnY2lf24Wk90ToJftTOryf9KhdMYCSd8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(36840700001)(46966006)(8676002)(83380400001)(426003)(82310400004)(2616005)(356005)(81166007)(40460700003)(86362001)(6666004)(5660300002)(8936002)(4326008)(508600001)(47076005)(70586007)(70206006)(186003)(7696005)(44832011)(16526019)(36860700001)(26005)(36756003)(6916009)(316002)(1076003)(336012)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2022 03:47:12.7669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a08628-dbf0-48cd-4cec-08d9dd59dfea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
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
Scnprintf use within the kernel is not recommended, but simple sysfs_emit replacement has
not been successful due to the page alignment requirement of the function. This patch
set implements a new api "emit_clock_levels" to facilitate passing both the base and
offset to the device rather than just the write pointer.
This patch is only implemented for navi10 for some clocks to seek comment on the
implementation before extending the implementation to other clock values and devices.

Needs to be verified on a platform that supports the overclocking

   (v2)
      Update to apply on commit 801771de03
      adjust printing of empty carriage return only if size == 0
      change return from amdgpu_dpm_emit_clock_levels if emit_clock_levels not found

== Patch Summary ==
   linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next @ 28907fd9e048
    + f83a3144ede4 amdgpu/pm: Implement new API function "emit" that accepts buffer base and write offset
    + 82de36426a1f amdgpu/pm: insert attempt to call emit_clock_levels into amdgpu_get_pp_od_clk_voltage
    + 32f0fcf45dd8 amdgpu/pm: Add Error Handling to emit_clocks stack

== System Summary ==
 * DESKTOP(AMD FX-8350 + NAVI10(731F/ca), BIOS: F2)
  + ISO(Ubuntu 20.04.3 LTS)
  + Kernel(5.13.0-fdoagd5f-20220112-g28907fd9e0)

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
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  21 ++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  49 +++--
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   4 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  44 +++-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  14 ++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 188 ++++++++++++++++++
 7 files changed, 302 insertions(+), 19 deletions(-)


base-commit: 28907fd9e04859fab86a143271d29ff0ff043154
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF62CC2BA4C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 04:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AB1B10E3E8;
	Wed, 26 Jan 2022 04:55:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4D1910E393
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 04:55:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJDhGA10hylre9sYEb2IqhXIMci4O8b914O3QcDvycijmLGsgqIHmrlr7lBgiwJuKmfA5g3zanQHefg2BGYNmQSngotuHN/U9ph+F9WsMpsEAIxhtI2lAzEzf8D9LV9ybK0bzCTOrJ3L5hSvFePYNI0V5L3BCGNDqvnrN9eaot+ahZA5pgJxHGfmvuejjhcRcrey5IWPxUTuKNBPpRK+FXhSmsLVQPn48XS8rvjeo+UEgcxATv/ac+2vWGGRS2X8H2aH2YORalRYKPNiT9JMWOX1TceaykaOr+4zkWNiHMWITBxXIfQI+v+9TdZA/unHZYLy0W7RW1KdOjp/oxjQ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKIK8ZYxhl104x6oWaShQ7H5fest6LhdEiBkmUtfEcI=;
 b=YvHFALFCk9rvBfIBm9oMUynZbSx7sgDMmu95NVMh7znriBtCWpweduliHUTYmf2eKh3wCUf0iKQodsqjfcCBud6woW2q42V2yE8rKtTeJt0CMzhbUbBpUz2pMtQLfN3HwU45R3C60IXOYJZdOjcSmIEKj2zkOKPNQW8hgUvWd8/4ILAeozkqbjr3DFGTDBZjLL6FQtxaLKd9vl3C4d37w6rdUlIjxIvRFb8kKvk3YSamaO11Fpw7II9Hhy4lgyZQIoJlG/sm9fY4qVY44qV1/Gvlw5nDfssIcv4bKiIbkRGszm4CiQ8PyjS0Skxf0EoT6xu9IckHi4axMcQ0XImHFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKIK8ZYxhl104x6oWaShQ7H5fest6LhdEiBkmUtfEcI=;
 b=EwLgO0yih7qGs2Kqy75uK9YZsoUtA5ehSSeHCce0SBTnk/ZKxAfWQddusp/KPonhLFpMkIFU6a13YWBYOdoyB9R3aMZWTqWiTXuJrIonAgmEnbSZbg7xDgQWrl666EZ1Sfy50Di8DtL3LqrKwHEb6Td5fApFkTrfVRPvrVXjy9Y=
Received: from MW4PR04CA0183.namprd04.prod.outlook.com (2603:10b6:303:86::8)
 by BL0PR12MB4660.namprd12.prod.outlook.com (2603:10b6:207:34::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Wed, 26 Jan
 2022 04:55:00 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::4e) by MW4PR04CA0183.outlook.office365.com
 (2603:10b6:303:86::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12 via Frontend
 Transport; Wed, 26 Jan 2022 04:55:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Wed, 26 Jan 2022 04:54:58 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 25 Jan 2022 22:54:57 -0600
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 0/3] amdgpu/pm: Implement parallel sysfs_emit solution for
 navi10
Date: Tue, 25 Jan 2022 23:54:38 -0500
Message-ID: <20220126045441.3891-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92c19d68-70b1-49bd-214d-08d9e0880170
X-MS-TrafficTypeDiagnostic: BL0PR12MB4660:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4660CB237292282C01E0BB0FF0209@BL0PR12MB4660.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZFc2/gmQZ/YBRIopXk0owvwl0lLJq1JuBuFQ/3ut8uF9TlPlerENiL70iU6yKTvse2P3iangSUbh3Sb83nzXj/WAv8JsygTSwwZ1vFCcDSOkjusmN1BVNbGaAeZpP+1h6+sr8tRtwI75IGv+vjvgqvhTVzKMnhlXastA1Vnj7V4bskn69Jlap05u3UbwrfqpfNoS+cC8FGJ5Z//ZGoDbOQsD+AYexsruVN0x89eRiylzqPE9eaXnnlCSJ8xHfTf4pv1PKvL6CerdGb2+RfLz0XEEdxXrw7rAmrayhq014Ae/56nK5/T99LLXokxtw5UaBEBgFbauwPAPPqI008/V0EivThmkibUey+SuYaqFzfWB5qxavRK49FH/cUezH7ao/FZnp6ZRI4sS2xMh0JGoDlGlqfM38fENeBiVT2sVnp0iAF8D5P+Gi7uKwjGyFAh4pG3cDPIJNDYsKH9RvxlZuU0KO1J6pNRHx3IaocZ0vEpiKX5xftFoLt/6BbDj9qFy7oujjTBliMtzRK7LiGVTxqN3i4f2rvIUagiGz34+3PMW23xHOMwWlkKGXOkET8RKuMOacl6kQPiYKs5Abm7QslFjuhEHUcx+QRXhY6w2f6JXnivKktHNv+WKxN5SYHpzETOJzj8WkePGrLTqcaR95GV29EA7JpC98FieJvcUjmQLgnuxXGo2olZi6b5jVMIkpQ1NZjY7NCPXbjJrCKqZvv12HSOZ4epO7rlNDZT8Oo9GtvYhBhWpxiuSno9Nm41gBPNOUVxzhl5lmGKyigota84IPrY0g5e5Whs0VBKTEes=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700004)(46966006)(36840700001)(86362001)(70586007)(316002)(70206006)(186003)(36756003)(4326008)(81166007)(6916009)(47076005)(36860700001)(508600001)(44832011)(40460700003)(82310400004)(426003)(2906002)(7696005)(2616005)(6666004)(26005)(336012)(8936002)(5660300002)(16526019)(356005)(1076003)(83380400001)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 04:54:58.9092 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c19d68-70b1-49bd-214d-08d9e0880170
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4660
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

   (v3)
     Rewrote patchset to order patches as (API, hw impl, usecase)
   (v2)
      Update to apply on commit 801771de03
      adjust printing of empty carriage return only if size == 0
      change return from amdgpu_dpm_emit_clock_levels if emit_clock_levels not found

== Patch Summary ==
   linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next @ 28907fd9e048
    + f3c1d971ea17 amdgpu/pm: Implement new API function "emit" that accepts buffer base and write offset
    + c67ac3384682 amdgpu/pm: Implemention of emit_clk_levels for navi10 that accepts buffer base and write offset
    + 734cca28fed3 amdgpu/pm: Linked emit_clock_levels to use cases amdgpu_get_pp_{dpm_clock,od_clk_voltage}

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
  amdgpu/pm: Implemention of emit_clk_levels for navi10 that accepts
    buffer base and write offset
  amdgpu/pm: Linked emit_clock_levels to use cases
    amdgpu_get_pp_{dpm_clock,od_clk_voltage}

 .../gpu/drm/amd/include/kgd_pp_interface.h    |   1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  21 ++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  49 +++--
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   4 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  42 +++-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  14 ++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 188 ++++++++++++++++++
 7 files changed, 300 insertions(+), 19 deletions(-)


base-commit: 28907fd9e04859fab86a143271d29ff0ff043154
-- 
2.34.1


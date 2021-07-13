Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E41C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 04:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B165160FED
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 04:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B165160FED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FE8989C61;
	Tue, 13 Jul 2021 04:03:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B527A89C61
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 04:03:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gzah6k7j3xSQYp1CGcU49sAUd1ZqQysmJkDJQGb25BHIpPHJS7JCEo3lh8ckzs00onouOrr+zV/8vnU3OFzWFJpg5NdTNo+On48FgP0zltteYN1sNvLHtfhkVrZLSqcEmTJ+4hqPkTL1htnimzMCxpomn4gZt0AKWrQsgGZ/lvE+eTtwHVrWoEMWBBzPGxSOoH7mwFAUkCR/qbsnlOh+bNc3EOJR59AQ91JSudl/s7tmIBzUEmMF6Gh379e5I8++Sghp5lvy2i5UgpTzHjgoBStD6UlWhE1P54biuWQ6ojeLi2qPu0s/nyZ8CPlKPxi7OLBT7kJaCsdUqrhPMq0+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs3WmtkdWvpOiEl/K8I7Alopn3/px2aLoVmLPyDdRLE=;
 b=HuuK7gTPxfLu5LkRXNP+4WireCSPHJlVfmpgtgGJlw0ZloQlQSraZHAF1OZumdcaTi19IjIBAo8P/vbayXJIFHkzZs+UhIgaJMANu6drVGIOIFi8xSgOmpJwC2qkX0OWJGfXp0dWjgqkwpg0dbR3Cuf32IZE22R3WCgQAv3bo4Drlv7LkN9gCkGffa1/hFuTd8rWoLIghm0DnVlPvuQaLe+2FyJ8f3ccVEK7qEqMqVvyRNrPlDSMR+bdZd05DFbwSGp87gbpOT5kKmMCcMBVcGjbsIEQPyeOU38SDmxHvINq2XMs0iXj/U2Uy55rcVwAMh/FefEyXwlhMp+ZDxmHSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs3WmtkdWvpOiEl/K8I7Alopn3/px2aLoVmLPyDdRLE=;
 b=tF/agxFpoXhOULaSz8UkFJviV+nXISTeqdPxdCprJ4JvXRypYdtdZXhOu4gW/e0VyRmsNYMviTbQXiYMl1Xz5QhcZQMUQzvl2ys3sA4N4mCyVx1j4A3X22g2cED4BeKPlLUC1QJnxJViHHZIlhL7z2Bmd7XIn/ivQag/xl5tt6Y=
Received: from BN9PR03CA0680.namprd03.prod.outlook.com (2603:10b6:408:10e::25)
 by MW2PR12MB2508.namprd12.prod.outlook.com (2603:10b6:907:9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Tue, 13 Jul
 2021 04:03:42 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::9d) by BN9PR03CA0680.outlook.office365.com
 (2603:10b6:408:10e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Tue, 13 Jul 2021 04:03:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 04:03:42 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 12 Jul 2021 23:03:41 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] Replace usage of sprintf with sysfs_emit in swsmu
 powerplay
Date: Tue, 13 Jul 2021 00:03:17 -0400
Message-ID: <20210713040320.4657-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1a62454-d980-44e8-6d8e-08d945b333e4
X-MS-TrafficTypeDiagnostic: MW2PR12MB2508:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2508B8C5AC78769D4270565CF0149@MW2PR12MB2508.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:285;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qRLo8TP0neQo2WZLzxCg6llAdZTultIXf93j8+83JELXffj+Vz37vqLJDURG4P2gZ4eB+/WfhWnLyMkeuyOjnu1cKoApQqrmgaLj97ERHfFV7Acruak+xC95YqKUImPC/mhbEskxYxM8xuDTiz0p2DVx3tOPx+bPO75skZawOSeBwVo2dRRZV6lmMBazzhZtGvGPDRwymKrN117Kv2GH3zo0U8Wt6kowi+NGUe31jcCoxlRf8zqIBPIKX9N0+U0dZnTok344+jjpKZT29AgTIUDetqeGsOHUSeKK9c0zQMJSG8PtD9pZe7X/bvgFF74zdQR0OCZkVbS69LYDoyAk2Y9jADOqbYPOczkMnK8Xb9j21swQsJxl7TKB6MbjqhstF14x4AvTHJwayegHLoNskv1wd4aNm+nzlHnS91mub4iIvRsoJRsPwst4yBFqlIqpxZ/IV/Z9lWJRSWeI+JWP0gN+S5yuXW99vsuA1/9OvQ557DHjjPgkMkn7BOU5WsavwKJCBKmnXwLKC6flg4D1Zosc7u/j9KBm/RnmIoRLKqL/zyVkRXl2UwTsnhUESR8t4ZB3UOdbwRWsgxLfv+VaNUzu9dp7+6KPqHpSRqLqH3dVhr6JgT/HlZca5OxmnMR5hspt7WdE7lxaQOegOoozREb7cU8MUn6M3o3hZRZRoAAj1eb677LLJSWldRU/Zzb7yPM9upo5q02NuGbq01mIj2Y+6Gr92eLToWPhTSQabpA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(36840700001)(46966006)(44832011)(2616005)(2906002)(16526019)(82310400003)(356005)(81166007)(8676002)(70586007)(36860700001)(6666004)(426003)(36756003)(336012)(70206006)(478600001)(186003)(8936002)(1076003)(83380400001)(86362001)(82740400003)(7696005)(6916009)(316002)(47076005)(4326008)(26005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 04:03:42.1166 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a62454-d980-44e8-6d8e-08d945b333e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2508
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


=== Description ===
Replace usage of sprintf with sysfs_emit in swsmu powerplay


=== Test System ===
* DESKTOP(AMD FX-8350 + NAVI10(731F/ca), BIOS: F2)
 + ISO(Ubuntu 20.04.1 LTS)
 + Kernel(5.11.0-custom-fdoagd5f)

=== Patch Summary ===
   linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next @ 41f5f65dd1e2
    + 8f658084973a  amdgpu/pm: Replace navi10 usage of sprintf with sysfs_emit
    + 9bb408150cd4  amdgpu/pm: Replace smu11 usage of sprintf with sysfs_emit
    + 534d0b145b9c  amdgpu/pm: Replace smu12/13 usage of sprintf with sysfs_emit

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


base-commit: 41f5f65dd1e2f660989ee7fa1a5fc6c3490f08f1
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

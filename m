Return-Path: <SRS0=EBpG=M7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB2EC432BE
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Aug 2021 05:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A7B460F42
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Aug 2021 05:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2A7B460F42
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A051B89D49;
	Sun,  8 Aug 2021 05:33:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1234A89D43
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Aug 2021 05:33:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coufjzROu/sL1m2TC1ususr/hbeK+wdIx8xs7aFGDI1/hAZaJ3vJaYhAxTZ+NXVDZErOdqxkq3YNLCTIXedOrRLy/sI1t0y1IpVbqkUwyXlIAZ0u5CNitrEtS23BxWNmMQGCVxZRgcgJ9GRb1qMujxtOdX17qxmmzgaDQSo7zvamrG5P2lgMmZ584R16LPaai7uUF7EyMexWbXusdB4JSJg/pYNeAXXne55/PqTia6lkFKbs2agxmj7/yViGpc3OKnt2dccMFhpueQNS0gqjwYsD4mkV/jyly9ccgdL5eJKLHKBGnq0SX1SdsWlzFxmh8rB3zz/kd85+cUKV9oIpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owRCpCTza+Q/JMLyW6lGPgkk0cJgb+idEwZ6m2xF3qU=;
 b=gleDbDkN/ts1BG4xO/RwOUB63qGycXCKsklxi3CNQyoXrhxwdGeympUqQzPs4XAtyqZ1tDm2jxHlUMfel02Bi6ASyjSFFT9uEICFHbKRGIxc24j2z3DXt2mBCA4rfMTE9g6cEcvhJJgS4xMw/WfTmhx2cgYjmeS3MyBuoIrD6da2xoGqABnh5OWaTwonaN7rckN5kADwoZlkdHFu3kXgW7vUVr3vde4+uC6ubvZbelOPPRr7XUvSgsppfCKnUj0dCtpDHtiY9UyitLxVSImOkRLBjC8HFSETZRYxTR6c220jQaTHVqunj/s9iKOBTnl78pgpCRnYceggMOx5UkVyug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owRCpCTza+Q/JMLyW6lGPgkk0cJgb+idEwZ6m2xF3qU=;
 b=bIkyrINfl3KluVDgG0eJOVhJ+pDcPkN9Ej1pP2EzogmTvYiBytCa6DsCPeDUFbko/cUFJ7V6ZJsDdzk3yT9I24nfNqal59PKiYWEW1aBNZ0m5ije9VlSgYADL2Sqs56IMF8r/uJsheCAjalsEGmyzksoVBIyYej5bpTYUsOYHvQ=
Received: from BN9PR03CA0066.namprd03.prod.outlook.com (2603:10b6:408:fc::11)
 by DM4PR12MB5391.namprd12.prod.outlook.com (2603:10b6:5:39a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Sun, 8 Aug
 2021 05:33:25 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::13) by BN9PR03CA0066.outlook.office365.com
 (2603:10b6:408:fc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Sun, 8 Aug 2021 05:33:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Sun, 8 Aug 2021 05:33:25 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 8 Aug 2021 00:33:24 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Darren Powell <darren.powell@amd.com>
Subject: [PATCH 0/4] Replace usage of sprintf with sysfs_emit in hwmgr
 powerplay
Date: Sun, 8 Aug 2021 01:33:08 -0400
Message-ID: <20210808053312.3423-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ceb2afda-e9f7-4088-153c-08d95a2e0b23
X-MS-TrafficTypeDiagnostic: DM4PR12MB5391:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5391C8AB5FEA23BF7013D9DDF0F59@DM4PR12MB5391.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:285;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WADHkjv61EuRb4dfQBuW3nPOZqVhpjwhBdFSFBiB90Gwlqm0DLvUNXjjmnjYn75jpPW1rcMZ+AEClfY2qrJsZDp76b7BLqgMqbJEjDEJVe8nFVgAOb8IBnIuYw5j01e07RbXKjTJlLKwVIVC3SQih+ZxdjVdyemnpqsKIFZ6e7fwaAs3X12G/waCxsk5vLdZqBJZbWSsydJWBBXazIkVyUWkQhoAQDJ7UDEbSVrMzMl+SBlitqAv4cQRD3UJ/2gdtaDnRGWtBRK9Z+UqD+SElqCBNIG/2NLqI77F+tSK/PfYVKjVYex4itduy1NJ+VPJW2lCmH/uvds10jb0x9672K9iZrjPKXpg63fukSzXQj4xQgXwP4BiX+xj4J4vCp44xiZYdhRimT7911dPS3DcoFtxdi43AZnKwwMfbndIwW116xeXZcK2JJEisLBhV1rUF4P14JhtE+JiBzWvRNvQAOMLKUjWeLtF7uOrWpAzmRMd2gY4dcvfnhODZ4qir7aIxQRb/ErWv9aY3ZHAmQfJs7/8Gq+LrP9r6UR0bNpUQRE/jdbW5tTdQUXGWweBjHPGS76RhSnuMBBUXzpRp2APSQuiggipf6iAtLddZw14h0l6p9of/vi02v+EpfrfWp8FYpGTY79cA/gp9qg2raazGz4hV9te0NTyKxjTD0dx1MIHwLi34VzeOKKDawYY0BhyJpvK7jEcAG964DAEqU+OfBb/2JXbiK3d4ANcecqxC35+Dk7T5e3ojqpiM3mGNdKB9yRP5JB4SUDh4t5s0PMu5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(36840700001)(46966006)(86362001)(83380400001)(356005)(36756003)(70206006)(34070700002)(6666004)(7696005)(82310400003)(26005)(70586007)(336012)(478600001)(36860700001)(16526019)(186003)(2906002)(82740400003)(81166007)(6916009)(8936002)(8676002)(47076005)(316002)(2616005)(1076003)(4326008)(44832011)(426003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2021 05:33:25.1050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb2afda-e9f7-4088-153c-08d95a2e0b23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5391
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
Replace usage of sprintf with sysfs_emit in hwmgr powerplay

=== Test System ===
* DESKTOP(AMD FX-8350 + VEGA10(687F/c3), BIOS: F2)
 + ISO(Ubuntu 20.04.2 LTS)
 + Kernel(5.13.0-gb1d634be9673-fdoagd5f)


=== Patch Summary ===
   linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next @ 2f56b0d631eb
    + 0ede8d563c58 amdgpu/pm: Replace vega10 usage of sprintf with sysfs_emit
    + 1d666a0652a1 amdgpu/pm: Replace vega12,20 usage of sprintf with sysfs_emit
    + 8bad9ffba08b amdgpu/pm: Replace hwmgr smu usage of sprintf with sysfs_emit
    + 773733df2f32 amdgpu/pm: Replace amdgpu_pm usage of sprintf with sysfs_emit


=== General Test for each platform ===
AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | awk '{print $9}'`
HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}
LOGFILE=pp_printf.test.log

lspci -nn | grep "VGA\|Display"  > $LOGFILE
FILES="pp_dpm_sclk 
pp_features
pp_power_profile_mode "

for f in $FILES
do
  echo === $f === >> $LOGFILE
  cat $HWMON_DIR/device/$f >> $LOGFILE
done
cat $LOGFILE

Darren Powell (4):
  amdgpu/pm: Replace vega10 usage of sprintf with sysfs_emit
  amdgpu/pm: Replace vega12,20 usage of sprintf with sysfs_emit
  amdgpu/pm: Replace hwmgr smu usage of sprintf with sysfs_emit
  amdgpu/pm: Replace amdgpu_pm usage of sprintf with sysfs_emit

 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 16 ++--
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 22 +++---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 38 +++++-----
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |  7 +-
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 38 +++++-----
 .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 14 ++--
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 74 +++++++++----------
 7 files changed, 105 insertions(+), 104 deletions(-)


base-commit: 2f56b0d631eba0e76cfc789d85cc5632256ad42d
-- 
2.32.0


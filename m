Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018C9C47087
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 23:06:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9463661132
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 23:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9463661132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F39B56E57A;
	Fri, 28 May 2021 23:06:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 282EF6E57A
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 23:06:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KklGr0oVkTj/xOEfVTCfaJQUPa/SVYyuefFU/4MtJ3EY1m4DxQqJdY/n4cMGHRmdfDCNLySAnwE4NMZmy8rU+D6pueCNgYMh9yhi6FH58664Tqm5+7zQtFvh6xUoLBQyXQ+B8NJ/XuIG6Tueck8yMNpvXSashDYEqsB0e7494maDXaaScm8VWYUVphXLQXnwpdk/kVvhU7zrGcYB55wt7N83soYtWvZD22728LRPG7ozOKyR8m+crFL0rLikfwRcTAPcXkWeFdwNF7ZlGWQlc3fpneVLDNeC9OoFL58ihj6QF8EsVIL0vQFUZuDlk885UbrnQe1YHLY1g6XoQP3EfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52RFA/+23hHpy7CTNLolYlxubD6RV42JLUGTkEh2DT8=;
 b=SEv8KLz4hpfhh0RKCNKSWfEMPPimi65fec/MKNiKem49A2QaFtUuYqDfjr45aXuYGRd4G2mmHZLAESgGSSXQl1JuYIo2rB9EtPDw+JryndFObB+wfrrnB0pMnIc9Gt+BSePS+s3263jrZt9/AvSTBmj5uIVIal6SPkvCkLROkS01b7eXAzbuMpPPDzxjP3aTvLuJEPAhrE1Zrs871ka/vmqIl3e8cqrBzioouxQPTe2BzwlL4YmN/q7vsJDS5oSuCqOylyRpFfT5MNBoJXQ9Df8RSGrO83aspEsB8ue7sQbIVrg9p9/R00k/p2z0pyehU9Yn/b2nm4Du3GPhCro9dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52RFA/+23hHpy7CTNLolYlxubD6RV42JLUGTkEh2DT8=;
 b=jzO3JVC7JikkeNd5xzR4PdBN8H+ummBQC0L0v8L+MunAPl02dxf8oowxZGyP2we1Njs5m/Ievx56rsjfbCPEWF6DxdGYm/9s7guU+3jTUtWxewqVXq0jbYGly8LPmA8EoVlNlQSVYn3PH2O3ZS8PwJjfAa/m5XoWXiB7lyx59lA=
Received: from MWHPR04CA0050.namprd04.prod.outlook.com (2603:10b6:300:6c::12)
 by SA0PR12MB4542.namprd12.prod.outlook.com (2603:10b6:806:73::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 23:06:38 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::8a) by MWHPR04CA0050.outlook.office365.com
 (2603:10b6:300:6c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 23:06:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 23:06:37 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 28 May 2021 18:06:36 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/6] Modify smu_get_power_limit to implement Powerplay API
Date: Fri, 28 May 2021 19:06:15 -0400
Message-ID: <20210528230621.16468-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7fc5a66-a730-46ff-df87-08d9222d3f1c
X-MS-TrafficTypeDiagnostic: SA0PR12MB4542:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4542F4CB973B4F1ABEBF9AC7F0229@SA0PR12MB4542.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wVpxtz8jCSxDX/BenJoByp3zRSAszFRSI2xUCpm5+PqwWUBhBnMwliRrPr1WC06Hpu7813+ygQIvuWMLxPbZDliAFbZq8fG4w9W8jcLQegH13XiJNgY/3tc7DvwsUBayf6PWZ+LsHauLiSC1uCV+T3Kj7nu6iut7IyFMxYTOmdBfMfV6DCJ50pMR0O95WE0fC637KjTf5iFZcOnx42CAyeUXwH5JWY+m2g/i2/Hx5hlkYaKXGB3hq2mp5W29QnkI89xFf29Q9tChvwl5xxgyIDmJaODTf81HDnVYnEA8cK/9Md/9qTZvFpEUt/XmmORkJG+n9G/P31dHj1hf1WhhbDOQ5XfqzcMFOZDO5Qq+35uAgZp/+VXuE5ZCXubM5YVx5Ugv1RnWk6AjqJ+EO2mMMZt6GUQ1ad87JDNdn02TaSGkcwM91qypUABuivFl7e2jgHZLMR93DRAKiRucMaAZlXC35uuXplasRh1lFFWgQ/egDC72N9SfYHUFsNnbTv0RyXyGeeV/rEg8N+EppPzcs2FUaaGLredv6zxWrIIKIKBnbm3jWZW10fuazlYhyCE8VTU63OLP3YBGFO/msImDTv8sDoa8pKOtYLI7gzXlb5ZZXCHRLQR4lQwHP8hPvHx4rCtNJFD/Xp/+No68VJ6LOlch8nxLBaVapooj3tQlpSusUTIxH5yjb9fxUJo4N4g3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(36840700001)(46966006)(82310400003)(81166007)(356005)(82740400003)(83380400001)(86362001)(478600001)(6916009)(316002)(2906002)(36860700001)(8676002)(8936002)(1076003)(7696005)(16526019)(5660300002)(186003)(70206006)(70586007)(44832011)(2616005)(336012)(426003)(6666004)(47076005)(36756003)(26005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 23:06:37.5726 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7fc5a66-a730-46ff-df87-08d9222d3f1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4542
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
modify smu_get_power_limit to implement Powerplay API

 v2: rewrote the patchset to use two enums as args to get_power

=== Test System ===
* DESKTOP(AMD FX-8350 + NAVI10(731F/ca), BIOS: F2)
 + ISO(Ubuntu 20.04.1 LTS)
 + Kernel(5.11.0-custom-fdoagd5f)

=== Patch Summary ===
   linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next @ 3ac16cf10525
    + 212a8ab5269d amdgpu/pm: reorder definition of swsmu_pm_funcs for readability
    + 50adb18c2670 amdgpu/pm: clean up smu_get_power_limit function signature
    + ab31cfcad254 amdgpu/pm: modify Powerplay API get_power_limit to use new pp_power enums
    + a5e2a4209a3c amdgpu/pm: modify and add smu_get_power_limit to Powerplay API
    + 6b732f665a9c amdgpu/pm: handle return value for get_power_limit
    + c1e3e0963996 amdgpu/pm: add kernel documentation for smu_get_power_limit

=== Tests ===
==== get_power_limit Test ====
* Test 
 AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
 AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | cut -d " " -f 10`
 HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}

 lspci -nn | grep "VGA\|Display" ; \
 echo "=== power1 cap ===" ; cat $HWMON_DIR/power1_cap ;           \
 echo "=== power1 cap max ===" ; cat $HWMON_DIR/power1_cap_max ;   \
 echo "=== power1 cap def ===" ; cat $HWMON_DIR/power1_cap_default

==== Documentation Test ====
* Insert temp documentation
** Documentation/gpu/amdgpu.rst
 vi Documentation/gpu/amdgpu.rst
** added text to start
------------START------------
Documentation Testing
=====================

Power Limit
-----------
.. kernel-doc:: drivers/gpu/drm/amd/include/kgd_pp_interface.h
   :doc: amdgpu_pp_power

.. kernel-doc:: drivers/gpu/drm/amd/include/kgd_pp_interface.h
   :identifiers: pp_power_limit_level

.. kernel-doc:: drivers/gpu/drm/amd/include/kgd_pp_interface.h
   :identifiers: pp_power_sample_window

.. kernel-doc:: drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
   :identifiers: smu_get_power_limit
-------------END-------------

* Setup
 cd ~/workspace/linux
 . sphinx_2.4.4/bin/activate

* Build
 export SPHINXDOCLOG=sphinx.build.log
 cp $SPHINXDOCLOG{,.old}
 time make -j 8 htmldocs |& tee $SPHINXDOCLOG

* View
 firefox file:///home/dapowell/workspace/linux/Documentation/output/gpu/amdgpu.html

Darren Powell (6):
  amdgpu/pm: reorder definition of swsmu_pm_funcs for readability
  amdgpu/pm: clean up smu_get_power_limit function signature
  amdgpu/pm: modify Powerplay API get_power_limit to use new pp_power
    enums
  amdgpu/pm: modify and add smu_get_power_limit to Powerplay API
  amdgpu/pm: handle return value for get_power_limit
  amdgpu/pm: add kernel documentation for smu_get_power_limit

 .../gpu/drm/amd/include/kgd_pp_interface.h    | 47 ++++++++-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 64 +++++++------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  5 +-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 33 ++++---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 96 +++++++++++++------
 5 files changed, 172 insertions(+), 73 deletions(-)


base-commit: 3ac16cf105253e17c4e63d4216bd4012cd5b3145
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

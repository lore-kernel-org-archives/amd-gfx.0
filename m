Return-Path: <SRS0=AYlF=LA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FC3C47096
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Jun 2021 05:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A3F8608FC
	for <amd-gfx@archiver.kernel.org>; Sun,  6 Jun 2021 05:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3F8608FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45E566E511;
	Sun,  6 Jun 2021 05:00:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10B646E511
 for <amd-gfx@lists.freedesktop.org>; Sun,  6 Jun 2021 05:00:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBEPf//IPcqLYVIyBhIWgkSoQMqgMw09PZyUh5bUz1Xf7I/0kiJJYkuiEdhagDS3LQ3e1qWVLE823Qz1wG2L+23NmczgWlLYJcqI9uxlv5Jo/V9r/duz5IVEfs2nJsx2D88vhMvawcqGCACJNZ045kEzrXI7bL2RpXrj3RdQtiDLYinGXccnxo56DZpApvUlXeQKlJorKI6NbAi92xYPXjom5FCnkY1sMy83dd5uiutq77EGFDGJryDJYf1xrQt4Xc2PoCLHm4od4UVTwSgl4sNYFyZrYUnMFPDsUV7t8NgSgu8zyhxhU9ECh0ZFnrSwT4lyqJQup8lR4x/61/NokA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7OxxXKLT0/1D2jPY8K+6COCt/qmTxzSf341+Ih3Orc=;
 b=nY1oLfC8T2s5I5go1WgkPI0jxi2HUglN8gP0JmeXqF4cFwE8QIj+12ujXsIsUBr/HzSfSO7m8lB6DNpgY7Ur51bVLIc5tvjmVlhJXeJy802RUfv0GnDz+mxAWQDSbelWGjheh1eCE3hrMN7U9oT94301ciu4moKy35oSFDFfLrLlAGq7xe/MxEzxApgt4suBjhAVB5nsd4Dn92cT7TK7/XwRdrl3fHrwXHnY0vjdrGSJNv1uf+RCdwuuaf1dub3D+ABLAldh5gOI+D4aIBtgqeJ4Sm2ddqqIRf7ypEGoWKz8b2E+/MRLxiB+fnowe87jhrm39UqVgb3sW4pI5NGO4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7OxxXKLT0/1D2jPY8K+6COCt/qmTxzSf341+Ih3Orc=;
 b=S1Tt1CJ8aICyBcs7GdUy7gchZ/YaSzWmoN+lG835JAS5z2Gpjf+cmFwcwoj9Ao+6tHYxMCwnjU+fidKxZ6gPQ3m/Sy+Ipx28c0catF/Vm6y2rSSrfmQYr5NVgusEGJP2JPe997E45hu4X5kf/B4a7LiJ8kfik15/Ad1EJmKt2pY=
Received: from CO2PR04CA0116.namprd04.prod.outlook.com (2603:10b6:104:7::18)
 by BL0PR12MB4754.namprd12.prod.outlook.com (2603:10b6:208:8e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Sun, 6 Jun
 2021 05:00:42 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::b) by CO2PR04CA0116.outlook.office365.com
 (2603:10b6:104:7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Sun, 6 Jun 2021 05:00:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Sun, 6 Jun 2021 05:00:41 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Sun, 6 Jun 2021 00:00:40 -0500
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 0/6] Modify smu_get_power_limit to implement Powerplay API
Date: Sun, 6 Jun 2021 01:00:17 -0400
Message-ID: <20210606050023.4124-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c440ed55-581e-43e5-39de-08d928a808c1
X-MS-TrafficTypeDiagnostic: BL0PR12MB4754:
X-Microsoft-Antispam-PRVS: <BL0PR12MB47548172C35CD80895992C3EF0399@BL0PR12MB4754.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:541;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJVoR8HwfYyXASNtYcWbI+gf4DvV5TupTOMean3yDWZf2QfB+tBhcjTiD3UuHw6oLLFtKhym73KhPvqEzi06yi314YKrBlqKy7yR2bfWQFdEbzpvNmAsJoLhIa02dt3LOYCmh7gZqaIQdzXW16aOjnbqvr8yVodMeS/k/QNfm9nZpApBLLSkHCVMpZYkJEfBHUo88xvcckgMPFw1DsaDpn3T/JIZauFO0a7qQhTemddNvJVDKk3nWmhepxwoVtygYW9H9CzFaN+wCmXPnlwPVda0E0Y7VS8RLranEgioI4OWHN7y7iCOdvQM/LNNtcSjPWJ7XDc5Ip8bi6foPDqxRjOOz0f9nmgjo5rFohemIcmMomlZVlOEDGNpEhrpgrbKdUji/npYhjSQTR0IvLfssVZzfEgcgN0sHrN+djNPqG7Cp14Ac67LOvR0HcNeCCpeRbbBiWS0FObmond020kfveFJKKwKs8/yc7TL1jlIGbS1ske2ZXyod2kx9cd2YPHR+Funf1C0WOa4exumLiNqSZUe9xBJpfD4+qC8AWZJabJXxc0LRzIybDUAYfDKNgj8yLfzqvlYffuGKTttQI8rMe7xOo0Y0jsMvusFjCavQYPkKhRFwm7cLVje5lsnt2HE7VstCecDStIUm0JU6vQcwnwjS5ORbhSBe+FGt872VHPhlVz5U1H3nO+B0mbXL7Cx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966006)(36840700001)(6916009)(478600001)(16526019)(70586007)(2906002)(186003)(26005)(5660300002)(36756003)(47076005)(2616005)(70206006)(82310400003)(336012)(8936002)(86362001)(44832011)(8676002)(81166007)(83380400001)(7696005)(6666004)(356005)(82740400003)(4326008)(36860700001)(426003)(1076003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 05:00:41.4584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c440ed55-581e-43e5-39de-08d928a808c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4754
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

 v3: renamed enum pp_power_sample_window to enum pp_power_limit
 v2: rewrote the patchset to use two enums as args to get_power

=== Test System ===
* DESKTOP(AMD FX-8350 + NAVI10(731F/ca), BIOS: F2)
 + ISO(Ubuntu 20.04.1 LTS)
 + Kernel(5.11.0-custom-fdoagd5f)

=== Patch Summary ===
   linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next @ 3ac16cf10525
    + 1a7ee0a2bc79 amdgpu/pm: reorder definition of swsmu_pm_funcs for readability
    + 3d0481caced7 amdgpu/pm: clean up smu_get_power_limit function signature
    + 593d896cf90c amdgpu/pm: modify Powerplay API get_power_limit to use new pp_power enums
    + 45339b7190fc amdgpu/pm: modify and add smu_get_power_limit to Powerplay API
    + 8f4be6d2a9df amdgpu/pm: handle return value for get_power_limit
    + a2e5f8ecd04f amdgpu/pm: add kernel documentation for smu_get_power_limit

=== Tests ===
==== get_power_limit Test ====
* Test 
 AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
 AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | cut -d " " -f 11`
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
   :identifiers: pp_power_type

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


base-commit: f60839821f77d6db48bfc986e0391b70b31fede8
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E0CC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 03:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82E7360FDC
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 03:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E7360FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F486E8F9;
	Thu, 20 May 2021 03:58:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B08CE6E83B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 03:58:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lt0KyYDvvz12i5OqYeexhHHKlNxA1O4yEEZkja6sXyAeiUY5PEf9oCj8SS991BtKMQ2vWHzZwYSq/mUnvtXsR+sdk88VsIaO1FKMBexNQ6onNyRiPbp1G1pkNRz3GdrZzinUfSf0vOBl76uolePgjlExT3rcEzTvjUfIDVtbRD3/8kC3r1lWz9+nfa54harK1bbvd6MsORmMjKK9vzVmnVKyPltU2iwksJoI7ehFO6yX/RY8PwNJ5uRTbBlSYbTp+dfptC96VjfMfLHJHz+jrivIrkI8zy7rXPgJtgGPGv0hnBWZrO2maxiNzRhCyvIzZY17D+7B/kogS5GStznksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgmRHDJe6B2RxkctOJtqKaB5GTmKndcHE2jvdCVNiZU=;
 b=dS47k/s6fZn9mEn27leyNN4cv9IB19fpP0dJNtlc+i96NRoslF2w5PhKA3QPM3r5g2lR9ovh/TFUn7q38fJ7qVpFmONMVzuzlnIeBJOyghxPCuDoyReCM15fZxcn5CTDvWAlnHZstfPA5Ji83EjcGDIlJ7UGZRWAXAyDHf6nwM998oQOSeYvkk2wE1GQFMCXuHEp2gxIURsI1k4GOKcl8grvmaxul7RAlOoCfqQyMYX6+Y4h3/Lm+CvVfPpMA5t8+xO+g5l7vHa32/dMJ+myJNyoYDIqAVM5Z3vr7pnWJEJrpc273RHYmB0HiSYS8d1dHuhBK69zDZn4plrL1nQphw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgmRHDJe6B2RxkctOJtqKaB5GTmKndcHE2jvdCVNiZU=;
 b=0aIPFelEUJdFV7wjcohNPRntSbSA86rtZLIBSqo++wTOMrd74njOy/3S4MIoPPMsvB9Wt1z0JEQkaDbu2aNhn87CAIAljrgnlCMgXgULH3Gkk9Hz8cyse2iD+RDgBoMowAGkkZrMTk3iq8AOR0gHFiXX6TpWa2zErc+eeg22QUc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM5PR12MB1612.namprd12.prod.outlook.com (2603:10b6:4:a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25; Thu, 20 May 2021 03:57:54 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::4c0:7a8d:d41:dba0]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::4c0:7a8d:d41:dba0%4]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 03:57:53 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/5] Modify smu_get_power_limit to implement Powerplay API
Date: Wed, 19 May 2021 23:57:17 -0400
Message-Id: <20210520035722.4877-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YTOPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::20) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dapowell-ubuntu-200400-1.amd.com (165.204.54.211) by
 YTOPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.31 via Frontend
 Transport; Thu, 20 May 2021 03:57:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 115995a2-93dc-4606-9d08-08d91b437196
X-MS-TrafficTypeDiagnostic: DM5PR12MB1612:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1612ABE9084EEFF69CBB2C8DF02A9@DM5PR12MB1612.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:321;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MqyR1VEwqoWrto/yLFw3aSQ1x/gIC4DACZaxGJDf86rN250xVZgAPGQoqD9R1kNiqrEK150I3jKo8NrXdjn+iYSVmPuUEXjDcwkbkGrZiEJKcuDonAA9DjMyZRbVvudZGv7J17LP1lpmVpQMmKJXdan3yDQLZ+PWvIawz9cIM1mTGDYHwVRMcorEU1qtLYdNX2j/YWOGE0gQdkVjaPF66L2Mm8JOffUFRuURF0XttM28XHgjKl+m1sGmrIXlc6QrB9VtW09hBFGlthBqsHtNhClq+XCr+DWP7K2P6BSf9JU0/ciDOvEvq+N5re2fNwLJQ3vupIBudnPkqRifQd4t3DnE6LqhjvRL2Oxa3/1w803ZxthK6urSKFMy9gQrSDxVp5TzJj00W/PT12UloZP3aN3NkC7aB15WlBtMgOXw6OVyBeZXP4B2XeaKp3rDFs3bVW8SfgaVjsxH5GIvCpD47byJMnDsV6Yh3d5ARaIKTDyAtuVR6hk94Xm2l5+x8c7C38gistLks1J7pIS5LIYtusSRmn2poJTvBz2SmFjY9LnJLZcJ+Rq3ihsSR8T18Xkd344s1eNcld+GuwkIlYRAPwpAa4BqWgHplRaUqEq/AAZZM203Fx+SLwrUeez+xpSiM0AzGSfhN+gGITy9nL5JZFoVDfRYNEJjuG7t5LwBQpY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(66476007)(66556008)(2616005)(66946007)(16526019)(86362001)(186003)(4326008)(316002)(478600001)(956004)(52116002)(6916009)(7696005)(6666004)(26005)(2906002)(6486002)(44832011)(8676002)(36756003)(5660300002)(8936002)(38100700002)(38350700002)(83380400001)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?n1AHZ1OFA0TjwAq3ndr5DsBdSoXu6WOz1anCXD8bXHHMR7StcS2cv25JGsMq?=
 =?us-ascii?Q?nx/aQ6gefa8evJasBGh4+8/NYCuSLUxab+mY2aKgGsbDsJrUkW8NG7LgSz3x?=
 =?us-ascii?Q?urhQYWDEgwnsSqjDRS5porWNFOCwKLAoHFmbZVdGAcMGTs5KAnS948Iirezl?=
 =?us-ascii?Q?8IJ8PgggZ3PwpAc7OyHmt+RdTLrRzMO3HE5uXC0xLTGX//Wixx603B6g01ow?=
 =?us-ascii?Q?reJPb8abCMH4kd6RrBx5w8sdlVP77+qLRw0iTy/jSsaaNvq8TFoRXeE1LJUM?=
 =?us-ascii?Q?eKPrIm6Kx4WAhlwPOsiPXBgxJ9TfXaYxtubE7gTt92IMIdGsDZAXoQYgzZF/?=
 =?us-ascii?Q?2WsBskXCecku7JJ8kHcMQ8OoM4wva8iJnvUwyikL8Tq8rTBdIQWCExUccwRw?=
 =?us-ascii?Q?zqR8OeoCLU4gLm5+nzcCR4f5ZYsF/3EHnQ24ynYex4JkfMWQ/03jc5xcCSVT?=
 =?us-ascii?Q?RcKcRIPyzCyuEPqdqx9QP+K4i4yzoHyKbcSKk1zoo99chz3CYE8uKtvAJjyb?=
 =?us-ascii?Q?u7B3Lrzalgnnzoc9l6OOX2NpjEnezwq+f/7LmEW27Spe5JfRBLqCQKPn04lQ?=
 =?us-ascii?Q?isZc5cLdix+jPgd69Ybv9cftgfcI3r5M+VVDsZ2RabRKodTkuD3t9PVg155I?=
 =?us-ascii?Q?PrfKbrcI/5t4loNidvNIK371PmmnsA8iLe+WLcguaMsDpBFmLstj39UNEWwh?=
 =?us-ascii?Q?wtTY5yrZrtYyVNIRS8IVCK/qKQ0uyGJIGwzxVneGYP9NVF45J2Tfc917aasT?=
 =?us-ascii?Q?zz2TprpUD8vBTgr2nsq9kJRrjPsQBOMKjvJCU2V5PDen2MdNhmdIoU8hv/Ey?=
 =?us-ascii?Q?ZD7xZUYEJ/BBM1ax1iqjzfDNnIpDYeHkZ99aqet/nm2IoNleFcEDRIk2qsPD?=
 =?us-ascii?Q?D2V0tZf53G1bVj247LUTNA0OxCWPuHzst/50PwXED531vSzc3XH+ZH2HMb8b?=
 =?us-ascii?Q?NEIuUn0Q/KprqwMn4jhek0W1ggRmJs3oOZkwSS8nQeBr1LweWp//Eks771i4?=
 =?us-ascii?Q?zC02eroWi7ocWd+5iK1YlcnINisSVJgD1rVx0B/EhQUc5HeVp2GgL/o358vC?=
 =?us-ascii?Q?W0CUN9o8Y2kIGd0Xmfo7PkSRR3ThTZ/IxYW6l1UVD0o0eswPgxtAAGtYlwBZ?=
 =?us-ascii?Q?Dp7sYvNNsYITi62FBzym4nfyMJoKqZXnhkX8TiPW08nE4Z1dTrulB4fHEyO2?=
 =?us-ascii?Q?3At5/9QfT/g+M9V5aGNgccPdhws4WbEuqcmzsZpw6YpPbarNGgra+qE3hvHO?=
 =?us-ascii?Q?8iBoWodPoAsupT2xEz2kjIcHUIckvJUFkt1x9KtHU63MI1zbc96aCS0SSFYr?=
 =?us-ascii?Q?oHyJc0t0vdk7Aqit8PCTFSlW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 115995a2-93dc-4606-9d08-08d91b437196
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 03:57:53.4689 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Yk/gPFbXS35mnkKDLsXDmqbQRmEKUaIuFtIGQKD1eQaeiywJQAt7B+u23VOSx4WNlhmfjiYTV0uMVaSpil4cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1612
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
Modify smu_get_power_limit to implement Powerplay API

=== Test System ===
* DESKTOP(AMD FX-8350 + NAVI10(731F/ca), BIOS: F2)
 + ISO(Ubuntu 20.04.1 LTS)
 + Kernel(5.11.0-custom-fdoagd5f)

=== Patch Summary ===
   linux: (git@gitlab.freedesktop.org:agd5f) origin/amd-staging-drm-next @ b1d634be9673
    + 538c6ba2ec30 amdgpu/pm: reorder definition of swsmu_pm_funcs for readability
    + 7b3ff20b1454 amdgpu/pm: simplify logic of smu_get_power_level
    + 72f426c7d850 amdgpu/pm: modify Powerplay API get_power_limit to use pp_power_limit_level
    + e6618a44993a amdgpu/pm: modify smu_get_power_limit to implement Powerplay API
    + 16fb37b834e4 amdgpu/pm: add kernel documentation for smu_get_power_limit


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
Test Documentation
==================

smu_get_power_limit
-------------------
.. kernel-doc:: drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
   :identifiers: smu_get_power_limit

.. kernel-doc:: drivers/gpu/drm/amd/include/kgd_pp_interface.h
   :identifiers: pp_power_limit_level
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

Darren Powell (5):
  amdgpu/pm: reorder definition of swsmu_pm_funcs for readability
  amdgpu/pm: simplify logic of smu_get_power_level
  amdgpu/pm: modify Powerplay API get_power_limit to use
    pp_power_limit_level
  amdgpu/pm: modify smu_get_power_limit to implement Powerplay API
  amdgpu/pm: add kernel documentation for smu_get_power_limit

 .../gpu/drm/amd/include/kgd_pp_interface.h    |  36 +++++-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  61 +++++-----
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |   5 +-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  29 +++--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 110 ++++++++++++------
 5 files changed, 159 insertions(+), 82 deletions(-)


base-commit: b1d634be967396d371e620685658224f28ba6247
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4C9C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 09:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 726E161107
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 09:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 726E161107
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22E556E11A;
	Mon,  7 Jun 2021 09:34:09 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CC946E11A
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 09:34:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDcBuhaxb012HnKVF82cC6AuNywkeqlFjz7/JAaN8AvfP2cPTB73Sc4nTQ5Ndf9aN2F26k3UfZXFkjCHf/PkWkcf83dVDHdO7XPPZA1XfQukA02mAAWMGNB0YsNUsgoR2TpxWTE0HWpLvKrjcHR3mR8bGPBasmFNmO1XlJHEIoaY4GNRQzBXtauWofo8i6UoDM4xapwwW8E1CdlMmS458lqcqKdxnBeh9k6ICBXW4P09MZvm5ctgfkkuwfNpjCFmrObYry/6FbyoIU6HZc2MR5O1jK0fRYGskWl00alOTb0kAS+azpqHmrsiPoHuWdLfrfg6po0JveZrOb2ddy5gDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzjkXTeMvAFaGSWJfF6TFoZIvDO9ktDDxCGQHmydR24=;
 b=gAUtFeF0ndoc6pvPDH4w3CrSCSxtG6kNQa693Cfr9A+NeAP8d5X4LzbLxIMmTrBPWleUkdL7Ho8IfU/EFn6k1QaHErTEZ5g6vcgLfM0ud1/glP3JWtWAkGShn+Dp4mRaVxcniUTqIJzXa0gbcx5Jm337dcDfp4989e2lI6JJBK1fX/ngvL/QKIDzCHL0sNvTtG3O7xRZerK/2sveMpjN+QxSHgjt5zIaudtunxtlHFx8VMcWouhY+DcE0kGqsdle8bL2wESY0aPD8ah6eRuoAOG3bZj6cxt7F9x+wxGDT9W0wz3ih/KRilIxjurS2k+aDj/B6+j2pbVXPAuwe3WSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzjkXTeMvAFaGSWJfF6TFoZIvDO9ktDDxCGQHmydR24=;
 b=nu9kDXnMBeWsaX4H8EUrk4xsifky4lvBawIGPJw5BK+zeOd/hlR3nKBBzvGMyWczhewmoVAMArLCHNJtlVvGou612yO8HbsEG58mUZRq9W+WvtPgEBwXDeY9hMw8Lc+P9qWb+6/PgKt3GkJO8ofxmUM9Si3slSj4LhAZ8pl/EvI=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5313.namprd12.prod.outlook.com (2603:10b6:610:d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 09:34:04 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9%3]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 09:34:04 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Powell, Darren" <Darren.Powell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3 0/6] Modify smu_get_power_limit to implement Powerplay
 API
Thread-Topic: [PATCH v3 0/6] Modify smu_get_power_limit to implement Powerplay
 API
Thread-Index: AQHXWpDnPFCyOCucLkOTdCDuzxfi8qsISq2A
Date: Mon, 7 Jun 2021 09:34:04 +0000
Message-ID: <CH0PR12MB53481F3A61C5BDF2CB76D80597389@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <20210606050023.4124-1-darren.powell@amd.com>
In-Reply-To: <20210606050023.4124-1-darren.powell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-07T09:34:00Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=796e417d-4dce-4784-abe5-822d9c008463;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [117.222.150.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c6ee61c-adbf-4fbc-cbbb-08d929976423
x-ms-traffictypediagnostic: CH0PR12MB5313:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5313F1E356DA39957A68539797389@CH0PR12MB5313.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:230;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uSE56wNxYAogHScSoWzBhsyP+c/ldIvUKg9g+JREvmp7/x89ieEP/kJMK0vFWygMvQ7Q9AR9o+QucKynk3+jCKTyGf/8pSw9Xozrmba/gybTRi79UgYttcK6wPTUOgCQlY8wQNikX3GDEZmo1tcuDidewp/dlZauPJDQg164VnjOQJuXRnnRWPsYMMGcZt9ssAmyhFRWIcsjCX2taV+fLD4jp5UeNOUCxoYUy7qkZFiistaSrJdFjLbifBvsu4nPG0rBPcCBvEfX1Jm7nsPFBiTRF+Fi4W4r8BMm1bY8oIW6JpjVFQpSv3hcF8mJZACQgOjyrWzYwYJ8g6dGcxVQKDgh6kYO0QU4w5MskdyGbLQkYEB1xUq2kv/vYokuYEXiR58cnB/ABNtgXC+CoaqGN4lVxEzwR7aLW0c5VDk+0UluOlk1D0yU+FStLQK8hZ6ywLzj8PNvSGfERiyRfrzkhHdjLBkQfcROQdrkdT9PhKiIi1CLrAlQKclJOM/YDmod1hriHVFABZVfvh/4clmBMVrZ/NBEZ0qDYZqJEnhP84yjeUGxvb0oo6PCyRBFO56no02TP8wMwvulKsFQbdvc+ZC1c0GHfr2rQYaMjazEmvM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(86362001)(33656002)(316002)(186003)(110136005)(2906002)(478600001)(122000001)(83380400001)(26005)(55016002)(71200400001)(76116006)(38100700002)(66446008)(9686003)(66476007)(66556008)(64756008)(5660300002)(8936002)(66946007)(52536014)(7696005)(8676002)(53546011)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?fkUQznEsBjFCQ2N591JPzWGZii6D1O5nGvq43ga207n5Zmy+SsC16r1/v4/I?=
 =?us-ascii?Q?2yYpUvIbA0cXApaBKwdeVhgaoZXqK6Sz+rtVfEW4Fy/3pVUPC1btpSzNXfkL?=
 =?us-ascii?Q?gmYsbktBcZhILQMMiMWAzFcKUlDDbfTNfMzurW4ZDTK7LimXoddhVTtRu/HS?=
 =?us-ascii?Q?9aKsFJ/JvJDD/klFoDWOqKQjHyd1DaTf2DoVfHoCH3LDZPhxAVk/DWWm6OCX?=
 =?us-ascii?Q?uXL/H1aQmb1vC/EMHHMt4pqPle0uL2uE4sx2Fc7iYuKrm2S09/MoVSfMfJL/?=
 =?us-ascii?Q?2R9ufq+DhE3AElwfINtynUUcoPQOqnbg4Bi19a5rZz1RrxPj8RUZMLMMScX7?=
 =?us-ascii?Q?HDsjLb6mLwknyUxybvPr7rWE3LiFAmWKtQ3y9O/ghW8B1yRxIe9heE2ioIRj?=
 =?us-ascii?Q?B0sh0Jww1v0/cMie4JIpiVEOlcpj90pCpe5wZL3vrgFCsUp6zAjaf6HGl06b?=
 =?us-ascii?Q?v3jJK23rFlrH1OT0w1w4aPBwUcVLqiwvGZ6mGk/6sP25t8kOyeAi0RM/rjtg?=
 =?us-ascii?Q?8hf8fslEUo8TmuOucHC5QbGhneCcH510yZsH34qYFkLhQVvbhr49OyHvfpqp?=
 =?us-ascii?Q?rjZinmHdAoGSTH2WUC+DyGh0p3qsiKyMG3Tc9G2WU87J7PdPiVU96Qi590zO?=
 =?us-ascii?Q?pqyEGLRNGsidhkgc/nMSmOud5LKI9Z8kJAJeJjcjUgSmu6vqC+1Pd1XuMySq?=
 =?us-ascii?Q?1rVkcKHHe8QA5RTjZCnC0nUr/E2ljrJUJ7vm06wINozeafEGJugyC4l361Md?=
 =?us-ascii?Q?8awDDGzMzPDTh+K/wfF1HZoEwYrcs5pShzcLosD8npY/WNX5v5UqybaPSfSi?=
 =?us-ascii?Q?9KP3uNzQc3xEWhQeAdFpyJpPHGRcWVYUgE+oiB4OxqFxugSrT/TSATMKE3Hm?=
 =?us-ascii?Q?81zDX/vKU2KGxstfjM6G6Mz9FxRv0GIfAfoW2qMhfQ8Iwos6Xp71wadgbRPf?=
 =?us-ascii?Q?6yzn03uAZ5IlcKvoOKNyPGKDxiE6wgVzAMhaxXXP8vI+4pyhxKV9KpxUqJBr?=
 =?us-ascii?Q?jQ0Nxr1RcEaqXGUz70HetU3HeyUiqLtSksMmpCC6N3eAYqY4ktv3AsWAv2IZ?=
 =?us-ascii?Q?kSHe/5qUayBsOkt+dVxaZIw8MPokrFgXUKYD6XALEOf3Py2ViF+sMlpgR43E?=
 =?us-ascii?Q?v3BVBTgNrDcGpijPhTXBSa8rOkV201H/2oWYhE6n+PwN7GDyDsek+F84Dpjs?=
 =?us-ascii?Q?wJHUUywvdGT9WMMkJcEqSqKgwnWWkwpU7HDaUjTRkPuB9Uwyd5Uh0QPEN69Y?=
 =?us-ascii?Q?28fexHW1LXlP1UR81Bx9UivShQwH7mrPnu96RyzwO97Or//jwuK07IDBPe0d?=
 =?us-ascii?Q?BdjG9TvFFNv1RMBkRzsJrcgU?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6ee61c-adbf-4fbc-cbbb-08d929976423
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 09:34:04.5657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zghWJGuOlY6kgQEnXEmOFjmpSt/+YWyFTM2tli0HCLr9VrvtZqhnJrr/CkAY4Ius
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5313
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Series is 
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: Powell, Darren <Darren.Powell@amd.com> 
Sent: Sunday, June 6, 2021 10:30 AM
To: amd-gfx@lists.freedesktop.org
Cc: Powell, Darren <Darren.Powell@amd.com>
Subject: [PATCH v3 0/6] Modify smu_get_power_limit to implement Powerplay API


=== Description ===
modify smu_get_power_limit to implement Powerplay API

 v3: renamed enum pp_power_sample_window to enum pp_power_limit
 v2: rewrote the patchset to use two enums as args to get_power

=== Test System ===
* DESKTOP(AMD FX-8350 + NAVI10(731F/ca), BIOS: F2)  + ISO(Ubuntu 20.04.1 LTS)  + Kernel(5.11.0-custom-fdoagd5f)

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
 AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`  AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | cut -d " " -f 11`  HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}

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

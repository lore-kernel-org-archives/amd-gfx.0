Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B279C33C9E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 17:58:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50B6F2465A
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 17:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GDpVDeNG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B6F2465A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAC326E43C;
	Tue, 14 Jan 2020 17:58:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 297506E43C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 17:58:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtG0UNrxPnbRi+19eIikO0NM8cncNmWMHMxaeORFRRFXs5xDUUpXVRNTqSaq0sLioJ5aoFQch8wzJAtNPbyUqT2shPJUP5BSivGOwPaI+eirVFAgVoaq/43/ukS08hb8unRro/QsKsmCCy+ANzE8yM0Th4mR9E4/EJElYfS4AdmwoUw/jbxWTzLfi6cIPPn2SJDBIebr3XQbl1vIrsMayAqo/vLhiwC2CicGhfbz1ZQP+6po72fSbeI5tLrRk5g913BR7xxlrQPoN1L9goKseAoPWs0BG+DMGgnARxC4tpbRwwiflvyC9yYTzS5IN9bIqOfXLjUwsWmzydqcQ7m3ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0imcwlpbv7lEH90bYfvoXnxIrXN4bqojlrF52DqgKg=;
 b=L/ah/JBmjXL2wOOLpWEDa8+ffmpxoVrNIufuZsgCliuB7OY1Ce7sU4cTCoYFxiC1jkRvgrn8juAeJ+wKKS0k9OLmlW6HITrOq1sYir+GhEsvX8HIqsv7YvtcjH6Ei11Ik3n51zuKABpEbIKlYF6ewJkhj32vftCkgVTAUB7kXxl4zzThVICohk61NEqw08ykB8A9NaV+ofk0aVSRAy8zT26+jFYSeTWZYbklImTlhwroBOXrEdy2jwvn8M99ZOD2j1ts3D0hwGRBRGwTkRvDJIpsAxMFMi2Vn7pz+btb0l2129wMHIFtMtwkYASKWVMUlYVSF8LIsC26WRsGBYm7mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0imcwlpbv7lEH90bYfvoXnxIrXN4bqojlrF52DqgKg=;
 b=GDpVDeNG/h++BGOcTktmQtfprklNynW8vwBdZgN2kmkJPs14TKTsW/drrN65huAdODgbCS93VgdEU8kUZ3F/GaFeMxnxvzjK5XogwC8/DEHSkZy6ZwIlUimsErULhbazhk48r+HdtyvJaKKhGKglkP+QiJ7cXmzcWFB9W7602FM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3109.namprd12.prod.outlook.com (20.178.54.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Tue, 14 Jan 2020 17:58:30 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.015; Tue, 14 Jan 2020
 17:58:30 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/6] support ArcturusIFM workaround
Date: Tue, 14 Jan 2020 12:58:16 -0500
Message-Id: <1579024702-27996-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTOPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::35) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from work_495456.amd.com (165.204.55.251) by
 YTOPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2623.9 via Frontend
 Transport; Tue, 14 Jan 2020 17:58:30 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 23fac085-1c9d-42de-3fcb-08d7991b5d50
X-MS-TrafficTypeDiagnostic: BYAPR12MB3109:|BYAPR12MB3109:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3109C0DCA08E5D9F836D72E5E4340@BYAPR12MB3109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(189003)(8676002)(81156014)(6486002)(26005)(81166006)(186003)(956004)(2616005)(6666004)(6916009)(7696005)(52116002)(16526019)(66476007)(66946007)(66556008)(4326008)(8936002)(36756003)(2906002)(5660300002)(498600001)(4744005)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3109;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VdcCkzNfOcGuboth6oMG1Epav2+MUFZ+ezG6l/Z2YOvh6RqGVgtPB1iTxgNrTKX2h++uvPSyB0kLv+JWxuMnvQv+qONtQfTfvovq48r5YUeogbGs3vnKuCw7rnPr0SbUVo6R0DpwCA84IZUrco3uEWu7aMFRcu1djBUUa03fHTBNSQclc/g2Q6PuDRZfxyY+bOhMBmU2srnd2+N6PLPbVKNIYhTZdAJL1OG7Ju6DQJlo2IvYb1PQWlxQ7GDjb/6Mq7G4JZnsX/3ywG5gpwjpDLHpUwfaPn9As3kTn+owlkFXfsE2C0236MJ+lJCrBEAUacpqH1KezE8gnOHLG18DK1uGO3cCDtsrqXSzLaLOdbTM4KBSHMEEWm6PudaA8PrugvpzKYsSLqDClQhxFNUadYEXpYMhBQK7BJxFdhEo9xHCbKEfa4wj5QNCpyUbm92Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fac085-1c9d-42de-3fcb-08d7991b5d50
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 17:58:30.7240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7ROyEFcqUJQpXiOitkXr9tJDVdowb/Sk+0r74siY0SuFLZ0z7YaIJWAV8+16L6u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3109
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add vcn2.5 dpg mode/dpg pause mode/dpg sram mode to support
acturus IFM(instruction fetch monitor) work around.

James Zhu (6):
  drm/amdgpu/vcn: support multiple-instance dpg pause mode
  drm/amdgpu/vcn2.5: add direct SRAM read and write
  drm/amdgpu/vcn2.5: add DPG mode start and stop
  drm/amdgpu/vcn2.5: add dpg pause mode
  drm/amdgpu/vcn: support multiple-instance dpg sram mode
  drm/amdgpu/vcn2.5: implement indirect DPG SRAM mode

 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  34 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  37 ++-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |   8 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  12 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 394 +++++++++++++++++++++++++++++++-
 5 files changed, 450 insertions(+), 35 deletions(-)

-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

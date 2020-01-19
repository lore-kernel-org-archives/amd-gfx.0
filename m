Return-Path: <SRS0=dEFY=3I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACA0C32771
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Jan 2020 03:03:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FCF3246A9
	for <amd-gfx@archiver.kernel.org>; Sun, 19 Jan 2020 03:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Whnezd7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FCF3246A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3099F6E1BB;
	Sun, 19 Jan 2020 03:03:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 444B46E1BB
 for <amd-gfx@lists.freedesktop.org>; Sun, 19 Jan 2020 03:03:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Avy9Nf5sI84mAMrLuflSfsSrhAbLaC+V01I1uAKrJd+PwRELpOG+XTU+hzWpvHRnv9KAr5NUncDgUMCWIQq1ZKWYm72tSWwqR0UJihqBv0m0D+xV1zim+aMJUT3u42ry0is8PVaTpKPvPyI5arjP8bBiamPoe8tk2P+VDcTgal7ypjapgkh18I0oL7OEMvVmc1LNSOHODvEuIICitHQCnC4H4jh3Zx0v1RBAHYSgd3IqWpwOHaRd45FB3GtgDs6babrGrggTCGjALYPp7cZLIkxN1LX51IRwiQEE3jFr2XWvnLkO5QjCditfhmTKEIk2vGos+7wjPqyeLmB0LrvryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sW3qtTdf/J5iJMhI9tEiDtvtvUrfRViSVZQErCidzpI=;
 b=AnirM44nIxiOFqxgzp59fUtoIwsVJ2Yw3YhH6ridqrJrFAmnfbUCNzT3aA0rlIEmt/RShXxIWFO1ckMyCItvXV8IFkjWQhUqhuncJU2WgcngaIRr1IrEjakvjbtJd4xVIjklaeCinV1TGStN2xE9f6Gcg1R1SNC0x1gEabumLsyOjUbhtfzqEyzmlUHHKDQ3yct0yQ8OhSknwB57IPtzx/R8EDF8vxH/6EOVTgaGQS9ujG5fyUUTlS/TjybGccJ/fKogIXARydDn1IZPBw4D6Qme+WgL74m36XmYyWCYmD73EUdzcLUmSmEkYYT9KiL+5Nyw6Sxvg742S9LE1ypTRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sW3qtTdf/J5iJMhI9tEiDtvtvUrfRViSVZQErCidzpI=;
 b=Whnezd7VBU4sL9kgfkUQoa3oMgE1AhK8XTfmUFHb0vgnXT/jXRAcIl0Timo6JgN53rgtOII69JYEe6BxeTSPhcm0RVK3zsOK8a4NoQwLsjZhxEAhRkffaaXVG76RtNThiTl34YsAZikRJ+Vix8wxVlCGgd0TOttqqzkf2grje9s=
Received: from DM5PR12CA0021.namprd12.prod.outlook.com (2603:10b6:4:1::31) by
 BL0PR12MB2580.namprd12.prod.outlook.com (2603:10b6:207:3e::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Sun, 19 Jan 2020 03:03:03 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::207) by DM5PR12CA0021.outlook.office365.com
 (2603:10b6:4:1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Sun, 19 Jan 2020 03:03:03 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2644.19 via Frontend Transport; Sun, 19 Jan 2020 03:03:03 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sat, 18 Jan
 2020 21:03:02 -0600
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 18 Jan 2020 21:03:01 -0600
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Tao.Zhou1@amd.com>, <Hawking.Zhang@amd.com>, <Guchun.Chen@amd.com>
Subject: [PATCH 0/2] query edc counter for more mmhub sub-blocks of Acrturus 
Date: Sun, 19 Jan 2020 11:02:50 +0800
Message-ID: <20200119030252.23853-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(428003)(189003)(199004)(2616005)(81166006)(2906002)(336012)(4744005)(1076003)(81156014)(426003)(8936002)(70206006)(70586007)(26005)(4743002)(186003)(7696005)(8676002)(4326008)(5660300002)(6636002)(316002)(36756003)(356004)(86362001)(6666004)(110136005)(478600001)(2101003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2580; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a848f384-182f-4e58-83fd-08d79c8c19a0
X-MS-TrafficTypeDiagnostic: BL0PR12MB2580:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2580D12496A4448B7921D8F9ED330@BL0PR12MB2580.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0287BBA78D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gtQmJswMP8VqL7L0FPRjyIkRGOjMVIi6hB0yZHj9nNLvGq5lDskKoe4ir8jGhBpXJsx1Qfk8kfm7whi/rd7grw4QHv2D3PvdIA1iVXszEScNpYutfPWr4LsvBAjgoQFQK0NDdMh/zSunLupa5Rf8Xxhz0CMNNZq22iPqe8qBj7ryCN+us5ooRLVHnbLAWVmWKz1KGb/aZoxeg2zW1ZGpY/ILe6FxYs2RnRnhjL/y4ujl/6jOdJVC8CK2w9nflYoebzrLnpacehNC3xvx6E2y+8ZLlYT2Co1T+engHiqU8kevQwAye4kn4OrJBnKv7eO78iD8aELXrh8MRwbytg2NSkdJkOm34e1TDt0uqolsohUbld3tF/RpOCSvNWfaeML2jygb1winIcZ7O1UolyCs/lUTR9W5UOMThaAS3m1dUP8ou9AZAAm5n/vBPe7PSi4NqNl3PC/pEwJA4at2AEFbf7HZ0RgT1ILCBgAE17Cm8+M=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2020 03:03:03.4688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a848f384-182f-4e58-83fd-08d79c8c19a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2580
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1. Add RAS support for MAM D(0~3)_MEM in mmhub.
2. Add RAS support for other mmhub ranges from 2 to 7.

Dennis Li (2):
  drm/amdgpu: update mmhub 9.4.1 header files for Acrturus
  drm/amdgpu: enable RAS feature for more mmhub sub-blocks of Acrturus

 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c       | 701 +++++++++++++++++-
 .../asic_reg/mmhub/mmhub_9_4_1_sh_mask.h      | 128 ++++
 2 files changed, 823 insertions(+), 6 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

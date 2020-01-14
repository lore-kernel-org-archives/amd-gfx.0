Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91FAC33C9E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 22:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D0D62187F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 22:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="QONCDEiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D0D62187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29D4C6E06E;
	Tue, 14 Jan 2020 22:23:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47B976E06E
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 22:23:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1KuMZWGsZbaQhsLGn3+lC7xxN4wIT9ENzCkpKmiZjTcbEDJmNIQXJ7t1wEkibMqOkgot8djKYYNT9fSH/nUFd4JEeg40Wx1O6J1tXz/L4uIVfQ1K0lSJTvfeY2B/TMBKhZEpJXzonkE0Ses1kTkisTJQ++3FxjB+LxFsfJo1ShARdp1xH7Ky3fKjHDcD9VRrvMhDVOPUxbSlfif1x5d42/rpWzfgCbWhgk3JmNy4LYyWDtTuKTLgYyYk4eqM8VWrRyu3K7YS32XjtjYC5FKnh2gHX7CGA2QUKc4jiAWiDYor2wqLnDSRxp2eYHXg3kX0xMvTZgtE/5S7zbu+CeIyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yI2wXP1lYQxVzhNNGoNrW1KRXTW8xI0/khBbOB4oNk=;
 b=V1m55PPAwAVwIxmPITHZu/TOhq3yqp1Bx0MReCDAM3QIUcbT1XJkyWk2DUXb99ry4oSNllxsgHyhblurx3c3qSdzHYs63i4N5dQvu6/QbsVdWSQDsssNkfBCxwa2tdShyw1HbLNcsOuilvVsR41zjCtAQp3KC6bpIl5beE3XDMq5DyAJgEHEwwgTS7EpquCcjh8l+WwIdlIjvoSOGCaEKpY5j2VNbfuYmLcRp6vrXcsWXnMrwON6ODdxGzoe4um74ckY8q+j0uCUVO/POrT/2G8V3CC2AcoVFVm1daysQryeUU1SgH/Ylq9LZzu1oZnTOqxaabbozbswQk3nvBnRAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yI2wXP1lYQxVzhNNGoNrW1KRXTW8xI0/khBbOB4oNk=;
 b=QONCDEiJpeeZPMLgQSc48f8AhUmKu8wb0ahu7X47jI8tZd11yBTheNxAR1KXPBj7uJ7PnmjimQKzDBwpuOt+hI2HJP7EKkp0uL2fKMa7ZG002iLmq4HiwG9cVOdIK+an0r0n3a7ylhV1x7zMIb7slFHOHALkfc5nLIGRUfG/5FM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3349.namprd12.prod.outlook.com (20.178.196.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Tue, 14 Jan 2020 22:23:25 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.015; Tue, 14 Jan 2020
 22:23:25 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 0/5] support Arcturus IFM workaround
Date: Tue, 14 Jan 2020 17:23:11 -0500
Message-Id: <1579040596-12728-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::20) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from work_495456.amd.com (165.204.55.251) by
 YTXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2644.18 via Frontend Transport; Tue, 14 Jan 2020 22:23:25 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ee3d7d2c-e3a2-433e-a238-08d799405f69
X-MS-TrafficTypeDiagnostic: BYAPR12MB3349:|BYAPR12MB3349:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB33492798E551E408BAB61A48E4340@BYAPR12MB3349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(199004)(189003)(66556008)(6486002)(36756003)(6666004)(956004)(4744005)(2616005)(478600001)(26005)(186003)(52116002)(16526019)(8676002)(4326008)(81166006)(81156014)(7696005)(66476007)(5660300002)(66946007)(8936002)(316002)(86362001)(2906002)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3349;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SKty0jaunS6vOE3LaTuC2rO2p3SGDX3pZc6mOtBOdVcbgBqs0y7xbnYkH408UPv4wWEAzxVvWLZRYosWNJsolhsz5OKk8w5bY6IAEfn0bK3NHuzMXXbWr8yftoC5Hy+WyaBenEWtaAwRfOyJsSysL5qlwOqJTLlhIAxwlOC8ur4w2iRm96aoQPrDRtA21yIHHQshztJFLn5xG+Cs+Ak859iue+zFi+U4KUJ3wGqe9R78DIGzzdcLGF9YbuZfC0cO42aINRrNA1OGJBCGpeK67gkyI3qvh/Xg5Q20w+G+m2bUlX+HsqyrZhXT+e2TG3gq/GO38xgBjRTHxHgkgK0qugEXGld7J826UInnnGFH/RM0x/YAADfinVNS0rGCPzCgXEszhBcbu+doa4nJnaCcbhNPluq6tmm0k067jugzk1kuWhtOTaHBsp6zkjSTUhr1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3d7d2c-e3a2-433e-a238-08d799405f69
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 22:23:25.7297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkRm+btAYDUmOThdVOLSqZ0p5DAzkliZek6hT1seSYoIKwrf3fR90GzZzm1bRAOl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3349
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

v2: Correct firmware ucode index in vcn_v2_5_mc_resume_dpg_mode
v3: Share multiple instance indirect DPG SRAM mode support for vcn2

James Zhu (5):
  drm/amdgpu/vcn: support multiple-instance dpg pause mode
  drm/amdgpu/vcn2.5: support multiple instance direct SRAM read and
    write
  drm/amdgpu/vcn2.5: add DPG mode start and stop
  drm/amdgpu/vcn2.5: add dpg pause mode
  drm/amdgpu/vcn2.5: implement indirect DPG SRAM mode

 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  34 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  48 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |   8 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  98 ++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 394 +++++++++++++++++++++++++++++++-
 5 files changed, 487 insertions(+), 95 deletions(-)

-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

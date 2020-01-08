Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8952EC282DD
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 16:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 524702070E
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 16:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TQZ8O5B5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524702070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E91B088161;
	Wed,  8 Jan 2020 16:17:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADE0C88161
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 16:17:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWvCXMgLlBigCYd8UWpEVZudVsCX09FLv0S4qPMitjwWg1qxxLQTc9QFW5qXQEyCwWKDphI0QLMIXf4sTAD1P5u5SbPJfgDZb/lLLuBh13+rwc5c7sIvUoUEB3jpgV942thCJloH5As8iQFmfo307ERyI1YAQoRyiJgyfd91/9XzqR2ZVl8/d0er68G9ikvmG7DS7JxErMwuIlIIzq68FImPCNsmJYfIJ21BAIAhRv8DzJM99vErEgczyviQiPgL2UsnbmL+PBZ5rdHvSe4Efl0YwusGkiZHJkQyMUJb2FNHLQFhrUk1P4/O7Bkt2NZEKLWG2YOFK/pK+IwnXX7xGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=353GxJ7VMvzSqSNKINfFHiY4hFFVkBSWf7nJ7sQ2xPo=;
 b=ii4wOjFHWzalD/v/V9I9AhgSDewGbDuRMuM9QyqrbYsGzBkn3k69TdHUaRpShcmLgq35cTL7We458/I3xdodbjyw9QCm6qcuKUfr2R9beNTCRQxTgI5wnm+MBNRYeLGCQw6Ed08KBDmSeZIjh7fvfr2hlbLuH9DzgiJiKCmwIaxBH079DC6FFjd3K8fALYD1Kugl2H2M7SkIIFqv4s1/X7OAfaw4ZksOSu9xVqHDR2Ify8DbxCqBk8ldeEP5MEEo1fpaS0QEEpxHXSlG+/ayqvxojuW+5Bv54maaP6v703sJS7aOHpVLYgc9b/vw6+kXjDRNkWXl+aNj4Hc4Gy23xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=353GxJ7VMvzSqSNKINfFHiY4hFFVkBSWf7nJ7sQ2xPo=;
 b=TQZ8O5B5KftAEusYBCay4ERfsn0gdZLY30FfwUpaZ3pVvdXVVzfyqTGeoZ1y+2O88sXHzTpqKHQ8kLU6Dpuwz8HXic8XgRLhkyTQEu91dl0J7ciRqVMHnGEYTEnr3TrlWo+jSI8s90C+ur91PnAZ7SXjKFGp2yEf6a84eVa3soo=
Received: from BN6PR12CA0043.namprd12.prod.outlook.com (2603:10b6:405:70::29)
 by BN7PR12MB2738.namprd12.prod.outlook.com (2603:10b6:408:2d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8; Wed, 8 Jan
 2020 16:17:37 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eaa::205) by BN6PR12CA0043.outlook.office365.com
 (2603:10b6:405:70::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.9 via Frontend
 Transport; Wed, 8 Jan 2020 16:17:37 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2623.9 via Frontend Transport; Wed, 8 Jan 2020 16:17:36 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 8 Jan 2020
 10:17:36 -0600
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 8 Jan 2020 10:17:33 -0600
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 Dennis Li <Dennis.Li@amd.com>, John Clements <John.Clements@amd.com>,
 "Guchun
 Chen" <Guchun.Chen@amd.com>, Tao Zhou <Tao.Zhou1@amd.com>, Candice Li
 <Candice.Li@amd.com>, Gang Long <Gang.Long@amd.com>
Subject: [PATCH 0/4] add SDMA ras error reporting support
Date: Thu, 9 Jan 2020 00:17:17 +0800
Message-ID: <20200108161721.7727-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(376002)(39860400002)(346002)(428003)(199004)(189003)(5660300002)(1076003)(81166006)(81156014)(6666004)(356004)(86362001)(2906002)(4326008)(36756003)(8676002)(8936002)(6636002)(316002)(478600001)(70206006)(110136005)(426003)(336012)(2616005)(7696005)(186003)(70586007)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR12MB2738; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fc64809-ed68-4d69-285a-08d79456469e
X-MS-TrafficTypeDiagnostic: BN7PR12MB2738:
X-Microsoft-Antispam-PRVS: <BN7PR12MB273802483AF823771F37A660FC3E0@BN7PR12MB2738.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 02760F0D1C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pwhgJEflPeuHSZ7xvSLsDH0Zq/WOLlvgPVK2dMtHhdwdqUrksq/+SOVxN2rNAAsQag4pWqWnl6fMt6VaBwR41N7Zc9bH9N6qy71Y59ynWbbBkq19/AU0uZjdjTFkInx+bYaat7BkPr+w50Xq68QVfuQ0CFNRkXLHDamk+LY1wN2GY6NJ4SEXGt75Pr6LZCOZzzSh5NoAiskBGDNv8/B0876t8gCbDu7I1xtZj8SI5+jg8SqJkJiYoc454CqgGN0jvFXExcpe764IXXB5e1sfwYtaPkpt2wCpp3Kyms11+eSij54E/EWKVU68NWXvuf0Oo0zV9P033TiEdPywcrgMi8F39a8+ZhDcNXZyyCpuJPDz8KvO4HjlGAZCg1MCHh1cSgIfwYCsBA5KJtKQKboH6NFBfg/GK5SY/u1u47vSNT02KfN1Pg8h5aRKpbAqOnQ1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2020 16:17:36.8214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc64809-ed68-4d69-285a-08d79456469e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2738
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Currently, sdma edc counters are grouped in gfx edc counter
registers array (sec_ded_counter_registers), which results
to several issues including:
1). count sdma ras error into gfx ip blocks when querying gfx
error counter (i.e. through sysfs gfx_error_count node).
2). kernel crash (access NULL pointer) when querying gfx error
counter on vega20. there is only 2 sdma instances while the
gfx edc counter register array unifed arcturus and vega20 cases.
then driver will force to read sdma2 ~ 7 edc counter registers
even the ip base address is not initlaized.
3). unnecessary/wrong grbm switch even reading sdma edc counter.

To fix above issue, the series will separate sdma ras query
functions from gfx one. check the sdam_edc_counters and report
back error count and the error type as well. 

Hawking Zhang (4):
  drm/amdgpu: add query_ras_error_count function for sdma v4
  drm/amdgpu: support error reporting for sdma ip block
  drm/amdgpu: add ras_late_init and ras_fini for sdma v4
  drm/amdgpu: read sdma edc counter to clear the counters

 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  |   7 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |   9 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  11 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 176 ++++++++++++++++++++++-
 4 files changed, 191 insertions(+), 12 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

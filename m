Return-Path: <SRS0=DbcS=A4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E274C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2634B20737
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R58TCMZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2634B20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9AE56EE0E;
	Fri, 17 Jul 2020 17:38:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B8A76EE0E
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2020 17:38:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q93zn2LZHa756+w/S2rrhgmHuFygFmjANF8l4ZCR7Fph1UJVgqTFZG57sxgOZuBkZ+xAU0Z2CCQTQq/xI0Euwmn2iTKzclacSjLKdHb/rlilcSiVxEwosU/HxPEkUftb3UAoE7RlZuWrC0IlqRHqRqHZFmr9ndhJLB3LfdlY/WHjvCmnXiKSoOUVIUFeSDB3tWlWjgFg35UE4Cwk3fXC6zu6qo6gZzPcn7WxeAXXGazTsI6kDqPNWfFjbsEZWGjQqIUoVFTPUl489rvnxZaQBV5keKT8H8J6Uu93fDaIdXbDFj9E3RMSJahH2w1vYl1rkwY2atupk+ibmxULc/NuMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwxWq2o4+HQX+VQUpMDSImB/maVU3D0G+/g1yfnTNyA=;
 b=OlOxeP2y7ikG+WaGQlSAbDZxzPnMdWl+RYajjOzTRJ3f4lwyfdyvrsPfwNzZiIld+lrsmJX/GjYl+KHdiOrQ5vsQ19BqtJjD/mSfl6wvcKkLWZRit/0LAsBQtZhbv9dNj167LPssr7p0zdCIizqbv9ZtZP44hvsa1oKF/9IPN+NPd/uy8W56f2Cr3jhcgiVoDI9lvDPY2fdMV33xjDPQJA+MhdF4I1GZx32fDlgXwH1liL83At/0CqF9kuLGNgNpmEfD9LCd0DVZ6344cy9y1NbpbVEIIa8UvtIvvJeQeV3XSEpxOk8lEr3uOfIlx3TZ5NAqX7AqoNdIcMqG+lxwhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwxWq2o4+HQX+VQUpMDSImB/maVU3D0G+/g1yfnTNyA=;
 b=R58TCMZtq4UE6kRHHjyuAPSKKablTaQyTGnlqpMyzUPpACafTl8yyvZL3F5dmrlwnafNGgs3hPkM5icXj6X3P9WA/k6kqz1tS+tTRiH79mxFCHsrbM6v9QWYhKfZRlviUB5PynrfR0QwEQKhih1/GOrJFEsdPfU1Zmlesuhpbqc=
Received: from MWHPR12CA0059.namprd12.prod.outlook.com (2603:10b6:300:103::21)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 17 Jul
 2020 17:38:15 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::c2) by MWHPR12CA0059.outlook.office365.com
 (2603:10b6:300:103::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend
 Transport; Fri, 17 Jul 2020 17:38:15 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3195.18 via Frontend Transport; Fri, 17 Jul 2020 17:38:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:14 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:14 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 17 Jul 2020 12:38:13 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/12] DC Patches July 20, 2020
Date: Fri, 17 Jul 2020 13:38:01 -0400
Message-ID: <20200717173813.11674-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(46966005)(82740400003)(70586007)(1076003)(47076004)(36756003)(8936002)(70206006)(44832011)(4326008)(6666004)(2616005)(316002)(2906002)(478600001)(82310400002)(426003)(336012)(5660300002)(6916009)(86362001)(8676002)(83380400001)(54906003)(81166007)(26005)(186003)(356005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0a93a11-612e-41e7-ac2b-08d82a782f75
X-MS-TrafficTypeDiagnostic: MN2PR12MB4208:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4208BBD9A3800354D67478D4FB7C0@MN2PR12MB4208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C/jRmFxPgpC0ZUt563pzL/H/dsDw0irvX6iqQj/42bIRVvdC2vvLVLR68CFesv3efIxj7twLoNDnW2NfmyoYY/LWnBXabCgUWsCnNoO8cq7eZwGwREQ0e7rSMCQl7QDSWoS2IaSYpt9WoVKkfh9bz8X3+hznwtkxmLYKl8dfyOV9KGtn8SGVxff+HlLb9PG5HsDDFNIGhW/CUECkWgLxdNxLmZ/Vcd+Jeg3g/DAdMLJkR8fI4m/+HuH2BIWVQZnsBvUR3jJGFKhjCRjuHCHP+bUFKSCyyZg+xJb1d5mDThcmJ8URAiYvozeELWVDnwbix0wHrdMqxha2m1hL8GRVvjijbWB7eoFg0pxMZVGfDtVNToTPEXB3h5QwboefY33j74qv0NI7VleSWGG1dEhTFA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 17:38:15.1999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a93a11-612e-41e7-ac2b-08d82a782f75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:
 
* Fixed compilation issue under allconfig;
* Enhancements in DSC, ABM, etc.;
* Implemented VSIF V3.

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.25

Aric Cyr (2):
  drm/amd/display: remove unhelpful 5ms delay
  drm/amd/display: 3.2.95

Aurabindo Pillai (3):
  drm/amd/display: Make new dc interface for adding dsc resource
  drm/amd/display: Call dsc related functions indirectly via dc
    interface
  drm/amd/display: Add additional config guards for DCN

Eryk Brol (1):
  drm/amd/display: Add DSC parameters logging to debugfs

Igor Kravchenko (1):
  drm/amd/display: interface to obtain minimum plane size caps

Naveed Ashfaq (1):
  drm/amd/display: Improve compatibility by re-ordering info-packets

Reza Amini (1):
  drm/amd/display: Implement AMD VSIF V3

Roman Li (1):
  drm/amd/display: Decouple ABM init from dmcu

Wenjing Liu (1):
  drm/amd/display: rename dsc extended caps as dsc branch decoder caps

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  21 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 516 +++++++++++++++++-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |   8 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  30 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   7 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  10 +
 .../amd/display/dc/dce110/dce110_resource.c   |   8 +-
 .../amd/display/dc/dce112/dce112_resource.c   |   4 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c  |   5 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   5 +-
 .../display/dc/dcn20/dcn20_stream_encoder.c   |   8 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   5 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  10 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h   |   5 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../amd/display/modules/freesync/freesync.c   |  41 ++
 20 files changed, 668 insertions(+), 34 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

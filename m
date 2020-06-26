Return-Path: <SRS0=Inwe=AH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7AEC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 16:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 030EF206BE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 16:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HMH4dkZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030EF206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F2E16ECD4;
	Fri, 26 Jun 2020 16:19:54 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770083.outbound.protection.outlook.com [40.107.77.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10FA66E125
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2020 16:19:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIoh5YnGx1dO3p/OQ6Kc3pJ8Rj6toNK7Wbw1cYnMdKSDzW2kjBlr8BSscCUBt377BMsfZ4BosdLT+I1wyKH0TqYIyZPLzRKqBvpDbOdhrroJbbT7KBsbLya2jv4vItBUEzCOdHQQRH+VkuogqKiC0iwOcHrr866lwjZiyi2ZD0wpFWBJAiNMxlfayhmh+G5hbERnsANQZ8Ha86Lxvu95ePOjxag4e4dLawCha4L9j30UgXg3s3OoqzIrLRFHjz8n2PVNaSL5QuYE7YkxVd4vq63bl3Pyc6a/azEWjrl0E168PHAAWN0GyLzDEjcqXAKyI1BOG8jkC1lA+D9wMQjt4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcUPP7B6Gd/95BLalGiMyWbLAk3JhhuOvLCAYSEbt/o=;
 b=UcgkcwUONCDN+UjNdMJMGsKRcGl20Hxn2PVvYC4Y6Ntv68cRkq/GuhsErlhkiWtuIN1OMO5x48pkmRU/nvp+zdzWm1/UztcQ4i29fAqadty2vf5HFP8eqP8O0cE/tIuFIPaOX86U+Wn4qK2+6ENZ8PCDbbnY8XnGe4sU2sjBNiceXeAViYPC65WBDg7dnDkuodxhP3UB1XnakJamLmbJM2CUQpF30lTAT+AOmtGdUhATw7AOsOopPIRL8qJ9O1r43Od/FL83Mr5V8zwMHZhV1XUYxEvtYdGp6tJ+M2375dmV8hI1z0B+36DekWlBdA0nl29lkUFSVFq4pGpBUBK5rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcUPP7B6Gd/95BLalGiMyWbLAk3JhhuOvLCAYSEbt/o=;
 b=HMH4dkZfk6FqY2VzKoly16+ggHTs2ObeMy3WsdTp143nlill6Ws+GKl8gBfYI9Ij7aFBz9bRG5IGkaLVK57tCxK01yOVV86ZcimimzcBrBpo/i2LykbA5yEERuWwrBKoaTD8knLcsGSp2Ta8AoK8df2089r4UWqPLwswAbCZRkk=
Received: from MWHPR15CA0047.namprd15.prod.outlook.com (2603:10b6:300:ad::33)
 by CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Fri, 26 Jun
 2020 16:19:48 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::78) by MWHPR15CA0047.outlook.office365.com
 (2603:10b6:300:ad::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Fri, 26 Jun 2020 16:19:47 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 16:19:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 26 Jun
 2020 11:19:45 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 26 Jun
 2020 11:19:45 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 26 Jun 2020 11:19:44 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/11] DC Patches June 29, 2020
Date: Fri, 26 Jun 2020 12:18:36 -0400
Message-ID: <20200626161847.16000-1-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966005)(8936002)(82310400002)(44832011)(1076003)(316002)(86362001)(8676002)(82740400003)(6916009)(47076004)(356005)(4326008)(426003)(81166007)(336012)(54906003)(36756003)(5660300002)(83380400001)(2906002)(6666004)(186003)(2616005)(478600001)(70586007)(70206006)(26005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f831981-30f1-41b9-718f-08d819ecbecb
X-MS-TrafficTypeDiagnostic: CH2PR12MB4072:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4072B7EE6917779238695BB8E5930@CH2PR12MB4072.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DQzDGrdc9U6zHzIGXmvmAk2obEaq9tNFFOXi6LSELBt0AtidaAJx9aieMKvjUkqc9CevnoNpyAxIwUIAGDa9G6eHZjTTGFwtmZ1J2fEo8cXaEZ9IAZjsto5a9vvVI9U+pjhU0KtGhFg6fiAhSuQKaxcWfK1pL9PyKrFy/npOXJWPa+5ewUjfSxQcF5nbuglG4rlUXdSX1OZJeatqjChmB2oZJaMnMv8P7dfZWfz+NvPYp0CWHVttmsOPVJg5aCmNrtW4kRbHGb/0qrzU7mR5VljmSBupeeOzyIzt/pFKw21CotuFSBa0txE/gzSbJm+5qkYJfQNVTXkdi/6/ChHgcjFOxFh2YdbaowySGoIlpFt2HvX9UEmE4faEcvPrp/QzXfoEg33TkQ6hSabqzxFgQA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 16:19:47.5286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f831981-30f1-41b9-718f-08d819ecbecb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072
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
Cc: eryk.brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

* Fixes in Freesync, DCN20, and others;
* Enhancements in DC;
* Improvements in PSR, link processing, and others.

-----------------

Anthony Koo (3):
  drm/amd/display: [FW Promotion] Release 1.0.20
  drm/amd/display: [FW Promotion] Release 1.0.21
  drm/amd/display: [FW Promotion] Release 1.0.22

Aric Cyr (1):
  drm/amd/display: 3.2.92

Dmytro Laktyushkin (1):
  drm/amd/display: Enable 4 to 1 mpc combine for max detile use

Jaehyun Chung (1):
  drm/amd/display: Fix incorrect rounding for 10Hz refresh range

Jing Zhou (1):
  drm/amd/display: Add register key and status for edid

Joshua Aberback (1):
  drm/amd/display: Preserve gpu memory allocation for life of dc

Wyatt Wood (1):
  drm/amd/display: Initialize psr debug flags to 0

Yongqiang Sun (1):
  drm/amd/display: Handle SMU msg response

jinlong zhang (1):
  drm/amd/display: check dpcd read status of DP_DOWNSTREAM_PORT_0

 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   3 -
 .../dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c  |  39 ++++++-
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   |  40 ++++++-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |  21 ++--
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 105 +++++++++---------
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  24 ++--
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   9 +-
 .../amd/display/modules/freesync/freesync.c   |  35 ++----
 .../amd/display/modules/inc/mod_freesync.h    |   7 +-
 13 files changed, 179 insertions(+), 111 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62445C636C8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 01:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F0166128B
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 01:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0166128B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4525E6E8E1;
	Fri, 16 Jul 2021 01:34:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E65676E8DB
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 01:34:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGdzAhn2pcVOQnZ+4BxHvjAU5KY8j/WQKy3gOBMxg+n3qOHpHv1/Vx3O9Clmd6YYvZDhkRC//cA5FgCf8KIV+55yuwqpPiCCIKIwUsLr6rmm0+xIH+k76c0dwCvBMpUxhpP2L4FRzGTUk1dxOFGqImjkzBYhCNXEn8MKl0cHIxjvVj3efN+wQPBFk3P9IbUdHfbtsvI/YjT6V8tWZ2eqfY7XzuRBqEWmehaKZBHpWOx8/bGE2Agggphi1/nnZZmYfsZATPyhSJUTvL4iki70xqC6umTIr/Y00SN2KU3WJPFgUDKRFtFMdP+vnzsXp8kVP9WZXeyvy/VL11JcohzDRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+U1zSBTX7ENjDYSyrjo8B5M3ArkALt9f+0DU7kJzC0=;
 b=V2ppXvEDkkBYop/J3UOBV0DjMuot0Zyaag3HTArHxGajmQSdYeXiF9sU2gCSo9jp1pGB5VhGDx6KzVpSktQ3xbb3U16D7liGdJBl4Jv9TAgy7gbJEFPtrIH7SlLLtck5odbWZUbzEz2RkDk0HJmKECV66On2kes/eWdkH58bFo4u7WnjBz55JYLAo2wJitC12fsK8WvecDcWX7Ac7SYIzsN6MR4XtU8QmWBYRKqdV29v5S/JzszXict/lIxrbJTV1ItmY1EIFn9O1G3Fbw+LzpJC85Fo4aHnF89Vak9EaoECjgMEqsPgdHlHPeAO016Vmn7TtrRTEjLSyFUXjMnulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+U1zSBTX7ENjDYSyrjo8B5M3ArkALt9f+0DU7kJzC0=;
 b=o7HL1DyTn6hlkkAfu1QolTP7yjp9qeOZPkY9dT+k1rI8p9hzrqHLjRfxrhvsKMau1ClYQAX100AmeZi9J9lESCL7thoDVD9R1ZWFfrS8LkgLlx/nt64zRDMpdRN/XP4SBeavZjOHW4zYO8EnMmVYm890yRhZCV7H8sfj108IbBs=
Received: from DM6PR07CA0069.namprd07.prod.outlook.com (2603:10b6:5:74::46) by
 CH2PR12MB4165.namprd12.prod.outlook.com (2603:10b6:610:a4::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.23; Fri, 16 Jul 2021 01:34:39 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::db) by DM6PR07CA0069.outlook.office365.com
 (2603:10b6:5:74::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Fri, 16 Jul 2021 01:34:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 01:34:38 +0000
Received: from ozeng-develop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 15 Jul
 2021 20:34:37 -0500
From: Oak Zeng <Oak.Zeng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/5] MISC fixes
Date: Thu, 15 Jul 2021 20:34:28 -0500
Message-ID: <1626399273-21347-1-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 208098c0-d6e3-41e6-4de9-08d947f9e076
X-MS-TrafficTypeDiagnostic: CH2PR12MB4165:
X-Microsoft-Antispam-PRVS: <CH2PR12MB41657A57BC3FE5AE2279805680119@CH2PR12MB4165.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2mRaowSj8RcWjfRMWCMm4s4Knpto0+sEb5NKBEZSFRtkUBquEO/XBqcG289xTqkaxc13reUxh0yel2gba0lPjRRvTkVvFIva9XGOA5V9436NHGxe6wX7+1U6nW2BKSZ4GjpYvuFi9lknZlmpEsDYcWwtAenQg6F7IPpb3vZfQsys8cuADGcUA7a4OwDt9Pjdc/IAP3STSCpi4VlBnNFQvUmwzsYf6S4IDLRaPV1I13zcUth8xOhKEQsPNFg/8ue9fFSu8F227bqe9MMCt652pRGyif4BEGHn1Tuh4yuuE1Kjp/tQdTuAm8F5wjVLYchld+iXjqFkysJI9iHasj8vjCUyLOoEQKGr5+t2ks+Tz7eqKELXsro70BKdszklcLVvIludkUvapKNTO/ZS6z8LmEGrX/Pc/WWugPzA+EY4HTbm6CxNkQHvqO9rsM13mjKHZAHmPzXbH/5RQ05z/X8X1mIkGxIsxPjypnTUmRnctMCyvISSWepMlSOeupflwLo6HtgG/smcKg3HQ4g+rXTH5dbEJ7THpAtoG84D7kmyXvbMcNW5jcqOmnA8a88mhzMXTrUxPAsfeV7tfSetpaLgKFP70hGA4TI4vW38y1KUtrBxOckD9GYu+7kveikJ2agxUCtZoaba6kpr2C3r1QGrMi+IOPxI/K9sxfKujFxWm4mB3lcE589pa53B+NFTmfwTrepi6TbWj7udyG+Ij13+rSMdl0Ta/hCRL/nTqHTbvwk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(36840700001)(46966006)(82740400003)(4326008)(81166007)(86362001)(2616005)(356005)(47076005)(8936002)(82310400003)(478600001)(6916009)(186003)(83380400001)(7696005)(16526019)(4744005)(6666004)(36860700001)(36756003)(2906002)(5660300002)(426003)(8676002)(26005)(70206006)(336012)(70586007)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 01:34:38.6854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 208098c0-d6e3-41e6-4de9-08d947f9e076
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165
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
Cc: feifei.xu@amd.com, Felix.Kuehling@amd.com, leo.liu@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Oak Zeng (5):
  drm/amdgpu: Fix a printing message
  drm/amdgpu: Change a few function names
  drm/amdkfd: Renaming dqm->packets to dqm->dpm
  drm/amdkfd: Set priv_queue to NULL after it is freed
  drm/amdkfd: Fix a concurrency issue during kfd recovery

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            | 16 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |  8 +----
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 36 +++++++++++++---------
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c    |  4 +++
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |  2 +-
 10 files changed, 40 insertions(+), 36 deletions(-)

-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

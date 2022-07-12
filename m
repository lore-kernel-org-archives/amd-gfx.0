Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F70C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 05:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D84D810FB7E;
	Tue, 12 Jul 2022 05:39:51 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 430CE10FB7E
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 05:39:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTVTPYaYt1RiHWfEZGxueScggc4kRoYhOgYoC7chk6GjaOnWY62RMOb06MEcBQfBXQ0f7dZqvDA34BAHvHPzUl1Uu6Rd9IyZOy0ksLFXDPTqEUGS7qgfGUxRJj8Ezbg06DTQtGbNVlgNzieB7xdBLEW9T3FPH7Lg7lxi2JS6olemWcogg06UpabHFVfkt8UCb5b3a9Ik6RtDPvohFHftibqVV5mhLDtKE9WZWB6YnXRajTcPEOhWLHKDv7DFD5kmhtEO8vExxKXmVRaJWmvAtS7IztPZThzIGj3xIHH2PHyM4Srcj7y10TuC1X6Vu8oW7fNUXdArl42zYUMDtMrE0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ky6Dc76iYhyqAAoD5ecWkTcUJEUTOTJBeWqcEMopjBs=;
 b=S7vhdbTaBVwpKVQIQ2xeddNelZbY9VmZQ7CBNAJKxWH4eo4LPhTYiazL1wY2W5loWDuxcuFNxGglAn9oRHJNFwCMpsj9LVmoh8P4Vyl4pBqTdIsNq6m1Wq4JjLsRjRBE2GCoefSHwIOu9tOlJNo0VXkvPxjiDZ73YAv5j/I4AQokwDXVZvE5RbQ6wVSYU5i87PHjxBhqQ8aocS5wccj/+91o28ti6R9COs0rqSGUdPMEk8q/FeN0godEYYJ1a324WiS/3tQJpbk0zEQ55uruWhNfrGYerfRvz9ATm45Rf2eZwWtC4Of+pUoDe2rUh658NeYlciOdtHjD1PO0QE3VFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ky6Dc76iYhyqAAoD5ecWkTcUJEUTOTJBeWqcEMopjBs=;
 b=j/YI4yc8taH5O4VdU8P5Q3tDY+tn3U0IraqWI6DA1P0puKYgV/lfP5ZygvdEuLatvGSoSrKIoKu92uzmPg855qO4ofL4flIH9++twdCf8VAeYyhrKsNqz7121ERykI+skadyGwJwf4GgyDQlBgIvkQEptzczE/774yy9QDGMv7Q=
Received: from MW2PR16CA0032.namprd16.prod.outlook.com (2603:10b6:907::45) by
 DM6PR12MB2617.namprd12.prod.outlook.com (2603:10b6:5:4a::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16; Tue, 12 Jul 2022 05:39:48 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::dd) by MW2PR16CA0032.outlook.office365.com
 (2603:10b6:907::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Tue, 12 Jul 2022 05:39:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 05:39:47 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 00:39:46 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [RFC PATCH 0/1] Protecting BO list corruption
Date: Tue, 12 Jul 2022 01:39:23 -0400
Message-ID: <20220712053924.91960-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.36.1.74.g277cf0bc36
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a00e2cd-dc68-4f0c-3a2d-08da63c8eedf
X-MS-TrafficTypeDiagnostic: DM6PR12MB2617:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25az/jIQ3KTEPxxIsAO/lvaQwgVg3DHIsl6BrBBUbpJrwsVdcUnMDSNhMKrcK2+LnTaTY9HJTNJ4vNQ5VWDEjxij/k3p8BZMdszFYGeLvRsvJYQd0U8mnZ4VE60kjJCxe6TTZNmnRBBVju7cyQ3X6qMspgadX+tzKYMQVZ9iqMF7WPBCrBbWEXurf+rgrIXN+srfxOpKK18JJPMLJO/Tuzbn5u49+4Aq/E03+Tuv2zfZh5l7/HFrdBqkIjL5xrEaVE8C8b5JA58FLB5kj3pmu4Cj9azMmoPFupFeIhvbCarPYtkQ1Rk6MsstaCDvecCRqW31Ho4n1It1JXxmXcCQqOZwdmOgUW78Tko3jsBvThIjqdn/4ykRxCXgpBWgsXeE/DrKt3Q9ZjfZUGZuNa/53aGpP29ReAa7S+iK27wxu5OfxgGaWJKCFr5b7uZ6R93in+6pORmto7Sj/nB/XyPhX0D9ELwGNrprc4KnA2vdxbTIS13PEmhGvpfZA4yGdegrWuD83krYoaHlhuL1VSMSrMQIvH5wYNoMHnRpCA2RSa93QU6O3fWleoBLi3iA28VpJpgboGJRLT5f3x9BE+X1YdcQ1cw/8IhiEMVw0reVyNpaD9N2WQCvtkGDRRoKW9haJp4eHVfzTdYYYbypBxR+EEaQ1UymeJCMXSmDMaeHrutECf9xqtYohBKtT4yI9pL3o0nN8cMN9YK14c/ZXAvAJyTDvBJWN9z5tSgdf55rOqxWc5zRO3/ZxOALD2Ynh34SQQA0Cw/nC7QMsN7qOjfW9ScNq1Cm+IbbesXnY8R7tIo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(39860400002)(376002)(40470700004)(36840700001)(46966006)(426003)(336012)(356005)(36860700001)(7696005)(186003)(16526019)(70206006)(966005)(6916009)(82740400003)(86362001)(81166007)(36756003)(47076005)(40480700001)(83380400001)(54906003)(82310400005)(40460700003)(2616005)(8936002)(70586007)(44832011)(41300700001)(1076003)(8676002)(478600001)(6666004)(4326008)(66574015)(26005)(316002)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 05:39:47.6843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a00e2cd-dc68-4f0c-3a2d-08da63c8eedf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2617
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Andrey
 Grodzovsky <Andrey.Grodzovsky@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Vitaly Prosyak <Vitaly.Prosyak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After removing the context lock by patch e68efb27647f21 ("drm/amdgpu:
remove ctx->lock"), we see BO list corruption as documented in the bug of
the link below. While reverting removal of the context lock does fix the
issue, a more comprehensive approach was suggested, which this patch
implements. I'm currently running with this kernel and it works fine,
however running the IGT's amd_cs_nop test, I see a hang in the 4th
sub-test, "sync-gfx0". Previously I've seen it get stuck in the 6th
sub-test, "fork-gfx0".

The hang is generally as follows:

[<0>] ttm_eu_reserve_buffers+0xe7/0x2c0 [ttm]
[<0>] amdgpu_gem_va_ioctl+0x31c/0x540 [amdgpu]
[<0>] drm_ioctl_kernel+0x8c/0x120 [drm]
[<0>] drm_ioctl+0x220/0x3e0 [drm]
[<0>] amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
[<0>] __x64_sys_ioctl+0x82/0xb0
[<0>] do_syscall_64+0x3b/0x90
[<0>] entry_SYSCALL_64_after_hwframe+0x44/0xae

Generally, something like ttm_eu_reserve_buffers() --> ttm_bo_reserve() -->
... --> dma_resv_lock() --> ww_mutex_lock().

However, while normally using the system, I don't observe such hangs--only
when running the IGT amd_cs_nop test.

Luben Tuikov (1):
  drm/amdgpu: Protect the amdgpu_bo_list list with a mutex

 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 31 +++++++++++++++++++--
 3 files changed, 35 insertions(+), 3 deletions(-)

Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Vitaly Prosyak <Vitaly.Prosyak@amd.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2048
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

base-commit: ab7e60938be74e21c723223e7eb96cac7b441e5e
-- 
2.36.1.74.g277cf0bc36


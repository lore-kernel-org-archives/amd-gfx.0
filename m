Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157A9C07E95
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 15:37:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3831613F9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 15:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3831613F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 846F66E9B4;
	Fri, 16 Jul 2021 15:36:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CDF66E9B4
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 15:36:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzruNb50/PXzo1844fB9Y2zS9cYfNAlGxaSUClutBUr3QLBZhho4oAUaqAWSyR+aq4mibq1XT4zp0JxTwHMuTNEBObYXopkJv0DRkhRTRB6UeCoBMZWhQ0+mib2biQfS7wnzYDfzGIry7j+s5gEaZg5iEPsaKbRv67Owtx2T50dTPNwvk91z7NGpml2QIkNPzag/0Fpqz7FDCj4epZFf7O3O0vgd3y2EUMurNaFOVpKboyXkReg85aUqikip8s67mDFzkS4ze5/RfX+Lw8pWQnMBHImgjg6Bum5D6kKoC1eFcs1xRy8F6KcZWixpwaHwLuRSTR03g4QK0JgrvO7miw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUy+iV8L8tbtJnYzt0yy14OPA83/FU6jZ9qRpnDrFSE=;
 b=UvK4916P8h7TVU6TbWjxSDJLyyEYn8VN21OfE31jUhZ678vBNY1FFg4tjVq4b3wtMNVXvyWh0q+QbilQijTyFELINHsTQGv2KSo4JgeK+w4X3CcKSWSgNSnOa4uxIprerZfIPjtrysNw9BC6FZaj0P0nNkDoo/Opi5hpGONVrV7dU0Pms4xd1F7/kKVm7QNSrMp1KKOc4HkuEOMjR/INvf5xhfbK4g3sO9DaxvPfq/t6qooJbwzrRnIyrAzS2jFqJ71MORhnkTW7AOPSWNFfSJUQuQUSLc5wTS0JVUBOg+aOfyBUS2JnFxQHqKxbOyK5HhSVttaWRE+MEiQi+Gbv+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUy+iV8L8tbtJnYzt0yy14OPA83/FU6jZ9qRpnDrFSE=;
 b=uQUYkQ8KNS8a6ZL2MuNQH3+y/3tymalLS8ZXvLsoaJev5gXlr8DYS1gPvBkaeXTdaoREzW7jiCgarWBIYkpJKf4YL60HryG+LpggGCCZDjzl2w2/6aCMjNapbxdSGeBxPuOkfV6MZNh+czhRyEb6UWspJ5H4yOa5/CU+rhEoGmA=
Received: from BN9PR03CA0284.namprd03.prod.outlook.com (2603:10b6:408:f5::19)
 by BN6PR12MB1155.namprd12.prod.outlook.com (2603:10b6:404:1b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Fri, 16 Jul
 2021 15:36:57 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::28) by BN9PR03CA0284.outlook.office365.com
 (2603:10b6:408:f5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 15:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 15:36:57 +0000
Received: from ozeng-develop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Jul
 2021 10:36:56 -0500
From: Oak Zeng <Oak.Zeng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/5] MISC fixes
Date: Fri, 16 Jul 2021 10:36:45 -0500
Message-ID: <1626449810-18044-1-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 264e405a-9ce6-46d7-1093-08d9486f8be9
X-MS-TrafficTypeDiagnostic: BN6PR12MB1155:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1155AF06C8A70E46A7A177E080119@BN6PR12MB1155.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lzn0dqK/s5J8FJIg6CMXxPyGe/DTwMB9Kt30wQcWnPg0weY+nTRj7dTztERUiVRt4kWqHejhKeOeerwu63BaiFshItM2z1Pduhr+uwzpyVsJTMH9TyCWbpXaOIPnxwTq2DYA26aCo6lJ/TmrqndlpkJeWOgGp5stsDzh3Ruelj1gt5PI9BbaYQYYFojgxwgrmI7hULmlm7JrWIJ1jw7W8JG+ZVZV6cKkZ+ROw0EMPpWpIaFhzeWQvjWQkxnPQFtqH5LjoKklbM3iItruvOsYKQ66iQmT0RR7KD7QY6Rs5veCu7HbNrZ9WIss9IC1OIesrz/5sEsl3C+j1UDBm5mLNadWu+Bs7i+F3LNKSWPlUkKl9HEz17quJ/aW9cddzyYwXFBNVei5N0oHUSrC+1HrqBXK4sHx1f+wNild6/WPbI4YgiX+emz7szHL/hHKzg1KkCRbUxRvdyz+1Lfr3/sfYL5o/zdIN/OSG2tf9PzJ6e5tiSh20+TcNEfwyICsoM7IC3fHHJRyVPzoYFvLSS+JFS2Z0aUVmYKYeif0TOHBlfVQkcfq9+O0nCad62hH+agDIXpodSy4YEfXHOv+5x7Wtcu36Xe0AqCmUPdmISMKG3Iq4RI0coMiqEsrLk/dyZOoZN0Kk4PJJQ+eefURFRwug3wlRXGvaQJMgCWXOqUn31RVJR43OeP7kQtwdTKaKfs+H+sgd6ySlPvbmmKHoItXnUpAFIcVgWFHXpoxcluD5W4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(46966006)(36840700001)(7696005)(336012)(82310400003)(5660300002)(82740400003)(16526019)(6916009)(47076005)(4744005)(2906002)(316002)(70586007)(356005)(426003)(70206006)(36756003)(478600001)(83380400001)(81166007)(86362001)(2616005)(8676002)(8936002)(36860700001)(54906003)(26005)(4326008)(186003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 15:36:57.4983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 264e405a-9ce6-46d7-1093-08d9486f8be9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1155
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
  drm/amdkfd: Renaming dqm->packets to dqm->packet_mgr
  drm/amdkfd: Set priv_queue to NULL after it is freed
  drm/amdkfd: Fix a concurrency issue during kfd recovery

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            | 16 ++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |  8 +----
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 38 +++++++++++++---------
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c    |  4 +++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |  2 +-
 11 files changed, 42 insertions(+), 38 deletions(-)

-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

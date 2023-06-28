Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C74CEB64DC
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jun 2023 21:24:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9316A10E395;
	Wed, 28 Jun 2023 21:24:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::612])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F25BC10E0F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jun 2023 21:24:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkE8YECMZprak9KptjIiLH6Z6o0FQswl40PsnxW3aIlSyAsASuzF76t5SvI9fmHwHDQ4kKFtgDjcx8wgDcfayLhBE7606FB/YjvK3PfZtH9fuoIU8UUvpWer9azn7RgFm7EkR469VwjQKrsGwmoXrehwrWVaRz2hVB0uLXsJ8RSDXl82x62RcU3uL8VCyoFSaI68AYkYD2UyZaY24bYTWR88BgJ3m1a9AQZbJLoO6RIqzv1gi55UvLrkmTvPkxwaw8J3utKuySe+fNbJbgQRvp9wSek/XijgElmSfzTdR0ezkCZv/PjM42WCpT5B5gm8N+sqfQVFk+4Mc/+q4RyrHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OR/zWlwcb+u6G90kIoeGsdn4Nr9XgSLr9/G4cBh0ik4=;
 b=YMQOHDEKk05jTR/q5NylnW482psmBxOiQTDlTM+ryskbA4Sm5CbQ6u0B4hvRj0CyjMw/CKh1tPO/lRBcN0GKlN0MGwW+uYr+p+ttXmS1eWHO5dZh6zCJop+zMtXSNwn7uM9cPT+AW6nDOQNYlfQJ4cNW8kUDCMCCz9pfK3M07okkZRGCmCEVzy5WajIm7mUJ2gzuOysYJsQax5PXspkJKAoljKRvYMD6dFlkpT1nTOQGdCkG7o+WJVl//RDm4aCiRKMdb6lByxfFw7nirlNdN+DoVVLr3UnMwCuJhnm10uxEoW7l1dh7kyg2l+TPQJ5EQB6J/cUqm4JkesW/GAtNwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OR/zWlwcb+u6G90kIoeGsdn4Nr9XgSLr9/G4cBh0ik4=;
 b=QkxZKdBI+mPFr9uSUwb2SafRwLwy/QDN7FTV9P46hZzGuCcOzHP5DPuhhdgQASzoYgBau2hqwHGmbwYPBsrPL5NM91hC3nLRUYDJ+eYvcuGKu+RsOG7lql6+q+kLTnYCk62xgDBrDhFKJA/Pfd3wYojt5dhgMj3D3CSF2NV9QJ0=
Received: from DM6PR06CA0037.namprd06.prod.outlook.com (2603:10b6:5:54::14) by
 BN9PR12MB5324.namprd12.prod.outlook.com (2603:10b6:408:105::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 21:23:58 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::f1) by DM6PR06CA0037.outlook.office365.com
 (2603:10b6:5:54::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.20 via Frontend
 Transport; Wed, 28 Jun 2023 21:23:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Wed, 28 Jun 2023 21:23:58 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 16:23:57 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/5] Upstream debugger feature for GFX v9.4.3
Date: Wed, 28 Jun 2023 17:23:18 -0400
Message-ID: <20230628212323.248650-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|BN9PR12MB5324:EE_
X-MS-Office365-Filtering-Correlation-Id: 669b7dbb-9974-4ae3-1687-08db781dfc53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RiJggtSsKs5KmL9UtfJXQeQOKbftAgqKcwN6kIF2D0BMOlF6k3yzJevIlTrhAJBIDrQyc5BtiKaKVcMPWq1InBpc7eI1oOG3PkUbFy6a4mVNPU1gAVLT2YpaVkjHcwClzBttp8vVCEtKbBzigQ9kvVP0P0Mol/KMo2YuVAp8Y4GUBQP+r7vWi5oKF300/OjKWvGT4ZQdWIAMCisw32K28o/NRdK+xF1cBxjblXx1btX8axA/06ST8jPbUBB8LSbOPfqM7ZJSWwK99xPfig2pkeoiBmzV81URKN3u8Q5aQ9PLcKmGRz2pTRJ5dJd9D2nbFXiI2H6s36EZVZdUTMzWxkfCCvAukRhKo2lFZOnXStkzR9IQj8NrqM+vrOuvJKg2XQKHw5hqiBW8jig8NKCCnEW2eHuDD6m/kLkbP27Eh8P7wsX+I120NkI+3YYYewy3jfpvEWhnBozChuG/iSFojx0kX3SgjmZP1L5nEWzyPTU5FOYDOIRBGUer8qUQ6cB7F2pOpM8KVEV7TZYfkyP4eCkan81GJMSFPCODrE6KHxsFwAf+tKtLPQ7MezpJ8DI3VBc5Feb3JPkonqJo602Ls8AX8Zsx+sj5RCvcGULTHZs2WB5NsUqVtodAJ8znWrG8LbLgdT7OC6qwGJz3JdwrMVSu5hd58AYmUa0w3tY7oUqYFYD1DcdzPCrHs4MVGdrC9XMz99rr6ZZcoH/jjv2Rvv9b5DwxwebJtSOF3ogZQqaf+KjPUpkNPkIpu2J1zuv23MainoWTEr4lw+uAQ+1d7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(46966006)(40470700004)(36840700001)(1076003)(5660300002)(4326008)(6916009)(316002)(70586007)(478600001)(70206006)(36756003)(8676002)(8936002)(40460700003)(54906003)(86362001)(36860700001)(40480700001)(41300700001)(6666004)(7696005)(16526019)(82310400005)(2906002)(356005)(426003)(26005)(47076005)(82740400003)(336012)(186003)(2616005)(81166007)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 21:23:58.4964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 669b7dbb-9974-4ae3-1687-08db781dfc53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5324
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Jonathan.Kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Eric Huang (1):
  drm/amdkfd: add xcc instance for debugger APIs

Jonathan Kim (4):
  drm/amdgpu: add debugger support for GC v9.4.3
  drm/amdkfd: add multi-process debugging support for GC v9.4.3
  drm/amdkfd: restore debugger additional info for gfx v9_4_3
  drm/amdkfd: enable watch points globally for gfx943

 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |  13 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h  |  30 ++++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 150 +++++++++++++++++-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |   6 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |   6 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |   6 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |   6 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |   6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |  18 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     |  10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h     |   3 +
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |   6 +-
 13 files changed, 237 insertions(+), 28 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h

-- 
2.34.1


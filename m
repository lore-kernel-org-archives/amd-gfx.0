Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C87BC77B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 12:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E7D810E092;
	Thu, 18 May 2023 12:21:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4C9F10E092
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 12:21:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yti2MiT8d0xouSGQ7ifwAtcRDsSmkSWfMlPdPs0AWtDUkJnhh0MuRpEZPigDavW5DzKFdjindzbB4h//5lFAwfh5Y2qXdxH4dAgFlUuxwozy4yya3Dp5mAk8SwlYSGLNF8o+zUy4Gk7iO2bxvKja2jvT8ZUR/6/SOWUIE5VqFhnFcRNn7zRzRNkB64f+bXqXs4Ms918SCB2Ttn5L9ReCirsC7+dLtXKeA/2wW7kc7gumnTpxjy83/2z0vSnx5eak7sZGcOErB+a7wr8I5AJEMhD35dgYCwBG3kSy2t8zniUN/E85pab/mDK/kENRtP+Nic6nNdoHF03/cN0pM7rRlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXBBVnAnI7BhBRmLvlgQlRgn4OV82JqGrDb6evXcuD8=;
 b=icEp2b9i8d0E2DwbbwGaZJF/O/6mH8s+h9NbUBcDQIksiqSye9HKu/Ufi+hDbbgLCvrY7e9p3s0LqmXHq+cPAOU+Yd2UDnQZ7HQ8Bb9e8XiZ/1crkcU6ZYjx0rpkCwX9kaV757baxtxdXhLVuU+tEaRuQ5ae+243+44CyiNQt49XXsl5y0OpsgT9m2KcoBW4RSb02I68xOGgfEYngbI97S+c2iGE3nEExgIUSfT3iIaNW7Um+96xKiXADTwdZmSIlrdoo2R3W2XebrZgzT4aiSaz8DmdHXKJ8h+eUt125s3SF5bWPBLO8+HDQ8XTW286m6A7zeUgZV3ppqLLv3KG/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXBBVnAnI7BhBRmLvlgQlRgn4OV82JqGrDb6evXcuD8=;
 b=4mVC6r81fhqrWivCwnHjhmB36/dk+BxRa8J0+ZukLON8wO7p5eeYw+XOack+IZfRDWMuaWCuTb+nJRJITFCPh3mHlBHfzGvNwvS1ib+Vw1IPFgbFLhnVlavHsKtQ8A9xmyrsMFUNq13919CMGLINd7jVigwG9DTAAV65o0Bce5Q=
Received: from MW4P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::15)
 by BY1PR12MB8446.namprd12.prod.outlook.com (2603:10b6:a03:52d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 12:21:40 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::67) by MW4P222CA0010.outlook.office365.com
 (2603:10b6:303:114::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 12:21:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 12:21:40 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 07:21:38 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 0/6] introduce the smu_v13_0_6 and gfx_v9_4_3 ip block
Date: Thu, 18 May 2023 20:20:53 +0800
Message-ID: <20230518122059.28815-1-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT058:EE_|BY1PR12MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: 4942d789-cbf5-4a5a-77ff-08db579a6ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 526EMd/dnQX0CkTugt6R4d52034HmhpFARBxaRO0L6/J6XWC7nzspH5cGk/OAp9eIhFxsOGoujtBQCOXQrxLUZi/pwo+mmKC5YbdmO6fF0RXq6Y7k2w2juCF4Xfw/zSHwzU9b49mjoZ5Lmj1IyUKkPjOswHJ0pti1FR+HigNjYDzONOOzg/ppJmnyvXBuUrQ+YL6WZp0yV/HKzTBEg6WhtFQ6FwVChkKhgwEjzjxw34sEWYYIfFI3wtS5SLwB6P7BW53yX/l4s1FSKWr7BYQLtPxaIWVsvFry21qnXjvvwc+a36S5BY1M4J4WLLj61i85Vzi23YvzytRVhj4zJylfF6SEjSc5AtpUmVq4UDjfU7TaAaSctqSlHMrX78xle/2u+/tkuMA1jYsk+zTkaW+SSSUQpYZX7DvlK0OHmHLo3dQGYzBNtw7gH9QPdaa8seoyGLUhF/UVEmrZLUcjAxqxQqlGJJHfEt+JZ0WChViZ8HLLPtBHnUPZbcGSOPFUGamBR0s2RAMJRTJMRTKEnqpPgB1E3hjMzfNLdP0onoW2oapJAk5KEXZ60DC95bvLV59acBDX4qE+o2HdwgwGDt/ScvHAa8V3KkIw0hKqRleoh872jOwPiOQG8n5VKysNMg4LL/HPNy59QjKxUTXpLQX9Oyt1iZN2vhxBsQd8LkT4pH90LwK49lM1UXv6l/NR7OLmgMFdewqNeRpVih5fTtJGB5aIlbziD8iXJS2h5Oayn/33/ZqmRSdxfbHJCfrQ8Ugj0Ky89vjPzN76b75Xahipw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(46966006)(36840700001)(40470700004)(26005)(40460700003)(1076003)(36756003)(36860700001)(47076005)(426003)(40480700001)(336012)(83380400001)(2616005)(86362001)(81166007)(82310400005)(82740400003)(356005)(16526019)(186003)(44832011)(478600001)(2906002)(4744005)(8676002)(8936002)(316002)(41300700001)(5660300002)(6916009)(70586007)(70206006)(7696005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 12:21:40.0008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4942d789-cbf5-4a5a-77ff-08db579a6ef8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8446
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Besides that, this series also covers fixes for multi-xcc

Lijo Lazar (1):
  drm/amdgpu: Use single copy per SDMA instance type (v2)

Shiwu Zhang (5):
  drm/amdgpu: add the smu_v13_0_6 and gfx_v9_4_3 ip block
  drm/amdgpu: bypass bios dependent operations
  drm/amdgpu: skip pcie bar resizing for gfx_v9_4_3
  drm/amdgpu: fix the memory override in kiq ring struct
  drm/amdgpu: complement the 4, 6 and 8 XCC cases

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 66 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |  7 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  3 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 61 ++++++++++-------
 7 files changed, 99 insertions(+), 54 deletions(-)

-- 
2.17.1


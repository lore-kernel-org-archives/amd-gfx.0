Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3B2C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 16:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46CAD10E35C;
	Wed,  9 Feb 2022 16:30:28 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2047.outbound.protection.outlook.com [40.107.100.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EB0F10E35C
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 16:30:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hw20cApxMWRPrbwQ2EpuDGrk6TaX8K3747AtM8tz/KXvCVf7qiQ39Ff0Rl7kg0fToqGqFYXvhFA1bCbgWQyrE2sib+/HtuPkbaqAmheGLhKFnpkJ6ViPkT4xxNK50/ReUOHBnrKWCkrPxmrqAd+qkl8ZbGPAOcB3QZeVigKzRg6qxGNE7c5uvo3VHfnfByMBDqWoeqFgrLrXl0TKHBmpvPvaVXK+A+vosFAOBoi1Xzgvr5AfOyVIYVwHBcneZnpMRV7vfjDUgwuGBsEcErN247PYAi3Fn1QcWXvsVqFIOCv3uuea+ulRz1fK0JQU9+aNsseak+7RpwTQGcFHnzDJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r60yqoXCfPdwRnqgYxfkgN3a+oM+Iv2zGuphTCMVfYU=;
 b=XZwnSrZzFIj9yYxpt//2BGosuXCtHtW14ZyX2lmz4L7zT4bdlO4/8t245rQV0eUEsi7JA3FdKPhQJl2ejUhXxL+Ywa0LmQw7mx6G0pap8SifIbiCBs5EGtSOp+vloTZWiCgO86YqgY5UYoapXuvaiqgHV/BVbrB0b16dmxc77uTQJkzFRp/DU4Lw86A2c8dq0yqLo9iwdbgHBjXefCxAT3EzmVVQIShB5wxv1EnTI7EbpPxoJcBAMB24q3d24+UHlErVKT/0bFSkSF6VgQnlkPqH0DDxIvN7QyN+AV1XOCsRacH3Hbe80kSEk2LjtP1cByV8M1A8KdiIZq6Xcb31DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r60yqoXCfPdwRnqgYxfkgN3a+oM+Iv2zGuphTCMVfYU=;
 b=nTczf5olIuhkP/dZAg5bUd/DrTewqFnyvcuT2rqzjR8MpOznG0huk6uIZxiZG+zhSuVy1svk+s8EwRpkybw47RQyNFoIHXHbi+yjJG6/Hj0cBeADZPQFtRWws8IhZ3dmBQ4lwZiEStnKIIOT5OCI/l64twzisrYUZQSyArZMWwc=
Received: from MW4PR04CA0111.namprd04.prod.outlook.com (2603:10b6:303:83::26)
 by DM6PR12MB2986.namprd12.prod.outlook.com (2603:10b6:5:39::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Wed, 9 Feb
 2022 16:30:24 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::3c) by MW4PR04CA0111.outlook.office365.com
 (2603:10b6:303:83::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Wed, 9 Feb 2022 16:30:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Wed, 9 Feb 2022 16:30:24 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 9 Feb
 2022 10:30:22 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/1] drm/amdgpu: Show IP discovery in sysfs
Date: Wed, 9 Feb 2022 11:30:06 -0500
Message-ID: <20220209163007.10522-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.35.0.3.gb23dac905b
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 965ed117-7ba7-4742-0df6-08d9ebe97952
X-MS-TrafficTypeDiagnostic: DM6PR12MB2986:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2986E416AD2F12C9B5ED0B2A992E9@DM6PR12MB2986.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:216;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iy0AHNW0cjKhmsoiDgsmB6FAeed1oFvtWwppzvUsF4gSCsuKFpvBE6SVVWx8w1acQB7LjOaAgcg1I4e9Hf/nE8TLyyB/21yAL4LV8R/23vPvike7qPSIsROCIZcHUkuZNSyFTKInnX0NhscsjuX8udCgvKAqqG+k5pPO2fQZvHo510j4lhVBmY/b6npiO8wjZUNjtVoirW0qELP8RWJr+X7TGQM72+pbcIcfJI6mCcb7lYQJ4wJrZgRg0aY5chOT0IfPHb1xWMrj9tRvVXsmZxr2AwXEUNiCFl4fC3foz348QESpPMEeCt6aG95kAryCQZ50jXHbCnamJ6v2Qqk4aDgXQ+ajiZS+gaAcx7KNbcZvOktvgnSJOWRKeBOOdx4GLaV4JT8Of6FHKGiGAAx/GXv7JtSwoDO/gdWeg39UNXU6t0LQ4K/dyjVO8+5+yOoW0XhEXXOKa2KrWwnjYNY5vOZOeF2eXiKisk5M351WDTgGV18r7X20OEzTH6jrBa0iNH8WuhUadhK2bNLLy0Y8RKzqwvgmeZdPPuFc9TfPs/ZynSA1kFl2U33BivuJ/VmSmpZ9TmegvYRJF53pOQ5YvYZS/K5kn1g0WaCMXGjxyvYg1v4BDj6MiMxAUjsZ+ABgSV8pBdq6pYaCjhlTRIJ7jDLNpyZ4C14ZeHZabgzNPi9X182QcI93z0zttxkHVzmJCOjKPdfi34utH0uecNwTEA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(86362001)(5660300002)(508600001)(81166007)(44832011)(6666004)(7696005)(82310400004)(2906002)(6916009)(1076003)(70206006)(36860700001)(40460700003)(16526019)(70586007)(4326008)(83380400001)(26005)(54906003)(186003)(336012)(2616005)(426003)(356005)(8936002)(8676002)(316002)(47076005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 16:30:24.3245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 965ed117-7ba7-4742-0df6-08d9ebe97952
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2986
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>, Tom StDenis <tom.stdenis@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Show IP discovery in sysfs. See the commit message for the layout
format.

For instance, on a Sienna Cichlid, the layout looks like this:

$tree /sys/class/drm/card0/device/ip_discovery/
/sys/class/drm/card0/device/ip_discovery/
└── die
    └── 0
        ├── 1
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 108
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 11
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 12
        │   ├── 0
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   └── 1
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 128
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 150
        │   ├── 0
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 1
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 2
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 3
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 4
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 5
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 6
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   └── 7
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 170
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 200
        │   ├── 0
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   └── 1
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 255
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 271
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 3
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 34
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 35
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 36
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 37
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 4
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 40
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 41
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 42
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 43
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 46
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 47
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 49
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 5
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 6
        │   ├── 0
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 1
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 2
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 3
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 4
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 5
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 6
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 7
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 8
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   └── 9
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 66
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 68
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 69
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 70
        │   └── 0
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── 80
        │   ├── 0
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 1
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 2
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   ├── 3
        │   │   ├── base_addr
        │   │   ├── hw_id
        │   │   ├── major
        │   │   ├── minor
        │   │   ├── num_base_addresses
        │   │   ├── num_instance
        │   │   └── revision
        │   └── 4
        │       ├── base_addr
        │       ├── hw_id
        │       ├── major
        │       ├── minor
        │       ├── num_base_addresses
        │       ├── num_instance
        │       └── revision
        ├── ATHUB -> 35
        ├── CLKA -> 6
        ├── CLKB -> 47
        ├── DBGU_NBIO -> 36
        ├── DF -> 46
        ├── DFX -> 37
        ├── DFX_DAP -> 49
        ├── DMU -> 271
        ├── FUSE -> 5
        ├── GC -> 11
        ├── HDP -> 41
        ├── MMHUB -> 34
        ├── MP0 -> 255
        ├── MP1 -> 1
        ├── NBIF -> 108
        ├── num_ips
        ├── OSSSYS -> 40
        ├── PCIE -> 70
        ├── PCS -> 80
        ├── SDMA0 -> 42
        ├── SDMA1 -> 43
        ├── SDMA2 -> 68
        ├── SDMA3 -> 69
        ├── SMUIO -> 4
        ├── SYSTEMHUB -> 128
        ├── THM -> 3
        ├── UMC -> 150
        ├── USB -> 170
        ├── UVD -> 12
        ├── WAFLC -> 66
        └── XGMI -> 200

114 directories, 365 files
$_

"num_ips" shows the total number of IPs, as this count exists by the
same name in the binary data.

Typycal contents of IP attributes is,

$head /sys/class/drm/card0/device/ip_discovery/die/0/GC/0/*
==> /sys/class/drm/card0/device/ip_discovery/die/0/GC/0/base_addr <==
0x00001260
0x0000A000
0x0001C000
0x02402C00

==> /sys/class/drm/card0/device/ip_discovery/die/0/GC/0/hw_id <==
11

==> /sys/class/drm/card0/device/ip_discovery/die/0/GC/0/major <==
10

==> /sys/class/drm/card0/device/ip_discovery/die/0/GC/0/minor <==
3

==> /sys/class/drm/card0/device/ip_discovery/die/0/GC/0/num_base_addresses <==
4

==> /sys/class/drm/card0/device/ip_discovery/die/0/GC/0/num_instance <==
0

==> /sys/class/drm/card0/device/ip_discovery/die/0/GC/0/revision <==
0
$_

Luben Tuikov (1):
  drm/amdgpu: Show IP discovery in sysfs

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Tom StDenis <tom.stdenis@amd.com>

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 423 +++++++++++++++++-
 2 files changed, 426 insertions(+), 1 deletion(-)

base-commit: 7ef7c0d6812708177acf554384892605bf87c077
-- 
2.35.0.3.gb23dac905b


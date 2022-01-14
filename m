Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A76DC43217
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 20:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FA3610E206;
	Fri, 14 Jan 2022 20:33:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 407BD10E206
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 20:33:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f5PYlaK+g/Qj6+YP3ocKlIm85PL1ymhlSDgYaPs238JCjdt7+tBepxxwhJXHCzGxJLiLjfVtUVNd5ofJdIAnKmTT3Ov1i+Ko4bmlzGhnK78XFabaR09mreem9sn+1Ul0wh0KKcgQDbfGgH8jR9T6PCSP3qz7EcY5QqiintacXokPPXURz0JYgOeDnOWkCSD3QZ2uckknIZfUltSLT+R32XBr9QVLU+v2VWktHF+5Fra2PfcSVWT9tbS8fGOs0x1ZTV9yddDrG7cABvRSzw+cdFu6BwWKwt7mpILXHOuTIHUuVofuS1BG9otbZ10Vq3L1zXWmmSsAY5UhdspvK6G7gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHVpI4xq0SSz+uq0p48ZkbPU97DLbaGArAS4t1cr8ss=;
 b=cfQb5Swd60WpadkXRuVkTqIrwoMdhF4vum65UkXyD6QN83MxoySJj7fS47lNfIhPkjV+YP2rsWuvqmvJNFK6TC/9XBbo5NVGDhDT3KW9X86JzVp54mK4yHxhmCqqCkqLHP5vlQPNCAjA0vwGLucfuepg0dvldNz0ROq6HlL5K2Wg76UQrkPm08gOWZdtCVvb3oREDv/1BKGxOqYXWUFmrkkg5u5B5otDaunAHhlXQLs9aSPBPdQRiPMYMSuGOwjbuk+e1QBtMF9H/JyKNbPT5OIbiH77YTWQvTRx/vJPa0QKO0D+r684Ib6o/hdqTdv5QJilzu1nn6yxK7ooqFdI0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHVpI4xq0SSz+uq0p48ZkbPU97DLbaGArAS4t1cr8ss=;
 b=mkksdF0D1jQYnAZHqMZ6eNMaxfFh/D6yfNxNfRVn80mP/SXGavnOW77OFoG4SHySupzz9kCLA2w9oblUdlMwxKuXAWWRGZ1+S4dUhhgUKqB1acFC6Dbpi1A8Njlsw1XvFs5L/wna6aZUhB9I96uZRNY7TVOVzrbaml0dchG/2PQ=
Received: from BN9PR03CA0177.namprd03.prod.outlook.com (2603:10b6:408:f4::32)
 by DM6PR12MB4563.namprd12.prod.outlook.com (2603:10b6:5:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 20:33:13 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::8c) by BN9PR03CA0177.outlook.office365.com
 (2603:10b6:408:f4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9 via Frontend
 Transport; Fri, 14 Jan 2022 20:33:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 20:33:13 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 14 Jan
 2022 14:33:12 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/5] HMM profiler interface
Date: Fri, 14 Jan 2022 15:32:51 -0500
Message-ID: <20220114203256.19821-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ef5ba45-accc-4986-2042-08d9d79d161f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4563:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB45635E7C3A4F0D7084EB82FAE6549@DM6PR12MB4563.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1TNAN3j17ofBSNhQElKtev5Gb74F+WjeKMvO1q8HAyezBWaq+ayYU7ekuudDFikO9kVoOBoafWxW9BEs2ib7WoPSz6MDbX4IFqoOL505jHZmUgJ10/HmPyQtB/q2bkUfZyjY615YOR1eWytU+MHqq07uS/4MrBMwIRo5d5YsFClotQ+MrFX3KVLiAOctClX1NtG2E/VFJA9zw+LNjmD0mkp5ZqSYGigF9OSPZ8DvpL55zAsOjjGYxU+ujAO7viWumxr/Yi73NQHzlLtHQEr9LbjCvd4sXPi2lcqWY/5kxe7sjSZXkySyIu7E/ZSfkHtN87NdrEr6saMgW3ypxxuN2/j8wKTl97TbVHsaVSoD23+FaPSdWvHbZ7dxTYyTVSAk1jXqE3ikm5PqOal2O7ojrMpx2JZCGGt4Zb+RZw9u+59e/8ViwEChSZUhxSt80TxszWAy+WQ6zIUOKlpFguvLdcvjFS9Csr4omlMjbhLl4YuGHmegoCzZfGgVC2zi7urxywnEWMvAl+qk+WVZsbv0W3AetSGejbQGPpgpbs9rCsxFZv/OiuMglvE+SBPNS7WDs1sh4fn9XryXwy38JNvJa+S4u2qi9Rvg0j4zujE+OiKkACYH4UVk8+HnX0j1SK+N2jbBDYref4Au+IShiVhe3/9PyXxLrfaA3CwPXqZzJ0GLbIpwpgn4o7M/uW6Djxy6/tgiieLJGo0js6FA2bvp5UQ+hXJ96SHtgbKUnknh+nnMBNSNYjLuGH8kFUCiCWaYvmkAQolIs8eDU6pNOjTHpe7rN9N/iWhftTDXzV20nU8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(8676002)(336012)(2616005)(5660300002)(6666004)(86362001)(316002)(36860700001)(40460700001)(54906003)(186003)(1076003)(426003)(16526019)(8936002)(4326008)(26005)(70586007)(36756003)(356005)(47076005)(7696005)(6916009)(83380400001)(2906002)(82310400004)(81166007)(70206006)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 20:33:13.0299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef5ba45-accc-4986-2042-08d9d79d161f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4563
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The ROCm profiler would expose the data from KFD profiling APIs to 
application developers to tune the applications based on how the address
range attributes affect the behavior and performance.

Per process event log use the existing SMI (system management interface) 
event API. Each event log is one line of text, starting with event id, 
and then name=value pairs for the event specific information.

Philip Yang (5):
  drm/amdkfd: svm range restore work deadlock when process exit
  drm/amdkfd: correct SMI event read size
  drm/amdkfd: enable per process SMI event
  drm/amdkfd: add page fault SMI event
  drm/amdkfd: add migration SMI event

 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    | 67 +++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.h    |  5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c    |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 98 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  8 ++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c        | 42 +++++----
 include/uapi/linux/kfd_ioctl.h              | 27 ++++++
 7 files changed, 198 insertions(+), 50 deletions(-)

-- 
2.17.1


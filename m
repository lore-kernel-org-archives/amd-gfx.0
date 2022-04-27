Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2144C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 15:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 717F210F525;
	Wed, 27 Apr 2022 15:16:54 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2051.outbound.protection.outlook.com [40.107.96.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E9CE10F524
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 15:16:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mK2nXhYneCy9pcHi5mVTvLY8wWXfz7Bah0jC70dqtJsNIVBHX+gMdlYTcJnmJ9oiAYgxjyjxtAFlwDj714fP1winOQuUaJre8t3SvRX6q/1bMhoZkwrO0ogYnNKGd+RG9vMZHm1gB8eRbAivzObfcQBQBzY2SFYPMM12KcMxch1qiXHwa8DeAyqgCMFjY+u8P3vmBrRKIxuNJXUTUXA5/uFTe4mzu/w32yYqUMK3tP41BMN2mHUQoApZPNl7BofpStCuv5k4RJTUwbAa+KKK1uvpQrxJ10PyL9iLRah2cXInuNNBN7eUSyHsUR5GpfmIfhba1mKVSzv3/anW7qyCyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJH3+7UFGYo5UUVeNTsW0p4SLaGVJo3+AT8rbFsMQ4w=;
 b=M/LjYsYwYUjL+6hwdQ5VySuYxlFl5xVjA11sjhgYOC386BzytncDWvs+cYEveHIWzsngDquoBv5mFHJ8Syg7wdSPWaFpW3o1Ywz8MWt9a7/L4xG/sP3gvH4LMfzgcviCRsXvSu4qkegaFwm0fUw0eISkEoGecutFCoThlPjoDa/xDzaiApVvEG7EKgB6trWmdMLh0Q+amx1K3p4i6xb5IoQU5vQqtynIRwAVdhDVlwepMQGS4wIT5FljpNHU/j4VMNbI+S2t1bnm7bEpDZegW3HpMiaESSvK6mSkmpeOsdbIJPq74wjL+nGAe+hk/h2sngKMNK2X2Xd7dyFFqbvcHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJH3+7UFGYo5UUVeNTsW0p4SLaGVJo3+AT8rbFsMQ4w=;
 b=4mmW2FvlWJvniLBHEHaL1ftuzHaXtTExmTUjWydP79PZiY6hVoHqs6ijBHSw6Yt2UKOxnT5VpErWgKjRHWPNx46F7D82RIq5yImrA8NvzS2F0UNrKkWWJhbck76TAYukPqpdZSRWNbV0FW335CNJn5Bb5RPCqYtkv9UlIBvjyPk=
Received: from MW4PR04CA0325.namprd04.prod.outlook.com (2603:10b6:303:82::30)
 by BL0PR12MB5011.namprd12.prod.outlook.com (2603:10b6:208:1c9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 27 Apr
 2022 15:16:51 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::b2) by MW4PR04CA0325.outlook.office365.com
 (2603:10b6:303:82::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Wed, 27 Apr 2022 15:16:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 15:16:50 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 10:16:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 0/3] Add NBIO 4.3 Support
Date: Wed, 27 Apr 2022 11:16:34 -0400
Message-ID: <20220427151636.3104955-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f44346f-1059-4c7d-a27d-08da2860f446
X-MS-TrafficTypeDiagnostic: BL0PR12MB5011:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB5011D67B70C52902333E99E6F7FA9@BL0PR12MB5011.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wg+IuXgjdidxqx8zSkoXd4ps80TUcCbJypT8Qw9Xq6KXYIWSybXWpnqBXnlSd3PKVUKZ67X5iHwar0mOLRBPLcthfM0GZG9zPD9ivTGBYS5ab90g2icfrI8q+Jv2lCikD6J5JprTJHbTz9a0QPSPssnOQ2Dt3lj5SZ7C7TZQ4uGSZQBswAjhLckQdsLCiSEqTKAu5zskDyRGIcuPXRyQ593J/wE1c+2sLz0ShAIHEkzhaVacugBGSWLbodY5HRD2xCTsKKYcYQWvj7pNiWC9mQG2Xe4L2d4KRHnVMHcPNYSPsYs7o2DNLpb5XZi7hhvHI/6eFdyzH59Ii5nRBCUaYP18dF8VDxFvjC+ZMpIo8B6avlTYRPSmHGjzDeJfoqxXd62dzJHXqYY6jytxLf1Y2OVezIuFbQB1GwyGDcm5cEKZy1oMR+biC8tfpujCCgfgXnFYjVEB1A3psTv5Rt85OpLpno0Y6kYFZj5NDMw5YfseE5RPqmwZ633bhB+XV+2lOBhzZK4RzOCcHDKCBSMf6KQD1pHwjsColXf6qCJ9fIyBc/DpcoDp83O9jzcvaAoOOZUbGvrNeMQ1fAv9Sp26hRK0z/QN18fLdzcnOF7XvZmE3tI/wKYau7SNH/VnxLc82/vIUkXCSwCWG3pt/Ci5xDOHGrxblO558LxRxE4b+oFl58LSqQ7d5NIT7pSNpHb+u6x5BYMp8b24TUw+kZSr4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(336012)(83380400001)(426003)(40460700003)(47076005)(1076003)(356005)(16526019)(186003)(5660300002)(4326008)(8936002)(36756003)(8676002)(2906002)(82310400005)(7696005)(6666004)(2616005)(26005)(70586007)(70206006)(36860700001)(81166007)(86362001)(6916009)(316002)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 15:16:50.4869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f44346f-1059-4c7d-a27d-08da2860f446
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5011
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch set add support for New Bus IO
(NBIO) version 4.3.  This block handles the
device interactions with the PCIe bus on
GPUs.  The first patch is register headers so
I did not send it out due to size.

Hawking Zhang (1):
  drm/amdgpu: add nbio v4_3_0 ip headers v6

Likun Gao (1):
  drm/amdgpu/discovery: add NBIO 4.3 Support

Stanley.Yang (1):
  drm/amdgpu: add nbio v4_3_0 ip block v2

 drivers/gpu/drm/amd/amdgpu/Makefile           |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |     5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h      |     1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c        |   368 +
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h        |    32 +
 .../include/asic_reg/nbio/nbio_4_3_0_offset.h | 17379 ++++
 .../asic_reg/nbio/nbio_4_3_0_sh_mask.h        | 82049 ++++++++++++++++
 7 files changed, 99836 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_4_3_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_4_3_0_sh_mask.h

-- 
2.35.1


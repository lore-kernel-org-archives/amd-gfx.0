Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB96DECAAD8
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 18:41:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D535210E38A;
	Tue, 30 Aug 2022 18:40:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4969C8903B
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 18:40:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eB6eh2lgl6KN1gOchvy+TI2dT+uN7V47CR2jknKSkFv2d88zdwKG9WSOYshJdav2qXvOxY9XUI5krNltqj5TdThl+wTny+MreB0/q8bgIZNmmKFureU0hYEsL+XgXgnkZYK/subIQJheRo87HVNXWLzfGx8/YOSVQq1/GOkDdiqyDl2i4M/oJ/VshNtYlo74jeTUvb+ybAyPr3BTRDMGft/DmY3rCp3ssHvly6XAfnSx7OJWvFrlu0NDl6mgMFB5cbgCaHOSZHs3e5+WaditAevEw4eY9MSDArDzicFH9iHemGb1I403q+pa2ake2RirVO6ckadDyxuM0c2+vWEJxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jf6OGEmwR58Bdi1OlbgU9713zhJ3OhcKLfIpIembnlc=;
 b=ZixQ7OmB0xJhjhWIYAgHGrOGLQ2g8Raldqfn3JmAySV2wQNrJEeNfjP1fUle2ImFy6zTlzxlGZtB9exyKp7lp8+fSKaCDax82Sc6zBGvAEogzF8wtHRIzYK1pjy5QbU6ZrbtXXEcrhbpx5/2E7L/d3Fla1M8eauIrZ4r+kozdr/xyEoQh0vMJNn6hyIbVvhiY8va6wuqiWQBYEaDzJcfTAULunBBdefzuyNe32WLGFcWHrQtXQ2LuI1y2ABDSRXixgE3YRJiFK3jLATIrmkL9FEdHQAN8ndYGwFIOpMYalab218GRiKMTKgVHgGmkXhqKFNsADofca0hLU4cT2ROLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jf6OGEmwR58Bdi1OlbgU9713zhJ3OhcKLfIpIembnlc=;
 b=z5odRa6Z9w9sCHcCDVdbqdRNPbwGhTgo5v/sssu1QrLHCugQ00NwXggbFgOfX9GPJDIE7a0bP0C/gFBfYyzqUnJUix1q41Pwmbh4zLkTurIUsPPN6KuiTrOjOqRZMK0YxL23tY9C7S6ZxJ4Fckopwe+weUyTOZS4x9GMv9OVqBQ=
Received: from DM6PR02CA0076.namprd02.prod.outlook.com (2603:10b6:5:1f4::17)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 18:40:35 +0000
Received: from DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::50) by DM6PR02CA0076.outlook.office365.com
 (2603:10b6:5:1f4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Tue, 30 Aug 2022 18:40:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT113.mail.protection.outlook.com (10.13.173.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 30 Aug 2022 18:40:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 30 Aug
 2022 13:40:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/19] drm/amdgpu: sriov remove vcn_4_0 and jpeg_4_0
Date: Tue, 30 Aug 2022 14:39:59 -0400
Message-ID: <20220830184012.1825313-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830184012.1825313-1-alexander.deucher@amd.com>
References: <20220830184012.1825313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12523901-39a3-4e50-8603-08da8ab71d89
X-MS-TrafficTypeDiagnostic: CH2PR12MB4120:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y6yw96+vcpXR0q78r+z1JwFhulDYCwpVsVdhbHCyBwwQ08gUgJp7iak4Oo8OMWFSTMd9UQklJEoRMFJmsRAPkuZg6rqnZYXNFM7lnCqWTdkhU6FmN+dAXgi+UEpikwTHFzJT+yFNd9cJ7n6mG/D59vfz5T1CSAWj4wqZsfklpPzVdIA7NQzPM9XWKX0o/x0k6UTlv8KP3ZPKLp+73XevpNUuNOUAcEcTbMimNy0Ib+11qm3T0b68yZWPNyfV8vqrseHSm16uC7OUJdkUyHZyt6oYQGbhCwM4Pl7WZq2y9kYUZtUKE7LwhkoJwr4eQeQPQxZAC6cPMVmz79OhsIx8S7kqwjtIuIF02s0v2bzk18M6JMyr4EM+EjUWipZ7GlvQUweoPTfq7iN/KFjgJ23zlpfoLL118GvrnJNM0C8T/zq7GCD331WfqsY+Lylkzx7tCMSHoXtD6ntKvQZA6mG8iJ0TGIzSxjnOmvIzYNZGaGWaxhmPhSHzYzHi1pwg5nfNEiZHprd8dM3MmydyLf5KnFcdDjb+WRHDE+j+adY0+0Sw9NBD9ylcMGLhZzHA0pfSlWQwgaHLmTuGwuuPwGnuQFs7J22TUQYfrNZ5xWBf6HcJ8EeLdOO94IDeNRX4T5vKy43u88bhu+h4LhXGcKZsbjgkA4RmkvJPyBFtMEkr9QXiuyeVGpSIrqd5nDnWst22A33rnlS5CZswXaExyu2LvH3sIndAma1Qc3EvoxaIpANxxe5lwNO7uWeHBMIMtwtrrKyVQQ5HEpKB347IUxELsmPitJtHqRdRVZVhPAkqlSw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966006)(40470700004)(36840700001)(86362001)(26005)(40480700001)(82310400005)(478600001)(6666004)(70206006)(7696005)(41300700001)(356005)(186003)(16526019)(40460700003)(336012)(81166007)(83380400001)(82740400003)(426003)(2616005)(47076005)(36860700001)(5660300002)(8936002)(54906003)(4326008)(8676002)(2906002)(316002)(36756003)(6916009)(1076003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:40:30.4453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12523901-39a3-4e50-8603-08da8ab71d89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Horace Chen <horace.chen@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Horace Chen <horace.chen@amd.com>

SRIOV needs to initialize mmsch instead of multimedia engines
directly. So currently remove them for SR-IOV until the code and
firmwares are ready.

Signed-off-by: Horace Chen <horace.chen@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 854ca8d4505b..06b2d1830091 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1908,8 +1908,10 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(4, 0, 0):
 		case IP_VERSION(4, 0, 2):
 		case IP_VERSION(4, 0, 4):
-			amdgpu_device_ip_block_add(adev, &vcn_v4_0_ip_block);
-			amdgpu_device_ip_block_add(adev, &jpeg_v4_0_ip_block);
+			if (!amdgpu_sriov_vf(adev)) {
+				amdgpu_device_ip_block_add(adev, &vcn_v4_0_ip_block);
+				amdgpu_device_ip_block_add(adev, &jpeg_v4_0_ip_block);
+			}
 			break;
 		default:
 			dev_err(adev->dev,
-- 
2.37.1


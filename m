Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D253C3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 14:10:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2C6210E9CD;
	Thu, 10 Apr 2025 14:10:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e979FIlM";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67B7410E9CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 14:10:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhjvlVe7keY55fP5iKJ7qOdlfKe4CBOgnSobbmhrzX1qVvpK/M5kth4B5YehnyGAkiBX3xh9FtKzz17Eho0GGlLBVt/IfoQlixX7VAWQIp5a27OoGxHuDW2t4PKvE14Yah+96zeE9ZNdt5GpdEQIQVQhLJs1OsJdTQu6Ax/2YSb3YJ8+cMHX3GT1eQLB+j0z9wZZaCBGLbH+M/+/O7HDFAvLq8XxJhRUDTFbup5MbhEmGqctWipwdEu7OlSLF0Y84iZsmg7h52HBXbNXKRzA0Go86X0Te7ac6u+JCAD0njwnfnK3r3ScGqXeIf9Fuy9KLd0Qv5Jb1iFbLlx81FwZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWd1o6Yxup5ChwJhu2yRrb2CBToF4EeNycAynrqxUHs=;
 b=j//j73phO6o8DGFyKX+ukra0aocwvpxB6s1dwGkbUkFXeO8y9eTq0GX3R6jnxx1mzdEvOnC5K3Ci7U2R1p12NYhktHEA1hwwIEHr71XfIvE6FVswj84ps2HWe66PRw71ADjCEi3Uh80Aq/vk3+YDGNwKdAqOqtByMaxsaTEsVFF2yqyPnVOQcjRUkXFE8CfIOr44OTG6Q2SELW8Ok8m9HsBHhj9e6XFHAxcViPDUMvBiv49BqDXfNsGboavrrUxbRXPHfJ6sJhjQ4B6qF5CmjIK1pgNieXSzSZH1fMnaIgtkMZmscU6pTiRDrxlBJPWj09YPlviODSqRiWplKKDZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWd1o6Yxup5ChwJhu2yRrb2CBToF4EeNycAynrqxUHs=;
 b=e979FIlMvwUJIdtKGBn4Rje3mJddkegtjUwekbWbSQlrXspmjhtLWCN7DBgjgvFTn3pcYGR264l3XZnFxBuKfwLa7N8ZNx1vMw1AmMiKKl9CHLtH6yJOmzup38CbiK+R6W653zEH5S5yIoTrJgKY4ZQzp3sNPRGWVQM1t1976Ho=
Received: from MW4PR04CA0083.namprd04.prod.outlook.com (2603:10b6:303:6b::28)
 by MN2PR12MB4143.namprd12.prod.outlook.com (2603:10b6:208:1d0::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 14:10:31 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::c1) by MW4PR04CA0083.outlook.office365.com
 (2603:10b6:303:6b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Thu,
 10 Apr 2025 14:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 14:10:30 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 10 Apr 2025 09:10:28 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Mario Sopena-Novales <mario.novales@amd.com>
Subject: [PATCH] drm/amdgpu/gfx11: Add Cleaner Shader Support for
 GFX11.5.2/11.5.3 GPUs
Date: Thu, 10 Apr 2025 19:40:14 +0530
Message-ID: <20250410141014.3295627-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|MN2PR12MB4143:EE_
X-MS-Office365-Filtering-Correlation-Id: fe77a41b-d14c-4dae-37d1-08dd78397388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NENrUHNoTUhVUER2T3pQRnluQTJUZURjN3Q0ZnVPazMvTVRrZmYyZURaYytw?=
 =?utf-8?B?eFdENnJtejR5di8zeSswamcvaEp5RlN3aHhYOUFHOU5GNjFaaDJIN0c2R3p6?=
 =?utf-8?B?SmwzbnhaYWZIN2VCVmNqb3pPZjBwUUJZZlBjMlhUclpsUUd5M09MSE0veXFu?=
 =?utf-8?B?MFNtZTc1cVdvRmxpVTgwa0ViNnlkcENhN0d0VEZTOEgxc2tXR2UzZHhWZzd4?=
 =?utf-8?B?SWlFaG5lMmpPdFppUVNyTDVjUEp2aGhvanMxSFNpU21Zb2VKM3FOWUZCQnVx?=
 =?utf-8?B?UlNqd25LVVdUQmc4ZGtMM3Z1MlhCSmZYbS9NL1BPMldsS09Fb3gxRTNITGVN?=
 =?utf-8?B?NU9FeGUvcEdGS0w2SU51ajRlZnFmR09HZ01BQ1YrV1VHMitLT2hJajVDeEZt?=
 =?utf-8?B?S3N0K0JjUTB0dThUVHJXbEV2bzBkVVBNQnRIbDRmczE3MWNmNVVvaWNLelZx?=
 =?utf-8?B?RWc4OFJaUGVCTG1DZW42WEcyRUJUbm9kWnNPYTNGN2xWYytCZ0lyS3pDVy9J?=
 =?utf-8?B?ZkxOQTE0Q0NVYmNwa2ltRGNrdk5rclhvLytvTjhPaGJBaTJMMnI4ZkFJSFhI?=
 =?utf-8?B?Q1dmT1hLUE4rZm5CTTc0T29ZVVhuVVVKTEdsZHY0NlEzRVRqeUlXWksydVZX?=
 =?utf-8?B?cWFzQzNkK1V6NERPRUsycXVNeEw4WTN0bXRPUzZ1MjV1UHhYNHZxeG5YWGx2?=
 =?utf-8?B?THRrbkN4RFZhVHE4eWNRZ2xOOWszbUp6VlNMdm1IYmQwOUMwOWMwMlRGS3Bz?=
 =?utf-8?B?OVNzU0JIVXFac1had1YyMzd5UlJQckZTMnlUNmNtYTFJdjM3eU8xQWtBMnF4?=
 =?utf-8?B?TzZUaE5wbFZVdEVaUTcwRksyZCtaLzFPSXh0Vkt2UXY4ZWZPSmJCV3NJSUVr?=
 =?utf-8?B?OHpjcCt3RWJNVmlqdmZyVEljOEZ0cmNHTHh1d1BuUW96N2xyL2xRL1VBN1Fr?=
 =?utf-8?B?OXg5eXZsL0xyK21xUzJOaW9URkIyWEpkMzg2ZU0wUnhNRzNhQ3NQSUEwTWgw?=
 =?utf-8?B?NzZXb2EvbHBWRDJwaEcrc2UrbCtVNVNnZkcySlpoZ0Y3dW9ubThEaVBsaHh1?=
 =?utf-8?B?N0VYUHE4b0VPZDhTbCtNWXZpWm8vOGZYSERTdEc3aXo3TjhRNVVrbFJ4SGVB?=
 =?utf-8?B?SGJwRG9KazNQNktQTmFVUnZOaWFuVEYyeG1kcHFERzU0TFcyUC9EczB2a1RI?=
 =?utf-8?B?b3FnSUduWTZxWEpka2wySEJNaUtTc2luNFZ5aDJkWkZnZHc1MkN4NTFaRllZ?=
 =?utf-8?B?S2hpSzdlSS8yVTUwejExcnYzQ3pOclU3V1kvbXpvby9EWllsQTFKNndvelRo?=
 =?utf-8?B?amI3S3MzdGVlVUJONjd2cUEyTDBZa05IVnBEUWFXUWw4MzQ0N3Zod254K0RN?=
 =?utf-8?B?ekVaNnFmQUhUMkZOTjN5ZDFmYVRNeHVJWEtZbDdpQnBTMkdHTU4yYTVuZ3I1?=
 =?utf-8?B?UTVXSXE1T2J1eFY4QS80amlRZWVjaEFBY3BVM2tqU01iSnhtNXAwSEt2MXpv?=
 =?utf-8?B?WlAyVE5KeExOYWxoSGlTRFFGVzd5TVAzQWNHZ2craW92T1NpaWZWRVdTcDlH?=
 =?utf-8?B?UGx5WUJYV3REQ0s1QzIreGU1MHdHU0VrK3R6RitrS3ZYUVZHNU9LeEhnV0ho?=
 =?utf-8?B?NjRzZms2VS9JWHRBSURZczlpYnpkL1dJak5NVFJ2VHcwa2dTQXk2ajg5OS92?=
 =?utf-8?B?dHBUazRPbDUvdWp5ZlQxQVcxTU1rQkpLdFdhc0hzNGgvb3dRcnkxRnowR3Ux?=
 =?utf-8?B?N3BRdkpEemh2bkRsOGJydlh1enFDcnhOMEJlTDNvYUMvbytqeEFxTGQyNW9m?=
 =?utf-8?B?dE5UOXh0MzJYbHNlN1NnQWpqTDQvVXEydk5VSlRZd3VLMFZqUFRrRFFhaWFu?=
 =?utf-8?B?dC91T2hVd2hOVXF3dGxKck9uVENnU3FIYktuR2hJVU5sYVc4cjB5SjBxeXow?=
 =?utf-8?B?clVka0lkT3k3WU8zQXZTN2U3ZG9xSU9rdVVYeUpRRGVqMGxPZ250bkpzZ2dW?=
 =?utf-8?Q?mlY/nWA3qpkNKA0TBrM92cJ6uWcD9o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 14:10:30.1848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe77a41b-d14c-4dae-37d1-08dd78397388
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4143
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

Enable the cleaner shader for additional GFX11.5.2/11.5.3 series GPUs to
ensure data isolation among GPU tasks. The cleaner shader is tasked with
clearing the Local Data Store (LDS), Vector General Purpose Registers
(VGPRs), and Scalar General Purpose Registers (SGPRs), which helps avoid
data leakage and guarantees the accuracy of computational results.

This update extends cleaner shader support to GFX11.5.2/11.5.3 GPUs,
previously available for GFX11.0.3. It enhances security by clearing GPU
memory between processes and maintains a consistent GPU state across KGD
and KFD workloads.

Cc: Mario Sopena-Novales <mario.novales@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 91d29f482c3c..06ad10d06ca1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1688,6 +1688,34 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 			}
 		}
 		break;
+	case IP_VERSION(11, 5, 2):
+		adev->gfx.cleaner_shader_ptr = gfx_11_0_3_cleaner_shader_hex;
+		adev->gfx.cleaner_shader_size = sizeof(gfx_11_0_3_cleaner_shader_hex);
+		if (adev->gfx.me_fw_version  >= 12 &&
+		    adev->gfx.pfp_fw_version >= 15 &&
+		    adev->gfx.mec_fw_version >= 15) {
+			adev->gfx.enable_cleaner_shader = true;
+			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
+			if (r) {
+				adev->gfx.enable_cleaner_shader = false;
+				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+			}
+		}
+		break;
+	case IP_VERSION(11, 5, 3):
+		adev->gfx.cleaner_shader_ptr = gfx_11_0_3_cleaner_shader_hex;
+		adev->gfx.cleaner_shader_size = sizeof(gfx_11_0_3_cleaner_shader_hex);
+		if (adev->gfx.me_fw_version  >= 7 &&
+		    adev->gfx.pfp_fw_version >= 8 &&
+		    adev->gfx.mec_fw_version >= 8) {
+			adev->gfx.enable_cleaner_shader = true;
+			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
+			if (r) {
+				adev->gfx.enable_cleaner_shader = false;
+				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+			}
+		}
+		break;
 	default:
 		adev->gfx.enable_cleaner_shader = false;
 		break;
-- 
2.34.1


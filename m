Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3C7D6EC0B
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Nov 2024 13:59:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33D5210E03A;
	Fri, 29 Nov 2024 13:59:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EQv3J6xK";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7509210E03A
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Nov 2024 13:59:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdPCn+LE1c52IGGrVelP+3dosserLcLu1oDaw4XdEtVAMAfAKL2f2X5eo3ufaDc75QJrtt5Cp7xPmVqFxuM3XE2ehUewbRUPW+zSmth8Q4weIdZRsbcAI5NH8XkE/88PreEYLY3F9QuXFj7cTk99Z0hj2ewZiOuHY7HxVB2ixYndliZGc2I2nOLzdMshQH2moCusr+sO+zhznDqV7LpdKfNHnzSh2KdV3FJJAnW8wirXQxBivOY8hqW/73KbvWoygujNS+muOpE6HX2hK3L9t1cRWEZKkAiPNRum4piYQI2SZRvbbDjTmeBzXBQpz8Surejic+aDU+iJf7E0CuM/eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=id7AAIjB/iZeRbCWVo8LpKZqe550kGkMnoVlNNf5myQ=;
 b=G+CP98HWkYHAqOgGJkdYlE2EPits/PMubEvf9+zhaSmX/nftSKRj/EFhNN9VzWsEV4uW8iuN4OUOGMr6HDGqtkDRtC5Jiwpe1iSfAxLb/NtDn+iTUo/5VhGZddwq93ikB68KlrCuGWIf7fhjuaacsLMlaqlMkupGBdRlhgGgD68sRNbeRQqwLCheUqIoiLBDrbX8Xm8XoznE80uTYTVgvRSMOpMERmKCH5JCJA1MKU0XWyWeYrv2UsJ4qP7EqTgm7Si0fkILI9eWfsWmXpkZZ7OKrtEZC0j5nCbkx1s18U4E6ksmy3Sa+OpZ9/uDSJG8JOUIUeif5U9AlzqDHYdtag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=id7AAIjB/iZeRbCWVo8LpKZqe550kGkMnoVlNNf5myQ=;
 b=EQv3J6xKuvu4E5ptU9uErf0TN01uiGZ2wsz1OjJp+tRw0l0qHGkYKTqY0HypSskHeJMUFsJbhIn5YkdOiVAkFTLTdSZotsSetuH8YKOf48oJCOXqgQ9XRLCv2y45aG1d8/kE7wivJ5c21BsLs0zczTYeAPzZ+ag9P65rb7sDAXM=
Received: from MN0P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::26)
 by CY8PR12MB7515.namprd12.prod.outlook.com (2603:10b6:930:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 13:58:52 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::58) by MN0P221CA0002.outlook.office365.com
 (2603:10b6:208:52a::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.14 via Frontend Transport; Fri,
 29 Nov 2024 13:58:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Fri, 29 Nov 2024 13:58:52 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 29 Nov 2024 07:58:50 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Add Descriptions to Process Isolation and
 Cleaner Shader Sysfs Functions
Date: Fri, 29 Nov 2024 19:28:37 +0530
Message-ID: <20241129135837.4070078-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|CY8PR12MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 3240cbda-dbf4-4943-260d-08dd107df52a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGQwOVoyRnAxUDhzYm4yTm82TmlpcXRiaFFBWVhWSnRVQWhXMTlCeVc1L0pG?=
 =?utf-8?B?SHR6R3d6YmgyVnV2SDJMNk5mV09DMC9DUDVkQUE5WERJdUVHR3B1bk1nRGVE?=
 =?utf-8?B?SmRweGtRcmZCa1dwSThWY1pkbkRnMjY3QnpOc2pKakcrWUlWSTB5ejdaWWM0?=
 =?utf-8?B?cVN0SmFhWWRaMkVjRm5UcGZJOWNkajVscmdOSjN3RktBaUlodGlpSmJwYjlw?=
 =?utf-8?B?RVFxUktMV3lIZk5haTZSQnBYN2ZTdzVYcjZhcUs4QStlUW56U01DWHRkS0FG?=
 =?utf-8?B?MWJXQXVSd3JibUJLTTNOQVRFbURHcS8zSEdHREhZRUZmQ29LWTdRVkt3aUds?=
 =?utf-8?B?Y05MNWkrQ3VUcjFFTE40SnhZTHNuU2RWbDV6VkxRMFk1M0R5MXpaUkE5R0hZ?=
 =?utf-8?B?dW1YcHM3RWpRMUdCQk9XWXFVNWdYSFA4L0UyNEJOR3A3K09jNGhuMFhiQjB2?=
 =?utf-8?B?UTVkeFgzTWhBaVN0QTB0WlJUa2hKUkkzQ25rVnhvVU51RDlIY09NL0ZmSGhi?=
 =?utf-8?B?TWVoWUcxazhxdEc2OUNaKzBFdklPZ0NRYi9sN2NzTDl3c1R6NEZNenRTRlcv?=
 =?utf-8?B?Zk93UEVOZzdKMVJoSWRENmMzb240SmI1RzlRdCtNQ09BMHQveW8yd1U1bW54?=
 =?utf-8?B?bjFwUnZieGpnZS9GYTh0UmhLQ1dtNjJENWplNDVPRUNOYjFBem12TnJhenpO?=
 =?utf-8?B?UEJiNmJXNjhtYzlrbzdLQ1VCT01UeHhSUm8zd0RXRXZVT1dWMkFQeHRWNDJy?=
 =?utf-8?B?VjlFcFI1Rk9pYWx5M3JKMkhPQ2pDZGJTYzRLWitJaTRQWSs2U0krOWZSQUhT?=
 =?utf-8?B?dnZpSW8vNkh4TE5iMjZFQXRPT2FoNitqZFBUZnNkTUdpbzlSVDhwbkNLRm55?=
 =?utf-8?B?c243bk1tNjNJTjIwbUZWS1VmQzhMRVQvQU90R0lvVG05NDU2WHd2Smd5UU52?=
 =?utf-8?B?ZGpZN0V3eG9CUVgwTzZJZ0FpbGNoOEhOc0x5YmRvZzVIMzZseENycFZaSE1G?=
 =?utf-8?B?RFlyL1c4eWlqT3lnK01hbDBHV1JRTUFKS2ZZTkJGZUVtTmNDOFRGaVg1Y2Zn?=
 =?utf-8?B?Z0FFU242QVBXUUJ4cVpHTkxPeDRDWkZRekxBakpYSGtTb2F4SU1XYi9zT1Mz?=
 =?utf-8?B?R2xBMDQ3L3V4U3N2QkpNTXRiS2VUVnNITE9pS29qdk9tbW9vb29xWDZON0dL?=
 =?utf-8?B?cThJdGcvV3hNdDRFQzRmS3hpYktLbFQwZ0RNRkFRcFBxZHhOOVlFd3Rqdldi?=
 =?utf-8?B?MnozdFRDZXFxd2tMaW5RbC9xZ0VXTzdRdGVQQ1VtRHU1NDVsWHJtb1ROK2ZC?=
 =?utf-8?B?dEZ3S0RRWTF0ek1kbiswdUlJL0JvRisrUm95MXV6TUpaWXRVMkxnQkZFc28v?=
 =?utf-8?B?S2VvUm5QVXd6a29ncjdoaVk4NFcyY2F1dnRpNmtDR3pwazRmeGVTNDNCMWlr?=
 =?utf-8?B?OWRMTnBjSEoxU3ArRmJPSUM4eW5LRi9mcFNsL2JnbzlnOUdJZFBZK29yOGpU?=
 =?utf-8?B?RCtnQzFFMGhzY1ZsMUs5OHE3Yjl6U010dVZDeGpibEx5MlozMXhoUUtRVWt4?=
 =?utf-8?B?M21iZG9WYXVNL2FlanZBekJwdE9CNldHMTZsbEZHZmFEeTlRaG9lbU5nMXh0?=
 =?utf-8?B?UVl6KzZGdU02aUQyWmhGKzFxL3JCUzN0WWl4dSthcGwvdGpBVWRjV3BBT0pI?=
 =?utf-8?B?UkpHZVFlRCtVNktwelF2N2dBbUQxb1Y0TUlLY2VFTnkyZFhBU2lId2ZJTmpH?=
 =?utf-8?B?WnduWWZGa3lXOWRGWE5oN3dYc0RjVnpQMHRxZWRTbmtGRWhiVzBCRkdzT0Zz?=
 =?utf-8?B?dCtwNDhndEIvVkJQQ2tOSUtIb0oyeldaVldRMEdaMFhmTTdLZEhyY0g5ckc1?=
 =?utf-8?B?ckZ3TTZKNEVpUHlBVExCaWw4SEdYN2NXaFJWMUVHVEJhV2x2elJJdGpIbVlC?=
 =?utf-8?Q?B5+r5z+iszaUFEMWHyOADtooWJNz1vcv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 13:58:52.5990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3240cbda-dbf4-4943-260d-08dd107df52a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7515
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

This update adds explainations to key functions related to process
isolation and cleaner shader execution sysfs interfaces.

- `amdgpu_gfx_set_run_cleaner_shader`: Describes how to run the cleaner
  shader via the sysfs interface in clearing the Local Data Store
(LDS) and General Purpose Registers (GPRs).

- `amdgpu_gfx_get_enforce_isolation`: Describes how to query the current
  settings of the 'enforce_isolation' feature for each GPU partition.

- `amdgpu_gfx_set_enforce_isolation`: Describes how to enable or disable
  process isolation for GPU partitions through the sysfs interface.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 45 +++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index e54f42e3797e..881a633bf0ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1484,6 +1484,24 @@ static int amdgpu_gfx_run_cleaner_shader(struct amdgpu_device *adev, int xcp_id)
 	return 0;
 }
 
+/**
+ * amdgpu_gfx_set_run_cleaner_shader - Execute the AMDGPU GFX Cleaner Shader
+ * @dev: The device structure
+ * @attr: The device attribute structure
+ * @buf: The buffer containing the input data
+ * @count: The size of the input data
+ *
+ * This function allows manual execution of the cleaner shader, which is
+ * used to reset the GPU state between different tasks. Writing '0' to the
+ * 'run_cleaner_shader' sysfs file triggers the cleaner shader execution.
+ * The value written corresponds to the partition index on multi-partition
+ * devices. On single-partition devices, the value should be '0'.
+ *
+ * The cleaner shader clears the Local Data Store (LDS) and General Purpose
+ * Registers (GPRs) to ensure data isolation between GPU workloads.
+ *
+ * Return: The number of bytes written to the sysfs file.
+ */
 static ssize_t amdgpu_gfx_set_run_cleaner_shader(struct device *dev,
 						 struct device_attribute *attr,
 						 const char *buf,
@@ -1532,6 +1550,19 @@ static ssize_t amdgpu_gfx_set_run_cleaner_shader(struct device *dev,
 	return count;
 }
 
+/**
+ * amdgpu_gfx_get_enforce_isolation - Query AMDGPU GFX Enforce Isolation Settings
+ * @dev: The device structure
+ * @attr: The device attribute structure
+ * @buf: The buffer to store the output data
+ *
+ * This function provides the current settings of the 'enforce_isolation'
+ * feature for each GPU partition. Reading from the 'enforce_isolation'
+ * sysfs file returns the isolation settings for all partitions, where '0'
+ * indicates disabled and '1' indicates enabled.
+ *
+ * Return: The number of bytes read from the sysfs file.
+ */
 static ssize_t amdgpu_gfx_get_enforce_isolation(struct device *dev,
 						struct device_attribute *attr,
 						char *buf)
@@ -1555,6 +1586,20 @@ static ssize_t amdgpu_gfx_get_enforce_isolation(struct device *dev,
 	return size;
 }
 
+/**
+ * amdgpu_gfx_set_enforce_isolation - Control AMDGPU GFX Enforce Isolation
+ * @dev: The device structure
+ * @attr: The device attribute structure
+ * @buf: The buffer containing the input data
+ * @count: The size of the input data
+ *
+ * This function allows control over the 'enforce_isolation' feature, which
+ * serializes access to the graphics engine. Writing '1' or '0' to the
+ * 'enforce_isolation' sysfs file enables or disables process isolation for
+ * each partition. The input should specify the setting for all partitions.
+ *
+ * Return: The number of bytes written to the sysfs file.
+ */
 static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
 						struct device_attribute *attr,
 						const char *buf, size_t count)
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6BBC4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Apr 2024 09:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1099410E49A;
	Fri, 19 Apr 2024 09:25:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sojaxgt5";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4135E10E49A
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Apr 2024 09:25:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6xd+bINcLKOvr6+ILPkqFsIl6YTR6/km7SNbCPSmiOEFvyOI7AAnr3Ctug7c+Vw8IaV/UoZK3Z7gc+71fG8G9dm1u3R8tsnmlMViLg+TXFONSa1fgAIh3tEWsEqu9zrcjlhPMnXGnsXYpJ52aH+MLR8YmdkWTlHFC0WN7lPxaM1sckDA3vowxIA8QludjD7NAQi+7Q8l6lqlrgvfPwTKdkWPA4iFv691eSjYrND6apea3Hq3F3kWqA6VI/cMD4M3EmQna6qW2CpjBJSGaYI8licNMg64LrrNuLNRfaA3as9B/pkG7tsbkDnreqqupcQNFntjIth4sDBywbGdqo5zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwjDjJ5fm9t1uMyNwKnYbjp/gzkdVqrwzv2+nXkH5Hk=;
 b=LOfMUYWJT0kwyYjkVj1qfrQ4zVIzkk6L7o/qr+HPIYTR7hLU0dCws9rEWSX5KIsUNaWSEoOmbVgyO7fqY8JiqrlhOIcDg3Wei5WUnvx/KGbhCvP7J0Xkk1U4UW4WnSQmOIurrFkx1vA6HxSpN9pUw3uFDqMfIf3zdJbPXGlBOhphOWOu9soCRtwvw96SJ5DLOAopBD14eiMztDy36UWktJpBUJQCPwrOpp9INloHCRI6QLeXX/HWsd+t3PIs2PuByqCLytKWbVcyoYi3d22mPIStEzVKr8QhXq6s7xhZR3CCQp5rr1rzChKXYJePijOsAFpvDe8B0FP8Cip4ZOAs7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwjDjJ5fm9t1uMyNwKnYbjp/gzkdVqrwzv2+nXkH5Hk=;
 b=sojaxgt5D5K2BII6Nf/mLpJGBuo91rBvJ584Cf1LBRLpgyOCqlZzVzW9/cMp+G4QaDV3Weiwh7USjRW6+uocDIoWk0j1fpeOpOjr0XVKxjJIpjcNtyiEzK+khZ4Bp80S+Es3hK7GfKvZNA40vf37S+dIO2G3Zmeq534o6uUm3KA=
Received: from PR3P191CA0025.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:54::30)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.40; Fri, 19 Apr
 2024 09:25:49 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10a6:102:54:cafe::5e) by PR3P191CA0025.outlook.office365.com
 (2603:10a6:102:54::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.30 via Frontend
 Transport; Fri, 19 Apr 2024 09:25:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 09:25:48 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 19 Apr 2024 04:25:45 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Li Ma <li.ma@amd.com>, Likun Gao
 <Likun.Gao@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amdgpu: Fix snprintf buffer size in
 smu_v14_0_init_microcode
Date: Fri, 19 Apr 2024 14:55:24 +0530
Message-ID: <20240419092524.98737-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e34ca6-27d5-4802-b29e-08dc6052b2c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWZqQTJ1UnNPZXU5YUFhMXFUdCt4VlAyL2s3VlBIRUw4UEtVMlYrbWFwTy9C?=
 =?utf-8?B?cXN5TXl1OE1PRCtQTWo4TTJrOUFxRHhnYkNJY2JDWWRzMDJTRTJHeEhDRkxk?=
 =?utf-8?B?a0VyMGJVZlFLNHppR2FhalNjT2pwbUlxTDVHLzVVOUtCdzlqV0syNjJHb0tY?=
 =?utf-8?B?ZVB4QlM0OElVU3ZUdUpEU2VYNHR5MkNBVXVCNUo5S2w3NXUyL2pXblNaTGtm?=
 =?utf-8?B?QnlVbndyU0pMV3FTandicy96YjRzKzB3bVlNRlhtWWQ4UDBDYzJNZWFDZjlp?=
 =?utf-8?B?NzZWWGpMWHZlc25Ub0FnTXNvOU9DUGtFTDdISXlSU25oelFranRxWHFIekhY?=
 =?utf-8?B?MXM0UHI1aWhhQ3puemRMeWdsa1M1TFhsZHIwVHAybFVGcjQvWFVCUHgwVnhS?=
 =?utf-8?B?Uk90bEhNbU1tV3lGMEJDV3ZPamtMdWlYSHlaTE04VllXbVlsYWl3WjhJS2RP?=
 =?utf-8?B?ZWd2YnpNNEZsSU1lKzJnVGZudU9HaXcyYWFkT2pyeERHZmRHR0JNZE85RGtP?=
 =?utf-8?B?U0I0UGtZWno3TzRSSHp4TXZ0NmZodGZVQldzektnbm04SGZoUDNWSXBSV2t3?=
 =?utf-8?B?eUJjNFVseHY3aTFKUzNDSVR3c0t0TFN3U3VvaDRlSmswbjhtWkZxd2QrK09N?=
 =?utf-8?B?dFNRdk1vd2VLdnFOdDd5OUxxbEFrQ3lySGNjR3NEZDBkRjN4VngrUmJKSGRs?=
 =?utf-8?B?R2ZPMWxHNEZ2SkZFVzgyOFhHYm5kWldFOVc4ZzFXbWRUNG8xZDg1d1JHOFJr?=
 =?utf-8?B?bzRsQ3NsSkY2ZXgvWFp6RXFPT0w2UmhkZW1PWlZ0cU1XZGFVTlEzNk9OSkJ5?=
 =?utf-8?B?NFh1c2NacnVxT2QyS0JGZ1FOeUVETUtWMW0xYXZFYXpReElWRzQvZHFDczJ3?=
 =?utf-8?B?UXhLSWR2aHd2YWg2MklsMm9vZVRMLzZYaHRxdnVuZEY2TTRzbnVPZzUwTUZw?=
 =?utf-8?B?TVByV29ReDhKSFNGWm5UZitHTDkzRG1MSXhmdHNXOHkzOWYrdTJkcnpwZVBC?=
 =?utf-8?B?UzNIZFRIa3lrZlQweXJrcldiMFZzQlFmWkR0WExaMjBBSk44UWpUbk1xNzds?=
 =?utf-8?B?THFZRkd2ZlR4dDdBN2dFZGp2Qmt3cW1aMTdxWU14M3duRmhsczJISG9Tc1hT?=
 =?utf-8?B?QXRnbEUwelZ3d0VEWE5wems5emFHZDRzUGRFTkJPK1ZiOU1ocDdRazAxcGpO?=
 =?utf-8?B?cmpLaW0yL3BqbzJOSU5ZRDBkS1U1YkYwMmdxSFNaWXU2NVhhR0M4SFNjMDEv?=
 =?utf-8?B?amxGL1FKclBxMFZUeHQwbDVqZ3VqdjZUVjBhOWRvVzFTSzdGTFF5R0RVb2pu?=
 =?utf-8?B?SDU2K28zYmpDTUNhaUIwUFBrYVQ0QkdUNGJYVzRqcVEzK0VrenpVQlhIVTFt?=
 =?utf-8?B?SmZQcHB5RmlBT1V3QjdxUGkvcU5vd2NQZXp0NHBBeHNSdGJsc0NSVTgrdWpV?=
 =?utf-8?B?L0tBZ0prZ2w4RE5ySm1salFubDZKd0FNNCt2eVlLZnhTKy9JeEwyWkJQVklY?=
 =?utf-8?B?NCs5UndaRFNMN3lvcG4xNkVYVEllTFBCZUZrYmJTSlREMFU2N3BSbDN4a3Rw?=
 =?utf-8?B?M0hkMlpheW5IZkN6aVFSWXVWSGJTZXZhMDBpc0JXdkc3ZEtVZ0dGc1NXTHVL?=
 =?utf-8?B?elFDSDJVS1ZwTmExeHFUYUZFZVJOamx4OVVFd1RLNWhxeFUxdUhEcktScUpE?=
 =?utf-8?B?TVAzeWpmRUkrZUpVVnJOSStDUmw2Mkc1UldqOW9Udkd1cHRYN29iRUppN3Ji?=
 =?utf-8?B?QjBLRXQ1cGRFL3pFdzVSR0ZDRXRnZUFNL0xiTTBXS0xtc0ZzbDVvemNEMFZo?=
 =?utf-8?B?T0dDMHQ5SUVtSTlOOWNsaURFMnNXcVo1b0I2dWVER3VhOHplbnpFdE5uVlUz?=
 =?utf-8?Q?NkSCt/b5E+/ga?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 09:25:48.1403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e34ca6-27d5-4802-b29e-08dc6052b2c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329
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

This commit addresses buffer overflow in the smu_v14_0_init_microcode
function. The issue was about the snprintf function writing more bytes
into the fw_name buffer than it can hold.

The line of code is:

snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);

Here, snprintf is used to write a formatted string into fw_name. The
format is "amdgpu/%s.bin", where %s is a placeholder for the string
ucode_prefix. The sizeof(fw_name) argument tells snprintf the maximum
number of bytes it can write into fw_name, including the
null-terminating character. In the original code, fw_name is an array of
30 characters.

The string "amdgpu/%s.bin" could be up to 41 bytes long, which exceeds
the 30 bytes allocated for fw_name. This is because %s could be replaced
by ucode_prefix, which can be up to 29 characters long. Adding the 12
characters from "amdgpu/" and ".bin", the total length could be 41
characters.

To address this, the size of fw_name has been increased to 50
characters.

Fixes: fe6cd9152464 ("drm/amd/swsmu: add smu14 ip support")
Cc: Li Ma <li.ma@amd.com>
Cc: Likun Gao <Likun.Gao@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 7d2055b9d19f..5d9335cb8530 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -64,7 +64,7 @@ MODULE_FIRMWARE("amdgpu/smu_14_0_3.bin");
 int smu_v14_0_init_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
-	char fw_name[30];
+	char fw_name[50];
 	char ucode_prefix[30];
 	int err = 0;
 	const struct smc_firmware_header_v1_0 *hdr;
-- 
2.34.1


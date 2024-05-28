Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C7BC25B7E
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 06:53:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2FF010E049;
	Tue, 28 May 2024 06:53:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TVI1TyzY";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADB0F10E0CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 06:53:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRS+mG9eKtJ2bl59v8/374m8Qa4gqYXHxN72kzc2Fs5uR7eLDRDz2mRoGui9vg6PRgXpxcodJgfBQP0hPnqlYtLUjb/yWyHrgMwdL81BHGW7H7fkn1r8TAyb+w/Y8hSmIO0OsVKc04gtBNQeo7JJVAufJPedEX6tQTZFsKT1ejb+qVEm+baM66VdU4fP4jyK+nvDYylCftN2YyFhiT7NVd7KWos0TJ3/epoOU6V5TI/3EdCGvlPAJ9NhZouTyWOIZQJjRN9wM/igQeooWfJiIDLkHyZx3csBW14ynCfKfBVs046iGrtNTIu3eiSKCkVdotUjA4e0WWyguKsK3J4k1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMCV0jiSktmYBH0uYytXf51pqP2B6XCZg96cv7vfQRo=;
 b=Kjr8G0L/FR1LeLrzFJKCVUaReBLqnoFMc8ig/zy3MUoBDFKVdBDm7AHi3MxTgresQ4ggbQiqSf68jDs/baGv8qBdbFDledf+M07kbyhuJ18K6SREHxGbwNZFpsZcLC4QgqGHFcChVNOBSbQR1pzB1aIGc9pP2ghwDZCtkPfiEWRz9Tdf+6kVVx71t8XTLCdCnoYCaGI/WiJ4Kv7y41w61iXkkJ8OQRGRX5dPAupNftb2iIDGfYdPIdRX2Xw7h/PMzxNOVBSitcO/EjqSAntDGkRkNnndblfaWOT2nUVNlmjCy+EHQL5Z0g8Zf6TkZKpjPOH/J/CBCB42DQdnKYdWlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMCV0jiSktmYBH0uYytXf51pqP2B6XCZg96cv7vfQRo=;
 b=TVI1TyzYz+w0VEM6uYXQgBreiRF8IIUQwscw54DiEf/EdxaYVP8crNvO/Gt/LarE3gvpbt/Uh2Dfc6r3QWpgdtRNQj/hnipO/YOwbORZhUviU6Ul+n1/8giPF0casHlU+ypPf3DrHyTWn5ku9qpfyYi6Mj28g0mng5iFQdd39yI=
Received: from DM6PR03CA0019.namprd03.prod.outlook.com (2603:10b6:5:40::32) by
 DM4PR12MB5818.namprd12.prod.outlook.com (2603:10b6:8:62::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.29; Tue, 28 May 2024 06:53:42 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:40:cafe::62) by DM6PR03CA0019.outlook.office365.com
 (2603:10b6:5:40::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 06:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 06:53:42 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 28 May 2024 01:53:39 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Ma Jun <Jun.Ma2@amd.com>, Yang Wang
 <kevinyang.wang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH] drm/amdgpu: Fix missing error code in amdgpu_od_set_init
Date: Tue, 28 May 2024 12:23:16 +0530
Message-ID: <20240528065316.1875823-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|DM4PR12MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: df508ff7-386b-48f9-d300-08dc7ee2e96f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1hPMUFKdVZQZDlXMFduNVNzdjVKWDFxbFNXQlB4MDJTb1dxSXNva1QyRkha?=
 =?utf-8?B?bEtvM1RzTitwS25FN2drN004c2JHVWpNVlhWeWI1emg0OFduUnFRN1JLRTYz?=
 =?utf-8?B?UjJJNE13Wk9iZVNhckloZDFleXU0R0pmSkYvV1RueU1sYVVlaVV5Z0h4UTlW?=
 =?utf-8?B?c3dXdk5SZE9VZVA2b00rMmVhRHdoU0oydzV5MzRpZkU1MWZIMDlSZHdzMllz?=
 =?utf-8?B?dHpVTGdNTlpUNDhlRjNtV1RjQ2RaZTJ2UUxYVTVURmFpSXdwM29qZVBWc3hB?=
 =?utf-8?B?NHR3bkJmK1p4MW9Ia2V0dktVcENYZmQ0V3VyVFNQR1FleHZ0SkFWS2syV3Fl?=
 =?utf-8?B?RWV5dHdBNldxSzFneUVGQzlRZzZuUnlwUnlzRENLVjZLS2pLUkpoNWZPTDVW?=
 =?utf-8?B?QldweVh2NE1HVDM1YllVVEFSQ2x6eUNuWUhnQTMyVGloVzdaNEdTbVpLd0xN?=
 =?utf-8?B?Y2lIdlBYZnZPSDk0SXVHbEJ0VWZtWHV2dkwzTUlhTU53eVZTUnMrOElVNUFP?=
 =?utf-8?B?NCtic3ZkY3cwQ05LOS8xbjBNUXpHcWM4aWxxT1lOa3RGaGJoSnI2a01FWHp4?=
 =?utf-8?B?QklKRXU3QlcvbVZXdTY3WWJmUFRkZ29UaHQzTmljUjBiOVBIZFBwOFJqL3VL?=
 =?utf-8?B?L2NPbTA0V3dZaXQzbFRzRFV1c1JZRytzQitQcjVZMEFaTlJaazdYa2RuZmF3?=
 =?utf-8?B?djVmUmdwS1BDejliSGN3Wlo2TC9KLytuaGs1K2dDMVFWd2FtcXdUNGFIRlFt?=
 =?utf-8?B?SHFIUE5KMllJMWIyekpSODJyK1hIMy9zQnc1RXhQSG1iRXlna1ltK3RKOS9T?=
 =?utf-8?B?U09ITlMwN3MyM3FHT0IxN0xpY3A1RHpuMFhlZFFmS1E2cXRBa3JOeGZRUUEz?=
 =?utf-8?B?RkFENVBodGx2TDhPcWErNDREZGdOTm14Z2RvTHRUQzA2b3VuR29nWEcybGFo?=
 =?utf-8?B?VGpQTkVEQWZQd3h6cjY0a2ptVGxvZEwxYXFzVWM5OHRVd0pKYnFOSzVRbHB5?=
 =?utf-8?B?RVlKdmlIejBibS8xZmJoR09BUjlET3JBbmh6NmZ5LzNndHF3aWJUTlc0QlE3?=
 =?utf-8?B?S0lBbnRrc2lGbitkdEFvbitXWFg4MnJWUlhUcVlQT2k5SFNTb2dKRmVwRkYw?=
 =?utf-8?B?Qi9EUDhzUldWanplcEhka0pmU1I4RS8xRjZCTEIzZ0JXZkZzNEt4M1RRTUlZ?=
 =?utf-8?B?MG54WXUwWmJVd2kyVWd4dms2T2g5eDlKVzI1UmZKYllLY0FKNUxoMlBaUzRw?=
 =?utf-8?B?R0NYNlpXNzd3d1VuTDZ0WEUvOUtRYVFESVlqNCtLVUQxNWlHeUxmLzc3S3Ry?=
 =?utf-8?B?MHVzemtJK1VtazZFVDVRazloMW9JdXRPaHlUb2RxcnQ3TjZITWhXd0JnSXE2?=
 =?utf-8?B?TmZHN2h3TWJidzE2bzgxMkFGeU0rZkdGbWVvdy9Zc3Z2aHFOZDRST2lkRjNo?=
 =?utf-8?B?S1ozL2lsY3ZDNnh6d3FBeVRPcTJFN29sQ1Iyc1JDUC80T2xvL05wZFUyNTNn?=
 =?utf-8?B?RHFmM1N5a0NKL1NlM0NyRGVQdU11TXVVeldicHF1TDE3QUZjTkVFTmtJell1?=
 =?utf-8?B?Q3lQUmlGRnFvU3NFeWRwN0NTUnhnTnRnSTFqM0ZYTS9Kd1pjQzJyTTdBanJB?=
 =?utf-8?B?YmNWNDZXVnFQbURuKzRNRE95dkwyclI3MW9IYWI1V1hRNWd6VGVRaTZrS2VL?=
 =?utf-8?B?dTNDalRCWGtpa0owcC9UaC9hbm9abHBndU5wS2hzTi83OUhuN3ZBbVNHNHdO?=
 =?utf-8?B?NTE3TWVROVlNY0lYZHh1UGduNkQyTzZNcjEyNjdzVmZTQTAya0l4YVkxZnZM?=
 =?utf-8?B?b0RYb3JsbWRGUDUyc25vUnZ5NHFCZkY5RStkZW9OUTdGRmx2V2J2aTNiUGZM?=
 =?utf-8?Q?kxEs67dfnN7kZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 06:53:42.3115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df508ff7-386b-48f9-d300-08dc7ee2e96f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5818
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

This commit ensures that an error code -EINVAL is set in the
amdgpu_od_set_init function when the od_kobj_list has only one entry,
indicating that the list is not in the expected state.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../pm/amdgpu_pm.c:4355 amdgpu_od_set_init() warn: missing error code 'ret'

Fixes: d9a3a5e770dc ("drm/amdgpu/pm: Remove gpu_od if it's an empty directory")
Cc: Ma Jun <Jun.Ma2@amd.com>
Cc: Yang Wang <kevinyang.wang@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d5d6ab484e5a..86118fbfc33c 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -4463,8 +4463,10 @@ static int amdgpu_od_set_init(struct amdgpu_device *adev)
 	 * If gpu_od is the only member in the list, that means gpu_od is an
 	 * empty directory, so remove it.
 	 */
-	if (list_is_singular(&adev->pm.od_kobj_list))
+	if (list_is_singular(&adev->pm.od_kobj_list)) {
+		ret = -EINVAL;
 		goto err_out;
+	}
 
 	return 0;
 
-- 
2.34.1


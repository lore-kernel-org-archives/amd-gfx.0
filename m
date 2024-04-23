Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E15C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 01:45:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC4BE10F71E;
	Tue, 23 Apr 2024 01:45:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R2JkkYtt";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1097310F71E
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 01:45:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8xSjtPtNJFS8QlDUgyIuatAktdYKTWpjmpOfHbvBfCVH+p0iFgHwQZyQ5iG5AyERlR+yxcfgkIgVAjpIwlnUjALEzc8+0QA/kJAGQv8XvNcNmhTvxnCA2/mFAkhV5KRxeJH9mRXoo2gdRCuEtY472hd/YqR9ezt8pvBphvSt9u/xaM9wijXPdkU8oa5fzGaXfnYMnXr4Z0Utxkq4hhJ/beL8GIfZpHpFdhdDMv5UmbeEyg1BuS5gLphiJ5AWrmRQ2flq9xyIR5Ri27dg6EY55dey+Nzo6E5yuFxuwXKyHVPvvo1H41i5OR5JJd2t3RWL3HKctWKnt0ToLdVKOIykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMm5jrs02sjyxvH95Sp12gGYCSaZ0X4MhS9tVrAVmTw=;
 b=L/X5zXdHEH4zb+8V/3W3qfG+w+oPLw9ZndGqiSr60pkHX6t8Y2IKAbuZeCxGetPjJC8vujZtJWgSMhAw6GvLW473nM45xfxXvD3v2wO8w1LLxjjasMmb6E5Ji+UjmJjkIl3wQ6l+Tf/5gjDTe+wanP4zWPS7LckcKUXgKsvrEu3DLauFTgXesG7BTmyaSe3YX6k082FvTuNvtsWQ2gmMIkqe4Gu5k2CN9Ci3Xw2qTMbK6qTKv+es2zfxvPFK+Zgg3LFG3ZO3RVLlykUCpyj+Z8TgrmbwV2B1AJxZfUTANVMH9S8LmeDBqptOC4cuTqUObOmKH743b3qp28aQ6E3RkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMm5jrs02sjyxvH95Sp12gGYCSaZ0X4MhS9tVrAVmTw=;
 b=R2JkkYttye6k8ruEPQ4viNsul4iTM6QqSSzdhMkISeafkHh4IR5g06I5KOsdDeJVwG1T/bUw15mPkxT2x5MjTimFcdPAqK49kJg7eNJ45gO0y5H2dPf9yZKb/NClgPe1mOzZD1idHf/+JXRFjndwGJtVH6FJAiK47dNAPd8oplE=
Received: from BN9PR03CA0513.namprd03.prod.outlook.com (2603:10b6:408:131::8)
 by SJ2PR12MB8832.namprd12.prod.outlook.com (2603:10b6:a03:4d0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 01:45:16 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:131:cafe::f0) by BN9PR03CA0513.outlook.office365.com
 (2603:10b6:408:131::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.20 via Frontend
 Transport; Tue, 23 Apr 2024 01:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Tue, 23 Apr 2024 01:45:15 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 20:45:07 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, "Lijo
 Lazar" <lijo.lazar@amd.com>
Subject: [PATCH] drm/amdgpu: Fix buffer size in gfx_v9_4_3_init_
 cp_compute_microcode() and rlc_microcode()
Date: Tue, 23 Apr 2024 07:13:59 +0530
Message-ID: <20240423014359.1597545-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|SJ2PR12MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: 36c18fde-4b76-4f92-14c6-08dc63370630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cUFBRC9NYmJUcnRPSW1DTm9LVmNaaDZSUjFlalRuNTZnbjU0ZGs1eVk0YjVt?=
 =?utf-8?B?UCtwQ1Q1dXFXK2NFQ29wK2tCN0tIWXJsZCsyeGcyNmFDa09Od01BeU9KUER0?=
 =?utf-8?B?NXdoNFRkUTRjRkx5ZTgxV2l3NEozNzJRU1pMSG9tL3d4dGpMbWdtay9mdXRv?=
 =?utf-8?B?akllakZGYXc4blFWUDlKbkpoRks3NGxodE5Bbys0MmI4L0R0Y01jbUxIQWxk?=
 =?utf-8?B?M2ZJS2VvUlB5cXdiWktTOXZ2UWhLeXo1eWNzRXVydWd1M3JLNHBxemtDRXdP?=
 =?utf-8?B?NTBPOHJOdGlHM3hwTXUrbUF5N1cweVdBbmM1L3pYeGRPei82QzF1V2tqSTlS?=
 =?utf-8?B?b3o2aGROQ2s2ZWZFa0dobC82eWRtZnBKU25yc1F0T0I2ZVMrUGIxWmJ3V2N5?=
 =?utf-8?B?ZXNHa1k2ZDNCaGdYSjk3SDMzR1pHVHBPVkhKR0ZlL082TUtJVXBXMnNLTUtV?=
 =?utf-8?B?V0QwMDZnK1BocUdaU2hhZVNJNnJpMUhaeXJlZHJ3UXV1NCtjRFhxNjM1aENR?=
 =?utf-8?B?YUJCRkM4Z3JKSmlORUZtZ2FvSlNSeURPc1Jubnhob0ptbm93QWFtR3VwNjNJ?=
 =?utf-8?B?czE1WERXcXloRXNUT3VyZSt2Vk5vQ1YwZU1GVkVkRVpqazdzR2VPdHJzK0Uv?=
 =?utf-8?B?VlNaeXdSbmZYbkpxWUpRdTV6YjN6em9LR0Rjdm9zTFVsUlJMdWV2K2t2SjVk?=
 =?utf-8?B?NlNYcUNubHY5L3BTRGFLdWEwYXoxSld5WU1DWU8rWTAwQjA5cFg4WlBJcGQz?=
 =?utf-8?B?NU1KNDhYVW9kbWJYS1ZPOXYyZXcvcUhna1FndFI0c3FHek9OMnFncCt3Y2pH?=
 =?utf-8?B?WDlaek5HL3hMWlRnT004YWUzajVVc2NsOFNabGRETUZ1aUhydnZrWEJ1dC96?=
 =?utf-8?B?UkVZMncxUnZrR0xPeU9UV0pJL0MwMnlPeFJmZUpVVmVEZXRuQkpoWmFpMDI3?=
 =?utf-8?B?MHpjeE5lRkYyOHYrbFJYMTlGS1k2ODdUY05ZMGxsakJtZml2Sk5zcFI3RHdt?=
 =?utf-8?B?SVJpTkc4UmJOblZrRlNlTHZaaWxqVkVvUDNIQmppaXdTYTQ5QjQ4WDhYUmZ2?=
 =?utf-8?B?TWtEc3dENkliZjZPeUJ1eGt6L1ZEQ1RGTCtxMitESWJWWm4zZTBKRXdKWGpU?=
 =?utf-8?B?a3ZSSG83Wkd5WWFKRHdvS3pDakVUZFFXa3paWmlZemNvZWphOS9ROHpQeHhp?=
 =?utf-8?B?cDVKcHJtMjJtcU9LOHdadFdjNkwzYnFlYXpGSmVTR0crOTY3NkxvWG5KSHJD?=
 =?utf-8?B?UHZZcVZJUXpneUNuVTNqNDhITmN1d3ozSnBnN1d3QnRLTUppSlV2a2pvSy9k?=
 =?utf-8?B?c1hHdWw1dEF5UXoydDB3dTdNL0lrVmhpdFdTZ3Z0U0pLS0YvdWpCTFFTUUFm?=
 =?utf-8?B?NkZuZlV5Y2tQR0U4QllsT2owaklIdjZpV2o2dXFuM2twLzZlRzNjanNzdVhN?=
 =?utf-8?B?eHR1M1poQ00xMDFvRkN1YTkxQWFncXJTVWZINjFOd3lHZ0Y2U1p3OVY2ODlV?=
 =?utf-8?B?aDJrRFIwWWhabmFDb1VMY3I1YUtGRDhhaWVrT2hFY2VQeXZsT3dBbXJocmk4?=
 =?utf-8?B?cnFzbUQveVFtSHpnMUl2S1pRUDFGbzc5TG4zQXM0OVZQcHZzTEgrMTd1aTY0?=
 =?utf-8?B?SVVZM3N5OWkzb0VVYVN6ekpPQllqVVhMVlgzU1gycWJUbmE0cytJUm5ScENO?=
 =?utf-8?B?cE4xaFcxVnhIOGlZb1ZHallEbkE5aVcwT0k0OGZSK1VCOTd0U1c0aUVWZkNt?=
 =?utf-8?B?OU9tUXZYdGg1aG9WVUQyTjgvMHlPeU1FcHg2WUx1ODFGbFhlMnRRS1BDYzNz?=
 =?utf-8?B?cFV3SUY4Z1pZbU9ML3h3R29EUU1XNHFOMFV5V1NlNVg4aStWZnExdnEvQkQ5?=
 =?utf-8?Q?ulNIFBX1vsma5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 01:45:15.7464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c18fde-4b76-4f92-14c6-08dc63370630
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8832
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

The buffer size is determined by the declaration char fw_name[30]; This
means fw_name can hold up to 30 characters, including the null character
that marks the end of the string.

The string to be written is "amdgpu/%s_mec.bin" or "amdgpu/%s_rlc.bin",
where %s will be replaced by the value of chip_name.

The length of the string "amdgpu/%s_mec.bin" or "amdgpu/%s_rlc.bin"
without the %s is 16 characters.

The warning message is saying that the chip_name could be up to 29
characters long. If we add the 16 characters from the string
"amdgpu/%s_mec.bin" or "amdgpu/%s_rlc.bin", we get a total of 45
characters.

This is potentially longer than the buffer size of 30 characters.

if chip_name is longer than 14 characters (30 buffer size - 16
characters from the string), the resulting string will not fit into the
fw_name buffer, Thus increasing fw_name buffer size to 50

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c: In function ‘gfx_v9_4_3_early_init’:
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:379:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
  379 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
      |                                                    ^~
......
  439 |         r = gfx_v9_4_3_init_rlc_microcode(adev, ucode_prefix);
      |                                                 ~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:379:9: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 30
  379 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:413:52: warning: ‘%s’ directive output may be truncated writing up to 29 bytes into a region of size 23 [-Wformat-truncation=]
  413 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
      |                                                    ^~
......
  443 |         r = gfx_v9_4_3_init_cp_compute_microcode(adev, ucode_prefix);
      |                                                        ~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c:413:9: note: ‘snprintf’ output between 16 and 45 bytes into a destination of size 30
  413 |         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 86301129698b ("drm/amdgpu: split gc v9_4_3 functionality from gc v9_0")
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 0e429b7ed036..1c46d5f6677f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -370,7 +370,7 @@ static void gfx_v9_4_3_free_microcode(struct amdgpu_device *adev)
 static int gfx_v9_4_3_init_rlc_microcode(struct amdgpu_device *adev,
 					  const char *chip_name)
 {
-	char fw_name[30];
+	char fw_name[50];
 	int err;
 	const struct rlc_firmware_header_v2_0 *rlc_hdr;
 	uint16_t version_major;
@@ -407,7 +407,7 @@ static void gfx_v9_4_3_check_if_need_gfxoff(struct amdgpu_device *adev)
 static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
 					  const char *chip_name)
 {
-	char fw_name[30];
+	char fw_name[50];
 	int err;
 
 	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
-- 
2.34.1


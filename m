Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB11D12D62
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 02:46:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E46110E415;
	Mon, 11 Nov 2024 02:46:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aItR9eHW";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E34AA10E414
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 02:46:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6tDFqXBtvHfym22kfZ7Z9p29/owoZSHRL9eTrEtuQb2bD8TRwcObX6bNgPUNvej0dGI11o/nr/uviokKu7LywAFLdNV8y3hVbWNF9xpgtpzT7oxaLQNu99uZlnRmTxrbcWpMzRkTv1weJ8KsYcMWZq4k5ci2ngfDKNSJNn1E0KoyCYekYGbLmXwLWPVMPcG8pbq/8sopPAlpV/EnyXkCPbDAw8YDck0HoXWxvzeB3/LGQ+13hzwNnnFngM71wIy6rYdrQTkFGPH8w6r7l4bJU7Qre2yTv8Lp8mc6uf0in2Yqo1GPmlbRRyOyZu/Tfb/KcRjYCni21SWSAe+phN7rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85ahSzHX2HhjH/nlYmTvvk0fFVN4rB5/o95DvYG/PMA=;
 b=IPmJ8T6ItVMt3FDQeoPCGioVOOPwP4xoKVFuFVVoJhChbcvRwAmZncIq2b2jRQjkr/CutT9hNdpcgW3Xp/ikySUD/9CZ8OSBtEZ5Rjig0idNOZkz4ThnAzV0TheM2HKZpFdwldSs/HI6ISvwF8+67opl+rEtLLspERnR0zdfxHTVTpkPVmiHuZsQJ8xLT4fMCyaZmj4rWPR7FFfFlmyCvgnuwB6l/O9m1H+c3dGRV8LDzZDnc6fLA4J1jWqy24yhXtHKWIApJssh7m+HIGT47PJ8fgoxeQ1MYlChTnxRivGIOZJybdtUO6QQMwQzcnJZqrukl9BdII2JmXZUHubJ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85ahSzHX2HhjH/nlYmTvvk0fFVN4rB5/o95DvYG/PMA=;
 b=aItR9eHWU9Uhn4Y0AfYkGjlPtExAQ8W7Mgs5ltk1uvCmdZK0VDsuzQysZ/k+Ww3l0d7etdD57/cT+FXSqjEwT9tqmIRoZAciW2rHqNDzuNUfELBI5ZBKqlhRH0QRZK4EPzExAWg6c63zyqDnFNH6nanWRW262FM4XDbcoQbsDME=
Received: from SA9P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::35)
 by IA1PR12MB8408.namprd12.prod.outlook.com (2603:10b6:208:3db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Mon, 11 Nov
 2024 02:46:32 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:806:26:cafe::57) by SA9P223CA0030.outlook.office365.com
 (2603:10b6:806:26::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27 via Frontend
 Transport; Mon, 11 Nov 2024 02:46:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 02:46:31 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 10 Nov 2024 20:46:29 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: Add missing 'inst' parameter to VCN v4.0
 function interfaces
Date: Mon, 11 Nov 2024 08:16:12 +0530
Message-ID: <20241111024612.1881727-5-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111024612.1881727-1-srinivasan.shanmugam@amd.com>
References: <20241111024612.1881727-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|IA1PR12MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: e48459ec-5ad0-4941-dda2-08dd01fb0cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDM3clI0cHo5dSt0ODVnMW45QTBhaEhnYXB6aldYdnY2OHZGNXl2WTV6S1Vw?=
 =?utf-8?B?WG9GcDNyK1NDak9OUy9nRUgvSnp3OCtvN2tGdHpDd1EwQXpGaWJWcGxSQzZC?=
 =?utf-8?B?ZlM2RXVmTjlwb3JKaFMyZnl3clVLVDV4WDFLdDJhd1htbmlYNGVLdzBMOXJv?=
 =?utf-8?B?Z1I2ZFFuNVZJbEpnS3NlNFZhUkxyNVFJTUZ3d0I3VGFDaXJ1QXBhN0Q5Snpk?=
 =?utf-8?B?dWxtclVaSVZYWkdqU0FWQ2NHUURWN3VjSk9KOU5iUkFpVmJmakVHN2lOYSt4?=
 =?utf-8?B?MGxzRnlwTWloTWFpQ0QxN0R5RW5HRFhJRzNvMVVCYzBtTjFxNHRHWXJHRmR5?=
 =?utf-8?B?VFIrL3VYcDY4cS9lbmJ4MlF5TkprMi9MeDY0NzY2WWhmQWRUK0lxK1Q5TG1T?=
 =?utf-8?B?ZS9IQ24zNmJoYUdvRUZ6MWJXWGtPdzdJSW52YkNCaXR4TFIwNURrZ0JRd2dO?=
 =?utf-8?B?Q1pUL29VN1lEb2VoYkVTOWhQc3A4VHZtWmt5N3I1OThHWkVkVnJ4dDVPR1lx?=
 =?utf-8?B?TXRmWHA1QW55THg4bmxVSjY5MGRxVWNxTFBSYTA5Z004eEdjdXg4VGROaGZO?=
 =?utf-8?B?bkJjZlJBem9QNk5lbHRmOTVYNTVLS3hrdWcrMkp0TDhXSnVmS1V4eFplRng3?=
 =?utf-8?B?aGRzMm0zVFRxZElSZEdoMHM3U3V1R0k3RFNUdUo2eExtb2ZKUEV6TTRHYmw4?=
 =?utf-8?B?cDNHc1I3RVNENWliVDJHamNTTjNVVTJLT0oxWFE1N3V1bHdsdFhYMzFaMzZn?=
 =?utf-8?B?dDR0Qlp6b1dZSFZRV3lzNEhrUzV0L0k5aTNNQVZQM3NSOXdiTDVtMFZ2QW1s?=
 =?utf-8?B?bFJIc0JYVW9TSjI2NjBkZnNuYm0zQlBaNjhvejRCVkpoNkp3bDJIamgzMVRk?=
 =?utf-8?B?MHlNa0Z3dENCVTBwdnF4NDVHQnY2eHhhZTJrRVBmUFN3K2t1aUV0bkczSyto?=
 =?utf-8?B?b0VPSnZpVzgzNktZZUVlODBjT05KSWhaMVNPelYxTHJBRmd1eWtzcVlsSXpm?=
 =?utf-8?B?c29RMTE2OEZKbFpJdWFxcVJVVmxqalNjd2hHYlY4emRRYXJ6ait2T2g1SDhh?=
 =?utf-8?B?M0ZzSFhVYjZsakF4dlpvekxvWTRBYUlJcjd1VG1HZWxxSm5SWVF0SjdOMEpI?=
 =?utf-8?B?YmxlWlZoeWNYTTVHbmM3eFVwL3JCSWJFM2lhYUdtQ3pSYVJBQmpZR0htTXZ1?=
 =?utf-8?B?ZHJsQVVtQTg3UmkzT3VqZUNWSUtYak9yTzRuVVNLZ0RiNHdxdy8vSGJucjNS?=
 =?utf-8?B?NUxXOCtLN251VG1ZU2k2enE1dm5QNWJHZGNmd0o3d1hubWFIbDdrQ3Fpbnhy?=
 =?utf-8?B?a3RnL0NlNUhkWngzQUp4RHJrVWF3aVF0bWR5Z1ExUDJrcDhiMlJnbkJVNFRX?=
 =?utf-8?B?b3Eyb1cxR3NoWDlPeWxkbnU3bUdvZ1ppK3Rtdll5Z0tKeVpMQzVOVTVRZzI2?=
 =?utf-8?B?Nm9rQVFhRXl5NzNjVjJZaHFmZFZYS0U3NkVJdjRNSk0zdXhIdHYrUHdDVUY1?=
 =?utf-8?B?ZmtaMkp0dCt1WDJLQ1JOWk9TZW5JbXl0VHhHMXpJUkVGTFNGclJPM2Z1ZVI3?=
 =?utf-8?B?bFNaWjVZdjdUc21DTHRBb0pIdUxDSmZiSUQreG1TdXdSMUZDUkhpaSt5RnVV?=
 =?utf-8?B?a3R2eTIxUDREb3F5Z3NROUY2eVhxNU1nUlEva0VJcmRDYnNVSmhSY1JJejFn?=
 =?utf-8?B?UC84eUJQRmxDWndOVFAyVE9mUTZSdzJOa3lNL2hWZi82MXM2bDljTENaN3Vz?=
 =?utf-8?B?ZG9sSmRTY0FVSGdDQ1p2SlZZQU00ZnpPSGlmaGszTEJ2QmJoZi9TS0gwRXNw?=
 =?utf-8?B?Vmo4ZkxzczMvK2UvMkJaYXczditUK0M5R2dQSXRGTE9rdXRNbGNMaGErTEFr?=
 =?utf-8?B?UXk0VG9lMHJPMDVnVGVUdHhaNzZZK1ZpdWFXbzJQRGhUd3c9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:46:31.6761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e48459ec-5ad0-4941-dda2-08dd01fb0cb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8408
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

This patch adds the missing parameter descriptors to the functions v4_0
_start, _stop, _set_unified_ring_funcs, and _set_irq_funcs.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:1093: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_start'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:1551: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_stop'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:1939: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_set_unified_ring_funcs'
drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c:2142: warning: Function parameter or struct member 'inst' not described in 'vcn_v4_0_set_irq_funcs'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 5c3b718ebdfa..c42d1274bcc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1086,6 +1086,7 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
  * vcn_v4_0_start - VCN start
  *
  * @adev: amdgpu_device pointer
+ * @inst: VCN instance index to be started
  *
  * Start VCN block
  */
@@ -1544,6 +1545,7 @@ static void vcn_v4_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
  * vcn_v4_0_stop - VCN stop
  *
  * @adev: amdgpu_device pointer
+ * @inst: VCN instance index to be stopped
  *
  * Stop VCN block
  */
@@ -1932,6 +1934,7 @@ static struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs = {
  * vcn_v4_0_set_unified_ring_funcs - set unified ring functions
  *
  * @adev: amdgpu_device pointer
+ * @inst: instance of the VCN block for which to set the ring functions
  *
  * Set unified ring functions
  */
@@ -2135,6 +2138,7 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_ras_irq_funcs = {
  * vcn_v4_0_set_irq_funcs - set VCN block interrupt irq functions
  *
  * @adev: amdgpu_device pointer
+ * @inst: instance of the VCN block for which to set the IRQ functions
  *
  * Set VCN block interrupt irq functions
  */
-- 
2.34.1


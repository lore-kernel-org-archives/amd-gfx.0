Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5820EC4345F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 05:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD87C11212E;
	Mon,  6 May 2024 05:59:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4pe/4foO";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC48C11212E
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 05:59:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIBnm/bUqPiyMP0cbJCm8x5w8ZWalOPQlQorY0lRbqzxBFi1aQNzWE0Afp2bS7An0xJgEcEP9AUMFZ2UsgiJj/DgMgs3ttW5YubZ+xAmR1OgHdXi4bVCSxs1yXBamMx7XN2CieZw2hb9ypnoc62/PBKjKdtkrsLdoSLaPkG3LfG6F6ef9qXkQMDqsgbWRVX6xmdUCYYNHcJhtJJnIZBIHVDS88rUJS1Y5P6AbdITna2NknY9a6hcHZ2zuAe1LPgJDiaYAgACnv7hcD81DHHoe3II526ZP2XVFCxHmUuQDPtl6EtAv456NvBgbYLbul56TfnVt6ff8aqQWWBBWhpygQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxoVkciYU5hvLloI1C64R7m6aZfqy13EHap6xzrVpyA=;
 b=g2hWDLFjndC0XrXeQwuKLST7o6Qbn7KO7WCOKxs+q0m2BllDaaMt8fih31QaH3CAd41IHf4huHP1x1eMQ9NKXHFDc0yT70NFvlYomno3G1T0fv6b1WrGxaoHQs9WwoDucF6pNPWQpaqj/zn6vr19/bcDlMMNeYlFlb9e4HXcX3SbrIRYUKlirqZG8ErqM/xX3iscYkG2Nb7SJy8RZf/e4HFrzzfQ43bcqm/eoK6Zh6lqXEyTmudwdSyDw/8hc6j8zs3Rw+iKtZtFwFtmPqikdd6gITUDXeuQc8GLUWkb5llTjJjQ9a3SgY7tRG5mh6q9dHAEt+jFbRBBsDlUBanvsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxoVkciYU5hvLloI1C64R7m6aZfqy13EHap6xzrVpyA=;
 b=4pe/4foOf3INbf7qGq7xLoTC3dUJTNDdHW6LRk0ivUQF1vuCeRx7pE+arb8pqUOsAX+4b7QrYxs8l+mIbuwKppQGuKbWApW+bEi/qhZCrMGbPBwgRWcf+wIn2YX520hMp4qXswLxnyTJs/zYW2yYNkg2XSO7Ui9oi2oR0kEY9aU=
Received: from BL1PR13CA0070.namprd13.prod.outlook.com (2603:10b6:208:2b8::15)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 05:59:33 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:2b8:cafe::46) by BL1PR13CA0070.outlook.office365.com
 (2603:10b6:208:2b8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42 via Frontend
 Transport; Mon, 6 May 2024 05:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 6 May 2024 05:59:32 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 00:59:31 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
CC: Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix out-of-bounds write warning
Date: Mon, 6 May 2024 13:59:01 +0800
Message-ID: <20240506055901.227249-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca9c49d-50ab-4c9d-b943-08dc6d91b388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjVxQzdzWDRGb0RlaUI0b04yRlVSUys0dFhaZ3Rqdit2KzhpWTlCVWlnbStY?=
 =?utf-8?B?ZS9zaGlpc1NFbVJ2MTFTTWhyOVBHWkV3SVArMWc1bWtkd0tmbzJmMVZuOUxp?=
 =?utf-8?B?NXZIeGYrREpMRGVSTTR5V25RUXFsTjRtMjV4M3pKQnJLK1NWNE9rY2oveGtE?=
 =?utf-8?B?WWNGRys4eEhDQUcvZTVpQnBQOG50TFFCZlZPQTRKbnNrRU44NTNxU2RkY2Vl?=
 =?utf-8?B?aFB1VWFMUE9UeWxtdVVoTEJ5Qk1lOUIwOEYrRElCY0FSUnlvTlZvNWJKMXl0?=
 =?utf-8?B?V3pFUThRT1NxUEU2UkNYT3A1Vll1WXJjTG53V3JCUWpkZnJUQStUT2h0eUUx?=
 =?utf-8?B?MW84RHVzMjIvYUtPMmMrd2lrbzBlMHB0aW1NZ2hjc3NaUXFsSUVyTWJod3FK?=
 =?utf-8?B?YkJNUEFkUXZrdlVmajZqZ1RmazFTcGphRDZpSnQ4bTBMejhqeDhKay9heVly?=
 =?utf-8?B?aXFyTDJ3WGJidVRYY2hObzdHZ1FTNW1kT0dPZ013V3NrdzljZnVGbmJDNVFp?=
 =?utf-8?B?NFBxMFAzZ2tHWHZyaHlwY3JyYzhEY0tUelJhdXh0SVBpZjhocnhldFZQTFdZ?=
 =?utf-8?B?VUlrQnVSSVNkNzBDY3BEcEJXaG9tcHNEVDVTMVN3K1VYaFNpS3lMNEppeEQw?=
 =?utf-8?B?S3FrbGQva2I3ZFdrN2F6RFFBQnlxcldqOXRPeldaQ2FDYjlUdVZ1SVZ6YTRV?=
 =?utf-8?B?Nk9yWEp1aXEwandIYkl6TkdEU2xwT0N5NTVsRnRXT1NWNzJsMGMrZDJNRFRB?=
 =?utf-8?B?WGMwLytJWXd6UytrSisxRGp3aldDWFBXbW1STXVMTlk0K0lrbkZleG5UdzJ2?=
 =?utf-8?B?V0xDR2tsd2VVT0oxdXRkK1lLUEpPUWd5RnlCV25PSEIzRkJwby85ellZM09E?=
 =?utf-8?B?eGpjQXZOQTg2MTViNnNscmhqL1JUY3lpU25GMXl1VVNpN1k0N2liTGNBdyt6?=
 =?utf-8?B?YjdCNXVKK21nM1NmUUE2MTJYaHFJQ0tXTWRDcmNQdkNlQzZqZHpuMHdmMnRG?=
 =?utf-8?B?ekhXTzZWQ0FtaWgxK3R3djd5ZFpiUE9CNjlIQmtnNi9XTkNYUWFCeUh6OGFF?=
 =?utf-8?B?TlppZjI3L1ZyUUozaTlYOERBVXpMT1VQRU4vbEJnZlBIeVpIM2p0enU4bGph?=
 =?utf-8?B?MWhIbWIwc2pZdGliZ3l2UXE1UzdleEVRTGcrbm9oa2hVY1FuN0xYVGpUUlZl?=
 =?utf-8?B?bU16aG9WSkN0NFlKdndZeTVLSjl0dXV5cXhXVFJyZzhFZFVIaW9CNnZMNnRk?=
 =?utf-8?B?KzFtREswbXJWdTJJdWtzTkRhQlVOZkVyUG54dFlpU3JYbjJpREwzakVFOGFR?=
 =?utf-8?B?aG50VzNEUTBmVzN0NkdMWGZBVGpXRGNPK2lqSkEzSXlpSUFWdUx5SEc5eHQr?=
 =?utf-8?B?NW9aMnRKbm5Md2xSaEdzaHZMb0Z0cmRwUW4wRk8wTFVLQ1FHUkJSb0M0RXdY?=
 =?utf-8?B?SWhPcXVEcnU3Vlc1WXZSUDE0YTQzVG0wK3YwaUVoNFdQNitFSUh2QmpiNWJO?=
 =?utf-8?B?SldPL1RabDRqRnVVZ2pBSkhSZ2llOHd6R1gzKzdkYUJ3ZEliQ1VvU3B5cU5M?=
 =?utf-8?B?T2tOcGR6WHJpaUZ0aW9mMUtrZFdkSnZEQkhGbVdiaFdXN1VKSksrUzJaNXhx?=
 =?utf-8?B?RlR4NE5uQUw2c25wZWlyaDVaRE9HNjNzNmR2eTdyYTZWSVVHMW0wNUZ2eWlR?=
 =?utf-8?B?MTk3WFZSZjBibGxScGFVdHJmMjF1V3k2eEpoeW1reC8rY3ltWVJpUmQzZDV6?=
 =?utf-8?B?U3g2aTJnWlJzMU96ZWRjQThXbE1aVGwvaHVMc1hKYU5PQkt2OExZckhuOFFm?=
 =?utf-8?B?aTl0QnZqQUxlUHpUWmtWbllGMXJLRmthdmpyMFh1U056UmNXK0NvaDBsakJQ?=
 =?utf-8?Q?edwxKtgqN/XRr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 05:59:32.9066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca9c49d-50ab-4c9d-b943-08dc6d91b388
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380
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

Check the ring type value to fix the out-of-bounds
write warning

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 15c240656470..ad49cecb20b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -352,7 +352,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	ring->max_dw = max_dw;
 	ring->hw_prio = hw_prio;
 
-	if (!ring->no_scheduler) {
+	if (!ring->no_scheduler && ring->funcs->type < AMDGPU_HW_IP_NUM) {
 		hw_ip = ring->funcs->type;
 		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
 		adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =
-- 
2.34.1


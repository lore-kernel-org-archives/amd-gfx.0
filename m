Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15FAC2D0CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 May 2025 09:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F1A610E217;
	Thu, 15 May 2025 09:24:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fBUPHHxA";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C17FE10E217
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 May 2025 09:24:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8W3NFsNUC/akeS+vYqFKeIdZx47YMw8xUGShe/ssyLwrRbtiQd7gW4qzz+h1MU6t4dmQi8FII4qrAyyisLHvUwPL7/zFXJGsqzDTAxuAQw2oKf4FIQr/CaOSyiqQWJlm5BjvGCypVAaNXK/4iJS1nBHpBcAITYfSEMXtaeTGN2Wgh40hdOg8Y2aRSfoHJXDihddRXevVYMQJD9aav0AAiFERWH14ffBWcHl/bLeQdqGUnzxKHX+RhByJo9DqKgIKFtKKrqrPvvn/X1Rd0rGPQuhwDa0SSm6U8ZtiqtbB9vbhpuOFCGHGyw5jSVpEnlA//Gd9NByUc6r4WVTIxf28g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXDzYWVzrpS2dXs1mq2cf6A/6OaN/owywjxict/wL5c=;
 b=uTH9gaIqi/GH3ej3bFke9e76th8gzK9445HFiTQmUFGEvcowDnyu/kP/Ixca9mL1dXEaYwcG/BArhmzj4LhTwjWFviLP7qIP0er6AES8f1/fv/u9D5M2J3GU0sP/rgZrAy1z8quUtJJGbXEqFKjKDPgsWwelfkBAs/scH4GD5694zBHp/agzBZVpm6YXGpRhXgW1StDsWTbjGZOXxZp0110XYcKuih1W69Zu/TEsBSs4xYWtkgnPBq+tNU98LLGVhld/u3rvX4MyqZQ8oNOaVyvmlXCRyxeWEh3yiWEWHlGVfO8GuUBoY7K4VatjXgt0FQV+KsO7S5jSAteIrHYV6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXDzYWVzrpS2dXs1mq2cf6A/6OaN/owywjxict/wL5c=;
 b=fBUPHHxAcQgmtnvmGsG6Ms5rxbIZphhonaFenMBh+pmROi5n+KPKThoYR3/b2fIg69Wz8ctodBsdDy+pnLfTHuvd9BmuNT4YCtzpx8mk9P/ihwpWLizoHnYrRpAw5YLmqvRGjlbs5SawoKOSdk2Y1C/n2/OZ+HwUNZGoe9yMaoA=
Received: from CH2PR20CA0010.namprd20.prod.outlook.com (2603:10b6:610:58::20)
 by DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.29; Thu, 15 May 2025 09:24:32 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::7a) by CH2PR20CA0010.outlook.office365.com
 (2603:10b6:610:58::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.16 via Frontend Transport; Thu,
 15 May 2025 09:24:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 15 May 2025 09:24:31 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 May
 2025 04:24:29 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Prike Liang <Prike.Liang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Arvind
 Yadav" <Arvind.Yadav@amd.com>
Subject: [PATCH v3] drm/amdgpu: lock the eviction fence for wq signals it
Date: Thu, 15 May 2025 17:24:20 +0800
Message-ID: <20250515092420.663226-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|DS7PR12MB8324:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e360428-3f25-4d07-c515-08dd93924cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHRVYmtoN3Bic2VzSjdkelJodVpNaUpleHlrWDhLNm8zL2tVOUVPRklqQWdq?=
 =?utf-8?B?OWd5eWV2c3BHQm1BOVF4MW9SOUxjS2RlL1FHM1krTFRQZkxSZ3F3aWpkMy96?=
 =?utf-8?B?MkxEQVBDVDVhK3c3L0ZiOFhqR0tZaStDK2RIYlJxZWZic3oyd1NRdnRMVTJW?=
 =?utf-8?B?TnAxcGVXZDRkMUdOR0lXNUZmWTA5L0hHMVVJbHFzL2ZremVFMG5vSS90ZWhE?=
 =?utf-8?B?cktaUlpYUmd4eWR6NTUyUk1SM1ZVZ3lFREZ4NkdIekM0NzczQkxWdERMcUxW?=
 =?utf-8?B?dWU0ZUNvUDlVUGVnSGNVWGt2di9EMGpXS1FSOVF6SUdQbDVWTzNtNmY5elFQ?=
 =?utf-8?B?RXVyOXRtOFViVTFsYXBFb09Ja1hsOXd2VE5nRll6REZaZ1A4RVcvUnNMWjRq?=
 =?utf-8?B?OUF0dTRXSFFtZDBJazhGK0JCSTBEMzNrNHMxdXc1SSszeG5lUmtXVCt0OE10?=
 =?utf-8?B?U05xNWJvQXdvd0ZiVHVrTXlydkJFanRoNXVoVVJRTDZvS2JpUDVGb2tzT2hq?=
 =?utf-8?B?cTFDQmhJTjFpZ1lXUWE0MmhNOFRZZ0t4Slk1a2U2Zk9oZWd0ZjlTZHNpVHlK?=
 =?utf-8?B?OUFxNHM1bjY4QXNnaXZJMlZieGtDUXd2dzUxSXN0dkhwaTNuU0gwVzE2RTdq?=
 =?utf-8?B?RzdYYTR0OFNaNTNTWG5kTUZMWDFjUEFSWFBENnJTWU9jQlVjaDhVWmZqVkdS?=
 =?utf-8?B?NThKM2tnOVZONlgvYWkxOHlGc29uOXhGOURIU3V2NHlhVG5Ka3dMNWZqWHds?=
 =?utf-8?B?SExvbThkSjEvTmorNVRHZStnNldlcjk3UWVVL2V0cm9QMGJOUTVXanFueHBZ?=
 =?utf-8?B?R01IS3YwczNUdCs3N3l5ZVhONm1VOUQwUU9TRlA1alRmMVFrQkhLUTBOd1Zy?=
 =?utf-8?B?VHhGL280MnhRbUZRRHI0SWE0NlMraVZHVzhGQUFLSnFydWFrZDNWV25ydW8x?=
 =?utf-8?B?bFlOMWxUQlVwV25OS1F4bVIzclhGeWpYUVUvZGZza2N5K1lUVG1FRndvSjdT?=
 =?utf-8?B?eDdTWDhzKytWMWtKRWNUSVlRT3dQc1JCSTJBNHN2am9ldHpwZU4xQjgzMzFU?=
 =?utf-8?B?ZFNQai9TS0VBYjFqYkFpUUtkVndtdU45VFJrampIOFI3RWRpM2cxQXNiYlpk?=
 =?utf-8?B?K2tsMkFuSGRuOHh6cmZXMHY4dTd6Y0kxUllEUFNYNkw4Sk9NN2oyNStmYWwr?=
 =?utf-8?B?KzRMMSs2YVhManpNUWxCS2F4U3ZGa1UvMlBnMy9lcTg0ZHJxOHhudmtCQ2wr?=
 =?utf-8?B?aDhLVmV1V0cyNFp5Qk9TTDRyek53ZTgzczQ4U055bUVzcnBNenBDb2toOERT?=
 =?utf-8?B?R3lITE52RUZhbWNlZ1d3T2t2WjAwbDBBWFVhTXI1dmpZSHVWUHp0MDA1dFZt?=
 =?utf-8?B?c0NtWDJYOGFKOWhibTU5VVMvU2lOUUJkYzFmKzVlVjdNMHEyeWdFdzMxbTZP?=
 =?utf-8?B?ZWtMS2RKRGRNQzVWNG1xSjUrYllhZ0xGcTJQWUxkUWdWNjgrcmpoanlQUGlq?=
 =?utf-8?B?TUJOMWVKUnJKM0NJb0l4am1QWlVuNVdwK0hBYU1Lb0hqSVB0NTN6ZzhaTEFo?=
 =?utf-8?B?V3RJNzBxZ2VDSDF2MG03dm1DWlVEb3dxS3cxSVdpOHprUDVNbkxpd3gxRVgz?=
 =?utf-8?B?RndhSWJUNkNpMlhxaTJFQndDM2hRcTNzMTdDUzFiY3o5b3dKUVd1dEVHVWZj?=
 =?utf-8?B?SVlKU1BxMk8venRZRmQ3QlhwYW1aV1NaQ0FYWGs2SkpJSjl1dnFZZU9DV280?=
 =?utf-8?B?WVJNWmZueklSRHpDSWhtY1dMVDV6aHY5QlNqMTNDaDVUTVpSK1ZSSWFldmVW?=
 =?utf-8?B?UTNUOUV6MklQMkRRblF1Z1RjM0NJb1RUU2RrU24ySk40b3FEWURsTk04WWht?=
 =?utf-8?B?aVorbkFYUWUzN2t6SmtTRVp1S3ZUUGthb3VoQzlaVVJiSDZzZHBkY29udzQ1?=
 =?utf-8?B?eHNSVkxpQ2ZIQTlGOXM3Y1VVMHB4b2FubWxOOTN5VnUyQWxhampTVkpjSDk4?=
 =?utf-8?B?VXp0UjhhSDJRcGQ3OHF2L053RFdUZXlEYVFSeXhwWkFBUml0S2UvYUJTTHg4?=
 =?utf-8?Q?3SVWBt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 09:24:31.8408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e360428-3f25-4d07-c515-08dd93924cc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8324
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

Lock and refer to the eviction fence before the eviction fence
schedules work queue tries to signal it.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Arvind Yadav <Arvind.Yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 1a7469543db5..5b5d45534d79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -108,13 +108,22 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	struct amdgpu_eviction_fence *ev_fence;
 
 	mutex_lock(&uq_mgr->userq_mutex);
+	spin_lock(&evf_mgr->ev_fence_lock);
 	ev_fence = evf_mgr->ev_fence;
-	if (!ev_fence)
+	if (ev_fence)
+		dma_fence_get(&ev_fence->base);
+	else
 		goto unlock;
+	spin_unlock(&evf_mgr->ev_fence_lock);
 
 	amdgpu_userq_evict(uq_mgr, ev_fence);
 
+	mutex_unlock(&uq_mgr->userq_mutex);
+	dma_fence_put(&ev_fence->base);
+	return;
+
 unlock:
+	spin_unlock(&evf_mgr->ev_fence_lock);
 	mutex_unlock(&uq_mgr->userq_mutex);
 }
 
-- 
2.34.1


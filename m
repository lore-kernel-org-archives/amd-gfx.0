Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC26C3ABC0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 06:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9998D10E194;
	Thu,  8 May 2025 06:20:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aZ2cGNy6";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AED210E194
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 06:20:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alzHGuE+nD0dWXy9p1VT/JBOU8P6MdTsNYW1vGjTn59oep4m65Goo7sFXKrkYYJps9xaol8b1pQ9hznTEpWn4hk71a0Ad+wNNd8bjREE4s30BEn1RR+idb2hpxHAPinnGvMhL1GQfdRxXaX/4PzR8KAlPEmvr+53dwURYkNcz81pp/zaxZPO6r+1VVpTS1aB3OJE/tO6VRWqJChrENq0UedpsdeThaK7ysQYIg2zuAxZYPmjt9BY7+PkFvjcQ/HWYjyZuuo7vL76cZUAq7jJP3IThXMeRQIAsmDwpGwqMYpFCPYeeOP5lQiuPEX7YGOi+2iIuJjTgN8ApDGJ6xnWPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlwdKHLd8kX+GzhLJoifI/PlcptS5zQur1cHuz+c1C8=;
 b=XHgM2/mgShE9RBPlYZH8rTncCT4YwjYLeCZ+08lyh0uXJeuHe5p68L6fKL0Pb2RcirAgsqP6qizhGmii46RNHzKjj4eGyAbD9nQWpdOQNoRQ1AhFt6u2VaA8fqmd+JrzLUlejGZgXhdiWgE8sh03LONG8fj1INBxKQJp90hNCwOF45/y5aJoeDXn8m5p6PsAQ2H0P9C0K4N+OXkIEBMPDs7+hzAz9Vml7C2JjHPlcz16eHwzmI+x/ONKE3+xQ5xdPJTsrlFRwuGJRnN+58H14hfaMz2MJg6X4ZGzmH6uL25a1l5y3plMmysQGa93wF0vagYPYgNecsyCbXSpHAQLMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlwdKHLd8kX+GzhLJoifI/PlcptS5zQur1cHuz+c1C8=;
 b=aZ2cGNy6TAWy+WUegmJTsgM4/F0JvHZCZoBut5Y2qb/MzWMfhWNjrQ628/ssf/Nw3iWl95t6RHST2fgKZNOOthDPj6CScVUZfzsws/GGrIo/eygeDboyvyzT2Elbiqp7kv6ze6aqiaTFcWjqGWkJjIQYpOOaxAoW2jPUNrIp+T8=
Received: from BN6PR17CA0056.namprd17.prod.outlook.com (2603:10b6:405:75::45)
 by DS0PR12MB7605.namprd12.prod.outlook.com (2603:10b6:8:13d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 06:20:33 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:405:75:cafe::13) by BN6PR17CA0056.outlook.office365.com
 (2603:10b6:405:75::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Thu,
 8 May 2025 06:20:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 06:20:33 +0000
Received: from rtg-Splinter.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 01:20:30 -0500
From: Arvind Yadav <Arvind.Yadav@amd.com>
To: <Christian.Koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>, <Arunpravin.PaneerSelvam@amd.com>,
 <dan.carpenter@linaro.org>
CC: <amd-gfx@lists.freedesktop.org>, Arvind Yadav <Arvind.Yadav@amd.com>,
 kernel test robot <lkp@intel.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: Fix amdgpu_userq_wait_ioctl() warn missing error
 code 'r'
Date: Thu, 8 May 2025 11:50:15 +0530
Message-ID: <20250508062015.120380-1-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|DS0PR12MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: 463e64a9-3b09-4487-cb28-08dd8df87072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3YrRmtPMnYrMHpqck51eEhhSUlvMnRmdFZiNklTYk16ZTZ5bEZ6eGVaQXhz?=
 =?utf-8?B?c0JjZ2VMNzkwV29BZ2pGUUhaTy81NUluNExBMzRZSGcwby92MFI4cURodmlX?=
 =?utf-8?B?UmtqZTBmZS8xbitLbWVVRXc5MTVpc1VzakdNQkFUZnpmRGtzSjJGM21CWnFs?=
 =?utf-8?B?S0RWVy9RUHNTck9SWDZFTGsvWmpTTkU1RWwrNkc1aDJtYURGNGw4d3EzU2xG?=
 =?utf-8?B?RGNTazlzdndHYkllVmFxckE2bGVpL2tSL3Z1cUgwOGVxdmVvQWhac2NIZWRE?=
 =?utf-8?B?NGp3aDdZSFRLSGFUVi9RdkRZRnNMemhUWlNMWWROcS9hd3d5S0lsM2NlRFBy?=
 =?utf-8?B?TzRvcVZVMkM1dk03SG1ZWG51TTlKR2picjFQazlKL0Fhbk8vTFN5MjRUTWo3?=
 =?utf-8?B?WjVJZnJ5dDVaVEFHYVA5Z3JmQjU3VjBXc21ZZTBUVFJLWmY5UzJaeU9KWXIx?=
 =?utf-8?B?Q2hua3lCL2Raek02NzY0MzhJSmNQU1BIczZxV0RsOFZWSmEzZ3lQVmhTekNY?=
 =?utf-8?B?SE1ySGVJTE9uZHdINnk4RVdPMjRNSHVUMnhmTkREc3dTRHVUOTlzcmIwRGxU?=
 =?utf-8?B?NDhnVmtHYWxXUm94THIwYVpGNUZIQ2JlNlZEbjVRSVdQc3ZFRkNvbnJ3eGZn?=
 =?utf-8?B?cFhtSTVFMTNhaFlhNytXTE9nR0JrL2pjejE1djJXcjI3V1JyY3ovQ1lVRldY?=
 =?utf-8?B?UmZibkVObHNhTkYvVVdoUGtVUVFnbk9PeW1BSmR4WE03OWlwajVwcWZkazE0?=
 =?utf-8?B?cGUvSHIrajNKYjdwcVpaRUt4ejNRajdidW03WCtnZ3gxMWhneVUyWWpDSldX?=
 =?utf-8?B?V2prQ1Z2ejRjN2dqS1ZMNmVPVDFvSXkyYTNyU01vQWVjMXRsYUhEaHhZdTZm?=
 =?utf-8?B?V2dVdVJPdm1md1h5czVyUzlxK3JkQkUxRVRwcVMwbUZabCttM2FHR2NzZlhw?=
 =?utf-8?B?Q3dWTE9YcTFmYlBPL0RmQ3BEWCs5ejFZckxkRDQ5Wkh6dlVyZDVremRLb21s?=
 =?utf-8?B?bWJrMGNWZklyRXUxQk1uZDREa09ZVWE5NFR5VmJiRGQ2U3ZkemNGbFd1OG1B?=
 =?utf-8?B?Kzl3TDJzSDY1OEo2VFJmRXZTV2VlYTVNbDRqZEZoRk5BUzZyY0VmQjFOTmZz?=
 =?utf-8?B?VjJSaUZ0RjFCTjFrOU1UTjA0aTBTNVhsR0U4UUc2d282VUV4a21URzM0dktS?=
 =?utf-8?B?U2Fsc01OT1FRRWRXL01hSUxiekZ5WlF1akpXdFhudFk1Y1l1VzQ1U3RHYmFn?=
 =?utf-8?B?U1kvNTRXL016Zi9DSFVidTVPTGZCcVhVTkdyeXVmaVpNY3JwOVJmaWdFbkdX?=
 =?utf-8?B?Qm1FWCtHUzRwcjZEYUJmZEJQNmQ4TXNZY3FielVBeU9wUXM3TEFIdGZqRWN3?=
 =?utf-8?B?WUYzT3dyUXIyUFV6Zi9SR090d1R0dnF3Q1FIa1J5Y0oybEh2c3gzcktIYUVw?=
 =?utf-8?B?Q2JGTHZUVjRZMkxOQlVYV09TTndDN0pINWh1dmlWT3NyTE5RUjVEREtJc1F5?=
 =?utf-8?B?bFYwVit4NmQrZExvaUt5KzNQTHpvc2h6bmlKYjFkK05acUtSTVY3TTdjQzFn?=
 =?utf-8?B?T2Vya2hsVmp1VWZwd1oxNDZMMmRJR2lSdU55c01ocGZYOVFwTlR0elRSMlI4?=
 =?utf-8?B?YTMxZlhEZVd6OVo5dFpGS0ExYkFvQ0UrUm5jKzZEQVhteUgzK25yZGNPTUpW?=
 =?utf-8?B?MmJYdXpFS1VILzh5cmR5YnNxNGRvTDU3bzJHWE9ES3BjS0gyU1NBemJ2Y2Ey?=
 =?utf-8?B?TTZKaDhZQ0VJeXlybEtHSHcwSThhZy8xMENzRThZWFhJUkpEYUlyNzlxRklq?=
 =?utf-8?B?MHRaeXBVWm5DME9qYWlVVkpvaXF2eUlhWVVsSU85b0tUbFVjRHNkdEx4T0xi?=
 =?utf-8?B?VzVLVG1hRXJjTGQrd2hKaFllT0dlVTNtR29UU2tDTjZsTXByc0syTi9FNnVo?=
 =?utf-8?B?d3dvSDJvdEZCdUJQdE9aVTlSWUIvaUJHck9CNE5LUDVNaE9IVFhsMW4xZEVJ?=
 =?utf-8?B?a1Q0L3hyS0dkeEV0a3NkVnp0WnVzYkZ1TFEwQkk0eDI3N3pmaUlTbWZRL09h?=
 =?utf-8?Q?Kn1khS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 06:20:33.3985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 463e64a9-3b09-4487-cb28-08dd8df87072
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7605
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

To resolve the warning regarding the missing error code 'r' in
amdgpu_userq_wait_ioctl(), assign the value 'r = -EINVAL'.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202505080458.rnV8YfiY-lkp@intel.com/
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 3288c2ff692e..84b052dbdd6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -852,8 +852,10 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 		}
 
 		waitq = idr_find(&userq_mgr->userq_idr, wait_info->waitq_id);
-		if (!waitq)
+		if (!waitq) {
+			r = -EINVAL;
 			goto free_fences;
+		}
 
 		for (i = 0, cnt = 0; i < num_fences; i++) {
 			struct amdgpu_userq_fence_driver *fence_drv;
-- 
2.34.1


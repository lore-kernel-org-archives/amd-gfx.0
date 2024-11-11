Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A67D12D52
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2024 02:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3669F10E07C;
	Mon, 11 Nov 2024 02:44:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0nl8Ia3W";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DFBD10E07C
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2024 02:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyIm41x26FiSgnCa9zIogN9BBCVIQya9AEyOVBXzYC/0PeNeRCB/wGwL67iVtldSbZmDP0DtPf4HDwleGJUeV+xq/NOwlsVtH2KOt5EavWQEgJJ2HEjhejXz/7jmFl55p94k4kaz0sHUtO6kCt0xApvURP8ULJF5QQmAWEF7F8roc+t+X+TaYGL25zu0Lu3QsS9G1aeQgJP10y7KAkeBOfhReKpzhQ8THonmQxgtlMoLGwR70+I/diWrYlCywgse+hMB6MKFWlhTF/g820hfIt5ZbsssXMHW+UYFjugZ/P/krtys3VJ+8dv09t4rtTf8hgFnF4Xlohat80DrhDwrWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZXtFVKwCOYarjMrggozSWNG+iccBAbFEG9pNpyTtp4=;
 b=Pb0pGmpV4oAF0ZHeLxOU4czN1+LSNH8Rd0MIn7B4fGkiQsI3+rUWOPD+6AbADUZiQeeht989ljVY1mSGTzPNrHPNN9FZDAxd2a8UNx0CMbJnAYL93FbuSN6ta5QBeaCCWQdP1zpi416iZZXMWC1uAcap/wWMrkgIcrUdtu3f67uluA+tZFqPsqksm9DQUQze9MISh3xfe8RAOtTJylHRoPkpGT4CLHdmNFJSNi9u9aRwoMhGwaGGKFJEkvJIogAHJqpoCLzDwpZbN3M44R+62L19NUtvTwvC8YchsiRi24hcEKoYIqaK4t2qUicDqUvMEJtu2HLNaCxqIrENkdVBvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZXtFVKwCOYarjMrggozSWNG+iccBAbFEG9pNpyTtp4=;
 b=0nl8Ia3WA3yIjle33E3wPEnEmF7sjwQb5Pt4Ck2JOgMmayc3oeVbSkdUx2gceKbb96Xr7G0cdb0rND5UoB0b7oEqYBBAl4PTgYNFOFLgTC8+XdncLzmlQFQMe0MbIRnoJF2DXOmXb9nM3m/tdcZ9AMJGSwzLbQw6SF+T2cdMP3o=
Received: from SN1PR12CA0049.namprd12.prod.outlook.com (2603:10b6:802:20::20)
 by BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.25; Mon, 11 Nov
 2024 02:44:10 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:802:20:cafe::6e) by SN1PR12CA0049.outlook.office365.com
 (2603:10b6:802:20::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Mon, 11 Nov 2024 02:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 02:44:10 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 10 Nov 2024 20:44:07 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Add missing kdoc 'gpu_addr' parameter in
 amdgpu_seq64_alloc()
Date: Mon, 11 Nov 2024 08:13:50 +0530
Message-ID: <20241111024350.1881077-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|BL1PR12MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 819a4210-7223-45af-ec5a-08dd01fab83b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVJ4dGZ6emlaK1RPYjdVWThQNGxqSTYwTFhTTUxNbUJVWDVEUWhHeGMxRVY2?=
 =?utf-8?B?WVZRVHM3UktNc29KYWlSUlI3OWZpNVRjK2dKSWkvK1EvVkV2MlNudGgwalpU?=
 =?utf-8?B?Y1RxWXc2K2hBaTNwZVlCTFFlWjNvMGxaTXU0YmhJOVQrbVYrU0NyRTZEZTdx?=
 =?utf-8?B?d3A5Z3ZmOTZSa0p5YTIyUHIzc05nS3MrMGlPYWUwMjFNNlVVRWtZWXdNTFlB?=
 =?utf-8?B?bmFRUFBaRm40Zldjb0pwMllBdmtOUkd3QnFMYWpEMnVWSFBSRkVXWm85Uy82?=
 =?utf-8?B?ODBaSFRRWEh6Z3h0ZU53aXkvT0V5RXlmOG9GS0JoZ0JwcldsQ3Q4emFLWmZZ?=
 =?utf-8?B?MllVa1hlUk03Nkw5VlB4TjR5eDdUN2N2SnhEb0MwQTB6WmpGLzZiTDlUdU9k?=
 =?utf-8?B?aDFZRWgzMXFSNWw1dEFrMlFVZUgzYWdKT0oydzR5RGRTcU5ZMkhiU2htenVr?=
 =?utf-8?B?RnlPZjl6eWViYzFyOERTQXBPaG1yTlFjYzRLRzhXU0tlQ1paMnRobDhkRWlY?=
 =?utf-8?B?bFNpMk12Yk9tVTVockJxRkczeGdTbXBEbGx1L0dYSFlIK3hKQ1FQVUZzK1B2?=
 =?utf-8?B?Y0VSOStBQW9EMkpjbDdqSXl0U29QUGxQaG1uMHhRYlBUM251NWtxanBOTVdL?=
 =?utf-8?B?L1FBZmpGMDBIZHBNeFRreWEva25yRmpFZzJlNWRUWGEvSTMvbmUxNGNrLzN3?=
 =?utf-8?B?SndxUEM0U1RrZHdoa1p1VWt0T2pMcVE3dGdKckdoL0ppeGNjV1AvUUE0QVhN?=
 =?utf-8?B?VXNPeXhCMEh1V3Q3L2Y5NU9ZdHczODdOcXFLVFhsYXN1ZmZMQ0xqS0pYdDFU?=
 =?utf-8?B?a05VdE00QUZvOFhIYVVDZUl3Sk5mQnpLUUhZTUptS3RwMy82OURsWWFYTUtJ?=
 =?utf-8?B?MmlNZ2I2Rm81a1BsamcyVkNFQ3lHSlZ2ZXdEd2VCbm5kZUhQUXU3bjcwUlhi?=
 =?utf-8?B?VzYvWTloR3gvdlBFSzJBSlFVRlkvcDRLcWl4U1R1eUZVQzgxQi9tTXNpdUJF?=
 =?utf-8?B?cWhFMjZIb3QxaDhXYWNjS3NZWjhlZENTamg1ZG1MSmpXT0lzUGR4NEFrZCtj?=
 =?utf-8?B?TWl3MWVVTXFCYkxZWUYzeExqM0EwcjFXLzB3S3VSNnIzN2JMVldNTEpPNEVa?=
 =?utf-8?B?b2RZbmRlbXlrZmIycXQrNjNaU3BGeXlXd1ZSZEp2a2ZGeFpnTUh4V0JjVlNQ?=
 =?utf-8?B?eEVIb0tZamk3WGEzM01rdTlYdUt0cFZrbDVaSGE2OWZlQmplY3dJdm5oeVpS?=
 =?utf-8?B?NGJldFlBSVRoZEhqa0V0TnpmamJGZWR0ZGk2NXZBS0dRRnNHWkhLdUw0RldO?=
 =?utf-8?B?ZUljREtCZGtlMmRhbW1mYVVFcEJQRFZRNHpGbXZJaWxMVUc1RlgvZU5Vbzcy?=
 =?utf-8?B?bGpvSVZBVHhhZllKMkgwWVBOUGgzTjFqNDBXcUFOa2FIVWNacVV0aEFiZEdh?=
 =?utf-8?B?dGtCVHpLRjlFbEJ5R0JXYmtJdVF4bUl1ekh3ZGhqV0xSVHkzaW5LMmpBRTBZ?=
 =?utf-8?B?TGRBZVhSSUZaL3VqQmlSeHptVWE3U0ZaUWpNZFVwdjlmUjJIOGtGT3d0OUd4?=
 =?utf-8?B?RVhsZ3Q0YWpPZUZtUWlHL0h5YkVGaXVnakt6WDlCeUp6UlBMZytueUlnS2xh?=
 =?utf-8?B?YXVTcEV6Z0hPbHpTTWtKYXNyRGJVMUpUYzRFMWRQMllCd0NUVkhlRlp5bTBY?=
 =?utf-8?B?MXFRbVk3RDI3M21uTm1iWTJZWlArSmpmanQxeEltZWFLRFZWQ2ZBZGJWV1pw?=
 =?utf-8?B?RzRTU1FYUVM2RjNOUFF5OXFMMXlsUVJPbmhjWml5UEp3UGROSXNMZ1QreVFE?=
 =?utf-8?B?cnE2SjNpVXFkbVFiVHYyTEcrOG5hNTF6YVAzRVRpRFRwa1Q2WTVmMmhNYWpX?=
 =?utf-8?B?dlI2M0VFRVkrUzNTRWdhRTgvM1RMQTN3ekVvRVRYaWk5MVE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 02:44:10.0083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 819a4210-7223-45af-ec5a-08dd01fab83b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5827
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

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c:168: warning: Function parameter or struct member 'gpu_addr' not described in 'amdgpu_seq64_alloc'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
index 0defad71044c..41ab2e2ccef4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
@@ -156,7 +156,8 @@ void amdgpu_seq64_unmap(struct amdgpu_device *adev, struct amdgpu_fpriv *fpriv)
  *
  * @adev: amdgpu_device pointer
  * @va: VA to access the seq in process address space
- * @cpu_addr: CPU address to access the seq
+ * @cpu_addr: CPU address to access the seq no.
+ * @gpu_addr: GPU address to access the seq no.
  *
  * Alloc a 64 bit memory from seq64 pool.
  *
-- 
2.34.1


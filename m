Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870ACEA3F27
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 21:48:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5770E10E5FD;
	Tue, 10 Feb 2026 21:48:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="idE1ZnjL";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010032.outbound.protection.outlook.com
 [40.93.198.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EFD810E5FA
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 21:48:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+wdnBfFkc2d8E8Y0D/0VamuE5x1bfkJbA+y+3G/o2ED/4lLZLBkYA3yWWbO/xOCBggy65GYuIAF9WOdkg0IqZ7rQEQuC9MZS0kkDcNHraTpFTNNNAKHcnxEA9UfcaBXOylE7oWUILxQSmdv8FCxwcDth7G+AwfCNTbEcv8NIKaCXpVhVkX1vjeAvPX+rYjoq5gKCZWNK6sRwB0CYKBDeFJ+B3kknYTcCbqeJyyYJ2X4mu8EbHhhVx2kWz01Z2uN+EdN10s0Z0HiCiHMY5GYlpN+eUQZyYbwEozk9cHnO8PfXGv1l+vU8T3agaB2XEJ1YsgZ8G56tWyflySg9Wgz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbK4QBE1XCZQpDgcJgPNoM1U6cm3OfqetOvtBl5upQ8=;
 b=v86wLI8zwRbILSt7lmKfIpKSKu/hFTt7/2JPujsdlbvIdqwHWyJepiw7EyhXvLlaYh1KoslA9uBy52rUDmG/twqD9a7tlPSxB+be1/GigmHdnHTCYE2vrBPZvDKoYbjO/RpX0ThIBv/BUpJ20HVEm/Xl5YFXGeyGaMZZvXR+VvhDhr3z5kL7ia4f4wbHxxf+Ru+YxVDmuazKP7HOzs/PFDRFDGyTg9N4xnVsT9hizQ9rGwKrapDsgOyJpdhuBv5D/vx12E0vhxS65reTH38/0XYv17Zlcq0QC/uclwtbx6++YYqbJkHl6p/I0WW+m6BtJQzTwo0ObQE5QxOd/5kT0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbK4QBE1XCZQpDgcJgPNoM1U6cm3OfqetOvtBl5upQ8=;
 b=idE1ZnjLt7FNeDm+kBer8uXqqigZHXltq4NDwUBQnDIeeN7PU2YDBYXMQ8F+xZEEtyrvrYUxbP2TLLyDaV1vlGGh6whKg/j9a3vF8gziRiErY6s7pu8NH50zv9PmaTwqhhWsQ+TM7NYe5cIgpmYKeEbxdvKq9ZgWJ7V8BqWM7NQ=
Received: from SJ2PR07CA0004.namprd07.prod.outlook.com (2603:10b6:a03:505::10)
 by SA1PR12MB6946.namprd12.prod.outlook.com (2603:10b6:806:24d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 21:48:04 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::84) by SJ2PR07CA0004.outlook.office365.com
 (2603:10b6:a03:505::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 21:48:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 21:48:03 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 10 Feb 2026 15:47:58 -0600
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>,
 <alexander.deucher@amd.com>
CC: <leo.liu@amd.com>, <Boyuan.Zhang@amd.com>, <David.Wu3@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 03/14] drm/amdgpu/userq: add doorbell size for VCN and VPE
Date: Tue, 10 Feb 2026 16:47:18 -0500
Message-ID: <20260210214729.80964-4-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210214729.80964-1-David.Wu3@amd.com>
References: <20260210214729.80964-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|SA1PR12MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: 5908fcb2-2e65-44fa-5789-08de68ee1190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1dOU2ZuTDhzdnNNZkMrYXBlN0tsS3kzRGEyZzZlT04ycUdGdXpaU3JrSHpt?=
 =?utf-8?B?RDVHMnZ1YjZURHFkcFFJVFVJc2dvaVI5dEROejY5LzhoUzJVVWc0U1IrOUhC?=
 =?utf-8?B?bjlmM2liV2dMd0FkVDJsdHlzZ2VzL0g0VjV3MGJmVndHMm5TR2pWQlZOc2xu?=
 =?utf-8?B?MXJXREJ5OFNvMUh2dTM4MUZZeEZhc2crYm9DdDR4ZjJhMnFiOEtVZENaajll?=
 =?utf-8?B?UjFQT0JJU0VKYWt5eHB2LzB4VTBmMTlGQnNwNWZLd0xjcjJFQkoxVW5Ra2VX?=
 =?utf-8?B?K1VnQk5RYldPMmdpVUk3UlVBNUtWalJWRXRuZ1VEb2NiNy9kT0R6cFRLd0d1?=
 =?utf-8?B?RWZ3T3hYTG9UMkFxd2NjVFlqOElWbHRRSXhWQmZsQzlFdFVmZS9CNTdUdXBv?=
 =?utf-8?B?V3pDS1FqblR4V0dwZTdJY3VyL1c3dzRITlF0SlFrd0FnVU9lY3p5TEVva2JE?=
 =?utf-8?B?Ym5paFMyd0FlYVdXZnd1dVBYN3kxdjdpd09lZURPd1FwMXpNQURDMzBRS29E?=
 =?utf-8?B?WFpwVkZoVXFTc1lUbDFKcnVlcWpNN29tVUV4T2pUYWRadTdwdnNCaElNWGFy?=
 =?utf-8?B?a1ZFd0pCZWZRRGx3QkNLUnhPeEZwWEZxRWRIUnRNTzFRVnQrK2prMm1MV1dz?=
 =?utf-8?B?d2xYWERReHc3VnkrYjB3anVrcXR1ZnNWK3gybzlKczhLaVlBSjhzTmlRYnYv?=
 =?utf-8?B?M1lsMmdvdU0wYVdNNmhuaFZnQ2tvckQrUGc0S2Y5eitscU9FVUtwYU84Vmwx?=
 =?utf-8?B?bGRBSEhOZ2Q2all5cUs5UXhpaGR0MjZISWJVRkd2bDZBZG5NQlREa3NrenNZ?=
 =?utf-8?B?R3g3ZGJtemlnKzh4by9QV3k1MVc4bXdsT0wzcEcrNU90c2hiL3k1dG15RHIw?=
 =?utf-8?B?cnpobmNBVW5tRjNDZXhFS3ppKzBwd2dEWGhGMlp0RUliVmVFdDFmMUxwQVFa?=
 =?utf-8?B?Y0hUd2hkSW9nRnA3cXQ0cEFJRE53cUJya1A5SG5jOEwzaHNwWHBOQnVzWGlV?=
 =?utf-8?B?QXE1L2c1VWZrQjBnZUNHQkVxWHFxeXJqSHJyaWJZNW1LV01pN1YwTjNyNm5x?=
 =?utf-8?B?Q0t1ZkFlWFVoOU5Eak00ZXFRYWJxd1phdU1aaHFYVlplVCsrNTNLdktuUkhk?=
 =?utf-8?B?MUx2anBkK2dBOGs4dWhDT0xvMGtOWTZDWUVFZ0lva3ZIdUZzVWlQRUVKL0c0?=
 =?utf-8?B?V0cyN1Qzd3puN0ZyWC9BQ3BkMjN3UUdPd0JqTWpndllhVnc1a3Jyd1RMN0Nt?=
 =?utf-8?B?NXBxOGRJRXFGSkZNa3h1cmwwS1VDMWZBcWN3TTBPRll0QXpRZ3hJdG1zTXYx?=
 =?utf-8?B?TnpNM0FqV0FhVHRxdFVtQmprT3JDbUp5OUp0WGdXejZ3M01ST0xWdGxydmRt?=
 =?utf-8?B?bWRLUUgydnphMUFwNGVuOFpNWGV5UlJFNjJUYWVlaGRDQUFGWTFXeDM2NUlt?=
 =?utf-8?B?YS9rOXBPYkFDUVVWeVY2aHkrN3lvRTdDTjBYYmVtQTljSEl3WWxYaWRIZGpW?=
 =?utf-8?B?QWR0WHNVYXpucyt5S0dwejVrMDlETE9md1ZnZG1SaS9QZlV4WFY1L3UyTk0w?=
 =?utf-8?B?U2NmbDR5ZjRoYkNVYm8zZ3Npc295YU1iSEdoNDdhcmxrRzR2MjdtRzZxMzdW?=
 =?utf-8?B?SCt2TEFxN1RKZm4xY0NNeWJOby81QlNJbGdUczdldmhsVWNzMi9adU0zK3g1?=
 =?utf-8?B?a2M1WFRLWHdJMlo1TGQ4by9vSVZMb1QzUUVsZEJLeXdvYTgxR2Vnb3ZyejJS?=
 =?utf-8?B?eGY4TDM3UTlwYytqa1NzZGlaay93ZjRoQjN5dFU5eXdOditsSEFiNjA2M1g0?=
 =?utf-8?B?S09CNHhMVFJBYU9rMkVpWFNqNlhpbTZhb2NzYW50dE5DRVljQWhDZ2FnUG5B?=
 =?utf-8?B?QnM1cDdWUnp1bFJ2YVFWR0RpMFJ4L1I1ZDUxbHRuQlRwQkxMRzdqUzE0dHlq?=
 =?utf-8?B?ZGF2Ym5TVjduRkk5Y0ZHSTNWbUE0UXFYaHJZNWh2NDBOTTExTUFQUndWN1Rj?=
 =?utf-8?B?YTdmSlJyOTIwWHlXMzFSVG4xRVZrRlhJcGVYU0dVekpacktEQlBkVDJ4MUZS?=
 =?utf-8?B?eWxNazY2QTBURmExZUVJcGY1VjNVTUpYQW5ya0pTNDhCL0NWMWg1NFUyS3Ev?=
 =?utf-8?B?RkFSdk40cG1lY2Y3dXd2RVo1ZVVxc3kwa0lDdjhTZGZDQnNTdVNmTHB0RWFH?=
 =?utf-8?B?dnNXcC9RbHJ3azBLTURjWlVwRndCY0lQeWtUQWpVc1h4S2xZeWFQNzVEMWJ5?=
 =?utf-8?B?SW5SVndZNkI2WEZ4K2RZWDFFUFp3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mjIPJipq3YDtB68V+5NVaSdh3panp4cQZgX1E+JoTmPkaGG4eZV+0wvRkhpZbRwoohBhl1WlqL5ObI25kKOoJO5dmJzti0752LHYPnBUlpMAFau9+fQHcTtJIF2e+cyQfXY06KyIg3prw6HnG1uhCqN/nJQ4uPxmGtTupso2XnPd2+Az5nkZ/FZatb4d1EpwMJFI1mKRVWViY1/6M04OYbuJRtHkDyKtDpg92zWj/w2TaWe0UhC5Z+qAbDBcL1OvzKOcQGi+xaKvO/Pp8Ryj18Zw7fC5BuOosLqrZpEzwiKMrohkZDqhvLLbzxr3qDPbhN/zmELxwOEMZKOLV5CoHLwDSaWipQRhZRd2BfiV8/OETlqKytDAlGEMV/awym5QjTuCLFIRkVlz1/PlxrH4P2itYzI1htmjnOuP0zKwKxS2jrfU3z85izwRj5MXrmTP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 21:48:03.8023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5908fcb2-2e65-44fa-5789-08de68ee1190
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6946
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

This is needed for VCN and VPE to get the doorbell index

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index e007f10a6c1c..dc9000b25be4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -601,6 +601,10 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
 	case AMDGPU_HW_IP_DMA:
 		db_size = sizeof(u64);
 		break;
+	case AMDGPU_HW_IP_VCN_ENC:
+	case AMDGPU_HW_IP_VPE:
+		db_size = sizeof(u32);
+		break;
 	default:
 		drm_file_err(uq_mgr->file, "[Usermode queues] IP %d not support\n",
 			     db_info->queue_type);
-- 
2.43.0


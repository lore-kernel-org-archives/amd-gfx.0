Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E22C83F17
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jul 2025 13:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F08B510E9AF;
	Fri, 18 Jul 2025 13:46:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PJdHV4Xj";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCAF710E9AF
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jul 2025 13:46:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AmLaayWx3AQG+xGXiTaEczY3nZVU870eZ12GEQfrMThbenYXfu6fTieuTDmiKL6iU+0gXq3evrlmbTzf6wIKqeKfIB+7vc01wD6zuqhvBHWpoe2upMvsF1ZmcmYiy53eXJJjEqaBq5IONVEKuXSV4la1cv9txLwZtqALNPgv1VX9aCVvp7O5pU572I3oNfYxQqwal1lq8gBXF8si/l0hM1RqOZQnWrgZv/xS+EEVQeNh8Pg4Wt5Su5vqowKf5yC10fs2SCqMjplYXwF/xRREPpEoddaNNNPW5pNuPYDxNB6lubQwjS2oD5TpHjjilFU61Vi+zLCOmmp90tYGwR0Xtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pO+e3t1AVg6J+VG8D5RGhwn0pWn6lbaVGck0xX62Wt8=;
 b=Uj0O09SqJlgLXZCNuvipMie7AUGR+6yRLn1LxRNjIctyMoqZp3uS8Hzme1yv4SeLLxi2xEsNpFhvph2P4ZWaLy0NuEByu6hhJ6dZvF7oLR6CTf1hxMMbALR5gK6ujz9JryCEnmaVWVsRrb1OcpOSjoPJcBFWfVuiYq1jNexUnncG4mhITlwhh4ip3iV8WEIItRm4OLWkhMXh0Ao/pXRtX5CmfuxOVaq3y8yOKJEgRDXA8h3z2ZEKZN7Yia98Q+v/OoZ6PW/nCkY7kmrZPFTZrxOnU6cAgW1kQB4PqamDSQNlMD54jR1GsK64GHIXz9S4GJHvfz4pS3wWa3fUd0c92A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pO+e3t1AVg6J+VG8D5RGhwn0pWn6lbaVGck0xX62Wt8=;
 b=PJdHV4Xj3ylor5TYJcyjL1YqczormC6EauyoUbTr+9wiwGeOEHLX4DVHDgdNflZsoi2vu+vQZ5GiDvNmt8SUZX2ZDf4+EI8Tpol82a+VKuGYVGC22OBpFsxrlCIwd4FtWRhfOfODfPEwGNkkOj4K1I6dN9M2LVdrM9C6ib7LkoI=
Received: from CH0PR03CA0333.namprd03.prod.outlook.com (2603:10b6:610:11a::7)
 by SA0PR12MB7464.namprd12.prod.outlook.com (2603:10b6:806:24b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Fri, 18 Jul
 2025 13:46:03 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::7a) by CH0PR03CA0333.outlook.office365.com
 (2603:10b6:610:11a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 13:46:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Fri, 18 Jul 2025 13:46:02 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Jul 2025 08:46:00 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 0/8] Generic register dump helper functions for VCN
Date: Fri, 18 Jul 2025 19:15:36 +0530
Message-ID: <20250718134544.2594829-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|SA0PR12MB7464:EE_
X-MS-Office365-Filtering-Correlation-Id: 93d86f09-a0e8-4193-bfa5-08ddc6016fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDhZVGl1VTdmdGdqSDVGQVF0RUF5ODFTeDg5NFpMdkN2QXdkY1Nhd05uV25o?=
 =?utf-8?B?SVlOekNlRVBDaGJpQTFzMWlxeUV0ZENZbHp4RGl1ZlhLRlNvQkR2djhZdDgx?=
 =?utf-8?B?cG9XZXg4QTZFaERrRnZTVHpPR0NOVm90RTdjY3RYWGNtM0dyRWlNbGU0QjRG?=
 =?utf-8?B?NkVzSGZha2YzTk5KMDBaMmlLUm8zY1kwNHJqMGdPbEVrMjZiS0hZWGsyOUpU?=
 =?utf-8?B?ZGl4WU1taWV3ZDBJVWJLYndzbDl1dUFSNHlOSnVQY2pOaWtuRDJGdFI5YVN6?=
 =?utf-8?B?dlduUFRVRmhFNnRwWG41c2ppNDk3M2VMTHl6QnA3aGJnRTVMUU1vY1NidmVv?=
 =?utf-8?B?czMxYkpKKytYUHVIbTBBVExQbTB3SjZDRXQwUEM5NXNSYzZXUmJrazlRWjdw?=
 =?utf-8?B?aHE1dHhRK2d6eXZGd1k2NTBCR2tqd1ZIZlIyYk1qZy90UWxhY05PUmpCMjJ0?=
 =?utf-8?B?bkpQS3BFUGFjdnpZM2svTDI0QkxGRkhndit4Z2ZiKzAvVFlQTy9VdlgreXB2?=
 =?utf-8?B?UUNLaGZiL0VEaEtFdVhlbHRneWI3bmFlSmYxVUtmUG95SWg1UDEzaDRxQXhS?=
 =?utf-8?B?WlJwY1A4TkZJZEtBNDl1S2Y0Rm9GODRlVUxwT1Bnb2dZTmlhVkYvc3pQVlJT?=
 =?utf-8?B?MW5id3B5cXBBTE5pb0F1UW0rd2ZtUTVRaHlYUFNpM2JnN0g2dUxVYWRnWnJR?=
 =?utf-8?B?eVFHODIwSG16NVUvK2FJd2VzSWlxbE9sUFBmamlDVGVDN1ljb0pxRmpNMmJO?=
 =?utf-8?B?b1IyUHFvZmttSkFHMk9GTUxRanFOK3ZFbUtCMFoxamtxK25NNGNhcEVld2Fl?=
 =?utf-8?B?dUpleTY3Rzc2UVJUSTZISk1CaTVjYkZJQy9KQXJ2Nm9xMkpZYkFNUE4vUUkw?=
 =?utf-8?B?azZMWFVDS2RFb1ZwcFNkdW5BUWI0RUxBcVIvMkw4cm0vU2JBRW9aU1B3VHdv?=
 =?utf-8?B?cHA0UnBLQWs2cTlwd0RoSzdwVlptbmlSS2ptakJwWEo2VTI3bjZBd2dOUXJR?=
 =?utf-8?B?WFhXTjBqaS9UL21HUExjQTF1NXBoNXczTS9XeTh5OWZjd00zVk1yWk9CUFEy?=
 =?utf-8?B?NDA5VVJHUldyQW84ckVEMElTNFRWNlNUM2pyNk5uVnNNOERaeUE1UWZ1SzJy?=
 =?utf-8?B?WnNnNU8rNEhGbXlHdmY2WFBRbmFBTy9GdFlybVVweVphK2ptMjJDd1ROY0h6?=
 =?utf-8?B?akxYLzdJL0RBK0U2Wk9IUExkRjJMVzNsQmZUeFRqN1VpSmVhUWU1SGZQNlAz?=
 =?utf-8?B?VG1tNDZzRldmai9iTk9uRjNoY2Nka25BSjJWSFVRSmc3SnZRWFAvWlpKL1Aw?=
 =?utf-8?B?OStvQ3JCa016dnozbWU3V1RHZXdueHIrZFZYejhsYkFtMjNkZURldWVJS2Rx?=
 =?utf-8?B?OWtGREg0aEUwOXl2Q3lOZGk2ZEtpYmQ5K3VCaUNvN1craVI1NHpTaHVaZkFS?=
 =?utf-8?B?NzlGbHFLZVhndkFSWUhhWDBXL2NOS2NJTENzdEpRMndqVVJpN2ZTd0lsRElC?=
 =?utf-8?B?bUdvY1F4R1JrM05vcEVxdEZMc2czK2hUdHhzVjdSK0FlRTAvV0M5b0xaTHBn?=
 =?utf-8?B?TS84bzFvWG5RQzhCd1JYRDJCcEJHWlQzdEpkUytDYzFTYW9BOVh1VUo3ajZo?=
 =?utf-8?B?aG5OY2U5ZzA1QVFZa3NtRGxTOXZOTW1qV2JnTWZkVjVCeHVWMVpseWorTUxy?=
 =?utf-8?B?d0YwbEtJZGs5V1AvQXg4d1laZ2tibnNwZksyZVk0UVBxMVVtMHRocEwxWXQ3?=
 =?utf-8?B?cmhXam51Um51TERTT3Vyb1JZT0hXUDUzQmFlR05rL2JaRlJMbW5hVU9CUlBY?=
 =?utf-8?B?NlRqZVlUZ0hXVy81MGdwUlBXUVlpZHFaVGxabXh5UnRDRTN1c0lXeE1IWGlv?=
 =?utf-8?B?eWw1bUZhMS8vTmJmWTN5b3k4ZTJtSG5CcnlHbnlFY2cvcDNpdG42bis3ajBt?=
 =?utf-8?B?T0RVaEtGT3NBQUJORndZblBkc1VKaGluYWNjQUtCL0FJakRkdC91SG1vdExj?=
 =?utf-8?B?QjVNeksxRCtPODFyVHZaUzE3NHRoSTF1YW1FRXFDM25oL3lMVWJVNEZVNSt2?=
 =?utf-8?Q?Fu1I+w?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 13:46:02.6151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d86f09-a0e8-4193-bfa5-08ddc6016fa6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7464
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

This patch series adds generic vcn register dump helper functions 
and reuses it in all vcn versions instead of redefining the same
in every vcn version.

Sathishkumar S (8):
  drm/amdgpu/vcn: Add regdump helper functions
  drm/amdgpu/vcn: Register dump cleanup in VCN5
  drm/amdgpu/vcn: Register dump cleanup in VCN4_0_0
  drm/amdgpu/vcn: Register dump cleanup in VCN4_0_5
  drm/amdgpu/vcn: Register dump cleanup in VCN4_0_3
  drm/amdgpu/vcn: Register dump cleanup in VCN3_0
  drm/amdgpu/vcn: Register dump cleanup in VCN2_0_0
  drm/amdgpu/vcn: Register dump cleanup in VCN2_5

 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 86 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  8 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 78 ++--------------------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 82 ++---------------------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 77 ++--------------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 79 ++---------------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 78 ++--------------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 78 ++--------------------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 86 ++-----------------------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.h |  5 --
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 44 +++++++++++--
 11 files changed, 170 insertions(+), 531 deletions(-)

-- 
2.48.1


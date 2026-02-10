Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1C5EB271F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 21:48:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B53A10E02F;
	Tue, 10 Feb 2026 21:48:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gvKi8XVf";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 696FD10E02F
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 21:48:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsOMs+ClpWiNbz3x3Q3fhTTSA2Gl2AEU02LfOD6ltcUrxFSdHCfg/EGp8YpT2F3KdX93Y9mT2mqsbOQ/mxkV3YEliL6YZEsT1uSsIT6rBB8JNg3b6N/exPorYu2h2FV4UYZHPMTttrONnApaMLAUBwAIEZsIxWoZOLHqsXluEH6EySBOJacZMYGRxlud/Ixibqt4voceJbN/4G4qVXLf5Wbk+F+aBwvilsjG+zBVi4ikQWMbXEYssoy6HGP+Pjt4ycNAaLo5JczcHzzrXw880HqYYRQffVVyyi2o/dv/LaM8VJX+7ocbZfYF7uS82arZyl81n8UmtfIXgNoeMScr5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4t60fXTbtPZqdrfj5yfd5/T7pw3Lzpeitme9ZzyeAgw=;
 b=L8Wq+0DXwo8ySDfOPdmshFZD4cmHyKwtr6HeDyAliNrTjH5G+4FIbutCZKx0GlCkJf0XauUUhzrd8GYzOPYNLqHTugVwg5bWSwEnrkautMEHgXGeEejy6M+KU9BmrkRbsZX0OAfQ5cKRfbfYWPCKb5vRNj6Prjww1CdrATQrPtghaSw6ywLr0UVeRhDK8qX4jdl23J+R6aFCACKIUGCwQxZVVP7k8RMk13imidQaKbCHtxb7hdOAcqT2tdFKguObgi/vEQvd0CAS6v9QtfS4M7xiMegY6JcgmGyGgfWKVA/Ct8cNISZ/6TrJlSyNLjlYsqh1FUHoWEu1loh+fl0dqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4t60fXTbtPZqdrfj5yfd5/T7pw3Lzpeitme9ZzyeAgw=;
 b=gvKi8XVfMqelb8ws8nxX4ou8zKgqsG//Viec+h90H3pZUUcy5IzL+8BSTZ3WFOhnZt9ikMkSc5eNQf8Cpi7G+FU6KdbZRSbxZzxByjEMXNUyL16MMJv9OkXFXK1WAY331uGOcjimgC0LM/FVaHmt+vbL+8QhlATBWaR6/RDh+1I=
Received: from SJ2PR07CA0008.namprd07.prod.outlook.com (2603:10b6:a03:505::8)
 by IA0PR12MB8907.namprd12.prod.outlook.com (2603:10b6:208:492::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.20; Tue, 10 Feb
 2026 21:47:58 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::73) by SJ2PR07CA0008.outlook.office365.com
 (2603:10b6:a03:505::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 21:47:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 21:47:57 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 10 Feb 2026 15:47:56 -0600
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>,
 <alexander.deucher@amd.com>
CC: <leo.liu@amd.com>, <Boyuan.Zhang@amd.com>, <David.Wu3@amd.com>
Subject: [PATCH 00/14] user queue support for VCN 4.0.5
Date: Tue, 10 Feb 2026 16:47:15 -0500
Message-ID: <20260210214729.80964-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|IA0PR12MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: c97e33fc-94e4-4da8-0d3f-08de68ee0db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFlBYU1IQ0k2anIzTyt5VXZzLzVjajdvd3dQYmw2U2cwdEtoS3EycFUweVFO?=
 =?utf-8?B?YTJaMGpzUmhEaHVwbG10a204WVhjd0k4cEhxbFZZQkt3VUxjUEh3Zy85TS9x?=
 =?utf-8?B?bHg4Nk5tOXRoS1pwL2JFYlg0czF5aTNWNzZ5bmdqaENKUjJDckhETnE5dDlV?=
 =?utf-8?B?d0pSeVJMYmNIOXc0SEhYb3FzV2lja2FJTWZ6VGg5ZEw1anZVR201QkpYdmh2?=
 =?utf-8?B?cGpodzNmbmFvcUx4YlZDRjMxWUt6TEFtNG9DRVNDT1Z4VWRTMEhtYmpZZGRT?=
 =?utf-8?B?UUJvMTM2KytRcnNFN09FVlhPNGx6U1BvbnZsR1JLMEdWb3lLWDFOTFdVUG9h?=
 =?utf-8?B?QnY1MDFUTWY2aE1CVGZSU1psdzlYYklSU0xqM2JKSWcxaXFjSVF2R0xCRW9D?=
 =?utf-8?B?L096aUhKKy9YWkVmYWpMM2NkTitPak1qKzlIY2ppdHBBemNScXRuVGhLVU51?=
 =?utf-8?B?MG9HMVAvOThESzkraS8yMlAyZnVnMm9kM3RlSTh3MjBGMEY3bHlWTDJVZDFo?=
 =?utf-8?B?Lyt3aUgveWNCald2TVFUdHRHTU1xYzlvREIvUUtnNlpjMkljL1Eza2VoT1hG?=
 =?utf-8?B?ZDRoOTVjajdmT2I2d2htYk5INzlaaW5vZjJzWS8rRFlEeE5GRWRKNTJjM1F2?=
 =?utf-8?B?bW1XZkloa0txRmF4bEEwMGZ3a2ZUSm9FV1MzOENFNThxVERtTHNRcTBva2tJ?=
 =?utf-8?B?Q3o1aExUMGx3TmN2YnBaQkppR2pidWRSMmh2Vi9QNUpYMDhUdHZKeks5ZGNw?=
 =?utf-8?B?UnRLOU0vdVpWMmlhZ1dvcUNMbkxOR1lzSFl0cDc1ejE3cG5tZThDcGhSeE5x?=
 =?utf-8?B?RzZSVjN5QVdGNTBsRlQrbTE5Q01pWlZ1QWhnTlhNbSs2SjRLWlJSV1pZeStE?=
 =?utf-8?B?TXVUME92UGE5QkpuZ0xZYUcyOGRpWHdPaXFEZzQvUEpsbllZYkZsejdzTjNt?=
 =?utf-8?B?Y2JVL20rNzlmMGk2MXV0bTE2bnJJdHFEbEMxSkFuemtsS29PcG1EOHY4U0hU?=
 =?utf-8?B?UjBzNnA0RTdhOFJBb0ZTYzI5S3JEMWVPZTFEQWVSRnFMemh1d05BRlR1NWMy?=
 =?utf-8?B?dldOUHJmNXNnUjBOeXNENnhXWVVGU2xqU1AzaHJlcEJ1bkkxZzJ4RHhqREgz?=
 =?utf-8?B?cHJody9SbzdYbFMvZEhQOG1iM0RDY0FEakMyTkJabEFDV2Nic3YyalJlZmpY?=
 =?utf-8?B?Y0k5Njd2TmRwZW5Ca2pHQnA3UkxkQUs5S2JTQzBUQmJWYTZ4bVE2Slp1YXJN?=
 =?utf-8?B?aitGeHlyZm5OYW1TSnJQaFc4NU9QQ0oyNHVyZm5jUUJ1blFGdGgzUFh1Mkcy?=
 =?utf-8?B?ekpudUloZFF6RExKVWUyNVJlWmNKVEwzUC9zSmRXdE1TQ3lUMGJmMnVHVkUy?=
 =?utf-8?B?M0pTNC81RkxOOE1RNzNvVUxYNVJJNkZmSWVKUk5Ha1JKMVlxVStBc3RCNEFS?=
 =?utf-8?B?UE4xVG5GMllGbVRTSm1BRFUveHpWSmFIMlZha1ZQY0ZSRDM2ZEthdFNGUERj?=
 =?utf-8?B?TU9Makc1M1JRRjEzdXVSZE5Xc3o3QXVVbVlJL0dsV2NxZndQeU5KMXRMOC95?=
 =?utf-8?B?VVZscDdYWk9DWUVESzlMSlcyU0Y0Tm1IaUt0b2tENEhKdHhOWkM5UU5QcU5Z?=
 =?utf-8?B?QXhqVlhTa1RzemZIUWxVczVEWDJBdkxPOC80bEdlYkJkYjA5Q2FBSDJpVHdp?=
 =?utf-8?B?dytNSHh5T0ZDNVZic2tRNVpFbHN5Q2Rnd3NoOUlKRWdhYWlKUDFXNmUrRlpU?=
 =?utf-8?B?OG11eVRoNHMrZzFEdTNsd3ZoT0N3Y3JYQlpvc0hreUgwdnFacUc1SjFIQ3FI?=
 =?utf-8?B?RE5iZnNUbnY3QVJyNlEwMHJhRTJ3TmlkVFBtK1NyaE9xNGU2akpKeGpUQWNW?=
 =?utf-8?B?RUExN1pBWEMya1MzZUgzNjZjSEZvUWhXMzRGS012VEV2Wkd4VjBwRlk0NUxP?=
 =?utf-8?B?dE9DME9IVUlxVnhKZ0d6N0s3Q09KbjFMZUtnc2JBSHV3RytZR2NIZERvZGRh?=
 =?utf-8?B?ZENhRE5acTBBN1ExS1lqREE1SDNmK05od214ODBnc0l1MWFZNlNyVWlFeHAw?=
 =?utf-8?B?Z1NJWTJ4dWdiTEl1Z1hDTW5MMUU0K1VLTkVrdDlrM2tPOWZGeHRZaUVwU1la?=
 =?utf-8?B?VmMxcEJXUGNhb3IzTUJEalpUYVFWOGgySUNoOHpUeHdXYm5SS3R6L3ZxRXow?=
 =?utf-8?B?OHdMWDk5UWlpOUtTcThwRm5Jcm0vb1Z0Q3FnbEtjd3NRb3RXU0gya0k5TUY1?=
 =?utf-8?B?U1FlZkVVaXlraUtlWDF1bVc2WS9RPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T19ULu+xPmwRRlsTxViMElCAv7BdcHOeoPZ5+o+pc/j0bq1/oJp4aitfJo7aDIw4C7+Pke83R4UJDy2R/jZGtyxfuhuT+G9WXCi7zNI5whrJ3bKahrE6A+b08U1lpdKK7qRyPJkTg8HI6X280d1/94iAVpEQPIUXB7nBup5RcbWaM2+lvSQIHmZpOIONoTnkJVtArpkVyxUZwrrdEZ8qBiEJpdRjFGjUtWPT5sq0RT7o4XBbR2baVjyvPQ/puDg9+pT9X3tPn+XfcW260JucmxV7neIhWZftotOOym49P5JdtsF43RRmBSC5SktvbbbuvFvovzAJPGkv5N0TQ9os22Re7gYO4Nr8V2hRv14IR6oV8Buao/xSnHL27IF7Fg+lRZQXtPBwLmbdHBPJgzI2asbOIIFAiVQmSNauanmCMsysMb+rpXSrl4flmihqRZrg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 21:47:57.4117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c97e33fc-94e4-4da8-0d3f-08de68ee0db8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8907
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

add user queue support for VCN 4.0.5

David (Ming Qiang) Wu (10):
  amdgpu: add global aggregated doorbell bo
  drm/amdgpu: add AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL
  drm/amdgpu/userq: add doorbell size for VCN and VPE
  drm/amdgpu: use amdgpu_user_queue instead of amdgpu_umsch_mm
  amdgpu/umsch: Add VCN IP init to umsch driver
  drm/amdgpu/userq: change mes_userq_create_wptr_mapping() to be common
  drm/amdgpu/userq: rework on amdgpu_userq_create_wptr_mapping
  drm/amdgpu/umsch: user queue support for vcn
  drm/amdgpu: add AMDGPU_INFO_DOORBELL
  drm/amdgpu/umsch: userq suspend and resume context

Saleemkhan Jamadar (4):
  amdgpu/umsch: Update UMSCH interface and mqd structure
  drm/amdgpu/vcn: changes when kernel queue is disabled
  drm/amdgpu/vcn: handle interrupt received from fw
  drm/amdgpu/vcn: handle the suspend context interrupt

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  |  16 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  10 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  18 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c  | 300 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.h  |  43 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  69 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |   4 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |  90 +-----
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0.c    |  75 ++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       | 122 +++++--
 .../amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0.h |  10 +
 .../drm/amd/include/umsch_mm_4_0_api_def.h    |  12 +-
 include/uapi/drm/amdgpu_drm.h                 |  14 +
 18 files changed, 646 insertions(+), 151 deletions(-)

-- 
2.43.0


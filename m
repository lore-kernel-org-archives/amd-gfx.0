Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6EED6409D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 09:22:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1876210E037;
	Wed, 17 Dec 2025 09:22:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eb16hEWB";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 963A410E037
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 09:22:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivn0oUZ8GkmwqA3hgLYhO8vKS9ufUOcxGoXeDfyUs0PLg3vyeJ8t+3s3ejGEX6DFZmGfMYT9df94p5PI2PutcUGfqXnPDgQYC/kJxuWpFknzA5S3TFjVNsya8Yzk3qQC5cwBJppxIxhYHiwi2XbBoopOWZZntWf91Vj3pYLrAeJ2NrKN6JahElm/t9te7QcVU4hMeoG859EjxSZo4NYas6b09iR8LgzDRdW0IUCmAEKQdd5XKRWXH7ZX08Orlr4+LMe/v4dBg72t0qizK8OYsqOulwBKF4TMX8GlkPEj6uTlIagItFpx7MXZR55PpRmet0737VIEFtxxXGR3bbmWgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hw9IfuI9gTHPPE1FLQFVTgrRgDeWFEqGHmQwHYDpKwY=;
 b=UqBwr/RcukCe1Q5SnwgMR5TwBGRnJIKPa0P1pYe83TmnfHrBihV0+vuyQZ5cuTg8m+pnMOVnsRXPaNhq8ZYMJtlUAGDnJLLaL7U9pCn2N1FcW4FW0cqyysEsKEGJKd/QlM9C0mI77x5M3ADR9XoQnpPzOSbXn+GWltudk8Uv/Jdhccv99zPE271yq/UwJRg3K1eFzX/0hzQJQehXS7KKuBJDNcTpo+LjiTl24lN5ZJ5rCID2kFvPBFs2VgPc3t4fxglSxmNMsrZIPxr+AM7z9w/zBtaTXdNfNnxiLAgf21l6+nOUizW921NP9Ou1unLIeJtJdZqZWxVkbiKrLDbwQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hw9IfuI9gTHPPE1FLQFVTgrRgDeWFEqGHmQwHYDpKwY=;
 b=eb16hEWBKpp9HnGGsBbINw+mbxy2YWasZavUA2DFlpaebcP7JimgBgcYX/Q6ZHp8PWYKykdAr/KMrlou1hUnCQdLj20/2hs86OPPr6Rby6WYRw9Kmz03T8Ttubv9OvHU4X5xEdha1IWde1OqfnNWfNWPkT3oAy162p5ExUmbOc0=
Received: from SJ0PR05CA0110.namprd05.prod.outlook.com (2603:10b6:a03:334::25)
 by BN3PR12MB9596.namprd12.prod.outlook.com (2603:10b6:408:2cb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 09:22:28 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::8b) by SJ0PR05CA0110.outlook.office365.com
 (2603:10b6:a03:334::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 09:22:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 09:22:27 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 17 Dec 2025 03:22:25 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 0/3] drm/amdgpu: Make MMIO_REMAP fully internal and Switch
 to OPEN_GLOBAL
Date: Wed, 17 Dec 2025 14:51:57 +0530
Message-ID: <20251217092200.703080-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|BN3PR12MB9596:EE_
X-MS-Office365-Filtering-Correlation-Id: 066d1c81-2b10-433c-4576-08de3d4dcc19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WDYweGx2L09EdjlvVDhHT29tVjBtd0NESkNNMzZ0ZGxuSXZkZWVZZjBoVG1a?=
 =?utf-8?B?YWE2TkZJUHd4eWdmcXZiZzEzTW5kZkFKemFIekdFNjNSdmZldlVPeUhvTnAv?=
 =?utf-8?B?eW9QajA4NGVtVkxpZmEzc1BTSEJFNlZjbTBxSGU3M1ppTThSWlhoVGdkNEc4?=
 =?utf-8?B?bm93VXdobzIyYitRSU9xWFdvMVRXRHA5cVQ3M3lJdW1MankxYktjNUg3Qjk4?=
 =?utf-8?B?MlI5cll6aGNkcmVyd1B2N3dwc2VKemF2eFBsWkY4RkIreUxCV3NKNTJPSlEr?=
 =?utf-8?B?OUJKOHJJTmtGRHEzbEhiZGpBV3pGdnNXcDlrWmJHeHduZ3RIcjk1S3phNUhN?=
 =?utf-8?B?SDl1Y0tnak5MUVVnSWFFbnAyRFlyZ1g5U29FQy9xVFJkNWxNbU1paVF0UWtu?=
 =?utf-8?B?TXlhSlZsNEdEaVNGRWVDU2NsMlNkOWNYRjd3aTlNdVpHdmdNZWR3ZTdVb0pz?=
 =?utf-8?B?b2dzdXJqMmxaek9kb3BkRXE0RnQrbUtPRGgyY1hsVWhYN2JJcTVvN0Vwc29t?=
 =?utf-8?B?c3JPemswUlVEeXIxTVQrblJrU25RVFgwcVYxT2tDQTVINU5DTmhCWHVNdVZL?=
 =?utf-8?B?QzBjaEJ3ZDBYVmwyMnFlS0U3c0V3eHc1UlF3dTlkUW9PZGlsYSt1Ti91WFpp?=
 =?utf-8?B?cW04ZGRjYTV6Z2l1QmpaRm5RU2FiMmFGYW5LS1ArcmZDKzZZTVpWN1Bsenov?=
 =?utf-8?B?TUFnYjRQVzlaTmxncTZSank1Q29NWm5KMmVuSG0vd2sxM0NpVXcySXVYWkll?=
 =?utf-8?B?cnRIWi9HTGpkRXk2eGZLeHRBWC9UNGNqdVVueUxuaFlnRmZmRG5INHpaUjlv?=
 =?utf-8?B?NW1QNEJCcjFKZnNBOWNWY3NYUSttTFpDMlVHMTA2MVplclF2Ynk3ZGNwWWxi?=
 =?utf-8?B?N0Z5RFBCT21OaHdhcFNxM2E3NHZlWjFvVTE2UzE5UWNGM3J4SzcvOEZLVzNZ?=
 =?utf-8?B?T05HeldTWVZxMmQ0SnlsOU8rSmR0U2VRaDF2TmFSenBmbVE5S3RjVUMzMUdz?=
 =?utf-8?B?bTZPYklvSmxKUDlGQ0dJQlJJT1JhVTRWcjc2R3l6QlJJL01uS2pVbHRmTkVK?=
 =?utf-8?B?bG8vSms4ZEFUeitFNjF4VER2bWIrcTJ6OTRDWk9iSHdBNjBpQzZPcjg4aWdX?=
 =?utf-8?B?NWNSZ29JcGs2VzlXS2cwV2JCS2E4ZjdZVnZycnlrZFBkbEYxbzEvZ1FIcHdK?=
 =?utf-8?B?bFc1b0NoNFRYQnVqSDVQTzVwNU9PNTcrRE5uQmN4ekVUMklDR1ZPT3ZIQ2Ru?=
 =?utf-8?B?RHpPRU1Cc2Q1a2twcXFVQ09wWXVQV09xMmZwRWNLb0UzK0FnTlowNkFzTTB1?=
 =?utf-8?B?dVZHSXNMV2YrZUl2RnZBWTh3ZUJuRlM4R0VsL3FJWGp0YjRkZzU4cTBUcmF3?=
 =?utf-8?B?QndZcngrTGhBZHV2d09IZU9ZeWJteW81MUlRUGZVNHZZVmpNUWp6U05tVFRk?=
 =?utf-8?B?U1NLejdkZVRjY3hMd1Myak9uUGhOd0xqRXlNVHM3TkFRamV3RFRkdmVQazEz?=
 =?utf-8?B?U21jMUFqN2FxdTlIQkdIdUhrSjVScklUMlZZZ0tJc1ltcmlBbkczVE43M1M4?=
 =?utf-8?B?YzFHcFlhZCtSVlRZa0xUZFdXamE4QjFGVVFFR0V2OGp4YmJWWW1Jc1QxcmFn?=
 =?utf-8?B?UVNmVTd3N0N0R1FLdnkxZ0Fsb2ZrcHpwT0w4RnI2aDk3Ym1qWGRPY0lsenN2?=
 =?utf-8?B?VnhadVZvUmxtekppd1BSUWV6L1MzUVd0TmJTVnV2MGhNY0dpanZuU01zUWov?=
 =?utf-8?B?R1duOWhqT2pRTXJITE16MjBUZ3AyS2JEOWIwQXpoajY2RWJiR2QxbmFxTkRh?=
 =?utf-8?B?WW1GSkFLK0tRQzQwYkpRT3dxL1NPQ21KRWRqYmxoQmhzZVZGek1zMGZUalVp?=
 =?utf-8?B?VVUxdithUElXV1lDK0kxNEcyTnhSbTA2RGdzSHZIb2pjUW9rdmZxRWFiVlRk?=
 =?utf-8?B?T2dKODdHVVhNM2owQnd1K1FhdlBBWk5Zc0wwdkFlblBCTzNwaWt1eVRDSVBJ?=
 =?utf-8?B?Z1BUVHp0MDNlSDRjbVB2bFhUd21oSy9SenNKbzJjNElNR1VVKzVHSHdoOWI4?=
 =?utf-8?B?ck5ZdjdHM0V1WTdIVlYwUGZMaHhUaFBrbnQxVkFBazdoQTB4cytlTW9GUjRi?=
 =?utf-8?Q?ef0c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 09:22:27.7841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 066d1c81-2b10-433c-4576-08de3d4dcc19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9596
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

Avoid overloading the GEM_CREATE ioctl with special cases. Instead,
userspace access to global objects (including the MMIO_REMAP BO) is
routed through a dedicated AMDGPU_GEM_OP_OPEN_GLOBAL path.

Overview:
drm/amdgpu: Rework MMIO_REMAP BO creation Allocate a global MMIO_REMAP
BO without relying on a GEM domain bit and pin it explicitly in the
AMDGPU_PL_MMIO_REMAP placement.

drm/amdgpu: Add AMDGPU_GEM_OP_OPEN_GLOBAL Introduce a dedicated GEM_OP
to open global BOs from userspace, avoiding special-case behavior in
GEM_CREATE and removing the need for userspace to know internal BO
parameters.

drm/amdgpu: Drop MMIO_REMAP domain bit and keep it internal Remove the
unused UAPI domain bit and adjust accounting so MMIO_REMAP remains
visible in fdinfo/mem-stats via its TTM placement.

Christian König (3):
  drm/amdgpu: Rework MMIO_REMAP BO creation
  drm/amdgpu: Add AMDGPU_GEM_OP_OPEN_GLOBAL
  drm/amdgpu: Drop MMIO_REMAP domain bit and keep it internal

 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 47 ++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 21 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 77 ++++++++++++++--------
 include/uapi/drm/amdgpu_drm.h              | 17 +++--
 5 files changed, 108 insertions(+), 56 deletions(-)

-- 
2.34.1


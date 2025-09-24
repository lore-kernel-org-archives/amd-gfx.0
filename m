Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95533CAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 16:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27EF910E140;
	Wed, 24 Sep 2025 16:16:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BkN2j02z";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010071.outbound.protection.outlook.com
 [52.101.193.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 649B610E140
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 16:16:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGN/yN1xXudIkaIKLAkIaOY/a4TwRSkfcqAy1UOFtJn3Ac/Q5XS4YXXzHolTNlC0AcLd39+iwwr1JlhzQfRunDJ5XckvK3RC4GR0YjphvpOJjp9dV0hasqMm/7umR0rD8/Ru9N1dDwYBUHHty2Py78KeMflxiBoVcqBLYpTakEYtQMgYFCHRAUviJL8Hxmnyht7D7liich8kX5BU84yh5o+g/QKblHZSGlzugY2ToHGK/z17w9upLHd9/r3F0/aGHts/QoU49SZQgSszRm8vJK73X07OuGC8Q9HoqvgrmZTvr1q5s/dYhQgGPQBh+NLbvtKs/zjLTcDQ1L9xeQoLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCOHtNnBk7tV+VCzQY4btxXnSAHAXLa4y72E+4DxBtI=;
 b=xJM3ZHS23TAM+6dO7WteYnvWcZzjUj/1rczaunp7ei5infH5SS8wzHQD21lxszUkTAD1YopOHV2WsMFzk820fx15Ja29xBwVv7eiNbtFQa/X1hfV4DMj/ozzjll9mkxLiEM17evBDJzC1B3IkLKyM8DjAfIPpSXwOjMxmQM9vkQ+pfl7DzRkRxf9svMWXsmkpTitmOtRjkO9Lae0YDWwJIuxeo83FgtJhYHOk4rGmGK0yY4u7NnkrLPwag69AO6txv2B8nAUmKS2RPkMY/QzbMGKzQ0pSFnsYNz+YRfCzdcwWJ/6/9v8ClcLVuRbzWFv01Jy33aYwKFHrY2kBxBUZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCOHtNnBk7tV+VCzQY4btxXnSAHAXLa4y72E+4DxBtI=;
 b=BkN2j02zgBeTx7EV9qH8gv9pW55y6v6QudgKQZpWPH0woUM6H21tlhJEz7hc8DsgTrwb9KugGCsQ8R6Y+3faaNeKVI+M//i4gytGUvLA4QJ2nkqdwJv3LgnlqesKzVVLtKXIthanfbTVJJSShv/P9z2QPhotcfHOdzrk2syfQls=
Received: from CYZPR11CA0021.namprd11.prod.outlook.com (2603:10b6:930:8d::17)
 by CH1PPFC8B3B7859.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::622) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Wed, 24 Sep
 2025 16:16:44 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:8d:cafe::6b) by CYZPR11CA0021.outlook.office365.com
 (2603:10b6:930:8d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 16:16:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 16:16:43 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 24 Sep 2025 09:16:42 -0700
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/5] Adjustments to common mode behavior
Date: Wed, 24 Sep 2025 11:16:19 -0500
Message-ID: <20250924161624.1975819-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|CH1PPFC8B3B7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f34a3b9-62aa-473e-202e-08ddfb85c03e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c2JEOW15WEMvdzFMdkl3MGQvQzdoclRVTzVQOE9HbGI4OWV6amRQNkRyd0VW?=
 =?utf-8?B?eUQ3UGZaMnZVMVBlaWVMRkQ0OSt2alZNRS9LN3JDUzl0bzhSYm1CK3Y0cWgr?=
 =?utf-8?B?ZjQ5ZGQwUk9uc3d6c2MrU0d4bittRHRRVkxGM2JOanI5UEg5VXViVWpqUDhp?=
 =?utf-8?B?NVNYWDFnMHB6ekk3anlYKzgyTTBaeG1tUlhaUzhEeEZxUEFOUGhXL1hpMWpv?=
 =?utf-8?B?UlMzNlFJVE8yWlVoSi8zZUVPc1Z6bjVZK1V2RElIaUtJYlYrbUNHR1hPVjda?=
 =?utf-8?B?Y04yMCtpNXBPdXBsQXRJUEZTSlpQczNxNXlXb05WZHdjRU5lekZVYnFSZFRl?=
 =?utf-8?B?OU1FQVlRbGdOdFJkVTFlczV2Z0lkYnBNQXM4U1EyN0x4RkhCRHMvSUFUMnJt?=
 =?utf-8?B?Rm1BY0JoaUNPYVR2RXFLVjBrMEpYOTdTQVU5cjNSMys4Sk8yWHJHdnhZelN0?=
 =?utf-8?B?dW9PV25sRTRaUXU4aFBvUTRIMkl2NXhMcXBCZHRaUjZ1dFN4MjVLUGUyWnhY?=
 =?utf-8?B?NXlXdDI4QWZWYzExNVE5TG5MZXc1dkFockxmOHpIa0pMS0lzeFFIL0thQTdZ?=
 =?utf-8?B?QlMzdUFJVUJCM1lHNnZ1WEdGTWFUS2NjY3NncExkNURDSy9nbENzcVJha0tu?=
 =?utf-8?B?OUdJVlUrRG9URnN1Nmg3ZWpwYkphUzhpbElzY3pDUFRwOXVoS0kxOXRjZlBW?=
 =?utf-8?B?N0N4NU8weEJsM2hwZUp0ODI3VWxXZWRFN0V6cHR5WEc5UHladG1SNjVtSHh6?=
 =?utf-8?B?T3h0SFRmekYwOWtDaUxKUUhWeHFnS2creVloOUdWYUVnaFJPUXR2UmtPN3Qx?=
 =?utf-8?B?Q0ExYXNTRzNYZWlrZ0ZtcVhTNE5DNU5MWWhkdEVyOXUzRWhNazdFTWJ3blB4?=
 =?utf-8?B?ZVp1cm52RmozNUl2V3Q2U2FJSTdncld1UVZmaTVveWNlNEE5QzZiNFhOeHAz?=
 =?utf-8?B?TkxOUkJLYzNqWGwrZW9Cc20wWm14bnlERjdiOFhVOVZQRjJadVVnaytiS0cx?=
 =?utf-8?B?elJIZ2szZmEydHl5L3JyekFnZ2U5bGZSZnhuaHVXK3VIWkNCc2pPYlBZQ0tp?=
 =?utf-8?B?d2RNaWVFV3o5K2x6UkllejR3aEMxV0ZYRUxDUkNIc1FEUWRpR01iYk5tSG9S?=
 =?utf-8?B?TXorYUNRK3NOUXY3SnBWV3prRzZPMVo4Wk1NVmtKS2pVUlBPNytHeGhBaWpN?=
 =?utf-8?B?QVgzQVliNDJwNmxVN1VXZ3dNQ3lvazlpbjhwYnlWWnI5UnNNd3NFMm5Mem5k?=
 =?utf-8?B?Nm1TTWkyYnBzeXlOditiUTlXMTlRcTNtVVNLQk0xVUNUYlp4UCtSQUluVzlt?=
 =?utf-8?B?Zy9zKzhaREtZUVNWQ0cyZEp0clppaDBrTFZyM2dRUnV3NW42WEVScTBKZ1FT?=
 =?utf-8?B?dFN3djVaWXJZSFZjeEpCNzlpM3BWenNVWnEwQ0o4eStxSFdTN3pIWXhRanhP?=
 =?utf-8?B?ZDJwdFN5ZDBnOG1NUUpzT2hscFdQdnc4Q2ZQeHk0S0twVFJYOEUwaDFiN1Yr?=
 =?utf-8?B?Y1QxdDUxYndtVVFOZFpnRkpTeFFvQVJobFhXMm1vZ042Ty9hTXAyQnljWkVm?=
 =?utf-8?B?K21kS1RuNlRWK1pwUDZIYW4xclRnb0greCtmRHVzT2I3aCtXNW9DNW1aRGJD?=
 =?utf-8?B?ZEtweVZ3ODNjSzlPUXBrTXhGb01HcFN0NUVsajdSVkxmYm4xSm5mTnJEd0pt?=
 =?utf-8?B?TjRHMzN1L3FEUTU1YmlaMlc1bjl1anhuSG5Uajk2RXJzNDR3WlFJdTJob2Q0?=
 =?utf-8?B?a3g1cmQyMFpzMVJzekVGaWpRd3E0czBoVXRHOTNwOEQrQVFxS3E1a3B6VUds?=
 =?utf-8?B?R0F0VG1tZ09FRzUrQ2ZhenJKcUY3eXRFMjFaSDlUTUNiUXF6aHp5dThSVEx1?=
 =?utf-8?B?UklSdUFOSUdyQzlwTmhvS2svbk9RSmRUYTdNOExieXhxL2lLWCtLbHp2cjZ6?=
 =?utf-8?B?dHVtZm9IMWNDVDBlWm5Wa3JJemg5OFZDWnpaYWpLRkoyTUhjZEVIa0Z5Q3Jn?=
 =?utf-8?B?OUNqRzJqMlcyNktEYnIra1lnN3R0ZW9jNlUyaE82bjgwMGJqUWNUb1VKSEU1?=
 =?utf-8?Q?R14zyn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 16:16:43.0126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f34a3b9-62aa-473e-202e-08ddfb85c03e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC8B3B7859
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

As part of enablement for SI and CIK in DC Timur pointed out some
differences in behavior for common mode handling for DC vs non DC
code paths. This series lines up the behavior between the two
implementations.

Cc: Timur Kristóf <timur.kristof@gmail.com>

Mario Limonciello (5):
  drm/amd/display: Only enable common modes for eDP and LVDS
  drm/amd: Drop unnecessary check in amdgpu_connector_add_common_modes()
  drm/amd: Use dynamic array size declaration for
    amdgpu_connector_add_common_modes()
  drm/amd: Drop some common modes from
    amdgpu_connector_add_common_modes()
  drm/amd: Add name to modes from amdgpu_connector_add_common_modes()

 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 41 +++++++++----------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 ++
 2 files changed, 23 insertions(+), 22 deletions(-)

-- 
2.51.0


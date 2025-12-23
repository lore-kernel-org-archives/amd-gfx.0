Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C24BE6F090
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Dec 2025 14:14:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EC0410E1B2;
	Tue, 23 Dec 2025 14:14:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QXZ/2Btw";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011059.outbound.protection.outlook.com
 [40.93.194.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2751110E1B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Dec 2025 14:14:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxTPR/gZn0lBsXECl4YizJV2UiApddfT/ME5lA7VmjhexZElM1b1EeYBXKRDTwqLcD1EsbvHvv1nw5fkomHB4G8stuOe9MAf7+4A0lAt5PgkJ+t/1uiW/441blIVb318G79aqlclWfMJufqCjTqJu0LkFpBIo3N8ZmlGxzbrMjisn/qXp5FPMR7NB2NKBwdmb2g8RhDpjI/PIKne7HK2jaxg1df7aFbjYdqJIK+AKEmpSGWK4xPT3hBCXs/BRrJ8fi04l8cu9IebIMv1NkjvbWk/zd1FUwVWzbJJsXoUET6RQ2N+JXEwTXhg4E9LfUkXK1kHtXbTL7TFIWBzxZk8rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gVbJ9638ldSqcW97S9QHWkKiHbrXdLkNdzaZj4uc0U=;
 b=XzKX2sMY06H84dzCbKSL6lt9PwmlWVhy2pid64/QuRe/nqZg83eTJMSRRr1BphFuiDJzGqjyw53VKMs2Zt97FX7nEM0wl3xFZWRupq9utt8vRoDy4bCWcqc7IP79LGkm9tEZdzsv2AUvUioFFSh1Ti+G7tPl7+37OUs2uLcDn6VwqkRqWmHXNekgLEIgZjrG6SCxyTWSFp2YNdeG7Ft5rTZTPJqR1eloRXEgbULdxFMFaZVB9N2bKOwAEjXrQrfBCAtYbZxlnXIVZ1Re6nq0ohs9rbnLo4HKVcflanSbsTuNtoEYRuUdasRvxX1mn9z8PPYixpixHh86IMInpqoOcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gVbJ9638ldSqcW97S9QHWkKiHbrXdLkNdzaZj4uc0U=;
 b=QXZ/2BtwcdQ2EclOul9tCCp8SqcM0dvPVV624YTF2/I6qGb+tlXuvRWrJnIHYxRls7zIMgfiJRPeo+Z+ir78e/faBT2jTrF/ysgRCXI2rBRT56rVFsKg9SmPdGLI2x3OXyrNGrXVR1UUd64GNInIY3ARKiodjP28LyoKjWpvxQE=
Received: from BY5PR04CA0002.namprd04.prod.outlook.com (2603:10b6:a03:1d0::12)
 by SA3PR12MB7902.namprd12.prod.outlook.com (2603:10b6:806:305::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 14:14:47 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::ef) by BY5PR04CA0002.outlook.office365.com
 (2603:10b6:a03:1d0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Tue,
 23 Dec 2025 14:14:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Tue, 23 Dec 2025 14:14:46 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Dec 2025 08:14:44 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 0/2] drm/amdgpu: Make MMIO_REMAP fully internal and Switch
 to OPEN_GLOBAL v3
Date: Tue, 23 Dec 2025 19:44:25 +0530
Message-ID: <20251223141427.36850-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251217092200.703080-1-srinivasan.shanmugam@amd.com>
References: <20251217092200.703080-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|SA3PR12MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: eba9feb3-8967-4df1-d183-08de422da0b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vjk2dSsxcFBpd1BMOVh3ZG8vTVFJQ0YxZTAxYVc4MHlwKzVKSVdVN2E4T295?=
 =?utf-8?B?R0U3ME9yTmhVVlgzZFlCMmF1WHF5UzYxbmdHWno2ZFZKYUkvOHVxbUIrU01Y?=
 =?utf-8?B?MTVOUWw4U0JXRzVOdWVGNjBKSUZWcWZFdzJuRE9wRGh1ZVdlNUtHcHpBeXlP?=
 =?utf-8?B?bjVkcXQ3dnpscDZlL25zK1VQMGhQaXVOQ0Q5SnFpU2FlZk82dCtJVTdXT1J4?=
 =?utf-8?B?enpteWE0K1o4aXlRZklKaHhWNHBUVUVEQTJHZmJnVVJPTHdMN2gyaU9FS1RF?=
 =?utf-8?B?aWFWbjJId0VPeEd2L0E5aUJqL1RRN0ZXa1RJakYvOVg4cVB4VEwwaGxpR0lm?=
 =?utf-8?B?Z2YvL0NmS2tTL2JvYzdDMXYzamFDUFNGd2NKb25JTGQ4dGVFV1orZmR0TDA4?=
 =?utf-8?B?d3pwVTFxYW1wTlcva3VKVVZJb1ljY0JSUUVvRWprckFDVmdQZkxPdEtMUjZR?=
 =?utf-8?B?S2Fabk8yT294emRMOHdMNjdwR2FEMGI0T1N3REcyeCt2RG1oM1M0ZmRPNmFR?=
 =?utf-8?B?WUVHUTI0Z1krOTNYRFpTQWZpRUVCMjhUQkw0SklJaktPdG5uSm5tRHpCdlY3?=
 =?utf-8?B?OUpiUkp2REFiVDJ6dCtTN2ZKVldsaGRBcUlYVWxQYUJGOFBrQi9sQ1BFZ3Fl?=
 =?utf-8?B?YndXZnc3R3dzN3Z2VnhPSnZOSmpjMWlvVktROExield1SzlOWGxZQ3VTQ2VQ?=
 =?utf-8?B?c1NoVXdsbEkza3RmS1Uyb3JlYTQ5U3R3eE9lRFBwOXFJc0NaT1JYZDRYSEtN?=
 =?utf-8?B?cU5Va0Rwemk5WXViR0ZFa2dOVGZQTE9KQ2lEYlgzSWJCaUlVSHZvdVpreFQ3?=
 =?utf-8?B?OUR1NGhzNlNJb2V2U0Rnai9hbjg1NU40bHNLOUZiSmR3ZWNoQkVwV1plaU1D?=
 =?utf-8?B?Z0c5WVJGcFE1YmtWbkFLY2dvb3RnQ2xDQnNqWC91dUtmZll0dEZ4b2hpWGZ2?=
 =?utf-8?B?WVRmQkx4VnA4cVFHdVV0a3NEcTZBWWJUayszOG8yRE5LZ3RtcW53cHJ0ajdO?=
 =?utf-8?B?OEN2eUYyamY1K2wzZWdkeUQ0bWkySmJ3ZmQ3RE5lbkZGSnRieVgvSVY4K1BD?=
 =?utf-8?B?T29xZXVlb3o4Q09QS2VuR3pIT29HaFNxWUZvdmpGVTRvazE2d0pFY0UxalZr?=
 =?utf-8?B?cnFSdGZ0UDFHMUJmTHFTYXhpQ0lpd0ttQTFDV0JzZTQyS1FCdXZZSHFnOFNl?=
 =?utf-8?B?ZUp6K3hmMTR6c1ZOYkRteGtCMldqZFR2NXFQNE5RWmhOb3dUM2dZSjNDK3lm?=
 =?utf-8?B?bUhXWVNweHpRTXowWkZCdUFxaExYTVN5dlkzZ005ZkNGaHlsSTNRQ01yRWFv?=
 =?utf-8?B?UXNKTndPS01VZWZvUEdvTzlWeXd6YmQ5QTliS1ZseDh1ak9BMnp3S1V5YkhO?=
 =?utf-8?B?TVMzTXVCV1F4MEhsWTdhakQxVzl2cWZXL0ZvZUlleE0wckFTWGpuMWpDY0JI?=
 =?utf-8?B?WTdHeGtRMjhNV3R4OFB3MU9NbEJOQ3R5N0tKeFBPbjczbTUyVTR5c2c5ZDBN?=
 =?utf-8?B?QlBJdHhPOHZlbk5FaE5pQkhpUWZtZ2VYZ1FqRGd1ZjJlclZhWWZ5SG55czRU?=
 =?utf-8?B?LzV4WitkYTNITmFPdlVVc3RJajhvcURYcEx0Nk1yTytyV21kZjkrK3doQ2Zo?=
 =?utf-8?B?dlZLclExOVhmK25UMDE5ZERkVkwva0JVUGg2L09KMnBUU1YzakZ4RGI1MTN3?=
 =?utf-8?B?TzEzNGpFeTJmcVp4enhGY2RidkZtZ28xV3lLNk9iMTBTbVhkVTF2SzVqT0hD?=
 =?utf-8?B?Z0tHQXZkNWsxNUhkbVhQTXE5ZHVJWExUaHd4SlozZG9EcjI3SWE3OFhQYi9G?=
 =?utf-8?B?NDgycHFIRVpUMFJBUlk3Ny8xVWhzdk1iMnNlVkNkN1ZJa0NuOS9Dem1ianFW?=
 =?utf-8?B?TkpJd3dRQ3BCVmRYYzQyYXNvNDNQa3AxdGVTT3lNZHRUeG1LWTVUL1ljK0ZW?=
 =?utf-8?B?QmM2ZXljZTZvUmdKV0daR1V2WFdHMzJKNmpSTXVvSENUK0FOMFc2RklXU1l2?=
 =?utf-8?B?NENXVDgvait5SXNXK2VIWHdVbmVoWkMyakw1QUJTQWgrbTVDK3c4aG1uempj?=
 =?utf-8?B?dU9KdDdSdnZpeWF5aXBCL3I0eGs3QWtickJzbDRIRlEvWmdYUXZZNG5TNHh0?=
 =?utf-8?Q?teMI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 14:14:46.8783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eba9feb3-8967-4df1-d183-08de422da0b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7902
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
#1 drm/amdgpu: Rework MMIO_REMAP BO creation Allocate a global MMIO_REMAP
BO without relying on a GEM domain bit and pin it explicitly in the
AMDGPU_PL_MMIO_REMAP placement.

#2 drm/amdgpu: Add AMDGPU_GEM_OP_OPEN_GLOBAL Introduce a dedicated GEM_OP
to open global BOs from userspace, avoiding special-case behavior in
GEM_CREATE and removing the need for userspace to know internal BO
parameters.

#3 drm/amdgpu: Drop MMIO_REMAP domain bit and keep it internal Remove the
unused UAPI domain bit and adjust accounting so MMIO_REMAP remains
visible in fdinfo/mem-stats via its TTM placement.

v3: Squash patches #1 & 3.

Christian König (2):
  drm/amdgpu: Drop MMIO_REMAP domain bit and keep it Internal
  drm/amdgpu: Add AMDGPU_GEM_OP_OPEN_GLOBAL

 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 47 ++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 21 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 77 ++++++++++++++--------
 include/uapi/drm/amdgpu_drm.h              | 17 +++--
 5 files changed, 108 insertions(+), 56 deletions(-)

-- 
2.34.1


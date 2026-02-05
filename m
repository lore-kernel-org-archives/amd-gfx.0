Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782ADEC1E8C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 10:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F110C10E876;
	Thu,  5 Feb 2026 10:00:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YSRtZxTB";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010067.outbound.protection.outlook.com
 [52.101.193.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B205C10E871
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 10:00:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zP9OZ86AphPjRJ7jtohBTh7RZI108nZ3VnSI1XVBDgIvLmJVuAN+oP/S5mNaIyf005Jblu4bB7X1vN24gE/ywwKLmPZcXO64Tdo0wZg1+0wRB15Wmy5bFFDMBXaXIkGduTlFA29AqvMGjLsM1ozm5gkm1bJEGWO3EEyUTLqKmxmgkmno2CPvzSBwT0I3sngoH5zx5TddxNWFcwHjjUEXdEF7I9YaEL6sITG2PG5xXS8idUCiwLYh1Bm3wzqPZlVSurDRFm65d+SQN2vyXR3wwPaOXgSxX+MjxnlRakEsYpxfj256UN7aASZELULjFnWr0JYkVq8UlylrmVCcc5iTcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r1eV1ENdphGpzh5Y0xbDvw8EcOMb21n1+cjXiM4/Oj0=;
 b=rh5GvOKuyOsSCVnaR78XJwJbl1/xqg4B3iS8rygEG6PLUDvonlJoXqAGIAv8DKZwHRCWso9Wzv2ptSCo3lYh6S+ZlSNVK5cgoEB+5qG64vJEQIpajhgv3bH4VC0oHVTy0VFujv9GBMq4lQ0zIFCGWyATcguQI490bTWSi2CYF+ELY0pbkhgH8CUfrMxWGrSokrgeS5mO3xGTA8lWIWOP3cVW1SBbqHCL7rF/daw2kAhfW24ptMSic6VKoY21FEa79Z+41O2tliD9fPM1aMW/XjulqYT9qzOzEKudzgSpFieSzXNKNd/yQUWRyJ9Mvz3hTbTa4cw0R7iLv3V42TbaxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=ursulin.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1eV1ENdphGpzh5Y0xbDvw8EcOMb21n1+cjXiM4/Oj0=;
 b=YSRtZxTByMy2PP6n2jBaPo2OYxqMkjYaLPNIP+9BGCWIIulGFMU8uZrEWsLqgx8EiPCpy9+6caErxeKq/FtDUazMmRLuPEcCJodf9mLY+/IqCL37cz807+40F3Q35GMqH+rjewjuNKQYQhPJ+6BYzHmdQqFHP3WzZpZCnGWeWRo=
Received: from MN2PR14CA0028.namprd14.prod.outlook.com (2603:10b6:208:23e::33)
 by SJ5PPF1394451C7.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 10:00:21 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::1) by MN2PR14CA0028.outlook.office365.com
 (2603:10b6:208:23e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Thu,
 5 Feb 2026 10:00:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 10:00:20 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 04:00:18 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: Tvrtko Ursulin <tursulin@ursulin.net>, <amd-gfx@lists.freedesktop.org>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Subject: [PATCH 0/2] drm/gem: Document drm_gem_objects_lookup() failure
 semantics and add safe helper
Date: Thu, 5 Feb 2026 15:29:55 +0530
Message-ID: <20260205095957.278704-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|SJ5PPF1394451C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b47a823-47c1-46cc-d1a9-08de649d5f59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUp6ZWl3TjdycnJjVWc5bGxIZExKNzZ1Yk8rSDZhM2tTYWkwdytOMGtzV3NU?=
 =?utf-8?B?dThxaGxneGovTkV1cVBKUlZCd1Ywbitpc04zQklER1FVZkRJWHFwRGpkNFQ2?=
 =?utf-8?B?RktCeHNrYnhjNlRTakFpQlhVZnJRV2tOaGRwc3hHcFRmbHFXaHhHZmgzVGFP?=
 =?utf-8?B?TVQ3ZXZTRXpuWFVPUks2MFhOZlNOWDVkc0xCOEhuN2JCcUxlOEkwZklVUDV3?=
 =?utf-8?B?YUhKeG80OHVzeGZsSWpKOW5PeExuYTFaZEZ5Zlg0a253YnNueGFISXhVSEFV?=
 =?utf-8?B?WXNHS2xONzVDWFNWQ2FJWVlXQ0FRci80K0JyYmxleUNDdkc3eGFlK213VkZQ?=
 =?utf-8?B?WHZpTDY5QlprNzFLaElxZCtzZ3NjWkJETnh0dFcyZ2NtVE85WWo3QjNPc085?=
 =?utf-8?B?VUlCY2ZTZXdHZFlVdVAwd1hSMjZNNTNDVmh5Ym85RzBPZUdaa2JXNTk4MCth?=
 =?utf-8?B?WEpzeitlM3MzVmcySUdZM2NWVXZxV1FSRHJiMTNjN1VXM1VET00waTlpdlo1?=
 =?utf-8?B?M2hDMDJpQkkva0h0ZE4rYmMrUUNpMXVxWW9DYThBRld4cGRJby9PWE85ZGlY?=
 =?utf-8?B?Vm5JV01IUXRaL3FsYTArQWM5dzYwMUwzWmgwTHAyVmNxR3I4Y1U4eG1jTnJQ?=
 =?utf-8?B?V2pOT1YyRmdCbDRGMmxqT05yM1RvZnZDWHEvNFFrWTgvQzFlYTE2bmd2UVJC?=
 =?utf-8?B?clBlRTJEVGlsSUg2ejZFTkk1V2ttQ2FNMEsrS3hSV2hVdlBLOXFrREVYdXJM?=
 =?utf-8?B?VWg1VExYQk5oMFgrblhPTEhpa3llbXcvcXhGVVkydThBS00wSGxhOFBsSTBy?=
 =?utf-8?B?RjZwRzQ2OXcxdFVZUm01N0JrYUVXTWNiVGRLdFkwSW00T1RMYW05MkxrQlpo?=
 =?utf-8?B?eXR2SWYxS20yaTE0L2ZMNUVDUlMyVU04VU52RUJGQ2kweUs2ZjB0VWl0d0Qz?=
 =?utf-8?B?SE9SVDJGQTY5a25qUy9MKzRhWkp6RVhlTXdIM3hhaTBOZVE5QXNYd2F5ZGNQ?=
 =?utf-8?B?MUMxUWR2S3NYYlNoQ1NtZWhoaXRoZFVSbEJaRlk0dWl1cnRnVndKeTZxYVAx?=
 =?utf-8?B?bmhxb2QvVVpIQ1Y4UXp6REt0d0lLUURRNXUvRklscjlYUkRmYmFOUTlwa1k3?=
 =?utf-8?B?OWdjRm00RzdhdXRVSzR0K1JOVWgyL29iZi90U0FOZTJwNXBqc2R2OHJTbU5W?=
 =?utf-8?B?cGRrZERRbko2NnBmOXQ5aEJWdkZMbWlWaEtoaDN5eERmajJoc0Qvcm9ldWhn?=
 =?utf-8?B?RTZTRGZxdmwyeHFJLzUwanEySHlzU2Nab0dsQU9tWFQ1VGlBbE1VVW9WNmdC?=
 =?utf-8?B?azhTaDdNdjg2STFyZk82OStSNmFrV2dYN2JNVnpmRG5LNmh4aHJRWjRQN0di?=
 =?utf-8?B?bnhwWWZKVnVBS1NUaTlMdmpDZlNwWmpBNThDTWJldnJaOVhnNVVZQ3BqSGtM?=
 =?utf-8?B?ZFh1OHRqV3VzU3crbnJXb212UXdrQktiSzhraW9vTmx1cnRsRk5POXl4bE9G?=
 =?utf-8?B?cWtFakxRcGxWNklMa3lFNk1EMUJDNG1TRFpVb1pBTG5iMmhXT05FbjZIb1Bp?=
 =?utf-8?B?YWl6MlljNmdVcXBXbUJ5MGdwMFFjNHpxeEk2c1hxYzBIRkZFU2pyUWdPcFN1?=
 =?utf-8?B?VmtxQVR3cm9iUXJlU0RLanFFS29SS0hmMmJJM1VKWUZ3UVhsditBUkJwalhn?=
 =?utf-8?B?ZWdJdlZJSkU3Yjd0aE42ZitFMXNCRHlrR1NHTkI1YmtkcGpwRk8vWlRGRzlr?=
 =?utf-8?B?M1dBUjRBU25zUytZYk9WNlRmRXZPclRSNFgzakNad2VCa0t1Zk0xV3JKTDBU?=
 =?utf-8?B?OGtTS3o5d0JnbGIrZjZOeCtRalZMWlVaa2pya1JkMHduUzg2WlJyS3F0cWUw?=
 =?utf-8?B?Q2tFbWlPZWNKOHVzNmVEMEV2cThkTXF5Rzc5ZG9UdVUyK1d3elRMaE9jSjFa?=
 =?utf-8?B?cEdvWkNmNkY4VjM5Zlp5ZnJXV3Y4R0I1VjV4M1lpSUp5bm9kaTVvNlF1ekN5?=
 =?utf-8?B?cnBJc1o1Q2VJUGJLQktKTnFjdGtTakIyOXcwd0RJdlhyQTlPUC9PMjNIZnJW?=
 =?utf-8?B?SzlBQkNneVFuU1p4SnpXN2dndFh0amFYODVqVUNnNVl5bkFwcUwvb1h1UGg0?=
 =?utf-8?B?Y1J5Q2YvVElxWE1CMkd2UGk1SEhpenFGbTBIeE1TR21qb2F6VFFzL0t5THJP?=
 =?utf-8?B?STFqZDFjNXFBM01EclgyL0RjN0NJZTk1NERBaXV2TWc2ZDZqQmt6eURWWWhP?=
 =?utf-8?B?NktxLy9Mbmdvd2kwem9STEUrNGhRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UG5DktaqlGGistk7JBJYXn1IWr4Zyd7Dc4Qw2QL9crqdohGs5k4kUl1f86Qfl+euUGMM93ElRtKIkEnBYn0iSy/6PRSvC0kokWEhIaqpf7YjiT4qd8tSbeM9UhzXQP8DUqqhIsHqVci9Q9fIKA1A4wUTNVkJhz42B9p1AsXhiC4DBNm+2hUDCN8kQ0Hpm7XvsZNF5PHaW4Ux6MP4XF0/cMsYwi6okIh2CADVnsp3NZL2asoDPVbNKX0p5UA77jNFwVHOuWr6+36/WgKLHAyjG06Xhzqwan37aJO0Q1XH87RtszUxjQM6lc0rmcNmNM7wffSDlNbzszUGUO+vPeGJLvU1KkcE2ILMbJAA6oubqnNYMmVOPuJNljrTrCzGo/ryNttRI5DJrOOoH8Pqx6yN1Wi1mJjAbE9DPOVXmdrL/5HbatQKcBqWzDF/OFE3X+/t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 10:00:20.5116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b47a823-47c1-46cc-d1a9-08de649d5f59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1394451C7
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

The drm_gem_objects_lookup() helper allocates an object array and may
take references on entries before returning an error. This relies on
__GFP_ZERO initialization and is not documented clearly, which makes
the API easy to misuse.

This series:

1. Documents the current failure semantics explicitly.
2. Adds drm_gem_objects_lookup_safe() which provides the same lookup
but guarantees cleanup on failure (puts any acquired objects and
frees the array), leaving successful behavior unchanged.

No behavioral change is made to the existing API.

Srinivasan Shanmugam (2):
  drm/gem: Document drm_gem_objects_lookup() failure semantics
  drm/gem: add drm_gem_objects_lookup_safe() helper

 drivers/gpu/drm/drm_gem.c | 68 ++++++++++++++++++++++++++++++++++++---
 include/drm/drm_gem.h     |  2 ++
 2 files changed, 66 insertions(+), 4 deletions(-)

-- 
2.34.1


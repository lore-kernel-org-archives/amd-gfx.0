Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A7CC87FCB
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Aug 2025 03:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A82E410E2D5;
	Wed,  6 Aug 2025 03:02:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JBXgPre/";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 027EF10E2D5
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Aug 2025 03:02:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDvQjxQ1u+1574FKs5mZUIt9S/DV+YxGrqr+pUwpG9n8TxhkhhXRnuX+ir4VlWJqmfn/mDOXrsLV8cHNxAFfxdAoD1wq8qc1fVBsIFwuGOCdA4YKpUu4vWjN7iyfvLdrXipOc4JnW6ijD1WbXN49zjE9yxCnw1eCPpO4976+vdq3jZpHO5+TS4w8XubqzU6CZt2oij+Jhg71G7ebPbQJdaZ7QniXaaWemZV6G/XS/H2w/gQC6ihzin3siFOktksFN3adsebHA0vPokXD2MeFQukB9Yo6ty8KfSA9KyMmStBAdbJgNKdtJb3aUWhq74StjSJSHM6QvP3ar1TtR2QhZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7hPcOt9eh4j0Dy2/HpcB5+059Y9CgMMNnhjkKG+FVFk=;
 b=VcvLyMaZkv6NgfTDhx0XaWr3lRG3rKeYY4ZfmrcujYjAESXaByQrpwtv0myZ53tT0l8vTjr2UmA7gj2Z+1NlrPqGx/42HNpk1Dp8vTlG5IkkBXxJgXMdscYlHXsy4G395oULPRE1eJNemj/cPpmRdclBd6kUmtIKGmR0ti0bHuoOPHQHAw5MNX6LFQETCq3Dz7SC+JJcmcLBIFj2HJthODQbRGYkiuoTMBb9SHm+Tj2xt0F3OFqEEdrK8mfaQ6Me/CTlDLQBPnidcVC3ldi9HE9EHycdCuzmZP1QC8WUaEkNp/K6C6IcR8EC2W0crQGnjaMB015T0/BwQSgaBwRjGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7hPcOt9eh4j0Dy2/HpcB5+059Y9CgMMNnhjkKG+FVFk=;
 b=JBXgPre/r07CCqIXkO/ZKrF2+dF/AVjzSptmWIIpCBP9tX9Xp8bFsGKhwGMCnhK3scubQLnao9xPqrP+ywNUgTNaz0iQJHLUg1UXf3Uon+LRyWRrSj9ENrIujM4lo8Yhgk+xj9HoXY1m7y3c1tInGETyRiwQ6ah2kr4tGl6BqgE=
Received: from BN8PR04CA0022.namprd04.prod.outlook.com (2603:10b6:408:70::35)
 by DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.19; Wed, 6 Aug
 2025 03:02:39 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:408:70:cafe::34) by BN8PR04CA0022.outlook.office365.com
 (2603:10b6:408:70::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Wed,
 6 Aug 2025 03:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Wed, 6 Aug 2025 03:02:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Aug
 2025 22:02:38 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 5 Aug 2025 22:02:35 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 0/4] DC Patches Aug 11 2025
Date: Wed, 6 Aug 2025 10:57:09 +0800
Message-ID: <20250806030216.21096-1-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|DM6PR12MB4203:EE_
X-MS-Office365-Filtering-Correlation-Id: f480303e-41c9-4c6a-df68-08ddd495b3ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3JGV1FPUDcrVmw0ak5Bb2ludXBkNU56d3dHNTVyZlVkZGNDU2JyT2V5eTJQ?=
 =?utf-8?B?eE96YU0xNmFvUEdCaUV2Qld3NEdMTnd3eW5NTmJYc1JpR0YxQVAxNnYyK0po?=
 =?utf-8?B?a1pTMnUxck9EVi9KUE5ZNTd0N2d3RCs1M2V5ejEyM2paeFZCUy82SjdJS3p2?=
 =?utf-8?B?WEEwU3FTNVFqS2xsRDVjQTFkWUhFcCtWYVFQQ0JONWxGZXU1WVhuc3pId2VJ?=
 =?utf-8?B?OS9Tc3NzMld2VzFQaVJ1cWlNMTVDRkhUVG1XOWNsVUhySUtlemZOcTdzMUdh?=
 =?utf-8?B?L3RlSEpjQy9lWWpPYlUzUldHMURGNTZ3emlKcS9vWUNQaHBJVGdJUVg2Z1pZ?=
 =?utf-8?B?KzlJRERTcVVEemI3RVRWeXBkcm1qSS9qNzlXb1ozY2hpdEFhV1hCTjBwTS9s?=
 =?utf-8?B?ZnZXRjdOS1lKbjlyN0N6N0J6T0VJQkZvRHd0NnZTemx4NXdiOHVQOWZBRTFw?=
 =?utf-8?B?bWxtYXlOTnVmbXYvNTVtVWRqR1VrcW9Vc002REZNMVQrWTdua1gyYlYyVTYy?=
 =?utf-8?B?dXBKNTFqZFZqbTdYQ0F2NHdrZE1hSzBxeWxraWNaNkozanRzTCtob0F0WUJO?=
 =?utf-8?B?VkFQNDJ6SzJKN1c2WEFucEJOVVI1NFdjZENpcGkyTGYrM1VZRFJjb0xBeFJF?=
 =?utf-8?B?Vnl3V0UyQ2VyWGVQUDFCRTRrMDM0aFZmTEVvYWNKak9tSXNWYjRVU2s0emww?=
 =?utf-8?B?eWtZRTVES2tDa3czd2hqeGNxQUdocHg5bUVubVRXRTJTWEN6OE93WjI0WVR6?=
 =?utf-8?B?VStrK3dTZjd2SXJ3OFpKWmlrL3NKalNOUFpPMlMzL3dia25MdHQ4VXpuc0Iv?=
 =?utf-8?B?aEUvVC9ZTVNFODA4TmxQOXcvNGMyY0xhdHd6c0dJMldrWmgwR0xSTmNiVjkr?=
 =?utf-8?B?Lyt5ZXRYQmU1RDk3THptMGFpSnJwY0xYRUlyVW5wbFNXWGZjOUwzdEd0aDA1?=
 =?utf-8?B?RUJsQ2VBamFhZWVBTmF6R1RVcmFTVmJBTU9UNjVoOFh5djdVVVYrdGp1enlN?=
 =?utf-8?B?dFRZRlM3Sm9MYWJOLzZ6TFl1TU0yRTNEY2xzMWdHekswajBMNnc2aUNUd1FZ?=
 =?utf-8?B?R3pRYkJKT1BVR2RONlFRY3pFSldpeFFuaVU1WEllS3o1S3JzaGtKU2NnVnpi?=
 =?utf-8?B?elNpd0pubGNrY0kvYTZMRXlpdENoVGVoRGVQV2Q5Vi90ZnNrU0V5aXNQMnRO?=
 =?utf-8?B?aUV6VWQ5ZlE4THh5dHFDcHVoKzlPd0pRODZyOTFOTWphU0hjL3lEV1pIZm0r?=
 =?utf-8?B?SFc2L0daRTZEemdMbjBSY1VtbXFIdU5DeUZJbDdtU2VMemQvQVBkYjVUaDFE?=
 =?utf-8?B?Y1VWOTRIR1FpV2Fzc0VQdGhFek1PNFlMMmdBTDlFWFNHQU02ZWR5ZmNVQUZH?=
 =?utf-8?B?clNabVJGQW42ZmlPaTFmYnpEdU4zUFMrSEhEWHFTYXplY3prNjZmUEdaemZS?=
 =?utf-8?B?TTNRalR5VXNZbGxGVDlEYnZUMFRITUFkNlJhdFErQTJHaWRlaC8vWGdZRloy?=
 =?utf-8?B?cnVZK1BXeHRvSkhvaFBKV0FzQzYwMW9LSkNmN1luVmpSSEhvM25JVkVpaWN5?=
 =?utf-8?B?c3JyRFBkZTB0ZTFGQ3JUZGUxS2RFNFdpd0cwM3VTRUgzZXVEcXpkZmR1blR2?=
 =?utf-8?B?c0t0SExRcW0yczAzQkw3RXd4K3R2emZKeW45ME5ncUc1WDF6NzZsNm9zeStm?=
 =?utf-8?B?bS9CaWNnMnhsNlZDdXNTb253eWxQeEV4Nkd1M0FMYkpPTDJZZXhwRnQwZEI0?=
 =?utf-8?B?WHJqUUZCdFZ4ekJKdklGcW50ekN5UEwzREZWUDlTdElnY1pKK2dCNWlLMy9x?=
 =?utf-8?B?ZG5GYXp2bzhobDkxbitUdk04M3JBdVRhK1ZNNDRobWR3M21QcUFzckllUTJR?=
 =?utf-8?B?UFF3WFljcTJzc3NCaFVzQkJhRFhSSlZMY2xPOEpBYjJNSlN5U1Z4M0hTMHBh?=
 =?utf-8?B?ZVVERjdhVUM0aXgwU3RqL1FTaHA2cFEyamZrQy9pYjhxQ29ob0x4bTVLY2dB?=
 =?utf-8?B?SG5WVFBFSEFtVWNUTmVtN2oyVEdLSUtKNU9kaENJeFVFaEdlcHZ2Z1ZuM0Rx?=
 =?utf-8?Q?ZeZZmH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 03:02:38.5650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f480303e-41c9-4c6a-df68-08ddd495b3ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203
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

This DC patchset brings improvements in multiple areas. In summary, we highlight:

-Fix close and open lid may cause eDP remaining blank
-Fix frequently disabling/enabling OTG may cause incorrect configuration of OTG

Cc: Daniel Wheeler <daniel.wheeler@amd.com>


Danny Wang (1):
  drm/amd/display: Reset apply_eamless_boot_optimization when dpms_off

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.22.0
  drm/amd/display: Promote DC to 3.2.345

TungYu Lu (1):
  drm/amd/display: Wait until OTG enable state is cleared

 drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |  5 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 69 +++++++++++++++++++
 4 files changed, 76 insertions(+), 2 deletions(-)

-- 
2.43.0


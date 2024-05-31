Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351C2C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 045CD10E080;
	Fri, 31 May 2024 16:08:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PqPJQ3mA";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A23810E080
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:07:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdQjMxhizx8CFSgmJiOzH3bEzmKdukbZY5WhZg4EU0NfYr+NfOl8zpzrgheo2bpNlgD9YR2DbYsFJ1tHY5h2JeH3uWxEkzclA6z/adsMJZIrTA5wipO7lp8aCgO5Auuq176hezsh4hGEKLgjrmc5CADmceox5jo9fFZPeYUNrKcfh0ODodEBZyvSATrlRYEfDdgUgZoMR6xkwz6mfzeaPjQEUY4Z4RSq++I8J46NCOSoNJDAQKTnNJ+mzJZ5OPx8aDOxGpFZKm+69kgELT+qoXGaj6um/nHxvHHxG96ROluQyF96FR3zr18M/92Bte3MDonbT1E8sJIy+UiHg1ie3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uL/3wsK3DRX2KoxhLqWCsTaXSQdycWPox8PDB1JEBG8=;
 b=PE/m/gQmHCacfkKzarTZ1Ph8AA++VapUO2jlxyYt0GLoxBzca6UOE3/ojf6LgWSVbLJYO2PBxB/tBRIQONT0JT7NbfAzd7/HOZQnRsJ8Ow+xkdjWZMJpg7ofe3UouXsv/HWqL/o+OJ6+9iya9HjZOhRjCW7P3Ikzuko2khyzdep+6VEWM4Kueh/Q4VItpmXpNaQtLUoeTrOynj4Z8GtJ6B+B42x9S7BFSrI9hX582MtG5Cf1QnayNqyTdK/GqCypiNycZoZ4CHhsz4zYeiPAhuMCTeeqaWHDYtnIWyNr9j3umuUi1AtKHv7xtQKaSdlcg50S9HyRY6ErIuhmmNIVjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uL/3wsK3DRX2KoxhLqWCsTaXSQdycWPox8PDB1JEBG8=;
 b=PqPJQ3mA+erMDAjzsHSlBvEJp7UOTd1xorfAm+201hg3HX0bHYEVDcj2F2E8DogYxWU9lOtbAuCjeaqTkierU4lp9/St5oRc870i0RAIhECLFmNBKrpjhztAv+fd2U0A3smnYtZLRVjXnUDSzu2uauzoqZTXrCsY+LUoVtcUTB8=
Received: from MW4PR03CA0048.namprd03.prod.outlook.com (2603:10b6:303:8e::23)
 by DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Fri, 31 May
 2024 16:07:54 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:8e:cafe::59) by MW4PR03CA0048.outlook.office365.com
 (2603:10b6:303:8e::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17 via Frontend
 Transport; Fri, 31 May 2024 16:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7656.0 via Frontend Transport; Fri, 31 May 2024 16:07:53 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:07:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: define new gfx12 uapi flags
Date: Fri, 31 May 2024 12:07:31 -0400
Message-ID: <20240531160735.3547360-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|DM4PR12MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c28f614-a870-43d0-528a-08dc818bd3ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWZIR0Jha3RxNDQxa1dLcnZxMGlmY1d6YjBBNEYrWDQ1NmJhd0JQNm1EWmhp?=
 =?utf-8?B?NjNrM1BHamhQZlAyaUZRcWt3NVVEcC9BWUVHZlRUaFVRM0tRbWo1T2JhL3lT?=
 =?utf-8?B?Q0xzMHNxSlNkdFY5TmZGVFNOYUc0NVhGa0FUb3RmRDNIUzdUWlE4LzdLR2VL?=
 =?utf-8?B?a3dtZzdOWVFmZ0Y3MDVHVWtEaVkyd3RHalRMWjBxSCtkTVd3MVBqSU8vZUZW?=
 =?utf-8?B?RWJoU25QbEFwNU1vL2xqVjBZNVZNcmpiWHF0eUdud1F1SXpMRkNTc1hlalVJ?=
 =?utf-8?B?ZnN5b0U1R09JdUJZMXZDRzI4RlZFOFZkeVNEYnM4aXB4QU5ZS0VLMUdVZVhv?=
 =?utf-8?B?Zy9PeHR4YWorTkNCenplNnpDOXZTR3Fxbk9MamFqRDd4V3l0ZUw0V2V2eWlG?=
 =?utf-8?B?VGQ2YVhselJmV0JlNEVVV0l0RlYvZ3B1Sms4MkNDcmkrUDFVbUpST3ZPTTVx?=
 =?utf-8?B?MFQyZmh6dGE4WWRWRkpnS0RFNm40SUludnNjMElaWFhaaWR0eVVmTDVnZzZu?=
 =?utf-8?B?UVAwdkZYWHVXUUs3eXV2R01UbHJTcUczejk0MUtuMFRiVUJuZS9qQWNzUTZ0?=
 =?utf-8?B?ZHlOczh4M2ZPT1o1Qk5RbVVzYk1qNVo5c3lYeG1uY3liRUI1VHUyMkxkbXZU?=
 =?utf-8?B?VTc1NC9LeW5WbStMOExmYXptOWZxT0FEczA3TU1UNjh1dGJkbjBOcThnUkFv?=
 =?utf-8?B?Smx4TUlOQ05XY09TSHZCU0p3cFBUcG5ZTGRQK1Awd0JKSVhSUTFxaVk2b2xr?=
 =?utf-8?B?ZjBVNVA2Rlczc3JQcmEyRGRoYXVvc0o1TGNxZ0M5YjhIY2lZL2wvWWdkeitT?=
 =?utf-8?B?M1JCYnFWbFdTYVFneko1dFVleDI4OHIwQ3paVmpDZXdoOEFicitrWDkvNmxv?=
 =?utf-8?B?YXNnVXFOQVJoUHB5WHpXVUN6SHlhU0pHeGJySFc0OEJJK2hPZ1RtemFWcWEz?=
 =?utf-8?B?SjVocUFmU2pKZEhzVG1NclBBaHpqK2ttRThRczErRGJ5T1hKZzRzMmlKVllq?=
 =?utf-8?B?ZFV0aGZqdE1KamtUZUdNditSRzlmdmJYQ3RYRk5pVlJKSmdYNXZTbXkwZjQz?=
 =?utf-8?B?RStLMXhFaTJmOGdEZ0hqalJFTkVHR0wzb3c0cGwrWnhibDJFY2JoWUx2M0pw?=
 =?utf-8?B?U2VkRlI4eTBCK2NTUzhBOXRadUJkTFZMUGl5TGVldjBXS1RPbDFZT1YzeU1j?=
 =?utf-8?B?OGR3N0ZjdlpiQVB2QWhWbkhwZ0RvNnpIN1dIWlhiakdjM1ZHbGNFaWR5bEt1?=
 =?utf-8?B?ZThIekFCN1hzcGtUeU9qSzUyU0l5Zk1OL0xYYU9NK1BScDZOL1duazVtR1JW?=
 =?utf-8?B?c1laZERQZjEvcWc1ZzRGN0JyS1JXSnNIM1daem9lc0tqaEp5ODROVVVSSC9l?=
 =?utf-8?B?VVVvdVdHaHpuWXdNMVQ1N1ZkOXBjOWhnM2JZdlhORXJWTUxyR1o5Z0lPeUJv?=
 =?utf-8?B?YzQxWlhWNjk3Z1N1U0hZS0xJRnFCdktPL0M3SW5LMmkrbGkrdDE4MFN1UU1y?=
 =?utf-8?B?aGJwTzY5Ym10L0RLcm9CaThJNE1Cc1hVR3NQa05lY0l3U09rQUE3VzRxZXF3?=
 =?utf-8?B?cHVBWGtNWFdJWkpGQm95VUdtQzRuN0ZrQmxnUkl3RnpDTzNXeStpWWhxTzQv?=
 =?utf-8?B?ZkJ4YWxQa3FQY2h4TFJFNzVBenBDSDlpYkI4alBFRWhlNTFyT200V0FSc1ov?=
 =?utf-8?B?TFFUMVd1ZGJGVmxFd0VZTnkxRXhDa0VMZDQvYUtKL3daL3BTZCtxQk43ZnpX?=
 =?utf-8?B?WWFjKzhLbzUzNTgvU1lveHgwWHdSc2wvL3JWTXNOMVlmM0tveWltd2hWUVcv?=
 =?utf-8?B?MmRCZVNmWWZQUGZPZFBJTFFUV0RzM002YkY3WjlTZlNYazVDU1h3WCtnYXBn?=
 =?utf-8?Q?msf70ETK8na2M?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:07:53.2312 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c28f614-a870-43d0-528a-08dc818bd3ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376
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

From: Marek Olšák <marek.olsak@amd.com>

define new gfx12 uapi flags

Signed-off-by: Marek Olšák <marek.olsak@amd.com>
Acked-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index ae3f4e275f20..3e488b0119eb 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -171,6 +171,8 @@ extern "C" {
  * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
  */
 #define AMDGPU_GEM_CREATE_EXT_COHERENT		(1 << 15)
+/* Set PTE.D and recompress during GTT->VRAM moves according to TILING flags. */
+#define AMDGPU_GEM_CREATE_GFX12_DCC		(1 << 16)
 
 struct drm_amdgpu_gem_create_in  {
 	/** the requested memory size */
-- 
2.45.1


Return-Path: <SRS0=Kvqq=AK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4400BC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 12:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7ED023B23
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 12:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yNVcNlU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7ED023B23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94785899A5;
	Mon, 29 Jun 2020 12:13:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B331D899A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 12:13:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atPs4PLE1lMOTDosxxqbqZH4pcMFbxYcRZjDxva8YgH/xVZCqeLTQIpWT3Nitqxvq+jFvW1hi7E5eX96BKAhr6UIrSL7pHbomZ/uInTsjMN0EQvxvJlzaioO0vCK+8CVxdCvvf6eWkyYfMOvIO+4oM2AZwbuGDle8/bR54NpPYGm5EmkHbLDL3MLcAIIPB2GhlODKyWThxYYV6/WhXViJ+ckoHJokTDXDydQE/k1n7LCVcY9kTNMS4r64qhHBbJr1Vv62BytUGTilFwpE8b31mYsQ8MLSOY+dAA9p2ou+ipz3j6Gfz+6lcz6Om/7iJk4Tp3Epw7i9qWfVP5AoWoU/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMbpyzdYiptACJm3MvLWU75A23L7jZ1gUYEeOjru/7U=;
 b=Svb6OFOx+LrfkMeEfXX691EzFcnpUC/V5NoLNpd3Ds0evuFSVr85/QxNmmd75Ryhm/UyQtrWHm/XtiCb5lO8ucOyTvO33SJxKjHh/ve2xxhn3K/OowhgI/y0wpj3xHy+O2griOMDOFZFNUAQXoRPMSjpoGhEm1ltc/LMyhuUWvxX5mOqJ0L4zUGEH4NMLUblxwD3EOsampFqmMkDQ7kHuITPrEu3iwxc5SLuZHTpY/dLM4Jb/w3OfObrrxeK/hdAuLoiMtYPm13BP+NK36UpPWki1astmlTFG4ylCNKkIDVTr7JOC62YpHX100lCbk5NhbjBR2nij1LUnphYz0Oepg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMbpyzdYiptACJm3MvLWU75A23L7jZ1gUYEeOjru/7U=;
 b=yNVcNlU0/7QleZejengH5B7abdqF6FX1UbpdGLmA+CkfHqBvznLEILjQG/dMMYnOaJ8C+uSAMfkhl2Nq2Ld5MCW+RKCYyDR5rXAUPyrRse7duuDLlZ0oA9qgpGjP1PlHgukH9v02hQesfBTxkjkRRcpbBxHElXOBDMF3M87Oc7E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Mon, 29 Jun
 2020 12:13:24 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648%3]) with mapi id 15.20.3131.026; Mon, 29 Jun 2020
 12:13:24 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Fix compile warning in amdgpu_fru_read_eeprom
Date: Mon, 29 Jun 2020 08:13:13 -0400
Message-Id: <20200629121313.18064-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::17) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YTOPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend
 Transport; Mon, 29 Jun 2020 12:13:23 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f26628a-624e-4bbc-5e74-08d81c25d282
X-MS-TrafficTypeDiagnostic: DM6PR12MB4354:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4354C0D970D28A73BE2B5EF1856E0@DM6PR12MB4354.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 044968D9E1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yw3LxoNaSc8IPiF3R94nvcuZZGpc2+tMaWz82jyLbP4tIULkP1nb6MvAQhqtQnQpBDIVj/tag6kTusapPMNjJqhFf4P+nz251MFJS06NpYF8luz6vvUAfRR064nn7Dujw0dsqjHlctEOhbRXcxesUu9489B73rIdHoeNCFfFoNiOxCHn5hV+5FJXhZga3jk8k1RKC3/baONQnCDoGqQXGdANfwq9VUPKvPlvAbgh+BBVCsOfPppVDFGprUsxU5uXvYCej3LL/bvhNRnEsRdzL9bto395XiC+VhGIu50vc3zkuQteXMdyWXxV6YU+uNvX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(8676002)(5660300002)(8936002)(83380400001)(86362001)(1076003)(6666004)(186003)(16526019)(26005)(66946007)(2906002)(66476007)(44832011)(956004)(2616005)(4326008)(66556008)(478600001)(316002)(6916009)(36756003)(7696005)(6486002)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 1lb4yCw+o2Bh/RhKPgoNdspQhqqeT423IfmtGr1wY6XcQciYVFZlG3DxGAD1THTcH8smlo18+L2RQRs/VZmW7AkcNBVyhV96Z5NSN9LRPrv0o9m4PP95Ye4D2oAh9ictLW7nVykSJ5vGY5y4nXiqMmSRVfL3bQY5MBPZFLbbp8Uub7WaU8LYyhze+h+eOKmPWcf0hawXKph8phy3rFiLtTzm9NhHD2U7wvtSFmXGPytBgJsAVWZBPQOoRwHol/F56ti78imSErPkwvDxoxaiz+VRQLdYi2YNihPqlebAppjCioeLdxoT1TC8ryfVZkrc9MtnFqRnN0vh6pAOWUQNNe55DDzZ24sevzh6O7+DUPteQywlIfE2RmA5q3F8pe6YReV3KYPqHVm7FU0UMaTXxhp4i5gvqREgpFp5m2fYrsbw6GOYUeP11wnZ/vURlo1bprq4sMLOGqbDo22dBLOJkc9ROqe+JaVu5Q9OnwbC0aE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f26628a-624e-4bbc-5e74-08d81c25d282
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2020 12:13:24.6130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4q6CUeNH+FzovQyj6LuLn0muMGRaxfuHLKoLBiBGpgIbXX8wTZHlVMNRMU8C3WBWU6LIBn56cCh8WLdtSclwEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This fixes the missing-prototypes warning for the amdgpu_fru_read_eeprom
function. Since we declare it in the header, we can make it un-static

Signed-off-by: Kent Russell <kent.russell@amd.com>
Reported-by: kernel test robot <lkp@intel.com>
Change-Id: I2b9419365cb8b38bcfb6582df53b96c83861d6cf
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index e811fecc540f..68ed16e4d8be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -48,7 +48,7 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev)
 	return false;
 }
 
-static int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
+int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
 			   unsigned char *buff)
 {
 	int ret, size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
index f29a8611d69b..f4024f1d66c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
@@ -24,6 +24,8 @@
 #ifndef __AMDGPU_FRU_EEPROM_H__
 #define __AMDGPU_FRU_EEPROM_H__
 
+int amdgpu_fru_read_eeprom(struct amdgpu_device *adev, uint32_t addrptr,
+                           unsigned char *buff);
 int amdgpu_fru_get_product_info(struct amdgpu_device *adev);
 
 #endif  // __AMDGPU_PRODINFO_H__
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

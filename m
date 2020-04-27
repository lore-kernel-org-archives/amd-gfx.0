Return-Path: <SRS0=xwvD=6L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0F2C54FCB
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 16:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D5702078E
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2020 16:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i+R6Ox2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5702078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72E316E343;
	Mon, 27 Apr 2020 16:47:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF4386E347
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2020 16:47:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHv881fLbgFrnraJTAxKCL0G3igwKTMaaFVRfFAhlbnNfkuN/fuOCYrgmJ4s1rCo1X0rZZoVtUDfjpWJmyBOJSHCFwtF7MagyR4EdMrFP5X2205k0pSrGN+qXgqU30bYCr6S2EJpkvd94bRjegKUtFQsNjvxtRrIlYipW2qEFH8wtjtNXBNpGwqQHztJfxLx6AplEXlIpr5jzHzFEjLhP5a3KgDekyrRcaQ/05XiQrtKhzyQ/4YhnnP22HrccbPjrE8Aadw/wnO4B3gUwjRUZMa8VwLLo3ivp2pQ7kewe3g+1z0JP8F1cirILiJ74U8rf0cXHcOgamz7s2e44ZUXzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0WGK55+zao36nTKVgoMCYslBSzgJKvv2gbV+HcIYyw=;
 b=foewn0YqCzpCAAEjNdRAwlgA+KUaZoSIqAMTg8LspAymJL3XBgbMLuTpse7Z+9cbP6nuOjG5MDmJLb/R5a5AxYI4VX3Rcx6+t5QWik+TECZNuC7cPEP98iraJdHtq7EBZm1HG2uMkstIB2UcMjEH2ZddlKIXjiQgtJXyT767PHIZ/D3Fb4PN9hTFNxlhiFyWH3PwU+yDueVwl3bOX11w2TCA093mGqhOCA5+rO+YvGDMkrE1RYjVDwAJPXGygE0GOpg0a5rvcOnVPVv1GGgroNjLOkwS3F27ZvT7iy6qenC+i7isc1x1ALh1gYAbZejo9SDzl+D3R93sp6eCQVaBHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0WGK55+zao36nTKVgoMCYslBSzgJKvv2gbV+HcIYyw=;
 b=i+R6Ox2MQRunIxmjRL2+WQ+9zeR59i7DYH5722O9ihMEOuPCctAUAmojVJTbcRRirKBgDYAeNUDWZf53OVLXOry4BY3/aQiuDj9YrmJ7rU1zC8W+7CKLxvtMBhUeyf8pHg7xfAnOO0BmBUvjp9wX3b6FwroPEP2oyZStQYW1+ls=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3913.namprd12.prod.outlook.com (2603:10b6:5:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 16:47:48 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 16:47:48 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: Add unique_id for Arcturus
Date: Mon, 27 Apr 2020 12:47:35 -0400
Message-Id: <20200427164735.27409-2-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427164735.27409-1-kent.russell@amd.com>
References: <20200427164735.27409-1-kent.russell@amd.com>
X-ClientProxiedBy: YT1PR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::39)
 To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YT1PR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 16:47:47 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: def8bfca-1bb7-474c-5ca3-08d7eacab76d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3913:|DM6PR12MB3913:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB39133BF69062B8C4AB4E2A0585AF0@DM6PR12MB3913.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(956004)(2616005)(44832011)(6666004)(4326008)(6916009)(66946007)(66476007)(66556008)(1076003)(86362001)(316002)(186003)(478600001)(16526019)(8676002)(36756003)(5660300002)(26005)(8936002)(81156014)(6486002)(2906002)(7696005)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t8kHdwmxIpjwJXkGFsPqDwnX68omNfsR00YnmatKStoG6QEasEt1yxhEcAnAP6BlhYuId3mlRmQcuF/HmuRwGdtnmAcoghySD8BbtRJyxHyKfUj3zRjRyziShPVMopYCI69K+8Z5DPd01iwY7Rk87yvqhx7XCUPjwSC4rNQpRuvNbxeAzZmeAhxxHIYSbpVSGsqXuy97cW5VQGwKc9fOnjpKxEgP4nqoZ4YxCccrIUVeqiWpeL1lJa4Mi+mtKdB8xQnmP8+rcFymigLciqIUGkqRBG43KOC0X+o81lcBh3H/nt1OYoAi5pwx+AFP5P9Z9m6UeIkqnk6/GLFEfu9/nWFwx5FpMYnVuHvcL70FvPCK/LZJCspOgkLIJxt9P5fkYV1juvHvSUWyAysFwkQVzgODQSinFLeneJy7b4iw7PDUExmB0MJHIc6grfy9J6lH
X-MS-Exchange-AntiSpam-MessageData: 6aw5Km1vGn/OrbXnl7byB8PJ0OauHQGqLi5vdCZapeO1j8Z1Mfln+hxLyLnlYSFoNUOqUX+2JIZ7qUv1RXcjcrXHrTkdZvxCFQ/uu+0XXH1MIBldfB0JNQ+NlBh98oBhqjBWGCrOG09iWyHf42xbH95ujslj9IHUfDQoQ6f0MXrQlydAM9v4WBwJsa4Xexrwa+fSZcbvXfkSh+JGQSYgQsxr/Nbxw9bnOysPxWNntF/w/2geNE79g14UZqJWgzJTfJH57cBB3RqNnkjR4Cp08fUIrgRDW3Ry+FpnS9ltLS0uAZjCP/dZydOHVfOe4iR5HzfG9wcuJuWWPRZyhuZRn9KZPJGA1yuUfenV/ATrUA5H8t5/y77deNn2H7de8SS4rlzQUELbuFvpVm6gP8ZB3H45aZlFy6/9UxLrtid+a6IYtTqt+VzME3ZlxThlOhhy/0cjA4zDsHmk7Pf9HNrTuEv4yr+eh2BGfkXhrVTBrwXVG++oJ8WJxQOjSHfgiPB6V2ulwLBcshS0ZFmhHP7WdPbqV6YDFKzB7jHnSGPCuvYj8hJ9pqT4qLbqqYSZVkRYwp3duxa6otxBhj5ofhcpNZZwyb/hjmwAZ4FmKe/hFGbZgjiwE7VfsA09Q+fi7040UED0iBRr7jjIvMgaMijXMIwuxbHXeDn1VpBvPKHqSEF/1UsC05gg2DrmJmZZHiOSFT3tncdZCZsz0O745NWy8bSjZ5dFlpM3S8OY7g9qI0pXnrMp3SOFfNFi3o0yjQwZ4dK3taVyCp72JtYEdE+z5P2KzmTSI7DJnFYa9nxGSsA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def8bfca-1bb7-474c-5ca3-08d7eacab76d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 16:47:47.9844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RRwHWotL1tsnT14HvXCN04lUgF2uRO/40FC3v0JdJUgXxorkX6GuNnN7S+B3g/3nlgw80x4AMei1ROQ3raWHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3913
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

Add support for unique_id for Arcturus, since we only have the ppsmc
definitions for that added at the moment

Signed-off-by: Kent Russell <kent.russell@amd.com>
Change-Id: I66f8e9ff41521d6c13ff673587d6061c1f3f4b7a
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index e98d92ec1eac..f55f9b371bf2 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -293,6 +293,7 @@ static int arcturus_get_workload_type(struct smu_context *smu, enum PP_SMC_POWER
 static int arcturus_tables_init(struct smu_context *smu, struct smu_table *tables)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
+	uint32_t top32, bottom32;
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_PPTABLE, sizeof(PPTable_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -315,6 +316,15 @@ static int arcturus_tables_init(struct smu_context *smu, struct smu_table *table
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
+	if (smu->adev->asic_type == CHIP_ARCTURUS) {
+		/* Get the SN to turn into a Unique ID */
+		smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumTop32,
+				 &top32);
+		smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumBottom32,
+				 &bottom32);
+
+		smu->adev->unique_id = ((uint64_t)bottom32 << 32) | top32;
+	}
 	return 0;
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

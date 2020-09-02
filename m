Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1ABC433E2
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 08:32:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9781520773
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 08:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fzUSWMAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9781520773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 654976E2E1;
	Wed,  2 Sep 2020 08:32:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F01746E2E1
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 08:32:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhCN2mWV1z9TfZqtIjYlYivj40MN06jlH40m0y4F8GUBTw4bz0m/bC0tUspfYEHe3DFvopRnTdLaTNq75fhJgodaZ3hcDR08qf+GJfbnGLL5mDNUdFbcXLEhwVBdWj1GinKv+abXoRe3xWjVoHp7xSpIX6gwYoh0Ila8ieMJKBucvHksHvqHYgKOggEyq48iUPpGWl8k7BbyyfSpskhAetq/wsr+K2GKF/P++S1I+Q3tIZYrwTTKVyrYbOD1PPQxoeWe/FWrbtudJVms8fjOt9uL9MMSJYkiNooOsi8sG/OkIBcOCRqB7vLaJLz4gtp7cF24w4TWzgRWw7TBBD2khg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qrb6vYTQRt3o+eZgAakCxpyPyGoQjm7ZkZjrr7eidYs=;
 b=NnkpEKXtjjYHQasvg93rdtnadZYfcLtwnPNIRJFReOoXp1Iel1v6iVkdgt51xWAs9oEtJDKs9cEBZSEH9aEP7R7kUE8TUAUX3M69AUe+aYvu85CqwenNPVldND96QUt8DDjfa9XbGOLotk/+3H/gEF5/MY4ErY7CvLNpJrq6jpiqv8myZGkla78Uq9hqVQC7tt11tkDHPYNkvZlpaHMUQKvNJC989JaKJg7n3h+KRI3XWhgb6SRvq97c2vjjcq6U3gw4gLzX51+GESW4ASuZv6Jn9sTO/ov614xIcZqNNfYv6EsjaIX0smFQezygGXB4Tq7ovz1fZWVqodw/TOCqpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qrb6vYTQRt3o+eZgAakCxpyPyGoQjm7ZkZjrr7eidYs=;
 b=fzUSWMAWFLXGND29htKn3WoXrrpRj4rGeo3GZgYnKKk5mmjAoRMzHiiETfT0/2CxnPU34wuYvbGUwjnjqOZi3XDcH10lGucftVHqpHGjRkgl6700FxuZkQloecqC2SLsT9BQjQUiRCop8dbIYKtXlJyiCdPcB34seUxYwxcIVek=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3868.namprd12.prod.outlook.com (2603:10b6:5:1c8::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.23; Wed, 2 Sep 2020 08:32:10 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3348.015; Wed, 2 Sep 2020
 08:32:10 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/9] drm/amd/pm: allocate a new buffer for pstate dummy reading
Date: Wed,  2 Sep 2020 16:31:30 +0800
Message-Id: <20200902083134.25569-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902083134.25569-1-evan.quan@amd.com>
References: <20200902083134.25569-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR0302CA0004.apcprd03.prod.outlook.com
 (2603:1096:202::14) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 HK2PR0302CA0004.apcprd03.prod.outlook.com (2603:1096:202::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.7 via Frontend Transport; Wed, 2 Sep 2020 08:32:09 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92c2255c-b7f9-45ed-0b97-08d84f1aaf7d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3868:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38686714E4D7EE4B427E1BD2E42F0@DM6PR12MB3868.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Spg8hwDYKZIyEWoq/yfrgaAmNAVopJ/UlrcMG2mv1Y+BZtggivJKLWLb+YYsDar6FYVvwDosF1NxixdS408lrffsOAYLohyU4UXH0BsNIJXrSjntxt7awBPI29T6MFKMErRPukAbYH93wU9ofTgScq0AtFqop4UoPtVx4Jv8CuLsxSFwv0oOP2BxNhqE864EhLklS/mOb2/2wX103/jbS2t4u4Jbsql8xKgsRA9tlzJZCkH3CeU6US5rL5kFIQ3LkXCJwAfD2k1qMugkDHOEn2ZxtHhqk/vcX4Jn98aiq1nxdfUgHf2Dt4ndVjuQEZHwwSy+TuGe/eKD5JxsYDieuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(66946007)(2906002)(36756003)(16576012)(66556008)(4326008)(44832011)(316002)(186003)(66476007)(5660300002)(6486002)(8676002)(86362001)(6666004)(26005)(2616005)(956004)(6916009)(478600001)(52116002)(8936002)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: m5NEuBC5eyc3XZntrDFF06OxpQzq46+dftNDe+G2uYmiHiJ97lJEiVeAv3sulHU2uxq+Kb94My6Bkab9d89D5ryRYAd+AfejBuQ+UtDe14v3hkIqzxNo/krce7YjkR6Fma0ImWfzE0sSmni2gyAjz/PhjwDDyG5FUGNU7lgS5G+TizqeiSF8lC4OepnFe4QTtr3CzIU2ostP1CJLDpF6uXvp9JtGDH8dDb0QKHTxaSQhGTCqhCek9+1KvMtvLYxaQ1ntxUAP8/SLZQHG5bpaU7EJUGhyQHieHYpLUCCwxSThOFqVaR/ajalR0n+G05oao+c9RafPMjVzCnHM+0oAfTZtsub2p6DSh8XUzSgIttk0Nlkx341UFoF9VsR9dHgw6KVKjUgeW1q+F2tq4sVJ9pH6uBQi/gjEZydEzjG7WCuKpPT5Vbpdl+2F9Q4hlmK0IcotlycV/+RM8oRFz0gnDNwjc3dKwHTbI5akgIiIo9Q8nyQZvgfGb90ne0kX9zf3E6UG7S9PjEj8EEVd0fv67c7HBRWtXE0TOBG2aUaAUfoj9fV/JowqkqVwQzGGFhe0BUrwRtYtyW6ALlxUwIu10anM/oji8Dcj4gQjo+Ed2/t1OWXcs1IuvwTRLW9v+dQUK8U5vSrWzJ7HFuSVv6MPXw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c2255c-b7f9-45ed-0b97-08d84f1aaf7d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 08:32:10.6945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0a++kYIfjpqidqgpsfxnrripCx52iod2CzQ/3Jc3hYcYMs2b6TTu5iuJXzESgcj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3868
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This dummy reading buffer will be used for the new Navi1x
UMC CDR workaround.

Change-Id: Ida41374c0ea156527a1bf1104c7b2b909e562f7a
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 45 +++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 701a94d4b9f6..29e041d86ae5 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -270,6 +270,7 @@ struct smu_table_context
 	 */
 	struct smu_table		driver_table;
 	struct smu_table		memory_pool;
+	struct smu_table		dummy_read_1_table;
 	uint8_t                         thermal_controller_type;
 
 	void				*overdrive_table;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index a9c0c20efddb..dab272721037 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -663,6 +663,45 @@ static int smu_free_memory_pool(struct smu_context *smu)
 	return 0;
 }
 
+static int smu_alloc_dummy_read_table(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *dummy_read_1_table =
+			&smu_table->dummy_read_1_table;
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+
+	dummy_read_1_table->size = 0x40000;
+	dummy_read_1_table->align = PAGE_SIZE;
+	dummy_read_1_table->domain = AMDGPU_GEM_DOMAIN_VRAM;
+
+	ret = amdgpu_bo_create_kernel(adev,
+				      dummy_read_1_table->size,
+				      dummy_read_1_table->align,
+				      dummy_read_1_table->domain,
+				      &dummy_read_1_table->bo,
+				      &dummy_read_1_table->mc_address,
+				      &dummy_read_1_table->cpu_addr);
+	if (ret)
+		dev_err(adev->dev, "VRAM allocation for dummy read table failed!\n");
+
+	return ret;
+}
+
+static void smu_free_dummy_read_table(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *dummy_read_1_table =
+			&smu_table->dummy_read_1_table;
+
+
+	amdgpu_bo_free_kernel(&dummy_read_1_table->bo,
+			      &dummy_read_1_table->mc_address,
+			      &dummy_read_1_table->cpu_addr);
+
+	memset(dummy_read_1_table, 0, sizeof(struct smu_table));
+}
+
 static int smu_smc_table_sw_init(struct smu_context *smu)
 {
 	int ret;
@@ -698,6 +737,10 @@ static int smu_smc_table_sw_init(struct smu_context *smu)
 	if (ret)
 		return ret;
 
+	ret = smu_alloc_dummy_read_table(smu);
+	if (ret)
+		return ret;
+
 	ret = smu_i2c_init(smu, &smu->adev->pm.smu_i2c);
 	if (ret)
 		return ret;
@@ -711,6 +754,8 @@ static int smu_smc_table_sw_fini(struct smu_context *smu)
 
 	smu_i2c_fini(smu, &smu->adev->pm.smu_i2c);
 
+	smu_free_dummy_read_table(smu);
+
 	ret = smu_free_memory_pool(smu);
 	if (ret)
 		return ret;
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=SXnv=2V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15972C2D0C3
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Dec 2019 02:49:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5DF5206DB
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Dec 2019 02:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="b5xYalYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DF5206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 481546E0C1;
	Tue, 31 Dec 2019 02:49:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20F7A6E0A1
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Dec 2019 02:49:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2nz0UMFneNZfeyX9OqhPyeTfJ7DhbIE5skbrRdpBPbMGCuMDT/RLzs5DzKwQwMwHkV7O8ixTeZFHbcu18YzxVROBia57O45HK5OYFLd0R2YBscDIIcTlnCN1FsnRqhQm0MSjYlR7yTaY8bkZ73J9KeJxjKGo/i6SE2dZ4jkkkpXQGchBOiZuf9U++SIda9ODFR/qSjAA0HZXXliMpDc27tWgkidNSeLV9H+5YgH1pYPLqjXYlxp71UvpUi9iBXL9j3Rybom0r3d31SJMMwQn15ysgSv2eaAmx2EGoO3EnxudjztGEu5s8WlicVV6EN677ucCXcuA3Nc6Z2AgtMfkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgsxR/vLQlMt64kGr0zE8y/yPn4RUf/pvOJeVYAApNI=;
 b=hU4J+pkm2mdty/aX7yZzZA+nzvtCuVclik9VpudO+YaOewP6srFYKnepLLgUlIztWCxJNErSj8jQ0R9d+foFE6TDD8kRc+busPG6WW0yvTm953j8jbb3RCM0QC0lER3Qb8olDo8sTHoHtEBwUrQIDkKZuRbuoEIzx1CKRNivHukbvHNECtWPXhk1E17+KbqMsF1o9ohs+hzADIlHNNdmQD/LSHEO+Kr4x72lHxWAALfyTGuubLTKDP+TnEP9geZQ+TmHt2ykCzShjS6rHH5GLdggkUKf74ucJqIErKVIG5xcKBAYeLhatQFZOE603r0tHSt+VM1HFf6RM9uFj1SXOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgsxR/vLQlMt64kGr0zE8y/yPn4RUf/pvOJeVYAApNI=;
 b=b5xYalYnM1jf/EKKM926hsGuJlt2mRbujxpJ7dNRHeOTb8n6XPuXs55cK853eccpRpvnfMeLU+kXroRUX4InqK48j/tku+TU75YQoIVQ/JPMqXbE6azigYn4IoK3DXN+E37CLtVjjovAEZs5XfLNKFE2Ht6MJrUulGRMakCmG2w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3935.namprd12.prod.outlook.com (10.255.237.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.11; Tue, 31 Dec 2019 02:49:18 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::1010:4621:68dd:5b47%5]) with mapi id 15.20.2581.007; Tue, 31 Dec 2019
 02:49:18 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/powerplay: cache the watermark settings on system
 memory
Date: Tue, 31 Dec 2019 10:48:55 +0800
Message-Id: <20191231024856.3557-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: HK2PR03CA0063.apcprd03.prod.outlook.com
 (2603:1096:202:17::33) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR03CA0063.apcprd03.prod.outlook.com (2603:1096:202:17::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.8 via Frontend Transport; Tue, 31 Dec 2019 02:49:16 +0000
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7553c517-e6ef-469e-c8ab-08d78d9c078e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3935:|MN2PR12MB3935:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB393538B15648A1505B8BF53EE4260@MN2PR12MB3935.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:231;
X-Forefront-PRVS: 0268246AE7
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(199004)(189003)(16526019)(8936002)(6666004)(186003)(4326008)(2616005)(7696005)(52116002)(8676002)(81166006)(6486002)(956004)(316002)(81156014)(26005)(478600001)(2906002)(36756003)(1076003)(44832011)(66946007)(66476007)(86362001)(6916009)(66556008)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3935;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cVE9srOuZIgt6CjayVfegFHI+71bLPD9LqM82MZEcXKzmTRwM/fFopjyuSQ8mTQrCnwE267a6YfamKDBZYmBqvSCLvSvEwecAII8aAjmOUFTq0vpKA/0fWhnXj3wYn8Kr60Knvb7AMiqX4Rfzs5DEXkLQE5cXbX/ylY0a2MIW98coDJfhUKLmYoVFWkZ/D4qbrX0pQ83gG0QF2QBjATdgyQBX+R1f9yklHA8W3+N4eHqcQ7GGGDYbMwrOY37LKYpgHJrU1v1qmUDJu5rEfviIoU9boDqD6Co9OFmVbEB6biNeaH0GCrJIID7JSlOiei6u4n+R/JdEgw0U4nQUaeXXnTq+zQT72UXpzbsviSLv+/th4vNmsno+7LTY13w32YYtBG6c8OyT8UIpgfv0q1KN+eJVGIFr1aPAiQuXY0Ox1upeT/JSLzPJyz3Kp511al2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7553c517-e6ef-469e-c8ab-08d78d9c078e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2019 02:49:18.2014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJFQFUrBc+uu7YbaeZVgaA4RuWxdkWoEEddphCqcf9w0jnY+wPs75bhCvfs0n1kv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3935
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

So that we do not need to allocate a piece of VRAM for it. This
is a preparation for coming change which unifies the VRAM address
for all driver tables interaction with SMU.

Change-Id: I967f960a10a19957ea7301aa40a8ced0c036ad68
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    | 21 +++++++++----------
 .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 +
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  4 ++++
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    |  4 ++++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |  2 ++
 drivers/gpu/drm/amd/powerplay/vega20_ppt.c    |  4 ++++
 6 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index f9bf69cd72a5..09e16183a769 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -1899,26 +1899,25 @@ int smu_set_df_cstate(struct smu_context *smu,
 
 int smu_write_watermarks_table(struct smu_context *smu)
 {
-	int ret = 0;
-	struct smu_table_context *smu_table = &smu->smu_table;
-	struct smu_table *table = NULL;
-
-	table = &smu_table->tables[SMU_TABLE_WATERMARKS];
+	void *watermarks_table = smu->smu_table.watermarks_table;
 
-	if (!table->cpu_addr)
+	if (!watermarks_table)
 		return -EINVAL;
 
-	ret = smu_update_table(smu, SMU_TABLE_WATERMARKS, 0, table->cpu_addr,
+	return smu_update_table(smu,
+				SMU_TABLE_WATERMARKS,
+				0,
+				watermarks_table,
 				true);
-
-	return ret;
 }
 
 int smu_set_watermarks_for_clock_ranges(struct smu_context *smu,
 		struct dm_pp_wm_sets_with_clock_ranges_soc15 *clock_ranges)
 {
-	struct smu_table *watermarks = &smu->smu_table.tables[SMU_TABLE_WATERMARKS];
-	void *table = watermarks->cpu_addr;
+	void *table = smu->smu_table.watermarks_table;
+
+	if (!table)
+		return -EINVAL;
 
 	mutex_lock(&smu->mutex);
 
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 541cfde289ea..30da8328d1bc 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -254,6 +254,7 @@ struct smu_table_context
 	unsigned long			metrics_time;
 	void				*metrics_table;
 	void				*clocks_table;
+	void				*watermarks_table;
 
 	void				*max_sustainable_clocks;
 	struct smu_bios_boot_up_values	boot_values;
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index e7ab8caee222..3387f3243a01 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -555,6 +555,10 @@ static int navi10_tables_init(struct smu_context *smu, struct smu_table *tables)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
+	smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
+	if (!smu_table->watermarks_table)
+		return -ENOMEM;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index e73644beffd9..506cc6bf4bc0 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -209,6 +209,10 @@ static int renoir_tables_init(struct smu_context *smu, struct smu_table *tables)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
+	smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
+	if (!smu_table->watermarks_table)
+		return -ENOMEM;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index a85826471d82..6fb93eb6ab39 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -450,8 +450,10 @@ int smu_v11_0_fini_smc_tables(struct smu_context *smu)
 
 	kfree(smu_table->tables);
 	kfree(smu_table->metrics_table);
+	kfree(smu_table->watermarks_table);
 	smu_table->tables = NULL;
 	smu_table->metrics_table = NULL;
+	smu_table->watermarks_table = NULL;
 	smu_table->metrics_time = 0;
 
 	ret = smu_v11_0_fini_dpm_context(smu);
diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
index 534c46bc0146..27bdcdeb08d9 100644
--- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
@@ -338,6 +338,10 @@ static int vega20_tables_init(struct smu_context *smu, struct smu_table *tables)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
+	smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
+	if (!smu_table->watermarks_table)
+		return -ENOMEM;
+
 	return 0;
 }
 
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FB0C38A24
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 18:54:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D59B20575
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 18:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lvm34PC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D59B20575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D90806EA4E;
	Thu,  7 May 2020 18:54:16 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680062.outbound.protection.outlook.com [40.107.68.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07F046EA54
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 18:54:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9Sepd0HxTpck3RFYwFwNi8yLsQg9HnwVQbH6N2P9EtlUuFki5vus82D8Kn+erIanmbUBcbjTwN0oG2ACYjInZQj74fB/Buxq6LK8KIsp19X9GRqWWjtyVqYUUoUQcs8+Ldt3MRAckfpwvFYC0RKQwXt6D6tJj3RdR9d5jsaDQUXxSf/VV7VZT/Njs8W0uxdvRL1jg23qC85aj4tbWUqFro2f6uF3dOwCfzTT+gBeZLYm/0Ih7Ht12kmxxZyWuXI9G4022/qfb2gaE6XxYQPTMWSUDasedao51UInOLE7+Jk/OUSR2Zmej+9bTiPmaEHqAJHP1OEB0dCuoWK3yydpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GorBVKUWuETEV+k1yWHrJ4AOegUpOC9g4j5PkCfTKk=;
 b=Tx/zzmk1wyreTYLogmCIs8fQFYPgbYGcxw6h4trpaMEGR+QFz8XzbsUs4Vrmq5kHsvop/xOcNk75IQLDakXve30t52ifMn+PMkcXiXneDZodv4BhyY/h8aRYZaToNssNz1bNwFwq2yKe3dA99a2JwE4FSjYIfVxOQBgrTDTJ10FlxzgWPNFTavxwNnr9D8/I2b9MbChan85yan7av3sO3RU7201EcpoJS8CN3CKljebRHlDitPfX3e57KXkKdjnFYWfteISOfl8555VZj7+y377YV/1pAwgDkJ9qYqYsZx7+hE83lJPfl/p14O+LBAYnVnCvCQQ40+4OAB03/Pyz1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/GorBVKUWuETEV+k1yWHrJ4AOegUpOC9g4j5PkCfTKk=;
 b=lvm34PC7N5SgMz00sfpzhFy2nXt9elZu65/50LcBHAJd+02KnhICOITSEJ+/85rgRsk+JLk/wWYxBu0zqVvJFk40Z1ECHvmXlmgaEIGsR/TncXMeJshC4L3Wx2SfFc2RZJPtL9IZ3rbIC5Ipvl731Hk1h/DshcNElrxwa+T6CN8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB3579.namprd12.prod.outlook.com (2603:10b6:5:11f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Thu, 7 May
 2020 18:54:14 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::e027:654c:5d9f:a648%3]) with mapi id 15.20.2958.030; Thu, 7 May 2020
 18:54:14 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] Revert "drm/amdgpu: Add unique_id for Arcturus"
Date: Thu,  7 May 2020 14:54:02 -0400
Message-Id: <20200507185403.5114-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTBPR01CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::40) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YTBPR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.27 via Frontend Transport; Thu, 7 May 2020 18:54:13 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7f63d776-872c-4a49-0e71-08d7f2b80940
X-MS-TrafficTypeDiagnostic: DM6PR12MB3579:|DM6PR12MB3579:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB357997E37246CABDC445F38B85A50@DM6PR12MB3579.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:83;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O2Bu/y8fmM7S2Ziu3SSDENQgsE3MpaRgPdgj8RLn7RdYHVwTqcfERHV/16VAGvBQmlMHI3SESUSrYs0/sK8UaRkVANp/o3AVxLDqmwsqRu5iPfjxMurAGAfQIxKSxMdV8Veguto5/Ve9/qS9OWceRhUi6CmrXxYlKkgSvUMI76omyAmcK+cXjKSqpm18skEwodjXcGTAgAatc9ZxFi0CfZ1pgI5MMwIvnXXGhCkSoE6a3p74fXU4L8SCb1EgWxjXyBF9ym+hGO84ppj2MlEG57kQY0N3u3WadC+z4vfFKpv4mgBHKE/FSA8qTZwv+iG05mLF70Z2GcDgeewmpOgPzNYvr+O8osoNYEeeUt7xZHfE5TXbyh2ZcbIHyYcnrGkb9yZsSjxld1tH/Qt6aJDY4IsJz0bJsekGYuC0PHfZo0fbeEwdLaLzUyhPK1EyyT5VS5XqQr+vSvjQ1d4534tONsMI4+prNdWbqUihdPv/TBqybgVEdV3KNIHJ0w/FBKCvAnlZVl3DsuqFrRnsUyOCzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(33430700001)(4326008)(316002)(66476007)(6486002)(66946007)(6916009)(2906002)(86362001)(83290400001)(44832011)(2616005)(83300400001)(8676002)(8936002)(956004)(83320400001)(83280400001)(83310400001)(16526019)(186003)(5660300002)(478600001)(66556008)(52116002)(7696005)(26005)(36756003)(6666004)(1076003)(33440700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: peXHHTzu6hz/yzgq7pC5AMf7ecdpKuRL2p3Zq/95HavE9XOrtJ3TNGfapnKhtgAZa4hXlQdxHPmuJWZDQWg5grvnoEYDl2+qc0jzO0j9XiITSUjpZid3WT8P5q+BJo4Zw4gqEyfZfWtKeCv+nimrqrD3lHJos9Krl/KmX9YLA6bOHJwyGT7pk3edet8XV0H+bsFMLA/uq4ZgvZKdPUYuz/ddqNW8hkyLxU8VU2O+BFitmIandILH/f1/yNqSMBP1BqgnbaiG/rALyeM8jLo+aQ6dRFz84212dG/jZas7HX82Jsa/PqqidlL8dxK1Amx0WXX0XVZiMaKvKKIG1pWgszmN7/QbfdBaKaAoW20H+LWTjfVz3FC4auTHPLgO8qIRqUidp3PGxXst97R3yHzMe+CBJU4p4eNTP6FrYwdgqTD1vAs10TToTs3yKQFMDdvrJyK+wVBsocaVf+0d8Wjyk5vQo9DSOrjDVojrM8IICITXiCGh+baVXnVdwcp4ywMRuLf3aV+vFciEpiOR4miJJ0Sl8VhF+a9AAnSpD2bRJC6pRaYoYw5TBU8z313xCfeEVilWxXPVL4J4LoYk7AzbuodpC0hmZz4dUy0AXN8jd8iGkk7Oc3nLwoue2w9VTLLAMoBmVyx5VgiWvY5e1u0SzLdLufUMyZyO1vUPWZWXjRsr7xYTQXG1pbak0FQsVty1a1syWPk6dYRHkTjYNiLw7+LWmaivCA4agukwcUWN7jO8zR0XRxqQd9SE0ClG+HABTiFdiFhGCZncB+o8wHSJgs2tHkpQsoi03iTXl4LyN0o=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f63d776-872c-4a49-0e71-08d7f2b80940
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 18:54:14.0471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+QVyZccUyKmI6gli9+Wy1k/R6IQDUZIRDrnYsZOHIRHy4YfCiU1i05xOTRL8k4hDU5d4Z5lxAeirdHuoTyUOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3579
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

This reverts commit b3abbca4eca6091e0e657baf9a5402e204e97d4c.

SMU does not support this on Arcturus right now

Signed-off-by: Kent Russell <kent.russell@amd.com>
Change-Id: Ia5f29f91a64005f68dbb9499b43789fe473cd00c
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index f55f9b371bf2..e98d92ec1eac 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -293,7 +293,6 @@ static int arcturus_get_workload_type(struct smu_context *smu, enum PP_SMC_POWER
 static int arcturus_tables_init(struct smu_context *smu, struct smu_table *tables)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
-	uint32_t top32, bottom32;
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_PPTABLE, sizeof(PPTable_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -316,15 +315,6 @@ static int arcturus_tables_init(struct smu_context *smu, struct smu_table *table
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	if (smu->adev->asic_type == CHIP_ARCTURUS) {
-		/* Get the SN to turn into a Unique ID */
-		smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumTop32,
-				 &top32);
-		smu_send_smc_msg(smu, SMU_MSG_ReadSerialNumBottom32,
-				 &bottom32);
-
-		smu->adev->unique_id = ((uint64_t)bottom32 << 32) | top32;
-	}
 	return 0;
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

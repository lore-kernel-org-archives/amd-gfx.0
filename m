Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0440C352A3
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 11:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93E9D206D7
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 11:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0ZB5+z3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93E9D206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 598B46EE29;
	Tue, 11 Feb 2020 11:23:14 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690072.outbound.protection.outlook.com [40.107.69.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41B646EE29
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 11:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUB3lJLodwknbCVZW7AU1+nwq7bGRp0Tm/m9fwdQG5GUAGW5TDg9Qrg/XghBXsWFhitb/hRp/Ywtehk1m+7oZhhbZ3dNiw9Gvr8zpkzg7pukJxHxPQaokEGLYRZ668WPEmzMUmdfz3Jjn8jeNgZJdMAR/gZvHbiMa3ImBJ6QywBVi2IIPqExQ/l+sDeBy5K3sHGwCjT+jpvUoUGruHaGVpZN6q3ErRx3yWf7DtJYPLd3HMljgx2Y4PWLro2NQLUkRwC5yZwp0vleqPp47upePu4jZaRZQS3PJLW08QC9oikdY4Cutg1gS7zoOi/JTq4jht6GDckI/dC5WxFypJrf3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Z4aj71mZsgZVspxwbTuXM6ytDLpzyCly/Ya6wDAzME=;
 b=d2FwyGLcETJ5abHkTXTvlA59Uizy/0w1Zu68uISPt1hVOxszo5/r7G1J/eiPMuUuVzejnRgCBN7h5WELhqQ8UNM8k4tR/iZ3EkkR94aEjB7iHxSvOVkb5oAink2UbhU9JytC5KNloLVyN1NRE+KUXiWevmSqqq6yTtVrfwgZtN3A6HUMf9AeOM+CSQTskkm2wFCHGNpi3tz6VXAmHU4cUkkPcLlJMek90E5AlC86Uq6+gfKmwc+jvCeVeuRN+XPp2/0msO/vfvM5frxoeeH+AOkLzSunY8dtWLG6lH5B+qmSxpdJP91kM4R83DHo6fsvLwgqZ+7vhYtqax3bl8IpUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Z4aj71mZsgZVspxwbTuXM6ytDLpzyCly/Ya6wDAzME=;
 b=0ZB5+z3XrVObhafOIURRmz29i+dr7IKyahr60tsIw+7HG6iPbHkV2tU4ET/Beh50VbFZfCfbSsx2u8f/DkERRwgd3/mk3yyRhNnphEiLHOGF84Wp3OSEHUuRIbadiW+lk4OS0tfQJLJH0taxsoAj4tPgXmnS3luKrP91kMN14Nc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB4221.namprd12.prod.outlook.com (52.135.48.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Tue, 11 Feb 2020 11:23:11 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 11:23:11 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH libdrm 4/4] amdgpu: clean up the cs structure variable
Date: Tue, 11 Feb 2020 19:23:03 +0800
Message-Id: <1581420183-14223-5-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581420183-14223-1-git-send-email-ray.huang@amd.com>
References: <1581420183-14223-1-git-send-email-ray.huang@amd.com>
X-ClientProxiedBy: HK2PR0401CA0018.apcprd04.prod.outlook.com
 (2603:1096:202:2::28) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
Received: from hr-intel.amd.com (180.167.199.188) by
 HK2PR0401CA0018.apcprd04.prod.outlook.com (2603:1096:202:2::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2707.21 via Frontend
 Transport; Tue, 11 Feb 2020 11:23:08 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 339bc910-4010-4097-6dc3-08d7aee4c6eb
X-MS-TrafficTypeDiagnostic: MN2PR12MB4221:|MN2PR12MB4221:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB422169F8B6FD5909150D484DEC180@MN2PR12MB4221.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(199004)(189003)(7696005)(52116002)(956004)(316002)(8676002)(5660300002)(4326008)(86362001)(2906002)(2616005)(54906003)(81156014)(478600001)(8936002)(6486002)(6666004)(81166006)(66476007)(66556008)(6916009)(66946007)(36756003)(16526019)(186003)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4221;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZHJDochaGj9yoNuKhhzIgo8zPyrXVYjOHzjR2cW04t6qIs1CyFghQ137pp6snPmvwcisVeKro+BPh4jMKVGP98PrfMVkp64YUEMxwIyoy0lYVfbfCH+0+LdzKXRZEyB9M+GaDyVOWyirJPnZbTQMGJ0dxINQVMZtilQhz+LZT7t3ltxnla6zInobjhr7cKoKB6b7JdMvLqOOpmMGiq6WexhYHgFI4mqwojvebXsZJDv/NOeLmtnScE0muI9R/hJsC6cTffORgHzWgVJh8yJvb5RUc1ruw8JLa4uDOFIIsrJLY1HRI+Ao/MMkdL3WGyFIqFGLEsIJwzmNtEdx7eQBj1UL/+btBd0mg57+CrcpNk/qsgCblIas0i+Fe5SqLqv5fD9aIl0W7hqzzBn1oHiNjhYbN3zGRDbs9V1xPazv2t6gZEq4u33Mq4lto6FhMld+
X-MS-Exchange-AntiSpam-MessageData: lq4r1P585K20YzIdgG7CdfNQDf/o5bxv3zo1aN3nWU+Bbtig8OiOIpqYrgRSJnpcfxuXx7fTClO2XEaaJW9flD5SYX6hMKh2gyZEEKw0KJY2jmjiS3qTpDXAXtA/UBaAiV2tgT/BqgzNii5b40jSnw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339bc910-4010-4097-6dc3-08d7aee4c6eb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 11:23:11.2487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmFXJwVjKS5Fo5TttFG+QLchuO/1sRp1QxfNewDnpteDn0UdBdtLXaI9MNT85SNeovdSz4x4mmEVrTOv2BnO2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>,
 Huang Rui <ray.huang@amd.com>, Aaron Liu <aaron.liu@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to use generic variables as the input of amdgpu_cs_submit_raw2.
Because amdgpu_cs_submit_one won't handle IOCTL directly.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 amdgpu/amdgpu_cs.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/amdgpu/amdgpu_cs.c b/amdgpu/amdgpu_cs.c
index 1772dbf..fad484b 100644
--- a/amdgpu/amdgpu_cs.c
+++ b/amdgpu/amdgpu_cs.c
@@ -220,7 +220,6 @@ drm_public int amdgpu_cs_query_reset_state2(amdgpu_context_handle context,
 static int amdgpu_cs_submit_one(amdgpu_context_handle context,
 				struct amdgpu_cs_request *ibs_request)
 {
-	union drm_amdgpu_cs cs;
 	struct drm_amdgpu_cs_chunk *chunks;
 	struct drm_amdgpu_cs_chunk_data *chunk_data;
 	struct drm_amdgpu_cs_chunk_dep *dependencies = NULL;
@@ -228,7 +227,7 @@ static int amdgpu_cs_submit_one(amdgpu_context_handle context,
 	amdgpu_device_handle dev = context->dev;
 	struct list_head *sem_list;
 	amdgpu_semaphore_handle sem, tmp;
-	uint32_t i, size, sem_count = 0;
+	uint32_t i, size, num_chunks, bo_list_handle = 0, sem_count = 0;
 	uint64_t seq_no;
 	bool user_fence;
 	int r = 0;
@@ -251,11 +250,9 @@ static int amdgpu_cs_submit_one(amdgpu_context_handle context,
 
 	chunk_data = alloca(sizeof(struct drm_amdgpu_cs_chunk_data) * size);
 
-	memset(&cs, 0, sizeof(cs));
-	cs.in.ctx_id = context->id;
 	if (ibs_request->resources)
-		cs.in.bo_list_handle = ibs_request->resources->handle;
-	cs.in.num_chunks = ibs_request->number_of_ibs;
+		bo_list_handle = ibs_request->resources->handle;
+	num_chunks = ibs_request->number_of_ibs;
 	/* IB chunks */
 	for (i = 0; i < ibs_request->number_of_ibs; i++) {
 		struct amdgpu_cs_ib_info *ib;
@@ -277,7 +274,7 @@ static int amdgpu_cs_submit_one(amdgpu_context_handle context,
 	pthread_mutex_lock(&context->sequence_mutex);
 
 	if (user_fence) {
-		i = cs.in.num_chunks++;
+		i = num_chunks++;
 
 		/* fence chunk */
 		chunks[i].chunk_id = AMDGPU_CHUNK_ID_FENCE;
@@ -309,7 +306,7 @@ static int amdgpu_cs_submit_one(amdgpu_context_handle context,
 			dep->handle = info->fence;
 		}
 
-		i = cs.in.num_chunks++;
+		i = num_chunks++;
 
 		/* dependencies chunk */
 		chunks[i].chunk_id = AMDGPU_CHUNK_ID_DEPENDENCIES;
@@ -341,7 +338,7 @@ static int amdgpu_cs_submit_one(amdgpu_context_handle context,
 			amdgpu_cs_reset_sem(sem);
 			amdgpu_cs_unreference_sem(sem);
 		}
-		i = cs.in.num_chunks++;
+		i = num_chunks++;
 
 		/* dependencies chunk */
 		chunks[i].chunk_id = AMDGPU_CHUNK_ID_DEPENDENCIES;
@@ -349,7 +346,7 @@ static int amdgpu_cs_submit_one(amdgpu_context_handle context,
 		chunks[i].chunk_data = (uint64_t)(uintptr_t)sem_dependencies;
 	}
 
-	r = amdgpu_cs_submit_raw2(dev, context, cs.in.bo_list_handle, cs.in.num_chunks,
+	r = amdgpu_cs_submit_raw2(dev, context, bo_list_handle, num_chunks,
 				  chunks, &seq_no);
 	if (r)
 		goto error_unlock;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

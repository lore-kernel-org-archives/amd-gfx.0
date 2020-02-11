Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5167EC3B186
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 11:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296A6206D7
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 11:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cUEBnF8k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296A6206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB1416EE22;
	Tue, 11 Feb 2020 11:23:09 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690081.outbound.protection.outlook.com [40.107.69.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3094C6EE22
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 11:23:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQD5XuWGRd7Fj1T+IDPkxSfDY2zDh7iXIN4vVF44KOX60jpt3Mrn4opNanOc8AZQAujTjgmceCCye3JG2jgI+9HqjIQJOOPTpvvpT0JHiiuO5uS+GY07dBi7oXnVGesHrElAQfYjAfaStZUvQpRmlR/bmfGgNAr4khZaZIUzHvQeDsEHyIlv2ZiL08QD7hlaqauGTJ2I3lY2yrzuPWMX3FWACa/2xnf17lWunkwcnt1ihrhQn0/ade+4KwYuXihN36H3VkGwK+AUtPK9DiF9F/SVDgaXF0iohi+ZWSCEpWaOoZbLu/kM0iQoSi7rKcYqzs8NhGgYA+KIV5SwoY5Aeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMCXjSe4dkuTr6+uWlYdUTIz7KeRa3sz323qxwGe0Tk=;
 b=WSy4gX4hK5l3rJnt3+md1yDCC+ZS60p6u+PpUdBnysI/GEqFQbaf8e2Fd/GNgg1MZgD76Ufzx6t+UNc4kSo5Dtk+Zf6iaPncLak19ROdOpAEydk4ze89ziBv08fxDHZCaI/3LGS3RrlMUB/bhgm5EQ+Qn5O6iBPl35UBsSeJDgGoe9BHSXE2o0mPjRhDxXEDzl+Td2c0JCNVrEUjmck2nGlBs059Hudl+58MqtTLo4xDGh6zd82856nKYNcLaHjVRty7deBQLLZjIiJ+FdoNM2yRhsSweT1qfgIYjngPLz3nbVL+VrZTkLrsmtSFF7Xem2p8JrdwrkRdo7p72esSPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMCXjSe4dkuTr6+uWlYdUTIz7KeRa3sz323qxwGe0Tk=;
 b=cUEBnF8krYONuzvHLI766ITvR7dl0mRvynICtmDwWddBjiwPgpzpVybz3lwFaYdoJDd4lneu6Ji5r8/4NNAxsJEuVom2/kzV5XdcDMmYwuhf+B6QSSb5NVz1Y36TO+q9sFh/jjS0GhOmTRLe0BJHsmbKmQWVYj/1YVAPQ+JBZ/8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (20.179.83.157) by
 MN2PR12MB4221.namprd12.prod.outlook.com (52.135.48.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Tue, 11 Feb 2020 11:23:07 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 11:23:07 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH libdrm 3/4] amdgpu: remove the un-used chunk_array
Date: Tue, 11 Feb 2020 19:23:02 +0800
Message-Id: <1581420183-14223-4-git-send-email-ray.huang@amd.com>
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
 Transport; Tue, 11 Feb 2020 11:23:04 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.188]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 063e237f-6149-47ca-9536-08d7aee4c4b4
X-MS-TrafficTypeDiagnostic: MN2PR12MB4221:|MN2PR12MB4221:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42212CBA318273550259BB94EC180@MN2PR12MB4221.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(199004)(189003)(7696005)(52116002)(956004)(316002)(8676002)(5660300002)(4326008)(86362001)(2906002)(2616005)(54906003)(81156014)(478600001)(8936002)(6486002)(81166006)(66476007)(66556008)(6916009)(66946007)(36756003)(16526019)(186003)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4221;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kozDDuXe09Z3C1gVxs+2ZZYSC3XVzqxLdN68vuZFhV/ygbirR3B/ZdNARz10/1ckqJhXYz7BYEMOdIS85zAMZTV2PS9iFFLehNFf22Oa+9ZiCCjxANKF22y/BThWm1+pRHzHvugodiex+TWLNkE98SfJ6faz1t6TJbgQAMlrezaOOBx38i10JET3qY4njNvESOYW5AdTKYGM1Au3WwUFytsPlKy2iDbZa+ar0i750Pz45fjywCEWMpXh8yWSWQPJZ/HH/XUQ3xbAlnKCg/eCkrkvW2HW/DNWxiPN3Gs94mlyhyGxWmxh+Uumt6QaFPl3/q70yp7/zp7V+L/sXRL86C3eeBgCi9lljGjNxFVt32EqcbAK5GhYx+1Mgu0YFVaG48bAOUfLqWrCQP4wbqiAZMSKyCoclOJigGRSeXZe4+T9DCzxrZwjFWJr81xFXGHA
X-MS-Exchange-AntiSpam-MessageData: //HTEzm/mMo7Aow+cD4PFlkOGs2ZiJ+VTLdxkL3cfGsciZn13GLeAuOSLX0J4pUgzC5mOJx5ZSrsIc2ckhUR8D0AJ3bXgrHB0eJA19cJX8rLB3wceEuHmhZql25n8ozc2JNbbzTU8s2W7mUJ0NyMRw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 063e237f-6149-47ca-9536-08d7aee4c4b4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 11:23:07.5777 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4RnFMC5SKy62bE9ELETOjojjO28Nwb2xwu/aXESs3b09iTjJgVSZWhoUq9QtXgOfDms00vZGqBP9S8QrpUKgA==
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

This array won't be used.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 amdgpu/amdgpu_cs.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/amdgpu/amdgpu_cs.c b/amdgpu/amdgpu_cs.c
index 864a76a..1772dbf 100644
--- a/amdgpu/amdgpu_cs.c
+++ b/amdgpu/amdgpu_cs.c
@@ -221,7 +221,6 @@ static int amdgpu_cs_submit_one(amdgpu_context_handle context,
 				struct amdgpu_cs_request *ibs_request)
 {
 	union drm_amdgpu_cs cs;
-	uint64_t *chunk_array;
 	struct drm_amdgpu_cs_chunk *chunks;
 	struct drm_amdgpu_cs_chunk_data *chunk_data;
 	struct drm_amdgpu_cs_chunk_dep *dependencies = NULL;
@@ -246,7 +245,6 @@ static int amdgpu_cs_submit_one(amdgpu_context_handle context,
 
 	size = ibs_request->number_of_ibs + (user_fence ? 2 : 1) + 1;
 
-	chunk_array = alloca(sizeof(uint64_t) * size);
 	chunks = alloca(sizeof(struct drm_amdgpu_cs_chunk) * size);
 
 	size = ibs_request->number_of_ibs + (user_fence ? 1 : 0);
@@ -254,7 +252,6 @@ static int amdgpu_cs_submit_one(amdgpu_context_handle context,
 	chunk_data = alloca(sizeof(struct drm_amdgpu_cs_chunk_data) * size);
 
 	memset(&cs, 0, sizeof(cs));
-	cs.in.chunks = (uint64_t)(uintptr_t)chunk_array;
 	cs.in.ctx_id = context->id;
 	if (ibs_request->resources)
 		cs.in.bo_list_handle = ibs_request->resources->handle;
@@ -262,7 +259,6 @@ static int amdgpu_cs_submit_one(amdgpu_context_handle context,
 	/* IB chunks */
 	for (i = 0; i < ibs_request->number_of_ibs; i++) {
 		struct amdgpu_cs_ib_info *ib;
-		chunk_array[i] = (uint64_t)(uintptr_t)&chunks[i];
 		chunks[i].chunk_id = AMDGPU_CHUNK_ID_IB;
 		chunks[i].length_dw = sizeof(struct drm_amdgpu_cs_chunk_ib) / 4;
 		chunks[i].chunk_data = (uint64_t)(uintptr_t)&chunk_data[i];
@@ -284,7 +280,6 @@ static int amdgpu_cs_submit_one(amdgpu_context_handle context,
 		i = cs.in.num_chunks++;
 
 		/* fence chunk */
-		chunk_array[i] = (uint64_t)(uintptr_t)&chunks[i];
 		chunks[i].chunk_id = AMDGPU_CHUNK_ID_FENCE;
 		chunks[i].length_dw = sizeof(struct drm_amdgpu_cs_chunk_fence) / 4;
 		chunks[i].chunk_data = (uint64_t)(uintptr_t)&chunk_data[i];
@@ -317,7 +312,6 @@ static int amdgpu_cs_submit_one(amdgpu_context_handle context,
 		i = cs.in.num_chunks++;
 
 		/* dependencies chunk */
-		chunk_array[i] = (uint64_t)(uintptr_t)&chunks[i];
 		chunks[i].chunk_id = AMDGPU_CHUNK_ID_DEPENDENCIES;
 		chunks[i].length_dw = sizeof(struct drm_amdgpu_cs_chunk_dep) / 4
 			* ibs_request->number_of_dependencies;
@@ -350,7 +344,6 @@ static int amdgpu_cs_submit_one(amdgpu_context_handle context,
 		i = cs.in.num_chunks++;
 
 		/* dependencies chunk */
-		chunk_array[i] = (uint64_t)(uintptr_t)&chunks[i];
 		chunks[i].chunk_id = AMDGPU_CHUNK_ID_DEPENDENCIES;
 		chunks[i].length_dw = sizeof(struct drm_amdgpu_cs_chunk_dep) / 4 * sem_count;
 		chunks[i].chunk_data = (uint64_t)(uintptr_t)sem_dependencies;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74600C2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 10:10:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2445F6124C
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 10:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2445F6124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9ADA6E061;
	Wed, 26 May 2021 10:10:51 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2077.outbound.protection.outlook.com [40.107.101.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E09D6E061
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 10:10:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlkKVhhj0Z+XhelqQuCitl2D+xdTe1VCcO6atheBXUSqPosA4Kk5e3QD663yL+tjSS0E6iReQ08xpm3eZHOP6EyhO8sJOHZApIcZ2vm8H5SKzaX15IXiXkt3kYM25i94XXWqqZkv/o1ThVmtbjd0HbIs8PfvXCyw37PZasW+r5aGDXwJZTXiyYfYyPVV+bxvtABQyo2CVtukAbL6kzMBZsKTR3twnrKS8CClZAxfUNz7HY2mxz/Xz5d3Wqs93e5cA+diRKlmUw3NDt89ghtN9v3zQ8bCi1bgAeBQEd/NBZ6Es9TtoIrgTOMNe2JoG7OvBIquI61ZAEfJL2RUoZP13Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gf3seuUUuVNxtKeU9ezZ8CbsMxPCtiKxScp01AwdcwY=;
 b=j8Ng6DC+l/QtdRi+TkSMf8w/vNqtXmC9uYgCTYEdEe17tztAeu6q1QtGKEc5RlOC08oZqWJgKr/nf4k7kS+5bm+UIBvhTlVWIx6mk2wfN5qe8q7vklM3pWvWciXwJkK0iIa0SWcmpMKaGRu8d9gZBVOleihSGy2wWBkLYhiw/qWIgPoN+E6PmFdNmvSM8CM96q6CO7w0qYY37LbRWBCwuRHk1Hkaw5U6rAh45zZbwhnguePqZcmmTUa3J3OduYFoWmGT6Iq1DFJFk6kjOALWG/4vSVlkDnwKbNbRvQe9zBWtVkxYUWxKZNdQm4qy7gtm3oBQ7MCICbasdjTNvGC2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gf3seuUUuVNxtKeU9ezZ8CbsMxPCtiKxScp01AwdcwY=;
 b=uAc5MZgbpANTzUupIatT0fZppVgi6l9HGdOL6uAaROVjsTVkuHZ8usjxeZpXZhdp84u27lqrcQciZpqUdoqZI23WMKRtyIsDvp68nPJusXNnO0tNEQv4i8zxTiwyKD9pyy7CCDzIklwpA+n4TknBU1mMoj2vMlAKgVf1gD9Wxqg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5232.namprd12.prod.outlook.com (2603:10b6:5:39c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 26 May
 2021 10:10:50 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 10:10:50 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/7] drm/amdgpu: move shadow bo validation to VM code
Date: Wed, 26 May 2021 12:10:22 +0200
Message-Id: <20210526101027.14936-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526101027.14936-1-nirmoy.das@amd.com>
References: <20210526101027.14936-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.98.218]
X-ClientProxiedBy: AM0PR03CA0049.eurprd03.prod.outlook.com (2603:10a6:208::26)
 To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.98.218) by
 AM0PR03CA0049.eurprd03.prod.outlook.com (2603:10a6:208::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 10:10:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4f308eb-15b1-4012-7c39-08d9202e89b1
X-MS-TrafficTypeDiagnostic: DM4PR12MB5232:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5232C24223B423DE5A950E738B249@DM4PR12MB5232.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6TSGwqUh2KCiWMSuHvlZNUHUJL9afSHK8SQWlEGmtIv4WGr5LCGQ30zUGOXnOm3Q39Lz90n3YpN7a27ygdgawoO/f35zFmXhN2/TOXSOns8tmUdji4+2tnTWMWLMsokgsYtxCAnjGEpHi5TFFwvSshI+4w2UiNMRFAHpeSp3hGJASr+Boat1DxvzDZnOTOMvbTkf2E5ENAyqswxc8i+RbYAcQZs36ehDApBv1qN7leqUlfb64y8gSQ7FZapQx9BNujY/hyA0J2wOm8AQpqKyusYKOcYfQAQPG0DJX/ba0vNuOr76OowBPP8RembxlbPqAORsSt7VJXzr81oOsP6D6P2LmJvE5Cjy+A3YvP/NUeOkFQfR+KBV1Upf8dPHFDoP6EyXHEXZGNnGCaq2a7Bs3A7Lx/2+BytD5MXr5pbD2bcBPAPFHFR7UredrA8DauXr48B7dZdts6S88makbSuEX1xAnu7+H+lcl/QPnW+o88kpfFQQ1vmQdJNj3FdXuN5nelUlRxVy2S8vbSaluog81BktG8zjfvXUH/TpjPLLI2gGzsCcZQDsS95cjAUqiitXgb7KCFDujhUtp/jQ0nAeo+o2dFCeou64GM4RYIRXk2bLcX4hJbAsxkSLPKfamYi7J2mwSmWO/JBXsX0211HqW3kJ+68rQuS41pBcZCFhszM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(5660300002)(66946007)(66556008)(6486002)(66476007)(6666004)(86362001)(2906002)(1076003)(6512007)(83380400001)(16526019)(44832011)(36756003)(186003)(6916009)(26005)(956004)(2616005)(4326008)(478600001)(6506007)(8936002)(38350700002)(316002)(38100700002)(52116002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?w8nrOOwLW66fAJGpXjmnN0S4ru4ZMhFB4c4HkADO7kygkNHpMs3s0okEMEV7?=
 =?us-ascii?Q?FgGTw0GX2uwsDowFLARJMYq7V3iMRbmsEqP+Iu3FDmwqGXvQwDc/26RMGYO5?=
 =?us-ascii?Q?mNQDWrvgyOupE3jJ4MQIqYW9/sQ88k0gPv8DoyN4Imp3/tNOWjbSi7htIPeJ?=
 =?us-ascii?Q?OJOwdzb5az/IcjUqOvW7TycQA+jef+5e5x37QyZFE9lyyE4IlXaRZAqx7fw0?=
 =?us-ascii?Q?ejPWS0r2H0EeKUnnzAQaOhQDBWyK8FXuC5BxZqbKE8eUu0e5IFXXa7BGPhSv?=
 =?us-ascii?Q?8ymPxwQaiBtBQ0p8dLJ4NNaJZOhn1p9rXzglHMKXCuxRjK7lOqQUgQk7ID3J?=
 =?us-ascii?Q?4uNU/o7+/6uoKaRvb/Vlv0kvjgkenuHxyTmhCsXSHgag9fhk6VDvMF3/fJkU?=
 =?us-ascii?Q?1fcvEPjwWQ2tNWuOTTcsLxjdlMAtMe0daMaw0f6ypFOq8KoS0OPOt1tFuNFG?=
 =?us-ascii?Q?qbuz9NMm5Dhf2I8j3vBo1/y6nWnAkYkD+2A9Yv9ApTBuCDduxOZnarATxjRg?=
 =?us-ascii?Q?iSN3ziwbpG0Vuhz7/QtbC9VTQwBg0FygkSw5/1Y7MllgnQj3j7ryNmmfU3lk?=
 =?us-ascii?Q?YClLlKIN0WxoIxFQfXqWqSPOAc3ncDsKLmt6+h3sSwowOzoXcwzxWA3YbOrC?=
 =?us-ascii?Q?TmKbE7iZlsM5qvMW2LKZmdtAJQLgQ3ujvROpsaOUl9In4ZUc/BpQNmPc/TXO?=
 =?us-ascii?Q?dIqBZcUUGgPXDMsh7KsiI7zyT7LjYBj00k8lmcUWqztpC5XPnWIYYN2Euo/G?=
 =?us-ascii?Q?vcrX7vmI7LcOiLKoiZT7d2XzUPAITRHx1Gh9JIVh1pACVVUar2Ij2/oEyHg0?=
 =?us-ascii?Q?pNQlK76SGuIf4yCB17IBs1ssgsCTara9AaOGXdjvr/2TNMzmU9jc+nZwewZk?=
 =?us-ascii?Q?wkEDmZdRFFl2KpttuaodZLVuk6JLLR9BCD2YbzGIRX0y1Op06Otmf0KjXyM0?=
 =?us-ascii?Q?cXL47fYc6UhFX6vLqOJ5L7ApWV9Be8S501dlGiE4lT5VzRssmcaYS55SOJoM?=
 =?us-ascii?Q?h/YqdU6TkE4XuYjy5vjuBysJJeUo8OiH/ouxJ6b9Ef6wVWdGUKn43eWbrw0Z?=
 =?us-ascii?Q?lvOwWgD3EfMNXm2Q8tog8EKCR4mlMcng6CbNZuhYCYfJS0B34yXIz0st03Oi?=
 =?us-ascii?Q?cvhbLlYK56Bbu2ayvbgqOdPtmnFV9lBtASh8AvtWLev28nmwcdXxFKFT2HNK?=
 =?us-ascii?Q?SvJoH9F3nRDyXhOufJgaheNabAW1v67mdwV+PBjixHsGbyqMMHoyZsoTc50D?=
 =?us-ascii?Q?lUaSzRJS+uLVAvg19xsuacZ81f5ZxNJBSDk0WjIosWgYMoGMMyPEtktSooK8?=
 =?us-ascii?Q?AKnl9bTPEffMXGlzFeR0r/6k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f308eb-15b1-4012-7c39-08d9202e89b1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 10:10:50.1495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZXEmgvR97mDlhbMsxZQ9XQbk6eiXq9DLPcIic/DvDUTER+DS8xrXzw/OmVjKPIHjpPFsxfnw8OBZMvd7MoR+ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5232
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Do the shadow bo validation in the VM code as
VM code knows/owns shadow BOs.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 23 ++++-------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |  5 +++++
 2 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 90136f9dedd6..f6a8f0c5a52f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -396,10 +396,10 @@ void amdgpu_cs_report_moved_bytes(struct amdgpu_device *adev, u64 num_bytes,
 	spin_unlock(&adev->mm_stats.lock);
 }
 
-static int amdgpu_cs_bo_validate(struct amdgpu_cs_parser *p,
-				 struct amdgpu_bo *bo)
+static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	struct amdgpu_cs_parser *p = param;
 	struct ttm_operation_ctx ctx = {
 		.interruptible = true,
 		.no_wait_gpu = false,
@@ -451,21 +451,6 @@ static int amdgpu_cs_bo_validate(struct amdgpu_cs_parser *p,
 	return r;
 }
 
-static int amdgpu_cs_validate(void *param, struct amdgpu_bo *bo)
-{
-	struct amdgpu_cs_parser *p = param;
-	int r;
-
-	r = amdgpu_cs_bo_validate(p, bo);
-	if (r)
-		return r;
-
-	if (bo->shadow)
-		r = amdgpu_cs_bo_validate(p, bo->shadow);
-
-	return r;
-}
-
 static int amdgpu_cs_list_validate(struct amdgpu_cs_parser *p,
 			    struct list_head *validated)
 {
@@ -493,7 +478,7 @@ static int amdgpu_cs_list_validate(struct amdgpu_cs_parser *p,
 						     lobj->user_pages);
 		}
 
-		r = amdgpu_cs_validate(p, bo);
+		r = amdgpu_cs_bo_validate(p, bo);
 		if (r)
 			return r;
 
@@ -593,7 +578,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	p->bytes_moved_vis = 0;
 
 	r = amdgpu_vm_validate_pt_bos(p->adev, &fpriv->vm,
-				      amdgpu_cs_validate, p);
+				      amdgpu_cs_bo_validate, p);
 	if (r) {
 		DRM_ERROR("amdgpu_vm_validate_pt_bos() failed.\n");
 		goto error_validate;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index da155c276c51..f474f15ba344 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -696,6 +696,11 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		r = validate(param, bo);
 		if (r)
 			return r;
+		if (bo->shadow) {
+			r = validate(param, bo);
+			if (r)
+				return r;
+		}
 
 		if (bo->tbo.type != ttm_bo_type_kernel) {
 			amdgpu_vm_bo_moved(bo_base);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

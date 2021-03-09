Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A245FC433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 16:55:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 556E565230
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 16:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 556E565230
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D827F6E194;
	Tue,  9 Mar 2021 16:55:34 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E88C6E194
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 16:55:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzYDKPLg+wGy9XqCbxujspIvmGF218ivnAkhqlhz2mbK2nQGkY1bZubdpNjNCJe7zUf1ZtifEdcCeKTKmLFDOg465I1RaJGFW3q7zvghynDhk8b6un7UY5TRf3yZXmpIr6VPmYAB9RNfFH+yBVFNQ6enuYA7J1WFDaGDKsdWdEOPvsfDBUw6GPdpuTjZv51r3zhtzYc7qodtpd/f9ycPWHHNfzmIqQfH+/IhrVxaRF2ioUX4wnPmz4RtPxqhXx0QtBPKmuQjIjIfR7gPqK1HdBkbv3zsu2UjwIXOmVkleIQhe9v2EWhPbgkCk+B/R3bw5pI7UlconNkzohX66OMrtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmwJmOXTs0Ba8Ywgb1KW8UAzUm9UclcolSCoV2d4B38=;
 b=XYPgOOy7C/uoXEG/AU/QOHqTnNa1gtBIRCkmr3bDxY42Ijqnhbo7wxpc/nHbQ6w1WbQc+JQ8F/hhn+VS+mB4hH9fl2yb+4XqqMMx5pYJEZYWwjsFGNbuo2MDiF+lf311T0pIvB0DiHicwv9AGXFqBhIMEY62K6/zLcoGrW5idz7nuc5YLKxPmH/X8FdjZDjyj48o0ghxVZx6+a2yZswpWBhbdwr/oDEuL1C+60HefQo424GZOWLZqI/KnjhAH+9A4No2Wsxia5YExChAc59zqSKMdMJnSFjEg/spO9gbkLRqq9Hgw5vx/fS/8dZoOttMu8Erb1UQNe8SVL2HiaisGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SmwJmOXTs0Ba8Ywgb1KW8UAzUm9UclcolSCoV2d4B38=;
 b=xgOrTfu19RN+xjcGJyo7RpLc6apGHlkvahvO2JzOJHOTRBMdHCwZFedwZc715Qq4YJIo5zcYJZPCXfRfwt8TWDQR/FGxqdaaTeGALRd4WxF+w1HBs5DgbyQp/Xrjb2VE2kOytcos8wdlgli8YKcd4P0E3WojZebrvmafyoy3DHk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB0056.namprd12.prod.outlook.com (2603:10b6:910:1c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Tue, 9 Mar
 2021 16:55:32 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3912.029; Tue, 9 Mar 2021
 16:55:32 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 1/1] drm/amdgpu: add amdgpu_bo_destroy_user helper function
Date: Tue,  9 Mar 2021 17:55:18 +0100
Message-Id: <20210309165518.7721-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
X-Originating-IP: [217.86.127.127]
X-ClientProxiedBy: AM0PR02CA0124.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::21) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.127.127) by
 AM0PR02CA0124.eurprd02.prod.outlook.com (2603:10a6:20b:28c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Tue, 9 Mar 2021 16:55:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f94d71d-3297-41d2-7138-08d8e31c2692
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0056:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0056B50843532AA1E2A76C628B929@CY4PR1201MB0056.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:213;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VEPH01DjGAijfa2wU3CgcxKjK7TDlzw5LQNDh7jImPz5kyzrtKFq79LYzKtsJ/AO3lqKlpiOZokiz1pZofRGff2NjrbfFvCb+TY2XuVwA4SJMNfP6n+cTqdyvCA6vtAAqidtNFCesctRQtmsqsG/nOvwPK75q/y55VSNmqVJOAGQ5FnTKIM5K6IQjv5PgSiP3p9n83alxfriv1eMPqGzs0WzKsKnAJXxIK2k+8nklSnHzJQ7lSlHx8x6pItSjdQgl0ZurKsa3rugJWLBD5lRenH1FPTmzFjgyQopw59fl6hVEmW+a9KFFDGptOrh/+wTGebzc6Nvma/WreMmvFUbytOkIPo2siNzGTe8bxLXZXLAkAYfzVBXtk2OHUEgpaSGxZTP6fPz3nuw03wfN3DUSOFkdAxjvgHnIJjb7eTlRvqGLakOXrNNfX2E8Jqs1ESdY/ZMTBTBinVBcIj4nT1J1C8aqC5/xX+pXmwNSujBYn714yVbJ4ys/8N3HEHqYpMsP1GBZJkWEuEsTEuAjxd0UA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(83380400001)(86362001)(2616005)(6666004)(37006003)(5660300002)(186003)(316002)(956004)(16526019)(44832011)(8676002)(8936002)(26005)(6506007)(34206002)(6512007)(36756003)(6486002)(52116002)(66476007)(478600001)(6636002)(66556008)(66946007)(2906002)(4326008)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Zdf8NJoProGp7qiTeK6DR9TbusVMFW8Xd95XrvReyd+SKZ/XAHNdR/YJUv1K?=
 =?us-ascii?Q?oHkN33f6lA9EHlInrlq+F0u5fl9DYjelNogHgSzKCf7rK4gvqtjDtEgO3G9H?=
 =?us-ascii?Q?dBA+ijJvYFDIloCUqBUj6EbelI5yuBVeRFRTfVL8KBr/iXkRWHz9gJmorscR?=
 =?us-ascii?Q?QRG4ZMK8/jgCLkIT2Dn/+ZAPQtRskXOR2UkI6eaqNqrXipfpUYvGxG/K7RjZ?=
 =?us-ascii?Q?xQquBYq1VAL4mJotstGl+/ibwPKHYpG/EHY72rvIsuS8JnI4U2tuW95mqVq2?=
 =?us-ascii?Q?WgPVfOAUb9Ltd7c+La1TDIkB3S9biBna4wqgjgLC8Vbk3M0eCh6KXEjVRkTh?=
 =?us-ascii?Q?O47oolNc/ObWlnOjkmFXuVZ2lKPkiVtTalkVBfYqwGjOz4qNSPGboMLvgr0P?=
 =?us-ascii?Q?IhNrYdSyEqjSiwpszilRPq4HrugI5gAAt0/T69slxEhgLrHlAh3krygNWghj?=
 =?us-ascii?Q?PInX2GoCdN6X4QvBFI6dT9CQNZqoBKlLtP0KKfFjRPAex3p+PMZDhTWW33Ow?=
 =?us-ascii?Q?Y290JCcKMJQAkhoJ5ocdxCVZSKJbBlcK46fWbyI1uhhgjUcmYvngDKWGA6RI?=
 =?us-ascii?Q?gzlTweuJGXgIAZ2O62NLfDNySdNyFLuLhSt9lqVAUOy4ZYqxJPm9vPseDsRt?=
 =?us-ascii?Q?sfkr4ws4wj29SnVQIkW4J4koUtJXU86mDbqNZEqk4Zrn9v8siPjsAvzF8NbS?=
 =?us-ascii?Q?GcRsF3aSvRIinSch/I/rpu2uxGMzRi6GPxyje3Jt5rg/no2BpJXOp+3/ZR4m?=
 =?us-ascii?Q?EbixHAQrbEO1yn54XZaayJVuo/b3BYkttne05RsSIX8wFyh8sn7E1scOsg6g?=
 =?us-ascii?Q?1hpWuImCd4kqsB1Te5Atd49m7lCRZKjMm2k4ie/lHR6jvhbuv1OUOW/5hNWz?=
 =?us-ascii?Q?N0jZvFSCW22Q1fxFB3l0JevJeE2P0dXEhl7qP1CUkZM+J6WU6Y0UwH0SF41W?=
 =?us-ascii?Q?dIS3XxmJM62JLW7weeqmYpvCtSaYPtgWzUIfyh0LVMAydNhB6cZAbFRbU5jE?=
 =?us-ascii?Q?qym+eEhHSEbral8yHExEaSFSz49EZ5T7SE3rZ+Sui7Xudw1I/XHJmSw7Kf4U?=
 =?us-ascii?Q?kHVkA2Xys0xSRz2lDGEhvPxcrv50A6FG4LHDHylccAKVcOOh9Jlo5lyoqmzC?=
 =?us-ascii?Q?06U6hhMSOYUFBmcvHidXDzV91psEq+yG7uTZW1eJFYS3yjLHo21hgjGsOt3r?=
 =?us-ascii?Q?EH+vjAFa6X/+X+heHkyW3N6KrQhI9mcy2uuVQ13Ow1RMv4RWYKMSQk7PLpeV?=
 =?us-ascii?Q?TzLq/3hNRPVcTc3FjTvVK4RfV/QgwrXWs5NFv1K1Qe37gtEgINYRX1Fex2nC?=
 =?us-ascii?Q?gC/4AD20MqKFVzKiMeJtiJQ/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f94d71d-3297-41d2-7138-08d8e31c2692
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 16:55:32.0265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUS2bfgOrW5NJtdp135O6TTXLDdMRooekLh2B0OHmjt7FJi+jJDJvunSh+d+mSbwV7eMWU2WUwen8J8zvXbRzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0056
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Implement amdgpu_bo_destroy_user() helper function to simplify
amdgpu_bo_user cleanup.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index ac0e1cd83858..cdd5d02e7b26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -73,11 +73,22 @@ static void amdgpu_bo_subtract_pin_size(struct amdgpu_bo *bo)
 	}
 }
 
+static void amdgpu_bo_destroy_user(struct amdgpu_bo *bo)
+{
+	struct amdgpu_bo_user *ubo;
+
+	if (bo->tbo.type != ttm_bo_type_device)
+		return;
+
+	ubo = to_amdgpu_bo_user(bo);
+	kfree(ubo->metadata);
+
+}
+
 static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
 	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
-	struct amdgpu_bo_user *ubo;
 
 	if (bo->tbo.pin_count > 0)
 		amdgpu_bo_subtract_pin_size(bo);
@@ -94,11 +105,7 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
 		mutex_unlock(&adev->shadow_list_lock);
 	}
 	amdgpu_bo_unref(&bo->parent);
-
-	if (bo->tbo.type == ttm_bo_type_device) {
-		ubo = to_amdgpu_bo_user(bo);
-		kfree(ubo->metadata);
-	}
+	amdgpu_bo_destroy_user(bo);
 
 	kfree(bo);
 }
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

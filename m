Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803B0C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 15:37:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EBE86521D
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 15:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBE86521D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF39C89B60;
	Mon,  8 Mar 2021 15:37:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDBEB89B60
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 15:37:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUNc7W3BrznSNSw7zHdKR+bvQs9R2qKBxdvM4Bl4MPEhL0jwKsmjBtajNMRCqwVIWcXlM4C4MM3Eqz5yNxI0TdnlefCyS3p1tFSuKx77KadhBCxx7dSDhNzRG7LjRkF9xvmGnDbVasWkMWtqFSEA9i7/QXfcnlIHR7JmYWUtx9WU/GXdQgH4AAhkzEEzDIy9qwUU9uEIfL9Y3Un+K5hZIm/itQfobqZlVnpRj46Pm41KUjY7fPYME+XxHc+kIys9dB4vVGCNxvXM6GL4mBer5PpZOj2whZrlEYNa+j5LiF6LZQu9Jb1qJAtA50k3RshUNfIlJwGqfeFVS21NeAIkIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgEEoFzl6hpE2UUTe2gbK1L5R7mbrHvu0/yLbi6qBlA=;
 b=eAu04/TzAslEQmqYZLwPAARMc+MJnlBizbGegMI4wfJplZ7nAObXm64fq+0c0WZZEGHIatp3Nb6zwLDgTKYVQjKjh1k2aEnc0PA+Uwp03UOUWQRz+x8mZs5Afm05xgPX7qpTb4a1VYNhYSR2fsuTdgdtOCoxNbvGENaF4nM2VIGLpPMbJNE7umwoyTI3EQ3SNd6TGeDUl1KRHkTM4PggVYrvgAB6nhvK62O5XknnMbsCPGiaN6YP6w2xEYgR40tlUErVNKn5dD/0UIjw2iqHjPqgXASPp6+zQbAgCE26GoHQb0HDOhBssN1J1KEyzisyDynIWNyglBG3rA2RlH2LjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgEEoFzl6hpE2UUTe2gbK1L5R7mbrHvu0/yLbi6qBlA=;
 b=oeLcwiZb4nh9sOmKnvKsfi48VQccXYqz1Nyk32FR5jE2nGs+jOiCvrQ8XfKhuDwKubrLvsx0K0RtD5YfJPpPpNXtEgo82092pofY9gs/k1Xny3ajgohSzy7sCNlH3WCn1PHvtpa09RsuRe+ixduj2yXVgI9UtljxaojUAAaenP4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1237.namprd12.prod.outlook.com (2603:10b6:903:3e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 8 Mar
 2021 15:37:19 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 15:37:19 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 1/5] drm/amdgpu: allow variable BO struct creation
Date: Mon,  8 Mar 2021 16:37:01 +0100
Message-Id: <20210308153705.37414-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
X-Originating-IP: [93.229.42.112]
X-ClientProxiedBy: AM0PR10CA0003.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::13) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.42.112) by
 AM0PR10CA0003.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Mon, 8 Mar 2021 15:37:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f42a119a-6302-4f1e-34ec-08d8e2480f42
X-MS-TrafficTypeDiagnostic: CY4PR12MB1237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB12379730C482D5EC8F74F8EF8B939@CY4PR12MB1237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BwjBIwiZ4fO10SA/U4prYCwBFNObkT21mYcFsjHLZykWx/H1fSE7PY5K1dCzCjCEunn+oP2z8/RCjnxxMNfaXGYrQw6Yv2GkG+HqQvft9eRcuvNly2kYFc8aaMedrfuTKNmnFkjyXxsA7iZvafc/q/p2n4be+EF/TyDK60hUFz8lyX9Y0KIM6lG3DSppah3l2GlpwytWMDTYDUSesvCqTkisdpXvVwOo5JMW4mihaYuFDfUlYk1z5x6vxhXAhR3NLoSxEegISETw6Mgd2jlsQkSahoMwBLfdKvzJOXrh0jKZNexX31TN/5wJ6vsLx3RrsdDA8L8h+c1WEpU90oxowQpVe29zJmmkCxrMtgwTxpI4GNFFWM+JNnX91q+qmdAtzJLYyAJPqy/Ug1r//u314p4NBPbZpF1o//IMfNNvn8lozxow9hfKMQl2GbMI4AY4Xlzen4rMHbnHuLQnJbodI+k4VvkOPuBoBvM2XZ5rxp0PmJ+NHtC4pRjxho8JcZHNE2Dc93nxedlwhlplEvTj6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(186003)(86362001)(44832011)(2906002)(6506007)(16526019)(66476007)(6636002)(26005)(478600001)(36756003)(6666004)(34206002)(37006003)(4326008)(66556008)(5660300002)(6512007)(956004)(316002)(2616005)(83380400001)(1076003)(66946007)(8676002)(52116002)(6486002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?j3aOtQLG+eu68Y2WagYFiIJ4fL01uBcMaSTInyxTYrKUwVEJ1cAVae0tf1be?=
 =?us-ascii?Q?0oRWk51dLb9uNCU2XTrDFsPtjjQrhhdy9D+N+YisYtWzzOgR2EqVzIOYs6a7?=
 =?us-ascii?Q?K99qGWLvh6O/8HOhpp3o0QzBIvFsHJiIbFSMkcAfng28ZvXCpOnCb3GJQA5H?=
 =?us-ascii?Q?TL2RKElbztR5sttKlktsIsr0mYOVEpqwZMFNK8i9gNEZNLkcEBQjiBxBBawV?=
 =?us-ascii?Q?IANeplCCfrbzr7bwnSbK5Xw7SrNejHPyeMzIUK/zKRUMFZp4hgw6WfdQ1sHj?=
 =?us-ascii?Q?OcnvFSGG0ChdfEMiEPFFULlLKD3Nv4iwmsN8EXQL9o2YB8gONLqOS04v/fiE?=
 =?us-ascii?Q?/tSFY/4aTzpd+N7JhBzF2LCYKNeLrsRPR0Ui8KlOsbzHvCsBCulF6kwJVmwk?=
 =?us-ascii?Q?L1By+uNzvEOqk47Xb5zk1R2gI6WK2IZqI7Gk54sPoXcRx4lHa3eZJO/hXx7U?=
 =?us-ascii?Q?A+8fgW43kMFQZ3PJQ6YIkdJtSwdmirc1hutjsznrssyg1U2s8TT2HVIf6A7C?=
 =?us-ascii?Q?nl3oA0pMGEcUklrS/c5D7kTnCGBq5MIsu4QnA6aGuv+htqIzHZP2Ft3rUrlV?=
 =?us-ascii?Q?atEOC0gXyBcYvRWQhGsINav31D7hgRu/MGaDg6l2RqTschD2lzeAh0r6U7Kk?=
 =?us-ascii?Q?dRsLUs4N3nARv+Zz6aJs7c8NT+Lh/jd/AcZ66eQ8UBDlXKLE8aswHUsgrpCy?=
 =?us-ascii?Q?xECxl5xylXC11itg3IpglgrLm6Plfa9p/oViwHb0D3TZvSIVWJQIH584YBZs?=
 =?us-ascii?Q?df0sYXyCisqC3jLP2hR0mNrhMVfZlXw78thyvg8czRy97Gywm1U7zPH5bBBI?=
 =?us-ascii?Q?zEZaXWzdEA30HviZJUg3avgBGjMgNtoQqtc4SlNewpHN/mAOpkGd5iu8nrL1?=
 =?us-ascii?Q?uqmQn2zvlC/WEq1F30r8ou2LxXpJxiqWc6MJy+Ku/ANludY+yQp0D50tvb7m?=
 =?us-ascii?Q?pQrPBfjUHwmrxCqHIzW3T8lJu2yot3xjaT6Z2iFpLiiCml2m9DcxEaP2LIHJ?=
 =?us-ascii?Q?o+D5PnwWuD3setDA4JY+5IMnPlgwuCSMnUG7rBfktVRvHxqUnueWBWLG3KRt?=
 =?us-ascii?Q?pSfL+evL9DO10F0Nz7xnfrrV2n+h6aGGpjhw812qjqEEoEufuT8C9uMpyjvz?=
 =?us-ascii?Q?ofeDUe1SnLyNzV8M1kwLEUXggL1KtOaHOH6Vwsh8epFhr1xXNQXsDgrdzttp?=
 =?us-ascii?Q?ZbD8/voVP012gD1Baj7fsO1uEclf3TghrMIDzbKb8oY0zj8N+AxvWKhDs3ws?=
 =?us-ascii?Q?cazJXngE2LPVOi1kEkR5cYPe7Lmc710ho88Jd9f/msbiVNe55+C6yPy75CpO?=
 =?us-ascii?Q?6lLHXqIpY7qBT77qUTRkmaCa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42a119a-6302-4f1e-34ec-08d8e2480f42
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 15:37:19.6194 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nssDNjVNbv6LWLeD6gims1s/W6S7Y5ah0cxVHQyx6d8jAcuA2y2iqD1pM5kgUPmifwZGd3z+8Q8GG8Iw5s15TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1237
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

Allow allocating BO structures with different structure size
than struct amdgpu_bo.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 9 +++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index ac1bb5089260..d32379cbad89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -543,9 +543,10 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
 	if (!amdgpu_bo_validate_size(adev, size, bp->domain))
 		return -ENOMEM;
 
-	*bo_ptr = NULL;
+	BUG_ON(bp->bo_ptr_size < sizeof(struct amdgpu_bo));
 
-	bo = kzalloc(sizeof(struct amdgpu_bo), GFP_KERNEL);
+	*bo_ptr = NULL;
+	bo = kzalloc(bp->bo_ptr_size, GFP_KERNEL);
 	if (bo == NULL)
 		return -ENOMEM;
 	drm_gem_private_object_init(adev_to_drm(adev), &bo->tbo.base, size);
@@ -635,6 +636,7 @@ static int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
 		AMDGPU_GEM_CREATE_SHADOW;
 	bp.type = ttm_bo_type_kernel;
 	bp.resv = bo->tbo.base.resv;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
 
 	r = amdgpu_bo_do_create(adev, &bp, &bo->shadow);
 	if (!r) {
@@ -669,6 +671,9 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	int r;
 
 	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
+	if (bp->bo_ptr_size < sizeof(struct amdgpu_bo))
+		bp->bo_ptr_size = sizeof(struct amdgpu_bo);
+
 	r = amdgpu_bo_do_create(adev, bp, bo_ptr);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 54ceb065e546..8e2b556f0b7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -40,6 +40,7 @@
 struct amdgpu_bo_param {
 	unsigned long			size;
 	int				byte_align;
+	u32				bo_ptr_size;
 	u32				domain;
 	u32				preferred_domain;
 	u64				flags;
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

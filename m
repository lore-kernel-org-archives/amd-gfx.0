Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D56C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 17:08:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD07764E41
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 17:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD07764E41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E7F66EACB;
	Fri, 12 Mar 2021 17:08:39 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C72176EACB
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 17:08:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxsIZlVtOuipd3g8nQgqhuOVe6/nepkEPW5uSvMjtHxukrf8rlo6dfntVTFQJ584ELzXxh2K0CCW/GG/eXasj+sF7ed7pEIwic1VeDTOQPhY+d/2HR/av16UkTFkcqXy+tlQtcEiRAIuEdMJ/AB3JDJ9gyR2zbej3w/a+THKxdFo93VqfODnd4iyi3Ii4y779QsJtjYD1j8cfZqIbuGQ7mHwxfpFG7qSHEyonxR0R/yaYG4qpt+ea1I9icN2pjJf1TmbOES3+AJaTp9DMXBbV8BXrjH4d/16n6LUt2VqJ3FS61K8bEXoM+et0sPO7aD/uFd5ejdSGwm0dQnr5FQMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWI2U0c11UFaZ+fmbQ/xsHOrObvnKu19tBT1YO2pFO4=;
 b=YRHpjsUp9mlGU+dossHhO7wODVLz2mM+75iE9DkNT/rojun5JExtyYMd9CJz9GNkVD36VKKsnSPnK7B/8QKgXCsH+uWUSpylV5di9diRSbml4SRWwjqgMA5q5ULDhqlJIpFvx08EgcZWIxM1e4A8LsnPPJxTbeYZ8X1V+sRNNV4OB40w1uyZyOp1ho9vaM5UzYtuogaz5IMrJYvjVvduBc0vgU15V0KbJfuIp/uFIu07UI9c2YGT1wzbYjlYyXsdTHeYvWMjC6gdjQDn8n7/e9bdG6dRY4LMJm2zQUqSm/rohFnyu8vXpIvdx9C4vGiVQkyDgdl5YeHnCWQk46Arvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWI2U0c11UFaZ+fmbQ/xsHOrObvnKu19tBT1YO2pFO4=;
 b=BUjfAdKiwikGsED8L0OXk30MVhR7bABABVrycK/fZ1X18brZfhI//+02b+k/2VWjK3DqKre13i3DvpdUSYtQmx7/YA7cKLEtqEzW7oiwpEOY6Tr4R4skllB4D0wKdk51czco69Qq0ASG+kRamV9h/+JYueArrXnQ4qVX83vwbyk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1864.namprd12.prod.outlook.com (2603:10b6:903:11c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 12 Mar
 2021 17:08:36 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3912.031; Fri, 12 Mar 2021
 17:08:35 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 1/1] drm/amdgpu: wrap kiq ring ops with kiq spinlock
Date: Fri, 12 Mar 2021 18:08:10 +0100
Message-Id: <20210312170810.10934-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
X-Originating-IP: [93.229.58.193]
X-ClientProxiedBy: AM0PR07CA0021.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::34) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.58.193) by
 AM0PR07CA0021.eurprd07.prod.outlook.com (2603:10a6:208:ac::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.11 via Frontend Transport; Fri, 12 Mar 2021 17:08:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e97fc6ae-09ee-498b-1044-08d8e57978df
X-MS-TrafficTypeDiagnostic: CY4PR12MB1864:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB18649179E75F21FD581F52E88B6F9@CY4PR12MB1864.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A6oPCzJFh+Ou5LZubNWwnYXcHhKCtjTGcZ1/oVI+5LrGKTtGEVR9tzVUNd8W/qKeGbSuk3Ba2aMwubu3QX0YL6ApLkv3H3BwzdEqACNS4/g50mTk3bSLQAvIGVEhID8yF/rScBeEH9m0k7M213Hqao425ilTkQACCZuv1lfTBaIJNzpTJ+1tci9qFvsuC7+HEzJfF1N1W3zqHJhjgVNVnZC5wpMOiwaK5/DoPgfF1+V18um4Std/vJnzUCnUpCmFa6rGvSO/iDkZPSLE5+qURIPGDQghH0E6U3ypxagUgs6HPfSvukVZ/oq6J521liM2gKmPG305YVNeHpydkRD2bH3Zl/Uc6+53XxdP3IUgrdFufqfDbE7iYAPahquJ72goT+uv+E5u1idXLIAcmj74xRWb1T1Mp+s6X7xzwdR6YEvqSCFXjoNRpNwtqLnSN8nR+euL11H1fqNSZ+FMzaLYy+Jx7eiM0rrZHLTi72VRXNfufPVwPGRI8uqajFvYeCGWw0M/4w2xmKpiORcHFS51QNV7HzKTAOwihQtzlLHZZ2zZ1XomgDwGJ14xuydQCBwa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(34206002)(1076003)(16526019)(186003)(6506007)(86362001)(44832011)(36756003)(83380400001)(2906002)(478600001)(316002)(4326008)(37006003)(52116002)(6486002)(6512007)(6636002)(5660300002)(8676002)(956004)(8936002)(66476007)(2616005)(66556008)(6666004)(26005)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Kt33rYn4yl8pgMbvi57A8CzUF7MqOCAUbUS5j+3Qqu6lfn0I6sB8JcqlLTiq?=
 =?us-ascii?Q?RYnWkswryots8gweChCBXkN8TPloukc9q8BpFLSdZpyBAlzocLVQQ+Anotxb?=
 =?us-ascii?Q?LEiBSIh8aovfXrgtfFXKPcgSPQ/7YFO+43/KU1zBnOHt595HymLP1Nl+GLUT?=
 =?us-ascii?Q?59v7pZvf/znt8/gtTQry2nDQ6Xm7VbtpI6aGXfvmRaqcMgKV8cZlI30LMZHX?=
 =?us-ascii?Q?HiNr/se3ZXig94KscGdn05QSGBlkXPGpKTf7JMQDDzComP4Hu/MJ90y0bEHR?=
 =?us-ascii?Q?KYxokhO2wNw9kVyFMgoW1ihWQNFGDIKGwzMvQQZmSdmDyu8DX/mIDFlbtYN0?=
 =?us-ascii?Q?oq+Xj/E1uaUgnVC1l3BQLSQdXm7Wo0czGXHIJWiHp12pJLEn5/E4KYW9oUUK?=
 =?us-ascii?Q?OwZEzrRR763tFd3uoArRGxiqMZuWK3vH8MldN9vvmUAoyYSJx8G61Z4Cks70?=
 =?us-ascii?Q?1Epuy7MJpcHPIjloy9I7/UmDXJG0uT7zcW+a7JGoetv7ao23HARySpkcN/JC?=
 =?us-ascii?Q?1lVFYy1Bzrwpn0Y+HVN4NjrHR3w3Cuzr1s4s1iiIppWii9jS1lEG3ccCovcR?=
 =?us-ascii?Q?Y4hZRc3ubziyl0I8zy2zsgBzN+VUspbkmT9zD5kj87UWhhemywl0abhFksD+?=
 =?us-ascii?Q?oCdM2DPOIrpCOVfaxHp4z3KBDWT/edI41fv7Pwz26uTS+Rd/4ql7vie0aT0t?=
 =?us-ascii?Q?FgyhyVHtSwVLjWqi8EM4V551EXmp7w0BBoZvM8RyoE/CUgNr1w8khkxfApAR?=
 =?us-ascii?Q?KMxofOwBjo/WxSnrMOasPJJKrC0PIaKpqsI5lyjsXnkCrhZ0osGfVPJACepi?=
 =?us-ascii?Q?Hq5Jo7TpMqp1AFsXBOjLpqNLajxvKAXah/yfDJ67N/ZbfBxpfvUdiouLUGqn?=
 =?us-ascii?Q?XaFFvzgYCmEzT+uobC0YdSX5GI1a2Pq0uH/u0a9IWAJ7zwoMLMIXBr8JbWub?=
 =?us-ascii?Q?Ght3iwPhwpTZ1sQfm4bgeJK9lqrVkss6/hZu7k+QjJj12euOEvD9e4DPPUCI?=
 =?us-ascii?Q?SnkXVWq9HXDdbVb2+SBYFlLulfVEB75+YUfiFTIw/ahGRwNDB/E2tmjScys6?=
 =?us-ascii?Q?JdGjL8W3597vvosxtqn7rNtGAgReg1Ov6Maf3ZWS5uTsIwKCKb8YQ8wtVo/t?=
 =?us-ascii?Q?6/KbmPhYcZiRzbN4kX24W8xoYyDpottgQgf77EGpdjniGJZ6EsEJ2I/cucSy?=
 =?us-ascii?Q?UIN5kSGvCI7V87bZmf+CdHJhQSmupGPmNB3Ehf3qIqpucIO6mfuuNO3aGQwY?=
 =?us-ascii?Q?ZDOQkfVLNte93MgpcUOzj0NYJLJLSyi33HTHeYqSQTZNuaGwuO62+nik4SH5?=
 =?us-ascii?Q?rwoEkb1Fm+gIjyqYNRmqfe6j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e97fc6ae-09ee-498b-1044-08d8e57978df
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 17:08:35.7152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gzx+4lyLIyD3i/COxgwIL3C+ottPk/8g+asUG3CXKe5M9BJIm6idfzYHjjBzrs9ORo9vfszvtPbLyoBv+khRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1864
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

KIQ ring is being operated by kfd as well as amdgpu.
KFD is using kiq lock, we should the same from amdgpu side
as well.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 1915b9b95106..892dc6b269fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -462,20 +462,25 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev)
 {
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
-	int i;
+	int i, r;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
+	spin_lock(&adev->gfx.kiq.ring_lock);
 	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
-					adev->gfx.num_compute_rings))
+					adev->gfx.num_compute_rings)) {
+		spin_unlock(&adev->gfx.kiq.ring_lock);
 		return -ENOMEM;
+	}
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++)
 		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.compute_ring[i],
 					   RESET_QUEUES, 0, 0);
+	r = amdgpu_ring_test_helper(kiq_ring);
+	spin_unlock(&adev->gfx.kiq.ring_lock);
 
-	return amdgpu_ring_test_helper(kiq_ring);
+	return r;
 }
 
 int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
@@ -518,12 +523,13 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev)
 
 	DRM_INFO("kiq ring mec %d pipe %d q %d\n", kiq_ring->me, kiq_ring->pipe,
 							kiq_ring->queue);
-
+	spin_lock(&adev->gfx.kiq.ring_lock);
 	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size *
 					adev->gfx.num_compute_rings +
 					kiq->pmf->set_resources_size);
 	if (r) {
 		DRM_ERROR("Failed to lock KIQ (%d).\n", r);
+		spin_unlock(&adev->gfx.kiq.ring_lock);
 		return r;
 	}
 
@@ -532,6 +538,7 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev)
 		kiq->pmf->kiq_map_queues(kiq_ring, &adev->gfx.compute_ring[i]);
 
 	r = amdgpu_ring_test_helper(kiq_ring);
+	spin_unlock(&adev->gfx.kiq.ring_lock);
 	if (r)
 		DRM_ERROR("KCQ enable failed\n");
 
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

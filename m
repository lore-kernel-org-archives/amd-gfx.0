Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD77C433E9
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 08:47:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A49966525D
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 08:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A49966525D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B664F89E41;
	Tue,  9 Mar 2021 08:47:19 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD19689E41
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 08:47:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKm9obpvUl9iVlUp2L6CpR+XDdiTAPgGmeql7iZNhtf06AG/UQxSn2TZU84kEVcoNhk20vnIMRo3fsALNXVVCoK7lxpCuBvd+Th6JpT3eSJwFVZq7JBZmS4OItSgdJOPRel9ew+iOIiPePIo65LrC01sE3gUfdCfmWVwoK/vWCEVjj0nbhlZ5Wq+3WT83CEYGW1GYW7N07GHOgovEkoA2msNYDKyqGA9NqNRZoRYZ/P3toovr96j+UQixY+nkPHnb+bFmUmPq1CtFKNwVeszERk4r6spJWTjdZVqhcApC31g6sZbEZhVRlWyT10RAy5Pu8H+JDAIo9bhEx10KllyZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTonkRCauU/75hqUkVADyYvatvorJZv6XWg3ktqcUOc=;
 b=mCEKV0qxh0aTkh4SzZAlQssj+ICVbDK5V+NXZbTw7bVzElGCyWs2K0feiHAz73wyOo7i6iAaS/Ie8MGFvUFc+p1mEPJXk3eIRRkAwCfRknIhgljn1l8y+X8akZt2Gqd7KFjZiJzSECQuuspetXK/Sf1vONZogDx1M89GeJka7x/Udw5aBq0U8SD2bkot07l3t+/LEXMTh20e+wP918zc6W/R8I66sTJvbbWpCPTy/yUn3S003H2074t+saSkmmHmAgORBgH52Qssbx34gqfbm9JhJRn3ekOjKcIslzYb74PHHP6LNmBXcYU6gS/WosMGphbJ7uTKySgtUgzK0uHzMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTonkRCauU/75hqUkVADyYvatvorJZv6XWg3ktqcUOc=;
 b=xr+d9/z7CB6sTycAmbgi8PoAXO0F4xyH04qFFe3CFgfVRSX/+5ms6VhQv3obW4Shy1jKr0fTjEH+XDOme7nYDBOx3iMFXgmQqkD3JT67WjTgFqCx2/HxW/k0vbN7NtQCh8Q7pMfR31l77OiOkiPOZIcOLp69v15ob46wbh3J2nA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1459.namprd12.prod.outlook.com (2603:10b6:405:e::8) by
 BN6PR12MB1377.namprd12.prod.outlook.com (2603:10b6:404:1c::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Tue, 9 Mar 2021 08:47:15 +0000
Received: from BN6PR12MB1459.namprd12.prod.outlook.com
 ([fe80::21cc:170a:9889:4460]) by BN6PR12MB1459.namprd12.prod.outlook.com
 ([fe80::21cc:170a:9889:4460%3]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 08:47:15 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 4/5] drm/amdgpu: use amdgpu_bo_create_user() for when possible
Date: Tue,  9 Mar 2021 09:46:58 +0100
Message-Id: <20210309084659.37649-4-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210309084659.37649-1-nirmoy.das@amd.com>
References: <20210309084659.37649-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.127.127]
X-ClientProxiedBy: AM9P193CA0028.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::33) To BN6PR12MB1459.namprd12.prod.outlook.com
 (2603:10b6:405:e::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.127.127) by
 AM9P193CA0028.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 08:47:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bef01a51-a2d7-4e08-c6ae-08d8e2d7f00a
X-MS-TrafficTypeDiagnostic: BN6PR12MB1377:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1377991222549604945B5D568B929@BN6PR12MB1377.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iYK3ybdv7V6rIImfquMI2bj1kNCl5yR5IXbI9+4FZ5Nn74JkBu1zPCrlGMmiTJm9yd6LnzcIGME74SJwB65qoMEWni/bwNd+PyIrWgoBgxov30bTkN4b+MQzT4+1Q0mAyK2MUgJsv1Gmg9OLab1/AfLAR5gCTS71RuW9XoppEO0tvt+K7IxSJO1lF4Kjmj1+kM74jP8ptHmFlH24PTMw8TDVyzt6j1XKdeyjZmTw2+1IOKE2W9Rm2tbxWzR+fLEIT53Qc3VX8Y5bUPa4VboRoOcxy3z+pwZj8jH393KvPiO+/a3UWZ8PYTE9HTUuoIJtbhil0wWSTRd/HxVzxuhyJQra3LhGQfEJmwkLMXAhaiEMKwlTNGt6Ll7rYwF1AJvyHS3wDQd2eN0pvHlSISBW+gir8aEAideLu0hDXjRdWxsWGnHSbQQlGni7l0SS00V7OqjgH4N7ZtEHR+4VqX6Q3mOKEa8cnO3NX3cGJX2QEQuuGBRYQ3InRQtS1y3Zod53Cft9IbYvDKfIi9c/vWpAAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1459.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(66946007)(6666004)(2906002)(83380400001)(316002)(4326008)(6506007)(36756003)(956004)(478600001)(8936002)(5660300002)(44832011)(37006003)(1076003)(52116002)(8676002)(6636002)(34206002)(66476007)(6486002)(66556008)(26005)(6512007)(186003)(86362001)(2616005)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4+lEyATLIou0DufPuaul3ijjTIqeR4B1iXxGhs0MPAzF4ojwhiTelBdI9Eix?=
 =?us-ascii?Q?hK/qHCBxemhpXso0Z+rNCcS0B1ZgBrz5YQcTQAfO90XVt48+mkiEvpz5ZRg1?=
 =?us-ascii?Q?9tc6llR3WaKqtXXEgVszBJNV1sR6L1iyUoUqesB+4sRubID4E0BsduqIudlw?=
 =?us-ascii?Q?e3lu4h+Vq0DGmUIDGOu/yQZwPRdUZKJbkI3cAzeQENJ53vvTUlnxh9hOgch8?=
 =?us-ascii?Q?TGUT5fi1a77FJzIWwGTyNQxIGJo+CEkPRI4bwFyk+Qfr7zD9WoOu+XKWnNRk?=
 =?us-ascii?Q?IxNCQ4wzTEV2BsfzNfsdML6BowepZhahZE7NGCF73fsiRtOJ5yAhEjs/PpEj?=
 =?us-ascii?Q?SSfebjnRz23Iv4zvcDiWM6Fe3CWjFTkgmX3kr48zqqITfIOFLssGwV4f33cv?=
 =?us-ascii?Q?y/Rx0vl2/MXMfuXcWkE/J3Q/qnJE+XrH5uraIZ8/FgxzhozKNy78EyUioLuz?=
 =?us-ascii?Q?++xjFTkbzkjYWqA7l18hpz6TIjm47uyYvaaswMxN9xgA8y/zy+ZZlE+z+EsG?=
 =?us-ascii?Q?i90unkEVFZnpRYASakxD8C4uPhHaDo8ELVUJsmqyxycec0UP53W9CEmZbB9J?=
 =?us-ascii?Q?Y4fGsko6k/ANlq4fY/L1tlTpU4Dg7iINHYiVTgTboiKdHcfQ99Q0MoD2Afta?=
 =?us-ascii?Q?Iw9tGJVhZk7oBjaNWk2rTvVJpdXHW+QvtRsZYH6Y3t3rjpsU6cmH8UeUVoJV?=
 =?us-ascii?Q?bepI7Yfz+WqqGUY3S4guQbjveMMg9QcD7Q6njMCxY6fL93szY8yydjK+LnkT?=
 =?us-ascii?Q?NH9nm7cCnEQDh+FWJOSd6ceEhaP2HeWleIWe1ikrFkFUljLUhx01UAqdV3xO?=
 =?us-ascii?Q?n2u0Okj22Xu+Od64SzWIImzfcSk7f51oInRdPB5LaUzPP/t+3RlNvdf+K4WR?=
 =?us-ascii?Q?1dKxtprgeA7mmZS/w8cZ99qMMTHJT+i9iKO0gsPNZ1R+pQAY2q0LzPoyeTuS?=
 =?us-ascii?Q?p1EPPxRa1UXkUYu0lzg27Z4yrvHXXp14ATdGzmP3Y1U/iqc5XFcbh5r7QR4b?=
 =?us-ascii?Q?tLVW9BCQkj0AFgO3nYAYN1/SyznzFClsk3inzpQqiHNe0FtAwb2fcnz9fju1?=
 =?us-ascii?Q?h0dyMrZ3NzMTCwovlyeUQoCgFm01N9WSp2W4NvOIKpkLbaxbYUk3qCES8Pe3?=
 =?us-ascii?Q?CimHYQ2M3UE4yYoVFzF+tdBr0npemHN8ZlevBxpIelz0lXIl4MJRO/ch16Oz?=
 =?us-ascii?Q?lkFGwZk+mFhY4OzmCLvA8nQX+dI13jwqCu8juE/YWdvuWv0rUImimpgz+0Be?=
 =?us-ascii?Q?fPIx+hQIFNmqC3W6Tm9/Qi3kRifIVN8gegITGz0NuX2prgs+ww/yMrVYmWpY?=
 =?us-ascii?Q?5eQMk3VS6muhd3dJb600JXR2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef01a51-a2d7-4e08-c6ae-08d8e2d7f00a
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1459.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 08:47:14.9157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gh7OER2Atfx2AjjGX38Xh5njkt+sJG53gMkz0WEVkKMxf3SAP4fZVeZJu8Xe5brqcWGPS/IU9Aw3TlKjLZWZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1377
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
Cc: felix.kuehling@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use amdgpu_bo_create_user() for all the BO allocations for
ttm_bo_type_device type.

v2: include amdgpu_amdkfd_alloc_gws() as well it calls amdgpu_bo_create()
    for  ttm_bo_type_device

CC: felix.kuehling@amd.com
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 2151fcb1e19d..de6b3ca64b45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -317,6 +317,7 @@ int amdgpu_amdkfd_alloc_gws(struct kgd_dev *kgd, size_t size,
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
 	struct amdgpu_bo *bo = NULL;
+	struct amdgpu_bo_user *ubo;
 	struct amdgpu_bo_param bp;
 	int r;

@@ -329,13 +330,14 @@ int amdgpu_amdkfd_alloc_gws(struct kgd_dev *kgd, size_t size,
 	bp.resv = NULL;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);

-	r = amdgpu_bo_create(adev, &bp, &bo);
+	r = amdgpu_bo_create_user(adev, &bp, &ubo);
 	if (r) {
 		dev_err(adev->dev,
 			"failed to allocate gws BO for amdkfd (%d)\n", r);
 		return r;
 	}

+	bo = &ubo->bo;
 	*mem_obj = bo;
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index bca260d56f76..311bcdc59eda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -58,6 +58,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 			     struct drm_gem_object **obj)
 {
 	struct amdgpu_bo *bo;
+	struct amdgpu_bo_user *ubo;
 	struct amdgpu_bo_param bp;
 	int r;

@@ -73,10 +74,11 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 	bp.domain = initial_domain;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);

-	r = amdgpu_bo_create(adev, &bp, &bo);
+	r = amdgpu_bo_create_user(adev, &bp, &ubo);
 	if (r)
 		return r;

+	bo = &ubo->bo;
 	*obj = &bo->tbo.base;
 	(*obj)->funcs = &amdgpu_gem_object_funcs;

--
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

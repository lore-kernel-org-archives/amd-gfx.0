Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E29BC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 07:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF59864F97
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 07:47:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF59864F97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FEFC6E4CF;
	Wed, 17 Mar 2021 07:47:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 626956E4CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 07:47:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTc4gheJ/hwNk6USdqzppB6AKXegM/ljxt1Abx0JWnkHWGGvKhgFuVlIOF+eO6Qync7PcKT0jchb1BL6G8Mc9+NgN9gnGsIT8EGgT+JBXOKf/n5a+4XNZiZGK44wnSnjr1ftwbWbMcsyAZ0v6SfoBoJVpnLwEha5cMIiVqR5H/ao7ryDtABMKTFVIwKwfmkfgeqnhplO/W+PqOQhs6LI2CS/TI+32ltOYWtE6uaPpdDOgxC/xe6YcMEG4Chwi/w6cn91QVEgArJRCZygs4UmP/xOD28kcNshAvQbGMI4RVnKvPnMw8Zg2Hvb+svCaWhgVM3F/i6n5yTvwOMmw0ysPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRDr2oy3pwVgtzFNy4XnzoHPmEpnobqu/VYK54hsLvo=;
 b=E0qaU2OLhY3QXiGwYdl0R/9jJlBrZTkwPKK9+z38FF7d2MOW5TYsGg2oCaJdU70zPiJSQ8F4BYrkMchvFjzqS8iUEPVyasXKR9iM9nMckO+PwMvBl2z+So8nkayYblSx9w/wb+EAXMt5uytmBhaEd9exhqGFaPkiL8UHuRCtnc9Zz8BKNxDbmnuBDUUzQ16v6D7qVTXtjIuBqToxCok8G9sgxkF1Qa4dpyEv8fur6HxrdtPZDc87vBa1pWBILTQ75vezbs+g1/jmHrZqMkglg2ODat3/63M+B+cJBm8Mqctmg0V/HVIlhqiHmB3GKbN6lUJmuihFO6S5HvnUTHLdwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRDr2oy3pwVgtzFNy4XnzoHPmEpnobqu/VYK54hsLvo=;
 b=Q1K1meuRcmqmPg3bUZbH1rguetDAukpwi/jXv15R5IVzVFoHiy+Ii4m06YNuB8Pe4pxf2ei8qsOzV6/vnmd1BwATFBsdEPF9v0EVbPxuvWjmqrVZdPT9B5qbjp5lSa7OpAaiVbWrNud3N3gxsITqF+ygGTs/eMsZKpNQU/IArtI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1847.namprd12.prod.outlook.com (2603:10b6:903:11c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 07:47:30 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 07:47:30 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 2/4] drm/amdgpu: use amdgpu_bo_create_dmabuf()
Date: Wed, 17 Mar 2021 08:47:14 +0100
Message-Id: <20210317074716.5547-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210317074716.5547-1-nirmoy.das@amd.com>
References: <20210317074716.5547-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.96.184]
X-ClientProxiedBy: FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::24) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.96.184) by
 FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.10 via Frontend Transport; Wed, 17 Mar 2021 07:47:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ec0bb081-a9c1-4f65-e8e7-08d8e918eae9
X-MS-TrafficTypeDiagnostic: CY4PR12MB1847:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB18476C787A0D859DADB184D98B6A9@CY4PR12MB1847.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IwDfDHPRVUvTrZv3W9CKXksB5Qjv75h1kDhCeAVNRcexZId7pt1MPvvw8LaJysG3evtPWyFXPjH0zv3wy6HY1PsXALCapE2FWjthtu9n/2Drmz5A9YBecn17zrRAH9IAmQU/qfnmI4gpw2gIR+KWLFlHB2+0F99puTq1WhCUBSuNfoDy66+0H3D+kc8Go4T44pOxy0ei7MgoZTiyJ9oKTMWnDjfxScktT7ofByL/aIrsgSb9g15V8mRG9W4UvMoJfxilkdkUd4jQ367HHWm6bb+7OMrvLsWOgQw3O9oJUIito8QosFQwFfVRUqUNC986aurdsU9qcifcaJmnK1m1eKeVCc5Q2b3kd4lzTXj3DJ8ZeBEGTZdqBRXUKPqndjEq+KcvRYvAqZalQJ0rvPfs2miKzWtUVWoAa8EhYC3dctOSiCcYJKQZFK1nLaY0rJzRWw6i40pDiOfCX6RSfQnN1tKZJZth2/wYzl0+ds/xpsTVj7phSyq+vOiHKOnPjDWsTla9nBpFo28pXycNcZLCADQr41hSlyqhXTX1605MYMpGv+1tgkEo31gCOlv0EEnS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(37006003)(316002)(1076003)(8936002)(66556008)(52116002)(478600001)(6506007)(34206002)(36756003)(4326008)(6636002)(6512007)(5660300002)(2616005)(6486002)(86362001)(66946007)(6666004)(186003)(16526019)(8676002)(26005)(2906002)(44832011)(956004)(66476007)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?h9AHQvDXz9vxdvP8oxB+yiaJqD+1W9lJvOtIwjcow2ircxBBRRnptfYifoGX?=
 =?us-ascii?Q?ErO0L5b1ibW5VbKraQgaiYg+xz9+XYdrLco86CtSokvosMCGhOeVW1+uXJpD?=
 =?us-ascii?Q?lCbtAfbI+XK/gzXAolmhWRGsgD96aR1xq5obpYgq2PnZxBhWAjBrpaObW37k?=
 =?us-ascii?Q?70vin8hn/dbIzNkeM2L5Fvj6U0rW4mW2K4dxdZBqv0wSHHCIaAgWyphgKeep?=
 =?us-ascii?Q?AXgTM+Js/gKzDOZYKOnf3YNVrHhJ9lNWlzTYx2VoB36WbB+mS2xdQaCKFc3P?=
 =?us-ascii?Q?qUno5sC824LOcCWZdqAVn7HSK6U8pdjOXCO7vmwVihLkvdMUQRwudHiVAT0c?=
 =?us-ascii?Q?1Q7eay+JcXWWkxlJySV9Zi/T5dUracT7UDI+/FQRIEA0erj4w2E4cvGRZ8J1?=
 =?us-ascii?Q?MbTdlkg5PDLuNaoP69keR9XD44ia8XEgNb88jMePUgeGa/k9P1poUKjOWQ7W?=
 =?us-ascii?Q?9WQ1L8jukx65gCEqJ9zLb8nn4yeJVUonw9cX8VT2ColMymaXOZoffTSkb2Mj?=
 =?us-ascii?Q?0p2DQ/nPwJf1Z08sM+XaXQJZVXKgWe620SHNTGBeFeZVS0aOh8BILGNrwMHJ?=
 =?us-ascii?Q?+si5CYsGLZZiMYGp4M31x4C0suQnUJRMsJlYRew5/qw/+/jiziIHF3f13dpv?=
 =?us-ascii?Q?kUHguw61O6VxlXvE0bSuPZqfwyavNi9dfyp48lGZGyLWRJvxcdfB3NaoegiY?=
 =?us-ascii?Q?NA9bLgoTV8n93+oxKEoxqR3rRdQs9AY/75CDESFA7W2yknLiEgBdqWyjbDCx?=
 =?us-ascii?Q?T5B2S1IHYbzxSGZLMn0EbpvIfh76klANC8RtoVdhvEUgkub2Hrqg1rupWrPB?=
 =?us-ascii?Q?7yGjWCRQRwvh0sIKYypDcdvUDCUmJqVgIVv61Dz/bIsxpVNFuQxnGlPSnBpE?=
 =?us-ascii?Q?yA38PLj16nBjAMOr+HNsPeLKmtHbtBNpZV7XDMRqiY6+U7lEyC4gsSlHRIt4?=
 =?us-ascii?Q?vG1ExeKUAbkMWIlnqDWRw5DpzF8WPijxAjaBlzUR+MFyZj5hs4qCAZhCLikp?=
 =?us-ascii?Q?qkzYlIryjW+pGLeXFFbrXfF0I5NJZjiQczinw2IlgaGcTTLceUVB0rBeG79v?=
 =?us-ascii?Q?Pf4VV5eKL1PvgQlrOPSdr4J2ivOAdfsZhafFdyB365Sry0m3yUDVSTbycGL/?=
 =?us-ascii?Q?qvbouPxw3A7GuCJHTFAYHwuzr+EWQFvLvx/VEiAZI1gUkEO6t9wPpeucaxq4?=
 =?us-ascii?Q?UY0+Caexb/1aN/kz4oxHK8vYBUIX58dvM7fmc6e8w2m0pz8lq0ciH0d87by2?=
 =?us-ascii?Q?LqhTjfqp06VcsQ3AH53IQKNZt3IVRmZ3jX6YXoJuuIvYmHKc8X/G7QPnSZoz?=
 =?us-ascii?Q?yTaI1coM3B9i8dvuwUjyImlk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0bb081-a9c1-4f65-e8e7-08d8e918eae9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 07:47:30.6258 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vkkHfkhKjf6LOG+aB1nUUUkHAmCx75SKOJKbCUOhDKxPsEAqnoKQnpCxT7BtNbydQJPmS/NfmjNkTmnt09fYDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1847
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

Modify amdgpu_gem_object_create() to allocate
amdgpu_bo_dmabuf BO for ttm_bo_type_sg.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 311bcdc59eda..5366a806be2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -59,6 +59,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 {
 	struct amdgpu_bo *bo;
 	struct amdgpu_bo_user *ubo;
+	struct amdgpu_bo_dmabuf *dbo;
 	struct amdgpu_bo_param bp;
 	int r;
 
@@ -74,11 +75,18 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 	bp.domain = initial_domain;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
 
-	r = amdgpu_bo_create_user(adev, &bp, &ubo);
+	if (type != ttm_bo_type_sg)
+		r = amdgpu_bo_create_user(adev, &bp, &ubo);
+	else
+		r = amdgpu_bo_create_dmabuf(adev, &bp, &dbo);
 	if (r)
 		return r;
 
-	bo = &ubo->bo;
+	if (type != ttm_bo_type_sg)
+		bo = &ubo->bo;
+	else
+		bo = &dbo->bo;
+
 	*obj = &bo->tbo.base;
 	(*obj)->funcs = &amdgpu_gem_object_funcs;
 
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCC2C2D0CE
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 03:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1208224655
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 03:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h/lbyPbF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1208224655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EC776E228;
	Wed, 22 Jan 2020 03:09:49 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760077.outbound.protection.outlook.com [40.107.76.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA2766E228
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 03:09:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIU4dwLOQ645ZCyScTkbZ/NycqgVK8U7gueK0mOSJQkghKAu2s+38ERtnxEfpYFJ2DV9CUF8xPYjfxxfYNdg/MsqZv6k2YrugQOvAmVjsH2WG+pkn9MRjHzmTbV++gjgzopSD1V9hNoLItVsA1fYM8PAL+OImCJEjpczlUSJWVkq1zl/Ltm61OxuCiGZpnRwaeP0m6NJGiepk+Kjy+trj5MUns1mM1csnzVFWSvek/wVMduGwUK3dpFFjaeAJTRrXK81abwFZeAKrSpK0TCRb7rurlL/P8QgmLbSi+9snVy26A6I9pbKwpTsrsJvdNytJsl9m98mVrIe6WpIQo18Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKldG4Yut12tR2cjZx5SDh6amWLUMXGfDuWlClUaViE=;
 b=CpOtDtNthDhQckPJTz34rVEqejPwY8cVnGMqBXYx04svqDzMbhxO/o6JFzJIDOj8ClUIf67BLBxZahROn96sIEXBNN0ABf0726BbLbHtar8XU+cUvq5oG9yjFlgLvkIhNscf0T2RZ8SxF9orJsaiiSSJ6kGfYjNB4XzTpAD6wJsgryDXxllAUHwVLiEItlK/SGyzjXOIz+g3pCKUrZWwWz0tZVr0k61yxhdsa2rdzHSu4hamdF3jLdbLE97Va7Y6IbTl7wG4a3+yQ37cGgyxgHFa75YjMn3twR2lmBmjzMPy/qsVIv86/IVFnYAaeMxP9Sk4xlkA3g4bjM3bFo1yUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKldG4Yut12tR2cjZx5SDh6amWLUMXGfDuWlClUaViE=;
 b=h/lbyPbFogac3yAiQRYmx/EnjF4NBkbvmB5KHfBF854CAudhg327b6SjWIj1GS3wmfhOZHeVdgXSLfgo/Rb+pOgSLtIvOyHCGmVuS6JErQR2jhxeF3S5/PSrsICdwhwAn/d4ZxIUc5T8iuCoQwbutehT4K+JSpTeIlN7IHMO6sw=
Received: from SN6PR12MB2800.namprd12.prod.outlook.com (52.135.101.138) by
 SN6PR12MB2624.namprd12.prod.outlook.com (52.135.103.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Wed, 22 Jan 2020 03:09:46 +0000
Received: from SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::a0d7:f7a5:5d2d:752b]) by SN6PR12MB2800.namprd12.prod.outlook.com
 ([fe80::a0d7:f7a5:5d2d:752b%6]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 03:09:45 +0000
From: "Pan, Xinhui" <Xinhui.Pan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: initialize bo_va_list when add gws to process
Thread-Topic: [PATCH] drm/amdgpu: initialize bo_va_list when add gws to process
Thread-Index: AdXQ0VelFRbHEHdaTxecPuaSY75YQQ==
Date: Wed, 22 Jan 2020 03:09:45 +0000
Message-ID: <SN6PR12MB2800374EE3DA1CBC3C618894870C0@SN6PR12MB2800.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=19101593-1859-480f-8428-000025ba5841;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-01-22T03:09:00Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Xinhui.Pan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9101020d-27c1-46aa-a049-08d79ee88899
x-ms-traffictypediagnostic: SN6PR12MB2624:|SN6PR12MB2624:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB26245FAF4558BDF8EF057CE5870C0@SN6PR12MB2624.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:298;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(136003)(396003)(366004)(346002)(189003)(199004)(54906003)(81156014)(64756008)(316002)(4326008)(66446008)(81166006)(6916009)(6506007)(76116006)(66476007)(8936002)(66556008)(2906002)(186003)(26005)(66946007)(478600001)(52536014)(33656002)(9686003)(55016002)(86362001)(71200400001)(4744005)(8676002)(7696005)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2624;
 H:SN6PR12MB2800.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C+07JaH087l3QzrMC5kQApmZP86oLzOJpU17sptQVCBmlvuE0M4ptVfsLSkf/bMm660E3ogaAfDpDsHktRVGySyRIKFPXrCGTo9xpCPfU54F+V28jvS5d+DG5tXkANhizlSLiNkUWX6GT0Z5WGsralJBDl1BJoeltAPPbAtrfhBZpUh9JJ0/cJn17GV5FQk7TdYD+ZIJOS6JQD3jmlXHuT6JojAuNsdxExpwuzh1cX43sJBSPZv5SAE+vPTYktnhCjfGvN50JG/B/JPqq+vqd58dIKJ0Go3iYi1aLNDxL9NKJbsvAz457hBryMpg1v0DnGjn9p3XpLTHVej0D8dZuZmc6PFNW+xQc4/8K+GzifMMnIcJr1DPzhmKJacL9yeodqtNOayv9zdsVLnqT4WkZVKvMcX0YYA9j4+KZLYC9SR6rdjEdMNDgGEDat+h196f
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9101020d-27c1-46aa-a049-08d79ee88899
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 03:09:45.6317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fw9yd8W7LLZ641ljcg6snI7fPKz3Sw8f4TfWgZgIjZ5KL24+kfyw0mceQLMmrNib
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2624
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zeng,
 Oak" <Oak.Zeng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


bo_va_list is list_head, so initialize it.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 9e7889c28f3e..ef721cb65868 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2126,6 +2126,7 @@ int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem
 		return -ENOMEM;
 
 	mutex_init(&(*mem)->lock);
+	INIT_LIST_HEAD(&(*mem)->bo_va_list);
 	(*mem)->bo = amdgpu_bo_ref(gws_bo);
 	(*mem)->domain = AMDGPU_GEM_DOMAIN_GWS;
 	(*mem)->process_info = process_info;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

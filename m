Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1195DC43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 11:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDA0B2073B
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 11:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CkuLnSQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA0B2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76F5F6E0BC;
	Fri,  3 Apr 2020 11:02:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A50D96E0BC
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 11:02:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwjoSNcitqA0+ZdG357zpFF2HqTd3JOBa9ywZhzxxa+v47o2VmSc4ipdRb8vHCFYrtYWVZx8aoiViJBgeVYOtI1ZvVgAm96yMEryask0i1zRidzPkTmnFz8AyPN1bhrpRcCvKSxlXQekSZk0d2YMiHm7dOMUC8OWwfu8OWqHrTyhLOxnOsq0khDn/hA3JISUrSEjjjbYxert8g1TP+MUIyTnGZXB+hu8euRc3p5b4bLdEF3OwZZ9qtmT9qA1DrVv+zHhWx+l0toOduI+uCK5QCLaaGzM7/6hHVAvdi05MYkQoomm1d6XBliKBQ400V0FP53A9SR5FA5ACtu6pne6uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l76pbzLog6eavyTjN84p0xxIxAO1cWE9zdbZKHUg4a8=;
 b=Kr+ysQOyB2s6NwELlcE1xWA8aTJChH63zdRmPZJaMl+HHtD2+EcG4jfwmo+a3lxH3nR64UOiD5bhUNdT0xlkdAAweWBl6iDjd0VuqDMuK6UPD/i6cTB3bArnh/IG09nw9MTV2CT6aAJNT+C6vBlgXHSqk2DqnaNdHLhLHGML3ypjN9+Y6mpbGiH0N+z/AFfSZCAQwFrr4pviyCxE3k6q4EwIlWKTt81TsAbioX0HytlhSOQoZkZ0pEyXRlnVLrfCmuRw6T+sAI1TdeBmIrsFw4hXJH5o3yvKUEbzpJHB3Ys9lF5a/9ZOa0tJVrgOWPNWjDprmChVaQed1O5UzIRVpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l76pbzLog6eavyTjN84p0xxIxAO1cWE9zdbZKHUg4a8=;
 b=CkuLnSQKwbFr8Tyf0sH9aiIW94kzti9Grz4sNI9KiaiYQLaF5udGViMvIKklxcEZjh8OeiYjcQWENoqMcQcZjIVP81WQ/IxWpCN6WuFZJAbbdc0HAEL+wfKrFNqgO75An6BrnI9ZYfkbPcsvK1cighisnITaQ9/9RertURg00D4=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Fri, 3 Apr 2020 11:02:41 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2878.014; Fri, 3 Apr 2020
 11:02:41 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Gao, Likun" <Likun.Gao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: change SH MEM alignment mode for gfx10
Thread-Topic: [PATCH] drm/amdgpu: change SH MEM alignment mode for gfx10
Thread-Index: AQHWCaGNLoDUJjzDF0+0yN0di45zM6hnO09Q
Date: Fri, 3 Apr 2020 11:02:40 +0000
Message-ID: <DM6PR12MB40757560136B184CC13EB4F2FCC70@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <1585909202-1350-1-git-send-email-likun.gao@amd.com>
In-Reply-To: <1585909202-1350-1-git-send-email-likun.gao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-03T11:02:38Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=5b447c88-e69b-4536-b4cb-000011cc0f72;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-03T11:02:38Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: ae799984-43a2-4a2b-8a14-0000fb409e4f
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b13c2455-82eb-4653-081c-08d7d7be876b
x-ms-traffictypediagnostic: DM6PR12MB4340:|DM6PR12MB4340:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4340E3352438F6C4AACD93D4FCC70@DM6PR12MB4340.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(33656002)(9686003)(8676002)(8936002)(66946007)(76116006)(55016002)(66556008)(66446008)(64756008)(81166006)(66476007)(71200400001)(81156014)(2906002)(186003)(110136005)(5660300002)(86362001)(478600001)(316002)(52536014)(6506007)(53546011)(7696005)(26005);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0YbqTbDIRdTvxgfMhNf2esGbPqC1Zd9C2MJKkHN6023M+c2fZUyASH6l07dZjkC3MDGLuvYF9erCbXNwxj6XF9xJVZ6XFdkmvPQJbeYxPJapWarF7CCNUF3ns4mw8irZJUKrD+GiHNNaG/hQ6D1MNhe77ZFwYrW+pXhxjn+JT4kTMyDRkcfVG4FutyhVFHOwMiJIvZ0TRcmOfv2xu4Ae7/l67ZLiA9L/YBc+6bjY6ViEgzFFt5HYTLstjgWcZBO/8igylLCQDC6sG6RMvT0evU6fNjHf+MrK2r9IRjJSP8OdyV++ZAx74IgPNMYAScE1tAl/pMsAh+r/0QZJeVk69UfY2tHYibhjm7bgaZfC0H8Ww91xWXqJ2EMGCGzD5qKbtpcp+DvM1UZHSg4ayLEP0yjhFcbP3/ypFWKD4HKEYd7/8TSpiwS4M1mzOghd5NN0
x-ms-exchange-antispam-messagedata: rsJywU1qJwbz/0WWwAz0taUKEdL/8zDty3jj9SPfE+TnUiz3StVIrl5sHJtAbVRpUuLrUOqHprr0c50IvEV5LLPsmQy9BrBh+7XTK9ahIgOmh9GMk5YFNC5I8MorNxWxV510DyTcjHfS4g1o25axbA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13c2455-82eb-4653-081c-08d7d7be876b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 11:02:40.9481 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tfnJM0RbUPsllxv3SeDJuP/4BNpZGBsnZnyHrKs1eqcAfbk4AXuCVX9Ptulq71WojQXA+ysmvWGmln+S4A63lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Gao, Likun <Likun.Gao@amd.com> 
Sent: Friday, April 3, 2020 18:20
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Gao, Likun <Likun.Gao@amd.com>
Subject: [PATCH] drm/amdgpu: change SH MEM alignment mode for gfx10

From: Likun Gao <Likun.Gao@amd.com>

Change SH_MEM_CONFIG Alignment mode to Automatic, as:
1)OGL fn_amd_compute_shader will failed with unaligned mode.
2)The default alignment mode was defined to automatic on gfx10 specification.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 5a67306..d8f0c0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -279,7 +279,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_1_2_nv12[] =
 
 #define DEFAULT_SH_MEM_CONFIG \
 	((SH_MEM_ADDRESS_MODE_64 << SH_MEM_CONFIG__ADDRESS_MODE__SHIFT) | \
-	 (SH_MEM_ALIGNMENT_MODE_UNALIGNED << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
+	 (SH_MEM_ALIGNMENT_MODE_DWORD << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) 
+| \
 	 (SH_MEM_RETRY_MODE_ALL << SH_MEM_CONFIG__RETRY_MODE__SHIFT) | \
 	 (3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT))
 
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

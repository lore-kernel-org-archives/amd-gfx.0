Return-Path: <SRS0=W5zw=6C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B2FC2BA19
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Apr 2020 04:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4210E2076D
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Apr 2020 04:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IYy6B90x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4210E2076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CD846EC5F;
	Sat, 18 Apr 2020 04:06:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 800B36EC5F
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Apr 2020 04:06:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVQLoppXyJHpk50+2jd2/krqJnIM8X/8TTHRufbWO3QwtOXLWAZdtLMqMik+EkovlxFN+40+kKZSky+Hvfxat9HzS2AP0qdZcuQGFJb+Jn8YkvIM6aZNJrrvb1n5HWLhdgztybIpOWUuFW09uzqytIb3JHscitpP07T/mxPujs4C16ojjnwfOfb1PI2v3kob8frnIJoxl3aegc1AaM6Bb+vJyKvDHNZ+ym9IZHRztz2EOHfCHmtAWKKOJEFvkyjSnyMIjorBfrRYJ+Lp/umwp+cck6iCVBnfAzhFTjVdC2PLpJFcoaSX9Oi7R/QoSJRPj6m7Nr5wrwQgYoxG2mFKYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwY8QRLYcmhVDSAqJ/xqQDHYX+rV6oqr+TnzTqA9K7o=;
 b=Ksoi1m5kyNWD9Xlr+mHLn871whMUvhtHVcgWV/qShPnpym17lFXr+38ENo14hfiT7m3ma0mP5DZKYI/6xSdsBT3jW/ZJ23EFTbteyCWFMQe7vW7Hu/cR6ugRRsd9w14WiYEvY0s8UNt/HnQ8m3wpGzylpDEiPRp6Bf3LumwuzTWSEz85mMrwvrAhIV+tMQZ7xqDXLbPPkgWz6NwFvYpLSlT/TWnAszf2bpMxKRWPfsWHnUzXI808iOMvMdCwbyALUN56dBZiTbUvuWWjJoA+RYejY9Ler1jPTRRk7xV99cf8uHiPonfIr67G7GENLZYeM6iyNidFBofUOA/KfkPGog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwY8QRLYcmhVDSAqJ/xqQDHYX+rV6oqr+TnzTqA9K7o=;
 b=IYy6B90xyktfYxibYwf6ZqPv/q2QT4Dupk+d+/RhlZoXOQxat4clrGyf8ZAZsya+fXARe/NuZbAygkm50OdOJirg6MQytIkQIiktS9kwEZ2qOAHTQsydkKCGA0zKwiK92pvN0JAZrzSjspxgpRuI//gG7pQ/U8HDKhsnW0P+wO4=
Received: from MN2PR12MB2880.namprd12.prod.outlook.com (2603:10b6:208:106::21)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Sat, 18 Apr
 2020 04:06:08 +0000
Received: from MN2PR12MB2880.namprd12.prod.outlook.com
 ([fe80::29e6:fe28:80a7:8bf8]) by MN2PR12MB2880.namprd12.prod.outlook.com
 ([fe80::29e6:fe28:80a7:8bf8%7]) with mapi id 15.20.2900.030; Sat, 18 Apr 2020
 04:06:08 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Zhao, Yong" <Yong.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Print CU information by default during
 initialization
Thread-Topic: [PATCH] drm/amdgpu: Print CU information by default during
 initialization
Thread-Index: AQHWFQGyWJ1muy1p2kaLE8jfA0ebNKh+QxdA
Date: Sat, 18 Apr 2020 04:06:08 +0000
Message-ID: <MN2PR12MB2880506AF7EF7DB47545E895EDD60@MN2PR12MB2880.namprd12.prod.outlook.com>
References: <20200417214624.20047-1-Yong.Zhao@amd.com>
In-Reply-To: <20200417214624.20047-1-Yong.Zhao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-18T04:06:05Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=fb5bd4c8-8f75-4e79-9290-00000d468f7a;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-18T04:06:05Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: bb121235-ba71-40ab-8cdf-00002ce9137c
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Dennis.Li@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4401067e-f14c-49e9-e7c2-08d7e34dd2db
x-ms-traffictypediagnostic: MN2PR12MB4222:|MN2PR12MB4222:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4222B392BAB1A5597EA5BAC5EDD60@MN2PR12MB4222.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-forefront-prvs: 0377802854
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2880.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(66556008)(8936002)(64756008)(66946007)(5660300002)(66446008)(8676002)(66476007)(52536014)(478600001)(76116006)(81156014)(55016002)(45080400002)(2906002)(966005)(33656002)(71200400001)(26005)(316002)(7696005)(86362001)(53546011)(6506007)(9686003)(186003)(110136005)(4326008);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w6XZCk5xAngPbvBcFLc9TkW6PFm4PO0ODuLvoi1FoZ7Lsw0IM2O166OM9RNVOd7oFTSZiO+BhuY3EeipB06z45EjvhPXJlS9QJ6CuuIBUhYEtNwqISZMcX35ibnWQ67o+cvECWFW7j9F/jKa8bb/QLSA6Ht9QoldLBeWCUGHgLhfjz+zOMgVQyUzdzaziuqAkNTctTqlHplm4jPpk7pcQrU5ifQou+QQ31tcG/6DySrnaYb9pwkkbPhD27cLi2+bA/1F6uKckzZVmj0qX/t0b+Y0dico6onDs/WFGKvXpgOGUmPlV654P+uv5jjPEAZG1Aw6WAt0kGQXXh1y++41oKXgitYOTP3HFljxnO0Xa3iBhOUSNNAvi6wceTxSCviHkvpLYn0EdNGdxUBB/5NYhGFb08J2TtzWsn9VL7ZwIENfBRz0xrgYDDQkmbhLf9uUuuBVOfrMUQf50VkxSvDal/HvXQnYwQawSoR1L67xSdM=
x-ms-exchange-antispam-messagedata: +6Z1pUtgHKHHpaUtFNyMU8POkjL26PtV6tyWIekP8QjlQLEgdt6EJGpQrEKVBQXWsxM7JWxhk6ACK6GgrceqfWFNe/s30jltVYCksizt0iibnoFRch/SiXe8z7wKwDvVX/6TZrP85KNKrRRjmNDZPA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4401067e-f14c-49e9-e7c2-08d7e34dd2db
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2020 04:06:08.3459 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lU8y0J9yeKMy1ZX9D5rErBtl0YiLnfzFKzX8FobuJm3jxzmWJMzL+sjofj+LvjKh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
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
Cc: "Zhao, Yong" <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Dennis Li <Dennis.Li@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yong Zhao
Sent: Saturday, April 18, 2020 5:46 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhao, Yong <Yong.Zhao@amd.com>
Subject: [PATCH] drm/amdgpu: Print CU information by default during initialization

This is convenient for multiple teams to obtain the information. Also, add device info by using dev_info().

Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 71ea56e220ae..423eed223aa5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3170,7 +3170,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		goto failed;
 	}
 
-	DRM_DEBUG("SE %d, SH per SE %d, CU per SH %d, active_cu_number %d\n",
+	dev_info(adev->dev,
+		"SE %d, SH per SE %d, CU per SH %d, active_cu_number %d\n",
 			adev->gfx.config.max_shader_engines,
 			adev->gfx.config.max_sh_per_se,
 			adev->gfx.config.max_cu_per_sh,
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CDennis.Li%40amd.com%7Cc78222da1054497bf05a08d7e318d379%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637227568077825376&amp;sdata=mC5ZAGmsbikJqKaOcJFR%2FF%2FxZK6PYIC5908DAGXCRTk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=2dg2=2U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533AFC2D0C2
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2019 10:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A3F0206E4
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2019 10:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TAh8r8yQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3F0206E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAFF7897F0;
	Mon, 30 Dec 2019 10:51:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 084C9897F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Dec 2019 10:51:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYQ075M3aXKehpjfF5kAKpuIQ+UsmPFvQi0rf4vpMVIiIMDk1UfnFKiB4bOha6SaBAmc64nEon8yt71E3CfJ4s+uDgIAvHIXHedppGPKseu6ZOxN/AICISE5BKUBP4VOt/t/gt6AjXNZadFxhzKaiYEt6VnFB8Ygd5I/NR9EiPAnq7+o/p3o6IrabIx5Fp+eB/n/ZNfVzpMgehSvDYSfPo0rejVgeRdauVwJTblar7P0HUm3SpTv2BeuW4kl7rPNHQBykhpZsB6j6sGPNK3XwYvPCBSPGbda6CwSSbyNAbg9nCREL4mUMtLD0MWOsD2KbE06zzNIlTyq7u4d1E+Gbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6MuQ/iZ0hhDjq7PK32C9not2ez9l3zKJjq3s5syicc=;
 b=QQyUTUuRlzfMSSCeeIIAfr/NnCiLdlC1XgdxXO9HhiSNu+lRp3ao58wJ7EiTb9kOZodmHrJMXqeIdp9BxulwiZhTBNCUx3d8GugKMm4fOqcg+JUmnQcRcOn8Z1//2d+eN4C80UoU+VUiBa9H94bkmPUv4fi04vHnujYP/NPp7LD2mVREUkqsToa4hNHYnKqVoHk8vHXwiv7SQsUkwlPjWbk6bTT6JqpSen4Mn4nLFvp+FKCA5NnztaY4Nu7gy0Ipee95uOq8Eu5dEc91ZLNQ6HJN0/IkmYbanj7/S33MBxITLuA3D+lC7j3oHFM5HP1Z7odwD77+ICuqz/9MRdyl3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6MuQ/iZ0hhDjq7PK32C9not2ez9l3zKJjq3s5syicc=;
 b=TAh8r8yQ0iRm1pbOhTp5DIPWQsHDXtu7Tw2wp3z/wAy7nzUveMBqJyEYUy8QLrcQRziLjk92s+X0iNfsFacGQx0neLvEnaS1PUb+wZSel1xtOoxXaSbJ6PE+9ri4wPZZLn3jg4/XDV00rN6DE2uOOt9MinslmSGfcawrWbTEwe8=
Received: from CH2PR12MB3767.namprd12.prod.outlook.com (52.132.244.213) by
 CH2PR12MB4151.namprd12.prod.outlook.com (20.180.16.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Mon, 30 Dec 2019 10:51:38 +0000
Received: from CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::4881:e645:b5d:421]) by CH2PR12MB3767.namprd12.prod.outlook.com
 ([fe80::4881:e645:b5d:421%5]) with mapi id 15.20.2581.007; Mon, 30 Dec 2019
 10:51:38 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/powerplay: avoid deadlock on Vega20 swSMU routine
Thread-Topic: [PATCH] drm/amd/powerplay: avoid deadlock on Vega20 swSMU routine
Thread-Index: AQHVvv2Yd7+wKIJQuEWrdezxIKtjK6fSgCWQ
Date: Mon, 30 Dec 2019 10:51:37 +0000
Message-ID: <CH2PR12MB3767216F586B337F88842114FE270@CH2PR12MB3767.namprd12.prod.outlook.com>
References: <20191230104013.28093-1-evan.quan@amd.com>
In-Reply-To: <20191230104013.28093-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Feifei.Xu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8138dd3-59d5-45c6-a1bc-08d78d163eef
x-ms-traffictypediagnostic: CH2PR12MB4151:|CH2PR12MB4151:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4151CB937F81DB292B8B1098FE270@CH2PR12MB4151.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:561;
x-forefront-prvs: 0267E514F9
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(199004)(189003)(13464003)(71200400001)(110136005)(66446008)(45080400002)(66476007)(64756008)(66556008)(4326008)(76116006)(9686003)(66946007)(55016002)(966005)(478600001)(33656002)(52536014)(186003)(53546011)(81156014)(8936002)(5660300002)(316002)(7696005)(86362001)(2906002)(81166006)(26005)(8676002)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4151;
 H:CH2PR12MB3767.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vKEFzuevtKsClHnRgAjY1kwW1J066HhGHSkfk9vWffhNfJBfUwEJJCqNYYXqFoyQ2IFowKo+b26O66n/jmcN6+7m0p0soDX7ytGG32I4TApjUKPzs+vq9kfNtj3nCXXMxxGMR3r506wEmYK2XR8wSc1cPhcldT1KOJbiqjdDFAKtJBQX8HADA3PaqTw5RZDv140camc2Z+bsSfLCT5oREvSyCGHglpdspyrDRvH7Dl02CtGgBT7e0T1DwSt2CZnd8AXLtZ277OfAh8fOajUB1R7j0P2ughkE+yEBj+qApvwl4syDmp0APMTHibsHKlM30xYe/iecrf9htsymP6h+IeJx8j0CzES9ccfsc97jQbcjdBuZKEjg+JmexQdabi9igCIOxSZssfCxoNfhtvCqH44eD740VKT693Fg9MUdP8QMlcHmOqrr3+bH92mTXVAFW3tvoDwCqLnC940YrmFEegNLbKlQlBmgKl/ij1oCJVJSXQRHZ8SfenADNj04yBeo2v1Bc8ilSEWSYVf+6eAq5GA4LHern3+6tOgsfEY94Ns=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8138dd3-59d5-45c6-a1bc-08d78d163eef
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2019 10:51:37.9144 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NqHkT4AcZM/15m0Rw3HZa0sS9sJnrfWNVHETl2ThUCl79rLONFpYzJsW+71DcORb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Monday, December 30, 2019 6:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/powerplay: avoid deadlock on Vega20 swSMU routine

The lock required was already hold by its parent API.

Change-Id: I2ffe63d2016a2e274d54634cd8f8c51cca8b3a1c
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index bd3dbd1a0ad3..4b686f0af538 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -2279,13 +2279,9 @@ int smu_set_active_display_count(struct smu_context *smu, uint32_t count)  {
 	int ret = 0;
 
-	mutex_lock(&smu->mutex);
-
 	if (smu->ppt_funcs->set_active_display_count)
 		ret = smu->ppt_funcs->set_active_display_count(smu, count);
 
-	mutex_unlock(&smu->mutex);
-
 	return ret;
 }
 
--
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CFeifei.Xu%40amd.com%7C0c69774261644dbf915708d78d14b8af%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637132992460232130&amp;sdata=VE1izoxhGZuGqIIKmYW2a3eu8eYPogoC3LsP0C%2BRbjY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

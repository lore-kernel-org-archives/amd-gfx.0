Return-Path: <SRS0=SqeI=EC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCDBCC56201
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 03:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D5A92072D
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2020 03:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S5HcW24W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D5A92072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 631E06EABE;
	Tue, 27 Oct 2020 03:16:29 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2053.outbound.protection.outlook.com [40.107.102.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 897036EABE
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2020 03:16:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+pI/r1vyEdw3YebsBoJdzX56HsOI1rPuGhix4+wa4pndIdHD/r2Lz7LFmvLAVFOLX2wmIRrrZ1Cjtm/L090vasXGgOlklRfI5ZAUSBDmYubsVHenqpyPxjslqIf+CYncGZ8WYlmxL3+kB0biVmSKhpgN8mTVVxl0ulOs2rE7T3PQdMCM/Bs3fTkDBJibCpgaKuxYotwONukfCn+GOfcSeRwphVmENfxOnIcwqkwAym6Gz/Jj2nr0GVgx10nXF4Z/vEigxE7LfanrTy5+eb3JID7wv3qX/pJA9seECvwckphVCUL8lWH295polomTM/bZkFBbH8z3vFD18SwaFBl4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TcZb+EMq5GuGkEZQlo1TkqPEurHac39mFeguIsvP3A=;
 b=krue8ILS+NGfYGh7JqgCIvGunoi7oJzwB88mxrIv/gfM83AjC5RpF3ClqwdxcZ92UlrR+zmrmaMTqu3bD027BnjzguhmsuH3H0rkUuFznN0egwBICxTwJ4yGRqnWL6BkVr7ZYtBpE2UTROAQc2/tLNcHi3qjUOm3XWi0Pc7EE9sabk3tPsmE94f/laGNTC9kSLhP/1R6IkT/XH1wcM2N1jzNnQdIvcM9GqSoNplQ8JC6ZJqvBFeYLsveSfxsqj/aXu3npJpVhF3+TcRKDYTw0FCNEeSZs0H+aB/IqjcbGUfg+E0coUBBIVgagXeLpVuo3gwpk4MFXeYcxKXW4n4+ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TcZb+EMq5GuGkEZQlo1TkqPEurHac39mFeguIsvP3A=;
 b=S5HcW24W+Xe1hRWU3d8or65TiF/366OgWxPc7+s4Gj/K1nkzMsSKCW55Eclync+0b6yMYJwg9L3yd28lHNest+nKh8tDmsQz/azOQ+WW093CDGyarMrWc/tSyBWEsMowWkdSsSGtzlMYcq/XX7JZJgSsDN+HtquVfGb50MCaBZQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3578.namprd12.prod.outlook.com (2603:10b6:5:3c::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20; Tue, 27 Oct 2020 03:16:26 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 03:16:26 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/pm: fix the fan speed in fan1_input in manual
 mode for navi1x
Thread-Topic: [PATCH] drm/amdgpu/pm: fix the fan speed in fan1_input in manual
 mode for navi1x
Thread-Index: AQHWq+ESSdw5Er/Y90+WFtFCwbwL+amqx0Nw
Date: Tue, 27 Oct 2020 03:16:26 +0000
Message-ID: <DM6PR12MB26197EFA4500EDED1B0E8D83E4160@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20201026214326.1694539-1-alexander.deucher@amd.com>
In-Reply-To: <20201026214326.1694539-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=27744139-edfc-4bf0-ae9c-6e8fad098d2f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-27T03:16:08Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e5ae9dbe-a04d-4af6-b242-08d87a26b0cc
x-ms-traffictypediagnostic: DM6PR12MB3578:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB35783C08EB201557A6C81C35E4160@DM6PR12MB3578.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: plQLJxhPoS1lXaA6T7KVSm9c1s/DLn3HPinvh36ECjDddQnUeTtb2E8ip6wzVISQZ9/VpY6orLj6oGA6trixOOGZ5i5ROEi5QMJSaoYyqkAXl8MZb/jQkQlY6U1HH4H8y4lrUH9PLlffe3ZeatniXbYxF04OtFJX5GNHpJ5bACZpyPygHBm9nNfjiApFI2VLJUQJHsmds42777luA0VB4a2wsgg7J/zL3FEzJPw0Xoxg/hs05h16M484BAmjstHasDVd26q7+tHtBzWSluEttujJcTsTAupucwflebF/kwc/TZgynksiNIHPTxyJbbBNZlE/y1uaGZ3uOmhI6nIWH50BhoJBfoQj2mNrAZu7JkFhm3L4cFOnjJzi6dtKMCpRt16VCPh6q9id0vjhAKSexc2VrrmaltwL8Aw/kqzIrsHE8Dc7RSOr0Z/GZxntPCMP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(2906002)(4326008)(8676002)(33656002)(186003)(9686003)(8936002)(71200400001)(316002)(110136005)(83380400001)(966005)(53546011)(7696005)(6506007)(26005)(5660300002)(55016002)(76116006)(52536014)(66946007)(45080400002)(66556008)(64756008)(86362001)(478600001)(66476007)(66446008)(32563001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: vjxSOyNAlDTKiTzwJE72VwyumbDx5N2y1ZHRETtvyBWfaJ6pfnvLvScB8Ic52nUaL9vlX0IvuO4QjN6/27WyME+XJjwl/uyv+vTosA+m2pBKcEQksJB13GPLN7ciXZj9YyIsvmlAazSpN7V/BzVLD4Pp1aYXjXR2Lry5yYiMbJlpY/NfZ4qLxvxBF4i6/hR7OCIPMV+K0kl8b9ifhm/j5i/4RDXEO+JoVTbKTomIlEfGGKjkGUkes3m5D9UXJ1GZnFOS6VZLzTb7cVbLmQ7TROcopo+SEQedZ1Ip4fFvHtO/i2qRxzYYyEEu4QKhVrxVCxoeE60yfaoIhsYnJe4oXxqyntjyIVGWNKbjW69/hoERBjejh3zu+AkU7cRBwBZdKQe0BP2Wvsc0J/ZlEPjigVPPJXuD8v9bJ4WlcI3BBG+EFiMeAgiGw8ZEY60L2E5381pz4NJZb4/evCJIfPUKje+hTNagTVpKUHrnsDFpCIEE92s+KcAjo97LJpZqOGDve89YeKEhiY7hpWb4dlrCMCkii55pCCM6JYr6yPG3Pc4xjQtycbVBAfwUBxBvpmoA0q9Xv6THdVk1/OFM7E5DNBwpUG+sYigimJsScZ/fBHsMa77PZmCgoQ7Dm2gQlgToGdZcEtB4xXJbvFfyum97tg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ae9dbe-a04d-4af6-b242-08d87a26b0cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 03:16:26.5596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yKPoRTYsoQ1WjSzjDGoRyJsVNt37sGhp+vZrk/K9vm57qEHOD+5XSlrfHriWiAh1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3578
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Tuesday, October 27, 2020 5:43 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/pm: fix the fan speed in fan1_input in manual mode for navi1x

It has been confirmed that the SMU metrics table should always reflect the current fan speed even in manual mode.

Fixes: 3033e9f1c2de ("drm/amdgpu/swsmu: handle manual fan readback on SMU11")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 9cf97744b67e..ef1a62e86a0e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1361,14 +1361,9 @@ static int navi10_get_fan_speed_rpm(struct smu_context *smu,
 if (!speed)
 return -EINVAL;

-switch (smu_v11_0_get_fan_control_mode(smu)) {
-case AMD_FAN_CTRL_AUTO:
-return navi10_get_smu_metrics_data(smu,
-   METRICS_CURR_FANSPEED,
-   speed);
-default:
-return smu_v11_0_get_fan_speed_rpm(smu, speed);
-}
+return navi10_get_smu_metrics_data(smu,
+   METRICS_CURR_FANSPEED,
+   speed);
 }

 static int navi10_get_fan_parameters(struct smu_context *smu)
--
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7C6856f65a142f4c8b933f08d879f83340%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637393454223805214%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=HR2B2wvNQAEBBcDLEC9C6PXJOswWjejQN4XeWEuksSY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

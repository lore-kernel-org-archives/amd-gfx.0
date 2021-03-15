Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703E0C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 10:32:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19C9364E64
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 10:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C9364E64
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE77E897E7;
	Mon, 15 Mar 2021 10:32:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E660E899C7
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 10:32:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhdaxXK+GKyfMa2BZDNojfLgFWyA/hLVXSQ1DbuwhDeczjWSvRHmY9zC48Ri7DUhBPu8NflyhWtYL5MQMti4SEzIMgOuIOnZYwYZCYV3UoPYtpS8TE0wPbiBlT7uKt36krInmWOg69aNyyQAKHNbm8TzeKmV/Zmue80//77IoFz9HDYnIjVzDSd1jtgc6lc780N3Ehie81fMKe1sMh9nJn64DfKOeur8qBqDIfFma8uG+E/iUyEMBxtBmt55AYokQsbLxZQJHj9rQyp07CfJg0OoNg8Y45xJ+jUFicCA8Zm+3tRVo89/rWRpIRS59UgF2MR+5aTvDK9F3e2S9Oc4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gf2IIZU5EEDCQH9CHP1+uojrTnamwHAsMoi8p6xSNe4=;
 b=czfko9PGXxCZsqHwlhhqPRK1PZnu/Xfuoj1PB97eMXudXfNQ6h0uwu0mJ2FB9br/MvdXQfTnLYf/1UZc/nwECwKixm61I4pJJJDMLkymMSMBaQRjvVCiCPaAo9GPsQGUBHTReib2K6FWZ82FpCp1Tt8MI+g0xKIFHzN5Cn028Bgn4Bkm9XLsBeLrHhbNrqChXdHGuviwGUgVXNp90gbaKr+85xPQyzX/3v0yV6/axPDez8RsymWy5tE6kB++AMJeYlL1Mk+FZ+PYAKJzZh152M6zNl5xZJfGXpHwmLqdRsfeRgntkN5l9T9nq5pOmuMRTEMiL8FT7NawMAo34Ch1Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gf2IIZU5EEDCQH9CHP1+uojrTnamwHAsMoi8p6xSNe4=;
 b=nqRpfA6sS5HLepjnx3l68SP3JVR4OnsbXxlH79gvxSUD8FUTbsXS0yNeuROUGkjwuELG7eR3JePkq2x6eariNTghh7wmSWxZ/E9pawGw/3ZQm5lWQrRMyONtd9VTuZ+/YzUJaFwvuRxM7QbnT1ryd7fmtRM85yRXsjo+1nPMUQI=
Received: from DM6PR12MB3018.namprd12.prod.outlook.com (2603:10b6:5:118::11)
 by DM5PR12MB1516.namprd12.prod.outlook.com (2603:10b6:4:5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.31; Mon, 15 Mar 2021 10:32:15 +0000
Received: from DM6PR12MB3018.namprd12.prod.outlook.com
 ([fe80::ed92:347d:38a4:d88d]) by DM6PR12MB3018.namprd12.prod.outlook.com
 ([fe80::ed92:347d:38a4:d88d%4]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 10:32:15 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: wrap kiq ring ops with kiq spinlock
Thread-Topic: [PATCH 1/1] drm/amdgpu: wrap kiq ring ops with kiq spinlock
Thread-Index: AQHXF2Jbx+GysBYDAE64QX2oYnLx96qE3CUT
Date: Mon, 15 Mar 2021 10:32:15 +0000
Message-ID: <DM6PR12MB3018F5411F3181EA5616B106A26C9@DM6PR12MB3018.namprd12.prod.outlook.com>
References: <20210312170810.10934-1-nirmoy.das@amd.com>
In-Reply-To: <20210312170810.10934-1-nirmoy.das@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-15T10:32:15.297Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a8153b3-a7d4-405b-5750-08d8e79d9a64
x-ms-traffictypediagnostic: DM5PR12MB1516:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB15166A0CFFE4B2C967DE9756A26C9@DM5PR12MB1516.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bPd6Wx6N2w2j9gbKlE4XRRWic3GNs2sO2IvBG5o4cYPgt/oAsBYcvnYOIlEjNk/epikkLdc1CeWkL6gE3RhpuxVUOr8MR4dInn5pgW+JdNQ6sjn+ukfMMceuoyaONnI7QwBZdqArJ/J4B93N50xqpIU/w5EPl1KtMYfs36amI6V2mRXg7HzdZQF4siTSltK6BTWL88x0jRJBL0xRHSATIy72dmKYDlfDx/8UKxZ+NeA5hPHfAmKX1fQvA8S73ZaAnrnGwFm4H3rpFSRT9Z3slwIOHDJPt/IBHwimPzISfUVMwdFWUVjJ27Nj668EGuDM6Za6ho/1fergCDEPt/5OTtR2heXU4NLDeFjtvbN4o9tSL5mzpKuYsXqQR3KINTTmYs6Nbe9noFj0Et7Y8TknG0acVzlMdZuFoyDO7D1cQ0nMWH4eiQqOxLn/1giVkQ95Wcxon0e+CwFMT+Gjv2ymaDGiCrVEqF09+0SfZuA+ZYBe2rB2KhObRBL4sHkadN7Krpc7aWtJg0m+7vKzkG6qKKI/EKjwS68ceGdwxi3qsFwaR+ZMxIxKQ2q+/qXWX71Ts2usa6sQcyA5HwtGgKmBj/qQ4sTGBTaL2rBBbitPIg8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3018.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(66446008)(478600001)(9686003)(64756008)(6506007)(33656002)(45080400002)(7696005)(66556008)(8676002)(53546011)(2906002)(19627405001)(86362001)(66476007)(71200400001)(66946007)(316002)(186003)(26005)(110136005)(8936002)(4326008)(52536014)(166002)(6636002)(966005)(55016002)(76116006)(5660300002)(91956017)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?nCJ4XBiHjTzI8sLgPVN7TssMtBA6rkelo9f+1fAN1IutPtS5hB0O/zfjTS?=
 =?iso-8859-1?Q?elF1NGDXnlVYCYiTjLo19eHBw/VLC26aokNcQKA4a0HkayHQRXWOUu8ImA?=
 =?iso-8859-1?Q?VLzxeilNYja4l5trvtnVu2NbuveEGz/MgY74/RdpYK+NtfLvs+OrovwbRS?=
 =?iso-8859-1?Q?jDIn2iAmZ3CT4j7ws+oeLoQ9czP4GclOxsxg5jOnSKf66UOmHt9FuTSTOj?=
 =?iso-8859-1?Q?PHyT9UouOR1AGmbOGrEwB4CCG2rLqGxSPc1GQ6mtaRjFuFRD5+XGtEUgi3?=
 =?iso-8859-1?Q?DaJgxf5LZR81ViQM+VqLr1r+2DUJ62Jz609kNg8xu8gYRUXtmzyfKV8yc5?=
 =?iso-8859-1?Q?60HoITF3FmwND5UoO2IVku/t3cH591KHKcZi+iZdO5mdM5F5evHiF6b7x9?=
 =?iso-8859-1?Q?UDRTalFIHa9Y57YyWb9HhGJkBqQZ4vd/L8tTI+989oS64rIcGu6Ix3cahA?=
 =?iso-8859-1?Q?fIeGEuMtCwKTvW0QQqWRknGFHC0PitAxf3vWeVedmpUrz7LWrg0cVpMT0Z?=
 =?iso-8859-1?Q?JiDCcUjJ+pPOtBX2qnN4XaWVben/nusLboDary0vaw2LGKQu97yTYqfE9a?=
 =?iso-8859-1?Q?vEMkuhJMhIRi/4w3WxfSo2UaR5edpjXUQhcNAJk3DmJloicD1hrGoZC1Qa?=
 =?iso-8859-1?Q?Zwt4BammBgmtfGyvmRT+2iDxNSLX/eZbzuLsnOYqa/5M9niTFGp/oAIh1c?=
 =?iso-8859-1?Q?pKXoT+H0TNO2veaXnw49jiX5k0p8YvO5seBso8Z3ptSrADAjnK3Ce5Wofs?=
 =?iso-8859-1?Q?tLkaMecXklPHakafxm0FZPfLeBLvQeUnqSaXuRfoRjzXcBGpcvh2+64n3H?=
 =?iso-8859-1?Q?EQ+Sevt/spQzPEhA6UbCKZ4z29XaMOSarIEkNQykrq9GjlRqmawLZ1or+4?=
 =?iso-8859-1?Q?64YxEDSC40AFvjEJpomz3siuqMahrzlsAjEfYRjCKxuWmn3LFEVoHLNJK5?=
 =?iso-8859-1?Q?lImqvvRnFfIIJmJ0j5wx2RsMKcIphHfdpOJ3hDfmVGMtd03Q1wphyeqdAo?=
 =?iso-8859-1?Q?72ECezX4FPuoxf+VQDFUxUw/8WyU8CNhVVwXtidZdoYFwV+Jo8uEvlEb0R?=
 =?iso-8859-1?Q?/7SHhZsfa0K04hCg4efZ6LHDQkrQDLxy23eOrAKQujFqtqyAg8XubHcFTG?=
 =?iso-8859-1?Q?908PwqLVR5/6CztlGE78/qQtJZpYTiWKMTZZOf48mkZ3teo8qZ+kC8WTGy?=
 =?iso-8859-1?Q?QFyczW5AkEcfawvgAbWXwywSDuXajQ8evYHeF8dZNz7q0hpWV8GUtR8ulz?=
 =?iso-8859-1?Q?A0aKkgwAdyExiCpRqtxfgtlEX+IRoz+YV+kkVSRWMfbCcvBOgwFIHofIE3?=
 =?iso-8859-1?Q?88ottDjTpoyDcwbBaTix/f+fVrZty3pZHE3ThBPs+xEIqO2txIIrS0WY74?=
 =?iso-8859-1?Q?Sh6228y81M?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3018.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8153b3-a7d4-405b-5750-08d8e79d9a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 10:32:15.8314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MD+6HjjWQ9ELbDOkESlmc7Ys86SZHVSmmbCprade79NZijGPxzo/2jbFY5VHTz0J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1516
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0209559013=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0209559013==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB3018F5411F3181EA5616B106A26C9DM6PR12MB3018namp_"

--_000_DM6PR12MB3018F5411F3181EA5616B106A26C9DM6PR12MB3018namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi Das,

It seems more reasonable to put spin lock in ring structure, so that KIQ ri=
ng can be treated like other normal ring.
and do we have other paths to call kiq ring except for kernel initializatio=
n? it seems the kfd and kgd will use kiq in one thread..

thanks.

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Nirmoy D=
as <nirmoy.das@amd.com>
Sent: Saturday, March 13, 2021 1:08 AM
To: Koenig, Christian <Christian.Koenig@amd.com>
Cc: Das, Nirmoy <Nirmoy.Das@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: wrap kiq ring ops with kiq spinlock

KIQ ring is being operated by kfd as well as amdgpu.
KFD is using kiq lock, we should the same from amdgpu side
as well.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c
index 1915b9b95106..892dc6b269fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -462,20 +462,25 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev=
)
 {
         struct amdgpu_kiq *kiq =3D &adev->gfx.kiq;
         struct amdgpu_ring *kiq_ring =3D &kiq->ring;
-       int i;
+       int i, r;

         if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
                 return -EINVAL;

+       spin_lock(&adev->gfx.kiq.ring_lock);
         if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size *
-                                       adev->gfx.num_compute_rings))
+                                       adev->gfx.num_compute_rings)) {
+               spin_unlock(&adev->gfx.kiq.ring_lock);
                 return -ENOMEM;
+       }

         for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
                 kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.compute_ri=
ng[i],
                                            RESET_QUEUES, 0, 0);
+       r =3D amdgpu_ring_test_helper(kiq_ring);
+       spin_unlock(&adev->gfx.kiq.ring_lock);

-       return amdgpu_ring_test_helper(kiq_ring);
+       return r;
 }

 int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
@@ -518,12 +523,13 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev)

         DRM_INFO("kiq ring mec %d pipe %d q %d\n", kiq_ring->me, kiq_ring-=
>pipe,
                                                         kiq_ring->queue);
-
+       spin_lock(&adev->gfx.kiq.ring_lock);
         r =3D amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size *
                                         adev->gfx.num_compute_rings +
                                         kiq->pmf->set_resources_size);
         if (r) {
                 DRM_ERROR("Failed to lock KIQ (%d).\n", r);
+               spin_unlock(&adev->gfx.kiq.ring_lock);
                 return r;
         }

@@ -532,6 +538,7 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev)
                 kiq->pmf->kiq_map_queues(kiq_ring, &adev->gfx.compute_ring=
[i]);

         r =3D amdgpu_ring_test_helper(kiq_ring);
+       spin_unlock(&adev->gfx.kiq.ring_lock);
         if (r)
                 DRM_ERROR("KCQ enable failed\n");

--
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CKevin1.W=
ang%40amd.com%7C0a90c6383d634a5226a108d8e5797c08%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637511657234189238%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dsf=
a27Sz8wcIyHJqaE9f8aXQMeUxbyynpAONZHUYoogY%3D&amp;reserved=3D0

--_000_DM6PR12MB3018F5411F3181EA5616B106A26C9DM6PR12MB3018namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (west =
european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfont, r=
oboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt; color: rgb(=
50, 49, 48); background-color: rgba(0, 0, 0, 0);">Hi Das,</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (west =
european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfont, r=
oboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt; color: rgb(=
50, 49, 48); background-color: rgba(0, 0, 0, 0);"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (west =
european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfont, r=
oboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt; color: rgb(=
50, 49, 48); background-color: rgba(0, 0, 0, 0);">It seems more reasonable
 to put spin lock in ring structure, so that KIQ ring can be treated like o=
ther normal ring.</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
</div>
<div><span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (=
west european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfo=
nt, roboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt; color:=
 rgb(50, 49, 48); background-color: rgba(0, 0, 0, 0);">and do we have other
 paths to call kiq ring except for kernel initialization? it seems the kfd =
and kgd will use kiq in one thread..</span></div>
<div><br>
</div>
<div><span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (=
west european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfo=
nt, roboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt; color:=
 rgb(50, 49, 48); background-color: rgba(0, 0, 0, 0);">thanks.</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (west =
european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfont, r=
oboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt; color: rgb(=
50, 49, 48); background-color: rgba(0, 0, 0, 0);">Best Regards,</span></div=
>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;segoe ui&quot;, &quot;segoe ui web (west =
european)&quot;, &quot;segoe ui&quot;, -apple-system, blinkmacsystemfont, r=
oboto, &quot;helvetica neue&quot;, sans-serif; font-size: 12pt; color: rgb(=
50, 49, 48); background-color: rgba(0, 0, 0, 0);">Kevin</span></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Nirmoy Das &lt;nirmoy.das@amd=
.com&gt;<br>
<b>Sent:</b> Saturday, March 13, 2021 1:08 AM<br>
<b>To:</b> Koenig, Christian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Cc:</b> Das, Nirmoy &lt;Nirmoy.Das@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> [PATCH 1/1] drm/amdgpu: wrap kiq ring ops with kiq spinlock=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">KIQ ring is being operated by kfd as well as amdgp=
u.<br>
KFD is using kiq lock, we should the same from amdgpu side<br>
as well.<br>
<br>
Signed-off-by: Nirmoy Das &lt;nirmoy.das@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 15 +++++++++++----<br>
&nbsp;1 file changed, 11 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gfx.c<br>
index 1915b9b95106..892dc6b269fb 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
@@ -462,20 +462,25 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev=
)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_kiq *kiq =3D=
 &amp;adev-&gt;gfx.kiq;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *kiq_ri=
ng =3D &amp;kiq-&gt;ring;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!kiq-&gt;pmf || !kiq-&=
gt;pmf-&gt;kiq_unmap_queues)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;adev-&gt;gfx.kiq.ring_=
lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ring_alloc(kiq_=
ring, kiq-&gt;pmf-&gt;unmap_queues_size *<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; adev-&gt;gfx.num_compute_rings))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; adev-&gt;gfx.num_compute_rings)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spin_unlock(&amp;adev-&gt;gfx.kiq.ring_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;gfx.num_compute_rings; i++)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kiq-&gt;pmf-&gt;kiq_unmap_queues(kiq_ring, &amp;adev-=
&gt;gfx.compute_ring[i],<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RESET_QUEUES, 0, 0);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ring_test_helper(kiq_rin=
g);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;adev-&gt;gfx.kiq.rin=
g_lock);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_ring_test_helper(kiq_ri=
ng);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *a=
dev,<br>
@@ -518,12 +523,13 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev)=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;kiq ring me=
c %d pipe %d q %d\n&quot;, kiq_ring-&gt;me, kiq_ring-&gt;pipe,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kiq_ring-&gt;queue);<br>
-<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;adev-&gt;gfx.kiq.ring_=
lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ring_alloc(ki=
q_ring, kiq-&gt;pmf-&gt;map_queues_size *<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;gfx.num_compute_rings +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; kiq-&gt;pmf-&gt;set_resources_size);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed to lock KIQ (%d).\n&quot;, r);=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; spin_unlock(&amp;adev-&gt;gfx.kiq.ring_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -532,6 +538,7 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; kiq-&gt;pmf-&gt;kiq_map_queues(kiq_ring, &amp;adev-&g=
t;gfx.compute_ring[i]);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_ring_test_hel=
per(kiq_ring);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;adev-&gt;gfx.kiq.rin=
g_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;KCQ enable failed\n&quot;);<br>
&nbsp;<br>
-- <br>
2.30.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CKevin1.Wang%40amd.com%7C0a90c6383d634a5226a108d8e5797c08%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637511657234189238%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3Dsfa27Sz8wcIyHJqaE9f8aXQMeUxbyynpAONZHUYoogY%3D&amp;amp;res=
erved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CKevin1.Wang%40amd.com%7C0a90c6383d634a5226a108d8e5797c08%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637511657234189238%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3Dsfa27Sz8wcIyHJqaE9f8aXQMeUxbyynpAONZHUYoogY%3D&amp;amp;res=
erved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB3018F5411F3181EA5616B106A26C9DM6PR12MB3018namp_--

--===============0209559013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0209559013==--

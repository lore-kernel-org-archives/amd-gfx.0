Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFB4C4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 05:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B9B510E13A;
	Thu, 18 Jan 2024 05:36:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4E2210E13A
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 05:36:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMtt8zI4JYBsVafRItVGW08npF2lpUVbQEhS+FIOHhwlJNYdq72B8TKM9BWe4+L/n47E45gA/kdATkxiVqZGx3NwJ9vgVTEx8c+y1jlIw3YIBK1/hBxK3gdA8hqMw6C0eJTnAeyYIWmfPVJhAdd4Da6oDHJX3jCivyqmD1iW8AkgNm6aZ485s3iJBQmYn/HJc/tlSiRXYvueYEhHbk0eHaG/aRsVc4uD4Bypl8CjOOIW7WnKXoJxHowGtbkr1OdY90uLi8o3F5mvANUQ9PmFVK6W/8rsoVBMS7wUpuJnMj2t9VvLofSkVgeGCPDnuZrpHCR7tmsgi2igOZVOVNAOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gzkcr5zuEDncuQwJZrQyNJYfNQUmI9gNd6nI+uZWNKk=;
 b=nhe6CK+Uh7fEnzL/T586G/sEqsxWDcbYxIUhGWusC1WYr6JnSsi/9EIFMzO8TYYob5k0htSLINP+8Lin/gZGaYPhme2wTFDR401E4Wv/iiYfjfxkEytFUC7mII9hp+OymHwwhwYo6MoEvjSL1/1FqDW6NiYwW2Wr+/Tp7J3M7RJJd4TIkOJjVxO46aTKYTrfhDKTAbU5JHAa/Wr/gQhdBJCSu294TZ5mCZUAexjdcC0XXDomBD6Hy6ZRGN860aEGAOSaOEj14h3Pqd8LiDDXl07011kxnue7daAijclYL9jwoHt0PR0Mj9HcFSMkhZxIBC+Oywn0Q39t2Q8HYXBy5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gzkcr5zuEDncuQwJZrQyNJYfNQUmI9gNd6nI+uZWNKk=;
 b=gjU5MOnZrOTATGBM7y7rLntQyRJykVE8WZhVL28x5YFcE981MLIQYnJN4PiGEFzLYrV+fUX+idHESwVGLltM3rnugk7V602ahCkEV9Qz1CrgOYq3KPFArcC9J3tahq81HERBbfTqWWZ3Pkce9UObESXmtYb42m0PAXDJ7JH12fI=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by DM6PR12MB4531.namprd12.prod.outlook.com (2603:10b6:5:2a4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 05:36:16 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::2c41:8d9b:d594:6865]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::2c41:8d9b:d594:6865%6]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 05:36:16 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: Add log info for umc_v12_0 and smu_v13_0_6
Thread-Topic: [PATCH 1/5] drm/amdgpu: Add log info for umc_v12_0 and
 smu_v13_0_6
Thread-Index: AQHaSFT4X0kvFAN36E6tmf5WhZQ3QrDe5A+AgAArwLA=
Date: Thu, 18 Jan 2024 05:36:16 +0000
Message-ID: <CH2PR12MB4215D78ABEDFD345E78FCC39FC712@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240116082034.1739848-1-YiPeng.Chai@amd.com>
 <PH7PR12MB599715DC30B7DE699D68E44582712@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB599715DC30B7DE699D68E44582712@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b0ff5739-8a74-45ce-b1a6-9c0c9bc35047;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-18T02:57:02Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|DM6PR12MB4531:EE_
x-ms-office365-filtering-correlation-id: 0fcabc95-cf34-4587-c019-08dc17e763f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yOqrsZ2FY4FyBoYVB9m8TBHYwQTLx1lNttCxOOhx8SuvzojQoNU29CqpW+BtRMPsYeBkbQ1lYdOEzY5v+X19ejOoIn8vcwETn8IUTRQF97SxUjlKwf2j+/dP/5LVm2MnFCjcy66jCCJrevb+Fh+SW7H3kFGaaRnrxf6y1I5s1FiavYm/lrUrFRQaa/RhkARPzl6LzAX1iWQrOFkbjEi/P3o+8ozRcMmMqqODbccJXR8rTAosRzg2VTNU13E0Ap7xMD6J5I5Az/YB29h0gRQOT33YStyE8uheB+lqHFUADwhlyiNLr7n+iC4PoqgruF7H7I4MxlHI/BDc217vaAtLktSjuqXP7CuueMRK2fqTruy6ia3GsrVtL9QWIbku+PMj2fCXw2Sm/yNHFzbHS3YorwjgrGSdltsw1DkKnb+935DmEHuYLkWgsV/5Am3dMeUepMfYYGGbakQp4l4O58LxfycAmiVRHgq9+kvPDIm6PRxjXvh1ck2FpiuiwtFhmL0jdMfin7mIrhKE+J3AeOBudS3bDHIUJ1KTRxR4sai6BmYm5TvkTHXTA8fEl95uckQIMNzNeVF8pKPAAh01jU9Gfob7X0wDndfolXAgAOTcnWRvX9cMBzm0N4VoSVTLVrXG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(71200400001)(8936002)(4326008)(8676002)(5660300002)(64756008)(66476007)(316002)(66946007)(66556008)(2906002)(33656002)(54906003)(26005)(9686003)(66446008)(86362001)(52536014)(76116006)(110136005)(53546011)(6506007)(478600001)(7696005)(55016003)(41300700001)(38100700002)(122000001)(38070700009)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pVRWjIxZWZjy1I0Iy/+ToaedpbwVW+1WO9dO8s01l5KpgtrwxEC1LE2f60y0?=
 =?us-ascii?Q?7voBqfyI6F2cQgeyY+THCwQaj0KAWAZg7oaRh9/HTOBxYXO0WwQBu9thAtqm?=
 =?us-ascii?Q?lS5xdQQ4AgWGf+HkQQ/cbj5gE/hc7yff6ypSfhnOnAhYzwz9O0kLHBUuEHQG?=
 =?us-ascii?Q?vLoLQwULLcH8UYarNuGi62ZjgMQWpZk+bbPmL7bBY2N+zEp8z1QNv88CHgyJ?=
 =?us-ascii?Q?PUCMVj5wudqx0efIwnQ3EQuZ5Bio8c38uCKfiOCWfIvCUufJQm5JOVZph4jA?=
 =?us-ascii?Q?wTEky8LRJliRZvJR5pNGbvuMTCKYLv1eQXCnHCSxE4TZEbU1AVHNKmnNqdmk?=
 =?us-ascii?Q?+ahWDQuz9gZ0k2CUjacJSt75FqIWAuEvvaogDnZLCKa7MM1pAYDQE6NLFWxa?=
 =?us-ascii?Q?7oF9pWwt+PV0y+ZJTbC1P4l75pvz2ARUn/v+m8TpAlEBpbG0TWwdDYlctWrA?=
 =?us-ascii?Q?SH6axz0bG5cT9AEJnjC6jrlsmjZMilV82Epspm/2u5CMKeW3NZFdgzRpq+cT?=
 =?us-ascii?Q?HwqxvS3CNI/UlL4ry/yCUrgqLfPTnvK0XsjkuhvYWXO3J8bfCSS5qg2gGEgk?=
 =?us-ascii?Q?r0dvMuLQe9TDhkfMr8akJmqQcj5WKRi9ur+l1BrE4xU5DihvYNHUvG51oneK?=
 =?us-ascii?Q?nPTstFY3A2uTLdABffgTp5GiQe48gkro6gR2qikyIA4KZFTvxeiFJt0Sv/rs?=
 =?us-ascii?Q?qwHn2xKeeOjzMUKrWuBjGa8iMhVONtXLX3gsaAXPNzCTYdFfYqtyalPVOE7F?=
 =?us-ascii?Q?9DMi8/1anX4BL9Ylsy86sUQ4BsYCrSUT5hGZn7n+j6VRMbXFFTQQDy44Rre0?=
 =?us-ascii?Q?BDOQ8X2DHXwao8LgoxnA1eIgcQG508wSm6T7Xy2UulUoY/q/QLqVxjtN+ubM?=
 =?us-ascii?Q?PVD3oq+52CR5tJHnlhYOJFCkowee3PanqJyMWITQeGRBklgWc4PQnUfacP8O?=
 =?us-ascii?Q?auzzOuqFZ6G165tgBnhkzwCDHd2GqCR7Uy/wH4ppBvtux9QofAmGVMezXVcW?=
 =?us-ascii?Q?o8emUTDzSEAKPQLoND5U4HWQ2AbzCYpBIPWEbK1FRXrWO+jyqwF7EKdObKTi?=
 =?us-ascii?Q?d83BWetJ5FGYNTN5l2lQYkfzq712fw/0RhbKVZH7lP8TNaTJgEd+JS7S9GPO?=
 =?us-ascii?Q?kNmTB58ogZrBI3bVhtizrqKs2jCitZaAZVivxWwRZDw4iYv6+ASjbSsCPZya?=
 =?us-ascii?Q?bKTFHguS0uDHQ8XEDc2rNs2xRKQSEPoATjulRHSxI0TCg1ksLEqegsUJZcAl?=
 =?us-ascii?Q?4XMGzqgKQlqljLiRIdjwm9A6k4nujmW4o3X03z95ILX9L0o+4i8qHVRf8Hyd?=
 =?us-ascii?Q?bQuLvZ8xecnmffabUILRZPDO7Mu8ownI+PClfdtMywvUnUD7TWCatNVxIq5b?=
 =?us-ascii?Q?OsS3ZONefU5u0SQ1fGztluhOKSjYYHd270lAilvIg3yVUookZFxR0ySqenJX?=
 =?us-ascii?Q?fx0Ub6F/czuAaSYoKHYdj+Nk3+Pk2huO/XGhR6l1xNwfGPCxyVi7JP440tEK?=
 =?us-ascii?Q?dIBc5vethGBQKO2+IHdu4be/CzmknS7SDZS21liEoIU4g9ATQdzFF3rBDGRA?=
 =?us-ascii?Q?kgxtzTzSPE8uEVkRuvI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fcabc95-cf34-4587-c019-08dc17e763f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 05:36:16.1342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: clIr/t23aptuw6pyDFKTT/JxF3nZKF5XiJtL4K6BkJi/15bbGiNyl/8tp03sbtrzUX0B0VvHOp74J/avn+D5Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4531
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

OK


-----------------
Best Regards,
Thomas

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Thursday, January 18, 2024 11:00 AM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: RE: [PATCH 1/5] drm/amdgpu: Add log info for umc_v12_0 and smu_v13=
_0_6

[AMD Official Use Only - General]

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Tuesday, January 16, 2024 4:21 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang=
, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: Add log info for umc_v12_0 and smu_v13_0_6

Add log info for umc_v12_0 and smu_v13_0_6.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c              | 11 +++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_events.c             |  6 +++++-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 13 +++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 6423dca5b777..fa2168f1d3bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -91,6 +91,17 @@ static void umc_v12_0_reset_error_count(struct amdgpu_de=
vice *adev)

 bool umc_v12_0_is_deferred_error(struct amdgpu_device *adev, uint64_t mc_u=
mc_status)  {
+       dev_info(adev->dev,
+               "MCA_UMC_STATUS(0x%llx): Val:%llu, Poison:%llu, Deferred:%l=
lu, PCC:%llu, UC:%llu, TCC:%llu\n",
+               mc_umc_status,
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, V=
al),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, P=
oison),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, D=
eferred),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, P=
CC),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, U=
C),
+               REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, T=
CC)
+       );
+
        return (amdgpu_ras_is_poison_mode_supported(adev) &&
                (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, =
Val) =3D=3D 1) &&
                (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, =
Deferred) =3D=3D 1)); diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c =
b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index 11923964ce9a..51bb98db5d7a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1297,8 +1297,10 @@ void kfd_signal_poison_consumed_event(struct kfd_nod=
e *dev, u32 pasid)
        uint32_t id =3D KFD_FIRST_NONSIGNAL_EVENT_ID;
        int user_gpu_id;

-       if (!p)
+       if (!p) {
+               dev_warn(dev->adev->dev, "Not find process with pasid:%d\n"=
, pasid);
                return; /* Presumably process exited. */
+       }

        user_gpu_id =3D kfd_process_get_user_gpu_id(p, dev->id);
        if (unlikely(user_gpu_id =3D=3D -EINVAL)) { @@ -1334,6 +1336,8 @@ v=
oid kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
                }
        }

+       dev_warn(dev->adev->dev, "Send SIGBUS to process %s(pasid:%d)\n",
+               p->lead_thread->comm, pasid);
        rcu_read_unlock();

        /* user application will handle SIGBUS signal */ diff --git a/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/sw=
smu/smu13/smu_v13_0_6_ppt.c
index 952a983da49a..cee8ee5afcb6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2406,10 +2406,23 @@ static int smu_v13_0_6_get_valid_mca_count(struct s=
mu_context *smu, enum amdgpu_

        ret =3D smu_cmn_send_smc_msg(smu, msg, count);
        if (ret) {
+               dev_err(smu->adev->dev, "%s(%d) failed to query %s MCA coun=
t, ret:%d\n",
+                       (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ?
+                               "SMU_MSG_QueryValidMcaCeCount" : "SMU_MSG_Q=
ueryValidMcaCount",
+                       msg,
+                       (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ? "CE" : =
"UE",
+                       ret);
                *count =3D 0;
                return ret;
        }

+       dev_info(smu->adev->dev, "MSG %s(%d) query %s MCA count result:%u\n=
",
+               (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ?
+                       "SMU_MSG_QueryValidMcaCeCount" : "SMU_MSG_QueryVali=
dMcaCount",
+               msg,
+               (msg =3D=3D SMU_MSG_QueryValidMcaCeCount) ? "CE" : "UE",
+               *count);


[Kevin]:
Please make following function public then use this helper function to get =
msg name string.
- smu_get_message_name()

Best Regards,
Kevin
+
        return 0;
 }

--
2.34.1



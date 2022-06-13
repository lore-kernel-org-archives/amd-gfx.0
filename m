Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9694C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 13:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5873410E4C1;
	Mon, 13 Jun 2022 13:35:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2846E10E7B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 13:35:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MV7tkL9UNQxN+vS5LS+Sz9Gu0oEYbvKmPQrhzDPwROlqESyvu/kfSSXwZUHKflDibCmS/8fAlzistmcNUQmFMrvvI0kQJyQOcHwy+uibawsw54/ciSHzOGgCXZeI4W4MB5BefER7CQcdfgJbpooCj9CotpUQsjMc6r7Dm++55PKopb5+Y8uMFPqC8ktc2tEXGcdHBqDzSxtErr1m6BcPu4rJhdBfTJk0zgzwIFxR6OqWIIXwXuevNCDEFoz/zxBQ1SWotzGntfuUe4D6DDwUgogSFmRLOE9V5A5/APXu1iVko0/+xdshg0R0fs+C7ACNjEvGpSPVC0oFMiwIdiBH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2rclQnuaxMUU2RtTISKxIX3LuSKY857AtDSG5R3PlY=;
 b=cKZuyagl++UBNVAxS9xWbsKPQkV08et2XRGFNTQrTjymE6oBYyiA1eiZy2vSqzvZMSqSDQ6pmvZt6DUHvzye05/V2XoEnd7rPDYj00rdsT5opD6TB5spCjJicHKPd97kn9KByXH7P6gRK61Q6FLBGBdGbOxZhYRdTywa0irRxgjQ93CiB11E2R7eBS60CSB1wOjS+KfzqV5jQt0S2aHZTaGUJBeXe4J5lGxVAX/vV95nyB+ROrVB8s7krZxSeaxDN+vepLPkSCT6MLiWdEcEHaTVU4oEOcyGha3KJ5hSedni6AH/lL3t/MjWowoJJlQJeaEq4uM9ziM3dXti0MBXGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2rclQnuaxMUU2RtTISKxIX3LuSKY857AtDSG5R3PlY=;
 b=KGyQbl/zY1R1GU+HY27etrJR0RJbDt+I4hoNqo3eQ9sgrL7BF7UXUV//wTRfVaGOgbA7cP+R5EpYhrvc43uXFvEWUbMIBkm3gp/PcgWt7ddeeQr6eFuIVeN3Hwfdqzl3QWbu8tic798iKrlXIMzzTpA3O/vR3AO28omIcuh3SJw=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by DM5PR12MB1322.namprd12.prod.outlook.com (2603:10b6:3:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Mon, 13 Jun
 2022 13:35:43 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::3d3a:523d:94fd:fa16]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::3d3a:523d:94fd:fa16%6]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 13:35:43 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>
Subject: RE: [PATCH v2 2/3] drm/amdkfd: Enable GFX11 usermode queue
 oversubscription
Thread-Topic: [PATCH v2 2/3] drm/amdkfd: Enable GFX11 usermode queue
 oversubscription
Thread-Index: AQHYfO1qD+hkwtUMUU63lF5wgoylIK1JfqgAgAPcBtA=
Date: Mon, 13 Jun 2022 13:35:43 +0000
Message-ID: <DM6PR12MB3067FA74AA6B50D4554458098AAB9@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20220610171316.2668611-1-Graham.Sider@amd.com>
 <20220610171316.2668611-2-Graham.Sider@amd.com>
 <YqQABPHltcA2awgp@lang-desktop>
In-Reply-To: <YqQABPHltcA2awgp@lang-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-06-13T13:34:23Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=86c309f5-e755-4c77-a589-3c90bd190f78;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-06-13T13:35:42Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: a5f5b6d5-d5e7-4499-b0ea-510ab4b2f307
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cedd0d0-ec6d-476a-333c-08da4d419d9a
x-ms-traffictypediagnostic: DM5PR12MB1322:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1322539F4C5F53941B0B79AF8AAB9@DM5PR12MB1322.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HWoiogCVW6SE71osL479UpCr/dcxomAVRzisv7ysflxm1o+6ejl9ahubWpKLidnHrla0/qb4wUFQuAoHB4iM7xDiFev1Ai75w6HYm6vBqTWxQgUBNXpivPhX3+zeg2KtAZhLdQd2Abe4PfVNW1n1U5+rtpm+Ro1P4mCworzkPpVTG3kI0dxCszXkHfwZj8swZjEx1ngVd2uyyRFXeaUIqqsRmTNrAXfUQQSFw/Zjdn0U1LUtdBfuHh8uqgN7/vwEKQotIj9gmgxd+AkI8E9rNovgfpyOEV307daaL/OegvxhoE/yIqALDS58UtMetlSpVctI9h1gWr/c+YotGcRIVED88C4wpfEo+nV2g7nfCuSU9/tk64y0qUveaYS7XsgQEKqlt+xIlYWlklIQ2yNiymo4t3pR6uLOhxai/JP1kHheqzOxllv334lm/YBb5mEQI8ew0qvU+LIxwVAQMojET2SJ3kXEcwRL/+LKOZTILzAWVzFpnK0OnAniK8qsudRLo8Q+txTyHqMh65qNCWHQ3Yk/Hxd7BL5I0VWnUlaV3dCseEVVcbXk4OhYqlZS/F8fM4DNkGzCJt/0vD1z1P5B4nHKiVLK5lkxwnw/BG6mmkEplb3jEwduGfjkTDoAz3Qwi4zUOIvTRP0LClaDbNVXHblwV8WmyhK+nxrMgX6G/STA/vy/nDI1GJRLRyudGvbMJgjHn2jv2696MmAHddYclw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(6636002)(316002)(26005)(54906003)(66446008)(508600001)(5660300002)(71200400001)(7696005)(38100700002)(6506007)(86362001)(53546011)(30864003)(33656002)(122000001)(186003)(9686003)(55016003)(83380400001)(38070700005)(8676002)(64756008)(4326008)(52536014)(6862004)(76116006)(66556008)(66946007)(2906002)(66476007)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t3IvwNB3mr/Szx0/mAMW+1juFzSluU86fLVq1HAGXpRbnQaGXMlCnq1UwvPi?=
 =?us-ascii?Q?0BPPBZKvhEV8DPyvhhoK9E+dFy6QVrFC+CvdfocKSSk/EiWp9tOmO41s7hAQ?=
 =?us-ascii?Q?QylPSJ9M2MPJTVi81oGNN9LUbvQ33B2C5lICMeO+gxTuAJG+v8fmCHhz3MDC?=
 =?us-ascii?Q?Bry7TmFpDGq2KSweDRG7TdL1WfhUHuot7V6AQSl+4aP/9KhDAOPLaJ/7qZlN?=
 =?us-ascii?Q?yVie/fBKO/IG1hOgjlQQTJzm0ZN3lTfit+w83XtmzIw8NPyuRjI4Gm8JOM1H?=
 =?us-ascii?Q?fAsDphxcDYS7TvDgZpHJqjP9zxJtFxJSmEyZNsfrZit4b4q9Kh+PCJQZe5Sy?=
 =?us-ascii?Q?J0Usv/bWNfPPzjVKav6Z7kfccSQSt5tmG7Cs7JT5UMqA5kAk4j7RtOX5N+FP?=
 =?us-ascii?Q?L8MlK6kWsmyKfgGELg/0mUcc9rDJoSCGlz89RmIZ+jTWpqeeFJH3P+pA9FRd?=
 =?us-ascii?Q?pD8Y3NKl0EzhOKLnAWvejdgWFKFyyKfKYnGj3mLXFIB9YLQ5r5N+0X0CGryJ?=
 =?us-ascii?Q?kZBaS6ZStQvsEYFG2RK+Xtin4HhVui5VWsfbx3o8XD9RifYdKhGv+dmChreC?=
 =?us-ascii?Q?lMB2no9l9K5sRwKU8T8qpkR6nMZ4g0rmnSMDmKblQXredCCEGEaYvY7gtfgc?=
 =?us-ascii?Q?pPy9WgcZzgmg1UaWjGoZ4loLshDPYcjQtM2nRsdEjgRKPPRQk3W6/JWCixpd?=
 =?us-ascii?Q?0L/OJtTYWTJj9RQ3Y+WuuTanotzE5q54qbL2Z56XKzD0lvamYS9E/vi1G/4d?=
 =?us-ascii?Q?9ZA7u2nky6uh0I0mNkG7iVKm1NA8cgFg/+Gdqc8tYxWGiyBNsK5Ats8P+VPw?=
 =?us-ascii?Q?togH46/DvI1c1lhLBCWUZKy3TFUb9znccI6ICZxjaVPaB8vREAsdwmZBnYwW?=
 =?us-ascii?Q?FdaZRJ2bRPsHS/yrsHc0YBgve/+1OW02ptzc59KgTuXX/ENKbFWjccezS+Pt?=
 =?us-ascii?Q?sEAjZCy5hF4//s2KWXi9Ml7VumnWVsBr5I6WYoxHKjCdypWD1dkbOQ+OPdfJ?=
 =?us-ascii?Q?uC+EOpqtA4v1rM694/uFbAkm7M7KDyOo4A9umssytGxkE+TfaqVHkhz9Yrr+?=
 =?us-ascii?Q?LTfsoIf7QLPfk9FXkww9RYql4Sr36E/+1D3WkX0uXzEewuX8C5dUQoxTwvsO?=
 =?us-ascii?Q?7jtd434Kbr9UYZqBaJdKjpAaBsqpIoQ3W0sVd1VwS+ohEeENFF/JtKAaVvWZ?=
 =?us-ascii?Q?JhUdKE9pPasEmRpYUm9RXTH9itJVBKeY94lfRWiqtm4wnPq/66e4kd/7nNzS?=
 =?us-ascii?Q?aQZ0tYK9FJKdJm9MpU0+YRHfT6xT+TTfg5XFbOI7GBMT+Q/PLRbQ+ZCK71N+?=
 =?us-ascii?Q?tERMunHrrDRoVrJ2sMJuIvjDmxaMAx4+LWpECSqPey/wTsiy/AYdeNyg2fJV?=
 =?us-ascii?Q?GQUczBQVDZT6P6VHBvG/cAnc/DikBLWhTdGYvPV75YG3kdf09aCxcW8AEmhX?=
 =?us-ascii?Q?QF4UKbktD6uw4JjCSE6oMPcVbXgA/oOEkYAaj4ZJSbgi+dxMJMXTQjYsykda?=
 =?us-ascii?Q?+NFqEUFYzBq0uHKakk/DAR45wqBGZNqLsFJBy1aVGfAV0gDyYNZ5CRdk8HG/?=
 =?us-ascii?Q?2YDfeK1CZq4K3o8zrwfdtFkYQwq3CKMgmpxs+/WKi+0olawbsV6e5vwjg251?=
 =?us-ascii?Q?2KTdbFq8dY6iNWEQuF55+eB2yBlMsESp8HWc4nEuUei0Jici9UNZDh08Z4Jc?=
 =?us-ascii?Q?cIS5ENt8nQ0Db3aJJlpmWVdvAXVJPr4mPJKCDmqe8cIOouXu4rvc3Ub8fxNu?=
 =?us-ascii?Q?hlL1XAd6Fg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cedd0d0-ec6d-476a-333c-08da4d419d9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 13:35:43.8375 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nT4FO76F8/ZzN1GqONRP38BDGdAn8o4rRn0dHzbB5vTt17jHSzfK9lnj2JhvC9T18nQnqRJdoD0J1ZR7e3sGIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1322
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
Cc: "Joshi,
 Mukul" <Mukul.Joshi@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Yang,
 Philip" <Philip.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: Yu, Lang <Lang.Yu@amd.com>
> Sent: Friday, June 10, 2022 10:38 PM
> To: Sider, Graham <Graham.Sider@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Joshi, Mukul <Mukul.Joshi@amd.com>;
> Kuehling, Felix <Felix.Kuehling@amd.com>; Yang, Philip
> <Philip.Yang@amd.com>
> Subject: Re: [PATCH v2 2/3] drm/amdkfd: Enable GFX11 usermode queue
> oversubscription
>=20
> On 06/10/ , Graham Sider wrote:
> > Starting with GFX11, MES requires wptr BOs to be GTT allocated/mapped
> > to GART for usermode queues in order to support oversubscription. In
> > the case that work is submitted to an unmapped queue, MES must have a
> > GART wptr address to determine whether the queue should be mapped.
> >
> > This change is accompanied with changes in MES and is applicable for
> > MES_VERSION >=3D 3.
> >
> > v2: Update MES_VERSION check from 2 to 3.
> >
> > Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  1 +
> >  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 39
> ++++++++++++++++
> >  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 45
> ++++++++++++++++++-
> >  .../drm/amd/amdkfd/kfd_device_queue_manager.c |  9 +++-
> > .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  2 +
> >  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  3 ++
> >  .../amd/amdkfd/kfd_process_queue_manager.c    | 19 +++++---
> >  7 files changed, 110 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > index 429b16ba10bf..dba26d1e3be9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > @@ -301,6 +301,7 @@ int
> amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device
> *adev,
> >  		struct kgd_mem *mem, void **kptr, uint64_t *size);  void
> > amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct
> amdgpu_device *adev,
> >  		struct kgd_mem *mem);
> > +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev,
> > +struct amdgpu_bo *bo);
> >
> >  int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
> >  					    struct dma_fence **ef);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > index efab923056f4..2d452655eb04 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > @@ -2030,6 +2030,45 @@ int amdgpu_amdkfd_gpuvm_sync_memory(
> >  	return ret;
> >  }
> >
> > +int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev,
> > +struct amdgpu_bo *bo) {
> > +	int ret;
> > +
> > +	ret =3D amdgpu_bo_reserve(bo, true);
> > +	if (ret) {
> > +		pr_err("Failed to reserve bo. ret %d\n", ret);
> > +		goto err_reserve_bo_failed;
> > +	}
> > +
> > +	ret =3D amdgpu_bo_pin(bo, AMDGPU_GEM_DOMAIN_GTT);
> > +	if (ret) {
> > +		pr_err("Failed to pin bo. ret %d\n", ret);
> > +		goto err_pin_bo_failed;
> > +	}
> > +
> > +	ret =3D amdgpu_ttm_alloc_gart(&bo->tbo);
> > +	if (ret) {
> > +		pr_err("Failed to bind bo to GART. ret %d\n", ret);
> > +		goto err_map_bo_gart_failed;
> > +	}
> > +
> > +	amdgpu_amdkfd_remove_eviction_fence(
> > +		bo, bo->kfd_bo->process_info->eviction_fence);
> > +	list_del_init(&bo->kfd_bo->validate_list.head);
> > +
> > +	amdgpu_bo_unreserve(bo);
> > +
> > +	return 0;
> > +
> > +err_map_bo_gart_failed:
> > +	amdgpu_bo_unpin(bo);
> > +err_pin_bo_failed:
> > +	amdgpu_bo_unreserve(bo);
> > +err_reserve_bo_failed:
> > +
> > +	return ret;
> > +}
> > +
> >  int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct
> amdgpu_device *adev,
> >  		struct kgd_mem *mem, void **kptr, uint64_t *size)  { diff --
> git
> > a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > index e9766e165c38..58d5ebed1b32 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> > @@ -290,6 +290,11 @@ static int kfd_ioctl_create_queue(struct file *fil=
ep,
> struct kfd_process *p,
> >  	struct queue_properties q_properties;
> >  	uint32_t doorbell_offset_in_process =3D 0;
> >
> > +	struct amdgpu_bo_va_mapping *wptr_mapping;
> > +	struct interval_tree_node *wptr_node;
> > +	struct amdgpu_vm *wptr_vm;
> > +	struct amdgpu_bo *wptr_bo =3D NULL;
> > +
> >  	memset(&q_properties, 0, sizeof(struct queue_properties));
> >
> >  	pr_debug("Creating queue ioctl\n");
> > @@ -316,12 +321,44 @@ static int kfd_ioctl_create_queue(struct file
> *filep, struct kfd_process *p,
> >  		goto err_bind_process;
> >  	}
> >
> > +	/* Starting with GFX11, MES requires wptr BOs to be GTT
> allocated/mapped to
> > +	 * GART for usermode queues in order to support oversubscription.
> In the
> > +	 * case that work is submitted to an unmapped queue, MES must
> have a GART
> > +	 * wptr address to determine whether the queue should be mapped.
> > +	 */
> > +	if (dev->shared_resources.enable_mes && (dev->adev-
> >mes.sched_version & 0xff) >=3D 3) {
> > +		wptr_vm =3D drm_priv_to_vm(pdd->drm_priv);
> > +		err =3D amdgpu_bo_reserve(wptr_vm->root.bo, false);
> > +		if (err)
> > +			goto err_wptr_bo_reserve;
> > +
> > +		wptr_node =3D interval_tree_iter_first(&wptr_vm->va,
> > +				args->write_pointer_address >>
> PAGE_SHIFT,
> > +				args->write_pointer_address >>
> PAGE_SHIFT);
> > +		if (!wptr_node) {
> > +			pr_err("Failed to lookup wptr bo\n");
> > +			err =3D -EINVAL;
> > +			goto err_wptr_bo_lookup;
> > +		}
> > +
> > +		wptr_mapping =3D container_of((struct rb_node *)wptr_node,
> struct
> > +amdgpu_bo_va_mapping, rb);
>=20
> You can use amdgpu_vm_bo_lookup_mapping() to find a mapping by
> address.
>=20
> Regards,
> Lang

Good catch, will use this. Thanks!

Best,
Graham

>=20
> > +		wptr_bo =3D wptr_mapping->bo_va->base.bo;
> > +
> > +		amdgpu_bo_unreserve(wptr_vm->root.bo);
> > +
> > +		err =3D amdgpu_amdkfd_map_gtt_bo_to_gart(dev->adev,
> wptr_bo);
> > +		if (err) {
> > +			pr_err("Failed to map wptr bo to GART\n");
> > +			goto err_wptr_bo_gart_map;
> > +		}
> > +	}
> > +
> >  	pr_debug("Creating queue for PASID 0x%x on gpu 0x%x\n",
> >  			p->pasid,
> >  			dev->id);
> >
> > -	err =3D pqm_create_queue(&p->pqm, dev, filep, &q_properties,
> &queue_id, NULL, NULL, NULL,
> > -			&doorbell_offset_in_process);
> > +	err =3D pqm_create_queue(&p->pqm, dev, filep, &q_properties,
> &queue_id, wptr_bo,
> > +			NULL, NULL, NULL, &doorbell_offset_in_process);
> >  	if (err !=3D 0)
> >  		goto err_create_queue;
> >
> > @@ -353,7 +390,11 @@ static int kfd_ioctl_create_queue(struct file *fil=
ep,
> struct kfd_process *p,
> >  	kfd_dbg_ev_raise(KFD_EC_MASK(EC_QUEUE_NEW), p, dev,
> queue_id, false, NULL, 0);
> >  	return 0;
> >
> > +err_wptr_bo_lookup:
> > +	amdgpu_bo_unreserve(wptr_vm->root.bo);
> >  err_create_queue:
> > +err_wptr_bo_gart_map:
> > +err_wptr_bo_reserve:
> >  err_bind_process:
> >  err_pdd:
> >  	mutex_unlock(&p->mutex);
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > index b39d89c52887..d8de2fbdfc7d 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> > @@ -208,6 +208,7 @@ static int add_queue_mes(struct
> device_queue_manager *dqm, struct queue *q,
> >  	struct kfd_process_device *pdd =3D qpd_to_pdd(qpd);
> >  	struct mes_add_queue_input queue_input;
> >  	int r, queue_type;
> > +	uint64_t wptr_addr_off;
> >
> >  	if (dqm->is_hws_hang)
> >  		return -EIO;
> > @@ -227,7 +228,13 @@ static int add_queue_mes(struct
> device_queue_manager *dqm, struct queue *q,
> >
> 	AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
> >  	queue_input.doorbell_offset =3D q->properties.doorbell_off;
> >  	queue_input.mqd_addr =3D q->gart_mqd_addr;
> > -	queue_input.wptr_addr =3D (uint64_t)q->properties.write_ptr;
> > +
> > +	if (q->wptr_bo) {
> > +		wptr_addr_off =3D (uint64_t)q->properties.write_ptr -
> (uint64_t)q->wptr_bo->kfd_bo->va;
> > +		queue_input.wptr_addr =3D ((uint64_t)q->wptr_bo-
> >tbo.resource->start << PAGE_SHIFT) + wptr_addr_off;
> > +	} else
> > +		queue_input.wptr_addr =3D (uint64_t)q-
> >properties.write_ptr;
> > +
> >  	queue_input.paging =3D false;
> >  	queue_input.tba_addr =3D qpd->tba_addr;
> >  	queue_input.tma_addr =3D qpd->tma_addr; diff --git
> > a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> > index f1654b4da856..35e74bdd81da 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> > @@ -377,6 +377,8 @@ static void update_mqd_sdma(struct mqd_manager
> *mm, void *mqd,
> >  	m->sdmax_rlcx_rb_base_hi =3D upper_32_bits(q->queue_address >>
> 8);
> >  	m->sdmax_rlcx_rb_rptr_addr_lo =3D lower_32_bits((uint64_t)q-
> >read_ptr);
> >  	m->sdmax_rlcx_rb_rptr_addr_hi =3D
> > upper_32_bits((uint64_t)q->read_ptr);
> > +	m->sdmax_rlcx_rb_wptr_poll_addr_lo =3D lower_32_bits((uint64_t)q-
> >write_ptr);
> > +	m->sdmax_rlcx_rb_wptr_poll_addr_hi =3D
> > +upper_32_bits((uint64_t)q->write_ptr);
> >  	m->sdmax_rlcx_doorbell_offset =3D
> >  		q->doorbell_off <<
> SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > index a5d3963537d7..dcddee0d6f06 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > @@ -639,6 +639,8 @@ struct queue {
> >  	void *gang_ctx_bo;
> >  	uint64_t gang_ctx_gpu_addr;
> >  	void *gang_ctx_cpu_ptr;
> > +
> > +	struct amdgpu_bo *wptr_bo;
> >  };
> >
> >  enum KFD_MQD_TYPE {
> > @@ -1404,6 +1406,7 @@ int pqm_create_queue(struct
> process_queue_manager *pqm,
> >  			    struct file *f,
> >  			    struct queue_properties *properties,
> >  			    unsigned int *qid,
> > +			    struct amdgpu_bo *wptr_bo,
> >  			    const struct kfd_criu_queue_priv_data *q_data,
> >  			    const void *restore_mqd,
> >  			    const void *restore_ctl_stack, diff --git
> > a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> > index f99e09dc43ea..ede1462a55c8 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> > @@ -190,7 +190,8 @@ void pqm_uninit(struct process_queue_manager
> *pqm)
> > static int init_user_queue(struct process_queue_manager *pqm,
> >  				struct kfd_dev *dev, struct queue **q,
> >  				struct queue_properties *q_properties,
> > -				struct file *f, unsigned int qid)
> > +				struct file *f, struct amdgpu_bo *wptr_bo,
> > +				unsigned int qid)
> >  {
> >  	int retval;
> >
> > @@ -221,6 +222,9 @@ static int init_user_queue(struct
> process_queue_manager *pqm,
> >  			goto cleanup;
> >  		}
> >  		memset((*q)->gang_ctx_cpu_ptr, 0,
> AMDGPU_MES_GANG_CTX_SIZE);
> > +
> > +		if (wptr_bo)
> > +			(*q)->wptr_bo =3D amdgpu_bo_ref(wptr_bo);
> >  	}
> >
> >  	pr_debug("PQM After init queue");
> > @@ -237,6 +241,7 @@ int pqm_create_queue(struct
> process_queue_manager *pqm,
> >  			    struct file *f,
> >  			    struct queue_properties *properties,
> >  			    unsigned int *qid,
> > +			    struct amdgpu_bo *wptr_bo,
> >  			    const struct kfd_criu_queue_priv_data *q_data,
> >  			    const void *restore_mqd,
> >  			    const void *restore_ctl_stack, @@ -299,7 +304,7
> @@ int
> > pqm_create_queue(struct process_queue_manager *pqm,
> >  		 * allocate_sdma_queue() in create_queue() has the
> >  		 * corresponding check logic.
> >  		 */
> > -		retval =3D init_user_queue(pqm, dev, &q, properties, f, *qid);
> > +		retval =3D init_user_queue(pqm, dev, &q, properties, f,
> wptr_bo,
> > +*qid);
> >  		if (retval !=3D 0)
> >  			goto err_create_queue;
> >  		pqn->q =3D q;
> > @@ -320,7 +325,7 @@ int pqm_create_queue(struct
> process_queue_manager *pqm,
> >  			goto err_create_queue;
> >  		}
> >
> > -		retval =3D init_user_queue(pqm, dev, &q, properties, f, *qid);
> > +		retval =3D init_user_queue(pqm, dev, &q, properties, f,
> wptr_bo,
> > +*qid);
> >  		if (retval !=3D 0)
> >  			goto err_create_queue;
> >  		pqn->q =3D q;
> > @@ -457,9 +462,13 @@ int pqm_destroy_queue(struct
> process_queue_manager *pqm, unsigned int qid)
> >  			pdd->qpd.num_gws =3D 0;
> >  		}
> >
> > -		if (dev->shared_resources.enable_mes)
> > +		if (dev->shared_resources.enable_mes) {
> >  			amdgpu_amdkfd_free_gtt_mem(dev->adev,
> >  						   pqn->q->gang_ctx_bo);
> > +			if (pqn->q->wptr_bo)
> > +				amdgpu_amdkfd_free_gtt_mem(dev-
> >adev, pqn->q->wptr_bo);
> > +
> > +		}
> >  		uninit_queue(pqn->q);
> >  	}
> >
> > @@ -900,7 +909,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
> >
> >  	print_queue_properties(&qp);
> >
> > -	ret =3D pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp,
> &queue_id, q_data, mqd, ctl_stack,
> > +	ret =3D pqm_create_queue(&p->pqm, pdd->dev, NULL, &qp,
> &queue_id,
> > +NULL, q_data, mqd, ctl_stack,
> >  				NULL);
> >  	if (ret) {
> >  		pr_err("Failed to create new queue err:%d\n", ret);
> > --
> > 2.25.1
> >

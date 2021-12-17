Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9362EC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 15:17:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1208110F01F;
	Fri, 17 Dec 2021 15:17:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1BD710F01E
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 15:17:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fai+JzyI5iBeKRd9zjvMqiv301mMv3t5QiOa0yAYDyEj3sx19BHkiwqYpv3wAJMgs/J9gGdm8uKcsHH3UVORMM9VIUFVUvqv4Yj/4q5cC4ynKyLDkPw/RXIJGydrPuPN0Ve4pA9EIg8H+FfgfWiyugGdjb/05s37ujhfta/t3I4uzJzODAMze11LDlGzEGVErd3LHlOb0g+nBskraOPkc6wlr569Bm1dsOhG3BQC67QxFWsdjh1cYNWT1L1iUc3rX4QbzgHNth9WjWDTLCnrCLvmRCJYPzKBEw7hw9W65Nv3gRdNG24P0H0iIBnh9VJ6jOmGHcH3wTvgs1wTmZy+Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Oe4c3D+mGxb+ryT/7qIHTNjlD+BwJIGP0XkGIc9bAg=;
 b=ZjRAvKsDJKZnDLzK1aoOVEHq9IaF6ywlPzgc0yonQXu23Spg1kksIAcX4aUYg7pxD7wJGtWtnGmw0sSqCeYrGtHcYvMjvyISQ1daIzQztYtfyDxr9C3yYYRo87qnWEN3nWrsNsVUKCgUTv+nzs3665qxskrcH8q6O9hEJCrJlNjJLXBc/RHQ5JSF5JBcLRzMYQn7HZPS+LeGMl5Yy2m94+B46ClZliS+SPDVFM5WW0Cza1V59RxgOigZ4UIZGMjuQypeW7kMYtlVNuN35tbGyCVdTb/8T2Q8/a9bw+LEY0fMezRyMVTVdbduIaCnOjGD4+DMcIMEvrgm8yhgeZhoJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Oe4c3D+mGxb+ryT/7qIHTNjlD+BwJIGP0XkGIc9bAg=;
 b=AHFVHHePDHAGl1CFXaOU7tn2rHD6VtLEqnwg8gMvqJ/1i+feQG37tKpcOm9CeQ0n9KSEiPFcwqNCE8klcdi2r26Ec5y6KG1hLEAj5UFrbsSaQjBOIbnm6uI9anz3wURNB+d2NFKZOjLwI95l/D/EJlcZo66A0gVj9GaXDEyPxBs=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM6PR12MB2748.namprd12.prod.outlook.com (2603:10b6:5:43::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Fri, 17 Dec
 2021 15:17:09 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::60ca:d581:a3ac:43bb]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::60ca:d581:a3ac:43bb%4]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 15:17:09 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Sider, Graham" <Graham.Sider@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: correct sdma queue number in kfd device init
Thread-Topic: [PATCH] drm/amdkfd: correct sdma queue number in kfd device init
Thread-Index: AQHX81LER4hIH3BxJEKLXk5oVL4kcqw2xj8Q
Date: Fri, 17 Dec 2021 15:17:09 +0000
Message-ID: <DM6PR12MB3163CA2EFDCE07DCCA30E5CF85789@DM6PR12MB3163.namprd12.prod.outlook.com>
References: <20211217143106.14140-1-guchun.chen@amd.com>
In-Reply-To: <20211217143106.14140-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=905ca676-dbac-4b94-aa00-5c56a56b9cec;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-17T14:57:44Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-bromium-msgid: fe6d526d-08fa-45db-b35c-de8d69447c35
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8476d39f-0612-472e-0c9a-08d9c1704ba1
x-ms-traffictypediagnostic: DM6PR12MB2748:EE_
x-microsoft-antispam-prvs: <DM6PR12MB2748BF52CB280C87F5A00E4C85789@DM6PR12MB2748.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: co/NnsQHWCmmoZ5iffRrELoTjpOFiYnztDXA607PDsY4mJMTt2c5LpZFogB9pRuL9JWkJNCQkZfNKON2DE0DBg9VbF27WtHIk2UPkEJozf/B1PLWQXNxdvWTfEcdSMlXGE1+Gv7BIFwm3yUiVTHJWO/JgQqQn9w4szSNn3LHtOWqxijoBHS2bt+f+0fYN5BaeKUNPuhQtCS15SQu1FsxDLX4KP+YBLKFcTQpDeJ6LIRDzV2THhI0cC1m3tPozSOTOmx/dgpbl22E/4eMzEP5uipTFO2sJJvz5bo8uUCODs4i9WhKLzAvx69XWvUea4imkV2o7w6iQoYqw9Ox7CzieAcdGS0MkfPqOdm1wQwk+LuFax26KxR5VkksCOVLYgmS/o66Shxdm583pHpwL2SZlGzxg+H+7BZrF1+1vvqov0Ua7jA+gn8Kg+r6qjUO7Y+IcpoDi/RePfgvAhXDaZBAmzFKpI+7KFUK2tJaRM1Dfy3C0x3m1XEN7mPv1lds/IxRRQ1KWbdwGsr60mZ4juxGRtsGI/KXyLdPIdlZ7KmGdpObs7wv9zQkTg/e4WoVD6Re3yvI40Mqj91AYWDI7+kEltytLBA8EvgHDPQEQJ4uhsp5xxnb7+KPsgjFEjFor0dCPDGFxrWHHd+tJzL5rd0KhAkj2myv347B+Z47z1IkZMZPobsWErH9/7cfoh/iiRtgFfqf1WarLLYX8WY/Vw7lXA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(52536014)(8936002)(6506007)(55016003)(5660300002)(76116006)(53546011)(33656002)(26005)(8676002)(186003)(122000001)(66476007)(2906002)(38100700002)(508600001)(83380400001)(7696005)(86362001)(6636002)(66946007)(66446008)(110136005)(71200400001)(316002)(38070700005)(64756008)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q3SInh7NmQ8x+zS8NhtSCOXB+ET7KNPk27nUSYbmoxhYW7rSY/tdvreYGyAF?=
 =?us-ascii?Q?iOaIpB8CxCorPb/4Vwqdl+xLpCCkP5tsuT/tM///Wb1LrJUP67jw3tp7sjY9?=
 =?us-ascii?Q?OUuMNrddPj1vWXLh6la6Cfckp37TSaue7vnmk4pWUA5IxlYc/gsvX4TQRm/r?=
 =?us-ascii?Q?831q434e9ZTEQ+Mpq03LWLWPHv4wYYd83CeQ6SFvNXDCoy2p/XxoYjNtEUnB?=
 =?us-ascii?Q?T7DMqh9c7QdgqAmMfZ7d9FpK/hriAs8pXHmpsLAbBQSLI4k+5ksJxIwnp/8m?=
 =?us-ascii?Q?UuWiaOLaexS4w4MXd9oTzDqfqLL6MEunVBtvYzj7r5GlPtFLon2tfv2iVlqc?=
 =?us-ascii?Q?esMfHC1phRUW4JTugzUgre+211Ms8Fi+H6sAttXJ2timWu21gSGbjt5G4I81?=
 =?us-ascii?Q?1Z9IuZvt2/fl8++nR7GJ/XW09nY1YJtVK6RYguVl5KeX7ZH+0B0JU7nBexUv?=
 =?us-ascii?Q?ZFcighcCTWiVKWWTrrJtTydREiJhcA6vPX1quE/QDizi4EGIxQ7pYy0eI13h?=
 =?us-ascii?Q?qoCir87u+/kEyrmJbYNIXedRLIu1NYbroa41XJmNy7t7e3s/soq12dAqpTbi?=
 =?us-ascii?Q?gLhxqLJaxud7zuq3TDy+/jVKd/1BUvajJCHk2jtiAzWPD1HlFqapj6zK30gd?=
 =?us-ascii?Q?n4A6U9IESC7zI/77feSGz1YO49ED4YT3dbrXNegIPENu5Sc5AjlUu3Y/P2tA?=
 =?us-ascii?Q?1oFKEG8PxLzWd7RjvBIMaRwmx7zuoYsPBneZGo3s+PQqV+Oej6waV0GedjtQ?=
 =?us-ascii?Q?Id9ru/gdEGhUtcv/rJm9FfGS2mKhL2HtbEpiMUg9ZdqjDxYOXIuXjfpl+2Vo?=
 =?us-ascii?Q?RpAhGBES+O1gT72ZvoFw1/N8OAwyGJCkrN4ZD5r0tq6GK/cMl9rOWPtbZ593?=
 =?us-ascii?Q?Mr4w+GwVy3rGRRN8m7k2c497hmq/fl8wmUtuwOrXSMYVfpGCDMGGoDnZv2IT?=
 =?us-ascii?Q?C8N+RBcNQxg0LDAOnidvGEfpLtwMZQxfU3JCwaVbHkkiqi/x1HNdX8VmUOXJ?=
 =?us-ascii?Q?xdFT5HlXMdx08h7VEY/GS7Wpp0PQVapI+msWDTBnV53SM46I4j9o20ZBUxQ9?=
 =?us-ascii?Q?xx6yufofSYwNJh6PKoErCFFFdkLsTZF13ouP2yQYcgVw/AZ5csMaErN3VIk2?=
 =?us-ascii?Q?A6ZcpnPHNeyUI6IxiRLoAmBxuETn+AEHbWbE1bSdeP9Q7VVGD/Z9X4bbKgmF?=
 =?us-ascii?Q?plfClYf1D0fLQWH+STgJyCKcvdDN1BVRRMzBXCm14xpp0WGjIbA+M6vT0TvP?=
 =?us-ascii?Q?/BeqIfY8XITlPUj6Wk8PAyEy1Yrxi4pBCL2LmYUOS/gm7ib+a7Mf+y+r2jWM?=
 =?us-ascii?Q?saaKz6STjstaQ7ogIhEfSIm+Ru3TEq4/qu/czkq6+jXk9k4ltdKx4ZrlSQ9S?=
 =?us-ascii?Q?DlR4MgBQuIfXNGe1Y67Bfs8YqS4LzAzF7DGHNzxzpGsIT15OpzWvYcdSLRva?=
 =?us-ascii?Q?T57U1rn8JThK+vsI4jYrzVJzvNcEkOtsoImEZJ8nGMKSb7yn0xLXVtHd32xt?=
 =?us-ascii?Q?KTBTQnhHbNKaZr4oLw0gSpVTKCrZ2zcG22MABNeMcATcUp7Uo6TQAhZsqZI2?=
 =?us-ascii?Q?Laz1Y7oit93ajzIgb4I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8476d39f-0612-472e-0c9a-08d9c1704ba1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 15:17:09.7573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nGSFs75hkCMvmba9hokiH48CbzK0HNK/wT3YW6VfIJQxQIl5vKIKBNriZ9MO2stI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2748
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Are safeguards required for KFD interrupt initialization to fail gracefully=
 in the event of a non-assignment?
Same would apply when KGD forwards interrupts to the KFD (although the KFD =
device reference might not exist at this point if the above comment is hand=
led well so a check may not apply in this case).

Also should the dev_errs mention what it's failing to do rather than just r=
eporting that it could not find the HW IP block?
In the case of non-assignment of sdma queues per engine, it still seems lik=
e the KFD could move forward but the user wouldn't know what the context of=
 the dev_err was.

Thanks,

Jon

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: December 17, 2021 9:31 AM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Sider, Graham
> <Graham.Sider@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
> Kim, Jonathan <Jonathan.Kim@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amdkfd: correct sdma queue number in kfd device
> init
>
> sdma queue number is not correct like on vega20, this patch promises the
> setting keeps the same after code refactor.
> Additionally, improve code to use switch case to list IP version to compl=
ete
> kfd device_info structure filling.
> This keeps consistency with the IP parse code in amdgpu_discovery.c.
>
> Fixes: a9e2c4dc6cc4("drm/amdkfd: add kfd_device_info_init function")
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 74
> ++++++++++++++++++++++---
>  1 file changed, 65 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index facc28f58c1f..e50bf992f298 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -59,11 +59,72 @@ static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
>
>  static int kfd_resume(struct kfd_dev *kfd);
>
> +static void kfd_device_info_set_sdma_queue_num(struct kfd_dev *kfd) {
> +     uint32_t sdma_version =3D kfd->adev-
> >ip_versions[SDMA0_HWIP][0];
> +
> +     switch (sdma_version) {
> +             case IP_VERSION(4, 0, 0):/* VEGA10 */
> +             case IP_VERSION(4, 0, 1):/* VEGA12 */
> +             case IP_VERSION(4, 1, 0):/* RAVEN */
> +             case IP_VERSION(4, 1, 1):/* RAVEN */
> +             case IP_VERSION(4, 1, 2):/* RENIOR */
> +             case IP_VERSION(5, 2, 1):/* VANGOGH */
> +             case IP_VERSION(5, 2, 3):/* YELLOW_CARP */
> +                     kfd->device_info.num_sdma_queues_per_engine =3D
> 2;
> +                     break;
> +             case IP_VERSION(4, 2, 0):/* VEGA20 */
> +             case IP_VERSION(4, 2, 2):/* ARCTUTUS */
> +             case IP_VERSION(4, 4, 0):/* ALDEBARAN */
> +             case IP_VERSION(5, 0, 0):/* NAVI10 */
> +             case IP_VERSION(5, 0, 1):/* CYAN_SKILLFISH */
> +             case IP_VERSION(5, 0, 2):/* NAVI14 */
> +             case IP_VERSION(5, 0, 5):/* NAVI12 */
> +             case IP_VERSION(5, 2, 0):/* SIENNA_CICHLID */
> +             case IP_VERSION(5, 2, 2):/* NAVY_FLOUDER */
> +             case IP_VERSION(5, 2, 4):/* DIMGREY_CAVEFISH */
> +                     kfd->device_info.num_sdma_queues_per_engine =3D
> 8;
> +                     break;
> +             default:
> +                     dev_err(kfd_device,
> +                             "Failed to find sdma ip
> blocks(SDMA_HWIP:0x%x) in %s\n",
> +                                sdma_version, __func__);
> +     }
> +}
> +
> +static void kfd_device_info_set_event_interrupt_class(struct kfd_dev
> +*kfd) {
> +     uint32_t gc_version =3D KFD_GC_VERSION(kfd);
> +
> +     switch (gc_version) {
> +     case IP_VERSION(9, 0, 1): /* VEGA10 */
> +     case IP_VERSION(9, 2, 1): /* VEGA12 */
> +     case IP_VERSION(9, 3, 0): /* RENOIR */
> +     case IP_VERSION(9, 4, 0): /* VEGA20 */
> +     case IP_VERSION(9, 4, 1): /* ARCTURUS */
> +     case IP_VERSION(9, 4, 2): /* ALDEBARAN */
> +     case IP_VERSION(10, 3, 1): /* VANGOGH */
> +     case IP_VERSION(10, 3, 3): /* YELLOW_CARP */
> +     case IP_VERSION(10, 1, 3): /* CYAN_SKILLFISH */
> +     case IP_VERSION(10, 1, 10): /* NAVI10 */
> +     case IP_VERSION(10, 1, 2): /* NAVI12 */
> +     case IP_VERSION(10, 1, 1): /* NAVI14 */
> +     case IP_VERSION(10, 3, 0): /* SIENNA_CICHLID */
> +     case IP_VERSION(10, 3, 2): /* NAVY_FLOUNDER */
> +     case IP_VERSION(10, 3, 4): /* DIMGREY_CAVEFISH */
> +     case IP_VERSION(10, 3, 5): /* BEIGE_GOBY */
> +             kfd->device_info.event_interrupt_class =3D
> &event_interrupt_class_v9;
> +             break;
> +     default:
> +             dev_err(kfd_device, "Failed to find gc ip
> blocks(GC_HWIP:0x%x) in %s\n",
> +                             gc_version, __func__);
> +     }
> +}
> +
>  static void kfd_device_info_init(struct kfd_dev *kfd,
>                                bool vf, uint32_t gfx_target_version)  {
>       uint32_t gc_version =3D KFD_GC_VERSION(kfd);
> -     uint32_t sdma_version =3D kfd->adev-
> >ip_versions[SDMA0_HWIP][0];
>       uint32_t asic_type =3D kfd->adev->asic_type;
>
>       kfd->device_info.max_pasid_bits =3D 16;
> @@ -75,16 +136,11 @@ static void kfd_device_info_init(struct kfd_dev
> *kfd,
>       if (KFD_IS_SOC15(kfd)) {
>               kfd->device_info.doorbell_size =3D 8;
>               kfd->device_info.ih_ring_entry_size =3D 8 * sizeof(uint32_t=
);
> -             kfd->device_info.event_interrupt_class =3D
> &event_interrupt_class_v9;
>               kfd->device_info.supports_cwsr =3D true;
>
> -             if ((sdma_version >=3D IP_VERSION(4, 0, 0)  &&
> -                  sdma_version <=3D IP_VERSION(4, 2, 0)) ||
> -                  sdma_version =3D=3D IP_VERSION(5, 2, 1)  ||
> -                  sdma_version =3D=3D IP_VERSION(5, 2, 3))
> -                     kfd->device_info.num_sdma_queues_per_engine =3D
> 2;
> -             else
> -                     kfd->device_info.num_sdma_queues_per_engine =3D
> 8;
> +             kfd_device_info_set_sdma_queue_num(kfd);
> +
> +             kfd_device_info_set_event_interrupt_class(kfd);
>
>               /* Raven */
>               if (gc_version =3D=3D IP_VERSION(9, 1, 0) ||
> --
> 2.17.1


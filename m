Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1189FC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Dec 2021 06:26:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BF1510E239;
	Mon, 20 Dec 2021 06:26:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 235E110E239
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Dec 2021 06:26:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZOG/WrCSkQ0PAnNrU5tYvYGTpajo0RfcbMyi83eyEHUZ/e+C+OIt1y8o3apy7WFmLI8HcITb9y2rzBJ90uRLBxLAilkyrxr/4yDudMM++DFpifYI0ZebF4T9GS/kzIpLEYG96enUiX9BtyHJnJTMkGV7y1JTru+5tUQfJrJsRTepAodt6CxJeZwyFZ1duIbffVzXOP/duEyPVuFiGdGqTLlSSq6KDa6hbqxerhsOiOaLxycyLukmkZJybKJcpc6dL/OS+6x2Q09kZikbz+75b0T2ZHFDKVZPWgAkxdLAdzmenXyM+hGzT7zGZ+LicZrrPA9Wfgow0jVGIEtd93tWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahd92EFglu6Yb7m26o32gkIO9zbo7Mme0bhMH2/67eo=;
 b=EK95mhSV8RoXKiX3wwNexQzFVjrtULRS3Tj3dFBto7cyMsOuT2WLFEhj3wF/QVmicIcbmBJp7sNKy/prSZ2ZDjuPLnPxwfW4tJRPeptMUV0NBlStTfqJLxZ8dOntjkrVP5igarLfs6xHTZfEW3eShDbPpm27MA2/j14A95vzgLrxyHkSExY8gU4/SeGiDDe12OnUGuCGpIFaP/rdcIf3t8JmrtYsZIM6udyZwOKn72nuPFztGhwBmjh+G2L3oHdPqlJ2WTTMXJW1nMum7PPeL+/Ew/vGgxkg3vFvkrfDzSmZ2kchRrTunw8uiDVM2ocWy0Rv4irp1NebwrfpC+rU+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahd92EFglu6Yb7m26o32gkIO9zbo7Mme0bhMH2/67eo=;
 b=JB4mnxLEZIv+yvHVWFN0VHPYhOddjanepR9cZ6rpPsyDtk31UtUjIv6p7k8EBnqpr6VqBCF1EmHmv394Ndgm7NQJHPWZUd91OG0RPLmIourSEaLlkO3gVmyAN06pqJP/PFOfFswlZkN6pOB3TUDnLJ0HRP5lY+nw2ccntDvBnEc=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3689.namprd12.prod.outlook.com (2603:10b6:5:1c7::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.17; Mon, 20 Dec 2021 06:26:33 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 06:26:33 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>, "Kim, Jonathan"
 <Jonathan.Kim@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: correct sdma queue number in kfd device init
 (v2)
Thread-Topic: [PATCH] drm/amdkfd: correct sdma queue number in kfd device init
 (v2)
Thread-Index: AQHX9U737KfzJJVPH0COspFqBXpgvqw63m6AgAAKCICAAAEzEA==
Date: Mon, 20 Dec 2021 06:26:33 +0000
Message-ID: <DM5PR12MB24699666CD82D7C92A1DF37DF17B9@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211220030849.32458-1-guchun.chen@amd.com>
 <DM6PR12MB3163F586AB5EED14E56AA455857B9@DM6PR12MB3163.namprd12.prod.outlook.com>
 <DM6PR12MB3067D18C422AB01AE376DFE98A7B9@DM6PR12MB3067.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3067D18C422AB01AE376DFE98A7B9@DM6PR12MB3067.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-20T06:02:28Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2350a017-1461-4d73-a390-1767873df162;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-20T06:26:29Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: fc39e61e-4d71-426d-99c2-b49eafa330b1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4a19969-4778-41c0-332f-08d9c381aab4
x-ms-traffictypediagnostic: DM6PR12MB3689:EE_
x-microsoft-antispam-prvs: <DM6PR12MB3689C1990499B03C13AF1539F17B9@DM6PR12MB3689.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zc/ETqEq9bUjCU3UD3oc+Mv4PyHHeL4tQ9ZzG0+iFzbo6f2xkRQ6crOaXEmPLHFi0IPlxFym2URmzqzHCgOaHaGDFZ8acOE5NFPC9xYz6Ys1cEqcPOHQeA6NdGblkTUIZap8xK9rjHIGVfXa/pvrBT6Y15xmm2iPZikgqqBkdE5MK4S5Wa/XotD3ev/o8GlDst5BGomCQqu5Np0hnpj27tum2Sc/phG04AC4tTAuwKQ09M/1pRg2MJObigC5F8yVRttftzAS+J5f+Cw4LdMaXMr48CQ4Jg6ALjwL28i6yGueuzM2DXC4RyY370yo03Nkt1l+PBqVPOWo+rsq5k5TlgiiWFxlnxk9plbRUuQFCNeA3p52hrjqQvPGFSzD3R9PmtR4s1kOqCBtNqsMXOYx58uUjsOrYnSDTdiDBwdOWAgZ1ExEitqBTQn/dEXz4q2JpFP6K/9IZ/B7vXDjkw/vzTtIwa1UsXCxddGRcyoRcu3vNdvu2GL57l7Ah+eC6DKm2pxfJRCvFPPpYdbiAQTWWIoh7DSN3U1zuo/3tGnYeSK66CREr42LHqOSHqXq4UAwYcb8e0TVNqZ5JhQArFfh7CHwspzElGZMlDPo0fOZeZ4WmnvXgxuCWfYFBkbYiCWLGpqI5my/IkUPz2RomQ72qFP6ZCUv7ivPZk4XRZ0Gkq7SZiecRpClLmLVg41wL+JFDilEmYbac4LMB9JO+7CV9w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(9686003)(83380400001)(5660300002)(38070700005)(26005)(186003)(53546011)(508600001)(6506007)(8936002)(8676002)(316002)(110136005)(86362001)(55016003)(2906002)(122000001)(7696005)(52536014)(64756008)(66446008)(66556008)(6636002)(66946007)(66476007)(71200400001)(38100700002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rGSw8sDcZ7nKQHPmslAEcsSq9W07/JzG6jqfMOd2XWJ/DZq0AAsVxkJFcye2?=
 =?us-ascii?Q?VYNIe8Go/Hae6gYWrYdfJS/OkjIFr5AM+lxFUYhf6YlVckeioQzeIEYITteS?=
 =?us-ascii?Q?a16rIsfcF1XzxpIo1Y0Wcm7MmtGVwMTONXjErA1BZO9Ndn17lGEa5sAFWqic?=
 =?us-ascii?Q?6QoJczu7VFkotyJzWCJ+tcUpVemZ0ORkK3zvxa8UcM4h9gqSh4HmJfMA+Vh0?=
 =?us-ascii?Q?G0QnIvHVK1UjUa5sjEz0Y2eDc3SVP2CszLFymNfJPQ/0jwBqmdR+XbQkP+du?=
 =?us-ascii?Q?qdxTE+YWvrcpzWD2LNQtM5joVwvmMLvykewPoyeEs42XYJKCfNOB28VvwnoL?=
 =?us-ascii?Q?OVgpz8dS+WPJSEOuYLqrKJMZYKWxKu3VWpARWeJgJ8XR1iYWu4FSVgRFLKaj?=
 =?us-ascii?Q?B5eLNO2Oxpe+Ppx67cWFdfLVRk0xuatD1ABdFde4goH1WKxVRUywuSGUMwDI?=
 =?us-ascii?Q?QDqS0t17XJhniG9xyi4FocLZAiWryi4EOkyW0K5f9zV5Ei/MgMaNBQfx9QSC?=
 =?us-ascii?Q?UTXirjEKd7/BO1lFBixh+2YG+Q8JpXNdIrE7kCLW7m7C+NYl//YpcbjA3a8c?=
 =?us-ascii?Q?mzrvVdbn18ZbdRxYY9oKjVwViEngXFjLMCEHDTqgGfnwYlWiUsi9ElUwY5Lh?=
 =?us-ascii?Q?LSz9l4PvyvVagWIh36n4nKwd3htm9NiMjtht5mh84O7NykRTntqPzYA9DL8Q?=
 =?us-ascii?Q?bi0Y932B+bhzZQbdAu/1yzrLep411Nu5DL2j6z8r0QpvcVKlW48CAZ+KejBX?=
 =?us-ascii?Q?qnF8XIMQwwQTcaXaJ4ZdVrMJvG64YDkG5Nqk18mKuwI6FHZ0sWFs031NLV+G?=
 =?us-ascii?Q?/x1OF9bz896gguyrELMhhxInUultFNUNhism9hL5oXsqnI/BewdYggHR2CjV?=
 =?us-ascii?Q?cD0FaSPUdU6XOdoU3dSjAb1o/0j4OPfg9GX0yeRXq9gwrfHhbB1ntRA5g1bT?=
 =?us-ascii?Q?W8Io6k+AlA386fFRxDY3Hf7VmsSJt/wPDy+9uLjFsE1z4e0kbuAyu4B+ICdn?=
 =?us-ascii?Q?X9tcfEXn3q6WXzGy5rqyehZMyQiS2eilpgj9GugP8CQX+MohsiZ2UvqCroe1?=
 =?us-ascii?Q?uQFnB9hNakG60muEfhUo8hamSfNVjrXoAt8YVNR8vYeLr6cVuAV2eKIZHFan?=
 =?us-ascii?Q?R5EuipbUviSDLWPNbfiWjBV+hNLJKlFeVTm1wCLVPQIJvuq7cpW1GonYf2Mp?=
 =?us-ascii?Q?JUoDcTrujDTkiLedgaP6Pez8YyyjvByf0WX6QZGKbuFCCh4AY9oys+D5A0+D?=
 =?us-ascii?Q?5JOqM+FwM3232V8N+ChdEZxun8craGEkDS1fd5c6xLx/WpOHCN6OECfkNaq2?=
 =?us-ascii?Q?4tD+9iOlSjez1bC1zEiUYjqj4mDsTIjGZxJbE0ug1Zyh5Z7Wb4v7a24sdrgV?=
 =?us-ascii?Q?xoCBM7i/PvQ/JtADrBdUFjNCxYIbunM3lCoOi+vr44GwAH0ba4gx7BsPT/Fl?=
 =?us-ascii?Q?n4BZiN7XxKn6Y+UEc9B1MiU1hi0dvdzlFLUaAf1IDX08kTOoN5gxQcjsMCMF?=
 =?us-ascii?Q?uM/RDIyG6UVZHBGHtHIDYCGkGwokfkJFC0YOvfjjk5Q/R5Z3LDQElRZHOOHK?=
 =?us-ascii?Q?paNn2YgglZOaEctmkoYZykkdvXxR21B3PJwAKKfMkB7RBwvWt5Xv0q23O7dS?=
 =?us-ascii?Q?PPdn/UjuyRYhQUxWk6bl/Vc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a19969-4778-41c0-332f-08d9c381aab4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 06:26:33.0207 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aFbPUM2JgTZtSr+9HVMeOeMFoq7Se/SlYYj3AEk8orqxiXdF/H9ReXCcVWmjs/9Ln2wtPzXZCE9QWK2FYqnKhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3689
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

[Public]

Email crossed:).

Graham, I have sent v3 to review, and will add you as another reviewed-by w=
hen pushing this patch. Thanks for the review from you and Jonathan.

Merry Xmas!

Regards,
Guchun

-----Original Message-----
From: Sider, Graham <Graham.Sider@amd.com>=20
Sent: Monday, December 20, 2021 2:19 PM
To: Kim, Jonathan <Jonathan.Kim@amd.com>; Chen, Guchun <Guchun.Chen@amd.com=
>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd=
.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: correct sdma queue number in kfd device in=
it (v2)

[Public]

> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Monday, December 20, 2021 12:44 AM
> To: Chen, Guchun <Guchun.Chen@amd.com>; amd-=20
> gfx@lists.freedesktop.org; Deucher, Alexander=20
> <Alexander.Deucher@amd.com>; Sider, Graham <Graham.Sider@amd.com>;=20
> Kuehling, Felix <Felix.Kuehling@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: correct sdma queue number in kfd=20
> device init (v2)
>=20
> [AMD Official Use Only]
>=20
> > -----Original Message-----
> > From: Chen, Guchun <Guchun.Chen@amd.com>
> > Sent: December 19, 2021 10:09 PM
> > To: amd-gfx@lists.freedesktop.org; Deucher, Alexander=20
> > <Alexander.Deucher@amd.com>; Sider, Graham
> <Graham.Sider@amd.com>;
> > Kuehling, Felix <Felix.Kuehling@amd.com>; Kim, Jonathan=20
> > <Jonathan.Kim@amd.com>
> > Cc: Chen, Guchun <Guchun.Chen@amd.com>
> > Subject: [PATCH] drm/amdkfd: correct sdma queue number in kfd device=20
> > init (v2)
> >
> > sdma queue number is not correct like on vega20, this patch promises=20
> > the
>=20
> I think you've also fixed Vega12 and Raven (they were being set to 8=20
> before rather than 2).  No need to mention this in your description,=20
> just double checking.
>=20

I believe it was only Vega20 that was being set incorrectly. The condition =
was:

	sdma_version >=3D IP_VERSION(4, 0, 0)  &&
	sdma_version <=3D IP_VERSION(4, 2, 0))

which encapsulates Vega12 and Raven setting sdma_queues_per_engine to 2, bu=
t also accidently encapsulates Vega20.

> > setting keeps the same after code refactor.
> > Additionally, improve code to use switch case to list IP version to=20
> > complete kfd device_info structure filling.
> > This keeps consistency with the IP parse code in amdgpu_discovery.c.
> >
> > v2: use dev_warn for the default switch case;
> >     set default sdma queue per engine(8) and IH handler to v9.
> > (Jonathan)
> >
> > Fixes: a9e2c4dc6cc4("drm/amdkfd: add kfd_device_info_init function")
> > Signed-off-by: Guchun Chen <guchun.chen@amd.com>
>=20
> Other than the missing checks for Raven when setting the interrupt=20
> class (see inline comments and reference kgd2kfd_probe in=20
> kfd_device.c) and one nit-pick inline, this looks good to me.
>=20
> With those fixed, this patch is
> Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>
>=20

Other than Jon's comments, this patch is also

Reviewed-by: Graham Sider <Graham.Sider@amd.com>=20

> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 77
> > ++++++++++++++++++++++---
> >  1 file changed, 68 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > index facc28f58c1f..36406a261203 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > @@ -59,11 +59,75 @@ static void kfd_gtt_sa_fini(struct kfd_dev=20
> > *kfd);
> >
> >  static int kfd_resume(struct kfd_dev *kfd);
> >
> > +static void kfd_device_info_set_sdma_queue_num(struct kfd_dev *kfd)
> {
> > +     uint32_t sdma_version =3D kfd->adev-
> > >ip_versions[SDMA0_HWIP][0];
> > +
> > +     switch (sdma_version) {
>=20
> Please pull in the indentation for all cases to line up with the switch b=
lock.
>=20
> > +             case IP_VERSION(4, 0, 0):/* VEGA10 */
> > +             case IP_VERSION(4, 0, 1):/* VEGA12 */
> > +             case IP_VERSION(4, 1, 0):/* RAVEN */
> > +             case IP_VERSION(4, 1, 1):/* RAVEN */
>=20
> As mentioned, you've also fixed Vega12 & Raven here I presume since=20
> afaik, they're based off Vega10?
>=20
> > +             case IP_VERSION(4, 1, 2):/* RENIOR */
> > +             case IP_VERSION(5, 2, 1):/* VANGOGH */
> > +             case IP_VERSION(5, 2, 3):/* YELLOW_CARP */
> > +                     kfd->device_info.num_sdma_queues_per_engine =3D
> > 2;
> > +                     break;
> > +             case IP_VERSION(4, 2, 0):/* VEGA20 */
> > +             case IP_VERSION(4, 2, 2):/* ARCTUTUS */
> > +             case IP_VERSION(4, 4, 0):/* ALDEBARAN */
> > +             case IP_VERSION(5, 0, 0):/* NAVI10 */
> > +             case IP_VERSION(5, 0, 1):/* CYAN_SKILLFISH */
> > +             case IP_VERSION(5, 0, 2):/* NAVI14 */
> > +             case IP_VERSION(5, 0, 5):/* NAVI12 */
> > +             case IP_VERSION(5, 2, 0):/* SIENNA_CICHLID */
> > +             case IP_VERSION(5, 2, 2):/* NAVY_FLOUDER */
> > +             case IP_VERSION(5, 2, 4):/* DIMGREY_CAVEFISH */
> > +                     kfd->device_info.num_sdma_queues_per_engine =3D
> > 8;
> > +                     break;
> > +             default:
> > +                     dev_warn(kfd_device,
> > +                             "Default sdma queue per engine(8) is=20
> > + set due
> > to "
> > +                             "mismatch of sdma ip
> > block(SDMA_HWIP:0x%x).\n",
> > +                                sdma_version);
> > +                     kfd->device_info.num_sdma_queues_per_engine =3D
> > 8;
> > +     }
> > +}
> > +
> > +static void kfd_device_info_set_event_interrupt_class(struct=20
> > +kfd_dev
> > +*kfd) {
> > +     uint32_t gc_version =3D KFD_GC_VERSION(kfd);
> > +
> > +     switch (gc_version) {
> > +     case IP_VERSION(9, 0, 1): /* VEGA10 */
>=20
> Missing check for case IP_VERSION(9, 1, 0): /* RAVEN */
>=20
> > +     case IP_VERSION(9, 2, 1): /* VEGA12 */
>=20
> Missing check for case IP_VERSION(9, 2, 2): /* RAVEN */
>=20
> Thanks,
>=20
> Jon
>=20
> > +     case IP_VERSION(9, 3, 0): /* RENOIR */
> > +     case IP_VERSION(9, 4, 0): /* VEGA20 */
> > +     case IP_VERSION(9, 4, 1): /* ARCTURUS */
> > +     case IP_VERSION(9, 4, 2): /* ALDEBARAN */
> > +     case IP_VERSION(10, 3, 1): /* VANGOGH */
> > +     case IP_VERSION(10, 3, 3): /* YELLOW_CARP */
> > +     case IP_VERSION(10, 1, 3): /* CYAN_SKILLFISH */
> > +     case IP_VERSION(10, 1, 10): /* NAVI10 */
> > +     case IP_VERSION(10, 1, 2): /* NAVI12 */
> > +     case IP_VERSION(10, 1, 1): /* NAVI14 */
> > +     case IP_VERSION(10, 3, 0): /* SIENNA_CICHLID */
> > +     case IP_VERSION(10, 3, 2): /* NAVY_FLOUNDER */
> > +     case IP_VERSION(10, 3, 4): /* DIMGREY_CAVEFISH */
> > +     case IP_VERSION(10, 3, 5): /* BEIGE_GOBY */
> > +             kfd->device_info.event_interrupt_class =3D
> > &event_interrupt_class_v9;
> > +             break;
> > +     default:
> > +             dev_warn(kfd_device, "v9 event interrupt handler is=20
> > + set due
> > to "
> > +                     "mismatch of gc ip block(GC_HWIP:0x%x).\n",
> > gc_version);
> > +             kfd->device_info.event_interrupt_class =3D
> > &event_interrupt_class_v9;
> > +     }
> > +}
> > +
> >  static void kfd_device_info_init(struct kfd_dev *kfd,
> >                                bool vf, uint32_t gfx_target_version)  {
> >       uint32_t gc_version =3D KFD_GC_VERSION(kfd);
> > -     uint32_t sdma_version =3D kfd->adev-
> > >ip_versions[SDMA0_HWIP][0];
> >       uint32_t asic_type =3D kfd->adev->asic_type;
> >
> >       kfd->device_info.max_pasid_bits =3D 16; @@ -75,16 +139,11 @@=20
> > static void kfd_device_info_init(struct kfd_dev *kfd,
> >       if (KFD_IS_SOC15(kfd)) {
> >               kfd->device_info.doorbell_size =3D 8;
> >               kfd->device_info.ih_ring_entry_size =3D 8 * sizeof(uint32=
_t);
> > -             kfd->device_info.event_interrupt_class =3D
> > &event_interrupt_class_v9;
> >               kfd->device_info.supports_cwsr =3D true;
> >
> > -             if ((sdma_version >=3D IP_VERSION(4, 0, 0)  &&
> > -                  sdma_version <=3D IP_VERSION(4, 2, 0)) ||
> > -                  sdma_version =3D=3D IP_VERSION(5, 2, 1)  ||
> > -                  sdma_version =3D=3D IP_VERSION(5, 2, 3))
> > -                     kfd->device_info.num_sdma_queues_per_engine =3D
> > 2;
> > -             else
> > -                     kfd->device_info.num_sdma_queues_per_engine =3D
> > 8;
> > +             kfd_device_info_set_sdma_queue_num(kfd);
> > +
> > +             kfd_device_info_set_event_interrupt_class(kfd);
> >
> >               /* Raven */
> >               if (gc_version =3D=3D IP_VERSION(9, 1, 0) ||
> > --
> > 2.17.1
>=20

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91479C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Dec 2021 02:45:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D17F910E33F;
	Sat, 18 Dec 2021 02:44:59 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A42810E33F
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Dec 2021 02:44:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBva4z6fY8vBbfTD8l+H+8RbZvrfgESaAuvQP9soPfx+1WC6FYnu+XEmOZKASY684Nm9aj5onKJeP6UB0dZ/FWMy9nrFmN5SNfDOVZlrzMnnrASIoEV/5wYv+78FJ96kTquvGOQ00A7mJRRWmVwDSK8kYFEwyrjck6qIiiH+ZZ4XQxJGUup6dY8r9+7L7VE6kb0cZzs3BBAoRRURgS3E7du2lmJmaf0OEOYHKOKcotNjJ7owlcwzI8rhPIx1r/eonawdPBtFlPDd9tTDiq6RBMMZ+0G0zLpDaleE86Pca2R4+zzkveonFJMtIrlCDjeltXOgQko7lvNHIuZlCUy5mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VGN/QuA46Mxt6pfaXsa+EPJ9Ev7IXIv1V83oLDLcx4=;
 b=e4u+d9yxIz5ND1jmJBtadX+CNLEcV/YYfKWkuIU6aVYTLEoE2nHJEh9Ud+RblTtyuQxnnXSInW+pc/25jdBwSfTKE0g3S6VDOav7wuf/SkdJUN3DuEOUfCPiIa4BdkCH5ONZLut9mmk7xXBSsJN2jqPt8U7XeTFBD6Zu2s+TM+OADEvATHQWwv8oNEAQhalOuFkZM8OxsZUOkhQZlQtE3JXoXHHeJ49TzMoqz6URbEK6i90okD6RE3ENz4rKyvqtDfnfgnGBwzwzh+oWQyTiBml22GbH2n6r9OLewnlYi4JpH0Oq7S9jv5jVh5/DodbllTn03wwl/AjZ+ETHHG+pWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VGN/QuA46Mxt6pfaXsa+EPJ9Ev7IXIv1V83oLDLcx4=;
 b=3bdtP/95Lu8kHkucYL6dZcNplp3VAEDTgoMbXx5zIoyJyU92yBN9bAjpulVtBRjjuJNhON/Mkz67CuHzgGd0QHNbj8k/242tzE2BEpXvFUBhsU621lmVeXY46iQp4Cz3YILwY+4+N9Kq+VClzXW6Uh0soA8z2adUZ3Z/H62VkW8=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3468.namprd12.prod.outlook.com (2603:10b6:5:38::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4801.14; Sat, 18 Dec 2021 02:44:49 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3562:eba5:418b:b43e%5]) with mapi id 15.20.4801.017; Sat, 18 Dec 2021
 02:44:49 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Kim, Jonathan" <Jonathan.Kim@amd.com>, "Sider, Graham"
 <Graham.Sider@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: correct sdma queue number in kfd device init
Thread-Topic: [PATCH] drm/amdkfd: correct sdma queue number in kfd device init
Thread-Index: AQHX81LEZri97TWIr0eq9bW4tqFb1aw2yIQAgAAIGACAALn9EA==
Date: Sat, 18 Dec 2021 02:44:48 +0000
Message-ID: <DM5PR12MB24694B61E8BE9459BD49F942F1799@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211217143106.14140-1-guchun.chen@amd.com>
 <DM6PR12MB3067C46D35A492404F4CBE948A789@DM6PR12MB3067.namprd12.prod.outlook.com>
 <DM6PR12MB3163DC1B1BBED2C0A05A4D9B85789@DM6PR12MB3163.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3163DC1B1BBED2C0A05A4D9B85789@DM6PR12MB3163.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-12-17T14:41:54Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=758dc379-579e-456e-9f71-3fecc3f9eb00;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-18T02:44:45Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 346a4582-b716-49d8-bdb6-649dcf9395ac
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dccf87d3-8895-4376-20f5-08d9c1d05bfc
x-ms-traffictypediagnostic: DM6PR12MB3468:EE_
x-microsoft-antispam-prvs: <DM6PR12MB34684E69DC797ABBE029D397F1799@DM6PR12MB3468.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1WQ3YLMYYRXROB2UCtxe6s2zdfF8NnHUB0Nperx0Rg40kBdgv1FULuR1Y7eTPh1M10Ie1+kDFkKkIV5fKh/9Fni0tQYLkeRlbbx3lLHC5P+2rvZjtoYa/6ia70p+UCP2fvrX4vKATpSc+XlFEzmWOciLrdpMtevCk6+eAgx7G5kfFNkEhoXvMJ+enZfM7oJv0pMyDwVMpm9AaHkhLQZelprbAq7J+vNv1XwVJGMy9vm/AzOwRci75InpcEPJEoROSYiNrJckXtU3t0QkStPjYQGlDHqx90dcUXNRkF9dUOlPtlVMmDv2X6sfcZumwZkmCoi2nwfoM/CDlbgtkJiid/+SdNnHyLKpBEcoMjQCY1AcMN9NtOgOfOj5kaeV3Ol1LfEanVZFjPHdqvoGbFXq5zH2viYFyTM3xNo0uidnsFVS1kFYlAIUCI3SJze/8AsVPWwF5oi8CwGezA7+nNhAC/fPMKIc+WmZ0kQYYyEfd14UOma53VSv8jgbSfdalzCSgUvMmDZn8DSb35cjuB4anAzPn2gJheHykX3eQ8HQYS+jLPGccBCqDp9IsyYEdLNirFSXb2MRTM1QdsZVr02PC7IAqxNfEnGkXMPSlAUHHyZxH9CEtzI8TvYCCeeHYWCPUZzgyD3WFwooQ4t8nOJTtgY8uVcNuizcySWU2g7uc038gH53OUY2kaW1gQasR0mVDvO2eJPVnCrFDYFyQn+aVg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(71200400001)(66556008)(9686003)(33656002)(316002)(52536014)(26005)(86362001)(186003)(8936002)(6636002)(110136005)(38070700005)(66446008)(2906002)(8676002)(7696005)(83380400001)(6506007)(122000001)(508600001)(5660300002)(53546011)(55016003)(66946007)(66476007)(76116006)(38100700002)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qnxky0e2AadVZwcSt8N9wT9ki7YL+656C7if5NuArwH8E+c8soola0BWq98s?=
 =?us-ascii?Q?3hVBFNrHmNcPrMneXRwKntl7+5YCcXvuOGs4q8icXiWRn6S3D8tPiFbjeV21?=
 =?us-ascii?Q?AhkIjnLccLjBpT6akUTTl1w/gHw79rmsoITEKp1G49mLWYLwLEC3YKhaFiSp?=
 =?us-ascii?Q?k4/bq5zN7R0/1i75CCcacrR9+xYMX0AK/Ft59N3QruFccSuesEba6Jou9ss7?=
 =?us-ascii?Q?oWmUbODo/cqhQmWSnuKZK42jckuyUHoxJlVAFtrwNipRuCWKqOIbMraiW/iy?=
 =?us-ascii?Q?F0o4GLnKiww+i/ndrWwLWSp5NrGIzJPKTeHgjgim3OkVkjChZdcc340O39zQ?=
 =?us-ascii?Q?coMghCh5aHs7IAPBZ3WIetJ291PaYgNUysZ1kcQDjiUVRmPi4rCwf8LmRIpx?=
 =?us-ascii?Q?/tl6tPYz48CCH7irKD/RePzBJCpToC8IB/CFvyu1prWGEHSEse5wKJA6hpU0?=
 =?us-ascii?Q?QEagYJ3IaQ3UqdNh5sA7SJaScA7M7gMfrCktMLq5zh/q/p8cN93YhpkURiPW?=
 =?us-ascii?Q?ScTjUrIZq3KoegIyhivKKikyi8v10wAVgom4LGBJjM3QEtHBRGlf+Hofyzgg?=
 =?us-ascii?Q?RJ+u/ETzxGI5jh7Lj7zdQIdLZPcbxhyDRkVuchubHvIbWDSTJ+RH89p5PiTU?=
 =?us-ascii?Q?lOgACtRBAYtgV94CJAdVv3AD89Ej/GUcGTI7MCGvqA5LBITEyN3rpnNR5wK6?=
 =?us-ascii?Q?mfMgbclAN+HgJgN4mT+Ce6wmwEaqr7akO4s+Ui+ALEpoBea2VaB5J95CDIqO?=
 =?us-ascii?Q?Xi4K+saO69GeeB85h6XloCvjZXFGnJBrEQ+eQWO4QUddTVqFrdNXjMDS3Ggo?=
 =?us-ascii?Q?T7O+4NP4GD0ZZUypIow5CjuBm+zn9/h7C6YBM6owLQxSN6XxoI8d5H4i/dY6?=
 =?us-ascii?Q?u5B2GEKGEQhp7w47xdTQWOSYBvMb6EJdifT97AlBEC5b+2jVmxQi1Tqq+l1O?=
 =?us-ascii?Q?zudRVW0OU4zCbwj6W6YlHPqx6SEvPbSUOcky+Zy6RpmJlwzKAo5LM+T8YVgJ?=
 =?us-ascii?Q?osvfSHuWgi4wdvMV8Cq55h/IzDuJnDg4y4Su0uGK7A/s9kt+hagBgUEdosRA?=
 =?us-ascii?Q?GhCj/oAM741TfcD7mcONWvhoLZqFAOuFhsY4QT37K4WOy7vM7/U4OcMCWJVA?=
 =?us-ascii?Q?5xP4K5rMBGq2wYf3i7GNQNdT/2MPljLYAjrPGJjo7sooPjqNUD1xygcvcm0z?=
 =?us-ascii?Q?SQJ1aQfCdqgQ0FlXtxhhJ3QNLoTpRNiTC/mFMLg269SDU/B2o8pHOM9LpdNP?=
 =?us-ascii?Q?nTZo3e1AQex3pIoBi88X7zFXwM/USBKHKpQGzV18B5HZ/B4evRmVbE/VbrDW?=
 =?us-ascii?Q?W7SKLEIwxPGqy0fO3L7oEQFE+WVGN9Lk+pm981bumBB+aSvpJN6v/IgfsxXw?=
 =?us-ascii?Q?fuTNpaQ8lVMydcypIc870D7073Y3Tx9Qna/gzz5XbrGqFU2wSF5Id059mN9w?=
 =?us-ascii?Q?VDUxlXqtwhjTFgpUkjxPz3yrjU4sO7rP/1VI8G4s+vL2ur18/wPlEwRb9Gp2?=
 =?us-ascii?Q?qfa7Cau/O4XNvWI6h4C7Guvu0TVNhJJCGoFBPJqiBTfCftuxB15z9uej3rGx?=
 =?us-ascii?Q?VV94eqDY0I3CeUaMWzY43E+e1kjimxn9Y+6JI/Atv2P9i99Cca/3NvI6py8M?=
 =?us-ascii?Q?Ud43XLTj/oTGCr245SwMSd4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dccf87d3-8895-4376-20f5-08d9c1d05bfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2021 02:44:48.8369 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lFJkIDKsBiz1OeWGeCEmjrrUXDJG64cPW1mNwXr7BjeR64dWJFu6v1n7aBnqO7H+ul5th3VrUC0cG7Z0IdHzuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3468
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

Hi Graham,

My general thought is, from what I observed, IP version does not change in =
a linear variation manner, so moving to switch case may be easier for user =
to decode this. Also, I want to get the code aligned with the IP parse code=
 in amdgpu_discovery.c.

Please correct me if I am wrong.

Regards,
Guchun

-----Original Message-----
From: Kim, Jonathan <Jonathan.Kim@amd.com>=20
Sent: Friday, December 17, 2021 11:35 PM
To: Sider, Graham <Graham.Sider@amd.com>; Chen, Guchun <Guchun.Chen@amd.com=
>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd=
.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: correct sdma queue number in kfd device in=
it



> -----Original Message-----
> From: Sider, Graham <Graham.Sider@amd.com>
> Sent: December 17, 2021 10:06 AM
> To: Chen, Guchun <Guchun.Chen@amd.com>; amd-=20
> gfx@lists.freedesktop.org; Deucher, Alexander=20
> <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;=20
> Kim, Jonathan <Jonathan.Kim@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: correct sdma queue number in kfd=20
> device init
>=20
> [Public]
>=20
> > -----Original Message-----
> > From: Chen, Guchun <Guchun.Chen@amd.com>
> > Sent: Friday, December 17, 2021 9:31 AM
> > To: amd-gfx@lists.freedesktop.org; Deucher, Alexander=20
> > <Alexander.Deucher@amd.com>; Sider, Graham
> <Graham.Sider@amd.com>;
> > Kuehling, Felix <Felix.Kuehling@amd.com>; Kim, Jonathan=20
> > <Jonathan.Kim@amd.com>
> > Cc: Chen, Guchun <Guchun.Chen@amd.com>
> > Subject: [PATCH] drm/amdkfd: correct sdma queue number in kfd device=20
> > init
> >
> > sdma queue number is not correct like on vega20, this patch promises=20
> > the setting keeps the same after code refactor.
> > Additionally, improve code to use switch case to list IP version to=20
> > complete kfd device_info structure filling.
> > This keeps consistency with the IP parse code in amdgpu_discovery.c.
> >
> > Fixes: a9e2c4dc6cc4("drm/amdkfd: add kfd_device_info_init function")
> > Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 74
> > ++++++++++++++++++++++---
> >  1 file changed, 65 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > index facc28f58c1f..e50bf992f298 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > @@ -59,11 +59,72 @@ static void kfd_gtt_sa_fini(struct kfd_dev=20
> > *kfd);
> >
> >  static int kfd_resume(struct kfd_dev *kfd);
> >
> > +static void kfd_device_info_set_sdma_queue_num(struct kfd_dev *kfd)
> {
> > +	uint32_t sdma_version =3D kfd->adev-
> >ip_versions[SDMA0_HWIP][0];
> > +
> > +	switch (sdma_version) {
> > +		case IP_VERSION(4, 0, 0):/* VEGA10 */
> > +		case IP_VERSION(4, 0, 1):/* VEGA12 */
> > +		case IP_VERSION(4, 1, 0):/* RAVEN */
> > +		case IP_VERSION(4, 1, 1):/* RAVEN */
> > +		case IP_VERSION(4, 1, 2):/* RENIOR */
> > +		case IP_VERSION(5, 2, 1):/* VANGOGH */
> > +		case IP_VERSION(5, 2, 3):/* YELLOW_CARP */
> > +			kfd->device_info.num_sdma_queues_per_engine =3D
> > 2;
> > +			break;
> > +		case IP_VERSION(4, 2, 0):/* VEGA20 */
>=20
> Thanks for spotting this Guchun. My previous patch should have used a "<"
> instead of a "<=3D" on IP_VERSION(4, 2, 0).
>=20
> > +		case IP_VERSION(4, 2, 2):/* ARCTUTUS */
> > +		case IP_VERSION(4, 4, 0):/* ALDEBARAN */
> > +		case IP_VERSION(5, 0, 0):/* NAVI10 */
> > +		case IP_VERSION(5, 0, 1):/* CYAN_SKILLFISH */
> > +		case IP_VERSION(5, 0, 2):/* NAVI14 */
> > +		case IP_VERSION(5, 0, 5):/* NAVI12 */
> > +		case IP_VERSION(5, 2, 0):/* SIENNA_CICHLID */
> > +		case IP_VERSION(5, 2, 2):/* NAVY_FLOUDER */
> > +		case IP_VERSION(5, 2, 4):/* DIMGREY_CAVEFISH */
> > +			kfd->device_info.num_sdma_queues_per_engine =3D
> > 8;
> > +			break;
> > +		default:
> > +			dev_err(kfd_device,
> > +				"Failed to find sdma ip
> > blocks(SDMA_HWIP:0x%x) in %s\n",
> > +                                sdma_version, __func__);
> > +	}
> > +}
> > +
> > +static void kfd_device_info_set_event_interrupt_class(struct=20
> > +kfd_dev
> > +*kfd) {
> > +	uint32_t gc_version =3D KFD_GC_VERSION(kfd);
> > +
> > +	switch (gc_version) {
> > +	case IP_VERSION(9, 0, 1): /* VEGA10 */
> > +	case IP_VERSION(9, 2, 1): /* VEGA12 */
> > +	case IP_VERSION(9, 3, 0): /* RENOIR */
> > +	case IP_VERSION(9, 4, 0): /* VEGA20 */
> > +	case IP_VERSION(9, 4, 1): /* ARCTURUS */
> > +	case IP_VERSION(9, 4, 2): /* ALDEBARAN */
> > +	case IP_VERSION(10, 3, 1): /* VANGOGH */
> > +	case IP_VERSION(10, 3, 3): /* YELLOW_CARP */
> > +	case IP_VERSION(10, 1, 3): /* CYAN_SKILLFISH */
> > +	case IP_VERSION(10, 1, 10): /* NAVI10 */
> > +	case IP_VERSION(10, 1, 2): /* NAVI12 */
> > +	case IP_VERSION(10, 1, 1): /* NAVI14 */
> > +	case IP_VERSION(10, 3, 0): /* SIENNA_CICHLID */
> > +	case IP_VERSION(10, 3, 2): /* NAVY_FLOUNDER */
> > +	case IP_VERSION(10, 3, 4): /* DIMGREY_CAVEFISH */
> > +	case IP_VERSION(10, 3, 5): /* BEIGE_GOBY */
> > +		kfd->device_info.event_interrupt_class =3D
> > &event_interrupt_class_v9;
> > +		break;
> > +	default:
> > +		dev_err(kfd_device, "Failed to find gc ip
> > blocks(GC_HWIP:0x%x) in %s\n",
> > +				gc_version, __func__);
> > +	}
> > +}
>=20
> I understand the appeal of moving to a switch for the SDMA queue num=20
> above since its setting isn't very linear w.r.t. the SDMA versioning.=20
> That said I don't know if I understand moving to a switch for the=20
> event interrupt class here. To clarify, originally when I set all=20
> SOC15 to event_interrupt_class_v9 it was to follow what was in the=20
> device_info structs in drm-staging-next at that time--that said if the=20
> plan is in a following patch to change this such that gfx10 are set to=20
> to event_interrupt_class_v10, what's the reasoning not to format it along=
 the lines of:
>=20
> if (gc_version >=3D IP_VERSION(10, 1, 1)
> 	kfd->device_info.event_interrupt_class =3D &event_interrupt_class_v10;=20
> else
> 	kfd->device_info.event_interrupt_class =3D &event_interrupt_class_v9;
>=20
> (Assuming this is done in the SOC15 case, and of course cases would=20
> need to be added here eventually for e.g. event_interrupt_class_v11,=20
> but not necessarily for every asic).

Explicit hard checks with a non-assignment on default might have advantages=
 by not allowing the KFD to proceed to load for unregistered devices or for=
ce developers to assign the correct interrupt class without making assumpti=
ons.
But that means more maintenance and additional handling on non-assignment c=
ases to fail gracefully.

Thanks,

Jon=20

>=20
> Best,
> Graham
>=20
> > +
> >  static void kfd_device_info_init(struct kfd_dev *kfd,
> >  				 bool vf, uint32_t gfx_target_version)  {
> >  	uint32_t gc_version =3D KFD_GC_VERSION(kfd);
> > -	uint32_t sdma_version =3D kfd->adev-
> >ip_versions[SDMA0_HWIP][0];
> >  	uint32_t asic_type =3D kfd->adev->asic_type;
> >
> >  	kfd->device_info.max_pasid_bits =3D 16; @@ -75,16 +136,11 @@
> static
> > void kfd_device_info_init(struct kfd_dev *kfd,
> >  	if (KFD_IS_SOC15(kfd)) {
> >  		kfd->device_info.doorbell_size =3D 8;
> >  		kfd->device_info.ih_ring_entry_size =3D 8 * sizeof(uint32_t);
> > -		kfd->device_info.event_interrupt_class =3D
> > &event_interrupt_class_v9;
> >  		kfd->device_info.supports_cwsr =3D true;
> >
> > -		if ((sdma_version >=3D IP_VERSION(4, 0, 0)  &&
> > -		     sdma_version <=3D IP_VERSION(4, 2, 0)) ||
> > -		     sdma_version =3D=3D IP_VERSION(5, 2, 1)  ||
> > -		     sdma_version =3D=3D IP_VERSION(5, 2, 3))
> > -			kfd->device_info.num_sdma_queues_per_engine =3D
> > 2;
> > -		else
> > -			kfd->device_info.num_sdma_queues_per_engine =3D
> > 8;
> > +		kfd_device_info_set_sdma_queue_num(kfd);
> > +
> > +		kfd_device_info_set_event_interrupt_class(kfd);
> >
> >  		/* Raven */
> >  		if (gc_version =3D=3D IP_VERSION(9, 1, 0) ||
> > --
> > 2.17.1

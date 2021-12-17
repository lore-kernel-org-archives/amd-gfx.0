Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5C9C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 15:05:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DFFD112A67;
	Fri, 17 Dec 2021 15:05:55 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5769112A67
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 15:05:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDb7Wm/zDkRhi/JDeVRCs0ls8vLWAZccfYDGRIFyAF3ied0x1D6T2Z/JpY7Br3py69ltEGJTwV65u6eC/8UuvNRWS7EP+re1d10jKU+81oYKarKpmyQooT+ijJIr/R0AKG8evTH13CqN6kYuhhP3gnDucz2XLw4DiHNXaz8VE0lY/t8RSMacVPN+lGMyeEt1XtVCUfRm3/Mwr/Jfq+TO2XAzwkgZuH7WlIbs0uRjclgeDx1mCEtjT7fB0gGg5RXdJkGVhytJoJs6hRyyVyXNkOaVpXMVANxyj6ZrTdpHWQg7Hsfh9z3qfEh/7CzudJC0NMU8kgoFOVwPwu24WQ1dAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4foQJPSMZ36IaWzi11DFC0rkZMBPZodtoDpm0ghRHno=;
 b=Oc7kTzEgDH55Kl/TjhJa9Yw6Dfc2yUICkgkcmPrVFMzAqT6t1qdxKvUTFnX3hr1ugxZXpV5C0/TKWIyLLLSBTKLU4urFLg7CVyADeFhFb0bucyMiiH/8ZVt4VKVZxKM1Od/E8yU7CfIwJu0+pmMDRv3IDKNvzayVRhAten4SNqPE5yO3Wg3ei5KnaIUxWAx6VZGcOWHyhH0TtxzqlMjdrjYKgdE4CHuKigwjcKBiTyeMgnN3O9Z33sNnP0LEh3n9mDRCMPWHt8j/2dvQQAxKNKvF8wdkDPEkLr1W+mH2BbWm+pH7puqmeT4snn7ce9ZvsKbXHRinPSqag55kWhoArQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4foQJPSMZ36IaWzi11DFC0rkZMBPZodtoDpm0ghRHno=;
 b=jH94ZOFGOBbqXYlRXBiEtAWYx55BF9AQCYFqTNOEJUNbvoPHvD6k0GNm4/PLauld60oAg8Ww5bm/y7Bec26eqtvtbKHlAmQpaskNy8Ep3opKGKoTE0j4WPkeqOkE75FEqjRW3/8OUW5VuPqnEYzqARTXuiHfgusEPinwSLJHeVI=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by DM6PR12MB4975.namprd12.prod.outlook.com (2603:10b6:5:1bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Fri, 17 Dec
 2021 15:05:52 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::cc36:3d1a:7e4f:154b]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::cc36:3d1a:7e4f:154b%7]) with mapi id 15.20.4778.019; Fri, 17 Dec 2021
 15:05:52 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Kim, Jonathan" <Jonathan.Kim@amd.com>
Subject: RE: [PATCH] drm/amdkfd: correct sdma queue number in kfd device init
Thread-Topic: [PATCH] drm/amdkfd: correct sdma queue number in kfd device init
Thread-Index: AQHX81LEf4zICDNhDU+iDRIhYXlHTqw2wdAQ
Date: Fri, 17 Dec 2021 15:05:52 +0000
Message-ID: <DM6PR12MB3067C46D35A492404F4CBE948A789@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20211217143106.14140-1-guchun.chen@amd.com>
In-Reply-To: <20211217143106.14140-1-guchun.chen@amd.com>
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
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-12-17T15:05:50Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 25da3f7d-4d77-4300-9324-8c64869097d8
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d50ceae-9013-4449-975c-08d9c16eb81b
x-ms-traffictypediagnostic: DM6PR12MB4975:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4975CF7374F59517D2AF39F78A789@DM6PR12MB4975.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ozcgHvFY3c0HzfkTaotErH+UL9C4H/b1gx1Oqe+QyIyTGd5ro7T0fF2NNRGLJ0xpl+IVcUjuejXMVUjiaprKZLJjFRvgKJ7B+qqGFe032dXBPrvQLCZDrd3USV9dEGicDLNjbI5Koep/FE0FTFCOaY40vCHDqm9MZCGqkHoKAAAVpcem3NZoLIyfa8rWKpiZf14Gm3CD/cHhB2J76+NNwXYgikIJ0fitzzP9JM2QfBf21kYOO+gx0ftFyhsVj7fo67Qgq5cVe+q9HXF0j2rEZVq9Uh2ZPXcYalhE1jJfmhUXu0mVffaNIcqvM//f1eArTHTcMw25loFISMLBYcDDNYRAC6iJn3PnzGnds1N0YylSLbB3PLrCFeuOJbjrKjrd49VpGUa1njEY1T+GXu0kDDcilzqWsLhbrXkahOuezGr/nFY883qbkAHrWDNPMXUjAu106FtZxsKq8mp6FILloHNuWsNTLtvgVIEzyZHPDg2dAIGO+eCGIUPZOysTBMSRvQPivr87pHGVTbAb4QbVynvO4N+c4Gv5mA8sGXiQh6+Ye8Yo+3xZwjeO1uL9neQJ0vdnT2bGWwSiwVmeba5Psnl50E9QlTAqPI4L6SF2J4M/6HW1Gmv1SFd8ch0WfVEnn21JcKFhw92ZY/HluflgUPfr/57xfUdbJwkB3W4GrMFGTLpDoBQC4zmSNxFBnpOfcPqk2+y+3iT3MOfKFyLqDw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(55016003)(8676002)(6636002)(86362001)(8936002)(508600001)(33656002)(6506007)(38070700005)(64756008)(5660300002)(7696005)(71200400001)(2906002)(66446008)(26005)(76116006)(110136005)(52536014)(83380400001)(66476007)(53546011)(186003)(122000001)(9686003)(66556008)(316002)(38100700002)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bmMeZ1ud0eD9I0Akjyve15PzHH1VUU1K/+yDMEogArMIjZ7Zi135CjUh9eL/?=
 =?us-ascii?Q?SQwpIuT3tF1X3qxhzAr+ADgfmSX/qLVA6CKp/lYQg6m7Dli8ro47f6GhbnZh?=
 =?us-ascii?Q?wn3LDdMfw7aPFcSZr0zZTsKRBAxYzQokz7TrgsgwCQdBwaF329dg72lHILRr?=
 =?us-ascii?Q?r85fBmMwYjJ3ehXLGn+jEOcN2jgkbCd4iqpGfYgtlVRA+UgkYiJyRrR9VYu8?=
 =?us-ascii?Q?hPTQYbKudZiXnKX+4DYjq82t0IPB7VGAFQ+kP1uToC8mLIVUF2SuVTJ3ehIs?=
 =?us-ascii?Q?tceH6SXq9kh42MOK7BCAyFMA84bwkt7/vkIY90VZTjZ9jBs8QxloUic1PPcm?=
 =?us-ascii?Q?xuW3e1rUFlInpT6l0jrjOjvSsKfBM5QBs5VJBR0+MafxjN9jAE2WPx2nGvG+?=
 =?us-ascii?Q?elJuiU0zAP3GUozuT/Nk7D5breyyXlDHjZVGQ86homR2WZmmA2fR4IoaEt2I?=
 =?us-ascii?Q?dBgokQF8BuQVpRN1KWA+dQo5OBUjx3vQYEzyGnefzDapyU3XxjkNVJBFA7DC?=
 =?us-ascii?Q?CTQ1OcsQlsLwCnqcjkGwhAc1EqES6Bvrwvud5CU+zgY2r+TdnXtK2MTKlbyr?=
 =?us-ascii?Q?PkG1MXZ7xObp1ZOvLuJbK0UqrOZIeXqnWfbiV43MprhvKsSpy35bKzFNK5BU?=
 =?us-ascii?Q?s9ZnIKeh5U9toREoAyWZLPhvU9Lz/w2ioLin+KL+dj+DOEykU0wICInE5Ubq?=
 =?us-ascii?Q?Ae+V+ZG6ye45sUI22byJIKICJgbcJTYFKCyOc3BSuk9ogATGjKlqEE9fG509?=
 =?us-ascii?Q?OIA0T5xhYlrgbGkveHo9SCIhXwCWvb9NcGcY70QNAwMclUApDSIg3XVtopsL?=
 =?us-ascii?Q?Qk9sevnntXz0sPbnBtLu4S3h9f/fGX40QxRiZYY4xrZ10ZHuVWLTsORHYCZb?=
 =?us-ascii?Q?EOhFURXyW/WsXMB65U0MjvmppCR2wRbvEZrakIRRExlCqiWnxsvz3Upeqxok?=
 =?us-ascii?Q?5B82VbQ4KjqxbWcYzAchRqDlu6tr+jepM0pdTDO/hIy4d3CkYZeil1aFevtP?=
 =?us-ascii?Q?CCLo44CLqrhQRSl78C7t8wtH0dAGMHq8UGWibU/zMJ2c8AEfc6ln8B9zzSxN?=
 =?us-ascii?Q?Vco8tbrA7iS7vmo86CIEf0BK+OQSdnVs4wZxrmvUIWq3LZbLKVutRsToq1nX?=
 =?us-ascii?Q?HEOfClD3YhoPDp9AHYPMFzxEiDqHkuMj6wvZqfkJbPttzez4Bje2cLoNaMif?=
 =?us-ascii?Q?4YSpAayyTkd0PRdYcDHk86UNjSu5mAn9KvNsdotb2iKvNqcTCt4ElRYXRAEF?=
 =?us-ascii?Q?Sc14kXssTkVi+0Dx7wWQ4BMk5ao2ba0yz4HmulamGWaKdsL1ivoeHRfdbF+t?=
 =?us-ascii?Q?59x5iRIMffk0Ee/4Syop+dRNtzO43gi+2rU5n8stDw3y2FT/76ihS7oq+BCH?=
 =?us-ascii?Q?EvQ9Fd9tuIS09D5vl4zNhJfM21M4uZl4TXnSR9RDrbSobMpoRkgPWnk8c8LB?=
 =?us-ascii?Q?70xOksHl00FDtOGcQQANzlXiopAeSkp7KpsJ3OlbWucQEABiPki3L+dJbSnJ?=
 =?us-ascii?Q?qiGj/l4/tIOlpmSAof22WhpRqstZmEbA9mnQmsBayysG8HnsyX6SyilubJr7?=
 =?us-ascii?Q?/J5LNZS1tCSWcUtUTLK2nI1jGLQZwFw6WEAv3ivoe/wHMvaxPRv7fp8IZLA3?=
 =?us-ascii?Q?5tKUjw3MKzceJ4EveIedgwM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d50ceae-9013-4449-975c-08d9c16eb81b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 15:05:52.7905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mBVLGYQ8YtDN/zWsquHPbhmFDM77akW6omBJe62gQUH2JdXx8VjIB1J3hoynjAQOTWkbygjsXkyyyNeFAjuG2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4975
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

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Friday, December 17, 2021 9:31 AM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Sider, Graham
> <Graham.Sider@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
> Kim, Jonathan <Jonathan.Kim@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amdkfd: correct sdma queue number in kfd device init
>=20
> sdma queue number is not correct like on vega20, this patch promises the
> setting keeps the same after code refactor.
> Additionally, improve code to use switch case to list IP version to compl=
ete
> kfd device_info structure filling.
> This keeps consistency with the IP parse code in amdgpu_discovery.c.
>=20
> Fixes: a9e2c4dc6cc4("drm/amdkfd: add kfd_device_info_init function")
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 74
> ++++++++++++++++++++++---
>  1 file changed, 65 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index facc28f58c1f..e50bf992f298 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -59,11 +59,72 @@ static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
>=20
>  static int kfd_resume(struct kfd_dev *kfd);
>=20
> +static void kfd_device_info_set_sdma_queue_num(struct kfd_dev *kfd) {
> +	uint32_t sdma_version =3D kfd->adev->ip_versions[SDMA0_HWIP][0];
> +
> +	switch (sdma_version) {
> +		case IP_VERSION(4, 0, 0):/* VEGA10 */
> +		case IP_VERSION(4, 0, 1):/* VEGA12 */
> +		case IP_VERSION(4, 1, 0):/* RAVEN */
> +		case IP_VERSION(4, 1, 1):/* RAVEN */
> +		case IP_VERSION(4, 1, 2):/* RENIOR */
> +		case IP_VERSION(5, 2, 1):/* VANGOGH */
> +		case IP_VERSION(5, 2, 3):/* YELLOW_CARP */
> +			kfd->device_info.num_sdma_queues_per_engine =3D
> 2;
> +			break;
> +		case IP_VERSION(4, 2, 0):/* VEGA20 */

Thanks for spotting this Guchun. My previous patch should have used a "<" i=
nstead of a "<=3D" on IP_VERSION(4, 2, 0).

> +		case IP_VERSION(4, 2, 2):/* ARCTUTUS */
> +		case IP_VERSION(4, 4, 0):/* ALDEBARAN */
> +		case IP_VERSION(5, 0, 0):/* NAVI10 */
> +		case IP_VERSION(5, 0, 1):/* CYAN_SKILLFISH */
> +		case IP_VERSION(5, 0, 2):/* NAVI14 */
> +		case IP_VERSION(5, 0, 5):/* NAVI12 */
> +		case IP_VERSION(5, 2, 0):/* SIENNA_CICHLID */
> +		case IP_VERSION(5, 2, 2):/* NAVY_FLOUDER */
> +		case IP_VERSION(5, 2, 4):/* DIMGREY_CAVEFISH */
> +			kfd->device_info.num_sdma_queues_per_engine =3D
> 8;
> +			break;
> +		default:
> +			dev_err(kfd_device,
> +				"Failed to find sdma ip
> blocks(SDMA_HWIP:0x%x) in %s\n",
> +                                sdma_version, __func__);
> +	}
> +}
> +
> +static void kfd_device_info_set_event_interrupt_class(struct kfd_dev
> +*kfd) {
> +	uint32_t gc_version =3D KFD_GC_VERSION(kfd);
> +
> +	switch (gc_version) {
> +	case IP_VERSION(9, 0, 1): /* VEGA10 */
> +	case IP_VERSION(9, 2, 1): /* VEGA12 */
> +	case IP_VERSION(9, 3, 0): /* RENOIR */
> +	case IP_VERSION(9, 4, 0): /* VEGA20 */
> +	case IP_VERSION(9, 4, 1): /* ARCTURUS */
> +	case IP_VERSION(9, 4, 2): /* ALDEBARAN */
> +	case IP_VERSION(10, 3, 1): /* VANGOGH */
> +	case IP_VERSION(10, 3, 3): /* YELLOW_CARP */
> +	case IP_VERSION(10, 1, 3): /* CYAN_SKILLFISH */
> +	case IP_VERSION(10, 1, 10): /* NAVI10 */
> +	case IP_VERSION(10, 1, 2): /* NAVI12 */
> +	case IP_VERSION(10, 1, 1): /* NAVI14 */
> +	case IP_VERSION(10, 3, 0): /* SIENNA_CICHLID */
> +	case IP_VERSION(10, 3, 2): /* NAVY_FLOUNDER */
> +	case IP_VERSION(10, 3, 4): /* DIMGREY_CAVEFISH */
> +	case IP_VERSION(10, 3, 5): /* BEIGE_GOBY */
> +		kfd->device_info.event_interrupt_class =3D
> &event_interrupt_class_v9;
> +		break;
> +	default:
> +		dev_err(kfd_device, "Failed to find gc ip
> blocks(GC_HWIP:0x%x) in %s\n",
> +				gc_version, __func__);
> +	}
> +}

I understand the appeal of moving to a switch for the SDMA queue num above =
since its setting isn't very linear w.r.t. the SDMA versioning. That said I=
 don't know if I understand moving to a switch for the event interrupt clas=
s here. To clarify, originally when I set all SOC15 to event_interrupt_clas=
s_v9 it was to follow what was in the device_info structs in drm-staging-ne=
xt at that time--that said if the plan is in a following patch to change th=
is such that gfx10 are set to to event_interrupt_class_v10, what's the reas=
oning not to format it along the lines of:

if (gc_version >=3D IP_VERSION(10, 1, 1)
	kfd->device_info.event_interrupt_class =3D &event_interrupt_class_v10;
else
	kfd->device_info.event_interrupt_class =3D &event_interrupt_class_v9;

(Assuming this is done in the SOC15 case, and of course cases would need to=
 be added here eventually for e.g. event_interrupt_class_v11, but not neces=
sarily for every asic).

Best,
Graham

> +
>  static void kfd_device_info_init(struct kfd_dev *kfd,
>  				 bool vf, uint32_t gfx_target_version)  {
>  	uint32_t gc_version =3D KFD_GC_VERSION(kfd);
> -	uint32_t sdma_version =3D kfd->adev->ip_versions[SDMA0_HWIP][0];
>  	uint32_t asic_type =3D kfd->adev->asic_type;
>=20
>  	kfd->device_info.max_pasid_bits =3D 16;
> @@ -75,16 +136,11 @@ static void kfd_device_info_init(struct kfd_dev *kfd=
,
>  	if (KFD_IS_SOC15(kfd)) {
>  		kfd->device_info.doorbell_size =3D 8;
>  		kfd->device_info.ih_ring_entry_size =3D 8 * sizeof(uint32_t);
> -		kfd->device_info.event_interrupt_class =3D
> &event_interrupt_class_v9;
>  		kfd->device_info.supports_cwsr =3D true;
>=20
> -		if ((sdma_version >=3D IP_VERSION(4, 0, 0)  &&
> -		     sdma_version <=3D IP_VERSION(4, 2, 0)) ||
> -		     sdma_version =3D=3D IP_VERSION(5, 2, 1)  ||
> -		     sdma_version =3D=3D IP_VERSION(5, 2, 3))
> -			kfd->device_info.num_sdma_queues_per_engine =3D
> 2;
> -		else
> -			kfd->device_info.num_sdma_queues_per_engine =3D
> 8;
> +		kfd_device_info_set_sdma_queue_num(kfd);
> +
> +		kfd_device_info_set_event_interrupt_class(kfd);
>=20
>  		/* Raven */
>  		if (gc_version =3D=3D IP_VERSION(9, 1, 0) ||
> --
> 2.17.1

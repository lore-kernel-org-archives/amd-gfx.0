Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEEEC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Dec 2021 15:34:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABBA410EB7B;
	Fri, 17 Dec 2021 15:34:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2620310EB7B
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Dec 2021 15:34:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KcsNrNyNSSthHrUZkk5+gTiyukvQzPTKZl0pa6rqzlAjN/VJPDXj6Ct+limKxPoSo7jxaFenutdS9Jf0r6vqYcQGExXZeA1nWLdmnYCOL6scf34HxdygtkhUFqe2BSMj3DNGE/EH3MfDw6qal1+OIvYWMfghq7g1ciwBWCFkT6FJHsrD9xRGrI4aGnwl4mlVDbzK8Ox4debbTCDB4+0z1lZFLtATdxOKtFZdixSrWD/czb40Q4wcPaRlCRTHY8mb0gD3hohe1X2cZkKAy6O5FjUJSCUtplm+Ly9QKRUuc8RKkfWg7G/80FzJ+y8cUNJqkR4xs4CS2SMSf9ZPsQ3uEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvQ/ECgA0lUiKtM1dHQAqS0wU9R15ItCXTYHOqKTvqA=;
 b=hkWOBab0EWoxDo7NtyC+aH/ScvNMBexxpA9bRjW/zFR4sBpDzqjBVAa4M1Q/ggxVpL3O0Agjlt28xHqhFmhmjtsLXxr52taiY6jXHL3BtT4aCqFv0Rl/12Zf6Po4Se5O6D8bincx3wMoMAZaIaE0Bd7+6pM6bGTEeleI6C7p7ismFRkIzxhcxnVixNI1ZDNLGfyN2AuUlT7Kvn6sc9ZGRlHTtgzoOAP/aVKbtEKoKJTKNv0VHxHeLHNyMNYAgNZoWhfT/Jq5n6ZJOvbxGZK4sTqr8MM3+jBWNNCmpR+R6ZCmSTa0Je59cUUBjYjB0cXNduziI+wXJsc7aLSzc3vNkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvQ/ECgA0lUiKtM1dHQAqS0wU9R15ItCXTYHOqKTvqA=;
 b=5HEu69LqEZUQxGQcdGEtY24FbUkxguqdxFW9kJzrKHsrgxLAZ2qklfM2GvhtCW7pNCLafEnH32t8DzpgYVNTStlCaykZGVFQ3/vJnsj58k0Ccfz2yVSkfTe6qikLUKn3OWI3hYZRcvZX9AyaskDobFJLvZX+XleAoiUzX+QBNco=
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM6PR12MB2698.namprd12.prod.outlook.com (2603:10b6:5:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 15:34:51 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::60ca:d581:a3ac:43bb]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::60ca:d581:a3ac:43bb%4]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 15:34:51 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>, "Chen, Guchun"
 <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: correct sdma queue number in kfd device init
Thread-Topic: [PATCH] drm/amdkfd: correct sdma queue number in kfd device init
Thread-Index: AQHX81LER4hIH3BxJEKLXk5oVL4kcqw2yIQAgAAEIJA=
Date: Fri, 17 Dec 2021 15:34:50 +0000
Message-ID: <DM6PR12MB3163DC1B1BBED2C0A05A4D9B85789@DM6PR12MB3163.namprd12.prod.outlook.com>
References: <20211217143106.14140-1-guchun.chen@amd.com>
 <DM6PR12MB3067C46D35A492404F4CBE948A789@DM6PR12MB3067.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3067C46D35A492404F4CBE948A789@DM6PR12MB3067.namprd12.prod.outlook.com>
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
x-bromium-msgid: a566adfe-ff25-47d6-8cd1-6ea10a9a9726
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc28f041-750a-497d-6584-08d9c172c43e
x-ms-traffictypediagnostic: DM6PR12MB2698:EE_
x-microsoft-antispam-prvs: <DM6PR12MB2698ADA7A64B1F4A71331A1F85789@DM6PR12MB2698.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B+rVtT6eKnwlCwSZL6GIqSwgfULUOxdXUesBttFr8+snXzz2Rg9ErcM12WdImBvTMBHTsPuZ4GS4hrDWNwpZuq9vfcoEgTyleg1hxvebTnj6yHxRx5RUizsTLMXklUu5UJDGor16BREyoGjpXQqZs5I5NAnO2k+n2/xH5joJOfv9J7PBEteK/53mbvQz3BJFwx9BQ9my8K4u1MowpU9IKhKDWHWEzwxECbG7MLxHamCvOxcqDoDTdXICdgNcpySSL/tGKg+f+KkN5IR9xkZr8h3KyDB38NOAkMjQuu4wXOG0fvipQ5z6jUgZpdmTj65yOHV1TY6KVUBHQwYHOzpEIqJVJ4VXOrFvB9Mg0knNE56Q1Xd+HCYQWIlN6F1c+xOQpfEHAWvdMHqiJTbLovwqS0cH5Hsq8fIhof+C6ueLAAbU0Qh20VCmFqiMYA7Jy7GEHz+M1Y99w7pXy8j1icgPGDOgfROolRsdTLRPHYiMYsK2BLaID4ZHARIe1AVcui95ywWklLz8QAIOlCQK51jTMBdBIky/HCV/xCLVG5TtEuofXsWY/Y9Y9WeIG8YI0BKN0tVp/ZEML7zbVGDUCZvNDxTm0HXKSrEFY3uYsMOG2KwYnplvxarCPrlK6/iZhVapuGykiqpYHfCMUlZtzvJBON9NlkE/MBAfg4PZyiPPfW6dKE/eyEGiugw7GLVW0PacqRUcelVHhoYqnD/y+L9Hkw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3163.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(52536014)(110136005)(71200400001)(76116006)(64756008)(7696005)(6506007)(9686003)(53546011)(8676002)(2906002)(86362001)(122000001)(8936002)(38100700002)(66446008)(26005)(5660300002)(508600001)(38070700005)(66476007)(6636002)(83380400001)(33656002)(55016003)(66946007)(66556008)(186003)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gw9TFzWEsuOnDUUtPHMSBv4GRKZ7xHxLnXlrznQ8mBqRudo+sr14uIvu+tBT?=
 =?us-ascii?Q?+eL3zOPZh5LeLy9aJDiiGnAz8XmYsegIDO43G3BixFrsGu6Us5MRSy3fU2+e?=
 =?us-ascii?Q?bSLTmp9D65b0DEUb3Guk2BTb6JxViit437LM6X4eAUNShH7+nKMK+MgG0WYL?=
 =?us-ascii?Q?Ng9XItONdXJoCM3HYZAsa3OZmNyVr3VIhFmpLBtzhZzZja4buyI8/UVKDuUo?=
 =?us-ascii?Q?jMnE0E+NqxnYqJVKUjr6+kP9HVw4LZsUkE+QZSQ+sJFcDsDxp73zTVI09ZZ6?=
 =?us-ascii?Q?doSNLCLCEUL3qOJLxYUzaAiJ0or02EnUgVisivX6ExrBolsFJA396YFICW9J?=
 =?us-ascii?Q?EzWK/fy+KEivdqU4uKxgBufV2DuYOSI/cTT8x1JuB61TUimu/+kYfZ6lxBxs?=
 =?us-ascii?Q?yQXGkwkhBdzazyh7xX46Ozddep0mOZqlVZq5DI5C6RdHJTn5QKkCwxcy46JX?=
 =?us-ascii?Q?kb8dVhhudH+8BTS6Zer3TxbH4svj4g7OCRGdYqZgT4eqJHSbMJH4U/tc1hb3?=
 =?us-ascii?Q?oQaPkhftb2M7hrM8Z8Uv6HSWnp1akd02BIJ3P+8f8ru6TrqmAg1JdSDbPB7B?=
 =?us-ascii?Q?AeXg0yH3E3USLb/eFjyfavEJ+rbOJmxBtn07KQlGAjxNVvHMi+BmAk/7Om9x?=
 =?us-ascii?Q?LmwWVD6uQhS5Q0WHN+SJ5am3IvOJOnBOJ8tyZZdOFGlEzG+/PkCy4Jor7A9J?=
 =?us-ascii?Q?+JB6UE9m7bLP2y7LD6vDUYIMXdrYKKJktTRxT4oKIandLPPMxZCrhCMDaQ/L?=
 =?us-ascii?Q?EvzvPXP2c53XYRPSsykMnm6DOiGXvSvCbAs4o76Rk9F30GLARPbTHcfth9tq?=
 =?us-ascii?Q?euk3ezEE7Yak1RqXKt5XK54re00ung1201Ym3aqO5J9qujcJ4L5DRaDX6Unz?=
 =?us-ascii?Q?KYkrbdiLAYcpsum0hV3OuMy8RMpjiQHBJKHuQCpltSIXQP5Ljggq0SrfbDhx?=
 =?us-ascii?Q?1y3fWlkB3ueMWZPYEOmA7c5UReRPB99292NdpPbfFi4K6VlKXntddX2/ZQG3?=
 =?us-ascii?Q?Nc35vtufrVKHfgRFb8tfW4S8jVJlAwRDJQOOc86Zvrg8LRNIXiUAMSL26ktA?=
 =?us-ascii?Q?1tlhmo2ve+50btdCM9PV/pf1ccF7gy8RtbFjxoGyZQAyFfpiEIlLUKsmiId9?=
 =?us-ascii?Q?Et1GMs9r8e1sFTD0wcpO6kIeiIL0UItAZaIWEdtB4RR46HZuJtvxCCmOYcGc?=
 =?us-ascii?Q?Q8eRE44x4X3LVumR0d9coZjAOL7OcR6ihrm0uSS9doHxASlN0rvHIfVdIjUj?=
 =?us-ascii?Q?u/yyPdPButyggmb4skmrfGkjU7lPFXlKF/FLshrDEhWaTX3wAkUIfc8HtgyK?=
 =?us-ascii?Q?GNgoqi/XvaE2hmtiSQDo1l6DGe3DeYdNoSj8ULIIROpupN7ClO0ogMgMLgnb?=
 =?us-ascii?Q?y5XZ8NBXq8oGRdXfKK8YzNcWu4RTylpqvO4zH4bhBMa/+Io1Zhi/Dr1ttBzr?=
 =?us-ascii?Q?r3aa6c/wXDtfFQm8P8KRC2ry28nGEIlMGz7dlqsrpjBYX0LYyEVCxaDz/3lo?=
 =?us-ascii?Q?v5ZUSJlamK94qh/faWTkcoz9VRSGGKGYzxT5amaXE5GTI2iNSx0LePqLPVx8?=
 =?us-ascii?Q?qC9B273ckn4wa3CoeTU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc28f041-750a-497d-6584-08d9c172c43e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2021 15:34:51.0460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xDNOl7bd4ecY6FCU9EWK9YTVPpN4Y9EilTwZu+iJvzF8aTjqLKV6mVWNYoh2eH32
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2698
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



> -----Original Message-----
> From: Sider, Graham <Graham.Sider@amd.com>
> Sent: December 17, 2021 10:06 AM
> To: Chen, Guchun <Guchun.Chen@amd.com>; amd-
> gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: correct sdma queue number in kfd
> device init
>=20
> [Public]
>=20
> > -----Original Message-----
> > From: Chen, Guchun <Guchun.Chen@amd.com>
> > Sent: Friday, December 17, 2021 9:31 AM
> > To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Sider, Graham
> <Graham.Sider@amd.com>;
> > Kuehling, Felix <Felix.Kuehling@amd.com>; Kim, Jonathan
> > <Jonathan.Kim@amd.com>
> > Cc: Chen, Guchun <Guchun.Chen@amd.com>
> > Subject: [PATCH] drm/amdkfd: correct sdma queue number in kfd device
> > init
> >
> > sdma queue number is not correct like on vega20, this patch promises
> > the setting keeps the same after code refactor.
> > Additionally, improve code to use switch case to list IP version to
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
> > @@ -59,11 +59,72 @@ static void kfd_gtt_sa_fini(struct kfd_dev *kfd);
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
> > +static void kfd_device_info_set_event_interrupt_class(struct kfd_dev
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
> I understand the appeal of moving to a switch for the SDMA queue num
> above since its setting isn't very linear w.r.t. the SDMA versioning. Tha=
t said
> I don't know if I understand moving to a switch for the event interrupt c=
lass
> here. To clarify, originally when I set all SOC15 to event_interrupt_clas=
s_v9
> it was to follow what was in the device_info structs in drm-staging-next =
at
> that time--that said if the plan is in a following patch to change this s=
uch
> that gfx10 are set to to event_interrupt_class_v10, what's the reasoning
> not to format it along the lines of:
>=20
> if (gc_version >=3D IP_VERSION(10, 1, 1)
> 	kfd->device_info.event_interrupt_class =3D
> &event_interrupt_class_v10; else
> 	kfd->device_info.event_interrupt_class =3D
> &event_interrupt_class_v9;
>=20
> (Assuming this is done in the SOC15 case, and of course cases would need
> to be added here eventually for e.g. event_interrupt_class_v11, but not
> necessarily for every asic).

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

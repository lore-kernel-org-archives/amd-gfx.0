Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86850C6FA8E
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 15:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4D7F10E6E8;
	Mon, 26 Sep 2022 15:43:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AD7510E6E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 15:43:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJIx2M8NqMBfwE+HVZSkRuQt629nOnMXXDZrzRzcQWrvUnqymPdIXHeikPuYZHpEcUxZ3Eb5/16b8li+Rg02kqx5ekJeGTcIguqco8V+4tblOrIMwPQ520VPzqnhY3AFGFXkVlXeeaD14blhTZ4k8GtDcdfRluZPhBYaImqno9+JZEh0Pf6X5bNU+iGdVMdc6lYDgq+tk1Jo+Z1i6szv1etMKFa6js7grMi7rx8Eu8sHw6YZbXBnFDEk7hD4zW05+yVk7L1h9tV7PcjVF/n34aePfFPXknPG7jar40qiLkae3vP2Jgl6WU3uSxLOO++ypcOi/YjRLWv2n3btS1UnOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MuiDnIlvKc+qLpTRRwyDs7oF7nW0/6VQeolrrHqhBMw=;
 b=Zn29zqbcLfkpzJ8FyRab4pb/tg2RxD0tr5oNNVowVB16dqo+ST7wt2q8p/y40d5y5PffAKQk6odBxyBqpG/Qv3pGTFErhb82Z6I9G9QE4VZc0qjWXgU4la2DMmVophIs+K396zWkvWRehispwnbzb/6vgJPuhsXge4C7FOC53vF/FQTnkpR9o8DTUlktlE3jooVB0O7S2PJzbZDE81NzALn0uJeduHU4K6h3JM9/OOIALKv04aYkCDDOtaNkd+N19c618MERjhFEQiFFHRx/qNb7qs4lFZqjBwNsHa+50mNtg5W9vPNUkRvi4oNZgdjh7WOxCCfeBBRoxc6Gz2njUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MuiDnIlvKc+qLpTRRwyDs7oF7nW0/6VQeolrrHqhBMw=;
 b=PoHSz3BED8f0UmO8/uRBgdTsQvlIrqfisTa4c/uGDI4nEMgdBDyNXz9R/72s/lcMyThqJHUUXYcdxG+3VRw0ex6nOFxw2FOyQdK5xm51DpZFItn3CcO2BjN63a1xdIP1Gftz03l6qA821Pqj+7XBj2bJlLcM7W0fpOb9LlIyxxQ=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 15:43:20 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::3c76:8e77:b067:49ea]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::3c76:8e77:b067:49ea%5]) with mapi id 15.20.5654.022; Mon, 26 Sep 2022
 15:43:20 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Fix UBSAN shift-out-of-bounds warning
Thread-Topic: [PATCH] drm/amdkfd: Fix UBSAN shift-out-of-bounds warning
Thread-Index: AQHYzgnAt2RnlLvVA0yI3Yvap/Ofva3x10+w
Date: Mon, 26 Sep 2022 15:43:20 +0000
Message-ID: <DM6PR12MB3067F40CBF77101101E524B68A529@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20220921222951.677177-1-Felix.Kuehling@amd.com>
In-Reply-To: <20220921222951.677177-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-26T15:43:17Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9bb61515-48e3-42d7-bba5-deab060458d2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-09-26T15:43:18Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 29128c50-91d1-457f-8c6e-e74cfc27ce52
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3067:EE_|MN2PR12MB4406:EE_
x-ms-office365-filtering-correlation-id: 9d4a9ecb-e26c-4085-630f-08da9fd5d699
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p5qw+tD7k3bFIDwDn1QNdRGIKJ0/fJAii/Nip0qRYeXBvazoNv6gKWUni70fApQAZsr/4LlZs9+lOiMcr4lHPmqE1YHXN6RICuRPUlBjUmpzVx6VwNDOklD3H//vIxFktbWDtMpvkXK0WsFsiFAQTOzvjHq/6Q9NNGCi6Alz8zfrj5NYhqZ9GAYuxwDd1n3xdKSbYHaan6kqz3QAbA4SSGvEtBEIgmdkG1WbAfFd2mB9TDQZ/uY6x0/n8gNpZoUVwRPvZaW9uIPO23LUCigDuC4k78pDPE/v+vdI4TQixC8Si7H93zxImQ31ToRzbGqSBr+1oa+bKZ/UM/Fmyj2Om9t5Sdg772a8yR+so7Eok17IwzKMZaF3AKuMjqMH+7bA9Y/iCqR78L2bhQS8UQm1OlvnIUv9jpYGvpw7SXa7kvciLzqiwqqE1Sg/iA5jHlR96VOYwKvxzw7MKnpUPUpjoIxb+wl7JVXdbORH9fCeXKSzXWCZ/TlhACgilRIGUAOvU3IdDsAX1Vds59w9TOgpcAjo25+4JR0il1m+CzBNBZE9f6/vX0hEkxk7B3lBjQ68lNygjGmFmnwYkBibN8TJrqF8+8I2PZgUeKQ5nPZlfM6+8HULAnXLoyyP9vIF8LknyMgm6kNzSDa2eD/N9efu8Cid8XYVNjaitH+mUyZP1/6MuhyuTVi4taDt5KKr1mG+N4qtnTK9M0PjfVOEa59AvZDxctj0yN/GqJYwCpwJj05l6qmRz0+ql/7y7Ukbp6mW8K4UjHFbgA3dTPQfDiCh7Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199015)(26005)(52536014)(6506007)(7696005)(8936002)(5660300002)(41300700001)(53546011)(33656002)(83380400001)(9686003)(122000001)(186003)(38070700005)(2906002)(55016003)(38100700002)(110136005)(316002)(71200400001)(4326008)(8676002)(76116006)(66446008)(66946007)(66556008)(64756008)(66476007)(478600001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y2OVKPrQmC0gGj2CMaXBUJQwvwngNVszRdj+FUPUjZDzDaNwP5ONtN9EWRYk?=
 =?us-ascii?Q?4JawrT6cYw0ZXkt5kc71XTy6vbPRk8APMJXccrtmbX0hmnebV64hT7pejXmt?=
 =?us-ascii?Q?H089QvIlnWTofiXjcYMnJem0wT54piscPK9OEQ0s5UAOIBd5/OMEV0s06A+D?=
 =?us-ascii?Q?6pV+UvxkLLoa1wQBvuL/7ggXYwguet2EpKcRGcaSuYc/a+uzix4LVwcdj0Bf?=
 =?us-ascii?Q?EJPzxaHlx78zI4yv25EG+enMcrW8GCN9pvzsxC0MH6HXq17WZEhh1FhC2sU3?=
 =?us-ascii?Q?jDjhrWIEEWAr2U/COcaUzd8Un19wxd9Pv400cjVQbpaoZo8+OnDv4Pb4Q8ja?=
 =?us-ascii?Q?SK2HEEI25yvGRz1ZVT5PzLhhVSG786uOGyk2cuwYkBQG/2E7u2ZOBJW3m4a2?=
 =?us-ascii?Q?yAx3h/99pJ0j36YfFBVm1rRA38+I0X6C40KpVhSbPfoOqWSxWh+zs5BpwccE?=
 =?us-ascii?Q?j4r3wRARjjqln/ioQfnXpco3oEJBGkqRxYXK89zqFR9pa9XhsQ1AFUYjh2bd?=
 =?us-ascii?Q?kPQyXZAQQIAtA3nQroe9UkaKC02/RvU/0HkrrizZLQO2Wbuhm1gOLAgriVKs?=
 =?us-ascii?Q?yL+8ylz157ROGPwmSYnHkKvkqteA80hlcQ/zR/7Bloh/IjsXUH4q5ppLm49X?=
 =?us-ascii?Q?QxEh6XU81bglZctH5dotTB+7aUbucFvoOphHqVkJ7+TB7yHJFcgjwYA10XfA?=
 =?us-ascii?Q?XbI8/FBju8+6uNL6D0r4s8BpHpiUj6C0QltWchYijZTS6CSEswhkIytGJ2Ik?=
 =?us-ascii?Q?W1apo3OUSPef8V8Ttl9+Q3WI+wNRAra4IXfaPPbltUyeTvwBRrT/FQpIJcR2?=
 =?us-ascii?Q?/6R7T1CoXCSDLqchIEZAtR+skLuq2okB8YPYBQanmd5BSp3enk3haGaAUD/+?=
 =?us-ascii?Q?Mw+oxajFetf6r/iXl4ywTBU91VsdtBl+vt+IqXSTXeh5jQgO5SW0Te9ykRBv?=
 =?us-ascii?Q?PXzIrAbvPhy1eEF+GI1ClWTy/yivY3wTcC70e0Jkj/2BLQnszwdUtRp/hZ/U?=
 =?us-ascii?Q?l0zMMgHVRHL0yYj7hz4WTo9xqxlxN2hDcO54++Yr5NL/JRvN1LXgYjLhlVhj?=
 =?us-ascii?Q?XLkxyqg3Bk9XMTMniUhj1jpg31WHSa3ubnr5gOEvk+AMaAuw5JXg15iqCBYz?=
 =?us-ascii?Q?BCU/cr9cbQHh//obaDhezpF5BCrfj7+3+3NqCNY8T/mJA0RP3/AEuw07Hb1V?=
 =?us-ascii?Q?kn4aJnqA9debIGwZg/jfR3d90u556H1Ll05vExpfhKHsS/OFxAKNz8QMkB5/?=
 =?us-ascii?Q?IzmNOg97Yf1wsUZTE6RMR/gqSGTe0ogm1B821E9K0JljFyir96yfzVmdPgSC?=
 =?us-ascii?Q?Iihiya1NmQN2I4eabPAKl4DeqADaaMC8ps+s5wBpBwIHE0KOPtvq3cAy9QMO?=
 =?us-ascii?Q?/xeHZYGxFAhky+d3nxrp9F2OwmsgF5FWhF6qOmNL2Dlg+3QEPrAlCKUWzI+6?=
 =?us-ascii?Q?mx+pf6YP2yMDEA9iap3pqr0mdpWMoA0vtcACWD6vUngl65pc2Mm1cE9Ggcc2?=
 =?us-ascii?Q?ePzE7vMOk+AkX3vJPJ2WokSQOEWZmCMrOmcJ6WnHOG3qKXBwUSVKfwZ4TOol?=
 =?us-ascii?Q?d8nJ8G7idfuOyDSmvyE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4a9ecb-e26c-4085-630f-08da9fd5d699
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2022 15:43:20.3261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QEwA5MaT+hA601BtBu8kxI/dDBxp8sqe1o+tIrUeroeJZGEaTO5Vz98HMFGTq6Bay2PESnuFHCPGFFOVWv6sdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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
Cc: Ellis Michael <ellis@ellismichael.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix
> Kuehling
> Sent: Wednesday, September 21, 2022 6:30 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Ellis Michael <ellis@ellismichael.com>
> Subject: [PATCH] drm/amdkfd: Fix UBSAN shift-out-of-bounds warning
>=20
> Caution: This message originated from an External Source. Use proper
> caution when opening attachments, clicking links, or responding.
>=20
>=20
> This was fixed in initialize_cpsch before, but not in initialize_nocpsch.
> Factor sdma bitmap initialization into a helper function to apply the cor=
rect
> implementation in both cases without duplicating it.
>=20
> Reported-by: Ellis Michael <ellis@ellismichael.com>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 41 ++++++++----------
> -
>  1 file changed, 17 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index e83725a28106..f88ec6a11ad2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1240,6 +1240,20 @@ static void init_interrupts(struct
> device_queue_manager *dqm)
>                         dqm->dev->kfd2kgd->init_interrupts(dqm->dev->adev=
, i);  }
>=20
> +static void init_sdma_bitmaps(struct device_queue_manager *dqm) {
> +       uint64_t num_sdma_queues =3D get_num_sdma_queues(dqm);
> +       uint64_t num_xgmi_sdma_queues =3D
> get_num_xgmi_sdma_queues(dqm);
> +
> +       if (num_sdma_queues)
> +               dqm->sdma_bitmap =3D GENMASK_ULL(num_sdma_queues-1, 0);
> +       if (num_xgmi_sdma_queues)
> +               dqm->xgmi_sdma_bitmap =3D
> + GENMASK_ULL(num_xgmi_sdma_queues-1, 0);

I think we still want a safeguard here in case we ever get into a situation=
 where num_sdma_queues is > 64. Otherwise we could hit an unsigned wraparou=
nd (in __GENMASK_ULL: (~ULL(0) >> (BITS_PER_LONG_LONG - 1 - (h)))) --> woul=
d cause a wrap plus shift > width of type warning if h > 63).

Something along the lines of

dqm->sdma_bitmap =3D GENMASK_ULL(min(num_sdma_queues, BITS_PER_LONG_LONG) -=
 1, 0);

Could work as a safeguard. Same for xgmi_sdma_bitmap.

Best,
Graham

> +
> +       dqm->sdma_bitmap &=3D ~get_reserved_sdma_queues_bitmap(dqm);
> +       pr_info("sdma_bitmap: %llx\n", dqm->sdma_bitmap); }
> +
>  static int initialize_nocpsch(struct device_queue_manager *dqm)  {
>         int pipe, queue;
> @@ -1268,11 +1282,7 @@ static int initialize_nocpsch(struct
> device_queue_manager *dqm)
>=20
>         memset(dqm->vmid_pasid, 0, sizeof(dqm->vmid_pasid));
>=20
> -       dqm->sdma_bitmap =3D ~0ULL >> (64 - get_num_sdma_queues(dqm));
> -       dqm->sdma_bitmap &=3D ~(get_reserved_sdma_queues_bitmap(dqm));
> -       pr_info("sdma_bitmap: %llx\n", dqm->sdma_bitmap);
> -
> -       dqm->xgmi_sdma_bitmap =3D ~0ULL >> (64 -
> get_num_xgmi_sdma_queues(dqm));
> +       init_sdma_bitmaps(dqm);
>=20
>         return 0;
>  }
> @@ -1450,9 +1460,6 @@ static int set_sched_resources(struct
> device_queue_manager *dqm)
>=20
>  static int initialize_cpsch(struct device_queue_manager *dqm)  {
> -       uint64_t num_sdma_queues;
> -       uint64_t num_xgmi_sdma_queues;
> -
>         pr_debug("num of pipes: %d\n", get_pipes_per_mec(dqm));
>=20
>         mutex_init(&dqm->lock_hidden);
> @@ -1461,24 +1468,10 @@ static int initialize_cpsch(struct
> device_queue_manager *dqm)
>         dqm->active_cp_queue_count =3D 0;
>         dqm->gws_queue_count =3D 0;
>         dqm->active_runlist =3D false;
> -
> -       num_sdma_queues =3D get_num_sdma_queues(dqm);
> -       if (num_sdma_queues >=3D BITS_PER_TYPE(dqm->sdma_bitmap))
> -               dqm->sdma_bitmap =3D ULLONG_MAX;
> -       else
> -               dqm->sdma_bitmap =3D (BIT_ULL(num_sdma_queues) - 1);
> -
> -       dqm->sdma_bitmap &=3D ~(get_reserved_sdma_queues_bitmap(dqm));
> -       pr_info("sdma_bitmap: %llx\n", dqm->sdma_bitmap);
> -
> -       num_xgmi_sdma_queues =3D get_num_xgmi_sdma_queues(dqm);
> -       if (num_xgmi_sdma_queues >=3D BITS_PER_TYPE(dqm-
> >xgmi_sdma_bitmap))
> -               dqm->xgmi_sdma_bitmap =3D ULLONG_MAX;
> -       else
> -               dqm->xgmi_sdma_bitmap =3D (BIT_ULL(num_xgmi_sdma_queues) =
-
> 1);
> -
>         INIT_WORK(&dqm->hw_exception_work, kfd_process_hw_exception);
>=20
> +       init_sdma_bitmaps(dqm);
> +
>         return 0;
>  }
>=20
> --
> 2.32.0

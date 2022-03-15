Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E54C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 07:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A8DB10E3D7;
	Tue, 15 Mar 2022 07:41:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D056910E3D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 07:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xq8TShui9SPW6ec497pKL3Pyb+SRC4dciA6xWk8kblEpqcqFu0y05ZLRKJkbDHX9YYzf0RrZ1hXRPo2C/qIYCJKTEKDdISvFApO3pVr+j5UcrqB6jFdUGVWOpiO9uPZFW3GuYGE+mkbpEZqzf3h1CcTbQNJgnRg0tMuBaulHzzZ0Y8liHvZmLrnWWcoQNJR2ytBt9soY9Kv8tpo3qM6RR6qv7DMsGiK/a/b/YB8d6K5z+YiTrtljH/eWJtm3aYpbzsf5o0Bgw18SV3KCdcoPIsS1DGtrv0EhHQ1mSTgrLn+WIbpN1xj6n810jhTpVkiXr15WxgFSMt7FFLXg3OpaOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEzlkRY/WawvsP0SQk+waNh93GTnR+OfAV1aHqVbZts=;
 b=CfNDitFHkJw5VV2QX/iPiODLwz1R99H5G6GMKDLckKm3icc3E3lrmp7Gv/KJ6ovyDwFVxQwR5koYHIcdQU2nQiZX89uUlKn4O77UjM3KH2y+dGzrQ0zkVhXRMKcHk/NRBVFdcxB5IYBnt+wxCNYMJauxgB+ACMLlrkb3iBoA/724HG3Gk/zRkUZYJzOC/Ff06Ff9GTZLEneQ1IkEyGrZa8CQooI008uijBuFu1srMCPZvcE343swWdysnjqTCmWw+31ywcbCz5J1Akb2BlCc1PKf+61zJlHCZDmNufHGqKbr8fm0tar+XjH4Co1rb4MrH3BqsTwePDjGGvlzibAQag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEzlkRY/WawvsP0SQk+waNh93GTnR+OfAV1aHqVbZts=;
 b=1+gczGoQtk8Ox6mUbAORA2eGHcBvxlAxPQLhWrJ01OB9/wCkOhKn7pn50WxUdv14YjqAMpT0KoF+uBkegNPPsLgfbwPntLJqRxQT4b+Gf5CTpsJC1KJzM0l1S8XoK6IFQ78wpShH+ncLrB9A7EnBvN7WDVjc2meutMxy+NPQSS8=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM5PR12MB2375.namprd12.prod.outlook.com (2603:10b6:4:b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Tue, 15 Mar
 2022 07:41:12 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 07:41:12 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [PATCH 3/3] drm/amdkfd: add RAS poison consumption support for
 utcl2
Thread-Topic: [PATCH 3/3] drm/amdkfd: add RAS poison consumption support for
 utcl2
Thread-Index: AQHYN3Gnmh0rVuZ5PUyC0L/FY4MrH6y+sL6AgAAJnQCAAVWAEA==
Date: Tue, 15 Mar 2022 07:41:12 +0000
Message-ID: <DM5PR12MB1770413895E8DB535673E461B0109@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220314070326.21828-1-tao.zhou1@amd.com>
 <20220314070326.21828-3-tao.zhou1@amd.com>
 <BN9PR12MB525751E2894B86B3E75ECDE0FC0F9@BN9PR12MB5257.namprd12.prod.outlook.com>
 <BN9PR12MB52579143201064C23BA153E4FC0F9@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52579143201064C23BA153E4FC0F9@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-14T10:39:41Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=67cd1c3a-c2f2-4376-b25c-6a09633070c5;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-15T07:41:09Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: fe767199-644a-4047-b972-ce16895c55b2
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 047358e7-fda6-49eb-dc12-08da06572dbc
x-ms-traffictypediagnostic: DM5PR12MB2375:EE_
x-microsoft-antispam-prvs: <DM5PR12MB237539E6E51C91F37E65F4C8B0109@DM5PR12MB2375.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xb/pMRvegPI2gdTLv7CagijYwzXVRrq6I+lKpbcpmIi0+1NVcOPIZEZcR9EEOQoCOoBPFY5JRCj32e8edwRa1k6oaoidE/6eW29iXlPJl2eKwrm42Hy1oc8kLsZ/E0h1d3gMt9Cd2uV1172oXQ4CPij5kRFvatpSkvmR36xLyTw2PSrBbw49oK749P56kRbvvXYhxKzyt3FmhJGVXMcyEfqTGxqiMzyGyAlfRi3H5b3crmxgEOxJGIOEt+V8p21YsNe4RwT539G3DaokXYTz6j9eMjPgkHivz4Zm0XjYAqABskMxNSH9qI/xQ3WAY/Y/fkpiysW+0M+C5q6it0iOTHQw/CJ9xQtm7K3SguoD7kkWIAT9M5pmZWf4TbX0SqUUd5nK39Yoto42u5ZywVyhReXQFWXUrayjE5vAdixIJMZGxQEXTb2Y7bh0MnfZrJZg9u/emJ6xiEBR7dIhRrkipZshRDSM7DGWTwuy4DZza1kck9VWfSQnYfa+wQQ6e6nrN2PaurChxe+59sVtBVWCvQcvCin6zpRxSQFnbJ42MepQG9Fpes6HZnUwmM+8gf+LeVDaO3rZhb3jBwf1a64NmWUe3dbivp1EVk5foLA0qkKTld9EIVDeuiP4dJ3YdxV5GM62mdKvWr6o7N0r0FqECgd88JBYK6E5Grd5NvMFMT5QUNmdPmTobv8VGSJtVeOehZ34q9OcbIT5DUAHp0MpeA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(122000001)(38100700002)(38070700005)(2906002)(186003)(71200400001)(26005)(9686003)(7696005)(53546011)(508600001)(6506007)(110136005)(33656002)(5660300002)(8936002)(64756008)(52536014)(55016003)(8676002)(316002)(86362001)(66556008)(66946007)(66446008)(66476007)(83380400001)(6636002)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cuQMCTMALDKa+26Q85HcYTkBCORqfYSRFV4evtTy7ONdAZMUkNLBNjKNdmvG?=
 =?us-ascii?Q?bmSGKR+bF04OARyKSqYTjAVdHU1jZGzFcwT/qfqwQxaXbhS5h7JmG2qCrOC/?=
 =?us-ascii?Q?8QLMWszTPVvZbTh25fGrX1l21TpzwyrPbTBjFHcz73e73pui7mRVUL5XeaZo?=
 =?us-ascii?Q?Sr9aO0zX6SkEqR5F3tfGOOvd/J44SBvcjhOxSmgxU5Nt081p+u5OskdstCVu?=
 =?us-ascii?Q?6dp8XNrEo0VphtRr219Y4xpX2hHWJBz4d/IGORIJ2gCTYRU3m6o0cLA0SK1x?=
 =?us-ascii?Q?mWubX/ay34c2iJnFR3p0kHDvwcvl9TZmBF9ZhuTDJJN9OJu7aeb/D/Rhq2hK?=
 =?us-ascii?Q?ZO9jsvR5DykvtJqXTLeBSDGmfBe6LOtlVUK1+un9Oni/wQqpZPiBr/HqSzEH?=
 =?us-ascii?Q?KkQSzPxYyYob9RyJX7tBE1Yzx5/Ba9Fv+Kw6EeDuBqdsalNF0+kTp/0f9vIJ?=
 =?us-ascii?Q?CFSi0Ikp7Y6bDjqu3a6r4vrrEDxHWtKnTBN3HrZ4FxGBX9Hqid9NjKyHicDQ?=
 =?us-ascii?Q?3PzXVTk0BZRR4AzrjmXkmYDFtlUy96IuDBlBN0er6iiY22aFTH8BLlugDsj2?=
 =?us-ascii?Q?eQ2VfR2jEfv+c/s81OYJA3vTWk532/6JsnAjwyuUosJrJofcoDVha3Lp5uEo?=
 =?us-ascii?Q?DU3CvKY9uAqgoDsatKQ4qt8cNADyrsNU2ll+3r7AiP4wnww2Uo+N5q+f9NtV?=
 =?us-ascii?Q?/P4Vhfbb7Fvp6Qb7DcRmHGvqNTt8qGQYf+PUKJtpkgavPrek1Qj8+N6xcZvM?=
 =?us-ascii?Q?V7e4ZGHgRQlkFRjbqDES1yVkIA89fjXLPiLM7mJw4q3RyzAfPZzL5r4ND+b6?=
 =?us-ascii?Q?8jxDLDWSx8DYaMPtpafZuT4IqDVX0nTHjRPrElHrLvWtEvYzpaDfYNT0rNfr?=
 =?us-ascii?Q?62n86l8m+dICUaZshsGN7pLEoyZ2BsQstHwfnxTG8ByRO7QQ9XfHXJa6xLcz?=
 =?us-ascii?Q?MoDnDU0H1qnD5+zr4kMTxlxsLNtyTdWZ0ytXDNkVSOs70t0Xx94jaNVQobVB?=
 =?us-ascii?Q?1lCEcVs6ZZwJo9owgwKz7lCs2936MH2019d+jqcc6iWxnUmZpAGkc2N2f19l?=
 =?us-ascii?Q?qx4m0hUs5p9P1HYnwHq/YVYqrGivUcW9XE6CudnJFB84Z+cbt9WOrGhSstNQ?=
 =?us-ascii?Q?VOPTgGrt5BoickC1SK+tHwbSxKxQyypIO+qqu9wI6SSFo3tvQjMu1vWriM7v?=
 =?us-ascii?Q?x/yECI0xn2kxQm+fOuIAlGq9R3zYnpDO2Lzhedq0iLV0nRGCwlNod6nn3GpM?=
 =?us-ascii?Q?SPQ3JxqDgM2B3YxyIOTv50dkfZAa1m94E7DwPmZynOOB0O9PXF0+f08gFRjN?=
 =?us-ascii?Q?foVo1VvBKGlBczOn92TjzqQM6LsF841ffUVrTkaUo4ivx0bT/+2vsAC2GOTM?=
 =?us-ascii?Q?ynLbqOzYEZrKb12Turo+KM9Iw09RLdRCYgMe3qcSg4szJC+wsyALJWFOKVz2?=
 =?us-ascii?Q?RS/6ikSHRfbv/cgN/+mxKhKkScnl2E1a?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 047358e7-fda6-49eb-dc12-08da06572dbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 07:41:12.3901 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5xLkaoSUFXhYbma7lCaCHxtJzuHd1FGBt4kS8VHcDUHmf5Am5HaDE0Y8DxeGBOmh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2375
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



> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Monday, March 14, 2022 7:14 PM
> To: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; Yang, Stanley
> <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Kuehling,
> Felix <Felix.Kuehling@amd.com>
> Subject: RE: [PATCH 3/3] drm/amdkfd: add RAS poison consumption support f=
or
> utcl2
>=20
> Never mind Tao. I guess you just want to leverage client_id to differenti=
ate
> sdma int source from the default, right? Then might consider to explicitl=
y call out
> the UTCL2_FAULT source.
>=20
> Regards,
> Hawking

[Tao] we only define client id for UTCL2, no related source id definition i=
n our code (the id number is 1 per my experiment), I'll add the definition.

>=20
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang,
> Hawking
> Sent: Monday, March 14, 2022 18:40
> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; Yang,
> Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>;
> Kuehling, Felix <Felix.Kuehling@amd.com>
> Subject: RE: [PATCH 3/3] drm/amdkfd: add RAS poison consumption support f=
or
> utcl2
>=20
> [AMD Official Use Only]
>=20
> Copy Felix
>=20
> @@ -119,10 +121,14 @@ static void
> event_interrupt_poison_consumption(struct kfd_dev *dev,
>  		break;
>  	case SOC15_INTSRC_SDMA_ECC:
>  	default:
> +		if (client_id =3D=3D SOC15_IH_CLIENTID_UTCL2)
> +			ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
>  		break;
>  	}
>=20
> This will break SDMA - We haven't enabled optimized poison consumption
> handling for sdma yet.
>=20
> I'd suggest we explicitly call out the interrupt source id UTCL2_FAULT as=
 a case,
> even it is the same as VM_FAULT. And it should be fine to start evict_que=
ue
> directly after that because in ISR it already guarantee this is from UTCL=
2 client,
> right?
>=20
> +		if (client_id =3D=3D SOC15_IH_CLIENTID_UTCL2 &&
> +		    dev->kfd2kgd->is_ras_utcl2_poison &&
> +		    dev->kfd2kgd->is_ras_utcl2_poison(dev->adev, client_id)) {
> +			event_interrupt_poison_consumption(dev,
> ih_ring_entry);
>=20
>=20
> In addition, is_ras_utcl2_poison can be renamed to query_utcl2_ras_status=
 or
> poison_status, while utcl2_fault_clear to reset_utlc2_poison_status to al=
ign
> with naming style of ras hw op.
>=20
> Thinking about this more, it's better we add this in gfx ras op, and expo=
se to KFD.
> Thoughts?

[Tao] accepted

>=20
> Regards,
> Hawking
>=20
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Monday, March 14, 2022 15:03
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai,
> Thomas <YiPeng.Chai@amd.com>
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 3/3] drm/amdkfd: add RAS poison consumption support for
> utcl2
>=20
> Do RAS page retirement and use gpu reset as fallback in utcl2 fault handl=
er.
>=20
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 23 ++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index f7def0bf0730..3991f71d865b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -93,11 +93,12 @@ enum SQ_INTERRUPT_ERROR_TYPE {  static void
> event_interrupt_poison_consumption(struct kfd_dev *dev,
>  				const uint32_t *ih_ring_entry)
>  {
> -	uint16_t source_id, pasid;
> +	uint16_t source_id, client_id, pasid;
>  	int ret =3D -EINVAL;
>  	struct kfd_process *p;
>=20
>  	source_id =3D SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
> +	client_id =3D SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
>  	pasid =3D SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
>=20
>  	p =3D kfd_lookup_process_by_pasid(pasid);
> @@ -110,6 +111,7 @@ static void event_interrupt_poison_consumption(struct
> kfd_dev *dev,
>  		return;
>  	}
>=20
> +	pr_debug("RAS poison consumption handling\n");
>  	atomic_set(&p->poison, 1);
>  	kfd_unref_process(p);
>=20
> @@ -119,10 +121,14 @@ static void
> event_interrupt_poison_consumption(struct kfd_dev *dev,
>  		break;
>  	case SOC15_INTSRC_SDMA_ECC:
>  	default:
> +		if (client_id =3D=3D SOC15_IH_CLIENTID_UTCL2)
> +			ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
>  		break;
>  	}
>=20
> -	kfd_signal_poison_consumed_event(dev, pasid);
> +	/* utcl2 page fault has its own vm fault event */
> +	if (client_id !=3D SOC15_IH_CLIENTID_UTCL2)
> +		kfd_signal_poison_consumed_event(dev, pasid);
>=20
>  	/* resetting queue passes, do page retirement without gpu reset
>  	 * resetting queue fails, fallback to gpu reset solution @@ -314,7
> +320,18 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
>  		info.prot_write =3D ring_id & 0x20;
>=20
>  		kfd_smi_event_update_vmfault(dev, pasid);
> -		kfd_dqm_evict_pasid(dev->dqm, pasid);
> +
> +		if (client_id =3D=3D SOC15_IH_CLIENTID_UTCL2 &&
> +		    dev->kfd2kgd->is_ras_utcl2_poison &&
> +		    dev->kfd2kgd->is_ras_utcl2_poison(dev->adev, client_id)) {
> +			event_interrupt_poison_consumption(dev,
> ih_ring_entry);
> +
> +			if (dev->kfd2kgd->utcl2_fault_clear)
> +				dev->kfd2kgd->utcl2_fault_clear(dev->adev);
> +		}
> +		else
> +			kfd_dqm_evict_pasid(dev->dqm, pasid);
> +
>  		kfd_signal_vm_fault_event(dev, pasid, &info);
>  	}
>  }
> --
> 2.35.1

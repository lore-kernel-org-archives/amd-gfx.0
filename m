Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C493BC0219D
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 21:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E66A10EBAE;
	Fri,  7 Feb 2025 21:47:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dVff5//W";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E72A10E143
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 21:45:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ose0zsGtvJdVFpvnXzgFj71K6g+HTyhW7jb9vFD1KlKC4eJ1zlsvI/RbRZ3BKDulLVCH2QmR+ptfDfvXBHTlo6z7nXyZgikKoPMpQFlBAJUjkgYQ6T+BdwVoimUR3NxOuMFrGtFTYTmPkY0TiEtrleroZnnJX5M/3gtGDK501Ok3tycxoAoA2iQh5GY59xlK0HJLAvdlPhmDb8g6s1j15VePasntva1JZkD2JspeSP/kxftUlllBXfj4LwVWLy5Tx6Ly6apmu8XrRu/vkbz2Exq/T+J585Uo/znvrkp8HX953QcOHhh3vZY47tYPfVpggPNqi78x1TOhvBJvJVk05Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRzB3aFbkpcxraRaG6Ot3YbP7BD/nbJdnVPSvcdccNg=;
 b=kQBGCF4zN8PlM5/Yb33Sx6QMAaJm+VXhZjeJ+jNu3xCAmNx4LlJ88K/ZYK2fl2BPTl4jxfUEvecPPplzgpbdXxnPcciorTjNnHHDa9ugWTixAcx9Ir3Z4dgmmi05Fj0+UOtYDIUfJXQzE+p1GF+rDLpKd8uQPuFeMLvc7w9UuOYuKMSxRtn+vzf+09iRPCOxa7tCpBxAL6Ou/a0ETXgxZcI5TE5+IJOG5ZMVpeFnjN1kiy2rJRHMYxQ8KlFRlXhDtFQqMH7JsWMi8QYavYQjY+MJ+p6YkAEaL85eIsu+KXUYx4fJChmAsEyOX32ZcGXG0935jDzpx3Q3A5FBV8WgVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRzB3aFbkpcxraRaG6Ot3YbP7BD/nbJdnVPSvcdccNg=;
 b=dVff5//WPNsjsr/rYSt9vR/+r81qFExygGn4nMuGZrkKRklW6iCxfwO257NqzN0h2D3mDLkBPP8rLmLXH12gx4buL2/1xcRuD7ccQXP+HrUVzjPZ4ORWL5OnFkPAmr/bnd4G7Xd5qL1liFQeJjK1B3pqrWz5m3bM00I4uBO+JxY=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 21:45:48 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 21:45:48 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
Thread-Topic: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery
Thread-Index: AQHbeJjnBkTSX11A7kaLj0Yc6dV7/bM66/vQgABLTACAAKRScIAACgyAgAAAHPCAABAFgIAABqQAgAAGyoCAAAMekIAAFaiAgAA/QKA=
Date: Fri, 7 Feb 2025 21:45:48 +0000
Message-ID: <CY8PR12MB743582FDD84CAE8D43B2154F85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250206131258.1970391-1-lijo.lazar@amd.com>
 <20250206131258.1970391-3-lijo.lazar@amd.com>
 <CY8PR12MB743505FC4310A69D4B2C372685F62@CY8PR12MB7435.namprd12.prod.outlook.com>
 <22d2c3e8-98f9-4ea3-9737-08e9812d312a@amd.com>
 <CY8PR12MB7435B4D359268091F915407F85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
 <a5bc0dcc-3aba-404f-aee4-f664a71b7a1b@amd.com>
 <CY8PR12MB7435100E613BA33C8CD4B2DD85F12@CY8PR12MB7435.namprd12.prod.outlook.com>
 <1f9441b1-46af-496d-9711-a71242d03b46@amd.com>
 <CY8PR12MB74358CBFB54C385E564B247785F12@CY8PR12MB7435.namprd12.prod.outlook.com>
 <DS0PR12MB7804043F80CCE669305F984097F12@DS0PR12MB7804.namprd12.prod.outlook.com>
 <CY8PR12MB7435933A1D8983F4661D762285F12@CY8PR12MB7435.namprd12.prod.outlook.com>
 <DS0PR12MB7804A35C24B56EDA46BCB73097F12@DS0PR12MB7804.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB7804A35C24B56EDA46BCB73097F12@DS0PR12MB7804.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-07T15:54:59.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|BY5PR12MB4114:EE_
x-ms-office365-filtering-correlation-id: 4aa7ce79-9e0b-4581-08e6-08dd47c0c8ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700018|7053199007|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?OzA4tIQmCM5OQW5OA6HW46c/IsWnCXEW+px3FZ6LyrRQUIqiHQib4yVlYlX8?=
 =?us-ascii?Q?MNOrRm71HGsMMdB602EpuEASXbvqcVcI55YGUyjqUaZWeGTJqM+rvq5/7rHA?=
 =?us-ascii?Q?FO6g9oFkPolOuCE/Zgd6SUI0w1Vn+DbZ3v5oJw3wAWQ6ChxxDvghbyZU1z34?=
 =?us-ascii?Q?EQ5qWbKiCVvtK61Z3Xqtuv06ktUKLmeLtHZQPiXTtYU0wdKv+mHVPL3x4BmY?=
 =?us-ascii?Q?AEgpfp12uqFL0xqa3GbmCS304xO6WuxaYfAudB+UQmOgwoTWKuvOtG4lkouM?=
 =?us-ascii?Q?pLZBSuM00//RNh7AIFiusFuZWUxknoZtgKvo0Mni52aPFCjQz+rIpjOqpIjg?=
 =?us-ascii?Q?5wPbASiQUdte8Ko7z2xpMVoZjnW83Jh4Ay+lMydqKwNu1WHKVJVk+gTosQRT?=
 =?us-ascii?Q?W/eniw719d9bPQcV9mjsdTZmG9h1ELOcHJP/JAtkoIRw7QTdecH2oWwEPKg7?=
 =?us-ascii?Q?r4lMrT4MwOm1C651hW45EVJuotHcoPQ7pwIYHrNIF33N6Ju8KTE9tj01uHQ2?=
 =?us-ascii?Q?i1dIkk99g2ywKziW/fRsFoyQxxTXdvMR1KpAJVd4Yp/7kXYkKzoOih6TuXGI?=
 =?us-ascii?Q?Oaa6Qs5V0j7W7tCztrJvT4zopwwZvWCMT2RnI5x9UID+7V7CrcNhMnm8V/NR?=
 =?us-ascii?Q?L9mJDAWewkrXxvznFgEPRLs3cIOEZRNPE6wQ4yiY1B9O+1h7zDtGKsSN3f2j?=
 =?us-ascii?Q?FOjG0V9vtVYwSZQRKLpff2062drTQknTePHgrPm5R74G9dZ1yWoaDOQ9yySL?=
 =?us-ascii?Q?cs3b6A+9+JrJIwKu1nXAX+L/lj0VKxZniV/XbFkWB6bCj1B+VDlzPJc7cw/v?=
 =?us-ascii?Q?UpUqd/PJTMVvZrT3OK6E3zywhBPjunZh4EkSZrYC0LHns8/YTGq0iXQQ0wGl?=
 =?us-ascii?Q?DvQ3IznVximLcQ4Jb0nDL0sBElG8PJ07TbGvEObh3PQl4/7sF74DCpQI4J9s?=
 =?us-ascii?Q?QzzZzC03yMzqVFffgxPVRYfxIq5rN/XhqRcqxr3DOFO933p/0p+DTpv+DV2h?=
 =?us-ascii?Q?CmCIUp+8SK/Pk97LXsax6OWke2/q4nqpbQbIvgN7jJUcNBBk+Ks4GPm5SAsg?=
 =?us-ascii?Q?lRJL8+i596RwoXtUACBkEptxt5xzuIO0beCX476OJnqey05VGA/d1BjAySag?=
 =?us-ascii?Q?2wuflL3ltkmh/Ux9wQZAeLMhjK3iCajJHbEjIo//wvlHvcL0vmvNnwnMpSqV?=
 =?us-ascii?Q?z+voN/oZGhvYmdEMffqTav5ssr1xxXkHeq9cfDdy8B6A+d9BWcJ3TTvgB1yM?=
 =?us-ascii?Q?y4gLmW8CGQ8tRl4ilvW2AgL8M+2rL249WEwqeogFFT8TsQvRqksDM+GXkVOR?=
 =?us-ascii?Q?WYNjF5ka+6Z8A1XYkTxkoJTOh3iwKZ1G1d8jprGvRc1GmykC1j6bK0o3kC1E?=
 =?us-ascii?Q?SxZSZp43YNs/lBhRy9bVQZTqwYoN9GS8CKjighzbtFXr6zU/IjS9KpiOCNx0?=
 =?us-ascii?Q?KmwYGknpcBQdTsJdIoO7jhSomyIVz2n6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?imRD39ntxNWyIU9BjkTTXaV+kimK5K4XNZ8YwVBg9xNERh4qbk0Qwuup97wP?=
 =?us-ascii?Q?FSL1pIhHNWJQ2dESyVcvklEky9vhldokwFRPY3RmseIiPVHvKzfu+Po4PBFa?=
 =?us-ascii?Q?+4RhwoyEJRcWEd8bHE/tNepiCozAhGatH6tu2PrTaCmIf2VkZXLQ/F1Gda3s?=
 =?us-ascii?Q?pqGByDIHhghHOVbM+zQrbwhnEmScgusRDvAFiEbxsrp+wngBEYXVRnGLzurA?=
 =?us-ascii?Q?Gn5n9EFN/UczuHX6ZV43cf9G95TuUnerTTKBu/LR3Pi2FwdBgplUYavyVqAL?=
 =?us-ascii?Q?4huNlDDitFTI0F+xvqAcdMlD35xRy1rb7ssaib3WJMlhyW0ksLb1nbd2x3Y5?=
 =?us-ascii?Q?b39/wmtRcybwOzcC80DNn9PzyLHReZXIVmx5YjFHPUeLCYQVuQ+fHeUaDthh?=
 =?us-ascii?Q?QZp+QnPHV5YM48+b4mwE2GcV/iAreig4VjM1wDsh5RUnQcSICOkHDs06TuP2?=
 =?us-ascii?Q?sAj+MfS0H95V0rg0NnMM5oFwvfCopsB/TNdGJzwp0I5BjCJXk+1BQUBa6Ae3?=
 =?us-ascii?Q?V8DH7l7r7g8Qk8UWZmkPLzE5k78PWKToxgK7ijuQvF4wVFxn7g0qGVo/IyhX?=
 =?us-ascii?Q?9hTNKzRVMRLvEUiWtFcJfhwgdPsvNmtyHjsjc14Smbd+JPrpupAB+w4+gCIj?=
 =?us-ascii?Q?4LXEK74PdE0s9XhHdeUCyCvBorVB5wuzigL3k5v18tqMejtqXtRon3djrzNq?=
 =?us-ascii?Q?sdbka6jhxEQ/SeRHx6RgkZxk79pxQyGAuE7JncRF8wq1nYOyXNBOLSGv1ssW?=
 =?us-ascii?Q?LqbYYy4AlO2g33sjHK6NAk9jK/UqTRUFj89biIFjbCZn78wNpB9yLZn8kSW2?=
 =?us-ascii?Q?dO9FVQ7dQg12/cD0l211ZZhfNkZCMw6OabbEl49Wxka1oxALPKQfDwAx70BO?=
 =?us-ascii?Q?olPqTA7dEiZxXQIoi1YGF5j9p2YHXJFb/R9rp8lC3UeHhi7lKxKZxbzj/RPI?=
 =?us-ascii?Q?6MFgUTlIBTphWUHQ1xgayjaXBZP8xyuBbkmwEqAcb56MTEaK+S8U9D9kJ6p5?=
 =?us-ascii?Q?GIKKS48Nut4KLWAhAq/YZqvsTJkq5w34Q68KVXGw6tpMx17UOBHkEd0FSoIH?=
 =?us-ascii?Q?dwc41VAMsjIooZO3i3SM4xWMvhvD1m4PtuTy7pa4BZS6SZD6fCuXwLVxvFYK?=
 =?us-ascii?Q?Mle8kEKURI5oFIhKdfAkrtUC/cAq4uEL/tmk3PVKiUlcxNPYZa1944Owind6?=
 =?us-ascii?Q?i2r3d+lzEklzI5CGlh9ZnJGmdNTOYyvpgN2ZYul8gqU9IcQOhsRYJ4d5d3Sf?=
 =?us-ascii?Q?SHieFJJk+W06eEfkm4U1UvHPb8VE8gzNxa8mfFTkHJly4yGjDAm3dnopoHj4?=
 =?us-ascii?Q?b+d6xVB4wnGjruJvampPNYdvS7+42F1tn8Yt/35EO+4HqLgoIwjGqtH3HX6q?=
 =?us-ascii?Q?BzyFlzltcSCkx8AXkp7wzQwn9f99XmQ0l12HXysirRsYWIvrpyDR1vjAix6B?=
 =?us-ascii?Q?pe8aQU4HGEe3543j4HNJN4vRzWjHQkCAwxfst8EkJJgt3DjIvc2Or02cAdki?=
 =?us-ascii?Q?d/UL/csB02MnT+mMGD9yPrOOcEKp2CoTjKJHv2jVLHXmpLWzVehCWfFs32QO?=
 =?us-ascii?Q?bAtVB3vSQEsj2jUp5H8=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY8PR12MB743582FDD84CAE8D43B2154F85F12CY8PR12MB7435namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa7ce79-9e0b-4581-08e6-08dd47c0c8ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 21:45:48.7388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vJlfpgTjLaVgQyeVhb9DO8hppLluB0VJ1+/HxsCbySzulHS2cSMZ4xbC1J+oKJV3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114
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

--_000_CY8PR12MB743582FDD84CAE8D43B2154F85F12CY8PR12MB7435namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

I think part of the problem is that gmc.xgmi.supported has weird usage and =
definition.
It's partly says that it has potential to be supported by IP version, but d=
oesn't actually say anything about real support but assumed say it has real=
 support in amdgpu_xgmi.c usage.
Real support is determined by gfxhub_...get_xgmi_info which has comments ->=
         /* PF_MAX_REGION=3D0 means xgmi is disabled */ and error returns o=
n failure to read.
On top of that, the gmc.xgmi.supported field gets set by both amdgpu_discov=
ery.c based on XGMI HW IP but is also set by gmc_v9_0.c early init base on =
GC version.
I think you're locked into doing a wrapper on a wrapper because the way gmc=
.xgmi.supported is set has become spaghetti code.
If that gets clean up, and we do your suggestion of pulling xgmi related in=
fo into early init i.e. get info based on actual verification that gfxhub s=
ays xgmi is ok,  I think the series would start to make much more sense.

Jon

From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, February 7, 2025 12:35 PM
To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery


[Public]

Another try.. if it helps (you or someone else)

This series introduces two functions for maintenance.

amdgpu_xgmi_init_info - This is to initialize any XGM related static inform=
ation. Now it's called as soon as XGMI version is discovered. Now, if that =
is causing some confusion, then I could rename to xgmi_early_init and call =
from device early init. The intent of the function is to initialise any sta=
tic info related to XGMI.

amdgpu_xgmi_get_max_bandwidth - Assumes all links are uniform and provides =
the max theoretical bandwidth. Currently, the calculation is simple as widt=
h * speed. In future, this may change based on IP version like speed * widt=
h * x_factor or get the bandwidth from FW etc. Caller is expected to get th=
is uniform interface for any XGMI IP version.

And lastly, both functions are maintained in amdgpu_xgmi.c

Thanks,
Lijo
________________________________
From: Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>
Sent: Friday, February 7, 2025 9:58:30 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.fr=
eedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Subject: RE: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery


[Public]


Well ... I don't know what other feedback I can give here then.

We're bouncing back and forth talking about language/function/logical struc=
ture or whatever.

I'm of the opinion that there are too many unnecessary wrappers here and am=
 biased to unbroken steps that make it easier to debug/dev later on (at lea=
st for me).

Maybe someone else has a different opinion.



Jon



From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Sent: Friday, February 7, 2025 11:06 AM
To: Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>; amd-=
gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery



[Public]



It so happens that driver gets part of the XGMI information through registe=
rs in GMC. The intent of those registers is to help GMC to figure out memor=
y access when device part of XGMI hive. Driver using those regs doesn't mea=
n XGMI is like a sub ip of GMC, it remains separate.



Thanks,

Lijo

________________________________

From: Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>
Sent: Friday, February 7, 2025 9:26:28 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.fr=
eedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
Subject: RE: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discovery



[Public]

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
> Sent: Friday, February 7, 2025 10:18 AM
> To: Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>; am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>
> Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during discover=
y
>
>
>
> On 2/7/2025 8:06 PM, Kim, Jonathan wrote:
> > [Public]
> >
> >> -----Original Message-----
> >> From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
> >> Sent: Friday, February 7, 2025 9:20 AM
> >> To: Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>;=
 amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> >> Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com=
>>
> >> Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during disco=
very
> >>
> >>
> >>
> >> On 2/7/2025 7:29 PM, Kim, Jonathan wrote:
> >>> [Public]
> >>>
> >>>> -----Original Message-----
> >>>> From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
> >>>> Sent: Thursday, February 6, 2025 10:56 PM
> >>>> To: Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>=
>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> >>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.c=
om>>
> >>>> Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during dis=
covery
> >>>>
> >>>>
> >>>>
> >>>> On 2/7/2025 5:03 AM, Kim, Jonathan wrote:
> >>>>> [Public]
> >>>>>
> >>>>>> -----Original Message-----
> >>>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
> >>>>>> Sent: Thursday, February 6, 2025 8:13 AM
> >>>>>> To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop=
.org>; Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
> >>>>>> Cc: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd=
.com>>; Kim, Jonathan
> >>>>>> <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>
> >>>>>> Subject: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during disco=
very
> >>>>>>
> >>>>>> Initialize xgmi related static information during discovery.
> >>>>>>
> >>>>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com<mailto:lijo.lazar@am=
d.com>>
> >>>>>> ---
> >>>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 20 +++++++++++++-=
-
> ----
> >>>>>>  1 file changed, 14 insertions(+), 6 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >>>>>> index eca431e52038..d4eade2bd4d3 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> >>>>>> @@ -2502,6 +2502,19 @@ static int
> >>>> amdgpu_discovery_set_isp_ip_blocks(struct
> >>>>>> amdgpu_device *adev)
> >>>>>>       return 0;
> >>>>>>  }
> >>>>>>
> >>>>>> +static void amdgpu_discovery_set_xgmi_info(struct amdgpu_device *=
adev)
> >>>>>> +{
> >>>>>> +     if (amdgpu_ip_version(adev, XGMI_HWIP, 0) =3D=3D IP_VERSION(=
4, 8, 0))
> >>>>>> +             adev->gmc.xgmi.supported =3D true;
> >>>>>> +
> >>>>>> +     if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9,=
 4, 3) ||
> >>>>>> +         amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9,=
 4, 4))
> >>>>>> +             adev->ip_versions[XGMI_HWIP][0] =3D IP_VERSION(6, 4,=
 0);
> >>>>>
> >>>>> Can this stuff get rolled into xgm_init_info and called directly in=
to
> >>>> amdgpu_discovery_set_ip_blocks?
> >>>>> Breaking up discovery_set_xgmi_info and xgmi_init_info as 2 separat=
e things
> >>>> seems a little confusing.
> >>>>>
> >>>>
> >>>> Intent is like this -
> >>>>       Set IP version info. This is the job of discovery and kept ins=
ide
> >>>> amdgpu_discovery.
> >>>>       Set any static information derived out of IP versions and not =
available
> >>>> in discovery tables. This is kept outside of discovery file.
> >>>
> >>>
> >>> Then why are you proposing to set up static information in the discov=
ery file in
> the
> >> first place?
> >>
> >> I didn't understand that statement. The function - amdgpu_xgmi_init_in=
fo
> >> - called from discovery sets up the derived information. Only IP versi=
on
> >> info is set inside discovery.
> >
> > Snip from you're last response:
> >>>>       Set any static information derived out of IP versions and not =
available
> >>>> in discovery tables. This is kept outside of discovery file.
> > You're calling amdgpu_discovery_set_xgmi_info which calls
> amdgpu_xgmi_init_info which is setting static derived information in the =
discovery
> file.
> > A wrapper called in a wrapper is still doing the opposite of what you'r=
e saying int
> the snip above.
> > If you're trying to avoid this and keep discovery clean, call xgmi_init=
_info in
> amdgpu_device.c somewhere after the IP blocks are set.
> > And put xgmi_supported definitions in xgmi_init_info since that doesn't=
 count as IP
> version setting.
> >
>
> This is only about structural segregation - like the place where we want
> to maintain xgmi related data. Functions setting IP versions and
> information from discovery table is kept inside discovery. Any function
> which adds further static data out of the IP version is kept in the IP
> related file.
>
> This is not about a logical separation like xgmi related information
> derived from an IP version shouldn't be set at discovery phase.

Yeah I get it, there's function in language structure but I could also argu=
e that language structures should point to function.
Otherwise, we could end up with a bunch of word salad.
I wonder if it makes more sense to roll up speed and width info somewhere i=
n GFXHUB initialization.
The xGMI information is GMC based and xgmi_supported doesn't rely on IP ver=
sioning IIRC but rather the number of physical nodes determined by the memo=
ry controller.
e.g. gfxhub_v2_1_get_xgmi_info.
Then that would take the pressure off all this file reference jumping and v=
ersion checking.

Jon

>
> Thanks,
> Lijo
>
> > Jon
> >
> >>
> >> Thanks,
> >> Lijo
> >>
> >>>
> >>> Jon
> >>>
> >>>>
> >>>> Thanks,
> >>>> Lijo
> >>>>
> >>>>>> +
> >>>>>> +     if (amdgpu_ip_version(adev, XGMI_HWIP, 0))
> >>>>>
> >>>>> Maybe roll this check into xgmi_init_info i.e. void early return if=
 null.
> >>>>>
> >>>>>> +             amdgpu_xgmi_init_info(adev);
> >>>>>> +}
> >>>>>> +
> >>>>>>  int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
> >>>>>>  {
> >>>>>>       int r;
> >>>>>> @@ -2769,12 +2782,7 @@ int amdgpu_discovery_set_ip_blocks(struct
> >>>>>> amdgpu_device *adev)
> >>>>>>               break;
> >>>>>>       }
> >>>>>>
> >>>>>> -     if (amdgpu_ip_version(adev, XGMI_HWIP, 0) =3D=3D IP_VERSION(=
4, 8, 0))
> >>>>>> -             adev->gmc.xgmi.supported =3D true;
> >>>>>> -
> >>>>>> -     if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9,=
 4, 3) ||
> >>>>>> -         amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9,=
 4, 4))
> >>>>>> -             adev->ip_versions[XGMI_HWIP][0] =3D IP_VERSION(6, 4,=
 0);
> >>>>>> +     amdgpu_discovery_set_xgmi_info(adev);
> >>>>>
> >>>>> If you do the suggestions above, you can just call amdgpu_xgmi_init=
_info
> >>>> unconditionally.
> >>>>>
> >>>>> Jon
> >>>>>>
> >>>>>>       /* set NBIO version */
> >>>>>>       switch (amdgpu_ip_version(adev, NBIO_HWIP, 0)) {
> >>>>>> --
> >>>>>> 2.25.1
> >>>>>
> >>>
> >

--_000_CY8PR12MB743582FDD84CAE8D43B2154F85F12CY8PR12MB7435namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Malgun Gothic";
	panose-1:2 11 5 3 2 0 0 2 0 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@Malgun Gothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
span.EmailStyle24
	{mso-style-type:personal-reply;
	font-family:"Arial",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:2037997328;
	mso-list-type:hybrid;
	mso-list-template-ids:-358029714 1479811818 67698691 67698693 67698689 676=
98691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Arial",sans-serif;
	mso-fareast-font-family:"Malgun Gothic";}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;
	font-family:Wingdings;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"purple" style=3D"word-wrap:b=
reak-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">I think part of the problem is that gmc.xgmi.supporte=
d has weird usage and definition.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">It&#8217;s partly says that it has potential to be su=
pported by IP version, but doesn&#8217;t actually say anything about real s=
upport but assumed say it has real support in amdgpu_xgmi.c
 usage.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Real support is determined by gfxhub_...get_xgmi_info=
 which has comments -&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/=
* PF_MAX_REGION=3D0 means xgmi is disabled */ and error returns on failure =
to read.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">On top of that, the gmc.xgmi.supported field gets set=
 by both amdgpu_discovery.c based on XGMI HW IP but is also set by gmc_v9_0=
.c early init base on GC version.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">I think you&#8217;re locked into doing a wrapper on a=
 wrapper because the way gmc.xgmi.supported is set has become spaghetti cod=
e.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">If that gets clean up, and we do your suggestion of p=
ulling xgmi related info into early init i.e. get info based on actual veri=
fication that gfxhub says xgmi is ok,&nbsp; I think
 the series would start to make much more sense.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif">Jon<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> Lazar, Lijo &lt;Lijo.Lazar@amd=
.com&gt;
<br>
<b>Sent:</b> Friday, February 7, 2025 12:35 PM<br>
<b>To:</b> Kim, Jonathan &lt;Jonathan.Kim@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during dis=
covery<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal">Another try.. if it helps (you or someone else)<o:p>=
</o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">This series introduces two functions for maintenance=
.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">amdgpu_xgmi_init_info - This is to initialize any XG=
M related static information. Now it's called as soon as XGMI version is di=
scovered. Now, if that is causing some confusion, then I could rename to xg=
mi_early_init and call from device
 early init. The intent of the function is to initialise any static info re=
lated to XGMI.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">amdgpu_xgmi_get_max_bandwidth - Assumes all links ar=
e uniform and provides the max theoretical&nbsp;bandwidth. Currently, the c=
alculation is simple as width * speed. In future, this may change based on =
IP version like speed * width * x_factor
 or get the bandwidth from FW etc. Caller is expected to get this uniform i=
nterface for any XGMI IP version.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">And lastly, both functions are maintained in amdgpu_=
xgmi.c<o:p></o:p></p>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Lijo<o:p></o:p></p>
</div>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Kim, J=
onathan &lt;<a href=3D"mailto:Jonathan.Kim@amd.com">Jonathan.Kim@amd.com</a=
>&gt;<br>
<b>Sent:</b> Friday, February 7, 2025 9:58:30 PM<br>
<b>To:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar=
@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during dis=
covery</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;A=
rial&quot;,sans-serif">Well &#8230; I don&#8217;t know what other feedback =
I can give here then.</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;A=
rial&quot;,sans-serif">We&#8217;re bouncing back and forth talking about la=
nguage/function/logical structure or whatever.</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;A=
rial&quot;,sans-serif">I&#8217;m of the opinion that there are too many unn=
ecessary wrappers here and am biased to unbroken steps that make it easier =
to debug/dev later on (at least for me).
</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;A=
rial&quot;,sans-serif">Maybe someone else has a different opinion.</span><o=
:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;A=
rial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;A=
rial&quot;,sans-serif">Jon</span><o:p></o:p></p>
<p class=3D"xmsonormal"><span style=3D"font-size:11.0pt;font-family:&quot;A=
rial&quot;,sans-serif">&nbsp;</span><o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xmsonormal"><b><span style=3D"font-size:11.0pt;font-family:&quo=
t;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt=
;font-family:&quot;Calibri&quot;,sans-serif"> Lazar, Lijo &lt;<a href=3D"ma=
ilto:Lijo.Lazar@amd.com">Lijo.Lazar@amd.com</a>&gt;
<br>
<b>Sent:</b> Friday, February 7, 2025 11:06 AM<br>
<b>To:</b> Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.Kim@amd.com">Jonath=
an.Kim@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during dis=
covery</span><o:p></o:p></p>
</div>
</div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:green">[Public]</span><o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div>
<div>
<p class=3D"xmsonormal">It so happens that driver gets part of the XGMI inf=
ormation through registers in GMC. The intent of those registers is to help=
 GMC to figure&nbsp;out memory access when device part of XGMI hive. Driver=
 using those regs doesn't mean XGMI is
 like a sub ip of GMC, it remains separate.<o:p></o:p></p>
</div>
<div id=3D"x_ms-outlook-mobile-signature">
<div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal">Thanks,<o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal">Lijo<o:p></o:p></p>
</div>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"xmsonormal"><b><span style=3D"font-size:11.0pt;font-family:&quo=
t;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font=
-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black"> Kim, =
Jonathan &lt;<a href=3D"mailto:Jonathan.Kim@amd.com">Jonathan.Kim@amd.com</=
a>&gt;<br>
<b>Sent:</b> Friday, February 7, 2025 9:26:28 PM<br>
<b>To:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar=
@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawk=
ing.Zhang@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during dis=
covery</span>
<o:p></o:p></p>
<div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsonormal" style=3D"margin-bottom:12.0pt"><a name=3D"x_BM_BEGI=
N"></a><span style=3D"font-size:11.0pt;font-family:&quot;Times New Roman&qu=
ot;,serif">[Public]<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar=
@amd.com</a>&gt;<br>
&gt; Sent: Friday, February 7, 2025 10:18 AM<br>
&gt; To: Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.Kim@amd.com">Jonathan=
.Kim@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Hawkin=
g.Zhang@amd.com</a>&gt;<br>
&gt; Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info during disco=
very<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On 2/7/2025 8:06 PM, Kim, Jonathan wrote:<br>
&gt; &gt; [Public]<br>
&gt; &gt;<br>
&gt; &gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt; From: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">L=
ijo.Lazar@amd.com</a>&gt;<br>
&gt; &gt;&gt; Sent: Friday, February 7, 2025 9:20 AM<br>
&gt; &gt;&gt; To: Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.Kim@amd.com"=
>Jonathan.Kim@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; &gt;&gt; Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.co=
m">Hawking.Zhang@amd.com</a>&gt;<br>
&gt; &gt;&gt; Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi info dur=
ing discovery<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 2/7/2025 7:29 PM, Kim, Jonathan wrote:<br>
&gt; &gt;&gt;&gt; [Public]<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt;&gt;&gt; From: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@am=
d.com">Lijo.Lazar@amd.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt; Sent: Thursday, February 6, 2025 10:56 PM<br>
&gt; &gt;&gt;&gt;&gt; To: Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.Kim@=
amd.com">Jonathan.Kim@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; &gt;&gt;&gt;&gt; Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhan=
g@amd.com">Hawking.Zhang@amd.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt; Subject: Re: [PATCH 3/4] drm/amdgpu: Initialize xgmi =
info during discovery<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; On 2/7/2025 5:03 AM, Kim, Jonathan wrote:<br>
&gt; &gt;&gt;&gt;&gt;&gt; [Public]<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; From: Lazar, Lijo &lt;<a href=3D"mailto:Lijo.=
Lazar@amd.com">Lijo.Lazar@amd.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Sent: Thursday, February 6, 2025 8:13 AM<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; To: <a href=3D"mailto:amd-gfx@lists.freedeskt=
op.org">amd-gfx@lists.freedesktop.org</a>; Lazar, Lijo &lt;<a href=3D"mailt=
o:Lijo.Lazar@amd.com">Lijo.Lazar@amd.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawk=
ing.Zhang@amd.com">Hawking.Zhang@amd.com</a>&gt;; Kim, Jonathan<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:Jonathan.Kim@amd.com">J=
onathan.Kim@amd.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Subject: [PATCH 3/4] drm/amdgpu: Initialize x=
gmi info during discovery<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Initialize xgmi related static information du=
ring discovery.<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; Signed-off-by: Lijo Lazar &lt;<a href=3D"mail=
to:lijo.lazar@amd.com">lijo.lazar@amd.com</a>&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; ---<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_disco=
very.c | 20 +++++++++++++--<br>
&gt; ----<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp; 1 file changed, 14 insertions(+), 6 del=
etions(-)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgp=
u_discovery.c<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery=
.c<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; index eca431e52038..d4eade2bd4d3 100644<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_disco=
very.c<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_disco=
very.c<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; @@ -2502,6 +2502,19 @@ static int<br>
&gt; &gt;&gt;&gt;&gt; amdgpu_discovery_set_isp_ip_blocks(struct<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; amdgpu_device *adev)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;=
<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp; }<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +static void amdgpu_discovery_set_xgmi_info(s=
truct amdgpu_device *adev)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +{<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_versi=
on(adev, XGMI_HWIP, 0) =3D=3D IP_VERSION(4, 8, 0))<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.supported =3D true;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_versi=
on(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3) ||<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4))<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[XGMI_HWIP][0] =3D IP_VERS=
ION(6, 4, 0);<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Can this stuff get rolled into xgm_init_info and =
called directly into<br>
&gt; &gt;&gt;&gt;&gt; amdgpu_discovery_set_ip_blocks?<br>
&gt; &gt;&gt;&gt;&gt;&gt; Breaking up discovery_set_xgmi_info and xgmi_init=
_info as 2 separate things<br>
&gt; &gt;&gt;&gt;&gt; seems a little confusing.<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Intent is like this -<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Set IP version in=
fo. This is the job of discovery and kept inside<br>
&gt; &gt;&gt;&gt;&gt; amdgpu_discovery.<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Set any static in=
formation derived out of IP versions and not available<br>
&gt; &gt;&gt;&gt;&gt; in discovery tables. This is kept outside of discover=
y file.<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Then why are you proposing to set up static information i=
n the discovery file in<br>
&gt; the<br>
&gt; &gt;&gt; first place?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; I didn't understand that statement. The function - amdgpu_xgm=
i_init_info<br>
&gt; &gt;&gt; - called from discovery sets up the derived information. Only=
 IP version<br>
&gt; &gt;&gt; info is set inside discovery.<br>
&gt; &gt;<br>
&gt; &gt; Snip from you're last response:<br>
&gt; &gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Set any static in=
formation derived out of IP versions and not available<br>
&gt; &gt;&gt;&gt;&gt; in discovery tables. This is kept outside of discover=
y file.<br>
&gt; &gt; You're calling amdgpu_discovery_set_xgmi_info which calls<br>
&gt; amdgpu_xgmi_init_info which is setting static derived information in t=
he discovery<br>
&gt; file.<br>
&gt; &gt; A wrapper called in a wrapper is still doing the opposite of what=
 you're saying int<br>
&gt; the snip above.<br>
&gt; &gt; If you're trying to avoid this and keep discovery clean, call xgm=
i_init_info in<br>
&gt; amdgpu_device.c somewhere after the IP blocks are set.<br>
&gt; &gt; And put xgmi_supported definitions in xgmi_init_info since that d=
oesn't count as IP<br>
&gt; version setting.<br>
&gt; &gt;<br>
&gt;<br>
&gt; This is only about structural segregation - like the place where we wa=
nt<br>
&gt; to maintain xgmi related data. Functions setting IP versions and<br>
&gt; information from discovery table is kept inside discovery. Any functio=
n<br>
&gt; which adds further static data out of the IP version is kept in the IP=
<br>
&gt; related file.<br>
&gt;<br>
&gt; This is not about a logical separation like xgmi related information<b=
r>
&gt; derived from an IP version shouldn't be set at discovery phase.<br>
<br>
Yeah I get it, there's function in language structure but I could also argu=
e that language structures should point to function.<br>
Otherwise, we could end up with a bunch of word salad.<br>
I wonder if it makes more sense to roll up speed and width info somewhere i=
n GFXHUB initialization.<br>
The xGMI information is GMC based and xgmi_supported doesn't rely on IP ver=
sioning IIRC but rather the number of physical nodes determined by the memo=
ry controller.<br>
e.g. gfxhub_v2_1_get_xgmi_info.<br>
Then that would take the pressure off all this file reference jumping and v=
ersion checking.<br>
<br>
Jon<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Lijo<br>
&gt;<br>
&gt; &gt; Jon<br>
&gt; &gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Thanks,<br>
&gt; &gt;&gt; Lijo<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Jon<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; Thanks,<br>
&gt; &gt;&gt;&gt;&gt; Lijo<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_versi=
on(adev, XGMI_HWIP, 0))<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Maybe roll this check into xgmi_init_info i.e. vo=
id early return if null.<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_xgmi_init_info(adev);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +}<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp; int amdgpu_discovery_set_ip_blocks(stru=
ct amdgpu_device *adev)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp; {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br=
>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; @@ -2769,12 +2782,7 @@ int amdgpu_discovery_s=
et_ip_blocks(struct<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; amdgpu_device *adev)<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_versi=
on(adev, XGMI_HWIP, 0) =3D=3D IP_VERSION(4, 8, 0))<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gmc.xgmi.supported =3D true;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; -<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_versi=
on(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3) ||<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4))<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_versions[XGMI_HWIP][0] =3D IP_VERS=
ION(6, 4, 0);<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; +&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_discovery_se=
t_xgmi_info(adev);<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; If you do the suggestions above, you can just cal=
l amdgpu_xgmi_init_info<br>
&gt; &gt;&gt;&gt;&gt; unconditionally.<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt; Jon<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set NB=
IO version */<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (a=
mdgpu_ip_version(adev, NBIO_HWIP, 0)) {<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; --<br>
&gt; &gt;&gt;&gt;&gt;&gt;&gt; 2.25.1<br>
&gt; &gt;&gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;</span><o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY8PR12MB743582FDD84CAE8D43B2154F85F12CY8PR12MB7435namp_--

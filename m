Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A97C6FA82
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Sep 2022 02:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E407610E08E;
	Mon,  5 Sep 2022 02:19:43 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84DA710E08E
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Sep 2022 02:19:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7Rcc/wLo1AWOx1zpIcNUjMdppx3VvGReXBWD/Qxc/AGOw70LhU10DY9FKw5zqQ0GW/cE+euEvDBBhNEva2Yk5I4Oth7pfSmhdN6DCXBEVk2Rag9rNQ4HU2XAwqTXa1TPdzwfILglKWFUqgLqBb4h9/SaikqqsNZxNAuso4ggVPSL4HDVYw2D+D3au5rEsDBislLWJDLuwsnJCVBZ5VzVQpn//xo14xvZu4A+RuipTceOOouoa45Ml7d2QMLEJbBQKQhgdIgGIRV8Rwd9HZ9tfi2+myTDcz4cBPTNSkckk4JZcop6xcsRChMc7vWocUU7Vg2yMLjBsjrZlpU1dKNBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9z8PGTq93CHHBDCJUsdMfLGBtyORKYFkg2GWND0yFLc=;
 b=T1aabMma0193ccFS0xBavnbSyFqlLJTHvUTo+5IQNl+Eq/gj27se7NlYQ6URfFNWYho67oeByWOfbbbn34+T+2HFV2GO6dtUqa668S0Bbi0RAm9m7nZXC97omdXWyS1ucZaZ6noXSiy9DjJDW/BEd1QPBWv+uIeZOSJg0lqmTUOFEUhPrnkhN4zwS/kvU8FymSgMtAsIskkW4ndY7WZFgiXgs1rP5tzSg04SuNJmnXxbtOEq3Vxq83sh1l8BmYWVDEDTQCmglL8yPJ494gbn/oRviPbwt07CI9DLr0an4XlzOoFlgYMQs224a1fGRi4TjHwtIJIPLmKPAZR0PtxWiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9z8PGTq93CHHBDCJUsdMfLGBtyORKYFkg2GWND0yFLc=;
 b=ECf9rHGxWrv5zQ5QRCfpbVGfNSkd07AHcTN9vBFfgng3UgrP9UHQGBCMAbjuPZm1zn2GTopIsbHeOqvPXGx2qBFnYnNV1cjXL818ZCfgzOtIY3K0MeeeDLr46jTjPX9BojvLRQGifCKySzADLKG0fuh9tUFC+6wgIt9L0LdZxck=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 02:19:37 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::f00d:d41d:a454:1f6b]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::f00d:d41d:a454:1f6b%4]) with mapi id 15.20.5588.015; Mon, 5 Sep 2022
 02:19:36 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>,
 "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp
Thread-Topic: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp
Thread-Index: AQHYvdTSZDAs90JRMEuRDXESgfow663LLOoAgAAyX4CAAAwyAIAEo3jwgAAIE4CAAAf+0A==
Date: Mon, 5 Sep 2022 02:19:36 +0000
Message-ID: <DS7PR12MB60056F112F6FA070165822C0FB7F9@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20220901072959.4085193-1-yifan1.zhang@amd.com>
 <BY5PR12MB387318D60C341DE66211E724F67B9@BY5PR12MB3873.namprd12.prod.outlook.com>
 <DM4PR12MB5248CC7BFD66675461C8C84BF07A9@DM4PR12MB5248.namprd12.prod.outlook.com>
 <CY5PR12MB6369CE86D66FA5010B56589EC17A9@CY5PR12MB6369.namprd12.prod.outlook.com>
 <DS7PR12MB60058FACB01936A5DA2030AEFB7F9@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CY5PR12MB636940E08DCF76C76A4070D2C17F9@CY5PR12MB6369.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB636940E08DCF76C76A4070D2C17F9@CY5PR12MB6369.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-02T01:43:58Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=64ec50d8-0469-49d2-8aa1-29f13023105e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa37e7f4-c086-460e-a37e-08da8ee51480
x-ms-traffictypediagnostic: MW4PR12MB7016:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QvpkifQ9OY3D+EP+Sk9LTQHVNi+EsVJJdTsegaL5Cch0v4Q4tKiUZU8356ZkajurMF7BUuly3yBeT33F9955tkrNAWYaZm1u/R8q8+3yG+R70LuqppjXvC0Tgw5OWA9jU0kB3iqQ1JxW62184DGxv6VswzKiVt08bl7JHQm43xyKXDSf8Twwwjj44qfYvthNwWOOcypl0ghQyAyvNQUJFmkstTCJN1hDv+eTZ0uXrs4Wb95l02dDbO0B8HD6syaKLUnh16yNohpdW8Gz0YfutM2iB6kYX7KB0rP7h9q9yUurvqzrcGbrvkjdruqrL2Zo2FzBlxdWolVDyBUuqxLUQE7JcuFakxiGO+Avsg9w630MFB0ku6nCgrk+V4kWVkKTodxOm91d8z2VUWI6phw7d6pP5W+tzKm9NQBBIJuMV0PBh1ApG2v3UoFVR3GD/dHhdlK8PaZpFM9KtYqhiQXu7TSyb90FvRvBkM2HPzFOTrk7l0fABT9Xo1YqzM77/nEE1FYR8JAbW8GrcDr+CEtzTVvj8Xe4NoZ7b9gBhT06GnxlHQYlP77k86GKyjKSEen1ot2e0ggYSUo0EquavtRs80Emvz/BJQnBGhmx9qV9QJHbtxAdJw0Mb+ybJJSPw5OFDwpTiZ5l2yCXD0K2/2QO6Un/Z/8I2XMP4GCKaMeoFsvOt+ZYOT+Njo3xWfF3+KvuVsU9DETUG6MQJfG7rPCjvaXApfF1rI9rFU/J59z3kpoA6vNHls0C+Vknb3qPzPFMsZmGhPT9IWeZa008TCQMnw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(52536014)(5660300002)(9686003)(41300700001)(8936002)(122000001)(2906002)(26005)(478600001)(33656002)(38100700002)(66556008)(66446008)(66946007)(76116006)(66476007)(86362001)(64756008)(6506007)(8676002)(4326008)(53546011)(7696005)(110136005)(38070700005)(54906003)(186003)(71200400001)(316002)(55016003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?N0ylLhqeXxDykmc3Vz3xOQc2zDLmh0FNdI0xlBBFu9NsJpqBQ+2kggTIse9s?=
 =?us-ascii?Q?40lvmOtgWWxvE0uMqSVldWz8c0eBFkfPI8A0vM+n4YRRvSYI4SwByTzIPz1H?=
 =?us-ascii?Q?sM897649+YQmsJ6fsX/c1EktLsJGlwVjYNQW9fqJlERl6hJapZl3WvSsGWZN?=
 =?us-ascii?Q?CtXhIcaS5o9N1Rs3+9aEFboXVOCGqYqyUrRT89d5Qk9SLlI+uwHf44Iw5ZuW?=
 =?us-ascii?Q?D2l3iLrKyvvXN2BNMf9H7masM+V7CeKXsjgpIIMLdiFxr5XRwMlI1nSNk29R?=
 =?us-ascii?Q?rV3RTBaZc5ZVjYemQM6MGNCHEi1o3LYmgGrzo2m951ePWVB6Da3r8vrNLSwe?=
 =?us-ascii?Q?eedioY//XtwyGhTNorPJskMMjwXZeFfaUfhI8BqPHoU2vDY+aa6tLuznp8dj?=
 =?us-ascii?Q?88KPz1c6bEnHsTPzIRiCCldhEa7Jvr+BFaerr1hTy5mUfDxRtsAV+BAf8i7a?=
 =?us-ascii?Q?dceUtjvsxrm3kTsXHmy0VBzf7iv5pY/vnFZgoQg4OGQCqDAbCGoSTljrjFsJ?=
 =?us-ascii?Q?lKyFD21wIzi8xebGgmzhbYKFLfLrSFjs4TMidC05+CYeL3QTuxzI8KA0eMCu?=
 =?us-ascii?Q?6j96hfE7YapCJ0dN/iXeVoiyrLvHRTIfDorZzgCaeeySQZ64/cFWmK8wLJXP?=
 =?us-ascii?Q?a2te1QvoV20ENi7q01h+1f0ogblpt8qV7Aff+oge/Iy5tD2b0FUa5F+uAX3Z?=
 =?us-ascii?Q?AyMTVtHRPhDRMMfc7KQKaamG9qansJ/5W8L+zZhfqPLl0wLUuaG1eJOZ/KkF?=
 =?us-ascii?Q?c/7OHHD3nKyWmPQTcYyxBM1LiYQ0FL48y2c7A5Vvp5HSH4givzwV8xPCuaUY?=
 =?us-ascii?Q?aNWRzG7d2G3dxBgGv85zhEDByTUdObetQsylYSAfINBFGlxm7i1kXHgYcOE/?=
 =?us-ascii?Q?ZBbw1CaJeS1aNL7NFZLiRKrTTNgNaMSVDA4BlkG4HzTxoRm1w6CdIDKfeQAq?=
 =?us-ascii?Q?eqs+pKZcOFTiVefFR910ePlh8b0v12eIssIv6Ty9Sexn+OQIlG2j5HC6gr7m?=
 =?us-ascii?Q?urJ64hsg39z9KDYYY69MpQUDSA7SYeuhCUEL+3i4f/1KqU1surCaIuAnMoa9?=
 =?us-ascii?Q?yHYjJFzEZtu/vFI4l2N/dmjoWODerXYgCoVXI6q/45+3rvzHgTMLkDuqtTqB?=
 =?us-ascii?Q?WkvnB/XFJQaUzTzo1wNbatX64IAmxL0VuLtCHDyVp36Afm2DIjF5d9CC/Hhv?=
 =?us-ascii?Q?HCwej4g8QLhW8mI991JIQQGONWW6C9jaFz+93llmUmqnEYpBMJOPBtocz7vN?=
 =?us-ascii?Q?VCJVS4/qSp91Oo91xJw9zIanT3a4nVyTY3kwf/hISHLjjqX9Cw7+nW7TDDWj?=
 =?us-ascii?Q?O4f4UnBvTy07NZP8ae3mIgdC8DuXSGjX5uZqxSSEARcMkCoxiLXd+xYSA3aU?=
 =?us-ascii?Q?fjXHR1t5P5CNoGcRmrv93Z3s0kfNUiJBpamUI6OB6ZfCQHJKRLq3xjD+v4YS?=
 =?us-ascii?Q?9crZRdMCfXfzZT9k0wvBY3yR2Xz4uJf/FNIjx0ErHyEYh8A014I6W95U9Shj?=
 =?us-ascii?Q?uqdFI8Lsp6EDjpjpsQTR4nlPkagn7JqqquVL0WjCwhdJ0OdQcrFa85K3Yh7v?=
 =?us-ascii?Q?XLfdQgsiTynDM/WwwNs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa37e7f4-c086-460e-a37e-08da8ee51480
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 02:19:36.8351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6RIn9wXV0Lt4+XPxQ1HqE5hGBBVxBiU0cO2Z8eARaTXw7IkNvcfb5rHP+zKkF7Pk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7016
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If not sure whether the discovery table can be fulfilled the cache info in =
the upcoming NPI ASICs, maybe need the dummy cache info in the default clau=
se case rather than add more and more faking some specific HW configuration=
 and sometimes that may give misleading HW info.=20


Regards,
--Prike

-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>=20
Sent: Monday, September 5, 2022 9:47 AM
To: Liang, Prike <Prike.Liang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Hua=
ng, Tim <Tim.Huang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Du, Xiaojian <Xiaojian.=
Du@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Kuehling, Felix <Felix.Kuehlin=
g@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp

[Public]

It is actually a bug of discovery table which needs to be identified in NPI=
 phase. Hopefully we don't need neither dummy nor yellow carp cache info in=
 the future.

Best Regards,
Yifan

-----Original Message-----
From: Liang, Prike <Prike.Liang@amd.com>
Sent: Monday, September 5, 2022 9:24 AM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>; Hu=
ang, Tim <Tim.Huang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Du, Xiaojian <Xiaojian.=
Du@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Kuehling, Felix <Felix.Kuehlin=
g@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp

How about add a dummy cache info for the NPI product in the default case an=
d notify user that's using the dummy cache configuration to make sure not m=
iss correcting the HW info in the future?=20


Regards,
--Prike

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, Y=
ifan
Sent: Friday, September 2, 2022 10:28 AM
To: Liu, Aaron <Aaron.Liu@amd.com>; Huang, Tim <Tim.Huang@amd.com>; amd-gfx=
@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Du, Xiaojian <Xiaojian.=
Du@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp

[Public]

Hi Aaron,

Yes, the cache info are different. But this diff is intentional to workarou=
nd the discovery table lacks cache info in GC 11.0.1 issue. The workaround =
will be removed after discovery table finishes integrating cache info. Give=
n they already have a test version, we can pend this patch until they finis=
h integration.

Best Regards,
Yifan

-----Original Message-----
From: Liu, Aaron <Aaron.Liu@amd.com>
Sent: Friday, September 2, 2022 9:44 AM
To: Huang, Tim <Tim.Huang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; am=
d-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Du, Xiaojian <Xiaojian.=
Du@amd.com>
Subject: RE: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp

[Public]

Hi Yifan,

Yellow carp's cache info cannot be duplicated to GC_11_0_1.

Different point to GC_11_0_1:
TCP L1  Cache size is 32    =20
GL1 Data Cache size per SA is 256

Others looks good to me=20

--
Best Regards
Aaron Liu

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of=20
> Huang, Tim
> Sent: Friday, September 2, 2022 6:44 AM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Du, Xiaojian=20
> <Xiaojian.Du@amd.com>
> Subject: RE: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow=20
> carp
>=20
> [Public]
>=20
> [Public]
>=20
> Reviewed-by: Tim Huang <Tim.Huang@amd.com>
>=20
> Best Regards,
> Tim Huang
>=20
>=20
>=20
> -----Original Message-----
> From: Zhang, Yifan <Yifan1.Zhang@amd.com>
> Sent: Thursday, September 1, 2022 3:30 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Tim=20
> <Tim.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Zhang, Yifan=20
> <Yifan1.Zhang@amd.com>
> Subject: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp
>=20
> Current discovery table doesn't have cache info for GC 11.0.1, thus=20
> can't be parsed like other GC 11, this patch to match GC 11.0.1 cache=20
> info to yellow carp
>=20
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 24b414cff3ec..1c500bfb0b28 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -1516,11 +1516,11 @@ static int kfd_fill_gpu_cache_info(struct=20
> kfd_dev *kdev,
>                 case IP_VERSION(10, 3, 3):
>                 case IP_VERSION(10, 3, 6): /* TODO: Double check these=20
> on production silicon */
>                 case IP_VERSION(10, 3, 7): /* TODO: Double check these=20
> on production silicon */
> +               case IP_VERSION(11, 0, 1): /* TODO: Double check these=20
> +on production silicon */
>                         pcache_info =3D yellow_carp_cache_info;
>                         num_of_cache_types =3D ARRAY_SIZE(yellow_carp_cac=
he_info);
>                         break;
>                 case IP_VERSION(11, 0, 0):
> -               case IP_VERSION(11, 0, 1):
>                 case IP_VERSION(11, 0, 2):
>                 case IP_VERSION(11, 0, 3):
>                         pcache_info =3D cache_info;
> --
> 2.37.1

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6DBCA5FBE
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 07:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B817F10F222;
	Wed, 30 Sep 2026 07:51:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iQiygiv3";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010052.outbound.protection.outlook.com
 [40.93.198.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE4E410F222
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 07:51:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rW4I0q6D/leHnjTydlFuMVXE9Z6iWQtAH9papSfFcnAbmU8GniaSaI4BQrbnqBHArJDM7ShJJg3VfFH7iCQR6tqZxGbeH+3QK88ZaAzszdmzCDrlarZH8fVbWx/d8VQ7e9/2eBDXYeVwrm4Em4GBufk8W/3coEaiEjQmRf2vxwb3dn+Orvz5mgwdhJH6QIxZo+roCsfbN1leeJIhY/QUTldCS/dgbDvD7NBq22XZu1bfT9i4y0IgADAYaAPoO60Cb5yglkrdamIN5LiGxXwzQwISPB4FRw3z+d0ffpJZVJKiUYUk8JreZzOqIq5SunMYouplB1zh5hmeZE0MwDD9Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiGYFkOEAeT6VF8fKn8ooL8kmEOx8jk8Qqvcj6X1+PA=;
 b=IdzVV8UWXifW5huOH1zQg1NUbvjg5+4km3jnzV+aJcDkv964FE33Xho/IDxipgq1WsQduFj8BWWbjaPL/595APx8kSi9N8vUA6cdkPFB73T4tY/AyMdAfO2bN5PzaDO5oN7242Yb9/8NHkO4Uw/acPNdn8xDVtjLCmDNft9m7PD8yL9PcYbzVUV7Rirs+RsR2/N9w2d/WILIDs7MdJKXLOHCfUwOCyHUKmXrdrdfiPEcKUMJgmPllvePyKyJNJx1m0Apb+0aAX/dqySJEu6IHOMpF7yDU83nvXoiT2cFP/fxN4DcFLErWKgtBmeoYlMxBN1kvdremqc1X83cVpP/Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiGYFkOEAeT6VF8fKn8ooL8kmEOx8jk8Qqvcj6X1+PA=;
 b=iQiygiv324piCf8VcPeD985z4nJIr5t0Hua1W/oxxKurF32YUpfC9Ny7/MhNUaZlTBplAueez15yH0dYPsrRgTcGDtXe7ECR5LPtYbMfwYq+C7rK7DhSvwDHLcDPTRFCw/uxKaAWFFdXFAzTN6KrzVO7wTqLjM9xVheewLzknNo=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by PH7PR12MB7843.namprd12.prod.outlook.com (2603:10b6:510:27e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 07:51:16 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::e019:4cd0:8259:f6b8%6]) with mapi id 15.21.0451.024; Wed, 30 Sep 2026
 07:51:16 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "Wang, Kevin" <Kevin.Wang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Yuan, Perry" <Perry.Yuan@amd.com>
Subject: RE: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset on
 gfx12
Thread-Topic: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset
 on gfx12
Thread-Index: AQHdT7nmMq5HTaPVj0+C645FmSOmiLblQ/QAgAACu2CAAKMngIAAfzwwgAAIqwCAAAP30IAABK+AgAASmyCAABAJAIAAB+8AgAAAQhCAAAUFgIAAAG/wgAAL7YCAAAhykA==
Date: Wed, 30 Sep 2026 07:51:16 +0000
Message-ID: <CY5PR12MB6369078C22B4C31FD24EE9E1C18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20260929022540.122318-1-yifan1.zhang@amd.com>
 <f9db848b-da68-4acf-a0e3-41464b939817@amd.com>
 <CY5PR12MB6369B765E89F17858A5AB4A8C18C2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <BN9PR12MB5146D08AFE80E7E6EE34B614F78C2@BN9PR12MB5146.namprd12.prod.outlook.com>
 <CY5PR12MB63694BE5CF3FB172F837CCBFC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <6b086b84-deed-47ec-ab7f-8cc016ab519d@amd.com>
 <CY5PR12MB63696540D11FBBD268D9B7ECC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <a2f8757d-1566-4b8e-a606-e363221db6a1@amd.com>
 <CY5PR12MB63693EB274BB3A16097332AAC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <fa59606b-0860-4aaa-b6ce-ac037f73eab4@amd.com>
 <BN9PR12MB5211C24FDF238C2A748378DC938B2@BN9PR12MB5211.namprd12.prod.outlook.com>
 <CY5PR12MB63693C7F0614B19DC5CD525FC18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <SA0PR12MB70915BCDD0BE98B2F8B54A0E978B2@SA0PR12MB7091.namprd12.prod.outlook.com>
 <CY5PR12MB63692E6BAC9D9589354ED1B5C18B2@CY5PR12MB6369.namprd12.prod.outlook.com>
 <0b83688d-d517-457e-b9f1-c62baa5d9087@amd.com>
In-Reply-To: <0b83688d-d517-457e-b9f1-c62baa5d9087@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-30T07:42:30.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|PH7PR12MB7843:EE_
x-ms-office365-filtering-correlation-id: 775dcdd3-c665-4488-a7e8-08df1ec79b74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|4143699003|56012099006|11063799006|10067099003|38070700021;
x-microsoft-antispam-message-info: dU0UZAjAtoyLCD4OF8wR9EjzENDbQoXcrBnNoyjerdhq+0fHdw6BuOrbjYMhHB3pz4+7vA57uUlcbwxjV6cS0IeYAX/YLeYe/dgZZ4pAOfzPJ5wY+bmAlPxoWDZjbVE9j4VvrVwIqVtqlj468HLi75wwuCy8Us5Qr3/Hw4rN+GnT/ciw9HBgaUg8UPXxtEZ0EDXxlVcI80mACOt1e4u0/56jYpB55QjzzAqEPTCy244PN34/lUFDqA604IIhDRsT1oFch1aU0TaA3WAGmzllF9Z2aDLW4nt8fmpCfJQ0bVFCbwe+/7JKcKnBvcaYXPi4StljYY4fnePZbMGFrhyODjgAquhWzwyJfTKb8h5+Gms7+25nSleku+F4O6X33nB098+iSFUQHAgzvkj6ML97PT9Smfh8kUGbDp11jyoJrp2bW+1kMXWa9r/7nafB78rx9f/zPpv0BLCtMbMeRW1+8Ki3sG+2t3ZH/Me3xGL5VBkjqTiSgHfdktk5DPuDxWwZYOFQogtCzkk66e8ml7cIUhMYKDmbalyKX91lzPN2iODIXCWHTcBMdom05nanw7l7CIt9uKOBm14Kr4IOMo3fvSeyhNlaO9tTlPernMRddTVTSjgzuC7aAOqgakRfH8N+PAN58Mr2DXsaFKX5nTGF8/ICm5Sf1T7GPin8Adlm2gjKTodBm/FqT4h1+4Wc/OyG3cUsOq8S7xtpTPZk5atJzHkWvhQB6kpKAKgRKc7DmOM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(10067099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jtjYuxmi20CBjAcUzdKSe+M3J0sYeCsSjZNT1rXVBR4CyuYz6Oe5s6yMBy?=
 =?iso-8859-1?Q?aX12tuHDtETg/TBBCtKDSLtTpCUkChYzrO65U53kVf2c8gC4PnuvZmUoiB?=
 =?iso-8859-1?Q?CjiM1FI0N6z5g1ZbqmNPJwUOj+tqwUNJshp+aA/N3djLk4sIP44cvvE8Xt?=
 =?iso-8859-1?Q?1PhmUBL+1AJX2RisikOk5nPYkrizv4rPRF0+RN33HjQkSyFdjNF/2881W1?=
 =?iso-8859-1?Q?Xk1tnhCGiLxLZmdd2yutGHGPLY/2Hah3RW3n2jha0HDNdmdWHTbhwABu20?=
 =?iso-8859-1?Q?bPRZ+ik/Ji3lxidnEWtNcL2ZquoncKnqN9tH9MdipgVX8+DZcjShxXYhyq?=
 =?iso-8859-1?Q?eIQA1uV33qnIha9CpiW8YLmkjrqcb5ZM6FPqQI5b0VrAOEVOUO0wD6Tzzv?=
 =?iso-8859-1?Q?FBQ5MroCRQc30L/GBkwdDx+il53JXnwSrSlkyhoevKl3nqr5UECCgsJWoW?=
 =?iso-8859-1?Q?q0bBY5cLMZQOP2xlUgOB6z2Lqj1qYOy/5Wzb1N9LHQM2CoXBW8omFXvWaq?=
 =?iso-8859-1?Q?kGYTDkuk9Y37vSSETpwnLkti9WSDfdrgKmuA3I92bCwT3nRrN1rDWeGI+F?=
 =?iso-8859-1?Q?m45A1xO/aAhNFBR2Oe8hAURDdTdWjHy3sgtUTee/lQ02M+Sumz7TGBnk0h?=
 =?iso-8859-1?Q?LJS4XiXHYpCNz0ZXjHIPy4hj3HaIgib/KJoqdbSPoi1JjI0NNKI/0JWfFB?=
 =?iso-8859-1?Q?cQUtO/69XWjP5PksVF0/MuVU5EM3LEHdbEgS/qA5nA8gg94F7Jehx7k9c1?=
 =?iso-8859-1?Q?+EpgjfxL0n8ncOSFztkF4UFpU6PvUdzu79BDnu89Ps6e1hKdIHSyMoEL44?=
 =?iso-8859-1?Q?Sgg2tUTfxEdmy+OEVQtVMe5vpYP3NCug22MQD8T7vpcd4D1+o664cDVuID?=
 =?iso-8859-1?Q?aus0IO21ztDn3AvErdjjP+psicAdUayxmIxr+W4ijNelihN7ruOrYrIXQ/?=
 =?iso-8859-1?Q?yFw497Z5ZRVrBAE/rPKISRIDFeR4sGQzfNgHXh413suAFQfOfNte+KWwmW?=
 =?iso-8859-1?Q?Dzai0nlkmeg+3K+0TCuBEYpCn09F2yoiT7YUxevIZQmbiD6PxisYdCmrDS?=
 =?iso-8859-1?Q?NLsZbva58Nf0v4zxiXX+KeZjQx3f49jTbl0MR4jh62NaiiiRVDCqfBYpmJ?=
 =?iso-8859-1?Q?4h3//H9Iuz7RQ97SYAcYntTVjLPfmThq88SqEa+oWmoIutacYO70CKbN11?=
 =?iso-8859-1?Q?PTWJy2QyYZ5n/h5gPaIbHgAiHCyGYVVhVDZOXRioZdcSz/YRiH8l6txg5z?=
 =?iso-8859-1?Q?r10TBN6dDTVGJc2RXyGoZJ3lNSmU4rVktPVYWeXgnqZbcVm7IQmgyO9FxN?=
 =?iso-8859-1?Q?uRNp0B4GtcTF7gDKtXBwGvsxAz+E/uSwKy47zC4AsfA0+HY2NdnVGmjktx?=
 =?iso-8859-1?Q?R60hEb34SFae3a9jSd4EfwDogzbLSV26cQ9BvBw2qQxdGA+/0390j5hPpK?=
 =?iso-8859-1?Q?v/nFNc9geU0xRVL3xv2AmrOrRG3F06kNMKc9hPZJ8oZ4cv5bUT7IwhY0y2?=
 =?iso-8859-1?Q?Bl1u0A9waDhtDMK9PSsWhjC1jqjowWRxMBP6DRY0JW51jegJV/Nml/XUwS?=
 =?iso-8859-1?Q?NP9GQP61cIPzlQoLOJXpeHj9KR2HSB6SpOtnclJ4QFlPMs+8rUcuHQkcTH?=
 =?iso-8859-1?Q?ZbIroDtZZy0w0cY/ybPHm4Zz2FW77i2e+3UxtvJt8lEs6rHHEshyMydmvs?=
 =?iso-8859-1?Q?Dpj7V6PJg2RZ35Rq8N+WpyI/5y0DlEWzYHR8frQa1UdYRpDLaoIYU8h+Pi?=
 =?iso-8859-1?Q?IVdPuC8Q8P5mANy9BYwurNdrADsMf/Ejm4A125flO1In6a?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 775dcdd3-c665-4488-a7e8-08df1ec79b74
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2026 07:51:16.4961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OWppPWm7UeiJZQHGNkBOsyCJAsJXV8r4PLLVWWbICkkkKLrW8Dg8RAvyKBVQcAqL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7843
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

AMD General

SMU debug mail box registers are accessed prior to disabling PCI_COMMAND_ME=
MORY, and PSP bootloader status are accessed after enabling PCI_COMMAND_MEM=
ORY. There is no MMIO BAR access in b/w.

-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Wednesday, September 30, 2026 3:12 PM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; =
Wang, Kevin <Kevin.Wang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd=
.com>; amd-gfx@lists.freedesktop.org
Cc: Yuan, Perry <Perry.Yuan@amd.com>
Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1 reset=
 on gfx12

Well it doesn't matter who gets the request and what do we pool.

The real question is if that goes over the MMIO BAR or the PCIe config spac=
e.

If the SMU debug mailbox registers or PSP bootloader status is accessed ove=
r the MMIO BAR space then I agree with Lijo that the approach of disabling =
all MMIO BAR accesses won't work.

Regards,
Christian.

On 9/30/26 08:35, Zhang, Yifan wrote:
> AMD General
>
>
> On Navi3x/Navi4x, the driver doesn't poll for a response. It sends the mo=
de1 reset request through the SMU debug mailbox and waits a fixed interval =
(SMU13_MODE1_RESET_WAIT_TIME_IN_MS) for the reset to proceed. After that, i=
t polls the PSP bootloader status and the memsize register to confirm the A=
SIC is out of reset. On ASICs where the regular SMU message path is used, t=
he polled response only acknowledges the message; it doesn't indicate that =
the reset has completed.
>
>
>
> *From:*Lazar, Lijo <Lijo.Lazar@amd.com>
> *Sent:* Wednesday, September 30, 2026 2:28 PM
> *To:* Zhang, Yifan <Yifan1.Zhang@amd.com>; Wang, Kevin
> <Kevin.Wang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>;
> Koenig, Christian <Christian.Koenig@amd.com>;
> amd-gfx@lists.freedesktop.org
> *Cc:* Yuan, Perry <Perry.Yuan@amd.com>
> *Subject:* Re: [PATCH] amdgpu/pm: block GPU PCI bar access during
> mode1 reset on gfx12
>
>
>
> AMD General
>
>
>
> The actual reset sequence is run by the FW while you are polling for the =
response. This patch doesn't make any sense in that way.
>
>
>
> Thanks,
>
> Lijo
>
> ----------------------------------------------------------------------
> ----------------------------------------------------------------------
> ----------------------------------------------------------------------
> ----------------------------------------------------------------------
> ----------------------------------------------------------------------
> ----------------------------------------------------------------------
> ----------------------------------------------------------------------
> ----------------------------------------------------------------------
> ----------------------------------------------------------------------
> ----------------------------------------------------------------------
> ----------------------------------------------------------------------
> ----------------------------------------------------------------------
> ----------------------------------------------------------------------
> ----------------------------------------------------------------------
> ----------
>
> *From:*Zhang, Yifan <Yifan1.Zhang@amd.com
> <mailto:Yifan1.Zhang@amd.com>>
> *Sent:* Wednesday, 30 September 2026 11:47:46
> *To:* Wang, Kevin <Kevin.Wang@amd.com <mailto:Kevin.Wang@amd.com>>;
> Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>; Deucher,
> Alexander <Alexander.Deucher@amd.com
> <mailto:Alexander.Deucher@amd.com>>; Koenig, Christian
> <Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>;
> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
> <amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>>
> *Cc:* Yuan, Perry <Perry.Yuan@amd.com <mailto:Perry.Yuan@amd.com>>
> *Subject:* RE: [PATCH] amdgpu/pm: block GPU PCI bar access during
> mode1 reset on gfx12
>
>
>
> AMD General
>
> Yes. In addition, the polling happens inside smu_cmn_send_smc_msg(), whic=
h runs before PCI_COMMAND_MEMORY is cleared. During the mode1 reset process=
 there should be no traffic to the PCIe BARs; otherwise, the PCI bus may ha=
ng.
>
> Also, every PCI config write in the patch targets only the GPU device its=
elf (pci_write_config_dword is per device), so no other PCI devices are aff=
ected.
>
> -----Original Message-----
> From: Wang, Kevin <Kevin.Wang@amd.com <mailto:Kevin.Wang@amd.com>>
> Sent: Wednesday, September 30, 2026 2:09 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>;
> Zhang, Yifan <Yifan1.Zhang@amd.com <mailto:Yifan1.Zhang@amd.com>>;
> Deucher, Alexander <Alexander.Deucher@amd.com
> <mailto:Alexander.Deucher@amd.com>>; Koenig, Christian
> <Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>;
> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
> Cc: Yuan, Perry <Perry.Yuan@amd.com <mailto:Perry.Yuan@amd.com>>
> Subject: RE: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1
> reset on gfx12
>
> AMD General
>
>> On a second look, the patch doesn't seem right. Reset sequence is
>> supposed to be complete by the time FW responds back to the mode-1 reset=
 message.
>> During reset sequence, we need Mem space to be enabled to poll
>> success status of the message and that's most volatile window during
>> the whole sequence.
>
> That is not right. When the OS driver polls and sees the response registe=
r become "1", it does **NOT** mean the mode1 sequence is completed.
> The PMFW will continue forward the message to PSP and wait for PMFW ucode=
 reload to finish at a 2nd-half stage.
>
> Best Regards,
> Kevin
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org
>> <mailto:amd-gfx-bounces@lists.freedesktop.org>> On Behalf Of Lazar,
>> Lijo
>> Sent: Wednesday, September 30, 2026 1:41 PM
>> To: Zhang, Yifan <Yifan1.Zhang@amd.com
>> <mailto:Yifan1.Zhang@amd.com>>; Deucher, Alexander
>> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>;
>> Koenig, Christian <Christian.Koenig@amd.com
>> <mailto:Christian.Koenig@amd.com>>; amd-gfx@lists.freedesktop.org
>> <mailto:amd-gfx@lists.freedesktop.org>
>> Cc: Yuan, Perry <Perry.Yuan@amd.com <mailto:Perry.Yuan@amd.com>>
>> Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during mode1
>> reset on gfx12
>>
>> On a second look, the patch doesn't seem right. Reset sequence is
>> supposed to be complete by the time FW responds back to the mode-1 reset=
 message.
>> During reset sequence, we need Mem space to be enabled to poll
>> success status of the message and that's most volatile window during
>> the whole sequence.
>>
>> Disabling the memory space after reset sequence is complete looks to
>> be the wrong diagnosis of the issue. Access during reinit sequence
>> after reset is safe and shouldn't cause any issue in general.
>>
>> That said, we should try to resolve the issue without touching any
>> PCI config settings. PCI config space is open for others as well.
>>
>> Thanks,
>> Lijo
>>
>> On 30-Sep-26 10:57 AM, Zhang, Yifan wrote:
>> > AMD General
>> >
>> > How about disable UE during mode1 reset ? E.g.
>> >
>> > Before:
>> >          pcie_capability_read_word(pdev, PCI_EXP_DEVCTL,
>> >&saved_devctl);
>> >          pcie_capability_write_word(pdev, PCI_EXP_DEVCTL,
>> >                                     saved_devctl &
>> >~PCI_EXP_DEVCTL_URRE);
>> >          pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_MASK,
>> >                                        &saved_uemsk);
>> >          pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_MASK,
>> >                                         saved_uemsk |
>> >PCI_ERR_UNC_UNSUP);
>> >
>> >
>> > After:
>> >          pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_MASK,
>> >                                         saved_uemsk);
>> >          pcie_capability_write_word(pdev, PCI_EXP_DEVCTL,
>> >saved_devctl);
>> >
>> > -----Original Message-----
>> > From: Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>
>> > Sent: Wednesday, September 30, 2026 11:37 AM
>> > To: Zhang, Yifan <Yifan1.Zhang@amd.com
>> > <mailto:Yifan1.Zhang@amd.com>>; Deucher, Alexander
>> > <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>;
>> > Koenig, Christian <Christian.Koenig@amd.com
>> > <mailto:Christian.Koenig@amd.com>>; amd-gfx@lists.freedesktop.org
>> > <mailto:amd-gfx@lists.freedesktop.org>
>> > Cc: Yuan, Perry <Perry.Yuan@amd.com <mailto:Perry.Yuan@amd.com>>
>> > Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during
>> > mode1 reset on gfx12
>> >
>> >
>> > This is the behaviour of this bit -
>> >
>> >          Memory Space Enable - Controls a Function's response to
>> >Memory  Space accesses. When this bit is Clear, all received Memory
>> >Space
>> accesses are caused to be handled as "Unsupported Requests"
>> >
>> > On AER enabled systems, depending on how the platform is configured
>> > to
>> classify the severity of UR errors, that could result in System error.
>> >
>> > On other hand, if you are sure that there is no such access during
>> > mode-1 reset, we don't need this patch in the first place.
>> >
>> > Thanks,
>> > Lijo
>> >
>> >
>> > On 30-Sep-26 8:53 AM, Zhang, Yifan wrote:
>> >> AMD General
>> >>
>> >> Hi Lijo,
>> >>
>> >> Why does clearing PCI_COMMAND_MEMORY cause AER errors on data
>> center GPUs? Are their PCIe BARs still being accessed during a mode1 res=
et?
>> >>
>> >> Best Regards,
>> >> Yifan
>> >>
>> >> -----Original Message-----
>> >> From: Lazar, Lijo <Lijo.Lazar@amd.com <mailto:Lijo.Lazar@amd.com>>
>> >> Sent: Wednesday, September 30, 2026 11:06 AM
>> >> To: Zhang, Yifan <Yifan1.Zhang@amd.com
>> >> <mailto:Yifan1.Zhang@amd.com>>; Deucher, Alexander
>> >> <Alexander.Deucher@amd.com <mailto:Alexander.Deucher@amd.com>>;
>> >> Koenig, Christian <Christian.Koenig@amd.com
>> >> <mailto:Christian.Koenig@amd.com>>; amd-gfx@lists.freedesktop.org
>> >> <mailto:amd-gfx@lists.freedesktop.org>
>> >> Cc: Yuan, Perry <Perry.Yuan@amd.com <mailto:Perry.Yuan@amd.com>>
>> >> Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during
>> >> mode1 reset on gfx12
>> >>
>> >> This doesn't work for all (at least on some datacenter GPUs). With
>> >> AER
>> enabled, this will result in AER errors. Depending on the platform
>> config, some may classify this access as fatal.
>> >>
>> >> Thanks,
>> >> Lijo
>> >>
>> >> On 30-Sep-26 8:25 AM, Zhang, Yifan wrote:
>> >>> Public
>> >>>
>> >>>
>> >>> Hi Alex,
>> >>>
>> >>> I think it is reasonable to apply the patch to all ASICs. I will
>> >>> sync with the hardware team about this change; so far we have
>> >>> only tested it on Navi31.
>> >>>
>> >>> How about adding a common helper and calling it from
>> >>> ASIC-specific code, starting with Navi31? For example:
>> >>>
>> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> >>> b/drivers/gpu/ drm/amd/amdgpu/amdgpu_device.c
>> >>>
>> >>> index b690a07e31ab..075de681ab86 100644
>> >>>
>> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> >>>
>> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> >>>
>> >>> @@ -4931,6 +4931,28 @@ bool
>> amdgpu_device_should_recover_gpu(struct
>> >>> amdgpu_device *adev)
>> >>>
>> >>>                    return false;
>> >>>
>> >>> }
>> >>>
>> >>> +void amdgpu_device_mode1_reset_wait(struct amdgpu_device *adev,
>> >>>
>> >>> +                                   unsigned int delay_ms)
>> >>>
>> >>> +{
>> >>>
>> >>> +       u16 saved_cmd, cmd;
>> >>>
>> >>> +
>> >>>
>> >>> +       pci_read_config_word(adev->pdev, PCI_COMMAND,
>> >>> +&saved_cmd);
>> >>>
>> >>> +       cmd =3D saved_cmd & ~PCI_COMMAND_MEMORY;
>> >>>
>> >>> +       pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
>> >>>
>> >>> +
>> >>>
>> >>> +       msleep(delay_ms);
>> >>>
>> >>> +
>> >>>
>> >>> +       pci_write_config_word(adev->pdev, PCI_COMMAND,
>> >>> +saved_cmd);
>> >>>
>> >>> +}
>> >>>
>> >>> +
>> >>>
>> >>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> >>> b/drivers/ gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> >>>
>> >>> index b250c5e41e45..356e09b7eef9 100644
>> >>>
>> >>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> >>>
>> >>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>> >>>
>> >>> @@ -2242,7 +2242,8 @@ int smu_v13_0_mode1_reset(struct
>> smu_context
>> >>> *smu)
>> >>>
>> >>>            ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_Mode1Reset,
>> >>>NULL);
>> >>>
>> >>>            if (!ret)
>> >>>
>> >>> -               msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
>> >>>
>> >>> +               amdgpu_device_mode1_reset_wait(smu->adev,
>> >>>
>> >>> +
>> >>> SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
>> >>>
>> >>>            return ret;
>> >>>
>> >>> }
>> >>>
>> >>> Best Regards,
>> >>>
>> >>> Yifan
>> >>>
>> >>> *From:*Deucher, Alexander <Alexander.Deucher@amd.com
>> >>> <mailto:Alexander.Deucher@amd.com>>
>> >>> *Sent:* Wednesday, September 30, 2026 2:59 AM
>> >>> *To:* Zhang, Yifan <Yifan1.Zhang@amd.com
>> >>> <mailto:Yifan1.Zhang@amd.com>>; Koenig, Christian
>> >>> <Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>;
>> >>> amd-gfx@lists.freedesktop.org
>> >>> <mailto:amd-gfx@lists.freedesktop.org>
>> >>> *Cc:* Yuan, Perry <Perry.Yuan@amd.com
>> >>> <mailto:Perry.Yuan@amd.com>>
>> >>> *Subject:* Re: [PATCH] amdgpu/pm: block GPU PCI bar access during
>> >>> mode1 reset on gfx12
>> >>>
>> >>> Public
>> >>>
>> >>> I think this should be asic agnostic.  Any asic doing mode1 reset
>> >>> should do this?
>> >>>
>> >>> Alex
>> >>>
>> >>> -----------------------------------------------------------------
>> >>> -
>> >>> --
>> >>> -
>> >>> -
>> >>> --
>> >>>
>> >>> *From:*Zhang, Yifan <Yifan1.Zhang@amd.com
> <mailto:Yifan1.Zhang@amd.com%0b>> >>> <mailto:Yifan1.Zhang@amd.com
> <mailto:Yifan1.Zhang@amd.com>>>
>> >>> *Sent:* Tuesday, September 29, 2026 5:36 AM
>> >>> *To:* Koenig, Christian <Christian.Koenig@amd.com
> <mailto:Christian.Koenig@amd.com%0b>> >>>
> <mailto:Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>>;
> amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>> >>> <mailto:amd-gfx@lists.freedesktop.org
>> >>> <mailto:amd-gfx@lists.freedesktop.org>>
>> >>> <amd-gfx@lists.freedesktop.org
> <mailto:amd-gfx@lists.freedesktop.org%0b>> >>>
> <mailto:amd-gfx@lists.freedesktop.org
> <mailto:amd-gfx@lists.freedesktop.org>>>
>> >>> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com
> <mailto:Alexander.Deucher@amd.com%0b>> >>>
> <mailto:Alexander.Deucher@amd.com
> <mailto:Alexander.Deucher@amd.com>>>; Yuan, Perry
>> <Perry.Yuan@amd.com
> <mailto:Perry.Yuan@amd.com%0b>> >>> <mailto:Perry.Yuan@amd.com
> <mailto:Perry.Yuan@amd.com>>>
>> >>> *Subject:* RE: [PATCH] amdgpu/pm: block GPU PCI bar access during
>> >>> mode1 reset on gfx12
>> >>>
>> >>> Public
>> >>>
>> >>> Hi Christian,
>> >>>
>> >>> The no_hw_access flag was first set in commit
>> >>> 0de604d0357d0d22cbf03af1077d174b641707b6. This was intended to
>> >>> fix the Mode 1 reset hang, but it proved insufficient.
>> >>> I think the flag was set in the SMU code so that it would apply
>> >>> only to
>> >>> SMU13/14 ASICs, without affecting the Mode 1 reset process on
>> >>> other
>> ASICs.
>> >>> I'm not sure whether we can drop the no_hw_access flag after
>> >>> disabling PCI_COMMAND_MEMORY. The PCI hang occurs intermittently,
>> so
>> >>> we may need another round of stress testing to confirm that the
>> >>> flag is no longer needed. Should we remove no_hw_access in a
>> >>> separate
>> patch?
>> >>>
>> >>> Best Regards,
>> >>> Yifan
>> >>>
>> >>> -----Original Message-----
>> >>> From: Koenig, Christian <Christian.Koenig@amd.com
> <mailto:Christian.Koenig@amd.com%0b>> >>>
> <mailto:Christian.Koenig@amd.com <mailto:Christian.Koenig@amd.com>>>
>> >>> Sent: Tuesday, September 29, 2026 5:06 PM
>> >>> To: Zhang, Yifan <Yifan1.Zhang@amd.com
> <mailto:Yifan1.Zhang@amd.com%0b>> >>> <mailto:Yifan1.Zhang@amd.com
> <mailto:Yifan1.Zhang@amd.com>>>; amd-gfx@lists.freedesktop.org
> <mailto:amd-gfx@lists.freedesktop.org>
>> >>> <mailto:amd-gfx@lists.freedesktop.org
>> >>> <mailto:amd-gfx@lists.freedesktop.org>>
>> >>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com
> <mailto:Alexander.Deucher@amd.com%0b>> >>>
> <mailto:Alexander.Deucher@amd.com
> <mailto:Alexander.Deucher@amd.com>>>; Yuan, Perry
>> <Perry.Yuan@amd.com
> <mailto:Perry.Yuan@amd.com%0b>> >>> <mailto:Perry.Yuan@amd.com
> <mailto:Perry.Yuan@amd.com>>>
>> >>> Subject: Re: [PATCH] amdgpu/pm: block GPU PCI bar access during
>> >>> mode1 reset on gfx12
>> >>>
>> >>> On 9/29/26 04:25, Yifan Zhang wrote:
>> >>>> block GPU PCI bar access during mode1 reset on gfx12, to resolve
>> >>>> the random mode1 reset hang issue.
>> >>>
>> >>> Interesting idea, that is much simpler than trying to mess with
>> >>> CPU page tables in the GPU reset path.
>> >>>
>> >>> The only downside I can see is that we now drop VRAM and doorbell
>> >>> writes, but I think that won't matter since VRAM is lost by a
>> >>> mode1 reset anyway.
>> >>>
>> >>> MMIO writes are dropped as well which means that we can also drop
>> >>> the no_hw_access flag.
>> >>>
>> >>> And BTW the SMU code should absolutely *NOT* touch that
>> no_hw_access
>> >>> flag in any way. Who added that there?
>> >>>
>> >>> Regards,
>> >>> Christian.
>> >>>
>> >>>>
>> >>>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com
> <mailto:yifan1.zhang@amd.com%0b>> >>>> <mailto:yifan1.zhang@amd.com
> <mailto:yifan1.zhang@amd.com>>>
>> >>>> ---
>> >>>>    .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 29
>> >>>> ++++++++++++-------
>> >>>>    1 file changed, 19 insertions(+), 10 deletions(-)
>> >>>>
>> >>>> diff --git
>> a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>> >>>> b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>> >>>> index 072d9c4e202d..25b9085ead71 100644
>> >>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>> >>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
>> >>>> @@ -2078,21 +2078,30 @@ static int
>> >>>> smu_v14_0_2_set_df_cstate(struct smu_context *smu,
>> >>>>
>> >>>>    static int smu_v14_0_2_mode1_reset(struct smu_context *smu)
>> >>>>{
>> >>>> +     struct amdgpu_device *adev =3D smu->adev;
>> >>>> +     u16 saved_cmd, cmd;
>> >>>>         int ret =3D 0;
>> >>>>
>> >>>>         ret =3D smu_cmn_send_debug_smc_msg(smu,
>> DEBUGSMC_MSG_Mode1Reset);
>> >>>> -     if (!ret) {
>> >>>> -             if (amdgpu_emu_mode =3D=3D 1) {
>> >>>> -                     msleep(50000);
>> >>>> -             } else {
>> >>>> -                     /* disable mmio access while doing mode 1
>> >>>> reset*/
>> >>>> -                     smu->adev->no_hw_access =3D true;
>> >>>> -                     /* ensure no_hw_access is globally visible
>> >>>> before any MMIO */
>> >>>> -                     smp_mb();
>> >>>> -                     msleep(1000);
>> >>>> -             }
>> >>>> +     if (ret)
>> >>>> +             return ret;
>> >>>> +
>> >>>> +     pci_read_config_word(adev->pdev, PCI_COMMAND, &saved_cmd);
>> >>>> +     cmd =3D saved_cmd & ~PCI_COMMAND_MEMORY;
>> >>>> +     pci_write_config_word(adev->pdev, PCI_COMMAND, cmd);
>> >>>> +
>> >>>> +     if (amdgpu_emu_mode =3D=3D 1) {
>> >>>> +             msleep(50000);
>> >>>> +     } else {
>> >>>> +             /* disable mmio access while doing mode 1 reset*/
>> >>>> +             smu->adev->no_hw_access =3D true;
>> >>>> +             /* ensure no_hw_access is globally visible before
>> >>>> +any MMIO */
>> >>>> +             smp_mb();
>> >>>> +             msleep(1000);
>> >>>>         }
>> >>>>
>> >>>> +     pci_write_config_word(adev->pdev, PCI_COMMAND, saved_cmd);
>> >>>> +
>> >>>>         return ret;
>> >>>>    }
>> >>>>
>> >>>
>> >>
>> >
>


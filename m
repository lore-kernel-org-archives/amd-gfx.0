Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF85FECAAA3
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Aug 2022 15:30:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB33310E985;
	Fri, 26 Aug 2022 15:30:42 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2066.outbound.protection.outlook.com [40.107.212.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD21D10E988
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Aug 2022 15:30:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKQZ6ov6O2bgkE91/Fa/dhtdKOqyOI2GMt2SYYOQOnokUWpgeCm0MxLgdrzWnXR4d9Jje2cH4YPW8QX4dhmP7IegTJajEcmt99Vq5iMZM+KldkePcRF9QHXHdDv72mFii1kLOWAOtLIo/klwCeDDV0HiFIPqaIkADeByFGtVyUtUs18wf55QjFtEdqFhL42/Oa3bfwjNUsvZm58mQF0VA0SnPo+6m9MbbQcRT9zM3fePWkQvd7ZbHzVb2TobE/MHdOcU4xkcdiKESV+xk3NPFEuOl5SpDMuHqM9qO0LxFjToUDyjBJZMd9PJHlYHH9F7XEGcEfeVIMwPCKdF7eBZmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kb9CQB7aLPnGIEgOWgQim1qPVnL5GVXVVtMY2nLzSfQ=;
 b=JZcAIY9TGhCno9/MnM9gi39ZyyzlyoMIj+2PiTw3GKx5aKwiCZixYxHjt+TXNks27wlK9brfgPfWB2cvsIjFGstzRPhP7uYyon6dn75wFgFIuWFuex5X7wH+NdyvrE6BWd8/8GawBPlmCYfiwra//IuSJQXW4ebaW12YjhAvV/Zd2AuetlU/L0lGMNsgrCoNve+38Ge9VJDgH/aPq4kKg/qWLU9U8vo8GRpMYC1lKEJ9yObdLS1dDL6ZCTMOSEmiQ4iMBKqaaYJnOK4zjkKV1OVA4vrYp+WJ8qAL2TSObZ2iRzdLP9ruusXzlKzpf2a0VGrtjINeZUhDeDSPwQYBVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kb9CQB7aLPnGIEgOWgQim1qPVnL5GVXVVtMY2nLzSfQ=;
 b=NlCwclQMsOIwqqsT6FZyM5HAFNlgaUh+1/0kB3lcl8esIKB1sxJ4+fJF3YAf+ueKLhYAtMcOUygaxQZr34uigM5gjyce0ROWUuP6NNmhknFs0Anvkq/bi+yeL28s4nsPe/kyo0l+ckD0E/YFd2r7CXWO8mZuZYMdPNBHYSfpuqA=
Received: from DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) by
 BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 15:30:37 +0000
Received: from DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::5097:87be:3557:c681]) by DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::5097:87be:3557:c681%5]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 15:30:37 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Handle potential NULL pointer dereference
Thread-Topic: [PATCH] drm/amdgpu: Handle potential NULL pointer dereference
Thread-Index: AQHYsLzZTS2TJPBDNkGN/BMXH268U62/jwIAgAANeICAAALpQIAAAnjwgAG7LYCAAAI9AA==
Date: Fri, 26 Aug 2022 15:30:37 +0000
Message-ID: <DM5PR12MB13084D9C6644873E447F608B85759@DM5PR12MB1308.namprd12.prod.outlook.com>
References: <20220815153123.138156-1-kent.russell@amd.com>
 <DM5PR12MB1308B61FF812A91CA0FC77EC85729@DM5PR12MB1308.namprd12.prod.outlook.com>
 <4f4292c0-7841-a955-c07c-1eb8f1aa9293@amd.com>
 <DM5PR12MB1308A8C9A177803B3FF55D9185729@DM5PR12MB1308.namprd12.prod.outlook.com>
 <DM5PR12MB1308E2A5CC5682F7DA944BFD85729@DM5PR12MB1308.namprd12.prod.outlook.com>
 <YwjkiZCTGpWNFaD6@yaz-fattaah>
In-Reply-To: <YwjkiZCTGpWNFaD6@yaz-fattaah>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-08-26T15:30:35Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=34a555e3-2805-45e6-a00f-887c1af556d9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36d071b8-0b48-44db-4ab6-08da8777ece1
x-ms-traffictypediagnostic: BN9PR12MB5052:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rXkjvwqzFB0uAcbuUsXCJfeztZgtNNKYakcVaG+oX6FiaGFNo1TuVrlkn0nd+da2sjFIqdK1IS2rXJ9a7YFbs3Q0Uzl93d+V/YT2u6lK6edwC5sims2VMa1gC1t/tr8cSQHPpCBT2ZaRDl4plBgs9pZg/cAJ46YlpyBGCyHgFDZpepylYhAKhz/jQNG82m4W/1xwMxYwObb812aUpDFFHrY9DFZSh8el7WrIBgIXS3PiSVSDDadQ85cb66dTZHeRzbWOviWHqTrTtZRf1XFGO7ARHWzVpn2HTiFfGBD0hDwjiNTfs0HXYUCHY2l09rv3uqcN1X70fMLDG46xffZgUe3aHkp6Z8b8S0EHPi/MlzXoFSMBK5pUYbQNJSPiblNcIyMRr3ZkhCDad9M5b1Nkb+gFLnSnhmVLEiVjVY//QjvkJO55W0UCLqcR5MzAAqTDCA21owxPXKmam8DZkfp1YMY4F7WADDlL5BdReg6qUxCIhI5mYlLcjJcKvaHiW2E6q8UBmJk9QEplH7iTA3xGlwkjNK5is9QNaaJsJRQjjCoYUEK4i0rgMTOQnx9qbAcerIdRkMdWq9BdTIB+JnQzaKa4kOCgV+OtrUYEHA9rwMv5zBFDgfivLtdvXMzlkbt/626APeAQkiGhFDhjg2dfPtynLAUMV2ugh+IlESt51wnsG7AxldsJiZ3SH1Ta1ZmRqmbZZ92qctClTp779S0wiGgAKYPLp83a8jxg/9JVJ+pQVMyhGiZ+Cve+76Fe2qNoUz8srjdPDvsJQODyD/cKdg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(55016003)(7696005)(41300700001)(76116006)(6506007)(4326008)(8676002)(66946007)(64756008)(33656002)(5660300002)(66556008)(478600001)(8936002)(6862004)(53546011)(122000001)(66446008)(52536014)(66476007)(86362001)(83380400001)(186003)(316002)(9686003)(38070700005)(26005)(2906002)(38100700002)(6636002)(54906003)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wDoM1cnxO1HuUVL4kORoFqks2LjHvvoOgM+T5snyQdNOnf409+ZGPm2QBGpL?=
 =?us-ascii?Q?TA6FGvSMqY4bOoaOIXWbcsHLx9OvhiMMuAbM62oHoG6KAlGRv1SdygSwNsNc?=
 =?us-ascii?Q?pSyvGZDTKM8DRbyoVSy7caOADl1EDf52JR6hyj9C8a8InGLhaKNB3nojqZPM?=
 =?us-ascii?Q?Pw8JCBeOhOfu7D5+7IbfsQzPMjw7ZbXKf7XBwvHPXkA5/c+SIZcXcnh/QMKo?=
 =?us-ascii?Q?zbNez4Nz+peOPWZ1Wk9eoxm/M/oXwZTck+zBvAuvrDpKEd9YP89wFc+6L5uQ?=
 =?us-ascii?Q?xiN/mEh3qR5h27YdQcRrtfDcDAiB4tqz4O5S0b1JVyXo7mAybR+CpxhvMFg4?=
 =?us-ascii?Q?rov0//UAgFdkFVvyDWQqnwA7en4O3iBSox2meKdECLvmzNbDsiFoi/gvLNXj?=
 =?us-ascii?Q?1fHa+TASgvsbvV5cnmcdRts1xwNHFV6ngpZqq16mI5UFg0foMpupSGeUTLeL?=
 =?us-ascii?Q?lJI01us+bx5xCP+yEFTELFqdxdjly4xIUnKGkR/NwHnx8O4GVf1bz1jbkZpY?=
 =?us-ascii?Q?fFvJ0YmADQJdNr87WZAILCqY7r1s163ETKfFNqRI/OlEgtg38lzQh/M+q2DY?=
 =?us-ascii?Q?iHL5h74dHUOxYAaoyZN4WX6839Y3yrHgbRr7vqJfH3dzMXB3Bhn5M5zRFHj3?=
 =?us-ascii?Q?vqFAUQ2BUUr0nsXlLtpaClWzKLiJvabGRwRcs8WQrex3TQSUKWKPP9wnaVMS?=
 =?us-ascii?Q?Y0pv7z+cYmy+/NifzY7aVwR+2avzIHvVw86F9Ic+az3aMVI7DQr7MHrkkLD0?=
 =?us-ascii?Q?B1c9Fn7qlJ+IAl20DmTjsg/4FRYZQZ7ygrwh4aywuFdLs3wHfxeItza4GzKY?=
 =?us-ascii?Q?fxKwxTcegkzfyG8eqFVxLz40dNJqjvIWt003lrlqJ5j2wYu7NoWknrNjpaqR?=
 =?us-ascii?Q?3b+WEtgM4Q9tHnrYXiIG07vfpLRHPh+OQs7sOnI8QuzsyNWtp4EKt/6X8Oko?=
 =?us-ascii?Q?mD7YDL6uYExbpdRjaQ5DAmEEiwvGNpwh2qv6KydXsgULejw8GUvhH5U3/dWA?=
 =?us-ascii?Q?nguE0MOajgjRe4JwyCKm+Hr+enm0YQZqym8Ort14KcdbmsP9JzcYPh9UgRYX?=
 =?us-ascii?Q?gbgd5vYL+N9fvyMc6WSJIuF+Dl6HSuP4dL4Emfv2jrtt8/ALpdc13L32SxtS?=
 =?us-ascii?Q?78FZzByLbfu4x0uZA9JZyPPp4ncht3/AYIY+ak2zLDZgkQ8DOLyM/sDXwHM7?=
 =?us-ascii?Q?m9o+3c4iyjfVGVVrcETF6FVN4lpRBRYxWmq3FdP52QqmDGiUajqNqzP8lVl2?=
 =?us-ascii?Q?KC4Y0BoOnBeze+yQHmmFnmyV1kCPRTKqCjt6pFW74W9J78fsPilkj4lYGrJA?=
 =?us-ascii?Q?8dDe7d5oLxoaH9bILYP0kAUiG23E6WWthiXt91riOCTTxE+ipv2LE/YN2vDn?=
 =?us-ascii?Q?i3z2lv28By9b51IZWdwyna7B4j+43hR309CxOLat5EHKGZ77ZZ3OMsSMz5ub?=
 =?us-ascii?Q?6wT/ynfAirDx19Q7+vT+lvtzoE/0VPEI4Ff/Lu80fCK+YssTptyg7xlSMX+9?=
 =?us-ascii?Q?EES5SOWL0/aIbBGs3U+peIcB1j687JHPSs83NefqSp3RbwX8PDPK9mPHhdtb?=
 =?us-ascii?Q?5wqBp+N+WPsNBBFvwho=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d071b8-0b48-44db-4ab6-08da8777ece1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 15:30:37.1235 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l7zduaPxHyy91yn1lZiuyHjIdGn8KlF5K3WpdEpcVzTgeZImwl//UAYXXYXji665zl523YcPf/JAQQTF+n8C/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5052
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
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: Ghannam, Yazen <Yazen.Ghannam@amd.com>
> Sent: Friday, August 26, 2022 11:20 AM
> To: Russell, Kent <Kent.Russell@amd.com>
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: Handle potential NULL pointer dereferenc=
e
>=20
> On Thu, Aug 25, 2022 at 08:54:46AM -0400, Russell, Kent wrote:
> > [AMD Official Use Only - General]
> >
> > It does indeed short-circuit on || (If the left side of an || statement=
 is not 0, it
> doesn't evaluate the right side and returns true). So we can ignore this =
patch,
> since checking for each individual field on the 2nd term is probably over=
kill. We
> were still investigating what got passed in and why it wasn't valid, so I=
'll drop this
> for now. Thanks Lijo!
>=20
> Right, the "||" will short-circuit, but not the "&&".
>=20
> ...
>=20
> > > +	if (!m)
> > > +		return NOTIFY_DONE;
> > > +
> > >   	/*
> > >   	 * If the error was generated in UMC_V2, which belongs to GPU UMCs=
,
> > >   	 * and error occurred in DramECC (Extended error code =3D 0) then =
only
> > >   	 * process the error, else bail out.
> > >   	 */
> > > -	if (!m || !((smca_get_bank_type(m->extcpu, m->bank) =3D=3D
> SMCA_UMC_V2) &&
> > > +	if (!((smca_get_bank_type(m->extcpu, m->bank) =3D=3D SMCA_UMC_V2) &=
&
> > >   		    (XEC(m->status, 0x3f) =3D=3D 0x0)))
>=20
> If m is NULL, then we get (!m || "Don't care") =3D true. We avoid the sec=
ond
> operand.
>=20
> But then we have (true && "Something with 'm->' in it"). The second opera=
nd in
> the && needs to be checked, and this will cause a NULL pointer dereferenc=
e if
> m is NULL.
>=20
> What do you guys think?
>=20

Since the 2nd field is in parentheses, it would be
whatever =3D (smca_get_bank_type && XEC)
if (!m || !(whatever))

In that case we should still jump out at !m, since the 2nd term is complete=
ly contained in that !((...)) clump. At least that's how I understand it af=
ter Lijo's original comments.

 Kent


> Thanks,
> Yazen

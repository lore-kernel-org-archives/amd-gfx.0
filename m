Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15514C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Nov 2022 17:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44E7789316;
	Tue, 15 Nov 2022 17:52:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C841689316
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 17:52:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRJaAw0QLj2EK5jl35+mXPmsHez7uFVti3Q6LbGxundrcufUtMjqISzZsC5nEj3OdyjrrNpPd9s9et4a5DmwgTzN6hlKzWjGxRJLegkn5z+5bhsY9eDnUPyNWrlRWCZdcy8lfcn+bdTkVq4YAlPh3geMTYJViyjmjKpC1uuXBAJqYnJe/QUUVTo2WTXIUe4bZR/nK8gJeggHKc518WTLy8G+oqFQBxGHc/butdxmCkEMUfKJLopjxjzhvT7g8vaT2q7WdmFsx4oncbpnaGcs9cLXbLpj1ZIdyyDFwqo/5fam6TYPe172xWMJOsq/82FDKGI8sGaHznQI5vFinQVj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glGanrulkQ1H4Y3Jj4DsswBfRH7axUJgggttWOcahgc=;
 b=lUuJIdfgcKZhdOJ1Oj4N3/PGpvGHWFCuRW7au/YI5fWimfCzm8iURIDWL1AcZCw3QxntpZ+4CRWUdCXgGDZ10/bAcEuZbH6BgAOt3IelKBFKZmB11/trdFCWFdaj4lzrcJSPafiW2TRsQoFNUJl9kyIXQK0EDLGVO9xNWTNrHzfJ78hL5d/gdtmLYdiWk0wG32yAHbUMd/VAfIih+bDTaMr3IR1d2Gtb+pcDrqsuLUudyvA7G1fieebflSGh70O8QccYz3Vo1kX13kPSg2e/FVqmDCTjMG0xfwUKJKz/7vdGmchkMPWeWSiFwjByf5aNP8EdmNGTklVVGgXiMi6qaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glGanrulkQ1H4Y3Jj4DsswBfRH7axUJgggttWOcahgc=;
 b=xq9+Ynv1Um3ZJo0C3YQXZQxHTGWBbEf2Gm9Ud4EBqsGcV5ulfkX+VF2aGG3OGnS3rQl6uHdRkZi0wut0+jtX0+CTQyWNKVm5ZfgaYSWX+8A3cKVnkJLwKWzWR76JGrTdEwT1W2HvDMzqJbxMrpDjHKb3aECpBqqJoAF5mGSXUzI=
Received: from BN6PR1201MB0084.namprd12.prod.outlook.com
 (2603:10b6:405:57::22) by IA1PR12MB6188.namprd12.prod.outlook.com
 (2603:10b6:208:3e4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 17:51:58 +0000
Received: from BN6PR1201MB0084.namprd12.prod.outlook.com
 ([fe80::2046:72ad:521a:3fbc]) by BN6PR1201MB0084.namprd12.prod.outlook.com
 ([fe80::2046:72ad:521a:3fbc%11]) with mapi id 15.20.5813.018; Tue, 15 Nov
 2022 17:51:56 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Rizvi, Saaem" <SyedSaaem.Rizvi@amd.com>
Subject: RE: [PATCH] drm/amd/display: Align dcn314_smu logging with other DCNs
Thread-Topic: [PATCH] drm/amd/display: Align dcn314_smu logging with other DCNs
Thread-Index: AQHY+G0R3zb7i8GN70KxFMiwTtACtK4+67kAgAAQMnA=
Date: Tue, 15 Nov 2022 17:51:56 +0000
Message-ID: <BN6PR1201MB008440D72339B49E7E576CF089049@BN6PR1201MB0084.namprd12.prod.outlook.com>
References: <20221114210701.23185-1-Roman.Li@amd.com>
 <MN0PR12MB61018FC7358247F0A2D476E9E2059@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB61018FC7358247F0A2D476E9E2059@MN0PR12MB6101.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-11-14T21:10:25Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=db96694a-48f2-4a3b-a61c-ab539de75e9a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR1201MB0084:EE_|IA1PR12MB6188:EE_
x-ms-office365-filtering-correlation-id: 740d20fd-5057-4543-d8a2-08dac73216a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NksTfj0GK5+HsTqa5+9t0Pq2Jpv6Ey9SgtVRlfDWSbpeeFKODoPPzO4HDFrZKXXDFOzx8JScGlj495AM9aB2YMh73nCAP2a4Bovlsbshsy1F9la764Ds2kNCtXG/VXyYSs+rqBen5XiX+zH3LbHq58RYYMIXzjYurLAlSmdfCYGJk5AHQYoIF4GgAscyjgCsxs3jXwqkukDzzIJn/kGki7lPEfM7d2j5v/qT69DpA9D3vzC1oqTJmuCivMTXSOLeg5nZr8RmL5BePfBZCpAKFjuOxnAyo6UA1beMoaykdreFoLqrgXjwidOLlRF/XArcr1fG0dUwdh1CxNmv7cTco9KO0VontXNM3a4iwhUcTnoz1mc4ttJmgZEvQyh34xng0faNGw/GqamPaP2DaoK1w75SizsKrNVqNgC510VQ5G+8FPhuBdPJ2hs4/Rb0VAFDKVq+uBss+CG4k+xZL97per0hDAjDv0j8ys2gLtmmCOql9FMuaHxn0z3QeV6OfsnLX66JKwxkv8SPC21PIvSGKk3x1/SsNHcplj9P4bN5qXmDiU223JdRQaiB0PqDKzujoE0ySGKxs9XsYaC5+YDPqu8wJjCbxpeSPuv+NNGmymerPApZ9jCFOVgsZPXokR0GjonsJO8zqWHw7Vcnv/HyNANOcpFfKtInBFPra5Pd6m6BrAtclJprqjsXTtPg2Fccr9FAMMrnkKlFLDsNJXzrB71wbxtGbZr1GkaHAuKqUc79oNMXOcI7qO4uLkicSRaogF3HU8ZZ4FI4rcak5Cvgxg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB0084.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199015)(52536014)(9686003)(26005)(76116006)(53546011)(6636002)(186003)(316002)(8936002)(41300700001)(8676002)(66556008)(64756008)(66446008)(66476007)(66946007)(110136005)(83380400001)(6506007)(7696005)(2906002)(86362001)(38070700005)(5660300002)(38100700002)(55016003)(122000001)(33656002)(478600001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UKjnIpx2qLLNSQpq29/9vgqrJQt6S7qRhxMB+HKCpINsMQXiyUH+6yzvtPzq?=
 =?us-ascii?Q?fLFO5MmhAWB63ADQVA1eHSueEQ5wmRSUzpPE0uPqQ7wPUzcIbbMCs4iJarB+?=
 =?us-ascii?Q?k8ioZn6Co43loCmuvTtrDjLFsj8ICz70kv/LjdqqwGb/rmxy7V8V8U0G8Hnx?=
 =?us-ascii?Q?cg4jFB2Nf3FJDDvEt48AhiWzVCYHrWdHc+RuPcWHXB2qINIa5iIy/wWGh0Sc?=
 =?us-ascii?Q?3ve/3q3m667NbwuVgIGRK+iAA8f2q8tCr12eSP6BYbYsIY8CX1gCkPNLuMJ9?=
 =?us-ascii?Q?Hg8nir1BoUs9aMONgNhAKBoT66KtMnxud21ONGsUM1V0yLuiGxdulK2t3zOJ?=
 =?us-ascii?Q?5JD1VdnZ4yNyt3FcF0jrwS6DQ23wEFRY9urxPyYbbam/KDvUd0RvYTaOsKH9?=
 =?us-ascii?Q?92i1Av5iF0nbj9EFGL3wdRInJ3+gLitPqvo6NgLQpTB5B+sodA18gaSyXI0n?=
 =?us-ascii?Q?gjI096FWJDqj5ECQzYjfWzDJg0b8eZvvMM+S7E4e1WlBLJEv2FZoRGH4KfXp?=
 =?us-ascii?Q?eGFqNKbYqC/+EV+K4HBUEuBkDCGkAuEXxC3e6xcia0dVC1mUvX4kvsiiOPEy?=
 =?us-ascii?Q?AtG6Z8pitHZoysicTIABjfVNXqbYpLg4Uaesf7ZjZHjwlfih6IcLvWcpB+ky?=
 =?us-ascii?Q?lu3NSBa4E/+kJKACIBYbdmEvWod5RvD1L6K1MXxHoKlRyIOlDrwcGTyic2Gb?=
 =?us-ascii?Q?E3yR16utv2t7X/GQ+w/RXO2gHP60GeJU03m7mTIFCCucA1aEL5Sfc49kM20q?=
 =?us-ascii?Q?v0qblQ0wEew14u6izqnxACkYq1VMb4G1b2rzE3Ry5/kf5wu8aXOwlnbEuITU?=
 =?us-ascii?Q?9U7fzSp4cJAUzkxDgDUK3ZpmAcUXPMhEKlP4V5KLFROZAgpqT8MhONjyYPnP?=
 =?us-ascii?Q?o9h4DynPSDsluaXvtg9amsZvZh72nMpYBTMUaLbIlxbzqvePirJ6kbvyOjZF?=
 =?us-ascii?Q?zzJmkvL8OXOzDbk58vc05f78586jESQy1LTZbFucplUF9p8n3APNFD5KzUZ0?=
 =?us-ascii?Q?y2Isx+QIFXSPxNLTvTd7uJlFJzxOZ4AIuG+IYUkUdJ1cCf92tnKMESSh0U3e?=
 =?us-ascii?Q?Hc7zwT0j1VU6Ivi3r8QsQuV+v9zCxD+tTiXs4dUHURxFLwiA9aCQ/CdRupJA?=
 =?us-ascii?Q?rC3e/NJeSeQOskflT5jLG0pgnQmBA146E2TXsUQnl4C9vubgxKX3SaUehrVE?=
 =?us-ascii?Q?LpiEiNnXGNTic8hobXIDzORrf+pysJIWU+XOJz0xvLfqRjl1eD0FqxeJO3pS?=
 =?us-ascii?Q?I3lP0mc62ICl/+LkCO97vwHfSJ98qMedb2czNmMJVRmWQ42Y2OIao+TSFDzM?=
 =?us-ascii?Q?x3nJe0iE6J0L9ORv5GsCfA4tDp8W84gIj001vjqG5pKgvKY/1uAEFSWMIQG3?=
 =?us-ascii?Q?3ds6Cs4c7jQZ7Rpsy0RdXBfCxdkoli2VXQjHJYZRNIZsrgLT1zWBz8cyi69H?=
 =?us-ascii?Q?AeZWwGjR4It9irHKHN1+w3VVdzbW2/ZsbEASz4L6TVzxIlOsjpb4fFpw0Ay7?=
 =?us-ascii?Q?Vb8LdpgiKSwxxypvE7JWE1zbcVvvPHi7wDLSj62hUDt4CmOJ1G6CAhL24hlL?=
 =?us-ascii?Q?ZqcgrvANUYHzyHa3Sac=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1201MB0084.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740d20fd-5057-4543-d8a2-08dac73216a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 17:51:56.8253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QoMrkrG4OQ0zC15ZLLPWkJPEAWFLTIETfoCy9svVbCW/Zu7FaOpkaecnUNeuH2TI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6188
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

Hi Mario,

Thanks for your comments.
I replied  inline.

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Monday, November 14, 2022 4:16 PM
> To: Li, Roman <Roman.Li@amd.com>; amd-gfx@lists.freedesktop.org;
> Deucher, Alexander <Alexander.Deucher@amd.com>; Wentland, Harry
> <Harry.Wentland@amd.com>; Rizvi, Saaem <SyedSaaem.Rizvi@amd.com>
> Cc: Li, Roman <Roman.Li@amd.com>
> Subject: RE: [PATCH] drm/amd/display: Align dcn314_smu logging with other
> DCNs
>=20
> [Public]
>=20
> Conceptually makes sense to me, but please see below comments:
>=20
> > -----Original Message-----
> > From: Roman.Li@amd.com <Roman.Li@amd.com>
> > Sent: Monday, November 14, 2022 15:07
> > To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Wentland, Harry
> <Harry.Wentland@amd.com>;
> > Limonciello, Mario <Mario.Limonciello@amd.com>; Rizvi, Saaem
> > <SyedSaaem.Rizvi@amd.com>
> > Cc: Li, Roman <Roman.Li@amd.com>
> > Subject: [PATCH] drm/amd/display: Align dcn314_smu logging with other
> > DCNs
> >
> > From: Roman Li <roman.li@amd.com>
> >
> > [Why]
> > Assert on non-OK response from SMU is unnecessary.
> > It was replaced with respective log message on other asics in the past
> > with commit:
> > "drm/amd/display: Removing assert statements for Linux"
> >
> > [How]
> > Remove asert and add dbg logging as on other DCNs.

I will fix "assert" spelling before merging.

> >
> > CC: Saaem Rizvi <SyedSaaem.Rizvi@amd.com>
> > Signed-off-by: Roman Li <roman.li@amd.com>
> > ---
> >  .../drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c    | 11 +++++++++-
> -
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git
> > a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
> > b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
> > index ef0795b14a1f..2db595672a46 100644
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
> > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.c
> > @@ -123,9 +123,10 @@ static int
> > dcn314_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr,
> >  	uint32_t result;
> >
> >  	result =3D dcn314_smu_wait_for_response(clk_mgr, 10, 200000);
> > -	ASSERT(result =3D=3D VBIOSSMC_Result_OK);
>=20
> Does this flow actually happen still?  I thought the assertion should hav=
e
> gone away as a result of 83293f7f3d15fc56e86bd5067a2c88b6b233ac3a.
>=20
Happens or not, we don't  assert here on other asics.
I don't try to fix any bugs with this patch, just align the dcn314 logging/=
bug reporting  with other asics.

> Maybe we want to also undo the REG_WRITE() call there if pulling this in.
>=20
> >
> > -	smu_print("SMU response after wait: %d\n", result);
> > +	if (result !=3D VBIOSSMC_Result_OK)
> > +		smu_print("SMU Response was not OK. SMU response after
> > wait received is: %d\n",
> > +				result);
> >
> >  	if (result =3D=3D VBIOSSMC_Status_BUSY)
> >  		return -1;
>=20
> I think what is missing to clean up recent asserts is actually a little b=
it further
> in the code than this.  It should be part of the error flow introduced by
> 03ad3093c7c069d6ab4403730009ebafeea9ee37

03ad3093c7c069d6a is for dcn3.1 initially.=20
If there's an issue with it (which I didn't experience) it should be addres=
sed on all dcn3x, that reuse it,  in a  separate patch.


>=20
> > @@ -216,6 +217,12 @@ int dcn314_smu_set_hard_min_dcfclk(struct
> > clk_mgr_internal *clk_mgr, int request
> >  			VBIOSSMC_MSG_SetHardMinDcfclkByFreq,
> >  			khz_to_mhz_ceil(requested_dcfclk_khz));
> >
> > +#ifdef DBG
> > +	smu_print("actual_dcfclk_set_mhz %d is set to : %d\n",
> > +			actual_dcfclk_set_mhz,
> > +			actual_dcfclk_set_mhz * 1000);
> > +#endif
> > +
> >  	return actual_dcfclk_set_mhz * 1000;  }
> >
> > --
> > 2.17.1

Thanks,
Roman

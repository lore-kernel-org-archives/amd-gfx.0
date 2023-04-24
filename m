Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6076DC7618E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 07:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA09C10E0A5;
	Mon, 24 Apr 2023 07:33:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0BDB10E0A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 07:33:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLiuP/jNhtJ/ETOoemLX39TsDz3QCiI6a+axGlEfsVpbNoNdkrvil/7nNg5BeYBERjlGKLsGwEH8582GnO84mXOI+8H2Non8xubfz4Cj1p+2pu/Lzv6aB9v1v20NDc6Eau8gnvF9u/BxmVepTMXMbSClEzNI88Cibvi9a/2Lj8yHviGgdx5BRy9T2tYbQjW05mlFaCFdnVhHNLeZzy6gHPUegEIPePx5bL0nfN58+nMIO4i2NiJ64UdaOR0TBIyGYBXnAKn6D31UK+vk1KuskCFZ3qx/X8gjezqiqWneHCIVvX5MhRDeFwYgw1uo5uLhnEz5ilEVr/0KgcZt87Lqjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVsy83eaydl0BY7hXOQCHJMp/0yTw3cPPkaGuGOPUsU=;
 b=QjMisqn58UoXq/MzMXFF+ov4iLhhd/QnBLXdtpxvKD9uvKWbsj4JlPOcgyQ4qsZsftoTTMo75ISebWMwrBcxBkbV2zGUFN/en/ub8kCL76nHcyvATsycnVttsM+t1WZi917bSLm7Jyd3HsZJWPZPi620fVirxqNz0AhmRBblsZiDEb/fbwRhySFrBNTpeokNRe+cyqE8lrYihIcZMbGCjlD3Ij8SVeuVtQqTs8PZfRu08jB9DRACdPmqurxQsTkYGCSbK9nDFcoadUbJ5t4MgwJp6jB6zBfWdJ9HzdjtbKQnQiS6lS4klFhMdQedCiRulMkVynmY459O8muS/EmXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVsy83eaydl0BY7hXOQCHJMp/0yTw3cPPkaGuGOPUsU=;
 b=rilNvwX0kWS0SE/WCJPyMYk7ZYDJzrPa+HucPAZnrU7cwGC5E20pRyHn+W1wCn70b2tKXfqKzYC1ifLaAjorJLFVs+xiM79jZsRr3sCVsXP2PEwGoJkI1bSO9Y844TwyXVUpB+0gmQFdZcq1s+d9TbkDpgO4RBqwPDcH+sU7pcQ=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 CH0PR12MB5105.namprd12.prod.outlook.com (2603:10b6:610:bc::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.33; Mon, 24 Apr 2023 07:33:27 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::6fe7:b96c:789e:3eac]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::6fe7:b96c:789e:3eac%5]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 07:33:27 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: conditionally disable pcie lane switching for
 some sienna_cichlid SKUs
Thread-Topic: [PATCH] drm/amd/pm: conditionally disable pcie lane switching
 for some sienna_cichlid SKUs
Thread-Index: AQHZdCMrO8z5sJilnU2X0klm9jkjYK81xS0AgARQkEA=
Date: Mon, 24 Apr 2023 07:33:27 +0000
Message-ID: <DM6PR12MB26197BB4714CD944A01824EDE4679@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230421072835.842112-1-evan.quan@amd.com>
 <MN0PR12MB610149D07DDF67122A2D2518E2609@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB610149D07DDF67122A2D2518E2609@MN0PR12MB6101.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-04-24T07:33:25Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9734b192-ee59-4048-b228-9cc19756ca50;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|CH0PR12MB5105:EE_
x-ms-office365-filtering-correlation-id: 1390f580-008c-4a14-28d4-08db44963207
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QIMGDCpUR/Nz4DfVS1/YjbljB9h/whqd3FOUdtxGAciGHQpxCRD779J8DswSHs3LxqnTkId5O0rLEbLb0wCDwcFb8HgMvdSC/bFoq+8GZI6iPQq9kjs1m9cjKAjguLyG4eNi9fYVKMqNzIpt5aV1MipQte5BckS0UHuFriVT3/HO01liQlgkRozD8i5P/5IWxnORhJol782rQSMwzjGn0hZ3tIif1iVx35zsJVzdCGjMqTJfQChit/dDuYRw24s4EOUlDikuCedJMlzSxc4IuA0IfO3nWiJXLgPa6es1DQNGueLv1l+QWlE76r/tu2AlIrK5vzfAtM27mq/FNQhgCdBHPewnAhR8GzlJSejMXOLPB794YgULj8zyTc7iNEULv8z6+DERMGi3yl3uTPDEJ+sjIgOWp02URdZwxfEtSqiOHXin1hU+7vk61l79KpUsHPGrRqzazfleWV6i2NqT0tHWF7V7BKAxKweQV6QwzjhUwyJfRbFTdedJ1ZAtiVPaGIuTCwbw07FoUqbmqwo30xE3axcVQZ3sfQz+YmAXvKqcVf/zI+oDNbM15WLHvfSF/vHhOMMWDt7kz/ZVMVgrY6NcicYBozHf91AuM4tH0rRlICWiQGlGWBaWbejgxKTV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(478600001)(110136005)(86362001)(186003)(53546011)(7696005)(26005)(9686003)(6506007)(55016003)(33656002)(71200400001)(4326008)(64756008)(66446008)(66476007)(66556008)(316002)(83380400001)(66946007)(76116006)(2906002)(38100700002)(122000001)(41300700001)(8676002)(8936002)(38070700005)(5660300002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JE+9S8RxhnRfSY2VrHW8tkoD17VQ5Rlh8cynul8TH4/ez7DXpGu1gW197nCo?=
 =?us-ascii?Q?vvOsH3ajgI++CVHdhEBz2n+7wFp/t2IFJVM8MywXJgixUhH9I9p1pYgM60hb?=
 =?us-ascii?Q?nzCRCkZXHuVzkXJgAd62XLrIsAZcZsRtACJUwgu62BoXO7S4mk2tLUOTZW2c?=
 =?us-ascii?Q?MuG7XJJansZ7ek9G5HIBsXN3Q/LEtVlDmvq4E6QHMVEPiivCFIFFVbZ70HXm?=
 =?us-ascii?Q?QC1gOp/v3nisMNHcrA1T1i9HMkXrlpAIV3ZVrKoIBrJiSHLmQIKs0SsEngqY?=
 =?us-ascii?Q?NVDXDwgixEqp/xjOllZ72sLn2/OUlqhyFuBzdBT4aAx9JiB72Kh6BP9JJVO7?=
 =?us-ascii?Q?JG/gbXwFis9emSRaAHVEadG5M5oYoO84bA6+EZ6p0zQirfsMnF0C/JhwFAO2?=
 =?us-ascii?Q?3M/DRwlf2+X1xV8y6/h37Fu2sXkPqsOFXBzcZsOO6pOmbeqeugLqMCx/nI9X?=
 =?us-ascii?Q?Vi0rp1+G886wYHqMKLKMyBL7f/hls4NGz4s/ooUc2dZXr/t/uucfVOU2l5Ro?=
 =?us-ascii?Q?/HbXv7robWsSXnkXAF3G/oyhrJkjwFZ0pwHAwd1hOAULXH6ggXcPxgdbHbmG?=
 =?us-ascii?Q?9W17QbmDzElotey3NLBAqC8D6JOYShMO4qTlz3p90sNKRe9uToN0FjnU44LB?=
 =?us-ascii?Q?rb4rO6QjXAqGkQGOjxdPZViEl/V6et3lEt9+YE7C8NcjmFDKkK1S6cbq7QaK?=
 =?us-ascii?Q?z21VO37BuD15ABTYdELFC3U7hLIo8y3Tqkv67wvLvlNkhoUvVfZe3bRkDzs3?=
 =?us-ascii?Q?L/ED65C9VWDXQInrHm5X1v2jzcMzbn+9cZXkRApZw8Hl2/ZqrG6mkGj/oKrR?=
 =?us-ascii?Q?2gsg3+bC3hduBIXSEPXVhdJq+H32rvbj6Ef0NqbZG1R71vBtd9Fp0g4qmZHg?=
 =?us-ascii?Q?ukkTllKolBBlHGqwfYy4OToGLooyXI+n4NNJPImIU6UvOVMvx4A1kRkOygUz?=
 =?us-ascii?Q?kDWSbwSbkowzshnf6p9nfriAkPoJx+jU859yqN1z1BdUYBTvskHCW3qzOq7M?=
 =?us-ascii?Q?IpLDoy77oHWNfoUOT/M6J8mvdOtkQZJjzRuQS5AztthsfrOiH8/ZYltKxHQv?=
 =?us-ascii?Q?36ttJGD04pyPN7esAcKRMnaR5Q36V5BpEydDL6yZ4JSzaUbsjpYSFjbf6IvD?=
 =?us-ascii?Q?YNkzmY5DBmJ9MC3FTYgInTzE8bmtO2RLZirwJEhA3exsvPDgKzfLX2gH/YSw?=
 =?us-ascii?Q?IYgWlAWh7FNYLX64upFiQu3njEH4Fx8uCJAzBLUTtmr0kGsZ66HGqcbDfj6W?=
 =?us-ascii?Q?wZJpYVk0E5MYXq+FmCgJRQvl5cLnO1q+Vad/fYDR1HjMuZLzCIJr7mSAkvnv?=
 =?us-ascii?Q?OP/cbhGG3P/fJc52WC52BOPWnlVww9hJepY4NrCRot5ZoN9LpmLSp/niQtGC?=
 =?us-ascii?Q?pP2PrseS75ewZXkjjqx8l/8qVkQ9pamEQmi3zhlSd7BfM4iIJkwZlq/2rdO9?=
 =?us-ascii?Q?9+N62gAvPT+YQm9X51flIACrC7w2vdE8/j6MOJnZ6GYAJzu7FiGdQl6JlikE?=
 =?us-ascii?Q?SmJ01vzZJ7qvxO/4Hfw8pxhu13Yy8VlMaLFQT2z6LDokp2QMeoPK418sN+F0?=
 =?us-ascii?Q?m4b3B7LZb8RGkrYvPP8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1390f580-008c-4a14-28d4-08db44963207
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2023 07:33:27.7790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AEoBbb7zT5BpcTNUHG3VNSy6R2ACXKUOIST+EPvh8r7327jPeZUkA2/7bs9GY20u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5105
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]



> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Friday, April 21, 2023 9:40 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH] drm/amd/pm: conditionally disable pcie lane switchin=
g
> for some sienna_cichlid SKUs
>=20
> [Public]
>=20
>=20
>=20
> > -----Original Message-----
> > From: Quan, Evan <Evan.Quan@amd.com>
> > Sent: Friday, April 21, 2023 02:29
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello,
> Mario
> > <Mario.Limonciello@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> > Subject: [PATCH] drm/amd/pm: conditionally disable pcie lane switching
> > for some sienna_cichlid SKUs
> >
> > Disable the pcie lane switching for some sienna_cichlid SKUs since it
> > might not work well on some platforms.
> >
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > Change-Id: Iea9ceaa146c8706768ee077c10e5d33bce9bc1c2
>=20
> You can drop the Gerrit Change-Id here
Sure, thanks.

Evan
>=20
> > ---
> >  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 92
> +++++++++++++++----
> >  1 file changed, 74 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > index 4b91cdc3eaa0..e7223513e384 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > @@ -2067,33 +2067,94 @@ static int
> > sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
> >  	return ret;
> >  }
> >
> > +static void sienna_cichlid_get_override_pcie_settings(struct
> > +smu_context
> > *smu,
> > +						      uint32_t
> > *gen_speed_override,
> > +						      uint32_t
> > *lane_width_override)
> > +{
> > +	struct amdgpu_device *adev =3D smu->adev;
> > +
> > +	*gen_speed_override =3D 0xff;
> > +	*lane_width_override =3D 0xff;
> > +
> > +	switch (adev->pdev->device) {
> > +	case 0x73A0:
> > +	case 0x73A1:
> > +	case 0x73A2:
> > +	case 0x73A3:
> > +	case 0x73AB:
> > +	case 0x73AE:
> > +		/* Bit 7:0: PCIE lane width, 1 to 7 corresponds is x1 to x32 */
> > +		*lane_width_override =3D 6;
> > +		break;
> > +	case 0x73E0:
> > +	case 0x73E1:
> > +	case 0x73E3:
> > +		*lane_width_override =3D 4;
> > +		break;
> > +	case 0x7420:
> > +	case 0x7421:
> > +	case 0x7422:
> > +	case 0x7423:
> > +	case 0x7424:
> > +		*lane_width_override =3D 3;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +}
> > +
> > +#define MAX(a, b)	((a) > (b) ? (a) : (b))
> > +
> >  static int sienna_cichlid_update_pcie_parameters(struct smu_context
> *smu,
> >  					 uint32_t pcie_gen_cap,
> >  					 uint32_t pcie_width_cap)
> >  {
> >  	struct smu_11_0_dpm_context *dpm_context =3D smu-
> > >smu_dpm.dpm_context;
> > -
> > -	uint32_t smu_pcie_arg;
> > +	struct smu_11_0_pcie_table *pcie_table =3D &dpm_context-
> > >dpm_tables.pcie_table;
> > +	uint32_t gen_speed_override, lane_width_override;
> >  	uint8_t *table_member1, *table_member2;
> > +	uint32_t min_gen_speed, max_gen_speed;
> > +	uint32_t min_lane_width, max_lane_width;
> > +	uint32_t smu_pcie_arg;
> >  	int ret, i;
> >
> >  	GET_PPTABLE_MEMBER(PcieGenSpeed, &table_member1);
> >  	GET_PPTABLE_MEMBER(PcieLaneCount, &table_member2);
> >
> > -	/* lclk dpm table setup */
> > -	for (i =3D 0; i < MAX_PCIE_CONF; i++) {
> > -		dpm_context->dpm_tables.pcie_table.pcie_gen[i] =3D
> > table_member1[i];
> > -		dpm_context->dpm_tables.pcie_table.pcie_lane[i] =3D
> > table_member2[i];
> > +	sienna_cichlid_get_override_pcie_settings(smu,
> > +						  &gen_speed_override,
> > +						  &lane_width_override);
> > +
> > +	/* PCIE gen speed override */
> > +	if (gen_speed_override !=3D 0xff) {
> > +		min_gen_speed =3D MIN(pcie_gen_cap, gen_speed_override);
> > +		max_gen_speed =3D MIN(pcie_gen_cap,
> gen_speed_override);
> > +	} else {
> > +		min_gen_speed =3D MAX(0, table_member1[0]);
> > +		max_gen_speed =3D MIN(pcie_gen_cap, table_member1[1]);
> > +		min_gen_speed =3D min_gen_speed > max_gen_speed ?
> > +				max_gen_speed : min_gen_speed;
> >  	}
> > +	pcie_table->pcie_gen[0] =3D min_gen_speed;
> > +	pcie_table->pcie_gen[1] =3D max_gen_speed;
> > +
> > +	/* PCIE lane width override */
> > +	if (lane_width_override !=3D 0xff) {
> > +		min_lane_width =3D MIN(pcie_width_cap,
> lane_width_override);
> > +		max_lane_width =3D MIN(pcie_width_cap,
> lane_width_override);
> > +	} else {
> > +		min_lane_width =3D MAX(1, table_member2[0]);
> > +		max_lane_width =3D MIN(pcie_width_cap, table_member2[1]);
> > +		min_lane_width =3D min_lane_width > max_lane_width ?
> > +				 max_lane_width : min_lane_width;
> > +	}
> > +	pcie_table->pcie_lane[0] =3D min_lane_width;
> > +	pcie_table->pcie_lane[1] =3D max_lane_width;
> >
> >  	for (i =3D 0; i < NUM_LINK_LEVELS; i++) {
> > -		smu_pcie_arg =3D (i << 16) |
> > -			((table_member1[i] <=3D pcie_gen_cap) ?
> > -			 (table_member1[i] << 8) :
> > -			 (pcie_gen_cap << 8)) |
> > -			((table_member2[i] <=3D pcie_width_cap) ?
> > -			 table_member2[i] :
> > -			 pcie_width_cap);
> > +		smu_pcie_arg =3D (i << 16 |
> > +				pcie_table->pcie_gen[i] << 8 |
> > +				pcie_table->pcie_lane[i]);
> >
> >  		ret =3D smu_cmn_send_smc_msg_with_param(smu,
> >  				SMU_MSG_OverridePcieParameters,
> > @@ -2101,11 +2162,6 @@ static int
> > sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
> >  				NULL);
> >  		if (ret)
> >  			return ret;
> > -
> > -		if (table_member1[i] > pcie_gen_cap)
> > -			dpm_context->dpm_tables.pcie_table.pcie_gen[i] =3D
> > pcie_gen_cap;
> > -		if (table_member2[i] > pcie_width_cap)
> > -			dpm_context->dpm_tables.pcie_table.pcie_lane[i] =3D
> > pcie_width_cap;
> >  	}
> >
> >  	return 0;
> > --
> > 2.34.1

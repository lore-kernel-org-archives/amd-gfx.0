Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4293C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 09:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AE7610E1BB;
	Wed, 31 May 2023 09:54:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 433F310E1BB
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 09:54:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KW3Q4s//ZORrGsZ91caM+IqDxXOGWqKabda8VFN16xSkuqNMsF3r2vrJCV7V9M6GvQyAyKalUXuvOPqDYceRCEOi3jdUcMEiJgA61Ywzk6hWKXrwbzf6/9ddWRgq6RpaY1gRDWi1QGa587B1D4FHcopEXew3vDehuCihAlajv7/q9s3nngHTuKCaGxXycuscacmewuMJsI5lUeGA0EfzZICMeXlA34bngo6II+RoX2n//rJ6QU3cx+zXVYL4J4oFRqDqFdg4sktB0QKyz+CsAtKy324v+xPAO8UGFmyRawHLYRtp/7MGt6UAtAyHV3eIdit+3P0pPFAc694c2l5TXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFnh27VG8zBjX9WKsn/GkmLs3R9K4qos9J5BNB+nA8o=;
 b=hO+aTSffsfVPP7u+MCuBfZnCxqWbORXvtZgHmDCEudAxr3LV00tf/j27WOs4wVsxqSHWK7W5Ky72Ggt6k1eyirw4gWpwK+1jHNj5lMpwM8FgwX/SWTeny9+V0rv/kq+VR94EW+XuaZAOBvMDv3KAkUFYKAWZtm+UR8cgm2rchIYmaLmSuzy9c5wsPaJi5cACch196v0IjyFUWmnKZ0sVU7QPghnNd6XcVGx+yK/3UZWwr0pibcS/hKoQ20Wnvres2LoWrHD6oLX07p0DxVMPeRUUY+AXOYoM17R5xm5kE0XVdpnAk2Lfy04CQqtUFGBrjKJ4O5GKe44SN9S5MrXoUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFnh27VG8zBjX9WKsn/GkmLs3R9K4qos9J5BNB+nA8o=;
 b=bs6v3iZEycD2/GBPa9SCXlTlPlUh8SMyJp0p8fEHJRbnkfjkHdtchshhow+lqiP5vLczyOlgkP7WaHko2+jhcjnwsEJoxBACH/BmBuN020IsNngG8wxdGNgD8FOOSjB5+7g6pbTMVrhWA67UMlsHnz7ep6HCdWMKk7dIzId/9Go=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Wed, 31 May 2023 09:54:50 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::eb34:e3b6:9ff9:de11]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::eb34:e3b6:9ff9:de11%4]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 09:54:50 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: conditionally disable pcie lane switching for
 some sienna_cichlid SKUs
Thread-Topic: [PATCH] drm/amd/pm: conditionally disable pcie lane switching
 for some sienna_cichlid SKUs
Thread-Index: AQHZdCMrO8z5sJilnU2X0klm9jkjYK81XidAgD8E5+A=
Date: Wed, 31 May 2023 09:54:49 +0000
Message-ID: <DM6PR12MB261983FB6A9A84960055C198E4489@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230421072835.842112-1-evan.quan@amd.com>
 <DM6PR12MB26192A46ED09CDB6BC1A3BF2E4609@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26192A46ED09CDB6BC1A3BF2E4609@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8322a7dc-1eb7-4d28-af95-d689cefd7548;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-21T07:32:18Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|MW3PR12MB4345:EE_
x-ms-office365-filtering-correlation-id: e861f9e7-9987-443b-97d2-08db61bd130e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ofPZB6BIhJ+vHQQEkuhKMeLQXeHkQifZeFgFVN7Y9zzCRRfZtj6KCaADm4j04HbRYeMefGhLlYqsC+qFy5w50iPm4m8Z7fKD0adNLSFkOxcdd9i0D+kxLQVnFTkMImoyotObtVw1Sz9FPCWd7lh+bofuD6JGP/ZroI9V7QUhalhLEnDZA23vSL8+S39EX4jLvhUKQICHg7+nsCZ7P5v8/U6AnpN//42lofPkhjzehkDqEBKexIPgjTt+IlfOWsHk7jrMn1DIU1ntCxqx4sELI7ZSIoSf1JPWvQq5nSjl8Rz+6VLugQeUOvFFcC9dXj7wxQVZdKkKssRsCCcH/faZBFKQc65czMnZmTly1Rg8NVJ9MIpU+4vA/2mKblfjJjNxJFFXpkOipStVM5iIKio2lrKiFnVl0i80l40Qg5XByw1e4UnGQrHxIri7rhst81DIaipSzJ73V8Mx+EqBygHfeBHW8UjhCzPiWOYlw/3F0aB6RdH/M2iDqbEQjxHLkJFLti7Zx7UTZVQ6NGIwMlPDDQbT7vYaYPi5sASZ2PRF8el5AIrIEODF73Wx8voE8+iBx2DL4SDWXHq6kpaLi4cz3h9cOMo1d1avheyLkH/zQcXYMnrJyT2tacByBQxvHhZb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199021)(54906003)(71200400001)(478600001)(6916009)(8936002)(5660300002)(8676002)(52536014)(86362001)(33656002)(2906002)(38070700005)(4326008)(64756008)(66556008)(76116006)(66476007)(66946007)(66446008)(122000001)(316002)(55016003)(38100700002)(41300700001)(186003)(53546011)(9686003)(6506007)(7696005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oRXLF5nH5sP8LOV9GeBqEySuu0CZz3/Dd8sugOAoEUENLrVZZzqx5V7zAsS+?=
 =?us-ascii?Q?EqS9smzt4aiUbedKLX8WixnB8e8ie1BUcRD31VDbktLdAttA7Z8uycXPJeww?=
 =?us-ascii?Q?NU8lwNhVRfoRIP6hHzlwrGKYn7JCU/jmNUkKAv7C4NXP4IMKrTKkTeT9nsip?=
 =?us-ascii?Q?mlL/R3pp0HYA4oHqCvIdMcno2Y6SsOKJr/qi3gFX4MrPTwATzt+0oxQ2b0Ih?=
 =?us-ascii?Q?pprM4SwlnIwgzx79ZzVF7vzRC5pqIda7DrY4nzVTdbjXknUXITwRH5SIGhFv?=
 =?us-ascii?Q?HawhMjcsMd/y+6qkHbSv3eE31t8ZDyjLvU/btVU4r03lggpOmut6NDBVAOsQ?=
 =?us-ascii?Q?y/CxrhXM4vFLYaOIHa4Ia5tswYAgAuZZpyTXq2aA0/DThr5QJO5dJK+m2c68?=
 =?us-ascii?Q?4Y2YZXK9G+RlGKYPydyaK/9T8/WKItLfI3Y/y8FrViORoGUlQlc2/XcMJitt?=
 =?us-ascii?Q?BVL2JxJfdl1VdWNcZYB3TrBCGHUm7WGciCm1k42zsRjwEcRNm+Da+2hJ3GO/?=
 =?us-ascii?Q?aAx8LchLA83Qiz3YBFv/ajPj1T2y5MhgaQi6JdnBKpHZlZqg2osifCiAHvcK?=
 =?us-ascii?Q?9kAUkQeIHhAYVupKILICvQ7T58J//47aAnqG2p7YGyFPZVdI73KL7QnYHhjJ?=
 =?us-ascii?Q?cGnetW0N0saGXJJZH47uhHQDBbfY20yTMC+3IybRmeYAJfZaTacswOG7P5Wi?=
 =?us-ascii?Q?+wbRxgcg0rAuNrKrPCWiYWRvW3Bq1djrTUwedroVA8RwJkFH0PQf1e7wsiud?=
 =?us-ascii?Q?9ZpTFMc3kGF4OYnt/DIl+XZ57KY/A+FDlN1lrL9C46OBMHkxnbmp4QNjHnZ4?=
 =?us-ascii?Q?MF+VvDaoXqASWMnZqicRJyK+kveKZBEjigriy9qvRoVB+++Lux+FvIUQ15zw?=
 =?us-ascii?Q?6FcQNdKqDz7LGZesiR1CJwaWvvjsQJlpz2JMhgUruzFnyQ0IReEQVE1eD+U5?=
 =?us-ascii?Q?JwDSLM68lqv1hM1+YDVWAZ54+TjhRm4nYJEiNu/0RocS7DnAD7DYiicfUAtf?=
 =?us-ascii?Q?Df4vIJmr1rf1q3/+O/aDrnq2ctf/Sd77qo3T3QLwT8+pYWWlYw5R4xh+tEBn?=
 =?us-ascii?Q?OB767yGTKCT7OT0FiBpdUNltixXQgdC1Gqk53tvsUjfkh2Vp5aoVteO5iOip?=
 =?us-ascii?Q?kgfDjgHCLK91+9uka1NF703+SMH/KfJuxK0470mYmHaUaWDAin/8xVRdDO3/?=
 =?us-ascii?Q?GioaF9cAkzN7bCj9SqlJB5CaERU5LB4WEGkAEIhNwZ2Y8U8wuNN8/sQw0OYf?=
 =?us-ascii?Q?gZde1cjnTDac0R+TouoHlCGLpXK99fUf6solO/iZhWvC/rdo/CeEaACWvhLM?=
 =?us-ascii?Q?tYnA2pheXaxsyoltj5a7+ey64GtawoAYywMR+j8MdmIlYLQ2eTm34J+hlePd?=
 =?us-ascii?Q?UWS4MuVLyujLcAfqxSU9qBW8HhnXk7nUfF2S+q6kPpqp4k3zHpa1ObXMhjRb?=
 =?us-ascii?Q?JsHOftsAfQWZH/NEu0i9z9TGL5N+3yfYir7Oe2TWiZDlAELZBVHy8bfADyZw?=
 =?us-ascii?Q?TXECvYGwelhJbF82wxfwVoC7nJSelUO4Mvh0aDMcYwgW7LzEs734hZmScg?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e861f9e7-9987-443b-97d2-08db61bd130e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 09:54:49.9370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K1YXFgMB1qQ0mCLa1GO9z8vwXw/2cSHLO2c9UXHxdc+KkhlkjyTxSri3lQGyTLtE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi Alex,

Can we land this as a temporary solution while we are seeking a more proper=
 one?
This is gating our customer and I was pushed for a solution.

BR,
Evan
> -----Original Message-----
> From: Quan, Evan
> Sent: Friday, April 21, 2023 3:32 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Subject: RE: [PATCH] drm/amd/pm: conditionally disable pcie lane switchin=
g
> for some sienna_cichlid SKUs
>
> [AMD Official Use Only - General]
>
> This seems able to address some audio noise issue observed per customer's
> feedback.
>
> Evan
> > -----Original Message-----
> > From: Quan, Evan <Evan.Quan@amd.com>
> > Sent: Friday, April 21, 2023 3:29 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> > Subject: [PATCH] drm/amd/pm: conditionally disable pcie lane switching
> > for some sienna_cichlid SKUs
> >
> > Disable the pcie lane switching for some sienna_cichlid SKUs since it
> > might not work well on some platforms.
> >
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > Change-Id: Iea9ceaa146c8706768ee077c10e5d33bce9bc1c2
> > ---
> >  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 92 +++++++++++++++-
> --
> > -
> >  1 file changed, 74 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > index 4b91cdc3eaa0..e7223513e384 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> > @@ -2067,33 +2067,94 @@ static int
> > sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
> >     return ret;
> >  }
> >
> > +static void sienna_cichlid_get_override_pcie_settings(struct
> > +smu_context
> > *smu,
> > +                                                 uint32_t
> > *gen_speed_override,
> > +                                                 uint32_t
> > *lane_width_override)
> > +{
> > +   struct amdgpu_device *adev =3D smu->adev;
> > +
> > +   *gen_speed_override =3D 0xff;
> > +   *lane_width_override =3D 0xff;
> > +
> > +   switch (adev->pdev->device) {
> > +   case 0x73A0:
> > +   case 0x73A1:
> > +   case 0x73A2:
> > +   case 0x73A3:
> > +   case 0x73AB:
> > +   case 0x73AE:
> > +           /* Bit 7:0: PCIE lane width, 1 to 7 corresponds is x1 to x3=
2 */
> > +           *lane_width_override =3D 6;
> > +           break;
> > +   case 0x73E0:
> > +   case 0x73E1:
> > +   case 0x73E3:
> > +           *lane_width_override =3D 4;
> > +           break;
> > +   case 0x7420:
> > +   case 0x7421:
> > +   case 0x7422:
> > +   case 0x7423:
> > +   case 0x7424:
> > +           *lane_width_override =3D 3;
> > +           break;
> > +   default:
> > +           break;
> > +   }
> > +}
> > +
> > +#define MAX(a, b)  ((a) > (b) ? (a) : (b))
> > +
> >  static int sienna_cichlid_update_pcie_parameters(struct smu_context *s=
mu,
> >                                      uint32_t pcie_gen_cap,
> >                                      uint32_t pcie_width_cap)
> >  {
> >     struct smu_11_0_dpm_context *dpm_context =3D smu-
> > >smu_dpm.dpm_context;
> > -
> > -   uint32_t smu_pcie_arg;
> > +   struct smu_11_0_pcie_table *pcie_table =3D &dpm_context-
> > >dpm_tables.pcie_table;
> > +   uint32_t gen_speed_override, lane_width_override;
> >     uint8_t *table_member1, *table_member2;
> > +   uint32_t min_gen_speed, max_gen_speed;
> > +   uint32_t min_lane_width, max_lane_width;
> > +   uint32_t smu_pcie_arg;
> >     int ret, i;
> >
> >     GET_PPTABLE_MEMBER(PcieGenSpeed, &table_member1);
> >     GET_PPTABLE_MEMBER(PcieLaneCount, &table_member2);
> >
> > -   /* lclk dpm table setup */
> > -   for (i =3D 0; i < MAX_PCIE_CONF; i++) {
> > -           dpm_context->dpm_tables.pcie_table.pcie_gen[i] =3D
> > table_member1[i];
> > -           dpm_context->dpm_tables.pcie_table.pcie_lane[i] =3D
> > table_member2[i];
> > +   sienna_cichlid_get_override_pcie_settings(smu,
> > +                                             &gen_speed_override,
> > +                                             &lane_width_override);
> > +
> > +   /* PCIE gen speed override */
> > +   if (gen_speed_override !=3D 0xff) {
> > +           min_gen_speed =3D MIN(pcie_gen_cap, gen_speed_override);
> > +           max_gen_speed =3D MIN(pcie_gen_cap,
> > gen_speed_override);
> > +   } else {
> > +           min_gen_speed =3D MAX(0, table_member1[0]);
> > +           max_gen_speed =3D MIN(pcie_gen_cap, table_member1[1]);
> > +           min_gen_speed =3D min_gen_speed > max_gen_speed ?
> > +                           max_gen_speed : min_gen_speed;
> >     }
> > +   pcie_table->pcie_gen[0] =3D min_gen_speed;
> > +   pcie_table->pcie_gen[1] =3D max_gen_speed;
> > +
> > +   /* PCIE lane width override */
> > +   if (lane_width_override !=3D 0xff) {
> > +           min_lane_width =3D MIN(pcie_width_cap,
> > lane_width_override);
> > +           max_lane_width =3D MIN(pcie_width_cap,
> > lane_width_override);
> > +   } else {
> > +           min_lane_width =3D MAX(1, table_member2[0]);
> > +           max_lane_width =3D MIN(pcie_width_cap, table_member2[1]);
> > +           min_lane_width =3D min_lane_width > max_lane_width ?
> > +                            max_lane_width : min_lane_width;
> > +   }
> > +   pcie_table->pcie_lane[0] =3D min_lane_width;
> > +   pcie_table->pcie_lane[1] =3D max_lane_width;
> >
> >     for (i =3D 0; i < NUM_LINK_LEVELS; i++) {
> > -           smu_pcie_arg =3D (i << 16) |
> > -                   ((table_member1[i] <=3D pcie_gen_cap) ?
> > -                    (table_member1[i] << 8) :
> > -                    (pcie_gen_cap << 8)) |
> > -                   ((table_member2[i] <=3D pcie_width_cap) ?
> > -                    table_member2[i] :
> > -                    pcie_width_cap);
> > +           smu_pcie_arg =3D (i << 16 |
> > +                           pcie_table->pcie_gen[i] << 8 |
> > +                           pcie_table->pcie_lane[i]);
> >
> >             ret =3D smu_cmn_send_smc_msg_with_param(smu,
> >                             SMU_MSG_OverridePcieParameters,
> > @@ -2101,11 +2162,6 @@ static int
> > sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
> >                             NULL);
> >             if (ret)
> >                     return ret;
> > -
> > -           if (table_member1[i] > pcie_gen_cap)
> > -                   dpm_context->dpm_tables.pcie_table.pcie_gen[i] =3D
> > pcie_gen_cap;
> > -           if (table_member2[i] > pcie_width_cap)
> > -                   dpm_context->dpm_tables.pcie_table.pcie_lane[i] =3D
> > pcie_width_cap;
> >     }
> >
> >     return 0;
> > --
> > 2.34.1

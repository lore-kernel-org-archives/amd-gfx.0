Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AC1C77B73
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 01:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7018C10E233;
	Mon, 22 May 2023 01:38:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01B5010E233
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 01:38:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gx5Gf5dbU+zL2+n8oIs+zLxgnUkJa7pQiZincEzh/iaYP1J9EiaY1DWjmRKYBZI02ZIprsk4gy4nsbr8oGaSvADr0sRGP7MWWQI2bzGNTOD4/vlndo8cCp9Yd2GVj4qsP55NjBs4fDwrSwzBP/DqF32E1hLmoRLpqCkI4nr/S7asRfRuWYx7uaQ7YxwQGUeznMax6gCycPwxc5FsO0JyRy/IoYNWJB7bqLJsTe/S3bzg1x28eqOAvUzhrHtsIxOVoRT9SOiTAMF/vaNmKLhljhkoAuxeTafyQ3R9U3WfE+dm+oRktW1V4GLWBhhGPIoWRdAn6IKGWjAtrtkUsvwQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpDOYsKtYIigTM431blIRyt8wZTWip2Vt32jVcoro2U=;
 b=I0NOb3oOikXR9keJ+rF4AzaqW5+VFB0A9E9XvBdJHNWEqd0V43piXD3MSLYRz7MHLJ7Lfz/bmFqU9zUQxUKJ7IDXX0Ez2/YVX+bfKPRrTzdCC9cjyB2PAlJ2f1g91eRsYXyCq1wWgBc4GeXVIGNK8quyeNgKPobntUuGWKnqBdzGz/X1trMVoUpKrCyNRri+CgbbAHAPf7GpW7agEB3rWp2L0LF9K2YHKQIkZBjtN/KexPQEvOnwL6ogz0RgLFF95TnrkRTbUNGTEwrHkBKte3rN+7jNj9/So10WNI3d4UNXyGtVgLopoS0YQa75sXQfc7E7lC91bOPIEA1LGrFZ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpDOYsKtYIigTM431blIRyt8wZTWip2Vt32jVcoro2U=;
 b=FpC7A9rpRL5wKn65tAqhY1McxAOSmZqFyepQlcXqD+2PFwTP+fXF0XPIAPWKVo32RYF9Ia6bq1glE+96UkYTXdIck4kfFTOaxMtFWZXvFrTSKySAElcefDPaVUlu4vxiI20MDXMBS97YsLfvV9dJN7Xz27sfgbEmsRnJudOakHE=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4387.namprd12.prod.outlook.com (2603:10b6:5:2ac::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Mon, 22 May 2023 01:38:38 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::f860:816b:a9bb:27a4]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::f860:816b:a9bb:27a4%4]) with mapi id 15.20.6411.027; Mon, 22 May 2023
 01:38:38 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: add missing NotifyPowerSource message mapping
 for SMU13.0.7
Thread-Topic: [PATCH] drm/amd/pm: add missing NotifyPowerSource message
 mapping for SMU13.0.7
Thread-Index: AQHZiicHcbIGHaD/Y06mFC/CLyUpm69hf6QAgAQIGcA=
Date: Mon, 22 May 2023 01:38:37 +0000
Message-ID: <DM6PR12MB26197E2764D788C2C12369E5E4439@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230519075259.1650630-1-evan.quan@amd.com>
 <DM5PR12MB2469A856FF470A1C68AF1D9DF17C9@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469A856FF470A1C68AF1D9DF17C9@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2babc0d7-3abf-43ea-bf0d-ec7540bc2d5b;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-05-19T12:03:41Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|DM6PR12MB4387:EE_
x-ms-office365-filtering-correlation-id: 3fd4630e-5ecb-4388-05f7-08db5a6543bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uoLRCVcXMRd524elFmDmfykLCmH1GF3h1I87z3ujMu0yfBqxy8tZNAW+2CF7BzYkeGS4A2ZuaFaLNBFqJ0Mb88rVHjXpmFwI6sIMXHnl7/XnrdJqke84/JirdqNEUH4SQ9yOC3N48V2QFwz9NEbKq6AqmRxstYzIbKQTEwN6e78FBdwEUoM/zrZc/ETrb6cAgy4jzAsz44LDBHCzLhD8GFGvZBlN0/+EJXHlN9xaO5Rjh1yxh6CNZUmFxkZpXR6jQu1FD1ZkPYnLmazx3dPIk/ZFpAn3vl51yQZ0FF7JZEWrnAoW4WCT8QixcYEG97IXfNeuUtEb1sb6jSb2qITeaSWE1rjiyAsS11pFYeBCa45J/ge6TEdWfDl7LKxlwI75xz0p0MojpCc8+Cm5USAwTUGjhZ08LB5+4i6dCMYYkGhD/ArbcmDmNXl5FBn9s14MAtgSNZWJpGCDQWymqFs15WUmrZ90zXnRWcRaZHqEHZppm4n2ZCoSwjtEe5S4lBG/XfR76U2zaKolkuu4oX6HhdbhJDjLxODtJzoTAoRzIeZd9WfM1hug7+uZlM3yLMjS94ugfVfyqmomr4F+2Kvn6y++Y2vff4/OYg+Io++D1QP7OpIntv+VqR4gHlSj6/g6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199021)(316002)(478600001)(6506007)(26005)(53546011)(9686003)(15650500001)(110136005)(71200400001)(41300700001)(66946007)(76116006)(66556008)(66476007)(66446008)(64756008)(4326008)(7696005)(52536014)(8676002)(8936002)(5660300002)(86362001)(55016003)(2906002)(83380400001)(33656002)(122000001)(38100700002)(38070700005)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DUWXxQnGl23UaF518aqMHeE05l7prO8np1K4nISqu4Lf9J2u3IoacpCZMXje?=
 =?us-ascii?Q?X9JWUZ7nHgrQBWK/fVnScHEAX9Ov8/KB5eNgv43SIwAgm5tQPSOPy8984FuH?=
 =?us-ascii?Q?cSIRJ0r/Q5ewwHRyUwiMJw87Y3VMXiuig3rf0sWd7dMz6rwjAqJ5dzUjorET?=
 =?us-ascii?Q?DSR8FjYuB9b7O8qJ87S4NV+VEuXezmJ464zM9oDzqyjSHU4S8y4+j/de14GM?=
 =?us-ascii?Q?ATgyl9Xu+cLipxpM6qyEge9Fui0In4NLd80aAVqY2c1GeklwRnzY35p3KNc9?=
 =?us-ascii?Q?4aPY12YRUQTstNh5wEIlo8RkLq3+3KTERDYq3cFnenPEI2b1750Jm2kjxjBu?=
 =?us-ascii?Q?FRW36f3sB5OoQXjMQvCBvT+xptKmsO+6kKcRAb0KHzNP/tkGhdL7MP+8aSaG?=
 =?us-ascii?Q?bbDv2SzM2rKyWD7vYWWN5IHsRLLy2wqhB9dBqCtNr3G2kt5K7vy2FtXvwSh8?=
 =?us-ascii?Q?vN10g9v9FvztsCrMD7SX0jOTJbQlUgWyUP0jGfJKU2heL1qtyhokc24x2YS1?=
 =?us-ascii?Q?PpYcjyTyWSGLdTxTu5mSU+YI/a5DAFuwSYI6dUnghoj2L/SxxgYl6F98DsdO?=
 =?us-ascii?Q?Kca9+hq7hhzGzkGngIqn3WjE2CSTXNDSablT+Xw7Xmz29K4YnWLpzn334XyJ?=
 =?us-ascii?Q?mtvM9IcPdNKbub6VmJKcMG5Wdoh997Hg7giV6zjkqr4wvlsE2fJzH2q2z/rQ?=
 =?us-ascii?Q?p7S8fzysey5+zKMyZ0wTzCcUuIt91epzyu9jrHhSIop42ip8h7+IJbzcip3n?=
 =?us-ascii?Q?eCNd4MX2XQW1GGMMlh/E/67lqj7fjWsgsFt4jasqISjL02KZinly1TgDLibC?=
 =?us-ascii?Q?6cvTcHgtnA0786HC14DmBxmUoRiyjqFCKEvj0IRT6ikTtaoG9I81yC6dviYc?=
 =?us-ascii?Q?pZPKnnN3ZQdP7k1/zyCkqpfeJW2yIDbfy64Wu8JoLas3lyyG7msoRjpui4ed?=
 =?us-ascii?Q?aUy03Z9LgiDSO/328+4lqdQcpBtEZh8pJm9qLj1t5BVU4tUsJDyHUKiklLCB?=
 =?us-ascii?Q?fTT20NScXJj9VL/5CEiFS/avSGA/2dqY/Q1H6s1xIJ5KhC2C3clHT3NgurDd?=
 =?us-ascii?Q?OCFMP9AJ6nTo4s+VctowaAgd1SZqjEwSYsn97JT+CPQihgtnG6FH3jGYerA8?=
 =?us-ascii?Q?dKrd78/GkzwHz67KaZfoJVJfLdaiBbf9qJbmrgznDxrlKdTqXcp1qAdi20Ql?=
 =?us-ascii?Q?qOQ+XgHtoSf5OzPjOvC8cuOR4gsgx8x/I1G9NWpposV1rrvA5yPBuMS5gXRs?=
 =?us-ascii?Q?r1tDEQYhcmhp9x3U/YSt6cVX37tz6TEwHFOXjurgO7xiIypi8+YdnF+LWvmJ?=
 =?us-ascii?Q?pAhjuK03y0PM/bvUnEA6ViM01h1vE2KIkiHuiJHTfcfDSQNCwKSKaLa4Gsvo?=
 =?us-ascii?Q?//KtnoYwMQ6/kIWAO6U6b+B15V98anD3DZkJW1ED+ba2Y7li5jTST3RQOEVR?=
 =?us-ascii?Q?bzzffKf4D1XI7Sy7auzvghhWh3Gj2rkrb4zH5R+6DLfJQ1eAL0jyACJ31wNW?=
 =?us-ascii?Q?66EQEBnZcXwW2Cipq9dAKK3CTdoNcU/5brPI/E1KFrtALlKTh3vBJ/IaarTw?=
 =?us-ascii?Q?iNquuvCDS3VRPpaTvTM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fd4630e-5ecb-4388-05f7-08db5a6543bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 01:38:37.7510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aUC/++Vhogz44gYczZLdxGVuzP8CTP7502CfB0vjGaEBCtN9YBCqj9dKID/p5M7e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4387
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
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Friday, May 19, 2023 8:04 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Subject: RE: [PATCH] drm/amd/pm: add missing NotifyPowerSource message
> mapping for SMU13.0.7
>
> [Public]
>
> Looks it's better to add a Fixes tag like Fixes: 4dd9b5392c57 ("drm/amd/p=
m:
> fix possible power mode mismatch between driver and PMFW"), if I
> understand it correctly.
Yes, will add that in V2.

Evan
>
> Regards,
> Guchun
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Evan Quan
> > Sent: Friday, May 19, 2023 3:53 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> > <Evan.Quan@amd.com>
> > Subject: [PATCH] drm/amd/pm: add missing NotifyPowerSource message
> > mapping for SMU13.0.7
> >
> > Otherwise, the power source switching will fail due to message unavaila=
ble.
> >
> > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > index 1b6116cf8b4c..cf6827179fd1 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > @@ -125,6 +125,7 @@ static struct cmn2asic_msg_mapping
> > smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =3D
> >       MSG_MAP(ArmD3,                          PPSMC_MSG_ArmD3,
> > 0),
> >       MSG_MAP(AllowGpo,                       PPSMC_MSG_SetGpoAllow,
> > 0),
> >       MSG_MAP(GetPptLimit,
> >       PPSMC_MSG_GetPptLimit,                 0),
> > +     MSG_MAP(NotifyPowerSource,
> >       PPSMC_MSG_NotifyPowerSource,           0),
> >  };
> >
> >  static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT]
> =3D {
> > --
> > 2.34.1
>


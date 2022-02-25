Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0AEC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Feb 2022 05:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD96610E2D0;
	Fri, 25 Feb 2022 05:55:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F183710E2D0
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Feb 2022 05:55:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6omPvssvWZxWvUCblvWMbxtp/f9RgFPyjEb8bLpW3EibeJib3UQhsx02Vn6FQPq5EKuSngMpermxy7G/1C2oqUDTDQIYVEFTbSD5pd+rA9xO+F8TLqsLW9X/q1SD2Gc7qurf+rDmqGLbLcIc4Y74lTKPnnRA6LkGXfiMeAV6yisrJCiC5N7FH2i739aBd0hKdv84nYLzjgHifpGbk9irWcJNoTdm8VeVUg8BP/uGgcs7ufECAc5cp3Tr7Ik7OnaQ4wQ5vkpOw8dcbyoT1svCBbnJj7jjfObsgzU5vbDt8r5mRgw5wBl0rODaFC5tqoA7JGLtaWbCjARj35cS+UO+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEF1s8EmIV7N36GTsQFgIdL+EEIAit9qNRCrrCk2Q08=;
 b=LrKX+JahH6+7cmGnJnyq7Iqpj/Kp3rN4t5NSaGJahcOnubX8RM0qnatGH6wvJF3AkVhGHD79fetxp5jx/AKk2SfvGw0Y4FHLo5DHFrB87hiTgRiSoiN4KRgPbXPscLpgl7yBVZ5mU+uWlrfaWGjACDO0t0F8dRPZ6lGV6l6b10bfoq7eA/FZLrwbr4ziq3xNrclnk37WvtIRhpY03L5NoOF4Fam+QyXUoCZ1AlF/BmDKpshdc4APtCgP0q/mBCSk22nmY4YdkhQMGGv49Tt6WCw27KbPlftkEh4e4NJo2oHIb6NceBEIFaB4DE5u7hSH6+5D6IBhqNdnHBAvWq+dIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEF1s8EmIV7N36GTsQFgIdL+EEIAit9qNRCrrCk2Q08=;
 b=rXkFWxIDhsWfh3iYLzQmtlYRe51UtqhyiQyxqHKf0+b4MEM7nOVQIeYcBMmvaoIeFARYxa5HhTBJbz+CbXQmI8l1Tvylm8Et/3T29CoxZdnDENj4oMETUivKw/Qqq+ulSTX0ro84hID/BVmYTPRizafT1rpnNceOdtTmKVgpAZs=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4795.namprd12.prod.outlook.com (2603:10b6:5:164::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.24; Fri, 25 Feb 2022 05:55:24 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::7d61:f517:f3f8:9ea]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::7d61:f517:f3f8:9ea%5]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 05:55:24 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Send message when resp status is 0xFC
Thread-Topic: [PATCH] drm/amd/pm: Send message when resp status is 0xFC
Thread-Index: AQHYKf9K+ofRHyEfkUKWe1QTzunzDKyjvH1QgAAFmICAAAH9oA==
Date: Fri, 25 Feb 2022 05:55:24 +0000
Message-ID: <DM6PR12MB26192A826B2B5DF65ED8ED5CE43E9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220225042156.676421-1-lijo.lazar@amd.com>
 <DM6PR12MB2619202956D5AF431734D5C8E43E9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <BYAPR12MB4614577C233FED50C0EFC80C973E9@BYAPR12MB4614.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB4614577C233FED50C0EFC80C973E9@BYAPR12MB4614.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-25T05:36:44Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b109171f-1a1d-47be-8559-ddfee2a8b805;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-25T05:55:21Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 25d9d1c3-c7b6-4220-b976-7a4f1f6dc9b4
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e82210f-db6b-4e33-d34b-08d9f8236aa1
x-ms-traffictypediagnostic: DM6PR12MB4795:EE_
x-microsoft-antispam-prvs: <DM6PR12MB479577BFA68A7201D4437456E43E9@DM6PR12MB4795.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uwLsZRVZSDRROzTUCUa/rjtTaweeVIuw3jHKO8aU8aoGpm/4h3zTlmiBtomjpcAY3Uzb2umWCLb3WL/o3DqQtU8XmDSGrBjgL0IIpizkFQADeBsm/dP6NhbYkicER72gy+ARTELSIacTfhsxP0WLkQ/90zqdjZFC6COfnFtWHgt60du+FxkFQGt9brMwvJw7K0KMcqmzAVe+3BC6bcKzp+Cm+OzASeumXd/NqFuCU7GMDfOG3TqvKHYKuwR4Poc6Ls4gA3/kQ0EZS4o4mDWj8cECvYPxK2lkCP0yv6kTguRwCqSwxQ0YV8jr9dlErSuTMXaokHO141/HiR+HYXuPQ2RpWKw0CgUwWZFEY/MEhnlyQLKEI488JTTd4++I/UFmOnRc+DKoU4aFJh2j29MIKFe42WLtSvQayObMCT3b7sKS0wDUOkrFvg21Se7Z5YIbImiXuyVroTQUtyCC3Pr1coGj+Va6eH7BDn+VFOtE+D4FE9h1fSv96f4PCcbWO+3Wsas+LWEOfISZokpeuuN1Jhhul8LpgXGMSH9iWuC1Ci3T9rmRvvZX6Xf3IUSY9B/J2IVgbnQnqD1BIrijRoy+Mt9GP1g9MhOrVj71CDSW45p68Npiwp37RmDSyvl4vDFie07Otc7NAoOv67zoeboG6EayZE1i3AtW/ET3h/Nn22UHlxjerayxZbGoc3VEC8QygXfXJKiQDBzbzMmmzBYtLA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(33656002)(2906002)(8936002)(15650500001)(9686003)(316002)(86362001)(508600001)(26005)(71200400001)(53546011)(186003)(6506007)(7696005)(64756008)(83380400001)(38100700002)(38070700005)(8676002)(66946007)(66556008)(76116006)(4326008)(66476007)(52536014)(55016003)(54906003)(110136005)(122000001)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?irVUDc2+8Kq45I471e5p4/x4P/ipmK0m/zbO3bAPNGWOh5v6IbEJTyhpVts7?=
 =?us-ascii?Q?w2shD7q9AmYBZl9cegxfWnGQ84IThHhjkciauDweO8DWokqVir5jRGR9g30X?=
 =?us-ascii?Q?Hpa18AI07+UsA6aPi2JyV19HXMqHKQTDaMIQU0bncujkPD+1c0HNapqDxUKw?=
 =?us-ascii?Q?BikHVmZSCQ3LRh52HKvuh9b83KUvhChnsMvsgvNyhz1oOPKyTH9bsSKrjtit?=
 =?us-ascii?Q?GBHLQGxp+n/qGxUNad901JN9hY5r+kjECCAmfGE8DVgxYVq7lZ5GqBqHZ5M7?=
 =?us-ascii?Q?pOBW+NKWuGlDbaysAYj/AcGQn/j4LZI/nb5Mg/TxjG8lw8pnVaqh9UYu5srG?=
 =?us-ascii?Q?lIugx31pA85NYH5B2JRl9V6EBEMEcuYK/ZEOjQbueG8QTzeJzmCSajDTmBA4?=
 =?us-ascii?Q?PAugLx0mAsGasxp/QtNHrbS0fk2gmuOal2dypiQzxiNCOpB+d2N4GvqaRKv4?=
 =?us-ascii?Q?z8RTiVBz8uJ02Bgs6CSoHVdeV6yWc6CA+wM86sf8D2YMyaNdfxCPAcHojmn3?=
 =?us-ascii?Q?I3weRXSCQJtUC1IPc0RMFJx3JBzOv3tGy3HacWrxplrkK3TJ+Rri481bIlqB?=
 =?us-ascii?Q?Ij4g1dkeXUM/dUxYTQ9NCBjTDH63ZuOg+BCxkFM6QBh6s5S+E6htwJJX8jc1?=
 =?us-ascii?Q?qZE7yBR54tminNzuZn4t4sFYQsGhDF6WPyTszRXHCbZfztUVKMtJhTGRf2j5?=
 =?us-ascii?Q?Hhhe/EcNGBDmGfhUUzxGy5kjXxZqieGpdgsdI+OfV3nMY1yHF3tG9Bf8/WIj?=
 =?us-ascii?Q?KD/oCcQ+56enWzJZ3txPZnmIF0m9qTbdN0XY9q8YwqDQg5OSjqd8N7GASksp?=
 =?us-ascii?Q?Lnd/fwB6kJ+hwLbJeTw5puBVY1PxwAa8YvEKLL00kOzEiMYtpL9qjKMDcOfT?=
 =?us-ascii?Q?9Qd+hPgm1ZbYTIWgaxonh5/QdSNgcbUhDl5kp+UEwRrJvHT57ehCWTUQxFib?=
 =?us-ascii?Q?lPlOr1xjFY4FDDgs6LzkrZkRC45Zs8rC+pF/3Bk8a+aGpiHO6XVRKoCLEhpE?=
 =?us-ascii?Q?KothNKOwkhb5w2cAPBpFVBF3OrG29YU/1GyY1CgCYBIhT6tdm91ddPI4Dg91?=
 =?us-ascii?Q?r2TGiB4oKorE0zGTcOZHRwyPniPbjgIOoWmhJpkdqfZjRigxBVxdey7v0zKg?=
 =?us-ascii?Q?B0nLX5MAYAlC0F85znu51xQVDN8+L3bnCNoamQaThoORZlv/QCwCcZFTtAMg?=
 =?us-ascii?Q?Mfpf6dQ2rPjTbMWoqjJOxPN99MggLVoZphkd52QIb5UBcSFyP2G0TAaCEbXX?=
 =?us-ascii?Q?7MrkHcUcWborGmGirM/nkoFURzDOB8ZvlVTwuBiJTnQTkcZ1h6bV0JZvdoPc?=
 =?us-ascii?Q?m6sibroNyTvw8HmX1eBrtGyUvqjSVkzPSTMXXXtTpvP1t7JTdOIpvpMD5Rgv?=
 =?us-ascii?Q?674//u1po4RGiEw72WWjbPd8I7RAL0d0Bx8b1ObY7WQ4KGzX62fs6Erj/7AV?=
 =?us-ascii?Q?VztF+qobnAapspYWB/UneETQIJi/MZislpTuc5jWGNMUKm5Yue8mkt7lJYjl?=
 =?us-ascii?Q?YRhNtye4aoqKgtwMVp4KYEVIYMzYE2VUoI6Iwj6f+3tJl6oJVftdRR0rgEW7?=
 =?us-ascii?Q?b4hoRR6OKv4ssF+wwEk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e82210f-db6b-4e33-d34b-08d9f8236aa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 05:55:24.4295 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ufqpeMWayNeyOMAI4DX3qqpUv0lIzyxm7J6j8obAuMzh31noCGRzCo6nbWUGn7N9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4795
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Friday, February 25, 2022 1:47 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>
> Subject: RE: [PATCH] drm/amd/pm: Send message when resp status is 0xFC
>=20
> [AMD Official Use Only]
>=20
> > That is the caller can perform something like issuing the same message
> > again without prerequisites check on PMFW busy
>=20
> This patch expects this method. Caller may try to resend message again. A=
s
> part of message sending, driver first checks response register. Current l=
ogic
> blocks sending any message if it sees 0xFC in response register, this pat=
ch is
> to address that.
[Quan, Evan] Yes, I know. But the caller here could be another one. I mean =
there may be another caller stepped in.

BR
Evan
>=20
> Thanks,
> Lijo
>=20
> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Friday, February 25, 2022 11:07 AM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>
> Subject: RE: [PATCH] drm/amd/pm: Send message when resp status is 0xFC
>=20
> [AMD Official Use Only]
>=20
> This may introduce some problems for two callers scenarios. That is the 2=
nd
> one will still proceed even if the 1st one was already blocked.
> Maybe the logics here should be performed by the caller. That is the call=
er
> can perform something like issuing the same message again without
> prerequisites check on PMFW busy.
> Or we can just update the smu_cmn_send_smc_msg APIs to give it another
> try on PMFW busy.
>=20
> BR
> Evan
> > -----Original Message-----
> > From: Lazar, Lijo <Lijo.Lazar@amd.com>
> > Sent: Friday, February 25, 2022 12:22 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
> > <KevinYang.Wang@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> > Subject: [PATCH] drm/amd/pm: Send message when resp status is 0xFC
> >
> > When PMFW is really busy, it will respond with 0xFC. However, it
> > doesn't change the response register state when it becomes free.
> > Driver should retry and proceed to send message if the response status =
is
> 0xFC.
> >
> > Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> > ---
> >  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > index 590a6ed12d54..92161b9d8c1a 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> > @@ -297,7 +297,6 @@ int smu_cmn_send_msg_without_waiting(struct
> > smu_context *smu,
> >  	reg =3D __smu_cmn_poll_stat(smu);
> >  	res =3D __smu_cmn_reg2errno(smu, reg);
> >  	if (reg =3D=3D SMU_RESP_NONE ||
> > -	    reg =3D=3D SMU_RESP_BUSY_OTHER ||
> >  	    res =3D=3D -EREMOTEIO)
> >  		goto Out;
> >  	__smu_cmn_send_msg(smu, msg_index, param); @@ -391,7 +390,6
> @@ int
> > smu_cmn_send_smc_msg_with_param(struct
> > smu_context *smu,
> >  	reg =3D __smu_cmn_poll_stat(smu);
> >  	res =3D __smu_cmn_reg2errno(smu, reg);
> >  	if (reg =3D=3D SMU_RESP_NONE ||
> > -	    reg =3D=3D SMU_RESP_BUSY_OTHER ||
> >  	    res =3D=3D -EREMOTEIO) {
> >  		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
> >  		goto Out;
> > --
> > 2.25.1

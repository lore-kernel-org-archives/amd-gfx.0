Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE52C47097
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 02:17:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAD7E613E7
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 02:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD7E613E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AD206F560;
	Fri,  4 Jun 2021 02:17:16 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 270A26F560
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 02:17:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBMbotXdo0IO16ZeNhfKWyuyDRA03qzh1KesvA30L/dI1NvofULsdcygD6L3awaZzZdMzyHnprqP5tRoygX0DjLFPUoC2YADwH7D02nw1Ys1cIe9b0tL5uPi2Gk+FbrzsgA0CFigECwoGRsxMOwQaHmAkFk+QXZ3X2csFEg+g6yBTXgCl3Fcj9STiXhLh0mMwSWW/fLSMOcCxuIC590xTePAtZviYYxsq/yXmtg43cQtcUX7B/DW3Pl9a+iu/9gybUce1ug1UNbR1Li4qq1kbyUyo8AYo80N6m5cncw56/1k38hGHL9bqvtVBd4D3UStS+8ON7KGA7eTsT5vki4wOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbBXHPsK8C3WSrOf7DX3jvByd9FC5PjnYCKLHl/wNBE=;
 b=AgLMiA/nRZWI/pJquOjA+soLRUzz53S5dbbpibDjOUszVop6PLk5G+iRH7Tl2lcMJSko3Kt26L6rNGZt3W/BtHDyx9NpiYBa0TMkLxR/G/mfQxb4lZacNgdyK8DsJ930UAn5i5rLT696QBk+NKAUnSVbePQCfhG41DQtWgb9dyStF5Egg0IQAUrjXyNBwc9P816qKp33DGlNfu6WGw+GbdhTfJA9ajp9uGEAsoACXuAQtxKZsjsuKwxtnVbFOLFKDG0Ehee2iK3kPjk6FemjOpxLyoD4Je0lZNZ10JO0UHkS5GT6Lyp2wEj99vm6ZZGSNVM6LVsjD/w+CjqnuRNAbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbBXHPsK8C3WSrOf7DX3jvByd9FC5PjnYCKLHl/wNBE=;
 b=ZnD8qobE9i58kut0zEKkiXrt7ieV+sipVpoCyeLNbNOOifWQIbDjNBocrLRNrekJ3u1Dm3XL+Pk+h943czRju/i24T6m7NBg6Q064loX2Lc6EVVustBr46Kgxe0JQFO1UjktyHY+XRqpO+NCFwVXcVe8kbisR1D8bxGuTnQK/8Q=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.20; Fri, 4 Jun 2021 02:17:12 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::14a7:9460:4e5f:880d%5]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 02:17:12 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Sider, Graham"
 <Graham.Sider@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation
Thread-Topic: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation
Thread-Index: AQHXVxHsBLX08fID40O0gD3ZLnSdeKsAIp2ggAIjB4CAAA3kAIAAyxqA
Date: Fri, 4 Jun 2021 02:17:11 +0000
Message-ID: <DM6PR12MB26197ADDF59681FD0902780DE43B9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210601181231.24773-1-Graham.Sider@amd.com>
 <20210601181231.24773-4-Graham.Sider@amd.com>
 <DM6PR12MB26199099168565AAFB6690ACE43D9@DM6PR12MB2619.namprd12.prod.outlook.com>
 <DM6PR12MB30676D0E36B54D85296A685F8A3C9@DM6PR12MB3067.namprd12.prod.outlook.com>
 <CH0PR12MB53480D82E2D1C8EF998760F4973C9@CH0PR12MB5348.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB53480D82E2D1C8EF998760F4973C9@CH0PR12MB5348.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-04T02:17:09Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1160a2c4-c7ad-40a2-846e-0d6c59d370a7;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3666dce-04ed-46fb-e6b0-08d926fedcf4
x-ms-traffictypediagnostic: DM6PR12MB4058:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB405847DBC334AA63EDA22C28E43B9@DM6PR12MB4058.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QNPLsZWSm/UjSS+fNzsoDhB+VAsvm1IUIunxX6cGqKa4hD62WtNQDiuOdi5ALVm/zmJ8dSrJ+rJ0YOApt+/SXjpWIcdbEWBB8KMBqZM1hX5xR2HjaGYfEU5FGgYTDYyKc9uCy77knOb++02Kv5nBmjtZyERSkKxQd3RLHC9Na6xOXxRhDbiat5riT6VZHKYRwX5WqkEPuWqPJW4a/RYqd+AqEo3uUHyv7XLbPG+7WlVbyvlhOH+idKNFCfiU3GwQtQBaIFuJTcLoTVz/pBWr00jMgbEXBOhloj6vns6IhgmfMbj8anCeFv6aCOvGaTpXeTqWCERDy5j28finbxqnJoywY8ei4mnqSswrgIAA0bLNhW2xHclj0qw9F38FvR8CfJGqWRGo0nXI61r31eBxNj4E5We3rArFLgAClV+iCK7uN7aOP/dSbdSp6PgKS7jD0dvzfCQR3hpI6IG4TgRFqPiqr5d1lCGNmc54fY8/o92mENPxV/XKny9yNLMl7wo14R0hnleEqpGcBy6wdWnGh8rO4gksOyHWJ7vCsHuRu0PQW9wcoKB+nZl7M0tJTAsEM8zSTeNrQYqoFWStZXOW7/6p0GnZbSuHOECd+O57Xsbx6sjcGs9arR3ckIM79Xh0YQLNfHmRxoezIN+6PmrdO/IKfyAAKV64uCHWYOG6SNdswqKm6IZYXHyNIJ5nMqzNn1T3WXY7MATuq1t7skzZeQ5+A4PL+Fg/DaZoKd9WhdLYVzgyTQji5hWf//6/ZdBr57a+ZZpi+iNvXEMle+S5JoUrOaFIQaH5qxmVX0BKSf8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(7696005)(4326008)(316002)(26005)(53546011)(83380400001)(2906002)(52536014)(6506007)(86362001)(54906003)(186003)(110136005)(71200400001)(33656002)(5660300002)(8936002)(478600001)(966005)(45080400002)(38100700002)(8676002)(122000001)(66446008)(64756008)(66556008)(66476007)(66946007)(9686003)(76116006)(55016002)(32563001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XOyhSRloxJnVxSH0BwAmc9PRWe9rEhGrvcc08KlXQz6Tbv7YRIrbTptn5rm9?=
 =?us-ascii?Q?tR1lA+GOM4U2rRhXPIe2hsrvG/tnHUCAQg584CtCWlcisHJ++0V82KYYRTXA?=
 =?us-ascii?Q?6HG+n9akm5KW4MAHYwy/JpxU7cih2ovyvffUWgRuUntrFoZ6q8QiQOUI+AEL?=
 =?us-ascii?Q?FoMXr8w8Gk9a0PsQYb+mwCZ9X+2pTeK2HrmFYCh7pbBsAqRPSTqJYDVfKnJk?=
 =?us-ascii?Q?CPbS/ryNkgN3eOOrKG4D+7SHtZjapOeQKoWFNEQDYPzznqmByrDtzc96cMU6?=
 =?us-ascii?Q?yYJPUrLQWomr4SiByLcYglwS4ctxUMbVuo6hH9v6ZCmIe+l/vmN+oZUp35Of?=
 =?us-ascii?Q?EtkxdJTAAo4nxKZWrTVXPHsBaKDqr5gmYrkafMytqyvSBAvZfMPX/PHkGbEX?=
 =?us-ascii?Q?SYEOI8qUPTj/Wi3/3Y57a2Fi4ykdhhBgdT4IMqZPblLx1iCGRyjNVRWTzIfj?=
 =?us-ascii?Q?Vc88FV9jL61Lc3TCN7PoxCIkusB1sqvEPB07zsuIQbhhGv4oisqlVI4QXPya?=
 =?us-ascii?Q?3xWRruD6Uvb8h89UsMAs1MyKoLT+lqz1ERXRRhSc0zC8h8P89b08zaIbe1Mz?=
 =?us-ascii?Q?LL2BmTxuucdmruZFmfDePa4pmiBhsjWPHrrI57eMXwru++M9QaNI/m+8IUK1?=
 =?us-ascii?Q?JJ12fWSqshZGNeUQg89n3+n98Nw0Zu+onTOSrgqF7dFJ6Eta+Vs1rX+6wD4/?=
 =?us-ascii?Q?bk8RBbt/l+FXKsg7lMwsBwgrHWPXjFXWfydhxfxazCyZZxTCyoDzbJl0qtl9?=
 =?us-ascii?Q?n9Rwya4NoYIV4Dordl2tReAhVPWUFduIkk1FeRAgAmeYXua+G2ubMYKAek2z?=
 =?us-ascii?Q?Nga31vvm8EZuoj/SgrXaB7zEDZHxSw+RCFy2v06HRMrW089h6Lr7rZaoyHAs?=
 =?us-ascii?Q?/SfY30srH3L+FcP1cpcGl4KyHxNRN6Ev60h6UagMWa6OYt37Bq4Us1lMxmGR?=
 =?us-ascii?Q?cD08vG6KmWUY1rnVAtzV8f/XbIihPZzNB+guzNs3/i3EwyXoGtimUDdpTvr8?=
 =?us-ascii?Q?P6jDfWCQ4zP14wo9L+FhYNGbeoScfYe9e6l5qou8PCKQ0tF7F/APJPrS3Axi?=
 =?us-ascii?Q?+fLSPRXlGw49S1WRO0UDQoC5lymzUJZXsPeBnBUAD40XefPABHhdSZgWRAQu?=
 =?us-ascii?Q?hytdTQj9rDd405AOiUUwBe2WWUYw6DWHZlIKVXLAzPS+aziF+AK/UJMY5EaJ?=
 =?us-ascii?Q?iCPgkT4VXiz8GS9+M4dEyDnOJfJBCGjrIiW3X27s7FbfRC6xOhj3/ZSEH7zc?=
 =?us-ascii?Q?zOCcQaeca+dxEZ7oHdjSjI1NouJ54cQB3laparOfCNRxFSQgnPMuhvhJuXZE?=
 =?us-ascii?Q?2vKJ22cK3+Kafmy+VbhfP6Lo?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3666dce-04ed-46fb-e6b0-08d926fedcf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 02:17:11.8182 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: udAt/ttP4TEB/tKO4RgO3tnolJhMFSpz1IXMp9Sx118cWIHfdojdFWkXHcAYZcBy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058
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
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Sakhnovitch, 
 Elena \(Elen\)" <Elena.Sakhnovitch@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Thanks Lijo and Graham. Yes, I know that only some specific ASICs support VR_MEM1 and LIQUID1.
However, the problem is about the design:
1. should we just list those which are commonly supported by all ASICs.
2. Or we list all the possible throttlers and mask out those unsupported for some specific ASICs

BR
Evan
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Thursday, June 3, 2021 10:01 PM
> To: Sider, Graham <Graham.Sider@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>;
> Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>
> Subject: RE: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation
> 
> [AMD Official Use Only]
> 
> VR_*0/1 reflect the throttle status of separate voltage rails - availability of
> both depends on board and FW capability to query their temperature.
> 
> Thanks,
> Lijo
> 
> -----Original Message-----
> From: Sider, Graham <Graham.Sider@amd.com>
> Sent: Thursday, June 3, 2021 6:41 PM
> To: Quan, Evan <Evan.Quan@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Kasiviswanathan, Harish
> <Harish.Kasiviswanathan@amd.com>; Sakhnovitch, Elena (Elen)
> <Elena.Sakhnovitch@amd.com>
> Subject: RE: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation
> 
> Some ASICs use a single VR_MEM bit, whereas others split it into VR_MEM0
> and VR_MEM1. To avoid confusion, we've combined the VR_MEM0 and
> VR_MEM1 bits on those ASICs. For consistency we did the same with
> LIQUID0 and LIQUID1.
> 
> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Wednesday, June 2, 2021 12:37 AM
> To: Sider, Graham <Graham.Sider@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Kasiviswanathan, Harish
> <Harish.Kasiviswanathan@amd.com>; Sider, Graham
> <Graham.Sider@amd.com>; Sakhnovitch, Elena (Elen)
> <Elena.Sakhnovitch@amd.com>
> Subject: RE: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation
> 
> [AMD Official Use Only]
> 
> 
> 
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > Graham Sider
> > Sent: Wednesday, June 2, 2021 2:12 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Kasiviswanathan, Harish
> > <Harish.Kasiviswanathan@amd.com>; Sider, Graham
> > <Graham.Sider@amd.com>; Sakhnovitch, Elena (Elen)
> > <Elena.Sakhnovitch@amd.com>
> > Subject: [PATCH v3 4/8] drm/amd/pm: Add navi1x throttler translation
> >
> > Perform dependent to independent throttle status translation for
> > navi1x. Makes use of lookup table navi1x_throttler_map.
> >
> > Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> > ---
> >  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 43
> > +++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > index 78fe13183e8b..bf376b1be08d 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> > @@ -238,6 +238,28 @@ static struct cmn2asic_mapping
> > navi10_workload_map[PP_SMC_POWER_PROFILE_COUNT] =
> >  	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,
> > 	WORKLOAD_PPLIB_CUSTOM_BIT),
> >  };
> >
> > +static const uint8_t navi1x_throttler_map[] = {
> > +	[THROTTLER_TEMP_EDGE_BIT]	=
> > (SMU_THROTTLER_TEMP_EDGE_BIT),
> > +	[THROTTLER_TEMP_HOTSPOT_BIT]	=
> > (SMU_THROTTLER_TEMP_HOTSPOT_BIT),
> > +	[THROTTLER_TEMP_MEM_BIT]	=
> > (SMU_THROTTLER_TEMP_MEM_BIT),
> > +	[THROTTLER_TEMP_VR_GFX_BIT]	=
> > (SMU_THROTTLER_TEMP_VR_GFX_BIT),
> > +	[THROTTLER_TEMP_VR_MEM0_BIT]	=
> > (SMU_THROTTLER_TEMP_VR_MEM_BIT),
> > +	[THROTTLER_TEMP_VR_MEM1_BIT]	=
> > (SMU_THROTTLER_TEMP_VR_MEM_BIT),
> [Quan, Evan] I'm wondering why you map the two ASIC dependent bits to
> the same non ASIC independent bit. Instead of defining two non ASIC
> independent bits.
> > +	[THROTTLER_TEMP_VR_SOC_BIT]	=
> > (SMU_THROTTLER_TEMP_VR_SOC_BIT),
> > +	[THROTTLER_TEMP_LIQUID0_BIT]	=
> > (SMU_THROTTLER_TEMP_LIQUID_BIT),
> > +	[THROTTLER_TEMP_LIQUID1_BIT]	=
> > (SMU_THROTTLER_TEMP_LIQUID_BIT),
> [Quan, Evan] Same question here and for Patch4.
> 
> BR
> Evan
> > +	[THROTTLER_TDC_GFX_BIT]		=
> > (SMU_THROTTLER_TDC_GFX_BIT),
> > +	[THROTTLER_TDC_SOC_BIT]		=
> > (SMU_THROTTLER_TDC_SOC_BIT),
> > +	[THROTTLER_PPT0_BIT]		=
> > (SMU_THROTTLER_PPT0_BIT),
> > +	[THROTTLER_PPT1_BIT]		=
> > (SMU_THROTTLER_PPT1_BIT),
> > +	[THROTTLER_PPT2_BIT]		=
> > (SMU_THROTTLER_PPT2_BIT),
> > +	[THROTTLER_PPT3_BIT]		=
> > (SMU_THROTTLER_PPT3_BIT),
> > +	[THROTTLER_FIT_BIT]		= (SMU_THROTTLER_FIT_BIT),
> > +	[THROTTLER_PPM_BIT]		=
> > (SMU_THROTTLER_PPM_BIT),
> > +	[THROTTLER_APCC_BIT]		=
> > (SMU_THROTTLER_APCC_BIT),
> > +};
> > +
> > +
> >  static bool is_asic_secure(struct smu_context *smu)  {
> >  	struct amdgpu_device *adev = smu->adev; @@ -524,6 +546,19 @@
> static
> > int navi10_tables_init(struct smu_context
> > *smu)
> >  	return -ENOMEM;
> >  }
> >
> > +static uint64_t navi1x_get_indep_throttler_status(
> > +					const unsigned long dep_status)
> > +{
> > +	uint64_t indep_status = 0;
> > +	uint8_t dep_bit = 0;
> > +
> > +	for_each_set_bit(dep_bit, &dep_status, 32)
> > +		indep_status |= smu_u64_throttler_bit(dep_status,
> > +			navi1x_throttler_map[dep_bit], dep_bit);
> > +
> > +	return indep_status;
> > +}
> > +
> >  static int navi10_get_legacy_smu_metrics_data(struct smu_context *smu,
> >  					      MetricsMember_t member,
> >  					      uint32_t *value)
> > @@ -2673,6 +2708,8 @@ static ssize_t
> > navi10_get_legacy_gpu_metrics(struct smu_context *smu,
> >  	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> >
> >  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> > +	gpu_metrics->indep_throttle_status =
> > +
> > 	navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
> >
> >  	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> >
> > @@ -2750,6 +2787,8 @@ static ssize_t navi10_get_gpu_metrics(struct
> > smu_context *smu,
> >  	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> >
> >  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> > +	gpu_metrics->indep_throttle_status =
> > +
> > 	navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
> >
> >  	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> >
> > @@ -2826,6 +2865,8 @@ static ssize_t
> > navi12_get_legacy_gpu_metrics(struct smu_context *smu,
> >  	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> >
> >  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> > +	gpu_metrics->indep_throttle_status =
> > +
> > 	navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
> >
> >  	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> >
> > @@ -2908,6 +2949,8 @@ static ssize_t navi12_get_gpu_metrics(struct
> > smu_context *smu,
> >  	gpu_metrics->current_dclk0 = metrics.CurrClock[PPCLK_DCLK];
> >
> >  	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> > +	gpu_metrics->indep_throttle_status =
> > +
> > 	navi1x_get_indep_throttler_status(metrics.ThrottlerStatus);
> >
> >  	gpu_metrics->current_fan_speed = metrics.CurrFanSpeed;
> >
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> >
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.
> > freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> >
> gfx&amp;data=04%7C01%7Cevan.quan%40amd.com%7Cf05ba28afbe0417ac
> >
> 54008d925290dc0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63
> >
> 7581680520671680%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> >
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
> >
> PzZzTHlRh0ygXIJdQeN8%2Ff4ojC9KcCy4Ia5POPGw1nI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

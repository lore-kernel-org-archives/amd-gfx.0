Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE61C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C6A67AC84;
	Mon,  6 Dec 2021 10:20:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35E8C73893
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 01:43:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAk6VCXyh22woGWbc6sUzlMUaMDNddvDXk+zztEHz+zFTCVRzE0dhkCkZ6qi/x7r5WX3d8+M45JoCang6iz4gFkeeBkjKhoSwJvClScAHXxZ48heh9/67H6PelrGoQDmZL4+FlPWteQGKIAsbEjNKwgZF3dS6hGNTX5e+X9Pf0Ipt0Rch1/fj2kDbg05NKunwqTydUv1+XcF/ScuLggxY6Jhe1yMowEcR3/ANJpraad/Rl+MwZSIeeQetgVAI1gyTHVV7sZuC7HLNXuHLZf/4vpCujlKR59nJ5NM6HAsTDRQOGLSLeZQKd9OC190jrWrRzevuJ0XCyhNmqQb/QnaWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdSY5A/z0PtZ2NEGhtcNavpxidK/hjsTcKBWYn7WjE8=;
 b=GajZy9RGA2bAf8OfojTbTmRHLbatjochwymydYZfQJpZOT+T2aknBpdSSMli9Sl2PtEs5SjGASAKB1jraH7zonnB3EUcKg2Zm7sVrDNqWC/hH67UT6HaszQnpCqgDQ4mEd/FEY1B6LBLJ2YXJfoWD1SQNeIEUtzGs9U3xVQdAl8esBAFuDy/OmIPrRizkwel9026lupbqmft1IUf/O/IGiZ/NWVFBp9a0qIVaT79HQFyp6d9WdqXRgoGj4xz63w4yKrHumj1i6Sqya0c4Pp3FW06z32khV5TxeLt24lycaOHNKLEtra/hrzC9ooy3q70PG+p2U+5NaKR/bLwJXWeXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdSY5A/z0PtZ2NEGhtcNavpxidK/hjsTcKBWYn7WjE8=;
 b=UBB0yZLgnVvdQMxaRAIf3H2SZxp8mVBGoEU55Qx4IrRfPlk58KtxfCOGiLc8XAEh2fF25ZdQnENnYMsnjXcuGSoDi+adNzw5011PUo9EH2xo1dzBCD6dWwluHlXJ8WsUvZz/gZ9tPf0zA3fx+7qlrGsRw2K50l3ncHlzeL1n+44=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Mon, 6 Dec 2021 01:43:43 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 01:43:43 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Li, Candice" <Candice.Li@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amd/pm: print errorno if get ecc info
 failed
Thread-Topic: [PATCH Review 1/1] drm/amd/pm: print errorno if get ecc info
 failed
Thread-Index: AQHX6b8hGFhgDGjWDUOr8mRJLpb43qwksRTg
Date: Mon, 6 Dec 2021 01:43:43 +0000
Message-ID: <DM6PR12MB26197AD0F208A4351C5FFE7BE46D9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211205100143.26904-1-Stanley.Yang@amd.com>
In-Reply-To: <20211205100143.26904-1-Stanley.Yang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-06T01:43:40Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=0cc4d5e2-5dc1-49de-bba2-9c313482b64d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a358c54d-8fc2-42ef-8270-08d9b859d661
x-ms-traffictypediagnostic: DM6PR12MB3865:
x-microsoft-antispam-prvs: <DM6PR12MB386519189271282948DAF6EEE46D9@DM6PR12MB3865.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7xO+JIbgssfL6zYuLXS1bZ5mEC+C6//mB1/VafI/9kMQo8v942panM3s2+4A98FUjBXcy45dUCLnjBs81rl53gpfOBJZADFm6xQOfm9WLRrrk8DL8gVW17GI6AZYCoJcWR+3F00pGt/yUIcFn0Yo7vnBO9U+pGYjkZO4HX5JLFgXls5xrqR2XOVV4wCl0L60upfnx2fMBi+FEoxQFyx0cyfvhPuwGu/8Tc7cQatFFifX9tv7As+9UG0DvgtpPmBtW5ae9Ut9pwYYwPh4ADdwM+9hfYMpmrZM+zufm79+UJW0zwfhN8FEvKLrgm++yuTxv/AG/wGNUSOrQRO4VupAbuE2r76enIlIJO5bgwRNp8g8kcC0etN+rhluuq78yyZqicLX9raDScsVmCv1OeEror5qTWmE2m8yHnpM5vVBWmZ57XGgZUwgGK2ai1XdZ1vAd91Vvn3Q6hhZcueywT7YgISQEUJ49UBy86moMrSyCUGOr8BTDIfRN9YY9eoV40IlyyYgDj62OASrrv+DANn0O3l3t5F8AUahyr/xiThqzcgE6ywnmilXf84jG1Y6d54QClsXyA8+9/O3s+OfZTVIxlQDJO1hNcZ1nnuo3SxYYFThTxAorEe/p2ClGndCvmIF5uSzMeIjR97wmlJSp+0p/6Yeg6Ju9rYwbpmEcy/EZraKSLdNHWrl8CB6URRXKa3iJo4SWoApMvlYXyUU9JfcM4ozEyrzQU32QM5HNRP/vbM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(86362001)(186003)(4326008)(76116006)(52536014)(122000001)(2906002)(316002)(6636002)(83380400001)(7696005)(66946007)(26005)(33656002)(55016003)(53546011)(921005)(71200400001)(6506007)(64756008)(508600001)(5660300002)(66446008)(8936002)(110136005)(66476007)(66556008)(8676002)(38070700005)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nBxoZcAIGzJyM36k1mVtscDzI59D+KZUpEvaK9UKjEueJdEl8COIUQYtSNcP?=
 =?us-ascii?Q?lGEj9V9iUG615hZtPPRtflt9vKGoODNIMvnxsoVr/k5LrcXeyBLK71/9xkLG?=
 =?us-ascii?Q?Jv2HXl9ISV0wF5KzhhwsGssiGlbLCLHOyvoiVZbVm+af2I2T+L8Jblh6Wuj7?=
 =?us-ascii?Q?+znm7i2BQ/pWadrRsdd3ZqyYGo2kyieLlOAhEtU36CdPDeQhto/ynp6tnoP0?=
 =?us-ascii?Q?srGyj/Cq0Ukmq/W0zkzvxZvwPtyCyA2c5aGemvELe4Ok9hj6/h25PvJExBZO?=
 =?us-ascii?Q?ow2e8nsG3B03WhB2YFqnalWpQ5mnR/SN/21HpaeAdJ7+5WmpGdp+h8wshm7y?=
 =?us-ascii?Q?oCfEwsp3/i4pqecMcz/83b6xpttcrc2Lpgpzc2yh4gYKNffdr5EyyFYA2iQ7?=
 =?us-ascii?Q?sKm7i7OMBO9GnNxVDNUljCug2Wh5IpacLL5PwT/JKSl4mB6WIGJjxYr+JhnT?=
 =?us-ascii?Q?EZH8DpgzDdmv5kufKxaBOLCaJefs6n2nqMDaf4bm6Bsj2t8mimRNr2Dcjhfz?=
 =?us-ascii?Q?x3xtQq5RquYB0XEwBvcltJO4R+JYLW66WtUiDF3K0JPCde2j1RW8C9OHpOEV?=
 =?us-ascii?Q?JiA9BWCnpkLB99WAWrWJARUUWS9Ci3JAbpFO2kFvFzZJKEa/oCPqwtbgGjqd?=
 =?us-ascii?Q?48h/bUpdZN7Wn+ZZ2+g5lcm/2jpR9lGmVyhBVJ+6ZH3MkBwVlnFvtPX2h4Rj?=
 =?us-ascii?Q?s8IPvTVr/33Az2a0n4cKSxWgW1x0OovfRhS6NFU4kQrbFlq/uJC3ZgYbU8T1?=
 =?us-ascii?Q?le06YBmXq6hF8qZD2BjdHCnP8SCrBPTKDwPCV+V0ZTHIYL3HGhc4AT1QTlF6?=
 =?us-ascii?Q?FCBN4NGcghIVTVgWsWC168COsnEwuVipVO24Zu7XQ/ia2lG3M1rpESqKqHjE?=
 =?us-ascii?Q?borbi5oAt6ZR+dkcmEW9xaJtKqi8U4NtdAc6JZDgTk8a6HxazhXrVGNIi7LE?=
 =?us-ascii?Q?lOyASZ/OtUqiOWB4kmOlshmNeptU0bdjeUkMLHVP5DEh7U4UxXhV8HsMuNRu?=
 =?us-ascii?Q?8ngbsPwbuOpj3jw8yZyIlLEQ3YZ3reAvQtxp+ZKfeHCMm0T4F7cSqrBphuNN?=
 =?us-ascii?Q?MkjdY+LIaBgy+XMj6cUX7NOv4+FEzV1VSGuhHMNLHE8NG72yNSmLwFRzDtsM?=
 =?us-ascii?Q?8uy1nmebFAAUNyCKaVLkMmIe661rlzP2TZRIaNAdV9BqFrE0nDcCNV5hRm4U?=
 =?us-ascii?Q?rYe98gvl4eWz6lgDL+/xPEKl+QhXMB42aCnSCa2ZOl64WFlwHbSSxbX5nhRK?=
 =?us-ascii?Q?HV/I0ebF2ipWrNAxrjxxH7h7UGJNlEKat4+XWFuvODGRLWng9l4DW7Pxw3yk?=
 =?us-ascii?Q?oe0ZZYrdKDaK/umdVzdn52FO4eTmPbHmbZQoo7vuZFcm1Cw8yuif74HmqBka?=
 =?us-ascii?Q?1AoZu/gjymjra5ccJgwLv7hN5M8HPVgmcXVy3h8X3V06TMEaEv5AM2LoapZr?=
 =?us-ascii?Q?vDwGv+9yA4HQhXJ6FvErxyfsM3C8xyAyYvlplq/H3QRvVrCdgfS8sDWHTQHx?=
 =?us-ascii?Q?sJYIAlQBzF0WAmjZke7JT9oSh9SatIRc/xuKwCgDIJ266jf0/lgFnsrRzzld?=
 =?us-ascii?Q?gvZ3aO5QY9YeJZ5E1Oo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a358c54d-8fc2-42ef-8270-08d9b859d661
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 01:43:43.6571 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9EYX/iZZzWNBmDLYayHttg/V8vWZWusyBQFwCo+H2IKvIJStdf3wInRqyNwhrnwT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3865
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi Stanley,

There is already error prompts in the smu_cmn_send_smc_msg_with_param() use=
d by the API mentioned below.
Can that cover your use case?

BR
Evan
> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Sunday, December 5, 2021 6:02 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Clements, John <John.Clements@amd.com>;
> Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>;
> Chai, Thomas <YiPeng.Chai@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amd/pm: print errorno if get ecc info fai=
led
>=20
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 6e781cee8bb6..e0a8224e466f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1815,7 +1815,7 @@ static ssize_t aldebaran_get_ecc_info(struct
> smu_context *smu,
>  			       smu_table->ecc_table,
>  			       false);
>  	if (ret) {
> -		dev_info(smu->adev->dev, "Failed to export SMU ecc
> table!\n");
> +		dev_info(smu->adev->dev, "Failed to export SMU ecc table!
> ret %d.\n", ret);
>  		return ret;
>  	}
>=20
> --
> 2.17.1

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC99C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 16:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A18AC10E86E;
	Wed, 29 Jun 2022 16:57:15 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A63E10E80B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 16:57:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhVJ+8jFBJLMV35M5Y0nkgCRRDRHOZ2IM9feDguqlmPXxhaNTXPNQ3LYf+Ur2BoxSGAkDLfvZS1lfZuHJ6fHBfunNzcSAt9IrTdYdqlVg1LDd75FB7pZily/ec4XGmHMgEgVpHvnwQ47KxndKiXzo0YJSOX/zQN03AyyxT0H3tNXTs7NKyMWGo28K7MW36eJ/z6xn93wT/BIJP0TZKGtXQt95QHgft71DG8FkBuNxdmJUk9Ced0D1G3G4TNh59F7t4z7Ex+zgm5H0FGOS1zCm6hQjUU2vHvtZxJZ4j6m4dXyopcberIobiPJFiNYCixY/yuK9b8n6fuL624Mh/sNgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLSCn9Vi72RuIe3sriio5rrSypgjzjhmJELfo1j5ySE=;
 b=KtEvc6DGErJpdc7qpjcox03e7Ih6CUkqlM6dVDnRK+vG279bCLCMGfBzUZhsAQEztpAE+SQvXMAiMFV0XteV6yEdkt7rsSNWiGNrfYIElUitPLvlFAyoOnvNq2qbKP5fMO14hUT8PhW46GfLHPWFE+DXdJr4PoRT576lBuP8Hze+5L4vkfU6JuHm14xK4IAUEzJ98KC8OoA9i/aSaVVO7eonit/IcGablgTW2M1XaLaX282u5PmecfvOaJAB2TurlPgZ9gm7UJecwJvlEZWL3DU1uRUz1+mjwAxosjQzB6pfQa+503OZt/XtazpEcY0s8WvMnph98m5JV+UIVHTJag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLSCn9Vi72RuIe3sriio5rrSypgjzjhmJELfo1j5ySE=;
 b=n/Rxov0zOpXkXmwEwkn4A6wPrJGHZFByztNACGF0634bFjsVnlhSu8BUFHoitY2bxali9LHGiUA8tZ1bPTQnF838S0yvO7Y1aU9pDVkYMobfEmgJ7IS28NdsFqMtffGEdNdEIAuRcX1icaCqkIg7GzzSIl/S8pl9DV+vS/Inj6Y=
Received: from SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 by MN0PR12MB5929.namprd12.prod.outlook.com (2603:10b6:208:37c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 16:57:12 +0000
Received: from SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::fd9e:c9da:16b5:a35b]) by SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::fd9e:c9da:16b5:a35b%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 16:57:12 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: RE: [PATCH] drm/amdkfd: Fix warnings from static analyzer Smatch
Thread-Topic: [PATCH] drm/amdkfd: Fix warnings from static analyzer Smatch
Thread-Index: AQHYi0ZmJwh8SNuw3EmRE3n9zwdWGK1mj50AgAAMB9A=
Date: Wed, 29 Jun 2022 16:57:12 +0000
Message-ID: <SN1PR12MB257561468CAF7D349266AEABE3BB9@SN1PR12MB2575.namprd12.prod.outlook.com>
References: <20220628232538.1316250-1-Ramesh.Errabolu@amd.com>
 <20220629161252.GX16517@kadam>
In-Reply-To: <20220629161252.GX16517@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-29T16:57:09Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=659dad72-c87f-4c01-896f-bddca3e9724f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-06-29T16:57:09Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: ea28d488-303b-4636-bd7d-4e7c988ea13c
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce5c0402-4da8-42d7-2fb8-08da59f06974
x-ms-traffictypediagnostic: MN0PR12MB5929:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9rPgJoh3VbPS6hwJlMw8Apn2lGiW54LP9elBCTzs5DMFMvxJAYJixQnxng8qsC7SdPmC7etjm2/ZyUthlnBD7/cp1Vs9+3G3NPdNhw3bn7k5gcb9QpazwvnYhonCBG/WdilOvF7mXnY4J+ibTSFC63n+DmVOlFzVwh7ZhZUSkJ1U7xUJv4CCl2UXYWPlI+WrE+exvjAbDCvU2DigAWL5takcjoyjqgW5pbps5/S7OCJr3QjtppIxbMZw6VzkIZagnuHnY33XIuRhdqOoYTdOVo5u7aou4oUH4y4LsiMFKPa/F1Zc3w369BioQCBvK4AwZoU0pnIwPZn4ofanCCN74mwuqmnAItU87scKKtGhb9zEtDjO9z0fMK0UbHYTiNn33J+FvtGlz+yokH57y5ZETU7I9tpK61aWJ4einwaU+GtOmh4Newg71oqLtouMucy+fupXVvcBqEJXF1uBCf1mqw/Vx3u4EofqB3vFvrUqdEZtOtCwzO19zDokno2S3x5qNOgJ1/27C2jQNlnPEyYzIE8+uQo4awBtSLmiY2wdGxciUco8uqRaZzJIl7VGc5wcdPuiAcRk9sKZokMZhsOPRNI0wBC4fhjhzVGmrwM+zJ0BoR1If0i16WKV4IKBOk14QZULv+O9GGj4bu/HvozcSGP+45+UCiyo/YXFwgYRX9EOhEGfttnw3+ymhPAOjxGrrhVCyfGSUqbUJg8SAVMjle5GcXCnqCeZkeTQFPhT1ChIl6Yo6Jy5CL4mQOpV+uspf/bqRzX+PlQHqMuFlrr2R3C+sUmt7FGLd4cysIQofh8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2575.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(76116006)(64756008)(4326008)(8676002)(55016003)(66946007)(66556008)(66476007)(38100700002)(66446008)(26005)(9686003)(86362001)(6916009)(83380400001)(122000001)(316002)(2906002)(41300700001)(52536014)(8936002)(186003)(38070700005)(5660300002)(71200400001)(4744005)(33656002)(478600001)(53546011)(6506007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hj6l2NkCV9nSLQ7MG4hzNiKzgH4l7IbDngKDttLEL3uJQGtzplKLbXjB4r9X?=
 =?us-ascii?Q?UUuyFi/ez1K+0kjxio/6bOxUfcoE6Iq3S3jV92Kpb0R4usyn8Zr3IPnxCqFn?=
 =?us-ascii?Q?HDlTD2eXLiAu3KTd8a+Wjw3pI8x0T/tIjdFJTKvSbOoWzH2d3fmgcBs+9NS5?=
 =?us-ascii?Q?nMmknBBQc12zmGLVNq/HKbiXew5OxNOF369Qk0t7pktrjJBXY/YvLiZ1AmBE?=
 =?us-ascii?Q?I2Tw3Lp0jg5MITU+TZUacqsb41uAlvA+nU3JT9h2IQsfG3TxR3i1gTWq9nqG?=
 =?us-ascii?Q?0DXmFWfzUs4ebad+ZRZBUYy8CJnjX6c9VsgfSoeikJ7ETeFaWATseV/vJoN9?=
 =?us-ascii?Q?wYlESfNT76ozXZkViUZhuolnILHeNR44jDqqGWQ3O39toQkzfuUrTUQJtDth?=
 =?us-ascii?Q?iksxCQtxQcNOtDNeU8cDFDahvvOlxy/wo+SOt8crzTPUeO1LbOuH/HDXMac7?=
 =?us-ascii?Q?yJfCF+XUYNc3LI5HMeUhYFRj2ZCxtNnvk+BV+c4m3PUAa64HVAeD+GM1TZzq?=
 =?us-ascii?Q?1cOMHsMz3S6yizbFfv7gGb+IrUkAaVw5db9qBGLVntdr/qBYdWMAcvr5/ul7?=
 =?us-ascii?Q?7xpwNpSnsqgrJSxkmWthtnLycQQcN5ZcC+f4y3SldZl27O3AdTJl3eyqFV6m?=
 =?us-ascii?Q?LY4/7UP4gQ+hcd8/W2nBYtPXAOEltU2x9QaFKkwN9si2WWmn35W2eaVPW8vw?=
 =?us-ascii?Q?3UMHn0of/qh2WtUEXoinEciDYbY+ic8BRkrR71AgiIS81OlNIVhCoH09OyEf?=
 =?us-ascii?Q?fTNic2gwDfoxUqclfvhF7ww/knj+Ddt4mk+WNVsExSZz1dcH+l42H/kCaCtV?=
 =?us-ascii?Q?+tXRfK6giurYlPmQb2sVqzT/zPWOECaYfFqqyoLYw0YZFrweoCw046SJuxqR?=
 =?us-ascii?Q?2qSqOWIM422X9lFkjV3y84xDxe7eZE/f8oOLh9bLQCAfUAG24qtloIoF7qGp?=
 =?us-ascii?Q?j35Gg4i9JC0+qwAGdgOoaF8CJS0r0QqEIcYl1DQdr42Gv4b9R3yfoMVa8wWZ?=
 =?us-ascii?Q?IlhS3DqqtUVHmCRREsqmM6xnDs3PIoITkCjeDwxXrXKVdT8g9WN0FHJ8Vyoq?=
 =?us-ascii?Q?LUk0J+/JaoDLZ7YijT3C6tecQn8DAbM7X44HRgbvd+od9Ds8cR6U3kpx/+ND?=
 =?us-ascii?Q?Svcb2EOSTQCvOvYFsE/aF2yjg+HxD2UHK7jVjsK8R36v7fB9fVd2wc3BLIJ6?=
 =?us-ascii?Q?kp8PhE1VBYk31OexmsnXSL1tm7JjuB1wt1yPf9Id/Sn4+z+i6ZcdNZF5rRLe?=
 =?us-ascii?Q?iCy/BPhdlw38RsT2JrFYUzkkE5zqh470xzvP8dIFIvP+F+xEUFk0hvp13bQU?=
 =?us-ascii?Q?gRzW74tGvJjKvHiHfAPV33g1cObqRNBJQ9bvQabnkc+yYj63xklyyXn+rNjb?=
 =?us-ascii?Q?rojHTpuvtYlRN0EUxqihhBB+B62q1o2GkMbDpbteQd7gynBuqB4qzdnkyy1H?=
 =?us-ascii?Q?uURv3VwCx5Kyj38DuNZwUZSaKrMKym3HoVBW93kx2RN6qgSaHpiP8j+60oKO?=
 =?us-ascii?Q?2mOsvN4ImTSpm9xvoraASE3uxqitzr1ACGrsO0qn6ScSLlRpDAJIm80ZFTft?=
 =?us-ascii?Q?C3LQ3fD3KtQKU7g4MZw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2575.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5c0402-4da8-42d7-2fb8-08da59f06974
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 16:57:12.2122 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ti7qZjTiLH6YKHkuhaMnCNkbib5AfipXdaUPJDVTKczxbICXL8O69uGLtWRqaXslqio2dwqv3wDSo2GSqIrHLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5929
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Thanks for running Smatch on the patch.

Will update the commit message with the list of warnings/errors pointed out=
 by Smatch. Will post the updated patch shortly.

Regards,
Ramesh

-----Original Message-----
From: Dan Carpenter <dan.carpenter@oracle.com>=20
Sent: Wednesday, June 29, 2022 11:13 AM
To: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdkfd: Fix warnings from static analyzer Smatch

[CAUTION: External Email]

On Tue, Jun 28, 2022 at 06:25:38PM -0500, Ramesh Errabolu wrote:
> The patch fixes couple of warnings, as reported by Smatch a static=20
> analyzer
>

I had forgotten what the warnings were.  Could you put that in the commit m=
essage or describe the bug somehow?


> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

This needs a Fixes tag as well.

regards,
dan carpenter

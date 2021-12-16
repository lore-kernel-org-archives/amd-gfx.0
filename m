Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C399C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 05:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98E2D1122EB;
	Thu, 16 Dec 2021 05:26:30 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D46FC1122EB
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 05:26:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qwu7tv5ol/SnQAqMKXSpA1TxWn/r/9d6HksEKWeSnxqZFQz+RYce3pHNNTdJ6ZEXy1i9Iwx8nC0Z/zaY8fCymZ0WJkfLtc31WLFdLR6maTzsryQFNwWprw5gZWpvB12VsKT8k5uI03CUyJapEjoSLPgkA5JcOubvvEnn/jI28lajZnJYzrNFV4qRIpcp879eC6owKyZ8UhaRTQWdz9XO0D0Jt5d82yG2Z+Oew64og4nWrj0frR+F7/s1UzGR5TrCqrJ2L1un5u7La/NFdnwr7iT7L/wjG/pEC2A3REqy7Hn69hcNKj8Dx8GxCgdOFZR2l19otsZss6kN5n05slZT5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBaAmmJozvbMKlxBhSnh0Sp3Xc376XTAsTsBC0X+kXk=;
 b=TBOHVq/efRnExHZxCzt6Yrh7I028GTsO2BdJj/3rL3Br8JvXWBEMK4+GsbUCcG9zd7+0nXEwy7KATPgGWtx8s3RjEZDEb9gXgLS3Wc/ACShD8/Wgrmcbx3ZopQ0pYXcoRvjf85lP864kV7ti8X+TaAe4nosfbVuYDMh4bZnaWNC0EAGEWm5WSSFS24Pll2NEpQuTd5vzt87dZpcvun+nSxO1S7PxDJzac25zAW0AwYuki04ep/gVFOy+VyAgj49JqGTUovLk+S75u1463mn+WD9lEN/ezNh5g35vFj8RAhSf5uvEBX0+UwYGk8ISJ543dlal4fActcYu6vnJAz4sug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBaAmmJozvbMKlxBhSnh0Sp3Xc376XTAsTsBC0X+kXk=;
 b=O2OfowryLAqcE5MD/fdSSttrtJRAYifIuzKuACqbaAOEoAm1fgWdExUqXg0uNN6wADNpRM2BZGWjcXJNXGeLUTHrHSKflegenp88KGIo0ZltkXxO6J5Lf4Qs++4ytRcPhpw+bJJj6nmp6skke+yk45kEIVv0cGnd4RmdCTCmJlw=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Thu, 16 Dec 2021 05:26:26 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4778.018; Thu, 16 Dec 2021
 05:26:26 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Fix xgmi link control on aldebaran
Thread-Topic: [PATCH] drm/amd/pm: Fix xgmi link control on aldebaran
Thread-Index: AQHX8cuEtdQfgAGtmUedMx3hfT6Ilaw0lyzw
Date: Thu, 16 Dec 2021 05:26:26 +0000
Message-ID: <DM6PR12MB261963BE32D1C0F469D192C4E4779@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211215155015.615018-1-lijo.lazar@amd.com>
In-Reply-To: <20211215155015.615018-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-16T05:26:24Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=bbee56ad-256e-41b2-9ef9-e20346b323e2;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 637cbf35-ad63-442c-8659-08d9c0549b7d
x-ms-traffictypediagnostic: DM6PR12MB4297:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4297421D35432D38104753C6E4779@DM6PR12MB4297.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:751;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kd5b0IMoxzP1cargpvtfMrmKfsEpkcop+Q9PtK53Q43rwF+DG2IiC5wagSn/WRbgf0LJsvwDfeyOlQ6GYy9IlSzvhAw80oDnXGYVz9X/rbqxsRylGh02QXnnS9wxuWJThVsyJFDWP+0U8gRf+Qc0ZGXnlbDSP6Pf5WuIHZe1Vx3PhHoCh+1FFL5DBARTAgHwcyKxLhoC+gQzYWm/+q1QcIiBK1uxtDUXRsGG3TX+nxefMGrksXfDacRbE1+zH7rRlN6OauiMflSK2IEAlzxUr3PRdafyw2P3kLbFtXIIBJMMHTOhCWwrWtQNgwpuQ4q4r0TI53Bbapo+TWTp8RtrWFCxn/aHDm2lrgpefUCLR7hWbBD3Rg0jekCdupeh3c/uH2lLDV8iQb8UnWzVPjaQz4OKHLGSiPUM7wqQYfePc/E8NETq1zH3ToBujaJtOIz02kP92KN0LENAYLzx16WCmocx60BEluF1IB9UNE1Ux+JeRHJqsQenD7XQn78ntpHanGh/baysf2ZWVqXgZOpuntIWU9NusaPTpT53EN5UMvOH6nkaSBsSCiTwKgssjJ6GSG5ZhBlzq1/6f8WSmSp7mdzz6JEh76fG77mj+MCulSEpOBRo1zCYQubBn4FSBQGp3sdYVFkwR6WmjrS7/lR0ohyg8qULpMc2ByJqowerQVQ9djwa0ri/pEglUi2JJRybjKQGgCt0dLldQfQwMIEbvg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(54906003)(5660300002)(86362001)(2906002)(110136005)(52536014)(33656002)(64756008)(66556008)(186003)(8676002)(4326008)(38070700005)(66946007)(9686003)(316002)(122000001)(55016003)(66446008)(66476007)(38100700002)(76116006)(7696005)(83380400001)(26005)(53546011)(71200400001)(8936002)(6506007)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1tUFACtWFLpzlGvrNs1e+cA594nl77t+Q4Ch3/Oyi4aDRqFRM3PySNJA0ecg?=
 =?us-ascii?Q?bP4Jz5nqWeKpBK316EFc0+SoGBemaS/ff+m8eNZ+w6w8dRKRoW/wqBtoAYXa?=
 =?us-ascii?Q?UUncurtR9m95yVC4GlM+Jv9LlXKwNsPGGEVQv+8naqTrrfs8PKCN7yUfXiL3?=
 =?us-ascii?Q?ACgYITFE2uVDWJhovC0iDn+M8qI6VxNbLSjbjsq4l3dWFZJ6hE2iFrXDuHfB?=
 =?us-ascii?Q?pPRytRHhYitQUfvskaNokuBH2gvFoXmNv0w910K4zwXlT25zapyd5HdhG5qn?=
 =?us-ascii?Q?UhsxhbPOJwBsXppb3EeApQG3PuU6rPRGhFizbSs0sksVZiz1DAMmM52K/KJN?=
 =?us-ascii?Q?AKAGHpgjXR5aL/eff/7mcl9b2HD9fVr912ppRxRU4GXuH7m97I0J0qRyidvU?=
 =?us-ascii?Q?mf+nLm6i5A0dOgoj4kZjCeu97dCfFQFYXlxKtrzi0eBzoLyilT/1UtkFn82X?=
 =?us-ascii?Q?AQU2N4RJ08Pm2aALBePyXFWfqq//ypBE53S3LAqf2w0dHf4PTI4Un/xIUq0h?=
 =?us-ascii?Q?NOy4y3Fp6dmQMB5sdj6OuY+Bf4Mvj5U8KlU3D5/JdxWz1csKsBRExyHmlpYk?=
 =?us-ascii?Q?4i4Sbd7KlxOeen0jcVf2P8tkEk7RQTop7Anxafa4Ao2IhXU7yX1ovmGYW2Xi?=
 =?us-ascii?Q?kHNAeyCJdM2Pzv1+cZs6LnsB2dHG8pnsWB38TV+biSzwMBqachT23jeVwwfW?=
 =?us-ascii?Q?kkRy0FzH/XBuPTIdtlbfc+op+P762r6eQLAc2ZrpW9B8e2zjVFDfdYnBG+/H?=
 =?us-ascii?Q?9gHjzk0V8KqbTwWX9HYEmf2VFdFl9hV6PjzhlraXg+omblvhXWdYca5o5K6x?=
 =?us-ascii?Q?cfvonBrWXDWJSxcUL+krGXfWQzys7pitlV8CUeH4WtZ6J0aMdGXRPOWETCTW?=
 =?us-ascii?Q?2H0WvuN17GJ7FFOXFJE/cpyaTF7bZNj7AO7FzOiFO9J0xiOGJjkfYcrvE3N8?=
 =?us-ascii?Q?Lglkp3o8sQFROJa084l4NT6xoJXsse1dS5QsT5hN8hfLPV5EE9JuJ7oryCh6?=
 =?us-ascii?Q?OjJOmYUBboiyuL9svDmg/lBJ4QEhyeoEkpO/c1iweSipZA8ssGXmds3NjmX4?=
 =?us-ascii?Q?zUuL6G05LxwpWjiy5xzEdoKB2JElK6TfrSEkRTfoedXacmEVvIGhNt7J1cwM?=
 =?us-ascii?Q?s4E/WqzIWz1yJ7gMAjvNjyMYGq3WS3AcaesT5GTkjrIHiE0RadPadPsA4xDy?=
 =?us-ascii?Q?rZnxriF2r6gGmNGs3d81HIBI3f83QUshWmFomWHpryhnimkOy4OXPV8OqZWs?=
 =?us-ascii?Q?YF0Dsd/MkRTZV0t+O7zixEy5WoqZuZHADOd8g3whQRyaLOfvGWV79+hk0vnw?=
 =?us-ascii?Q?wOUKteIcR/V8Y+ZKwxfItRIgNf1F+gwMqH+mPAVrZvpsPfenNpxEgCL2bHfA?=
 =?us-ascii?Q?CWdYTsMK2xC3mmwIKqhmBpdm2BpGA6rfee+yIvEfJrPrTylYk8Evzd8+0hu4?=
 =?us-ascii?Q?SU6pklj9x6Laesuhh4nfWDmhVeVWuHihUBMQA5NJCpgb6UtOFtyZaESIGypu?=
 =?us-ascii?Q?gUiEoTqTwVcopJ//cNCeO4/stJ3Zu5YN5tVSpkSSPbfdAPx1qDvEwxZ7/WeX?=
 =?us-ascii?Q?t3tBhKRpj1NSnvmlNqg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637cbf35-ad63-442c-8659-08d9c0549b7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 05:26:26.6897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AK4wKiXcn4JZN7a4JA7p0l+h5DHBUz30I0YDR7pvOYNUMB3OhtFHKFJP6tpliO7L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo
> Lazar
> Sent: Wednesday, December 15, 2021 11:50 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amd/pm: Fix xgmi link control on aldebaran
>=20
> Fix the message argument.
> 	0: Allow power down
> 	1: Disallow power down
>=20
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 0907da022197..7433a051e795 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1625,7 +1625,7 @@ static int
> aldebaran_allow_xgmi_power_down(struct smu_context *smu, bool en)  {
>  	return smu_cmn_send_smc_msg_with_param(smu,
>  					       SMU_MSG_GmiPwrDnControl,
> -					       en ? 1 : 0,
> +					       en ? 0 : 1,
>  					       NULL);
>  }
>=20
> --
> 2.25.1

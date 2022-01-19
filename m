Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D5EC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jan 2022 01:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E63D110E1CF;
	Wed, 19 Jan 2022 01:45:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 829D610E1CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jan 2022 01:45:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBW+I/EvueJ8Oth8LOPtBWAHq5ViTpqY3E4t4P6J+s0gPhxhgK4/jP2YupUL7wL2OO3hRGUNCGKt2U1iI7IzTdk6dLk3H2aDA13nCHT0pfW3t/+C8H7IPcd4ZvNp23bjT3wXodchhxvH/CI/ufNt66gCE2M2v/c0X0GvzUzSUr2uCo7oQcJ3E1iSN2H4l51C2wgUkDdhXUdl9T3DmJysutAlqpsJeT6zzVZMz0QVL3idLIu0awsPJZBYxrNJ6W8hx9HPCZfnlsxTR4+b0AF4cmGvf0F9dEDKIeM5HLOCGntZpZADTe6f7NM4skt48yd6bV4Wz8zqRNh/htTrLBYs3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkicEbG5D0jE7sgVhXHzxRXGIoHnFuKu/x5RqjxZowM=;
 b=VC5etIWhpiY3GmlsK6hcgU1b1QLyva51NaaV4EGFbRjMG3I9CAw9J0idZTKemnQsZYfoSshpCmYFLOclVfcPRZPKhhKP18Byl/70ID7hg6h3Lhp+QKdEBIO2K10ZkJpnWtKsNozL8yBiQuvqRPhQvkw47gFunn4Jv0ELKq+irDwyUjj0P8O+1dPCzA2bpoj9Z1rSB+lyryJWNQP8qbIsWzNNdqA5jc7nteu5Sbt3KR02PYwGcHhsSeag0y4opR4mLixRJkFkC1NJLXwV3ulFOOzaesXuNMiJb6gepxhGbsq5BSp2khUpcstX5NSsI1PlVXvJ8ymZCW790je4vldeKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkicEbG5D0jE7sgVhXHzxRXGIoHnFuKu/x5RqjxZowM=;
 b=VWRUbrjaGKutpyf4KW9HaLwJLIoIa0kkIq04BdvVNKVcgUXOuc+Hkl13zsAnpRuHwClNBsTiw9eCWwXB9J9hlWcGUwh3ChyVeLTxako2BshGg2hOOtNBlNqywxYjIlz/pVbxZxQ4RkAYcQUFJxcFAoDaXMDdW6rOPhWOBmMl8fE=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB2668.namprd12.prod.outlook.com (2603:10b6:5:4a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Wed, 19 Jan
 2022 01:45:48 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%6]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 01:45:48 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3] drm/amd: Warn users about potential s0ix problems
Thread-Topic: [PATCH v3] drm/amd: Warn users about potential s0ix problems
Thread-Index: AQHYDJmTeqdeVfl2S0+a3kPwlBg1mKxpkoOo
Date: Wed, 19 Jan 2022 01:45:48 +0000
Message-ID: <BYAPR12MB4614D0EB07738E929BBFA52C97599@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20220118183102.32482-1-mario.limonciello@amd.com>
In-Reply-To: <20220118183102.32482-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-19T01:42:55.1618380Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 545a1c57-aeb3-4557-e01d-08d9daed6b13
x-ms-traffictypediagnostic: DM6PR12MB2668:EE_
x-microsoft-antispam-prvs: <DM6PR12MB2668417DD640EC29F9554E9197599@DM6PR12MB2668.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z62OVnTBFsubo+bU4jHEN7xjuFIhYrii5F0qEslZKuPo2Cpmsc+4dUOTZ4z+paH+Dy73k9iHWY+JsyLOu2KtkJQEaawXdXeeudyx6+XmYW5yXr95iATsdA/IiQ2IbgS+O8Lt6lGvrnreA96+yXyX1sS7AhwzeyZrZPFtrjCvPMFSLaq6ei9+id3j7aG3zmbJR78LSB0ffn6jzlBu0O7P8+W8hH5O1WKwgZ9HIeiwJ9C/Flja0+1O7UYSn4rgWcndCPvZdiHg9ACrJI3vJD7lgLI6MbEjCsa0yQlnejb8p3F9asUOqD3WsPvR7zNpDW12D2i/L5vGDsHRKt5FkAJnNrjwH2dtAkZUwpucyiOBsP2kK6DjStmxqqLttIjZ589VREx1TFPL2VJe4/5qn4zDRlQHM5Zm4d8uL5tP5DsFFkGInmDpBF6YgazYeRNJxWPmpieKYuYV/hPnSjvbmEgBjRRCLYRQ1oFu3LGE7EyR/MpwDILfa95krKPEiwuiE5TRbe4PVcffyoO4STbkHuVkj4/9BrNvww42e8QsXgilYXnP2BxteGtVitX2Kupp/0JBT4pXU4TzTPq/Bo0ESYRjmuAvo+rMX2N2vS+HaucJqCm2VwMzZlp3yAzOK6fHvwnuPr/6Iu8tJXhYWZuEsdk17A7cWHv3D3ErhMYiiMbqNKGhwv895Df9z9FyoctI/mh874fHjQcntqJfZXeUvUQNc7obtcIGs6GsDCixy8FCMQ0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(2906002)(76116006)(86362001)(64756008)(91956017)(122000001)(66556008)(66946007)(71200400001)(38070700005)(508600001)(55016003)(110136005)(26005)(54906003)(316002)(186003)(4326008)(8936002)(6506007)(66476007)(8676002)(558084003)(7696005)(5660300002)(33656002)(38100700002)(52536014)(9686003)(83380400001)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aHowzQSLAVSRw8FAUqtCxWUv8E9DoFkIGchb51v2xLZ+BroCC+HPU5GHoX+O?=
 =?us-ascii?Q?1PTFFPy1SE+wCzPdgt5Op4FarD58sGbMlUdJ11NDgJhRr9cyZnPi1AN6UvbQ?=
 =?us-ascii?Q?XGx60pf3hmf5DERjx60+fqjv53lstB9cFJhY4lnIlkGkT5PXg+QNUSf5/Mbn?=
 =?us-ascii?Q?PawpeNCyJHuOpLD/0lYCNsjs8SxjVUsOujEaAFDFJ09WUubA+tmuPE7Ya+7A?=
 =?us-ascii?Q?Gx18U+R7ZkHYzKS0vN8ArXOVPMzNwjQ4sChJbnOfHl94X8oa3kTjeiRifaQ5?=
 =?us-ascii?Q?iBlVD+W8BoQmvTe6tp/Skq+LL/ERj/hHro7yPhnY4+bl5puBkOrDS+E7LLfU?=
 =?us-ascii?Q?LlLs5uEIJJjiwXUUHPdCOicBf6v3O+ZcmRkjoNfPvkd8/b4JTABPgtFVIl20?=
 =?us-ascii?Q?PavlbWKXl+MVSbZ4EtYNsQ1fUfZCYDEWZdtFilMEvFn/VO5goOASmayanNdX?=
 =?us-ascii?Q?zgun4uMOytkbXDoEYBKe/jmBP82GxzSZUowrZkqrk3y6yy/he8o+nm3J0HPj?=
 =?us-ascii?Q?+O67GyH5Iv5lWJBhejWX84dlZH/atjh+FVJHELXFNWn8YQf/9YU7fK1gISdL?=
 =?us-ascii?Q?pUMuUNxv6TX+o0tn3vxXJZNcqgeEXyAhpfAPkjbjgUCasNq0Pfl9m0WndvbM?=
 =?us-ascii?Q?2i4ncTLStrTEPMpzpmZ6cnDs3mpRkloaSnwZnmF+nX5rn0Wwycxr2meWd5gM?=
 =?us-ascii?Q?f02e8Ohg72KLhhvA7WTU0MAixVVVCQaP+CfuJjjaz4kKDC8d2Zy+Kony6dyk?=
 =?us-ascii?Q?A0YXy8bqNNWHgcuREyAEHUx88nk0I57vfvduj5DHRwFLP6td+kcn6AWlrIt7?=
 =?us-ascii?Q?8dJO6ox8xw/VckZ1Qyxl/VhwNCWLzr0Iqd3cgi5A/dAoJFGDV1a81ui4TYb9?=
 =?us-ascii?Q?B9RaBdMCFQzInXzm/YX9rXUPzjZQ14Da1lcQeFKaaez34fb8T9dgux1fG247?=
 =?us-ascii?Q?lO/6BKmWecLMoVthm9Los1Chz89W1jydn99LFeV+DafERYGOjn9Jz9pvRawV?=
 =?us-ascii?Q?YS5iUq+NCwnVUEZU1pVRKGYPAmpidUBlUKaE3R4o3PH44fsCVTKLoQA0Bat1?=
 =?us-ascii?Q?EYN9g1Ur+I96mTBD+YuL87ONdS2PvL9LZwUNDHrSm/xP3CKP2SVymYxa5D6Q?=
 =?us-ascii?Q?QKq0oaaj2aj2PX94XAljAe3MgUbwRjtOLRSQRZInZzfyccJ7ibQEpaOxFvlg?=
 =?us-ascii?Q?ncagC0tyuXw/PFx/hdzQdezBBREBmzYO53ORE4xU11vikyi/WJHPqi5UjE7+?=
 =?us-ascii?Q?81aXlhkTRkKj77jIxFT5HiSAtpMU3yzweY43+i076wfIo8xxKu0qe33YUIpb?=
 =?us-ascii?Q?NbjZinp5nDVVBIqU9VdED8cEmLJh+ZG3TdtHwoR01MyXElwbr0a+8OHkLcXv?=
 =?us-ascii?Q?OqTYbJ7SBS/k2nUFt+zbPgwA/H4pqqGs13FDaR6LdQmgeowefOZpvYv/65Bf?=
 =?us-ascii?Q?CA8gtZTmvTTyrQIntkz816HPYPftLeZVl7Vble6FHLhzAOgQZPyz51PclUBT?=
 =?us-ascii?Q?bqLxmqfbfjVdx++BX3sgrDdFxcqDl7rXLClgL9SvbWNhjmxY7aLWlF7a/KgA?=
 =?us-ascii?Q?RmjYH/HteC01X1LmsqfUWYveMVqcRwktO2cTNFhj?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB4614D0EB07738E929BBFA52C97599BYAPR12MB4614namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545a1c57-aeb3-4557-e01d-08d9daed6b13
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2022 01:45:48.6798 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z74re76nypRnbXKys5Vsi9iOXooJfo5dS0R7BwF7s2TdfzYo1r/Qy37X5HVDuzre
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2668
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
Cc: Bjoren Dasse <bjoern.daase@gmail.com>, "Liang, Prike" <Prike.Liang@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB4614D0EB07738E929BBFA52C97599BYAPR12MB4614namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

IS_ENABLED(CONFIG_SUSPEND) will be required for using  pm_suspend_target_st=
ate.

Thanks,
Lijo

--_000_BYAPR12MB4614D0EB07738E929BBFA52C97599BYAPR12MB4614namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<span style=3D"font-family: -apple-system, HelveticaNeue; font-size: 14.666=
7px; display: inline !important;">IS_ENABLED(CONFIG_SUSPEND) will be requir=
ed for using&nbsp; pm_suspend_target_state.</span><br>
</div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div><br>
</div>
Thanks,<br>
Lijo</div>
</div>
</body>
</html>

--_000_BYAPR12MB4614D0EB07738E929BBFA52C97599BYAPR12MB4614namp_--

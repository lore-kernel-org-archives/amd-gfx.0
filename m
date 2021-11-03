Return-Path: <SRS0=5wqy=PW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9196C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 16:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB7461101
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Nov 2021 16:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ADB7461101
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 278F173A06;
	Wed,  3 Nov 2021 16:44:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A6F573A03
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Nov 2021 16:44:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMeit8Py5hxUaK1TGBNmXxFysC2OHwIZI0zEmnWwR3KvMiQtLlyg5QbD+YFG0/as5IrNmgE2nVV2Ih08FpWF/f6ymPXyhuDN+gE4NgVPLiGNUDrWK3XlNTL9LINQtbkksfF6189rtmCDn8hegyM1MUBDrM1LRXHlRR0O/PzFasjGPmNcAI4qQymLJmZzz9xCw5Zk8SbYpbrZKVVQZTsLsh/N5/aaEwm/Ayb6I/vFo3DbJ6ilg20EghinWbv6fXhLKHqoGtcy+sIKnzhF8Dxk9jE+H1RRQi7R+aPeBMeFsf2/u9r4FfEUYAb1QRHeYHfbnrsBx7adxZrnM8pH1z4ETA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVWE+8zdEKiFdHu3S3RCdjLvKU8vVEdx4pZQ/CYsl9E=;
 b=PxJqB/1HH5iKW1HSv5CvYAC3FLljnbt6zwmTxBTrLYa5obeWzSdM/o1nZmI1Ezuj0sMYk06rBIbqSXqgDuyUxIxsv/HIBzgw0MQ3lSFak6tgkz7FJ9Zaf6Fpg3VlcFlCB9CkfK62qt23RZoazKKzYt7K/pmg5Y8ll4F9gRSg9w81uiDYsytFqNwWzZA8TBf/Wh55mCEnoRxE/EgWSNBgBVImNVfmjZlP9vNKaiEb7LY5CFGASpE006OQShocgcfsKN4//76kZFDhyuUQnGnAT2VUZAZc3D4N4B0oBZc+ZUZz0iHvcOrXRil79NJ69vV6HbAorFAqKxuq8ooOqIdK9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVWE+8zdEKiFdHu3S3RCdjLvKU8vVEdx4pZQ/CYsl9E=;
 b=wq/H3HxSMIdpZILJBntaAyi0pjruZyoGhjw4Erq7JoSjuoVSqKDd4XDvuqwADqjsXWBF2jYFrCJEFa2HW9RHA8Da/h7klJ/e+b/t10RBIBu9hqt4p6sEkCACJtLUAfUyS7qto27p7C98MAVLWok1neGBhxRsUeU5DO47YEn137k=
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4842.namprd12.prod.outlook.com (2603:10b6:5:1fe::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Wed, 3 Nov
 2021 16:44:14 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4649.019; Wed, 3 Nov 2021
 16:44:14 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Zhu, James" <James.Zhu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdkfd: fix boot failure when iommu is disabled
 in Picasso.
Thread-Topic: [PATCH 2/2] drm/amdkfd: fix boot failure when iommu is disabled
 in Picasso.
Thread-Index: AQHX0B8toVUK90PdvUWnIej6tA5P5KvxLGYAgADStACAAAOaRA==
Date: Wed, 3 Nov 2021 16:44:14 +0000
Message-ID: <DM6PR12MB3930ECB53E908F15EEB172B2978C9@DM6PR12MB3930.namprd12.prod.outlook.com>
References: <20211102192324.3402-1-James.Zhu@amd.com>
 <20211102192324.3402-2-James.Zhu@amd.com>
 <e390c469-5584-4157-ccaa-3be588b4143a@amd.com>
 <4136ce63-2865-c4fe-90d5-9cc3f869d59f@amd.com>
In-Reply-To: <4136ce63-2865-c4fe-90d5-9cc3f869d59f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-03T16:40:23.2198856Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a041464-ed79-41c3-fbd7-08d99ee92b6d
x-ms-traffictypediagnostic: DM6PR12MB4842:
x-microsoft-antispam-prvs: <DM6PR12MB4842E07E4631909CD01BD1C7978C9@DM6PR12MB4842.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v/m99ezFQZHxD3qntsnToPZ38fMSRPRRDhN91Hh+y5vxWMEePz1yA7qS9POISoJKEP+ThdVdZyMwYrVRIhBEL3ea9G/wZPXMnqdgVYzZFLPgZf6aoN77OQ+sziFBTOQPLeCV1bWpLNKNd//zjZXHWK1xZFpxj9yl4nKwE3+3AXXHkHo8CxagObf9ikVuYqplTfTH9wl9ssQepVE/V+5JXrmplsMSP75FIlDtsJSaW0I5Nr0cgkrdJMv19Pr4E6gtCjzJcrn/4nA/i4CR8wgIbeknw/QISKee4qGmW41dfxTjJfr4t6JRfo301wxn8swTqHzFhAA4Op81Dylc+xN4gpaQSBVzP2OdkF/0GQ8dozzGubWlTs77adz/EnSdOWkCoqrfxexsObqS/yRjJztmqrtwQDAK3V37jzJhTVHWPGN60JwbyeZB8vRQi+uwqqRY4LCckC3fnoFQ+T7NcY7svW+x8i7PoaywolOeM+CFQPh/qfS5mBidZZ86a8yvvMQMVqO0J6OLWv4aGEu3R5l9FDMOSmUjPzz2vlgwGHUPJtOyYbuUuH2uvMBgv81Z/1iWodO4ipzZsi4kHk/VPpCN2Zr1weycV3cRkGpNsM+hrtCHYjnO7aBy6OFFHqgqlz1HFU+RLNDf/JXsmkg9fpyGB8RAG6OvTAdiaAw0zUa7gpPHNn80QhWy1k8ZXUpHusO9zEsCt3i9oSmljN2DkJdMz139DzLisdKfIRWT6DqWP+q/7PKBDIpjbslCJc8Q5oqwmDH3D8cdhDxtZ3QlvwzQi290jL+Puh4aFLmvphRw4YM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(558084003)(166002)(52536014)(966005)(38100700002)(71200400001)(86362001)(186003)(26005)(122000001)(316002)(6506007)(66946007)(76116006)(66476007)(91956017)(66556008)(110136005)(55016002)(5660300002)(8936002)(38070700005)(508600001)(8676002)(54906003)(64756008)(2906002)(33656002)(66446008)(9686003)(4326008)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Uy97+hXVu1bDpt/pVQ/0ROibAGujFH+5GS/c3VKH+EsOAU6uxSSZXEoebQu5?=
 =?us-ascii?Q?/6jNHJjt0afGejXJE13udYgcZOdO5apyIDKapOTbxZHfb9NKPAsTBXWGIMa1?=
 =?us-ascii?Q?wQUPRz8sESHogKOpBDmQI1gZaHdaEZVWYPqiqF8Q3a/RHwr/fiQixHQtoL1t?=
 =?us-ascii?Q?R1obrqMncX/siK0L/Qucg5iweYYLCGnvEvdLnolMLAsX4celDTXWqtY5d34f?=
 =?us-ascii?Q?72MqeYGWFu+Lo5mPf0ZYfTTOfR3qcklRK3SJJ8I5udIU2H+tgqc0SYv3QIX6?=
 =?us-ascii?Q?DFNc4TK15PRA545NSqBrtYyI6Nggny8jMC7/0dCQDaoCULuFnONz5OsiFh7I?=
 =?us-ascii?Q?SZDI4D8tQp4jt2tXPO1SyQmvD/vS/z/H3NwfUVQwhZ+7nWRGt0GxOmE0Mz4l?=
 =?us-ascii?Q?e5B32/77Sx9vnhC1ZlkxnTHgrODt7Xa/qqyMlym5mtY/ybW6Q6Z1oSQiYDJN?=
 =?us-ascii?Q?kz/Go7oJgemxukmRqsIPuugG6rRPYAZOKtdwYE0VUYyu0WFK4iwZ1Z23LFxa?=
 =?us-ascii?Q?spcXJh2NimtHLmz0ktpAmBlCDYlbT8eNDHurUhq5MzbLdkNgnLZq8jcpya1f?=
 =?us-ascii?Q?xGHQZeBfPCHe/WTci7wbDsSnXG1uiQWUaqTnsVE8iD/DjilrBCsM+cWWJqz9?=
 =?us-ascii?Q?OF0YyKmFfluLY5CxoRXK57Juj5w3ofVvZ2VPuK8fdRsk1HtnNzJbNHg8Wgdk?=
 =?us-ascii?Q?YOjGfnUocCASFS7f64AVNvCuZSvDed/TV3EZlnxxZQt1f1oq3X2A8ccxA6LY?=
 =?us-ascii?Q?XPQHrdKxKc3asCQ38i319PwlJLpualIBgxwwxCJz5GBppt6/DKRy2ikdG2R8?=
 =?us-ascii?Q?L8pqIJy0MGvZFYPTNVv4bDzx+zzprv0ejPl+ZQHSFETluqQtRPsicfAgektG?=
 =?us-ascii?Q?ZaOr16kPvjzjULusL6m4R7tLRm9WWFRbpttdblacBq+c+ifsvhiqhxxo/idm?=
 =?us-ascii?Q?M9lIaLZ8kWcgrRS/X9zgHlC29KUVSCKMIezTa2td6sshiUDTh8MG+Y9LKjyA?=
 =?us-ascii?Q?WtmY8cveJAy804m3JEJQ1OBPFCX4WeLHcGa5ZGSMvbd0UUuGctVbzGO5aDZd?=
 =?us-ascii?Q?RTnuGswp4b/7dkEIdvKd2a0bboEde4Oe991tv0KlfEHZtpHOSqktRsb+5DOv?=
 =?us-ascii?Q?PFDWkU/sCkZ6nqWaL+XO+BqBUoUAJV4Dz1sDI702ytubyEc8q3MWNVL94MjE?=
 =?us-ascii?Q?edHYUeMxsWoW1o+wsRV1XK8yeXO3FrwQusvLvpFofj4LP7xqHDkowgw8/z7Y?=
 =?us-ascii?Q?pG5J8HbmkFvVW/9OIe0eyOgWoJuI9ZKkTcKVIN9XLueVYGX9v/2v/djPmcjp?=
 =?us-ascii?Q?ADotewZYiSBR/4jGaoPJ9ksIsP3moIxoJkcOsz1uq6dOyipcGf3ZQ2OAhXBR?=
 =?us-ascii?Q?DAsPZjJLnlXxS7tbi8GlU3Y+7YfV5K1J49VQqxLiNzAFD12mdOjqlUt8mKSw?=
 =?us-ascii?Q?48lIp61LwkEyy+orpVJnOQ0pud+WvH+FhbRlwImg95avryRxl8Fi6gBdJuY9?=
 =?us-ascii?Q?0BrGeGlhogakreqMRImQgZ2Kzixfys6oBTlw7liafmVteAzdRtvS4f0DVzmU?=
 =?us-ascii?Q?ENkFiRWKA6TzoMoj/Kg=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB3930ECB53E908F15EEB172B2978C9DM6PR12MB3930namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a041464-ed79-41c3-fbd7-08d99ee92b6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2021 16:44:14.0593 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L2trTsucw8DpUJvH2d2PHBj1OrBIsaLrxpmjB+YacBlHzK2NYM1Qc8r5CvFQDOPK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4842
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, youling <youling257@gmail.com>,
 "zarniwhoop@ntlworld.com" <zarniwhoop@ntlworld.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB3930ECB53E908F15EEB172B2978C9DM6PR12MB3930namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

It's a conditional case for some kind of early reset. Haven't checked detai=
ls, on a quick glance it appeared to call iommu init again.

https://elixir.bootlin.com/linux/v5.15/source/drivers/gpu/drm/amd/amdgpu/am=
dgpu_device.c#L5160

Thanks,
Lijo

--_000_DM6PR12MB3930ECB53E908F15EEB172B2978C9DM6PR12MB3930namp_
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
It's a conditional case for some kind of early reset. Haven't checked detai=
ls, on a quick glance it appeared to call iommu init again.</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<br>
</div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<a href=3D"https://elixir.bootlin.com/linux/v5.15/source/drivers/gpu/drm/am=
d/amdgpu/amdgpu_device.c#L5160">https://elixir.bootlin.com/linux/v5.15/sour=
ce/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L5160</a><br>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Thanks,<br>
Lijo</div>
</div>
</body>
</html>

--_000_DM6PR12MB3930ECB53E908F15EEB172B2978C9DM6PR12MB3930namp_--

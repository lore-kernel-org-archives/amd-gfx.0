Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D47C5DF62
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jan 2022 12:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E0E310E582;
	Wed, 26 Jan 2022 12:05:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FC7410E8ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jan 2022 12:05:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuiM4hvjUdHYdIPO+nBlBcpX8sOrPB1GE7/FXXjX71hnHwBmCUArmiAbG6Eq3AlZfC1QnyYb24F42slqXXA9Is+JTRrMTtnx37Uh5DKCjAVMo2B5bCtaS5UXZaBsBBiaJ+J3NIdfQ19v6cIY1e7weH/9O06/5FeHemdRpfhCN/bReNjsGYyh57OiLEJIpW28GPYfdQ00Ji1B3e/W04H15GJP+p9xaF9rxG1exPrq/PvuZ8+zABJOG79vZILx8yJGKNjbRwqbXOYgA7eN03a++HbHJPY/oRzFhHflVsOenctzWMIzOeCg1x+l7BGVmRGAk7AysOk1MjECNeACc63YUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBcmwfvsmtVoMu2LHpGZuUTSYhipmWp1sl5ZLT3ejYQ=;
 b=Izdz9acE0uONvyF+tgBzuBBplgKXhvwR6psS0unTe6n9p3W5KfPYGQ2kSpa+ohZbhhoa7GhK03gBI3whIXNaN4p/V3e1Fw1sookCXN9wZIFaKYGmKcbm3xi4zoD03cI9aNhXH3iuuG9eSWAa7vfl27ninzYG2JNM2tE6nf9rAbHp8R8zI2rZ7ndc3n40w4QxGEf8k4O9797wldSCrveWP2qeBXQjan/KiUxUGLFKv129oC+59z/UndicgI4ENyvPN2NIltautHLCs5LlVMabtZ5GLLm6eTc4CV5NGBfl1Huc9FLadrreEplaf58bxtuG5MY8aam6+cXFKS2EwPzUtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBcmwfvsmtVoMu2LHpGZuUTSYhipmWp1sl5ZLT3ejYQ=;
 b=kDA5rpQm8ZWkNaa480uffiqgYhEgtWEjp52yuHdd/If3bce8wMZpZLs7IuQPOLb2RJT2shnAzVU/cpoIK+sMT4/NuveH8GZlE+lsdgYWpL00hyCo1QVs51B7DKrg3RmI6xlO7cNdi7HuhJdeELKoW4ixoB7MlawWG1/jFjD1V+4=
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.14; Wed, 26 Jan
 2022 12:05:38 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b%4]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 12:05:37 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: add safeguards for accessing mmhub CG
 registers
Thread-Topic: [PATCH] drm/amdgpu: add safeguards for accessing mmhub CG
 registers
Thread-Index: AQHYEone9cdwB033MUaGEuk1BmCgMKx1MsYc
Date: Wed, 26 Jan 2022 12:05:37 +0000
Message-ID: <BYAPR12MB461439BFC58135ABF0C42D8597209@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <20220126075326.1134770-1-Lang.Yu@amd.com>
In-Reply-To: <20220126075326.1134770-1-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-26T11:57:53.7533653Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1d96983-afc8-49b3-1cc6-08d9e0c42a69
x-ms-traffictypediagnostic: MN2PR12MB2941:EE_
x-microsoft-antispam-prvs: <MN2PR12MB294103206BF216A0643C396897209@MN2PR12MB2941.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7hHC/fU9eBsbau6oQiMNAgVCNWsuwo7juXHVKxsH9uvXYDdL/4ce1PjcmvMip6COtQOhRZw6BMp6KCjekAwolIxXkNfoMPp0eT1OEklpPkFJGWBKdyps24QSti6Gh9t89hok12SMb+98iawnHlVnKTvDEte7qd6roxu+Fo8a3gMqtbVSAQrOaXqhWycKk68IPnfxubHyg5BeIvVL8R9YS73d4Jyvh409Ri65zSkjaYT/4oYHoUAnaEAFfkXg25WMInSKwU6crgoJx5xDOt6ArweoquDDAV0P2x0mKRquEoHKmuEmYOExYMAvGmw6FpY7U1qlFFWjESZsmTnA5SfAPnNxTTZggKFz7rsc/gK8EHmGcC4OOU6fAgUe59ZNkSrHid3TLdIdKn/117HiPyTvMAsaMKnYCUpfoVw0ofOyncKontjFF6BmkI8zxset00WXPYP4621RqYbZwGXkftfRjOT8nmVv4sZNqxUeplqYJ3MA22buTLW+UE6kk1s184vuigcyvgWPJhvLKJXiuJUlc8hrzExxEesOXK8CAbVrsmzgIyK+TFB4SMoqsOAbykcc4jPa+ODkVOGg5lV9z9kNCro5hvFf1kadtitHDdThxzATcVlXMBpljjuhKHueR1n8MKcuQ5G+0ThQg60lDwpsJo9ji+4e1x0EG+3lj8oQsLlga4SXzx8TVTz2IhzvxqJbaBkjf0gKKhmiirG1PlLpAQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(4326008)(64756008)(26005)(76116006)(6506007)(5660300002)(71200400001)(33656002)(86362001)(66556008)(91956017)(66446008)(54906003)(66946007)(316002)(38070700005)(7696005)(9686003)(508600001)(4744005)(110136005)(186003)(52536014)(55016003)(122000001)(66476007)(8936002)(38100700002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?If7nJFxz4QSUPzssSMDG5QJC8XPUo6VD6Lv3tfRqnoIuPKUv0Z7x3OF4Bkhf?=
 =?us-ascii?Q?RZ+znX1zQPXAnh24nSmFkBvWVWzPv9r7dmdNYpzlfxTe4tu+REd46dP0NrJk?=
 =?us-ascii?Q?e9ZteNgCszoTPGdovv74cMQ9T0fe9i1nrQMOSNnGHvzIlEXp8tC3lIM4/T0J?=
 =?us-ascii?Q?qEZ7z7GRB0rK7yyocUX0Owz5eiyjixWCBLJQ7Itt/38UjpqzqKw8OcySb8SU?=
 =?us-ascii?Q?rp3keLMdDtvTfPwVZmR+zJEN16JHdy4jHSnngnHkAgM0n4oyz3Oyp/Al9J/S?=
 =?us-ascii?Q?NpoeopmePR28j2pAE2JS1rSmeGqeaKjn+nOn6QU2m/TjAK3bLTo9yliOKSPs?=
 =?us-ascii?Q?ZVBOnX6wjqEVRe/2XJqDvDAI2rtprz7Oo90CrGbGzTNr6Q3w5/pcLENxLSfK?=
 =?us-ascii?Q?RXK/Y3b1xyh1RqBNp1vpTnuoD65RBefd6kM05Ut5QsjjmUGi6xMw538F6J9T?=
 =?us-ascii?Q?uMVqhP/rfEFZ6Z/q1fZcjiFOSu13xna3z19EJmkpUYOFHXb8Xb6VzdH74bpz?=
 =?us-ascii?Q?WNKomtBQAXcYAxyTGy4ywcS2ttDj0SgFLD6LLB1KHkMif+Gdm8dqL7xAWMwz?=
 =?us-ascii?Q?gWE3MUtsa0HxbPvIbdYoxVyw973Rbld1zMgTw6/Qxd+JooWHQuazNyxxcILb?=
 =?us-ascii?Q?r+aYMENkWj45O5u9P8qYKLZ0uDcXuVqRIsGewTYVHr1SDZwuHPDFoivklX5U?=
 =?us-ascii?Q?bZRyXyimxChe5amBb3lVjAEEhr8+WRIE4M9PpY3MGWw68OpDhrkVr/dqTdhU?=
 =?us-ascii?Q?/Ienhbe0qa+L0ug9dnzkebF/+JgCs8PhOWWUuGK3ZhQcG/uelsYsTMiK1MRd?=
 =?us-ascii?Q?Ase5xZV920fgbq3Wm1LwVsv/7t5jCuMKjnigwNMB1lljXoFKn6CL4s31ZOMs?=
 =?us-ascii?Q?3Vt5axbtnBVLlZqd8VjQmFwNgAMoaml+jx04uPbCtYZ6AziWr24tBkABZ6Qn?=
 =?us-ascii?Q?6Yw7TyejyAD8uCGRYNKZOMYrlPNJP7elR4zqoQpj0IucX4xnsTSlTw52RrPj?=
 =?us-ascii?Q?JGXMbtxFINnpTEvLxTXzk/fqqlYrCvantoJvXnlOoM+/adFAO1jQLSBdpwgM?=
 =?us-ascii?Q?4xB7S4GrOVebMZxpmE259yz526jTTeY62qVHbfdXJPKQ5oL9lb6AqJ7SX1bp?=
 =?us-ascii?Q?5L75BBSUG5kknki3TXjqbRDucnB+ARjxFG9kmqlZCj9+03FXYNmx5h1CKdfr?=
 =?us-ascii?Q?Skbr5RTIYu1pRoNhgXjNwkOivCL5z+5U9BtM+HgpIOZa9w88Bp5l+piZYKEv?=
 =?us-ascii?Q?XxgzGfhAqaxAAUwsfBYZfpf9DEVcbx9h+o4OfpvaUdtnHO4Al1u1Xu2oN8xx?=
 =?us-ascii?Q?qeqKfmFuv9yZbvquJ5eQCN94sF/Wd4jyJRuJJeY1A2mMyZzC3Tbu0QBaGUHu?=
 =?us-ascii?Q?K2xGaN2rezkLC68/IV/PB/ynwD/mxfC/uH18JPtPhlXioeKl0re1GuRYlUD9?=
 =?us-ascii?Q?/D9ggd2ecxsDE9RBFR4zYqPLaTFLPfU8QQqSEkpLjasnDUDVg+Vfg0v9bz2f?=
 =?us-ascii?Q?frQ3yZ3PxqKSbk3KHiFUCrSsUOsn1ZlXlDaMRhHCK7p9gTOWzcNsZn/l0hcJ?=
 =?us-ascii?Q?8GX8HIiqkT+6kvMk9OWOuR85Tp7Qqy3G8tLWGMs1?=
Content-Type: multipart/alternative;
 boundary="_000_BYAPR12MB461439BFC58135ABF0C42D8597209BYAPR12MB4614namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1d96983-afc8-49b3-1cc6-08d9e0c42a69
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 12:05:37.7660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cMuwfC4GFwUQ2z//r2ygiM1qwtUlpfrXWwwSz8ptC3KT4rFdCT00Tihh3IXBCRRl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2941
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BYAPR12MB461439BFC58135ABF0C42D8597209BYAPR12MB4614namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Hi Lang,

There are ASICs in which driver doesn't enable CG, and then these flags wil=
l be false. However, the CG will be enabled by another component like VBIOS=
. Driver still reports the CG status eventhough driver doesn't enable it. F=
or those, this logic doesn't work.

BTW, could you check if it's some sort of PG which causes the issue?

Thanks,
Lijo

--_000_BYAPR12MB461439BFC58135ABF0C42D8597209BYAPR12MB4614namp_
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
Hi L<span style=3D"font-size: 12pt;">ang,</span></div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<span style=3D"font-size: 12pt;"><br>
</span></div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<span style=3D"font-size: 12pt;">There are ASICs in which driver doesn't en=
able CG, and then these flags will be false. However, the CG will be enable=
d by another component like VBIOS. D</span><span style=3D"font-size: 12pt;"=
>river still reports the CG status eventhough
 driver doesn't enable it.&nbsp;</span><span style=3D"font-size: 12pt;">For=
 those, this logic doesn't work.&nbsp;</span></div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<span style=3D"font-size: 12pt;"><br>
</span></div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<span style=3D"font-size: 12pt;">BTW, could you check if it's some sort of =
PG which causes the issue?</span></div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto">
<div dir=3D"auto"><br>
</div>
Thanks,<br>
Lijo</div>
</div>
</body>
</html>

--_000_BYAPR12MB461439BFC58135ABF0C42D8597209BYAPR12MB4614namp_--

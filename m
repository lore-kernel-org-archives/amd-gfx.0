Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF92C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 14:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7E778BD48;
	Mon, 18 Jul 2022 14:15:02 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E3A98BD8A
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 14:15:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCmAlyD9WRAiVIS2rNG43nhEV3ORsRDkLOroouxd7uFcmXb2yFNsuLCIuF5uC7R8yFu3i52YblWkJJ0rgfaxTu+aU5HclwI5nGrGumniXMbGaTTKOFZLT46+SrVuKIoNr9auiuJrp508oqdOLepcA0K3t98e/URJ29LyPoDEdKr7iZ9JtoTczNHco1fRUeChzSoe9X+46gi+WxCr0ddM50TYKJTSrZA2YH9zuryStBaVfkQX8TsadL47e5gLH3C5iyeics2FSsthWBNTbzaoevVK2msmeWbI6ND8fW9IyvW6sh+4UQwFVb2WQbvQpf5UdS+VQx0H+jQi/JWluKodsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5K8B8D6hybB/KbADkhuM1VcfCvaXQVV0yXl0bQ3Vhuk=;
 b=F7aW1FBe8lABIOI2AhjqzSoxd4R7vemGnK98ChPiZx74Oyay7+4U0B07irtAmSVsYn/Vk+pSiHaMyM7ICvIAZYVgMhGscAlKXIgxXUjFbBQHKE9EfFCza1MBfTtGNxUtpc2RNqhFHcYhyb+iwNdQ6EZQwuuDNfTB4njiHTO/OJRRVO1McAMD/McKoBRxVNEFhm7fSMsoOkWPy5nfq6QztdHzfFyfRbYy2ADbPN+ssB+qEcAG/y8FFlOj1YL/kiG9Tfkx9dT+oVLJiFCKfEz+JpK/pLUEv/FTtuDGZl8MERk7e4xf/61iSxtOiz3AvsNATxDerq4BXfX+GUSxBFXFhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5K8B8D6hybB/KbADkhuM1VcfCvaXQVV0yXl0bQ3Vhuk=;
 b=JGVs216pwktQ8546BMHPLss9l7jn6kGxAFvQJyoINWAJ3BjMS3FVXQa3UkLIosJn4pd2kBNgaEJwxCbMDndox+ptSGXUpSLzPySdVfEd0dzWs7pSvaBRqF3CwZDIYMGREji8KCRrJT43DNxijpecP53dlY5z9Dv0rKM6tNBVthQ=
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 by DM4PR12MB5119.namprd12.prod.outlook.com (2603:10b6:5:392::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Mon, 18 Jul
 2022 14:14:59 +0000
Received: from SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::bc88:3db6:f931:98fc]) by SJ1PR12MB6194.namprd12.prod.outlook.com
 ([fe80::bc88:3db6:f931:98fc%5]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 14:14:58 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Liu, Leo"
 <Leo.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v4] drm/amdgpu: add HW_IP_VCN_UNIFIED type
Thread-Topic: [PATCH v4] drm/amdgpu: add HW_IP_VCN_UNIFIED type
Thread-Index: AQHYmIYVYr2zSI2ZiUqf3I0W/7KGq62Dtl2AgABytwCAAAGaAIAAAWlA
Date: Mon, 18 Jul 2022 14:14:58 +0000
Message-ID: <SJ1PR12MB61946514C9D9B9DF87C9CF06958C9@SJ1PR12MB6194.namprd12.prod.outlook.com>
References: <20220715200410.301438-1-ruijing.dong@amd.com>
 <e2dbaab9-de5a-3180-13a8-cec2c8b0285d@amd.com>
 <7beb798d-73ba-7015-7b3d-441a5daef26f@amd.com>
 <4f91384a-bef6-b8da-77c1-0bd5f4e7b3c1@amd.com>
In-Reply-To: <4f91384a-bef6-b8da-77c1-0bd5f4e7b3c1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a84de01f-c638-446a-a273-109719995ce2;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-18T13:59:17Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f4c3f93-fc74-47da-642b-08da68c7e5ab
x-ms-traffictypediagnostic: DM4PR12MB5119:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J8rSdG3h3cNUsDqMvIj+AMWQoO9wi084kRk0jGt1tRl+a56XVkQeDh6qL2rVCfK32Wvolf4HQ3LL5WwABVujlMAZ8Ox8eqs+moKLmFKC4kP40/+zATtyjX97+RN/t2DNKQuZlFNWzy37AyPiL8MDj3m1DIb4AOKkDoGj/iGfeSOA30dNeJpVyONOvC/rzraB1kfI/HHHInUTdcWrPPBTeeL8sEZPRtLC0qtZ3+hfCfhs2PXQL9tcS1Te+/j2TsTxmoC6b3JRqrTu6Un++3Ontd0zuHb0av6iVgDZi/LMa4N+Gze8SMTUpD4WTPPL4ve0ofjFYLndWciOv+JRntFvlQLjFu4dzCOPcw8IRAAmmDwgzrwWFTQzZ21EbNStS1z02RhkpResxgGgZu9qT2e3XNRbvkAcXlWeJ8mZNB4jZ5zcUfNvff2PFdpe6PfXGesu6MS2A1+RvvmTJvfOW4MWDQEYFG1kJMqAjj8WoJoLJcHE8cEnnC5oY4/Fu0vCx6tqW/6mNezz1vjBkwnw2nM22FeOERlrIfB9d6mlaeM7dKf3OZveChUZUAWKVSEUZ0Cggs1MKOpj6oL+u1lChDI3WXVaVRhOpELLMjLQBtrRfDlc7l4GS1BIyz1lvPhf1OUmzL4e/luDkysKvdBZRCqO9CvDXpUBELrqoEUob6zvdbj6v2+rm2MPeY2VTTA2qEkneUlo0/84MSQWYa3hEprcDzAH8kEpTeot10b+Iuz29cwIxpLxV4/tCdf3oPFhulnFzt+GMt7OueSfrCtaB8hmhw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(83380400001)(26005)(9686003)(186003)(33656002)(41300700001)(2906002)(6506007)(7696005)(66574015)(53546011)(55016003)(478600001)(966005)(5660300002)(52536014)(8936002)(86362001)(110136005)(316002)(122000001)(38070700005)(38100700002)(64756008)(66446008)(66476007)(66556008)(71200400001)(4326008)(66946007)(76116006)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXA2KzB2bVhJMmV3M3hwMDF6cHJhd3dKckxDemhyVE1DKzNMby96VXVwRDFq?=
 =?utf-8?B?cUhQT201dGRtTFhJVWszcnZPUEZhUnJHemhRaU5mQkw2USs2TDZqbFdZS1Zy?=
 =?utf-8?B?cEJBc3dzY1dYQVdEV29lODhrZlhDSkRpaXJPSTVWUklCeW4wMlR2MU56Z2Z0?=
 =?utf-8?B?aDNFcFFCVG1ISjhnMWV3UUNpZTJYRkhYRWFWbEptNEswZldaVGtPTnJmTjdG?=
 =?utf-8?B?QUE1UlRUMlA0RHp5cGZpNm1OcStkOHFzclQ4V1NFSVEwcFhFUndSWTV4bVpu?=
 =?utf-8?B?TnpTaUVNajZ5QkJGSDB5dFV0Mmw4L2JCYklkUlRmWUdQbU5iL3paSmVFNEVx?=
 =?utf-8?B?Tmd3dXlaWEk3dmQ5SzBDVkZhSFdLenA4dFArbUJVYjJSUG9WRXBVcUlUVWxF?=
 =?utf-8?B?M0VyOXhCbHZuMDlpMFA0Y0p6KzZKRVJncXdFZTlENmxLdi9oT2tRajkzZGNU?=
 =?utf-8?B?eGlKNGRGZFBoOStjYVd0NE5rZE41N0FKWXcvU29TbWR1bWs3NDZxU3B5bGFY?=
 =?utf-8?B?YlJpbmNXaHNjdEZ0TDFLL1k0RllyVzZ6SXNteEl2c0REL0Z3amI4aSt2UnZB?=
 =?utf-8?B?SlY5K3dqWDE5NkRlOER3bGk3R21wNVBzR1RlTnpiVmFORy9hQ1pwUnJIdVlZ?=
 =?utf-8?B?Si9NcXhHL2d5bjIwWmwrWEkvWmZ4bDkzQ04rMXZ5NjN2Q0czYkxWdWJPYU5v?=
 =?utf-8?B?RXZKUUErL0NJK01WZFlrRnRLRnZydnNRclMveDFHdkd1T1dnM0hraE42b1d4?=
 =?utf-8?B?U3djKzBWUzh3a2lyM1ZuNmtEbzkxRXZINitvRUdoK0MzOGNyeElsc2NYUytx?=
 =?utf-8?B?aUh0ZnNwTUlCdmN1MDRqZEdNaU51RUcrM3BER1h6YmxHZFQwa1V0Ujh1ZDl2?=
 =?utf-8?B?Uzl3Q2xBaUUxaVVZSk1TcDUyN0tzbEpiSUwxS2pQTE1NNkVTZ1JKWDBMRkJS?=
 =?utf-8?B?R0svZkZQQXNWV2hCK0QrdEZIMTR0R1ZqM1Q3OXdRMStYaG5sZmRLTFdHMENO?=
 =?utf-8?B?WXAwb0YvckJqY2h6TzBNNStOZ1lnbG9iUVNwejJ2WVd2Uk1nVno3SEc5QW9m?=
 =?utf-8?B?UHpnZk1wbTZQbDlVaTI0elY4MHVyQU01ak52bDFMc3FGOUJTdWJ4OXArZmpv?=
 =?utf-8?B?Ty9wc3VrOTdxQjdCRnJsT09QeXp3b3BRaDBQMkhhbzExSmMzSm1TOXdRbkpn?=
 =?utf-8?B?THRVTUFTU3o5WHFVZ0phMk5MS1RRMVBuc1huWlVuVFVldDc3b3RVbDZyd2Zh?=
 =?utf-8?B?Z0VOeVpDbW85NHozcjNFQldpdEZkZWNid0RaTnVEb2txQVlMM2t5Skg1SS81?=
 =?utf-8?B?Ykl3VTNNeHJuck16RFpIVU45SUpNTUgvU1RBOFZ5bk8yQXZsMG1QRi9YK0Jr?=
 =?utf-8?B?WTlhWjE2anNXM3pseGRaT1c0bDdnemRaM0NsZG1QY1UxL2t1c2xCR0FlaW50?=
 =?utf-8?B?SlEzL3ZNSi9USFJtYVdPd052aDYzeERHWEZ4WlljRDEzcVR5aS84MFlySXdz?=
 =?utf-8?B?cjVOUjVnSWdiL0hYcnhLMGowejNrc0RSaFJRMDQ0OGF3TURHSEY2WUZLcmxB?=
 =?utf-8?B?RnYrV1h2dGlwZ1FxZVBRdXdvcEZ5bjlSYmhyeDVGM3U5K1YyVDJnWTdGSzJ5?=
 =?utf-8?B?bGR4OFBwM29TbEMvclZSTG91My9pREFnVjVNRkt1QjRaREVvWHpSY0E2OW5k?=
 =?utf-8?B?bWZBWWpYNm1sRkI3WWYvdElGTUxaWWNjTlhoNHNxeWQ4a0pIVnlwaHdIeFhr?=
 =?utf-8?B?VnZ0NnVFcHY1ajk5ZnhGYUlnQnRxR2QzMWE1Z0xUMXRLdDc4RDRGY3UwTExR?=
 =?utf-8?B?ajhlRVBEZUJPclZsbklWMVJmYWZsMlN3TWliOVBzMjQ4YXFwVVlieGRrMFBv?=
 =?utf-8?B?UllVTmRLaTRqNEJGZms1TlIwcVFrbS8vVE5CTTFLRWI5bjR0M3g1MWJsOWtm?=
 =?utf-8?B?UnB4dXBkb2VWZ1h4clAxc1g3TGZjcnV0aWlHRXpWSlVCUllnUjlYTWxEL2pJ?=
 =?utf-8?B?UCt1ZkhuREw5dFdtSUNzV2ZHUGl5YWc3QldLZFQyOHF5aXZRN2NJT0FZcXhm?=
 =?utf-8?B?LzRJVHNld3hsNWdDYit5MGNYSFdzeHZsYkJ0RHBaSjdtaDkvREFvd0NaeDNp?=
 =?utf-8?Q?q2iQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4c3f93-fc74-47da-642b-08da68c7e5ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 14:14:58.7185 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vBlT1XMxbtoABYcxQAeX/K+4bljAMBlx5TGlAOfbImYUwscwhi0zuKOLciD1GaEI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5119
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4+IFdoYXQgaGFwcGVuZWQgaXMg
dGhhdCB0aGUgZW5jb2RlIHJpbmcgd2FzIGV4dGVuZGVkIHdpdGggZGVjb2RlIGZ1bmN0aW9uYWxp
dHkuIEluIG90aGVyIHdvcmRzIHdlIHN0aWxsIHVzZSB0aGUgc2FtZSBmb3JtYXQgZm9yIGVuY29k
aW5nLCB3ZSBqdXN0IGFkZGVkIGFub3RoZXIgb25lIGZvciBkZWNvZGluZyBhcyB3ZWxsLg0KDQpK
dXN0IHRvIGNsYXJpZnkgdGhlIGZvcm1hdCBkaWZmZXJlbmNlIGJldHdlZW4gbGVnYWN5IGVuY29k
aW5nIGFuZCB1bmlmaWVkIHF1ZXVlLCB3ZSBjYW4gZG8gZWl0aGVyIHdheSBpbiB0aGUgY29kZS4N
Cg0KVW5pZmllZCBxdWV1ZSByZXF1aXJlcyBhIGRpZmZlcmVudCBmb3JtYXQuIFRoZSBvcmlnaW5h
bCBlbmNvZGluZy9kZWNvZGluZyBmb3JtYXQgY2Fubm90IGJlIHVzZWQgaW4gdW5pZmllZCBxdWV1
ZSwgd2hpY2ggcmVxdWlyZXMgdG8gaGF2ZSB0d28gbmV3IGhlYWRlcnMsICJlbmdpbmUgaW5mbyIg
dG8gaW5kaWNhdGUgdGhlIGNvbWluZyBJQiBwYWNrYWdlIHR5cGUsIGVuY29kaW5nIG9yIGRlY29k
aW5nOyBhbmQgdGhlICJzaWduYXR1cmUgaGVhZGVyIiB0byBndWFyYW50ZWUgdGhlIGNvbWluZyBJ
QiBwYWNrYWdlJ3MgaW50ZWdyaXR5LCBpZiB0aGlzIGZhaWxlZCwgdGhlIHdob2xlIElCIHBhY2th
Z2Ugd2lsbCBiZSBkaXNjYXJkZWQgYnkgVkNOIEZXLiBUaGF0IGlzIHdoeSBJIHdhcyB0aGlua2lu
ZyB0byBoYXZlIGEgYmlhcyBvZiBBTURHUFVfSFdfSVBfVkNOX0VOQyBjb3VsZCBiZSBiZXR0ZXIg
aW4gdGhlIGZ1dHVyZS4NCg0KVGhhbmtzLA0KUnVpamluZw0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNv
bT4NClNlbnQ6IE1vbmRheSwgSnVseSAxOCwgMjAyMiA5OjU0IEFNDQpUbzogTGl1LCBMZW8gPExl
by5MaXVAYW1kLmNvbT47IERvbmcsIFJ1aWppbmcgPFJ1aWppbmcuRG9uZ0BhbWQuY29tPjsgYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhh
bmRlci5EZXVjaGVyQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHY0XSBkcm0vYW1kZ3B1
OiBhZGQgSFdfSVBfVkNOX1VOSUZJRUQgdHlwZQ0KDQpBbSAxOC4wNy4yMiB1bSAxNTo0OCBzY2hy
aWViIExlbyBMaXU6DQo+DQo+IE9uIDIwMjItMDctMTggMDI6NTcsIENocmlzdGlhbiBLw7ZuaWcg
d3JvdGU6DQo+PiBBbSAxNS4wNy4yMiB1bSAyMjowNCBzY2hyaWViIFJ1aWppbmcgRG9uZzoNCj4+
PiAgRnJvbSBWQ040LCBBTURHUFVfSFdfSVBfVkNOX1VOSUZJRUQgaXMgdXNlZCB0byBzdXBwb3J0
IGJvdGgNCj4+PiBlbmNvZGluZyBhbmQgZGVjb2Rpbmcgam9icywgaXQgcmUtdXNlcyB0aGUgc2Ft
ZSBxdWV1ZSBudW1iZXIgb2YNCj4+PiBBTURHUFVfSFdfSVBfVkNOX0VOQy4NCj4+Pg0KPj4+IGxp
bms6DQo+Pj4gaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL21lc2EvZHJtLy0vbWVyZ2Vf
cmVxdWVzdHMvMjQ1L2NvbW1pdHMNCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFJ1aWppbmcgRG9u
ZyA8cnVpamluZy5kb25nQGFtZC5jb20+DQo+Pj4gLS0tDQo+Pj4gICBpbmNsdWRlL3VhcGkvZHJt
L2FtZGdwdV9kcm0uaCB8IDYgKysrKysrDQo+Pj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJt
LmgNCj4+PiBiL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oIGluZGV4IDE4ZDMyNDZkNjM2
ZS4uZTI2OGNkM2NkYjEyDQo+Pj4gMTAwNjQ0DQo+Pj4gLS0tIGEvaW5jbHVkZS91YXBpL2RybS9h
bWRncHVfZHJtLmgNCj4+PiArKysgYi9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9kcm0uaA0KPj4+
IEBAIC01NjAsNiArNTYwLDEyIEBAIHN0cnVjdCBkcm1fYW1kZ3B1X2dlbV92YSB7DQo+Pj4gICAj
ZGVmaW5lIEFNREdQVV9IV19JUF9VVkRfRU5DICAgICAgNQ0KPj4+ICAgI2RlZmluZSBBTURHUFVf
SFdfSVBfVkNOX0RFQyAgICAgIDYNCj4+PiAgICNkZWZpbmUgQU1ER1BVX0hXX0lQX1ZDTl9FTkMg
ICAgICA3DQo+Pj4gKy8qKg0KPj4NCj4+IFBsZWFzZSBkb24ndCB1c2UgIi8qKiIgaGVyZSwgdGhh
dCBpcyBiYWRseSBmb3JtYXRlZCBmb3IgYSBrZXJuZWxkb2MNCj4+IGNvbW1lbnQuDQo+Pg0KPj4+
ICsgKiBGcm9tIFZDTjQsIEFNREdQVV9IV19JUF9WQ05fVU5JRklFRCBpcyB1c2VkIHRvIHN1cHBv
cnQNCj4+PiArICogYm90aCBlbmNvZGluZyBhbmQgZGVjb2Rpbmcgam9icywgaXQgcmUtdXNlcyB0
aGUgc2FtZQ0KPj4+ICsgKiBxdWV1ZSBudW1iZXIgb2YgQU1ER1BVX0hXX0lQX1ZDTl9FTkMuDQo+
Pj4gKyAqLw0KPj4+ICsjZGVmaW5lIEFNREdQVV9IV19JUF9WQ05fVU5JRklFRCAgQU1ER1BVX0hX
X0lQX1ZDTl9FTkMNCj4+DQo+PiBJJ20gc3RpbGwgaW4gZG91YnQgdGhhdCBhZGRpbmcgYW5vdGhl
ciBkZWZpbmUgd2l0aCB0aGUgc2FtZSB2YWx1ZSBhcw0KPj4gQU1ER1BVX0hXX0lQX1ZDTl9FTkMg
aXMgYSBnb29kIGlkZWEuDQo+DQo+IEhpIENocmlzdGlhbiwNCj4NCj4gRnJvbSBWQ040LCB0aGVy
ZSBpcyBubyBWQ04gZGVjIGFuZCBlbmMgcmluZyB0eXBlIGFueSBtb3JlLCB0aGUNCj4gZGVjb2Rl
L2VuY29kZSB3aWxsIGdvIHRocm91Z2ggdGhlIHVuaWZpZWQgcXVldWUsIHNvIHVzaW5nDQo+IEFN
REdQVV9IV19JUF9WQ05fRU5DIGlzIG5vIGxvbmdlciBhY2N1cmF0ZSAuIEtlZXBpbmcNCj4gQU1E
R1BVX0hXX0lQX1ZDTl9FTkMgdHlwZSBpcyBmb3IgbGVnYWN5IEhXLCBhbmQgdGhlIG5ldw0KPiBB
TURHUFVfSFdfSVBfVkNOX1VOSUZJRUQganVzdCBoYXBwZW4gdG8gdXNlIHRoZSBzYW1lIEhXIHJp
bmcgYXMgbGVnYWN5DQo+IGVuY29kZSByaW5nLCBzbyByZXVzZSB0aGUgdmFsdWUsIGFuZCB0aGF0
IGlzIHRoZSB3aG9sZSBpZGVhLg0KDQpZZWFoLCBJIHVuZGVyc3RhbmQgeW91ciByZWFzb25pbmcg
SSBqdXN0IGRvbid0IHNlZSBpdCB0aGlzIHdheS4NCg0KV2hhdCBoYXBwZW5lZCBpcyB0aGF0IHRo
ZSBlbmNvZGUgcmluZyB3YXMgZXh0ZW5kZWQgd2l0aCBkZWNvZGUgZnVuY3Rpb25hbGl0eS4gSW4g
b3RoZXIgd29yZHMgd2Ugc3RpbGwgdXNlIHRoZSBzYW1lIGZvcm1hdCBmb3IgZW5jb2RpbmcsIHdl
IGp1c3QgYWRkZWQgYW5vdGhlciBvbmUgZm9yIGRlY29kaW5nIGFzIHdlbGwuDQoNClJlbmFtaW5n
IHRoZSBlbnVtIGFuZCBhZGRpbmcgQU1ER1BVX0hXX0lQX1ZDTl9VTklGSUVEIHN1Z2dlc3RzIHRo
YXQgdGhpcyBpcyBzb21ldGhpbmcgY29tcGxldGVseSBuZXcsIHdoaWNoIGlzIG5vdCB0aGUgY2Fz
ZSBoZXJlLiBUaGUgZW5jb2RpbmcgY29tbWFuZHMgc3RheSB0aGUgc2FtZSwgZG9uJ3QgdGhleT8N
Cg0KU28gdG8gc3VtIGl0IHVwIG15IHN1Z2dlc3Rpb24gaXMgdG8gc3RpY2sgd2l0aCBBTURHUFVf
SFdfSVBfVkNOX0VOQyBhbmQganVzdCBkb2N1bWVudCBvbiB0aGUgZGVmaW5pdGlvbiB0aGF0IHRo
aXMgaXMgdXNlZCBmb3IgYm90aCBlbmNvZGUgYXMgd2VsbCBhcyBkZWNvZGUgc3RhcnRpbmcgd2l0
aCBWQ040Lg0KDQpSZWdhcmRzLA0KQ2hyaXN0aWFuLg0KDQo+DQo+IFRoYW5rcywNCj4NCj4gTGVv
DQo+DQo+DQo+Pg0KPj4NCj4+IEluc3RlYWQgd2Ugc2hvdWxkIGp1c3QgYWRkIHRoZSBjb21tZW50
IHRvIEFNREdQVV9IV19JUF9WQ05fRU5DLg0KPj4NCj4+IFJlZ2FyZHMsDQo+PiBDaHJpc3RpYW4u
DQo+Pg0KPj4+ICAgI2RlZmluZSBBTURHUFVfSFdfSVBfVkNOX0pQRUcgICAgIDgNCj4+PiAgICNk
ZWZpbmUgQU1ER1BVX0hXX0lQX05VTSAgICAgICAgICA5DQo+Pg0KDQo=

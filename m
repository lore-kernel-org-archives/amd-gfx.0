Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0B9C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Nov 2021 06:39:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 923726E103;
	Mon, 29 Nov 2021 06:39:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9B4B6E103
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Nov 2021 06:39:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rl2VBqLJIrhh4HVaXCUm/1GRAowHqSJJBQYmjiEPpL+YPjGQwcGO8zsbG6W9lWlpqNohCdOdLdcLmRMpWmiFNFDt0MnMSeCMiIgcb6ikHB8xw8MLvAgHMnDznehMu2E99r9/ojeNu4Xbv1MpUGWUNvy98VR2QePzQrdrL3+iBLFr4jYwn6pYNoX56lpbHsBNQo3l/XPMzrQ7ocdncZstLfvJySgChi3QxcC0x7C6AMSyBjirM8usj3huJhniD8h/4RjugT8EE67f+1M5mD7SBLcLo48TWoKjIs0w2i6fTDqTfu/FaW4DRNiiQqVNlXjEJN+sVzLEHOMnP0oSQ85USw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZ7dF7oNPtQeH6aVvqzdTi3RAr336a1QkLnxXiQBC4w=;
 b=cJIfyuE7k2soP0qNZHWAm7z6UNiALSpWwbJE/N8Y94RfrzQiTtvVlTTqeaxnv17DrBx/Jg861GldhJQhAMArvX2dPMCMhjmylk1J4VzSM+V0rKSn9sndI6oVb3IaBZ8Fi9WSiSll8pypk+uUkCge1qdgB5cYHNsfDc08CU8ZGJTydWzLwbacANcle6RXUlf0UpMSMseRWk5Rf5OCoBYdclhVywJYrwJBfukJQOyIwWqwwPxI75UQ6zXtzvynUOmvqADyUNZTIXOrDZ0drTzUbjZdTBpPPONsInPwJvrbqxtI0vjdPqR0egyKza0cQSfxE/RwVgpeJ0nSIftBgSi2tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZ7dF7oNPtQeH6aVvqzdTi3RAr336a1QkLnxXiQBC4w=;
 b=bBj96XO2h+c8HYU4GS0ksXaVAkroaOiJSxn8gmtSEpJasYhfmlUqvknJg2EadPWK/ie6DG3QLekAvHiYPgsiCMjnca2EkhbPtCdapHxgL+H5q1xPwNX0ESiD6Iw5/KciBX8xLXc6Lo9mTigNH7eu8nf/BSM2v1QpI3OPKJm0OkA=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Mon, 29 Nov
 2021 06:39:09 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::1cfd:2e4c:5ff9:a458]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::1cfd:2e4c:5ff9:a458%9]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 06:39:08 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>, 
 "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggUmV2aWV3IDEvMV0gZHJtL2FtZGdwdTogYWRqdXN0?=
 =?utf-8?Q?_ip_block_add_sequence_on_aldebaran?=
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: adjust ip block add sequence on
 aldebaran
Thread-Index: AQHX5OoRg6UYt1IVrkKA3iPX50tlrawaDQAAgAAAq7A=
Date: Mon, 29 Nov 2021 06:39:08 +0000
Message-ID: <BL1PR12MB53340AF1A13AF19441CCF4EF9A669@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20211129062634.8559-1-Stanley.Yang@amd.com>
 <BN9PR12MB52578B3E6419AA1360CE3F60FC669@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52578B3E6419AA1360CE3F60FC669@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-29T06:36:16Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=fb4928bb-7ccb-4eff-b460-d0eab3e3eb76;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-11-29T06:39:05Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 83d42e8c-9a34-4691-8148-5574f62e8948
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1486bebc-5513-4be0-1d5b-08d9b302f274
x-ms-traffictypediagnostic: BL1PR12MB5317:
x-microsoft-antispam-prvs: <BL1PR12MB53173194F08ADDFBEAE31D689A669@BL1PR12MB5317.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:22;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7Oe68dP3LerAEah8YqcVOlIf4becTB/5eRaGu5cR4hMyfOJXnLWkPndU9ewQFS91AmhQnv8/BomE0VZOjYbi8SZqP+WdQ+1EnGyTuyIrFX4sQloptvJN8Dp0WZ1WFYarcpIgTqc/DCKKES0syEjwJQiQKPKc4HayC4dsObOUw8IENeYbMuwFr9pgydqutUae0Jt//IWN1oIYPmF8Y3P3qGUicCQLjl+Z9jQSyVyAmGE11yRuxGnSfflY4lu0BJK+56HjPbz0iAw5bwRZmRBhkfgL/7dD4+T5LXblnae8cXB5OuxnaeSFapxvhz1rJI0sQ2txL9YpxrkmWrtExt+E2NzLf6P3eDW9D2XOLLNNyUgcGt+NgEJz1iX/UUUz0JvkDmdLvu4Cu/dYVc93e9INlE/6f/K9323p1qFrl4s/wzqPoVSwAdgtHWiX2C9XXMN3P2ceW8PFOcieTxJDouYVhG7x2DSrZU8KqOxG5cCvNGWDYqwGc/ogU0fm7As6n5Fkx75Lb7AGgR/ZIcHv2Nthat7s0hxlgW8aS9/0yAR3gMNKGXh/LweyJ5ZY5NtFvi+9ZwaW0zt+fDuF1Keqil+otrTHF/84CjnmyVviFw2ZJ/dE4ph4Z9XGhahMw9jnMuXcRtwcctXFmwZwbN5RigioVFhsdw6rR/Ntzn1bUCxez/4sY8ZqdwXi8xHY/Ttd9jRo59e+cL5k5yGFbIsIjQ+PXA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(76116006)(71200400001)(52536014)(33656002)(224303003)(66476007)(66556008)(64756008)(26005)(86362001)(9686003)(6506007)(66446008)(7696005)(5660300002)(66946007)(38070700005)(53546011)(122000001)(38100700002)(8936002)(55016003)(83380400001)(508600001)(316002)(6636002)(2906002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1hoNndYYzU3V1U2UnQvVkx2ZGJjdlVIa0YxVTVYYVFZYi9wRG5UZitsSVR1?=
 =?utf-8?B?bGlBQXFwcWhwdFlNQ2dMZS9DUkdSSlczd3dDRUpTc3p4bzl4SFFkcnR3RzRM?=
 =?utf-8?B?WlVCc0w1Q2VSaG5YL3o4V1oyQ0xnL1NwWUQwWkFkNWF2dE03NkZVZnJEZFJQ?=
 =?utf-8?B?ZlVaVTJoalhUdkNWZUVqQ1BPUE9VUk0vekNJcFRxeVdJQmxFQ3p4Z1lGNmdN?=
 =?utf-8?B?Nmd5ZU9zSzZPTzVJSkNhMExWRmZBNythdmhpSUsvQ2VNOUFUa3JjWlJvNlYw?=
 =?utf-8?B?M203ZzBTMjBIbzNtNVM5eEk5ZncrMzRrREJJblRVb0I1Ri93K3BOOHhuMm9J?=
 =?utf-8?B?dHJaSTg3YjcyUEhvTE13aW41bFhmUGxGNUlTVVc1OTQ0TXNTMHJSTmVBOGdn?=
 =?utf-8?B?SExmbGxvTjd1UEtZYXNkVGVzT2VLN3UwVTBISkkrNDdjMzh6MEE1alJDbUtu?=
 =?utf-8?B?ajVMRDVBY0R3WlFxd0VIeWFMWmdBRktOOU5HUG92VkFaOHNCbHpjY1NGZWdq?=
 =?utf-8?B?bFByRk1wU29mNExrWmk0a1E5dE1HVi9mN0tteXk1QTQwOHowWE1wTEg5OThI?=
 =?utf-8?B?TlN0Y1F2ei91S3FpR1FBa0gxMGRvNzZzZHRHcXlZWnlWUUJ4TGpTZVd1VlFN?=
 =?utf-8?B?K1hvYyt4RUEyNzBzRE1KN0diRnc5M0tVaVRESCtOTU5iWk5kK1pwVXdPWk16?=
 =?utf-8?B?OU5CSzA2N3FoUDE1OEpydjBMT1RMaDIxL0ZuQnp5UWoxRVh4dG9Sa3dZaWha?=
 =?utf-8?B?eU9lYTBacE0renJ3cjNiZWZyQzRyc3NXL0JaeHhXQUxkazlXVGxIUVNZU1Yr?=
 =?utf-8?B?RHFaRVpOeUl4MTF0L1NreCt1MDNnN3pmZWExeDB1ekRaMVU4Q1pvMkhjcFdO?=
 =?utf-8?B?Ymk2bUZQN0pFU25aRm1JSU5HYm9ucGppeVk0RHo0R24wY254bGpidnU2ck8x?=
 =?utf-8?B?dkhvTlBqcGhUbkcwNUtETXh6RFBwRjY2aVlrellCcHd2Ykc3VHo1Wi9GcGox?=
 =?utf-8?B?c01McHB2NGNERm5sdFpvSm9ocnh3RUN5YjJzRGJYOGhnM3hRMmdCamdCekE4?=
 =?utf-8?B?Z2ZQdEVTRC9pem5IS05XaGtTNks5MDkxeUVyYjJxNXkrQWJsdzZWRHNEdDBn?=
 =?utf-8?B?NG5tYS9LMDRKa0ZSZ04wYW80UHNlOE5ONlpCSk15c242cUNkUFY3UGhLcVBs?=
 =?utf-8?B?Tit4b3IrdGY2S2s2L2VVRHNDQkVZRTUrWUVYOEFXTnhwZXpwRG9IdWlpOGZI?=
 =?utf-8?B?N21sUGI3dHJLOGZuQTRIYm9nRzVTQndIajV2QlBRNTZ3cCs0Q0JpSEtIUjRa?=
 =?utf-8?B?azVDVjNVN09VNHVVTFRLVzBrbHZpZGx2cE12b0NkZGZVQTAyZ1p6ekNWTDJo?=
 =?utf-8?B?bjV1ZVhEWVMwQU5ETzZKTnJ3c0hoOVVqVGsxSTB6NnRvZjRIcXJuSHhlMitm?=
 =?utf-8?B?Nk1WK2pYYjVtS2lSTDdKb0c2U2ZWVjVJemxibm5WdC9YcngvSS9zenF1R1Y4?=
 =?utf-8?B?VDdJbDY1UllIL0k0NHN6cXFRTVJVSmYvdm9JZ2V1VS8zM255ZklQdWFKbE9x?=
 =?utf-8?B?NUpIaW9Wbkl1ZmdBcTJabHRLeTZUWGV3ODBhcEw2UTliVXlKejQzWkZ4QjlZ?=
 =?utf-8?B?T3M1RzRJMmFkWUZjY1lLQ1llcnBZNXRxOEkwby82NEpDeERTOC9qd3ViU2Va?=
 =?utf-8?B?ZytYRVRFeTVPTFo0ZlZXOVJVcFlWaVlJVVpWNWQzUFVkSnYrdU1lbzZPMVIz?=
 =?utf-8?B?elcvMUdrdTRYZmV6Tk5qNCtsMmw3eWRnUzJ4NnZSeDdmemlUUkhYL3F6RXhT?=
 =?utf-8?B?Y3hBeXM2TWhYYi9tUlE1R0k0MUdiend6Y2ZSZjdveksrbm81NUZRcklsZ0hV?=
 =?utf-8?B?TjMwWmd0TU9XTFBsd2lycElHTEhqODB1Yi9yVGNRUzJsNjUwdkJDMnlseEVv?=
 =?utf-8?B?Q3RLZlJkdUF2QWJXSmZ0Vy80am9vR1UwMms3QUMyZWhVWlo0SEU5RDUrNVlF?=
 =?utf-8?B?UjZQaHhwWUZHTFY0UkUvTSswQ1krd2l3YVc0ZkNQb2JjWS80UTljTDU3cStZ?=
 =?utf-8?B?M1Z1VEpPN2RHMUdCTFA2dVN1MjFRWkdmZ09leElNby9ZSHpDNS90bG5yOHZh?=
 =?utf-8?B?MzUrL0NGanQ4c3RTeHVLVFc1TXJUeVUvZW5SbVowRHNHekJrT2F2cHZReG1T?=
 =?utf-8?Q?Jg/4UYJj1JB63SjPgh6Lho8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1486bebc-5513-4be0-1d5b-08d9b302f274
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 06:39:08.6935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rtDUcff59J7pg6L+NBWdVPx2TZvH6WfHBxQLuggghKXvUB4OnudhXqLiM2NEnac9XKm4f+iK1rdG4FWFTXRVEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5317
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KVGhhbmtzLCB3aWxsIHVwZGF0ZSBiZWZvcmUgc3Vi
bWl0Lg0KDQpSZWdhcmRzLA0KU3RhbmxleQ0KPiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWP
keS7tuS6ujogWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCj4g5Y+R6YCB
5pe26Ze0OiBNb25kYXksIE5vdmVtYmVyIDI5LCAyMDIxIDI6MzYgUE0NCj4g5pS25Lu25Lq6OiBZ
YW5nLCBTdGFubGV5IDxTdGFubGV5LllhbmdAYW1kLmNvbT47IGFtZC0NCj4gZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZzsgQ2xlbWVudHMsIEpvaG4gPEpvaG4uQ2xlbWVudHNAYW1kLmNvbT47DQo+
IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29tPg0KPiDmioTpgIE6IFlhbmcsIFN0YW5sZXkg
PFN0YW5sZXkuWWFuZ0BhbWQuY29tPg0KPiDkuLvpopg6IFJFOiBbUEFUQ0ggUmV2aWV3IDEvMV0g
ZHJtL2FtZGdwdTogYWRqdXN0IGlwIGJsb2NrIGFkZCBzZXF1ZW5jZSBvbg0KPiBhbGRlYmFyYW4N
Cj4gDQo+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHldDQo+IA0KPiBQbGVhc2UgZml4IGEgdHlwbyBp
biBjb2RlIGNvbW1lbnRzIHNtZGEtPnNkbWEuIEFuZCBkb3VibGUgY2hlY2sgdGhlIGNvZGUNCj4g
YWxpZ25tZW50IGJlZm9yZSBjb21taXQuDQo+IA0KPiBWMiBpcw0KPiANCj4gUmV2aWV3ZWQtYnk6
IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NCj4gDQo+IFJlZ2FyZHMsDQo+
IEhhd2tpbmcNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RhbmxleS5Z
YW5nIDxTdGFubGV5LllhbmdAYW1kLmNvbT4NCj4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciAyOSwg
MjAyMSAxNDoyNw0KPiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFpoYW5nLCBI
YXdraW5nDQo+IDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBDbGVtZW50cywgSm9obiA8Sm9obi5D
bGVtZW50c0BhbWQuY29tPjsNCj4gWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+DQo+IENj
OiBZYW5nLCBTdGFubGV5IDxTdGFubGV5LllhbmdAYW1kLmNvbT4NCj4gU3ViamVjdDogW1BBVENI
IFJldmlldyAxLzFdIGRybS9hbWRncHU6IGFkanVzdCBpcCBibG9jayBhZGQgc2VxdWVuY2Ugb24N
Cj4gYWxkZWJhcmFuDQo+IA0KPiBSZWFzb246DQo+IHsNCj4gICAgIFsgIDU3OC4wMTk5ODZdIGFt
ZGdwdSAwMDAwOjIzOjAwLjA6IGFtZGdwdTogR1BVIHJlc2V0IGJlZ2luIQ0KPiAgICAgWyAgNTgz
LjI0NTU2Nl0gYW1kZ3B1IDAwMDA6MjM6MDAuMDogYW1kZ3B1OiBGYWlsZWQgdG8gZGlzYWJsZSBz
bXUNCj4gZmVhdHVyZXMuDQo+ICAgICBbICA1ODMuMjQ1NjIxXSBhbWRncHUgMDAwMDoyMzowMC4w
OiBhbWRncHU6IEZhaWwgdG8gZGlzYWJsZSBkcG0gZmVhdHVyZXMhDQo+ICAgICBbICA1ODMuMjQ1
NjM5XSBbZHJtOmFtZGdwdV9kZXZpY2VfaXBfc3VzcGVuZF9waGFzZTIgW2FtZGdwdV1dDQo+ICpF
UlJPUiogc3VzcGVuZCBvZiBJUCBibG9jayA8c211PiBmYWlsZWQgLTYyDQo+ICAgICBbICA1ODMu
MjQ4NTA0XSBbZHJtXSBmcmVlIFBTUCBUTVIgYnVmZmVyIH0gQWRqdXN0IGlwIGJsb2NrIHN1c3Bl
bmQNCj4gc2VxdWVuY2Ugb24gYWxkZWJhcmFuLCBpdCBjYW4gZml4IGRpc2FibGUgc211IGZlYXR1
cmUgZmFpbHVyZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFN0YW5sZXkuWWFuZyA8U3RhbmxleS5Z
YW5nQGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2Rpc2NvdmVyeS5jIHwgMTAgKysrKysrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMNCj4gaW5kZXggNGUzNjY5NDA3NTE4Li5kYzFkODhh
MzFmOTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
aXNjb3ZlcnkuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlz
Y292ZXJ5LmMNCj4gQEAgLTEzMDksNyArMTMwOSw5IEBAIGludCBhbWRncHVfZGlzY292ZXJ5X3Nl
dF9pcF9ibG9ja3Moc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAJCX0NCj4gIAl9
DQo+IA0KPiAtCWlmIChsaWtlbHkoYWRldi0+ZmlybXdhcmUubG9hZF90eXBlID09IEFNREdQVV9G
V19MT0FEX1BTUCkpIHsNCj4gKwkvKiBtb3ZlIGFkZCBzbXUgYmxvY2sgYWZ0ZXIgYWRkIHNtZGEg
YmxvY2sgZm9yIGFsZGViYXJhbiAqLw0KPiArCWlmIChsaWtlbHkoYWRldi0+ZmlybXdhcmUubG9h
ZF90eXBlID09IEFNREdQVV9GV19MT0FEX1BTUCkNCj4gJiYNCj4gKwkJCShhZGV2LT5pcF92ZXJz
aW9uc1tNUDFfSFdJUF1bMF0gIT0NCj4gSVBfVkVSU0lPTigxMywgMCAsMikpKSB7DQo+ICAJCXIg
PSBhbWRncHVfZGlzY292ZXJ5X3NldF9zbXVfaXBfYmxvY2tzKGFkZXYpOw0KPiAgCQlpZiAocikN
Cj4gIAkJCXJldHVybiByOw0KPiBAQCAtMTMyNyw4ICsxMzI5LDEwIEBAIGludCBhbWRncHVfZGlz
Y292ZXJ5X3NldF9pcF9ibG9ja3Moc3RydWN0DQo+IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAJ
aWYgKHIpDQo+ICAJCXJldHVybiByOw0KPiANCj4gLQlpZiAoYWRldi0+ZmlybXdhcmUubG9hZF90
eXBlID09IEFNREdQVV9GV19MT0FEX0RJUkVDVCAmJg0KPiAtCSAgICAhYW1kZ3B1X3NyaW92X3Zm
KGFkZXYpKSB7DQo+ICsJaWYgKChhZGV2LT5maXJtd2FyZS5sb2FkX3R5cGUgPT0gQU1ER1BVX0ZX
X0xPQURfRElSRUNUICYmDQo+ICsJICAgICFhbWRncHVfc3Jpb3ZfdmYoYWRldikpIHx8DQo+ICsJ
CSgoYWRldi0+aXBfdmVyc2lvbnNbTVAxX0hXSVBdWzBdID09IElQX1ZFUlNJT04oMTMsIDAgLDIp
KQ0KPiAmJg0KPiArCQkgbGlrZWx5KGFkZXYtPmZpcm13YXJlLmxvYWRfdHlwZSA9PQ0KPiBBTURH
UFVfRldfTE9BRF9QU1ApKSkgew0KPiAgCQlyID0gYW1kZ3B1X2Rpc2NvdmVyeV9zZXRfc211X2lw
X2Jsb2NrcyhhZGV2KTsNCj4gIAkJaWYgKHIpDQo+ICAJCQlyZXR1cm4gcjsNCj4gLS0NCj4gMi4x
Ny4xDQo=

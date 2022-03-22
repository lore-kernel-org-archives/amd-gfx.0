Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92B7C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Mar 2022 03:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DC0810E500;
	Tue, 22 Mar 2022 03:17:35 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2051.outbound.protection.outlook.com [40.107.96.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDE4110E500
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Mar 2022 03:17:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBk5qPi2w7bJUKWQMYsbWlWxc9c6HBymvF9sNu03Jko1jTNqUPFsZDhdmi0Sn5Fh3CsFY2EToQVTI8R2qmMyKyc/M63DrXg6Rcc46dzRbqeodl1f4k2c/lcktCB18PzlaIjhMsyi3pfVV8foz2GsU/4MWSNJSs5NWSzBJMAvDImswZKJc4c+y15CpxC28hav/xBNjncihG/AEB4s/sSjuLQ1qlG1MgufoI00ZN5+XxhKFeYTRRRHFpaNrLqINN5maEpzPoPdBIahrkNV/oV0UoJD3Sy85VbLbcYs+ZMO1aSk1HZWEtF1t4iXBRTOPDmOBJIwGr+PiT6Epdk5lbQ8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+DX5ONDRt03rllqyr0QtKjnmPfXwcS3mljlbgXGw04=;
 b=OCoHuNoYlnnbwxxF+P+hgLgFuPgeJMQxqID4tGbOZ+n88SLpBhPJ1yM/Vv7p5nq42da+to+68LRR7EoIjkMXOJktQaTVQng9QLyFMODNMP24UcC/N3f+OHhztaSVTQkoQbr2StRGFNpSiT/tdDFr2ZlWjtiXjM3rBBdmw+3RT2VxQYPo3xarpQj6s0g05crS7CJu+izFradxrwAkcNPNexys5j99a4hfKXipaGQn01Uvs7erxDXdrZoZ7jeVlNEchccwPtN8dZL530Qn0rVUj8BjQn4be9yu2IndNnF/lek8QYmq7/dLQJl3cuR7/lQs4h9EFkGJro5cIh/1UtWHDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+DX5ONDRt03rllqyr0QtKjnmPfXwcS3mljlbgXGw04=;
 b=vYFyWm59XcDINhf1DWC2f0Dxz14wAbMNj1gjqmQiwYRnMDyqBUe5GzoHab5vxR8jeuI+d7P6hceu4jGAIzoMTvxJjyLiM78SKIfsrJ0XlwHoBb2BWuQPfjeDhTX9Ao07ynTJrjn3+PAiF+rWO+fTivxaAySyXeHRtmeI7x96xrc=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by CH0PR12MB5203.namprd12.prod.outlook.com (2603:10b6:610:ba::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Tue, 22 Mar
 2022 03:17:32 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.5081.019; Tue, 22 Mar 2022
 03:17:32 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdkfd: print unmap queue status for RAS poison
 consumption (v2)
Thread-Topic: [PATCH] drm/amdkfd: print unmap queue status for RAS poison
 consumption (v2)
Thread-Index: AQHYPQduuVaBtZt7+kyIHY5y8KDziqzJsY4AgAEJbtA=
Date: Tue, 22 Mar 2022 03:17:31 +0000
Message-ID: <DM5PR12MB17706EFCD71EA2F4DAE3264CB0179@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220321093818.24270-1-tao.zhou1@amd.com>
 <25fe0aa1-aec0-4dc1-0238-24dc496f3528@amd.com>
In-Reply-To: <25fe0aa1-aec0-4dc1-0238-24dc496f3528@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-22T03:11:29Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1e3ac7bc-0ab6-4f04-baaa-a17a803f7abf;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-22T03:17:28Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: d19741a8-5085-4bf3-a9df-464036afb1b3
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01747013-baf8-41cc-085a-08da0bb280d7
x-ms-traffictypediagnostic: CH0PR12MB5203:EE_
x-microsoft-antispam-prvs: <CH0PR12MB5203FA89C4FEA4037F16A20AB0179@CH0PR12MB5203.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eSCqEkVJUeZDnhCZQuuKRs1a4rKT8FHJMLdbRCXeVe2qPESp+UmeQZM1s4Hogklcq6xBf8unC6J3BZPbBo79ytbfqBLCXP6M8HAtfwwPXTdsKFAkYxlBUHAhi+GyMat3+iO7iclWnpeeQ54+uI5u1FZqLw4rsdy8+hXngJ3dsThCJxtoF8lbZeshh8GXwoS4KcUiEOl37uHZRYlu2384zJ7Lirz0KWyYAjDZ6B46A49WcoHD1o/v+hOJlKn3PusJSh/OSujpZgMjbSEXaaX/18ltxC0z7gq2DVy4ReZLUZ309kHhzpHK+x3OeClvbl8Wrk+PgDIRSE+RAZjryZJQMFim0pO/YIF7jlDTOCVZy2qmm+QQ5ept5kBdbC66g7Stgx7w3HcQCGXbI/bvZQqwMgsdfKeMkwSSffUYKxUgOqmfVufbQVT7cM52KXJEFDEfEuadu7IxQAwJEv6ELhrDHMGE9ZLbDfQldZUFNvVQwpUpK1vM+zXAD279GugFk+So2cbm4u8K2ccBys3GM0n6XhklcksgmDWG/NwGQLTjX53OckFpLAZ+f/HKhT7Q7i9yeH8jBYS13Uk4TmTAbk4gyM/rU5mVXvJfqix/CxeI8jmgtajWlQMopzsq96LVJ8DOVQflTy2AyAZ4u2qO4M2+MuJVIB/kOuposeVCAmm/ZWzF8N5h9AUccRxEmtxsb87HiOMlvXaLa4zyscfq/3gsQYIo2fQLSLDUL0wnI6/pBxE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(53546011)(86362001)(8936002)(7696005)(64756008)(6506007)(66946007)(66476007)(66556008)(66446008)(83380400001)(55016003)(71200400001)(52536014)(38070700005)(2906002)(9686003)(508600001)(26005)(186003)(110136005)(6636002)(8676002)(76116006)(122000001)(38100700002)(33656002)(921005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHUyd1RLd0FlZjZPSFcrS1RHNTl1ajdJN20wR2VQV1ZTckk4SndDTVBDbWNa?=
 =?utf-8?B?Qmg2OGptMGltNzN2WjlCMGxBMGdTUEYydE1TWmw4R3ZoNm1iRURBalpuSTlI?=
 =?utf-8?B?Y2NQVm5iVmJVUDNRYk5ZdE9SVm0vY0lKcWpyYjUzbWZiM1RYa3VESkZTd25C?=
 =?utf-8?B?T2NpbndWUDZpL3JrTXFBeWhCbkZuMGJtK05tcVp1dGxhUGJRTGgyUXQ1bFJp?=
 =?utf-8?B?cTRSaTA1SEpFOFlnUmZMcnhaNGhHSWFYVllFbVB4SGVoVGdCcGRVUkYzNTUy?=
 =?utf-8?B?VURmVkg5bkdqQzJiWHlnb3lPZWJ3Rzh1L2oyckRKTU8vYkxDTTNqK1N3WnhV?=
 =?utf-8?B?bUU2aUhyMGtiRFRvWHZLYzRhVkgxdVNNODNJUStadmI4OUt5NGplUzVGK1I4?=
 =?utf-8?B?ZlIxdkQrNWptZDk5UmxIOS92QjNveW16aG5pNlZEdWVDc3FOQ3dEL2J4NGkr?=
 =?utf-8?B?dzk4ZTk1WEJQbzIveTdYUHBicStES29ZMHc4Z2ljYk5BWGtUSkdJU3lUV2Rs?=
 =?utf-8?B?akM5Zzl3ZHNmVWl5WWhySy9saUFOUUdyYkhhdDVMRzhVZ3hTQm16dDBGcEVW?=
 =?utf-8?B?c0Q2azg2NHptZHNqRzRKS3V0U2dPZElRTEtBN2gyajZMNkRsR0pISUdjRGl1?=
 =?utf-8?B?bnJVU1EvMVE3Y3pkbC9ucytrZlgwMml5ZEF5Z2YrVWRiQ1RwN0tIeklmNktY?=
 =?utf-8?B?cXQ2ZGVrbUIzY0tNaWJpTlpKVWhRYngwYnN5cm02YW1Tc3pxcEo2VXh1Uzlv?=
 =?utf-8?B?R2I1OVlXa3BvR1FlaG1NZER2MW5ocGdhcnJva2EwOHR4dTBhYmlWL2dvRElK?=
 =?utf-8?B?d244TG5zbWd4RDV5azVVQWQ0RDJkM3Z0Ykx0NGtBai9tbzZGdTBCZGhEdXhG?=
 =?utf-8?B?U2xHQTlmaDkrMTdEYkQ4cHJpRFdpUFZvZzhmUHgvQ0NnVWtPaEt2aTlqdkpN?=
 =?utf-8?B?TFlvMFNGNmNYK04zcm9XR0M5UmxqZndEczdFVTFJTDRsSU1SRDZvR0F6MFE0?=
 =?utf-8?B?UjB6cHdXOVRXUlBoY040b3gxRlpveWJHVEsrM01oaWpRVjJ6Y0ZsSzQ3a05Y?=
 =?utf-8?B?SnN2WmVyTml1Q1NLMlNlZnVZTDVBMjEwbW9jNHhaWGpCdlJJTG5qS2lIRWJv?=
 =?utf-8?B?TmF2VHFEdDIwL1V2UGxxQ0EvV1pGZ3ZUdWx6Y3BLbHU2d2x3Y1BlaWtlN1J6?=
 =?utf-8?B?aUxEaHhWdXBqeFdSOCsrbThvU2pFV3J0MEFUWW8zeWR2Uzhtb1BWNmpWbjVP?=
 =?utf-8?B?ZlVwcy8wTzdpQnJUckY1STZQY2paVm4reFBhVmpheVlYLzc4bllxMk8rVERG?=
 =?utf-8?B?YXJ3UnozSzZtSkMrVzVmaGd6MVkzVW1DQjBiKzEwRk91bGs0LzF6cFlmZzFX?=
 =?utf-8?B?d3VxOW55bkZQNzNUbHlUVmdQL0Y2bUt5RkFMMk1pMlVuSkt6STV2RTY5TW9i?=
 =?utf-8?B?ZDdwN2VORlVJcFNPQnlpNFFTd0hYKy9SYXZHUklEK3FtenhzOU1yVUg0Y3c1?=
 =?utf-8?B?ZE1RaU0zaUZ0MW45WXVCK3AybjdOcFpveG14SkxnRFZOY1JjTzFSNmswNzRx?=
 =?utf-8?B?VUNnRm4zR2xDblBlYTRKOG96L2xiVitnUEtodFFvdUFXaHVvL0xWNmpnTEtz?=
 =?utf-8?B?NVNzVXQvUS9MSVJuM0hzbmY4eFl1dzJlejJEbEIzS2V6OW9yaUI2NEJVckw0?=
 =?utf-8?B?akdIR0xsSVpnUHJ0UUlQMkttV2pUS2V1Z0VPWnlMamJ4WXQ0MTVyU1pLZjNJ?=
 =?utf-8?B?V0xmYzgrRGRvME1BSWhFN2Y0YWxRWjNQTVRxalNBT0dKc1RaRFNhc3Q1MDVr?=
 =?utf-8?B?TW5mVmxibXcvUUxaYUFTNkJnZEVCMWtPTDNyQ1BkUDJ4V2RyWWc2aVNCamZX?=
 =?utf-8?B?U1FGOU13SWtPTTFoOEZ2RXRqMkNodVpGWnFwV2JnaG8yVUNwWHBQNlZlc2Er?=
 =?utf-8?Q?eQY58yaj8zfc9mUeG/KKWzi24NUmXe/v?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01747013-baf8-41cc-085a-08da0bb280d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 03:17:31.7819 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VQHdAObLaJgu+M/zu5TW6TM+3L29JPaCi+NbbxF0eLqeHpnJ0Jqx3EUQklaq2Ppr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5203
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBNYXJjaCAyMSwgMjAyMiA3OjIxIFBNDQo+IFRvOiBaaG91MSwgVGFvIDxUYW8uWmhvdTFA
YW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBaaGFuZywNCj4gSGF3a2lu
ZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgS3VlaGxpbmcsIEZlbGl4DQo+IDxGZWxpeC5LdWVo
bGluZ0BhbWQuY29tPjsgWWFuZywgU3RhbmxleSA8U3RhbmxleS5ZYW5nQGFtZC5jb20+OyBDaGFp
LA0KPiBUaG9tYXMgPFlpUGVuZy5DaGFpQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IGRybS9hbWRrZmQ6IHByaW50IHVubWFwIHF1ZXVlIHN0YXR1cyBmb3IgUkFTIHBvaXNvbg0KPiBj
b25zdW1wdGlvbiAodjIpDQo+IA0KPiANCj4gDQo+IE9uIDMvMjEvMjAyMiAzOjA4IFBNLCBUYW8g
WmhvdSB3cm90ZToNCj4gPiBQcmludCB0aGUgc3RhdHVzIG91dCB3aGVuIGl0IHBhc3NlcywgYW5k
IGFsc28gdGVsbCB1c2VyIGdwdSByZXNldCBpcw0KPiA+IHRyaWdnZXJlZCB3aGVuIHdlIGZhbGxi
YWNrIHRvIGxlZ2FjeSB3YXkuDQo+ID4NCj4gPiB2MjogbWFrZSB0aGUgbWVzc2FnZSBtb3JlIGV4
cGxpY2l0bHkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUYW8gWmhvdSA8dGFvLnpob3UxQGFt
ZC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfaW50
X3Byb2Nlc3NfdjkuYyB8IDExICsrKysrKystLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNyBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9pbnRfcHJvY2Vzc192OS5jDQo+ID4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfaW50X3Byb2Nlc3NfdjkuYw0KPiA+IGluZGV4IDU2OTAy
YjViYjdiNi4uMzJjNDUxZjIxZGI3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9pbnRfcHJvY2Vzc192OS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX2ludF9wcm9jZXNzX3Y5LmMNCj4gPiBAQCAtMTA1LDggKzEwNSw2IEBA
IHN0YXRpYyB2b2lkDQo+IGV2ZW50X2ludGVycnVwdF9wb2lzb25fY29uc3VtcHRpb24oc3RydWN0
IGtmZF9kZXYgKmRldiwNCj4gPiAgIAlpZiAob2xkX3BvaXNvbikNCj4gPiAgIAkJcmV0dXJuOw0K
PiA+DQo+ID4gLQlwcl93YXJuKCJSQVMgcG9pc29uIGNvbnN1bXB0aW9uIGhhbmRsaW5nOiBjbGll
bnQgaWQgJWRcbiIsIGNsaWVudF9pZCk7DQo+ID4gLQ0KPiA+ICAgCXN3aXRjaCAoY2xpZW50X2lk
KSB7DQo+ID4gICAJY2FzZSBTT0MxNV9JSF9DTElFTlRJRF9TRTBTSDoNCj4gPiAgIAljYXNlIFNP
QzE1X0lIX0NMSUVOVElEX1NFMVNIOg0KPiA+IEBAIC0xMzAsMTAgKzEyOCwxNSBAQCBzdGF0aWMg
dm9pZA0KPiBldmVudF9pbnRlcnJ1cHRfcG9pc29uX2NvbnN1bXB0aW9uKHN0cnVjdCBrZmRfZGV2
ICpkZXYsDQo+ID4gICAJLyogcmVzZXR0aW5nIHF1ZXVlIHBhc3NlcywgZG8gcGFnZSByZXRpcmVt
ZW50IHdpdGhvdXQgZ3B1IHJlc2V0DQo+ID4gICAJICogcmVzZXR0aW5nIHF1ZXVlIGZhaWxzLCBm
YWxsYmFjayB0byBncHUgcmVzZXQgc29sdXRpb24NCj4gPiAgIAkgKi8NCj4gPiAtCWlmICghcmV0
KQ0KPiA+ICsJaWYgKCFyZXQpIHsNCj4gPiArCQlwcl93YXJuKCJSQVMgcG9pc29uIGNvbnN1bXB0
aW9uLCB1bm1hcCBxdWV1ZSBmbG93IHN1Y2NlZWRzOg0KPiBjbGllbnQgaWQgJWRcbiIsDQo+ID4g
KwkJCQljbGllbnRfaWQpOw0KPiANCj4gQXMgZGlzY3Vzc2VkIGluIGFub3RoZXIgcGF0Y2gsIEkg
dW5kZXJzdGFuZCB0aGF0IHByXyogaXMgdGhlIGxlZ2FjeSB1c2FnZSBpbiB0aGUNCj4gZmlsZS4g
QnV0IGl0IHdvbid0IGJlIGhlbHBmdWwgZm9yIHRoaXMgY2FzZSB3aXRoIG11bHRpcGxlIGRldmlj
ZXMuIFdvdWxkIHN1Z2dlc3QgdG8NCj4gY2hhbmdlIHRvIGRldl9pbmZvKCkgLSB0aGUgbWVzc2Fn
ZSBoZXJlIGFuZCBiZWxvdyBzZWVtcyBpbmZvcm1hdGlvbmFsIGFib3V0DQo+IHRoZSBoYW5kbGlu
ZyBvZiB0aGlzIHNpdHVhdGlvbiByYXRoZXIgdGhhbiB3YXJuaW5nIG9mIHNvbWV0aGluZyBiYWQu
DQo+IA0KPiBUaGFua3MsDQo+IExpam8NCg0KW1Rhb10gSSdsbCByZXBsYWNlIHByX3dhcm4gd2l0
aCBkZXZfaW5mby4gSSB0aGluayB3ZSBuZWVkIGEgZGVkaWNhdGVkIGNsZWFudXAgdG8gcmV0aXJl
IGFsbCBwciBmb3JtYXQgbWVzc2FnZSBpbiBhbWRncHUuDQpSQVMgcG9pc29uIGNvbnN1bXB0aW9u
IGlzIGEgc3BlY2lhbCBldmVudCBzaG91bGQgYmUgcGFpZCBhdHRlbnRpb24gdG8sIEkgdGhpbmsg
YSB3YW5pbmcgaXMgYWxzbyByZWFzb25hYmxlLg0KDQo+IA0KPiA+ICAgCQlhbWRncHVfYW1ka2Zk
X3Jhc19wb2lzb25fY29uc3VtcHRpb25faGFuZGxlcihkZXYtPmFkZXYsDQo+IGZhbHNlKTsNCj4g
PiAtCWVsc2UNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJcHJfd2FybigiUkFTIHBvaXNvbiBjb25z
dW1wdGlvbiwgZmFsbGJhY2sgdG8gZ3B1IHJlc2V0IGZsb3c6DQo+IGNsaWVudCBpZCAlZFxuIiwN
Cj4gPiArCQkJCWNsaWVudF9pZCk7DQo+ID4gICAJCWFtZGdwdV9hbWRrZmRfcmFzX3BvaXNvbl9j
b25zdW1wdGlvbl9oYW5kbGVyKGRldi0+YWRldiwNCj4gdHJ1ZSk7DQo+ID4gKwl9DQo+ID4gICB9
DQo+ID4NCj4gPiAgIHN0YXRpYyBib29sIGV2ZW50X2ludGVycnVwdF9pc3Jfdjkoc3RydWN0IGtm
ZF9kZXYgKmRldiwNCj4gPg0K

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC094C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 16:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EE3710E170;
	Fri, 10 Dec 2021 16:12:20 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C581D10E170
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 16:12:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaUzMwOzukLQFeQirp1VIhV/cfRq283Pgx2V/erWL1F+vFVjQ/2FQof/hHKNuy8ZGpcdNwZ62eusuXBcSJ9OuXQpbHy01/Gj3nZ7+HHhcUsU3NqX1wTGmSQfmBKK2h4VPFnzpxFTnaS4NcKqUkpH45NvXZFIfBDSFynoMNMUpJxUbGj1Q+gZO3QZjPtX02/Md/x9Bies5ltXHV/XnBYsGY8WvK/mklpwqfxdcERzEef/hO4EfyDWfgeZTIJ4oAn6o80XuzY6vEjSD5qNp9/g9B0iYnfILkGXOd/n0Xaa/WetccNk2gBJ6Zl/PBJbvJ6IlRX/Oltpj/mGcu7qCqz4sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7LLM7qpu66RjwaM7AHUQ9l7LeVOFT7OEAZffwuej/A=;
 b=gSgY9QP/2w3tB7sJ+GJ5PojStshDzMBZy91xXPw2OOXoe6x00L6lyj7S6vYBSbSQ0U31vbvs9H74jus8IA3sIwTTyPBgO78gmEsQSs+nWLLPnGERKgAvnM++aoTZDsEHJ8iO2bqpBrkqGe/QZ8U8F85OOdkGxvS1Bz8vkEM2CvHnKKFbrQKWN3wX4HQO27LKSmZte0uWa/8ScksZtMgwsHIaMRxP5b6lcE6gMEbB9dMPEN5ghp9RK36XYUlxWxYIfqXa76Ulsb3vuYiHZmWUkYeWQAy23mMoewJmM3bkjY+YcP6cvxCT1XVv4IMvtJwAb9WtbHLhyKGvovCfG/Lbvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7LLM7qpu66RjwaM7AHUQ9l7LeVOFT7OEAZffwuej/A=;
 b=lBzzXgHYbXrRTbPBgm7LGP/0GCBssv5Dt/V0zCd3aHtB7qH9dxl5mJjb7xZ3yyE+0tGZ61RZmL0Uy1FwJKg31TXmfUKNNbU7gw9GV1J3L2loXTwarw9/zaP+L5Ba1ViYtehvPXI2r/Z1cmeI2gzNXoGWoiNLAruUa4Mahpbexu4=
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SA0PR12MB4559.namprd12.prod.outlook.com (2603:10b6:806:9e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.24; Fri, 10 Dec
 2021 16:12:16 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9481:9017:a6a:3028]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9481:9017:a6a:3028%8]) with mapi id 15.20.4755.025; Fri, 10 Dec 2021
 16:12:16 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd: move variable to local scope
Thread-Topic: [PATCH 2/2] drm/amd: move variable to local scope
Thread-Index: AQHX7d4/NXLhWqY1jk+sICtPGIuwJqwr5EMAgAABIJA=
Date: Fri, 10 Dec 2021 16:12:16 +0000
Message-ID: <SA0PR12MB45107A250FB6E68EAAE81428E2719@SA0PR12MB4510.namprd12.prod.outlook.com>
References: <20211210155415.11867-1-mario.limonciello@amd.com>
 <20211210155415.11867-2-mario.limonciello@amd.com>
 <05231ce9-0c8d-509c-f5dc-27a972739501@amd.com>
In-Reply-To: <05231ce9-0c8d-509c-f5dc-27a972739501@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-10T16:12:14Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=ba756dd0-59f1-49a9-ac45-b365273281e9;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-10T16:12:14Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 67d806a3-0300-426f-9251-3993f80e086a
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3b3fda8-b6bf-4a04-5ac1-08d9bbf7d5cc
x-ms-traffictypediagnostic: SA0PR12MB4559:EE_
x-microsoft-antispam-prvs: <SA0PR12MB45599C246FE0567091E7DCC1E2719@SA0PR12MB4559.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tDZO7ympi0tfbGm0NFuD4N+m+S3vE7r3l7r5Zx0HD0IRz2TZx4yO6GqMxxSw2cBBYZom5zkLwtZLJzh24ARWg+yeTXH3pguupcWaKo7U4SMFXoEkFUOKJysSpYcjLUZcNoFakVWJDv9ezTBF0a+8rKKdkmSUEiXMKxzDAUxm1TD0nyHjcQDgN2HyfUX2ZhxMQ11uDppVsNFEE98XVUEoChS2A0TQm4XlutjLlzbO8zH4WdnYs3y3nhpLI64Q7O62XSDRVwY19sOnS3A/vLG24Ir7siwxRvS5r4LARJJXT0s1u0LjLm+ycOxhoQaF8kXfX5AQiE4HT6m5PJGwc7IipLorCyPMyBIYMwS2U4CgQ+As/uKWl+vRsMNGUWjDTZAN7ZZmaIWAxPpxDjnHhB00AvkrVgL2uoEJlsJSkzSeex3oIGcO/CiPHzboD0oRbrg+TYp+TwISwExgv0dLGRRyDH/rrZK7+KrW7YM18ryhJoJ6+HT3S8b1XfKI3u0f95mnD1mAHPT/e8N+ZWcHRIIjX4fl4MCdwix2K3rYGfj5+kMJPtsbm5teIXRRMxTFRzpH9Uud+zWfKdupKH/hf7KEnoPougYH3Brk+p58/L8ZI5v8pk6J//HnTbZbPpYnCFqSw/tk6jxJCn+wn2YBeYP/8GNQJai9hjKzeS6MugknPEvmJDMJXcm5jJyibEdtaXhNeYp+VMLqq7imOl915jwNOQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4510.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(66556008)(66476007)(38070700005)(86362001)(186003)(316002)(64756008)(66946007)(8676002)(33656002)(55016003)(9686003)(7696005)(508600001)(66446008)(53546011)(2906002)(8936002)(71200400001)(83380400001)(52536014)(5660300002)(6506007)(38100700002)(122000001)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1BjNGxzdXVyQ0xMQUx0Mks3RU4ydzUzREFGbmcvb2pqR0t3YWsxSkI5dWwr?=
 =?utf-8?B?REc4ZHY2ZDcreUplU3JBYTdzZnVZM1Vua0pnUUZuZ3BRcU90STNDTkE1OTV5?=
 =?utf-8?B?aDdmazNuUmplRGxhZVM1bElYUWRyNmRjUURUY3oxWm0zWlZwQkhMRUpDNmJk?=
 =?utf-8?B?VlN1WExySCtvVzc4UytOb3RWejA4MDcyK3RrNFJIVVRKQ2x0OG1wUU1SQjR0?=
 =?utf-8?B?amFLQnFteWU5aGRET2M4cFF6cURublFYajYrdjNSc2w5aWVEOXF1Uk93NlNo?=
 =?utf-8?B?cnNCTDRGRGdaWHlpY1JXTGdUNjNSZmdaWEZpRmIrRjZpbGdMaUdqMGNWR3hL?=
 =?utf-8?B?MUdQMmtYRlZwYmtxSS9DMFVoMFhHZzVvblE5a0JNUnRSTU5pbEpCckpWNlFq?=
 =?utf-8?B?N2dDRWQzcTl5QjRlYk9jcXNmQVowVHFESEFFVjZOWHd4UFhPZ3djSCtJazN1?=
 =?utf-8?B?dVRVQ2tWTEtFeXloTDlGL1RGbm1QWFJTY0VOZDcveVNQbVJkU05sZXNpZ1BB?=
 =?utf-8?B?TytmejBadGRzVENYRUYycmtUNlFNQzhaeVc4bFhpdGgxMGs3dFAxZnMvUTNF?=
 =?utf-8?B?bVBXTm1lbWZuRHhEV2trZGh3QUVZQmxCOVU3a1ZFOFd5Zmh1OEQ3M1FmTW5Y?=
 =?utf-8?B?WmJ3UVNVM2xzcDBkNGxxcGYvMWhlWk1MWFZzQWhnS3VSYVRiMVRpUEd4SWtV?=
 =?utf-8?B?VzBPR1NkRWtwcS9JcGVldEEvdE5Eb01pVTMyc1g5UFl5SXJqdFpMMEYxTHFN?=
 =?utf-8?B?akdDb2MzREplS204VzRsODNYR2ZtV05qV0tzWWcyaWt1KzlJcEY5SitmMXE5?=
 =?utf-8?B?TkJMUlNReWZhK0piYzZSWUJmZFUvTElVMm84WENDZjVoRFd3VVhZRHBCR0Rh?=
 =?utf-8?B?TmkvcHBWNG1qQmhnN2toYTRtZHFpRm1GMVM1SHdyalJ1blRSL1YrU2YrWHEy?=
 =?utf-8?B?cnU1NGR6SEFidFFVcnBGUWYybmNrT3lpdysrSnBxd0VnbjYrUUhKbTVGSUt5?=
 =?utf-8?B?SjdPRTZhSzl4aHloRk12d2orQ2VCd2hueVduSGZEVEYzaldwekE3RVNhbjJu?=
 =?utf-8?B?MEZ2WUJWK0ZVdkJUNWxQMmgvSDJKcGs5a25BU0ZhK0wzeW8rb0Y2Z3RwTWZs?=
 =?utf-8?B?OWt5Q0VqamlSRVZaWGc5SHVZVG9qeU1OMWR3cDMvZ2tBUTVCUGlKTlliRmJ1?=
 =?utf-8?B?NVJKQThieThEMDl6aFdheExXV3pmVThSbUY5NzQ4dzA0Q1BzUGF6dHhId3k5?=
 =?utf-8?B?V1I3bHRVYmxOUlBqVmFoeVBTT0kwcHU0My9HUWphSDVMMWZ2UU1TNVRKK2lH?=
 =?utf-8?B?bXovWVN0cmxTeXF4ZGlVRElGejNpNENWY0QxU0FUWXNuZStJTm9xKys3dTlN?=
 =?utf-8?B?RFVZdGMxOHliTHVmVTFYRVZyazU2YTAxSW1hNTNTSkY4dVNuRzEwUFJsaVo0?=
 =?utf-8?B?RUVTaW03MzE1clFSRDgyNEhHa1lVd1FQZG43UmoxTTEwNURDajl1VS9KLzBk?=
 =?utf-8?B?d1F5QmJGYzIzZmJ4cjFHUEtURU5SMzBGeitwNktWMFlKK2JGM3hRSUwvY2ww?=
 =?utf-8?B?U0IwN2JWb0k2MXBha0RRcUpsKzJ0ZnRXNXZONzVnNEY3d2Qya0FYZzZ3TFVP?=
 =?utf-8?B?QnQydllTVlQrV0tIcnJ6TkRZcFg0aVUzOWdGV3JuWEpsS29LOG8zN3JsWXNs?=
 =?utf-8?B?YlVqU0t6Y1JSdnpxZVlJRTNUbkNOdjZWUHY1cm5pZThobzdrUTFEYmRTczln?=
 =?utf-8?B?U2luZlA4VHBXNjV4VitwUFBNRkZDSk9DbnpYUGxWQ2JBaWExbk9teDVKL1RJ?=
 =?utf-8?B?cnIxSFIyNHRqd3kxNmd5enA1a2d0MndkVFltWTN5dVdicWUzcURuTEwrVmFj?=
 =?utf-8?B?WUNUam0wQjZGbkRDZlBQU0UvckU3U3k3Zm9XalZ1cXNHMEpwQlZrZkRzYmRH?=
 =?utf-8?B?Y2xjQjZEUUd4R29TZUI0MHpLdjFWcXRxdUV4ckVUc1pPbXloZFV3cy85dHNm?=
 =?utf-8?B?ZXhjY2IxQnc3L2dUTUxCY1poNUkrT3NOSDFFSzB2SEN0cEp1cGFFUjBmaGhN?=
 =?utf-8?B?RVl4eGVJdkhmaUMyaFFhU211SkY4NVFxaW54S01ycGNybnVKVlFvelRBRURx?=
 =?utf-8?B?OGZmNTVjcVFmZG5md2RhcjlJWUtVZGNvQllzQkd6UCsxSHVySXBkdnpBQVBD?=
 =?utf-8?B?UzRVSUJPd0pQa25pb1dqMEJRVUErTTVqZFNyQlo1Ymx6cTMyenQ5QnV0OU0y?=
 =?utf-8?B?aGE2MkxrL0g3bTlmdUJ2YXY5Ykt3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b3fda8-b6bf-4a04-5ac1-08d9bbf7d5cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 16:12:16.6398 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XCttO1jwhW2KSrx3M4ULTelTz2DyATTqykWmiQJeoJb5WnGYG7cMQsksfleN4xRzbgQTOTdRc5Tv7h36RUqIlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4559
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seV0NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBT
ZW50OiBGcmlkYXksIERlY2VtYmVyIDEwLCAyMDIxIDEwOjA3DQo+IFRvOiBMaW1vbmNpZWxsbywg
TWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGRybS9hbWQ6IG1vdmUgdmFy
aWFibGUgdG8gbG9jYWwgc2NvcGUNCj4gDQo+IA0KPiANCj4gQW0gMTAuMTIuMjEgdW0gMTY6NTQg
c2NocmllYiBNYXJpbyBMaW1vbmNpZWxsbzoNCj4gPiBgZWRwX3N0cmVhbWAgaXMgb25seSB1c2Vk
IHdoZW4gYmFja2VuZCBpcyBlbmFibGVkIG9uIGVEUCwgZG9uJ3QNCj4gPiBkZWNsYXJlIHRoZSB2
YXJpYWJsZSBvdXRzaWRlIHRoYXQgc2NvcGUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJp
byBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX2h3X3NlcXVlbmNl
ci5jIHwgMyArLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZGNlMTEwL2RjZTExMF9od19zZXF1ZW5jZXIuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX2h3X3NlcXVlbmNlci5jDQo+ID4gaW5kZXggMGQ2
ZGMzMjlkZGRiLi5mYjU3OGIzMTFiOTggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjZTExMC9kY2UxMTBfaHdfc2VxdWVuY2VyLmMNCj4gPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9od19zZXF1ZW5jZXIu
Yw0KPiA+IEBAIC0xNzk4LDcgKzE3OTgsNiBAQCB2b2lkIGRjZTExMF9lbmFibGVfYWNjZWxlcmF0
ZWRfbW9kZShzdHJ1Y3QgZGMNCj4gKmRjLCBzdHJ1Y3QgZGNfc3RhdGUgKmNvbnRleHQpDQo+ID4g
ICAJc3RydWN0IGRjX3N0cmVhbV9zdGF0ZSAqZWRwX3N0cmVhbXNbTUFYX05VTV9FRFBdOw0KPiA+
ICAgCXN0cnVjdCBkY19saW5rICplZHBfbGlua193aXRoX3NpbmsgPSBOVUxMOw0KPiA+ICAgCXN0
cnVjdCBkY19saW5rICplZHBfbGluayA9IE5VTEw7DQo+ID4gLQlzdHJ1Y3QgZGNfc3RyZWFtX3N0
YXRlICplZHBfc3RyZWFtID0gTlVMTDsNCj4gPiAgIAlzdHJ1Y3QgZGNlX2h3c2VxICpod3MgPSBk
Yy0+aHdzZXE7DQo+ID4gICAJaW50IGVkcF93aXRoX3NpbmtfbnVtOw0KPiA+ICAgCWludCBlZHBf
bnVtOw0KPiA+IEBAIC0xODMwLDcgKzE4MjksNyBAQCB2b2lkIGRjZTExMF9lbmFibGVfYWNjZWxl
cmF0ZWRfbW9kZShzdHJ1Y3QgZGMNCj4gKmRjLCBzdHJ1Y3QgZGNfc3RhdGUgKmNvbnRleHQpDQo+
ID4gICAJCQlpZiAoZWRwX2xpbmstPmxpbmtfZW5jLT5mdW5jcy0+aXNfZGlnX2VuYWJsZWQgJiYN
Cj4gPiAgIAkJCSAgICBlZHBfbGluay0+bGlua19lbmMtPmZ1bmNzLT5pc19kaWdfZW5hYmxlZChl
ZHBfbGluay0NCj4gPmxpbmtfZW5jKSAmJg0KPiA+ICAgCQkJICAgIGVkcF9saW5rLT5saW5rX3N0
YXR1cy5saW5rX2FjdGl2ZSkgew0KPiA+IC0JCQkJZWRwX3N0cmVhbSA9IGVkcF9zdHJlYW1zWzBd
Ow0KPiA+ICsJCQkJc3RydWN0IGRjX3N0cmVhbV9zdGF0ZSAqZWRwX3N0cmVhbSA9DQo+IGVkcF9z
dHJlYW1zWzBdOw0KPiA+ICAgCQkJCWNhbl9hcHBseV9lZHBfZmFzdF9ib290ID0NCj4gIWlzX2Vk
cF9pbHJfb3B0aW1pemF0aW9uX3JlcXVpcmVkKGVkcF9zdHJlYW0tPmxpbmssICZlZHBfc3RyZWFt
LT50aW1pbmcpOw0KPiANCj4gV2hpbGUgeW91IGFyZSBhdCBpdCwgdGhlcmUgc2hvdWxkIGFsd2F5
cyBiZSBhbiBlbXB0eSBsaW5lIGJldHdlZW4NCj4gZGVjbGFyYXRpb24gYW5kIGNvZGUuDQoNClZl
cnkgd2VsbCwgd2lsbCBmaXggaXQuICBDYW4gSSBoYXZlIGEgdGFnIHdpdGggYXNzdW1wdGlvbiB0
aGF0IGZpeCBpbiBwbGFjZSwgb3INCnNob3VsZCBJIHJlLXNlbmQ/DQoNCj4gDQo+IFJ1bm5pbmcg
eW91ciBwYXRjaGVzIHRocm91Z2ggY2hlY2twYXRjaC5wbCBoZWxwcyBzcG90dGluZyBzdWNoIHN0
dWZmLg0KPiANCg0KQWN0dWFsbHkgY2hlY2twYXRjaCBkaWRuJ3QgY2F0Y2ggdGhhdC4NCg0KJCAu
L3NjcmlwdHMvY2hlY2twYXRjaC5wbCAwMDAyLWRybS1hbWQtbW92ZS12YXJpYWJsZS10by1sb2Nh
bC1zY29wZS5wYXRjaA0KdG90YWw6IDAgZXJyb3JzLCAwIHdhcm5pbmdzLCAxNSBsaW5lcyBjaGVj
a2VkDQoNCjAwMDItZHJtLWFtZC1tb3ZlLXZhcmlhYmxlLXRvLWxvY2FsLXNjb3BlLnBhdGNoIGhh
cyBubyBvYnZpb3VzIHN0eWxlIHByb2JsZW1zIGFuZCBpcyByZWFkeSBmb3Igc3VibWlzc2lvbi4N
Cg0KPiBDaHJpc3RpYW4uDQo+IA0KPiA+ICAgCQkJCWVkcF9zdHJlYW0tDQo+ID5hcHBseV9lZHBf
ZmFzdF9ib290X29wdGltaXphdGlvbiA9IGNhbl9hcHBseV9lZHBfZmFzdF9ib290Ow0KPiA+ICAg
CQkJCWlmIChjYW5fYXBwbHlfZWRwX2Zhc3RfYm9vdCkNCg==

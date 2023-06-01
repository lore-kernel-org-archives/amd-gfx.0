Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50695C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 17:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A21010E592;
	Thu,  1 Jun 2023 17:32:20 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::60f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B50310E58F
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 17:32:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDV23LanwYoXTOuGmQlll3XymnLfY7as3KMjHQ4U1IqF1I7tOieEpqixJ6ITRHR0LC3DGK0ciwMwOxATjIXvLQac3kvzAe0KILyC2BJcm/2h3phzL4rnzXzb21tE51gYVmzyTp0y8+YzdF+F59rn3SmHCusaLB02+RTbDzOsiZ7NqiLDx4Z9xpITQCym2gkJtMgZfxZDqvTbwZf2yj6tdu1wwZ6aN1SDpkm99XfopLcISH3/eZTCKOvYFZQCY+Anp+kvyf1WFwd0WadEs9MH6GlF8+flJooKGYNnpHAfAJ9wenEyruv/AnoDKjIe7CveIfhmwtybSBdKaLaiUumATQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yonpeqZ+bERR7JrQ4I7sjcjuA3y9BBI+QIb7H9zZW9U=;
 b=FFDTGQlpOqMXimOinBjlaiTyI1WJ0peBIXurkEvPiDHlMvWMt/gxZgxlwh9wPNIkMYfNcgX1XD0k+iBYncFEygu6yzkKxHxNZImJ+3ICpDxbRn9pYLUeixgDkTW8QxGI0oBs7Zx+bNLlXIpczETK7NgtFIhWZJo7p/LXOwGDnGtRzd9bJci0qa2ey/zyNAW7yoaLy4LCQo+INxBar4u5fFYKmPSc7IiBFZPd3PQm+cqvQj8TV6YGfEP5b57FAcdIaVtlEmYNDQIb0S/CsRx0Dd7kz+h7VhoNd1xs1Dssv08xQJzem+YLx37FYFpGuwBNZFox/CbBcCfPGj0gEPkA9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yonpeqZ+bERR7JrQ4I7sjcjuA3y9BBI+QIb7H9zZW9U=;
 b=A+gEtg5cWJk2d67/nC0q2JgYaJDa1W4lw/l6sdsX/3+FrsbtJT+8oz4BTEM4AhUnjsOrfWLNfjGPB7DXi2x9oMRzjTiOQlj86RfCanN4OB/APwIpMnquTS2XbTNDuLPJltShYpPRIAQihApR5s9pJt3hzMk4T6ly/uy9ytlz9vI=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB6616.namprd12.prod.outlook.com (2603:10b6:8:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 17:32:14 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a65c:3aa0:b759:8527%5]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 17:32:13 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH v2 1/2] drm/amd: Disallow s0ix without BIOS support again
Thread-Topic: [PATCH v2 1/2] drm/amd: Disallow s0ix without BIOS support again
Thread-Index: AQHZk0by55pnFViFU02apb6xRrle1K90YHIAgADpawCAAMuUQIAADFYAgAATHKA=
Date: Thu, 1 Jun 2023 17:32:13 +0000
Message-ID: <MN0PR12MB61015B1C47145EE26E88440BE2499@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230530204848.231842-1-mario.limonciello@amd.com>
 <CADnq5_N64zscFAjTj2JtBGqyoZRUjazSrW75NGAJqPKWBXL68Q@mail.gmail.com>
 <CADnq5_McnF0W+zS0t+tShb0PH4bRLzRcPnSrWNryV06+0biYvg@mail.gmail.com>
 <MN0PR12MB610115263A4DEE12FCAB5D69E2499@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CADnq5_PSsLLC7gRTDohur+2Oy2g_r0ziwOottbRVdWrJZ4HxAw@mail.gmail.com>
In-Reply-To: <CADnq5_PSsLLC7gRTDohur+2Oy2g_r0ziwOottbRVdWrJZ4HxAw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=97ffc566-940e-4733-a708-9f703cd721f6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-01T17:23:03Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DM4PR12MB6616:EE_
x-ms-office365-filtering-correlation-id: 3e2d704d-eda5-4f36-de8c-08db62c62355
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zbl4LJkouXrZY3FHFeJimSMGs+cJJKxpZoarNF9FH6lSk1BXd4KJE0lO2ira2CYvcmyTUGxp6QN6+M384VFhLdzNCLbRCTbjfaJgkK7yA1pNB+MoTgXdDD+CZw+4s32HOb3HknuxM9dNoZ1uoVpl8CusddA36y94ymVaSyem02nEW68VRP7DC5kHTilhIuGfcFuksjANiviH4IgETr0QVEM6SHgh1bK6dBYXnzjbGohohLr00fdVatxKMnMTz16EfFzTJ1ruwqXEDeKCgabgc1xjYFvgjwRbvfSiD60hw9iCrIcYU/0n56hutjIbS5A6g0eKycE2LnOWNAV5UIYr/xoNJtRShJuooGHQ1ngilS2zz2Sot1MV/z8QPT2J3JVd0ZJMbV9VgVHmphFn+AMm4H6jHYnF8ZVdd2ichIPfncJSQCipBjXGd7Xl3Oarwn+gns2iw571ZMMFvw+5otmRrgkx3jvkHRvl/0IygDrkIUbaVkiBYiCPkAhmuVbs2UlNFu15rHxoM+XjsFJ2wISrIzCbypQa/eoFGO3Fa3cpCvsdZNcZ249IFRtTQB0uB5NrikSkh/TcL85V/XjujfQ5gDQkC/GN4Wl4q2qn+vfIilfkkGojHKOtjq86ORoceMdm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199021)(54906003)(8936002)(8676002)(5660300002)(52536014)(478600001)(33656002)(41300700001)(7696005)(86362001)(316002)(71200400001)(966005)(26005)(6506007)(55016003)(9686003)(66946007)(66476007)(76116006)(4326008)(66446008)(64756008)(66556008)(6916009)(53546011)(186003)(66574015)(83380400001)(38070700005)(2906002)(38100700002)(122000001)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VURLbHprbTBLbVRvY0UrZFJZdFcyR1ZsOWRScjR6eGo0RDdlTlgrc1dZdFFz?=
 =?utf-8?B?V0dwMVgzOTViUm05ejY0OGtDRk9QZksyR0hzcTRaS2FNZytwcVcwaUVCNVhj?=
 =?utf-8?B?a1VXbUg3SXpUZjdyK2FqaU16L01Ha1o1N0tRMUlUOGpIZEFvQW5KK2pKWkk2?=
 =?utf-8?B?R3hSVGJmUENKN3ZuVmF1bHZjYjJVcFdSNWJyalMvMkR5cGlxZ3o5dlgxZDFL?=
 =?utf-8?B?WXk0Y2t6ZGE2WWM1UlRBQ1ltUi9EZEpwOXBqZGt1dklwbHJOaXZQeUo4Ukx0?=
 =?utf-8?B?OTFzcGV1TWhidDRQWmNyVDgxOWdJUUs5ckM1clRjS0c2RFRnL1pBejRyeVU3?=
 =?utf-8?B?WVVKNnlXK0pRR2Jja2wwNjFFRUREK2dzaC9vbE1Tek54aWhnMGFqY3hTL0d3?=
 =?utf-8?B?WXZVQ25ZL0ZPL0VFaGhrcWRmUHpGcVlRbDhvQlNsYjFqTTlPM1YvemRaRFRK?=
 =?utf-8?B?RUwwQ2F0N2hHbXlHVmVUdTNyMEJBSXIySDlvV2txREZ0b3JhRXFyNFB1Qjky?=
 =?utf-8?B?clduY0JNU0huRUtXempMa012MXVJVWFubll0WDloWUIwWkdXbUFlS3BhZFVL?=
 =?utf-8?B?UytJY1RiZ3A4aTlSZWd0dGJGb2UxaUVSTzdhZjhpNHVRNys0SjFkdWl6Z24x?=
 =?utf-8?B?QTJ4OVJWcUlIcXAybWgyVFVDMktNdHBQbzBLbGM4QXl4Mkk5VUFhSFhjVjll?=
 =?utf-8?B?cTdpY3VsVnpqbWFhWEpxWldqdDFEL1VBNDJWQXd5UWZCTzBIWjRYMDBCcVpy?=
 =?utf-8?B?SmZrQmRsaXc0dS9ETXFXTHZtdFRXT3JQWFpZNS9HWlRiKzhvZFc0Mis4MDZG?=
 =?utf-8?B?aHZKN3JMRTBvOGFIMmNtekloN2t3RDFJTlF2L1kwMFR0ZG5sOHZycmpLUnRr?=
 =?utf-8?B?TkRnYVlPLzdtclJnNjhxdHNtTXV5SDlPYkdtQnpXV3ZDaTRyWEhzaXRBcjNF?=
 =?utf-8?B?cXhoMGYxR2w4YW9pUXZiKzFKU1dTK3ExUTgzTmFFMVJPOUxMNFdBYmQ1UUdv?=
 =?utf-8?B?bFRSb3NndmFFb3dmVnh1S3J0bkl5Vjc5NlBOQmptSDhLeU1HWlM0T2twZkox?=
 =?utf-8?B?d2t6RnhqREl0UDMrRGphNUlqUGtyM2RBZnZ2dWpoZG9pcXNwekg3aWdSMlI3?=
 =?utf-8?B?RHc5WHZtQko1WjNyVWpRY20vYUVnR1VwMjQyOUtJWlZ5cVlDbUE1ZTdBMlFu?=
 =?utf-8?B?dEFnOVphdXV6UlRxRG9HOGJBeVErTUV0ZlBjeEREYlBUZDl6VUdvQTlFQTk0?=
 =?utf-8?B?TEZlYVBjWnZqK09pVHZnQ0NReDZtQUZKc0FOeGJKdWV0L2dXdjdoYmVEN2pY?=
 =?utf-8?B?aHpQR0xFb0ZYVWlYSUE1Z3FMVjNsbUs2MFpjSlhPVy9wWWdINXRqVkVIbm1p?=
 =?utf-8?B?WFp0ZTNJSE5zVGVDVThUL1gyL09hdkZBMDlSVnlxd1ZIVkhDQkx2REFyaUFn?=
 =?utf-8?B?WEFJSkc3SnVBVUZGM1psbWk3V3JUWWd5aXZHbklpWndjY0oxRjlkYUpJTFJa?=
 =?utf-8?B?TGpIaGhnZ3hpcGlTOG9OMkl3a29VMzJzUXhnQVVwU0U0ZXNVeTRQQmtKTXlM?=
 =?utf-8?B?OWtGZCtJQlJ6cmU1eVMwOU9iVXkrTlBNVXNZc0RyeFZLUXQ1czBqdVNpdjFz?=
 =?utf-8?B?aG41clZQakNGN2VtQWloSFZ3eVdKLzF6aTIwMjlZZ3Bxb0ZSMkx0UDE0UFRG?=
 =?utf-8?B?WGd1ZHJFKzFqcmY2a2JHT3MrSnRCejhSQ1UyaWJyalNlaWhZLzExSkE1QmQ1?=
 =?utf-8?B?c0FyS3pSWHpGcHdjcHRNbHM3VmpqQzlGTXpPcFJlMEJzZXVZd1orOXpzK0Fq?=
 =?utf-8?B?T3AvUDI0OVM5M0UwT0JDQU90N1VaM2I3c1d6VmRBeWlzU0k1NTNOdjNVYk9L?=
 =?utf-8?B?Y3lzcFBuc3RsdWJDZ3JadjlnNjg0aERzQ3pwV1ZzWG9aTmZXb0lXUThCTnBi?=
 =?utf-8?B?K1V5dW9SNTI5M3RlYjk0cjBvMHlyNHdYeGhhRS9ZVmdzZStob3RuVjRoMG1p?=
 =?utf-8?B?REROWTJyQVZzZno5SStqaHF3SjkxanBwK2tGbXlqWlhzZitLQUpaTG9FZEZY?=
 =?utf-8?B?T0REbERKUCtjNFd6cnorSkxBSExoY1I2Z3Nlb095RFFOMTBEL1dVVGRGN3Nu?=
 =?utf-8?Q?TQCo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2d704d-eda5-4f36-de8c-08db62c62355
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 17:32:13.8434 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xpmVepIOhTfMmUtKBGFJJUTxEiiqJWQ59unU0UcV276FklS6vBrrazwvgoE3MhDzqRte3rt7MEKTLF++bRXPbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6616
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
Cc: =?utf-8?B?UmFmYWVsIMOBdmlsYSBkZSBFc3DDrW5kb2xh?= <rafael@espindo.la>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+
IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDEsIDIwMjMgMTE6MTUgQU0NCj4gVG86IExpbW9uY2llbGxv
LCBNYXJpbyA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4NCj4gQ2M6IGFtZC1nZnhAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnOyBSYWZhZWwgw4F2aWxhIGRlIEVzcMOtbmRvbGENCj4gPHJhZmFlbEBl
c3BpbmRvLmxhPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMl0gZHJtL2FtZDogRGlzYWxs
b3cgczBpeCB3aXRob3V0IEJJT1Mgc3VwcG9ydA0KPiBhZ2Fpbg0KPg0KPiBPbiBUaHUsIEp1biAx
LCAyMDIzIGF0IDExOjMz4oCvQU0gTGltb25jaWVsbG8sIE1hcmlvDQo+IDxNYXJpby5MaW1vbmNp
ZWxsb0BhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IFtBTUQgT2ZmaWNpYWwgVXNlIE9ubHkgLSBH
ZW5lcmFsXQ0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJv
bTogQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+ID4gPiBTZW50OiBXZWRu
ZXNkYXksIE1heSAzMSwgMjAyMyAxMDoyMiBQTQ0KPiA+ID4gVG86IExpbW9uY2llbGxvLCBNYXJp
byA8TWFyaW8uTGltb25jaWVsbG9AYW1kLmNvbT4NCj4gPiA+IENjOiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZzsgUmFmYWVsIMOBdmlsYSBkZSBFc3DDrW5kb2xhDQo+ID4gPiA8cmFmYWVs
QGVzcGluZG8ubGE+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMl0gZHJtL2FtZDog
RGlzYWxsb3cgczBpeCB3aXRob3V0IEJJT1Mgc3VwcG9ydA0KPiA+ID4gYWdhaW4NCj4gPiA+DQo+
ID4gPiBPbiBXZWQsIE1heSAzMSwgMjAyMyBhdCA5OjI24oCvQU0gQWxleCBEZXVjaGVyDQo+IDxh
bGV4ZGV1Y2hlckBnbWFpbC5jb20+DQo+ID4gPiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gT24g
VHVlLCBNYXkgMzAsIDIwMjMgYXQgNjozNOKAr1BNIE1hcmlvIExpbW9uY2llbGxvDQo+ID4gPiA+
IDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPiB3cm90ZToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+
IGNvbW1pdCBjZjQ4OGRjZDBhYjcgKCJkcm0vYW1kOiBBbGxvdyBzMGl4IHdpdGhvdXQgQklPUyBz
dXBwb3J0IikNCj4gPiA+IHNob3dlZA0KPiA+ID4gPiA+IGltcHJvdmVtZW50cyB0byBwb3dlciBj
b25zdW1wdGlvbiBvdmVyIHN1c3BlbmQgd2hlbiBzMGl4IHdhc24ndA0KPiA+ID4gZW5hYmxlZCBp
bg0KPiA+ID4gPiA+IEJJT1MgYW5kIHRoZSBzeXN0ZW0gZGlkbid0IHN1cHBvcnQgUzMuDQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiBUaGlzIHBhdGNoIGhvd2V2ZXIgd2FzIG1pc2d1aWRlZCBiZWNhdXNl
IHRoZSByZWFzb24gdGhlIHN5c3RlbQ0KPiBkaWRuJ3QNCj4gPiA+ID4gPiBzdXBwb3J0IFMzIHdh
cyBiZWNhdXNlIFNNVCB3YXMgZGlzYWJsZWQgaW4gT0VNIEJJT1Mgc2V0dXAuDQo+ID4gPiA+ID4g
VGhpcyBwcmV2ZW50ZWQgdGhlIEJJT1MgZnJvbSBhbGxvd2luZyBTMy4NCj4gPiA+ID4gPg0KPiA+
ID4gPiA+IEFsc28gYWxsb3dpbmcgR1BVcyB0byB1c2UgdGhlIHMyaWRsZSBwYXRoIGFjdHVhbGx5
IGNhdXNlcyBwcm9ibGVtcyBpZg0KPiA+ID4gPiA+IHRoZXkncmUgaW52b2tlZCBvbiBzeXN0ZW1z
IHRoYXQgbWF5IG5vdCBzdXBwb3J0IHMyaWRsZSBpbiB0aGUgcGxhdGZvcm0NCj4gPiA+ID4gPiBm
aXJtd2FyZS4gYHN5c3RlbWRgIGhhcyBhIHRlbmRlbmN5IHRvIHRyeSB0byB1c2UgYHMyaWRsZWAg
aWYgYGRlZXBgIGZhaWxzDQo+ID4gPiA+ID4gZm9yIGFueSByZWFzb24sIHdoaWNoIGNvdWxkIGxl
YWQgdG8gdW5leHBlY3RlZCBmbG93cy4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoZSBvcmlnaW5h
bCBjb21taXQgYWxzbyBmaXhlZCBhIHByb2JsZW0gZHVyaW5nIHJlc3VtZSBmcm9tIHN1c3BlbmQN
Cj4gdG8NCj4gPiA+IGlkbGUNCj4gPiA+ID4gPiB3aXRob3V0IGhhcmR3YXJlIHN1cHBvcnQsIGJ1
dCB0aGlzIGlzIG5vIGxvbmdlciBuZWNlc3Nhcnkgd2l0aCBjb21taXQNCj4gPiA+ID4gPiBjYTQ3
NTE4NjYzOTcgKCJkcm0vYW1kOiBEb24ndCBhbGxvdyBzMGl4IG9uIEFQVXMgb2xkZXIgdGhhbg0K
PiBSYXZlbiIpDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBSZXZlcnQgY29tbWl0IGNmNDg4ZGNkMGFi
NyAoImRybS9hbWQ6IEFsbG93IHMwaXggd2l0aG91dCBCSU9TDQo+ID4gPiBzdXBwb3J0IikNCj4g
PiA+ID4gPiB0byBtYWtlIGl0IG1hdGNoIHRoZSBleHBlY3RlZCBiZWhhdmlvciBhZ2Fpbi4NCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IENjOiBSYWZhZWwgw4F2aWxhIGRlIEVzcMOtbmRvbGEgPHJhZmFl
bEBlc3BpbmRvLmxhPg0KPiA+ID4gPiA+IExpbms6DQo+ID4gPg0KPiBodHRwczovL2dpdGh1Yi5j
b20vdG9ydmFsZHMvbGludXgvYmxvYi92Ni4xL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1DQo+
ID4gPiAvYW1kZ3B1X2FjcGkuYyNMMTA2MA0KPiA+ID4gPiA+IENsb3NlczogaHR0cHM6Ly9naXRs
YWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvMjU5OQ0KPiA+ID4gPiA+IFNpZ25l
ZC1vZmYtYnk6IE1hcmlvIExpbW9uY2llbGxvIDxtYXJpby5saW1vbmNpZWxsb0BhbWQuY29tPg0K
PiA+ID4gPg0KPiA+ID4gPiBQYXRjaCAxIGlzOg0KPiA+ID4gPiBSZXZpZXdlZC1ieTogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiA+ID4gPiBQYXRjaCAyIHNlZW1z
IGEgYml0IG11Y2gsIGJ1dCBJIGNvdWxkIGJlIGNvbnZpbmNlZCBpZiB5b3UgdGhpbmsgaXQNCj4g
PiA+ID4gd2lsbCBhY3R1YWxseSBoZWxwIG1vcmUgdGhhbiBhIHdhcm4gd291bGQuICBVc2VycyBh
bHJlYWR5IGFzc3VtZSB3YXJuDQo+ID4gPiA+IGlzIGEga2VybmVsIGNyYXNoLiAgSSdtIG5vdCBz
dXJlIHRoZSBhdmVyYWdlIHVzZXIgbWFrZXMgYSBkaXN0aW5jdGlvbg0KPiA+ID4gPiBiZXR3ZWVu
IHdhcm4gYW5kIGVyci4NCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBZb3UnbGwgbmVlZCB0byByZXZl
cnQgZDJhMTk3YTQ1ZGFhY2QgKCJkcm0vYW1kOiBPbmx5IHJ1biBzMyBvciBzMGl4IGlmDQo+ID4g
PiBzeXN0ZW0gaXMgY29uZmlndXJlZCBwcm9wZXJseSIpIGFzIHdlbGwsIG90aGVyd2lzZSwgd2Un
bGwgYnJlYWsNCj4gPiA+IHJ1bnRpbWUgcG0uDQo+ID4gPg0KPiA+DQo+ID4gQ2FuIHlvdSBlbGFi
b3JhdGUgbW9yZSBvbiB5b3VyIHRob3VnaHQgcHJvY2Vzcz8gIGQyYTE5N2E0NWRhYWNkIHdhcw0K
PiBhZGRlZCBpbiA1LjE4DQo+ID4gYW5kIGNmNDg4ZGNkMGFiNyB3YXMgYWRkZWQgaW4gNi4zLiAg
SSBjYW4ndCBpbWFnaW5lIHJ1bnRpbWUgUE0gaXMgYnJva2VuDQo+IHRoZSB3aG9sZSB0aW1lDQo+
ID4gb24gZEdQVXMuDQo+DQo+IEkgdGVzdGVkIHRoaXMgcGF0Y2ggeWVzdGVyZGF5IGFuZCBpdCBi
cm9rZSBydW50aW1lIHBtIGJlY2F1c2UNCj4gYW1kZ3B1X3Btb3BzX3ByZXBhcmUoKSByZXR1cm5l
ZCAxLiAgSSBoYXZlbid0IGRlbHZlZCBpbnRvIHdoYXQNCj4gY29uZGl0aW9uIGJyb2tlLiAgUmV2
ZXJ0aW5nIHRoaXMgcGF0Y2ggcmVzdG9yZWQgcnVudGltZSBwbS4gIFRoaXMgaXMgYQ0KPiBUaHJl
YWRyaXBwZXIgYm94IHRoYXQgb25seSBzdXBwb3J0cyBTMy4gIFRoZSBkR1BVcyB3ZXJlIHBvbGFy
aXMgYW5kDQo+IG5hdmkyeC4NCj4NCg0KQnV0IHJ1bnRpbWVfc3VzcGVuZCBpc24ndCBzdXBwb3Nl
ZCB0byBydW4gdGhlIHByZXBhcmUoKSBjYWxsYmFjayBBRkFDSVQuDQpTTUFSVF9QUkVQQVJFIGlz
IG9ubHkgdXNlZCBmb3Igc3lzdGVtIHdpZGUgc3VzcGVuZC9yZXN1bWUuDQoNCj4gQWxleA0KPg0K
Pg0KPiA+DQo+ID4gPiBBbGV4DQo+ID4gPg0KPiA+ID4gPiBBbGV4DQo+ID4gPiA+DQo+ID4gPiA+
ID4gLS0tDQo+ID4gPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3Bp
LmMgfCA4ICsrKysrKy0tDQo+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FjcGkuYw0KPiA+ID4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwaS5jDQo+ID4gPiA+ID4gaW5kZXggYWVlZWMyMTE4
NjFjLi5lMWIwMTU1NGUzMjMgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2FjcGkuYw0KPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3BpLmMNCj4gPiA+ID4gPiBAQCAtMTA5MiwxNiArMTA5Miwy
MCBAQCBib29sIGFtZGdwdV9hY3BpX2lzX3MwaXhfYWN0aXZlKHN0cnVjdA0KPiA+ID4gYW1kZ3B1
X2RldmljZSAqYWRldikNCj4gPiA+ID4gPiAgICAgICAgICAqIFMwaXggZXZlbiB0aG91Z2ggdGhl
IHN5c3RlbSBpcyBzdXNwZW5kaW5nIHRvIGlkbGUsIHNvIHJldHVybiBmYWxzZQ0KPiA+ID4gPiA+
ICAgICAgICAgICogaW4gdGhhdCBjYXNlLg0KPiA+ID4gPiA+ICAgICAgICAgICovDQo+ID4gPiA+
ID4gLSAgICAgICBpZiAoIShhY3BpX2dibF9GQURULmZsYWdzICYgQUNQSV9GQURUX0xPV19QT1dF
Ul9TMCkpDQo+ID4gPiA+ID4gKyAgICAgICBpZiAoIShhY3BpX2dibF9GQURULmZsYWdzICYgQUNQ
SV9GQURUX0xPV19QT1dFUl9TMCkpIHsNCj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgZGV2X3dh
cm5fb25jZShhZGV2LT5kZXYsDQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIlBvd2VyIGNvbnN1bXB0aW9uIHdpbGwgYmUgaGlnaGVyIGFzIEJJT1MgaGFzIG5vdCBiZWVu
DQo+ID4gPiBjb25maWd1cmVkIGZvciBzdXNwZW5kLXRvLWlkbGUuXG4iDQo+ID4gPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIlRvIHVzZSBzdXNwZW5kLXRvLWlkbGUgY2hhbmdl
IHRoZSBzbGVlcCBtb2RlIGluIEJJT1MNCj4gPiA+IHNldHVwLlxuIik7DQo+ID4gPiA+ID4gKyAg
ICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gPiA+ID4gPiArICAgICAgIH0NCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+ICAjaWYgIUlTX0VOQUJMRUQoQ09ORklHX0FNRF9QTUMpDQo+ID4gPiA+ID4g
ICAgICAgICBkZXZfd2Fybl9vbmNlKGFkZXYtPmRldiwNCj4gPiA+ID4gPiAgICAgICAgICAgICAg
ICAgICAgICAgIlBvd2VyIGNvbnN1bXB0aW9uIHdpbGwgYmUgaGlnaGVyIGFzIHRoZSBrZXJuZWwg
aGFzIG5vdA0KPiBiZWVuDQo+ID4gPiBjb21waWxlZCB3aXRoIENPTkZJR19BTURfUE1DLlxuIik7
DQo+ID4gPiA+ID4gLSNlbmRpZiAvKiBDT05GSUdfQU1EX1BNQyAqLw0KPiA+ID4gPiA+ICsgICAg
ICAgcmV0dXJuIGZhbHNlOw0KPiA+ID4gPiA+ICsjZWxzZQ0KPiA+ID4gPiA+ICAgICAgICAgcmV0
dXJuIHRydWU7DQo+ID4gPiA+ID4gKyNlbmRpZiAvKiBDT05GSUdfQU1EX1BNQyAqLw0KPiA+ID4g
PiA+ICB9DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAgI2VuZGlmIC8qIENPTkZJR19TVVNQRU5EICov
DQo+ID4gPiA+ID4gLS0NCj4gPiA+ID4gPiAyLjM0LjENCj4gPiA+ID4gPg0K

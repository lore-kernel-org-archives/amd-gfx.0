Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE50CC636CC
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Feb 2023 17:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C46810E254;
	Mon, 20 Feb 2023 17:12:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2C2110E254
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Feb 2023 17:12:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMBCY8ynm84pjr159qZP7VhMt70RutRoNlpfSbcZUeK1QHqg1GVanw2gj6aozedPrcZrIF4tzs399MAcM/ctMdszIab8SGx8vBlcOiUPeIkjQeRkEVmfnB92Wg9mOBbJG0j1iQ6cIyybmp16TiaeiJygylSXucnM+JTg00U4sQ1yUIGTuhozP490ttrziFAKgLuT3rE2myGttFtBjVXgOYwks0BTG4vLNA5QGrTxVotqxVx5dQht1BQyuixlcGR9BbXEwt+Ocd9zfuzsqOxRUO6aWg/y3ZmwYHJA/UPb20R28SELaXj2qCgwL7Ho9ZUYQIaniJKuAJg5u3U6yMw6cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olKs7rPqg+8RFkyqpedGZfRBZLqVPKGQLf98gjv9k3c=;
 b=CKfYflDNuun9h1j32pi82/jzvVDKXuxpitm+9lUq9m+qtZ4BdyG5M7dU9pjT+HVFtWAioDiz3Y+MH6jtquPmladokz3k2aHrR0pzwBMGxR0rKb57QGCy4jxxF9Vn2NAyEmyKP6GE/c9fFUF5d0avNXWg+WLRY9h0gq1uC38Xpkz+7+6aMMH/HcAMm9VEBUdXJUClUVmMrD4pqRZkgJRkmvP7W1v7pK0vnLbufUcI3BopnK1eVcOkApDlSecTk3TuMj8eQ8SqMzL28PKTKZHxcVX+xTDjV24Dd3psZ7PxX+Tb4b0MtdkRtV8FbCbobj5N3WW/j9L9g8PjdQsDVDgaeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olKs7rPqg+8RFkyqpedGZfRBZLqVPKGQLf98gjv9k3c=;
 b=VR1nPPWseAFkDRSDl/W/w9eXeH/yEDFeM0nD2I5pBcAWm6fCI/ZujVMm5GmKPsXaK7pG5uz2WtTzPu5xZVnTUpu2sVEN6NvpgOtvrHdQ+z7sFOpGfViA9ko/mT3HM6wIVH+JJL4Yf5zD0hY2cs78wdIZU7YqGjGgpgdk3GDgB5I=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Mon, 20 Feb
 2023 17:12:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%7]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 17:12:02 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH v2] drm/amd: Don't allow s0ix on APUs older than Raven
Thread-Topic: [PATCH v2] drm/amd: Don't allow s0ix on APUs older than Raven
Thread-Index: AQHZP++iqTyuv8QiVk+K3qmgTaIHEq7YGIWggAADz4CAAAB2IA==
Date: Mon, 20 Feb 2023 17:12:02 +0000
Message-ID: <MN0PR12MB61017303B1A6DBB2F2A3B209E2A49@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230213211030.5295-1-mario.limonciello@amd.com>
 <MN0PR12MB6101412F199DB12681D0D565E2A49@MN0PR12MB6101.namprd12.prod.outlook.com>
 <CADnq5_NKwBFHhx_TW2CSD0Ha46g5QGDDQBBqh=G78H672XQNKQ@mail.gmail.com>
In-Reply-To: <CADnq5_NKwBFHhx_TW2CSD0Ha46g5QGDDQBBqh=G78H672XQNKQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-02-20T17:12:00Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5a874051-49e5-4361-b652-755f73c7b945;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-02-20T17:12:00Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: e27d3e20-4619-49aa-aa10-2308f3d7b541
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CY5PR12MB6252:EE_
x-ms-office365-filtering-correlation-id: 91cb787b-cde3-4c91-2e17-08db13659584
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oIHFx0dtqs3eRP38haBx0NFMoV9KOBont8vVgiqNS+LfRenywmLCFAP4lR9RvF0sCPZfHd9p/raVDJMTj5NMZYkOwIEQ3WVlV1jWnxjaOz3a27+G4nEkBHX6gxP/jpjE3ZKwR/CjDSO2gunzOMx47kUWL8Vco8puLgIJDk7kbmepob+1Bt97rR61H8sO3CqwlkC0opdJXqe0y0+9YU3S9cVSBEy0cTBtLBoB1IMM9b2lpxejhnITDy+U5DinytYjsA2A1EQtUmXpbbGlGSr8O6UAHL4UygjLfisgJEKRPdkUEPfmw8WZeGtBOpGI0V3UEZrrpIqkG1pHdJTAzo+t15XEElrrh5hBI9FHH8fXeapNSldDg+f1zzpLI580LV0P8MIvoxDcNpTrFLNikQsajzDUO65p/5zbsrJAjWm7A/rKlX+k4AN4dmIAv7a7PMFhTLkOb3Rxs/S7MqMD4WQ+IsmyY62UTrPZcUqXg+PcCF+15wGN7AbZTtFsDXSzWx1Eq6WnLThOOU269FdFkJJT2aoH/AxSqPHNvXenL+o1Z7Jazzp9i/prcE0xeQwDpYS9oMvtPEIS+CRIRaurGkmPg/GWqkVwiE8GIedqc4dKJfIvVQ2CWhFOp8nr96TrIl1W8YFF+r13pjM/FYnkIcOZfL/ONHE8NlGGM6HzkoYJgc7lOtLBQsuuTYyAqN/bRF511eMJVzfPnY/k97WQTe+Dg/idxAHs7LBd2KqUOfRxenI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199018)(53546011)(5660300002)(52536014)(9686003)(41300700001)(8936002)(38070700005)(55016003)(2906002)(83380400001)(38100700002)(122000001)(33656002)(71200400001)(316002)(54906003)(86362001)(7696005)(26005)(478600001)(6916009)(4326008)(66446008)(64756008)(8676002)(66946007)(66476007)(66556008)(186003)(76116006)(6506007)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2JBZktNZ1dzalRxMFg4RXpzVVloL1V1YzNCM3JNVVV5V2V1Q0RBL29Jcjd5?=
 =?utf-8?B?R1N5YUplOTdXdmQ5anczeE5zbThxalBxZnhJR3A0OWtZN3FVV2RCb3FwUHZ5?=
 =?utf-8?B?bUFyQ0NsMzBjdEcwQy9jd2M2RXVueWlzVHNVcnNGTDhWMjBqSlJ0VlA4bWc1?=
 =?utf-8?B?TTBuS3MwN3RFUkhPZW1LZ24rak9WY1VzMWk5RitDblE1RDBtdk8wSUg0bWQx?=
 =?utf-8?B?TW9vUThQQ25EelJDb052QnZWMVpCRHlwaXRDQWwrb0Vtanh3RzdkMjNmS0VW?=
 =?utf-8?B?OE1lOEZ2d2VVNTZXTHNIVllNUXZHZkJSS2l6akM2bGNETGsrcGs5eUIyV0x6?=
 =?utf-8?B?QWljdmZpQ3dUeXE2aTdRMFJLUWxmeC9FQnZCUmppTWR0K1NqQlBUMUFQR0Uy?=
 =?utf-8?B?SStPNHRDRHNnVzFYOU5YdENkS1RhTjFibTROT21SZlovaXE5SnRQSElCQ2My?=
 =?utf-8?B?Y056SitYQlBhK0Rld3ZhVy9udjQzVTFIVXNKN2k5WmFGa0NyZ1c3T251SHYy?=
 =?utf-8?B?OWlla3U4aFFaSk1VRlh1SDE3L1oyajI4eGlBODBaYk5kRWg5OFcvamFyemJ0?=
 =?utf-8?B?UEZ5TFZYc0twSlFWVDJlZXY1ZE82SnVUR1BBUUhCb1o4eXN0QkdwSGNhaXBN?=
 =?utf-8?B?TkwrdmpVTHo0cWh0RmFlbTd4eDU3V0laUEF3RHpkbVpUTGtnOFJaQzdkRUhD?=
 =?utf-8?B?SkoxU2lPNWtVS2Q1ODNyRUlFR3ZxcEdCVzlzU3NjRkF5UVVWZkZYOHB0OG5u?=
 =?utf-8?B?dHpWVHgwQjlVR0wrR2Rkd3BSd0xqY2lmSFo0dXRSaGg1U0UwSmU2NlBBRTEr?=
 =?utf-8?B?ajlNZjd0VTUxa1RRb2c4VnlLUFlBdFVLSElXQ1U5WXVnWWxwYkg4QmVSRzNQ?=
 =?utf-8?B?bXRVbGFMU0tkd0thNk5vbFBhUzdNUGZDWDJITDZkL1JhOHFUbzkybWdzUmFy?=
 =?utf-8?B?N2pseFNwbU1rQWZNZ0RjWmxnY1lJa2c5YkJkVXVSWEsvTkRRZVR1RUhLWkp0?=
 =?utf-8?B?RCtHNW51NjE3U0t3VlMreWlpWjZScjZiS3BQRjdKaVhkYVZETVEvVGRwQUZq?=
 =?utf-8?B?L08xdDdBMnhvSFVzUk5ucVdpNi8yVTZlM1k3U0ovRnhnRytTYXZ3SkFoN2xu?=
 =?utf-8?B?OFFVSFJTR2JnUE5SSTFuc2lHNTRmV21weE96d05sM0FhbnZsZEtkRlZhaUFO?=
 =?utf-8?B?bGhCZ0t6aWNxSjVOMmorN0NWdUZJR01KM1IyZ01YZzRHRkVoNFlGb04vT1hE?=
 =?utf-8?B?T3M3bXpPRGVJaUVjbkdLeDlITXNwZ2dZZllLa21JY1RreGRlcE84MmR0RnFD?=
 =?utf-8?B?NER0czljd2RwUGNHM0lLdDIvYXpUOHRRVG40UmpTVzdMeGNRR1hyTlE3TkEr?=
 =?utf-8?B?NlVZTFdlVkJWTXNvUmo1cDBteklzNHN0MHZpeVplb0Z2VFRSQWNMS1F1QkxW?=
 =?utf-8?B?VEZiUnlUOWxtbUF5TzA0YjRYRFkzTEtXNVdiRSsrVmFUL29lenVDaE1Ka3Zh?=
 =?utf-8?B?T2dRRkxGa1lDMUxaZWxUMmhoNmRadEFKZ1l3ZXQvSlk3NGpvZ244ODBMeDZE?=
 =?utf-8?B?Qk5uaUM4SjVoZ3lHdzlMdVN4ZVYzTUV1bmMzWityM2IvUjF4MWpKVzd6Wkx4?=
 =?utf-8?B?eGZVTHBwcDZPMmJvRWxsRndkei9GU3g2T29la2kxVWw5OWZNcStaSmwxelVw?=
 =?utf-8?B?YklxVW40Y3B4NlBPSzBjVmxiVUFySWZOcWx0UFEvSTlPZk1vc3NueHU4ZVhy?=
 =?utf-8?B?NmFqSk9VbnNGNko3RU96UGFhRDM1VHZkMjVhbHhxUGh4TDdqOTZhT25kcVRa?=
 =?utf-8?B?ZEdDd1c4b05HZW9pR1BFSnRXZ0xxNnBvclZteGJHTUFEaGRUSDB2UzVjQUsx?=
 =?utf-8?B?RTlkSzFVbVZkRFZlU1ljNGJzOG5WVWxWQlNvZmhhWmtyemR2T1Y2T2p0K0RM?=
 =?utf-8?B?UVpHM0FVc3RMdUpZVUIrb1dDNG00L08wQllKc2kwREg4MjQxUjE3eEZBWGZF?=
 =?utf-8?B?M2JraHloS1pSSzJ6bEM4S0JocThnZnltM3BHQWpuRzI4bFNtYVhheE9BR3k0?=
 =?utf-8?B?aUZYTXZyUllHMW9RaTA1RS9nK1cvSUdrWWI3R2p5bU5YMDg2WFcxSHZRYzhU?=
 =?utf-8?Q?vr5s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91cb787b-cde3-4c91-2e17-08db13659584
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 17:12:02.3993 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dum44Ne7nBeTbbQEcermwcKtJALuXHYKRsazAnIjFKRRAwRVe5chXnNcu8MXQPwhkKQBaDBAUtCnkyfWYvEqLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6252
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwuY29t
Pg0KPiBTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDIwLCAyMDIzIDExOjEwDQo+IFRvOiBMaW1vbmNp
ZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IENjOiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBkcm0vYW1kOiBEb24ndCBh
bGxvdyBzMGl4IG9uIEFQVXMgb2xkZXIgdGhhbiBSYXZlbg0KPiANCj4gT24gTW9uLCBGZWIgMjAs
IDIwMjMgYXQgMTE6NTYgQU0gTGltb25jaWVsbG8sIE1hcmlvDQo+IDxNYXJpby5MaW1vbmNpZWxs
b0BhbWQuY29tPiB3cm90ZToNCj4gPg0KPiA+IFtQdWJsaWNdDQo+ID4NCj4gPg0KPiA+DQo+ID4g
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogTGltb25jaWVsbG8sIE1h
cmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPg0KPiA+ID4gU2VudDogTW9uZGF5LCBGZWJy
dWFyeSAxMywgMjAyMyAxNToxMQ0KPiA+ID4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnDQo+ID4gPiBDYzogTGltb25jaWVsbG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQu
Y29tPjsgRGV1Y2hlciwNCj4gQWxleGFuZGVyDQo+ID4gPiA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT4NCj4gPiA+IFN1YmplY3Q6IFtQQVRDSCB2Ml0gZHJtL2FtZDogRG9uJ3QgYWxsb3cgczBp
eCBvbiBBUFVzIG9sZGVyIHRoYW4gUmF2ZW4NCj4gPiA+DQo+ID4gPiBBUFVzIGJlZm9yZSBSYXZl
biBkaWRuJ3Qgc3VwcG9ydCBzMGl4LiAgQXMgd2UganVzdCByZWxpZXZlZCBzb21lDQo+ID4gPiBv
ZiB0aGUgc2FmZXR5IGNoZWNrcyBmb3IgczBpeCB0byBpbXByb3ZlIHBvd2VyIGNvbnN1bXB0aW9u
IG9uDQo+ID4gPiBBUFVzIHRoYXQgc3VwcG9ydCBpdCBidXQgdGhhdCBhcmUgbWlzc2luZyBCSU9T
IHN1cHBvcnQgYSBuZXcNCj4gPiA+IGJsaW5kIHNwb3Qgd2FzIGludHJvZHVjZWQgdGhhdCBhIHVz
ZXIgY291bGQgInRyeSIgdG8gcnVuIHMwaXguDQo+ID4gPg0KPiA+ID4gUGx1ZyB0aGlzIGhvbGUg
c28gdGhhdCBpZiB1c2VycyB0cnkgdG8gcnVuIHMwaXggb24gYW55dGhpbmcgb2xkZXINCj4gPiA+
IHRoYW4gUmF2ZW4gaXQgd2lsbCBqdXN0IHNraXAgc3VzcGVuZCBvZiB0aGUgR1BVLg0KPiA+ID4N
Cj4gPiA+IEZpeGVzOiBjZjQ4OGRjZDBhYjcgKCJkcm0vYW1kOiBBbGxvdyBzMGl4IHdpdGhvdXQg
QklPUyBzdXBwb3J0IikNCj4gPiA+IFN1Z2dlc3RlZC1ieTogQWxleGFuZGVyIERldWNoZXIgPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJpbyBMaW1v
bmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gdjEt
PnYyOg0KPiA+ID4gICogRG9uJ3QgcnVuIGFueSBzdXNwZW5kIGNvZGUgb3IgcmVzdW1lIGNvZGUg
aW4gdGhpcyBjYXNlDQo+ID4NCj4gPiBBbnkgZmVlZGJhY2sgZm9yIHRoaXMgcGF0Y2g/DQo+IA0K
PiBSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0K
PiANCg0KVGhhbmtzLg0KDQo+IEkgdGhpbmsgZm9yIFMwaXggYW5kIGRHUFVzLCB3ZSBwcm9iYWJs
eSBuZWVkIHNvbWUgYWRkaXRpb25hbCB3b3JrIGFzDQo+IHdlbGwuICBJZiB0aGUgdXNlciB0cmll
cyBzMmlkbGUgYW5kIHRoZSBwbGF0Zm9ybSBkb2Vzbid0IGFjdHVhbGx5DQo+IHN1cHBvcnQgczBp
eCAoaS5lLiwgZG9lc24ndCBhY3R1YWxseSB0dXJuIG9mZiB0aGUgcG93ZXIgcmFpbHMpLCB3ZQ0K
PiBzaG91bGQgYmUgdXNpbmcgdGhlIHJ1bnRpbWUgc3VzcGVuZCByb3V0aW5lcyBmb3IgQkFDTy9C
T0NPIHJhdGhlciB0aGFuDQo+IHRoZSBTMyBzdXNwZW5kIHJvdXRpbmVzLg0KDQpPSyAtIEknbGwg
cmV2aWV3IHRoZSBmcmFtZXdvcmsgY29kZSBmb3IgdGhhdCBjYXNlIGFuZCBzZWUgd2hhdCBtYWtl
cyBzZW5zZS4NCg0KPiANCj4gQWxleA0KPiANCj4gDQo+ID4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3BpLmMgfCAzICsrKw0KPiA+ID4gIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyAgfCA3ICsrKysrKy0NCj4gPiA+
ICAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4N
Cj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNw
aS5jDQo+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hY3BpLmMNCj4g
PiA+IGluZGV4IGZhNzM3NWI5N2ZkNDcuLjI1ZTkwMjA3N2NhZjYgMTAwNjQ0DQo+ID4gPiAtLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwaS5jDQo+ID4gPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYWNwaS5jDQo+ID4gPiBAQCAtMTA3Myw2
ICsxMDczLDkgQEAgYm9vbCBhbWRncHVfYWNwaV9pc19zMGl4X2FjdGl2ZShzdHJ1Y3QNCj4gPiA+
IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ID4gPiAgICAgICAgICAgKHBtX3N1c3BlbmRfdGFyZ2V0
X3N0YXRlICE9IFBNX1NVU1BFTkRfVE9fSURMRSkpDQo+ID4gPiAgICAgICAgICAgICAgIHJldHVy
biBmYWxzZTsNCj4gPiA+DQo+ID4gPiArICAgICBpZiAoYWRldi0+YXNpY190eXBlIDwgQ0hJUF9S
QVZFTikNCj4gPiA+ICsgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiA+ID4gKw0KPiA+ID4g
ICAgICAgLyoNCj4gPiA+ICAgICAgICAqIElmIEFDUElfRkFEVF9MT1dfUE9XRVJfUzAgaXMgbm90
IHNldCBpbiB0aGUgRkFEVCwgaXQgaXMNCj4gPiA+IGdlbmVyYWxseQ0KPiA+ID4gICAgICAgICog
cmlza3kgdG8gZG8gYW55IHNwZWNpYWwgZmlybXdhcmUtcmVsYXRlZCBwcmVwYXJhdGlvbnMgZm9y
IGVudGVyaW5nDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2Rydi5jDQo+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
cnYuYw0KPiA+ID4gaW5kZXggNmMyZmU1MGI1MjhlMC4uMWY2ZDkzZGMzZDcyYiAxMDA2NDQNCj4g
PiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KPiA+ID4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jDQo+ID4gPiBAQCAt
MjQxNCw4ICsyNDE0LDEwIEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Btb3BzX3N1c3BlbmQoc3RydWN0
DQo+IGRldmljZQ0KPiA+ID4gKmRldikNCj4gPiA+DQo+ID4gPiAgICAgICBpZiAoYW1kZ3B1X2Fj
cGlfaXNfczBpeF9hY3RpdmUoYWRldikpDQo+ID4gPiAgICAgICAgICAgICAgIGFkZXYtPmluX3Mw
aXggPSB0cnVlOw0KPiA+ID4gLSAgICAgZWxzZQ0KPiA+ID4gKyAgICAgZWxzZSBpZiAoYW1kZ3B1
X2FjcGlfaXNfczNfYWN0aXZlKGFkZXYpKQ0KPiA+ID4gICAgICAgICAgICAgICBhZGV2LT5pbl9z
MyA9IHRydWU7DQo+ID4gPiArICAgICBpZiAoIWFkZXYtPmluX3MwaXggJiYgIWFkZXYtPmluX3Mz
KQ0KPiA+ID4gKyAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPiA+ICAgICAgIHJldHVybiBhbWRn
cHVfZGV2aWNlX3N1c3BlbmQoZHJtX2RldiwgdHJ1ZSk7DQo+ID4gPiAgfQ0KPiA+ID4NCj4gPiA+
IEBAIC0yNDM2LDYgKzI0MzgsOSBAQCBzdGF0aWMgaW50IGFtZGdwdV9wbW9wc19yZXN1bWUoc3Ry
dWN0IGRldmljZQ0KPiA+ID4gKmRldikNCj4gPiA+ICAgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2ID0gZHJtX3RvX2FkZXYoZHJtX2Rldik7DQo+ID4gPiAgICAgICBpbnQgcjsNCj4gPiA+
DQo+ID4gPiArICAgICBpZiAoIWFkZXYtPmluX3MwaXggJiYgIWFkZXYtPmluX3MzKQ0KPiA+ID4g
KyAgICAgICAgICAgICByZXR1cm4gMDsNCj4gPiA+ICsNCj4gPiA+ICAgICAgIC8qIEF2b2lkcyBy
ZWdpc3RlcnMgYWNjZXNzIGlmIGRldmljZSBpcyBwaHlzaWNhbGx5IGdvbmUgKi8NCj4gPiA+ICAg
ICAgIGlmICghcGNpX2RldmljZV9pc19wcmVzZW50KGFkZXYtPnBkZXYpKQ0KPiA+ID4gICAgICAg
ICAgICAgICBhZGV2LT5ub19od19hY2Nlc3MgPSB0cnVlOw0KPiA+ID4gLS0NCj4gPiA+IDIuMjUu
MQ0K

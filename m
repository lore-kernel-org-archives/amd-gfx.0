Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA708C6FD1C
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 02:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49B2210E4AF;
	Fri, 24 Mar 2023 02:07:49 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D567510E4AF
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 02:07:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3GajrdCvZNkAmm+AKJXMCL7JaILBEr3VxeO5ctEMDwcjoqWTu1WEtd8CP4q9Db1aPuumbdLFFkvlgrcw867i/vXi94iEs0eqw/4E/YsRoCzZQEbj8bVLmNdZTnWX+TFj+HC04qMLjC+gO5FjcE6qXO4dQH5lr+bOl2aEkB5knJUdpjAoJfRy/CHo+U/G/gcGatHl8g/SlJEV7PGTeiR5VtAawV6u6uoeJ2QgQSLb4OtxqcMS3UBFKg5Kp1nv/XYB8C0wRPYGyQ+1eMztltMvSRrYQy7mNNAqMp3KG1jHlbvdTXT5r+Zc2knaDXOaJ5EqOiDrEOoEZ8CcD1ADwyqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mGUYGwHHCrQFs1X0JalLiHukpmih3Po3zPmRVsrO2M=;
 b=mB61VzLRhCBohRelQXUAKzzGl/J4DovHzvAp+9OBQzgkOaQe09jwd5r7/XST2h68dRVs4TMAQvugG6k4clx73bH8B2hFud3y3xzcexEjE4dwitQPxrMSxocnLykwGHS2tFYHiZXF2zGvLJsCBbSZKGQWSMu3Bjw/msFP5uQQIB4umWJ+3nQlSFe5TKERYaBRWxK0V60FyaswdsgAimurSHfmaV2RekPHzcKXdsZetumWGbFWfzw/HL0y3Xk9HRLwEWOYpvpL+bOpf2qSlavUzbbEzzT4ug5I9NA8uzP5ZK4zaoVeTJpqdgCoNYPg/RnwpQqfpR5q3NK81X2IINKrAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mGUYGwHHCrQFs1X0JalLiHukpmih3Po3zPmRVsrO2M=;
 b=ovytTIYIJY6KDXGVB2Ip1u+o3HlYNhI8fref4mwyO8dEAoSWGJT4WmjboBZ0hUpjJr8Spt/oouQG5ClnkcN/SKAxPmj9+8zjYOe6RrFfJ5DKSvOj0qYaWN1vryFhYLeXEeZ/sr1MA+T9zow6GQyt4f9eAnGMZNJ3Nu4simcN1wA=
Received: from DM6PR12MB3531.namprd12.prod.outlook.com (2603:10b6:5:18b::10)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 02:07:44 +0000
Received: from DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::cf43:4080:4a5c:c4af]) by DM6PR12MB3531.namprd12.prod.outlook.com
 ([fe80::cf43:4080:4a5c:c4af%3]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 02:07:44 +0000
From: "Yang, WenYou" <WenYou.Yang@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [v1,3/3] drm/amd/pm: vangogh: support to send SMT enable message
Thread-Topic: [v1, 3/3] drm/amd/pm: vangogh: support to send SMT enable message
Thread-Index: AQHZXar/AdKpFZ6KfkKT3hsAyvbZxa8JL2xw
Date: Fri, 24 Mar 2023 02:07:44 +0000
Message-ID: <DM6PR12MB3531069BC681C4B7BEE9CF0DFD849@DM6PR12MB3531.namprd12.prod.outlook.com>
References: <20230322054808.1555230-4-WenYou.Yang@amd.com>
 <bc2d087d-c627-fa0d-7b4e-da3b763f8cff@amd.com>
In-Reply-To: <bc2d087d-c627-fa0d-7b4e-da3b763f8cff@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-24T02:07:41Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1604390e-a50a-4fc4-8e6f-11d8712cfc25;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3531:EE_|BL0PR12MB4865:EE_
x-ms-office365-filtering-correlation-id: 285631b7-42e5-4aed-e595-08db2c0c8e53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /wcogGaNEsfO0yAJUGnZ4eDimekyldU5O07eE/qDbwNZizg35zQMSKVwr7YFls0b6YPi6+6basQMrJfZYkY13PyfhB+idck4b644LVjQAmIitpSMtSwztdhv78VFKAwdV2eZIT6DzvqvkxwXpdJ38+NfZHtUkPucVzNJWPWWEBOS+PGLwP5u18uUXLU5Bi5JNgrrCKmWSVdp8cDzhZFLk5ettQ0J4CrpX0oy3tLwljhiiWqN4Zrp21buBj5lCDjcnrzMLxmOuIzL/l+1zWC/94xX8/BxyfvV6DE763/H0aoyXDxRZYxV8iBxbzEU0iX6hSltjFEiobjTboeZel/OSgZe1n/iCMm7X1IgLbgVDjHIPlfqbUVOnSpcQwmdzh9TU+2X2FjgVTntvxspxDp9Nngqoz29s83BUCxP2QO96jzqc4labhBBXWhMh4qkDSxUUx8bPOpatgX0C8plpGjSbMNdidNMCxioVPCsOrlZAHdx5zJew9avJmQ32DbcUlu8Z31zuOqHFm6z2O2K1J+tvFcW7YsqBPT81eEr0XgIRDlocS6LWIjx6uKvDNjboxtGVSeEW0X1+3uEl4JGGCWB/m3J9hTbLAgo3ldRx+OXd0vVhrJkwHFu7cfBKtpFQLOEBk89YCd1ZqVegpHcATAYeqkwqJHmk2j5O0m8jTbg3cPVIELIlIP+5hE3jwHvg7JgtfdgUsXl7wJTMWCLNByWbQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3531.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199018)(478600001)(83380400001)(64756008)(8676002)(66476007)(76116006)(5660300002)(66446008)(4326008)(316002)(66556008)(6636002)(66946007)(15650500001)(41300700001)(8936002)(26005)(52536014)(6506007)(122000001)(53546011)(110136005)(186003)(9686003)(7696005)(54906003)(71200400001)(86362001)(33656002)(2906002)(55016003)(38100700002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1pRdXBWb2tScTd6cW1HbEprWTZSeWtzYVhvclJTTkQ5cE5UUXRsMU5nQVF2?=
 =?utf-8?B?TlcxTVZaSnIrbHlxN051NTBCVTFHK3hXWWZERVBOSE94UTcxNnIwY3diekhB?=
 =?utf-8?B?OUJqTWZ5R05wK3JWVnA3RzBybCtTSUx2eDNiYXdSd0xSWTlaVTcwRCt1SWt5?=
 =?utf-8?B?V3IwUXViRnRCbDdWM1R4N3loRjJ6YlpRL2RQNGxKQXFJa3BsMGdHVjBRa0V0?=
 =?utf-8?B?Z0FKMXNxK2NCb1MvQ0VQbzByOUY0SzVsNWtLOXJ2akl6SXFPQTVkYUpqSEl6?=
 =?utf-8?B?RkFvMmNES21YQWhLeUQveWt0bHF0aWtLZEx5eERrV0lQQVdmV1c2THlzYW11?=
 =?utf-8?B?RSt4WDNCQ1h0Z05qWWN2cUVPODhuamw5d2Nhc2FwUTJISnMyVU5SNW9QaHpL?=
 =?utf-8?B?R3RMa2FrbXk2NXpTOHFnR0c1TkFSSE9DYkJvYUdsUW1WOWZ0aUc1L3pvcDBh?=
 =?utf-8?B?WHBOTmVRcEROY3BUODQ1NmFyLy9tdmlwYVEyVTU1Uk1aQkNmWnRkcStmUmhy?=
 =?utf-8?B?TlpHY0JDcjJqL2tsem5mcFdKeWhEWS9iQjMyd29haUkrcVA1cmx1TnlzcWk5?=
 =?utf-8?B?bDJEOVphUHh4b0ZlaHJYSjhLR1FmQm1BNmphQ1B5M01lU3VIU2xSVUliaUIz?=
 =?utf-8?B?VmZHcUpRZW4zbDZobnlLT2wrQ3ZjdjI4cURzOVZEMThhbFZVZFNDYVczMlJn?=
 =?utf-8?B?U2l3clUrR0pMMUFvRDZJN2J2TkRpcENNSVk3OWRnN2V5b3cwK21yM21lU2d6?=
 =?utf-8?B?MWEwL1gzT0pabHkvNWxsdjFTSVZ4UWFjZWNOUEdzc01jaWhPcjY2VVh4bjRl?=
 =?utf-8?B?SGV6YnFzbnVpcnRsOGxLM3pDaWlYdkwwUUdJaTIxNmdlVU5ZSUxndFdxNmI4?=
 =?utf-8?B?SHVWdnI5ZkRjdGdYd1lFcXU2bExVbHlJdUdESTVhRytWSzY0WkwrM0hndzEv?=
 =?utf-8?B?d1huR0NpWFdvS21oVXRkLzRaT2pUcGlqaTZOYkZaMjlyT1F3TkhKa0ljb0xx?=
 =?utf-8?B?aElINzY4ZG50UktnMGN0YS9QMTgrL3ZkT21yY2xKcEh2WHJLLzZiUGFEUjZH?=
 =?utf-8?B?aVNOejV5MWJYZnRpMlJONTZMUEhTNEpxN3Q0WkpLczU5Z0YvWEMwSjB3UFRw?=
 =?utf-8?B?cjZmcFJVdEZ3OHFONWs2YnlMS0F2M3hzVnM3QUFLVHZ2ZGttS0dkRStjNFBK?=
 =?utf-8?B?WmdENDJxRnFiRkdCZ0pzZjBrTXI5cmxYbGExQUlvNDZBZmRHSGx1Qlh5SC9t?=
 =?utf-8?B?bUg3T0o4RU5qUEI5dWJUZm1rWUdNc085MmcvVWJRanF0Y0IrcVZQWlBZbjN5?=
 =?utf-8?B?b3RReTBBWjI5TE9uaFRSWlJSb2lwM1ZnQzV2Wi92WXNGMkI4ditCOUhQUk1J?=
 =?utf-8?B?cWcweG9yT2prem11Y0xKWWNwU044MkNibW5LOTBMQ200cEo4WVV0a0N1Qm5Z?=
 =?utf-8?B?eFpWMXl1alg4blhtU0JzQ3ZvUGNUN3BBdlhPUWhyRWV0QnQ5bHRaSVZmd0hX?=
 =?utf-8?B?WUE4SndUUDdQQWR3UjI0cnczT2ZSZVFzSXMwM050cFEzTUMzbDVkdVlaTU0y?=
 =?utf-8?B?NDN3N1ErTlA5cmIxcDQ0K3hoNjc1Q1RvTFRrU2RwODlEWmk0YnNvSTdUdkxB?=
 =?utf-8?B?c214M1pIcmZjVXJ2REdsdlBoZWZvaTd5M2hrejZ1dmE5V0FiQkpLTjIxelNa?=
 =?utf-8?B?S0M3K2F1RzhvYld1UnJ4NU0xNnVQWjN6c1p1bWFLeDNGR0MvNjIvQnFseG9M?=
 =?utf-8?B?cGQ0U2hSS0RyT045VVJGcG83L0NzbVMyTTNOaU9WV1ZYMGZKRmtPcCtvOU94?=
 =?utf-8?B?eWErYkNBQVZzdU8rT1QxR1VoM2Nyb2xnYU14M3FBUWhMeFZxcGtMUG1KUk5x?=
 =?utf-8?B?TnhoN1FCMjBaRncxV3VnM0x4NnVCUllvL2VaRGdHbmJmejFZU01SQkdYTDFx?=
 =?utf-8?B?bU5jN1JlNEVOdWh6bDNjTGdKZUU3Ry9iNFRGSGdSUzY1UGdUNHFyancrYjFj?=
 =?utf-8?B?cVdlMG9ERXpJTnFvdDRWS3JySzR0bEdXUlNJQXNFejJib3JVNGozSUd6Szh2?=
 =?utf-8?B?MHFjTkJzdDBUNlVuV0ppWHFEd3lLTTc3VWR1ejUzM29uTGlCTlN5ZFJRcDh5?=
 =?utf-8?Q?AItXlerGH+pkTRTF1fwzd7hX1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3531.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285631b7-42e5-4aed-e595-08db2c0c8e53
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 02:07:44.1681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v0nTMA5bQBVH/JlUUo9IoONHF45V9PT4GNar2YCBo6VNT5bYtezoTlHIXELvl11ROxeNsqB8IJfSNSra5jnIhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
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
Cc: "Li, Ying" <YING.LI@amd.com>, "Liang,
 Richard qi" <Richardqi.Liang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IExpbW9uY2llbGxvLCBNYXJpbyA8TWFyaW8uTGltb25jaWVs
bG9AYW1kLmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXJjaCAyNCwgMjAyMyAxOjE1IEFNDQo+IFRv
OiBZYW5nLCBXZW5Zb3UgPFdlbllvdS5ZYW5nQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIN
Cj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8Q2hy
aXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgUGFuLCBYaW5odWkgPFhpbmh1aS5QYW5AYW1kLmNvbT4N
Cj4gQ2M6IExpLCBZaW5nIDxZSU5HLkxJQGFtZC5jb20+OyBMaXUsIEt1biA8S3VuLkxpdTJAYW1k
LmNvbT47IGFtZC0NCj4gZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgTGlhbmcsIFJpY2hhcmQg
cWkgPFJpY2hhcmRxaS5MaWFuZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTogW3YxLDMvM10gZHJt
L2FtZC9wbTogdmFuZ29naDogc3VwcG9ydCB0byBzZW5kIFNNVCBlbmFibGUNCj4gbWVzc2FnZQ0K
PiANCj4gT24gMy8yMi8yMDIzIDAwOjQ4LCBXZW55b3UgWWFuZyB3cm90ZToNCj4gPiBBZGQgdGhl
IHN1cHBvcnQgdG8gUFBTTUNfTVNHX1NldENDbGtTTVRFbmFibGUoMHg1OCkgbWVzc2FnZSB0bw0K
PiBwbWZ3DQo+ID4gZm9yIHZhbmdvZ2guDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZW55b3Ug
WWFuZyA8V2VuWW91LllhbmdAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIC4uLi9wbS9zd3NtdS9p
bmMvcG1md19pZi9zbXVfdjExXzVfcHBzbWMuaCAgICB8ICAzICsrLQ0KPiA+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvc211X3R5cGVzLmggIHwgIDMgKystDQo+ID4gICAuLi4v
Z3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvdmFuZ29naF9wcHQuYyAgfCAxOQ0KPiArKysrKysr
KysrKysrKysrKysrDQo+ID4gICAzIGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3BtL3N3c211L2luYy9wbWZ3X2lmL3NtdV92MTFfNV9wcHNtYy5oDQo+ID4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL3N3c211L2luYy9wbWZ3X2lmL3NtdV92MTFfNV9wcHNtYy5oDQo+ID4g
aW5kZXggNzQ3MWUyZGYyODI4Li4yYjE4MmRiYzZmOWMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvcG1md19pZi9zbXVfdjExXzVfcHBzbWMuaA0KPiA+
ICsrKw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvaW5jL3BtZndfaWYvc211X3Yx
MV81X3Bwc21jLmgNCj4gPiBAQCAtMTExLDcgKzExMSw4IEBADQo+ID4gICAjZGVmaW5lIFBQU01D
X01TR19HZXRHZnhPZmZTdGF0dXMJCSAgICAgICAweDUwDQo+ID4gICAjZGVmaW5lIFBQU01DX01T
R19HZXRHZnhPZmZFbnRyeUNvdW50CQkgICAgICAgMHg1MQ0KPiA+ICAgI2RlZmluZSBQUFNNQ19N
U0dfTG9nR2Z4T2ZmUmVzaWRlbmN5CQkgICAgICAgMHg1Mg0KPiA+IC0jZGVmaW5lIFBQU01DX01l
c3NhZ2VfQ291bnQgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHg1Mw0KPiA+ICsjZGVmaW5l
IFBQU01DX01TR19TZXRDQ2xrU01URW5hYmxlCQkgICAgICAgMHg1OA0KPiA+ICsjZGVmaW5lIFBQ
U01DX01lc3NhZ2VfQ291bnQgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHg1NA0KPiANCj4g
VGhpcyBkb2Vzbid0IG1ha2Ugc2Vuc2UgdGhhdCB0aGUgUFBTTUNfTWVzc2FnZV9Db3VudCB3b3Vs
ZCBiZSBzbWFsbGVyDQo+IHRoYW4gdGhlIGJpZ2dlc3QgbWVzc2FnZS4gIFRoaXMgc2hvdWxkIGJl
Og0KPiANCj4gI2RlZmluZSBQUFNNQ19NZXNzYWdlX0NvdW50IDB4NTkNCj4gDQpBY2NlcHRlZC4N
Cg0KVGhhbmtzDQpXZW55b3UNCj4gPg0KPiA+ICAgLy9Bcmd1bWVudCBmb3IgUFBTTUNfTVNHX0dm
eERldmljZURyaXZlclJlc2V0DQo+ID4gICBlbnVtIHsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvc211X3R5cGVzLmgNCj4gPiBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vc3dzbXUvaW5jL3NtdV90eXBlcy5oDQo+ID4gaW5kZXggMjk3YjcwYjkzODhm
Li44MjA4MTJkOTEwYmYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9z
d3NtdS9pbmMvc211X3R5cGVzLmgNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3
c211L2luYy9zbXVfdHlwZXMuaA0KPiA+IEBAIC0yNDUsNyArMjQ1LDggQEANCj4gPiAgIAlfX1NN
VV9EVU1NWV9NQVAoQWxsb3dHcG8pLAlcDQo+ID4gICAJX19TTVVfRFVNTVlfTUFQKE1vZGUyUmVz
ZXQpLAlcDQo+ID4gICAJX19TTVVfRFVNTVlfTUFQKFJlcXVlc3RJMmNUcmFuc2FjdGlvbiksIFwN
Cj4gPiAtCV9fU01VX0RVTU1ZX01BUChHZXRNZXRyaWNzVGFibGUpLA0KPiA+ICsJX19TTVVfRFVN
TVlfTUFQKEdldE1ldHJpY3NUYWJsZSksIFwNCj4gPiArCV9fU01VX0RVTU1ZX01BUChTZXRDQ2xr
U01URW5hYmxlKSwNCj4gPg0KPiA+ICAgI3VuZGVmIF9fU01VX0RVTU1ZX01BUA0KPiA+ICAgI2Rl
ZmluZSBfX1NNVV9EVU1NWV9NQVAodHlwZSkJU01VX01TR18jI3R5cGUNCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS92YW5nb2doX3BwdC5jDQo+ID4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL3ZhbmdvZ2hfcHB0LmMNCj4gPiBp
bmRleCA3NDMzZGNhYTE2ZTAuLmYwZWViNDJkZjk2YiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL3ZhbmdvZ2hfcHB0LmMNCj4gPiArKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL3ZhbmdvZ2hfcHB0LmMNCj4gPiBAQCAtMTQx
LDYgKzE0MSw3IEBAIHN0YXRpYyBzdHJ1Y3QgY21uMmFzaWNfbXNnX21hcHBpbmcNCj4gdmFuZ29n
aF9tZXNzYWdlX21hcFtTTVVfTVNHX01BWF9DT1VOVF0gPSB7DQo+ID4gICAJTVNHX01BUChHZXRH
ZnhPZmZTdGF0dXMsDQo+IFBQU01DX01TR19HZXRHZnhPZmZTdGF0dXMsDQo+IAkwKSwNCj4gPiAg
IAlNU0dfTUFQKEdldEdmeE9mZkVudHJ5Q291bnQsDQo+IFBQU01DX01TR19HZXRHZnhPZmZFbnRy
eUNvdW50LAkJCQkJMCksDQo+ID4gICAJTVNHX01BUChMb2dHZnhPZmZSZXNpZGVuY3ksDQo+IFBQ
U01DX01TR19Mb2dHZnhPZmZSZXNpZGVuY3ksCQkJCQkwKSwNCj4gPiArCU1TR19NQVAoU2V0Q0Ns
a1NNVEVuYWJsZSwNCj4gUFBTTUNfTVNHX1NldENDbGtTTVRFbmFibGUsDQo+IAkwKSwNCj4gPiAg
IH07DQo+ID4NCj4gPiAgIHN0YXRpYyBzdHJ1Y3QgY21uMmFzaWNfbWFwcGluZw0KPiA+IHZhbmdv
Z2hfZmVhdHVyZV9tYXNrX21hcFtTTVVfRkVBVFVSRV9DT1VOVF0gPSB7IEBAIC0yNDI4LDYNCj4g
KzI0MjksMjMgQEAgc3RhdGljIHUzMiB2YW5nb2doX2dldF9nZnhvZmZfZW50cnljb3VudChzdHJ1
Y3QNCj4gc211X2NvbnRleHQgKnNtdSwgdWludDY0X3QgKmVudHINCj4gPiAgIAlyZXR1cm4gcmV0
Ow0KPiA+ICAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbnQgdmFuZ29naF9zZXRfY3B1X3NtdF9lbmFi
bGUoc3RydWN0IHNtdV9jb250ZXh0ICpzbXUsIGJvb2wNCj4gPiArZW5hYmxlKSB7DQo+ID4gKwlp
bnQgcmV0ID0gMDsNCj4gPiArDQo+ID4gKwlpZiAoZW5hYmxlKSB7DQo+ID4gKwkJcmV0ID0gc211
X2Ntbl9zZW5kX3NtY19tc2dfd2l0aF9wYXJhbShzbXUsDQo+ID4gKw0KPiBTTVVfTVNHX1NldEND
bGtTTVRFbmFibGUsDQo+ID4gKwkJCQkJCSAgICAgIDEsIE5VTEwpOw0KPiA+ICsJfSBlbHNlIHsN
Cj4gPiArCQlyZXQgPSBzbXVfY21uX3NlbmRfc21jX21zZ193aXRoX3BhcmFtKHNtdSwNCj4gPiAr
DQo+IFNNVV9NU0dfU2V0Q0Nsa1NNVEVuYWJsZSwNCj4gPiArCQkJCQkJICAgICAgMCwgTlVMTCk7
DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJldDsNCj4gPiArfQ0KPiA+ICsNCj4gPiAg
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgcHB0YWJsZV9mdW5jcyB2YW5nb2doX3BwdF9mdW5jcyA9IHsN
Cj4gPg0KPiA+ICAgCS5jaGVja19md19zdGF0dXMgPSBzbXVfdjExXzBfY2hlY2tfZndfc3RhdHVz
LCBAQCAtMjQ3NCw2DQo+ICsyNDkyLDcgQEANCj4gPiBzdGF0aWMgY29uc3Qgc3RydWN0IHBwdGFi
bGVfZnVuY3MgdmFuZ29naF9wcHRfZnVuY3MgPSB7DQo+ID4gICAJLmdldF9wb3dlcl9saW1pdCA9
IHZhbmdvZ2hfZ2V0X3Bvd2VyX2xpbWl0LA0KPiA+ICAgCS5zZXRfcG93ZXJfbGltaXQgPSB2YW5n
b2doX3NldF9wb3dlcl9saW1pdCwNCj4gPiAgIAkuZ2V0X3ZiaW9zX2Jvb3R1cF92YWx1ZXMgPSBz
bXVfdjExXzBfZ2V0X3ZiaW9zX2Jvb3R1cF92YWx1ZXMsDQo+ID4gKwkuc2V0X2NwdV9zbXRfZW5h
YmxlID0gdmFuZ29naF9zZXRfY3B1X3NtdF9lbmFibGUsDQo+ID4gICB9Ow0KPiA+DQo+ID4gICB2
b2lkIHZhbmdvZ2hfc2V0X3BwdF9mdW5jcyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkNCg==

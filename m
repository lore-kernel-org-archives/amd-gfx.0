Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BD8C6FD20
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 17:50:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 674A910E17F;
	Fri, 24 Mar 2023 17:50:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F041410E180
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 17:49:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZH+JrT19vn7apOiz/9304VaK+oaRfw3yFbV3dp8qyIab3GUO2AK1wzQzsCid4n+98Rub8nQA2BzPXEYLrJxbRCFO78Zuv9o7SHfY28cjXDwRjUkxaNqPf0KB6/HgHTdfQ/khW6uy/b2pvmS0PJS4ziWudvnZg1k3VD0R1hG9zUuxYQzxWXVzdwmuoT53n0CT4Ld41NSCIGnXSNFiE6hKVsSnQs6CDZPzOLOAtURmNv67rll+V20DTbGYF1xMHngJBGsvULN+zubZu2uoqfzFyNC1lZX2pVwbmps0lLDexM3QNINbzx1iewy0EErCvvmgjkEDvn4XN3zociOJMnjuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwff9ZNxgMtgiHQmlltQh2vlkumgmPH2UPzs1K8v6UY=;
 b=DeKSWbuyTo+fjZpDJB/a0zHl+QHpOm9aS01jX+Q0dcqT6SC3KEMzBj/xhrGh15BrFYz4fr8eKkwdYQeS01DrNYlr0Aid0yhTvshEALKpTge1x/z9RQYRefgyH9U3IYa9yOCCryiMaDwH/B2QrAgDaYG7/MHGLWSWQRi1Oe3yFAkxE6C/VIMD/yFDAsHJt+xwI1B6U8zLiKSdh3zZcw79QuOX54d9i+Iw7fGV/TDZf8lnYB0nMd4dFtqE3MMFNH6pYL9mNjkDmcWKf7C+6gL7pz+Tnsu+2OVNT3/9yB2DoHeTNubjwKcoimXsev05w0NPU+6sEZGgsuYi5idauKZPkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwff9ZNxgMtgiHQmlltQh2vlkumgmPH2UPzs1K8v6UY=;
 b=eWS5LmfNoVu/4xd9bhaoU+2oREfyq82VmgLV2+gWOL/zPwXSLqPiCZ5UttaS8cGkuYMLOmgTooy7+2yAUqfIUZNqVlwin9FPCdhKfOQYdVBJbOcrza3+C1znOD4H9tRRsQIlYWZvRupPOAkMSzG6eEbpzVBnvUuQlxQps9OBzj8=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW3PR12MB4394.namprd12.prod.outlook.com (2603:10b6:303:54::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 17:49:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614%9]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 17:49:55 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Yang, WenYou" <WenYou.Yang@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>
Subject: RE: [v1,2/3] drm/amd/pm: send the SMT-enable message to pmfw
Thread-Topic: [v1,2/3] drm/amd/pm: send the SMT-enable message to pmfw
Thread-Index: AQHZXa61BHnd31yqfE6bzv0XKnJ+068IqPOAgACMkACAAQDtkA==
Date: Fri, 24 Mar 2023 17:49:55 +0000
Message-ID: <MN0PR12MB6101644046D01AC2C2A8ED1DE2849@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230322054808.1555230-3-WenYou.Yang@amd.com>
 <2c8c7a2a-566d-22a7-dc9b-5e08fbaf726c@amd.com>
 <07785bf1-80a0-e6db-66a3-eca43c5e945d@amd.com>
 <fb4548f4-098a-c9ed-26ce-4c98d7219773@amd.com>
In-Reply-To: <fb4548f4-098a-c9ed-26ce-4c98d7219773@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-24T17:49:53Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b9a5978c-3134-454d-ab1e-db049851fc35;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-24T17:49:53Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 8a0096ed-7cd6-48bc-bb85-520e089e19f3
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|MW3PR12MB4394:EE_
x-ms-office365-filtering-correlation-id: b464f9ee-5854-4faa-6f07-08db2c902d5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D8ML2zpf0VotNWNkbHqLZExJXqvRj1TWc0dW+mNbpsUqQo3wEfehKl6VXx0+BXunm7rifzDMOcc2QScAlYgdF7jImBIJ9lmJlUmfcWLsFBQPEC+WWaW7sdnYLicPPnBzFwxzdjRZyO5gup6cVEzfbNWAfkl9tnwHFQFkVobZoXR8Sw6zGHwDt3qC3OIAsNwj8TTKG41TaCgOr2OW1O/EYNA+CWBZbrsqWDo2KJKDya8fsEjWu2AJPprPJsUjKpQZfvgeqVtfoqGCMR4l8/6Lf7rlF3ceZd46Bmrp//5DTr4tUl6YrI9HQSCkUSaAnS3UhhYzZLaiRz1etXsQZNbcoq71QboNbh8WHn9ceKM3CIieVmNBZgeTK6WXA2mUxQTPQxubL3xZNG8NLcK5lMQ8vMPBapJMY64F/LJ6w9phcYtcCfGEpnTp5FSLa/bl38tGRRbz/ucs1ALQEghs/WBWNxRQU/I99Yso2inqMnIW5bt46/xgAZ/YdkjZpS5/SFrNgYz5EgPjMbUD8DTI/nSCu4tsjz0FsI+0QJk0b//yf9dvUD+2wUwTVHqYtY9kKQJQfZmwvuWADfQIORJngGl5nMqTbkq+W0e0o6QJPq9IyVyoeoX0DJKYJIvqoq10Lblo47jfEaVarY2QWsN52egoqLEvqvVszTyMdPLwi0d4tSF8bT8cQwUws2jy4TCbwRKXMPD4kw9rstLrlUkcgtEK3IAWHucMTEOcyWjgnBW7MSk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199021)(921005)(2906002)(38100700002)(8676002)(66556008)(64756008)(4326008)(66476007)(66946007)(76116006)(83380400001)(6636002)(54906003)(52536014)(41300700001)(5660300002)(122000001)(15650500001)(110136005)(53546011)(26005)(6506007)(8936002)(7696005)(55016003)(38070700005)(478600001)(33656002)(86362001)(71200400001)(66446008)(9686003)(186003)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTlUTmZ2M0sxQVBwcGN2VFpma3R6N2lsVVl0dmNHazNLTFVRQUc4bUNGUGth?=
 =?utf-8?B?ZlhvVVJBVk5DdTJqTzdQUE1rV09SS29wcjk5Qy9Ba1Irc0QwaXV0V3NoZ0lY?=
 =?utf-8?B?NUVGb0srWEV0b1BHanpaUFlpZ0pzUUEzMXdnN2kyVzdycVlsTUFEbUtnVisy?=
 =?utf-8?B?eGF1eEVkTll2eWZxT1ZkUnpQZWRFVmE4T3AvQk00cTNxTGcrRVRsRGw3aFFG?=
 =?utf-8?B?L1JsVzJLZ1pOQ09oMkdldDJsTjBMeE9WRUxTZlE5UHBPOE1OcjlBbUZ4dVAr?=
 =?utf-8?B?SHREd0o0VE1oRXdoU1VsbkZYNHVQekJScHNmNjFzL0lRVUg2eGJnS29ydElI?=
 =?utf-8?B?SGZtNzI5dmlvUHZjbCtjaDJld1NKQjlsQTJveDJnNEVJWTYyc0VwYkRXQmYr?=
 =?utf-8?B?MzBPQTlBeDRIY2MraXNNbHp3eEhVRm5LSTk4cDRVcklWWXRlRUdkNUhBOTE4?=
 =?utf-8?B?RG1FTnpIeHlmbnRwaXVET2RyV3NWWGsyWkZxTWMrUWFzd01SLzN1cXQ2Unlz?=
 =?utf-8?B?YnNnMEZFNGNXRCs4TFdueUZDb2pZTURrN2p4ZVgrUkV3NmZOUzB1VEUxZ1lU?=
 =?utf-8?B?bWw2RUhzcmVXVDNZRXZqMHVCTldScFlmSTJVQmdqY0ZZM052RkllazNVelZS?=
 =?utf-8?B?QVgxaktnUkZabmtBSVdId2E3Nm82VndzanE5b0dYcndSS2lFOHdUL0tCNjRH?=
 =?utf-8?B?bmFDcnpvR2NZQ2dublA4aFZ3S3JhVFc5ajcvT0ZxWkJoZkF3ckhWY09yWWxZ?=
 =?utf-8?B?NUZ3YUpCaVpiVlVMWXp3Y1hjVlRxWXN4eWZVUkFpRVJ1Tmw0KzRnbk9OUVVN?=
 =?utf-8?B?dHZnT2dTVVBwNGlzQU5mcmRUMFI2alVoZ2JDTkQzZDBJSWdVditVYTV3Vkx0?=
 =?utf-8?B?TEgzaUVUcm14V1FDVTNZRCs5bzRuQzR5bnNra2x1V2FZY2lvM3RZNnkvS1E1?=
 =?utf-8?B?aVcvQ1Npa0NRQ05YK2UyRHd5TXF3RkNDMmtrRjRzRFZPSitOcUxjT3JIWTZl?=
 =?utf-8?B?ZVREYzc5MzI0MmxIUDRDWHBSSGFTa3QxaHRVRzhCd2ZRRGJWU2dhN29jOEJl?=
 =?utf-8?B?cldCeW9JZkV3dXZiZlhITW9pblptQWR4Y1JzU0JVb1ZTdFJhMmV4c21ua213?=
 =?utf-8?B?enF1V1AyamIxbHJLbUxnQ2RCM0czdlRydzNoZDBjc2QwUGNTL1Q1TXIxQnZs?=
 =?utf-8?B?ajcxVm9abEdvTXlTVmthWGdaUEFvQTRRVnhGUDlHTDlEYXVLMkdGVmRLUEN4?=
 =?utf-8?B?bk5Rcmh4VmdjRXBEL3JnWHZjM09PSmloaGhvR3drREhLa2MyUUhmOTRwR21n?=
 =?utf-8?B?eC91OXJRUGdZeUtDLzNqUmYzUTVJVDhWVHpvdHF3K3owRDNtNmhUTzExbEhj?=
 =?utf-8?B?dzNQQk1mZjMrMFdIVW1GdWNmeUQwWGUyelljWkxVV1QyQWd5dGpYUFROSGlv?=
 =?utf-8?B?N1dqK1NxNlI5aDdwaFJPVDltWnNLT0k4a1Z6UTZ6SFFlei9QU1pnUm8vbVFa?=
 =?utf-8?B?UWsycGpLWGhlbEUxQlNnQnZlbzNuWE8xZ25Nc3VQTkFPWERrWk8wVHloRnhz?=
 =?utf-8?B?UHU4d3p6OTErR3kyUGFlUGgybDdzM3poUUVsbEpETFRqOStXQWsxSzJwTlhL?=
 =?utf-8?B?RXVhd0NMb0xQa09NS2RXbTZoZXVjbnZTWWllNzBPOXQ3aVdZN2VrcHNsYUJq?=
 =?utf-8?B?ditsMmlCcWZPeGFkVlFKcTA1ZlB6M1J1OUdPN2UrR3Q5all3dFdNM0dsY0gw?=
 =?utf-8?B?d1hRL2pVLzRIZzlLcm5tdE1VQVhVNWg0RkJNNDBjVlVxS0JMamNuV0RQbXQ0?=
 =?utf-8?B?Y3lJWFA1QlBoR2pEQXFVWFBwK1h5cmxhVmlGY2UzamNxNUxnVC81LzY0UTk5?=
 =?utf-8?B?OXUvS3NBbmVGWUhsTldCZUtaT2dPMWo5LzBONnA0bDUrT1NscXFFYWJoWHNS?=
 =?utf-8?B?SkVyWXN5ank5cWxrYTBtLzJQYWtNMzI0TmFGQzAwcTQvZS9oRDlnUmFKQi8z?=
 =?utf-8?B?Vm4wbDdhTkhTVzNrQlg1UmFheVY3QUtxSSt2Tk5NVE5BYnFXQjdSWTFLa2x5?=
 =?utf-8?B?SmIvWVR5VmhhV25nbkZSakdCcjFVc0JBVW9ZazhKb0o3dFk2R2FWQkcybVdj?=
 =?utf-8?Q?tvKI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b464f9ee-5854-4faa-6f07-08db2c902d5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 17:49:55.0689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Bq9Z82jlfgnvigVN78k+bhtzIun32h6rI9XXnbzI8fzjvTS/2wMs9ZwuOdMmFoYIsOCYuNrzSKmg2aClGXvVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4394
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
Cc: "Li, Ying" <YING.LI@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liang, 
 Richard qi" <Richardqi.Liang@amd.com>, "Liu, Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQo+
IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAyMywgMjAyMyAyMToyOQ0KPiBUbzogTGltb25jaWVsbG8s
IE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPjsgWWFuZywgV2VuWW91DQo+IDxXZW5Z
b3UuWWFuZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hl
ckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4NCj4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNv
bT47IFBhbiwgWGluaHVpIDxYaW5odWkuUGFuQGFtZC5jb20+DQo+IENjOiBMaSwgWWluZyA8WUlO
Ry5MSUBhbWQuY29tPjsgTGl1LCBLdW4gPEt1bi5MaXUyQGFtZC5jb20+OyBMaWFuZywNCj4gUmlj
aGFyZCBxaSA8UmljaGFyZHFpLkxpYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPiBTdWJqZWN0OiBSZTogW3YxLDIvM10gZHJtL2FtZC9wbTogc2VuZCB0aGUgU01U
LWVuYWJsZSBtZXNzYWdlIHRvIHBtZncNCj4gDQo+IA0KPiANCj4gT24gMy8yMy8yMDIzIDExOjM2
IFBNLCBMaW1vbmNpZWxsbywgTWFyaW8gd3JvdGU6DQo+ID4gT24gMy8yMy8yMDIzIDEyOjQxLCBM
aW1vbmNpZWxsbywgTWFyaW8gd3JvdGU6DQo+ID4+IE9uIDMvMjIvMjAyMyAwMDo0OCwgV2VueW91
IFlhbmcgd3JvdGU6DQo+ID4+PiBXaGVuIHRoZSBDUFUgU01UIHN0YXR1cyBjaGFuZ2UgaW4gdGhl
IGZseSwgc2VudCB0aGUgU01ULWVuYWJsZQ0KPiA+Pj4gbWVzc2FnZSB0byBwbWZ3IHRvIG5vdGlm
eSBpdCB0aGF0IHRoZSBTTVQgc3RhdHVzIGNoYW5nZWQuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9m
Zi1ieTogV2VueW91IFlhbmcgPFdlbllvdS5ZYW5nQGFtZC5jb20+DQo+ID4+PiAtLS0NCj4gPj4+
IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jwqDCoMKgwqAgfCA0
MQ0KPiArKysrKysrKysrKysrKysrKysrDQo+ID4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L3N3c211L2luYy9hbWRncHVfc211LmggfMKgIDUgKysrDQo+ID4+PiDCoCAyIGZpbGVzIGNoYW5n
ZWQsIDQ2IGluc2VydGlvbnMoKykNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMNCj4gPj4+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMNCj4gPj4+IGluZGV4IGI1ZDY0NzQ5OTkwZS4uNWNk
ODVhOWQxNDlkIDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3Nt
dS9hbWRncHVfc211LmMNCj4gPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUv
YW1kZ3B1X3NtdS5jDQo+ID4+PiBAQCAtMjIsNiArMjIsNyBAQA0KPiA+Pj4gwqAgI2RlZmluZSBT
V1NNVV9DT0RFX0xBWUVSX0wxDQo+ID4+PiArI2luY2x1ZGUgPGxpbnV4L2NwdS5oPg0KPiA+Pj4g
wqAgI2luY2x1ZGUgPGxpbnV4L2Zpcm13YXJlLmg+DQo+ID4+PiDCoCAjaW5jbHVkZSA8bGludXgv
cGNpLmg+DQo+ID4+PiBAQCAtNjksNiArNzAsMTQgQEAgc3RhdGljIGludCBzbXVfc2V0X2Zhbl9z
cGVlZF9ycG0odm9pZCAqaGFuZGxlLA0KPiA+Pj4gdWludDMyX3Qgc3BlZWQpOw0KPiA+Pj4gwqAg
c3RhdGljIGludCBzbXVfc2V0X2dmeF9jZ3BnKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBib29s
IGVuYWJsZWQpOw0KPiA+Pj4gwqAgc3RhdGljIGludCBzbXVfc2V0X21wMV9zdGF0ZSh2b2lkICpo
YW5kbGUsIGVudW0gcHBfbXAxX3N0YXRlDQo+ID4+PiBtcDFfc3RhdGUpOw0KPiA+Pj4gK3N0YXRp
YyBpbnQgc210X25vdGlmaWVyX2NhbGxiYWNrKHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIsIHVu
c2lnbmVkDQo+ID4+PiBsb25nIGFjdGlvbiwgdm9pZCAqZGF0YSk7DQo+ID4+PiArDQo+ID4+PiAr
ZXh0ZXJuIHN0cnVjdCByYXdfbm90aWZpZXJfaGVhZCBzbXRfbm90aWZpZXJfaGVhZDsNCj4gPj4+
ICsNCj4gPj4+ICtzdGF0aWMgc3RydWN0IG5vdGlmaWVyX2Jsb2NrIHNtdF9ub3RpZmllciA9IHsN
Cj4gPj4+ICvCoMKgwqAgLm5vdGlmaWVyX2NhbGwgPSBzbXRfbm90aWZpZXJfY2FsbGJhY2ssDQo+
ID4+PiArfTsNCj4gPj4+ICsNCj4gPj4+IMKgIHN0YXRpYyBpbnQgc211X3N5c19nZXRfcHBfZmVh
dHVyZV9tYXNrKHZvaWQgKmhhbmRsZSwNCj4gPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjaGFyICpidWYpDQo+ID4+PiDCoCB7DQo+ID4+PiBAQCAt
NjI1LDYgKzYzNCw4IEBAIHN0YXRpYyBpbnQgc211X3NldF9mdW5jcyhzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZQ0KPiAqYWRldikNCj4gPj4+IMKgwqDCoMKgwqAgcmV0dXJuIDA7DQo+ID4+PiDCoCB9DQo+
ID4+PiArc3RhdGljIHN0cnVjdCBzbXVfY29udGV4dCAqY3VycmVudF9zbXU7DQo+ID4+PiArDQo+
ID4+PiDCoCBzdGF0aWMgaW50IHNtdV9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkNCj4gPj4+IMKg
IHsNCj4gPj4+IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7DQo+ID4+PiBAQCAtNjQ1LDYgKzY1Niw3IEBAIHN0YXRp
YyBpbnQgc211X2Vhcmx5X2luaXQodm9pZCAqaGFuZGxlKQ0KPiA+Pj4gwqDCoMKgwqDCoCBtdXRl
eF9pbml0KCZzbXUtPm1lc3NhZ2VfbG9jayk7DQo+ID4+PiDCoMKgwqDCoMKgIGFkZXYtPnBvd2Vy
cGxheS5wcF9oYW5kbGUgPSBzbXU7DQo+ID4+PiArwqDCoMKgIGN1cnJlbnRfc211ID0gc211Ow0K
PiA+DQo+ID4gQWx0aG91Z2ggdGhpcyBzZXJpZXMgaXMgaW50ZW5kZWQgZm9yIHRoZSBWYW4gR29n
aCBjYXNlIHJpZ2h0IG5vdywgSQ0KPiA+IGRvbnQndCB0aGluayB0aGlzIHdvdWxkIHNjYWxlIHdl
bGwgZm9yIG11bHRpcGxlIEdQVXMgaW4gYSBzeXN0ZW0uDQo+ID4NCj4gPiBJIHRoaW5rIHRoYXQg
aW5zdGVhZCB5b3UgbWF5IHdhbnQgdG8gbW92ZSB0aGUgbm90aWZpZXIgY2FsbGJhY2sgdG8gYmUg
YQ0KPiA+IGxldmVsICJoaWdoZXIiIGluIGFtZGdwdS7CoCBQZXJoYXBzIGFtZGdwdV9kZXZpY2Uu
Yz/CoCBUaGVuIHdoZW4gdGhhdA0KPiA+IG5vdGlmaWVyIGNhbGwgaXMgcmVjZWl2ZWQgeW91J2xs
IHdhbnQgdG8gd2FsayB0aHJvdWdoIHRoZSBQQ0kgZGV2aWNlDQo+ID4gc3BhY2UgdG8gZmluZCBh
bnkgR1BVcyB0aGF0IGFyZSBib3VuZCB3aXRoIEFNREdQVSBhIHNlcmllcyBvZg0KPiA+IHdyYXBw
ZXJzL2NhbGxzIHRoYXQgZW5kIHVwIGNhbGxpbmcgc211X3NldF9jcHVfc210X2VuYWJsZSB3aXRo
IHRoZQ0KPiA+IGFwcHJvcmlhdGUgYXJndW1lbnRzLg0KPiA+DQo+IA0KPiBUaGlzIGlzIG5vdCBy
ZXF1aXJlZCB3aGVuIHRoZSBub3RpZmllciBpcyByZWdpc3RlcmVkIG9ubHkgd2l0aGluIFZhbmdv
Z2gNCj4gcHB0IGZ1bmN0aW9uLiBUaGVuIGZvbGxvdyBFdmFuJ3Mgc3VnZ2VzdGlvbiBvZiBrZWVw
aW5nIHRoZSBub3RpZmllcg0KPiBibG9jayBpbnNpZGUgc211LiBGcm9tIHRoZSBub3RpZmllciBi
bG9jaywgaXQgY2FuIGZpbmQgdGhlIHNtdSBibG9jayBhbmQNCj4gdGhlbiBjYWxsIGNwdV9zbXRf
ZW5hYmxlL2Rpc2FibGUuIFRoYXQgd2F5IG5vdGlmaWVyIGNhbGxiYWNrIGNvbWVzIG9ubHkNCj4g
b25jZSBldmVuIHdpdGggbXVsdGlwbGUgZEdQVXMgKyBWYW5nb2doIGFuZCBwcm9jZXNzZWQgZm9y
IHRoZQ0KPiBjb3JyZXNwb25kaW5nIHNtdS4NCj4gDQo+IFRoaXMgbm90aWZpZXIgZG9lc24ndCBu
ZWVkIHRvIGJlIHJlZ2lzdGVyZWQgZm9yIHBsYXRmb3JtcyBvbmx5IHdpdGgNCj4gZEdQVXMgb3Ig
QVBVcyB3aGljaCBkb24ndCBuZWVkIHRoaXMuDQoNClRoZXkgZG9uJ3QgcmlnaHQgbm93LCBidXQg
SSB3YXMgdGhpbmtpbmcgaG93IHRoaXMgY291bGQgc2NhbGUgdG8gb3RoZXINCkFQVXMgb3IgZEdQ
VXMgaWYgdGhleSBhcmUgaW50ZXJlc3RlZCBpbiBhZGRpbmcgc3VwcG9ydCBmb3IgdGhpcyBtZXNz
YWdlDQp0b28uDQoNCj4gDQo+IFRoYW5rcywNCj4gTGlqbw0KPiANCj4gPg0KPiA+Pj4gwqDCoMKg
wqDCoCBhZGV2LT5wb3dlcnBsYXkucHBfZnVuY3MgPSAmc3dzbXVfcG1fZnVuY3M7DQo+ID4+PiDC
oMKgwqDCoMKgIHIgPSBzbXVfc2V0X2Z1bmNzKGFkZXYpOw0KPiA+Pj4gQEAgLTExMDUsNiArMTEx
Nyw4IEBAIHN0YXRpYyBpbnQgc211X3N3X2luaXQodm9pZCAqaGFuZGxlKQ0KPiA+Pj4gwqDCoMKg
wqDCoCBpZiAoIXNtdS0+cHB0X2Z1bmNzLT5nZXRfZmFuX2NvbnRyb2xfbW9kZSkNCj4gPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCBzbXUtPmFkZXYtPnBtLm5vX2ZhbiA9IHRydWU7DQo+ID4+PiArwqDC
oMKgIHJhd19ub3RpZmllcl9jaGFpbl9yZWdpc3Rlcigmc210X25vdGlmaWVyX2hlYWQsICZzbXRf
bm90aWZpZXIpOw0KPiA+Pj4gKw0KPiA+Pj4gwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4gPj4+IMKg
IH0NCj4gPj4+IEBAIC0xMTIyLDYgKzExMzYsOCBAQCBzdGF0aWMgaW50IHNtdV9zd19maW5pKHZv
aWQgKmhhbmRsZSkNCj4gPj4+IMKgwqDCoMKgwqAgc211X2ZpbmlfbWljcm9jb2RlKHNtdSk7DQo+
ID4+PiArwqDCoMKgIHJhd19ub3RpZmllcl9jaGFpbl91bnJlZ2lzdGVyKCZzbXRfbm90aWZpZXJf
aGVhZCwgJnNtdF9ub3RpZmllcik7DQo+ID4+PiArDQo+ID4+PiDCoMKgwqDCoMKgIHJldHVybiAw
Ow0KPiA+Pj4gwqAgfQ0KPiA+Pj4gQEAgLTMyNDEsMyArMzI1NywyOCBAQCBpbnQgc211X3NlbmRf
aGJtX2JhZF9jaGFubmVsX2ZsYWcoc3RydWN0DQo+ID4+PiBzbXVfY29udGV4dCAqc211LCB1aW50
MzJfdCBzaXplKQ0KPiA+Pj4gwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPiA+Pj4gwqAgfQ0KPiA+
Pj4gKw0KPiA+Pj4gK3N0YXRpYyBpbnQgc211X3NldF9jcHVfc210X2VuYWJsZShzdHJ1Y3Qgc211
X2NvbnRleHQgKnNtdSwgYm9vbA0KPiBlbmFibGUpDQo+ID4+PiArew0KPiA+Pj4gK8KgwqDCoCBp
bnQgcmV0ID0gLUVJTlZBTDsNCj4gPj4+ICsNCj4gPj4+ICvCoMKgwqAgaWYgKHNtdS0+cHB0X2Z1
bmNzICYmIHNtdS0+cHB0X2Z1bmNzLT5zZXRfY3B1X3NtdF9lbmFibGUpDQo+ID4+PiArwqDCoMKg
wqDCoMKgwqAgcmV0ID0gc211LT5wcHRfZnVuY3MtPnNldF9jcHVfc210X2VuYWJsZShzbXUsIGVu
YWJsZSk7DQo+ID4+PiArDQo+ID4+PiArwqDCoMKgIHJldHVybiByZXQ7DQo+ID4+PiArfQ0KPiA+
Pj4gKw0KPiA+Pj4gK3N0YXRpYyBpbnQgc210X25vdGlmaWVyX2NhbGxiYWNrKHN0cnVjdCBub3Rp
Zmllcl9ibG9jayAqbmIsDQo+ID4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dW5zaWduZWQgbG9uZyBhY3Rpb24sIHZvaWQgKmRhdGEpDQo+ID4+PiArew0KPiA+Pj4gK8KgwqDC
oCBzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSA9IGN1cnJlbnRfc211Ow0KPiA+Pj4gK8KgwqDCoCBp
bnQgcmV0ID0gTk9USUZZX09LOw0KPiA+Pg0KPiA+PiBUaGlzIGluaXRpYWxpemF0aW9uIGlzIHBv
aW50bGVzcywgaXQncyBjbG9iYmVyZWQgaW4gdGhlIG5leHQgbGluZS4NCj4gPj4NCj4gPj4+ICsN
Cj4gPj4+ICvCoMKgwqAgcmV0ID0gKGFjdGlvbiA9PSBTTVRfRU5BQkxFRCkgPw0KPiA+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzbXVfc2V0X2NwdV9zbXRfZW5hYmxlKHNtdSwg
dHJ1ZSkgOg0KPiA+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzbXVfc2V0X2Nw
dV9zbXRfZW5hYmxlKHNtdSwgZmFsc2UpOw0KPiA+Pg0KPiA+PiBIb3cgYWJvdXQgdGhpcyBpbnN0
ZWFkLCBpdCBzaG91bGQgYmUgbW9yZSByZWFkYWJsZToNCj4gPj4NCj4gPj4gwqDCoMKgwqDCoHJl
dCA9IHNtdV9zZXRfY3B1X3NtdF9lbmFibGUoc211LCBhY3Rpb24gPT0gU01UX0VOQUJMRUQpOw0K
PiA+Pg0KPiA+Pj4gK8KgwqDCoCBpZiAocmV0KQ0KPiA+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldCA9
IE5PVElGWV9CQUQ7DQo+ID4+PiArDQo+ID4+PiArwqDCoMKgIHJldHVybiByZXQ7DQo+ID4+DQo+
ID4+IEhvdyBhYm91dCBpbnN0ZWFkOg0KPiA+Pg0KPiA+PiDCoMKgwqDCoMKgZGV2X2RiZyhhZGV2
LT5kZXYsICJmYWlsZWQgdG8gJXNhYmxlIFNNVDogJWRcbiIsIGFjdGlvbiA9PQ0KPiA+PiBTTVRf
RU5BQkxFRCA/ICJlbiIgOiAiZGlzIiwgcmV0KTsNCj4gPj4NCj4gPj4gwqDCoMKgwqDCoHJldHVy
biByZXQgPyBOT1RJRllfQkFEIDogTk9USUZZX09LOw0KPiA+Pg0KPiA+Pj4gK30NCj4gPj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L2luYy9hbWRncHVfc211LmgN
Cj4gPj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvYW1kZ3B1X3NtdS5oDQo+
ID4+PiBpbmRleCAwOTQ2OWM3NTBhOTYuLjdjNjU5NGJiYTc5NiAxMDA2NDQNCj4gPj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvaW5jL2FtZGdwdV9zbXUuaA0KPiA+Pj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvYW1kZ3B1X3NtdS5oDQo+ID4+PiBA
QCAtMTM1NCw2ICsxMzU0LDExIEBAIHN0cnVjdCBwcHRhYmxlX2Z1bmNzIHsNCj4gPj4+IMKgwqDC
oMKgwqDCoCAqIEBpbml0X3BwdGFibGVfbWljcm9jb2RlOiBQcmVwYXJlIHRoZSBwcHRhYmxlIG1p
Y3JvY29kZSB0bw0KPiA+Pj4gdXBsb2FkIHZpYSBQU1ANCj4gPj4+IMKgwqDCoMKgwqDCoCAqLw0K
PiA+Pj4gwqDCoMKgwqDCoCBpbnQgKCppbml0X3BwdGFibGVfbWljcm9jb2RlKShzdHJ1Y3Qgc211
X2NvbnRleHQgKnNtdSk7DQo+ID4+PiArDQo+ID4+PiArwqDCoMKgIC8qKg0KPiA+Pj4gK8KgwqDC
oMKgICogQHNldF9jcHVfc210X2VuYWJsZTogU2V0IHRoZSBDUFUgU01UIHN0YXR1cw0KPiA+Pj4g
K8KgwqDCoMKgICovDQo+ID4+PiArwqDCoMKgIGludCAoKnNldF9jcHVfc210X2VuYWJsZSkoc3Ry
dWN0IHNtdV9jb250ZXh0ICpzbXUsIGJvb2wgZW5hYmxlKTsNCj4gPj4+IMKgIH07DQo+ID4+PiDC
oCB0eXBlZGVmIGVudW0gew0KPiA+Pg0KPiA+DQo=

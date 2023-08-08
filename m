Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C78C001B0
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 08:38:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E518810E3CB;
	Tue,  8 Aug 2023 08:38:31 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E44CC10E3CB
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 08:38:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lFyWrsrj64gYfiJ3ufve/TcfYqHW6Z+MmRpgWDgBH6r7/OKYoLLcfESRrKVKLpaMe5m5tjO5PiSmYRIR0R2DakwNkn6xJUDqSXqFsZlGp7l6IPsCHdnmV/1hlpcpgsaa8j/5PlZlD8sIKvu+yYmE69QWI7UPFtoqYXeeAheKvgER7FpN3kxIUlzB/otGTzERER2iOJt8T0mV4lrMlvQUQ/jQPR98UUISuhUWhnYIlZYHrbWnT6bTcxU9mLQVWHV7qwNAmRQh3Sl6g3wF1VB26BT0H2ZxzbtWJ+a2i49b0lmxIAGUaTpP97SFjFdupi7AUdUkBParYTMCuElV4U+Zww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8CKnN6cAVPBr3d9IAF52Xc+/i40zlItAvf4bRvh3Eo=;
 b=jLnCoOtYVRUOE9drFKKy1/AOaK6B+UPJ1WnvFcez5bZj0g71FTwHvu3ZhBNGGDUsqYcfQtCcug6n6+RwWpMlHoaviocMPgOwUhe83VNvE0V7YhZKKPA+VRCuG/Nvlo2gB3/sAFrugYwDx147dxibQrRVij+v7q+LQ9tSBr+GYUi9yqyKeH3V0dcMzFe3kjza90fNO/Vsq/32Z9gWAfJSvVwN5ZU548ujWrc+I0QbstiKuXckPZMVmf5VxAuWfg9BeKh34iJThc1vPCJZFS2G4yeiZA6trc3nGIs10o+qrIZa8nACT3JjCu3W+MVgcQhBKKY13MgJSwiQ3tDkRo/3iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8CKnN6cAVPBr3d9IAF52Xc+/i40zlItAvf4bRvh3Eo=;
 b=nyHgD1G3Vj0GAYW772XSIC6jVzIyRysjJ+yL3ldTF/x20QEpkEEJgPSGW/iUwkU+eawxhmaOYsmfXkSoXiUJQx+PiN4Mvg+0S2WVisp+ibU3sdnx23CZTWv1LM9hHj5EuH2jPjsacI1o9mJh6TZEyLvw8k8bSu0qRmg/3PKPMDU=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.47; Tue, 8 Aug 2023 08:38:26 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::ed2a:4807:1825:170f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::ed2a:4807:1825:170f%5]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 08:38:22 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Umio Yasuno <coelacanth_dream@protonmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] fix throttle_status for other than MP0 11.0.7
Thread-Topic: [PATCH] fix throttle_status for other than MP0 11.0.7
Thread-Index: AQHZycNG3USnhkbxq0uE2luWavI2ya/gE8cQ
Date: Tue, 8 Aug 2023 08:38:22 +0000
Message-ID: <DM6PR12MB26194F879FCE037C745B6D97E40DA@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230808064025.1008680-1-coelacanth_dream@protonmail.com>
In-Reply-To: <20230808064025.1008680-1-coelacanth_dream@protonmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=1adc142d-0ffc-4d37-8e21-d3e9bed8c260;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-08T08:38:06Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|PH0PR12MB5677:EE_
x-ms-office365-filtering-correlation-id: b5a06e18-4ed1-4e13-ec21-08db97ead31a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /QJx/wngnJLOk/1uKiVYW6/ipQ137baXujz1hcz00m0KZJly2wi8QhyXZz2UFQr4Mt+FEdPgBbn+ZOo3jX1sgJj1N0qHYgU2KjsfLAWWxAdCMH0+N1zyZimdubLHuSAO65S7Yam8CaI56pS5gRSxDpHnlW9V+tH27Nq47wFjW8PJUk75uFChXL3PSIXLFUIXbL8UJurM4TxsstNhr28Ny2CyUdfCDa4VbfXM0sGwhlFtfhs90YVc2WVUuq0MVEAigJCekggiYZ2WWw3b6ubKxBr4/Cp40QIRkk2m8yagKqlbpm0mIuRb94MxDg9StZgjR++6aPpH4aHWHJL9cNPczBuJmE1PHnLvEZc8CQkidaB8z7Vf+3Qu88NsfDdug0nyhPtHpxCkswk3xULRzBgZh6xn62WcdDXy81lPJ96IVFXmKA3XeJWuKpIadNtt9EwWM4Iwsvkt5fZJ5n+dtjMxkFgrstt8LCEvh4L8vuSkfHRFutH/ok8jLG2Tv6sugZmQshVfv8vNygihX6YYOjR8JhzPQqw80pmXr9R9wB1WUNTnTwhsPEFrRplJKSyos/oMy79gv+cuBvM9CCLGrLH/IRGTI1cCHzbnkwolkfGxfxk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199021)(186006)(1800799003)(8936002)(8676002)(53546011)(26005)(6506007)(41300700001)(83380400001)(33656002)(2906002)(38100700002)(122000001)(38070700005)(86362001)(52536014)(55016003)(5660300002)(76116006)(66446008)(66946007)(66556008)(64756008)(66476007)(478600001)(4326008)(966005)(110136005)(54906003)(71200400001)(9686003)(316002)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2N2M0xBWmRDSmcxSmJxdm4rOG5jUFlLWk85MW5DVW5uRGI1cnJ1UTY0SldT?=
 =?utf-8?B?NVVKem82SzgzL0x0SUpXNkxOdHpjUzI4WTl1OHh4Q0dNMzh1aU5tTXljUngz?=
 =?utf-8?B?dmNHVTlRdXhocEdITFJkblZJN0pwemliYTN5K0RvVTZ4SEliM3Q5b1FKU09n?=
 =?utf-8?B?TGlvKzJHdkUrYXZNQ25YMG5BbEJSdnJVdm83RVhNdlF5YzFLVjY2ZzJ3a0FT?=
 =?utf-8?B?cURuSEpqZk1YZ1l2MlZpY2J6ckZORlM5UWJ1SXU1eFRjUDB6WXAzcDJhY0ly?=
 =?utf-8?B?aStzcE5xMnBIZ25PWGViWjh4RlNkcjNPYTN2NWN4b25QZjZMUEtHd256eWIx?=
 =?utf-8?B?ckpvdjJjZmJiazMyeHhVWU1sUVU1S2p3MHUyQTJlKzM0Q2cxUXBLRk9kRmRZ?=
 =?utf-8?B?a0lueUxJQWVxMWJ1WlZIOSs1NFQvTzhXS3c2cEt1WnRCOTN6RlRHeVpNUStL?=
 =?utf-8?B?Yll0U0lIZGJ4b2h1RkVzdkFKV0h3bDcrY3REbmlrMFovWnM2YXdObHhCYjRV?=
 =?utf-8?B?aTE1UnZsUkFQa1FXNjFnQmdtTGhpZEdPOEFmRk1ZdVp0OU42REI0R0srZzB3?=
 =?utf-8?B?S01Vb1pqOGxhRldqMGMxeUZBQU5RRmNrQ0FsU2tkeTJJUFFBaXc3WGlqaTRO?=
 =?utf-8?B?VDVvanRoWThXV0hkeEd6L05oRmYzQW9HWjBDNlFXcjkycHZPQWc5bG8zR3hm?=
 =?utf-8?B?bHBzOVBMOWdLbnE1OU5MWDl3MHJuRTRETGtSYVB2SS9SOGp4aDM2OW0xcjVP?=
 =?utf-8?B?R3NHZzVvR2pkN2FsZlRrYjh2Y3BaMlpYaUlYNS8wMHdjRU5vUkdhSHlIVmNt?=
 =?utf-8?B?eThsWTBJcjFmY045T1d2djFiZDh1SVFXbjNLNjlRK0RjWTJuMkRhOWZmMFZi?=
 =?utf-8?B?R3RRYXRKNnI5WnhKd2psWW8rL0Y3dHBSVU1NRmxobFhiZzh5dWxKUXdiTG1H?=
 =?utf-8?B?cE1Yd0xZVnByenFvYzZUeGZUQ2JycjZ4TU5xbS82K1J0QzFIWDZ1Z3ZtUUdR?=
 =?utf-8?B?VXd6djF3c2N6ZXFzVlkvU0tPamNVLytIV3d1ZW8reFNXNzRablc0ZXNsbUpC?=
 =?utf-8?B?eFFsTHhCT1l4SUJhSFBtOXlEM1puQnQxZVpkbTVWbEpQTU9JVnNtZzNEYTg1?=
 =?utf-8?B?Q2pIUHp6U081UGN5eVlpc2RXTlBMN1BqSjgxS0U2REY5Z2c1TVRBaDJVL0Nl?=
 =?utf-8?B?S09xVUlsVTE1QlppRGdUVzE5Si9RWHlNcHE3dHJFaDlDSThDMkE1ZXhGRHB5?=
 =?utf-8?B?QWpzV2RJbm9rcFFVRmlpc0NvWEYvQUN1b200L1YzTkpKZXU2QmZ0VEpGV1Zv?=
 =?utf-8?B?MGZHTi9qRy9KVWx1VklDbU92ZkZTQXZWRkJSWjVyMGI5UWFGTjhVeEJoVkVH?=
 =?utf-8?B?Y2lxa3ExM2thNGRyUGc1TTM2ZDRZUXNTSEdvakFFNXhpblQyYlRxYSthWW5q?=
 =?utf-8?B?NkliSWJyWjZxbnFsQlRvRXdrdDV1THBmVEJsTmh2QTVPN1RlbW9PeTNkZjMz?=
 =?utf-8?B?Sk5wRDBZZjZOUmNnZVVxd2hDUTJVZjRMcDZVSHBmSWJyWWNmN29OUHhxQ0Zm?=
 =?utf-8?B?bml2UUtEUWlka0dHMERYWXZLKzd5a3ZjUmJHTllwS2ZiUXk4d3RZTkx1cnN1?=
 =?utf-8?B?R2xBVDR1VW1zMmlyTjdRcWpDbWpJTG5vcWlWSUdtazY1MDRxeDMwY1FpSEZX?=
 =?utf-8?B?MkhZY0p6QUk1Nyt4TGtNYWg3K3ZIQlBTV2h2eXkzc1VKTUdxcjhPWDNNWXFa?=
 =?utf-8?B?OFh0WmxCNE1vY2Zkdm9QM1hNeUh1ZnEvdTlwRkEwZnhhWmh0VmlKRGIyL0Rw?=
 =?utf-8?B?NXlGUGlza3VhNHF1K3hBTmxUOXRaMFExS3pSUndDWCtCcHQ0Q1dnSnJIU2M2?=
 =?utf-8?B?RzBpYzVRUER2ODlwb0RQKzRpUi9OVDV1WGM1SFRJakNpL0NnQU9uNnhscUtn?=
 =?utf-8?B?SHlJYnFxd3V2Q2s4cDlRSGhCa2c3MC9jUjk4TlFhRit6TnUwNVhvZ3h4UHhU?=
 =?utf-8?B?YmRMUkFjcURJRGJjT1lnZEYxcDFkZXYxTjFVWHp2MmtwOURHUWZpQ3VWM2pC?=
 =?utf-8?B?d2tGbFRjRGpGc3lTaEp5T1dGN0FoVVUyWGRBNHNDWlBWM0pwZUFKaXRWOFZ2?=
 =?utf-8?Q?soRM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a06e18-4ed1-4e13-ec21-08db97ead31a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 08:38:22.2702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lKj7khOx2gvzk0bjUvAtE3ghzmO5zNlmmS+AGSi847rdQabWwI3ONtlD0iZVnXAR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJldmlld2VkLWJ5OiBFdmFuIFF1
YW4gPGV2YW4ucXVhbkBhbWQuY29tPg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IFVtaW8gWWFzdW5vIDxjb2VsYWNhbnRoX2RyZWFtQHByb3Rvbm1haWwuY29tPg0KPiBT
ZW50OiBUdWVzZGF5LCBBdWd1c3QgOCwgMjAyMyAyOjQxIFBNDQo+IFRvOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tPjsgUXVhbiwgRXZhbg0KPiA8RXZhbi5RdWFuQGFtZC5jb20+OyBMaW1vbmNp
ZWxsbywgTWFyaW8gPE1hcmlvLkxpbW9uY2llbGxvQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRD
SF0gZml4IHRocm90dGxlX3N0YXR1cyBmb3Igb3RoZXIgdGhhbiBNUDAgMTEuMC43DQo+DQo+IExp
bms6IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vYW1kLy0vaXNzdWVzLzI3MjAN
Cj4gU2lnbmVkLW9mZi1ieTogVW1pbyBZYXN1bm8gPGNvZWxhY2FudGhfZHJlYW1AcHJvdG9ubWFp
bC5jb20+DQo+IC0tLQ0KPiAgLi4uL2RybS9hbWQvcG0vc3dzbXUvc211MTEvc2llbm5hX2NpY2hs
aWRfcHB0LmMgICAgfCAxNCArKysrKysrLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5z
ZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vc3dzbXUvc211MTEvc2llbm5hX2NpY2hsaWRfcHB0LmMNCj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL3NpZW5uYV9jaWNobGlkX3BwdC5jDQo+IGluZGV4
IDg1ZDUzNTk3ZS4uNTQ4ZDI1Y2YzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L3BtL3N3c211L3NtdTExL3NpZW5uYV9jaWNobGlkX3BwdC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvcG0vc3dzbXUvc211MTEvc2llbm5hX2NpY2hsaWRfcHB0LmMNCj4gQEAgLTU3OCw3
ICs1NzgsOSBAQCBzdGF0aWMgaW50IHNpZW5uYV9jaWNobGlkX3RhYmxlc19pbml0KHN0cnVjdA0K
PiBzbXVfY29udGV4dCAqc211KQ0KPiAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gIH0NCj4NCj4g
LXN0YXRpYyB1aW50MzJfdCBzaWVubmFfY2ljaGxpZF9nZXRfdGhyb3R0bGVyX3N0YXR1c19sb2Nr
ZWQoc3RydWN0DQo+IHNtdV9jb250ZXh0ICpzbXUpDQo+ICtzdGF0aWMgdWludDMyX3Qgc2llbm5h
X2NpY2hsaWRfZ2V0X3Rocm90dGxlcl9zdGF0dXNfbG9ja2VkKHN0cnVjdA0KPiBzbXVfY29udGV4
dCAqc211LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBib29sDQo+IHVzZV9tZXRyaWNzX3YzLA0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sDQo+IHVzZV9tZXRyaWNz
X3YyKQ0KPiAgew0KPiAgICAgICBzdHJ1Y3Qgc211X3RhYmxlX2NvbnRleHQgKnNtdV90YWJsZT0g
JnNtdS0+c211X3RhYmxlOw0KPiAgICAgICBTbXVNZXRyaWNzRXh0ZXJuYWxfdCAqbWV0cmljc19l
eHQgPQ0KPiBAQCAtNTg2LDEzICs1ODgsMTEgQEAgc3RhdGljIHVpbnQzMl90DQo+IHNpZW5uYV9j
aWNobGlkX2dldF90aHJvdHRsZXJfc3RhdHVzX2xvY2tlZChzdHJ1Y3Qgc211X2NvbnRleHQgKnMN
Cj4gICAgICAgdWludDMyX3QgdGhyb3R0bGVyX3N0YXR1cyA9IDA7DQo+ICAgICAgIGludCBpOw0K
Pg0KPiAtICAgICBpZiAoKHNtdS0+YWRldi0+aXBfdmVyc2lvbnNbTVAxX0hXSVBdWzBdID09IElQ
X1ZFUlNJT04oMTEsIDAsIDcpKQ0KPiAmJg0KPiAtICAgICAgICAgIChzbXUtPnNtY19md192ZXJz
aW9uID49IDB4M0E0OTAwKSkgew0KPiArICAgICBpZiAodXNlX21ldHJpY3NfdjMpIHsNCj4gICAg
ICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgVEhST1RUTEVSX0NPVU5UOyBpKyspDQo+ICAgICAg
ICAgICAgICAgICAgICAgICB0aHJvdHRsZXJfc3RhdHVzIHw9DQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIChtZXRyaWNzX2V4dC0NCj4gPlNtdU1ldHJpY3NfVjMuVGhyb3R0bGluZ1Bl
cmNlbnRhZ2VbaV0gPyAxVSA8PCBpIDogMCk7DQo+IC0gICAgIH0gZWxzZSBpZiAoKHNtdS0+YWRl
di0+aXBfdmVyc2lvbnNbTVAxX0hXSVBdWzBdID09IElQX1ZFUlNJT04oMTEsDQo+IDAsIDcpKSAm
Jg0KPiAtICAgICAgICAgIChzbXUtPnNtY19md192ZXJzaW9uID49IDB4M0E0MzAwKSkgew0KPiAr
ICAgICB9IGVsc2UgaWYgKHVzZV9tZXRyaWNzX3YyKSB7DQo+ICAgICAgICAgICAgICAgZm9yIChp
ID0gMDsgaSA8IFRIUk9UVExFUl9DT1VOVDsgaSsrKQ0KPiAgICAgICAgICAgICAgICAgICAgICAg
dGhyb3R0bGVyX3N0YXR1cyB8PQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAobWV0
cmljc19leHQtDQo+ID5TbXVNZXRyaWNzX1YyLlRocm90dGxpbmdQZXJjZW50YWdlW2ldID8gMVUg
PDwgaSA6IDApOw0KPiBAQCAtODU0LDcgKzg1NCw3IEBAIHN0YXRpYyBpbnQgc2llbm5hX2NpY2hs
aWRfZ2V0X3NtdV9tZXRyaWNzX2RhdGEoc3RydWN0DQo+IHNtdV9jb250ZXh0ICpzbXUsDQo+ICAg
ICAgICAgICAgICAgICAgICAgICBtZXRyaWNzLT5UZW1wZXJhdHVyZVZyU29jKSAqDQo+IFNNVV9U
RU1QRVJBVFVSRV9VTklUU19QRVJfQ0VOVElHUkFERVM7DQo+ICAgICAgICAgICAgICAgYnJlYWs7
DQo+ICAgICAgIGNhc2UgTUVUUklDU19USFJPVFRMRVJfU1RBVFVTOg0KPiAtICAgICAgICAgICAg
ICp2YWx1ZSA9IHNpZW5uYV9jaWNobGlkX2dldF90aHJvdHRsZXJfc3RhdHVzX2xvY2tlZChzbXUp
Ow0KPiArICAgICAgICAgICAgICp2YWx1ZSA9IHNpZW5uYV9jaWNobGlkX2dldF90aHJvdHRsZXJf
c3RhdHVzX2xvY2tlZChzbXUsDQo+IHVzZV9tZXRyaWNzX3YzLCB1c2VfbWV0cmljc192Mik7DQo+
ICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgIGNhc2UgTUVUUklDU19DVVJSX0ZBTlNQRUVE
Og0KPiAgICAgICAgICAgICAgICp2YWx1ZSA9IHVzZV9tZXRyaWNzX3YzID8gbWV0cmljc192My0+
Q3VyckZhblNwZWVkIDoNCj4gQEAgLTQwNTYsNyArNDA1Niw3IEBAIHN0YXRpYyBzc2l6ZV90DQo+
IHNpZW5uYV9jaWNobGlkX2dldF9ncHVfbWV0cmljcyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSwN
Cj4gICAgICAgZ3B1X21ldHJpY3MtPmN1cnJlbnRfZGNsazEgPSB1c2VfbWV0cmljc192MyA/IG1l
dHJpY3NfdjMtDQo+ID5DdXJyQ2xvY2tbUFBDTEtfRENMS18xXSA6DQo+ICAgICAgICAgICAgICAg
dXNlX21ldHJpY3NfdjIgPyBtZXRyaWNzX3YyLT5DdXJyQ2xvY2tbUFBDTEtfRENMS18xXSA6DQo+
IG1ldHJpY3MtPkN1cnJDbG9ja1tQUENMS19EQ0xLXzFdOw0KPg0KPiAtICAgICBncHVfbWV0cmlj
cy0+dGhyb3R0bGVfc3RhdHVzID0NCj4gc2llbm5hX2NpY2hsaWRfZ2V0X3Rocm90dGxlcl9zdGF0
dXNfbG9ja2VkKHNtdSk7DQo+ICsgICAgIGdwdV9tZXRyaWNzLT50aHJvdHRsZV9zdGF0dXMgPQ0K
PiBzaWVubmFfY2ljaGxpZF9nZXRfdGhyb3R0bGVyX3N0YXR1c19sb2NrZWQoc211LCB1c2VfbWV0
cmljc192MywNCj4gdXNlX21ldHJpY3NfdjIpOw0KPiAgICAgICBncHVfbWV0cmljcy0+aW5kZXBf
dGhyb3R0bGVfc3RhdHVzID0NCj4gICAgICAgICAgICAgICAgICAgICAgIHNtdV9jbW5fZ2V0X2lu
ZGVwX3Rocm90dGxlcl9zdGF0dXMoZ3B1X21ldHJpY3MtDQo+ID50aHJvdHRsZV9zdGF0dXMsDQo+
DQo+IHNpZW5uYV9jaWNobGlkX3Rocm90dGxlcl9tYXApOw0KPiAtLQ0KPiAyLjQwLjENCj4NCg0K

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C31C001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Aug 2023 09:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEAC010E4AA;
	Fri, 18 Aug 2023 09:48:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 828C010E4AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Aug 2023 09:48:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msGSRyF4PbAFgpP++c/nUwtOqaC8sST+Ygyd3+JQBsIbbzc9sLeuXukL8v8RpRk6WZUvS9BoehGILit6gZFrMnBlQyetj9g3rPz4PWpYkxVwgFuy0XaqOdmFwjUzkRv5XwFX0VYcvmnZc8tz0VEhGnE3vY7lnFiJvSnZkHyncbQr8RqxBBIirL3ytZnAR6wr2e6+HknYzy7CMMyD2qVfvVaJiDFEy8nYGQlytRWIF7WXViis4XJxubocuqP030L3uInPKweuyjNj0w4fUiWJpi+DHPMZ6pXs7DqPk86B8ktPcqB8VZx4+qKBtuWV3tvjyLH2gufpgrRScaJlwV0TXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZ1EcwbbD2gL9ytbhq1x58d9cO4b0XtbhAFIfHctT+w=;
 b=RTUEeyMYTyzqSGSL+mq5U+NfswTSU55TfPNx5NZac1HWqjEUr9Q6MhdnWiZryyg0/D37XM9LQ17jEY/X9Ek7LLeSZkKvMuA7kZp3kNzigGEXJ26hO3GZ0wWtUxGvqS4XcpqhFABsEuvwUjUQ1pYbDQ2viC37jhcvUENHuZV7LukO+dBSRVZnkiNScmUxrVNdbOPZvc/Kc3KiDLqjhxSUV4D33mYV58Uv2TyrFG84jS0/AfQHKzsKw06/0wMzrc1f3iiwap53EUFgNBGuYUQVrGbp8xgZ4V0hwpUoiqgfQB8UjIVuOwyVGoytGnbJWw1XEjhF8OFv5rA+VJpirffBTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZ1EcwbbD2gL9ytbhq1x58d9cO4b0XtbhAFIfHctT+w=;
 b=TwXY5dYQ7ZH925Oc2SGfxzNSb2tadoEOZjg+H4V9vcpCqOjMtU+5obpz3T0pedUDGoz5CE5COVNDBqjM61OTAO720eek5HEUfKgnMNY9/iq2C4S83G7++5B/YGjIAN6nH5XCm9Hu9GOR4ucdzAaP3RO01WI9xvZWq/2wxksYWiY=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.20; Fri, 18 Aug 2023 09:48:54 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 09:48:54 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix kcalloc over kzalloc in
 'gmc_v9_0_init_mem_ranges'
Thread-Topic: [PATCH] drm/amdgpu: Fix kcalloc over kzalloc in
 'gmc_v9_0_init_mem_ranges'
Thread-Index: AQHZ0Z+ypupyejYPAEy2GCqMsavne6/vzuBw
Date: Fri, 18 Aug 2023 09:48:54 +0000
Message-ID: <DM5PR12MB24691A4E3825FFD8B08E19B9F11BA@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230818064558.819989-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230818064558.819989-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=486a78f8-bde0-4534-9c6a-edfc0a168c84;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-08-18T09:48:19Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DM6PR12MB4499:EE_
x-ms-office365-filtering-correlation-id: 84a21182-4316-44b1-2cfb-08db9fd0559f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: clrvNz5srhHEqE0i4QmELG/j9CFeS/RHZKcWAQbqDhyyitUmG1WEZ4wFNiz4PA5TLtphAuetTZj4ar1TrnXEq+ptz+Xuu284VOKWRSiHU6GCKJFKybJHdD/7IBcT0NTsIWHCcMS0MO6MYQTdk0PIiZUaIQQtZH9U8aZRwvnKdXGX8nhbePh6EfBcx5CUT07pbzeTO4D4Bt1Ivd8Je8/fCzD3/T4Spn2+onx8lmhZWaABcrX6Kfbgzq/dyg/d9aRqQ3EvAl3d9Mqc/BNey8N8hVPXNm8KcTsw2JKlasSjeQ7vp0gw1RKHqSkGLFLF20LSI1QyKEbHgli3e/CIoaFhf2xnuEKBfyFSIYXxdPCLkbqbyxO/R7Dx6QLJaKdbxQZ5ZTxdVvtOd+isU6WSL5i8nJ5ZXKQpbv97WEK2IuoeXfZrAA18XH0/X3jxfywUyO3Wx0dTYUvbl9bjND0qseA7ihXKmLrSt6q3r8W2Rkj4KHvdxXyRRtplFwhGrVtsYrfEPDoXgVaahGNofWgkJLjoH7XroiH4QKD4LCq9Rp/CIxGcDYEgM1KHZWHzj6g00dHM8diNjk6gu+KN8NwFQG7BPGjplGr5bo9dUBebgcpTvDohA8WmIIAKrBbTfHvnbj7K
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199024)(186009)(1800799009)(26005)(71200400001)(6506007)(7696005)(53546011)(9686003)(66574015)(83380400001)(5660300002)(8936002)(8676002)(52536014)(4326008)(2906002)(478600001)(41300700001)(76116006)(110136005)(66946007)(6636002)(54906003)(64756008)(66446008)(66476007)(66556008)(316002)(38100700002)(38070700005)(122000001)(55016003)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2l2Y2JIYU9rVDBtTDlEZldrVGtUVWR6a2htbUN6dE5VWXE3N2xxaTZTV01q?=
 =?utf-8?B?VlhsYU1oNkMxZTF3Q0p6QzV1Q1M2K2tFbkFueVR3bWRtUzRlTUdCWDlDdjJR?=
 =?utf-8?B?MGZNQTgyaWtTbS81T3N3WGMyT1hGNjVlclF5RzNsNTM2STdLbGFaWUtjSWJI?=
 =?utf-8?B?Y3hLRm9ZVUF5K2ZmSGZjNTdadTRjQ0dnbnV2SXdGRmVwWVByQnB3bmxCekRt?=
 =?utf-8?B?aVo2UXpOa0FuWDVkUXQra0UvblREY0tMYjJjN3V0TTVRWGprZVh4Wk1HeFBx?=
 =?utf-8?B?dWM1TnFLbWh1TUxjQjZWWHdqUHdJKzRjYXRZRDArelVZVkFZQy9DNzRpMTNX?=
 =?utf-8?B?UWljbVRsSXNqd3lLV2U3SjdMZ0p4aXJIWWdvV294NHlqMUttNXZxNzNEWWhl?=
 =?utf-8?B?bXJHNFMwejVJY3RDL2g5dGlIQ3VmM1R6cHdXYTYrdlI1Y01pT05LR1lUN0FD?=
 =?utf-8?B?Mno3QWdNTTdpOXN1d2IySmROQXp4eHkrQ0E1WXRZRUQ5UTNES0ZSM1VUeVVJ?=
 =?utf-8?B?NW1CNjJNQjcxZDFiQTFhb1NlNmdJRlkxcGRqTkY2ZjliMHpvMzBTWlJCTzZP?=
 =?utf-8?B?QWhEWXFCKzNYNjVnN2Y3K2xLZU8zcG02NDAycWNRY1Rzekljd3ByRUoyVlVW?=
 =?utf-8?B?VnFsZWpNWklhWDVZc1kwVVNSOXZOQUFDRHZmT1d0ekd6RWx6QmNyRmJxZ1Fv?=
 =?utf-8?B?OWVRWGtCNFNKOW5CTTEvL3ZqZzgwbVpYMlI0eGFlWEZUL1hYZEs1dUtqU2t5?=
 =?utf-8?B?QU53NmFhdjRUMWJvZVRSZ25tMXNOdUdLNmF1R093TzMvRDNjQ3IydkFvUkVu?=
 =?utf-8?B?VVprQlpKTi95a2d6UVhKRlYrSVpvVHAwVjRlT2VpejhBb0t5bkljdTErUUMy?=
 =?utf-8?B?WGJ6bkNJUnFta0N3L0xtRS9ORmpwMk5nYm9LbVdDMkMxa0RXRHlPUTN3d1Zl?=
 =?utf-8?B?cmk3Q2xJUWNVbXpzR3JiM1RRWmNGQ3ZsVlNvc1JSeGNxMkhqZWk3VldtVDdy?=
 =?utf-8?B?RmRTdzNuZ0J2dzJUcWpFelg1cXVtbmo4UVU5bzB1OWZqYjJGNUxzTXBYZTQv?=
 =?utf-8?B?STVGZFhJQzBpYk5ET3hiSEdrYnFQOUQvVXBtZm42clExcWJqemtTci96cC8z?=
 =?utf-8?B?VEpNY0dWd2VaVGtHbTJQVDRvQWZ0QmNmVDh1alpiVWNYY1ZPc0NIZ0pHcEdV?=
 =?utf-8?B?cGVqN2xrRFNRYXlLbnNDYjJzYmlvNDlvK1lSTGd5U01tMldpSXhEKzF3bmF1?=
 =?utf-8?B?bS9ldWFkMEZKZWhiUitUVmtzWVFKcDZ2T0FnWEpyNW5VR3VTWnpqNURmMWxJ?=
 =?utf-8?B?azhrcytmUnEvR2tnQUFZb2pPSTNyN2ZEWGFoZVlpYUkyV3dJZXJSYVQ1NmMz?=
 =?utf-8?B?aTZQanFpZkYvdkcyOFpkWVJXUFUvMHhKaHZDTDJadWlwbmRHRDhDdmJQamZG?=
 =?utf-8?B?QW1WZG4weEk1NlFwVWRsQ2FtcXVGMTNwcFlkSWw3WEFlQXhQQzdJbFZKWUhF?=
 =?utf-8?B?d2ozZFlzRkFDUnlEbHZCaSszWDRyOVRCM094K0YwOXlheDlpekMzbkhadFRh?=
 =?utf-8?B?aStqc3l2Wkc2bytUOUJkOE1ZR2NkZHNWMFNUbHorM1ZJaTFOMXAwTnppRldX?=
 =?utf-8?B?ODR1Q2cxMlR6THdXZk5ZSkJyeitnM0YxNU5IUnNPZGV0QUtTYkZKNXZ6TzY3?=
 =?utf-8?B?ajVFaTZyMEh4ZG1pQU43U1NIeTRsZWVsWjRYUnY5elRlVEQ1eWR3RFBUd1c5?=
 =?utf-8?B?WEdLNXJpZFdtbU9KMGR3S3pqK0U3VUt6ckd2Vnp1ck5Rcms1Zys1Ykw0K2tv?=
 =?utf-8?B?NlZ1bnNSSldrUi85UnNCWmdiYy8xTytyVGhucVc2MHk0RU92OUljM2haU3Fw?=
 =?utf-8?B?Qms1TjNuZGlFV3pwckJOdTd5cGdDZzEyMnJ3c2pJeldia3FCKzNzMXFQbTll?=
 =?utf-8?B?UDk4M3kweEdWcVJibjUyY0R4UzFxaEx4ejBsckRZdUFEVzJ1S3ZUcGpSUVpO?=
 =?utf-8?B?YVpPZG02a0RWQU04SUFRYktjVE5abVJ3SitZNEpDRExERTBVUm9KNEhnMngx?=
 =?utf-8?B?a2ZoL20zMEpxR3Avdm9pOFRBQnpadFlvNGd1K0k5QXNubmJoNVVoNVdkcFMw?=
 =?utf-8?Q?01mQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a21182-4316-44b1-2cfb-08db9fd0559f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 09:48:54.1495 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w2WCKJm3/grppkn41Pk+L8zj9108aPboYr+g+wQUl95Igb6/uWvbE4yv3de/Dku2a0B71yBtziRFjc2wziiEcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4499
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KUmV2aWV3ZWQtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29t
Pg0KDQpSZWdhcmRzLA0KR3VjaHVuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogU0hBTk1VR0FNLCBTUklOSVZBU0FOIDxTUklOSVZBU0FOLlNIQU5NVUdBTUBhbWQuY29t
Pg0KPiBTZW50OiBGcmlkYXksIEF1Z3VzdCAxOCwgMjAyMyAyOjQ2IFBNDQo+IFRvOiBLb2VuaWcs
IENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVy
DQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hl
bkBhbWQuY29tPg0KPiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFNIQU5NVUdB
TSwgU1JJTklWQVNBTg0KPiA8U1JJTklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47IFBhbiwgWGlu
aHVpDQo+IDxYaW5odWkuUGFuQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdw
dTogRml4IGtjYWxsb2Mgb3ZlciBremFsbG9jIGluDQo+ICdnbWNfdjlfMF9pbml0X21lbV9yYW5n
ZXMnDQo+DQo+IFJlcGxhY2Uga3phbGxvYyhuICogc2l6ZW9mKC4uLiksIC4uLikgd2l0aCBrY2Fs
bG9jKG4sIHNpemVvZiguLi4pLCAuLi4pIHNpbmNlIGtjYWxsb2MgaXMNCj4gdGhlIHByZWZlcnJl
ZCBBUEkgaW4gY2FzZSBvZiBhbGxvY2F0aW5nIHdpdGggbXVsdGlwbHkuDQo+DQo+IEZpeGVzIHRo
ZSBiZWxvdzoNCj4NCj4gV0FSTklORzogUHJlZmVyIGtjYWxsb2Mgb3ZlciBremFsbG9jIHdpdGgg
bXVsdGlwbHkNCj4NCj4gQ2M6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPg0KPiBD
YzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KPiBDYzogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KPiBDYzogIlBhbiwgWGluaHVp
IiA8WGluaHVpLlBhbkBhbWQuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBTcmluaXZhc2FuIFNoYW5t
dWdhbSA8c3Jpbml2YXNhbi5zaGFubXVnYW1AYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIHwgNyArKystLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dtY192OV8wLmMNCj4gaW5kZXggZjlhNWEyYzA1NzNlLi4wNjczY2RhNTQ3YmIg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYw0KPiBAQCAtMTk3Miwx
MCArMTk3Miw5IEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBfaW5pdF9tZW1fcmFuZ2VzKHN0cnVjdA0K
PiBhbWRncHVfZGV2aWNlICphZGV2KSAgew0KPiAgICAgICBib29sIHZhbGlkOw0KPg0KPiAtICAg
ICBhZGV2LT5nbWMubWVtX3BhcnRpdGlvbnMgPSBremFsbG9jKA0KPiAtICAgICAgICAgICAgIE1B
WF9NRU1fUkFOR0VTICogc2l6ZW9mKHN0cnVjdA0KPiBhbWRncHVfbWVtX3BhcnRpdGlvbl9pbmZv
KSwNCj4gLSAgICAgICAgICAgICBHRlBfS0VSTkVMKTsNCj4gLQ0KPiArICAgICBhZGV2LT5nbWMu
bWVtX3BhcnRpdGlvbnMgPSBrY2FsbG9jKE1BWF9NRU1fUkFOR0VTLA0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihzdHJ1Y3QNCj4gYW1kZ3B1X21lbV9w
YXJ0aXRpb25faW5mbyksDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgR0ZQX0tFUk5FTCk7DQo+ICAgICAgIGlmICghYWRldi0+Z21jLm1lbV9wYXJ0aXRpb25zKQ0K
PiAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOw0KPg0KPiAtLQ0KPiAyLjI1LjENCg0K

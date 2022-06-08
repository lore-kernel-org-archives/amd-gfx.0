Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314ADC43334
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 20:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2B691136B5;
	Wed,  8 Jun 2022 20:03:50 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B919A1136B2
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 20:03:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BV9LdHqwy6CTeG4D3befgIWUX+lnrwaPfeqtnv/kLnmE6e3eVBWYSPqV9auO0IWoTEwz+71x0ghoGqz7M46ZARXrZB1tUbNu/EKD2B+Ph+/AGxrodOcS4id5BjrSp/27ogD20TqR4ssdJ06+xlaabpCmKPqWmwCJPnGRVkz4A2d22NjFZW0U6e6SLHNTrmmH36fCYaL2ws3Vca+FLhY8xo0ZG0H4Hc2gB4kch93PFvZqct2BEsq9iwGuKXTsjno81vIP0UU5QCB1O4gWjxzPt48dkfEoJ5qbDIWWGLwnf2/EBaHy2GYbe5/9VQLus93nVwPwpNGWLK31F1+iNVYw3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuV/7Awqn0esjL804/IIcjSfio9jmXC9OlU6MbxpnCQ=;
 b=A2xx6/+CgnkhlVmh8mr4A8A8oHNfDvcjLpLrJL0fVJf2zc6JE7mHJpBu9FkWJ+OGban7lWIqPxkuEazLuTR7PyZolHhyxVMgBFT3vBb+H4+tcD8poOh9RqYeipoE9N7f7f/7Ojl3h2oE2BMMujPbRqbRpHWoyWdnC17JSte3qrDoxk9HmThYbLqF0XKu8fnsaqmIkCjVOAAcSpY5pqU5kALM24lgvoyuCSj9vA4YO2WhptWvd3KUZF8KWLapkJz6m2ydyEtG4cuY2umIqXJKabBZrbmJM4ndMxg7MVr+T5GtFw9/yzErhhSZzskpveBvZpPCxKR2uRtxz5WDZve0VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuV/7Awqn0esjL804/IIcjSfio9jmXC9OlU6MbxpnCQ=;
 b=11stJCGYF5tt3bavQzgJgJnna/CKCdpVmLBXLA/JLxxkfwayzfegL698UuGgvnMYrHXBmd7TeSglNcsm97WY3UVwqz0CIET6hASIzDrzZwRxS5BtjKB86uJxCwnqJFRwwwL3epQBmbxguNB2VBY9uyoJ+4BETggfa/kXJhN1Myg=
Received: from SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 by DM4PR12MB5891.namprd12.prod.outlook.com (2603:10b6:8:67::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Wed, 8 Jun
 2022 20:03:46 +0000
Received: from SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::58d8:1b61:8bdb:2824]) by SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::58d8:1b61:8bdb:2824%4]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 20:03:46 +0000
From: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Unpin MMIO and DOORBELL BOs only after map
 count goes to zero
Thread-Topic: [PATCH] drm/amdgpu: Unpin MMIO and DOORBELL BOs only after map
 count goes to zero
Thread-Index: AQHYey4Vf9pg3yO4kUK6rCliqoBzWa1F6JsAgAAF7eA=
Date: Wed, 8 Jun 2022 20:03:46 +0000
Message-ID: <SN1PR12MB2575DAB025B69322D14B60D1E3A49@SN1PR12MB2575.namprd12.prod.outlook.com>
References: <20220608115110.1798650-1-Ramesh.Errabolu@amd.com>
 <954e9aa2-835b-397a-299c-c98bb60b764f@amd.com>
In-Reply-To: <954e9aa2-835b-397a-299c-c98bb60b764f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-08T20:01:15Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=649aa9d7-9022-4048-8477-f4673a2550bf;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-06-08T20:03:44Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 3e353098-7475-4841-b588-bb42af4c1360
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b587d995-014f-4d81-d094-08da4989ff1c
x-ms-traffictypediagnostic: DM4PR12MB5891:EE_
x-microsoft-antispam-prvs: <DM4PR12MB5891CB983FBC7882A058E8FCE3A49@DM4PR12MB5891.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yV+CSY5F/6ugXJytpUMMYA2IayE4gfpnjKe/aMi2hFUcZ2AhnjsKTZQsktd0TvITbRqlgvg1RqGHnxHvypiDS2DqWbsoJlZUP7G6iVP79gObqz5aIkCX4Ny3SInBpcYJbSpljjgbJetO4XjXCfBB3PljtjXuktMeCFAhXYdf3iX8NXEXahY9Tb8+nFQPsehiWc8uNy39B2EouAckZJV5Jo5uRjYZzUGQi6UoEn79CN9fWoJ6ymELQdSfoPP1x+GakPBks6reDjA06PgvLc1V9mU79FqKhFG3gpU+ujrIyZqvPx6FrVU8ocmCzMrhm3P7TtrwT95tIvqwvtqSuz7unF70i15TDHuP2C1ruOKaMu26nzIdihweNEt7uiOVPvedz8sFCxxe3UQLOwCmjtogAh0ppYvjLI3pTFOUmxpVuiauOC97WQ9RPB1jKKyK0MV1LN4xuz2tYIIiknoYxHoSefDUvGcOKkIgBg4BptQjZgasPYjhmdHZL3aWButr2NuFq0DBH4/xHndnAsK2zu9tjUNk3I0a+BDnXme1QFBbnJK5oVXq9uNGHyUWoEHXVMw8+FxcsiG6W/zZCpNwof+MrGblipr9kNvYUMrAeBUyjB22aihN3O3jnhdDcFTXP4eNqkv8TXmXFv6Q6XurgR7J4umYFOA/kihHpUwNPUuKQ0/QZLSIvyAXf5qSmTokHCOe1tnFtgQcev3nOhLWgMwwWw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2575.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(64756008)(66446008)(8676002)(122000001)(71200400001)(9686003)(5660300002)(33656002)(2906002)(26005)(83380400001)(55016003)(66946007)(110136005)(186003)(76116006)(38070700005)(66556008)(508600001)(6506007)(7696005)(66476007)(38100700002)(86362001)(316002)(8936002)(52536014)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnRsMXVPUVdSZUJNQm5mSTlZT2Y2QUFEV1l4VWRBUkhZaUt5V0ZvbnlROGVz?=
 =?utf-8?B?eVBrQzJTeDRuNXBYejVERU84eHpZUmJLbmxBMXc5Vlo5N1NmdWJZS2tVdHI2?=
 =?utf-8?B?c1pLUS92dUg2bzhvS2V6Vk8xdTV6aWhTV1NNNmFkcnZMd3QxUCtDTlBFUGhx?=
 =?utf-8?B?RzAvc3NibSsveXBlUlY1YlRMTGpsaktqNDdua1M5MHZheC9VYUcyZUlCTUlT?=
 =?utf-8?B?eE9QcERnZWU2MnM5WVo1RzNybWdtbjBsaEZ0ck5QSkl5bnd2SWFZQ0lyVUJZ?=
 =?utf-8?B?RzU5YjdUUnNpc2l1dGVxVzE0WDFOVzhtdFRKdmNNaVJpcU1Gb2xRaEVBZkxj?=
 =?utf-8?B?N081WXcrOG5MQ2V5UlhYbDE0UzFaYmsvaTZYRmdkUzFnamludlZiUE9uLzFH?=
 =?utf-8?B?ZnlPTFRrQTBRMWtkaUhCMXZFVm1zYTdjRm5IMmZRN0szbTJhdExuL2lCeHZF?=
 =?utf-8?B?UXdxTWZqMnVMZFptbE9tRFZDaVBVNW5JaFJ5ZVpWTGVaNWFOMjg2M1RKNFNH?=
 =?utf-8?B?SVRadG9hZHdMS0piVzJwWTE0dUxqYzNLSTB6cWJtQWF1M3I5T0Nid0ZJSTc1?=
 =?utf-8?B?blVtcUVoTjludVl4ZERHdkN2dXpjblRWV1ZyZ3ZqUVBOQk92a2ZEOEQ2Q1Qx?=
 =?utf-8?B?R0t6VWtZV05KcFc4SUdqdUdQSkhnR0JRV011dmtpU05IaktNWUlmK1cxVVRQ?=
 =?utf-8?B?NjVyV2VqZ0tTMytLRTViUXpzSEFtYm9USmNqRkJ5T3dJOUtCN0JzeDY1M0Vk?=
 =?utf-8?B?Sm9jb25XOHRIN2FxVU84RVRrREt3S3Z1bUV2dUMxTi93NFlGUHEyeUUyako5?=
 =?utf-8?B?WTZEb0ViTFg4bkhLdDNYN0Q1OGJQSk9iNDhmZS9CMUUvb3pHLzMxL1FnaDRC?=
 =?utf-8?B?YUdZeFE5dFFidko5MUVNNUtweFVxV3RmcU5NTnBsRGhNcWdNMFJhNnE4M2dQ?=
 =?utf-8?B?RzNzOWtrRW5hRko2aTVwZGxKU21aa2ZGelhMVThZQWZ1K1lyR3VqSDMwUDdo?=
 =?utf-8?B?YXFONWVYR2dNelNWWC9Dek1FcThEOFV4MVZlcHlMMXBBQkNRNWNETGs3c09u?=
 =?utf-8?B?MW4zWGdlLzNmT0dYL2xHaVRKcGJzcThYY3hrOUdrbXFWeVVMbVFmeE1ScEF0?=
 =?utf-8?B?RzI4NlhKN3BvUVlLdmFMUkJxQ3dzVjRmcVFGRmJYWkpMWllVbXppaERnL0Np?=
 =?utf-8?B?ZmJkZHZpSjN2VkdlRGtlWTVOamUwak9INGs4Y24vbUdnQVZxaFNkd1VocWRk?=
 =?utf-8?B?bEoyV1BMME1Za0U0V3V4ZEVaTndCWVdXRDFIazAzVFVkTU81bVVEWll4NVJy?=
 =?utf-8?B?N0VtSStscWxHVU9VWGd0YjkzM3NhMDJvVnZLWVJwT3hWbEhoYlRIVmZQQTVq?=
 =?utf-8?B?bXI1TnVpU1VhOExhTFppdFJyOHVGbFRzL0tYRHpWVTVlbTFBenFxRHRmajFj?=
 =?utf-8?B?VmRkcDB0L3JzN1ExYTR3OTAwWk9mckhGTi9mQlBBTHhmMGRWTTROWi9BNis1?=
 =?utf-8?B?WFc0NWZNM2RPNGJ6OUlxUlExQXpzK2VkNTZuOUJGT2FXSkhSeEdpdUlIdXZY?=
 =?utf-8?B?R3dYQUR2R3V0L1VsSDZXNUk4TnNBNDVZZHh1UU51RW1iUGIzcys5Y1dseGZk?=
 =?utf-8?B?SmpzOHl2dFZaZFo3QllyL0grYkhRTGhueXVmcU9jZC9GN0VtRngrZ3hvdVBn?=
 =?utf-8?B?a2hZWGVzWVNoRlZIVU9vU1FSUTFLSU9hWWZ2ODNJU0Yxb2RsZnZXSnhRMG1C?=
 =?utf-8?B?MklqME9Cekl2bHFudUsxeG01bklDbVU4dnM1UVFOWDBGQ1pFRzNabXF2SEdu?=
 =?utf-8?B?R0NqNG5yOUUvcDc2K2VNUXZPanMyb0JpTnFzUjFKbGxCc2xpVVJOWHluYVEv?=
 =?utf-8?B?Y0xLN1dQVDB6cDBuc2ROd3lDN1pqZFFIUnAvc1o3SitRYVdwTmh5Z2tESW14?=
 =?utf-8?B?alAwalZrem9vRXpxVzBDQTdaUExXcWt6cmxPbGhZdm1XMVJJR1VXMkJySTh4?=
 =?utf-8?B?OVNiNnQ3TVdjd1lXT2Y1Z3djeGVPU3ozZkRscSs1ZSs3aitlWGNseU5HMVJP?=
 =?utf-8?B?cFlObU5VSDgxV0RmTVcvaGZKWnNZWVJ4RHNlaDRzL0hSZmEwU1cyS05hcGor?=
 =?utf-8?B?NnpBekJ1aW16VDk3MGc5M2pwYXI4T1E4dXBzc2dJWTJWSE9FaTlHbElKajMy?=
 =?utf-8?B?eEJYQmlLUXdKYzh4cjlZenoyay9xWFJyQ3NOc213TXk2eGhML2kvL1V3N1lS?=
 =?utf-8?B?VzRlRVU5czB1UjdFZlBxY1lTSmlEa0szV0prSjgwUkhNVm1pRnlKMzFaYXYy?=
 =?utf-8?Q?R3wt+4LbE817WXhPVs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2575.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b587d995-014f-4d81-d094-08da4989ff1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 20:03:46.5615 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vo+0SNXx276zlYlScE7v2uy1gTcVxlFjd8WsqdH2S5w93bTz1VMR77wEV1qIxWEyiF6ElVT5QDfcdLMmw/cuzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5891
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCk15IHJlc3BvbnNlIGlzIGlubGlu
ZS4NCg0KUmVnYXJkcywNClJhbWVzaA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJv
bTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPiANClNlbnQ6IFRodXJz
ZGF5LCBKdW5lIDksIDIwMjIgMToxMCBBTQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnOyBFcnJhYm9sdSwgUmFtZXNoIDxSYW1lc2guRXJyYWJvbHVAYW1kLmNvbT4NClN1YmplY3Q6
IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IFVucGluIE1NSU8gYW5kIERPT1JCRUxMIEJPcyBvbmx5
IGFmdGVyIG1hcCBjb3VudCBnb2VzIHRvIHplcm8NCg0KDQpPbiAyMDIyLTA2LTA4IDA3OjUxLCBS
YW1lc2ggRXJyYWJvbHUgd3JvdGU6DQo+IEluIGV4aXN0aW5nIGNvZGUgTU1JTyBhbmQgRE9PUkJF
TEwgQk9zIGFyZSB1bnBpbm5lZCB3aXRob3V0IGVuc3VyaW5nIA0KPiB0aGUgY29uZGl0aW9uIHRo
YXQgdGhlaXIgbWFwIGNvdW50IGhhcyByZWFjaGVkIHplcm8uIFVucGlubmluZyB3aXRob3V0IA0K
PiBjaGVja2luZyB0aGlzIGNvbnN0cmFpbnQgY291bGQgbGVhZCB0byBhbiBlcnJvciB3aGlsZSBC
TyBpcyBiZWluZyANCj4gZnJlZWQuIFRoZSBwYXRjaCBmaXhlcyB0aGlzIGlzc3VlLg0KPg0KPiBT
aWduZWQtb2ZmLWJ5OiBSYW1lc2ggRXJyYWJvbHUgPFJhbWVzaC5FcnJhYm9sdUBhbWQuY29tPg0K
PiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZt
LmMgfCAxNSArKysrKysrLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspLCA4IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYw0KPiBpbmRleCBhMWRlOTAwYmE2NzcuLmU1ZGM5
NGI3NDViMSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2FtZGtmZF9ncHV2bS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmRfZ3B1dm0uYw0KPiBAQCAtMTgzMiwxMyArMTgzMiw2IEBAIGludCBhbWRncHVfYW1k
a2ZkX2dwdXZtX2ZyZWVfbWVtb3J5X29mX2dwdSgNCj4gICANCj4gICAJbXV0ZXhfbG9jaygmbWVt
LT5sb2NrKTsNCj4gICANCj4gLQkvKiBVbnBpbiBNTUlPL0RPT1JCRUxMIEJPJ3MgdGhhdCB3ZXJl
IHBpbm5lZCBkdXJpbmcgYWxsb2NhdGlvbiAqLw0KPiAtCWlmIChtZW0tPmFsbG9jX2ZsYWdzICYN
Cj4gLQkgICAgKEtGRF9JT0NfQUxMT0NfTUVNX0ZMQUdTX0RPT1JCRUxMIHwNCj4gLQkgICAgIEtG
RF9JT0NfQUxMT0NfTUVNX0ZMQUdTX01NSU9fUkVNQVApKSB7DQo+IC0JCWFtZGdwdV9hbWRrZmRf
Z3B1dm1fdW5waW5fYm8obWVtLT5ibyk7DQo+IC0JfQ0KPiAtDQo+ICAgCW1hcHBlZF90b19ncHVf
bWVtb3J5ID0gbWVtLT5tYXBwZWRfdG9fZ3B1X21lbW9yeTsNCj4gICAJaXNfaW1wb3J0ZWQgPSBt
ZW0tPmlzX2ltcG9ydGVkOw0KPiAgIAltdXRleF91bmxvY2soJm1lbS0+bG9jayk7DQo+IEBAIC0x
ODU1LDcgKzE4NDgsNyBAQCBpbnQgYW1kZ3B1X2FtZGtmZF9ncHV2bV9mcmVlX21lbW9yeV9vZl9n
cHUoDQo+ICAgCS8qIE1ha2Ugc3VyZSByZXN0b3JlIHdvcmtlcnMgZG9uJ3QgYWNjZXNzIHRoZSBC
TyBhbnkgbW9yZSAqLw0KPiAgIAlib19saXN0X2VudHJ5ID0gJm1lbS0+dmFsaWRhdGVfbGlzdDsN
Cj4gICAJbXV0ZXhfbG9jaygmcHJvY2Vzc19pbmZvLT5sb2NrKTsNCj4gLQlsaXN0X2RlbCgmYm9f
bGlzdF9lbnRyeS0+aGVhZCk7DQo+ICsJbGlzdF9kZWxfaW5pdCgmYm9fbGlzdF9lbnRyeS0+aGVh
ZCk7DQoNCklzIHRoaXMgYW4gdW5yZWxhdGVkIGZpeD8gV2hhdCBpcyB0aGlzIG5lZWRlZCBmb3I/
IEkgdmFndWVseSByZW1lbWJlciBkaXNjdXNzaW5nIHRoaXMgYmVmb3JlLCBidXQgY2FuJ3QgcmVt
ZW1iZXIgdGhlIHJlYXNvbi4NCg0KUmFtZXNoOiBUaGlzIGZpeCBpcyB1bnJlbGF0ZWQgdG8gUDJQ
IHdvcmsuIEkgYnJvdWdodCB0aGlzIGlzc3VlIHRvIGF0dGVudGlvbiB3aGlsZSB3b3JraW5nIG9u
IElPTU1VIHN1cHBvcnQgb24gREtNUyBicmFuY2guIEJhc2ljYWxseSBhIHVzZXIgY291bGQgY2Fs
bCBmcmVlKCkgYmVmb3JlIHRoZSBtYXAgY291bnQgZ29lcyB0byB6ZXJvLiBUaGUgcGF0Y2ggaXMg
dHJ5aW5nIGZpeCB0aGF0Lg0KDQpSZWdhcmRzLA0KIMKgIEZlbGl4DQoNCg0KPiAgIAltdXRleF91
bmxvY2soJnByb2Nlc3NfaW5mby0+bG9jayk7DQo+ICAgDQo+ICAgCS8qIE5vIG1vcmUgTU1VIG5v
dGlmaWVycyAqLw0KPiBAQCAtMTg4MCw2ICsxODczLDEyIEBAIGludCBhbWRncHVfYW1ka2ZkX2dw
dXZtX2ZyZWVfbWVtb3J5X29mX2dwdSgNCj4gICANCj4gICAJcmV0ID0gdW5yZXNlcnZlX2JvX2Fu
ZF92bXMoJmN0eCwgZmFsc2UsIGZhbHNlKTsNCj4gICANCj4gKwkvKiBVbnBpbiBNTUlPL0RPT1JC
RUxMIEJPJ3MgdGhhdCB3ZXJlIHBpbm5lZCBkdXJpbmcgYWxsb2NhdGlvbiAqLw0KPiArCWlmICht
ZW0tPmFsbG9jX2ZsYWdzICYNCj4gKwkgICAgKEtGRF9JT0NfQUxMT0NfTUVNX0ZMQUdTX0RPT1JC
RUxMIHwNCj4gKwkgICAgIEtGRF9JT0NfQUxMT0NfTUVNX0ZMQUdTX01NSU9fUkVNQVApKQ0KPiAr
CQlhbWRncHVfYW1ka2ZkX2dwdXZtX3VucGluX2JvKG1lbS0+Ym8pOw0KPiArDQo+ICAgCS8qIEZy
ZWUgdGhlIHN5bmMgb2JqZWN0ICovDQo+ICAgCWFtZGdwdV9zeW5jX2ZyZWUoJm1lbS0+c3luYyk7
DQo+ICAgDQo=

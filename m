Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B36EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 02:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24DFD61882
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 02:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 24DFD61882
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEC8B6EB31;
	Thu, 30 Sep 2021 02:23:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EB0A6EB29
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 02:23:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGKbOG2Y+aj6By6C3N6JMgRP92MoIPKZiUOZmk0yuxk1o+lashNdhxBpg6wb0p1JWNVu0XVuPupK60hzaK+A15zpgoqg1fLBsmg+xvfm+vg4mCYi7ElLAJZe3bL0/w+HjplUVonrij138/dMX/SIYY2gTOsCNxylI7ys5Nc46OH+j4Olcv4fDa2wb7LTSYI5yFSS6Els5Sb/DnRktIJzdUwmrPZOVfws7Oc8guqXPULv7jBa9Apw/16LXvR22FOPxJp4t3SLVUr6qHEvl2tbp9O9XrEzPhLkjVwwtOgKPrnEjtwWjRUj2uzP6nTvy79mR3VPUMXvMBzBoot0H5JLsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Q6DBrK9bDh1FxrWmsiyagY9u/dnQrqxfS7eGSo6bO+w=;
 b=ED42nqA1i99V/kvi4ZP+npOAaz+a1SkhryTZ8yuegG/s4xrmNG6JeaOYH8dNc8TN2Qg1uXYH4NyklGxqYvesQtMCHYMp1Cu/r43joqYsMIAgBqVcdNlM0NhgK5VMZdI1ayOYIRana23n7Dl+VGgX/WQVgbomCASiecBFq1ricSX8kdM5+QuRi+PrKPIaSTQ7MYAIvabHULZbOf1xmL8RiDoTxChPfwqe0eP1hF3HQIE4OR43gdTccG7nvVsvs0PYsSS9PeuXzNQnOuhQMD28QQM6ir37q9NNYaRSpsqFOIsjgLusavtP1x+pl+ix1dKdI3mLheo7mQkhvxDGBpZDHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6DBrK9bDh1FxrWmsiyagY9u/dnQrqxfS7eGSo6bO+w=;
 b=sh8MtIrjuyo0YroNayix+lL0r9SweG16VPrK5TXcfJAxy1a6wYnvKMnlY0nkp3jtWlv8KjCMV789FGdcgaqMCz/xC3ASs8qbgK+5esNzGJ24Gbfxwp3zPRz3xz5Sh7aCQIJZY7jClEXG5T2z/+ioIKIfXHXSkLh3lhJlLt9D1YY=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 DM6PR12MB2809.namprd12.prod.outlook.com (2603:10b6:5:4a::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15; Thu, 30 Sep 2021 02:23:17 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::899f:5742:e36e:b303%9]) with mapi id 15.20.4566.015; Thu, 30 Sep 2021
 02:23:17 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdkfd: fix a potential cu_mask memory leak
Thread-Topic: [PATCH] drm/amdkfd: fix a potential cu_mask memory leak
Thread-Index: AQHXtQsmKTKeWYk0oU2s3x4JTRfj6au7IiqAgACGfTCAACdoAIAABimw
Date: Thu, 30 Sep 2021 02:23:17 +0000
Message-ID: <DM6PR12MB425018180CB2B71C7BBC0134FBAA9@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20210929082212.1806312-1-lang.yu@amd.com>
 <2ccb1777-ca8e-5a39-5311-3262c1cba608@amd.com>
 <DM6PR12MB425096E4B53642BEA55FDE25FBA99@DM6PR12MB4250.namprd12.prod.outlook.com>
 <10d28f06-42df-6b8e-6e44-a4c85ed92473@amd.com>
In-Reply-To: <10d28f06-42df-6b8e-6e44-a4c85ed92473@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be4bd809-641e-4485-5cfa-08d983b943b0
x-ms-traffictypediagnostic: DM6PR12MB2809:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB280926CEE35E8513FEF3D7F1FBAA9@DM6PR12MB2809.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nihSEVSn1avPRYof3yvVX80gnEawncD0SN54GYVtzYEY/P7Lj0oBpeVre/f/ZoXj2WTy5wCHY+jfdb1s2SHdnG1IQcI5hTrHdLuoXhtUrc+OR8w92ikoDDGgeA30b2og4LK2bhtiSG/LiyhLUKkBs6vTkvPS+rAI/dwSMfWxnzPSjxeEPd7AfnxsvzHEYtHrKZuscViz8wpGxgNk8xna9ycu6WbOMD6QE/zjoA+KYpgLSakUpTUtvbHzDvxVvlJ+Ikiqs/4emvb+THVohkh8mYhWV5cpGtuVovgaUSF1eQFt5qpjGyBxXE61xMvvxk4gKAWd5+PS7RY5Xw+fN3KTOU4LqWYr/ol5VrS/cou1k2YQcRIWQ5q415RY3lqpMrYVMDGhVbh2h05dHcC53dRAzOqgdyk/GpCmqkmCEe/UInFM3nnI4XNysHOPEp9/2qRBu9zy5vhk3JN8Foo2rH86lRYRiWOoFe2b+L2/GKSpplA24zCqwavWWw75atkISR94mRDYXb/3O0MwkvPL5cpqrTgxRKuA8bQH895l0/juN7t13fOEYJ+XBgS3+9V9nY85eaDHRO/4NVvNgHjJveR6ytUsVvDJ4L7CUkRHm05vAJeuINHVuH9KTIlKVG/wktaBFxngLkHywPaLW6fUAsR9I6gddbgPjKFzkp76tE6eSnnsDcxYv5xqCfLIbTHrLtoBAM+HgrRmuXDUf1peqtIKBQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(9686003)(76116006)(71200400001)(8936002)(186003)(83380400001)(8676002)(66476007)(66556008)(66446008)(508600001)(26005)(33656002)(5660300002)(52536014)(66946007)(64756008)(4326008)(55016002)(7696005)(2906002)(6506007)(53546011)(54906003)(316002)(38070700005)(110136005)(122000001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEdEbjZ2UmxHc3ZHdDVmRjE1Z0NvN2VROWxBWlRRQzZSVEJFQWJ2YzRaSVJQ?=
 =?utf-8?B?VzBsQnJRbTlCMUJ4RGlrQittOWVZbnhvNEwxdS81TElPeS9VNk9yZWpRSmxa?=
 =?utf-8?B?SkJuU1lIbktjVXk3VHlYZ013ZGR6SmJ5dTFXZ2lsRnI3c2t5L2dtN1JYOTlP?=
 =?utf-8?B?WGpCSk4xa0MzTDVBc05NakUxS0VwQWlFRVBlNkFOOVkwdm1mZGVTamZMK2hn?=
 =?utf-8?B?SDkzaUVzdk5XWjlpMDdUSmRWczJEUDFzYy9NQTc5OG5DQ0ZWNWFBdXJlcGpW?=
 =?utf-8?B?dzI3UUtGOE9FdUthODRIbHZpbWtjV3p0dDZzK0phRUdTTm5hYVdPaVA0NFJr?=
 =?utf-8?B?ZFJ4MlpVakl0VnJLRXBpSlY3cmFJUGFTME4weWtwdlVwN1FzMVBLU1V6SlBB?=
 =?utf-8?B?WkNPZnlhR3liZkVSN0ZlR1E2bENKU3BzZ3lFQlZGSFRHQ25BT1JzR3RVTllC?=
 =?utf-8?B?M2U5am5ZbDNBaHhDV2NvRmlzSmV6SnhabWJuTFdaWUl6T2ZjUkZiMi83VWFQ?=
 =?utf-8?B?YjlHRHZDWXVNTDIxWkduc0V4VGJRTGJPZ3I1YllxVndIYkRNL1YzU1BmUkI0?=
 =?utf-8?B?Mjh5OU9FQWhuWTVWL1dXSi9BalRBU3hQamhLV2hFR20xYmZvb2VJWVFSZFRI?=
 =?utf-8?B?MzNLV08rSHEvN1g2WWk2endUYkFSNUY4bW9pQnQvck1zb3c4YUZScnhlN1Vy?=
 =?utf-8?B?SVZwQTdJL1R4dlY5TkJQNW9WSjZuaXhjcmFnYVp5WnNpc1dxbFdvbm8zWWh1?=
 =?utf-8?B?OWNjVkpsbk55ekFVcmNqUGhLcUROR1FkQ21JVjBaeHcydmphWXp1QUFKY0Zx?=
 =?utf-8?B?dW56d3NiQis5ZWgrOHA1aWk4TU9MODExemdQc1pWMk1ES2FmbG1ObTN1a2l4?=
 =?utf-8?B?Y3F2cG1yRDlGZncydTREdGN2WEpPTGR0R3FUMHh5bWtnOXNPOGswckc4cmZE?=
 =?utf-8?B?WEkxU3Z5cUpneW9WRWpIdjJXRkxPbGNPakN5VGtUOEFsQXJmczZ5YU1aSDBK?=
 =?utf-8?B?eTh5T1p4TWdkMVN1b29reVJ6cDEzQzVjQzgrbXJzejIxSmNmNzV4U2lVZ0lB?=
 =?utf-8?B?VVh5cnhwcitUVTQxWHVaekVMTGVpbDBEczIwa2pCVHFHMml6OERHRklXYzgx?=
 =?utf-8?B?RlVxL3hleUV5bmVSV0xodDhGdFhVK3k4K3pFbnc2cHFVYjV6eTM4d21ENXd4?=
 =?utf-8?B?WG1oUXVaV3YzY3NCeGg3OC9GNEVVRGFkU1FZUnE1T0ZFOTdKNjlyL1c3YzNo?=
 =?utf-8?B?UzVlL1BMK3l5d2lHWnFpV3lnZlRNS3lQWFFEaXY2ejRyQkRxM1Mzem9JbWs4?=
 =?utf-8?B?U3NjcU1SeXhFTDc5OUtTSWZoMmxDMW5jb1c0Z0F2Y1ZUcXY3Q2xaZXhmazc2?=
 =?utf-8?B?YU0yYTJmai9Fb3ZjdW1JWERrTERkVWFiUFR6TTlESk50dlBRRy82VnlWNE9t?=
 =?utf-8?B?QzRidUNpWDV5U1l3VkRtRnYrRlZKRStwMlgwOUxWZDlmUjhzM1o2dmhYeTBF?=
 =?utf-8?B?bnJKU0xvNUdpblF4b3JjZzRaZG1Cb3ZDandDN0NMcmQ0dU02M29UVVgxR3RY?=
 =?utf-8?B?dWFiRWY2cVNlT3lJdnJGbHZRMTg0MHBCTmFwY1BBNmVYYk81amtyaEJLZFp1?=
 =?utf-8?B?Nnk2STExTU9sdjB4Vjh1NDc2WVZnS0h2Y2pCVTZQbWVoTVdpYnllSVpFWG9H?=
 =?utf-8?B?S200WlVtVXpjeVVRWlZIKzYvYnJ2dkJEVk1nWllHSVdaWUdqNG1NWXRqczJr?=
 =?utf-8?Q?wtEWw4CzoOYmYVtjgTIFBn+O0CxbmckcGf2jQjZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4bd809-641e-4485-5cfa-08d983b943b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 02:23:17.6838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qCMS3ZEc8/hDuvu38EH48xBf/MAgYnHZenp4GuLfnA7SPiXtzF12383mQ0CUcHmpiuo8FSAa62GXtLJmnTw4iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2809
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEt1ZWhsaW5nLCBGZWxpeCA8
RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj5TZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDMwLCAy
MDIxIDk6NDcgQU0NCj5UbzogWXUsIExhbmcgPExhbmcuWXVAYW1kLmNvbT47IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnDQo+Q2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRl
dWNoZXJAYW1kLmNvbT47IEh1YW5nLCBSYXkNCj48UmF5Lkh1YW5nQGFtZC5jb20+DQo+U3ViamVj
dDogUmU6IFtQQVRDSF0gZHJtL2FtZGtmZDogZml4IGEgcG90ZW50aWFsIGN1X21hc2sgbWVtb3J5
IGxlYWsNCj4NCj5PbiAyMDIxLTA5LTI5IDc6MzIgcC5tLiwgWXUsIExhbmcgd3JvdGU6DQo+PiBb
QU1EIE9mZmljaWFsIFVzZSBPbmx5XQ0KPj4NCj4+DQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+Pj4gRnJvbTogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQu
Y29tPg0KPj4+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDI5LCAyMDIxIDExOjI1IFBNDQo+
Pj4gVG86IFl1LCBMYW5nIDxMYW5nLll1QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZw0KPj4+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+OyBIdWFuZywgUmF5DQo+Pj4gPFJheS5IdWFuZ0BhbWQuY29tPg0KPj4+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIGRybS9hbWRrZmQ6IGZpeCBhIHBvdGVudGlhbCBjdV9tYXNrIG1lbW9yeSBs
ZWFrDQo+Pj4NCj4+PiBBbSAyMDIxLTA5LTI5IHVtIDQ6MjIgYS5tLiBzY2hyaWViIExhbmcgWXU6
DQo+Pj4+IElmIHVzZXIgZG9lc24ndCBleHBsaWNpdGx5IGNhbGwga2ZkX2lvY3RsX2Rlc3Ryb3lf
cXVldWUgdG8gZGVzdHJveQ0KPj4+PiBhbGwgY3JlYXRlZCBxdWV1ZXMsIHdoZW4gdGhlIGtmZCBw
cm9jZXNzIGlzIGRlc3Ryb3llZCwgc29tZSBxdWV1ZXMnDQo+Pj4+IGN1X21hc2sgbWVtb3J5IGFy
ZSBub3QgZnJlZWQuDQo+Pj4+DQo+Pj4+IFRvIGF2b2lkIGZvcmdldHRpbmcgdG8gZnJlZSB0aGVt
IGluIHNvbWUgcGxhY2VzLCBmcmVlIHRoZW0NCj4+Pj4gaW1tZWRpYXRlbHkgYWZ0ZXIgdXNlLg0K
Pj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBMYW5nIFl1IDxsYW5nLnl1QGFtZC5jb20+DQo+Pj4+
IC0tLQ0KPj4+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMgICAg
ICAgICAgICAgICB8ICA4ICsrKystLS0tDQo+Pj4+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRr
ZmQva2ZkX3Byb2Nlc3NfcXVldWVfbWFuYWdlci5jIHwgMTANCj4+Pj4gKysrKy0tLS0tLQ0KPj4+
PiAgIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4+
Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFy
ZGV2LmMNCj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jDQo+
Pj4+IGluZGV4IDRkZTkwN2YzZTY2YS4uNWMwZTZkY2Y2OTJhIDEwMDY0NA0KPj4+PiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY2hhcmRldi5jDQo+Pj4+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jaGFyZGV2LmMNCj4+Pj4gQEAgLTQ1MSw4ICs0NTEs
OCBAQCBzdGF0aWMgaW50IGtmZF9pb2N0bF9zZXRfY3VfbWFzayhzdHJ1Y3QgZmlsZQ0KPj4+PiAq
ZmlscCwgc3RydWN0DQo+Pj4ga2ZkX3Byb2Nlc3MgKnAsDQo+Pj4+ICAgCXJldHZhbCA9IGNvcHlf
ZnJvbV91c2VyKHByb3BlcnRpZXMuY3VfbWFzaywgY3VfbWFza19wdHIsDQo+Pj4gY3VfbWFza19z
aXplKTsNCj4+Pj4gICAJaWYgKHJldHZhbCkgew0KPj4+PiAgIAkJcHJfZGVidWcoIkNvdWxkIG5v
dCBjb3B5IENVIG1hc2sgZnJvbSB1c2Vyc3BhY2UiKTsNCj4+Pj4gLQkJa2ZyZWUocHJvcGVydGll
cy5jdV9tYXNrKTsNCj4+Pj4gLQkJcmV0dXJuIC1FRkFVTFQ7DQo+Pj4+ICsJCXJldHZhbCA9IC1F
RkFVTFQ7DQo+Pj4+ICsJCWdvdG8gb3V0Ow0KPj4+PiAgIAl9DQo+Pj4+DQo+Pj4+ICAgCW11dGV4
X2xvY2soJnAtPm11dGV4KTsNCj4+Pj4gQEAgLTQ2MSw4ICs0NjEsOCBAQCBzdGF0aWMgaW50IGtm
ZF9pb2N0bF9zZXRfY3VfbWFzayhzdHJ1Y3QgZmlsZQ0KPj4+PiAqZmlscCwgc3RydWN0IGtmZF9w
cm9jZXNzICpwLA0KPj4+Pg0KPj4+PiAgIAltdXRleF91bmxvY2soJnAtPm11dGV4KTsNCj4+Pj4N
Cj4+Pj4gLQlpZiAocmV0dmFsKQ0KPj4+PiAtCQlrZnJlZShwcm9wZXJ0aWVzLmN1X21hc2spOw0K
Pj4+PiArb3V0Og0KPj4+PiArCWtmcmVlKHByb3BlcnRpZXMuY3VfbWFzayk7DQo+Pj4+DQo+Pj4+
ICAgCXJldHVybiByZXR2YWw7DQo+Pj4+ICAgfQ0KPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3NfcXVldWVfbWFuYWdlci5jDQo+Pj4+IGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3NfcXVldWVfbWFuYWdlci5jDQo+Pj4+
IGluZGV4IDI0M2RkMWVmY2RiZi4uNGM4MWQ2OTBmMzFhIDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzc19xdWV1ZV9tYW5hZ2VyLmMNCj4+Pj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3NfcXVldWVfbWFuYWdl
ci5jDQo+Pj4+IEBAIC0zOTQsOCArMzk0LDYgQEAgaW50IHBxbV9kZXN0cm95X3F1ZXVlKHN0cnVj
dA0KPj4+IHByb2Nlc3NfcXVldWVfbWFuYWdlciAqcHFtLCB1bnNpZ25lZCBpbnQgcWlkKQ0KPj4+
PiAgIAkJCXBkZC0+cXBkLm51bV9nd3MgPSAwOw0KPj4+PiAgIAkJfQ0KPj4+Pg0KPj4+PiAtCQlr
ZnJlZShwcW4tPnEtPnByb3BlcnRpZXMuY3VfbWFzayk7DQo+Pj4+IC0JCXBxbi0+cS0+cHJvcGVy
dGllcy5jdV9tYXNrID0gTlVMTDsNCj4+Pj4gICAJCXVuaW5pdF9xdWV1ZShwcW4tPnEpOw0KPj4+
PiAgIAl9DQo+Pj4+DQo+Pj4+IEBAIC00NDgsMTYgKzQ0NiwxNiBAQCBpbnQgcHFtX3NldF9jdV9t
YXNrKHN0cnVjdA0KPj4+IHByb2Nlc3NfcXVldWVfbWFuYWdlciAqcHFtLCB1bnNpZ25lZCBpbnQg
cWlkLA0KPj4+PiAgIAkJcmV0dXJuIC1FRkFVTFQ7DQo+Pj4+ICAgCX0NCj4+Pj4NCj4+Pj4gLQkv
KiBGcmVlIHRoZSBvbGQgQ1UgbWFzayBtZW1vcnkgaWYgaXQgaXMgYWxyZWFkeSBhbGxvY2F0ZWQs
IHRoZW4NCj4+Pj4gLQkgKiBhbGxvY2F0ZSBtZW1vcnkgZm9yIHRoZSBuZXcgQ1UgbWFzay4NCj4+
Pj4gLQkgKi8NCj4+Pj4gLQlrZnJlZShwcW4tPnEtPnByb3BlcnRpZXMuY3VfbWFzayk7DQo+Pj4+
ICsJV0FSTl9PTl9PTkNFKHBxbi0+cS0+cHJvcGVydGllcy5jdV9tYXNrKTsNCj4+Pj4NCj4+Pj4g
ICAJcHFuLT5xLT5wcm9wZXJ0aWVzLmN1X21hc2tfY291bnQgPSBwLT5jdV9tYXNrX2NvdW50Ow0K
Pj4+PiAgIAlwcW4tPnEtPnByb3BlcnRpZXMuY3VfbWFzayA9IHAtPmN1X21hc2s7DQo+Pj4+DQo+
Pj4+ICAgCXJldHZhbCA9IHBxbi0+cS0+ZGV2aWNlLT5kcW0tPm9wcy51cGRhdGVfcXVldWUocHFu
LT5xLT5kZXZpY2UtPmRxbSwNCj4+Pj4gICAJCQkJCQkJcHFuLT5xKTsNCj4+Pj4gKw0KPj4+PiAr
CXBxbi0+cS0+cHJvcGVydGllcy5jdV9tYXNrID0gTlVMTDsNCj4+Pj4gKw0KPj4+IFRoaXMgd29u
J3Qgd29yayBjb3JyZWN0bHkuIFdlIG5lZWQgdG8gc2F2ZSB0aGUgY3VfbWFzayBmb3IgbGF0ZXIu
DQo+Pj4gT3RoZXJ3aXNlIHRoZSBuZXh0IHRpbWUgZHFtLT5vcHMudXBkYXRlX3F1ZXVlIGlzIGNh
bGxlZCwgZm9yIGV4YW1wbGUNCj4+PiBpbiBwcW1fdXBkYXRlX3F1ZXVlIG9yIHBxbV9zZXRfZ3dz
LCBpdCB3aWxsIHdpcGUgb3V0IHRoZSBDVSBtYXNrIGluIHRoZQ0KPk1RRC4NCj4+IExldCdzIGp1
c3QgcmV0dXJuIHdoZW4gbWVldGluZyBhIG51bGwgY3VfbWFzayBpbiB1cGRhdGVfY3VfbWFzaygp
IHRvIGF2b2lkDQo+dGhhdC4NCj4+IExpa2UgZm9sbG93aW5nLA0KPj4NCj4+IHN0YXRpYyB2b2lk
IHVwZGF0ZV9jdV9tYXNrKHN0cnVjdCBtcWRfbWFuYWdlciAqbW0sIHZvaWQgKm1xZCwNCj4+IAkJ
CSAgIHN0cnVjdCBxdWV1ZV9wcm9wZXJ0aWVzICpxKQ0KPj4gew0KPj4gCXN0cnVjdCB2MTBfY29t
cHV0ZV9tcWQgKm07DQo+PiAJdWludDMyX3Qgc2VfbWFza1s0XSA9IHswfTsgLyogNCBpcyB0aGUg
bWF4ICMgb2YgU0VzICovDQo+Pg0KPj4gCWlmICghcS0+IGN1X21hc2sgfHwgcS0+Y3VfbWFza19j
b3VudCA9PSAwKQ0KPj4gCQlyZXR1cm47DQo+PiAJLi4uLi4uDQo+PiB9DQo+Pg0KPj4gSXMgdGhp
cyBmaW5lIHdpdGggeW91PyBUaGFua3MhDQo+DQo+SSB0aGluayB0aGF0IGNvdWxkIHdvcmsuIEkg
c3RpbGwgZG9uJ3QgbGlrZSBpdC4gSXQgbGVhdmVzIHRoZSBDVSBtYXNrIGluIHRoZSBxLQ0KPj5w
cm9wZXJ0aWVzIHN0cnVjdHVyZSwgYnV0IGl0J3Mgb25seSBldmVyIHVzZWQgdGVtcG9yYXJpbHkg
YW5kIGRvZXNuJ3QgbmVlZCB0byBiZQ0KPnBlcnNpc3RlbnQuIEknZCBhcmd1ZSwgaW4gdGhpcyBj
YXNlLCB0aGUgY3VfbWFzayBzaG91bGRuJ3QgYmUgaW4gdGhlIHEtPnByb3BlcnRpZXMNCj5zdHJ1
Y3R1cmUgYXQgYWxsLCBidXQgc2hvdWxkIGJlIHBhc3NlZCBhcyBhbiBvcHRpb25hbCBwYXJhbWV0
ZXIgaW50byB0aGUgZHFtLQ0KPj5vcHMudXBkYXRlX3F1ZXVlIGNhbGwuDQoNClRoZSBjdV9tYXNr
IGlzIG9yaWdpbmFsbHkgaW4gcS0+cHJvcGVydGllcyBzdHJ1Y3R1cmUuIEkgZGlkbid0IGNoYW5n
ZSB0aGF0Lg0KV2hhdCBJIHdhbnQgdG8gZG8gaXMga2VlcGluZyB0aGUgY3VfbWFzayBtZW1vcnkg
YWxsb2NhdGlvbiBhbmQgZGVhbGxvY2F0aW9uIGp1c3QgaW4ga2ZkX2lvY3RsX3NldF9jdV9tYXNr
Lg0KaW5zdGVhZCBvZiBldmVyeXdoZXJlLg0KIA0KPkJ1dCBJIHRoaW5rIGEgc2ltcGxlciBmaXgg
d291bGQgYmUgdG8gbW92ZSB0aGUgZnJlZWluZyBvZiB0aGUgQ1UgbWFzayBpbnRvDQo+dW5pbml0
X3F1ZXVlLiBUaGF0IHdvdWxkIGNhdGNoIGFsbCBjYXNlcyB3aGVyZSBhIHF1ZXVlIGdldHMgZGVz
dHJveWVkLCBpbmNsdWRpbmcNCj50aGUgcHJvY2VzcyB0ZXJtaW5hdGlvbiBjYXNlLg0KDQpZZXMs
IGl0JyBiZXR0ZXIgdG8gZnJlZSBxdWV1ZSByZWxhdGVkIHJlc291cmNlIGluIG9uZSBmdW5jdGlv
bi4NCkJ1dCB3ZSBhbGxvY2F0ZSBpdCBpbiBrZmRfaW9jdGxfc2V0X2N1X21hc2sgYW5kIGZyZWUg
aXQgaW4gcHFtX3NldF9jdV9tYXNrLCB1bmluaXRfcXVldWUgYW5kIHNvIG9uLg0KSXQgc2VlbXMg
c3RyYW5nZSBhbmQgZXJyb3ItcHJvbmUuIFVubGVzcyB3ZSBhbGxvY2F0ZSBpdCBpbiBjcmVhdGUg
cXVldWUuICBBcyB5b3Ugc2FpZCwgaXQgaXMgdGVtcG9yYXJ5Lg0KSXQncyBub3Qgd29ydGgga2Vl
cGluZyBpdCB1bnRpbCBxdWV1ZSBpcyBkZXN0cm95ZWQuIFRoYW5rcy4NCg0KUmVnYXJkcywNCkxh
bmcNCg0KPlJlZ2FyZHMsDQo+IMKgIEZlbGl4DQo+DQo+DQo+Pg0KPj4gUmVnYXJkcywNCj4+IExh
bmcNCj4+DQo+Pj4gUmVnYXJkcywNCj4+PiAgwqAgRmVsaXgNCj4+Pg0KPj4+DQo+Pj4+ICAgCWlm
IChyZXR2YWwgIT0gMCkNCj4+Pj4gICAJCXJldHVybiByZXR2YWw7DQo+Pj4+DQo=

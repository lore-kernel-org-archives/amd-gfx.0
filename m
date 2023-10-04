Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7192CE7C4C8
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 14:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA13510E142;
	Wed,  4 Oct 2023 14:46:37 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9081A10E139
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 14:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNpbcipx657/jot7KyItE83B1a9tazdiH6ibL8qlNbbuzT6SesrJRFUALGiVjoHBXGdF/sQ8fCKx3/WusKzhxX1DIVAUVnMsiTrxpgxpRmczJmhJ2eTWlrD1EQPGV5b3o0kO770xhqjodILhTZ6JtOjDxtBqU1qPRO2uhw6bwc0bH6Z3L+DjpvLrE8tR1NFLpaeA180JlMtrK9eaeFZ7k3OqzsXT3je7auka/nT6DMYLvrAIc1xLppX8kGlY0UBFyolySr3BvbxSG5OVCYbyTtJvWMY0yhU+PML6TXpiwHfC+eW1V8VrG4Y0utMeogHbnLcvM67p8hpFC2efX40kJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eixmrGzxG2HHR21cRqiA1HNuJEVEdD6gOf9F6y1LjOM=;
 b=ZTvkPsDZ491+78UPVMLYkgMTUkKEGb3D06LMLa3pfFyRn+vkhp2yB2oufQRa4FzITVusHt+2Y6IIfxWp3xjqrBOGhcxKQPOYwr18rEPfO5OtilpDnhw0GJ5l4TiWa5NjiX8QVusTnHbhG3s6jVWZG7VgtYupL6LQYxDe4zr826HMce3yY8nCJC7sp442OJC4fQUhybuMXT16RoLTpHKso42xoda69JAqgzJ1Zp/k1UlC3Ihcu0IEcA9iRyv3fuBYNCtnjeqA8bwx/s6dNpmjCR3URZIeDV0LSNcMFKaoWHvAaZ3dIkuf3WLsLTqUSPWaQEA6TYCSAmhAfm/Qt9t/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eixmrGzxG2HHR21cRqiA1HNuJEVEdD6gOf9F6y1LjOM=;
 b=n9haPN/V0DlGk8aLLcItoSS+QLxmqrcwYvwbZpv6wxwJeyVHhc5GiRVCBpUreumFX+NHjl1Ag/C9vCHOeXpGlfJ8c7Hxq1JTcBipiHBWOUQ85rAZ9IiDsG1EHr/E+F3tcwh/dx6Rf2whBraHHrCns/iXgDXkEmzXptY/+wDoWmE=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH0PR12MB7790.namprd12.prod.outlook.com (2603:10b6:510:289::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Wed, 4 Oct
 2023 14:46:32 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a%7]) with mapi id 15.20.6838.029; Wed, 4 Oct 2023
 14:46:32 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Enable SMU 13.0.0 optimizations when ROCm is
 active
Thread-Topic: [PATCH] drm/amdgpu: Enable SMU 13.0.0 optimizations when ROCm is
 active
Thread-Index: AQHZ9izsYaJj05dYqUWXOcBDhmvAHbA5qwCAgAAKPDA=
Date: Wed, 4 Oct 2023 14:46:32 +0000
Message-ID: <PH7PR12MB59970BA3BCDE01CC2B6CF41382CBA@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231003190731.106594-1-alexander.deucher@amd.com>
 <CADnq5_OTfvO0piqPPnvMrJCq9YJmQ8pJrPZh_Fuz1MNNikv-6A@mail.gmail.com>
In-Reply-To: <CADnq5_OTfvO0piqPPnvMrJCq9YJmQ8pJrPZh_Fuz1MNNikv-6A@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH0PR12MB7790:EE_
x-ms-office365-filtering-correlation-id: 1e71944d-d020-4d39-8331-08dbc4e8b35e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2fJ6HgnjBLYllL5SdnbB+Dny2z5P/Rf0ZrjI7Oi59Jo5mobs8jFLa9EEtmleWUeOQPBvtVPTLBXfnXw3i0b9AVhgbi2i2cYkfnzSB37JIVPcBg+RlKBeOha9hTm2J2NuKnkNh5tpwiMeY/My4AKJNXHjvL9nATamzm1W2lVwiVLjlKS5dUXQbEFCYoHTN3jdsa3t/BH3SlRPNgctSQCzxoNySTEm8FlzXjUcgGciVRbdMpiDU1sJKD8h3ku4S9m43Sx+Fuy+7wASlTI1oUuL2eCFmEaSo0smvxbj4gw7Jm51liSVKv3Db+n9b6nJh75Au6djYSj2IzSHJVCGDcJJwDk+EkMObuTKteseEwcC1JyEa9MdEXca8vhs10/D2cXiYc5rKFkbz1v8JPmw0mnzgLXEhrYi2GqxvabxBYrwbhuoDwVLvC/csYvKreKivUZw4wBqa198XMj1PflA6PseauzV4bKxj6XeASWFpPnwcmB3SZ50KDX4ZiNlV1wLdfBy9YydxHh4QDPCvNXToYSsba/TH3EAhRwsDVGWq7L9PK3dBq5SVrV7qF6Ainu68rLS9X/Q4GYs1rInbitJhQ/dChbuV8WYUdjStDeVIIHL+go=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(39860400002)(376002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(52536014)(5660300002)(9686003)(53546011)(33656002)(71200400001)(38100700002)(38070700005)(7696005)(6506007)(86362001)(2906002)(55016003)(478600001)(122000001)(26005)(6636002)(8676002)(4326008)(66946007)(110136005)(76116006)(8936002)(64756008)(316002)(83380400001)(66446008)(66476007)(66556008)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sk53Y203NlBoMmNCaWlrajQrYkVQa0dFWWNlOFRObXRncDljVE5lQ3YyVnJP?=
 =?utf-8?B?MzJoUHYxNHNhMWRHY2RZQ1Jxa3YxQWt2dU5vOHd2Y2VURm53N2RvQ3pLZFBB?=
 =?utf-8?B?TE5DWlZUMTRYQnBxNnViZjRvUDV4dUpMODhURi9TTy9IV0tlR0lFNXlYNldi?=
 =?utf-8?B?QUVwajJVWXZFdzRXbFkyZWU2REFscU5MTmFtSUVPVEpjOW9IN2llcitjQWxO?=
 =?utf-8?B?WXFHMUthUmVwY05TblBoeTcyeXVpdDF0NlMxTjhWd1BscWtkRkM1clBSZ1pW?=
 =?utf-8?B?bjJDWGJ5UWNmLzJjcjVzNHU4Y3czMFVHNldOVEFEUTdwRWZnMDk4Vkl6UU9K?=
 =?utf-8?B?VzJFajdwY05zb040RXBXQ3Joc1lnKy9jcERTL0wwS01QQXVMZ3loa3VTM1J3?=
 =?utf-8?B?VG1HUEJLUWtiT1QzME84b3pqMm44Q1RCQW5NZ1Z5K05YcEU0M3VHYk5PTFF6?=
 =?utf-8?B?ZkdNK2wzTHphRlVRK0dndjczcTRmSkNjeXk2OTNSTXVjeExBL1Fvb09LKzVJ?=
 =?utf-8?B?L1VIeUlPSU13V0k3N0hYZlRSZzhNNkJNS2tZWHV0MjFoNXFrZThiODJxWVA4?=
 =?utf-8?B?RDhOaDJrMU9SRE9yUVU2T3R6TklxWE52WWlkemhubUZlUWs5bEFOT1E4c2JJ?=
 =?utf-8?B?d0toeE5RdEx4V0JoZWtleGZZejkwSDZyWkxZd1NodmxEQk9IUE81amhDUW0v?=
 =?utf-8?B?RjZhQkdYbEhJdmRqaTFQMTFQN3U1T2pzc014UnNQUlQ2RGJTS1dXQ0g2SlZN?=
 =?utf-8?B?bnR5Rzc2cXZpOWN3cExqODN3RHQ0MTBoSHcwazVIcTB0N3NFYnEvR1FsMjd2?=
 =?utf-8?B?ZVAvMmd2WUxHZkhxejNGNWdIQjVxNXhVZE03SW9LWXBOOGljbjBHeHc2S0tO?=
 =?utf-8?B?M2lKQnVWZG1vYStOdGRxR1oxcmxsVnc5UFpmcjFrY0ptQU4vUklGQkNHc1hT?=
 =?utf-8?B?VHFZczRxTFgxUDFuUHBKbThHNzcrWjUySVRqNzhvUGJyd3lkbEZmQ0JlV0FR?=
 =?utf-8?B?QUlaUWREV2t5Zk5SMFgwUjVMRlZwWGhxekIvTmhpQUxvaGlOWnJTeHdidGoy?=
 =?utf-8?B?KzE4TTdoQkNveFdMSlN6aXRMVjl2SXBndE1WVDY4VjZrYjlUUEFVdzJlbHdl?=
 =?utf-8?B?ak8wek1TbGdwRmxKTmt5enJmcUs1RzVCQmFjYlVleGxFT0QvQmhWWUhhcit4?=
 =?utf-8?B?SEtvY0VHUnMwcDI3UmIvSWwyNWtBQUgxanRDazFKamQ0U1BIY0N1OThMRk03?=
 =?utf-8?B?MFBRZE5yM0R5enlhUW1wQXJ3enV6OUN2MzAvUXJxM3NQU1lhUEdVYXhHS2JG?=
 =?utf-8?B?Y0s0MzhlODdIK2hWalhtQmlMV1A5WFhnT0JZS0FyeDNwRWRiNHlSY0JDMWR2?=
 =?utf-8?B?N0Nac290ZXhFbUs1aUIxa3BxcXVrRHVqWUpKRUIzdHhqS3hJNDJETGlYNm5x?=
 =?utf-8?B?cUZsK0doc3pTd1FybkQ3MWlTWmNpcnRmOVV4VXRzWHVFaG4zVnJHSmprSDU4?=
 =?utf-8?B?cjdwVk1pRExxSUZQY3RLMGFjbXFTbnJJT2paZGwrYWwzODIvYXpnZGhXbVp2?=
 =?utf-8?B?SnBUNzZCZW0zVmtUZHRhODlEUUhJdU12UjRyVWJqS0FzVFV5YXFKKyswTkp6?=
 =?utf-8?B?bUllb295VzU3UEs5NXZScENpK1RFNnI3YWNhZWFQTXY0bEtXWFVlOWRRQWZ1?=
 =?utf-8?B?WlhLaGgrdnN2dDMzL1A3d2ZNVUYrNmlCV0hEdlUvbXp6ZTkxSE5oTE05MkVW?=
 =?utf-8?B?VEdBN2lyRWVsYWkyYzdvejNOeGc4MEczdzlYZ3dFMlF4UEVLQURUZGR5TGVs?=
 =?utf-8?B?VkVGbHFLckx3WUt2MFArUXVkQlRBUVgrUzZMODIxRktaenBydURJWW9QYWlp?=
 =?utf-8?B?eGVSS3NaUmhPYThaRkJOUXJybHUwNFVtRjFaaDNZOFFGbUlvVXd3U1ZFRHpk?=
 =?utf-8?B?M3VnTWdFNlpvTkExdkxheEZQNnBENlhkS0RvQVZtamE2THo4SnA4VjJrV3Zu?=
 =?utf-8?B?UTNtTVdIczd5Tk5RKys0TDRodkNVV0R6M2xnRVdFaWplOWZ5NTVuazU1NTB6?=
 =?utf-8?B?dWg1bEs5QXRxWDVXQTM2bkNUNEpMMXBIRFlTd1dKT2k0YkxaaDNpdlFZRytR?=
 =?utf-8?Q?4bBQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e71944d-d020-4d39-8331-08dbc4e8b35e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 14:46:32.3254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ozL3nu9YCbKtZ2ifKapGz9Id0mUSVM18DEkedwJrRwKGBOHPZ4h6th5Ve8U6SnIe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7790
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGkgQWxleCwNCg0Kd2h5IG5lZWQgdG8gc3dpdGNoIHByb2ZpbGUgdHdpY2UgZm9yIHNtdSAxMy4w
LjAgPyBpbiBpZGxlIHN0YXRlIDogc2V0IGNvbXB1dGUgcHJvZmlsZSB0aGVuIHNldCBwb3dlciBz
YXZlIHByb2ZpbGU/DQpBZmFpaywgUG1mdyBhbHdheXMgdXNlcyB0aGUgbGFzdCBzZXQgcmVzdWx0
IHRvIHJlcHJlc2VudCB0aGUgY3VycmVudCBwcm9maWxlLg0KQnV0IGl0IHNob3VsZG4ndCBhZmZl
Y3QgdGhlIHJlc3VsdHMuIEFueXdheS4NCg0KUmV2aWV3ZWQtYnk6IFlhbmcgV2FuZyA8a2V2aW55
YW5nLndhbmdAYW1kLmNvbT4NCg0KQmVzdCBSZWdhcmRzLA0KS2V2aW4NCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVl
ZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBBbGV4IERldWNoZXINClNlbnQ6IFdlZG5lc2RheSwg
T2N0b2JlciA0LCAyMDIzIDEwOjA0IFBNDQpUbzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5k
ZXIuRGV1Y2hlckBhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQpT
dWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBFbmFibGUgU01VIDEzLjAuMCBvcHRpbWl6
YXRpb25zIHdoZW4gUk9DbSBpcyBhY3RpdmUNCg0KUGluZz8NCg0KT24gVHVlLCBPY3QgMywgMjAy
MyBhdCA2OjQ34oCvUE0gQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPiB3
cm90ZToNCj4NCj4gV2hlbiBST0NtIGlzIGFjdGl2ZSBlbmFibGUgYWRkaXRpb25hbCBTTVUgMTMu
MC4wIG9wdGltaXphdGlvbnMuDQo+IFRoaXMgcmV1c2VzIHRoZSB1bnVzZWQgcG93ZXJzYXZlIHBy
b2ZpbGUgb24gUE1GVy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9hbWRrZmQuYyB8IDggKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2Vy
dGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9hbWRrZmQuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQu
Yw0KPiBpbmRleCAzOGI1NDU3YmFkZWQuLmI2YzBjNDJkZTcyNSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jDQo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYw0KPiBAQCAtNzE0LDYgKzcxNCwxNCBA
QCB2b2lkIGFtZGdwdV9hbWRrZmRfc2V0X2NvbXB1dGVfaWRsZShzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwgYm9vbCBpZGxlKQ0KPiAgICAgICAgIGFtZGdwdV9kcG1fc3dpdGNoX3Bvd2VyX3By
b2ZpbGUoYWRldiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBQ
X1NNQ19QT1dFUl9QUk9GSUxFX0NPTVBVVEUsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAhaWRsZSk7DQo+ICsgICAgICAgLyogQWRkIG9wdGltaXphdGlvbnMgZm9y
IFNNVTEzLjAuMC4gIFJldXNlIHRoZSBwb3dlciBzYXZpbmcgcHJvZmlsZSAqLw0KPiArICAgICAg
IGlmICgoYW1kZ3B1X2lwX3ZlcnNpb24oYWRldiwgTVAxX0hXSVAsIDApID09IElQX1ZFUlNJT04o
MTMsIDAsIDApKSAmJg0KPiArICAgICAgICAgICAoKGFkZXYtPnBtLmZ3X3ZlcnNpb24gPT0gMHgw
MDRlNjYwMSkgfHwNCj4gKyAgICAgICAgICAgIChhZGV2LT5wbS5md192ZXJzaW9uID49IDB4MDA0
ZTczMDApKSkgew0KPiArICAgICAgICAgICAgICAgYW1kZ3B1X2RwbV9zd2l0Y2hfcG93ZXJfcHJv
ZmlsZShhZGV2LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBQUF9TTUNfUE9XRVJfUFJPRklMRV9QT1dFUlNBVklORywNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIWlkbGUpOw0KPiArICAgICAgIH0NCj4g
IH0NCj4NCj4gIGJvb2wgYW1kZ3B1X2FtZGtmZF9pc19rZmRfdm1pZChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwgdTMyIHZtaWQpDQo+IC0tDQo+IDIuNDEuMA0KPg0K

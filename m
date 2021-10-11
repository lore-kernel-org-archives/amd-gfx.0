Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C964CC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 14:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF2A60C41
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 14:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8CF2A60C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F1AA89D42;
	Mon, 11 Oct 2021 14:27:28 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B06189D64
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 14:27:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMDrl4Z3Je+1dQcVLoFam18y33H+2UFgbR5owjRThQCYPYvpGsRcePvFM99PnSy5fmMMnrxOMRfgTx4xkjZ1WcDkONkw+DvwWr+o8PR1ciRM1S93UuEj9x64KZJctSO+eKbfIjC2wRGKFMH0mN3oNninEFTHpmxKt/P0bMiW2Ct4OQsvoYeEehs2z8wNHT+MSXmiMbH57KLK6s79R+S7hq31Tk63asDcGx2AhMb773sDREy7EoUgK/ijjNK+af96OA4s4UynQZSZDGn5SKSdJARZ9+aYer8Uxrnklmm/dT5bgHu/Ha4aMC+SH558yWQgjPj/OPodsFHJh28RyufEpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIHmLhlaA8ALqt7zP0jcrHRzHBAiIRLAVtzeEAAEWqE=;
 b=NJWZh+Jfw8/hfvENrB9BjAwxshZWo+LNPUOKQn7aSci+Hi4xNzlvPS14kt7XnxI+9O2DhA8Nf1EHfibEOz0y8I+00n7btG/pVnhSDl9u0H0T8jaJEKR0vm8FD2oUVb7z/80rjfuX+iUSov9PnMmNe5UJ7VJTBGwmyLoqAGJq/zHK3SUrhIgJC2+hIDN1EZ/Sil/rVoplqFqH7uqfS/R0SvN2wZ+ERfxFSo7pauokc9u5Tls2sbqQIL6cEGXSbxhqJKNw5hh5vhCcVYtxvukaxXCahiFOz7yzKQCDJsxVDurKfwPV/aCTOobjq0GnYNYGEEkn2XXVX57betCFACrh1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIHmLhlaA8ALqt7zP0jcrHRzHBAiIRLAVtzeEAAEWqE=;
 b=hjfeni6pf2L/omV+nO7fw1q6XVqAn9FCvp8PovCDFJmKMlBvpaeMvG9IuvV/5shxdUD3gM/d24x3AgJjW0xN+l9pnyTwQ03JYmnHiyQ244gOIujwm8sTVfj7Avgj/YAmXd+tpRIhBT9FY6Wf9QxNJqfsmYfEzUf3+fTJbTDjTsE=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM5PR12MB2502.namprd12.prod.outlook.com (2603:10b6:4:af::28) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25; Mon, 11 Oct 2021 14:27:24 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 14:27:24 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang, Ray"
 <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: query default sclk from smu for cyan_skillfish
Thread-Topic: [PATCH] drm/amdgpu: query default sclk from smu for
 cyan_skillfish
Thread-Index: AQHXvnp+jYdgqQB24ESe2JYFyz9j8avNffuAgABcP0A=
Date: Mon, 11 Oct 2021 14:27:23 +0000
Message-ID: <DM5PR12MB2469C25979CA84EC98C0C793F1B59@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211011083147.577024-1-lang.yu@amd.com>
 <53bf0be2-be7a-5a38-4c04-dbd82a928db0@amd.com>
In-Reply-To: <53bf0be2-be7a-5a38-4c04-dbd82a928db0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-11T14:27:20Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=4c03b156-95d5-45ce-987c-52cc9b2bbd29;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 214d079a-fcff-4d81-2c8d-08d98cc33e39
x-ms-traffictypediagnostic: DM5PR12MB2502:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB2502843EBD16C3C05559B9D9F1B59@DM5PR12MB2502.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j71MmhgP5K0QpVLOS9cl8jow9a0qYSs3Kkd1paE/rwifVOa6MNNmYQcQKvZmepcsHnAXlZL+zmARx3u/R8LtUKemz6Kpzczh9K+eHphXtVe+rTGEo943GMhWXZPVgqa0lNFeGxjoKqBO4X+cp71WEU1wDZke4bqzffSA9CzFvc3geikHuKdqFMtx3JTvLqVqSfDGRoXKK2whfqGOFmMUMpd7/3ZTYKAi4eHtaP1OwDIUvwP/SXesODqaaH/D90W9Rs4f7dSvadUA3IbX21/rnwJkdla8mXoMaTACEKDnny3W5iE8GH7X2TlhygfCUe4r8fye5UfOiHD1vV7Uxlu4HEB2IPBlU8TyhVCUhy9AdITw5YSS68C/O0k8I3Rz4MVnlDlGnWWPstXY001rwcLOTj6DxsfrbmBeHI57jCdfawGehIZup0G7qwVXAWTgoy9F0SFzv3bc12CssTuzmsQysjWtnK0uqYj/TwdvMB/G5yC9bZF0o7o1+TJGmcg2WUfjXfZ2UJZFgk8jc9kLu+YgkGkntu5/N075QgXAcoYizlJD1qsakzXiyBjNeVm/ZE9t1ZtBAhYidYkuEmxyJOK7lYWhJqwGpeWyqhqE9R/kAjaAaSflxzKaeklAHXP9P6E9EBx3szTVsm4iELTBwGC50x0fqfGQkGolT6NDvB152KQigS6qmoVlSX3su5vEzDHg7C1JhMFV7dMBNatPManW/g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(83380400001)(55016002)(7696005)(8676002)(8936002)(122000001)(53546011)(6506007)(38100700002)(186003)(86362001)(9686003)(26005)(71200400001)(66476007)(52536014)(5660300002)(38070700005)(66556008)(33656002)(76116006)(2906002)(66946007)(508600001)(64756008)(66446008)(316002)(110136005)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDRzWm16dXY4OEJlWEhiQnZOUnVuWFpxMmQrWG13WFgyTlpuYnA1eWNQZ1Ja?=
 =?utf-8?B?WDBDNlA0Yi9hR0UwNUVEOC9KM0h3ZFc0VEVwUmhkODVLeFdiMi9BMGdaWW5v?=
 =?utf-8?B?VjhHK1pERnZpZ2RncVFyMXZidGE3K3ZDV05NblZabHhhV2IxYlVnUW1qR1ZB?=
 =?utf-8?B?MW5UUGU0QlAzQm1idDRkaGl6L1RlZ1E5TWR6M2piaFVsWWhXRWw0ejlYbllP?=
 =?utf-8?B?Nzd1L1Myd082Zm1aTTdtaGZZUkExb0xCeW5VWWxmNE9aNzJtajZ2ekFDaCtv?=
 =?utf-8?B?NEpnWWM0ZVZRc1YzYUtNTXV4UDgvVDZxbWdwN1UxdytiWUVvb1cxQS8zZ3RD?=
 =?utf-8?B?c28xSytvUWR1cll2alNpMXJ5OUdEVXdVZURlUXJMeHAvV0N5Q0RNUG8yeXY5?=
 =?utf-8?B?M0Jha21GRSsybTJrOUticGtwRmYyRVE1VENVMjZ0VE5HMDM1bEU2U0JDM2sv?=
 =?utf-8?B?eWlRVVF6T3hvdVVBT21pVk5rTVozcHhtMW5hTGlIS2QrenFONHRoYVpCZnU3?=
 =?utf-8?B?TUpSVFdWVEhKdVdGTkdXVG9sdUVGdVppTHVPTlArdlMvRUV2RHdHOWM5eWRC?=
 =?utf-8?B?TTk4S0ZGZnFmaEx6bzlBVHJheEtCYnZUTG9VVTlhQ051cVorcU00U3QwTVA5?=
 =?utf-8?B?VHpmVWt6V3RvK2JnNS94S2xua05YK1c1Z3lzNFl3TDk4dUFGVnZwTGxqSzc2?=
 =?utf-8?B?RzlGTkNiamkvdzBNaHZya0t4ZWxGYUZ1WG9VWkFDR2xqOGRsL3Q4RDNGOHl5?=
 =?utf-8?B?Zm5sS1FLSms0SFcxeWZnbWdiMWRJMm11OVN0VnJyU2lNMWQ2Z1NlYVc0WVdr?=
 =?utf-8?B?VDBSazkxanhzU1ljOThsWnh5TUJUNkNnVTZGRGpjU293N3Z2V0p4NURELzMx?=
 =?utf-8?B?RWNNYUx1bmJvVENvNm1kcWNpR0ZHMzh4dWFDVGQvM2p3czhWTnptU1FOL0Fp?=
 =?utf-8?B?TTNVUkV0NjBzQlJlVDFxbGpHT01VUlY3Um1xTCt5TDlxcHI4SSszd1NIQUg2?=
 =?utf-8?B?UGYvSDBhaW1oRjlFa2orUFA1QW53V3FvTFg5d1J1eERVbks1c1ViVklXcFR4?=
 =?utf-8?B?eGxMWHZCQVprdjluazdBc0E0djhaUmNxeklCUjdUeFZ2S2tTbXYyakFwanNj?=
 =?utf-8?B?LzVMRGFNODhVYVZJSUZUWDdSb1lNL29FUWE0SnJxUjhMZFlHWmg1TGFYTElW?=
 =?utf-8?B?eFIybitGUUI0NkxUQytRQmUzemc1bHZNQ01naU5ydm1rQlRvRU11SkRIMXh6?=
 =?utf-8?B?L3RUd2FNUUhkM2ZuZWF2ck4xVTlUck9CS0gzYk1qVXhta1NaTEtibmtXNVlv?=
 =?utf-8?B?Ty85TWI5cWlGd1JGNSs1UzRyRUtOZ3ppUzJxQm0wUmI5WGZ4eGNIK1JyWTZO?=
 =?utf-8?B?ZUZhUi9DNTZmVThkRmt2cGxFNkJmRG9oUVVTbUc5Z0RYMDRBK1R5K0x5Z2E5?=
 =?utf-8?B?dHdHRkZmNy9kNHgwMVdDUGhVOHU3dW9tOGljOHc3b2lRaGdjOXVXMUhQVjRX?=
 =?utf-8?B?R3BPWDUwbUJvM0s1a0RvMGxVNkdaYlRrVmJyN0Zmeld3MmdFbDY0ZElObmEr?=
 =?utf-8?B?N3A3M25GVnBsRlgrSXR0T0hZeEF0TW9rS0tvQUJWbi9sbm5RLzVWR2cxZTdH?=
 =?utf-8?B?eEtrVmFuMVo0aGUwaDMyWEMyRTNFcmFjZ2tKR0NURUZrTUU5RE9PbUhtS2JU?=
 =?utf-8?B?dXgyVXl0aVFqTXpYNi9zQTBJME1TSjE2ZE1QU2hndVl0TWRTcklIOVlHSHYw?=
 =?utf-8?Q?g/qHzNsoJtghTvaE+EePcR3BCn7lBv1RjAoVO4T?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214d079a-fcff-4d81-2c8d-08d98cc33e39
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2021 14:27:23.8622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jv++6mkQaF+eG0nz7TOymaTi6B1ZHZllbK30fp0s/1kRlJjqwFfhmC5o04w6M686ruDkR8NYD6WWMf+lcibScg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2502
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

W1B1YmxpY10NCg0KR2xvYmFsIHZhcmlhYmxlIHRvIGNhcnJ5IHRoZSBzY2xrIHZhbHVlIGxvb2tz
IGEgYml0IG92ZXIta2lsbGVkLiBJcyBpdCBwb3NzaWJsZSB0aGF0IG1vdmUgYWxsIGludG8gY3lh
bl9za2lsbGZpc2hfb2RfZWRpdF9kcG1fdGFibGUsIGxpa2UgcXVlcnlpbmcgc2NsayBmaXJzdCBh
bmQgc2V0dGluZyBpdCB0byBjeWFuX3NraWxsZmlzaF91c2VyX3NldHRpbmdzLnNjbGs/DQoNClJl
Z2FyZHMsDQpHdWNodW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IGFtZC1n
ZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBM
YXphciwgTGlqbw0KU2VudDogTW9uZGF5LCBPY3RvYmVyIDExLCAyMDIxIDQ6NTQgUE0NClRvOiBZ
dSwgTGFuZyA8TGFuZy5ZdUBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcN
CkNjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBIdWFu
ZywgUmF5IDxSYXkuSHVhbmdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRn
cHU6IHF1ZXJ5IGRlZmF1bHQgc2NsayBmcm9tIHNtdSBmb3IgY3lhbl9za2lsbGZpc2gNCg0KDQoN
Ck9uIDEwLzExLzIwMjEgMjowMSBQTSwgTGFuZyBZdSB3cm90ZToNCj4gUXVlcnkgZGVmYXVsdCBz
Y2xrIGluc3RlYWQgb2YgaGFyZCBjb2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTGFuZyBZdSA8
bGFuZy55dUBhbWQuY29tPg0KPiAtLS0NCj4gICAuLi4vZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211
MTEvY3lhbl9za2lsbGZpc2hfcHB0LmMgIHwgMTIgKysrKysrKysrLS0tDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL2N5YW5fc2tpbGxmaXNoX3BwdC5j
IA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvY3lhbl9za2lsbGZpc2hf
cHB0LmMNCj4gaW5kZXggM2Q0YzY1YmMyOWRjLi5kOThmZDA2YTI1NzQgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvY3lhbl9za2lsbGZpc2hfcHB0LmMN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9jeWFuX3NraWxsZmlz
aF9wcHQuYw0KPiBAQCAtNDcsNyArNDcsNiBAQA0KPiAgIC8qIHVuaXQ6IE1IeiAqLw0KPiAgICNk
ZWZpbmUgQ1lBTl9TS0lMTEZJU0hfU0NMS19NSU4JCQkxMDAwDQo+ICAgI2RlZmluZSBDWUFOX1NL
SUxMRklTSF9TQ0xLX01BWAkJCTIwMDANCj4gLSNkZWZpbmUgQ1lBTl9TS0lMTEZJU0hfU0NMS19E
RUZBVUxUCQkJMTgwMA0KPiAgIA0KPiAgIC8qIHVuaXQ6IG1WICovDQo+ICAgI2RlZmluZSBDWUFO
X1NLSUxMRklTSF9WRERDX01JTgkJCTcwMA0KPiBAQCAtNTksNiArNTgsOCBAQCBzdGF0aWMgc3Ry
dWN0IGdmeF91c2VyX3NldHRpbmdzIHsNCj4gICAJdWludDMyX3QgdmRkYzsNCj4gICB9IGN5YW5f
c2tpbGxmaXNoX3VzZXJfc2V0dGluZ3M7DQo+ICAgDQo+ICtzdGF0aWMgdWludDMyX3QgY3lhbl9z
a2lsbGZpc2hfc2Nsa19kZWZhdWx0Ow0KPiArDQo+ICAgI2RlZmluZSBGRUFUVVJFX01BU0soZmVh
dHVyZSkgKDFVTEwgPDwgZmVhdHVyZSkNCj4gICAjZGVmaW5lIFNNQ19EUE1fRkVBVFVSRSAoIFwN
Cj4gICAJRkVBVFVSRV9NQVNLKEZFQVRVUkVfRkNMS19EUE1fQklUKQl8CVwNCj4gQEAgLTM2NSwx
MyArMzY2LDE4IEBAIHN0YXRpYyBib29sIGN5YW5fc2tpbGxmaXNoX2lzX2RwbV9ydW5uaW5nKHN0
cnVjdCBzbXVfY29udGV4dCAqc211KQ0KPiAgIAkJcmV0dXJuIGZhbHNlOw0KPiAgIA0KPiAgIAly
ZXQgPSBzbXVfY21uX2dldF9lbmFibGVkXzMyX2JpdHNfbWFzayhzbXUsIGZlYXR1cmVfbWFzaywg
Mik7DQo+IC0NCj4gICAJaWYgKHJldCkNCj4gICAJCXJldHVybiBmYWxzZTsNCj4gICANCj4gICAJ
ZmVhdHVyZV9lbmFibGVkID0gKHVpbnQ2NF90KWZlYXR1cmVfbWFza1swXSB8DQo+ICAgCQkJCSgo
dWludDY0X3QpZmVhdHVyZV9tYXNrWzFdIDw8IDMyKTsNCj4gICANCj4gKwkvKg0KPiArCSAqIGN5
YW5fc2tpbGxmaXNoIHNwZWNpZmljLCBxdWVyeSBkZWZhdWx0IHNjbGsgaW5zZXRlZCBvZiBoYXJk
IGNvZGUuDQo+ICsJICovDQo+ICsJY3lhbl9za2lsbGZpc2hfZ2V0X3NtdV9tZXRyaWNzX2RhdGEo
c211LCBNRVRSSUNTX0NVUlJfR0ZYQ0xLLA0KPiArCQkmY3lhbl9za2lsbGZpc2hfc2Nsa19kZWZh
dWx0KTsNCj4gKw0KDQpNYXliZSBhZGQgaWYgKCFjeWFuX3NraWxsZmlzaF9zY2xrX2RlZmF1bHQp
IHNvIHRoYXQgaXQncyByZWFkIG9ubHkgb25jZSBkdXJpbmcgZHJpdmVyIGxvYWQgYW5kIG5vdCBv
biBldmVyeSBzdXNwZW5kL3Jlc3VtZS4NCg0KUmV2aWV3ZWQtYnk6IExpam8gTGF6YXIgPGxpam8u
bGF6YXJAYW1kLmNvbT4NCg0KVGhhbmtzLA0KTGlqbw0KDQo+ICAgCXJldHVybiAhIShmZWF0dXJl
X2VuYWJsZWQgJiBTTUNfRFBNX0ZFQVRVUkUpOw0KPiAgIH0NCj4gICANCj4gQEAgLTQ2OCw3ICs0
NzQsNyBAQCBzdGF0aWMgaW50IGN5YW5fc2tpbGxmaXNoX29kX2VkaXRfZHBtX3RhYmxlKHN0cnVj
dCBzbXVfY29udGV4dCAqc211LA0KPiAgIAkJCXJldHVybiAtRUlOVkFMOw0KPiAgIAkJfQ0KPiAg
IA0KPiAtCQljeWFuX3NraWxsZmlzaF91c2VyX3NldHRpbmdzLnNjbGsgPSBDWUFOX1NLSUxMRklT
SF9TQ0xLX0RFRkFVTFQ7DQo+ICsJCWN5YW5fc2tpbGxmaXNoX3VzZXJfc2V0dGluZ3Muc2NsayA9
IGN5YW5fc2tpbGxmaXNoX3NjbGtfZGVmYXVsdDsNCj4gICAJCWN5YW5fc2tpbGxmaXNoX3VzZXJf
c2V0dGluZ3MudmRkYyA9IENZQU5fU0tJTExGSVNIX1ZERENfTUFHSUM7DQo+ICAgDQo+ICAgCQli
cmVhazsNCj4gDQo=

Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D5EC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 04:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18F4D61186
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 04:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 18F4D61186
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A42C76E57E;
	Fri, 22 Oct 2021 04:35:46 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2042.outbound.protection.outlook.com [40.107.100.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85D206E57E
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 04:35:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afxrmS5t9BWIMY+W1sClvT9JZEwICIId5aUjTOu946gjUXz6XwERwo2qRxT+wTY3Ys9vXCQMN4E8Cuv1A2S1lumZS4i356PLcEciTNtRImwaNxdr9qzY8tlrKoGsOgZboTQLqoDv1i23+ryCupd+nIGpOkIaBPxxr7XQDlVbg4VbQnmLcvdB/IVINUzaLnCbFCtXCebwUoF5C3suSa1dnEdAQ/Es4BhRrWTdJFx7N5iu9fZ1J8Cu7tVvbWKyNuKWHoR/gCTBTuW8zdyFNGHwZaVPucZ33mnUfRrYQL76Ly+LZiCXOCEp49oVSeG++w/eJFNzJsY9ThTs6Ac3is7bhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3IyK0RY6mYjl8VJlQN775f4AR4LSlC9b1MZlFwWuKY=;
 b=kdHz4U6U66rGxEDPCNBYOd7Fx1HPLcL8nvg359t32ALcwN3MbRxvY9rw5Bh4PjEV3Blp09rpz7Qf3Kl2c/Sxrc2sDgxyZYoL31hDSyONlrEygbuhC6LQ1dDCWKfB5gOXXq6mxvhDvuZzanCiCS01UVVesWWR8gciV7Gbzs9rGjlg2DHjbSKCfOMlVNrEBnfrteDFCIKWBnLV/woNNfIEtT7BQd8sj6RLLsKgEhMcj0W6zzW7QNQQjAicYIogV67vzHPIaYrYaDkg+qxewr8ExRyw3gzrpOWYE0lsZuf3mbBNfJl/cUXrnsqge2kJyDqdUSx7oV+JjgRVQ5/kfazqfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3IyK0RY6mYjl8VJlQN775f4AR4LSlC9b1MZlFwWuKY=;
 b=fvk1Bnbss3s5ecyzcX8lb0YvB67rmn6JpvknJNtpH6MmfWansyb4CwqpoOVXD+n5VLvzzW1v4QJQ2nBsRYCiUIYKmFvy5Zk8CQei5O5CuynGs497zfVq0OH/oqJvz9zDpJotAXUq+L0gPXYhOsbZbPZ6f2F3Bf0CLpFLhW/Dgd0=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3964.namprd12.prod.outlook.com (2603:10b6:5:1c5::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18; Fri, 22 Oct 2021 04:35:42 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4608.018; Fri, 22 Oct 2021
 04:35:42 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/nbio7.4: use original HDP_FLUSH bits for navi1x
Thread-Topic: [PATCH] drm/amdgpu/nbio7.4: use original HDP_FLUSH bits for
 navi1x
Thread-Index: AQHXxvxB20/Z2YFgZ0mnOR62CEtCvqvebNYAgAABleA=
Date: Fri, 22 Oct 2021 04:35:42 +0000
Message-ID: <DM5PR12MB2469282511E0F2AD53B0257CF1809@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211022042046.959686-1-alexander.deucher@amd.com>
 <CADnq5_O8Ds1j8aOSQJJEUd=fNPez-djXmi2f4yrST=Ot=-wMhg@mail.gmail.com>
In-Reply-To: <CADnq5_O8Ds1j8aOSQJJEUd=fNPez-djXmi2f4yrST=Ot=-wMhg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-22T04:35:39Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=26508c10-f5ed-441d-9e1f-3b5bf66b274b;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3c7b43a-8ae3-4b34-006b-08d995156864
x-ms-traffictypediagnostic: DM6PR12MB3964:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3964F7EEB0BBD68890EAB354F1809@DM6PR12MB3964.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZHA5fDf2u2ajruCgbXG7W1Gv2NkBwj8nIXHP61dj2VrK0kvo5UkN+uBOa/TyCjR4PGEzCq7xbLcFamsql1gbmaTtrOlRmIwSPl/SP+WlKWs5oRPd2j+lVucHI1sIFz0X7Ba9CfDduahIOZXLEGuxwANzbKKgeFjSObiL5cMKWmhX9lNje2pV0VF2D1DbHrzOeM5go5sBx+U2ppjq5aqwERuKhnGfNzb950BgbNx51ReGctMKbeUS7NNkz7UdkXAMBckqFt8QYBN1NnbkkhaKazEHK90PQX73+OEPUX2iJyBHP1E9h9gEtEKyxzGBjrY+R9V2oM0TJYIxuRNxT4pbgwscoMvoKw0LQ1VttFXbshU5E4D4TxZ7e0/v9SvlDmf97VLUvbdD1mcBN7F/DZ1/Xae915Q9SbSf75M2JyhsL40iCpv3+gF/LKtUzqu/iDVvuiHZDlphltuv1sqhcU/Uxp06tLoa2ipSf0PznB37F9S4jnkiwFI2T2Q1l28YsU8uOjM14WbwYfXAT23/S+whynqROhjzjsy+KanKOCtPDqpWq0oF6dIyKiz77TUrUJPh8FbkTMRubYGj+9wIwkSIn0J/G9LyQp1PnZ2UtPM6n0/tgklPApt3mAi870gMfGmEoEY/hqv987TqooQ3O2ZkbqmuzJkq6Ht04pvwRlBe+PqPZG7/WU4aLRXnCNqI/g40eFK2sXP7PzndYs65P/mlDuuWzqliupGwARDYc4o8x2k5AxezG7WVbykmLSQWdIqu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(110136005)(508600001)(316002)(9686003)(122000001)(55016002)(33656002)(53546011)(8936002)(6636002)(66446008)(6506007)(4326008)(5660300002)(2906002)(26005)(83380400001)(52536014)(66556008)(8676002)(7696005)(38100700002)(38070700005)(186003)(86362001)(66476007)(76116006)(64756008)(66946007)(71200400001)(32563001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2NyekNzbWprWDdFV29pZFQ4ZXdEaVlXTjhtc1RyR212TGRtZ1Zqc2tvY2g1?=
 =?utf-8?B?T3NYQ0dJYVdleDdaUEhuQmtYckxvaUY5TG5rSnJFc21BZ20xNW9WbEpNS2xB?=
 =?utf-8?B?cTFZU2tRTzFaT2IwQ3JjQU4zTUdRbW8yUEwyVjNoYXdjY0tnWGRUMCtOZzFQ?=
 =?utf-8?B?ZGduU0JqL3VOczVxS2hFWWdMRWNLc3F5QTdBNDdPMW14UTBWWjZCQ1Z4bzFX?=
 =?utf-8?B?eUoxclQ0Mm1iWndZakRxTGt2dGE3Q1FtL2kvWklxRjA1ZVViMUtJTUpDNk1r?=
 =?utf-8?B?MWlVMk9TSzRRQmtScnRhd016dUMwRjhYVlRMb0VzTDgvd3MzQWdpb0p1TW9H?=
 =?utf-8?B?UElxd0taaDB3dFBvSG5JMmZEYWIvbW0yOHdxakJtNWxOMWdhdjBPWisraVVN?=
 =?utf-8?B?RldKMkVCQWFkdVdJUndqK1RETjFNNVpBODVESmFHUzhYK2tsNnN0WjltOGNK?=
 =?utf-8?B?TmVUbFRQdURXM2N1bEFOc3hwZ1JPVUVETithNkZsajNiNnpiNFpVczRwN3Zt?=
 =?utf-8?B?OVVxYjhVckk3YzFrUHVlRjVuWitHbXg2d0oyU1Y0Q2NoNGpGbnZGV0YzUkIr?=
 =?utf-8?B?VkFHY1N0aHBKYVRUSXdHc0l5d0FBUEhQSnF5VEZOelVhTXJ3Q2dxejc5UThG?=
 =?utf-8?B?Y05PaTNadVNrRGprZTdpdGRkbW95TE9nN05aNXZnaGk0eUJQd3JJSWZCOHYx?=
 =?utf-8?B?RW5rcXB3KzhzZnZyV1Q5VU9BRmIxeFljZlFYVnFPdlgzcFlVakFYSFVIemtl?=
 =?utf-8?B?OUtpUjUwTVhYRTlvcDFtTXR2SHMvd29pN1B6ZktobU41dENTMzdqNVRJMjc5?=
 =?utf-8?B?aldibm0zU01MUUMveXlTUU5WRit5NThIYjk1RGdyK0hWdkV6aHpHTEQ4SG1s?=
 =?utf-8?B?dE1tcmVwakVGSjFzSUd0VEY3cEZOOFBodHhTTkl0WlFINU14eFBZVmFYS1dL?=
 =?utf-8?B?Y3hNMHg4ZU5WTElKQkdtLytvOGwzc1lmbExLQ1ZmZ0hSOFh3WlF4a01pdmpn?=
 =?utf-8?B?WUd3S09IR2NiU2NDeExsOFVrWm1JdDB5RklYZ1Nmc3BUUHFGUzBwRHV3TWhY?=
 =?utf-8?B?emEwQTVuUlppR09BQUVhWXJmQmgyclF0VUhwYlpOLzB3UE9JWkNzVzl6ZjFC?=
 =?utf-8?B?Y0VkQ0pkNUtBWkRzS2x0TEtjUzNLcWV3QVZOWVhvMmN6bVJsbUNEQ0RvZEN1?=
 =?utf-8?B?VnpMSk5MSDYrSmR3R0drTWJNNGYwUzV1Y2NySzFNTURhNFpPd29HVkVGem9h?=
 =?utf-8?B?bzdQVEJkL0JaR0c2LytJTHd6cWFiTUt1WTdIZzYxMjNhZ0xCaWVsZm95YzU5?=
 =?utf-8?B?SDZjaW5BVXNUZ2ZuaGlmcksrYXFpNUQ2eGNiNGttcXR0MTQ3eUlTMHFrWjR5?=
 =?utf-8?B?L0ZTZWI3dUgwVit1TGRRZk5LNHRrcUlPSFZNZ20wZEVnQmhCV2t6UmdNbWVn?=
 =?utf-8?B?T0UwckpsTVdVWmJrZGRuaWxwS1JYWHVKOGRSYWJBSTN0bTJIbHhBRHpMQTZr?=
 =?utf-8?B?c1o2b1N2TUhTYmxuTWRVd1l3ZmRTYVc3QkpBUWZ3M3NrclZkZHRna3BxOFBP?=
 =?utf-8?B?ZW94RjRKRkVncjQrMmFXZ1Vkc1VmcnFIYjkrbDArODNLMWc0anVqdnQ3TW10?=
 =?utf-8?B?cDJ0bDYzYTJQazhCOXd2UW1NZDJ5azNEZXN3OFcwTHorVEdDSkZJdk90NFQx?=
 =?utf-8?B?SjVTV0lKYm43dndpdVRURC96cHQ1eVFldnVjVE9RdHNHd0VNTG5WcEl5cnBJ?=
 =?utf-8?Q?K624qHxMkh8L3jxEIUdbmdcQ05Rs6I4DHivS2/k?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c7b43a-8ae3-4b34-006b-08d995156864
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 04:35:42.6012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guchchen@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3964
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

W1B1YmxpY10NCg0KUmV2aWV3ZWQtYW5kLXRlc3RlZC1ieTogR3VjaHVuIENoZW4gPGd1Y2h1bi5j
aGVuQGFtZC5jb20+DQoNClJlZ2FyZHMsDQpHdWNodW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5v
cmc+IE9uIEJlaGFsZiBPZiBBbGV4IERldWNoZXINClNlbnQ6IEZyaWRheSwgT2N0b2JlciAyMiwg
MjAyMSAxMjozMCBQTQ0KVG86IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJA
YW1kLmNvbT4NCkNjOiBhbWQtZ2Z4IGxpc3QgPGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Pg0KU3ViamVjdDogUmU6IFtQQVRDSF0gZHJtL2FtZGdwdS9uYmlvNy40OiB1c2Ugb3JpZ2luYWwg
SERQX0ZMVVNIIGJpdHMgZm9yIG5hdmkxeA0KDQpPbiBGcmksIE9jdCAyMiwgMjAyMSBhdCAxMjoy
MSBBTSBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+IHdyb3RlOg0KPg0K
DQpDb3B5IHBhc3RlIHR5cG8gaW4gdGhlIHBhdGNoIHRpdGxlIGZpeGVkIGxvY2FsbHkuDQoNCj4g
VGhlIGV4dGVuZGVkIGJpdHMgd2VyZSBub3QgYXZhaWxhYmxlIGZvciB1c2Ugb24gdmVnYTIwIGFu
ZCBwcmVzdW1hYmx5IA0KPiBhcmN0dXJ1cyBhcyB3ZWxsLg0KPg0KPiBGaXhlczogYTBmOWY4NTQ2
NjY4MzQgKCJkcm0vYW1kZ3B1L25iaW83LjQ6IGRvbid0IHVzZSBHUFVfSERQX0ZMVVNIIA0KPiBi
aXQgMTIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rp
c2NvdmVyeS5jIHwgIDUgKysrKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L25iaW9f
djdfNC5jICAgICAgICB8IDE1ICsrKysrKysrKysrKysrKw0KPiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvbmJpb192N180LmggICAgICAgIHwgIDEgKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAy
MCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGlzY292ZXJ5LmMgDQo+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc2NvdmVyeS5jDQo+IGluZGV4IDgxNGU5NjIwZmFjNS4u
MjA4YTc4NDQ3NWJkIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZGlzY292ZXJ5LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2Rpc2NvdmVyeS5jDQo+IEBAIC0xMTI1LDEwICsxMTI1LDEzIEBAIGludCBhbWRncHVfZGlz
Y292ZXJ5X3NldF9pcF9ibG9ja3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+ICAgICAg
ICAgICAgICAgICBicmVhazsNCj4gICAgICAgICBjYXNlIElQX1ZFUlNJT04oNywgNCwgMCk6DQo+
ICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDcsIDQsIDEpOg0KPiAtICAgICAgIGNhc2UgSVBfVkVS
U0lPTig3LCA0LCA0KToNCj4gICAgICAgICAgICAgICAgIGFkZXYtPm5iaW8uZnVuY3MgPSAmbmJp
b192N180X2Z1bmNzOw0KPiAgICAgICAgICAgICAgICAgYWRldi0+bmJpby5oZHBfZmx1c2hfcmVn
ID0gJm5iaW9fdjdfNF9oZHBfZmx1c2hfcmVnOw0KPiAgICAgICAgICAgICAgICAgYnJlYWs7DQo+
ICsgICAgICAgY2FzZSBJUF9WRVJTSU9OKDcsIDQsIDQpOg0KPiArICAgICAgICAgICAgICAgYWRl
di0+bmJpby5mdW5jcyA9ICZuYmlvX3Y3XzRfZnVuY3M7DQo+ICsgICAgICAgICAgICAgICBhZGV2
LT5uYmlvLmhkcF9mbHVzaF9yZWcgPSAmbmJpb192N180X2hkcF9mbHVzaF9yZWdfYWxkOw0KPiAr
ICAgICAgICAgICAgICAgYnJlYWs7DQo+ICAgICAgICAgY2FzZSBJUF9WRVJTSU9OKDcsIDIsIDAp
Og0KPiAgICAgICAgIGNhc2UgSVBfVkVSU0lPTig3LCAyLCAxKToNCj4gICAgICAgICBjYXNlIElQ
X1ZFUlNJT04oNywgNSwgMCk6DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9uYmlvX3Y3XzQuYyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYmlvX3Y3
XzQuYw0KPiBpbmRleCAzYjc3NzVkNzRiYjIuLmI4YmQwM2QxNmRiYSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbmJpb192N180LmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvbmJpb192N180LmMNCj4gQEAgLTMyNSw2ICszMjUsMjEgQEAgc3Rh
dGljIHUzMiBuYmlvX3Y3XzRfZ2V0X3BjaWVfZGF0YV9vZmZzZXQoc3RydWN0IA0KPiBhbWRncHVf
ZGV2aWNlICphZGV2KSAgfQ0KPg0KPiAgY29uc3Qgc3RydWN0IG5iaW9faGRwX2ZsdXNoX3JlZyBu
YmlvX3Y3XzRfaGRwX2ZsdXNoX3JlZyA9IHsNCj4gKyAgICAgICAucmVmX2FuZF9tYXNrX2NwMCA9
IEdQVV9IRFBfRkxVU0hfRE9ORV9fQ1AwX01BU0ssDQo+ICsgICAgICAgLnJlZl9hbmRfbWFza19j
cDEgPSBHUFVfSERQX0ZMVVNIX0RPTkVfX0NQMV9NQVNLLA0KPiArICAgICAgIC5yZWZfYW5kX21h
c2tfY3AyID0gR1BVX0hEUF9GTFVTSF9ET05FX19DUDJfTUFTSywNCj4gKyAgICAgICAucmVmX2Fu
ZF9tYXNrX2NwMyA9IEdQVV9IRFBfRkxVU0hfRE9ORV9fQ1AzX01BU0ssDQo+ICsgICAgICAgLnJl
Zl9hbmRfbWFza19jcDQgPSBHUFVfSERQX0ZMVVNIX0RPTkVfX0NQNF9NQVNLLA0KPiArICAgICAg
IC5yZWZfYW5kX21hc2tfY3A1ID0gR1BVX0hEUF9GTFVTSF9ET05FX19DUDVfTUFTSywNCj4gKyAg
ICAgICAucmVmX2FuZF9tYXNrX2NwNiA9IEdQVV9IRFBfRkxVU0hfRE9ORV9fQ1A2X01BU0ssDQo+
ICsgICAgICAgLnJlZl9hbmRfbWFza19jcDcgPSBHUFVfSERQX0ZMVVNIX0RPTkVfX0NQN19NQVNL
LA0KPiArICAgICAgIC5yZWZfYW5kX21hc2tfY3A4ID0gR1BVX0hEUF9GTFVTSF9ET05FX19DUDhf
TUFTSywNCj4gKyAgICAgICAucmVmX2FuZF9tYXNrX2NwOSA9IEdQVV9IRFBfRkxVU0hfRE9ORV9f
Q1A5X01BU0ssDQo+ICsgICAgICAgLnJlZl9hbmRfbWFza19zZG1hMCA9IEdQVV9IRFBfRkxVU0hf
RE9ORV9fU0RNQTBfTUFTSywNCj4gKyAgICAgICAucmVmX2FuZF9tYXNrX3NkbWExID0gR1BVX0hE
UF9GTFVTSF9ET05FX19TRE1BMV9NQVNLLCB9Ow0KPiArDQo+ICtjb25zdCBzdHJ1Y3QgbmJpb19o
ZHBfZmx1c2hfcmVnIG5iaW9fdjdfNF9oZHBfZmx1c2hfcmVnX2FsZCA9IHsNCj4gICAgICAgICAu
cmVmX2FuZF9tYXNrX2NwMCA9IEdQVV9IRFBfRkxVU0hfRE9ORV9fQ1AwX01BU0ssDQo+ICAgICAg
ICAgLnJlZl9hbmRfbWFza19jcDEgPSBHUFVfSERQX0ZMVVNIX0RPTkVfX0NQMV9NQVNLLA0KPiAg
ICAgICAgIC5yZWZfYW5kX21hc2tfY3AyID0gR1BVX0hEUF9GTFVTSF9ET05FX19DUDJfTUFTSywg
ZGlmZiAtLWdpdCANCj4gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYmlvX3Y3XzQuaCAN
Cj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9uYmlvX3Y3XzQuaA0KPiBpbmRleCBiODIx
NjU4MWVjOGQuLmNjNTY5MmRiNmY5OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvbmJpb192N180LmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
bmJpb192N180LmgNCj4gQEAgLTI3LDYgKzI3LDcgQEANCj4gICNpbmNsdWRlICJzb2MxNV9jb21t
b24uaCINCj4NCj4gIGV4dGVybiBjb25zdCBzdHJ1Y3QgbmJpb19oZHBfZmx1c2hfcmVnIG5iaW9f
djdfNF9oZHBfZmx1c2hfcmVnOw0KPiArZXh0ZXJuIGNvbnN0IHN0cnVjdCBuYmlvX2hkcF9mbHVz
aF9yZWcgbmJpb192N180X2hkcF9mbHVzaF9yZWdfYWxkOw0KPiAgZXh0ZXJuIGNvbnN0IHN0cnVj
dCBhbWRncHVfbmJpb19mdW5jcyBuYmlvX3Y3XzRfZnVuY3M7ICBleHRlcm4gY29uc3QgDQo+IHN0
cnVjdCBhbWRncHVfbmJpb19yYXNfZnVuY3MgbmJpb192N180X3Jhc19mdW5jczsNCj4NCj4gLS0N
Cj4gMi4zMS4xDQo+DQo=

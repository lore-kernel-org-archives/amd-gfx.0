Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E083EB64DD
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jul 2023 03:15:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA1D010E19C;
	Mon, 17 Jul 2023 03:15:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F05110E19C
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jul 2023 03:15:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TljGCzyCquGws3vpspiRXyKOv1Si4o0KYEIYCzK9mAe/i1Avorg2b1uWj9JEzNy2RK/aXD1aeqTQk3dGkDKKHmWe75YcTb7cc16fzu31mXyufUFPF9iQ3dLXciUS1sAhrcvXgTJeEOsroQyCS4v3tO9ra5kuXxG342VaUbQeKqqKVwXZzWu+mEcjZBK9YukLplAFz3xfUW7u36Ge7KDxqJKSeZf83YgiMmL59aGhSc14WkfBhTquFhYCgNA+ow2BdhJquyfnCj93panFiUpmtraWFOV1TLzRwYE12F1bRzQelt7wzCy9wyIxE+qWQHIIMH2xc9LFw4UbfUyWsGJ0ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnBjCHNH2mX6zKylTFr05/dmFtkNlZEL4GOlG6WtItw=;
 b=UOyF1Z89pDOuPUDUcVTac/C3m2ViPjd51DpJatF/XvwyJdkZDqweiw2zWhSExOWJbsHBMNFC5383hEqN8AO/UpE4gmCT8eHPPfj4waoxBBObpGC3X5OA3KV+JJu5pocFpYli/dmOBDXQFZHRi+FU2JBXIIdnmQCeE/+QdmARt5+PSwZqhjwvjKsdSrlG4thaVROa1Mb52i39Q1DM77lLb4Gf4z1EhywnJPWv4unO9N9dN/LTgvjeHZcTroTd3JU2N9wGXV8cu0/lLtVI5tKYyLuwDcsyB45gFk02ssQGN9o8ADDrbzKxYprCeSIlNa3B5gmolEBc8OkjQNP391s8/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnBjCHNH2mX6zKylTFr05/dmFtkNlZEL4GOlG6WtItw=;
 b=BcRfE5QPB86NVDPcRvjTYewDweb1giSEJYQqasBc6c2U7imlzZfu3rpfGVWj3j+RmTWxWicaBgCdEoS7f7JpG6aLlg9bIGL4ICkkaXCuzLtKW1Dec3lBVgC6p5MovLqRZjKimU6+ZKiM10ij+YG+/8AGMuKwPImfYHVV043vNOY=
Received: from CY5PR12MB6648.namprd12.prod.outlook.com (2603:10b6:930:3e::9)
 by DM4PR12MB5279.namprd12.prod.outlook.com (2603:10b6:5:39f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 03:15:54 +0000
Received: from CY5PR12MB6648.namprd12.prod.outlook.com
 ([fe80::472d:81ab:815a:c6f1]) by CY5PR12MB6648.namprd12.prod.outlook.com
 ([fe80::472d:81ab:815a:c6f1%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 03:15:53 +0000
From: "Guttula, Suresh" <Suresh.Guttula@amd.com>
To: "Liu, Leo" <Leo.Liu@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: allow secure submission on VCN4 ring
Thread-Topic: [PATCH 1/2] drm/amdgpu: allow secure submission on VCN4 ring
Thread-Index: AQHZtjf01Bruor4uakqIgeY8Qx3Bqa+5RHSAgAQHznA=
Date: Mon, 17 Jul 2023 03:15:53 +0000
Message-ID: <CY5PR12MB6648350EC2B84CAD1D68176F933BA@CY5PR12MB6648.namprd12.prod.outlook.com>
References: <20230714094448.3178171-1-Suresh.Guttula@amd.com>
 <f4d3835e-f22e-3403-e917-c23b595784c6@amd.com>
In-Reply-To: <f4d3835e-f22e-3403-e917-c23b595784c6@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6648:EE_|DM4PR12MB5279:EE_
x-ms-office365-filtering-correlation-id: 17acc725-745f-480b-1380-08db86742123
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bzVhlll/DCepmo1UJsXw0DU7IjuVIk47pw67XGi/H6xJwEL/kqJXGNJt4Dwmat/llafJHWbdI/MpHUunSXDBv6a1oPzBDb7TvNbJKpnlf2VbxNqvPDCrwN11uPpMOZUu0Sl1GAnpS37tzLtX9TZwo7QuDLaHgB+3M3S48ZOeSI3Y9+fvbWe6wzrOt0/2klOyXquStpf7cyU7G+EokwJX7hH+8R0pHNsdT74PV6KPKVRPy8ySr++dwbVcWAsnPTD0K0m7013QOjPGuByaRBs7heILFJ+2KMjZxA+64F96SBvFHr5aeu2HgoDK6gFGh8x49W+TP1GkHxpf9qBjh1ZYF9MBLTVsfqObgTrs1hR04CY1MaEYvziXx9UqtDV3kjRjYJYp4tbgJP2foptCjKXuEiUAA+bQ12jlWzkYeNNSNsLlwEc2iKoP/ri8QA5L7JM0AQ+i2Lk4F9LhIh5xxhw2s/XoHdjsrEHbr28+TClgZfcfYrfXESu9/43mCZSzVjVNXvvLMGr0odVYQ7cD9kPRvKhCVe4EO3zPa5Wzi7Iaa/O3GMXdEM2wuD6fpkWnwjZuXQ5rRQHhkmNXj49kvW8uhWGf/nOx3m0uFxXL9n3ZhjM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6648.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(86362001)(2906002)(33656002)(38070700005)(55016003)(186003)(966005)(83380400001)(55236004)(53546011)(9686003)(26005)(6506007)(38100700002)(7696005)(122000001)(110136005)(6636002)(76116006)(4326008)(316002)(66946007)(66476007)(66446008)(64756008)(66556008)(478600001)(5660300002)(71200400001)(8936002)(8676002)(52536014)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVFNT2lBb1RoLzJLUi9BZkFiMHB3NDdzY0dVN0VPc2JQcU0zUVV6YUtYSHZz?=
 =?utf-8?B?ODFyWGY5R2dvZ04xd1RSRytwYWxWb1VOOEZZMGRaK2xyZlpTa3hmVVhlVXJQ?=
 =?utf-8?B?RXlETlh4SzYrS1QzOVgzeS9UWCtWQTkrNGJlZXpHZW5ILzkzSlVQQktVcUM3?=
 =?utf-8?B?NjVqbkZQR2k1TU1pa3RoaUxEUitlNHpVYk1pdzIvaWFxdXdiNFBMRzdZSTNi?=
 =?utf-8?B?K1lWTkFzSEVVSXVHaTBJTmFibjlFaFF2Yk1LL0hwN2pTeERLS0pvbjN2UFFD?=
 =?utf-8?B?TWpDQ25oWHFqdEw4VSt0a3VzeDlTcVFZSlVQZFRESE9wUk9qQmpkblRWVVZP?=
 =?utf-8?B?K0lsUElwQ1RyTUh2THk5VGozcDg3ZmV3eHRZbGJoem9RUjBhZTl1M2tsbm04?=
 =?utf-8?B?b2U5MkVvR3Y1eGgwWGJXZDZjMTVCNW5nTzdvc3Z3KzVHV0FNQ2lPMUUvakJs?=
 =?utf-8?B?bHdKT0Q0M21KZmlrMDZiZDVqc0NmcVhaK1l2cG1GTHl4VkFSeXJzemVyNnVZ?=
 =?utf-8?B?VHZuRmtsdHpyNHI0WFk0L2ttL1RkNEl5TC9NcVllR1JvdEcra1BaRzBhNXB6?=
 =?utf-8?B?VGg0eUk4SXFCNDhWUjlIV1ZLMHIxSFJVaWRabTVvNFRUaVY2dVIrYno1MVRU?=
 =?utf-8?B?VGtlZUkxMHhDWVlpK0VzMy9MWHk0UTdEVVRRVmVRTGE1eXdXeXhuRUhBVXlK?=
 =?utf-8?B?ZUVNZ0VaU0d1QmZUTWM1M3BIVjkveVh5VnpXWko1UEZmUm5ZZXlhNU9GV0Jj?=
 =?utf-8?B?ZE9JS0xvQkhIcUw4a2EzcmxDUkpTeHBzYUs1WEdHSER1ODFzT1VGRXdVRDJ6?=
 =?utf-8?B?TjNNNXZaSHJKQnhVMmtTL1hQanVtSjVtcFlaTGdNZEJDK1hSeTQvTlJiRFh0?=
 =?utf-8?B?REoyWXlOUkpjYmt1RnlLTnN5dURmVW96cU9LcWo2SEtYZCt6bllpbDZURW9I?=
 =?utf-8?B?NEhXYkxGdzJ3Y0UraFIzOVRjNUlDNEZvczBJMm5STWFkV2pEVkh2OVpUTHJS?=
 =?utf-8?B?NGQ5SHpGMXJlWWJPcmVPc2UwVlV6NlhvTC9BYUR2SVhIejdZanpCZ2tseFpx?=
 =?utf-8?B?eTFISm1BbDhuR2FRZlhoVlhRN2NrZTJaMllLdDVGekNZTHJJYjBkVmNJaEt5?=
 =?utf-8?B?WFNCWjlvWWxwSUZaV1l2QURWRUlNQjNvU3R0NDVnTGxwT3pnMHVjK0lQeEJ1?=
 =?utf-8?B?cFpCTnBLVU5sU1VDV2RaZEp1QzY3S3NXang3Z21HRG93bktMaUxjdHNjTHBV?=
 =?utf-8?B?UFRvQS96Zko5RVJwSVJLMU5Fc1V6LysvM2hRUzl3eHRnVDk4Q2szVG03dHQr?=
 =?utf-8?B?QVFqZkFHbEFDNDgrSldVZGtXeWI5ZE91a3o4djgxbTFubk84Z01hUlZjaVEr?=
 =?utf-8?B?WWduOStDb2RnNFZlLzFLR3RGSGtjbDE2WEJKS3E2NXcwOFlmMGJ4bVcxRy9h?=
 =?utf-8?B?UGNpZEpncWRXeHV5V3NoWGF5YTErY01WNjhPVTNid1l2YlhnbCtWNURXTXJL?=
 =?utf-8?B?RU1WekxGYjBjMXNLQkRyRVN5ZkJOUTlnalBxbzU3elVYYVRqVjhWN3IvdWNH?=
 =?utf-8?B?OVdEMzVHVHpLUUw0MU5QMmN6VVlaRXBxdmgzUGhsZG5VWXFYdU5MNVNiVEtB?=
 =?utf-8?B?bkh0NkJMZ1MwM1p4STNKQ25nRnRrQ1puQVJJd0pyd1dZNXJITFJBMjdBNjRk?=
 =?utf-8?B?N0NQT1MvSFlyZnEwaDZ6d0xaOFAwa2NRdldnVWdPemd0TzVpcWdpOU1xRHpN?=
 =?utf-8?B?SHM1Rm9NcFduS2tUUGpmREhrVHUwSGNKdEtDbTlxc2N2eWJQVVVBdkh2c0Nv?=
 =?utf-8?B?emE3cm9lRko4TVVNZkNLbVRDYnp2bzgyaFFCRVJRWUFBa1lQclJFUjVPNk1Y?=
 =?utf-8?B?RWJ5RHdWb1Q2WElMbzV2VnZ5dVdnSHcyODNRdXVMd3p6VGdrQkxhajM3REZS?=
 =?utf-8?B?TWlydS95TVJKb1JpcmZ6MHRUZ3R4UkwzbE1vcmpkUk9hWUlGZ3pBN01mTlhI?=
 =?utf-8?B?eE9XYTd0MjJHdVpDbDk0QVgxTlh1c3JHVTdRUzRPVkhoQzJKajFJbW40WHZC?=
 =?utf-8?B?OGdrR21iTG9FaUhKWUxlSkRsTnhsZmtoV0IyTGRSRCtpYURSMllEVmhnNnRJ?=
 =?utf-8?Q?jxaA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6648.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17acc725-745f-480b-1380-08db86742123
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 03:15:53.2739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GC6LyIenkSY/+XyjKP42LIyUFMPg7A/P3QxWzY0jvTJKE/fVOU1oFZFrGAOQrbPZLQUkaBDQ+TS+164UwCAW0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5279
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

SGkgTGVvLA0KDQpUaGVyZSBhcmUgdHdvIGlzc3VlcyBoZXJlLg0KDQpUaGlzIGNoYW5nZSBmaXhp
bmcgdGhlIENyYXNoIHdoaWxlIHNlY3VyZSBwbGF5YmFjayBhbmQgd2Ugc2VlIGJlbG93IGVycm9y
Og0KMjAyMy0wNy0xNFQxNTo1MToyNC44Mzc1OTJaIEVSUiBrZXJuZWw6IFsgIDEyOS4yNTU4MjNd
IGFtZGdwdSAwMDAwOmMyOjAwLjA6IGFtZGdwdTogc2VjdXJlIHN1Ym1pc3Npb25zIG5vdCBzdXBw
b3J0ZWQgb24gcmluZyA8dmNuX3VuaWZpZWRfMD4NCjIwMjMtMDctMTRUMTU6NTE6MjQuODM3NjAx
WiBFUlIga2VybmVsOiBbICAxMjkuMjU1ODI3XSBbZHJtOmFtZGdwdV9qb2JfcnVuXSAqRVJST1Iq
IEVycm9yIHNjaGVkdWxpbmcgSUJzICgtMjIpDQoyMDIzLTA3LTE0VDE1OjUxOjI0LjgzNzYwM1og
SU5GTyBrZXJuZWw6IFsgIDEyOS4yNTU4MzRdIFtkcm1dIFNraXAgc2NoZWR1bGluZyBJQnMhDQoN
ClRoZSBzZWNvbmQgb25lIDogaHR0cHM6Ly9wYXRjaHdvcmsuZnJlZWRlc2t0b3Aub3JnL3BhdGNo
LzU0NzU4Ny8NCkZpeGluZyB0aGUgZ2FyYmFnZS9jb3JydXB0aW9uLiANCg0KV2l0aCBib3RoIHBh
dGNoZXMgcGxheWJhY2sgd29ya2luZyBmaW5lLg0KDQpUaGFua3MsDQpTdXJlc2ggRw0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGl1LCBMZW8gPExlby5MaXVAYW1kLmNvbT4g
DQpTZW50OiBGcmlkYXksIEp1bHkgMTQsIDIwMjMgNzowOCBQTQ0KVG86IEd1dHR1bGEsIFN1cmVz
aCA8U3VyZXNoLkd1dHR1bGFAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVy
LkRldWNoZXJAYW1kLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFt
ZC5jb20+DQpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6IFJlOiBb
UEFUQ0ggMS8yXSBkcm0vYW1kZ3B1OiBhbGxvdyBzZWN1cmUgc3VibWlzc2lvbiBvbiBWQ040IHJp
bmcNCg0KDQpPbiAyMDIzLTA3LTE0IDA1OjQ0LCBzZ3V0dHVsYSB3cm90ZToNCj4gVGhpcyBwYXRj
aCB3aWxsIGVuYWJsZSBzZWN1cmUgZGVjb2RlIHBsYXliYWNrIG9uIFZDTjQNCj4NCj4gU2lnbmVk
LW9mZi1ieTogc2d1dHR1bGEgPFN1cmVzaC5HdXR0dWxhQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92NF8wLmMgfCAxICsNCj4gICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3Zjbl92NF8wLmMgDQo+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNu
X3Y0XzAuYw0KPiBpbmRleCBlOGMwMmFlMTAxNjMuLmQxOTlmODdmZWJkMSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3Y0XzAuYw0KPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjRfMC5jDQo+IEBAIC0xODA0LDYgKzE4MDQsNyBAQCBz
dGF0aWMgaW50IHZjbl92NF8wX3JpbmdfcGF0Y2hfY3NfaW5fcGxhY2Uoc3RydWN0IGFtZGdwdV9j
c19wYXJzZXIgKnAsDQo+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRncHVfcmluZ19mdW5jcyB2
Y25fdjRfMF91bmlmaWVkX3Jpbmdfdm1fZnVuY3MgPSB7DQo+ICAgCS50eXBlID0gQU1ER1BVX1JJ
TkdfVFlQRV9WQ05fRU5DLA0KPiAgIAkuYWxpZ25fbWFzayA9IDB4M2YsDQo+ICsJLnNlY3VyZV9z
dWJtaXNzaW9uX3N1cHBvcnRlZCA9IHRydWUsDQoNCldlIHNob3VsZCBzZXQgaXQgdG8gdHJ1ZcKg
IHdpdGggVkNONF8wXzQgb25seSBmb3Igbm93LCBhbmQgY2hlY2sgZWl0aGVyIHRoaXMgYm9vbGVh
biBvciBWQ040XzBfNCB3aXRoIHlvdXIgaW1wbGVtZW50YXRpb24gZnJvbSBwYXRjaCAyDQoNClJl
Z2FyZHMsDQoNCkxlbw0KDQoNCj4gICAJLm5vcCA9IFZDTl9FTkNfQ01EX05PX09QLA0KPiAgIAku
Z2V0X3JwdHIgPSB2Y25fdjRfMF91bmlmaWVkX3JpbmdfZ2V0X3JwdHIsDQo+ICAgCS5nZXRfd3B0
ciA9IHZjbl92NF8wX3VuaWZpZWRfcmluZ19nZXRfd3B0ciwNCg==

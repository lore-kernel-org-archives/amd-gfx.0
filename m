Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4AAC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Apr 2022 17:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7383810E1A7;
	Thu, 14 Apr 2022 17:56:19 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2070.outbound.protection.outlook.com [40.107.102.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F09C310E1A7
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Apr 2022 17:56:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UF7t68GwUk6f9aUrZ8dIK/6yHLPNKHAgw7rM9XLwEcnIhFcu7kgdQVoSQ8kPQ0yDQWZ7YMw10swlV2APyCNGseVF//nBxtjOoqd3RVlL5Eudy+e0mF+ruXVHU3BllFnBWYCJFkitEvXRl8x97rgAVseme8Y9As1CncWFm9+iJSDC411DIFof1jcdgbzdTnuHb9ZmNTLY3D8/hbeUk/h6iTpA1fJccV1RbULup6qgSNPtHQbdgpY5PJ6abkhKT9UkjoxaJf68IZ9oZCynQZGUdPDwwt9i9vDiNlAa4HPsKgLTZUbbWlWpee+qq6d11F5brq5gAlmV/j4KSvi1m913AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tk82oGeOl6ifyaBSAZW33ebhQwsKLeJ27lTWonlQFfQ=;
 b=bUhLC73gUQX0iVARvXS/QfJ+N5fZ2jyN+IFZX2tgHPsjcrg1zQTbHHI85PXXFEI3rk8tLlZntjSrMA1q2H8t1uYi5wqxQd6IfeZ2kvDHfzFRC3OZxxv9emoS3z+sBt8jmDgdhfClbucLh9kKnu5UOE8rjUFn8yTSfaDAEongM+ZQ7wNKd23WJU9y1/Wx2N+rU6Yna3LvWlN3+OipB2YW3QBykFSOpk74KYpIxRB90HcBgRDAKmIPnkrpj+vCrxK8/DHnb1yk8hDE2hqxN63nPbVFOaoumfiMKUGroEQAjg0sDi5Z5cOrsT3tbwHTS8k+kxf4Q8w2zXrfkTronEtFnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tk82oGeOl6ifyaBSAZW33ebhQwsKLeJ27lTWonlQFfQ=;
 b=Fp9bRyaFZdEozaK6f6ekcEgKWJolLRrE9cYJ28uDMS3D0nuglAMyP6/LTRA2w8/+3t4A2Y/1JO1EFwg0XzK0x7gXPf8VBItwcCam3mAv4hsh+SscpMU8dw8fvrX4lIJ9WEzkasQtYZLzT44zc5yPUcrt6XH+KIZnaS/AWOPIq50=
Received: from DM6PR12MB5021.namprd12.prod.outlook.com (2603:10b6:5:208::17)
 by DM4PR12MB5842.namprd12.prod.outlook.com (2603:10b6:8:65::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 17:56:17 +0000
Received: from DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8d9:b576:c670:be66]) by DM6PR12MB5021.namprd12.prod.outlook.com
 ([fe80::e8d9:b576:c670:be66%9]) with mapi id 15.20.5144.029; Thu, 14 Apr 2022
 17:56:17 +0000
From: "Yat Sin, David" <David.YatSin@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdkfd: Fix GWS queue count
Thread-Topic: [PATCH 1/2] drm/amdkfd: Fix GWS queue count
Thread-Index: AQHYT05pfRBjPMkt2EqJ/tE/b1rnJKzvf8iAgAAA7sCAAA0igIAAI+9Q
Date: Thu, 14 Apr 2022 17:56:17 +0000
Message-ID: <DM6PR12MB50210D75E67D9ABD0488322A95EF9@DM6PR12MB5021.namprd12.prod.outlook.com>
References: <20220413155145.861750-1-david.yatsin@amd.com>
 <e9eb2603-4997-30e1-ce2a-bd3ae0bec7e1@amd.com>
 <DM6PR12MB5021A8149E735B300611A06295EF9@DM6PR12MB5021.namprd12.prod.outlook.com>
 <370d8e9d-7050-e82e-ba46-d9716d023829@amd.com>
In-Reply-To: <370d8e9d-7050-e82e-ba46-d9716d023829@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c413475-de21-416d-aab7-08da1e40130c
x-ms-traffictypediagnostic: DM4PR12MB5842:EE_
x-microsoft-antispam-prvs: <DM4PR12MB584282A0945B0970C5E0CFB595EF9@DM4PR12MB5842.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8lHgpGb0qEig92ZCqAPe09YSQmtyiiFs0U6MQxdtDr8lMKVjIL34AyA587S2rP567IZ1NpRPGBAi6TJ0QPFznfesmWIjFNlVkv5RoC2345jDu5o2XaGBmZSsaw1xVfpIRU2vqLMJA3g6Zn8svVv4wodXVuzfjcuWFjQ4xijVEgSXKVpOBbQwJASM5BDDhKKrS0zob+HrL1EVhdyOa7g0eBwwbh7saPW8o16PIBXyE81utq1UCzlE0wL6zooCrGkkasIB6oAjc4ac0o3wytbDiJX8nYug5oS02YXFongVghmH9fEJ7Oit5mVFdx0ffDuBLmJt3bsOUocnHWQoMb15L/5yx0GPygV94n/eAJP+BsnrhRsiM43S1wzyLRxAwsDWq6P6l8/sGTPbLdrR7NUgfeUnkfEniYDT+gRMPpdQ8l9k+tGsUwu+PlKgXvcT1jzi1VUq/Is+VT/26VWNQQOordvLDc+s3fG+4uWohPGZqnBC52e9VUAyoWbKv3VwwAvu4COaGWEzhPZbREqWEekQAlOpwWA+h063RtpQZ+12Rd5f1xOVpMQ4nG0NNdZEICS9hv/DtVqRbM/KYfmGeYPSm0BcEeNvf+TwnhPkV4vvYIeS77ZVWqGWAaxwyeZX5qFsPwsC6IcAzQWN1OxXuii+Fl/RH1xQEBIQBsx75/Zr9y2ecmH/VQ0pbNxnvXhpKqBAHw3NTVBRz+Fyx1s9SbA+Dw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5021.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(8936002)(186003)(33656002)(6506007)(9686003)(52536014)(7696005)(53546011)(83380400001)(508600001)(26005)(5660300002)(2906002)(71200400001)(76116006)(110136005)(66556008)(64756008)(38070700005)(122000001)(55016003)(66946007)(8676002)(66446008)(38100700002)(66476007)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnJ1czJodGRya3ZmcDBYWk16SjhqTHcyaXVFSTJCb2VvNjF6RGlIV2lZVllY?=
 =?utf-8?B?UUV1ZitJa0hkbVRCbEgvY2o1bDdWU0dBRnZHSC9HeVdVUE91R0RzYWtrWDJt?=
 =?utf-8?B?TDR0bTdIMnJPTVQrbUVxYjVZb1o2NFIrdktBN2t1VzFhZks1ZS8zQXZGYnpQ?=
 =?utf-8?B?MHR2VXFNVGJEZEFHU2lKZnN2eFVET3EvQTltbHlPV2NBL0lFL3J3SHlmMG45?=
 =?utf-8?B?S1RuSFY4NDdXQy91RWZVdGsrMXBsaHZuWkcxM2lFd0l0MnlzdWVUV0xLWnFq?=
 =?utf-8?B?a3RzdjRDNjMwNE1KY2tGclpsa0JTaFg0UkZHYncrRDlhNEhpRUpRMXkzWHdU?=
 =?utf-8?B?OWlUQjVUWGxkbitUUFhJaFRGL0NVN2ZNVTQ1d3dBeUVjWGVhVlJQcXFNTFNl?=
 =?utf-8?B?ZlFUZlJ3L1ZjZFZOclp4L2hlOHhxcTlvYjkvNnB4V1Z0cGhsNGl0UmFQTXhz?=
 =?utf-8?B?L0RGT3dJbHJDanJ3ajhxK29OcW5tU2JHMThXaDNFS2NlS2xyRHlCNnpONlhi?=
 =?utf-8?B?dWVMNmNsTWliQVNOUGNGMUM1WGlBbFNER241MVRQd0loOExBTktITDNvWEsx?=
 =?utf-8?B?MDZURUZLcms0WTllY3pibVVNQi9xRENMMTJCRCtabncyNzJMbFZvM0ppcnhK?=
 =?utf-8?B?aWJaU2hFQzU1VC9qSmpjVmJnclIzdXM4bHNGemVaWkhSaUphY0dxcldFelV2?=
 =?utf-8?B?WjFwajdLK2p6dmtXT3I4MHZUd3owaDNscHhyZG96eVM5aWFNN1l2YUt5WGdU?=
 =?utf-8?B?SU1ydlZXVlRWYTZEUjRTL3pBOC9qUHhZcURvQ2RSa3BmWVh2NGl5Ly8wTEZP?=
 =?utf-8?B?UFFpZlJXSkMvcUN2T1JwYjBwYTJDSGtqc0l1M09IQklhTFBXdklrMmpTZ3Vt?=
 =?utf-8?B?bTZtL0RQdi9CdlBJMlU4WWJuNjhRQkFaTk41S3dFbHVCVWZMTHRlS2pVVmVa?=
 =?utf-8?B?cU90MkUrci83WGtodkQydU1tQ0d4OEpXaU5Zenp4dDhpUXdKYVQxSndTVmJ6?=
 =?utf-8?B?N0NyTytHTm1OK1hTZEFIRGxkMEFOdEovZUpLSGV0VTVvYWdtZWx3bTY2d2lj?=
 =?utf-8?B?cmtsMFVMaFNuWHZZbHJTekpLRmYxcTROM3VCQnRIeENOZHJmYmRCU1dyUUlY?=
 =?utf-8?B?RjRHRkNvZnNvclNvL0Z2UzZDRVRWcnZqbFFGSEdTcHcrVnNaLzREblRwS2pk?=
 =?utf-8?B?amZnUEFmbWluL0tzeWowYTQxbnJTYTNXWURUS0Q2bU83ay8zL2xCQ2ZBTzRh?=
 =?utf-8?B?bWJiNUlxZmtQWUlDeEgvOE9HbnlyeEhDdHFCRDlXdmdaUktTZ1hJUllHaGZN?=
 =?utf-8?B?ejJJeTN5cVNtUXVQNFJOdWpkaDZaVFl5c0RzR2grRWppOVkxNGQ5N0xjUUpk?=
 =?utf-8?B?QitUVXlHSlBwbGdyaFRMSTd5ZWN1b1F0clpnOHBuREVtbnAyZkFMZ0RDUUVh?=
 =?utf-8?B?a1FMMHd0YmdTQzBKeXMycHJFZkloTlMxMCtUQ3JXakFrbUYzMW9vN3FxVmo5?=
 =?utf-8?B?d1gzbm11RDVLbEV3Y0JCaWw0NVl3bkgzam5UUnRhcEs2WTI5SEVsUTFKUU5z?=
 =?utf-8?B?dDB2RWlQd29uM1FZcjc5ajAyOWVkVUxQMC9objlzTVUvNzBFQVdTdU1LZGl1?=
 =?utf-8?B?NXhML0dCWGliaVI5Yjh2Z1VlcUpVSVdJb3NWQStEcFdmZUE0THNMRGxmazI3?=
 =?utf-8?B?ZW5wdm9NZ0prUVJTaDZxa2dxS1dzUjdBTjBjVUpwZ091RnM4VWNSZXJaYTl2?=
 =?utf-8?B?MGNJaEhwcS9vMGFod3pLZWxDYzVZM3U5MWJMRFQ4RDdNNm55SFcranQrY2lw?=
 =?utf-8?B?aUd1Nm52eFBoMHJZTjVvTzFqWVJzdzFEdUg4cm05Yk1velM1UytjL1pxYWcv?=
 =?utf-8?B?RTE2T3pWdkdmVDNPNXJVbWU3RUp2cUNYWU5jWEFmQjIxamVlMDVabEZPYzhQ?=
 =?utf-8?B?UWlCODdzQm12YTRPbmo1QlRXQmNoaU1FNWt6L2pLSEE5WFNseXZmcnI2RmNE?=
 =?utf-8?B?d253MURGMXFMNnIyQXlCWnNvMUNCYnZSZURJWmNKYTJqQk9YQ3RMM0JrRGcz?=
 =?utf-8?B?R2p1eXJ5OHpaa0dyRUJLQWNuMjV2Tk01djNwWU5tTzdZVlFoTGtRUmdYT0lt?=
 =?utf-8?B?cXRjRXdwcVBmaFZrUTErUlVmWjFnUzJPOW1VdkoyM0dRbDFiblNUZXZta1lP?=
 =?utf-8?B?YTJLMWpnYXREUm05RnZaSWtoRlVWZVlnejRBYldKYnoyL0lJK21KZWpaL1R4?=
 =?utf-8?B?WE9vMENKZFZRU2ZEcnRMeFVLZ2tVTWtGUGdldzA1N0ZocVV4S1ZTOGJrekZs?=
 =?utf-8?B?bFhJWjV0YmVkdm1pcmNlNTBjM3ZjNWIzNDJKd2FUVGZFTkZtVzBZdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5021.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c413475-de21-416d-aab7-08da1e40130c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 17:56:17.1265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jgkx/hODz5H706iBeEqdxd/HXSYYZVh7E6ouj8uL/KPYRRTGwP1Gulg0wtUgxzjWPPyjMNn3ui40qcbT9dqGWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5842
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3VlaGxpbmcsIEZlbGl4
IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgQXByaWwgMTQsIDIw
MjIgMTE6NDIgQU0NCj4gVG86IFlhdCBTaW4sIERhdmlkIDxEYXZpZC5ZYXRTaW5AYW1kLmNvbT47
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8y
XSBkcm0vYW1ka2ZkOiBGaXggR1dTIHF1ZXVlIGNvdW50DQo+IA0KPiANCj4gQW0gMjAyMi0wNC0x
NCB1bSAxMTowOCBzY2hyaWViIFlhdCBTaW4sIERhdmlkOg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFt
ZC5jb20+DQo+ID4+IFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAxNCwgMjAyMiAxMDo1MiBBTQ0KPiA+
PiBUbzogWWF0IFNpbiwgRGF2aWQgPERhdmlkLllhdFNpbkBhbWQuY29tPjsNCj4gPj4gYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzJdIGRy
bS9hbWRrZmQ6IEZpeCBHV1MgcXVldWUgY291bnQNCj4gPj4NCj4gPj4NCj4gPj4gQW0gMjAyMi0w
NC0xMyB1bSAxMTo1MSBzY2hyaWViIERhdmlkIFlhdCBTaW46DQo+ID4+PiBRdWV1ZSBjYW4gYmUg
aW5hY3RpdmUgZHVyaW5nIHByb2Nlc3MgdGVybWluYXRpb24uIFRoaXMgd291bGQgY2F1c2UNCj4g
Pj4+IGRxbS0+Z3dzX3F1ZXVlX2NvdW50IHRvIG5vdCBiZSBkZWNyZW1lbnRlZC4gVGhlcmUgY2Fu
IG9ubHkgYmUgMQ0KPiBHV1MNCj4gPj4+IHF1ZXVlIHBlciBkZXZpY2UgcHJvY2VzcyBzbyBtb3Zp
bmcgdGhlIGxvZ2ljIG91dCBvZiBsb29wLg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IERh
dmlkIFlhdCBTaW4gPGRhdmlkLnlhdHNpbkBhbWQuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgICAu
Li4vZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jICAgIHwgMTIg
KysrKysrLQ0KPiAtLS0tDQo+ID4+IC0NCj4gPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2Vy
dGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4+Pg0KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jDQo+ID4+PiBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jDQo+
ID4+PiBpbmRleCBhY2Y0Zjc5NzU4NTAuLjdjMTA3Yjg4ZDk0NCAxMDA2NDQNCj4gPj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jDQo+
ID4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21h
bmFnZXIuYw0KPiA+Pj4gQEAgLTE5NDUsMTcgKzE5NDUsMTcgQEAgc3RhdGljIGludCBwcm9jZXNz
X3Rlcm1pbmF0aW9uX2Nwc2NoKHN0cnVjdA0KPiA+PiBkZXZpY2VfcXVldWVfbWFuYWdlciAqZHFt
LA0KPiA+Pj4gICAgCQllbHNlIGlmIChxLT5wcm9wZXJ0aWVzLnR5cGUgPT0NCj4gPj4gS0ZEX1FV
RVVFX1RZUEVfU0RNQV9YR01JKQ0KPiA+Pj4gICAgCQkJZGVhbGxvY2F0ZV9zZG1hX3F1ZXVlKGRx
bSwgcSk7DQo+ID4+Pg0KPiA+Pj4gLQkJaWYgKHEtPnByb3BlcnRpZXMuaXNfYWN0aXZlKSB7DQo+
ID4+PiArCQlpZiAocS0+cHJvcGVydGllcy5pc19hY3RpdmUpDQo+ID4+PiAgICAJCQlkZWNyZW1l
bnRfcXVldWVfY291bnQoZHFtLCBxLT5wcm9wZXJ0aWVzLnR5cGUpOw0KPiA+Pj4gLQkJCWlmIChx
LT5wcm9wZXJ0aWVzLmlzX2d3cykgew0KPiA+Pj4gLQkJCQlkcW0tPmd3c19xdWV1ZV9jb3VudC0t
Ow0KPiA+Pj4gLQkJCQlxcGQtPm1hcHBlZF9nd3NfcXVldWUgPSBmYWxzZTsNCj4gPj4+IC0JCQl9
DQo+ID4+PiAtCQl9DQo+ID4+IFRoaXMgbG9va3MgbGlrZSB0aGUgb3JpZ2luYWwgaW50ZW50aW9u
IHdhcyB0byBkZWNyZW1lbnQgdGhlIGNvdW50ZXINCj4gPj4gZm9yIGluYWN0aXZlIEdXUyBxdWV1
ZXMuIFRoaXMgbWFrZXMgc2Vuc2UgYmVjYXVzZSB0aGlzIGNvdW50ZXIgaXMNCj4gPj4gdXNlZCB0
byBkZXRlcm1pbmUgd2hldGhlciB0aGUgcnVubGlzdCBpcyBvdmVyc3Vic2NyaWJlZC4gSW5hY3Rp
dmUNCj4gPj4gcXVldWVzIGFyZSBub3QgaW4gdGhlIHJ1bmxpc3QsIHNvIHRoZXkgc2hvdWxkIG5v
dCBiZSBjb3VudGVkLg0KPiA+Pg0KPiA+PiBJIHNlZSB0aGF0IHRoZSBjb3VudGVyIGlzIHVwZGF0
ZWQgd2hlbiBxdWV1ZXMgYXJlIGFjdGl2YXRlZCBhbmQNCj4gPj4gZGVhY3RpdmF0ZWQgaW4gdXBk
YXRlX3F1ZXVlLiBTbyBJTU8gdGhpcyBwYXRjaCBpcyBib3RoIGluY29ycmVjdCBhbmQNCj4gPj4g
dW5uZWNlc3NhcnkuIERpZCB5b3Ugc2VlIGFuIGFjdHVhbCBwcm9ibGVtIHdpdGggdGhlIEdXUyBj
b3VudGVyIGR1cmluZw0KPiBwcm9jZXNzIHRlcm1pbmF0aW9uPw0KPiA+PiBJZiBzbywgSSdkIGxp
a2UgdG8ga25vdyBtb3JlIHRvIHVuZGVyc3RhbmQgdGhlIHJvb3QgY2F1c2UuDQo+ID4+DQo+ID4+
IFJlZ2FyZHMsDQo+ID4+ICAgwqAgRmVsaXgNCj4gPiBZZXMsIHdoZW4gdXNpbmcgYSB1bml0IHRl
c3QgKGZvciBleGFtcGxlIEtGREdXU1Rlc3QuU2VtYXBob3JlKSwgMS4gUHV0DQo+ID4gYSBzbGVl
cCBpbiB0aGUgbWlkZGxlIG9mIHRoZSBhcHBsaWNhdGlvbiAoYWZ0ZXIgY2FsbGluZw0KPiA+IGhz
YUttdEFsbG9jUXVldWVHV1MpIDIuIFJ1biBhcHBsaWNhdGlvbiBhbmQga2lsbCB0aGUgYXBwbGlj
YXRpb24gd2hpY2ggaXQNCj4gaXMgaW4gc2xlZXAgKGFwcGxpY2F0aW9uIG5ldmVyIGNhbGxzIHF1
ZXVlLkRlc3Ryb3koKSkuDQo+ID4NCj4gPiBUaGVuIGluc2lkZSBrZXJuZWwgZHFtLT5nd3NfcXVl
dWVfY291bnQga2VlcHMgaW5jcmVtZW50aW5nIGVhY2ggdGltZQ0KPiB0aGUgZXhwZXJpbWVudCBp
cyByZXBlYXRlZCBhbmQgbmV2ZXIgZ29lcyBiYWNrIHRvIDAuIFRoaXMgc2VlbXMgdG8gYmUNCj4g
YmVjYXVzZSB0aGUgc2xlZXAgY2F1c2VzIHRoZSBwcm9jZXNzIHRvIGJlIGV2aWN0ZWQgYW5kIHEt
DQo+ID5wcm9wZXJ0aWVzLmlzX2FjdGl2ZSBpcyBmYWxzZSBzbyBjb2RlIGRvZXMgbm90IGVudGVy
IHRoYXQgaWYgc3RhdGVtZW50Lg0KPiANCj4gVGhhdCdzIHdlaXJkLiBDYW4geW91IGZpbmQgb3V0
IHdoeSBpdCdzIG5vdCBnZXR0aW5nIHRoZXJlPyBJbiB0aGUgdGVzdCB5b3UNCj4gZGVzY3JpYmUs
IEkgd291bGQgZXhwZWN0IHRoZSBxdWV1ZSB0byBiZSBhY3RpdmUsIHNvIHRoZSBjb3VudGVyIHNo
b3VsZCBiZQ0KPiBkZWNyZW1lbnRlZCBieSB0aGUgZXhpc3RpbmcgY29kZS4NCj4gDQo+IERvZXMg
dGhlIHRlc3QgZXZpY3QgdGhlIHF1ZXVlcyBmb3Igc29tZSByZWFzb24/IGlzX2FjdGl2ZSBnZXRz
IHNldCB0byBmYWxzZQ0KPiB3aGVuIGEgcXVldWUgaXMgZXZpY3RlZC4gDQpZZXMsIHRoZSBxdWV1
ZSBpcyBldmljdGVkIGJlY2F1c2Ugb2YgdGhlIHNsZWVwKCkgY2FsbCBpbiB1c2Vyc3BhY2UuDQoN
Cj5Mb29rcyBsaWtlIHdlJ3JlIG1pc3NpbmcgY29kZSB0byB1cGRhdGUgdGhlDQo+IGd3c19xdWV1
ZV9jb3VudCBpbiBldmljdC9yZXN0b3JlX3Byb2Nlc3NfcXVldWVzX2Nwc2NoIChpdCBpcyBwcmVz
ZW50IGluDQo+IGV2aWN0L3Jlc3RvcmVfcHJvY2Vzc19xdWV1ZXNfbm9jcHNjaCkuDQoNCkkgdGhp
bmsgdGhpcyBpcyB0aGUgYWN0dWFsIHByb2JsZW0gYW5kIHRoZSBpbmNyZW1lbnQvZGVjcmVtZW50
IHNob3VsZCBiZSBkb25lIHRoZXJlLiBJIGRpZCBub3QgcmVhbGl6ZSB0aGUgZHFtLT5nd3NfcXVl
dWVfY291bnQgb25seSBjb3VudHMgbm90LWV2aWN0ZWQgcXVldWVzLiBJIHdpbGwgcG9zdCBuZXcg
cGF0Y2ggd2l0aCB0aGlzIGNoYW5nZSBpbnN0ZWFkLg0KDQo+IA0KPiBNYXliZSB0aGUgbWFuYWdl
bWVudCBvZiB0aGlzIGNvdW50ZXIgc2hvdWxkIGJlIG1vdmVkIGludG8NCj4gaW5jcmVtZW50L2Rl
Y3JlbWVudF9xdWV1ZV9jb3VudCwgc28gd2UgZG9uJ3QgbmVlZCB0byBkdXBsaWNhdGUgaXQgaW4N
Cj4gbWFueSBwbGFjZXMuDQpBQ0sNCg0KUmVnYXJkcywNCkRhdmlkDQoNCj4gDQo+IFJlZ2FyZHMs
DQo+ICDCoCBGZWxpeA0KPiANCj4gDQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+IERhdmlkDQo+ID4N
Cj4gPj4+ICAgIAkJZHFtLT50b3RhbF9xdWV1ZV9jb3VudC0tOw0KPiA+Pj4gICAgCX0NCj4gPj4+
DQo+ID4+PiArCWlmIChxcGQtPm1hcHBlZF9nd3NfcXVldWUpIHsNCj4gPj4+ICsJCWRxbS0+Z3dz
X3F1ZXVlX2NvdW50LS07DQo+ID4+PiArCQlxcGQtPm1hcHBlZF9nd3NfcXVldWUgPSBmYWxzZTsN
Cj4gPj4+ICsJfQ0KPiA+Pj4gKw0KPiA+Pj4gICAgCS8qIFVucmVnaXN0ZXIgcHJvY2VzcyAqLw0K
PiA+Pj4gICAgCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShjdXIsIG5leHRfZHBuLCAmZHFtLT5x
dWV1ZXMsIGxpc3QpIHsNCj4gPj4+ICAgIAkJaWYgKHFwZCA9PSBjdXItPnFwZCkgew0K

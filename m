Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21D3C7EE23
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 01:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5149410E0F9;
	Tue,  6 Jun 2023 01:11:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CE4E10E0EB
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 01:11:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fj9++ndCuC1UEFWe40W4QSAuiFLissRrRrwTp8GhVOHmV5zWNP6V3Kfiou+keHRsgwoCrAAOySdwBtAm3+337PDdYFFEf9R5pJheVxtVznd9PJ5gqQEOsdYuB9TILNp6FQtXi/FSXkBFGYiCEyraBEzpNIfHtCG1d6htZnIaDdfKGExziasHdGRRa6SodD/z08Q49ri7kVtnPz69xyOqtoqKePGc2RQZMQwbZcMernnAR5Ll7sNs88MVZshrA1byzvuVIIliG6G3EeaWlSeRdaXbYK7hN77BThICFCeuWoDi+wHnJn7J/Cf7yFZVG0O3RKT4QqBtVm5GDNNmVbgNNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uil4ZNO/JZLk6ZQ1cr+skYuQY/NzHgPS5p51zf3OBU4=;
 b=FNPdIoTdqjM3SXgAZPp43dZmNHsqVhEzR7idzTh9PkLP+r13mv8n3/qGhsgENimtCiyTrnBgKVXCiWSdvNx3/YqHi3HljjvhAKvXf2fANg6M43c5PisH6f6Np1xCo4apwLlNT7uFZv2+Uxk/5v5wictWWjGUfPvj8+MLBhC/jOcBMUbj/IRcs6KQqrArmzXS3u93uw6NisBlY41jSvOoedP8MluRHbs3qG9I8WP4GNLn2inF4AyFW774hmBw1c5Eb4fHIRO0rOeorUEyBtyR8pEKsr7dOTsr5+e6DslkpgzesUAF8BFGXVL6FDat9qzo20iLKeHcAn4GRnwZ23ImbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uil4ZNO/JZLk6ZQ1cr+skYuQY/NzHgPS5p51zf3OBU4=;
 b=3OZs87HzoJhZC2iSgZ4gNjS2Qi56D1L3cjdbji+n4I7Ky2zvOLElEgdzsi9AVK5litIbIBlspwXFUD9w5OD4WqxhgQcqXKiO730EIH5LgZBMsaD2O86FfWD0JohOBeYzxlt/+8+3G20VtMXVLce1YxngiHWcVNTO0W572zCpowg=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DS0PR12MB8766.namprd12.prod.outlook.com (2603:10b6:8:14e::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Tue, 6 Jun 2023 01:11:10 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::43e0:b9fc:552d:5cd5]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::43e0:b9fc:552d:5cd5%4]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 01:11:10 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "mikhail.v.gavrilov@gmail.com" <mikhail.v.gavrilov@gmail.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: make sure BOs are locked in
 amdgpu_vm_get_memory
Thread-Topic: [PATCH 1/2] drm/amdgpu: make sure BOs are locked in
 amdgpu_vm_get_memory
Thread-Index: AQHZl421zLvVMFJgAUmG4XWg4nR8ja98+A1w
Date: Tue, 6 Jun 2023 01:11:09 +0000
Message-ID: <DM5PR12MB2469DA5E1D8B9FB3BB8C7082F152A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230605091122.3363-1-christian.koenig@amd.com>
In-Reply-To: <20230605091122.3363-1-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=cb5d641a-87aa-4f79-895b-9f927d7fecc4;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-06T01:10:12Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|DS0PR12MB8766:EE_
x-ms-office365-filtering-correlation-id: 0816ffa9-7386-459a-2161-08db662ae9cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3koNkg9Tvzmqz/ZXdThFryR/AVaOZZkYKngwQIWM+OXVX7Mh3JaVzv94kfTW82UrG0vukwxw43lb3/4zANCc23WPdVDbPucxLn4E3Kv58hgbMPkTTIjqjQvbmUvlWUyamdSyDroiLrZngED8iEUltfry6eBCG4eFGo+cnHPQpVq8OPcxXXye7KpgXoerXBG9xedO2QPxJFmkTDfzX5kEP1HPKWEE2irdnVTBx95V3ef36DHT57EW6v3z7zAmmg9HOHqbgsq/TdFAQcfacRJtMrkbcbnUfeIlbUbiAF+N/OdBTIm13skl7nLY8rb11Y0n9qBk6z3/Rmlaf8mrgX/W2EKHQwwjj9s1w/NgSI1cf7DPASsCRLHwdD1Bp2/pDQC/DAToNdOUhP6pXCQBx4AyY5G2P4H7BKcaGhZcbWLLlxtEt4h3mvgHuW51WxIKGmnQqHsTVDxmxyEwBD7VpHB0RbSpix6qs4m0Dht4jb5uAhoOZOBZzQrNpH6yA2jNnkq/IzqjkhBalWO0h+GesyrtimIeb/p1eGCD8UKbMPf5ArIVSQmm0iJ0zB4EHUqhLi4phdDM3LKCraKBFaJvysA9UfG7JIqVfMFgRNq7Oy5Jj2H/WLF8AzahBMg35Hah5Y9x
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(396003)(39860400002)(346002)(136003)(451199021)(186003)(2906002)(9686003)(26005)(53546011)(52536014)(6506007)(5660300002)(38100700002)(8936002)(8676002)(122000001)(110136005)(83380400001)(66574015)(7696005)(38070700005)(41300700001)(66946007)(66476007)(66556008)(71200400001)(64756008)(66446008)(76116006)(33656002)(316002)(86362001)(478600001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWdrOHVTVHZrRTE0T01pNTBDREo3WGxmbU96aXIxTWJoMldZY0svWGxzM0NT?=
 =?utf-8?B?Y1dHV1VhYTJpY0xLT3VPczMrZ0EwVTQ5bmVHZ1dGWnh4VTFiNDJUZmFXajVM?=
 =?utf-8?B?WGRScEdoRzQza2dTZkw0bUkyaU9rWkNjb0t6OWhJMFFTVUdTTVFZZGN0ZFg5?=
 =?utf-8?B?SjdDMDR4WWhOVEtEdjA2Z3g2OU96RnNGc25pZHFBaXZZQnEzdlExbjgyT1la?=
 =?utf-8?B?STk5eEorQkN3Q0haM3QzdGYxdkVuUS8wV2JCV3ZuYTg4akQxcHVuN3I3WXU4?=
 =?utf-8?B?cnlob2liaVQycXM4QnhoRU51Yyt1bUdza0dPZXoxK2c3WTNjaGVDTXlJMlk3?=
 =?utf-8?B?QXpibTc4Z1daZ1Q1UTM5K3V3THF3MmM4bDFEd0k2YkNnc0NhNFZod29wWExL?=
 =?utf-8?B?V1VMUC8zb2JMSkVTTXhzbzVQdnRTVHMyU3AwMnFWWHBPUjdPY3RrYmpyb05T?=
 =?utf-8?B?c1lobEllN1R6eU50TTNNZUJYekU5TUVDemR0SFNIYWhVbkZNbXMxalg0RXpO?=
 =?utf-8?B?cGIvaGFYREhNM1JzcWVHMHM0KzArT3IvTXlDcmExVjBkSlM3MklXYUFqcDdU?=
 =?utf-8?B?RUc3RTgrL3NMajk5SzA1M2NIMlBWUEtoN2ZOVFg1a3NvZFBUY3diOG91dnJS?=
 =?utf-8?B?SllEVTFFWlN2SnMzN2IzblA2d2xNaVdoN01xT05TTEpxZzJDNTZ1ZTUvWGJL?=
 =?utf-8?B?YzFjZElIMVZDQjRtQWZwVEtod08xLytLREpvbW5pa2tHT1ZwbTcxWWVsNUx0?=
 =?utf-8?B?ajBJOEN1MTI5cXYwcS9qU1FPMmI0SU1MUE1mTTZQNGhoTDcxbk5XUk1CbGkz?=
 =?utf-8?B?TlllWVJpcDgvaDJxRXd2MTVSaWFkODFrTFgvbU1zd3FxRTZtMCtweDBLTmNl?=
 =?utf-8?B?UkhJVmI1ZVdWV3JGekdtSmJ4VEI5aDIxMUFzZEdIZ3ZoSVpxdUUzcWduaFBQ?=
 =?utf-8?B?VzIxWElORG9XL1BaZllkcHBCS2dCWVg1S1dVSGV0d3BFTGZUU2M1U3IyQktZ?=
 =?utf-8?B?OSsvcmhHZytxQXJYSHd1Y2k2MlpZMGtjcExjSVVCNjlCSzh6TGgrUkRocDRz?=
 =?utf-8?B?REdrVGx6a3FQVVNOdWJ0QnNzTjBYQ2Ztcnd4eWgySzNGYkRxZm8zbGRQRUlh?=
 =?utf-8?B?SzA2NGI0ZXY1NTNMQm9VMUZpRktnYjNlcnFqUXJhdHI0dWUzY3lQT09rc0xW?=
 =?utf-8?B?cWJ3UjNtN0g2TE1yUHp6cHRPdzdwZlpKbDJ6bERWbVpPTkZaclMzV3p6Nkx0?=
 =?utf-8?B?dEtCMzJGaU1ScE0wWmR1WTJOVjgwK2h3T0lrU21zM3NZaG5Rb1FwSzlYR2pH?=
 =?utf-8?B?OVZqMG5DNDJKNi9ZZm96M3dOUHhXblE0YnNnUU4wVE1rQ1VqRTFkRUgycVE4?=
 =?utf-8?B?bVZKVHNaenFZSDh0dWhTMDVvalFacFhjNStpWXdPUDZ0ei9COGcxbGR6Zjc1?=
 =?utf-8?B?TDIyZ0x6OEp1Mm1MMnN1LzBGR1hOZG5RM1J1dHJjTUU4d1pGQzBta2Y5eFFt?=
 =?utf-8?B?U0hkMDR3bzQ3bElUc1Q3UVJxczZVUERMM1pBaXZTSTl1dzJmOWc2alg1UVlL?=
 =?utf-8?B?cE1aYUM2ZllaZDJDZGFtNmQ5ZnF3eisvREtHNWxxU0RVRjdVeFhjUEQxZ21t?=
 =?utf-8?B?eGRvNDh5d21GOSszbjNkS2lsSmdDOFVqSmpPMStMYWdpVVV4VjFKVzF4R0Fh?=
 =?utf-8?B?ekVqcG1DUHE5REtzWnZ4TUVMZG1HYnpZUmRHbmNmWGxjaTQ2b1liU2FSOGZB?=
 =?utf-8?B?amlkNGRRUEQ4VEtQVUN3WEZERU1OaXRmdXQ0eEFnUXduN1djSCtRMVUyMkNY?=
 =?utf-8?B?aDJDY1ZwVmwySGpFZk5SMjJSV3RMT2ZySStOSmIxclJoclRUMllLZW1QTGpR?=
 =?utf-8?B?ak1oQzBnS1U0R2d0NmQ1NUw0ZmhsbDRBaEZhOTBzWHk1eFVINHpuNkRrdXJ5?=
 =?utf-8?B?amhQT2tKdHpiekFraTJIeFMzRDFBZjMvTktBNXFzNDlkTlJiYVkvdVl6VU5l?=
 =?utf-8?B?cWdVbHJCdUxNd0JVOUhIL0hCbnZhenZraUErd3E4L0M2ZTJxNTdOWnNnRVRh?=
 =?utf-8?B?WjNTa29YNHd0dkgybUlvRVRCOVhPTkJZQ1lxbFFHT2xSMkUvYUE4eFpLem5p?=
 =?utf-8?Q?eA4s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0816ffa9-7386-459a-2161-08db662ae9cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 01:11:09.9729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uxGdbiWO0gCJhSqkKnR04Gi578PxKHsdq+a+BeztJFpMMxrkwiz3TJK78050u4e8vZh5yXl05Rak38NAUWZufQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8766
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

W1B1YmxpY10NCg0KQWNrZWQtYnk6IEd1Y2h1biBDaGVuIDxndWNodW4uY2hlbkBhbWQuY29tPiBm
b3IgdGhpcyBzZXJpZXMuDQoNCkEgc2ltcGxlIHF1ZXN0aW9uIGlzIHdlIGRvbid0IG5lZWQgdG8g
aG9sZCB0aGUgbG9jayBpZiBibyBsb2NhdGlvbnMgYXJlIG5vdCBjaGFuZ2VkPw0KDQpSZWdhcmRz
LA0KR3VjaHVuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXN0
aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6dW1lcmtlbkBnbWFpbC5jb20+DQo+IFNlbnQ6IE1v
bmRheSwgSnVuZSA1LCAyMDIzIDU6MTEgUE0NCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnOyBtaWtoYWlsLnYuZ2F2cmlsb3ZAZ21haWwuY29tOyBDaGVuLA0KPiBHdWNodW4gPEd1
Y2h1bi5DaGVuQGFtZC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAxLzJdIGRybS9hbWRncHU6IG1h
a2Ugc3VyZSBCT3MgYXJlIGxvY2tlZCBpbg0KPiBhbWRncHVfdm1fZ2V0X21lbW9yeQ0KPg0KPiBX
ZSBuZWVkIHRvIGdyYWIgdGhlIGxvY2sgb2YgdGhlIEJPIG9yIG90aGVyd2lzZSBjYW4gcnVuIGlu
dG8gYSBjcmFzaCB3aGVuDQo+IHdlIHRyeSB0byBpbnNwZWN0IHRoZSBjdXJyZW50IGxvY2F0aW9u
Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zt
LmMgfCA2OSArKysrKysrKysrKysrKystLS0tLS0tLS0NCj4gLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAzOSBpbnNlcnRpb25zKCspLCAzMCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gaW5kZXggM2MwMzEwNTc2YjNiLi4yYzhjYWZlYzQ4
YTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5j
DQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+IEBAIC05
MjAsNDIgKzkyMCw1MSBAQCBpbnQgYW1kZ3B1X3ZtX3VwZGF0ZV9yYW5nZShzdHJ1Y3QNCj4gYW1k
Z3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0sDQo+ICAgICAgIHJldHVybiBy
Ow0KPiAgfQ0KPg0KPiArc3RhdGljIHZvaWQgYW1kZ3B1X3ZtX2JvX2dldF9tZW1vcnkoc3RydWN0
IGFtZGdwdV9ib192YSAqYm9fdmEsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzdHJ1Y3QgYW1kZ3B1X21lbV9zdGF0cyAqc3RhdHMpIHsNCj4gKyAgICAgc3RydWN0IGFtZGdw
dV92bSAqdm0gPSBib192YS0+YmFzZS52bTsNCj4gKyAgICAgc3RydWN0IGFtZGdwdV9ibyAqYm8g
PSBib192YS0+YmFzZS5ibzsNCj4gKw0KPiArICAgICBpZiAoIWJvKQ0KPiArICAgICAgICAgICAg
IHJldHVybjsNCj4gKw0KPiArICAgICAvKg0KPiArICAgICAgKiBGb3Igbm93IGlnbm9yZSBCT3Mg
d2hpY2ggYXJlIGN1cnJlbnRseSBsb2NrZWQgYW5kIHBvdGVudGlhbGx5DQo+ICsgICAgICAqIGNo
YW5naW5nIHRoZWlyIGxvY2F0aW9uLg0KPiArICAgICAgKi8NCj4gKyAgICAgaWYgKGJvLT50Ym8u
YmFzZS5yZXN2ICE9IHZtLT5yb290LmJvLT50Ym8uYmFzZS5yZXN2ICYmDQo+ICsgICAgICAgICAh
ZG1hX3Jlc3ZfdHJ5bG9jayhiby0+dGJvLmJhc2UucmVzdikpDQo+ICsgICAgICAgICAgICAgcmV0
dXJuOw0KPiArDQo+ICsgICAgIGFtZGdwdV9ib19nZXRfbWVtb3J5KGJvLCBzdGF0cyk7DQo+ICsg
ICAgIGlmIChiby0+dGJvLmJhc2UucmVzdiAhPSB2bS0+cm9vdC5iby0+dGJvLmJhc2UucmVzdikN
Cj4gKyAgICAgICAgIGRtYV9yZXN2X3VubG9jayhiby0+dGJvLmJhc2UucmVzdik7DQo+ICt9DQo+
ICsNCj4gIHZvaWQgYW1kZ3B1X3ZtX2dldF9tZW1vcnkoc3RydWN0IGFtZGdwdV92bSAqdm0sDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBhbWRncHVfbWVtX3N0YXRzICpzdGF0cykN
Cj4gIHsNCj4gICAgICAgc3RydWN0IGFtZGdwdV9ib192YSAqYm9fdmEsICp0bXA7DQo+DQo+ICAg
ICAgIHNwaW5fbG9jaygmdm0tPnN0YXR1c19sb2NrKTsNCj4gLSAgICAgbGlzdF9mb3JfZWFjaF9l
bnRyeV9zYWZlKGJvX3ZhLCB0bXAsICZ2bS0+aWRsZSwgYmFzZS52bV9zdGF0dXMpIHsNCj4gLSAg
ICAgICAgICAgICBpZiAoIWJvX3ZhLT5iYXNlLmJvKQ0KPiAtICAgICAgICAgICAgICAgICAgICAg
Y29udGludWU7DQo+IC0gICAgICAgICAgICAgYW1kZ3B1X2JvX2dldF9tZW1vcnkoYm9fdmEtPmJh
c2UuYm8sIHN0YXRzKTsNCj4gLSAgICAgfQ0KPiAtICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5X3Nh
ZmUoYm9fdmEsIHRtcCwgJnZtLT5ldmljdGVkLCBiYXNlLnZtX3N0YXR1cykNCj4gew0KPiAtICAg
ICAgICAgICAgIGlmICghYm9fdmEtPmJhc2UuYm8pDQo+IC0gICAgICAgICAgICAgICAgICAgICBj
b250aW51ZTsNCj4gLSAgICAgICAgICAgICBhbWRncHVfYm9fZ2V0X21lbW9yeShib192YS0+YmFz
ZS5ibywgc3RhdHMpOw0KPiAtICAgICB9DQo+IC0gICAgIGxpc3RfZm9yX2VhY2hfZW50cnlfc2Fm
ZShib192YSwgdG1wLCAmdm0tPnJlbG9jYXRlZCwNCj4gYmFzZS52bV9zdGF0dXMpIHsNCj4gLSAg
ICAgICAgICAgICBpZiAoIWJvX3ZhLT5iYXNlLmJvKQ0KPiAtICAgICAgICAgICAgICAgICAgICAg
Y29udGludWU7DQo+IC0gICAgICAgICAgICAgYW1kZ3B1X2JvX2dldF9tZW1vcnkoYm9fdmEtPmJh
c2UuYm8sIHN0YXRzKTsNCj4gLSAgICAgfQ0KPiAtICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5X3Nh
ZmUoYm9fdmEsIHRtcCwgJnZtLT5tb3ZlZCwgYmFzZS52bV9zdGF0dXMpDQo+IHsNCj4gLSAgICAg
ICAgICAgICBpZiAoIWJvX3ZhLT5iYXNlLmJvKQ0KPiAtICAgICAgICAgICAgICAgICAgICAgY29u
dGludWU7DQo+IC0gICAgICAgICAgICAgYW1kZ3B1X2JvX2dldF9tZW1vcnkoYm9fdmEtPmJhc2Uu
Ym8sIHN0YXRzKTsNCj4gLSAgICAgfQ0KPiAtICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUo
Ym9fdmEsIHRtcCwgJnZtLT5pbnZhbGlkYXRlZCwNCj4gYmFzZS52bV9zdGF0dXMpIHsNCj4gLSAg
ICAgICAgICAgICBpZiAoIWJvX3ZhLT5iYXNlLmJvKQ0KPiAtICAgICAgICAgICAgICAgICAgICAg
Y29udGludWU7DQo+IC0gICAgICAgICAgICAgYW1kZ3B1X2JvX2dldF9tZW1vcnkoYm9fdmEtPmJh
c2UuYm8sIHN0YXRzKTsNCj4gLSAgICAgfQ0KPiAtICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5X3Nh
ZmUoYm9fdmEsIHRtcCwgJnZtLT5kb25lLCBiYXNlLnZtX3N0YXR1cykgew0KPiAtICAgICAgICAg
ICAgIGlmICghYm9fdmEtPmJhc2UuYm8pDQo+IC0gICAgICAgICAgICAgICAgICAgICBjb250aW51
ZTsNCj4gLSAgICAgICAgICAgICBhbWRncHVfYm9fZ2V0X21lbW9yeShib192YS0+YmFzZS5ibywg
c3RhdHMpOw0KPiAtICAgICB9DQo+ICsgICAgIGxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShib192
YSwgdG1wLCAmdm0tPmlkbGUsIGJhc2Uudm1fc3RhdHVzKQ0KPiArICAgICAgICAgICAgIGFtZGdw
dV92bV9ib19nZXRfbWVtb3J5KGJvX3ZhLCBzdGF0cyk7DQo+ICsNCj4gKyAgICAgbGlzdF9mb3Jf
ZWFjaF9lbnRyeV9zYWZlKGJvX3ZhLCB0bXAsICZ2bS0+ZXZpY3RlZCwgYmFzZS52bV9zdGF0dXMp
DQo+ICsgICAgICAgICAgICAgYW1kZ3B1X3ZtX2JvX2dldF9tZW1vcnkoYm9fdmEsIHN0YXRzKTsN
Cj4gKw0KPiArICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUoYm9fdmEsIHRtcCwgJnZtLT5y
ZWxvY2F0ZWQsDQo+IGJhc2Uudm1fc3RhdHVzKQ0KPiArICAgICAgICAgICAgIGFtZGdwdV92bV9i
b19nZXRfbWVtb3J5KGJvX3ZhLCBzdGF0cyk7DQo+ICsNCj4gKyAgICAgbGlzdF9mb3JfZWFjaF9l
bnRyeV9zYWZlKGJvX3ZhLCB0bXAsICZ2bS0+bW92ZWQsIGJhc2Uudm1fc3RhdHVzKQ0KPiArICAg
ICAgICAgICAgIGFtZGdwdV92bV9ib19nZXRfbWVtb3J5KGJvX3ZhLCBzdGF0cyk7DQo+ICsNCj4g
KyAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKGJvX3ZhLCB0bXAsICZ2bS0+aW52YWxpZGF0
ZWQsDQo+IGJhc2Uudm1fc3RhdHVzKQ0KPiArICAgICAgICAgICAgIGFtZGdwdV92bV9ib19nZXRf
bWVtb3J5KGJvX3ZhLCBzdGF0cyk7DQo+ICsNCj4gKyAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeV9z
YWZlKGJvX3ZhLCB0bXAsICZ2bS0+ZG9uZSwgYmFzZS52bV9zdGF0dXMpDQo+ICsgICAgICAgICAg
ICAgYW1kZ3B1X3ZtX2JvX2dldF9tZW1vcnkoYm9fdmEsIHN0YXRzKTsNCj4gICAgICAgc3Bpbl91
bmxvY2soJnZtLT5zdGF0dXNfbG9jayk7DQo+ICB9DQo+DQo+IC0tDQo+IDIuMzQuMQ0KDQo=

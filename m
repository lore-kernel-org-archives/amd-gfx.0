Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27528C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 20:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C5E510E063;
	Wed,  9 Nov 2022 20:26:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99A2010E063
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 20:26:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErEvN9WamXdXJvlQ7rEFAvk4KqctSkdXcqEQQ8DCZF5LGkDRKDnjTIEMkHiH8/cQq4/uGxGrXpD7aX6U5kbcsowG1I5m1g0E/sf8v99efUVicq8eQWcHvAcWDztbHjDahF04R+piADgs41yEN0ynZ/88zLY8d9Fp3Jo9E0gBUulAsmS5nXlXf1Ix536A1FbpjrAQ6xdrhvqQ0MRUEK8jjVLdaYTYJG5oboPGFkbv9Vu5M2H20BJHEo7K2KgdrWFVfd8bE8vOZk1vV7gdSwCm0VelxHDsxMZegLGWltmsg5bXe4Rtgwb+oYiTeagWqVA+PWLken6A5/wl8UR0C9F9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75KaaADptJRBEC1gI8ojiWWqQX6bm1FuHtN9tzS8th8=;
 b=RiTh5BV3/KuP7+Urdz6d2rPwB+8u406j5WAs4C1o0OqwRe20cApVOSKJ4fofnx3hCHwb4U/l2fVrFCk7hl3PzQryXnjRbYTsR8oAMmg3A/iVP7OKmAurGC2m97sZ7yRHAcNBQz6rI8cKvjtNf+8f4rWR1QZKF6rG6p5FhI+vKiX5ad1J4nkYWoM5F24chWuuu/+BtwJ7WbJ+6k5JxAbftbJ4rX1dsvNoJ1OtO1NC5bZi83RCKFpXEAYmX+2JVeJS9u4YjqQ2jNZGRguViTWy60M7Qw+0qrf8pcFDIsOyQDN3rrwVKeJyeS2MOwbMc3e3/1MEFET3nDs42mAnM+N6tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75KaaADptJRBEC1gI8ojiWWqQX6bm1FuHtN9tzS8th8=;
 b=QuAmUF4vVlrho+vu5KCNEm/wo9IGeLg1gt3efW4IaJ+MJ2ROaQxgRUSeKH/YfAPzYRsQOMv5d8/EXY0F1XUQhL8FYL9OgwBK/VJvzKMnGqKe4FS+4vaXmcAnRyq8ccdlocQbcGFtmlGTKRGqpWXDPchXjyTjOKSO+hXfBS/QMjU=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CH0PR12MB5170.namprd12.prod.outlook.com (2603:10b6:610:b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Wed, 9 Nov
 2022 20:26:08 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::6e21:576d:6e80:7e49]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::6e21:576d:6e80:7e49%5]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 20:26:08 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Wan, Gavin" <Gavin.Wan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Ignore stop rlc on SRIOV environment.
Thread-Topic: [PATCH] drm/amdgpu: Ignore stop rlc on SRIOV environment.
Thread-Index: AQHY9GiQSwnTQxODGEKqkCSxFr2t3a429CcAgAAVtdA=
Date: Wed, 9 Nov 2022 20:26:08 +0000
Message-ID: <CH0PR12MB5372E467C6606AE6A8201D84F43E9@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20221109182422.21924-1-Gavin.Wan@amd.com>
 <CADnq5_O_qeNZDju-uffzfZRYcgK763atyOt2ZCQ7s-f9tE+t+A@mail.gmail.com>
In-Reply-To: <CADnq5_O_qeNZDju-uffzfZRYcgK763atyOt2ZCQ7s-f9tE+t+A@mail.gmail.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=558efa0f-25df-444f-8196-9e42857e4083;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-09T20:24:59Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5372:EE_|CH0PR12MB5170:EE_
x-ms-office365-filtering-correlation-id: 92765d78-d47a-4581-feea-08dac290a276
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tk+SvL2Dh0ZrigU/9rt7yzOiuskSh8GPc4a93w0HKLEc6Tq09089+whYQpgtLZlBVu67+u7u04X3vdwUJ86hIKp7ojYzqWbSXm56pDmP0GoabpEv63ACBu8Ul4Mjpc0+J0xt+Sqz5Lux/ApGcI/tKEhfRi76JmfzZl7dQPB2tetYWjuNf59GhPbhJqmELZKAQS/WUv9thSKkJZlPQd5nvn2/ZGvQgKNZ7xYydjWdyAw+NVUD/RhBA3xLEwgeJXp3ObqX0OV/WPKhqAKJ6yRgSdN1ec3C5fgAB1qwvOo3Zva7ovglEqb4rn3d7jbQnaZrNFtKareViwpw8MIZ7V2s5g8CCYY8dD+ztQSRnPwUqgmU91a28PHol50el/u0zSQ1kraaQ6yOk/J6h5IcZv+G5HKZhLpMqx8EbIihO000U2VvrSOjNaigSDNNO/VA9wF41pa1C0qEfbbOzYTl3wkFi+adWAqt5Rndp6/ultMpOJ02BLmd2LuDknOWf0rITTBSq8a2YSeBo/+zBYEyH5n9ZY3n+UmjTykej1Gv4UKqdUVeDzrCN3T6CrEIGKb6q7WZY5UwrBGSaJmgXb7RwWwIfP6zK962Dc+Pb9PGWusIU4vck3pKPEIZWRvg3szwMTsq+ANhNPUyrICFy+f4SHOmqGlWE+R1GyHl7pGz3B52KAhJ7UM6eBLF2QoAoGM1HmdoKAaeLyjw4ENDBSEk8xEU8WSKx/s2XHZKO9xtKraM8/eI+kbyHPXqZ5iymnTOwvE8Od7ErGW0Rk+TrXw16sNJiA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199015)(64756008)(8936002)(76116006)(66446008)(66946007)(4326008)(41300700001)(8676002)(66556008)(66476007)(6636002)(33656002)(55016003)(71200400001)(478600001)(110136005)(316002)(83380400001)(52536014)(122000001)(86362001)(6506007)(7696005)(53546011)(38100700002)(38070700005)(9686003)(26005)(2906002)(5660300002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1ZXMURnTDBkZnRoOGJoODVyYXNIbEhTczNkb2NKOWxrbHYxT2ZzSXd2YWMx?=
 =?utf-8?B?M1FkYUUrQ21KY3Vsa29STGhmSjFZT1h4cEtkd2kzdGZkZnpZSlpFaVZySnYw?=
 =?utf-8?B?Tm14RHROTXpXb1hBN2lTK0RlZXR2K21EbU5JYnNFVkRBdkpSWGs1c2VJejZW?=
 =?utf-8?B?ZmM1aVNIdGV5Qkd1d241ZUNxVnpESmlHZmpuc1JiRW5KYTdSN2xkckRkNUVC?=
 =?utf-8?B?cUw0OFBWQ0lmNHE5K2p2a0poU1k5T3YwdzFDNVZHbWZIV0pvY0FDOWkxbk1E?=
 =?utf-8?B?c2FiWDhwMmtwQjhqYUxMRHBpdkdOTHhwbU5nUjZpOHNoTmYvR2xaMEVTMWhi?=
 =?utf-8?B?NDUwVTk5MjFYaGx0UjNpcURtblBic2pWbFpjNUhlbHZXWk55VzN6MEVLcXUy?=
 =?utf-8?B?eVoyZWhTZkQwdHJTU0dPVHo0MHd3bWtlRjBWK3lLaWRsWkVvaGU1UG52anox?=
 =?utf-8?B?bjlpZ1ZHUEFBSUdPSUl2TDdYWHVvallhd3dmeW4rWC9NaFdCRjNhc2lrYXJn?=
 =?utf-8?B?QnlZc2FYZ0dlSzdPeVluOVZRWWFYWUEvSHdSWGgyVEFkVHUyVU1vclMzb1Ew?=
 =?utf-8?B?VlFyUFViQ3JWeDgwbGp2YzVNM3loMXlFTHVsWkxQY0tmSGpwQmI4TTFUdFBV?=
 =?utf-8?B?c1FxRUNDV0lUcWFMOVdpT0ljeFdKMTd0M2hRa1ExTEFNY0piVHZFZjZ3T1hV?=
 =?utf-8?B?THJxY2t2VXhnS1NMR0sra3BGTEFTZGxSempJa2VsUzczZmhOOHZLT1NWNDVK?=
 =?utf-8?B?S2J5cWN6QzNJYndHdFIyUWh5MW9JaG05eFkrc01PalAydSswbFA4VlZkL1RR?=
 =?utf-8?B?VmNQWUJ4aGxaL2NaSTNnaFh2Y0pDcjNPTnVxUTRMUmlBNlVZQ25UVDcwZkta?=
 =?utf-8?B?TngyMzBOOWVhVEFubFBEZXE1L2N5SlpVeFNHMTQ3bGhzY0JROUlGZEFJeENZ?=
 =?utf-8?B?OC8vNStmMVFCaElZVVlQZ2F0MmhlUFFGT3pMcElKSWNqdzNybFRwbjh5TVNU?=
 =?utf-8?B?bHI0R0IwQUMzZTMvMjlnK0FTVE9ueWUwMEk5ZXc0ZktuVkgwQzJmdy9JMU1V?=
 =?utf-8?B?ajJYMGxUNUNZYllGaVlPWnZRYzJEa044TnI4djN0ZVVCSzJnUGJxRTB1Z2tE?=
 =?utf-8?B?T3Z0M0lXbzhMVjhFMTZtQmZDajJZQWFNUHR0M0FreFV2YksrOEVNN05EalNr?=
 =?utf-8?B?N0RoOUtJRTlZOW5POWx4YitabHdFdVcyT0oxUjllaVBocitQS3BnbklaOW4z?=
 =?utf-8?B?U0FZUEtxTGZEZmNWMWJEWHZqQ0NVSHFFaTdPVmxyTmFiWnhYazFSQWZZZWp5?=
 =?utf-8?B?ZUN2RWlDSWg1Mk1ld010LzBnNWxzdmhoaFRmZGVQTEVJcyt1ZWY4c2ZRTzE3?=
 =?utf-8?B?WHdsM2xKTnZiNjcrWUVVSVlqTGFybGR5NU91M0JzekhJcW9CKzJOekZhYloz?=
 =?utf-8?B?K21zRDFuZmh6eXpvOWRma3FWUUhRT2lxcE5HWVhtY3Z4ZlRWSVlZN2E3eUV1?=
 =?utf-8?B?UFp2M29ZQ2krd2VyWXJwT3VOTGJwUFhZT24va2lTQ2FqVkgrSEVtcWw3NTdo?=
 =?utf-8?B?d0lFaitsM3dFditVd2ZzK1ZwdEVjVi8vNmZ6dHFxTnVZZXpXcmJWVnhFL1k5?=
 =?utf-8?B?TFU1Q1crUUpoaG9IeXArU05JbUROaktrcnplMFhDRm4wenNOWHRiUW9ZYU1K?=
 =?utf-8?B?aFdYaU9yYkloN1JRM1Jjb200YWlrUXBzbmNLQVhSd3ZWZWhuOWtUV3lmS2ZW?=
 =?utf-8?B?cHZDQTB0cmRxZVgyWE00b2ZoN2pwZGxXVlhUSnhma3Y3NXk1UzFqbG5XZGRw?=
 =?utf-8?B?SnVQeUtKaEUzK0NtQlp5Z1E4Z3J3NUdMYWUrcjNRWkd6WEpPN2N0aTRtKytU?=
 =?utf-8?B?WG9KRFNGTjQ5SHRZZUpmR1EzNUJZSWxwS0hOZjJmTEIzdHIzV2ZNRlNSKzJ1?=
 =?utf-8?B?ZTMzVnlDUnJ1K1FnYklZVld1dTkxNTNYUzlWaUxPZ0ttUTltMHdjODUzWm5J?=
 =?utf-8?B?YmRlZEM5dlIvTitMVXhkdW8zUkhYdXA2eExzMEMyMktWUmJDb3JManBJOTlB?=
 =?utf-8?B?aVZqQVMvWWZsOXE4aE9TTjN2eTMzMzJJQ3JDaGduaEg1NUdTeXBmYjhiSHNF?=
 =?utf-8?Q?aBZo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92765d78-d47a-4581-feea-08dac290a276
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 20:26:08.2508 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Px7PdHWgJkn5cbtjTHafOkhvlVVoUuK9uHqZaUt6tFB/K9R0O7I35v4vDzRzdWgulhyHht9vCG4mGVzykWugw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5170
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNClJld2VkLWJ5OiBzaGFveXVuIGxp
dSA8c2hhb3l1bi5saXVAYW1kLmNvbT4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJl
aGFsZiBPZiBBbGV4IERldWNoZXINClNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgOSwgMjAyMiAy
OjA3IFBNDQpUbzogV2FuLCBHYXZpbiA8R2F2aW4uV2FuQGFtZC5jb20+DQpDYzogYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IEln
bm9yZSBzdG9wIHJsYyBvbiBTUklPViBlbnZpcm9ubWVudC4NCg0KT24gV2VkLCBOb3YgOSwgMjAy
MiBhdCAxOjI0IFBNIEdhdmluIFdhbiA8R2F2aW4uV2FuQGFtZC5jb20+IHdyb3RlOg0KPg0KPiBG
b3IgU1JJT1YsIHRoZSBndWVzdCBkcml2ZXIgc2hvdWxkIG5vdCBkbyBzdG9wIHJsYy4gVGhlIGhv
c3QgaGFuZGxlcw0KPiBwcm9ncmFtaW5nIFJMQy4NCj4NCj4gT24gU1JJT1YsIHRoZSBzdG9wIHJs
YyB3aWxsIGJlIGhhbmcgKFJMQyByZWxhdGVkIHJlZ2lzdGVycyBhcmUgYmxvY2tlZA0KPiBieSBw
b2xpY3kpIHdoZW4gdGhlIFJMQ0cgaW50ZXJmYWNlIGlzIG5vdCBlbmFibGVkLg0KPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBHYXZpbiBXYW4gPEdhdmluLldhbkBhbWQuY29tPg0KDQpBY2tlZC1ieTogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPg0KDQo+IENoYW5nZS1JZDogSWFj
MzEzMzJlMmM5NThhYWU5NTA2NzU5ZGUxZDNhMzExYjVjODQ5NDI+IC0tLQ0KPiBkcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL3BtL3N3c211L2FtZGdwdV9zbXUuYw0KPiBpbmRleCA0ZmU3NWRkMmIzMjkuLjBlOTUyOWI5
NWQzNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVf
c211LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMN
Cj4gQEAgLTE1MTcsNyArMTUxNyw3IEBAIHN0YXRpYyBpbnQgc211X2Rpc2FibGVfZHBtcyhzdHJ1
Y3Qgc211X2NvbnRleHQgKnNtdSkNCj4gICAgICAgICB9DQo+DQo+ICAgICAgICAgaWYgKGFkZXYt
PmlwX3ZlcnNpb25zW0dDX0hXSVBdWzBdID49IElQX1ZFUlNJT04oOSwgNCwgMikgJiYNCj4gLSAg
ICAgICAgICAgYWRldi0+Z2Z4LnJsYy5mdW5jcy0+c3RvcCkNCj4gKyAgICAgICAgICAgIWFtZGdw
dV9zcmlvdl92ZihhZGV2KSAmJiBhZGV2LT5nZngucmxjLmZ1bmNzLT5zdG9wKQ0KPiAgICAgICAg
ICAgICAgICAgYWRldi0+Z2Z4LnJsYy5mdW5jcy0+c3RvcChhZGV2KTsNCj4NCj4gICAgICAgICBy
ZXR1cm4gcmV0Ow0KPiAtLQ0KPiAyLjM0LjENCj4NCg==

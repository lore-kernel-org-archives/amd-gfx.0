Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFC7C76196
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 07:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FBE510E06C;
	Mon, 10 Apr 2023 07:32:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C55110E06C
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 07:32:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxkxdyZBD6TCOIQTp34p49lHrxPu7lpvsd90/b4z33CHfG8B8+z0CMU9RUUWplT5pWjxSMJ1KTiSdpshk6VLsyZRkv2JlnMcn3zVff9gp3N1v/zHFAYwHP++ZZQEsLv+YoZkxV4PmRKXG6ByRuqmG8WjgWsM0dkBVB2HPEfq+/9V7x6z7K4aQbn/bzXuA3kvf+crxGnYJqRSuz0Zpw1WdMrBr6ltab9cEJ8bGATEOU6uEYcPF/cfZwNK3cbYE5KYSKJe/Z9rFXXIm/cMk5+r25PaG/PzDTwjhYZRIQEMqsRvtY1yeFSFzL1sOCMENrqIulXRlZPwG4uufSUrCu1TXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73BRwsV8peFLtAQWRixRrA/uqkEQ7Vifarx7G6Qto+4=;
 b=bXTVbOb1Xb7sRjJgJILILIsH7/oygzOT0Np/7t4EKrLx6U95Wg+L+i+TLpnzn7KWzRXPxaKh3j4ooyOr/It/0Dbpiw4mLwCIsoMmLtuMHNPtXMN0NRYTHEAfnN57gKoFQduH7XwdX3NC7qf8gGO62fJzb+PWdYb1/uoFLhV5KZPZJvMaDyLwB7UZjvC8R8a0gTz+iv7ALc2Hv5qQT01g0SOR6m5vGLhIgAqZDj+DykYYGF+ZfDtO2OyPJWzkZm7qvPHlJyFZ01WVyiSm0FQChULcrpVBoRy7hFH/HvTcOpTegtElYxzGIr9HwroW1HEcgFmY/v8+sj+AcKoJifoYZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73BRwsV8peFLtAQWRixRrA/uqkEQ7Vifarx7G6Qto+4=;
 b=x49DxVAZzoPgqAp0tHmHMQi57fa/FLg6ZdP+utwsY7HRd3HNN9kZonJf2HgCxg/kmvhUbcV8ScUXBQ8OpBONvVWn5vEEUgvBYBo5w8IlEZLx/NPpnNjonxYuWi4TLLWO37G3FmPkwNNMoe/Dpn63NS+jkadw7UESYqkEEl4Jxwo=
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CY8PR12MB7289.namprd12.prod.outlook.com (2603:10b6:930:56::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Mon, 10 Apr
 2023 07:32:04 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6277.036; Mon, 10 Apr 2023
 07:32:03 +0000
From: "Sharma, Shashank" <Shashank.Sharma@amd.com>
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: RE: [PATCH v3 0/9] AMDGPU Usermode queues
Thread-Topic: [PATCH v3 0/9] AMDGPU Usermode queues
Thread-Index: AQHZYlg/wQgIMZ1Dd0K1XyfDx7ke8K8jxFGAgABwPVA=
Date: Mon, 10 Apr 2023 07:32:03 +0000
Message-ID: <MW4PR12MB5667D4837CFDEE7230F5423DF2959@MW4PR12MB5667.namprd12.prod.outlook.com>
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <CAP+8YyFgbru=1HkLo1Kfm1jKPrk5sXenUmmkzzysWbSh05q2tg@mail.gmail.com>
In-Reply-To: <CAP+8YyFgbru=1HkLo1Kfm1jKPrk5sXenUmmkzzysWbSh05q2tg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-10T07:31:59Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=16eb9239-29c2-4c1e-bc26-0664cd95ffb9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB5667:EE_|CY8PR12MB7289:EE_
x-ms-office365-filtering-correlation-id: 078bf4ff-0e87-4bcf-56c7-08db3995adbc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rM3ZjCwU4G339TFj8+G619bG98ABQJxnJEKx6TREkyVY+2jiIZx1X4vYD6faKDB/zzO8OYGFLScjohJPr0LcCWXcmjLCwjcSJ2O84MaP8pf6u7elo8pLXCfh9R8R8rm+eV4SPjHjOAJIiaf4VnrsymU9/t2I8u1fx8m2MMZwZzRx6FE4KyiMv16WeRLygZJhdSUZexsotNGViC+TccqOix1xLZe+fsSYUGRIBzT1kAiJjrRlx3VwAkNC2UEJ6HMEiH27iDY/SqRCnGJ3U0v9hVcR9+uO9c1luk95MPEastzbPMgOe4B1PNzEv62IK65JBu26UVqIbUeBK1PfXvLkRiEzO2DPd9IunsqOPTUuSZq+vrW9As8qZrF2gpQwRAVbzTbVs5epLAK7hX+rurtpJqHiFXNb8JYp5omAV3A+MEZXmJQPG41WvdbsnFZIPNuzX+KKZDJgJAOBmEKhz57F3Im537nMlhGPRAqB+Lu2JIDc4ZPX/YOXBwZcRf+rII2Lelt6Pn/b6tzEY4tFcOZ7+XgKcsghfrix4zXZrrcGRS2iTBroYAGWiVSR7r0+XmVB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(451199021)(83380400001)(76116006)(966005)(71200400001)(478600001)(7696005)(186003)(54906003)(26005)(9686003)(6506007)(53546011)(52536014)(2906002)(33656002)(38100700002)(5660300002)(122000001)(66476007)(66556008)(66946007)(64756008)(6916009)(4326008)(41300700001)(66446008)(8676002)(8936002)(86362001)(38070700005)(316002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djlzTUMzTFBIRXAyL0VTanltYnhjeWhVUjNIMTV3YU5lRGZhMTF0OVNRSGwx?=
 =?utf-8?B?Y2NBdDQ3L1VCTGQ5emx5Vm1BcGxNcTZCeUpiZkU2Y0QrZlZJT0l1Wldnck9S?=
 =?utf-8?B?SUNabXZGaVJIbi9ZWVFIVWJaOFA3amErSHU5Z3NRM0FQdFNwQkdqeFV2Mmc2?=
 =?utf-8?B?UjB2akE1Yk0yQlpGT3BYNWhVb1lvMis2U3p0Q3RMdE94d0FvSkxwKys0MG1B?=
 =?utf-8?B?dEROUWhTb2laOEN2VldWNGlTTGJ4cGhGTjF3bURWUFJJVHNaaDJ5a1dGWUF0?=
 =?utf-8?B?Rmp3SzJXckRSaGVFRHd4VDNKZ0dhNDE4VkFjTkJiOGpLVFlTdTdBenVMZDNF?=
 =?utf-8?B?aUk0YUNjNjJ5OFpGZFNpcytOMGtqYU03SVNSbGRwU25pTEJVR0FUL2xqb21m?=
 =?utf-8?B?Sno1SVFZSVg2eTNDbUNoR0MvL2taNjYxWlh3S0V4SVRBTVNjWjd1SU1MeCsv?=
 =?utf-8?B?aDJBZUhZOXZicythdW9NRWVDbENHWFRnTTlWdiszdUlTM29oa2NOQWgrV2Zx?=
 =?utf-8?B?dDVFR0JERXBhbExZbmkwU09qT2N6dFMvY0NBYjNaYUJuUUx0NWtBQTNTVW1C?=
 =?utf-8?B?aTZiUlZOS1FPNzNpSnhBeVpVeEJlWkI0YURERkVjODNqbUF0T2hDVFFkU3NB?=
 =?utf-8?B?d3VCOEVvdnZxSWlQSzBkS2RkTzFYRUpqbDN2WSs5Y0d4U3l4VmxrblBOYm1Z?=
 =?utf-8?B?bG9NTVNNdjNJUlZic3JQREZMNnlBd0NHR0IxZndEUTNRbHJYcUdOa3lLQzJE?=
 =?utf-8?B?QldwN0xVVHFWemhlSW54Yk9RU1pSUXhvYmVxZ0Faa1A5QlhFRmcxWTlOZ3ZP?=
 =?utf-8?B?WElYM1FndlJISW5tTHRpTFdKaDdQTFpEenZUclVXMTl4ZDBpQ3JGWTZwYjBk?=
 =?utf-8?B?eG05Y1B0NXdpUkJnRTMxSnNhNlZoWWcySC9KbEtoWGx6Tzg4NzVoZmVuOEhy?=
 =?utf-8?B?WkhSVHc4dXA0U1Qwcm55MUt5QTJ4b3pGcGlVenVheEg4Wm53ZUZJekZBV3BD?=
 =?utf-8?B?T0lMdGJTblRFaUdZeitTK0lIeXhvRVlmR1hYc3h4OUtJc0MzYjZlWE1TNU9l?=
 =?utf-8?B?OUwyYmpsQUZ2NWhmN0pIK1ZCT2hIenJHek1obkpTRmljSWFiZkt3NGJlZFpI?=
 =?utf-8?B?U1lOU3RYR3Z2L1pZRXFwaFJnbW9MQlU5U1dBR3lCSGV0L210SWlJTlhnRTlS?=
 =?utf-8?B?TTlGVzBlVXI5akEyOUF6enA5a1RRVUZFRUxIazl3WTRXRmZxdlhtN2hydkx0?=
 =?utf-8?B?cmJyL2V2SWxJTEptZkowV1FtSTRUSFQzVWF1ZlRzN3daV1JKTWFrNWNBOUxC?=
 =?utf-8?B?WUQ0QjNENkxKWmlGdVlmWHQ0bGlmN012UVhaYWMzVkNWNmRGVmNZOG5wbHJJ?=
 =?utf-8?B?QTRhK1ZNZWRtV2dmM2FYYlVzUW9VcWh0YWZGT1A0b1JVTFR5RXltbmNQVjh2?=
 =?utf-8?B?bWJqdEJ6NFp5UW9aTkpZYTBiSjh2QkVuajdaRFhNbERlU3RlQW4wTkRBcnla?=
 =?utf-8?B?U0JQWksrOEIyWWZaYnYwL293aGZLbEFVVStQa0g1eENJUjR5aVg3YjZUdzFn?=
 =?utf-8?B?NnNQeCtrVHJrT05JeTRCSXpucUxyYkJEbjliMlZHbVdybDVLbVNjakFmdUxF?=
 =?utf-8?B?bDZ5TmI3cEx0QU4yc1N4MWRvWUZOUFd1REdZN3AycnJIbGV5blFDYjIvV0tT?=
 =?utf-8?B?U2tYVzRWc1d6TW54NDJjejQyYUxIeHo2bm04cVZCdFFpdjJabFQybmNCemxB?=
 =?utf-8?B?VjJvZmx2MWJiT01JcENEdTlVUmR3RGhidTluQUMwWXZFcWNCc0hFa0Vza0p1?=
 =?utf-8?B?YnlzMTVmY3BGK1NHU0F1UXhNbUltbVVUemtDWkhSd3dzRzhhc2tvWlBkclhO?=
 =?utf-8?B?aUM4Q0M0b2FmcGtmbzRwbkp3c2Vmdy9JY0tMYi9aRkFNM1NsdDZRV0dXNklo?=
 =?utf-8?B?UzVVcHlZVElDSVRmQ0tuV2JIQ2s2MVpCRU0vdkxyRnJQU0YzaW1XL2RiT0Mw?=
 =?utf-8?B?Mkp2YURoQzNhU0VSRTRRUWduRHVjN0srUXBKaWRMUjRJeEF6L0dJRW1QcjRM?=
 =?utf-8?B?cUVxUVVQcDZYdDNYeGxqRWZKQUtCR0lRb1VsWmRGYzZZTHh5NURsbG9iekZ0?=
 =?utf-8?Q?cBl4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078bf4ff-0e87-4bcf-56c7-08db3995adbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2023 07:32:03.0708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KwwMfJAFClCA0dutEy6jEq+Q5QBUt7BvX9Qa2xo1cBt2plWeC28lff2mWsHcafi/v800MePMf+noLlBYVbBoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7289
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, "Yadav, Arvind" <Arvind.Yadav@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhlbGxvIEJhcywgDQpUaGFua3Mg
Zm9yIHRyeWluZyB0aGlzIG91dC4gDQoNClRoaXMgY291bGQgYmUgZHVlIHRvIHRoZSBkb29yYmVs
bCBhcyB5b3UgbWVudGlvbmVkLCBVc2VybW9kZSBxdWV1ZSB1c2VzIGRvb3JiZWxsIG1hbmFnZXIg
aW50ZXJuYWxseS4NClRoaXMgd2Vlaywgd2UgYXJlIHBsYW5uaW5nIHRvIHB1YmxpcyB0aGUgbGF0
ZXN0IGxpYkRSTSBzYW1wbGUgY29kZSB3aGljaCB1c2VzIGEgZG9vcmJlbGwgb2JqZWN0IChpbnN0
ZWFkIG9mIHRoZSBkb29yYmVsbCBoYWNrIElPQ1RMKSwgYWRhcHRpbmcgdG8gdGhhdCBzaG91bGQg
Zml4IHlvdXIgcHJvYmxlbSBpbiBteSBvcGluaW9uLiANCldlIGhhdmUgdGVzdGVkIHRoaXMgZnVs
bCBzdGFjayAobGliRFJNIHRlc3QgKyBVc2VybW9kZSBxdWV1ZSArIGRvb3JiZWxsIG1hbmFnZXIp
IGZvciA1MDArIGNvbnNlY3V0aXZlIHJ1bnMsIGFuZCBpdCB3b3JrZWQgd2VsbCBmb3IgdXMuDQoN
CllvdSBjYW4gdXNlIHRoaXMgaW50ZWdyYXRlZCBrZXJuZWwgc3RhY2sgKDErMikgZnJvbSBteSBn
aXRsYWIgdG8gYnVpbGQgeW91ciBrZXJuZWw6IGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9y
Zy9jb250YWN0c2hhc2hhbmtzaGFybWEvdXNlcnEtYW1kZ3B1Ly0vdHJlZS9pbnRlZ3JhdGVkLWRi
LWFuZC11cS12MyANClBsZWFzZSBzdGF5IHR1bmVkIGZvciB1cGRhdGVkIGxpYkRSTSBjaGFuZ2Vz
IHdpdGggZG9vcmJlbGwgb2JqZWN0cy4NCg0KUmVnYXJkcw0KU2hhc2hhbmsNCi0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBCYXMgTmlldXdlbmh1aXplbiA8YmFzQGJhc25pZXV3ZW5o
dWl6ZW4ubmw+IA0KU2VudDogMTAgQXByaWwgMjAyMyAwMjozNw0KVG86IFNoYXJtYSwgU2hhc2hh
bmsgPFNoYXNoYW5rLlNoYXJtYUBhbWQuY29tPg0KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnOyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBL
dWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBLb2VuaWcsIENocmlzdGlh
biA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwLzld
IEFNREdQVSBVc2VybW9kZSBxdWV1ZXMNCg0KSGkgU2hhc2hhbmssDQoNCkkgdHJpZWQgd3JpdGlu
ZyBhIHByb2dyYW0gdG8gZXhwZXJpbWVudCB3aXRoIHVzZXJtb2RlIHF1ZXVlcyBhbmQgSSBmb3Vu
ZCBzb21lIHdlaXJkIGJlaGF2aW9yOiBUaGUgZmlyc3QgcnVuIG9mIHRoZSBwcm9ncmFtIHdvcmtz
IGFzIGV4cGVjdGVkLCB3aGlsZSBzdWJzZXF1ZW50IHJ1bnMgZG9uJ3Qgc2VlbSB0byBkbyBhbnl0
aGluZyAoYW5kIEkgYWxsb2NhdGUgZXZlcnl0aGluZyBpbiBHVFQsIHNvIGl0IHNob3VsZCBiZSB6
ZXJvIGluaXRpYWxpemVkIGNvbnNpc3RlbnRseSkuIElzIHRoaXMgYSBrbm93biBpc3N1ZT8NCg0K
VGhlIGxpbmtlZCBsaWJkcm0gY29kZSBmb3IgdGhlIHVhcGkgc3RpbGwgZG9lcyBhIGRvb3JiZWxs
IGlvY3RsIHNvIGl0IGNvdWxkIHZlcnkgd2VsbCBiZSB0aGF0IEkgZG8gdGhlIGRvb3JiZWxsIHdy
b25nIChlc3BlY2lhbGx5IHNpbmNlIHRoZSBpb2N0bCBpbXBsZW1lbnRhdGlvbiB3YXMgbmV2ZXIg
c2hhcmVkIEFGQUlDVD8pLCBidXQgaXQgc2VlbXMgbGlrZSB0aGUga2VybmVsIHN1Ym1pc3Npb25z
IChpLmUuIHdyaXRlIHdwdHIgaW4gZHdvcmRzIHRvIHRoZSB3cHRyIHZhIGFuZCB0byB0aGUgZG9v
cmJlbGwpLiBJcyBpdCBwb3NzaWJsZSB0byB1cGRhdGUgdGhlIHRlc3QgaW4gbGliZHJtPw0KDQpD
b2RlOiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvYm5pZXV3ZW5odWl6ZW4vdXNlcm1v
ZGUtcXVldWUNCg0KVGhhbmtzLA0KQmFzDQoNCk9uIFdlZCwgTWFyIDI5LCAyMDIzIGF0IDY6MDXi
gK9QTSBTaGFzaGFuayBTaGFybWEgPHNoYXNoYW5rLnNoYXJtYUBhbWQuY29tPiB3cm90ZToNCj4N
Cj4gVGhpcyBwYXRjaCBzZXJpZXMgaW50cm9kdWNlcyBBTURHUFUgdXNlcm1vZGUgcXVldWVzIGZv
ciBnZnggd29ya2xvYWRzLg0KPiBVc2VybW9kZSBxdWV1ZXMgaXMgYSBtZXRob2Qgb2YgR1BVIHdv
cmtsb2FkIHN1Ym1pc3Npb24gaW50byB0aGUgDQo+IGdyYXBoaWNzIGhhcmR3YXJlIHdpdGhvdXQg
YW55IGludGVyYWN0aW9uIHdpdGgga2VybmVsL0RSTSBzY2hlZHVsZXJzLiANCj4gSW4gdGhpcyBt
ZXRob2QsIGEgdXNlcnNwYWNlIGdyYXBoaWNzIGFwcGxpY2F0aW9uIGNhbiBjcmVhdGUgaXRzIG93
biANCj4gd29ya3F1ZXVlIGFuZCBzdWJtaXQgaXQgZGlyZWN0bHkgaW4gdGhlIEdQVSBIVy4NCj4N
Cj4gVGhlIGdlbmVyYWwgaWRlYSBvZiBob3cgdGhpcyBpcyBzdXBwb3NlZCB0byB3b3JrOg0KPiAt
IFRoZSBhcHBsaWNhdGlvbiBjcmVhdGVzIHRoZSBmb2xsb3dpbmcgR1BVIG9iamV0Y3M6DQo+ICAg
LSBBIHF1ZXVlIG9iamVjdCB0byBob2xkIHRoZSB3b3JrbG9hZCBwYWNrZXRzLg0KPiAgIC0gQSBy
ZWFkIHBvaW50ZXIgb2JqZWN0Lg0KPiAgIC0gQSB3cml0ZSBwb2ludGVyIG9iamVjdC4NCj4gICAt
IEEgZG9vcmJlbGwgcGFnZS4NCj4gLSBUaGUgYXBwbGljYXRpb24gcGlja3MgYSAzMi1iaXQgb2Zm
c2V0IGluIHRoZSBkb29yYmVsbCBwYWdlIGZvciB0aGlzIHF1ZXVlLg0KPiAtIFRoZSBhcHBsaWNh
dGlvbiB1c2VzIHRoZSB1c2VybW9kZV9xdWV1ZV9jcmVhdGUgSU9DVEwgaW50cm9kdWNlZCBpbg0K
PiAgIHRoaXMgcGF0Y2gsIGJ5IHBhc3NpbmcgdGhlIHRoZSBHUFUgYWRkcmVzc2VzIG9mIHRoZXNl
IG9iamVjdHMgKHJlYWQNCj4gICBwdHIsIHdyaXRlIHB0ciwgcXVldWUgYmFzZSBhZGRyZXNzIGFu
ZCAzMi1iaXQgZG9vcmJlbGwgb2Zmc2V0IGZyb20NCj4gICB0aGUgZG9vcmJlbGwgcGFnZSkNCj4g
LSBUaGUga2VybmVsIGNyZWF0ZXMgdGhlIHF1ZXVlIGFuZCBtYXBzIGl0IGluIHRoZSBIVy4NCj4g
LSBUaGUgYXBwbGljYXRpb24gY2FuIHN0YXJ0IHN1Ym1pdHRpbmcgdGhlIGRhdGEgaW4gdGhlIHF1
ZXVlIGFzIHNvb24gYXMNCj4gICB0aGUga2VybmVsIElPQ1RMIHJldHVybnMuDQo+IC0gQWZ0ZXIg
ZmlsbGluZyB0aGUgd29ya2xvYWQgZGF0YSBpbiB0aGUgcXVldWUsIHRoZSBhcHAgbXVzdCB3cml0
ZSB0aGUNCj4gICBudW1iZXIgb2YgZHdvcmRzIGFkZGVkIGluIHRoZSBxdWV1ZSBpbnRvIHRoZSBk
b29yYmVsbCBvZmZzZXQsIGFuZCB0aGUNCj4gICBHUFUgd2lsbCBzdGFydCBmZXRjaGluZyB0aGUg
ZGF0YS4NCj4NCj4gbGliRFJNIGNoYW5nZXMgZm9yIHRoaXMgc2VyaWVzIGFuZCBhIHNhbXBsZSBE
Uk0gdGVzdCBwcm9ncmFtIGNhbiBiZSANCj4gZm91bmQgaW4gdGhlIE1FU0EgbWVyZ2UgcmVxdWVz
dCBoZXJlOg0KPiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvbWVzYS9kcm0vLS9tZXJn
ZV9yZXF1ZXN0cy8yODcNCj4NCj4gVGhpcyBwYXRjaCBzZXJpZXMgZGVwZW5kcyBvbiB0aGUgZG9v
cmJlbGwtbWFuYWdlciBjaGFuZ2VzLCB3aGljaCBhcmUgDQo+IGJlaW5nIHJldmlld2VkIGhlcmU6
DQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9zZXJpZXMvMTE1ODAyLw0KPg0K
PiBBbGV4IERldWNoZXIgKDEpOg0KPiAgIGRybS9hbWRncHU6IFVBUEkgZm9yIHVzZXIgcXVldWUg
bWFuYWdlbWVudA0KPg0KPiBBcnZpbmQgWWFkYXYgKDIpOg0KPiAgIGRybS9hbWRncHU6IGFkZCBu
ZXcgcGFyYW1ldGVycyBpbiB2MTFfc3RydWN0DQo+ICAgZHJtL2FtZGdwdTogbWFwIHdwdHIgQk8g
aW50byBHQVJUDQo+DQo+IFNoYXNoYW5rIFNoYXJtYSAoNik6DQo+ICAgZHJtL2FtZGdwdTogYWRk
IHVzZXJtb2RlIHF1ZXVlIGJhc2UgY29kZQ0KPiAgIGRybS9hbWRncHU6IGFkZCBuZXcgSU9DVEwg
Zm9yIHVzZXJtb2RlIHF1ZXVlDQo+ICAgZHJtL2FtZGdwdTogY3JlYXRlIEdGWC1nZW4xMSBNUUQg
Zm9yIHVzZXJxdWV1ZQ0KPiAgIGRybS9hbWRncHU6IGNyZWF0ZSBjb250ZXh0IHNwYWNlIGZvciB1
c2VybW9kZSBxdWV1ZQ0KPiAgIGRybS9hbWRncHU6IG1hcCB1c2VybW9kZSBxdWV1ZSBpbnRvIE1F
Uw0KPiAgIGRybS9hbWRncHU6IGdlbmVyYXRlIGRvb3JiZWxsIGluZGV4IGZvciB1c2VycXVldWUN
Cj4NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L01ha2VmaWxlICAgICAgICAgICB8ICAg
MyArDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCAgICAgICAgICAgfCAg
MTAgKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYyAgICAgICB8
ICAgMiArDQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMgICAgICAg
fCAgIDYgKw0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxdWV1ZS5j
IHwgMjk4IA0KPiArKysrKysrKysrKysrKysrKysgIC4uLi9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dXNlcnF1ZXVlX2dmeF92MTEuYyB8IDIzMCArKysrKysrKysrKysrKw0KPiAgLi4uL2dwdS9kcm0v
YW1kL2luY2x1ZGUvYW1kZ3B1X3VzZXJxdWV1ZS5oICAgIHwgIDY2ICsrKysNCj4gIGRyaXZlcnMv
Z3B1L2RybS9hbWQvaW5jbHVkZS92MTFfc3RydWN0cy5oICAgICB8ICAxNiArLQ0KPiAgaW5jbHVk
ZS91YXBpL2RybS9hbWRncHVfZHJtLmggICAgICAgICAgICAgICAgIHwgIDU1ICsrKysNCj4gIDkg
ZmlsZXMgY2hhbmdlZCwgNjc3IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pICBjcmVhdGUg
bW9kZSANCj4gMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycXVl
dWUuYw0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IA0KPiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdXNlcnF1ZXVlX2dmeF92MTEuYw0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZl
cnMvZ3B1L2RybS9hbWQvaW5jbHVkZS9hbWRncHVfdXNlcnF1ZXVlLmgNCj4NCj4gLS0NCj4gMi40
MC4wDQo+DQo=

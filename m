Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A89EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Mar 2022 06:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BA8410EC10;
	Fri,  4 Mar 2022 06:35:12 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2084.outbound.protection.outlook.com [40.107.95.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C466C10E895
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Mar 2022 06:35:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWONNM5/VrNjtyYQ56ApFwSCgIP84R3MaciOseR9QMsjDz8YT9/vLU2BcfMgXui3IK1zpDrS4nPBPwAUXU+OU9psZhCrcbHRUkAXbl548fMMm0J1LiKYs8Iac4hnQQxQG8jlL3TheZFIRX64GBEwFEkLjys5AjmzcB8Rq5IKGhwBk7Lxm1D+zscfA/8zPkm8iEFMTHLRIN2uzNUqo9kI5VKp+tvTpwewafSEeso8yWADBijlfTmO8K8OMK2WQYIB5pAmFhObUlIegBjdlG/6NmwdZbdGMdxSLwxAxpmC0xqnZWFa7ntV4zqtWa0CufnDuk9X91wQSr+Ye6jv5yaTWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bARxFeXn7SqJsXew/rETUGw/4lG64mO3koCd7UnvIa8=;
 b=gVpwjJatDBCC0pOa71aDC6w3oHsh7NYP/VjDPPA3N7hqxfNcPSbnk0giTUxH6NHqHLROCnLjC7rUUaVg+66bLTeDs5J5kIN29zmrojciu2B7dQnZwmlZ+AsFVAvQ3M0YeiqgpaUoB+fxIPDGXUL6dw69i4CYsJL3a4aF8ywtMOhl6A0Zy2asw6ugIypr/X8Uq3YRJccIskeipvzEkDeXleemZKsOCgXYK4COK/arcJiOT4Rzhk41VIi0yaLKKf4ZyuF1dTJLycO7xkYXh6QCakqq59ZeCafYtQMCgYbUUMyGNhAnm3MlOMhphul76eGP86E4RmFf/E6yX+EtC0VyCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bARxFeXn7SqJsXew/rETUGw/4lG64mO3koCd7UnvIa8=;
 b=1zGB/ONhu3/t4QfPARTHcilovdNmZWP5Axtf5KNPx0mPw7VbepruAi3x25/pv0/EOf/VoRJ3L4GIkhqVI2z3u+w3f20fOL4T21YMRrTuYlQkhmi0Xx8kIrMKOh4jmXMswgbKf0VUbYZVXJkmtZmxEBM7piKT5xbesOHRBmQLABQ=
Received: from CY4PR12MB1927.namprd12.prod.outlook.com (2603:10b6:903:127::15)
 by DM6PR12MB2618.namprd12.prod.outlook.com (2603:10b6:5:49::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 06:35:08 +0000
Received: from CY4PR12MB1927.namprd12.prod.outlook.com
 ([fe80::4c2d:a4b8:3d26:8dcb]) by CY4PR12MB1927.namprd12.prod.outlook.com
 ([fe80::4c2d:a4b8:3d26:8dcb%4]) with mapi id 15.20.5038.013; Fri, 4 Mar 2022
 06:35:08 +0000
From: "Chen, JingWen" <JingWen.Chen2@amd.com>
To: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>
Subject: Re: [RFC v4 02/11] drm/amdgpu: Move scheduler init to after XGMI is
 ready
Thread-Topic: [RFC v4 02/11] drm/amdgpu: Move scheduler init to after XGMI is
 ready
Thread-Index: AQHYHUtOdZTRleTQLkS6G3YM+VdPOayK2a6AgACrOgCAF1tqgIAAGyAAgAANfYCAAAOsgIABKkMAgACqPYCAB6CWgIAAAT2AgACXx4CAAATvgIAA34gAgADqN4A=
Date: Fri, 4 Mar 2022 06:35:08 +0000
Message-ID: <A2B65E35-266D-46AF-800D-0812898DBF82@amd.com>
References: <20220209002320.6077-1-andrey.grodzovsky@amd.com>
 <20220209002320.6077-3-andrey.grodzovsky@amd.com>
 <d82ac1a0-d81d-9861-fc1b-8cc06017a2b5@gmail.com>
 <1d7cb471-c32c-416c-4336-317ee9f171ef@amd.com>
 <3752a89c-d468-8c39-03a9-37d592dae89f@amd.com>
 <48c207dc-cc7a-efda-a4a8-4f1f1a6511fe@amd.com>
 <BL1PR12MB514424A75728E78BC0E5B848F73D9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <91b8771b-695d-b126-13ec-50dddd56f200@amd.com>
 <7c07d1b7-e700-60f3-1114-f1386892e836@amd.com>
 <9df3a044-a0a6-cdea-887a-82e7cc9f47eb@amd.com>
 <f36352a4-78a9-8e4b-4ec4-8722240d445d@amd.com>
 <0049c754-2af6-0558-3278-620faa4ed7e3@amd.com>
 <C3715E75-B013-409C-B2A3-E10CD79FD027@amd.com>
 <7e9dc4ea-3665-7632-280f-9e8ed8948b45@amd.com>
 <1f4c7682-790a-7c71-33e2-0d2277b642d1@amd.com>
In-Reply-To: <1f4c7682-790a-7c71-33e2-0d2277b642d1@amd.com>
Accept-Language: en-150, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.60.0.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 184d7de1-9ee5-48f5-173e-08d9fda92068
x-ms-traffictypediagnostic: DM6PR12MB2618:EE_
x-microsoft-antispam-prvs: <DM6PR12MB2618C19BDCC85FE341CBE1A2B7059@DM6PR12MB2618.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ObgdkzOkFNZkAglMISrMnkqDmOQueCx6yhUe0tPtYAXjph8bgEtNw5wdy7GWUcy/ULq2wGyojcn9wWCJZYdWf4Oz5jU6XHxpNkupXqmtlANhf4g/7fYhjgyyASVrRm9MWTYzArUICXQp6A/4w9/DQVH7vb+C8SjEeUDVRfP/rYJYNB9PbpTUzOYpdgQinjSf4t//xXKEW5/x99fSN7JjLlWp5HKBonWygP+1wte1xLH09kCtIdrb0jsbxycStEueBriK92c4MBLe9aDPZVrK7IQTdA7m+g3GyZ/7iDi/SK8dSQ3Xc2TzP6lf3IO9kHRekElAobVl+4nu5ci00xIWzsswbjS/Ft3ju6hX+yIr1Y0V/4E2HH5gsqW5OnZOpwMfBxkg2NjEnmRWaoE5eiFCUQoEJZJPPJSg55WnPhoO5lBfZlHM5Xhgqinp7jq8QTE/OiNc2qnE7oqIuRUpRKbEVlU4IPvSxCb7hpWOMCW8dOsPo+6O8/txfhv/rpegrLsN23nrjaxK39ZtqnomFVAIAJmbccFI47OwRmJC7+wQY64/SKh6cq1vkL39uqNh9+vMzWtLgRvhqiKnR4KmxXJlXtfcJd7IVYWHA0I9lv/XwATMbNnT+y4o80tAjdFpQ2lx9XFX4tOlj2799bB8j+3lKhm7oeEeaPLmN3lBiuqjzbyePdVaewvt7JxGFBwT2czemWRuALZR2VQxUkkLEJciUz/9gaDAYBlw9BKHWyJ8QRuJa2nGNbuh6k7L2qpZ/MqS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1927.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(38070700005)(2616005)(36756003)(6512007)(26005)(186003)(8676002)(6506007)(122000001)(66946007)(38100700002)(5660300002)(76116006)(91956017)(66476007)(66446008)(66574015)(6862004)(64756008)(53546011)(4326008)(66556008)(71200400001)(86362001)(2906002)(508600001)(33656002)(6486002)(6636002)(30864003)(83380400001)(37006003)(54906003)(8936002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGFqcWxlcG96eUxTZEFKaXQ0OC8vaEh4TlFmRHBFQzBCem5taDlWYTd0aWhN?=
 =?utf-8?B?SmpDaEhrTnFtekxJblR4K2JaYy9ad2hSVDB5eE5mT3hrTTBmZWxzV2lpMmMw?=
 =?utf-8?B?TmVBVGc0V0d6RldZbGIydUdCdFNFazgxOUoza05hQkN3Nm04U2VZL1lMM1Bi?=
 =?utf-8?B?aG1seVVFUjFrLzBKdE9iREwyLzR3d1lxVmRGWXhaOXlDV0hTQzlrZjhMeis4?=
 =?utf-8?B?WGhBbkVMeTMrM1A0UXJNanhleGRmODNuaFF6dDZQblVxblU0RzNibURCb3pa?=
 =?utf-8?B?L1BxS3BrOE4rVUJFNllJQkFQbG1FUDdHc1RuVmFaRjZzczNtTkFwWkluRnd1?=
 =?utf-8?B?VVRqa1ZQOWRxL3BGd29qWTR6Z2tzSU4yM1hvLzVSb3VRYmRhS3RZSlh5K1hE?=
 =?utf-8?B?RDRqbERmRVNuRFVYV0hXQW5OOVFsQSthSlFPeHdMNktGTkFRMCtHakNTTlhC?=
 =?utf-8?B?bFFKVG53RFVPUDZLWmptN1F5VVlkRXRZV3FnS2NHZ0FYRVRLcmhjTmUyV1Np?=
 =?utf-8?B?Y0JMVUpRZzZnL2NsMXJvWS9KL0owRlNUVnFNYmRLWDduNDk3UktUOUNPZG5j?=
 =?utf-8?B?bXNQN1BpOTYyTy92K0FadklmSTB4allSVFRFZUxFVFBxelF4cDd0V2sxbEt5?=
 =?utf-8?B?UU03V1hRbW1oZUU2YkErMXBBWXJHbnFDakpweUNDMWpKZmlsVXBwa3FydDhr?=
 =?utf-8?B?aWVxZUxnb1kwTzczNUFkZmx6VE02clRtSnlHWFpmd09DYU9tNy9XeDV1S3dZ?=
 =?utf-8?B?bHhENktKSy9Db1h2QkJwQ1hsOG9CaVJ5cENXNGNjVWhKZVErdE1lOC9UZjVn?=
 =?utf-8?B?WDQvM1l6NDR1Y2xRaW5UaFpSN3d4eC9iK3dIQ1REUWM0SDVPaDZyYmJnU1lM?=
 =?utf-8?B?S3c4ckhsNWp6Tm1ONmNoTjhlTmRpc2JlZXJXV05qR3lHZUtXb0xHTHRzYlVt?=
 =?utf-8?B?d1lObkoxNkFTWllFVFV0TmMvbFM3U25VWTVDMDRpNHBaVmFkS2VHQW9Sa2VU?=
 =?utf-8?B?dXNQVDJmakxoNXNkUHo0WXZNbk5FUzlzQWVBbE1VVktIUVlQeCtXZ1ZlbnBQ?=
 =?utf-8?B?dHA3UUdWL2JBMXB1RnlRMTF5M015K3NwWVBuN0hxcUlHdkl5OEc4ZEg2NnV3?=
 =?utf-8?B?TGoxL0tYZWcva2twWE9RK2ZkWE5USFZPZjJueE04TS9UU2pvQTAxU3hQb2RJ?=
 =?utf-8?B?YWJyc1RBZ2s4UFMxUVgvcnF4WHllcFVFUnAvMHFWb2MzWC9LK0Uwcmxyczc3?=
 =?utf-8?B?YlozSDh0TVJWVWhzb2RhaGZRYkZGZ1l4NkFicmFkZWJlb3VydGVQQk1JelI4?=
 =?utf-8?B?VVlXbnRoY3QydUN6WW9odkFEd3RUbzZObTRIQmNUTGtwZ2tZSDNteDlyRVlh?=
 =?utf-8?B?d1JxdUpIV3FzU0R6eDh0SlJZVnk5dlpFUjRHWWNlUHB0Q2dzMnNVMStEaXZC?=
 =?utf-8?B?bjFLdUNQVDZyWGNRQkxuYXNhQXdEWFQ1UFBwL0FUT2VtZzB1S0pCSFQ5b244?=
 =?utf-8?B?QmQ5M2tuN2JZSDRkZlRBeUZiWVJZL3lGdEhXMlV0cjU3cVA1eUx6eWNFVHMx?=
 =?utf-8?B?dFJ6TTV3aFdGOE9LR3JCVHB5ekVneXhOb1RSYzFZQkdDK21KdW1LaXRMZ1lZ?=
 =?utf-8?B?U1p2U0VINWlsTjliQ1R2RGlUVkphdHZZM1ZSWDd3NDlpUTh1NUVQcnBQbHIw?=
 =?utf-8?B?VEc3aWczRnVnMXlkTDdoNkkvenplN2x6UFp0TWdYbW9kVGJQQ2hBajhjRUFz?=
 =?utf-8?B?Vkh0S1ZPOTQyck91dlNUTGVDRVpVWkdLWmNRbnpXK2l5Q1ZqN2JrajZPSkZ6?=
 =?utf-8?B?SWxDbnUybU5ja3UzR0U1dFdUd213TWw1bUdZSjgzRkhPRHJqVmRkUFNnVUJU?=
 =?utf-8?B?dGRpd1QzRnN1V1R2a2NmaldQZkJFWkFRQzZaYjdzcVBvT3p4TVU4U2ZUamlN?=
 =?utf-8?B?REdmUGhKZndnNVhMeUlzTFVOazdQNkl6anlKMUNZeVhDSlNYcVd4MUhyeTA0?=
 =?utf-8?B?bEVSc3h2Zk13bWtjWjc1Wng2dFplY1Y1R0JaZDNNcS85TE1PVGMvVVR5Unp6?=
 =?utf-8?B?TWxHeXBvK3dPZGQ2KzlBUjE3b2FZU1p0TWk0RnZwSlk5OFdIRlU3dVJUWmtq?=
 =?utf-8?B?L1VtQWJVRU9tbHFhbTBOd2xlTWZxN1kwcHExMEZqZVRlTW9nWmdVUnNmbldh?=
 =?utf-8?Q?1dY8LMZAF6GzDEaD6rWg85QZqR1IhKT0B0jd+Iod3DXc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D657DE127FD09C4C91911C0695DB005D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1927.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 184d7de1-9ee5-48f5-173e-08d9fda92068
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 06:35:08.3066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dtuDocI4bM/iUeUEFZLgoOECICiyo/J2qMns1lWJwANWjAww45oqr2Ub95zLU/IsIpMhXx6KsvNJ+70r23gAQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2618
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
Cc: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "Chen, JingWen" <JingWen.Chen2@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhhbmtzIGEgbG90DQoNCkJlc3QgUmVnYXJkcywNCkppbmdXZW4gQ2hlbg0KDQoNCg0KPiBPbiBN
YXIgNCwgMjAyMiwgYXQgMDA6MzYsIEdyb2R6b3Zza3ksIEFuZHJleSA8QW5kcmV5Lkdyb2R6b3Zz
a3lAYW1kLmNvbT4gd3JvdGU6DQo+IA0KPiBJIHB1c2hlZCBhbGwgdGhlIGNoYW5nZXMgaW5jbHVk
aW5nIHlvdXIgcGF0Y2guDQo+IA0KPiBBbmRyZXkNCj4gDQo+IE9uIDIwMjItMDMtMDIgMjI6MTYs
IEFuZHJleSBHcm9kem92c2t5IHdyb3RlOg0KPj4gT0ssIGkgd2lsbCBkbyBxdWljayBzbW9rZSB0
ZXN0IHRvbW9ycm93IGFuZCBwdXNoIGFsbCBvZiBpdCBpdCB0aGVuLg0KPj4gDQo+PiBBbmRyZXkN
Cj4+IA0KPj4gT24gMjAyMi0wMy0wMiAyMTo1OSwgQ2hlbiwgSmluZ1dlbiB3cm90ZToNCj4+PiBI
aSBBbmRyZXksDQo+Pj4gDQo+Pj4gSSBkb24ndCBoYXZlIHRoZSBiYXJlIG1lbnRhbCBlbnZpcm9u
bWVudCwgSSBjYW4gb25seSB0ZXN0IHRoZSBTUklPViBjYXNlcy4NCj4+PiANCj4+PiBCZXN0IFJl
Z2FyZHMsDQo+Pj4gSmluZ1dlbiBDaGVuDQo+Pj4gDQo+Pj4gDQo+Pj4gDQo+Pj4+IE9uIE1hciAz
LCAyMDIyLCBhdCAwMTo1NSwgR3JvZHpvdnNreSwgQW5kcmV5IDxBbmRyZXkuR3JvZHpvdnNreUBh
bWQuY29tPiB3cm90ZToNCj4+Pj4gDQo+Pj4+IFRoZSBwYXRjaCBpcyBhY2tlZC1ieTogQW5kcmV5
IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+DQo+Pj4+IA0KPj4+PiBJZiB5
b3UgYWxzbyBzbW9rZWQgdGVzdGVkIGJhcmUgbWV0YWwgZmVlbCBmcmVlIHRvIGFwcGx5IGFsbCB0
aGUgcGF0Y2hlcywgaWYgbm8gbGV0IG1lIGtub3cuDQo+Pj4+IA0KPj4+PiBBbmRyZXkNCj4+Pj4g
DQo+Pj4+IE9uIDIwMjItMDMtMDIgMDQ6NTEsIEppbmdXZW4gQ2hlbiB3cm90ZToNCj4+Pj4+IEhp
IEFuZHJleSwNCj4+Pj4+IA0KPj4+Pj4gTW9zdCBwYXJ0IG9mIHRoZSBwYXRjaGVzIGFyZSBPSywg
YnV0IHRoZSBjb2RlIHdpbGwgaW50cm9kdWNlIGEgaWIgdGVzdCBmYWlsIG9uIHRoZSBkaXNhYmxl
ZCB2Y24gb2Ygc2llbm5hX2NpY2hsaWQuDQo+Pj4+PiANCj4+Pj4+IEluIFNSSU9WIHVzZSBjYXNl
IHdlIHdpbGwgZGlzYWJsZSBvbmUgdmNuIG9uIHNpZW5uYV9jaWNobGlkLCBJIGhhdmUgYXR0YWNo
ZWQgYSBwYXRjaCB0byBmaXggdGhpcyBpc3N1ZSwgcGxlYXNlIGNoZWNrIHRoZSBhdHRhY2htZW50
Lg0KPj4+Pj4gDQo+Pj4+PiBCZXN0IFJlZ2FyZHMsDQo+Pj4+PiANCj4+Pj4+IEppbmd3ZW4gQ2hl
bg0KPj4+Pj4gDQo+Pj4+PiANCj4+Pj4+IE9uIDIvMjYvMjIgNToyMiBBTSwgQW5kcmV5IEdyb2R6
b3Zza3kgd3JvdGU6DQo+Pj4+Pj4gSGV5LCBwYXRjaGVzIGF0dGFjaGVkIC0gaSBhcHBsaWVkIHRo
ZSBwYXRjaGVzIGFuZCByZXNvbHZlZCBtZXJnZSBjb25mbGljdHMgYnV0IHdlcmVuJ3QgYWJsZSB0
byB0ZXN0IGFzIG15IG9uIGJvYXJkJ3MgbmV0d29yayBjYXJkIGRvZXNuJ3Qgd29yayB3aXRoIDUu
MTYga2VybmVsIChpdCBkb2VzIHdpdGggNS4xNywgbWF5YmUgaXQncyBLY29uZmlnIGlzc3VlIGFu
ZCBpIG5lZWQgdG8gY2hlY2sgbW9yZSkuDQo+Pj4+Pj4gVGhlIHBhdGNoZXMgYXJlIG9uIHRvcCBv
ZiAnY2FiYWJkZTE5MmIyIFlpZmFuIFpoYW5nICAgICAgICAgMiBkYXlzIGFnbyAgICAgZHJtL2Ft
ZC9wbTogZml4IG1vZGUyIHJlc2V0IGZhaWwgZm9yIHNtdSAxMy4wLjUgJyBjb21taXQuDQo+Pj4+
Pj4gDQo+Pj4+Pj4gUGxlYXNlIHRlc3QgYW5kIGxldCBtZSBrbm93LiBNYXliZSBieSBNb25kYXkg
SSB3aWxsIGJlIGFibGUgdG8gcmVzb2x2ZSB0aGUgY29ubmVjdGl2aXR5IGlzc3VlIG9uIDUuMTYu
DQo+Pj4+Pj4gDQo+Pj4+Pj4gQW5kcmV5DQo+Pj4+Pj4gDQo+Pj4+Pj4gT24gMjAyMi0wMi0yNCAy
MjoxMywgSmluZ1dlbiBDaGVuIHdyb3RlOg0KPj4+Pj4+PiBIaSBBbmRyZXksDQo+Pj4+Pj4+IA0K
Pj4+Pj4+PiBTb3JyeSBmb3IgdGhlIG1pc2xlYWRpbmcsIEkgbWVhbiB0aGUgd2hvbGUgcGF0Y2gg
c2VyaWVzLiBXZSBhcmUgZGVwZW5kaW5nIG9uIHRoaXMgcGF0Y2ggc2VyaWVzIHRvIGZpeCB0aGUg
Y29uY3VycmVuY3kgaXNzdWUgd2l0aGluIFNSSU9WIFREUiBzZXF1ZW5jZS4NCj4+Pj4+Pj4gDQo+
Pj4+Pj4+IA0KPj4+Pj4+PiANCj4+Pj4+Pj4gT24gMi8yNS8yMiAxOjI2IEFNLCBBbmRyZXkgR3Jv
ZHpvdnNreSB3cm90ZToNCj4+Pj4+Pj4+IE5vIHByb2JsZW0gaWYgc28gYnV0IGJlZm9yZSBJIGRv
LA0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IEppbmdXZW4gLSB3aHkgeW91IHRoaW5r
IHRoaXMgcGF0Y2ggaXMgbmVlZGVkIGFzIGEgc3RhbmRhbG9uZSBub3cgPyBJdCBoYXMgbm8gdXNl
IHdpdGhvdXQgdGhlDQo+Pj4+Pj4+PiBlbnRpcmUgZmVhdHVyZSB0b2dldGhlciB3aXRoIGl0LiBJ
cyBpdCBzb21lIGNoYW5nZXMgeW91IHdhbnQgdG8gZG8gb24gdG9wIG9mIHRoYXQgY29kZSA/DQo+
Pj4+Pj4+PiANCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gQW5kcmV5DQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+
IA0KPj4+Pj4+Pj4gT24gMjAyMi0wMi0yNCAxMjoxMiwgRGV1Y2hlciwgQWxleGFuZGVyIHdyb3Rl
Og0KPj4+Pj4+Pj4+IFtQdWJsaWNdDQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4g
SWYgaXQgYXBwbGllcyBjbGVhbmx5LCBmZWVsIGZyZWUgdG8gZHJvcCBpdCBpbi4gSSdsbCBkcm9w
IHRob3NlIHBhdGNoZXMgZm9yIGRybS1uZXh0IHNpbmNlIHRoZXkgYXJlIGFscmVhZHkgaW4gZHJt
LW1pc2MuDQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gQWxleA0KPj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLSANCj4+Pj4+Pj4+PiAqRnJvbToqIGFtZC1nZnggPGFtZC1nZngtYm91
bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IG9uIGJlaGFsZiBvZiBBbmRyZXkgR3JvZHpvdnNr
eSA8YW5kcmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4NCj4+Pj4+Pj4+PiAqU2VudDoqIFRodXJzZGF5
LCBGZWJydWFyeSAyNCwgMjAyMiAxMToyNCBBTQ0KPj4+Pj4+Pj4+ICpUbzoqIENoZW4sIEppbmdX
ZW4gPEppbmdXZW4uQ2hlbjJAYW1kLmNvbT47IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVp
Y2h0enVtZXJrZW5AZ21haWwuY29tPjsgZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZyA8
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnIDxhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4NCj4+Pj4+Pj4+PiAqQ2M6KiBM
aXUsIE1vbmsgPE1vbmsuTGl1QGFtZC5jb20+OyBDaGVuLCBIb3JhY2UgPEhvcmFjZS5DaGVuQGFt
ZC5jb20+OyBMYXphciwgTGlqbyA8TGlqby5MYXphckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3Rp
YW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT47IGRhbmllbEBmZndsbC5jaCA8ZGFuaWVsQGZm
d2xsLmNoPg0KPj4+Pj4+Pj4+ICpTdWJqZWN0OiogUmU6IFtSRkMgdjQgMDIvMTFdIGRybS9hbWRn
cHU6IE1vdmUgc2NoZWR1bGVyIGluaXQgdG8gYWZ0ZXIgWEdNSSBpcyByZWFkeQ0KPj4+Pj4+Pj4+
IE5vIGJlY2F1c2UgYWxsIHRoZSBwYXRjaC1zZXQgaW5jbHVkaW5nIHRoaXMgcGF0Y2ggd2FzIGxh
bmRlZCBpbnRvDQo+Pj4+Pj4+Pj4gZHJtLW1pc2MtbmV4dCBhbmQgd2lsbCByZWFjaCBhbWQtc3Rh
Z2luZy1kcm0tbmV4dCBvbiB0aGUgbmV4dCB1cHN0cmVhbQ0KPj4+Pj4+Pj4+IHJlYmFzZSBpIGd1
ZXNzLg0KPj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+IEFuZHJleQ0KPj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+
IE9uIDIwMjItMDItMjQgMDE6NDcsIEppbmdXZW4gQ2hlbiB3cm90ZToNCj4+Pj4+Pj4+Pj4gSGkg
QW5kcmV5LA0KPj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4gV2lsbCB5b3UgcG9ydCB0aGlzIHBhdGNo
IGludG8gYW1kLXN0YWdpbmctZHJtLW5leHQ/DQo+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+PiBvbiAy
LzEwLzIyIDI6MDYgQU0sIEFuZHJleSBHcm9kem92c2t5IHdyb3RlOg0KPj4+Pj4+Pj4+Pj4gQWxs
IGNvbW1lbnRzIGFyZSBmaXhlZCBhbmQgY29kZSBwdXNoZWQuIFRoYW5rcyBmb3IgZXZlcnlvbmUN
Cj4+Pj4+Pj4+Pj4+IHdobyBoZWxwZWQgcmV2aWV3aW5nLg0KPj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+
Pj4+PiBBbmRyZXkNCj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4gT24gMjAyMi0wMi0wOSAwMjo1
MywgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToNCj4+Pj4+Pj4+Pj4+PiBBbSAwOS4wMi4yMiB1bSAw
MToyMyBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Og0KPj4+Pj4+Pj4+Pj4+PiBCZWZvcmUgd2Ug
aW5pdGlhbGl6ZSBzY2hlZHVsZXJzIHdlIG11c3Qga25vdyB3aGljaCByZXNldA0KPj4+Pj4+Pj4+
Pj4+PiBkb21haW4gYXJlIHdlIGluIC0gZm9yIHNpbmdsZSBkZXZpY2UgdGhlcmUgaWlzIGEgc2lu
Z2xlDQo+Pj4+Pj4+Pj4+Pj4+IGRvbWFpbiBwZXIgZGV2aWNlIGFuZCBzbyBzaW5nbGUgd3EgcGVy
IGRldmljZS4gRm9yIFhHTUkNCj4+Pj4+Pj4+Pj4+Pj4gdGhlIHJlc2V0IGRvbWFpbiBzcGFucyB0
aGUgZW50aXJlIFhHTUkgaGl2ZSBhbmQgc28gdGhlDQo+Pj4+Pj4+Pj4+Pj4+IHJlc2V0IHdxIGlz
IHBlciBoaXZlLg0KPj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTog
QW5kcmV5IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+DQo+Pj4+Pj4+Pj4+
Pj4gT25lIG1vcmUgY29tbWVudCBiZWxvdywgd2l0aCB0aGF0IGZpeGVkIFJldmlld2VkLWJ5OiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Lg0KPj4+Pj4+Pj4+Pj4+
IA0KPj4+Pj4+Pj4+Pj4+PiAtLS0NCj4+Pj4+Pj4+Pj4+Pj4gZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jIHwgNDUgKysrKysrKysrKysrKysrKysrKysrKw0KPj4+Pj4+
Pj4+Pj4+PiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYyAgfCAzNCAr
Ky0tLS0tLS0tLS0tLS0tDQo+Pj4+Pj4+Pj4+Pj4+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9yaW5nLmggfCAgMiArDQo+Pj4+Pj4+Pj4+Pj4+ICAgICAgIDMgZmlsZXMgY2hhbmdl
ZCwgNTEgaW5zZXJ0aW9ucygrKSwgMzAgZGVsZXRpb25zKC0pDQo+Pj4+Pj4+Pj4+Pj4+IA0KPj4+
Pj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jDQo+
Pj4+Pj4+Pj4+Pj4+IGluZGV4IDk3MDRiMGUxZmQ4Mi4uMDAxMjNiMDAxM2QzIDEwMDY0NA0KPj4+
Pj4+Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNl
LmMNCj4+Pj4+Pj4+Pj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jDQo+Pj4+Pj4+Pj4+Pj4+IEBAIC0yMjg3LDYgKzIyODcsNDcgQEAgc3RhdGljIGlu
dCBhbWRncHVfZGV2aWNlX2Z3X2xvYWRpbmcoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpDQo+
Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgICByZXR1cm4gcjsNCj4+Pj4+Pj4+Pj4+Pj4gICAgICAgfQ0K
Pj4+Pj4+Pj4+Pj4+PiAgICAgICArc3RhdGljIGludCBhbWRncHVfZGV2aWNlX2luaXRfc2NoZWR1
bGVycyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCj4+Pj4+Pj4+Pj4+Pj4gK3sNCj4+Pj4+
Pj4+Pj4+Pj4gKyAgICBsb25nIHRpbWVvdXQ7DQo+Pj4+Pj4+Pj4+Pj4+ICsgICAgaW50IHIsIGk7
DQo+Pj4+Pj4+Pj4+Pj4+ICsNCj4+Pj4+Pj4+Pj4+Pj4gKyAgICBmb3IgKGkgPSAwOyBpIDwgQU1E
R1BVX01BWF9SSU5HUzsgKytpKSB7DQo+Pj4+Pj4+Pj4+Pj4+ICsgICAgICAgIHN0cnVjdCBhbWRn
cHVfcmluZyAqcmluZyA9IGFkZXYtPnJpbmdzW2ldOw0KPj4+Pj4+Pj4+Pj4+PiArDQo+Pj4+Pj4+
Pj4+Pj4+ICsgICAgICAgIC8qIE5vIG5lZWQgdG8gc2V0dXAgdGhlIEdQVSBzY2hlZHVsZXIgZm9y
IHJpbmdzIHRoYXQgZG9uJ3QgbmVlZCBpdCAqLw0KPj4+Pj4+Pj4+Pj4+PiArICAgICAgICBpZiAo
IXJpbmcgfHwgcmluZy0+bm9fc2NoZWR1bGVyKQ0KPj4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAg
Y29udGludWU7DQo+Pj4+Pj4+Pj4+Pj4+ICsNCj4+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgc3dpdGNo
IChyaW5nLT5mdW5jcy0+dHlwZSkgew0KPj4+Pj4+Pj4+Pj4+PiArICAgICAgICBjYXNlIEFNREdQ
VV9SSU5HX1RZUEVfR0ZYOg0KPj4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgdGltZW91dCA9IGFk
ZXYtPmdmeF90aW1lb3V0Ow0KPj4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgYnJlYWs7DQo+Pj4+
Pj4+Pj4+Pj4+ICsgICAgICAgIGNhc2UgQU1ER1BVX1JJTkdfVFlQRV9DT01QVVRFOg0KPj4+Pj4+
Pj4+Pj4+PiArICAgICAgICAgICAgdGltZW91dCA9IGFkZXYtPmNvbXB1dGVfdGltZW91dDsNCj4+
Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgIGJyZWFrOw0KPj4+Pj4+Pj4+Pj4+PiArICAgICAgICBj
YXNlIEFNREdQVV9SSU5HX1RZUEVfU0RNQToNCj4+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgIHRp
bWVvdXQgPSBhZGV2LT5zZG1hX3RpbWVvdXQ7DQo+Pj4+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICBi
cmVhazsNCj4+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgZGVmYXVsdDoNCj4+Pj4+Pj4+Pj4+Pj4gKyAg
ICAgICAgICAgIHRpbWVvdXQgPSBhZGV2LT52aWRlb190aW1lb3V0Ow0KPj4+Pj4+Pj4+Pj4+PiAr
ICAgICAgICAgICAgYnJlYWs7DQo+Pj4+Pj4+Pj4+Pj4+ICsgICAgICAgIH0NCj4+Pj4+Pj4+Pj4+
Pj4gKw0KPj4+Pj4+Pj4+Pj4+PiArICAgICAgICByID0gZHJtX3NjaGVkX2luaXQoJnJpbmctPnNj
aGVkLCAmYW1kZ3B1X3NjaGVkX29wcywNCj4+Pj4+Pj4+Pj4+Pj4gKyByaW5nLT5udW1faHdfc3Vi
bWlzc2lvbiwgYW1kZ3B1X2pvYl9oYW5nX2xpbWl0LA0KPj4+Pj4+Pj4+Pj4+PiArICAgICAgICAg
ICAgICAgICAgIHRpbWVvdXQsIGFkZXYtPnJlc2V0X2RvbWFpbi53cSwgcmluZy0+c2NoZWRfc2Nv
cmUsIHJpbmctPm5hbWUpOw0KPj4+Pj4+Pj4+Pj4+PiArICAgICAgICBpZiAocikgew0KPj4+Pj4+
Pj4+Pj4+PiArICAgICAgICAgICAgRFJNX0VSUk9SKCJGYWlsZWQgdG8gY3JlYXRlIHNjaGVkdWxl
ciBvbiByaW5nICVzLlxuIiwNCj4+Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgIHJpbmct
Pm5hbWUpOw0KPj4+Pj4+Pj4+Pj4+PiArICAgICAgICAgICAgcmV0dXJuIHI7DQo+Pj4+Pj4+Pj4+
Pj4+ICsgICAgICAgIH0NCj4+Pj4+Pj4+Pj4+Pj4gKyAgICB9DQo+Pj4+Pj4+Pj4+Pj4+ICsNCj4+
Pj4+Pj4+Pj4+Pj4gKyAgICByZXR1cm4gMDsNCj4+Pj4+Pj4+Pj4+Pj4gK30NCj4+Pj4+Pj4+Pj4+
Pj4gKw0KPj4+Pj4+Pj4+Pj4+PiArDQo+Pj4+Pj4+Pj4+Pj4+ICAgICAgIC8qKg0KPj4+Pj4+Pj4+
Pj4+PiAgICAgICAgKiBhbWRncHVfZGV2aWNlX2lwX2luaXQgLSBydW4gaW5pdCBmb3IgaGFyZHdh
cmUgSVBzDQo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAqDQo+Pj4+Pj4+Pj4+Pj4+IEBAIC0yNDE5LDYg
KzI0NjAsMTAgQEAgc3RhdGljIGludCBhbWRncHVfZGV2aWNlX2lwX2luaXQoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYpDQo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgICAgICAgfQ0KPj4+Pj4+Pj4+
Pj4+PiAgICAgICAgICAgfQ0KPj4+Pj4+Pj4+Pj4+PiAgICAgICArICAgIHIgPSBhbWRncHVfZGV2
aWNlX2luaXRfc2NoZWR1bGVycyhhZGV2KTsNCj4+Pj4+Pj4+Pj4+Pj4gKyAgICBpZiAocikNCj4+
Pj4+Pj4+Pj4+Pj4gKyAgICAgICAgZ290byBpbml0X2ZhaWxlZDsNCj4+Pj4+Pj4+Pj4+Pj4gKw0K
Pj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAgLyogRG9uJ3QgaW5pdCBrZmQgaWYgd2hvbGUgaGl2ZSBu
ZWVkIHRvIGJlIHJlc2V0IGR1cmluZyBpbml0ICovDQo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgICBp
ZiAoIWFkZXYtPmdtYy54Z21pLnBlbmRpbmdfcmVzZXQpDQo+Pj4+Pj4+Pj4+Pj4+IGFtZGdwdV9h
bWRrZmRfZGV2aWNlX2luaXQoYWRldik7DQo+Pj4+Pj4+Pj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jDQo+Pj4+Pj4+Pj4+Pj4+IGluZGV4IDQ1OTc3YTcyYjVk
ZC4uZmEzMDI1NDBjNjlhIDEwMDY0NA0KPj4+Pj4+Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYw0KPj4+Pj4+Pj4+Pj4+PiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYw0KPj4+Pj4+Pj4+Pj4+PiBAQCAtNDU3
LDggKzQ1Nyw2IEBAIGludCBhbWRncHVfZmVuY2VfZHJpdmVyX2luaXRfcmluZyhzdHJ1Y3QgYW1k
Z3B1X3JpbmcgKnJpbmcsDQo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgIGF0
b21pY190ICpzY2hlZF9zY29yZSkNCj4+Pj4+Pj4+Pj4+Pj4gICAgICAgew0KPj4+Pj4+Pj4+Pj4+
PiAgICAgICAgICAgc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2Ow0KPj4+
Pj4+Pj4+Pj4+PiAtICAgIGxvbmcgdGltZW91dDsNCj4+Pj4+Pj4+Pj4+Pj4gLSAgICBpbnQgcjsN
Cj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAgICAgaWYgKCFhZGV2KQ0KPj4+Pj4+Pj4+Pj4+PiAgICAg
ICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPj4+Pj4+Pj4+Pj4+PiBAQCAtNDc4LDM2ICs0NzYs
MTIgQEAgaW50IGFtZGdwdV9mZW5jZV9kcml2ZXJfaW5pdF9yaW5nKHN0cnVjdCBhbWRncHVfcmlu
ZyAqcmluZywNCj4+Pj4+Pj4+Pj4+Pj4gc3Bpbl9sb2NrX2luaXQoJnJpbmctPmZlbmNlX2Rydi5s
b2NrKTsNCj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAgIHJpbmctPmZlbmNlX2Rydi5mZW5jZXMgPSBr
Y2FsbG9jKG51bV9od19zdWJtaXNzaW9uICogMiwgc2l6ZW9mKHZvaWQgKiksDQo+Pj4+Pj4+Pj4+
Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEdGUF9LRVJORUwpOw0KPj4+Pj4+Pj4+Pj4+
PiAtICAgIGlmICghcmluZy0+ZmVuY2VfZHJ2LmZlbmNlcykNCj4+Pj4+Pj4+Pj4+Pj4gLSAgICAg
ICAgcmV0dXJuIC1FTk9NRU07DQo+Pj4+Pj4+Pj4+Pj4+ICAgICAgIC0gICAgLyogTm8gbmVlZCB0
byBzZXR1cCB0aGUgR1BVIHNjaGVkdWxlciBmb3IgcmluZ3MgdGhhdCBkb24ndCBuZWVkIGl0ICov
DQo+Pj4+Pj4+Pj4+Pj4+IC0gICAgaWYgKHJpbmctPm5vX3NjaGVkdWxlcikNCj4+Pj4+Pj4+Pj4+
Pj4gLSAgICAgICAgcmV0dXJuIDA7DQo+Pj4+Pj4+Pj4+Pj4+ICsgICAgcmluZy0+bnVtX2h3X3N1
Ym1pc3Npb24gPSBudW1faHdfc3VibWlzc2lvbjsNCj4+Pj4+Pj4+Pj4+Pj4gKyAgICByaW5nLT5z
Y2hlZF9zY29yZSA9IHNjaGVkX3Njb3JlOw0KPj4+Pj4+Pj4+Pj4+IExldCdzIG1vdmUgdGhpcyBp
bnRvIHRoZSBjYWxsZXIgYW5kIHRoZW4gdXNlIHJpbmctPm51bV9od19zdWJtaXNzaW9uIGluIHRo
ZSBmZW5jZSBjb2RlIGFzIHdlbGwuDQo+Pj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+Pj4gVGhlIG1h
eGltdW0gbnVtYmVyIG9mIGpvYnMgb24gdGhlIHJpbmcgaXMgbm90IHJlYWxseSBmZW5jZSBzcGVj
aWZpYy4NCj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+PiBSZWdhcmRzLA0KPj4+Pj4+Pj4+Pj4+
IENocmlzdGlhbi4NCj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+Pj4gICAgICAgLSAgICBzd2l0
Y2ggKHJpbmctPmZ1bmNzLT50eXBlKSB7DQo+Pj4+Pj4+Pj4+Pj4+IC0gICAgY2FzZSBBTURHUFVf
UklOR19UWVBFX0dGWDoNCj4+Pj4+Pj4+Pj4+Pj4gLSAgICAgICAgdGltZW91dCA9IGFkZXYtPmdm
eF90aW1lb3V0Ow0KPj4+Pj4+Pj4+Pj4+PiAtICAgICAgICBicmVhazsNCj4+Pj4+Pj4+Pj4+Pj4g
LSAgICBjYXNlIEFNREdQVV9SSU5HX1RZUEVfQ09NUFVURToNCj4+Pj4+Pj4+Pj4+Pj4gLSAgICAg
ICAgdGltZW91dCA9IGFkZXYtPmNvbXB1dGVfdGltZW91dDsNCj4+Pj4+Pj4+Pj4+Pj4gLSAgICAg
ICAgYnJlYWs7DQo+Pj4+Pj4+Pj4+Pj4+IC0gICAgY2FzZSBBTURHUFVfUklOR19UWVBFX1NETUE6
DQo+Pj4+Pj4+Pj4+Pj4+IC0gICAgICAgIHRpbWVvdXQgPSBhZGV2LT5zZG1hX3RpbWVvdXQ7DQo+
Pj4+Pj4+Pj4+Pj4+IC0gICAgICAgIGJyZWFrOw0KPj4+Pj4+Pj4+Pj4+PiAtICAgIGRlZmF1bHQ6
DQo+Pj4+Pj4+Pj4+Pj4+IC0gICAgICAgIHRpbWVvdXQgPSBhZGV2LT52aWRlb190aW1lb3V0Ow0K
Pj4+Pj4+Pj4+Pj4+PiAtICAgICAgICBicmVhazsNCj4+Pj4+Pj4+Pj4+Pj4gLSAgICB9DQo+Pj4+
Pj4+Pj4+Pj4+IC0NCj4+Pj4+Pj4+Pj4+Pj4gLSAgICByID0gZHJtX3NjaGVkX2luaXQoJnJpbmct
PnNjaGVkLCAmYW1kZ3B1X3NjaGVkX29wcywNCj4+Pj4+Pj4+Pj4+Pj4gLSAgICAgICAgICAgICAg
IG51bV9od19zdWJtaXNzaW9uLCBhbWRncHVfam9iX2hhbmdfbGltaXQsDQo+Pj4+Pj4+Pj4+Pj4+
IC0gICAgICAgICAgICAgICB0aW1lb3V0LCBOVUxMLCBzY2hlZF9zY29yZSwgcmluZy0+bmFtZSk7
DQo+Pj4+Pj4+Pj4+Pj4+IC0gICAgaWYgKHIpIHsNCj4+Pj4+Pj4+Pj4+Pj4gLSAgICAgICAgRFJN
X0VSUk9SKCJGYWlsZWQgdG8gY3JlYXRlIHNjaGVkdWxlciBvbiByaW5nICVzLlxuIiwNCj4+Pj4+
Pj4+Pj4+Pj4gLSAgICAgICAgICAgICAgcmluZy0+bmFtZSk7DQo+Pj4+Pj4+Pj4+Pj4+IC0gICAg
ICAgIHJldHVybiByOw0KPj4+Pj4+Pj4+Pj4+PiAtICAgIH0NCj4+Pj4+Pj4+Pj4+Pj4gKyAgICBp
ZiAoIXJpbmctPmZlbmNlX2Rydi5mZW5jZXMpDQo+Pj4+Pj4+Pj4+Pj4+ICsgICAgICAgIHJldHVy
biAtRU5PTUVNOw0KPj4+Pj4+Pj4+Pj4+PiAgICAgICAgICAgICByZXR1cm4gMDsNCj4+Pj4+Pj4+
Pj4+Pj4gICAgICAgfQ0KPj4+Pj4+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3JpbmcuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9yaW5nLmgNCj4+Pj4+Pj4+Pj4+Pj4gaW5kZXggZmFlN2QxODVhZDBkLi43ZjIwY2U3M2Ey
NDMgMTAwNjQ0DQo+Pj4+Pj4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9yaW5nLmgNCj4+Pj4+Pj4+Pj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3JpbmcuaA0KPj4+Pj4+Pj4+Pj4+PiBAQCAtMjUxLDYgKzI1MSw4IEBAIHN0
cnVjdCBhbWRncHVfcmluZyB7DQo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgICBib29sIGhhc19jb21w
dXRlX3ZtX2J1ZzsNCj4+Pj4+Pj4+Pj4+Pj4gICAgICAgICAgIGJvb2wgICAgICAgICAgICBub19z
Y2hlZHVsZXI7DQo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgICBpbnQgICAgICAgICAgICBod19wcmlv
Ow0KPj4+Pj4+Pj4+Pj4+PiArICAgIHVuc2lnbmVkIG51bV9od19zdWJtaXNzaW9uOw0KPj4+Pj4+
Pj4+Pj4+PiArICAgIGF0b21pY190ICAgICAgICAqc2NoZWRfc2NvcmU7DQo+Pj4+Pj4+Pj4+Pj4+
ICAgICAgIH07DQo+Pj4+Pj4+Pj4+Pj4+ICAgICAgICAgI2RlZmluZSBhbWRncHVfcmluZ19wYXJz
ZV9jcyhyLCBwLCBpYikgKChyKS0+ZnVuY3MtPnBhcnNlX2NzKChwKSwgKGliKSkpDQoNCg==

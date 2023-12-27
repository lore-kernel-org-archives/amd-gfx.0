Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F86C46CD3
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Dec 2023 01:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E8D010E0F2;
	Wed, 27 Dec 2023 01:27:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0327A10E0F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Dec 2023 01:27:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MD/hJJ5IgHQCzkYWJcTUulMilT/3HQVOjcmE2kCwVV0DbDhQhIZ5ZW4KGhtPnjKLCpX+bAaVB7O4rv2kSDT33lRD4stlBGMgaPRvhA95GCldWTzM7RsUoijmbn/WQxbFRRDoC1hJ/1GN7DpjBHf/m1+rrXxhuT9Bkr7NcnkpLtCAImIjEJpxhUPmU3iCj/RzSPQj3CyRD3Gd8+EuKSRkXnJXrcP7hyhT++bfrhFDVsRvRG1m0uvnlSUFysSuuIR3OJIpNodydnRx7xZdy+kedDKnJuT7EPFRpxk7J/6zRHjJVpr01yB2VSPct3j0F1yAt7ieecpzYWIUW2BBpfRVWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1PiZOvhxb8OhOC+Mz6tZ9KIrpUhET1yp6/tvCW2ZB0=;
 b=P+IJS9s7DSceJZCKyZnnHOHHhTcdEPilnIf2QEfPKpulihM1dWMZRoG0lkbGINbXCzEV9SwhW3rgKuEdWsmHBt2x1sAekXpwAEHNhq3ZETLQvsl9wnZXxygSENvKe6lirnJmFi4tRALoBSD4vk0Bg9qRbRqjx4a8T4OAoJifNh//whtTRM7f4w4fUev4uahxnP7ElDKPvvX+b+Tfso62UkMIAzijVvJ8IgasQvp3n4q5qIZ16fnFUf3rbcG2ZSpspUg+4LwxsYMm5aVEeVA1eK1q2WqxBl61Q0vSOUwziLqaXPZ30elYXIM19qYubJGXyMSA3oLH5TLxD8BIXqrg1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1PiZOvhxb8OhOC+Mz6tZ9KIrpUhET1yp6/tvCW2ZB0=;
 b=0uH63osgz2z0Dsxykhm28+qaHvVkBCN91zEjqWfbKW0TVWGoLtIbq7eyMVz3ZNjp07O+h1vKDG5UNfFPUDKgfNkj6PfIqzBi8bTkbI+Q4Y9MhnKBXASOCzNkEEOwHx0TlFCNrkG5yniMSO6Q3YB6K2no2sRSuAlmNE0l5Po0jrQ=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 01:27:12 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 01:27:12 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix possible NULL dereference in
 amdgpu_ras_query_error_status_helper()
Thread-Topic: [PATCH] drm/amdgpu: Fix possible NULL dereference in
 amdgpu_ras_query_error_status_helper()
Thread-Index: AQHaN+L2U04tabGdVkOId6FL1Xme4LC8V7kw
Date: Wed, 27 Dec 2023 01:27:12 +0000
Message-ID: <BN9PR12MB52573025F486EFB3FEABA40DFC9FA@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231226100425.3129745-1-srinivasan.shanmugam@amd.com>
 <20231226100425.3129745-2-srinivasan.shanmugam@amd.com>
In-Reply-To: <20231226100425.3129745-2-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3cf6e9c3-6658-411e-b5d9-b0975115e818;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-27T01:26:43Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB5040:EE_
x-ms-office365-filtering-correlation-id: 298ff396-b5a7-4587-3384-08dc067af3b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a1t1C9I6WkzpgeRDfDOxwZwermYOcD12UEf+eyhIuxAItC+6osGEfm4d9WK21zK7j0tFQ7zPWKdsGU7WmfBi+aL0YwzmAS4HIwuZv4EjpbuVNgQwaDiTced7JabLrujm5akcD/M9E0s3UVvckJTOsfPj8sk/etadhiT+uZcMSmk1wpGf+UBfsf8fFiauJ+f1wkch1ILtDpc8SrqQ5Hl0rAZUcWkXkSaz7eXnKakZMekbLj9aHFerd6zb9OTZRwtPdbw/wCSJAVvJT8y0x1vD52vROkyyHak35BJCCPz2+TZ4lwMZbDNW9RzuIXdgsxd2gdQiErvYle90chIcPRBY7zAzjTzpaE4oV/4XCTu88jyuY4LvgT7NIHhlyhm/KouudeR2z+OvQmp+vO99Xz7op8cpd/kPbc7ZJjZefxZ2hb8Qqc38KBwy9rf+V7rAt6p0XmpOtPzDUQ/639VlMWMgPDK2ROGDymeQ40DlVOU0JMAnInick7/TgQF0mqvxsMsx7yAM2WSBqsU5/xI7OwfNNMyXkSvQEDQSrbmczj+eOnwjcZiwo3iZ6XEl1OR/iuJfd8wEWDpMwN8O8xBeBYxyGG9GeeXRG8j0uU6Iaxgd5Lyf8xIySkMHHX69KpRyWG8S
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(41300700001)(86362001)(83380400001)(71200400001)(26005)(38100700002)(122000001)(66946007)(52536014)(8936002)(8676002)(4326008)(5660300002)(2906002)(6636002)(478600001)(53546011)(9686003)(7696005)(6506007)(110136005)(76116006)(316002)(64756008)(54906003)(66556008)(66476007)(66446008)(38070700009)(33656002)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEJCZmZweFRzdC94L0dBd3JDTmRJRERqSURGNGZod1hEUUZjMUZjbGd6VVZF?=
 =?utf-8?B?V1VvWHYwWlR4OUgrOGNzZHV0cEk2S1dhNWtaRmVVeTZNQ0ZSdXh6QlRwR1pt?=
 =?utf-8?B?N1Nya1JnQi9SOS9aWFgwQ0lxdEQwN1RuaWt4WmxJVXdQa2EvN1VUSTBqbjBh?=
 =?utf-8?B?Z1gwbE9ON3gxRURPTnR5cFFXOWZyUHhGbGs0N1pzREU2YVBVaFR4RllQNjB5?=
 =?utf-8?B?TE9ZK0EzNTdUbGJTa0ZTM0FVWlFBcUNTamVucU9oekFDbzlzVnM3RGZZQVJS?=
 =?utf-8?B?OG1sbmVBVW9LM0ZjMFcvRThGaS9SMEIyTURoVFYwZDV5b0gvUlVkSyt4aEhO?=
 =?utf-8?B?SnpnY04xZjYzcDVmMDVTT3hQN2ZXQ2NPT2g5eklzMmQ3RDB2Q1JqQWZhd1RS?=
 =?utf-8?B?N2JzUmVYM0UyeUtmdGgzR1pmYmlQY2Ywc1l5RzhIbXBzazBCaHk2eWdvdWZC?=
 =?utf-8?B?aTVzZ0FDY3dUZjQ4ZzlOZlB6YU5xQzNFQlRLMnMvemJ2eElIZ2RPZU52QVR1?=
 =?utf-8?B?bjN4OElya1ZyL2Z1NXUwVm04aEloK0ZndVdkSHlScFNHMGgyZkF2SGVOb2R6?=
 =?utf-8?B?OVpRUGpTRDUzZkcySGM5STV4RDNSZlZBajdYK3ZSWWxpUHBYM0tRWVRNK3lm?=
 =?utf-8?B?TlVUTGFuTVJEMzBES01rVFV1aHZENnRBd1dpSWRnVzRyQWtmYStrZEwxbUIv?=
 =?utf-8?B?anlWK3NiN2QrSCs5SGEwYjVHb0JKcGt1NUNQUlVvWGU0d0FsZkNYUE5KTko5?=
 =?utf-8?B?cE1lZVVsTGpCUExxdVpER3VZdXJCTVBpYkhHV1N6eXlXcVVhNmlpRzcySVZU?=
 =?utf-8?B?UVlObVVQVDJpenZsOHBSVFI4TnN2WUczTDVhQU1VTXk3NGpieVNoTW5lTVly?=
 =?utf-8?B?Ri85bTduV2tlSXFQekdXTXI0NVNFRFJOZW9CSVpWb0dGZDVzQjVYT0F5RU1J?=
 =?utf-8?B?OHN1WFJFbitURFo1R25ER1dheUk5YjMveGZvUUZBcU4zUzlWNUtPZGJjYUU5?=
 =?utf-8?B?M01acURpL0ZKa3hNRmdRRWY0NStJeE1zZEJ4UW9vclU1RjB5ckZsbUZhaTRi?=
 =?utf-8?B?NFlsd2pMOEh1SFhBVmZXZDdVMXF6Zm9ieVdyemxhcVg2U1lqUy9lV0JMVUlX?=
 =?utf-8?B?Rm9yTW9JbWgyWURTM21PRnlJYlFGeExoYUxEUjJsM1N1NDVBSGtjUnFldDFj?=
 =?utf-8?B?VGw4YjlrbWNmTzYvNWljZ05YcnZmTys2WFZ4YVJQWHYwQTNYTHRGM3FsSlcz?=
 =?utf-8?B?RXBXT0M5OWhqYjVpQ1lEVVBaRlFiNDFubG1oQ1VyL1R3a1VxczJQRUJvcW5K?=
 =?utf-8?B?U2lqbnJ3aldsbURLQnYwQ1hRRFdBUU1vbGRRcEY1eHE0ZXBDZ2IwYXpLaTJX?=
 =?utf-8?B?ZFNmQnpHRXhXQlgvaDZxaVFyekZkYVdrZFhROFZGTXpDZVVzRGZFNkxTZ3VC?=
 =?utf-8?B?bTBoa0haYVhEWFloWGlNSWlzOVIwdW4vMGp1czI3RkdBRUFHZkd4VFZSaG8z?=
 =?utf-8?B?Mi9lRVVvZlFDRXNvQVZad1NCOVdiVkdGcEpZdGF5aEc3cGY4UnJPK1VyUEVG?=
 =?utf-8?B?ZnBObUc1elFJT214VjRtQzNLd1doWEZZTVYzTTQxKzBVeU40NFNDdzh6ZEkw?=
 =?utf-8?B?S2YrREpBNlNjcXgzWDhIbnpuVUNKS1hyZGdZM1BwdmZZb25jOGgyUXBpNnFh?=
 =?utf-8?B?alJ3RVNWd3RPUHZpcVVvb3FXVmxXdXZpcmlLczhHOGRQYVRsZWJlc0ZzYUNv?=
 =?utf-8?B?eGlYS2VMYTY2emJ5OG1sZlh4Y2VZaVduTitpaU91SnFiNTdiVmtvSWtpeUMw?=
 =?utf-8?B?WXlYTUpLUFQ4TlB2WHNPTVBxZTJwMW9yelpQQ3dhL29CNGlQb253VHRwbEdi?=
 =?utf-8?B?MGJ6NVpTQWcrOGNObXNWM3UrRVZxNE1vTndOdEF3dk4xY3pVUkZkcjYvRjg4?=
 =?utf-8?B?RHR3aDlKL2dnbjZhelN4eTJ4Zk1tckN2SzVNVFR2QnVKaWIzT0dMYlE5cG80?=
 =?utf-8?B?dUt6WjU5ZVJHdXNyaSttU1pGaHFEOHRPM3hhZ1ZyMlhTVVdhLytpME1XZ3NB?=
 =?utf-8?B?RmUxZ3Irc1ViRjRROGc3aW8rU1lmTjgwN3Eya3R2bVJkREl0OWEvcGRIaXdt?=
 =?utf-8?Q?T0Ns=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 298ff396-b5a7-4587-3384-08dc067af3b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 01:27:12.3487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WjjlzRLxzNeYkQVEFt7ibKHQ4UJGCrV9z5U4v/TCpAcToOpcO9JcvDZn9aZR4FikFwVHzdsz4XZBZ3KtrM6Bag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5040
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkludmFsaWQgYmxvY2sgaWQgc2hv
dWxkIHJldHVybiBpbnZhbGlkIGVycm9yIGNvZGUuDQoNClJlZ2FyZHMsDQpIYXdraW5nDQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTSEFOTVVHQU0sIFNSSU5JVkFTQU4gPFNS
SU5JVkFTQU4uU0hBTk1VR0FNQGFtZC5jb20+DQpTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAyNiwg
MjAyMyAxODowNA0KVG86IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQpDYzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFNIQU5NVUdBTSwgU1JJTklWQVNBTiA8U1JJ
TklWQVNBTi5TSEFOTVVHQU1AYW1kLmNvbT47IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQuY29t
PjsgWmhhbmcsIEhhd2tpbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4NClN1YmplY3Q6IFtQQVRD
SF0gZHJtL2FtZGdwdTogRml4IHBvc3NpYmxlIE5VTEwgZGVyZWZlcmVuY2UgaW4gYW1kZ3B1X3Jh
c19xdWVyeV9lcnJvcl9zdGF0dXNfaGVscGVyKCkNCg0KUmV0dXJuIDAsIGlmIGJsayBpcyA+PSBB
TURHUFVfUkFTX0JMT0NLX0NPVU5UDQoNCkZpeGVzIHRoZSBiZWxvdzoNCg0KZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jOjExODMgYW1kZ3B1X3Jhc19xdWVyeV9lcnJvcl9z
dGF0dXNfaGVscGVyKCkgZXJyb3I6IHdlIHByZXZpb3VzbHkgYXNzdW1lZCAnaW5mbycgY291bGQg
YmUgbnVsbCAoc2VlIGxpbmUgMTE3NikNCg0KQ2M6IFRhbyBaaG91IDx0YW8uemhvdTFAYW1kLmNv
bT4NCkNjOiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQpDYzogQ2hyaXN0
aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPg0KQ2M6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4NClNpZ25lZC1vZmYtYnk6IFNyaW5pdmFzYW4gU2hh
bm11Z2FtIDxzcmluaXZhc2FuLnNoYW5tdWdhbUBhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIHwgMyArKysNCiAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfcmFzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMNCmlu
ZGV4IGJhZDYyMTQxZjcwOC4uMzI3NDE1YTE1YjA1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfcmFzLmMNCkBAIC0xMTc2LDYgKzExNzYsOSBAQCBzdGF0aWMgaW50IGFtZGdw
dV9yYXNfcXVlcnlfZXJyb3Jfc3RhdHVzX2hlbHBlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwNCiAgICAgICAgZW51bSBhbWRncHVfcmFzX2Jsb2NrIGJsayA9IGluZm8gPyBpbmZvLT5oZWFk
LmJsb2NrIDogQU1ER1BVX1JBU19CTE9DS19DT1VOVDsNCiAgICAgICAgc3RydWN0IGFtZGdwdV9y
YXNfYmxvY2tfb2JqZWN0ICpibG9ja19vYmogPSBOVUxMOw0KDQorICAgICAgIGlmIChibGsgPj0g
QU1ER1BVX1JBU19CTE9DS19DT1VOVCkNCisgICAgICAgICAgICAgICByZXR1cm4gMDsNCisNCiAg
ICAgICAgaWYgKGVycm9yX3F1ZXJ5X21vZGUgPT0gQU1ER1BVX1JBU19JTlZBTElEX0VSUk9SX1FV
RVJZKQ0KICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KDQotLQ0KMi4zNC4xDQoNCg==

Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B88A606A31E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 02:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iY+IBhDt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22CDB10E8F4;
	Thu, 26 Nov 2026 02:08:44 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012011.outbound.protection.outlook.com
 [40.93.195.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02E2810E8F4
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 02:08:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBoPytC0Fk2gtwU0KyNsAny3vMRyidZ55VUb/OU0lsa9IFN+f2bs+1X6kXyR+XLELpdZWCRms5myS0h9cCRwYfRMrTowVB9ozEQomlNOw3t/dx0HRZJctXZQAli89iJEsqEGItNl1czSzrfyt3MYwW7jwkV2jCFt9YwbKAwUOQsicx82yZo1KgIbsV+qDhE/jQWPOcQf5ny942oWxDqe8mcqAizQ1OcofaWdbQRSTnMT0rKutWLfsmWjpqkcu/xytrLbAti/VuPdrOe3FOnWr7ls3SkRgmXsw76szD+npCvz5nCkWE2RSvAxhbikbbo2Rasm5LoOtpm29nx/7puJaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkJTVP8v1NDwuQDb7fSr2xMnHlBUQrE62zAInDxn8vU=;
 b=S3/q5LyjFaCNkcxDEUNrELzwp/MdgmznkSq1vVuMywAH/5QEVx3Zi6OBrnz1RSStRk+8JzCMvC3ksz8aCNhRxBq+sEfuC08RFTpnAuDq1ubievqbLgIaJINM/X/qnhvW2fAVhbPt9tK14OIyhVjbLxcrRUOq0Sb0aGgKyyyRABn3lXpnrAmHh2P1Vd2hlaQ2zd8RO4p2vZZTZgcv4ZegLUdD9ik+BdsJNFChARREgrTnLu9XoQkQTvc8uWxQ+OvhvhNOt/E/uCIzidl3YcciG6fdG9hthN+IqDEzsSvXEsKwoHLbSAhvWzxMKHfxMp8eXvrLUlLk07pkHu4T989BoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkJTVP8v1NDwuQDb7fSr2xMnHlBUQrE62zAInDxn8vU=;
 b=iY+IBhDtT17xFjwsfUP63fbyYgn24mGlHG8bOFpxiHm58IoMFDBeaI3JWkZtzmboQzWKE6p/t/d3QPPHwhVB+p+y3aRYEE2n7cHkxTs+d1xxGh7nj0o++p8hq1DGm1fAfGOFqTEWZZbAacIeSfGlEe69Bq1gyC0Etnv8yzh3Qkk=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by LV2PR12MB5798.namprd12.prod.outlook.com (2603:10b6:408:17a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 02:08:33 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%3]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 02:08:33 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: unlink userptr bo_vas under the
 notifier_lock
Thread-Topic: [PATCH v2] drm/amdgpu: unlink userptr bo_vas under the
 notifier_lock
Thread-Index: AQHdfLv2Z8EZ/DfXsEetf+vYyi/c/rc+zf0AgADN71A=
Date: Thu, 26 Nov 2026 02:08:31 +0000
Message-ID: <DM4PR12MB5152D04678CF707AFA9CF3BFE3422@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20261125090415.3345401-1-Jesse.Zhang@amd.com>
 <64bdf30b-8033-4d74-a928-9d5690aafb24@amd.com>
In-Reply-To: <64bdf30b-8033-4d74-a928-9d5690aafb24@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-26T02:06:05.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|LV2PR12MB5798:EE_
x-ms-office365-filtering-correlation-id: 6642ff81-9ff6-4572-8b93-08df4b622c1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|6133799003|261009221227099003|261009223327099003|261009223027099003|261009221727099003|261009220027099003|18002099003|22082099003|56012099006|4143699003|11063799006|261102123227099003|261026121527099003|261021121427099003|261021123027099003|261022075727099003|38070700021|10067099003;
x-microsoft-antispam-message-info: vNbNzDxxdBEOMfy1GuIohSeaTIlndNUG5FAf44Lm2y5dNsFl8tQZ4MIa8G16EQmuePwoFB8ZLRAmjK/N1Rh7UtLJMz9kb6Ygd2VwUXwpCX4rEW8oAuPsWAmrXjnYVBg9v+lBZihvHWrG+3aLT1uEAQrN5rDbJLoMVi6V58u/svIgxYxTONeCbiWTDMIADUsPIczXg9Fo6H/RrCdxnnVrL/l+6NLVOtxKwnw6Dto9goIHj9wnQ68qhycZAffjH4HdHj9rQngmS+2rYFHFbeRAdBKxLaZYoH7bcEoOFWZjtO4E2f1iMJAmqRNGRvYyUQFb4MtBsxoLCJc13BtipTSmZCKAKiKRmdaD+yeawiio3PwE5TqcH4Q3kd8fZWT4FM6wN9nC995a7OlwyYY1oNucpK+UpxTPLOYfw07oBcD6JnGBl5Fx9cDumPsH0Gh4p0ADQC+ozyGTN6rojl2ZGunrCn+S3zbD3+oLh9j9hhbYjNAZaTphbZAC2eLIJYOh6FGYDdmQ1FWhSAuwfr3Hh++ln5ybkTVhjgH8SE09YB+NJtUJsi4m2b+xpBdU+1EE64/64J1szi3OnpSvPAfUsW567me7UqwXUW0iRbgeJAH79DdZM2qjEVm5Tdu+aInwKCegJUs4fELIMryNSoKgLi/L7qb8fRuC4tU59VMTj59XJmpq2NB+rUDB0/2H0z2ZTfzvn3BtlAHcfWaurh+E0B8scykLTZGdsx8kqbDwyD7cQGM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(261009221227099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009220027099003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(261102123227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022075727099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eExMMDVBT25USFRXU3VjdElteDZpQkY3eTFURmhZNnVwbDJaZUswbVk1RHhH?=
 =?utf-8?B?NVNzZjBha2dkUExUTTl2NzcvL2k3UGNlZlA0OFRQSVR1QU9jc0RKUUJ1Yjgz?=
 =?utf-8?B?Q3k4RXdHeEV4SUY0cnFrRldNbFJQWmpUem1RWkFrNDJNbllUSG9Obm1jUHJM?=
 =?utf-8?B?M05LamJOYzZRZld1Z25Mam9IakVRc2s2SU10SlEwZDV6YXhMc1BXQzNXd2Nw?=
 =?utf-8?B?TVh3aXZvaEFGSmY5ZFlsZVZRWGFtNTRmTjZGcXUrN3Jreis4UGNqMmNFSmg1?=
 =?utf-8?B?bnYvNlkyNzdqSzZRMnZDU3B1bUo2TEdaUk1uRVE1N1ZjU3VtSlJYeG1KN2JR?=
 =?utf-8?B?VVJXb1dnejc0ZGhwb1lXbmZqYmxtSFJBY2FncTFUQXhOcUtpSWlLS05LNkFV?=
 =?utf-8?B?OWRMRzh0a2kwUUhuNllnMTFpWjNpZVU4YWxsa2VwRkRMcjVRbG5WaFBoZGFN?=
 =?utf-8?B?N3ZlNkVHNURxNk1EMkZqZnNtQzRWY0k2R3ZVaWVXVTcrUHVzUW00YVkxQU9K?=
 =?utf-8?B?bmREZFdXUEJueEowRktyYVVSc2ZtRWNZbHpKblNaQm1kZnB0eXhYblpDN1NT?=
 =?utf-8?B?ODRXR1ZBVFlpTHFZRWVoZUljM3lDcjdETUU1NlFRYkhwZlQxbXQ0TVpCOCtV?=
 =?utf-8?B?Rk9UUElYbGJnZUNyeld4R2ZBajVrTHVZUDFDZE5rUWxkYzlGbkp6VHVpWmE3?=
 =?utf-8?B?QWZTNlowczJqMklPSDNhajlVN3d5L1E0TVAySWlHQzZZelh0T2I4R2hlT1kw?=
 =?utf-8?B?L1h6Q2ZYcTB3NHR0YWtleFJaRUVGUDBoa1ZhTWpjTkhRM1FoNXNPbnJwWVZ3?=
 =?utf-8?B?MGtod0Viczl6SjV6OUtITHA2UGQyS2tvL3grNWNMa1VGU3JqOHdxcmtYK1FF?=
 =?utf-8?B?c3VaSXBFdmJlQm04bWZyVGtXQjZodHVhV2QxeTd3QkJvdU5NT0VFZm1FMTEr?=
 =?utf-8?B?S2Q0ZnRpaExpZy91Wk9wbG1EVTR2V0VGaUxST0MvaWpYZE1lQjJURG1xd3Yw?=
 =?utf-8?B?aWF5YzJXaGM4MDlkdGtpM0VWaGE5d3dGcW5xek5UQXMzWXhmeE1BYzl6RDJl?=
 =?utf-8?B?WGJhbGdVTWxRR2E4emw3akdTM0VCM1pUOVRXVTZxQkNaWElyczdTM3dMYTQw?=
 =?utf-8?B?ZHhacEdQTVdoa1JwcHhMaXl5QUw0eEM0VjZLa0J5Y1Q4MkJkbUtTQkdlYkhS?=
 =?utf-8?B?L1cvenpGa09BOTY1UUxuaTNYZG9Cb2EzZGFWbWNNMzJjM0UrZVN5VDZIU3kw?=
 =?utf-8?B?VFlwTnIwRGtETHJzNHV4YXhNNnQ2VFBhdlhzZHI3Q1h6eG1tSHZxaGJYb1NV?=
 =?utf-8?B?WmlMMjA0VlB6N2pNdzFZNlAyY0dDMnl5SEd4Qk1UbkJ6a3pRemRWc0E4Z0FI?=
 =?utf-8?B?L25UdmpMOGt5U2hUbWlKR01LaktHS0lXakhDNEhvRWgwMWdqNjNtOG03ZFl0?=
 =?utf-8?B?THc5QXJtbGxLbWVEdmEweVFpNnJEYnVzRWhzaWVMbCt3RDU4UDFGaXZvUW1B?=
 =?utf-8?B?cDl5R2EvaWJrWHVhYXNCTDJLbVFiR1RPeFZVL3ZqZ1hQNUoyVnlvY2ovRExh?=
 =?utf-8?B?aC8xN0hxZDZsZFFwNUxZcXN4aTBHYmNuK2dVSVpOemxjMEZEenNKYklWN1FQ?=
 =?utf-8?B?c0Q1Q0FhRGsrYkRsT1U1V1FWMnBQVUJtQVIrL01hRVFDNVVxTjZ5bFZ4N1RX?=
 =?utf-8?B?RGNmMi8xZWliUTFzTTdCYUhuaFVjRUNtSUlpYVkzcUdGSTM2UXU3UU1PS1Fl?=
 =?utf-8?B?c2ExZ083SXczZ0hQdm1ZNlFXNER5dGUzZDBLS01DcmFCTTE2UEVrNlU4VUlO?=
 =?utf-8?B?UTR5Nk9wcS9CdWtSUC9sUDZQVFBRMWprZjdXOGNZVmROTE1UY3lRZHgrZlBV?=
 =?utf-8?B?V1M2M0JSaTZscHIrNFBlZkdqQmdCdENhTEhXaElJZ25BTmJ0N014S1dhdksz?=
 =?utf-8?B?UEwxSEdvUDh2WVZpK2VpNkJVSEdFM05yL1BCQW4za0ExOEtBYXZzREt4N1Y0?=
 =?utf-8?B?ZUZGaTNidm5LWjlTVmMvWmc2dlc0bDk3eTZhdXJaZUhsdHR4OHlsWWw4U1dn?=
 =?utf-8?B?QWRxRkhwTitadkJyTlNuYlZBSlhQOWZueExtVm9UM3hQZGZLdHkrQVRBVlRp?=
 =?utf-8?B?SnQzcW1UT1NJT3BmcHpCY2tveE9ISWpFdDNDRXkwMG1TWU1MalB2VUZqcUZ0?=
 =?utf-8?B?Z3Y4U3g5dTkycjErQm4yYmgvenVnSzFMQU40RGRaNDRHUjBnNVlmdnZlRW1I?=
 =?utf-8?B?VENqeUhFangyNDJyVk94MEpGQzZ4dFhud1gvOXNtOTZBNm1ZKzZ5aDRieDJz?=
 =?utf-8?Q?QzxjmT45NchXcSmMoJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6642ff81-9ff6-4572-8b93-08df4b622c1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 02:08:32.8369 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fWFnt6l7LBn3sUsmS+CyWx7vkIItnKwkhu6caYVpUeVK2dO9Kkt/6JKV4U74Ao5R/F8J8tgJbTgPpvMavUC/qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5798
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QU1EIEdlbmVyYWwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2Vu
aWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIE5vdmVtYmVyIDI1LCAyMDI2IDk6NDkgUE0NCj4gVG86IFpoYW5nLCBKZXNzZShKaWUpIDxK
ZXNzZS5aaGFuZ0BhbWQuY29tPjsgYW1kLQ0KPiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+
IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIGRybS9hbWRncHU6IHVubGluayB1c2VycHRyIGJvX3ZhcyB1
bmRlciB0aGUNCj4gbm90aWZpZXJfbG9jaw0KPg0KPiBPbiAxMS8yNS8yNiAxMDowNCwgSmVzc2Ug
Wmhhbmcgd3JvdGU6DQo+ID4gVGhlIHVzZXJwdHIgTU1VIG5vdGlmaWVyIHdhbGtzIGJvLT52bV9i
byB1bmRlciBub3RpZmllcl9sb2NrLCBidXQNCj4gPiBhbWRncHVfdm1fYm9fZGVsKCkgcmVtb3Zl
cyBhbmQgZnJlZXMgZW50cmllcyB3aXRoIG9ubHkgdGhlIEJPIGFuZCBWTQ0KPiA+IHJlc2VydmF0
aW9ucyBoZWxkLiBDb25jdXJyZW50IGludmFsaWRhdGlvbiBjYW4gYWNjZXNzIGEgZnJlZWQgYm9f
dmEuDQo+ID4NCj4gPiBPbiBOYXZpNDgsIHJhY2luZyB1c2VycHRyIEJPIGNsb3NlIHdpdGggTUFE
Vl9ET05UTkVFRCB0cmlnZ2VyczoNCj4gPg0KPiA+ICAgQlVHOiBLQVNBTjogc2xhYi11c2UtYWZ0
ZXItZnJlZSBpbiBhbWRncHVfdm1fYm9fbmVlZHNfdXBkYXRlDQo+ID4gICAgYW1kZ3B1X3ZtX2Jv
X2ludmFsaWRhdGUNCj4gPiAgICBhbWRncHVfaG1tX2ludmFsaWRhdGVfZ2Z4DQo+ID4gICAgX19t
bXVfbm90aWZpZXJfaW52YWxpZGF0ZV9yYW5nZV9zdGFydA0KPiA+ICAgIHphcF92bWFfcmFuZ2Vf
YmF0Y2hlZA0KPiA+ICAgIG1hZHZpc2Vfdm1hX2JlaGF2aW9yDQo+ID4NCj4gPiAgIEZyZWVkIGJ5
Og0KPiA+ICAgIGtmcmVlDQo+ID4gICAgYW1kZ3B1X3ZtX2JvX2RlbA0KPiA+ICAgIGFtZGdwdV9n
ZW1fb2JqZWN0X2Nsb3NlDQo+ID4gICAgZHJtX2dlbV9jbG9zZV9pb2N0bA0KPiA+DQo+ID4gVGFr
ZSBub3RpZmllcl9sb2NrIHdoZW4gdW5saW5raW5nIHVzZXJwdHIgYm9fdmFzIHRvIHNlcmlhbGl6
ZSB3aXRoIHRoZQ0KPiA+IG5vdGlmaWVyLiBUZXN0IGZvciB0aGUgdGFzayBvZiB0aGUgdXNlcnB0
ciByYXRoZXIgdGhhbiBpdHMgYWRkcmVzcywNCj4gPiB0aGUgR0VNIGlvY3RsIGFjY2VwdHMgYSB1
c2VycHRyIGF0IGFkZHJlc3MgMCBhbmQgcmVnaXN0ZXJzIHRoZQ0KPiA+IG5vdGlmaWVyIGZvciBp
dCBhcyB3ZWxsLg0KPiA+DQo+ID4gdjI6IGNoZWNrIGFtZGdwdV90dG1fdHRfZ2V0X3VzZXJtbSgp
IGluc3RlYWQgb2YNCj4gPiAgICAgYW1kZ3B1X3R0bV90dF9pc191c2VycHRyKCksIHdoaWNoIGlz
IGZhbHNlIGZvciBhIHVzZXJwdHIgYXQNCj4gPiAgICAgYWRkcmVzcyAwIChTYXNoaWtvKQ0KPg0K
PiBUaGF0IGlzIG5vbnNlbnNlIGFuZCB2ZXJ5IGRhbmdlcm91cy4gUGxlYXNlIHVzZSBhbWRncHVf
dHRtX3R0X2lzX3VzZXJwdHIoKQ0KPiBpbnN0ZWFkLg0KVGhhbmtzIENocmlzdGlhbiwgSSdsbCBz
d2l0Y2ggYmFjayB0byBhbWRncHVfdHRtX3R0X2lzX3VzZXJwdHIoKS4NCg0KSSdsbCBoYW5kbGUg
dGhlIGFkZHJlc3MtemVybyBjYXNlIHNlcGFyYXRlbHkuIEdFTV9VU0VSUFRSIGFjY2VwdHMNCmFk
ZHJlc3MgMCBhbmQgcmVnaXN0ZXJzIGEgbm90aWZpZXIsIHdoaWxlIHRoZSBUVE0gYmFja2VuZCB1
c2VzIHplcm8NCnRvIG1lYW4gbm8gdXNlcnB0ci4gV2l0aCB2MSBhcHBsaWVkLCBJIHJlcHJvZHVj
ZWQgdGhlIHNhbWUgS0FTQU4NCnVzZS1hZnRlci1mcmVlLg0KDQpSZWplY3RpbmcgYWRkcmVzcyAw
IGluIGFtZGdwdV9nZW1fdXNlcnB0cl9pb2N0bCgpIHJlc29sdmVzIHRoYXQgY2FzZS4NCkknbGwg
c2VuZCBpdCBhcyBhIHNlcGFyYXRlIHBhdGNoLg0KDQpSZWdhcmRzLA0KSmVzc2UNCj4NCj4gQXBh
cnQgZnJvbSB0aGF0IGdvb2QgY2F0Y2guDQo+DQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCj4N
Cj4gPg0KPiA+IEZpeGVzOiAxYzgyNDQ5N2Q4YWMgKCJkcm0vYW1kZ3B1OiBmaXggY2FsbGluZyBW
TSBpbnZhbGlkYXRpb24gaW4NCj4gPiBhbWRncHVfaG1tX2ludmFsaWRhdGVfZ2Z4IikNCj4gPiBT
aWduZWQtb2ZmLWJ5OiBKZXNzZSBaaGFuZyA8SmVzc2UuWmhhbmdAYW1kLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAxMCArKysrKysr
KysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+ID4gaW5kZXggZWE4NjcyNDUx
ZDk4Li41ZjllZDljYjE4YjUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdm0uYw0KPiA+IEBAIC0yMjc5LDEwICsyMjc5LDE4IEBAIHZvaWQgYW1kZ3B1X3ZtX2Jv
X2RlbChzdHJ1Y3QNCj4gYW1kZ3B1X2RldmljZSAqYWRldiwNCj4gPiAgICAgZG1hX3Jlc3ZfYXNz
ZXJ0X2hlbGQodm0tPnJvb3QuYm8tPnRiby5iYXNlLnJlc3YpOw0KPiA+DQo+ID4gICAgIGlmIChi
bykgew0KPiA+ICsgICAgICAgICAgIC8qDQo+ID4gKyAgICAgICAgICAgICogVGhlIE1NVSBub3Rp
ZmllciBvZiBhIHVzZXJwdHIgd2Fsa3MgYm8tPnZtX2JvIHVuZGVyIHRoZQ0KPiA+ICsgICAgICAg
ICAgICAqIG5vdGlmaWVyX2xvY2ssIGl0IGNhbid0IHRha2UgdGhlIEJPIHJlc2VydmF0aW9uLg0K
PiA+ICsgICAgICAgICAgICAqLw0KPiA+ICsgICAgICAgICAgIGJvb2wgdXNlcnB0ciA9IGFtZGdw
dV90dG1fdHRfZ2V0X3VzZXJtbShiby0+dGJvLnR0bSk7DQo+ID4gKw0KPiA+ICAgICAgICAgICAg
IGRtYV9yZXN2X2Fzc2VydF9oZWxkKGJvLT50Ym8uYmFzZS5yZXN2KTsNCj4gPiAgICAgICAgICAg
ICBpZiAoYW1kZ3B1X3ZtX2lzX2JvX2Fsd2F5c192YWxpZCh2bSwgYm8pKQ0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgdHRtX2JvX3NldF9idWxrX21vdmUoJmJvLT50Ym8sIE5VTEwpOw0KPiA+DQo+
ID4gKyAgICAgICAgICAgaWYgKHVzZXJwdHIpDQo+ID4gKyAgICAgICAgICAgICAgICAgICBtdXRl
eF9sb2NrKCZhZGV2LT5ub3RpZmllcl9sb2NrKTsNCj4gPiAgICAgICAgICAgICBmb3IgKGJhc2Ug
PSAmYm9fdmEtPmJhc2UuYm8tPnZtX2JvOyAqYmFzZTsNCj4gPiAgICAgICAgICAgICAgICAgIGJh
c2UgPSAmKCpiYXNlKS0+bmV4dCkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgaWYgKCpiYXNl
ICE9ICZib192YS0+YmFzZSkNCj4gPiBAQCAtMjI5Miw2ICsyMzAwLDggQEAgdm9pZCBhbWRncHVf
dm1fYm9fZGVsKHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+ICphZGV2LA0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgKmJhc2UgPSBib192YS0+YmFzZS5uZXh0Ow0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgYnJlYWs7DQo+ID4gICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAgICAgIGlmICh1c2VycHRy
KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZhZGV2LT5ub3RpZmllcl9s
b2NrKTsNCj4gPiAgICAgfQ0KPiA+DQo+ID4gICAgIHNwaW5fbG9jaygmdm0tPmluZGl2aWR1YWxf
bG9jayk7DQoNCg==

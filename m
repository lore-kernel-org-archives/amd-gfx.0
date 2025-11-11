Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB07CCFA1E
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Nov 2025 05:35:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51AAE10E0C4;
	Tue, 11 Nov 2025 05:35:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WR2U5TWm";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013037.outbound.protection.outlook.com
 [40.93.196.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE50C10E0C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Nov 2025 05:35:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyJxFEp4U1QPeXdx3ioijAGOVIbEJ6kpKqhhfHd4H7hRlOQ0fziwKJZdb2hNsm10+0Nth30UwIdlVHKYEqwSA7d7Em9hXlY7MI8vF6fF5yTUolSE74oKycIxNwUk5dh015gbiFiPLJL6s13VmB7Kad4GBdr1zgXDUyKaUCuvLBJVKAvvIzHC6T1Y2nUC25vEnuT2g1jBZ6xSrmFBxzy++CjJx/V06UOZOMu24Ea1yl5SZqzbSDMG79FrR/HBzAP8wVFhl8UZ1O7J5LyD9B7YtX33GZ64M01Od1NbAySheuPE4MXq+LkiyBU7igFyggxVCVtNY2QZEg4KslVXmd8dpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmnYRFbYqonTQQN2naYZqqKyMIB6iQ5MlFowh80n0ts=;
 b=FgXcNaAi0gCh51Ax/1P7/BfLEY7Up/9Xf4oOU5EYk+AF0gpeKPrsTIvdmhUpaXhejrShUGWcmu7bHbaNIr/aOJUA8t755CZp5Z/c+bwNaGGBYOksBsNnXaPWuPo1f8HEG/dzDG+7VGJOKtj0UwGR8OeRCf4qKbLNPkxK30xDs5z/J7lXoaQ6UPrQ+Z/9WiIkZCqgIyO3fp9kxtjqwaONfgHZgbDGmu3Aj5Pan3bUmYNiiRCNRtS19NA6uh6B0ursVqyimf7yMIHEMe9n2Puci9tY9fYQd6c6o2brO7iO0vKynUzq/Y9s7tf3gi9FTkyUESMjdOR1E8xCLqSao4kgZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmnYRFbYqonTQQN2naYZqqKyMIB6iQ5MlFowh80n0ts=;
 b=WR2U5TWmM/8Oq4a8rKZ/u6VrZEjnofgxkf1xNmBik7RrzjW6/U+5TBZukAHVtgWm8i1icVAvmBamcPNzboGmzpwLE+w+kYIGKq+QZ/a9Sr211QrAcfn75p7QFAFORMDH2JKeSxaQ1b62dyXtFEx4l+WO5/wNnyADbxezgge1fCc=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 05:35:06 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::be26:4c33:76bc:e1b%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 05:35:06 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Gadre, Mangesh" <Mangesh.Gadre@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
CC: "Gadre, Mangesh" <Mangesh.Gadre@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: improve VRAM usage reporting safety in KFD
 interface
Thread-Topic: [PATCH] drm/amdgpu: improve VRAM usage reporting safety in KFD
 interface
Thread-Index: AQHcUslBJcicI7TnTEq4bE5EXP1Qk7Ts9EFg
Date: Tue, 11 Nov 2025 05:35:05 +0000
Message-ID: <DS7PR12MB60718756393DDAAEAFE544BF8ECFA@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20251111050810.2694854-1-Mangesh.Gadre@amd.com>
In-Reply-To: <20251111050810.2694854-1-Mangesh.Gadre@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-11T05:34:56.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|BL3PR12MB6380:EE_
x-ms-office365-filtering-correlation-id: 9a24e8a4-32a7-4e96-05cc-08de20e41205
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?eHJuTGpmdXcwdzJOWEtDekpKazVreG5LTEl5SmVwZFBieS83VVp0emNiVXlO?=
 =?utf-8?B?dTZ4U1Jha1FmSFVaWitTZDhHNGE3SXo4QVRuSUIrLzljS1piTkVxOGNreE94?=
 =?utf-8?B?Y3ZFQ1ZPc2JQRmRPTUUyZUFKUTczb3lGZGNtMjJmVVhiNVJ2RGhrcmhvZ1c4?=
 =?utf-8?B?VHQxb1AwenVENXl0RG41U2l6cEhMZDMzaGxGVmtKVnhsSFJ1Ly8zQUpldkR5?=
 =?utf-8?B?NjFIWndDc2FkOUJuWE5DUU9iNit3RXhwbjQyKzUyQUZodFhYZ0RIVFZQWk8y?=
 =?utf-8?B?T2pRMFZaSk5rRW9QdHlNK0k3K3h4aGNLT0wxczROWnBBMUpnL05PU21EUzF0?=
 =?utf-8?B?cUpQRFZEVlhERm95OHBuYWlwM2lmOXVZaFYxSkVJUlhzMlpzUlpvM1U3RXBu?=
 =?utf-8?B?VlNaM2dZZXNRN0h2eUFNR3hZN1c0VFBsbGhLVWRZOE5VekxJWHptU3FTeXAr?=
 =?utf-8?B?ZWxndlg0YWp1RlVROTAwcU8wZ0VQUm1OS1FINTlGUEk5bkhEblBWSmM3Mzg4?=
 =?utf-8?B?cTc2cjd2cTJ1NmJiMTFxOHdaRC9FVkJ5QXgwQWtKS1dqVXAyZGVKdks4Wkhw?=
 =?utf-8?B?S0VUMlIzSDh0Yk9pTDJVZlZCUjhJYVRpSjRuNkVVakFBY0RlV3ZYb243NXhi?=
 =?utf-8?B?Ty9Ia3IyWG1vVmNZejhkNjZkN2tBYVlpZ2ROR29kK1NrcjVPaENtMnI1U0Jw?=
 =?utf-8?B?NHRQRmsranFIRHg3ZVpsd25CNFNJdWE5OE9yellKSEdmbCt0QzdlZmdrdTNT?=
 =?utf-8?B?OTErQ2tWNnZyOS9PTHE2WDZseDYwT256eXVXMzd1TnRuQnlnYjhZV2xxcFpF?=
 =?utf-8?B?cUFQaWtWdjBCSnhjdC9XVm5CNWdVSGJoSDJRaVdXQmhtL1BFWVhQMlR6TEda?=
 =?utf-8?B?dzFFNlU5bWNBVmdHNk9GWHplYmxsMzRMeFRMNzNFeXZZRDRKL0FhWXYvYkZT?=
 =?utf-8?B?OG5leTZVa29aaWozTTF6L0ZEUmxrV2NIZzJVNTFSTGRZb0RNQ29yT0s2STBD?=
 =?utf-8?B?S05uLzRTc3dOREdTTnRyREFFb3lwOVhHWDR4U1AzWldCcjFKQ0xORm9KWTdm?=
 =?utf-8?B?RWFlMnozYVQrdGl4OU1PTkxha25HN3laTlR1eVZqeTRmY2pJQk5ZL2ZxeFdX?=
 =?utf-8?B?V0FDTyt4N2dTU21kcHZMcVVneGVoalZDUEd0NU1NWW9reDlJQjRwTTN0cE1S?=
 =?utf-8?B?b0YxbkREMUhKMmk4eDM5Q1phL1JvdVBKQmloc3pULzR4U0k4VVJJMUtwZ0Nw?=
 =?utf-8?B?dytxbE5sSjRqZTZ1UXlnTElrMXVMYzRGcGJLNE94TDNabjFPdWI2QXdIUjhl?=
 =?utf-8?B?cnZURVpoZmczS05CMXZuL3pvNzRha3pYRnQwTVkxM3doT3JpZlU1bkpaQlpl?=
 =?utf-8?B?U0pIUDFVOXQ5R1FGWlVRYlhRQWtOTXV2bFk4amZTS253L2VlMkEwaW0wUWdp?=
 =?utf-8?B?OUg5QTFsa0J4d0x2UUtxdkErNTh6Y1pOM0IrYkdaS0ZXQmZ5aUdkaVN1dDZI?=
 =?utf-8?B?RU1EYTRla1k5Y0dOR2xMZUlJWXBPQk85L3pGOUZLdFRoOGNlMUdkR0dJaUVS?=
 =?utf-8?B?QzBydTRXbkRDTkxUU09RKyttSVo4dDN6YlNHZlpURFdlcHMvQkdGVFkxVjJR?=
 =?utf-8?B?N3BuWS9NRU5nNW1odExZT3M3bUw1b0hpWU1SNjBJUk1kaUU3ZENoK2NHdG1C?=
 =?utf-8?B?VCtqOUpHWjBLbWMrejRZZkk2STEyeHA5M3JtYjZ5bHJGSzNjOTVYNzhzRnNN?=
 =?utf-8?B?WHNhWmVxYXVBT1lOeVBobFFFdlozQTQ0TUdJKzY4SHJvd0pJRm9HMVZEa0ph?=
 =?utf-8?B?UU13ZUxTUE9VaW5pYWwzWlhNS1ZPR1k0MDFNMzJSQ1pBTWxEeGgxeDcyT1g0?=
 =?utf-8?B?M1RGbU9LcGErZ0dtbTl6alNKWC9TRjFSZVUzeTZyUElCOHYzVW05NGVuL2p3?=
 =?utf-8?B?YmdQZWNCRlB5a2UvTHNyS2hJYWpWN2hwR1Nwa1g4OUVNNUVZZVZqZmRqRlNs?=
 =?utf-8?B?ek1sMjg5RUppcEl6b3dmT1pTUmQzTnZYQ0pTUEhkWHo1RjNhR0RxbDduWHJJ?=
 =?utf-8?Q?Wytwtm?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEFUa1dhYk9nZEZMMWxRZDl4bENRQkcvc0NzQldLRFJIN3BxLzRrU3NRSFpr?=
 =?utf-8?B?VWdGdmdxWmkrOUd2cHc1NzI4VngxZklsejdBbWJ5em1pZ0tNazRrZXpRRitO?=
 =?utf-8?B?THBMVWgyWURFVUxEZWxmUW5RVG1xZkdpWFRFeU5PcDlkbm5TYjc3VXgrZDlp?=
 =?utf-8?B?WnMxWHdZaEU3OEVhS3FzbVVsQkdHZk1CUnpUNEd1OWV5MW9LWjBUaHRQZWdQ?=
 =?utf-8?B?VFZVNTIwalUwdzczRnZsUXNPSUl2M3RYVXBaOEFUNVkvSVFtd0xaTkpjcWdv?=
 =?utf-8?B?WGRtNm5HRXZ6cE9rNksxNS9ySHdwNHBJYWZid1VCYTJuSUI1UW4xcGhvUUVH?=
 =?utf-8?B?dVFzazQyN3NSL2wvN09PTzlobXk1WlhFdVo4UUhncTc1TnZVWGtyQTFmS1Zj?=
 =?utf-8?B?dUk4UHROdkZ2bFRTbjJTSGc5UVNaNFhXLysybjJMYzZ2RXFGdHlkZlpNYzFr?=
 =?utf-8?B?VmNqbGJ6TVNzLzUxdTFONy9IK3JiVEplUGdzeXhUdGY4Qng2czlBOCtFQ2cy?=
 =?utf-8?B?U0pBSTI0QkNMVlhxTFpaM3BZOE9ocUg1N2wxY1lMNTRZWTZGdHdEQ1o5R2ky?=
 =?utf-8?B?bDJ1MHZub2tCa3Fsem94SVB6NXNsTGllSjR2ZC9Hd2tFSGdQa01tNGN5RHNL?=
 =?utf-8?B?L1hWUGtCVVltazk4RUY0UXlCTTJUbnh4YXBaMWlhS3E1R3dOVG00TTEraWJY?=
 =?utf-8?B?aGh3UGVxOHF4VzU0NWhlcks5L2FBeFIrRnBONnlCMEl1S01GVTdVc2JZM01o?=
 =?utf-8?B?WVNlM3FqUEFmMXhIOEdGajdHOWtCeGpxc3pacWRSekxhQWlxSE90RENqeDlH?=
 =?utf-8?B?aUcvQU9sYmpWakRLUnFXcFVZWHlHTmVpdGFxWU84MC9JZUdSN010MGNRdzYw?=
 =?utf-8?B?bEhBbGg2eXZ0c3dKb2ZGRFZ1WVA0S3VQeWZzRGo5cTJpdmtUUlJoZE54QVhp?=
 =?utf-8?B?VEZNL2lNMVZkb0lzS2Z5YVZFd3RpWFFXb1A3Zi9VUkFXRWoxM2NGOU5BeTZp?=
 =?utf-8?B?bVpRRDJPSFBRT0IrQmdxT0pKWThQdUJFWjVWT0dWQnYxQVAvTVl2TXg0Q0RH?=
 =?utf-8?B?Z2tBY1kwWEY2cEpRdjRWZzhTQWRFSHN3RVltdmc2L21pZDlQUmZLUWVqbjcv?=
 =?utf-8?B?Q2tlOHU0Znl0NGNpQkVwYVowNCt1ejhacmxxVzhiNTZVSEprV09WK0Eyc3FD?=
 =?utf-8?B?K0kzMjVXcWhyWHY5aXMzbzJOdXZNN00xbjgvUFFSMTdqM3BVSzk2UE1Rczc1?=
 =?utf-8?B?Y1J0ZzhJZnFTSVB1ZVRjTk1vbGFKZnhoOXhNZHY5bzBZamF3emRTRE5kaVY1?=
 =?utf-8?B?M2xPUzlWNjd3OGlsUnE0N1BUWm51OW9TbGVZR21YTmxqT0U0SGZvQ2JqZWh3?=
 =?utf-8?B?b2Q0M2VQeWRQcytSOWNCT2JwVlRQZkVOWXJlMkRzaUJyb25NMlJwNkpvSnp5?=
 =?utf-8?B?a1VrdE96cGZza2ZPYkFaMFZNU3AwajlHOFRRL3ZnUlFqbnVQWC9OK1RSRTE4?=
 =?utf-8?B?c29xYXdpa0ZheFdnNS9pT2FwWTl4Z2Q2OEJRL2x2RVhYbmFrQkNyQzJKdE56?=
 =?utf-8?B?NXdhYmdSL2VFbDBJeDVzek5sdWJsNEdYcXM4bnc3S0QzVVlnZStxWnYxOHJE?=
 =?utf-8?B?cldTbG83T1I2NDh0cHY0NXlOTjFYR2JvRnhkVGl1U093dXh2UmxzTWRGS3ly?=
 =?utf-8?B?eUUxaE11Q1gvTThJYzE3OC9FQndSUThJUkJiNzdyaEErSkh6UDB0TE93WjNq?=
 =?utf-8?B?ZGVPZDV4dUpkdkxtajhIb2gyQ2c5dzRiRFBZcEhkR0FmM1BET0NYUXp6TDBV?=
 =?utf-8?B?NFFnWi9yemFuL2l1UUJOTHJtUm5USUVPY3FsRUttWmc2TlBOaEdQdVI2ZVIx?=
 =?utf-8?B?bjg3UEtCaEZveDgvNldIclc1cExYQTVTTDVmRWpJT1p2eisvbmxCYjRHWmMy?=
 =?utf-8?B?amF2SG1YS08rQU9Hb01LTnFzeHZ0cDJ2Lyt6aG5aR21rdVZJZm5PVUQ0amEv?=
 =?utf-8?B?dGU0c0ZCZXNHSG1yeEh2Y1FVUjFRRDJoaVJLWE81VENvUmJxR2Rrb2xHbnJm?=
 =?utf-8?B?SXhWRGhnOTgyQnAvNm9wUllOTWg1dmY2TGkyV25mNVc3aitqTnAzTTNSVDM2?=
 =?utf-8?Q?tAaw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a24e8a4-32a7-4e96-05cc-08de20e41205
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 05:35:05.9935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: csHymoOtmkliJuY2wzpdBU0ObBFs07koZ13Y/6eiTNOT3b2V+OwwBVyYfXrh7VCCAdBgBcY+LnQUtPtQSLfAhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6380
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KUmV2aWV3ZWQtYnk6IEFzYWQgS2FtYWwgPGFzYWQua2FtYWxAYW1kLmNvbT4NCg0KVGhhbmtz
ICYgUmVnYXJkcw0KQXNhZA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYW1k
LWdmeCA8YW1kLWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9m
IE1hbmdlc2ggR2FkcmUNClNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDExLCAyMDI1IDEwOjM4IEFN
DQpUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFpoYW5nLCBIYXdraW5nIDxIYXdr
aW5nLlpoYW5nQGFtZC5jb20+DQpDYzogR2FkcmUsIE1hbmdlc2ggPE1hbmdlc2guR2FkcmVAYW1k
LmNvbT47IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQpTdWJq
ZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IGltcHJvdmUgVlJBTSB1c2FnZSByZXBvcnRpbmcgc2Fm
ZXR5IGluIEtGRCBpbnRlcmZhY2UNCg0KQ2hlY2sgaWYgVFRNIHJlc291cmNlIG1hbmFnZXIgaXMg
aW5pdGlhbGl6ZWQgYW5kIGFjdGl2ZSBiZWZvcmUgYXR0ZW1wdGluZyB0byByZWFkIFZSQU0gdXNn
ZQ0KDQpTaWduZWQtb2ZmLWJ5OiBNYW5nZXNoIEdhZHJlIDxNYW5nZXNoLkdhZHJlQGFtZC5jb20+
DQpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
Pg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jIHwgMyAr
Ky0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMNCmluZGV4IDM5ZDcxMmUz
ZTY5Mi4uNDk1Y2JhOTc1ZjJkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZC5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfYW1ka2ZkLmMNCkBAIC01OTAsNyArNTkwLDggQEAgaW50IGFtZGdwdV9hbWRrZmRfZ2V0X2Rt
YWJ1Zl9pbmZvKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBpbnQgZG1hX2J1Zl9mZCwgIHVp
bnQ2NF90IGFtZGdwdV9hbWRrZmRfZ2V0X3ZyYW1fdXNhZ2Uoc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpICB7DQoNCi0gICAgICAgcmV0dXJuIHR0bV9yZXNvdXJjZV9tYW5hZ2VyX3VzYWdlKCZh
ZGV2LT5tbWFuLnZyYW1fbWdyLm1hbmFnZXIpOw0KKyAgICAgICByZXR1cm4gdHRtX3Jlc291cmNl
X21hbmFnZXJfdXNlZCgmYWRldi0+bW1hbi52cmFtX21nci5tYW5hZ2VyKSA/DQorICAgICAgICAg
ICAgICAgICAgICAgICB0dG1fcmVzb3VyY2VfbWFuYWdlcl91c2FnZSgmYWRldi0+bW1hbi52cmFt
X21nci5tYW5hZ2VyKSA6IDA7DQogfQ0KDQogaW50IGFtZGdwdV9hbWRrZmRfZ2V0X3BjaWVfYmFu
ZHdpZHRoX21ieXRlcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgYm9vbCBpc19taW4pDQot
LQ0KMi4zNC4xDQoNCg==

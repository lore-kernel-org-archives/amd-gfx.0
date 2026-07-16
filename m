Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1A7C4450E
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 02:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06B8E10E29D;
	Thu, 16 Jul 2026 02:35:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N+fGdvbr";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013041.outbound.protection.outlook.com
 [40.93.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B08F510E28B
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 02:35:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVlZKER6D1z/ZGpHCNHX6N4HgHTOdBTlMdohkVI1MpS794rNeiyLDwj8Nes4g5KhzeVXMMDBAUMqWqNpzqlPhLZsXFMs+6aCgDJm8NKo2a2Yiq+ZvUP1IH6VNIyrZI6nupyOnIfp86BwUnvNbBVbwdmJVckz/xZHF3+N7LtM8ESYEEVhPHo7iWDrUnmsgvxrq4posukl7deYd1J1Mwxvr3jCwvfqdU5TX5B07Tu3whQHNed+VctJeiTu2G9GlUA8VP+f8cZTW1cTpJdYPvzCrv99x9G06GTuQpiBL4yAAFGxO7DcuOJGUUQxgSv4CZL7rJ2+9HkzrZ81ajTsvvqLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTexClHMdDex52Qi5zbIY2VnXoP9R96UvWS3iE+wYCk=;
 b=s9Z+0m/xrugn88U0XZJVgUn9TUZsurB/xLBOfVxdNuw2IcfllkgaDhl1RUqs5xl54lMtYaBKMj/RZu1K3fvLFgbjZLHqle/cPKFC6gX68cMCpLzaWNX5s/bm+URqIXEKcihhsabMvVyhgqm1zJU8JFDAJfaLrJyAzKIgslznnVpM1q3KKznwIGmTdny3mqRfQGK8yFFnrP/UqvAHfIkxVmtxObCLVU+62WprMzbDrJqKhHgvxpYSt9n8zuSqr407AxZdjnciF+c/l6KY8By4XeRWasQSuf6GwFWgx32jxvDCzT88AGs/gg5xNu662phQ2kMloctuFVuHNbX/p8N/gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTexClHMdDex52Qi5zbIY2VnXoP9R96UvWS3iE+wYCk=;
 b=N+fGdvbrZlaaP57ESR27k2mk+j7245jh4VibAwFzM4nyXVkL0uBmTT1VBI/YG2siVIOv3jbNbwAfO3MP3KGxI/IfV3EQ9IEBoW6rl+/UeLyb9yqanjF4b3ep3cJ8ZcIoL1BfpCUsZAp9pvPul8GMYNLxfqvRznPj0qAznEvtZg8=
Received: from DS5PPF18A985A10.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::645) by PH0PR12MB8029.namprd12.prod.outlook.com
 (2603:10b6:510:26c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 02:35:30 +0000
Received: from DS5PPF18A985A10.namprd12.prod.outlook.com
 ([fe80::b4ee:f931:50c1:323d]) by DS5PPF18A985A10.namprd12.prod.outlook.com
 ([fe80::b4ee:f931:50c1:323d%7]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 02:35:29 +0000
From: "Zhou, Bob" <Bob.Zhou@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: skip clearing empty freed VM list on GEM close
Thread-Topic: [PATCH] drm/amdgpu: skip clearing empty freed VM list on GEM
 close
Thread-Index: AQHdFC3pqrQ+IQ0qREuOtbQwAwqdE7ZutoSAgAC2/YA=
Date: Thu, 16 Jul 2026 02:35:29 +0000
Message-ID: <DS5PPF18A985A10AD818A2A875C1691938294C72@DS5PPF18A985A10.namprd12.prod.outlook.com>
References: <20260715074523.988105-1-bobzhou2@amd.com>
 <95a4c91c-5d2e-48cb-82b3-203050d4c8ec@amd.com>
In-Reply-To: <95a4c91c-5d2e-48cb-82b3-203050d4c8ec@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-16T02:29:31.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF18A985A10:EE_|PH0PR12MB8029:EE_
x-ms-office365-filtering-correlation-id: cfdd5e5e-92cd-4276-ac76-08dee2e2e6e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|38070700021|56012099006|5023799004|11063799006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: rR3AnbJRGlq0ugvL2lYSh0O61acTjgj4BOHHAMxuv/OIbSsco7a8SLgF0TsmNVfBZAFTJ8YsFyFV2rXKonOkbCY7AW/j4dd71UykD6i134Q0fKdNHtIfx2pd9XTAqr204DM/mjvObA7y+KzXOTKh5vTzI5fCR2ZyaKu8G2sZ66asirwcgmkIuZtHnS/BelRVMDrbWKVhLHo7GLnILa/wZxcj0N1p5LxU+naHa40ykpDHR8drDGT0CUcaMaxeTMMEzW4KhJOq8AUhOiuUhQanZ2fpe3b2Xc+Z0/t+i72rSsCya2Ny+HqgyVX7cULsMK/+gZ3JPoP+OAvpgylD2eogXAq3E914L7EziSvh/6vwMh2sjNLVJpsbg98o84YC6VEunNtnsgPlAkeF+SDLj6wBI3d6oxzLBFsixN9kiDgiOpw769gu1Zq8zO5kYMiWEtMby2QEkxWMl41Ur/3loQHOf+4OGVYW5D4ueiJozwHre2jtaAXp+Si+4Z0frwTYt80hVlkdzxHzxFqNZI+Y6oH2E+8PnDn3cld9aX9Kouajim/DeIQNr78Loppo3goo55ywk11CsmdejfbRue0K5Y3mWVZM7vIJCBMA2LJXY6ZV8OVzCXuvSIaJoZnE6RV+1r+LwYowj4iJ6QLF6Hlru79Oemsg+dVJAjGZa5TYQrjJthptc8Yv/4Q32HjzwupbqCbi62moWnWnn7UqH/9gJkMh9S4WI5HKVDSB10ipC/7rTp0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF18A985A10.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(38070700021)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STlIelkxMGU2TTduVGh0RGtIZ1d5a0x2eEhOTzQxNjEycURWTUdxNzZiNVA5?=
 =?utf-8?B?KzhwVWNHQ0NyanhZYk41Mmc3S3JtUTJIcVpqbVpURVp3SWpXYzlJRS8zTCtT?=
 =?utf-8?B?NW85OTl6dzM4dGUwTjc1ME9nMXJnUmxSdDFuaWlSUXI2eS9pUmtGdDVrZXhI?=
 =?utf-8?B?T1FBQ3FLZkFjWDU1QjcyYnlEQU1XQVpmSEpvY2UyY3ZMM2dRTjZZYUNxVEtU?=
 =?utf-8?B?N3IzT0FGYjNYcWsxeVQvUXRMSVFQMjN2TVRWRDA3NUVjdGN6N05vK0ExOFJD?=
 =?utf-8?B?N1ljRTNvdEptK1pTN0V4a1JkdERBZG1zUGhxUSswNFhJalM2WkNGQ0RiRk10?=
 =?utf-8?B?YjZDMG0xOGpCQ1NPUnBUYUxXWnlGZ3JydmpYbmluN0FTQVM2TEl0dzBtYzRB?=
 =?utf-8?B?NTdic0xYdGk0QldoZkhYeEdQcFJrZkU2UHpDdVBEcnNVL2gvRStBVmVnZGFh?=
 =?utf-8?B?UlpuSnJjaVJmWUIrblVJN1lxZlhXLzd2RGJya1ovUENhWHhpVE5lNVErL0JO?=
 =?utf-8?B?NFZrZjJFMkJzcWJOM3A1eUEzNVRnN3JUSkVVVFdSeEpjaU5VdC9oaFczQnZx?=
 =?utf-8?B?Rm0zMTlpMWhPOUZwcGk5OWZqS1o0bkRVZ1hXaTdvOUtVcXh0VFVuVHprZFVP?=
 =?utf-8?B?SWJhNGlIaDlKTkt6clZ3cVBrNjJaeG5lZjZLN2F0ZkR5TUVQYVo3TE5Za1B2?=
 =?utf-8?B?SmtyUzJMU0VPSDdMS0ljaEx4UExCc3J4SGxFUmxwdW1wUWk0RUhKMjBZMUxP?=
 =?utf-8?B?WjRrSCttUjhaQ3JCMm5RVDFpamRhRG51dTc0Slhsc2piam1hbU1HMGFxZEVR?=
 =?utf-8?B?NWk0aXN1SmlzZ3d3SjF2RlMxK0ZMZkdYNk83Q1J5RkhUVXNtaklkS2F1OFZm?=
 =?utf-8?B?OS85bnBaOFF0ejFFdGNZd1hYZ2VpcnFHZSs0TmJCZVRIQUh5Qnpzb2dSMFF5?=
 =?utf-8?B?c1diZzVSZEFrUGkvTW1wVDhzNld1RDVmQ1ViN21qeHVvbFRlVGpUVWh0Qnl2?=
 =?utf-8?B?NzFJM0ZuRWUwNHhBK1cxVEpNTFZzQUNhNzRRWWtFN3hrRE9MSkZnMDEvdzN3?=
 =?utf-8?B?cDRCYnlJVUhBNHBocHljakNGMGxnZnZWeklLaTBEd3B3dy8rY1BQcmpkb0pQ?=
 =?utf-8?B?LzVROEdGbG9WajB5UGIxaVl6T0hPMXBHUUJodFJQdCt3eEhHVm5WQmt4MXps?=
 =?utf-8?B?NzFIZ0NUcEVXdlBZeUZiY1U5WjBwY28rWUE2OThPd0ZvK1B6NzdQMjVPYzdW?=
 =?utf-8?B?U3ZmUXZCQTNZSStmNDY0dWVua3BWQ3ZnRW85Y05FYWRScGhBTjg4TE1xQ0l0?=
 =?utf-8?B?cllzNnRmVXdzdHJIMjJsZXY4TW8vZlFYRjFDb0R5K1dFSGh2aGtMT2E0Vmcv?=
 =?utf-8?B?V08yMVFFZDlRQ0lmV1FCV3hIaGFyS1hBZk1ER3RRNWkrWis1R0xzSVp3dE1E?=
 =?utf-8?B?MXdmdFJteXE2SG8xclhrSENkNHJHZHJEajY2OElySGdDSDkvYng5RUNad0tt?=
 =?utf-8?B?QWpGdVE4YU56SkxkSmN1T0lXUGhhbEhWM1c1clNKeHNNMThUSWlqemhTVUJU?=
 =?utf-8?B?L3dpTTFFdWdkamR5NnNhNmc1M25LN1ovYkxQQWFpYkwraEhaM1lONVRpWGs0?=
 =?utf-8?B?dXluTEdHVjgrL0xHVGNYb0wyckpLTU9iTWlBcUIyelM0U2JvRXJ5eThCek0y?=
 =?utf-8?B?M1VLblZ5eGJETTRXLzFoSXpNRHVuUnhmTndDaXk3MmJJZGhtUlVGVHNGREc0?=
 =?utf-8?B?OUcwaHMyNC9mR3ZUb2lLZTR1TWhuaHhpaEhNYUhkYnVqaTUwZm1rRW52UjRi?=
 =?utf-8?B?cXhLSDV2RWJTK3dqdzhscXRuU0crR3JBZGx1Q2RJVHRzSEV1UEJnN0RZT0dZ?=
 =?utf-8?B?NkV2ODNVMFFDa0dFR0ZUbzdjRVdVN0RlMTlOVldBQW9SRDhTd2QyQ3ZkMnFp?=
 =?utf-8?B?WTM2SkhUNXZMN1VQMFVlSzRsSStSV2RMVHRSeUNOcFpKb0I0eGx1OUlUcDlz?=
 =?utf-8?B?N3M2RW1idStERzE0NjIxdVU5eVBiOUM2dWhaTmZUdFl2UUdwZi9PVldmQWpS?=
 =?utf-8?B?a2JpSWZnS056Y3JzeVNhS3lJZ3p1Q25rYmgvaVlrYzhaVUc0aDlnSWVndEdP?=
 =?utf-8?B?M2RObVJDSndvTkhtaVh5Qm54RlU0V1Q4ZE1QcFRFM0NuZ3pSVERSUm4zeXVF?=
 =?utf-8?B?TTMzR1o3Uk9xUTI1NE5sSHJ4UnFnbDFlNGQ4REIvMTN2N0lEZ3ZPM3lXS1dZ?=
 =?utf-8?B?eE8xSU9yeUxWcWU3alMzc0M2VFNreTRyZ2YxTkRSSEIrc1hLU3A4S3MvNEhu?=
 =?utf-8?Q?YNFimoPPXgKCj9DtEj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF18A985A10.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfdd5e5e-92cd-4276-ac76-08dee2e2e6e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 02:35:29.6828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dEpiPG+stUDV5MXrxMkgny27VXE0I+/b99VCTxxIc7uIQ6ofrz4vf/Zn0uwxVdZhyCmdg7chlOL5bZBNrv/bow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8029
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

QU1EIEdlbmVyYWwNCg0KSGkgRmVsaXgsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldyBhbmQgc3Vn
Z2VzdGlvbi4NCg0KVGhhdCBtYWtlcyBzZW5zZS4gTW92aW5nIHRoZSBjaGVjayB0byB0aGUgYmVn
aW5uaW5nIG9mIGFtZGdwdV92bV9jbGVhcl9mcmVlZCgpIGlzIGEgY2xlYW5lciBhcHByb2FjaCBz
aW5jZSBpdCBrZWVwcyB0aGUgb3B0aW1pemF0aW9uIGxvY2FsIHRvIHRoZSBmdW5jdGlvbiBhbmQg
YmVuZWZpdHMgYWxsIGNhbGxlcnMgd2l0aG91dCBleHBvc2luZyBvciBkdXBsaWNhdGluZyBrbm93
bGVkZ2Ugb2Ygdm0tPmZyZWVkIGludGVybmFscy4NCg0KSSdsbCB1cGRhdGUgdGhlIHBhdGNoIGFj
Y29yZGluZ2x5IGFuZCBzZW5kIGEgdjIuDQoNClJlZ2FyZHMsDQpCb2INCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1k
LmNvbT4NClNlbnQ6IFdlZG5lc2RheSwgSnVseSAxNSwgMjAyNiAxMTozNSBQTQ0KVG86IFpob3Us
IEJvYiA8Qm9iLlpob3VAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBE
ZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQpTdWJqZWN0OiBS
ZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBza2lwIGNsZWFyaW5nIGVtcHR5IGZyZWVkIFZNIGxpc3Qg
b24gR0VNIGNsb3NlDQoNCg0KT24gMjAyNi0wNy0xNSAwMzo0NSwgQm9iIFpob3Ugd3JvdGU6DQo+
IGFtZGdwdV9nZW1fb2JqZWN0X2Nsb3NlKCkgY2FsbHMgYW1kZ3B1X3ZtX2NsZWFyX2ZyZWVkKCkg
YWZ0ZXIgZGVsZXRpbmcgYSBCTyBWQS4gSWYgdm0tPmZyZWVkIGlzIGVtcHR5LCB0aGF0IGNhbGwg
aXMgYSBuby1vcCBidXQgc3RpbGwgYWxsb2NhdGVzIHN5bmMgc3RhdGUgYW5kIHdhbGtzIHJlc2Vy
dmF0aW9uIGZlbmNlcyBiZWZvcmUgcmV0dXJuaW5nLg0KPg0KPiBDaGVjayB2bS0+ZnJlZWQgZmly
c3QgdG8gYXZvaWQgdGhlIG92ZXJoZWFkIG9uIHRoZSBHRU0gY2xvc2UgaG90IHBhdGguIFRoaXMg
ZG9lcyBub3QgY2hhbmdlIGJlaGF2aW9yIGJlY2F1c2UgdGhlIGVtcHR5LWxpc3QgcGF0aCBsZWF2
ZXMgdGhlIGZlbmNlIHVuc2V0IGFuZCByZXR1cm5zIHN1Y2Nlc3MuDQoNCkkgdGhpbmsgeW91IGNv
dWxkIGdldCB0aGUgc2FtZSBlZmZlY3QgaWYgeW91IHB1dCB0aGUgY2hlY2sgYXQgdGhlIHN0YXJ0
IG9mIGFtZGdwdV92bV9jbGVhcl9mcmVlZC4gVGhlIGZ1bmN0aW9uIHdvdWxkIGp1c3QgcmV0dXJu
IHdpdGggImZlbmNlIg0KdW5jaGFuZ2VkLCBvciBOVUxMIGluIHRoaXMgY2FzZS4gVGhlbiB0aGlz
IG9wdGltaXphdGlvbiB3b3VsZCBhbHNvIGFwcGx5IHRvIGFueSBvdGhlciBzaXR1YXRpb25zIHdo
ZXJlIGFtZ3B1X3ZtX2NsZWFyX2ZyZWVkIGdldHMgY2FsbGVkIHdpdGhvdXQgYW55dGhpbmcgdG8g
ZG8uIFRoZSBvdGhlciBhZHZhbnRhZ2UgaXMgdGhhdCB0aGUgY2FsbGVycyBvZiBhbWRncHVfdm1f
Y2xlYXJfZnJlZWQgZG9uJ3QgbmVlZCB0byBtYWtlIGFzc3VtcHRpb24gYWJvdXQgaG93IGl0IHdv
cmtzLCBvciBrbm93IGFueXRoaW5nIGFib3V0IGludGVybmFsIHN0YXRlIG9mIHN0cnVjdCBhbWRn
cHVfdm0uDQoNClJlZ2FyZHMsDQogICBGZWxpeA0KDQoNCj4NCj4gU2lnbmVkLW9mZi1ieTogQm9i
IFpob3UgPGJvYnpob3UyQGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9nZW0uYyB8IDIgKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZ2VtLmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmMNCj4g
aW5kZXggNmEwNjk5NzQ2ZmJjZC4uNzI4MTFmNjk2M2ExNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uYw0KPiBAQCAtMzQ4LDYgKzM0OCw4IEBAIHN0YXRpYyB2
b2lkIGFtZGdwdV9nZW1fb2JqZWN0X2Nsb3NlKHN0cnVjdCBkcm1fZ2VtX29iamVjdCAqb2JqLA0K
PiAgICAgICAgICBhbWRncHVfdm1fYm9fdXBkYXRlX3NoYXJlZChibyk7DQo+ICAgICAgICAgIGlm
ICghYW1kZ3B1X3ZtX3JlYWR5KHZtKSkNCj4gICAgICAgICAgICAgICAgICBnb3RvIG91dF91bmxv
Y2s7DQo+ICsgICAgICAgaWYgKGxpc3RfZW1wdHkoJnZtLT5mcmVlZCkpDQo+ICsgICAgICAgICAg
ICAgICBnb3RvIG91dF91bmxvY2s7DQo+DQo+ICAgICAgICAgIHIgPSBhbWRncHVfdm1fY2xlYXJf
ZnJlZWQoYWRldiwgdm0sICZmZW5jZSk7DQo+ICAgICAgICAgIGlmICh1bmxpa2VseShyIDwgMCkg
JiYNCj4gIWRybV9kZXZfaXNfdW5wbHVnZ2VkKGFkZXZfdG9fZHJtKGFkZXYpKSkNCj4gLS0NCj4g
Mi4zNC4xDQo+DQo=

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C591FF886F
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 06:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8EC010E9DE;
	Tue, 28 Apr 2026 06:51:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="11jK3tni";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011046.outbound.protection.outlook.com
 [40.93.194.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FC2610E9DE
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 06:51:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qj96ACoGvU/3lCUvz1qS+u7CrgykeRXpsVA95SHZznvjeLpvZcd2/JiuIigDSX/VTp6hf6F4oqLDmRkMIhzDpu28WLCuEyMkF4akCZbG0CKqjDg0SP5Mnfa4AbJtuUDsX1oe6ojPCk/0iB15NyLv7MZENEtn2Ojj3+0GkWeScJMyOyu267Hzzz0Bz0ARexCgcPzrcqk5oLU6bdVx0bHLyrnI6tisuyYeZbBDslkqpLYJch0QpuyBnG6o6nKKb1pJZNeEhn+WL7UBU4EtZgFv3OL5iC28kdJdROILt16zE4BdOoYc7TN6zAFpweDlIhVbGPvZza0pIRdp/GMTi7Pe/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QT50Y2aBe8zh7+pMkoWQKznJJwUkwiaNYM+Pb3HGHYs=;
 b=KCi/0KVizeoQjTvCY6C5knvPcWYnsVn1c+kqByRybEPhx3CUwQGVK1cRAZNJdURVvF1XQtXC6ffmLCOFyfrs3bhmKarSxkCrwUWk4E0mEXB7gsyEkADdIQ6qGryf3G7O8hELsunbtTqKmV2LCcdBrfYTmSEflgngy5V6Bpa+K09yNwBa7rPGkO3bhe5oLF4abVA/J1guqHHpMgvbEyzkFl+Iqi0Nfs1Y26IcJmZpaCrdrBmqlVsWs7B/NEPc/PVGqwqiYoxct3jEnM1PGnmY6Fz4DUq1U2RwnlI1/wIPZp3PEp1BwYFmGXGd6yGG15i5REnXPT+KbDl1MhILtGpVpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QT50Y2aBe8zh7+pMkoWQKznJJwUkwiaNYM+Pb3HGHYs=;
 b=11jK3tniE62FV2KwuQ0jNbMCiIvDijl0IsH/iegAtKK1+YcBMJOArRRTlj4nXS9qE6Jin9SamyZ3T0OQA0Flev+tA3nVFKNNjRGxWVnrzLaiGDFLxwXQ/wEuLfsTHG1HV6NJMocqdWscKcoyUdKOI9SGRmXtmi9Qvz2CTVENPP8=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SA1PR12MB7412.namprd12.prod.outlook.com (2603:10b6:806:2b2::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.16; Tue, 28 Apr 2026 06:51:55 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 06:51:55 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Zhang,
 Jesse(Jie)" <Jesse.Zhang@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/8] drm/amdgpu: remove deadlocks from
 amdgpu_userq_pre_reset
Thread-Topic: [PATCH 2/8] drm/amdgpu: remove deadlocks from
 amdgpu_userq_pre_reset
Thread-Index: AQHc1nOC4LVxQfVGcU2OCLpKdw4yqLX0Bagg
Date: Tue, 28 Apr 2026 06:51:55 +0000
Message-ID: <DS7PR12MB6005CC8E7AD16B551359D97DFB372@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260427182723.1715-1-christian.koenig@amd.com>
 <20260427182723.1715-2-christian.koenig@amd.com>
In-Reply-To: <20260427182723.1715-2-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-04-28T06:36:07.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SA1PR12MB7412:EE_
x-ms-office365-filtering-correlation-id: 105b12a4-21fe-45ba-99c5-08dea4f2a2ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: yb8axx/qe5TgoDAW+M2qOmnmKjBRt0hHEkwvbsGlhVZIBq7n1DYtuyvl7xUKt+Zs98cZ9ujFrh2Cqq9yzUOj4v/5m0pZK9IfGHDe+k1J9TBqWNcmWj6oWFzDpxiuQq2LWHWk6C7Vgnx4TEpoP1nFMUNTu/bhWzG4aKg4CNGn5dNigF3k4aIXltDtRipPkwZEMjgoIW64xzxHNn9krkQBXwhhbR4wn3OUXa1QJFTn4+7orrABhmHj/sW4ePdSMMqQpHh3mZx39lavJVxbhWpstqNUIBYqudLsixcaPBnAu04gVBj7OQN+lTWBPpeQ2Pl8zAFf1AuZPuMDzqwhI87jR7X7fKaK02UInOrQ5sRvsMe3DsMnFzqOpWQfPSBoeOY2d9tTfmgE4M5T2iJ/W0qtvrs/fd3Rj9W9lzH4K2ag4KSN2UJnuqqTygfpXHqLbtvGXiWhLA9btSUee96Jc04uLMucJQ75QC49t4rLQJWhr/z6bAFn8on6LjsMQnOqTKo5i6ZSMO3ZPW2YHoEB6MXN1iC/ORj12Prf0Ho/MKxoPDz1VLSV2/0uqf4Pm14dcIUbyDA5T8bHPX91y2L+evH3kFleq2naKnoB1JhQODlP15oj4Bu6ao+KfD5JxQrWHT8V1JnkR+aMimFIsWbLMGlT4uR+/qiPLEgfkGv3CRWz0DybX0yTI3zrvRkCx31Fsq9L7CGrFC9hG+06EW84gaJ0ivqF1lPdETlRkYTB/mnGXQMEFjkAdWrt06z44iAcfnXbsdAX0r4uk3cguUqpoHlW2YFuwwfl6lFZlB6zRg6TE2Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0ZnNHo0UFlqak5xSkJXKzNSeW03Y1paZ2h3RFJYdVhXVkl1aWFHMEtUTGZR?=
 =?utf-8?B?OVZLRjNCWGFLak1PMXQvSzlIMmxGUzdLa3lORWhzSUJtdmJXbE0zU3BjOFZ4?=
 =?utf-8?B?VGZNYnE5aGpkVEc2dkp0WTNXbEdpRFRLYzJyTnc5RjV6eTNiY3Y0MjlKbjZv?=
 =?utf-8?B?M2ZQZkRwQjUzb1g2OHBUNE42UjZvNUdnV1VZcC8ybSt3dk9iTUJuKytRRHY3?=
 =?utf-8?B?VHVwMkxXWVlLOGNiV0ZraUE0eG1oU012NTZ0aGtiTWcreDY0RmNYcXdhMkxl?=
 =?utf-8?B?N3ozS0ZRU0xOTElQcmNBZUtZd2dTRWlyekcvd0g2VDFJc3NxREZneDNnS3JL?=
 =?utf-8?B?WGpTbnFabTdGcGJteWlTRm1pZWpwTFJuUTc4OHBvZkllWWZLLzNSNmt4VEJH?=
 =?utf-8?B?MjNGK2JWRUU0NGRpeHhhL0R3VGk5RG54djFKVnBlRGVDOGc1cU05RkZHdGxH?=
 =?utf-8?B?eGFqM3BFVGNmanlvMTdqampISFpJeW8vaTFyNi9hT1BSNG45c0pCNWJtTEhj?=
 =?utf-8?B?QnhnVjRyajlkaFcySmg5em4rMUxrSFZJRmt3V2hrN3AvY1dHZDJ2QTI4NjJB?=
 =?utf-8?B?TzdtMk9NNDNCTVU4aGhsbVZNQTk0SWFITzNBclJsb2dkbUpSaTlicENPYlJ0?=
 =?utf-8?B?UVpBaFE3Vy9CRnlWZGFSUGVrcVJEdzE4Nkk2THVQSzh5NGlqZCtDOVAzZHQw?=
 =?utf-8?B?VU9HUHZXMVlReStTSm9sQ2drd3NzYUkrUkZySWlxVkhTZnZTSFA3aEhIcTU3?=
 =?utf-8?B?Q2dscFFqWFZLVVkzUGl5ZXNSdDh5QzZkRytBTWZlS1NKRU9EVFNQRnE2eS9C?=
 =?utf-8?B?Z1VxbzkwYTV4NHFtSmQzeFUxN0V4UG9BMXk4NDlwYktMa1hIS3g5WEZpSzdY?=
 =?utf-8?B?Wlo3MmIyZm5raTFkWVF0Yi9GNnlQY0ptdCtydDRqeUtXRnJDc2tEdENEdW5r?=
 =?utf-8?B?a0hDc2pyRUZjL25mRmVoUG4yeFEwcklqbjlaTFBndWZ3YW5uS0FRSUpQQ0JL?=
 =?utf-8?B?cFVFcDY1THNEVHplTm1IeWZWMVZQSG1lb1ZxbTVCY01IRHpHSUpTNXlEa1pC?=
 =?utf-8?B?T3dyYVpQVk5xNkd2SjlhcFExdzRFcWt3YnV0UUVyQ1FyREtGQkVvb0FPQm5Q?=
 =?utf-8?B?UFdiS3pINkRKdUUrNXZWL0RRR3ZDRUY3WGVybzZ0Zld1c1poSWdrSHErakRt?=
 =?utf-8?B?SThmTFcxL3E1VmNoakh4aG5FWmhBcGRUVWJKWklleGhIclJaRVJMdEVDQU1B?=
 =?utf-8?B?UkU4UGZGMnVCRmlLamZxbXA1NzliK0xKZGltYUNFYXRPWVFmN1RIVUphRFRH?=
 =?utf-8?B?cnhsYWhOazd2VHFqVFpaZGlZR250NTBXWExvNTV5Y2ZUeEZnSUNUZG50Z1Bw?=
 =?utf-8?B?Nzl1QjNYSFkycmxscDdsQmNuQlNIRlY2YUg5V1RRWlpXQm5PZlVEcm9oVU1Q?=
 =?utf-8?B?a3RYU2QzQVd6U2puUkt4bGFjZ1BrZmhLejVqVnF0Yk9ySUgzVTNBejNZZFNy?=
 =?utf-8?B?VjhUbW4yZWd6MlB0Nzh2V2t3RTRMTXhRY2toUU5Bemc1OWg5MXZuam1vOEtv?=
 =?utf-8?B?Z21aZUFBL0JNSThibkViSDUzdmVXSW1uVGl3Znd3WXhHeVRLamhlMGRwRVly?=
 =?utf-8?B?OHN3MVJyck9iVEMvK3ZOenNJbkdqQ0tLWG11aTZnVnFGeXNBRFpaZVJGK3Z4?=
 =?utf-8?B?NmZ4Q21RMEZBYXNmclBGNllkOFkrVWFrejh1bHdxRUdYVEZ2MW1SeFdPaWkz?=
 =?utf-8?B?c0lDYkxWWi9GbHhFNmY5OHVHY0pLV0VqVVhxUzA3ZkM4VUdVS0ZNQTZNU1cz?=
 =?utf-8?B?STBnTUo3MWpJTytNcm1OQ3Baam1zK05XVXdWY1lUU1VxUWxPNUp3R3h6QUtZ?=
 =?utf-8?B?eHQxK1grUC9rNzA3bTBQaVRPMXorcGRvWEhYR0FDemlLV1NMUFRKOUxKVnMz?=
 =?utf-8?B?V0t4djlyMnhyWU8xaE1uN0wwWkZmZTRGQnJFMVNnS1lGbDdMcUdEd0JPWFF2?=
 =?utf-8?B?dzNFUEtZZGt5UXR3N09iU09zYTlXTzYya0pid2EwaXNpZk40UXdOOFpRMjJK?=
 =?utf-8?B?MmFnNkQ3OGdsc0pVMnNSYkh3bmFqNzFkaElYY2dVQ01telRwcWFWSm8yUndx?=
 =?utf-8?B?RUhyYWhDM290WjBteEhMSk8wdzVnN2VRa29rdVgxYXVWdTFuNnFXbkhTTWpx?=
 =?utf-8?B?bHg4ZHZGTnBCdWJzd0IrNU1UY2hlQzZqdFJOaldiMWRCdEpUOXlHSHNpNnpv?=
 =?utf-8?B?NFFuS01HamV2OGF4KytvT3Y1YzJWUmxxWXNNaFQwL0N4TDc0R3g0d3Zqdk9V?=
 =?utf-8?Q?SsG9MSo7HxG1TpF2yy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105b12a4-21fe-45ba-99c5-08dea4f2a2ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2026 06:51:55.1477 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J/cdTm5xmHzEnrMOoers0nm25qI3N8Was2QAJO3njRANa+i06d5xP1ShDhE2vfFi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7412
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

UHVibGljDQoNClJlZ2FyZHMsDQogICAgICBQcmlrZQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5A
Z21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCAyOCwgMjAyNiAyOjI3IEFNDQo+IFRv
OiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBMaWFuZywg
UHJpa2UNCj4gPFByaWtlLkxpYW5nQGFtZC5jb20+OyBLaGF0cmksIFN1bmlsIDxTdW5pbC5LaGF0
cmlAYW1kLmNvbT47IFpoYW5nLA0KPiBKZXNzZShKaWUpIDxKZXNzZS5aaGFuZ0BhbWQuY29tPg0K
PiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gU3ViamVjdDogW1BBVENIIDIv
OF0gZHJtL2FtZGdwdTogcmVtb3ZlIGRlYWRsb2NrcyBmcm9tDQo+IGFtZGdwdV91c2VycV9wcmVf
cmVzZXQNCj4NCj4gVGhlIHB1cnBvc2Ugb2YgYSBHUFUgcmVzZXQgaXMgdG8gbWFrZSBzdXJlIHRo
YXQgZmVuY2UgY2FuIGJlIHNpZ25hbGVkIGFnYWluIGFuZA0KPiB0aGUgc2lnbmFsIGFuZCByZXN1
bWUgd29ya2VycyBjYW4gbWFrZSBwcm9ncmVzcyBhZ2Fpbi4NCj4NCj4gU28gd2FpdGluZyBmb3Ig
dGhlIHJlc3VtZSB3b3JrZXIgb3IgYW55IGZlbmNlIGluIHRoZSBHUFUgcmVzZXQgcGF0aCBpcyBq
dXN0IHV0dGVybHkNCj4gbm9uc2Vuc2UuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYyB8IDI2ICsrKysrKysrKysrLS0tLS0tLS0tLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pDQo+
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEu
Yw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+IGluZGV4
IDU4Yjk0NzdjMDM0Ni4uYTM0YjFkZjUxM2QzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiBAQCAtMTUxMCwyMyArMTUxMCwyMSBAQCB2b2lkIGFt
ZGdwdV91c2VycV9wcmVfcmVzZXQoc3RydWN0IGFtZGdwdV9kZXZpY2UNCj4gKmFkZXYpICB7DQo+
ICAgICAgIGNvbnN0IHN0cnVjdCBhbWRncHVfdXNlcnFfZnVuY3MgKnVzZXJxX2Z1bmNzOw0KPiAg
ICAgICBzdHJ1Y3QgYW1kZ3B1X3VzZXJtb2RlX3F1ZXVlICpxdWV1ZTsNCj4gLSAgICAgc3RydWN0
IGFtZGdwdV91c2VycV9tZ3IgKnVxbTsNCj4gICAgICAgdW5zaWduZWQgbG9uZyBxdWV1ZV9pZDsN
Cj4NCj4gKyAgICAgLyogVE9ETzogV2UgcHJvYmFibHkgbmVlZCBhIG5ldyBsb2NrIGZvciB0aGUg
cXVldWUgc3RhdGUgKi8NCkl0IHNlZW1zIGEgbmV3IHBlci1xdWV1ZSBsb2NrIG1heSBjYW4gaGVs
cCBsb2NraW5nIHRoZSBxdWV1ZSBwcmVjaXNlbHkgdGhhbiB0aGUgcHJvY2VzcyB3aWRlIGxvY2sg
dXNlcnFfbXV0ZXgsDQpzbyBoZXJlIHByZWZlciB0byBjcmVhdGUgYSBuZXcgcGVyLXF1ZXVlIGxv
Y2sgdGhhbiByZXVzaW5nIHVzZXJxX211dGV4Pw0KDQpUbyByZXNvbHZlIHRoZSBkZWFkbG9jayBp
biB0aGUgdXNlcnEgZmVuY2Ugd2FpdCBuZXN0aW5nLCB0aGlzIHBhdGNoIGlzIFJldmlld2VkLWJ5
OiBQcmlrZSBMaWFuZyA8UHJpa2UuTGlhbmdAYW1kLmNvbT4NCg0KPiAgICAgICB4YV9mb3JfZWFj
aCgmYWRldi0+dXNlcnFfZG9vcmJlbGxfeGEsIHF1ZXVlX2lkLCBxdWV1ZSkgew0KPiAtICAgICAg
ICAgICAgIHVxbSA9IHF1ZXVlLT51c2VycV9tZ3I7DQo+IC0gICAgICAgICAgICAgY2FuY2VsX2Rl
bGF5ZWRfd29ya19zeW5jKCZ1cW0tPnJlc3VtZV93b3JrKTsNCj4gLSAgICAgICAgICAgICBpZiAo
cXVldWUtPnN0YXRlID09IEFNREdQVV9VU0VSUV9TVEFURV9NQVBQRUQpIHsNCj4gLSAgICAgICAg
ICAgICAgICAgICAgIGFtZGdwdV91c2VycV93YWl0X2Zvcl9sYXN0X2ZlbmNlKHF1ZXVlKTsNCj4g
LSAgICAgICAgICAgICAgICAgICAgIHVzZXJxX2Z1bmNzID0gYWRldi0+dXNlcnFfZnVuY3NbcXVl
dWUtPnF1ZXVlX3R5cGVdOw0KPiAtICAgICAgICAgICAgICAgICAgICAgdXNlcnFfZnVuY3MtPnVu
bWFwKHF1ZXVlKTsNCj4gLSAgICAgICAgICAgICAgICAgICAgIC8qIGp1c3QgbWFyayBhbGwgcXVl
dWVzIGFzIGh1bmcgYXQgdGhpcyBwb2ludC4NCj4gLSAgICAgICAgICAgICAgICAgICAgICAqIGlm
IHVubWFwIHN1Y2NlZWRzLCB3ZSBjb3VsZCBtYXAgYWdhaW4NCj4gLSAgICAgICAgICAgICAgICAg
ICAgICAqIGluIGFtZGdwdV91c2VycV9wb3N0X3Jlc2V0KCkgaWYgdnJhbSBpcyBub3QgbG9zdA0K
PiAtICAgICAgICAgICAgICAgICAgICAgICovDQo+IC0gICAgICAgICAgICAgICAgICAgICBxdWV1
ZS0+c3RhdGUgPSBBTURHUFVfVVNFUlFfU1RBVEVfSFVORzsNCj4gLSAgICAgICAgICAgICAgICAg
ICAgIGFtZGdwdV91c2VycV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxldGlvbihxdWV1ZSk7DQo+
IC0gICAgICAgICAgICAgfQ0KPiArICAgICAgICAgICAgIGlmIChxdWV1ZS0+c3RhdGUgIT0gQU1E
R1BVX1VTRVJRX1NUQVRFX01BUFBFRCkNCj4gKyAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVl
Ow0KPiArDQo+ICsgICAgICAgICAgICAgdXNlcnFfZnVuY3MgPSBhZGV2LT51c2VycV9mdW5jc1tx
dWV1ZS0+cXVldWVfdHlwZV07DQo+ICsgICAgICAgICAgICAgdXNlcnFfZnVuY3MtPnVubWFwKHF1
ZXVlKTsNCj4gKyAgICAgICAgICAgICAvKiBqdXN0IG1hcmsgYWxsIHF1ZXVlcyBhcyBodW5nIGF0
IHRoaXMgcG9pbnQuDQo+ICsgICAgICAgICAgICAgICogaWYgdW5tYXAgc3VjY2VlZHMsIHdlIGNv
dWxkIG1hcCBhZ2Fpbg0KPiArICAgICAgICAgICAgICAqIGluIGFtZGdwdV91c2VycV9wb3N0X3Jl
c2V0KCkgaWYgdnJhbSBpcyBub3QgbG9zdA0KPiArICAgICAgICAgICAgICAqLw0KPiArICAgICAg
ICAgICAgIHF1ZXVlLT5zdGF0ZSA9IEFNREdQVV9VU0VSUV9TVEFURV9IVU5HOw0KPiArICAgICAg
ICAgICAgIGFtZGdwdV91c2VycV9mZW5jZV9kcml2ZXJfZm9yY2VfY29tcGxldGlvbihxdWV1ZSk7
DQo+ICAgICAgIH0NCj4gIH0NCj4NCj4gLS0NCj4gMi40My4wDQoNCg==

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C57C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 06:35:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C33F113149;
	Tue, 23 Apr 2024 06:35:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CB/uOXum";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED4EA10FAE7
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 06:35:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Woukc17Ip9v/Y++Fo/qkQb5+U32i+8gdGVHFeQ6o1Qk0RiKhQBH8bmsMR0GfbH2ZovQAXr9GVHkHQ2AqOkh4C8HVSdQPXe0jiLOa5BPbk7rgekBVOySa3LIIlZtPjUgEbMjvBbSyPfVutn7pafemf9mpv+PJ0kRE4V+AjsupYPmPkCeWXgy+sBYL6p/EYswj6M4Ee2zfJ06xVfvtpN643MFzGTS1g3gJrak8UR0fJb5f7CEQ9WRRKdCf62mVMxmFUCP6HKWhsZY8yLv2y6ZzFq5dNbJTLwv6jIbqO0W2WabnJ9eWkxj/HFWCswDNoCghHEx6L9SL2IJPxKXmpPiMEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2v2uz420UNtqkuz1Ch7GO8skxAjKZCq2gGwEk2rCgcQ=;
 b=cZWBgt0/gKxHctSlMN8A42C/rpmqqHYsyjSNO1I52G8B60UZBuijPQPeOOECBmoJjK+EufZKTTqRTEm+tbLiCB/wtk7MHxjB4uwqDhIBhIdXAKgE3k0vzObDoimMDWRWzCDrSGTHe2T50GGgi8OiIwVnfTzZlBXF1uu48kTkTpB7ru9qoACP4wNdHHLha00gEhAUy0957F2J5pWfht5NIl8i91zwU6x2EqJIpqNYPSRkpnMQLo0DNWqbBFIq9NllGBxoOtponP82j/fsp8Oyni6LDyuhWSwP5RFgYwVV1bk6/KNrQv2OxfGo2AJwISe+DUAMjVkvaF4YUiJu3MyqNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2v2uz420UNtqkuz1Ch7GO8skxAjKZCq2gGwEk2rCgcQ=;
 b=CB/uOXumnohblTt86a+0o/dc+Xgj3afQ6ky/n5CCp5D828yxFN0KCiJQBHiv5WRGdseJq0Qoger0e9wf/X+HCd6keeIaxSuLkz1f6xiD8BzHMmUq92OGtTb2wDH48pKykVMlf4pyrvEd9iHz8hTt5IG/EbyJGVzf3yzb5parWvE=
Received: from CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19)
 by CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 06:35:24 +0000
Received: from CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080]) by CO6PR12MB5394.namprd12.prod.outlook.com
 ([fe80::641f:33ef:d412:4080%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 06:35:24 +0000
From: "Zhou, Bob" <Bob.Zhou@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: fix uninitialized variable warning
Thread-Topic: [PATCH 2/2] drm/amdgpu: fix uninitialized variable warning
Thread-Index: AQHalT/LvmVaEXSx2EW9HqyWe4gD0bF1XdiAgAAHh7A=
Date: Tue, 23 Apr 2024 06:35:23 +0000
Message-ID: <CO6PR12MB5394A7C02377487347A987B094112@CO6PR12MB5394.namprd12.prod.outlook.com>
References: <20240423053334.884670-1-bob.zhou@amd.com>
 <5fb6b05e-0e50-4a0e-94c3-c40d96150f61@amd.com>
In-Reply-To: <5fb6b05e-0e50-4a0e-94c3-c40d96150f61@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=06b3e68e-a575-421f-bf3e-90144f7b87c4;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-23T06:32:20Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR12MB5394:EE_|CH3PR12MB9026:EE_
x-ms-office365-filtering-correlation-id: 56f4fe01-3281-4e0b-567e-08dc635f8e48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?MlFYdFdRRCt4NWM0MGluakF6c0VGTzBGMkVsRVJkOWRGNjk5QnNMWmpWeldX?=
 =?utf-8?B?eWtkMG1acy9jbUY2eHRKVTJOdmJoUTVtM0VXS3RUaUR6bHlxWUhxUlA0Q0Ra?=
 =?utf-8?B?SG5NTWk4OFBoVmZ0ZWgyT2FYZHhOdDVrRmllZW5uLzdTUDl3a1dXMzBIM2kw?=
 =?utf-8?B?TWNjWldIWHYxTittaExMc1hIeVNwSnIvRGZiakNTOEhocDZxYWQ2K2tQYmlP?=
 =?utf-8?B?c3NINkhMNGRoTmtyS3JHN0lYMWxyMkxLQWgzUUJDcmd6djZrWGdodTlBL3Ru?=
 =?utf-8?B?dnpqUkpid01NRHBjR0YrZFNEWFExSFJaRjRWN1JvUDF6UWtFaTU1UFVoTlNj?=
 =?utf-8?B?dVE2Rm85NTJCVk41K3JWa3MyOVVZWHdXRWlyOExBSFErZjZZUDZTb1JSMlUr?=
 =?utf-8?B?bndqRG1uaTdieTdKM3AxajZ5TFdsbzhWODNQUTRrR1AyUjJKZ2RSQU1MVlFx?=
 =?utf-8?B?Zy81RVpKc0thelVEODEvS1FENVkxNlNranEvTkVoQTJZZ1djL0ZxS2FCTHNh?=
 =?utf-8?B?L0NCVVYzUDR1OGU0Ry9HWkZzWHVaeklMaHpGRXdvL1dNaklIblNRdnc1NEIw?=
 =?utf-8?B?VUxmQW9DL2dRVmN6RHIzT0l0T3FtbEV4blE1eXBwZEJucWRmNS9HZnZJQ1dh?=
 =?utf-8?B?dStLMkxHbVVkQjkwQUZzbmxHclh1ZGVhd0xBbGNWNy9PRXY4Zml6cW85bDhB?=
 =?utf-8?B?Zm1BK3o3WS9SZkYyUXFRcGNhU2hxRHNrbE04VjhMaC9pdjE0dWlQVHFkYW9j?=
 =?utf-8?B?OWNNVnpxdDFJdXEwRFlobitvUG9SaU9oNUtWak1nbDV4U3YxN2l1L1ZTTTZK?=
 =?utf-8?B?Q254V0NBL2x3Y0EzUVdoejNOYnFNQlcxTWFVTFo1WEEwVGl2a3ZKZlZKaGU4?=
 =?utf-8?B?NVFMZXg5M25pditybFJWTzVHYWlMbSt0K0pkU3ZaMXpld2l2dURYUjc2V3NB?=
 =?utf-8?B?YWxLTEtIYVlpeWZ3MFU2dmY4SzcvNDVWemVNSnF0YU8xd1BxSjhONllsaG5p?=
 =?utf-8?B?aWpyRldLTWFuWW0zc0w5OE9CVGRyd3ZEdUxwRDhFMUtmMzVhR3FpRWRibjZU?=
 =?utf-8?B?RE9kRUVlbTh1aWl3amlqaWhKNUY0ZGk3QVhLU2ZCcjhQelc4MFI4aFZKMXQx?=
 =?utf-8?B?OWcrWWp3ejFndTlOdVRtS3RtZGNiS2UxdzBla3l5N1VsZ0o5SmU4YzhnV3h2?=
 =?utf-8?B?RjRjcGdOK2tuS21NdkV2OWMwTHkrWFBTek1rRnhmTU9tZ2dHNnA5MU5zY211?=
 =?utf-8?B?YXlFeXZwb3BoNFdiTVk4MDBXUkpQeTNaSjF6RzQ3ejVQWUFESENEM1FkWlJD?=
 =?utf-8?B?Qi9hZGExMDRKMGVkdm5pSU1DcERzWFNVdHgyTCttczduSGE5eG9pYnBZS2VI?=
 =?utf-8?B?Q1NTK1NCWnhidXR1V1ZmUm4zaVppck9Oc0J0M25BOEJnM0xGWDByZWVoYVor?=
 =?utf-8?B?RkRyRDRyUnZrTUhHVGhMWUl4dFdOd3J1SktmOENtekpoQ29HaWJkMkJSMWZ1?=
 =?utf-8?B?cjREdlN6SkE5K3d3Z3U0RTY0aER2VGRMdTQwOG8wS2VtMWppOS8wd2g2cld3?=
 =?utf-8?B?Mm85ajVYMnRiVWgyTmNPeDNId2hJVU9HcGZsQXhWT0t0WldXRnBVL1EzSm9W?=
 =?utf-8?B?QW9vMXN0b0M0K1VpRmlhVDBlVGFyMXZkdnBqZTIxUW5yZjBEaFlzdUJtVDdl?=
 =?utf-8?B?S2VVc3lFTzQ5ZU4xbm01TnViUFpkVVB4NEpZNVBoR0xiYkZYNzFwRVFWQVJi?=
 =?utf-8?B?MHA1ekFRNW9DeXRKSXdnOEVBbnJZVm84KzRDc3F1UE10L2VpcmZBV0p2MUty?=
 =?utf-8?B?Y3NES1hlZmpLZlJuUHdyZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5394.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0JBOUR0SFQ4UGxTbkFWeGJjajJPNlNuam1ocEFESDNyaXM4TW1QRnhKeDMr?=
 =?utf-8?B?THhJWlVrV01lVFJSbUpsL1ltcDRZWjc3T0xnNEdSOE1YZ2lDOEtoRXloNXBD?=
 =?utf-8?B?cENJbGtrODhnN3UxclRHTys3Q1RsaDlHZWd5VC9idHBhMm02RXZMa2R2TU90?=
 =?utf-8?B?ZTJkVWFFMklxWjlkamJhOEZTN0RDelRIVXRkazQ0ZkVMdWpzeHJNeVlVUDdl?=
 =?utf-8?B?allqRVdUU0x5aklNRDBtN09ZelREWTNFbjBnUXA3VWdyL2swb2s5TmJXNjIv?=
 =?utf-8?B?bS9LVVkzNmRpYWQ4VFB5bktWeEZxRjhRSVRFSk8yU3Y1Y2FKMnNQRWVoRmZF?=
 =?utf-8?B?a3FpT0hjbVAvb280VktwNEswRGVpRXdVR2wyL25HSjU2VGFRN0xXUTFrcmJs?=
 =?utf-8?B?aWtwZDcrODRsTjREYktVMkY5ZVZ0TDc0czMxYTN6UjQvUVhzYlh2dndTMWZh?=
 =?utf-8?B?VDYzaHdnZ0o4UU9LVFd5Ky9ZWVBBdmZBb2dqcUswVVFKcmlOY0Nlbi8vbjZy?=
 =?utf-8?B?UXdhZlJwWkhBN2pSR0FHamJNWEwwME9BYWF4L2J1SDFncTk2d2FOTTlQc251?=
 =?utf-8?B?d2tSeS9kbVhVTytENHQ2YUw0U2FsdzJSakxGdzJvbnVtUUt6Mlp2UWZYZTRs?=
 =?utf-8?B?MytsS3IrRFZXZW5neUkvMUp3WDROM0xmVTBEZk1PK2V4a3o5R1hzTWxUVFp0?=
 =?utf-8?B?V1hoRCtZek8wSW5QL0Ird1ZRR055eWN4STVEd1hvaFVWVlVOVkpONWliWG82?=
 =?utf-8?B?bUhqbWtvdHpqcUVydm9HZzc2amtlVm9ES3J3aFg5dWM0WEl4ZmdqWnA5ekJa?=
 =?utf-8?B?S3htRTk5YkpnRkRlMFhSeWlxR0d2bGh3VjRWZnpHZHdZOC9hK1A2QllpN1BD?=
 =?utf-8?B?VWlEdWk0S1VIMlRUMXFrajBCTW1IRzNZd1pSb2dwVXdjS1JIVGd1bS9BSERy?=
 =?utf-8?B?L1RkZS9xNWJPU3BRQlExenBsbDQzRDdSMjVNSkhhTzd4YVdqUjE5aGVKM3Ry?=
 =?utf-8?B?VzhSekl4SGpxZldnUU51V3Z4aytVL2JyTGRpemd4VE5Pam5VWjA5VUJhakVZ?=
 =?utf-8?B?YzE1MnRacGtGZk9YUVhmcnRBSzRQTGJtTHlTSWdDTmEvT0VwR2NpdmU1N0dv?=
 =?utf-8?B?ait4UFBxdmxlUmdOU3E3TC8vRW00bTZOcC9BSVRmeTd4S1QyYVlRUFE0N1BV?=
 =?utf-8?B?ckg1c0tselppQUQ2WFQwZ1N1RFFXM21KMThYK2hRaFJSSUJ2UEgwK0tURGJn?=
 =?utf-8?B?ZElDaXoveU93R3orWHl5ZkJmMUdlc01DVDA4bkRuZFIvdkoxU3dxak1HSzRQ?=
 =?utf-8?B?K09YN2NpNGxiTjhXaEMyK1ZDNE96cDJxdHFZTkN3cUlJVURDWjJXNDRPNGpr?=
 =?utf-8?B?S3M2bVVxOGkxWm0wc05wTkxRRzA5NjBVRU5jTU9uUy9LcDI1NTZIeEViSytt?=
 =?utf-8?B?U3JRQkZNNGQ2cVg1b1haU25STmNXUzIwUWVMNVVNOEFSbzc4SzhKcFE5RHZl?=
 =?utf-8?B?Y21pek9tZ0Q0Rm5DajFLdHpWSDNSTkhZNktYMXBjWDVNL3BqWHhtd2JVRTN0?=
 =?utf-8?B?TTJIOFFrbHBzVW1LZW9udEExM1diRk1hNy93Q29peWlYRUZjTWZjVUsyUUh4?=
 =?utf-8?B?WWk0NFUxRnNMWGxRODh4TGhOSFZZSlFMZXdUSTVlQVZLcmMrTm52MVorMlNh?=
 =?utf-8?B?NnQ0bDZCcVFKL3ZUbmVxZEVvalhPYlBaWXJnRlFrM29jNjdPUU9MSWNMbGxK?=
 =?utf-8?B?S0FKSW11ODhtU1ZURjIxVmhCVTV3b3RpT3phd1BBa0FrdVFXNVc2LzlJQ1Rs?=
 =?utf-8?B?UVFpQkozRitSOVdLd1pvU1pRL00zT1oycTZoYlNKa2hJVFF0TXhmb1lsSXRD?=
 =?utf-8?B?MXRRSGxMcmd0Njg3OGFkL2lQcXoxQUMyWWZLb0RVTEdTekQ4Zkk1TFZQWUZQ?=
 =?utf-8?B?VE9yRGQ2bnVEZkV6alRXVVlkN29VK3hHVjZlekJGL1NHamNMWFphSWN1K1E2?=
 =?utf-8?B?aW9jKzNwelk3dzgvUzZ4QnpOQUdiazVvYWtmM3NYRmxYeUhrRW9ocTRCWDYy?=
 =?utf-8?B?TEMvbE53SWFrRUtlUGp5ZkdjV3IydUk3SlJZQWh6b1lZMXo3b3lCYmozb1hB?=
 =?utf-8?Q?ahGs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5394.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f4fe01-3281-4e0b-567e-08dc635f8e48
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 06:35:23.9391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LpG9tBiALUn4HAFkksluXgYWtSiTcpRb3OgW/AIgUlLaLECVrvrTdv4tT03d0dBmiVNXBCW4axNn/EfQ3BmXgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9026
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

W1B1YmxpY10NCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KDQpJIHNob3VsZCBjbGFyaWZ5
IHRoZSBpc3N1ZS4gQXMgeW91IHNlZSB0aGUgYW1kZ3B1X2kyY19nZXRfYnl0ZSBjb2RlOg0KICAg
ICAgICAgICAgICAgIGlmIChpMmNfdHJhbnNmZXIoJmkyY19idXMtPmFkYXB0ZXIsIG1zZ3MsIDIp
ID09IDIpIHsNCiAgICAgICAgICAgICAgICAgICAgICAgICp2YWwgPSBpbl9idWZbMF07DQogICAg
ICAgICAgICAgICAgICAgICAgICBEUk1fREVCVUcoInZhbCA9IDB4JTAyeFxuIiwgKnZhbCk7DQog
ICAgICAgICAgICAgICAgfSBlbHNlIHsNCiAgICAgICAgICAgICAgICAgICAgICAgIERSTV9ERUJV
RygiaTJjIDB4JTAyeCAweCUwMnggcmVhZCBmYWlsZWRcbiIsICBhZGRyLCAqdmFsKTsNCiAgICAg
ICAgICAgICAgICB9DQpJZiB0aGUgcmVhZCBmYWlsdXJlIGJ5IGFtZGdwdV9pMmNfZ2V0X2J5dGUo
KSwgdGhlIHZhbHVlIHdpbGwgbm90IGJlIG1vZGlmaWVkLg0KVGhlbiB0aGUgYW1kZ3B1X2kyY19w
dXRfYnl0ZSgpIHN1Y2Nlc3NmdWxseSB3cml0dGVuIHRoZSByYW5kb20gdmFsdWUgYW5kIGl0IHdp
bGwgY2F1c2UgdW5leHBlY3RlZCBpc3N1ZS4NCg0KUmVnYXJkcywNCkJvYg0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2Vu
aWdAYW1kLmNvbT4NClNlbnQ6IDIwMjTlubQ05pyIMjPml6UgMTQ6MDUNClRvOiBaaG91LCBCb2Ig
PEJvYi5aaG91QGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgRGV1Y2hl
ciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3Rp
YW4gPENocmlzdGlhbi5Lb2VuaWdAYW1kLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBk
cm0vYW1kZ3B1OiBmaXggdW5pbml0aWFsaXplZCB2YXJpYWJsZSB3YXJuaW5nDQoNCkFtIDIzLjA0
LjI0IHVtIDA3OjMzIHNjaHJpZWIgQm9iIFpob3U6DQo+IEJlY2F1c2UgdGhlIHZhbCBpc24ndCBp
bml0aWFsaXplZCwgYSByYW5kb20gdmFyaWFibGUgaXMgc2V0IGJ5IGFtZGdwdV9pMmNfcHV0X2J5
dGUuDQo+IFNvIGZpeCB0aGUgdW5pbml0aWFsaXplZCBpc3N1ZS4NCg0KV2VsbCB0aGF0IGlzbid0
IGNvcnJlY3QuIFNlZSB0aGUgY29kZSBoZXJlOg0KDQogICAgICAgICBhbWRncHVfaTJjX2dldF9i
eXRlKGFtZGdwdV9jb25uZWN0b3ItPnJvdXRlcl9idXMsDQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGFtZGdwdV9jb25uZWN0b3ItPnJvdXRlci5pMmNfYWRkciwNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgMHgzLCAmdmFsKTsNCiAgICAgICAgIHZhbCAmPSB+YW1kZ3B1X2Nvbm5l
Y3Rvci0+cm91dGVyLmNkX211eF9jb250cm9sX3BpbjsNCiAgICAgICAgIGFtZGdwdV9pMmNfcHV0
X2J5dGUoYW1kZ3B1X2Nvbm5lY3Rvci0+cm91dGVyX2J1cywNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgYW1kZ3B1X2Nvbm5lY3Rvci0+cm91dGVyLmkyY19hZGRyLA0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAweDMsIHZhbCk7DQoNClRoZSB2YWx1ZSBpcyBmaXJzdCByZWFkIGJ5
IGFtZGdwdV9pMmNfZ2V0X2J5dGUoKSwgdGhlbiBtb2RpZmllZCBhbmQgdGhlbiB3cml0dGVuIGFn
YWluIGJ5IGFtZGdwdV9pMmNfcHV0X2J5dGUoKS4NCg0KV2FzIHRoaXMgYW4gYXV0b21hdGVkIHdh
cm5pbmc/DQoNCkVpdGhlciB3YXkgdGhlIHBhdGNoIGlzIGNsZWFybHkgcmVqZWN0ZWQuDQoNClJl
Z2FyZHMsDQpDaHJpc3RpYW4uDQoNCj4NCj4gU2lnbmVkLW9mZi1ieTogQm9iIFpob3UgPGJvYi56
aG91QGFtZC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9pMmMuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9pMmMuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pMmMuYw0K
PiBpbmRleCA4MjYwOGRmNDMzOTYuLmQ0ZDJkYzc5MmI2MCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2kyYy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9pMmMuYw0KPiBAQCAtMzY4LDcgKzM2OCw3IEBAIGFtZGdwdV9p
MmNfcm91dGVyX3NlbGVjdF9kZGNfcG9ydChjb25zdCBzdHJ1Y3QgYW1kZ3B1X2Nvbm5lY3RvciAq
YW1kZ3B1X2Nvbm5lY3RvDQo+ICAgdm9pZA0KPiAgIGFtZGdwdV9pMmNfcm91dGVyX3NlbGVjdF9j
ZF9wb3J0KGNvbnN0IHN0cnVjdCBhbWRncHVfY29ubmVjdG9yICphbWRncHVfY29ubmVjdG9yKQ0K
PiAgIHsNCj4gLSAgICAgdTggdmFsOw0KPiArICAgICB1OCB2YWwgPSAwOw0KPg0KPiAgICAgICBp
ZiAoIWFtZGdwdV9jb25uZWN0b3ItPnJvdXRlci5jZF92YWxpZCkNCj4gICAgICAgICAgICAgICBy
ZXR1cm47DQoNCg==

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B331FD3C525
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 03:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51DEE10E64D;
	Wed, 10 Dec 2025 03:04:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D4nM8UvO";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013012.outbound.protection.outlook.com
 [40.93.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C868510E64D
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 03:04:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKsCZAkHiMQI3m1+/LU5hxznlngKJTWWq/YrNfBXKWYX6ohdmAu3rIvEpitYfnjziRURWX6Udw8uAuogHzxOMST1j/ioVhL0ftTrMf+GS6Dy96crOYNgyHeG+gMhVO6gRtIcOPzQbj5ahVN2bJoD6c2ftD6PXyq1NNfgyk0O86GtzJttS4z/3sQtwI4mByVLHU9wYtPmlt6UN3yRutJOWeHHXwt9SLzXanBE45JFyVHXsTc3lp0O5100aeN4fDPfxqpRWl/8wmpW96vHOpeiWpHgLRXtRztCfZGPifOULD3LBFjc2t822jWqfxoj2msmaEFqpuMK3MCfuYGUNYUpIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfUHlNVeEMs+gW+fM+CFRJqtmHExWZIdD81k5nmaTYQ=;
 b=Xep6qQ68KArT9E9z+6El63qObIU7Z8LW8pyp2fs6fKKdwY4AyNZnkcPq2MdE9651AFOatIbGBxgTxIFIJP+sizBJRoiGgrdctl6EvEXXjA4+MqO7KUD2MJlGmOaJ5l65j+0R0GmPkfWcww34XBfRkMij3wvw2d4lLuNEyuKtz5ia6azhiItj0aa0EYw6xaUJItnWqeWD0eX536tjWXnxVBd1VTmKD+sKL1sQgrtpOWAYtgp4pH5gUf6CFwA3MltUKVnjkVS2poITTtvEzZknYX7Ucg1b9kQ/my6j7JQmiFlu+MOh65AujG6b+Nt9qTFY9CfM71Yxs5tljzgWzMLcKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfUHlNVeEMs+gW+fM+CFRJqtmHExWZIdD81k5nmaTYQ=;
 b=D4nM8UvOIH8Y+qgnm93SBT9jbQjG6fRTyt92cOY8ydC1XFIidok+MLWy904RUArcnw537MVUhAX+3FUcO2UuH8Anw/AuHiNy6nP4BaQFAVcssEvN6upp983wvFsU8hqrIWJ7UkTAURNoZd37hCwuy3uZpsEe8UsnAD8+ZPHD1t0=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by LV2PR12MB5848.namprd12.prod.outlook.com (2603:10b6:408:173::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 03:04:23 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 03:04:19 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Wait for eviction fence before scheduling
 resume work
Thread-Topic: [PATCH] drm/amdgpu: Wait for eviction fence before scheduling
 resume work
Thread-Index: AQHcaO2W845K0EhyQkOGrmuD/SK25bUZDkqAgAEibtA=
Date: Wed, 10 Dec 2025 03:04:19 +0000
Message-ID: <DM4PR12MB51521EBE33AC44DA2EC192A0E3A0A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20251209092409.1257671-1-Jesse.Zhang@amd.com>
 <c1aa6e1e-88a8-4b09-aa8a-f239f1306b9d@amd.com>
In-Reply-To: <c1aa6e1e-88a8-4b09-aa8a-f239f1306b9d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-10T03:01:32.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|LV2PR12MB5848:EE_
x-ms-office365-filtering-correlation-id: 250b0d6f-39f0-41b0-45c4-08de3798cfab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?ZHdKMjNHNG1UTEgwaEdmM0k1MmFFT0F3amQ3NHZ4cTNWWkNoQzN3ZVhoQTA0?=
 =?utf-8?B?ZmZ0K3hPbmZqWVZaY3NpNnZ6VGpyV0VqSTlrWG1mdVRBV1NEaC9pOEczRDVW?=
 =?utf-8?B?eFV3Slgrc2ptcHFkNTlzY3RWTXZhazN0S3prYzdMY3BUdzFVVTcxSzZKN1FI?=
 =?utf-8?B?SHhkSGFyQnMxcjdkM28zNzlIMWU5WTY2MVhZWjRncmZuaTBtWWdYRU1MVWd2?=
 =?utf-8?B?MkVYTzB0bDdQT1pmN3VCUmhpLzZHcDZHellBcmJ1NUh3eEtSWnpmY1hNU044?=
 =?utf-8?B?MTlhRTNiZnBieksrdkdVdGgvVDI5TXgzV1ZKZTVTTmN0Mk1ScDVYNlcvRGNi?=
 =?utf-8?B?bHdCSzFQVGx0YzA3ZzVTNncwVDlQWjZqNSthOXA4dkxCblJhMm9QZmVmY1Jl?=
 =?utf-8?B?dHI5cWR3N2pQc1JmNWpybjVvUitMNkJqeWRYL1VINUNEVUVDR0J3aVFYK3Uw?=
 =?utf-8?B?TkFHTmdHR1hvdXJxQmd1U0NNbVpGNGlRcVRzV2VUa0dDa240UitENHVNQ1Z0?=
 =?utf-8?B?MWZBZThxcDROYUZweUxralV4TTQ1d05XaWJwMHdzc2RZS1pHcHE4U01VMjBh?=
 =?utf-8?B?NzJZQmRsbjl4UkduZzdjTGdHUXZrSWE5bzhacHZScnJ6WFVsZlI1eTNkcHNV?=
 =?utf-8?B?eUg2QkhYTmN1N2w4aWRQTUdRMC9QQkZwcVhOQTh3WWMwcmdJRnlMNXBrUEgw?=
 =?utf-8?B?dy9IZnI0ZGZheUJVcUsxSnVEMVVPUzROeDdTcjN5LzFLTEtuYm93YnUyTzda?=
 =?utf-8?B?Qm1CMFBaM2NKV3p1TUFpMmtOSHpyZStCOVg0MzJ2ZU1WYi9aZ3ZncFNYSEZP?=
 =?utf-8?B?RlNPUDhUeEk0YjJRaDZWaW0zL0F5SDdWNmJuMkV5Q2llanBBY0p0RWlCT2NZ?=
 =?utf-8?B?cnIyTW9TUE5qUzNDVFVKbW0zRHBmYkxiRjJNU2w0TURLaHFlcnB1Zldnb2J1?=
 =?utf-8?B?R24xY0pHd0ovVklkWXlpZnBiVFQvYTNTVGp5WEpGUFI3R2IwVU9EQktmM3k0?=
 =?utf-8?B?WFlPcWY1bExVaFN0SFYyWGkzdVJMaW5oc0ZTWkRLalpXNXhnaWRqeU0zbFF2?=
 =?utf-8?B?WVg2d0pGV0puZTlJV1JTWUZTQUgySGpMLytWYmFOeUZCenFmMlRRYWZKaCs1?=
 =?utf-8?B?RE5YZUFJYUZPNjR4cG9yRmd2VDlyZWpZUldVblA4Uy8vVlNkM3lCVXBySTRj?=
 =?utf-8?B?NWlxRTdFUVJRZGFvSzFUYmRZSjRXZTBsOE1FalF3MHNNQ2hPRy9MMEVzSmQz?=
 =?utf-8?B?QXVuZ29BL3UvMHlrRzFGM3dENUtFbzN1aUJZSnA1QlFYQUNqU0FqM3gzL1BC?=
 =?utf-8?B?ZDhPcU5BRlVJYzlpMkJ5eHNIeVRQb1IxckRwb2kvdEsxc3RWUjQ5RjQ2KzVY?=
 =?utf-8?B?RE40NmIyaU8rV0doV3d5V01FUko3MUxqeFViQlpuUk0zR2pzTWdOWkVMSlYy?=
 =?utf-8?B?WElvVDREL2ZIR2RxRlZnTVZyOExpem5wVWJ5cnhmVEZWSUM5MzB1aUdQMG40?=
 =?utf-8?B?Y2ZSWnBzVUpvZnhvZHRnVWtuQXl0cWFyVTZJK2NFUHorTzRVdm5NTS8xK0lx?=
 =?utf-8?B?Sjh6VzIyRG01KzlCSUp2NHZNT21EODQ5bmRaRkN2NTdQWE54MlFWdGxGbGZY?=
 =?utf-8?B?amM1UXNqbE41Z0c3WVJRR3BuWWRueWV3a21Na3lLWHVnZkVIcnhOcWl6L2dI?=
 =?utf-8?B?L1U3OUNDZ3BTdHF0akRMUlFkNGpELytxSlEzcFJvUURyWlluUWkvZjZQUVdD?=
 =?utf-8?B?RGhadE1nOXJRYkZ4a2I3ODZJZk9JRzNTRElBdDNtUXlzWDV2L2dOT05pblc2?=
 =?utf-8?B?anZQaTQ1MDQ1U1N3MWRScmwyeWZ1RXNLVnhyaUd2Y2dmbmUybk5MbWlaZ240?=
 =?utf-8?B?NXpLU1h3S3p4azZPK0VtSzFLc3V4SEMvTFhtMm5ydjA2ZlQ3TXQ4YWhlTkcx?=
 =?utf-8?B?cDF0bzJ0MzgrQTRKR0c0Vnl4UEtpNzI4RnU1OWxGYmZEYlQvZkhYV1RzVE5o?=
 =?utf-8?B?SUVzRk5SdEJVUG5tZUVtODNqaVZVR1pwTC9jWlV6VFJ6MkpQcHRDWkxGNm1T?=
 =?utf-8?Q?eJuzaa?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkJoRlc3RndIODl0Si9NWFFsUVoyaEJpTUFQTGZFRERZTnNqQ3luOEtLZ1c0?=
 =?utf-8?B?UnYyNUFqcisyejhTSUdQUFBXc2E3V1JYK3A4dFhqQkdUczYrM2twTERkS3VN?=
 =?utf-8?B?SVd6OUZEV0NpWmVNamFJRXFDTU1pdXhCVVNTcFU4dTRIRm5maUIwYnIxNUVD?=
 =?utf-8?B?YjUxcHExS1hHM0ozcUJrc2JtQllZV2RzYWVuczNMUXd6SjQ2alpoai8wc2pw?=
 =?utf-8?B?ZkZDMGh3eE5HVjVBckIyRVFGaDRPVEdPenBQdkV2aFhVTnpGcTJXLzNHTitx?=
 =?utf-8?B?U1NVL1ZZQTZtVDFDOVFuV0tOY3B4VklFRWVsOTRhcTlUZ3BvNFVJcHl5dk8w?=
 =?utf-8?B?ZjZjMU9TRGtSeGdsWFBnb1hGVkJmTExxLzFwcUN0S3p2cTFjWFhGNkw2Tzlw?=
 =?utf-8?B?dnNaUndQQllGNlFUbkF6R25kRmdsNTllSlNxSEdlNjRXb3ZpL1daUFNxcjQ0?=
 =?utf-8?B?QkZQYjM3SkNZK1hsVnRMMnhVTi9pMzZ1YW5sS0NkZGZYaERnVVJvYitEMVgy?=
 =?utf-8?B?QW9aNkkyeHg2WUVFZjVrVG5QUTFGUkVnakpFbE81dnFlRVdyRXBSa2srSzQ5?=
 =?utf-8?B?Ri9XZ25pZWlsWEh4R3ZseFpCQ3VhdG1kZ0hHb0h3djgrOFJPckl4YnNlS2Jq?=
 =?utf-8?B?TVRZNjVvRzdKa1NmTEVsczhQVnJkVHh1aW8yVE4xaDFDaWs0QVRETWQwZzhT?=
 =?utf-8?B?VnVZNFplOHNhUzZuWERBWmtMZS9TWFBKc3pSZWpXR3gyenB3RUVCa1ZBeDRx?=
 =?utf-8?B?VkRyVU5nU1NrUUNZL2RDaktTdjBxS1BDczhEUVBRSjJpNzhmYTlRZklUeWhY?=
 =?utf-8?B?RUtEQ244L0FDY2Q0VWErNFlIV0tpNlp3ME5TcHdXcFpDSk5BcmhEOXZwNHph?=
 =?utf-8?B?cUxDekRzZnBRQ00zbXp3dDdLWFV0OWtQUGZ1MFFYMzBMMjJwNlB3YXZyRnFN?=
 =?utf-8?B?YmtGZUcrRmZMUmg1SnpVY1Q5b0lwWmxoWFcxQ3Yrbm05ZEZyeURvazJJSERH?=
 =?utf-8?B?YS9HSmRySkRZMmg2SW9Eb3F6bzB1MTdnY0NnZUg2aUdPWUQrbGRUM3RjbG1P?=
 =?utf-8?B?QjdMMStkeS9oYTk1akt3bldEeG5sOVVMWWFhOEx2a0FiQm9VRVloQ2ZpaUM4?=
 =?utf-8?B?Skl4MmlkY0p5cWRMVFZ5aFhlYmhkMHpVR05RMUU3aUhxOVNxL1VwWlVoV3Jp?=
 =?utf-8?B?ZG4wZ2RBQXpCT1dLcnFnSGNBQS9yaytUK0F4cGhPUHQzL0VDeFJwN0x5elFp?=
 =?utf-8?B?VEhVRXltdE1XaGJxcklLcHB5M1VQaFR4Q0FWYk9VZzJJaTE5SW1MUVBSYTB5?=
 =?utf-8?B?MDI3N0JpVEl5Zk1hNXUwVjcxTENOQk1UMFpRNkV3cXliT3RFVTU1Z3RyMGJS?=
 =?utf-8?B?cUlmWFR4cXVVcEdsenl6cUt3b3FMbU1URG1NQ0J4WmJHYlBXemF4RW1Qbjha?=
 =?utf-8?B?SWkxVzFCenZlNVFsNWJ2aG9kZ1ZOMWxWNEpwUWRXOTVMRU1kMUxiZUNmekdy?=
 =?utf-8?B?ZU9FVGF6aFBqSDJjdHJVeHJmVUtEVDF6cHZMZG5ibUVRNGhHQVlWWjVXZlVZ?=
 =?utf-8?B?bVdobXh4NHFJMGZZYlJET2I2SjRWWWNkcmtoeUs1RTc5c1kvQ2VJMUpmQ3NN?=
 =?utf-8?B?Y2ppQkZmd0VkdVo3YkZ1TllvNHRYdngrb3hnazZlN09tcG9FNGlrSEZscFVz?=
 =?utf-8?B?SHJZS3NqVWlNS2YzK1grV0trbG1rd0pOYy90QnRxeENmRnpuekx6Ni9uZFJZ?=
 =?utf-8?B?NUswcFgwcnFyQUdsT0tFTGk5VmxZb3pGczVYU0pkS2JnTzRvNTV2MCtCVzJV?=
 =?utf-8?B?dzk1YkpVMkMwaXFjUGZ5UkU5RVNDYUZTWXNHQ2lCZDRFZTM3RUtHV1RlQWJ1?=
 =?utf-8?B?TWpIZnBod0NDcm00NHh3bTFET3FCSVN1VlZ2VUtPbWx2bURQQm5wVkZmRnVK?=
 =?utf-8?B?MVpqTG9ZNkNVU2RWMDl5WmZMT0toTUhoWVlvRnNoblJEMUFWaktJWmhEREdy?=
 =?utf-8?B?aEdwM3ZMeHoxWFl2RUJCa2FCK0trSFovUkZVYXIwOHBhUUFacURzald0T050?=
 =?utf-8?B?ZnhpdFFvdzRIaHluZkpKdjdTMHQ2ODhTRWxzWUtjZEVGeDVDbXUxNWRZak9i?=
 =?utf-8?Q?mXJk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250b0d6f-39f0-41b0-45c4-08de3798cfab
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 03:04:19.1319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X/Zjr1yS6VET/vBi+Y2I+0KNldHaBY4F2lEOudaBTmR7KLuKEECI3Dg9T/f31rbQUXMYDSxUCoVfX3RQ5MCsmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5848
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlh
biA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciA5
LCAyMDI1IDU6NDIgUE0NCj4gVG86IFpoYW5nLCBKZXNzZShKaWUpIDxKZXNzZS5aaGFuZ0BhbWQu
Y29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhh
bmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0g
ZHJtL2FtZGdwdTogV2FpdCBmb3IgZXZpY3Rpb24gZmVuY2UgYmVmb3JlIHNjaGVkdWxpbmcNCj4g
cmVzdW1lIHdvcmsNCj4NCj4gT24gMTIvOS8yNSAxMDoyMywgSmVzc2UuWmhhbmcgd3JvdGU6DQo+
ID4gSW4gdGhlIGFtZGdwdV91c2VycV9ldmljdCBmdW5jdGlvbiwgYWZ0ZXIgc2lnbmFsaW5nIHRo
ZSBldmljdGlvbg0KPiA+IGZlbmNlLCB3ZSBuZWVkIHRvIGVuc3VyZSBpdCdzIHByb2Nlc3NlZCBi
ZWZvcmUgc2NoZWR1bGluZyB0aGUgcmVzdW1lDQo+ID4gd29yay4gVGhpcyBwcmV2ZW50cyBwb3Rl
bnRpYWwgcmFjZSBjb25kaXRpb25zIHdoZXJlIHRoZSByZXN1bWUgd29yaw0KPiA+IG1pZ2h0IHN0
YXJ0IGJlZm9yZSB0aGUgZXZpY3Rpb24gZmVuY2UgaGFzIGJlZW4gZnVsbHkgaGFuZGxlZCwgbGVh
ZGluZw0KPiA+IHRvIGluY29uc2lzdGVudCBzdGF0ZSBpbiB1c2VyIHF1ZXVlcy4NCj4NCj4gV2Vs
bCBzaWduYWxpbmcgdGhlIGZlbmNlIG1lYW5zIGl0IGlzIGZ1bGx5IHByb2Nlc3NlZC4gU28gdGhp
cyBjaGFuZ2UgaGVyZSBpcyBqdXN0DQo+IGJsdW50bHkgbm9uc2Vuc2UuDQo+DQo+IFdoYXQgZXhh
Y3RseSBpcyBoYXBwZW5pbmc/DQpbWmhhbmcsIEplc3NlKEppZSldIEhpIENocmlzdGlhbiwNCg0K
TGV0IG1lIGNsYXJpZnkgdGhlIGlzc3VlIHdlJ3JlIG9ic2VydmluZyB3aXRoIHRoZSBTRE1BIHVz
ZXIgcXVldWVzIHVuZGVyIHN0cmVzcy4NCg0KKipUaGUgUHJvYmxlbToqKg0KRHVyaW5nIHN0cmVz
cyB0ZXN0aW5nIG9mIFNETUEgdXNlciBxdWV1ZXMsIHdlIGludGVybWl0dGVudGx5IHNlZSBzdGFs
ZSBkb29yYmVsbCB2YWx1ZXMgcGVyc2lzdGluZyBhZnRlciB0aGUgQ1BVIHdyaXRlcyB0byBgY3B1
X3dwdHJgLg0KU3BlY2lmaWNhbGx5LCBhZnRlciB1cGRhdGluZyBgY3B1X3dwdHJgICh3aGljaCBz
aG91bGQgdXBkYXRlIHRoZSBkb29yYmVsbCksIHRoZSBkb29yYmVsbCByZWdpc3RlciBzb21ldGlt
ZXMgcmV0YWlucyBpdHMgcHJldmlvdXMgdmFsdWUsDQpjYXVzaW5nIGluY29uc2lzdGVudCBxdWV1
ZSBiZWhhdmlvci4gVGhpcyBoYXBwZW5zIHJhbmRvbWx5IHVuZGVyIGhlYXZ5IGxvYWQgYnV0IGlz
IHJlcHJvZHVjaWJsZSBpbiBzdHJlc3Mgc2NlbmFyaW9zLg0KDQoNCioqUm9vdCBDYXVzZSBBbmFs
eXNpczoqKg0KQWZ0ZXIgc2lnbmFsaW5nIHRoZSBldmljdGlvbiBmZW5jZSwgdGhlIHJlc3VtZSB3
b3JrIGlzIHNjaGVkdWxlZCBpbW1lZGlhdGVseSB3aXRob3V0IGVuc3VyaW5nIHRoYXQgYWxsIGlu
dGVybmFsIGRyaXZlciBzdGF0ZSB1cGRhdGVzDQoocXVldWUgc3RhdGUgdHJhbnNpdGlvbnMsIE1F
UyBzdGF0ZSBjbGVhbnVwLCBldGMuKSBhcmUgZnVsbHkgdmlzaWJsZSBhbmQgY29uc2lzdGVudC4N
Cg0KDQpIb3cgYWJvdXQgY2hhbmdpbmcgaXQgdGhpcyB3YXk/DQotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3VzZXJxLmMNCkBAIC0xMTMwLDggKzExMzAsMjcgQEAgc3RhdGljIHZvaWQg
YW1kZ3B1X3VzZXJxX3Jlc3RvcmVfd29ya2VyKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCiB7
DQogICAgICAgIC8qIFNjaGVkdWxlIGEgcmVzdW1lIHdvcmsgKi8NCi0gICAgICAgc2NoZWR1bGVf
ZGVsYXllZF93b3JrKCZ1cV9tZ3ItPnJlc3VtZV93b3JrLCAwKTsNCisgICAgICAgc2NoZWR1bGVf
ZGVsYXllZF93b3JrKCZ1cV9tZ3ItPnJlc3VtZV93b3JrLCB1c2Vjc190b19qaWZmaWVzKDEwMDAp
KTsNCg0KVGhhbmtzDQpKZXNzZQ0KDQo+DQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCj4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEplc3NlIFpoYW5nIDxKZXNzZS5aaGFuZ0BhbWQuY29tPg0K
PiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYyB8
IDQgKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4g
PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gaW5kZXgg
MmY5N2YzNWUwYWY1Li5lZDc0NGIyZWRjNjEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYw0KPiA+IEBAIC0xMjM4LDYgKzEyMzgsMTAgQEAgYW1k
Z3B1X3VzZXJxX2V2aWN0KHN0cnVjdCBhbWRncHVfdXNlcnFfbWdyDQo+ICp1cV9tZ3IsDQo+ID4g
ICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICAgICB9DQo+ID4NCj4gPiArICAgICAgIC8qIFdhaXQg
Zm9yIGV2aWN0aW9uIGZlbmNlIHRvIGJlIHByb2Nlc3NlZCBiZWZvcmUgc2NoZWR1bGUgYSByZXN1
bWUgd29yayAqLw0KPiA+ICsgICBpZiAoZG1hX2ZlbmNlX3dhaXRfdGltZW91dCgmZXZfZmVuY2Ut
PmJhc2UsIGZhbHNlLCBtc2Vjc190b19qaWZmaWVzKDEwMCkpDQo+IDw9IDApIHsNCj4gPiArICAg
ICAgICAgICBkZXZfd2FybihhZGV2LT5kZXYsICJFdmljdGlvbiBmZW5jZSB3YWl0IHRpbWVkIG91
dFxuIik7DQo+ID4gKyAgIH0NCj4gPiAgICAgLyogU2NoZWR1bGUgYSByZXN1bWUgd29yayAqLw0K
PiA+ICAgICBzY2hlZHVsZV9kZWxheWVkX3dvcmsoJnVxX21nci0+cmVzdW1lX3dvcmssIDApOyAg
fQ0KDQo=

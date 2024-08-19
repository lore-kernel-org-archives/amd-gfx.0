Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52C5C5320E
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 09:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F8BB10E0EA;
	Mon, 19 Aug 2024 09:37:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uEf6/paO";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 703B410E0EA
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 09:37:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSP8nsVHs7HQbowUIW2SO/RJCpQOeJ6sMGuPCeajEG3YTwELLPysYc7MYc9aHR2M63OIzHk2StsBVOwTov+Awzwl0+IVNLoUEkptEYiwYhSpZqt94V1azVnkqwJwJF2FNsB7pa13JRnD2V+VuoEkZaQ2rcgSHxkUwO0NRzLzlcj/p7YIWg4wn2PfKEkTezOyw0aHDXVPGLtHsQBj1p3ZZCoHbfqXLh0JXsJU2MJ/Kh/EQTsG0oEvEM2szsh3ObUmkE2vz8wMyr3C2Ve7CJANR85T7tKwiAEhpz0wpihxL1D6Fpc3xMjvayqiAAXy4ejTWmSiAFIQM3KKsZTxli8TXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/CJg1Dt9oNBPc0eWkLM8LCY1McfitXsk1uz8b+lUBLA=;
 b=clS86gqbKXuKVmwCt4qJ8JMT/mVGRzmG+v+IaFCjdjVayCRQBe1dDV6CQ1vVthR/ijkM8UC2FVa3UpkwqbEHNhmEb9Jx5HyhNXUDFFY+Xq+xsmo01J9b01rnAdfsQjUclD7sWq+2dbFaWiV/jaQB7gqHUXsMDQ93vD3bYpymXKLeahEuBDiOgGO2g/S3pW5bOdd2FOZ6EesHhJUQn1yVIyv/q09NBHes1HYPrCEb400QNx759vSJyE6G4BQSIl4YV9RZ3PhZFxhHpajUfauSEv0VlA2UHLUcaeDnLHQbxPCLZYmlKk34jBh13ei+KHC4B2JMOXIEWjZnG8lGEkPErw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CJg1Dt9oNBPc0eWkLM8LCY1McfitXsk1uz8b+lUBLA=;
 b=uEf6/paOLego+FhImKvZ7lsjKpRGG0EygaZOy4s/zGxg2gWWMZkTGVeNAwuLoYoU6IIdO+hrpFMnSiKJVPkOFun7/2Qe5v0Q3l7EsUqS7eo++GUzM0KTAboFiiZuLqPpsn+0pB4Pjpw6DJ2vK/mK6KESU1v8g3IaXdyxBO4a0VE=
Received: from SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15)
 by SN7PR12MB7345.namprd12.prod.outlook.com (2603:10b6:806:298::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 09:37:05 +0000
Received: from SA1PR12MB7442.namprd12.prod.outlook.com
 ([fe80::cf37:527e:ce1c:5a78]) by SA1PR12MB7442.namprd12.prod.outlook.com
 ([fe80::cf37:527e:ce1c:5a78%5]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 09:37:05 +0000
From: "Huang, Trigger" <Trigger.Huang@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Khatri, 
 Sunil" <Sunil.Khatri@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: Do core dump immediately when job tmo
Thread-Topic: [PATCH 4/4] drm/amdgpu: Do core dump immediately when job tmo
Thread-Index: AQHa77GjmjPzps/WQkWAvR/NNJnNg7Ip6XOAgARsBlA=
Date: Mon, 19 Aug 2024 09:37:05 +0000
Message-ID: <SA1PR12MB7442EFEFE5AD627E16CA9202FE8C2@SA1PR12MB7442.namprd12.prod.outlook.com>
References: <20240816075447.442983-1-Trigger.Huang@amd.com>
 <20240816075447.442983-5-Trigger.Huang@amd.com>
 <CADnq5_O340AzmjzDyJT+wrfC4nXUT6h6392+V+nSH2hL0AknGw@mail.gmail.com>
In-Reply-To: <CADnq5_O340AzmjzDyJT+wrfC4nXUT6h6392+V+nSH2hL0AknGw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=bd9289ed-95e2-4de5-9020-76bcb98e6789;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-19T09:30:29Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7442:EE_|SN7PR12MB7345:EE_
x-ms-office365-filtering-correlation-id: 2c097885-ee14-4fc6-0249-08dcc0327cb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ait6eWoxeEV2OGo5VGlWYkIrY05iaFVTckQ4NFdFMU1NeGZBYXVOSjdqc2Fk?=
 =?utf-8?B?U3pKSkRSUkd5b1FOUTg0Tm1mdGhCREVUNiszN0pDaUFad0tiQnZFVVA3QkRZ?=
 =?utf-8?B?TUExd3dVUjRXUm5MV3JHYzc4bi9EL0piY0QwVDMzVjFYZE5wUHRoaVF5MlRo?=
 =?utf-8?B?ZFRJSUhpUHBYUHdKVlM2a3p1amVwM2p3b2xEV3lRakI1b1ZETERSSTR0UzdE?=
 =?utf-8?B?ekZjQVB3NXNpdUFtTjVhQ014UVFoZ2xyTjgyazV6NGdORHc3dkhYWjVKdDVq?=
 =?utf-8?B?TFZlS1Vud1U2OEY4RFNBakNEWHRnYnhydFlDdXZwRi91UnhBanJuaGxyeUtt?=
 =?utf-8?B?U1JHZVFnYlpONmlyNnBuN0ZXci9saEhJTHIvSkNMZWRua24xQ29hM3pNdks3?=
 =?utf-8?B?Tk5OWHNCN3lrTTlkWEQ4RUh4dk14M1ByNUVPdm9kZ2t0NHQ2YWNoS1czVWQw?=
 =?utf-8?B?T2FPOEM4UlpLZjFUTXkvZHQ0SW1iWUtMVUlrNC85djVIZVNiVTdrNi91WWdY?=
 =?utf-8?B?STJKUGpONjh6a2x0N2F2TEcrWmp4ejJSdWhUTldXWXR0VnYwUmJyc3V0T2Zw?=
 =?utf-8?B?ZGhFVEtsWDRvWi90WWMybDc0ZnZzQWVwQzZEbVlRSHBRcXJmSEZHSVEvemhC?=
 =?utf-8?B?TUxKUVRWQkFNUmJ0bHpiSDRCM3BIaTIrR0tra0d0N3N5UEdaZnBzN3pKUVhM?=
 =?utf-8?B?ZUFJMWJ3NUR1c1JoOEx4SUxFMzBPR2JPQXBWMWRtcXA0WURYVjY1TzBvMXNE?=
 =?utf-8?B?YXpQbisySDBRTDN3a0NWRVhIUjNtU3FDSUdlMDhSV2JWcnNxKzN1YVIrdyth?=
 =?utf-8?B?cStYTnVDdVpBUE9UaU9zcXJRYzUrZ2MxMldHemV3Nkt4eklDbXlHTWFja0Qx?=
 =?utf-8?B?K29PK0ExanVOTm1Tem1sUm9Vb2ZRK1VXMXB0aHBVMXR3QkNlUkNvV1dIS1B4?=
 =?utf-8?B?K2xaczRpNysvUGhvbjNDajNzRDBxa1RMSFhxYUMxQWhSQzJ6cmxGTk50bVI4?=
 =?utf-8?B?dDBSeHF3OElXNFFCNXR4cjVWUDlVV3lTZUR5ejlpY29ZTjRvQWtKcisrU20z?=
 =?utf-8?B?TjhPL0JWY3VuMnFSK2YrNnRpeVNzNW0wMlJpT3U0U0NYUEhHY0x4UFVoMlY5?=
 =?utf-8?B?WHVEalFEb0l5dVllR0VNS3BjNlI2RjBLUmcvZE1BVUZTWU1CcGpQd0ErNm9t?=
 =?utf-8?B?dVlqQVlSRktuZld0R1FJd21jK2ZYbW4ycFBMbDNQRyszWEM4QlZ0SlcxekY4?=
 =?utf-8?B?dGg3Wmw4Y0ZIZTIwcVN2cVZuV3dnODUrTXJQKy93bUtrVGFsRS8vRnpuVDVh?=
 =?utf-8?B?cG5wZ29pNkpIL3NvSjlkdFFvTSsrZjV4TCtaT2J0WFlLQkRjYy9ZNitsK0Ex?=
 =?utf-8?B?SnNYb3EvZ0s3SDBlc0p2S2J6OEZNNGkrdklqcG5McXU3MS9PRWVNY0FBcFlS?=
 =?utf-8?B?WDFMSGU1dnoxZjN2Sm5VZHJzaU1na0trWUVpN3ZzbGVueE0rWllOV3lZZFRF?=
 =?utf-8?B?Umk1UTFKWlBJVDlpcnRjOHE2ODRiOEYwZzdnamw5aERMdnB2TlNSVUVnZEhT?=
 =?utf-8?B?eTlZWUtHRTlDbm1WTTRLQXh3ZmVTY1gwckpvTUgyYW9LZjRmQXIrai9Cc2cr?=
 =?utf-8?B?OVVLcDhxdVlMcWQreGdvVHBqUkN3ZVZPa1pYbFYyMGp5WENaU3psdHhLREJT?=
 =?utf-8?B?cFhDenlaa3ZlbVFMV1J2TGlNYWl1azVHOWRWMTlCRkdvVzhBOEpkYlpMYmpH?=
 =?utf-8?B?NkcycWowS0hoOW9TQXVSc0g3dFpSeWE0bTY1NXlvUlpJSHVOT1FRMVdXZU1x?=
 =?utf-8?B?YjdJRE1BbkFDeE9ucGI5TEFCL25Ja0w3VEhON2g3d21yNEFENkVGMjZJSndT?=
 =?utf-8?B?NkhJQzM1UkV5eG5hSktMMURVS3ovaUFwYS9CekFvWjRYa2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7442.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0czSEt5bHZkZTBiSXhqUmI0WmJyaGtPcmdFN2tPRHZvNHVMY2E2MmNTS21h?=
 =?utf-8?B?SmxlWUZTQWdOWlBLL283REE4RCs2WFlyOVpxTmZTSGdqRU4zS3hOV3diNy9S?=
 =?utf-8?B?Z2tIaytobDBYQlYzZm52SEg2V0ZrTFIyczlpUnhMYjZHNzBucEpDVElZVitt?=
 =?utf-8?B?c01uT0dsTWJWRXhpNVNza09qMXIvbXhWMjZodHRRZ3VBMnZ5Y3VRWTUxZ2VW?=
 =?utf-8?B?cmpzbjAxbExuaFhRMFIvZnFIREZhc3VoRnJYWWVjaG1uMWhCRUNDUGxTZmhR?=
 =?utf-8?B?OU5QSFVFcVUvMWs2V0dMRjk3cjhHQmtkNVdqd2gxVE1hNTU3MVIvb1FmbUdR?=
 =?utf-8?B?NDNKSldKa21HUTg4eVQ1R2JmNmJYM1JKOFpkYUoyRHpCVEN4VWYzMDhzc2hp?=
 =?utf-8?B?dUxkZ3RTUTE3WndSd2hGYlowNk5YQ0hPWHIrMTVsMlR3cXc3aXkzZG9BaGN1?=
 =?utf-8?B?OHc5dW5UVjFJU3dQQWJheWs3akk3cENpWnNDd3F2emhsaWU1NzJXSnRhTWkw?=
 =?utf-8?B?Qmk0bFhHRXhIWnV3Q0NwdEhMTjQvWlh3ZTI2ZzQzTHA1enRnSDVwbGc1RHl1?=
 =?utf-8?B?TFZsUzdvbk5XVS9hQ0RIS0NSTWp3MXcrVnUvQmJheEVoUDB3ZVRrWlJHbWEw?=
 =?utf-8?B?NnJJTWMvQjYwUTNRcUxsM2NMeGtsWUhyVGxqdTJITEZPbWdkV3JiTmdGVFhs?=
 =?utf-8?B?WUxDc2lPbGlxbDVwSFlxNVFjeWduODFPU3J6RFlYZEl2UW8yOStYZENUUFBW?=
 =?utf-8?B?QjhGc3lObkw5aC9XZ01qbDNVa1BDbUxuWld1dUtTMHhPZGlRRWhSdkJ1UFlD?=
 =?utf-8?B?bmx1VE9ndnZSSkVPVU96N05va3ZRcWVjU1VCU1ZlM0ppRjFraWVqMVcrVWc1?=
 =?utf-8?B?TmpHR0ljZk8ySnp3VDkzc0RDZDM2YmZraXBWNGMrdnZodmVqN1g3U1RmRXZx?=
 =?utf-8?B?cndwbFZzZUNJdmVzaDQ0b2wvTEVrU2UrcWpJeGxSYUhZL2EwSnRPZWZ3UHNk?=
 =?utf-8?B?cGtPNmhWU1NEQm1mRkpSTXZwUk5kNmpna2pORXpPSlFZTlZkZ0J5SlFLY0Z4?=
 =?utf-8?B?TXJNTzFaY3ZGMTc0L3pBWDhYcGpCTVI2Tk8yMHordXZPS0hSaGZBdFE3N1o1?=
 =?utf-8?B?bjNMb3o2VHR6LzQzdERWWDdHek9rTG9wQ1d5bXZiRVZjcEE3VjA4aHlkaWdN?=
 =?utf-8?B?SkxYTHJoUHpCUUlLL0tuc2M2NnRyTXJuOWlmZzErRFVNUVJmUFdoMGUyVVdY?=
 =?utf-8?B?R0FIQldHUHgxTzJQM2ZPR08wNnNYM292azN6eW5JbEtMbVVoem9abVg1dnR5?=
 =?utf-8?B?MWY2SVVhYVppRnpYR3V6bW84MW5RbVNWU2phenJSWmNIM0kwU1VkSXJTUURB?=
 =?utf-8?B?SUlmQjdRNDBEL0FXR0tNYXhxWmxVLy8xeFZOSE1WQ2RFa0ZENVpQc2g1UXB6?=
 =?utf-8?B?aW1ZeTRMT0xFRnl6TXdCQmNtcEhBZC9GQ1ZnSnlkOUUyYSthbUpFUEJucFMx?=
 =?utf-8?B?M3BaMmRHRldKMXhTNHVNYjdFNW5BQnhqKzRpR0dTUnR6ejE2Q2FaQmY3QWdw?=
 =?utf-8?B?byt6UFFOdVEreFhWcEY5Q0FOa3U1eXFaZWR1K2FVODRtcnduR2hjUXpvKy9I?=
 =?utf-8?B?MDgrdm9tVHdJWTlpZXdGOWsxM2w0SURMK3hzYjhJeGdsOVgzbHhyMGVQMTRx?=
 =?utf-8?B?MGd1WlZaVXN1V1FFMkwxNVZpZ3V0QjVPRlBhRlZnZEFkUFpKMDU1YVRKcUZ2?=
 =?utf-8?B?TVU5WDNPM1RWOWw3SWkyZ3FlSTk2N2pxM1ZUZmJsUWp5RVNLdmV6QktnaFVH?=
 =?utf-8?B?b1FzekVxS09zM2dYTTd4amsvMTV4U2VtRFdOM0xCeXFRcU94ODJ4UzJhMzIw?=
 =?utf-8?B?ZHlWQXNQRXdRcTBSSkhKYjRCVzZFd0grUEM3a2h2ZHBHMFNRa1YyeS9QdTkr?=
 =?utf-8?B?emxLSVd2eURhK0NweFpLdkZ3SE01SWU5a3o3NUhFS3V3K3FBWHUrajVwY2E0?=
 =?utf-8?B?aWJ3UHNNQ3RSSE44MmZWUmcxZFRMY0FHTjl6WlR2VktDUHFFWVZySFl0SW5L?=
 =?utf-8?B?SHFUYml5c2NwRVdQeU5icFc3TnQrbzdkZmhXTE5ya2ZUK20wYkdGd2tjVmJX?=
 =?utf-8?Q?cye8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c097885-ee14-4fc6-0249-08dcc0327cb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 09:37:05.2562 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e3m2T6YA7LdePpkywTGq1Xh9bGf+HA04Loyk4WnRn2ESXgBmh9/zSVijzTOQ62af0pAVty7vt2IdQt8Nc/L7oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7345
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IERldWNoZXIgPGFs
ZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMTYsIDIwMjQgOTo1
OSBQTQ0KPiBUbzogSHVhbmcsIFRyaWdnZXIgPFRyaWdnZXIuSHVhbmdAYW1kLmNvbT4NCj4gQ2M6
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBLaGF0cmksIFN1bmlsIDxTdW5pbC5LaGF0
cmlAYW1kLmNvbT47DQo+IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1k
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCA0LzRdIGRybS9hbWRncHU6IERvIGNvcmUgZHVt
cCBpbW1lZGlhdGVseSB3aGVuIGpvYg0KPiB0bW8NCj4NCj4gT24gRnJpLCBBdWcgMTYsIDIwMjQg
YXQgNDowNeKAr0FNIDxUcmlnZ2VyLkh1YW5nQGFtZC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJv
bTogVHJpZ2dlciBIdWFuZyA8VHJpZ2dlci5IdWFuZ0BhbWQuY29tPg0KPiA+DQo+ID4gRG8gdGhl
IGNvcmVkdW1wIGltbWVkaWF0ZWx5IGFmdGVyIGEgam9iIHRpbWVvdXQgdG8gZ2V0IGEgY2xvc2Vy
DQo+ID4gcmVwcmVzZW50YXRpb24gb2YgR1BVJ3MgZXJyb3Igc3RhdHVzLg0KPiA+DQo+ID4gVjI6
IFRoaXMgd2lsbCBza2lwIHByaW50aW5nIHZyYW1fbG9zdCBhcyB0aGUgR1BVIHJlc2V0IGlzIG5v
dCBoYXBwZW5lZA0KPiA+IHlldCAoQWxleCkNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRyaWdn
ZXIgSHVhbmcgPFRyaWdnZXIuSHVhbmdAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jIHwgNjQNCj4gPiArKysrKysrKysrKysrKysr
KysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2NCBpbnNlcnRpb25zKCspDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jDQo+
ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMNCj4gPiBpbmRleCBj
NmExNzgzZmM5ZWYuLjAwOTU1MTMzNWQwNSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfam9iLmMNCj4gPiBAQCAtMjgsOSArMjgsNjMgQEANCj4gPiAgI2luY2x1
ZGUgPGRybS9kcm1fZHJ2Lmg+DQo+ID4NCj4gPiAgI2luY2x1ZGUgImFtZGdwdS5oIg0KPiA+ICsj
aW5jbHVkZSAiYW1kZ3B1X2Rldl9jb3JlZHVtcC5oIg0KPiA+ICsjaW5jbHVkZSAiYW1kZ3B1X3hn
bWkuaCINCj4gPiAgI2luY2x1ZGUgImFtZGdwdV90cmFjZS5oIg0KPiA+ICAjaW5jbHVkZSAiYW1k
Z3B1X3Jlc2V0LmgiDQo+ID4NCj4gPiArc3RhdGljIHZvaWQgYW1kZ3B1X2pvYl9kb19jb3JlX2R1
bXAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHN0cnVjdCBhbWRncHVfam9iICpqb2IpIHsNCj4gPiArICAgICAgIGludCBpID0g
MDsNCj4gPiArDQo+ID4gKyAgICAgICBkZXZfaW5mbyhhZGV2LT5kZXYsICJEdW1waW5nIElQIFN0
YXRlXG4iKTsNCj4gPiArICAgICAgIGZvciAoaSA9IDA7IGkgPCBhZGV2LT5udW1faXBfYmxvY2tz
OyBpKyspIHsNCj4gPiArICAgICAgICAgICAgICAgaWYgKGFkZXYtPmlwX2Jsb2Nrc1tpXS52ZXJz
aW9uLT5mdW5jcy0+ZHVtcF9pcF9zdGF0ZSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBh
ZGV2LT5pcF9ibG9ja3NbaV0udmVyc2lvbi0+ZnVuY3MNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIC0+ZHVtcF9pcF9zdGF0ZSgodm9pZCAqKWFkZXYpOw0KPiA+ICsgICAgICAg
ICAgICAgICBkZXZfaW5mbyhhZGV2LT5kZXYsICJEdW1waW5nIElQIFN0YXRlIENvbXBsZXRlZFxu
Iik7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgYW1kZ3B1X2NvcmVkdW1wKGFk
ZXYsIHRydWUsIGZhbHNlLCBqb2IpOyB9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9pZCBhbWRncHVf
am9iX2NvcmVfZHVtcChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0DQo+ID4gK2Ft
ZGdwdV9qb2IgKmpvYikgew0KPiA+ICsgICAgICAgc3RydWN0IGxpc3RfaGVhZCBkZXZpY2VfbGlz
dCwgKmRldmljZV9saXN0X2hhbmRsZSA9ICBOVUxMOw0KPiA+ICsgICAgICAgc3RydWN0IGFtZGdw
dV9kZXZpY2UgKnRtcF9hZGV2ID0gTlVMTDsNCj4gPiArICAgICAgIHN0cnVjdCBhbWRncHVfaGl2
ZV9pbmZvICpoaXZlID0gTlVMTDsNCj4gPiArDQo+ID4gKyAgICAgICBpZiAoIWFtZGdwdV9zcmlv
dl92ZihhZGV2KSkNCj4gPiArICAgICAgICAgICAgICAgaGl2ZSA9IGFtZGdwdV9nZXRfeGdtaV9o
aXZlKGFkZXYpOw0KPiA+ICsgICAgICAgaWYgKGhpdmUpDQo+ID4gKyAgICAgICAgICAgICAgIG11
dGV4X2xvY2soJmhpdmUtPmhpdmVfbG9jayk7DQo+ID4gKyAgICAgICAvKg0KPiA+ICsgICAgICAg
ICogUmV1c2UgdGhlIGxvZ2ljIGluIGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIoKSB0byBidWls
ZCBsaXN0IG9mDQo+ID4gKyAgICAgICAgKiBkZXZpY2VzIGZvciBjb2RlIGR1bXANCj4gPiArICAg
ICAgICAqLw0KPiA+ICsgICAgICAgSU5JVF9MSVNUX0hFQUQoJmRldmljZV9saXN0KTsNCj4gPiAr
ICAgICAgIGlmICghYW1kZ3B1X3NyaW92X3ZmKGFkZXYpICYmIChhZGV2LQ0KPiA+Z21jLnhnbWku
bnVtX3BoeXNpY2FsX25vZGVzID4gMSkgJiYgaGl2ZSkgew0KPiA+ICsgICAgICAgICAgICAgICBs
aXN0X2Zvcl9lYWNoX2VudHJ5KHRtcF9hZGV2LCAmaGl2ZS0+ZGV2aWNlX2xpc3QsIGdtYy54Z21p
LmhlYWQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgbGlzdF9hZGRfdGFpbCgmdG1wX2Fk
ZXYtPnJlc2V0X2xpc3QsICZkZXZpY2VfbGlzdCk7DQo+ID4gKyAgICAgICAgICAgICAgIGlmICgh
bGlzdF9pc19maXJzdCgmYWRldi0+cmVzZXRfbGlzdCwgJmRldmljZV9saXN0KSkNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICBsaXN0X3JvdGF0ZV90b19mcm9udCgmYWRldi0+cmVzZXRfbGlz
dCwgJmRldmljZV9saXN0KTsNCj4gPiArICAgICAgICAgICAgICAgZGV2aWNlX2xpc3RfaGFuZGxl
ID0gJmRldmljZV9saXN0Ow0KPiA+ICsgICAgICAgfSBlbHNlIHsNCj4gPiArICAgICAgICAgICAg
ICAgbGlzdF9hZGRfdGFpbCgmYWRldi0+cmVzZXRfbGlzdCwgJmRldmljZV9saXN0KTsNCj4gPiAr
ICAgICAgICAgICAgICAgZGV2aWNlX2xpc3RfaGFuZGxlID0gJmRldmljZV9saXN0Ow0KPiA+ICsg
ICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIC8qIERvIHRoZSBjb3JlZHVtcCBmb3IgZWFjaCBk
ZXZpY2UgKi8NCj4gPiArICAgICAgIGxpc3RfZm9yX2VhY2hfZW50cnkodG1wX2FkZXYsIGRldmlj
ZV9saXN0X2hhbmRsZSwgcmVzZXRfbGlzdCkNCj4gPiArICAgICAgICAgICAgICAgYW1kZ3B1X2pv
Yl9kb19jb3JlX2R1bXAodG1wX2FkZXYsIGpvYik7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKGhp
dmUpIHsNCj4gPiArICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZoaXZlLT5oaXZlX2xvY2sp
Ow0KPiA+ICsgICAgICAgICAgICAgICBhbWRncHVfcHV0X3hnbWlfaGl2ZShoaXZlKTsNCj4gPiAr
ICAgICAgIH0NCj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGVudW0gZHJtX2dwdV9zY2hlZF9z
dGF0IGFtZGdwdV9qb2JfdGltZWRvdXQoc3RydWN0DQo+ID4gZHJtX3NjaGVkX2pvYiAqc19qb2Ip
ICB7DQo+ID4gICAgICAgICBzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSB0b19hbWRncHVfcmlu
ZyhzX2pvYi0+c2NoZWQpOyBAQA0KPiA+IC00OCw2ICsxMDIsMTIgQEAgc3RhdGljIGVudW0gZHJt
X2dwdV9zY2hlZF9zdGF0DQo+IGFtZGdwdV9qb2JfdGltZWRvdXQoc3RydWN0IGRybV9zY2hlZF9q
b2IgKnNfam9iKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gRFJNX0dQVV9TQ0hFRF9TVEFU
X0VOT0RFVjsNCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+ICsgICAgICAgLyoNCj4gPiArICAgICAg
ICAqIERvIHRoZSBjb3JlZHVtcCBpbW1lZGlhdGVseSBhZnRlciBhIGpvYiB0aW1lb3V0IHRvIGdl
dCBhIGNsb3Nlcg0KPiA+ICsgICAgICAgICogcmVwcmVzZW50YXRpb24gb2YgR1BVJ3MgZXJyb3Ig
c3RhdHVzLg0KPiA+ICsgICAgICAgICovDQo+ID4gKyAgICAgICBpZiAoYW1kZ3B1X2dwdV9jb3Jl
ZHVtcCkNCj4gPiArICAgICAgICAgICAgICAgYW1kZ3B1X2pvYl9jb3JlX2R1bXAoYWRldiwgam9i
KTsNCj4gPg0KPiA+ICAgICAgICAgYWRldi0+am9iX2hhbmcgPSB0cnVlOw0KPiA+DQo+ID4gQEAg
LTEwMSw2ICsxNjEsMTAgQEAgc3RhdGljIGVudW0gZHJtX2dwdV9zY2hlZF9zdGF0DQo+IGFtZGdw
dV9qb2JfdGltZWRvdXQoc3RydWN0IGRybV9zY2hlZF9qb2IgKnNfam9iKQ0KPiA+ICAgICAgICAg
ICAgICAgICByZXNldF9jb250ZXh0LnNyYyA9IEFNREdQVV9SRVNFVF9TUkNfSk9COw0KPiA+ICAg
ICAgICAgICAgICAgICBjbGVhcl9iaXQoQU1ER1BVX05FRURfRlVMTF9SRVNFVCwNCj4gPiAmcmVz
ZXRfY29udGV4dC5mbGFncyk7DQo+ID4NCj4gPiArICAgICAgICAgICAgICAgLyogVG8gYXZvaWQg
YSBkb3VibGUgY29yZWR1bXAsIGFzIHdlIGhhdmUgYWxyZWFkeSBkb25lIGl0ICovDQo+ID4gKyAg
ICAgICAgICAgICAgIGlmIChhbWRncHVfZ3B1X2NvcmVkdW1wKQ0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHNldF9iaXQoQU1ER1BVX1NLSVBfQ09SRURVTVAsDQo+ID4gKyAmcmVzZXRfY29u
dGV4dC5mbGFncyk7DQo+ID4gKw0KPg0KPiBJIGNvdWxkIGdvIGVpdGhlciB3YXkgb24gdGhpcyBo
dW5rLiAgRG8geW91IHNlZSBhbnkgcHJvYmxlbXMgd2l0aCBhIGRvdWJsZQ0KPiBjb3JlIGR1bXA/
ICBXZSBhcmUgZWZmZWN0aXZlbHkgZG9pbmcgdHdvIHJlc2V0cy4uLg0KDQpJIHByZWZlciB0byBk
byBpdCBvbmNlLCBhcyB3ZSBoYXZlIGFscmVhZHkgZ290IHRoZSB2ZXJ5IGNsb3NlIHJlcHJlc2Vu
dGF0aW9uIG9mIEdQVSdzIGVycm9yIHN0YXR1cy4NCldoYXQncyBtb3JlLCBkdW1waW5nIHRoZSBJ
UCBzdGF0dXMgYWdhaW4gbWF5IGNvc3Qgc2V2ZXJhbCBtaWxsaXNlY29uZHMgYXMgd2VsbCBhcyBy
ZXF1aXJpbmcgZXh0cmEgTU1JTyBhY2Nlc3MgZm9yIHJlYWRpbmcgYWxsIHRoZSByZWdpc3RlcnMu
DQoNClJlZ2FyZHMsDQpUcmlnZ2VyDQo+DQo+IEFsZXgNCj4NCj4gPiAgICAgICAgICAgICAgICAg
ciA9IGFtZGdwdV9kZXZpY2VfZ3B1X3JlY292ZXIocmluZy0+YWRldiwgam9iLCAmcmVzZXRfY29u
dGV4dCk7DQo+ID4gICAgICAgICAgICAgICAgIGlmIChyKQ0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgIGRldl9lcnIoYWRldi0+ZGV2LCAiR1BVIFJlY292ZXJ5IEZhaWxlZDoNCj4gPiAlZFxu
Iiwgcik7DQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0K

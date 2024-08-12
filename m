Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E87C52D7C
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 05:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EFC810E0CB;
	Mon, 12 Aug 2024 05:37:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tXrsdo8h";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6458510E0CB
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Aug 2024 05:37:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ft1yz2Qt0qAqGTYkcEyBId6SYrKiiAQDnfKkTYjGJgXiNUsJcTmYVcAzbUKc+LxcUEy8PKPABWdnQ+XaQst4D3LZXoQgL4kxZOSIxO9ngCbJr1PcYO0MPX1Vt4BDEzJFoqyPpKg0Z67VwOpgfaqVEPciE6k2gQFxJDOg5CPaaHo0jFaZhIVWQiKfqnu65LnIZJExy+09Pg7iGx7GjIbyafCFCYEpqR+qCh0latQVzsQsFCFFzP/cINtyXbDz9X+xe4TgyaNXF8tgjxY9qrSgUjHlx+6ayu2x40QGAHWqQqSQ+lQrh1TzYwKaRnTps4Wd9EKkqsg8oqxpo8nboGxaDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zjnqc7THMwOuYCOZouTj+S0RVqa3xjfs5Qe74TF6NR4=;
 b=m/USPl/VGpRuXw7JovFniHpm7/q45VbiQnEvN0eJs+L1vz7y1yO97KT+TfOMrqVjurG3w2xJ2GbGOR2MvbYqgLy8zMm/59xnpzozyR9Cen2GHK4zREKpk9sJ2Oglli9smgFMCk90Po3a+Nq1I7rCy+Pdmb5jXJZS5b0BAvx3qiw1HBmB5ERzYH7Y1G+aPhCLtC8TvW5Jh0yWa2irqNIGZcR4MqpTKTgqtU6tWkuXG6fGdaMTAMxEOmEXEiuThZROLCm6l/Y3QgZO/2ky1lwx6aeLIh/wTngE76dZa7MzHfBRhWk5knHwzYgWOjQCQkQDWn9Nt7huq+s3jQxlr1YMcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zjnqc7THMwOuYCOZouTj+S0RVqa3xjfs5Qe74TF6NR4=;
 b=tXrsdo8hD/2RjwkHr+/z5nll8dHUIcnVruXxjz2wRSxdIZQRDrGo6wSH9MqmfEY3nXX8UtjkbLBjphIT370KoJ5EXDJ74+IkpMbQ5dHMNRUaraffwjn17uiA2QYBwpUh9NWA8gxXAWlPmiATG0zaKZw8vN4EC7+1Kj6OSevjfZE=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CYYPR12MB8891.namprd12.prod.outlook.com (2603:10b6:930:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19; Mon, 12 Aug
 2024 05:37:22 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 05:37:22 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Do not init ta microcode from guest side
Thread-Topic: [PATCH] drm/amdgpu: Do not init ta microcode from guest side
Thread-Index: AQHa7Gbpc5z1r5GoDEqGyPPPu+H+q7IjDg2AgAADgECAAAMOAIAABNFQ
Date: Mon, 12 Aug 2024 05:37:22 +0000
Message-ID: <BN9PR12MB5257B07321FC99BBD95DB0E4FC852@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240812032221.29060-1-Hawking.Zhang@amd.com>
 <12589748-95c7-42c4-9670-31cdf499a18a@amd.com>
 <BN9PR12MB52578F3FEECB00427FF010B5FC852@BN9PR12MB5257.namprd12.prod.outlook.com>
 <758aadf9-1719-4cc6-8c72-6db43623cca0@amd.com>
In-Reply-To: <758aadf9-1719-4cc6-8c72-6db43623cca0@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=70218f38-04f5-4343-bd63-54ad367d8eb1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-12T05:33:08Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CYYPR12MB8891:EE_
x-ms-office365-filtering-correlation-id: 0d02d8f4-28ed-4a78-3295-08dcba90d6da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZE5hOC9LbDR3OUdsL05WR2pqQ2hoT1phbVIyZ3lvSmR1VlZZelNvK0pwOWkz?=
 =?utf-8?B?cUxYdzVhN0J2T21WRFcwTFpXV1pacGp6NWxKRnZ0eGFuMGt1dUVFU2hLMkNQ?=
 =?utf-8?B?LzltMXFNeThwYzR6azhyLytQbFRoZFluMW5mazFoTFpnbWY2a3ZoRENMSzE1?=
 =?utf-8?B?Q3oyZHI0YmVGQk5uNDhyaEhLSHAzcEYrRGVmSHNhbks4RGNrT0Jvdk9uUkh5?=
 =?utf-8?B?KzBsb3J4U1hWak1tK2RaQ0dYaWd6Q3djQWxVN3IwcGNLTTYrVWlnVXVjQXdC?=
 =?utf-8?B?cXZ3dXZpWUk2RWhKektBZ1hFVEhFZHVBQjFxSVFGZTBtajAxN3NxUExkbWo4?=
 =?utf-8?B?ay9uN09ZclU4VjJGR2IrWjBYcitQendwWDBEM0JSelltUjNvdHUzTjVpTFB4?=
 =?utf-8?B?SHl3RVVBY1lZRFJ1TFc4TVpzMmhHUlpRZWhpUkhVdkM3bTF1M3k3MFJBa3B0?=
 =?utf-8?B?ZjJRdjhoSGNFRk83dlVIRzdKNjh6c2psZW8zT0FJQ1ErbytkREdGV21kbklR?=
 =?utf-8?B?cjlQUVpYcll6WGc0bWMvVVljdUdWUU1mM0d3UXl5cVZ2YngwNG44Q2liV2h0?=
 =?utf-8?B?S2dvUlp6bXZDSkgrYkNrOFRkUGw5VHF4TGRTbHlXYnRBa1AyKzlBeXdGWGt4?=
 =?utf-8?B?Rk80V0NleUhyNGN5RWxnVmpCb3NVVVViYXFadlFJQmxseHlxMXlwUjZXSW9j?=
 =?utf-8?B?bE5XVGRXQnJpb1kyWjFwYlprenl3RmJHU3J2amVYVTJ6c21ESmpKcUdKT0Va?=
 =?utf-8?B?MUNQZDVCVFpRZW8xSUZFdnZnOXRhNTBxb2wySlQ0UTFzU1g1YkxPbGhoZzdC?=
 =?utf-8?B?WEdJRE9aUExFYk1idU85NEl4NmpZamtXSkRKN2xRb0tuSzdvSTNSK29OSUQ1?=
 =?utf-8?B?djNYRW1lZTRQelJ4Z2gyUXJSbEprTXRnVGZNbjFDVG04cm5zTlp5bVpnOEN3?=
 =?utf-8?B?b2JyWGljMm5TQytOZ0ltMlYwQjJKSUkyck1jenR6ME1tR2ZOWnk4NGJmalJY?=
 =?utf-8?B?MFF6TTcxakY5d0szWWhVUW84SHRFWGp3a3hzT0JqcVFtbldhb3IxT3YyWGxk?=
 =?utf-8?B?Y3pKamxQSTdMVENNdTN6OUw0TlNEWjI5ejFibzEyZDc4UUZTeHZVNVpTVjVC?=
 =?utf-8?B?aURDMW5TNXR1ZFNUL3N2UGticjV5QkNHL1k0UE5Hc2NVWGE2RkIxdVQ3MzZx?=
 =?utf-8?B?YlpJUncyckh5SlE2RWI3WUJGSG9lY09JOEszam9SYkFGbUUwZFB5SnJsK01n?=
 =?utf-8?B?L0tvWTU5STVpbGwwdXVPdktZRWZQY2t4YTQrSE5sazM0VWw3NGRFOUU2Y2xh?=
 =?utf-8?B?b3duM21RVTNkOVpzWWxFU0pSUWNBSWJhTnVFd0xCQjhMZVBXUnRBSEJYQlBX?=
 =?utf-8?B?bi95NSt1d1N3dko5Uk9WTDdQdDkvYjRGM3ROaENyZmFCWWpIYUswMExDa095?=
 =?utf-8?B?cnE0N2NRWUJiNlNTeHNLTzlKMW1Tb2NhbTFsTW1CbGhzNXZydllQVW1qZ0VG?=
 =?utf-8?B?RmM3Y1k1NmVSdkdjSkdrVkQwSTI5WHNuNG9VN3Z0N0NvS0NGRzlWdjd2TEZu?=
 =?utf-8?B?NWlKVEE0ektuWVlwbXA4ZVlWSm9Eb2s2TnoxZDVWNnkyNDRQWGhFdlpBNy9I?=
 =?utf-8?B?bXF3TXpBTDAxbnpWOCtOWUtObXVHazhTN3AxanArbUw5dkUvN05yS1NwZ1NZ?=
 =?utf-8?B?enkwVkN0RmpzaDlQcStCaUNuNWtZRC9ncW0vUkZzcFF4MnllL1NmamMxVEdL?=
 =?utf-8?B?Y2NiRlhkQnBaL3FxT0JSNXExem1aVG5sbXkrQzIyVzNKTTJWakNwS205VCtw?=
 =?utf-8?Q?C8hCoNpdpb4kbxAHHT69jzRkXWtWM2UZmdwcg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWl5SXZYaEFoQUlSbENqRUdkYzBxNWJTUzlkTHl1UzFlMmM5a0hDN0U0UUw1?=
 =?utf-8?B?ZTBjRU5JaFRaYUFaOE9rbndUcXF3SHU2RTFUYjlISmlqTFlSd1lYcGNFNkMw?=
 =?utf-8?B?N256aFppTXFHT3pwMi9LTW9vZWtYU3NIc0ZVZlU2NTNSY0d2eVA5TE9vNDBx?=
 =?utf-8?B?TkQvNHQ4azFYdkxyemYxS0M3cDZIbjQzUFAzQUhWOVZoU3J5WTByK0loaTNo?=
 =?utf-8?B?MFVsSEZCTEVlekxhTHVDWndRb2MwdnBuZldodER6UnovWi9XVUpOaGQ4L2sy?=
 =?utf-8?B?UGxCVEtJSFdmclJQam1CYU9oa2xhcThHMzUzNGxGaEFBK2RodHN6djF6SEdM?=
 =?utf-8?B?MDI4VmZPTXo0WlZIWTFra0xiV1RrRy9Xck1Ic2RnZnBNMHNFYVMrYWxBeUhF?=
 =?utf-8?B?L1BVV3Y4d1dhYUxNS0Q0Ylk5RjQ1dGtqQlJpdTd5WEJTb3lCSkVtVEhFOUp3?=
 =?utf-8?B?a0had1crK2F3ZnVpR21NUkxudno1UUwvRjkwUjdyWXFScHlBand1bGZLN1pC?=
 =?utf-8?B?NngzYWpSWjRQWmhjQ3V5NWdDWjcrMlFSdWhRUzgwVG9BdWxudEJoMG54YkdM?=
 =?utf-8?B?YSs0R2ZmWnFXZkVIQjNLa1BYZ0xsYTlMNFVwRVB2ejdyUzR6V2FPVkF3VFds?=
 =?utf-8?B?RTJCVzNmbWE0cFVIclRZTEc0MFRCVmdnanB5TjdQbDhCKzZlSFdnbXJhS2lx?=
 =?utf-8?B?di9IWnMvd0N2ZUl0dDF4aTNXR2t4Rm1hMUo1aHlpSnhLVVNKaFVsQ3JybkJo?=
 =?utf-8?B?b2pTSm92WDdVTmtucFg3SkNqdkxkak5UNktmOUJqUzRIRTBSU0IwRG44bEc0?=
 =?utf-8?B?WEVOVDk4aEs2YzhEM2JUU05tMStCU0VuazJ3UDc2enR2YzVhVk5tcXJOTGFs?=
 =?utf-8?B?bk5SaEJ3bTFkNWQ0eStRY2lKcDZITTJPS2x3MEVHTWlIZmVjcGZXamQ5R3Ja?=
 =?utf-8?B?UFVCOTM3TXoxNzg0VmVSZjVLYlZsbmV3R3cwaEhEMlo0M29mTkVla3RHQWVn?=
 =?utf-8?B?d1ZTa0Nzck9JWjBaWHIxcXY5ajcrUjlNcGtWU05jRm1OYnBrQ1lSZmMyZWVQ?=
 =?utf-8?B?dGkrYmc0bG5PQXRnOXpkMEZTWFZyWHVmZml3c1MxNEcvVFZ1WWpOQmlwbkpr?=
 =?utf-8?B?QSsyQUpwUWVaa1llOXpFRzUvd1VJQUF5VUM1azMwdnRqUEVWRE8xa1hHV3dL?=
 =?utf-8?B?aUxqb2xXbXBtR0ZOdmdxSlJ1alJjazQ0TTZUSGJyOWJPeDJoZWhXQ3htSEVS?=
 =?utf-8?B?WDVUT1d1RklpYW85QmNocmsvMzQ4TEZsSlYrUUt4a3Npc3d4QVg0MllISmNa?=
 =?utf-8?B?SlpORGdqWkJFRlFWdlIxWFRFczQxYXRjTHRuVnlSVy8zbzltSG9TMzFsbXJQ?=
 =?utf-8?B?Ykx0UUV1NWFwMDM1dG9DZVJnZWZNYjRGOTZ0V1hsczVJZFF2OTJvK1hESm1o?=
 =?utf-8?B?SzVxaUx2U2lkeUZmNTZkUDhSWWdraHVyKzQ2Z3RxYVNXRUQ0aTJEYVNhazk5?=
 =?utf-8?B?NkJhNXdNZHptUGJRbXFaYnJ5UTBLMWZQSUx3QmlPNFd1ZTFRei81c0xjeDJV?=
 =?utf-8?B?eklUb3R6UGJLemVnVGRTNFVWTnRmdlIrbGE0ZDkzdU1iUXpmcFFRazFQOTVB?=
 =?utf-8?B?U1phRWV4WHhQWnBtN2ZmUVhPeU5VNHlocmpNalQvdjhXeWc3ZmVIaGsvc2Ft?=
 =?utf-8?B?Y0s2NS9wUThxWHJ4Z1dtMVROWGFCdGluQ2ozNmo0SUNTYUNPWk11TGhYY0tI?=
 =?utf-8?B?cFp0K25rZTlZZDFGTzJudjNCZHNSUGI4K3hUc3J4cjhNQTFFNTRJcXBkUmsw?=
 =?utf-8?B?YlhpckU5U1lzMGZ0TWxHN1dCTVk5YWRkNFJ0WTJyS1hiVklOcklQUzlEc2Jn?=
 =?utf-8?B?WXFIYXcybmtRR2p3K0l1OTB6Q1dHT0Zqa2EvUXlEbDNqRlFHYzJmWDFNV0F6?=
 =?utf-8?B?TzRPRWRsV3R6a2liOFpEZmU0MmZ6V3lBZ2pSaG5SaklDUDE1TnRqbFI1UllM?=
 =?utf-8?B?VHpOS3RJbzVlU1gwZGVQc0l5VmlMRXcvbmdtTFBoYnlXclFQazdCUWZ3SFli?=
 =?utf-8?B?NmdiYzFoYUwxN1I3TzJCSmdhdVk4aTh4cThTdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d02d8f4-28ed-4a78-3295-08dcba90d6da
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 05:37:22.1990 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hImByl9Sq/alE6vl3jKjcYUI2cpiZfw8UwgAvc4CxA/mGzLCsCBrhVZOQjPcOBH7dB1HOFH6Dt+3L0GHNkaM8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8891
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
Cg0KT2theSwgcGFydCBvZiB4Z21pIHRhIGNhbGwgaXMgYmxvY2tlZCBpbiBndWVzdCwgdGhlIG90
aGVyIHBhcnQgaXMgbm90LiBUaGVuIGp1c3Qga2VlcCB0aGUgdGEgaW5pdCBtaWNybyBhcyBpcy4g
d2lsbCBsZWF2ZSBwc3AgY2FsbCB0byBkZWFsIHdpdGggdGhlIGRlbHRhIGJldHdlZW4gcGYgYW5k
IHZmLg0KDQpUaGFua3MgZm9yIHRoZSBjYXRjaGluZy4NCg0KUmVnYXJkcywNCkhhd2tpbmcNCg0K
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFy
QGFtZC5jb20+DQpTZW50OiBNb25kYXksIEF1Z3VzdCAxMiwgMjAyNCAxMzoxNg0KVG86IFpoYW5n
LCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZzsgWmhvdTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BB
VENIXSBkcm0vYW1kZ3B1OiBEbyBub3QgaW5pdCB0YSBtaWNyb2NvZGUgZnJvbSBndWVzdCBzaWRl
DQoNCg0KDQpPbiA4LzEyLzIwMjQgMTA6MzUgQU0sIFpoYW5nLCBIYXdraW5nIHdyb3RlOg0KPiBb
QU1EIE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0K
Pg0KPiBZZXMsIHRoaXMgYXBwbGllcyB0byBhbGwgdHlwZXMgb2YgVGFzDQo+DQoNClByZXNlbnRs
eSwgd2UgaGF2ZSB0aGlzIC0NCmh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibG9i
L21hc3Rlci9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfeGdtaS5jI0w5MjUNCg0K
d2hpY2ggbWFrZXMgdXNlIG9mIFhHTUkgVEEgY29tbWFuZHMgaW4gVkYgbW9kZS4NCg0KVGhhbmtz
LA0KTGlqbw0KDQo+IFJlZ2FyZHMsDQo+IEhhd2tpbmcNCj4NCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2Vu
dDogTW9uZGF5LCBBdWd1c3QgMTIsIDIwMjQgMTI6NTINCj4gVG86IFpoYW5nLCBIYXdraW5nIDxI
YXdraW5nLlpoYW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgWmhv
dTEsIFRhbyA8VGFvLlpob3UxQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRybS9h
bWRncHU6IERvIG5vdCBpbml0IHRhIG1pY3JvY29kZSBmcm9tIGd1ZXN0IHNpZGUNCj4NCj4NCj4N
Cj4gT24gOC8xMi8yMDI0IDg6NTIgQU0sIEhhd2tpbmcgWmhhbmcgd3JvdGU6DQo+PiBUQSBzaG91
bGQgbm90IGJlIGxvYWRlZCBmcm9tIGd1ZXN0IHNpZGUuDQo+DQo+IERvZXMgdGhpcyBhcHBseSB0
byBYR01JIFRBPw0KPg0KPiBUaGFua3MsDQo+IExpam8NCj4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBIYXdraW5nIFpoYW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+DQo+PiBSZXZpZXdlZC1ieTog
U2hpd3UgWmhhbmcgPHNoaXd1LnpoYW5nQGFtZC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9wc3BfdjEzXzAuYyB8IDggKysrKystLS0NCj4+ICAxIGZpbGUgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjEzXzAuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3BzcF92MTNfMC5jDQo+PiBpbmRleCA4NWVjOWUzNTY5MGEuLjc0OWQ4MTQz
YjFlNyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3BzcF92MTNf
MC5jDQo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9wc3BfdjEzXzAuYw0KPj4g
QEAgLTEzMiw5ICsxMzIsMTEgQEAgc3RhdGljIGludCBwc3BfdjEzXzBfaW5pdF9taWNyb2NvZGUo
c3RydWN0IHBzcF9jb250ZXh0ICpwc3ApDQo+PiAgICAgICAgICAgICAgICAgICAoYWRldi0+ZW11
X2ZsYWdzICYgQU1ER1BVX0VNVV9kR1BVX1NJREVXSU5ERVIpKQ0KPj4gICAgICAgICAgICAgICAg
ICAgICAgIGJyZWFrOw0KPj4gICAgICAgICAgICAgICAvKiBJdCdzIG5vdCBuZWNlc3NhcnkgdG8g
bG9hZCByYXMgdGEgb24gR3Vlc3Qgc2lkZSAqLw0KPj4gLSAgICAgICAgICAgICBlcnIgPSBwc3Bf
aW5pdF90YV9taWNyb2NvZGUocHNwLCB1Y29kZV9wcmVmaXgpOw0KPj4gLSAgICAgICAgICAgICBp
ZiAoZXJyKQ0KPj4gLSAgICAgICAgICAgICAgICAgICAgIHJldHVybiBlcnI7DQo+PiArICAgICAg
ICAgICAgIGlmICghYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKSB7DQo+PiArICAgICAgICAgICAgICAg
ICAgICAgZXJyID0gcHNwX2luaXRfdGFfbWljcm9jb2RlKHBzcCwgdWNvZGVfcHJlZml4KTsNCj4+
ICsgICAgICAgICAgICAgICAgICAgICBpZiAoZXJyKQ0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIGVycjsNCj4+ICsgICAgICAgICAgICAgfQ0KPj4gICAgICAgICAgICAg
ICBicmVhazsNCj4+ICAgICAgIGRlZmF1bHQ6DQo+PiAgICAgICAgICAgICAgIEJVRygpOw0K

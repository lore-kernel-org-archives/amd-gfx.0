Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8045CC83F0F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jul 2025 09:28:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F30C710E5EA;
	Tue,  8 Jul 2025 09:28:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sgmlul3U";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 826F510E5CD
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jul 2025 09:28:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYg8+wzVfxdZkstVqLH5VPXEtMhMtJdELq2Qe8i89HNf0dLWCTzyDUqT1bUP48sck1pLu8xSyKvOn1CBFBeQJxxaMGep9/4H0A/xNvbVGHwCjALqZh6zQddf7F8hXnnoL1yrSbnolMfkVaKix91C/ECs7/wHqhHMjpIeuVGmeppdauuSQ8ScFbvVjXdRy/fa559H66xZCfVYLcUjv55ATTS9GeApe1KqJLpGMMiGb7XBh5tPNh4wwfQWsAh5wUScMBIFcCTZt7QpserdIC1RGbHeyY5uydcDJXMK0P/P1q8m2El5TucGSWUVxhkHhreEAUxbsHpd4nzhJTwiyJN3Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vpoxoU5rvW8KUkMEk81TfkGqBKzLpVbGBZm2luohOYQ=;
 b=tRnr0LFNgfeEH4yqVlVBesdzGomhnCiutHpTfDI/QqOTOUMP2UQWedPUxbtekAXuD7VVWSv7QIght7cOdfNFxrcYAN1RoySTdo9i7QJvZ1gQ8lxkiMF5Wd2LTBpvXSS99X8dBgNbNRy3JT+2Q80t/UQBpxJL5ryRSQ8+0Je+MSEYvmvYcg008JtaFGPOqxhVMBRQsAEW5BuY6MUUAW3LI8iSZWbJTcSwZ8cKqJUnvyu1hx9SBNlApN4OprSi53EV9wjyEmblRpPCqYukZ8OLUxK4lXA49WpKz1PjnjtbbSt5RpPHkWDz929GNNazk1GQLcYYuoEDxsBqvMWKMlo1Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpoxoU5rvW8KUkMEk81TfkGqBKzLpVbGBZm2luohOYQ=;
 b=Sgmlul3U5A+KjMom88O69P2p3jdG+YoVPXPA83DZBGhW4NO9p5/qXxkyD4wCVFBYlB8kWjQEtWEni2+OWF8nGuq9WZqw/etjW7wNBcOyqpr0I1V/QkG+tRUz1m/LUXAbzHUTolmlvkxdhdEqXKc4rhrR4A0Y6etcrTDoEpV+BKQ=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 LV2PR12MB5727.namprd12.prod.outlook.com (2603:10b6:408:17d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.28; Tue, 8 Jul 2025 09:28:04 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8880.034; Tue, 8 Jul 2025
 09:28:04 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v5 8/9] drm/amdgpu: validate userq activity status for
 GEM_VA unmap
Thread-Topic: [PATCH v5 8/9] drm/amdgpu: validate userq activity status for
 GEM_VA unmap
Thread-Index: AQHb7M8aqkYROR0HkEC2wXfkwmq5AbQmbUyAgAGHfEA=
Date: Tue, 8 Jul 2025 09:28:03 +0000
Message-ID: <DS7PR12MB6005768B9C3E32317F7F8779FB4EA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250704103308.1325059-1-Prike.Liang@amd.com>
 <20250704103308.1325059-8-Prike.Liang@amd.com>
 <ec6cded3-daa2-40c2-91bf-4686e8a03e7d@amd.com>
In-Reply-To: <ec6cded3-daa2-40c2-91bf-4686e8a03e7d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-08T09:03:47.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|LV2PR12MB5727:EE_
x-ms-office365-filtering-correlation-id: 42f0a667-d347-4383-6246-08ddbe01bd7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?Uko1bk11eExTcFZKVHpqRnFDNnd6dk9vM0VVQ1JJbloyVjFkWCtUeFo4bjYr?=
 =?utf-8?B?bWZtNlAzUkF2UzVIWHVGV2hMNmpoNXQxN21paVFNSGJPT25YNnBFK01yL0g5?=
 =?utf-8?B?MzlvNmwzTUw3R3BWQ3pxejN0UGdmSEdGTHlXZXppaStaRGhKVU05MXBXMVl1?=
 =?utf-8?B?citCckg3ejRWYXhDUStyN0V4ci9tcWpWUi9oa0JvcGVxdVVtZEkwL0FxUW54?=
 =?utf-8?B?aTgrbzJuc3BrcHF2dTFKM3ZOOGRwajJTMkFWM3pSelJlWVJ0WjloMHhsRzRX?=
 =?utf-8?B?aUt4elFvYUw1ZCtNN3ViVFVtcnNzRlVhd3BFcWhxNS9LK0U5MGZOMmJLQ3Ba?=
 =?utf-8?B?ZjYyTElMc3dJMjQ5WE5JT1FyMVdLZ1lLYWJ5dmw2a1RmSVl1aVZQcVRTUndZ?=
 =?utf-8?B?eHFsL01iZExWTlJ0a2VmRXJjaWhtSk9WOVcraHdOeEJWQkVucVFwTzdHZjJX?=
 =?utf-8?B?UndFRkEzZ3BWcEFjZFczMG93T1FWSVdqOVEwUzRWQkkzV0hlZndpRnYyRGc2?=
 =?utf-8?B?amJrMXp0MHowbHppcm1JN3lHdDdZZklrNmRyeU9PYUVMdHFqUDcySEZHVEVq?=
 =?utf-8?B?TzBpWjRvVGlkZ2MxZWtFRkQ4QUEvbWU0cnF1RFVFM0Jzd0c1T3lBQzlWSnd1?=
 =?utf-8?B?S1pLOXE4dE93QzlkMWRjd0JCQ3RNT2RqM0ZyZTJsaVdGMHhGRlVBbllNN1Rk?=
 =?utf-8?B?VDFPQ3ZaK3hiZzhieUlub3VSSDBHQ21jTDVrbWJBb3RGb2JTYmh0ckN1U3pG?=
 =?utf-8?B?WE1WODJIL2VtY3k1L0xKTklrUERocVRZWk9OSE1JaWhxZjU3R3VWT1NvM2dp?=
 =?utf-8?B?QTZPYVRhU0Q0eExoaDNzSnptZUJ1WkVubC9wNkVaQngyRVRmL01PTTg2ZUti?=
 =?utf-8?B?Q25QVnhhMUtlZEhjZ1ovNEMzTENzQnBCRDRoZUV1aitWNXJreVdWOTNWWjZa?=
 =?utf-8?B?V0MzcUlqVDhJTHhydFFXeGVvT2MxQ2dGTm0vUXViTFkxTURZNGlrQjFxT3ZP?=
 =?utf-8?B?dmpvWVV4UWFrZXlsK05xbWJocE4zVSt3SklrZGtXQkNpQ1R5RHMvcEd5ZW85?=
 =?utf-8?B?QmpjOG1zbFhyM3MwVGd5MU84NFRJY2tuaU16UkZ6bmpTN1dXWmVyTlBwL1U1?=
 =?utf-8?B?WWhabXhxcHVnR2FTK3NYVFNna1J6ME9zVXgrTit3ZXJiSnlCanJ3WW1lR0U5?=
 =?utf-8?B?OGMwTnBjaXZ6bzVoSWhnbUdRWEw1NVZJaXNadTBzcXdCUWpzWjhsVXcvU2Vy?=
 =?utf-8?B?ZHo0Wm9TMWNuVVRtWmFzRUdYUzhZOUJqSm5nTFhENkVSRmVJd2YrSDNxYk5L?=
 =?utf-8?B?R05YL3ZudVNJZ1hFY2puYXRQT2p0dlY5Mk9UZlk0cU9lTW1BOGlud3Rha3Iz?=
 =?utf-8?B?K0E5MUxBcmVrTmpYZ00xc0JUNlIzY3dPaG44ZXlTVmxPVHNFU3QzbTdPMkFH?=
 =?utf-8?B?RnB0d1lmYkdwUDRweS9Td1BHdTFxZUJYaDVNbFc4UGZVbkw0ZE1jWDJiZU8y?=
 =?utf-8?B?bTRPdncweUJJS1d2ZVBKbWZNMDQxYjRzZnFmRHpLTWtEZEl5U28rWElsdHcx?=
 =?utf-8?B?VHQ3eURUb0ZwMDRocG9hTnlKdG1pdUZ4dWxDUTR2UkFnaXdhSHBHV3Q0eEN6?=
 =?utf-8?B?UkVGUTBmQytod0pBK09SRmNRVU9lU0VWeEV1UE1HV01CelZkS1NKajRYZGFM?=
 =?utf-8?B?OWduZG13QTg5eDh1MFAzOTB4NWlMc3BvTVZGdEpsMTFvVzlvb2k4Sk1GSDYw?=
 =?utf-8?B?M1NDSUpKNy9sbkM3NFZJd2xGbXRnT0VkN2p6R3R5aWwzWkVvc0JaRUhOOG03?=
 =?utf-8?B?N3pBNkh1QlRybndIRWxlYjJWN1RLRk9uSHgzU3pUS2JpcTBwYmVRbUtWeW8z?=
 =?utf-8?B?R3lvbnhxWlpkc2c5T0lLZTlFZnE1Z2g2bVlxZHRYRzArb1BLRW9XaGt5STNG?=
 =?utf-8?B?bEdUeUp3WWtUQUorQmQxaTkwZlZjK29FdzduQmt3SDJ2VjJQY2JhNFE3Zits?=
 =?utf-8?B?aENRbXF2UUFnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ymg3V04rYjZaVGhEVXBXNTltTEJpRGR5b2lYa1kzM05jaW5iWHZZeTZDd01a?=
 =?utf-8?B?czNlZVdRTjU1bTdPL0RoWldxTEJCWUlhNWsyMTJjTHc0NzVjTTJVeDhKV3hK?=
 =?utf-8?B?TEc2QTF5S3VNTGNUQ0tCSzV4dG9leEZ6SnByR0M1SHNjcTlNc1Y0Vkl1OEVi?=
 =?utf-8?B?VVdzU1hXQTRZa3orYjIzR24rKzd6WW9jc0xOWkwvUTNPempSSmt5OWxZUEpn?=
 =?utf-8?B?WmoxV1NSVWtBcGdrS3ZCOVFYcHpFVHlUMmtCRG93K25RNlZUNkNyM0J3dEU5?=
 =?utf-8?B?YzZxd2FmZ3FBZ0pOL3AxMlZnSGN1L0NDQncxUFpwNkxabDVBN2pJK3hIYUdX?=
 =?utf-8?B?eVNERUxZTVpRR0ViOWdYcXMyTkZkQ2pXd2pUZFBRSGFkQ2JEZDYvWHFpajZC?=
 =?utf-8?B?MUhGNVpNSUVjdGNGYmVaaUFrNTNpSzBVZEd0bUJlcG5jZWd3SDUxUHE3cHJL?=
 =?utf-8?B?UW1meTloUUNXbThoUWs4bm8rWFFtNStkenB2dWhiVUJOSVFwNUs2aVlwdW9W?=
 =?utf-8?B?TUR3SGVQdE1Dalo4ZnYvZHArQ2JVYUprZUxPMVFxUGRnaXYvY28vK3ZLQ1VT?=
 =?utf-8?B?VHBITlZUQ1dKbGs0ckYxSlpmTHg5SDIxS2xZWVVQbGozUW1RUlMyOHNRTm16?=
 =?utf-8?B?dC9wYWdjQTMwblB5TEdsRHRBR2JTU29sV1BUNGtFY3ZZUE5ZaTY3WTdjY0Fq?=
 =?utf-8?B?bklOZTFWZHdFOG1ISmpmTnFFZ2NzU1F5ekdPNktjRHMxa211UHZJODUyOFIx?=
 =?utf-8?B?UnpCY0U3djFIM0RyWThCVUI1RXZsang5dEw0T0FjRE1ydWtJQ1BTV3VSZ0py?=
 =?utf-8?B?MHVpYm16ZVVGK0xCM1Y5OWlqUHc2OCtVcHB2cEEzekVkcTNLbFVqdjVSWkox?=
 =?utf-8?B?QnA0dGxSak1BcWdOaElOcUhycTVKaDJhYkxVQXQ5b2w1YlB4aGw4aFRDVjVs?=
 =?utf-8?B?NFFmQkhvRnBzM2RtT2J5MmJmek9KTHhML2Nsa2VpK2F0blA3VmtuUlZmU0hC?=
 =?utf-8?B?YlZoUTR0dGJyajFkdURQN2ZOaVcxa2lQMHhLQy9TOUNWdWowS1d5ZWhnQWIx?=
 =?utf-8?B?L2Rkd2ozejlUWWJEdHNyV2w2QnRzb0xFblpjTGZnYTdHM0piYTZyQVl5cGhV?=
 =?utf-8?B?bnpleTFrdzVRQm9jMHlsTGh6dlBxZ1JIVzlTb0hQWkxyYmhlZXhBM0dDNks5?=
 =?utf-8?B?TnVTWHNGTU52czB6ZFI4d29Sa21HTmxtZFhDZ2dkcGlKLzdqalk3ZkRBSVUz?=
 =?utf-8?B?a1REK1I2RFhUMjl0MnE4bTR1QnlWYzBoclJ1ZmNUZ0xTWVpWaTJkNkN5RnlW?=
 =?utf-8?B?T09vbWtaT0N4Q1JNcUJkNHFXckFKTHJ5UXM1MVhZcCt5azRJaGVld25BbWNz?=
 =?utf-8?B?Y2FrTWMzd3ZValo1b3NkR2krTTRTSDVIbWVROUs5WlpITTlBY25KRlQraDBV?=
 =?utf-8?B?ajJGTmQyNFVyQmJXVFh5Ni9jL29hTDQyaXE0ZWlhVVcyckVFRGNGeG1XZUlH?=
 =?utf-8?B?NTU3ekdZZzJlRU5xUHgxRDFJWDFJalpMdEVkZ1YyRko0eTR3VUp1RS82dTBY?=
 =?utf-8?B?NHJUaHNReU5NV0U1c1hITVFweDFTeVQyajRHNlNENUhSeUtLdytvZlJKcmNI?=
 =?utf-8?B?bnVIOVdhdHRYMmRveDJkd3NvRnBpVXUvOFlWdUlWR1U2cENJdm1laHpJNHM2?=
 =?utf-8?B?cXlmRWh3MHdYcmZaN01WTWVTbkRoNm9jZ3R5T3NpVi9BdU80Y2JKTC9tODJJ?=
 =?utf-8?B?NTlDWDB4SktYUHlwV1M5RGdVZEJVQWVSbksrTHp4VkdGQk1BTTFxcEVmQ1lE?=
 =?utf-8?B?K1FlaUF2ZzVJdm1mdkxwUE1nNHdtZ0Rrc0VmQU1NVVhEY1pBSXBKd1ZMbVRB?=
 =?utf-8?B?Tk4vQy9CWTN0WkZ0c1pUWnBWK002NEdrZ0hxeXVQdEk2RllxREd5L3Y5N1ln?=
 =?utf-8?B?NVdDSE1vNW92UGJVWUt2RlFlM2dQajZkemRtUGNtdUs0NWs0N0tXT1JwYXNB?=
 =?utf-8?B?VWlSUjdTUWlTSGs2a3hoRUE0R1daelBRdXNrZjNpd0ZBdWl5SDBuck10VnYv?=
 =?utf-8?B?K0Y0Q3ZneExydkJxZVB2cytEaDFwOWpybFNWWU5PWWxvVlFSeUZjZ2dnR3h4?=
 =?utf-8?Q?OyRg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f0a667-d347-4383-6246-08ddbe01bd7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 09:28:03.9055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DAhUl++dw3PjXuhNzfRytTh8hn2L0pPMVyxy4eu9JsPE7zYZsdEOxCjYFDX/Nnzx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5727
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

W1B1YmxpY10NCg0KUmVnYXJkcywNCiAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogS29lbmlnLCBDaHJpc3RpYW4gPENocmlzdGlhbi5Lb2VuaWdAYW1k
LmNvbT4NCj4gU2VudDogTW9uZGF5LCBKdWx5IDcsIDIwMjUgNTo0MyBQTQ0KPiBUbzogTGlhbmcs
IFByaWtlIDxQcmlrZS5MaWFuZ0BhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4N
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSA4LzldIGRybS9hbWRncHU6IHZhbGlkYXRlIHVzZXJx
IGFjdGl2aXR5IHN0YXR1cyBmb3IgR0VNX1ZBDQo+IHVubWFwDQo+DQo+IE9uIDA0LjA3LjI1IDEy
OjMzLCBQcmlrZSBMaWFuZyB3cm90ZToNCj4gPiBUaGUgdXNlcnEgVkEgdW5tYXAgcmVxdWlyZXMg
dmFsaWRhdGluZyBxdWV1ZSBzdGF0dXMgYmVmb3JlIHVuYW1hcHBpbmcNCj4gPiBpdCwgaWYgdXNl
ciB0cmllcyB0byB1bm1hcCBhIGJ1c3kgdXNlcnEgYnkgR0VNIFZBIElPQ1RMIHRoZW4gdGhlDQo+
ID4gZHJpdmVyIHNob3VsZCByZXBvcnQgYW4gZXJyb3IgZm9yIHRoaXMgaWxsZWdhbCB1c2FnZS4N
Cj4NCj4gQ2xlYXIgTkFLIHRvIHRoZSB3aG9sZSBhcHByb2FjaC4NCj4NCj4gV2Ugc2hvdWxkIG5l
dmVyIGRlbnkgdW5tYXBwaW5nIGEgVkEgYmVjYXVzZSBpdCBpcyB1c2VkIGJ5IGFuIHVzZXJxdWV1
ZS4gVGhpcw0KPiBjYW4gY2F1c2UgYSByYXQgdGFpbCBvZiBwcm9ibGVtcyBpbiB1c2Vyc3BhY2Uu
DQo+DQo+IEluc3RlYWQgd2UgKm11c3QqIHN1c3BlbmQgdGhlIHVzZXJxdWV1ZSB3aGVuIHRoZSBW
QSBpcyB1bm1hcHBlZCBhbmQgZGVueQ0KPiByZXN1bWluZyBpdC4NCj4NCj4gSSB0aGluayB3ZSBj
YW4gZG8gdGhhdCBieSBhZGp1c3RpbmcgdGhlIHVzYWdlIG9mIHRoZSBldmljdGlvbiBmZW5jZSBm
b3IgdGhlIEJPcyB1c2VkDQo+IGJ5IHRoZSB1c2VyIHF1ZXVlLg0KSSdtIG5vdCBzdXJlIHVuZGVy
c3RhbmQgY29ycmVjdGx5LCBkbyB3ZSBuZWVkIGEgbm90aWZpZXIgZm9yIHRoZSB1c2VycSBWQSB1
bm1hcCBldmVudA0Kb3IgYXQgYW1kZ3B1X3ZtX2JvX3VubWFwKCkgZGlyZWN0bHkgaW52b2tlcyBh
IG5ldyBmdW5jdGlvbiBvZiBjYW5jZWxpbmcgdGhlIHVzZXJxIHJlc3RvcmUgd29yayBhbmQgbWFy
a2luZyB0aGUgdXNlcnEgc3RhdGUgYXMgaGFuZyB0byBhdm9pZCBmdXJ0aGVyIHVzaW5nIGl0Lg0K
T3Igb25seSBkbyB0aGUgdXNlcnEgVkEgdW5tYXAgY2hlY2sgYXQgdGhlIHVzZXJxIHJlc3RvcmUg
d29yaz8gSWYgbm90LCBjb3VsZCB5b3UgZ2l2ZSBtb3JlIGRldGFpbCBvbiB0aGlzIHNvbHV0aW9u
Pw0KDQo+IFJlZ2FyZHMsDQo+IENocmlzdGlhbi4NCj4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFByaWtlIExpYW5nIDxQcmlrZS5MaWFuZ0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnEuYyB8IDE2ICsrKysrKysrKysrKystLS0N
Cj4gPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgICAgfCAgOSArKysr
KysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV91c2VycS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNl
cnEuYw0KPiA+IGluZGV4IDMwODM4ZTUyNzliZC4uMjIxMjkyYjY0MTdhIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycS5jDQo+ID4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxLmMNCj4gPiBAQCAtMjgxLDcg
KzI4MSw3IEBAIGFtZGdwdV91c2VycV9tYXBfaGVscGVyKHN0cnVjdCBhbWRncHVfdXNlcnFfbWdy
DQo+ICp1cV9tZ3IsDQo+ID4gICAgIHJldHVybiByOw0KPiA+ICB9DQo+ID4NCj4gPiAtc3RhdGlj
IHZvaWQNCj4gPiArc3RhdGljIGludA0KPiA+ICBhbWRncHVfdXNlcnFfd2FpdF9mb3JfbGFzdF9m
ZW5jZShzdHJ1Y3QgYW1kZ3B1X3VzZXJxX21nciAqdXFfbWdyLA0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgc3RydWN0IGFtZGdwdV91c2VybW9kZV9xdWV1ZSAqcXVldWUpICB7IEBA
IC0NCj4gMjkwLDEwICsyOTAsMTQgQEANCj4gPiBhbWRncHVfdXNlcnFfd2FpdF9mb3JfbGFzdF9m
ZW5jZShzdHJ1Y3QgYW1kZ3B1X3VzZXJxX21nciAqdXFfbWdyLA0KPiA+DQo+ID4gICAgIGlmIChm
ICYmICFkbWFfZmVuY2VfaXNfc2lnbmFsZWQoZikpIHsNCj4gPiAgICAgICAgICAgICByZXQgPSBk
bWFfZmVuY2Vfd2FpdF90aW1lb3V0KGYsIHRydWUsIG1zZWNzX3RvX2ppZmZpZXMoMTAwKSk7DQo+
ID4gLSAgICAgICAgICAgaWYgKHJldCA8PSAwKQ0KPiA+ICsgICAgICAgICAgIGlmIChyZXQgPD0g
MCkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgZHJtX2ZpbGVfZXJyKHVxX21nci0+ZmlsZSwg
IlRpbWVkIG91dCB3YWl0aW5nIGZvcg0KPiBmZW5jZT0lbGx1OiVsbHVcbiIsDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZi0+Y29udGV4dCwgZi0+c2Vxbm8pOw0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FVElNRURPVVQ7DQo+ID4gKyAgICAgICAgICAgfQ0K
PiA+ICAgICB9DQo+ID4gKw0KPiA+ICsgICByZXR1cm4gMDsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0
YXRpYyB2b2lkDQo+ID4gQEAgLTUwOSw3ICs1MTMsMTMgQEAgYW1kZ3B1X3VzZXJxX2Rlc3Ryb3ko
c3RydWN0IGRybV9maWxlICpmaWxwLCBpbnQNCj4gcXVldWVfaWQpDQo+ID4gICAgICAgICAgICAg
bXV0ZXhfdW5sb2NrKCZ1cV9tZ3ItPnVzZXJxX211dGV4KTsNCj4gPiAgICAgICAgICAgICByZXR1
cm4gLUVJTlZBTDsNCj4gPiAgICAgfQ0KPiA+IC0gICBhbWRncHVfdXNlcnFfd2FpdF9mb3JfbGFz
dF9mZW5jZSh1cV9tZ3IsIHF1ZXVlKTsNCj4gPiArDQo+ID4gKyAgIGlmIChhbWRncHVfdXNlcnFf
d2FpdF9mb3JfbGFzdF9mZW5jZSh1cV9tZ3IsIHF1ZXVlKSkgew0KPiA+ICsgICAgICAgICAgIGRy
bV93YXJuKGFkZXZfdG9fZHJtKHVxX21nci0+YWRldiksICJEb24ndCBkZXN0cm95IGEgYnVzeQ0K
PiB1c2VycVxuIik7DQo+ID4gKyAgICAgICAgICAgLyogRm9yIHRoZSBmZW5jZSBzaWduYWwgdGlt
ZW91dCBjYXNlLCBpdCByZXF1aXJlcyByZXNldHRpbmcgdGhlIGJ1c3kNCj4gcXVldWUuKi8NCj4g
PiArICAgICAgICAgICByID0gLUVUSU1FRE9VVDsNCj4gPiArICAgfQ0KPiA+ICsNCj4gPiAgICAg
ciA9IGFtZGdwdV9ib19yZXNlcnZlKHF1ZXVlLT5kYl9vYmoub2JqLCB0cnVlKTsNCj4gPiAgICAg
aWYgKCFyKSB7DQo+ID4gICAgICAgICAgICAgYW1kZ3B1X2JvX3VucGluKHF1ZXVlLT5kYl9vYmou
b2JqKTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQo+ID4g
aW5kZXggZjA0MjM3MmQ5ZjJlLi5jOGNkZDY2OGE4ZjIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYw0KPiA+IEBAIC0xOTI5LDYgKzE5MjksNyBAQCBpbnQg
YW1kZ3B1X3ZtX2JvX3VubWFwKHN0cnVjdCBhbWRncHVfZGV2aWNlDQo+ICphZGV2LA0KPiA+ICAg
ICBzdHJ1Y3QgYW1kZ3B1X2JvX3ZhX21hcHBpbmcgKm1hcHBpbmc7DQo+ID4gICAgIHN0cnVjdCBh
bWRncHVfdm0gKnZtID0gYm9fdmEtPmJhc2Uudm07DQo+ID4gICAgIGJvb2wgdmFsaWQgPSB0cnVl
Ow0KPiA+ICsgICBpbnQgcjsNCj4gPg0KPiA+ICAgICBzYWRkciAvPSBBTURHUFVfR1BVX1BBR0Vf
U0laRTsNCj4gPg0KPiA+IEBAIC0xOTQ5LDYgKzE5NTAsMTQgQEAgaW50IGFtZGdwdV92bV9ib191
bm1hcChzdHJ1Y3QgYW1kZ3B1X2RldmljZQ0KPiAqYWRldiwNCj4gPiAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiAtRU5PRU5UOw0KPiA+ICAgICB9DQo+ID4NCj4gPiArICAgLyogSXQncyB1bmxp
a2VseSB0byBoYXBwZW4gdGhhdCB0aGUgbWFwcGluZyB1c2VycSBoYXNuJ3QgYmVlbiBpZGxlZA0K
PiA+ICsgICAgKiBkdXJpbmcgdXNlciByZXF1ZXN0cyBHRU0gdW5tYXAgSU9DVEwgZXhjZXB0IGZv
ciBmb3JjaW5nIHRoZSB1bm1hcA0KPiA+ICsgICAgKiBmcm9tIHVzZXIgc3BhY2UuDQo+ID4gKyAg
ICAqLw0KPiA+ICsgICByID0gYW1kZ3B1X3VzZXJxX2dlbV92YV91bm1hcF92YWxpZGF0ZSh2bSwg
c2FkZHIpOw0KPiA+ICsgICBpZiAodW5saWtlbHkociAmJiByICE9IC1FQlVTWSkpDQo+ID4gKyAg
ICAgICAgICAgZGV2X3dhcm4oYWRldi0+ZGV2LCAiSGVyZSBzaG91bGQgYmUgYW4gaW1wcm9wZXIg
dW5tYXAgcmVxdWVzdA0KPiBmcm9tDQo+ID4gK3VzZXIgc3BhY2VcbiIpOw0KPiA+ICsNCj4gPiAg
ICAgbGlzdF9kZWwoJm1hcHBpbmctPmxpc3QpOw0KPiA+ICAgICBhbWRncHVfdm1faXRfcmVtb3Zl
KG1hcHBpbmcsICZ2bS0+dmEpOw0KPiA+ICAgICBtYXBwaW5nLT5ib192YSA9IE5VTEw7DQoNCg==

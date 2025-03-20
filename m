Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE944C35FFC
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 02:38:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 481DB10E314;
	Thu, 20 Mar 2025 02:38:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OJE6nxTc";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 205BF10E314
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 02:38:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjKepILh6ASNOxADVis+awGzlxUqRPfKHavAqaQiqunnUlA3RfBr8vWV2uz4aSwoZMPVt/E6vAwq0Tewj/wG2HlwFRCyBS1KzHsWrUciIjnXMnx6WN+QUsUF2P8dRRnDLRkdgtayAv47D8n1Z969bUxP9UIVzlufEzI21dGGadqK+KUIXhzl4gfqwiBQ0OWw9y4U+ujk0zB7mfWhrt3FR97dXTELqT0fmgzCH/CMBpb9BHW14V8LWYBgvwWvXjdiGQlKzzIKyWtVi4Ni2mWcGZT0zVOEVdU9GdilMTzsD84PNRzXedAIlOXG611Dkgv5fd7fGms1pcbAb3GB3uXf0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bt3S7Y5EHvIy+KwyiZfozIZIaN0YdR1m4K/A6AM5hJY=;
 b=j4prNbwW+MQOw6EF7tX8NNAaYgUbMItPayDEyiCLD64vxKIH7kZDTA7F2wBsweCT69xV5OM9YYyef7KvF2Jcuuy3MBQ5j3NreSNoXqn2vIWNVoF7SdnboL/HNAKhKLD+jGHMghtrNOWHDC/9hm96BTumt5gflOLy/+zXUqaQI/eoGbgediFwXcBbcB/kFa4JHjC7gkq64g6L/wUKpPTbFGkHT3AvbPUp5cTewQRmTAob2xm86u3bfLNiMaVRv8eYcGkCaxpKFNzAP0yLIIu8IQENfZZjSuohDU6Nn1RzTQV3IuooJgWhOUoX2CIPZDzAoH3/VittTOMn1IhmYuO1nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bt3S7Y5EHvIy+KwyiZfozIZIaN0YdR1m4K/A6AM5hJY=;
 b=OJE6nxTcCh72dqEi+iGLu4upd8P5K/LvzxBsEX82cF4beuafCZnB/Gb0/M0tnLJoIkrLeiZhe8dFn+H2rPItk4AvChMEwuFR+Gp6cMeuN70+Ji2ojgjkMQouu8g5KnFAXLGezqUDZ1dy6m65R8uX05gFoqQKFyFgoAr4fZXNEGY=
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 MW4PR12MB7030.namprd12.prod.outlook.com (2603:10b6:303:20a::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.34; Thu, 20 Mar 2025 02:38:19 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::db2e:f082:bb80:d1a4%2]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 02:38:19 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, =?utf-8?B?VG9tYXN6IFBha3XFgmE=?=
 <tomasz.pakula.oficjalny@gmail.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/pm: add zero RPM stop temp OD setting support
 for SMU 14.0.2
Thread-Topic: [PATCH 2/2] drm/amd/pm: add zero RPM stop temp OD setting
 support for SMU 14.0.2
Thread-Index: AQHblecZ0V94ASVXaE6Oa/n51BMfm7N5vn6QgACOugCAAGOFAIAAAdyAgACjA2A=
Date: Thu, 20 Mar 2025 02:38:18 +0000
Message-ID: <DM4PR12MB51657FD3B25C2F01340701B98ED82@DM4PR12MB5165.namprd12.prod.outlook.com>
References: <20250315201558.339913-1-tomasz.pakula.oficjalny@gmail.com>
 <20250315201558.339913-3-tomasz.pakula.oficjalny@gmail.com>
 <DM4PR12MB5165690B22C63D856BFFD7708ED92@DM4PR12MB5165.namprd12.prod.outlook.com>
 <CAFqprmyv+WXmBWwOa3uPuOkmLtrkfc7jEXquXEyb-Bjuni_jBQ@mail.gmail.com>
 <CADnq5_NV4hiQCHB7-YE=cN2NNS4AeHsnxntJfQ5a+iiYOaiYGA@mail.gmail.com>
 <CADnq5_OxT2qfxdPAg5=w1PeOBhQdCL-He2rBJOireSidBz9DKw@mail.gmail.com>
In-Reply-To: <CADnq5_OxT2qfxdPAg5=w1PeOBhQdCL-He2rBJOireSidBz9DKw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c0c4df26-3cd6-4204-9f6d-567edd8fe47c;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-20T02:35:13Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5165:EE_|MW4PR12MB7030:EE_
x-ms-office365-filtering-correlation-id: 1ca8b10c-0587-4447-8864-08dd67584635
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NSs1UlozUFhqSytlMi93cUIwWS9mUVJETkUrTVEvWmlZR0VBV2FjVlNDUS9T?=
 =?utf-8?B?WFA2MDdwMjFrelJ1cXk1eXJJQTlxQ3FqQURGRHc2Y2E2U2NBN3RZa1NBTU1h?=
 =?utf-8?B?SjFlSnJOb0lKcHVGWHM5UGNZRGpqNGdRR01aM3ZUTmZZK2xSaE9wL0J3V0Iv?=
 =?utf-8?B?OUpKZFZNUDV6NVdPZzBCZ3RRQ2Z4cnJ0N3JaejlPQnprRVZ0MXJFOFBLQ2to?=
 =?utf-8?B?ZUNJYjVnMXhScXdzcStCdXBGYW10STRkM2k4VkRqdFZML2F5OHl6Q09xRVVW?=
 =?utf-8?B?UEl4T0NadXVicGxnK3FSbDJ5M2VRK3BWalltcXAxU3kvQ0g1SkJnKytCcEda?=
 =?utf-8?B?WG1uZmRTNk5udGhnT1BWQlNlNGU4dDRRa2FlNGo3NU5ydmJVWGFvUS95Y09i?=
 =?utf-8?B?RUpQZFdZMHUwbm5SZWdxN29jUSt5R3ExU2VILzBTTjNGZWREUUFKa2QvZ2xX?=
 =?utf-8?B?ZEszRytkYmFjU2xjV0ZpMlhLRHd4M1ovenJSZmg0dDJSbkdlVVQ2MGtwZWZ1?=
 =?utf-8?B?a2dTSTZIbW9RUWJoa2kwd0FXMzZobGlldldaYkRQcTBQOUJLU2xXT2xIUWx6?=
 =?utf-8?B?amJyY3VIa0lpcVlBRXNvdHV4eWV6cnY0RlZwTjdyaGRhYnBIV0YzS20zWmtB?=
 =?utf-8?B?MlQzSzlPaEpndW41OEJtYWx5bGJZdlpOWFhaeTVtWDA5b2tydGFIakR0elRl?=
 =?utf-8?B?MmJjaUhLTEFManlyeFFzZEM2VTc4TFBKSWZLN25YVjhWN29hc3B1R2Y1S2tx?=
 =?utf-8?B?VXJHYzBYZ1Q3UXNpNmZWMW9SR3VoWVZDQUNScGxpZG8yd09aNGR4V3VEUnNU?=
 =?utf-8?B?WnI3Z01GOUZaU1FCcmQ1a1ZQenpveGZla1k1WXZRZGdDSHhWUi9IcGF4RmtQ?=
 =?utf-8?B?OC9yMVo0ay92REJJRmx3WWJMSnIwZ3hrZjU2MDh6Nk5tUVNPN2szc1RNbU50?=
 =?utf-8?B?eTJoWXlsaDhNVTcySmtMVnMzVEtsZHkrWFVmSWdZOW11YU9CODJBS1ljdTIv?=
 =?utf-8?B?U0laS2tGVC8rNElkcFZJQVN2NVUrYmhUZVlweVkyZ21jbHArRlpHakM2YktE?=
 =?utf-8?B?aXNrc2p1NFplY2RDU2tBUGNwOU4vak5ycHU1OHVUVGNORXVUSXR6aTBFVFFo?=
 =?utf-8?B?UEkxaWJ6ZDZRRllMYWordmg2c04wbmdqem5OdUtEQTh0Uko0ZDJtTUlCNDlC?=
 =?utf-8?B?a0JWeTJ3QVBTc0Q5SnFZUVFxWDNudXM4TkYydVBpVzhZUTBCb2RCRVhMdzhk?=
 =?utf-8?B?NFdGZTV1Y29YUTJyNE0wZjZWQWVLUkR3YU5pcE42OCtOek9PdFNrNU1kL3ZW?=
 =?utf-8?B?V3hpVk5mdktSSmt4ODIrVDQ3L0pYSFM0dGFLakxuam4xcDRTWi8rMHo3Zy8w?=
 =?utf-8?B?MTdEN2JNaysyV0lmdXRlWm4zcVRYSFpjK3IvSlY3bVVuUFJZV0lnWU1GMHYz?=
 =?utf-8?B?RkovaGRNTkFsMVRMSytPRjBTcVoxRjBmTmxFMjQ4YWlWWDBraUR4cTNXV01r?=
 =?utf-8?B?a1hackZHVkkyOHAvNnVvWW5BY3ZFL2IySHcvQkF4T1dXQUxacTZrbmk2aWN3?=
 =?utf-8?B?TDVuMFAzTGFrNDViN0RoQytZYXNITDF4TEw0Z0FUVUhKWEN3KzBMREcySEF3?=
 =?utf-8?B?MGJNVzJzWXk4MWdJcmFFR3ZGSjdRam0zSFd4MGVsTnZ0VHdEY3JQTUIxc3Zy?=
 =?utf-8?B?Y0tWU1VhbHFSektLQ1gva0NFekZZWkZIR2JwakhwKzRGcHM0SStINFRVelJO?=
 =?utf-8?B?U2dOZVdrSXlPTHl0U1QrQTU2RFA2RSt4Q0VDTUlpSXo0anV2bDk3cm9KUHZ6?=
 =?utf-8?B?d3d2TUVtc3dXZkRuU2xmOGp3ZGh4Vlk0L1l0Z0gyWFRPUy9oWVdHR3ltZ1JQ?=
 =?utf-8?B?dlNUNzFJbUFtUXRsNmx6WUR1YWpnejF2ckRhVUhaeEVCQVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vy9kY3Uza0FBek1jaytLMllxcmZXYXpPWXN1MGZrMDJOeWpuV0x4Q2NXVk1M?=
 =?utf-8?B?VWVyZHdUcjVMTmdaOVZZTC9iZS9OK1JidFJEbUxkK25ybnhDa1lGckw4ek1Z?=
 =?utf-8?B?alMzcnFHTTJoUnorRzFkZVFaV2puR3I1UnRjaUZGTFVjOWxWelIvMkltWS9w?=
 =?utf-8?B?L091UjNSMUtDN1F1aXVCRFJwMWhXcW5ua2d4OCtpZ1ZxYnRjL2w0akdvdmRi?=
 =?utf-8?B?RjBTbDhMb09DWnNtaW9XMFNLc3BkQThFYkNOOGNlTFN1RGpSeUk0MkcvY1Mv?=
 =?utf-8?B?NGpJU1l4eWFUTjF2MUVJV1ZsSE01WVA2aXlxRHYyd3ZZN2RZT3RwMFFPcTVh?=
 =?utf-8?B?dVZFRnpscjFHYW5nT040elBXWXNrVU5PRDg3VnJEbHMvNzZJZjN0VElCL2JK?=
 =?utf-8?B?d0c2d1FsWGI5U1RXN21ObVlGVE9WSHJJcHJxdFAybWFJQXFvZW5uWi9SODJ1?=
 =?utf-8?B?aG1kNGMrN1JHendGZ2lvbzFmN3J1RmFJY0NXZVorT3NiQkNScGd0NWg3ZXQr?=
 =?utf-8?B?a0ZEa0Y0TWE2ZnRPYmR5T2V3MFVjTXdNdmU3cEF6Z1R2TnBBM2YrRU5waTVu?=
 =?utf-8?B?RzdlSVFNRzA2Zm1YRTJsRG5SSHZXNUVMcllmL1hjTkNVYmwxOHFqd1hUbXB5?=
 =?utf-8?B?L3BaMWJ1dHBlSlU5eVlTMGd2MW93ckVLUXRvbVpRSGVYTDRvVlNWRWRKazRo?=
 =?utf-8?B?MUk5MnlPbUZ2S1VQN2V1Z1NIR3VXU1pNcHR6SlRXbXN5RFN4Qi9qTFVQK3Vo?=
 =?utf-8?B?RXJOaWlDSGhMQlBDZm5lSmxvOUQxcVZuK0kzTVlqcGhNWFdaeVlUVHp4V2xW?=
 =?utf-8?B?RXhKNGwwcVQvc3VPRkZSVEZsQXFsVGcybTR6Q2tXYkR2aTBlbmVWNU9rdTlm?=
 =?utf-8?B?OWw3eVU5a2U2Uitocnk2dnJkL1o2RFJaTVdHM0xqRDhRSm1ySkJOdEZ4UlJD?=
 =?utf-8?B?UW4veTBBcGxaQi9Nd0ZiaGVZT05qRFBpR2R4bG94NjB1QXBBSDRITHVMZGY0?=
 =?utf-8?B?Q2cvc0xZRlhMVU83NVg1L0RaeHNqZHFzMUczYXpyd1I0azM2SWJCWXZneGdv?=
 =?utf-8?B?Y2lsaW4reTcyZTcvY1RXbmpobmgrL01GT0hkRSs3czZjR3VUcGJBYkVLbUF3?=
 =?utf-8?B?bUxwL3pVVkNWQjkyTnVCTld5ZWZZcnpSZHBXRi84VEpJZ0lYSTFlMVE2NUpF?=
 =?utf-8?B?UWRiSDdaeUVvZkd6bTBFeTdnUDFQYzZkSTRxb3JqNXpIaEdZVnkrVXZiNWF4?=
 =?utf-8?B?Mm94VmpoZU5NRVNVbmI3OFB6V2dxZ0Vxb3lHWkdzY2U0YjI2T0JlT0puS1lt?=
 =?utf-8?B?NU1sZ2FtaW8rRTlIVGVpSTFDWFpGM0h4ODlHeDMwT1NZZTY2U1AyN0tTMUI0?=
 =?utf-8?B?SjFWM0Z3cjJGRE1zY2VIVTdLN3R2MS9MbFZWOGo3Q3RLa0ZETVlmcWlNNnlw?=
 =?utf-8?B?QWdINHZ5UzJCTDN3bTU3VGhIYUl2R1gwb1I3ZHV1NnZjajYyRkkvVEhlOVcv?=
 =?utf-8?B?SVlUZWM1TVZQZlNYeFJFWTNEajRhRnREYVE4bXhwbzJnMXpXYVp5ZWE3c3BO?=
 =?utf-8?B?QUYyVTlpWFMrV0pzeXI3dDI4V1dHdjlhZS84UkhHNE93Zy83dnBLTVpiNG95?=
 =?utf-8?B?UjB6VDhtVUlaRHRxRWFMQmUrRDhZcWpWTGwrRzJKSlp3TmxwQjhXdUsrSm5k?=
 =?utf-8?B?a3JlclNyU3FLMG9lblZGU1ZBMGM3OWJtUDM0RmN1WDRhS01XaU5Jc0Z4b2FC?=
 =?utf-8?B?dUljNDl4SEtCTkZINVAwbXVPSlIwSnREMVpiUmhPckZJbWFRVGF2bjBFVGha?=
 =?utf-8?B?S3FjcC9GcTJNQzI0OGM1UHd6WUtxUnVnYWZEenUveERjc3Jxa0pQMGRYcWx0?=
 =?utf-8?B?cVdUZFkyajFUbm9nK2FDMENaSnByNU4wdm9UQlE2d3VtZEdrVTV6c2FZQUhv?=
 =?utf-8?B?VE50T2JpS0xMR2duaFpXYU5hb0tDeHZNazBhLzA2UjZaem9WL2NmK1VKcG1h?=
 =?utf-8?B?VERwbU9Kd2JVVUJTbGd4OVI2MzdGSzdHUkFKRTNKbmcwTzkwNkhoUXBTVk1m?=
 =?utf-8?B?SVJWOENWdW4reXJqSXRVUjBkNG5vVkxqeDRuaHluTXlMRzc1YU5jVTNuaVJU?=
 =?utf-8?Q?mEf4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca8b10c-0587-4447-8864-08dd67584635
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 02:38:18.8540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RJ5K9PQxcjK9EIDefZl8DZ3ZYSf+qmlFwtNE7+yZZV/S/8vE/j2Ttb80OvTHKmUc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7030
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
Cg0KVGhhbmtzIFRvaG1hc3ouDQpJIGNvbmZpcm1lZCB0aGF0IHRoaXMgY2hhbmdlIGlzIG5vdCBp
biB0aGUgbGF0ZXN0IGRyaXZlci1pZiBmaWxlLg0KSG93ZXZlciwgdGhpcyBpcyBhIGZ3IGludGVy
ZmFjZSBwcm92aWRlZCBieSBmaXJtd2FyZSB0ZWFtLCB3ZSBjYW4gbm90IGNoYW5nZSBpdC4NClRo
YXQgbWVhbnMgdGhlIGludGVyZmFjZSBpcyBkaWZmZXJlbnQgYmV0d2VlbiB0aGUgc211MTMgYW5k
IHNtdTE0Lg0KTGV0IG1lIGNoZWNrIGFuZCBnZXQgYmFjayB0byB5b3UuDQoNCg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEFsZXggRGV1Y2hlciA8YWxleGRldWNoZXJAZ21haWwu
Y29tPg0KU2VudDogVGh1cnNkYXksIE1hcmNoIDIwLCAyMDI1IDEyOjUyIEFNDQpUbzogVG9tYXN6
IFBha3XFgmEgPHRvbWFzei5wYWt1bGEub2ZpY2phbG55QGdtYWlsLmNvbT4NCkNjOiBGZW5nLCBL
ZW5uZXRoIDxLZW5uZXRoLkZlbmdAYW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFu
ZGVyLkRldWNoZXJAYW1kLmNvbT47IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0Bh
bWQuY29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNClN1YmplY3Q6IFJlOiBbUEFU
Q0ggMi8yXSBkcm0vYW1kL3BtOiBhZGQgemVybyBSUE0gc3RvcCB0ZW1wIE9EIHNldHRpbmcgc3Vw
cG9ydCBmb3IgU01VIDE0LjAuMg0KDQpDYXV0aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBm
cm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNlIHByb3BlciBjYXV0aW9uIHdoZW4gb3BlbmluZyBh
dHRhY2htZW50cywgY2xpY2tpbmcgbGlua3MsIG9yIHJlc3BvbmRpbmcuDQoNCg0KT24gV2VkLCBN
YXIgMTksIDIwMjUgYXQgMTI6NDXigK9QTSBBbGV4IERldWNoZXIgPGFsZXhkZXVjaGVyQGdtYWls
LmNvbT4gd3JvdGU6DQo+DQo+IE9uIFdlZCwgTWFyIDE5LCAyMDI1IGF0IDg6NTPigK9BTSBUb21h
c3ogUGFrdcWCYQ0KPiA8dG9tYXN6LnBha3VsYS5vZmljamFsbnlAZ21haWwuY29tPiB3cm90ZToN
Cj4gPg0KPiA+IE9uIFdlZCwgMTkgTWFyIDIwMjUgYXQgMDM6MTksIEZlbmcsIEtlbm5ldGggPEtl
bm5ldGguRmVuZ0BhbWQuY29tPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBbQU1EIE9mZmljaWFsIFVz
ZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KPiA+ID4NCj4gPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBUb21hc3ogUGFrdcWCYSA8dG9t
YXN6LnBha3VsYS5vZmljamFsbnlAZ21haWwuY29tPg0KPiA+ID4gU2VudDogU3VuZGF5LCBNYXJj
aCAxNiwgMjAyNSA0OjE2IEFNDQo+ID4gPiBUbzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5k
ZXIuRGV1Y2hlckBhbWQuY29tPjsgRmVuZywgS2VubmV0aA0KPiA+ID4gPEtlbm5ldGguRmVuZ0Bh
bWQuY29tPjsgV2FuZywgWWFuZyhLZXZpbikgPEtldmluWWFuZy5XYW5nQGFtZC5jb20+DQo+ID4g
PiBDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPiA+IFN1YmplY3Q6IFtQQVRD
SCAyLzJdIGRybS9hbWQvcG06IGFkZCB6ZXJvIFJQTSBzdG9wIHRlbXAgT0Qgc2V0dGluZw0KPiA+
ID4gc3VwcG9ydCBmb3IgU01VIDE0LjAuMg0KPiA+ID4NCj4gPiA+IENhdXRpb246IFRoaXMgbWVz
c2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRp
b24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGlu
Zy4NCj4gPiA+DQo+ID4gPg0KPiA+ID4gSG9vayB1cCB6ZXJvIFJQTSBzdG9wIHRlbXBlcmF0dXJl
IGZvciA5MDcwIGFuZCA5MDcwIFhUIGJhc2VkIG9uIFJETkEzIChzbXUgMTMuMC4wIGFuZCAxMy4w
LjcpIGNvZGUuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogVG9tYXN6IFBha3XFgmEgPHRv
bWFzei5wYWt1bGEub2ZpY2phbG55QGdtYWlsLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gIC4uLi9z
d3NtdS9pbmMvcG1md19pZi9zbXUxNF9kcml2ZXJfaWZfdjE0XzAuaCB8ICAzICstDQo+ID4gPiAu
Li4vZHJtL2FtZC9wbS9zd3NtdS9zbXUxNC9zbXVfdjE0XzBfMl9wcHQuYyAgfCA1MA0KPiA+ID4g
KysrKysrKysrKysrKysrKysrLQ0KPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNTEgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0DQo+ID4gPiBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvaW5jL3BtZndfaWYvc211MTRfZHJpdmVyX2lmX3Yx
NF8wLmgNCj4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvcG1md19pZi9z
bXUxNF9kcml2ZXJfaWZfdjE0XzAuaA0KPiA+ID4gaW5kZXggYzJmZDBhNGExM2U1Li5hNWViYTdi
OTFlMmYgMTAwNjQ0DQo+ID4gPiAtLS0NCj4gPiA+IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9z
d3NtdS9pbmMvcG1md19pZi9zbXUxNF9kcml2ZXJfaWZfdjE0XzAuaA0KPiA+ID4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvcG1md19pZi9zbXUxNF9kcml2ZXJfaWZfdjE0
DQo+ID4gPiArKysgXzAuaA0KPiA+ID4gQEAgLTg0Niw5ICs4NDYsMTAgQEAgdHlwZWRlZiBzdHJ1
Y3Qgew0KPiA+ID4gICAgdWludDE2X3QgICAgICAgICAgICAgICBGYW5UYXJnZXRUZW1wZXJhdHVy
ZTsgLy8gRGVncmVlIENlbGNpdXMNCj4gPiA+ICAgIC8vemVybyBmYW4NCj4gPiA+ICAgIHVpbnQ4
X3QgICAgICAgICAgICAgICAgRmFuWmVyb1JwbUVuYWJsZTsNCj4gPiA+ICsgIHVpbnQ4X3QgICAg
ICAgICAgICAgICAgRmFuWmVyb1JwbVN0b3BUZW1wOw0KPiA+ID4gICAgLy90ZW1wZXJhdHVyZQ0K
PiA+ID4gICAgdWludDhfdCAgICAgICAgICAgICAgICBNYXhPcFRlbXA7DQo+ID4gPiAtICB1aW50
OF90ICAgICAgICAgICAgICAgIFBhZGRpbmcxWzJdOw0KPiA+ID4gKyAgdWludDhfdCAgICAgICAg
ICAgICAgICBQYWRkaW5nMTsNCj4gPiA+IFtLZW5uZXRoXSAtIFRoaXMgY2hhbmdlIG9uIHRoaXMg
ZmlsZSBpcyBub3QgcmVxdWlyZWQuIFRoZSBsYXRlc3QgdmVyc2lvbiBvbiBkcm0tbmV4dCBoYXMg
dGhlIGNoYW5nZS4NCj4gPiA+IENvdWxkIHlvdSBwbGVhc2UgY29uZmlybT8NCj4gPiA+IFRoYW5r
cw0KPiA+DQo+ID4gSSBqdXN0ICgxOS0wMy0yMDI1IDEwOjQ4IFVUQykgY2hlY2tlZCBhZ2FpbnN0
IHRoZSBjdXJyZW50IGRybS1uZXh0DQo+ID4gYW5kIHRoaXMgaXMgc3RpbGwgbmVlZGVkLg0KPiA+
IFRoZSBsYXN0IGNoYW5nZSB0byBzbXUxNF9kcml2ZXJfaWZfdjE0XzAuaCB3YXMgbWFkZSA1IG1v
bnRocyBhZ28gYnkNCj4gPiBLZW5uZXRoIEZlbmcuDQo+ID4gSXQncyB0aGUgc2FtZSBzdGF0ZSBh
Z2FpbnN0IHdoaWNoIEkgbWFkZSB0aGlzIHBhdGNoLg0KPg0KPiBXaGF0IGtlcm5lbCBhcmUgeW91
IHVzaW5nPyAgSSBzZWUgdGhlIHZhcmlhYmxlIGhlcmU6DQo+IGh0dHBzOi8vd2ViLmdpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQNCj4gL3Ry
ZWUvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9pbmMvcG1md19pZi9zbXUxNF9kcml2ZXJf
aWZfdjE0XzAuaA0KPiAjbjc4NA0KDQpOZXZlcm1pbmQsIGRpZmZlcmVudCBzdHJ1Y3R1cmUuDQoN
CkFsZXgNCg0KPg0KPiBBbGV4DQo+DQo+ID4NCj4gPiBUb21hc3oNCg==

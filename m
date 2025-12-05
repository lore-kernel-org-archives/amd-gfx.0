Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C4DD374B1
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 23:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A117010EA9E;
	Fri,  5 Dec 2025 23:03:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BmBe+bQv";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3270010EA9E
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 23:03:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2xMJy8vM1CPt7baDRcfo6h7ew+LoL2VW5ZESMLaHyFn1bz/9ZnIxmVZmMGMZ4i5I8kNHuYAzEEqT+3N8UmJyEGqJ+dzZx5toL1AZvgo8SprBbMA9byFsH+NMBWaouic0pgwBz4s34kKpMqkjJGyyxFuySpvUCs9BwfhkvqdiqzBZiqSvCUs+dM5dibsUjhm0pFQXM7FJDY1ufJsVWMHPRJv+aBTztqJwt9vPL8Bj2hvm3Zi0JgLpkulfRriLaylCCUttQZU46T26CpK6eJ5/vPfAdL8wGBWv03T/y7glUthEDIvKRYbg8E/3udb+7EkRILGjObamGPhHSQ4GUQtbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gjV+cX1VCTsELQgNjWQCCqbCzowD/C0lrH0GNjvESs=;
 b=SgDfb1GHpuoXKyL5SM2Uz/44frmQiKm+7G8kxG0HhvMt8lgK5FMVWrvpB2KAFXeyZnJ1Ad5FjrSN66UudINHyvxX3AVwZaTEFx/Okl/cj+ZYc0qP8u8ZIxnOMhzvmK6S8rgkmo/TUpEgp+TTHFm36F4de+ZKlDPM9Y3ikp/virhaJegjWwioQMacTl46Wwtkg1CbgMofH5TNVzLDcyF+zdWMn6PcY1YM/tZJ4jva+36eBhM8zqT0rQGNjrp15zEjxIeHrKP+SQf7tOvs2gVnDPCtqiSIFpnt2z5zhPNhf9G21TGBHVMckV3aKNwoNMERNii3+D+8aEepFFEKnYQ1QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gjV+cX1VCTsELQgNjWQCCqbCzowD/C0lrH0GNjvESs=;
 b=BmBe+bQvVpFdGrpRvdEK3yOvPIZCVV1YuA07JkrsjCwNfw7Un8c0rnxjv6xD7mRDoBYeXOj069tkMELFiPXmBAJ70AyNgCBkh32YBF5EfxHRVPUJFmDtSIYAq4q2Qo2gb5l8gqIhb8J1DAVriiK5jIJBvMeJbfSdjShJeEYzFKY=
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 by IA1PR12MB6113.namprd12.prod.outlook.com (2603:10b6:208:3eb::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.10; Fri, 5 Dec
 2025 23:03:12 +0000
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993]) by SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993%4]) with mapi id 15.20.9388.011; Fri, 5 Dec 2025
 23:03:12 +0000
From: "Martin, Andrew" <Andrew.Martin@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v4] drm/amdkfd: FORWARD NULL
Thread-Topic: [PATCH v4] drm/amdkfd: FORWARD NULL
Thread-Index: AQHcZGtcgUYmNgPbQU6j82N/zG7/6rUTQTEAgABqOJA=
Date: Fri, 5 Dec 2025 23:03:12 +0000
Message-ID: <SJ0PR12MB8138E66801D2A01C3AFA8FCBF5A7A@SJ0PR12MB8138.namprd12.prod.outlook.com>
References: <20251203154145.63159-1-andrew.martin@amd.com>
 <29bd7365-2b39-44ae-89ce-48bfcb9ece9f@amd.com>
In-Reply-To: <29bd7365-2b39-44ae-89ce-48bfcb9ece9f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Felix.Kuehling@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-12-05T22:54:34.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8138:EE_|IA1PR12MB6113:EE_
x-ms-office365-filtering-correlation-id: ce796483-7d3b-4b75-49f8-08de34527755
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?utf-8?B?Q2w2SnNsR0w5YVVjdGVmZUdEZUl2Q05vVlUwbFlONlVvY21ZUEs0TFJjODFu?=
 =?utf-8?B?c2EyYlcrcEV0RGpqOGJ2SThUY2FVcmZZMTF5blROTmdUYU1lWWsvMFZJOXZt?=
 =?utf-8?B?by9jN3dXTFJFYUI1cWlUTWhzeXNNTDB5U2ptMmp2cUtocXJreCtuU1B2MG5v?=
 =?utf-8?B?RWtkeENPM2RxRVZxU3NTUkc5SHd0K0ZPK080d0F4MEZzdzlWT0tHVisxWlNE?=
 =?utf-8?B?TTVFdEY2NGV6bmR0NDF4SVdPUHoxaDIzMjlLYzgwRFJTc0MxMEpVc3FoNVRn?=
 =?utf-8?B?MnRMemk5WTVxTHdCSEJNTTFPdWtub3VyUEttTkg4amFTLzNCWWF1QWwyc3VX?=
 =?utf-8?B?MjRBWWJKaTluS3lSbzFlR1Z1dWFXWHVDdGdJYW1qQUdoK2JtVzlzaWE2Y3NV?=
 =?utf-8?B?MC9sTTRCb0NQWlp0b0Z5bVpvcWJWeXJsMVhXMWdYSHZVbXhsQzBGOHBKa3RV?=
 =?utf-8?B?cFJxSFdCYmZPcjlGQWRRbXRKRjMrcUpBcmVxTzNLR1h5Q2E1U1VCVFNrSEFW?=
 =?utf-8?B?d2ZBcXVaWG9OMS8vTG9UTVNCNkQwRS84eWdtcjMxcWNocFlTV3lUeWdMNFZD?=
 =?utf-8?B?dksveDE5QWJsazR4QXJnZHJHWmMzd3ZlQVpERkFvWi9ZNWdqVW5QZC9HbnpS?=
 =?utf-8?B?ZWViaFh3aWdLRDFMWHcvQkJCWXNOeHY5ckVrTjY1c003Um8xd0V5Y1p1SWgv?=
 =?utf-8?B?MisyaFNFT0hvZlRodUcyMGNkeGFoMXhyR00wRXBNNk40Mkthb2kvNS8rVjNR?=
 =?utf-8?B?MXgxSGF5a1B6dHJHVnBXVW1xeDVhbm8zcitDVHIrd2pTRERQMUJEUVB4LzVo?=
 =?utf-8?B?ZGNJcENFMGVLVFZneHkvU2JQK2NFV2Zqb3BaZ2Izc0ZJM1BmaUVQYXpPR3Y2?=
 =?utf-8?B?NC91NVo1OC82Q0tIblRwakVUTkdmbTUyZHZhZG1sZGExUDdiL1NPMzNPbU5N?=
 =?utf-8?B?R2ZHdFNPVHNPUFFrd29XNUIySVpiSUh0MFdwL1NhWndQelk3UGpxOFF5d2xp?=
 =?utf-8?B?NXROeVFjVDZwWEVvbmo0aVlrcEpheVNESHBITU00REtuN1R3dXFBSUJtUDBG?=
 =?utf-8?B?ZUswM3RWVHAxQ0hOREUzSFhqNGhBSElJZnZuQ1RzRkRjQmRIQlZxeWF6aFc2?=
 =?utf-8?B?cXQ3bmJwdFZtTzZad0dDVnJobnRzdEQ0d0lpeHl5RDNtUEJpM2E2Ri9wWlQ5?=
 =?utf-8?B?eHY1Ly8rN1hOUUF4KzR1UVZQeTZvYjliSkZXY2VwcEk4eVlrSUlqa1NveW5G?=
 =?utf-8?B?M1puTEFJVzU5czF4NXN6d3VvbW5SYUhhREJZRUhybjQ3YVQ3a2RiTG1QeU5S?=
 =?utf-8?B?ZkZRdW51RTB1WEhraXVERDJ5eDZ2NGlOTmJrQ3VCZUNrWVVDcDF5VElWYk5Q?=
 =?utf-8?B?WjlsSW9jVndFWHA5aGx3c0V4aEo2blpVbXBaK3RIalpodGhwWTFFekJzaU1k?=
 =?utf-8?B?RXExZi81RFpidll3N1J5alczZ29Kclk2TS93WENkZWNBZ1lyZWpyNm5lZzVs?=
 =?utf-8?B?UFBwNFlqZDdITVRkS3pxVXJMbmV3akdkU05YZ05PRjYvK3lOS3ozdmRnZ0Jk?=
 =?utf-8?B?SzdJMzViQjR2RWRPbzZHRVlLeWY4andzWTVicjYzNHNYR0ZBOUttTmxTOVhy?=
 =?utf-8?B?V2RtWGZyOXR6bWMwbmdlWmxZOXNOci9tWisyM0ZLMEw4U25uWHJVeTlUbFRC?=
 =?utf-8?B?RVkvaml3UXJCbDB2QlRsUThlc2R2aklpcFVFN2kzZkRqNExqaVlYK0wyQVQ3?=
 =?utf-8?B?eHVoK3E4L0FRQkNFeGJoREJhSUFRRGc3b2pYZUE2azF1NWlkcW11MzFRR2RD?=
 =?utf-8?B?OEdjSHhDZ0s3U041bmdodGp2MndWNHNKYUpwenhzUWRBQXhSdU9Ld2VHcFRp?=
 =?utf-8?B?S05aUW5STVBJcDVwN01XS3IrS0NNRHQ5emdFcHZMNTVQQzBUN01hanBQQitq?=
 =?utf-8?B?N3R5QmE2U2dLS1RGVFV1WUhLR0k4czZTd0QrengxanBmQW4xaHdlV1NDR3cx?=
 =?utf-8?B?YnFJZ1VqcUNseVhBZFRjMGNhNzBSYm91dXNMRXY4dUpLMzN2RUhzSlpTU1dE?=
 =?utf-8?Q?gGoenF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGVraUFnTjU3c1FVWWFWTUowRHhCQUR2YVhRTkIvRk1NeEhWbWlSYlFuUTla?=
 =?utf-8?B?ZDdTQXRoOW43Tlk0MkZvcmVVMHpTSG45TTd4a1laSHB0S3hFR0RSMWJpbFF1?=
 =?utf-8?B?L3I3bUV5c2hzWFJPN1lzb2Z4VnVveGM0MHpBK3BvdjRybzkxbUxNUGllbHNr?=
 =?utf-8?B?VFVxMDFBQW9TSG1zcno1NTdqSEtpQk5KV3pTNlRXZmJTV3JISHk1QWRMdlc0?=
 =?utf-8?B?ODQ1eUswTmFFKytuTlgrVGdITU1kZDI5TndFR0tReTZGTU16RndzRXU1V2Y0?=
 =?utf-8?B?TmtjdUtwc0dpakhGMDB1TTBINTdwQ0xqZyt4QWh4ZXI1S1l6dWpJZTE2SmJs?=
 =?utf-8?B?dzhkVTczTWVVS3NIRDVUQzZRMUVoS0ZLVnBrQ0NHVHk2cWtyRi9UbERsTXpt?=
 =?utf-8?B?V1lYQ1RrT3NFUDFqUlZvb1E2VkRzUUxPQVFDNDNqMWExNTlIejIvNDJ4Nnhz?=
 =?utf-8?B?VTIxN2xiVDJWQ1NSQUhVYnVNaG9YTFloUXk2WnBuWElKdVBackVnSXE0aVda?=
 =?utf-8?B?S3phdjJFVklaMzVxTEU0c0JKR21CMmVKQ3NwUktLT1BvdkZqVG43MTc3MEw3?=
 =?utf-8?B?VzVCUzBPVnUyMi93cUs1bDVGRVVadXQ4WlBESEozNG5zZzlaOUdUZ3lBS3ZK?=
 =?utf-8?B?R3B4WWF0eHB4RGNSQ3Q5c2VLc2RUSnN4ZEhRZ3RrZWRacVBNSUxtTnRJNHhv?=
 =?utf-8?B?OUNMQk1rd1FsTjJmWnRNSklIUkpGeFJyd2JHRTROSkJXOGNYN3U5YzE5em02?=
 =?utf-8?B?Z0Y3SlNraEFyeVFscyttYmVsN1ZnbEdmcWs1L3lLVmdNVUVNa2lIUXdnUnBB?=
 =?utf-8?B?K2dvR0c0Z1dOeXhmemt5OUVhaXhXb0Y5T1V3YjJmTGNSMFhvQnM2aktmbHFS?=
 =?utf-8?B?RU5WMmRscm04a1l3Z0VGOGtrN1g0RTFvSytEenh1bFdSUGx1d2pyR2s0M042?=
 =?utf-8?B?MFNqL1lTTGxOR0Zub3JUNjNkM0hmSTVKdERGYjU2RjMvQ1c0THgzcGRDZEM4?=
 =?utf-8?B?dEl3QnJHb0plb3dlUlJnNGtiWnRyWElaT0JqSnYwV0ljY0tZUDhpZUlFb3Z2?=
 =?utf-8?B?LzdWNHFDenNNM0NYbnRYWmhXRXFDYllqcFJpM0JyNXJZQ2t1SktrMVdMMVZS?=
 =?utf-8?B?NXVsVFR4S2E1SGg1V3d6ejQ2d1BqNFpiVXU0NVlNcXk1U2txRkIxTWptbm1U?=
 =?utf-8?B?RUNPODhseEZrdTJPQ1VNUmhuVWVxSDM1Q0hjd2p1SDlOSCtlcGoxWml3Z25w?=
 =?utf-8?B?ZTdNVERxTDJVdHZlNFp0MmRrY1BhejRLUVN2RmhoVmIrZUc1RFh3bm9Dc3JO?=
 =?utf-8?B?Zm94Q1g0RElTZFZBNjQ1NnNtcFdEU3cySStZNnBvb1ZYUm95RWlrUXBiWFgy?=
 =?utf-8?B?TzNKbHdnb08wOWMwK2NvTFhyZVJjbHo1QU5ZMXQ1SHBhaFFXN2JBTUJlbEM4?=
 =?utf-8?B?TkxrT3Q5bzlncnFGeEJWamZibGhONkE5YVFLN3lSUWszRUVpK1dJL1VuUnV4?=
 =?utf-8?B?LzF5V1BndERzYzF0MDRSdVZHM05mUnJDeGtSQ2kzYmhZTm93TndIMENrQy9Z?=
 =?utf-8?B?aHJqa3VlWktqYzFRQmhZRW5iVTdDZElLVWFkTzA0RWVWQkNZZDF6TFhCYzFZ?=
 =?utf-8?B?Q1B0VFlybU9xdjRzeFVGVjdvUGFZWnprcG5UeUR1R1VpSGh2UVhZVkc3L3l6?=
 =?utf-8?B?TGtyWWpOM3NoanBjaktzWXZJdGRXT0dLSjZ5RlcwT3hYZmZyK0lhTllJSlJ0?=
 =?utf-8?B?V091amdDcCt5aVlLYW9wUzNGcit4QnZvZHVzRTlDQVlGcldWMDBHbExwV0d6?=
 =?utf-8?B?NlczT3VZd29oZDU5RStxUlJ3dS8vS3NvN2JseGNLK1hiLzkxOWpJRjMrRHE4?=
 =?utf-8?B?c0NiVjJOZ3JwbXh1eC9zcEQ4WkFLMzhFSWx5U2JqSy9JY3dLNFRPdFV1TXlM?=
 =?utf-8?B?QWxBSUNQWjZhR3BtREYwQXRhNm1aRXNPMEN1ZXhZR01YcnVXdEZvQWExV1VZ?=
 =?utf-8?B?ZDZuc1FFS3dIQ0pjSjhhK2xaaldUbEUrZDdic1Vld055dXQxQ25WOHJ1MzRx?=
 =?utf-8?B?RVJ3Z2lZNUlPdzhDaFZZaXV1OUhKcUNkYnFpSW1RbWlMT3hONDlEZURXTWht?=
 =?utf-8?Q?onCg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce796483-7d3b-4b75-49f8-08de34527755
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 23:03:12.6973 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: axNjWk2Vu3jI91LO4HYKb6k/BbTVPeTigZfhHeqVVY94utqFG0dydJkazbMqUlVvj79tPJFGsdBy4XK0YNxpIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6113
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
Cg0KR3JlZXRpbmdzIEBLdWVobGluZywgRmVsaXgNCg0KVGhhbmtzIGZvciB0aGUgUkIuICBJdCBh
bGwgbWFrZXMgc2Vuc2UuICBCVFcgSSBrZXB0IHRoZSAib3Bwb3NpdGUiIGNoYW5nZSBpbiAod2l0
aCB0aGUgdXBkYXRlIGNvbW1pdCBtZXNzYWdlKSwgIGFzIGl0IHdhcyBzdWdnZXN0ZWQgYnkgeW91
IGVhcmxpZXIgd2hlbiB3ZSBjaGF0dGVkIGFib3V0IHByaXZhdGUvcHVibGljIEFQSS4gIEkgcmVh
bGx5IGRvIGxvdmUgYWxsIHRoZSBzdWJ0bGUgZGV0YWlscyB0aGF0IGdvZXMgaW50byBlYWNoIHBh
dGNoZXMuDQoNCk9uZSBsb3ZlIQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IEt1ZWhsaW5nLCBGZWxpeCA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4NCj4gU2VudDogRnJp
ZGF5LCBEZWNlbWJlciA1LCAyMDI1IDExOjM0IEFNDQo+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZzsgTWFydGluLCBBbmRyZXcgPEFuZHJldy5NYXJ0aW5AYW1kLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2NF0gZHJtL2FtZGtmZDogRk9SV0FSRCBOVUxMDQo+DQo+IFBsZWFz
ZSBjaGFuZ2UgdGhlIGNvbW1pdCBoZWFkbGluZS4gU3VnZ2VzdGlvbjogIkNoZWNrIGZvciBOVUxM
IHJldHVybiB2YWx1ZXMiDQo+DQo+IE9uZSBtb3JlIGNvbW1lbnQgaW5saW5lIC4uLg0KPg0KPiBP
biAyMDI1LTEyLTAzIDEwOjQxLCBBbmRyZXcgTWFydGluIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2gg
Zml4ZXMgaXNzdWVzIHdoZW4gdGhlIGNvZGUgbW92ZXMgZm9yd2FyZCB3aXRoIGEgcG90ZW50aWFs
DQo+ID4gTlVMTCBwb2ludGVyLCB3aXRob3V0IGNoZWNraW5nLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogQW5kcmV3IE1hcnRpbiA8YW5kcmV3Lm1hcnRpbkBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9mZW5jZS5jIHwgIDIg
Ky0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9jcmF0LmMgICAgICAgICAg
ICB8ICAyICstDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGVidWcuYyAg
ICAgICAgICAgfCAxMiArKysrKysrKysrLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9wcm9jZXNzLmMgICAgICAgICB8ICAzIC0tLQ0KPiA+ICAgNCBmaWxlcyBjaGFuZ2Vk
LCAxMiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZmVuY2UuYw0KPiA+IGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9mZW5jZS5jDQo+ID4gaW5k
ZXggMTkzZWQ4YmVjYWI4Li4zMWI4ZmE1MmI0MmYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9mZW5jZS5jDQo+ID4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9mZW5jZS5jDQo+ID4gQEAgLTEwNyw3
ICsxMDcsNyBAQCBzdGF0aWMgY29uc3QgY2hhcg0KPiAqYW1ka2ZkX2ZlbmNlX2dldF90aW1lbGlu
ZV9uYW1lKHN0cnVjdCBkbWFfZmVuY2UgKmYpDQo+ID4gICB7DQo+ID4gICAgIHN0cnVjdCBhbWRn
cHVfYW1ka2ZkX2ZlbmNlICpmZW5jZSA9IHRvX2FtZGdwdV9hbWRrZmRfZmVuY2UoZik7DQo+ID4N
Cj4gPiAtICAgcmV0dXJuIGZlbmNlLT50aW1lbGluZV9uYW1lOw0KPiA+ICsgICByZXR1cm4gZmVu
Y2UgPyBmZW5jZS0+dGltZWxpbmVfbmFtZSA6IE5VTEw7DQo+ID4gICB9DQo+ID4NCj4gPiAgIC8q
Kg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5j
DQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfY3JhdC5jDQo+ID4gaW5kZXgg
NWYyZGQzNzg5MzZlLi5kMWQ3MmNkMzMyZmMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRrZmQva2ZkX2NyYXQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9jcmF0LmMNCj4gPiBAQCAtMjM1OCw3ICsyMzU4LDcgQEAgc3RhdGljIGludCBr
ZmRfY3JlYXRlX3ZjcmF0X2ltYWdlX2dwdSh2b2lkDQo+ICpwY3JhdF9pbWFnZSwNCj4gPiAgICAg
aWYgKGtkZXYtPmtmZC0+aGl2ZV9pZCkgew0KPiA+ICAgICAgICAgICAgIGZvciAobmlkID0gMDsg
bmlkIDwgcHJveGltaXR5X2RvbWFpbjsgKytuaWQpIHsNCj4gPiAgICAgICAgICAgICAgICAgICAg
IHBlZXJfZGV2ID0NCj4ga2ZkX3RvcG9sb2d5X2RldmljZV9ieV9wcm94aW1pdHlfZG9tYWluX25v
X2xvY2sobmlkKTsNCj4gPiAtICAgICAgICAgICAgICAgICAgIGlmICghcGVlcl9kZXYtPmdwdSkN
Cj4gPiArICAgICAgICAgICAgICAgICAgIGlmICghcGVlcl9kZXYgfHwgIXBlZXJfZGV2LT5ncHUp
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgaWYgKHBlZXJfZGV2LT5ncHUtPmtmZC0+aGl2ZV9pZCAhPSBrZGV2LT5rZmQt
PmhpdmVfaWQpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGVidWcuYw0KPiA+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RlYnVnLmMNCj4gPiBpbmRleCBiYTlh
MDliNjU4OWEuLjFjYjI0MDkyYjE3ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfZGVidWcuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9kZWJ1Zy5jDQo+ID4gQEAgLTUxNiw5ICs1MTYsMTMgQEAgaW50IGtmZF9kYmdfdHJh
cF9zZXRfZmxhZ3Moc3RydWN0IGtmZF9wcm9jZXNzICp0YXJnZXQsDQo+IHVpbnQzMl90ICpmbGFn
cykNCj4gPiAgICAgaW50IGksIHIgPSAwLCByZXdpbmRfY291bnQgPSAwOw0KPiA+DQo+ID4gICAg
IGZvciAoaSA9IDA7IGkgPCB0YXJnZXQtPm5fcGRkczsgaSsrKSB7DQo+ID4gKyAgICAgICAgICAg
dWludDMyX3QgY2FwczsNCj4gPiAgICAgICAgICAgICBzdHJ1Y3Qga2ZkX3RvcG9sb2d5X2Rldmlj
ZSAqdG9wb19kZXYgPQ0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICBrZmRfdG9wb2xv
Z3lfZGV2aWNlX2J5X2lkKHRhcmdldC0+cGRkc1tpXS0NCj4gPmRldi0+aWQpOw0KPiA+IC0gICAg
ICAgICAgIHVpbnQzMl90IGNhcHMgPSB0b3BvX2Rldi0+bm9kZV9wcm9wcy5jYXBhYmlsaXR5Ow0K
PiA+ICsgICAgICAgICAgICAgICAgICAga2ZkX3RvcG9sb2d5X2RldmljZV9ieV9pZCh0YXJnZXQt
PnBkZHNbaV0tPmRldi0+aWQpOw0KPiA+ICsgICAgICAgICAgIGlmICghdG9wb19kZXYpDQo+ID4g
KyAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKyAgICAgICAg
ICAgY2FwcyA9IHRvcG9fZGV2LT5ub2RlX3Byb3BzLmNhcGFiaWxpdHk7DQo+ID4NCj4gPiAgICAg
ICAgICAgICBpZiAoIShjYXBzICYNCj4gSFNBX0NBUF9UUkFQX0RFQlVHX1BSRUNJU0VfTUVNT1JZ
X09QRVJBVElPTlNfU1VQUE9SVEVEKSAmJg0KPiA+ICAgICAgICAgICAgICAgICAgICAgKCpmbGFn
cyAmIEtGRF9EQkdfVFJBUF9GTEFHX1NJTkdMRV9NRU1fT1ApKSB7DQo+IEBAIC0xMDcxLDYgKzEw
NzUsMTANCj4gPiBAQCBpbnQga2ZkX2RiZ190cmFwX2RldmljZV9zbmFwc2hvdChzdHJ1Y3Qga2Zk
X3Byb2Nlc3MgKnRhcmdldCwNCj4gPiAgICAgZm9yIChpID0gMDsgaSA8IHRtcF9udW1fZGV2aWNl
czsgaSsrKSB7DQo+ID4gICAgICAgICAgICAgc3RydWN0IGtmZF9wcm9jZXNzX2RldmljZSAqcGRk
ID0gdGFyZ2V0LT5wZGRzW2ldOw0KPiA+ICAgICAgICAgICAgIHN0cnVjdCBrZmRfdG9wb2xvZ3lf
ZGV2aWNlICp0b3BvX2RldiA9DQo+ID4ga2ZkX3RvcG9sb2d5X2RldmljZV9ieV9pZChwZGQtPmRl
di0+aWQpOw0KPiA+ICsgICAgICAgICAgIGlmICghdG9wb19kZXYpIHsNCj4gPiArICAgICAgICAg
ICAgICAgICAgIHIgPSAtRUlOVkFMOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+
ID4gKyAgICAgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICAgICAgZGV2aWNlX2luZm8uZ3B1X2lk
ID0gcGRkLT5kZXYtPmlkOw0KPiA+ICAgICAgICAgICAgIGRldmljZV9pbmZvLmV4Y2VwdGlvbl9z
dGF0dXMgPSBwZGQtPmV4Y2VwdGlvbl9zdGF0dXM7IGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMNCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9wcm9jZXNzLmMNCj4gPiBpbmRleCBhZWM3NTIyNDA3ZGIuLjQ3NzgzODAz
ZjU2ZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJv
Y2Vzcy5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3Byb2Nlc3Mu
Yw0KPiA+IEBAIC0xNzYzLDkgKzE3NjMsNiBAQCBpbnQga2ZkX3Byb2Nlc3NfZGV2aWNlX2luaXRf
dm0oc3RydWN0DQo+IGtmZF9wcm9jZXNzX2RldmljZSAqcGRkLA0KPiA+ICAgICBzdHJ1Y3Qga2Zk
X25vZGUgKmRldjsNCj4gPiAgICAgaW50IHJldDsNCj4gPg0KPiA+IC0gICBpZiAoIWRybV9maWxl
KQ0KPiA+IC0gICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiA+IC0NCj4NCj4gVGhpcyBpcyBr
aW5kIG9mIHRoZSBvcHBvc2l0ZSBvZiB0aGUgcmVzdCBvZiB0aGlzIHBhdGNoLiBJZiB5b3Ugd2Fu
dCB0byBrZWVwIHRoaXMgaW4NCj4gaGVyZSwgcGxlYXNlIGNhbGwgaXQgb3V0IGluIHRoZSBjb21t
aXQgZGVzY3JpcHRpb24gd2l0aCBzb21ldGhpbmcgbGlrZQ0KPg0KPiAgICAgICJSZW1vdmVkIG9u
ZSByZWR1bmRhbnQgTlVMTCBjaGVjayBmb3IgYSBmdW5jdGlvbiBwYXJhbWV0ZXIuIFRoaXMgY2hl
Y2sgaXMNCj4gYWxyZWFkeSBkb25lIGluIHRoZSBvbmx5IGNhbGxlci4iDQo+DQo+IFdpdGggdGhh
dCBmaXhlZCwgdGhlIHBhdGNoIGlzDQo+DQo+IFJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8
ZmVsaXgua3VlaGxpbmdAYW1kLmNvbT4NCj4NCj4NCj4gPiAgICAgaWYgKHBkZC0+ZHJtX3ByaXYp
DQo+ID4gICAgICAgICAgICAgcmV0dXJuIC1FQlVTWTsNCj4gPg0K

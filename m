Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57F9EC1E86
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 09:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 836AB10E849;
	Thu,  5 Feb 2026 09:49:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H6GKQyRn";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012027.outbound.protection.outlook.com [52.101.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A782610E849
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 09:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIpQncOQ+Hq1Lumx04GupzwYjXbeGmiceXH6x+kmTM/P0a7c6fBX72aPQ8sMXBfE5u2NdG5WXr8FI62nuCPvjcotpYBr23Z6z58Bfnc+Gd/fYlo60HBM3KAEz6AP5/P/6aj6lLnW1lBRleZmefLJMJ3s/KzpULDFb3f6Zo0xz4qG7hNLQcFq6gPIrAbrYcuP9nhrKrPZVOkNVzdSUPM1P80GFgrZd17OyvtQlQ8YLs8fvFgnIYmxANsjjUcaPdWgpvhY1vBmg2u6xGcwUZTvojTHKy0iO8fHEHL0lwoRC9slpOxYaZVDvJWjsv0yDHesz54ndo2KM/5zSQal265LjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dye1B/ELUaUz40Ln14lddJSEAhojhdSn7jhCXN9+DDA=;
 b=angeQIcMZjwXdtfQ4BWWwQefFeB4W6RjeuSZDIYnysbtMwboiYlD9kSq0uBLuI8+xM1UH7aly9F6TdmgGnT7VrlV7peSlVJeMdFMplGySYEi4dKULN+Ixy/lzz9mpmFyeE8VSITR5IojpHHMEZtRRDkELmGuFy3egZ5Ip2fRIWd803s0E4ESl/yDCOqp9dCX/zTU0iEqH2QnHgbZfn5eSn1EpIJuPGrGR0hff3f0WyfMo/l7Eqf9B9HeaClXSuH8eHmPtj9nibJ2gESgug/DVC7eMLP88jOrPhRNfAFoH+Exl9wNgmJZiPJNKpUdKolhFMFOm4BiXBFHh4DKJACbng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dye1B/ELUaUz40Ln14lddJSEAhojhdSn7jhCXN9+DDA=;
 b=H6GKQyRncr7byLjfxFrvj5Ugr8bKRYw7+ctXXvT/8U8C8VPvfbpSG1CzbuXTsHQD30WzkImKLXsD3dy3LBJGA0ZGKsH+nBnPUU+wQ7uneSFM2yuZwPohpmSO8moF3YS48Tj7HGQ2hzT7cupeajK0dhe+o7v8c7VbATUpZXBZ1HA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 09:49:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 09:49:34 +0000
Message-ID: <7ea6af25-e3f0-4d64-aec1-cfc1b7e5182b@amd.com>
Date: Thu, 5 Feb 2026 10:49:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix uninitialized variable in
 amdgpu_fill_buffer()
To: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 pierre-eric.pelloux-prayer@amd.com
References: <20260205021617.1279195-1-samasth.norway.ananda@oracle.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260205021617.1279195-1-samasth.norway.ananda@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:408:e0::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: 4adf76ab-562a-481a-9442-08de649bde1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OURBVVBidm91LzJyZ0JyM1I3NUdYeGdET09EOERCVkxsQ3Q5NlQ2MlJMWFM1?=
 =?utf-8?B?eGtIQVZnU2IxdVVuSnVqMlVKM2RmTmFkWWhhaVB5Q094M3Bhb3ptWVZ3aVRG?=
 =?utf-8?B?djJaQVYzbGpZWmVtejZRTFJBMXIrbnoyM0YwaUJEZ2JaODlBckpML2IzWW5C?=
 =?utf-8?B?Q2Jpb2JvQmNNNC9mN1FCTldhU04zcXhuaXB1UzJWRkUwYXAwcG03TXU4VDcw?=
 =?utf-8?B?dGNScjJ4WHdGY3RPdTFWcm1rSExVNU1rYkYrNnJzdDBlTGFORkFqWFdiak8r?=
 =?utf-8?B?ZkZDREFaci94VGoyT0sxSHc1UEVPVnc5Qlc3Ry92clBOZWdUMzVCSjZjWXF3?=
 =?utf-8?B?SHp6YjBTbVAvMGZlc0ZuNGw1YzZURHRSR2xQRXZOY1Vaa2crQmVRZ1dBQ2FG?=
 =?utf-8?B?eGJRNWJ6WWtjYnRPZmJ5OVg5c1M5aUxVcTVmZ2JwVzh4K3NnakNXSUZ5MUJa?=
 =?utf-8?B?MjlNMW01dFVBRFhQQ0dhTGl1VHVYdlNQWTUyMmx2Z0dvRFZaLzVLVHAvV3Zq?=
 =?utf-8?B?RGVzWTN2anpENFBxOXdkZmlSMEsyQ0hFckNReU5hZ0VHbVIrQ2NwZ0tNd21P?=
 =?utf-8?B?eThma0g3ekxoT2c1UHhiaG5FTk1EVUNYQXExN3JSRWR4OHRTTEZCalBBSEYv?=
 =?utf-8?B?TDhaVjZDQk56T2JVVHQ4Q1BUeVViYmxJNDFFRTc2NmMrUko5VXdwSitwdmlU?=
 =?utf-8?B?NjJPL1ZBSUdiNnE0eCt6UE5vR1RqZHM2dFFCS2FBc0ZLb1BsWVZpMDdGeThO?=
 =?utf-8?B?enpsRFgydGFZOElrOHNTb281bllFdDJoV3V2ekZibHZmQ0FTM204UzRoQUR5?=
 =?utf-8?B?aUp6TFhNTDB0SGtMaEQ4MmF6d1NQTEFjdlVIZnFVQmJGSHpjaEZsSThPSGxF?=
 =?utf-8?B?aWtXdTNzcDBsbDNCVXQrNUVBTGF5bEVOaVBhREVvMUFwOEZ0V3VWZC8zem1J?=
 =?utf-8?B?NXpMdExpaXUrUTNoUjBvOFhDVTA0TG84Z3NPN0dMcDVBNjhhQ2YxV1haN3VU?=
 =?utf-8?B?anZkazNmRHNTVkdWR2NEVDRYQkZaajJXSEdoMU05QjVodnZvdXNKQ0N3eFJ0?=
 =?utf-8?B?UTlaRWV3eEp5SHhSbHY2b21uMTBDcG0yaElpcjRXVVBEN3M3dEtqb285bjBI?=
 =?utf-8?B?eWZaUHVKRUZTRWpZalZuSm5tNVFKejVySjZkZlptRXErWUl6ekdPU3ZZWGxC?=
 =?utf-8?B?d1QxUkFHVytDVFZjNmNrbUFVdStISHFpMXZ4YngwOVBlWHlCL0cwVDE1Y2pP?=
 =?utf-8?B?d1Arek5jbEhFcjhoMHNmVHNmdDBWQ3RkOVdMajRSbnNtNFB5cEkyMjNEK29m?=
 =?utf-8?B?TlUyS1Z3ZVBxOTQ4bEJIM2o3ekpTV2d0VzdnQWF6MFBOS1NaSmlndXdveG9Z?=
 =?utf-8?B?bGc3aU40S2pQd1RRd281WlRaQ2JUVXhhcVc2MjQ5MnRyNG1ucWxDbGN0dHFF?=
 =?utf-8?B?QkRPUlhaV3NGc1QzeXpLQ1FORGtMK1g4c3h2RHhRSFBpSHVxOTBrUWk4czBB?=
 =?utf-8?B?bmpKVkl0UXdQVlZrUGxlMit1dU9xM0NCUXRJMjlFYTFlNkJsUkgyeElRSkpw?=
 =?utf-8?B?Q2wyUjIreTBSRkVPbzJlMHN5aHJ4bXpIeUpHdnh5alE4WjNiZTVmamh3YnJ0?=
 =?utf-8?B?Y2pleWh0WVFwa2JPaXY4T1VCeU9LS3oybFJLSFdIckZ3WU9qZUtLLzlLZFBa?=
 =?utf-8?B?V0w0NmNCSGVERkZFTDhXR2JjSHk5RC83WG9kVWs5eXRqVUNZZkZxMXZJV2Qv?=
 =?utf-8?B?b3MzamIzem9TQVV4QjJWT1k5SjNmNGdzYVg4QUFiRVJCVFhQQ0xwMUxaNzV2?=
 =?utf-8?B?S0NsbHpOeHArY1JVMHlQWkZwRGtJOUNoWnRkRFhaZExUSmtMYjJ1eXQyUHh1?=
 =?utf-8?B?NHM0Rk1MNXlzUlkxMzNFWGVDWlR3aFY0R3hzQVpjRDd5SzhZUDJFNW5wZTlQ?=
 =?utf-8?B?alhuZlcrL0tvSy9IeUE3OGNGVEpFaE9lVE1pM1Nxb1p5MVh3M0hCMGRGM2Uz?=
 =?utf-8?B?UkRVR2U0NXhKSDVsTVdBNGNsVDgrOGJHSzkyOVZKVFp2TUNMNGJYVW45RTgx?=
 =?utf-8?B?b2ZZMkdtMysvbmltWTJlQjFZMVEvdldFaG5DRUZpRjJTeWtQNStEQ05mQWFr?=
 =?utf-8?Q?NtSA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2NyZCtXeVhiREd3c3RBbEg5Q1FBQlIxQ1VMdUVxQ2dEMlJ6akJEaGNtSGcz?=
 =?utf-8?B?N3htWFV2NVFodFMyS1dGRU56M0FhaHRyRmhkcWsrUndOY2Q3QmtmbU9Rem9w?=
 =?utf-8?B?d2pGaWJnVFZDdFRiZFVuelFOTm5BNFNvS00wZzRUNnJTUG16eXdJZVFrL1dj?=
 =?utf-8?B?WktvZVV5TlZodFdpalJOd0twcE83STNtYjIvenl1aVY2emthd2lsVi8rR3V3?=
 =?utf-8?B?NFN5RHdpSjJvSExVRW00dTFHd2ZTRmh5WGxBMUdwS0xERGlicDlaZnlPKzYy?=
 =?utf-8?B?aEZWbG5MRVYxdjh3VGxVM2xydXVyV1k3T3laT3ZFN0ZHS28wSUxsL2dsZGVy?=
 =?utf-8?B?anBqbno4a0xsUFFWWVp6dXFuVmo1d2FSeFdxdlRSOWZDQlpJTk4wTDhaV3BX?=
 =?utf-8?B?aXE0TUJ4a3FTNFVXck9lSkZEcUhQdlgvYXNaSGkxZmg5SjJuY2hCOURwWlBm?=
 =?utf-8?B?Tis0UFl3RGVZeGZsaW42NVNmMU9YNE5KV0tzcTFJL1NxV2swWUhVdm00MXFC?=
 =?utf-8?B?QW9tQjBkdFNiQmxwbXU3cmk2bHBBMm1hdnlRODFFYXc2bzJvNi9TeWM3ZWl1?=
 =?utf-8?B?bkVLYkh6MC9mMEl1VzIxZzl6OHQxUUhYNXNLeStGeksyaWdNUjdqMkxYMGx0?=
 =?utf-8?B?TUtCTXdZYlhsWjZvRk5oUngrNGI4enV6SERMdFhqL3NDS3ZUVW9DMEVWUXlC?=
 =?utf-8?B?UGdSMHZURnZMMUhOYzI3YmIzRVgwQWhYUVBQU1E4WlhScXltOGROZmk5RTE1?=
 =?utf-8?B?Q21jWEUxVzlHV0s2dTdQMzNlWWtpVFpYTVdORStiUnFXYitrNlhkR0wwbCth?=
 =?utf-8?B?NXhGaUZ3cW1oZWpNN0txeG9LUGVhbWpJWDk1cW94cHpDdUs5YWl3d0x5ZWNy?=
 =?utf-8?B?MWlpaUZvN0dkOFJHRGhxZEQxTWI1Y1Bvczh5VWhNazk4Zjl3bFpHMmtDY1pa?=
 =?utf-8?B?eXlFTENnQ09PUDdMYldSaHVPd1ZhQXJCcXM1NURKbDFYZ2Nxd1l5ZC8rMk9m?=
 =?utf-8?B?UkJXcFp5cStxaXViQU1mZGQ3QUdTK0l4SllpUEpTUlRxSDQ0QlcwSXdzamN1?=
 =?utf-8?B?cmk5dTBjSzd5blEzajg5MG9maXpKVUQwL2luU1JUUHAzdXowV3RyazFxWXJw?=
 =?utf-8?B?SkMwT0c3K0tYc3pvUGNGcC81WnpDN2VMUWlOSGFFWjYrNVA2a1FoVnp3M0Jj?=
 =?utf-8?B?d0RlWE82VWR5UkdHVmhRcnhQVU9Tb0RCRmN2NjE2dzJuWkl2Z2V4UE1rK3Vk?=
 =?utf-8?B?TkZrNGhkMnZpaFIzbGF1Q3FMUmlhWnRJREFQSElRL0kyb0FLWmpFZFppTk5r?=
 =?utf-8?B?ZG1oV1had0tVUEZWcjZyTEJKa2djTmx1RTltWHZUaXI3dm05OTc0eHhLYWRD?=
 =?utf-8?B?NnozUkJTdmpGbUZtcGNONGxmNEd0YTBMdmx1cW5OckhCbVlvMEhaTTc4L1I1?=
 =?utf-8?B?c3Y5OHQyNEtxUzZIYThkcXNoTlNNZU1nNGIyM1hXT0F4TmUxQ3I4Slh3QXdT?=
 =?utf-8?B?d0tZWnNDalFmSHV6MldEUWZYWnNFVFcyVStwdFVmbml3MDR6d2VOZGJ4RW1j?=
 =?utf-8?B?Vnh6OXhqOTBXdGNNemJIY3BMdWRNWWNVOXdFZnhFNSt3alBYazd0UzEzTkdi?=
 =?utf-8?B?RUdycWs4ckwwRUNERmZON0wwOHgrVVk5anlCL1Z6VlBFL2RRbVVFajZCL2Nl?=
 =?utf-8?B?ZFMzMVR1MVBOeGxKZmowYzluMXFaR0d3MGV0V2xRTjRwbk12MjEySFc3TXJv?=
 =?utf-8?B?bldibW5KWkZZZ2tPNEkzYkZoSU5hKzRIQ0h1TndUVU5mRjZ1c2ZraElIVVdY?=
 =?utf-8?B?MHRqQkM2TmN4YTlIUngxNDAwRWpNU2pGOXlEbmo4WVZxTFU0T0lacCtTeDZ5?=
 =?utf-8?B?U25FZWZ5Z2hXL09lRkRVZGdKNXhFcHoyTnJ2YkFmaTllS2dMNnBHMnN1TUg5?=
 =?utf-8?B?K3R0RnBmK1U1QjYrV3JpTlFLdU9lbnJDUW43YkdJaytmRnYxdHJQT0FKVDJN?=
 =?utf-8?B?ZU5jSXFFZGVLSVMzWGpNVDNiNUdIUzR4ODlNOWkyZHBpT3hPa1dvTTlpRitD?=
 =?utf-8?B?VjcwMWQrdklycEVHSDg2MnFsRVh5VEh6Q3kzS2J3cEdUYWVySHNVQVVaR0Zr?=
 =?utf-8?B?NENNLzFxMktJSnV1aTlPekNWczlsSXhpd043VDAwenR6c2FkK0VKT2duTzF3?=
 =?utf-8?B?WnZEWlE3Q3NoWW9Va3FDZ3JrKy9TUnRrTHZlWDB3b0hCbXA3NTI3c2dMNHJr?=
 =?utf-8?B?eGFUNlBTRDlHNTcyZG8rYzFPb21LMXpZM1VyckZBcFNxVUJodHgxN3BUMW12?=
 =?utf-8?Q?kYqYhClD8bCDeJMz6N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4adf76ab-562a-481a-9442-08de649bde1a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 09:49:34.3960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWFM4EQx6LJhcIPrC1ggP+tMqjHwH7jF0nSz3/6sj5fdFsKK5QfMuQO7Dv0d6bsx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064
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

On 2/5/26 03:16, Samasth Norway Ananda wrote:
> Initialize 'r' to 0 so the function does not return an uninitialized
> value when the while loop body is never entered. Current callers always
> supply non-zero sized BOs so the loop always executes, but the function
> itself does not enforce this and static analysis tools flag the
> potential use.
> 
> Fixes: 22f7cc752408 ("drm/amdgpu: restructure amdgpu_fill_buffer v2")
> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 15d561e3d87f..44524eb2f74f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2564,7 +2564,7 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
>  	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>  	struct dma_fence *fence = NULL;
>  	struct amdgpu_res_cursor dst;
> -	int r;
> +	int r = 0;

We usually avoid initializing return variables exactly for the reason that the compiler then can point out code paths missing to set it. So please just initialize it directly before the loop.

This is also not a real issue because the loop is always taken, e.g. zero dst.remaining is not possible, but the compiler or analyzing tool can't know that. So maybe drop the Fixes tag, no real reason to backport this except for cleanup and silencing the warning.

Regards,
Christian.

>  
>  	if (!adev->mman.buffer_funcs_enabled) {
>  		dev_err(adev->dev,


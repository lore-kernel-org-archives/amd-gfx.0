Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A17FC3ABB6
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 09:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BF3210E317;
	Mon,  5 May 2025 09:02:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l9xQEjjf";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F37910E317
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 09:02:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hChpb1Cd3fzd9DB+hOlhUwwa7qXIePdVXA+nzpsii/1Y38nsx0acXH265BIBULZwRYD8iOEVWYH1aXyPDKmEe2Llvap7YKsb8qQ3b1dlfMXnLonS7t7t0w9avI1TXeW+tdWykxw9K5GXKhPYbb9TUh/3dyr51DMkw8koQbhoz5rICyklWPrnEI0fSgY6YcKF84AKZ4wYtPUd2e8KxmEUQrSsHMvR4Sxejq+ILMUF/SD3hNrbunAxjaA2jGBWPMtgGmEtoABf46HqQ+VEVuIv222lakanjnDRRG8ZuRCkVPAXiJGMpkCtLWvyYJced0gEorLajDsj2MLIbf7ThkTKuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05rWYb/d+bvNv4pF62jENVrzfy9iWDvAvBPvWnWm7mQ=;
 b=l1InXatnwLcnjKiMBcuc9gszFpvLi27AUuAcoAHaeGP/ciiQYZyWL0GxsZ3F4cPHPbqVVSZeQKZwI6ZDjGjD8JPoUsIxiL5EFJgZ63Oe75md12thx1m8IW0+hZWo7rJyPTsI6TZo+GgddyGVVPzA5Xla1PeLpelA/0MSkKMjtDPGuj4sKA/JHGTwsRlg9Oq4S0K+N2GiMuP2ZV6kmrshKwUd9qTFRkUFL5tlE+wYRh98zMOdU4o4A5Z+V0JzAN5Hk4V9SyEPxF0pPjYGmPTfxsnmuz0IuXtypF75l2RgZ1vq30njn1rywUl9hMvZZCV5JWhgD/NYEqMOU04rQFDszw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05rWYb/d+bvNv4pF62jENVrzfy9iWDvAvBPvWnWm7mQ=;
 b=l9xQEjjflHJsbNALMpAXfrFMPmrFPFzNUW9L3tyILI98ob3kIPFxaMV0rzzKHYebDDfOzl7FuOOgBnWmwt9sg52psh+UTNY1UGh9/pKkmkWdpcYvkuugNDmk9KPr52T1rBgL5vzwiWTjxjaMU6Ek/P/m9Rp7ZRWY4QW7ARPsVZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Mon, 5 May
 2025 09:02:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8678.028; Mon, 5 May 2025
 09:02:16 +0000
Message-ID: <6288c9d8-9a18-4027-ba50-258f837025a3@amd.com>
Date: Mon, 5 May 2025 11:02:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] drm/amdgpu/uvd: Ensure vcpu bos are within the
 uvd segment
To: John Olender <john.olender@gmail.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, arunpravin.paneerselvam@amd.com
References: <20250429112429.5646-1-john.olender@gmail.com>
 <20250429112429.5646-3-john.olender@gmail.com>
 <CADnq5_OBUWJj5uqbB78wLkbBAMtoRUy=Nes1O6garEQceCLB3Q@mail.gmail.com>
 <b09012e2-f361-46b5-afbf-313334fad69a@amd.com>
 <7efe97e3-adac-417b-8f0d-50ec4b2589e0@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <7efe97e3-adac-417b-8f0d-50ec4b2589e0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0417.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN2PR12MB4045:EE_
X-MS-Office365-Filtering-Correlation-Id: d8466062-1eb7-4fbf-f7c2-08dd8bb38858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0JLOFRma1pPZjU1NUtYamtnMmVSUDJ6MDF0c3JicmtRVEt5MzNiYlhtbXFH?=
 =?utf-8?B?NUp6a0xqT3pCcEZRUEdCMHIxWUk2R1p1WU9QOXk3SkxqSkxSWDFMME9yR0o0?=
 =?utf-8?B?ZlRYMVJQc1NpUHdwNC9tQVdNcUlsQjJES2EyWG1EOVNodEtDWkRpQkw0alhk?=
 =?utf-8?B?dUlBd0FFK3lHVVFxelBDL3BkcVp4VEVZQ2liKy95R3hFWFdROGZrbUJ4QzN2?=
 =?utf-8?B?STNOSGFRNGFUTVJiRU5CVXBweFlLOStpZEdaZVQ1bzNIeXkvWmRFNHd3U3ZJ?=
 =?utf-8?B?Rlh3Z3FkUmdxSTJXdXdlYnVjV21KNzl0bmJOVUxEL2c3TlRNN25pYXNyOTFi?=
 =?utf-8?B?RzVNdGl4NGlLdkdmclY3WTROajZFUXFSd2Z6bkdoalVhcXR3NXo2RmZTR0R5?=
 =?utf-8?B?YUdaTWM1VVB4NVlPcG1QNjF5YVhjOURhb3pOeHBNck9LYXIybmZ5UlhDWmwz?=
 =?utf-8?B?eC81ajljZGdBQ1RkVndQVVpKMzl1TkVxSjlsU25hTWZoa29kdW53ZnJKT1kv?=
 =?utf-8?B?eG53cVd3dnZwcVRDYlhjeEN2UFNTdTRmeEthamNPSTkrNW5aRjUranlkU1Bp?=
 =?utf-8?B?amZTRU9qRm12ZlB1QUpzM0hlVjdYVnlWb214UEljOE9CQTJlU2tLR1FnZVM4?=
 =?utf-8?B?bGp1NGEwRGloaVBBRXhScFJ6VnRXaGNXbldtVmpMTDVVNjJkMUZUUUxJNkhN?=
 =?utf-8?B?TU05UjREM1NQb0IyR25tOTVUdDRRQy91U1h3OWtOTVBLTW0xbk84bUtpTXBi?=
 =?utf-8?B?UTl4cGlsS1d5NXg4TnNwSys2d2s5TXZ4a213WjBITDFPOWNyMGZSdEozSlhM?=
 =?utf-8?B?V3ZXbVViMmpwRVQ4ZnRkclMyS1NESHIraHFDaTdzSGJ0ZTMxamdOcnBURmZT?=
 =?utf-8?B?WUphUEM1TFFtaFl5cGZjaVN1RnhWdkN6S2VkMC9CZFhQYTAyU2ZqVWZ1ZnM1?=
 =?utf-8?B?MTdOOHBiY05Bc2hMOVN4SWtRd09QYzVKSFVsWVYvZGFkQUJLNmM2QktkUHFR?=
 =?utf-8?B?UkhGeVVObjZ3a2phNE9RM2V1ZncwVFRyTXF3T256cVNZUmsrRUdIY0pBaGFi?=
 =?utf-8?B?b0dZRlZUZmlnQmtKUDZLdVFDTU42L2pDTHI1NzZtMkU2YmFQc2J6RHNjb25K?=
 =?utf-8?B?T0wyMWxodUR5bnU2ZTlDeWdEdVpWSHFxeGx2T3ozZjhIYURqNWU1RnQ2cTlv?=
 =?utf-8?B?MFV5cHBFTmJ2WE9Td3hCQWhONHdjR1ZsME1ueTFCL2ZLNmtkWFdtQndUNVJG?=
 =?utf-8?B?enhBZzhWSzVXL3ZKUVh2bHBaeXg3NStoKy9jaEJrV3JhMWxYYTY4S1Nsc0ts?=
 =?utf-8?B?YUJObTd1TkZGREdrYlZMTUlNTmJtSEVscEQzTTdIcElPcjdxaHJiN2thYy9D?=
 =?utf-8?B?MWM2TWpJek5UQzRHeHlrdVBCdXhBUG9JWWdmQmtoWnZISUxwZHBmbzdlMXRP?=
 =?utf-8?B?WFpxWGdrY2h2TDFhamgwUVo2aU9JRUlWTkJDeXBJQnBVOENTRDFyM1hEQVpn?=
 =?utf-8?B?Z3ZEaDJZbTc3SEJJSkZBY3lOR2ZXRUZiVXRqWTEzMWJ3K1hvd1BJdEVhM3FX?=
 =?utf-8?B?WXZ4QmtuQ1ZNQTRHSGYwSGJYOTBjTm1wUTRnRjdNU3FOK2tmYkR3WFRaaDBF?=
 =?utf-8?B?SFBzRWY1Ymx5VzdoYlhRSkthdTIrN1ZjTFpSeWtZMXc4VUpTVGkxUmw2QnVa?=
 =?utf-8?B?MEw1cmk1MlVxQnJ6bHFPS2dTQzA2RlVsM0xMMDVYLzJxdlJVQ3Z1M0k2cm9h?=
 =?utf-8?B?c0VLS29MSnlXR2w2bmsrcmxRRnI4TzFPdTNBcXFHRVZvc2xUV3doNDE3L0l1?=
 =?utf-8?B?TEZVT2tUU3NZY2VYYjNjSkZva05ieUFpalpNUlA5MC9PelQzNjU3UDFTVkQz?=
 =?utf-8?B?Qnc0UEdlUkMvQXREbWxQbkFEbnpZUmhBRXhIWkhXMGdHK1RXcjVFK0cyUlhw?=
 =?utf-8?Q?jbel8la1Sn0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXpsTHMySzViR05zajhqendINlFhWlVMQVVNU3hoU1RwY1RQamxCY2EwWEsz?=
 =?utf-8?B?YlRQaWUraml1ek8zV1I1aEI3SHRRR3hkUTdLNXJoV1Z3OWFITlYyU0FHdmh5?=
 =?utf-8?B?Z3k3eTNBSkp4c1dDRC8rZlF4ZTdyQ29QYnpLQXBZZWM2NzdXSUZQZ3BKdnBm?=
 =?utf-8?B?YUpOSW9ZcGcySHlsRXpjWlgzWlMwcWJtRG8xQXFNVUtMWHlWTyt2RlFUT2VN?=
 =?utf-8?B?bDJkaXhvbXVDYzgwQWRKSG1oWGdadU9MdHVkK1pZRklDMSsrdWNmTHZRTUhM?=
 =?utf-8?B?cVRaQlFWK1hUZFRvdG5UME13Q1h0TGZIWjBhSzFoNkE1MEd0UU5BTVZKeHhr?=
 =?utf-8?B?UjBkM2pINTRXQ1NzRlZFQlpYVllwais5UDgzU1pmR3NiaU1jbVlkUVNFbUsx?=
 =?utf-8?B?bzhWSkMrUFBuRmtiMStUaURYZ2lLMGhEUzkrSW50QVRYeE5ITkVVU0t0NWcr?=
 =?utf-8?B?V1VFdEpQYTlha2drYUl4R2xmdndvK3JKK1h0S2dWaWlWR2VhVE9qaXl4eGtF?=
 =?utf-8?B?TllvU2J6OWlzUDJ4VzQ3TUUvblA4ZkNhSGlCck1MT2VJaXF2L3BZUjBNanRQ?=
 =?utf-8?B?MDd2ZlBBb1FSNURTck5CMVZYd1JIaUtkVGZ4MWdnNjMzQnN5alB5R1BGdEJz?=
 =?utf-8?B?WncxbEtMZk10TXMxY1doV0g1NWRtVVZraVRuL3k3OURIdSt6M1JUMlVtUWNv?=
 =?utf-8?B?d0h5UCttbVdCWHhpdWtDdFVWZXp3NTVZVTNFaUpxM0lqbjhicFZUNlE5VHNj?=
 =?utf-8?B?d2hoOXp5SUdLN3l0bDVLbld3Qi83UnpzTDZ4QloyREh4TDg4bnFBSGlLL1F5?=
 =?utf-8?B?UmRRTmxuS1lGLzJvbFN1WkMzSzFVdVFkVlExaUJCaEFwelhwcCtqbGdvN3Q3?=
 =?utf-8?B?dkpNakl2QzA4NE5IbEI2M2FibTc5MFJuRVVnanp6aDNXQ0VTMlROa2N1VFAw?=
 =?utf-8?B?MFNZRkxZNjY1Wkd5UHVoZkxvOVdvWUdPejh1MW52bzlESy9yOUxYc3hmd2VK?=
 =?utf-8?B?UEFqZGZsSlNFd0EyMVB3UXpFU3pvSFNuVElSaUt2ZnNGaFVteDNtR1l6V0tH?=
 =?utf-8?B?K1BSTldRSGI2R012c3ZmdlYwVFdEK2Q1dHVWaDYvRHo4U05uSmk4VG4vdjho?=
 =?utf-8?B?b1l1S2dweXRMTUo2N3VuRGtQTnlDZktCeHZVMmpKSUFPVTQvRXFIcTBFUVBi?=
 =?utf-8?B?Vk1kakdmZ0hVUHY4NFpYdzRRdjd0WlNLaXVDUVB5K21NYUN2eUM3WUI0RDk2?=
 =?utf-8?B?aUdkOUN4MGcxS1JWcmhxenh3TVFSam1mUU5Ga3dwSXhOYnJiQllUZU9Bd1lJ?=
 =?utf-8?B?Wkp1YzlJU2FwWGUvQXhsa1pxdnJvS1VBeXlEMDVkRjJuQ2JjVGJHVVdJM2xj?=
 =?utf-8?B?ZERKTnQ4bWpCWnoxZGZHUkwwYXRacmlVTnNwYzB2cEJKNVR6R2hqZTNPM2pZ?=
 =?utf-8?B?d2h5cUtSWVBTdmhIVlFNeGxjV2hDSHBJQnZheVlrbkJoaDlpSmcvOC82WGNw?=
 =?utf-8?B?cG9PeVBYZEpsbmFpNnE3QVlrcksvWWUwSVZZcFRsaGMxUE9TLzFZalBVL1FX?=
 =?utf-8?B?NHM0Y0FZeGx6Zi80S29yUzVwYVNkV3AzNFg0d3VsMmM1MlhlVTdRVVpsV21i?=
 =?utf-8?B?QWVCUTNDR25TWUpUa25mVnVicjkrc1pHOHJFemFmRWNqdWNKa0xxbDhGTXpK?=
 =?utf-8?B?YXpsbStvMXQzcC9uY2xKdlNxUThrOEw3bkRaVG5LTXNiMU0vNUZzZTZ4SUxO?=
 =?utf-8?B?RUw2VWlEOStMVXlnd0Y5RGxYalJ6d2dlZXpRSll2OTBLbVhkYmJyQkdrZXcy?=
 =?utf-8?B?WG5BRGI5TnhsZG5JNlN5OXA3eHJJR3B3OVFiRUcrYWY4YVJqOVJMaHNvTVNY?=
 =?utf-8?B?M3kzT0NvYTYyK0F5dXQ4UHNIVXJQVnR2Yms3cHc4b1ZIdk91L1ZIODF6c2VQ?=
 =?utf-8?B?cGt3ZWFCOFdQVGZnbVlHUTZ0WnUvNndDaU1DTzJvYzlZbklyZThhTWVpOURr?=
 =?utf-8?B?c0dkV25ONjVHQllFVzhySSt1YTdWLzJsZ2l5dEtDaDJsOW9lZjNEQzlzc2w0?=
 =?utf-8?B?MzNzMnBWcFRXSEhldmxtRmovekNzcWZSc3pDL2pIY3JORkFzV2k1L2ZHckJX?=
 =?utf-8?Q?fqHQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8466062-1eb7-4fbf-f7c2-08dd8bb38858
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 09:02:16.1982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHxiVHyU0hXlPcYvk9Yd7xl2CJFaOCw1KkWgdgHWl0u4Rg9xrA7YIEueGB1yLmUy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045
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

> Simply changing the uvd vcpu bo (and therefore the firmware) to always
> be allocated in vram does *not* solve #3851.
> 
> Let me go into a bit of depth about how I arrived at this patch.
> 
> First, what sort of system configuration changes result in the uvd init
> failure?  It looks like having a display connected and changing the BAR
> size have an impact.  Next, which kernel change reliably triggers the
> issue?  The change is the switch to the buddy allocator.

Well that is not a resizable BAR, but rather the "VRAM" is just stolen system memory and we completely bypass the BAR to access it.

But the effect is the same. E.g. you have more memory CPU accessible than otherwise.

> 
> Now that the issue can be reliably triggered, where does the error code,
> -110 / -ETIMEDOUT, come from?  It turns out it's in
> amdgpu_uvd_ring_test_ib(), specifically a timeout while waiting on the
> ring's fence.
> 
> With that out of the way, what allocator-related change happens when a
> display is connected at startup?  The 'stolen_vga_memory' and related
> bos are created.  Adding a one page dummy bo to the same place in the
> driver can allow a headless configuration to now pass the uvd ring ib test.
> 
> Why does having these extra objects allocated result in a change in
> behavior?  Well, the switch to the buddy allocator drastically changes
> *where* in vram various objects end up being placed.  What about the BAR
> size change?  That ends up influencing where the objects are placed too.
> 
> Which objects related to uvd end up being moved around?  The uvd code
> has a function to force its objects into a specific segment after all.
> Well, it turns out the vcpu bo doesn't go through this function and is
> therefore being moved around.

That function is there because independent buffers (the message and the feedback for example) needs to be in the same 256MB segment.

> When the system configuration results in a ring ib timeout, the uvd vcpu
> bo is pinned *outside* the uvd segment.  When uvd init succeeds, the uvd
> vcpu bo is pinned *inside* the uvd segment.
> 
> So, it appears there's a relationship between *where* the vcpu bo ends
> up and the fence timeout.  But why does the issue manifest as a ring
> fence timeout while testing the ib?  Unfortunately, I'm unable to find
> something like a datasheet or developer's guide containing the finer
> details of uvd.


Mhm, there must be something wrong with programming bits 28-31 of the VCPU BO base address.

Forcing the VCPU into the first 256 segment just makes those bits zero and so makes it work on your system.

The problem is that this is basically just coincident. On other systems the base address can be completely different.

See function uvd_v4_2_mc_resume() where the mmUVD_LMI_ADDR_EXT and mmUVD_LMI_EXT40_ADDR register is programmed and try to hack those two register writes and see if they really end up in the HW.

I will try to find a Kaveri system which is still working to reproduce the issue.

Thanks,
Christian.

> 
> Well, what seems related in the code?  Where is the ring fence located?
> It's placed inside the vcpu bo by amdgpu_fence_driver_start_ring().
> 
> So, does this patch provide the correct solution to the problem?  Maybe
> not.  But the solution seems plausible enough to at least send in the
> patch for review.
> 
> Thanks,
> John

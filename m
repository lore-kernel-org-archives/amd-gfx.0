Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14627CDE022
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 12:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D2F510EA55;
	Fri, 14 Nov 2025 12:16:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0HzCWKIh";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011037.outbound.protection.outlook.com
 [40.93.194.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B14CA10EA55
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 12:16:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTAAvQ+j42U4bh2asEmKAa9uu3eRvzGLrjMHYkmOSE9/9v6gfanErVt5WVtz2LfF8KxyKzdzYUcwMYUvLKrdXgO5HUSo5LpoJQY3ZOoq2API3Ubb584q+SFAKlkrXrtRRCXVUrXqw/KSfXn20KT2fXRPriT0YqIS0nmUw4kHW5qSOBRMX5tv8gkjgCuXrCa1bnwAV2GBu4iMSKxjFH0PmXkyIKCNu/mZm7SYBJkS/NouS98y5ZyR0oRR8kT2QktGoI6sUuX26xuFasGtmoDukchSQg/1JOf5JlSWnuqM/JJz2k3cdxswAlRA4lZEIcj9Z2BnYmpvTa/3HXoVyu62Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQSbTsTTRopJbksMLHE6Mh7ALHN8Or0bOiRn0X695rI=;
 b=WbwZYDT4rfr1Ifi07XeoFSfVJWVMqgILj9u0aZXbKKgL3qH/sWVMLaZAYzcZmDff4AlCHaF5zR6D7PYOI5c3suRBbR6IkMoKoZY9caEuQDT6zQAKj+FPRq7igTZEEIC755s1PuWAfbkD+PKoueBXIJVZ0v2rM6PT1xB7gBEqP9A7W39bxjqQPEdKuWJUo8SXCquTw+rwKtbT2F4E1uEToq/pudBsTt7uzoQXClVDn08xtLCtSTUf4s+PI7tB+plTPsBxiXwjE3dnAA75ymrKJsFFeA98ohObLmYn9qs2Lu0WeYH8bgFV1PMzXRpiykNe0xQet7k45pdTKmJYM+Lzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQSbTsTTRopJbksMLHE6Mh7ALHN8Or0bOiRn0X695rI=;
 b=0HzCWKIh1Eig7K1gQJxNz/M/HiVtI/yLvgPq1/z6t9ylfqIiBOU8u8NWs6Kcy7MOjeOcXAPSobg0v60BRhiXptIcwtfzAC6YfHkH3gh8SdoVkktKREThv3o9lsD1iTmmI1/A3Qt+rM6sAqKysYa0a0xxfewlrWdSisv2PVxrhnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 12:16:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 12:16:44 +0000
Message-ID: <72c36b2f-4996-48f0-bcfe-87faf4ffba29@amd.com>
Date: Fri, 14 Nov 2025 13:16:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] drm/amdgpu: Use amdgpu by default on SI and CIK
 dedicated GPUs (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
References: <20251114120736.31310-1-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251114120736.31310-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f41725d-f709-4321-f9bc-08de2377acc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHBycGNvQlFOZzJkNmxVenpGN3dvUGZ0YVp0VFdud1lXZ1BtUVZJdHpxR2V5?=
 =?utf-8?B?dWdxWk14SEJCWFNLN05oWGFrQS9TQXNYYVRKNDY4OXducm1xTno0dVhqOFFZ?=
 =?utf-8?B?Ky8vaDdla0M2dzhwY3IwWjE0QzU4aE84SXRrQUVWdTE2dWk4bWNleUEyQkhB?=
 =?utf-8?B?MDlhWEo0Q296VVFzRFhkRkZzTHYxSmc0cXRNaXMrOC9BMmhVTzJVM3I1MFJN?=
 =?utf-8?B?cDgza0lrNE1HVHh3cW42MC9TNk5reHJLQlJSdGRQdXE2ZFJxMlF5MDllUldo?=
 =?utf-8?B?SmQwelEwdjdrQzljTFpQMXJpbXhOK3BWb2R0czFOdjVZN1pOM1gxdm9HTmxO?=
 =?utf-8?B?ZFlyS0tkdTlhSEQ5K0RIRTBPR2JSa1BxUVY0blFzR0p5ZTREcXhZTXo1VEJM?=
 =?utf-8?B?ZXJCb1k0Y0xHa0pnLzRtT1grcWZDOEZHRVFIOThYeVhua1hLeHRQeS9TMllj?=
 =?utf-8?B?aFI0YVFWZ2VtVURza3F5bGQxc21HUm04STRyVHI2TWcvejNxVmRKOWxqUGg1?=
 =?utf-8?B?NWtXTEc1WUZJYVdSWmZPbnh4em1jSzVyM2dUZ1p0UWxsTm9GYXBKb1cwUURY?=
 =?utf-8?B?Ylk0QlBFWGROQXlXRzN2U256Y29PUWNuV3FKdzlBVjllWU9VeGZwaDByeDBI?=
 =?utf-8?B?WW5NZ1NBVkIwRy9uSVV5dDhwVExhaktyYmNQMXdpSjdiSEdRZzFodmZWSk1K?=
 =?utf-8?B?RmhpT1FCL1I4WE54MXZreml6ZFIzVVpWSG93OVVPaGRUT3V5UktTUC9CSmFN?=
 =?utf-8?B?Z295RnUzN3ZxcEMrN3JJWER4UmwyWHZLcDMwSllWNmtZUXJobVpneWhDSThH?=
 =?utf-8?B?U1k4QW5FL1JYc0N2dUZ0QXdZc0JsK1pwbExyaDF3M0h3WU5BaU91S1JyMW9N?=
 =?utf-8?B?VmRlSmFYaWNxOUw4SDR1ZE81VlY2S3VZNzJ1UGxiVUVYTVFRdExUWU9xdnJH?=
 =?utf-8?B?ZHlCR2NMUFdwbGhVSFBwLzlJUU9MNTlWcjNtWXNwTzVyTThHRnlsZlFkNm5m?=
 =?utf-8?B?QkpEYkhBTjh6ZW5hY2gxb0U3bEdJTVJzbGV0NUFJR0NtSjNiQmo4ajVNL3pq?=
 =?utf-8?B?RE0wV01mRGtDeWNVdERBZnVaZFlqVC9WRmhOaFMxL3Bpazd1OFdoNmhHek9T?=
 =?utf-8?B?L1hIdEVXWGxDWWRpdVpkU09MaUtqd0ZFbW0rMDM3MllsRzBRZnVvWUJPSGhE?=
 =?utf-8?B?VGRJcDE4a3NRZVVlbkFVRmIvVnYvS2hrbnppWm1TeTJUYUVMc0NDRndmaXBJ?=
 =?utf-8?B?dDJLaWt3RnZCaXN5cWZCMWxxdWlVUXZZbFZhWmVqMFhkVWU5S1FiZ2xyWDJU?=
 =?utf-8?B?a3p2MndyY1V3Vm15Q2xsSDg0dklGTG1vaWtUd0gwOEdRQmlUQUdyZ1l1aWZR?=
 =?utf-8?B?L0wyWkdFb3liUGRrWURaMkFheHFMU0UyUS83dm94ZlloOGN4ZEdud3k1aUdu?=
 =?utf-8?B?VERYeHYrSHp5amJ3bFVldUVvQTVNOExEMExjSTIwZWpnU1dZdnhFS2svSTNT?=
 =?utf-8?B?WjhCMGpkQks4a3p3NDY1eVdPN0xCZmZiaEF0aVpITFlyNWVMY3FYMjJ6Zzl5?=
 =?utf-8?B?TVFHbnNZYkR0WlF5dkFGd1pnSlRpTXI4a2E4K3BDQ1VlbEFseXlQeFpranBs?=
 =?utf-8?B?SlFWbWhBS0hUSWpaNHBwOFByTjNJRnZPU2tLU1J2em9YTmZiZHloVTJyTGNp?=
 =?utf-8?B?Zmk1YTFPUjIvTlduMEJOQ0ZZUXZjY20vaDNmMGMxeGJkaDIrdmRxUTNQaVlH?=
 =?utf-8?B?ZDBqekp0VlRERmgwcVo1OXlaYTRNaE1LandiZDJkQmtteGd2RWN2VEtIalUz?=
 =?utf-8?B?T2NWU2RQVzB5dUpIVUFMT0RDSnpvTll5V1lReUhMRmtMOFlMalkwVHlTTzl4?=
 =?utf-8?B?Z2tLZDg5WXh4WGF1U0IwTzdmSDc1bEI2b1RkSDdpaENlMExhSzV3UFlYbEds?=
 =?utf-8?Q?3Y21XhBSVMR3vTczIAf5xlZ3TMR8xjkG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck1rQW54bEF3aWhQRHR3N21IR2ErZHdrUUhIRlVWMEZITzNvWGtvRTBZbzlY?=
 =?utf-8?B?NnhmZW8wQUNvTlYvaVphYkM3V0p6eWJ6bHVDWWE4WVgyeWtsODlDeFI4clpE?=
 =?utf-8?B?NDI5OFdvN2RaazNHeVZQd250YlhVWFVXS2JYczkreHB0WWZmdnZQYWpCVEQ1?=
 =?utf-8?B?MDhsOFVsOTZaOW1BOHlMYkp5TWJxa1VQVVNiT3l3aFRXV25wY1k2L1BiZGRK?=
 =?utf-8?B?RFllazlmaUxOd0VTcjREQ1c1YUxEK1VJWVRXd2FndEpZcCt1SVNBVDlUQjR3?=
 =?utf-8?B?dzR0L2VoOUZIMklNQnBwUHg5Qk5DOTN0Uk5qNWtsY3pmVjhPaFdrRDM4Z2oy?=
 =?utf-8?B?NEx6U3gvNW9NeUNYZjljYklTUGorTTRLUVFSTXBzOUtjWTc4MzFXdUNMeXoy?=
 =?utf-8?B?RUJDWjY2dkN3Q2cwcTY3ZzIwYW4zMm5pazl6VTEwcUNuaDlYWkNNUVF1RHdy?=
 =?utf-8?B?SGRscElFU2kvYVlNbmpRZkpBbWNKOGVNS0Zkbk5PWUUwSEJjN1AwSDNpam1O?=
 =?utf-8?B?ak9oMU5LdEp1VzNKR3MyUDZNTUd3aFNzN2dtUkg1OWR5d1JqMDFmZ3owYnpN?=
 =?utf-8?B?RTNRMURxVDAxbnJiajZVSlFQeUVwVFp2NjJjclNjL2I3c3Jnak83MkpuQ3Zu?=
 =?utf-8?B?ZkoybUN4TnJCbDlCTkYvdmNQclYxV05GS01CcmhwcTI0VU4yRlQyK0Z5bG5o?=
 =?utf-8?B?NnlJV2JKWUJYWUw0RklKYjF4MUNUVHZHczcvUDRwNVZYRlh3MzV1OHJsa2J4?=
 =?utf-8?B?THVHVysxTFI0a0huQStXL3dWRGs1N2FwZDcxQVlCWE9KSkMwL1RhSHJEM01U?=
 =?utf-8?B?czJnNGwzSTZKSU1QWFBTMlNqQ3ltU3EzdHNyN25QeThkbklJMWJGdUloY28v?=
 =?utf-8?B?dGFxQVJIcGRFVmxpa2k4bWJhR05WUG1OaGtYZU1kbnlPaGpyTVR2UnRFbUpG?=
 =?utf-8?B?Z05RR0laOWJjNERNNUgxaWk3V20vNkc4N2hGblhUMzYybFNtK09TaXBnWHU3?=
 =?utf-8?B?YmtPT2hGWHpLdlJPS200VGRhUmRkVUpoVVN5dDlEbjN1KzlDcW83TGFUQ3lr?=
 =?utf-8?B?OUxyQXpXVjdpVWpnSW83OVVRNXl5U1UvRFRRZDJPbC95OXRlS2lMSEFzWitQ?=
 =?utf-8?B?M2FlUEJTaTRpSGRLeTJQa2xacjV1b2MzY05JRm1FR3JzL01VR1N2U05OMGFz?=
 =?utf-8?B?Q1hpK1U0Slg5Yzd3eVNoVDNpTzd4b3JRUE15RG5RWWxNckFiSnNobklPVm9s?=
 =?utf-8?B?ZXhpa2ZUUW0zUXpDMHRaR0pnMlFMSlNYQXBRZW8zbUtGWjUxMzVXTmpVemVT?=
 =?utf-8?B?QzA0WWh4U2RlRUpKSGRGcVNjc2VROXZWZTUrTC9XZi9rYjI5V1U4V2ZKYXRr?=
 =?utf-8?B?U2VzNjhiSng3Um9LRDlOcnBXdFZvOG4waEVvTzhXeVF0ODd1bWRQTmxzZ1VL?=
 =?utf-8?B?a2x1RHpsQ21aTFVYRGpNd3V0ZkZOTnV5TFpUSUdmK0lHV2tpRjd3Y09yV0xT?=
 =?utf-8?B?aEwrT2NLNEdzL1lpZis1anExN2hOaW1TNW9WNFVnUWx2OWFKM2RwMEFSamxY?=
 =?utf-8?B?N1RkVVhlam94azJVRkRQUktwVTkzNVA0TkJnV0FqQSt6N0tORlRxSURlZ3Np?=
 =?utf-8?B?NFNQTzRqZTRnd1ZtVXo2VnQwaUJwWmJqT01QYUFLN3J5cjFORUFOSS8reVRz?=
 =?utf-8?B?cGJ0SDJwdHFFNnlUcENBZFdhZVdpYnZUVE9KVEdVTWdSM1RvbVpCaVpTQk90?=
 =?utf-8?B?aURyZzRmR2NjZmxKTGNuVC9IRUhTNEhqenNBWG9Wbk1SdndJL3pJaTh4dnUy?=
 =?utf-8?B?RktCanYvOTVHaFNoYUwvUGRMeE55S2ZvZGY3Z0dVMTRtdHk2UG41aENGR25h?=
 =?utf-8?B?TkUzNG5xOWY5Qi85Wjc2UzRJSmxTUEY1MVJxa0xIMU82SkExalJ6eFhYeFJR?=
 =?utf-8?B?Y0w3dHMrcmEwSzBqR2V3dTBWSHprYnVPeW5IcmJwTWxybS83b0lobG9QUlJs?=
 =?utf-8?B?Mkg5Vk03bmpyeHNrWGo1RnJXeVJHTGhlc040a2tCTGlXN1ZwK3Z4dy8wY2kw?=
 =?utf-8?B?L3BxRGFCUUVuREdvTldsalZXbkhtQmFuVEJLSyszN05wcGxwVXl3UWwyQ0tF?=
 =?utf-8?Q?giAmoMP2nTmwZdUaN6OPrJ2pc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f41725d-f709-4321-f9bc-08de2377acc1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 12:16:44.1563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yNo7IadExkwWkQ1nTOehRvGadK9JKHx5qRk6N0Whbe8j+kKEuYujTV5isWZKvwL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298
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

On 11/14/25 13:07, Timur Kristóf wrote:
> Changed in v2 of the patch series:
> Updated documentation in Kconfig file.
> 
> Now that the DC analog connector support and VCE1 support
> landed, amdgpu is at feature parity with the old radeon
> driver on SI and CIK dedicated GPUs.
> 
> Let's enable amdgpu by default on SI and CIK dedicated GPUs.
> 
> Why?
> 
> Compared to the old radeon driver, amdgpu offers better
> performance, more display features through DC,
> as well as support for Vulkan 1.3 through RADV.
> (Note, although the hardware is 10 years old, the R9 290
> still appears in the Steam hardware survey for Linux
> at a modest 0.25%.)
> 
> What can these GPUs actually do on amdgpu?
> 
> Hawaii (eg. R9 390X) can even play modern games such as
> Baldur's Gate 3 or Cyberpunk 2077 and gives a decent user
> experience considering the age of the hardware.
> Tahiti and Pitcairn can play some modern games, albeit
> at lower resolutions and lower frame rates. They are
> mainly held back by a low amount of VRAM (2~3 GiB).
> The other SI and CIK "gaming" GPUs are mainly useful
> for playing games from their era (the mid-2010s)
> or less demanding games in general.
> 
> CIK dedicated GPUs are the following:
> 
> Hawaii (2013~2015):
>   Radeon R9 290 and 390 series
> Bonaire (2013~2016):
>   Radeon HD 7790/8870
>   Radeon R7 260/360/450, RX 455
>   FirePro W5100
>   various mobile GPUs
> 
> SI dedicated GPUs are the following:
> 
> Tahiti (2012~2014):
>   Radeon HD 7870 XT, 7950, 7970, 7990, 8950, 8970, 8990
>   Radeon R9 280, 280X
>   FirePro W8000, W9000, D500, D700, S9000, S9050, S10000
> Pitcairn (2012~2015):
>   Radeon HD 7850, 7870, 7970M, 8870, 8970M
>   Radeon R9 265, 270/370 series, M290X, M390
>   FirePro W5000, W7000, D300, R5000, S7000
> Cape Verde (2012~2016):
>   Radeon HD 7730, 7750, 7770, 8730, 8760
>   Radeon R7 250E, 250X, 350, 450
>   FirePro W600, W4100, M4000, M6000
> Oland (2013~2019):
>   Radeon HD 8570, 8670
>   Radeon R5 240, 250, 330, 340, 350, 430, 520, 610
>   FirePro W2100
>   various mobile GPUs
> Hainan (2013~2016):
>   various mobile GPUs

Reviewed-by: Christian König <christian.koenig@amd.com> for the entire series.

I think Alex already merged the CIK switch, but that should be trivial to resolve.

Thanks,
Christian.

> 
> Timur Kristóf (4):
>   drm/radeon: Refactor how SI and CIK support is determined
>   drm/amdgpu: Refactor how SI and CIK support is determined
>   drm/amdgpu: Use amdgpu by default on CIK dedicated GPUs (v2)
>   drm/amdgpu: Use amdgpu by default on SI dedicated GPUs (v2)
> 
>  drivers/gpu/drm/amd/amdgpu/Kconfig      |  24 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 160 ++++++++++++++----------
>  drivers/gpu/drm/radeon/radeon_drv.c     |  81 +++++++-----
>  3 files changed, 162 insertions(+), 103 deletions(-)
> 


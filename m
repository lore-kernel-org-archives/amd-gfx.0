Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8E9C5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 20:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68E8710E17E;
	Fri, 21 Aug 2026 20:31:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JCNuHoKL";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011051.outbound.protection.outlook.com [40.107.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E04F10E17E;
 Fri, 21 Aug 2026 20:31:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GexMJlqLQ2s3KbCcGxR+zo5WomF6FO7ryl5jmPQ9B0kKvjRRnt6YwS9XYYWUXwv8D2uJvhC+dZReOTX9MALFtM0MBqArrx27E5mOpGxoaXiDphB+ffOR1Tn9fNBmDxA/QT2/+E4llpKt9PvwunsChqp1lN0E+bfplVD1uqqdIBAPeWT9sx/HvLPXkTr9XHls3ofAxcNxmiibc6i6M1x2/kn7IVo6e4gFrg/MKllQEMXnL9lDs9auI+4NB0r0JgccYZJCGJXcgaCfJoJuHmNMUC9PuApkKsyFlybeklls/TQJLAEll5swFvZkME5qywR4BFsmVs0HZeO9M+qduPFJmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9A4QSwjELSel4rxSzKpeDeVBrmK/VyIEgYQBeDJ1rU=;
 b=smvaZ8zVnBQU+7b4l3j4Uh+PHq2JDOe3f/9quzjkESnBdvsSnb4m489mYwh6M/2um6TvcQUiix6MnUKXzeRrEmcqH6fIX+ceFQz4wsDATz8T+TfiTyscm/hFgDgTv+8yWpXw99F4HBCtP9dY7HSvuaJoAbYYT77zMaAWuTDIrk8AetbjBgp+diZBAu00Cl0SBCf4I0yGtCdn19cmnQYJwOSUDpym3WMsO3utq8B4sJQB9TVesYjJcrUMjTPPnbLoV/LdOiDVjVywCGecY9kK+H0dmR4YG2ywp/04a0Of78Qg8RJdnxEEDPzMknWJjsjb32mIwyrha03MjnsQRpLO9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9A4QSwjELSel4rxSzKpeDeVBrmK/VyIEgYQBeDJ1rU=;
 b=JCNuHoKLAMy+zO3WW/hqgMm0i+x9D5BzaCcutCFA1wZ0A1bgr3lv7bMgQ30YJ3+a0KdYse/psPPNciHs7pOL9R3zq4RfqxOxghD81e1m68wIezR0khn5J2cVj3Z0Rtg4LWfmxngjOBk7WqNiVawGx1Z2MizjuR3PDl5XptbRlz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by CH3PR12MB7641.namprd12.prod.outlook.com (2603:10b6:610:150::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 20:31:08 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 20:31:06 +0000
Message-ID: <edb965a1-3d35-4dd6-924f-52e88b91a8fd@amd.com>
Date: Fri, 21 Aug 2026 14:31:04 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] display: fix blend_mode for non-overlay planes
To: Bert Karwatzki <spasswolf@web.de>, Joshua Peisach <jpeisach@ubuntu.com>,
 linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, Leo Li <Sunpeng.Li@amd.com>,
 amd-gfx@lists.freedesktop.org, Jesse Zhang <jesse.zhang@amd.com>,
 Amber Lin <Amber.Lin@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, amd-gfx
 <amd-gfx-bounces@lists.freedesktop.org>, Melissa Wen <mwen@igalia.com>,
 "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
References: <514c5423b98376e2e6f1fe4bb56c0f3607b4cd52.camel@web.de>
 <20260814151701.65222-1-spasswolf@web.de>
 <DKUUGMJ1H5N5.2FRQG3ZKH6SNB@ubuntu.com>
 <7ac562a41bc25f459c2102a01f2d07f2437984b8.camel@web.de>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <7ac562a41bc25f459c2102a01f2d07f2437984b8.camel@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::35) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|CH3PR12MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: 4deda4a9-2a90-49a2-09cb-08deffc320c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: VMw7R7KvLFk3iyWIH7cMgp91Y3HzzHILRAUjKOVVupvbhjT8p/nlTeHWwjSLGg0/paVd2Wjuohc3O70Qnyj52C2xfS7xTr0nfT8a3fK1xyfBKB0czwAy19+IGpKXwcW8XdGwwRwmN6x0eEK1Jgj3MkQSUkrhCvETvnKCzze+hF9xqW+ln4/nn30jfVoMzU/GTAgpzLN6WKma6kkjWCD2vEvhCchmhy0/tBFzqjSkBvgeRSNMAn3CC62yzy5kjO00d09dn3LU72swT+FLpIhDdFN055ZdywNdACgsAZmg2CWM+8nCSHmi7+TVhs3BgOW+hex23cNdlrKI+OqbeA9I/x+2Qt9PgMhw2h1+xooQu2mQkhNVy2z7L+Ovo4syhmunxiCXqRgFV7zofGuT5uuKNCOmUFxCAK6RE1xQMqZoY8uYP93j+rkPln/cjqcqhlRtXJekLP5KMn4M0mxbMtQuIXWVxyNytCR8ZvMf17RwvHNVc/S07VAExwJGHRMSqqniuvziMQ87ifN589F6SmKYRZzjvIWFu3onvsgYPbiwHrGJhxrUyAcorcmkZBYCc48AuIzBD9OvhJaToaZOYTkljNDCAtQnx2/dmCUzCSczruuNiVZu9Yy4NqiZAVxwubrt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTdxNm5vY2pZcWhqczJMcktXMHBsbkxjd0I5bDlyQUpoUmpFdDFIenEwZ1k0?=
 =?utf-8?B?am96d2d6VldVc1BlcGZIemRtaS9VMkFtdTFDZjRNL3VoNHV3TlgvbE9BckM4?=
 =?utf-8?B?ZkZYTFFrejBTeVJVUGR2a3BkWlJvWTYvNkhBVmRwOXh0citQMWVUVnpIdERu?=
 =?utf-8?B?QTcrSE84SnAraFJxM2gzenk2WGRuUGhCbFZ2Y0hFSCtKQzBoem9SWlc2M2M0?=
 =?utf-8?B?TXBNK3BwTlFNUGI4cUVINWY0SXVObjBtZ1d6RDJiN2Fncmd0Qys0L2pyQUhC?=
 =?utf-8?B?V2FDV2R4UGFieU5UdmVEUlkxN1V6S005TUgyRmZkYUxidGl1d0IxN2o5NVJl?=
 =?utf-8?B?bXQwWFNhcDRtVVhQbmQzanowZ0ZmYXBnOWZ5WEIzMUozS002QXUyVW9PQkZy?=
 =?utf-8?B?a2U3RzByVURHTDZ2cEtXdVpCNXllUU0wOHgyUXR1SFdZazJzTlB6TzhaY0tL?=
 =?utf-8?B?SkhBUkgrVStnSFU2blRqZnFSK2pwMG0ySExObmxKRXhHd3lkUGNnS21QeHJB?=
 =?utf-8?B?cHZsV3d6WmxlUWZLekxpK2x3SjRPU0xlRFRlNE45UVB2SkxveFJDRWhpdFVl?=
 =?utf-8?B?SDc4MHVlNkk0QWU2OWkrZlRieWtWQzZURHpIMm1XWHhlZHNkYWVQUENwUDNl?=
 =?utf-8?B?a0hsRlpCUTQ3eG9kaEI1RllZMTJ5ZkdDRXNQU0hJTXhLTVRMWGpkSm5RdXFG?=
 =?utf-8?B?clhBbHBQSGpGbGJFYy8rbjJhUWdPSkFwRmR5N0JqT1FDRzEwUXByYkZsNys2?=
 =?utf-8?B?TVgrN0hCaWRkTjV2aG9odTVTR1ZIMndBS2h3ZEMwMWdlbm1meVl1RXRJSVJm?=
 =?utf-8?B?QUdUTU5vbm9BMlBLdUpjME1aV01wZlNHY3lGQ0c2WGJadnFmNzk4ODc0eXRl?=
 =?utf-8?B?QXNPSDBLa0RKL09jQXRreEQvYjVUUFd6aXlucGdsRW5ON3FLK3R3bWMya1Bp?=
 =?utf-8?B?RDVTbnVMOW83cUFyZVVsYmdhemQrWmJQLzdSdS8rNlZkakZwaE1tTklZZ3o4?=
 =?utf-8?B?a3ZYbU1TanBTdFZsV0dWQTYrQ2l4OG5mVDBaa2NiZTdkN3RLSks2Q1RSQUxP?=
 =?utf-8?B?Z0RkQzg4aEQvU2t5b3BJUXhNQitpOG4rZG0xR3dOOXNjLzJ5M2cyem9mT21y?=
 =?utf-8?B?SmhFR0c2TTYwb1J0M2NCYW9YNyt0aUNwZHY2RHBUc3F3ekg1c0VjWGFKb0lu?=
 =?utf-8?B?OEFUaUJkNVBrdTF5K3dIT2JNNHhHb3FGNldUK1p0RERibHVwVmFnSkIzZzl4?=
 =?utf-8?B?NllYSXRWR05sTnRIN1dRSEhtS01uVnlDY2pSKzVOY1EzZGlhbGJYUXloNEJm?=
 =?utf-8?B?TFBBbUJSUU9JM1U2ai9WTTc4ei9KQ0JmSEdtU1dQRlVrVWZ1N0dnbHVUMDls?=
 =?utf-8?B?eThiQW1hTjB0T2M0OUlpMmp4U05TWnU1QVUrYjl4dEo1Rllwb2JVY21FKzV3?=
 =?utf-8?B?b3BkTW9vRm9mVTd1NUljaC9DWGxNT2UyMjducDRwZUV0MTc4UmlVTm56NUFZ?=
 =?utf-8?B?Mjg2cnJWUW52S1I3SXQ3SEo1STFLZnlsL2dKRlRHYkhueGNTV250UUlnT1FM?=
 =?utf-8?B?VmRpdVhlNzBjRjNUVTQ1WTNlQ3Y4RDBMTUVvd0prYWhPbHIyZGxtQTAyM3Iv?=
 =?utf-8?B?Z0JUNFdjTzhmMzRQNUV2dmlaRWJOZlFIZHpZYWpBRzRhRmw3V2xKSXpyTWVB?=
 =?utf-8?B?ZGdYNTVJWm1GVWhkNFZ5eStDZnkxeE1NYjRnMnZpR1RDbGNzTkluY203T1lz?=
 =?utf-8?B?c2s0eC9IdEI2bkgvNkpGdFZhRUs5VVNSRk5nZ1JweEF6cFQrNUZNUmxzb0JE?=
 =?utf-8?B?dmZ3VVkyS24xUk5MZEpDekpEYy9iWFU2U0dVMzk2cE14SlRnSENUd0VPYUZ0?=
 =?utf-8?B?UHdieG1Zd20rWXZRNmFzNFFwZEtMOUhtQndPd0J3cFBDT1B2Q0lZTjlUYUpq?=
 =?utf-8?B?VkRtRkorRGN6V1BSTzZHUTVmMTNqci8vR2RYNjZ1T250eVNFdFZpREM2aGJo?=
 =?utf-8?B?amVoVW4ySFNvUGdVUEp2MU1va1EzMzQwUzZJcHNSQXVJUHJod2ZZT2ZZRlpN?=
 =?utf-8?B?ZWpIaTc5MzVxTHdUTGxINW5IRTZXMHRNbjQwd3ZhVnB0TjZYcUp5OWh2N0lQ?=
 =?utf-8?B?bjVhdzBKcVlmWFJsSmRwTm9jTG0xeTZWeHRCS3U5Vkl2Z0RxRGh5WlZ4Z1Ju?=
 =?utf-8?B?NDZFVXRsUmFMTXhxbzgzS0RUM2h4VUJTaU5FeGhJVW5Qdjc1KzJpdUxQVkNO?=
 =?utf-8?B?Ym1VOUlHZDgwYnZHZ2lMWWNzVFIzUE42SlRXWWJyMlJFLzVHZDBEL1JMU2ww?=
 =?utf-8?B?ZnRBM2Z4VnBrNTlVL0FKc2Jrb1Vwck1DYTNESk5vOTBZaGNEbytxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4deda4a9-2a90-49a2-09cb-08deffc320c8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 20:31:06.8282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KyvCMQfn8MGTB4N61eZAaH2b+72odUf//QthtFOxgB4tlp9AomUagWPF73RBV+ZvA5HIgZgUKLiMV5fxUdS24w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7641
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

This looks like a fix for the same problem Melissa tried to address in

https://lore.kernel.org/amd-gfx/DS0PR12MB65342AEDED0D035DFA92E4189CA32@DS0PR12MB6534.namprd12.prod.outlook.com/T/#mf6847a9e8d013adae40afa3c2ca0c64ebd3fcb50

Please advise if it is for a different issue.

Thanks.

On 8/21/26 13:42, Bert Karwatzki wrote:
> Am Freitag, dem 21.08.2026 um 14:47 -0400 schrieb Joshua Peisach:
>> On Fri Aug 14, 2026 at 11:17 AM EDT, Bert Karwatzki wrote:
>>> Previously drm_plane_create_blend_mode_property() was only called for
>>> planes of type DRM_PLANE_TYPE_OVERLAY. Since commit commit 860e748bddcc
>>> ("drm: ensure blend mode supported if pixel format with alpha exposed")
>>> this results in warnings from validate_blend_mode_for_alpha_formats().
>>> We fix this here by calling drm_plane_create_blend_mode_property() for
>>> all plane types if the plane is supporting a format with
>>> per_pixel_alpha.
>>>
>>> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
>>> ---
>>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c  | 5 ++++-
>>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 3 +--
>>>   2 files changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>> index 62eac6e65334..a6a54351ea56 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>>> @@ -755,13 +755,16 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
>>>   	struct drm_plane *cursor_plane;
>>>   	bool has_degamma;
>>>   	int res = -ENOMEM;
>>> +	struct dc_plane_cap dummy_cap = {
>>> +		.per_pixel_alpha = 1,
>>> +	};
>>>   
>>>   	cursor_plane = kzalloc_obj(*cursor_plane);
>>>   	if (!cursor_plane)
>>>   		goto fail;
>>>   
>>>   	cursor_plane->type = DRM_PLANE_TYPE_CURSOR;
>>> -	res = amdgpu_dm_plane_init(dm, cursor_plane, 0, NULL);
>>> +	res = amdgpu_dm_plane_init(dm, cursor_plane, 0, &dummy_cap);
>>>   
>>>   	acrtc = kzalloc_obj(struct amdgpu_crtc);
>>>   	if (!acrtc)
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>>> index 824ef3ce5de0..4c0c6a8a0dac 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
>>> @@ -2208,8 +2208,7 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>>>   	if (res)
>>>   		return res;
>>>   
>>> -	if (plane->type == DRM_PLANE_TYPE_OVERLAY &&
>>> -	    plane_cap && plane_cap->per_pixel_alpha) {
>>> +	if (plane_cap && plane_cap->per_pixel_alpha) {
>>>   		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>>>   					  BIT(DRM_MODE_BLEND_PREMULTI) |
>>>   					  BIT(DRM_MODE_BLEND_COVERAGE);
>>
>> Not sure where the full patch set is, but this does make the warning
>> go away.
>>
>> Tested-by: Joshua Peisach <jpeisach@ubuntu.com>
> 
> This is actually the only patch, the 1/8 is an artifact from using
> git format-patch which I forgot to remove.
> 
> Bert Karwatzki


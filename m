Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E764DCA5FFC
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 16:10:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B36E10E184;
	Mon,  5 Oct 2026 16:10:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rYe152FI";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6E5C10E184
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 16:10:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkyd0I/OAmiEZtxZ6gFezzkW/VheYLXMjVrNyAkN9f5LcVmNnIueEFJmpD4nC8qcsScA6uvCStpaCBCXlAd8QIb1PsddwVV5FG5sV6Z6uCvOWGPNsiTUEpwfil5qgnLrtGN9WsN1Fe/d3Jdy4RUkMxfvlDgYoER1lfPGiMM5VOBuSWw2pkBKoqGUuUEL4J1nD2h3G+5oSJbVGTEQVuT1y7Ou0ndSlrvUt7lc1Sla8ElqRaUo990R/5tgHi3kegS0ePODsbtj2G76Y0sHmux7RvMmTFqpjMJY2zlZqW0QzcvnQDPN5WfQY3KDl4Y/oju0RzCtmclX4tQMaBOtk7L9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h51KG5QHvksjDU2l5SH9JSEUblVoXPyDFbwIzv92ux4=;
 b=nEsjydyUiH4N7OGeP+XlgW0EKFp7fqwRZmbTV6h3hHJnFZbFeFDTkkqKBmHLchQvEwaHywMAUErvA8dAKSsApO4oYjqruUVNvPkOXLUL83y5+dRNbUfc16OVe6NhGpkyCIefgup3Qv3RXYo0YQuDB0lGRb11DwY5pHTVMcUqVOqHQPK6fIRs8XluGimQVZavurj5GIY8m69VHSbbdnszOH4HkcaQQsB4+EBwu/Ca0zXqr+ICccPNSmwma/glaGZTx45RTfjQgHDIkF5Nih6GngLF747XniA/clHzI6+L+7LzKO8HzHqWiw2aavXuZsQ9xNUsMYY3RjrhgB1nh83FuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h51KG5QHvksjDU2l5SH9JSEUblVoXPyDFbwIzv92ux4=;
 b=rYe152FIqV+tVJh8Wz2tvc7VZYdfaXA+UQYg63CC2g3r/ozdGPnMEKnlK3GvYVDgyKSaJIqVPo9lqyKuRl2D56tZljX/P8nXxmd45jcLrHtLqz8kh0QhEAgGyLvXuwEwNkKfeR/e9GLLA4f7l0IqUILjzWpItUi3Bbev7TU8Z70=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4SPRMB0031.namprd12.prod.outlook.com (2603:10b6:8:349::17) by
 MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Mon, 5 Oct
 2026 16:10:24 +0000
Received: from DS4SPRMB0031.namprd12.prod.outlook.com
 ([fe80::5a9e:89da:d693:13a3]) by DS4SPRMB0031.namprd12.prod.outlook.com
 ([fe80::5a9e:89da:d693:13a3%7]) with mapi id 15.21.0472.015; Mon, 5 Oct 2026
 16:10:23 +0000
Message-ID: <2fe98d68-88dc-4ede-bca1-4eb8c13ff2ae@amd.com>
Date: Mon, 5 Oct 2026 18:10:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Allow VCE SEI command in IB
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261002145248.30879-2-david.rosca@amd.com>
 <CADnq5_NO7sDFC0m6cwfz=n4BQG7a6us0s343HRuq4nN0opDr9A@mail.gmail.com>
Content-Language: en-US
From: David Rosca <david.rosca@amd.com>
In-Reply-To: <CADnq5_NO7sDFC0m6cwfz=n4BQG7a6us0s343HRuq4nN0opDr9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::32) To DS4SPRMB0031.namprd12.prod.outlook.com
 (2603:10b6:8:349::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4SPRMB0031:EE_|MW4PR12MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 651decdd-eee2-46b1-55cf-08df22fb296a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ZwUQYi2NvBMtTKEvbzTlupqr2a1kIJ0BGKO3C5iFygCmvBlRsy9oCthvCAg1WrWgHGIa3IqA0quVs5aiQM7miEuAgRwZSxqTHHcmizxw9l4pxAqWSkWY64PNMEmzfSFFfvfJALgomcsV1a8pWx/NExfyNc2yWfx5/UzKpU9vhR3cBWjG0r6VCOPK1nCPK1IgaJr4M7pU7ash1JX4cubttAxrPl81bRoMsLOIR1MwWHJSBNCzKGsax09Cmq0TweDJPXtKiVW6DkPKFI8qIEdA74/E4RnyfGbn39YSl73LZZ6AMTehTBNvpaRziEn1KkUwrufjCP82YXcTK95n89sQh9Z20OBGRoqkWbTvAbn8E71dLFixEH/l84r+gfOhN4eEcyUg0+5n1v0MgKSeH/ZD/7S2JX7bFAMtzcLdoLvIQ4joagxGOE5/4Nyyr4HQZkQqljmDnocytzouPX144FETx/elEykS6E9bZkV2JsfrAF8h6xPOgRH9apS+0WKN/7eNuMuTBOt9KBv2MvPh/q+MjHDqqji2buy/5O9UrePpvSyBLYonWwfH9LsiKMz/sWihFuJYP1JgD5DZuAJe6XZ4sUQxnQWlowE0ZAvoxCGdb3+At1Pl/cL45D93IEx+Kojo9R5aKqAtUxH6SbgV9nBC/Afow7h5a8Uaqi2gtsL52mw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4SPRMB0031.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlFpV1YrNmhVMmNDcEI5ck0wbklhenF4UE03b2x2aEd5TE9MemxqZXRpM0k0?=
 =?utf-8?B?UGxOSmVQSDVMS2NrNmlhSG1KMHFzTjFQZnMxbXA4eUhzT1FNZ3A2d1lhMi8v?=
 =?utf-8?B?SWZOR1hmcUdiSWpISnpUZHd3MytKaWsrU1J0S2hYNC9xVVBLZ3FXRDlaejMr?=
 =?utf-8?B?ZTcrQnZ4SDJkQmRMNXgyMEVldW9VcGdYUXo2UllISUFWR09YVFd6TDIydnNq?=
 =?utf-8?B?UHBPMEZvalgwejlSRDJRYkVScGUrYndMZlFGRDdwN1NXQVkyK2ZUUHZFSW1o?=
 =?utf-8?B?WXFFWGRRRVRPZXg4czR3bm81WEYzZWVxbUJ3eEp0NFF1SkRxWEZrMkV0REVm?=
 =?utf-8?B?Q1RlMWwyYjZTM0paZnN4SkphRjR0QkcvWEJsQ2VXWko4ZFVnUUNqdEEvalhJ?=
 =?utf-8?B?ZTRETW9NSWFqL3BjUmJaOUNvYnlzNUloOUxyNWNlbkdndTI1KzY2L0ZuazU4?=
 =?utf-8?B?RHR4WEpOcmszd1gzWjZqRWlJRWFFWHRaRkd4bWZZMFlENzVydlhyT0Z6QUdq?=
 =?utf-8?B?VGNBdU9MTjhvVit4dVllTDkyMXFLUWs5bWtibU9neWc2QTlOVGhmbE56Z2di?=
 =?utf-8?B?UUc2R2doa3FvYnUxanFOM2kwa2pPRkJCN3ZsQ1REaERNQ1dSdVdCUHp3V0tG?=
 =?utf-8?B?QXJEaEhQMC8yUVluV0hKTHN4VGxyRzQzdDNoOStiWmJkMURoWjliMmVWbGtw?=
 =?utf-8?B?ZVg0UVBaZE4vcTgxdnN1SWxvN3JCOTBQUGxRRmxnYjZFYmZlVlBMV3l5K0Z6?=
 =?utf-8?B?VVJuN1grWUNCazg3TWw1MWJjbGsrR0c4Mjc5N2IwMTNkVWFCZEZXRE50cW5F?=
 =?utf-8?B?STMrOGNMejd2UjMzVlhad29ZeGZ2S0ZMM1FkM2VURnBESjhRTnFuaHM2SCtF?=
 =?utf-8?B?bmZ2bUZOTjVvdUZ6OW1zRzBMM3gvSklzTFQ1SXU0dEtHakRFdUpGMjFOSmpu?=
 =?utf-8?B?c1Vvbi9RVlJsUEtubHNmZGZYY0Z4a3hSZStnRDdMaVZFSFV4NkNhN3I5MVdw?=
 =?utf-8?B?eVp4SHViTDVlOHpzMHo4RnpJcHZXTDJOUDVMd29mWGpWeTZEeXdWaVpLOUpF?=
 =?utf-8?B?TlF2UjJkM1pmTzJiRnBFWEFnQmJkSHprN3NWaWdhRXIrTk1GNmNQek1keUtU?=
 =?utf-8?B?eUF5ZXdlM0dQTlYzb2Z3VFR4VlFHMERaRGNNVTFDK2MzNmNSZW50UWJSYjhX?=
 =?utf-8?B?V1hlMTNydmJFV0RvMkZ4T0hOWDFQRDFvS3dReHhSZU1VaHR1dU01ZzVuQ1BM?=
 =?utf-8?B?VDhDUXhEOFNvd25mNGtDQndJTmxQa0IzUE5mQTdEK0YrTmJCd3VBd3MyM1RD?=
 =?utf-8?B?VENvNUkvQmZnTTVmWG12a1VXanZJTnV1cC9zMk1IbkpMdUFJYzgvbkZYam9X?=
 =?utf-8?B?UE1Pc3ZQdm56S2VEeHBXS2ZTdnRWQm54Ym52SkR3NGx3MUpmYVYvaUxGOHdT?=
 =?utf-8?B?bmxpdnRzRmYwSzdnTVRVUTBlV2RUNnVNRFBkTTVzMW9ocWhkby9hS0tFZG11?=
 =?utf-8?B?aHR6d2t4TXNORTl2MHVZdEtyanRvVXNCMW5jSnpGOTVLaWV0V0FvZDVQS1Bi?=
 =?utf-8?B?OGtiUmNyQ01xY3VoZjhncmhRNENVc0l2ZGVOL0U2VG9udU9CSzNSc1JtSlp4?=
 =?utf-8?B?NlhRSTFFV0loNVUxMXRRMkhMVGIvUzF0Y2srVnhZb29pV0R2QzRxUWxXNUpw?=
 =?utf-8?B?N2ZBQm5UakNaNGFkMlNNeTkvaFN6cXVzaFd6eHdOZ1ptM3U4V0tqOUt5SFBj?=
 =?utf-8?B?SUJxejBiNTdGTitRU3BVNVIyclJYd1F3UmRMbFVQMVpMbm5NL0FoQTkwakp6?=
 =?utf-8?B?TU9zSU1jazB6MytlM3VKS3p4bTJ0MFM4bEZvbE9pWkRSUC9XbWU0V0pGS0Jw?=
 =?utf-8?B?VzRJZWdpdnhlRGRoVG9OM3RqelhKcmp0SEZyNk9IUWF3RjFmbUN0dmhtQWFU?=
 =?utf-8?B?SGNrS1haa2x2U2tLbjl4MkpsdGRsV01xQUJ5OENrSmg1OXBYTGwyMXlRMXFt?=
 =?utf-8?B?bUNtczB5b1p2Sm9oUjhnbjBmdGl0Z01ubDVucmJMYUJnaTRFWHRxc1ZYQUN2?=
 =?utf-8?B?NzAwVktJU3BNdFlKUmNjNktMaGptSzE2M3hWYzRFcEZVbkIvWHp5VmFuVzF1?=
 =?utf-8?B?elJudVF4dGh2ekJxYmhJTitPNVM5a2VkWHhscG1hMUVvY3ZOaTY5V0FyRkNZ?=
 =?utf-8?B?ZUdXN3MzV2pNWEppUG5VcCtrNW5XQlNaRE1hN1p1V3l3bHZzb2F0ZWx0b3Vn?=
 =?utf-8?B?aEVhcjRLSVRBZFBZT2JkMTZjWWJTb3NuMzk4aEo2aDdnQy90bWhlcmtPV2VR?=
 =?utf-8?B?UXUxZndMb0kwYnJzbWhhMUVEaDN1Z1ZRTkRML0NTemxkcEZBRXhkQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651decdd-eee2-46b1-55cf-08df22fb296a
X-MS-Exchange-CrossTenant-AuthSource: DS4SPRMB0031.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 16:10:23.7911 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KAhVRKUhExGvC25hXEYc0Tin+1dnYKEuarHfiQTV38e8am47WZORhhw3tUrB8mVi1z9aSHO3HYu35igJ8o88w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165
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


On 10/2/26 17:34, Alex Deucher wrote:
> On Fri, Oct 2, 2026 at 11:31 AM David Rosca <david.rosca@amd.com> wrote:
>> Mesa will use it to get the slice offset in bitstream from feedback,
>> which makes it possible to filter out SPS/PPS headers that VCE 1 and 2
>> FW always forces on IDR frames.
> You probably want a driver version bump as well so mesa knows when
> it's ok to use that?

Yes, but there are more changes needed before that.
I'll resend this as a series with the version bump.

David

>
> Alex
>
>> Signed-off-by: David Rosca <david.rosca@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> index 39d87f3df9e0..bfad44ec7feb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>> @@ -920,6 +920,7 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p,
>>                  case 0x04000007: /* motion estimation */
>>                  case 0x04000008: /* rdo */
>>                  case 0x04000009: /* vui */
>> +               case 0x0400000d: /* sei */
>>                  case 0x05000002: /* auxiliary buffer */
>>                  case 0x05000009: /* clock table */
>>                          break;
>> --
>> 2.43.0
>>

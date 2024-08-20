Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91508C531DC
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 15:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30D0C10E040;
	Tue, 20 Aug 2024 15:07:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xmy384Ui";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E816210E040
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 15:07:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjTHexHicIRcMXyDcfLwvW1SAthrsGLeyCnN1trKxGLFRZ/smismUWy44zEiXw128YBShg8dISOtv1EF9ZzM+385oy3VAVeILRcqF4pGF7k6LNaJoGOoqK/TcUczzOBUGEqDX8PSYNKhbIjoQUXsJKWth00WuoOeX3Zv/VAtaUUBU+qcuyoqRqje61CH1cpJKOScquzr3CjWoc7JHh0WPKAbwYaY7mM7owppyo9x/IQWD8GEiAr29PmdkAINr/8XuZePNbT+lMjIaFkAhfHXSl6nymY6rnvi4g+7Ap+rURawr34rCBjIragD3vhVGdErhWvG82sRqTC3+kaUOvE3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s73xUFnLHmkrcgbyqsCoJzi6olCKXL+uAHw2KURYgCw=;
 b=xyMOdVj5zFzBHxCxfcxb3HEnLY2eqUnnBS6n24dDYJpYi9fV/GhxiBLdBP7LCRM7/1jDu2vHdXcKa8db+CQEXLfyttUYHkkEUmCSM0AqEXq0XUlbVNgv+gIMPhl1XWz+zmLbKbF0vwHtVTeGuN2A1l/bqHGx6GlyqB3mKzePI69WoEdZShhBXnmeLJfl/LLUzkZeH+yRUzT40lsUjD35oMTWkUlM8NvMKIOEzqoRm0G9UhnyS+qusHyCSM0niGvgdT9DYLugCPcm3BxaELJUqAb2i2fubXGeIL85bm28FaQjeIXFm+XCLGGSXsccO7NHw96s0QlnHHLiNIjo5oSOwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s73xUFnLHmkrcgbyqsCoJzi6olCKXL+uAHw2KURYgCw=;
 b=Xmy384Ui+HpAgH5pDa6YIhEedWdtyvlsoLyJRjnHVQpL6HfPmDv5ZBrKn649HuyNQljDOMAoD5XeHYqnd3MHw0Pj5hxnr9hk98eShXhhLyyLyaFgvOZdwu/oyvq2NmjfEWs7e9XBq1Z2AkdBtUXE6VzXK372b12fAjxpDb2HcIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by CY5PR12MB6370.namprd12.prod.outlook.com (2603:10b6:930:20::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Tue, 20 Aug
 2024 15:07:35 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 15:07:35 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: Do core dump immediately when job tmo
To: Alex Deucher <alexdeucher@gmail.com>,
 "Huang, Trigger" <Trigger.Huang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240819095331.460721-1-Trigger.Huang@amd.com>
 <20240819095331.460721-3-Trigger.Huang@amd.com>
 <a0978549-9bd3-e985-76eb-f50115f76bf4@amd.com>
 <SA1PR12MB7442E8D1DB91114A51FC9EB0FE8D2@SA1PR12MB7442.namprd12.prod.outlook.com>
 <CADnq5_MqZqWnd1ZL-O4vrKNCVuz6+fgp66BYNVw5y7iMbY-hyQ@mail.gmail.com>
From: "Khatri, Sunil" <sunil.khatri@amd.com>
Message-ID: <2c894489-e32a-f143-5d9c-51916ce4f119@amd.com>
Date: Tue, 20 Aug 2024 20:37:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <CADnq5_MqZqWnd1ZL-O4vrKNCVuz6+fgp66BYNVw5y7iMbY-hyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: PN2P287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::9) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|CY5PR12MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: c6352aa7-9144-4da2-0127-08dcc129d2a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qnl1aWVJdTBNTDF2VHNkc2dXT2xvdGlCOFJrTC9zVEJOVWVqVEpCQ2ExQU5R?=
 =?utf-8?B?TEcvTlRQQTYzL0FXZWxDcVNacFlNRGpiRmFCTkRWaDVOVXk5dEpvcjQ5VFN0?=
 =?utf-8?B?azVyaForUVNVeURvT016UlJhMnNQeU9QcHN4SkRySmJFbDB6ZHJrejh3UFVM?=
 =?utf-8?B?NG1lQmRjenN6dzY5d3UxcVV6RktYMEFKVGJmaTBSVFNtSDJCUnl4RVhlQkRm?=
 =?utf-8?B?eThMOG05K2VVZFNrRWJqRmthdEN3cFNwWWhMcUFFOU9PWUFZT0sxWHhqRlNo?=
 =?utf-8?B?c09pUkVkL3NXM2RxSkpsN00yc1B0NjlXTE1uOGh1M2tDR2l3bGlub1JxTmV3?=
 =?utf-8?B?UStZSnpZLzQ4VXk5NjhkZ2I3eWRFZTROZ0RiQnVoNDFDdUpvQXNiYVVTblFr?=
 =?utf-8?B?R0FobE4xazJaUHdTNGRBV05tbkRXdklvSWZDeVYzSUdPcFFDcTZ5cSs0QVVT?=
 =?utf-8?B?QzBQVFJIeGkwQzNaUlc5L25tZGwxYXlQc2Rya2V2YlZiZGRweXpabFBoTjlW?=
 =?utf-8?B?QkZWUncwUGxGWmFvd1RJSVNrK1F1NXF1enM1eFRHZ0JHTmJvWTVZYVNMd2k0?=
 =?utf-8?B?c09scDVRcHAzRHVWV1hmdnJ3RURhSVh5N2U2OURrQ1hmYkFiNU5mbnlLQy9G?=
 =?utf-8?B?UGtFUFlLS2dJUEZUdkd3RnZxTXZobWozZTg0S3JicGxVZDJtM3B0QzFVMTlm?=
 =?utf-8?B?ZUVQN1ovR1pKVjliUnRKbGd5RUV5Tlo0K2dZUFZWVDlQcCthZFB5dU1jdnls?=
 =?utf-8?B?SG5sMlVBWWFCT25JNmE3VGxKTklyeEtNN3FPWk1OM0t2cWJuVWxZQy9JNW5Q?=
 =?utf-8?B?KzNXZHM4T2k1ODBack0xMk13NXFKRG16amdIMVN6bnV1MUZVNHBsT2NkVWhi?=
 =?utf-8?B?WUF1WVlDUC9WRmdQZ2VTYkFhbmFVWlZwQ0pmL0VXU2ttYmxLRVZ4REVnUWg3?=
 =?utf-8?B?UUVwVU9xdDVISWpaKzlmTmJKSzN2VE5sWlY2ZkNoWkpUVXJTekdwQnFEN3px?=
 =?utf-8?B?djJDYTRTakRzNjFMOTdyVVlpemJpQkJ1T0FRb2lGU1Z4L2Q1TzEyRFF6NWt0?=
 =?utf-8?B?aWxPZXBZRTFwNGNQcmczaWt6bWVna3hMVk1VTGlSblpuTEhVdDlkY1BQL0Ft?=
 =?utf-8?B?OFZML3plRm92dFVCVld2QzVjWGg4QmZKVjZaSm5Xem9FdVhBNFNzcEZ3TEF3?=
 =?utf-8?B?TEJzcDM1cExzbDlnMHNFVjhxNHNEMmtFTVc3aVFvVDZQRTRsdG16eWlBMWxp?=
 =?utf-8?B?ckhlV21adHliU1ZQclVZbW5FVGFSaWtJR0hsU040WDZKVTJJU3FzZnZaTjZk?=
 =?utf-8?B?VXpBNkZNNzcrYnhMalVXWXJkbi8wRHhScy83R2puc0RlZElVMTM0amxna0x0?=
 =?utf-8?B?MTY3WVZ5VitoYkdVQzVmcWxLV0dNUG4rWG0zL0RsWDVpTkg5MU11d2MrbjVW?=
 =?utf-8?B?cjMxOVVjbkZvZGFVNG1RcXNXNSsrNmlVbC9FMGc4emY1TWJZbGh6QkZHRVp5?=
 =?utf-8?B?UnY5VFQ1Tk5JWVpycldXT2ljQ2tvaWN2K1g4MndGMTRGdTVxR0pwTFBWSTJo?=
 =?utf-8?B?Mm9aOEVRYjJsNzZQSUZvcno0OERuYjNSWFE3eHNpQnppNDRQYjR3SElQZXBR?=
 =?utf-8?B?anZqWmRKRkVRVWZSdm9ScFdXRE5BSXpMWllHdE91TWtMWTljQUR6bzYvMDBh?=
 =?utf-8?B?Q1VSc0tuZGIwdGhaM2E5QVNOYXFLZ2gySHJXUjBtUmwrV2tkUGJTOVVrQkpB?=
 =?utf-8?B?UlJXWlZWbGdiZUozV0h6QXBBNzhraDhHWUc2T3VFQlVidEFodE9zckpibWdR?=
 =?utf-8?B?YjNjK3NObEhqRlo0NXgwdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3EvUlJnN1dHTHZzMGxnY1hET28yd0UrVUdIaE1rNksxT2FPbkFEL3dGTlNW?=
 =?utf-8?B?TEdRWTdhZVV1SHFyQjhkSWUxUGRuaS9DVGdlV1FTS3JQM3lxYzhVZkZVeFZX?=
 =?utf-8?B?M0dkVG5WRXBKR1BuVEtWS3ZEenE3blA5VURXTHlHVzVQY0t5MDRVM05QZktp?=
 =?utf-8?B?ZDJZQW8vVGNUaUtBaWFiVTVTN3Zkc3RBUTFNYVdNdm96V0hIeHMxb1dDaHoy?=
 =?utf-8?B?VGxjMjhuZDZlaksyaTFuUzEraTZoNXVycE92SjNtTUNzTmJrL1VHTlFuTEcv?=
 =?utf-8?B?Vzk1N3NDN2QyVDZhZXUvdkN1RWhpb1R0cUJ0RWx1aE05RjN5bk90V1E1VHZM?=
 =?utf-8?B?ZFJDcndKUDRDc1kvQi84em9oNDhybDZYRzdrc01MRzdtajdWRlFmbTRDRTZo?=
 =?utf-8?B?VzEzREtTcmpNNURMcStGVlMwVGwwMnlUbkVhWDhjYzBqdXFIQVVjamR6eDZT?=
 =?utf-8?B?elNzaUlMVmV3U2lBMnQxS3lBV0drR3k2UjJyalBxTi9EbDZ1RnFzYUthbzJM?=
 =?utf-8?B?SE91dmJmdGhSaUtlUTQrSWNQWDBESEdadW15UUVla1ZpTkY5WDlyVjBNWDdx?=
 =?utf-8?B?b2czTUk5cW41SlJleWJ0bUpCOFNPb1NzVmtnMkF3aDc2ZHY5dXRTU3ZocHZK?=
 =?utf-8?B?bFZvaXJCS3BraVo2QU0zS0NOMG9rcUpDZEFPMmJHeFB0UDdJMzM0ODY4SkI5?=
 =?utf-8?B?QWF0RUZ4a3VoRllXeDl4U3lUaGlKZjBFaTkwRFEyRVh5U05CVUdQV0l0YWp4?=
 =?utf-8?B?RnZ1d1RwdWl2UndkNVI5YXNSbHhWK2dLVGIxL0dwdUxNTW9IZnFJWWJCNnRx?=
 =?utf-8?B?dEYvTEMxRmpJWlpsZ29oN1c5S2lLbUh5UFdjOHQ2Mm1QYmlzRGV0NG52Z29K?=
 =?utf-8?B?YWdWWTJ0Mm4wbGlQMTRDNys2NUkxbFZzdCtUTm0xdksvd1VkY2NsR3ZFaTE5?=
 =?utf-8?B?UjYrMWRkQVZLNFlQenJDUWlPUEdXbXFrZzhrNXY0NzRxcnBkSnhwWC8zdm1W?=
 =?utf-8?B?QjVZalN2Z0xLK0RnNWREejNHOXM3aW1yR2R2NUxsRU9Yd1dLa0N6cXFmQ0JJ?=
 =?utf-8?B?QjdCYmprWWFjUUtadGFGUGtkeEQ1VjZraEZLTTE4Znk2aFFzVlVyRjZESnQ0?=
 =?utf-8?B?ancwbzJOWXdIdngyUFJ0S1d0UFJEVndBcE5ndWQ0MnV6d0d1K0grS2w4YjlI?=
 =?utf-8?B?ZzllUGUvNVZSeWRGdUFOVTNsNk9xRExrNEFENEZlN3Y4NmNwN3hiaHVOckhF?=
 =?utf-8?B?SHFzdnhhRzBoL0hNZG1WeE0wNktJb1hKaFpMTFFWL2x1SVR3UHIyaVhQZE94?=
 =?utf-8?B?RHA3cjkwaVpTcG1MSXFBTm03azBYaHZCeHQ0Uldpc1RveDlBaEtzUVFXZlVp?=
 =?utf-8?B?VS80bHZtdjRKZTZzWTQ0endpbnkyMGxEY2hjY09xQTFrc3AxSTBRZ3BGb0lT?=
 =?utf-8?B?NmJkdGFOZ2V3L3dmaW1YeElyTm80eUNrcUhFZzgzaFgydmZ2RTRZaVY0NEhw?=
 =?utf-8?B?M3piQndCTlVlZC8rS2JaWWlVSklqZmNjbENId0Z0Z3BtVWtKbUFYYjQxRnBK?=
 =?utf-8?B?aVJzTlc5SDR1Q0JwbHNXdGtnUzRNTUltdCthclNMd21pVFljMDhUWEpmbEl6?=
 =?utf-8?B?YnBpdXBOcmxBeXhxN2JVbVdIV0pnWk43ZnNRa0g2N0pMcFp0bVJpbnVNcXgw?=
 =?utf-8?B?c0xtc1djaWZzVzFoekhCN3l5b3FHc28rOEJyT3dDQ09INjZ5a2NvdkZYaUc1?=
 =?utf-8?B?RDJncWhTMFVBUHlaV0lVRnpUWDNtb1RyRFNUdjFNSDZkN1lCV2FQdm8xbDEr?=
 =?utf-8?B?ak54dGdjR3RiNVNpeTlHNHZYamtPRGsrN2x1WXlwQlhyWU1IODdsQ3pGYjc5?=
 =?utf-8?B?Yy9GZWhITGg1TEhNWHpUSmloVjlUdTBYbFZsTzBIbU9SQ3U2eHpKOC9GdHpW?=
 =?utf-8?B?RUYxSmV2azJ4M29Oc0EvdkV1YkFDMXpuREhabVNuZHlDYmtyOGpXRTdKVG1M?=
 =?utf-8?B?d3I1cU95M1FyQ2dHSkNxbVBBd0NDMTU1MlVENjJ4b2ZBYjNpNkYxODY1blo3?=
 =?utf-8?B?WFV0eXhmZklwNE15NW5ZT0M1NmRCK3c2R3FZdTNvY3AvT3VCM09VQ0FIbWFa?=
 =?utf-8?Q?kKG1O3Z8g7d1hw9233Mih2AK6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6352aa7-9144-4da2-0127-08dcc129d2a9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 15:07:35.5248 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOtuKtfDO4Dll5Y8Fj1dLLhbjMVl5vie9lRs2RbIVbgB9VnWVUO0Wbp15+ufVim2Zw2UvFiQ8gyUgYdFW+umJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6370
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


On 8/20/2024 7:36 PM, Alex Deucher wrote:
> On Tue, Aug 20, 2024 at 3:30 AM Huang, Trigger <Trigger.Huang@amd.com> wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>>> -----Original Message-----
>>> From: Khatri, Sunil <Sunil.Khatri@amd.com>
>>> Sent: Monday, August 19, 2024 6:31 PM
>>> To: Huang, Trigger <Trigger.Huang@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
>>> Subject: Re: [PATCH 2/2] drm/amdgpu: Do core dump immediately when job
>>> tmo
>>>
>>>
>>> On 8/19/2024 3:23 PM, Trigger.Huang@amd.com wrote:
>>>> From: Trigger Huang <Trigger.Huang@amd.com>
>>>>
>>>> Do the coredump immediately after a job timeout to get a closer
>>>> representation of GPU's error status.
>>>>
>>>> V2: This will skip printing vram_lost as the GPU reset is not happened
>>>> yet (Alex)
>>>>
>>>> V3: Unconditionally call the core dump as we care about all the reset
>>>> functions(soft-recovery and queue reset and full adapter reset, Alex)
>>>>
>>>> Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 62
>>> +++++++++++++++++++++++++
>>>>    1 file changed, 62 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>> index c6a1783fc9ef..ebbb1434073e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>>> @@ -30,6 +30,61 @@
>>>>    #include "amdgpu.h"
>>>>    #include "amdgpu_trace.h"
>>>>    #include "amdgpu_reset.h"
>>>> +#include "amdgpu_dev_coredump.h"
>>>> +#include "amdgpu_xgmi.h"
>>>> +
>>>> +static void amdgpu_job_do_core_dump(struct amdgpu_device *adev,
>>>> +                               struct amdgpu_job *job)
>>>> +{
>>>> +   int i;
>>>> +
>>>> +   dev_info(adev->dev, "Dumping IP State\n");
>>>> +   for (i = 0; i < adev->num_ip_blocks; i++) {
>>>> +           if (adev->ip_blocks[i].version->funcs->dump_ip_state)
>>>> +                   adev->ip_blocks[i].version->funcs
>>>> +                           ->dump_ip_state((void *)adev);
>>>> +           dev_info(adev->dev, "Dumping IP State Completed\n");
>>>> +   }
>>>> +
>>>> +   amdgpu_coredump(adev, true, false, job); }
>>>> +
>>>> +static void amdgpu_job_core_dump(struct amdgpu_device *adev,
>>>> +                            struct amdgpu_job *job)
>>>> +{
>>>> +   struct list_head device_list, *device_list_handle =  NULL;
>>>> +   struct amdgpu_device *tmp_adev = NULL;
>>>> +   struct amdgpu_hive_info *hive = NULL;
>>>> +
>>>> +   if (!amdgpu_sriov_vf(adev))
>>>> +           hive = amdgpu_get_xgmi_hive(adev);
>>>> +   if (hive)
>>>> +           mutex_lock(&hive->hive_lock);
>>>> +   /*
>>>> +    * Reuse the logic in amdgpu_device_gpu_recover() to build list of
>>>> +    * devices for code dump
>>>> +    */
>>>> +   INIT_LIST_HEAD(&device_list);
>>>> +   if (!amdgpu_sriov_vf(adev) && (adev-
>>>> gmc.xgmi.num_physical_nodes > 1) && hive) {
>>>> +           list_for_each_entry(tmp_adev, &hive->device_list,
>>> gmc.xgmi.head)
>>>> +                   list_add_tail(&tmp_adev->reset_list, &device_list);
>>>> +           if (!list_is_first(&adev->reset_list, &device_list))
>>>> +                   list_rotate_to_front(&adev->reset_list, &device_list);
>>>> +           device_list_handle = &device_list;
>>>> +   } else {
>>>> +           list_add_tail(&adev->reset_list, &device_list);
>>>> +           device_list_handle = &device_list;
>>>> +   }
>>>> +
>>>> +   /* Do the coredump for each device */
>>>> +   list_for_each_entry(tmp_adev, device_list_handle, reset_list)
>>>> +           amdgpu_job_do_core_dump(tmp_adev, job);
>>>> +
>>>> +   if (hive) {
>>>> +           mutex_unlock(&hive->hive_lock);
>>>> +           amdgpu_put_xgmi_hive(hive);
>>>> +   }
>>>> +}
>>>>
>>>>    static enum drm_gpu_sched_stat amdgpu_job_timedout(struct
>>> drm_sched_job *s_job)
>>>>    {
>>>> @@ -48,6 +103,7 @@ static enum drm_gpu_sched_stat
>>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>>              return DRM_GPU_SCHED_STAT_ENODEV;
>>>>      }
>>>>
>>>> +   amdgpu_job_core_dump(adev, job);
>>> The philosophy is hang and recovery is to let the HW and software try to
>>> recover. Here we try to do a soft recovery first and i think we should wait for
>>> seft recovery and if fails then we do dump and thats exactly we are doing here.
>> Hi Sunil ,
>> thanks for the suggestion, and that's reasonable. But my concern is that after soft recovery happened, the GPU's status may change(take gfx 9 for example, it will try to kill the current hang wave)
>>   Actually, in most cases, a real shader hang cannot be resolved through soft recovery, and at that moment, we need to get a very close dump/snapshot/representation of GPU's current error status.
>> Just like the scandump, when we trying to do a scandump for a shader hang, we will disable gpu_recovery, and no soft recovery/per-queue reset/HW reset will happen before the scandump, right?
>> On most products, there are no scandump interfaces, so core dump is even more important for debugging GPU hang issue.
> I agree that it makes sense to take the dump as early as possible.  It
> makes sense to move it up now that we are starting to have finer
> grained resets.  We may want to wire devcoredump into the KFD side as
> well at some point.
In the current implementation we do stop the Scheduler and wait for 
existing fences to complete or signal them. But the new place to dump 
will not have anything like that and even though we have timeout some of 
the threads or waves might be still progressing the IP dump might be 
changing during that time.

But i am not sure if we want to stop the scheduling of new tasks and end 
the existing one.  How about we have multiple level of dumps i.e just 
capture and not dump as first dump is what is captured not last.
a. Capture after soft reset and let it be overwritten by next level
b. After soft reset fails capture again before hard reset is triggered.

So eventually we would have the ip dump file generated of what we are 
interested in.

Regards
Sunil K



>
> Alex
>
>> Regards,
>> Trigger
>>
>>> Also we need to make sure that the tasks which are already in queue are put
>>> on hold and the their sync points are signalled before we dump.
>>> check once what all steps are taken before we dump in the current
>>> implementation.
>> Do you mean sometimes like:
>>          drm_sched_wqueue_stop(&ring->sched);
>>          amdgpu_fence_driver_force_completion(ring); // Since there is no GPU reset happened, is it reasonable to call it here?
>>          amdgpu_job_core_dump(adev, job);
>>
>>
>> Regards,
>> Trigger
>>
>>> Regards
>>>
>>> Sunil khatri
>>>
>>>>      adev->job_hang = true;
>>>>
>>>> @@ -101,6 +157,12 @@ static enum drm_gpu_sched_stat
>>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>>>              reset_context.src = AMDGPU_RESET_SRC_JOB;
>>>>              clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>>>>
>>>> +           /*
>>>> +            * To avoid an unnecessary extra coredump, as we have
>>> already
>>>> +            * got the very close representation of GPU's error status
>>>> +            */
>>>> +           set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
>>>> +
>>>>              r = amdgpu_device_gpu_recover(ring->adev, job,
>>> &reset_context);
>>>>              if (r)
>>>>                      dev_err(adev->dev, "GPU Recovery Failed: %d\n", r);

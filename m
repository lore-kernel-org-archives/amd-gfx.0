Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9380C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 13:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E18111133BE;
	Tue, 23 Apr 2024 13:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1EgJLCNY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E61F1133BD
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 13:25:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwsSGVVJ45AwAhl4Ugs0E6e/jGDEYssV2i7pTnlONNnY8JPVf9usj0YzjnvDRNLA4cjbN6BUUhWzxkkiUylXtA0mXZ+GpdY7iRwUbIlJAC/DSaXifsdlBHoBCMBJsw8h8rP4WaCXoqChOXCTHdSLH5+F8ij0HRGjOeCA3L5k298WDRZqjKyZGH2VqhZIuPugliie4NjYJU9wzFZ3CK7TMW7DpyZzS9y01fZH1XYJnxEXemdJLnGOLEqHz3CenXgnk3T9SyYWQETFElu8ZyofxzIi28amiLBXMJY+UVfm6aV+3VOVhgNTGs9mi1X5JAlq34lRj7nV9/orfj2y/ewtIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PtFmLQ16UzMJqg0ZYROI3J50o/PjA7ZLjzAWN+Inz8=;
 b=Ogmy3P93QapUZ0kOTlArLqlBXAQWuNqKKEgDwqDJbwY8y7weRygfcesPEDo+QixTDckj3n0o1VMr30zUWBnQyoTSo9hN+HaUqHlDmiYSOGqNC/X3QmnGJiXiAnWE7zFTlMYDFYE48jI8Pjd0AhlZw1tjYhnjb4bsgsjR+nItD3I138h1e0Lt1wvyJIwqKVqqoIjEvFJnpz7YrHdAqMtbSqjRLgzsGJR2SC9noeDXG51BzvSlIlRiC+BZOakxYvNeMiXM1tZRTMEXYy6y83lbHyZvo+ZTwLlJmn0OXLOBC22gg1PryKz0FKMbd40tnkrXyy4W2KWkQuT+JOuSBaMUxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PtFmLQ16UzMJqg0ZYROI3J50o/PjA7ZLjzAWN+Inz8=;
 b=1EgJLCNYQAYRmSstfI7i5S4QQWFUJVzoNIH7HTdNp4U/2xeg503tjy9mWF7/SKMtgllIhkq2yFdmtHaMP9G9LAHXGH/TewjS84rHjIRSdA2sBahZx3Jn01VkM9lwRCiebHYzIS7Fijs4Ql2QOsPIkNpVS9UTlXKOjnquTc5mB7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7415.namprd12.prod.outlook.com (2603:10b6:930:5d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 13:25:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.021; Tue, 23 Apr 2024
 13:25:55 +0000
Message-ID: <7835e33e-5a94-4cb3-b831-6f11a921fd1e@amd.com>
Date: Tue, 23 Apr 2024 15:25:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] drm/amdgpu: Handle sg size limit for contiguous
 allocation
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Arunpravin.PaneerSelvam@amd.com
References: <20240423130450.25200-1-Philip.Yang@amd.com>
 <20240423130450.25200-3-Philip.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240423130450.25200-3-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: 58872bec-6a8c-4c69-5154-08dc6398e7ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2kvSFVvcSt0VWdJNHU5ZmZqS1FoYS9zY0VzUDBOVkp2MjdicWM1UWQ1YmpP?=
 =?utf-8?B?ZmtNekRsb1c2dTJ5OW1VbE5hMFBqUmoxRG9qR2FNaXBoYk1TS1psYnE2a1Fu?=
 =?utf-8?B?SjVud0JsYTZYMHVyRzA5RmJvdys3M05MT1VXYWFqeVZNeHduclUrZXZrMVVX?=
 =?utf-8?B?K3J0Q1RWT3BCKy9aY3NHbXBIclJjOHhSWmpxSVhjU29aVk1JcExqREhVeFRT?=
 =?utf-8?B?K1pOWmNqWmR6QlN1THdIdXVMQU9PdUtSWGpseWhCdkh4cFBGeWo2Z0lySUNh?=
 =?utf-8?B?V2tYMXNFL2dhbE5jdURnYXpheWdtOGdYTVN2cG1hSWlsSFpBRmR0VTlqVFRY?=
 =?utf-8?B?a3A5VUVTRnRkdkRFVTRpQW0rQ05yQ2FyNlV0WkNKTjFmblIwanpTWHhCeTRj?=
 =?utf-8?B?cUlGZzQ3MTV4UzhmUk1ac3RYNlpNOEt4NjBYVktMdWNSVmRrTHRPV3Q0cCtX?=
 =?utf-8?B?b0R0T3QzVmtkayt2dlBqcngyTTdKVjdYVk9vMVJScGdoWVEwVWk2bnNoYjAr?=
 =?utf-8?B?cXpCLzNOTGlrV2w5SzZRbkM5YU5KWlRhZGNkN0xZRFh4MFJBSjA4VTl1WG5Q?=
 =?utf-8?B?eldkT2FkMzdrWG9MUGZVOHFETlZEUFhnSTNNNWlXK3FFOFpGaUhWVGJ0ZTVv?=
 =?utf-8?B?QW01WThiTmV0YnlsbU5lQUg2V0djQ1ZnTmhyQS8xdDgydEtRWU1zdnVqMG5x?=
 =?utf-8?B?dHIrYTVrS3Z6ZGtlaXl0cUV3WlNsR2pra2ZvSzJxUHpFeUw5eDF0Y2VUSmox?=
 =?utf-8?B?VGkwMDZyZ2QyZDBWaWNkMXhva1lrc1RBd3dVTWtUdHNMRWFwWXNUbUovWVNB?=
 =?utf-8?B?bll0dXFCSENnRnVtOE5TY2FBTTFCV25yNlp3ZWxkaFdQdEx2YWNMWmwvOU83?=
 =?utf-8?B?OVhmRVdjOG5xRTA2K2t4bGhKVml5TGZ2cFY2TlgwUkc3d2JzWFhQekFsMGYz?=
 =?utf-8?B?TFgyeFR3SmVtbFpRbklvZER4eHBGV25JdkRjOXoxc1VtNTVpbGNZUlF2Y2hS?=
 =?utf-8?B?S2RCSkhzQWxsWmM2K3BpOHZtdXFrL1ZYWmZzdzIxamVyYVU5TmlFTzBHanRV?=
 =?utf-8?B?UTBEbkpyZW9WWlhBNEZLTEVSRHU5dkhhUThvbHNBVDdGZng5K28zSVhlUUFM?=
 =?utf-8?B?WFpYZVMweHRKYW03SWRWWDFnN01EbWNTNFRhZk9zb1B5V0dPQmJUSnBnZnBI?=
 =?utf-8?B?WUJqNlhpdHBUalZsbVFodE9lb3hxSWd0eFh0NlRJUGZsY0h3Z2MvYmo0UFRs?=
 =?utf-8?B?TThxQlBhbUtnSk5WZFJTRWY4bzlQdjQ0NjljYlFOdEliT2RTTHV6Qi8rMTdx?=
 =?utf-8?B?M0prc0JIcktqZkJkV2xVM2UyaTJXNnRmcHp1dEwzQXkrR1FrMGRkeXoveUFK?=
 =?utf-8?B?b0FyVEFWWTNHN0NKZ1hxNUxtNFBFWEZzWWhhbk9BS21ZWEZDeTF1Y1BpTm9Y?=
 =?utf-8?B?dFFvODY5eVBTd3l1QW1jSWFwQndtTlFrYVJsaFp6VU1SdjNpcmV2bVNmUmNp?=
 =?utf-8?B?bHArSWtMUzRERnNsU21nQkNlVkpwMGx2amZvU2NWMFQzZjUyWVlGMFlEL3hG?=
 =?utf-8?B?a095bjdqa0tISW14c0JPcTdGTUk3aloxdnd0cm1lc1lPRlpBNzdmSU4vaklT?=
 =?utf-8?B?cDlMUFlhNFVZK2RINDAzOVNuNnBuNUhGTU12b3UzSUdzdjdRUnpCMEpkNUts?=
 =?utf-8?B?L21HdkdHeWZmR2VJSkUvMk9KUWp4K1Fyc3VzcjNDWGphd0F4cmY3Z3NnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L01DeWp4NDFrTnhmOFVtem52ajVyVFRzbCtUNEh0Z3R1eTVtZEx5Y09PdkRw?=
 =?utf-8?B?UVMzVWswZCtHa25JTWV1eENwVW9vQzFZamdWM3FDRzhJdmZwNzgwRThwS2NU?=
 =?utf-8?B?Q2thaG1NLytGVkNlcEQrWUQwbHJONkpvMUhmY3ZkTVVacktYek4rOTNyS3F2?=
 =?utf-8?B?V1FzclA1UWc4dno5WXFDUzA3THllMWZpTzNwekJXeHdrSXhFeFloZ2o5MXBF?=
 =?utf-8?B?ZVorLy92dUhZWllwYXFTZGVoa2swK3hhVm45S3VUTUsvNm5HQ1NoUUNsN2Fj?=
 =?utf-8?B?WDBwdGxQSlMvUG1WYTdSYW1Qc3FZVVpQMStQYTZSUHRDQ1NqZ0YyNmE5UkRK?=
 =?utf-8?B?NDFpSTQxVXlwclBIVVFhK0ZscjlzcW1UT3dxMHhEbWJDV2dmT09XOVdjM2Mv?=
 =?utf-8?B?YnFnVy9lNkNnTzVNdHdiMFV3Nk0xNXBTUnBqbVNNR0JCQkxXNGNPNWtTUDlz?=
 =?utf-8?B?dmJmMGgxMTJ0S2pUT0drSEZSYktKZDBFa1V4Tk1QZWVzdjNRUFZXUEtjbTU4?=
 =?utf-8?B?c3lVZ3J2Z3pjWUpzaXo1VW5RQnJSdUd2RTlKRHBBQkFmS29QbmkxVUdpYzUw?=
 =?utf-8?B?Y2x3SW9tVThVaEl3T09SNlNaS0Fpd3dhYkRqaWFhaWpsR2J4U1BxNjEyRGlW?=
 =?utf-8?B?eGRiOFd6eVhzT3RNWXFXQU0zYmFmWnBUeURUUDJZQVIyTlhjZEpVWXhURk5m?=
 =?utf-8?B?aStBTzhhS2xYUDZnVnlET3o5Y2NjRlVJUXBleUdzWEZwSU12ZEpqdkFqOHYv?=
 =?utf-8?B?UUZxZ0kwSU5kdm9DR2I5OTVmdUF6Skd1eWRyRmZDdU9UYTlobTVDc0VYb3g1?=
 =?utf-8?B?YWd1ZDZsaEl0TWZ4YXdBTUhESG56SXJJc2xmRjkzaTlwb0U3SkVubVZXNlNE?=
 =?utf-8?B?V29ROVBjWTdBVDAyRWFwb3hDbXZUSG55RG53amRycThjMThSWDVwZFpPL0tV?=
 =?utf-8?B?ak9mUktJN2Q2SzVpNGRzY3RiYnd6SExaN3I2UjZ2M2RUOUJmMEIydEx0WThX?=
 =?utf-8?B?TXdyZStYWm5WZGpSNXhKQWl5RzBRMEZwNWdjbDUzMDZhd3FvTjFlaUgwdHNz?=
 =?utf-8?B?YkZFVGRVMmp2eUpPNmpiYjV3S1hTaExObXFnT0YxRGZIZk5KOEl6M3NId2V5?=
 =?utf-8?B?V3FmdWQ1ZTdzN3pPR296dGRzWXpsZW5XMHhkNnY1OW5mT1V3NVUrNzdXQnFX?=
 =?utf-8?B?TzNpaFQ1UWk0cTFQYWhSTmttT25GZVJlN3FpZ3FZQUJVSzQ1TWJBV1MvQjBw?=
 =?utf-8?B?MEphVWZLMmxHQ05MTmE4R3Y4WmQveVQ0M0hwelZBSGpKdENZVUVKS1UzZ3pr?=
 =?utf-8?B?MXpvZVlhK1dvUGlTd2gzTmE1elhYaU1HVkd4V0lpdG9jWWpGT1ZYM0ppcFU2?=
 =?utf-8?B?aUhicXhyNExVWEEvb09VYndBb2FrQ2VxbEV0bTllYTNUMXIwblJhTWdoeFRY?=
 =?utf-8?B?Ri9WVG1tT1lxbjNFbkpzeVhraWxZbzR3Q1BmTm5WQ0NUdEoyRUkrQVZ6NkQr?=
 =?utf-8?B?dGh5NGZjYXBLaC9DQXhodTA4TSswTlBHQnlmSjcxbUlBMjVNZE9rNW1NVS9n?=
 =?utf-8?B?ZWhzVkZZUEpHQjhwaUZrNWsxdnpkbTdPZ1pGcE9ma0w4SHRZVC92VlFEZUph?=
 =?utf-8?B?bG9Va09xRXZVUWl3V1JydWdTMmgweDVNeXlCYzBkTCs4STRuenBYciszM0h4?=
 =?utf-8?B?czVtV2E3V3NlUjdiY0NVSlp6NzZNejRLcGFZaWgwQnNRU0doZzFudCs1MTZ1?=
 =?utf-8?B?VWw0ZmtpR2hyaXlFai9DVDEvNkFwRUZGaFRCTGpLNldHN0lERStPczZPbU9C?=
 =?utf-8?B?emYyRW9DV1NIWEc4QlVoeDkvdHh2cXUwV2JpZnI0WEtyWkdURXQzRW9CSm1V?=
 =?utf-8?B?ZW1rQ2c3OXNWK1RPcThzb0pLSmlOZU0vdDNabDJUVmtRL2JNWWMwa0tvU1VW?=
 =?utf-8?B?SldiQWxHZ01VVFB0WG12a29qUHR1Yi9QcTRXajUvM2tlTEhDQlpiT1o5T3Rv?=
 =?utf-8?B?Z1lUaWVpRUpuSGJaaE52VThxaFlQc3NDcFNQNFpaTW02bkltNGtnY1MyWENE?=
 =?utf-8?B?QUl0dXd6WWpIOGpCMUxLWHVqeWh2VGNwbi9nczkwRlBKVGFrRE9iWEtzeFQz?=
 =?utf-8?Q?l3d9rYxHkOmDGGpc66zlDDf/t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58872bec-6a8c-4c69-5154-08dc6398e7ac
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 13:25:55.4301 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/6ludRPWspZLgHQSUiajFlQt6/xqZdPY2BVlrGuU07FZVjGmkMtaM5exMCEzbPj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7415
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

Am 23.04.24 um 15:04 schrieb Philip Yang:
> Define macro MAX_SG_SEGMENT_SIZE 2GB, because struct scatterlist length
> is unsigned int, and some users of it cast to a signed int, so every
> segment of sg table is limited to size 2GB maximum.
>
> For contiguous VRAM allocation, don't limit the max buddy block size in
> order to get contiguous VRAM memory. To workaround the sg table segment
> size limit, allocate multiple segments if contiguous size is bigger than
> MAX_SG_SEGMENT_SIZE.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 4be8b091099a..6c7133bf51d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -31,6 +31,8 @@
>   #include "amdgpu_atomfirmware.h"
>   #include "atom.h"
>   
> +#define MAX_SG_SEGMENT_SIZE	(2UL << 30)
> +

Please add an AMDGPU prefix before that name.

Apart from that looks good to me,
Christian.

>   struct amdgpu_vram_reservation {
>   	u64 start;
>   	u64 size;
> @@ -532,9 +534,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
>   
>   		BUG_ON(min_block_size < mm->chunk_size);
>   
> -		/* Limit maximum size to 2GiB due to SG table limitations */
> -		size = min(remaining_size, 2ULL << 30);
> -
> +		size = remaining_size;
>   		if ((size >= (u64)pages_per_block << PAGE_SHIFT) &&
>   				!(size & (((u64)pages_per_block << PAGE_SHIFT) - 1)))
>   			min_block_size = (u64)pages_per_block << PAGE_SHIFT;
> @@ -675,7 +675,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>   	amdgpu_res_first(res, offset, length, &cursor);
>   	while (cursor.remaining) {
>   		num_entries++;
> -		amdgpu_res_next(&cursor, cursor.size);
> +		amdgpu_res_next(&cursor, min(cursor.size, MAX_SG_SEGMENT_SIZE));
>   	}
>   
>   	r = sg_alloc_table(*sgt, num_entries, GFP_KERNEL);
> @@ -695,7 +695,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>   	amdgpu_res_first(res, offset, length, &cursor);
>   	for_each_sgtable_sg((*sgt), sg, i) {
>   		phys_addr_t phys = cursor.start + adev->gmc.aper_base;
> -		size_t size = cursor.size;
> +		unsigned long size = min(cursor.size, MAX_SG_SEGMENT_SIZE);
>   		dma_addr_t addr;
>   
>   		addr = dma_map_resource(dev, phys, size, dir,
> @@ -708,7 +708,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>   		sg_dma_address(sg) = addr;
>   		sg_dma_len(sg) = size;
>   
> -		amdgpu_res_next(&cursor, cursor.size);
> +		amdgpu_res_next(&cursor, size);
>   	}
>   
>   	return 0;


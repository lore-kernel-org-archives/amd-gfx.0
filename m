Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9495EC02194
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 15:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 339EC10E1D6;
	Wed,  5 Feb 2025 15:04:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dM8diC4F";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15DE910E1CB
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 15:02:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plFdxDQs1N9RECF03VPGJHq0KD43W9afEYATtlYV0ZbEYt94NKkH7Db+iEP3yB3YUNVPbh/yVFYstQfwL/Nz7vlrxqietuZvxM2h74azTqm4LSdP3xVi9JGvrslasUvGHBoqP4oF4vlN+OuTS4b2+aeu1vefiQqIzcdbvJ11l4yEyuHDCtfC+4JUdLqnTS00diZjymF1Ss843E4Pe8bv3B0c7vP1izuagm+HnMmuI+aLcOp442YyVpJ/J40FcVNk9Hc57IvAox29hMq0NxA3hv4h3dex031yhwzQn6NUSy4ElLMIlLP3hFEAU4PdMUhBHPMGyR+c6zo4UMGCri7uXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfosrV79NcLrIZ4GsHtGBOZP8vnIHqUbEg+CUkljpRA=;
 b=vgMjIHgoRbl9HVnUkLfAAfqjyVolpmVlEX/ZxDLNQkjsbYMjsegB5OJNHMZw1MHZFK4SdvZ016ykodJB+Q2Ok/lpvQk8fdh9fX0QUEDVd6HPehrNfTvxHDAsZW9IH3cZz07NQDnY9oxB5I1yORzRzbGxmnhfMnyqqeZyeH0wzmsVILPo6yq35BPH+TD5HSp9QjJiQf5pW/lpXr2K0Bkd7VgQjvilnnv12gpOWS8udyWWUkloaH8U9UMkdgNbYjyReUu98OCockWiTXDFsjkDcNRSjgjsMriZ/aX67HTr3lUSKErK/VovszOtkJiK8DXd6Xj5DcbqpYXpPLH0bR/uuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfosrV79NcLrIZ4GsHtGBOZP8vnIHqUbEg+CUkljpRA=;
 b=dM8diC4FMkGlpXZmFsNYwq91/2ZeoGP97DZQskpK0NFn4c01C6PELRqiTp/alQWWYOG9eZbV46Cj3vhb4HOFfSCvD5X/kPbGVvIFxA1KjkcE5MkJzRLIU3CU9BrFvRaM5vckXfbn39s21151ApgJJO/7CFgm3Byf8rUANaX00HI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 15:01:57 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 15:01:57 +0000
Content-Type: multipart/alternative;
 boundary="------------kgq5wgmujYyW93DcXWGggQvX"
Message-ID: <65a8bab6-b223-48cb-8240-a895a15b1875@amd.com>
Date: Wed, 5 Feb 2025 10:01:55 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/44] drm/amdgpu/vcn2.0: convert internal functions to
 use vcn_inst
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-15-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-15-alexander.deucher@amd.com>
X-ClientProxiedBy: YQBP288CA0035.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::12) To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f6f30a-2144-4a45-4802-08dd45f60913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajErK2ZXcVdzclN3N0Ywa01GTlRkaFRxRnVqMWZiQUl3SmliRGo4NUZGUWd0?=
 =?utf-8?B?WVRPUnFxbi9lQ004Z3lsVTFKZGltU01BK0hpUmpSYndmN0tUdDZJU0pudUpE?=
 =?utf-8?B?SGlzaDFZK0ZlSFNhSmtBd1NTMUV3V3BUY3lVVEtmQjBsc3B0Ri9DNXBOQnJL?=
 =?utf-8?B?eEw1QWNFYUR4dlY4N0xuNWlnS0grWmcyN3J0aWtRa0Q3RmUxdU0vbHpiZWR5?=
 =?utf-8?B?K3BIT054RDJuN0ZmaHAzcTIrZGhoUHZDSjZHZ3d4bjIvQWJ5NEhZaGxKU1lG?=
 =?utf-8?B?K1lvK2FFWmcwdUZIcSt5aE9MZzR0aG5FZzBUMThlaG9OSjN5T3pneGRGcitV?=
 =?utf-8?B?Unc0Z3F6cFJVYy9OU0MvTTFSdm5objlHbFpHUmdJVGJsbCtSdWVjMTNQS3R6?=
 =?utf-8?B?VW9mWlZMd0pIckF6K1ZNRkhublVRNDRTWGFHVFA5WEZYMklXUmlIMkNyUk9K?=
 =?utf-8?B?SlRra2NWU0Q3T25mUlhHTnNPd0FNTmNLVVRHOTY1N0NUL0Q5TzJsa3l4emkr?=
 =?utf-8?B?dU9ydTN1Ykl1cjR6MFZTMGRmV1VqQ2huMi96YmRRUkg2dHdTaXA5TjgxWG0x?=
 =?utf-8?B?Q3pQV0NtSWQ1TXliSTZoWXVIamFvVStyTm1CQXhmbFlUVElvRVZzYW41MXN5?=
 =?utf-8?B?Z3ZPVGY0cVZXbzUxMjZGQmhCTEVERmVFUXhZZHluRFFwVzhmWkRBVXZxYVIx?=
 =?utf-8?B?OW1JY1Y4UHlQM2YveklYZ04yVklRalJxdUNZTTU3RTBBQTRueVQxa0RSSzhi?=
 =?utf-8?B?Uld4QlVvVUkvMlVTSnFrMGVRQkpHd3Q1a2VublhxR1QzN0hWbXlJcklKR282?=
 =?utf-8?B?V2pobXArV3d2R2hrdHh1WXpFSXRlNE9HNlNRcXRoSHhSc21uc3hwemZTTVlH?=
 =?utf-8?B?K2hWajc2empRN3QxbEUwVkZtQysrUWs2a01aQm1NbkdTVzAyeXhJUlFmQS92?=
 =?utf-8?B?cGtVdFFUa1E0N0llb2FmbVRsRXk0SEcvVFEyRnV6QzlyRE5ENkJ6YXJyUHRj?=
 =?utf-8?B?SVZ0ajlhNFBYMUcweVoyOEhLTmwwNTlLODJicE1UUUwwdURJaHZvRmNCakl2?=
 =?utf-8?B?bHBwc2NQeVNjQUttM3NmSWQ1VXNyTlUybzVSRS95YU5zNGtiTFRMZWVEZnM5?=
 =?utf-8?B?dHh6RUdpV1BwZHFRRkpBeHJZVklZVGc4Z1NLM0FoM3NEZmZSeHhOZkN4Z3FL?=
 =?utf-8?B?ZDVuTkdpc0IxcTErN21hVFI0OVYxUlBuYTRObHVDOHlZaHhUVGVBUUthYTFj?=
 =?utf-8?B?QjhJNk1vRWlNK3ZlT1F2KzB2RkplZnVsRU9HVU92dXRPREhXdlo2a1RtcFpp?=
 =?utf-8?B?WEZVSlJ2QW9TU2VBSmZJK1FHVWJDTCtBbjFhMzRpdnkyQUlaUCtQQzFpeVJW?=
 =?utf-8?B?ejRKZ21PWmpYVmQ2Nmx6MkxsY2F1Q0NWWTRYZFgzb1ZZK0JGbm5TTWJmd3Rq?=
 =?utf-8?B?Vkg0WWJmZko1N1RtUTIvaE5zYXlKQzJ2V0d3b1QwWHV2bHN6UDhFVkF4SmdX?=
 =?utf-8?B?U3M2d0hyQ25RQ2RQVFhJV0FHQVU2elJIaGtyTWI4dXZyMUlZcmJxalA2c3Va?=
 =?utf-8?B?eW1NQVdFSjVtQmVZT3VsT1hZZEU4VWErR0tpMHVRWlIwYnVCTFJXdmduMTJ2?=
 =?utf-8?B?OXNUdGdlUnNNcDI3SUdDS3lnb3NoOHgxaWRBSlJiRkVlZ0pMZFg1K09hSS9h?=
 =?utf-8?B?ZHA3TWdNc0hTWjV3QkwrVTRHcCttWTJGVnZmVkhnbjN4MzBoNi9Pb1dtZDJu?=
 =?utf-8?B?dE43U2VTMDkwTTI5K0k1TVlORFdXb09Qd1hqcmswYWtjc21lNjFlVVlZY0pT?=
 =?utf-8?B?Q2Q2REtnVUxmMjk2WDl6MmlvOFNsUzN1U0gxaHhpV2M4UEZvY1EvWDQ0ZEZU?=
 =?utf-8?Q?4wJN71dkCLD6M?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2Z2MUlBMExWQUt5cHNOL0xpUU9GSWU4b1M2QS9FY1B6TEt5dzdKRk5jelhv?=
 =?utf-8?B?OElaVW5SOURndjRtZlBFSDNlNk5adTlSKzQ2OENGNEFYbGRmS2FsUTZkZGtq?=
 =?utf-8?B?TGk2bFkwcVpDN3l0V1hQcTFnZlRmTkRDaytBdG5RcUhxL0IrTCtkS3pwL1BD?=
 =?utf-8?B?L0NKNlZWd3dMZ1BIY3B1NzV3N3VmTmJvY3VpdVlqcVNwT3Bqc0U2WWFCOHVj?=
 =?utf-8?B?SDhNRjdLR2poeHh0WW1tZTBQTE5JTnp2cTVIVFpZTURFVG43OWNhaXkwL2ZV?=
 =?utf-8?B?d0lhSS9VWmFCUnlpV29PVUJ3Q1Z3WEJXOVkrQ3lnclhsKzRCMExoNmtyY3Ba?=
 =?utf-8?B?aUJGcHVWeFRXbHh3ZjV6a3JKZFhGMlQyL1dlMEdTdExtQjV5V0xHeHRYNlh0?=
 =?utf-8?B?RExwZkI2cDJLQll5c3d3eUNJMG9ocm5uSmUwZ0FmWENDVmtHWU5DN2c5UGdu?=
 =?utf-8?B?OFA1Y0gxSUlRTnh6YjM5TGNnaUtVRGdPZzdOZ3ZmMW5BUVJtQ2Nkb1ptVlJv?=
 =?utf-8?B?YzZSNVFEY290RUNTdUM3Y2NjOGwwY3VBNWlKcHEwVDVwbGJZelp0UllnWkV5?=
 =?utf-8?B?QzB6VGJMaW4wdXFTZG1qaHZtdWJNNDRnWkdsa0NCSExiSmE1ZVhnMEYzc2dJ?=
 =?utf-8?B?RXp5N05YaTR2Y29uaVlmeWF5dWlhOWI0WlRJYitzL1hLSWwwWW02YWR5WXph?=
 =?utf-8?B?MGFub29MazZneitZWlBSaVlkUUJiR2h1MGlnUGdaeVhybXM4RTY2UXNQSDFL?=
 =?utf-8?B?YXhuQlJUeEpqQTJGZFBqTkIycmNjdWlDZWYwcjh1MUEvMVpteUpKSSswejNU?=
 =?utf-8?B?VFNSOFV1N3pwTDdOSExMcjNzTWl1VnRIeHZickczTnRqNHJuRk9YWlZDZ0JE?=
 =?utf-8?B?TkVpUXFSYkdPZDJIK3Y2QlNGNDFyV0lzQVU2b3BkNlRweFhLS2o4MGhHaXg3?=
 =?utf-8?B?aEdlRHI1eFpXamlVZ08yeXJ0K09QYnlLME9zOEhJSytRdjBka0ZsU1V6Undt?=
 =?utf-8?B?VHBVcXoyYXEyTXVjR2QwNlBDejFMSTJlYlNXK1F2c0tyUVE3d3ZLVEd0MzBZ?=
 =?utf-8?B?NFJuQ0ZQU3V5dWw1ZHRmM1d2clg5eFdYRFlvamlnRG03U3Yvb1duQmxKNWRB?=
 =?utf-8?B?TSsrMWZRNVlYV1piY2o1SDJTMGduaGZNRk5TTW55ME9HalM1bEpXd3JJSld1?=
 =?utf-8?B?aE1WTC9wVjhZSzJ6cFE4eGZrWnRPNEF1YWdDckJRY3RTbmFOcnJxQTVJMTYz?=
 =?utf-8?B?STAzcjBrakpTVzYrR2FIY3Z0b0lUSU5CV2Rsd3NMWG95R3J3SWxSMmxDelVz?=
 =?utf-8?B?MERQc1JyZTlmVFhsNGhTY1hCdEVPa3BGWFZsK3ArcDBKRTZFTGlBekxzZzFr?=
 =?utf-8?B?cVJ5VVo4dFFiMUR0SHZzZld1dTdTQWg2QUJKbE1yS0VteDBYWm4xcG83dk9G?=
 =?utf-8?B?SW5YOUxSdGxXUWxoRW9ST0doZWxXRzVja3BGc2kwUGtwcU5WZG9QVXZPeDAw?=
 =?utf-8?B?ODZmQ1Fua2pTOXRqeTJvQ2lQS0pNTHlTQUNVcFV2TTlZNU9TRXRkVVgxN1JB?=
 =?utf-8?B?VVdrSkF0US8waFgyT2NWc3BOai9Tdi9WakF3TnVvbGxBN096RHBzeXpkWGZl?=
 =?utf-8?B?Wi9UTmcybXNiUzl1TGhLNkZCbU9RbGdheTAreVVPRE0vZGdNOG41SEZhYzFo?=
 =?utf-8?B?ZHZlZEp1V2g4bnAveE5va0hNMlVvRXVHbnZrdlV3WEZnY0crUHNmOStIZGp3?=
 =?utf-8?B?OVJGVVlSOXdHWFFOT0RnREpoOTZLTFZNQUJXSnFqOHNublNreGt5cEJLUlZZ?=
 =?utf-8?B?ZFNnL3lSTkpBcVRjTmV1UjR0UUZIV1I0ZU5xSkR4QTRodUtWWVlFOGdqMEQ1?=
 =?utf-8?B?bkprVUNLSk9PZ1p3RVhqSUtlK0dBUGRFNEtXZG50OERhSk5oTDZiK05iczJ3?=
 =?utf-8?B?TXh4bkRCc2dFWDUzSEQ1V0ZMVFNGMngvaFViRUZMNWlvMmhURzVCcjF0aHVG?=
 =?utf-8?B?MEs0R0hnV2pXZTFFMHpGRVdJYmlYMUNCT3paZEdLc2Z3RGZNMmxMNWx6MXJ3?=
 =?utf-8?B?MU0yTHRrNWRtSDJ1MXkvck8zTjBYY1YwMEV3bjNPLys5eG9OU2o0cVplSUZN?=
 =?utf-8?Q?B1IbXG6Npp/IrUd/oYLcRK24O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f6f30a-2144-4a45-4802-08dd45f60913
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:01:57.4538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D5Y6kUJX5+Oo0Tb/7RDGJCBli9nKUZ2ByoEEdfwMniWdFWBFzUGIWp/w6G9Xo2VjMeIO5F0xPQ4OzGcxA1EFCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
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

--------------kgq5wgmujYyW93DcXWGggQvX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-31 11:57, Alex Deucher wrote:
> Pass the vcn instance structure to these functions rather
> than adev and the instance number.
>
> TODO: clean up the function internals to use the vinst state
> directly rather than accessing it indirectly via adev->vcn.inst[].
>
> v2: index instances directly on vcn1.0 and 2.0 to make
> it clear that they only support a single instance (Lijo)
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 66 ++++++++++++++++-----------
>   1 file changed, 39 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 8ff5a9d67cbd2..aa61d3b54f8c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -370,8 +370,9 @@ static int vcn_v2_0_resume(struct amdgpu_ip_block *ip_block)
>    *
>    * Let the VCN memory controller know it's offsets
>    */
> -static void vcn_v2_0_mc_resume(struct amdgpu_device *adev)
> +static void vcn_v2_0_mc_resume(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
>   	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->size + 4);
>   	uint32_t offset;
>   
> @@ -426,8 +427,10 @@ static void vcn_v2_0_mc_resume(struct amdgpu_device *adev)
>   	WREG32_SOC15(UVD, 0, mmUVD_GFX10_ADDR_CONFIG, adev->gfx.config.gb_addr_config);
>   }
>   
> -static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_device *adev, bool indirect)
> +static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
> +					bool indirect)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
>   	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->size + 4);
>   	uint32_t offset;
>   
> @@ -525,12 +528,13 @@ static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_device *adev, bool indirec
>   /**
>    * vcn_v2_0_disable_clock_gating - disable VCN clock gating
>    *
> - * @adev: amdgpu_device pointer
> + * @vinst: VCN instance
>    *
>    * Disable clock gating for VCN block
>    */
> -static void vcn_v2_0_disable_clock_gating(struct amdgpu_device *adev)
> +static void vcn_v2_0_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
>   	uint32_t data;
>   
>   	if (amdgpu_sriov_vf(adev))
> @@ -634,9 +638,10 @@ static void vcn_v2_0_disable_clock_gating(struct amdgpu_device *adev)
>   	WREG32_SOC15(VCN, 0, mmUVD_SUVD_CGC_CTRL, data);
>   }
>   
> -static void vcn_v2_0_clock_gating_dpg_mode(struct amdgpu_device *adev,
> +static void vcn_v2_0_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
>   		uint8_t sram_sel, uint8_t indirect)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
>   	uint32_t reg_data = 0;
>   
>   	/* enable sw clock gating control */
> @@ -685,12 +690,13 @@ static void vcn_v2_0_clock_gating_dpg_mode(struct amdgpu_device *adev,
>   /**
>    * vcn_v2_0_enable_clock_gating - enable VCN clock gating
>    *
> - * @adev: amdgpu_device pointer
> + * @vinst: VCN instance
>    *
>    * Enable clock gating for VCN block
>    */
> -static void vcn_v2_0_enable_clock_gating(struct amdgpu_device *adev)
> +static void vcn_v2_0_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
>   	uint32_t data = 0;
>   
>   	if (amdgpu_sriov_vf(adev))
> @@ -743,8 +749,9 @@ static void vcn_v2_0_enable_clock_gating(struct amdgpu_device *adev)
>   	WREG32_SOC15(VCN, 0, mmUVD_SUVD_CGC_CTRL, data);
>   }
>   
> -static void vcn_v2_0_disable_static_power_gating(struct amdgpu_device *adev)
> +static void vcn_v2_0_disable_static_power_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
>   	uint32_t data = 0;
>   
>   	if (amdgpu_sriov_vf(adev))
> @@ -792,8 +799,9 @@ static void vcn_v2_0_disable_static_power_gating(struct amdgpu_device *adev)
>   	WREG32_SOC15(VCN, 0, mmUVD_POWER_STATUS, data);
>   }
>   
> -static void vcn_v2_0_enable_static_power_gating(struct amdgpu_device *adev)
> +static void vcn_v2_0_enable_static_power_gating(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
>   	uint32_t data = 0;
>   
>   	if (amdgpu_sriov_vf(adev))
> @@ -834,13 +842,14 @@ static void vcn_v2_0_enable_static_power_gating(struct amdgpu_device *adev)
>   	}
>   }
>   
> -static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
> +static int vcn_v2_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
>   	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
>   	struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
>   	uint32_t rb_bufsz, tmp;
>   
> -	vcn_v2_0_enable_static_power_gating(adev);
> +	vcn_v2_0_enable_static_power_gating(vinst);
>   
>   	/* enable dynamic power gating mode */
>   	tmp = RREG32_SOC15(UVD, 0, mmUVD_POWER_STATUS);
> @@ -852,7 +861,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
>   		adev->vcn.inst->dpg_sram_curr_addr = (uint32_t *)adev->vcn.inst->dpg_sram_cpu_addr;
>   
>   	/* enable clock gating */
> -	vcn_v2_0_clock_gating_dpg_mode(adev, 0, indirect);
> +	vcn_v2_0_clock_gating_dpg_mode(vinst, 0, indirect);
>   
>   	/* enable VCPU clock */
>   	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
> @@ -901,7 +910,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
>   		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>   		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
>   
> -	vcn_v2_0_mc_resume_dpg_mode(adev, indirect);
> +	vcn_v2_0_mc_resume_dpg_mode(vinst, indirect);
>   
>   	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
>   		UVD, 0, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
> @@ -969,8 +978,9 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
>   	return 0;
>   }
>   
> -static int vcn_v2_0_start(struct amdgpu_device *adev)
> +static int vcn_v2_0_start(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
>   	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
>   	struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
>   	uint32_t rb_bufsz, tmp;
> @@ -981,16 +991,16 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
>   		amdgpu_dpm_enable_vcn(adev, true, 0);
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> -		return vcn_v2_0_start_dpg_mode(adev, adev->vcn.inst->indirect_sram);
> +		return vcn_v2_0_start_dpg_mode(vinst, adev->vcn.inst->indirect_sram);
>   
> -	vcn_v2_0_disable_static_power_gating(adev);
> +	vcn_v2_0_disable_static_power_gating(vinst);
>   
>   	/* set uvd status busy */
>   	tmp = RREG32_SOC15(UVD, 0, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
>   	WREG32_SOC15(UVD, 0, mmUVD_STATUS, tmp);
>   
>   	/*SW clock gating */
> -	vcn_v2_0_disable_clock_gating(adev);
> +	vcn_v2_0_disable_clock_gating(vinst);
>   
>   	/* enable VCPU clock */
>   	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_VCPU_CNTL),
> @@ -1034,7 +1044,7 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
>   		(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
>   		(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
>   
> -	vcn_v2_0_mc_resume(adev);
> +	vcn_v2_0_mc_resume(vinst);
>   
>   	/* release VCPU reset to boot */
>   	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_SOFT_RESET), 0,
> @@ -1142,8 +1152,9 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> -static int vcn_v2_0_stop_dpg_mode(struct amdgpu_device *adev)
> +static int vcn_v2_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
>   	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
>   	uint32_t tmp;
>   
> @@ -1172,13 +1183,14 @@ static int vcn_v2_0_stop_dpg_mode(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> -static int vcn_v2_0_stop(struct amdgpu_device *adev)
> +static int vcn_v2_0_stop(struct amdgpu_vcn_inst *vinst)
>   {
> +	struct amdgpu_device *adev = vinst->adev;
>   	uint32_t tmp;
>   	int r;
>   
>   	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -		r = vcn_v2_0_stop_dpg_mode(adev);
> +		r = vcn_v2_0_stop_dpg_mode(vinst);
>   		if (r)
>   			return r;
>   		goto power_off;
> @@ -1230,8 +1242,8 @@ static int vcn_v2_0_stop(struct amdgpu_device *adev)
>   	/* clear status */
>   	WREG32_SOC15(VCN, 0, mmUVD_STATUS, 0);
>   
> -	vcn_v2_0_enable_clock_gating(adev);
> -	vcn_v2_0_enable_static_power_gating(adev);
> +	vcn_v2_0_enable_clock_gating(vinst);
> +	vcn_v2_0_enable_static_power_gating(vinst);
>   
>   power_off:
>   	if (adev->pm.dpm_enabled)
> @@ -1348,10 +1360,10 @@ static int vcn_v2_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
>   		/* wait for STATUS to clear */
>   		if (!vcn_v2_0_is_idle(adev))
>   			return -EBUSY;
> -		vcn_v2_0_enable_clock_gating(adev);
> +		vcn_v2_0_enable_clock_gating(&adev->vcn.inst[0]);
>   	} else {
>   		/* disable HW gating and enable Sw gating */
> -		vcn_v2_0_disable_clock_gating(adev);
> +		vcn_v2_0_disable_clock_gating(&adev->vcn.inst[0]);
>   	}
>   	return 0;
>   }
> @@ -1818,9 +1830,9 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   		return 0;
>   
>   	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v2_0_stop(adev);
> +		ret = vcn_v2_0_stop(adev->vcn.inst);
>   	else
> -		ret = vcn_v2_0_start(adev);
> +		ret = vcn_v2_0_start(adev->vcn.inst);
>   
>   	if (!ret)
>   		adev->vcn.inst[0].cur_state = state;
--------------kgq5wgmujYyW93DcXWGggQvX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-31 11:57, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250131165741.1798488-15-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">Pass the vcn instance structure to these functions rather
than adev and the instance number.

TODO: clean up the function internals to use the vinst state
directly rather than accessing it indirectly via adev-&gt;vcn.inst[].

v2: index instances directly on vcn1.0 and 2.0 to make
it clear that they only support a single instance (Lijo)

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody"><span data-markjs="true" class="markpsh7afcgm" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span></span>:
          Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="2">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250131165741.1798488-15-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 66 ++++++++++++++++-----------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 8ff5a9d67cbd2..aa61d3b54f8c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -370,8 +370,9 @@ static int vcn_v2_0_resume(struct amdgpu_ip_block *ip_block)
  *
  * Let the VCN memory controller know it's offsets
  */
-static void vcn_v2_0_mc_resume(struct amdgpu_device *adev)
+static void vcn_v2_0_mc_resume(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
 	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev-&gt;vcn.inst[0].fw-&gt;size + 4);
 	uint32_t offset;
 
@@ -426,8 +427,10 @@ static void vcn_v2_0_mc_resume(struct amdgpu_device *adev)
 	WREG32_SOC15(UVD, 0, mmUVD_GFX10_ADDR_CONFIG, adev-&gt;gfx.config.gb_addr_config);
 }
 
-static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_device *adev, bool indirect)
+static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_vcn_inst *vinst,
+					bool indirect)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
 	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev-&gt;vcn.inst[0].fw-&gt;size + 4);
 	uint32_t offset;
 
@@ -525,12 +528,13 @@ static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_device *adev, bool indirec
 /**
  * vcn_v2_0_disable_clock_gating - disable VCN clock gating
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  *
  * Disable clock gating for VCN block
  */
-static void vcn_v2_0_disable_clock_gating(struct amdgpu_device *adev)
+static void vcn_v2_0_disable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
 	uint32_t data;
 
 	if (amdgpu_sriov_vf(adev))
@@ -634,9 +638,10 @@ static void vcn_v2_0_disable_clock_gating(struct amdgpu_device *adev)
 	WREG32_SOC15(VCN, 0, mmUVD_SUVD_CGC_CTRL, data);
 }
 
-static void vcn_v2_0_clock_gating_dpg_mode(struct amdgpu_device *adev,
+static void vcn_v2_0_clock_gating_dpg_mode(struct amdgpu_vcn_inst *vinst,
 		uint8_t sram_sel, uint8_t indirect)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
 	uint32_t reg_data = 0;
 
 	/* enable sw clock gating control */
@@ -685,12 +690,13 @@ static void vcn_v2_0_clock_gating_dpg_mode(struct amdgpu_device *adev,
 /**
  * vcn_v2_0_enable_clock_gating - enable VCN clock gating
  *
- * @adev: amdgpu_device pointer
+ * @vinst: VCN instance
  *
  * Enable clock gating for VCN block
  */
-static void vcn_v2_0_enable_clock_gating(struct amdgpu_device *adev)
+static void vcn_v2_0_enable_clock_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
 	uint32_t data = 0;
 
 	if (amdgpu_sriov_vf(adev))
@@ -743,8 +749,9 @@ static void vcn_v2_0_enable_clock_gating(struct amdgpu_device *adev)
 	WREG32_SOC15(VCN, 0, mmUVD_SUVD_CGC_CTRL, data);
 }
 
-static void vcn_v2_0_disable_static_power_gating(struct amdgpu_device *adev)
+static void vcn_v2_0_disable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
 	uint32_t data = 0;
 
 	if (amdgpu_sriov_vf(adev))
@@ -792,8 +799,9 @@ static void vcn_v2_0_disable_static_power_gating(struct amdgpu_device *adev)
 	WREG32_SOC15(VCN, 0, mmUVD_POWER_STATUS, data);
 }
 
-static void vcn_v2_0_enable_static_power_gating(struct amdgpu_device *adev)
+static void vcn_v2_0_enable_static_power_gating(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
 	uint32_t data = 0;
 
 	if (amdgpu_sriov_vf(adev))
@@ -834,13 +842,14 @@ static void vcn_v2_0_enable_static_power_gating(struct amdgpu_device *adev)
 	}
 }
 
-static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
+static int vcn_v2_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
 	volatile struct amdgpu_fw_shared *fw_shared = adev-&gt;vcn.inst-&gt;fw_shared.cpu_addr;
 	struct amdgpu_ring *ring = &amp;adev-&gt;vcn.inst-&gt;ring_dec;
 	uint32_t rb_bufsz, tmp;
 
-	vcn_v2_0_enable_static_power_gating(adev);
+	vcn_v2_0_enable_static_power_gating(vinst);
 
 	/* enable dynamic power gating mode */
 	tmp = RREG32_SOC15(UVD, 0, mmUVD_POWER_STATUS);
@@ -852,7 +861,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 		adev-&gt;vcn.inst-&gt;dpg_sram_curr_addr = (uint32_t *)adev-&gt;vcn.inst-&gt;dpg_sram_cpu_addr;
 
 	/* enable clock gating */
-	vcn_v2_0_clock_gating_dpg_mode(adev, 0, indirect);
+	vcn_v2_0_clock_gating_dpg_mode(vinst, 0, indirect);
 
 	/* enable VCPU clock */
 	tmp = (0xFF &lt;&lt; UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
@@ -901,7 +910,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 		 (0x1 &lt;&lt; UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		 (0x2 &lt;&lt; UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
 
-	vcn_v2_0_mc_resume_dpg_mode(adev, indirect);
+	vcn_v2_0_mc_resume_dpg_mode(vinst, indirect);
 
 	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
@@ -969,8 +978,9 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 	return 0;
 }
 
-static int vcn_v2_0_start(struct amdgpu_device *adev)
+static int vcn_v2_0_start(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
 	volatile struct amdgpu_fw_shared *fw_shared = adev-&gt;vcn.inst-&gt;fw_shared.cpu_addr;
 	struct amdgpu_ring *ring = &amp;adev-&gt;vcn.inst-&gt;ring_dec;
 	uint32_t rb_bufsz, tmp;
@@ -981,16 +991,16 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
 		amdgpu_dpm_enable_vcn(adev, true, 0);
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG)
-		return vcn_v2_0_start_dpg_mode(adev, adev-&gt;vcn.inst-&gt;indirect_sram);
+		return vcn_v2_0_start_dpg_mode(vinst, adev-&gt;vcn.inst-&gt;indirect_sram);
 
-	vcn_v2_0_disable_static_power_gating(adev);
+	vcn_v2_0_disable_static_power_gating(vinst);
 
 	/* set uvd status busy */
 	tmp = RREG32_SOC15(UVD, 0, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
 	WREG32_SOC15(UVD, 0, mmUVD_STATUS, tmp);
 
 	/*SW clock gating */
-	vcn_v2_0_disable_clock_gating(adev);
+	vcn_v2_0_disable_clock_gating(vinst);
 
 	/* enable VCPU clock */
 	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_VCPU_CNTL),
@@ -1034,7 +1044,7 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
 		(0x1 &lt;&lt; UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		(0x2 &lt;&lt; UVD_MPC_SET_MUX__SET_2__SHIFT)));
 
-	vcn_v2_0_mc_resume(adev);
+	vcn_v2_0_mc_resume(vinst);
 
 	/* release VCPU reset to boot */
 	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_SOFT_RESET), 0,
@@ -1142,8 +1152,9 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int vcn_v2_0_stop_dpg_mode(struct amdgpu_device *adev)
+static int vcn_v2_0_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
 	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__UNPAUSE};
 	uint32_t tmp;
 
@@ -1172,13 +1183,14 @@ static int vcn_v2_0_stop_dpg_mode(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int vcn_v2_0_stop(struct amdgpu_device *adev)
+static int vcn_v2_0_stop(struct amdgpu_vcn_inst *vinst)
 {
+	struct amdgpu_device *adev = vinst-&gt;adev;
 	uint32_t tmp;
 	int r;
 
 	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) {
-		r = vcn_v2_0_stop_dpg_mode(adev);
+		r = vcn_v2_0_stop_dpg_mode(vinst);
 		if (r)
 			return r;
 		goto power_off;
@@ -1230,8 +1242,8 @@ static int vcn_v2_0_stop(struct amdgpu_device *adev)
 	/* clear status */
 	WREG32_SOC15(VCN, 0, mmUVD_STATUS, 0);
 
-	vcn_v2_0_enable_clock_gating(adev);
-	vcn_v2_0_enable_static_power_gating(adev);
+	vcn_v2_0_enable_clock_gating(vinst);
+	vcn_v2_0_enable_static_power_gating(vinst);
 
 power_off:
 	if (adev-&gt;pm.dpm_enabled)
@@ -1348,10 +1360,10 @@ static int vcn_v2_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 		/* wait for STATUS to clear */
 		if (!vcn_v2_0_is_idle(adev))
 			return -EBUSY;
-		vcn_v2_0_enable_clock_gating(adev);
+		vcn_v2_0_enable_clock_gating(&amp;adev-&gt;vcn.inst[0]);
 	} else {
 		/* disable HW gating and enable Sw gating */
-		vcn_v2_0_disable_clock_gating(adev);
+		vcn_v2_0_disable_clock_gating(&amp;adev-&gt;vcn.inst[0]);
 	}
 	return 0;
 }
@@ -1818,9 +1830,9 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v2_0_stop(adev);
+		ret = vcn_v2_0_stop(adev-&gt;vcn.inst);
 	else
-		ret = vcn_v2_0_start(adev);
+		ret = vcn_v2_0_start(adev-&gt;vcn.inst);
 
 	if (!ret)
 		adev-&gt;vcn.inst[0].cur_state = state;
</pre>
    </blockquote>
  </body>
</html>

--------------kgq5wgmujYyW93DcXWGggQvX--

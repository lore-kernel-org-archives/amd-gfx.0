Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90ECC02194
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 15:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BAB110E6AB;
	Tue,  4 Feb 2025 15:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WauoAz5M";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2B9210E6AE
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 15:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/h58fRNsrSxESjBAJQ3etpY/jVSJln2ppMUgDVp6B8wpQT/C7QU+JDjCXUZwWIDMCRML+umdf4+kP2rI6L0/ZEr/wAv+wAyMMmtcdOhaWDtHNxslkiZ/UCz5s5XagvN2MUjpv5hy39zNFGLHICtrvqz/VWl4xmVvXiD0cGS9X+kp8a6RON6mvLtZJ/ldahqFb5Y2zFpQYg7wj7pwl+M9cYQ/4ZCSlJt0k1ullgCHXWW0/Big9ilgvzKKHd7UAdPJhofvO2/I6Yvoasi+FVe723U6DO9xL5vSWr1wH6vigML8AYaclyxrQhi8GRc41kHGd8Qs4YZqyiiM9z5IuST5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87+LXJXqqOPPqW2v7q+mvC5u+/DIbsfk4Ofz+oKX1dQ=;
 b=frNjLuAvs6zRBOP8zlJhuNVtqqNQbK7tkh2YnfKhln803CHiWiRw9vV8srf9veAp198UwpCfk/ZwoXkvmqpvvBXrl8bl2nQYliPSkxoI2otzzFlnElUjsse01q9VSUi+cCqpKlF71eIEQgcVY3DO2qVKPMhe8vw+CB8YtCKcWbI5n9doslot0UoJtLh0Akd1Fu60NC9MV9dwwlvJWSmSwUz7vNaoNXg/Y//h51GnreUTi+sZgdnX3cspECh75t8/0zi+zc5ry3qAUrN/qEe0sF+1kdkWqIfjkNMe0+rE2S1yWLUcOOTqzD/4S9vbk1LgDWIW3b/yvkGzncKXTvlqEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87+LXJXqqOPPqW2v7q+mvC5u+/DIbsfk4Ofz+oKX1dQ=;
 b=WauoAz5MtyJMGXZkgVXsURvkNvFV5NMvJTkpmg1u/TuDB0dpt9ltpT2kxi76brz5K0N1Q4cHssv6f1F8xstDUq0o9sNjx3F8avXaMJLBWS5LZ7sNFSgIkzyC3EgmEa8L8/S5ht36UC/BqKG/nmXkpGM+AcDFSss4uVI1d6L4N3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15)
 by LV3PR12MB9266.namprd12.prod.outlook.com (2603:10b6:408:21b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 15:56:47 +0000
Received: from CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc]) by CY8PR12MB7491.namprd12.prod.outlook.com
 ([fe80::217f:1ab1:9a5f:fecc%5]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 15:56:47 +0000
Content-Type: multipart/alternative;
 boundary="------------tHHo9wOEu4kjhhWVmRF4P3HD"
Message-ID: <09f79e81-1e31-4fe2-b50c-c1687f32aa29@amd.com>
Date: Tue, 4 Feb 2025 10:56:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/44] drm/amdgpu/vcn5.0.0: split code along instances
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-7-alexander.deucher@amd.com>
Content-Language: en-US
From: Boyuan Zhang <Boyuan.Zhang@amd.com>
In-Reply-To: <20250131165741.1798488-7-alexander.deucher@amd.com>
X-ClientProxiedBy: YQBPR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::41)
 To CY8PR12MB7491.namprd12.prod.outlook.com
 (2603:10b6:930:92::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7491:EE_|LV3PR12MB9266:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a10da9-af63-4901-6147-08dd45348778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHhzSm1ydm5WT1FWSGY5bndVUnd4cVplSHFIWVFzemZPUlRVRHcvQlI3NzQy?=
 =?utf-8?B?NTRwbHNaMmREMU9lU1BRVzNtMk04djczS1FKckRUYys4aE5GVG5iSmk4dnB5?=
 =?utf-8?B?WDBPd0F4MGoxUnIwdXY5bXJ1M2NxaHBSalF1RHhMVzFhQkpRS0tOdXBudzNI?=
 =?utf-8?B?Ly9FTWQ4ZWNKM1FKZ1pKcVRZUDY4c0doSHNkSUVXUGw1VzFwRURIOEsvZHlJ?=
 =?utf-8?B?amc4bEhrOXhBemFEV0xGajQ2blJWcVJ6cDlWVG94bS8zTjkvT3oxMzBqUDZT?=
 =?utf-8?B?blEvVEZlWDhTVVg0K2FJVmlNVHBndHQ3VFRMM1dSU1ovaXY0ZE56NmRWWGhB?=
 =?utf-8?B?NmFxQVdVdlVGbU4wdUNHKzVPT1QyV2JaMVJrbEFsanQxV2tWZWt6ejB0cUFV?=
 =?utf-8?B?UmVMLzBLNjV4RG5xU1JUcHFlRXdGeVcxWlhKRDRLZlpNUjhTZkRPR051b0dr?=
 =?utf-8?B?cENKVnA2VDk5V0hTZ3l1clc3T29TMDJqUDdZdDZiOU9MZGo1ZkZOUmc2dEow?=
 =?utf-8?B?WU9vcjE5czZwcFJhczJmUUJaZmlGcTVNMWRDbVprczY2U3pyQ01FbjA2MnFI?=
 =?utf-8?B?TERrZkNXT2VSVGZwUFBHN0gzR1JERkcvbjR1eXAydEFTTDR2NzlpelhnTVVC?=
 =?utf-8?B?ZmR2cUtkMFh5SXo3UUgreStlcmYrRlo1OGZRV0w1cVEzRTEzOThXdHJyVHZK?=
 =?utf-8?B?bld6UnJxYlA4ZmtuTU9oR3RpeXFSeldwTHJnUndLSGFwcmV1aXJpRkRmV0hz?=
 =?utf-8?B?YVNGeFBrVVZVR2dsRkVOeU9NeXVVRjNyc0l5b3dmVlpxNkFjaGJ4eU9LcGI1?=
 =?utf-8?B?NXFncWVOSURSTWR4L3R1aG0vbTMwOHBKTFRJcHkzYkFEM3ZZZXJPU1NrMDVw?=
 =?utf-8?B?aFhBUlBESjlKdmQxUXV5OWQ2Yk9TZ0xycHBJVE5kUE0yTWUxNzdIK2F6MUdo?=
 =?utf-8?B?OWwxblByaVhKY2VuakdxbWlHQWowZThWWTVmUXVqNzM0WjZGRXZvRjV2Tlhi?=
 =?utf-8?B?aG1VU0hlLzhZL1ltMGhlN3pMUUFqdmExSkpaUGlPS1Q2WWl3eTFGemJUaGhY?=
 =?utf-8?B?MVRHSmVqM003R1hCUWcrRmxmMHhrK0FXNGp6V2ErdElYUEtyWHJNczlPc2M2?=
 =?utf-8?B?TkJVSnE0ZVZJWkZRUExhVmNMN2t6bXBzUU9hVkR0aTN4N0VYekM1UHFLRmVS?=
 =?utf-8?B?blNrTEZ1bXZJbG4wdllmV2dKam9MeGQ5YnpJTW94TzdwdTlmK2d5SjFjdnN6?=
 =?utf-8?B?Rkh1VGVKdkhBTHl1bXYvUDJBckxpUlFOUXNhbjd0b1M1enFka2U1RlkzSFE0?=
 =?utf-8?B?ejhibTA1UzM0RXZYNXlralVUYzZkZTIxQzh5eGoxWFhVU2tYdzJPcElRRG1h?=
 =?utf-8?B?SzZQSjRhSFJURVAxK2lYN1QwT1RJWllscDNmdU5uNWhLclBTWTZPeFlJbzV2?=
 =?utf-8?B?VDlHQVBLaDFQZm9rNTRVTG1CQ2NxeXZYdHEvNC9JRmFyZC9hVkdqSmlOeDV5?=
 =?utf-8?B?RUpldDJDc0RWQ1lQWTlOWU9kZUw0QlU2b1ZjN0p3aGFGOTNaWlovNThMOWF1?=
 =?utf-8?B?T0pPVGV5SGUrTEJkOVdueW1zWlBkNVdiY1FIZUJzSEo5bmg3cFN0Q3pMVTMx?=
 =?utf-8?B?dElWU0dLMkdtZzdLTEM2MGZrWmZKbndYWjJSYkpReE14djUzemdBcUUyejgz?=
 =?utf-8?B?bzN5ZXE1SmRLV09BQWMwTldhUkE0NXBNZmRiODA2ajRML1pCbHBWTC9OWi94?=
 =?utf-8?B?UkJWN3E4K2FlN2IyZFJZOHpjNWtpWkZXNVNqWVRpT1k1d1JCVzIzTkQxVDhl?=
 =?utf-8?B?VEdXY2RzUG11eGVDQzNGckkxTXdSRFFoWTFhMEhTV1g5VXNXd1A2YStxRGg1?=
 =?utf-8?Q?153nVvHUacMbs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkdsZzdJNVFHRm1nSHlscVZPeWZJVE90NFNUZklra1plNnVvcXkzMTFBVnVC?=
 =?utf-8?B?cUI0QnFNdFM1b1JMdjlMVmtRc2dQaUpKTmxpMklhR3BTb0ptM2xLazM1djFG?=
 =?utf-8?B?SmUvbnpCOFU5Yis1WVEvdHRLbGVCZ0E4YkhldzVQZWJKbG92K3k4YjdxVFg5?=
 =?utf-8?B?T1RQNGJQR3gxTU5OR3ZZYmF6MXJDaWNoV3pYNzhqdDhTVEJoelJFRDFtb2p6?=
 =?utf-8?B?SmxFUGdjTTBpRXVGRGl3VEdIb3UxMVV0SVA1YnVVMTNPUS96cGk4Z01FWU1B?=
 =?utf-8?B?R0UvQzdXTzBpVE9PSnB3K3hGSG1ERHE3a0MydEpsZzFHOERVeWhyWG1na01o?=
 =?utf-8?B?c3dLNS9FQ0NJb2FsMHdzLzk4a3ZSUEhWLzJDQ05ESDhLK0RrN2d1QmR1dWds?=
 =?utf-8?B?cmkvd1h0VUJHL3RsS2hienZXWlZlUDB3VGE0TzhMOUVKamtHdjUwYjBiMzNL?=
 =?utf-8?B?M1lCYmprMWdIK2VMcnFGOG9NZVM2TVdiWTJzSDBsR1duTTNkY1ZUeHVBYWhP?=
 =?utf-8?B?NytOdldESUtGOERBeTFHaEswa2xHMis0QlIxdi9sR3p5VXN6L2FrMkJwcWMx?=
 =?utf-8?B?T2o4YytWL01RUVlEWlpnYVZ3eEc1TDFKbmxkNkhyWURRTTM2SXhGZ1l4b1ZO?=
 =?utf-8?B?cnkxWlZ3WDBBZWNZMUV3M0U0eDhPdXRmcDJ2ZkExWlZ3cTFKR1E0b1RyRWx6?=
 =?utf-8?B?UW5lbk1RVkJoUVlrWUx0MTRlZWppbmdxd3dnVTk2U2NzandDTjY3N1ZiOGFI?=
 =?utf-8?B?cWx0M2MrekRFOGF1dGZ5blZicHBiRUczMFNyaVBrZVZ0WlhXa1JWSUhRbjZx?=
 =?utf-8?B?OEhYNUJXK3ZDZHZMWFA2b0Vpd01yNXhjSUg1NzJINnVyQlVOZmx5U1ducDdl?=
 =?utf-8?B?a1krNWF2K0lQdnFHK3ptOUduK2dBTkRVUG5oMDc4ZmwrVDRlcTl6SnhCbG93?=
 =?utf-8?B?eVA1a1B6MVBhZFRqNUc5c2oyOUlBSnhIOG9Heno2bWJBd3dhNWtveURuaXRO?=
 =?utf-8?B?MlMzMHRnRUMxTHUwcmR1dkpHaWQyL3gvcGhNb1ZobjJzN1dWUlZGaW9xUTFw?=
 =?utf-8?B?UGw2d2Vnam9NdjVRdlZSMXJaa3NLVlZ4cWVKMG4zdE9jejRpK2gxaCtzNmhT?=
 =?utf-8?B?enRYckdFa3Q2clFuMnp1QlpjS2sxR012OVllUW4ydmFrSVVnbzVoWTI4YkdS?=
 =?utf-8?B?SmVFS2pLRkV6Um5XR0xUVHBFdXQ5SjZzOHFtL2FEZFdObmlpUmVxd3VzNjlN?=
 =?utf-8?B?WmE0c3RVRmJWTkJPb2ZWRnIzcmxiTmNVMkNyS0ZYdjhEQ3NvdXUrVTY1WjRP?=
 =?utf-8?B?R2dIeEJ4TnV4SDRaZzJ5aDRmUzFKd2ErZyt1L0QzRFlnVnhyeG1kM2FmSm40?=
 =?utf-8?B?ODBWZDlGWElNaVFEVjg1QlVJRkdrRUJ5ay9ndS9pSlNTeHowdVJ2ZUpkeWhx?=
 =?utf-8?B?M0E4bk5SWFdsSzI2eTZkNFo1NlNSeWhkWTQvWjAyZnhab0lDZXlCOUdQTGhm?=
 =?utf-8?B?QlNoMUJmajJuZ3QzZTVLOTVkSkZ4bWVwbnQ0TmNnYmxsenlyNExrMTNnOWpJ?=
 =?utf-8?B?WWMzYlQ2OFZCQjZRV2xVV0ZmOTkwSXk3dEI2SmxCaFJEYlFJSmpMUE82bDEv?=
 =?utf-8?B?ZU5ZYnNLVCtxSUVPRm83S1VPdkJkRmtpUGp4RFI3aitSVFhNb1lNUm1pdTZK?=
 =?utf-8?B?K0laRHJPUzRFeVhWZm9URXplbnBzNDZCQ3RZSnNJWm4yenozc0FnMkoxcU1J?=
 =?utf-8?B?bFBDVDk5b243OUc4WkJQRVZXbDdEUDVNMWNWZUhIaE1Rb2pVZ1BHTkZWRCtL?=
 =?utf-8?B?UTlMbmZ2NWwxNkoxUVI5ejRnbGczV2tzVXFScjRyZDA1UXQ0UW05bXlDZ3FH?=
 =?utf-8?B?Vkc0WTllcVVxM0p5OEpXMTNiV0RmUGFzM3NJNkorOWNRV2VZUmd4SDYzV2lJ?=
 =?utf-8?B?U0l5OXdIeXFtRGJxYWQwc3Nwb29tYWgvdS9oT2VTUi9yZHNUK0dVVjZEVzJO?=
 =?utf-8?B?ekVueDd2K0NkbWs2S2tOTGVNRm9uLzNyV3ZwUDBYdVFGR0xYSGNVc29DNkNy?=
 =?utf-8?B?SThDSjhFYmlIN0IvV2pKSTFsbWwrRWs1M2haaDBHWmh1Q215ZzZyMHVMa1hk?=
 =?utf-8?Q?KaNRp5AtWLrRJ20K+kSIwdsGm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a10da9-af63-4901-6147-08dd45348778
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 15:56:47.1900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4oV8N030cre4MO+NWwkXPdq6SYVP9f89jn5iPYwXoYCA02VeGM3U7QlXU2DzyRF6ApcKx2uzyyle2PtIyFdPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9266
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

--------------tHHo9wOEu4kjhhWVmRF4P3HD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025-01-31 11:57, Alex Deucher wrote:
> Split the code on a per instance basis.  This will allow
> us to use the per instance functions in the future to
> handle more things per instance.
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>


Reviewed-by: Boyuan Zhang <Boyuan.Zhang@amd.com> 
<mailto:Boyuan.Zhang@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 386 ++++++++++++------------
>   1 file changed, 190 insertions(+), 196 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index b6d78381ebfbc..6b777ed01d445 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -767,154 +767,149 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
>    * vcn_v5_0_0_start - VCN start
>    *
>    * @adev: amdgpu_device pointer
> + * @i: instance to start
>    *
>    * Start VCN block
>    */
> -static int vcn_v5_0_0_start(struct amdgpu_device *adev)
> +static int vcn_v5_0_0_start(struct amdgpu_device *adev, int i)
>   {
>   	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
>   	struct amdgpu_ring *ring;
>   	uint32_t tmp;
> -	int i, j, k, r;
> +	int j, k, r;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->pm.dpm_enabled)
> -			amdgpu_dpm_enable_vcn(adev, true, i);
> -	}
> +	if (adev->vcn.harvest_config & (1 << i))
> +		return 0;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> +	if (adev->pm.dpm_enabled)
> +		amdgpu_dpm_enable_vcn(adev, true, i);
>   
> -		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
>   
> -		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -			r = vcn_v5_0_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
> -			continue;
> -		}
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> +		return vcn_v5_0_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
>   
> -		/* disable VCN power gating */
> -		vcn_v5_0_0_disable_static_power_gating(adev, i);
> -
> -		/* set VCN status busy */
> -		tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> -		WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
> -
> -		/* enable VCPU clock */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> -			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
> -
> -		/* disable master interrupt */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN), 0,
> -			~UVD_MASTINT_EN__VCPU_EN_MASK);
> -
> -		/* enable LMI MC and UMC channels */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_LMI_CTRL2), 0,
> -			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> -
> -		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> -		tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -		tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> -
> -		/* setup regUVD_LMI_CTRL */
> -		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL);
> -		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL, tmp |
> -			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> -			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> -			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> -			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> -
> -		vcn_v5_0_0_mc_resume(adev, i);
> -
> -		/* VCN global tiling registers */
> -		WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
> -			adev->gfx.config.gb_addr_config);
> -
> -		/* unblock VCPU register access */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL), 0,
> -			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> -
> -		/* release VCPU reset to boot */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> -			~UVD_VCPU_CNTL__BLK_RST_MASK);
> -
> -		for (j = 0; j < 10; ++j) {
> -			uint32_t status;
> -
> -			for (k = 0; k < 100; ++k) {
> -				status = RREG32_SOC15(VCN, i, regUVD_STATUS);
> -				if (status & 2)
> -					break;
> -				mdelay(10);
> -				if (amdgpu_emu_mode == 1)
> -					msleep(1);
> -			}
> +	/* disable VCN power gating */
> +	vcn_v5_0_0_disable_static_power_gating(adev, i);
> +
> +	/* set VCN status busy */
> +	tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
> +	WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
> +
> +	/* enable VCPU clock */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> +		 UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
> +
> +	/* disable master interrupt */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN), 0,
> +		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
> +
> +	/* enable LMI MC and UMC channels */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_LMI_CTRL2), 0,
> +		 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
> +
> +	tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> +	tmp &= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +	tmp &= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +	WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
>   
> -			if (amdgpu_emu_mode == 1) {
> -				r = -1;
> -				if (status & 2) {
> -					r = 0;
> -					break;
> -				}
> -			} else {
> +	/* setup regUVD_LMI_CTRL */
> +	tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL);
> +	WREG32_SOC15(VCN, i, regUVD_LMI_CTRL, tmp |
> +		     UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
> +		     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
> +		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
> +		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
> +
> +	vcn_v5_0_0_mc_resume(adev, i);
> +
> +	/* VCN global tiling registers */
> +	WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
> +		     adev->gfx.config.gb_addr_config);
> +
> +	/* unblock VCPU register access */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL), 0,
> +		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> +
> +	/* release VCPU reset to boot */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> +		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +
> +	for (j = 0; j < 10; ++j) {
> +		uint32_t status;
> +
> +		for (k = 0; k < 100; ++k) {
> +			status = RREG32_SOC15(VCN, i, regUVD_STATUS);
> +			if (status & 2)
> +				break;
> +			mdelay(10);
> +			if (amdgpu_emu_mode == 1)
> +				msleep(1);
> +		}
> +
> +		if (amdgpu_emu_mode == 1) {
> +			r = -1;
> +			if (status & 2) {
>   				r = 0;
> -				if (status & 2)
> -					break;
> -
> -				dev_err(adev->dev,
> -					"VCN[%d] is not responding, trying to reset the VCPU!!!\n", i);
> -				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> -							UVD_VCPU_CNTL__BLK_RST_MASK,
> -							~UVD_VCPU_CNTL__BLK_RST_MASK);
> -				mdelay(10);
> -				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> -							~UVD_VCPU_CNTL__BLK_RST_MASK);
> -
> -				mdelay(10);
> -				r = -1;
> +				break;
>   			}
> +		} else {
> +			r = 0;
> +			if (status & 2)
> +				break;
> +
> +			dev_err(adev->dev,
> +				"VCN[%d] is not responding, trying to reset the VCPU!!!\n", i);
> +			WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> +				 UVD_VCPU_CNTL__BLK_RST_MASK,
> +				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +			mdelay(10);
> +			WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> +				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +
> +			mdelay(10);
> +			r = -1;
>   		}
> +	}
>   
> -		if (r) {
> -			dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", i);
> -			return r;
> -		}
> +	if (r) {
> +		dev_err(adev->dev, "VCN[%d] is not responding, giving up!!!\n", i);
> +		return r;
> +	}
>   
> -		/* enable master interrupt */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN),
> -				UVD_MASTINT_EN__VCPU_EN_MASK,
> -				~UVD_MASTINT_EN__VCPU_EN_MASK);
> +	/* enable master interrupt */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN),
> +		 UVD_MASTINT_EN__VCPU_EN_MASK,
> +		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
>   
> -		/* clear the busy bit of VCN_STATUS */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_STATUS), 0,
> -			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
> +	/* clear the busy bit of VCN_STATUS */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_STATUS), 0,
> +		 ~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
>   
> -		ring = &adev->vcn.inst[i].ring_enc[0];
> -		WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
> -			ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
> -			VCN_RB1_DB_CTRL__EN_MASK);
> -
> -		WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
> -		WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> -		WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring->ring_size / 4);
> -
> -		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
> -		tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
> -		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
> -		fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
> -		WREG32_SOC15(VCN, i, regUVD_RB_RPTR, 0);
> -		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, 0);
> -
> -		tmp = RREG32_SOC15(VCN, i, regUVD_RB_RPTR);
> -		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, tmp);
> -		ring->wptr = RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
> -
> -		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
> -		tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
> -		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
> -		fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
> -	}
> +	ring = &adev->vcn.inst[i].ring_enc[0];
> +	WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
> +		     ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
> +		     VCN_RB1_DB_CTRL__EN_MASK);
> +
> +	WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
> +	WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
> +	WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring->ring_size / 4);
> +
> +	tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
> +	tmp &= ~(VCN_RB_ENABLE__RB1_EN_MASK);
> +	WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
> +	fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
> +	WREG32_SOC15(VCN, i, regUVD_RB_RPTR, 0);
> +	WREG32_SOC15(VCN, i, regUVD_RB_WPTR, 0);
> +
> +	tmp = RREG32_SOC15(VCN, i, regUVD_RB_RPTR);
> +	WREG32_SOC15(VCN, i, regUVD_RB_WPTR, tmp);
> +	ring->wptr = RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
> +
> +	tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
> +	tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
> +	WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
> +	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
>   
>   	return 0;
>   }
> @@ -953,83 +948,80 @@ static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
>    * vcn_v5_0_0_stop - VCN stop
>    *
>    * @adev: amdgpu_device pointer
> + * @i: instance to stop
>    *
>    * Stop VCN block
>    */
> -static int vcn_v5_0_0_stop(struct amdgpu_device *adev)
> +static int vcn_v5_0_0_stop(struct amdgpu_device *adev, int i)
>   {
>   	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
>   	uint32_t tmp;
> -	int i, r = 0;
> +	int r = 0;
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->vcn.harvest_config & (1 << i))
> -			continue;
> +	if (adev->vcn.harvest_config & (1 << i))
> +		return 0;
>   
> -		fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> -		fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
> +	fw_shared = adev->vcn.inst[i].fw_shared.cpu_addr;
> +	fw_shared->sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
>   
> -		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> -			vcn_v5_0_0_stop_dpg_mode(adev, i);
> -			continue;
> -		}
> +	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> +		vcn_v5_0_0_stop_dpg_mode(adev, i);
> +		return 0;
> +	}
>   
> -		/* wait for vcn idle */
> -		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> -		if (r)
> -			return r;
> +	/* wait for vcn idle */
> +	r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
> +	if (r)
> +		return r;
>   
> -		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> -		      UVD_LMI_STATUS__READ_CLEAN_MASK |
> -		      UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> -		      UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> -		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
> -		if (r)
> -			return r;
> +	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
> +		UVD_LMI_STATUS__READ_CLEAN_MASK |
> +		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
> +		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
> +	r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
> +	if (r)
> +		return r;
>   
> -		/* disable LMI UMC channel */
> -		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL2);
> -		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> -		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL2, tmp);
> -		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
> -		      UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> -		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
> -		if (r)
> -			return r;
> +	/* disable LMI UMC channel */
> +	tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL2);
> +	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
> +	WREG32_SOC15(VCN, i, regUVD_LMI_CTRL2, tmp);
> +	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
> +		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
> +	r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
> +	if (r)
> +		return r;
>   
> -		/* block VCPU register access */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL),
> -			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> -			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
> -
> -		/* reset VCPU */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> -			UVD_VCPU_CNTL__BLK_RST_MASK,
> -			~UVD_VCPU_CNTL__BLK_RST_MASK);
> -
> -		/* disable VCPU clock */
> -		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> -			~(UVD_VCPU_CNTL__CLK_EN_MASK));
> -
> -		/* apply soft reset */
> -		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> -		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> -		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> -		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> -		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> -		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> -
> -		/* clear status */
> -		WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
> -
> -		/* enable VCN power gating */
> -		vcn_v5_0_0_enable_static_power_gating(adev, i);
> -	}
> +	/* block VCPU register access */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL),
> +		 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
> +		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
>   
> -	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> -		if (adev->pm.dpm_enabled)
> -			amdgpu_dpm_enable_vcn(adev, false, i);
> -	}
> +	/* reset VCPU */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
> +		 UVD_VCPU_CNTL__BLK_RST_MASK,
> +		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
> +
> +	/* disable VCPU clock */
> +	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
> +		 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
> +
> +	/* apply soft reset */
> +	tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> +	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
> +	WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> +	tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
> +	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
> +	WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
> +
> +	/* clear status */
> +	WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
> +
> +	/* enable VCN power gating */
> +	vcn_v5_0_0_enable_static_power_gating(adev, i);
> +
> +	if (adev->pm.dpm_enabled)
> +		amdgpu_dpm_enable_vcn(adev, false, i);
>   
>   	return 0;
>   }
> @@ -1279,15 +1271,17 @@ static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   		enum amd_powergating_state state)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
> -	int ret;
> +	int ret = 0, i;
>   
>   	if (state == adev->vcn.cur_state)
>   		return 0;
>   
> -	if (state == AMD_PG_STATE_GATE)
> -		ret = vcn_v5_0_0_stop(adev);
> -	else
> -		ret = vcn_v5_0_0_start(adev);
> +	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
> +		if (state == AMD_PG_STATE_GATE)
> +			ret |= vcn_v5_0_0_stop(adev, i);
> +		else
> +			ret |= vcn_v5_0_0_start(adev, i);
> +	}
>   
>   	if (!ret)
>   		adev->vcn.cur_state = state;
--------------tHHo9wOEu4kjhhWVmRF4P3HD
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
    <blockquote type="cite" cite="mid:20250131165741.1798488-7-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">Split the code on a per instance basis.  This will allow
us to use the per instance functions in the future to
handle more things per instance.

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p><font size="2"><span style="font-size:11pt;"><span data-markjs="true" data-olk-copy-source="MessageBody"><span data-markjs="true" class="mark1tk8wrane" style="" data-ogac="" data-ogab="" data-ogsc="" data-ogsb="" data-olk-copy-source="MessageBody">Reviewed-by</span></span>:
          Boyuan Zhang <a href="mailto:Boyuan.Zhang@amd.com" title="mailto:Boyuan.Zhang@amd.com" data-linkindex="2">&lt;Boyuan.Zhang@amd.com&gt;</a></span></font></p>
    <p></p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20250131165741.1798488-7-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 386 ++++++++++++------------
 1 file changed, 190 insertions(+), 196 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index b6d78381ebfbc..6b777ed01d445 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -767,154 +767,149 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, b
  * vcn_v5_0_0_start - VCN start
  *
  * @adev: amdgpu_device pointer
+ * @i: instance to start
  *
  * Start VCN block
  */
-static int vcn_v5_0_0_start(struct amdgpu_device *adev)
+static int vcn_v5_0_0_start(struct amdgpu_device *adev, int i)
 {
 	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
-	int i, j, k, r;
+	int j, k, r;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, true, i);
-	}
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
+		return 0;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;
+	if (adev-&gt;pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, true, i);
 
-		fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
+	fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
 
-		if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) {
-			r = vcn_v5_0_0_start_dpg_mode(adev, i, adev-&gt;vcn.indirect_sram);
-			continue;
-		}
+	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG)
+		return vcn_v5_0_0_start_dpg_mode(adev, i, adev-&gt;vcn.indirect_sram);
 
-		/* disable VCN power gating */
-		vcn_v5_0_0_disable_static_power_gating(adev, i);
-
-		/* set VCN status busy */
-		tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
-		WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
-
-		/* enable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
-			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
-
-		/* disable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN), 0,
-			~UVD_MASTINT_EN__VCPU_EN_MASK);
-
-		/* enable LMI MC and UMC channels */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_LMI_CTRL2), 0,
-			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
-
-		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
-		tmp &amp;= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		tmp &amp;= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
-
-		/* setup regUVD_LMI_CTRL */
-		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL);
-		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL, tmp |
-			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
-			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
-			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
-			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
-
-		vcn_v5_0_0_mc_resume(adev, i);
-
-		/* VCN global tiling registers */
-		WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
-			adev-&gt;gfx.config.gb_addr_config);
-
-		/* unblock VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL), 0,
-			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
-
-		/* release VCPU reset to boot */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
-			~UVD_VCPU_CNTL__BLK_RST_MASK);
-
-		for (j = 0; j &lt; 10; ++j) {
-			uint32_t status;
-
-			for (k = 0; k &lt; 100; ++k) {
-				status = RREG32_SOC15(VCN, i, regUVD_STATUS);
-				if (status &amp; 2)
-					break;
-				mdelay(10);
-				if (amdgpu_emu_mode == 1)
-					msleep(1);
-			}
+	/* disable VCN power gating */
+	vcn_v5_0_0_disable_static_power_gating(adev, i);
+
+	/* set VCN status busy */
+	tmp = RREG32_SOC15(VCN, i, regUVD_STATUS) | UVD_STATUS__UVD_BUSY;
+	WREG32_SOC15(VCN, i, regUVD_STATUS, tmp);
+
+	/* enable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
+
+	/* disable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN), 0,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
+
+	/* enable LMI MC and UMC channels */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_LMI_CTRL2), 0,
+		 ~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
+
+	tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
+	tmp &amp;= ~UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	tmp &amp;= ~UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
 
-			if (amdgpu_emu_mode == 1) {
-				r = -1;
-				if (status &amp; 2) {
-					r = 0;
-					break;
-				}
-			} else {
+	/* setup regUVD_LMI_CTRL */
+	tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL);
+	WREG32_SOC15(VCN, i, regUVD_LMI_CTRL, tmp |
+		     UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
+		     UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+		     UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+		     UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
+
+	vcn_v5_0_0_mc_resume(adev, i);
+
+	/* VCN global tiling registers */
+	WREG32_SOC15(VCN, i, regUVD_GFX10_ADDR_CONFIG,
+		     adev-&gt;gfx.config.gb_addr_config);
+
+	/* unblock VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL), 0,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
+
+	/* release VCPU reset to boot */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+	for (j = 0; j &lt; 10; ++j) {
+		uint32_t status;
+
+		for (k = 0; k &lt; 100; ++k) {
+			status = RREG32_SOC15(VCN, i, regUVD_STATUS);
+			if (status &amp; 2)
+				break;
+			mdelay(10);
+			if (amdgpu_emu_mode == 1)
+				msleep(1);
+		}
+
+		if (amdgpu_emu_mode == 1) {
+			r = -1;
+			if (status &amp; 2) {
 				r = 0;
-				if (status &amp; 2)
-					break;
-
-				dev_err(adev-&gt;dev,
-					&quot;VCN[%d] is not responding, trying to reset the VCPU!!!\n&quot;, i);
-				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
-							UVD_VCPU_CNTL__BLK_RST_MASK,
-							~UVD_VCPU_CNTL__BLK_RST_MASK);
-				mdelay(10);
-				WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
-							~UVD_VCPU_CNTL__BLK_RST_MASK);
-
-				mdelay(10);
-				r = -1;
+				break;
 			}
+		} else {
+			r = 0;
+			if (status &amp; 2)
+				break;
+
+			dev_err(adev-&gt;dev,
+				&quot;VCN[%d] is not responding, trying to reset the VCPU!!!\n&quot;, i);
+			WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
+				 UVD_VCPU_CNTL__BLK_RST_MASK,
+				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+			mdelay(10);
+			WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
+				 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+			mdelay(10);
+			r = -1;
 		}
+	}
 
-		if (r) {
-			dev_err(adev-&gt;dev, &quot;VCN[%d] is not responding, giving up!!!\n&quot;, i);
-			return r;
-		}
+	if (r) {
+		dev_err(adev-&gt;dev, &quot;VCN[%d] is not responding, giving up!!!\n&quot;, i);
+		return r;
+	}
 
-		/* enable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN),
-				UVD_MASTINT_EN__VCPU_EN_MASK,
-				~UVD_MASTINT_EN__VCPU_EN_MASK);
+	/* enable master interrupt */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_MASTINT_EN),
+		 UVD_MASTINT_EN__VCPU_EN_MASK,
+		 ~UVD_MASTINT_EN__VCPU_EN_MASK);
 
-		/* clear the busy bit of VCN_STATUS */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_STATUS), 0,
-			~(2 &lt;&lt; UVD_STATUS__VCPU_REPORT__SHIFT));
+	/* clear the busy bit of VCN_STATUS */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_STATUS), 0,
+		 ~(2 &lt;&lt; UVD_STATUS__VCPU_REPORT__SHIFT));
 
-		ring = &amp;adev-&gt;vcn.inst[i].ring_enc[0];
-		WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
-			ring-&gt;doorbell_index &lt;&lt; VCN_RB1_DB_CTRL__OFFSET__SHIFT |
-			VCN_RB1_DB_CTRL__EN_MASK);
-
-		WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring-&gt;gpu_addr);
-		WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring-&gt;gpu_addr));
-		WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring-&gt;ring_size / 4);
-
-		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
-		tmp &amp;= ~(VCN_RB_ENABLE__RB1_EN_MASK);
-		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
-		fw_shared-&gt;sq.queue_mode |= FW_QUEUE_RING_RESET;
-		WREG32_SOC15(VCN, i, regUVD_RB_RPTR, 0);
-		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, 0);
-
-		tmp = RREG32_SOC15(VCN, i, regUVD_RB_RPTR);
-		WREG32_SOC15(VCN, i, regUVD_RB_WPTR, tmp);
-		ring-&gt;wptr = RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
-
-		tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
-		tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
-		WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
-		fw_shared-&gt;sq.queue_mode &amp;= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
-	}
+	ring = &amp;adev-&gt;vcn.inst[i].ring_enc[0];
+	WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
+		     ring-&gt;doorbell_index &lt;&lt; VCN_RB1_DB_CTRL__OFFSET__SHIFT |
+		     VCN_RB1_DB_CTRL__EN_MASK);
+
+	WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring-&gt;gpu_addr);
+	WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring-&gt;gpu_addr));
+	WREG32_SOC15(VCN, i, regUVD_RB_SIZE, ring-&gt;ring_size / 4);
+
+	tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
+	tmp &amp;= ~(VCN_RB_ENABLE__RB1_EN_MASK);
+	WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
+	fw_shared-&gt;sq.queue_mode |= FW_QUEUE_RING_RESET;
+	WREG32_SOC15(VCN, i, regUVD_RB_RPTR, 0);
+	WREG32_SOC15(VCN, i, regUVD_RB_WPTR, 0);
+
+	tmp = RREG32_SOC15(VCN, i, regUVD_RB_RPTR);
+	WREG32_SOC15(VCN, i, regUVD_RB_WPTR, tmp);
+	ring-&gt;wptr = RREG32_SOC15(VCN, i, regUVD_RB_WPTR);
+
+	tmp = RREG32_SOC15(VCN, i, regVCN_RB_ENABLE);
+	tmp |= VCN_RB_ENABLE__RB1_EN_MASK;
+	WREG32_SOC15(VCN, i, regVCN_RB_ENABLE, tmp);
+	fw_shared-&gt;sq.queue_mode &amp;= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
 
 	return 0;
 }
@@ -953,83 +948,80 @@ static void vcn_v5_0_0_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
  * vcn_v5_0_0_stop - VCN stop
  *
  * @adev: amdgpu_device pointer
+ * @i: instance to stop
  *
  * Stop VCN block
  */
-static int vcn_v5_0_0_stop(struct amdgpu_device *adev)
+static int vcn_v5_0_0_stop(struct amdgpu_device *adev, int i)
 {
 	volatile struct amdgpu_vcn5_fw_shared *fw_shared;
 	uint32_t tmp;
-	int i, r = 0;
+	int r = 0;
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
-			continue;
+	if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))
+		return 0;
 
-		fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
-		fw_shared-&gt;sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
+	fw_shared = adev-&gt;vcn.inst[i].fw_shared.cpu_addr;
+	fw_shared-&gt;sq.queue_mode |= FW_QUEUE_DPG_HOLD_OFF;
 
-		if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) {
-			vcn_v5_0_0_stop_dpg_mode(adev, i);
-			continue;
-		}
+	if (adev-&gt;pg_flags &amp; AMD_PG_SUPPORT_VCN_DPG) {
+		vcn_v5_0_0_stop_dpg_mode(adev, i);
+		return 0;
+	}
 
-		/* wait for vcn idle */
-		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
-		if (r)
-			return r;
+	/* wait for vcn idle */
+	r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_STATUS, UVD_STATUS__IDLE, 0x7);
+	if (r)
+		return r;
 
-		tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
-		      UVD_LMI_STATUS__READ_CLEAN_MASK |
-		      UVD_LMI_STATUS__WRITE_CLEAN_MASK |
-		      UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	tmp = UVD_LMI_STATUS__VCPU_LMI_WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__READ_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_MASK |
+		UVD_LMI_STATUS__WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* disable LMI UMC channel */
-		tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL2);
-		tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
-		WREG32_SOC15(VCN, i, regUVD_LMI_CTRL2, tmp);
-		tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
-		      UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
-		r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
-		if (r)
-			return r;
+	/* disable LMI UMC channel */
+	tmp = RREG32_SOC15(VCN, i, regUVD_LMI_CTRL2);
+	tmp |= UVD_LMI_CTRL2__STALL_ARB_UMC_MASK;
+	WREG32_SOC15(VCN, i, regUVD_LMI_CTRL2, tmp);
+	tmp = UVD_LMI_STATUS__UMC_READ_CLEAN_RAW_MASK |
+		UVD_LMI_STATUS__UMC_WRITE_CLEAN_RAW_MASK;
+	r = SOC15_WAIT_ON_RREG(VCN, i, regUVD_LMI_STATUS, tmp, tmp);
+	if (r)
+		return r;
 
-		/* block VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL),
-			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
-			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
-
-		/* reset VCPU */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
-			UVD_VCPU_CNTL__BLK_RST_MASK,
-			~UVD_VCPU_CNTL__BLK_RST_MASK);
-
-		/* disable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
-			~(UVD_VCPU_CNTL__CLK_EN_MASK));
-
-		/* apply soft reset */
-		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
-		tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
-		tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
-		WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
-
-		/* clear status */
-		WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
-
-		/* enable VCN power gating */
-		vcn_v5_0_0_enable_static_power_gating(adev, i);
-	}
+	/* block VCPU register access */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_RB_ARB_CTRL),
+		 UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
+		 ~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
 
-	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
-		if (adev-&gt;pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false, i);
-	}
+	/* reset VCPU */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL),
+		 UVD_VCPU_CNTL__BLK_RST_MASK,
+		 ~UVD_VCPU_CNTL__BLK_RST_MASK);
+
+	/* disable VCPU clock */
+	WREG32_P(SOC15_REG_OFFSET(VCN, i, regUVD_VCPU_CNTL), 0,
+		 ~(UVD_VCPU_CNTL__CLK_EN_MASK));
+
+	/* apply soft reset */
+	tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_UMC_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
+	tmp = RREG32_SOC15(VCN, i, regUVD_SOFT_RESET);
+	tmp |= UVD_SOFT_RESET__LMI_SOFT_RESET_MASK;
+	WREG32_SOC15(VCN, i, regUVD_SOFT_RESET, tmp);
+
+	/* clear status */
+	WREG32_SOC15(VCN, i, regUVD_STATUS, 0);
+
+	/* enable VCN power gating */
+	vcn_v5_0_0_enable_static_power_gating(adev, i);
+
+	if (adev-&gt;pm.dpm_enabled)
+		amdgpu_dpm_enable_vcn(adev, false, i);
 
 	return 0;
 }
@@ -1279,15 +1271,17 @@ static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block-&gt;adev;
-	int ret;
+	int ret = 0, i;
 
 	if (state == adev-&gt;vcn.cur_state)
 		return 0;
 
-	if (state == AMD_PG_STATE_GATE)
-		ret = vcn_v5_0_0_stop(adev);
-	else
-		ret = vcn_v5_0_0_start(adev);
+	for (i = 0; i &lt; adev-&gt;vcn.num_vcn_inst; ++i) {
+		if (state == AMD_PG_STATE_GATE)
+			ret |= vcn_v5_0_0_stop(adev, i);
+		else
+			ret |= vcn_v5_0_0_start(adev, i);
+	}
 
 	if (!ret)
 		adev-&gt;vcn.cur_state = state;
</pre>
    </blockquote>
  </body>
</html>

--------------tHHo9wOEu4kjhhWVmRF4P3HD--

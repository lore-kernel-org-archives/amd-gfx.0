Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D79CCD1BF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 13:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83C4610E3F4;
	Tue, 28 Oct 2025 13:16:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kU2l6jEu";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B51810E3F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 13:16:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukiverYw7cbFV6HzarUAer5XMqYT8lN6BV/fykQfe3DMsCcbtngs8nJ17j0qOQ8YMHMMZRhLzC7vPmzVl9xC9ULBWJn050nR9Ejx4zFQ8u4VgHNou1uGqEigFlrc6kGJXcTd8Nbez9XiGARuCUkJV16wvE4a59MQIK+OXRlgvtjY5GI8I7VH7rFC0O5JzQtIz+v/XGJbY5tC13f7AhocEnY66S4ndDQW6aOZh6uQ+Xjxv2BROdUpm7SIq+t+XAOUiKiltgFZHr0eZjybb4c73Uhhf+rN75a16kvDqkzkVCyeF8zC4vf6sV5eygupmdVZ65ZAdiBTuy2pLeH0y9uQ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPLLnq09fmbAEBfXkwMN4vHGz17sUwGbJVOnPI/0ONs=;
 b=rcZwudw1Q3pRlZOoKGdmq0tVRMcKyD0RU2W70YzVhJWwS4w41/AaaAuX50i/42Y/kl3WhXGDAG94lv+E8e1PZWFPdEOy793/yEYB8ijCxch+iaWqIUUlT808/yubmNO2ybxZ5WDL58AsuFgZdyud9Wq+QPZioGhMeUo4w1+BNmlV9FTBZUxMn6Y04N5obDqzASvSN4FfWTXvSj6nboKY9gDug7bS7RaRlSi6uU0cJwKm2NStDO/PWDmvokvCqWh5mIto1/zIH+IGGaZUpe8aQE4GxWcWIvmPFXjjaQjhUchf9QUmI4b1313MAIk231IeCRMpmmYwtIkXmTVkc5YJaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPLLnq09fmbAEBfXkwMN4vHGz17sUwGbJVOnPI/0ONs=;
 b=kU2l6jEuxWOPo/6MQWSNuAVOpytv/KuHApBfsrCcetreFlNDqzTuROdnPXoBUsLT0OjITBzvtaH5c9veVbhBbTackfbLX0kjOu5TML3rbaxF5oM9IKMdTMIYX4JN6Xwvy0HpEU+G6HfN5ZDUF0No4LF2FctLEkwABkzyPrGEiVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY1PR12MB9559.namprd12.prod.outlook.com (2603:10b6:930:fd::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.12; Tue, 28 Oct 2025 13:16:34 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 13:16:34 +0000
Message-ID: <13375ad8-468d-4995-ab35-7180b36e33e5@amd.com>
Date: Tue, 28 Oct 2025 18:46:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Refactor sriov xgmi topology filling to
 common code
To: will.aitken@amd.com, amd-gfx@lists.freedesktop.org
Cc: victor.skvortsov@amd.com, Will Aitken <wiaitken@amd.com>
References: <20251008133225.1238028-1-will.aitken@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20251008133225.1238028-1-will.aitken@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY1PR12MB9559:EE_
X-MS-Office365-Filtering-Correlation-Id: fdc72c90-9cc9-4f60-3a74-08de16243791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEp5bStiNjFKa1Y2bk8vSTE2TkJ0UlVtSEtxV2ZEV3VQK2FtSHBGR0lhQmRh?=
 =?utf-8?B?QWd3b2R4YUFVZGpVcHdLSFNBTHkxN2N4MUtBck1xYi83b2o5UkJTbnczLyth?=
 =?utf-8?B?TTM5M0pjaHRzY3ZhTzdFRFhSYy9DSnhwZWxWcmFpNTFBWno4YVFTMjlkS1JD?=
 =?utf-8?B?WDRWNGN5SnB6cGRPZm04dnFZZmthRFJONmx4eWpvVnQ4VWlWeDZzYU14U3hn?=
 =?utf-8?B?aXRhVGJmTnZ2MmhSYmdiTFMxZEdaWC9VdmNTeldyYkFWWldZVnNTQ3VvY3Za?=
 =?utf-8?B?dndwSlp3WEVXUFI2b2o4Umh6TDRuSWMwaEU0WEdvenZ0d01VSnlmcE1BUnNY?=
 =?utf-8?B?SkxzVzh1R21GaVZXbVRNZVJFcXUzSGMzYmdXcU8xWVo1QXRJa2NIYm5vS1RC?=
 =?utf-8?B?WVJ1bC9CYlRHTHo3bloyNW43bWJ2bVhIRUVEdUczaFhBSG8xZFc2ZjB1WnFH?=
 =?utf-8?B?RndoaDNFNlpVZEVreGxxUmdUSFREeWRPQmZkcFJUaGxpY2FRNlcva2pkN25K?=
 =?utf-8?B?aVRLTjVYMlA2Y2ZpZVdJT0dubEY4a3dWRkRXRG1tT1dEK3dFck1LYmVDdENo?=
 =?utf-8?B?RWUyMkFQMDRpREc4dmd6aURHelRXKytDQ1NOSnBjUVBhSTZqenJlbmh3cHE2?=
 =?utf-8?B?Y1V6VVBpNm8ySXBhMW1xSTlXUjgzMjBvakgzTHZmN1FvNXlsODdUay9VNVdN?=
 =?utf-8?B?MERYOG9sZTFsTHlKZUJkdjBFajZmcFBEQ1VHWS9scENyV1JsWUJoTjdXVW1J?=
 =?utf-8?B?cmFDZGNzYndad2p6eDBQZjEwM3ZZRUhzeUYyNjBLZmwxZE41OURnVVRsZGJx?=
 =?utf-8?B?YnBFNUZRQVdvcG5NK293bldneFo5ZFRWWUROcFRNT2ZQQ1dlK0U5dzJsUkE2?=
 =?utf-8?B?MGhsVXZ6WmpuYkxnN2ZsU25WaThYbmtpdWM2QTNrYXJxTS9KN29aVG9RQWE5?=
 =?utf-8?B?aUQ1Z0JUMCtGcjJ3aGR2T1NkdHFULzJiRXp1eW1JdG41MktvRHZUOUx5alJR?=
 =?utf-8?B?S2tKcE1IUVBySTJ2a0JZWkxSVXRnV2djSXY0cy9Sa1dTWERVZmlpZlBRenYr?=
 =?utf-8?B?ZWwvMkw4Tmpua1pPaisvbld5UWtTT1hVYXY1MlR5bDE5UEdHemdhSHFMOHlZ?=
 =?utf-8?B?b253Q0RlamxsT2FrM0dXQWo2YzJxRFZ3R0Z3R05MOU50YWYxTmRLNzlzM1pp?=
 =?utf-8?B?V2N0MjYvakIrU0lSTjBMdnlJd0I5MDE0RmxkSEFOQWxjUUVYcWZTRjIrSnJC?=
 =?utf-8?B?amorRXpQaERIQXpScVdmazhBV1NZMGFiNlN1Z0ZjejFuaGVIUys0NDJpK3lW?=
 =?utf-8?B?MHdFdm1odUVuaXBXWkxvbFh3bzBwbzl1MWU0RmppWFFiUk9BQ0xzN2hreEl5?=
 =?utf-8?B?VExtcHcxb3lObUFrUE9kZi9QKzhxcFlQTzhtR0o3d3BuQVVIODkxcDlPY2dy?=
 =?utf-8?B?M0grTVRsY1JrSWFsVlBJdGtrZkxPajNVVCtiTEIzVHlQWXEyVXFWeTlPOEMx?=
 =?utf-8?B?d21LcmMzU0VLWXlORnZrVXM0UnJwbkgxK3dNcHhyelU5dkJNbkpCVWhNbjVO?=
 =?utf-8?B?RVBjdU5vZnhwTU9pL3NFOHZINDl1QkJybzMxQ2Q1OS9VNE1TZzA0T0xlUkJ1?=
 =?utf-8?B?dHZtWTYxWUdybVkxbjMzMjJBWWU2UnNCeERjeUNjcGUzRk1BRGpJTnp6SDJw?=
 =?utf-8?B?SlYwb0ovdUdJMG5FdCs4SHp0VDdidkFHK3lZYTlIN1JneVk2R3dTay9TcVAx?=
 =?utf-8?B?YVRUbEVvSXF0VnBZQXRYeC9BNHdzTFRreVNHUDNZeHc1QWxmNllnTm1nQ0da?=
 =?utf-8?B?ZDJJa2FWMXIwUThaS1Q4WmVjRG5xUWxuYnV1dVh1cHFnM2RJUCtRYTA0amp1?=
 =?utf-8?B?U1Zzdms4UEt5U3hvNjkyR2JDK3UrVDN1czdCYXNwSDVYaVpqTjMyYWtSYWkr?=
 =?utf-8?Q?KC1HY1/tP9IHYNF1Cn/ZoulZkxuCM3oy?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXpMMlJyMHBxR2JpaitqYXJqWFozazI3NmNoUzF5YVU1eTE5eEZiSEQ2RmRL?=
 =?utf-8?B?b1NyTkUwYUtwTUpaQTlLR0FPVjBIamExc0pMeHlQVDdTNXRWaTJ3a2FzZTQ0?=
 =?utf-8?B?dGN6QlFRQXJ5VTBIMzZRb2hOWi81YmxUYmt3L2xtU2orV0FHc2hWL2xFVDIx?=
 =?utf-8?B?RWVSSExLZmFHdVNaN0MxOEQ3NDc5dExXUDBmdUcwYnZtbC9yQkVoYmJhQ2Zz?=
 =?utf-8?B?a0dlK1R4SW0wZThUblZNNWRTMDk1T01VQUErS0V0NW4yZjRnT2l4Uy8vT1h5?=
 =?utf-8?B?NFFqRjVEZUhnWmh4MkowZS9tdG1GTkRKbUI1WjNJWnFaaU02NnhQZjRXZGhr?=
 =?utf-8?B?Nm9WQmswYlF5b3EvQllxNkFwTHpLMG0wa0wwM3JMOWhHUGI1Y3NIYkx3UlBJ?=
 =?utf-8?B?NmNMcmQxdFFwV3hWWXJ6WHFPaCtIeDh2ZVNncXppa2c5Mk93MDNVMEFKL2dX?=
 =?utf-8?B?M2xSM0JmQ3RuVXRYalRDeEExK1NVVm13V2kzYkxEbEtrbTV1Wk9HellCcnRM?=
 =?utf-8?B?am1MaytsTSs1QThkTTl3R2g1MmNLTHZqNXlzYjVkK1B5MWh2cVd5cVFjbHdO?=
 =?utf-8?B?c1IrQUdNa1RYaVEydTVneE9URlFqUTlIRU1rZDM1NzJsNkxBUFdsU3Z6OUx0?=
 =?utf-8?B?M3lSVmxMMUtwRU96ejBRSXdFNmhqMFVFRU8xWERjcjdCUFZNNVBWdEhGajcv?=
 =?utf-8?B?UUZ4MGRncFd0UlhrakdqSzdGd2pUUWJteFBrZUZaQkR3dzBhN0RycDNtYmwy?=
 =?utf-8?B?UUcvK3AyQm1PdXNobjJ4MlduRkdkNmtXalZFaE1jT016SWY1K0dhaU9OTXdT?=
 =?utf-8?B?VHI3ZThtYVdOWTVyc3RJMnZqQlM2dUg4VFpBb2RwNWt1QkFvNjJCbjhQblhm?=
 =?utf-8?B?L0k1YnA1TEErZmJnc2JJUnJiY1pUNEFrSWpaQVcvMGxkQTkvdEZRZEhRNTRa?=
 =?utf-8?B?dGJNNEpPVHoyZGVuREpPZ2orZWtVZ2hLL0VZbW5FNnpkNzZ0NURQaXBlZSs0?=
 =?utf-8?B?N1JvWHVteDludkt5aDA2ckhLdi9QbTBWVU5aZDVLcTh5Nmx0ODRKT1R6OGhO?=
 =?utf-8?B?RnNXWG90dEtKMXRHYjJzVTdQNjl4VTAxRnFjMWFVaWZkZzJ3UTlWVndtMSto?=
 =?utf-8?B?WXVuSldNcHZqSlFCQi84NzMrbkF2MmNna3RBSEhxVWRUNUZyZEM3U3dEL3kv?=
 =?utf-8?B?SEpGV01Qb1NPbDFoVW9uSzk1VjhOOEJDYnVSdlFwSjhhR3ZHeDhjMHdkU3dD?=
 =?utf-8?B?ZXgzTlRLZk0vZ29pM0ZmbFdSaTVEcVlNakRXZHJOdER0dmpuY0RQYkJ6QVFl?=
 =?utf-8?B?bGpHMDVhNkxwTVQzcWg2bkl1QlF1UytOdVpIOVNjdW5FaUExSm1mWHJ2V3p0?=
 =?utf-8?B?L21YZ3VIM3pJdHh2ZmpmYnlXNWhyOFlWaUVTVmU1TURTK1BpU2VFQmp0czR6?=
 =?utf-8?B?K3NtWGp1enVwVVlyL3Z6c2l3cjM1NDM2ZUVqVU9mRnFvcmtGUzVSd2RNZjh1?=
 =?utf-8?B?Z2o2emFqSWQ2VGlSZUVYNUxDaFBoOTlKUStORngyR2RzWU96SVZ0M3kvSnpm?=
 =?utf-8?B?Nlc5NlFOQnlRVW5mMm4welROVHcrSno4NlBxNjBVNTY5TWhmeXd2aUY5RlBu?=
 =?utf-8?B?MFFYVVhWYjhTZlhTM1NHR2U4dmdYcWhUajdmRjZtOG5FUXVYQ2lXdjFHZ0xj?=
 =?utf-8?B?RVZOTkhxdHoxVmVqYzJHbmdpaDFXWkVPOUlvZ0NDOXRQN3I5K1VKdHRDbllR?=
 =?utf-8?B?OXZGcnRGZEcwLzE5WitqOUp2NXN2bWlkeTdlckR6amVHTXZ5Slh2Wi9VR1Rs?=
 =?utf-8?B?dThLQzRCdnNid3htY1VnSXdadFV6bkhzL21SeHBGRXlBK1hoTzdFNU5sQ2t2?=
 =?utf-8?B?cXpXb0E2RlJaalBId2R4bmY1VW15YVNjVFVDdE4zejJ3STdTdi9CSkl1OFU1?=
 =?utf-8?B?RGFPOEN2aGZ0WDBYM0RUL1lNdkNoTWRVMUpWT1VONzYyNVRBYjRWZXlnK29G?=
 =?utf-8?B?QjhmZFhSclpCM1Fpc0YxQUZXL2lJY1hVbkFUUVpMS0tjcXlaTXhyRkdjTnZQ?=
 =?utf-8?B?YWIzNDJuYWJxTWt0VkwvbHBPQjhHRW9mZ3NmUWt6QnJIZTVodkxzMklVQUZu?=
 =?utf-8?Q?nMQlVqpvRsyW8B9B7N/amWU1P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc72c90-9cc9-4f60-3a74-08de16243791
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 13:16:34.2613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0DJEc+pxm793n1OpeNSRK4cjMr9SjoczGy66nm47J3rER5r8Ly+r2Lw9OcK+iLH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9559
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



On 10/8/2025 7:02 PM, will.aitken@amd.com wrote:
> From: Will Aitken <wiaitken@amd.com>
> 
> amdgpu_xgmi_fill_topology_info and psp_xgmi_reflect_topology_info
> perform the same logic of copying topology info of one node to every
> other node in the hive. Instead of having two functions that purport to
> do the same thing, this refactoring moves the logic of the fill function
> to the reflect function and adds reflecting port number info as well for
> complete functionality.
> 
> Signed-off-by: Will Aitken <wiaitken@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 19 ++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 27 ------------------------
>   2 files changed, 14 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 6208a49c9f23..82500ade240d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -1539,6 +1539,7 @@ static void psp_xgmi_reflect_topology_info(struct psp_context *psp,
>   	uint64_t src_node_id = psp->adev->gmc.xgmi.node_id;
>   	uint64_t dst_node_id = node_info.node_id;
>   	uint8_t dst_num_hops = node_info.num_hops;
> +	uint8_t dst_is_sharing_enabled = node_info.is_sharing_enabled;
>   	uint8_t dst_num_links = node_info.num_links;
>   
>   	hive = amdgpu_get_xgmi_hive(psp->adev);
> @@ -1558,13 +1559,20 @@ static void psp_xgmi_reflect_topology_info(struct psp_context *psp,
>   				continue;
>   
>   			mirror_top_info->nodes[j].num_hops = dst_num_hops;
> -			/*
> -			 * prevent 0 num_links value re-reflection since reflection
> +			mirror_top_info->nodes[j].is_sharing_enabled = dst_is_sharing_enabled;
> +			/* prevent 0 num_links value re-reflection since reflection
>   			 * criteria is based on num_hops (direct or indirect).
> -			 *
>   			 */
> -			if (dst_num_links)
> +			if (dst_num_links) {

Patches look fine. One clarification - do you need to fill this 
information if sharing is disabled?

Thanks,
Lijo

>   				mirror_top_info->nodes[j].num_links = dst_num_links;
> +				/* swap src and dst due to frame of reference */
> +				for (int k = 0; k < dst_num_links; k++) {
> +					mirror_top_info->nodes[j].port_num[k].src_xgmi_port_num =
> +						node_info.port_num[k].dst_xgmi_port_num;
> +					mirror_top_info->nodes[j].port_num[k].dst_xgmi_port_num =
> +						node_info.port_num[k].src_xgmi_port_num;
> +				}
> +			}
>   
>   			break;
>   		}
> @@ -1639,7 +1647,8 @@ int psp_xgmi_get_topology_info(struct psp_context *psp,
>   			amdgpu_ip_version(psp->adev, MP0_HWIP, 0) ==
>   				IP_VERSION(13, 0, 6) ||
>   			amdgpu_ip_version(psp->adev, MP0_HWIP, 0) ==
> -				IP_VERSION(13, 0, 14);
> +				IP_VERSION(13, 0, 14) ||
> +			amdgpu_sriov_vf(psp->adev);
>   		bool ta_port_num_support = amdgpu_sriov_vf(psp->adev) ? 0 :
>   				psp->xgmi_context.xgmi_ta_caps & EXTEND_PEER_LINK_INFO_CMD_FLAG;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 1ede308a7c67..2e70b84a8c3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -958,28 +958,6 @@ static int amdgpu_xgmi_initialize_hive_get_data_partition(struct amdgpu_hive_inf
>   	return 0;
>   }
>   
> -static void amdgpu_xgmi_fill_topology_info(struct amdgpu_device *adev,
> -	struct amdgpu_device *peer_adev)
> -{
> -	struct psp_xgmi_topology_info *top_info = &adev->psp.xgmi_context.top_info;
> -	struct psp_xgmi_topology_info *peer_info = &peer_adev->psp.xgmi_context.top_info;
> -
> -	for (int i = 0; i < peer_info->num_nodes; i++) {
> -		if (peer_info->nodes[i].node_id == adev->gmc.xgmi.node_id) {
> -			for (int j = 0; j < top_info->num_nodes; j++) {
> -				if (top_info->nodes[j].node_id == peer_adev->gmc.xgmi.node_id) {
> -					peer_info->nodes[i].num_hops = top_info->nodes[j].num_hops;
> -					peer_info->nodes[i].is_sharing_enabled =
> -							top_info->nodes[j].is_sharing_enabled;
> -					peer_info->nodes[i].num_links =
> -							top_info->nodes[j].num_links;
> -					return;
> -				}
> -			}
> -		}
> -	}
> -}
> -
>   int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>   {
>   	struct psp_xgmi_topology_info *top_info;
> @@ -1065,11 +1043,6 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
>   				/* To do: continue with some node failed or disable the whole hive*/
>   				goto exit_unlock;
>   			}
> -
> -			/* fill the topology info for peers instead of getting from PSP */
> -			list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
> -				amdgpu_xgmi_fill_topology_info(adev, tmp_adev);
> -			}
>   		} else {
>   			/* get latest topology info for each device from psp */
>   			list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {


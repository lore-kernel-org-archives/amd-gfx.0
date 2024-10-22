Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC81D2C550
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 13:25:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFA2E10E1FB;
	Tue, 22 Oct 2024 13:25:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eLqoZuGq";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA04E10E1FB
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 13:25:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TTcqIFJFgvNdyKb5E7dgnLu4eiI7ngqnti+fNW/NNB/AhNKMlmNCK3FzY7xih7foSiREUOoBNa+J2PsGGut2SCmqV7J0zzEUE6iDeRyFFUIE3sb/zzN8usxDTSmvpkqlCJuokakI/B/xh57kAld2PDW11nXUqJ6TxoovjDDODU8ue0jiQA5TtAOIaXDvZcVVH+6mUSebY6t9+QNRtbhla+E7hJ/g/bYwLTx7u2KdQQy8aa5/RWUsbWW/a1zRtC+hx4KYWSisX/fxI0a0udjFdCuzVa4xGxHU+zsy5joA5NZzbJVvmqCEqfqsnF4JWnRIp/UVN9ea4X9FDuh8b3KWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLKGP7zIlg528ADN6uRkc3BAvo7NOg11tb4VRNaelb8=;
 b=NnFwQQCN6WG/Y/r2DlcipDgPV7X/fLZWSlKu2ox1COCljTUVKtpm8k/0Z0NKKmcAKyKEtbN/3aaL+sgZecrQ0OAYikQVjMF66dkFPhMxZEciBn14MRhUCnEcMr45eHLPZgFZuoS/pV3/jR6V5b3iLMu62tLAkpfOEvygpG/qb3D0AkZ8dIB7aN+kP7lOsNn/ugf9qENgM7dSDcyIEZzOdbzhDa3Z15msapIH3RxNjj2L3yZaVO/7y5csBHAEf/wVhsnnVlF+nE6jcNMHZN3ojl/SVkew0k5EqfYheqpC86Qa0HrS1w+WBsbKf6TQfQlTI8PJQ3CmSq5dxVZuoMh6VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLKGP7zIlg528ADN6uRkc3BAvo7NOg11tb4VRNaelb8=;
 b=eLqoZuGq/Mfi6WSKP+dvPZwTDFH8TF3QWpgA4LEnj8sTtS1lt/4IxA1HZu6s42A2RK2JHs9z/pRBHnZN2GwLhbCNWRl1uvkqXrFvEy/9UClXGV3fMAX1BF4fufBuljxYMFH2ksm5Adc2he3PdpWpAVkryC2Z3XUKuok9xgEgqi4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH7PR12MB9102.namprd12.prod.outlook.com (2603:10b6:510:2f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 13:25:31 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 13:25:31 +0000
Message-ID: <a9d81328-3de5-4b12-9d9d-6ea3353e4bdb@amd.com>
Date: Tue, 22 Oct 2024 18:55:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix the logic for NPS request failure
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com,
 rajneesh.bhardwaj@amd.com, Ramesh.Errabolu@amd.com
References: <20241018063533.3082692-1-lijo.lazar@amd.com>
Content-Language: en-US
In-Reply-To: <20241018063533.3082692-1-lijo.lazar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|PH7PR12MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f30119-dfef-4f5e-6957-08dcf29d00a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L051NnFZdHhOV1ZFaTAza1hyRHprZ1RXY0ZOTkVvY3JzZ0p4TDBLenFQWGlI?=
 =?utf-8?B?amY2QkphMkZsUHMvVnFnL1RPRU45ZUdPRmpqcjNJLzhBWWhGUHFOT01TK3lq?=
 =?utf-8?B?VVVhNytKbEVHSSt3K0s2Z2RtL2xib3NWV1ErRmlMa3kwbU1leDRUaG01MVAr?=
 =?utf-8?B?OVVNNlRNMkNiNGpCQ2xHSjFramdtejluRmlubldJS3RqZERocWpXTUVZY285?=
 =?utf-8?B?amRmLzl0NzhzU1QxemZPWDh3U2hKWlJnamdnWW9NZlZBclBqS1ZWVElXbmdR?=
 =?utf-8?B?TGh2U1BkS1NqZ3h0dit6ZG0wOXRJQTlJOHYwMVpWRmdvd2xpN0RSQm1uZHB1?=
 =?utf-8?B?RHM1ZW9vZGpoU3JOaU5WdjloN0QyOG5ybERmRzdUeUZpNHp6R1FzZDRZNDdr?=
 =?utf-8?B?YnJrSFF4UWlGZGM2RjRkTDgzcnBEUmhmd1o5a245UlRxNVNNYlFIWWhRK3Jn?=
 =?utf-8?B?bjV2MmxpMWNqOEFrWEIwcFhwYmpvTkVPa0x5VE1FNm5uVStVWlYvYWlZSDhB?=
 =?utf-8?B?bW9hWkRCQ2pXYUxLeFdYMW93QU5Qb2x0dlNxaERUckJDR0poaXU5YmcwSjRG?=
 =?utf-8?B?dlBDYmRqUjVPTlNjeXAwVy9TRXlqT3ZoV2RCZThONER0aXltNElMSXFiVWpF?=
 =?utf-8?B?UzVoS08xc2ZxNVhReUVRNmNJY2lLcVg2ZnFGMmF1RHZtQUtPWWszQmg1aWNy?=
 =?utf-8?B?OU03dXBpWWlFeTdkZy8wVndiV20wUFdzWmJQK1J6L1RrK3ZHaVpaNTRRckpX?=
 =?utf-8?B?UnpFT2VncFhqS3ZCVHp4WE5oQVdhQlZyYWRYVWZVTmhWMkk2aS8wcUw0NDQ2?=
 =?utf-8?B?UU1oREJkNnYzblNTWko2VkJOOU45UVFocm9xRzlFU1ZTeDhyeC9vTTNGa3Rq?=
 =?utf-8?B?YVdoSmRkNXR4cXA4TlFPdUpCcG9QWHVqbTZJM0UwUHJGNzBFc1dZVWsyTlFU?=
 =?utf-8?B?ZUY1NzFkSE9aaElPc21SNC9mY3kyckdyOEw2bm1aNDVyamVvZzJEWkkzMW5E?=
 =?utf-8?B?NWg0KzlXWk5nZGNJbkx0QlpVaXFuaVNvTEFSNFlMK0FJV0RDRldYczNwUmNP?=
 =?utf-8?B?T3NNbDdRU2x3Y21DOWJWNi8wVEFZcjhSTnVDTGdweWxFbGRMWE1ydHZLQzBH?=
 =?utf-8?B?K3Y1Qm85eFV2VkhGdGlFU0tSTHZkV29KOGJXbWhWSTlsQ0FhZHhxbGhMOUtj?=
 =?utf-8?B?TVlHdEZVaU5vZkc2dEdwZ0RXMC9penlodlNwWTdCUWloU29PVW91SnRMU3dh?=
 =?utf-8?B?Ty8weFZTQWp6Sm8wZG9DcENzazhOVEpaaWpna2ZQRVkrcUxCU3M5SDZXejF0?=
 =?utf-8?B?RVBaVWhGMGlKalM0YjdRMG9CSldUVXpHMzhtL0oyVVFJMm9pZzkxMXd4SlBH?=
 =?utf-8?B?Q1BHSUYxd3l4ejlNRzhEMS82bkNjNXVBMHpseHJVV0Z5WnhIUmY3MGZ3YW84?=
 =?utf-8?B?b0ZPdmQ5QnJYZVZFQnI3VjhBaEJHa21PY1dnSkhFZ1lBMUw0R25sSUlFaVYz?=
 =?utf-8?B?VWREMWMzMzR0WkYyN1BacTdlejZsNVZEM1luN0NRaC94Z2VGOXJJeWVVMUdt?=
 =?utf-8?B?MFJDd0haaU1BTlYrMUYwb2gvUmp6ZnRHVVN6OEJnZVFUYmdwSE1GR1pwZ3Mv?=
 =?utf-8?B?Q0VYOVozcjRTR2ZWbEtURE9TN2pjZUtyWkNBSzdYamh0VFJaN1FqdHhyODda?=
 =?utf-8?B?bnhYSzBpVVB4N2N2bFhGZk54Znc0UlRPU282UytKRlhnU2FTcFNoWmZvQXFT?=
 =?utf-8?Q?m32L0hETfsoU19qNWI516+jZmDPn/kCpvhR5yD0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm1lN0NnKzhvdkhRaFJtRG9tQTViL2JzbjF3TzN2SkFhL1RncFRCc1duWmtn?=
 =?utf-8?B?K214Ly9Wbzh2YjBoMlRmY2xjTHhwalhaejd5b1NBWUswQTIxMlp2YWNlZEV1?=
 =?utf-8?B?VFJxS0dSZWQ2aDl0eEhUOFRJRG0yUUxzd3duYW4rR2pLd2lYWVJ2eHk4a2xz?=
 =?utf-8?B?QW1kMGRrNVAwb2VkTGpIM1AxZHFrTFA2SlRZZzdIbTl6RkxnL2MrTnVqUHM4?=
 =?utf-8?B?SzFzTWhKOHJuWndaZTRnbTlmejY5b3lYdVY3UVlEdHpENklRajQ0ejZ0Tkd1?=
 =?utf-8?B?WmR0WXoxNGo2SWFQUjZQM3dLMWNpYTdPQmRVWXJ0cWI4UTE2dmhwZXJ4Sm9M?=
 =?utf-8?B?U3lTYVJha0ZzTnZla3ZnZ0xRYXRia3VsOUxqVzlQTHppall5enJPZk02bzRz?=
 =?utf-8?B?WjdmWDJlMzVjdkRVZjhYWFJCeXVCMUtjSndmOTBHUzVSQ0Q2UzdYTXkrZ0ZV?=
 =?utf-8?B?RkY4d3NWUXBxNGVLa2ZsZExsVlBDMzVGNUwzSDVwQkJaNVlTWmxUVk5qYUp2?=
 =?utf-8?B?UkVUNU9TVTM0NTRBUEVWanhoRlFCb0NqeFMwUGM4QnVxZEVIbzhKWnpOUDNH?=
 =?utf-8?B?ajZBbHd3aHlqeC9lYitSWUpLcjNqeXYzYlJWY0t5Z1owQklRbkRNR2w1Zzl5?=
 =?utf-8?B?eHp6K0x3TDJBSWh4clNBWjA4N3ZleXF1bmFZUlVTS3Y5dFRZb3ZObkJJYktl?=
 =?utf-8?B?cmluSC9UWTk2WnBLOXFGckVPWG1pN0xScy9DVjVQOEhwNFBoM0ZmUjhRYzhW?=
 =?utf-8?B?bVFBVnVSb28yYzRFNW1OY2FwcCtLcFBtUnF0SjZ2b284TGU2YkJkelJsZ1Z6?=
 =?utf-8?B?Nzc0R1hDdlhLSlgrSkFKNTVDWVp3YUVBZEE4N0I0cVBmQWszL0pVTDVhY2FE?=
 =?utf-8?B?ZXhKSTRvYzBWWEhqcjF4MEdHcnhBT055enFRTXM4RXlwTzdKek5RMnJjMDE1?=
 =?utf-8?B?bnNIdURqWkJsOGFweTFSazFTSEU5c0ViY2kxczUxRUE0UEhMYUgyYW9zY1c3?=
 =?utf-8?B?K1B2TldFVzFjMCsvRHViMTlQTUNYNnVIaGdoVkF6cnhqajRIQXFUVFdwZng0?=
 =?utf-8?B?RGU1QmdrM3pycUNqbmQvalZKc0lWaVlQdVZUb1FieFdMVUdnVkpSTjlhaSt1?=
 =?utf-8?B?WEp3UkVBRXpDbWJOQXZseGQ3WVMrUE8yOTJublZiNjg1MDZmNnFaK2JIQUd6?=
 =?utf-8?B?QUNDckpLeE80cFFYQS9BQ0NuN0J1SmEvYVE2WjlxN2YvQVhMYWNNV1VHSG54?=
 =?utf-8?B?Q21DdFN3MUxDelYxbkpTeE5qOHVwWDVva0V2RGp2N2k5ODJVd0VQNWgxeDVh?=
 =?utf-8?B?L1RlQ1JGcXdSYkZ3czlNSDhhM1o2aVFnMkJuNjk5ckZvQjcxUnpHNHhIUnAr?=
 =?utf-8?B?ZHpBVGRGNnRQSWNaMUd4YTU4aVMxcm41Y0VBblgzVlVvNGJZWklNWElUQVZZ?=
 =?utf-8?B?ZDZRTzEyTTZWdnV1eXVlcVJNTjBkclFBK2hHTDZIYXVxYnNmaXVJQ29OV1pp?=
 =?utf-8?B?dmZUakR6amJWY2xyWlJhNENxVThWcHgrSkRYcmVFR1JWNVlQYVkvU2xhMDd5?=
 =?utf-8?B?REY4NHJLeEp0aFRwMExpeW9zUjE3WWF2eTZVc3ZZbUt5NXkveHE1SnBNeThG?=
 =?utf-8?B?U2JSQWVTVVB3dUlVeG9yZm5DMFh4cWJyaTR5NWZTK2ZHMkpOR2RidUFRS3RV?=
 =?utf-8?B?RkNNcHkwSkxjeUxUK2NnczdBK0l0V2ZTMmhVN1M0dGhWS3dIYzZoMlpSR3Rp?=
 =?utf-8?B?dm5CczhGcXZNQXZZRVQ1QkxDZ1lvYnhKL0VEQlpGSnhrYm85ek1CVTFxVEIw?=
 =?utf-8?B?ZHZJNDBlb0F4U0VjWlJyZ3A2Y1d2bTRFNTB6THNHbXRBbk02V2RzZGU0NHFP?=
 =?utf-8?B?YnByR2x0ZDVhbW55R0xXdnI4dE9KUnF4RnN0OXNGMnUvL1VDMnM5MmNMMkt5?=
 =?utf-8?B?bzBIRTZrbFQrQ3JzMTVDeThHQ29BTUpvQXZUVy8wZGhrTi9DSnRVNnBXL0ps?=
 =?utf-8?B?VnlPQ2Uza0FERHFFRm8zcG1CZkNLSzV0dm0zZmNrcm1GWFM0azdOaS8rdi8r?=
 =?utf-8?B?ZythcW1sZi9kVVVjTGx1ZmdxU1p0Yk1aZGhDRTFMZ3h3eEpDTExoTEFMNUR6?=
 =?utf-8?Q?EpsaHZWQH8tM3QDI7XzVxyZ5F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f30119-dfef-4f5e-6957-08dcf29d00a2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 13:25:31.8313 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+Ili8Y3zckTDRhGhHCv5zdI+QwRaS7AFE8x9sDMNwziFvR+atInwuH5vGt2OGzx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9102
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

<ping>

On 10/18/2024 12:05 PM, Lijo Lazar wrote:
> On a hive, NPS request is placed by the first one for all devices in the
> hive. If the request fails, mark the mode as UNKNOWN so that subsequent
> devices on unload don't request it. Also, fix the mutex double lock
> issue in error condition, should have been mutex_unlock.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Reviewed-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> 
> Fixes: 44d5206ec07c ("drm/amdgpu: Place NPS mode request on unload")
> ---
> v2: Add a debug log for debug purpose (Rajneesh)
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 28 ++++++++++++++----------
>  1 file changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index fcdbcff57632..3ef5066ca529 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -1586,26 +1586,30 @@ int amdgpu_xgmi_request_nps_change(struct amdgpu_device *adev,
>  	 * devices don't request anymore.
>  	 */
>  	mutex_lock(&hive->hive_lock);
> +	if (atomic_read(&hive->requested_nps_mode) ==
> +	    UNKNOWN_MEMORY_PARTITION_MODE) {
> +		dev_dbg(adev->dev, "Unexpected entry for hive NPS change");
> +		mutex_unlock(&hive->hive_lock);
> +		return 0;
> +	}
>  	list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
>  		r = adev->gmc.gmc_funcs->request_mem_partition_mode(
>  			tmp_adev, req_nps_mode);
>  		if (r)
> -			goto err;
> +			break;
> +	}
> +	if (r) {
> +		/* Request back current mode if one of the requests failed */
> +		cur_nps_mode =
> +			adev->gmc.gmc_funcs->query_mem_partition_mode(tmp_adev);
> +		list_for_each_entry_continue_reverse(
> +			tmp_adev, &hive->device_list, gmc.xgmi.head)
> +			adev->gmc.gmc_funcs->request_mem_partition_mode(
> +				tmp_adev, cur_nps_mode);
>  	}
>  	/* Set to UNKNOWN so that other devices don't request anymore */
>  	atomic_set(&hive->requested_nps_mode, UNKNOWN_MEMORY_PARTITION_MODE);
> -
>  	mutex_unlock(&hive->hive_lock);
>  
> -	return 0;
> -err:
> -	/* Request back current mode if one of the requests failed */
> -	cur_nps_mode = adev->gmc.gmc_funcs->query_mem_partition_mode(tmp_adev);
> -	list_for_each_entry_continue_reverse(tmp_adev, &hive->device_list,
> -					     gmc.xgmi.head)
> -		adev->gmc.gmc_funcs->request_mem_partition_mode(tmp_adev,
> -								cur_nps_mode);
> -	mutex_lock(&hive->hive_lock);
> -
>  	return r;
>  }

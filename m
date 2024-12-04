Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09822E7716F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 23:36:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B586910ED7F;
	Wed,  4 Dec 2024 23:36:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3N+aMxZF";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ACF510ED7F
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 23:36:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9tr8lHv+m/r1YtKTPRuqSsfCAKGtPPVGxkXbnn3DdO0Pt3Y6qnq4ndxPEbFxtd4pRqjU8MuobUnigqxJnvnau+mMBPIL7UB0ho/7Dx/lAGV/1zt4KvCzmRs6OSJMlmPffpMCHMDrEgy8F0yiy5a1V/IYIbODu/4f6cOPyILAtqQOOetZPtFI9JtS3+W2vfRG6BLZi+JwMFt0moCnp5Zcv9uSEwKVLUpFZ01wteCATpNJrKAfQSWATxFaHljf/K2e63JBvEQGmxES6UXFBuWPyvBn01VzB1yL50Oo8bUbB/Tjm4sbseEqVygQTNA7PFOudgNg9fVGuyrxz1nFTDWtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6gqjmKs6LUlYUU9qqbqXVSYtEuRD/LmEV63UaqtZMY=;
 b=b3SZ5vdmIJQiRDE4G1XHBgjc3ekuCFuXOI8Q5ulTw+PeooEuVVqXw5fa4gXzqsY068BN1gvoJr7PVk2bNWbnXW3iUDSOZcDeCk4JETMMe9DN/wCqFeJ2P8fsgVVYNnHYSN6LSpocpV3Dqn4rfrjRKdFU0A49LLAqyzCb/ujnVXcDBjAxbR6F+JACILVm/dp5yvul5WVFe++Exqca4tll+8sdWGbHKxihiosi0CHPiCk7cpwyQLU/JHx0HcMqimr9HdAhgOQAux8b8DU6zo3zbH+nLjYEbnXhWfpVSy5Y0L9wmLZDZVvwnP6zNn+X9sXv5Jz7b3QBFzD+vQJPkV3xiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6gqjmKs6LUlYUU9qqbqXVSYtEuRD/LmEV63UaqtZMY=;
 b=3N+aMxZFBwue8sEeX7yA4S/AeYcC5EAyTBYLQY0rlbCkXbTsWR/Q8wi4V5nodSGlGB5FB9MKY24WvxICviJDvVbxa7wyiJw8SRlDP0prRer5YS+59oiN1Q544CnRNxbEg37pSX4Xedf4IVklqCehcUtlbuu+zFJPVThbPeskSbU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB5829.namprd12.prod.outlook.com (2603:10b6:510:1d4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 23:36:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%6]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 23:36:30 +0000
Message-ID: <b02ef955-f510-4067-a577-276b3882cd39@amd.com>
Date: Wed, 4 Dec 2024 18:36:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/amdkfd: pause autosuspend when creating pdd
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, mukul.joshi@amd.com
Cc: Alexander.Deucher@amd.com
References: <20241203143046.3643-1-Yunxiang.Li@amd.com>
 <20241203143046.3643-2-Yunxiang.Li@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20241203143046.3643-2-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0293.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dc7c46d-b1fe-4dae-2b40-08dd14bc7ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXlHZ0VqWFRIQTJyMlN3UzhFOTFzZ1BVeXE5MnNhc2FuYmdoQ2Fwd3pjZWVa?=
 =?utf-8?B?VHVZeTVFd0VDd2tNUkZydC9XL3J5MGJyS3gwMWF4OHBabEdBaU9oZDhpTHl6?=
 =?utf-8?B?dTVXVENMU3Bxak1HK0lZd09ZalZYcjdrS1kwNkFWSkV4aE5ydHVUQmtLNU9V?=
 =?utf-8?B?cFBCMVJzc0Rub0gzRVl2U0lCM29QSDFhVHhaVWVnNDhIR09xQWRETmN6cktH?=
 =?utf-8?B?M29kZDBHb0puczFhd2gzTkF2bVlybDhQclVucXFOOHgyZjhBdE1DRTdlNkpz?=
 =?utf-8?B?TFdxanVMNklHakpFQUF0bFhzSjFYVTA5MUxoeEdQUjhFdGhBSjU2cXMyOFFo?=
 =?utf-8?B?U1lCc2xrdkdDNnF0T1cyRkVLQldVdUszZFVWRytpcHo2ajg1d2dUKzVRSUMw?=
 =?utf-8?B?WVgyK25vU3FFeXR2WHBhQS9FU2QyWlhxSFRZd0tNejBMdmJGa2tRakIxd3B2?=
 =?utf-8?B?NkY4TTVIQStLNTRyU3FRRzhUVWhsaWRDWWt3TUo5SGFheFVGb3VnYkoyZUFw?=
 =?utf-8?B?N3p0b0VBV0JsVURZOS9sMkp2WTkyaldHbEVtWk1Ta1RvOVFrOVZrZ1N6T2c5?=
 =?utf-8?B?dmErUzMxQUlRVTNRSFJ0cXczcjhMdSswUVVXcGJkcWduOFVva3BrdHl5YXo2?=
 =?utf-8?B?d0VaVHhlalFXOWRPV2diRmZReXcvUEhQejZ2SHBqZmRaaCtRZVhkdWpFNlpK?=
 =?utf-8?B?dFE2QmRHTUdwWFdYajFyeUE3dWpiOHFNa25NYTVTKy9mVVZ6cmE1d2ZISGpy?=
 =?utf-8?B?QXdaZjFUY05BZ3IraFpQeDNJV2pRbkN3OE5oUFpUTVo5TWpQdlY4LzVBdTVP?=
 =?utf-8?B?UW9JMWlJNzl2cUFadTFkYWJSVDR1TmxoUDF5NndVWjI5YVBlTE9kallqS1N4?=
 =?utf-8?B?dFpVRFVUMVJxVDE1aFBLTXBmWnpQME1zcFZRTnhWWXFQVU1Xdzc5K2NjSVBa?=
 =?utf-8?B?a1IrekdjN2tpdlBhSDdHWTJzWGxvSmpVd2J6dXFRTTNPQU9NbzJQeTJQcGFJ?=
 =?utf-8?B?a2NNOHlJQ2RFRmJtR1lCclh5dTFMTWJxeTczSEVCREx1UUhUWmk1YlUxVFdi?=
 =?utf-8?B?ak9vYjk4Y2xaQkNleVdTQlVSbThVWFJsT0VUWUxXaE85YjR2aFBqUHdVaGlM?=
 =?utf-8?B?cWY2Ymh1akF5Y1hSL1d6RWExdkxSV09PUjVBdXBUQmN2NmpvbTlJeHgycStD?=
 =?utf-8?B?VzNhZXZWcWs3YmhzN092YnJIY1ZTeHpQQ3ZzY0dpUThkOVp4dENHK29aRkg2?=
 =?utf-8?B?bWgybEY5M0lGK2pzUy8yb2xxVG0ra1ZjVWVtb050c3E5MEJlb0hTdlNJNEM2?=
 =?utf-8?B?TUx0WnQ3ZXB6N085ZXhobThIZTI3REhMd0NaOXBuVmpLc3UzS0FBU1VxQVdx?=
 =?utf-8?B?c3BDbTVQdEhmSDU3ZmRkNmIvOFFxeFdvc2xOTC9BTUlpU0pBa0pQYVQ1ekY4?=
 =?utf-8?B?Y1l5alBXQkp2L3NDQmNHczZFTUVaK3RlY1lpdERlYlphR2FvQXdSM0txeDQ4?=
 =?utf-8?B?Ty9VRmY0MVo0L0FYcmExenBSeEJVdDIyT1BhOG5KUDhMNkNXYVZMR0k5MlM4?=
 =?utf-8?B?N25yUThKajh4aGtTNGV4bXhvOTcyenFEeGh1M09jSE84QXdNOWdoUlJKVkpz?=
 =?utf-8?B?R1J4bFlxK3NYaTVvd2FkemVVaHJFb1BGMmwrK29VODdkcXhLVlAvU0h5RE54?=
 =?utf-8?B?OUp5T0hTZVNsUkNLazlyZlBHdk14TWUyUzVmMFJheEgwL21vNVp4ak1UNUlu?=
 =?utf-8?B?bEFmOXBPRkZKNi9oSnN4d2sxbzRzUU1HSUdjOGJKb2tlTTAxTzUzOGRUa2pQ?=
 =?utf-8?B?TFA5cnl6NjdyZHp6dndFZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEpTSXF1SS9QeG8ycUQwUC9TMUZlM2xvbUYvT2lxcllreXlCUS9QVHdNckRj?=
 =?utf-8?B?YUlDS1BlZGl4dVc3QnRiS25kcjQxbjk3bjkxSTU3OHovRGp1T1lEejdwZkJr?=
 =?utf-8?B?bG1mNjNFTUQyRHQ3M1FXM2lTLzdsVTZkdVRIN09WTFl2QUxNQnJ3YW5JVTZ1?=
 =?utf-8?B?YlJGNmhna1ZXUXBmektwekdNdXI5bnJiL0IzbE9zVWhBOTkwZmhnSHdKWENQ?=
 =?utf-8?B?cnl2cWNKbXI0UlpmbUM4dFdDeDF2QkIra1BQQVd1WjNIODNXUnVzOGVPcWhB?=
 =?utf-8?B?TzJneEJwOElEdmRpamFoL1NWa0t5cnVhQVJ3VkUzbWhFVi8wTitySys2S0RM?=
 =?utf-8?B?THVJMjhkaVBCRzlaVXRRWHlYRnlDdEZsaHpVMlRxRDdXL3hHL3VhdUlUQmtW?=
 =?utf-8?B?SFRueVhNL1ZFRXNwLytrQ1JXWEMwY01rNEJ3MDh0WTA5Y2hPYm8vUUEwblcy?=
 =?utf-8?B?cmxqb0dxS0E2UHF2Tk4rb1lFalQ3STc2VHRvUzM3aEtKWXFlZFpJNjBXSVp3?=
 =?utf-8?B?cE1lRGdRU2IyNGd2RSt4SXEzRE5ldUxoWmw0Y2s4cDQ1MGw0dnRydnhoWmx3?=
 =?utf-8?B?T0gvOTJSNFR2TUlJcXM1OHgwTisrR1hBTmtxcCtVQ0dmVTJaaGxDVjc3MDZ1?=
 =?utf-8?B?RnY2VjhuS3o1NWJ2alpTaERBL21NQ3g4aG1EUHgvNUJUaEdRcllNejZVWFZG?=
 =?utf-8?B?eFk1NVJlSWFLK01nQ3lUbStjMk0xZjlLNDBzMkJoM0hBcEpCRExlZG5LUW9k?=
 =?utf-8?B?cUFibkY2dEFPMWJnYTRISGFyY1YxdG80aGlwTHhkY3JabGRUcXdUNUhTV2ZB?=
 =?utf-8?B?MitDd1pFdVA3S1QyUEFteXpHbTlXMC9sUHpLZjhhSTArZG1VTXkxYW9LOUs5?=
 =?utf-8?B?aDZyUjdITzd2YXRqK2oyZXVQd2xjRDVWOXUrTVZDU3d5SHlTMGFJeGQycUli?=
 =?utf-8?B?NTZpdldQblBlNWNmeWplZWRmclQ0RzVrNDBQb0RPN28rcE14SXNQQVovdERK?=
 =?utf-8?B?T3N3VWMwVG11R3lveUNyZXY0cjFjNEV1TFlxelVseExLVTErVTJ1WlBWSTh5?=
 =?utf-8?B?d1hoM3dHTi90K08rUDdsQ0Y0cU83NmFrd2o1dnVaaUoyQSt6RDZiYnVyRFlZ?=
 =?utf-8?B?NktHMllKalRFTzRqL21pTWNVWHFGWUY2RitvYUQ5cHd6YTdOcXFVTHdYMjQx?=
 =?utf-8?B?N1hib0NJVjNpQlZ1MElxQjlqWlVNcjhxNGVwaWZhUTRCWmhRTmJTaXZMYTRj?=
 =?utf-8?B?NFplTGNOWUIvMVdOZnNaUkUzdEtmVFVjOExrd2gvYXNFOGVKR3ZiM0lLQkxz?=
 =?utf-8?B?ZjFRMXNaZG5DdlFMS05OdEJtcGh5LzM5dlhZeWVhTnpETTNnbWRUdUpKWE9L?=
 =?utf-8?B?VTJhbDZqaTJUYmxIcEFEa1lOZ3BqZnpmeVpRZmRkZGtYOUxVRkVVRXI0akNK?=
 =?utf-8?B?Q1h2ZmU4MFduV2Y4eHNjMWxFb0p2TTFzNXVrMU1tK2plUW9FaFJIVk12Rzgz?=
 =?utf-8?B?STJjTTd0Z0gxdnJ5c2dYY3FPc29BZHlNMmphQUtjbEV4Z3VyeTFQNzA3dFRO?=
 =?utf-8?B?eUJYWDFUOFJzalR3VXRBanRXaDZqQ2Z2ME1GMlBFMnNDVEFWUG1Sam50WDlW?=
 =?utf-8?B?MFRDVmp0TGwzdVBjbys2SHQ3bnFCTVVqMmVkQUwyc0FQM3BuZXZZNHZ0ZTRW?=
 =?utf-8?B?RFBUV1VQYWdiL0x5Q1U3SnBqTXhuT2Z2Vk1jcUIwcks1RHpleE1wRWdJS3lS?=
 =?utf-8?B?aVpodERHYU5pNFdYdFY3OWl0QXRvYk1HRFU2bjVYc3B4RnR6MjIxUExLRjVz?=
 =?utf-8?B?Mnk5dUhnR21sL2luZkdTWkZWL1V0aEdRYVNtQXRYSThjVGt5cmJ6NUh4REsv?=
 =?utf-8?B?R2dDTFI4MTVJY0RHMERPc1lnSkVWQ2hwa1V1NndYaTFTYXdncGlIa2JZNzZl?=
 =?utf-8?B?MHNvYTd2NjZ1Ny8yNFFreVlSM05lcEZia3M0OWlkaHdveTh3QkExUDJEMldW?=
 =?utf-8?B?eGFnN3llcjMyK1RkdEwzdnZJVFNzcHJxWXlONnFZTGlxemNROXNjK25Sd085?=
 =?utf-8?B?MVljNElEcUFZeXhzRS9mekNtME1QNitTK2JyZFhVelV6bDZxTkhDUnRzRndk?=
 =?utf-8?Q?XGit1suhfi2LncegpIeXfODse?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc7c46d-b1fe-4dae-2b40-08dd14bc7ade
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 23:36:30.5980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6cGcpyZUhgF4a4N7A4nLsaAqf3LzZq71+7XbcL6kBVT5jBpymRmQFJ+kqpwrH9/aLpaFVi+yJGZtt4YHUjp4iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5829
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


On 2024-12-03 09:30, Yunxiang Li wrote:
> When using MES creating a pdd will require talking to the GPU to setup
> the relevant context. The code here forgot to wake up the GPU in case it
> was in suspend, this causes KVM to EFAULT for passthrough GPU for
> example. This issue can be masked if the GPU was woken up by other
> things (e.g. opening the KMS node) first and have not yet gone to sleep.
>
> Fixes: cc009e613de6 ("drm/amdkfd: Add KFD support for soc21 v3")
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> ---
> v3: remove the cleanup in kfd_bind_process_to_device and document why
> this issue doesn't always happen
>
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 555a892fcf963..c81c020af75d1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1635,12 +1635,19 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
>   	atomic64_set(&pdd->evict_duration_counter, 0);
>   
>   	if (dev->kfd->shared_resources.enable_mes) {
> +		retval = pm_runtime_resume_and_get(bdev);
> +		if (retval < 0) {
> +			pr_err("failed to stop autosuspend\n");
> +			goto err_free_pdd;
> +		}
>   		retval = amdgpu_amdkfd_alloc_gtt_mem(adev,
>   						AMDGPU_MES_PROC_CTX_SIZE,
>   						&pdd->proc_ctx_bo,
>   						&pdd->proc_ctx_gpu_addr,
>   						&pdd->proc_ctx_cpu_ptr,
>   						false);

As far as I can see from grepping the code, this BO is never used. It is 
allocated here and freed in kfd_process_destroy_pdds, and that's it.

I see a different proc_ctx_bo allocation in amdgpu_mes_create_process 
but I don't see that function being called anywhere. Either my grep-Fu 
is getting rusty, or there is some dead code and data structures 
surrounding MES here.

So unless I'm missing something, we can just remove this proc_ctx_bo 
completely.

Regards,
   Felix



> +		pm_runtime_mark_last_busy(bdev);
> +		pm_runtime_put_autosuspend(bdev);
>   		if (retval) {
>   			dev_err(bdev,
>   				"failed to allocate process context bo\n");

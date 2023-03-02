Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9792DC6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 08:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C9B610E3C5;
	Thu,  2 Mar 2023 08:28:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D270310E3C5
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 08:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIJe2dKaVElIe6+XdmfP7wP1vmpnb/manXM0C3a30/9QjXU7LpuqxZBcK32frFjZOAHGlVLEYgSp0KQ8VUN3QDneUYYyu3RkDO7X0RIeAwaMqXVUAh4seqh022li5eDnc4Q5tUaAYPb1mHbkTne8cbYqMeF3ZH9IbXWVF39vbkKkC7FiNuFYXIM4bJdUt4QiveSkaX4xo1BnNyKfbg4OYC7zqq1v/Z69kSICqK4Are12loYKMDr5aS6gVKdieTRCQMgh1aY2wOY/M274xivB4TEI2zt0C9nQGGabgYByMR3E3wlZ1sgpWQrmIAa96ruI6vyy/RfHOzNak7OKjZaQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3IGFgoGtWSLxOBVmkTQ57OiwckqY3lMMD3WoSyuOe4=;
 b=kXar3PdYkDCeYLGcztPQ3iHUgs1r8Cv4z4HlZ+D5j5pBOA7vKtVQpuRl5f6jsVzzTkz5NqPT1BwToq3nM4ctfX6qIGnEY/6/px4yTlFMFRtEUvuEaNM8juVDQISKP6oc8oZoFSVnDcK4IQZu2t+9gQXLSAI0N4sRUdmvAFaDrK8PuaFIrtTXzetXY/T93vw29OyriKC0FbS2OkyckPdVXxMX3rsCbB4N2J54FVeOYvq2JkF+zuqROHcLZYtjneLlIkBQ1gMbusjCW7Dl6Hyx8iDN3vAjC2jpYurWtmQ6l4OguxkFSitKFV8CS9gMP+xkEsm8mrgxgqpNIv+gS5vC6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3IGFgoGtWSLxOBVmkTQ57OiwckqY3lMMD3WoSyuOe4=;
 b=YZrzwPP43ThMEiBFSqDEHBVOQSGA2GRRnBSZqXGNauYImjkXgRsPOha1MMOH2ZyLVaP9P8yLTFZMKLvLYOARlHcq+X4Dc+kAQl+5dml9F1yPOICSU5BxBCMHbEfjdQrbedc1hDeiQfG3JedxLls9WXg/PNDVMs8DRneG4mJRepg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:422::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 08:27:56 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3e46:4948:b543:8dba]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3e46:4948:b543:8dba%2]) with mapi id 15.20.6134.030; Thu, 2 Mar 2023
 08:27:56 +0000
Message-ID: <47d45518-bad2-0855-170c-31022ada6dae@amd.com>
Date: Thu, 2 Mar 2023 13:57:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: disable cstate properly for driver reloading
 scenario
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230302065835.3905147-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230302065835.3905147-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::27) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|IA1PR12MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: a3cbb602-d263-49b2-7211-08db1af805bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y7L9gDw5X/FZv+q9VtbW8BuuaCwWTmeHyzn9KPIX/QesZ8hsjg3ToT017iBfaM8WUaSqMshapmgbSN8q66Gn6SHc/cSCXW9IuO7lCCR/cACw72LSXjnXe69dfgBozSGsXwz94pSuHI3J97kUdNEusPQYlwZU+yJqqCyvvSzvlwRhJyPFGzmIn/waDKAGFKnYNBXv81r/xM1oH4Zq7GRBrRlMpKRst6ilJq/yaSyG7JQYh2Ufbj35G9pgDD3eR+9AdqMD3vJ4pjs73mbpzwhA4/tV00MCq2m/gTON44R5FbhFLEMd1cv63GO2Z8yJyyLM05sndI6oyYiQsVothe/AQlUbiu/nYt+WPZhbupCpLMzJaPxcMU+ZpB/AAKu8gbIp3GR5XiTqilp4r1q8TLER1S8gPuVcr8DP3R2yMvh6QnD1i0HXIB2ToByZK74lJL7CGtLMBknDmrJNEZwcE3vTwhVOCLdbae0EBK9kpVw9yHNseUDnQwSCgN8kbbo/FrcMHGctzs2b0J2H6zKPW+1YSPRrC9xXUo8/alUOSyDazUqdfhVShCFHL9FpjJYocAPdxrhytGEzMuiJs2mcpz5l+oBRviM1z93p7xqLMog313BkcQIud7qcpXvCHL2EBCGAGU1QgpEQcb6lO0l8hkY16WrsMYfMaYYs/Z0pVhL9bkRmthW7Yi0OvbokwI1Z9jLarkWViXIBpLubUhpXJDhRBAEFH5qhlY+CXSxC73o6LmQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199018)(31686004)(83380400001)(6666004)(36756003)(38100700002)(8936002)(5660300002)(478600001)(66556008)(86362001)(31696002)(2616005)(26005)(186003)(6512007)(53546011)(6506007)(6486002)(66476007)(2906002)(8676002)(66946007)(4326008)(316002)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czlvWklCWkRYSTVzaFpuYTRWYXRXbzJxcEVsR29pWVM1YkZDS0tEbENFWGNI?=
 =?utf-8?B?Nnk1djVxYldNaWV4S0VXUmFYcXdzWE01NUdiSHA4bTlFMDVxeTBGYlRYS1lQ?=
 =?utf-8?B?NXc4UUhvUEZOQlZNcE0wQUpzYUY1ZmR6aDVIbHM1RUlWeUc0d09wb0dGZ3dR?=
 =?utf-8?B?SzdGQlVTaFFpRGl6U3dpMGRqbFIrbENVVXQ3TlQ0Wmx4SEJ4WWYrOFhORmxX?=
 =?utf-8?B?OStXL1c4U0R4MFRGcFZlVE1Sek5XdzgybitRalpQU2pMNGN1aExkMGpnV3FH?=
 =?utf-8?B?SDhES0NkKzNzcmdBajZRSHNNV3g0NnFzMFVzdVU1ZFdESk5lS3NvZlFBMldF?=
 =?utf-8?B?M3dubG1MWldZOXRqR1BEL0UrNWxtTndrejVXQ1haWnF5WkVuWnZhMkoyKzdM?=
 =?utf-8?B?WVlwZVMrdmFWMVEwYS9kelZKNENqcnZWbXhSenc1L1JLbEYxdWNSSis3VHFo?=
 =?utf-8?B?NGxZNVRVWWloanNkckZBUThOTHVKN29lc0h5TDd6QlJEVVhva1ZueTBySlpo?=
 =?utf-8?B?SDhkeTFwaVBLdzlua05sQWFwdnl5K0lJd2I5c1ROU3MwMXB0VWhVY1hWNkE2?=
 =?utf-8?B?SnlXeit3dUxVaHVwaEsxQlRnSSt1MEN5enVxbzlmb2hkaGMvc1RmTWVQM2R3?=
 =?utf-8?B?b0F1UmR1UHNxbVpralE4bnBxUWUzVHg5dmdnT3l2WXNnMEJYS2NGVmZrb3dT?=
 =?utf-8?B?aGpWSE9JdjBieDhnNzcrMGZKYjAwYnQwOHY2MUFPT3ZFRUlBM2xWak9vOG5U?=
 =?utf-8?B?VFJrL0JtLzlac3ppVjh2WDVRNXYrWkNhN1k4TkZSSGFuUk8wdzU0RmYrS1Vr?=
 =?utf-8?B?U0hEbjF5TmtCdytsTTZUekpvTGp3b1RtbEthUjdFalpLU2N6WmJkbnJWWW1T?=
 =?utf-8?B?Z3ovdFU5RlFNNGVndHozc2ZKZXc3RFo2WHI2K281ZW5CT0dtdU1uNDZGTlNT?=
 =?utf-8?B?MEtuRW15K3lFMWhhTGMxTlk4WCt3M3BxKy9md2czanpvM0NsQTZ2T3FmblZ4?=
 =?utf-8?B?eEdCV0h0akpaM3RxSVRDMHFUTjV0UjY2YjlsVE5UbEtvaDdvS2xqWHhkVE1s?=
 =?utf-8?B?RHR6VjEwTlZSWHBMajBGTGlCdVpaMkJFOURScFFzUkpYSnNROTRydGpURk9W?=
 =?utf-8?B?d0RkOVpGZWZaZ3Q3ZWJpM3RMZU1IMmVBVzYwSlpjNnB6Z0VwUDgxTVpORmlG?=
 =?utf-8?B?VlNOQk0wWEsxY0xNZlFFMHV3bTZwbFgrSUcxZXpoenBneEhpUjNMbk9BUDRN?=
 =?utf-8?B?WmROREdSdzg3MjhRdlBHTDliOGhPZ20zbDZVZDBhZE0wQ0wydDFDb1pVa20r?=
 =?utf-8?B?VUFxVExzVzNjaTZPWlphdStSNjRibG90K2R1WENjdXVuOHVmclpyNlYxbE1L?=
 =?utf-8?B?UTl6TG5DeG1zc1N0VVo5NTNmMnVERkhqVDZYZ0RGa3YycjREM2F6RnpPZWVx?=
 =?utf-8?B?cEluZ0R4b1NkNzRvMENlYU9NallHdys3dENNZTUzQlpscU9JR2NybXFObFI4?=
 =?utf-8?B?OURsZ1pDdWhId1kreVRhbnhFVGFVSUdxRnl3SjlDS0ljUEthRzU0YWhQcU5E?=
 =?utf-8?B?UENNZDJOQUtaQVhSMFJoeDFtVlAzYzZBeFRKTmdaRzY4WUNPaDRuRCtjeWgz?=
 =?utf-8?B?dW5vWW1sdjh4VkVvcXowSmRsMlhsT2loYUs3T2haMi9EbHEvNklpcmcyTTM3?=
 =?utf-8?B?Ry9lV3lwL0x6bEdtRzdScHNWM25xak02TEJaSEoyeC81TWtWaWRHbWI0MEdY?=
 =?utf-8?B?UndoaTBrSHZ0U3EzTGhIc1gzUUVxMWdvYnhOaUxFMXRsRzE4T3AzWS9kYmZx?=
 =?utf-8?B?WVZaTVBMUTFOMTNFYldIVnVPQ0ZFYWRDbmtXMG42UGtsRUpLYWdFRlFsa3Yz?=
 =?utf-8?B?a3JET2dJN0M5eUN6Qlo5K3c1RDREZWFTdlZjRWs0c0lQclpBNUx1MFJRU2Ex?=
 =?utf-8?B?THlEZzVFbVFhdm1uU1I4NnQwditGdktmYlNBUU92a0dyWlIrU004UmdnN21V?=
 =?utf-8?B?VjEzeTkzcEFCRFNsSW1DSkFsb0oySEpWd2d5ek96Zm9qdVBtY3NpNzR0R1RD?=
 =?utf-8?B?cEoyQXZ0VnFBZDdHOHBKM0JGWUhHOWY2cGx3ZElqNldkanYrQzlhRm5neTdh?=
 =?utf-8?Q?75smVPzNQFUyTTQ57kTcIVac4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3cbb602-d263-49b2-7211-08db1af805bc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 08:27:55.8035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1b3OV0jVqj3B/RHexWzhbHHGonOZzuNMCPAaQjBvL8i72ojauWC43LnGUlr8YdN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 3/2/2023 12:28 PM, Evan Quan wrote:
> Gpu reset might be needed during driver reloading. To guard that(gpu
> reset) work, df cstate needs to be disabled properly.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I5c074c265c0b08a67b6934ae1ad9aa3fed245461
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 51bbeaa1f311..3c854461ef32 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2816,6 +2816,15 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
>   	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
>   	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>   
> +	/*
> +	 * Get df cstate disabled properly on driver unloading.
> +	 * Since on the succeeding driver reloading, gpu reset might
> +	 * be required. And cstate disabled is a prerequisite for
> +	 * that(gpu reset).
> +	 */
> +	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
> +		dev_warn(adev->dev, "Failed to disallow df cstate");
> +

This looks more like a firmware bug. Driver sends the Unload message to 
FW. In that case FW should disable all features including C-state.

Thanks,
Lijo

>   	amdgpu_amdkfd_suspend(adev, false);
>   
>   	/* Workaroud for ASICs need to disable SMC first */

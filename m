Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0371061B28
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 00:08:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 049C010E69C;
	Tue, 31 Mar 2026 00:08:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bc4mOzfe";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1944110E69C
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 00:08:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqeQvuEvB8XUwDUqUrGLfbrp03cHUEQiAJM9Nfah13X1RTtwzpb4fTO966nSRXnSeSshiRPYd0+sEnX27XlWuYwv3o8gw/8B1cbkLuTUSfa9pR9Ybdqqw8ROPO8bPx+5dqKfPTZO9d20uY5j55ZF2nuJPjYZluLWhOlyKrVaKOh5ADck17SVw6btrComjmTxWn+Qv7ti7gTgJyYLT8GmFxtOtCegC+3b8JlrGQJdpKdBw8Q2g/B85oaYVlWJq+qBEH0j8eh+GDa3cqNUwruD8dI2bWH8PEJ1tMrdHbO5HLekyWYh4MqQchNXr34Uw/5Rl/MZtgqc/LzXIkXePI/K6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaLclSv+Tz9RTA7+J/DkFyuHd54yawZqSU6654CXx/E=;
 b=tbeAL+EhPEjUVC46GQc7nVxkhCR67gmfxsYEgPTD/O0ckvUCYj32VtQJl5Qngq+XjmJ/S0UFIyEWI4euH250iuzpT4Xo+cyMpvMsGogz40Ni1MW9c04otciYNdWmmOVOOMkKWZyrvyRXS2Bz/PIXvS3JdMcW1mqn5pisP53YUzgTQxpy8d1fq28h2VOARFD8dKY07HA2yHFa3iu/dXkkWx4uMt9HLaHckfd9Hog9C0CITdMC0H8nGmT3KYBEogy8lzyDixIHk5eEsntjNY8uSR5f8ExhxAJcgsXwRUkUsw3XDN/rdZkeBi0myefnxnWsZfFq6rfQOaN3MlBaG5kOOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaLclSv+Tz9RTA7+J/DkFyuHd54yawZqSU6654CXx/E=;
 b=Bc4mOzfeC9LqedvdGPuv1rvSVr4il5wVRd5AE/wQcZIIw+rKeHZKyFrI8t+Ce7r+IdfYPgs6tb5hf83I8gitqV+QLe9kuYEEOscyd2QG+/QkcQcpDIMi0mzsLNkCOZrmiw7jDllw3EUM6X2LUOa4nz5zfQPt/INw/JP+Tt6yH2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 00:08:08 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%7]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 00:08:08 +0000
Message-ID: <14dbd703-8a89-4ba4-9d85-756fd9e885b7@amd.com>
Date: Mon, 30 Mar 2026 18:08:06 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix missing parameter details in
 amdgpu_dm_ism
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Ray Wu <ray.wu@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Roman Li <roman.li@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Mario Limonciello <superm1@kernel.org>
References: <20260329095642.2131849-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260329095642.2131849-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0046.namprd04.prod.outlook.com
 (2603:10b6:303:6a::21) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|PH0PR12MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 172570bb-c78a-417d-b2e4-08de8eb996ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 50VZyCv0qvicWWG4xHHEhpzogJMJ+YoDg41sL8Xf7T8DH9DScv3/uAuRdqm0v8m9U0jDdFdLVrzD43le56nM80k/5GgLZ3aHTofqE2onIIEfw8kKlPdj1ds82TU0Q0UXaP3soowT4L1JBjJSZRnu8c1uuh+b70FgR4eRooUY8n0ptkLnhoqejUeYJuqsYT8wx9z3A5tRUNyygtUizU18mxp92id1MrYAqFAPw4AJB/sELmtZycHc6pnW3MANywHs6A0D6E1Edq6F9wgk/WjrETmzwBMcKe2ys8KRiMaA8xnj9EW0Goe6zUAu5fBLqrvKRv6qG35nzGkNTO2bpbOzCvD7to98N5Qchkr/7R0TVUZF5oGKEem69jdqqpIPshcvtvGWL18dkQ+UDT00O9J1/GDvOKtE00ldde4TfhCyysTM0XoriXyT4h1HmdNrcQg4tAr7aJRiMRiFCbdOoHq2bKKGZ9LJ6pQ0vGGAaFy2gpknrFpYI2MXLhH9RMlieUOWkK8HkYHu6rOhiV2nYTPEcganJkvgOhJ66BABGMNBfuk8CPO4YvzxEr2NftpoIWIcrXoq5Hen1xgOueyF3E5pDCgQZl/dsr1X48g0ervphbFEIxQJ2X2zdzT4dwUQZ06G3jZ5vqf1QP3nDpjZ0GZaGirE3KMq5nAfJiHV0vXAk8lXsMbQ54R4MVJOjLi1gI7l+THsuK6/lfo6N6N4WGoQByOWmBkBBXORnNAT8qDBQAQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXlpUzhxNFM0NmlQL1pyTmIvV3pFeU1vemo3S1htQ25uRm1uek92RFdHdGxT?=
 =?utf-8?B?d2hKUUMyY1ZCQmYrSUl5dDk0Mm1OM0F5d1J4bXFneDNlYWw4SXhHK0ovVmdL?=
 =?utf-8?B?dW1tNlVMaGVTUGtGS0NRTUs3aTUzK0JIaFhoZENCUFJEcWJtYmJJV0RYZlJW?=
 =?utf-8?B?VVNXZFJWckk0ZXhxZDhHcldtOVVTR0x3T0FUbXhidjg4MmhDWTNWKy94cVdE?=
 =?utf-8?B?cndBN1ArVSthMFZRMUxxODV4TUNFR1RDMFMxWjBOalFVTWwxQk5zQ0pLQ3R5?=
 =?utf-8?B?aGlxaGN4R1F1b0xYNFg0MjdPM1VxbjMyMXRNaXd0bmJOaktJSGl4S1BGVytK?=
 =?utf-8?B?eG91TW80dmlRMHoxYk0ySWo0VTdBYlNldi9vVEpGNURlUU9nZVF1SFdJMUs0?=
 =?utf-8?B?WFFwbEE3WEZOeGFYVkNNQ2NPaUgzdTRnYThQdHFPQUJmeGlUTTdlbDVQdmM2?=
 =?utf-8?B?TDF1cnFrYlRRc1ZJREladGM0cEJHbzRiUlg2bGRmdXp5ODZPbzlFUTF6TWgw?=
 =?utf-8?B?RzR5YkN2WmpUaFZLRTEwUmtvK1h5QjRXUk5FTk4yV0N6ZUZyMUViR2YycUF4?=
 =?utf-8?B?VDJFTnpuT1JrQ0JxYUhXekFQcUh0QzZlY0JiZXZIa3RYOWdLLzNIQUhwdW9n?=
 =?utf-8?B?cWh6Q09GU2N5cVBwajM2SnVBVDMxZlRGL2xPYWtWaGJZaHBnSENlYVZpUytF?=
 =?utf-8?B?NXg5SVN1Vi9mSHpOdW1mRzB0ZWxsbzdSU01iVXgrdE1IK0p0V3FOQVM5bTlr?=
 =?utf-8?B?RWRpRzZ2VUdMVHE0MlB0YmhpTzJFdmlmVytobVBYMGpIMGs2aUVTamRLT01q?=
 =?utf-8?B?dGh0RDBuY0hoeFc2MGt6YXRVUEZMV2x6bno2eHFkS3dpZmhVSGNmdVA0VkJR?=
 =?utf-8?B?YjhVbURHck9YWVJPRVRETmVRZTNSMDl4V1NUenE1TXYrUXJTTnFHRU83TVUw?=
 =?utf-8?B?MHNTcWJ3d00zRWZPek9lWlc5TysrSkFmeWRHMkRrSU00OTNsWnAydUpLKzE2?=
 =?utf-8?B?N2tJWFJabEdrd040OE9yZGdBbVVUU2QvZlJyZEkxMmgwazNxaUJtSU10N2VX?=
 =?utf-8?B?T0dRSTE2NEFmWW5OZFhoSVQzU1IrUzM1OEpxWG51MlY3bDFSSmlVUWVpcmRr?=
 =?utf-8?B?elMxZFAxa1J0S2ZRV21wY21wZVFvVGZ3NlhjTkN5TEoxODF3V1RJWVRrdU14?=
 =?utf-8?B?SktQMHpHenlaMUtkWXg2WUV3YzRtU3g3TDVCMGhEclBZS3FIOFM1N0xGZm8x?=
 =?utf-8?B?c0tKS0Y0dVhWb0wwWStZbHFpSlNIS3IrcHBsVktTVytDanpva3drMEZNdnpC?=
 =?utf-8?B?SU9CbHZiOFhFYU5ydGNjWHNpRHhWT2pqblV0cUN1SEsvQWNIVTRpaVZ3M1U2?=
 =?utf-8?B?U04rTi9sZDlFV1Yrc0xXa3VuRFl0eVJpZ2xjQmVTMFM0TkpwaW1yVmdYeXMr?=
 =?utf-8?B?TFhwYnkrL0tDZmdaZGl2bXdiTWVHUHdlamY3V1Q0ZXdZSEhCZ2hkdzBJd01h?=
 =?utf-8?B?Z3VKRkhIT3E5WTlESHBGNnZTdTVEK2t1TFNDdUlYTndENlYvMkJzZ0tuczBx?=
 =?utf-8?B?aXdHSklpUVJ5VGJ0WlpreUpOT3pGMlcxaGkrUDdhbE9XWjR4SGw5c3RwV2dq?=
 =?utf-8?B?aGtrNTBseWpMSHNFckJBbkFMM2F1TmVyZlE5dDRmbDYrWDNoQ2pBbDZBaG80?=
 =?utf-8?B?ZTlET2NHODRrR2Fpa2p0VU5FQVovc25BeGZIOWxldUdnRjEyanM4SVFkcnN1?=
 =?utf-8?B?RmFvREhTVXRRSThRREhDdXN1YmE5MmFRL2VXQWtTRnE1aW85ZVBFVTkyTGFI?=
 =?utf-8?B?UUpMV2xoOHBZK0VVOTlZaHBkVHl4RHRCZllMSmN4Q1NWbTRzSnBuZUlJMmxC?=
 =?utf-8?B?QnZ6dXc4eXZRYmVRN3pkVmNhS2ZrTWhtZVBnN3NITmIxcmtUNzN0T2N0aUhj?=
 =?utf-8?B?QUVxS094ZHVRajBTQW9Hb25WUEYwb2dRNjd6WTFCYnJScnBVNWg5YUx6Q2p2?=
 =?utf-8?B?SW5ySHcyUHJoSHpBVDYvNG1kTmVpS0lvd2swdjduTVd0cWNRbGpOZUJ2NG9l?=
 =?utf-8?B?RGdjbmovSDlxYkpaR01LQ2I2U3dyQ25wZmQrRDRzSEJVMXdUTXB1NVZrdVRt?=
 =?utf-8?B?aEZqZ1hiM3BnRUVuTkhGUkM5QmMrVDlJTDJEcldQd2UrUWhONjdFRE1ZRExl?=
 =?utf-8?B?RTVNYnpWQ1VmYVNHME9IdVNtZDJrQmgrSWJ6VmV1QUp2aS9EdzJhUE1waHBO?=
 =?utf-8?B?VTVRdk5kNll1ZzRsZ1grdndJZzRna050VUJnSjE3M1hQRytKUUt3WEs1V3U1?=
 =?utf-8?B?OUh0ZzRRbUFlY0F5N1h2MGxNd2I4bnNGTUNMbTVDdVc5eElMaXJYUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 172570bb-c78a-417d-b2e4-08de8eb996ae
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 00:08:08.3243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NtqYDpELrmiOVY0N1INorPIQo8hwOM0mkIsxnVZMnxnk7SFELs33KVYBcKOYcDzw0uhoiOJ6ZI4iTSMrmd7BbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 3/29/26 03:56, Srinivasan Shanmugam wrote:
> Update comments in dm_ism_get_idle_allow_delay() and
> dm_ism_insert_record() to better reflect their behavior and inputs.
> 
> dm_ism_get_idle_allow_delay() computes the delay before allowing
> idle optimizations based on history and stream timing.
> 
> dm_ism_insert_record() stores idle duration records in the
> circular history buffer.
> 
> These functions explain what they do, but they do not explain what their
> inputs mean.
> 
> Fixes the below with gcc W=1:
> ../display/amdgpu_dm/amdgpu_dm_ism.c:44 function parameter 'current_state' not described in 'dm_ism_next_state'
> ../display/amdgpu_dm/amdgpu_dm_ism.c:44 function parameter 'event' not described in 'dm_ism_next_state'
> ../display/amdgpu_dm/amdgpu_dm_ism.c:44 function parameter 'next_state' not described in 'dm_ism_next_state'
> ../display/amdgpu_dm/amdgpu_dm_ism.c:153 function parameter 'ism' not described in 'dm_ism_get_idle_allow_delay'
> ../display/amdgpu_dm/amdgpu_dm_ism.c:153 function parameter 'stream' not described in 'dm_ism_get_idle_allow_delay'
> ../display/amdgpu_dm/amdgpu_dm_ism.c:216 function parameter 'ism' not described in 'dm_ism_insert_record'
> ../display/amdgpu_dm/amdgpu_dm_ism.c:44 function parameter 'current_state' not described in 'dm_ism_next_state'
> ../display/amdgpu_dm/amdgpu_dm_ism.c:44 function parameter 'event' not described in 'dm_ism_next_state'
> ../display/amdgpu_dm/amdgpu_dm_ism.c:44 function parameter 'next_state' not described in 'dm_ism_next_state'
> ../display/amdgpu_dm/amdgpu_dm_ism.c:153 function parameter 'ism' not described in 'dm_ism_get_idle_allow_delay'
> ../display/amdgpu_dm/amdgpu_dm_ism.c:153 function parameter 'stream' not described in 'dm_ism_get_idle_allow_delay'
> ../display/amdgpu_dm/amdgpu_dm_ism.c:216 function parameter 'ism' not described in 'dm_ism_insert_record'
> 
> Fixes: 0b572a6bf04a6 ("drm/amd/display: Add Idle state manager(ISM)")
> Cc: Ray Wu <ray.wu@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Mario Limonciello (AMD) <superm1@kernel.org>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> index 65a5cfe1e106..a3ccb6fdc372 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> @@ -35,6 +35,9 @@
>   
>   /**
>    * dm_ism_next_state - Get next state based on current state and event
> + * @current_state: current ISM state
> + * @event: event being processed
> + * @next_state: place to store the next state
>    *
>    * This function defines the idle state management FSM. Invalid transitions
>    * are ignored and will not progress the FSM.
> @@ -148,6 +151,11 @@ static uint64_t dm_ism_get_sso_delay(const struct amdgpu_dm_ism *ism,
>   
>   /**
>    * dm_ism_get_idle_allow_delay - Calculate hysteresis-based idle allow delay
> + * @ism: ISM instance containing configuration, history, and current state
> + * @stream: display stream used to derive frame timing values for delay
> + *
> + * Calculates the delay before allowing idle optimizations based on recent
> + * idle history and the current stream timing.
>    */
>   static uint64_t dm_ism_get_idle_allow_delay(const struct amdgpu_dm_ism *ism,
>   					    const struct dc_stream_state *stream)
> @@ -212,6 +220,7 @@ static uint64_t dm_ism_get_idle_allow_delay(const struct amdgpu_dm_ism *ism,
>   
>   /**
>    * dm_ism_insert_record - Insert a record into the circular history buffer
> + * @ism: ISM instance
>    */
>   static void dm_ism_insert_record(struct amdgpu_dm_ism *ism)
>   {


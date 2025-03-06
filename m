Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7871EC282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 11:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D78410E8C1;
	Thu,  6 Mar 2025 11:03:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AS/mopnB";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2069.outbound.protection.outlook.com [40.107.100.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A0DB10E8C1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 11:03:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qY4F8WIfxk6YUQckfs+5X3+kTTWZoOE3d8gbeY000tGkHBnvj9yE6zihqCiEYgkro8dLczwIWoGsVoVsrLo1WSd8C0JoYluvqyLXo1Jle2CpxbMvZASJF/9X07xzagtuY6I6sBcb66QaNMSmE2rSB72bdHXlahe3mcZIAoQQK9gPPd1IqbZu/zc/RBN1PTgHzv1u7uNGeAosQXRI86gRjHIU357u0D7fLXvhuiGH6v2lRlRC1tBXwP1NA+UciUHH0/PBZKC7J3T8FCWNtpRWpaCOjML0RZXHH6EyiShQT4XwaTs1gx8EZHg/HLhItr8l+HWHQ53hgtSIJY+7Wn+EhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9g/xdFtKFq48KjhDsjgnSOS9nuBV/2C4jJHBNQYAk8=;
 b=D+GCknnTx00y565954ns/cILliSNCfHM2qUV8RVk98YuCT7V6tIQkGjigQ7QFGX+kVHKqn/8iYAhSXPBq9/XQfsZjOTTbnEeNSukuN70Rz/136AwLm7SdTkJYXAwnufBpFhn3WOar7eIJkWPTPsTnVDWrQmCjoI6EY2caLFF8FNylBLRFMePcV9q7D6vCbyCTe76DWNREtQhUHo4Z8WD1CF4a+8JlNxI+y6hTo/pmKkxyJj8UUKgNtEXuER2yuAXNIZtqKNoNuuareXPYf/+YFpDBOqR08NRpB76HLOz76YhZ9e75NMTXra1nxfrMp2JD04/DNJNs6CZh1mv/NQvlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9g/xdFtKFq48KjhDsjgnSOS9nuBV/2C4jJHBNQYAk8=;
 b=AS/mopnBmG3uy88MP7VK1zHYRjA9wJSbzX5zGENJtFJZFLerZynC26xBW6kmfJVjSrMnhEswl8RShYlQM5D0/J+YHMav8Enlp9z7AF8NYEf3FSCmMz/4jacv7xEBW18o1Q/+cj3H2/3UVxgMFP6/ZVmUCxXd+zBav4SA1cNjn/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM4PR12MB6543.namprd12.prod.outlook.com (2603:10b6:8:8c::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.29; Thu, 6 Mar 2025 11:03:30 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8489.028; Thu, 6 Mar 2025
 11:03:30 +0000
Message-ID: <3f1deb74-5798-4d4d-a7dd-4556def5db25@amd.com>
Date: Thu, 6 Mar 2025 16:33:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] drm/amdgpu/gfx11: add support for disable_kq
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250305204721.1213836-1-alexander.deucher@amd.com>
 <20250305204721.1213836-8-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250305204721.1213836-8-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::17) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM4PR12MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: 50f5edde-ab6d-4dcd-d7c3-08dd5c9e8746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0xUYU1qTkk1bU5QMkVNTjBpdVZlMy9yOElqK0lxU2RjT1ZpalNiYWpYY3o1?=
 =?utf-8?B?NFZPUzF1bjBIK3B5Q0d1b2RNSm16R052dUNLeFkzNGhRVnhRQW80T0hkWlZp?=
 =?utf-8?B?TEZGTi95aXV2MHdnOG5kWDVNMmI1Unp3RjdBSVh5WlBGbStwM0lXakJMdFI0?=
 =?utf-8?B?NTJ6Z1JuRit5Sm5kTks1NTFFemk4U3hZdG15L0NBQWQrU09VN0sxMHI1YUdr?=
 =?utf-8?B?OVdaeSt4UWI2bi81U2FtYm90WmlTdXRFdlZ3amI5ZjU5aGtnQ0dJdmMyRVMy?=
 =?utf-8?B?TFU2R2JhNW9yVW1lTG1SOC9KWjBnZ2VmdFV1VjZsVjRYejFlc0pRVlViNlJp?=
 =?utf-8?B?eFNEdEJyUWp4V25aS3VPL21mNmt2RlBCWTdXM1luNHdaNGFDWEhlKzBQTVBh?=
 =?utf-8?B?c0o0eUFrNG9jZzNWZS80cGlrbHFHOUJYL21tOURwWDR3WjhQV1VuNnkvQXNZ?=
 =?utf-8?B?TEVrMjBHSnRtS2NMcWxIY2UveDhkNVZBSzcrN0tnRmhsK0p3YTIyZjUxY0Nj?=
 =?utf-8?B?TUlHY25QTFNUMk1KYng1dXZDTkhGQUU1NXpObkcrWElpS1ZyejFrUTF4Yjkz?=
 =?utf-8?B?NGh3UkpmZW9DaWRiOEtRRzZIV2RVbjFVeURKN01CQksxelhwZjdwbVZ5bm15?=
 =?utf-8?B?Z2pXZG1GWlNvY1hrdnFQOFREZUJ0b2lsd2xwUVM5aHJWaVdPdW5UY3ZKQmJr?=
 =?utf-8?B?dkJ1QURFMThuQnFmK0xlL3pmZDhvZVZkMS9KaEJnUU9UVDRFcGkxVUE3a0Jx?=
 =?utf-8?B?NXdOZ1ZKTVJaQlZadDFKNWl3ajI0NGlPZmVUSHZGZzlEZVVJdWtlSlRDdnhS?=
 =?utf-8?B?LzBoOEptUmd4c3NyN2ZVcUl2clB5KysxQ0ZycUN2Z3V1WVd2WDFLWnRrSVFs?=
 =?utf-8?B?MUcvcjE0dUE3d09NaDY3OEEwVDA0ZTZteTN4VUhmdnJSMkY0ZUMxL3NVcUhC?=
 =?utf-8?B?Yk84S2VUQVExcHltcER0RGYvMDZ0Mlg5NEVlcjFaQkE3N2s1S1ZDcjZkSGxr?=
 =?utf-8?B?MFc3S0Z2ODJRNXE4SzRQTFkrWmZFak9PR0FFeDZGOTc3Y1JQT1RLUXRxYXZ3?=
 =?utf-8?B?bGlMTThMYWtSQWM3SlhHWnB1U01zTWxXWUN1R0NNOTVjbTAxSFVtdjNWTjEw?=
 =?utf-8?B?UUpZeVN5T0lhNncyQW5URnBOWXVxUThlZG05bDgvb1czTVdtQUhtYStLY2hW?=
 =?utf-8?B?MnM3bkI0Y3UwdmU3c2xDNXNOZklCMldEYUo4TVQxMkNGVTVXeW9pdmVyUG9L?=
 =?utf-8?B?c01lNmd0eUs5cTVTOXh1dkZnK3d6a3RsL3BjeStlM3J4d3BudE9oTUhCYTlK?=
 =?utf-8?B?bm5CbnNlZ0o2d1BDMEZ0ZXRoTHZsVmprNDd6RjJlOTM1ZkhyRUJNMkRHejFN?=
 =?utf-8?B?RjhXckRIQnRnTDloTHV2RXM1bHNXVFBVckdmWGJXdkM1WnlqdWtOUTZCdzFq?=
 =?utf-8?B?RFZ3SmhOZXBSQmwyaGJnTVJQU1hXa3A2ai9hek9WSWNRSWUxajNnSCszbGFL?=
 =?utf-8?B?TmtQV0ZtSzIzNnhPNFV0ZDg5ME55eloxWnltUHJ0cmdtR0R1OXpxTWZXc1E3?=
 =?utf-8?B?T0FQT0FwUWlEekRuVkRHVXoxSGM4U0RmaVNINW5odkloNVJya1ZsUEJITEVU?=
 =?utf-8?B?TGVoUnA4aWF0WGZHRDhsejZ2cEtBOGE5QnBublM1QWpwNWFmekJVOVc3UnZK?=
 =?utf-8?B?SDBYODhWcnQrMFpLSW81c0hmbjJkVjVLazQ4QUFzaE9tVEFoTmZLRkRFaXds?=
 =?utf-8?B?RUNPditXaUZOYnZ0M1YrbG82WlhMMkxpOHhTUXo2RFNON2NwUUo0N0h4ZGNt?=
 =?utf-8?B?QXVUT1Roc3Nyd2U1YXlUeU9MTnhPOCtpbENPUVFtbjM1Q2E3d3ZoRTk2Mnlz?=
 =?utf-8?Q?G1BWxhKqpw0Di?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vi9BMXcrRXdGcDNJRmFCSVBmQU1GSTlNaVhlUUt5TjB0YXd6dXBYT3l6NmQ2?=
 =?utf-8?B?TFdwd3d5Q0lqclk2K2llT0FqK3R4NXppdFFhMHhCY1JzRmgrSEd4eFpzRm9h?=
 =?utf-8?B?MmlHMkkxUE8yRjByRVNmbEVDVFl1Vy9tNXo3aExLemxwbERrUFhTTlgxK3Ix?=
 =?utf-8?B?L04ydm1VV3JGei8vMm43K3FiTERTZzdwRUtUcGZtSXh4cm1Gc1FJM1V2UEtw?=
 =?utf-8?B?R2FYbEVqd085K2VWN0FzYzZGQjlaclNaRWkyNjBCeTdSTm0vOEJXU083VnU1?=
 =?utf-8?B?c2J0bkdEVHNoVlBYQmtVTnkyalVodGZZVXMrUHpZMjJtV1dsU1lxdksyUjVz?=
 =?utf-8?B?cUF0RVczSkVSRUlPZXhZZFA3L2E2NGhqWEprZGNzd0JoQ2o5NWdvSFRpK3lk?=
 =?utf-8?B?V0pWTSs5RXpjYm40TXIyOHQwbDFsQ0kxZ1FtaitxaEYyWm9ESUhKa3ZMU05n?=
 =?utf-8?B?UkM1NERVa0FIQ094VTBLWjNVM2RZM0JUTTJENnlBOE9aT0ExV0w4bWpvNHBm?=
 =?utf-8?B?dXMvSkZrTG1JMnUvVUZCamxEeXl0U2xlVU1GSUtmMGpua1BlTHE5SnZMQ2pr?=
 =?utf-8?B?cnZ2MU9TQ2V2cEx6SjdBRkdTWWtncFhwN1phS0xhVmZHZllCSHBYcFhkclBK?=
 =?utf-8?B?RU1QOXFKZnJhUVZxMFl4Y3dlRjV0ZUNUVEF5RE1ibW5vWHh2Uk1KeU1yZWU5?=
 =?utf-8?B?NHh0Mi80d3JBTDhOL1ZobEtad1YyTlgxMnVKZXBKeEhNSWZkYkc1ZUVXTW9l?=
 =?utf-8?B?UmtvZWk2RnhXdis2ZklsRmcvMzlhbklvcUZmTWZXTW92THB4d2JUUlFzaGxP?=
 =?utf-8?B?L2pqbmJNUTZiWEM3dlJDZ2sxYW9OUHM0TzdCenhqaFRZVVlnVFhjVzhGTXk3?=
 =?utf-8?B?ZHJIZkFyR0hVclkrNGUzWG9qNHY0eVVwRWdqaGpLRmRHOGtEZTFudlRnK1pz?=
 =?utf-8?B?YTBaa0lQcDBuMVJTWUhzeGlmcWs1dTQwVyt0MGg5d3dLUmJLQnFaK1FiRUhO?=
 =?utf-8?B?U0oxOEplbktucldEN2Vsd3dOR2dqaHZycUowMDQrMWlPTzBIOFMwK0Q5ekFH?=
 =?utf-8?B?OXZhWnNPdEg3d1VTeldhOXF4SVNaTXZ5Zkx6bkVoS0hCKzhTZFhXblA2WXVu?=
 =?utf-8?B?Q2V0T1RQS293Z2JLdXJvZENHVWh0RW9MNWQxNVE3cy9TTVBBRFpZejd0OThz?=
 =?utf-8?B?WSsvbDJrZk92VWp5b2RSdjYyakIrcWVqd1hXb0RsRmxxbEx0ZUw5S2pyZmRU?=
 =?utf-8?B?K1JvK0h3OFpUZy9LODVyR0VuRldOM1cvUUh6VnlwKzQxUnkrcUpZVktkMXc0?=
 =?utf-8?B?KzFyMUFTMkJKRXhvVG0wdkhWeExLYWZ6MVRYR1hwZk1tV2dud0pxSzFmYnI0?=
 =?utf-8?B?ekhZNXVtd1pnTFI2VW42Q1FKM0txby9wcktGR05mNlVmdnZ6MjM5RUVyYk1U?=
 =?utf-8?B?MnpRSlZOR0pkdElQaG5pME0rRVJLbVZrYVBSQ05tWEdvVjRyRWRkaVBzT1I4?=
 =?utf-8?B?aXI5MzNDM00wNlZ1bWo1b05CN1FOQ0dXNVN4T1R0MExXZEhTMkVBNG9FQ1FU?=
 =?utf-8?B?REJTNmx1NitVTzZnY3AxRXJBcXRyLzdCc0Q4c0E1bXBGODFoQURkOHZJeW95?=
 =?utf-8?B?YW5PTEpFNGpvRzhvV1hhK1dXanZaMUVzR1FVMnFBV0oxdC9FNG9acDlSaGE5?=
 =?utf-8?B?NGt4YTVpN0FJVGk3NUFSUlZlTDcvK3l1bG9YWS94ekMvUTNHRGRiSVAwV28v?=
 =?utf-8?B?UE14Ri9KYm9Ocm44dWU3cjJjWHowVGZKT2VZQ0x4akFxRkxGR0JiaENLTzZL?=
 =?utf-8?B?SEttbHdhN1RZUisweHU5T1JHU1Z6d0VZTm5RaGNISC9wMnhCVmcwZ0hadzhh?=
 =?utf-8?B?TnRPUFltS1l2eCtpelVoN0VidnJway9LcFR2QTZQUlFlQVZJTkgyOTZ5Z21q?=
 =?utf-8?B?MEE2UExxZEtta3dDRVpnVGJlSTBxaG9qenRVRVVVTkZzQjNZTzA0UURYRW1V?=
 =?utf-8?B?MTl1R1pXTzlwQjdHYkFJZEZQTElaRjRkRk96anNKa0NRUDYyMlNnTU4yU2h4?=
 =?utf-8?B?K3A3OGo2cmhtOGlpTnZGNGVxRCt4VEIrQ2plUWlNdDR6QTVvY3hoUW50TFlm?=
 =?utf-8?Q?JORbRWdpCJBZhReN6l6F5gX2z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f5edde-ab6d-4dcd-d7c3-08dd5c9e8746
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 11:03:30.3605 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aw4SowwL9Sr2PIKMrDOiVajzeNydoGm86uDiHgTsrKWdzFyTtQ3/OMoAiVataQWDjD2/T+8d0uaFWMFb9BO8dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6543
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

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 3/6/2025 2:17 AM, Alex Deucher wrote:
> Plumb in support for disabling kernel queues in
> GFX11.  We have to bring up a GFX queue briefly in
> order to initialize the clear state.  After that
> we can disable it.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 77 +++++++++++++++++---------
>   1 file changed, 51 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 3e49c0f399e02..e18100c5faa2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1128,6 +1128,10 @@ static int gfx_v11_0_gfx_ring_init(struct amdgpu_device *adev, int ring_id,
>   
>   	ring->ring_obj = NULL;
>   	ring->use_doorbell = true;
> +	if (adev->gfx.disable_kq) {
> +		ring->no_scheduler = true;
> +		ring->no_user_submission = true;
> +	}
>   
>   	if (!ring_id)
>   		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
> @@ -1709,21 +1713,23 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
>   		}
>   	}
>   
> -	ring_id = 0;
> -	/* set up the compute queues - allocate horizontally across pipes */
> -	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
> -		for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
> -			for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
> -				if (!amdgpu_gfx_is_mec_queue_enabled(adev, 0, i,
> -								     k, j))
> -					continue;
> +	if (!adev->gfx.disable_kq) {
> +		ring_id = 0;
> +		/* set up the compute queues - allocate horizontally across pipes */
> +		for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
> +			for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
> +				for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
> +					if (!amdgpu_gfx_is_mec_queue_enabled(adev, 0, i,
> +									     k, j))
> +						continue;
>   
> -				r = gfx_v11_0_compute_ring_init(adev, ring_id,
> -								i, k, j);
> -				if (r)
> -					return r;
> +					r = gfx_v11_0_compute_ring_init(adev, ring_id,
> +									i, k, j);
> +					if (r)
> +						return r;
>   
> -				ring_id++;
> +					ring_id++;
> +				}
>   			}
>   		}
>   	}
> @@ -1823,8 +1829,10 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
>   
>   	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
>   		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
> -	for (i = 0; i < adev->gfx.num_compute_rings; i++)
> -		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
> +	if (!adev->gfx.disable_kq) {
> +		for (i = 0; i < adev->gfx.num_compute_rings; i++)
> +			amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
> +	}
>   
>   	amdgpu_gfx_mqd_sw_fini(adev, 0);
>   
> @@ -4489,6 +4497,9 @@ static int gfx_v11_0_kcq_resume(struct amdgpu_device *adev)
>   	if (!amdgpu_async_gfx_ring)
>   		gfx_v11_0_cp_compute_enable(adev, true);
>   
> +	if (adev->gfx.disable_kq)
> +		return 0;
> +
>   	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
>   		ring = &adev->gfx.compute_ring[i];
>   
> @@ -4561,18 +4572,29 @@ static int gfx_v11_0_cp_resume(struct amdgpu_device *adev)
>   			return r;
>   	}
>   
> -	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> -		ring = &adev->gfx.gfx_ring[i];
> -		r = amdgpu_ring_test_helper(ring);
> -		if (r)
> -			return r;
> -	}
> +	if (adev->gfx.disable_kq) {
> +		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> +			ring = &adev->gfx.gfx_ring[i];
> +			/* we don't want to set ring->ready */
> +			r = amdgpu_ring_test_ring(ring);
> +			if (r)
> +				return r;
> +		}
> +		amdgpu_gfx_disable_kgq(adev, 0);
> +	} else {
> +		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
> +			ring = &adev->gfx.gfx_ring[i];
> +			r = amdgpu_ring_test_helper(ring);
> +			if (r)
> +				return r;
> +		}
>   
> -	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> -		ring = &adev->gfx.compute_ring[i];
> -		r = amdgpu_ring_test_helper(ring);
> -		if (r)
> -			return r;
> +		for (i = 0; i < adev->gfx.num_compute_rings; i++) {
> +			ring = &adev->gfx.compute_ring[i];
> +			r = amdgpu_ring_test_helper(ring);
> +			if (r)
> +				return r;
> +		}
>   	}
>   
>   	return 0;
> @@ -5111,6 +5133,9 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
>   {
>   	struct amdgpu_device *adev = ip_block->adev;
>   
> +	if (amdgpu_disable_kq == 1)
> +		adev->gfx.disable_kq = true;
> +
>   	adev->gfx.funcs = &gfx_v11_0_gfx_funcs;
>   
>   	adev->gfx.num_gfx_rings = GFX11_NUM_GFX_RINGS;

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8934C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Mar 2022 13:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DAE110E061;
	Tue,  8 Mar 2022 13:55:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A907910E27A
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Mar 2022 13:55:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0g7Yb5yiv4fvz8KbaImTgD1x5VSqaR9p8KPXDnkWp72wBUbD+bwXtzmoKS1GASNATJ86SbLpZsT4sQovykhxn9j23NuKw+miC1NNdS/EEi8yGf8oym3VVm78bYiw+CFDP1doe3Vw1KrJTacjv7PiqRhGT1XQMImZg9BUPLE96QosvG3kHFJS3oDBa/hEJ+PCO5rEGi4K77gji7A1MNPATAVJHhya+uej6sol9ANcVxLKGVV86QsbRG+P2UNfdXDx9jjRRAWRyGZEtxvt+XH9BPQ5AE7mCCGab4GS88w10cwS4PFXPkFgWevhzwmJbtXt8fM2W0Xoz/lVOJ9Rg756w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=603t3P573ZWa/VKVkNwvD53sL9teFLd7rV4/xyIHSIk=;
 b=cUnR2EJK1fRscInpZFptn3CEr6GMhPavvNx972iOKhDLEuTHQllVufBK7MD2G4ntUbLEVXMudz/yjGrssnctuV2C+zp0BSt4rCE7udK+8v418+k2GsCBrBDZu/5ooKhFGIeJYud6QMBPYUcwlj2KnHdTjFHMfMaJ3IoQs0X/9yXWyH4VJqY1sdJWLvWNVifbUPzhPCh+mEA7FosY7HUuB+zqTjE0T0rCyKJUuGRaEzjIiG8YZQT4tqhdEAXxkUDD1lgSLW9cPA/Ut8bO/zfT83+X0dowbskpVsh78DO+VQszNrNrwYTgU2nwWtn6NLA6OnIhYDvign5baI8Ub0Vxcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=603t3P573ZWa/VKVkNwvD53sL9teFLd7rV4/xyIHSIk=;
 b=u0UsH0zwIvM+EBNSOyFzJhdU9CuVM/L03MGJX0p8ZV3QUJz2IqJlxpphpmX+LoLfejsOxbwQog3hfhxMKJLZdRebf12v5M9z4vx2OzdFeJiMxIw+9hcq02bTIg92Fs0/ISUMtRynU3gp3sehJc4T5Z3BigaIXK6fD2e4IkQwf2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CY4PR12MB1861.namprd12.prod.outlook.com (2603:10b6:903:11e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 13:55:38 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::192:5346:4ece:7ca3]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::192:5346:4ece:7ca3%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 13:55:38 +0000
Message-ID: <a6c477ff-2122-6e10-1ea0-77285af4f3c1@amd.com>
Date: Tue, 8 Mar 2022 08:55:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/amd/display: fix dp kvm can't light up
Content-Language: en-US
To: Tianci Yin <tianci.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220308065006.164101-1-tianci.yin@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220308065006.164101-1-tianci.yin@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::7) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 846e9fb4-ca1d-43b4-b43d-08da010b5323
X-MS-TrafficTypeDiagnostic: CY4PR12MB1861:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1861475E5B22A95A6B0B40868C099@CY4PR12MB1861.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yudFxRcEPYF5dc6c9CNQi9lqtIZ+H5RMBnMp6NgNEJ5EdhhG96qFM5nutDMW5Sj6yGWIVwJ8FVVy7g12DlCe/EAcq0gUlwqt7SK4hAnBfcJlvUTPynNjgwPAT82TiIutOHoi9OOU1KeoBbq6YAZencDQXKhKJbEHPbAy22gd0971/m5CrfzT2Hs1dhpKTylEfNzkAYWbIdjIWlRZAg9eWMXGL0Kb/zuOZz8BjGmWnfpR64SVLvYEsV6L8pgevL2qOXjV+sZMOjwxCzeYxyMeIk8QvZNw10yfc6WHxTWvdwRqKYYus0tQHcDB9+vcdGczPqvFY8CidcbGFLBRHYq767hp0s+7czOyMwZ551GchNrxskcpkN681Z0+Gkrnzr9womCFVMUzScyvTU0u+xOtnFpAxzVe6bfdyEakKZHMwbzneN+H1q90a8sHC+qeJYKJk390YJ2oOoBLKRr0A0I07S8esFBNkzdnlqOldTyyCxfv6eau7vlrcb+PSoyggFsYjajJ5HEs0RjICmT7BX/L7LrxmAOl2bEXG7iKWhAQu2RsEWxOccvrm2rRWwMBc8PaHmyCEpu5kCFduHqHKJz7fH7rIvLnznaIUaOjDxX063D4yWsAOUPANGaxHWqoPjDCzj/7NvMOg9b0zYLaBKPDXcR08IKVbV4l0NhlOvZQyOMYt3vfmT9Rm4/4bcHlaZug2ZugwAuMpwWRvnZ2OajfjJc27UHFcLbwq6YK35NO5YbyvHaBkl+WgDOb4QePJsFC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(66946007)(44832011)(316002)(6512007)(5660300002)(8936002)(54906003)(26005)(508600001)(66476007)(4326008)(86362001)(186003)(31696002)(6486002)(8676002)(6666004)(36756003)(53546011)(38100700002)(6506007)(2906002)(83380400001)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3ZQTkRBRHlsbjczeGFkRHRlSml2Z2FYaVpKZmVYak5kem84cXpGdUgyM1d6?=
 =?utf-8?B?WnRiUkZuV0FmVjBJb1JkbnVPcDV2eFBqSFNweEM2aFJJK2taR0FGVEJxZWdJ?=
 =?utf-8?B?OTRpRG0xbkNTSkNNVXNDUEtjS2lRZGhBM2ZuTWwxNVdNV01jQ203MEI0bFc1?=
 =?utf-8?B?ZVVyTjVkaXFJeGQvU290MmR3dE9KdWhYWW9xSEUvVHdDcmZOVFl2aGRnWEZS?=
 =?utf-8?B?OVFWSnFxRGxyQlZrK0RISHFFS2Q4eVJrNGVyWTUwVnF1c2tYY25keTU4dkMv?=
 =?utf-8?B?UW40em9FUFI5V1VmaEdNZ2habXI1NU41NUtZbXBnaWNoeUJEa0xmNnc2RVJ5?=
 =?utf-8?B?RnVtOHAxeE0yYjB5WmhaRlNNZFhmOHErYXU4Y2lQT0Z6UDNxTnQvMHVHRnhD?=
 =?utf-8?B?NmhHYjdHcUU4MXNSOWtMMjI1NEVpK0RKRmFuL0tYM2k0a3lJRHd1U2FLWnhY?=
 =?utf-8?B?RWJGQkVGcVNWUS9vamx3U1dEZnRBWUUxQXBGK3hWdWE5MWg3SDd6dno4ZHJF?=
 =?utf-8?B?R3ZvRlE3S0tLaDJYV2FSZ1Q5RVYzd1VrTzJMMjJZN1lEbnoydUphUG1XN1No?=
 =?utf-8?B?eVlRYm44RjV3QmI1cE41b2pQVEFSeDhVZnZISnJXMzdvSjVMWXV6NncxZ25u?=
 =?utf-8?B?aGYrTnlyRGRsNnR1Y0ZZZ0tES1d0TW53bVU1TW5XaUNyVDVEQ2ZHKzVIbVp1?=
 =?utf-8?B?bGZXQm9FYmlqWGlnOWlIaFJKbUZSY3dnRmlOajZpZGV0N05kN1ZKbG92RDgz?=
 =?utf-8?B?SHZ6Qm1IRDUyM3RQT0tNMlJyQ2RwV3ZPL3hQc0E1NVJZOUtTZE5VY1pSeWlr?=
 =?utf-8?B?YWV6Q3AzekEwak1kYWVYd0FCLy9YN2tjVFRRNEU5WlNiZ2JQMzgxRHZhQTkz?=
 =?utf-8?B?Zzg3NThsM3poQjdWTmdyK29MbCtoUy9VNmx4M0VHWHVYWDdOMlV5S2FhNVRv?=
 =?utf-8?B?OVZ4a29QbWUwQnJVSGdQVjBBK1puYTRwMVJFeXE2L1hPOHdyTkcvclRwNW9o?=
 =?utf-8?B?K1BrRmh0WWRmUWpPcUREV3ZZMXcxYjR3d2wvV3lKSi9SWDFlUk14SkYydVNP?=
 =?utf-8?B?VzU5M1UrSVFmdFRueWhGOStwbkZsUEVKU0NreDJBazgwKzlKdDJvdjcvbW5i?=
 =?utf-8?B?NUVOdW1sQU1yQ283ZE01MXNtc2IxeXZEU0E2YVpXc0ozNThvdlNTbGduWThZ?=
 =?utf-8?B?SHUzWlB2M0plazRtVmU5UkpwTkY4cWJFVGtTL2Q3TEhRRjQrOUNCWXpnSVdR?=
 =?utf-8?B?aEkveklCbmhGQkZ0bjJCT2FNNnBpMHRyekllYUZVL1c0emZPZmR4S0lWemFZ?=
 =?utf-8?B?ekhnY3NiT0NTc1BTOTRreThxK3FzelFyb1pHYjBvaFdWVWhwc05VOEdXL2Fp?=
 =?utf-8?B?ZUh0bWFNYTBsSXQ3Wks2L00wOVJzSVE3bld5MEJqaXAzTFBpUW1QeWE5VGIy?=
 =?utf-8?B?dkhZUEoxZ2wrems2aXowQnhic3dvZk1OZWpmUkVWZi9ZZkFQYWJMLzU3MDFz?=
 =?utf-8?B?OU9PYTVXaXIzbVV4czY1S0x6dWZVVloxRzA0Z1MyYUpQdU5PV3M2OHVDQXpL?=
 =?utf-8?B?WnAzcUE0aHIrS2FDVWIvdEZkeFNEWTNRbitFY2N0eTRkamRpLzFlOWdjYUov?=
 =?utf-8?B?RjNPS2dNQzJ4VitIdUlqNFJOWDVpVFloWXZRNEtpUVFmY1FvT3pGZ3VuOTBz?=
 =?utf-8?B?SWVCSDBFSzFpQ0U5ZURCT1RjbVpmYUdBc0xNZG5oYjhXSFc5bnFKa2RoV3Q3?=
 =?utf-8?B?UjIyaUxLa1puREh6UlQ5NVVnWjF2NGkxOVpVOXduQ3BqWFdvd0l1OUlYV1Bn?=
 =?utf-8?B?MnBXVW13YWduaHAxZk1FVFpRWjF2ZVFCaGpQRHRrVmpUckdieVArZTF3Q3Rx?=
 =?utf-8?B?dGg3MkpZTjhzMWFJaFMrdFBGanluNWRQYmMzYkVaWnh4NnNSWjY4d0owUW5O?=
 =?utf-8?B?b0R2K0N5dXZ2eDk2akQ4Yk9hbC9BcnBxY1hxTVByYllqSHFUeUxGWUR4WjYz?=
 =?utf-8?B?eFFBTWx4UzBYYWFNdmdGejdLSnVSUVhZdnAwZ3AvSDJlTi80WTV1YmxyUTQz?=
 =?utf-8?B?blRRYUZmVEduNGZSeHhsK1U4dTBRVFdnM1JZdnhvbWlUL0Y5SWtQMDRXSksz?=
 =?utf-8?B?N1k0QjIwcFpLZUNzQXVadzFVUUFpV0tsUUxXTUdFaUNCUHhtM2NxazJ0UDJu?=
 =?utf-8?Q?DPbUoEetz6vCZ+yQhJsGrwE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846e9fb4-ca1d-43b4-b43d-08da010b5323
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 13:55:38.0913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCjKHjsiydasTGDLZvMzPq/aKjVdWQVhpSPHUhgQipB4V6+PmSeD426lP3bhgvUzfTbDbB7rlBuqQpiVpXa/LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1861
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
Cc: Wang Yu <yu.wang4@amd.com>, Zhuo Qingqing <qingqing.zhuo@amd.com>,
 Liu Wenjing <wenjing.liu@amd.com>, Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-03-08 01:50, Tianci Yin wrote:
> From: "Tianci.Yin" <tianci.yin@amd.com>
> 
> [why]
> The DP KVM failed to light up, since the lttpr_mode is not reset to
> default value when failed to read LTTPR capabilities, and the
> variable max_link_rate retains a initial value zero, this cause variable
> link_rate be assigned to an error value zero, consquently pixel_clock
> get wrong value zero, and kvm can't light up.
> 
> [how]
> Reset lttpr_mode to default value when failed to read LTTPR
> capabilities, so that the link_rate fallbacks to the minimum rate that
> supported by link encoder and sink.
> 
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 5688b15ca9e6..f9ae06103241 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -5101,6 +5101,7 @@ bool dp_retrieve_lttpr_cap(struct dc_link *link)
>  				sizeof(lttpr_dpcd_data));
>  		if (status != DC_OK) {
>  			DC_LOG_DP2("%s: Read LTTPR caps data failed.\n", __func__);
> +			link->lttpr_mode = LTTPR_MODE_NON_LTTPR;
>  			return false;
>  		}
>  


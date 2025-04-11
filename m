Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBA6C36010
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 16:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB47310EC37;
	Fri, 11 Apr 2025 16:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F0IZL7yj";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82DD410EC37
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 16:54:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P089R5QtaOp/dco9XRRUJQPV0HK/fnGLd49ncDNa+f4rUaLrIa7eDPibY35wPNul+NWHLuGcrX68kIMztb9Fxzn246ijOHhjc8D0OGKuTiROUzZCxPdZEbQnNgOL3kKvvvpW+hHyU3PpT8KZTgoknSNGiNBMWWTfhRQJjN5HbI7CRJjZPRk18XbrJjErr+aLlfYbPnMmowKuaBFyqy4ayClcPFjP2q7N4Jq9eYaQ3IzGaRD9aCG+phwGaHCsxGXJe+tzVgTmkRfelEk5ot+FaoSwcM/IXEC3vsv0YIKtMjl81OQ6wqSVKixgaxr4eaAwfi1BREaL08F44QpA9D/zOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kV2miI5OGx22ZruGgg0AYX8VrhFKWtfXKlfxqtYCM5o=;
 b=UB/b2rN3jaeACyoToHSIhCsndOf1g1Pj39SLxqNw4eWuDL5Sl2+yaJSWjFcD/03QGjlH25ZJXvH/pSmvnATqJy+rqIEyMRAw93pZfSFVswMLZjZO+VJL1BTL1H4k0vgYDRO1rDRgOptLqUkGqlXRKXBQuQDMC6XQ8UGt/tIVbcaYp/Zu5tqaNZ3MWjcaRY+GFEQzs762L6seBiYLU4BY0ej9/YSnpe9DpTUrrw6cOTnTmRs69sIxFsBJQIpolwr8L1IVsynky32G11UjaMZpZwh573/UqEMlZZ001cRJM9TpHpkAOC8r/O/8bSgGSjNYXgxJuh3eKKLcI+J8RSG8yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kV2miI5OGx22ZruGgg0AYX8VrhFKWtfXKlfxqtYCM5o=;
 b=F0IZL7yjwnlrZLIViyaXniBTrB6qPV0hRcasxB7FuVoxtiLeAoGo5tbH7+grG8gSGmtzVM3H4QMqa/oU+1uqugvdj7+V/FkfVg3kgy7QgfoHMftvGx9D+b/9drAsJz8acq5gJwiGQPs1rCW8y42fMJNaHQzhujTMpHB9c3CW3nU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10)
 by CYYPR12MB8869.namprd12.prod.outlook.com (2603:10b6:930:bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Fri, 11 Apr
 2025 16:54:27 +0000
Received: from LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec]) by LV2PR12MB5776.namprd12.prod.outlook.com
 ([fe80::6628:31a5:4bbe:ffec%3]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 16:54:27 +0000
Message-ID: <0967c954-1f37-422b-8d0e-2379083c566b@amd.com>
Date: Fri, 11 Apr 2025 22:24:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] drm/amdgpu/user: add priorty to user queue structure
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250410185402.2352109-1-alexander.deucher@amd.com>
 <20250410185402.2352109-5-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250410185402.2352109-5-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::32) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_|CYYPR12MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: d4fa4bfa-e7cf-472d-795e-08dd79198511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVk4SWlVa080MVpwK04yOWVhUG16Mmd0aTNyNXMwN3VVYm8wbnJmVEFCRHN4?=
 =?utf-8?B?bk5ramdsVTZ0K2JBTTU1NnJ3Z21XbENFb28rWnpVWVBRaHkyNTRoSGdHSU1H?=
 =?utf-8?B?cXlLWW9hOHVPeG5IQzRidy8rcjlTL2FVcy9xczE1K2pMakt6VmFTbmFZb2R2?=
 =?utf-8?B?aVYxY2FPeld3OXNxK2RpLzFYMnUza2hNR0VsYTNkR0Q0elUyWTJOUWU4dUdE?=
 =?utf-8?B?NEFhN3drY0NMYmxkTCtqUGNrcHg0MFRTUkFlVGVnVUpIei9tNFVEaWhmeEp3?=
 =?utf-8?B?blVSMUMzQXU5Zko4MDFaUi9tWGtzVmhsWlliQXRTZ3lHZDI3VjA3QTNIT1Vn?=
 =?utf-8?B?NEc5RDRjZzBNdXdWR01EaVpBODhXMUxDb3BZMnNTczE0eDNwSmJxMld6N3NW?=
 =?utf-8?B?R2F6MFpzZ2pWUGl6UU5vRWVqTXMwYWowcTlsYWlhZE9QU0pqMmgrTTBTcjN0?=
 =?utf-8?B?WmJoWTNJbTFBaE5uMkVoNjB6eTFKeGFQdjI0V05VMGhyYlZ0TEpDUGcySVEv?=
 =?utf-8?B?Y1djTit4aUk0eW1oWjFrVHpLWGY4dCtDNTFzdXJuOURGK3FxTVFJMmFIWUli?=
 =?utf-8?B?dEFIbFE2UFo3NE5Vb0JQUXJ6eXI5Q1d0NXE1dzhqejI3R2w0Ulg3V01abm1a?=
 =?utf-8?B?bGlxa2hxTkwvcTRIWHdmc25ScHFYdXVNeHJRRGZLa1dJcjU4V290WXJEN0Rj?=
 =?utf-8?B?dFB3QlFmR2MyekJOYllEVE5vcTh2STV5MjllRkU2OGxOekVnTjl1akQ2YytX?=
 =?utf-8?B?K2RNaW5wU2lqSnZFc2tYQytHckxEMHk4dU0yNStZWmx3T1RvVnVweTNsbGFT?=
 =?utf-8?B?UVFTVU5pZFlwTUFWNFYveWxvemcrRW9xd05MaXhzTmZHWk1HeWxHM1RPUmcw?=
 =?utf-8?B?Zk9VQW5EUWNqZSswcURENk52Q0J3RW5MaTF0R3lDQWZtOXc2TWZJaTByLzBO?=
 =?utf-8?B?cDNGRGNXR1B4K3pMN2MrZkhsQ3pVS2hXT2ticmswZzAxakhFTjE4VGFrZVBi?=
 =?utf-8?B?ZlQ2OHpDLzJGRllGcGQxUWl4NWtqaFYyMGhBcjZFVEh1ek9pdXlER3VyUXdk?=
 =?utf-8?B?SmV3aXZUaTJvOVF2RklYaDRlbWpEUnBqdXpBMHZleEhaN2ZWSndJckcvVHhr?=
 =?utf-8?B?R1pRd0haRjFCblBwZk9OQzF5ZkZRZ2JzVkVCSmh3QzF1RVMraDdOT3VxakYz?=
 =?utf-8?B?RU8wNDJzaHhGb3FLRzdCZTFQb3VnUnBOd2VDSWVBSFhaMUZGTHlMQlZ6ZVR4?=
 =?utf-8?B?RkU5WUQwVWlXeWRnU0x4U1FwdzBHTzRJNlJxRWJ1VS91UzBuVmc0RXBnZFBC?=
 =?utf-8?B?NGxvekZDc3B1RFl5Nm1Ja2pYdklyOE96ZFNkMzFOa3NaQ2piNHN3MzhMRGlm?=
 =?utf-8?B?Yit5NnR4U0dZM3I0c3B0SDJXYStoak9XM1pwYndlMTFraklabzN1MXZSa0Fa?=
 =?utf-8?B?d3RuZERkMGxXOTJnSk95a21YcU5LVFZVTXNUQ211d0VyckwvWkpBREVxRXdM?=
 =?utf-8?B?RGFSZHhoeUdzMXpSQXlORk9Xc0duTWxzWXNmTDRQL1pNbDcySGZoRFZScUlr?=
 =?utf-8?B?Y1lwL0g3UURpYVFCMHk2RldaeTVxbm5ZZ1hUV3FnVXZ5S1U0dThpdkZBTzlj?=
 =?utf-8?B?d2wvb3hmOWx3U2NHMXNPeUx2UzhKc3lIdjM2a0pnRnpxWGlPN3JpRkJ1Q0t6?=
 =?utf-8?B?T05PSDZyUnY1eDNlcjlPSjUxUmd1SW9iUkVZZDBGVHlhcnpJeG5aaEcrVmll?=
 =?utf-8?B?SFBsWXNYU0lFK2g2MWYzSm9CeWpGNGtnUHhxd25XY0Y4TGFLYTZGZE5hNGJO?=
 =?utf-8?B?RGwrTlhkdFRoOWRLYXhBdWVQNVZIUkNVOFJrUExvdEswWVVyYnpUcUNZdmlH?=
 =?utf-8?B?RjlHclpLOGxVUnBQZ1g3SVFVaEs1Nnd6aUhTUkRORmpab3diTGFMc0ZUUjh2?=
 =?utf-8?Q?fuecrlytOBk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5776.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHlCTjh0YXFha0RheTUvZDJjOFYxL2VZRXZTdlJaVEdVbUR3NUN6dkxqOENr?=
 =?utf-8?B?SmF2R0VlZDdBQXhRMmZnL21McjFVS1NmV2lQN1l0SXF6STVFRGNuSVpvWDYw?=
 =?utf-8?B?eEsySVNZOEt0eVN2dDlxcjZGQ0ROU1YxRFhXaUdqaE9Yb0RRYUZ6R2txRGtZ?=
 =?utf-8?B?Sk5xYmhCeUc5ekJsWHdIc29TYmdXQWN4U2tOQml6WDVCVkx3WW1VK1NmRkdC?=
 =?utf-8?B?YmNGcHdPZUNFaWE4VXpTbVdNcE92dStvSGhjZTdtRExTdGR0R2FxYWFXS2di?=
 =?utf-8?B?d0FhVlJHeVFDdVlid0NUVlBYb2c0Qnd3ZU9vcjNpTjdISkYwbisvenFtenhU?=
 =?utf-8?B?cHd3ZkRxeTU2NkZyT2ZsWXc2VXZWUmhxK2pLcDNTY0EvenlvaGJhRUZHUHRU?=
 =?utf-8?B?RlMyV1ZsU2VrQUJDZS8zTEp5SU5YMm9vUzI3amFwSGNuekZOSGgxTzVqd01t?=
 =?utf-8?B?TlJseTY2MFFUYlNNZ1g3TGJBZ09DWHV3bEFkbER6T0kvNnpaTUU3YUN2VThZ?=
 =?utf-8?B?ZzNTakNxWjMyRnZzUEZSWHl0SUp1YmE5andNajIwRVlSNzB2VE94SW1LR1hS?=
 =?utf-8?B?SGMrWTRmL1dCMWxTNng2cVoyL0JDMkdSUGh6c3k1WnFWZUlLdU5hb3pMeFYz?=
 =?utf-8?B?NUIybXdLbEV5enM0amdvQ3IrYzJBaHJzeGc1SmN6WG05YjMvbUw0TnQzZFY2?=
 =?utf-8?B?bUJ3UWIrdUVxaHhkdjN3VFZ4MGp6alF4U1Z1dEtOMFg5aUhTNTRVcHZRWk9p?=
 =?utf-8?B?ZFB0cHZaKzFmTjlyL3c4MzhNemNzckFDVkprUG9wdmtlbzZqUzNORGRPMXlz?=
 =?utf-8?B?U1lCZHhoM01oRnZiVGxhcTVkT3hqMlV5Q0JCdnBaNnJVNzZMSXUzeU5GMG51?=
 =?utf-8?B?QkIrenRBRGdZQTdTWDg4L2IvM0Zhejd4bG90WFliSWJhcjBpRkh4UGx3aWs2?=
 =?utf-8?B?cDBTTzdXMVJKSytPZkx3b05vT1J3Z0Y4Tk5rTklqMnNiVjMrN3BlYTRta1VU?=
 =?utf-8?B?V05SNE5PMndGVVI2Q1lxcEp3UVUvcnJycENzV1pIeDVLMmZuRndOY3VkdEdS?=
 =?utf-8?B?T2ZxYUZjQlFqSG9VczJ2aDNkK2Zad2lWV0QxbGpYaXQ3SXByVWhCZmQrMmgw?=
 =?utf-8?B?RC9hTFM4TWRDUEp4TlRaNzMzTExPbWtPQnRQU0hRSmx6OU9NNndKV3FLcU5T?=
 =?utf-8?B?MTM0cGtkNDlNWFFrNWx2MEhOejZ3TDd2bm1TTEJOb0xYWktVM3M0bFk2OWg2?=
 =?utf-8?B?QnZScXVSdXNTc2xOZ0RSUStKVFk0NDdVbFFYanRMb1lKc3NvZ3NMVVFpVHF4?=
 =?utf-8?B?YUNyT0ExNnBxd3JBQlorK2JiTmljMnhPMHFtVS9lWGhqS09DME1pRXBkdEJ5?=
 =?utf-8?B?YmhjVVNjRmhZcjVVZUJQT2Y4UEFKNjNFSXpZWkdWN0N6TG11VElFY1pVanZS?=
 =?utf-8?B?S3ViS00vQ0lrNFN3cXdxUG1JOXV1UTB6by9pdGdEeUY0M1IwQXozMGFsOGRU?=
 =?utf-8?B?SkNGQ1B4T09BRXhRb3ladEdJUmRFYkQ1TDhKU3N6bzNxTy8xaVZWTzBzNERl?=
 =?utf-8?B?MVIxakQzYk1MV21nS0tENGIvTnZLRlBESTBpZWhITzdNeVZVNHdMMFZEMDNK?=
 =?utf-8?B?QmtnZzF6aVUyU0dEUkEzamJ2YmQxcjVhU1lIYkw5RkFrUHBZM3ZOcGdJc1dI?=
 =?utf-8?B?b1ZaTWY1blM3RjU3NS9Cc0ZsRnY5YjBmb3VZOEpXeUFlSGJoS3o0cE9jTVUv?=
 =?utf-8?B?M2xyQjhXVnVLSjNnZVJYeUcwak1ZUnNnUk56bTloUXhJZ1hpL3V4MmY1YTlB?=
 =?utf-8?B?S2oxOHo2YkhnSm8zYzZ0WE00WjY2VlJtcG9CRklUQnNqSjlGUzhPUjNKM0RB?=
 =?utf-8?B?NHZ0d29VcE8wVVFWZzN0SmZoMElydkIzWEZGVXpNREZnYSs1VldpbTdnVmdD?=
 =?utf-8?B?alEvbXVLTk5KRVhrajVubDlBQ29XQTdjU0Jmd2FuQk1Ic3dEaW1DeHZEdHZ2?=
 =?utf-8?B?cDBHRUJpVS9rZEwrT2ptQUovWUtMRkNFQWRmUXQ5bkFUTVNyTTlEWXVweVRS?=
 =?utf-8?B?aUJFZ3NnN2k5VUFkb3dMempBM3hRWGNTQ0xCSVMrL0NwNVY4a2JINElpcnlt?=
 =?utf-8?Q?JOJdUbIC+mz9ciJvzugZmcGBz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fa4bfa-e7cf-472d-795e-08dd79198511
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 16:54:27.3975 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zoy0EciMW7l997/SaztT3hwxGAqQMOTSJNftKWwG4L9XeqDohNn39Dk3PB5DaELaCIABHo2/hSjoCN41sz+oPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8869
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

On 4/11/2025 12:23 AM, Alex Deucher wrote:
> So we can track this when we create user queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> index fd0542f60433b..e0bc45e36dbc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> @@ -56,6 +56,7 @@ struct amdgpu_usermode_queue {
>   	struct xarray		fence_drv_xa;
>   	struct amdgpu_userq_fence_driver *fence_drv;
>   	struct dma_fence	*last_fence;
> +	int			priority;
>   };
>   
>   struct amdgpu_userq_funcs {

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23568ECAAA1
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 16:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DA9810EC9F;
	Fri,  9 Sep 2022 16:47:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1821310E0BE
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 16:47:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGR/5f/wmagfgKAkmfRIzOnwmvnVmcnq/NKoRrYY5EzmqrjTuRqnK4jaxRByX/jHd4KgjzYwaHqTtu1s1U6Qon5ZsghSOPFWceVvr17goF64hkto5jmXgiY2dlVwjwQR1DU37kfw8LrzSUP8r/eOp/rPh84L27CaOn7qQZo0qdE7qe1PUPCwBiIOgvYx+rqFomM10OFAxs4m7ACqotiI2FEPsF0Xb8bgafKYFBGeSBl/jCSqQyxz2nCrCJ+5qoS6+GDjFhFPUJgUYzTfl1PWE/v4nN3FPSZ+xOvEL9jTtKwvG5EFjd1DEpP3nmUaJSR61USYySSR+YnsQYT3o1YC3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H66wIOOdHR6ZoA5DwGV6SDRFHGkwWR6+ajEMyqLlE8M=;
 b=hb4zYhFwAaxMqvxomf8Irn6CWPfR46A52fsq+W1NiChZIXq/4VUpMvgMhvkAPEBHFR0WakMAAUBIzuEMADoujSNrwUbCi2VjCyEUmTRrWaFn/dXTuX2aCQx9ISqJk2Dcy14hHhrfa8jr6/O0zahB7ojvul+Gw9Cbva0rfLhEv7+dBFfq8fMrL160e7+gCvjOc5uXzh6HhQCkPY0pw/yNMvqYdOfWbhMqsYQj4mzUH9+b6MffCrt+iADZo+i8Fq2mTnqx+eZScdNR4VWnTG7O+Xb5VG9r+odXybgH1GZfj1e/liCczthMZwy3SDm0sxizDfY7Yo8A0LhzL8whfyJ1bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H66wIOOdHR6ZoA5DwGV6SDRFHGkwWR6+ajEMyqLlE8M=;
 b=t0tDsTGFN0T5XHgHaZUZyxkBcxREYG1b/XnffV+/jbmJcVPn6n3QPs8m5r6G5RNTUBvjsLvE3L8jD39vp7yjKymTws84Qz/dSshGDoqeCm449XDnuOyK/VfSoTEaX6KAetKSiK07hdBtvs5jENth7qLDqkmvaXqUPf4/0u5ptuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by CY8PR12MB7635.namprd12.prod.outlook.com (2603:10b6:930:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Fri, 9 Sep
 2022 16:46:58 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::80ca:c97:d395:1acf]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::80ca:c97:d395:1acf%6]) with mapi id 15.20.5612.016; Fri, 9 Sep 2022
 16:46:58 +0000
Message-ID: <788d0894-3bca-de61-de5e-5a2d5c903fd0@amd.com>
Date: Fri, 9 Sep 2022 12:46:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/4] drm/amdgpu: Add software ring callbacks for gfx9(v3)
Content-Language: en-US
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20220909015022.557099-1-jiadong.zhu@amd.com>
 <20220909015022.557099-2-jiadong.zhu@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220909015022.557099-2-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::35) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB1947:EE_|CY8PR12MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: dd1e4704-1e31-46a0-40fa-08da9282e91a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G7OoGcMRbozVBWukOfGKMtgg5trnrmiSpOBHDAl0/5qVGsCub16v1pCXiVQZ/AxFheBahJH0bmYP7GJQjBHhCCFO7T5s+bXObKhukV5KQVfWgNj3Q1gBfhI0ETdPxZ4kbMtGrk7hITGCWEwKnvlINlM2V9FoCH362eJCpy/8L1urMB3Juzd9gX0RzSXYkRvwsVS/TRfQMRnXvIrRgWfRlDNKTFhB7thIxwqpaxHeei3lU96eGOQHf70vRTSsj1eC9S7YbTnsiqIepI0juCUxaogYeaOG7rtcbngu2ybZexkBh7lw5/7w7U+QgQnXkDuluqjq/JnB0dIVl11dT1LEdLXWse0yf4qxbZVi6yR4jJfu26v+bxBu4YgxoSLL1JFA6lvQAeMuoWha9EsG4lMluAQlXKiiP7YCxQTznWUpqbOzSd9HDvcNOsRCLp42dODldQsEROi8vDhWlX4Bnq/523/pyibfgSvGqztEro0JRNo214Y5b9h/fX33tNZmeYQ/BEQp1evpjWYgtbBjpYPTLpwioRD9T4ICh03fulI+And8LwWrXYeFtUzQbOnuPPYOfEUxF4LM+lLsi4d1l90hcaeytOT6GcPptr7IL8ZppVJr+U1plqJSDGHEZG+UXQUxC33m9rgr05V0nAGH6HNAYtTUGTvH7SCvHfmydFt2oN77ZssNeawoArsTgqjjzT2DuLKHfwGKIiriQfqJoD2KH27dkkwfBuubwt7vLoc07dnGObBSwqvAF0uyfrcNvNa/tlyvmCo+qZpo1jIAqA3gQG9sHAoHfdpjmMaYhmGbuVM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(36756003)(186003)(2616005)(53546011)(86362001)(44832011)(5660300002)(30864003)(6486002)(31696002)(478600001)(6506007)(41300700001)(31686004)(6512007)(8936002)(83380400001)(38100700002)(316002)(2906002)(8676002)(66476007)(66556008)(66946007)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG9FeHV2SXVFVnBIb21xdWRTL1ZZd0hyVlZzakNyRnp4ek5oa0RIblNDTzdo?=
 =?utf-8?B?QUhlV2dFQlp5cGx2ZGNmQjJJMjM4MHljVnptZFlCUmdKdzJhRmVNYTZSRm5Q?=
 =?utf-8?B?QlJvY20yTXJwa3FuODVGTXF2OGhldlF6RjE3SzJSeXRwWElFNXRoL2ZtWU9N?=
 =?utf-8?B?d3Q3bThrRkpyR1VQeUNVc2tSRTZLZndhY3hHeXd2UUJPY1l1eTdjdkpnNFFl?=
 =?utf-8?B?ZFF6WEtmNFg2YXJTam5HY2xZL2NXR2IvL3JyQ3BvRVZiZ1hSNytOSm85ZWc4?=
 =?utf-8?B?TVBEOHlXN21ZSE1XeGF3MEJxMXlXT2E2OHREUy8wQWhsRUlWQlNUTCt4NDVt?=
 =?utf-8?B?bklrOUpXMkNZQTJ3eHpEUkJaaWVkaVc0VW5oaXFvNHRmek9NTFNMNk45WGpL?=
 =?utf-8?B?SEE4dkxpUU5sOHM5MUwzN1A1dnJMRDFHN0hoV0ozSTZKQmNQU0loTlFKM0xn?=
 =?utf-8?B?VVByWThyWld3dXowVjRQMnZoZENDVHhhbHdvaTFYVitrV2NHL3IwbGREL2xn?=
 =?utf-8?B?RXgyUGRzKy9seGVYMTdkWU95Zkw1ZUZqSGl1YXZrY3F3OTI3Sjh4U3VEdEZu?=
 =?utf-8?B?clhLOFdYUWZ6Q3ZWeFo3NGNPSzVQZTlHQ3p3WEowOGpoT2pjTEZzcU5tZmNy?=
 =?utf-8?B?RHBQZ1lyanAyakpaRytNdFhqenpjSVB0S2hKdGMzNWNGYm1rN2dXdE9pSUhZ?=
 =?utf-8?B?UEFOWDlnVEgwRTd6aWoyMnBuYUNxdkNqSWdSSUI2ZWVleUh2aU5lZ1lJT2t2?=
 =?utf-8?B?NElrNDQzMDlyM3MwbzBEYldMekVndDI2NVA1L0llTTBjWGdNR0NhK0s3TkV3?=
 =?utf-8?B?ajM4azZMVzlFZ240aSs1a0E1YTNIN1NITkdYMVZaNGUrd0YxMzFoODAxTXJk?=
 =?utf-8?B?a2ZMdnhIMmxGTTJzeHdmWHZnWDhLY1d6Rjd4ZEU0T0pCeG03SWFvQzFjOGhr?=
 =?utf-8?B?RDVqSEpzS245U0VUVEx4NGlmaXJjVFB0cEduSUhXMTRMS1dwSWs5RGZqMHZy?=
 =?utf-8?B?WG1CMmNyc1BoenBDVUVNVndGYUpOUjhUQVh0dDVtMU41R1JRQWJaOHZRaGNK?=
 =?utf-8?B?eU52M1k5NHltejQyS2p5YWFnUDNabHY4UTdWQzdTcnFXSmFUcHB4eThFbWc5?=
 =?utf-8?B?a3A5Z3owRnlRSDJ2ZW1NOTBmMVJIcTQrbWloL2RDM1V1OHFHUmZMSk9HVjg1?=
 =?utf-8?B?VGxBZXpWei8zUGw4eXgyWnBWOUpPcDdocTBKN29YUVpBRFZ0dnlmcTdWWXBt?=
 =?utf-8?B?S255RGdlRGgvTmFlSFpaVzNJeUpKRDZ0cEpmVUI4VXhPcDY1ZTI2UG5sQm1u?=
 =?utf-8?B?WlN0WGZ0RlYyOE1lbitVWGZmODBsTk9aN0M5Z0RCYkRQb3dWSkNNejJFODhm?=
 =?utf-8?B?OTlMMzgrSTE2aW5MWEJtZUVHUnlpVnQxOERSREtQNXMyVGpvTHJkLzV6bjJ0?=
 =?utf-8?B?N3FiVmpsNFM0SENUSUFPakUrSjVyVGtYc0ZtdWZwZG5vSDIrM2ZpWlNzRzBY?=
 =?utf-8?B?V2ZSeTdyV0ptaGJrcnR4SllGeFFaTkFvdWMrQjAwQThGbGZqc1J5dTBoMHR5?=
 =?utf-8?B?SFlGbDROU2k3d3pMemlPRkIrcUx1b1JKdVBkY3hMRDVtWERmMUhZQ0RTU1pC?=
 =?utf-8?B?R3RGOGMrZ1Q1K0R0ZDFGVHEzTm4ybzUvdWowSDdaby9qbjZ4OURzRVg4N1Bl?=
 =?utf-8?B?SWR2T0diTmQ1eTdUdUtMTzN3L1VvRVlETnV2MjV4NUxCQlFuTVRuaEhRcHNF?=
 =?utf-8?B?K2lmNzJnaS9scnVqUEpweEoyQndiaDl6OUM1WFBQZUJjSUNvanRLSUNuaGpm?=
 =?utf-8?B?VnpMRXB4S3d3czRqS1J5NFp2OGhFdG1ic214TlFWM1BEdG1VMS91bTExRUYx?=
 =?utf-8?B?emJjWjd6Y2tZTnR5amRsd29YcjBrNjUzcGMrY21UU3lOOVJGRmFRSHBxUzcw?=
 =?utf-8?B?RVM5bGdTc0Zuc0REck1NRC9MRzRJc1RUcEFoQlU5S1gxc28xQUxHajJ5Yk5y?=
 =?utf-8?B?Z1Zldmt2cTJQWCtZNUpRQkgzZ0RFTHZjSU1uVkI2Ni9BUXZxV1EzUytGZXlU?=
 =?utf-8?B?NEUxVyt4OXE4R3N3eWpYVDhBdTd1ZVVmSTBJcU1MdFJ4U0QyMW9ZSGUraEho?=
 =?utf-8?B?WnF4YWxhVnJ6QVBBZUIvcTVQM21pS2xxZWtzaUszZmpQanFYby92ZENLUkhy?=
 =?utf-8?Q?3JynCxGfaiZc2S8tR1xBPHi/sctjhlznB9df7IIqL88M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd1e4704-1e31-46a0-40fa-08da9282e91a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 16:46:58.1968 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLYFe4dcqXTpDt1RL9YzSNJF8FtJcJm4xRbnrssFxxAYK+prRWZNYcTCDx8DaryqHW7ELCEdlSqSrqt47sD38g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7635
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
Cc: Ray.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 2022-09-08 21:50, jiadong.zhu@amd.com wrote:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>
> Set ring functions with software ring callbacks
> on gfx9.
>
> The software ring could be tested by debugfs_test_ib
> case.
>
> v2: set sw_ring 2 to enable software ring by default.
> v3: remove the parameter for software ring enablement.
>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |   2 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  16 +++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   3 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 116 +++++++++++++++++++++--
>   5 files changed, 128 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 96d058c4cd4b..525df0b4d55f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -207,6 +207,7 @@ extern bool amdgpu_ignore_bad_page_threshold;
>   extern struct amdgpu_watchdog_timer amdgpu_watchdog_timer;
>   extern int amdgpu_async_gfx_ring;
>   extern int amdgpu_mcbp;
> +extern int amdgpu_sw_ring;
>   extern int amdgpu_discovery;
>   extern int amdgpu_mes;
>   extern int amdgpu_mes_kiq;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 0de8e3cd0f1c..5eec82014f0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -348,6 +348,8 @@ struct amdgpu_gfx {
>   
>   	bool				is_poweron;
>   
> +	/*software ring*/
> +	unsigned						num_sw_gfx_rings;
>   	struct amdgpu_ring_mux			muxer;
>   };
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 13db99d653bd..5b70a2c36d81 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -33,6 +33,7 @@
>   
>   #include <drm/amdgpu_drm.h>
>   #include "amdgpu.h"
> +#include "amdgpu_sw_ring.h"
>   #include "atom.h"
>   
>   /*
> @@ -121,6 +122,11 @@ void amdgpu_ring_commit(struct amdgpu_ring *ring)
>   {
>   	uint32_t count;
>   
> +	if (ring->is_sw_ring) {
> +		amdgpu_sw_ring_commit(ring);
> +		return;
> +	}
> +
>   	/* We pad to match fetch size */
>   	count = ring->funcs->align_mask + 1 -
>   		(ring->wptr & ring->funcs->align_mask);
> @@ -183,6 +189,11 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>   	u32 *num_sched;
>   	u32 hw_ip;
>   
> +	if (adev->gfx.num_sw_gfx_rings > 0 && ring->is_sw_ring) {
> +		return amdgpu_sw_ring_init(adev, ring, max_dw, irq_src, irq_type,
> +			hw_prio, sched_score);
> +	}
> +
>   	/* Set the hw submission limit higher for KIQ because
>   	 * it's used for a number of gfx/compute tasks by both
>   	 * KFD and KGD which may have outstanding fences and
> @@ -343,7 +354,10 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>    */
>   void amdgpu_ring_fini(struct amdgpu_ring *ring)
>   {
> -
> +	if (ring->is_sw_ring) {
> +		amdgpu_sw_ring_fini(ring);
> +		return;
> +	}
>   	/* Not to finish a ring which is not initialized */
>   	if (!(ring->adev) ||
>   	    (!ring->is_mes_queue && !(ring->adev->rings[ring->idx])))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index fe33a683bfba..ba6d8c753f7e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -38,7 +38,8 @@ struct amdgpu_vm;
>   /* max number of rings */
>   #define AMDGPU_MAX_RINGS		28
>   #define AMDGPU_MAX_HWIP_RINGS		8
> -#define AMDGPU_MAX_GFX_RINGS		2
> +/*2 software ring and 1 real ring*/
> +#define AMDGPU_MAX_GFX_RINGS		3
>   #define AMDGPU_MAX_COMPUTE_RINGS	8
>   #define AMDGPU_MAX_VCE_RINGS		3
>   #define AMDGPU_MAX_UVD_ENC_RINGS	2
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 5349ca4d19e3..774e44e1074a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -47,6 +47,7 @@
>   
>   #include "amdgpu_ras.h"
>   
> +#include "amdgpu_sw_ring.h"
>   #include "gfx_v9_4.h"
>   #include "gfx_v9_0.h"
>   #include "gfx_v9_4_2.h"
> @@ -55,7 +56,8 @@
>   #include "asic_reg/pwr/pwr_10_0_sh_mask.h"
>   #include "asic_reg/gc/gc_9_0_default.h"
>   
> -#define GFX9_NUM_GFX_RINGS     1
> +#define GFX9_NUM_GFX_RINGS     3
> +#define GFX9_NUM_SW_GFX_RINGS  2
>   #define GFX9_MEC_HPD_SIZE 4096
>   #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L
>   #define RLC_SAVE_RESTORE_ADDR_STARTING_OFFSET 0x00000000L
> @@ -2270,6 +2272,7 @@ static int gfx_v9_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>   static int gfx_v9_0_sw_init(void *handle)
>   {
>   	int i, j, k, r, ring_id;
> +	unsigned int hw_prio;
>   	struct amdgpu_ring *ring;
>   	struct amdgpu_kiq *kiq;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -2356,13 +2359,40 @@ static int gfx_v9_0_sw_init(void *handle)
>   			sprintf(ring->name, "gfx_%d", i);
>   		ring->use_doorbell = true;
>   		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
> +		ring->is_sw_ring = (adev->gfx.num_sw_gfx_rings > 1) && (i > 0);
> +
> +		if (adev->gfx.num_sw_gfx_rings > 1 && i == 2)
> +			hw_prio = AMDGPU_RING_PRIO_2;
> +		else
> +			hw_prio = AMDGPU_RING_PRIO_DEFAULT;
> +		if (adev->gfx.num_sw_gfx_rings > 0 && i == 0)
> +			ring->no_scheduler = true;
> +
>   		r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq,
>   				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
> -				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +				     hw_prio, NULL);
>   		if (r)
>   			return r;
> +
> +		if (ring->is_sw_ring)
> +			ring->wptr = 0;
>   	}
>   
> +	/*init the muxer and add sw rings */
> +	if (adev->gfx.num_sw_gfx_rings > 0) {
> +		r = amdgpu_ring_mux_init(&adev->gfx.muxer, &adev->gfx.gfx_ring[0]);
> +		if (r) {
> +			DRM_ERROR("amdgpu_ring_mux_init failed(%d)\n", r);
> +			return r;
> +		}
> +		for (i = 1; i < adev->gfx.num_gfx_rings; i++) {
> +			r = amdgpu_ring_mux_add_sw_ring(&adev->gfx.muxer, &adev->gfx.gfx_ring[i]);
> +			if (r) {
> +				DRM_ERROR("amdgpu_ring_mux_add_sw_ring failed(%d)\n", r);
> +				return r;
> +			}
> +		}
> +	}
>   	/* set up the compute queues - allocate horizontally across pipes */
>   	ring_id = 0;
>   	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
> @@ -2413,6 +2443,9 @@ static int gfx_v9_0_sw_fini(void *handle)
>   	int i;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	if (adev->gfx.num_sw_gfx_rings > 0)
> +		amdgpu_ring_mux_fini(&adev->gfx.muxer);
> +
>   	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
>   		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
>   	for (i = 0; i < adev->gfx.num_compute_rings; i++)
> @@ -4709,8 +4742,9 @@ static int gfx_v9_0_early_init(void *handle)
>   	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 1) ||
>   	    adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
>   		adev->gfx.num_gfx_rings = 0;
> -	else
> -		adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
> +
> +	adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
> +	adev->gfx.num_sw_gfx_rings = GFX9_NUM_SW_GFX_RINGS;
>   	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
>   					  AMDGPU_MAX_COMPUTE_RINGS);
>   	gfx_v9_0_set_kiq_pm4_funcs(adev);
> @@ -5877,7 +5911,11 @@ static int gfx_v9_0_eop_irq(struct amdgpu_device *adev,
>   
>   	switch (me_id) {
>   	case 0:
> -		amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
> +		if (adev->gfx.num_sw_gfx_rings > 1) {
> +			for (i = 1; i <= adev->gfx.num_sw_gfx_rings; i++)
> +				amdgpu_fence_process(&adev->gfx.gfx_ring[i]);
> +		} else
> +			amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
>   		break;
>   	case 1:
>   	case 2:
> @@ -6882,6 +6920,62 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
>   	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
>   };
>   
> +
> +static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
> +	.type = AMDGPU_RING_TYPE_GFX,
> +	.align_mask = 0xff,
> +	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
> +	.support_64bit_ptrs = true,
> +	.secure_submission_supported = true,
> +	.vmhub = AMDGPU_GFXHUB_0,
> +	.get_rptr = amdgpu_sw_ring_get_rptr_gfx,
> +	.get_wptr = amdgpu_sw_ring_get_wptr_gfx,
> +	.set_wptr = amdgpu_sw_ring_set_wptr_gfx,
> +	.emit_frame_size = /* totally 242 maximum if 16 IBs */
> +		5 +  /* COND_EXEC */
> +		7 +  /* PIPELINE_SYNC */
> +		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> +		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> +		2 + /* VM_FLUSH */
> +		8 +  /* FENCE for VM_FLUSH */
> +		20 + /* GDS switch */
> +		4 + /* double SWITCH_BUFFER,
> +		     * the first COND_EXEC jump to the place just
> +		     * prior to this double SWITCH_BUFFER
> +		     */
> +		5 + /* COND_EXEC */
> +		7 +	 /*	HDP_flush */
> +		4 +	 /*	VGT_flush */
> +		14 + /*	CE_META */
> +		31 + /*	DE_META */
> +		3 + /* CNTX_CTRL */
> +		5 + /* HDP_INVL */
> +		8 + 8 + /* FENCE x2 */
> +		2 + /* SWITCH_BUFFER */
> +		7, /* gfx_v9_0_emit_mem_sync */
> +	.emit_ib_size =	4, /* gfx_v9_0_ring_emit_ib_gfx */
> +	.emit_ib = gfx_v9_0_ring_emit_ib_gfx,
> +	.emit_fence = gfx_v9_0_ring_emit_fence,
> +	.emit_pipeline_sync = gfx_v9_0_ring_emit_pipeline_sync,
> +	.emit_vm_flush = gfx_v9_0_ring_emit_vm_flush,
> +	.emit_gds_switch = gfx_v9_0_ring_emit_gds_switch,
> +	.emit_hdp_flush = gfx_v9_0_ring_emit_hdp_flush,
> +	.test_ring = gfx_v9_0_ring_test_ring,
> +	.test_ib = gfx_v9_0_ring_test_ib,
> +	.insert_nop = amdgpu_ring_insert_nop,
> +	.pad_ib = amdgpu_ring_generic_pad_ib,
> +	.emit_switch_buffer = gfx_v9_ring_emit_sb,
> +	.emit_cntxcntl = gfx_v9_ring_emit_cntxcntl,
> +	.init_cond_exec = gfx_v9_0_ring_emit_init_cond_exec,
> +	.patch_cond_exec = gfx_v9_0_ring_emit_patch_cond_exec,
> +	.emit_frame_cntl = gfx_v9_0_ring_emit_frame_cntl,
> +	.emit_wreg = gfx_v9_0_ring_emit_wreg,
> +	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
> +	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
> +	.soft_recovery = gfx_v9_0_ring_soft_recovery,
> +	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
> +};
> +
>   static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>   	.type = AMDGPU_RING_TYPE_COMPUTE,
>   	.align_mask = 0xff,
> @@ -6956,9 +7050,15 @@ static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev)
>   
>   	adev->gfx.kiq.ring.funcs = &gfx_v9_0_ring_funcs_kiq;
>   
> -	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
> -		adev->gfx.gfx_ring[i].funcs = &gfx_v9_0_ring_funcs_gfx;
> -
> +	if (adev->gfx.num_sw_gfx_rings > 0) {
> +		//first one is the real ring
> +		adev->gfx.gfx_ring[0].funcs = &gfx_v9_0_ring_funcs_gfx;
> +		for (i = 1; i <= adev->gfx.num_sw_gfx_rings; i++)
> +			adev->gfx.gfx_ring[i].funcs = &gfx_v9_0_sw_ring_funcs_gfx;
> +	} else {
> +		for (i = 0; i < adev->gfx.num_gfx_rings; i++)
> +			adev->gfx.gfx_ring[i].funcs = &gfx_v9_0_ring_funcs_gfx;
> +	}
>   	for (i = 0; i < adev->gfx.num_compute_rings; i++)
>   		adev->gfx.compute_ring[i].funcs = &gfx_v9_0_ring_funcs_compute;
>   }

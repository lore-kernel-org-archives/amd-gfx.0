Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5500AECAAA1
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 16:45:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEF0410EC94;
	Fri,  9 Sep 2022 16:45:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7EB310E0BE
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 16:45:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjEH1PVnKJ1dTH1Bvby1kwd7nXJo9JTp23QujTZFCuJLN4PP4mEGvmfiSl/hgOxb5Az943TiLWUsqPfgUJNXTCMOIcMBHryTitHW8yfOIX4est80++kB+T1/tpL7JPQXF2HUWq6IyQFzRd4MTcc1++3DltZ625cog1jG3MmKE997VoDWJPQ16iEF8tOe0lBfvjTG/kRpJ09z1IwWCoNxYWEKr1zul+wgicKnn1KTQ1NjhVuKG5GmBHQ0WLK+vsbt2/rmOzcL7tVZq7v+hGOF2N2FuiFMnvKYJobgIa0URdNdnTO7VCjppGUfda2xlHzJEIFIglaZYJehJo/zO4cjjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7g0a8+40ZODlhqCll2i01kXzqM6exOHfCX0wbSVxHA=;
 b=HcDymFNhkVZ3Tk6OpJ+lM9fBMWbE/8hDi5JgN/qAMDaGplFJKLdbMw/yvKYsjXXgULUce7s7f90CENpCfp04dooI8PWDpi7W85NU7GNEk45du4oPfHjafKgvygCC5j9gXN5StGHT98LkTF693vby8N8eDCtMY7a9+1zrSr7Z2hDs6XKers/nTLO1Vw5o5wia0RBu4h6nRf6zmBQ9nVLk09tmFsE6iacYa37i9mWdAKECEwPPuMmyRqbvrOvZz9O+2Fupxp3RcMGd9GLiEDanvVXdiG2bKvYFNcnkLEFICwFGF1rv765ttcogmlWljsIT5xynX+6RdV4Bb77xWOrxQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7g0a8+40ZODlhqCll2i01kXzqM6exOHfCX0wbSVxHA=;
 b=YYfo6vmAKP2taLfRFxxAgh0WwIsSKaU3hxkpgJdcg03HwN9DP/737FrF7x3TS+RdwHMvrE+8qlasO/8p+UYtIN3KoVcowkTdcF4CphRjyGCekWV96b+AvtBP4PA4l+WpFDt9IZPXoVEbQHhXfwO4bllJlohyfRTVlWR0Lr/WV50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by CY8PR12MB7635.namprd12.prod.outlook.com (2603:10b6:930:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Fri, 9 Sep
 2022 16:45:26 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::80ca:c97:d395:1acf]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::80ca:c97:d395:1acf%6]) with mapi id 15.20.5612.016; Fri, 9 Sep 2022
 16:45:19 +0000
Message-ID: <75db4358-feda-0a0e-415a-ad5edfd4bb89@amd.com>
Date: Fri, 9 Sep 2022 12:45:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] drm/amdgpu: Introduce gfx software ring(v3)
Content-Language: en-US
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20220909015022.557099-1-jiadong.zhu@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220909015022.557099-1-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::22) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB1947:EE_|CY8PR12MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b77767-d200-4425-1b45-08da9282ae76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X7sfYiUKSaOAweHIq5p+BAc+4/RVkb4t/SoWkcsRiR6fGbjPwHNOo5MYLLSuQO+wPilVTig7Q0Hbnx6gkjMFkCtHwtb6Zmp0I+Cmt9hKH7Pk06gnb4wgQFTggv+nam0vF928+6B4J2B6wUZAnJqCPeMgq6cUEwu5GYycjBSR+6MbMIrdeU3K7l2TucluK04aQko1c7N61FpA8xuAmP4AITF+rFf6JieD58BATdgIhhbxADAAJYGdJRfljwSEJJcrrd9+Fw7ZzzQWb8O8f5h/bLz0zT08RdoA/VMRU73dMA3HrbxqPsmJWVs3SklVIG/OHvP8yJ/1fztaxc/viSJCg41BtX3Vh4aXkcNHaYnc5U6ym4ItkDXNMTmrXDQyPLqjkPhL+bufSwH4n0UAJuv8nK4xg1TiyAyY/cuh6h7Uo0cQTC5uQcyT8qp6ICB4Ke8howRWrQQXQIZ87JC3wUXDo1xjGB3BXBe0ARyGe21ncNS9wSYg5fOBlMOVxOb59+pRPGxMiDd2D4O4Xb5QOn6Sf337snP9hrbffHVDDByJfVgIJ0A8kUAjvx04oG4DiRvQJtilhRxorOmklEJG5hTPjXl3RMX4wlGau7Au8BV18gJ+11hmf/tPGzGtqslI0i+do8xM46/dEeJUK/BIaVpMs9M1lc6IkKoVLHyhBXLiMiNUABvVYg8quu3DNt4eAf3Auwiz4FdmapMV/rRbmn2RgWXpfBSSY03cAEe1PPoMKPxMSugXrK0n82clxddRieBy3PXhAwhY5EDt1RXqPT5jW+GXqWiONa2w6k3NwUdskQ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(36756003)(186003)(2616005)(53546011)(86362001)(44832011)(5660300002)(30864003)(6486002)(31696002)(478600001)(6506007)(41300700001)(31686004)(6512007)(8936002)(83380400001)(38100700002)(316002)(2906002)(8676002)(66476007)(66556008)(66946007)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlR3UVBZcm5SbHhKdDlCai9UWWdmVG9Hd3BMbmQwVEVGdVZ0TzltRHpVMTBx?=
 =?utf-8?B?MUhYZTNPUlZmWFUrUTJOL2QyZlUyZ0R1M2JhQ2wrK2JmUjhvV0xkZHl3U2Fz?=
 =?utf-8?B?QlJ1dnF3dy90RS9XcmcvQzVEdjc2bmx3cTRpYjVVNmZKcG5nNklWdm5JMTFx?=
 =?utf-8?B?L0NFS3FEZU1xSlBRMktERUJVVHk4RVVJb1lnTVVXWENlaU91ZFdWVGNaMVM2?=
 =?utf-8?B?L1lBaTlvdThDUE15TXlDejVyYVc2UVpPNEk4VUFHaHUwTmgxRmVuaURNeWp0?=
 =?utf-8?B?clhVcVBrY3F1VW0wWWdpT1B0NzZ5OGY5enVNUHVnOTZ4WWUyU2JGWnRpOXVv?=
 =?utf-8?B?ZXEvOGE3cS9ZQ3hvMzJTNCsvZEN0Qll0RzF4dGJhNngyYWQ4cHpXQWc2NlAv?=
 =?utf-8?B?QitTRG05dE9rd2dIR0NIQk94NmMwQjdkaGlqUWF2OWFlRUJmZzhwT1RtWmt5?=
 =?utf-8?B?S0VReUVJL0dPaXlwRlBxdUlaOW9KOVcrV0dNdVJKNEVkYS8wb1FuYkVMbVJi?=
 =?utf-8?B?RlhIMjlYMTM1ME1mMk54SFRWVGVWQW9xeEh0Qjh6ZVprUllYM2tMUFFZQ3ZJ?=
 =?utf-8?B?bUlFb0k0RTQwYnowL1d6b3dNQlFJVGpFWmR5N0sveUl2S2ZUdHRpMkdiekox?=
 =?utf-8?B?NmU3eHc5a2ZzNkRvU0pMalJ5UDFjRGl3eE9YRjVQN3VWdzhGMXVua0hnZ3lW?=
 =?utf-8?B?YUtGVlBpZnpycW9PVThwelArU290TlRnRWZCQ0RkaTBBLytZUkpGYkNHTVJs?=
 =?utf-8?B?a0tyMmVmN0NFckVFZmwvK1pva3dtWHRuM0hsQmNTRTB1RXEyZmtuL2ZsWGVj?=
 =?utf-8?B?V2E0QWFHNnUzRTNWaC9yMVRXUi9xVXRXQktUb3F5dUd3Z25pTHV2UXNlZ1dw?=
 =?utf-8?B?ZlUzeEcvQlc3REF4MTgxdmZGVmZocERkRVZVaW9seisvTmtnQWlLMjhNZVpy?=
 =?utf-8?B?amxKNTgvamszUFN1KzBRc01wT3Y5RHVqWm5mQ3ppU3gzMkhJTW5PaThDZTJ0?=
 =?utf-8?B?Z0FCZ3VPZjhOWHIyTStoYjJ2TWs4b3hxZ2NTc2h0VWc1YUV4T1pVQlVXdWRw?=
 =?utf-8?B?RUJtdTZwRVc2b0EvczVrNzZKcjh3UldLR2ZqZTdlSU9EeUswdGlkMGtXWUxw?=
 =?utf-8?B?WVhXQmp1emFSQmlrVUtFZlF5V1Npek9MNldKc1c5allmNUZiNEFMVlFOd0ta?=
 =?utf-8?B?S01MSm5UY2dnZXErdWNVUW0xejBxdThMSjNyMFlMbzNvdDA3THgxZHVlNDRl?=
 =?utf-8?B?NXpQUjlKK2pzNnh2OTJFYjBsT1JNeG5VUVI1ZEFPTDRhMURBT3g4ekpXcFJi?=
 =?utf-8?B?NFJucjZGMFJsTVNtSG1CSmpmTUxabEVZNGF3OHpsNThDZVdJS3RFcUwzbC85?=
 =?utf-8?B?b3ZlbnBKck9Ba3NOakN6K1c3dmFES09KU3NHNnA0dlV6SXVldDlhcjhlSWp2?=
 =?utf-8?B?WHVRaklQK2YxbUdmZ3dqSXVWdnRFclJhN0pVbjViRzhCU0lZUUsrVXdTNTdU?=
 =?utf-8?B?N1ZHQ21DSnRRNVBHa25yWml4OGljbUVMSUtoRExvbW43eGJpUlBPejFLZG5q?=
 =?utf-8?B?UVpKdXlHd3ZlZkViU2lJaHNKTC8rRDViV2U4SEtuRVI5QTY5RDRFRS9pNk9l?=
 =?utf-8?B?SVUxTW1wYjY4U0xaZ1FuSEErUndmaFBVRXVPYm5lb0txRzFLaHpiR3F0dGkz?=
 =?utf-8?B?OEZMZ29UWnBhSW0rdGlhcnJ6MkdVVlJMc205S3NIcU1wV2FTUThVZ01vVXZz?=
 =?utf-8?B?dEt6S0hKcGUwWllCaWMyUkk5VnFzU0RLQ1dNdGpJZnhVM1NTYWZLSEQxekVP?=
 =?utf-8?B?bEhpSzRqRUFScWRGVDVsMkl6Z09PaFQvKzNwV2lodTg5N2huakVhZUhveTdN?=
 =?utf-8?B?NW1QTGxiV2syZkc4RHczWiszMWkyaTIxZjlaNGoreVJMa3pGcC9sR2JJK1V6?=
 =?utf-8?B?QzZMTS9ZWDR0bmlOd25aQVh2d1U5aitKeWRLM1BIZit2RVlidEhka3VjMFNY?=
 =?utf-8?B?R3VramNuRU81MGhXOWEwZ3NIQmRBckw2czdoc01MQlVnMitZQmZ1bFNMY3FS?=
 =?utf-8?B?V3VzVC9ES1BJYlh1OS85NTcyOE1DYm5tYTVHeVdUbXl1N2NnYTVpUmtzZkhk?=
 =?utf-8?B?dEZocUlpUk95Sm83cWQrNjJhYmxLZ0VHYXdWUWJtdVF4bmQ1ZnZsUmxKdFcz?=
 =?utf-8?Q?viAKa2kHW9vMZkB/N3TOaxi2ZOSUa8dgpMCvHiTi+rVW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b77767-d200-4425-1b45-08da9282ae76
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 16:45:19.8757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GKOwxtFtMbmeuVZir+6V7OEoPKxeVYNeMoaeTlzFw3JTSEGakuweqlfs/ZUUOkSDVTgaP77Yfay5IFbbdWmi6w==
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


On 2022-09-08 21:50, jiadong.zhu@amd.com wrote:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>
> The software ring is created to support priority
> context while there is only one hardware queue
> for gfx.
>
> Every software rings has its fence driver and could
> be used as an ordinary ring for the gpu_scheduler.
> Multiple software rings are binded to a real ring
> with the ring muxer. The packages committed on the
> software ring are copied to the real ring.
>
> v2: use array to store software ring entry.
> v3: remove unnecessary prints.
>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   3 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 182 +++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  67 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c  | 204 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h  |  48 +++++
>   7 files changed, 509 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>   create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 3e0e2eb7e235..85224bc81ce5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -58,7 +58,8 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>   	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
>   	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>   	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
> -	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o
> +	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
> +	amdgpu_sw_ring.o amdgpu_ring_mux.o
>   
>   amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 53526ffb2ce1..0de8e3cd0f1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -33,6 +33,7 @@
>   #include "amdgpu_imu.h"
>   #include "soc15.h"
>   #include "amdgpu_ras.h"
> +#include "amdgpu_ring_mux.h"
>   
>   /* GFX current status */
>   #define AMDGPU_GFX_NORMAL_MODE			0x00000000L
> @@ -346,6 +347,8 @@ struct amdgpu_gfx {
>   	struct amdgpu_gfx_ras		*ras;
>   
>   	bool				is_poweron;
> +
> +	struct amdgpu_ring_mux			muxer;
>   };
>   
>   #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 7d89a52091c0..fe33a683bfba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -278,6 +278,9 @@ struct amdgpu_ring {
>   	bool			is_mes_queue;
>   	uint32_t		hw_queue_id;
>   	struct amdgpu_mes_ctx_data *mes_ctx;
> +
> +	bool			is_sw_ring;
> +
>   };
>   
>   #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p), (job), (ib)))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> new file mode 100644
> index 000000000000..ea4a3c66119a
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
> @@ -0,0 +1,182 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include <drm/drm_print.h>
> +
> +#include "amdgpu_ring_mux.h"
> +#include "amdgpu_ring.h"
> +
> +#define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ/2)
> +
> +static int copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
> +	u64 s_begin, u64 s_end);
> +
> +int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	mux->real_ring = ring;
> +	memset(mux->ring_entries, 0, sizeof(mux->ring_entries));
> +	mux->num_ring_entries = 0;
> +	spin_lock_init(&mux->lock);
> +	return 0;
> +}
> +
> +void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux)
> +{
> +	memset(mux->ring_entries, 0, sizeof(mux->ring_entries));
> +	mux->num_ring_entries = 0;
> +}
> +
> +int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +
> +	if (mux->num_ring_entries == AMDGPU_MAX_GFX_RINGS) {
> +		DRM_ERROR("adding sw ring exceeds max gfx num\n");
> +		return -ENOMEM;
> +	}
> +
> +	e = &mux->ring_entries[mux->num_ring_entries++];
> +
> +	e->ring = ring;
> +	e->start_ptr_in_hw_ring = 0;
> +	e->end_ptr_in_hw_ring = 0;
> +	e->sw_cptr = 0;
> +	e->sw_rptr = 0;
> +	e->sw_wptr = 0;
> +
> +	return 0;
> +}
> +
> +static struct amdgpu_mux_entry *amdgpu_get_sw_entry(struct amdgpu_ring_mux *mux,
> +				struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +	int i;
> +
> +	e = NULL;
> +	for (i = 0; i < mux->num_ring_entries; i++) {
> +		if (mux->ring_entries[i].ring == ring) {
> +			e = &mux->ring_entries[i];
> +			break;
> +		}
> +	}
> +
> +	return e;
> +}
> +
> +void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr)
> +{
> +	struct amdgpu_mux_entry *e;
> +
> +	e = amdgpu_get_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("cannot find entry for sw ring\n");
> +		return;
> +	}
> +
> +	spin_lock(&mux->lock);


A bit more generic question, I assume the spinlock here protects from 
concurrent runs
of amdgpu_ib_schedule. For them to be even theoretically concurrent it 
must be from
direct submissions to HW (because any scheduler mediated submission is 
serialized though
the dedicated scheduler worker thread). But in such case why we protect 
only here ? If i am
not missing something there is no total per HW ring lock when calling 
amdgpu_ib_schedule today
and we do a lot of HW accesses there to ring  which should probably be 
protected from
concurrent accesses.

So if any one can answer this question ?


> +	e->sw_cptr = e->sw_wptr;
> +	e->sw_wptr = wptr;
> +	e->start_ptr_in_hw_ring = mux->real_ring->wptr;
> +
> +	if (copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr) == 0) {
> +		e->end_ptr_in_hw_ring = mux->real_ring->wptr;
> +		amdgpu_ring_commit(mux->real_ring);
> +	}
> +
> +	spin_unlock(&mux->lock);
> +}
> +
> +u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +
> +	e = amdgpu_get_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("cannot find entry for sw ring\n");
> +		return 0;
> +	}
> +
> +	return e->sw_wptr;
> +}
> +
> +u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_mux_entry *e;
> +	u64 r_rptr, r_wptr, offset, start, end;
> +
> +	e = amdgpu_get_sw_entry(mux, ring);
> +	if (!e) {
> +		DRM_ERROR("no sw entry found!\n");
> +		return 0;
> +	}
> +
> +	r_rptr = amdgpu_ring_get_rptr(mux->real_ring);
> +	r_wptr = amdgpu_ring_get_wptr(mux->real_ring);
> +
> +	if (r_wptr < r_rptr)
> +		r_wptr += mux->real_ring->ring_size >> 2;
> +
> +	start = e->start_ptr_in_hw_ring & mux->real_ring->buf_mask;
> +	end = e->end_ptr_in_hw_ring & mux->real_ring->buf_mask;
> +	if (start > end)
> +		end += mux->real_ring->ring_size >> 2;
> +	if (r_rptr <= end && r_rptr >= start) {
> +		offset = r_rptr - start;
> +		e->sw_rptr = (e->sw_cptr + offset) & ring->buf_mask;
> +	} else if (r_rptr < start) {
> +		e->sw_rptr = e->sw_cptr;
> +	} else {
> +		e->sw_rptr = e->sw_wptr;
> +	}
> +
> +	return e->sw_rptr;
> +}
> +
> +/*copy packages on sw ring range[begin, end) */
> +static int copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
> +	u64 s_begin, u64 s_end)
> +{
> +	u64 begin, end, r_begin, r_end;
> +	struct amdgpu_ring *real_ring = mux->real_ring;
> +
> +	begin = s_begin & ring->buf_mask;
> +	end = s_end & ring->buf_mask;
> +
> +	r_begin = real_ring->wptr & real_ring->buf_mask;
> +	if (begin == end)
> +		return -ERANGE;
> +	if (begin > end) {
> +		amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) + end - begin);
> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[begin],
> +			(ring->ring_size >> 2) - begin);
> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[0], end);
> +	} else {
> +		amdgpu_ring_alloc(real_ring, end - begin);
> +		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[begin], end - begin);
> +	}
> +
> +	r_end = real_ring->wptr & real_ring->buf_mask;
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> new file mode 100644
> index 000000000000..d058c43bb063
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
> @@ -0,0 +1,67 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __AMDGPU_RING_MUX__
> +#define __AMDGPU_RING_MUX__
> +
> +#include <linux/timer.h>
> +#include <linux/spinlock.h>
> +#include "amdgpu_ring.h"
> +
> +struct amdgpu_ring;
> +/*
> + * start_ptr_in_hw_ring - last copied start loc on hw ring
> + * end_ptr_in_hw_ring - last copied end loc on hw ring
> + *sw_cptr -the begin of copy ptr in sw ring
> + *sw_rptr; the read ptr in sw ring
> + *sw_wptr; the write ptr in sw ring
> + */
> +struct amdgpu_mux_entry {
> +	struct amdgpu_ring	*ring;
> +	u64 start_ptr_in_hw_ring;
> +	u64 end_ptr_in_hw_ring;
> +
> +	u64 sw_cptr;
> +	u64 sw_rptr;
> +	u64 sw_wptr;
> +};
> +
> +struct amdgpu_ring_mux {
> +	struct amdgpu_ring *real_ring;
> +
> +	struct amdgpu_mux_entry ring_entries[AMDGPU_MAX_GFX_RINGS];
> +
> +	unsigned num_ring_entries;
> +
> +	spinlock_t			lock;
> +
> +};
> +
> +int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux);
> +int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr);
> +u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
> +
> +#endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
> new file mode 100644
> index 000000000000..452d0ff37758
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
> @@ -0,0 +1,204 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the
> + * "Software"), to deal in the Software without restriction, including
> + * without limitation the rights to use, copy, modify, merge, publish,
> + * distribute, sub license, and/or sell copies of the Software, and to
> + * permit persons to whom the Software is furnished to do so, subject to
> + * the following conditions:
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * The above copyright notice and this permission notice (including the
> + * next paragraph) shall be included in all copies or substantial portions
> + * of the Software.
> + *
> + */
> +
> +#include "amdgpu_sw_ring.h"
> +#include "amdgpu_ring_mux.h"
> +
> +#define amdgpu_ring_get_gpu_addr(ring, offset)				\
> +	(ring->is_mes_queue ?						\
> +	 (ring->mes_ctx->meta_data_gpu_addr + offset) :			\
> +	 (ring->adev->wb.gpu_addr + offset * 4))
> +
> +#define amdgpu_ring_get_cpu_addr(ring, offset)				\
> +	(ring->is_mes_queue ?						\
> +	 (void *)((uint8_t *)(ring->mes_ctx->meta_data_ptr) + offset) : \
> +	 (&ring->adev->wb.wb[offset]))
> +
> +
> +int amdgpu_sw_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
> +		     unsigned int max_dw, struct amdgpu_irq_src *irq_src,
> +		     unsigned int irq_type, unsigned int hw_prio,
> +		     atomic_t *sched_score)
> +{
> +	int r;
> +	int sched_hw_submission = amdgpu_sched_hw_submission;
> +	u32 *num_sched;
> +	u32 hw_ip;
> +
> +	BUG_ON(!ring->is_sw_ring);
> +
> +	if (ring->adev == NULL) {
> +		if (adev->num_rings >= AMDGPU_MAX_RINGS)
> +			return -EINVAL;
> +
> +		ring->adev = adev;
> +		ring->num_hw_submission = sched_hw_submission;
> +		ring->sched_score = sched_score;
> +		ring->vmid_wait = dma_fence_get_stub();
> +
> +		if (!ring->is_mes_queue) {
> +			ring->idx = adev->num_rings++;
> +			adev->rings[ring->idx] = ring;
> +		}
> +
> +		r = amdgpu_fence_driver_init_ring(ring);
> +		if (r)
> +			return r;
> +	}
> +
> +	r = amdgpu_device_wb_get(adev, &ring->fence_offs);
> +	if (r) {
> +		dev_err(adev->dev, "(%d) ring fence_offs wb alloc failed\n", r);
> +		return r;
> +	}
> +
> +	r = amdgpu_device_wb_get(adev, &ring->fence_offs);
> +	if (r) {
> +		dev_err(adev->dev, "(%d) ring fence_offs wb alloc failed\n", r);
> +		return r;
> +	}


Looks like a typo copy pase duplicate of the above

> +
> +	r = amdgpu_device_wb_get(adev, &ring->trail_fence_offs);
> +	if (r) {
> +		dev_err(adev->dev, "(%d) ring trail_fence_offs wb alloc failed\n", r);
> +		return r;
> +	}
> +
> +	r = amdgpu_device_wb_get(adev, &ring->cond_exe_offs);
> +	if (r) {
> +		dev_err(adev->dev, "(%d) ring cond_exec_polling wb alloc failed\n", r);
> +		return r;
> +	}
> +
> +	ring->fence_gpu_addr =
> +		amdgpu_ring_get_gpu_addr(ring, ring->fence_offs);
> +	ring->fence_cpu_addr =
> +		amdgpu_ring_get_cpu_addr(ring, ring->fence_offs);
> +
> +	ring->trail_fence_gpu_addr =
> +		amdgpu_ring_get_gpu_addr(ring, ring->trail_fence_offs);
> +	ring->trail_fence_cpu_addr =
> +		amdgpu_ring_get_cpu_addr(ring, ring->trail_fence_offs);
> +
> +	ring->cond_exe_gpu_addr =
> +		amdgpu_ring_get_gpu_addr(ring, ring->cond_exe_offs);
> +	ring->cond_exe_cpu_addr =
> +		amdgpu_ring_get_cpu_addr(ring, ring->cond_exe_offs);
> +
> +	/* always set cond_exec_polling to CONTINUE */
> +	*ring->cond_exe_cpu_addr = 1;
> +
> +	r = amdgpu_fence_driver_start_ring(ring, irq_src, irq_type);
> +	if (r) {
> +		dev_err(adev->dev, "failed initializing fences (%d).\n", r);
> +		return r;
> +	}
> +
> +	ring->ring_size = roundup_pow_of_two(max_dw * 4 * sched_hw_submission);
> +
> +	ring->buf_mask = (ring->ring_size / 4) - 1;
> +	ring->ptr_mask = ring->funcs->support_64bit_ptrs ?
> +		0xffffffffffffffff : ring->buf_mask;
> +
> +	/* Allocate ring buffer */
> +	if (ring->ring == NULL) {
> +		ring->ring = kzalloc(ring->ring_size + ring->funcs->extra_dw, GFP_KERNEL);
> +		if (!ring->ring) {
> +			dev_err(adev->dev, "(%d) swring create failed\n", r);
> +			return r;
> +		}
> +
> +		amdgpu_ring_clear_ring(ring);
> +	}
> +
> +	ring->max_dw = max_dw;
> +	ring->hw_prio = hw_prio;
> +
> +	if (!ring->no_scheduler) {
> +		hw_ip = ring->funcs->type;
> +		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
> +		adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =
> +			&ring->sched;
> +	}
> +
> +	return 0;
> +}


In general i see this function is a big one to one subset of 
amdgpu_ring_init.
Could you maybe see a way to refactor such that this function is the base
and for HW related code that different (like BO allocation for ring 
buffer) you
maybe can add if (!ring->sw_ring)... and add those code snippets ? To avoid
substantial code duplication.

Andrey


> +
> +u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	BUG_ON(!ring->is_sw_ring);
> +	return amdgpu_ring_get_rptr_from_mux(mux, ring);
> +}
> +
> +u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	BUG_ON(!ring->is_sw_ring);
> +	return amdgpu_ring_get_wptr_from_mux(mux, ring);
> +}
> +
> +void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring)
> +{
> +	BUG_ON(!ring->is_sw_ring);
> +}
> +
> +void amdgpu_sw_ring_commit(struct amdgpu_ring *ring)
> +{
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
> +
> +	BUG_ON(!ring->is_sw_ring);
> +	amdgpu_ring_set_wptr_to_mux(mux, ring, ring->wptr);
> +}
> +
> +void amdgpu_sw_ring_fini(struct amdgpu_ring *ring)
> +{
> +	BUG_ON(!ring->is_sw_ring);
> +
> +	/* Not to finish a ring which is not initialized */
> +	if (!(ring->adev) ||
> +	    (!ring->is_mes_queue && !(ring->adev->rings[ring->idx])))
> +		return;
> +
> +	ring->sched.ready = false;
> +
> +	amdgpu_device_wb_free(ring->adev, ring->cond_exe_offs);
> +	amdgpu_device_wb_free(ring->adev, ring->fence_offs);
> +
> +	kfree((void *)ring->ring);
> +
> +	dma_fence_put(ring->vmid_wait);
> +	ring->vmid_wait = NULL;
> +	ring->me = 0;
> +
> +	ring->adev->rings[ring->idx] = NULL;
> +}
> +
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
> new file mode 100644
> index 000000000000..c05d8a94ad0c
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
> @@ -0,0 +1,48 @@
> +/*
> + * Copyright 2012 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include <drm/amdgpu_drm.h>
> +#include <drm/gpu_scheduler.h>
> +#include <drm/drm_print.h>
> +
> +#include "amdgpu_irq.h"
> +#include "amdgpu_ring.h"
> +#include "amdgpu.h"
> +
> +#ifndef __AMDGPU_SWRING_H__
> +#define __AMDGPU_SWRING_H__
> +
> +int amdgpu_sw_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *sw_ring,
> +		     unsigned int max_dw, struct amdgpu_irq_src *irq_src,
> +		     unsigned int irq_type, unsigned int hw_prio,
> +		     atomic_t *sched_score);
> +void amdgpu_sw_ring_fini(struct amdgpu_ring *ring);
> +u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring);
> +u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring);
> +void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring);
> +void amdgpu_sw_ring_commit(struct amdgpu_ring *ring);
> +
> +void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring);
> +void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring);
> +
> +#endif

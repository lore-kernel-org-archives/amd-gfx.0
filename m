Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757AFC6FA82
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Sep 2022 15:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B10010E75C;
	Tue, 13 Sep 2022 15:12:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38D5010E76F
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Sep 2022 15:12:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TK509plIzngiOHcm+430xXoq9LA2rvg6W3L8uheggc8HLA2pKh3oZXs5KxdKa3wj1XAhzEFWruqugbwe14nYBmaWcfZBo5Grgd+TxTFZ+fR8Ea3+Lxq3GiEqHLfYB9bYl5Yrd3vx8j6mlBH4azTHXVVRijHI5rCyx6Y5xM57MxPmDhPSg3pe4Srliw1sO3N1p8o9e59M+a/IfM+FeD0UyR1h0PCecS0pAH328o3e/qRwQUBXLe8K5RticSWMntDaleOzi0Yug9HjVSdqk3a/xP0r1uDcY63QiwFEz9w5OaJ8cVq0OVWcdOzQtfFz70liCErvwIQ+oFTwqzhi1LDnQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kb+exsFTED/U4agjP27iP013H/lrCDsWRwDIAjoHw5A=;
 b=XaxYayEqFUWmf4vSx68W19AyzVCw6iKP883fX/nWDG+D4cP7hTD+qugkNsk8c1K/qY5A736wFmknsNsN7T2/RK8NKBSnQSEF9N6plHlqo4LbMM5BhA2D3j9pf1rNOeV7oqPa8Vf10FCNlChbfN6C5131t1+6HCyZ/GgsCZGEjXg8FkJ0IYjs7WrfdGRw6hJP3a97U9W1dMo7jAiPy3mzvVR5jab3OyTtH9w2Cnb7F2PIqS2m2Gc9lDCDQAW6krL3fUnXbJJPs5zqN5NCV7MqkR6a2ryq6fpo1sTUl/OM+4fInLKQcB4SQJWi6PwQr6kxohWIFIrb4/My680WmTJVqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kb+exsFTED/U4agjP27iP013H/lrCDsWRwDIAjoHw5A=;
 b=I80OttMIEeDJjn0YSeRiO+pj6+AkOoOzoXOx9kxG2RZyBqRQ6U63ytoBwVF9RJKGaS5ynpDXVrwjeYmy5XVEkP7SvdSqKiFS7z3JkQymkQxvQtY3/lKiozYjkX8kGrqgjXKgEU9+1Iy64z/r/f3k59MRU843Bt6sspfkeTF/Odc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3375.namprd12.prod.outlook.com (2603:10b6:208:cc::12)
 by SJ0PR12MB5486.namprd12.prod.outlook.com (2603:10b6:a03:3bb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 13 Sep
 2022 15:12:32 +0000
Received: from MN2PR12MB3375.namprd12.prod.outlook.com
 ([fe80::855e:f995:b7a0:130b]) by MN2PR12MB3375.namprd12.prod.outlook.com
 ([fe80::855e:f995:b7a0:130b%6]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 15:12:32 +0000
Message-ID: <2d46d127-ea75-7813-2b37-2b1d4e77249b@amd.com>
Date: Tue, 13 Sep 2022 11:12:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/4] drm/amdgpu: Introduce gfx software ring(v3)
Content-Language: en-CA
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20220909015022.557099-1-jiadong.zhu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220909015022.557099-1-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::13) To MN2PR12MB3375.namprd12.prod.outlook.com
 (2603:10b6:208:cc::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3375:EE_|SJ0PR12MB5486:EE_
X-MS-Office365-Filtering-Correlation-Id: 9acbd1e6-d5aa-4986-bec0-08da959a6167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KYVjn/DTyvB94FR6bAS5O1NrxNDPNdj9kW4u6oHQWoQTVQKiOmWr7nN8Ts8SLiAB4EBHP6r2/hk8isj1gfKerYE4IToIOGq41FsLylG3kdQth6TDws3kuI9dW9gyqbZJxqvY6/jYa83yxpXQfg1U4hosDle4u4Yl5Y+AZKm7EKQnGVSBAdNde0I0Ns4cfGhAq4pS6paQXgajSWD1CFHFN0roHDpld2qoWVLQ1NBmQaNu4jPRaiw+nbaB9/Z8bhKD8AUXHY1MNGAVBxzprTdKRJsjNTWBA+mWl1dnTQiZ5a/aMlBDxCGrGJ44cTDc4+zBKQAJagCnZWwKOe6szk0ul2bOyCKOd1/Sazx9UT4qCbEhH11tCfKD5VcRnlAqb0dGfs00AKYNOUDXX72MraSFEbLxfSLEc7XD8m5NC+rW4ifPzPzyoupCBrDF0/HoFuY5V/JVN4+qM6bVlHtWSiCHHEPX2ZoTEN8etKBSUwKQ6aUpxlSKd4Y22ap1QgoaWdN6KmlFwmPiNQjrbUQ+T6z8+U1x2rFr/9Q+U9S3X1ioSgYmQ0wouzjJXh47YhNlsH6Wd5Af1OruNeUPKwWi5Ywm7eCVGNAWIzE+JxteaaTymdLWYvWX94hlYQ0psg4u5/4gRtPHG6klyR6YMWEqEo74UDe9mEywtnmRxVurb54L1sz6GP9t18FbFBz6+cb38Yb87hXx01MJpE4/B1RKd7NYdlNyP3BS2Fb+fETD7chqXOJPCaHTadk2juBHiHYgLP3T/2jjFwIdC1PZhQNWDLmLUausuw4of4GrKtQ0JW2fMBI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3375.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199015)(5660300002)(186003)(53546011)(38100700002)(6506007)(2616005)(8676002)(36756003)(316002)(31686004)(41300700001)(4326008)(66946007)(6666004)(26005)(6512007)(31696002)(8936002)(30864003)(66476007)(66556008)(44832011)(86362001)(83380400001)(478600001)(6486002)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzViUnBHNmE2Vm9mWVg4VXdMRzY1TXlqR29CRUUrQ3VvYmVnY3FNQWptZjVw?=
 =?utf-8?B?bmk4emh5ZkxnMjh1TlNGNG9zMGRNUC9JRGEwM3Q4SVhQWDVpdmhjQzdsSmZH?=
 =?utf-8?B?Q1BFRzNVNVZYbm00MzZVNjdiNlEyZER1eDl1UTJRNXI0WHRQOHpaZ2RGYkxR?=
 =?utf-8?B?alYvUmZFcDZQNUU1WkQ2Y01TMnZPT2xPTE5JS2JvdlNSYnNLSkxlMkNsQlFC?=
 =?utf-8?B?dHJ3ZzJIN2NpZzdFM09zaTRnTHNRdXFTZm9aNXZjSTlOSERadFVRaEExZWFM?=
 =?utf-8?B?dytaQ0UvK3VFVHVrR29KaCsvaWNBQXpSd29XeHhWVHE4NGxVWmpzNzk5dHlQ?=
 =?utf-8?B?YUNXUUx4dVF0MFZBcWd3MFpQUFQwam5XRnRUdDhkZWJqNVZJUjEvODM3Tm9G?=
 =?utf-8?B?QW5oWmQ1bUViSFlmMm5lMDRaZHpWQW5wdnEwNk1pVWJwdmwwMVBLQUFpMTh2?=
 =?utf-8?B?ZGdWUjNwWHo0UC9SM3JNZXptZWd2cHZqNVVNTFlJREVJWEMxNTg4bEVDVXhI?=
 =?utf-8?B?Qk1URUttNTRaMWFieHJWTzZ4aG1JNG9FOFNwbFA4TlpkOTdJb1BWQjIvUXZz?=
 =?utf-8?B?L0Y5MVY5U1B3cE5HcXRZdkFoV3pLeEZ1SkpLRCtORFRXbzJyU3huMmNoa1Nr?=
 =?utf-8?B?ellnUHJEb05IQ3JhKytqdzZ0TVcyNVZZc05MU0dvYzVPOGY2OXh4SUlHTG9q?=
 =?utf-8?B?QVFqRm95d0xwd1dSaXBGcGZJY1ZnQWlFRUxObnpNV3dqVWFIUXp0OS9kanZV?=
 =?utf-8?B?RHJVTmVnSVpQcUdwOTBlTHZlQkw2b2dITnVuWWk5TDFCUzJLR1E4QlVIV0Ri?=
 =?utf-8?B?VVZNdmsrZkdGaXFEMkRYUGtrbEsyNkYvU2orQ0wvWWlGazgvVEV5L0hWTjUz?=
 =?utf-8?B?OHJBOTJPSnZxVTd6ZjFhN3Y4TWVmWnkyMVlNcXJDUTVZQnJJeCtDZ0x6M2Fs?=
 =?utf-8?B?WnJPK3ZSek5aWlZaOXFSQXdySk0yZU05R1NSQktsMVNRRzJ1LzlSTlViUWJX?=
 =?utf-8?B?K1NjanJsSTNGV1h1aU5zN3RtUFhHaHNMdnR1bVJEWm9IRDQ1THU1dlovYWxx?=
 =?utf-8?B?RUdmTVExR0dxclJjdHhHYmgxbkdNWEhpOFc4b2xtcFA3TzNFSTNIcFlxSjZZ?=
 =?utf-8?B?YVlOdFFTZ3ZhTFQrazJnWDh0YXZDb2o4akxLNG83aENnc3k5dzgrMllpTkNH?=
 =?utf-8?B?MnN2ZnMvWWJVQ3hFbmw4UjFkbnhSQXdBNHNlcm1uZldxVXZDbkxtVDVVT0RP?=
 =?utf-8?B?WVRvYnZyak1idTJvT3NwR3Q2OFR0VklEbXBrekthSTlZb2VWT0VKQnRBei9a?=
 =?utf-8?B?QnhJaEl6eS9rVm9paXBVUHJvaFNzM2Jqb0xpcjZNQUxHUFZQc0NBanJQaURl?=
 =?utf-8?B?WThwRTZZRERUNktVOTJya3gvZ01KYUNvY00ycVFrVFNVUm5ZTnljLy9RN3lx?=
 =?utf-8?B?cW9saStRb0hPMHNqa2NwaTB0clA4K2VRcmRyZ1QrWGN4MGhqMVJoK2NDY3lh?=
 =?utf-8?B?TjRnelRmM2R4c3NLVFZKZVhQRWJTRUFaWFZzTW9aYTJ1bVFianV6VGFuYjhv?=
 =?utf-8?B?VWprbkFUWU5nQTNHZGxDTWw5cjRoUy9mNkVsd2RhVEQ5OCtpNVVRQXVQbTV5?=
 =?utf-8?B?d3BOS2I0eG02bExxWWVPYU94YVF4RUhudXhEU1ZncnRQdDhlaHk2TTc0M3ZV?=
 =?utf-8?B?YUwzTDlZaFJ5c1JnTzhqODA0TnJ0Q0VUdCtlUUZBOUt4S3YyU09RZVpUN3BS?=
 =?utf-8?B?blJxQS9vdWl2dnRwNUtDQlk2UzlwVEtJdnNQVXA4VzBXdHJQT1BtQ3AxQVI2?=
 =?utf-8?B?UndNYy9DdmhqL3FrV0FjRS9CUVNQVVpyWk54SkFCakpQWXZORjJCeG5EZGVC?=
 =?utf-8?B?bm1PZDNRMFpMSzIvSVF6SmRKZnVkdnJjRi85alliZE1CWCtrcm9VZVRFL2xE?=
 =?utf-8?B?OFlvK3l0OU5QTXN3d0ZiQmJVN0drN05IM3lJaS95OVF2Y3E1ZERCSUZ1eDZE?=
 =?utf-8?B?dDV2cHlILzMxemxZR1dSMXFsRUhsQzdHVy9GdlNuK0s4VDZadHpYdmdoRGUz?=
 =?utf-8?B?QWc2bWpYbC8zMjVkNHdGZGZQeE14SGpiVm55cU9YeE0yUFJmT1BwNmhnWmlX?=
 =?utf-8?Q?GBnFpe85+5oJAAm7BtKLqreZE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9acbd1e6-d5aa-4986-bec0-08da959a6167
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3375.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 15:12:32.0537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ibjEIp8tk0h/RUxDendOCjaQJ6/ft5026B56ltLJUMoKj2SNyCF7QyynGrHeKH4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5486
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

Inlined:

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
>  drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 182 +++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  67 ++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c  | 204 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h  |  48 +++++
>  7 files changed, 509 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 3e0e2eb7e235..85224bc81ce5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -58,7 +58,8 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>  	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
>  	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
>  	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
> -	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o
> +	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
> +	amdgpu_sw_ring.o amdgpu_ring_mux.o
>  
>  amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 53526ffb2ce1..0de8e3cd0f1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -33,6 +33,7 @@
>  #include "amdgpu_imu.h"
>  #include "soc15.h"
>  #include "amdgpu_ras.h"
> +#include "amdgpu_ring_mux.h"
>  
>  /* GFX current status */
>  #define AMDGPU_GFX_NORMAL_MODE			0x00000000L
> @@ -346,6 +347,8 @@ struct amdgpu_gfx {
>  	struct amdgpu_gfx_ras		*ras;
>  
>  	bool				is_poweron;
> +
> +	struct amdgpu_ring_mux			muxer;
>  };
>  
>  #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 7d89a52091c0..fe33a683bfba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -278,6 +278,9 @@ struct amdgpu_ring {
>  	bool			is_mes_queue;
>  	uint32_t		hw_queue_id;
>  	struct amdgpu_mes_ctx_data *mes_ctx;
> +
> +	bool			is_sw_ring;
> +
>  };
>  
>  #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p), (job), (ib)))
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

You can't return here -ENOMEM, as it is not a real out of memory condition.
Maybe EINVAL or something like that, but not ENOMEM.

Also, under what circumstances would we get to this condition here?
Are such circumstances valid?

And if so, then when this is returned, what happens?
Does the driver die?

I feel we shouldn't ever have this here--it should've been
calculated correctly to never have fallen in this/such a circumstance like that here.

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

How and why would we get in this situation here like that?
Also, DRM_ERROR() may overflow the kernel log. Perhaps DRM_DEBUG is better,
or not print anything at all.

> +
> +	spin_lock(&mux->lock);
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

These names are very much the same to a human. How about
writep and readp?

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

Use double dash for visibility "--".
Please spell out "location".
Perhaps you want to say something like:
"last start location where we copied to in the hardware ring".

Don't you just need an "index pointer"--pointing to the next
location to copy to?

I don't understand what "last copied end loc on hw ring" is,
as we ll as "last copied start loc on hw ring". 

> + * end_ptr_in_hw_ring - last copied end loc on hw ring
> + *sw_cptr -the begin of copy ptr in sw ring

Double-dash and space around it.

Don't you just mean "the copy pointer in sw ring"?

> + *sw_rptr; the read ptr in sw ring
> + *sw_wptr; the write ptr in sw ring

Double-dash instead of semicolon.

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

Shouldn't the size of this array be dynamic depending on the ASIC used?
Maybe call it "ring_entry", so that "ring_entry[i]" means "ring entry at index i."

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

I don't know how you were able to actually insert TAB chars after the text and before
the backslash. Pressing the TAB key in my editor only aligns the line according to
the mode, and that's it--I can't insert a TAB char.

Don't insert TAB chars to align the backslash. Instead use the space bar--insert spaces.

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

I don't think we should have this here. Make it dynamic instead,
so that it would work with any adev in the future.

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

You don't need parenthesis around "ring->adev" and around
ring->adev->rings[ring->idx], drop them.

> +
> +	ring->sched.ready = false;
> +
> +	amdgpu_device_wb_free(ring->adev, ring->cond_exe_offs);
> +	amdgpu_device_wb_free(ring->adev, ring->fence_offs);
> +
> +	kfree((void *)ring->ring);

No need to cast to (void *).

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

Make sure to run your patches through scripts/checkpatch.pl.

Regards,
-- 
Luben

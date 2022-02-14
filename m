Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59650C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 09:31:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCDEF10E25E;
	Mon, 14 Feb 2022 09:31:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F60910E25E
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 09:31:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbcYFdShZX5qWN2KJpbVhWYq9NKTLKZQQi83ahEAiTwoCLls/1wIjEJPRtps3u8+J1g6AD97HXLFjKIEV+Zsgc99LZUnoXSzOM6p4H3TxLa61jcJVtyYurjkcdf025LjFiA5HxRCwKpaVtA1LiLJdLqqwTXRfc0VKHVPI4F/Phim2WLdiQaZsMGZvVs7XdKmxQo/W6KaBQ9wYakQBcsL5gc+l2LggUuoFPEWDvNpjUfSSivEy7wJnYuMrUn4LvCqVOZWRl54Fk/hQiIUaMV5kTAfLxZhmFcUY8jVLdjVV1gpRSQPya82uMvK2N/849Wi18Sx1/VIHCy2URnFJ7lRtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vft9faXzbnZX4IUavLXQDTuZKs6ayUY5NBNvnvm7KjE=;
 b=ko5ruQ5zsXt0KiZUKh4qQIa5kuF3Sh3CtoGv7vZrUHtmoFbGAmxnG8cxGJ2ozsgxGg1Yo5Szwd4kkWzhVa2bHPbczuh4E5mFvNPrVPdJkoPSwieBGqzoVY2xO5ngyZiq7K36xP9LukSnhwgCGg74AiCtJSmA3gIIrKebIeJ4H3Yn3lUdm9qPihKDpYLfVHHadsYq2L+awOvdJQRAba1O2Eqd7enfgmZPm/vwDMDOwdRWWwXL/ll4WlaGebnVN40nj4YEYP3FuZYabbfX3sdz2oTJiKKkQS56s8kuQifB2+oJRlSIlWGKsNNoYyJPp0oy++z2y8RmE8Mk0Gy1cqAbHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vft9faXzbnZX4IUavLXQDTuZKs6ayUY5NBNvnvm7KjE=;
 b=jAe7R4phaZoeOav/EmyQF4+jw/bnFoB6jOiuuHgLt9akGrubdqmqXmPk7pOMMzTcmuG5qL2iUtzuN/AC7naDag4YqJwqar1jEfLsKCkxfhZ1FNU1Ji/7johgSqpIMTy3lc3baaNoYQWlEGd2f/ierSWCFk5pJ0yXinf40aYkJHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB2841.namprd12.prod.outlook.com (2603:10b6:5:49::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 09:31:29 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3%3]) with mapi id 15.20.4975.015; Mon, 14 Feb 2022
 09:31:29 +0000
Message-ID: <1f4f5651-1f2a-a858-3be4-497def8d3984@amd.com>
Date: Mon, 14 Feb 2022 10:31:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/2] drm/amdgpu: add reset register dump trace function
 on GPU reset
Content-Language: en-US
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220214091619.2820-1-Amaranath.Somalapuram@amd.com>
 <20220214091619.2820-2-Amaranath.Somalapuram@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220214091619.2820-2-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR07CA0020.eurprd07.prod.outlook.com
 (2603:10a6:20b:46c::21) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24861771-1848-43df-3552-08d9ef9cc7ac
X-MS-TrafficTypeDiagnostic: DM6PR12MB2841:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2841E19FCF095DCE7484C9B583339@DM6PR12MB2841.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S7/aW99o67csG1/QG9dFrrrR9UF+RY5y277HFEyJjy1Iuh7smhyKmmmi0khlxa+XuIYKW6+rxXr3WSQAj+NT1v3WCVPoDWG1QrJ0xl+eR7LgrIt2e0RkzHPwhq0MIeGnOVVEHM2OnPxPh7vqsrLdCxWi/1tbKt/RBjhw/DDoBSFFV13mi6+QoS5S0Kw36pHGtbZYJfBihR9o45YMdReIxqVxK2ON2lTMqbk2DMzy5baziZuyh2wKNbu2BVetIrClLWl1cTtnajamYrncUJL+9XxnPna+TjGCXZ6vM4FpExVcYF68ww+zGq+uOaXX8Yqeh7WOxFVch8R1++p37Lxm/Tm7tFo6K3nEgg72pQOhVdEZ4xOeLYnRSeKYufV7cDfEG0ey5k/hmNu+T56MupXnV10yVRuvxz7oSHf/Fb96lzDtYZqi/pUwFl/E7qe5NKp7Q8fEL3zKqNz5693MdagEZszFkLRvVoycSKS+CxeGPC3ekfrvYXbvBKWLLtCOuKJWz/LeaDPYOc+LQmtQob+ZdxVYNCKJfJcv/3tICKFsXtKhsXf44NyDWz0Rwk5v0G3epPCdt8fE3jhs8uzlaG/QYnLouKWzZUEdh7hl83i+EhTgP5R+b5MKCJcPq+VbUN8DrwUVckwcFn48gpMFFiOvtu7iyxOi8P+RvjsBz5Uqp1YECpCE0DKHrpGNFB5LhsU9K82LLI7HkMEbGDNq0QTwzLc4Tge+IgtN/sS/ex3mSo8OKJyWNZiD9ZT+mo0NoZyH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(8936002)(66556008)(66476007)(66946007)(4326008)(316002)(186003)(2616005)(31696002)(508600001)(6666004)(6512007)(6506007)(86362001)(6486002)(38100700002)(31686004)(2906002)(66574015)(36756003)(83380400001)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHpIb252Sm00SFhNbXJoeFpzMGxsUHl2OVFWKytPMGQwSTlCbld0cFNkelBz?=
 =?utf-8?B?cWFiQnlsMEhwTHJWZkJMcFF0ZlBweEJtRHJlSERwNU9JSjhBVjRwVWVWR1ZE?=
 =?utf-8?B?SCtianh6cklVRWJrdnFNd0djNnJYbkd1QUJSRzZiOEMrcGpEeVIrempORlRa?=
 =?utf-8?B?S2hBMk1pakg3MXBSVkxNcFVKb2JMSWtUcUlueVF0WUFWYW1lTGJ6UVFrMHM0?=
 =?utf-8?B?WjdoeGsvNHFKNjNnSGtpdVZGREViSHJyRE5rMnVwK01RaFF6eHNWUDVJUE51?=
 =?utf-8?B?RXRrRnVJM2tWbmFFUW9Jb0pwSWhTQ0NRdHdtdXozdGZzVThqa0dQQ09mdWFI?=
 =?utf-8?B?OVJBaFJ1dERaY20rUmNVcEl4L2dPTmdNRVZDWlhDZTFvdjlvSno5UGhFdzBC?=
 =?utf-8?B?Z3FWYnM2aHlUaWtlQy91Ulh4bllNUFByTDBxZ2xmSnVJRm1TejhyNENxM3Rv?=
 =?utf-8?B?dTdDanBzdHp4aERVaWxpTnppQUpSbzFPclRSTDkrQjRIalAvaG5ONXMvT2lK?=
 =?utf-8?B?allIZGpzNzYyMzBUcjAwY3FVQ29XVnc5WXVrK2V1MjZaRFV1NmpsSDR0Tkdl?=
 =?utf-8?B?WHdQVW1HUnljUTk1RFpPaktwOU5tMytrNkhlZlJldnNiRXdoeFh5TXNkV2N5?=
 =?utf-8?B?R0drK2ZMa1VFazE5SzdONk9lYU9heGR2Y1dUbkd5cGpxSklMaHM2SXAzZDdw?=
 =?utf-8?B?RUhxZUxHRTNLV3Z2cjJrc0RPcmlhQUxnMklOMVp0eTdMVFJUSHNnYW40cFJL?=
 =?utf-8?B?Z09YTlF5Z2xOc1NhRGJDUFVrY1RjMFg2ZjQ3L01TNkt2Y1BYTjBJSnAyaUlM?=
 =?utf-8?B?b2VHZUdVbTM1dlFVMjU1V3FhRkp4VUphTlhLMjEzcTJNektObjZVeEU4NE82?=
 =?utf-8?B?S0JXVGNqY3N1SzVNUTlvcnk0aTdOWkJQOGJ5eWZHS3ZEdkFZUklRY3BxWUxP?=
 =?utf-8?B?MnJmcGNlMzRSVy9RTVU2RlVEeUpQOEVIMHRtODhUZjBhVTNmWmVZZi84QUpq?=
 =?utf-8?B?elJjTUhhQ1RvRGJ5b2Jqb0dZQXpoMUxrOFF3bW8xSFVEQ2VDQWQ5aStIRTd1?=
 =?utf-8?B?dzVXaXV6aTNiNnFOQTF2eWNlNnpxeHNyVzJsY3VCU2diY0VlTGlQdy9PSDdn?=
 =?utf-8?B?bXQxd3FPY1h4YnBVQXE3Smk3S0FVamtYU254UWFtc3krSFZkL04vUWZiblRD?=
 =?utf-8?B?T1hBUkhWNnErTkNuRXYrTjZRZmpKMnZ3Ykc5SGREZU1KUFl2NWUwN09vcmNO?=
 =?utf-8?B?WVBZM3krWnd3RWk0ajE0M0REWmtiTVdEaUM3T0VLajFNaEhHNk9LS3UxU1hV?=
 =?utf-8?B?QU8xcXQyaERSVUJHNEZiV3A4dzJXSVVhR1kwM25mT1M3TFh6bXJwUzB0d2dU?=
 =?utf-8?B?UW1ER3QybkVEZklDVUhVa2JObk1lUnltSmJ3U2JNR21nc0FUaWlQUGF2OGV1?=
 =?utf-8?B?WXpUMG0xRlp5eXVPbTBiN1ZRZExJZnh4TitiYjFSNjhOZlZBQStFUE15Z254?=
 =?utf-8?B?UlVJME9LanBiQ0tWWWlwcmdWZTFoNHlmWjlGU1N6aWx2WW5Nb3cvbkhqcVpD?=
 =?utf-8?B?TFYybm9va21wZzR1b0Nab2p0Z3RPd0EyaDU5Y1l6bGR3bDU0YjJvMEJmVURr?=
 =?utf-8?B?RTNaVVpZN0J2VnFQOFVkMEY3cFhmZ252Q2YveWNiZUI0UXZ5WldJMktEMDM0?=
 =?utf-8?B?RmlZWlJBcC9qb3phYjZqNnN0M0lTeEZYSFc1MDZPN3lheGR1UWFtOWxPTENo?=
 =?utf-8?B?d2twV0F5YnVLM0lLM0J6cVJnVzFLbkoxVmV6TmRvL1RBZkwxcnRiYUZEbEJ1?=
 =?utf-8?B?WDMycjBNaWdENWtUSTdLMmhURTM0ajh5RnNwN1dyQ2dQMGFqVXdRL0VqTkJG?=
 =?utf-8?B?MkhHTlpCRVA3RVlEZVZ5YWtqS1p3MDRrN0tLOVpiN3FaalgvQkdCeFhQVGRH?=
 =?utf-8?B?aERpWVM0OHR2bWZTdncyZE9FNHBHQXU0S0phSFk0WlFWUUhmZkUvV0hxUzN6?=
 =?utf-8?B?c0dJTzZadDRraWNhM3ZVbTZHT0tUampDcUpJYWwvbitKNmVOdUQrbmhKM09o?=
 =?utf-8?B?blU5bXAzTnBXTXEzbkZVTVNLbzRFTFRyMWZmTCszR1REVjFkVXNpM2o1dzZS?=
 =?utf-8?B?bjdETVlKamdaVHI5YytudVFaN1E2U0lRbUFWbmFsVlVOQlNJKzhaNlRHaXdM?=
 =?utf-8?Q?3YKfxTF1y28Z1UAthdd+4rc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24861771-1848-43df-3552-08d9ef9cc7ac
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 09:31:29.5711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CiYCxJBefsw8Uqpej09Fzt75cR9c0k38/CShQkVDvultQX+Ric0i6Mgb/YT/D/W6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2841
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
Cc: alexander.deucher@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.02.22 um 10:16 schrieb Somalapuram Amaranath:
> Dump the list of register values to trace event on GPU reset.
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>

One nit pick below, with that fixed Reviewed-by: Christian König 
<christian.koenig@amd.com>.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 ++++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 16 ++++++++++++++++
>   2 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1e651b959141..4e11a93134cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4534,6 +4534,19 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   	return r;
>   }
>   
> +static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
> +{
> +	int i;
> +	uint32_t reg_value;

We usually try to declare variables like "i" or "r"/"ret" last and 
longer lines first.

Regards,
Christian.

> +
> +	for (i = 0; i < adev->n_regs; i++) {
> +		reg_value = RREG32(adev->reset_dump_reg_list[i]);
> +		trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i], reg_value);
> +	}
> +
> +	return 0;
> +}
> +
>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   			 struct amdgpu_reset_context *reset_context)
>   {
> @@ -4567,8 +4580,10 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   				tmp_adev->gmc.xgmi.pending_reset = false;
>   				if (!queue_work(system_unbound_wq, &tmp_adev->xgmi_reset_work))
>   					r = -EALREADY;
> -			} else
> +			} else {
> +				amdgpu_reset_reg_dumps(tmp_adev);
>   				r = amdgpu_asic_reset(tmp_adev);
> +			}
>   
>   			if (r) {
>   				dev_err(tmp_adev->dev, "ASIC reset failed with error, %d for drm dev, %s",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index d855cb53c7e0..b9637925e85c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -537,6 +537,22 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>   		      __entry->seqno)
>   );
>   
> +TRACE_EVENT(amdgpu_reset_reg_dumps,
> +	    TP_PROTO(uint32_t address, uint32_t value),
> +	    TP_ARGS(address, value),
> +	    TP_STRUCT__entry(
> +			     __field(uint32_t, address)
> +			     __field(uint32_t, value)
> +			     ),
> +	    TP_fast_assign(
> +			   __entry->address = address;
> +			   __entry->value = value;
> +			   ),
> +	    TP_printk("amdgpu register dump 0x%x: 0x%x",
> +		      __entry->address,
> +		      __entry->value)
> +);
> +
>   #undef AMDGPU_JOB_GET_TIMELINE_NAME
>   #endif
>   


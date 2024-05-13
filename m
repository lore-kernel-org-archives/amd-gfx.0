Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434DCC25B74
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 17:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB01610E8C1;
	Mon, 13 May 2024 17:11:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ulhs8037";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F9E10E8C2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 17:11:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HA95RusTCVVW/WT4GC21Y0uv4n1XPgqcGcoZ8NAxn08virneHHO2+MIkmUSdfktdSPfE14D9RoDtQD/7yHSRdlVvUc9CzstAG4f9uCcF1runjtoVh3xaRWDXxY9+B0rG3j9s9+cogeBtyDcLH1kpnk8hmNABvqm6Z+4MOSgSFeaMG+UehwXvkLuR3yzV8AJLInM0BLm+6RR5ELSoiOOmhrj504/Anlc4dqAbySQvvvB5pxgiKl1nCL0UqggwsGnfFqhXlLnaiCwfg89gVi1kL3imL+IdwjRg5n/iaCvJ/jjeXzyxEHZT8hnbuWygEoZf3XyNLMsxMtd3XAu4iu30FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJtRb5GRuVJCFQ8A+YIi5YUIrLguvIbIWrYW0mqcOPU=;
 b=V0l7+9aH5C8xyXZbZuSmZY99r5RMov7MR4mVFq17FHv2mIEWVG0DPmLbhNyqm5S0fwJdZOdVaT8fNUJ/7OQuPigC3zVpDqLYkGdsha+8EnPD8YgyYLpCoLFjDlv3gwlAX/hQXbcfbB9xunxa7I2grqqLiP0AL2l9tg+wI0HZ8UE8klyzEGedINbGKlQOR5/vRo4dWELlx6EhzPO7NBVENrNKeHilc3tf0yRa2BYjwOeK8Njg/plRVZVaurru/dIZtsE6rU+09N9H/HMNj16r4KmAgF+2hg/7MoZ/KmaR68nt5gc+QemWlE2jUdd2GAzzwuws+R1JxYqULx3iJ06jNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJtRb5GRuVJCFQ8A+YIi5YUIrLguvIbIWrYW0mqcOPU=;
 b=Ulhs80379/CsjwonR+8ysLlp8joJXVlcpAEYbJkKoRhK72y0iEahp8EYJ+UXpKWzz4jsZD5Xmh2ZKv8IYQ7KZQ6d4vvzBW9+9JowYCE3/aBEcXqov0DnND9HII46hp5+kdjQ7pkCBoEzZEZLExIQSwc2X+13vylLyklHUiTOR5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB8715.namprd12.prod.outlook.com (2603:10b6:208:487::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 17:11:11 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 17:11:11 +0000
Message-ID: <ee168145-3baa-4d87-b92a-b0f696a7d3d6@amd.com>
Date: Mon, 13 May 2024 19:11:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/vcn: remove irq disabling in vcn 5 suspend
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, leo.liu@amd.com, sonny.jiang@amd.com
References: <20240509184032.1463021-1-David.Wu3@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240509184032.1463021-1-David.Wu3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c2b754a-3519-4c8b-6f9d-08dc736fafe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0dHOXRBVlFPd0E3aUZici9Qa09McmtUZnhiUmg2TXh4VUZSSEJlV3dyZWxO?=
 =?utf-8?B?UGlLK2huT2xZSkEzM3lZZU8wRnE1Z0ZLSzhGUXROUWwxaVUyQVQrbS9jcmJa?=
 =?utf-8?B?WGp5VURBbk9XSStieU5XQnhXT0l1UGU5ODFweUF2TFlKNnJNalpEN095TWRv?=
 =?utf-8?B?Y0xVZUxBaTYzenJWK1dWSFpMb3h2a3dRWGpGZ3J6MTBCR3pQMUQ2L2R3ZDdR?=
 =?utf-8?B?QXdzeml4UEhDd3ZkRUlaRVd6MEFjZ2hsbG44cWk3OXFHdEZTVTZnbkJpK2o1?=
 =?utf-8?B?aDROWVpGQ1dhdXgwMFh2RFBoWUs3RkpUVDJ0Zmp1RnVRSDUvd3ZLRlByMWRz?=
 =?utf-8?B?UnprMWhuczBrbmtQdUttQVNLdjlsWk8xU0M2UGx5aHEyeE1iWEJJQWtnRjBw?=
 =?utf-8?B?ejhVMFdlV3VXbnlvcS84V0UrQ2hYWi9jN3F2QkFzMCtpWi9lTmg0YkJuTW9a?=
 =?utf-8?B?MWQ3cm5lc2IvY3BOZG1uRExPNGp5Q0ZLVDVOc05LQXJkNEpuajdBYjJIdllx?=
 =?utf-8?B?OEpPNUszRytvS2VSS2Z1eEJjeEdBNGgwQ2FkNkF1elJHK016MW1FNHVEcUdE?=
 =?utf-8?B?YkwxRGtIR0V6YlRIVVF5TGFSL1U3MmN2b3NYNENXdEVrclBVcE9qK1I5QVlP?=
 =?utf-8?B?enBpN0N2SEFPYmRXVk9heTkvT1Y5aE9BbUVSdFprRFZXZDBvRm1VTnFxeWhB?=
 =?utf-8?B?M0k5RUZXbUhNSk05UE1oTFIyVU5XNittdXhteCtvaFFuN2QwMGE0ZVJobWlL?=
 =?utf-8?B?L3BQTTQ3bS83ellMUGpySkVaT3prR3ZnWnJhTFFJVU1LOWJnQ1RmcDFpU3NM?=
 =?utf-8?B?b0hqL0pZbUtGVlRYMlAvS2FYT1UrWVp0VGtvYTc0ZTVNeG5YRUo1SzU1K3pQ?=
 =?utf-8?B?VERTTlpKWXhuU24xOUpMSnZSbmxFTS9wcmgyYjlLY0ZqVnIraFB3enVROFpu?=
 =?utf-8?B?ZThvekdrVU5WQ0NqTHVPTWtzWFg0dmIzek9BR05Dd0dPZFExcUdrN1YxUTFr?=
 =?utf-8?B?TVFPc0dvRXpmalEvNGRIaUZhakQyS0dtV2FBVnhTbDhDb3gyYnArWTVOWW5B?=
 =?utf-8?B?aG03YXJTV0xOY2drc094VkRxL0hzTjlLTjNOczdYNGpBMUp6dkI4MzlvZzUz?=
 =?utf-8?B?b01RUjVWampNWWNNMzZRMHlaQk1tZlJnWnR0a0xrbUZETXZDWUNkeG1CczMr?=
 =?utf-8?B?SXkxUXo0aHZGNjRRWGZ0Unl2S0o3YldpWEkvamZhWElmcXRBMTQ2OWNjRTNZ?=
 =?utf-8?B?Wm1BdHhIZDdnWWpOY2Flc3ZIWUcxMlRKeVdTM3RDbC9PV0xVSk05VTBxa0lp?=
 =?utf-8?B?VUkydGlCMVVvcENSeFF3SXRyRzVpY1VJNXdtS1ZUdXZhN1IxODJUa3JQT0xl?=
 =?utf-8?B?KzB3eU1qdHNDbFVmejIzajV3WFYxdm1SRm5CbThVVll2VGJwdnFIbEtzT2J5?=
 =?utf-8?B?RzIzTXRoKzcvcjYrVkJzaVJPb3hpOXdmeHFBbXA5ZnFTaDNiYy9GZUVtWFlU?=
 =?utf-8?B?QW1OSG5yd0hZckY0WlE5ZjkrKzZ3MU1vRkNPQXVocGw1RndqalVxcmgwMTRI?=
 =?utf-8?B?QksyR21qM1ZncVV0T3Q5QVFuT1p1cm9MbkJlRmozNjBWWGtpamlJa01PMVlp?=
 =?utf-8?B?QTR5N0NNMHBtQnh1Vk40dUk3SHdpTldoMXppY3pUelk0SVBsUFJnZTFsMTdJ?=
 =?utf-8?B?U2lZdzlmNUVta0UvR0d4c1QzTmZKQmsxamJVem1xeFJaRTNPY3BwaDZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3RlS1hGc0tkT20xaHpLdzlkaFhtdFRxT2pDUVBSanBKcWR5NXYvM2F6Ykdy?=
 =?utf-8?B?cUFYYWQ2M29ZeTR1S2dyQkVVbWhhMVBNcGNPalVkWlgyejZDd2pLUDBHV2dv?=
 =?utf-8?B?aFdIejBhYzdYd214M0p1dStqR1VLVmZnSWo0UW5helJHdlpxdnhhSUJ3MVJo?=
 =?utf-8?B?dDdjYVVaRklxZzBLSmRrNzl6bTlPYnNSYlMxN3NiRHAxWEhtVklVYmhhRitJ?=
 =?utf-8?B?OVc2TkxvV0VueWZWdXVSSUYyV0g3M0dhVUFiWDQwcjdQYWN3UWx4K3ErNlFD?=
 =?utf-8?B?OUlla0dmcnNraktGbytKVGJGR2Q2bWJ6Sks4d0s2bzM0MERtQW1BZlJuVjQ5?=
 =?utf-8?B?Lzd4bVJGL2NicEV6S0ZOM2J4NTh2emxVTDFDN3BhWUErS0lhZW4wTkZXa2Ry?=
 =?utf-8?B?Wjl3NWo5Z0VEVUV4Y3NsdkxFS0g2L2dld0RqYTh2UDlzdUVyWklUSHlCU3M3?=
 =?utf-8?B?bzBXS0kreHN3aU9GZFlNRzRHNUZyT3poU1haWkxQRXI3ZTh6ZFFOSlhrOUN5?=
 =?utf-8?B?NncrN0Y2UVVUWnVpWXBqUDU2eFcvcEd3VlR6cmxvSzcrUTBnWUxQc1czd0Rq?=
 =?utf-8?B?OERkMjNWanYrUlFPdXhoYUEwUWFDcFE3OWl2K3dBNnR0alhnRlg0QUpPUGhm?=
 =?utf-8?B?NUdGVjRrTGpKVHhWQ093WEZuM3ovRkIrbVVrVWJtSkZnbnhWWkorR09SSExz?=
 =?utf-8?B?b3F1Zi9qcFBsbkpTWHhQOUlLRnc3MmZYTkRnV1lHUHNiSDVhU1RpY25ydFda?=
 =?utf-8?B?dWNXR1dqcnd1VTdndVdVUmxnOUVhR2lGTm9EaUlETGh1aW5KeDNQSWJPblFT?=
 =?utf-8?B?TUZXSWZ5bFo1OUxjSkRqM3dDVGUyZ1RuaDdTQTNYVWMyclArbW5xc1NSRzR5?=
 =?utf-8?B?VDB0M1crY2lEcklYVVFWcXUzK1ZlNldKVW9SV1RadkwzZ2NLZG1QN3JVWGZY?=
 =?utf-8?B?S21hb0wvMVNFS3pDeTlOQ3VQMVl5ei9vTzdUUHVaV2grcEw4blArWTZzQnp3?=
 =?utf-8?B?cVN1YnFnMUJIbzNteXJoekwrTHBTYlVtZjVnYmxFRnNPNkpFc25QRm9CREF5?=
 =?utf-8?B?TjFicytWemJMSFlDRS9GUmtQSzl1S21BZ0htN0VCb2RTVldLYlNtNlJQcGMx?=
 =?utf-8?B?MldzdHp0ZWpzeWRxcS9DbmFORzRRVEFycUQyMmRFaWV0Y0hFc0hLYlhKNFAz?=
 =?utf-8?B?bk9aNmJ5dDJGN3pNVGlhY3g4RHhNTlgyazlGNGhNUitneUVMYkI4U0ZCdFF1?=
 =?utf-8?B?L1dhd08yWXBqM0V5aFgxM3dXRVdSQVRVK3RFVkVTdWV3WGtUZkRtWTdZVHhu?=
 =?utf-8?B?WWhyUUV5Z2tBajlYMFcyKzFTRi9ydGdPWUdjaFlvTlJMTEIvSzdGbTBaQXBT?=
 =?utf-8?B?TUtSQkljN3dyUUNzN0l0RlJtVEtUK2JLVHRveXJtSCtjaUQ5OFBkT0JST2pm?=
 =?utf-8?B?azF5aWtQZTVrdEpxZXVMQnBuQWJWZXNqT3daT1hxSDZGUm1aamVpWGtyVEx4?=
 =?utf-8?B?NVA1ZHJBem9mL2pzSS90R000OGhRdWVMSGo5OXVNUkVZd0RPYUhNZzlPTGJS?=
 =?utf-8?B?K3RBejFnZUIzTzRvM05mRVlvUkkydUM3S29UNjQvcXUwNVBJeG81NWh4ZTdL?=
 =?utf-8?B?NTAvaDdpdGFkRU5LbHFiTmdiN2JseS9wMGNhNTZ6bVpOYUN1LzY1NmRxejU2?=
 =?utf-8?B?ZTFxWHlaM3I0Qk9Wa0gzeEFMQ2t4UUhrRU9oZEpZVUdtc05kMXNvVVZHZjJW?=
 =?utf-8?B?ODk4dEZTeUd2V3Bvc251SGNaZWhTRkVxamVMbjJBcXBRZWMyVFBmSm5ieHZO?=
 =?utf-8?B?cklPN1V6bnAxZEZPVm56OW5IL040V2pSdytNTmlKYWpVRDd5SkRET2pNYU4x?=
 =?utf-8?B?WG9YV0ZrN2h4aU41YzRtU1piZVl5bU5ZQU80ZVlBU1NyMFdaQm1NMkE5ZjhW?=
 =?utf-8?B?MmhhcmxSN2tMUEU4d3RESTFoQ3JLcTF6SVhRVk1nRXRTRjBYaWhJQmRHdkdR?=
 =?utf-8?B?VEpsb3ZXZTRudmo5T2pyUG5WUzNleW5taHpvY0tKaFA5SGV6SUphaWI1eG9z?=
 =?utf-8?B?RTNTVnRXWXBMT2xCMHU3VVdiRUVSVmRMKzJMd3Q4Q2duaHRjWG9zSUU2Z0Vj?=
 =?utf-8?Q?4r70T5fauMnFNPZK1fb72/0om?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2b754a-3519-4c8b-6f9d-08dc736fafe8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 17:11:11.0872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhgRU0oBzjEw3FaRfFco0qr8QLoGtQn0UV5Ddl54MHZezETBnAOA+FICDmCTlqdg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8715
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



Am 09.05.24 um 20:40 schrieb David (Ming Qiang) Wu:
> We do not directly enable/disable VCN IRQ in vcn 5.0.0.
> And we do not handle the IRQ state as well. So the calls to
> disable IRQ and set state are removed. This effectively gets
> rid of the warining of
>        "WARN_ON(!amdgpu_irq_enabled(adev, src, type))"
> in amdgpu_irq_put().
>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 19 -------------------
>   1 file changed, 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 851975b5ce29..9b87d6a49b39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -229,8 +229,6 @@ static int vcn_v5_0_0_hw_fini(void *handle)
>   	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>   		if (adev->vcn.harvest_config & (1 << i))
>   			continue;
> -
> -		amdgpu_irq_put(adev, &adev->vcn.inst[i].irq, 0);
>   	}

Looks like you can now remove the whole for loop.

Apart from that looks good to me,
Christian.

>   
>   	return 0;
> @@ -1226,22 +1224,6 @@ static int vcn_v5_0_0_set_powergating_state(void *handle, enum amd_powergating_s
>   	return ret;
>   }
>   
> -/**
> - * vcn_v5_0_0_set_interrupt_state - set VCN block interrupt state
> - *
> - * @adev: amdgpu_device pointer
> - * @source: interrupt sources
> - * @type: interrupt types
> - * @state: interrupt states
> - *
> - * Set VCN block interrupt state
> - */
> -static int vcn_v5_0_0_set_interrupt_state(struct amdgpu_device *adev, struct amdgpu_irq_src *source,
> -	unsigned type, enum amdgpu_interrupt_state state)
> -{
> -	return 0;
> -}
> -
>   /**
>    * vcn_v5_0_0_process_interrupt - process VCN block interrupt
>    *
> @@ -1287,7 +1269,6 @@ static int vcn_v5_0_0_process_interrupt(struct amdgpu_device *adev, struct amdgp
>   }
>   
>   static const struct amdgpu_irq_src_funcs vcn_v5_0_0_irq_funcs = {
> -	.set = vcn_v5_0_0_set_interrupt_state,
>   	.process = vcn_v5_0_0_process_interrupt,
>   };
>   


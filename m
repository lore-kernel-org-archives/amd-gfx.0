Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6907AECAAA1
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 16:48:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F229410ECBA;
	Fri,  9 Sep 2022 16:48:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E4C910ECBA
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 16:48:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIDD226vu4biJw1j4DKsl8dhABwvaQx/jybI6hFdiFBIo+S6KmQYqq8+Z4n9AKe0wHrFrEXdJQEbpcspyT+zadWuLD7GWOJrTOdoPuHifq9absWXX0syKI9RnqdmzBb1/AvS3HuKlTfVEeYTxF99KcxHOUP5DERw4Znaz0rRfVo0VDlLZYovWW4Tp3g7tUNuv6fuKj0gUjZQmRKz5jdShAZoNCd9QG5nxEStWVOSaPGZjDxV37U8IpxdbrdDFZ1ovOWtpK1OGf2I8+WB/7aezOI6ZjCqCSUEpXsDT0QJNSoE43+qLey7jXlo2EieBdmHx3l/tCb5wLENDc8ysoOeyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvURy2h3xH/65E/7KSFuC3MyZpVdfYZFf//5VqcW1Cw=;
 b=UCCVYcEep+lfoZG94EOHF2y9IoOS6MCSH+TUMTWfCPollQ3rpU37rZBQXdnpUZ+3pHJfcVqdJiJsxkL48aPjwjUjZGKJLxqSPYuH3l2Em/AulGf8U6fqlDTTY7IiD0mKHiNj6ukE6OOivg/RKCnwoGkNedRbyGiGmcfLDbHzjf/U6jsPmvGpZyqirS76lRL0fmfigT974PTDCYMZMsDNKlvmrX4Zjej+kviPlgvnTln9hqT0baHuudu+UCxOwbvkCh1QVwt1QPK8eRpCdg0k7CLzinej0jqIKPW0TExZFqKSHKvLk+x+3PJ61NizdRjP5QR8rbtdE2XAIr0i2bhtcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvURy2h3xH/65E/7KSFuC3MyZpVdfYZFf//5VqcW1Cw=;
 b=45qk+Ky6i/tXjNgd+fSHiEvaKz8WL6rXdI7YfBmOjUIOiSS4B6R8PnO4GqmIabkeASFrcWCCfSFZkegk0yEsIA889RABalxPA5aUVeN5UdbQK78OP68L2pM42c7SY8hXqSi/5VHCzcv4k+aZJ4vM0iVZgLzjcuRlu09ghmlSjAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by CY8PR12MB7635.namprd12.prod.outlook.com (2603:10b6:930:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Fri, 9 Sep
 2022 16:48:39 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::80ca:c97:d395:1acf]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::80ca:c97:d395:1acf%6]) with mapi id 15.20.5612.016; Fri, 9 Sep 2022
 16:48:39 +0000
Message-ID: <22ffe89c-7724-9e86-8f9c-087d16c6a849@amd.com>
Date: Fri, 9 Sep 2022 12:48:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/4] drm/amdgpu: Modify unmap_queue format for gfx9(v2)
Content-Language: en-US
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20220909015022.557099-1-jiadong.zhu@amd.com>
 <20220909015022.557099-3-jiadong.zhu@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <20220909015022.557099-3-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::25) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB1947:EE_|CY8PR12MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: ed79e760-52e8-485b-7192-08da92832577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iGXx34wbKbkifkSNvu/5f7eD7GjceOLy5J9KU6Sqi2e4A4Wk0lgIGaTW2ehnw+FMYtViCSskY3TiAADcq6jVn0AjHLmrribpXdy6vLUMkfN5oKeB5u7zffo7NQAd6uYnfg5cZjNv8FWky4/TuCNwmd7cGaTaL1DRtDeelNOQZJklB6NN44T0FoJVZp85CiMMrovHRgkvCFaZa9rhtw9BKdeneic3UEmz0GoceWZkJue5viLSP5Q7fehGkATCXWIY/IxBhVvtObHHozXzV53QgFSgxowqbSUMggkQrX3gzR09xQOCDwOBPA/dceqW5d4uKKgMkA235M/IqCpbiQM0QjLTDxGBVxQe2iPVdlE53BTZLRD4eWA7d+kR44JSv1HKgH9tmTWSt4crnQWPTllLPxHpzk8LwvCEBqipWnYuE0t8M3HTzcnYApFetvrINiMhG/ZvhQNoHs+w6ol8IvmLqZsYaWCB/5P0kNMR8O9Wh1r1t+PRJ14vMR14sW+//MSuDa7WCvjBo8geBjJK+1nbYjFgtXhszIV/ISnj1TAiwLbf5+b14mL1j/3NNV8GXUoa/l7rMt3IXT0+s8j3crnuDREHO9t2RFOoLPHVQOhx5za8AH1B349NJlnhAmDXmWwx+LcQBFendt/JuWMh/UY0xg64Y7u2LVaPwnAKfT7hWxeb9CzQkPJel/8LSm6jShv60TmKXdmYAp981e2KK4h/SJMJRixj+icu3rkmwtG8q3WOwzYrlG1Exh0XiWOJyzpMj0+vIhlyN60ecfi1SM1/L4r4XdKTh3bbBe6xBXfbfFo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(36756003)(186003)(2616005)(53546011)(86362001)(44832011)(5660300002)(30864003)(6486002)(31696002)(478600001)(6506007)(41300700001)(31686004)(6512007)(8936002)(83380400001)(38100700002)(316002)(2906002)(8676002)(66476007)(66556008)(66946007)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmxaTmh6dStwY2F6U0VmVTZ4cmN0L3pmL2ZaOXpDS2NlTFRsKytmOEhkbTM4?=
 =?utf-8?B?N0wwV2dpY0JDNFp0a3VRbndzUWRZalI0L3NWb2U3RDJxSWhNbkhITnVQTVl5?=
 =?utf-8?B?MDBuODZva08rYVc2L0l1dzZ6RURJSmF5blFUUVZGT3dXRU1SUFJkWXpHcWlx?=
 =?utf-8?B?c2pLUm53TnVxR3l3TmNUc2VmRGYvRDVFNjJ3OE1sQm53SDd1eFc3V1ZmdGs5?=
 =?utf-8?B?c1RlRzVrbm1GNUxCQTlTMk44RUo1SkZPb1FBKzdDWFB5bzZBTUY0QVJ1YmVR?=
 =?utf-8?B?TGFwNFdaVXZxblNHeVhaTVhUMVB4K0V2QWlWT3BSZC9yU3hGeGpJeW9IRm13?=
 =?utf-8?B?ZUxOSDlvN0pqdTlmL3pFbktxVVQ2VXVFSTk4RWRPNWVUbTJTdnFIemg5UHZX?=
 =?utf-8?B?WjBUZWZYeW94SlBTT2FHM0pMOXZhcmpkUEFMZm1JMmRFdU1VMmlYYStmYVJW?=
 =?utf-8?B?WlBWQ0M3dUlRVm16ZStpV0MzWUJSVHd2bVphZis1RnNZcVNmY2ZkbDJHQmhj?=
 =?utf-8?B?c0lyZ0NTdHBCay9GVUtwQWxJVEsxMFNLVGowenIzSXNVTkpmYlJLY2x0em5M?=
 =?utf-8?B?WWVmMndxSDdwU3hoTS9QUEtPT1lFcHQrZUkrU1dqcG9CZlRwSm82aHdKelBy?=
 =?utf-8?B?am1SWnZkajZ0bzgrK1ZzNVN6dmlXcDJERXozT3BzRmpTSUZjU1JBaW83OW1H?=
 =?utf-8?B?N2Zqd3ovL0JXSDB3VnBLR3lLS2JVUGRVcTZMN25IUkRISGtic2QvOEEvNE10?=
 =?utf-8?B?TndjWTFjV1U3UkhOWTVGbU81TkxGaU14aVg2TTRGUHJsMUtzOWZTVUIvMERG?=
 =?utf-8?B?WDRndllsK0d0QXZ4YTRLaGxTamFIaHlnYmU1Y3RCQ1pHK0NrR1RnZ2tGWEto?=
 =?utf-8?B?cHRTTGNJVkxQV1JHUXAzRmc5bkJFUEE2NDc0WTl4NHh1Q1J2RGJMTENRV0U2?=
 =?utf-8?B?Mk8yQWVGSlpWTXhQMXNZcU4rcXBmZ1dQQWlHYi8yM3lNTmNtdmhrMGFyRXps?=
 =?utf-8?B?TGFXalJUbXR2SlVXVHVmUUhIOHovNDJpVklXMTdLVFM3ZTdIM0ovaVZVWHRN?=
 =?utf-8?B?V1pDRjJZUG9ucFJBMEwyT3JtdElyODhGa0RXdlozQllYUU1aYzhHc3YzNjlk?=
 =?utf-8?B?WW80STcybjRGZjZUMXBLK0R2K0F5SFcwVUlLd01mb1J3Rk96NGhqa2pkNzlN?=
 =?utf-8?B?RG1oOENZeWtCNElDcWl4OW9VMThJQm1UTDhRMSt2bVhzdWZ1QTJqandjTkZs?=
 =?utf-8?B?ZzFXWjMxOVNBTWZ3UzYxMmFGT1prTEdNdURuM3ErOFEzeFBYMXE0OFNxZ0l3?=
 =?utf-8?B?M2RCK0x1MVhyMGhIZFo2UU80Ui9xRE1VVFJad3NIVlhVYTgwMSs2Vk9IL1NT?=
 =?utf-8?B?TWRqbmtydndXQUJweThYTmtnQ0x2NjU2Sm5pRGg3T1d2dVdDRVppSmJLeWhN?=
 =?utf-8?B?V0l2RzVHM21WeWtkdmF3K2RnMzA4bG93QkgvazVhU0ZUS1lDQzMyQXhYVE5t?=
 =?utf-8?B?NXBMQi9JQXZYb0Y0akNaYkhYR0hMaUNQY3FHaXMwWXRTeUc3Z20ydWM1OFZz?=
 =?utf-8?B?V0VOaUtZWTFQcjRvdkFDdXMyVHQyOHl4dmRYQ2lxa0ErYU5EOTN6RGRsVEZr?=
 =?utf-8?B?cjRrTHNMOUVBTEQ0NThjbFpNcVFEZHB2aXNoUUdndU01V0lrTkJ2RUhXWitS?=
 =?utf-8?B?dHFpV2ZYUzVBdlhqMW1lZ2tPWXFYTDF3cktYbENuK2VmN1I4bkw4Nk1aczQx?=
 =?utf-8?B?VmFFd1hReEFvM3NQT2VuZGdQd3dNK3RsZEpzK0dWQXpOTEQrZXlDTGNTWEtI?=
 =?utf-8?B?Zi9XTyt5ZzBXTUJTcnFnR2M1YWljblhNWVphd2VwWGZzQkhuK0RzR2Nqd29W?=
 =?utf-8?B?ZW9XSG5jaFgyMXc5OTJLYlNabm5HemNZby9TOEF3WUVLZjZteFlYNHpwZWQ1?=
 =?utf-8?B?bTBIM1YyTGdsdmkxbThIWlVWajMyVGdMa3RsbUNsZXlUVGtyTjcrZGZvSHNH?=
 =?utf-8?B?SmVaQTFVckZxVHdTRVJPMzhTVElsbndNSnB0WWJxVGozckZHTGRrMzkxeVQy?=
 =?utf-8?B?QU9PeGlUUWxIU2IxR0NuMG56VFlNbGE0SnA2WHl1TmxLYWVlVTVTUHVvSWdM?=
 =?utf-8?B?UXNuak5LN3R1b1EyVWM2MlBjVHpBSExvajQzY1hHVkZVMUc2ZGxXa1RUckJB?=
 =?utf-8?Q?9m6D/YmTcC//s+ucarjIZaJnCRcXmvC2CfNMv2X3QJ71?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed79e760-52e8-485b-7192-08da92832577
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 16:48:39.4708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XurDZKcacE8Pwt33UeHW+T5/MHVJRBTDicG/9+N3NVWnUsa7CqjT8uFkMyuUIeDVGBSYkQZznC+Dn3NWL6LEoA==
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

Really can't say to much here as I am not really familiar with queues 
map/unmap...

Andrey

On 2022-09-08 21:50, jiadong.zhu@amd.com wrote:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
>
> 1. Modify the unmap_queue package on gfx9.
>     Add trailing fence to track the preemption done.
> 2. Modify emit_ce_meta emit_de_meta functions
>     for the resumed ibs.
>
> v2: restyle code not to use ternary operator.
>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 181 +++++++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/soc15d.h      |   2 +
>   3 files changed, 155 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index ba6d8c753f7e..d3155dc86c07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -60,6 +60,7 @@ enum amdgpu_ring_priority_level {
>   #define AMDGPU_FENCE_FLAG_64BIT         (1 << 0)
>   #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
>   #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)
> +#define AMDGPU_FENCE_FLAG_EXEC          (1 << 3)
>   
>   #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 774e44e1074a..89a5c45b1006 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -753,7 +753,7 @@ static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
>   static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
>   				struct amdgpu_cu_info *cu_info);
>   static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
> -static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring);
> +static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume);
>   static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);
>   static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
>   					  void *ras_error_status);
> @@ -826,9 +826,10 @@ static void gfx_v9_0_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
>   			PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(ring->doorbell_index));
>   
>   	if (action == PREEMPT_QUEUES_NO_UNMAP) {
> -		amdgpu_ring_write(kiq_ring, lower_32_bits(gpu_addr));
> -		amdgpu_ring_write(kiq_ring, upper_32_bits(gpu_addr));
> -		amdgpu_ring_write(kiq_ring, seq);
> +		amdgpu_ring_write(kiq_ring, lower_32_bits(ring->wptr & ring->buf_mask));
> +		amdgpu_ring_write(kiq_ring, 0);
> +		amdgpu_ring_write(kiq_ring, 0);
> +
>   	} else {
>   		amdgpu_ring_write(kiq_ring, 0);
>   		amdgpu_ring_write(kiq_ring, 0);
> @@ -5356,11 +5357,16 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>   
>   	control |= ib->length_dw | (vmid << 24);
>   
> -	if (amdgpu_sriov_vf(ring->adev) && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
> +	if ((amdgpu_sriov_vf(ring->adev) || amdgpu_mcbp) && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
>   		control |= INDIRECT_BUFFER_PRE_ENB(1);
>   
> +		if (flags & AMDGPU_IB_PREEMPTED)
> +			control |= INDIRECT_BUFFER_PRE_RESUME(1);
> +
>   		if (!(ib->flags & AMDGPU_IB_FLAG_CE) && vmid)
> -			gfx_v9_0_ring_emit_de_meta(ring);
> +			gfx_v9_0_ring_emit_de_meta(ring,
> +				 (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ?
> +					true : false);
>   	}
>   
>   	amdgpu_ring_write(ring, header);
> @@ -5415,17 +5421,23 @@ static void gfx_v9_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>   	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
>   	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
>   	bool writeback = flags & AMDGPU_FENCE_FLAG_TC_WB_ONLY;
> +	bool exec = flags & AMDGPU_FENCE_FLAG_EXEC;
> +	uint32_t dw2 = 0;
>   
>   	/* RELEASE_MEM - flush caches, send int */
>   	amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6));
> -	amdgpu_ring_write(ring, ((writeback ? (EOP_TC_WB_ACTION_EN |
> -					       EOP_TC_NC_ACTION_EN) :
> -					      (EOP_TCL1_ACTION_EN |
> -					       EOP_TC_ACTION_EN |
> -					       EOP_TC_WB_ACTION_EN |
> -					       EOP_TC_MD_ACTION_EN)) |
> -				 EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
> -				 EVENT_INDEX(5)));
> +
> +	if (writeback) {
> +		dw2 = EOP_TC_WB_ACTION_EN | EOP_TC_NC_ACTION_EN;
> +	} else {
> +		dw2 = EOP_TCL1_ACTION_EN | EOP_TC_ACTION_EN |
> +				EOP_TC_WB_ACTION_EN | EOP_TC_MD_ACTION_EN;
> +	}
> +	dw2 |= EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) | EVENT_INDEX(5);
> +	if (exec)
> +		dw2 |= EOP_EXEC;
> +
> +	amdgpu_ring_write(ring, dw2);
>   	amdgpu_ring_write(ring, DATA_SEL(write64bit ? 2 : 1) | INT_SEL(int_sel ? 2 : 0));
>   
>   	/*
> @@ -5530,33 +5542,135 @@ static void gfx_v9_ring_emit_sb(struct amdgpu_ring *ring)
>   	amdgpu_ring_write(ring, 0);
>   }
>   
> -static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_ring *ring)
> +static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume)
>   {
> +	struct amdgpu_device *adev = ring->adev;
>   	struct v9_ce_ib_state ce_payload = {0};
> -	uint64_t csa_addr;
> +	uint64_t offset, ce_payload_gpu_addr;
> +	void *ce_payload_cpu_addr;
>   	int cnt;
>   
>   	cnt = (sizeof(ce_payload) >> 2) + 4 - 2;
> -	csa_addr = amdgpu_csa_vaddr(ring->adev);
> +
> +	if (ring->is_mes_queue) {
> +		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
> +				  gfx[0].gfx_meta_data) +
> +			offsetof(struct v9_gfx_meta_data, ce_payload);
> +		ce_payload_gpu_addr =
> +			amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> +		ce_payload_cpu_addr =
> +			amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +	} else {
> +		offset = offsetof(struct v9_gfx_meta_data, ce_payload);
> +		ce_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
> +		ce_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
> +	}
>   
>   	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, cnt));
>   	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(2) |
>   				 WRITE_DATA_DST_SEL(8) |
>   				 WR_CONFIRM) |
>   				 WRITE_DATA_CACHE_POLICY(0));
> -	amdgpu_ring_write(ring, lower_32_bits(csa_addr + offsetof(struct v9_gfx_meta_data, ce_payload)));
> -	amdgpu_ring_write(ring, upper_32_bits(csa_addr + offsetof(struct v9_gfx_meta_data, ce_payload)));
> -	amdgpu_ring_write_multiple(ring, (void *)&ce_payload, sizeof(ce_payload) >> 2);
> +	amdgpu_ring_write(ring, lower_32_bits(ce_payload_gpu_addr));
> +	amdgpu_ring_write(ring, upper_32_bits(ce_payload_gpu_addr));
> +
> +	if (resume)
> +		amdgpu_ring_write_multiple(ring, ce_payload_cpu_addr,
> +					   sizeof(ce_payload) >> 2);
> +	else
> +		amdgpu_ring_write_multiple(ring, (void *)&ce_payload,
> +					   sizeof(ce_payload) >> 2);
> +}
> +
> +static int gfx_v9_0_ring_preempt_ib(struct amdgpu_ring *ring)
> +{
> +	int i, r = 0;
> +	struct amdgpu_device *adev = ring->adev;
> +	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
> +	struct amdgpu_ring *kiq_ring = &kiq->ring;
> +	unsigned long flags;
> +
> +	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&kiq->ring_lock, flags);
> +
> +	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
> +		spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +		return -ENOMEM;
> +	}
> +
> +	/* assert preemption condition */
> +	amdgpu_ring_set_preempt_cond_exec(ring, false);
> +
> +	ring->trail_seq += 1;
> +	amdgpu_ring_alloc(ring, 13);
> +	gfx_v9_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
> +				  ring->trail_seq, AMDGPU_FENCE_FLAG_EXEC);
> +	/*reset the CP_VMID_PREEMPT after trailing fence*/
> +	amdgpu_ring_emit_wreg(ring,
> +				  SOC15_REG_OFFSET(GC, 0, mmCP_VMID_PREEMPT),
> +				  0x0);
> +
> +	/* assert IB preemption, emit the trailing fence */
> +	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMAP,
> +				   ring->trail_fence_gpu_addr,
> +				   ring->trail_seq);
> +
> +	amdgpu_ring_commit(kiq_ring);
> +	spin_unlock_irqrestore(&kiq->ring_lock, flags);
> +
> +	/* poll the trailing fence */
> +	for (i = 0; i < adev->usec_timeout; i++) {
> +		if (ring->trail_seq ==
> +		    le32_to_cpu(*(ring->trail_fence_cpu_addr)))
> +			break;
> +		udelay(1);
> +	}
> +
> +	if (i >= adev->usec_timeout) {
> +		r = -EINVAL;
> +		DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
> +	}
> +
> +	amdgpu_ring_commit(ring);
> +
> +	/* deassert preemption condition */
> +	amdgpu_ring_set_preempt_cond_exec(ring, true);
> +	return r;
>   }
>   
> -static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
> +static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
>   {
> +	struct amdgpu_device *adev = ring->adev;
>   	struct v9_de_ib_state de_payload = {0};
> -	uint64_t csa_addr, gds_addr;
> +	uint64_t offset, gds_addr, de_payload_gpu_addr;
> +	void *de_payload_cpu_addr;
>   	int cnt;
>   
> -	csa_addr = amdgpu_csa_vaddr(ring->adev);
> -	gds_addr = csa_addr + 4096;
> +	if (ring->is_mes_queue) {
> +		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
> +				  gfx[0].gfx_meta_data) +
> +			offsetof(struct v9_gfx_meta_data, de_payload);
> +		de_payload_gpu_addr =
> +			amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> +		de_payload_cpu_addr =
> +			amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset);
> +
> +		offset = offsetof(struct amdgpu_mes_ctx_meta_data,
> +				  gfx[0].gds_backup) +
> +			offsetof(struct v9_gfx_meta_data, de_payload);
> +		gds_addr = amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset);
> +	} else {
> +		offset = offsetof(struct v9_gfx_meta_data, de_payload);
> +		de_payload_gpu_addr = amdgpu_csa_vaddr(ring->adev) + offset;
> +		de_payload_cpu_addr = adev->virt.csa_cpu_addr + offset;
> +
> +		gds_addr = ALIGN(amdgpu_csa_vaddr(ring->adev) +
> +				 AMDGPU_CSA_SIZE - adev->gds.gds_size,
> +				 PAGE_SIZE);
> +	}
> +
>   	de_payload.gds_backup_addrlo = lower_32_bits(gds_addr);
>   	de_payload.gds_backup_addrhi = upper_32_bits(gds_addr);
>   
> @@ -5566,9 +5680,15 @@ static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
>   				 WRITE_DATA_DST_SEL(8) |
>   				 WR_CONFIRM) |
>   				 WRITE_DATA_CACHE_POLICY(0));
> -	amdgpu_ring_write(ring, lower_32_bits(csa_addr + offsetof(struct v9_gfx_meta_data, de_payload)));
> -	amdgpu_ring_write(ring, upper_32_bits(csa_addr + offsetof(struct v9_gfx_meta_data, de_payload)));
> -	amdgpu_ring_write_multiple(ring, (void *)&de_payload, sizeof(de_payload) >> 2);
> +	amdgpu_ring_write(ring, lower_32_bits(de_payload_gpu_addr));
> +	amdgpu_ring_write(ring, upper_32_bits(de_payload_gpu_addr));
> +
> +	if (resume)
> +		amdgpu_ring_write_multiple(ring, de_payload_cpu_addr,
> +					   sizeof(de_payload) >> 2);
> +	else
> +		amdgpu_ring_write_multiple(ring, (void *)&de_payload,
> +					   sizeof(de_payload) >> 2);
>   }
>   
>   static void gfx_v9_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start,
> @@ -5584,8 +5704,10 @@ static void gfx_v9_ring_emit_cntxcntl(struct amdgpu_ring *ring, uint32_t flags)
>   {
>   	uint32_t dw2 = 0;
>   
> -	if (amdgpu_sriov_vf(ring->adev))
> -		gfx_v9_0_ring_emit_ce_meta(ring);
> +	if (amdgpu_sriov_vf(ring->adev) || amdgpu_mcbp)
> +		gfx_v9_0_ring_emit_ce_meta(ring,
> +					(!amdgpu_sriov_vf(ring->adev) &&
> +						flags & AMDGPU_IB_PREEMPTED) ? true : false);
>   
>   	dw2 |= 0x80000000; /* set load_enable otherwise this package is just NOPs */
>   	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
> @@ -6912,6 +7034,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
>   	.emit_cntxcntl = gfx_v9_ring_emit_cntxcntl,
>   	.init_cond_exec = gfx_v9_0_ring_emit_init_cond_exec,
>   	.patch_cond_exec = gfx_v9_0_ring_emit_patch_cond_exec,
> +	.preempt_ib = gfx_v9_0_ring_preempt_ib,
>   	.emit_frame_cntl = gfx_v9_0_ring_emit_frame_cntl,
>   	.emit_wreg = gfx_v9_0_ring_emit_wreg,
>   	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/amdgpu/soc15d.h
> index 799925d22fc8..614e9f8467fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
> @@ -162,6 +162,7 @@
>   		 * 2 - Bypass
>   		 */
>   #define     INDIRECT_BUFFER_PRE_ENB(x)		 ((x) << 21)
> +#define     INDIRECT_BUFFER_PRE_RESUME(x)           ((x) << 30)
>   #define	PACKET3_COPY_DATA				0x40
>   #define	PACKET3_PFP_SYNC_ME				0x42
>   #define	PACKET3_COND_WRITE				0x45
> @@ -184,6 +185,7 @@
>   #define		EOP_TC_ACTION_EN                        (1 << 17) /* L2 */
>   #define		EOP_TC_NC_ACTION_EN			(1 << 19)
>   #define		EOP_TC_MD_ACTION_EN			(1 << 21) /* L2 metadata */
> +#define		EOP_EXEC					(1 << 28) /* For Trailing Fence */
>   
>   #define		DATA_SEL(x)                             ((x) << 29)
>   		/* 0 - discard

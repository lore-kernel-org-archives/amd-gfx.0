Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6DEC32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 14:52:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 664D710E594;
	Wed, 28 Sep 2022 14:52:51 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F72710E3D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 14:52:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJAHVVYWnnyzwZe50mCoBOSQ7FWhd7usHQT39yQC11KTMyyVpUsBWna6znLBKTRcWjz9owlotMtgKsMnSBjxLSTARc+s5nZR6Aktl5AL8mqnSqDmN5KXltXtuWG8PQXYbJwaXETBL50G3RDDK7wdXzr5Br3CnzCJkR6lnsBodfwbSwQwq+14klDRy6TLC7BhpBvZSksLwHIRV6TsY8gPHB5i5pHTBzFFmwbjo+wQ88d+Dlnj8meKhwbqPf7WzkOJUFgTXLFIfAe+363A+0RarAvmWibIC3MAlJOatLGCCglFJJMEGPh8dM8PdpnXQaW6Dipqy9Fsmelepuu8iggCXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRhRA3VGVeSPdh9cFhCFp8igUT987c1+TbVYoPs8mRs=;
 b=FUwrwu8PfI57Hvc7yEiGDwIq1esEha0iE8TxSLGWBVGTpDnq+esRA0yCG1UG+/PG+FbbipHNJf0E2kmZuJG9kZODphARxNDi+OKKphgmNMP0IpbJ2qF8Zoyhlwe+bUaNL2s+GFWMqN3l+rf7i7rUzi/9D6PoDJ+UVtAIFv8Z2NKt2Z97cdClGKuXYqzR5QDan8pC3G2HA+qnFptzP58YH2dxrGLQsAoMO7cTz9T/K6fi3IRuKZ5VGQhVd0HyJ33IcS9xExSoe/dZmtggGGUYz4uLuuo2fuFJRyqeZEYc2m+kIittPlKxIVcnLkyu579qM5XCAR+ykuv0d3UKCdELDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRhRA3VGVeSPdh9cFhCFp8igUT987c1+TbVYoPs8mRs=;
 b=mJSi6GFH3kan4aXFq6kuitgRZEPI6elzq+tuE2De1nywBfLJdOPAcSeNv41BynZJ4YjZcbMHK8puXaq+BCV2L0q3UQ+3Zx5xO8LbHwq4QxPJ14LUUE27cGFVCJfvUYC5E+ygmsneHDXIceFthqNC5I2yOy/dB0+rb2SjslTHIdg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17; Wed, 28 Sep 2022 14:52:45 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::8423:8031:a9f3:20d5]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::8423:8031:a9f3:20d5%8]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 14:52:45 +0000
Message-ID: <b410a60f-75bb-e0b5-a618-9cfff6601b75@amd.com>
Date: Wed, 28 Sep 2022 10:53:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] drm/amdgpu: Fix mc_umc_status used uninitialized warning
Content-Language: en-US
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
References: <20220928144951.89514-1-sunpeng.li@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20220928144951.89514-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0024.namprd20.prod.outlook.com
 (2603:10b6:610:58::34) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d38dc9e-8493-4f7a-385d-08daa1611a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fRJ+OPpyvMr9T/2eLp1exufQYjLxImKZ7sm79L10ql4P/eJx1Kb0n+YpuQ2WjD7qgMh6ar3DrE5t+rO3oKDM7GfIVMEd+hR0QWPcrPyCmPnMlpxaRTMYMrrwNNL8DGknJCyOV+QCegkJ4n89RlAzB4HbTVATnuzfGUz+8OmV1lrq1eP1Yvs5oGzwmVJJaJKC3NZsSM5LdmzkEYm30TSbR8fONIpTFda0EwtXOLQVwniwdNwaSc/8x2h0BmDu3ci5w9xzKeBxep1AIYZjHrY5pCF+cofmHLeCvapoORHajo4RA7UJiznX+ev1MW3VD7O2rVKU/nC2Y2/p5PjeOfASWyok9mSBJGdWiCClEH2Yoj9A84J/AkBwS1gfuhkuUUUBiJG8ZHo6e0NWVXg6k7ohTnUJGGWNT4Ck4UkaCnZlQg0D/a7UOxdivsn7IV1KfObY05ZWF38nTg3g4iZUSkAG5+dEhdaaoU7ljyK+mmWCkvTmIUe18DhF1Y5WLlZRsVh1wr80wVjGy+wTxyDrVqt3dJUyppSNJuc0niINA/ke/LYy+ikvDs/Z5jYFCw9M9GjfwcRqS8mr2ocg1uRshryPMhawPj8ocOHKFcNrh1bXaBmW+K1THvQMmxDCX26kXoMGdOiSQ/DPkMAsZtY8YCZ7nAG2OSptmxDMHBdEPQyDNvUp4lcJbK6G1uaAhOwrM5NT7fDX13unMdwE/8awwhzdGv3Dv7yqqSbzTpo7/e4EYopoSmCfAolu6eiAZYAeWsRY6ehOFlDc1u+KOlkpFBBe655rmq0SsxLFqjPypPXbWhk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199015)(316002)(8676002)(6486002)(478600001)(5660300002)(38100700002)(66556008)(66476007)(4326008)(66946007)(41300700001)(8936002)(36756003)(83380400001)(6666004)(6506007)(53546011)(2616005)(86362001)(6512007)(31696002)(26005)(186003)(31686004)(44832011)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEpWK3krYjRFYlp2a1FlSmZBUEJWZlZnWVVhcGVmbFBGOWNHMmxsYVZEbXV4?=
 =?utf-8?B?RXFyOTJRUll1TXJSZjZpUUUwUURvUW4zSXpwRnpTQ2xHaXlhRkc4a1V4WHd2?=
 =?utf-8?B?SXNSR1c3c1hJVlhnUzlLWUsybytTQWpqTVpQNTZ5V2hNdlE4KzJnVDhLUkxx?=
 =?utf-8?B?djVYQ3QzQktVU2xNbUsxTVljak1UdFAwbk9wZ0J6OTJSZDFjRzBjeFF1b1Ev?=
 =?utf-8?B?N3MrWHhLUVhUM3gzdnpZRXBRUVFWRUdQTnM4b3AwNHlvSlpJWG1GbEFqSis0?=
 =?utf-8?B?YkxxZVJuakxBZHF5OTc4eDFueENIV1FBcy8vTzhjK2QrYTNMbWxuUGw1RVBx?=
 =?utf-8?B?aXIyN2hBdUdTQk0zTk9nS2lJZnNORDlhTG1hSWFKYWdTbC9ScGJiMW9USC9T?=
 =?utf-8?B?QjY3TCtXdjl0eUsxUERTUFV0ZGlFc2NiWHl4UkxseDFmYU9MalpSeVk5eXlI?=
 =?utf-8?B?aGNkRlBtUGdiTDRhZDJsNmZqTUpoU21uS2Y5Mkl0TkdCRUdjK3ZzUVNDS3Nm?=
 =?utf-8?B?aVR3UVdQbS9Zdlp4RE9uU3FFMVoraUc5UytKRjZMczRnbUUzU2VsdUhTS2lJ?=
 =?utf-8?B?NkJNYXJVRFFuUENXaXFoYUtzSEdhZE0yRTVFNEQ1UnY3R2hWU1FRZ0NTL2do?=
 =?utf-8?B?RUxaOW92RmxlSjUxTnprS29tWTNtd0Q0dnNJZG5LWEZCOHZuSmdqMTNqcS9q?=
 =?utf-8?B?citJNWtGckZ1ak03ejhMNWFNeGFhNzJlU0g4VDliSkMxalFrQS9Gb2pCb2s5?=
 =?utf-8?B?bzhhazJHejJmMnNyRDVaTE1UR044UmpMSlZPSTU5Qi9VWldxRDhsNWdWcWZh?=
 =?utf-8?B?dUd3bU0yZ1NJWlhpNUYzRWRJVUxsOG42YnhmeFBkbzI3aFNLSS9tbXNlZm9t?=
 =?utf-8?B?ZThmQ2dlNTdwMVVTbmk5dmhPK1Z6elZHNXYwUDFiamJBaWRZZXlOTjBoS0V1?=
 =?utf-8?B?R2RqY0pPd0xZSythT1p6WTV6U2FRcFB0b1cxeTdLSzdaK2t2dDRoQkJ3SFoz?=
 =?utf-8?B?aGFiU1VOL3BqNnlGaGRRTE5wSnhMdXV3cWl5QXdpNkRFdjhySkpZQXJCdnEz?=
 =?utf-8?B?K00zUXFvV0JDTVdoblpZV0hWS3EreWxTU1A4ZHAwR0k3WUVKNGpWUkFib2lO?=
 =?utf-8?B?citCVUxKQ3pFSGxYUWVTM2hHM1UwQmJ4bGh0MndsME8vWVhFeGljVEczMnZB?=
 =?utf-8?B?ZDcxbWhLNm91Y00rdzEzTjd6a2ZWeEdrd2dsd25vc2s4aHV6MFZ6M3E2Y1Zx?=
 =?utf-8?B?MnZvK0IxYXlQNDNNK1dkcnBhTWpLb1RTdnI2QVB1MGU3Rzd6TkdybytlalR4?=
 =?utf-8?B?Ym1XamZvUU4ybVR5WUQ1Um11dTZIUzFLaDF5bTBWNWNDUGltN2xUK2ZaMVM5?=
 =?utf-8?B?SVBOZWFCN2FVYmJva01BaVdwaXhwcDVRdEhHeDcvTG9jZzRPT2xkb3FLcjNN?=
 =?utf-8?B?VFFJNEsxZVNWb2lOYVR6K1gvMC9kWFoycGI2OE9hZTkwRTNTV2lpWFpFSjZL?=
 =?utf-8?B?Wk9vUW1YbzA2U3MydmZKSVpycElEeHdaYi9PZE93c2ppWjlxbHJLUFhYbkt0?=
 =?utf-8?B?RWFGYldWbkFZTStYVlIxRHNza0VJVDF4TTg4anhWSUIrSG5PNk1SSXZIWnc3?=
 =?utf-8?B?WXl0SE1oLzR1ZU9wNjB4Z1Ewd3l2bFk5M1lmL2ZvUWFPY3FhNHBRelZpbnRi?=
 =?utf-8?B?eDR1ZG9PTzJBRjlsQUgvL085UGwrd2dCR0lkMDNPcEpqR3ZXK1l0dm5EQXFP?=
 =?utf-8?B?RGpOYmJNWFdDbkNCY25NamZnaU9GdnJjczlPYm1PY3BYc1ljU1pJV2hqaTR2?=
 =?utf-8?B?eEVKYTBxdFBHWVpYaVBYMlhpaUMrWE5VY2o1djJhVkNhQ1pjYSs3ajIxWmhH?=
 =?utf-8?B?RUpPZEZDQi9KQmREVlN1RjFWQ2RyeVBESTI1TlowNFhCM053eWpBMXZwSnZH?=
 =?utf-8?B?QzRIZXYxZDg2WTBWTGw0NG4wOXNIS0h5czk4ZG1ZWnYyWS9vdUR2Qjl1UEcz?=
 =?utf-8?B?c3o3Zld6OFh3WFhjT2NMTWlqYXJBS0k3N2lzelVtN0lPR0VScFRwUmc2NXQy?=
 =?utf-8?B?dGh0WVZHN2E1aGxZcXFBRTVNaUhHenZ2anViVEpIbDBZZzloc1ZDSFRZaUhS?=
 =?utf-8?Q?qhted8SucYoCpUEYJos0csD8g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d38dc9e-8493-4f7a-385d-08daa1611a26
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 14:52:45.0208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCnFOvJYCEadaL+CpxsBgUF1fDuyVSSsx8/XOhR7vFZ+m0q5X6zWbLiLfKLKDYJwrrVInmCec05AwDeJpWWfCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
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
Cc: stanley.yang@amd.com, hawking.zhang@amd.com, tao.zhou1@amd.com,
 Rodrigo.Siqueira@amd.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-09-28 10:49, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> On ChromeOS clang build, the following warning is seen:
> 
> /mnt/host/source/src/third_party/kernel/v5.15/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c:463:6: error: variable 'mc_umc_status' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>          if (mca_addr == UMC_INVALID_ADDR) {
>              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /mnt/host/source/src/third_party/kernel/v5.15/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c:485:21: note: uninitialized use occurs here
>          if ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
>                             ^~~~~~~~~~~~~
> /mnt/host/source/src/third_party/kernel/v5.15/drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:1208:5: note: expanded from macro 'REG_GET_FIELD'
>          (((value) & REG_FIELD_MASK(reg, field)) >> REG_FIELD_SHIFT(reg, field))
>             ^~~~~
> /mnt/host/source/src/third_party/kernel/v5.15/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c:463:2: note: remove the 'if' if its condition is always true
>          if (mca_addr == UMC_INVALID_ADDR) {
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /mnt/host/source/src/third_party/kernel/v5.15/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c:460:24: note: initialize the variable 'mc_umc_status' to silence this warning
>          uint64_t mc_umc_status, mc_umc_addrt0;
>                                ^
>                                 = 0
> 1 error generated.
> make[5]: *** [/mnt/host/source/src/third_party/kernel/v5.15/scripts/Makefile.build:289: drivers/gpu/drm/amd/amdgpu/umc_v6_7.o] Error 1
> 
> Fix by initializing mc_umc_status = 0.
> 
> Fixes: d8e19e32945e ("drm/amdgpu: support to convert dedicated umc mca address")
> Signed-off-by: Leo Li <sunpeng.li@amd.com>

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> index 2cc961534542..a0d19b768346 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> @@ -457,7 +457,7 @@ static void umc_v6_7_query_error_address(struct amdgpu_device *adev,
>   {
>   	uint32_t mc_umc_status_addr;
>   	uint32_t channel_index;
> -	uint64_t mc_umc_status, mc_umc_addrt0;
> +	uint64_t mc_umc_status = 0, mc_umc_addrt0;
>   	uint64_t err_addr, soc_pa, retired_page, column;
>   
>   	if (mca_addr == UMC_INVALID_ADDR) {

-- 
Hamza


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E98E784B0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 17:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D647610E2C5;
	Mon,  2 Oct 2023 17:06:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC23410E2C5
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 17:06:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHeKiuW6/v23SiPFLTPIAGFJKDRtOuVo+K+djRhHrhrUTeOym6Fq8w88OTNiw36Qrz/i+XaicN9X8U/abXojGN9Za6ldrhgoIe18uCI9eeaD+IiGGb0Otqxs3LT4e+vxZ/AVGCmOAdlW4iW81AX+jnqCI38M4kcY1nyGulW6N1K10yZlc7/vlOsneANRJ/UzI+ugSikoSUO3Q80XuXzixIG/gbCXHGSF4IwMZA/B7LU2faSdaXNidPvP01uiigNJQzWuAKbn6qeAJrKZXcvX5/9gLqbQxqjw5lbKi+YCZJWyriFuwQCx/f7eb+eIl2p67VPJefkCjMrxroOspus2JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKfjhhuQBifVv2dNEdXwAfo70Es/oMnn5HuCqjIs/PM=;
 b=K6Oo7d8OUA5rbNpiVsNdimKMv8omCHPzELQnlqegZDf5rRHF4/4gZGztuydNNqU8pxsYGdFoeJh561c3jikZ0jaPA+E2kFca9RtFXCC1fr/qH2bXx69vZ/y137Cznlxxq1hbqhhLc1RLr9+5xnZuE5aOlWv3TnkYS/y6/TTT0GTEXZAj1aW72sRMc3VgRv2+i1rg10KoLUu8V6CRCn0I//kdvl/hC+hJsLBvdaNPyUZauGOYZGiuiLMuX3S4VvJZ4bivC37AfAXIizwfDiVZxF03UJAjQwbBaITnm1WQlQzCjOqO/CcVAn4mndq6xPeq96geRYnZs3BcDqnAyKbRCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKfjhhuQBifVv2dNEdXwAfo70Es/oMnn5HuCqjIs/PM=;
 b=DhvlBk2h4lRpRyml7wyCKCpqNQfEYEeLXPl6ufPaFoQi3gkdy6Jl60oFhQsz5DNRIlPe2DSBNaJEyDEE6W3lBMXSKP+dM4gr2leoTYToK1qAHFiCJ/GOGSJ9axhJxkJI0wzLD3MVB/nin7OB8aeTGw07qm846YyMHxGEmn4Fp60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) by
 PH8PR12MB7229.namprd12.prod.outlook.com (2603:10b6:510:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Mon, 2 Oct
 2023 17:06:34 +0000
Received: from DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::6c31:d0a6:fd35:a88f]) by DM6PR12MB2602.namprd12.prod.outlook.com
 ([fe80::6c31:d0a6:fd35:a88f%7]) with mapi id 15.20.6838.016; Mon, 2 Oct 2023
 17:06:34 +0000
Message-ID: <af89092e-663e-6487-9c0e-048ccd715ed0@amd.com>
Date: Mon, 2 Oct 2023 12:06:31 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/3] amd/amdkfd: Unmap range from GPUs based on granularity
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230929141115.10016-1-Philip.Yang@amd.com>
 <20230929141115.10016-2-Philip.Yang@amd.com>
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20230929141115.10016-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:5:3bb::11) To DM6PR12MB2602.namprd12.prod.outlook.com
 (2603:10b6:5:4a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:EE_|PH8PR12MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: fe44ed32-2708-42e4-df59-08dbc369ee4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qDiK3y5p90wSJhrB6ncBUykPEbjWWeWijZCh1ICM4MNsiucIRqMEeAT9iOZxfvIZTvE8GkU6GCvc+dUcTobIU+Q9mmqc7A8++hJZISgJOAfu3Fkj3CnOT6Ug3v2N8p1TeoqNXJ0jJh1y0WQPJCW+/D1RWO4S6A5USEg+x+W+o21Hmu1dPxhTv5lyy2J+FKC4YqdXYwgAAEMv2dBJzbouWaD/JWVPoQaui14BMSqJi31ySvWqKBmFeDkkAaOCXpOfaYtrDtPQhTNLxRbxOQE8YWjDV2Eglsamj0SZz4ahAuNKaAoGMKa5/DQZQR7HPkWfyWKzAkJGxPaf7KehODHT711Ig1z7rqRUzYfyWoeR+orHsSD3cpBy5z/td8Nj8DvBm6S+tniMGnH8C1wxjIljKw2hLRYRRU56rQWx+MQrtx6zf4K7rnYK+phNQx+UMlspEUbgODooLbtNZOX4kxNkApLsYRw1mcXygSeB6FpGkgSKfrAoGmcm22Pa0kXxcEv4LkB9mCwyaYhTHJvzP+nlQKgrnPB1GNyGfh1Q9HLIb8GCzmpY8kebJuSE2TXXkW1L1FrE9wryVrAvwCw7l4dklZDFIUs5CPaVYAJDvtL52npYh/eixz+2i9A2QqaBWcqLtsC78GAColaqPtPJIY6+iA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2602.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(39860400002)(396003)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(26005)(38100700002)(8676002)(4326008)(8936002)(31696002)(6486002)(2906002)(53546011)(6512007)(6666004)(36756003)(86362001)(2616005)(5660300002)(478600001)(41300700001)(66946007)(316002)(66556008)(66476007)(6506007)(31686004)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXp6Rm1uSXY3Z2psU2EvMlhXWVZRcmR5YzZOUHRLQW9WbDA1WFZmY1kzcU9w?=
 =?utf-8?B?bjBnNitkTUticlJrblNKZElEWStKYTFQN2czSkU4ak1laTRnSVJ6RkR2bGpj?=
 =?utf-8?B?U2xpUnYzanpWWldySWx1VzUyS0Y5V2NKS0RsWVBIVWQwR1FkUklvNlY1UnNz?=
 =?utf-8?B?cVlPaWVnZ2V3b1NuS0oycGhJb2F3cms4MGxubDMzUEFsR0NkdXpkRE81N0ZL?=
 =?utf-8?B?NVVnWGZUcGc5S2lTRUhjWmVDMFJOVzVSN1VCUi9oMk9mVk91VkxuYjRuQjZS?=
 =?utf-8?B?VUNoVzBKK3VlbWF6MnYyME4rZ2xVb01xSmVvcER6WXVFYUphRVE0OXdYaWFu?=
 =?utf-8?B?NHl3MXFwNzgzSFZYcHFrRDhCRjRVZGFrdDByVXM0UkJ3c3M1ZmVvREt3YVBa?=
 =?utf-8?B?ODlJdEtOQ3RXOEtvSVdCc1NGbWM4K29YMTNFUG5PZFZNc3lGd3Zvc2pZT01t?=
 =?utf-8?B?a0hoOTFUYVJ0WHM0b0gxc010U3dHaTZiOXJ0K0E0Zm5XSEkwZFR6RENEMUpX?=
 =?utf-8?B?NnJLbjVudEE1ZXZYdmxuUzV5dXR3dUFpek9SSnNBajZMK3RMTVFFVEwwK216?=
 =?utf-8?B?dU5JdFFONHZCOWtpL1lLYmlUMnphOGZFcHRsdVc4THRFVTJaUCtwUlU4bzhl?=
 =?utf-8?B?dEZVTTJFdjVXNkplM3JyNjdnRU5rTE96ZFpVbWVCQkFaN2lQWnp1N2NxNE8x?=
 =?utf-8?B?MFNsbGRpQmJSSFVxUi93K3ZkMzNoK21QNU9UK0VzWWMrNzM5Q3QrT1RCVXd0?=
 =?utf-8?B?VllQVDFDTUc3cmJ5cVUwOW9NK2FkTVdJOEpWMmp2eTJsQW9uYWRMbElROWJR?=
 =?utf-8?B?ZVJHanFUYzZySkRWVk1wYXNiRGF1Sk85TXl2Mml2Zi9jU0NTZUZTRlFEWnJC?=
 =?utf-8?B?UFRxTUlxbUJ4YmwrWktaVHg0a2RNM09BeHVIYm92d1N1NENTRlo2bi9acmtG?=
 =?utf-8?B?b29teDZENG1yL2tlUlB3K3dWeU1RM0lrRnBLWU1TclZsbzduSGNSK0FpSGRT?=
 =?utf-8?B?SENZQmhJUHVuWUFFR3d0OVZ0MGwrNHVQZFVWeGkySlBxeUJLYThrdkMyVWJt?=
 =?utf-8?B?eXZ2ZldyUTdKS1hHdWZsOFRBMDRpbXVtaXJBUFYvT1JHWTVzWjNUcVJhWWlV?=
 =?utf-8?B?eVdqejlNZVd1TGVSRUVwTE5DOGIvOU5LSVR1dDdWQlFvNVpTaW9DLzJ5d3FP?=
 =?utf-8?B?TzhKamJvd0g2MEJ6YVdGRDdDWUJIUmRybXZ0NGRvbU5CcStBRGp4MWpxUmlv?=
 =?utf-8?B?SzBCeGJGbU5ldFZ0a0Y1TnpvVVRSa0NXNlZiQlhzTUd3WGRsekFZUE5qT3V4?=
 =?utf-8?B?T0hIMmlnamVOUlc5QnFyb211bkY1UkFMMmttMm5xVzlEZ0M4TXBETHFIRkJ2?=
 =?utf-8?B?RXNRS3lTTGpqSGJXQk9ScTVKZWtyd05tZFN2MzZYUWJ1aGZWekpmOHAwb1hy?=
 =?utf-8?B?T2JDMGxtTlZwRC9kbHB1OHl3TitBdnVMTldoZlhxcFJPcHFJanl0RnlEVzdF?=
 =?utf-8?B?RkNPOHVZajhET1JUR2ZhdUtJcVV5cHhhVmJqOGdNT3VoaDRUWGpQaCtoMS95?=
 =?utf-8?B?WFFOVUk3VFh2TEh2T2h1NFJTZk5tdE51SXZZVEloVW40ZTQwaEVKUWhTVDcx?=
 =?utf-8?B?ZEVZZHp6S1QwNDJKOC9kQTBYNUFtNVhXM1BqOFB0b05JMFJESk1zZ25Id0x1?=
 =?utf-8?B?bUJvMWo0K0pHWXc5ZHFmei9DOFZPWkNWR2swVWZUdDJzbGJjTjNqVzhxNDd0?=
 =?utf-8?B?eHgvcElQZXRRLy9VZE5nZGVrdGM0WWxFNDVvN2Nnb3BndkZNMGwzaUlEZktL?=
 =?utf-8?B?TkpIb29UcENrZTA1anBMckJFd1JsSWE2UTZhYmk4ekRtbnoreDZPaDFHZkc4?=
 =?utf-8?B?cnRpaVJyeWFlTUR2aUp3TWU3N0N0NDBRMWRkM3RrSjlaRHpVRTNlN2VEdmVC?=
 =?utf-8?B?OEdFU3F4dFdnV2k1cGNLZ29RSGhVQkl0cWJTNjl4ZUhtbzZUVVc2OHZXZVlS?=
 =?utf-8?B?cGxSM1kvcUUvMkxjcCtMeVQ5aUhwU3dvYlpISkk3K2hJcnAxbXpHVmxheFYv?=
 =?utf-8?B?U2xlWFVibjhudElDTDJWdFJFei9KUHdzQlBFQnlwVUpHSFZtWjdMczVnOUp5?=
 =?utf-8?Q?NF6M=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe44ed32-2708-42e4-df59-08dbc369ee4d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2602.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 17:06:34.1395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftt7sXtDQUUn4tQC+U/CPVcQ4RUtZ2A4KP+b22ZxMJOVoS8i7Jzr951VAc6Pgcz1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 9/29/2023 9:11 AM, Philip Yang wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> Align unmap range start and last address to granularity boundary.
> Skip unmap if range is already unmapped from GPUs.
>
> This also solve the rocgdb CWSR migration related issue.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 35 ++++++++++++++++++++++++----
>   1 file changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 626e0dd4ec79..ac65bf25c685 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2004,6 +2004,26 @@ static void svm_range_restore_work(struct work_struct *work)
>          mmput(mm);
>   }
>
> +static unsigned long
> +svm_range_align_start(struct svm_range *prange, unsigned long start)
> +{
> +       unsigned long start_align;
> +
> +       start_align = ALIGN_DOWN(start, 1UL << prange->granularity);
> +       start_align = max_t(unsigned long, start_align, prange->start);
> +       return start_align;
> +}
> +
> +static unsigned long
> +svm_range_align_last(struct svm_range *prange, unsigned long last)
> +{
> +       unsigned long last_align;
> +
> +       last_align = ALIGN(last, 1UL << prange->granularity) - 1;

should be ALIGN(last + 1, 1UL << prange->granularity) - 1;? Here last is 
included last page number.

Regards

Xiaogang

> +       last_align = min_t(unsigned long, last_align, prange->last);
> +       return last_align;
> +}
> +
>   /**
>    * svm_range_evict - evict svm range
>    * @prange: svm range structure
> @@ -2078,6 +2098,12 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>                  unsigned long s, l;
>                  uint32_t trigger;
>
> +               if (!svm_range_partial_mapped(prange, start, last)) {
> +                       pr_debug("svms 0x%p [0x%lx 0x%lx] unmapped already\n",
> +                               prange->svms, start, last);
> +                       return 0;
> +               }
> +
>                  if (event == MMU_NOTIFY_MIGRATE)
>                          trigger = KFD_SVM_UNMAP_TRIGGER_MMU_NOTIFY_MIGRATE;
>                  else
> @@ -2085,16 +2111,17 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
>
>                  pr_debug("invalidate unmap svms 0x%p [0x%lx 0x%lx] from GPUs\n",
>                           prange->svms, start, last);
> +
>                  list_for_each_entry(pchild, &prange->child_list, child_list) {
>                          mutex_lock_nested(&pchild->lock, 1);
> -                       s = max(start, pchild->start);
> -                       l = min(last, pchild->last);
> +                       s = svm_range_align_start(pchild, start);
> +                       l = svm_range_align_last(pchild, last);
>                          if (l >= s)
>                                  svm_range_unmap_from_gpus(pchild, s, l, trigger);
>                          mutex_unlock(&pchild->lock);
>                  }
> -               s = max(start, prange->start);
> -               l = min(last, prange->last);
> +               s = svm_range_align_start(prange, start);
> +               l = svm_range_align_last(prange, last);
>                  if (l >= s)
>                          svm_range_unmap_from_gpus(prange, s, l, trigger);
>          }
> --
> 2.35.1
>

Return-Path: <SRS0=1/w8=NI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF40BC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 06:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81FF560C3F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 06:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 81FF560C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97AC86E105;
	Tue, 17 Aug 2021 06:26:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40A626E101
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Aug 2021 06:26:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjKXeJ3DKA8gQ8eba4OANQ8Mizx9m/BL345o4HNSnysztfHdzDjfpXLNOTVpWvM+hX6QckwsnNihPW5sDHoDHyzuI4L3FbCrpQiEjpYK+Bc7SHJT0FkP9Wv+1yXqm+yKO3PNOSWG8JCItWYjvqrC2okRcAP2B18RXboV3BEu7z1I4Vakd6Is0naK8rcs49wvgLYtWUnVmCrG+dP5DVdsd7m70Poc5jAkhesm5uuUP04Mh1b1KAMNXfokw4X0qaCoEptfeOTJX6+T/+ib9nzz/lflhhJ4mBKIzVpDK/1WF8VAhuwmUkEAzhgnr2oD6bcKQpcllqD/w69jfkotTXl7cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s12DY+qpothN3pCNsHtqYzL2phbyoZxaCSokDWknIt4=;
 b=Is2qQHV05iaBifu5EGeEuFpDEsWS6JZG3zfIRUvB6/56Iv4UMFEHYaDBnJb52W6NM7HR9b331zcbf1uH7k5Npf4e36kjaXp17zRJEkke35VM/qxcPRxgfJ3Dqb9W3h9GFq4WHJSknLpkvY/Y0f7oZNDkFdS6r+5Vie2irzRPnBd44cJHLjTsXZh+uI1rPWDEUkip5aSWJihjtIkky3bkzAHL7aeaQsO9LqZBdeKzH21g7cFk15tT4rIGufBLIbuninqL0o1JpLUc6JZXMgYfg91TxIkK9hbZI/dYhX+fguUF1T3pObUtcxQO4N8JkWwIG2N1dje7ckCCV8YVQhCc1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s12DY+qpothN3pCNsHtqYzL2phbyoZxaCSokDWknIt4=;
 b=nBkeFmdOltISH5c4XUYR+H2HPsggukY5nkXgXoCrVuhZgxy0eyKuxNf4CJ0RC7OF5oy+GsacA+TYWfe2kQ5cQhT6caTxNvvst6tVzy802BK9WPF6AkoC9N7HrL65UFrUKM6Ky88oW3YSQecNuxyWgTJSo6XcsAVNjLY0NvSephU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM8PR12MB5397.namprd12.prod.outlook.com (2603:10b6:8:38::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.17; Tue, 17 Aug 2021 06:26:32 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::946e:7191:34a2:9850]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::946e:7191:34a2:9850%7]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 06:26:32 +0000
Subject: Re: [PATCH] drm/amdgpu/vcn:enable priority queues for encoder
To: Satyajit Sahu <satyajit.sahu@amd.com>, leo.liu@amd.com
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20210810070954.4480-1-satyajit.sahu@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
Message-ID: <0214eee6-b1c7-d9d2-f938-f0d89d4070cf@amd.com>
Date: Tue, 17 Aug 2021 11:56:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210810070954.4480-1-satyajit.sahu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::30) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.68.101] (106.51.20.251) by
 MA1PR01CA0160.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.18 via Frontend Transport; Tue, 17 Aug 2021 06:26:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b15297d3-18ff-4d43-87d8-08d96147f47b
X-MS-TrafficTypeDiagnostic: DM8PR12MB5397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB53971D0CB6087A7DEB6A2F0BF2FE9@DM8PR12MB5397.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NNXV6MBgeMCcUmjYJW5XdVfQI8n4EBc4aMUCYVyyGcBn57xi4+ndRVpN1SYkRaPm/PKbz+kVNkxrwCsjAPZgM9BZmdebIDlkRy3AsQeRlF943pL9EPwaiOLp7Axa/faDQtpfgk0/xaCmJ/VCw/oK97LkrF0dtwoU3JkjvZ8MfLInh9yVGlIlSwVqy4QkGMc8m3HbQgEfC2QNrtt55kEeAxQITvgR0O0RQSzxIug9LuXpgJgtsRg95ei74vzp6QBauIHNgiThjBetZRdhVVpNSWZs+8bGfvOtLdUKMNe4FzDCf18gwLqRG7S89S7SwI4BDVWJLr+XIKI8YdlfZXPknos+/a0kVPwGzNHm09f1srcrAz8tIJyAGIpsLMpwevSjg11ECFyPRCVqIVpY637CR3qherlTo97Pl0DXoCTpekmTxFtF9RxMVCGTgQMOIeFqucPf5xmUJHAr0KMedWei0RdWjpazhHC5TkHUx3/yOr4AnLe1wnFPCO+fVbcQYbnEYlhaafayQXfT6lx6FCp3ixt5lIn9QeEtg3AKj+i4wz6TY2F5o53BHReB4Rp/O1x5QcM2I6YBZBCZNU9zlcab9/CC4gaU3r1rlu54xZDYOW7K1yzUGhlyFoIgCR9XDOneKvCVhxXDJpH/Hbtvrypyfx/n82dRJhrpWI74+mAku9QJojNq2pyBqgUI1kHOZexwhwvOnvbg1BEDmTwqeIgpXeHY2MFYPf0b6GU8MTXIEfLICy8Bfxo7KaU0hrRt+fX6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(6486002)(6636002)(55236004)(508600001)(26005)(36756003)(8936002)(8676002)(2906002)(5660300002)(30864003)(316002)(53546011)(31686004)(66946007)(66476007)(1006002)(6666004)(86362001)(4326008)(83380400001)(956004)(186003)(2616005)(66556008)(16576012)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjlzUklRZlhqdFVFcW81cjZidVphREt1ZzNKcVJWMm4xc3FFSWZYcm4xdGlS?=
 =?utf-8?B?OHhYREFLWXR0dkhxVnd0SVNhckphWGZRajRZcDd1Q3lydllmUmlCTkQzaUxU?=
 =?utf-8?B?L0hMVjBKc2RQR0JOVUNyTjczYUNtRU9iZlYxV0ZHMHNtVFRpZmZiRys2S2h5?=
 =?utf-8?B?Uk9wT1VGVEhlOWwwcU9PVlNibkM4U05CVktzVFNUYW12SXJ4eHlKQ2dGNjZ4?=
 =?utf-8?B?dDI4NExWWis5OWlreXNkQUpNTVV4MkNVSFlqVnhuNWt3WHlVRWtEelFpRCtU?=
 =?utf-8?B?b3VXaWJuNjB5d0hoemhMTTg4eDlvV0FRSmtoMzk5aWgrNXljcXdvdEhTTnda?=
 =?utf-8?B?WGhwTVNrbSs5S3JwdXhNYXR5Nll1VFBQSEc0bXRNM2JLSlBxem9oMGl5cTQ3?=
 =?utf-8?B?S0RlRnNobTJYRW5vcForMGNoeHNyYmlUZ0sxZkZjL2xwa3JEWDZwLzliN2ZQ?=
 =?utf-8?B?SWhtZEE3SzYvdFRPZm51eW1jeFVpK2dkVTNKUXR4SGNDS3Z5LzloWWwwRXgr?=
 =?utf-8?B?M2VJRTZ0NVFiZUhkTkdVWmdDV3FHdXZzQUVoVllTZDZ1bHcrVUQ2WnpGTmdk?=
 =?utf-8?B?MjNxRWdKU3lUVEo1L3FSdG43a29lSmcwdk9DeklSd2lNeEtZYSthazEydnFn?=
 =?utf-8?B?V1czNGZ4bUZFcjhHd1JhajFQblRCd1V3K2FhZU5OWlQ1VVNVdDFMME9ZR1ZD?=
 =?utf-8?B?VWVCdmlFVUU2UTJhb2djZ0dGRzRKY1hWbndkUWsxUmtMU0dOeEkreTIzU1dX?=
 =?utf-8?B?L2thWk5ia1lCRnE4Tnd2VldFUG5YZXJYalJxYys0cUFxcTA1d2E0WG9idDVK?=
 =?utf-8?B?MFV3cHdLOHNrc252UW9EMEFmS0NpWmtiN251dE12K1VBMnlGYmV1WTM4Mm0w?=
 =?utf-8?B?azZ4dTE0QnVhVzNnL2JaNmoweWVIRXJwYjk2U2UvdTc1WmhKZ091K3hmSVox?=
 =?utf-8?B?NXQ3L3hiYTZPRFVRVXhhenFuWFAwOGFRdUovMHNWZTBISEhWS3c3cDhYMmdR?=
 =?utf-8?B?OU9Ldm1WR3p5VTAzUE5OTmlyd0NPQkxCMWxRcjJwdGgwcWNNSW1mcXZ2dWV4?=
 =?utf-8?B?MFhna3MweXEwL2I5akpiNkpSZU83eEJUZHdRazJpbmxyVUNGZUs5ZnBMOFhs?=
 =?utf-8?B?ZzVFL21pSlZJTWV6UGx0MW5aV1ptMmR6Rm41cmhxZ1VvM3JhTExmY1RzZVR2?=
 =?utf-8?B?SG0xMmZ1QVBhNkFwMWE5R2IvTW1DQ3c0Mk0rcllaVi9YNnFRaHpURUt3djkr?=
 =?utf-8?B?bXhxYklYN3BXbUVodUxuaDhRbmd3dHZUTFRvVW5HRHI5eDhkWnZacnRCK3FB?=
 =?utf-8?B?dzBpUFRybW03T0h0L2F6bkVoU1BnQy9xMmdPUm5oZDZCVHd0ai9tbkVZemlq?=
 =?utf-8?B?ajdiQUNqTllpbTBMMmdBN3RpVlJkWTU2WE1kd1J6ZjZublo5SXBMczVlUmZk?=
 =?utf-8?B?S0pvaWdHdy9NVWljVytlVnJsKzlVT1pzaXVCdHFJS2JDVm53VWFHNnRKNDFO?=
 =?utf-8?B?emlsUU5Oa0N5WkwzOCtqSHZ5bFI0dnhod3dscUgvVlBINGwwY04wWWZWZDh1?=
 =?utf-8?B?TmhoU1d2SDV5RG12ekczRzgrcnFrRmxVbTZqRm4rUWt2Z21WSHdNRUdCNGdl?=
 =?utf-8?B?TUlVeDg1UEpVMTRNbjRGVyt3OC9ocEQ3MDI5NTVtbWZ1a2drbjFCb01wUith?=
 =?utf-8?B?bUdSOWUvZmI0S2V5SngzazVOdXh5azlqUXlLVmFzbVEyY1ZZb0NZSXFGR3ZT?=
 =?utf-8?Q?vrY2XfIcL/ovTpht6QVQFuFxx9mQwCjWTQLtXGX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15297d3-18ff-4d43-87d8-08d96147f47b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 06:26:32.3179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5PhCOHLXYsECE+VaGFOM0elQIxVWwp6bfPMV2ycv1NJAJME5tHZEtFrX2rteat3Z47ssqPtx5zbaw4Xj4gk8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5397
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

Hi Satyajit,

On 8/10/2021 12:39 PM, Satyajit Sahu wrote:
> VCN and VCE support multiple queues with different priority.
> Use differnt encoder queue based on the priority set by UMD.
> 
> Signed-off-by: Satyajit Sahu <satyajit.sahu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   | 35 +++++++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c   | 14 +++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h   |  9 ++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c   | 14 +++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  8 ++++++
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c     |  4 ++-
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c     |  4 ++-
>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c     |  4 ++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     |  4 ++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     |  4 ++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     |  4 ++-
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     |  5 ++--
>   13 files changed, 99 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index e7a010b7ca1f..b0ae2b45c7c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -73,15 +73,44 @@ static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_compute_prio(enum drm_sch
>   	}
>   }
>   
> +static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_vcn_prio(enum drm_sched_priority prio)
> +{
> +	switch (prio) {
> +	case DRM_SCHED_PRIORITY_HIGH:
> +		return AMDGPU_VCN_ENC_PRIO_HIGH;
> +	case DRM_SCHED_PRIORITY_KERNEL:
> +		return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
> +	default:
> +		return AMDGPU_VCN_ENC_PRIO_NORMAL;
> +	}
> +}
> +
> +static enum gfx_pipe_priority amdgpu_ctx_sched_prio_to_vce_prio(enum drm_sched_priority prio)
> +{
> +	switch (prio) {
> +	case DRM_SCHED_PRIORITY_HIGH:
> +		return AMDGPU_VCE_ENC_PRIO_HIGH;
> +	case DRM_SCHED_PRIORITY_KERNEL:
> +		return AMDGPU_VCE_ENC_PRIO_VERY_HIGH;
> +	default:
> +		return AMDGPU_VCE_ENC_PRIO_NORMAL;
> +	}
> +}
> +

As it is also mentioned by Nirmoy, we can't use kernel priority for 
VCE/VCN ENC work due to the delay/stale punishment.

But adding DRM_SCHED_PRIORITY_VERY_HIGH also might not be a good way as 
other drivers might not be very interested in that (or are they ?)

I can think of two ways to go ahead from here:

Mrthod 1:
=========
- Introduce DRM_SCHED_PRIORITY_VERY_HIGH in the DRM scheduler layer, and 
demo a usecase of the same in our high priority VCN queues (in fact this 
should work for high priority gfx queues as well)

- Check the feedback from the community

If there are not many consumer or there is not much interest around:

Mehod 2:
========
- Add a AMDGPU specific priority flag while submitting the work
- Use this flag to keep the DRM scheduler level: DRM_SCHED_PRIORITY_HIGH 
but the AMD scheduler level: AMDGPU_VCE_ENC_PRIO_VERY_HIGH
- Pass this flag parameter to 
amdgpu_ctx_sched_prio_to_vcn_prio/amdgpu_ctx_sched_prio_to_vce_prio 
functions and set the proper scheduler level which will allow AMDGPU 
driver to schedule it in the correct ring

>   static unsigned int amdgpu_ctx_prio_sched_to_hw(struct amdgpu_device *adev,
>   						 enum drm_sched_priority prio,
>   						 u32 hw_ip)
>   {
>   	unsigned int hw_prio;
>   
> -	hw_prio = (hw_ip == AMDGPU_HW_IP_COMPUTE) ?
> -			amdgpu_ctx_sched_prio_to_compute_prio(prio) :
> -			AMDGPU_RING_PRIO_DEFAULT;
> +	if (hw_ip == AMDGPU_HW_IP_COMPUTE)
> +		hw_prio = amdgpu_ctx_sched_prio_to_compute_prio(prio);
> +	else if (hw_ip == AMDGPU_HW_IP_VCN_ENC)
> +		hw_prio = amdgpu_ctx_sched_prio_to_vcn_prio(prio);
> +	else if (hw_ip == AMDGPU_HW_IP_VCE)
> +		hw_prio = amdgpu_ctx_sched_prio_to_vce_prio(prio);
> +	else
> +		hw_prio = AMDGPU_RING_PRIO_DEFAULT;

Move to switch(case) probably for the better appearance ?

>   	hw_ip = array_index_nospec(hw_ip, AMDGPU_HW_IP_NUM);
>   	if (adev->gpu_sched[hw_ip][hw_prio].num_scheds == 0)
>   		hw_prio = AMDGPU_RING_PRIO_DEFAULT;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> index b7d861ed5284..4087acb6b8bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
> @@ -37,7 +37,7 @@ int amdgpu_to_sched_priority(int amdgpu_priority,
>   {
>   	switch (amdgpu_priority) {
>   	case AMDGPU_CTX_PRIORITY_VERY_HIGH:
> -		*prio = DRM_SCHED_PRIORITY_HIGH;
> +		*prio = DRM_SCHED_PRIORITY_KERNEL;
as mentioned above
>   		break;
>   	case AMDGPU_CTX_PRIORITY_HIGH:
>   		*prio = DRM_SCHED_PRIORITY_HIGH;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index 1ae7f824adc7..9d59ca31bc22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -1168,3 +1168,17 @@ int amdgpu_vce_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   	amdgpu_bo_free_kernel(&bo, NULL, NULL);
>   	return r;
>   }
> +
> +enum vce_enc_ring_priority get_vce_ring_prio(int index)
> +{
> +	switch(index) {
> +	case 0:
> +		return AMDGPU_VCE_ENC_PRIO_NORMAL;
> +	case 1:
> +		return AMDGPU_VCE_ENC_PRIO_HIGH;
> +	case 2:
> +		return AMDGPU_VCE_ENC_PRIO_VERY_HIGH;
Please use AMDGPU_VCE_ENC_PRIO_NORMAL/HIGH/VERY_HIGH instead of 0/1/2 
for better readability.
> +	default:
> +		return AMDGPU_VCE_ENC_PRIO_NORMAL;
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> index d6d83a3ec803..f5265f385890 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
> @@ -32,6 +32,13 @@
>   
>   #define AMDGPU_VCE_FW_53_45	((53 << 24) | (45 << 16))
>   
> +enum vce_enc_ring_priority {
> +	AMDGPU_VCE_ENC_PRIO_NORMAL = 1,
> +	AMDGPU_VCE_ENC_PRIO_HIGH,
> +	AMDGPU_VCE_ENC_PRIO_VERY_HIGH,
> +	AMDGPU_VCE_ENC_PRIO_MAX
> +};
> +
>   struct amdgpu_vce {
>   	struct amdgpu_bo	*vcpu_bo;
>   	uint64_t		gpu_addr;
> @@ -72,4 +79,6 @@ void amdgpu_vce_ring_end_use(struct amdgpu_ring *ring);
>   unsigned amdgpu_vce_ring_get_emit_ib_size(struct amdgpu_ring *ring);
>   unsigned amdgpu_vce_ring_get_dma_frame_size(struct amdgpu_ring *ring);
>   
> +enum vce_enc_ring_priority get_vce_ring_prio(int index);
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 6780df0fb265..ca6cc07a726b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -951,3 +951,17 @@ int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout)
>   
>   	return r;
>   }
> +
> +enum vcn_enc_ring_priority get_vcn_enc_ring_prio(int index)
> +{
> +	switch(index) {
> +	case 0:
> +		return AMDGPU_VCN_ENC_PRIO_NORMAL;
> +	case 1:
> +		return AMDGPU_VCN_ENC_PRIO_HIGH;
> +	case 2:
> +		return AMDGPU_VCN_ENC_PRIO_VERY_HIGH;
Same here
> +	default:
> +		return AMDGPU_VCN_ENC_PRIO_NORMAL;
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index d74c62b49795..bf14ee54f774 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -290,6 +290,13 @@ enum vcn_ring_type {
>   	VCN_UNIFIED_RING,
>   };
>   
> +enum vcn_enc_ring_priority {
> +	AMDGPU_VCN_ENC_PRIO_NORMAL = 1,
> +	AMDGPU_VCN_ENC_PRIO_HIGH,
> +	AMDGPU_VCN_ENC_PRIO_VERY_HIGH,
> +	AMDGPU_VCN_ENC_PRIO_MAX
> +};
> +
>   int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
>   int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
>   int amdgpu_vcn_suspend(struct amdgpu_device *adev);
> @@ -307,5 +314,6 @@ int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout);
>   
>   int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring);
>   int amdgpu_vcn_enc_ring_test_ib(struct amdgpu_ring *ring, long timeout);
> +enum vcn_enc_ring_priority get_vcn_enc_ring_prio(int index);
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> index c7d28c169be5..2b6b7f1a77b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -431,10 +431,12 @@ static int vce_v2_0_sw_init(void *handle)
>   		return r;
>   
>   	for (i = 0; i < adev->vce.num_rings; i++) {
> +		unsigned int hw_prio = get_vce_ring_prio(i);
> +
>   		ring = &adev->vce.ring[i];
>   		sprintf(ring->name, "vce%d", i);
>   		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
> -				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +				     hw_prio, NULL);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index 3b82fb289ef6..5ce182a837f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -440,10 +440,12 @@ static int vce_v3_0_sw_init(void *handle)
>   		return r;
>   
>   	for (i = 0; i < adev->vce.num_rings; i++) {
> +		unsigned int hw_prio = get_vce_ring_prio(i);
> +
>   		ring = &adev->vce.ring[i];
>   		sprintf(ring->name, "vce%d", i);
>   		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
> -				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +				     hw_prio, NULL);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> index 90910d19db12..c085defaabfe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -463,6 +463,8 @@ static int vce_v4_0_sw_init(void *handle)
>   	}
>   
>   	for (i = 0; i < adev->vce.num_rings; i++) {
> +		unsigned int hw_prio = get_vce_ring_prio(i);
> +
>   		ring = &adev->vce.ring[i];
>   		sprintf(ring->name, "vce%d", i);
>   		if (amdgpu_sriov_vf(adev)) {
> @@ -478,7 +480,7 @@ static int vce_v4_0_sw_init(void *handle)
>   				ring->doorbell_index = adev->doorbell_index.uvd_vce.vce_ring2_3 * 2 + 1;
>   		}
>   		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
> -				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +				     hw_prio, NULL);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 121ee9f2b8d1..f471c65d78bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -145,10 +145,12 @@ static int vcn_v1_0_sw_init(void *handle)
>   		SOC15_REG_OFFSET(UVD, 0, mmUVD_NO_OP);
>   
>   	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +		unsigned int hw_prio = get_vcn_enc_ring_prio(i);
> +
>   		ring = &adev->vcn.inst->ring_enc[i];
>   		sprintf(ring->name, "vcn_enc%d", i);
>   		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
> -				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +				     hw_prio, NULL);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index f4686e918e0d..06978d5a93c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -159,6 +159,8 @@ static int vcn_v2_0_sw_init(void *handle)
>   	adev->vcn.inst->external.nop = SOC15_REG_OFFSET(UVD, 0, mmUVD_NO_OP);
>   
>   	for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +		unsigned int hw_prio = get_vcn_enc_ring_prio(i);
> +
>   		ring = &adev->vcn.inst->ring_enc[i];
>   		ring->use_doorbell = true;
>   		if (!amdgpu_sriov_vf(adev))
> @@ -167,7 +169,7 @@ static int vcn_v2_0_sw_init(void *handle)
>   			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1 + i;
>   		sprintf(ring->name, "vcn_enc%d", i);
>   		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
> -				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +				     hw_prio, NULL);
>   		if (r)
>   			return r;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index e0c0c3734432..fba453ca74fa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -194,6 +194,8 @@ static int vcn_v2_5_sw_init(void *handle)
>   			return r;
>   
>   		for (i = 0; i < adev->vcn.num_enc_rings; ++i) {
> +			unsigned int hw_prio = get_vcn_enc_ring_prio(i);
> +
>   			ring = &adev->vcn.inst[j].ring_enc[i];
>   			ring->use_doorbell = true;
>   
> @@ -203,7 +205,7 @@ static int vcn_v2_5_sw_init(void *handle)
>   			sprintf(ring->name, "vcn_enc_%d.%d", j, i);
>   			r = amdgpu_ring_init(adev, ring, 512,
>   					     &adev->vcn.inst[j].irq, 0,
> -					     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +					     hw_prio, NULL);
>   			if (r)
>   				return r;
>   		}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 3d18aab88b4e..f5baf7321b0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -224,6 +224,8 @@ static int vcn_v3_0_sw_init(void *handle)
>   			return r;
>   
>   		for (j = 0; j < adev->vcn.num_enc_rings; ++j) {
> +			unsigned int hw_prio = get_vcn_enc_ring_prio(j);
> +
>   			/* VCN ENC TRAP */
>   			r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
>   				j + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[i].irq);
> @@ -239,8 +241,7 @@ static int vcn_v3_0_sw_init(void *handle)
>   			}
>   			sprintf(ring->name, "vcn_enc_%d.%d", i, j);
>   			r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
> -					     AMDGPU_RING_PRIO_DEFAULT,
> -					     &adev->vcn.inst[i].sched_score);
> +					     hw_prio, &adev->vcn.inst[i].sched_score);
>   			if (r)
>   				return r;
>   		}
> 
I think this patch can be split into 2,
  patch 1: introduce the priority core logic and functions
  patch 2: consume priority logic across various vcn generations sw_init 
functions (vcn_v1_sw_init, vcn_v2_sw_init, vcn_v2_5_sw_init and so on)

- Shashank


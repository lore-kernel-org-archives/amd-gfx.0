Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65548C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 17:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCCD310E863;
	Wed,  2 Mar 2022 17:49:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C09110E860
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 17:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRE4+DsnFkVnuuU1NX5GhdffkzcPg3tfFUJd2pA2ZTvKtaMQD1wgrtAgUO8r2JzLPGDPXK7J93ua7+j03RorxFeHN8EP+iQl/1QvMysKK7a9tk4PEkNFjxE4rTt6I1CxfYwRs5bmwSXIltZmcWAaJzBrlquo7Ah/ngqhsZWrTV9WNoJZ9OJK6tdJSuDCMti8Ehvo67+HFIRj/HXVLuqs82duO6aqt2xFsf+RbmW/MYscw0+zlQQlFAp4JXWeqBHt0OjG3pA4V7re4Du71ViTmveQi71+3+mAAibW+Jc1Suwb/pRbwAGZzofcWI2rTgkWJNKHmFdMCgAhPkf52dsEoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CF2axUjSb3QpK8Cm1kwjmamWDDBL2BgH2fGntltD3sg=;
 b=eJT4apndUW9h8JUMnIbYnE4bAmW4A6ODd/Fr3LR7PJoZGGZMizg0beREEYxaIAm62to60ppOeqLOBEOIqqJTISSGiwkHtFIVjQkSqUrMNaOQ1TnRHmQZXpQVCl5jieA7x231rRhnHs7e9mWHaddCOof/2tcMMuVSkvPCTdm2HCmVEVjTYn5EyS28UCjqGhb9cTIO7hqXZgDQMzRA74W/yO1yC/da+DPe8Bl4WgNaD4Dn9uoS80fFBS6lx2OiLoOC/cD7HdiqdvwJ8l8Pr8Ooh8WGYMpeWG3qX3HqkmRldhX//FcptFHkCw4EuFUiBawNbAkiBKd6/78Q9QOeKzMrzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CF2axUjSb3QpK8Cm1kwjmamWDDBL2BgH2fGntltD3sg=;
 b=EWLgj0PzBI9N8IDLQYSyk99meBwnt/xHVQ/r75E191ef1pQlocXDLo2XycnTbdlgNNFWK7bWmS8wI/AgLr1ZGRGPDuLGOjVkCUp2o4NrgSh033q8T9BYVyzG4oDLpWkqi/6ijlme4uyUdM9QqX4cCx9S70E045LQF4su69N3oOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1947.namprd12.prod.outlook.com (2603:10b6:3:111::23)
 by CY4PR12MB1464.namprd12.prod.outlook.com (2603:10b6:910:d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Wed, 2 Mar
 2022 17:49:34 +0000
Received: from DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3]) by DM5PR12MB1947.namprd12.prod.outlook.com
 ([fe80::a105:faab:243:1dd3%11]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 17:49:34 +0000
Message-ID: <f93dc8c0-d698-2ba5-6801-3ba3f19460d4@amd.com>
Date: Wed, 2 Mar 2022 12:49:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm/amdgpu: Fix sigsev when accessing MMIO on hot
 unplug.
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220301180800.1781042-1-andrey.grodzovsky@amd.com>
 <09402cd4-8cc2-2ec2-e239-823bae762c1f@gmail.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
In-Reply-To: <09402cd4-8cc2-2ec2-e239-823bae762c1f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::8) To DM5PR12MB1947.namprd12.prod.outlook.com
 (2603:10b6:3:111::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65ab743c-6307-43ba-0741-08d9fc750303
X-MS-TrafficTypeDiagnostic: CY4PR12MB1464:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB146475D09E53AE99F8B1B009EA039@CY4PR12MB1464.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NS/ppUpbH7v48SKiwl5BqdwX8L0uGsLo3lAn/tmHy3yizkZEHV0I9bMjrD6YIVE5vFNn2JvEkwFo0YOfDhqTaXT4T0lUbSfAgdpZNvFXk/4x89usq2XKiA6qEZ/cwq/kswTxfjkrRpDIi6omvw1Nr8VLhqC6q5lXfn0nMZG9tNSXb8p0P8748xgMeNDMvpSjKmhC+kDn7ki4tLGnV1Zqy+iJBp5r+44ofFlJ/c76t3QzVDwnJl0ITNNKNZwP3f8LCYGc/ZJHAfbsNYinB2TX9Jo+YHY7CG9M8JuGb3s2Hafd5x4TALGnuqxdEOrE004oG85DNCGBQr7N8sfHOxdKwZpzaA4aY95Nynzchj7Nkf5Jqqd06Z/yeXUQ44G+gnnp4Q/1AluLngPm3+vEdizOveKzn2jBOg3hG8Kj39mQmbOikuIgpkWJYFj7rEnX1/s9avBZ8sqLH20oxlkWhyP0ivp6fqJovE4U8knk1mdR/+J07+S8U2xuUiN66sjwbTflFMZ/UJXOV1DUXtouongkjJ2RpAT7EPcrvkHbb21nxt/O+GvcfWbq0nwGeWta2pMY/EfjJQlxVcvxL/qll4tUArVGh0KBIgw6O6mkv6iRUQei27HqYpAV0TSC8uhppNChIvWoJWU4X/xEE/NFJiMN1+wawgaRH9kH6/WxGow8WFbb9g03UsXDfgllxtTXc7VCdCe4Jw6XOHWBfPOKbUUnf7icxXXyIYYxEQsl0Y9++ys=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1947.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(6506007)(38100700002)(53546011)(36756003)(6512007)(31686004)(4326008)(83380400001)(508600001)(44832011)(316002)(8936002)(86362001)(2616005)(5660300002)(2906002)(186003)(66946007)(66476007)(66556008)(8676002)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWRPUTJPZDFnWHV2S3hjTHVTU3NWT3VUT29EUHRaNlp6UU5KU2g1UFpqMFY2?=
 =?utf-8?B?TlBBN2Nzd2phVFlpa0F6bHNOd1A0TlJ3OXNsUmdmcDBTNnkyS1A0SG5yMEw4?=
 =?utf-8?B?TmljWTAwcVJFcFRVZ3c4eXhLdmxiK2RGVTRNOENqVTZ3NFNMWWR0dSt2WG96?=
 =?utf-8?B?Y0NoL0xIWUhGZ2Y4bWFIWmhZWWZwR2NwcDI2MStJYlFxN2J1TWc4Wk9TdGlp?=
 =?utf-8?B?NGtWNVFVUWR6aHRmY0hIaTk0dllRVHBxTXN1VGRSUzArUU45ZnlaRkZHU2dW?=
 =?utf-8?B?Z0d3UkloaG9QWENYUmZWZGl4b1ZTeHFEVjZ1OVRaa1U0OTRQeW1vV3ZvYnhI?=
 =?utf-8?B?OS9lbTJxcUlueE5FdC8wYS9OYllOVTVpcmtPZkQwUG9JTTUrQUlGdkp6Nmwx?=
 =?utf-8?B?S3NJWDVydktwOFZYZWZZbHRXWlMySnBwSkJvK2hTYTYyaU1aWXdIUW1MeDFF?=
 =?utf-8?B?bVdrd2l2VStKdFVwR0dlSEF5c1BWUHlMcjhoMTd1WWZvZVZBK3l2WTRkaVJC?=
 =?utf-8?B?cmsrSnFMQVdyWGdtWmpWeDRxbzZWUkh0SWcyeXgzT0FhVkE1N0V5OTJWcDVw?=
 =?utf-8?B?Tk1NYW9lK1djWnNYMk52WkhDem5DWHZYdUh2S29NSjFJZGpSSm5acjBTWnc5?=
 =?utf-8?B?Y1FidUFud05LUTVibTZMOWJhVHpRYittajJ6Y0dBdEl4eGo3bVVSNTd2Z0dC?=
 =?utf-8?B?TjcwaVpTYm1wWitiemM5YlRlRmJrLzlRYytSZ2x4M29NYlFySUd4VVkzak1t?=
 =?utf-8?B?VHNhMDZaZGFucGMwWWlub0lmMTYwWDE1RVZ6bkVnbDhpV1NkdGIzK1BNTDVC?=
 =?utf-8?B?eFpmWXpycEdsN3RKZ3dqY0RVcUtqVTFGWU9EMnM4VW1VN2xXaUVuNTlLdHpD?=
 =?utf-8?B?bXJDVUVRYklPYVZwUkZOc3U5MndVUjQ2THJjTmw4WHFpV1lLUUZIK3RJNnFX?=
 =?utf-8?B?WTFRV1krdjAzUG5lMktPdnZBVnlUN0x1N2pFN05rN1MwbDluNzQ2Q0hOL29B?=
 =?utf-8?B?eWp5YlVmcENvNmh0Y3AxWW1NMEZHTllxL3hJN2ZTV1AvVHY4d3RBWmdBY3o4?=
 =?utf-8?B?cVR4YmpONmpId1MvSVB1ckJTTDR6VlA1WkplREFYLzY1STRkRWVEM0lmZjJM?=
 =?utf-8?B?Q3puaUlKQnQvZXpiUEN0b0k3RlpOVU5xRlRhc2lyOVh6YWRuOE5hQjh2ekYz?=
 =?utf-8?B?eWVpbUVVN3R6bDRlT1o1d292UEU0L3o4YjNLSUNod052K2tkS3VJN25YUkha?=
 =?utf-8?B?UGFvTHFpRlJtNHY3ak01a1RUSk0xeWJ2VjJhb28wVW9rT21pL0Mxa1o3YTFJ?=
 =?utf-8?B?UXFEKzI2NE5FWUlybWhFL1plajUyTERNdEl2dHREalh0bzFYUVQ4cmlQSjNi?=
 =?utf-8?B?cEVVK2twQVVVMFhmb3ZkNTNCRCttM3c1TW9ZMnhJdGVtYVBoeGRoWFk1bEdI?=
 =?utf-8?B?ZTFoQ3ZYNFByZXF0NjFjSUlOc2c1VElIWHlSVzRzYXZyeUdhQlo3WEd5a29j?=
 =?utf-8?B?U1Z6Ny96bm9UMVlIZEQzQmtpRlZsejJoZkYrL1RVUUtNemlqanorZUFKUXZ1?=
 =?utf-8?B?bFVqaE5lcWNzaEFSVkdIc2xldjkxQUpuS0x2eGJvSFJJMzh3dDVKWXhhdXNU?=
 =?utf-8?B?Q0FCa0FvY2pIMTQ2Q2IzMzhVRDQ4ZjJTQVgyak44UFhpcWNNNnZtOTZ5TW9v?=
 =?utf-8?B?dDFiQ09TeElPWWhNL1NNZGNMRm1Gc2xxcWdGMnRDV1YyUFhHRHBnYkVVODhv?=
 =?utf-8?B?bUN0K3l0eGdiN05VMDk5ZkkyOHRiNW95cWk3WWk1b2dYSjIzWkpsMEIrVzdv?=
 =?utf-8?B?bWFhYXlUeDZvREtONEhtbWtua2xFYlYxNTdkanZ6WDZuRzdRSmFLNzRucC9x?=
 =?utf-8?B?UFc2NlJJRG5MUGlwNVd1ZC9oU0RyWHU1elJWQjV3eW8xQkh0UFVXNjNFKzFs?=
 =?utf-8?B?WXFzbUx4aDZvL2JrWktEdFJqOTlQK0EwOSs2MzN4cFBEZmFiQlZSU2R2em9y?=
 =?utf-8?B?cHZIQkNyMTQyWDl2Kzdhc3Z1YVFnYnVSTVdUNDNWKzRJVGtKNTVZQTY1bmh1?=
 =?utf-8?B?Uk1SbGhUemJiNW9yVUJubEhrck1SSU9sa2J6dWtJVG81b0NrY1o4OC9YblBZ?=
 =?utf-8?B?N2ZnalZreXAxM0NnZ0txR0tvUVdReFVYZjQ4QURGNVlJaVhSaTBGY0NEdi8x?=
 =?utf-8?B?Uzk4bkh0emxMYjMzbXhOTzRBRWxRTlNJNTM5bnV2aDhWaWR1eVRmdkhBd2ZU?=
 =?utf-8?Q?oKit/QdnKG6zBMce5HnHQWUr0jdYk1wSEpTdxN1H4A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ab743c-6307-43ba-0741-08d9fc750303
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1947.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 17:49:34.4507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjgbS4f+UI02fYn6+uDKV6fiR1c0gmx1yy4vatjuerxBM0x0xK6X5cM7+m7MRjNbgsx7dmXGhGZIe1aGmBVFMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1464
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
Cc: Alexander.Deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks, already did. Code pushed both here and in libdrm.

Andrey

On 2022-03-02 03:37, Christian König wrote:
> Am 01.03.22 um 19:07 schrieb Andrey Grodzovsky:
>> Protect with drm_dev_enter/exit
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>
> Reviewed-by: Christian König <christian.koenig@amd.com> for this one 
> here.
>
> Regarding the version bumb you should probably sync up with Alex.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> index f522b52725e4..4294f17cedcb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>> @@ -23,6 +23,7 @@
>>    */
>>     #include <drm/drm_auth.h>
>> +#include <drm/drm_drv.h>
>>   #include "amdgpu.h"
>>   #include "amdgpu_sched.h"
>>   #include "amdgpu_ras.h"
>> @@ -339,7 +340,7 @@ static void amdgpu_ctx_fini(struct kref *ref)
>>   {
>>       struct amdgpu_ctx *ctx = container_of(ref, struct amdgpu_ctx, 
>> refcount);
>>       struct amdgpu_device *adev = ctx->adev;
>> -    unsigned i, j;
>> +    unsigned i, j, idx;
>>         if (!adev)
>>           return;
>> @@ -350,7 +351,12 @@ static void amdgpu_ctx_fini(struct kref *ref)
>>               ctx->entities[i][j] = NULL;
>>           }
>>       }
>> -    amdgpu_ctx_set_stable_pstate(ctx, AMDGPU_CTX_STABLE_PSTATE_NONE);
>> +
>> +    if (drm_dev_enter(&adev->ddev, &idx)) {
>> +        amdgpu_ctx_set_stable_pstate(ctx, 
>> AMDGPU_CTX_STABLE_PSTATE_NONE);
>> +        drm_dev_exit(idx);
>> +    }
>> +
>>       kfree(ctx);
>>   }
>

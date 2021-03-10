Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BA7C433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 22:17:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4354764FB9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 22:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4354764FB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 901596EA7A;
	Wed, 10 Mar 2021 22:17:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB2A06EA95
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 22:17:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0ISJjaZA7co3ZL6jXmyLDurW89ytHtXSrOPdY3PXMaCVnjlROHS1N0WvSw1E+ZbGvSFjTHPbF80ACrAoGE7MPsrIIxL+rAoPRHKbD69x8M3i4hVU30i9CtxRWu9kTARVaIfVlq0dk2thN8a2yDfz0G//kyxdecGN63oDc2eWv77EKfVCGS6HMOJLry+LfN23to9X9eJSU5T9Xailj7TKewbtatAb+sK1Tw06WGfBuwyokdJ6YAQ/om7mFdNd18JuBAO8rDzWflBIG/g5e/1tRc8lVYfF7cOiYt2SLwDNb95B6nFweVLpNLKPyh5NoYwVp1WvvJzBgQ5zjrchh9Q6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gkpi9yJgKH+fRm8660yZ+LvX4QFZLKuVvTsGePj+074=;
 b=Al+cu7HgP079eBDN8fVRkDDZTZzaqN5tukIXj8dwDk7PpOFTzLq7iso1W6IkvdYMxyp2HTllSrOhB41sjPf7r+RcxxPRJf0jxYFLXClfC9oaJtoaM0lBFJs8YWY5ChUghRVOjD2oM5Idsi7KOWlHJvRP/AbdbqUbWM283g/4VTLdmoxRktdJlHsewaTgfHsO9oHNMN19Ksn3TlwflHfCnCpDXHqyJe4xPzrmmTdolO6BOft3lJF40fdc+t6hDH2uRiv4Cv/v+k4JX63lj2ceY/pJTdN4NKAfXp5Au0hQABEo8voJilhVy6nxapnZKzAxSBcif7M9Rk4vPysasqM7zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gkpi9yJgKH+fRm8660yZ+LvX4QFZLKuVvTsGePj+074=;
 b=xx9f8hFN9DSwb8oFcd1+oNShi/mxdmj9qQhicl7YmYNpYGmzq7KE0mzAhVsz+l3hN0JLqsGNdMuJVFqFnlpTmsPnaIHLdWbUalyfU+YMA3X8P33RiEm7X9PZ3dJ5Bgdp5bEJ/GvohPHa54JWKTyx81wBbwigAqnLXoxHlMtXEz4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by BL0PR12MB2449.namprd12.prod.outlook.com (2603:10b6:207:40::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 22:17:48 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::ec8d:851e:525d:a6ab%9]) with mapi id 15.20.3784.031; Wed, 10 Mar 2021
 22:17:48 +0000
Subject: Re: [PATCH v2 1/5] drm/amdgpu: allow variable BO struct creation
To: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
References: <20210309084659.37649-1-nirmoy.das@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <759409d5-efab-8468-11b7-b292a2ba4f03@amd.com>
Date: Wed, 10 Mar 2021 17:17:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210309084659.37649-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::34) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YT1PR01CA0155.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26 via Frontend Transport; Wed, 10 Mar 2021 22:17:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7fbb351c-be01-46a8-6360-08d8e4125633
X-MS-TrafficTypeDiagnostic: BL0PR12MB2449:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB244906E7BB590A44A3BF3C5392919@BL0PR12MB2449.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:415;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xtxtRPo3rVFSK2YDwbaEgLQD0e1GuE47xqk2ZATVHq4jNg0FIdLTu9dOg2SZyC0lb6PtV0E6KUKvY/pLdtXW3jO4jxcEH9ZVe6xKDnONA0B0uqS4oqt7bHzW2eqx8yhFzFNZk8d+4VPkZLGu3B4p2c089y3PWUXgZALPJeW3gIkqYz16DwGgLCT/JRFfAvUkSXj0XEmkYvN62hgNUEm2/5kZA+3Uru7JgCdLJdS937Xn++nL+ZlkmwUSF2mPyXazunQU7OtIftnTYTVq9fKNUr5EMJl5KBqZuzcuEXB4m+24cV8ofNwf8uB82lWAzM513mLE3dozeENsAZkpGMbP711m4r9i269e7aIP1XdlIt32rIPheNnpp8sUoB1H4t55y5ak0D35eAHmIRRsMZNcmOatxaIoZIdt6mhBKbBBelgxyFJUtUaIinaAG2qHb4AUZOTqacgIY/HXAp88gyCTZmnKM5P1S4BEzawIrCcAOkXWZHGCqfKZnx3PlyrNLTzgq6fl9j0ffomi9xZcdf0g6O19AkA9JEjg4LuiHaqAJ5YJIXZdYAV0HQCN3OpfGV1iTY9Cdp8JyAFPQSQfWOmpme4QWaO8OI1W69+hCuN1jtI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4948.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(36916002)(66946007)(6486002)(186003)(316002)(956004)(16526019)(66476007)(44832011)(31696002)(36756003)(86362001)(83380400001)(6636002)(5660300002)(31686004)(66556008)(478600001)(2616005)(8936002)(52116002)(26005)(8676002)(16576012)(53546011)(2906002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WmlwZG9aeXlNUDlJQktzZzBxcVlIWEdnMHc3WlZQV3E1MVVaNDFURWE4MEZu?=
 =?utf-8?B?a01lZ2NWTUYyMitmZEpwUGVYRkpRY1l4V1V0aTZGS2xxTllLQlNnZXdRT3pO?=
 =?utf-8?B?SU5qTXlkZFJ5c1o3dEh5TkdHYnVMeGcvUWtrRzNXaUxCOTNhVTFZSTZHUm5v?=
 =?utf-8?B?TkYwc2Fjd0w1d3lvQm41V25ZMmRHZi8yM05xeEpGS1hTQU9od2FSSC9XSzlG?=
 =?utf-8?B?OVZBOGgyVk1kUmI5M1I2MlV0cURIWDFQMUhjUkhweWRBSW9MazNLVVl2eUZL?=
 =?utf-8?B?ZEVXTjJOTEswYmUzQUdvTG04THZudWozRjNrUVpLb3hOeGZHdmI5dEpuaWJl?=
 =?utf-8?B?UXo1czFRb2xxTFM0bVdUdEloblQ4TkZGT3FxMEpDdWxKaEtmSlJEaU0wZm45?=
 =?utf-8?B?S1UvQTFFNkhTSVVabVM1aGRGMmUwSGhnelNmM0pSMmEyQVpEUlBaTkpzN3Yw?=
 =?utf-8?B?RXk5TlJ6TU1LTU1BRkhQU0lWR0dWcGxabzFuc0piSWxBS2lVcW8zWWRDNkFZ?=
 =?utf-8?B?aDk2TWlvcjd6Zmlkb0hwdWRwaTkvbDJtMGIrbm50T1B5NWpzbEl3VnRuUG5W?=
 =?utf-8?B?WEVnZWVTVUpJVlF1ay80N2IxZUNwb2U4WHlkNGQ0aFg2K0JDYjZEVzY1Sk1m?=
 =?utf-8?B?WHZabnFGaHBPWFVNMTdXbndMU2JzOG1HSThIcjhQWU1iYTJqdkFJUURlZm1q?=
 =?utf-8?B?SEtQNHpDTzVMMWJhbWNlMVA4OXU1YzBGM3dwNnBHbXp4QlgvL0wrcDlFaVRw?=
 =?utf-8?B?KzljSkwzUUlQbWZTY2Y5T2dFZlNFWk8xUC9wbTE4YlM1MlZyc2JJOVZ3TEpT?=
 =?utf-8?B?eXNlc2d2N1JrZGNOZW85ZlJiUERUZEZvWWJMNWZwS0VGVEJTV0NFWHhKSndp?=
 =?utf-8?B?aWU5MGlXeExwNlFDUmVvd3F2SzNlNXJxWEY5MnFzVkMrOHBtVkJUWXRTNElX?=
 =?utf-8?B?ejRmOVovQVphOUlwa0w0ekR6RDZhTFJ6L3BYSlZ6OFE4ZFh0S29iT25Pb2V0?=
 =?utf-8?B?WXY3Q01na2hvQ3ZPS3B1VFdMQXdsd0UyZVkxOVQ4N2lSZTNaSHhWU0ZyMFV6?=
 =?utf-8?B?WThQNmozZzdEbkVuS09IcmdkOW9DM2RXbHJmb2V4NWEzeFFGcndjODhKMXFq?=
 =?utf-8?B?VmlaTnJ0WjB6aUtUNHU0NXVXZXRhcXB2YXh5Qi9nUFp2VDlubXRQM0J0N0g4?=
 =?utf-8?B?SmtPankwUS9aRGRtcFVoeGVYNjAycjRQM0RqbFVTMFp0c3g4T05sTjd3Wnk4?=
 =?utf-8?B?THRFMW9wZ2hUU2lGYm03VVVJN2Qxc3VMQ2NGcGVxOUx5NlN1MjB0cTZxeDdE?=
 =?utf-8?B?OFFSOU04WW9LVWk4NDB1WUMyUlAzQVBGbnAxVHo4Z3BHOS93SDlpd3VOcmp2?=
 =?utf-8?B?UHNvYnU1SnUxOFNOeVVIOWRHb0k3NEZ2K29tZFJTWm9TWHUzWHUwalNJYVJz?=
 =?utf-8?B?REhLWTMrUjAzS1NKa01mWjRaQkhWUUJnb1JBK3RlVC9GV25pKzh6Mzdrc1p6?=
 =?utf-8?B?RTdsN0lPdkpsbTRIb2RwN081K20ralRmQkMxK1lxbk43dWJJZzJFTElmcG9E?=
 =?utf-8?B?SVBlN3RDL3BSc3BycjJJdU9hQmw0TkMxWk94ZHdFdmw1c0QzakVoVTdoZ1BR?=
 =?utf-8?B?OVRRUHMweTIvamRBbkVMWXJ6bDJMY2tOelh3ZGY0Wmo5WldmZnluQXZ6TDRV?=
 =?utf-8?B?bWFjZHNaWjdPUjRrTDczODVXSUtzdlNqL3lTM21pSFhBN0sybCtkUmtNYXRO?=
 =?utf-8?Q?DqVVYLeBvfFoxowxOhCrfUel85lZox4+d5TighX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fbb351c-be01-46a8-6360-08d8e4125633
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 22:17:48.3978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iwiv+ckaijzFzb+ajc+f1FT9U44iSjcnFcN7Hwg2XgGisAwMCetZO2FuZT2IlHWGDasqTIsgS2qsrCSqi3hOeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2449
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-03-09 3:46 a.m., Nirmoy Das wrote:
> Allow allocating BO structures with different structure size
> than struct amdgpu_bo.
>
> v2: Check bo_ptr_size in all amdgpu_bo_create() caller.
>
> CC: felix.kuehling@amd.com
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>

The series is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      | 2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c       | 2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 8 ++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_test.c      | 1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 1 +
>   9 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index f44185f512de..2151fcb1e19d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -245,6 +245,7 @@ int amdgpu_amdkfd_alloc_gtt_mem(struct kgd_dev *kgd, size_t size,
>   	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
>   	bp.type = ttm_bo_type_kernel;
>   	bp.resv = NULL;
> +	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>
>   	if (cp_mqd_gfx9)
>   		bp.flags |= AMDGPU_GEM_CREATE_CP_MQD_GFX9;
> @@ -326,6 +327,7 @@ int amdgpu_amdkfd_alloc_gws(struct kgd_dev *kgd, size_t size,
>   	bp.flags = AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
>   	bp.type = ttm_bo_type_device;
>   	bp.resv = NULL;
> +	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>
>   	r = amdgpu_bo_create(adev, &bp, &bo);
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> index d9b35df33806..313517f7cf10 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
> @@ -85,6 +85,8 @@ static void amdgpu_benchmark_move(struct amdgpu_device *adev, unsigned size,
>   	bp.flags = 0;
>   	bp.type = ttm_bo_type_kernel;
>   	bp.resv = NULL;
> +	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> +
>   	n = AMDGPU_BENCHMARK_ITERATIONS;
>   	r = amdgpu_bo_create(adev, &bp, &sobj);
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index 5807cad833d3..c5a9a4fb10d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -126,6 +126,8 @@ int amdgpu_gart_table_vram_alloc(struct amdgpu_device *adev)
>   			AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>   		bp.type = ttm_bo_type_kernel;
>   		bp.resv = NULL;
> +		bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> +
>   		r = amdgpu_bo_create(adev, &bp, &adev->gart.bo);
>   		if (r) {
>   			return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index fb7171e5507c..bca260d56f76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -71,6 +71,8 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
>   	bp.preferred_domain = initial_domain;
>   	bp.flags = flags;
>   	bp.domain = initial_domain;
> +	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> +
>   	r = amdgpu_bo_create(adev, &bp, &bo);
>   	if (r)
>   		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 6f7995293a1e..1e07c66676c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -55,6 +55,8 @@ int amdgpu_gmc_pdb0_alloc(struct amdgpu_device *adev)
>   		AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>   	bp.type = ttm_bo_type_kernel;
>   	bp.resv = NULL;
> +	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> +
>   	r = amdgpu_bo_create(adev, &bp, &adev->gmc.pdb0_bo);
>   	if (r)
>   		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index ac1bb5089260..c30f10f931fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -248,6 +248,7 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *adev,
>   	bp.flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>   	bp.type = ttm_bo_type_kernel;
>   	bp.resv = NULL;
> +	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>
>   	if (!*bo_ptr) {
>   		r = amdgpu_bo_create(adev, &bp, bo_ptr);
> @@ -543,9 +544,10 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
>   	if (!amdgpu_bo_validate_size(adev, size, bp->domain))
>   		return -ENOMEM;
>
> -	*bo_ptr = NULL;
> +	BUG_ON(bp->bo_ptr_size < sizeof(struct amdgpu_bo));
>
> -	bo = kzalloc(sizeof(struct amdgpu_bo), GFP_KERNEL);
> +	*bo_ptr = NULL;
> +	bo = kzalloc(bp->bo_ptr_size, GFP_KERNEL);
>   	if (bo == NULL)
>   		return -ENOMEM;
>   	drm_gem_private_object_init(adev_to_drm(adev), &bo->tbo.base, size);
> @@ -635,6 +637,7 @@ static int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
>   		AMDGPU_GEM_CREATE_SHADOW;
>   	bp.type = ttm_bo_type_kernel;
>   	bp.resv = bo->tbo.base.resv;
> +	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>
>   	r = amdgpu_bo_do_create(adev, &bp, &bo->shadow);
>   	if (!r) {
> @@ -669,6 +672,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   	int r;
>
>   	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
> +
>   	r = amdgpu_bo_do_create(adev, bp, bo_ptr);
>   	if (r)
>   		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 54ceb065e546..8e2b556f0b7b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -40,6 +40,7 @@
>   struct amdgpu_bo_param {
>   	unsigned long			size;
>   	int				byte_align;
> +	u32				bo_ptr_size;
>   	u32				domain;
>   	u32				preferred_domain;
>   	u64				flags;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
> index 7b230bcbf2c6..909d830b513e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
> @@ -62,6 +62,7 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
>   	bp.flags = 0;
>   	bp.type = ttm_bo_type_kernel;
>   	bp.resv = NULL;
> +	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>
>   	r = amdgpu_bo_create(adev, &bp, &vram_obj);
>   	if (r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 9d19078246c8..a8f8b9a06899 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -869,6 +869,7 @@ static void amdgpu_vm_bo_param(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	bp->domain = amdgpu_bo_get_preferred_pin_domain(adev, bp->domain);
>   	bp->flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
>   		AMDGPU_GEM_CREATE_CPU_GTT_USWC;
> +	bp->bo_ptr_size = sizeof(struct amdgpu_bo);
>   	if (vm->use_cpu_for_update)
>   		bp->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
>   	else if (!vm->root.base.bo || vm->root.base.bo->shadow)
> --
> 2.30.1
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

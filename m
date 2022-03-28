Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4E8C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 13:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEE2010E686;
	Mon, 28 Mar 2022 13:14:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2D0910E686
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 13:14:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMcRboJcEbmxXraaZ1f/jvO5MZqxuh0KWadkFF0QN2n1zCp1l1B6gsBk6YkFsWgxko4m9ySRfNstdS1miivuKhx9lJ/K+08GjBVSUJYRzr0+NHzviz9sRKXr5fh+6KQUXMPrFSvnSJyUSCLEb+P0fCWMBA0ezHB2ABFUj/+eG98QbALy0rfJDKgEADnHLPvp49m/o7MDTl55yBgxKkYc1Rv0Iqj61AHj6KiOWl8BELevjfEjQSkVJnfbKY/BxpbYA1sJV7aczBwnQVdcS4617947UoBbEtPgodAS2w6v0Y1feQtsjyskGvEaCGxluSpVmJqWS9jRvb0UnAPRUF5O4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JSEEyZ25YLiKITCqv6oBLZ9c5Xf5EQqlmnjXqEJrNg=;
 b=Scd/vaCctOe9DnjA4Ob9xcKCcQQI30m5ONrBvlyZpZPGoq207R2EWLuROYE+6IO+2phnUN5XnOcR6TwzTh+fxGHWsB86gvGCDSeXtfsdxhxaKPKfKUxhPyiPUEl5r6cQ6/nQQgJVVxHBtP3E8IRAifSlNGlLpDctjoQA86AFSkpeUPGA359JjxlC0z41V4Vfp2KCR78U+C6hSR/MIxBFDjXbN7oXekTH8VXZJEI0kM5s823Dbjc9zv6wbq8vhfbYiDGvD7P8sX50r4pj4cJv7xBfmOm2n3JOezbPGonbwQ8/Ub8OZaWyOfijdxUxYBiPARJGPD/UDvV7OmRqK2WFSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JSEEyZ25YLiKITCqv6oBLZ9c5Xf5EQqlmnjXqEJrNg=;
 b=PmaCvnx2Ase09nTraphvOshx9Vx/TxqP1Lu89ve44GPycKbrdTlk5RyIh3EuchmZlp0/Uz665R7l/QzqsAIPyc9ehyJoCOikdJ8qioYzOS3XP7vTKUNxewRkiMq6sQt7ZZpcTRxpMMSwGQQkoeown9IfoLh38d+Mo98BDDB5Qck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BYAPR12MB2965.namprd12.prod.outlook.com (2603:10b6:a03:ae::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 13:14:16 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 13:14:16 +0000
Message-ID: <9d0cc505-0e31-12b9-6d3e-4cd1d4c54646@amd.com>
Date: Mon, 28 Mar 2022 15:14:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/3] drm/amdgpu: Correct unlocked update fence handling
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220328130700.29642-1-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220328130700.29642-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0349.eurprd06.prod.outlook.com
 (2603:10a6:20b:466::24) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efc05da0-e92a-44d9-83a6-08da10bcdc55
X-MS-TrafficTypeDiagnostic: BYAPR12MB2965:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB29654F7B12A768AE4778651B831D9@BYAPR12MB2965.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nnvYNRT4F/30othvXNgX2zOl+xawVRV1CRbTEBCawq79Z21lM7l1YssxUzmZrrCPd37lpfvUms0GmvMZd0I2i6XiHrvjYPCVQWZGAs0b4jj3ve8DBIrOfozss85Y9+bS9U6AtKdqMCtoMZrXlQg5YmCKp9xM3QbfSj2ogCIR+5wv82HKVs9zh8fXH/9kfzl4ON93VmO0yHZPTEoIHtNaQ0PuMHaTLltlzLIGgQLfGXcwljAmho/v0L0/BJ0iSaxEyOYhPm+vKfJhLvbdHbNEdcbWHDIeqj2WK12GbpmXzct4msP+sDQhS4dDDOO/LcI/ySFn/NMF7usWrCeP+nlSdC5ItKx9mTB1brxJIBgs/SKnZOAcTjGczG9ZZilWauxTLyXHVY6I9msg7sEjqhmHJm7QMh7enAL1Jkgp9j/Z5t1EmJlPHqAGVCjbpzCfkyErpkOUbepeg2IagjcWHj5yWmuljWkDeKtJhTyfLNnxsvOxdXpMnnRWcr3V6p4ZHTES2Owg3ZX22eLt6Kz8iqBDjdKxBgtJvuVqFASbwY7EknW8c/XyAms1tUAvxFH8DW+MhCagch534RFXrCO/1DD9IwQ6J6vLSJh+9EDGJUHWQp7QpUHvuitczwR4jKQzy8A9SZePveibBF/H66262y9ixmHBTBE1XBbpYZk6WhCfsh1UBcHi3yvkLy9gB/NE+TyBAIztCUXa2Nlu2Eh/bp7P994ChE3T2IB8vezvzQOMp8LaXcbg8t5pqOObxwEwn+tH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(86362001)(15650500001)(31696002)(83380400001)(186003)(5660300002)(66476007)(66556008)(66946007)(6666004)(8936002)(2906002)(4326008)(2616005)(8676002)(6506007)(36756003)(6486002)(508600001)(38100700002)(31686004)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG1TWWRucVFZR0RyVmtSaGRrK0t4QmVjaFJtdUNETnBNRHdPOWxCWVpneERZ?=
 =?utf-8?B?TEJiMDAxQXMySXBRYTdHajQrYUdQNllmSzNGUlQ3SCt1RENrN3YrU1ZjN252?=
 =?utf-8?B?SFdCZC9iamNWODNoeDlLOEpoY2ZBUXhzQ3FmVFZwOE9valAyRG1FVW9mazdz?=
 =?utf-8?B?Uldja28zaVVuRVRDUy81ZUk1SVd0dllEakhUWCs5YWY2Z1RUVTBqdWhLNnhU?=
 =?utf-8?B?THlQUjE4Sk5rNElpOFZyY1ZYZEFZcFdJNjY4WFRWODdVU05iMlYwVCtJSmlm?=
 =?utf-8?B?SURIMVRoNWV2eFNlZDJmV0VxbU1CTnBxWi9uR3E3eXk4T3VnS2dTVUx4N3Vm?=
 =?utf-8?B?RllLcHliN3Z5Z2kxSGczamdqMVN1NEFjQi85Qm9SZEJVT0hGMnlYaTc4Q0Jy?=
 =?utf-8?B?M0JERXJ6c3lDZlRpRTZ3SlVFN0pFajNka0dsYUhQRkRWcXFQVjlHZHZONjZF?=
 =?utf-8?B?cVF5NHVIQTlRcy96YkdOUXI3OWV0a0syQmRoVi9LMmtBeDZnMy8rQzY5TE5Y?=
 =?utf-8?B?TU1LOUhMbEl6RnA3ZWEydlFNQ2NIYml0aGErMmdGdWtOZ0R4VmgvbHBtZlkr?=
 =?utf-8?B?NkJqcFZiMXJnSU4rd2FQM05qNlJrNTVnUzZvR2x0UGt2eEROaCtsSHZZcG1L?=
 =?utf-8?B?OW00d1FFSTVRTWRPRmpBYUI4K1B4L04rWVRDU2d2a1VCbVd2TXlMRmRPT2wx?=
 =?utf-8?B?aFM1TnhXMStOeE9XZFBtMzU3Q0tSY0VsVVVUV2hYTkNqM2JzVERjV0hMbTk5?=
 =?utf-8?B?a1J4eTN3bTNkcFJiV1hVd2lNRG03emEwSXRCaWdVYWhGUFc2RHpOdjJjbmd5?=
 =?utf-8?B?Q2kxSzI1Q1dndnQ3djM1eG03empQQ2VQWitEdHlNNDNMNHRBTjRpR01YQmtB?=
 =?utf-8?B?N1ZFYzd2Zlh5QzZ0bkhNeW8yK0ZyWU82N1l0UTZhdkZMdjhtN1FFa1dHZkhk?=
 =?utf-8?B?T1FJdi9oWjFBc3czaENIdHdaOTdoaXNuUHJWZjhXd3pTZG15MXhiMzNJSmcz?=
 =?utf-8?B?K3VzUXVDYkFEM293YjVYSi9OenhIa25xR3R2bmRoTTJjbytXakRGeTZjbEti?=
 =?utf-8?B?OTRUeVBoWXI4VFhwdHhIQWxaZlBDRitQeXJ6b0xYRTY2VkZiM3hFTzdiVXdF?=
 =?utf-8?B?ajZqOFdWWGpEUmF4TC96bTZxakE4bVhOL3h1VUU4UU5RZ0RWTUVIZlkvMVFF?=
 =?utf-8?B?V08xN3c3OXR2OHBqZmtNR0JRMTkxMElxV0hFRGJOUmR2UDMzTTNZNDBxd1VH?=
 =?utf-8?B?aExUT3NiSlB2TWdTeDdFTjMrQnBTUUttV2JDRWZsWE5kOUtHbWlZRUdEWHlm?=
 =?utf-8?B?U2orUGR2cHlTMXNWUTd3L3JkbWp3MDVJVWFzTldjdVZTM2I3dEdEZit6cXlP?=
 =?utf-8?B?d05mTTk2VUZnWm1SK2l6amUwaWRxbkF4anZQRUdVOWdJR0ZoL0c3ci9SQWVh?=
 =?utf-8?B?QmRtL1dPYXZlRmZEYUFZVnROVFkvZkR3aHJWeEpqbVg3NWgrVVRKK1NqeExC?=
 =?utf-8?B?aWFGZm1yL2s5ekFWYlNHcDZzQ2o5VVZQViszbjFHRFZMUm01UTRFNjBFdEl6?=
 =?utf-8?B?SENEMlhqL0FscWdkTzBnMmlCbC94UHhTcThMYXdnRU5JVnNQN0JUMEpqbWxL?=
 =?utf-8?B?Q3JuOXowUytTZHBPNVRObUdqUEpFRHFlaGxWMTFTczljTVRTa3BzZ1ljbjM5?=
 =?utf-8?B?NFgzUVBVeHJCU3BpbjlobGVvaDdpQ0w3ejF0TytWTllJYzRFZ08rd3JzcU9E?=
 =?utf-8?B?eG9JY2FKeTVoTkVwbW4wVmdEdTJtUzlTUTZraHh4NHhaS1lYZ1VyUm42L1BU?=
 =?utf-8?B?ZkliZlE2dUJ5VEg4VjRpb1RpM0I5d1RsUzliWC9YR0NPNWxRR3ZXeUJ6bWdW?=
 =?utf-8?B?T01nU3R3SEtJYkYrem5XN3B1WmRXMlN4V2NGQVNvY2pBS21XUENSZ3ZXQ3ls?=
 =?utf-8?B?VDFtNFZMVXlPdDAzb3lXU1FzWTQxUVVPVHpZN3E3TWw0YUpRRHJza3paVzhP?=
 =?utf-8?B?U3pXQlFFcGdkemJqM3ZvSHlaQXI0a0FUeXBlTy93R3RjNGFLYnQ3NGVDMVVW?=
 =?utf-8?B?cjN2N0F1SEtMUlZEaXdBYXRFbW1ITnB5RHZEbFJkSEF5ckJ3dHE5djJuUjRx?=
 =?utf-8?B?SzBQbGFxUHdyV2ZuTGNraFJwTHJNZ3hVUy9hQldKSWdoOHE4WmMvVldPYUlI?=
 =?utf-8?B?Z1F5bDIvb0lpa214YlRSOEdUQytINk0rVkZRU3BuOE1qVE9ORW5HdlhDdzVj?=
 =?utf-8?B?bStoZVUrMGF4U1ZWeTFGMTIzdFNSRTRMQ05mUkl2YnFsVk8xazQwa2N1Tk9B?=
 =?utf-8?B?NmRTZVVHZEc5aXo1YS9qZXJmY2ZtZlZpRDI3YzQ3Q1ZlZHdjNkxUNkVjMVFX?=
 =?utf-8?Q?cnvm7AH7n/+qg07L0Rc/iAWxRiDZqqKilVek0OpCWXMnW?=
X-MS-Exchange-AntiSpam-MessageData-1: p9U8lGNFoepqrg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efc05da0-e92a-44d9-83a6-08da10bcdc55
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 13:14:16.4709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGkgUswCojEhZBIKNGqpL1EoOvmJlHoFUNwwBXVmvlVdNSnBti+XgIK3OVVJZ1Qx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2965
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
Cc: felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 28.03.22 um 15:06 schrieb Philip Yang:
> To fix two issues with unlocked update fence:
>
> 1. vm->last_unlocked store the latest fence without taking refcount.
> 2. amdgpu_vm_bo_update_mapping returns old fence, not the latest fence.

NAK, that code here is perfectly correct.

vm->last_unlocked gets a reference to the last unlocked operation.

Otherwise the last locked operation is added directly to the root resv 
object.

Regards,
Christian.

>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index dbb551762805..69fba68ff88e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -109,7 +109,7 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
>   	if (p->unlocked) {
>   		struct dma_fence *tmp = dma_fence_get(f);
>   
> -		swap(p->vm->last_unlocked, f);
> +		swap(p->vm->last_unlocked, tmp);
>   		dma_fence_put(tmp);
>   	} else {
>   		amdgpu_bo_fence(p->vm->root.bo, f, true);


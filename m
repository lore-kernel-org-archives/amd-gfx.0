Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E10C6FA9D
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Mar 2023 18:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8C0710E1E6;
	Wed,  1 Mar 2023 18:54:19 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C7410E1E6
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Mar 2023 18:54:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYmw4wre4x7s/koj4rSePn038RVlbxX5Qd+23e5sNwGpLrRwTDRCBfrdqcPynrubCT3UUV+U/BBQTlKEUuYDV+E343+Bz3ZsmaBZGZ2cV4wf/ys3sgRbHU1PjGl6LnvG4T4aAYE0eVy6wgC3JLxOSvDrwa4vESx1I4oCJyg2OyKfGBPh3jVLziO0drzTKJRn6ZmC+S/bnYOWQAXibEoV6QPfO7wdpNRbmM5o3AFg7yXbzuE2LIJFx2AF5x+SC2qaodaKs0DuQKdQLy7q+bcdZpwjs/myJ6W9QJVYI7XA5SA/hNhrgphwQhCqjFAI2oyDPLvKUBn0UNl/ZqSZc80GoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euoKsjADV1pVoZTP86wrWh7fO+PdPfY1zMlUhKt2LD4=;
 b=m8gu63mKVD/lENB81RiRTsgUNTznzXgTcw/EU6Hh7MknPHs5o33mSvj8EyNcguIN3Z7Wew08HpShV+E2ido+JkUVGg1YiJmwE49BiqgiSh4UbEVIRdSxBxsXky7QOtM4GrD+S3c9TqfuAkhudhm1gEE0Qkynp8qno1fb86C4ioPMcztwlIxEMtabMIRfKEgj6VDTbm+KagsviU+KkG/h7Dn78mNs+enKFXrraRhdjv+ZH037egOREy7xxhv7YLbDNArd2miha/qzX/UEZet1aQ+0NPFAZhNPW1QN6vdYDulHOCAHk7D36wz3havOqDMItgZqUJQMMbpt+9rhrWvD3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euoKsjADV1pVoZTP86wrWh7fO+PdPfY1zMlUhKt2LD4=;
 b=aEnain1nb2uarhUTC4ljIB/d4uNy2zbvmMmpPpllqfCIXYd60YxszjOJRDGZkiEZ0c7bvaAGwlpT9La/X7bBWdMFdKIxEFAiaikMwTAOZ3hSVtXpPwfuiYuFrGAmVXFsil7zT6BjvdsX5m8YCQ8ih5c6JfD4GX012FLL/a5uo6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB6907.namprd12.prod.outlook.com (2603:10b6:510:1b9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.26; Wed, 1 Mar
 2023 18:54:15 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::23f:22c1:b49e:b77e%4]) with mapi id 15.20.6156.018; Wed, 1 Mar 2023
 18:54:15 +0000
Message-ID: <1334b675-406b-c864-31c8-99dbc7fb0e6b@amd.com>
Date: Wed, 1 Mar 2023 13:54:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] drm/amdkfd: Cal vram offset in TTM resource for each
 svm_migrate_copy_to_vram
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230301163430.1782358-1-xiaogang.chen@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230301163430.1782358-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0002.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: c51fd93c-3136-499a-3649-08db1a865a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eVZPfQN7gY0MGtItdGNHpcnVhhnsrDLkC6zsMLS4ChxJiHM1Bohwu3OTIQXTNPuEG8WhrU84EN+8h/PQujG3kWjg4oJ3CyOFXCPREDeMJbX/iVX2Avrh5YKqKPDWPmGeJD7mgFn2UwksUdgvSHbnV9NN3PjbuwlT7BotjCzB8gOGtOMeyqPYa8cJcWZEvb0nGv2nD61gOqOgxFH7Qn3UCKOW51EKlWXwXGa/tTDd+4XZt75ybkKSn5/Sc5m1Q09CK28nSgxra4UDBNrY3DBfIq0ZrpF/pFtQyP8Amoz4EO9Na9mArSJrLoRsLLnXVCJzHDl7OjO9f+aKAuXOJBHsdPKN0bjlPjPLZehmB7STwgg2k8iqE3FmVZNxIjIQz74VLlFre2i4ogLFjwDHWNkDiKKfPaaeSbDgb4DWpXSTzrE+fgFJf6nPnYt5l9Xdv2Dxsx3TnEj1GMYCnvrCrnCzZwkcHoQlsNLwWRjR2m0YeYzyG6DajE83GqTz7SQWl5rPhlE3d6XGHRV1/y37x/9ZHTByNwMWRcryYx+L3TXeoqkN7WTjH8Wz7vscx20mHN43DsTF62WeIkYaILP6Bxq2VgnTQQNSk5x3JwKDZ3ITm/slYsOZNUhp8189m6jncapJ26XftKQBpxafySF9ujMydfU+g5I0a21V0Ur4fPFsYRHKJB224wAFDjVRWVuztPm05QR1WYRux+bfcpZjw5GOYY3yraa7ZI0uv5gskb/b5Kc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199018)(86362001)(31696002)(36756003)(38100700002)(478600001)(8936002)(41300700001)(8676002)(66946007)(66556008)(66476007)(4326008)(2906002)(316002)(5660300002)(83380400001)(6486002)(44832011)(6506007)(26005)(6666004)(6512007)(2616005)(186003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHhjZG1iRHYzT29zT2NhckFtNjZJbGh3eW1rY0FQcmJNeWNSQk8xN1ZFTTlU?=
 =?utf-8?B?Szg0YlB3cXpicVIyMFUxYzFYVm9Ccktqalp0aW1qTUZzUDlCS1BMRFpzL1ly?=
 =?utf-8?B?S3VURUJQZmJ5Y0RraXBESjZwVWxjSjVBZlR2TUhySXcwNXRDZGJXTEdNc1pF?=
 =?utf-8?B?M3hIQUwxS283R3B4L2lxK3dINkM4K2V3UnRUSnhFc1llV0VWTkxVelNabXB1?=
 =?utf-8?B?TUpDSjljK1NRZnJTWE1CNE9PUS9NWGdBVXZwdC9TUWN6MVVHeHpxME1hMlpV?=
 =?utf-8?B?Y05NaWlKMFI1V2dEOEE4bGlUdndhbko3M1BxMzRqQkV5N0lLaG5ub2NDUHcv?=
 =?utf-8?B?T054V1RrZDNZMzdabHRibnJWWEplNU5kY3JaY09hRU1nbTRZZStWZjZtNm52?=
 =?utf-8?B?ZWxaSU1leUJybXc3ZXlPRnB5WjFsbk5mWm5URmZZVXhMZjRBblNVdCtHdGVL?=
 =?utf-8?B?V3N1SFhVOGZiWG1vY2tHMk95WGNId0ZCZ2JYZXAxVXMxbFRJWmJKTlg0cThm?=
 =?utf-8?B?YkFKbEpnVHFaUHJueGlsYVVBTWJWSmx4UGh0L1VkK0tkNlY1d0FYWUNLNHdv?=
 =?utf-8?B?VUlacEFPNnFqOGZ2MGQ5WWgyT3ZHaHh2am5DNk9wUzZCZXRyMjJaak5KQmUv?=
 =?utf-8?B?bkRBU0hJTkUxakxXYlVzZTJwcmxWVzcxK2VVMHk5NWhwVWthNU9VcXVFQlJJ?=
 =?utf-8?B?dGNVeGpRckJNNmpJQURyWTZQam9SUmV2ejhtT3BZa0NBdUd5TGVOTlFIbDJ1?=
 =?utf-8?B?NUM0K0lpb2czSDFVVDhFcnhUemExc1RQcnd3Vy9FN0ViblBjeGgvVGlBZnE2?=
 =?utf-8?B?RnpNdm5CSVExZzlLZHpuaERRRUU3SFFwbmJsVFZyU1NGQWFTeThlZzJ2eVRN?=
 =?utf-8?B?dHRRYitVaW9DQ21FdjFGTXhISlovSTRKdEtSTzRVNEdVMjJpSnZHajIzaDBl?=
 =?utf-8?B?M1NCVE14MHcrdkNrcE9Ra21NcjlDUTBxeFl5K2xlcDJXeEtQeTZoMWF1N1gx?=
 =?utf-8?B?NnFRSUtZLzRuNlg3ZkszMVkwbDdJckc2NzVWdXA1NUduYjdnVWVWMXJqN1FQ?=
 =?utf-8?B?b25JTkZzZWdSOE5SdmpZeU5XZ0Q3ZG4xRmJNbzl2S1VwMEFSTVlkaXhRTVZD?=
 =?utf-8?B?U1JQbVc2bVYxb25jNDNDWWdnUjByOVg3TTdmMERHcmRSbVVvNThBSlpZZHZK?=
 =?utf-8?B?TzhMVjdCeU9BS3I0NUhjRU5lMDhNS2krdTdQT1ArK21XVlBudHlra2RaMk12?=
 =?utf-8?B?U01pdFo2QUdiWUFzdXA4QnBSdEN6Nm9OaEpIZTVjZzA3MU9WbWtHTVVBSlpu?=
 =?utf-8?B?SHlmd0FzQmRKcXRXeE8yNVprbmd0U0lFYVNsRmZtak9aOEpEMXplTjBBaGpU?=
 =?utf-8?B?UmlXamtNc1RFcitOa2tqd01vc1F3S0x6bGtTbkVZQ3JBY2dGOUVxTFQyZ05v?=
 =?utf-8?B?QkNIRWh0blg0aTZlWHg3Q2p3SmRVbzFSdHBxYU1GQmNTaUhGTlEzaCsyOGgw?=
 =?utf-8?B?SW5jMjYwd3M5Yktmei9jTG9xN1cxakZvVjFWb3JlcWNxZWNJdGhucUVsTHpm?=
 =?utf-8?B?VVdpOFYydlJhNUwydUVQL1ExN3B1Kzc3cUtNMHRPMGgvL2w2L0JsSmFiNkxP?=
 =?utf-8?B?T1JSK3dyQzFvODNMelZvcm9ITXFqY2dYQnpET3FRempBcUVXaC9icmtkR3VE?=
 =?utf-8?B?U0hmTEFHd0tlQ20vc29QNS9nempiSGFPanUvVzFBejF6UVZIZG1FOGhRY0hO?=
 =?utf-8?B?cUN0c085WHFUcmUvQ2pQQy9KaFowQVc2MkE2VW01SFpYTkJWQk5aNmFPS3dY?=
 =?utf-8?B?NThUalZHNTFpa0pTOGJwN2tGb3F0REY3SC9FZTV2SGFETGJMQ1BqZFVSSkI2?=
 =?utf-8?B?MEJtSSsyNStvNE5KWXRRSmVmS25WemtGYUQ4M2x3S1Bnc25lNy9nOTJTRGhQ?=
 =?utf-8?B?cSs4eXUvOE53M1U3LytzQWNPdUN6TGM5MzJLWWs0ajI4eHR1WU9LaDZnSGVv?=
 =?utf-8?B?OXVkbzYyL2QrblkxTC9CdGRPVVBPdUk0NWROb21aU0tqb3NLamRubVFqRXkr?=
 =?utf-8?B?bW1kQ0Q5ZnhWRTBCSUpxN2dndWxobjFTQmJWL29pb0ltWXUrY1IrWFR5NWxU?=
 =?utf-8?Q?qvRP2rhWHtpGeCbaom3BOSqCM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c51fd93c-3136-499a-3649-08db1a865a84
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 18:54:15.1329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mU2oir4QbfLrDhimVX4bkSwD3J0xD6Qv2Q5o0pPPnTPBR/Cf1AJG/1EowMgtEZQOlTJ5/NIA/QJDiASaJSUeuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6907
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
Cc: Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2023-03-01 um 11:34 schrieb Xiaogang.Chen:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> svm_migrate_ram_to_vram migrates a prange from sys ram to vram. The prange may
> cross multiple vma. Need remember current dst vram offset in the TTM resource for
> each migration.
>
> Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>

The patch looks good to me. Is this a typo in the title: "Cal vram 
offset ..."? Should this be "Calculate vram offset ..."?

For a shorter title I'd suggest: "Fix BO offset for multi-VMA page 
migration".

Is a similar fix needed for migration in the other direction, VRAM to 
system memory?

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 1c625433ff30..373cd7b0e1ca 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -294,7 +294,7 @@ static unsigned long svm_migrate_unsuccessful_pages(struct migrate_vma *migrate)
>   static int
>   svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   			 struct migrate_vma *migrate, struct dma_fence **mfence,
> -			 dma_addr_t *scratch)
> +			 dma_addr_t *scratch, uint64_t ttm_res_offset)
>   {
>   	uint64_t npages = migrate->npages;
>   	struct device *dev = adev->dev;
> @@ -304,8 +304,8 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   	uint64_t i, j;
>   	int r;
>   
> -	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
> -		 prange->last);
> +	pr_debug("svms 0x%p [0x%lx 0x%lx 0x%lx]\n", prange->svms, prange->start,
> +		 prange->last, ttm_res_offset);
>   
>   	src = scratch;
>   	dst = (uint64_t *)(scratch + npages);
> @@ -316,7 +316,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   		goto out;
>   	}
>   
> -	amdgpu_res_first(prange->ttm_res, prange->offset << PAGE_SHIFT,
> +	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
>   			 npages << PAGE_SHIFT, &cursor);
>   	for (i = j = 0; i < npages; i++) {
>   		struct page *spage;
> @@ -403,7 +403,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   static long
>   svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   			struct vm_area_struct *vma, uint64_t start,
> -			uint64_t end, uint32_t trigger)
> +			uint64_t end, uint32_t trigger, uint64_t ttm_res_offset)
>   {
>   	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
>   	uint64_t npages = (end - start) >> PAGE_SHIFT;
> @@ -456,7 +456,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   	else
>   		pr_debug("0x%lx pages migrated\n", cpages);
>   
> -	r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence, scratch);
> +	r = svm_migrate_copy_to_vram(adev, prange, &migrate, &mfence, scratch, ttm_res_offset);
>   	migrate_vma_pages(&migrate);
>   
>   	pr_debug("successful/cpages/npages 0x%lx/0x%lx/0x%lx\n",
> @@ -504,6 +504,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	unsigned long addr, start, end;
>   	struct vm_area_struct *vma;
>   	struct amdgpu_device *adev;
> +	uint64_t ttm_res_offset;
>   	unsigned long cpages = 0;
>   	long r = 0;
>   
> @@ -524,6 +525,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   
>   	start = prange->start << PAGE_SHIFT;
>   	end = (prange->last + 1) << PAGE_SHIFT;
> +	ttm_res_offset = prange->offset << PAGE_SHIFT;
>   
>   	for (addr = start; addr < end;) {
>   		unsigned long next;
> @@ -533,13 +535,14 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   			break;
>   
>   		next = min(vma->vm_end, end);
> -		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next, trigger);
> +		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next, trigger, ttm_res_offset);
>   		if (r < 0) {
>   			pr_debug("failed %ld to migrate\n", r);
>   			break;
>   		} else {
>   			cpages += r;
>   		}
> +		ttm_res_offset += next - addr;
>   		addr = next;
>   	}
>   

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB7EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 09:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8652A10E164;
	Mon, 28 Mar 2022 09:21:56 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2047.outbound.protection.outlook.com [40.107.212.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A2CB10E164
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 09:21:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MF7z6YljubNSexsh7cf8Lx/O6NL5Tabi3XNAyaEIkr0K1cA0f7GySQxobv4wFa+Er+ikRRN97xOvkJ09aFM7DKCAVzKu+GBZ/lLGJlvQ+792SjG1A4Jqk4fVqWmQwcCeJyjQJfSk2AtT7r7jtbYJvLjUks3ZiXQGZgw+O8vWIcRtqlDg/yJpEdXrprADb2Db4P4nRb94a84uYFke8fjFc45R0TGYtZMKFJQ8p/LiPudjk2cHQlDbRw6X5dV7hJrU/YWQDnlchYXDsyaUmhXvQqDHPf3kNzLaOSKFlaNJgR31gZbCzHjkKZMSSbOGHspGFGClqzuB23URev04vpVYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DP0llEb+GZW4TGki40HyHYCOG9hJitxAMIIymehmsmk=;
 b=DkXeWpmZkCKq2E8fz3P290E7zZEH5GormSQcVb5SSiy3u4huPUbR+Y8v9lKJftCXxNpyOrpM1750DlQ/efOr2d5fiewJLBGbkwx1KbJ1QsWbKeK9HdxypcZM3qZeO3T6kTTJ5wZGjSTajtUSEYuhRbZYCNCdCW0oqYwAz2Y7NnjT+ZepsQK+hbOMp/D6Sctjz4VWP/ssxGCaqZF2cGjKw9PVDfqgC8zTUZmmwo3YH658klII7qv/E4EOeO/TSeokf16KRDIS9cPd9PtaYVH0V3Ho2QVvf1f90AT/sirSfWcCiVlIcSBYnAd82Lgr0ENoKAdUSnw4ZablFQGnus/orQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DP0llEb+GZW4TGki40HyHYCOG9hJitxAMIIymehmsmk=;
 b=uJGuW3T1epYgEJlkoMKkvTZr2GYNzejKLFMNFThbpWtmtY928UQD4Ipyke/qcLNsosAjEdFh/ccmoMzIdcyR58GicWc6pJndrc0JvjxLLmaxWtwqDJ/q3QcfHa/2q4vCGtIgX6ttQk0exXULien58NFj533vLUGmZ2AXs3vZ2qQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM5PR12MB2549.namprd12.prod.outlook.com (2603:10b6:4:bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 09:21:51 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::404f:1fc8:9f4c:f185%6]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 09:21:50 +0000
Message-ID: <af7b9210-01e6-261e-b7c2-de29275f7a0b@amd.com>
Date: Mon, 28 Mar 2022 11:21:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] drm/amdgpu: Use last_unlocked fence for unlocked
 update
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220326005641.10284-1-Philip.Yang@amd.com>
 <20220326005641.10284-2-Philip.Yang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220326005641.10284-2-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0177.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::32) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b16368e4-43ec-4423-e395-08da109c63fb
X-MS-TrafficTypeDiagnostic: DM5PR12MB2549:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2549CBE85656A618FAF775B7831D9@DM5PR12MB2549.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l6iD38KNso+LeW+cHJ3BFAQuyx/XuYplIQ2Kp+1bR+Vd2YnI08g/3hhhZwSitpqBadaY5RN2zrf5ZNqXgdOxILajKVwI4wPvhYzodc2WKVQa8LIk/hNhHk6FvcfxhjukSep2Ud86BRmdEFXQrSRnrTdTvSB7xutDqScKKO4q7K0SkbOTtwsQkM6u67FewCv+TG7QIgwiu52uVNF5jHUNAWQ3w4fqGFmJ5+9GCVChuwAO7td0cSpQ2+nncwgn82H6CgxDtfsUHPq7yRbGPpM1gsnQXTUhMfqGRVPIKxLTWt7iecmNgISXfuh2baAgsHwGMUxJhF7GEDbCdVRAk/Ng3YzYWGdqHVqfNYLri3ThfCRfF4v72bs7pFbNsy0P8hZmpt8E47c4I2iCjejqtBNUHwD+qKs/KKavcuXrOId+kcNvnhNKlimyOO5rf7xMerOiFDf5WazfIIAFjo2MuoaCgbJHvFgcOwn7qcBUrPf3u5VJikpi28JCpGctntkC01RF8+IhQ5R3CD7CGl85xjWouHF8GVd7wNgOesA8SffGXIsNDH7xmMnsurQpkEtEu7dmSjf6IowEYXCINJSPzxB3nXzPv7LqsyJ6B2VZ1fhDwYB1y0lJ6djX0p8/VMV9tntg7hCLphvla9dVG1eA0USkVHjIJaallvVHfISvyut7E6D9IeZYzXMae9a6kbH3XORpvzwrHFnfAB5ElzPIm7vqemujrQg0EsJlrXmALBX6VtIg9nNN8vE9PlvC9miKcoYd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(66556008)(15650500001)(38100700002)(83380400001)(36756003)(6666004)(6506007)(6512007)(2906002)(6486002)(508600001)(31696002)(86362001)(31686004)(316002)(8936002)(2616005)(186003)(66946007)(66476007)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTBXc3ZuTjFVYzlOK2I5cmdhNkE4LzVQOEllc3pkUTA3aUV0TjhNY0pjZDly?=
 =?utf-8?B?cythbXlQMnNhSVJGVlJ2a1UxaG5KbXJwQzFqbnFnNVBMUnFzcWxPbFZRZ29F?=
 =?utf-8?B?cUk5SEkrcWw0QjVKRUQ1TUhIWHBXY2ZlYkNLOTFOamtqZ0VQRENkVTcvNjhV?=
 =?utf-8?B?UVNFU2JZek01Rzk4WHJ0a3d5cXU0Vjlha0tKYU5iNklXS1NaY0N2SWlFNDVU?=
 =?utf-8?B?bnJnamR1WnpTdUhXUG1kaDBDMGZpYWpwUm1QN1pidlhIZkgxbWZxZjdCVEZW?=
 =?utf-8?B?a1liYUllelpmWjdMcWMwOERkSzg4WUplaERmWlhUM2xOMTN3QzdHRWoxTCti?=
 =?utf-8?B?NXJVV0QvaHZwQmtyUWkyMDhFYW1hUjNiSk03UFlNVyt2Q2FneTBvNmRvQ2do?=
 =?utf-8?B?OE5waDd1Q0FXRFRZM1NrNXI1YU5sNmJYcHlhQmNWQnYrRm9yMW5xNERvQW5L?=
 =?utf-8?B?blM0UFZSUGMyL2xaMWtHd2VuSnZueWtoVHVEYW53dzVSdFYrdTRqcDZVN2Z5?=
 =?utf-8?B?VDJ6OStqZm9FWWRaaG0vMG1NZ1BJUlYzNC9XbnIydWxnYXdidXBzSDJuakM2?=
 =?utf-8?B?OEZpaHZSTzlGMVJ5M1ZwY28rOFB4MU5TRitaSlprZ2phZVNEYW56dkhrUEpB?=
 =?utf-8?B?MjVzdDJCdTNQUVAweVZmVlFDdExnZHVaT213U0J5bmJ0MDFwWk5iaXpxVWNo?=
 =?utf-8?B?QWpxUFRzeU5KSTF3bW96Wk50cGRyS1RaeUJ0elhtQkdONE1NekF3Z0hFOC8x?=
 =?utf-8?B?UkhjQzhOakVRczBPTXBlTXg5OXRLL2VrODJVcXNkb0hSOXc2SmRLeGJ3anVM?=
 =?utf-8?B?dzZwYmNKYjM0RnlZaXJYMDhLdDB6eUd1OWQrVHVmSmFJRmpSS21qQkRFM0xq?=
 =?utf-8?B?OTRmOVlmWlhCd2g1dzhQaTd6L3RSRzg1ZitRenpVVVVFUklmMHlkZklIRHJM?=
 =?utf-8?B?Y3czYTBpRzBwbGJTQjhiK2JYSzRkcTM5dklxd1dpcDFrZUJVN3Q2OWlUNVZU?=
 =?utf-8?B?aCtkL0FZWTA4VmV1dzUxSFM2R1NJekFBVVpxazZVQjZYL09rdjFLOUI4S1F6?=
 =?utf-8?B?OUZGdWhRZG9lU0NxandqVUMxeTFNZHd0KzhpWmNxbkVEeFBmWGduNHRsOWJP?=
 =?utf-8?B?OXdnUFlnRVF5Vkpydk1WZEhnYUlXazZ0cm5vbjJvdGVWVndtSUo3RHJkNjVJ?=
 =?utf-8?B?M21LTUYvaU1hckRLeDlhclVlbm1WZ2k1czZEK0N4UHRSMlcwUEJIK1hSWjBn?=
 =?utf-8?B?UVQ5cU9rbzRDTWd1UHd0MlV0dlhSV21Xb2VmMTcxMzlrVVU5ZnhYNXBJUTB0?=
 =?utf-8?B?ZGlRRG5RVHhka01Tc01qQ0ZnUUFnVEFWYTlxMzR4eHZKZVNlM2pHUi9Uc1dW?=
 =?utf-8?B?VFhaMHE0RlhxaFZSZXQzMEc2QXRWMmpWZDhhVEE0UDJkUHAyV21BWXRLbTdj?=
 =?utf-8?B?VzBFdHNSU2F0WThnMC85dEZUUFJsazJIYks1VHd6Y01YOWhrZUlHMjMzak5J?=
 =?utf-8?B?MGFkNGtOdTZwbVhFNDNBRjU4TWJtanRFN0NOb3VrVGV5d1N5TW4wTkVaTkow?=
 =?utf-8?B?eW5iUjhhemFqTGhhZWFSLysraDZIT09yQXplV0hsTXFWQnc2UkNxc2tRekJk?=
 =?utf-8?B?UHBMSmk3enZiQXVqMjNkQmJreDBiTERNMHQyaEp3ZUMraDVKUjdPQmV4NGlG?=
 =?utf-8?B?NFZYZ1RJNldCSU5FemZNaGZaWC9va1duelphNlNlT2JHa0tNL2J4bzNQcDF4?=
 =?utf-8?B?KzRjZnJmTHRMbVJLTFE0MjZZa2Q5WmNlUnc1NysrTnIwdjQyU3JWTjNBdFdT?=
 =?utf-8?B?alRGa0ZocWEvenFMQkRLdWl3RytQOGZHM2l6bVZsSVovdXRmTjkzbnZ0eW1n?=
 =?utf-8?B?SWtXSUFGYW9WMjlyOXRRNWI5TEMySHoyU0hLMXl5L2FLc1pZTksxM3NaeTlQ?=
 =?utf-8?B?RUFqTk1oZTNnTzExd0Zoelc5NXY5OFRwSFJWQUhVczdzYkpLS2ova0lEWEtm?=
 =?utf-8?B?WlYrbU85NUZlMjgvdU9kOERHYis4V0pIb3hydTNIY1BLQVFKT2t4MHloaDBT?=
 =?utf-8?B?a2N1ZkdraHFqSWFjRmFvc0pBMm9vRHpvN1ZoWDhKVW4rOUkzNlYyVjJDVklj?=
 =?utf-8?B?TGZJM2kwNy9waHptOTFJQngwVXZHT1FkOEpveTJPZEw3MEFPSkR0NTlaWVhq?=
 =?utf-8?B?VFNjb0VmSkQzMTdGOGtKNjdSd1hGbzhaZVFZeFU5NEpFQ1ZYQnVZaklQczRk?=
 =?utf-8?B?bCtDZjhjblNRN0V6MHJnVDBrZVRLbmR1NFJjZHRsN3Fsa2tkV1k3N2FkRWly?=
 =?utf-8?B?ekcyMEk2WXNheEs5dEdCa1dCeW9BMmY1R2FJZ3pIZVdjck5WWkZEOFNZTy8r?=
 =?utf-8?Q?OzPTkNkh6FNWzZU8Ev/7WgGotCVgDFh/PF/1gNMCL8l/3?=
X-MS-Exchange-AntiSpam-MessageData-1: SCUU2+SRKLiPUg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b16368e4-43ec-4423-e395-08da109c63fb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 09:21:50.7084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HvQXa5PZ+/zdm8elbj9tZ/Dtpnj5RGAr7M5q+g++mF/e4RMNEh9KT8xAG/pncdj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2549
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

Am 26.03.22 um 01:56 schrieb Philip Yang:
> MMU callback update page table set unlocked flag, add callback tlb_cb to
> vm->last_unlocked fence, and pass it back to upper layer to wait for
> page table update done.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 48f326609976..aac1b625194f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -927,7 +927,10 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
>   
>   	r = vm->update_funcs->commit(&params, fence);
>   
> -	if (!unlocked && (!(flags & AMDGPU_PTE_VALID) || params.table_freed)) {
> +	if (!(flags & AMDGPU_PTE_VALID) || params.table_freed) {

Dropping the check for the unlocked flag here seems to be ok.

> +		if (unlocked && fence)
> +			*fence = dma_fence_get(vm->last_unlocked);
> +

But that doesn't seems to make sense, fence should already contain the 
necessary fence object if any.

Regards,
Christian.


>   		tlb_cb->vm = vm;
>   		if (!fence || !*fence ||
>   		    dma_fence_add_callback(*fence, &tlb_cb->cb,


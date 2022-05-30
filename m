Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67207C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 30 May 2022 07:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECBB110E03F;
	Mon, 30 May 2022 07:55:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC47410E03F
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 May 2022 07:55:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8av3NWyI1aGsKRqim3MIZsFIpDbps3CEA7PVnzDU8Wlfh4AdDD9d3OU/Nr+aNtauXAAm0ywsQReRNmfKkRnQo5X7O7gso8o7Qb++hjqDmUxPAwIUodg795+3UX96neS50a2UUobJDHdElO0YmDs5T49NMicvGzFyG//Ck1CTMdJcmX9nwFOpAqru4+/AhwM8cj8Ep3qjtZP9m7xn56RA2XUDd4NunwQKy6SIKEWIX1MoUTZVYDbqg7eSQhIzfLBhjdD+7Mfkj0ozCq+/6TWOFI757nsAuFJVvnvccxxLTsnALzSUQdO3MoUPXc8FvTbmACtHhxrx94o5nIkwWg4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phTHu8y52RBuBPo371OgTVjKcGGdxMbP8lfIKDnWxrc=;
 b=WTyI8xvRzrBuCpjY+3HtUj81YPkvuVEeRO/gCEz1asfU+Eu+X+UpGJ42tmV71ojfbjMXfhT2NB0WXRwcV2IW7Ngm/+oGpiFF6jkNhmBuYp29FQlIgkJKjMMJzgnWXPHHDFfK5OriBoztZFLV4qSDuCcgq3SKBPWMZBwZvjXGLhMHlVswBVWgpxlRo6Wpsxb7lO/UbCDUQfBOTbhajV9MaioxPiU1qEcXvyttGZHdPEtEVnxRy1rKixIEXEgTu77VmOLthhH0eq1XquuFMClBwczfoHmueho1xq8vq0H9RIUlLslRmC/p+6i2+8qYD8VqNkhW9KPW8HaZpLJAlbukhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phTHu8y52RBuBPo371OgTVjKcGGdxMbP8lfIKDnWxrc=;
 b=m1AKUxxJcOunmjr7WbgYpiPsnMzIIiOC+DVyoPRR/YpzNgoHMrM8OAsJw1A8Q+60ifV/qQ0uDr2KTj26LQVZJpxFxbcuQqZnxKqxUxO8LPmcqW3OR3uZ0S944HVlC4337m8XFEBW70FRHP/vhuG19Tuos5dL1xd73jwETTPnHxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH2PR12MB4104.namprd12.prod.outlook.com (2603:10b6:610:a4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 07:55:16 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 07:55:16 +0000
Message-ID: <d2da41d4-1322-95db-04d6-325ba5c65031@amd.com>
Date: Mon, 30 May 2022 09:55:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 6/7] drm/amdgpu: Rename amdgpu_device_gpu_recover_imp
 back to amdgpu_device_gpu_recover
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
 <20220525190447.239867-7-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220525190447.239867-7-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0262.eurprd06.prod.outlook.com
 (2603:10a6:20b:45f::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d295b48b-be6b-49b4-6194-08da4211bc02
X-MS-TrafficTypeDiagnostic: CH2PR12MB4104:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB41043D4A01E8273F08F018CF83DD9@CH2PR12MB4104.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tnhY21PwUfULgR8RicDNUjncsdMm1ADzuDOZvuLZLmGtGcbhVT/ZwxiCrAe0d+MiOViILJwVeg6+PoJeCQ3+yAjc2ihorkue1Iv7ZXv1LAoR5s+GjhPD6GKLTXzPn1JoCwqOCEc9/wwGdNy1LK/M6y6U9wtl7id+pmqVSG4KGocobDO4JN6Uz71AAS17KbrYjOqgWHA/3oTrwmhBBBHP4K5X4XbiZ7X1H3BBrm9sJZpamGeqMGtjVkJPPohoKUzPdDQil+VksyMGU4sNFV6/0iVQeBGa7tVZDgEYvYbQZwymGNkBwMyBpDq4+rSRYYaTzufHl9AlHWyjYa6K36EYtPo0ZuF02+kGuFReoOrTe0+ZLVUc7mv4527IHTdg0qXZ19RH1TlwAfL/bkuZcvSiMu1tTaYAv7xHE9H3PFzjZNoZQ2B19Omunw6lLr8GhkdL9kecZcoYV80dzp7BX8JdsYIVV37O5+T91gAFlvdDdfBofW3HcWipqOiUi7o7eYJsD47BgQkkirVps+8gTcROmGxHlebqb0Yfx9NwIPr5wgG+jDdWlcsphuv/iuBKkZbD/VVlMiVnEXqA+NqE1ifklV3fXMMzYgarhP6z+u8Pv99U/0Haok03iq/8F91Ls5e7obVxirHkcL0JDieUW9x0fma55GLoW0MbiCZCdrwedX3aleAqDnlNLPZoTfjpaAiPVUvRigGUUDUIGDl4+yv1sX8x3xFr6exl0LUf2jYii0s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(5660300002)(66556008)(4326008)(8676002)(66476007)(508600001)(83380400001)(186003)(31696002)(6486002)(8936002)(86362001)(26005)(6512007)(38100700002)(2616005)(6506007)(6666004)(2906002)(36756003)(31686004)(66574015)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2orNVFSblJCOUx6YkhheXVnaEZ0b2pyT3RaRTRkQ0JJZXZ4YUhJVlk2YWpu?=
 =?utf-8?B?OGZMTUs5QUp0dFlwUlAvNlVYTjdlS0dFVzBKYU1IenVNZHo3MksxbStSYTIv?=
 =?utf-8?B?bjNIRVFLRUJiRzN3Z3d5bWpnWTJ4aEpkTitVSUJzb3h5SWN6bjZ2UXkrZTlr?=
 =?utf-8?B?Z3FNYjZ2emFVOU9WSVBQSXd3cEJZc2s0ZnRJekNja0wwaXp1QVI4SmR2bUZD?=
 =?utf-8?B?MVJFNUszVlREWjc3R3pDb2Y3Q3FQeTlKU3E1clZJYkgwUGlwR096OUJuVENa?=
 =?utf-8?B?RzVvVENNOXNycW1FZUZzMXV0VjI5Q2VZRE5JTnFLTCs5TDdTSUd1N0FhZW9Y?=
 =?utf-8?B?NnlqOTJsYU9uenQwb2wwOFNMUlFGWWlUd0o0d3hyZ3kzRFd3eGNIVHZPUll5?=
 =?utf-8?B?d0ZnNzBNeXFTeWRRVjMzTUZ3a0ptbW1RTVkzQUo1R0QzVnZ3eUdWcUljRjFP?=
 =?utf-8?B?Tm95SXhLbXRBclg1d0wrbkNTVlV5eGxTOXFzaUtsTmRORFJITHNiU2wxSGFD?=
 =?utf-8?B?L1ZhOE1BM3V2WlpUemw1NGFLMDlrU0h3QXFibWFpMzhEek1zejk2WnhmQ3Rz?=
 =?utf-8?B?VzJZanBEdFlKRTBDNjgxbDZnM2Fja3pwS3Y3bGZMY09pRWZjK1FYKzVRRVVH?=
 =?utf-8?B?QXNGV2VORUk4ZVZjVFVVMStTZXkxZ3ZyUCtPNXBpNnROT1NjS3JITGhEQ3Iw?=
 =?utf-8?B?dVpHYU9iRnM3MmJHN3E3WklSakpIN1htbmVBZm8xbnlvMDcyK0FvT05wNktZ?=
 =?utf-8?B?ZnF4dThCRmREb0htMFRNMUJIUWxGMkxyNU10TitkcHZpTVBIY3dUUy9RL0xN?=
 =?utf-8?B?TW5GZVVZUjd2N0lEOVVHc0hZcjRBb1BUSDJGejJVaEl3U2V5WVZOaXpDam1V?=
 =?utf-8?B?S3d4NGNZVWF4UUZocDhjeENlL3k5MHkrem9CR3ZmRnF6WWRtS3BDRkhDNlJu?=
 =?utf-8?B?cmVsM29NYTR3MjJGYmgxYWt3bFFNamxKak50K09vK3VCWmI1RHl2VXZ3ejYr?=
 =?utf-8?B?VVd3N1IvbFlXOEV2S28vMlVObUlMMDg2ZThjdEVDa0NDcnhiVEU4TWtGNEZv?=
 =?utf-8?B?OHVtR0pwMXp5ZHBLTkJmdWFjVWpucFhVcHlZcHdyWlRBRi85QXVNNjk0UUg5?=
 =?utf-8?B?M0JKc1BvZjg3ZHhBWk5XWHdWYWo4N1dEeWkzTTFHbGRYZFY4cDYvZ2NpYVBE?=
 =?utf-8?B?TGRHbDZSeXZrY2NZWEhhSGxZYVFTM092UXBwakQyV01xOVFXdGpaVGp0dlhu?=
 =?utf-8?B?SU1qNlpDWUE4NGF4SmVpdE5qNFRJME9nMmJjeko5K1pmajNxTG1PSFdsSkRT?=
 =?utf-8?B?Ym9IY2l6Tys5YzFRTlpZUitHMDIzclV3am9XdTdHK250VngwcG1xY0tlK085?=
 =?utf-8?B?Mk1RbjdqR2lqaERMejIvbndGV0Z6UXRKVVdQOWFCUmYxOVhoRXRCVTZHM3Ew?=
 =?utf-8?B?OXQyMlhSYUxqNzIzdlRUY0FjZlJvRWwwcGVuS3JXeUNMV05Ea3JST2hTT2pP?=
 =?utf-8?B?WE9nQnVsb2ZYalYrcmdkaGNhRmllM1p2Rms3RVJTc1QwTXRhVTk0THM2eGFJ?=
 =?utf-8?B?bVR4Q1AzRFVnTElaK3BpcEpUWHBYYW1EUGdLUVZCMTg4QXIxd2JEM3hYTnRU?=
 =?utf-8?B?bmgxMUd6MG01eTkyMVJEaXdTellrbnpsSGhJNitHOFRCTXpzTmhEZXp5QVpk?=
 =?utf-8?B?Y3JOVTlkTm5yaVMyRDk0QVVtZFdtSmtxS3ZkUFIvYzJXZnp5Sjk2d01qaSt4?=
 =?utf-8?B?TmIxd3Y1N3EwU2JKeFpjNzlibnBlNUIxbW1RdDFjZ09LUTdrekhETDZQbDhQ?=
 =?utf-8?B?WU1Pdm9JSDlLS1N3NGtrcFhzNGR2REQvU1JCbGJyOW1VNzNvYlU0TVhjN2Nl?=
 =?utf-8?B?LzZHanQxc0cvNmFpRlpGMkdEMGJYSGRGYWFleitPekhwZFBBQ3Z3eDRLSUdG?=
 =?utf-8?B?SiszWFVzZWx6b3FxaXBNK01iVGM4TmgxZ3p2UWY3K3hEZ3RBbVlBb3oxQWtB?=
 =?utf-8?B?MTQvR01lL09TZytkUFdXa2tiTVVGZy9BYjIrb1d0V2JRbXl1L1drMU9WWDlN?=
 =?utf-8?B?TnFFRVdQbUFXNUdDR3pWeW4zVTlOVW1HZ0tnOVBkT2krR2xjT0lpWVhVbVFx?=
 =?utf-8?B?bE0vemtNdlVORjNBaU1aQyswbndXZ3dmK1JRZDZETGRManZXelVkZnNoamYw?=
 =?utf-8?B?b2pTY3ZJcTJYYWZRMU84TjhtUS9seE5UbzJWUUllZ2VydmR3ZGs1L0JMeitD?=
 =?utf-8?B?Q1ZhVElnN25uTmtIbks3cDlVVlYvbVlydDI2WWljUXFXdmQrYmlQWlROSFRq?=
 =?utf-8?B?WHRYT1F3NWJPZmVyNUlCdThhc0FlM1U2ekhRbTNZSXFLN0ZoamNZZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d295b48b-be6b-49b4-6194-08da4211bc02
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 07:55:16.4683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezhn0WzaRTKXT67F8qr0XWdd9ETNtARULlcLVEI+A8p+xhyPT87WKjbwqBeHhPec
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104
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
Cc: Zoy.Bai@amd.com, lijo.lazar@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 25.05.22 um 21:04 schrieb Andrey Grodzovsky:
> We removed the wrapper that was queueing the recover function
> into reset domain queue who was using this name.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 2 +-
>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      | 2 +-
>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 2 +-
>   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      | 2 +-
>   9 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 8165ee5b0457..664ed0a6deab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1244,7 +1244,7 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
>   bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev);
>   int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   			      struct amdgpu_job* job);
> -int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
> +int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   			      struct amdgpu_job *job);
>   void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
>   int amdgpu_device_pci_reset(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index a23abc0e86e7..513c57f839d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -129,7 +129,7 @@ static void amdgpu_amdkfd_reset_work(struct work_struct *work)
>   	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
>   						  kfd.reset_work);
>   
> -	amdgpu_device_gpu_recover_imp(adev, NULL);
> +	amdgpu_device_gpu_recover(adev, NULL);
>   }
>   
>   void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e3e2a5d17cc2..424571e46cf5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5065,7 +5065,7 @@ static void amdgpu_device_recheck_guilty_jobs(
>    * Returns 0 for success or an error on failure.
>    */
>   
> -int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
> +int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   			      struct amdgpu_job *job)
>   {
>   	struct list_head device_list, *device_list_handle =  NULL;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index b0498ffcf7c3..957437a5558c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -819,7 +819,7 @@ static void amdgpu_debugfs_reset_work(struct work_struct *work)
>   	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
>   						  reset_work);
>   
> -	amdgpu_device_gpu_recover_imp(adev, NULL);
> +	amdgpu_device_gpu_recover(adev, NULL);
>   }
>   
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index dfe7f2b8f0aa..10aa073600d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -64,7 +64,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>   		  ti.process_name, ti.tgid, ti.task_name, ti.pid);
>   
>   	if (amdgpu_device_should_recover_gpu(ring->adev)) {
> -		r = amdgpu_device_gpu_recover_imp(ring->adev, job);
> +		r = amdgpu_device_gpu_recover(ring->adev, job);
>   		if (r)
>   			DRM_ERROR("GPU Recovery Failed: %d\n", r);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index a439c04223b5..bc0049308207 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1922,7 +1922,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
>   	}
>   
>   	if (amdgpu_device_should_recover_gpu(ras->adev))
> -		amdgpu_device_gpu_recover_imp(ras->adev, NULL);
> +		amdgpu_device_gpu_recover(ras->adev, NULL);
>   	atomic_set(&ras->in_recovery, 0);
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> index b81acf59870c..7ec5b5cf4bb9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -284,7 +284,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
>   	if (amdgpu_device_should_recover_gpu(adev)
>   		&& (!amdgpu_device_has_job_running(adev) ||
>   		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT))
> -		amdgpu_device_gpu_recover_imp(adev, NULL);
> +		amdgpu_device_gpu_recover(adev, NULL);
>   }
>   
>   static int xgpu_ai_set_mailbox_rcv_irq(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index 22c10b97ea81..e18b75c8fde6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -311,7 +311,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
>   		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
>   		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
>   		adev->video_timeout == MAX_SCHEDULE_TIMEOUT))
> -		amdgpu_device_gpu_recover_imp(adev, NULL);
> +		amdgpu_device_gpu_recover(adev, NULL);
>   }
>   
>   static int xgpu_nv_set_mailbox_rcv_irq(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> index 7b63d30b9b79..c5016a926331 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> @@ -523,7 +523,7 @@ static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
>   
>   	/* Trigger recovery due to world switch failure */
>   	if (amdgpu_device_should_recover_gpu(adev))
> -		amdgpu_device_gpu_recover_imp(adev, NULL);
> +		amdgpu_device_gpu_recover(adev, NULL);
>   }
>   
>   static int xgpu_vi_set_mailbox_rcv_irq(struct amdgpu_device *adev,


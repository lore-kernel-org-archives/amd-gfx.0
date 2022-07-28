Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63212C19F2B
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Jul 2022 02:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AC1310F5D3;
	Thu, 28 Jul 2022 02:45:36 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E10AF10F0C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Jul 2022 02:45:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1tmo8j+ArXA4gUumb+PA++EoLaQ74FLR2x26r9EKbxTw2t3Bn2S+oultWGWnyLEcwyOV9XvJdiZykoPzdNLiWud9tEJAIINjL8UI7h6nuKWTZZfS1zwBI9Ywli+NIOdh1Nj7nFyP5kwrlLSiPQ2wwu9OhyQFKi0ljBE1THTFyUwNQ+yo1VDWSPlFDHzpoUIOg6quQ/qjGInvb0/BNqvGQhmlPejutpfygkB4MGie0DimEcx/fA6ueXZ1xzETzyBMFuLY1Zvx5xtx6dtC9Wvdm7pmSN+Y/HpmAoodn9AtkRNxodNcRIQgUeY3c5jnuPuOIgIFH0CnOCdzWH1C5Kq0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZpWBpyj/MmhVJd+w/zPyISRNEfH59czsRqfRXsluUY=;
 b=NKz+Hh9G0NBYB2SYsxTR0faHsya1k9q8aSYtHs4m/C1JYaE/SaKTKY3OmE7fKt/y9VGmOyNlxFxBMe6oIWPmB/SPH4FMg/D45YAyE9Jhn8LrBm3sPmaxeVLA5fcjwoDTkC8ZwrCVdSDxIAaKOD8/TSxWYoVDSLijwJad8KBFBhEFTVNS4L29wxI267Qy30PTTBtiz64lampHtQTFEumo0Inww3dfZ5WRz/+tJqY5CC8zdpk2fuWeTu+I+KnpmhtRqo1s71Xoz8bXt94RnJ+aFvkhyfzXOVQ/uYOmSxgHR5bWAA0GmJTujen1iMfVWmJpHGm3A2KPQDb/tduHzOPdww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZpWBpyj/MmhVJd+w/zPyISRNEfH59czsRqfRXsluUY=;
 b=OhPjOsWGlRBLRDdusOWH4fiSX2bvjCDXDVrRLj1UtSqffMhDp8mxUQ6uaeWopIo/mIuwyIApf8gYb3FLmWoBPAiCX3oYsBC3n1CtnhKZxAvCq7wM04cfDWl1nwV7kuXKGd2h13vQtPQXJfZk429au8WM5Kocz0zGDQxqquo2XDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN8PR12MB3140.namprd12.prod.outlook.com (2603:10b6:408:67::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.21; Thu, 28 Jul
 2022 02:45:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%5]) with mapi id 15.20.5458.025; Thu, 28 Jul 2022
 02:45:29 +0000
Message-ID: <600f400e-3662-9df1-52b9-8fd0160882da@amd.com>
Date: Wed, 27 Jul 2022 22:45:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] drm/amdkfd: remove an unnecessary amdgpu_bo_ref
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220725103205.2085630-1-Lang.Yu@amd.com>
 <20220725103205.2085630-3-Lang.Yu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220725103205.2085630-3-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::18) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dde8734-9eba-4179-5f4e-08da70433bea
X-MS-TrafficTypeDiagnostic: BN8PR12MB3140:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MqWtELSnBclIdD3SHN5FGDeqfQ12/l5oNzshRQ/tJ8qIh+Im86wflUa0CwkWUG/dgLnpvS0skiRY7vLXmUxt0R/QChurMeriH7bHM6Oyx3tDRHZfeeABeCOlJJiCH5IH5++7dhmI+jSE+0W+t+5dKeLYCUHqZrZB13WD5LdCfi40OXZDj7fO5dPcUuqOpl5ljOOQ484O9xbu7GgPL3CVuA8KmgE3aVj63sYf/dG1Z+N67SMDg5yMgqBA3asng3DriGdCyd2+eUMYZcJnjh7E+tWBP+hzKsjmnyhwsVndHl+qhVoMS+2o6290X3SUEJYZ4kUsj8deYnqRuSR+2E4lvXkGV3TuJBo0UkA8Z7UfPmR0/yRnPlF4hO1twWEnmEvWX6bHKthRZvcFr5TUP2jszLkZX4vxzG4vnt3XmHnw6MHPSbRevo0ApEGpHsC3KEBB9HrE554EHHxmUxS7oIniNR19z6rWeHoGXw3nXf4+1cvkcp3s3wOsGcxQpl0Njxm7tCvUsZCTKiXBQIt07kUnmosW+RVv/eM/hxpW2rGIfNEfPKSS85BRTaP5su0dr2FcvGxUv6zkhfZXm+SOaxs90kZQNIgLHlq4SR+O4tEp8fqxQ49vlmF4gZ/h2lGEIkMH9KyrzPqU7vsPQ8+WO8jYDCEOdlFtUSM7p98Zy8MEY5ExQ4fggoeXkdaDlGVTlPMzioYn93mfM+rYmZSmyTI099BY0th+9gYGl0xs7BjqfwzSJPK7kKvn9F9Uj5oHCyLpGjNmJryP2qd7ldOeM3Rjb/Lj4PomLskc9Fu9cqcI82B87DKcK/FNBqJkhYCLFiuPOxmcpNfCnlqiZITfKS5VSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(66946007)(66556008)(66476007)(8676002)(8936002)(38100700002)(6512007)(4326008)(54906003)(26005)(41300700001)(478600001)(6506007)(6486002)(316002)(4744005)(86362001)(186003)(2616005)(31696002)(31686004)(36756003)(44832011)(5660300002)(83380400001)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VThOcXZxb1p1V2tJTTFxbWpLQXRnTVpDdVBuYUl0ZGY0U0lldWxWdmRtQzVB?=
 =?utf-8?B?ZUtEU3VzY3d3ZzVoRjYyMDB5eTNvbTB4OVJDTmFwaDkrdVEySVBXL0FISzNK?=
 =?utf-8?B?TmhhOHBNRWZmMXhEdkhPUDBDamhHdjYvZkVPc3FuZnA0NHVCZkZyQXVZMEha?=
 =?utf-8?B?QUUzcmJrbHZvQXp4NU5hZllHL2VHeW5sUXVmRGduQUlYcWFSZm1TWFZzZ1hQ?=
 =?utf-8?B?ZGJvMjY0TStsNkMwRVlPWmw5REk1RjlFbEFDRTVaem90YkFlbEJQVFlMaERs?=
 =?utf-8?B?azR4RS9tQ0JzSUpzNTVjY3g2bEdGaTJCVDhReWo3di9iZGxkS3RqUmN3bUwv?=
 =?utf-8?B?dEQ0eStKTEZPeU1Qa2tyU1FTNEZBMmhCR2FkeWt2cDFva0Qwb1lueldyajRK?=
 =?utf-8?B?dVlqRlhucy9xM1dDVlF6Zld4QS9OWDZSVWFmTUY2Z0lGbFo0cktMU3dNYWpY?=
 =?utf-8?B?b3VyYktJWWtNVy82bGpCc1FDZTdxMWk2VlgxVUMzQWxSU2FZUEprcWNXTGcz?=
 =?utf-8?B?cWpGNWd3SVpMelZIUlYwUHZld2EvZUhXbHBYMjRzbmVhb1MvaXNsOGJjNVVu?=
 =?utf-8?B?bXB1T2ZFSkdOb0JMaVhTNVZCY2xZUmdXL1FldVkxZXlqT3FyaXdhUHA1TEpx?=
 =?utf-8?B?Wjgrb09qQUtONzdGWjVPWHFtZFBLMmlsM3ZYWnVuQ3c5bjJwWVJLUC83bjEv?=
 =?utf-8?B?SmFCeld5ZnB2SW9HamlqSjF1WWZBQWlGRy9yaWRjWjRrVGRjODI1T2ZvczRJ?=
 =?utf-8?B?T1JCZmdUT214Z2o0MnUxWUIwNEhaSW5NNU5DdktOQjFPQm8reisrNlREVGZR?=
 =?utf-8?B?UFMvaXk1blpuWlhxNlZwMFhodWtLb29FandrRGVhNVNmQmNXTUJQSjJhYVRZ?=
 =?utf-8?B?YkEzUkh0WEtlYW9GS0V0L0N3Ti9KNGtBT0M4R3BqVmFORUNUU2w3T0RlWUF0?=
 =?utf-8?B?YUpBNlBwR3VZaEJSQkFSSEI3T0duVVIwRDdYSUc5U0hYOXRtTUNTSFFpa3Jr?=
 =?utf-8?B?Zk5KSEp1elNiSThNQlZUMTVjd1FDQ09wNHhOeXBiUWkxb3hiTjJoTlF0cnhv?=
 =?utf-8?B?UTY5UllkSU9jRU5VdFBMTGU2QUZnaXdmWjhrQVVEc3ZPSVNGMjBrVWdsUU1J?=
 =?utf-8?B?bzAveVVLcyswM01xQ2xqNEp2aEJaazJSejdjY3ZqS0tFbXkxdFRRWlRmZjFl?=
 =?utf-8?B?RTZRUDdXRG5hZUlYVmJIN3dhd2hTemlMNnlrRzRaeVNpdFFRVHZSNExLTDU5?=
 =?utf-8?B?ZEwzbmJJY0JIZG8rSnFHb1lVVmlkL1JZNEZRZ2pvMS9WV3VEdkpHRVRsOVBn?=
 =?utf-8?B?cGpqZ1Z1RG4ydE1Wb3I3b21iMU9xd3RvUzRzUG9vUER2SWs3dVdUb3lkT2FM?=
 =?utf-8?B?WW8xQzJKS1RHKy94S0RMc0Z1WVhleGtnOUwvSkw0RCsyNCtPRm9zOU84dlJ1?=
 =?utf-8?B?NzhtYisyeFNVYzhDbnJBRXJMZUVKOCszZkc0YW1VNTQ4aHJydWNrUk9IU0Ex?=
 =?utf-8?B?dFAvVktaeDA4eU9GNEN6SWFRb1JrcXZiOXA1amJZMHFCTStDMWNGeWs2WENL?=
 =?utf-8?B?WTNtdG1LOUVxNmJnS3Bmbzk4SnhWWC9lQmdQMUo5TmxoWCtyOURGc0dwb2Iw?=
 =?utf-8?B?cnJVUzk5NGczbHJpenB2YzRoMUpCamxEUVVWNktrekhCVEpURUJjTmRzeVJ1?=
 =?utf-8?B?b2NUVTdZeTlIdkcybjBOUFNTaklmaEd1b2V6YlpyTkNoNjRIbjM5RXcyaVJs?=
 =?utf-8?B?ZWNaT2N3Z0VpdnZLZmQ2TENnWnc3NnJjR0JiM2Zaa29zam5pVXdXVUpxd21o?=
 =?utf-8?B?M05wWlp5dkY2Zkd6cGNSWHBLMm91dzZBNGRyemhFU0xua1loaVd0UzZkVTRO?=
 =?utf-8?B?TnhGUDRXWUJHMWk2TFFvZnVJZlIwaHJhK2pvTjc3S3ZmVENUSWNVdS94R3pV?=
 =?utf-8?B?bDZFa0piZCtvNnpydnhCWGtGb3pxS3lRUEdsWFdScEx5WVhzL3FFeUc0ajZT?=
 =?utf-8?B?T3pZNlBDTndtMDdzcUs4dVo1a2s1UkpmbmJmdFp0YkZFMUlKOTB5aHA1T2JU?=
 =?utf-8?B?eWdKd3AxanlVeFFjYUZkcUVQZ21Idy8rRGphMTNKcGZrUmM0SkpqWGQ2U2JS?=
 =?utf-8?Q?RTdpm/+b9EjPgFe1dipWzeqez?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dde8734-9eba-4179-5f4e-08da70433bea
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 02:45:29.8244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRxvT/DiDlaTVpytVwfxP15TFvi0MCETlia0ykFD4KechhqCC2UpADRuXdf1rcmnV7ACRagttWJb5BieupHWQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3140
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-07-25 um 06:32 schrieb Lang Yu:
> No need to reference the BO here, dmabuf framework will handle that.

OK. I guess I needed to do that manually for the userptr attachment, and 
copy/pasted it unnecessarily for the dmabuf attachment.

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index c1855b72a3f0..802c762108b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -827,7 +827,6 @@ kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
>   
>   	*bo = gem_to_amdgpu_bo(gobj);
>   	(*bo)->flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;
> -	(*bo)->parent = amdgpu_bo_ref(mem->bo);
>   
>   	return 0;
>   }

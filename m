Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730B8C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 18:03:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A8B010E665;
	Thu, 17 Nov 2022 18:03:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD13610E665
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 18:03:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FV+Z0aszkP+gXVAOFuPdKpCchUXbvhNCRfVivJ48qSQh8QfLcSrrOflJzuDGLZEq2U7epQdAgGVP5a4wSYFEMYwmgIhkjtIWQNV3oUnsza7aYwzFqb0vN32oisPIK0Lh4rCi7rdgalhg7gmoWo3kxvxxg+SRfSZA0THKw8ZlcbC4f8Vb51a1/T6XXA4Pnmc1W76xMjf+bXKqxWkb2kK3EjU+jaC/lsMcM0PF6DLN//adxvj4km8dr8x57lvh4UsH1XtuW7CQVyJQ4j67GobU0qkRVxzX8upuG8B+d40ZCAADvCDzBXiWfM2J9aeTeTpHz7pxEAKt+FDUrIQm2RvJ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2sbgMki+JFoOlZyEWfVME1k5yeF3i84mgqJoKJjPnk=;
 b=Xauf3x/S9hOfk5cvr/XDqCApEr0D756GB1vTtSMLvci/ccc+Ov3YCEqECEwGqc1HBgXwWZt57l7mdnu70HS87EYtHnzqtgF4TVrKxt/ttebePMZLXICsERs08X74iI8QNl/0LYIs4bJ0larkBkRNXbJ4XzSO+bZ0SFCVFt2R1bBgputc+lWesm1TnRbV5jIs+t+E18MkKM1/j9vcJ74XUt1Az7c/PgOnlMPxPzRi78TQOrSQLlO6wl1+xHr7DPfZXbaMCcrLf+qSCItl/nWXUZAwjtwx+O2iGam8nKwRbwupOOC+Xj5PvPmumTv8hMB5uQ4UmUneuchiwyq5RrD7zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2sbgMki+JFoOlZyEWfVME1k5yeF3i84mgqJoKJjPnk=;
 b=5pCUxfB2BGR0u+tkiCZPGDohd4l7h9fty0nQqtVMRVAUtOU8rCYPRHS5Ho1CHQdvf7GZ2G85I+LVJns9z0ztNsqZ7k2D0uokhdfwpzmVOjzozV0wYuKglOq+sfaNGKOEL2dqs198dEh5doHefdzfI2V2a2b3PnEr08VzWHbHfcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 18:02:56 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5813.018; Thu, 17 Nov 2022
 18:02:56 +0000
Message-ID: <61ae3895-986c-444e-6c1d-bc792d34a73f@amd.com>
Date: Thu, 17 Nov 2022 13:02:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdkfd: Release the topology_lock in error case
Content-Language: en-US
To: "Ma, Jun" <majun@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20221116080415.593223-1-Jun.Ma2@amd.com>
 <13c82533-6cb1-2bcb-405c-f81123807fcb@amd.com>
 <90dae711-8786-fc6d-9834-59e201b22620@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <90dae711-8786-fc6d-9834-59e201b22620@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0288.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH8PR12MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 921b9eb0-7656-437a-1cdd-08dac8c5f4a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6AaW8w6QJmtzmiW8UVXSdkH3sYkWg9Ot4YmrbiYbYNnHriKClZiJqtI6Ce21gNmB1kYhjnsoKPP00UsXx3JS1SjXWs5EuympqLeIGR9m8R1igkJx/2Y3Iy6UQlFnb8kWjv+07oLoUx/5NFszVxsg2rMtP6ShOoIjjmIzvyuaYxcFCEHN3AvKPlPNiRAP0LXqjF3NVSCYC0t1UTjFST85PuZRNSS8SkpX93/UBZogb6UsNKGhn626Tc8mixxyu+VMyOwxuTkqqcaAjG3xUeLXr2oWYNQrPQOd29KeaXcRAtPcsYNpFiMjyLAvKqToxHmbmcy2MUM9uRpvopjxMvZ05Gafhbafsjor96dNp2o/0K9iQdfZfXL7+ziCCBjADUru+8tS9m9LBnIBo6/h1yZAIjitKGU5M0phiyYeEJdf6l21BON/Q4Bxli1uX8vbTHlK8kk9sDPRLPCUPi9s6lHOLuGf+hFs5EygwI8k640Cib6KA9hrrXh5UhDs4PkIslEULqjtDna/oEVfD+4IdFnBYjMBb6HDq4pGWaWckL1v5HyDtMnVjSmeMJZypyplmZ6l4Z41Q7XoFGqEDza/ivsTlYDJHMq+D0BaIsnOVb0L6UK8fjYfXBXWVSzyTXVHZqEz22NooinyIs+cV3J2AaDQGgHo0CULNrIOdb5fYooHczR6mKLU7Eoyz66W/PhjYi4gU2IdxGbDE+kV/yo2lbYjIslt+ADpchHSwElnBYObDqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199015)(5660300002)(2616005)(36756003)(8936002)(4001150100001)(2906002)(44832011)(41300700001)(186003)(316002)(66946007)(8676002)(4326008)(26005)(66476007)(6512007)(38100700002)(66556008)(83380400001)(86362001)(31686004)(6486002)(478600001)(6506007)(31696002)(53546011)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXBIUEJsQkZCODNuSGlLeTE2cnc3ZzdLbXorMFh2WHVBMU1janF2aE10cEpW?=
 =?utf-8?B?ejduT3dRKytsYzBIYzZIKzhKRXJPeTh1d2Fobmtrek5vc0p3UVQxY3NTL1Mw?=
 =?utf-8?B?eUdGa0FXdWtlVk8xazN0d3hCUXJ5WVRtWkR3SFkrWE03Q2E2cnFkRWp4VHE0?=
 =?utf-8?B?TG1NZ0lsek9kcXBSUFVsVjdOMGQ0blBwbVFrZjF4aHdPbGFTM3FhWGNlNHll?=
 =?utf-8?B?R3I5ZHc5VmJqU2NKdExTM1JRVXNDL1pIR2gvRytMUTRYY1hOVXREOG5KNk1R?=
 =?utf-8?B?KzdnVzk0RC9GVlh4d2NuaGhzRXVQdTB0QmJjMmpOb2xvQjN5YVJhL3p5WnlO?=
 =?utf-8?B?UklFNXZTR0lXL0JPaXlEdXZpMlUwWjUwK2V5NXdpamNFeGFmOTRhYUplaEVW?=
 =?utf-8?B?Y0lncGJXdDdLRWR4TW5sWGJZTkZUVi9IckNxSDNTSGlpYnh1aFkxeE5RaU1t?=
 =?utf-8?B?UnJ2Yk1KRW9IKy8yaGhacTFIZ1Y0Skg1VTFHT1FkdXZQTE1oVkptZ3h2WndF?=
 =?utf-8?B?RzNaYitNcEQrMmdPQ1dzaFEwMkdKSlpob29NNTZ5RnZNRFk2ZTFiaTFqa3M2?=
 =?utf-8?B?UkMwc1NORTF1dUFFUU1TRkdVY1A1N1BGL2JxZlJEQlpWMmplaXRwSS9QSGR6?=
 =?utf-8?B?RUhmQ0pONTVKZmF5eUlsR2FlT0s1UXpFT20xK0FmMXZuRHBydU9tZTJuVzI5?=
 =?utf-8?B?MUs2Slhqakw0aFlDS1lheUhoT3FiUWdDRmtJL0V6ZTNWN2lzd1BTREZHajBW?=
 =?utf-8?B?ZldqK3c5UXhKY0d2MkJlbnBRU1Fpem5PR3NBbkh2ci9TN0VBamJ1Wm9zdEx0?=
 =?utf-8?B?d09haks3NFUrR05lbVlpS1hxQTdBNjVXQ2JvVWtRZ2ZBQjh2Y3pmT1BRN0FO?=
 =?utf-8?B?YUJrSlNkZUZqbVpncGtIRldkQUhwZEpDa0E0cElwUUJIQVNqZVBTT3RML3pn?=
 =?utf-8?B?aU1zQWJYTE1PZVY3emZGYXkrVktyVVZiblAzSldzbjZEczBETGVsa2VPK1l1?=
 =?utf-8?B?cXg5b2xKL3RtM3VJK3EwTE1EeWM4aTJHWElaaVEwNzRXTHFPNGlrUmRnSDZG?=
 =?utf-8?B?K09NRGE2d1ZXT2ZuOXNIZzZuRERwQjNEOUZjQnNEZENtT0kwVi9xUGJHcnlX?=
 =?utf-8?B?RnVlcUZheGpmQlYwZlZJSmFNYitxSDNzSEZOb2x4UlFXRnc0WlYrOG1OMXFX?=
 =?utf-8?B?MVJMa2tySTl1RnpNTGRWck4yUG5jcmVGejBOb2g5dGJ2TVpTbnhHVVY2bmZl?=
 =?utf-8?B?cVVrNlNYYUlRN2VhdjFpY0p5bUdkVU5vdEhXZFRqNVZOV3pxWUpjL2hwdWlp?=
 =?utf-8?B?WkdSa0szVkszWklRV0ljOEpiOVBKUnErMjFIeVR2RGlGYVNEVUplY1UraEds?=
 =?utf-8?B?Yk5aR1NaNU5VS2Nkd0xlVFZWeXY1QkdrYmpyaTVPY2s3Zk1IUXNnTWM0aENx?=
 =?utf-8?B?ZFdxWXBmNjJnaWU1aG15NkhQVHFhcWc3K3FEY3hWdW9PeEpGajVENFFBbUU5?=
 =?utf-8?B?MEJ5VmJMZy9BWkpFcDBDU0doQURBcWtEVnB4R0VibE9DUlRLTzhFQnhqYVcw?=
 =?utf-8?B?TStPcE8yS3hGZWlwM3YzaWQ0WGgvV2g3cHMwOHZZQi9sTDJ6QWZ2R3kvMllV?=
 =?utf-8?B?eVhtY1FUWU42R21xR3oyWEdwMXpXVnhVU003c1B2OWV1am9YQ1BVMGhua3lo?=
 =?utf-8?B?WisxbXlnYnRDdjgxYXhZUlEza2dCVUtvVFpFQ3JwcU93R29DS0VmU2RIcnJH?=
 =?utf-8?B?WWhNREY3b09oK1NKckJ0NVo3Qk9KTldmSzU0UWhodTRVOTRjZEJ1Tkw2TXRp?=
 =?utf-8?B?Y2RFcEVQL2FTTWFGS1RpY3NxdXhkOHljdlJ0QjhRb2lrZEVvL1VhRWlHWUg2?=
 =?utf-8?B?MXRrZkFBMGVmS2NFVlp2NVdHSkxZWGROSmRpZlZ6SThaeEgyNjQvS0FhVEIz?=
 =?utf-8?B?Rkl3WTV2bnB4RmpTTkN0aEFqRFdVbDJSS3VkUjlUcHpJVHpLQnlHMEVVcHRa?=
 =?utf-8?B?emY1bWgrMDlOQko3Nk55azJXbWd6cnRXQ0NBaWtaVG5kZ1loNUhlc29FSGI3?=
 =?utf-8?B?TU1mdGJ0WGswQkhER3FPMTU4aGxVUVBYaU5jTjZubkJTYjFqTkdQdklpQWNq?=
 =?utf-8?Q?TZRKnRqU9zaahTcw5OWhGFslt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921b9eb0-7656-437a-1cdd-08dac8c5f4a0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 18:02:56.7249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZy0yBMG6rJnZMMz5JkcdWiWy3lUvfyDmkubYxeKjwA9WTF6UWA9sQvu7hsQfRk+5tWzma0g4uAna0D3AGt/fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6674
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
Cc: error27@gmail.com, guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Looks good. Feel free to send the revised patch to amd-gfx. I'll review it.

Thanks,
   Felix


Am 2022-11-17 um 02:33 schrieb Ma, Jun:
> Hi Felix,
>
> I just tested your patch. It works fine on my test set with the following little fix.
>
> Regards,
> Ma Jun
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 7ea3ec1e9e75..7d6fbfbfeb79 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1954,9 +1954,11 @@ static int kfd_topology_add_device_locked(struct kfd_dev *gpu, uint32_t gpu_id,
>                  pr_err("Error creating VCRAT for GPU (ID: 0x%x)\n",
>                         gpu_id);
>                  topology_crat_proximity_domain--;
> -               return res;
> +               goto err;
>          }
>   
> +       INIT_LIST_HEAD(&temp_topology_device_list);
> +
>          res = kfd_parse_crat_table(crat_image,
>                                     &temp_topology_device_list,
>                                     proximity_domain);
> @@ -1964,15 +1966,17 @@ static int kfd_topology_add_device_locked(struct kfd_dev *gpu, uint32_t gpu_id,
>                  pr_err("Error parsing VCRAT for GPU (ID: 0x%x)\n",
>                         gpu_id);
>                  topology_crat_proximity_domain--;
> -               return res;
> +               goto err;
>          }
>   
>          kfd_topology_update_device_list(&temp_topology_device_list,
>                                          &topology_device_list);
>   
>          *dev = kfd_assign_gpu(gpu);
> -       if (WARN_ON(!*dev))
> -               return -ENODEV;
> +       if (WARN_ON(!*dev)) {
> +               res = -ENODEV;
> +               goto err;
> +       }
>   
>          /* Fill the cache affinity information here for the GPUs
>           * using VCRAT
> @@ -1989,6 +1993,8 @@ static int kfd_topology_add_device_locked(struct kfd_dev *gpu, uint32_t gpu_id,
>                  pr_err("Failed to update GPU (ID: 0x%x) to sysfs topology. res=%d\n",
>                         gpu_id, res);
>   
> +err:
> +       kfd_destroy_crat_image(crat_image);
>          return res;
>   }
>   
> @@ -2001,8 +2007,6 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>          int i;
>          const char *asic_name = amdgpu_asic_name[gpu->adev->asic_type];
>   
> -       INIT_LIST_HEAD(&temp_topology_device_list);
> -
>          gpu_id = kfd_generate_gpu_id(gpu);
>          pr_debug("Adding new GPU (ID: 0x%x) to topology\n", gpu_id);
>   
> @@ -2018,7 +2022,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>                  res = kfd_topology_add_device_locked(gpu, gpu_id, &dev);
>          up_write(&topology_lock);
>          if (res)
> -               goto err;
> +               return res;
>   
>          dev->gpu_id = gpu_id;
>          gpu->id = gpu_id;
> @@ -2141,8 +2145,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>   
>          if (!res)
>                  kfd_notify_gpu_change(gpu_id, 1);
> -err:
> -       kfd_destroy_crat_image(crat_image);
> +
>          return res;
>   }
>
>
>
> On 11/17/2022 4:49 AM, Felix Kuehling wrote:
>> Am 2022-11-16 um 03:04 schrieb Ma Jun:
>>> Release the topology_lock in error case
>>>
>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>> Reported-by: Dan Carpenter <error27@gmail.com>
>> Dan, did you change your email address, is this one correct?
>>
>> Ma Jun, thanks for looking into this. Some of this problem predates your
>> patch that was flagged by Dan. I would prefer a more consistent and
>> robust handling of these error cases. I think everything inside the
>> topology lock could be moved into another function to simplify the error
>> handling. I'm attaching a completely untested patch to illustrate the idea.
>>
>> Regards,
>>     Felix
>>
>>
>>> ---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 +++
>>>    1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> index ef9c6fdfb88d..5ea737337658 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>>> @@ -1841,6 +1841,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>>>    			pr_err("Error creating VCRAT for GPU (ID: 0x%x)\n",
>>>    			       gpu_id);
>>>    			topology_crat_proximity_domain--;
>>> +			up_write(&topology_lock);
>>>    			return res;
>>>    		}
>>>    
>>> @@ -1851,6 +1852,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>>>    			pr_err("Error parsing VCRAT for GPU (ID: 0x%x)\n",
>>>    			       gpu_id);
>>>    			topology_crat_proximity_domain--;
>>> +			up_write(&topology_lock);
>>>    			goto err;
>>>    		}
>>>    
>>> @@ -1860,6 +1862,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
>>>    		dev = kfd_assign_gpu(gpu);
>>>    		if (WARN_ON(!dev)) {
>>>    			res = -ENODEV;
>>> +			up_write(&topology_lock);
>>>    			goto err;
>>>    		}
>>>    

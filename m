Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73956C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 10:03:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E77CD10E405;
	Mon, 17 Jan 2022 10:03:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E9FE10E412
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 10:03:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQCJqCIKJViLI6R6H/8o/H6OieQGZn7DTiSupRdI2TfEEi9H6uM1PckeGFLt4CCRv8YJUSlLLOfNesf8L4QS+CcTSCJuHJ3hjy53xoJkrXCEf/YuD6jhqZLJBGcV5HO0AZX8wUcV/g+waE2UrS1L1LOedTtfflK7mP7LTu817ac9RAYnl8SzWzky+Yid7SY/Oc+cMfpl79LXotVyTO0WiIi0t3jPrCJxryp1ECuviEZI7Otbuic50W126oDZ+Rs+KU0H+GxOOtho7i3qaTNT8xlWGV/lgUzWOeGQSJqFQD2YQlM51+4SXtairhI8oTLA4scBi0PEt1EKwKDzBJDplQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UyHfoeGKx8gW6g4DBcoKYLJ5dX3igBYzJt+8jJKj/E=;
 b=AolMy0pM2uIp+D79gH9zzQzb3PNGijjgki6bz88DlQGzg0iHXbWu2LGJ3Baxt5Qp1qJetI5R28I5BZeFwTp0M93W2RkioN5uToEZAbO9ZoUCa+A3Cz47VFKD7n0Xr3GmrHXwUpnt0ABSvnhkXGNhuVjqmijck8N6PxJPPrWmwjqI9dX5a5Lbx05OUzt8oE7F7DON4JJ7srKVJHrAXHpf9WIvXCESnNrW3CkYEaaurqaEen1RMHSPJW5CoPIet50QhJPdOxfbqwMdchU2wzHd4WTKOG7E6IvI95UxNTj7CVWE0UdK16X1ubNSB8tafWVvGi9m2ruNPV2OnQEj89kT/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UyHfoeGKx8gW6g4DBcoKYLJ5dX3igBYzJt+8jJKj/E=;
 b=dJXO6QtLr/adsMzgRQMnJBK4DyTThDLIipEN2Igzh0AiM4zD/wP5HoIswwqkrsGsycgsPBeSg8LonRnrDHUgg4z2732ogCRh2wBl7aSgKviOTuw9FvSSv4HbvfbtuuC7cWZBzZcOaB+HWWALByKIfILHC2ae5cnPW654rIxp6hA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0187.namprd12.prod.outlook.com (2603:10b6:4:5b::9)
 by BN6PR12MB1683.namprd12.prod.outlook.com (2603:10b6:405:3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Mon, 17 Jan
 2022 10:03:09 +0000
Received: from DM5PR1201MB0187.namprd12.prod.outlook.com
 ([fe80::7597:2d5e:826e:7ded]) by DM5PR1201MB0187.namprd12.prod.outlook.com
 ([fe80::7597:2d5e:826e:7ded%11]) with mapi id 15.20.4888.013; Mon, 17 Jan
 2022 10:03:09 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPURESET uevent on AMD GPU reset
To: "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220117063343.27896-1-Amaranath.Somalapuram@amd.com>
 <12d7152f-3274-a250-e25e-6144cc9cc1e2@amd.com>
 <DM6PR12MB3897D77C82314BBBDBE8AF93F8579@DM6PR12MB3897.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5568c4e1-7bc5-cd7f-d6d7-92a4f920c40c@amd.com>
Date: Mon, 17 Jan 2022 11:03:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <DM6PR12MB3897D77C82314BBBDBE8AF93F8579@DM6PR12MB3897.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR05CA0007.eurprd05.prod.outlook.com (2603:10a6:205::20)
 To DM5PR1201MB0187.namprd12.prod.outlook.com
 (2603:10b6:4:5b::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99b1bfd6-ad89-4e2c-4b6d-08d9d9a09099
X-MS-TrafficTypeDiagnostic: BN6PR12MB1683:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB168331BF4577B1DF8AEDD9D883579@BN6PR12MB1683.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12TV7tGVGZdSH2e49rUxGDvY1cgIwLSFXmCe94Qo6K9xRC24LwTU+B3Q/HflaEoqiIWwBZTWKfuGnASkNqrNzFUwhuBuS3dCRrvz7f1XqINjMY1zYgpG/4ulb122zoEBD7gHkDXChRVhlq3fENFn86X/+uoUW0cnlKEq7t7hJ0B+MP/elzfz9xeHTy4n6DYkEaRC/HSj4Bx2AZnXym7NvjuKelq2s1s7ewhkmt8HIGD8W/jSW8wTpUo2+ybUcKknSuBEoWCf48hegrisa6BXvFl19dUtiYnDZMgVeZydO1TrRyiHdd6FAyQNU8yEnieoTA1W2nEAbhWn5C/eXVHKFLUrTVn0vMj4UlXTS4Ca96inMLI1s5zq03BOl05v/P2ru7nrcu1zsyQqpyOHdtj+QIti33NKxFDftexc4kqpC84MI8RQdWfzZlaBsmqKtflNai2zW69cYdmEKUU2i7VhKXXCFfUcKOy9z0y77W8+AJ/1il1OMhyO1UfeUdW7VeeM+qsj2MTpWG6PGe3GpJ2WpEn+qzXZSML+nFCMaygIuqzeUUmsgi79UhUbSa7yQcPhzEGWUzPKjl8CCnHnaLVsfIsDad8I5vTVVbsIRLQtOQo0RmkVhz8v3XgHu972g4xR6K842d8rjG6Bqyur1RL+auaQTNx3Oi6gj/eP12cKzm0GUjUBHv7+sSah5FTZvlNu1NUP1j+j88camm3ZvRy45irpR03E4lRSKiOpcc4C0qHVjR23UnrzgEzz6fm9J+CY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB0187.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(110136005)(54906003)(36756003)(66946007)(6512007)(316002)(186003)(86362001)(31696002)(38100700002)(8676002)(6666004)(8936002)(5660300002)(4326008)(6486002)(6506007)(53546011)(2616005)(66476007)(26005)(66556008)(31686004)(508600001)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejFwUHQ3eGdsNzYzZFpIVjNHUTQvUWJRUThLK0VSQ2pnancvYlNvOW1rNGMx?=
 =?utf-8?B?dytmR205OGx0THlpeWdTS2h2TjBPZllZWkpDZ2dOaUFpR01MdmtDRlYxeGZv?=
 =?utf-8?B?aEhQaWN4WmNsT284RHpZbHRwdzA5MGgyb1R5T3JQdUJvTWc4QjdqWlRoWVFr?=
 =?utf-8?B?YnlRa2l4VDFMSFMxSGZVS0szVzduL3NHaDRFMmJ6dU05NEtkYWhnVnpyUHlp?=
 =?utf-8?B?RFM0K2pPVnQyUXMvblRZSjV0eXF2dTFJd1NCd0JJR0RIRjRQbnFHMTNzeG5M?=
 =?utf-8?B?K05pQkhjZ0R1NGY3bW0rbzI3cHg2cFgxK0xDdXRRREMvcTA0eTFIYkRLdEM0?=
 =?utf-8?B?RExyWUtIcTN2RTE2Ry93YkxueGJ3S3JJbHZWeit5Z3BaUkp4ZWxvbEo3MnR1?=
 =?utf-8?B?bGtsNHAwVlc2NVVWZnlpb0c5K3YrQ1NOSG9RMXcwMGtjTkZwMDJPVXp5aCtK?=
 =?utf-8?B?UVpzQUQrcnlOMGJ1SDFXNXVBVnNDY1RoeVFpSjA0YURFbmJvNUlhamxqUG9D?=
 =?utf-8?B?MTMxbkQ3T2cybG9SZVphZ0hsNG9LRG0xMW5jdWl3eWNRYW9mczNTNDk4OEVz?=
 =?utf-8?B?UE9uNzZZRHZCS1FTcS9oaFRXcUxUN2ZUdHZ2b29uZXh4K0Zuem9MNHM5NVhE?=
 =?utf-8?B?LytOYzZlU3lvL1VjeS83NjhCNndIblZSaE5Za05xQklEWWd4ZEtSV3pWaGhq?=
 =?utf-8?B?dW5CS2p6c1ZlUzNKY1Y4cDFQZFhkWTJyaG82MjRFQ0tuTHV0TkwxaGhFZFJi?=
 =?utf-8?B?U3dGaWgxZFJJMStSUVE3NjJhQVFaRUIxL1Q2ellDa2hFcTBnaE5VWnhmTlZM?=
 =?utf-8?B?bHQ4UTQ2YjJuYzNiTzdNSjhQcUhtTWY1UjBHdGJ0MlAwMmRUb3I4U0dmb2lQ?=
 =?utf-8?B?eU4rV0k5ZFZ1azRSQlJXL3h3enZMMHZXNkQrUDJpRUducGZwbkRKQk8waWRL?=
 =?utf-8?B?ZStJbTdoYVRXM2Mrem5TVDZTZUl2dkhwdFFhMEtYYktqWmZPTFhvV0loNUdk?=
 =?utf-8?B?Zms3REhYTzRKWXc3SVlpclB0RmdBL3NSZzNtRUlJMGpLM3JCVDFQOEx0ME93?=
 =?utf-8?B?NmJiYjFjc20xNDkzMmhvbzBydE5PZExpa2ZGZlFKTGhtNEdDRzhPbWNLaG9B?=
 =?utf-8?B?Vm05WmFBTUVhQ3c3N3VPUlh3aDlUMXVMU1JlYkRPcnlvRXhHeWZyei9uY01J?=
 =?utf-8?B?UEUzOFBtTnBrVGlIUmV2K2NRNERQeTFlRGd5UWo5UE5vYlY1M1VlQWg1YnB0?=
 =?utf-8?B?SVN1MjBqN3B3WXVuSm85NXRhVGRkZ2dCQm9FanJqTFZqNHNWaGlGVjhUMnJx?=
 =?utf-8?B?S0YxWHIrc2VTd1hScGVwN2hOS3hjb1J2WEd1T2tqNEdLOWwvUzRVbHZhVU84?=
 =?utf-8?B?QXg3YjhiSm1UV1phajRUVlhmYlZPT3Faejc1bkM3OEVFYUtRbzdJUys2eGla?=
 =?utf-8?B?TTNVd2tFVUdsQjVVWExvSWZyR2Z5ZVgrOG43bldXYk45Z1RvMjgxZi9ERGl4?=
 =?utf-8?B?NlQ1cXB3eGJwMm5UdUZ2TFR2R0hRakVDM29WRVlXYlNrU3lVYUkxUVpmS3gw?=
 =?utf-8?B?VVRNNUJJdU54SzVmTGRMbm9QSmF3Z0Z6NE1xLzF3MW5hYllmcjljeWJncS9J?=
 =?utf-8?B?WFNvdDUxb0U4N244eEVOdHExTHZtcXdNTlFjSXppUy9CeFhlcHZjWlFXYXV2?=
 =?utf-8?B?ZktVc3lCOVhta0Q1d3pLTFVrUXRMRkh1dUxRSnRuN2xBVC83bVErN0h0N1N0?=
 =?utf-8?B?SlFGcG5ROTkwdjNTUUZIKytJVTk4Q1FzMEgxdThYRXNiSHBJdW1oZS84bFVq?=
 =?utf-8?B?dG9ESFlJTnZuZmRORys5dGUzVjJpVnpDclEyWk0rbUZtRFZzMjBmaE04R1Rp?=
 =?utf-8?B?ZUpSLzRQT29pSDZUTytPY0NLY1RMWUdJMnVEV0dLK05JWTkvRDhBYTVESGEv?=
 =?utf-8?B?SW92RDRkczN6dVhoYTVOb1JPWFVXdzc0NDk5dXlaZ3RuZEY2R3RhZ0N2SDlT?=
 =?utf-8?B?R091bVhmdW1tNzNlMlJxcldFRitPU1ZoVlRZNWJDVTcxZFI4bG9aNEF1MzNl?=
 =?utf-8?B?NTlZNnBFVC9QREtZYjM4aWVGYzBOQ0twMHhORlpXMmZIVE9MNEpvTXlUekZs?=
 =?utf-8?Q?XSRk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b1bfd6-ad89-4e2c-4b6d-08d9d9a09099
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0187.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2022 10:03:09.5002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QWV6CmFY73V7ZdNWmlUMQp0RIqdU69B692eqHUsnNrgwa+9A0UPE+zp4wZYv5PDj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1683
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sharma,
 Shashank" <Shashank.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.01.22 um 11:01 schrieb Somalapuram, Amaranath:
> [AMD Official Use Only]
>
>
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Monday, January 17, 2022 12:57 PM
> To: Somalapuram, Amaranath <Amaranath.Somalapuram@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Sharma, Shashank <Shashank.Sharma@amd.com>
> Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPURESET uevent on AMD GPU reset
>
> Am 17.01.22 um 07:33 schrieb Somalapuram Amaranath:
>> AMDGPURESET uevent added to notify userspace, collect dump_stack and
>> trace
>>
>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/nv.c | 45 +++++++++++++++++++++++++++++++++
>>    1 file changed, 45 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
>> b/drivers/gpu/drm/amd/amdgpu/nv.c index 2ec1ffb36b1f..b73147ae41fb
>> 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
>> @@ -529,10 +529,55 @@ nv_asic_reset_method(struct amdgpu_device *adev)
>>    	}
>>    }
>>    
>> +/**
>> + * drm_sysfs_reset_event - generate a DRM uevent
>> + * @dev: DRM device
>> + *
>> + * Send a uevent for the DRM device specified by @dev.  Currently we
>> +only
>> + * set AMDGPURESET=1 in the uevent environment, but this could be
>> +expanded to
>> + * deal with other types of events.
>> + *
>> + * Any new uapi should be using the
>> +drm_sysfs_connector_status_event()
>> + * for uevents on connector status change.
>> + */
>> +void drm_sysfs_reset_event(struct drm_device *dev)
> This should probably go directly into the DRM subsystem.
>
>> +{
>> +	char *event_string = "AMDGPURESET=1";
>> +	char *envp[2] = { event_string, NULL };
>> +
>> +	kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
> As I said this approach is a clear NAK. We can't allocate any memory when we do a reset.
>
> Regards,
> Christian.
>
> Can I do something like this:
>
> void drm_sysfs_reset_event(struct drm_device *dev)
>   {
> -       char *event_string = "AMDGPURESET=1";
> -       char *envp[2] = { event_string, NULL };
> +       char **envp;
> +
> +       envp = kcalloc(2,sizeof(char *), GFP_ATOMIC);
> +       envp[0] = kcalloc(30, sizeof(char), GFP_ATOMIC);
> +       envp[1] = kcalloc(30, sizeof(char), GFP_ATOMIC);

No, not really. kobject_uevent_env() will still allocate memory without 
GFP_ATOMIC.

I think the whole approach of using udev won't work for this.

Regards,
Christian.

> +
> +       strcpy(envp[0], "AMDGPURESET=1");
> +       strcpy(envp[1], "");
> +
>
>          kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
> +
> +       kfree(envp[0]);
> +       kfree(envp[1]);
> +       kfree(envp);
>   }
>
> Regards,
> S.Amarnath
>
>> +}
>> +
>> +void amdgpu_reset_dumps(struct amdgpu_device *adev) {
>> +	struct drm_device *ddev = adev_to_drm(adev);
>> +	int r = 0, i;
>> +
>> +	/* original raven doesn't have full asic reset */
>> +	if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
>> +		!(adev->apu_flags & AMD_APU_IS_RAVEN2))
>> +		return;
>> +	for (i = 0; i < adev->num_ip_blocks; i++) {
>> +		if (!adev->ip_blocks[i].status.valid)
>> +			continue;
>> +		if (!adev->ip_blocks[i].version->funcs->reset_reg_dumps)
>> +			continue;
>> +		r = adev->ip_blocks[i].version->funcs->reset_reg_dumps(adev);
>> +
>> +		if (r)
>> +			DRM_ERROR("reset_reg_dumps of IP block <%s> failed %d\n",
>> +					adev->ip_blocks[i].version->funcs->name, r);
>> +	}
>> +
>> +	drm_sysfs_reset_event(ddev);
>> +	dump_stack();
>> +}
>> +
>>    static int nv_asic_reset(struct amdgpu_device *adev)
>>    {
>>    	int ret = 0;
>>    
>> +	amdgpu_reset_dumps(adev);
>>    	switch (nv_asic_reset_method(adev)) {
>>    	case AMD_RESET_METHOD_PCI:
>>    		dev_info(adev->dev, "PCI reset\n");


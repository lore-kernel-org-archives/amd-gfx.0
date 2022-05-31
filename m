Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317D4C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 03:03:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F67410E1F0;
	Tue, 31 May 2022 03:03:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0ACE10E1F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 03:03:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhDwYhNsaBWPmsv71JILAJl90p0T9Xfzo2KepIIsT8iebReB5WVFq8Hpm6aqWEHwdWXhiWZtJtJ+TrhwJ97oICpc1nz+qFLPUE1VUtdy6yslX+Ni70gug+3U1HTInIS98g2eINYmem3OFDy2p1E19VO2sHhrQqaFOKQA4+Cea2qyFQLBxAchBeoV4+edNpbH8JVqDaq2MPz3vMZcZ4B2v3Dl10M1W+ZN/WL4F8C0Juzw5DOAwTpfm7tIZWOKRt3QEbghiaT9aIN0GXE65Rjt/x/ig/uk8lUjcbWMa2ScnYmA3syZBdf4jENG1a1oYerPEVSI3vHKpOAPkC2XJ5CKOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxlMravSZiu7aqdtEhv94hoPJg3xSMppZWIuhvNs7OQ=;
 b=SvLbJ6Yof7AkF5hdHTERnhEXFXDmKZu26V3G8JMcgXC9lqxYovELyjQehiSdDyccTI9OHLvepbkKB3+PDSo+kcbysCZs6400IPfmiQJ8HFNdD2h48f2n9iJrxMrHRmvRIqpXoiUUCiE6bTx4HmffH3IoFpWDBjp2+OOKZtgRCJshKj1mzA13NPv9zVnOc8txS7Se/BdRO0E6z7eXmPagXHQHzCXkm1m4s67NwgxE2jwAj9DuUMYCmpsJHnIdu9OlGOBN86IeGf5yC8WJmAkvoEAwqOpEG/dYxsZf4KDTnBcdVkbX+ZD6uk+pO7BaHdIMBp2Tp4r6n/ny7eE8ByFSLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxlMravSZiu7aqdtEhv94hoPJg3xSMppZWIuhvNs7OQ=;
 b=1C7h5a/GmO5TedOOeI1ITo9LNmsvK/uq5VlxdgrySP52qN301QsBkof6V8qnn6DKFyBx5lqib6blITyYAj46jthowr4kKtG64OguMl+PBBArInGa+yLNYj96y+4pcHq74r/hxalR2e5tHt5hd/ft17EZiLvOP5gigEStoV+G2Go=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 CH0PR12MB5073.namprd12.prod.outlook.com (2603:10b6:610:e0::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Tue, 31 May 2022 03:03:04 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::f85e:63df:8fde:b620]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::f85e:63df:8fde:b620%5]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 03:03:04 +0000
Message-ID: <e8299242-617f-5deb-54c1-8c778220e617@amd.com>
Date: Mon, 30 May 2022 23:02:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 3/7] drm/admgpu: Serialize RAS recovery work directly
 into reset domain queue.
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
 <20220525190447.239867-4-andrey.grodzovsky@amd.com>
 <4b4ffe49-e7e2-880f-392a-98959ee63d49@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <4b4ffe49-e7e2-880f-392a-98959ee63d49@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::32) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd9f208d-bdb8-468f-b465-08da42b21496
X-MS-TrafficTypeDiagnostic: CH0PR12MB5073:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB50738A46F0C3E5D64493105599DC9@CH0PR12MB5073.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qRGtfgdj3lpAyRG0OClQLv+vIPQ/iQzbcbeCrNImTQ7uB1KgrjHCdJ3hgmbMFvv0CJEAfQIwlBS3ooxYzPFhYHSekNPGnFDx3pTkEgBmI1qC1cDcBYxEbjsxrXx4RnJCuBxVF/6kwTY41eUBrOYR72DQS9QzdpFtdBZ39bm+2bEJHoBgMG/iWWq7tzQ9jPR/MFstVY6AeQL6HzVJXl21tBu8UwFkt8H7DcMeTbthiqc8Cy8NCo6hpv4VOn3WPQa944ZnbMCrZirOqaCtYIQe5vpe4s63El1VmhvKU9HS+7zDFRzMofYgAhekmPyY3WZmI9h8UFsxKGM2qQmZgZu7MB6Y8sTHMkgpjqzZ90OowPkr6hF02v6te1VjXFAlg8SS3GriCmJcmw1j1q4ForrYoufxT/OZbmI77GAXVEYrpiMZe1T+UO3cob5N65Bv6PKG0QiOmpCqXOH0alKrOMCUZjiwIsaYxzfZ/8KL5BZZOywll2RLd4wmKv7qxUwxhgQ0tPP/jUTVrpQihzcmwaRevuMawf1/p3PiwvHvFhGqLWzKOoNqLoh/mpK1oFwGZXv+enrcRnR8qt1Bo+8BBS//jeZI+I876rXYS4E94rPlShJ5t5U8TIfzMQY8Vq3MlWJCbh+P3clsRmgK48pWQHtcUfMgSH0bvDVD3o+bJyatCALLk/rRzQc+UYTP5p+GoMIrlBfxlGxZqw2QEPxInKCfSOZgR5CbMjQokCix9JcpUEY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(66946007)(66556008)(66476007)(4326008)(8676002)(83380400001)(38100700002)(6666004)(8936002)(110136005)(316002)(36756003)(66574015)(31696002)(6506007)(186003)(26005)(5660300002)(508600001)(6512007)(6486002)(2906002)(44832011)(53546011)(2616005)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTl4Vmh1S0N6M2dvRDN2ZGpCQ2hTdnY3UFZENStlYnhXRy9TWDBwUTNYblg5?=
 =?utf-8?B?dk1laG5JT1EvdFBZWHJET0R1STZhc0o4SEIrZWRJNm1UeEV4dEtXWmtBa2hm?=
 =?utf-8?B?cDZMQWdVREdYMmNkRENPM0dia2t4eDNVa3NFVWtHT2d4WDlyM3ZEZVNuZ2tG?=
 =?utf-8?B?Q1J4WXZWaWgyUGN1bnp6eGR4OE5LaHVaN20wYjdUeDJpMlJMZEZzQVFxb2Z6?=
 =?utf-8?B?THZ5M3I1SFVQWUdKbXNocjBUckIwMjc2V0xlTXJjelNtYWR1eHBNcW9LUHQ3?=
 =?utf-8?B?VHhoMHc4eVF2Y3RTK2lpTjA1N21QV2V6M1E5UEFpNzlHQlZYckxkZWlxWGRU?=
 =?utf-8?B?bWt3MEd5NldiMkY0K3d1K1pxSkVjbTZxUHlrYklBa1NqZ3dTQ2pEOUw0cWt0?=
 =?utf-8?B?UTEwdEJvcys5YmR6S08yNUVDamdGRjdFdVJnTHNqamV1KzNsd0pxeGN1NjBp?=
 =?utf-8?B?bU80bWNGd25jc0Ryd2o5RlFoY2lleGg4NHlUVlNNSUVCYVJhSTAvUFFBKzFx?=
 =?utf-8?B?dDg4VjkzTGs4NjZ5K2h4SmpQc2UrQnJkRnIzSVQybnJKemtQZi9uT3RxNWor?=
 =?utf-8?B?SVBTNE9Oa1pLeDNkQzN4bEJia0RVNEpGblFGWC8ycG5jdmg5dTZEMmZCMnUx?=
 =?utf-8?B?UWFvSyttZ1Y5SWE5SE1ucU1YbnR4b2wya0FnQno1cHNTYTVVK1VIWjloZFIv?=
 =?utf-8?B?N2JMMUUrajdhWnNoYkpYZkprMVZReWYvWEN0ZXI5M1Mrb2p5WHJ5ZTZMYVlE?=
 =?utf-8?B?enlUa1V5MGkxdXFLNkh6MktpYlJEVU1wUEVKY29LdDl5WUJGcVFkM1RGdXpm?=
 =?utf-8?B?Nmpib0tYdTF1NFFLQ2daVW5WU0UzK2JialBxUmx3a0NUV0VYbU9WQWFubXNq?=
 =?utf-8?B?YmVkQllvZU4xQzl6SVdXR0t4K28vbVZidWcraEdMYmNyRFFLQmwrcHE3WDBQ?=
 =?utf-8?B?VDhaQ1FCdEtOWk9QT3k3Q1FuOVlZamJGVHNmRUFQRlVFQmtxQlBObEUzVjRu?=
 =?utf-8?B?dU9EU2VhWHpQalNRWmhLQnZPSSs4RUNjbEpBK2VDdUh5MVU3SkljQmx5ZUNt?=
 =?utf-8?B?UW1SMWtMZEhDQVlRVTZ0WFovNFZXSXFGT0lzclVpOWFIR1UvbGZCVjlLdStH?=
 =?utf-8?B?c3JjTEVHQThWNHNDRDhyMTVTZzl1SVo4R0ZhdHp2NXRGREFGdnhHM2VxbmQx?=
 =?utf-8?B?YzBvRVR1UkpiK3pXS1ZRc0I0cllLNVAxT3B1RVJkb2dwT2VZN3BaakxFeENr?=
 =?utf-8?B?U3FhVjRZeXAxOVFJaEh2UHkzQ2R0eTVRV0Q4cE02c0x4RFdGckZ3SVpwQ3cz?=
 =?utf-8?B?WTExZloycERVZDdJaEluYUJ1U3FSdm1OYmtFMXpXaFNLNnB0RHdSOHlmcE5E?=
 =?utf-8?B?ZFhMSWFHZTZXOGh2VFdlMzJWSDhScm1GaFN1RmYwMWRtU29DYUZrMXJtNFox?=
 =?utf-8?B?d0JxTUozZkhMa0tjV1JlN28vMndTVzlTZm92SVozU20rN1I4YmJKMUJ6UzJS?=
 =?utf-8?B?MzJITWQ4bHFrendPOWRDdm1EbGMvbnk2UG54dmE3ZEIxY2tDUU1zeHFGL3o3?=
 =?utf-8?B?bUdnejBKd1ppQTZJZkNWNjA1dHM2UytydHpqTmN5VW9VaWZtU2hwU3RLSEhT?=
 =?utf-8?B?VkN2RU5hRzFRNUgzbzl3eWxLWEJZekw0Z3pGdVBRcTI0d1lZVlJVUFR1V1Vy?=
 =?utf-8?B?SUF0dkJKWW55N3I2TkZMaG5DeFdSZWxGc1JFNitrbFZUVWc0STVIczFzVmRT?=
 =?utf-8?B?NWtuZWN4WkxrdjZyM29SaS9YOE5WZUVUclcwdEUybmw3eDdRQzg3TVY5UVUv?=
 =?utf-8?B?Znp4UFdYNzZCMEVWbE5aeVhaME5Cd0cxemgyVlhTKzVMM2FHV01LVXlmUjc5?=
 =?utf-8?B?WERhcnhKZFZtSXBMejNJSE54cFN3cHBtbzNMZ1YvTFhONVp0VmVNSU81MHJm?=
 =?utf-8?B?eUt2ektEZlhHOXhrQUQ3ZCtzQXl0RUpGMUNzTFVoTjJTMXpNaVdNMEcyTUR6?=
 =?utf-8?B?Z0ttWGJGVWoyOG90blJrV1NDQVhFaWxnZUYrZzdTbkh2cmRUOURaclBpeURN?=
 =?utf-8?B?Q2Vxd1pJVzBKRU9nbXdGVlByRXVGWUJUalE5K2RpazBvZFIvWjdaU0RsQzc3?=
 =?utf-8?B?MGc2QUhmbWpBTjhKOEJoOWYzV2UvK0p6dGdCWUQ1R2lJVmRrOXd3ZmltQ0Vr?=
 =?utf-8?B?elZvWUM2YmdsVHdYZmFCWkUzcDNlNG96WEMxb0lRNmVDQW9jdDI3UVRwVmRi?=
 =?utf-8?B?bHZ5dk5jZGVaWmJCZFpoLytDOWZBS0RsQWxLcjRaUEFIb0ZtZ1g3eFJMNEFK?=
 =?utf-8?B?Ui81OStWQlpBMkcwRFpnaUZZWnpabERrTGYrSVpuVXZyMXN5bHhKQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9f208d-bdb8-468f-b465-08da42b21496
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 03:03:04.5410 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8hNIP09PQ/XnysqXMm/JtoRNnPbjAmh85+CnLGxZCFc7oRbMrdNeZNHlsCJ4wxO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5073
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

On 2022-05-30 03:49, Christian König wrote:
> Am 25.05.22 um 21:04 schrieb Andrey Grodzovsky:
>> Save the extra usless work schedule.
>>
>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> 
> Acked-by: Christian König <christian.koenig@amd.com>
> 
> Maybe Luben want to take a look as well, he has done some RAS review in 
> the past.

Looks good to me. I understand this is a change to sync up with the other changes
Andrey has been doing to GPU recovery.

We'll need to test this "in the wild", and thoroughly.

Acked-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

> 
> Thanks,
> Christian.
> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> index 31207f7eec02..a439c04223b5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> @@ -35,6 +35,8 @@
>>   #include "amdgpu_xgmi.h"
>>   #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
>>   #include "atom.h"
>> +#include "amdgpu_reset.h"
>> +
>>   #ifdef CONFIG_X86_MCE_AMD
>>   #include <asm/mce.h>
>>   
>> @@ -1920,7 +1922,7 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
>>   	}
>>   
>>   	if (amdgpu_device_should_recover_gpu(ras->adev))
>> -		amdgpu_device_gpu_recover(ras->adev, NULL);
>> +		amdgpu_device_gpu_recover_imp(ras->adev, NULL);
>>   	atomic_set(&ras->in_recovery, 0);
>>   }
>>   
>> @@ -2928,7 +2930,7 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
>>   	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>>   
>>   	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) == 0)
>> -		schedule_work(&ras->recovery_work);
>> +		amdgpu_reset_domain_schedule(ras->adev->reset_domain, &ras->recovery_work);
>>   	return 0;
>>   }
>>   
> 

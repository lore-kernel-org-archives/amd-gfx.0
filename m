Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B43C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 03:25:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A204A61425
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 03:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A204A61425
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB61D6E29D;
	Thu, 30 Sep 2021 03:25:38 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2057.outbound.protection.outlook.com [40.107.101.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E3E6E29D
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 03:25:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+Zy5xf4Lipl/wDaw5z/LogHNbxAS63oc8H3CPH0JByb+gx0K/uZQwdFMJ0PB1PeMHL2GLGOi7Rf/VumnclI3MXCGm9wzpJn9dd9maHcz5HjQJCvb1xY5yRnTrTfKm5uSLyTETMoaOleLN9/l+iD41yLIBnZfpUXNQxSOb456vchWQXsladGC3qnGEAsT/Jj67pu10VTF03iMTvuAWoNcaFhTM+7+XgWfGmalrB9Ij7I0sc3PlUq9exC2uWwJX2aXvNrL6kQQuWNIJ6t8MNeiB8G+Cf5qaXxT9pEYVAdyOwk8sIrNRNwtoA6K+5lFk0WOPaP+3fuOp4lKqiJ1ldsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=Q1CZ20LCovbIPafYeZHV3qpoaqfbaboIX4RhMXF/1Bg=;
 b=WtzLUOIpVFIfUhemWrIzotGrS0Do7VQQ76zLRYMDL5d8YuemWH5pVmX/n69Yt3ri/bx7LoxcdpAvd8Ldiyj4Vx3EH8UhX7lwyJ7K2L1u80DsKMAlPTqQpRFO6XrhsN1blWGI0p4fNw0OwJ4Wol/ZxgBDG+Xjtaf8zl/lu2bjniLylOqNODhvbU9CQtHWrNhxzrVIC3SgmoQkvbU8M9nzqtOJ5xYhK5gU5XDayyAB2jV7PcDxBdDc28XZQYuoHWQZc/XNRaSpopych8TqsYBVACS1LPVKH/HFtcJY2NH+CEWS9ETzJlgEupx+grSqBtc6tRT7rFb7vl5pr98fAI7TNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1CZ20LCovbIPafYeZHV3qpoaqfbaboIX4RhMXF/1Bg=;
 b=IPwzrOBNTzupcU4AODg3MNaA5L1Gr+36VWPW7A+1ZmmzQR5FRp3KTXNS1Aadml8PRR8Q3ROwcheERYp65G17gpcX+NrtAH1yl3q5050OV2lk5aQS28c/RjgEhwzrICeiP6hjdfeBteEu1PXywn+RdMc8J8KdmVbR0ohzCoJFxSY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB3308.namprd12.prod.outlook.com (2603:10b6:5:182::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Thu, 30 Sep
 2021 03:25:34 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::70bf:51ab:7cba:45c2]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::70bf:51ab:7cba:45c2%2]) with mapi id 15.20.4566.015; Thu, 30 Sep 2021
 03:25:34 +0000
Subject: Re: [PATCH] drm/amdkfd: fix a potential cu_mask memory leak
To: "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>
References: <20210929082212.1806312-1-lang.yu@amd.com>
 <2ccb1777-ca8e-5a39-5311-3262c1cba608@amd.com>
 <DM6PR12MB425096E4B53642BEA55FDE25FBA99@DM6PR12MB4250.namprd12.prod.outlook.com>
 <10d28f06-42df-6b8e-6e44-a4c85ed92473@amd.com>
 <DM6PR12MB425018180CB2B71C7BBC0134FBAA9@DM6PR12MB4250.namprd12.prod.outlook.com>
 <29e7070d-f36a-a904-e173-0de8a95a7d50@amd.com>
 <DM6PR12MB425032636CE5A8303F1E481EFBAA9@DM6PR12MB4250.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <1175c55d-8bf3-c9da-43da-b2c86911754e@amd.com>
Date: Wed, 29 Sep 2021 23:25:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <DM6PR12MB425032636CE5A8303F1E481EFBAA9@DM6PR12MB4250.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::18) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 YT1PR01CA0139.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 03:25:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48ce9e48-303b-44f8-8a17-08d983c1f707
X-MS-TrafficTypeDiagnostic: DM6PR12MB3308:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB330881D512B4BCD9EBDE677692AA9@DM6PR12MB3308.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TeY7KImqh6FNSSOI1ppiN+kSbZq9fX7JcavZwQ5JtyV+pPMlfZ+PLn2DA/gYLrOx3U5PSf65GInZhFL0vurUwEZPHJmJovYp5333uSrusqsQsuGo8zsj/PleZClYIRXrJueXYbZWW1S6F0vj2fC9itvpdkQrU+qYc0JG8tx6XoTdgXPTN7k7FZCdZNdt7XS+vvtm7ssoPJ4m9SbhUT4fqgEuchB5DX+tkq7OdoQNbuV6uJa9EkY7IgjWI5+Z4RNBgI7cntS8NYDAR6tjpEuyOkCa6abohooErhmkKdDATCNqd8nKLJRaWAEqHYDYJNls29rs43TCcCrDBMB3f+FOxSjhKWfM8Xkr+aTtFEtXofn0DN205CQWUAlqLbwqbM+0t85wTANlUokrNW+zM8q5dDHzsP+IbLrDOp1vQ4g3Z7VdgSGyvysKn8ZivZeWfScS+aRcnNlZl4TXv5ZzjOdEFMSG6L2TJzJdDwv5vM+h7D0NwdEABdOlwa8c6X8LWJCuU1SFVcJ8q6IOH4VmDPsoEft8fTV7dThgcJLjDaf8zu5SsILmXGTQJ1kwki/Xt5ROA+d7LFEFkLU0fK/UP2eyt+SN7DFHwUNj/Cbt1febu4+wKtBAZeIEd2sJPxTW9CPc9eSR0+9Ajoh2wjafOrVTFIRVUrtiPJLhe6sQBkdVCR2Kty6SCzZ4nRItxKthawNwAuXYLHrEGkJlhoeBF31sGeOJYRPTfxs1SQEfc+k8eu1x9RXq3i6JHnwrSkjn3iud
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(38100700002)(2616005)(8936002)(956004)(36916002)(508600001)(66946007)(110136005)(26005)(54906003)(44832011)(316002)(16576012)(53546011)(31696002)(2906002)(4326008)(8676002)(66556008)(83380400001)(186003)(5660300002)(36756003)(31686004)(86362001)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlhOR1M2U2V4eVF3YW8wRWFKTWt5MDUxZkx3Q1BwRW8xUElmam9HbUYvUXUr?=
 =?utf-8?B?bkRnSFk1eVNtWFEvcVZ3dFF2S1JuYWE5aEtjVHpzV25xU1FKQVBxVVd2QlFN?=
 =?utf-8?B?SVY5dEM5bFpSWlQrdVd5a2wvZkY0TENoMnp4SEpMV2pMRm40VVpTNGFNbGxV?=
 =?utf-8?B?eDBZUS9VTjVldjYxSXJ5ZjdqbHNjdDQwNmEyeFBreGZRblQwWDB4Z3Uzazgx?=
 =?utf-8?B?WUxtZmU4RGRYOWM3MzRDMW5MWUNlOHJiQm9IQ0NnOHJuVm8vUmxQQWRwMURZ?=
 =?utf-8?B?UFFLT0xHNnNOSE9mbHArNVpBWjAxSG9lRm9kY1V0Z1BLci9CMSsrM1FZQzU1?=
 =?utf-8?B?dVp3c2VpVWh1aUpUbUN6SjQvVkdrY2hqbzkrU0pWZm81RUY5bVBmSjgyaXVU?=
 =?utf-8?B?UVBKQWFmUUtGWWNta3Mxc0xMUjZtUkx0K3p4K2hTcUtjem1aNEdOelBrS0F1?=
 =?utf-8?B?UW5WSk4xbXZ6L081Zk5mdVZBOG5lRlprODRXQ0lUSlVpK2lsTTZNMGtWUlhD?=
 =?utf-8?B?UzBwTSszUkNpemNpcTBLNVdHckp0aDFLTUYvc3FDeU13NjlJS2R2MUdrM2tI?=
 =?utf-8?B?MjI3ZVpQSDg0MzVqaHJuRjBQY2NwZVpxRUxhQ01EK1hmb09FbzBQYkZPYzIr?=
 =?utf-8?B?K0NyNUo3UkJVdmZRMTRwRlcyQ2VLbHhubTZ4YUFwQ28zSnVlMGNucVlubnJ5?=
 =?utf-8?B?Tm10aDBBZUpDRWVreW5yeFZSNjZMVkNwT2ZuV3BaTjFNSUgyOTdJK3B4Mm83?=
 =?utf-8?B?SnpEUVZ6OUVVMlZPajcyU082S2FUcnB2aERHQnE3c1JDSWlqQ1BZU0QrSG9H?=
 =?utf-8?B?RWxuUXRCUEtKOS9hZk9jb0ZtWVpUZW9tWmhXZGdrOGpaWUNzL1FOZVZ0R0Jt?=
 =?utf-8?B?cjNoeFUwclhBWElaQVdCTjQyYUJsRXJ4VlQ5a2JtaTJKSVpydHYxQm1LeVBv?=
 =?utf-8?B?bFlTaUJ2bkhKZS9kZHdpdEJCWnl3TWpYZXczbFJTNlNOMHp0enVEL3pSbU9o?=
 =?utf-8?B?Yk1uYm8wQStZdGFhSjNobU53N2Z1dkl2RWU3QytUZGdLcjYzalM3ejZ5QkJm?=
 =?utf-8?B?bE9LRVZVZ1RBdWNpL2haaVYxMmVHWFR0SEpCVnROaW9oK0tsMDBPTk5uNkI0?=
 =?utf-8?B?K0tRR09IL1JNSmJ3ZlJzNUN6QUNCMmdNSDdvZXQwaS9kWXo1YXpqLzljYytP?=
 =?utf-8?B?V2ZjNVhqaDJsaCtYU3UrcDVPdzlUNHdTck95VmphS2RKODNjZmY1eUVzZ0J2?=
 =?utf-8?B?b0M0cDFkYlVpQjFpL0pPK0RNUzNRTVZTNWxFMFh3VyswTmxFNksrYlkyVjVQ?=
 =?utf-8?B?UXFtSjdlbnBLam04ZkIzek9IZmsydk9peXpMaGhLQUYvdGFZQWtlWEN2aUhM?=
 =?utf-8?B?S1dqN3p0a0Uwa1BFVm9pWGRIZVBJMjZxT0xIUmsxVkYySzdWNmwvalkzekpk?=
 =?utf-8?B?TFltRjY4ZGZtakpZcFpTYVpUL01ZYU1OOEszWHFtYlhSS1I2RVZzd29rQjZI?=
 =?utf-8?B?TjVyRXVndHMyYk1UTG1hTnVzMFZRdkJvQm5GbFlLTmQ0MncvZGdDOVVzMU1i?=
 =?utf-8?B?cnFuTEQzMUJ2azZYVlRmYWlWZWczNEgyaFpFVmZyRkJ2T0VYeXlSNXQ5MEUw?=
 =?utf-8?B?bmlpNU0rMHBWdnlPeFJLSFkyeDdIYnVRUUQxWW05TnNMUGhsdFZjUko1c0dN?=
 =?utf-8?B?VHNTaVg2aVpuMUFrazIrS0V2YitlVXJ6MFZmV2NWSE1ZTG9JZ1VCK3BBTGFX?=
 =?utf-8?Q?l1iItesA0FMbcVw8keNCqhfLkVyH0uBCFiGNZtu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ce9e48-303b-44f8-8a17-08d983c1f707
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 03:25:34.7898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HC+l3uSA2J9A8fAQa6tJ9teB4h7AgecW0JJMBLYTst8t8TTonN/MlYoJFyK6F0cY8UTKDOzIa8IkPCZX45fimw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3308
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

On 2021-09-29 10:38 p.m., Yu, Lang wrote:
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Thursday, September 30, 2021 10:28 AM
>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>> <Ray.Huang@amd.com>
>> Subject: Re: [PATCH] drm/amdkfd: fix a potential cu_mask memory leak
>>
>> On 2021-09-29 10:23 p.m., Yu, Lang wrote:
>>>> -----Original Message-----
>>>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>>>> Sent: Thursday, September 30, 2021 9:47 AM
>>>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>> <Ray.Huang@amd.com>
>>>> Subject: Re: [PATCH] drm/amdkfd: fix a potential cu_mask memory leak
>>>>
>>>> On 2021-09-29 7:32 p.m., Yu, Lang wrote:
>>>>> [AMD Official Use Only]
>>>>>
>>>>>
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>>>>>> Sent: Wednesday, September 29, 2021 11:25 PM
>>>>>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray
>>>>>> <Ray.Huang@amd.com>
>>>>>> Subject: Re: [PATCH] drm/amdkfd: fix a potential cu_mask memory
>>>>>> leak
>>>>>>
>>>>>> Am 2021-09-29 um 4:22 a.m. schrieb Lang Yu:
>>>>>>> If user doesn't explicitly call kfd_ioctl_destroy_queue to destroy
>>>>>>> all created queues, when the kfd process is destroyed, some queues'
>>>>>>> cu_mask memory are not freed.
>>>>>>>
>>>>>>> To avoid forgetting to free them in some places, free them
>>>>>>> immediately after use.
>>>>>>>
>>>>>>> Signed-off-by: Lang Yu <lang.yu@amd.com>
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/amd/amdkfd/kfd_chardev.c               |  8 ++++----
>>>>>>>     drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 10
>>>>>>> ++++------
>>>>>>>     2 files changed, 8 insertions(+), 10 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>>>> index 4de907f3e66a..5c0e6dcf692a 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>>>>>>> @@ -451,8 +451,8 @@ static int kfd_ioctl_set_cu_mask(struct file
>>>>>>> *filp, struct
>>>>>> kfd_process *p,
>>>>>>>     	retval = copy_from_user(properties.cu_mask, cu_mask_ptr,
>>>>>> cu_mask_size);
>>>>>>>     	if (retval) {
>>>>>>>     		pr_debug("Could not copy CU mask from userspace");
>>>>>>> -		kfree(properties.cu_mask);
>>>>>>> -		return -EFAULT;
>>>>>>> +		retval = -EFAULT;
>>>>>>> +		goto out;
>>>>>>>     	}
>>>>>>>
>>>>>>>     	mutex_lock(&p->mutex);
>>>>>>> @@ -461,8 +461,8 @@ static int kfd_ioctl_set_cu_mask(struct file
>>>>>>> *filp, struct kfd_process *p,
>>>>>>>
>>>>>>>     	mutex_unlock(&p->mutex);
>>>>>>>
>>>>>>> -	if (retval)
>>>>>>> -		kfree(properties.cu_mask);
>>>>>>> +out:
>>>>>>> +	kfree(properties.cu_mask);
>>>>>>>
>>>>>>>     	return retval;
>>>>>>>     }
>>>>>>> diff --git
>>>>>>> a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>>>>>> index 243dd1efcdbf..4c81d690f31a 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>>>>>>> @@ -394,8 +394,6 @@ int pqm_destroy_queue(struct
>>>>>> process_queue_manager *pqm, unsigned int qid)
>>>>>>>     			pdd->qpd.num_gws = 0;
>>>>>>>     		}
>>>>>>>
>>>>>>> -		kfree(pqn->q->properties.cu_mask);
>>>>>>> -		pqn->q->properties.cu_mask = NULL;
>>>>>>>     		uninit_queue(pqn->q);
>>>>>>>     	}
>>>>>>>
>>>>>>> @@ -448,16 +446,16 @@ int pqm_set_cu_mask(struct
>>>>>> process_queue_manager *pqm, unsigned int qid,
>>>>>>>     		return -EFAULT;
>>>>>>>     	}
>>>>>>>
>>>>>>> -	/* Free the old CU mask memory if it is already allocated, then
>>>>>>> -	 * allocate memory for the new CU mask.
>>>>>>> -	 */
>>>>>>> -	kfree(pqn->q->properties.cu_mask);
>>>>>>> +	WARN_ON_ONCE(pqn->q->properties.cu_mask);
>>>>>>>
>>>>>>>     	pqn->q->properties.cu_mask_count = p->cu_mask_count;
>>>>>>>     	pqn->q->properties.cu_mask = p->cu_mask;
>>>>>>>
>>>>>>>     	retval = pqn->q->device->dqm->ops.update_queue(pqn->q-
>>> device->dqm,
>>>>>>>     							pqn->q);
>>>>>>> +
>>>>>>> +	pqn->q->properties.cu_mask = NULL;
>>>>>>> +
>>>>>> This won't work correctly. We need to save the cu_mask for later.
>>>>>> Otherwise the next time dqm->ops.update_queue is called, for
>>>>>> example in pqm_update_queue or pqm_set_gws, it will wipe out the CU
>>>>>> mask in the
>>>> MQD.
>>>>> Let's just return when meeting a null cu_mask in update_cu_mask() to
>>>>> avoid
>>>> that.
>>>>> Like following,
>>>>>
>>>>> static void update_cu_mask(struct mqd_manager *mm, void *mqd,
>>>>> 			   struct queue_properties *q)
>>>>> {
>>>>> 	struct v10_compute_mqd *m;
>>>>> 	uint32_t se_mask[4] = {0}; /* 4 is the max # of SEs */
>>>>>
>>>>> 	if (!q-> cu_mask || q->cu_mask_count == 0)
>>>>> 		return;
>>>>> 	......
>>>>> }
>>>>>
>>>>> Is this fine with you? Thanks!
>>>> I think that could work. I still don't like it. It leaves the CU mask
>>>> in the q-
>>>>> properties structure, but it's only ever used temporarily and
>>>>> doesn't need to be
>>>> persistent. I'd argue, in this case, the cu_mask shouldn't be in the
>>>> q->properties structure at all, but should be passed as an optional
>>>> parameter into the dqm-
>>>>> ops.update_queue call.
>>> The cu_mask is originally in q->properties structure. I didn't change that.
>>> What I want to do is keeping the cu_mask memory allocation and deallocation
>> just in kfd_ioctl_set_cu_mask.
>>> instead of everywhere.
>> You're not changing where it is stored. But you're changing it from something
>> persistent (while the queue exists) to something ephemeral (while the ioctl call is
>> executing in the kernel). I think that would justify removing the persistent pointer
> >from the q->properties structure.
>
> Mmm, actually it has been copied to mqd memory. It doesn't make too much sense
> to keep it persistent.

The current update_mqd implementations update the CU mask in the MQD 
from the one in the q->properties every time. So the persistent CU mask 
is currently needed. You're right that this may not be necessary. But 
relying only on the persistent CU mask in the MQD would be a significant 
change in the way the CU mask is managed that would require updating all 
the ASIC-specific update_mqd implementations. Feel free to propose a 
patch that makes all those changes cleanly (including removing the 
cu_mask from the q->properties structure).

However, that goes beyond a simple memory leak fix. I think it would be 
worth it if it makes the code and data structures cleaner.


>    
>>>> But I think a simpler fix would be to move the freeing of the CU mask
>>>> into uninit_queue. That would catch all cases where a queue gets
>>>> destroyed, including the process termination case.
>>> Yes, it' better to free queue related resource in one function.
>>> But we allocate it in kfd_ioctl_set_cu_mask and free it in pqm_set_cu_mask,
>> uninit_queue and so on.
>>
>> My proposal here is to only free it in uninit_queue (when the queue is
>> destroyed) or in pqm_set_cu_mask (when it is replaced by a different cu_mask).
> Anyway, I still think it's strange and error-pone to allocate it in kfd_ioctl_set_cu_mask
> and free it in uninit_queue and pqm_set_cu_mask.

It would not change the code complexity from what we have now. You're 
just moving the free call from pqm_destroy_queue into uninit_queue. For 
a small bug fix, that's a pretty good deal.

Regards,
   Felix


>
> Regards,
> Lang
>
>> Regards,
>>    Felix
>>
>>
>>> It seems strange and error-prone. Unless we allocate it in create queue.  As you
>> said, it is temporary.
>>> It's not worth keeping it until queue is destroyed. Thanks.
>>>
>>> Regards,
>>> Lang
>>>
>>>> Regards,
>>>>     Felix
>>>>
>>>>
>>>>> Regards,
>>>>> Lang
>>>>>
>>>>>> Regards,
>>>>>>      Felix
>>>>>>
>>>>>>
>>>>>>>     	if (retval != 0)
>>>>>>>     		return retval;
>>>>>>>

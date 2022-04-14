Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C276C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Apr 2022 15:42:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE47B10E0E3;
	Thu, 14 Apr 2022 15:42:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 121E410E146
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Apr 2022 15:42:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtC2RPRmt5X/rUk1cM3Atm3F8VvuQ9eDt5zlbRNgkjq3J/zvpUZ+sXzg7p+AudfqdFCD6NqBArDYnl9NtnxPUMdfqOleR+jfexPN0zfTNdlUNsVEb+2CQzvNflGJUTvpalTIE6Rrt0kYpivR128/a2cKgHUfK/VwYdDC5j4bqYD2eKDfezYqPBd0Y7aUKNwm/HtlfZkIsTGLY48u8kkaOkmIY2YHOUTp5TMMHSVAyMIpC5XvrG6osbbkSZfrVz7mYDyt8C7Px8z+SIVnKEBPT6QSFpEWrpsO4leOn4UjlIyWRkgSbbEdsmQdLDv+43uxQiDlhIzDPiIpZQ2SbYdbIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwSrqylM9/vqfuxhHsDwsdZyuaoVc5xX3CoVotiGFbM=;
 b=RGABfO8vG7sG9SaMV0oCwI1zBh1f/giqcoh7dGDxFqbv9z3s+9X9UIaePOBxo4nFmRvRDlJPDwaLTw67A6Np0wBUebqf9Ewl/7nCPVvQ/JceuBClj88dEDyNkcrMdi2LjPMf4oIpLHJgL9HRqP4sDF5Semaev+iBsLFfeWG3m5ta4+vfxuHlGFhaqUDTXy4Y8mQAfiXKdvci2W746Y2Ki+dQhaHlBAsaV85n/ABDFQNgKeLH71tZL7kicRNGbOadxO5wlSUExNZVcE74EktHUMTYb3Qf7R7XWQAxRmLTg+UNWivMDy3YVp8OO4Se+kdKdTTYpq1TE1kcWTIv2tC75Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwSrqylM9/vqfuxhHsDwsdZyuaoVc5xX3CoVotiGFbM=;
 b=5UlKAcK9BtwgmkE0503+DDD8Gyz6qKUv8wZ4wONqJXoB9lz0L5qc7hfo5P48J1cRNtTn24BwmLItUfcB/Tegepzxf1Ac6f+3cqDsctMguTg+z3IPJBIc/a3J6Rn4t+xi+wMCBS6yvd8mru0tLRr4Kz+Dikv8538nAJHdcm+HdiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Thu, 14 Apr
 2022 15:42:23 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%9]) with mapi id 15.20.5164.020; Thu, 14 Apr 2022
 15:42:23 +0000
Message-ID: <370d8e9d-7050-e82e-ba46-d9716d023829@amd.com>
Date: Thu, 14 Apr 2022 11:42:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] drm/amdkfd: Fix GWS queue count
Content-Language: en-US
To: "Yat Sin, David" <David.YatSin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220413155145.861750-1-david.yatsin@amd.com>
 <e9eb2603-4997-30e1-ce2a-bd3ae0bec7e1@amd.com>
 <DM6PR12MB5021A8149E735B300611A06295EF9@DM6PR12MB5021.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <DM6PR12MB5021A8149E735B300611A06295EF9@DM6PR12MB5021.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::30) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b55e6c3d-a7b2-48ed-ef4a-08da1e2d5e63
X-MS-TrafficTypeDiagnostic: MN0PR12MB5953:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB595327D76338413D3D338CEA92EF9@MN0PR12MB5953.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lsvGubpZ8x5ONBclr/QSGfGUidfwEq1BdovVzOQk0RHMeXmu5jcm/ZKzkzetURZUKd0TnS5VCJ9xCR6BEjVNutEhty0skxOlKqk/n4cCweN8VFjXATo/1E46ImlqglNyqrfO5AKczIJYtfpXJ5zYkxr0F+rXBMoYNr3LdFIDt7/dHLCPQzA4EXDDLV7kXwOqgccE11mg1l9D/SBkaew1DzNzAuoISISxcU/3GKMhlG2jHDOAu2T3JT1SmQhh8U3VzPRm/y204tMfl9kBj++0xLwqo+uJllBZLKcWXivfRRnDQpsutH4RdO88+vaUZwDs8y/BecswAe3SE874/QMTQOsl8SFlocnkNChvDwl0xwCeaKn5oFl8SydFbi1cCzPTw2jh8YpIaxQNrrqPgUF7nlTyXgoPtPACdDrzdrfeK7406XSEppuhTANds/UxxC4S23xO9/fp32tNZQKqXMQFCPynzoJ9rVRW1Xue9SCwqMSsUbpvhGISq4yTHDpGXO78XlgxULtQcMuChnmKFjH5pLWwoyWbZO6wFsksWd+pT+I1sEog7kEcwWkLnSCmX2Zd/LeEiruM35+tEA2v+tyKdRNfVaIVEmfz1Kzul7wQeecxDywmutluGMO8CTTp0zvYgqaOZPPI8tvxMfSP88CBs53MduS0lh8IhHjELXWXNfRQVbd0pCeuBozwMvgExD4djAgtRIorR/izT+rSkR2mqgbYoLc4HR6dxWXJsaSgmv6uhH74UbE2czQxkPZe8Om+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(316002)(36756003)(8936002)(6486002)(66556008)(110136005)(508600001)(38100700002)(66946007)(31686004)(186003)(66476007)(31696002)(26005)(86362001)(5660300002)(6512007)(83380400001)(2616005)(2906002)(44832011)(53546011)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW1ic0tYblVES3IzaWJxaFFXRGgvRDVFdWVZUEU1UDFuSkxyRmV3MmdHZjRJ?=
 =?utf-8?B?blBOVW5hMHQvQTR1RWVFN0JpSTZOQ1pTZTVvV1YyL2lYTTNTcWxkVlFWNTFX?=
 =?utf-8?B?SWZydm1tZTMwNEI1cWZXdlRSa2FONUtuSTZEcVVTUXVpMTVKS2l5enF6emNn?=
 =?utf-8?B?ejFsdjFLdjREQkVlUVY5dEliY1ZGNzlsR213MjV1OHZZUllHVDFHRnZ3dXdY?=
 =?utf-8?B?ZGhoU1hiTURUbEJNb0d1SmdVaEd2U2FhM0tsb0toRi93c1dNNGhqZUdrSXhF?=
 =?utf-8?B?UU8rQkZwU3dOYWc5cmZadVRCMFlmR0dVVW9idUkzYWkyVjRPVXlSZE1Hbkls?=
 =?utf-8?B?TG5OTzMwL0tzR1FaQkwwbGNkaHlHOElPdGt6MjNDN1hnVUo1KzBzR3ExUWxn?=
 =?utf-8?B?aWtRMkRjWjFoOTZuOFZFVmo5Rm8vZ1VDbU4wTEpPY3F2aVI2cGJjaDFvZUtK?=
 =?utf-8?B?L1J6aERsK0JIcGREdXJJQ3Y4NlJwczJ0WGJmVnhzMlQ0V1JoRElCY2dWdGdG?=
 =?utf-8?B?TGFRSGVUa2ZSMnhPVWx1dGRWdS8vakloRmlYTjdNWS95TVNiRjdIMWQ5TWJj?=
 =?utf-8?B?Y0QxcWZ3ckxNUm8wSUx4dzAwWDA5TXd4UlJleS95L0F5MCtwWWdlalFDU2ts?=
 =?utf-8?B?OWd1dFhscGpBYTRRMXhpMjNRa3FmODZmTE9tM0N4WlM2ckNxaUUzSDNXeEI3?=
 =?utf-8?B?cDQ4UTRadmlOcmJCdnNodFRKa3BNcW5TY1dEWkRVcHhQc3RMV0NQNzlueFJz?=
 =?utf-8?B?QjlnNGs3ZVRNR1Y2NWlVcGd0REd4WWlRT01xSGoveTBOS0c5TGtzdFNoUHFt?=
 =?utf-8?B?YUVYSGJ3S0M0am43MURKN0hxMkZHOHMxV3cwaTJ5dHdoc0J0OE0xdEwvanA2?=
 =?utf-8?B?QnhWdlJZTHdldlV5UlpiamxLQ1ZwdnJjdVVTVXF5UlRHNk5WNGJOb0JxSXdW?=
 =?utf-8?B?QVJZRnF1OFk4bG9xcUM1OC9yUkJET0NaWlIyalhzR2JxS1MrODZ1NjJ4eXVX?=
 =?utf-8?B?YzJvOGkxWk9CczJ6Z3cvWnRVN2hpTFBuUGV0UXR0QnJZc2JpSHB5eWpCYVJD?=
 =?utf-8?B?WmpudUpuVGd6dkxtNWd2NFpmVUtCL1hQTHhVZ3QxWllxdmNncTAydmJSbzJS?=
 =?utf-8?B?bEFreGhyY1N0Kzc5TUJ3R3ZXZkVGNmlFK0hBK2lyZW5rT0wwWmxqM3pqcE9N?=
 =?utf-8?B?MDB3RXRINjNrc0VQcHY1VHFqVzhvZjlrUkh3TktVS2NNREVET1NLWGgyS1p1?=
 =?utf-8?B?cTViMG9lY3FSaWpmd0QrSUcxb2RSWS9aNTVLZG92d2hCTmpNYkd5YWNPZGl1?=
 =?utf-8?B?Q0xYbHBxTVZiMzZxQkhRTU10OWJxSkZ3OHlBRTZGL1Z3aHR3bStUQ3RHekZJ?=
 =?utf-8?B?MHFtSUtmdjl3MmExZVZzd0VMNStXZHZpUHd4aVhRMnhIdFdWQ0VRempHY2FC?=
 =?utf-8?B?djAzK3dYOGxlMjYxRG1zV1M2cGd5V3g0UGI3eTRFNjY5SWVjZlVPbmM0ajBp?=
 =?utf-8?B?cjJHcURrWDY3QmxkdFVvN1FBc2RZOWhvVE1UMVE0b2ZzcXgxTFhHVE5JWmMy?=
 =?utf-8?B?OUlQS2JObTlKQmpkQnJ1YWRUN0o2bGpqLzhtTW8rNFV3cE1UZzRFWS93R1Vq?=
 =?utf-8?B?RUd6bHdQZ3FWVU43OHNRdmZzRTZKaGRJaCttMGJOTnFQSzZoMWFSZU04eFdT?=
 =?utf-8?B?aW10WHlINGl6SHNiLzFDeGFjTUxmbWg4OVNNS3BQRzNSVkI5RkZqalEvYUZ5?=
 =?utf-8?B?akxLeWlXVkFCckxrY3FKZHVOT1hoMjRGSHloS2RoZjNOZlpTVWkwbEJQaXB6?=
 =?utf-8?B?UHRyVDRuMGNMWk9Tc0xoVGJxK1pDMFVZVjVBenJNVjJoWWxaMUNNOGo5Q2R2?=
 =?utf-8?B?cnI5V0dEZzNSMlI0UkZDWGk0T3NjYW5QdFpCWnV6VHV0c0FtQjVVdnBzVG51?=
 =?utf-8?B?VU5zdHBzTGpiRzlWbmw1NjNYQzBtNEQ3TTRPdW5sSU1lK1BBend3WUs3ZERT?=
 =?utf-8?B?dGpWUTJYTmQ3RWhidjhGVEZ1RHo3VmVINFM4RlExSllRbXVvQ2g2Y1FzSmIw?=
 =?utf-8?B?Qk5TY3FYWGlvbE02YnZ6M1E5TlBBbVZ2VjdmUGJOcms2clNLSWFPbU1sUDhP?=
 =?utf-8?B?ZVlCZ25XbVg0d0pQVVFsQ0NpOFlTeVQrdThLVVBEVTkzWkJ0NWQ5ZGpqS2h5?=
 =?utf-8?B?b2ZBdGRHbWRuc3dodU15Q1VjMUl2QkhTeW1DdXVFVkkyY1NiaWp1U3daZ2Zu?=
 =?utf-8?B?RjV1MjBnbm5EMUxOR3BDNFVXZi9ibjN1ajhnNnhWck5JT00zSjJZZWxMVCtJ?=
 =?utf-8?B?RVFsRU83UDFNNlp3V1p4Mm1Jdlp0djh2QWQ2MitWVlpORWN2NzNpUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b55e6c3d-a7b2-48ed-ef4a-08da1e2d5e63
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 15:42:23.3565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: flJF2waH1cyPW84PU12lL1RCt/X3Kju+Hqtz4+LvLkWgF2ejlapquZhZusPwC700npgN9TLc6hMW5Z+SZ3dfhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5953
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


Am 2022-04-14 um 11:08 schrieb Yat Sin, David:
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Thursday, April 14, 2022 10:52 AM
>> To: Yat Sin, David <David.YatSin@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 1/2] drm/amdkfd: Fix GWS queue count
>>
>>
>> Am 2022-04-13 um 11:51 schrieb David Yat Sin:
>>> Queue can be inactive during process termination. This would cause
>>> dqm->gws_queue_count to not be decremented. There can only be 1 GWS
>>> queue per device process so moving the logic out of loop.
>>>
>>> Signed-off-by: David Yat Sin <david.yatsin@amd.com>
>>> ---
>>>    .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c    | 12 ++++++-----
>> -
>>>    1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> index acf4f7975850..7c107b88d944 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> @@ -1945,17 +1945,17 @@ static int process_termination_cpsch(struct
>> device_queue_manager *dqm,
>>>    		else if (q->properties.type ==
>> KFD_QUEUE_TYPE_SDMA_XGMI)
>>>    			deallocate_sdma_queue(dqm, q);
>>>
>>> -		if (q->properties.is_active) {
>>> +		if (q->properties.is_active)
>>>    			decrement_queue_count(dqm, q->properties.type);
>>> -			if (q->properties.is_gws) {
>>> -				dqm->gws_queue_count--;
>>> -				qpd->mapped_gws_queue = false;
>>> -			}
>>> -		}
>> This looks like the original intention was to decrement the counter for inactive
>> GWS queues. This makes sense because this counter is used to determine
>> whether the runlist is oversubscribed. Inactive queues are not in the runlist,
>> so they should not be counted.
>>
>> I see that the counter is updated when queues are activated and deactivated
>> in update_queue. So IMO this patch is both incorrect and unnecessary. Did
>> you see an actual problem with the GWS counter during process termination?
>> If so, I'd like to know more to understand the root cause.
>>
>> Regards,
>>     Felix
> Yes, when using a unit test (for example KFDGWSTest.Semaphore),
> 1. Put a sleep in the middle of the application (after calling hsaKmtAllocQueueGWS)
> 2. Run application and kill the application which it is in sleep (application never calls queue.Destroy()).
>
> Then inside kernel dqm->gws_queue_count keeps incrementing each time the experiment is repeated and never goes back to 0. This seems to be because the sleep causes the process to be evicted and q->properties.is_active is false so code does not enter that if statement.

That's weird. Can you find out why it's not getting there? In the test 
you describe, I would expect the queue to be active, so the counter 
should be decremented by the existing code.

Does the test evict the queues for some reason? is_active gets set to 
false when a queue is evicted. Looks like we're missing code to update 
the gws_queue_count in evict/restore_process_queues_cpsch (it is present 
in evict/restore_process_queues_nocpsch).

Maybe the management of this counter should be moved into 
increment/decrement_queue_count, so we don't need to duplicate it in 
many places.

Regards,
   Felix


>
> Regards,
> David
>
>>>    		dqm->total_queue_count--;
>>>    	}
>>>
>>> +	if (qpd->mapped_gws_queue) {
>>> +		dqm->gws_queue_count--;
>>> +		qpd->mapped_gws_queue = false;
>>> +	}
>>> +
>>>    	/* Unregister process */
>>>    	list_for_each_entry_safe(cur, next_dpn, &dqm->queues, list) {
>>>    		if (qpd == cur->qpd) {

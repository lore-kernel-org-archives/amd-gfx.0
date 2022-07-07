Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EE5C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 15:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CF8C10EEFD;
	Thu,  7 Jul 2022 15:54:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAA5B10F1C3
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 15:54:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfVzwt1b5z2veUFsvGcxptZvP5BqoLUVxcIBsnThdPPFK0WxeZyfzXox9TfhfGx0otwxUlpHd7FTAXuIF5s5CvGPxkwNBYRsp7XNS8j/v1VCc0aj0hKgszzcTHCx/FevqpmxFNB6iLV40JMYvT1p81SbwJsQJ6lMJjPBmFPxKtKdjzVdh70/8BwJeNB0o1uXk6tVOcdjqnEwSvk9MfBdiJL5VOhNAYpo6Ynm8R4dPKOEK0QqL0TgqfV9YTLtfMH5ocohuRuwL6QabQ8wmpEtjKz90/xDnA2V15wwFDBOvLt4so69bAZOhj7GwJSGGCfrkMQp9PWN2zW9IClsrNjflw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmlnXvhH9YQGoUMdGOHQNRDwJ6BtvoCbWgK2Uvvo7gs=;
 b=M1gXvz2Z/jxvXjkl11HR8yxB99g9g8rDHOA0BoN8m0MUMBYR1tw6Qpq3siP/7RGHF1tfDt6WZgUGlP792NlpUrLxYGnqK/yDWuR5/RDPnUI9g4wZwqHYx4BBwo2h+nZXN++VOopUeqNwhthNEOvn8DxqWNbPflgt2OibO7sPVIFIIz1CgTWdMivRN8uNsji0gd+5qnI2/T4agBicqnuKgXpVQXD/hROZSkkw8M+oz412FAPCAnqL2MSCM1DYPDcXxaSg/F5vtCngsIcEOL+yCHiKXxKmTJcWRyLhHSiL/w3LmRSVd0+/cFPzoMGnLvN832mONBGcWGlZeklPY4cOYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmlnXvhH9YQGoUMdGOHQNRDwJ6BtvoCbWgK2Uvvo7gs=;
 b=NaQpUVBJnhP48+o2not/KhuA95zWgQfuOyCT094qe23oSCGZMLKPUkdKXHwQzB4RdDdc5YczP6CkxcXCoh5pKy6Dshk7rV1u+13WVuP8pZz/XqLKP6V5/i7P+T8MzZU+Nr5frrhdcIQp+DOl7O6gTzBuqKAmtX0V89xLzCPUVb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4875.namprd12.prod.outlook.com (2603:10b6:610:35::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 15:54:51 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa%6]) with mapi id 15.20.5395.022; Thu, 7 Jul 2022
 15:54:51 +0000
Message-ID: <0ad9d9a8-0554-813f-ab3d-43812e17cea1@amd.com>
Date: Thu, 7 Jul 2022 11:54:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drm/amdgpu: Fix one list corruption when create queue
 fails
Content-Language: en-US
To: philip yang <yangp@amd.com>, xinhui pan <xinhui.pan@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220707102800.8035-1-xinhui.pan@amd.com>
 <a56b3b2e-8a98-68a5-4bc8-6c8a72786e4a@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <a56b3b2e-8a98-68a5-4bc8-6c8a72786e4a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT2PR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba8b1cbf-f97e-49c6-dec2-08da603106e6
X-MS-TrafficTypeDiagnostic: CH2PR12MB4875:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QybrvNAgNxZ/JDCG5SVxYC5NxxIc3oBFFZ/N+evuHVQtXmwoAeNhaf83cza09sgA/EElKkbKvNCWIYnRMnEjzX1mgsfBwZatZICZQT2Xf4d26frzqUNVyAC3PID0CUUtaLrWevrVxMJ4XR+dU8BGRLDTMDb98WZ5MRI20khqpuZCsRaQ1Gx8mTLjT9wOnWEOwcBOPnvxF2qJ08LI+sHuCb9a6ZTIMhPPNxwSdqAlFuOBlSNpM0d7azRlPA38lwDc2ySzC4THFxVWTHul24OmY/LKr1v6vA3D3oTCYd9ECIUrG07KpjynLcMdyeMnkFW3byBgXaYfVPGT/bFCe5NZM4FhWRVrYy7bZcecnf/64KkWO9uhocIgOwYLl5cQy6iRGUh4DpWlMzRS3c0rIL2tW+SiaUS5u7TJ6jVmkp06Pr2MzDUmFQDlCrQ+AYVMV+pPgB8IEHlqurogyiH4wqKJswfMdSp7lNDs9iutN/Gva8HPZvKv+DtGtH0rgWjCOrKgTwW9hbQumtmqvTpSOlLmtejJA3QHWTHDVwilHu1Zem65Gty6KgxTeNcy+iHxVF6Jp1+ARGXWdWds0iCU8Kb4Q77pCIEKNvJmeeGCU0YIsZnkRuvktRgStbT6VuXzw0NK7ZV/1Abx9t+iga3CgW7eOIE4N2EZ3PLxuHlOjffCLcbffvMJ833fEdvmR5PAKRHqYBd3qGW2QnHueJHamN4LtQDF/9sEnf3mC00oSzF7hCbvoURPSgtUvhZmHSk6kI1Dp0raPA2I7NN1wnEbjAIlH5uYs5HejczzGMfELuVs3kbTSXtf0wc8a6K3HyfZhVajKCfE/h/C8ksM49S2d0i6Gsor8B86JPZ/Sc3eHy/0YhE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(6486002)(5660300002)(44832011)(478600001)(110136005)(66556008)(8936002)(31696002)(66946007)(86362001)(316002)(66476007)(4326008)(8676002)(83380400001)(31686004)(53546011)(6512007)(186003)(2616005)(41300700001)(38100700002)(6506007)(26005)(2906002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N29rT1JaU1JPc1FwYWZUZEhUQ1NRTzlGUTlvbDFuR2FUOFg5RllXTnIwWVNY?=
 =?utf-8?B?emViL2xaeW93bHZRME54VEpCd2gyNEV4aUlxRWQyNHdtODlyNlA4Nmp2NmtR?=
 =?utf-8?B?dWl5ZzU3OXNVY2ZpdUVPTTVkc0E0TURUc2FVeTVXbUVsMDFwRXdQM1ZVd3Az?=
 =?utf-8?B?UTZvbk5rdGRkNGxYNkVXbzZzV0p5alRoQkRlemtYTmdCZDdFY2QrK0l0SFdz?=
 =?utf-8?B?eUJDajRjRjk1d29TWi8yeTFEais0TWF0Mkd0RjNGOUo0dGpmNzArTmpyeFhk?=
 =?utf-8?B?SlpwVGFlaTk2dUQ2dDVWZjdjb1VoSU9ZSERXMmY2Q2JXTGdwbmU0LzdMYzlB?=
 =?utf-8?B?cDh6Ykl6YUdYTUhiY3FuUFZ0REdBb1VmZmJFQjA5aGFycFFrK3dXME5LQ3dV?=
 =?utf-8?B?dkVidVczTjN1cXhjK0ZvTVFURytVREJIYkE0OXdyaXp4MVRKeW5reFNYY1lO?=
 =?utf-8?B?Ym1HQ2dMTm56SnNNODkzTmx0TldzZG5Vd0pYWDVwcmRrejI1WmZtWGQ2ZjA1?=
 =?utf-8?B?c1R5N2ZSTlJmZTJVSjdiZXdXNkd6N245MlhGMHVZNTN4TkxSM2c2VUZrSkJk?=
 =?utf-8?B?ajRPMVlaOE9KS2JxbjdVTzlsek56OEpoanM0TzQrdThhSFVFVVo4bFdaNytM?=
 =?utf-8?B?cXVnK2JTWHl0S0ltZnJtc0pocmZxSTVScWpTODJraXY2VFd4eUVicmlibEw4?=
 =?utf-8?B?MEtUaUZOTXpTejhHeHdMMHcrZnp3dG9aUTNjUjgzanh3MEhHMTVoMjVuNjAz?=
 =?utf-8?B?bjhxdTM4UDY4d3ZlTWprTHJncUNiei9lVFpnZ0RPaWZHaU5pMnRTallJbm9k?=
 =?utf-8?B?MTRTajNkcmM2YkxiSzROeWc1WjZRZzB2bFdFZ1Q1VUpicnhPQjZnSjRTelFa?=
 =?utf-8?B?eFo2bGU5T2xyZ3IwYVA1RjZOek1EY0RJZ3AzYXM4T0JjWCtGMG9NSVRFVk9N?=
 =?utf-8?B?QWJPRUFtUzI5N3JnRFA4aUtMQlAvb0ZORmdHandGem05ZnVjL2cvN1k1cUJk?=
 =?utf-8?B?NVRJWnNseXFHSXowbGxacGFPZ2tBU0NTNnpKZFV4UE5ISUlxOFZ3YVBRNmFB?=
 =?utf-8?B?VHZLL2VDaEZQR2tMWDV1ckdrRHRRTEJrdi9MVnZzeTQxODFLRGd2KzY0WE9n?=
 =?utf-8?B?L3FLK25iV084K0NRWjNiSXVwek5TUmlZVmRCMnVyQWRHM2UvVUVkK1Z4TkVI?=
 =?utf-8?B?QTQ1ZklWalduS3ZXSlJUQi93WFR1UXVLRy94Tk91WkwzblZhMzROd2RReVFL?=
 =?utf-8?B?anl4UWZRZGNES3hRaE5lMlU5cUlHSjMzUVhmRjd2dmtDeTFrT0hPUnRRWDhy?=
 =?utf-8?B?VHorbFpmekIraGIzcG9ZZ2IxMDlsS0UxMk45ckx1TVRJOTUyREpzVDhmN0dR?=
 =?utf-8?B?WGdDUlVOcFIyTXdHcHdKWVB6ODFzcUg0MHNKQWxXa0NvMXdDLzFKeXFwMHlo?=
 =?utf-8?B?d01xS1dXelJqaDI1QUVlT1NVY21WcjgraHoxclJpaUdRS2FLRFdHUnBueWRl?=
 =?utf-8?B?MUJqTFdDeU11Um1IZ1lCM1lseWpaRWdrTVRIVFlaR0lvcDNyOVBXbkQvTnhl?=
 =?utf-8?B?WG53M2p3NmlEY1E2d1BvNmVXU0xPQVFZOXRjMUxkWE5WUDgrRURlczlHM1g2?=
 =?utf-8?B?REMrQ1VobGZ4SHpRWWJnUzZteTBVREh2ZGNzNFRKSjI1S2ZKMmluMjlNSGZP?=
 =?utf-8?B?QWJEMmlYak5DaXZFOHV4bUZ1RnRTT2pGa0NGN3VaTkpLY05UL0l2b2RkeEhO?=
 =?utf-8?B?bFVZUkEvcTBmNVhzWUxJSld2YkMzWFZpSkNNcXM5Mkk5RVdJNlZHTEVjVTVZ?=
 =?utf-8?B?ODZJRVIxSHViY0JJemJyOXNxaG55U2xKd2M3bmwvRlRycG5NU2xMb1FqaTNI?=
 =?utf-8?B?ZUxhL3pLUVY4ZzRFNTJJd3k4bElwUVN4VGo2UXQ3N3g3T0N5WTc3T2V0QmVJ?=
 =?utf-8?B?bkcvUWY3RUtTdzlXWnhCMGlEYUo1UmZPdHF0WHMvYzFoelBhbnhhVUtlU2p0?=
 =?utf-8?B?NXRUeG9PZGtzUmhuRU01SHZYWms0MUxjSk9TeW5ZQzEwNTBlcnZGSTl4aUJi?=
 =?utf-8?B?b3VqL1JybWZJdXZoem9Wb01ReWIwQ3dXMDdkcmJkZCtaLyt0NGVndFdJaWY2?=
 =?utf-8?Q?S9mLhlpVZivvgCehHg17de2S1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8b1cbf-f97e-49c6-dec2-08da603106e6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 15:54:51.3380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9BnB+ypEpURUKUaHFDPwwdWOkEm/HHOMV/breeJUa0+sVaQyCX0HEnlam0SPnJfnm/6V1leeuAKoLLpKty1hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4875
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-07-07 um 09:39 schrieb philip yang:
>
>
> On 2022-07-07 06:28, xinhui pan wrote:
>> Queue would be freed when create_queue_cpsch fails
>> So lets do queue cleanup otherwise various list and memory issues
>> happen.
>
> This bug was introduced when adding MES support, as we used to ignore 
> execute_queues_cpsch return value. Cleanup and return error to user 
> space looks good to me.
>
This is similar to the queue destroy failure you looked at. A failure in 
execute_queues_cpsch doesn't really indicate that the queue creation 
failed. There is nothing specifically wrong with this queue. It just 
means that HWS is probably hanging. So this problem will be handled with 
a GPU reset anyway.

Regards,
   Felix


> Reviewed-by: Philip Yang <Philip.Yang@amd.com>
>
>> Signed-off-by: xinhui pan<xinhui.pan@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 11 +++++------
>>   1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index 93a0b6995430..e83725a28106 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -1674,14 +1674,13 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
>>   	if (q->properties.is_active) {
>>   		increment_queue_count(dqm, qpd, q);
>>   
>> -		if (!dqm->dev->shared_resources.enable_mes) {
>> +		if (!dqm->dev->shared_resources.enable_mes)
>>   			retval = execute_queues_cpsch(dqm,
>> -					     KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
>> -		} else {
>> +					KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
>> +		else
>>   			retval = add_queue_mes(dqm, q, qpd);
>> -			if (retval)
>> -				goto cleanup_queue;
>> -		}
>> +		if (retval)
>> +			goto cleanup_queue;
>>   	}
>>   
>>   	/*

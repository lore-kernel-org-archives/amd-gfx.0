Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F051DF531C0
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 18:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9034810E506;
	Mon, 13 Apr 2026 18:51:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KDVyBewK";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011049.outbound.protection.outlook.com [40.107.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DFC610E506
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 18:51:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKLAKyBU70JFYc7IBN0NPfwq1REOTho6XSZdoXoSW+Hykoi/E/r7gjQBIywdjCZteUrwvNtcDH4/SCAHoD38Cmno2eT8HgYIq3oyWOFIdycJjP614MiCw0UnTeZBQLKJE8JizoRe4hJpnNBnYSSwQeacP2wv3vrw57erWXkVrslt/69PIk/9Qd+Pen7YJmU04sRK6r286AfRf+EdiHJmTH/i4QnqSju0TUDslUiDlbi5CAe9sViJmJ1a4IaWaVDfwNG6rAXaGmB7rFNBrDn2sdquRbc2dItxpckJB/gszUB4gWffoutjkIKrgw6up+o29ME96qGRyeXGOgcP6ZVWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXzRhzH9mB3iW07IX8a8wsGxHlkhglGyN8EGPA3bJg8=;
 b=sWSCt04/hSvo6XHizOzCBl7+xp9Pxa3lnuHr5Y978BsW4yUm/LWeZAwqfaLpXiqNbT8abq0fPFoPkYihQihLpJ0eKdUMthkOcaCNNQKV/Zs0YM5pbfCdD4MAkMo/6TqdpbmPtHmxehVFnzbbDTWWVh5SUTIa6bjSZwIh7rJc5R8ho9VRqZteBry7C8dn8YDM1oHA/DyoOQHC6pQVtcYmICiue30QeUM5UDgP2Qp4ZNitHSzXrc1cKAawfM4Y04s7JkmYaBF8RTtlq+OrsgKrjWo1/4vvDvvFokt/nbadEe5G1GVuhC+IE3Rz1SmS83jeKavWwNp5TBlN20oK9pnAZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXzRhzH9mB3iW07IX8a8wsGxHlkhglGyN8EGPA3bJg8=;
 b=KDVyBewK8hMAJMiuO2U3Svjh4d2SQ651fQERnJ+v4c83aGVc1O3zusfNIOW7ADoOa3AUYtfSgeDd4tG38cHYYccghOL5NBd2Z83AZqPDoUwobzEydnslHgdI4JHsDl8ODe4a6e6C0Ah6jAXCloaXawgrzWS2q49FT2aFDiNygDs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.17; Mon, 13 Apr
 2026 18:51:02 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2%4]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 18:51:02 +0000
Message-ID: <e8d8ee99-131a-4855-9c7b-91cdb3a29656@amd.com>
Date: Mon, 13 Apr 2026 14:50:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] drm/amdkfd: Reset queue/pipe in MES
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun.Liu@amd.com, Michael.Chen@amd.com, 
 Jesse.Zhang@amd.com, Jonathan Kim <jonathan.kim@amd.com>
References: <20260324175653.1325754-1-Amber.Lin@amd.com>
 <20260324175653.1325754-10-Amber.Lin@amd.com>
 <CADnq5_N87OnPXugvJJhnKuG4O6NZN5PdxBBYJVYA9nRP_msDyg@mail.gmail.com>
Content-Language: en-US
From: Amber Lin <Amber.Lin@amd.com>
In-Reply-To: <CADnq5_N87OnPXugvJJhnKuG4O6NZN5PdxBBYJVYA9nRP_msDyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0181.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::8) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dd12790-7695-4467-a4ca-08de998d9c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: TYY5WpDngk/+u/AlDStih9GuCRlnH3/Cya7zmAe1SBQHpwkl/whdxFLmVI3MtdsTWu4jY7j8CJecQOvUeMOr0VOVvYwRWS79UqpgLhhJLv4ZNLa7r1Sbmp2p+QZpZmUs75xI1rFn85UxjIefgiw5DMXnkJO7rEOX10Rv823ACvhoXE+vnNesqijCzalB0DjF5zMPkGS7jN4ddxYp4IiAAXHKVmzX31wqkvDOCJ5XEpM/IDahe1P6g5Uvy4ixFvSASupgC4mx1QfJ2RU8x3BpR4x7JilI1sYeduHjNNTd9SiXRijrN5WJf93F7joN6x6YKBAzIkPRr4hoLxKWpgKo/alXaHFVf7UjcBLxPwWv1k7axwdv8wvTnsbE2gLOlG949hcUhCfbXsEqlsQcrr8r8NJVuxwca+0oe2M7a0IqLM5hcst4ifN54VrBKNqQbPBh+EV1uga7ZWvEzhbKHgKMO3Fbke2RHtJKcgpdy495gtoEG+61huc6OshoVaTPOVtlpJVraKv85jlJhzivexfBF02slDA3eboTZHh1YmopIwulrsLGc9If1Z5aE/+Mg8qb/vScTp/WYAzINzdTXRFdEpS/6rLSukntEnDwbs7esmAE9tBXURFYBC5PLGZzGBqI18YyAI6fb63wOsMc9v1r4Sm5uUdShXzZ5qinFtP5a0dxJvGnkHkt1mmfOloGikrklQzyb5JyaTHjiRBFUsGI6r4/0geUUOf1fo1PWVjTBPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yy9mY3Yza1NCQ2kvWWNHK1Z5bkh1dzd4MWN6U1V0ektmNDVodFlXeU9jS0cx?=
 =?utf-8?B?UEhGclNtcDNVU09JVEZBYVhITFc0QmNjYllEZXRseVdMaGJ4UlRKWUZnMzNz?=
 =?utf-8?B?SG50NjdMVEdwTU5ua3VORG00VmNEK2xVaTJJMXdDYVg4RW05U3lPdXFjT2h0?=
 =?utf-8?B?aFZsb2xTOHh4eGtzN1hwamZraWtSQnVvRDBQRmhwbDUyQXFRUzlaWnFFbVQz?=
 =?utf-8?B?R3IyZlh2L2JXOGFHaXRCd2VUUURhMWZuS3FlRVU1QXpNYXNXa1FLbkNJS1lX?=
 =?utf-8?B?cEJ3TzQvaUU3TGVURHdHM1ppSjBSZ1IyNVRMVDhMaFF0SjhFY0Rqb3BXRHI4?=
 =?utf-8?B?b0pZVFNjQ2hxQ1FkWStlNEhPdm5nbXV2TlJHWEVPOXJ5WW9qSkdwdzBqSTFk?=
 =?utf-8?B?UlZXM0lIRjV5elV5cnZQNEJsMGVmcjNFRlBkRER2eS9odTA1bFBOU0YvTlY3?=
 =?utf-8?B?Vno0NXdtTjJmNlVWbXkvMWo1WDBtQk5zcWt6eUl5OER4YlhVR09rZXBzQytY?=
 =?utf-8?B?cUYxWDU0Q25FeFFnc2pwTFhVOVNXK2dlYUlUSTBhMkdta1NSWUsrNVJRcHJw?=
 =?utf-8?B?dDhjUlJtNWUvTU4wcHNaMmRQMFJjaFhoQWhlSGVlNjhWNUo3RFBmZ05FcCtH?=
 =?utf-8?B?SlRhWlBKa08yczRNR2lBVFVZYW5pQWc2NGI0Q2NZUEpTMXJoeWV1aTUxZEFJ?=
 =?utf-8?B?dGNMTW8rR0VuSW1tcUJad0dRalRVRStya0FoWC9mSmU5SkxhalpjQk1sUi9v?=
 =?utf-8?B?M0p5N1EzTkxzT2tlenVndW5yUmtGYkN0RmROWTNkTndFYWM2VXExb2E2c1Ba?=
 =?utf-8?B?MDFKR3JicHZnWjcvSjhYaGRwNE5VY0d3Q0IvQUlhc1VZekV1b0lzb290OHp2?=
 =?utf-8?B?TGJSTmFCblk5U2JwdURBSkpFbHFVL2pqWEhCbmRlb21ZRk1XWXREOVRpOWNa?=
 =?utf-8?B?bzBSV29RbFREdEVCMjA2dis3WjZhMGoxRHN5amhrR1BsS0tORmh0Z2xzQlpC?=
 =?utf-8?B?MzZtcUh0cHJPOFgzWkJFWXk4aFZDc3hzTDdiRXBja3pjdTQybTFHZU1uOEQ2?=
 =?utf-8?B?ckJqOTM2K1kzdmQyOWhnVU9kbHAxbldzemFqV3VkYmNxNWFYbGJlRnlHUURE?=
 =?utf-8?B?cUlEbEdlR05oanBVcm4rblpnb3YycXgwbGNCbWU0NkVmVUhnQThDQUl2eCtM?=
 =?utf-8?B?SWIxQ3RLL3hFQllYdlFTdTVzb09vTUZGVEpSTkllWm5GM2V5MTJzY2hQRDZi?=
 =?utf-8?B?Qmc2L09OcWg5a29SMTR0NE9Obi9SUmlWNmRvaTlhT2NFY2RwOGpQRjVKUis1?=
 =?utf-8?B?RnpjQ0wzVW9UZGEwcmRFazUxNVFNemNreWpwc2UyMGhUbTh1dEo2NmpxMUUw?=
 =?utf-8?B?T2JYUWQ4UjQvekhteHZ6YXF3OEtmTjdBOGdseDBhbWxWdmxVWWZUZU42WTNs?=
 =?utf-8?B?UHVKWUxWSEkrb1JmOGNwcVB0MG5QSi9tVlA2R09kcTYwWUJnUDdURkFqMkY5?=
 =?utf-8?B?TkQvQTlBalkxbHROOGpmVTZyd2U3WER6V0lrd0dpcmRhSWNxN0xmRWhPa0cw?=
 =?utf-8?B?ci9qTWRZT0wwRXp1SDVOb1lwcVR3T1BDZDR4b0tIdnRuRVNJK1V2K3RKSG51?=
 =?utf-8?B?bWhnY1B1UnlVZGRsWEFTS1lHTXdBYXlwdk54VVV2aXFMSEVpUHg3cW1Wc0tK?=
 =?utf-8?B?U0t4NWUxZWdEMnZOc0xiaFg0Vmd1K0VtMHhBVTRMQ3JNTHF3VkFZbFl0RktJ?=
 =?utf-8?B?WGdxWjFpaUpxMFlpcEFNVkUwK0dWakphRTFPK3RFMVVwaGNtd012blJ0ZVVQ?=
 =?utf-8?B?ZGNQT2RYWk4yNVpGNGplMHErUXhzdFhraGlsQjFpbUYrK2JMcThpSFQxSHJI?=
 =?utf-8?B?Sm1mZmdHZ2VxRlplSGtzLzNCblIvNFNuejUzVnRzRHRuSjl6RFhoMlZXcUlk?=
 =?utf-8?B?YS9Qam5RNVV2SkJ3S21MM2hrTXVKREp0aTlleUhUSnJibXRXZzhleVMxRml5?=
 =?utf-8?B?Nno5TTVyWVppVWdVV2k0SHlnYmZybnFKNVJiZEhxR0gvcEdJMjB2dkFhRXZj?=
 =?utf-8?B?SFJzWnN6VkpmWHBOeENmbXg5WnY5b3ZlY1JPWmdDVndBOWdKVGNlbFlMQXpE?=
 =?utf-8?B?YTVBdWRaU2MvS2kyTE5kbDJWWEZLTkU2aTlsdHlUOU10TnpUK3E5djVsR3M4?=
 =?utf-8?B?Z1VqYlZQSkNrcFluemJaU0x6ODN4RFhNM3dheW10WW1iVTFJcUxqMXB5L1Z4?=
 =?utf-8?B?aGU0bldVTWVVMk1LSkdCUGs1cHI4NHZrUHJrSW9aSlBFNExZclRDajF3dnpB?=
 =?utf-8?Q?wRuFJ//b7nTWbocrgc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd12790-7695-4467-a4ca-08de998d9c3c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 18:51:02.5045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KPELbA6dEQJEJR56TGUOT6dinp13O9FYaM3t10U8/sc/qrmvYfkNVQzx6WFAbg/v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232
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



On 3/26/26 14:51, Alex Deucher wrote:
> On Tue, Mar 24, 2026 at 1:57 PM Amber Lin <Amber.Lin@amd.com> wrote:
>>
>> When removing queues fails, KFD calls amdgpu_mes to detect and reset
>> hung queues, then cleans up those hung queues in KFD.
>>
>> Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
>> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |   6 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |   1 +
>>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 147 +++++++++++++++++-
>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   1 +
>>   4 files changed, 153 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index f3a4ae1fd521..7cf4b3d6fc93 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -793,6 +793,12 @@ bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
>>                  amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(12, 0, 0));
>>   }
>>
>> +bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device *adev)
>> +{
>> +       return (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(12, 1, 0) &&
>> +               (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x73);
>> +}
>> +
>>   /* Fix me -- node_id is used to identify the correct MES instances in the future */
>>   static int amdgpu_mes_set_enforce_isolation(struct amdgpu_device *adev,
>>                                              uint32_t node_id, bool enable)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> index 643b4f8d757a..44fa4d73bce8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> @@ -548,6 +548,7 @@ static inline void amdgpu_mes_unlock(struct amdgpu_mes *mes)
>>   }
>>
>>   bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev);
>> +bool amdgpu_mes_queue_reset_by_mes_supported(struct amdgpu_device *adev);
>>
>>   int amdgpu_mes_update_enforce_isolation(struct amdgpu_device *adev);
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index ec8d7f4be840..1c9c350bfffe 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -71,6 +71,12 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
>>                                  struct queue *q, const uint32_t *restore_sdma_id);
>>
>>   static int reset_queues_on_hws_hang(struct device_queue_manager *dqm, bool is_sdma);
>> +static int resume_all_queues_mes(struct device_queue_manager *dqm);
>> +static int suspend_all_queues_mes(struct device_queue_manager *dqm);
>> +static struct queue *find_queue_by_doorbell_offset(struct device_queue_manager *dqm,
>> +                                                  uint32_t doorbell_offset);
>> +static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q,
>> +                              struct qcm_process_device *qpd);
>>
>>   static inline
>>   enum KFD_MQD_TYPE get_mqd_type_from_queue_type(enum kfd_queue_type type)
>> @@ -273,13 +279,19 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>>          return r;
>>   }
>>
>> -static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>> -                       struct qcm_process_device *qpd)
>> +static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, struct queue *q,
>> +                                           struct qcm_process_device *qpd,
>> +                                           bool is_for_reset,
>> +                                           bool flush_mes_queue)
>>   {
>>          struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
>>          int r;
>>          struct mes_remove_queue_input queue_input;
>>
>> +       /* queue was already removed during reset */
>> +       if (q->properties.is_reset)
>> +               return 0;
>> +
>>          if (!dqm->sched_running || dqm->sched_halt)
>>                  return 0;
>>          if (!down_read_trylock(&adev->reset_domain->sem))
>> @@ -288,6 +300,7 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>>          memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>>          queue_input.doorbell_offset = q->properties.doorbell_off;
>>          queue_input.gang_context_addr = q->gang_ctx_gpu_addr;
>> +       queue_input.remove_queue_after_reset = flush_mes_queue;
>>          queue_input.xcc_id = ffs(dqm->dev->xcc_mask) - 1;
>>
>>          amdgpu_mes_lock(&adev->mes);
>> @@ -295,7 +308,13 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>>          amdgpu_mes_unlock(&adev->mes);
>>          up_read(&adev->reset_domain->sem);
>>
>> +       if (is_for_reset)
>> +               return r;
>> +
>>          if (r) {
>> +               if (!suspend_all_queues_mes(dqm))
>> +                       return resume_all_queues_mes(dqm);
>> +
>>                  dev_err(adev->dev, "failed to remove hardware queue from MES, doorbell=0x%x\n",
>>                          q->properties.doorbell_off);
>>                  dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
>> @@ -305,6 +324,12 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>>          return r;
>>   }
>>
>> +static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>> +                           struct qcm_process_device *qpd)
>> +{
>> +       return remove_queue_mes_on_reset_option(dqm, q, qpd, false, false);
>> +}
>> +
>>   static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)
>>   {
>>          struct device_process_node *cur;
>> @@ -359,6 +384,103 @@ static int add_all_kfd_queues_mes(struct device_queue_manager *dqm)
>>          return retval;
>>   }
>>
>> +static int reset_queues_mes(struct device_queue_manager *dqm)
>> +{
>> +       struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
>> +       struct amdgpu_mes_hung_queue_hqd_info *hqd_info;
>> +       int hqd_info_size = adev->mes.hung_queue_hqd_info_offset;
>> +       int num_hung = 0, r = 0, i, pipe, queue, queue_type;
>> +       uint32_t *hung_array;
>> +       struct kfd_process_device *pdd;
>> +       struct queue *q;
>> +
>> +       if (!amdgpu_mes_queue_reset_by_mes_supported(adev)) {
>> +               r = -ENOTRECOVERABLE;
>> +               goto fail;
>> +       }
>> +
>> +       /* reset should be used only in dqm locked queue reset */
>> +       if (WARN_ON(dqm->detect_hang_count > 0))
>> +               return 0;
>> +
>> +       if (!amdgpu_gpu_recovery) {
>> +               r = -ENOTRECOVERABLE;
>> +               goto fail;
>> +       }
>> +
>> +       hung_array = kzalloc(adev->mes.hung_queue_db_array_size * sizeof(uint32_t), GFP_KERNEL);
>> +       if (!hung_array) {
>> +               r = -ENOMEM;
>> +               goto fail;
>> +       }
>> +
>> +       hqd_info = kzalloc(hqd_info_size * sizeof(struct amdgpu_mes_hung_queue_hqd_info), GFP_KERNEL);
> 
> We should avoid allocating memory in the reset paths as they can
> deadlock if the kernel is waiting on the reset to get the memory
> needed for the allocation.  Can you preallocate this somehow?
> 
> Alex
In v4, I pre-allocate the memory when KFD starts scheduling and free it 
when KFD stops scheduling. In other words, hung_array memory is 
allocated before user compute queues are created.

Amber
> 
>> +       if (!hqd_info) {
>> +               r = -ENOMEM;
>> +               goto free_hung_array;
>> +       }
>> +
>> +       memset(hqd_info, 0, hqd_info_size * sizeof(struct amdgpu_mes_hung_queue_hqd_info));
>> +
>> +       /*
>> +        * AMDGPU_RING_TYPE_COMPUTE parameter does not matter if called
>> +        * post suspend_all as reset & detect will return all hung queue types.
>> +        *
>> +        * Passed parameter is for targeting queues not scheduled by MES add_queue.
>> +        */
>> +       r =  amdgpu_mes_detect_and_reset_hung_queues(adev, AMDGPU_RING_TYPE_COMPUTE,
>> +               false, &num_hung, hung_array, ffs(dqm->dev->xcc_mask) - 1);
>> +
>> +       if (!num_hung || r) {
>> +               r = -ENOTRECOVERABLE;
>> +               goto free_hqd_info;
>> +       }
>> +
>> +       /* MES reset resets queue/pipe and cleans up internally  */
>> +       for (i = 0; i < num_hung; i++) {
>> +               hqd_info[i].bit0_31 = hung_array[i + hqd_info_size];
>> +               pipe = hqd_info[i].pipe_index;
>> +               queue = hqd_info[i].queue_index;
>> +               queue_type = hqd_info[i].queue_type;
>> +
>> +               if (queue_type != MES_QUEUE_TYPE_COMPUTE &&
>> +                   queue_type != MES_QUEUE_TYPE_SDMA) {
>> +                       pr_warn("Unsupported hung queue reset type: %d\n", queue_type);
>> +                       hung_array[i] = AMDGPU_MES_INVALID_DB_OFFSET;
>> +                       continue;
>> +               }
>> +
>> +               q = find_queue_by_doorbell_offset(dqm, hung_array[i]);
>> +               if (!q) {
>> +                       r = -ENOTRECOVERABLE;
>> +                       goto free_hqd_info;
>> +               }
>> +
>> +               pdd = kfd_get_process_device_data(q->device, q->process);
>> +               if (!pdd) {
>> +                       r = -ENODEV;
>> +                       goto free_hqd_info;
>> +               }
>> +
>> +               pr_warn("Hang detected doorbell %x pipe %d queue %d type %d\n",
>> +                               hung_array[i], pipe, queue, queue_type);
>> +               /* Proceed remove_queue with reset=true */
>> +               remove_queue_mes_on_reset_option(dqm, q, &pdd->qpd, true, false);
>> +               set_queue_as_reset(dqm, q, &pdd->qpd);
>> +       }
>> +
>> +       dqm->detect_hang_count = num_hung;
>> +       kfd_signal_reset_event(dqm->dev);
>> +
>> +free_hqd_info:
>> +       kfree(hqd_info);
>> +free_hung_array:
>> +       kfree(hung_array);
>> +fail:
>> +       dqm->detect_hang_count = 0;
>> +       return r;
>> +}
>> +
>>   static int suspend_all_queues_mes(struct device_queue_manager *dqm)
>>   {
>>          struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
>> @@ -371,6 +493,9 @@ static int suspend_all_queues_mes(struct device_queue_manager *dqm)
>>          up_read(&adev->reset_domain->sem);
>>
>>          if (r) {
>> +               if (!reset_queues_mes(dqm))
>> +                       return 0;
>> +
>>                  dev_err(adev->dev, "failed to suspend gangs from MES\n");
>>                  dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
>>                  kfd_hws_hang(dqm);
>> @@ -2137,6 +2262,7 @@ static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q
>>                  q->properties.queue_id, pdd->process->lead_thread->pid);
>>
>>          pdd->has_reset_queue = true;
>> +       q->properties.is_reset = true;
>>          if (q->properties.is_active) {
>>                  q->properties.is_active = false;
>>                  decrement_queue_count(dqm, qpd, q);
>> @@ -2203,6 +2329,23 @@ static struct queue *find_queue_by_address(struct device_queue_manager *dqm, uin
>>          return NULL;
>>   }
>>
>> +static struct queue *find_queue_by_doorbell_offset(struct device_queue_manager *dqm, uint32_t doorbell_offset)
>> +{
>> +       struct device_process_node *cur;
>> +       struct qcm_process_device *qpd;
>> +       struct queue *q;
>> +
>> +       list_for_each_entry(cur, &dqm->queues, list) {
>> +               qpd = cur->qpd;
>> +               list_for_each_entry(q, &qpd->queues_list, list) {
>> +                       if (doorbell_offset == q->properties.doorbell_off)
>> +                               return q;
>> +               }
>> +       }
>> +
>> +       return NULL;
>> +}
>> +
>>   static int reset_hung_queues(struct device_queue_manager *dqm)
>>   {
>>          int r = 0, reset_count = 0, i;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index 27e4859e4ad7..6cb33f6d71e2 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -523,6 +523,7 @@ struct queue_properties {
>>          uint32_t pm4_target_xcc;
>>          bool is_dbg_wa;
>>          bool is_user_cu_masked;
>> +       bool is_reset;
>>          /* Not relevant for user mode queues in cp scheduling */
>>          unsigned int vmid;
>>          /* Relevant only for sdma queues*/
>> --
>> 2.43.0
>>

-- 
Regards,
Amber


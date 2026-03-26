Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B8A10AB82A
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 21:35:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 054A310E30F;
	Thu, 26 Mar 2026 21:35:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MY7q7Qkm";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011024.outbound.protection.outlook.com [40.107.208.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFD3B10E30F
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 21:35:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sy2km2eR0ZLjvOTm+uz+MbIF7U5OeVGNWQom1jHigqkr7LJxEpD08kAEAKLW26aBojbtL2yN/SO6SDxaEb2QUT+eFP6qdocq8T+OmPBil/lR5UCLiG7LFaKF6Xpvep7Z6otzNkR+q6giKRfUGdr60eIWQNlm3X66jQbYmUQ3dDcEPQaenCcYcWGnS6YjthnlPFfIFaQNlYxn60jARnk7DFlxJYKbEuAttOMKvf4+XXNONoTSNr2o8EkE/3ZBW6z1ubY9ux6TPFHzMRVHVm2JIEepP4TUR6p1YC3qXeDvaqIvMLPh0D5J7AIv+HVd4OSAOaS0pgECXVFiitjUygy1Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X4KlnSiylxyjZWP83TNXu6Ao2G8k0kUXCVJ3vwGi5eE=;
 b=FL8k0cHl9oxhYMjI47h0Dh28/sAQQUAQCRp15eM/93OH52riYyE99zBBhbro7XTG6IS3YGs7LehGW5m84MscVsDNeZCXajoXl1HMhjn5bIhX1XzK00Z9lll1FDXcbRSqYTynmtv/KH94F0hEWmvlFLLssjzEWCPvOpOACreanQQlu4HRqh8rvy+tby2n+PIw54Rnq1DkSCcLyMBev4zxzPN1H6d+NTqi5WlPCm6Vo+9y1DSWIxwKbidpV5vUE29VJXPZFMSuWCo1rzIImK8hRVvNbOrMp+lkar5yYzt6u8mvZIXNAW4mCHOGXQoj2Vw4WD2i1jSc2ICDzmWOXmZrww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4KlnSiylxyjZWP83TNXu6Ao2G8k0kUXCVJ3vwGi5eE=;
 b=MY7q7QkmLeOFezGPLINMcgxCQqOAvvE0NED8xEteBuDrC2qdif+uDpQgPNM8dWHr1kPnIoZBX40+GPVfCahK1osjG9Xm0YYHFGCNE7DnMk7cVAfZKD7B5jQMXzrttfmJlLo4n4w5QVt3oYR1st240Vy0XoYCBn3q8PdaCFcdVVQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by PH0PR12MB8032.namprd12.prod.outlook.com (2603:10b6:510:26f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 21:35:14 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2%4]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 21:35:14 +0000
Message-ID: <a306ce23-3f90-439f-aec2-17f43133371d@amd.com>
Date: Thu, 26 Mar 2026 17:35:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] drm/amdkfd: Reset queue/pipe in MES
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun.Liu@amd.com, Michael.Chen@amd.com, 
 Jesse.Zhang@amd.com, Jonathan Kim <jonathan.kim@amd.com>
References: <20260324175653.1325754-1-Amber.Lin@amd.com>
 <20260324175653.1325754-10-Amber.Lin@amd.com>
 <CADnq5_N87OnPXugvJJhnKuG4O6NZN5PdxBBYJVYA9nRP_msDyg@mail.gmail.com>
 <8aa62deb-df7e-4a3e-8303-67d050495998@amd.com>
 <CADnq5_Ns2JEfdGHtFBzkHp5+01hpM=9SLnwxFz4dpt98DrzdzQ@mail.gmail.com>
Content-Language: en-US
From: Amber Lin <Amber.Lin@amd.com>
In-Reply-To: <CADnq5_Ns2JEfdGHtFBzkHp5+01hpM=9SLnwxFz4dpt98DrzdzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0083.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::19) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|PH0PR12MB8032:EE_
X-MS-Office365-Filtering-Correlation-Id: e17a1d5f-c6ff-42cb-d8c4-08de8b7f90e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: PUVu89mtJjtQlSEn0tIMvtN834cb7PbHryTUBYbhk/ndxGDWHyW5Kj+hbdTMkarPNwA/LaQ6n/96XmqU9OV6Htpe1pDgEw6UmGNiUeBgfY2FKZjKF2tiQYzgp53T3QH9XiFXZDOFLr/Dd8ZvLbxAztb9ljfPMM0YzKr/vn294hx7uIg0J2XMzUKBxJe9IrxfOlNxYc0Gpb9M0zHdJJ7PioLu/QSL7kLXcOAOXfmMYDjea5RZLY2OxjdbAap5kqHH0HEZgzBKELAQag7AbSQRZF+63exxsrh5rjq/FRy9YMbEXYpA1QmsZHoqTMD8yxF5fdP8GdzVd4Y7P/IMuBCpZtxnviOUfSnu3ttCKvGZdZ8kbM4CfV6YThaQUIn38Mw7hwyPUn86CegpmvQ71n2sb4oc87cjxL/crhmSO/HpmywLW94ByCZ4H0wEZnLrGHDxUnVTZv3XXl6/4Zi3avpfvKpVMWJBxNSZufOTNVf7FJvordy6K4ReR8rwkF/f2Mk7+o9hZ8MdBXv9yyOZXAiS6xH9O6thxSIeBKGQofyDpnTTkHntdN1BYeeCJie9apBRTk+SgpKE30l9SO2BcKMwLYqu1E4v7yUxsPlufU/97RYKSrovUY4U1S9caVazZm5QD0G9Qjk0BJUysOAX2LdmtVJtAl2A2SL1Nn7zo3uE05/SMiW/qo1f3hDpt0Og2F1z7mC003dNHOzJeRtZ2iwRJbP8nWRNiRHnZekxONHqtTE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjBIME44aThEem42VS9LVnBJZ3FGcHYyUHMvL09iWm5KakZuTzVNdE5aWlp1?=
 =?utf-8?B?MDd2Y1JwdkRwSkNZQTNiZCs3aEdHbjN5dlUrMU9zeFNOV3B5ZXpJQVY1eVhT?=
 =?utf-8?B?KzFaejR5eEFtVkRvcVBDZkNzb1BwNUpycWVMclNBb0t2V3VwSFViNXl1bmt0?=
 =?utf-8?B?Q09uNFlHaE84SEtMdUVETU54Z0ZQLzk4WC9najJXdU9JSGNBbzlOS1U5TkpM?=
 =?utf-8?B?dkZVcnpLSkgxSGpQY2pvdkErV2kwTkdjNkpDN0hwQk5yNFZhTUZCVGR2NVd3?=
 =?utf-8?B?VmE1ZE9od212MktLd2xWd0owdHgwZ0wwOWMxaTM2cDB6N2llMmNvZk5lNTUv?=
 =?utf-8?B?VzhYT2ZYaThrMWxtWnUxQVN2WmNoWGtmQkpQOVlacTIzR2FMM2VOQkxZRnRn?=
 =?utf-8?B?aGYyY1FITTNxVGNxVzN0S0VkNmVuTGFZeDdXS3VGUTArSGYvMVhMTUZSTEZi?=
 =?utf-8?B?RmFZd1I4UHJEL1kwSlpYZ1MrajhRUHVndThucVQ5Vkt0MEpBYmdOL2VxM2pW?=
 =?utf-8?B?dE9FR1BabGpZaXhaWmgwcVIrczlUMzQxQVE4N1dZc1R6ekgzUFh1NXpCd0Jz?=
 =?utf-8?B?QlJ0U29JeWpkNit6bkIwZGlRU0lCMVZoNlBSVVBpVm9FaFc3cjMvRUV4aXlq?=
 =?utf-8?B?VjZmbm4yQmRsVytTU2RyR0loRW5oVmlEUm5KQlZJLzVGaG9KQWIrU2lqSGtS?=
 =?utf-8?B?TlJ3UVdQQ1lQa1ZYZ09uZzVrbm5FZ0NIdzF4bmk3RXRmS0NxZ2ExMlg4cHZl?=
 =?utf-8?B?RDdHL1E2WTZHakhzSUhRVWdhelMzTVRXcm9yQXU5dFNQWkhzOS82SHZNOE1y?=
 =?utf-8?B?NHFuZ2VySDNiWktKZWRNYTV2ZEdad0FvOTZJaUs0amRXMzdtOFFKeHlscnhW?=
 =?utf-8?B?OS9HRHNlcm1ncnE4cDBaMWpyY01rVk9UMEhmUkdxTlI4SlBtRkoyTE9EL3dN?=
 =?utf-8?B?QVAwYnpaaGtYbGxvS20ycGlhd0dBKzQ4OVpnTmJiN2UreVZ2VllrNWxoVktM?=
 =?utf-8?B?SC9jeHJ5UzdpR2llTmhyN3IwMjAxbTBONUVOaUozY0NYV2c4bXVPNmFWUmtB?=
 =?utf-8?B?cm11OGpjZWphWU9OOUdMMkRNUytOTkZUTGtwTmprOXR5QUgwbFRkVHhwa2Nt?=
 =?utf-8?B?aE1zOWVNZWIxNGxjSjVmZ0tCSkx2VzhCYk01UmJ3c2pOa2EzdWYvK1A5VmxP?=
 =?utf-8?B?dTQ2Znkvb2JYVUhGUklsN1FYcnJnYXpaRCtYWXEvSlRlQ3A3Vy9QanB0bHpz?=
 =?utf-8?B?RnZLWDl2VHR4bWpRK3JHRE9EKzJodWMzSkthcXczYWdFS2pxNjZyY2FZdStO?=
 =?utf-8?B?cUZPbnd2VGVScGM3OTdPeGM5NEdYM1FzbFR1L3EyUHZ3NjRPZkY1cmoyay9x?=
 =?utf-8?B?VGNvQjJiYjUzUTFZK1JLMHRIN1BXOFB3RDhIT2I0cTNDUTg4WXBHb3lKblNO?=
 =?utf-8?B?cU43cXY5dnpWYThtZ1JvVFZYWHV4RU85NDdSb3dsekczdnBNZ2RUdFNucVho?=
 =?utf-8?B?dG9lbG5KS1dnbnpaMWh4Y0NQbEk4T01kT3dsbGFyK01BM1BtdHlIK252NmQ1?=
 =?utf-8?B?ZmRka21ZVVBUR205NWFzc3pjdWhpMTVVc1FGY0RtUGR3NVovWERnUUora1pG?=
 =?utf-8?B?b3BRTXU3cE1BSjM2N3JxR1FrSUlTU2xsRFVQMmNkVkdLZ1JYZWUwczY0M1Vr?=
 =?utf-8?B?SUhXWERLRFJVTFBuSmRYSm9KTUdFcjRkeHZNUytMV3VoanpjTXZ5SkhkdzV6?=
 =?utf-8?B?dVZBcmZXU1dUUHFQT2oxWDhqYVpsaTFyZDhwNkpNbkZaRDYyMmhRRGY3U1F5?=
 =?utf-8?B?RnY1KzFFc016aSszSnVmRmRMZ2t0VnRZaC9EcmxCMXBtTktVMllmVTdQcVpH?=
 =?utf-8?B?aDJwRmx0blNOOTZaNTIyWGxGZDlYTCtpSVhBSXRZR1ZoUHBFWDQwbVRqeE9m?=
 =?utf-8?B?cDAvTFdETjFNbC9VMm00TjZremcvY0h3VDBMTHlTZTJWVi9qV2dUb25qSjRS?=
 =?utf-8?B?dnViemxxSnlzNTgxNmVkaDBrR2RtVlVBSUdpR1VVQzN1Qm4zdmNQOFFVS0o5?=
 =?utf-8?B?YkFBR1VjMDk2Z0t4SnQxK1lvUUtralE3ZTdQNlh3N2tBNlpDYnJLRGZpaWY2?=
 =?utf-8?B?bzNWY1FLRXpVV3ZDU0l2dVJnUUtUaUYrRS9rV1UzNkRZMFFYamVqaVo5cVV4?=
 =?utf-8?B?SlpReXJBZmtwRGVzU0UzR3FrWWpZSEgwTDEwcHJYOEpBekFxWUsrSzFYbVpD?=
 =?utf-8?B?eGZYOVVIRFdXdk1pUEVTM1gwbStiQnNaTDR0Ync5aXRYSTBLN0JNck9WWnZT?=
 =?utf-8?Q?HGsDXiNzEDJ5fmVrJ5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17a1d5f-c6ff-42cb-d8c4-08de8b7f90e2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:35:14.2851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+wdnUKYZM4/livQkgddo/LOnKY2svHhm5pfAQDS8pdpEaqG5DzUM0XWd2saoGl0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8032
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


Regards,
Amber


On 3/26/26 17:08, Alex Deucher wrote:
> On Thu, Mar 26, 2026 at 3:40 PM Amber Lin <Amber.Lin@amd.com> wrote:
>>
>> Regards,
>> Amber
>>
>>
>> On 3/26/26 14:51, Alex Deucher wrote:
>>
>> On Tue, Mar 24, 2026 at 1:57 PM Amber Lin <Amber.Lin@amd.com> wrote:
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
>>
>> We should avoid allocating memory in the reset paths as they can
>> deadlock if the kernel is waiting on the reset to get the memory
>> needed for the allocation.  Can you preallocate this somehow?
>>
>> Alex
>>
>> I probably misunderstood the concern here... When we allocate the needed memory here, reset process hasn't happened until we call amdgpu_mes_detect_and_reset_hung_queues below. amdgpu_mes_detect_and_reset_hung_queues is where driver prepares the detect_and_reset input and then submits the RESET packet to MES.
> RIght, but we've detected a problem at this point (failure to remove a
> queue).  Presumably we tried to remove the queue due to some external
> factor such as the kernel asking for memory.  Once that happens the
> kernel may be stuck until we complete the reset and the memory can be
> freed.  If you really need to allocate memory, you need to use
> GFP_ATOMIC.
>
> Alex
>
I see. Let me look into that. Thank you Alex for the explanation.
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
>>
>> Here is the amdgpu_mes_detect_and_reset_hung_queues
>>
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
>>


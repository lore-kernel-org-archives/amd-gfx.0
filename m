Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 877F4F531C3
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 18:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D184910E508;
	Mon, 13 Apr 2026 18:43:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KcgbXdrm";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC05A10E506
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 18:43:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfeZEjS/vevCDWwa1klBKZPsKKqmv+W5BauLfs5v53Jt0dxQui5VtMNwnelUV7rZEfSij2pZLlffHDQakSx5vGcwB+EKK9aC5pYkPmvie/PNW60sklKIHbYY4/V+fEB0BXcQyDc/byqVoLM8r5CcVFrA4SRPOonXpkB2nYjDWxz5wWugM16q/9XapwTrP130NpGiNuiL7lOAZU0TyQoa9luHhiIukvBYTTbdGxxw1lpl4usfvbqZJakFeSkI3yJbE3K+6iVQhQ7rBG+u7Ec9MVjWN5XjqgadOgXTM25LiJmN6N+XzLHE1u1WcaSaayWhm+1CicA8I3IHxagvPS2wog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flE4i4864ddT0wB68ocDfJGyezu0Msp/a3Y5CNTB29U=;
 b=xWbxz2/nu+jHsYJh0iQrTB3Xs5CglR+4ivrYtYoj5NGD3uTVmdLZzpvPBzfo3DnaJhPEFKYVJYeRkc12HfGoEzoJpT9MJ6k/8uG1/faSEEVOUrmeXgRBAauzT712yH7U+25No01Y+F5+zP2PumwKkksVP7HY1ovguI1OUv5Satkv8GOKE0Ff+hHMiWHPGV5Q0TAStutwIzrYm1WD0FaevnAk+NpSPTTFdHYHMod11uoKm+5Tr+tG1IhpI6EzAjUm9HALwi6z+mwpgy082l6elOf46P52c8wra5nYRVpDqH9XVdeiTojqr7DnWByUTbb52JvvU78kJjpFME0/Iz8/tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flE4i4864ddT0wB68ocDfJGyezu0Msp/a3Y5CNTB29U=;
 b=KcgbXdrmqqwA12q/06SzIozz5RJznGc89E9B3R7Oq8KFQ6eaZYlnHUxSz9TBMRpjzcbRLH1YjojXEcrKfOPNcVWfW+8nCzTJujfTFwsSOzTeMP/dXDXCEzhYeIVtE3m0K23OaoL1O9ZxKwxm0xN4q62sXHTmjEjJDsFu6svJoRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by MW5PR12MB5683.namprd12.prod.outlook.com (2603:10b6:303:1a0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.17; Mon, 13 Apr
 2026 18:43:22 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2%4]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 18:43:22 +0000
Message-ID: <f5f1e51c-42b8-45a8-a2b6-ee5b5ebfd7f9@amd.com>
Date: Mon, 13 Apr 2026 14:43:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] drm/amdgpu: Create hqd info structure
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Jonathan Kim <jonathan.kim@amd.com>
References: <20260327203152.1578828-1-Amber.Lin@amd.com>
 <CADnq5_Pm1ArB7odhzTo7Ssc+BX7z0wn+AyjotWcbjmxevE8UDA@mail.gmail.com>
Content-Language: en-US
From: Amber Lin <Amber.Lin@amd.com>
In-Reply-To: <CADnq5_Pm1ArB7odhzTo7Ssc+BX7z0wn+AyjotWcbjmxevE8UDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQ1P288CA0001.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::8) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|MW5PR12MB5683:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb0a113-a201-46d5-9db4-08de998c899d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: E+8b0Gt89uRpoAdAcKMheSMQ73YzXEWTjBr28vy41NGtR+CEr9eF5k5Xpe+aeRl+1yPZHn1InONm3a1oXs9RfuVXj7R97mZtpcwBPiFAzgdd0pIoZSu08XiRr0I2GgXUiy6ATZ8QrxhvgwUoTCJirpFzSf06KC3y2IWfltM+mQNnFVtW3kvoggRUHrfSc7vjtA+3cooJ5Lj/ClJ+oh4rX2t1X4BotPbkXUuWrWLlAsblIeEysjSijDpiUN3OjOSBvWU722ADfF9zJ8eswlaTFlb/QKucoUn0F2IjFd7zXx3x0tTjYPqSLu2qMldwKIiIQ7dh65ErtmBGj2YQSauKMvJJ6rAuCJEcB6HIWFH5Si74HxyTL9A3fD0NBTWNXmh24kmVBHCIehdqIHqtBm6fbApGuekTd2SwdV8Pi/IU9g+4KGUDEtOsMhBmWywu9gXITUJnkYZF50MxwrApxqnBSjnCpbV0MycpraOCGmTNAeQXf8EAEgiAV2bk33Mn89SW9eolAFwn4ANMEyCcboweLup1E1aN2Mr4h/p3aH+vl28bzP0jcQttkTeDaUgIIQ5okeAMIlF0vLzo4AzmPVvC1ZB2fa4gZGo2t8A/g/v+5Qtu3/K4bfzxWraFFvEZpH9HjeJozgD+UYnXZseNr4ADl3Rfx2GSX3ZaO6c9LNfvajlwh6+X3wR8LkWZuSsOiUGU6FxvzP3tjJXMXzmSuwyKJ7oYlwdny1WOxB8VgHY3Gbg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVJyTkM5YU8zcWdqWjRoZG50NWgwYk94angrWFZhNmpZTTF0UjhkeXZhM2RY?=
 =?utf-8?B?ZG1NUW90RVZyTWpIak83ak5pSFlyeXF6WnBlSWxpMGh1Umkrc21HdzB5Ulhp?=
 =?utf-8?B?d2hJa3Y4UUNGWmZ3M1dlS0NiSVNGUkpSbUJ1aHZLVGNoOVlwV3hjTjJ0ajRr?=
 =?utf-8?B?Z2F1ald2UHE4NjF1MnBUNGpKV2h2bGhDbTJkR0xady93TWR5bmVmSTY2eWpm?=
 =?utf-8?B?ZWhQb3F6VnNtdmlnelBZVVRLb3plRjJ1UXFqaDd5RGpJdnQwVmFOSFVTY0o4?=
 =?utf-8?B?T0JYU3hqK3RMNmhKL0F4TXhCYkIvbTArTkR2eEgvNjBrTGtMVmNJR2xTdXZQ?=
 =?utf-8?B?U01Fb1RPckowRWlWbGtNM01JRDlmbDVNdHQ0aTZWUUlxVUNEYmsrTlhyaEU5?=
 =?utf-8?B?YTNoeTdHTzVJN014aDZYYlIvdWo3aVgrN1NVNlFFUVdmZHRYNVpLb2szZ000?=
 =?utf-8?B?NmptYWd2c0I1NTZMRHA0Y2NLcUJFZFBhWDlXVk9kd2QxMFZhTzFJaUJBR3No?=
 =?utf-8?B?YWMwc0d3anNVcDZjZ3lIWk5HY3RmcTA1Wm4xY3RqTVpHOWJ2Z2xKQWZOd1Z2?=
 =?utf-8?B?a3FyR3VGdkpwNWdHN3BDSkQ1RDAxcHIzZTBIVnV6dys0MGdMNDN5YkhhelFW?=
 =?utf-8?B?Q1FQL2Y4OWJJTDE4dm5UbzRnREdBNEx6S25HVEZMMG8wc1UvVXVwZXJ5RlVy?=
 =?utf-8?B?NTV1SFk4N2pjTkU0czdnay96OUlmclRSOVh4QkRqRW51cVdpVzBoL2JiTGd0?=
 =?utf-8?B?eDVjaGtlaHFsU3UwYnRxVUY0dndLazJiV25MdUF2a1V5Q0hLS0s0eVN6ckJU?=
 =?utf-8?B?eVk0ajVVckVpWGN3UWVVZzZTTlIrMzJQSVh3cHFxc1lSRFZJYUlrQjVtWDhH?=
 =?utf-8?B?cU1DalFqaEUxWU5jMTZOMEl5UW12RDZkU0tLUmhGb3FCWTY0MXVRVGFMbWht?=
 =?utf-8?B?ak9JeDBpZGZMUnIyVVZMR3hTTXZLa3p4TTNnd3VrRk9DRW9QTElXWWpLdWVY?=
 =?utf-8?B?bmFPV0RDaWY3RG1pUE8wM0JxZUs1dVJyU0VsVHc3NHphaHNxZldwU29LMmRH?=
 =?utf-8?B?aGRCUXo0Vmd0bVlNeDhxZUl6eHFqd1VRcmw3eEl6MGVueXNBSEE2T2ZnMnk5?=
 =?utf-8?B?VFNObjczN2VSRWhVOC9xTkNSMy90YnVLNUtTU05LclRST081UEw5aDZIdzBs?=
 =?utf-8?B?V3V0SlZzayt3a3JsaURRRGlFRmV4MkNsaTNzd0Q2R1huaUFtMEJFOTkwckNn?=
 =?utf-8?B?aDBqRnUydGR6VHlnQjRQai92SU93RkI2YjE3bThyMWV0a0VHWDEwWDhaTlp5?=
 =?utf-8?B?ek9HZld3RHl4bkFkUmwrZURCb3hoTlVzYXVrM29sa1JpNXFndXdGbytJMmZj?=
 =?utf-8?B?cFpnQ1Q4cXBxaWhiNUtQTUZyV2hMSTB5TXFpWUtjb1VpWlN0bFc5MjkySnc0?=
 =?utf-8?B?UThMRlhueXhoZmx2dlN5QU5Pc0QvRUVxMnlmUFh1ZThlc2oyZGNYWHkxd2Uw?=
 =?utf-8?B?aU9JbkJhbTZUdnJHcDJHUW9WQ2VlZEcwc1IxS2JGTTZDcnNadUpDbHBTQkZx?=
 =?utf-8?B?OS9IK0JSQjJncWNjQU1HT09jOGxtTmN6TGt6bTd5ZElnek1PdkNVUitvSTg3?=
 =?utf-8?B?eThOQ0pyeHV1Tk1naW4xRERkaFIveFVMOVNLSlJuUnA1ZUcrQUQ5VGJ2azdT?=
 =?utf-8?B?d1NpaVhWZ3FMTzJKLzBGajNockJOM1VraTl1Q1ZjYUh1KzY0eWhhN1YyTGdW?=
 =?utf-8?B?Y1hUaWVobnRyL3psdi9LdDNDazV4Z2JsVUJvTlFkVUVnWmlrdzF3WTBHMm02?=
 =?utf-8?B?OFUrd1loaitrRHJoMTRnTzVlSTd4Nm5XTTZlS01iZ3czdEJ6ajJUQzRlVWE3?=
 =?utf-8?B?U2NiTGRvZjFZS0x1SjNsZU4vKzkrWHdwZmtPNUlNV0wrNE1DRFcxVlI3bWpz?=
 =?utf-8?B?SmhpbThENXpvSi9Ydk1JZkQ0b2pEd1lrUnVJZHRCUUZtbVZ0Vno5NUFpcElz?=
 =?utf-8?B?QjgwL0d1RWlxVWNXOTROSlZTKytsQTVNTlZnQ1ZtU0tHckNuL0EvSDNTNHBO?=
 =?utf-8?B?Z20zL09Nb01NdXRkOEwzNGgwdkJKTmVvRkhsUUZ6TE9yajF3WjJUcHNnK25v?=
 =?utf-8?B?bnYyaHJFR0taaFF4WjE0U0ZWQzdEY0hJOGJKNnA0TG54Nzgwd1RSbEc3RnM4?=
 =?utf-8?B?WHdxNWpPS1B5OEdzR3dPb2kvWWxhT3RhOXFVU3A2UWNRWTBqZHZxN1FNK0My?=
 =?utf-8?B?NmtlRnhUSUZxZzJhUVkrbGlMNTZCN0t3L1BQS3JYbDZsOWtZc2JvY2FNTzJE?=
 =?utf-8?Q?fD7unSJFtUr2CRvVq8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb0a113-a201-46d5-9db4-08de998c899d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 18:43:21.8709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmlJgWxnsY6ohaXFJLyt4zi2qZJjdpuxYBNW5TUS2DFXfzl2E+pQiJ6716EGHLRv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5683
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



On 3/31/26 12:20, Alex Deucher wrote:
> On Fri, Mar 27, 2026 at 4:33 PM Amber Lin <Amber.Lin@amd.com> wrote:
>>
>> Create hung_queue_hqd_info structure and fill in hung queses information
>> passed by MES, including queue type, pipe id, and queue id.
>>
>> Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
>> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 17 +++++++++--------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 13 +++++++++++++
>>   2 files changed, 22 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index f1f8bbfc31e0..436a46ba1dfa 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> @@ -447,7 +447,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
>>   {
>>          struct mes_detect_and_reset_queue_input input;
>>          u32 *db_array = adev->mes.hung_queue_db_array_cpu_addr[xcc_id];
>> -       int r, i;
>> +       int hqd_info_offset = adev->mes.hung_queue_hqd_info_offset, r, i;
>>
>>          if (!hung_db_num || !hung_db_array)
>>                  return -EINVAL;
>> @@ -471,6 +471,12 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
>>                  return r;
>>          }
>>
>> +       if (r && (queue_type != AMDGPU_RING_TYPE_COMPUTE)) {
>> +               dev_err(adev->dev, "MES resetting queue type %d is not supported\n",
>> +                               queue_type);
>> +               return r;
>> +       }
> 
> I think the message here is a bit confusing.  The MES can reset other
> queue types, this is just the fall back case for when MES queue reset
> has failed.  Also, does MES populate the doorbell array for all queue
> types regardless of whether the reset was successful or not?  If so,
> shouldn't we bail for non-compute queues after the doorbells are
> populated?
> 
> Alex
> 
Right, I removed the queue type check in v4. And yes, when MES fails on 
queue reset, it populates the doorbell array for driver if driver is 
going to proceed pipe reset. The existing check is sufficient. I removed 
this extra one in v4.

Amber
>> +
>>          *hung_db_num = 0;
>>          /* MES passes hung queues' doorbell to driver */
>>          for (i = 0; i < adev->mes.hung_queue_hqd_info_offset; i++) {
>> @@ -486,13 +492,8 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
>>                  return r;
>>          }
>>
>> -       /*
>> -        * TODO: return HQD info for MES scheduled user compute queue reset cases
>> -        * stored in hung_db_array hqd info offset to full array size
>> -        */
>> -
>> -       if (r)
>> -               dev_err(adev->dev, "failed to reset\n");
>> +       for (i = hqd_info_offset; i < hqd_info_offset + *hung_db_num; i++)
>> +               hung_db_array[i] = db_array[i];
>>
>>          return r;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> index f80e3aca9c78..2e6ae9f84db0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
>> @@ -170,6 +170,19 @@ struct amdgpu_mes {
>>          uint64_t            shared_cmd_buf_gpu_addr[AMDGPU_MAX_MES_INST_PIPES];
>>   };
>>
>> +struct amdgpu_mes_hung_queue_hqd_info {
>> +       union {
>> +               struct {
>> +                       uint32_t queue_type: 3; // queue type
>> +                       uint32_t pipe_index: 4; // pipe index
>> +                       uint32_t queue_index: 8; // queue index
>> +                       uint32_t reserved: 17;
>> +               };
>> +
>> +               uint32_t bit0_31;
>> +       };
>> +};
>> +
>>   struct amdgpu_mes_gang {
>>          int                             gang_id;
>>          int                             priority;
>> --
>> 2.43.0
>>

-- 
Regards,
Amber


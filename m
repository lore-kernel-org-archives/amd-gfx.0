Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802B6F483E5
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 19:11:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B3AB10E44B;
	Mon, 23 Mar 2026 19:11:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zSkX2hqh";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3EA210E44E
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 19:11:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjwLBWr0O9xKGbkbKUzao34mz1vuT5MIhnRHutkITNTOgD2RLhgVEPrBMbeTiV90xktkR38DVX8EUapX4ccxQTqDN3vOlDBUc17iiynNA6H1f4d/JP4+etTMPtfBMm+2UzcB8/byo8Vfc85fHnCq/FzLt8C5mAmWMXRDlkziZLj0RfrrXdiAoUdcMzhXGBa65diTLAgoZSBw9vSlxc5ziomFG75B3m6q127wmLKKNhPVgiIUXgKJSK0Rs3RwKK4ojp7IEZlRkHbtbHFcs2utyBTdUl5q8nLZTBXR77MV2+9gTJdpCW3waFoURPRE9crMDMtVWG4qDtJ8qftZ/It9zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4eZi+sH8pdH2KOZ3ZY5y7r9+OQaid7ojEHPdICClJQ8=;
 b=Wk9PQlvb8yMhW9+C5tXFlpNLu+Z5N/dmt3/Fon194Sh7RcOI4XBsWtNLCItpVV71t7y4Vlpnz7JITkaBEq1vCm9hWvTR9uP6SGWKdqkkuOSfycqOzBdmNc6oYCj6zb+x8GKV/+npRqM8cMAFgg+Y9m8+88AFXKgPw8NN+A/6seMxaRDYTc+/zSafh4DRdqa3x1Uph9KBJO+GmjfVucetrGcvWjQjqA45KDP0HhMy9DQ/NVaX7kyykre3uqQNm5XkqNN7nK2nle3pyXhCulxxs+D6/VYnfOAVaXhq2MEZyiDPBLZgZD9k0gw75jHkVKKnD9Kr5RDLcSRvwXSiuebfCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4eZi+sH8pdH2KOZ3ZY5y7r9+OQaid7ojEHPdICClJQ8=;
 b=zSkX2hqhUPQLTMXm8R9uwVpdL8+TVv4LUxoKsCaIhwtfS20u7hJHEHyNkZMLL1tsVf/VvLclgFqhO/b79K3Yr/Hz0CNtMhj0/wUy7lUjvhd0DakMFOdH+Nb55G65u1PGdxpK3dAuCyrEd+qbkGaO+9JX0kFxkm4ISPHOj0B1guk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11)
 by DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 19:11:12 +0000
Received: from CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2]) by CH0PR12MB8464.namprd12.prod.outlook.com
 ([fe80::a45b:9b43:1014:eaf2%4]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 19:11:12 +0000
Message-ID: <59d748d8-193f-492a-a552-be3417181a31@amd.com>
Date: Mon, 23 Mar 2026 15:11:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] drm/amdgpu: Create hqd info structure
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun.Liu@amd.com, Michael.Chen@amd.com, 
 Jesse.Zhang@amd.com, Jonathan Kim <jonathan.kim@amd.com>
References: <20260320200208.1188307-1-Amber.Lin@amd.com>
 <20260320200208.1188307-5-Amber.Lin@amd.com>
 <CADnq5_NCqNEcAPC66tqcKNtM11XFRodV948Ev3zDHyMCW0mU9g@mail.gmail.com>
Content-Language: en-US
From: Amber Lin <Amber.Lin@amd.com>
In-Reply-To: <CADnq5_NCqNEcAPC66tqcKNtM11XFRodV948Ev3zDHyMCW0mU9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0222.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:eb::8) To CH0PR12MB8464.namprd12.prod.outlook.com
 (2603:10b6:610:184::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8464:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: 69ef12dd-9c91-4029-f57a-08de890ff2b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: TNqPCFyh2t+f04QfrcXXK6tJeGJLXcarTfBb178xAmG5Wo7ZFQI14SrfGOs63dtrLTlVkgZspHTcdNNduMd2pfiT7F1BeIaxiGAbHrh9qt7c2NdxclySYbHx9iMP98YLCIxfgBaNry8DNn+kcjV4YHz5ID3isxP17pbNM5+DasIgYhRiI0dRVe0HSN9wPvZps+Xr6ZVQSQ7I1ktf+K6agrA5vaPYVmjV2KxTEf53Bro/f9rjAcWvYYzzL1YaMq+3DLRQ8sspWueZ8htMn6O6LQVAGa2FbQoQFaHacwdQQAUisxse7IPEcxPZDhEeSnriZFqH0iqDyvfOfenrIMiRUixU10noWlSsqN4OTGYic9aGMzDcfd7GO9nwPvbXwl6W+1cxo6ISZTUjWljRa2I+9zf74mZAh1gjqCjlB9OS5o32P8IohvYxOcs2yW0qXilmAIR03L4SCmfhzXq3s3AvI6DPzAbZKSxqtvCCB3FcU9WgFAqEYXnHpBrYiDVDeunjUKkEho3uoskDspRNNW/5qe+5BxW4cmMrBYuEIoKgbPDmg16Vo6Lu8jy8lR5lbGfzFfom0ABQtC96o4fLV95QRP60bsVkjbDU6IhJ5vItJQAlluULHDTYPDKw/jZxa7LoBlWyMk+hlqs6xvjJqEsFw9Hej8zbnw9Q3xY0xKA90mnFQ21ReTnJHJcbH9QelmZugeDiFBfdPJuUrrkYHtmYXwlsIElG6aEJQDJRVUq0dkk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8464.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVFyN0VhdXVjNDUvYjRlaEljaTBvbUlJTkUyL3VpNVBJWEwxcytKejVhWTdV?=
 =?utf-8?B?NDVQenlDQXNDRm1pbmwxazVVYnRoYmRLdndQK2ZWMHhNVTJCQXFsaGNEVElI?=
 =?utf-8?B?UkpjUmowdENpV0FuUkxGUWthOVBZeDR1S2lYZ1Jyem5VQm9zZ1pvNWkyc0Zw?=
 =?utf-8?B?cUtwV3RMR2UxclZXSmRqWklFLzAyUWZ6Q0RHY3NXbDZsOSthOUt5RFdJQjlE?=
 =?utf-8?B?R0RCVmR5S1lUa3VydDVrKzlrME9hOVI2b3FtZG1NSWNQZ004MWQwRUhicU45?=
 =?utf-8?B?bE9YeWF5bUJVUUROWEZHNjZaY3IwZm1UWXNyaUhUTHF1TENMWU1YTzFrcGRa?=
 =?utf-8?B?cW4rNzlVMTl5TVhvMDBkWXN2bGg4UVAzNWpYU1YvSEk3aVJLK2xKUkp3WXIr?=
 =?utf-8?B?cksvLzU3cDlaVWp0Tm9taGQ2cGJraTJPZDJML0lNbkVkTDZIZmlITGVYV2FS?=
 =?utf-8?B?NHVqdGhTbzJkSlFlZzN0RVd6ZVBCOTZsNUZINzVTc0d2SHRSVDViVFhHdDI3?=
 =?utf-8?B?cEFvclBwQzRiRkFuT0JzYzZxYnRQQWt6dWNPTFdNQkNjSzh6TmU1bStkUjF1?=
 =?utf-8?B?cWlLTUhZZlhEOFJrTVowREtNVkVaU2wrcnlYQWVNSUYyanlFMkZvNEl1Y3Fx?=
 =?utf-8?B?RWRmdEZlaDN3SFhxMmFubWgxeGtXdGZadVpqS05TUDMrdDUvWTRNSVhhT0VU?=
 =?utf-8?B?RUZJVzhzYjZFU0ZDdFNuV2hsZkJ0eDdnVE9YMkpGbHFkNkZvWWNLL2RLaVkx?=
 =?utf-8?B?RVQ1eVBMT1V3bXNmNERLM0tSV2JCUmlDQVlCSm1vV0daeHlwWC94dUk5MUV5?=
 =?utf-8?B?TlZ6K1R1YkNKVEttTXBPT3Z0dWFqaFR6RDhpRUJ5SktlSHAzaVpyUzkzSHhP?=
 =?utf-8?B?RXhuOVJNM3VDYW4weEY3WjBDMmE1cHRWS3EwK3RGTzI1TXVqRVBlVWdueC9s?=
 =?utf-8?B?RXBSS1kza2xxNmkwMVA3Mk5CSjRhRzlwV2JxUmxzQkNsUDBXT1RLRkNUcjAz?=
 =?utf-8?B?bm1MMUM1RGhMbEV3ak1HYTJyczBDMDFlVjBvbEdYOWpSZmtvd2FtYTV5VEt3?=
 =?utf-8?B?eVl0ZVpiOTFIQ2ZxN0Q1NG9vcDRkWWRCUUFzZEV6WWtqL1lBakRpOHp6NFVY?=
 =?utf-8?B?d2U2RXRtQTA3TmJRMG5Jd1N4cVIzbUhkZDlHbnNKQkZDZlpCWmZTd1hxUHlU?=
 =?utf-8?B?anp0aDg3cjZ5MWU3eFRMSlpKdEhHY1VlY21hVDI1QmtuWUpVUWRQS2ZkMXhM?=
 =?utf-8?B?cUcvU3RnRnVVRG9weUdKUmsvdmdJT0lUM1l5WDI3czd6b0dZSStIRmJ4Z3ds?=
 =?utf-8?B?TThIeVNQOHE2a2NKS29uSXdPZGdnRWYrc3FmT2NjV04ycE5BRXUrRzQxekFE?=
 =?utf-8?B?TktENmxkdm9BNk4vb3pBZDc5ZGFqQVBPUHh5dEFQVzc3Uk9xRm9OcmloK2Vx?=
 =?utf-8?B?cVBScnlhZ09Qdkp0RU5VNVlyN2drcUQ1SkJXMW9ycm82MktkdFpjaHR2SnpV?=
 =?utf-8?B?NGxSYkVpQkpCS2tCY3JOTWQ1TmgwZGxYS3E1Um5zMXNFSytFMDU2Q29UTnRa?=
 =?utf-8?B?TDFBdnI1dHZxWEt5UzEwZk5KNjZ6V08vMFlweUhIcW83UkdaNVltU3NGTWE4?=
 =?utf-8?B?d0xOVGtYc3d2MS9xdWhPdXg1K25LVE45Rmw3MW1FRkxKSDBSTVpNN0JpK3Nz?=
 =?utf-8?B?UGJRU21Ia3hVOWlOOWlXL2U5dmNLUGVDMnhQaGh4eTUrdWxnclo2Z2s3Rmpq?=
 =?utf-8?B?Y1JXYTh3U3VRYndxckN0bmhMSUtxdXBjWWtpK2R6VXJ6eEI0YWhQOGNKa1ls?=
 =?utf-8?B?SHg4eS9ubmZKNWJxSjlZM3ByUVVZOXdPTFpENnhiSjhESnNqMy9lMytobEIv?=
 =?utf-8?B?TzRXY21DTkVjenlxTUphRFZJdEx5MEZYSjJFcVQ4c1kzMWh6TUUwY2JOOUNS?=
 =?utf-8?B?bGpZU2I5VDRhQVFCV3BFcG5PSm1DUkRDY0tWRUJ3Nk9lUCtXUzFUZCtzWTZ6?=
 =?utf-8?B?YXhtY0NUZFBheUJsQ3VXd05Bay93N2h4NUNTOVk4MldVc0Rab0EwS1dKS1Bl?=
 =?utf-8?B?Z2JUMStZY0NJWmM1L2Y5UWV1dHhmbHVMVlpIZG1lY0s4OWlzVnhXeEJNWVZY?=
 =?utf-8?B?bHR0dFhxcnhZNlhOTEh5Rjc1b05CbDB4U0JYa0Z5c2xOQlh0Q2RTM3N0VThD?=
 =?utf-8?B?T0ZiUDB0alZhVkdMWm1SWWt5S3NhZDBWdWFocEp6czMzWnZWd3RzWDl5MkJl?=
 =?utf-8?B?dHZwOGdDMkJJUk1RSGNNbzJxcHo1SFFTZjYreWdrSW9adVIzZWtsSlR5YWsy?=
 =?utf-8?Q?ytUt9azl8xDPzCs4Bs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ef12dd-9c91-4029-f57a-08de890ff2b0
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8464.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 19:11:12.4878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbWyxgpvPpnh0cFvrwyJkoAYDK73eBQnjVwLI6nvmL/z4Ye/mJ8U40J70zySGqaH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928
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


On 3/23/26 15:01, Alex Deucher wrote:
> On Fri, Mar 20, 2026 at 4:09 PM Amber Lin <Amber.Lin@amd.com> wrote:
>> Create hung_queue_hqd_info structure and fill in hung queses information
>> passed by MES, including queue type, pipe id, and queue id.
>>
>> Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
>> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 13 ++++++++-----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 13 +++++++++++++
>>   2 files changed, 21 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
>> index bea509f6b3ff..710bca87c32b 100644
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
>> @@ -486,10 +486,13 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct amdgpu_device *adev,
>>                  return r;
>>          }
>>
>> -       /*
>> -        * TODO: return HQD info for MES scheduled user compute queue reset cases
>> -        * stored in hung_db_array hqd info offset to full array size
>> -        */
>> +       if (queue_type != AMDGPU_RING_TYPE_COMPUTE) {
>> +               dev_warn(adev->dev, "Unsupported queue type: %d\n", queue_type);
> This function will get called for non-compute queues.  We shouldn't warn here.
>
> Alex
Right, I only consider the caller being KFD and ignored it can be 
potentially gfx too. I'll remove this warning.


Amber
>> +               return r;
>> +       }
>> +
>> +       for (i = hqd_info_offset; i < hqd_info_offset + *hung_db_num; i++)
>> +               hung_db_array[i] = db_array[i];
>>
>>          if (r)
>>                  dev_err(adev->dev, "failed to reset\n");
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


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4311FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 12:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0F9E10E65D;
	Tue, 24 May 2022 12:10:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D1E510EC78
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 12:10:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUtdx4mT65Md+zDFRDHCrCStZZWGh2kqQm0mrMWYTBB+M64Xgc06RQJt8aCIpebFEhzxMvsEF6dkoOAFcxH8ScWG9gIVxCx+JG/iVQt6dGksBnqGLxM36yCanvw/hBVjcV8Z3ll4PppqrCU93jiSHJgdD6VrAIhQ2pB63h+80EC/VTXDJ0hnGsXmWmrr+TkXrp8yIyJC9754ICWDdDI3a+fsA/mYA+HdYStDBDO53VB/KqkUehjAe913U8iUMx33PRRE9DER9GswXwMySm5Zyb2lIAg07XtrJ1F5D7q1Hbl9O4kR+cCW603R+DA1XPY5QW1Grzodw2oamXi62YuSeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4WEEyEQoz7g4a6DxWH9rWGIjIgFvyKYEQ75BtFU8uQ=;
 b=IoKAxy1CAAU+vbEPEu6o2sVzRrhcO4AU5+R+69AsFgSnMVDxgAQAXtg8J+ZjaoDdp+WlO3wgRRyuHtnfT+XR5YDUEQ+mEWn8eA0Qlx9okkNfhsvssQLq8zhUX8ibUN4Xyy2m/l/XNxVpbWlP0Hm9sxzHvQLrcqzNOPm7KfbyDabcoMg/qWfhRUlZcCLFE5kYvmQdCjuw6Y+eVqzeyWft3ppOD3V01UlS39hnnnRPnGpIrug54N/xbKkPgjnTl10CfycykCu9IrxwBtljL8lRMRwx3vmajgIFy3+Qq1dausL98BOtsPBtm3DaDwqRZAfsppPWEJPjcCHLaEkuI3bIMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4WEEyEQoz7g4a6DxWH9rWGIjIgFvyKYEQ75BtFU8uQ=;
 b=BaG4sjEQU1/L/scZ/etdBdYYLmPaBEV6ecF7vY8UrQKt9PgNwXJHMHI+mutGFRzIJtU+dWYtlCdHZlO0GxzDHzQiDhXk4jxari3KLOy1Ieg+apg7KUgweTy+uEN87qWFoQBu9gIZStfvj/bq1tCrUxFj6pTOSUHRrIV+Cl992VE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3897.namprd12.prod.outlook.com (2603:10b6:5:1ca::24)
 by BL0PR12MB2403.namprd12.prod.outlook.com (2603:10b6:207:40::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Tue, 24 May
 2022 12:10:45 +0000
Received: from DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::d88f:683a:1421:dde3]) by DM6PR12MB3897.namprd12.prod.outlook.com
 ([fe80::d88f:683a:1421:dde3%7]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 12:10:45 +0000
Message-ID: <7cdad508-17b9-17b0-59f2-de0bf98ed780@amd.com>
Date: Tue, 24 May 2022 17:40:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 2/2] drm/amdgpu: adding device coredump support
Content-Language: en-US
To: "Sharma, Shashank" <shashank.sharma@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220520134909.92781-1-Amaranath.Somalapuram@amd.com>
 <20220520134909.92781-2-Amaranath.Somalapuram@amd.com>
 <588a0599-7d0c-0041-9877-4429b416e7ed@amd.com>
 <18da952a-25d7-1d52-5d1b-016432066211@amd.com>
 <2e8b9ebe-3d1f-40e5-73e3-54607a8045cb@amd.com>
From: "Somalapuram, Amaranath" <asomalap@amd.com>
In-Reply-To: <2e8b9ebe-3d1f-40e5-73e3-54607a8045cb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::15) To DM6PR12MB3897.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 956261f4-a644-4728-a130-08da3d7e6e79
X-MS-TrafficTypeDiagnostic: BL0PR12MB2403:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2403F21E73821431A967E826F8D79@BL0PR12MB2403.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zvkdu4mCAuPARvBLqpLByoR3BvzjqS9aAFHWkvWdh9sNlomYycK86H30wtL0qKQS2yEF/C7lOnQqETw6jj2FkKiSf/sv8kQDzb2/pwvz2N2ZW2+or1Iafo5L158KuA5m0Ymr6uk9ntTaglIzrj55jqNSF2Oga/bON4YGlYkzBs0DlIX48VisAk9EkwJW1T8hDVhK6gSiQ6ePVjBCs4GTj2EaAtuYveyguuFtUVxL76icy14zMfi8E9cAePWVcTI8FEStetgvZwLGSegWQAKnHctxo6gmgbXiQjSutGeqjuz1ft/vtHcIavEbOQGj0SwdtYh5IWQdEWwN3pGrbS+cj4mOLWeD8lco+lSt4iUe82lACxstFJ81zTRfqyTGCTymX2NVArUY2VBDl5tedk7I0yb9OpX+H9wonYN+c9zvZSTseTKFi8S0BsGFqCht4tV2NDAM96wlbORG5EuoXnH4ObxnatcFSPgiXGjjA94D3Xvi2/GprIFNoRT80k319E0PWwCZi/DTFb05orqJrAxXVR/bfwXvixB5IttOhtW9Q94eRiokXL0JqeVZUYyCyGw9Ge8989t+RhaqCOCERvFcT0VcIJSTBQteNB9lxwHzeonMxdDRqewVASYOvWVT6EZc8EQ2uoR7/4SDd//KsKq+jWX9bbuLthIMqStl09JMyKg5jdKBMBXHAE/VoBi1joYZ0wTBOQPC9Qgudxb/8lVoDyf7cyD8pXqBXoYuTlX7a9Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3897.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(5660300002)(8936002)(6666004)(2616005)(31696002)(66946007)(66556008)(66476007)(36756003)(186003)(316002)(6486002)(53546011)(8676002)(4326008)(26005)(6506007)(83380400001)(508600001)(2906002)(31686004)(6512007)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SllVMG51YnZ0M1JPZmJVMnhPUWtZRkJmZ3ExOGpBR0podUNFbm1TQ0cxeDU0?=
 =?utf-8?B?NTlFVElqMmtCaGdzNEtDZ2ROZ0U0UXVwTHQ3OGVNSkFsdzZNZ2MxVXBCR0Vi?=
 =?utf-8?B?MHNHL2M3cFR3Wmc3Y0dmNVJURGVCb1MwOFdCZ1J4aFBMcDU3UzE1dGEzekNM?=
 =?utf-8?B?cGgzQy9Jejl1c0pTTDdyZ01jMTF0UWx4WUwzUy9RSC9aTCtneG8rM0lmU3Qv?=
 =?utf-8?B?N2F1NWJ0ME1lUUxiQm1iNnc0OGVqZ0Jxbm00QUluMVdoYzE4UlZpcGdETlZJ?=
 =?utf-8?B?ZVVub2pkZVBTK2V3VVpTRGpUeHFGaUxRVWNRVFRLM0IrZ0dkKytNZGNiTWtM?=
 =?utf-8?B?NEJzTzBPYklocC9tTDNXa2J4ZmNYYklGaXNRdTlReHp2WG9SMkI3MFF4anNR?=
 =?utf-8?B?Qm5yT0FTSWNFODAvZ2I0RnZoMDZoc3VCN1pIZm1TK0R6b0M0RlIvQ0dQeC9u?=
 =?utf-8?B?ZzRwL0U3TmowWWVTelp0cC9DRlFkYUNscXYvRzdKc1RNUjNrRFdqY0pMQnJZ?=
 =?utf-8?B?ME1OTVgyM25ablVyRVpLblBqWlliUUhBbHdXYS9CNzRjOVE5M0pLVGNqU09K?=
 =?utf-8?B?Q25xTXZjVU5nbDdVOU9BbUJid3VlbGtEdnc5R3VyWnNnUjBTU3FXcjlxc2xQ?=
 =?utf-8?B?ZmNwRFpNN3pBT0c2SGhKT2RYd0VTQ0hITVZUYWJPL3UxQks4OGtRbDhoWEFH?=
 =?utf-8?B?TkgvS2taY3dXNTRHVy9PdlpzdFJNcEJDcGdtZVZvUWZJVW04Y3dLdjl0THZt?=
 =?utf-8?B?dFNHdWtYVCs2d0M3US9zZWR4TFptYTB0eU9IUzEvUW5OTUU0Z0g0QWVPTnpZ?=
 =?utf-8?B?cGNqa1F1dm1uMTI1TnhIbnIxcnlYRUs0MFp3SGhBNDFleU1jc1Uyd092UW5N?=
 =?utf-8?B?T2hrSDRwQ0tpenN5aXVxajR4OEU1WUV1TmRKV1ZNSUcyS28xK2N6TnlYZkdz?=
 =?utf-8?B?bVJsWkVLeFRMdWFqSEE4eEM3enluYU1NY09yQ2ZVYnhPa21vcklBRDNlZVRy?=
 =?utf-8?B?M3VQQ0J2R2lzcHB4Z3Y1RWFRWWdoUjc0MnVBemdVNDVPVHoyT1p3N3lxVTdw?=
 =?utf-8?B?K1VtZTNmS1B0N043VVhpWlhyU0tKbTdENEc1bGNGYUVIYjhpbDdqUEtYeDhi?=
 =?utf-8?B?RERwUVc2ZEd2clFwb0x4eEl5MUtieHlqVGZvK2ZoME1zd2pQYVovOWxyeU9E?=
 =?utf-8?B?cHdsSWlaZXRNbHhqOEMvcnI3dEFtaUdKZzI2STQwVjNKcm5TTWxtbXQyWWJX?=
 =?utf-8?B?R1ZhZTUvd2V1VkxWbjVndEh3czNPOEppQ3lrVzJtRVM0WmhUaUs5dXU5TTZN?=
 =?utf-8?B?eHorQTRCdmNvZ3lUV2k4ZUIwWDlOVTY5bnEvd0pKZ1JUUlNDMmpuTG5LczEx?=
 =?utf-8?B?K2dpcDhDQnVhWDRxK212WER1dm9CenR1RkdKNi9CRFdyaXZHQnhTUXVKQU9Q?=
 =?utf-8?B?OFAvMGJkZlJKVDhOdTdUWlR5YTNzbXJBREVDMTN0YXJhK2kvMTZ1WGdTU1lx?=
 =?utf-8?B?QXpHVjA1Z1BDS0ZRZmJ1Y1JpanpEY1NGWWZvU0diUFpaYWVSNXVpN002VHlL?=
 =?utf-8?B?U3NyK0R2MlpJRS8yakNiZmpVV2FOSHJmclEyVlFMVzRXZ3V1bFVoa3FmL3RL?=
 =?utf-8?B?bnVOdWdXZnZyTmFBNW1ZMSttb0xmYWZTc3FFNDJlVTJjZ3JxN2Y4RkQ1WDgv?=
 =?utf-8?B?aXNlYm55b3FFUTZjOW5RYkhwUXpIQ2RLSVpQQjhBeEI4R1pSWGswRlhCMDFt?=
 =?utf-8?B?Z3JBRlhOTnhTMEkxYW5zeGgraHpoK1dFSlZhcVF6QXRHMmZhSldYOGRRcVJi?=
 =?utf-8?B?ZUsrR1h5b0cxZUVjR05GNXdIWGszczhzZUVjRVBVTDk4Ty9yWXhFbGIwV05u?=
 =?utf-8?B?em9ITHZtYlIwUXZGbmpOandyekFBazE5TDRTMmxId0p4K1pSY0JFekhiT1Vj?=
 =?utf-8?B?Nm5KbytKWmU4OEUySlg4RnFjem45T292WGhUd1ZZcG1nOE54MW9aS1NJSGJo?=
 =?utf-8?B?aHJwRU5pbGtXenZYUjl0eWM0bFFLT0pqY0NXUmlaU1plaUY1amVIRzhVdWZP?=
 =?utf-8?B?TUNsWWdYeVh0Mlc2SnNBaGkzMVFjR25GZGVMeDNtdFFleVBHMTRYcmcvbFk0?=
 =?utf-8?B?dDA1aEl1TzhOWmJjT2Y1WDJHLzFMQktaczc5VEU5b1dGTnVZZ2orM25yT1BD?=
 =?utf-8?B?S0Rma3pwMkFpczg4QTRhbXFKdm0xcS9kMWhEUU1SRjFVZ1hwd0pBK3F4c1NS?=
 =?utf-8?B?WW5WTlNYeUtDSVlhenpDUk1TMzM5NlNCTTgxcytXRE15bVB5VktBVDdKRnk4?=
 =?utf-8?B?eVZSK2VJQm05OE5pRlczT3VmY2pLSWdOR3FBam9NRmh4UXBPdmFpdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956261f4-a644-4728-a130-08da3d7e6e79
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 12:10:45.8266 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9SYDIlHrQsDhmWs3Fw3tPwyX0NwonxD/AeD+Qg3a1GqkrUAfM3ikb8U1o7orKeOLqJmXXk67B+n85TtELLVNQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2403
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


On 5/24/2022 3:23 PM, Sharma, Shashank wrote:
>
>
> On 5/24/2022 8:42 AM, Somalapuram, Amaranath wrote:
>>
>> On 5/20/2022 7:52 PM, Sharma, Shashank wrote:
>>>
>>>
>>> On 5/20/2022 3:49 PM, Somalapuram Amaranath wrote:
>>>> Added device coredump information:
>>>> - Kernel version
>>>> - Module
>>>> - Time
>>>> - VRAM status
>>>> - Guilty process name and PID
>>>> - GPU register dumps
>>>>
>>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 59 
>>>> ++++++++++++++++++++++
>>>>   2 files changed, 62 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> index c79d9992b113..f28d9c563f74 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>>> @@ -1044,6 +1044,9 @@ struct amdgpu_device {
>>>>       uint32_t                        *reset_dump_reg_list;
>>>>       uint32_t            *reset_dump_reg_value;
>>>>       int                             num_regs;
>>>> +    struct amdgpu_task_info reset_context_task_info;
>>>> +    bool reset_context_vram_lost;
>>>
>>> How about drop the 'context' from name and just reset_task_info and 
>>> reset_vram_lost ?
>> OK.
>>>
>>>> +    struct timespec64 reset_time;
>>>>         struct amdgpu_reset_domain    *reset_domain;
>>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> index 963c897a76e6..f9b710e741a7 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>> @@ -32,6 +32,8 @@
>>>>   #include <linux/slab.h>
>>>>   #include <linux/iommu.h>
>>>>   #include <linux/pci.h>
>>>> +#include <linux/devcoredump.h>
>>>> +#include <generated/utsrelease.h>
>>>>     #include <drm/drm_atomic_helper.h>
>>>>   #include <drm/drm_probe_helper.h>
>>>> @@ -4733,6 +4735,55 @@ static int amdgpu_reset_reg_dumps(struct 
>>>> amdgpu_device *adev)
>>>>       return 0;
>>>>   }
>>>>   +#ifdef CONFIG_DEV_COREDUMP
>>>> +static ssize_t amdgpu_devcoredump_read(char *buffer, loff_t offset,
>>>> +        size_t count, void *data, size_t datalen)
>>>> +{
>>>> +    struct drm_printer p;
>>>> +    struct amdgpu_device *adev = data;
>>>> +    struct drm_print_iterator iter;
>>>> +    int i;
>>>> +
>>>
>>> A NULL check for 'buffer' here could prevent a segfault later.
>>>
>> Agreed.
>>>> +    iter.data = buffer;
>>>> +    iter.offset = 0;
>>>> +    iter.start = offset;
>>>> +    iter.remain = count;
>>>> +
>>>> +    p = drm_coredump_printer(&iter);
>>>> +
>>>> +    drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
>>>> +    drm_printf(&p, "kernel: " UTS_RELEASE "\n");
>>>> +    drm_printf(&p, "module: " KBUILD_MODNAME "\n");
>>>> +    drm_printf(&p, "time: %lld.%09ld\n", adev->reset_time.tv_sec, 
>>>> adev->reset_time.tv_nsec);
>>>> +    if (adev->reset_context_task_info.pid)
>>>> +        drm_printf(&p, "process_name: %s PID: %d\n",
>>>> + adev->reset_context_task_info.process_name,
>>>> + adev->reset_context_task_info.pid);
>>> Please fix the alignment of print variables.
>>>
>> I will cross check this.
>>>> +
>>>> +    if (adev->reset_context_vram_lost)
>>>> +        drm_printf(&p, "VRAM is lost due to GPU reset!\n");
>>>> +    if (adev->num_regs) {
>>>> +        drm_printf(&p, "AMDGPU register dumps:\nOffset: Value:\n");
>>>> +
>>>> +        for (i = 0; i < adev->num_regs; i++)
>>>> +            drm_printf(&p, "0x%08x: 0x%08x\n",
>>>> +                    adev->reset_dump_reg_list[i],
>>>> +                    adev->reset_dump_reg_value[i]);
>>>> +    }
>>>> +
>>>> +    return count - iter.remain;
>>>> +}
>>>> +
>>>> +static void amdgpu_reset_capture_coredumpm(struct amdgpu_device 
>>>> *adev)
>>>> +{
>>>> +    struct drm_device *dev = adev_to_drm(adev);
>>>> +
>>>> +    ktime_get_ts64(&adev->reset_time);
>>>> +    dev_coredumpm(dev->dev, THIS_MODULE, adev, 0, GFP_KERNEL,
>>>> +            amdgpu_devcoredump_read, NULL);
>>> instead of registering NULL as free function, I would prefer you to 
>>> have a dummy no_op free function registered, which we can consume if 
>>> something changes.
>> you mean something like this (function without any code):
>> staticvoidamdgpu_devcoredump_free(void*data)
>> {
>> }
>
> Yes, precisely.
>
>>>> +}
>>>> +#endif
>>>> +
>>>>   int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>>>>                struct amdgpu_reset_context *reset_context)
>>>>   {
>>>> @@ -4817,6 +4868,14 @@ int amdgpu_do_asic_reset(struct list_head 
>>>> *device_list_handle,
>>>>                       goto out;
>>>>                     vram_lost = 
>>>> amdgpu_device_check_vram_lost(tmp_adev);
>>>> +#ifdef CONFIG_DEV_COREDUMP
>>>> +                tmp_adev->reset_context_vram_lost = vram_lost;
>>>> +                tmp_adev->reset_context_task_info.pid = 0;
>>> why is the PID hardcoded to 0 ?
>> in case of reset context reset_context->job->vm  is null (possibility 
>> that reset can be non VM related).
>> If we don't set tmp_adev->reset_context_task_info.pid = 0, it will 
>> show previous reset valid PID.
>>
>
> But when the VM is not NULL, are we updating this PID somewhere ? I 
> did not see that happening in this series.
This is the only place where PID get updated.
For example sequence of operation like:
1st reset:
-valid VM and tmp_adev->reset_context_task_info.pid is set to some valid PID
2nd reset:
-invalid VM
-tmp_adev context will remain same (adev context will be same after 
successful  GPU reset sequence).
-tmp_adev->reset_context_task_info.pid will be holding 1st reset PID value

if we don't set it 0, it can give wrong PID.

Regards,
S.Amarnath
>
> - Shashank
>
>>
>> Regards,
>> S.Amarnath
>>>> +                if (reset_context->job && reset_context->job->vm)
>>>> +                    tmp_adev->reset_context_task_info =
>>>> + reset_context->job->vm->task_info;
>>>> +                amdgpu_reset_capture_coredumpm(tmp_adev);
>>>> +#endif
>>>>                   if (vram_lost) {
>>>>                       DRM_INFO("VRAM is lost due to GPU reset!\n");
>>>>
>>> - Shashank
>>>                      amdgpu_inc_vram_lost(tmp_adev);

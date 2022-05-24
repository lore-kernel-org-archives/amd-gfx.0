Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF47C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 May 2022 09:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F56110F421;
	Tue, 24 May 2022 09:55:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71D9510F421
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 May 2022 09:55:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCjY3IGyzPA2snhYZ27Y0IVxiUQfT66YyeEoJvO4FQ+ZnumNi3cPkmn97Qttxc1E69hCE7vxKCtM6NQVxqOnCY4J/juM0jMSbWGgImmaZuMOgCQ+DUgzQcU51zgIcGSXpYWPIR5QE+p5gny0/PAA1g6qIRdOJYHGHchUQwyuiWPkg+pPv97oGrXkd2mqDRUGBD11hvPtv+etpB2fJo+F0MxOrpN5naPvB2hYmnI39C5fB9Mjicg+VCn+ZEsBzmOv2bP0Qx1eFq+8ZaEb3WAN3xwsybKCZbqEnBBYnhs3g9dA2be4YCj5VAUIJ0pqADYRu2t5QnZ7/TOL0ko92Q69Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tAj1gGK/pD+LMFoQrT9YfsikZNK2QSbRBX3rAVHc/c=;
 b=P6VvkErfp7B1sEsvzTwhSLSe0sfCeG3NTRiT5PnDjWWMg9CbdH4ebafSigr3UFjlQ60uF5P/2wM/tzis8RGwO9Lc7BcpR34GAtRLMnzKwSjDCwpsfBzAZwp7lvOtUlAj5ziMMTEBV/qz3ZSPk9ol9D356a22t2svEPeC9qp2RfdJxfD3ZSiIawVauVeBIB74/deJC9OIDOeel2xT1pHFCiaj7AvNbmu7WwdSJF8T77NxGC3/gYOFsXljoFSBZkO01JUwasT9IwwLuiT5IjGyjltcyHWXHeMDfUxuV6JhIu9JfZp0uS6Euo22OBIFbK5+QE8TuMTRvRPtPtwajZ5dlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tAj1gGK/pD+LMFoQrT9YfsikZNK2QSbRBX3rAVHc/c=;
 b=HQe0ocD4TM8F2HDsfdPVtmFl31Pv4C8Wokd55Gvm20eFTnkS44OnjZHeCSCWLRUTOa8dsIZL9AKdqbsxLuWHuVUOOIgww/4qUCIQb+TzPuKPtkIkGKFc+e/8yz3uYptTAog4ZtCVI7MPB1UC+LWXxai9KRZMJwp69d/JwfZfqpo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MN2PR12MB3599.namprd12.prod.outlook.com (2603:10b6:208:d2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Tue, 24 May
 2022 09:55:19 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::5149:1152:d389:81e3]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::5149:1152:d389:81e3%2]) with mapi id 15.20.5227.023; Tue, 24 May 2022
 09:55:19 +0000
Message-ID: <8e23dc2f-f365-1f0e-8ce8-f9f5b1405a1a@amd.com>
Date: Tue, 24 May 2022 11:55:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v1 1/2] drm/amdgpu: save the reset dump register value for
 devcoredump
Content-Language: en-US
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220520134909.92781-1-Amaranath.Somalapuram@amd.com>
 <1b19f85d-0ac7-3559-92a7-f7c7c6571512@amd.com>
 <9fdbe193-b65a-a429-09a1-107b00313891@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <9fdbe193-b65a-a429-09a1-107b00313891@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P194CA0059.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::36) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1ec2cb4-654b-43f3-631d-08da3d6b829e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3599:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3599A2B036735418D6C622EEF2D79@MN2PR12MB3599.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7VpBCWgF2TS6t4ZdjBwKW6rSlrckTyj4RtXWlWCxsD+XiBjIe/FxpiWl81cFGu9Nwe3qFPDmQ8w2ZoKkTK9oHrDi5HEkMR96053kusf6h6vsnSFEdWz+AiRcbrTvzQfpQd9M+YmkyMYNX8LwUOF2HAIo19uLH58oNSyP6GI3GEZXuZ4cZsgiAXhKsj2zEDeyvQZ6ysuSqpjHrPhBdIGtS1lhEYZdlRj1q/QHHnkBWQ4S3a8LenTaglHrxar0/IfsheMWD/I6r8Sonj8F5K9PGfNxhPCFsXaWyAlfHjVjRLruHof1lZjr0hstqX0gVnj4T1BapYL7/GaOmzDcJqo45hK8tgMVW3BbedGUXdPiLUSTquqLDDPVA4fhBQMuVbHEMB9Dl5QkS/7zUw/zbGpMQGyYBQQxwC3W54ghtkJhmslzW4OunN7aNyeEkpC7CIxv0PWwdL9rMV7eUmGJLGR1Jq1ndlCw9hKj+5ETokVHHyzOl4o2Y5G2jHeAqJtIPp+Mh00C8RWZXFuZlcAywMAgOS/wgJoURexroy+PbWwHb9FpXHeP2DGAe0jUpSW7iXaIjKH4sN3LnTAXSXdH3UtJFl8Bq0J/Pbxn0YdCNCXcujSGSFpbB2QJie539kNOZGit0rJRB85XFp2kbmUCdfgAJe0e/+8OWM3tp3Bpjjdp0IClT9BPwundhA7hz/JdeMGJeTbjFpi23GZczFBfsEtJ+vv9ZuKiv38mcwBat4XUxxeWMV8zflbciF/BZUNXWJOP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(186003)(53546011)(38100700002)(6506007)(6666004)(66946007)(66476007)(110136005)(508600001)(6486002)(316002)(2906002)(6512007)(2616005)(8676002)(26005)(4326008)(5660300002)(31686004)(8936002)(66556008)(86362001)(36756003)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bThwVEcxQW5HWDJ5V25HakpWcTJKaTM4eUpLT2ZvN2d4ZUkvQ1F5ejBGZGNX?=
 =?utf-8?B?NW5zcnMvVDNYMjY5b0ZaVnRTN1FOVU8yeVI2RlppRWxuakZGWDV2bEhLMVpT?=
 =?utf-8?B?a3B3d0JqTXJCSG42ZUhnaTlab1JQTVl4U3NqcWJWSnJiVytTT1pOQXpVRUp0?=
 =?utf-8?B?RS9wbkx4SE82YjVLTVZjeDRiY0lwczNSeEd0cnFsN21jQlpaRVBUQUErSmo2?=
 =?utf-8?B?YUNGNjhtN1RZcDZLT01IRjVpYTVvWEdXQlY4Q2ltQ0dleEFQT3pGb0xzekdB?=
 =?utf-8?B?UnVhNERpRkxxVUJKdkgxUHlJTzJxaEFkcWRPcm8xMjZ5TDhITWdTRFBaTW8w?=
 =?utf-8?B?Z2dNcEYyL3JIZWxjcHJNdlF6WFJlSjJWRUdOMi93YTB6WFdsWjNPRGFjdktn?=
 =?utf-8?B?cVFJQXU4K2lFY2ZuL1p6Rkg5QkVJdjViM2xSQW9BN2lHL3N4bXZTMGVtVU1D?=
 =?utf-8?B?cDB5Tm9ram55TWh6VHZGcm5nZHhyYWxZWko0VmdXamx6ZXdJenRLWkpPTml1?=
 =?utf-8?B?a3NKN1pRYk9WWUdtV0xrZFJkVUh4c3VzSkxSN2dSMjFkVzFHd29QV2loblhh?=
 =?utf-8?B?LzZLb1ROVElPZXhzN2FJRlk5SnRvSVVicWJQektPMHloa2xVT2hUVGZ5Rkwr?=
 =?utf-8?B?ZytCUXFJMi9lZ20yM1JUOUV6OXg0TW9HV2ltTlV4OHBtSi9DeWx2bHpOaHpE?=
 =?utf-8?B?OWpjcWx6VTRmZUtDREpmSHQrdWtFVGo5eThaWk1PU3ZhV1Vtb1FoLzZRSUoy?=
 =?utf-8?B?Ui9NQU5OUTRwallicXRLSmNQWjRMeFgvVE9nVDJKL2o5YWNmb1ZoMUphTEx6?=
 =?utf-8?B?QzdmV0x2Tk9MSUJaZThTanlTYldoRUxtTm1zQ1Y2K0Rja1NTOUZGc1o1VjNB?=
 =?utf-8?B?cWdHRnVRUWN2bzQ0aVdzRDlSZUU3d0FnTU5rYkx0eGhvOWFTWm82RTVXU3pv?=
 =?utf-8?B?cWhBR0lnRFpVOWd0OW51cGwrM1RoMnFPLzNIRjlHaVErcGprcUh5UzU3L2hO?=
 =?utf-8?B?alF6cm1VZlFHV1JzbjlCOXIvVTNXenA5QW1BUFNPL0p3U2JpZEF3Z2p1USta?=
 =?utf-8?B?ZVkyMzdMSTFKVW9LTzNRSXJqODU4dmJ6WVRIK2NPSEtoa0hyYklEbE45eFVu?=
 =?utf-8?B?emhXQ0Ixb3dEemZ6UHlhQ2gyWUtLVXVTejkybVE3eHNWWHVnNWdsbjlSZDJW?=
 =?utf-8?B?TzZ0bUY1SXliN3FkQjJTSGNmSVBUeG4rNHppbFVjM3FtS0tROU9mc1ZGTkFR?=
 =?utf-8?B?TzVpZkZCeTNVNnZMMkkwUDVrWWw2UjdVQ21TeC9LMEEycWpuN1owVEYvWXBN?=
 =?utf-8?B?WUJPVFA4dGpndTU0TzVSMGorZi9jUVlaRkZoYXQxRXF3SmRLV2FKWWlyYkF3?=
 =?utf-8?B?WHpPNEFRQlhBWUpJNnJVeFFlallOQUpKNi9aeE5FSEFqUUpGdHBVaHJ1TjBz?=
 =?utf-8?B?M3VkYnNNNng1TG9lWEhHQWdCaGVSNHNYRmVld0xudFRDR3dSNzluZzlnZmky?=
 =?utf-8?B?cm5aUms1Wm5WUGwrOTZQbUNWbzNZRDk1eDZCVkRSMnYyb1J6QkhUNlU2aVRz?=
 =?utf-8?B?UlgxM200M2NLU01lTTMvNm9LUUtuOEpkWGJqYzNKYWIvK0w2ZENaRmJLT0R2?=
 =?utf-8?B?RUdaVHM1bXlkU1NMOElhTTJXck9GMjlwMkxMR0xtNWtpMnlRVlFhSWphb0Nw?=
 =?utf-8?B?UnVYYVhmUWN3ck90MUlJeGoyRGdWRkFEbmRhWFBmTkpYa1oySWJJeXVnbnVV?=
 =?utf-8?B?ZVVnR1FNVWlTQTBBZTkyL1pWZlRYYkllTEhudkZaMXVRVHBwejhiRUZkNnhF?=
 =?utf-8?B?ZlN1RXBTdlZydmxVSXArVnJuaitZdXVQSm1POFZZNEVsY0IrVmU3bVpzdkZD?=
 =?utf-8?B?ajU4R0ZubFN2bWRqN3NWMlpuaXhCMlorUlkxWWY4UDVjZGJJMkQ1NXhERDNu?=
 =?utf-8?B?MnVGbktNMHB3T0doTlZ0MlhHd0hRTFdVanI2d1BuWGltNjdaNzZaLzBDUW9u?=
 =?utf-8?B?bkJwOTc3My9vOEVHMkphck0zb0g0YUFFMmdIUnZRazBsbTlPOHpzWUpLbVZ0?=
 =?utf-8?B?aFlVNmIrL0lzS1UyNXZaNjB6SFRFVzdrNFd5UGJPQWNmaXhhRlBPZWYxd0RC?=
 =?utf-8?B?NGNBN29ud3JsRDVFQlViQUNiUkl5Z3lhc1ZVdHFBV1NSaEVkaGdtZkdPRTRv?=
 =?utf-8?B?dlJQMGVtWnNtSTN3QWcyNVpMNUhvNUtaZVRTMmoyS2xUYUlESHFXaGdrd3pa?=
 =?utf-8?B?T1VxL0txMmplaHVBdDZ3aHUwRUV6cTdRNmpxRjV4eDJHNmVGVVNaalNiY3BR?=
 =?utf-8?B?empOOStVQytlemhvVnFKQitvY242VXJWOGQ0anVLMTJFbUl6R0FBUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ec2cb4-654b-43f3-631d-08da3d6b829e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 09:55:19.1527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcPQi+AVENBhmogPVCf158e0wUeBFGBDZdcxkHi2pmGnXh+vz6cAkceWTWJ4d03f8gZrWEmRVraHJZU2PgXmOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3599
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



On 5/24/2022 8:12 AM, Somalapuram, Amaranath wrote:
> 
> On 5/20/2022 7:36 PM, Sharma, Shashank wrote:
>> Hey Amar,
>>
>> On 5/20/2022 3:49 PM, Somalapuram Amaranath wrote:
>>> Allocate memory for register value and use the same values for 
>>> devcoredump.
>>> Remove dump_stack reset register dumps.
>>>
>>> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 1 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 9 ++++++++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 7 +++----
>>>   3 files changed, 12 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 76df583663c7..c79d9992b113 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -1042,6 +1042,7 @@ struct amdgpu_device {
>>>         /* reset dump register */
>>>       uint32_t                        *reset_dump_reg_list;
>>> +    uint32_t            *reset_dump_reg_value;
>>>       int                             num_regs;
>>>         struct amdgpu_reset_domain    *reset_domain;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index eedb12f6b8a3..942fdbd316f4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -1683,7 +1683,7 @@ static ssize_t 
>>> amdgpu_reset_dump_register_list_write(struct file *f,
>>>   {
>>>       struct amdgpu_device *adev = (struct amdgpu_device 
>>> *)file_inode(f)->i_private;
>>>       char reg_offset[11];
>>> -    uint32_t *new, *tmp = NULL;
>>> +    uint32_t *new, *tmp = NULL, *tmp_value = NULL;
>>>       int ret, i = 0, len = 0;
>>>         do {
>>> @@ -1709,17 +1709,24 @@ static ssize_t 
>>> amdgpu_reset_dump_register_list_write(struct file *f,
>>>           i++;
>>>       } while (len < size);
>>>   +    new = krealloc_array(tmp_value, i, sizeof(uint32_t), GFP_KERNEL);
>>
>> tmp_value is initialized to NULL, which means krealloc_array() will 
>> behave like kmalloc_array(), is there any particular reason we are 
>> adding this variable at all just to use krealloc_array(), and why not 
>> use kmalloc_array() directly ?
> 
> I thought of using kmalloc_array() (got little confused on next write 
> cycle), I agree to use kmalloc_array().
> 
> Regards,
> S.Amarnath
>>
>>> +    if (!new) {
>>> +        ret = -ENOMEM;
>>> +        goto error_free;
>>> +    }
>>>       ret = down_write_killable(&adev->reset_domain->sem);
>>>       if (ret)
>>>           goto error_free;
>>>         swap(adev->reset_dump_reg_list, tmp);
>>> +    swap(adev->reset_dump_reg_value, new);
>>>       adev->num_regs = i;
>>>       up_write(&adev->reset_domain->sem);
>>>       ret = size;
>>>     error_free:
>>>       kfree(tmp);
>>> +    kfree(new);
>>>       return ret;
>>>   }
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 4daa0e893965..963c897a76e6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -4720,15 +4720,14 @@ int amdgpu_device_pre_asic_reset(struct 
>>> amdgpu_device *adev,
>>>     static int amdgpu_reset_reg_dumps(struct amdgpu_device *adev)
>>>   {
>>> -    uint32_t reg_value;
>>>       int i;
>>>         lockdep_assert_held(&adev->reset_domain->sem);
>>> -    dump_stack();
>> This should be a part of different patch, where you can give some 
>> background on why are we removing this.

You missed this comment.
- Shashank

>>>         for (i = 0; i < adev->num_regs; i++) {
>>> -        reg_value = RREG32(adev->reset_dump_reg_list[i]);
>>> - trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i], reg_value);
>>> +        adev->reset_dump_reg_value[i] = 
>>> RREG32(adev->reset_dump_reg_list[i]);
>>> + trace_amdgpu_reset_reg_dumps(adev->reset_dump_reg_list[i],
>>> +                adev->reset_dump_reg_value[i]);
>>>       }
>>>         return 0;
>>
>> - Shashank

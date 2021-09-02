Return-Path: <SRS0=HxPN=NY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C52EC432BE
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Sep 2021 03:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC150610A8
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Sep 2021 03:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CC150610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F2C66E426;
	Thu,  2 Sep 2021 03:54:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D26676E430
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Sep 2021 03:54:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/5oXHm43KHeNbyqIhOhimM9ZBuXsvZwiLHpn00Ek1HMGVpxcSbHdNWxfqHPlvVco/ut/KNDL6emQtF8P1LVsbOOsmY5dwV77c2bwdptCHH9Uow4/dRtrqWEaWW15xkTj3NomGEO2Tklu2ZZ9Lsp4As0vkzw+vWU53RAkN7bH/zOekCYlG9mn/4F6Fxx7K35+BoaX5yDQzJbuYDl3Nks8MKEqcNDlX6n6QT2GZG7wsbV722X155RZhuea8CU5pArJEprN9KGvA3g5Gh3gT8hiQfEskf5/s+eLvx1Fyv/rRXCOAyprFVZlS8iZ2QXeUDkb5T8J4tDlZ4d43JHM03Y3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=eV9fI23blVyeNrTAauA+pnD38qAjxhKqMvGUexzu264=;
 b=UVXquz9W3x70tZPdnJuzjvBg0KOIIS3jmd2cyKAx57E3F6jAw2AvX+1lAv8zi7DLw0mFNUt1gVtjsuxx/6t3Tzr3zBxSHgbUZVb3gyt+TTRmCsp1KpLOME98UP/yG1uUTILlVCoHy7RInksE7o4Kn629/g+u1c8GaaMtUu5LYeNwRlWQ1y122oHDLMsIDqwqqtN8t/horNa0zHCNN4UfFUr9rEdXc4CnHB2TQieG3IZwjj/RWvLdVhSERIDt93DxSf5Tme/Jp8f8cMCmusUYwKhyyy6enkCqKutiObSEGN1WQawLKy5m/IiloiVoVFMikAN0IRhwj1TDm+7apd11FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eV9fI23blVyeNrTAauA+pnD38qAjxhKqMvGUexzu264=;
 b=meHBLb+TCtl6VZSLoW4nsiVYnsiHcvY04hseCzBk3wmRQhk16e8V2U7R2Arz1YDOJviBOAWDBLm/JsWPKBoyzpXyFNrnYSWIW+NKlvvVG42YN/Z1VZTJNsnDwTg580UtZxBG5YRgWUpfJt/zyeHBFoXVmbFLD1jd1aNPWaMaVlA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5061.namprd12.prod.outlook.com (2603:10b6:208:310::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Thu, 2 Sep
 2021 03:54:16 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.024; Thu, 2 Sep 2021
 03:54:15 +0000
Subject: Re: [PATCH 1/1] drm/amdkfd: make needs_pcie_atomics FW-version
 dependent
To: Felix Kuehling <felix.kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210831215632.195506-1-Felix.Kuehling@amd.com>
 <239a99fd-835f-cbbc-152f-afae6861bf60@amd.com>
 <2c63bf17-2404-8c68-fa63-b14d94de3e90@amd.com>
 <BL1PR12MB5349845ADA6A373FBA45609197CD9@BL1PR12MB5349.namprd12.prod.outlook.com>
 <9e6ea029-d928-0c60-edde-be1dd1fb09f6@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <6f4690cb-8d3b-4c96-f1e7-25c2b23a999f@amd.com>
Date: Thu, 2 Sep 2021 09:24:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <9e6ea029-d928-0c60-edde-be1dd1fb09f6@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::34) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN2PR01CA0059.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:22::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.17 via Frontend Transport; Thu, 2 Sep 2021 03:54:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 913210cd-ab15-4c0f-923d-08d96dc55533
X-MS-TrafficTypeDiagnostic: BL1PR12MB5061:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB506189A182BACA9F41BD7F3397CE9@BL1PR12MB5061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U0MXfUBd/xYzXTH6kNzU0VGSMkDtFrxHKD/GB/bWsOGaBdbVYdkGQi3iaNaiacL+c5lPzTSI+mig8NO9y1uRvA/MofT0joCsJzi72yXWfnuaedqoaAzCQdQsRXVjclW6Dio3zCeLnzQ76lcJWQoPZu5JdG2fYHkhOKpN3EcaDPzQRwK0RdNAikQi+yUXZH8X5CPG4UXEfzWOQbhSNyDieVMsg5s8h90a7fWE1b7wMcQLRWAFX+L9tB6um1ucMDeD1DNixdPST7Dd1Z1lk4T65UrJHEjIbYKtBjSGObgNRQUdIiF6utYJp7CYBIDORJoTpH/PdIICU3T/Wc3Xf07k+31NQx66WtRM55xWUgSai67iIBv41BkT5yLXGqoGRhY6MTt+w0ux9Cqp0i21ic3lvJWfd51gpoxb2AZFynyPa64HqktT1vaX1L53G0nbVG3EOslRtBvrSIuwctJi93CDU+c5C8DMI1TKEGf/UUH4a+oBkhBm069TLdxnMJEEqTfhCXt/THcB53V7buAN7uyCOVGHOWwdetvewvNKaHFjIlxmSWZ5Kad6XGjl3jY2wgieV6mxuECQFZxge0l/P6A0v3HKRxKk2MB8kOm3JeMi1YDM0QXAqnolMycG/Ocy9KVdyMPgB2XDkam7mqHx7r9Npbp+OSDd9tFMl4RQvlzNk8AFaFCkhH1ld8MPA5EzJC9C6YYnihJceZl5R0hOTj591y85SHZMKefhBJ9Kc/Sc+oU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(2906002)(86362001)(31696002)(36756003)(2616005)(53546011)(8936002)(8676002)(6486002)(186003)(478600001)(26005)(6666004)(16576012)(316002)(66476007)(66556008)(110136005)(5660300002)(956004)(66946007)(83380400001)(31686004)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFFLVDR6YkRsZ1BmcGUwcnRJa3BOVkFVRG5yeTI3cVZ2M3ltUlJlYkowYkx4?=
 =?utf-8?B?VHdsMEJZejlFYldBZDdpOUVsSXJ2dVl5SVFTU0NNcHo4UGxxNys1L0hremVp?=
 =?utf-8?B?Zmd2RVo2cGU4Nnh1Q1pvM3VDUno2NXRGUU1meCtBbGg5QUZseFI0OENFd0tm?=
 =?utf-8?B?cENGT05MNXpjMHpLcVJEU1k0N3BqQitLQ2JOc1B2dUZjY2xRVExxQ2NOU3Jq?=
 =?utf-8?B?S0x1cnpRbk1zSVUvOVZyWXhFbXZoK0ZEb3FGM2VtWEJFMXMvODdFdDFjN09i?=
 =?utf-8?B?aWtRbzZPZEQwY1VMNVV2dGJiNHgxTGRzN1NEdkkrSjhUTWJPWlBZaDBXaVRJ?=
 =?utf-8?B?ZExDcUtzam5ETGRGVFdIcU5zRG80WnZkaUFnRUVFSElxSDZJeXBOdnR2VlVo?=
 =?utf-8?B?RFJnN3VxRkRnWUN5ZUN2Z0hhbHNlRTFKRmFPbDdKdjZIdjhOSGQ5bm9KMGY2?=
 =?utf-8?B?TFp6RzBOSVk1aWtlelR0ZjhybzFDanFSd1RTRUc5eldnRERDKzlVK25HeE9q?=
 =?utf-8?B?a0xjYVE5YkxpbG1VM3pjK0JwSmg2UnE3QlhRVnJDeFdwWUNvRERiVW82Zjlo?=
 =?utf-8?B?MFI2RDE1emxBbVZKbE5EY3VkL09hWkpJK2JyQ0xYaU9qUXhjMGtwWHlmVk5X?=
 =?utf-8?B?ZjduMHdBTHhPUmpkdGduaTA2a1hlZm9PUG43eFFBc240YWJwS0R3RlpXQmw5?=
 =?utf-8?B?QzF6VFZOMXdwQXI4OGpEVGpZTDN0a05TMmFHY1ZLTVJqZ0VKakliZEM0RWNK?=
 =?utf-8?B?NndXN2RScHFVbEpRS20zQkdRck5mYUNrQVc5Q0dRTHNzT3NZYXQ2d09yYWVT?=
 =?utf-8?B?eWxFcU9BL1VjQmJ4UDJteFd4VW43bUZmcnY1Z1UxUDVkbjhKTkJEVkpMUXZL?=
 =?utf-8?B?N3ExS29sNHlZZzNFZXZ4dkNDaEF0SXJQV2g5RGpYZTgrOUZrdXdjT09mOWJZ?=
 =?utf-8?B?bjN6eCsyTE82SkJ2RVgvblhpNllabWZ5YUJzbUpySVFGd1lWOFFCRXM2VFAv?=
 =?utf-8?B?K0dCVlZVZWYyZVhUU0pJSVk3SkdTRncwdjljV1FCNjR1MUlNcitNWXhCR3lE?=
 =?utf-8?B?OG5nQnQ0UzQ5dHYzVTFjOWpKS3JOWWM1MDZxWFczSW9DcFVlOGVnR25zTmV3?=
 =?utf-8?B?RzZvQTA2WHd0ODVqOHpZYmhXbkp6SFZlaFVFaGpiZGR4Z3dOWHY4RmFnRFhT?=
 =?utf-8?B?ZHV6SkRVWHhDQlllaTZqem9TZ1d6OUZWZWptWE84N1p5SXJGbnVzcDFXTGxz?=
 =?utf-8?B?cVh2MXgzM0U3aWUvUVJ5V3o5Y0NMK3ZEb0g0SFlsMlFEdVRSYUNHUVpzbDZQ?=
 =?utf-8?B?R21mV1UzazZrU2xSK25MNGR0bi9yOUk0KzMrV0FCd1lpTzM2ZTJ0TW85bU5M?=
 =?utf-8?B?dW5qNHBSUUFZYU5WamROU1F6SU9nRnZrOUpXUkUvajFyM3h2L3FPYkN4aDBs?=
 =?utf-8?B?b2J3c3pZZGFZdGl5emFQWERUWWFzbkVwbE5ZUDlEbUxTbTlSakFodmRuNFZY?=
 =?utf-8?B?RzhCMkJxVE1ybFYzT3RvU285cDJ2MkxKaHZiUGhpdXB5bjhSeFZUQVpXTkpD?=
 =?utf-8?B?RlIyUUlWZ2k1RHAyVmM3Z2c3V2lteGVFWGplT2FpUU1GMm9vdjRJMDAzVWFG?=
 =?utf-8?B?T2Q1cHl6cXh6V2c4cDRtN2E4Z2dXc2s2aWFhd3FuMXhWZGdXQjM0cWo2b1dp?=
 =?utf-8?B?Tkp0SWJvdkYvY1hBa0kvNVlQZlF3dDhBUWtpWXAwOWV3MStBbXdjbmEvZmVI?=
 =?utf-8?Q?svY00pYFOoxfBlGLmdCIDS6GzTadbCEt+Ats/9d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913210cd-ab15-4c0f-923d-08d96dc55533
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 03:54:15.7085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hj8yCJM6CD2tO35+XDYYpSHRKkSDhU1KCMrGYAVG5HjhmgurEGsiKlgmG59euUaC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5061
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

Thanks Felix for the detailed explanation.

Thanks,
Lijo

On 9/1/2021 10:17 PM, Felix Kuehling wrote:
> Am 2021-09-01 um 12:30 p.m. schrieb Lazar, Lijo:
>>
>> [Public]
>>
>>
>> What I wanted to ask was -
>>
>> Whether user mode application relies only on link properties alone to
>> assume atomic ops are supported? If they check only link properties
>> and if the firmware doesn't work fine, should it be still marked as
>> supported?
> 
> Let's be clear what "firmware doesn't work fine" means in this context.
> It means "firmware requires PCIe atomics". If firmware requires PCIe
> atomics and the system doesn't support PCIe atomics, KFD will not use
> the GPU and will not report the GPU to user mode.
> 
> If firmware does not require PCIe atomics, or if PCIe atomics work on
> the system, KFD will use the GPU and will report the atomic capability
> to user mode in the IO link attribute.
> 
> 
>>
>> Basically, what is the purpose of exposing atomic capability in link
>> properties and whether that can be utilised by upper mode applications
>> just based on PCIe atomics support?
> 
> Applications can use PCIe atomics by using atomic shader instructions
> when accessing system memory in GPU shader code. If the system doesn't
> support PCIe atomics, these atomic operations are silently dropped.
> Therefore the application must check the atomic capability in the IO
> link properties before relying on these instructions for system memory.
> 
> Regards,
>    Felix
> 
> 
>>
>> Thanks,
>> Lijo
>> ------------------------------------------------------------------------
>> *From:* Kuehling, Felix <Felix.Kuehling@amd.com>
>> *Sent:* Wednesday, September 1, 2021 8:24:56 PM
>> *To:* Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
>> <amd-gfx@lists.freedesktop.org>
>> *Subject:* Re: [PATCH 1/1] drm/amdkfd: make needs_pcie_atomics
>> FW-version dependent
>>   
>> Am 2021-09-01 um 7:04 a.m. schrieb Lazar, Lijo:
>>>
>>>
>>> On 9/1/2021 3:26 AM, Felix Kuehling wrote:
>>>> On some GPUs the PCIe atomic requirement for KFD depends on the MEC
>>>> firmware version. Add a firmware version check for this. The minimum
>>>> firmware version that works without atomics can be updated in the
>>>> device_info structure for each GPU type.
>>>>
>>>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdkfd/kfd_device.c | 9 +++++++--
>>>>    drivers/gpu/drm/amd/amdkfd/kfd_priv.h   | 1 +
>>>>    2 files changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> index 16a57b70cc1a..655ee5733229 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> @@ -688,6 +688,7 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
>>>>        struct kfd_dev *kfd;
>>>>        const struct kfd_device_info *device_info;
>>>>        const struct kfd2kgd_calls *f2g;
>>>> +    uint32_t fw_version;
>>>>          if (asic_type >= sizeof(kfd_supported_devices) / (sizeof(void
>>>> *) * 2)
>>>>            || asic_type >= sizeof(kfd2kgd_funcs) / sizeof(void *)) {
>>>> @@ -713,8 +714,12 @@ struct kfd_dev *kgd2kfd_probe(struct kgd_dev *kgd,
>>>>         * supported.
>>>>         */
>>>>        kfd->pci_atomic_requested =
>>>> amdgpu_amdkfd_have_atomics_support(kgd);
>>>
>>> Should the check be grouped inside amdgpu_amdkfd_have_atomics_support?
>>>
>>> This flag is used for setting some link properties. If there is HW
>>> support but comes with incompatible firmware, should the link be still
>>> marked as atomic?
>>
>> Our GPU HW always supports PCIe atomics (it's part of the PCIe 3 spec).
>> But some mainboards with older PCIe chipsets do not. Sometimes even
>> different ports on the same mainboard differ in their PCIe version and
>> atomic support.
>>
>> amdgpu_device_init always tries to enable atomics on the root port an
>> all the bridges leading to the GPU by calling
>> pci_enable_atomic_ops_to_root. The result is saved in
>> adev->have_atomics_support, which is returned to KFD by
>> amdgpu_amdkfd_have_atomics_support.
>>
>> The firmware change here does not affect whether atomics are
>> _supported_. It changes whether atomics are _required_ for the basic
>> operation of AQL user mode queues. The coming firmware update will
>> remove that requirement, which allows us to enable KFD for these GPUs+FW
>> on systems without PCIe atomics.
>>
>> Enabling PCIe atomics with the updated FW is still beneficial because
>> shader programs can use a subset of atomic instructions for accessing
>> system memory atomically on supported systems.
>>
>> Regards,
>>    Felix
>>
>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> -    if (device_info->needs_pci_atomics &&
>>>> -        !kfd->pci_atomic_requested) {
>>>> +    fw_version = amdgpu_amdkfd_get_fw_version(kgd, KGD_ENGINE_MEC1);
>>>> +    if (!kfd->pci_atomic_requested &&
>>>> +        device_info->needs_pci_atomics &&
>>>> +        (!device_info->no_atomic_fw_version ||
>>>> +          amdgpu_amdkfd_get_fw_version(kgd, KGD_ENGINE_MEC1) <
>>>> +            device_info->no_atomic_fw_version)) {
>>>>            dev_info(kfd_device,
>>>>                 "skipped device %x:%x, PCI rejects atomics\n",
>>>>                 pdev->vendor, pdev->device);
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> index ab83b0de6b22..6d8f9bb2d905 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>> @@ -207,6 +207,7 @@ struct kfd_device_info {
>>>>        bool supports_cwsr;
>>>>        bool needs_iommu_device;
>>>>        bool needs_pci_atomics;
>>>> +    uint32_t no_atomic_fw_version;
>>>>        unsigned int num_sdma_engines;
>>>>        unsigned int num_xgmi_sdma_engines;
>>>>        unsigned int num_sdma_queues_per_engine;
>>>>

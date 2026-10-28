Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BC9606A31D
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=d0kFWDyK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C1B810E099;
	Wed, 28 Oct 2026 13:53:53 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012012.outbound.protection.outlook.com
 [40.107.200.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA66110E099
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 13:53:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZlz97/TUM6sKnH6Uw4DABsfe9LqPQ/4+/SLRFtPuyQW+0BQY+mYizB2x8wIsRoP7M0IKUhafc27CmbeUo6pMIguhmr8peTxk54sfPHAd1JxWwaaqg0i5fKcxup4Ga7Nq0Z+en11qusKvtwGrrumAnVSWq4DUMPR/RvNjvLiGCUjX1avPkSRNH3u5b+VyrvBm3mN1oaZYf1wNoggBnyM0MsSsbIBTh1hPs0wGbokMUKRiXGo8ogz7Fc8zv3Nyn2AKwK7JghWLBjp637PWBTkY7FmcJk7XJxqOtvqZO4FPJY5itFHiokHdfvK+IxU6S7pErsoYZjvnfTiOxDzOqKuWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFJMKLsllbYArEI3IQCdNtwDE15okrRrefRvPTbzzJM=;
 b=u+KPrhruQKJDXjp/XCzXWYT4ONiKlvx1iNKIjQG9lSvj9hDnLCdMHKvB86TCz8Z8/LHQQRHnLi6TENIqE2VpoS64CjZgj6HFykNePOHfLc4O48p8XIb+XPGaEMJxRkELIy08ZyWwfLSMhwxLTD2tRpQkKx3vn0FvqTtKUPdIzHxdG0cpTr5icCiE/YMszFCw5bShR4JYlmj/B9f5xiIOWtRWwBXUpSM0tmHnLj4XQ9KmWC/T03rZ0AzFW4jqOD4NvENDsXYzrz438UuiVjyK7X9cl0BjiQRwIAK/gY77BkqG8r9NsOCikj0DGqDEzyIb2KCGp4BGW4gSAoVzEiRONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFJMKLsllbYArEI3IQCdNtwDE15okrRrefRvPTbzzJM=;
 b=d0kFWDyKTYzAql8891ADWyygnVBMJVJYGKe2RxRygI59U0xXdLR+FmbOpgUmrmWRuF2QGTfNojcipH8SOWjulvMpkKPGY4Ej57F1tKRMY4ZSkkUNCmPwn91cJnW4q2WbFrelkJzLuE9+22CdlUo1MxuGqTyAnG5N4w0mFmjQ4y0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by CY8PR12MB7291.namprd12.prod.outlook.com
 (2603:10b6:930:54::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 13:53:41 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%4]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 13:53:39 +0000
Message-ID: <0b5f7c6c-86af-4966-b18d-fbcf1b3cdf76@amd.com>
Date: Wed, 28 Oct 2026 09:53:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 4/8] drm/amdgpu: Attribute UALink loopback messages to
 the correct sender
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261027195913.1794477-1-mukul.joshi@amd.com>
 <20261027195913.1794477-5-mukul.joshi@amd.com>
 <0b9b80f2-58ab-4113-b308-562697650afd@amd.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <0b9b80f2-58ab-4113-b308-562697650afd@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0114.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::23) To PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PHXPR12MB999256:EE_|CY8PR12MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb227f3-a075-45cf-44f6-08df34fadede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|11063799006|4143699003|261009223027099003|56012099006|261021121427099003|261021123027099003|10067099003|261026121527099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uhTgjgEBM62o1eC+5n5qHbhoo7JGx37UuFYi+LXUOdIhsUMXxcw36bRUQ33E89Jwf92rOBvKuu85oMBW0/RvW4yL5YOF67F/iHTVI0LHh7N3A70SMk+WWJuRdjtDfSGjsC8o3A1kfQYyg8t8DWfXxekqzTiUsI70eeVMLOJcAbbaOQPU6IRq3aUJBPeCmTd/LdHMt9NtSXgJRFZ2LqacQEmeE6pvqLyEgay4Sx2IHkfgBujYns/0ASSqL/VOGeLAQylGNn5BcL9N03ZWtxOXz6dig+1U99pgN8Wa/4McBIlUD+HEbanzEjZg6t3zd1WgUUk6xhXyi9dR4OalbvYGIAvQA3DwG1jd3IDAg/rzOYgUD3JfPTNGJMJx0U37LAupBOzi0OqiD3jTncaSo18p6J5yqSXzU/nsN5Acjl63sTj4BEY4HSenghu9yzuyPEHAxGTkmdbXBrrSVtfho7/pCc1wSvFtrrbJLGCZq3k64Yws3Je/1IJMg+jafnFZm8s85fhjqVhP3pBU2qJyC5XMXjm67XVU4oNIwTdF6QVE17zZz6W7PiIqUL4gtOGt0+5suwcW+eW+vJ8cPZfmLAqBOgA0jT34kS0zm5HL0B9g4hrlKeetWrEXiO4nujCFQTX4lvQq6wtNwteuVD4fNkxHcg2Dw60v9WFnzGtod9N3EXk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11063799006)(4143699003)(261009223027099003)(56012099006)(261021121427099003)(261021123027099003)(10067099003)(261026121527099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3VGd2RlODN3dExaTzBESk1IbU1BWCtmeFdGQ3FTZTJUY0pxNjVyNjJ3RnlK?=
 =?utf-8?B?TnBBcGE1SURBRTEreEdWZDNPem5NcVU3L2ZUQnpwRzdBVnZmbGZFVXplZjVL?=
 =?utf-8?B?NjFsaHcrbGdDN2tIR3VuVktSbzhoOWgyTWRBUW8yaHY2KzR1RFJDV2gxTjFE?=
 =?utf-8?B?R3A4OHJRYnZwSHh3WHZ1ckl1eXB3dTB3Q3BBWkpqNUdyVkJQY0htNVgxTTJW?=
 =?utf-8?B?VDJ3SDVDcE93MzJaV2MxWXZKcnp3bHh1Mm9TR0lERVBicGlWSk1KR29OOXJw?=
 =?utf-8?B?UVl2WHpRSTg4amhONk1MS1Urd2ZlbVdBZnl4MVFFcUZ0SGE1Q0hYMTNsZ3RP?=
 =?utf-8?B?VVdWa3gyNEZXb0IzNmRUZDI2TFV0bjZ5T3NJSXRrV0pWZkJObHlWdFlYMVkr?=
 =?utf-8?B?dWpMMXRKczQ5Ymp1RENSVVhXaEtrTzdRMk5aSjdLejNLbzNYMDhlVnFrL1FI?=
 =?utf-8?B?THlrVFhkMGxYeVFNRXNFMGtsVnUwa1RjYWJsUlkrZ0orMjdFb2ZTR2hMT0ww?=
 =?utf-8?B?M0hzMlVxZTZlWU5HUmxYNy9XaXFQZCtDSW52UUVicmhTZlNtQVpLa3gwTDc5?=
 =?utf-8?B?QjVIb0VIUkVZL2pyY1AzVFlrWnlPTTA1VncyTjAvTDJDcjNvNFdadTdzWUJU?=
 =?utf-8?B?UGxJZVA2aWFLb0RzMEJ3MWtTVHp0bjVjSmZnSWtRRGtoV21UdWtrWTZLMnlM?=
 =?utf-8?B?MkJPWS8rVlVjMFVCRSs5VTdhOUQ2TXRYWGNlTzdJMjlJTGxFU1NnUHBuU29l?=
 =?utf-8?B?QUFHNzNXZEJQNXNHWmhwN2N3SXk1bzNMZXQrS0pUWGVBZ1M4S1VhWTIzVFFV?=
 =?utf-8?B?ZEhNM0xkZTFHY0hJRFBiU0JBRXhmL05HRHJsWTFBUDJBQk1aUzZiTFRqR3Ja?=
 =?utf-8?B?MzBXUHFsb1B0V040RVdDK2t5Y1pVeXY0T3NOdU8xSlJaUW9ndW9kT3pvMWY2?=
 =?utf-8?B?U2M0ZjFxRlg2Y1FSS2RHUzBSSTlmVnB6YzV6akJ0QmpmT2hyS2NScVhrTUJY?=
 =?utf-8?B?OHBQYWdUWC9xd2FFcXFvSlFjOU0ydWExUkYybUZyeTA1Z0hlbHk5R0lVOS8w?=
 =?utf-8?B?S0JlcDVTeEducFFqYlZtSGRBQSsyZUl1SmNwaEcvdkhCMmF6VHlkZDJKUlpk?=
 =?utf-8?B?ODIyRkxRUnZkUlJMQWNKOXhrSkUyOXYzd0lqU0o2dzF2WXFJK0gxeGhDdHRR?=
 =?utf-8?B?NXV2a3JWVUUvU1lKbnpXZGdXdjRVMDlXOHhrUkJlWlg0UDA1aHh4OW5tUk1C?=
 =?utf-8?B?S2R1UFRVWi8wMU9ZRnVSMU1NT3dZUG9aMnJlZElpOXlyVGZOQUtjOVJGalZE?=
 =?utf-8?B?alJpZFhSUTY2Rlg0UVc1TU0yQkEra0VWVW5tYjBFaEl0VnhjOGlhaytVVjBs?=
 =?utf-8?B?YzMwTy83ZVFzdi9pZkt1MjFYR2MzSElQMHQ5c3I4ZEFsUGpzdTBWOTZuNVMr?=
 =?utf-8?B?RVNRTTVPWmNpV2tRTFpuclVtNExwb2tybVNFYmU5ZjV0RENURmVMVTNXY2sv?=
 =?utf-8?B?R0s5RkN0NkdDcnVDZXlNbVBESFc5eXlqV0t4N0RsWFdRNElGMUdhNml3ZlM2?=
 =?utf-8?B?UHdKaXE5cEd4bkJweGlOTU9mMXNRZytLN05tNUpxaFo0K2NuTFFkaWE3ZW84?=
 =?utf-8?B?SXB0eGVsNGNPZ05icUVZYUJUMjNYckZLKzJTeHRtZkJzMm13RWwxcWdDR3Iv?=
 =?utf-8?B?bmhkcThZVG9hZEdLVVhyaHF1RHl4Q05TdVFqdmRuSFdpNmdsY1FWak5MNTE4?=
 =?utf-8?B?K0UvVXJGZjBHNGtMSnVVZE9lOVk2OHhOR0tBN2hlN1JXZkJ1anlWV2FjQ2pN?=
 =?utf-8?B?MWFDQ1E5RkJ6MDA2cDVKcUt4WlBWREhJdE5RK1kwb2pNUE1adjFmcFpsZGI3?=
 =?utf-8?B?ZzZWNVBYY1FjWGRxbmpFSmhIZWR0ZngwYVhRSHNkNTl5WTZMUmdMUHdEUlNi?=
 =?utf-8?B?SkgvcFNlUnZSQVRTMU1jYm9ZYzIyTXZnNkFxNkFJWjRkNXk2MnJHUDA4UzFE?=
 =?utf-8?B?VlZGclZGeEVPRkJ5TjJ3NEUzMmczQythWEd6bHFOWU04T1hEazMrSGFEcXVP?=
 =?utf-8?B?bkpVK2JCTUc3bVhBT2RtTzBNUGo2TWs2ekd5bXpvOWliREZseEJQODZqUWxK?=
 =?utf-8?B?WWtYMmlSUmNjQXNhOG9mMjJIcGVRMHlBcStHSVkxV3BENlZzbEREZUVLM2lQ?=
 =?utf-8?B?bFNyNWk3a3RnYkJ5WlRNeXRuVitzSzJLNktucUV2TXp6OEdEVGZkcXl6aDlP?=
 =?utf-8?B?WEhZZ1I0ZkVPRzNSMlVUbjNUQjYzUXNxSDg1RVk4LzE2Ly9qeVBDQ0xrekhm?=
 =?utf-8?B?QWdPNmdJWVhpajZUSHI5SXRkU0RmUDN4VE9pbVozL1BNVEk5aE9oZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb227f3-a075-45cf-44f6-08df34fadede
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 13:53:39.6438 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcjvMa9lT9db5TMYE6n1dqkG16W9JOawzZAjLzvkGETcQdzSSbaqEZUs2/TgZxDUrhJeBvOE/d01lohcWxI1VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7291
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/28/2026 2:23 AM, Lazar, Lijo wrote:
>
>
> On 28-Oct-26 1:24 AM, Mukul Joshi wrote:
>> In UALink loopback mode a single GPU acts as both the exporter and the
>> importer, so the sender accel ID of a message depends on its direction.
>>
>> - Send HELLO as the opposite role of the destination: a message to the
>>    exporter is sent as the importer and vice versa. Outside loopback
>>    this is still the GPU's own accel ID.
>>
>> - The MP nHT stamps the IH cookie of every HW-delivered message with
>>    the GPU ID of the single physical station, the exporter. The only HW
>>    path is importer -> exporter, so attribute these messages to the
>>    importer. SW-emulated exporter -> importer messages carry no IH ring
>>    and already name the exporter as the sender.
>>
>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>> ---
>> v1->v2:
>> - Use ualink_exp_accel_id/ualink_imp_accel_id() wrappers in
>>    amdgpu_ualink_process_irq(). (Lijo)
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 32 +++++++++++++++++++++-
>>   1 file changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> index 6c70be7badec..96a6023f51c5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>> @@ -1090,6 +1090,23 @@ static inline u32 ualink_imp_accel_id(struct
>> amdgpu_device *adev)
>>       return adev->ualink.info->ppod.accel_id;
>>   }
>>   +/*
>> + * amdgpu_ualink_local_sender_accel_id - sender accel_id for an
>> outgoing message
>> + *
>> + * Normally a GPU sends messages as its own (single) accelerator. In
>> loopback
>> + * mode the same GPU plays both roles, so the sender identity
>> depends on the
>> + * destination: a message to the exporter is sent as the importer
>> and vice
>> + * versa. Outside loopback both roles collapse to the GPU's own
>> accel_id.
>> + */
>> +static u32 amdgpu_ualink_local_sender_accel_id(struct amdgpu_device
>> *adev,
>> +                           u32 remote_acc_id)
>> +{
>> +    if (remote_acc_id == ualink_exp_accel_id(adev))
>
> +#define AMDGPU_UALINK_LOOPBACK_EXPORTER_ACCID        1
>
> 1 is a possible id in a regular vpod config also. I think a check of
> loopback mode also is required here.

We check loopback mode inside the helper, ualink_exp_accel_id().

Thanks,

Mukul

>
> Thanks,
> Lijo
>
>> +        return ualink_imp_accel_id(adev);
>> +
>> +    return ualink_exp_accel_id(adev);
>> +}
>> +
>>   static bool amdgpu_ualink_is_local_accel(struct amdgpu_device *adev,
>>                        u32 accel_id)
>>   {
>> @@ -2238,7 +2255,10 @@ static int amdgpu_ualink_send_hello_msg(struct
>> amdgpu_device *adev,
>>         dw0 = AMDGPU_UALINK_HELLO_MSG;
>>       dw0 |= (remote_acc_id <<
>> AMDGPU_UALINK_HELLO_MSG_RECV_ACCID_SHIFT);
>> -    dw0 |= (adev->ualink.info->ppod.accel_id <<
>> +    /* In loopback the sender is the opposite role of the
>> destination, so
>> +     * the exporter side tracks the connection under the importer
>> accel_id.
>> +     */
>> +    dw0 |= (amdgpu_ualink_local_sender_accel_id(adev, remote_acc_id) <<
>>           AMDGPU_UALINK_HELLO_MSG_SENDER_ACCID_SHIFT);
>>         dev_dbg(adev->dev, "SEND HELLO: HELLO message to remote
>> AccId:%u\n",
>> @@ -6548,6 +6568,16 @@ static int amdgpu_ualink_process_irq(struct
>> amdgpu_device *adev,
>>           return handled;
>>       }
>>   +    /* UALink loopback: the MP nHT stamps every HW-delivered
>> message with
>> +     * the GPU ID of the single physical station, the exporter. The
>> only
>> +     * HW path is importer -> exporter, so the real sender is the
>> importer.
>> +     * SW-emulated exporter -> importer messages carry no IH ring and
>> +     * already name the exporter as sender.
>> +     */
>> +    if (adev->ualink.loopback.enabled && entry->ih &&
>> +        src_acc_id == ualink_exp_accel_id(adev))
>> +        src_acc_id = ualink_imp_accel_id(adev);
>> +
>>       msg_type = dw0 & AMDGPU_UALINK_MESSAGE_HEADER_MASK;
>>       local_acc_id = adev->ualink.info->ppod.accel_id;
>>       dev_dbg(adev->dev, "Got MSG: remote acc_id %u msg_type %u\n",
>

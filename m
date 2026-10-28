Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E05606A31D
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Od7t91Rs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27AA110FCCE;
	Wed, 28 Oct 2026 14:44:12 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010014.outbound.protection.outlook.com
 [52.101.193.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C46B010FCCE
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2026 14:44:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGG54ZP3jsFzE8E+C6mD120qf1/f1Et+V6KgF2J2rC98VQBywCZLZY0jmqkOoqGdwvMqbUfS9no5/856/QVZqOzlWagwuwDgqk40j1lL/ITLEivNPAMDlzT9X3CuU0Pj4LO7ZyzzFLLFourZuAOGd1rjsz9SL5fIDYHjevzvB4AAbgBd/Z2Ob9FaK2lZ0XaN8o5LN2eQkNSAbxrb8Xi1zIcWltHsczjLPoixmZg1aqMYeU2CuGt6R4U2lSpoNo81Ky2QmwDdb9V3V6JZMrI5qFvW/K7kJW6WBa58CHCfG6jhaJ1rMHhDZBcoSShQJSJEtWaVI/miWkrlrry8/WhLdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7i2MdiTkLRJ+XkPdUM4LMORE/K//UGSE/oQIE5cyI5A=;
 b=zBBRK1zLGYbzGfhRSwT/3x9DigUJqF7FN4wNOOk7fI93Fuha2dM2cCnkB544SAP3FmBM6ynN0fuu7c9R6X8a7aYyfEu/tOrOWBjmoGKrjZVG98fF84nLj9VJ/osjsNjjssyfO5mlcazCMbS/Y4S+qINzL1ifGiPcw0H7u4veCWICoopnGowsmt53u3b0Hy+LtRFgS4OurIgj0ZcfjZ8n6L/HnKAt87Qb/2p05EnfmAAobZo43S9kp6TBsBRwxErQvPH2VcRM4XoXYcAlzZ2WnRy5AjsUlnZw9nwFfZiMrml7d0YUyvWN1lMVQ3Bv4yWq1hbZWU2nW0tsliQQ2iX2nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7i2MdiTkLRJ+XkPdUM4LMORE/K//UGSE/oQIE5cyI5A=;
 b=Od7t91RsOlEZtFlPXDVWpRehQMvt7nyYuR/B1GubzWje1cDer2pXhFyxmGw7rBzK0jI7UZ7BcKV/b0n9vrqL30WOVZNh3GF87q7e9YAJ2+8pS1OJMzD7EaYFUZmIlsRKWggfsywScxYdGz9O7t5pM3WAKBsr9JtiWW5t/HQ8zzk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by DM4PR12MB5842.namprd12.prod.outlook.com
 (2603:10b6:8:65::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 14:44:00 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%4]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 14:44:00 +0000
Message-ID: <42ed2e2e-1e36-4deb-9825-a00cb42d110d@amd.com>
Date: Wed, 28 Oct 2026 10:43:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 4/8] drm/amdgpu: Attribute UALink loopback messages to
 the correct sender
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261027195913.1794477-1-mukul.joshi@amd.com>
 <20261027195913.1794477-5-mukul.joshi@amd.com>
 <0b9b80f2-58ab-4113-b308-562697650afd@amd.com>
 <0b5f7c6c-86af-4966-b18d-fbcf1b3cdf76@amd.com>
 <18feb9ae-d755-4ad4-9dc5-7f80880a2991@amd.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <18feb9ae-d755-4ad4-9dc5-7f80880a2991@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::8) To PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PHXPR12MB999256:EE_|DM4PR12MB5842:EE_
X-MS-Office365-Filtering-Correlation-Id: 6822c949-bb2f-40f1-b461-08df3501e770
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261021123027099003|56012099006|4143699003|11063799006|261009223027099003|10067099003|261021121427099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: RbLNRZzeG5rWtO5/AjMlrGXmVZBFsqi02UEYzjhN0dNPH8owHC1no6u1nZ+MS2r5rEf9d+QdqXfLvxXHn+uGpsdAUgmXXj3wUk1uL2N73MMw+npJB9IXgXkYLEO5OZzCKQ+o7RZX45w2KNP+CtQqnD/T+or/lnTp9zpfhkYH0Gtd3sFa3dljdfxjh4fE3r3/bGIdLDt8Zzu1FWhbbr7pe847xIPm95gP82mNKwzGSyjZ+AXg0AqVr9gPMKuHt3kUqbSq9KqPWXU6B9w31n6979ZR3KnizyvMGxou1qzzFL/VMEEpg1Zu8BSmtLz0NwBILvo5oMLPfLe90zbRFgFiKy3J0KVI6ySTr41HERekNUXuNaWX6jzlgYQ8oyNTxsVbXErNRME+23tC7XdEISVqKofJZ45+9ob9KbgxGf5nUkTSuGikJQdGNtJlyk/c2Amm3WlWzMoF7eSAayW4CbtAY2kQslhj4SM+j7U3lqatQEwoSjbxGwdJtLHLfh89JGxjfPwaOky9c9S4iG/1tQXl8TIQdRRyvNj7oSdk9Q/n6FkwYXY9rCeYK+pEgTXCib7WTfAs29SedqdanhrI8cbCogGtvf2LvAM+6IIwEJqCqehwj40ruzQFwYvwGQbKLXduIIzRfpxcMGyUvHA5W9AZw8wDYege6KerrW97cqd1lAY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261021123027099003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(261021121427099003)(261026121527099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnpVb21VSFFsL1RNTTl5ZUN0dTZDUDQxbStiRjhWM3FzV2JHdVlwM1IvK3pa?=
 =?utf-8?B?amN5bEsrRzlwYjFTNnpjWU5rcWJOekRDeTg5TlBQRzRtelI0MWQ2azROQ2ZZ?=
 =?utf-8?B?bkVJSnFMdWVzamVMN1VZWGRySld4VEVIdm0xWW1nN0hPVHRNaXhDcVI0dXhz?=
 =?utf-8?B?Q0x4MHdtdStZSExPSTc3b0FENjQrYWRkZjBjVEVOaTR4RnlENzJMeWxGdlI1?=
 =?utf-8?B?MmlsSFpTS3dMMTQvQzhFWjNHRmdXQis0ckRjRjJIWm54YzRrSXljSjg1SXVV?=
 =?utf-8?B?TktwWUlQVllRODUrWjNQRjB6SDZyQmlZd1FEWXlTS0h5WHFBNWtMSU8rZ0RN?=
 =?utf-8?B?Qy9RY2FaMHZZU0lsbWNJaUtva2FOSUZ1ejdEaEFGRmxBRHJXSFhaekZrR3hL?=
 =?utf-8?B?S2NpK3A3Y3JjSktlMkFiT2RhR0JwWmc3cG13ZVZsdDQ1NGUrMVFudkNLckFL?=
 =?utf-8?B?RXBJM0poeGxQT0xrYVAyeEpackFyWElJMWUwdjNYTHN5blVmam5PbXdtSU1W?=
 =?utf-8?B?My9FZmZ3UVRpVndTdEgzMjY5UUgxbm1VanVtUzhaTk5vcEh5K1c3RUs0dHhD?=
 =?utf-8?B?S1k2SGY1VmJpZmZYbnUzWmRmc1N3ZG95U2lESHBEUjluNWdWMHlCZFRFRWs4?=
 =?utf-8?B?clcrYXJxaWVicDhiOFFUVFNXQkRsdWdPY1orS2podlNFWlNNNjdFRGFId2dE?=
 =?utf-8?B?ZXRQUlhwVWJxUWREaTZ1a1U3QVArd1dXbkx2S2xaZHBqZnd6LzNTRjNJVTVK?=
 =?utf-8?B?bTg4ZjQxbXByVW85U09MMmF3UldISnJxZ0F1ZG1odytqYlJpZ3BDTi9DUmdF?=
 =?utf-8?B?dnJMZURMdUV3eTJIRDZUSkNpNUVRZklJQmtzZXJzZnVWdWhXNnVsVk5OWnoz?=
 =?utf-8?B?ZW13N2F5M0MwQ1p6TE9iK1VOWEpxSkQvU0VPaXNaUmxsbW1kM0JaS0pZemZ2?=
 =?utf-8?B?MFZyL0t6T2ZaT3MrR29id0haYVZTU3A1QzBWbnpmVmhMOFU5LzVtM1BieU1P?=
 =?utf-8?B?dEFhNXp3NDhJQklzRnVCYWNqY1ZPUGthZksweWF2ZjloRW5KUi9zd1dMdURZ?=
 =?utf-8?B?emRWRERwK2VISHBMV1RFSWlNbnhINzZmVUNnc0NBSmR6Yy9SY1ozdUVzdjVr?=
 =?utf-8?B?ZHE4ejR4QTNtVHB0ZkQyKzlzR082Q1RKNllQaU5KR3RuLzNoZ211ckdsc0RH?=
 =?utf-8?B?WTVwVmI2ZFplUVFtWXdxTDZHUGRMaDlHNmJKd3ZNWHRiOHNKdW1UYjdsZXRw?=
 =?utf-8?B?bExUY1gwSHFXdGEwTTgxM21rZnMxaEdHUDRPT1ozSG5NSUtZVXJhdk9Xb2hJ?=
 =?utf-8?B?R0U0YWZMZ1RjOFNjRS9JNWJkMG1CZUp2SEZVRG5FbExPbFh1MDc1V0xRTk1O?=
 =?utf-8?B?UzRRSHFKemgvR3VkcG1YaFM3blF2bHBJN21kc3hoZzVaeGYzbnJLRHF6aXNL?=
 =?utf-8?B?L0xGeUk4Q2xqZ2phcmY0OENhK3JCVDZMai9zN0VhVFRReXFUMVEwWm1XdWtq?=
 =?utf-8?B?MDFkRmZaZmZHREEzRXVRVU53cUd1ODN2YzFnSmFrN09XaEZwaEsxM2Rodngz?=
 =?utf-8?B?VStYNWdadndzUjc1Umdia2dmTEcwSHBwNG1mUEhxbjR2ZkVZTmE0SUZUUC8z?=
 =?utf-8?B?ZktKeEdQQ3owRTNSc2Y2dXlLcTh6ZFFCc3EyVGh2M2NpQ0R4ckFLdmJGTlls?=
 =?utf-8?B?aHMwY1MvdWF6OGpybjRyMWxrR1RwSDliV0VMLzEvNVVDaGVzRGtpYldVQldC?=
 =?utf-8?B?TUNxbTdwMlF5RzljUjJrdktnQVFrQi9ma29YcDFjOXN6TGN5aVJ0VkdQSnMr?=
 =?utf-8?B?VGFjSnRsMnhONjZ1amlpMEF1LzNJQ3FRQ3Flcnh2UGZRdFU0eGhVUDdBUDZC?=
 =?utf-8?B?djBCd0xHVVV2dXdJa0l4aGZ6d0RkTWpTV1N5WSt4SjVLV0xqL29BOXVkOW1F?=
 =?utf-8?B?NHhEeWtjQktTSG15bWZzUE9YMXluKzRNTUorU2ptWlpJQTV4TUxpRVdlMUp6?=
 =?utf-8?B?V1dnUlIzL2x2UUhnSGd5RUVpNFAvSjI3Tlh4TXVuTXlCMnF1TkcwblE1MGd0?=
 =?utf-8?B?R1draThkcDRMZFlsWGtCZHAxbGUxNEg3Mk1hdEdNWVZCS2E4RmYzd1Z4Y2xY?=
 =?utf-8?B?dkpRUnRjYnpldzhhSitJa05Oc3V0K2VTc3ZXYlFOTE1zQmN0aE5Za216RzR5?=
 =?utf-8?B?NHRUM1B2OEFFOGJkWHZTUXE5c0tzQ0o2RjArQ3g2TWltemV1YVNkbFQ4TUJD?=
 =?utf-8?B?eHFPUW5rOERXMEpVSW5iakhnQ1JIcHBUMmMrNXBFVCszNWNXRytIeDBYUXAr?=
 =?utf-8?B?UkJ2VW9ab2pDSDZWT2lTNXBQbVhCZHZoZGRQL0tSQmYzRHA4UklLdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6822c949-bb2f-40f1-b461-08df3501e770
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 14:44:00.4998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r2A6LTyWAhQM8HefN2hvkwT0UlaTcMWGgrqRCnHj96l2uT3WRhLo5XV4a+gsl/2KrM/g0r5pl1GXoo610otVYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5842
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


On 10/28/2026 10:00 AM, Lazar, Lijo wrote:
>
>
> On 28-Oct-26 7:23 PM, Mukul Joshi wrote:
>>
>> On 10/28/2026 2:23 AM, Lazar, Lijo wrote:
>>>
>>>
>>> On 28-Oct-26 1:24 AM, Mukul Joshi wrote:
>>>> In UALink loopback mode a single GPU acts as both the exporter and the
>>>> importer, so the sender accel ID of a message depends on its
>>>> direction.
>>>>
>>>> - Send HELLO as the opposite role of the destination: a message to the
>>>>     exporter is sent as the importer and vice versa. Outside loopback
>>>>     this is still the GPU's own accel ID.
>>>>
>>>> - The MP nHT stamps the IH cookie of every HW-delivered message with
>>>>     the GPU ID of the single physical station, the exporter. The
>>>> only HW
>>>>     path is importer -> exporter, so attribute these messages to the
>>>>     importer. SW-emulated exporter -> importer messages carry no IH
>>>> ring
>>>>     and already name the exporter as the sender.
>>>>
>>>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>>>> ---
>>>> v1->v2:
>>>> - Use ualink_exp_accel_id/ualink_imp_accel_id() wrappers in
>>>>     amdgpu_ualink_process_irq(). (Lijo)
>>>>
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 32
>>>> +++++++++++++++++++++-
>>>>    1 file changed, 31 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>>> index 6c70be7badec..96a6023f51c5 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
>>>> @@ -1090,6 +1090,23 @@ static inline u32 ualink_imp_accel_id(struct
>>>> amdgpu_device *adev)
>>>>        return adev->ualink.info->ppod.accel_id;
>>>>    }
>>>>    +/*
>>>> + * amdgpu_ualink_local_sender_accel_id - sender accel_id for an
>>>> outgoing message
>>>> + *
>>>> + * Normally a GPU sends messages as its own (single) accelerator. In
>>>> loopback
>>>> + * mode the same GPU plays both roles, so the sender identity
>>>> depends on the
>>>> + * destination: a message to the exporter is sent as the importer
>>>> and vice
>>>> + * versa. Outside loopback both roles collapse to the GPU's own
>>>> accel_id.
>>>> + */
>>>> +static u32 amdgpu_ualink_local_sender_accel_id(struct amdgpu_device
>>>> *adev,
>>>> +                           u32 remote_acc_id)
>>>> +{
>>>> +    if (remote_acc_id == ualink_exp_accel_id(adev))
>>>
>>> +#define AMDGPU_UALINK_LOOPBACK_EXPORTER_ACCID        1
>>>
>>> 1 is a possible id in a regular vpod config also. I think a check of
>>> loopback mode also is required here.
>>
>> We check loopback mode inside the helper, ualink_exp_accel_id().
>>
>
> Thanks for clarifying. Adding a check may be a bit easier to read.
>
> if (!loopback_mode)
>     return adev->ualink.info->ppod.accel_id;
>
The wrappers are handling all this in one place, because we need same
check for imp_accel_id as well.

So, better to keep them in one place I think.


Thanks,

Mukul

> Thanks,
> Lijo
>
>> Thanks,
>>
>> Mukul
>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> +        return ualink_imp_accel_id(adev);
>>>> +
>>>> +    return ualink_exp_accel_id(adev);
>>>> +}
>>>> +
>>>>    static bool amdgpu_ualink_is_local_accel(struct amdgpu_device
>>>> *adev,
>>>>                         u32 accel_id)
>>>>    {
>>>> @@ -2238,7 +2255,10 @@ static int amdgpu_ualink_send_hello_msg(struct
>>>> amdgpu_device *adev,
>>>>          dw0 = AMDGPU_UALINK_HELLO_MSG;
>>>>        dw0 |= (remote_acc_id <<
>>>> AMDGPU_UALINK_HELLO_MSG_RECV_ACCID_SHIFT);
>>>> -    dw0 |= (adev->ualink.info->ppod.accel_id <<
>>>> +    /* In loopback the sender is the opposite role of the
>>>> destination, so
>>>> +     * the exporter side tracks the connection under the importer
>>>> accel_id.
>>>> +     */
>>>> +    dw0 |= (amdgpu_ualink_local_sender_accel_id(adev,
>>>> remote_acc_id) <<
>>>>            AMDGPU_UALINK_HELLO_MSG_SENDER_ACCID_SHIFT);
>>>>          dev_dbg(adev->dev, "SEND HELLO: HELLO message to remote
>>>> AccId:%u\n",
>>>> @@ -6548,6 +6568,16 @@ static int amdgpu_ualink_process_irq(struct
>>>> amdgpu_device *adev,
>>>>            return handled;
>>>>        }
>>>>    +    /* UALink loopback: the MP nHT stamps every HW-delivered
>>>> message with
>>>> +     * the GPU ID of the single physical station, the exporter. The
>>>> only
>>>> +     * HW path is importer -> exporter, so the real sender is the
>>>> importer.
>>>> +     * SW-emulated exporter -> importer messages carry no IH ring and
>>>> +     * already name the exporter as sender.
>>>> +     */
>>>> +    if (adev->ualink.loopback.enabled && entry->ih &&
>>>> +        src_acc_id == ualink_exp_accel_id(adev))
>>>> +        src_acc_id = ualink_imp_accel_id(adev);
>>>> +
>>>>        msg_type = dw0 & AMDGPU_UALINK_MESSAGE_HEADER_MASK;
>>>>        local_acc_id = adev->ualink.info->ppod.accel_id;
>>>>        dev_dbg(adev->dev, "Got MSG: remote acc_id %u msg_type %u\n",
>>>
>

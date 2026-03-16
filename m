Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939D5F46456
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 11:44:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C43110E49F;
	Mon, 16 Mar 2026 11:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4seoBBak";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A411010E49F
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 11:44:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awGizDSB+U1EaOU+izrx6RwjdRB96jlEK3B87hGlj16YdJCEuHXsH6sEe222r5PLOtV9/47FUeiM7d5QfS6kS8P64q62wDXyRlF5SqkHsLbL7yTTy1utq58YsywQrDlYx8g2P/V549BOWgf8sNAZeT0WiRyPYkw7MvW7CDnxW9UFV3cI0vGpVwdJWITqHsPgUFmecLaLF6mU0F+Wh5kQZzmjf2ESCRhdBU2+RV6jNaSVIhLtnxk/ACwxbrIxFdQ5v2/oRxTWUFcdajMjgtED3s3XY25lWsAQgdwy7JdRPpaT2Hafuc20YdBRuQFNnDeW5fV9ofJfyrE9LmFAuzbj1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6i+h2ZjYw+C3dcAuAkQ/O+0ko+3kUObzTa7LvfS28E=;
 b=dtChBCqPO7c6aIY84W5eE3IvWe/iDl4XjOCqPg/naTDwGtdXOtb8jYsUO805PC57UNMmDpWj0J2EHCrVbyOl5kLAptFvXbqxMMADLaYnE1wT1Wk+vdMkUxR44wB4IU0QcDMmYu55ibpo9TNqdS7ZmeOpmqOtxZePKUeBbAbZ95xeYYQDM4WD2K16wGjsCpRP/r8iO+HZOPb9B6yRSTpNYx0bF1yMaguFd4yQeFoA8+W4hnS2HFLNoqAoi+WJCnbk76eF/SV1RvWP7MHGV8FqJFmwMZ8Ldj4kkaCGMLLQkRP5bVsdWR58eM1gTIHoSPofwWLGK9sjuc0dOFDc/v+zZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6i+h2ZjYw+C3dcAuAkQ/O+0ko+3kUObzTa7LvfS28E=;
 b=4seoBBakzOIncxqhnriXmGKxEUJRUrPnd3K+uXxSvWobC99VUNk/uxzvKVfi9KsRryL4Rqwk6QXd1jeQXHMLbwdtXCxoXtmgX6huuH87HOuaLGw4jmZeCUME05sQMwvEqjx04D4bvFE2Ei+ZmPKw13IS7R85k9EqzQH7MfZc6yI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY8PR12MB7196.namprd12.prod.outlook.com (2603:10b6:930:58::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Mon, 16 Mar
 2026 11:44:42 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9723.016; Mon, 16 Mar 2026
 11:44:42 +0000
Message-ID: <cbccd8b0-e35b-4436-b18c-efb7180a74ce@amd.com>
Date: Mon, 16 Mar 2026 17:14:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: avoid KIQ HDP flush from VM CPU commit
 during reset
To: "Zhao, Victor" <Victor.Zhao@amd.com>, "Xie, Chenglei"
 <Chenglei.Xie@amd.com>
Cc: "Chan, Hing Pong" <Jeffrey.Chan@amd.com>,
 "Luo, Zhigang" <Zhigang.Luo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <8738adb8-9c4a-45d3-b515-08c7cfbc5b29@amd.com>
 <20260311193123.2531557-1-Chenglei.Xie@amd.com>
 <SJ1PR12MB61212CEE0DBA45B1BD76768A8047A@SJ1PR12MB6121.namprd12.prod.outlook.com>
 <946d46d1-3778-4261-b1c4-9ccd60133246@amd.com>
 <DM6PR12MB43404FA78497B51EF4B90C2FFA40A@DM6PR12MB4340.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB43404FA78497B51EF4B90C2FFA40A@DM6PR12MB4340.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::28) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY8PR12MB7196:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af981b3-224e-4ea0-5aee-08de8351696b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|7053199007|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2UMNRIezKAXmtoe2fJOvaLAkl5kE3wpdVaDWxAqpTAsbYSF/y3qJ3uecTKAK4CYWBoxVWmr8q8NejIqdz9sGOd/shtD/C6/W0P7lOdwiqo49XxU5jf9BoL6oxVVOQodjeA8QSKd4mv2YzPhLjgAB/zu6SDxFkuKrT00qN4ZhDed815cqYu113XaWrSXT4Ilh02IMdqzrm+wfI80M/D/bP/MkS9fwvhAWY1X06POJ+aiaQzuPDKfNyLrXrCGU4TN/Pg0DD+UTJr3eBeqj0r+svVcm6RuqP6QDAJ16YeyT5xqk5LDqBXHszPezqeNqyy0XXHxQ6Of7FAaBR2F0u56dXwhduxHD8WwKoQpu2S+hD+KIAj4+q49JIBnhbvo+6RmNVt7r49rgVRngzbEIqmrElNahibrbtXsb2xLTUnJIGrYAtB8/ow6800jAkrrWtTizR2MXLeNwNOu1GgI/6Bwlu39DgRfCPMS78TutXzvmT/eEga4+SBfWWvsmvPwbfoIWifr8ijZKmDCTfSLKU8bskCiJUOH/j8HSVxXcnJCFdGPWE/KAW0QeRDIbOKx4hKuhvTjARtIFKa/eUY3j4WLMstE+7oSu+O62HTEbNc1CVsV+m9Hyl2VTwK6y9CWq7z0nWfMf1eDUoRCezo0RzH/0nSG73Xw4IE53oTTHxShSRFwALbO6KLjqZQNDxqtJojTGFrMIjR7zGnuWDl70qXhlC73CjylnWRg1dg+PAG2ZlBs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(7053199007)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlErR2JkK0FJRnFkVEMrc24xTmNDTTZuOVg4MHBXQzBtUTFlOXhmNkZwNUVN?=
 =?utf-8?B?WUxwWUVpRDBQMHB6ekhFNDE2UElBekcxQThNRG9PLzZmMldkOVRhNXZvd214?=
 =?utf-8?B?dUNHZHkvQnd3MGxPV1J6VUJpWFcxNDl0UENXK0J0WndCZUYyNWVJNTF2MlFi?=
 =?utf-8?B?RWdzRXAwTEIwSVgwbzYrQUdubFFpWUpXMWd4eWxmN0hRcEhUSFZhdXRYalY0?=
 =?utf-8?B?dEh1TVhqTi9oWlBZQ3VZY3VzbTRpMEhzcURPUkx3OUw4am1DVUxYVHFKNnl4?=
 =?utf-8?B?c1k1OEljQzBuajFpOThQbkxka05MVEpia1ZuNXZEWllCNmY4WVZLYjUyMU1y?=
 =?utf-8?B?MENFdXFRL1NRSGkyeTBXWVJCRHM1TUE1YU9YeVRyeXJ3V1RpcEdVR2xFMno1?=
 =?utf-8?B?M2U2OU8rYllHTFBZRFV2dXYxSXpmZjcvZEdPY20xS1FmYUtxTHY1V29ZaVJG?=
 =?utf-8?B?ZmdiTXBvWXJERmpFRXU5OS8zaFNBMkNrbXNxeW9ZMVRWdE9oZU1KNGVRZ3dK?=
 =?utf-8?B?cFRjT2tjNjRvOEpheVFQMUxmeXBnVlY0SmpONE9Gclhkd0tVSGN3NUl1Ym9B?=
 =?utf-8?B?K2s1dVpsTkIwbXlybTJ1QS9mUzFvUEVPWkdLRm1JMDdzM3o5Y1VCODNlZi81?=
 =?utf-8?B?aWV4VHZOZHViM29YZ0FFNWdiSjZXVnpRdW10ZUdRZi9ic01mUURVMnFHY2F1?=
 =?utf-8?B?SHpFNVVIQnZSZjFXdjlIbkRldk9RYTVmd24xQmp4VDRST25QdjdYbjlydzFF?=
 =?utf-8?B?UjBJLyt2T2FzK1hteHQ4c2dmTDF1L0xwUHpRT0J4d0xaQVRPUHk1bjFnYWhI?=
 =?utf-8?B?TFZKMHRJdW1oaWhpQ2J5d2d2a0ZJSE9NVUc1YWRwUkRCV0JzZGVNZ1FiYkpE?=
 =?utf-8?B?bFZTQ0xjd00wMDhNZk9vd3VQak1NVW5RVjFNS2EyZ2JtQkhyZ3NoT0MwcUJm?=
 =?utf-8?B?dXZpbFY3S1dzYjJERlNEbFA3bElsWDkzL1JkaUZnMzFHd05VMVFwQ2tTVkhx?=
 =?utf-8?B?MG9mV3RQbjhlMmMrRm4rU29QVzlOZHRvMi83V0IreUNlZ2RGMzdFYStmYWNo?=
 =?utf-8?B?RTJrL0NMSXUzLzQwaUFoelBtTnNUR3JuL09YRGdHaFJmTnpSZXpTYW5xbkpJ?=
 =?utf-8?B?Y3g1QXdINlY0ZjRoYVNVdnB2MUIyYWJMU0QyZTZLeGhwSG1PZXBJejl3elJk?=
 =?utf-8?B?L2t5aUhVa2pHRTFsYUZyaW80Q2ZiSnd3L2gzWjlBdWVmUWh6bzdDdFlmMkZV?=
 =?utf-8?B?aE5Ca2VqRythcDZqTWZZZEJXZHlMUmpHTGV2bVQ4QVRKUG9vNGc4YmhXbnBW?=
 =?utf-8?B?RXFCZE5aeWpoenNFWWFvaTJkTk9qeDZuWk5OYVg3S0pjTFk2aW54TlVORXJD?=
 =?utf-8?B?ekN4ai9DVFVvZEVXKzhGL2J5TFNWL1JYWE5GRHV4N0VhWDg0SDdranNDOVA2?=
 =?utf-8?B?Y3g4R2N2bVdaN056N0JvVGtNOHc1RnVXVEVpamphMmRFd3RXcTN4aUhiRjVp?=
 =?utf-8?B?TTM5SWtnVUJBUXNWRkJDRnJFMFJQNDBMdjhDcDBrOUpyaFZ6eXJYVUtydG1N?=
 =?utf-8?B?VmMwOHZ6NlN4WUhqSzN6VTN5eHIrdWk1ajdUZ3dYY3pZNlkyeXplZk5Bb2pV?=
 =?utf-8?B?RGZJb2hsN0NTemVkdG5PYmtNV1dRU3JWaFYrMndWN0Q3aW83S0ZmMEsrWVdy?=
 =?utf-8?B?OGxmU3VBTDJRYWZFNmN1TGtQWlhhOVF2NkJLOVE4Tjh1WkRTOXlNVWV3OXEr?=
 =?utf-8?B?QllwbjhBdUo4ejBPSkdjYm1QNXNTQWRlaW9lZkRXQUx1eTJpcVNFOWVWd05I?=
 =?utf-8?B?YndKb3E5NU9vWVpDZFJwdUFhUFc0MTg5TktIWG9FN20xRUU2N1JJZjlKYU5F?=
 =?utf-8?B?eVYvRGcyNmZCOXl1TzlISGFmaTNIR2lhaGgxUzJ0OGlvc200RkYwcGFxVkF2?=
 =?utf-8?B?MWoxaG0wYWRHdDBsdnE3Skd6RWZFRkN6N3hraXlTUTlNM0UwTjNEbTBMUDJT?=
 =?utf-8?B?L2JmdGVNUGxhSlB3S1MrNWdielhaUDArZnRGYXZaV3Z0VjlUK1ord3prSWw0?=
 =?utf-8?B?T3NtdVU4cFI5b3RNRzJBNEd6dEcwdWpuMGNFb3ZlWmJCQlEvc0Jqcmk4RDhI?=
 =?utf-8?B?OHB1ZjI5Vmd4TnAvK1pTaGkwSTZLNzhZNFV4NzJFcHFqeWlsdnZhQWhLQTBN?=
 =?utf-8?B?UkYwcTk5dWJmZEF1bUNwWlVHYURSbFQyNlhEUUZGTGpUZEh5c2kxSnB2SFEr?=
 =?utf-8?B?U254ODRmeVd4eCtjM25VS0FpUURRc0plK3c2MXYwTldwVlhCYUExdHhCSCtB?=
 =?utf-8?B?OE5vb2dBUnloMndUWU5XSllENGpSSE5ucWFDUTZ4NDBRQVhuY2F3QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af981b3-224e-4ea0-5aee-08de8351696b
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 11:44:42.2562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJHz0RtmXVw/yo9pP5rinmQuf4xsZREPHy3+5H4i2IDwtISGomkUB6313ptLJI/v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7196
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



On 16-Mar-26 4:15 PM, Zhao, Victor wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> How about do force completion after amdgpu_virt_post_reset to avoid any possible fence corruption during reset? For amdgpu_device_flush_hdp we already have amdgpu_in_reset check in amdgpu_kiq_hdp_flush so calling it should not cause trouble.
> 

Clearing before actual hardware reset should be sufficient ideally.

The current in_reset() check in kiq flush is when packet submission 
times out. in_reset() is a software condition. Flush could be required 
for unwind operations before actual hardware reset is initiated. That 
way, it cannot be blocked with a blanket in_reset() check.

There is also a higher level logic issue seen now. There is a sidethread 
on this, will add you there.

Thanks,
Lijo

> Thanks,
> Victor
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lazar, Lijo
> Sent: Thursday, March 12, 2026 1:45 PM
> To: Xie, Chenglei <Chenglei.Xie@amd.com>
> Cc: Chan, Hing Pong <Jeffrey.Chan@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Yang, Philip <Philip.Yang@amd.com>
> Subject: Re: [PATCH v4] drm/amdgpu: avoid KIQ HDP flush from VM CPU commit during reset
> 
> 
> 
> On 12-Mar-26 1:10 AM, Xie, Chenglei wrote:
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> Hi Lijo,
>>
>> Please help review the latest patch version. The faulty source is the amdgpu_vm_cpu_commit() requests too many HDP flush commands to KIQ due to VM page table updates during reset.
> 
> Do you have a dmesg log for this trace? If this is happening after hardware reset is initiated, it needs a closer look. We don't expect page table commits while hardware reset is ongoing. Copying Philip.
> 
>> The new change fix this by using non-KIQ HDP flush path when in reset, and added extra fence force completion on KIQ rings during SRIOV pre_reset.
> 
> If I remember correctly, the reason to introduce KIQ based HDP flush was that the direct ones don't work for multi-VF cases. I think you cannot replace one with the other just for flush happening in reset scenarios.
> 
> Thanks,
> Lijo
> 
>>
>> Thanks,
>> Chenglei
>>
>> -----Original Message-----
>> From: Xie, Chenglei <Chenglei.Xie@amd.com>
>> Sent: Wednesday, March 11, 2026 3:31 PM
>> To: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Cc: Chan, Hing Pong <Jeffrey.Chan@amd.com>; Luo, Zhigang
>> <Zhigang.Luo@amd.com>; amd-gfx@lists.freedesktop.org; Xie, Chenglei
>> <Chenglei.Xie@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
>> Subject: [PATCH v4] drm/amdgpu: avoid KIQ HDP flush from VM CPU commit
>> during reset
>>
>> During GPU reset (SR-IOV), amdgpu_vm_cpu_commit() is called repeatedly for VM page table updates. Each call uses amdgpu_device_flush_hdp(adev, NULL), which on SRIOV runtime takes the KIQ path and submits a fence to the KIQ ring. That floods the KIQ ring while the GPU is resetting. After reset, hardware has cleared the queue and those fences are lost, but fence writeback memory and sync_seq are out of sync, so amdgpu_fence_emit_polling() can hit -ETIMEDOUT and block further KIQ use.
>>
>> Fix:
>> - In amdgpu_vm_cpu_commit(), when the device is in reset,
>>     use the non-KIQ HDP flush path (amdgpu_hdp_flush) instead of
>>     amdgpu_device_flush_hdp so VM updates during reset do not submit to the
>>     KIQ ring.
>> - In amdgpu_virt_pre_reset(), force completion on all KIQ ring fences so any
>>     pending fences are signalled before reset. The other rings were
>> handled in amdgpu_device_pre_asic_reset()
>>
>> Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
>> Change-Id: I95404ce348ad546ddff1ea3b95a3f790299eb7aa
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 11 +++++++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c |  7 ++++++-
>>    2 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> index f01f385091083..5998e0a04d760 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>> @@ -1191,9 +1191,20 @@ enum amdgpu_sriov_vf_mode
>> amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *ad
>>
>>    void amdgpu_virt_pre_reset(struct amdgpu_device *adev)  {
>> +       int i;
>> +
>>           /* stop the data exchange thread */
>>           amdgpu_virt_fini_data_exchange(adev);
>>           amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_FLR);
>> +
>> +       /* Force completion on KIQ ring fences so pending fences are signalled. */
>> +       for (i = 0; i < AMDGPU_MAX_GC_INSTANCES; i++) {
>> +               struct amdgpu_ring *ring = &adev->gfx.kiq[i].ring;
>> +
>> +               if (!ring->fence_drv.initialized)
>> +                       continue;
>> +               amdgpu_fence_driver_force_completion(ring);
>> +       }
>>    }
>>
>>    void amdgpu_virt_post_reset(struct amdgpu_device *adev) diff --git
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>> index 22e2e5b473415..50ab9f9604834 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>> @@ -21,6 +21,7 @@
>>     */
>>
>>    #include "amdgpu_vm.h"
>> +#include "amdgpu.h"
>>    #include "amdgpu_object.h"
>>    #include "amdgpu_trace.h"
>>
>> @@ -112,7 +113,11 @@ static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
>>                   atomic64_inc(&p->vm->tlb_seq);
>>
>>           mb();
>> -       amdgpu_device_flush_hdp(p->adev, NULL);
>> +       /* Avoid KIQ during reset; use non-KIQ HDP flush */
>> +       if (amdgpu_in_reset(p->adev))
>> +               amdgpu_hdp_flush(p->adev, NULL);
>> +       else
>> +               amdgpu_device_flush_hdp(p->adev, NULL);
>>           return 0;
>>    }
>>
>> --
>> 2.34.1
>>
> 


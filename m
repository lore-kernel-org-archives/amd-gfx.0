Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABE5C47DDB
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 17:48:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08EBA10F7D7;
	Mon, 29 Jan 2024 17:48:46 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C96A10F7D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 17:48:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMX27a2yxjwwt8R8W4lcyH07mtb5tPw7b6D1djc3YHCicZk3HW36iMk2zQNXAbzDZOCJyNgP0HvLkH7ZhJHG0lu2DlksTPnfu/1KW6U7O2QGuO6Vci5qbSX/5S0eohEYO8xlQb9A62pxutpxBOgXLJwbaoZomlAFW5or2/fIoe7ydr3P4E3ptQtOBPtk5qNfETV4Akeq/Uqy2rrp61kmF+eP9END6L1Nr46Zg8NklaxIUbD458f8mgp7KZsEkQ3qZyqpPFmC2oZiSamv5zCWc2rKOFS1jNKTc7WAYlNoIfDqgcNOv0CHZYsX/qtgV3nuXzALDj6Zohw+fLeLDII05g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnrESzZ1Uvyh0DANJo8txqhEgHYf+VoACjqcgapjLew=;
 b=YJDVcbbnin8L6u55vu57WSbA6WuuiyfwITGPCqPqw3J2RoBOT2p4GCP+j5+iaUorFW5RrAq2dNt3B12PNovsOVsW2PQR4Tlyq0zrOEj/gOSlPBf50zovv0fLzWs521+OsyfnI8uEcTsKNuDT3EWrxwvdmJCtS2jVXGOudG4+mueN+l5thCCmH/uGNh6HU6NCj97KXiWeEKEXTt3G6GI6wDWE7CoBd0yuvJh7kM6AWS47UMzaFqvwHWhGr6WPwKQIes94DSc5300SG9MGnF6b1jZRUVMlL02siK52bEtwRezgZW0gR6cgklwFQMq6sQOStEuadFyLWgXNWcsx1iAyAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnrESzZ1Uvyh0DANJo8txqhEgHYf+VoACjqcgapjLew=;
 b=FPyHP6RpVGjxhCn3k4mWZ7MvWo8Jjnjb0hW9jNYoaSla5zFQw4oD1jDVsUe+9hgAcqnkQidJd1LIS8Jpp+z2Y6wsddkqIUkBxJP7jA6q/iCDlqA9nwERjPY7/YvlnusUEl3uNDvS0bLUHjcuznqkY8dzCbpRr0OWFYnixiwe3To=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB8276.namprd12.prod.outlook.com (2603:10b6:8:da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 17:48:40 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b%5]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 17:48:40 +0000
Message-ID: <19cae9ce-b9b6-4051-ad2f-ec9010c8745f@amd.com>
Date: Mon, 29 Jan 2024 12:48:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole
 (v2)
Content-Language: en-US
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240125222748.2089791-1-felix.kuehling@amd.com>
 <CH3PR12MB8902F83CE713AD38C49C346BFB7E2@CH3PR12MB8902.namprd12.prod.outlook.com>
 <d9143fd6-2e82-4e42-a297-962d3b806cf9@amd.com>
 <054ed71a-446e-7ba7-e1cc-bfb08497afe4@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <054ed71a-446e-7ba7-e1cc-bfb08497afe4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0101.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf80e39-e57b-4088-ab32-08dc20f28708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x77UBUFZGiQe/3UyVDPsFqDQr4fjz2X2TVLEeeMNiC3aVX/S/iFKzlvxoz4Shi6Z9kFrdzk+Lq1yKvjhqthH8rXtknXE3Blc2dv+IYDczMbj18/xjRJdxQPA6b2gexaU15DNEuq1y/AfAfrpd7OcPaAnTRFGO5aIAh8b6bz5QC9DilkuJpeRDiYF21mDgAnLWAZ+mLWbYYtISvGkzG/aSAI1YC+UX9BOkWB2Vp75lAfMjYvEnIAcyV8PCBNSUffya7OCbED0SIWjVlmnv4outnqK/PhXSlgk7397ZIKcaGR464pggIyj3mGi9GrtLMHjSrAyp4vnM/Fmo5PCu+BpBjL/YKABbEdDJRUiA7Qu93ezfozPfex9CBNXPZOVLHQK7gO0i+TwRgUKxHFgW3lc3rMAMu68jDlg9F/NnklmPq9yEHyKiZhHZzp5lpv2S11NbUbgXwZTN5FETR/Mq8FvSn61dTEZ3wzAj3h+xXddm+lIef9Eksn0WC5GGwHDV7QTbhR8wu2dZLVt7dodn2yXzDhwbXHnrTwOH0othEhVHZiG6WcJ+pQBwoJ8p8ZYgngc8shu3Jkru8z/OhnT+MLyqkDqvBSDNUAWQbxgyM7COCyAKTxQ09WeqzpeVcU63qg3UxYOQXE/x1suifkahU7Y3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(8676002)(8936002)(4326008)(38100700002)(110136005)(66476007)(66556008)(54906003)(66946007)(316002)(86362001)(31696002)(36756003)(41300700001)(2906002)(44832011)(5660300002)(6486002)(83380400001)(31686004)(6512007)(6506007)(53546011)(26005)(478600001)(36916002)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEk4Q0hXR2dCcis5ZE9RUUFBdFdrV01Fay9WWVEvbmwzUHZPSUIwTUYrZXE2?=
 =?utf-8?B?RERod081WFFpUGtFbEZNNzU5dCt0M3V2U1BZY2tKOWZsTndBbDdGdXlweWov?=
 =?utf-8?B?bGhtWFJRQ3NqMWxUQVdMenRwSXE0NDlJS3BHSm9WQ3lIK3RsYjhqWDNWazk3?=
 =?utf-8?B?Mkh3TURkYUV0WFcxYXRZdDZpU3d0L0hGaVUvV2oyc2hyRTFzR2dyZkZTS3Nj?=
 =?utf-8?B?Z1c4eEtaOTlvbEZxMllYaGMrSzhmOGdMMnllbUZHaUw3Qk8waGdRUzFUVVFF?=
 =?utf-8?B?NU5uQ1h3UjFjRTFtUWhCNFBrWXpZSmowNnpJRnJBLzJzYzJML0pNOFpFSjRE?=
 =?utf-8?B?MmZRNUdKQStreUJNWW93blJlZy93czRtUXhKaUJEWmpYazlRRDQraFk2ZDhz?=
 =?utf-8?B?Y0V0aWVYVzE2UEp1dUVXMTFYY2JRSlJzbmdwRU53S3UzMi9EbUNoVHY5ZTRu?=
 =?utf-8?B?VGIvUFl5VWk2eWlYUi9UTXpkTjFKTG9nUTB5di9xT1h6S1B1WWRuVFRwK2hQ?=
 =?utf-8?B?ZXUza2N6OVRWUmdvV0NqaUdjQkpiN1o1SnFjVVVLSW03WVAvcjZJdGRXeWJ5?=
 =?utf-8?B?KzVTNmx1d3JmbXV3TmZRNDh4MjhIS3UxMmVMRFd4eEF4d2Z2TzBqVm9xanIy?=
 =?utf-8?B?STNGQWFsWklOKzMvNFVJYTdqZkVyUFNYRmNZRDRYaXNJcThWN1g2WWxmek5t?=
 =?utf-8?B?eURxSlJuQXVEOXZ3WEVlb09icmdnSWR5clA0cWxTSkFUaTRkSU1rcERmeEZx?=
 =?utf-8?B?ZlVDSDhrU3RiZ2tzUXlzQ2oxcnkxY2Q2Zitrc0lEN2c0UnBmRVFkejFMc0o2?=
 =?utf-8?B?Zy80Z2NDVm4zUlh5cW11UjltUDRHaFRBdENIZVlGQXVXc2dZT3dKRm5iRzFh?=
 =?utf-8?B?WVgycFU0bWZsV1IwRjZES2ZrejJZNUhhR0d5MlB4Zy9QWUJnNStmdnVMalp4?=
 =?utf-8?B?b1EyQXFaSUcvOU5IUnVyVHdEbXJFUjE3cGphYmNOeFNBZjc5TjNjRUtnK1A0?=
 =?utf-8?B?UVhzRWY4eW5lUkZIdVBrUlZVVGZwV3JYbUhHS1gzdndrOFE1OEl6TEpCMkIw?=
 =?utf-8?B?c0NJMm5KM3MrVVVxOFllMmRXYkRrT294QlZLV0o1N3lZbDQrd3cwVFk2LytD?=
 =?utf-8?B?bUN1L1RGZEZRZ2lYd2IrbGJPWjBKUUtuZ0hsRHJFUzVMRVZEZldEa2xEbFZq?=
 =?utf-8?B?c0kxaGZ4dE8zOHFUU0N4MWpFTVAvalZHUnF3c2xFblBhci80eFpBYU9NalVx?=
 =?utf-8?B?bTFPSHlJdWg5S2xTOFpaZThBa29uSEM5d3JQN2FONUVCNkMzS3dETlh1c2xh?=
 =?utf-8?B?SWlrQStNTlU2cXFRb1JNZ2RKWU9XakxkUklienE1b3F6SnRLU3JKcmxhUGZn?=
 =?utf-8?B?RUxCNGowSGZuYTZ2S2Y4K2ZpaS9vQmJ1V3Y1ME82Tk16WXV2QXFGVHk0Vk9t?=
 =?utf-8?B?ZlFiNnhlL3JrUkV3dkdSRk9lNVQyUUN4YWhFSlFUaDNGQ2l5eTJxNlBnclg1?=
 =?utf-8?B?QnlNc0c0T1dtYm0rKzN1U0tUMUxZYjN0L0VpVlJTS0czbndUL1JIVTkyT3lF?=
 =?utf-8?B?Y21qSlp3YTgvNUNnYklQSVk2MllHa2R2S3NJS3ROSXFBM2xFOGhOMDZOUHkw?=
 =?utf-8?B?cGtXU3JMRGZsQitmQmVEZ3VrZWoyTVBvKy9xa0thWVYzR1dmNWVqeGM5Mzc3?=
 =?utf-8?B?QXJOWTkwVFBKU0hnc2RIWTAwNXA3RUkraGpKZVg5MkkvbTFFRFlKdEgyWi9X?=
 =?utf-8?B?MUxqaktpRE1LTWRUb08rQkplSG45UWF2YW9oTWx2M1N1dGNjRTZqMXNOT2tN?=
 =?utf-8?B?c1VrWWNpNzk1Vk9WYmdyd2x5dUJuc1M5UDRuUEsySEFIRXdtZnc1bHA2TkpQ?=
 =?utf-8?B?UTBiTVFXMXYzMlR3WmhHUjAweTZRbmdVZTVKdVg4Q2tKUC9GYXJwUlAwcTBh?=
 =?utf-8?B?cjlHTCttVTdRWk01YWdzdTJjd1p5Z1RZbjRNOUhoa2IrNXRVUElPQUtyR0J1?=
 =?utf-8?B?amh3dXQ4S3pKZTQxNmxhdzh5RGJ5OExDUDFkQXVTanA3NkgwUjE5MW9pMXg4?=
 =?utf-8?B?cjJvZHZtVGV6SVNEN3RxK0xyV1Z3ZkltNWRyMjVNaGhoQndSVnZ6cXZXV1A4?=
 =?utf-8?Q?BEyVMNMWKlLOU6NdY9pTAN7P4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf80e39-e57b-4088-ab32-08dc20f28708
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 17:48:40.0608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L8K/IcXw1DhhSfzA7jMCK9RbsDh7vXeZ12hMRcAZFluK2o5cXSYoEgsyp5kWsrhyNDZYAfO9ZIsty8DOR0/CwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8276
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
Cc: "Cornwall, Jay" <Jay.Cornwall@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2024-01-29 11:50, Arunpravin Paneer Selvam wrote:
>>>> @@ -339,18 +346,19 @@ static void kfd_init_apertures_v9(struct
>>>> kfd_process_device *pdd, uint8_t id)
>>>>        pdd->lds_base = MAKE_LDS_APP_BASE_V9();
>>>>        pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
>>>>
>>>> -        /* Raven needs SVM to support graphic handle, etc. Leave 
>>>> the small
>>>> -         * reserved space before SVM on Raven as well, even though 
>>>> we don't
>>>> -         * have to.
>>>> -         * Set gpuvm_base and gpuvm_limit to CANONICAL addresses 
>>>> so that they
>>>> -         * are used in Thunk to reserve SVM.
>>>> -         */
>>>> -        pdd->gpuvm_base = SVM_USER_BASE;
>>>> +      pdd->gpuvm_base = AMDGPU_VA_RESERVED_BOTTOM;
>>> Hi Felix,
>>>
>>> pdd->gpuvm_base changes from 16KB to 2MB after this patch.
>>>
>>> The default mmap_min_addr(/proc/sys/vm/mmap_min_addr) is 64KB.
>>>
>>> That means user could get a CPU VA < 2MB while the corresponding GPU 
>>> VA has been reserved. Will this break SVM?
>>
>> It could break SVM if a process tries to map or access something 
>> below 2MB. I'm not sure what AMDGPU_VA_RESERVED_BOTTOM is used for in 
>> the GPU page tables. But if it's causing problems for real 
>> applications with SVM, we should look into lowering that reservation.
>>
> We have decided to keep AMDGPU_VA_RESERVED_BOTTOM free for catching 
> NULL pointer dereferences.

Can this be made smaller? I think the 64KB minimum address used on the 
CPU side serves the same purpose. Could we match that on the GPU side?

Regards,
   Felix


>
> Regards,
> Arun. 

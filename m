Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AD0C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 15:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66D42112519;
	Thu,  2 May 2024 15:35:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TPnTL0Z0";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55AA111250F
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 15:35:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRS1QurjbeOjnTPsl5K4wo0IIrGKiqdszmZRwdTysDyBx7mL9m11r0QQwXjKbFGbEVtoyzpPU17W+l6qMh9FmHqacgt65yiKDwvfg/6JzyL16vuyZLgPoZ+06Fo9kbZFHE/UWna4NI3BCTJZm59uSL0ZCqqxj1Ed2XIhuONGvXFWXhZz0+yKJmblMpUEJz5wz9EDKca+5DTKjE9r4rnfNrCBdX/aNrBgdRIhxLbZ0fM7QcxMfdHebOZA2x8TWm93Gd2kMU0hZ2qRFrzBe5pBSqY9+OQzIEls6sC2R+4nXHBpI55qblMtJvWDyRjWpvm8N7PKOK/YSKCUfp/+TU8laQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1wB1r4mwq8UyPCc/7tDyXzxA/1rsg0zQgkTatPLuS0=;
 b=J7ARtu1G60HuBRuZa/0nHymL4fX00QcUw2ZxeajurPKcRGkCIeYUyENVpBkbwPcNlVO11xc8a0G1EdJiUzIb9fYWch2KFl5SCVufvkI7GWUzfYBHe7y3nCwyiigILQsheVJo2FNNz2kf6N+IfjI3Flz9fU8JGscyx023Je3qYqbnL+0QYfaN57331mTgXQCuixxfw4dSD1Egg3czQglsHH2p/g5oMcpCFps74RipKlO62WMyhaSz5SbUH7s94slQaBZ/fy6tkQCRoyapSQFkOhxj4tb+eK0a4j3Qb95If7kmRBTOitTfq0gGZjmutA06H9gjIxzA1G5BASzw4+WL6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1wB1r4mwq8UyPCc/7tDyXzxA/1rsg0zQgkTatPLuS0=;
 b=TPnTL0Z0omgfuEFXGW9jDlw1ALhQrNsArcpPTK7kyK7bF3gc0aLgdB82htzUdo/I3d7YppBK2hdO+0enAjBbkVAyuOEdOLsrpNS86b+Tj49aFWsk8+t76xmYEtFtfLYTqtnvIIQOw3Z4BFcXw37XyL2LZjyWjP4H9AWmQWDVZFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MW4PR12MB7430.namprd12.prod.outlook.com (2603:10b6:303:224::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Thu, 2 May
 2024 15:35:43 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::966b:7f50:4f07:3c8b%5]) with mapi id 15.20.7519.031; Thu, 2 May 2024
 15:35:43 +0000
Message-ID: <a067eee6-f47b-b859-daba-da50ecfabb7e@amd.com>
Date: Thu, 2 May 2024 17:35:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 05/14] drm/amdgpu: create MES-V11 usermode queue for GFX
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: Arvind Yadav <arvind.yadav@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-6-shashank.sharma@amd.com>
 <9b19831b-d534-49b1-9786-38c3cdb5b02f@gmail.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <9b19831b-d534-49b1-9786-38c3cdb5b02f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0102CA0108.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::49) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MW4PR12MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9480d2-76c1-4237-2651-08dc6abd8724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3dUQ280alN2RlA4dU1yU25mOFdmbkJnbUpqRmkzekYyMS9tUDQySUNJejhl?=
 =?utf-8?B?R3k3aHNDTm56VmxhVFJIR0lHcU5IbThzdFNvanBNakVUZWlNMndpZmEwWTNN?=
 =?utf-8?B?cDVpeGNVZDZtcC9QMEFnUWk0WUZncWpnVE5wSkt6alNudkFnNGhsRnFYblFK?=
 =?utf-8?B?UG5YTWpIMjFoQmlFNGhKZE05Y0pWVzVtcXQ2a2VTUGJEUzdlcU02aHM4Z1RF?=
 =?utf-8?B?NFh4aHVmTk5rQ3lJbSt0RmZhN3BIVUg2Wk84dnNFWTVXS0pUb1QxS0p2OEVD?=
 =?utf-8?B?bDdFUisyNU5QTEJFRHRjZTUvUFl4MFVwMzFtYlpiSC9aYkFuMDZZbi9DUlFT?=
 =?utf-8?B?K0p5VWFYWU12aWRZQzBKYnZxdzhhcXZTamYrdCtjOVNINTZsc1NRSVpmbmRG?=
 =?utf-8?B?MDRYVUdWbmtNQlpPV2o1VXcxUTdiYXMvNitLcHBYazN6aENQdVI4VEM2cmpn?=
 =?utf-8?B?RnJNdys2R2xHU2VXbCthNEVpQ3NxZUlSU01Fc2ZNRnZsUzNRSWNzcm5KTmJP?=
 =?utf-8?B?VGx5YTRDbVdGcXdUY3BSeG5rRUpkQUJwR2hGY1hkd25HdWxjSmowbjFKeWJp?=
 =?utf-8?B?WTY1c1lFN1pjZmNxUzdGeVh1NGZScjRJUEtNdWh2U0V3TVVDNmg3K0NuY2c4?=
 =?utf-8?B?WTNzTDF3Y0x5UHhkbHlBcVFRNFdSSHY5V25kQkl6RVo3eTdEOUQ1RElPLzJH?=
 =?utf-8?B?WWJuenZRaWRTU1ZRT3FJMDdZelVwd21lMysyMXZDS1RzeW1FcGlXUysyZzV3?=
 =?utf-8?B?RUVEdHBRd2ViMWlJbVIxNmYxcTJjWnFMYnhPVkJRQ0hpSHR0RnFGbWdNTit4?=
 =?utf-8?B?T2xRK3VVbFBMd3N1ZUJLOHdLZzR4WTFReHJkV3UxNTh3VER4N0tMRlppR1Zr?=
 =?utf-8?B?Sk11RWJ5V3NtZVNWZ1dpK2FzNlBNdEhBM1RGVzg4SzdNbkkvYnd1dFJPRDhQ?=
 =?utf-8?B?NS9LMzVFUk93cFVaRldBeDdpR1V6SzdjM1JwYmxpeVcwN1JXalRoMmNyU1hu?=
 =?utf-8?B?NlNtWDlpWjNZOGRMbUp6Qjhoa3BQT2lxWFpObWkxMjFkVjNhdnNudjFiZis4?=
 =?utf-8?B?eGpUZGt3enBSZVgzdWpWcXg5NmhpRWd0ZklDUGNpSGwyQUpQTWJXV1lTbW5X?=
 =?utf-8?B?VEFsM3hDU2FSWXN6cU9GYjNkZnNvd3RMVXV5NEMvZFpWYUVLN29BUmFyekgw?=
 =?utf-8?B?b0h3ZUJBaGQ2cEU4R3hMeVc4SDFDTkVkLzNFTC9zRXJ4NjhUcll6TmZTeUZs?=
 =?utf-8?B?U09QRC9FQmNFVkdWT09hMmF2QzJYK2ZWSGI4T21Pd3NzM2xsV2Q3ZjAyY3Yr?=
 =?utf-8?B?Z3AxWGhZMit6cm56UEJQVElQL1lobkNHNW5ZR3JPWG5TNG1pcnB6OHgzV2FE?=
 =?utf-8?B?REJTZVRBcklpRUZlZ3hKQStCRnllcUlnNXB2WkdFSnZRWVdsbzArMFNjb2lQ?=
 =?utf-8?B?YllIcEVoZHhHQ0d5RHJjMy8zTDhnRDUxOG1COVpzc2FJRTM2QUdFYnBrQjhQ?=
 =?utf-8?B?akVuQmw0SWlQV20vdVIyRlJ0SE5nR0xDMzAxcTJMcEJ0NHR3R0JhZ1Nwd0tC?=
 =?utf-8?B?NTRGUkpHeXYwUXltRjlmNFRnR253M0RWTVcvT21Fd0l2OXhVZi8vK1ZYenh1?=
 =?utf-8?B?R0RFTDlYMzdPU0IyQk1kd3E0SWFENTNxMTNzYjlja1p5MnNOYnNaRzVNdnFW?=
 =?utf-8?B?OUcyWW93U2tPeWErOFBvTG1mVHVlZ200UGJCUW8xVGJPcGF3eEdRMjVRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y25NSnBYU3pDdkNwaDFpaXdwaGxySzZ5NFFLejc0QTNoZmNqejZoYjQ3d2x4?=
 =?utf-8?B?QXRMc0RCUU9WbStOUXFQa2ZLY1c5alI2VWVtTjZlWm1RZkdabXc4aUhqVS9o?=
 =?utf-8?B?bFhTVnBQTWdldnpnT1NqSGFVbU9wM2gvYkh1UndoV3hyYUNZd21yb0s0QkVC?=
 =?utf-8?B?eDNnWFZuMG0xdnZGVi9jbytKb3hWbWFuaWR2ak55UHpvVDYwdHJacjNhMEZV?=
 =?utf-8?B?cDM0VUFORVFtM3U2RG5BZC9sSldFY2srSWt5ZnRXYjZwNThLZ3F1ZDNiOElm?=
 =?utf-8?B?ek54Y0tkdHZ3dFdseWtBdkZUbkt1cTBla0R2c3BiSWZNd2phTmk3REs1akNq?=
 =?utf-8?B?a1ZQRGpmZkV2NXFvcU5ScUpxOU5XV0ZTZUdCbmJZbUthSFM2c096a2JtYUZU?=
 =?utf-8?B?TDJnbGF4NVF2T292NHEwYVBOeEc1K3pVVUdpWjBnaUpOYWp0elBmNlNmaUJi?=
 =?utf-8?B?RWJGMzFTanBTcDBZd1V5UTJHU2Y5L0RJRGZGTkVVNGZ0SUxJcmRJS05mbVEx?=
 =?utf-8?B?MjV5S2M5OVR5c2pRSWd6WHN1MVJLMnh5NnI4S2wzMjJLZXRoWXF6VzdiczNh?=
 =?utf-8?B?c1F2VUp1dkdNOWpLa0VCZktKRGJCSG9jS2N0b0VId0FYTUNOa3A5K1NsaUpR?=
 =?utf-8?B?azZiZzM0c3ArQ0ZFSDZHM3BJb1cyUFhlOFVERkJSRFVwYmdEZEpkZ1RlRlR1?=
 =?utf-8?B?ZkdPWDhrM2txeDlKekw3ZVA3YU9GNjgzUm5pMEY2aEVhT3hXTlgzK2FJSFdT?=
 =?utf-8?B?N1ZRZzZWaXlyUWtBSVExZUhUZjJxbTFyWllyQmdpZ1NIRUJ1M0laUnZ5dVNE?=
 =?utf-8?B?WnFiL1djY3RXR1RpZk9kdlU0NTZWYk9KQmVtUTJXVVMweDZDQjBQUEVPcGlE?=
 =?utf-8?B?dTk4RVhGN2NHTHUzVk1Zd2o4SEdUdXY5MW5mNkYza1NYOW9SM3dPcUxYc3lt?=
 =?utf-8?B?Z3JFYTZHMERUWTc0OEtRTy84LzQwTlRpWXJpdVFoTU9vSkI0UWZYUG45M04x?=
 =?utf-8?B?cHE3Qzk4RmVwWlZrZFNvUGdoQmFsRTY2UmNhZXNEN1dNTUF0aFdYVkxRWWg1?=
 =?utf-8?B?aGp3cDdEWHhVZzZaNHo2eFU0Q1VzcE8xRkVhUHZNTGVQZXNVeWlyMGZMb3Ix?=
 =?utf-8?B?akxSVDlRaWdnVmRrSVVidzlFMGltajlrUVRhak9GenpOWTZFYVVXNEk4aVUz?=
 =?utf-8?B?dWxCVklSSlVnWXJhbDkzSmFnaVJocE1TbDdMbFM0QVQyYU9FTGtldERzV21U?=
 =?utf-8?B?djdZUWRucEhsWVdyeWttcUZTSmk4YVdIcEl5bnk0bFNHN2E5ak9qRXF4bWtu?=
 =?utf-8?B?bFJBZUFpV0ZBZXVvOW04NWdQVE10ZmFLMWxTekoxT082d3JCREVTMVQwZUFX?=
 =?utf-8?B?VUVLV3MwM3ZucmhsalUxazl3VXRaNFRqNk1lMldsVTNwYXlpa1NmbVhZMzBL?=
 =?utf-8?B?ai9IQ01vUC9rbW5TcUFDeXhBTlpIcFY3RXFKajRZNFN0a3R1QVlscTgyTkFp?=
 =?utf-8?B?RytXajlJTG9MRDNXR0RyNWVuSVZnWnJBcDVRVmpDQmtyK2lBenMrcGl0K092?=
 =?utf-8?B?MzdQUExWMVE0cnRCa29OS0lmYmVKZllHV2ExSXFuRHlQSjAwTlVmaFowZnln?=
 =?utf-8?B?czdWWFFvYXdzY1NSTE03Tjlwbk5LR0dNZkF2MlBxMGdZWE84OFZPSzZxZjJT?=
 =?utf-8?B?dElIU2ZKTldNSFIvUlBmbWFlalFkTkdrR01rZ1hyMHVyWGx5TGVjeW55YnRt?=
 =?utf-8?B?OHJWUnBNbEhpRmZqaXRId0g3ZUFJK3R6RFNVSGZ0SXVoL3M4Wko3NUZhSXl2?=
 =?utf-8?B?ZVByaXFEVyswOGFGLy9QTi9iRHE5MkY5NW9GOFFUMWR4eWxnVXQwVkl2M2Y0?=
 =?utf-8?B?ajZBak1YTjFReUx0WVJVVTV2QWtHNDBTSVdTYTh4VTkxbkg2S0wyam5mbVA1?=
 =?utf-8?B?QnB2aFo4dnRYbVlRV2VwYTZxQjNsWmQvYTM2UVdWZGJHSUVZcHBVMXYwSXNw?=
 =?utf-8?B?U3ZncHQ3YmwrR1VoNzlCbVg0d25SWWM0VXFwaXowNGkyc1pBZFNGZDVyVkVn?=
 =?utf-8?B?NlpEcFN4SG9BMk54V1VFdzVYdWUrcmlWTE1ncjVjR1lSbVJjYmRLY1BnK3E3?=
 =?utf-8?Q?0AAZz1mVCfYfOguHpLz4jAUBb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9480d2-76c1-4237-2651-08dc6abd8724
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 15:35:43.1484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kh5/mqrGtecmyUKEqc4Njk1e5xaHzMNwubIrEFqXgFR6mvjX7UTMHJeW3fySSnAKARpeD+CksXXHvjjsDRyKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7430
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


On 02/05/2024 17:14, Christian König wrote:
>
>
> Am 26.04.24 um 15:48 schrieb Shashank Sharma:
>> A Memory queue descriptor (MQD) of a userqueue defines it in
>> the hw's context. As MQD format can vary between different
>> graphics IPs, we need gfx GEN specific handlers to create MQDs.
>>
>> This patch:
>> - Adds a new file which will be used for MES based userqueue
>>    functions targeting GFX and SDMA IP.
>> - Introduces MQD handler functions for the usermode queues.
>> - Adds new functions to create and destroy userqueue MQD for
>>    MES-V11 for GFX IP.
>>
>> V1: Worked on review comments from Alex:
>>      - Make MQD functions GEN and IP specific
>>
>> V2: Worked on review comments from Alex:
>>      - Reuse the existing adev->mqd[ip] for MQD creation
>>      - Formatting and arrangement of code
>>
>> V3:
>>      - Integration with doorbell manager
>>
>> V4: Review comments addressed:
>>      - Do not create a new file for userq, reuse gfx_v11_0.c (Alex)
>>      - Align name of structure members (Luben)
>>      - Don't break up the Cc tag list and the Sob tag list in commit
>>        message (Luben)
>> V5:
>>     - No need to reserve the bo for MQD (Christian).
>>     - Some more changes to support IP specific MQD creation.
>>
>> V6:
>>     - Add a comment reminding us to replace the 
>> amdgpu_bo_create_kernel()
>>       calls while creating MQD object to amdgpu_bo_create() once 
>> eviction
>>       fences are ready (Christian).
>>
>> V7:
>>     - Re-arrange userqueue functions in adev instead of uq_mgr (Alex)
>>     - Use memdup_user instead of copy_from_user (Christian)
>>
>> V9:
>>     - Moved userqueue code from gfx_v11_0.c to new file mes_v11_0.c so
>>       that it can be reused for SDMA userqueues as well (Shashank, Alex)
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |   4 +
>>   .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 110 ++++++++++++++++++
>>   3 files changed, 116 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>> index 05a2d1714070..a640bfa468ad 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>> @@ -184,7 +184,8 @@ amdgpu-y += \
>>   amdgpu-y += \
>>       amdgpu_mes.o \
>>       mes_v10_1.o \
>> -    mes_v11_0.o
>> +    mes_v11_0.o \
>> +    mes_v11_0_userqueue.o
>
> Do we really need a new C file for this or could we put the two 
> functions into mes_v11_0.c as well?
>
> Apart from that it looks correct to me, but I'm really not that deep 
> inside the code at the moment.
>
Actually, this patch adds these two functions, and then the upcoming 
patches add other multiple functions to create/destroy FW objects, 
map/unmap_queue, handle doorbell and map wptr BO on top of these. So 
when we look at it in the end, its probably fine :).

- Shashank

> Regards,
> Christian.
>
>>     # add UVD block
>>   amdgpu-y += \
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> index f7325b02a191..525bd0f4d3f7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>> @@ -1331,6 +1331,8 @@ static int 
>> gfx_v11_0_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
>>       return 0;
>>   }
>>   +extern const struct amdgpu_userq_funcs userq_mes_v11_0_funcs;
>> +
>>   static int gfx_v11_0_sw_init(void *handle)
>>   {
>>       int i, j, k, r, ring_id = 0;
>> @@ -1347,6 +1349,7 @@ static int gfx_v11_0_sw_init(void *handle)
>>           adev->gfx.mec.num_mec = 2;
>>           adev->gfx.mec.num_pipe_per_mec = 4;
>>           adev->gfx.mec.num_queue_per_pipe = 4;
>> +        adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
>>           break;
>>       case IP_VERSION(11, 0, 1):
>>       case IP_VERSION(11, 0, 4):
>> @@ -1358,6 +1361,7 @@ static int gfx_v11_0_sw_init(void *handle)
>>           adev->gfx.mec.num_mec = 1;
>>           adev->gfx.mec.num_pipe_per_mec = 4;
>>           adev->gfx.mec.num_queue_per_pipe = 4;
>> +        adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
>>           break;
>>       default:
>>           adev->gfx.me.num_me = 1;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c 
>> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>> new file mode 100644
>> index 000000000000..9e7dee77d344
>> --- /dev/null
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>> @@ -0,0 +1,110 @@
>> +// SPDX-License-Identifier: MIT
>> +/*
>> + * Copyright 2024 Advanced Micro Devices, Inc.
>> + *
>> + * Permission is hereby granted, free of charge, to any person 
>> obtaining a
>> + * copy of this software and associated documentation files (the 
>> "Software"),
>> + * to deal in the Software without restriction, including without 
>> limitation
>> + * the rights to use, copy, modify, merge, publish, distribute, 
>> sublicense,
>> + * and/or sell copies of the Software, and to permit persons to whom 
>> the
>> + * Software is furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be 
>> included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
>> EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>> MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO 
>> EVENT SHALL
>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, 
>> DAMAGES OR
>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>> OTHERWISE,
>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE 
>> USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +#include "amdgpu.h"
>> +#include "amdgpu_gfx.h"
>> +#include "v11_structs.h"
>> +#include "mes_v11_0.h"
>> +#include "amdgpu_userqueue.h"
>> +
>> +static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>> +                      struct drm_amdgpu_userq_in *args_in,
>> +                      struct amdgpu_usermode_queue *queue)
>> +{
>> +    struct amdgpu_device *adev = uq_mgr->adev;
>> +    struct amdgpu_mqd *mqd_hw_default = &adev->mqds[queue->queue_type];
>> +    struct drm_amdgpu_userq_mqd *mqd_user;
>> +    struct amdgpu_mqd_prop *userq_props;
>> +    int r;
>> +
>> +    /* Incoming MQD parameters from userspace to be saved here */
>> +    memset(&mqd_user, 0, sizeof(mqd_user));
>> +
>> +    /* Structure to initialize MQD for userqueue using generic MQD 
>> init function */
>> +    userq_props = kzalloc(sizeof(struct amdgpu_mqd_prop), GFP_KERNEL);
>> +    if (!userq_props) {
>> +        DRM_ERROR("Failed to allocate memory for userq_props\n");
>> +        return -ENOMEM;
>> +    }
>> +
>> +    if (args_in->mqd_size != sizeof(struct drm_amdgpu_userq_mqd)) {
>> +        DRM_ERROR("MQD size mismatch\n");
>> +        r = -EINVAL;
>> +        goto free_props;
>> +    }
>> +
>> +    mqd_user = memdup_user(u64_to_user_ptr(args_in->mqd), 
>> args_in->mqd_size);
>> +    if (IS_ERR(mqd_user)) {
>> +        DRM_ERROR("Failed to read user MQD\n");
>> +        r = -EFAULT;
>> +        goto free_props;
>> +    }
>> +
>> +    r = amdgpu_userqueue_create_object(uq_mgr, &queue->mqd, 
>> mqd_hw_default->mqd_size);
>> +    if (r) {
>> +        DRM_ERROR("Failed to create MQD object for userqueue\n");
>> +        goto free_mqd_user;
>> +    }
>> +
>> +    /* Initialize the MQD BO with user given values */
>> +    userq_props->wptr_gpu_addr = mqd_user->wptr_va;
>> +    userq_props->rptr_gpu_addr = mqd_user->rptr_va;
>> +    userq_props->queue_size = mqd_user->queue_size;
>> +    userq_props->hqd_base_gpu_addr = mqd_user->queue_va;
>> +    userq_props->mqd_gpu_addr = queue->mqd.gpu_addr;
>> +    userq_props->use_doorbell = true;
>> +
>> +    queue->userq_prop = userq_props;
>> +
>> +    r = mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, 
>> userq_props);
>> +    if (r) {
>> +        DRM_ERROR("Failed to initialize MQD for userqueue\n");
>> +        goto free_mqd;
>> +    }
>> +
>> +    return 0;
>> +
>> +free_mqd:
>> +    amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
>> +
>> +free_mqd_user:
>> +    kfree(mqd_user);
>> +
>> +free_props:
>> +    kfree(userq_props);
>> +
>> +    return r;
>> +}
>> +
>> +static void
>> +mes_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
>> +                struct amdgpu_usermode_queue *queue)
>> +{
>> +    kfree(queue->userq_prop);
>> +    amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
>> +}
>> +
>> +const struct amdgpu_userq_funcs userq_mes_v11_0_funcs = {
>> +    .mqd_create = mes_v11_0_userq_mqd_create,
>> +    .mqd_destroy = mes_v11_0_userq_mqd_destroy,
>> +};
>

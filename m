Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D755ED41C00
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 05:03:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7650110E67D;
	Wed, 13 Nov 2024 05:03:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tPXtGkLx";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2AEE10E67D
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 05:03:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovnzBu8ircw/c4POsRT6RrKAK2t849q/RxzjhmslpXVGXf7iJJsF5MASUaTjk3CymAPseM0nXdiu9nhb1ldgFA9O0qaE+pH34USDbd6XuKc+5HYMPJ8Fx4ujm87rtm8JqjKTMKCERDSKQcQKivV/ZsPOIeRZ2TGVkxbsgGmBQBo/36lsA16xdPtqcutPv3OOG/IQb0XWb5h2l+Ow5HqNyOlGrRgnRu1nONphKALTcHMdO2o/beo3p1qK2gBXMKHpK2DNp/dzBdPynS08wI6NvwVLodS5tEhn3pcr+ZNcFXgvj2tp9/JOGtRa/YEanxqzFkLBvVpZQ4Xjm4P7DlSQmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9GyW2FfwxL3+751VhZLtZ3SPTcxaF8wLlFyTkWrSb4=;
 b=kSuobt32B5CfV1OBeVSXFQuImHEWgOc6Hl0kcx3veHcOzo97njrsVPvcI/LkcDQvUB+45d3rOxYLOjgItO2f6pGR9c1UlDlSE6axJyuMSub8J2o7BqZgzwmhXWAIcbVEJEBz/EsMgtyCGPFtLBL3+n2wylGvQ4f8hM3Qlxpj9hk6f1uQdqFPkoRxIp3b50NVKtwdvi8bD6lwwc5ZaKE01K5z0UcAKhGAwpCank/kQzZBnhkGHFpq58h0T6jLFfhxNTjFTGaPkh2L7anstmejDpZcM38hqTfMo91qxXHdop7w6dza3lY5phDmRdpfmsm2UumyXXMNuuKVEicGmp8L6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9GyW2FfwxL3+751VhZLtZ3SPTcxaF8wLlFyTkWrSb4=;
 b=tPXtGkLxTrte4ck5NUeOoiNHcBA1+0GNp1dwkOabzR+i3XywuFLE9CF+ifpROelkxxqf4ogNg5cfC/N7NdKxqknxnNHfu8DlXJ/ZY2XMhCN12LFEomLHJTgbyKYuAKbgLWYqcvCY9ClJ26fRMndp9Y48fo73ZdabP5M+QaNja0s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 05:03:17 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 05:03:16 +0000
Message-ID: <e8698f59-6fe2-41b3-b023-5e9af848a0c1@amd.com>
Date: Wed, 13 Nov 2024 10:33:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: fix vcn sw init failed
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>
References: <20241112143050.1931822-1-jesse.zhang@amd.com>
 <20241112143050.1931822-2-jesse.zhang@amd.com>
 <910caa3a-802a-41d6-ae07-c39292081d4d@amd.com>
 <DM4PR12MB51524E90E5A98A03BF7FDD8CE35A2@DM4PR12MB5152.namprd12.prod.outlook.com>
 <63fcdfc5-af2a-4065-ab5a-81ca5dca6db9@amd.com>
 <CADnq5_Pix7r90tHzXF85vNMrqk+KZSOGSgHRuCvHH1LSG6JVgQ@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_Pix7r90tHzXF85vNMrqk+KZSOGSgHRuCvHH1LSG6JVgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0129.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::14) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d090622-70e6-41d4-5510-08dd03a07ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1ZtZm5ScHVWaFQ3cWVGcHM2VjZJcmhPN1lCVFRGek56VEpSTnRmbXFoMDBz?=
 =?utf-8?B?dkYxcG9VUlJjZFJVcjM5aVFDelMveXRVT0JNbmtrUUpKWDcwQnJHanhSNUY2?=
 =?utf-8?B?a0Nuc0kzNVVtbmpFR3pQa1pTbFZHa3BvbXQzRVUxTU9taFVrWWhSTEc5dk91?=
 =?utf-8?B?ZE5pc2hMOFJGQ3hBckg3b0FpdGtPUnh0S3c4ZlYrbnJKOHc2OWNkUWsxWG90?=
 =?utf-8?B?OGU4bXQ3QjZtNUdod1RuelNCRGdVejBiV1lsWEVMZmxSUm05QmVuVWROT3Jq?=
 =?utf-8?B?Vkg0SjJCZi8yUUZZTjVxeG1BWFlFdHMzd2JXK3NmbkNJRGtjanNncW1sOXVr?=
 =?utf-8?B?cHY5d2F3dUx5eUZYZzRraHNOZjdZbEdidUNOK2t0Y05OTTRLS096eWlqT1hj?=
 =?utf-8?B?RW40ZkZPcjFremhyd2hmTFhtNXlQREoxZ3dLemFQQ0g5RVFOb0p6VkQybmhN?=
 =?utf-8?B?WDh2eUtLQm9uajRPcGZQWklocStKdDZ6NVNrYXVQZHgxeUcxTDRTRUFqVGlE?=
 =?utf-8?B?REwxUlcwMStLRFZETGR1SE94SkZyV3BKeXJneHo4d3dhQ2FYZHdoa1Fnanlj?=
 =?utf-8?B?L1FVWEZqMGYyY3hkRzBPdVRTd2dIaGVYUUFCZG5RWGtkeEt1M1JzRVI0WUV6?=
 =?utf-8?B?RVNsUkZuMHI2VmtKZFBHMVRJNG1EelRrUXVwam9OWFRhQUgvVWhSeXdDSUpU?=
 =?utf-8?B?UG03cGF4MFplczRQUy9GV29XVTNDb21DTlpnRmVQbmN0NitrbU91NVBkdm9k?=
 =?utf-8?B?UWdEQStMdmkrR29jd2x1QStZalI4MzRFa0pOUEUvUkFnM3FiOTMxRkNDZjRj?=
 =?utf-8?B?NENLb2UxdE9hc1ZLblBpcHJOWk5PaHJURWVYU1ZNdmxxellqRm5pR0VWQnQx?=
 =?utf-8?B?QU1WUGw0NjBueTA3Y3Z1ejdxeW04a0gzSTFSYVg3dEhwWFoyd3RCV3hyU1ZV?=
 =?utf-8?B?RGo0RXRaYk5NbXpYWlNVWVBGZ1pCL2gwRzNhYUNVTzRlekU3ajRKQjlXNWdX?=
 =?utf-8?B?ZUVHRmxMUzZwdDZBcTNIOVVOMVU2aTJocE12NkpPZVVHYU8vN0FlYVhBcW5U?=
 =?utf-8?B?ZCtwd1JnM203bW40ZnNvVWd2cHZmNlpkMXVDcTBjMWJFaE1BWEpYZWtreUZ6?=
 =?utf-8?B?Sjh3VU9hdkI3bnNJVHFwcTE5aHF1UHd0REU2N0dST2UxU2ovL3FPMnFqUFMx?=
 =?utf-8?B?S2k4ejNZTm9vdysyYnFGSG1YVFEwZHd4UTgzTmpDVmM2eGtGVlBkV0p3bERj?=
 =?utf-8?B?clkvaTJMUFduT2puc0wrTlNxaThyRzFKZXF2dXlxSVZSOGFJcGc2ekhqQkty?=
 =?utf-8?B?emxTUDBkV3A5REg1Y1UrVmx4ZE5GeXFTTFY4Z2xyODQ5eDZydkRMQ29Cd0lq?=
 =?utf-8?B?QnFKdGcwcXVJMUZnbTZRMkFybWVYajc5d3kxSXd1ZXlSSStKemQvcDhwN3pk?=
 =?utf-8?B?N09PM3kyZkVidmN6V3dENTNYUFVuS09XQUQrTHRMU2dBczFwdnYwaFZTRUMw?=
 =?utf-8?B?Slh2Rmx3OER1VlUyZ1ZNNVlGU21wNEhjVFVKRjErYm9TelZ2cXlSUFN1eEVh?=
 =?utf-8?B?RmxTazV0VThHZ29pa0xvcU5OZTNoY3ZQRVZvNlhVeU51czZBMmY5eWRoY0Z2?=
 =?utf-8?B?VklnZzlqOXZYejU2NllaV2hSWjN3amdPYzNUZGJQQkc2VlI0dTZ2Sm1iSk5S?=
 =?utf-8?B?WEFiSUhOeWpwRXNhYmlVUUZhMlB4N1NodzQzMlp0Q1RvOW45cXJ6bnNKOGNJ?=
 =?utf-8?Q?xYXK3BJtlmDDQDSlMME/77H5N95Zbk7sE7+8g5P?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjhFRllwMit3cG4xOWdnT1B2NWRzYzVrWGlLazRGNHNOVjhlVFQyRU5DNm1p?=
 =?utf-8?B?UUZaQ3ZDclZjRDI0VUdsNW1mUHNPZ0tyMDV5NVR4ZXV3YXVqTEdwWDBlRm5X?=
 =?utf-8?B?QlcyNm1SYzB1R2h0SW5FUjY4N3QyT2ZRZFJLdmdJVDg5S1NORis0VTU3M0Fa?=
 =?utf-8?B?UEEzS3p5ZEdTdHVLNXlabXBZTTVMU2IrNEllNVdLRkFsT2YrTEtiQlNoUXBv?=
 =?utf-8?B?Ulo4bDZXNitoN2F6dzNLUjN3WkRHMU4vOW9OU3piUEtMQlA2MXJxTndSdjBl?=
 =?utf-8?B?ZW02a1R6SGpQZll0Y2ZwVytLc3JRamw1Nk5FZGt1YnZlQjZrVnBHVXRxV0h5?=
 =?utf-8?B?Z2ZBYTcycmo2TDBYZklBUGJmejI3NEw3YXc4dUNSZ05sdmR5cFNhd2pwaUhC?=
 =?utf-8?B?amNXdEUyQlJxME1Bc3prUGRIaVdGMk0rRGFxZnVXL3BET0ZlTThOOGtGeFdF?=
 =?utf-8?B?STZ6WDFjNzRvR0tFYmE5M1RNUThyR2pGZmo4SktSSHc0bmhnVDlUM0gwTnNI?=
 =?utf-8?B?bmRWZmYxLzVDL3pDOFFWNzBZaDA0U0M4cDUyOCtJQWM3L2t4WUQ5YTFnNkhG?=
 =?utf-8?B?OFBOaVlxRHFVVWpHRDVRbURtd2RaT0J4MkJteGx4RGNMVm5VWmdESjBCTzJL?=
 =?utf-8?B?RXhWK055amVMS25YNlQvK1EwNWRGS05zQ2pGTnJlc29PcEt6c2cxRzF2emVz?=
 =?utf-8?B?T0lqcjhWdTl5RldpRytOd2RPMWdJZzZTZEJHU2R1VmtORk9UWTJ6d045SVIz?=
 =?utf-8?B?SFBBSC8zTFUvSG93bFlsdHUzL1hxK1NwbTRnWWhJNEVMYlFXK1NQR09KNTdR?=
 =?utf-8?B?eTk1Q0RhNEtPdXVFSHU0eEV4Z3ZFMWhFNVdPQUdaU0JLOTNidEJHd0p3VjNW?=
 =?utf-8?B?M2NoUW4vRGZFMWp1YnFma0pXV0NhNHEvek9ucHk1T1g3UllkOTNUVFRGTmVj?=
 =?utf-8?B?WjZhb3JTM3R5emxmaFg0Y09NU25aUGMvT2l3MjdRalhGYU1nN3I3R0l6ZWJp?=
 =?utf-8?B?dWp5T1RBVkxwMUx2eE5JMlNsV1FEaFVETG9rTnBmUjNWejE5dWhmc1BNQlhB?=
 =?utf-8?B?cjg3VTI1ZmdLS2F3enNtZUp4cjZlcDg2cE9CR0cyRldwYWVTby9JZytkOHRD?=
 =?utf-8?B?cXBKZUJsL3RoK0V6ZU8rd1pPQVc2Rkswd2MzTWJzemI3RUcwMHZSRnprb255?=
 =?utf-8?B?OGcyUG9hTVhzRXJhZ1dzYVdnVFVUQXdua05KTjRMSWErTlY3bG1rWDI2UWx3?=
 =?utf-8?B?Rmk2eVBhaE9JWllwdDV2Y3VMWnBvbkNQaG8ycmtmc1NSSkxPSTdGMkE4a0xI?=
 =?utf-8?B?RTduTWh6SThKcWtYa0hUR2N0OXBXTWR5WUY5UGp0aXJEbnZSbU96T2FscllF?=
 =?utf-8?B?Z1Q3c0c5RmNSQ1VlKzNRRUJvOGVFWEc1MmwyL2NOa3orTDJUOEN2RjFIZEhH?=
 =?utf-8?B?WDZzQUliZkZtWFNoZDN1NVZUcUM2YThlRWpTdUFiU25GN2cxUTk1NEhla0dG?=
 =?utf-8?B?bWJFcEhiRExXMitvWkRyWWdjYi9BY2tucExDRlNvdTFlQ05DOHR0R0l6aEFr?=
 =?utf-8?B?MDZZay95Q3JseFV5S3R5N3lLUG5oZnh6RDJoNWRoQ1JWclFxczh6MWNsM3Bi?=
 =?utf-8?B?L0k4T0FhdzFzL1F2R1duSXNSMDR6emtVeUFGZXA0Z29MS3NqbzA3VDk0YXBk?=
 =?utf-8?B?WXcvZHVnTzYzNzk2dUEwR25aMmMxWGM2SkgwYXZEWGJQbVF0eVJ1cFE2K0R1?=
 =?utf-8?B?VTdEWHpkcnY2a2N2alNvQVZMS3NXelR4VTJRVG1aMXY4dHZaMmMyeU9oUTdm?=
 =?utf-8?B?bHFxempDRXJxQnRzYWRBZUREeFJBYnN4K2pMS0ZrK254cU9xMHNJUFRsMnRI?=
 =?utf-8?B?aGlOVGFkTWJtNU03aXJQNTJHb3FtUWFzM1JZeVhvUmMrTytDdVRSVVVpalJm?=
 =?utf-8?B?dU1BS1pHNFFCWGZucUl0NWx3RFI2VTZyOGhtR3VEcVlDSzhyTnJYM1hRR1N4?=
 =?utf-8?B?TTh3S2RJWW5lRDBHK1lsV21mRW01MEhqRGpkaDY4SnJyem9LTUdFRjl0TXdI?=
 =?utf-8?B?RUMrcW9HeFdlMndYb0JJNDZsM20vM1FhZzdFTlVrc1hKMmFKOXZRcHlDeGlY?=
 =?utf-8?Q?Bwdb07+h7DBEpFGYjt/Iy0hVT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d090622-70e6-41d4-5510-08dd03a07ba6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 05:03:16.4032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrxUl8yf+AxyJJd2sINMz/tfSeTqYz1Lq2+s3reEzZicRL7ld6IUacwNbXeKQ3+J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197
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



On 11/13/2024 10:16 AM, Alex Deucher wrote:
> On Tue, Nov 12, 2024 at 10:24 PM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>>
>>
>>
>> On 11/13/2024 7:58 AM, Zhang, Jesse(Jie) wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>>
>>> Hi, Lijo,
>>>
>>> -----Original Message-----
>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>> Sent: Tuesday, November 12, 2024 10:54 PM
>>> To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Huang, Tim <Tim.Huang@amd.com>
>>> Subject: Re: [PATCH 2/2] drm/amdgpu: fix vcn sw init failed
>>>
>>>
>>>
>>> On 11/12/2024 8:00 PM, Jesse.zhang@amd.com wrote:
>>>> [ 2875.870277] [drm:amdgpu_device_init [amdgpu]] *ERROR* sw_init of IP
>>>> block <vcn_v4_0_3> failed -22 [ 2875.880494] amdgpu 0000:01:00.0:
>>>> amdgpu: amdgpu_device_ip_init failed [ 2875.887689] amdgpu
>>>> 0000:01:00.0: amdgpu: Fatal error during GPU init [ 2875.894791] amdgpu 0000:01:00.0: amdgpu: amdgpu: finishing device.
>>>>
>>>> Add irqs with different IRQ source pointer for vcn0 and vcn1.
>>>>
>>>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 19 +++++++++++++------
>>>>  1 file changed, 13 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>> index ef3dfd44a022..82b90f1e6f33 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
>>>> @@ -83,6 +83,10 @@ static const struct amdgpu_hwip_reg_entry
>>>> vcn_reg_list_4_0_3[] = {
>>>>
>>>>  #define NORMALIZE_VCN_REG_OFFSET(offset) \
>>>>               (offset & 0x1FFFF)
>>>> +static int amdgpu_ih_clientid_vcns[] = {
>>>> +     SOC15_IH_CLIENTID_VCN,
>>>> +     SOC15_IH_CLIENTID_VCN1
>>>
>>> This is not valid for 4.0.3. It uses only the same client id, different node_id to distinguish. Also, there are max of 4 instances.
>>>
>>> I would say that entire IP instance series was done in a haste without applying thought and breaks other things including ip block mask.
>>>
>>> If the same client id is used, it returns -EINVAL (because of the following check) and sw init fails at step vcn_v4_0_3_sw_init / amdgpu_irq_add_id.
>>>
>>> amdgpu_irq_add_id:
>>> if (adev->irq.client[client_id].sources[src_id] != NULL)
>>>         return -EINVAL;
>>>
>>
>> We had some side discussions on IP block-per-instance approach.
>> Personally, I was not in favour of it as I thought allowing IP block to
>> handle its own instances is the better approach and that could handle
>> dependencies between instances. Turns out that there are more like
>> handling common things for all instances as in this example.
> 
> We tried that route as well before this one and it was ugly as well.
> 
>>
>> I would prefer to revert the patch series and consider all angles before
>> moving forward on the approach. Will leave this to Alex/Christian/Leo on
>> the final decsion.
> 
> Do the attached patches fix it?
> 

This is kind of a piece-meal fix. This doesn't address the larger
problem of how to handle things common for all IP instances.

Thanks,
Lijo

> Alex
> 
>>
>> Thanks,
>> Lijo
>>
>>> Regards
>>> Jesse
>>>
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> +};
>>>>
>>>>  static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
>>>> static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device
>>>> *adev, int inst); @@ -150,9 +154,9 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
>>>>       if (r)
>>>>               return r;
>>>>
>>>> -     /* VCN DEC TRAP */
>>>> -     r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
>>>> -             VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst->irq);
>>>> +     /* VCN UNIFIED TRAP */
>>>> +     r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[inst],
>>>> +                     VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE,
>>>> +&adev->vcn.inst[inst].irq);
>>>>       if (r)
>>>>               return r;
>>>>
>>>> @@ -174,7 +178,7 @@ static int vcn_v4_0_3_sw_init(struct
>>>> amdgpu_ip_block *ip_block)
>>>>
>>>>       ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[inst].aid_id);
>>>>       sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[inst].aid_id);
>>>> -     r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
>>>> +     r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[inst].irq, 0,
>>>>                                AMDGPU_RING_PRIO_DEFAULT,
>>>>                                &adev->vcn.inst[inst].sched_score);
>>>>       if (r)
>>>> @@ -1734,9 +1738,12 @@ static const struct amdgpu_irq_src_funcs vcn_v4_0_3_irq_funcs = {
>>>>   */
>>>>  static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev, int
>>>> inst)  {
>>>> -     adev->vcn.inst->irq.num_types++;
>>>> +     if (adev->vcn.harvest_config & (1 << inst))
>>>> +             return;
>>>> +
>>>> +     adev->vcn.inst[inst].irq.num_types = adev->vcn.num_enc_rings + 1;
>>>>
>>>> -     adev->vcn.inst->irq.funcs = &vcn_v4_0_3_irq_funcs;
>>>> +     adev->vcn.inst[inst].irq.funcs = &vcn_v4_0_3_irq_funcs;
>>>>  }
>>>>
>>>>  static void vcn_v4_0_3_print_ip_state(struct amdgpu_ip_block
>>>> *ip_block, struct drm_printer *p)

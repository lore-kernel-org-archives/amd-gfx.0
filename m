Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BA5C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 03:40:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B02F10E180;
	Thu, 16 May 2024 03:40:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CGQrcwrn";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67A9110E180
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 03:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/LMYY2rTic1+OirpwEtGE/0FRmF/do8bz9Tuk0pZo5WRfoSvcir2Cr3H8E5tOgQNDfjHMdoX+MIrTyjDXSnfHBeRUccK99MFBF9JyFQ3o8L1kopCWjuQzLvatwEDWajobeP/zWTO1i2Jvk/+TGAWhCZGR9y7Hcsm6jF3VCD+/esVSIs4m7VtR7uYs//gxORNVfXmUlpn+OOF8jZDnW6euFl+9Dr4q6JdRlA95CXW1aatCdUc9H0ZJSlpTHqodkWye/EqE+sr5xnVN7P4TGnCqNiB8FUvZP2jpYLOGJWSUKS5VuvTZY6WJe3fwKvvYrFA/R8R0M3Nu8jLsyQYIsTPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pvCIYqwq3F6hjKJ9zoHSY4tTAVqXqecruqyTIpcciI=;
 b=J/kHUhp7oic00LCOCPNEY/P4FubE0Iz5v8GeJhLWtsKY8uMb0kq7t1xv3lrAtXNe7yIepK9Ha9TOVNm+3HVSCQn42Md/DHtdAFDaDDyesVaSN3qsC5MjyA8CHBt9oyif/Ewx95ZkpxG7KMNpFY1XMzdaOev2Sw9BeV2UF54mGLTrcL2+Gl1v4VtkAOgl6eUAm5KEyVh4v/ghYZo9iFBCNeQH6ebSonRqx9WCphMY0Ls7xQRkMImIAya8ClQjnx/7HDFWprmgyTWdQQz4ITAbfHnIsX95DldqUFA/m+jpBmnq060+HumosCmwPUMfrRL2n4HjfNeXCsXyrwakE21K4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pvCIYqwq3F6hjKJ9zoHSY4tTAVqXqecruqyTIpcciI=;
 b=CGQrcwrnHteZBVYVp/YqgpOOh2KOS/qKS/wlXhL/Qd/WH9sxltgFT37FypPDYW1gX7z/fkw/Hr7duUZQZfTW0aWoPxdWrqKWPew2qvOAdcsCXZalN4gynkU+UVmNTOrvhmtCjy8mquk+JHzVIQzliIpzBYByXxF+mdcVSgPN6+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by MN6PR12MB8492.namprd12.prod.outlook.com (2603:10b6:208:472::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Thu, 16 May
 2024 03:40:35 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::8865:d63a:a8eb:282b%4]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 03:40:35 +0000
Message-ID: <62b9661e-9d70-4152-af4b-2fa9ddac49c4@amd.com>
Date: Thu, 16 May 2024 09:10:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] drm/amdgpu: add support to dump gfx10 queue
 registers
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240515121754.1810181-1-sunil.khatri@amd.com>
 <20240515121754.1810181-3-sunil.khatri@amd.com>
 <BL1PR12MB5144866E6DD7FD0EC9226EB9F7EC2@BL1PR12MB5144.namprd12.prod.outlook.com>
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <BL1PR12MB5144866E6DD7FD0EC9226EB9F7EC2@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::17) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|MN6PR12MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: d62a1ee6-6ead-4d04-49e3-08dc7559f1f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkhXRUpnWkFYYnMxY2J3Vit5UEpjaEJwLzZJbyt5aUJ3ZUhJQ096RWg4YjBO?=
 =?utf-8?B?bXplTE13aEsvSkJYWU5mL2RwSnc2ZEJpZUZmRm4yTk5KMmlUTUh6UXNGVFZs?=
 =?utf-8?B?MnEzN24vSVpCWmprRVEwMUtWODYzWi8yTkM3RVRYS0oyRU92Q2xuYk5jNFo0?=
 =?utf-8?B?cjYyUS93cytDTExmMEgxK29NbUJNTTJaODJ6NXZWeVpoK0ZIaVJKUmF2NEVF?=
 =?utf-8?B?YkdPN2Rmdm1TYUUwV0Irak11R3lTcDZEL3hwMXIwQXFXOGg3aHQyT3dzdldD?=
 =?utf-8?B?Nkh2REtjT3dwUTAwaGlWZTYrRHZ4U1VncVZ6UW1GV201MEpkT2NLMThZOXhn?=
 =?utf-8?B?anRldnFub2RocytjL1l2WTdyM2NCN2FCYVIveGFOemhrTDkwTDBaQm1YTFhU?=
 =?utf-8?B?QjFyUTZBS2tLeDArMkluVEVJclBJSEFHanVSYUxTb0pwZUpLcTQ5RE50Uit4?=
 =?utf-8?B?UGtldU1BbGhrYzZQUW43MTNEYXhFbGVwNkhraVFFcDN2bmY4bnMyRU11eGpk?=
 =?utf-8?B?SXhsQ0tjTWw1elpQREFUVHp2VlV6c1dKVk5JUldRZW01dTYzM1hLYnJjV2FY?=
 =?utf-8?B?dmEyQUp1MWdOS0wwT2pxUDVqeCs0R1dPN0kxTHpsY3N3aTNHcUhPQWpKcldZ?=
 =?utf-8?B?bHlQQWNIWWJhVXNqZ1lrOUZocVVnM1o5dHdGUk9tTFhjVURJOUdJbGRibThD?=
 =?utf-8?B?TlJYLzZWN25YWWZLSUdSUldpbHlGaDArcU95eGtsUzh6alJaTTQvak1EdFRj?=
 =?utf-8?B?RysrbXZIaHBTaWRBZjdLMVoxdUJ2NmZ0dEp2TVRwRGpLQjEvNjZ4TVd6SmdV?=
 =?utf-8?B?THRwamR0SDl0Q2lvZ09wdUU1N2ZGRXRDSXNxVGs1dDVDWFltb3pLZGJTa3pZ?=
 =?utf-8?B?ZzlMRWkzZ0FIU2ZpS3ZhcWlrZnFWL2oyaWUydDFJV1JYUTJ0c1kzU2ZyT0JT?=
 =?utf-8?B?U3hoVmRXNmVJK2k4S0JYdDh5T0VFMFp1M0wyYTd2U2ZNYXRmT0kyY3VxWE5q?=
 =?utf-8?B?YlJEUnQ2emZKS3hRWjBxdlZsNTlBcXhjZjNaR2lmVkc0aFNoNEtFV1FJbk9N?=
 =?utf-8?B?Z3pDd0tGNkRERU1sSWhzMUwvdS9zRWNvY3hMTjJScUprR1Z1K04yUk5KNlIr?=
 =?utf-8?B?Zkk2WHFSL0RseEJVZlkzMnBvQW41ajk0dGx2dnNTTlhkMkV0NlJHYnQrZVBu?=
 =?utf-8?B?VzhobWVwTk1YL0lKTjkzaHdaVHBJaU9veFFxUUlNbytlV1UzQjQ4eXRLTk91?=
 =?utf-8?B?bkFRZWhDMWFBWHRqTFJ4YnlYVm1uNVVnN3orbUtTZTZEejhxQ1k4ZGJhQVRH?=
 =?utf-8?B?dUtCMDA4UFlHZWxkMG9rbjdjcUJsQ3ZRY085c2NvMHlBTzFQSXlyeHNEaDZs?=
 =?utf-8?B?MmZXN3hxK3VvWkcvQ1hWelB0ZWliQ0Qzb2paczExYVAvTUhKNXUvTUI0ZXZY?=
 =?utf-8?B?T2hmaHExSzJqTGVHOXlZYldkTUl0Smp0SC9wMWo3Zm9rTzY1NDJ1aVd2Q1li?=
 =?utf-8?B?dGpnQkVZTm82UUgzMEJWRElTb0J5OW9TZThuamhOelk5R2VEYXphSWxySWNP?=
 =?utf-8?B?U1FBYldVMVRUWVBIZFIyUE9LbHFPUTIxNUNaaEJ4QWc2eWVMUUIycElLUlI3?=
 =?utf-8?B?OXJadmMwSHNZYXpaT0wvQTgzcm9GeXNZVTA5YW1SWVdvbTdhcDBTVEp1NlEx?=
 =?utf-8?B?NERBMlBKeHh0ekczWVZaSmFSTjk0Z2xpam9HdzlTOTJ0M1FVWUFmTlBBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmQwWWxMS0xrR3BRQ0xDREhNSFA1c1RmRnZpWEp5LzF6YWdaMGxldkRoNWFQ?=
 =?utf-8?B?R0x1V1hOMDdRY3lPV2t2bklSaEVBZzRtN1FKSlNvQzBra1c0cmJVVFJlRUJB?=
 =?utf-8?B?ajcvZVN1aS8yM3lwdkhxNm51UkVtZHl6ZWhZRS91Qy94Tit1UDRDYWYrQmND?=
 =?utf-8?B?QW5NTVdwWE1sUkNWdm1UdmpWcytNQzczQmJIV0tHQWRSSWIwTVpYYmdEempi?=
 =?utf-8?B?L3hYZVN1Y3JwMXFTQlRzeUlaUlR2VllyMjBrbTJQbm91YXRBeEh6YUY1OVN5?=
 =?utf-8?B?VGN5N3lUYmNHSXJDenF6S04vTFYweTl2enlvNkE1RytRMkk2RCtRMWcxL01I?=
 =?utf-8?B?VzBEaVU2bm1RQzJOZzlvUjI0R0xnYjRyRDc3MlFKdmlpQ1JwS2Fua3ZYeE9X?=
 =?utf-8?B?NWVQRWJxbEhndTQxNXQ4VWFZWVpuTDVoNGc3NE5CY1gzY1BwL2NGWFQyYTh4?=
 =?utf-8?B?MjdqZnRYb3JuUnUrWDgvMytXNU9ZQ2NtNFUzTlMwa21UTTVxTTJteHBTd05P?=
 =?utf-8?B?eWJqa200V1NSQVBnVGpoVXlwbUlremFZSm1iZG5YZHFxamdYRnJ6eEp5aXV0?=
 =?utf-8?B?VUVEMHc4NGxCVkNKdXFNZmtqcC9iNWVxUkpvQmRpVWw4cUR5VWpQN3lhR2M3?=
 =?utf-8?B?Vmt6ZFNvR3hTakZZN0JTR0o4VHkwZGVZaWw5TEVQRmlwYjFKYUxMc05LQTh2?=
 =?utf-8?B?QU53TEV1TWVtdGZVN0tWYkcrcWlTNks2QVRBNzVzVm00UmhwM244QWlZQ1Vp?=
 =?utf-8?B?bWpYbVA0dWhFaU9lQVBCRjNCclpjVFpXcHQzZzRVL08rYk8wRnZtNXVaM0xC?=
 =?utf-8?B?L3liQ2ZjRHJuaTBFWXladURwbWlXSC96UDFwaEpNcmZTa2h2T3RKVW1tN2Va?=
 =?utf-8?B?RUFycjFrTTd2R0hPa0N4TThGb1YyUW5LNmZETi9GWXVVNzRhSGVDY1IxclZz?=
 =?utf-8?B?c2Y0d0NBbmtkcWRVeVNueGlTeXN2YVAxckdmZ2tuOWg3Y0VBa1ZjYmhYYlZp?=
 =?utf-8?B?K0lvK3l2cmZHMXVheFBXNjZNc0w5Mzc0cGJoTUVlSHJBMGpNVy9LRzVkSzlV?=
 =?utf-8?B?STNXQVQwb3VueUVmSFN4L0lyVXd3Wm93NE9VT0FxYXR2ejkrcHVFcy83dm5Z?=
 =?utf-8?B?MkYvWUw2TFRGc3RrYnViU2JlNFlrTW4wazBZNndZNFRyalVIRU1tZ1U4SmNW?=
 =?utf-8?B?clhBbzRFZWExNFBydThEVVAxNUxFOHJIbENzVjlhS2EwVklIZW1xUG5RZmRQ?=
 =?utf-8?B?S3FLaDJCaUNFY1pvbmJwTC96cTBUdVRiUVhWU0pTdGRHM0VsTGpUdTNPbXFu?=
 =?utf-8?B?RThDblFZbjdpYklGZkJhblZMWVJISU5TVUxWZG9pWEJXZWxsNG1BOVRsdFVV?=
 =?utf-8?B?YzhDWFg3RnRYQ3VscUs4ZWRFV1QwOEZCSTVOS2xjbnRMWjRsUXBBV2dnUlZ6?=
 =?utf-8?B?Yzh4ZUczVEJQaUFxSkl6ZmNTM1ZEQXJsaG1pRzkwMi9KNmZmVjBJb3FKQi96?=
 =?utf-8?B?NjVUY2I2aFVSaUpWRTZmQklxSDh1S21lTzV1c094QTdNUTZtbU0xMm52dS9W?=
 =?utf-8?B?bm9ZTHphVzlhaHRWdDFXQkZHd2JHdG1EK3p4R2VRQlFKbncxVmRhMnNSMG5G?=
 =?utf-8?B?SXF1Z0xER09rNnNyNkdDYnUzUWhNTVJRK1hsQkZaMDBDNE53Zlg4bnF5aDZF?=
 =?utf-8?B?enZqdGU4ZnptMC92WXYvZitlL0xSQkJ1ajZDNk1iZnhscGpPR1RKY2UwSXpG?=
 =?utf-8?B?RTVvdUgxOXhNMW9oZ1FQMHIyNkR5WXNOZ1B4amlScjYzWWlDZnlMdGlSZytT?=
 =?utf-8?B?T1FIdWFBLzRxWVFIWmZVaHZ4aWxCN3UxY2pFZXgvTkJoa3Z2RVNSWkdrQnFs?=
 =?utf-8?B?U25WNEZoT3JCUFowcnZPRmtzanhheHZody9kb3Qvd2U2VkxUZlpSREdlRDF2?=
 =?utf-8?B?RWZyMG9lWHRxdzNjd1ZhZWRSaHR1UVpnRFRxbEp5bFlaTmtpaEpLeUFBblZy?=
 =?utf-8?B?RUJtVm9WcUVkS0U2TnNyRGpIRzF1S0t5elhQUjd5U0p0aHhPWmNMN0hGOVZR?=
 =?utf-8?B?U3VNK1QydTQ2cUtHY3VnY3pSd0tDaFRENGtoYlNGQ1dCTGppSnN6Nmh0QnpZ?=
 =?utf-8?Q?6QpUWMTGRcB91NC4VNK2BjGkw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d62a1ee6-6ead-4d04-49e3-08dc7559f1f3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 03:40:35.4829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zy1EG/FezGvv0gveaiQ6uGtuzGVed7It0vYMBAuuZ77zYtxuW85n+h7i0Np1h8pFymWGGt4TwvOiifZ6UHZ5vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8492
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


On 5/16/2024 1:42 AM, Deucher, Alexander wrote:
> [Public]
>
>> -----Original Message-----
>> From: Sunil Khatri <sunil.khatri@amd.com>
>> Sent: Wednesday, May 15, 2024 8:18 AM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Khatri, Sunil <Sunil.Khatri@amd.com>
>> Subject: [PATCH v3 3/4] drm/amdgpu: add support to dump gfx10 queue
>> registers
>>
>> Add gfx queue register for all instances in ip dump for gfx10.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  1 +
>> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 86
>> +++++++++++++++++++++++++
>>   2 files changed, 87 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> index d96873c154ed..54232066cd3b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> @@ -437,6 +437,7 @@ struct amdgpu_gfx {
>>        /* IP reg dump */
>>        uint32_t                        *ipdump_core;
>>        uint32_t                        *ipdump_cp;
>> +     uint32_t                        *ipdump_gfx_queue;
> I'd call this ip_dump_gfx or ip_dump_gfx_queues to better align with that it stores.
>
>>   };
>>
>>   struct amdgpu_gfx_ras_reg_entry {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> index daf9a3571183..5b8132ecc039 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> @@ -424,6 +424,33 @@ static const struct amdgpu_hwip_reg_entry
>> gc_cp_reg_list_10[] = {
>>        SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_DEQUEUE_STATUS)  };
>>
>> +static const struct amdgpu_hwip_reg_entry gc_gfx_queue_reg_list_10[] = {
>> +     /* gfx queue registers */
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_ACTIVE),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_QUEUE_PRIORITY),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_BASE),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_BASE_HI),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_OFFSET),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_CSMD_RPTR),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_WPTR),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_WPTR_HI),
>> +     SOC15_REG_ENTRY_STR(GC, 0,
>> mmCP_GFX_HQD_DEQUEUE_REQUEST),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_MAPPED),
>> +     SOC15_REG_ENTRY_STR(GC, 0,
>> mmCP_GFX_HQD_QUE_MGR_CONTROL),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_HQ_CONTROL0),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_HQ_STATUS0),
>> +     SOC15_REG_ENTRY_STR(GC, 0,
>> mmCP_GFX_HQD_CE_WPTR_POLL_ADDR_LO),
>> +     SOC15_REG_ENTRY_STR(GC, 0,
>> mmCP_GFX_HQD_CE_WPTR_POLL_ADDR_HI),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_CE_OFFSET),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_CE_CSMD_RPTR),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_CE_WPTR),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HQD_CE_WPTR_HI),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_MQD_BASE_ADDR),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_MQD_BASE_ADDR_HI),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_WPTR_POLL_ADDR_LO),
>> +     SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_WPTR_POLL_ADDR_HI) };
>> +
>>   static const struct soc15_reg_golden golden_settings_gc_10_1[] = {
>>        SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4,
>> 0xffffffff, 0x00400014),
>>        SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_CPF_CLK_CTRL,
>> 0xfcff8fff, 0xf8000100), @@ -4664,6 +4691,19 @@ static void
>> gfx_v10_0_alloc_ip_dump(struct amdgpu_device *adev)
>>        } else {
>>                adev->gfx.ipdump_cp = ptr;
>>        }
>> +
>> +     /* Allocate memory for gfx cp queue registers for all the instances */
>> +     reg_count = ARRAY_SIZE(gc_gfx_queue_reg_list_10);
>> +     inst = adev->gfx.me.num_me * adev->gfx.me.num_pipe_per_me *
>> +             adev->gfx.me.num_queue_per_pipe;
>> +
>> +     ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
>> +     if (ptr == NULL) {
>> +             DRM_ERROR("Failed to allocate memory for GFX CP IP
>> Dump\n");
>> +             adev->gfx.ipdump_gfx_queue = NULL;
>> +     } else {
>> +             adev->gfx.ipdump_gfx_queue = ptr;
>> +     }
>>   }
>>
>>   static int gfx_v10_0_sw_init(void *handle) @@ -4874,6 +4914,7 @@ static
>> int gfx_v10_0_sw_fini(void *handle)
>>
>>        kfree(adev->gfx.ipdump_core);
>>        kfree(adev->gfx.ipdump_cp);
>> +     kfree(adev->gfx.ipdump_gfx_queue);
>>
>>        return 0;
>>   }
>> @@ -9368,6 +9409,26 @@ static void gfx_v10_ip_print(void *handle, struct
>> drm_printer *p)
>>                        }
>>                }
>>        }
>> +
>> +     /* print gfx queue registers for all instances */
>> +     if (!adev->gfx.ipdump_gfx_queue)
>> +             return;
>> +
>> +     reg_count = ARRAY_SIZE(gc_gfx_queue_reg_list_10);
>> +
>> +     for (i = 0; i < adev->gfx.me.num_me; i++) {
>> +             for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
>> +                     for (k = 0; k < adev->gfx.me.num_queue_per_pipe;
>> k++) {
>> +                             drm_printf(p, "me %d, pipe %d, queue %d\n",
>> i, j, k);
>> +                             for (reg = 0; reg < reg_count; reg++) {
>> +                                     drm_printf(p, "%-50s \t 0x%08x\n",
>> +
>> gc_gfx_queue_reg_list_10[reg].reg_name,
>> +                                                adev-
>>> gfx.ipdump_gfx_queue[index + reg]);
>> +                             }
>> +                             index += reg_count;
>> +                     }
>> +             }
>> +     }
>>   }
>>
>>   static void gfx_v10_ip_dump(void *handle) @@ -9414,6 +9475,31 @@ static
>> void gfx_v10_ip_dump(void *handle)
>>        nv_grbm_select(adev, 0, 0, 0, 0);
>>        mutex_unlock(&adev->srbm_mutex);
>>        amdgpu_gfx_off_ctrl(adev, true);
>> +
>> +     /* dump gfx queue registers for all instances */
>> +     if (!adev->gfx.ipdump_gfx_queue)
>> +             return;
>> +
>> +     reg_count = ARRAY_SIZE(gc_gfx_queue_reg_list_10);
>> +     amdgpu_gfx_off_ctrl(adev, false);
>> +     mutex_lock(&adev->srbm_mutex);
>> +     for (i = 0; i < adev->gfx.me.num_me; i++) {
>> +             for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
>> +                     for (k = 0; k < adev->gfx.me.num_queue_per_pipe;
>> k++) {
>> +                             nv_grbm_select(adev, i, j, k, 0);
>> +
>> +                             for (reg = 0; reg < reg_count; reg++) {
>> +                                     adev->gfx.ipdump_gfx_queue[index +
>> reg] =
>> +
>>        RREG32(SOC15_REG_ENTRY_OFFSET(
>> +
>>        gc_gfx_queue_reg_list_10[reg]));
>> +                             }
>> +                             index += reg_count;
>> +                     }
>> +             }
>> +     }
> Does this one not need an msleep?

Since the registers are also less and also total no of times loop runs 
is lesser too. But we can add the msleep as it does not seems to add any 
delay in overall.

Regards
Sunil Khatri

>
> Alex
>
>> +     nv_grbm_select(adev, 0, 0, 0, 0);
>> +     mutex_unlock(&adev->srbm_mutex);
>> +     amdgpu_gfx_off_ctrl(adev, true);
>>   }
>>
>>   static const struct amd_ip_funcs gfx_v10_0_ip_funcs = {
>> --
>> 2.34.1

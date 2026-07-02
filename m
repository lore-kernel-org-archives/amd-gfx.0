Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3490C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 08:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6404910F206;
	Thu,  2 Jul 2026 08:13:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mhSDI2Kq";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012023.outbound.protection.outlook.com
 [40.93.195.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2100110F206
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 08:13:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JubvgQtfypBr9FAry37PxlW1TbT16fF4jkDsHW+PqQCj4IXVoMCXbxoEhDVtYnLcF7pURtEvy4ljKGiviSUae1/SpWkv8xcBzCkEQ73cSiGELh6d9upgBhygKDW2oGkuqir7Zt060Hg/IBFlQORoNnMl4d/vXJjPqphrshW3k58zHx6ZWwxdP1DCDdgsl79Gd8lJDasNXAH6ryKj6BThTCIQTG0xQLaelvosAM4Ocjv8mx/ppv1LhdojwpFyZLhbXywNrVxx/4fyOdUJleaAI60kKRy4W4uwmbkpruDNgorwGqr+8TvaHXe6tIMVFt/7P89uldloJPf0qTpdm7mvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4GRhor6wBX3ua4EYR5lTDn6yS9oyhu5JByLedHA9MEY=;
 b=UXkl8eFT1+0jbR+Ot+94DkAKXRHSmGO5nJEIZxAL7SAhEtaEwq7+pExYek6dwq4Hgi5Exxe8m9nmlK5A5laG2hxnHR6B9cAkhihfLwJZfO6yjqZ8uLhlUwGLHgJVWOiK8eqxAk0v+qGlf90sKpxEzpkEZVTACtlTNFAKB05BfxvAohs9qSIGAc/8CM1LRLg7y3Kytpl3rizNr/RNHyhp/+4LXOipTW1kYWKhESFCu2BP6aPKM0FjXsb6gtOiPTgnrgwnjlZycJsuYX9LcoradKstOPfrBD10tZoBdaJoiSNnkS+ECeB8tm8I3Jf+YXlNsBajLa26ad8SY1jxFw1BHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4GRhor6wBX3ua4EYR5lTDn6yS9oyhu5JByLedHA9MEY=;
 b=mhSDI2Kq3AXelvwfCkl/U3va3sdkb+BMf7BSl6Cxtn1xsXns5xpH2W1pGbZClWb1yeSvHwR+GhWMfbvkUWdAIhrBvoVxgCpIEfjqMsfqxwmjTiOABKgXw/wmCF+arAQd/98hhIvH+jNdC3yofOyPFDL7njOVWIJ3i+TDxgzF1Jw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB8165.namprd12.prod.outlook.com (2603:10b6:a03:4e4::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 08:13:14 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 08:13:14 +0000
Message-ID: <afb46518-8c45-4fab-8d54-d578d5b9ee29@amd.com>
Date: Thu, 2 Jul 2026 10:13:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] drm/amdgpu/ih6.1: Use IH_SW_RING_SIZE for soft IH
 ring instead of PAGE_SIZE
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-6-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260701161721.85681-6-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb99ad8-7f39-4857-c08c-08ded811c3a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|4143699003|18002099003|56012099006|11063799006|22082099003|921020;
X-Microsoft-Antispam-Message-Info: dVvFWcyS7Q+KyqUVGU/Y5QBid+y99rFp8CkSZyiWnBi+5ybJrME6ZMcqFHQGrF+4EJpjqk0gO7iS8YqQGSO80SvsXFtsM4A/aHDkwpNKRlPsmWIn6/sudrtdS4OzbEgDruMmhJS+VAPbrCzHbgqGNORLcJQ+X6Y8cJS6gzwnAlyz3eqgbUKY2yNcz5Xs8wMIy5jCTi28xU2CnM79SpHmreILqR7r2ZYgQO4vwKxXLftv/Xo2spOc63ethQ5BTLol3wMsU6NJcoesk7w7qpq64cbg1r4thm6lRq2oztTsxnp4E1AYExAA7ZofVdpUIZHRJXtdzcI9ydKPktdxv2IJiiXq89n4aURtGBMwhnki6YA98MnWxl4pzoz1pB1FJ9C9SNGmxX6ZoZAMX5OB7xgQ2dmMVfGzdCk5Q55knT7w+3VKVP5UioL3pAZjHr1nEkb2vKERwShUXbSyysrHTRFZ4oP1EU1fzRQhVUdREWNFod2dfQAaDgxR5lMTwKE5/CTJe9sWYgrP4HRAMzHk+QxeQIvjJUhV3PUazbnPE5UzBtNhzD7Mpj+SVYhj4kJDccWoCh9531R/YGxOAsp6yFzeLBglykwXwk1rKkqDNIclzwKQI6lVKpo2fhWPydouTehchNMphTD2eNBFPuQslAN0JOWkwJum9eJNNB1SeApcLHb48I40tgGvLSzuqPqN24Wjx7XrQocfbDIYtemiwXVWdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(4143699003)(18002099003)(56012099006)(11063799006)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWpsNHEvRyttNis1WS9ZczA5Q0dIQnlqai9xaGJLZWpUR0VXdHAyMW5CeEdP?=
 =?utf-8?B?VE9wWDgrK2Q3WkpnTlR0MDdIbVRWMW9vckRYNi9WRllLV2pkWjd2WTMzZW1B?=
 =?utf-8?B?MU5aSlRIbkRtUnJTWTloYXY2Z3lWaTQ0YmJxblBoYkVmU1M2d2Z1MHAvSjBN?=
 =?utf-8?B?VHdreTFqcFQ4WGRFMUh0dC9oZFdoaHY5cWlTKzJjS0ErKzhBcnhZTEFKc3FK?=
 =?utf-8?B?TGkzaG5TMGozWGIxWVhCeGxndE5NN3ZramJCcHpTNHZMem85alFOSlJPRG5M?=
 =?utf-8?B?MHNZc3BncXNXbThEaG1BTysvSktxL2ZWdzFQTmpFK3B3TFRuaEF3MjRPcE4z?=
 =?utf-8?B?Vi9iUjFWRElKNnQrbmRwLzBvRi85Q3FlUC9XNXlub01UYnIzUUc3NHBSbTMw?=
 =?utf-8?B?QW9oRlFqaUNReDA0c2JLT01HT3ZDNVQ3L2lWOXcwRDVOU0RSaFFBVHVKc2tt?=
 =?utf-8?B?ZDZ3Qk5DQWhaZVQweUNKMFo3b056SWlCTTRFODJveTN0VXEySEUwdFdWWmxF?=
 =?utf-8?B?UlR3S2R1TWkwd0Q1V1NENjFsdGNpeFZtVWllR3VLcVVZVk5tOHkyZU1BalBa?=
 =?utf-8?B?MlVoMHFiNERaM0taOG5ucG1kS3NqaG11eHU3WlVRWnlWMjJiSnpreGowYTRl?=
 =?utf-8?B?ZVJZUDZybXd2YWVGOVpTeGhjN25HcXkyL0dndlFQZXdWL3FwQWdRQmJrQXFa?=
 =?utf-8?B?UXFWMU9KTEtmcHpTUEhIWmRBM3MxdHNWZWxYR0FJZVdtNWE2WU9zQzRlNSt4?=
 =?utf-8?B?bmlhOUNtWmVJQW9XWm56VkJaay9ob1p2cjZZTk5kY3FZOTlBUVNjSXdWMFBo?=
 =?utf-8?B?QjlBUm1RUHRUbjVQM0hkaVN6QXZRamV4aGIxczZ2Z1BKakFXalgvcnptYktS?=
 =?utf-8?B?dlFtQXZOMHcxS1FsVDJNNnowdmJmazRrQjFsNEJNQytMN3VBYURQYmRqRHNp?=
 =?utf-8?B?RkJ2ZmF0WVdYdVczUjRiMjNEOThneHJ1WlI1QnRnaTE3MnI3NnVBclJXRWNY?=
 =?utf-8?B?YTN4VktuSWdVZmNsUngrbmpLTnJ0ZnNPQ2lXSlViVFUvcDlCMFdYczlNSklE?=
 =?utf-8?B?ZnV4TkdpbGQ4ZTltVEJzc2gyZzdBQlNBYXJrS2FvcTBkNitKUFhKNEpnNjE1?=
 =?utf-8?B?SC9JMnVRSWV6aTVNZlViZ1p1RXFhRDdkcUlDYnVHN1IxRi83VzZreitiNzNE?=
 =?utf-8?B?cGlNOWdzdGZKWG9UQXpEZTBVaEN4VDFUUmtBbnpyMjBmdGx2OXFLTmRteVBu?=
 =?utf-8?B?enZwejc1UGRZbFZ3UkJ6Vk92d2Evdkw1WkFaUWlTcXVOUmZSRGJpeTRrVTkz?=
 =?utf-8?B?TWYxRFd3RzliSnlSMUlCT1JacDArazFsS212b28vajdrUzRSdkhPdUlUS0Mr?=
 =?utf-8?B?MllpakhGeEgyUEdPNzdYTXVrS2NjNmpZc1hJbEN6S0sxQ2R2anlabXBINVRO?=
 =?utf-8?B?akhqaFJPeVpIbTgreE1hTCs0bHpnTVRpVzFYalI5VTRaVFZJWUE1aEJicFNl?=
 =?utf-8?B?QlV5WFJXK1lxS3J2Umd0b2dFV0thQStmT1NSQm1xN1A0WngrL08wNm9veXI1?=
 =?utf-8?B?Mm85TUpJamtRUFRqaEE5SEwzT0tXcStBdE11RVdFY3RPa0prbzRISWpPQlJJ?=
 =?utf-8?B?Y1Iyd3BFdjZFYTNOSFdZS0tieE9Ka3NLLzhoby82QzR5SVVwUDM2SFA0VHdu?=
 =?utf-8?B?MjlYZEQ0YngvNXA1NitCL0NJNlJrSlZib2MzNnNKcTFrUVphSVJtODljRmVj?=
 =?utf-8?B?TVUxMzdZTVF3NWNFWk80S29EZHBIOG5wZmtCN2NpOXhpQ0J5a0dzdVQxajVX?=
 =?utf-8?B?VHkxcFZrWlR4Wm5YNjdZUTFJR01EajJiblhLekZZck1vY2QwNEVNcFVmS1Vx?=
 =?utf-8?B?MjBTRWVMaVoybk9Pd21hY2o5VWZ4QnNmbURGOUJ4d24rTFdNanBobm5nQVZZ?=
 =?utf-8?B?bmY4WWVQcTNvVEU3cHhmdmRTUHMxOW5LYmVFNDNkL0JhQnhNUlV5MHczdzds?=
 =?utf-8?B?VElHUkZwMDVVVVdyZVd1dFNpUjJNQnpiS1pqTlBLYnZCZUdLSjNxWU4rczdD?=
 =?utf-8?B?Q2hpV3Raa0hKRFFRbFNxbXlmelFyRUkzOFE0dGVKenRyb1c2dTdHSjJobDc5?=
 =?utf-8?B?VWlKa2NjK2hkYnZmQ2dvc3ZVMFBReXhhRmFxSUIzS0xQV2hoQVFrSUoxZXAy?=
 =?utf-8?B?Wm5wbFZDRzl3Sk5JbU5KS3l4ZWZNY1hrc1MxTDMvYzNidDFXZFVLNTBxS3Q4?=
 =?utf-8?B?Y2ZpRnZQRllHMHhBTGp3d1lNVEp5d1VBcG1CWVMvSm1wakhhUWdnWnYyYVhD?=
 =?utf-8?Q?xDoKBdIkSf4juKuzLF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb99ad8-7f39-4857-c08c-08ded811c3a7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 08:13:14.4214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7njPzKQvCXwIJEA9qlXf7yfAqb3DJJRBaootSqm7RPhr6cmwYUuhZ6Vd20SPJvXA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8165
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

On 7/1/26 18:17, Timur Kristóf wrote:
> When there are a lot of retry faults happening, the soft IH ring
> can fill up really quickly and possibly overflow. PAGE_SIZE was
> too small, use IH_SW_RING_SIZE to match what other GPU generations
> are doing.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/ih_v6_1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> index 9dbc20131410..f6fdb3a950e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> @@ -590,7 +590,7 @@ static int ih_v6_1_sw_init(struct amdgpu_ip_block *ip_block)
>  	/* initialize ih control register offset */
>  	ih_v6_1_init_register_offset(adev);
>  
> -	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
> +	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
>  	if (r)
>  		return r;
>  


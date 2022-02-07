Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9503EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 07:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C73010F2B3;
	Mon,  7 Feb 2022 07:40:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD2C910F2B3
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 07:40:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RL+MPnWVNip2ob/K83HjQDLilbFs9c/nn+YMSjYtSPFfDF+YYGqfOx2XvDofUSRbKjHS7fIcIdkim1E7qyXzLJP8JOVwwApnIaV9lt2aTM1N1uNb6hAMe1cFd+2sUvR+pSjDJYIbLxHXWUoFDgsgFt7svwzCdAqYbxqNQIGCtRDoes51IwSUnayXwSgTPZVqtzj3nmUFHUhtFl1F5ZmcILEBGySRSRBi4Wkpqc4YfTt1MxuczE+4PfQN164AvDpoFfoAQLs2tjFZJqrA4+6eAYITxxSZ//29XCitrjuSlgR7sANlMeuf8Ei5kMDyY+iG7ZG8eZ8o1l+kjO1WzeBFdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dh0ALR7JoVWmc/RkQVLiVx+WnaXIsrJl0NXy/I/Xelc=;
 b=mHaB+AMefat68sqZsxSU9q62c4Jz3uARNbjHKJJ5hNl6D48bTY8Bh0+T5wglyRVE38XpkG+lMzvQtPCJMosr5cs8IgrrqTDNKcOtR8g3QPBfKDEmaOJPK6QxHNqygFk25ZAyTCaaq5maP3QmkX/LdQYrXRMUW5sZRln6BhVLhd+rgBC6/a1YszGaYnL7KM9S/Hdb+WUqKT9Pb7XWfySlWXrhUHJqrWnxuh3ZT+sjFrCibGjNb1zW1qgVGNGcMJQeD3t82VZlum4bECD3hwhe5jmudnUvjIW5ZdJh9PtX2iPKJDo1W1RQeBpcD6V3XP1oACuRZgs8sPzMSLYaiKo1qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh0ALR7JoVWmc/RkQVLiVx+WnaXIsrJl0NXy/I/Xelc=;
 b=FpgENqghNv1iwUdiklWazZSr1AgiG1W2DwKdS6DqDycbIOKr5Qnf4dtACG1ZgSRW5Y2sShYYhE4CRNmM3PwLJQzYr5WboP3TgY/hiZiPs+1qICnjZEcNJoSfYeAqnYcxtfdnknIp6uP3FA0mWKOiq7zJhGeHqpHtX0JY5UhUeUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MN2PR12MB3696.namprd12.prod.outlook.com (2603:10b6:208:169::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 07:40:46 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d861:5699:8188:7bd3%3]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 07:40:46 +0000
Message-ID: <3619e7f8-d3f4-d3df-b921-0bb78e52be1c@amd.com>
Date: Mon, 7 Feb 2022 08:40:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: check the GART table before invalidating
 TLB
Content-Language: en-US
To: Huang Rui <ray.huang@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>
References: <20220207024155.414712-1-aaron.liu@amd.com>
 <20220207024155.414712-2-aaron.liu@amd.com> <YgC8d4ld4aaAyuZl@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <YgC8d4ld4aaAyuZl@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P193CA0056.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::33) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6269d345-77c8-45d1-8186-08d9ea0d2710
X-MS-TrafficTypeDiagnostic: MN2PR12MB3696:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3696E53E6A0301543A9C3E36832C9@MN2PR12MB3696.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/yUcPZeqQof+VQPe7yhV8UsWJw9zB7bq3BnlDB7sff2YoQAFEMnX48qMiei/1QQwLsyQB3yhDbMHcGkoLIs9zb8wXw1EEx2EOkeiJwKv4rhEYLYOE+mQtVSXpIfi3POpiA+RvWW4+tlTFNmP33PassNUKiQR21LDA1h0CzeC4EFD7ffX2H2aAcRGQosYkmXLi2Laor4OkgoRp/6NLqKJm74wjGHw4hFuFcHdYot8gMRB10tBBN7kVp4uXOfKzYruLJyECJpNP5BT6ibIXCDpgFI34L3YRCq/SPa4L6q+m1tmfpHMksQsh7LyBJY91LOsUwdJnZ4nkBg58dZdmkpi/dLMvqQS7cvdsHbrmF0tj3wIeElPplGbddfNB7f+S3bxXpmyv/VUfBkJSxXOd2zKzmD1Xbp7TMuZyi2o+Eu/iAWyBFLJqBwgDW68Usba+u+PAKnG3D3PENGFv/6Akupf5QT6guOqIAt3yY+ZDio1ByqkrdrccQI6mrdDO0VirlIqs1mjyfyKqBAeT1vxu6lixTQ+X/wmwMi8jxR22gRfyphFntUlFo84FAm6Q8mR2S+pxnQaXkuxhoCwYPEWwqgK0zSt6D/JYY//+MBQjNdx5WGBO4USOrczXEdJVv5YHwml/SWeXIYFnUZhR0YNPARsy05Y5aws7lo3SujgTQuIKlFaqctE3K7R+f5KCo7h+qcqXWFJdTyZKIjTRqLAKHoi8OXc0TcTMsK53Vh1Ar0NDo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(2906002)(110136005)(6636002)(316002)(186003)(54906003)(508600001)(38100700002)(2616005)(5660300002)(6512007)(4326008)(6506007)(8676002)(66556008)(66476007)(6666004)(31696002)(8936002)(66946007)(31686004)(6486002)(36756003)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STkzTndBUUtyOUtUczN0U1RKNEw4QmkzWklpM1dUYVlVc0VVZUs3RHNXQ0N5?=
 =?utf-8?B?SWRrK1A4ZjY4VU1sWGEyZW9XSjZuUDJNaUVnTzFXVVhZOTBlTWFTb3JNNVN1?=
 =?utf-8?B?ekdEWXhKYzhOclBBUUF2WE1lVmZYUGJjUW5ScU1icDhlUFJqVStGcXNSVXM2?=
 =?utf-8?B?MWVZcnkrWk1rREJMZGpSSEY4NWtHbVI4TjM0bExUSmhoM0NwV2Z2NFFBTVBU?=
 =?utf-8?B?U0NSZEhPUzFEWnk0VXM4UnlWYXp1VFB3YWZRNHpabElBbllab294c25DL3Vr?=
 =?utf-8?B?dkZuV3VqSmwyM2xBOUYxYUdpYlNwL05RQ1pGT3RiZG5OV1lRdVpJbmlmdHA1?=
 =?utf-8?B?dWpRZ2dpbzNPUGtnTnppWWFIakZod0Zqai9aU2Y3bU43cEhUQ2dnRFNmeFZN?=
 =?utf-8?B?VzlHaWpGaUN6NXk4WnBtT2UzOS9nUXY1ajVkSTJ6bFJnNTJnWlhqWHhRblpN?=
 =?utf-8?B?ZUtQU0krK0cxMVR3d1VUSzhvRHFta0NlSGZLSTdDQUJBYnVlaDFpZnlyMy9T?=
 =?utf-8?B?QU5XSW5TS3VGTlczeTU2WmZKUWJrSDl3YTEzNHZvQkVDaUdpSVc4MGMvSTJr?=
 =?utf-8?B?V0hJOWpLZzVXWkpseStQd2V1T0NVOXJEQzA1S0cvcFhRT2RQSzdJYm5vV21v?=
 =?utf-8?B?WENmSGQxREtUWDNteTh3Y0F2QzVXOFhHVmtWVzl4bmFKM2hnRkxxN2x3Ty93?=
 =?utf-8?B?K2ZWV0p3aEZEd293VjVDMUQ4OS9EN1Fjc2dOKzJncjBwWDhwQWZpWll4STVr?=
 =?utf-8?B?dzd3VGVwYTIzM25nQW9oQ29uWWhUUHVMa3hCOUQ2SFlzbThsYWt4N0s5R3Vj?=
 =?utf-8?B?TlNuMDNvTGxjRFJVWGlwSzNWSVFvVE1maUdnSEtBUjA1YWFYbmcza1pyekds?=
 =?utf-8?B?TkM3aWhjeGdUdkFlZVZTZFFVajJrVUdDRGxERURWTFVoYjdOOWw4NXNTUDEx?=
 =?utf-8?B?ak1xc1ViQllBTDl6S1dscXFIbDBhaElhQ08zMG5wL3o4R0xwam4xaHJBNEMv?=
 =?utf-8?B?OUpnSmhGczhKQnAwV1lITDVCdy8waXJuYlc1UlBEVlo5aXNXKys4K2hEZXE5?=
 =?utf-8?B?dUZGMVc3dUR5WkxWbGlTUTYyWUtyU25yNDAyV2svSVlDYXExTW5QKzdLK3JL?=
 =?utf-8?B?V0NsUXcxSnpxdXlRSStZNnovKzVIY3NvZUROeTFISUtYbjl4eXlxUlUxUlV1?=
 =?utf-8?B?U0ZDV0hSZnlpK29TRi9uYS9jRWQwcHVWQXpxNU4zNVdYZnhacjBrbGhZTkZF?=
 =?utf-8?B?TnNsa0tYbDR5S29zcTJIZDhJbXlCSHdaSVJwb3hLcUtRQmw0aHlKRVV1cnFl?=
 =?utf-8?B?dnFJTCsvTHhyT1U5LzVWRXZ5VkJHQ0RIdkxYcm9PZjFYZnlITjRzT21ZYkNz?=
 =?utf-8?B?WHVucU1USDV6cGsvTHByUE5RdDIyS29jSmZEVG1HdkJNTkZsMlhtcTdCN0J2?=
 =?utf-8?B?ZmtIS3BKOWdaak81T0d2NDN6NzFNTmIzbHNDbC90SlRUdkhmNFl5NEIyZjF6?=
 =?utf-8?B?SGNWeFR5bEx0NzUvaGpFUkNHVFBYSDhMTXVNMjJhNVJHd2h3Q0JvekFVVlpw?=
 =?utf-8?B?S21sRDcxVkpIMUtudDRDZTRiRk9tdWx4NHRvZElUSENaQ001THJ1VlpBSXVT?=
 =?utf-8?B?Nk5HRTlyaWxIaXlOem00VTkzdWdrQUJRcTd6aGFyVWhaVEU5YkVjd1UxcGhM?=
 =?utf-8?B?OVlIbTFzZkRxR1JPZFdNTnhsdEUveWVpWHA1VjZGQ1JjdENyWHZialV1ZHc3?=
 =?utf-8?B?eTVya3lJbHhuRHhQTWFnTGVtM0wxRnNxajhvUkdSNGliRGMzMDRCOFgxbEM2?=
 =?utf-8?B?Tkt0dHBySEV1NW93eXZqK0VMZjAzQ3cxdmk5V1R2TVdaMzNKd1dQSWpiWkpn?=
 =?utf-8?B?TUVjeXdXdm05dVBIa290eXc3djR5ZXdZWHFVWkhBSklaSklIOGZWR0g2STRl?=
 =?utf-8?B?aTRLeStMdEswYVRadlRIWndlcXJVVC9UT0t6TDNNMlJ3VVRzeTRKRE0yMTB0?=
 =?utf-8?B?NGRBcXlLdmt1cTg3Mi8zQm5xb3BPWUE0K09kRXRsWlNEZlExTkZWa1FXTkVM?=
 =?utf-8?B?eS92ZkhXMzJVaXoyTGlzcmx2WElveUtYWmpVSGk5Y2FpMGl1SHFYaTNQbTZq?=
 =?utf-8?B?TVpFQU9tNThwWW9nTjd6N3ZPTWdEUmVmc2pBUThGeDRxOFRuU2NqK25kVGlj?=
 =?utf-8?Q?m1BmDucy+ZM2W3caUGNGpbc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6269d345-77c8-45d1-8186-08d9ea0d2710
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 07:40:46.5503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lxPQLhPbGbFSqXyq1oo/DhSRNftPj3XJAMXN3eNM6Vycb3xuuERfLFBuhPbuyIg4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3696
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 07.02.22 um 07:30 schrieb Huang Rui:
> On Mon, Feb 07, 2022 at 10:41:55AM +0800, Liu, Aaron wrote:
>> Bypass group programming (utcl2_harvest) aims to forbid UTCL2 to send
>> invalidation command to harvested SE/SA. Once invalidation command comes
>> into harvested SE/SA, SE/SA has no response and system hang.
>>
>> This patch is to add checking if the GART table is already allocated before
>> invalidating TLB. The new procedure is as following:
>> 1. Calling amdgpu_gtt_mgr_init() in amdgpu_ttm_init(). After this step GTT
>>     BOs can be allocated, but GART mappings are still ignored.
>> 2. Calling amdgpu_gart_table_vram_alloc() from the GMC code. This allocates
>>     the GART backing store.
>> 3. Initializing the hardware, and programming the backing store into VMID0
>>     for all VMHUBs.
>> 4. Calling amdgpu_gtt_mgr_recover() to make sure the table is updated with
>>     the GTT allocations done before it was allocated.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Aaron Liu <aaron.liu@amd.com>
> Acked-by: Huang Rui <ray.huang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> index 91d8207336c1..01cb89ffbd56 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
>> @@ -259,6 +259,9 @@ void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev)
>>   {
>>   	int i;
>>   
>> +	if (!adev->gart.ptr)
>> +		return;
>> +
>>   	mb();
>>   	amdgpu_device_flush_hdp(adev, NULL);
>>   	for (i = 0; i < adev->num_vmhubs; i++)
>> -- 
>> 2.25.1
>>


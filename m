Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3884C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 09:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 974D910E928;
	Thu,  6 Mar 2025 09:57:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rPBW6I7M";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4811310E92E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 09:57:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHvEFjRhko5txCJbgfWoda6U51piqmuUjGAAHckOHmxPNlb58BeqGuS4i7hWVTOPq/eHM+17sZsO3vtGNUzUK+syGf5HO0Buzf9+sWn386CUhL2yHQLIQiFxHqABKIZoKwoyqDTrgO+PaHZEcl+tjASfghCyvugUnOXBmgieeTFeeDVgd8GKBHekCRjubqP8iNZZ+wTlloPXx5t18xtRR9HT04xxu1iTaOb8/FbKYdYawY5xnW43jAq1kFqzSwVJmscp0QcIcBfVi6ZsRA9TcItZpIEnahUnUukhpa4qK1K3fp+Ibodo0ihlf2+8/XLOj+42B1a+TcS7i7TiHvoT1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRMFncehSe8WCfVuTNVFS3glrk7YRzEFApMjXHLGzQQ=;
 b=u7JkaAgLss3KDg7er67gkldAloITl4lXpBf5wEBhamd/PZsVhwYMhn6Iw6y/ix48hDEPnSAaqr1OD/lAJp/sNY4tcEvnWF/lCKXhKNSN4GaCdA5sUpuMkhdhAVcFQaZSpa4umapQ6ame+NKJOnmThWjKLXDEFiIbMIh6ICMyZWmqnihUIc66X67+QhKs/8KWwRPWZ9shE7STkjoAetVbfVsTH8iwrKAmF+g0X7kmPxJqH11TC5/kAzbGNY9/r9QmcF0AaW5D4P6q8GKr7IOf91y+tooG49YPzLBPedq3EBHCBzGaehp/B1UbfKvGxUNWlNI8xsScwtYbXreUT9/Xhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRMFncehSe8WCfVuTNVFS3glrk7YRzEFApMjXHLGzQQ=;
 b=rPBW6I7MM+k/bfkP1DII6HoKA+Kwzfz2u28UTys2eaUu6TP6ykGvP2Xag/QZN6oDKeJ8riUSX7s2yvfGKfv7L6+YIjAIMVC+9kDbycOenQLwwKCIw9CkfSwog7ToP6b+b/OCpDDWuYPgXo+YPR02//0ywO0ADN27n5RtxUauZ5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 09:57:38 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%7]) with mapi id 15.20.8489.028; Thu, 6 Mar 2025
 09:57:38 +0000
Message-ID: <8a2b375e-c907-421b-84ac-46b85f2ccf33@amd.com>
Date: Thu, 6 Mar 2025 15:27:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] drm/amdgpu/gfx: add generic handling for disable_kq
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20250305204721.1213836-1-alexander.deucher@amd.com>
 <20250305204721.1213836-4-alexander.deucher@amd.com>
 <eb414965-542c-4264-8524-087fe52bddef@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <eb414965-542c-4264-8524-087fe52bddef@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::13) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: a7579a6f-bdf9-47e2-780c-08dd5c9553b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEk1SUVpRHk1a2VSZ2EzOVFtZGx6cHNhM2gzNDZqR3UyVElyTXR1Tlh5VnVo?=
 =?utf-8?B?ZlAwOXB2ZlNwT3h3M0Z1SnZWQVUycXlxRXIzNlJPSVV5bG5yRVl4cHlwdnZH?=
 =?utf-8?B?dEJBY2lSdFBjdWtabzhHeUVDNUJqL3lEZFNIQW15SVpyN3BNckJpZXVuRkZj?=
 =?utf-8?B?SnNYdnhiT0pXVXFoQmsrSmdKSkZ0a09CZWpQWFA1cWNBRDFvaHU0TWxUb3ky?=
 =?utf-8?B?VnArM3RMRUlBQ1N2UDdmSktudHFSQjFycDVuUng4cWc3QXM5NEFZaWVtTDV5?=
 =?utf-8?B?WFd2bjVidmdzWTlodzludUIvcjFTRkwydDFKamRFQ09YTzVpSUVJQ1VmK2hN?=
 =?utf-8?B?VjBlMmI0WjJSZ2JiZ2pOamx4MVcrN2VMbGErb29CalBOY2hhSGRaeHQ1NXU0?=
 =?utf-8?B?cTRJeWl4OERuVWdNQVlPNERXenpubTJOVlFHUU9mRjU0K1BDNkJRb3R0QVJL?=
 =?utf-8?B?emlabWVmcXMvT0NDRG9RaWFWRTBXUlJKc2h0WHY2Nkt2elZWaUJxRXlSTmlQ?=
 =?utf-8?B?TndITVdxbUNhdFFJSDIvanc1Y1d6MlZtM2VqMUc0MGZkTmNXOGtSempmMFhD?=
 =?utf-8?B?KzlHMllDZE9ub0xwZzdXZEg4VXJiMGdDUm0zendab29KWWdOdVUrL082bzJZ?=
 =?utf-8?B?c0JiYllIWVhyOXFmbnIydVZnZ2dhKzVZMHNJSUxObEM4YmJDZkxLdURMY1Ur?=
 =?utf-8?B?b0Z6SU85aEdjZTBReTNHMzhQS1prUUZZME96V3NwTFBVVHN5S3R6NjhjVHJM?=
 =?utf-8?B?Nk04eVBlQ2FYWVU1SExDK1hvNXpTb29YRU1GWjBBRGI1V0xZcjlTZVR5OHZh?=
 =?utf-8?B?d3BhUjk2OXliWVQxc2tJWWxkRFp1Z3FHNmVtV0l6dmFZS0U2TTdKUUZZa0VL?=
 =?utf-8?B?cERNNTQzK082Qkp1NGRFQ0JEMUhnVDBXYXI0WDE1SWRVdXhiSTdYQ2hzZUxV?=
 =?utf-8?B?SG5tVTQ3aURQaUFSOSt2emQyV0x0RCt3YWtCRUtEa2ZPUjB0OWpGVXI2UG5Y?=
 =?utf-8?B?QktCVXZFZzlIY09kaEdCS2hDczZZWXRTR2JmU1hkZlg0amVCL2xGWXhPTG5W?=
 =?utf-8?B?Q1lqWmliL2hSMkZnSXJZWWtUalU1NjZFMDllRU10YlBLUVhXZEMrZm5xdENq?=
 =?utf-8?B?RTIwRzB2cmFOY29lRW53UWJFL2lheUJWWi9KSjJPWHJwNzlZV2tiUlYxSWFw?=
 =?utf-8?B?ZmpUcW94OW12SFV6YUxMNDhodlExN2lOeisybW96bWxaaTJhdkZWZlJNTmNF?=
 =?utf-8?B?Slcydm0yR1pzNWttYmNvcDl1Ykpadm5HQVNoRmNldDUzY2lEemdZSllaT1BK?=
 =?utf-8?B?aG4xWUtXOFg3alp4cjJmY1RXYlJXTTV1aFpHSG04VmN1QVh6Z3VZbUMxYXpR?=
 =?utf-8?B?RDdTbnlIcmdpSFRpL0RBSjFEZUE0T0pHQ0RFWWxUdHFJdWZSanY1ejdkc2Vo?=
 =?utf-8?B?bTExUGJ6a3F4SGMyK08ydnZDVnpob0UwZGt1SjlGeEYzMnl1UVluL0pTTWZ1?=
 =?utf-8?B?bkpRQWEydXNVLzJ5N24reTNFbjFyWVd4dFV1Z0gwVnlZK0tacHZSRXZhVGVj?=
 =?utf-8?B?ZVhMODdzRTBiYThtVkxTRWExaDdEekM4K2lkcnFtZnNJY0pqaWg5VzJHMk5a?=
 =?utf-8?B?VjdIVndhNXluWDd0eUpDUGtRcWxUU2phYlhDdTIyMnNkWG8vMUpHTjhLUUp5?=
 =?utf-8?B?ZC83bFdHUXM0US9PNTRHRTczSnBFaHBZeXNDMkVTU29xcG1OUHF1ZnQ3NytH?=
 =?utf-8?B?aTVkR3lFQ2g1cXlwK3g2UW9OOUdRSjBCcXBRMlZsTWF1RURCa1Y4Z0hLSW9P?=
 =?utf-8?B?dFJmRmppOHd3MytTUk1nWkVFMmRZRmJ5NytSS1cvTDR3QXRyOU5xUm5Fa3Br?=
 =?utf-8?Q?q3fzfmyYwO30j?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGdHUVhCMy9vblZiZThhL0JMbjdPTzc0ZHJEcDBkbWtoSE5YeGZlZ2tjelIv?=
 =?utf-8?B?bGRqbHA2cTRoSzEyZ3ZPRTlldkYzakZkQndDT0Z3cDNUS3p1ZGZTenkvUWFD?=
 =?utf-8?B?N1RqUzgrWnJLNS9zVUVTdXlZSVRRZzVsb2h2NWEzZHpnQ0Z3WmNxRFFYN1k0?=
 =?utf-8?B?VWNkV2RBbzI0cUh3MnZvSzVkeEtsNU0yODdKSUp1WHJ3ekhoOEVrczM2OVk3?=
 =?utf-8?B?ZXBkNmZjMHlSODZCV3ZvdUp1ZFhIUTZFNXo1cWYwMnJnMFNaaTZZRlpIYTlr?=
 =?utf-8?B?SXVhUE9kNUtZSHdMMUdSaUNvQlp6SE5wREF3dDRkaFJ2YUtCOEUwV0JXRVVj?=
 =?utf-8?B?dnU0YXpIbnFDOW1oVnVOS1FobXdnZHpIbEViYnpaQzBPVGRWTUV2QU5JOWNJ?=
 =?utf-8?B?VFJSaEtmeVBZc1F2TEZLVTNGSzllVVZFTVlsTStuK2wxcm0yWVNqbS9SSEg0?=
 =?utf-8?B?Y3JhS1IxRzRKTS9od1hjMnNTT3pmcDlTQnI0MjBObGdBUFFOTW1lcXNYL3BM?=
 =?utf-8?B?a2FXNUdpVHlZcjI0WWpKY0dVbUlzbzEza2tGT3RCQkFzNHUyYVErcHEwMGtk?=
 =?utf-8?B?cXY5bnQ0ejlydmd4OUcvcnIyaTloZkZlb044MWNGV05iMi9hMkRjOENPUzdF?=
 =?utf-8?B?VHU4Qi9pc3d0U2h1MFY4cjBuRUhVaGIxaUJJM1pkUFBFYVRkTHFHcFhJaktQ?=
 =?utf-8?B?cDlXYWViZjljZHAyQm91cHN2T3IzVm9RU1RyQm4rMFE3N2lrRkxMT2gwcUg5?=
 =?utf-8?B?bGhjdG1PbmJ2Z0xMOFl6bzFVSkVMdUg2TUIzcEJ0a0tLcWhVSGZsUm5VcU8r?=
 =?utf-8?B?Um5zM1FiV1N2aTEyREJCUEZqWDlVQVFaeXdpOUk2S1ZOK0gwNER2UUNwVnp3?=
 =?utf-8?B?a0VhVjlpMFNLdzJCYjNPOS9uTEkwN0EraUFob2ovelpjUituenV5V3dqR2lU?=
 =?utf-8?B?TVBXWUI2dlNXdlpsbWZoay9NaXM5YTdpeW9ZeTVXVUFhb0RHaExvMFYwanEy?=
 =?utf-8?B?M3JEN2JDSWN2QUhtTU5DVk5sK1pXQ0hNZSs1OXc5elVLa21jeGIrVmRjV2pn?=
 =?utf-8?B?ekxscnZBRU80czlyKzBJaDkvQTZ1S3Q3ekFydy83YUxNdUVtcnY1aklVZ3Fq?=
 =?utf-8?B?eDdaek5EQ1poZU0rTi9aZ3h4RllRQTkzK0N5TE5MOWdlRGtzTWx3MjJWSWhH?=
 =?utf-8?B?WVRhKzlINHFpWTR2WnZ4c0dDVVU3REhOMUxKQTgxTXhUY0dPYTFuRnVhd29u?=
 =?utf-8?B?c1FNS1NlYUt0MzNxZGhkY3F5NjJ3eVdybCtZQ0dQdXQ4aGFxa1RVSThjMllj?=
 =?utf-8?B?Q2g2ZUdQV3QrUjViUEk1MnhuYlVqVVQ0U0QvbUdrYW5KWjNrQzFySE0xVnl1?=
 =?utf-8?B?WXNkQ3hmaGJrWVBXTmxBeFBIYmNyNlhhYVJaWElVZzJ0MmZmaGVkM1JrY1o5?=
 =?utf-8?B?UWZzbndvTmxZeVl1MFlCdU9TSktiNVU3N3NlTEoyUG01N3h0enpFZ0xLKzZp?=
 =?utf-8?B?R1hVcHhuaGd3OU1ZNEFaZTNmWGd3MmtCazdmVXhhWkpXTEh3eDBtdDN2QVRt?=
 =?utf-8?B?UkdJSmZ5YUZTd3hQcnBLNFA4M3ZIZ3hKVmNiUnpUd0E2R2ZOajcvc2dQVGs1?=
 =?utf-8?B?cFhZUVBtSUhVZzR0ZlVIZlFiaUd3cktmMjk0bWxzMDlML1BnVEc1eWJrS0tT?=
 =?utf-8?B?VWg4R2o5OUY3SXFxakFEN1V6L1VyTEtPT04vR2VhVW9HQ0R6NmJhZlk1YzBF?=
 =?utf-8?B?RUVXbmNUT0g5aHVrQ1VXSC81MXl4cDRuQ1dGVXZINXVzT0t6SEc2VjBzUkZ6?=
 =?utf-8?B?c2NTQWV3djZNRGx5WGlOMnJwbWlZeG1zdS8xdUhKVkp1ZVlQenYwRSttNitV?=
 =?utf-8?B?dFp0QTc4RVJpOFgrUzlrd1NLYmRRMkxXT3VtbXNJMDBCSnErcWZzTmNxT1VZ?=
 =?utf-8?B?VWV3dWVQQ1YrRXRwM3UybnVEeGNzTjhwVUVxTVVXSVkwY2lvZDd6QzNTSnM1?=
 =?utf-8?B?ZjRnMld3V0h3dDlTRHhDbVBNNmdjWEJSNnhFNkI4cm10TEVqUHQyeEpFbTNE?=
 =?utf-8?B?TXNnZXdhUGVmV3Mra0ZYZWJrN3RQbmtiRW1lTVlJRzRwR0J3TWQzdWRFYlJQ?=
 =?utf-8?Q?jTIWYXY/1NXEiwBEr06/OV15/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7579a6f-bdf9-47e2-780c-08dd5c9553b7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 09:57:38.4062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LLT5wWuYzoJA+cLb+RmSYKrIXhmjvIJA4f3D0JF8H99OMoy1rxIaBvZJ2gou5XeXK6N4t6HUQVD9Gfv+VQN5pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
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


On 3/6/2025 6:36 AM, Felix Kuehling wrote:
>
> On 2025-03-05 15:47, Alex Deucher wrote:
>> Add proper checks for disable_kq functionality in
>> gfx helper functions.  Add special logic for families
>> that require the clear state setup.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 92 +++++++++++++++++--------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  2 +
>>   2 files changed, 67 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> index a194bf3347cbc..af3f8b62f6fd5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>> @@ -371,6 +371,18 @@ int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
>>       return 0;
>>   }
>>   +static bool amdgpu_gfx_disable_gfx_kq(struct amdgpu_device *adev)
>> +{
>> +    if (adev->gfx.disable_kq) {
>> +        /* GFX11 needs the GFX ring for clear buffer */
>> +        if (amdgpu_ip_version(adev, GC_HWIP, 0) <= IP_VERSION(12, 0, 
>> 0))

Yes the check has to be  < as gfx12 do not need the clear buffer based 
on our discussions.

Regards
Sunil

>
> Should this be < instead of <=?

>
> Regards,
>   Felix
>
>> +            return false;
>> +        else
>> +            return true;
>> +    }
>> +    return false;
>> +}
>> +
>>   /* create MQD for each compute/gfx queue */
>>   int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
>>                  unsigned int mqd_size, int xcc_id)
>> @@ -379,6 +391,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device 
>> *adev,
>>       struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
>>       struct amdgpu_ring *ring = &kiq->ring;
>>       u32 domain = AMDGPU_GEM_DOMAIN_GTT;
>> +    bool disable_kq_gfx = amdgpu_gfx_disable_gfx_kq(adev);

name of variable and function could be in sync. disable_gfx_kq and 
amdgpu_gfx_disable_gfx_kq or change function name according to variable.

Also another suggestion here is better to have one more variable in the 
gfx struct or ring and read this amdgpu_gfx_disable_gfx_kq once and use 
it in all the places. It does looks confusing
so many similar sounding names.

Regards
Sunil
>>     #if !defined(CONFIG_ARM) && !defined(CONFIG_ARM64)
>>       /* Only enable on gfx10 and 11 for now to avoid changing 
>> behavior on older chips */
>> @@ -413,7 +426,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device 
>> *adev,
>>           }
>>       }
>>   -    if (adev->asic_type >= CHIP_NAVI10 && amdgpu_async_gfx_ring) {
>> +    if (adev->asic_type >= CHIP_NAVI10 && amdgpu_async_gfx_ring &&
>> +        !disable_kq_gfx) {
>>           /* create MQD for each KGQ */
>>           for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
>>               ring = &adev->gfx.gfx_ring[i];
>> @@ -437,25 +451,28 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device 
>> *adev,
>>           }
>>       }
>>   -    /* create MQD for each KCQ */
>> -    for (i = 0; i < adev->gfx.num_compute_rings; i++) {
>> -        j = i + xcc_id * adev->gfx.num_compute_rings;
>> -        ring = &adev->gfx.compute_ring[j];
>> -        if (!ring->mqd_obj) {
>> -            r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
>> -                            domain, &ring->mqd_obj,
>> -                            &ring->mqd_gpu_addr, &ring->mqd_ptr);
>> -            if (r) {
>> -                dev_warn(adev->dev, "failed to create ring mqd bo 
>> (%d)", r);
>> -                return r;
>> -            }
>> +    if (!adev->gfx.disable_kq) {
>
> Maybe just set adev->gfx.num_compute_rings to 0 somewhere, then you 
> don't need this condition.
>
>
>> +        /* create MQD for each KCQ */
>> +        for (i = 0; i < adev->gfx.num_compute_rings; i++) {
>> +            j = i + xcc_id * adev->gfx.num_compute_rings;
>> +            ring = &adev->gfx.compute_ring[j];
>> +            if (!ring->mqd_obj) {
>> +                r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
>> +                                domain, &ring->mqd_obj,
>> +                                &ring->mqd_gpu_addr, &ring->mqd_ptr);
>> +                if (r) {
>> +                    dev_warn(adev->dev, "failed to create ring mqd 
>> bo (%d)", r);
>> +                    return r;
>> +                }
>>   -            ring->mqd_size = mqd_size;
>> -            /* prepare MQD backup */
>> -            adev->gfx.mec.mqd_backup[j] = kzalloc(mqd_size, 
>> GFP_KERNEL);
>> -            if (!adev->gfx.mec.mqd_backup[j]) {
>> -                dev_warn(adev->dev, "no memory to create MQD backup 
>> for ring %s\n", ring->name);
>> -                return -ENOMEM;
>> +                ring->mqd_size = mqd_size;
>> +                /* prepare MQD backup */
>> +                adev->gfx.mec.mqd_backup[j] = kzalloc(mqd_size, 
>> GFP_KERNEL);
>> +                if (!adev->gfx.mec.mqd_backup[j]) {
>> +                    dev_warn(adev->dev, "no memory to create MQD 
>> backup for ring %s\n",
>> +                         ring->name);
>> +                    return -ENOMEM;
>> +                }
>>               }
>>           }
>>       }
>> @@ -468,8 +485,10 @@ void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device 
>> *adev, int xcc_id)
>>       struct amdgpu_ring *ring = NULL;
>>       int i, j;
>>       struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
>> +    bool disable_kq_gfx = amdgpu_gfx_disable_gfx_kq(adev);
>>   -    if (adev->asic_type >= CHIP_NAVI10 && amdgpu_async_gfx_ring) {
>> +    if (adev->asic_type >= CHIP_NAVI10 && amdgpu_async_gfx_ring &&
>> +        !disable_kq_gfx) {
>>           for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
>>               ring = &adev->gfx.gfx_ring[i];
>>               kfree(adev->gfx.me.mqd_backup[i]);
>> @@ -479,13 +498,15 @@ void amdgpu_gfx_mqd_sw_fini(struct 
>> amdgpu_device *adev, int xcc_id)
>>           }
>>       }
>>   -    for (i = 0; i < adev->gfx.num_compute_rings; i++) {
>> -        j = i + xcc_id * adev->gfx.num_compute_rings;
>> -        ring = &adev->gfx.compute_ring[j];
>> -        kfree(adev->gfx.mec.mqd_backup[j]);
>> -        amdgpu_bo_free_kernel(&ring->mqd_obj,
>> -                      &ring->mqd_gpu_addr,
>> -                      &ring->mqd_ptr);
>> +    if (!adev->gfx.disable_kq) {
>
> Same as above.
>
>
>> +        for (i = 0; i < adev->gfx.num_compute_rings; i++) {
>> +            j = i + xcc_id * adev->gfx.num_compute_rings;
>> +            ring = &adev->gfx.compute_ring[j];
>> +            kfree(adev->gfx.mec.mqd_backup[j]);
>> +            amdgpu_bo_free_kernel(&ring->mqd_obj,
>> +                          &ring->mqd_gpu_addr,
>> +                          &ring->mqd_ptr);
>> +        }
>>       }
>>         ring = &kiq->ring;
>> @@ -502,6 +523,9 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device 
>> *adev, int xcc_id)
>>       int i, r = 0;
>>       int j;
>>   +    if (adev->gfx.disable_kq)
>
> Same as above.
>
>
>> +        return 0;
>> +
>>       if (adev->enable_mes) {
>>           for (i = 0; i < adev->gfx.num_compute_rings; i++) {
>>               j = i + xcc_id * adev->gfx.num_compute_rings;
>> @@ -547,11 +571,15 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device 
>> *adev, int xcc_id)
>>     int amdgpu_gfx_disable_kgq(struct amdgpu_device *adev, int xcc_id)
>>   {
>> +    bool disable_kq_gfx = amdgpu_gfx_disable_gfx_kq(adev);
>>       struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
>>       struct amdgpu_ring *kiq_ring = &kiq->ring;
>>       int i, r = 0;
>>       int j;
>>   +    if (disable_kq_gfx)
>> +        return 0;
> Maybe just set adev->gfx.num_gfx_rings to 0 somewhere, then you don't 
> need this condition.
>
> Regards,
>   Felix
>
>
>> +
>>       if (adev->enable_mes) {
>>           if (amdgpu_gfx_is_master_xcc(adev, xcc_id)) {
>>               for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
>> @@ -657,6 +685,9 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device 
>> *adev, int xcc_id)
>>       uint64_t queue_mask = 0;
>>       int r, i, j;
>>   +    if (adev->gfx.disable_kq)
>> +        return 0;
>> +
>>       if (adev->mes.enable_legacy_queue_map)
>>           return amdgpu_gfx_mes_enable_kcq(adev, xcc_id);
>>   @@ -716,10 +747,14 @@ int amdgpu_gfx_enable_kcq(struct 
>> amdgpu_device *adev, int xcc_id)
>>     int amdgpu_gfx_enable_kgq(struct amdgpu_device *adev, int xcc_id)
>>   {
>> +    bool disable_kq_gfx = amdgpu_gfx_disable_gfx_kq(adev);
>>       struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
>>       struct amdgpu_ring *kiq_ring = &kiq->ring;
>>       int r, i, j;
>>   +    if (disable_kq_gfx)
>> +        return 0;
>> +
>>       if (!kiq->pmf || !kiq->pmf->kiq_map_queues)
>>           return -EINVAL;
>>   @@ -1544,6 +1579,9 @@ static ssize_t 
>> amdgpu_gfx_set_run_cleaner_shader(struct device *dev,
>>       if (adev->in_suspend && !adev->in_runpm)
>>           return -EPERM;
>>   +    if (adev->gfx.disable_kq)
>> +        return -ENOTSUPP;
>> +
>>       ret = kstrtol(buf, 0, &value);
>>         if (ret)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> index ddf4533614bac..8fa68a4ac34f1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
>> @@ -483,6 +483,8 @@ struct amdgpu_gfx {
>>         atomic_t            total_submission_cnt;
>>       struct delayed_work        idle_work;
>> +
>> +    bool                disable_kq;
>>   };
>>     struct amdgpu_gfx_ras_reg_entry {

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B744CD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 13:10:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3054810E45F;
	Tue, 19 May 2026 13:10:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gZs7dlSp";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011064.outbound.protection.outlook.com
 [40.93.194.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DD6310E45F
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 13:10:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hwk2sqM7UaoPcw7KtqaqlGwfOmmC5VnAMvb2wNWctQfzCfBViqzeIJEp2A/EV7xXgg2q7+UIB7TVhj2kqa7wSBesBPNeMTTK13A5FH9yeI3N+BwcywCdI8DSdseDkcOhOjBLDT/wL6f46OjwVKgTwCwqi/N1vHQyFRd1DdQ7tPJVRf+5psfr3VEcspvl/snVurFYpuV3eChogip8wvLOVYzKNiUp2adNlQySucS42NZE727zXyezunnsYrKqfCtHoLYPn7U/8c1B5y7J7xQFiFR+Ip9+S+V/dxzA7NvBH9szigs96U/ruNOt4j77EMG6zMiG8QEoSUNyFOjn3UkbMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eZI5S+Lf7VYEbLMisakzQkU8CIE/SNyut3lA6/nzb8=;
 b=iKKKcMDUFyF7s3BSL8hDpLI8eeiKHpNa+V1M+pZgEEva6s4lPqDM7KKBYSGFEkooHqG6Hm0R1qLJCrEGstgwsliZdfJooZUWXVvMw1OMl4cm+JPv3QRBS75C4uU1E2vFCpA8HySP7Q4AkfFIlDmoFTTjC9cj48x3bZNspOQ+k+3YI+LqIBa79GEjET7PAYySdxxQPI3UVzENEHNWA+B/gBd6jV5ySIjUxDoZYMwHCAJpzm8pd7TfQeMPevIHchsOs3GjlrHodBLGc7bU/vkWI92ir5QcSqTovFMReFMpfHRTwApFrNt3HYGkkZYM0ysA/EV4/OCCYfYYMVTLdrkFvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eZI5S+Lf7VYEbLMisakzQkU8CIE/SNyut3lA6/nzb8=;
 b=gZs7dlSpscXY+QiW92/b767fy9acseZ6rwlf0lPgs2ByJwHtQ4w6KJdfRF4ssTG9qxpxNP7dLUMAxYPhjvqTPuh5SFrp86FMnP4sylE1RiD7D7kIt7Gif+CAyaodMF69feqp/9/5e7REWZGlmSz1tsC/wX8bD5gSzpPrePduq2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by DS4PR12MB999075.namprd12.prod.outlook.com (2603:10b6:8:2fc::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Tue, 19 May
 2026 13:10:07 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%6]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 13:10:07 +0000
Message-ID: <1cc25b9a-1056-4a77-9f87-858820582780@amd.com>
Date: Tue, 19 May 2026 18:40:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/8] drm/amdgpu/userq: clean up wptr_obj along with
 mqd_destroy
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260519111801.1435954-1-sunil.khatri@amd.com>
 <20260519111801.1435954-4-sunil.khatri@amd.com>
 <c0b9b588-0543-4057-82ea-fe6654917a71@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <c0b9b588-0543-4057-82ea-fe6654917a71@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::20) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|DS4PR12MB999075:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b6f3ce-4eca-41b1-f992-08deb5a7f2b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|11063799006|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: iKMkpAG74/JpOurXtzUElkG/6D0dHolKrVzG2IyHgzlyJBUWnhEaeSQt4zjXawrvlVR4uZhbrl+JZqTvSC6ojm5vn/ym7l7e+sDp5GH2P9Mui40lgFfSMisklm64GboPP4MZkO2/+Qj0dOl4tf2a0oejEA/7/YxQq21WNUsRRcOg3gp0F+cwWpRb3JfqhpjU5vUnZCo9oIwtMwDA1kxR72ns8TnDW03iuXsm0E2fJoV80UrBC8D6c8skFRTRK5umB5IreTC6+fZBGJC+qryGs8Gro/oaP4gQZM1lLa9oQkVofyFvfPI3MWdhLT2QYz7TdXoKViUjzoryr7xxveoLKN6XBnd79FnYnRFNjvpG8fngpbwTnYAh9YgMXV6mHcvMi0tXK+eU9d32cok6AuYuV5HwMUWbio/+EhVKayU5dzjuB978a3eGZcP0NG9FPBpGPmzUHAn5lWbeUadyTLKbfFXmcAm+QmASD1UVMn/JZnq24OuuPG9vonxmVlbGbmvJlRXFUs3nEHlxkIEWBoWZK9cpkh4hspyDJ0xmctFpnYmLihoGh7auMDS4PDk1+vMwhMcj0zJuVqM9dw3xYjfFjqKb3M2V+1hX0yv/MT27iBZwoDPllbtCRLgmtGjgvEozsadRZPVGOBkWIBvSaNIIqUx5aWThNNGquazqMphZerDVfmux6+8yNgURbVmjhUt/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(11063799006)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anEvWnpTeS93K1p5aTR0blVyVWVuRWJ5VjB0bzIxdVB1STlrTEVoNy90MUFr?=
 =?utf-8?B?ZTJ2K2lCK2pzanE4ekRPRmhlNGRXSE16YU9penBCcnRTbzg0OTlnSHd1a29t?=
 =?utf-8?B?ZWtNWWZPWVBwWkdtL2o5eUFpQ1NTQ0pBOWg4MEM3K1ZNTk9oY0xKN1E0R2Jm?=
 =?utf-8?B?QmdTeFRualZNY2k3OGlZc3JYWnFmNDhoOXhBc3FWdXpZMXpaS2srZjE5Sk5o?=
 =?utf-8?B?Vkg2T3ROM3htb0JHL1lNSUxmL054SVlOenArb0dZTW5mVFNqVC9Yam9GcGla?=
 =?utf-8?B?YjlCcjIzUWZqS3VhdEl3VENJRFpPYzA1cGg5cEI4NXlHVVgxZW9lNUZaTmgz?=
 =?utf-8?B?RnZEeHpaNjJFL3Y2VHRobXRPNXF4VW53eThXbXNqMDEvMjNLVTdaT1M2MHpw?=
 =?utf-8?B?Nll3RGlXZ2xpbytINm9LZWdVaHBXYi9IOURZMWpCc1ZSVFYxMUNSK3FkaFJ4?=
 =?utf-8?B?MUUxUERpNFJlTDB4SzV2b0pPSE9INUd2VFVia0lPemFIYlF0WVVoYng1cXpn?=
 =?utf-8?B?TGJVcnR1a3Z2YUhRWUw3Q2g5c1ltaHk3QWZSd283UDFLb2EzYVZFRmVkaE56?=
 =?utf-8?B?cSszQVNkdzBKK2hud3UvK2l6Q1dZQWwzSDhXMXZ1SEVHeHB3cWtRYWhFNUQw?=
 =?utf-8?B?ZGQ3WXJDejVTWVI2TFRTYTcwcE45TEN4VzN4OWtqazllN0FkMnJ4Wng2WkRG?=
 =?utf-8?B?TEtxK3Mrb2tEdWZmR2RiUk1UblJIcy9VNGtycWlyNUxRc1htaDY0WmJGakdV?=
 =?utf-8?B?VGZxbVh5Tk1BbWVPN0Q2WjhIdHNXYnUrZHlzeHV3QjBvRnpWVERpUG5jRmxZ?=
 =?utf-8?B?S2hNcm1LQjFrejlVNTVub3h0aExpMFZMVDhHWkNwV1E2cDFoYXlmMmJRSENX?=
 =?utf-8?B?elFDaDdRSyticFpneUs3cHl1QllpWWhlOEZsQ3U3S21OREVpZHRlL1FkTCtE?=
 =?utf-8?B?U3FTMCs5aDVtUXpJOVo5VjZHM1diVUJrMDlwYXNyYTVtT3hSbFlxYzBpVDlk?=
 =?utf-8?B?NFdIbGhFMGJmLzdlSGFGSVM0Q09XS2I3bG5uYm1QaktRakhGdUVka2lSN0RB?=
 =?utf-8?B?aFZId0k5VVVxOExvOW55WXVMZEwwTlNLUEo3bXVCTG5yYkdFTXlFY0Z3TTBW?=
 =?utf-8?B?VUxWVEpyZ0x0aVIwOG9lN2N4WGhKLzVCTWl4OG1kMGJNRkl3Z3ZWTjBUaElE?=
 =?utf-8?B?dkpUNncwZjdDR2xTK3J4SC9IR1BTL3lHRnkvaXB6Zk9Ta0JTSlAwVDMvVkIw?=
 =?utf-8?B?NDBGRHg3bGkyVGJjdktMODBUQUhnd0tyMVRVRWp2MklzQnAweWNjakJ0cWM0?=
 =?utf-8?B?MWRWL2E1SzFJdFVNZkVadUJ0RGgzcU5RdURlWWFVMWZBRWZmcGxDRExETUZT?=
 =?utf-8?B?OVBtUkRNQ1ZocDdVS0F3dEcxcVpwdllTYVRsdHJKUUJzZXZLZ2JZeUl1Vkp5?=
 =?utf-8?B?RUxRc2JrbEV6cnV5NFk1R3pJSEJPY1JwckVGa1lveXppWUFMNVA3K1VWR1R0?=
 =?utf-8?B?L282OUZQbmhnNytWYU1RU3dQWTNoOXVvZTdsVStwRnU1T2phTTVOa1BQZFdX?=
 =?utf-8?B?eDYyN2tSRk9mZ2I2TVlkd1IwWkdZQjYzZ3JqZGthTU9yYzNyZ2dueis1OE03?=
 =?utf-8?B?Y1NQZ05FQ1RqSGRabUZkSXJPOTBROWptMVExS3liOXVWODN3NWtBOWcrT0th?=
 =?utf-8?B?VXVMcXFBTmZhYVVYV3Q4MzY3Y3FLem5xWmxWOElaYjVCS2J2cEVsL3ozdyt5?=
 =?utf-8?B?N3Nwakd2dHJRdlZqL0t1RTNaeWxoQ0tXVXRJcDA3Q3F6ajZzQWU2Y2prOUd4?=
 =?utf-8?B?RllGcHd5L2YrWngraHpWbnhJUmg4Wm9lQlhvVzl3QTJUUVVLd3JoeFk3RGRP?=
 =?utf-8?B?clNhRnBvOXdlcjVoWVlPV1NCZ1hiQTZrTlJ1SXdyVkFycHljR1RxYkRmRDRC?=
 =?utf-8?B?ZmpOek41U1BzUk5JSm1IK01RaE53Y1A4cmlBV05yYTlOak9kOC83YmlVeGtY?=
 =?utf-8?B?ekVBekp6R01zU3lhZXVhcUF0WmlCZjcvYVRORU44KzlTRGF5aEF3Uzh0Z1lP?=
 =?utf-8?B?Sm9VamdLYnZLMEwyZ1RhN3BTQ0k1Qld4UStwQWI0RmQyYkExTXRKakwwaCta?=
 =?utf-8?B?SVh3U0NYZEZ5OFlJc0c5M3lNejhyaktYdVBPVGwwS1BNekcwODR6NlpOcTI0?=
 =?utf-8?B?YVJzanZIbkVRSU9BcmdKZGk5VTZ5M0cveFMxcHpNRGN6c1BRMmRYYWl0elA2?=
 =?utf-8?B?YUdLVDNocEhwcVR0WEMzSngweENrempHaGpKYi81b1dkeUl1anppcDhMMnJX?=
 =?utf-8?B?QnFBcEk3QlJ4dCtaTmtFUnpCRHJyYUVFYkl0d3BrY1ZxVHBJRFh4dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b6f3ce-4eca-41b1-f992-08deb5a7f2b3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 13:10:07.2907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RY9T9Zlm0G1Vg8fWJaegscG5+eMDK0RZEzbmERsDp7RFvv5OQgNsLwX0lmJFazqreGDrcoQ5OsBY6rxh8Q7Flw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999075
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


On 19-05-2026 06:13 pm, Christian König wrote:
>
> On 5/19/26 13:17, Sunil Khatri wrote:
>> During queue creation failure, when we clean up mqd via
>> mqd_destroy we arent doing the wptr_obj cleanup and hence
>> adding that clean up.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 0737636fac43..47a38fefad89 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -835,6 +835,10 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>   erase_doorbell:
>>   	xa_erase_irq(&adev->userq_doorbell_xa, index);
>>   clean_mqd:
>> +	amdgpu_bo_reserve(queue->wptr_obj.obj, true);
>> +	amdgpu_bo_unpin(queue->wptr_obj.obj);
>> +	amdgpu_bo_unreserve(queue->wptr_obj.obj);
>> +	amdgpu_bo_unref(&queue->wptr_obj.obj);
> That should probably be a function in mes_userqueue.c instead of here.

Yeah even i thought so about it, sure will move in MES layer in the new 
patch set

Regards
Sunil khatri

>
> Regards,
> Christian.
>
>>   	uq_funcs->mqd_destroy(queue);
>>   clean_doorbell_bo:
>>   	amdgpu_bo_reserve(queue->db_obj.obj, true);

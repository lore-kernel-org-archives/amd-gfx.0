Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF3FEE0209
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 05:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 514FD10E0A3;
	Wed, 11 Sep 2024 05:01:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2XZY83vQ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA00B10E0A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 05:01:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1Z03zGCMmu397uwwtq4Z//9tLXNSFF6BgJPsZ4EtMSRJGND2PVX6g0AeaABsn49iobswfmXMyc1eLnxUhK04eN26Rdbe78P/4vLBuCKidyySLbP0ejoLg2U8KIBTIQnlVxN+SWGcRJ/FzTJpCFxKNeV/1atVPIW0RusXrSMMf5s9u1BtLV8E0kvxuXl/dtkAUQEQFUEWfcX1Bq7VCxXB+DgK2a3bdCE5JQdg//olU6D39QUF8+pX34a735qWqYTvZ+GY9KJ+nSt7mHv7iFJauJqBj66XRrEx66RpquM3QWWtrK1vuiW0j4VKcm0LM+KFTWJ3FQYbT3lHDoqjCXJAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8m2LvV/MSy+5eJWipA41eceghoHc8bsRCmF+QJLX4o=;
 b=Fe2nEtaqlfpns+LBbRqYnaUAZAi0JdSQGRCiIBWRDIf91aTW9f6zN6Ib9QkQa6XKOzVry3xV5W50jkftsJSJjbYiwSwx4PtalpzswXDje/XjkfXgUz9M3ss1zDhpK8R5E6dwnXs9f0pnz2GD4PyOt+FxCrLctqbPI8EMvwLHOjNX/orf6fu8K/LET6B8jmrFtOa/1R2LBDoVQ64ePuuQe1pOTNZdIYAhz3ReU+MnRLK4JiCVuyJuEIVOMSuKN74BGgHgRdcOuD6UFYda1/FuHeIvnfhkj5VPeXNHw9AygBu484gGADailOwktGrp5FxgcD+PIPjfKjMAXidKOqI27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8m2LvV/MSy+5eJWipA41eceghoHc8bsRCmF+QJLX4o=;
 b=2XZY83vQq3Ke1yIFN1vxZdC7HuY69WaZuP4zoDs3xdboBmJgkz0R489lDv3IxC80VMIKuJ/2JArNLLOkROZ3b/Q4ziCLogiUs5sfUI2vg6qy2rqF6h8iAU3KI+TlrhHcDYBFeQK9Zac/xG5Lp5ePUWDU+WBh2635x2Xw6DbB48k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Wed, 11 Sep
 2024 05:00:59 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3%6]) with mapi id 15.20.7939.017; Wed, 11 Sep 2024
 05:00:59 +0000
Message-ID: <cbf97cdb-3a96-476c-b044-0bad0d8273ad@amd.com>
Date: Wed, 11 Sep 2024 10:30:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] drm/amdgpu: screen freeze and userq driver crash
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240830184322.1238767-1-Arunpravin.PaneerSelvam@amd.com>
 <20240830184322.1238767-3-Arunpravin.PaneerSelvam@amd.com>
 <d79341ab-84f0-4d5c-914a-ff27f4097078@amd.com>
Content-Language: en-US
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <d79341ab-84f0-4d5c-914a-ff27f4097078@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::12) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ec3c1c1-9fa1-468e-543a-08dcd21eb9cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXB1OEhmZXgyMUFqZmtmU052OTdhSUNxeER5SmdJRklkM21HTm00N0NaVWt0?=
 =?utf-8?B?SEVQOW45dEhjd0xLdXJxNlEyK1UzTm5Ra3pOeXhOVlFZZG1xT0FldG54akN1?=
 =?utf-8?B?emN3Qyt2SXFuREhNWGFoMkR3QitGcTlMWEdGK1BJbjJHbHFlcG1wSDM0dFIv?=
 =?utf-8?B?T1R1SUV5Mml6SzRoY3pjdkJhMjUvbnF3VzhTT1NLOHpEUkg0M3V3cldyeDM0?=
 =?utf-8?B?MGgvTktEa3hsRTBGY2xibjNWdjNoUTJQQWdtUmxtR1NHcHZxeE1RU2I0QWVW?=
 =?utf-8?B?NndNbnF4eTJUdjg4QWJwa1lNWGxPZ2dFNDBSRDlBTUtCeUF5NlNjeTJYUHdH?=
 =?utf-8?B?cFJ2RHVHdWRObWRmVVMybnpoTDZDWUVvZXZhakJRTUNjbG5BZUNhaTR2UkJV?=
 =?utf-8?B?elZSKzUrek5iNm9BRGtpU2tJSlpibmF5T2RqQlZScXBsazNnRHRsY21HSVZ2?=
 =?utf-8?B?a3h6cDRxZWhjZkQzQ1dMTHJOYVNjS0o3anpzeXpDYklMQlRVeE9YSzJuSDQz?=
 =?utf-8?B?cUg4U3k5aEJwY0d4MFBRVUsyMXpicVI3dEl4N2tCdit1UDNWMzRnY1lNRGJn?=
 =?utf-8?B?cVU3emsxNlp0N254TjBZbGJ0MWhVWkNQdlN6VEJISDhSNWZMeGtTNnFPM0NC?=
 =?utf-8?B?US9SS3dXbDVnUE1XVzY0VnN5a2VRMTZtYUUxU2VCbUtUTjJQeGNiVFVjaFM5?=
 =?utf-8?B?eVdWRlNuUllyQ0M5SXFJVjVML0FzajlmMG1GN1NRMHl0RDZndm55dEo2WXdD?=
 =?utf-8?B?WExFeHpPdGozRG82cWYyQVBCSWRUdjQ3YjhVRkRyUkNsOHh2anl1WDNyUGp4?=
 =?utf-8?B?YWdXNmhHRCtBNS9BNFpMd04rbk81ME10YnV0WjJub2NqeWpzcHFBQ2x4ZlVQ?=
 =?utf-8?B?cGx0U3UreDMxRDRERlhNZXE2elJ4aXhaNjdyVmJtVWkrUXloaHJJVC9XMUpj?=
 =?utf-8?B?U0RTaXVkSkw3TUg3SnZJNFMvSTc4ZUdvUklXZWQ1Um95c082ZnBVZkxyOVNq?=
 =?utf-8?B?UThwTkdmZG5UT211SnFRMHhBeUhTaUlmR1VvRDYzeURJMEIwMnk1K2QxVzI0?=
 =?utf-8?B?UmhLejlqSUZ2K3RMYjdydU9JekxoRzZrWkRQTFI4RFVBU1ZUUVRGanNvRngr?=
 =?utf-8?B?Z0l0cnB6R2VRTkhEOU1hWk1JbVJtODlPamVUNVdnbHphdjVObFFMS09qcFNK?=
 =?utf-8?B?ai94a3JORkJZK3MvMkJ1YjJ0M0FSalNqNHdxeVlzTmJlcjZPdXZpRCtJTDYv?=
 =?utf-8?B?d0F1R0I3NDZPdWNVR3dqck52eDI0blJUUnIrcE9WTENXbW14OUV6VXFQVkIr?=
 =?utf-8?B?TjVkalZMYjNtRXdoVU9IY0s0bHlWM1ZqMUJOdnNva09sb2cvWVNjTjVwcWw5?=
 =?utf-8?B?dlUzR3hHMHlEUVdUclN6ajRiT3p3OEJneEZ2S0svd3FNNkUycm41ZTYrZW40?=
 =?utf-8?B?cUhSWWtyNTJDZGMxVCtCZW5TZFNFb2pobGpKZVFQVmx4d25qNnZ1d3lkOC9F?=
 =?utf-8?B?bEx6SkhTenJnazVnbGJTR1NXdmg4VVlzTi9peWxsM0pBS0dRVGh0NGR3NnA1?=
 =?utf-8?B?RnFRYSsvbmtuVjIxR3JDa1V5ME1SWGl1TFdIRnlqZnJ0MzRSbGEza01ibUpY?=
 =?utf-8?B?NXh6TkRvdTQrOVFEMmhOb0RmS1ZiZHBaemJFUTVUWWlBYVpLWURFZHpOcnov?=
 =?utf-8?B?aEp4MU9FTlRjanp5akpIbWJrSVRFV0ROZStwaTZuMmxQUXIrWTF5NjYrUEV1?=
 =?utf-8?B?cld3NURWTVAzVmJmVHY3M3dqQXRtNzlHSU1SWlZTMHBzang2RzJLci9SYmNR?=
 =?utf-8?B?WTF6NnlrRWVhaWdNeDhOUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTZlRDZXSnIrWVBIQXBTL2tBVHVyQXBhM1hZYVA1OHk2Zys3SVcraFl2SnBB?=
 =?utf-8?B?bDNmTnU4Y1ZOWFZJTktqdnRoK3VEV1BLa3h0aHJMVXhseTdQUWxHSUpSWWx2?=
 =?utf-8?B?aVFjdVpkbnFwSlNTbVo3Ui83eUM3eUFxaVFrVUtKYWpNL201VDlCVTBQWFFq?=
 =?utf-8?B?UmJKTGZrQTRMYjlubjEwRy8rdVYvdkpxb2pEVERFUVRuVHRWdVpMM3h1WFdH?=
 =?utf-8?B?NUxuUEtudThjL2J0bmRMQ0l4WmpxR04xZUdQVk5Oc1ZuMmtSQW80VEVlVlZW?=
 =?utf-8?B?ZE8vdE9weDkvM2g2bktjOG05QzBjMWd5eFBrRnlCYko2MXVDeGZ2M2t2cHBG?=
 =?utf-8?B?cWk2aSt4ZUQ2UVZTckViZ2E0UDBKMG4zLzRCdE5HWERUOFN5MlJYZVBIOU90?=
 =?utf-8?B?em8xRjUxdEdQMzlHZk55bGVyQkFZc2k2dTY1TnM5QmZWSm5WV3B4VjF4NVhV?=
 =?utf-8?B?YTd1RDdleWw3QkFkOFVzQjdlZUlZSW12Znc1VkxuSVRVc3BsSzZ3bW1kSHBs?=
 =?utf-8?B?SE5OYmM2UUpCQVM2b0x6L3hqRGV4a1VPN2FWdjFrNUxnOFV6dHJzdGhyYWJD?=
 =?utf-8?B?QlhkUk5qSUZpTXoya09qdFBCbmNHOVpVODEwbnk0MlBpMWNFTmQzUzU4c3gw?=
 =?utf-8?B?TEo0WFdhNE9qNGtBdmRURGRWY1ZWRWh0QkxMU1l6NXZkcVUrUFVwU2pUK0xr?=
 =?utf-8?B?SHhBV2N5UGRUVDcvVGhXRTA2ZTQ4OGZqSzFHVFZybFJRSzB5eTJMM0I5THdB?=
 =?utf-8?B?YXB6LzVNRkdWakQreFRKcVA2S0wzWVdkb2p2dUQzejQvWmZMR2JuTHpMOHlN?=
 =?utf-8?B?Rmg0QTFFUks0QWxHVGFGR3dieGJ1Zld6YTNvNjRLK2dJN2hjMG1XK3d6ajZl?=
 =?utf-8?B?NHc5NnV6RmZUYks5UExMZ2Zkbmxnd3ErKzBsOFE5UU1PZzlBSENVUDJWanBH?=
 =?utf-8?B?NE1nb1AwMVZKV2dINngrSEFVWjRvckE0UkxGbGhKdDJRMGZxVTMyR3Z6MkVY?=
 =?utf-8?B?ZjAxSjlQelJyNUVaUDZCdGRxb1pBd1Vhd3NOc0EwZGhmSkR1Y05nQWJsU2JY?=
 =?utf-8?B?c3VlNUN6d2pwZFhCdVlHYjZXZVNlN05SSGE3MzBwc3ZXVk5waFI3bExtaWhO?=
 =?utf-8?B?YnA1ZldDNUszUWdnOHBiTWhOWTlUSXp3SWxJa3R5OTNIMTlIb1RMTVhFditR?=
 =?utf-8?B?cTVCM3VTa3JjMk1NWm9kL0xrYzRLMHR4UlFTRE1uRzFVUExpdEtoa2R2VWRl?=
 =?utf-8?B?K2dVV01tZWNZWUE2NFRDOUcxOWZUY2srcUQ1bENvRDFKajdWajlIcnlpWHd0?=
 =?utf-8?B?czBQQlpCRXVuaUR0MTNqS2J5WWlaME50RnlpOFJ4TEo3anRRYng0aFV4ZjV2?=
 =?utf-8?B?bCtKdS9ncGJUdlFYdEpOSXlXeDBMYmFYaGJVYU12bzZsZlRsVHZIRVlxL0J2?=
 =?utf-8?B?MUhycFptY2RQRGh4eG1SdDRjWHZ2d0lFTDZzcXU4eUFpRndtMkYyWXM2ZFZ1?=
 =?utf-8?B?MXI4czhCTW9uTWRvTzAzYjg0eTlmeGdaZ2YvaWVSOU52b1lqUTYvSkNoWnVS?=
 =?utf-8?B?ZnZiaWVsRDF5SkZlUlpBMkpwVHp2YUl1UnptalJWZ1BOOEhvWTMrMjlFR0tR?=
 =?utf-8?B?aUJxQkV1dEYxNUVOcElPZlI3WE9CUngydVUrKytRemZxSG1OalVXYVZ5VGhU?=
 =?utf-8?B?VzlZdExGY3JrMi9zZmtqV3EwODRVT0tzYXptSkhIZzQyNlVlYXhmVGdWdDd4?=
 =?utf-8?B?a1hxOTJLWVkxSlFyd3BEZEZrS01aTEZteEFQbDhSQ3pGZ2txOEc3VC9kOFNx?=
 =?utf-8?B?VDJ5OFZkTzUydU5XVE5raTMzdEVOTE1JaEZNQ0lBRXl5eTdSa0hvYVk4ZTVh?=
 =?utf-8?B?WTZvNi9uTkJFYzJqL05MN2I4dzBZWU5jT2lON3RuLzdFcnV0ak81RUhTaEhu?=
 =?utf-8?B?ekg3SU9FNVV4SmIvWGRQc05FampuY1l3TzQvby9LSkh4YmhMSkR3MmxramdI?=
 =?utf-8?B?WDJJdEZOOXBGbWM4QksyTThuK1JhM0hVNUFGTFdUL2JEVmJMT2JVcnE5clhu?=
 =?utf-8?B?ZkVWalpsTXJxMHQ2Q3BJS2JYU1NUc3NIMXgzRVN3YytCRVhXd0J4NmNrSERW?=
 =?utf-8?Q?NaUUIh1jfzD91URW9w2bz6YXu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec3c1c1-9fa1-468e-543a-08dcd21eb9cb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 05:00:59.0972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdXj3uCr5L2hB0EwKSTrTG+pV8Km3SMpkNV4Rdh1XmqgouwqCVjFLdUNqfiIKEX+O+vK6sxjV+pDFCgtJibhCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593
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

Hi Christian,

On 9/5/2024 4:50 PM, Christian König wrote:
> Am 30.08.24 um 20:43 schrieb Arunpravin Paneer Selvam:
>> Screen freeze and userq fence driver crash while playing Xonotic
>>
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index d2e1d0d0f29f..8a3b5374cc1a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -187,6 +187,7 @@ int amdgpu_userq_fence_create(struct 
>> amdgpu_usermode_queue *userq,
>>       struct amdgpu_userq_fence_driver *fence_drv;
>>       struct amdgpu_userq_fence *userq_fence;
>>       struct dma_fence *fence;
>> +    unsigned long flags;
>>         fence_drv = userq->fence_drv;
>>       if (!fence_drv)
>> @@ -230,14 +231,15 @@ int amdgpu_userq_fence_create(struct 
>> amdgpu_usermode_queue *userq,
>>           }
>>       }
>>   -    spin_lock(&fence_drv->fence_list_lock);
>>       /* Check if hardware has already processed the job */
>> -    if (!dma_fence_is_signaled(fence))
>> +    if (!dma_fence_is_signaled(fence)) {
>> +        spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
>
> As far as I can see that still won't work correctly since you can't 
> guarantee that the fence doesn't signal in between testing and 
> grabbing the lock.
Can I move the spin lock little up before the if .. else check.

Thanks,
Arun.
>
> Christian.
>
>
>
>> list_add_tail(&userq_fence->link, &fence_drv->fences);
>> -    else
>> -        dma_fence_put(fence);
>>   -    spin_unlock(&fence_drv->fence_list_lock);
>> + spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>> +    } else {
>> +        dma_fence_put(fence);
>> +    }
>>         *f = fence;
>


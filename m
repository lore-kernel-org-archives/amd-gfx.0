Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B5ACA5FF0
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Oct 2026 13:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D2CC10E1FD;
	Tue,  6 Oct 2026 13:26:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x7/fOw9Y";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013036.outbound.protection.outlook.com
 [40.93.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 917FA10E1FD
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Oct 2026 13:26:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMtlHTxrdKxHzd+Yo07eBKEigtbbu0bnb6KXSXbSx9x9IaVYVHlHqoeNccSpR4moy6uBTFH8fDc6XmaQoVHrHIyXUBOlmzY3BRGG2/rsZiwRkadv7caR9DtAnDIFqlcZuADISF+SxoCE5ECAJt+9fCdE4a3bZJccTbyUMmzIu4IW2tTo5irWe8ghFGKYptEsXg8YF8sieVjE34zxYKiDDyHk5+Gq/4DKGGlhbEv0Rt+Ns14ITYARBUTf1Xfg+KVkvuf/h5Y/CHUU1D2zQfPmLAWfRtVJcimw/t/UhtYHu+jQtLUHVaT0gGovF5NiZrrGp31nJhABXjBm0tTUqfKCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqR2JItCENcOqBbOlH4LFDnhPO2eZreGssc0bZ6pj6c=;
 b=WxtJise7gCn2pkwHeEFT/2HdRBGF071GlWBfpAYzYBx/id0rW25PUDzTPgF5vryIpicvkcDBFc/DekuEKTnUh4ajxiBqFroXvwV5G7Dr2cY7ZQLs6kndTj+dIm2Z88gkAaYhY+ULh5M89/A2POgoamom+x6Pc92EqnXckthoeNzJiTi6AzbZc4/Y+1xpDaXBijQ8DCcPfYzAvEjFSqpFvqS3VH/kj4Le2VCAW1ZXkKCMmKujDTKSM3RkK2STi1ftnsCYKTYh4LCIx2InMjvXilaEVDpkB82Vukq3DLeRPcs8mW8kI8cMkIGn8uJDWXq5HXV8rYc+DKgRDeWiDAeHCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqR2JItCENcOqBbOlH4LFDnhPO2eZreGssc0bZ6pj6c=;
 b=x7/fOw9Y/vhPWEx/1cnoNY6wuWbv9RL63iOGxYjF6ZcC2vqUkbyIEbQ6Rr1yHzhmSfiqLco0tbmhb7RBgLB6mWm+qS4bvZ7aTmZcqIyg6tqXaVvQWl19QXDd5sGuwz0+oNiLytfiVQPIQ64vC3Lv/SbE4/alkpewEhrOjrqBZfM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10)
 by DS6PR12MB765562.namprd12.prod.outlook.com (2603:10b6:8:4c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 13:26:19 +0000
Received: from DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c]) by DM4PR12MB5167.namprd12.prod.outlook.com
 ([fe80::4588:54c1:bc29:2c7c%3]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 13:26:18 +0000
Content-Type: multipart/alternative;
 boundary="------------h5kWE05ikbrQuonHUP4U92PT"
Message-ID: <b6f6c61a-799b-4e70-a10c-b6c481cbf7e7@amd.com>
Date: Tue, 6 Oct 2026 09:26:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Fix svm_bo use after free in
 svm_range_clone
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Harish.Kasiviswanathan@amd.com, Mukul.Joshi@amd.com
References: <20261005203247.1363226-1-Philip.Yang@amd.com>
 <16bb0bc3-b714-4192-ae6c-c20912328600@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <16bb0bc3-b714-4192-ae6c-c20912328600@amd.com>
X-ClientProxiedBy: YT4PR01CA0371.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::20) To DM4PR12MB5167.namprd12.prod.outlook.com
 (2603:10b6:5:396::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_|DS6PR12MB765562:EE_
X-MS-Office365-Filtering-Correlation-Id: e156d686-9668-4dce-c413-08df23ad64a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|8096899003;
X-Microsoft-Antispam-Message-Info: 3IRXH3TP5dPD8W0EiD7FL+oQb++8H11EnTiWs3YOCqjbn8KO3h0Aa3HhQqrK17+tCu9Z8CUjHrmDc57dM6/ZKNwEeqoq/fIIWI83dgJncdamjwO/EgN7F0rIlcqbxeNu4KZSFdI4RwyOco3gcidezhFXMzJb1Sl8Lex54R78dfYCynUXyNUJ6KlyZr7TJPcdNkxOyt0t5S0GEciGxGwZxhuAFaXol8E2RMgW//8dGn9UyULEKIlvWVYz3gwefpnvU1aJfaMfMHw9Cm+3NoGewLtOOAMyoigFQF3Ywe9FYZnyVptmukpsrJOrgwSCEJFihz8hhSJCw2ERpLXC7LMp9D8M/rsyvvhu7+Utk3pVXayzYHrqCYpn6uG11N5BCLU0pJMcvR33z/XDtcYcyX/31ovalBJuzjZpuXcgZdferT/XL00FCAPK0Wpar+XauKAh/Umn3gLIVeaad7uuXYfChxZFwMhQLscmmiEjr6u8ES/JuVgrpVgF0ta5RwaxiGhE39UVub8P1PVV6C1feChUd+ho0ssUMcysZP8XaA2x1Rq8TFlGTVfCOGvgbOvoLyAAw/0Fz0sBo/CBRrTXoSqXYlzo8zv4+ZiGebqZsIJAq25abtQqxzMSHzYZ9wgU771xIMm9n3Ez+CiRhAk9/KCzDf+h3heNTWM7MPe/mGd111k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5167.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXVZY0dFc0tIYlptMktHM3M0RzBKbjZ0SmFIMVEvQ3pKS3JYQ3FyaVVVRXVT?=
 =?utf-8?B?eXB4dUxnMDVTM0FVeXJvQXBtWGZobzhRRjB5ZHdkSlA1bDBRMEw1K1hLdGlP?=
 =?utf-8?B?UHVqMFBLbnFTM1NQZ01ZRGcvT1Jaak5wa2I5T1VvN3pGcUJZVFRBN2NsSFZ6?=
 =?utf-8?B?SUJUWTVBTkZkRkF2aHVKRzl5dVgwUFEzS0JXakwxaVFnYWZHRzdVUUs4ZEt0?=
 =?utf-8?B?UmE5eFcxV3l6eEhhSWt4T3F2cHFHcFBmRjVNaWlmMTBCYlpka0J1Ri9PQmJa?=
 =?utf-8?B?L2YweGJtczgvWTM4a2NMYXAxTnBTNVpSWFpxZTlHbmZ2dmNiamt2NVVCQ0F5?=
 =?utf-8?B?VlZOOFVqZ0ZQMDg2d0J3WHp3amsvZ0ZyRFYxeVBJY0dMUW41U2FsZDhsenhH?=
 =?utf-8?B?c1RiS0FCTHFKMlc0V1BLNDlTTlpGNGxuQ0c2eXNTRnRSQWhpQnBGY3BZL1lx?=
 =?utf-8?B?Sm9SYnNKT0wyZjQybXVnYm1QM2dwdDkzNHJLK0xYcFh4RXZzMUVoNExrcllD?=
 =?utf-8?B?RXFqKzJ3bm5LM2swSS9RV3BzSVdOWXNaT2ZyODRuR1lPOTVNN01tZ2JjMU95?=
 =?utf-8?B?SGEvbElkeFJCVklxb2JhUXd6dDZwL2NVbjcxRFZzOW10Q3loeWF4Q1BmbUFj?=
 =?utf-8?B?OFU2RlFISDdBRUpGUTVmL3IyNUkvUFhLRG5DU21vMUVIZGFHQ0NpU0RES2gy?=
 =?utf-8?B?WXA5M2dmLzk1NmdVOU1kTlYxR1dWTXhVaUkwVy9jclZSNkkza29xcDcvMVl5?=
 =?utf-8?B?SVZtbEl0dVM5Q0NsSkk1SFNIQ3VKUnlBeGsyOEhhWlk3R3pUUWFsUGYrbjV0?=
 =?utf-8?B?R2hiQWNmYzcvekVscFNaRXBVQXVTMzlVVjJ6Z2xjSTR0elAzWjZkUUhCK3R3?=
 =?utf-8?B?dmdmVXdiZVZ6YXJZenhqZi9EdnBCR2Rtalg5eVplNERQOGkxclFYTmZmM1Ex?=
 =?utf-8?B?bFF5ZnJoUlArZk1GZEpFRllJWmdEY2lETjJwSElRaHhhenJXSGdNMmE3ZmRY?=
 =?utf-8?B?aXZKbGpwakpnWVVJR3h0QWVJdUxIMms1VlpOaUd0eThtRHh0VXF2bzNsMGta?=
 =?utf-8?B?Z0c5MC9ybDNuUXAxd0Ezc01RWERSYUNRTlljMlplbU9Ia0l2VjNVNm5jNUNx?=
 =?utf-8?B?ZEFnQ1I1WXJIL1dFYWl1Rzl2aG1ubVkxTk0zSVM2eEZZSVphcVgzdnp2eWZu?=
 =?utf-8?B?TFlWQjBrMmY1ME9weHREWitkb2RQSkZoUDN5bE9DQ2JWWkYxelQ2STNzbzBW?=
 =?utf-8?B?UmpvYVBpWVF5NE1PcWhDQ3pWdGtINHRIZ2UrVXNTVlJldGoxNXRsMXhrQ3VQ?=
 =?utf-8?B?clo5M01lYUtNTUs5c3V1V0R2QU5IU2crMHlUTDhqVm53Y01HS0RCUDNkRVcx?=
 =?utf-8?B?bnpzVndTWEFwR2JXdkhTdzZEcUsrRWN4L0o0SjZMc2xFekJRQmlRd1ZCOFht?=
 =?utf-8?B?TE9HcExBMXJaNDZxSVIvQkJSSUhiMWFrQlRwUFFVd2dibS81QmxWb0hTTFVk?=
 =?utf-8?B?dmU0RjduVFpCVy9sQmxpZUlpRmtwZm4zaTlFWlRwbWFkRDBrazFIVTlMUXd5?=
 =?utf-8?B?T1hDYjhjQjE3ODArUzVsNmY3WFJ0N3YvSFFSajBYRGNJeXlQWVVkMlI0VXNu?=
 =?utf-8?B?OE1wYk1UbEgrRm4wdkpINHhxdVBReCtya2U2dlp4ZWRNb2MreTA0b1UrSlFE?=
 =?utf-8?B?QnBLVkpNR1pFT1hXd29xT0c0L09weUpnSnBqb3ZSL0doREJXK1FlUDlzYTY2?=
 =?utf-8?B?M1llWnc0VWtyZmxoS1RPaEt6eVlQQzByNFhJQzRidkVXYlZOTGJaZXNWSFYx?=
 =?utf-8?B?TmxUWkpXUUZkTG9TbG5LVFFLY2VFRlpiaUNFV3VlRTN0RXV4VlZwWmg3U1Rk?=
 =?utf-8?B?TEJSdCt1Ukg2SnJ3ZDNWOTdFOTgzaTFYTzRxdW1qb1M0Ty9tN1dINnRsbW1Q?=
 =?utf-8?B?TEdzazB4b05vRHVBNG1heVpUQWk3M2RDM2hHOGo5UTFZRnowNmZSL0IxL1dT?=
 =?utf-8?B?ZzA4cDF4dTFHVFdYZFFEdy90UDUyVyswRlpDY3YyTE5aSlV4cVhaV3dYdzVh?=
 =?utf-8?B?S1prL3dhWHZFV3pXRm9EeHdHdnBiZUhBQkhWMy9HbzJhbjRBME0wRjl4bC9x?=
 =?utf-8?B?VGdHOFVENkNJU1pmTkZPWjNreXNEcHhZWm1XcDNsUlFpTzl5T0ZBbGs4TVp1?=
 =?utf-8?B?TlNJL0NydlpYTktycGVDZjEzdWx2NUFEaFJnV05MUmpGQTBjYWlTVmJtYUdv?=
 =?utf-8?B?SkkyZDZmejQ0ZTkvcENyZUNDckMxZ1QzK2RJdUw5RFU4RHUzYXFuZ2JSYnlF?=
 =?utf-8?Q?LylZkg6mM6GUgSdltm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e156d686-9668-4dce-c413-08df23ad64a4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5167.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 13:26:18.8448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Wk32hpRmdbf5mDsFbAkRKHXgnG6ddNhXMHDXhbU4todIODGCPq8lEn4O69UrA+A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB765562
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

--------------h5kWE05ikbrQuonHUP4U92PT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026-10-05 16:57, Felix Kuehling wrote:
> On 2026-10-05 16:32, Philip Yang wrote:
>> prange->svm_bo stays set after the range drops its reference in
>> svm_range_vram_node_free(), it is only cleared later by
>> svm_range_bo_release(). Taking a new reference based on old->svm_bo can
>> therefore hit a svm_bo with refcount 0 and svm_range_bo_release_async()
>> pending, leaving the clone with a freed svm_bo.
>>
>> Use svm_bo_ref_unless_zero() under old->lock to only share the svm_bo if
>> it is still alive, same as svm_range_validate_svm_bo() does.
>>
>> v2: use svm_bo_ref_unless_zero instead of checking old->ttm_res, to keep
>>      sharing the svm_bo when the range dropped its own reference 
>> (Felix).
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
>
>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index cfb428c72686..7ffc31df3b87 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -2158,14 +2158,19 @@ static struct svm_range 
>> *svm_range_clone(struct svm_range *old)
>>           svm_range_free(new, false);
>>           return NULL;
>>       }
>> -    if (old->svm_bo) {
>> +
>> +    /* old->lock keeps old->svm_bo alive while taking the reference */
>> +    mutex_lock(&old->lock);
>> +    if (svm_bo_ref_unless_zero(old->svm_bo)) {
>>           new->ttm_res = old->ttm_res;
>>           new->offset = old->offset;
>> -        new->svm_bo = svm_range_bo_ref(old->svm_bo);
>> +        new->svm_bo = old->svm_bo;
>>           spin_lock(&new->svm_bo->list_lock);
>>           list_add(&new->svm_bo_list, &new->svm_bo->range_list);
>>           spin_unlock(&new->svm_bo->list_lock);
>>       }
>> +    mutex_unlock(&old->lock);
>> +
prange only holds svm_bo reference while ttm_res is set, refer to 
svm_range_vram_node_free,
prange can have svm_bo, without reference count, with ttm_res NULL.

For this case, new prange should drop the svm_bo reference, will add 
this in v3 patch

+if (new->svm_bo && !new->ttm_res)
+               svm_range_bo_unref(new->svm_bo);

Regards,
Philip
>>       new->flags = old->flags;
>>       new->preferred_loc = old->preferred_loc;
>>       new->prefetch_loc = old->prefetch_loc;

--------------h5kWE05ikbrQuonHUP4U92PT
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2026-10-05 16:57, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:16bb0bc3-b714-4192-ae6c-c20912328600@amd.com">On
      2026-10-05 16:32, Philip Yang wrote:
      <br>
      <blockquote type="cite">prange-&gt;svm_bo stays set after the
        range drops its reference in
        <br>
        svm_range_vram_node_free(), it is only cleared later by
        <br>
        svm_range_bo_release(). Taking a new reference based on
        old-&gt;svm_bo can
        <br>
        therefore hit a svm_bo with refcount 0 and
        svm_range_bo_release_async()
        <br>
        pending, leaving the clone with a freed svm_bo.
        <br>
        <br>
        Use svm_bo_ref_unless_zero() under old-&gt;lock to only share
        the svm_bo if
        <br>
        it is still alive, same as svm_range_validate_svm_bo() does.
        <br>
        <br>
        v2: use svm_bo_ref_unless_zero instead of checking
        old-&gt;ttm_res, to keep
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp; sharing the svm_bo when the range dropped its own reference
        (Felix).
        <br>
        <br>
        Signed-off-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:Philip.Yang@amd.com">&lt;Philip.Yang@amd.com&gt;</a>
        <br>
        Signed-off-by: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a>
        <br>
      </blockquote>
      <br>
      Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
      <br>
      <br>
      <br>
      <blockquote type="cite">---
        <br>
        &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 9 +++++++--
        <br>
        &nbsp; 1 file changed, 7 insertions(+), 2 deletions(-)
        <br>
        <br>
        diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        index cfb428c72686..7ffc31df3b87 100644
        <br>
        --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
        <br>
        @@ -2158,14 +2158,19 @@ static struct svm_range
        *svm_range_clone(struct svm_range *old)
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_free(new, false);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        -&nbsp;&nbsp;&nbsp; if (old-&gt;svm_bo) {
        <br>
        +
        <br>
        +&nbsp;&nbsp;&nbsp; /* old-&gt;lock keeps old-&gt;svm_bo alive while taking the
        reference */
        <br>
        +&nbsp;&nbsp;&nbsp; mutex_lock(&amp;old-&gt;lock);
        <br>
        +&nbsp;&nbsp;&nbsp; if (svm_bo_ref_unless_zero(old-&gt;svm_bo)) {
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;ttm_res = old-&gt;ttm_res;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;offset = old-&gt;offset;
        <br>
        -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;svm_bo = svm_range_bo_ref(old-&gt;svm_bo);
        <br>
        +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;svm_bo = old-&gt;svm_bo;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock(&amp;new-&gt;svm_bo-&gt;list_lock);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; list_add(&amp;new-&gt;svm_bo_list,
        &amp;new-&gt;svm_bo-&gt;range_list);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_unlock(&amp;new-&gt;svm_bo-&gt;list_lock);
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
        <br>
        +&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;old-&gt;lock);
        <br>
        +&nbsp;<br>
      </blockquote>
    </blockquote>
    <span data-teams="true">prange only holds svm_bo reference while
      ttm_res is set, refer to svm_range_vram_node_free,<br>
      prange can have svm_bo, without reference count, with ttm_res
      NULL.<br>
      <br>
      For this case, new prange should drop the svm_bo reference, will
      add this in v3 patch<br>
      <br>
    </span><span data-teams="true">+if (new-&gt;svm_bo &amp;&amp;
      !new-&gt;ttm_res)<br>
      +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_bo_unref(new-&gt;svm_bo);<br>
      <br>
      Regards,<br>
      Philip</span>
    <blockquote type="cite" cite="mid:16bb0bc3-b714-4192-ae6c-c20912328600@amd.com">
      <blockquote type="cite">&nbsp; &nbsp; &nbsp; new-&gt;flags = old-&gt;flags;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;preferred_loc = old-&gt;preferred_loc;
        <br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; new-&gt;prefetch_loc = old-&gt;prefetch_loc;
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------h5kWE05ikbrQuonHUP4U92PT--

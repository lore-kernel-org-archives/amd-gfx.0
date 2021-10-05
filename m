Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FA7C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 13:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BE0761244
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 13:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2BE0761244
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 789436E3FC;
	Tue,  5 Oct 2021 13:49:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3E376E3FC
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 13:49:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fzv7wHrLnDDfncTNC+sincKpzRj0V24hTH/1UJxM1S8xMhN9/WF9d49of8umdJmCIfcwvqKKNVEJQEIEldq15m7b4HJFrPZH82tDk8oIQK1hB5E8aNCjvvzHtzxlriHHVhdrW65OffWyGihqnt4c/RrZLhDlX1OCeTSya8XR8gXXBWLT6xWtbD6TgXHW0JydwmC7Y7h/9TnAsuYZJyHAVaxAaN9w2/+RzYIB808ReaWxXETaQ8OukzaCBxa3Nyk6eN7SDH9v55PTw2twWWxnwgQw0l49F3+aLD+cWwdBrVZZ3YmRcgsl2oXrG8EUVb0ZJJxNIIN3b9uSZFneAKqMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDjlQRMq86K3jxoGkh7xC/xx8nt5Uh3XfAtiS4kC//Y=;
 b=fjIwLyZtEsgMoEIur1C3C0cyjBwEGBwmTyIhv+AgcWzm0ddlySb+klKa/G6uCOStU19OwU3kU/80UUk0LTTjhPBd07Epi9Bt2pqvgY9Jv1o8SXMW86h3L6/qRj0H6+YIafwoNVCYt9uRBKubR5JQbHRJHuyhkrn8cDTDqUfKCLxWBoFJ03zOMrnecFxTp2jYMoUH3uTil+rKx2NPxF5Cc7elspzSS7UOwSzmL5+FkHSAINuaN63asP1yeJFyc8NB5phA2fwLy7NIQXwHnXVrb7t6aGOw9iT/f8DhC2+N721Bd5mDqvPJB6sb9gOoiR+q7fpQo6omwqztdWJZNMBFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDjlQRMq86K3jxoGkh7xC/xx8nt5Uh3XfAtiS4kC//Y=;
 b=kaf9Vids1++wyHB3rrd5ZiLdEfO16Tdt3AM5kfnFSNXbPWBzIiu1jQtbKO7ivcPWWzFoJalqf2bkqVW2Vwh42SOQaz+yI5G1OyMS62fkqFSz/IdT1O/v9rQ8Ox2t57AKn4k4uSq44bnS7z65XwFeCoI0Zp/uuq7NpeR5mUgwtbg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM8PR12MB5480.namprd12.prod.outlook.com (2603:10b6:8:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Tue, 5 Oct
 2021 13:49:26 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::555a:2980:a5c2:8d29%7]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 13:49:26 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: ignore -EPERM error from debugfs
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: shashank.sharma@amd.com
References: <20211005131115.25595-1-nirmoy.das@amd.com>
 <ab673b77-e8b7-94a4-76f6-588ad9e472f7@amd.com>
From: "Das, Nirmoy" <nirmoy.das@amd.com>
Message-ID: <182c1454-102e-cf2f-80eb-09baa57f8e82@amd.com>
Date: Tue, 5 Oct 2021 15:49:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <ab673b77-e8b7-94a4-76f6-588ad9e472f7@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM6PR10CA0012.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:89::25) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
Received: from [IPv6:2003:c5:8f22:7600:a4cc:46c0:2b2c:fb20]
 (2003:c5:8f22:7600:a4cc:46c0:2b2c:fb20) by
 AM6PR10CA0012.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:89::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15 via Frontend Transport; Tue, 5 Oct 2021 13:49:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84335f96-e315-48d3-234b-08d98806f242
X-MS-TrafficTypeDiagnostic: DM8PR12MB5480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB54804A149462CC15B842C60F8BAF9@DM8PR12MB5480.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vEqXrAtsyzR3S2A/fmDZDzCre9FqNxYCI8ArjTGORTwc9KT3RaXoRWCsnR5wecPoeSvtE/6mwSRQ/29gImd2kPutQY3/OBR/USuZndSC8Qskku4fKNm/l/TJFosOUT3jX7ucPzfW0X7pRnHCotROaOm+zqibUhfZ63hRc7x67BmFIFbk65AdcJPQxOyRkVwuMSkICD6caRFv0OsxLALWve65xLWJVrNbhTu2XaUv+NvTFAXYTAf9QHpffOF35sGl/q0h/ikBkF9NKptNFTZ8xVLnM34zCYbl0OqCR/fT1paPHxlN3I6sasYUlmXcogZbYtXAPYyn7WNq66Img9WZXzX6aenwe16OR30bkXqfW7Xbs0KGQ2GgPiFpi0IfTWrKKB72WhlEbeZk5+SgkL1whCjrkaRZj4hY+JzJcfRUtmtAHh1Kqk4Tww12rRCdIQxcyEodX7GKYrCD8Z+S5I0RPCfLyftXkplsalMfAmObpLwu5s64fV2xtNGe8rYgAYDz/Pgb+nwvB9OBC/h/qEqA02maBQhRIndxJkHSU+guB9L0Qm95vyFYY2QOGjL45sv6DNfVIijb0qg+7ibUC0cVkUFOLgeezF0qjpQJziF/kpN6UiUv+Q4ViihljgVrBlX9CSfqa2S89stOXyYt1RaCOUD1+wM8hCjj8+4zaiHRbpANS/9Vam144+2RtQ2Deuuv4BR4X0ngdVdbje1uZiIc93RyTCsGGF7otM/1Q7x1RVE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(508600001)(8676002)(66574015)(86362001)(66946007)(66476007)(66556008)(53546011)(83380400001)(5660300002)(2906002)(6666004)(2616005)(38100700002)(6486002)(31686004)(36756003)(8936002)(4326008)(52116002)(316002)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTUrRStEYUtmOWtMRklxTG40aFNYazhWc1UxRGdHLzZoWndlemF6UjMrQlBq?=
 =?utf-8?B?Sk16K2h0bkRHNWl1NjBFVFcrSXArTlFvRzJFZTJtWkp4bUx6eDdjVFJheldr?=
 =?utf-8?B?Z0VJMmtEM1lRWVhiTVJySGNodmlqUEVHS3Z1bURhbFdpL1hUOWZRZkdPVDlw?=
 =?utf-8?B?YkNmeDBVTzFQWVpCR0xoZXg1VlRka2ppOTE5cXAwMFNYVGc1QjZNck5xdzRr?=
 =?utf-8?B?VTFtRlhtSWpnWlE0aS8wU0w1NGExVStoOHBaTFdxSllIMVRDbEJnSGdJT2s3?=
 =?utf-8?B?TlB2MDZlLzVVM0lla09sZFBXazluSHVZU25JZFhld1V0WndJM0FQWHU4aEg0?=
 =?utf-8?B?T0xDWGtGWEdhZWM4KzZMZi9lNzBpb2wxZzVjak5pQ21iM3FqRTZBSjk1SGY2?=
 =?utf-8?B?Y3BxcEFlS1BHNDlVSTQ5dzErcVRUdDdjL0lORnVjMFZGcmJEbmEwT2FOQTRa?=
 =?utf-8?B?MnZzY0R4MVZtbHlnV2VEK0JIczJ1UVd3cnY4Q1pubHgrd0pQZE9uNHR3d1pY?=
 =?utf-8?B?TzAxeXNMMlJvNFNCcnNDZSt5Q0p3TXE0VGlPbjg1elV5b21oWGxic1JQTlZn?=
 =?utf-8?B?bmxtTVA4TEd5QllWUVlqUVQ5OG5BY0FzM0VISUx3SldqbWRYNFRoVUZkRnll?=
 =?utf-8?B?aTlvU1IxbTRySHFGdzBYYTJvTm9FZDByOG1PVlowaUJqVWZGNUlsQUMyUU83?=
 =?utf-8?B?RWQrSWpENDVScm50WTBvV293N01OaUR5cEdBTWRIS3AzNzBPMWh2V3JjS2Z0?=
 =?utf-8?B?a2x4SGMvUWxFQ25IdnRwY2NLOTRRVDl4cnY2Vzk3YVRNUDZ5aGZLMWVLV0pT?=
 =?utf-8?B?T2J3MmZxZlU1S0lDdnlLK0piZGZhd3FxblY0U1FOUmkwS3BVa0dLYUpZc0Nz?=
 =?utf-8?B?dC8yWnJqeEpQR25YWWxPbE5kQk5HZktnVitWOWdCVngvcUU5YVE3TlV4M2JY?=
 =?utf-8?B?R0d1QmFrSHFKTW45QTdtVXFIamJrSmVubGdmbXdQeERQZXRhYmRQVmhLcElq?=
 =?utf-8?B?TWhQUmpwMUtLdmUzU3M4OWFIYnFZdFpnNy9Fa2x2aVJEcXQrTGI3UWVEVWIv?=
 =?utf-8?B?QlRsYmxaNEIzZUY5RVlYN0JiQTNqa2xTcVg4N1J5TFNCVVJqcytFdFVHazJ0?=
 =?utf-8?B?Zm1KRkNseXBwSUhBLzJ4ZGg4MVpHQW9nem1YT2hhQndMRXlCcHdJTloxUWZm?=
 =?utf-8?B?QXltM0JZVEQ4MVRkMElSanFNZTNTWHNUL1o0Z0JKK0ZNS2VtbGxXZ0tqcDdO?=
 =?utf-8?B?dGMwQk1ZaFdsemFzNm5qYmZyRGw5aHN2anVvZ0dzVlFJTUpJK20vYU9jazJR?=
 =?utf-8?B?elZac1pkUlIzU0lqY3oybUwxMVZ4eXNyY3ZMVmVrd1crV3lQYVZCQ2IyTVFQ?=
 =?utf-8?B?UHhXT0tONnVURFR2bWNFRURNOVpEN1ZYcGNaZk5pZzd6WjAvUTNRQ2k4bXRy?=
 =?utf-8?B?LzdZVVE1TEFGeU5LajBYczRZMVByZDFjd2gwSlZ2OGtjTS8zdjdidUtJRm9s?=
 =?utf-8?B?VUhxQ2M1RTRJVERPcnZQbERIMGFQVG1iZXh6dWVpdHFoTjM4dmpCNnE5VUlW?=
 =?utf-8?B?cFFGd2xiTk93ZkpYdHZxRHRYK3pzUGFaZlhmR3c0eElEcTZWNFhZT1M0cVhO?=
 =?utf-8?B?Qys1dEM4eVhiaWVMRWtTSDdBUnRvd29jOFZlZUNxb3M0bEZIZ1EvSVcyckdj?=
 =?utf-8?B?ZXcrRXQ4NlpDamxUbGNnSUEvOUMyenl2OWdPYW9lQnlsUHRBTksxOXp3UEFB?=
 =?utf-8?B?dVg1eGtiZjlIeGo4a1o1N0N0cklYclYxVHJNL2RPYzNOTmE5ZHhkYjJ3bDg0?=
 =?utf-8?B?V3h0eE1xempQRDlqRWF0TlBVLzRlbjkrNkFnVHFOMDJlcGpaVFJ6L3ZwWmI0?=
 =?utf-8?Q?5+YXLg3epBBSV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84335f96-e315-48d3-234b-08d98806f242
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 13:49:26.6741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOVclGECTjfP0y9zbCYAc9v8lu7aOFaFZEJ0cFkMTpxd8BPnuKnaCWg2lvGBFavAv/RAw9RQaLPBvRElSCw/2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5480
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


On 10/5/2021 3:22 PM, Christian König wrote:
>
>
> Am 05.10.21 um 15:11 schrieb Nirmoy Das:
>> Debugfs core APIs will throw -EPERM when user disables debugfs
>> using CONFIG_DEBUG_FS_ALLOW_NONE or with kernel param. We shouldn't
>> see that as an error. Also validate drm root dentry before creating
>> amdgpu debugfs files.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 6611b3c7c149..d786072e918b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1617,6 +1617,16 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>> *adev)
>>       struct dentry *ent;
>>       int r, i;
>>   +    if (IS_ERR(root)) {
>> +        /* When debugfs is disabled we get -EPERM which is not an
>> +         * error as this is user controllable.
>> +         */
>
> Well setting primary->debugfs_root to an error code is probably not a 
> good idea to begin with.
>
> When debugfs is disabled that should most likely be NULL.


If we set primary->debugfs_root to  NULL then we need to add bunch of 
NULL checks everywhere before creating any debugfs files

because debugfs_create_{file|dir}() with NULL root is still valid.  I am 
assuming a hypothetical case when debugfs_root dir creation fails  even 
with debugfs enabled

but further calls are successful.  This wont be a problem if we 
propagate the error code.


Regards,

Nirmoy

>
> Regards,
> Christian.
>
>> +        if (PTR_ERR(root) == -EPERM)
>> +            return 0;
>> +
>> +        return PTR_ERR(ent);
>> +    }
>> +
>>       ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
>>                     &fops_ib_preempt);
>>       if (IS_ERR(ent)) {
>

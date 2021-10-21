Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB17EC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86DD461130
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 16:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 86DD461130
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CACF6ECD1;
	Thu, 21 Oct 2021 16:49:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F59B6ECD1
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 16:49:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkEK9uaGhlz0V9Tw+PiyhPVbbogXKAShYmol5YQH5eYDNr+NEQr964rf3kANi+iC8d9RbzTPYmUPn8W/CAJ1Di90oUm98xw5VX7mzh6Oin1HdIZ4dP4ltQmoV5W+z9ojfOrIzDZxdit7Si5nf5CGK3pGSs+QQvy8k4MwSZ4g1rmTRyqSThf73z9b4smHv+p1No2fhFCAFMWinZ29D70756o1m4V9AJSuAkVdJU0nQaHSWOk1gU/6DdfPCDqGJ6eT50BtJ7hb+ePtIxmkME5Dsv2sw0BCEvcpb/ZHEuHQviGdtfHiEw4BQ428Cd6rE//IK4iWnJ4anbkWDr60JfPIyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGTmYgeo3IzRzinkGJmk69L2Xui4SsnL1Fooupmrt4g=;
 b=khYns0OprFXKjEbSpwfKvHIMxJvYjR3enW45UOhwLEDLIHo4lEXPPhPWzQTuCwmhxChIGEdwQVq4bSnspQsTYdqWFKY2TSF6Z6sj5fg/upfY2k7Bm2XE2ZNguUSWHo7GZI5VZp/hN8ZwnMehG1Nc5bEpReigMdSVuxyge0TiuQLiSslgWUJmax5luX53XjE+yu6nWo4UY5FKNxlq8F8g7vtsjF4KKpBmZaZQzQVorx4w6UHQ4WNTzjBXxbNunsObnHU8Ar9g+OhvsXq9QLeQjLd5raEuc4Akwx+wAy7OaqLZsDdnxUXD0tOEe57roiRnbNnp2q6E/Lyt7SJ9/aopEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGTmYgeo3IzRzinkGJmk69L2Xui4SsnL1Fooupmrt4g=;
 b=SLCdg9w9MYjc1EW/Km8+gzJzLBfxryxqROW2nd0vigZCfy3S3/B46gbqPUEXAYg9rGtEDjCK7KRn3HTc004fOy3cH6qnDGjjlwUtMOtx+ra5WB3sw8ry4+XQqs6CIEY80wmyp896Ei3+cklPTEYByWQ7c5cuPSEwui0u+V3XfhA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3957.namprd12.prod.outlook.com (2603:10b6:610:2c::17)
 by CH2PR12MB4647.namprd12.prod.outlook.com (2603:10b6:610:b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 21 Oct
 2021 16:49:28 +0000
Received: from CH2PR12MB3957.namprd12.prod.outlook.com
 ([fe80::9cc9:5edf:91ad:93d9]) by CH2PR12MB3957.namprd12.prod.outlook.com
 ([fe80::9cc9:5edf:91ad:93d9%7]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 16:49:28 +0000
Message-ID: <cc4f5b6b-2593-f51d-15da-a4f061fa8fa7@amd.com>
Date: Thu, 21 Oct 2021 12:49:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH 1/2] drm/amdgpu: Warn when bad pages approaches 90%
 threshold
Content-Language: en-CA
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Joshi, Mukul" <Mukul.Joshi@amd.com>
References: <20211021155711.1191830-1-kent.russell@amd.com>
 <50f764cb-64f1-5b36-7e14-1c560784b7ea@amd.com>
 <df069bd3-76cd-4662-b4c3-23e6e17c77d6@amd.com>
 <DM6PR12MB3324522EA8DECF3AE8C533DF85BF9@DM6PR12MB3324.namprd12.prod.outlook.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <DM6PR12MB3324522EA8DECF3AE8C533DF85BF9@DM6PR12MB3324.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::30) To CH2PR12MB3957.namprd12.prod.outlook.com
 (2603:10b6:610:2c::17)
MIME-Version: 1.0
Received: from [10.254.34.99] (165.204.84.11) by
 YT1PR01CA0091.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 16:49:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c0c0079-07e4-4c33-bb26-08d994b2beee
X-MS-TrafficTypeDiagnostic: CH2PR12MB4647:
X-Microsoft-Antispam-PRVS: <CH2PR12MB46471E2D4BC5EAE3F15E5DB699BF9@CH2PR12MB4647.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OuXKUXKJwb5oBGsKx5OCZQI+/G9gxD3+MZ58VJsyjk783gMZuJML34Ya2es5egncyDgXwx+u6N/dYuLswd8fjKh3+Nt4mVASumS2QjQHEyHvHuymgvCFiYzNa5ujnrZg6RsRRCH0O4E5kAQ61kcgzH+FFDhbMWy48yr1YWpeK+A4EMUhHr9OlqUFIO2joSJ6olkDebi6iTHb/N/OTLGL9vxp6WWqyFjAU7IsWHWOG3FwcK5kBYLXsS7dUyq3YHkoSDuQZ/tSnixKlZ2Q+aA+dw4rx6Fc3e+Q7xkJqOpRpSHjEDpLul3wjYT3TA2muw58Q8hreQeYKfSN90OXVDtJHCkLKCT4+ZVGI4hPTteVXOljCXID8/oah5QdmLq7WuuAW8DYIuuvbel0XKugSonOZEJkfvkhp6Xex2MGLiK3vZOEZPoy9VPDp84FMwxdPKcmujB31k2ag0aFDiIsbG5XNPnL8usXi/HV3BNTr1o8iePZdcdiwqCrD5miekNrwLDN/Ld7mgpMI694b0sj7vni8uB3ufav9peuY8R+GLLdXH3A0rFu7F0ounumifkrUioyYUKnPVNgGCSkcWAJcae5+4WHlkC413PkEVJeRjHUz9JJ8qoTf5Hwuh7kvkzi4Ka5Cgs7lNMHIdJP/oUmiYD0N3L5bLZ63XaBeHU4R9uuXZhJr/tnJdA1sF3d12Hy85mJpsrEWLi8ho5hjgimbaTL0okaANOWZfTmpEthxO4421QWUJ3NYb6G/cbf6zKUL8t2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3957.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(66476007)(53546011)(66556008)(66946007)(44832011)(5660300002)(38100700002)(110136005)(4326008)(6486002)(508600001)(2616005)(956004)(186003)(4001150100001)(83380400001)(2906002)(316002)(16576012)(31696002)(86362001)(31686004)(8676002)(8936002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFNlOGlyeWl5SjNDaDdHekR6eWV0MXFweFo3Nk1YV3BvaTViWmx2MWlocE0x?=
 =?utf-8?B?TExRWHN5Nk1ZdHNGcHppYTM3eGVINHRGSWZ0WjZxQktncjJWMElIYXFJNmlD?=
 =?utf-8?B?aTVJTlVERzc0SU9VVGNyUkRHaVp3cURNSXhZMmVVQitMTjZYRFd1a2JyaDZP?=
 =?utf-8?B?ZTEyMU5PMVY3NkE4S3F6NVlHSUNCZnBhUGFYRGhjR3FaQTE3cFFUSlZJZ2hI?=
 =?utf-8?B?YlNFT3E1Y2czaXdSRzBNZmpMWldRdW54MkhUc2ZrblBhSUpFZGRCeUQrdHNT?=
 =?utf-8?B?bEpCLzV2bEJubGgyUXRZZzZVY04wZ2RvZmUwbUJvVVREeUd5dTlEQWZEU0Jx?=
 =?utf-8?B?aDRMNytFK2xPTXhxM1YyekNVMmo3UnR4a3Q0clJxdVR3OENiTkdZbTdIbnFk?=
 =?utf-8?B?KzFENTRnNUVEWE9XWFFJenRPeHBlWDJnRHlhbVZPSmhtbGdXdVRRdFZ0dmpv?=
 =?utf-8?B?dVhwcWRXNXYyNHk5RlFXc3pYT2YyQXBuanl4SmV3WTRpYkJQKzZ0cDJXNkt4?=
 =?utf-8?B?Y2NqdHdWWGdOVzhrSFZSRXVXZHY0cExzaHBNK1ZrQmhQdzAxTDhjdDkrMTQ2?=
 =?utf-8?B?akRnU2VnMTR2MkRQME54YTR2QWNQZGRSa0Mvdk9Uem1CQ1k3bGtrMGhkTkdZ?=
 =?utf-8?B?bytyTXgySWNBQ3dKbzF5eGVkaTFRQUhZUnFMTU9GWWhIVm5PZjBxOTBNOVZM?=
 =?utf-8?B?cUZ0NVo1RFpTYU5pZjB1L0JQbU5hbUxXaGFwTTR6blpPdXhuU1pmbmpDbUgy?=
 =?utf-8?B?UzVscTI3bDVFa2IvR0tySWdVUSsvTmY0dGl3RzlJSUo3OVZTZjlWNlh0RlAr?=
 =?utf-8?B?bVlVQitHVG1MeCszTDVqSk5RWTN6ZzQyWFlFVmJYSUEwVHUzUFg0bEJjc2xM?=
 =?utf-8?B?OXlBR294SnV0MnVBdDRIeUNsVnNZVnNRb0xWcEtucTdXcXVyWkc1cURkMzQv?=
 =?utf-8?B?WitjNVJNREhtSlpPR1JGRzRFUERvbElIN21FanNHa3I1YUMzUERiMDRwWjFU?=
 =?utf-8?B?bUYwMHlkdTdEVFhmeTZmdWx6TTROdFRCSFhvZnZaa0NDTTkvWTZSRDJEWDFw?=
 =?utf-8?B?eW5qeUI1VDRjeldKaTlFSDZwS29CWHFkU0NMeWxZZENhRnpIQ2NFd09IRWYr?=
 =?utf-8?B?ekpuSTJYN0VWS0oxRHF2L3lQYzdRVG1TMUlLUFIwVUhXc3F6NVh2NCtNVzRr?=
 =?utf-8?B?OUN3Y0RHbWVnT2tVSE4vZjVHK1MzZG1wY3ROc0hVNTZQbnFqLzJpbnNudHk5?=
 =?utf-8?B?MUdmRklpazhvL3ZaNUZuL1U1VHZ2RSs4NU9JbHRXSzdLRXRsNGQ5UmdaSXhG?=
 =?utf-8?B?NDF1Sm5QaEsvM2d3Y3BqZVR5dGhLUk05UGJvNUVNcHZoUUNDQ0t1TzIxL082?=
 =?utf-8?B?OFQ3YndWSTcyelNrbHRqeFRmaUlnVk9nUE8rRmdxbS9tU1N3OWZ6SWRmWElh?=
 =?utf-8?B?cTBDakNXb0F5cGsyK3oxWUpkWUU3NzJmTXV4TDB1bUNmWldlWEJmUG0zdFBo?=
 =?utf-8?B?bk5jaENTN0ZsRkNxRk5SbjhLRXhLWXc5L1d0MlYxK0MyaVdoK2diTXAxaTZh?=
 =?utf-8?B?UHZtSHY2bTlHOENKRGtPZmM2SlJYbVpWVTZENVZUWEswbnBrNXZSWFk5MmVs?=
 =?utf-8?B?d25VSXJ6MURzYlRmdWhFU2EyUjUvZUlKQXJWT1Q1L1JlWEQwdUlKeDZmOHQv?=
 =?utf-8?B?M1ZXWTByaXg5ZytGVFRET0ZOOXRwRzAyenlFSjBmUEEzUVJFcFd4bG1sYWQx?=
 =?utf-8?B?cEhRQlF1emduSHdsVW8yM0gvWktJbEhOeUZ4L0xFYXArVEJZYXFKNlVxcU94?=
 =?utf-8?B?YXJuWGpjdlcrdW9lVndJbmJMUlMyZjZreXBJbGdmU0xqa1EzaTBEQXZMc3Mw?=
 =?utf-8?B?d2o2eXhNZ3Zrc3lqTG92N3pIQVRuVTFabmtUZDh6RWtnWXBNbDFQL2xGc2hT?=
 =?utf-8?Q?Agr+vMt42Es=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0c0079-07e4-4c33-bb26-08d994b2beee
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 16:49:27.9391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ltuikov@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4647
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

On 2021-10-21 12:47, Russell, Kent wrote:
> [AMD Official Use Only]
>
>
>
>> -----Original Message-----
>> From: Tuikov, Luben <Luben.Tuikov@amd.com>
>> Sent: Thursday, October 21, 2021 12:45 PM
>> To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Joshi, Mukul <Mukul.Joshi@amd.com>
>> Subject: Re: [PATCH 1/2] drm/amdgpu: Warn when bad pages approaches 90% threshold
>>
>> On 2021-10-21 12:35, Luben Tuikov wrote:
>>> On 2021-10-21 11:57, Kent Russell wrote:
>>>> dmesg doesn't warn when the number of bad pages approaches the
>>>> threshold for page retirement. WARN when the number of bad pages
>>>> is at 90% or greater for easier checks and planning, instead of waiting
>>>> until the GPU is full of bad pages.
>>>>
>>>> Cc: Luben Tuikov <luben.tuikov@amd.com>
>>>> Cc: Mukul Joshi <Mukul.Joshi@amd.com>
>>>> Signed-off-by: Kent Russell <kent.russell@amd.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>>>> index f4c05ff4b26c..ce5089216474 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>>>> @@ -1077,6 +1077,12 @@ int amdgpu_ras_eeprom_init(struct
>> amdgpu_ras_eeprom_control *control,
>>>>  		if (res)
>>>>  			DRM_ERROR("RAS table incorrect checksum or error:%d\n",
>>>>  				  res);
>>>> +
>>>> +		/* Warn if we are at 90% of the threshold or above */
>>> The kernel uses a couple of styles, this is one of them:
>>>
>>> /* Warn ...
>>>  */
>>> if (...)
>>>
>>> Please use this style as it is used extensively in the amdgpu_ras_eeprom.c file.
>>>
>>>> +		if ((10 * control->ras_num_recs) >= (ras->bad_page_cnt_threshold * 9))
>>> You don't need the extra parenthesis around multiplication--it has higher precedence
>> than relational operators--drop the extra parenthesis.
>>> Regards,
>>> Luben
>>>
>>>> +			DRM_WARN("RAS records:%u exceeds 90%% of threshold:%d",
>>>> +					control->ras_num_recs,
>>>> +					ras->bad_page_cnt_threshold);
>> One more note: The code uses "dev_err()" for this very similar message:
>>
>>             dev_err(adev->dev,
>>                 "RAS records:%d exceed threshold:%d, "
>>                 "GPU will not be initialized. Replace this GPU or increase the threshold",
>>                 control->ras_num_recs, ras->bad_page_cnt_threshold);
>>
>> Since your message is essentially the same, sans the "90% of threshold", perhaps you want
>> to use dev_warn(), instead of "DRM_WARN()".
> Agreed. Lijo had a similar comment. I may follow up with another patch to change all of these table-specific DRM_* messages to dev_*

You can still do that, but for this patch, make the changes I requested and change this to dev_warn().

Regards,
Luben

>
>  Kent
>
>> Regards,
>> Luben
>>
>>>>  	} else if (hdr->header == RAS_TABLE_HDR_BAD &&
>>>>  		   amdgpu_bad_page_threshold != 0) {
>>>>  		res = __verify_ras_table_checksum(control);


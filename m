Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8451DFC6171
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Sep 2024 18:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1971610ED70;
	Fri, 13 Sep 2024 18:51:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3sFVwswM";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9C3910ED70
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Sep 2024 18:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x66Nc8ElFTHDJI0ySOQkdD0CUHG/CqJn5KeOvPrzBVhap+u9IxqC6gFpHbu5xC1zwm9NZhOoC2+V9nyGngmJpBmtD80d+uqqRyuoNZzWS+K6yJ6rRmtZKJiZBkRGDL2HtA5P+vqIiuNk+y8Ht0zdXQb0bFHIqoShZV6LnWfmaWw4aY/geOrmQ2YWfg3SJ6Eb1FTeXW1LWijcGudcxRJCoxV++gg2YDhlZnXLXewhLDRhHG0kGguLMGKcOvZTMUEh5dS8W6f1+J0Qv2vS836ygj9H+0jBT1hTLPLgv1sbYyAYh53azMYE1dt1UWIqXAbJVFvAiNyjcFSg1UKMdEb7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1qHfl8pQ4wpik+Vc6XEtdLLfobrnQEwii2ooY+s4JE=;
 b=bJxOqIDpnENkCWJ8fiRq419qOaYoVvs5Z8nUm5aqsDv7kpdFC9jldhh3w0dxzVXwHC7DUOVKpnlqNU4J2UTOZvB9MJnc3r1Q8WA7IXEmEUS/idN6lmNCqcVV3mAE+Q+9mXUgVBG8eOWGKvOFdkcD+JG/6J1wX4wTKUVu1hFKGrSvx9BDd1SBBkHyEPtrM78K3zSP/wbNxD/b58HeYFlKt0xW9cbKiKWKh7v1zPHwXSTjiWUO5umoPuUWPNJ0CtLAlifcZCybem+6WCvBpR4ufCcfo+eFsr1cjhVexnICLRP13Wzhy7MJ+bemW1O/54kDb8qyGztj6U2CbfM8T6z8ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1qHfl8pQ4wpik+Vc6XEtdLLfobrnQEwii2ooY+s4JE=;
 b=3sFVwswMbyxmqnIeIX+36uQiZZgzM3sSr2n5v0SWzJBV+SYvtj91iBcXORgDy3++2r8CiUP4dIZKtWsHpMLsZl/2v2Rpr3KEorg1feA3uzQYk5HbSzP5PAjNEqwUVDjcjXeycXd+GsLsCytbGRn7n5FrJSngYjiypKZ4do1hdLQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS0PR12MB7777.namprd12.prod.outlook.com (2603:10b6:8:153::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Fri, 13 Sep
 2024 18:51:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 18:51:38 +0000
Message-ID: <04ca46bd-c734-4fe8-9244-bbc138b55b57@amd.com>
Date: Fri, 13 Sep 2024 13:51:37 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Validate backlight caps are sane
To: Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: amd-gfx@lists.freedesktop.org
References: <20240913180039.38146-1-mario.limonciello@amd.com>
 <db78e83a-6b4b-4d87-a2b7-8a2a912e63b2@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <db78e83a-6b4b-4d87-a2b7-8a2a912e63b2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:805:de::49) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS0PR12MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc2d65f-d40b-4d7d-681a-08dcd4251971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tnd0OXFZMkxCZjlNd01oeWtRSDYveDgyVU5pemhjQ0FWWWE0ODRKSG1sUW1x?=
 =?utf-8?B?Q1l3Y1I0cGpQVngvODJMazNGcjhOV3NqV3NpazV1aUNwVm9HRmtOSmlvTmVx?=
 =?utf-8?B?REhtVU1OUXQ0SjVQdW54R24zNmJvWGF6a0x6Y2l1U3NhejRMK2xoVFVGbG9m?=
 =?utf-8?B?YnhtOVczYkhIOWJxRW5YeStDa3YzeGNOa2YzLzIyeUt5S2t0TGRrcVhrYi9N?=
 =?utf-8?B?UWdONXhYdDRhSnUvT2FnSjJSbEI4V0hjVVppdm5SbFRLNDVaNHY0WWZLNW9N?=
 =?utf-8?B?WXRhUmpSZ0lsNDVvZUw2T2pBNHAvaDBTQURXcE5QRENNcnpMWUMxY1hpYlhk?=
 =?utf-8?B?VkhlOHNWdG1uUXhqWTg1aWxlSExpQXhCdVFWeUpqRWRTa21UTTFGOGk2cjRx?=
 =?utf-8?B?WmNmWVMrclJpeHdtd0IzUENaZWZQTnpjUE8wOVNkWFlyaVJJeXJOcitsdjFL?=
 =?utf-8?B?RlgrUlhUMWxtOTVDWXdzV2hqQlNHQWxkSUlDRVVRbjJnUVVndzgxSFZibmUw?=
 =?utf-8?B?eEpzbXZqTUFudFB4dVFsdmJyUklxSm40ekw4QzFSLzlYV1ArOE51TEhRVG5u?=
 =?utf-8?B?endYVUNGaDd5MVFXNkh3alVwZEFLL0RLa1MrNjRtZzRheHVVQ21Nc3RWb1ZY?=
 =?utf-8?B?ZjAydXFBSFptQ1VaL2JkMk52ZVJ4ZnlXeVNwdVBVK2ZBV3p4RDBFQWVjdUlL?=
 =?utf-8?B?WVdQOWVBeXZsa25ZV1h3aE5MckhuZE9CeDkxY2djVDlNY0ZOcVBxSnpUZUM1?=
 =?utf-8?B?bzNlYlcwMWZnMHZ4b2V3WXZJMGtydEw3QUwzMFowcVFlRDhCSzVQcDllUjJY?=
 =?utf-8?B?WlY2Tk5ycTVEOGk1Yjl2SjJxcHpYTkt2VmdrK3A0dlIwTFU1ajVCY0ptMTJ2?=
 =?utf-8?B?VVNoSVpPQmlxdFZDN3AxcW5pelVIN1BLdm95S091L3puMVRlb1BBT2tUYXNn?=
 =?utf-8?B?enczNXowd0g5Tk5jdWhmZFBIeWkrc0tRSFM4RzhOZjFEeWtZLzl5TlJPeEVZ?=
 =?utf-8?B?aCtURU9nblpZNWROVWJYM2h1STRDU3lmQjB6VXI0NkEzMk00VVRudDY5SVdp?=
 =?utf-8?B?K0dmTEJ0b0xjTHFPd0VXbERyNjZkV3RvSC9tZDVGVTBVdlE1cHB6ckVzcUlC?=
 =?utf-8?B?SWdNZlMwQjFMaGdjSVBVVU0xei84bUFyZFJybEdXMUtyYjZ2bDBXM2Nrc0p4?=
 =?utf-8?B?UlluOU45ejJmR2tLOVdjd1hKYW50VGl5OXFFOWhwRWhkMHVoYWFvbTBXc3pi?=
 =?utf-8?B?YjdycWRCQTVDYlE3Q2J4RkpRUjczUGtPMGE2RU9CNjNrM1c5QjcwNlZmcUND?=
 =?utf-8?B?b0M5dlc4NEEzaG12QnJBdTRYZXZwMFk2RHExa1pVNjZnMFcvVzJpMnZSRWoy?=
 =?utf-8?B?MWVNNi94dXlmUEJTYTdkMGpKQUtpTS8relFyTGJqUTB1VGxJNkhYbndIdjlM?=
 =?utf-8?B?U29sdkwyYU9BUlJVSEtZaC9FYnpUUDIyRlFiaHZBODVOd2lrYnJwVFVZY0xj?=
 =?utf-8?B?dDgvdFZ1VDBBNndTY3lkNGR4ZlZXaDBZYisrYmY5WC9EN2tXT21LdFFYY0RJ?=
 =?utf-8?B?L1RKRGVVVTJxZ0VtWGlnL1BZQ0pkK1RMaGl1RzMrc25NcVBvRjNTZ3dZMEx5?=
 =?utf-8?B?bVlJdHFPc3NCT3krazNkb0RnODJFZlhkbzlhYjRLTFFuYm1ZUnhZQWtMN0tC?=
 =?utf-8?B?VDdLYi83a09uSlQrQjR5dnNQVXQ2RFRNRGx1NTJmM2FZOEJWVGR5aEFhemR5?=
 =?utf-8?Q?p7zhr67+dsnwOFkn2E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXRuejg4eXhLTGE0OGYza1pBcmlQTmhCZHhUTXRFOW9ML3I1RHpEaVFVZVkx?=
 =?utf-8?B?WDI2cmZGbWx2MGhpMmMyK1hpc2Nsd3cxT3R0OTIxdGJ5aGNSWW5ISXFqM0Jq?=
 =?utf-8?B?S2lCREI5L2RFR1U5Q2wrZVBhTEthZjlSKzdmOEdXNlU4S3ExNkFscUxHZ2dy?=
 =?utf-8?B?TEIzQWRIOHdjNHZQYXMwUnRwNEhFWmFhM0s2MFB4VWhScjlac2g0aVRSVm9n?=
 =?utf-8?B?Vm9mUkhnVVpTMGRKY2M1NlFrMXRQNWRhY2d5TStIblN6TWZCUWptbWgyK2l3?=
 =?utf-8?B?bFE3QUZoaFJZQVl0TnUxSStXVWkwNU1yamhtR0RIS3pGRm5Oc0NOWDJ0a2lr?=
 =?utf-8?B?NHdsSDJYNE05WDBnUDBWWXo3eFFKVzhvM292dFhDM0w1SkdKbDVzK1FCeUt3?=
 =?utf-8?B?b0c2UTNDZFhEY1VuKy9NMldqNXhONzFVYnNqRVd2RXdDdnM3MEE0YzM1Mncy?=
 =?utf-8?B?Nm9EeU1UZUcrTHZiTjl0dWh4VmFkcXZwK2FKM25uMXJ5M2ZMcnhjQmRuSHQv?=
 =?utf-8?B?L05EMWx3SGJvVjloQmJnMmZjTHBmZFhVQTJrdjRHenlxTzhiZFBzVjVQT0ZK?=
 =?utf-8?B?cGtNRU9lcWlEUXJYcXBlUHlOUDZuMHFyallhTlBaenNLU05OWXh4V0l0UTdW?=
 =?utf-8?B?UTNZZWtTdXpkZFBwK0xidU1LQ0lBbnV2elE3Y1ZwK2JDOWdhbnJHQmluWngw?=
 =?utf-8?B?MjNybFh4TkZMaVZvQkp0TXhzdzY3Y000dzF6UGk5c3VQMXN3UlFZcjluazI1?=
 =?utf-8?B?L0pLdkNVYlQ3LzdweHRVbjNScGRHODRJNU81aTNyV3VNSXgzMXNnckxDWFBY?=
 =?utf-8?B?YjBveURJN0Y3ZzRWcjRQTEdoeWhzTUF3c0xQcGoyejBadDljOVZxZDhGV2ZP?=
 =?utf-8?B?aXJwQVNaNG53RFBBZmZHQnFKVkxta2JySHhHTlF4MHAzVFNXalFzanE0aTVh?=
 =?utf-8?B?cGlLOUZBWmllWFVsVEJWbnNpbzJyQ1JneFVPOTlCZjJnSjJxa1U0WFdWblBi?=
 =?utf-8?B?STR4OGZCVmNVUjR1VWIwcGtuRVlLU1VaYS90aFRSdGVxZFJWMkMwMnA5a2k1?=
 =?utf-8?B?eGFYMHM0WUNyU2d0MHV6YmNlNStvZnUxVGlSUFpPbTc5S0hZenNOd0EzRUFQ?=
 =?utf-8?B?TkUzWU9TTXFKbVF6NWEvODd4UXUzM0pITXRzMzRPM3lZeWRPS3oySXlZRDk0?=
 =?utf-8?B?Z1c2UEJqN1krRWV3dVlTb0dEdnJNZDN4RUVJTXByRCswampYa2ZndHNUaEs1?=
 =?utf-8?B?b3ZURFlNYjBsYUVBWUlvS3Vhbmg0MzBIMDl4RXFiZ2s1V00xQ0NRMjhIbnpz?=
 =?utf-8?B?d0N5Z2V4QUpqclAwZ1lyOVdseWx4VnludG5Ra01xZWpjdHEwVWdMUFU0TVVu?=
 =?utf-8?B?aDlOckh2ek95QjFva0lYRU5LckZuTzl2bGlSYnZIMnQrTytCK0RMcmRvSHJw?=
 =?utf-8?B?TWVJU0dhT0NtNEZpR0tyNTNZSE5PVlZPM2hZbXJwVEdyczI1WVRFNzRUTmhm?=
 =?utf-8?B?dTBrWEE5YTRrdUVFRVVZY3FJdkg3bkJUM29RQzhaWnZkQlRsNmdWNW84NVlB?=
 =?utf-8?B?azl5QTE3RUMxVlI3QkQ5VVlWYjJRSThGTlV5T3g5Q1NXYjZOeG82NW9ZYWdJ?=
 =?utf-8?B?amR3aDBjVThoM09NdklRMkxzc3VjaS83T0pYbjhaYnlsQUNQK3pBaW5nN0tL?=
 =?utf-8?B?UStjbzVXRkdMWGlLMlZGK1Iya3dUWDFZZ25LTnBCQ0ZsbXFpQnVRQmZnbW4v?=
 =?utf-8?B?ZUo3ZTAwSWpQSW1CdnMzUzdEVUgvWXFFb1pmc3dLTmRmR2Izd1k3ODhIU1Y4?=
 =?utf-8?B?WTh1SER5VkpSR3ByNTlLYTBLMkY5eGxyNk81dVQ0d2swSTJsZktWNm0xTk5B?=
 =?utf-8?B?QUZXQlAwOHZva3FrZC9YOUtxZnpBU0JQMjkwNmwzY3NRa05vemJBOHFWei9O?=
 =?utf-8?B?OUNUdm9CbzNMQzVzWnB6NTlmTXBYOVIrak9oT0w1bjFOMy8rQ2g4b0hJR2dh?=
 =?utf-8?B?Mk9ESGhyVGJPNk9Cb2twdGI2a3Y2a0pibEFwME9LdWFVdUJrQ1JJVWdaL2V6?=
 =?utf-8?B?a2lMYXFqdGZBTHZIQUxVY01CNG5lcDhneEdOL1ZxNXhTdzNhUHNCdWtVd3Vt?=
 =?utf-8?Q?zunw59YPHyL+AMrv+yzfHDKcU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc2d65f-d40b-4d7d-681a-08dcd4251971
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 18:51:38.7167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAtYeNWQpckKnskmWVBpBfO8lgg0rdDD3cSnStwCeYvE2J3TZ5DQjRgwpcECQj6K3fz3trivQ5+CKb5W4IJXtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7777
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

On 9/13/2024 13:47, Harry Wentland wrote:
> 
> 
> On 2024-09-13 14:00, Mario Limonciello wrote:
>> Currently amdgpu takes backlight caps provided by the ACPI tables
>> on systems as is.  If the firmware sets maximums that are too low
>> this means that users don't get a good experience.
>>
>> To avoid having to maintain a quirk list of such systems, do a sanity
>> check on the values.  Check that the spread is at least half of the
>> values that amdgpu would use if no ACPI table was found and if not
>> use the amdgpu defaults.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3020
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 5942fc4e1c86..ad66f09cd0bb 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -4428,6 +4428,7 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
>>   
>>   #define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
>>   #define AMDGPU_DM_DEFAULT_MAX_BACKLIGHT 255
>> +#define AMDGPU_DM_MIN_SPREAD ((AMDGPU_DM_DEFAULT_MAX_BACKLIGHT - AMDGPU_DM_DEFAULT_MIN_BACKLIGHT) / 2)
>>   #define AUX_BL_DEFAULT_TRANSITION_TIME_MS 50
>>   
>>   static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
>> @@ -4442,6 +4443,21 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
>>   		return;
>>   
>>   	amdgpu_acpi_get_backlight_caps(&caps);
>> +
>> +	/* validate the firmware value is sane */
>> +	if (caps.caps_valid) {
>> +		int spread = caps.max_input_signal - caps.min_input_signal;
>> +
>> +		if (caps.max_input_signal > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
>> +		    caps.min_input_signal < AMDGPU_DM_DEFAULT_MIN_BACKLIGHT ||
> 
> Would we still want to allow signals below AMDGPU_DM_DEFAULT_MIN_BACKLIGHT
> (but above 0)? The min backlight value of 12 is a bit conservative and
> I wouldn't be surprised if systems set it lower via ACPI.
> 
> The rest looks like great checks that we should absolutely have.

I'm waffling about that one because Thomas' testing showed that there 
was some problems with panel power savings when he quirked the Framework 
panels below their ACPI default (12) in his v6 series of the Framework 
quirks.

So my thought process was we should put in an explicit check for now and 
then when we have panel power savings working without a modeset landed 
then we can also add code to the backlight set callback to turn off 
panel power savings when set below AMDGPU_DM_DEFAULT_MIN_BACKLIGHT to 
prevent the issue he found.

> 
> Harry
> 
>> +		    spread > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
>> +		    spread < AMDGPU_DM_MIN_SPREAD) {
>> +			DRM_DEBUG_KMS("DM: Invalid backlight caps: min=%d, max=%d\n",
>> +				      caps.min_input_signal, caps.max_input_signal);
>> +			caps.caps_valid = false;
>> +		}
>> +	}
>> +
>>   	if (caps.caps_valid) {
>>   		dm->backlight_caps[bl_idx].caps_valid = true;
>>   		if (caps.aux_support)
> 


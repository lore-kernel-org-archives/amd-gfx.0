Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2064DC54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Mar 2024 05:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A246810E0F3;
	Mon, 11 Mar 2024 05:49:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3Qmd5LrN";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7523410E0F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Mar 2024 05:49:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YoQgxaGe4PFDz0NDxY+0KwkXwG6wW5hEIkz5dTVuPiZueew7mpdqZ7efkQzpigXjoe+u7vwIvXdjooAdDk1AbS3/c2rt/EG503FyfpXXhJ+446ZyO01Yk9LvttaWM7htwIhke1UAzrtW0iarPmq6MKzk6o43OMsYKNNLOpYpONQNkLjYhxFSCb/dLzpbk6XFmcrG8NeoF16eCxySjAfnkJTaVjA68eT+5fJvifKPiv4n4sqWcy/tJD9t1BZ5/EMwznCPjTKPsYVzzUqYGw+M18OJh+PptDidEROr5q/CqXzLmLjph97GqyFZIpcdhKNnzv2c9uDoc3ZptrlMxAh+yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SqZ16/OX4E44tzqiAsE2DHMxTcia9J8bSRgU+Iof/EQ=;
 b=RCNJ+EE1TnXFBIHc+/9Qdu4+/NDI7oIMRIJem3hLzMATDrF0O//0asQU3GaKHbly/wR+lvbjBEauKisgqR4NB9oQvlhSHZhpDdyZeVX6ogljp9Y0pnavgVXLas2YrG9aBe+iHz9TJhndhlcaNC5p+yN10r7DVSD14RDXLsiYYTRdTbTobIt87/9z7l5AcGR5HtK7vzsTKHjUnG9nwjmUHi7y0oBAP3jN1LwaRXo94ok65pOynpu6dnaBt3kutT/dYSPydK0vI4WcAU8oOiJriv4lcHOcObbrnNqDP9IDRc2Dqv4z1WmjhNIoRB/UXf4C+BdJWv1ONadPdVxDoaB5wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqZ16/OX4E44tzqiAsE2DHMxTcia9J8bSRgU+Iof/EQ=;
 b=3Qmd5LrNBZ26le02H34Sq4kY5lcJ4q2BRAcT8nRxHw5i0gFzDhf6SFRYs0z7B962kVr8LE/cDPWW0HjcVfcjU21nh7X/2WEIrKgXDZF6FejeVJJVyeGqi62Dp4sCRsGixc2QXFSFqhRVUTEOug5S0fhDumyDRqK7lWQqHhcgfKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 CY8PR12MB7268.namprd12.prod.outlook.com (2603:10b6:930:54::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.35; Mon, 11 Mar 2024 05:49:33 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 05:49:33 +0000
Message-ID: <00160e7a-2781-4285-b4b4-3fba14fdf10c@amd.com>
Date: Mon, 11 Mar 2024 13:49:22 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com, Kenneth.Feng@amd.com, Alexander.Deucher@amd.com,
 kevinyang.wang@amd.com, Yin Zhenguo <zhenguo.yin@amd.com>
Subject: Re: [PATCH v2] drm/amdgpu/pm: Fix NULL pointer dereference when get
 power limit
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240308095140.2221137-1-Jun.Ma2@amd.com>
 <9f3c2e9e-7c9c-4b8d-9e90-58a0d9bfa87d@amd.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <9f3c2e9e-7c9c-4b8d-9e90-58a0d9bfa87d@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|CY8PR12MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 0257c804-bd77-427c-91a6-08dc418f06e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nCCICwb6mgWP0NE521UUfB3lAFOqxnxc6FVEHZbhBG9T9rzbXZYeFQutvVtXiQdfBMKxijLwBm8X4cQRW26YEGgdnSYzp1I2J9c2Yvcxj/XsMpO7rnImzGX4tX53KPAcq5fdodQq+HPATsvNotmJRjEZ9rAvyEvVA7eOqj+NDuDFql22wl9DUWeO8yUsk4NwkIOfCV8eFi3KVbWix+Gmdby/S+n7CCK1neCsiihZjCx+ZEldIz1+SHwcLQRM59VeJbj7Z2uv9E2jMxhz7zx+g7bxyC5od59lmnn+f8GGr1e9VbPhpVx3I0370Abw8bFdouYpSkiHwAN9F1r70agDa3NJp9e6crDSSHq8SXSntebSjqCUQPACwivWjzrrPYkWY88GpCZQj2DHVrvzMv0dSkdhqFXUiMSOgAx9SHOQHUWMjh7D2ARkWSZ7MoB4Bz4QN/zMhDk/WHGe13I2Uf8VzriWHjORU01iUCrgl1KwHjdNhPh8Bk+O0w/x1M6uj2aIXDHGW77K0GNEQ7iVASvZF3m8efb3AV3zHqGRmbEw8sRjvIoZrXYwT3xQz3pf65Poks0xLIvTNVDDAg+iwMfFwSZ7t9vN8H9YLHkN2X8E1YFTInpK3KsxWdqXlkSORVc0dyAPTBeO3mTvRyU0ulvK1mk80amgWAi7Zk3j+EgjLa4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGkzOVBXNGs3WkFXNVl5R1dqS2pIY0VpenVVMU9rWCtTcFhjQWJQSmF3clFz?=
 =?utf-8?B?QnorRmVoWXdQZDgvaGNnUEl1SWJ2VmxGL21uczRYQXlyUmVEN2J1VXo2MTJn?=
 =?utf-8?B?a0N4dVB2QTZXdmJtNFk5dTJrT3g4U3JhZEZrRHVvVE1aTHBYMlFYSVcxVUhP?=
 =?utf-8?B?ZmsvK1Z2K0ZkVDFkK3ordDlIT0UrOUcyUjkyNEM0RkpzaFJvbXd4Q3BOREpG?=
 =?utf-8?B?bDlpUXVHVXFZT1FQQk56SFl6Q3FXeHhHSm5vVDhDMFBSUXJpckV0RW9YNVlo?=
 =?utf-8?B?Z3N1bEpxQzlITXpDOFEzazZnVUh3L1Y3TFhidndRYll3cE4vcE04TmwvS0Vv?=
 =?utf-8?B?eVY4VytWNzFHYWY0WUZrQzFmT3RtVjVMQnJhT2ZZREtPZUZPNlcvNEJnaWJk?=
 =?utf-8?B?U0lFakxtUmhONkQ5aUVBT1JTZTgrQ0NuMlFOYUw3K0xiMVNoenRoWlhnV2Na?=
 =?utf-8?B?MUFoWVV3UTdhL2duNEx3WXVYNm5XVTc0NFM0TEh0UmhFMnYvVU8xTlFWeFUx?=
 =?utf-8?B?VkVMZUI0cFoydGZDSExic3dtdUxVZDBKemc1Y1g0enVkY3JsYWdzTkJ2OVFR?=
 =?utf-8?B?QTUvbnkwUzh5elhQeTFMQkVwK0pVQmo3SFAvSjRkZnhPOU1WL2d0V2QyL0R5?=
 =?utf-8?B?NmNWMWMxVWFBajZmd1FGWXZtL3R5aEI3Y3BxeklkV3ZFL0J0V3IxN1N4blZR?=
 =?utf-8?B?Rkd4YUw2SThBeEVwVitOWVRMTnhMbXhxZGhsR2poMzJFb1dxSHVhWnduRmF1?=
 =?utf-8?B?cTc5WXVtNmNOZ3pzNGRmc3YzU2pMbmFUb2ZCWThvT1A4Qmk5SDFJMzc4bWI1?=
 =?utf-8?B?UVdJM0FUV2Vhc2RVbVVxWmFlWldmWVNyQS9EeGRybnhmOEkycmNhQmpJKy9n?=
 =?utf-8?B?UFBLNWNBZXJVVy92WUhaaTl1MUMvVzE1blh1V1M3WEtxL24yRmF6aWVTYlRo?=
 =?utf-8?B?MnVWb1hOeExHMSt3bHIrcUZsV2lFNDhJdmw4OU9GdUNSenZvaTFWUW1FRVVQ?=
 =?utf-8?B?dGYrR3JxMG5IaHJaSlNQU1NGb1lXMG9neE9ta2M4WTF0MWpYdE5wRDdjWkI5?=
 =?utf-8?B?MlJxWVh1dDhCQTdXSllCWEdMM0pNMDRveXl1Y3lRdy8xUlFMbEVBenFDbDZw?=
 =?utf-8?B?SG5xa2Z1RkZRYTBJWXdhcUtpdzJ0WDFZNmswTTRoV05aMWc4UXBsNXp6MVUy?=
 =?utf-8?B?Z2RGbUhpZ2UvY3pnVlJSNXdQeDZyT3oveUt1R0pIZjJBMXhhTktnOU1nR0Uz?=
 =?utf-8?B?cjBBbFZ1S1hzV1BEVXhobVBEeWlTZVpmWFkzSFhKQVU4MHhKQXF6NEpkMlkz?=
 =?utf-8?B?MVZlMVlFYU14QTFIQUZZYjd4RERZcDZoMkh4YnQ3NVBPbVRYekwvWEJvc25n?=
 =?utf-8?B?WXcvTjRkY0JrVXpLbUJKMmYyTEFISUJHQkk1Y2xhYWVsOU5mMDRDbDkvRzYv?=
 =?utf-8?B?Q2lNWFp5anBSRUdqWE9XSVNSMFo4YVhCNXRrUndlZWQ2U3hCNU1BVGpzNzdj?=
 =?utf-8?B?cnphRWg4QXVOWmQvdGphZ3o2QW5tQzR3OWVHKzZ0TlovMWNRSmF2OE1OSTdx?=
 =?utf-8?B?UDZaZFdzKzBXaThpU2lxYjE0a2xKVnZ0UHQ3bnc4Ri9FdzB2SkxERjI2TTBF?=
 =?utf-8?B?OWcyS2pueWpETERZL21FcWJObkdFZTJQMDBaY2RMWXZ5Qm5GTGtheFo2bmdh?=
 =?utf-8?B?WkFMODV2ZXdXQTRhaFQxWmdoMG4wWnBvUmJqdk5qOTZXc0lyc2hpYk4ydkNr?=
 =?utf-8?B?b1Z2bWgxVG5MMW1vMWNDVlhiRHk3dHliT0ZLd3QwZUVRL2VkN1V6Y25Ld0JW?=
 =?utf-8?B?bXcvYTdKWFF3T0hYVlNVUXhyNXVhNnJUTTY1MHZZOWFIWnpjekN0bnBNRUV4?=
 =?utf-8?B?eVpkOXVncUJqcmxRYVN1V1dKSkR2bTdDdGkzL28zYXM1Sk1rMVV5N05BYnVW?=
 =?utf-8?B?VmlVYTFnUWJsNXNuZGxEL25yL1dHSDE4Ti96Q2xIMHNYZ1NqdnVJcXhwM0xM?=
 =?utf-8?B?TEhUYkMzSDBnbEg3NTlxZ2lkL3FhU1RsRnNPOEhCVklwSThTbHVya3VyZFRa?=
 =?utf-8?B?VnNPaFYzUUw5Zms1clJqNzF6eWtZL0Vvd05zMk93NDZtWTJNN0o3aGNGWnBn?=
 =?utf-8?Q?IVwoXaylREv5IA46p+2/85lYA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0257c804-bd77-427c-91a6-08dc418f06e4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 05:49:33.3422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ClGbk/igV7QpWmeBsOQCRqkfMBT+czpH52XQBH+Uez/EN9pU15d/4COO+9w3NYTD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7268
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



On 3/8/2024 10:00 PM, Lazar, Lijo wrote:
> 
> 
> On 3/8/2024 3:21 PM, Ma Jun wrote:
>> Because powerplay_table initialization is skipped under
>> sriov case, We set default lower and upper OD value to
>> avoid NULL pointer issue.
>>
>> Also, It's necessary to check od capability before
>> using the power limit value from powerplay_table.
>>
>> Fixes: 7968e9748fbb ("drm/amdgpu/pm: Fix the power1_min_cap value")
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> Reported-by: Yin Zhenguo <zhenguo.yin@amd.com>
>> ---
>> v1->v2: Check the od capability (Alex, Lijo)
>> ---
>>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 18 ++++++-----
>>  .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 18 ++++++-----
>>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 30 +++++++++++--------
>>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 22 +++++++++-----
>>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 22 +++++++++-----
>>  5 files changed, 68 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>> index 1d96eb274d72..862d5d198f42 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>> @@ -1285,8 +1285,9 @@ static int arcturus_get_power_limit(struct smu_context *smu,
>>  {
>>  	struct smu_11_0_powerplay_table *powerplay_table =
>>  		(struct smu_11_0_powerplay_table *)smu->smu_table.power_play_table;
>> +	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
>>  	PPTable_t *pptable = smu->smu_table.driver_pptable;
>> -	uint32_t power_limit, od_percent_upper, od_percent_lower;
>> +	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 10;
>>  
>>  	if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
>>  		/* the last hope to figure out the ppt limit */
>> @@ -1303,12 +1304,15 @@ static int arcturus_get_power_limit(struct smu_context *smu,
>>  	if (default_power_limit)
>>  		*default_power_limit = power_limit;
>>  
>> -	if (smu->od_enabled)
>> -		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>> -	else
>> -		od_percent_upper = 0;
>> -
>> -	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>> +	if (powerplay_table) {
>> +		if (smu->od_enabled) {
>> +			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>> +			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>> +		} else if (od_settings->cap[SMU_11_0_ODCAP_POWER_LIMIT]) {
> 
> This check is applicable even for od_enabled case. Presently OD provides
> multiple feature capabilities; only if a capability is valid, then the
> limits defined in the table are valid.
> 
> BTW, I'm not sure if that is the subject of this patch.
> 
> For arcturus, overdrive doesn't look relevant; again that may not be
> relevant to this patch topic.
> 
Yes, We might need 2 patches here. One is used to fix the NULL pointer issue of
powerplay_table, the other is used to check validity of overdiver table.

Regards,
Ma Jun

> Thanks,
> Lijo
>> +			od_percent_upper = 0;
>> +			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>> +		}
>> +	}
>>  
>>  	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>>  							od_percent_upper, od_percent_lower, power_limit);
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> index ed189a3878eb..fe8d24a7d319 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> @@ -2339,7 +2339,7 @@ static int navi10_get_power_limit(struct smu_context *smu,
>>  		(struct smu_11_0_powerplay_table *)smu->smu_table.power_play_table;
>>  	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
>>  	PPTable_t *pptable = smu->smu_table.driver_pptable;
>> -	uint32_t power_limit, od_percent_upper, od_percent_lower;
>> +	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 10;
>>  
>>  	if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
>>  		/* the last hope to figure out the ppt limit */
>> @@ -2356,13 +2356,15 @@ static int navi10_get_power_limit(struct smu_context *smu,
>>  	if (default_power_limit)
>>  		*default_power_limit = power_limit;
>>  
>> -	if (smu->od_enabled &&
>> -		    navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT))
>> -		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>> -	else
>> -		od_percent_upper = 0;
>> -
>> -	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>> +	if (powerplay_table) {
>> +		if (smu->od_enabled) {
>> +			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>> +			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>> +		} else if (navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT)) {
>> +			od_percent_upper = 0;
>> +			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>> +		}
>> +	}
>>  
>>  	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>>  					od_percent_upper, od_percent_lower, power_limit);
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> index a405424dd699..c86e13f6b6c5 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> @@ -617,6 +617,12 @@ static uint32_t sienna_cichlid_get_throttler_status_locked(struct smu_context *s
>>  	return throttler_status;
>>  }
>>  
>> +static bool sienna_cichlid_is_od_feature_supported(struct smu_11_0_7_overdrive_table *od_table,
>> +						   enum SMU_11_0_7_ODFEATURE_CAP cap)
>> +{
>> +	return od_table->cap[cap];
>> +}
>> +
>>  static int sienna_cichlid_get_power_limit(struct smu_context *smu,
>>  					  uint32_t *current_power_limit,
>>  					  uint32_t *default_power_limit,
>> @@ -625,7 +631,8 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu,
>>  {
>>  	struct smu_11_0_7_powerplay_table *powerplay_table =
>>  		(struct smu_11_0_7_powerplay_table *)smu->smu_table.power_play_table;
>> -	uint32_t power_limit, od_percent_upper, od_percent_lower;
>> +	struct smu_11_0_7_overdrive_table *od_settings = smu->od_settings;
>> +	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 10;
>>  	uint16_t *table_member;
>>  
>>  	GET_PPTABLE_MEMBER(SocketPowerLimitAc, &table_member);
>> @@ -640,12 +647,15 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu,
>>  	if (default_power_limit)
>>  		*default_power_limit = power_limit;
>>  
>> -	if (smu->od_enabled)
>> -		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
>> -	else
>> -		od_percent_upper = 0;
>> -
>> -	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
>> +	if (powerplay_table) {
>> +		if (smu->od_enabled) {
>> +			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
>> +			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
>> +		} else if (sienna_cichlid_is_od_feature_supported(od_settings, SMU_11_0_7_ODCAP_POWER_LIMIT)) {
>> +			od_percent_upper = 0;
>> +			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
>> +		}
>> +	}
>>  
>>  	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>>  					od_percent_upper, od_percent_lower, power_limit);
>> @@ -1250,12 +1260,6 @@ static bool sienna_cichlid_is_support_fine_grained_dpm(struct smu_context *smu,
>>  	return dpm_desc->SnapToDiscrete == 0;
>>  }
>>  
>> -static bool sienna_cichlid_is_od_feature_supported(struct smu_11_0_7_overdrive_table *od_table,
>> -						   enum SMU_11_0_7_ODFEATURE_CAP cap)
>> -{
>> -	return od_table->cap[cap];
>> -}
>> -
>>  static void sienna_cichlid_get_od_setting_range(struct smu_11_0_7_overdrive_table *od_table,
>>  						enum SMU_11_0_7_ODSETTING_ID setting,
>>  						uint32_t *min, uint32_t *max)
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>> index 6a501d2661f5..e17f93ba861e 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
>> @@ -2356,8 +2356,12 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
>>  		(struct smu_13_0_0_powerplay_table *)table_context->power_play_table;
>>  	PPTable_t *pptable = table_context->driver_pptable;
>>  	SkuTable_t *skutable = &pptable->SkuTable;
>> -	uint32_t power_limit, od_percent_upper, od_percent_lower;
>>  	uint32_t msg_limit = skutable->MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
>> +	const OverDriveLimits_t * const overdrive_upperlimits =
>> +						&pptable->SkuTable.OverDriveLimitsBasicMax;
>> +	const OverDriveLimits_t * const overdrive_lowerlimits =
>> +						&pptable->SkuTable.OverDriveLimitsMin;
>> +	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 10;
>>  
>>  	if (smu_v13_0_get_current_power_limit(smu, &power_limit))
>>  		power_limit = smu->adev->pm.ac_power ?
>> @@ -2369,12 +2373,16 @@ static int smu_v13_0_0_get_power_limit(struct smu_context *smu,
>>  	if (default_power_limit)
>>  		*default_power_limit = power_limit;
>>  
>> -	if (smu->od_enabled)
>> -		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
>> -	else
>> -		od_percent_upper = 0;
>> -
>> -	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
>> +	if (powerplay_table) {
>> +		if (smu->od_enabled) {
>> +			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
>> +			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
>> +		} else if (overdrive_lowerlimits->FeatureCtrlMask &&
>> +					overdrive_upperlimits->FeatureCtrlMask) {
>> +			od_percent_upper = 0;
>> +			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
>> +		}
>> +	}
>>  
>>  	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>>  					od_percent_upper, od_percent_lower, power_limit);
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>> index 3dc7b60cb075..684cb5a7ef6c 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
>> @@ -2320,8 +2320,12 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
>>  		(struct smu_13_0_7_powerplay_table *)table_context->power_play_table;
>>  	PPTable_t *pptable = table_context->driver_pptable;
>>  	SkuTable_t *skutable = &pptable->SkuTable;
>> -	uint32_t power_limit, od_percent_upper, od_percent_lower;
>>  	uint32_t msg_limit = skutable->MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
>> +	const OverDriveLimits_t * const overdrive_upperlimits =
>> +						&pptable->SkuTable.OverDriveLimitsBasicMax;
>> +	const OverDriveLimits_t * const overdrive_lowerlimits =
>> +						&pptable->SkuTable.OverDriveLimitsMin;
>> +	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 10;
>>  
>>  	if (smu_v13_0_get_current_power_limit(smu, &power_limit))
>>  		power_limit = smu->adev->pm.ac_power ?
>> @@ -2333,12 +2337,16 @@ static int smu_v13_0_7_get_power_limit(struct smu_context *smu,
>>  	if (default_power_limit)
>>  		*default_power_limit = power_limit;
>>  
>> -	if (smu->od_enabled)
>> -		od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
>> -	else
>> -		od_percent_upper = 0;
>> -
>> -	od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
>> +	if (powerplay_table) {
>> +		if (smu->od_enabled) {
>> +			od_percent_upper = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
>> +			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
>> +		} else if (overdrive_lowerlimits->FeatureCtrlMask &&
>> +					overdrive_upperlimits->FeatureCtrlMask) {
>> +			od_percent_upper = 0;
>> +			od_percent_lower = le32_to_cpu(powerplay_table->overdrive_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
>> +		}
>> +	}
>>  
>>  	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
>>  					od_percent_upper, od_percent_lower, power_limit);

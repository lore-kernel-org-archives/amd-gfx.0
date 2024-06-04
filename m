Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E86C27C50
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 13:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9226410E48E;
	Tue,  4 Jun 2024 13:55:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZeDRL74J";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0EE810E48E
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 13:55:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtRoPLGLx+vYfUi+JYSLLn2wZw5jTKNpIPKBVCpaAQfCINuWnyR/kRx37KPwgvh4vQah6K1YUnL+ocrkWKY+gYWd4m1nkQr0/KkI1v4tMgcnvu04kGH3rDrB7Q7ekfdAaPj2NnEoyjC+9wFYOtLadfSo/4ifGxy7gnXzCuT/AIW9hKnu5pm+eaoXOykzMh9pSgIPjsqWjuuMqUvPRWpgJjnch/arwXgueqLjHgWgYDl35lWY/XQTTju//zx2nGqjv78mwDecxgF9rLO4GtSI2TM8BBpZU7mcVE+TdlI9c73zbOpCUFgN0m3D41mYD/ZyWf84Rb/bWe2vy01yF9ajxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBph7ITNUSxywd1P3J4prjpZlSPiEAWSHMDJNi21J6Y=;
 b=IqIf0CtVt+5nWkwmT0evnTkwI42s/S26FvQsov95o+V948zVX3WSMe1GFByBipjuxQZc+o23Fgj5i3Yvz5UDnUQgrFbTD3D3LD36nLfhNjMfXldrQGrChXGK+uxUH3E4dtqXykVTFe0FJk2d9Dx+2+rTZ+zOYBZ9CtHltx5XEf4ogh4ME1SXUjihvokzfQw0DuOHkouRmDJ1bK2mvi/qYg0bOo/pmhWauDTPMdAL2FoB+kS164C4sUcG03f86UIqilzt3VmAJZ9ffWBU0FwumXqGJ5zrDYnModOfI453EBlMmeUAJPf+P4AGt9umlKJmRJpwZF7uSNcnqjMDfvYTWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBph7ITNUSxywd1P3J4prjpZlSPiEAWSHMDJNi21J6Y=;
 b=ZeDRL74J0hb1tPRs8VQvMxbvbYlpGPL8jEQO+3YjYeSI8igjjwQaSm3FztjFv7KxvpvjZGuftF5SMbEuG2LpfPgxf6aCKCKFU4FwDBa+88Wbzfd13hpo0bixrDkl1l80uVCfsJG66X7aknvmd2W+YvFO3FMNcEkg7WHF2+xt19U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 4 Jun
 2024 13:55:30 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::a3de:b197:926d:e124]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::a3de:b197:926d:e124%6]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 13:55:30 +0000
Message-ID: <f9210170-440c-4d2b-b2e5-310fbb057175@amd.com>
Date: Tue, 4 Jun 2024 09:55:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: add reset cause in gpu pre-reset smi event
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com
References: <20240603181258.170580-1-jinhuieric.huang@amd.com>
 <20240603181258.170580-2-jinhuieric.huang@amd.com>
 <21fe0149-188b-4510-99b4-35a54805401f@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <21fe0149-188b-4510-99b4-35a54805401f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::23) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|MW4PR12MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bc8ebf1-d923-4f5e-eef9-08dc849dfef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXB2bHdac3hDdVJFZkk3NGNaWjBDdWJXa0x6QVlBSjlYZmtISmVCVXI4bzdn?=
 =?utf-8?B?dUdRejAraHY4ZTROczh4SHYwSmtxVXdPeTJrT0VJb3F5QVFSMVVoRUdhOStH?=
 =?utf-8?B?WUI4KzZveEpJT3AranYxK2tpU3M5QUhPNnJ6Z3lHbCtFWEN5SVdFUjlnN2My?=
 =?utf-8?B?bDFLV2xRMmRlYm9qWG10eDRIcXY3NENGclJKZlBsVXlVaGJhTE9ORStTYk9I?=
 =?utf-8?B?RHFZWGx4QUZLbEhGbDMxYVpFbDVwL1pYNDgvM3FzNUUzcGgvdGJQY2p2b3oz?=
 =?utf-8?B?eHZ2WURKbCtuWjZSbzl0RXVzTldvREhZY2VhZ2FtZnVETXpCdU1JQUNEQkNF?=
 =?utf-8?B?QjkycDVlK2hUaUVxVVJPVGZHeU5VWHdOb3FybzVtVy8wZTk3cWs3eTFHZGs2?=
 =?utf-8?B?UDcyVGxNOUNlcngwMUNMc2NLS1I2elI2YlkyMjJKcmljVnJWMXlTZW4yY3Nv?=
 =?utf-8?B?bXo3UFF4bUZRckY0UFBZU0EzSGFqWTRyUitSQ01EaXdtSkc1a2xLM0t2Yzdm?=
 =?utf-8?B?azlTRFpUNGpIL0RXa0tNc3pRaHBpaUtnblNHWmxOUCtLdnNrdmZEODB1N0o0?=
 =?utf-8?B?MXltY0gveC9CdHlSYUJCbzVIVk5oVzFWRFBkdkJiVjQvTHpmaVVIejRxSDl6?=
 =?utf-8?B?ejBTMHpROVN6endicnJvdkwyQ0krTkdMOG9laXJhb0JpU0ZnV1RteHFhVk4y?=
 =?utf-8?B?bkc1WjVCekwyWDdkcm5OeDlhbUlNckU2U0hpYndhdDUyc0c0cW9od3RNeURn?=
 =?utf-8?B?UHVQdnFzNVZldkJkK0E3YW40Z0dkNUdPSUs1T213cWFoeVlIcjd3bXUvbHk0?=
 =?utf-8?B?eGorMTJWencvSVJZdTB2YlF0RFkwUXpmS1c3WEhTSTAwTkxXallDOTl3aGg3?=
 =?utf-8?B?OEpzSmpkbTAxQ2k3VmJJT2ZsOVlSOXpQZUNVb3Zpb2Q2RkF5cnVic3N5MEVR?=
 =?utf-8?B?WFRXYnp0b0ZvOUpKRjNzbmtyY0EzQjNWR3ExRi9GZkg5YXlZQXZRRXp6TlZo?=
 =?utf-8?B?eDRFWWpGNU5MNXNZNEZYK2diVDl6UDJ1RXVXZDVsSk5ETG9uYzdxanY4aXV3?=
 =?utf-8?B?ai9iYVU2WjcxRGI4dHIvS0NDbDNFeXc2VktLMDN3dHRIaHlFNURwNUI1TkxE?=
 =?utf-8?B?TndBdklXSjZEdU9CQUVVZ1BYMnpvem15T3lKUHlPSUVxdmdwWHhWbzNaYUZB?=
 =?utf-8?B?YTJuOXlFc2ZQS3FXWlRVTEhiSUJuQzloWmkvN1J5T0lBaStEbXg3d2lLNk9O?=
 =?utf-8?B?SkpWUjhGMStWNnQ2dGhaSENvVVpFbmtkUW5sY0VlK3g4QkRZL04rUy94RUJp?=
 =?utf-8?B?Sml3Y3hSUXdseU4zZ0tJNHl2VkJsT0w5MG9palcza04yM1lnQ3I0K25teEw1?=
 =?utf-8?B?bmRrOUI5NFVzTS9QdkR6ak84M3N5SlZOTEtheVVjYWlrdkgxM2NyYUNjNGZI?=
 =?utf-8?B?cnJ6RXBSM0tiRDVnMWN1alJEZXhNUFRxdFdqaEtvblluZEdkRlJnSVZEUzd4?=
 =?utf-8?B?OUM2WHhQWGw1MTJXNlhwc3krQ1hySE4wTG5qdTdoczlFL1I2S3F3aGJwUlFJ?=
 =?utf-8?B?UUMwY0JSRkVMbmwvR1hvaExTeE1BV2xVVWlyV25LTzlCNWdKc3hDaktoM1Zp?=
 =?utf-8?B?QVAzZTc0SjhNS1ZVMDRrdU1YN0lVTHZSbWJIZ3pITHYzU0RQZlR3bmRWelZY?=
 =?utf-8?B?azR5ZGpvbC9yZ0ZxdDl2a0RqOUlhRnRTRFBJQ29GVlpRcC9CTVlkUmU5Rmsz?=
 =?utf-8?Q?EwbNNwp8AHZ3jAGgWduNkhp2/5Cg4cBlB3tsFsv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEExSy9YeG5uQVlUTm9lMlRHZFhiRUY4MDJtT0VaUkJMZm9IMmJBMG5mRUtn?=
 =?utf-8?B?cSt1cUtxWVRodng2VW4yLzNXWGlRMmtETmVKNzJiTkRDcUxyRVFkT1I4QTRM?=
 =?utf-8?B?ZjYrTTh6UmNEbC82amxVaHdUZ3RlbGZvRGx1bnBOT1BCMnd6dy9jMmgzdzY1?=
 =?utf-8?B?N2tOQU45ZHJGaDBqclNKQ3JTTVJkRnYvMTZWQjRpS1hObDhwVVplUnpaUGI4?=
 =?utf-8?B?SDQ4RURxZzA1VCtKNTczL3JUaGJTTlZRRDB4SXlnZVY0U09qZzdzMXNXM3RQ?=
 =?utf-8?B?cGpscE9UeVFvbEFyRmJFdURES3I0QWJRUFFaRDN4N0hBNUxaZVNSamNPUHFU?=
 =?utf-8?B?S0s4QTBmRmxqYXhMR2JOYmxuR0RRK215UW5VUW9SZCtMeHZWQXFBQ1dmcy9y?=
 =?utf-8?B?VVgzajNIemw5ajZ1anREeEI3WW9zWTY5N3kvb25uMk9icHY5b3FpOVRFN2ps?=
 =?utf-8?B?aGttT2RrTmo1TjlTcjFPNlFrcW1SK24yNWUzeDZON25CL0RKS1ozR1lDQkNS?=
 =?utf-8?B?SmY1Z3VhUmRzWEx0VXVoanJzYmlqaENTUUp0VE5HcHp1ZUI1ZjM3aGVZQ09n?=
 =?utf-8?B?SmRaSFUzb1JocXBTSFZJb1VhR1ZLeUk4Rjl5bXFYcUF0VWZVREMzTldkc0hP?=
 =?utf-8?B?LzdBMG5OVGxjUU0zd1o3Q0JRQjRDYmltak8vRUthMnpTRDJEL3FTQi9Mckxq?=
 =?utf-8?B?YmQ4QTBudSs2cDdINDdwZjdpTnhlZ2xtaFEzV1pEZUVxQ2RFU3owUldrUzdp?=
 =?utf-8?B?MWdrTWtZT0ZiNVR6NXMyTUlCL0VRWTN3aHRrTWhxaC9zSElwUEYrM290MlFK?=
 =?utf-8?B?TFNER1Qybi9tVUpZSkhVUUw0N0d2c3pOa1NuQUZUYlBhZm5pV2gxOVJ2Q3Y1?=
 =?utf-8?B?ZnhkdXVwMWd3NmxYbTNrSnNFaDRtQ3ZNUytMYzdlWDBjV1NNdUwxT2hvb0Fn?=
 =?utf-8?B?alVYSmVuUCtTTThMTnhZcEgrS2ZOUkZyU09abUttT0tiT1F4TVBJMU5ndzZD?=
 =?utf-8?B?NXA3aHVncWpsNldUWnVWUTI3NklPTS8yTEM1YTBGdTEzUUtNR0hiRWdYTUF1?=
 =?utf-8?B?VmR2Y1NPZ0cvTHkyNytGYUVIQmYyNXRFcnIyT3NTZmlWTnVJTW1IWFRIWkFT?=
 =?utf-8?B?clU4ekNmVmpsc2NuZjdJTHRUZDlpL0hKKzJKWWxzWWpleHNVdUVXeTcweFc0?=
 =?utf-8?B?TTk3R29XSTVZaVZLREhtcTc5Mmh5b2hYd09SR1U2NE9JRE5venVoRHBJdDZo?=
 =?utf-8?B?ZWpob3FQUFNnS3crc0QwUS9lSnZiemwwUzR6ak43S0l6MzRMdjU2TUNPZXUx?=
 =?utf-8?B?MGRHNGRaVCtIQ0hybG5YaTV6UDFUWkpIQThRdk9ScVZPUURuVUZiaVExeEI5?=
 =?utf-8?B?dzlBMGJPdGVVWkUxak5UZzU3Q2kwazRrOGgvUy9DcGZNUUdKUGF2bkZIZjRW?=
 =?utf-8?B?UnMyS2djTWV4YkJSa0E5VnNNUUcxZG1jdTc2eklOcHZSalRMbkdBd2J4dE00?=
 =?utf-8?B?WFdsdDRzZHRMU3VPeHlITHpRaGxUT1FXVDF2Tlp4eHltWnJjSm9MSkd6cjFK?=
 =?utf-8?B?SitlL0ZhTEhVVXI3c2M5MFpZOFZ1Q3dQODhFQ3ZWYXdNcTJJTkZWSk5oL1c2?=
 =?utf-8?B?c3Bab21IYms1NldXVEg4MXovY3IwZlNZVVN6VS93NFk5SkpjbGdUK0xpVGNu?=
 =?utf-8?B?SjB2UzV4U0lQaGp5d3BidU90L05zZWVnVWVTc3ZlalBjR3I3bnFoeHZsL1lo?=
 =?utf-8?B?YzFydWJmYlpyeTdRUDNabkpMcXFMOGw5Rkl5dTFTOGg0ZFEreHdkMy9nOG1K?=
 =?utf-8?B?WVVOQVFPRytTKzBlYzY1SVpvSEdXRlJienBWY2pxTGNQWmo4Zy9sVW1ubXlo?=
 =?utf-8?B?QWE1d3JqQmNtU2FTRXdrU1BvZU9zcjVoOGJwOGR3UlpJSmc1QVJ6VFQ1ei9S?=
 =?utf-8?B?S2dLUHprNlVmUlFoUzlJOTlIQkJWU3I4MDI0V1lyMzI0NTBnaUx1TlVrZmhx?=
 =?utf-8?B?U2JuNk1kZ2JWVXBFaGR6SXBGUTJKdkp0OUhrcDNibFpJRjdRVjVrV0l5d0Nk?=
 =?utf-8?B?Wi9kOWlQVURFLzZheW5ZMUZOYldlSWJzZjBLUzVTZnp4OEwrNzUxbzJFZFRn?=
 =?utf-8?Q?QyGk3nsGyORtvAi2IQQ73oSdL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc8ebf1-d923-4f5e-eef9-08dc849dfef4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 13:55:30.3986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFuxUG0mHUTnUagfbEE0U1lWichvEUgXPEaOMBv9KnmQsSiWn/sfnId9wix4AL9y21od+xg/jdm1powcJ2bAdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949
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

Thanks for your review Lijo, I will send a patch with reset source in 
another places.

Regards,
Eric

On 2024-06-04 03:26, Lazar, Lijo wrote:
>
> On 6/3/2024 11:42 PM, Eric Huang wrote:
>> reset cause is requested by customer as additional
>> info for gpu reset smi event.
>>
>> v2: integerate reset sources suggested by Lijo Lazar
>>
>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> This series is
> 	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>
> I think SMI needs to get all reset cause descriptions. Are you planning
> to fill reset source at other places also?
>
> Thanks,
> Lijo
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |  3 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h  | 10 +++++++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  2 +-
>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c     |  7 ++++---
>>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 16 ++++++++++++++--
>>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  5 ++++-
>>   6 files changed, 33 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index e3738d417245..eb601b41d9d5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -133,6 +133,9 @@ static void amdgpu_amdkfd_reset_work(struct work_struct *work)
>>   
>>   	reset_context.method = AMD_RESET_METHOD_NONE;
>>   	reset_context.reset_req_dev = adev;
>> +	reset_context.src = adev->enable_mes ?
>> +			    AMDGPU_RESET_SRC_MES :
>> +			    AMDGPU_RESET_SRC_HWS;
>>   	clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>>   
>>   	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index 1de021ebdd46..7e945a4790bb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -47,6 +47,7 @@ enum TLB_FLUSH_TYPE {
>>   };
>>   
>>   struct amdgpu_device;
>> +struct amdgpu_reset_context;
>>   
>>   enum kfd_mem_attachment_type {
>>   	KFD_MEM_ATT_SHARED,	/* Share kgd_mem->bo or another attachment's */
>> @@ -170,7 +171,8 @@ bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev);
>>   
>>   bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid);
>>   
>> -int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev);
>> +int amdgpu_amdkfd_pre_reset(struct amdgpu_device *adev,
>> +			    struct amdgpu_reset_context *reset_context);
>>   
>>   int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev);
>>   
>> @@ -416,7 +418,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>>   void kgd2kfd_device_exit(struct kfd_dev *kfd);
>>   void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
>>   int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
>> -int kgd2kfd_pre_reset(struct kfd_dev *kfd);
>> +int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>> +		      struct amdgpu_reset_context *reset_context);
>>   int kgd2kfd_post_reset(struct kfd_dev *kfd);
>>   void kgd2kfd_interrupt(struct kfd_dev *kfd, const void *ih_ring_entry);
>>   void kgd2kfd_set_sram_ecc_flag(struct kfd_dev *kfd);
>> @@ -459,7 +462,8 @@ static inline int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
>>   	return 0;
>>   }
>>   
>> -static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>> +static inline int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>> +				struct amdgpu_reset_context *reset_context)
>>   {
>>   	return 0;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 6711836054f9..4096cb3e937e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5775,7 +5775,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>   
>>   		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
>>   
>> -		amdgpu_amdkfd_pre_reset(tmp_adev);
>> +		amdgpu_amdkfd_pre_reset(tmp_adev, reset_context);
>>   
>>   		/*
>>   		 * Mark these ASICs to be reseted as untracked first
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> index fba9b9a258a5..52be4e340fb1 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>> @@ -924,7 +924,8 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>>   	kfree(kfd);
>>   }
>>   
>> -int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>> +int kgd2kfd_pre_reset(struct kfd_dev *kfd,
>> +		      struct amdgpu_reset_context *reset_context)
>>   {
>>   	struct kfd_node *node;
>>   	int i;
>> @@ -934,7 +935,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
>>   
>>   	for (i = 0; i < kfd->num_nodes; i++) {
>>   		node = kfd->nodes[i];
>> -		kfd_smi_event_update_gpu_reset(node, false);
>> +		kfd_smi_event_update_gpu_reset(node, false, reset_context);
>>   		node->dqm->ops.pre_reset(node->dqm);
>>   	}
>>   
>> @@ -974,7 +975,7 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
>>   	for (i = 0; i < kfd->num_nodes; i++) {
>>   		node = kfd->nodes[i];
>>   		atomic_set(&node->sram_ecc_flag, 0);
>> -		kfd_smi_event_update_gpu_reset(node, true);
>> +		kfd_smi_event_update_gpu_reset(node, true, NULL);
>>   	}
>>   
>>   	return 0;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>> index 06ac835190f9..ea6a8e43bd5b 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>> @@ -29,6 +29,7 @@
>>   #include "amdgpu_vm.h"
>>   #include "kfd_priv.h"
>>   #include "kfd_smi_events.h"
>> +#include "amdgpu_reset.h"
>>   
>>   struct kfd_smi_client {
>>   	struct list_head list;
>> @@ -215,9 +216,11 @@ static void kfd_smi_event_add(pid_t pid, struct kfd_node *dev,
>>   	add_event_to_kfifo(pid, dev, event, fifo_in, len);
>>   }
>>   
>> -void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset)
>> +void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
>> +				    struct amdgpu_reset_context *reset_context)
>>   {
>>   	unsigned int event;
>> +	char reset_cause[64];
>>   
>>   	if (post_reset) {
>>   		event = KFD_SMI_EVENT_GPU_POST_RESET;
>> @@ -225,7 +228,16 @@ void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset)
>>   		event = KFD_SMI_EVENT_GPU_PRE_RESET;
>>   		++(dev->reset_seq_num);
>>   	}
>> -	kfd_smi_event_add(0, dev, event, "%x\n", dev->reset_seq_num);
>> +
>> +	memset(reset_cause, 0, sizeof(reset_cause));
>> +
>> +	if (reset_context)
>> +		amdgpu_reset_get_desc(reset_context, reset_cause,
>> +				      sizeof(reset_cause));
>> +
>> +	kfd_smi_event_add(0, dev, event, "%x %s\n",
>> +			  dev->reset_seq_num,
>> +			  reset_cause);
>>   }
>>   
>>   void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
>> index fa95c2dfd587..85010b8307f8 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
>> @@ -24,11 +24,14 @@
>>   #ifndef KFD_SMI_EVENTS_H_INCLUDED
>>   #define KFD_SMI_EVENTS_H_INCLUDED
>>   
>> +struct amdgpu_reset_context;
>> +
>>   int kfd_smi_event_open(struct kfd_node *dev, uint32_t *fd);
>>   void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid);
>>   void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
>>   					     uint64_t throttle_bitmask);
>> -void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset);
>> +void kfd_smi_event_update_gpu_reset(struct kfd_node *dev, bool post_reset,
>> +				    struct amdgpu_reset_context *reset_context);
>>   void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
>>   				    unsigned long address, bool write_fault,
>>   				    ktime_t ts);


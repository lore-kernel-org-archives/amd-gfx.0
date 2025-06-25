Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C67C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 08:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14DF810E68A;
	Wed, 25 Jun 2025 08:01:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XywQNj3E";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F87B10E68A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 08:01:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KjsDY+fTTgG4GguYrZ3pk3IZojhIklZ5IBD4BpGHWJyqcnAGHLYmz9wOJbp/MnaL2IynBZwnnIrv/rfWGVWCgH5jJt4XyNq7W5zp4xtyJ1h//Z0ZsnKRfwwjb8sUVKjiHZ4KhNo7ZSCXHDsZ3ngsBxzt/ynxin2vqyot5pqLU3SWC+ww33Tzsfs0m7TACF057OuWwtI9oiE7H8KR2KTJ3m6o28DqTL9Te50INXB4nDdzj/DgcjM41daqBCDuksXuJHgrgVqB/UUHFAK7AAYtZsmYIh53yFiJBrsW67uM4OF9o/JUP+9E6FrMt9NhGFyfgyx7//1rBBTs8T2RZLvUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zb0r08GbNCmHrWDEq0ofvFbQU5Ye3cJQPfH50GShwYU=;
 b=e5PnVVX++9YQgXRzJPowGISTbNzRi4HQ1CJmXP0UP5OuXzvV+7mRgM6nLU8P28mqRidZFq5lOLp8WWNF1TVXvL8Z2ZWsJK2KUtOKIXl7fgV9LT2Wh7n9ObPILu095bUaN11kG3+a9k6aaZUOUFFmhiStJtQlqKD5AtLnf3NsNLnmmi8ArL9FSQ4L7JQKk0iCBOQsIqAUR/cJQAr7crchtz8SjXB3hYaPAL8o16DuICeoge8cFHQTWpDDmwmStzqeOmZk+/5iokAAThgy/3EwVPIWV+SpybdJydp/nnzjnR6vH74hwV9KvbVUhctqv4Tvwbch274g6MGgXypcEXDIsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zb0r08GbNCmHrWDEq0ofvFbQU5Ye3cJQPfH50GShwYU=;
 b=XywQNj3EMzkCC4Kq1NDQ5aduEfP1JurZTUKP9Krjsy5dhup2rPtbV6i6ualxvx2zKvyhhSiGJHgTh7y1RmaqCTMdBp1O0NaINeO66whqfi8Zhwudj61Y/isLbI6I9o9z0qDEjTcCj7QNobR9EsfwVK2Hjp0+lEm4ivb+qPqty2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Wed, 25 Jun
 2025 08:01:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 08:01:38 +0000
Message-ID: <daa46f6b-98c8-4bee-92e1-999f3a7a9d0a@amd.com>
Date: Wed, 25 Jun 2025 10:01:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/11] drm/amdgpu: add userq object va track helpers
To: Alex Deucher <alexdeucher@gmail.com>, Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
 <20250624084535.1178476-5-Prike.Liang@amd.com>
 <CADnq5_Ot27pk+hpk0ndQxmypbTr4i2z_uH3smsuHvzH9zkqTsw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_Ot27pk+hpk0ndQxmypbTr4i2z_uH3smsuHvzH9zkqTsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0439.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ae25690-3086-48d4-659f-08ddb3be8351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MlFrRDJpem1iVzNHZktVN2tvUjhhS3ZRV3d2akhoTm15Qi9pU1RYc21yT2d3?=
 =?utf-8?B?cjBhR1ZQMnBwYWtMOWZXQk4rU1M2dUxhWUhMT21JdWIwYmhrMWtiVllYWTVO?=
 =?utf-8?B?VUdBZnd3M09ob1lGMG96K0UvY2xvVFNBTkFCM2VuU3pYVUNaWXhZcjA2NXk3?=
 =?utf-8?B?VWpDWno5MCtpUnl4K0NzMnpJYXVMSmpvZ3FVNzlYQmdyZ1FJa0ZjT1kwdjlr?=
 =?utf-8?B?QXJJNS9WZjJkcjA1R3JEWFJNUURmelBxNjJTc2dPNmpPaE0yZFVjR0MrcXRR?=
 =?utf-8?B?a2pHMHZHRlZMSHRQbEtNTnlYa2Izdm8vUFo2aHU5Wm9HR3VKb2RnanhEZG55?=
 =?utf-8?B?ai9OLy9RVHpvdGhUa21xU1M1VVBrT0ZNWGZBNTYvQjJsZVpjcjlpb0g5Vkd4?=
 =?utf-8?B?M2xQZGxrUXNBY1pRZ0dpVTl6WEtGU2x0UkNjZVRJaE5VM3VPWkszbEpCejhs?=
 =?utf-8?B?UVo3SUgyRmVueUxhdDlFMHZ1clg5T2E0OWhJN2RwMnp0TVZGM2cyQmdhMjkv?=
 =?utf-8?B?NllvT29HVEJJUEFtbDgzdUxaRmZ0ZzlZWDFSay9ZbzBMZS9LcnFzK3Ftc09p?=
 =?utf-8?B?b2xIeW9qa01LZit1TmpBaGtWMmllTVpQQmVxd2JYZnpuWm9kT2ltaXd5UXhu?=
 =?utf-8?B?NFd5cDE2YWo3NU01R1lzZmplbFJVVmU2OEdRTE1wL3J1NVk1RlBKTDJNdUNQ?=
 =?utf-8?B?OGJOVENVRXZ6Y0FobDFOblhTeWJ3QXNtSVhSWSt0TEU2L3hkN1hydUxZQjZ4?=
 =?utf-8?B?RjYyMUNMSFNPQ2dNY2c3WlhlcEF3c0QrVlBYRjk2OTFOY2R5VnNyR28vYWpV?=
 =?utf-8?B?djdNUUdTU1d6Q3RsQXQ0VXJENFVWSFJ4eGRhWUkybDBBUXNyWlkrVGZSenda?=
 =?utf-8?B?d1JaOW0wbzFheHJDdGdDSm43ZU95NUptK3NwOWxHVG5QNThBSm95QkNJL0pm?=
 =?utf-8?B?VkNaaTFyZWgwcjJyMEE5eDFNNFAzQVViZjR0aWxqbHYyQmJjenRlTFF1TEtT?=
 =?utf-8?B?cTlqVks1amhnaFQvZlhrUXVYMjRmK0JRUlNCWThGZjE3RFd0WG1NMjhTSUtp?=
 =?utf-8?B?MVdycnFEUk9yVkNCTEtWZURFS0lmWHNUQzNsaEtyWDVOWXJpbFN3NS9BWkdo?=
 =?utf-8?B?empMZTRHdkdxNmh1d1E3SUF4RlVaUHk5QnJsTmQweWlEUitxbkxSazJPVVdo?=
 =?utf-8?B?UDltdzlaaDdoTVlOSVBOemNodVRady9Sc3gzRHJvN08yM1krMjhyRVZPa000?=
 =?utf-8?B?eFJVM3cvd3N5R0FrUkNLYzRBeC9hVlc1YU81b1ZWMnh4alVlWWRPZ3Fya2NK?=
 =?utf-8?B?TEd2UXkrb0RZMEZWbHNRWkVLMEU1aEpsTmtqWjFSVE13ZU95TUlOQWdzc3VS?=
 =?utf-8?B?MnVPZWJLZWhMR2xneDBDUmdveUQ3Wk1uaDJlaS9Edkl6NXhFbHpJcVo3VnFZ?=
 =?utf-8?B?L296aEQzMURCeDJIbDczbGxic0lHNGxodWZNZVk1c2ZuMHZ1YkppVGVvUGpp?=
 =?utf-8?B?ZGVBNW5yTVc4U1RyU2w0c05oWFpmeUY5WDYwajlpcFY1TXpOQ3I0U01qd3pC?=
 =?utf-8?B?MlhDSEdsbktLYUtpY25VUmpWR3NQaWJRT0RtT3U2dFU5Q1JocjRPcXF4SlNJ?=
 =?utf-8?B?a1dXV3g3d1ozaGlhY21QNjE3cFU4cEUwYnZRTUROUG1meXRwczQ3WnRJOC91?=
 =?utf-8?B?dURqYlpWWXFtd2M0WjU5QnlNV1REbDJXMlJsYmZpbjB2VUEwZkVIdDhwYnRB?=
 =?utf-8?B?dC9PcU16ZlFyOElWMlhLalFmZW1PaGhnb0djcW1PQ1Q0dTFlWCtsSXVJUm56?=
 =?utf-8?B?MzI5TWNRRkNKWHVibkdpV1RNUnFPbHdRWlNqaGN6b2J1blgxSWhHNjNnZjJw?=
 =?utf-8?B?NU1qaDRPQkUzNUc4bGpBMFNJOS9pLzl5cjlSOWJ6Ykc3VFR0YmN2b2k1WjZO?=
 =?utf-8?Q?dOtiJYDIZR8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGt1aHovZkwzbjZoWnAxOVBHQjZDejdkOTZJSXlVaGM5Ym5MMGR5NDdGZUxw?=
 =?utf-8?B?TUUvZXMxb09xMDJ2NEJIMlFYZy9rRmJ4YWZwdmNZUXdEcGJtdW5YWVNOaWI0?=
 =?utf-8?B?QjgybFhiTU51WTFvWElkTTZpYnZkQ29EcHU1V05Zekt3N0F0NjZPazlUbTZC?=
 =?utf-8?B?VVVsTVhLa2dWMDdDUFJuUENQaUFNeVlHNmFlc3dCL21yQTVRYklDNUdNRnNK?=
 =?utf-8?B?VDRjQ1Bodk1ZTXBwZHVxS01TcnBwbVRqNlp3aFY0TldFeVhLNTlldUxaWmZC?=
 =?utf-8?B?Sm54Y2FqcXhHSFlXVnAvOFVocFJnY1BZK25jem81ZisxNnpwT0g0NjZjd0Nw?=
 =?utf-8?B?Qkp2ZHV3Y2VSMWlYb3NsZWw4SFBsL0FTMGx0ZnZPaWNZdzQvOUQwRlJnMzBD?=
 =?utf-8?B?eDJLVXZrTVBnaUdORnNOUlV4R0FDbmRkTEg3UFg1aGZnS0FXTlBSKzRGSlVK?=
 =?utf-8?B?S0Z1NW83dDQwZlRQMGpROUEzVjhuSFlack51RUQ1K1dDNlhoeFVVMUJrdnF2?=
 =?utf-8?B?Ym5xT2szeitWcERpVURGNFNxQVdNd1Z4L2FBWnJCVVJmdVh6U2wvYnZSRVkz?=
 =?utf-8?B?RndDYk5sbC82UU5CMXV0WXgvS3hmVUM5dVdJOEd3MmZLT2Q1TUNFaEt6WThK?=
 =?utf-8?B?cGVlTHNGdVZodzdPWFYyVTY2OHg4ckVybm42SzBMOXozS1VEdGtpVUtoMDNm?=
 =?utf-8?B?c1pobkY1Y3NOdnVIaWdNalFZdUNDRVlvcjlLTHY2b2ZPeC9POENIcS8yVWhm?=
 =?utf-8?B?ckFqUk16TXBHQjQxZGdaTWVUQXRuajJUZEl2eTEzN3NVUE9Xc3I3dC9xMzF0?=
 =?utf-8?B?Y2dqWDFRc2Z1aGhuOEZFUVBtRTJXclVJdjV5ODJYeHp1ejkvbkxIMUNKRkpX?=
 =?utf-8?B?ODFSQUYzaDVvWHFGODJPSUVWL1NjK1VacTlkMWRHZ2lrY2pSbG1jcHJIUGUv?=
 =?utf-8?B?eFRSSXVZYWJ0a1hhRWJRY3UrNmllRlg3MjlhQjZVU3EyTU0rSHVCNEN3WUov?=
 =?utf-8?B?SXNLRUdOb0NZb1JCTjRFTVkwWlAwRVVNV0Y4WnphTktPcURIVzVrT215cVhV?=
 =?utf-8?B?SG43UThMRGMxMW9xYlJIMU1IbnlmZ0NJU1pmOGFLWWdid0hVSVlXU3k1OXZR?=
 =?utf-8?B?RFVua1pNMlVPMXhjTkZPdnpGejlvM2lyK1RLS25WRWtTMDcvMUJiMWZXWHVL?=
 =?utf-8?B?cEZ6UGozcnVYeElDSnZkZXVRRWJmMmQxcGMxRWI2TlJtb2pSSWlGaW5UU1Q5?=
 =?utf-8?B?bXRlbVJ6ckRzellqRkgvYURnMTVadC81bVoyNjBRamREUkhZNXJBYkV4TUtL?=
 =?utf-8?B?NEtMQ3NZaUFnZ0hiSTBuWnlhU3ZsSjJoQXBkdkM2eVl3SE8ya3d5WEpVMExT?=
 =?utf-8?B?UWJXbEd0VEc1ZExFclRHelYvUERXUUhiWW1pK1d1ZUo4amU3UTFkajJLK1M5?=
 =?utf-8?B?QWVhRmc4RnFiSUNEWllqUjhNZnNjQWNUOHh5bFIzSzZ6eDBiUDU4VnpCQVZz?=
 =?utf-8?B?NVE3Rm9VRlNXejcrelZWVS9XeVNSSk1WUThJNzNtVFcrc3dXbHhSUDBPOGxs?=
 =?utf-8?B?MjdYK1p1MnFsQ2NlQlMrdmpzOVVxbGJBQUUyU2NjOENjemJYcXllWGwzSlM0?=
 =?utf-8?B?aUVMaG9rV2JGMy81ejFDb1RvbmxVbGttSHROU2NaaFdSeEU0cldIa0xSVkZO?=
 =?utf-8?B?cm5USCtXTTBVN0IzbVN4Z0FRL0dUMFB1eDkzbFRKc0htMnh5MjIrQm1ZS3hv?=
 =?utf-8?B?L2NPL0dzK0tJODRxc0NSb0cvcWdnNHVTNkUrQWs1ZXlQc0JVYjZNT0xsTlZE?=
 =?utf-8?B?OUkyN2IrVGtWa1AwTHdmVTZacnA4RWZLYmVGemUxbHVHY0ZFVGlWZ1pZTmZl?=
 =?utf-8?B?MG5GUFNiZW1YRDI1T0hMMG1peVp5OVJnUk5kVTNoSWh6NzdkTjZCWUNGWFk5?=
 =?utf-8?B?bWRZRVZqSml6aUlQY2N0aXRnbHN4Yi9wbkFoNnlHOXJEYnVTNjBNNVc4aHRu?=
 =?utf-8?B?Ukw3aFkyY0pSZmdkOXRRanphNGk3ZEVTR2hxaEFRTkt1UHpEbUpub2R5d2d4?=
 =?utf-8?B?YjZRZE1zSjdUV3YzSzZsTTMyWGFoQVhtenRyRnA0MEc1UGxMZ3Npc1c5N1B1?=
 =?utf-8?Q?IA1XFI8kte7y63j2TSXpVguyp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae25690-3086-48d4-659f-08ddb3be8351
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 08:01:38.6362 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pH2YOx396iyA3vL0rnRoBwIL2OuemCpbhD71KmKr5iogPSSrRVQa6iXpAqNBy+zc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
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

On 24.06.25 19:15, Alex Deucher wrote:
> On Tue, Jun 24, 2025 at 4:54 AM Prike Liang <Prike.Liang@amd.com> wrote:
>>
>> Add the userq object virtual address get(),mapped() and put()
>> helpers for tracking the userq obj va address usage.
>>
>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 132 ++++++++++++++++++++-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  14 +++
>>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |   4 +
>>  3 files changed, 149 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index a20f7ccbe98e..cbbd1860a69a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -76,6 +76,134 @@ int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
>>         return -EINVAL;
>>  }
>>
>> +int amdgpu_userq_buffer_va_get(struct amdgpu_vm *vm, u64 addr)
>> +{
>> +       struct amdgpu_bo_va_mapping *mapping;
>> +       u64 user_addr;
>> +       int r;
>> +
>> +       user_addr = amdgpu_userq_va_align(addr);
>> +       r = amdgpu_bo_reserve(vm->root.bo, false);
>> +       if (r)
>> +               return r;
>> +
>> +       mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
>> +       if (!mapping)
>> +               goto out_err;
>> +
>> +       /*
>> +        * Need to unify the following userq va reference.
>> +        *  mqd  bo
>> +        *  rptr bo
>> +        *  wptr bo
>> +        *  eop  bo
>> +        *  doorbell bo
>> +        */
>> +       /*amdgpu_bo_ref(mapping->bo_va->base.bo);*/
>> +       mapping->bo_va->queue_refcount++;
>> +
>> +       amdgpu_bo_unreserve(vm->root.bo);
>> +       return 0;
>> +
>> +out_err:
>> +       amdgpu_bo_unreserve(vm->root.bo);
>> +       return -EINVAL;
>> +}
>> +
>> +bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
>> +{
>> +       struct amdgpu_bo_va_mapping *mapping;
>> +       u64 user_addr;
>> +       bool r;
>> +
>> +       user_addr = amdgpu_userq_va_align(addr);
>> +
>> +       if (amdgpu_bo_reserve(vm->root.bo, false))
>> +               return false;
>> +
>> +       mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
>> +       if (!IS_ERR_OR_NULL(mapping) && mapping->bo_va->queue_refcount > 0)
>> +               r = true;
>> +       else
>> +               r = false;
>> +       amdgpu_bo_unreserve(vm->root.bo);
>> +
>> +       return r;
>> +}
>> +
>> +bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
>> +                       struct amdgpu_usermode_queue *queue)
>> +{
>> +
>> +       if (amdgpu_userq_buffer_va_mapped(vm, queue->queue_va) ||
>> +           amdgpu_userq_buffer_va_mapped(vm, queue->rptr_va) ||
>> +           amdgpu_userq_buffer_va_mapped(vm, queue->wptr_va) ||
>> +           amdgpu_userq_buffer_va_mapped(vm, queue->eop_va) ||
>> +           amdgpu_userq_buffer_va_mapped(vm, queue->shadow_va) ||
>> +           amdgpu_userq_buffer_va_mapped(vm, queue->csa_va))
> 
> Only some of these are relevant for each queue type.  Rather than
> checking all of the critical buffers in all of your helper functions,
> it might be cleaner to add new userq callbacks that only check/update
> the relevant buffers for the queue type.
> 
>> +               return true;
>> +       else
>> +               return false;
>> +}
>> +
>> +int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr)
>> +{
>> +       struct amdgpu_bo_va_mapping *mapping;
>> +       u64 user_addr;
>> +       int r;
>> +
>> +       user_addr = amdgpu_userq_va_align(addr);
>> +       r = amdgpu_bo_reserve(vm->root.bo, false);
>> +       if (r)
>> +               return r;
>> +
>> +       mapping = amdgpu_vm_bo_lookup_mapping(vm, user_addr);
>> +       if (!mapping)
>> +               goto out_err;
>> +       /*
>> +        * If here refer to the userq VM BOs and keep the usage count by
>> +        * amdgpu_bo_ref(mapping->bo_va->base.bo) at creating the userq IOCTL,
>> +        * this reference and usage counter will be kept until amdgpu_userq_destroy(),
>> +        * while the userq VA is unmapped at amdgpu_vm_bo_unmap(), which is ahead of
>> +        * amdgpu_userq_destroy(). So, when amdgpu_vm_bo_unmap() tries to unmap the
>> +        * userq VA mapping, it will result in an unmap error caused by the BO's reference.
>> +        */
>> +       /*amdgpu_bo_unref(&mapping->bo_va->base.bo);*/
> 
> I still don't follow this.  Why can't we get a reference in userq
> create and put the reference in userq destroy.  If the app is freeing
> the buffers before the queue, that's an app bug.

We should probably just signal the eviction fence when the application tries to unmap a BO which is vital for an user queue.

On restoring the evicted queue we then check again if all the VAs needed for this queue are valid and if they aren't we deny resuming the queue.

Christian.

> 
> Alex
> 
>> +
>> +       mapping->bo_va->queue_refcount--;
>> +
>> +       amdgpu_bo_unreserve(vm->root.bo);
>> +       return 0;
>> +
>> +out_err:
>> +       amdgpu_bo_unreserve(vm->root.bo);
>> +       return -EINVAL;
>> +}
>> +
>> +static void amdgpu_userq_buffer_vas_get(struct amdgpu_vm *vm,
>> +                       struct amdgpu_usermode_queue *queue)
>> +{
>> +       amdgpu_userq_buffer_va_get(vm, queue->queue_va);
>> +       amdgpu_userq_buffer_va_get(vm, queue->rptr_va);
>> +       amdgpu_userq_buffer_va_get(vm, queue->wptr_va);
>> +       amdgpu_userq_buffer_va_get(vm, queue->eop_va);
>> +       amdgpu_userq_buffer_va_get(vm, queue->shadow_va);
>> +       amdgpu_userq_buffer_va_get(vm, queue->csa_va);
>> +}
>> +
>> +int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
>> +                       struct amdgpu_usermode_queue *queue)
>> +{
>> +       amdgpu_userq_buffer_va_put(vm, queue->queue_va);
>> +       amdgpu_userq_buffer_va_put(vm, queue->rptr_va);
>> +       amdgpu_userq_buffer_va_put(vm, queue->wptr_va);
>> +       amdgpu_userq_buffer_va_put(vm, queue->eop_va);
>> +       amdgpu_userq_buffer_va_put(vm, queue->shadow_va);
>> +       amdgpu_userq_buffer_va_put(vm, queue->csa_va);
>> +
>> +       return 0;
>> +}
>> +
>>  static int
>>  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>>                           struct amdgpu_usermode_queue *queue)
>> @@ -442,6 +570,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>         queue->queue_type = args->in.ip_type;
>>         queue->vm = &fpriv->vm;
>>         queue->priority = priority;
>> +       queue->queue_va = args->in.queue_va;
>> +       queue->rptr_va = args->in.rptr_va;
>> +       queue->wptr_va = args->in.wptr_va;
>>
>>         db_info.queue_type = queue->queue_type;
>>         db_info.doorbell_handle = queue->doorbell_handle;
>> @@ -472,7 +603,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>                 goto unlock;
>>         }
>>
>> -
>>         qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
>>         if (qid < 0) {
>>                 drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> index 704935ca0c36..194ec7a6b3b2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
>> @@ -52,6 +52,13 @@ struct amdgpu_usermode_queue {
>>         enum amdgpu_userq_state state;
>>         uint64_t                doorbell_handle;
>>         uint64_t                doorbell_index;
>> +       uint64_t                queue_va;
>> +       uint64_t                rptr_va;
>> +       uint64_t                wptr_va;
>> +       uint64_t                eop_va;
>> +       uint64_t                shadow_va;
>> +       uint64_t                csa_va;
>> +
>>         uint64_t                flags;
>>         struct amdgpu_mqd_prop  *userq_prop;
>>         struct amdgpu_userq_mgr *userq_mgr;
>> @@ -134,4 +141,11 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
>>
>>  int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
>>                         u64 expected_size);
>> +int amdgpu_userq_buffer_va_get(struct amdgpu_vm *vm, u64 addr);
>> +bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr);
>> +bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
>> +                       struct amdgpu_usermode_queue *queue);
>> +int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr);
>> +int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
>> +                       struct amdgpu_usermode_queue *queue);
>>  #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> index 4615d3fba530..c9cde14064d1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> @@ -263,6 +263,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>>                 userq_props->hqd_active = false;
>>                 userq_props->tmz_queue =
>>                         mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
>> +               queue->eop_va = compute_mqd->eop_va;
>>                 kfree(compute_mqd);
>>         } else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
>>                 struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
>> @@ -284,6 +285,8 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>>                 userq_props->csa_addr = mqd_gfx_v11->csa_va;
>>                 userq_props->tmz_queue =
>>                         mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
>> +               queue->shadow_va = mqd_gfx_v11->shadow_va;
>> +               queue->csa_va = mqd_gfx_v11->csa_va;
>>
>>                 if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11->shadow_va,
>>                                         shadow_info.shadow_size)) {
>> @@ -317,6 +320,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>>                 }
>>
>>                 userq_props->csa_addr = mqd_sdma_v11->csa_va;
>> +               queue->csa_va = mqd_sdma_v11->csa_va;
>>                 kfree(mqd_sdma_v11);
>>         }
>>
>> --
>> 2.34.1
>>


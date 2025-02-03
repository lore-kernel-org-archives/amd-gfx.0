Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6DCC02192
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2025 16:44:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D5BC10E50F;
	Mon,  3 Feb 2025 16:44:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PwiQATTK";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB42A10E50F
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2025 16:44:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4IOAJ/4ZCvHL1AlqgYbDAamhcTHnmk316RSEl1g6WloFsIjwibekp9wEcaXDrbUvFHOIhbiDP2/+8d+0IJRI3FKVZlqQEUNVHqCG2MRGkvtXUopLD6FklvA6AH+aJW35wxDbGUALicjuhKH5ar3Rb1tRpKFTmchxN3GWBlrPBUgpQc3VUl5a1UeXb2QgI+m3l1OD1W78Uy+Nz+7OgNm1pryDD1/55X48g4rcdBXdKf+PBfGcrpI6Cf+OvDG4I6h/UT6ZGI6Wjb/sNJw/mgNIwTsX78W8RAzotQL+JjwBQElhL8pxPpinZ7wg3iLgZHU5og0j0ggoRyyc+KOGCje7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0zi663S6sD0QZgjAtgww9DWFpFXSfpNgFFygBZ0eeA=;
 b=MZw+H/OLOPLXQ5QK7TipG2g8uXsir8ku1kzABKbII6M/LAr6mvWazDiim0876lS8D3xeykbl09vgiAB6sXOscrhlG2sxIeHwggli/6RIImHWS+Ej0cJgO8uc2SJh+xLZpVYnNehuvCUNyhOV6+CRQRQmzXGMqhXqNmppKZh/OfxFsAEf1idaNPV0Ja2MZBXhxqqz2fqV2MytTKWoA3jIcTG0Oh1pd2WtIbjuFNJe2JtXV0DNmog6Oxu2gPTSewFhQwG101ZLbvIFMX2qdbrNW9Phybj3vo4ItsF3bNQwxJpQU/6AQbxCX05jjDaze1sqATWaC8fgOMzh+ZULgvxnhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0zi663S6sD0QZgjAtgww9DWFpFXSfpNgFFygBZ0eeA=;
 b=PwiQATTKYfUhp1PbB0CLrPLYk2yV2sKq8EydNSpJI8XZ6dipAJqKryO4QlRoVIsHabJOLzXGp19/qMu3SuRqJ9EapLf2d5lBrV01/JzsPetcQorzgPcJtNJavYnFghyN0I5D14i5P9bhgN0QVV96o4x7yI0s/Ut7UDQzvo0wfc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB9036.namprd12.prod.outlook.com (2603:10b6:930:78::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.24; Mon, 3 Feb 2025 16:44:34 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 16:44:34 +0000
Message-ID: <4499ac1b-7487-4cdd-b7ff-0d7e930c6109@amd.com>
Date: Mon, 3 Feb 2025 22:14:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Fix get_if_active usage
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com,
 Alexander.Deucher@amd.com, pierre-eric.pelloux-prayer@amd.com,
 kenneth.feng@amd.com, mario.limonciello@amd.com
References: <20250201042639.1805796-1-lijo.lazar@amd.com>
 <CADnq5_Ns10DeL1PGzdq73_mArfX8E2Rz7P_56S1+hd+81JsjfQ@mail.gmail.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CADnq5_Ns10DeL1PGzdq73_mArfX8E2Rz7P_56S1+hd+81JsjfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0234.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::6) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB9036:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc40218-4370-485b-90f3-08dd447209d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MDFPeVhreUZzeTFoL1FqY0E5TXhYWmY4REU2Vk5LUnJxWGd2bmVqUGZ6RjJ3?=
 =?utf-8?B?SHE5dlR4VXJGRTc4aGh2T0tia1h5NWdlVnkyOUtuUG1DV0tlMytTV2lQa2U0?=
 =?utf-8?B?WERmblg1TGRlRll0a1JCQ1lTMW5NampvU2JlazRqOUJSYkxKVGZIbFdTMTlL?=
 =?utf-8?B?Y3ZyZWEyclhDN3lsTW00TWZtQlV3bC9NM3dzcWxSYUJaOEd4RlBHS0hiSUZr?=
 =?utf-8?B?WEIyWGRnelVNVW1rbFh6NjY5MjZSVm11MXpDNDRMZHBsVW01d2VXNE5SMmhB?=
 =?utf-8?B?YmhpREtMbFFJUmozeDdRVTdGQUh0cncwdHlZK3J2ZkV0Nm1oS21lWU9rWWhs?=
 =?utf-8?B?UnZMMjc5MkIzNFluaTJIY3Z0MzJZSlZId3Rxb0k0eUNGZUlZNDgxbW1paVlq?=
 =?utf-8?B?eXVWK2RFd0F5UmtqSkZCNkdUa2tYQ250anhsQlNtVGR2YStJQWNzWC9EQ2Ra?=
 =?utf-8?B?cU5SSUUyZ0lUdGtTN2twbUswUGRjL2ZYc0t6cFNwbUVlWGJ0TmdkTnYxM0l2?=
 =?utf-8?B?N2ZVUDk5Y1o2eVMxN0RHQVEwVk1yRVFvbEF6R0ppNjFBUUhJY1FwdHJLbkIx?=
 =?utf-8?B?cWRpazZ4NlBXTWoyZzk5L01NVit4aWpoazJsZ1h5QU5penVxbmNIWnlodFlk?=
 =?utf-8?B?ZnovYlZDbHZCRFJObVpmazkzSlZoVm05NFNnRGdvemkzUDY2S01yVXRINzJz?=
 =?utf-8?B?RXlOU3pMalU3Rk85UTJBcnhwOVFiOHcrV3ZRdStseERNdG5NU2xJaFFpM3BI?=
 =?utf-8?B?aGY2MjlNb2s3Q3ZpTVlTaE9GTlpLRHF5NkNKRGdZUnU1OENNLzRYMUhYeHJk?=
 =?utf-8?B?S09NSnJBL0l0MVBIUGFCcEdETHorY2Z3Rkx0U0k0S0NnN0pEK25RZXhZcUhO?=
 =?utf-8?B?elowZi8xNHpBNEtGUTdTVDg5Z2pyTzVRVy92YUduNC9QMHZOM3FPdENDMHhy?=
 =?utf-8?B?cjFJQnYyOVlYZktWYStHVG5VTXpGL3dzbG9lMG9VSVQwZ09SejhRMWtqeDhP?=
 =?utf-8?B?UzUvUkJUZlJkcmpCMHA1b0NuVW9JelhuZXQreW5SSWNkbm9ndnNyaFkrVFJv?=
 =?utf-8?B?cFh0YlBDSk5DUmd4Yll6UDQrYWUvTzU5ZjlFVGlTekZISkd1QlBYNm9QZVo3?=
 =?utf-8?B?bklURytCL2JFR3Fxc0ZtdDA2RVNsQXhFUDBMRDRxeTM5WFE4SDZldTZKSlBV?=
 =?utf-8?B?ODRTVWJEdUJBTEZGdHlkUHZwby9UeXB4YUh4WFZ2eXlsYWN0S3JmMEs2YlhV?=
 =?utf-8?B?ZE5vYkZwS3NiK0JVUitIOG9hamI3T01URzR1eGU2elgrTGdqRHhOQURoYUtC?=
 =?utf-8?B?MVlXR211Sm9MQzN4eUNScXRncFg3UTVQSjZIK2hxbkIraDFuNHpQZ3ZDanJi?=
 =?utf-8?B?aWFkd1gyWGFLZm41cUVOS09pckV0K1A1ZXNBN0RwS1hKWGNDQ3VZcmNhcFVO?=
 =?utf-8?B?cHduSU82ZzFTaXpSdjlSeTFjMDZlMEJBRFhuRTZNbVYxRzMyYW1xQnpnVFVa?=
 =?utf-8?B?L2ttR2VwcU4wYy9LMy9YNzZSRjFhakl0Z2VoWU5FREtqWWNUTlhGTm41RlhZ?=
 =?utf-8?B?MVd4ZzBqYmFDL3NkQldCcGpmeHNaS1JFei9CRTMvWnlSVVo2WDdyOE40ekI0?=
 =?utf-8?B?UTJxakNGd00vckpHMmhhVUVZTmRlM0hOWUduUzR4UWwyRHNIdm1Semx5TFZO?=
 =?utf-8?B?b3llc3RsNXVNT0xlQXhoMWdjZ00zZzNPay91UUhhWkFZUXFJN0FKVi9KcVIv?=
 =?utf-8?B?eFlWb3I1Z3U5R01qMTJUampJOWZ2WjU4VDJ2bXdXN1ZNSE91bkw4NFJGOTJB?=
 =?utf-8?B?R25EK2pNdWZuL3ZWUklpSEZpQmdNUitEdnFrdWdlWUVrcEF4S2M4VEVjNExI?=
 =?utf-8?Q?NYObxFgkdJQx4?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THRkZ2FZVGRnbkQ4czhHYVVuRHc2Nkx0dWpIZXgvbjJoR0JRY1JVZTE5b3E0?=
 =?utf-8?B?WGRxR1l4di8yekJTK2Q2WkZubUpLdEVIOEhLRUtZcDRmUFR1dUlVOUJZRkxy?=
 =?utf-8?B?VXczUU94bE9obWEwSkc0eEVxbFZPTDRNakwwWThDTEZRUFJZTWlMM21QUnVs?=
 =?utf-8?B?bVVhVU9Iak02YTN4czlUQjcwK0xIeWdMYVlKVGxVWExGOCtDTXl5SkxKb29P?=
 =?utf-8?B?ajMwZWxDemdhWlhBdTBxK2RGM1huUFFXM2pSdGdmcjlZVndOYlJEdzlrS3Ro?=
 =?utf-8?B?KzAybS8xRGhIMXN0cnF6WXdOWVhWcitaQXZudy9KNmgxaHFNbWFjWlR4Wmth?=
 =?utf-8?B?NENpWEVmaDRheVdhakhRcGluSCtzUnRNZ05qdUV5bWpQejBBbW1VSlA2QzlI?=
 =?utf-8?B?VGFjU1Z3TUM5UklHYUxEbWROTnVzRWxXRWkxZE41WC9sNSt2TWVBSHFOUlNQ?=
 =?utf-8?B?VVdiaEwvcGhjYUVuL2N3bmVLSzdjQWtKaldrZTg5dXJueWFXMDVpY3g3YlFZ?=
 =?utf-8?B?YU1qaXd5eDBhTUxkRG5qazVxYzgvWjgxVXBoRzNPRm9DTHVJTHJGRUlTdS8x?=
 =?utf-8?B?WHFmKzk5SHdZUjV6QjM0VmRseTFZcFlUcWFmVk13clI5ZHBUQ2QwNjZTNHk4?=
 =?utf-8?B?NVNGU2h1dHlvckN1TU0wWTgyRU9PbHhJQVMwU0U5SnFFYXltNWlMTG9Fd0Nj?=
 =?utf-8?B?RThwK3RmUTQ3Z0VQb1pkVFBGV1MxZCtSSG9vTkF4ZVo1TmdvTHRXZ1R6bHZM?=
 =?utf-8?B?ZjY5VExBd3g0UUV6Qis5LzVGVEZLMkRZNFh3ai9NaEtaQnNqd0lGQ1o0cDdQ?=
 =?utf-8?B?OU9mdGVKaCtaZHo5RHg5ck5KbVJ1MTlaaGdnbE53QmdOT2tLS0laMGcvUHNY?=
 =?utf-8?B?QW9TY2g2WkprTjhzbmdsdUZXSy9KOVZJN3h2SEdLcHByZnhDOUFrd1JYWjkx?=
 =?utf-8?B?WkJzNVZJeS8xM2NURUM0d1E2azBKOVZvVXdua3U0ZXBHUVdOSjJxME9ac3ZS?=
 =?utf-8?B?U1ZYVFRIY0JTYWxKWVByKzZ4K1dOeEVUdWRyTGNTcys2YnpXaFBjbSs5N1Aw?=
 =?utf-8?B?ei95TFZibFpMTGtLTjk0a3VDUW5ZZ3VVZVpOODNxcDdwV0JrNGVXZXU5cTlJ?=
 =?utf-8?B?RzdMVFRvejkxYXpza0NKWnkrNW9vTEoveDRhOFZ3dEFwaWpRazg0S3MzWWdR?=
 =?utf-8?B?ZDNZbkgyZlNOcS9NQ3RLQitqUkJNdzg1eTJWckVmQ040WlNBZ0poWE1GTXhr?=
 =?utf-8?B?OFpSR2RSWnpVN1pGZFY0NThlVHAzL0NaS2pwaFczVlFhTkRhb2QvQ3JSY2VY?=
 =?utf-8?B?TU55UEdYV3cyTkJvYW9RSklieFAvMlE1T01CRkhQT3hKejBYd0ZhUER3Si9a?=
 =?utf-8?B?ckNuVnFSZ0Q2cUZhOFFmUG0xeGRiaHB2eVpBN1NiUDZzVGduZnlCeFVxc3dH?=
 =?utf-8?B?dWdVRVlCK3JzMkpCb2ZtUVFGcHJINFk4V3MwVkM1MytZa1dDaCszYlVmdVRG?=
 =?utf-8?B?WjBORGZJdHVhQ3FiS0o5TEk3YlptRmJHRnJjenNibnZkOTlPTGRITXJmbkJB?=
 =?utf-8?B?bmFXeHFGbVZyNXY0aDg4Q2JROUJUMEpac1p5eE45UStGM2ZCcFpPWmVNc2VP?=
 =?utf-8?B?MzRDM3JmRUE0dzg3ckROV2w1dWtjWVpuLzZSNVJtM1NNMGE4d0tmN2t6cnln?=
 =?utf-8?B?N1dXTjRSaTcxTDRtMzFRdDF6RGRzRENNa1lzRHdnbVdEdEsyTVVmeFVweXFl?=
 =?utf-8?B?SDYxaGx0aDFpVk53Tk9qNEhmVmcvbkRnekNXUDJwR3JWWFBIWmp1YloySTln?=
 =?utf-8?B?azAxTmcxR2ZxNXNwMWc5R25vNnRqVkQ0VWRhcGFrNS9POHppN0NQZGNzVzda?=
 =?utf-8?B?bW9TcmRLYWZhM0dWN0E1Y3JFenMyYUs2Wk1pNWZDYURnSXRFckZTbWx6YmF1?=
 =?utf-8?B?NFhzN1JpU1NsZ3RJak1IVlViT0xJdlhzWndIcjliaEVRU0dDUFJrTlIwVlo1?=
 =?utf-8?B?aVY0UUhhZ0lRQk83ZGdwbkI3QUNWSFdlckt2N3FPOTJtb0dURm5lQW9MVTdj?=
 =?utf-8?B?Yi8yL0JqTWx6Mml6UmJGUmpoTXJIcjh2K1Qrd2VpNHJ2bUVGaS91UEpTcml3?=
 =?utf-8?Q?wCDfQnWHAXbiTKmFX91VbyEmn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc40218-4370-485b-90f3-08dd447209d8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 16:44:34.2543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9WLDAyFTQduPzN4sy8BYFiwCu2afxcwYez4NIWdHjfJKjqDW/otMIt2qGHVGH01
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9036
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



On 2/3/2025 9:36 PM, Alex Deucher wrote:
> On Fri, Jan 31, 2025 at 11:53 PM Lijo Lazar <lijo.lazar@amd.com> wrote:
>>
>> If a device supports runtime pm, then pm_runtime_get_if_active returns 0
>> if a device is not active and 1 if already active. However, if a device
>> doesn't support runtime pm, the API returns -EINVAL. A device not
>> supporting runtime pm implies it's not affected by runtime pm and it's
>> active. Hence no need to get() to increment usage count. Remove < 0
>> return value check.
> 
> Might be worth mentioning that this happens when CONFIG_PM is not set
> assuming that is the case. 

From what I see, this looks to be the generic way to use this API
regardless of CONFIG_PM. When CONFIG_PM is not set, the stub API gives
the error code which is inline with the case when runtime pm is disabled
for the device.

 More future proof to move all of these
> duplicated checks into a common helper? 

Yes, this makes sense.

Also is it possible we might
> miss errors with this change in the runtime pm enabled case?  E.g., if
> a previous resume failed.

Probably, this needs to be addressed differently -

        if (adev->in_suspend && !adev->in_runpm)
                return -EPERM;

We have this check already; we may not need the second in_runpm anymore
as now the behavior is to allow operation on the device only if it's active.

Thanks,
Lijo

> 
> Alex
> 
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>
>> Fixes: 6e796cb4a972b ("drm/amd/pm: use pm_runtime_get_if_active for debugfs getters")
>> ---
>>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 129 +++++++++++------------------
>>  1 file changed, 48 insertions(+), 81 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> index 0aca0803514e..a8db2d3c9154 100644
>> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
>> @@ -138,16 +138,14 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
>>         struct drm_device *ddev = dev_get_drvdata(dev);
>>         struct amdgpu_device *adev = drm_to_adev(ddev);
>>         enum amd_pm_state_type pm;
>> -       int ret;
>>
>>         if (amdgpu_in_reset(adev))
>>                 return -EPERM;
>>         if (adev->in_suspend && !adev->in_runpm)
>>                 return -EPERM;
>>
>> -       ret = pm_runtime_get_if_active(ddev->dev);
>> -       if (ret <= 0)
>> -               return ret ?: -EPERM;
>> +       if (!pm_runtime_get_if_active(adev->dev))
>> +               return -EPERM;
>>
>>         amdgpu_dpm_get_current_power_state(adev, &pm);
>>
>> @@ -261,16 +259,14 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>>         struct drm_device *ddev = dev_get_drvdata(dev);
>>         struct amdgpu_device *adev = drm_to_adev(ddev);
>>         enum amd_dpm_forced_level level = 0xff;
>> -       int ret;
>>
>>         if (amdgpu_in_reset(adev))
>>                 return -EPERM;
>>         if (adev->in_suspend && !adev->in_runpm)
>>                 return -EPERM;
>>
>> -       ret = pm_runtime_get_if_active(ddev->dev);
>> -       if (ret <= 0)
>> -               return ret ?: -EPERM;
>> +       if (!pm_runtime_get_if_active(adev->dev))
>> +               return -EPERM;
>>
>>         level = amdgpu_dpm_get_performance_level(adev);
>>
>> @@ -357,16 +353,15 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
>>         struct amdgpu_device *adev = drm_to_adev(ddev);
>>         struct pp_states_info data;
>>         uint32_t i;
>> -       int buf_len, ret;
>> +       int buf_len;
>>
>>         if (amdgpu_in_reset(adev))
>>                 return -EPERM;
>>         if (adev->in_suspend && !adev->in_runpm)
>>                 return -EPERM;
>>
>> -       ret = pm_runtime_get_if_active(ddev->dev);
>> -       if (ret <= 0)
>> -               return ret ?: -EPERM;
>> +       if (!pm_runtime_get_if_active(adev->dev))
>> +               return -EPERM;
>>
>>         if (amdgpu_dpm_get_pp_num_states(adev, &data))
>>                 memset(&data, 0, sizeof(data));
>> @@ -399,9 +394,8 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
>>         if (adev->in_suspend && !adev->in_runpm)
>>                 return -EPERM;
>>
>> -       ret = pm_runtime_get_if_active(ddev->dev);
>> -       if (ret <= 0)
>> -               return ret ?: -EPERM;
>> +       if (!pm_runtime_get_if_active(adev->dev))
>> +               return -EPERM;
>>
>>         amdgpu_dpm_get_current_power_state(adev, &pm);
>>
>> @@ -519,16 +513,15 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
>>         struct drm_device *ddev = dev_get_drvdata(dev);
>>         struct amdgpu_device *adev = drm_to_adev(ddev);
>>         char *table = NULL;
>> -       int size, ret;
>> +       int size;
>>
>>         if (amdgpu_in_reset(adev))
>>                 return -EPERM;
>>         if (adev->in_suspend && !adev->in_runpm)
>>                 return -EPERM;
>>
>> -       ret = pm_runtime_get_if_active(ddev->dev);
>> -       if (ret <= 0)
>> -               return ret ?: -EPERM;
>> +       if (!pm_runtime_get_if_active(adev->dev))
>> +               return -EPERM;
>>
>>         size = amdgpu_dpm_get_pp_table(adev, &table);
>>
>> @@ -840,9 +833,8 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>>         if (adev->in_suspend && !adev->in_runpm)
>>                 return -EPERM;
>>
>> -       ret = pm_runtime_get_if_active(ddev->dev);
>> -       if (ret <= 0)
>> -               return ret ?: -EPERM;
>> +       if (!pm_runtime_get_if_active(adev->dev))
>> +               return -EPERM;
>>
>>         for (clk_index = 0 ; clk_index < 6 ; clk_index++) {
>>                 ret = amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size);
>> @@ -923,16 +915,14 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
>>         struct drm_device *ddev = dev_get_drvdata(dev);
>>         struct amdgpu_device *adev = drm_to_adev(ddev);
>>         ssize_t size;
>> -       int ret;
>>
>>         if (amdgpu_in_reset(adev))
>>                 return -EPERM;
>>         if (adev->in_suspend && !adev->in_runpm)
>>                 return -EPERM;
>>
>> -       ret = pm_runtime_get_if_active(ddev->dev);
>> -       if (ret <= 0)
>> -               return ret ?: -EPERM;
>> +       if (!pm_runtime_get_if_active(adev->dev))
>> +               return -EPERM;
>>
>>         size = amdgpu_dpm_get_ppfeature_status(adev, buf);
>>         if (size <= 0)
>> @@ -996,9 +986,8 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
>>         if (adev->in_suspend && !adev->in_runpm)
>>                 return -EPERM;
>>
>> -       ret = pm_runtime_get_if_active(ddev->dev);
>> -       if (ret <= 0)
>> -               return ret ?: -EPERM;
>> +       if (!pm_runtime_get_if_active(adev->dev))
>> +               return -EPERM;
>>
>>         ret = amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
>>         if (ret == -ENOENT)
>> @@ -1238,16 +1227,14 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
>>         struct drm_device *ddev = dev_get_drvdata(dev);
>>         struct amdgpu_device *adev = drm_to_adev(ddev);
>>         uint32_t value = 0;
>> -       int ret;
>>
>>         if (amdgpu_in_reset(adev))
>>                 return -EPERM;
>>         if (adev->in_suspend && !adev->in_runpm)
>>                 return -EPERM;
>>
>> -       ret = pm_runtime_get_if_active(ddev->dev);
>> -       if (ret <= 0)
>> -               return ret ?: -EPERM;
>> +       if (!pm_runtime_get_if_active(adev->dev))
>> +               return -EPERM;
>>
>>         value = amdgpu_dpm_get_sclk_od(adev);
>>
>> @@ -1295,16 +1282,14 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
>>         struct drm_device *ddev = dev_get_drvdata(dev);
>>         struct amdgpu_device *adev = drm_to_adev(ddev);
>>         uint32_t value = 0;
>> -       int ret;
>>
>>         if (amdgpu_in_reset(adev))
>>                 return -EPERM;
>>         if (adev->in_suspend && !adev->in_runpm)
>>                 return -EPERM;
>>
>> -       ret = pm_runtime_get_if_active(ddev->dev);
>> -       if (ret <= 0)
>> -               return ret ?: -EPERM;
>> +       if (!pm_runtime_get_if_active(adev->dev))
>> +               return -EPERM;
>>
>>         value = amdgpu_dpm_get_mclk_od(adev);
>>
>> @@ -1376,16 +1361,14 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
>>         struct drm_device *ddev = dev_get_drvdata(dev);
>>         struct amdgpu_device *adev = drm_to_adev(ddev);
>>         ssize_t size;
>> -       int ret;
>>
>>         if (amdgpu_in_reset(adev))
>>                 return -EPERM;
>>         if (adev->in_suspend && !adev->in_runpm)
>>                 return -EPERM;
>>
>> -       ret = pm_runtime_get_if_active(ddev->dev);
>> -       if (ret <= 0)
>> -               return ret ?: -EPERM;
>> +       if (!pm_runtime_get_if_active(adev->dev))
>> +               return -EPERM;
>>
>>         size = amdgpu_dpm_get_power_profile_mode(adev, buf);
>>         if (size <= 0)
>> @@ -1471,9 +1454,8 @@ static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
>>         if (adev->in_suspend && !adev->in_runpm)
>>                 return -EPERM;
>>
>> -       r = pm_runtime_get_if_active(adev->dev);
>> -       if (r <= 0)
>> -               return r ?: -EPERM;
>> +       if (!pm_runtime_get_if_active(adev->dev))
>> +               return -EPERM;
>>
>>         /* get the sensor value */
>>         r = amdgpu_dpm_read_sensor(adev, sensor, query, &size);
>> @@ -1574,7 +1556,6 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
>>         struct drm_device *ddev = dev_get_drvdata(dev);
>>         struct amdgpu_device *adev = drm_to_adev(ddev);
>>         uint64_t count0 = 0, count1 = 0;
>> -       int ret;
>>
>>         if (amdgpu_in_reset(adev))
>>                 return -EPERM;
>> @@ -1587,9 +1568,8 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
>>         if (!adev->asic_funcs->get_pcie_usage)
>>                 return -ENODATA;
>>
>> -       ret = pm_runtime_get_if_active(ddev->dev);
>> -       if (ret <= 0)
>> -               return ret ?: -EPERM;
>> +       if (!pm_runtime_get_if_active(adev->dev))
>> +               return -EPERM;
>>
>>         amdgpu_asic_get_pcie_usage(adev, &count0, &count1);
>>
>> @@ -1715,9 +1695,8 @@ static ssize_t amdgpu_get_apu_thermal_cap(struct device *dev,
>>         struct drm_device *ddev = dev_get_drvdata(dev);
>>         struct amdgpu_device *adev = drm_to_adev(ddev);
>>
>> -       ret = pm_runtime_get_if_active(ddev->dev);
>> -       if (ret <= 0)
>> -               return ret ?: -EPERM;
>> +       if (!pm_runtime_get_if_active(adev->dev))
>> +               return -EPERM;
>>
>>         ret = amdgpu_dpm_get_apu_thermal_limit(adev, &limit);
>>         if (!ret)
>> @@ -1784,16 +1763,14 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
>>         struct drm_device *ddev = dev_get_drvdata(dev);
>>         struct amdgpu_device *adev = drm_to_adev(ddev);
>>         ssize_t size = 0;
>> -       int ret;
>>
>>         if (amdgpu_in_reset(adev))
>>                 return -EPERM;
>>         if (adev->in_suspend && !adev->in_runpm)
>>                 return -EPERM;
>>
>> -       ret = pm_runtime_get_if_active(ddev->dev);
>> -       if (ret <= 0)
>> -               return ret ?: -EPERM;
>> +       if (!pm_runtime_get_if_active(adev->dev))
>> +               return -EPERM;
>>
>>         size = amdgpu_dpm_get_pm_metrics(adev, buf, PAGE_SIZE);
>>
>> @@ -1822,16 +1799,14 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
>>         struct amdgpu_device *adev = drm_to_adev(ddev);
>>         void *gpu_metrics;
>>         ssize_t size = 0;
>> -       int ret;
>>
>>         if (amdgpu_in_reset(adev))
>>                 return -EPERM;
>>         if (adev->in_suspend && !adev->in_runpm)
>>                 return -EPERM;
>>
>> -       ret = pm_runtime_get_if_active(ddev->dev);
>> -       if (ret <= 0)
>> -               return ret ?: -EPERM;
>> +       if (!pm_runtime_get_if_active(adev->dev))
>> +               return -EPERM;
>>
>>         size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
>>         if (size <= 0)
>> @@ -2709,9 +2684,8 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>>         if (adev->in_suspend && !adev->in_runpm)
>>                 return -EPERM;
>>
>> -       ret = pm_runtime_get_if_active(adev->dev);
>> -       if (ret <= 0)
>> -               return ret ?: -EPERM;
>> +       if (!pm_runtime_get_if_active(adev->dev))
>> +               return -EPERM;
>>
>>         ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>>
>> @@ -2837,9 +2811,8 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
>>         if (adev->in_suspend && !adev->in_runpm)
>>                 return -EPERM;
>>
>> -       err = pm_runtime_get_if_active(adev->dev);
>> -       if (err <= 0)
>> -               return err ?: -EPERM;
>> +       if (!pm_runtime_get_if_active(adev->dev))
>> +               return -EPERM;
>>
>>         err = amdgpu_dpm_get_fan_speed_pwm(adev, &speed);
>>
>> @@ -2864,9 +2837,8 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
>>         if (adev->in_suspend && !adev->in_runpm)
>>                 return -EPERM;
>>
>> -       err = pm_runtime_get_if_active(adev->dev);
>> -       if (err <= 0)
>> -               return err ?: -EPERM;
>> +       if (!pm_runtime_get_if_active(adev->dev))
>> +               return -EPERM;
>>
>>         err = amdgpu_dpm_get_fan_speed_rpm(adev, &speed);
>>
>> @@ -2925,9 +2897,8 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
>>         if (adev->in_suspend && !adev->in_runpm)
>>                 return -EPERM;
>>
>> -       err = pm_runtime_get_if_active(adev->dev);
>> -       if (err <= 0)
>> -               return err ?: -EPERM;
>> +       if (!pm_runtime_get_if_active(adev->dev))
>> +               return -EPERM;
>>
>>         err = amdgpu_dpm_get_fan_speed_rpm(adev, &rpm);
>>
>> @@ -2995,9 +2966,8 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
>>         if (adev->in_suspend && !adev->in_runpm)
>>                 return -EPERM;
>>
>> -       ret = pm_runtime_get_if_active(adev->dev);
>> -       if (ret <= 0)
>> -               return ret ?: -EPERM;
>> +       if (!pm_runtime_get_if_active(adev->dev))
>> +               return -EPERM;
>>
>>         ret = amdgpu_dpm_get_fan_control_mode(adev, &pwm_mode);
>>
>> @@ -3162,9 +3132,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
>>         if (adev->in_suspend && !adev->in_runpm)
>>                 return -EPERM;
>>
>> -       r = pm_runtime_get_if_active(adev->dev);
>> -       if (r <= 0)
>> -               return r ?: -EPERM;
>> +       if (!pm_runtime_get_if_active(adev->dev))
>> +               return -EPERM;
>>
>>         r = amdgpu_dpm_get_power_limit(adev, &limit,
>>                                       pp_limit_level, power_type);
>> @@ -3693,16 +3662,14 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
>>                                        char *buf)
>>  {
>>         int size = 0;
>> -       int ret;
>>
>>         if (amdgpu_in_reset(adev))
>>                 return -EPERM;
>>         if (adev->in_suspend && !adev->in_runpm)
>>                 return -EPERM;
>>
>> -       ret = pm_runtime_get_if_active(adev->dev);
>> -       if (ret <= 0)
>> -               return ret ?: -EPERM;
>> +       if (!pm_runtime_get_if_active(adev->dev))
>> +               return -EPERM;
>>
>>         size = amdgpu_dpm_print_clock_levels(adev, od_type, buf);
>>         if (size == 0)
>> --
>> 2.25.1
>>


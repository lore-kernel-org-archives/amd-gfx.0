Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA097E7719A
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 22:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92D2210E95F;
	Wed,  8 Jan 2025 22:04:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fWef147S";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABF5010E95F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 22:04:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Htg6JEe/OJPSbsqscljnl/ASnUvDEd4bbD/Vdiledefk+cfznhk9WQx6s2PG15VG2zZe0LlGNPR6hDNJUq0uQbXtw7cBYIdmcg5ho2uX2vpt34ISxqgWC+V96xDywB2E9Jtmd8H3EdwzGh8D7CgDIsbHAMVdb11UJyh4Zt1JaqJPtWDkXSNPMMUQmGjYJhrvIV0sGwC5X5EuSp2SfNFfT/4spLIV/mE8v+OnPz/3iqVyi0hZVPLbFopORV+/B/+GrLi8BYj3y9wNS1C9ZhxLOXoyfkP7wnqJVoKkDwfJem0N+HUS31Z9uI7ghxGLRdWqNWiT1SPH00Eo4PPRgklHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXhWPQD4/7XeYzoVSzf0B6qeBaO8q/Yz+6Gb/MGfDiY=;
 b=dAEPWAmvt22si/ynGHbAvOjGSa+2gB9Ir098nVDDEtSUO9ZsP83vl01V0EIFYqWT7ZgxVjj8SuCIIpL80ubEFqXJty4D064D3CUi7DX0k3CKL7TjFddCyfy3n+OrcWRvmU9DrtEVMMsX2Zt+u5msoFPA6CuTRV4LrjKkyJln/8HZhpBNf3uyTt4bqAJQnBPjJOXsIMoNFviWNo56JxQK2sTyTGqam7PkGhqc2fDMwKWUMu+4xRe7WJBTSSvndcjeTkQINXoQNHjfKHwaekqbCL5+NXf7xqlY7rSmVJdRY8JXkm6M2dNH1i5zuu3YxW41bKRI7lr+geV0eJ9DcMORvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXhWPQD4/7XeYzoVSzf0B6qeBaO8q/Yz+6Gb/MGfDiY=;
 b=fWef147SJwMv9xpA/JdbW0HIm9PbFK26PEIhfXUW5BuHY3TrNG7m+OJ+Kfl5dCMtOE0sqtLanJTGwzQbKg/aesstq3m8IYwi8P9hbpym4r53twuIeDOy+LOG778R2sU58B0aQ5TJ1Ke64wXUtL6/vjzBe6ZrCgVQ+0g0BNE0Pas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CH2PR12MB4054.namprd12.prod.outlook.com (2603:10b6:610:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 22:04:49 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%3]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 22:04:49 +0000
Content-Type: multipart/mixed; boundary="------------0xRrRzTEPzOkYylIjNuaYu06"
Message-ID: <8f3df358-e771-e2a5-68d8-266549a1af8d@amd.com>
Date: Wed, 8 Jan 2025 17:04:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] drm/amdkfd: Fix partial migrate issue
Content-Language: en-US
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250108131940.1435142-1-Emily.Deng@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20250108131940.1435142-1-Emily.Deng@amd.com>
X-ClientProxiedBy: YQBP288CA0016.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::15) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CH2PR12MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: 92826413-cc4c-4b49-cef6-08dd30307827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aHlvL3oxOFVDaFNRdE5hUUxuZmxKbU01K3IrOVpMTGF1OXhFOUVQZ3FPdURh?=
 =?utf-8?B?YUlBdnpTWHNOUjU4U2h1UHFCMk43QUhkS25qZ3NhekIrcFNjU3VYWENFUyty?=
 =?utf-8?B?eDlYNUZJZXo1TnVoTTFCYlFFdGNDMS9mblI3Z3BDWm1jQWh3aklIWmZ1U1Jv?=
 =?utf-8?B?aXl6YkxJRWtOVG1jYWNST0MwdS85NHdSUTlwV3pKUjVGbnVpNCthWkhZZDlX?=
 =?utf-8?B?QXFoUWhRMXp2WXhrWVpFYmNzeHhDbENCTTdDNGxucTE4Ym9YQ002d2RlV2pJ?=
 =?utf-8?B?S2w5Ykg5WFdpZVVFMGg4VG9pQzdGNWNiMm5USTZwbDdKNzNSWWVnNFRSR3pY?=
 =?utf-8?B?SzlneklCY1YxbmM4dk5HeWVzSHp1RFVSQ1ZMWmw1bWRONTdnQVk2R0k3ZHYy?=
 =?utf-8?B?NW5sdFVFbmpkZzFNUnlteEJBdlEwYndOalVma0JTejhOUlpWYVgxSVVuN2Ji?=
 =?utf-8?B?QVd6cStaSldGNjg4b1FNODQ2dTFUNmIzYXNVVlRVK0JMVnlSY1JTcU0zckRk?=
 =?utf-8?B?cnhMUFNJNHh6Yks1bTBTcUl4RU1iTW1mdEUxTU5UOUIzVEVKQkQwR0hrY3VG?=
 =?utf-8?B?ZVIzSWR0ajFVNGk5eVVVaFFzL3kzTHp1MGRJMVhaTnl4aHBEYWIyT2NZUThN?=
 =?utf-8?B?cEJlQXh5L1ZLblR4N2U2T25LUkp4VTgvanJ3aS9XQ1h2SGpWUTFncHhnSUtJ?=
 =?utf-8?B?YjZyUllrZ2hBWFQ1NVJtU1lUR3ZzMmpsOHNsOG9kb3pScDR0Y1ZCTW4vUW5h?=
 =?utf-8?B?bFQyeTJubUN2QlltYUFYTURSaXVKSUZxNHlXSW15aFRhVWJhQy9EVXkyeUtX?=
 =?utf-8?B?N1hJMDJuR2ZzQ3lQaXR1RktqOWlrcXAzY1hwNmhud1Y0QkZHNmQrcy9CQ1FG?=
 =?utf-8?B?OTlzc3p5VTg3SjFIeE5HWkloQi9BZFNwaklrRVlDbStTUW54MzJaUHNpRkpi?=
 =?utf-8?B?b0JqcC9zbjZTSTdrdGM1S3pweXF4RE1QdVFsOEQxZGNIVzVheE05bDdhTk5T?=
 =?utf-8?B?MURjc0E5T2RnQUlFRy94T0JlWVZKWVBaRFd1TEhuUUNlNVVad3NCTXlSVzRq?=
 =?utf-8?B?R2g1eW1uaW9wd0YrNnRYeEhJYUk2SmYwODhVdE9zTlY1WHVCWW5xMmlrU3Jw?=
 =?utf-8?B?NWYvVy93dEhKTVNPc2pJZCtCaXRjMnp3eGJObml1eXNGaGhBSmFJSFJYQ05D?=
 =?utf-8?B?OGNBZkVxeDMrQThGeVord3MrWlJCRElIS2tlL0hxWWJiQ2lzNzVqeDgyQTM4?=
 =?utf-8?B?eWxiSW9CVlNHR2Q1d3VUdDZMSVBJZ1Q1VjkyaERhVUdFUUxYd2pNUURjbENE?=
 =?utf-8?B?RnRrOTRHOXAycWZZQ0JySmhpNnl0VE1sTjZiNi9FSnlXeWF3NHd1NXhBMkRo?=
 =?utf-8?B?Wk9rUWlVbElqTzhsS2RPa0FaUW5wbkJVcStyeWo4MjNDZDFhMkthV1p0M25m?=
 =?utf-8?B?QnovTnZkN2NHQU1WTG50ZTF1V2NqTU1lYkNaa0t1RjNkUERNYUFsNXcrNjZO?=
 =?utf-8?B?KzAzUTVSU3p3OTJYVi9VU3FRb2VKUTBkUWJWWWNiZExPNnEzNnBtTENtWmlj?=
 =?utf-8?B?NXpicjduaWk3ODM0b1VWM004WHBZSWwvT0xjcis0clB3dHBQcDdIb1R3MllN?=
 =?utf-8?B?NTZ0Vmk1WUg0bWZCVnRGT3pYSC9IVDFLYmJ4dEpPOEIvZTNyb0hFNEtja01q?=
 =?utf-8?B?NXZyanJXZlo2S3Awc2Z2QVhUL2pQWSs2TThTUTc4T2FnRHpETU1hMHE2N2hN?=
 =?utf-8?B?T2tNbmxBM0F2Y0t0RjdnNTRhVForTHJwN24vVndpZXZoWVhwTTA5bDZkcWFy?=
 =?utf-8?B?empTQnduR0V3Uk45bGFlQ2ZEOWd0ME1qR2M1UXRWR0NUQVo0NitML25rb2NH?=
 =?utf-8?Q?Zrt5vJZgx93On?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXZRMUFQbnJrNVlBOGhnbFU5OExnaFEzMUpmcUZCUEVuRTJSQWxiNW1kYjJx?=
 =?utf-8?B?bFVaU1gzRFVpZ244WHcwRStsQVNLNVZwbVZ0d0pkSmFZbHpvS1FVM1RldVZ1?=
 =?utf-8?B?L2JvenVQM2pRTXNzSk5nR2k5N2RzeHJXOUF6UUw3OUczMEl6dlNaUGpqREpo?=
 =?utf-8?B?V3lDQ256SlVrN25XZE1hdWFZQ1VmbldERjkxN05hUFpjMlBTS0MzNTNOZFJC?=
 =?utf-8?B?WSszaXZPTk5VVTZpeUc2RFZxL3lHZXNXaHZPNHpGamNSZVVqUDFLbktSOUFt?=
 =?utf-8?B?VUFocU5rR0dHaExyUzlRZE1TUUNoeXc5NVVXNDhpR1NwNlc5TE5xbWpLRmN3?=
 =?utf-8?B?OFpzTlVjVEV1enp2Vlp3NGNVcmVONkxWZUlENFVqeEJjLzI1YWUyUm12N2VT?=
 =?utf-8?B?bjVJUlQzaHRZQ1JpTGhRVGNiejdiSE1tWDE4OFI3czBSNE4zWG80SUxkQ21N?=
 =?utf-8?B?QlRFZjF4RTNIckwremJmNUVRZ0Nrakl1S083RVhOa3hycHBnWm1DZi9tUEIz?=
 =?utf-8?B?VkVYVVAwQ2ZIRG5aOUFSNzJWMTV6WkRaVmRnbGRUNEhDcmRkVHg3d0JzamI4?=
 =?utf-8?B?S3Y0S2p4UFFMUzhaVXFXYXBKOFV3S1A5cXlBZGpDZ21EcDNyZEhrWGVjeEdF?=
 =?utf-8?B?aDZMQ0RUN0R2OEs0THpiaktVeG4wL0xqd0xCbE10RDhsZzVYTWF5c1k2QjVK?=
 =?utf-8?B?UGhUMGVQRkN2VEZJZjhDT2pxTGt2WFFzWjZOZ0hHUkRWM0RVUnBTT2o3NEU2?=
 =?utf-8?B?aWV1bTRSZVlxeERuaURyVjJ3dFYvVnl0L0FValZWOTcySHA1N3I3SkI0ZDJQ?=
 =?utf-8?B?Q3pUemhNbm9qVDVSTGR0SjVFS3AyL212VW9rYUQrbkNNeFgrbE00Y3ArMW9D?=
 =?utf-8?B?bmFTUnZtV0xMTlFMbHdLTGNYRjJTOTNCNnRNdzh4WmFIN0g0K3Y5Uzl4VDhp?=
 =?utf-8?B?V01Nd3lheGVGMHNDYmJ4Z2F4TlRZSUd2U09MRkhkQ2x2eFVyUHp5b1BKNmlw?=
 =?utf-8?B?NWVURzVxOE41SEFvTi9TcEhtUlh1emJsbFc4SVIxWUxkMk9HZncva3QzeWds?=
 =?utf-8?B?eU9YMW1nQzlvQ1lLdCt0a1RtN2haaFp3RTFoMWdXUlZxSlNHN1U2aXkvbFlW?=
 =?utf-8?B?dW1zRW82dlhUQnB2UGUrOVFGSzNGamZLUmYvbjEvUVVBSTNuVGJLa2Y5Tkp5?=
 =?utf-8?B?YkNUekJRUStPSXJuTU5ObEZIWVF0dk1EVzVqcE1SN2h3Q3R1cWY3S1ZMSVR3?=
 =?utf-8?B?MDJMWkdCU3JBY2dEU3ZXVXVHT29jL0dFR2taNUQrTW42WHQ0aHRmVjVRT2Vz?=
 =?utf-8?B?UXNIUHJiWTk0c2JERVY1NUhvMTVaNkNZZlpXci9oQmdOWWttdWNSRDRQWHNL?=
 =?utf-8?B?OU45VkZjTmVXUW9FVWxvN0FTRk9COVZjblJwWVg4ZzhPaHg4REgxb1NBMndO?=
 =?utf-8?B?YWY0eE1hSjNhWXgxa1IrV3MxcWliNzJqeXluVzdRdTQrWk96UGtUSzJjcjRp?=
 =?utf-8?B?QmJpNjZoWmR2QjdkTzdadzMzY3RrbkFTTk1SRXQzUGFSMDR4Rkk1SG80QW1E?=
 =?utf-8?B?R21KOHVzWTdXU3Q2cWh3eENicDM1V0EwU3lBRytRUHZZR0tGK1BuVTVHYUp6?=
 =?utf-8?B?OUJ2ajhjY3ZVSGJnV2QrU2hNZG00a0FDVFZEaVMxeE1aSytpTjBXT2pzVHZr?=
 =?utf-8?B?RmVRTWw5NDljYkxPRFB0QlZBanhSQW1TMVFDbm5PV3h4emRyS25DVlhteUlh?=
 =?utf-8?B?cXJNaVY0WXdIbEdLVlUyK0NnSEs2R0piUUlDYXNybSszMkFFU1BCZFJoeEdL?=
 =?utf-8?B?UjJ3VzFWdUdVWHF2RDBjQVJ0NHhJak80RjNOMWdVcVZTdzNmSkRKQjJqaVBT?=
 =?utf-8?B?NHIrMzNDaFpEamw2dDZGVW4xNnlaM2pSL3JZTFFwSUVJOTZ6Z2lLdSt4c0dF?=
 =?utf-8?B?OURmc2FmNkdHMlErT3dTckp4b0JSaHhIN2RmWXVKZG9FREoweXhVNU5JRXVa?=
 =?utf-8?B?cW82OTI4Q084dlFteXlFQVdleXZiU01naG14NVcrOGxLUkRIa3pCU3JMd1Fy?=
 =?utf-8?B?eWhmbUFFVTZaOEQzcEZRUldDbnFqLy9NSk5VZGhQcmNKZktybXNmN0s5emlF?=
 =?utf-8?Q?0AOuITboi2WR76Hc0MKHwxQ0l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92826413-cc4c-4b49-cef6-08dd30307827
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 22:04:49.0454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3miSWxpXE5SdnVBKjsO1syMCjBRTg3OKksoZa/n2Kf8NzODH6gIptLxEVqwgctNx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4054
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

--------------0xRrRzTEPzOkYylIjNuaYu06
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2025-01-08 08:19, Emily Deng wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20250108131940.1435142-1-Emily.Deng@amd.com">
      <pre class="moz-quote-pre" wrap="">For partial migrate from ram to vram, the migrate-&gt;cpages is not
equal to migrate-&gt;npages, should use migrate-&gt;npages to check all needed
migrate pages which could be copied or not.

And only need to set those pages could be migrated to migrate-&gt;dst[i], or
the migrate_vma_pages will migrate the wrong pages based on the migrate-&gt;dst[i].

v2:
Add mpages to break the loop earlier.

v3:
Uses MIGRATE_PFN_MIGRATE to identify whether page could be migrated.

Signed-off-by: Emily Deng <a class="moz-txt-link-rfc2396E" href="mailto:Emily.Deng@amd.com">&lt;Emily.Deng@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index eacfeb32f35d..b671d12c32f6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -278,10 +278,11 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 			 struct migrate_vma *migrate, struct dma_fence **mfence,
 			 dma_addr_t *scratch, uint64_t ttm_res_offset)
 {
-	uint64_t npages = migrate-&gt;cpages;
+	uint64_t npages = migrate-&gt;npages;
 	struct amdgpu_device *adev = node-&gt;adev;
 	struct device *dev = adev-&gt;dev;
 	struct amdgpu_res_cursor cursor;
+	uint64_t mpages = 0;
 	dma_addr_t *src;
 	uint64_t *dst;
 	uint64_t i, j;
@@ -295,14 +296,17 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struct svm_range *prange,
 
 	amdgpu_res_first(prange-&gt;ttm_res, ttm_res_offset,
 			 npages &lt;&lt; PAGE_SHIFT, &amp;cursor);
-	for (i = j = 0; i &lt; npages; i++) {
+	for (i = j = 0; (i &lt; npages) &amp;&amp; (mpages &lt; migrate-&gt;cpages); i++) {
 		struct page *spage;
 
 		dst[i] = cursor.start + (j &lt;&lt; PAGE_SHIFT);
-		migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
-		svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);
-		migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);
 
+		if (migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE) {</pre>
    </blockquote>
    This should check flag MIGRATE_PFN_VALID, same as
    migrate_pfn_to_page, so move this inside below if (spage....)
    <blockquote type="cite" cite="mid:20250108131940.1435142-1-Emily.Deng@amd.com">
      <pre class="moz-quote-pre" wrap="">
+			migrate-&gt;dst[i] = svm_migrate_addr_to_pfn(adev, dst[i]);
+			svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);
+			migrate-&gt;dst[i] = migrate_pfn(migrate-&gt;dst[i]);
+			mpages++;</pre>
    </blockquote>
    increase mpages here is good, simpler than increasing mpages after
    each copy, as the last sdma copy outside loop will handle the
    remaining pages.<br>
    <blockquote type="cite" cite="mid:20250108131940.1435142-1-Emily.Deng@amd.com">
      <pre class="moz-quote-pre" wrap="">
+		}
 		spage = migrate_pfn_to_page(migrate-&gt;src[i]);
 		if (spage &amp;&amp; !is_zone_device_page(spage)) {
 			src[i] = dma_map_page(dev, spage, 0, PAGE_SIZE,
</pre>
    </blockquote>
    <p>out_free_vram_pages path error handling need fix to put, unlock
      all migrated pages too, please check changes attached, I only
      compile but didn't run test with the change.<br>
    </p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
  </body>
</html>
--------------0xRrRzTEPzOkYylIjNuaYu06
Content-Type: text/x-patch; charset=UTF-8; name="1.patch"
Content-Disposition: attachment; filename="1.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9taWdyYXRlLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfbWlncmF0ZS5jCmluZGV4IDRiMjc1OTM3ZDA1
ZS4uNTQ1NmEzNjY2ZGEzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9r
ZmRfbWlncmF0ZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9taWdyYXRl
LmMKQEAgLTI3OCwxMCArMjc4LDExIEBAIHN2bV9taWdyYXRlX2NvcHlfdG9fdnJhbShzdHJ1Y3Qg
a2ZkX25vZGUgKm5vZGUsIHN0cnVjdCBzdm1fcmFuZ2UgKnByYW5nZSwKIAkJCSBzdHJ1Y3QgbWln
cmF0ZV92bWEgKm1pZ3JhdGUsIHN0cnVjdCBkbWFfZmVuY2UgKiptZmVuY2UsCiAJCQkgZG1hX2Fk
ZHJfdCAqc2NyYXRjaCwgdWludDY0X3QgdHRtX3Jlc19vZmZzZXQpCiB7Ci0JdWludDY0X3QgbnBh
Z2VzID0gbWlncmF0ZS0+Y3BhZ2VzOworCXVpbnQ2NF90IG5wYWdlcyA9IG1pZ3JhdGUtPm5wYWdl
czsKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IG5vZGUtPmFkZXY7CiAJc3RydWN0IGRl
dmljZSAqZGV2ID0gYWRldi0+ZGV2OwogCXN0cnVjdCBhbWRncHVfcmVzX2N1cnNvciBjdXJzb3I7
CisJdWludDY0X3QgbXBhZ2VzID0gMDsKIAlkbWFfYWRkcl90ICpzcmM7CiAJdWludDY0X3QgKmRz
dDsKIAl1aW50NjRfdCBpLCBqOwpAQCAtMjk1LDE0ICsyOTYsOSBAQCBzdm1fbWlncmF0ZV9jb3B5
X3RvX3ZyYW0oc3RydWN0IGtmZF9ub2RlICpub2RlLCBzdHJ1Y3Qgc3ZtX3JhbmdlICpwcmFuZ2Us
CiAKIAlhbWRncHVfcmVzX2ZpcnN0KHByYW5nZS0+dHRtX3JlcywgdHRtX3Jlc19vZmZzZXQsCiAJ
CQkgbnBhZ2VzIDw8IFBBR0VfU0hJRlQsICZjdXJzb3IpOwotCWZvciAoaSA9IGogPSAwOyBpIDwg
bnBhZ2VzOyBpKyspIHsKKwlmb3IgKGkgPSBqID0gMDsgaSA8IG5wYWdlcyAmJiBtcGFnZXMgPCBt
aWdyYXRlLT5jcGFnZXM7IGkrKykgewogCQlzdHJ1Y3QgcGFnZSAqc3BhZ2U7CiAKLQkJZHN0W2ld
ID0gY3Vyc29yLnN0YXJ0ICsgKGogPDwgUEFHRV9TSElGVCk7Ci0JCW1pZ3JhdGUtPmRzdFtpXSA9
IHN2bV9taWdyYXRlX2FkZHJfdG9fcGZuKGFkZXYsIGRzdFtpXSk7Ci0JCXN2bV9taWdyYXRlX2dl
dF92cmFtX3BhZ2UocHJhbmdlLCBtaWdyYXRlLT5kc3RbaV0pOwotCQltaWdyYXRlLT5kc3RbaV0g
PSBtaWdyYXRlX3BmbihtaWdyYXRlLT5kc3RbaV0pOwotCiAJCXNwYWdlID0gbWlncmF0ZV9wZm5f
dG9fcGFnZShtaWdyYXRlLT5zcmNbaV0pOwogCQlpZiAoc3BhZ2UgJiYgIWlzX3pvbmVfZGV2aWNl
X3BhZ2Uoc3BhZ2UpKSB7CiAJCQlzcmNbaV0gPSBkbWFfbWFwX3BhZ2UoZGV2LCBzcGFnZSwgMCwg
UEFHRV9TSVpFLApAQCAtMzEzLDYgKzMwOSwxMiBAQCBzdm1fbWlncmF0ZV9jb3B5X3RvX3ZyYW0o
c3RydWN0IGtmZF9ub2RlICpub2RlLCBzdHJ1Y3Qgc3ZtX3JhbmdlICpwcmFuZ2UsCiAJCQkJCV9f
ZnVuY19fLCByKTsKIAkJCQlnb3RvIG91dF9mcmVlX3ZyYW1fcGFnZXM7CiAJCQl9CisKKwkJCWRz
dFtpXSA9IGN1cnNvci5zdGFydCArIChqIDw8IFBBR0VfU0hJRlQpOworCQkJbWlncmF0ZS0+ZHN0
W2ldID0gc3ZtX21pZ3JhdGVfYWRkcl90b19wZm4oYWRldiwgZHN0W2ldKTsKKwkJCXN2bV9taWdy
YXRlX2dldF92cmFtX3BhZ2UocHJhbmdlLCBtaWdyYXRlLT5kc3RbaV0pOworCQkJbWlncmF0ZS0+
ZHN0W2ldID0gbWlncmF0ZV9wZm4obWlncmF0ZS0+ZHN0W2ldKTsKKwkJCW1wYWdlcysrOwogCQl9
IGVsc2UgewogCQkJaWYgKGopIHsKIAkJCQlyID0gc3ZtX21pZ3JhdGVfY29weV9tZW1vcnlfZ2Fy
dCgKQEAgLTM1Myw5ICszNTUsMTMgQEAgc3ZtX21pZ3JhdGVfY29weV90b192cmFtKHN0cnVjdCBr
ZmRfbm9kZSAqbm9kZSwgc3RydWN0IHN2bV9yYW5nZSAqcHJhbmdlLAogb3V0X2ZyZWVfdnJhbV9w
YWdlczoKIAlpZiAocikgewogCQlwcl9kZWJ1ZygiZmFpbGVkICVkIHRvIGNvcHkgbWVtb3J5IHRv
IHZyYW1cbiIsIHIpOwotCQl3aGlsZSAoaS0tKSB7CisKKwkJZm9yIChpID0gMDsgaSA8IG5wYWdl
cyAmJiBtcGFnZXM7IGkrKykgeworCQkJaWYgKCFkc3RbaV0pCisJCQkJY29udGludWU7CiAJCQlz
dm1fbWlncmF0ZV9wdXRfdnJhbV9wYWdlKGFkZXYsIGRzdFtpXSk7CiAJCQltaWdyYXRlLT5kc3Rb
aV0gPSAwOworCQkJbXBhZ2VzLS07CiAJCX0KIAl9CiAK

--------------0xRrRzTEPzOkYylIjNuaYu06--

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9B7E77197
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 17:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10BA410EEA7;
	Thu,  9 Jan 2025 17:14:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tMQgmLC3";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EBCF10EEA7
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 17:14:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSJ7yVvV5fTVxrFAWamHF2XmsjUOX0PbNqxS7OWOhUz35SBqUDY1dRimAn5QhxYvJNfAxUtJDGsxHDjwBCyBOyHAFibnXIKiacj2zU9XFiiiQ+TM5JoLTxEGUeHarar1qFzHGxWBPAhl73K+L5ce5aUER41Fm958K5uIaTlD+sEQuJI9wnaFqmacaqgv263YVgx17p5GMnRqKGArEBMpabLaE2zpBwsDKFyL9eNDI/k6B07TBByE/iNecETEe4iSH1dRZXQZR0uPLA570Zyve/uJP46jA8FDbLtkyCcgvWjxYuxmDYl+M4AT7yL2zE3rqDeiP7kLqopLG7xmDenMCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJk5vJ4ZmLwNqBhdl30J6BavsOMQl/EfSIi6m6y2Lzo=;
 b=sensTIlwrofMEfrVwTtI48nWxGaStNtz/Zno797XgGR8qo2zID3GhhRdsddJPJnYPTydYmQr7wzMoFflbJCvCPE8aLtqB+691KjLhUbt38wQXRPo7ng60GwIEIg6PWz+BUpkMtpRelPi8qr0fX3IDbvl+iAw3nGYm3UylGV0FfO4y6Lxy7FR25Nr4t6A9KbMN0+hHuDDM+jLvnEOuyFNJ8R7JjU2PO4QjQRrXnckUVkMJdGAwyVksehJnAETITcWMu6sBR9pJrhTSVfR/UDHjbML6Hmncx2bH/wQiVTss0tyMNbIf01ACtcS5I5nWGfM17BLIvGEqwv0g6Q0M50ySg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJk5vJ4ZmLwNqBhdl30J6BavsOMQl/EfSIi6m6y2Lzo=;
 b=tMQgmLC3zrV9WVW89KNZI/a4JAgai6ds9bc8fEKvgpjPBbSI1bxh7Dlc8k06YuaQnp+JluA/CjfHpViT2u7qRrHKtIgeOlTUtWawRYTrC20vXhj1iB65V1ZS3VoDR50t8h3LVQ6JEFdVdLX9VY3AzC8Ta0hlzVPUfEqZxkANGLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB5657.namprd12.prod.outlook.com (2603:10b6:806:234::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 17:14:46 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 17:14:46 +0000
Message-ID: <4925dfbe-9a0f-4c73-989f-d2b1d7784161@amd.com>
Date: Thu, 9 Jan 2025 12:14:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix the looply call
 svm_range_restore_pages issue
To: Philip Yang <yangp@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>,
 "Yang, Philip" <Philip.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20250103022615.1399054-1-Emily.Deng@amd.com>
 <62496e35-e23c-4d10-a5b1-99978665cebc@amd.com>
 <PH0PR12MB54177A7932BF4D91A8A41FE38F102@PH0PR12MB5417.namprd12.prod.outlook.com>
 <PH0PR12MB5417D0B508B3DECD240478E48F112@PH0PR12MB5417.namprd12.prod.outlook.com>
 <PH0PR12MB5417E664CA264D62E1F2EB9B8F112@PH0PR12MB5417.namprd12.prod.outlook.com>
 <22e5cee7-52f4-ef08-b44b-e4fb96027ea9@amd.com>
 <PH0PR12MB54172D04315DCA27E581B2CD8F122@PH0PR12MB5417.namprd12.prod.outlook.com>
 <PH0PR12MB5417561D4BF4379DAFF7CF698F122@PH0PR12MB5417.namprd12.prod.outlook.com>
 <2015756a-974d-67a2-d875-9b90a1a9b1f3@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <2015756a-974d-67a2-d875-9b90a1a9b1f3@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQ1P288CA0015.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::13) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA1PR12MB5657:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c038d8a-c0a7-463d-65f4-08dd30d11dba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bUNna2xjZjNNT3VWVjBnZXdSSmVzeG9YaTB4aU41dmVxS2hkUjV3Ty9oeUJm?=
 =?utf-8?B?YmRITEN4R0NCOE9idDNpZ2ZBazZiK2NpQk1kZjJROXI3MnJhRDR1Q3ZmMmRu?=
 =?utf-8?B?L2tpSUZRUXg3QjkyNGl2WjgrN2puU1p1MXNkeWxQZzNyVGlXYUl1QXBtOWgw?=
 =?utf-8?B?MHZ4ZExBTGVRWE84NTUrZHhsb2ZuK2tHZnpTZkdsdXRQZjc4ZGFkcXFvZFMy?=
 =?utf-8?B?WVcvVzZTWjkzSk5rU1hlR2RlZ2pid3ZnalNoYjhSQVNiZmdoYzl5cXg0ZHJP?=
 =?utf-8?B?YkpZQmlDb1ZwaDlpeDJVMElqZ0wvd1h4KzFmZHl2YklFOGFrS0wwQm9ibnZk?=
 =?utf-8?B?NFFYWVpzWDBCcU4rSzNGa2hxRFRDVlU2cGhWU1dZbFZLaHlqYUszVkZUbUNH?=
 =?utf-8?B?Ny9CKzcxa2I4RkhPU1FmV2FPQSt3N01WekE4SFNLYXA0Qkxma3JrVW45TWRQ?=
 =?utf-8?B?NEwxMUkwaDZtQXVmK2Y0Z2dkSzRDZGh3SXdJSExhRExZMyszZkVDa0tpN0Zp?=
 =?utf-8?B?RDA2K1dFNUVJUG9Mb3ZzNWpGRzgvZFd6RWJKZjExVTBKVXZ2WVhpd3YrdFVo?=
 =?utf-8?B?ZldXaVB5NmVFODZmZkhvRDdBMWliTFd6YkdkUXZPeTJQQk9ML3ppeHZtTDBk?=
 =?utf-8?B?T0pOcTdJNmUvRnU4ZTZ4Zi93aHZvOEhqRDNYYmRVcFhNN1Vqalpway82djFT?=
 =?utf-8?B?N1djcHZRZWpwN1RkcUx6cWFlemFZQXNpbE9ZUC9oQS84ZXZsMGxhZjc5WVYv?=
 =?utf-8?B?ZzRHclcvYzZ3SzlZbTN5RXNiYUlPbFBjUHdPbnFock9sK3ppYVViRmhIcmFY?=
 =?utf-8?B?TktwWUZZU3JBajA3WTYxWGRKOVc4MmtYa0s0cWdKME1iR2hiRFFMVlpFQnk1?=
 =?utf-8?B?ck1YdG1sLzJReVd1RUMvWTJnMXBBY1p0eWdwMEpreERoVFBQeU1YdjRwRGhi?=
 =?utf-8?B?cWl5YXN0K1R4MXBrWjBockFPSG9Odm4wWTlISkNtSGV0OVIxRHdDbmJrNXdu?=
 =?utf-8?B?Zmc1OVlGbmk5Z3AvcGZXakhBREE2Tk94UTltSmNpd3BuOGlrUWlhNHFpYnFW?=
 =?utf-8?B?bVJBL01oS1Z4MHExMkFiNklpdGp2cVVHUkM1d2JzY2xudVR1MElOdXhVM0kx?=
 =?utf-8?B?NytTeVQ5N0FVYmNYYnBZWUhOOGJEcWYycXZWbDFlUVp6VXBWUFp1L3p2cm41?=
 =?utf-8?B?aGtBcVZKUEw4R3FWYmFuekFKOHpyVitsczlSSFNnYis0Tm5pYVhWQVRBUmpw?=
 =?utf-8?B?T0haTWRoNW9aQkN4eEE3aFlaL1FWb09uRlVKdUd0aFg4NHBGaGFlNjIzSmNO?=
 =?utf-8?B?T1VWd0pVUXBlaEY5WStNWEszdGJnU3JMUlB2Q0d6MitMRnBCbHVxZjVGNHpL?=
 =?utf-8?B?V2N1UGZiU0FKUHRINVpNUDVZYy9UelRWQ3U1ekJ3U1NJMGNKMWtNbWFpT2I4?=
 =?utf-8?B?NklEdkI4Z2E3L3pWaFprS2FOaGh0RzZtazA2Q2dKbHJtNU9JK3UyRUJxa21a?=
 =?utf-8?B?WldlallyenhMUjhDQW9XR2R0Z0w2anJ3d09UUzY0TDFvTjhyT3c5dzhPRExs?=
 =?utf-8?B?cDA5SXVFaXY1V2JLbDJrYStML3B3NFI3QlRnSnVISTluYXp3UVBrOVBpaWtY?=
 =?utf-8?B?cXFZMm9EeG5WWkJDVGM0QjZsVGhRUHNTTStPYWt2bUliZFRRM05QTGhPRFhE?=
 =?utf-8?B?cmlHNFhqditpei80KzI0RnJqNkVUYVhHNEJ0aWwrUC92QmRINldKVzIxMzZ5?=
 =?utf-8?B?UmJOeklRZnZGZUNhOFZ6Q1ZuTE9Eak8wOW1Rc1NnRHV1cyt5WW9EeXYrbXJr?=
 =?utf-8?B?ZHVVRDdpWWVLclpxNnFtbEV2TVJXRlJQUjM3bDVHS1NZYmZhNU1EcVJ3eHNy?=
 =?utf-8?Q?P2wN4XnAxaoTF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWkra1I4Zms0QlBkK1FlYVJYTXFCRVZwYXFjMlYvaFRSRkRKWStaRHB5Z2U1?=
 =?utf-8?B?M0V0RkllYzdGNGlFbkdXckN3c1g5emhqSk5nd1ZKYkZsQUROUzN2TzJUbWY3?=
 =?utf-8?B?eWl1Y2NXSUJ3dmlKcmh4OFZDZXZHN0VtV1RSUC8xYVp5ZTFFR1NtSG45WlFZ?=
 =?utf-8?B?bGlXenlRK0FvZlB5UU54WUsrV0xGMW5LemJzQm1vemRpeS9PbEtSRURjREY4?=
 =?utf-8?B?RVRqdXEyZ2xqUjhDOWpIWkJwaDB0bDRyMFhSaEhaZVdwL0VlaHNpbjhlS0xO?=
 =?utf-8?B?QisxNTBKclN5bWkva3k2dUFocGZnVjVxSFpMcUc2M1pNdGhUWGRiVU5zb0hR?=
 =?utf-8?B?Rll4YkJ6VjM4KzdJM0piVkVqWmdLK080RzYzSnBFQUxsTDNaN0FpdVJTc2Vx?=
 =?utf-8?B?d3BDNzhzLzlXUXBTWmNRTmpmRWEwOUUvNHRHSlNhMUZITGdlbUI0ckVzeHhT?=
 =?utf-8?B?cmlHTW5xQW5sa0QxQmllYjQzWlZ6QmhJN2VHTTJZSXg3bVI4Z2JWRFFJOGxW?=
 =?utf-8?B?bms5U1ZuNXEvRVNjcFFvUmJvTFBkZVBUL1NGZ1FLazQzY1ZkZDdUazdiR2lF?=
 =?utf-8?B?d1B0djdtVWdSRFpmbzJuNHJTQytVSENOMnNXQkU5KzQyUlE3SDdrSTE1eW5M?=
 =?utf-8?B?Wmhlcndtb3dnZWJZRU1kSTJyMlRnbnFTOUJ6M3E0RncwajRseW5JYjFlVlFE?=
 =?utf-8?B?V1N2ak1vbWJkNnI1bUdYemYwdEdYb3FTMDFHcXVwdzNmei9hbmVzZTlKQ0JB?=
 =?utf-8?B?bENxb3Y0Nmg5MzNFdkpaMDgzTklUKzllandKbUJ1NnRCNytnWUJPV2ZoQkVK?=
 =?utf-8?B?MlBSU2pUWDFibkZVaWtVUnZDcmVLd2U3K1djVHE1NE1XU0NoTklOeFlsOHhY?=
 =?utf-8?B?ZjZMYzFseW43Mno4NmxtK1Z3SUpSbjhaclVRRTk3NStYZkMvc3FROFdXQ01p?=
 =?utf-8?B?L00zVTljM1d4YVlBYTd4aXE3b3BwUnJDM2FIeVRiQkN5a2ZRenh2ajRkeXN3?=
 =?utf-8?B?amFRNzI0QWhrU3ExU3BUR3ZaeXFQOFZ2K2t6TEh3T2NlNDdxSCtFVFlwOFpx?=
 =?utf-8?B?RVIzek1BZmpCbndFa1dGMWMrWEhRbmFoVDdYWnI0dFREUmdHclkyQ1JjYjBF?=
 =?utf-8?B?aGx3WjVFYitVemcrNm9VdFd4bFN6eVJCU2J5RVBKd0tMSGhOY1RoZkYrS1lv?=
 =?utf-8?B?Nk5WZjlsNzVZU2t6aEVSeGEyZ1RxbmJDT0lHVktPV1JXTlpCWGVUNUtlTWxj?=
 =?utf-8?B?K1l1WkI2L3dxc29yeWJ6NXQ3QjlBQ3NuUXlmVTVtaUhlVFRnWld2MVRKRDNW?=
 =?utf-8?B?M2ZxSFV4WEhPWDR1cDcrS2FTM2lmU2lHc2d4b0tCMGxsckU0ZnkxeUg0WjFt?=
 =?utf-8?B?VlNubjJNVCt5U1c5eDBtZ051WnRha1VRS2ZxSzBZcnFqNlU3NmQ4RTRkSG84?=
 =?utf-8?B?T3hDR29ORVZjV1JWeFVoTTVsVzA3TmIxZVlqb1ZXeHIxZld6MFFIRHdmRXpQ?=
 =?utf-8?B?Q09CNGRWNVMvdmF5YkVvWUZuUkw2YXlOV1RnTVg1cnJEeXAzWTZtaTNiQTFG?=
 =?utf-8?B?bWIvVlV5cC9PNkwyR0ZvNU1LTkVUK0dQbEFMaC9Zb3ZpYWNBb2V5bmp1ZWxB?=
 =?utf-8?B?cnAxU3Q3ODRlOGhmSmdCbFdrVFhNYnlZdnZKMUxROVhnbm51Nk11WDJnNDZI?=
 =?utf-8?B?K2cySlBGSkl5VWtSOXNFYXB5QUZjVmkwbHhaQm9wcHRnZ2x4Z281dkN1WTZR?=
 =?utf-8?B?bGphM3FLbmhaSllPQm5PODZscXAzbFdGckZTaldpUmtUcXprVFJjMS9zOEVI?=
 =?utf-8?B?djE1Y09JTkhWc0tPWUl3Q2tJVDNuOWxPQlJ3aXM2QU9vcEE1ZWoyU3VBWWRS?=
 =?utf-8?B?cHNhbUtmZDVOMnBnU3d0NmN4Uis0TmgwZ0pYSlp4SXVDKzVhT2tqbDhuZEJ1?=
 =?utf-8?B?b1I0SkQvWmZwYlYzM1BmY0RjWTlnSEtTT1YxUnJ1c0dlb0F0OE9nVitiVFVm?=
 =?utf-8?B?NFI0YVpMU0J4TFFhUGpxWk1Cbnh4dGQxdTVZM3FoNG0xWUI0WlEwRFRPeDNL?=
 =?utf-8?B?M2pzZEYzd1ZWQXBCUENrMEVYbExTaUtEbU9sZHdObnJCRVFRbVNVSS9wek9x?=
 =?utf-8?Q?O5pLWSYmWKrNYygxKwU84/ged?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c038d8a-c0a7-463d-65f4-08dd30d11dba
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 17:14:46.3541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PyibKj23Dd9aXFIO8OtVQafZu7cyk6jN+fCX0h2w9q4sWkdWKMfi5yB4pSekTnslKc8zUlyM8K4VQSfwRzRQxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5657
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


On 2025-01-08 20:11, Philip Yang wrote:
>
>
> On 2025-01-07 22:08, Deng, Emily wrote:
>>
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>>
>> Hi Philip,
>>
>> It still has the deadlock, maybe the best way is trying to remove the 
>> delayed free pt work.
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000000>] INFO: task kfdtest:5827 
>> blocked for more than 122 seconds.
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000290>] Tainted: G           OE K   
>> 5.10.134-17.2.al8.x86_64 #1
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000243>] "echo 0 > 
>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000317>] task:kfdtest         
>> state:D stack:    0 pid: 5827 ppid:  5756 flags:0x00004080
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000002>] Call Trace:
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000006>] __schedule+0x1ba/0x490
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000002>]  ? usleep_range+0x90/0x90
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000002>] schedule+0x46/0xb0
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000001>] schedule_timeout+0x12a/0x140
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000003>]  ? __prepare_to_swait+0x4f/0x70
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000002>] __wait_for_common+0xb1/0x160
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000004>] flush_workqueue+0x12f/0x410
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000126>] 
>> svm_range_map_to_gpu+0x1b8/0x730 [amdgpu]
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000078>] 
>> svm_range_validate_and_map+0x978/0xd30 [amdgpu]
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000065>] 
>> svm_range_set_attr+0x55f/0xb20 [amdgpu]
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000060>] kfd_ioctl+0x208/0x540 [amdgpu]
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000058>]  ? 
>> kfd_ioctl_set_xnack_mode+0xd0/0xd0 [amdgpu]
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000004>]  ? vm_mmap_pgoff+0xf2/0x120
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000002>] __x64_sys_ioctl+0x88/0xc0
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000003>] do_syscall_64+0x2e/0x50
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000002>] 
>> entry_SYSCALL_64_after_hwframe+0x62/0xc7
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000008>] RIP: 0033:0x7f8c472617db
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000001>] RSP: 002b:00007ffd2908a688 
>> EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000002>] RAX: ffffffffffffffda RBX: 
>> 00007ffd2908a6fc RCX: 00007f8c472617db
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000002>] RDX: 00007ffd2908a6c0 RSI: 
>> 00000000c0384b20 RDI: 0000000000000003
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000000>] RBP: 00007ffd2908a6c0 R08: 
>> 0000000000000000 R09: 0000000000000000
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000001>] R10: 00007f70f467f000 R11: 
>> 0000000000000246 R12: 00000000c0384b20
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000000>] R13: 0000000000000003 R14: 
>> 0000000000200000 R15: 00007ffd2908a770
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000003>] INFO: task 
>> kworker/u129:7:5942 blocked for more than 122 seconds.
>>
>> [Wed Jan  8 10:35:44 2025 <    0.001897>] Tainted: G           OE K   
>> 5.10.134-17.2.al8.x86_64 #1
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000247>] "echo 0 > 
>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000315>] task:kworker/u129:7  
>> state:D stack:    0 pid: 5942 ppid:     2 flags:0x00004080
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000067>] Workqueue: amdgpu_recycle 
>> amdgpu_vm_pt_free_work [amdgpu]
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000002>] Call Trace:
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000003>] __schedule+0x1ba/0x490
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000002>]  ? newidle_balance+0x16a/0x3b0
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000001>] schedule+0x46/0xb0
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000002>] 
>> schedule_preempt_disabled+0xa/0x10
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000001>] 
>> __ww_mutex_lock.constprop.0+0x390/0x6e0
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000045>] 
>> amdgpu_vm_pt_free_work+0x97/0x160 [amdgpu]
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000003>] process_one_work+0x1ad/0x380
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000001>] worker_thread+0x49/0x310
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000001>]  ? process_one_work+0x380/0x380
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000001>] kthread+0x118/0x140
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000002>]  ? 
>> __kthread_bind_mask+0x60/0x60
>>
>> [Wed Jan  8 10:35:44 2025 <    0.000002>] ret_from_fork+0x1f/0x30
>>
> Move flush_workqueue to the beginning of svm_range_validate_and_map 
> should fix the deadlock, deadlock is because it is after 
> svm_range_reserve_bos. Also there is no concurrent unmap mmu notifier 
> callback to free pt bo as mmap read lock is taken outside 
> svm_range_validate_and_map.
>
I don't think the mmap_read_lock protects you from concurrent MMU 
notifiers. I believe we have made that assumption in the past and it 
proved to be incorrect.

Regards,
   Felix


> Ideally it is enough to flush work amdgpu_vm_pt_free_work (not flush 
> queue system_wq), but svm_range_validate_and_map cannot get the 
> correct vm to flush.
>
> adev->wq is shared by all processes and all xcp partitions, maybe 
> better to add wq to KFD process info, but right now 
> amdgpu_vm_update_range cannot access KFD process info.
>
> Regards,
>
> Philip
>
>
>> Emily Deng
>>
>> Best Wishes
>>
>> *From:*amd-gfx <amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of 
>> *Deng, Emily
>> *Sent:* Wednesday, January 8, 2025 8:34 AM
>> *To:* Yang, Philip <Philip.Yang@amd.com>; Kuehling, Felix 
>> <Felix.Kuehling@amd.com>; amd-gfx@lists.freedesktop.org; Koenig, 
>> Christian <Christian.Koenig@amd.com>
>> *Subject:* RE: [PATCH v2] drm/amdgpu: Fix the looply call 
>> svm_range_restore_pages issue
>>
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> *From:*Yang, Philip <Philip.Yang@amd.com>
>> *Sent:* Tuesday, January 7, 2025 11:19 PM
>> *To:* Deng, Emily <Emily.Deng@amd.com>; Kuehling, Felix 
>> <Felix.Kuehling@amd.com>; amd-gfx@lists.freedesktop.org; Yang, Philip 
>> <Philip.Yang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>> *Subject:* Re: [PATCH v2] drm/amdgpu: Fix the looply call 
>> svm_range_restore_pages issue
>>
>> On 2025-01-07 07:30, Deng, Emily wrote:
>>
>>     [AMD Official Use Only - AMD Internal Distribution Only]
>>
>>     Hi Felix,
>>
>>          You are right, it is easily to hit deadlock, don't know why LOCKDEP doesn't catch this. Need to find another solution.
>>
>>     Hi Philip,
>>
>>           Do you have a solution for this delay free pt?
>>
>> Thanks for debugging this case, I had a patch to not free PTB bo when 
>> unmapping from GPU, but it will waste VRAM memory. My test case also 
>> passed with the tlb flush fence fix, I don't see the no-retry fault 
>> generated any more.
>>
>> The deadlock is probably from svm_range_unmap_from_gpu -> 
>> flush_workqueue(adev->wq), this is from mmu notifier callback, 
>> actually we only need flush pt_free_work before mapping to gpu, 
>> please remove the flush_workqueue in unmap from gpu. If deadlock 
>> still happens, please post the backtrace.
>>
>> [Emily]Yes, you are right, will try to remove flush_workqueue in 
>> unmap from gpu to have a try. Will send a v3.
>>
>> I think you don't need add new adev->wq, use default system_wq and 
>> flush_work.
>>
>> [Emily]No, it doesn’t allow to flush a system_wq in driver, it will 
>> trigger a kernel warning, as lots of other work will be put in 
>> system_wq. I have tried this.
>>
>> Regards,
>>
>> Philip
>>
>>     Emily Deng
>>
>>     Best Wishes
>>
>>         -----Original Message-----
>>
>>         From: Deng, Emily<Emily.Deng@amd.com>  <mailto:Emily.Deng@amd.com>
>>
>>         Sent: Tuesday, January 7, 2025 10:34 AM
>>
>>         To: Deng, Emily<Emily.Deng@amd.com>  <mailto:Emily.Deng@amd.com>; Kuehling, Felix
>>
>>         <Felix.Kuehling@amd.com>  <mailto:Felix.Kuehling@amd.com>;amd-gfx@lists.freedesktop.org; Yang, Philip
>>
>>         <Philip.Yang@amd.com>  <mailto:Philip.Yang@amd.com>; Koenig, Christian<Christian.Koenig@amd.com>  <mailto:Christian.Koenig@amd.com>
>>
>>         Subject: RE: [PATCH v2] drm/amdgpu: Fix the looply call svm_range_restore_pages
>>
>>         issue
>>
>>         [AMD Official Use Only - AMD Internal Distribution Only]
>>
>>         Ping....
>>
>>         How about this? Currently it is easily to reproduce the issue on our environment. We
>>
>>         need this change to fix it.
>>
>>         Emily Deng
>>
>>         Best Wishes
>>
>>             -----Original Message-----
>>
>>             From: amd-gfx<amd-gfx-bounces@lists.freedesktop.org>  <mailto:amd-gfx-bounces@lists.freedesktop.org>  On Behalf Of
>>
>>             Deng, Emily
>>
>>             Sent: Monday, January 6, 2025 9:52 AM
>>
>>             To: Kuehling, Felix<Felix.Kuehling@amd.com>  <mailto:Felix.Kuehling@amd.com>;
>>
>>             amd-gfx@lists.freedesktop.org; Yang, Philip<Philip.Yang@amd.com>  <mailto:Philip.Yang@amd.com>;
>>
>>             Koenig, Christian<Christian.Koenig@amd.com>  <mailto:Christian.Koenig@amd.com>
>>
>>             Subject: RE: [PATCH v2] drm/amdgpu: Fix the looply call
>>
>>             svm_range_restore_pages issue
>>
>>             [AMD Official Use Only - AMD Internal Distribution Only]
>>
>>             [AMD Official Use Only - AMD Internal Distribution Only]
>>
>>                 -----Original Message-----
>>
>>                 From: Kuehling, Felix<Felix.Kuehling@amd.com>  <mailto:Felix.Kuehling@amd.com>
>>
>>                 Sent: Saturday, January 4, 2025 7:18 AM
>>
>>                 To: Deng, Emily<Emily.Deng@amd.com>  <mailto:Emily.Deng@amd.com>;amd-gfx@lists.freedesktop.org;
>>
>>                 Yang, Philip<Philip.Yang@amd.com>  <mailto:Philip.Yang@amd.com>; Koenig, Christian
>>
>>                 <Christian.Koenig@amd.com>  <mailto:Christian.Koenig@amd.com>
>>
>>                 Subject: Re: [PATCH v2] drm/amdgpu: Fix the looply call
>>
>>                 svm_range_restore_pages issue
>>
>>                 On 2025-01-02 21:26, Emily Deng wrote:
>>
>>                     As the delayed free pt, the wanted freed bo has been reused which
>>
>>                     will cause unexpected page fault, and then call svm_range_restore_pages.
>>
>>                     Detail as below:
>>
>>                     1.It wants to free the pt in follow code, but it is not freed
>>
>>                     immediately and used “schedule_work(&vm->pt_free_work);”.
>>
>>                     [   92.276838] Call Trace:
>>
>>                     [   92.276841]  dump_stack+0x63/0xa0
>>
>>                     [   92.276887]  amdgpu_vm_pt_free_list+0xfb/0x120 [amdgpu]
>>
>>                     [   92.276932]  amdgpu_vm_update_range+0x69c/0x8e0 [amdgpu]
>>
>>                     [   92.276990]  svm_range_unmap_from_gpus+0x112/0x310 [amdgpu]
>>
>>                     [   92.277046]  svm_range_cpu_invalidate_pagetables+0x725/0x780 [amdgpu]
>>
>>                     [   92.277050]  ? __alloc_pages_nodemask+0x19f/0x3e0
>>
>>                     [   92.277051]  mn_itree_invalidate+0x72/0xc0
>>
>>                     [   92.277052]  __mmu_notifier_invalidate_range_start+0x48/0x60
>>
>>                     [   92.277054]  migrate_vma_collect+0xf6/0x100
>>
>>                     [   92.277055]  migrate_vma_setup+0xcf/0x120
>>
>>                     [   92.277109]  svm_migrate_ram_to_vram+0x256/0x6b0 [amdgpu]
>>
>>                     2.Call svm_range_map_to_gpu->amdgpu_vm_update_range to update the
>>
>>                     page table, at this time it will use the same entry bo which is the
>>
>>                     want free bo in step1.
>>
>>                     3.Then it executes the pt_free_work to free the bo. At this time,
>>
>>                     the GPU access memory will cause page fault as pt bo has been freed.
>>
>>                     And then it will call svm_range_restore_pages again.
>>
>>                     How to fix?
>>
>>                     Add a workqueue, and flush the workqueue each time before updating page
>>
>>         table.
>>
>>                 I think this is kind of a known issue in the GPUVM code. Philip was
>>
>>                 looking at it before.
>>
>>                 Just flushing a workqueue may seem like a simple and elegant solution,
>>
>>                 but I'm afraid it introduces lock dependency issues. By flushing the
>>
>>                 workqueue, you're effectively creating a lock dependency of the MMU
>>
>>                 notifier on any locks held inside the worker function. You now get a
>>
>>                 circular lock dependency with any of those locks and memory reclaim. I
>>
>>                 think LOCKDEP would be able to catch that if you compile your kernel
>>
>>                 with that
>>
>>             feature enabled.
>>
>>                 The proper solution is to prevent delayed freeing of page tables if
>>
>>                 they happened to get reused, or prevent reuse of page tables if they
>>
>>                 are flagged for
>>
>>             delayed freeing.
>>
>>                 Regards,
>>
>>                    Felix
>>
>>             Thanks, already enabled LOCKDEP while compiling the kernel. The delay
>>
>>             work seems for other reasons, I am not sure whether it could be deleted completely.
>>
>>             Emily Deng
>>
>>             Best Wishes
>>
>>                     Signed-off-by: Emily Deng<Emily.Deng@amd.com>  <mailto:Emily.Deng@amd.com>
>>
>>                     ---
>>
>>                        drivers/gpu/drm/amd/amdgpu/amdgpu.h              | 1 +
>>
>>                        drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 +
>>
>>                        drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c           | 7 +++++--
>>
>>                        drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c        | 6 +++++-
>>
>>                        drivers/gpu/drm/amd/amdkfd/kfd_svm.c             | 3 +++
>>
>>                        5 files changed, 15 insertions(+), 3 deletions(-)
>>
>>                     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>
>>                     b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>
>>                     index 93c352b08969..cbf68ad1c8d0 100644
>>
>>                     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>
>>                     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>
>>                     @@ -1188,6 +1188,7 @@ struct amdgpu_device {
>>
>>                           struct mutex                    enforce_isolation_mutex;
>>
>>                           struct amdgpu_init_level *init_lvl;
>>
>>                     +    struct workqueue_struct *wq;
>>
>>                        };
>>
>>                        static inline uint32_t amdgpu_ip_version(const struct
>>
>>                     amdgpu_device *adev, diff --git
>>
>>                     a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>
>>                     b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>
>>                     index f30548f4c3b3..5b4835bc81b3 100644
>>
>>                     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>
>>                     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>
>>                     @@ -2069,6 +2069,7 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
>>
>>                                   if (ret)
>>
>>                                           goto out;
>>
>>                           }
>>
>>                     +    flush_workqueue(adev->wq);
>>
>>                           ret = reserve_bo_and_vm(mem, avm, &ctx);
>>
>>                           if (unlikely(ret))
>>
>>                     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>
>>                     b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>
>>                     index 9d6ffe38b48a..500d97cd9114 100644
>>
>>                     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>
>>                     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>
>>                     @@ -2607,7 +2607,7 @@ void amdgpu_vm_fini(struct amdgpu_device
>>
>>                     *adev,
>>
>>                 struct amdgpu_vm *vm)
>>
>>                           amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>>
>>                           flush_work(&vm->pt_free_work);
>>
>>                     -
>>
>>                     +    cancel_work_sync(&vm->pt_free_work);
>>
>>                           root = amdgpu_bo_ref(vm->root.bo);
>>
>>                           amdgpu_bo_reserve(root, true);
>>
>>                           amdgpu_vm_put_task_info(vm->task_info);
>>
>>                     @@ -2708,6 +2708,8 @@ void amdgpu_vm_manager_init(struct
>>
>>                     amdgpu_device
>>
>>                 *adev)
>>
>>                        #endif
>>
>>                           xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
>>
>>                     +    adev->wq = alloc_workqueue("amdgpu_recycle",
>>
>>                     +                               WQ_MEM_RECLAIM | WQ_HIGHPRI |
>>
>>                 WQ_UNBOUND, 16);
>>
>>                        }
>>
>>                        /**
>>
>>                     @@ -2721,7 +2723,8 @@ void amdgpu_vm_manager_fini(struct
>>
>>                     amdgpu_device
>>
>>                 *adev)
>>
>>                        {
>>
>>                           WARN_ON(!xa_empty(&adev->vm_manager.pasids));
>>
>>                           xa_destroy(&adev->vm_manager.pasids);
>>
>>                     -
>>
>>                     +    flush_workqueue(adev->wq);
>>
>>                     +    destroy_workqueue(adev->wq);
>>
>>                           amdgpu_vmid_mgr_fini(adev);
>>
>>                        }
>>
>>                     diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>
>>                     b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>
>>                     index f78a0434a48f..1204406215ee 100644
>>
>>                     --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>
>>                     +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>>
>>                     @@ -554,15 +554,19 @@ void amdgpu_vm_pt_free_work(struct work_struct
>>
>>                     *work)
>>
>>                           vm = container_of(work, struct amdgpu_vm, pt_free_work);
>>
>>                     +    printk("Emily:%s\n", __func__);
>>
>>                           spin_lock(&vm->status_lock);
>>
>>                           list_splice_init(&vm->pt_freed, &pt_freed);
>>
>>                           spin_unlock(&vm->status_lock);
>>
>>                     +    printk("Emily:%s 1\n", __func__);
>>
>>                           /* flush_work in amdgpu_vm_fini ensure vm->root.bo is valid. */
>>
>>                           amdgpu_bo_reserve(vm->root.bo, true);
>>
>>                     +    printk("Emily:%s 2\n", __func__);
>>
>>                           list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
>>
>>                                   amdgpu_vm_pt_free(entry);
>>
>>                     +    printk("Emily:%s 3\n", __func__);
>>
>>                           amdgpu_bo_unreserve(vm->root.bo);
>>
>>                        }
>>
>>                     @@ -589,7 +593,7 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device
>>
>>                 *adev,
>>
>>                                   spin_lock(&vm->status_lock);
>>
>>                                   list_splice_init(&params->tlb_flush_waitlist, &vm->pt_freed);
>>
>>                                   spin_unlock(&vm->status_lock);
>>
>>                     -            schedule_work(&vm->pt_free_work);
>>
>>                     +            queue_work(adev->wq, &vm->pt_free_work);
>>
>>                                   return;
>>
>>                           }
>>
>>                     diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>
>>                     b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>
>>                     index 3e2911895c74..55edf96d5a95 100644
>>
>>                     --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>
>>                     +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>
>>                     @@ -1314,6 +1314,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device
>>
>>                 *adev, struct amdgpu_vm *vm,
>>
>>                           uint64_t init_pte_value = 0;
>>
>>                           pr_debug("[0x%llx 0x%llx]\n", start, last);
>>
>>                     +    flush_workqueue(adev->wq);
>>
>>                           return amdgpu_vm_update_range(adev, vm, false, true, true,
>>
>>                     false, NULL,
>>
>>                 start,
>>
>>                                                         last, init_pte_value, 0, 0, NULL,
>>
>>                     NULL, @@ -1422,6
>>
>>                 +1423,8
>>
>>                     @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct
>>
>>                     svm_range
>>
>>                 *prange,
>>
>>                                    * different memory partition based on fpfn/lpfn, we should use
>>
>>                                    * same vm_manager.vram_base_offset regardless memory partition.
>>
>>                                    */
>>
>>                     +            flush_workqueue(adev->wq);
>>
>>                     +
>>
>>                                   r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, true,
>>
>>                                                              NULL, last_start, prange->start + i,
>>
>>                                                              pte_flags,
>>

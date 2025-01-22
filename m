Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CD0C0218B
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2025 02:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A28E710E65A;
	Wed, 22 Jan 2025 02:59:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zRa7lSfM";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::604])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8CC110E5A4
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2025 02:59:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJSJm8pQMlIT50J73Df0MkvwRleqeBHmcltDEg6JFogMbOrr3OWYRkS5Ie6uRoQpmwyqiVmVdx7WQri8ayWk60F1+/Wi/KbIYEXCRl+5k4sSaWJsFQTKU9aefkpp2MBBraHTGL/cX9tNBM8Ylq+nYjm1oS2qfiqu5Q6+sQ74o66xHz5GzWlRgACVxxQpVTuf0x1cvM3EYGiz/V5n0/qbOVgl9QUl/Tys2bkId/jjIHa3tITq+Cq/eTrqOCWUUXvioKidRkzmgLjyOSkH0Ia7JhhllbCHO7+GYVEEaE7PijP/BGOj4oq//5N3YKqKWDToZmH467akupG+glN4NAgbsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crsPjI8mygqGq34d1VSsqsJWmatVOg3ZI+1mz95dk18=;
 b=xhZvs1c4cOPQy9cT/e7EGjhcCQw5CpbRJrLjrrbTbzmeJhZRNZIjSNdXTia6xbEFq9Rb+oIS+a/7NusVkob5zWptFSIivHgd0tSiEnuiKSRFb1hsi5Sx0y0sGuCWGGyikbX5xQ2CclGQCAGReihkn18L+c+EvRV3ezU3lA7mo/U7EAON4m+j2Pu1kFdNyBXwSOvOkrbCyPTjlRZJqef6daPACI76FPCv4s84A2oQMle+zrHHv4MJlzTRG0/t9J466eY/5g8fRSuVGI7F24/lLxZXiFn306YnDmj+hwChUetuiHtxgjmNZg/JL9MXZ6sRwG0KhSfKMbFQudivXQyPnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crsPjI8mygqGq34d1VSsqsJWmatVOg3ZI+1mz95dk18=;
 b=zRa7lSfMqT7wn0gBLrgCU/A+xGocEjMuRUtdBgp+UFF0PmBek7fDpzLnNB6ZBHAMdDWhz+8uGW+E+M37KyO5kKguvG3ussx5OJ6ehqxvW5/vQsMevCkKImlFrWcHykNsR5OJbneQjTDQ1JCagbMerXwLQUffY7UyxAzfjD1d7Hw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6807.namprd12.prod.outlook.com (2603:10b6:a03:479::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 02:58:51 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 02:58:51 +0000
Message-ID: <9e689d0e-d8ca-49c9-8e62-dd113fe774e0@amd.com>
Date: Tue, 21 Jan 2025 20:58:48 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] amdgpu/soc15: enable asic reset for dGPU in case of
 suspend abort
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Jiang Liu <gerry@linux.alibaba.com>,
 alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 Hawking.Zhang@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 Prike.Liang@amd.com, asad.kamal@amd.com, sonjiang@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736739303.git.gerry@linux.alibaba.com>
 <2462b4b12eb9d025e82525178d568cbaa4c223ff.1736739303.git.gerry@linux.alibaba.com>
 <ef9902c4-0d7e-4a1a-b785-b3ca8e8d0a03@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ef9902c4-0d7e-4a1a-b785-b3ca8e8d0a03@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0162.namprd13.prod.outlook.com
 (2603:10b6:806:28::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: 56773261-3801-4601-2c5e-08dd3a90b2f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UEkzS3VOUWc2MjdndjhIdzk0cjFiYXVZNlBVMkQxc0NJRWd5cWp0RUJNbm56?=
 =?utf-8?B?Z2pLcU1ZUEJuRXROUVdsMDI3MEh2WEFqU0R3WnlpK2RwWmlNUk51ejFQbHhy?=
 =?utf-8?B?djdXejdBYm1yYk82MittK2lhcG5SeHMwOGViV1ZsOWp3WW1HRlBIRW1BRGcr?=
 =?utf-8?B?TGdNK055Ums4aDc0bDB6ek5QSVdDd0JOWWJidnpHTlhKYkpGbElpVlBXY3lw?=
 =?utf-8?B?NjR4dW56YmZqbUtoUVBZT3hSS2F5ZVBYR1Y4eTJ4NlR3eXI4Yyt6MzY2bEs3?=
 =?utf-8?B?MHRZSitIR3ZvMGR0cmg4bGlMRmtkRnQ2dy9neFVlQ3ZVMGVxUHhTQ0UvNHpr?=
 =?utf-8?B?WVNES2V0c053UWpobGQ3ejEwejlYdnNEZjFTSVpzbDRLaXJZclRyTGFXV3h6?=
 =?utf-8?B?NE14dTJVc2JsV2JDcjhSM1JQWWZ6dzFOQnZQTml4eDhwaDhxQ0pyQWc2OXNp?=
 =?utf-8?B?Wk4rMWdSdXBacG1wdVVJQlZ4dlpxb3NZaGVsTVBvMUFVVmRkbDlzN1FLMnE3?=
 =?utf-8?B?d20zdHFDUmE1ditZelZvVmZSM20vcHhuZUYrWXVXaDlnNHoweDNnL3lQU3Yv?=
 =?utf-8?B?VVg4NUI1VmxUTUpGUDBPaDVCQzZFOHF2eDA2WmUwcWtXbjFvMDMzYTZ0NDEw?=
 =?utf-8?B?WFY1amlpWDNaM0N3SFNoVUxIeGxZZEUzUTdsZ3dtT1RYbmRDenBpemVCVlRI?=
 =?utf-8?B?QTRHZC9VZitya1hCYVVhOGpmRWVicHJaQVRHN2RnZ3dVTHpnZzRFWFdUVnpC?=
 =?utf-8?B?bThqYzZzMmhEd1FOYW5PMGUwei9zUU9mRW1YOG5WeVA5ak9JMzE0MG5ncUsr?=
 =?utf-8?B?Q0ViZ0hTdFExVlU0NFBiSmtJY2RuSnFLUWtMMGFWZkdrK2tZb0puMUdacjBR?=
 =?utf-8?B?QS9YNHMySXdVV0FoU1hKYitaRDdMaVd1cEpwdzZwNUd6VGpobE1tZy9abVJp?=
 =?utf-8?B?M2V1cG1HVUE4M29aa3JESk8wby9oRHFCajJEajRjVkw0M0E4SDVzM09NbkdD?=
 =?utf-8?B?aHhTZ0Mza0huQmVtakc4TDQ3WHdNOHdEeFVUQkZDWGtQdTdhTElvT2tpTTlU?=
 =?utf-8?B?QjNLd1I4MG11NC9WRE02NnJ1aXZ0aWxYSjZnQWVuZEdhZkNyWXMwa3FzNkQ4?=
 =?utf-8?B?MlhMeHdSNEZaNk5jQkkyeEVISkFTSFFFSzF6QjUzc1dtY2JUZE5WaHFwbTFP?=
 =?utf-8?B?cWVFTmNuY2pEYzIrZ25mcmplV3FUYmdXMVVMVHZiaENxWmpaRy9VUkI1S2Vm?=
 =?utf-8?B?ZVlQZXJSYnUyb2RpL2xDQW1QZ1Q2N3FLYm96OFdnNjJzMmliQVNCdFNSNDNw?=
 =?utf-8?B?L3lLR1ZQUEFXV0JrMmQvL05nYzlwam1DOVAvb2U0WFJxWjZpSXoxV2s0OE9R?=
 =?utf-8?B?RUtBYXdwZ1ozZVhtcS95ZUVrNFFlVWJNU3htZWpocEJjV3RKdjNxZEJwOHk3?=
 =?utf-8?B?bmozcHl5eTAzcEM1Z0NwWUExRzVZRG1QaE5WUlk1ZUlEZ2J5YnIwcGRUNUhk?=
 =?utf-8?B?bWRrTVd0b1hkZHpLZ1dncFZtV0swMTZSNUpVekg4TGsyaFdiaVZDUmVDVDds?=
 =?utf-8?B?OXp4aWJSMkMwWjRFcW8yb091azk5ZXd3WUN6STZaYllKMUJlVUU5ZDVDZUt4?=
 =?utf-8?B?U0pVcWxhemJrWk9NOGpyZGVNU0RxKzQ5U0g5eFR0WTd6WWVXanhsSXduR3BO?=
 =?utf-8?B?MUxJRDI5TWxjYklBUmQ0QUR0RHNXZjBUNHlVTFV5Ly91b0hDemRndldPUHpH?=
 =?utf-8?B?YUN4bExUd0QwUkIycklKWFVHMDZzTkw1Q3l4aDF3WkFzUXVzY0o0bndQZHBj?=
 =?utf-8?B?RytKVGYzdWFXRVduOTBuc0JWcWN1MXkxTkpSRCtTeUU4a2dqZnJuYXhVeWMr?=
 =?utf-8?B?MTZNV0FCRlBPVlF2a2xKclJsU0tHRkYwcWgvMW9rKzNYUWNKUHdlWFBrVW1n?=
 =?utf-8?Q?0/IZbErS/Jg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVNmMEZ5OTNKQ1FVbStLeVJ5NW9sSnNRS2tMODNZdzluV3ZKSmhncDZSbVps?=
 =?utf-8?B?THkvSGo4MXB6V3FuSmF2bWZKbU9qRy85bnN1WlV4U3RiYnVFbTd6Q3pnOUNv?=
 =?utf-8?B?TEN1VHJZNXVyZjBldmhTSmxFZHorOFlaQmV1R1dUaW1uQm04TURVWlNyOW1x?=
 =?utf-8?B?bTJLaDY5b1I1T2E4NXJ0b3p3WUJ3SWdpZGpkT0lhakwyeE9SakFDMzRaWlVY?=
 =?utf-8?B?cXExNE05TXRCY3phS0prSWhQNTNKRVZyQTB4azVLMktoMXpoeDBYb0thR3R5?=
 =?utf-8?B?SVlieEFBVHE0ejNVK0NpV2NZMHA1QURHOWJyQXBoOGhSeUdaMVlZdUJ4TlhR?=
 =?utf-8?B?WitFbVZ0aFRyYlA3UjJrQUIzbDdkWGdyaWZpM3dEWEtsZThyS01Wa2dBUm1R?=
 =?utf-8?B?OHlMV1R5RG9qUWpXRTFkZzJNbUNmNjhMUTFjaEQ2UUo4azNZT0RvVXpWbUp5?=
 =?utf-8?B?em9MWE9ZTUpMcmNkcUVYdjFnVm9KaWF5NllpYzJGTUZRVlAwOFBCVGJRdWl4?=
 =?utf-8?B?SDM5SzVKUy9iL0ZFbGVTMkFtakJsaENHM3Jjd1NLdGEycGxEcUZwVm5hbS9m?=
 =?utf-8?B?Ym1JekQyV3RoWFhqcDZCOXBvZjVpVXJYOE1SVE9URFZQVHdkL2N1Z3l0cHEr?=
 =?utf-8?B?ZlR6TlFLYnBUbzRBSS8zL2oyNTlqVkFMZGgxQlFMWUJVeDZ2QVhlMHJsUFJT?=
 =?utf-8?B?cHd4ZEhiR2tPV0t1MFQ1eFAxMFVpVXREOGlESE5FQVRMYWNuUnI3ZExBYUdV?=
 =?utf-8?B?THpaL0NSUUxKcjBjQWoyUGJ6bVhiZDZUMFUyWUdBY1h6Y1ZYSUJKMUYySUNx?=
 =?utf-8?B?YmZlQ1FQQk1MZE84U09IWXpveThNRFJvT3hEMWQ5SVd4eU5URlVHYVNlcWlp?=
 =?utf-8?B?Q0ExZzJJREFhWVpmQmgyVjZTME5TSVM2OUx5TkltRUdrdmFldURDall4RFoy?=
 =?utf-8?B?VSttbjBPVFpkOElEYVhud0lhbmtNbHFEaUZ5SWpZTFdXeEpBMVorNWZqUk94?=
 =?utf-8?B?Sm9YRm9SNEM0ejVVSzd1ZUlxSW81N1dvcEtOaGRpMGVvL3ZCS2U5aHNVVFRh?=
 =?utf-8?B?UG1CY2l5ZnFNelNNYnZIVFpmanJMa2pjQ09BODFVNDlaNFNTNzFGQXdTeHhp?=
 =?utf-8?B?dlFBOFltRzBsK1N5TlhRcmVCaVFGVk5jdHU2cVdBV0JVeXVqZkpOd29yMmF2?=
 =?utf-8?B?dU5lT0JmSTJmT1FxKzVYZ1FyeTBZcU1CWnkxV1JtSUVJeVN4dVpvbnNUMUFo?=
 =?utf-8?B?RlNES2ZmamdLNjA3TXBvRE1zQUN2SE9tSi9lYm1IRWFpOThTcTI1TmVONVR1?=
 =?utf-8?B?SVdXL1pJazJwM3owM0pWTU5JUDkrOElSc0RNZ2NZYUxucnoxNTUybDNjVVJn?=
 =?utf-8?B?NC9rbllHWTVEWVV4MjVLbFNCa1pDZFhSMTlOUjlhWTV0cWZPQWYvQnd6bzFS?=
 =?utf-8?B?QWpNbzlLQ3ppbDd1WHZ3MXFMT2ZoN0hMRzliejhtdUdDUkZBNTdQNjc1cXdw?=
 =?utf-8?B?WWhWczd4VmZTT0phcEpsYnh6NlhJRTAwUURWV212T2hBWVVYRUtCekszejdH?=
 =?utf-8?B?bWtjd1dNUGVGTFVmT0NuTytxMlRHMVYrdk5yUDZDanV2NitGSVBYRWZWRkJx?=
 =?utf-8?B?K1BtV3o5bmt5dUR5NjB4SUtYNjVQeDRmVjFzek4rVCtjZVlnSWJ3bHlxMUFk?=
 =?utf-8?B?Rk9XdTRqMHVsRmxkTWhpaDMwQjF4UDJoQytsRGxWdWZxOEdoNXo4WUNyVHg1?=
 =?utf-8?B?c2Q5UGxSbGNDTUpFcGlXb3dsYkFDWEZWMTFhVGNLcTdoQzE1RDlnSFVkQkpP?=
 =?utf-8?B?VmEvSEttaEhQSzRTMWt6eWo0b3E0WmJXakw3ZWJ0b2pWcFJzZ0cyVi9yQWJ4?=
 =?utf-8?B?S2pLYUhucTJ0OXE3bW02MmRMUzZRS1NTc3NmbnBSQnBRVHVlb0VxRCtPRnYr?=
 =?utf-8?B?QUJ5WG4rd0wrMWNPWTlHaVIyZDJiVnQ0dkNZd3FwRkZiQ2h3LzJXUmk1UGYv?=
 =?utf-8?B?UmI0UzRLZ1RsS0FQcnpPK2diajdZemJFSFNwTXlaeXg1bUlZLy80WncrSHNP?=
 =?utf-8?B?NXkrQ3dsQVlSVlQwenFqVVNRZ21LRm14YzN0TzZ1b1hQWExha25yYTRkSTdy?=
 =?utf-8?Q?oWUEEyfP4ZWYdv1/ndfsR6CkA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56773261-3801-4601-2c5e-08dd3a90b2f1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 02:58:50.9692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UlY78CBIhznlj/hMuUGg5wDMotPkHY8tR9RXoMjAfv2cZ7/f2lgej4sWCf5fYkh+qKeDTqUSKbWi7RymWGnVzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6807
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

On 1/20/2025 23:45, Lazar, Lijo wrote:
> 
> 
> On 1/13/2025 9:10 AM, Jiang Liu wrote:
>> When GPU suspend is aborted, do the same for dGPU as APU to reset
>> soc15 asic. Otherwise it may cause following errors:
>> [  547.229463] amdgpu 0001:81:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring kiq_0.2.1.0 test failed (-110)
>>
>> [  555.126827] amdgpu 0000:0a:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring kiq_0.2.1.0 test failed (-110)
>> [  555.126901] [drm:amdgpu_gfx_enable_kcq [amdgpu]] *ERROR* KCQ enable failed
>> [  555.126957] [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block <gfx_v9_4_3> failed -110
>> [  555.126959] amdgpu 0000:0a:00.0: amdgpu: amdgpu_device_ip_resume failed (-110).
>> [  555.126965] PM: dpm_run_callback(): pci_pm_resume+0x0/0xe0 returns -110
>> [  555.126966] PM: Device 0000:0a:00.0 failed to resume async: error -110
>>
>> This fix has been tested on Mi308X.
>>
>> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
>> Tested-by: Shuo Liu <shuox.liu@linux.alibaba.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/soc15.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> index a59b4c36cad7..0e1daefd1a8e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>> @@ -605,12 +605,10 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
>>   static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
>>   {
>>   	/* Will reset for the following suspend abort cases.
>> -	 * 1) Only reset on APU side, dGPU hasn't checked yet.
>> -	 * 2) S3 suspend aborted in the normal S3 suspend or
>> -	 *    performing pm core test.
>> +	 * 1) S3 suspend aborted in the normal S3 suspend
>> +	 * 2) S3 suspend aborted in performing pm core test.
>>   	 */
>> -	if (adev->flags & AMD_IS_APU && adev->in_s3 &&
>> -			!pm_resume_via_firmware())
>> +	if (adev->in_s3 && !pm_resume_via_firmware())
>>   		return true;
> 
> I don't think this can be applied to all environments. For ex: this may
> not be applicable for dGPUs combined with ARM CPUs.

I looked through amdgpu_acpi cases and I'm not sure I agree with this.
On ARM side amdgpu_acpi_is_s3_active() should never return true because 
ARM doesn't support PM_SUSPEND_MEM.

This means that amdgpu_choose_low_power_state() shouldn't set is_s3 either.

So I don't think this block will run on ARM side.

That being said, we might have other more fundamental issues to worry 
about with suspend/resume than handling aborted suspend/resume when run 
on non-x86 so the whole set of amdgpu suspend/resume code might need to 
be revisited.

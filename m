Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092C4E9128F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 14:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A25C810E8E4;
	Thu,  5 Feb 2026 14:27:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VriY6Y+9";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2519F10E8E2
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 14:27:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0rV+lBHjBAzzjpkgamtqgIaRrezK9xJh8p+WbNzYKoXwwRMpy9axGKNNjzdthmu0hZIT40VPWOeHHajfuKabW7+/sJ88KHpdV4nIKgjLVHP7uIbp7Vap3OfwiqVMRaja3PmOmvWFyJOp+F0y/1XOdOGXE0b7XaAPZPqsMgwg7EcauT6uPhw2d7QPOG0cvJ6OyBRN6coQ1ZiuIER/8Fwj2S776n45uaLCNlG1fgpwF/Bf2J3ucCL2TgORc2ooCa6Tv3VQbm58L5J63nzdSn6ArM0bcH8O9mZSR6W4xF060YJlpDOefENkczFUGIFuKu/qVMncbJHIAgcPqG4tTPXpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xx7PgN5WNwS+0baJhzxt+TNE+cTfIfXMyPAKrTPmxcU=;
 b=LeIqAAXHWZ8OOGErvGcJMBaPnNkfLX5uMuXEEEAjOkCfYuno92jVQ2n/sDgdb7fWkrXN1asuqdYvH4dBqL/9cr8UWT9J6npAqSGJcAUf7rKCipNcVNnoldwDxXuIpUUKKOVCwJrZS5O2A72Kt1Aj6chORSLNN8ySr1lkhymyDNxIOCXyIC5ftm66nfKgWx5bCD4IBp7ZqGKVgkKXTrZqJu+BJWxRWzVSh3YbLz7DzOWk+++3tI9NpCJMdA6zxfXviNnlIeoM4TkHh22zjCW66WmAlkKVttr7vyOMoTSbL+64WYJCpTcWcXqfH4DIxyIv7wAKcwtmpnoKT4qcrvKdOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xx7PgN5WNwS+0baJhzxt+TNE+cTfIfXMyPAKrTPmxcU=;
 b=VriY6Y+9ERMaBEg1eXPARJg4pDaaP6hJmt7ULTgYBoeEirFYNLUhr5D2G+1/y/W+s8lXbzT+BBxDfwYVaqhWbV9s/PYj2DuVo5W2gV1S1qsG74IYCew4k7k1c6/TNRDLm5aTQVwRVCQMNB8HHQfW1c+a5xLW/D18P2Hftr2hnwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com (2603:10b6:a03:44c::18)
 by MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 14:27:21 +0000
Received: from SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::7c4d:63c2:bc84:8516]) by SJ0PR12MB6760.namprd12.prod.outlook.com
 ([fe80::7c4d:63c2:bc84:8516%4]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 14:27:20 +0000
Message-ID: <3996d2ad-4fe0-4060-83e6-092fc264f348@amd.com>
Date: Thu, 5 Feb 2026 09:27:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add kfd_ioctl_profiler to contain profiler kernel driver
 changes
To: Perry Yuan <perry.yuan@amd.com>, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: yifan1.zhang@amd.com
References: <20260205064823.646853-1-perry.yuan@amd.com>
Content-Language: en-US
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <20260205064823.646853-1-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0186.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::29) To SJ0PR12MB6760.namprd12.prod.outlook.com
 (2603:10b6:a03:44c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6760:EE_|MW5PR12MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a026be-d070-45ae-47c0-08de64c2ab42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vm5LVzc3TER4QVFCa1VnYS9zVUJIdlBuQTFGcWJlOGdrclBwbFFaR205ampq?=
 =?utf-8?B?UG1DWkJrcUhPc0c1cVRQR1RGZkpXTzJRblFLWmVReitwdWZ4Z3gzQ3JaRlh5?=
 =?utf-8?B?bWRUV0RhUzNNMThiOHAvQ3JrVmJXYUZVQVdKS0xaZ3RqSXFKeEhjdkhrWTZu?=
 =?utf-8?B?SXhxcnNydk9yYUtBY3pmSTdEZzNSM2Y5Q1M2WmV3YTV5K0hqY0xycjdST25q?=
 =?utf-8?B?NG5kSWdaZ0lHaVBmN0RMQkdNbTV6MTdHR2xBNGoxdk5LNGlRSFYvMWhlai83?=
 =?utf-8?B?bUtoODNpcTBLYmtmSXQ3dG5hOXlyWk9oQkJTMjhBQzFoQWdpazloVzBPVndR?=
 =?utf-8?B?ai9US3pwWGxWZlZyOS9hQTZxWDBYTG5kQkR0Tkg1anloOGlaem9FTHpiVHB2?=
 =?utf-8?B?QlRaWGRHVW1ZOWVTemF4cWN4UXRDS01JSDRLRHdmV1hSbkxIcFBmZ3NSNTA1?=
 =?utf-8?B?Ym1vUTZoVVhqSG44RG11N01aMVNzMzVPRnRjZW9rek14ZzNoYXpoQ2VSSTVJ?=
 =?utf-8?B?QWFuTFMxZVl5dURPMmorRnozV2I1eGkvK0pjOE9jSFRJVVV1TnlHejRGQnlm?=
 =?utf-8?B?cHZ5R1hKcm5UcFoveVM5SnRQOVkyOCt3enZmT2RHYU9TdUcvVGZWSVNHbmND?=
 =?utf-8?B?Tmw2eTBFanJaNGt1RnBsMEtSUk1qNFRvWCtSZ2YzSUxVSkxZdmpnRzg1c1F0?=
 =?utf-8?B?dGZiZ2V1cWZ6eXAwSGFvMjRQWG1OQ20xMkFGUEZEWXMwUndhdnMrTC90L2px?=
 =?utf-8?B?Q3hkeXhnbXBMZnQzWWMrS0ZFZC9ySDNQMFNuNFpRTmdtbitzaXdQa2U3TTNl?=
 =?utf-8?B?NUdwR2oyc3d1ZmkxbGtXY1lIb1BiTFFjV29RWXcrQkpldy9mbXV5cVNRbGV3?=
 =?utf-8?B?MTB5RytpMCs1RDRndnNPTUNnL2N1aTRqSnlrTHZnYUtBeDZiTEdTZzB1dHJM?=
 =?utf-8?B?QmFSOXNoWU45N0VOd1RjRmhYbmZ3dVF6bnpkbXFiZDkzS2Q2N0pvbFpPREkr?=
 =?utf-8?B?ekhoMlRyeWpTaDZ5cmx4OGsvSXBJODQ0WC9kK0RVMjZQbTlkVWkwZkFqVUpE?=
 =?utf-8?B?WUE3QS9salBjRnNiOHVML2NCSDlEVXgxU3dvc01aVUxPb29uSGprcHh5SWxp?=
 =?utf-8?B?eExtMzBWM0RTN1F6RUdCV0hmRC9va2ZjdTdvcUxrVVRPeDNTMUU0WWJaTTVC?=
 =?utf-8?B?Y3ltWmNKL0VuYjJTRlhpckV6bmlGWXkyRWNRa3pJaG8rZHR4TW4yY0F6bXBa?=
 =?utf-8?B?U0hnMVdoaEw5S3ZERmlxYW5IeitrdTZPdnVYWFNtTFhlT1FSRDhHR0Qrb3Zq?=
 =?utf-8?B?cDhNWEp5NmFBdi90WEx5czZ1U3hGTm1QdjFZVzZOMy9MdVZ6VFBFbTY3NzJR?=
 =?utf-8?B?c2dLZk4wVW5KMHRKZTkzZnZCcS9Rb3M3TG16WUsrdHZXMjROS3UxU25ZTlhF?=
 =?utf-8?B?YzlUbTZvempqS09FcHRhRmZMSGVIckhjRHFFa2g2NXdmczVlUU1ibm8wQUs2?=
 =?utf-8?B?NVNLUkxHaGc1RWZsQW81V09mNm43RDZCMGs5ZEE0cTE1aXhoN251VnRKSVNR?=
 =?utf-8?B?TGc2YUJxRTNYYTE5cWxzaGpjV3JwaktTVkRBQnp2bnN5bEZoZmdDZ2orV1ZL?=
 =?utf-8?B?ZnpRQStaZVNkaXN0dXY5cUdYR2YrRXc2K2p2UHpzZVlERmhvN3RNdDBRWlJN?=
 =?utf-8?B?eXZ6am9HMi9pNjd5WmZiMEg2ZkR0TmF0TFh6eHpZRFZXN1J4M2dYdDZXcWE0?=
 =?utf-8?B?YWJ6TkNuWjJjUzdUNmh6MWIzZ3hoaVhmNUhtTUV6eStLdG9ZUEtxMDdQUWEx?=
 =?utf-8?B?c3d0Z1o1T1BZS3BNQmo0Tmp4T2Y1UTFyUTEwa2NoekRsdFFrNXlTYWo1S2tS?=
 =?utf-8?B?MTNYdDRWQmdpNm9DaUNqbUQ2enVBMWxGYVhlQVd0bzVEbTNROW1yV1lKRlRH?=
 =?utf-8?B?VGc2a1Rob2YyUUhKUlpsQXQ5cVFVbm9uWStTM1NwNllzbW41aWdkcXJkZEVW?=
 =?utf-8?B?L2o2QW4vZld1OE5ndXN0ZmtrMmdyUkQ3NVFWSGhySnNzR2Q1Y0RzcEVPQ0RD?=
 =?utf-8?B?cm92U1VuS2NZK0tvaEFhRkJQZFlqdjJ5Y3pIOVNmY2FsRE83SVVDU3NrVE84?=
 =?utf-8?Q?h+Gs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6760.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTJpRlhNbVg2RUZYT2c0emZLUTdPa0tJTDNhS2NEb0JlK2xQSi9nL1cxbmxS?=
 =?utf-8?B?NHJ4a0wxNVRDS3N1UWpJcklTZ0g2VGpCREhjc1RtdlRvSmdjcGZyemJNbmg1?=
 =?utf-8?B?OEZkcVhjaTc1QUd2UXZla0tiZDd3eERQUzdueEJPcnhySnltYlFSMmRhK2Yz?=
 =?utf-8?B?UnMwZ1E5RHd5U0I4cktwWDJISzJLRkh1SGdDTkxiR0tNaCtQbHl3eDZ0Nk5q?=
 =?utf-8?B?ajBSc2UwdlBFbGZORHZ3QTBGNUo0d0szVnZ3L2FoUGlnVmlGQVFWcCtWMEsw?=
 =?utf-8?B?Z3BTNW13RkFIaEZ6cUg4dW12NnpmVStEU3M1OXZuWjd6M0gvTkZKaGtYOExo?=
 =?utf-8?B?T2w5UFpkTDE2US9KSmFZNVBUWkV3ZE5oL212U3UrL0tzYXVCdVo2d0w1eVhh?=
 =?utf-8?B?bktwWnMvUC9Sd0MvVTNuZkhzM3oyZm1JcTBiNkllMjlqblFES1pla25Hd084?=
 =?utf-8?B?VmlqR0xRUE8xQnh6c1FIaTRKQnViM1JYMzVVMEZVd3lONHErRG5FbEFHdHJ3?=
 =?utf-8?B?WDhQR1V1V0wwZktzSTZKTDVVdUxhbElvV0FweGpRZXBuQ2UvVnR2T3pqSlJx?=
 =?utf-8?B?QjJSNTJwenFpNjFhRUExWm9pd0Q4NUtESllCTmFqNTRxTUJKRmFweG1RQXY5?=
 =?utf-8?B?TUFvOVkwMjRtMWxTN1N2NExBTDRWUndmNTN6enlIT2c1L2tVTnlNak9XcjhK?=
 =?utf-8?B?Sy9QbzV6WGZEdkpZajVKQWU4TjlLUGkzVWIzK1hjVXFVYWpacGRHYkxPV09Y?=
 =?utf-8?B?TmtqRnRLUVUzR1FMZFdWUXQxc0t6c3RtRDNWSTd0cTFLYWVSL3Q5V3ppVm5U?=
 =?utf-8?B?OTlod2Z2d3Z4MzdHclJJVWtKS0NTRU1PRHNZZEk2Q2ZNRGx2Ym1SZGg1OXdO?=
 =?utf-8?B?TFhJaFBLWm1RWU9wTXlEZTJBN2hJZUZlSnp3aEpOSWNpUi9jd3NWZGUwWjQ1?=
 =?utf-8?B?aWNCWTk0Wml6Y0xVb1NvT1ROZXJUQ0I5OWlzNC9BUXA3STFMQUdQMkc4Sllo?=
 =?utf-8?B?WDZzYzFlQ05SY3lBQm55MmxUZFdQK1RhUWcyYWZGSHdBZVdzWS8vcEJkSk4y?=
 =?utf-8?B?OHlpM1dZZ2dpVHNoamJyc1pIM01vYjdkNjJxVHFsUnp3Y1Y4clcwVDVvdWFq?=
 =?utf-8?B?THNEWWR4UjZDd0JtU2RtRDAzblZuV1NMelFHSVB5WTZ2aFUyUUhFTjAzOFhG?=
 =?utf-8?B?Tk9VK3FXWkpPRThWRnVaVWhhcW1saHhWY2NUbFRtOVU0UzkyRHFTRnJ1Zm02?=
 =?utf-8?B?d1JqWVVtVXZLNlg3RDNiTWgxTVBFTGVjWmV6dFZXWWVXSUtZbWowZHZKcURV?=
 =?utf-8?B?MEUyMmVabFZYcEtQTDJtcFVFUXRkSiszdjM1d25vUVN5VmUyc1pqTlQ0ZCtl?=
 =?utf-8?B?aVRWZjZXNG9tcHZ5Z0JFWElQdHVudmJBVWRrdHBoejB4Y3JDTVBOTll4U2ty?=
 =?utf-8?B?eDBHSnJvUWdNU2Y5TmtvYWRaNTJUVWxIbXhUQmRReFpZc0ladmFIV0J3N0Ro?=
 =?utf-8?B?bExScEt6bXRwNE1zdi9XMVR5eWQ2TEdBSW5SenZxSEErMTFKdjdrRzdZVkwy?=
 =?utf-8?B?WFdVVDltTFlkbHJCZXZHb1NQUmpBb0dFRTFkcmlra0xWMnhTZElGcGhiK3Uz?=
 =?utf-8?B?b2xGV09MWVgyQTc1VHFvMFp0SUZCUGlqdVl1Qmc0K2lTalFSQkUrbkkzSy80?=
 =?utf-8?B?YmdiVnBjdTdQYUpTKzc1ZTlZbWIra2ppRUpOVEQrMUZNZEJPQUdoMWxSVjBY?=
 =?utf-8?B?QVZpcGhoZFdYd29qZXlmQWVOUGs2ZldaSWxZZzhpS2JvRmRHWWFXZlFjbjhs?=
 =?utf-8?B?SElkU1poU2NEMFNHUDEyS05kbVZwYUpnV1RjanRRTkM2NUhkUHZ6R0ZhMnhs?=
 =?utf-8?B?SSszZkRzN0JzUGorSkgybFYwZGx5R29lcGE4dHkwL3RqQW5XWVFmK0JkRi9a?=
 =?utf-8?B?RVk0L0ZaNktjS2R0eVVEeGF4TDNEa080VEdLUGRGcS94MnhrM2pxajRYRGNl?=
 =?utf-8?B?YlhRc1VBTWJXOC9McWZJOG9PQk8rcUJhNTdJNWg2Z3VZN1oxVEt2czdxRTV2?=
 =?utf-8?B?T0NVNG9oaVlvK2NmWWxveTdvZ293ZHhqOHVSNkFjNW9JaExQZEo1djNxUjl6?=
 =?utf-8?B?KzBxVFlyVlk3YXYvTituSlNpdFRkSFk5ZEQ1bnRreDJnQ1YwL2wxRW51Q09r?=
 =?utf-8?B?OFFBN2orOW1zYVBwNytHQU1SeGVnVVNwQXZOL1lCM3BrUm5hKzRWNHUwRjRl?=
 =?utf-8?B?YjZkWE1nYWdGTUx6aVRrVFVYUGNNQ1NuZkhkRktZVWN5cGNnbkd0aEhLaHlH?=
 =?utf-8?Q?L4lQArVwAvO98uRoVa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a026be-d070-45ae-47c0-08de64c2ab42
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6760.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:27:19.9513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XaX83FTbpU0Wz4VV2sgekcApOMXOF4jxVwemTkGUizNP2+lCoNmWpRjKEw+CPO+6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5600
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


On 2026-02-05 01:48, Perry Yuan wrote:
> From: Benjamin Welton <bewelton@amd.com>
>
> kfd_ioctl_profiler takes a similar approach to that of
> kfd_ioctl_dbg_trap (which contains debugger related IOCTL
> services) where kfd_ioctl_profiler will contain all profiler
> related IOCTL services. The IOCTL is designed to be expanded
> as needed to support additional profiler functionality.
>
> The current functionality of the IOCTL is to allow for profilers
> which need PMC counters from GPU devices to both signal to other
> profilers that may be on the system that the device has active PMC
> profiling taking place on it (multiple PMC profilers on the same
> device can result in corrupted counter data) and to setup the device
> to allow for the collection of SQ PMC data on all queues on the device.
>
> For PMC data for the SQ block (such as SQ_WAVES) to be available
> to a profiler, mmPERFCOUNT_ENABLE must be set on the queues. When
> profiling a single process, the profiler can inject PM4 packets into
> each queue to turn on PERFCOUNT_ENABLE. When profiling system wide,
> the profiler does not have this option and must have a way to turn
> on profiling for queues in which it cannot inject packets into directly.
>
> Accomplishing this requires a few steps:
>
> 1. Checking if the user has the necessary permissions to profile system
>     wide on the device. This check uses the same check that linux perf
>     uses to determine if a user has the necessary permissions to profile
>     at this scope (primarily if the process has CAP_SYS_PERFMON or is root).
>
> 2. Locking the device for profiling. This is done by setting a lock bit
>     on the device struct and storing the process that locked the device.
>
> 3. Iterating all queues on the device and issuing an MQD Update to enable
>     perfcounting on the queues.
>
> 4. Actions to cleanup if the process exits or releases the lock.
>
> The IOCTL also contains a link to the existing PC Sampling IOCTL as well.
> This is per a suggestion that we should potentially remove the PC Sampling
> IOCTL to have it be a part of the profiler IOCTL. This is a future change.
> In addition, we do expect to expand the profiler IOCTL to include
> additional profiler functionality in the future (which necessitates the
> use of a version number).
>
> Signed-off-by: Benjamin Welton <benjamin.welton@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Acked-by: Kent Russell <kent.russell@amd.com>
> Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 82 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  4 +
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 25 ++++++
>   .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 +
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  | 16 +++-
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  | 14 +++-
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c  |  8 +-
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 15 +++-
>   .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   | 11 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  7 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 11 +++
>   include/uapi/linux/kfd_ioctl.h                | 30 +++++++
>   12 files changed, 217 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 732ad1224a61..dbb111a33678 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -21,6 +21,7 @@
>    * OTHER DEALINGS IN THE SOFTWARE.
>    */
>   
> +#include <linux/capability.h>
>   #include <linux/device.h>
>   #include <linux/err.h>
>   #include <linux/fs.h>
> @@ -3204,6 +3205,84 @@ static int kfd_ioctl_create_process(struct file *filep, struct kfd_process *p, v
>   	return 0;
>   }
>   
> +static inline uint32_t profile_lock_device(struct kfd_process *p,
> +					   uint32_t gpu_id, uint32_t op)
> +{
> +	struct kfd_process_device *pdd;
> +	struct kfd_dev *kfd;
> +	int status = -EINVAL;
> +
> +	if (!p)
> +		return -EINVAL;
> +
> +	mutex_lock(&p->mutex);
> +	pdd = kfd_process_device_data_by_id(p, gpu_id);
> +	mutex_unlock(&p->mutex);
> +
> +	if (!pdd || !pdd->dev || !pdd->dev->kfd)
> +		return -EINVAL;
> +
> +	kfd = pdd->dev->kfd;
> +
> +	mutex_lock(&kfd->profiler_lock);
> +	if (op == 1) {
> +		if (!kfd->profiler_process) {
> +			kfd->profiler_process = p;
> +			status = 0;
> +		} else if (kfd->profiler_process == p) {
> +			status = -EALREADY;
> +		} else {
> +			status = -EBUSY;
> +		}
> +	} else if (op == 0 && kfd->profiler_process == p) {
> +		kfd->profiler_process = NULL;
> +		status = 0;
> +	}
> +	mutex_unlock(&kfd->profiler_lock);
> +
> +	return status;
> +}
> +
> +static inline int kfd_profiler_pmc(struct kfd_process *p,
> +				   struct kfd_ioctl_pmc_settings *args)
> +{
> +	struct kfd_process_device *pdd;
> +	struct device_queue_manager *dqm;
> +	int status;
> +
> +	/* Check if we have the correct permissions. */
> +	if (!perfmon_capable())
> +		return -EPERM;
> +
> +	/* Lock/Unlock the device based on the parameter given in OP */
> +	status = profile_lock_device(p, args->gpu_id, args->lock);
> +	if (status != 0)
> +		return status;
> +
> +	/* Enable/disable perfcount if requested */
> +	mutex_lock(&p->mutex);
> +	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
> +	dqm = pdd->dev->dqm;
> +	mutex_unlock(&p->mutex);
> +
> +	dqm->ops.set_perfcount(dqm, args->perfcount_enable);
> +	return status;
> +}
> +
> +static int kfd_ioctl_profiler(struct file *filep, struct kfd_process *p, void *data)
> +{
> +	struct kfd_ioctl_profiler_args *args = data;
> +
> +	switch (args->op) {
> +	case KFD_IOC_PROFILER_VERSION:
> +		args->version = KFD_IOC_PROFILER_VERSION_NUM;
> +		return 0;
> +	case KFD_IOC_PROFILER_PMC:
> +		return kfd_profiler_pmc(p, &args->pmc);
> +	}
> +	return -EINVAL;
> +}
> +
>   #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
>   	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags = _flags, \
>   			    .cmd_drv = 0, .name = #ioctl}
> @@ -3325,6 +3404,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
>   
>   	AMDKFD_IOCTL_DEF(AMDKFD_IOC_CREATE_PROCESS,
>   			kfd_ioctl_create_process, 0),
> +
> +	AMDKFD_IOCTL_DEF(AMDKFD_IOC_PROFILER,
> +			kfd_ioctl_profiler, 0),
>   };
>   
>   #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 9a66ee661e57..f231e46e8528 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -936,6 +936,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>   
>   	svm_range_set_max_pages(kfd->adev);
>   
> +	kfd->profiler_process = NULL;
> +	mutex_init(&kfd->profiler_lock);
> +
>   	kfd->init_complete = true;
>   	dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev->vendor,
>   		 kfd->adev->pdev->device);
> @@ -971,6 +974,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>   		ida_destroy(&kfd->doorbell_ida);
>   		kfd_gtt_sa_fini(kfd);
>   		amdgpu_amdkfd_free_kernel_mem(kfd->adev, &kfd->gtt_mem);
> +		mutex_destroy(&kfd->profiler_lock);
>   	}
>   
>   	kfree(kfd);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 804851632c4c..4170a283db5b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -305,6 +305,29 @@ static int remove_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	return r;
>   }
>   
> +static void set_perfcount(struct device_queue_manager *dqm, int enable)
> +{
> +	struct device_process_node *cur;
> +	struct qcm_process_device *qpd;
> +	struct queue *q;
> +	struct mqd_update_info minfo = { 0 };
> +
> +	if (!dqm)
> +		return;
> +
> +	minfo.update_flag = (enable == 1 ? UPDATE_FLAG_PERFCOUNT_ENABLE :
> +						 UPDATE_FLAG_PERFCOUNT_DISABLE);
> +	dqm_lock(dqm);
> +	list_for_each_entry(cur, &dqm->queues, list) {
> +		qpd = cur->qpd;
> +		list_for_each_entry(q, &qpd->queues_list, list) {
> +			pqm_update_mqd(qpd->pqm, q->properties.queue_id,
> +						&minfo);
> +		}
> +	}
> +	dqm_unlock(dqm);
> +}
> +
>   static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)
>   {
>   	struct device_process_node *cur;
> @@ -2967,6 +2990,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
>   		dqm->ops.reset_queues = reset_queues_cpsch;
>   		dqm->ops.get_queue_checkpoint_info = get_queue_checkpoint_info;
>   		dqm->ops.checkpoint_mqd = checkpoint_mqd;
> +		dqm->ops.set_perfcount = set_perfcount;
>   		break;
>   	case KFD_SCHED_POLICY_NO_HWS:
>   		/* initialize dqm for no cp scheduling */
> @@ -2987,6 +3011,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_node *dev)
>   		dqm->ops.get_wave_state = get_wave_state;
>   		dqm->ops.get_queue_checkpoint_info = get_queue_checkpoint_info;
>   		dqm->ops.checkpoint_mqd = checkpoint_mqd;
> +		dqm->ops.set_perfcount = set_perfcount;
>   		break;
>   	default:
>   		dev_err(dev->adev->dev, "Invalid scheduling policy %d\n", dqm->sched_policy);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index ef07e44916f8..74a3bcec3e4e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -200,6 +200,8 @@ struct device_queue_manager_ops {
>   				  const struct queue *q,
>   				  void *mqd,
>   				  void *ctl_stack);
> +	void	(*set_perfcount)(struct device_queue_manager *dqm,
> +				  int enable);
>   };
>   
>   struct device_queue_manager_asic_ops {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> index 97055f808d4a..993d60a24d50 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -124,10 +124,9 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>   	 */
>   	m->cp_hqd_hq_scheduler0 = 1 << 14;
>   
> -	if (q->format == KFD_QUEUE_FORMAT_AQL) {
> +	if (q->format == KFD_QUEUE_FORMAT_AQL)
>   		m->cp_hqd_aql_control =
>   			1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
> -	}
>   
>   	if (mm->dev->kfd->cwsr_enabled) {
>   		m->cp_hqd_persistent_state |=
> @@ -142,6 +141,12 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>   		m->cp_hqd_wg_state_offset = q->ctl_stack_size;
>   	}
>   
> +	mutex_lock(&mm->dev->kfd->profiler_lock);
> +	if (mm->dev->kfd->profiler_process != NULL)
> +		m->compute_perfcount_enable = 1;
> +
> +	mutex_unlock(&mm->dev->kfd->profiler_lock);
> +
>   	*mqd = m;
>   	if (gart_addr)
>   		*gart_addr = addr;
> @@ -221,6 +226,13 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
>   	if (mm->dev->kfd->cwsr_enabled)
>   		m->cp_hqd_ctx_save_control = 0;
>   
> +	if (minfo) {
> +		if (minfo->update_flag == UPDATE_FLAG_PERFCOUNT_ENABLE)
> +			m->compute_perfcount_enable = 1;
> +		else if (minfo->update_flag == UPDATE_FLAG_PERFCOUNT_DISABLE)
> +			m->compute_perfcount_enable = 0;
> +	}
> +
>   	update_cu_mask(mm, mqd, minfo);
>   	set_priority(m, q);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index 7e5a7ab6d0c0..4a574bbb5f37 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -164,10 +164,9 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>   	if (amdgpu_amdkfd_have_atomics_support(mm->dev->adev))
>   		m->cp_hqd_hq_status0 |= 1 << 29;
>   
> -	if (q->format == KFD_QUEUE_FORMAT_AQL) {
> +	if (q->format == KFD_QUEUE_FORMAT_AQL)
>   		m->cp_hqd_aql_control =
>   			1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
> -	}
>   
>   	if (mm->dev->kfd->cwsr_enabled) {
>   		m->cp_hqd_persistent_state |=
> @@ -182,6 +181,11 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>   		m->cp_hqd_wg_state_offset = q->ctl_stack_size;
>   	}
>   
> +	mutex_lock(&mm->dev->kfd->profiler_lock);
> +	if (mm->dev->kfd->profiler_process != NULL)
> +		m->compute_perfcount_enable = 1;
> +	mutex_unlock(&mm->dev->kfd->profiler_lock);
> +
>   	*mqd = m;
>   	if (gart_addr)
>   		*gart_addr = addr;
> @@ -259,6 +263,12 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
>   	}
>   	if (mm->dev->kfd->cwsr_enabled)
>   		m->cp_hqd_ctx_save_control = 0;
> +	if (minfo) {
> +		if (minfo->update_flag == UPDATE_FLAG_PERFCOUNT_ENABLE)
> +			m->compute_perfcount_enable = 1;
> +		else if (minfo->update_flag == UPDATE_FLAG_PERFCOUNT_DISABLE)
> +			m->compute_perfcount_enable = 0;
> +	}
>   
>   	update_cu_mask(mm, mqd, minfo);
>   	set_priority(m, q);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> index a51f217329db..7173f6470e5e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> @@ -139,10 +139,9 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>   	if (amdgpu_amdkfd_have_atomics_support(mm->dev->adev))
>   		m->cp_hqd_hq_status0 |= 1 << 29;
>   
> -	if (q->format == KFD_QUEUE_FORMAT_AQL) {
> +	if (q->format == KFD_QUEUE_FORMAT_AQL)
>   		m->cp_hqd_aql_control =
>   			1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
> -	}
>   
>   	if (mm->dev->kfd->cwsr_enabled) {
>   		m->cp_hqd_persistent_state |=
> @@ -157,6 +156,11 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>   		m->cp_hqd_wg_state_offset = q->ctl_stack_size;
>   	}
>   
> +	mutex_lock(&mm->dev->kfd->profiler_lock);
> +	if (mm->dev->kfd->profiler_process != NULL)
> +		m->compute_perfcount_enable = 1;
> +	mutex_unlock(&mm->dev->kfd->profiler_lock);
> +
>   	*mqd = m;
>   	if (gart_addr)
>   		*gart_addr = addr;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index dcf4bbfa641b..d4659a438be5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -218,10 +218,9 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>   		m->cp_hqd_aql_control =
>   			1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
>   
> -	if (q->tba_addr) {
> +	if (q->tba_addr)
>   		m->compute_pgm_rsrc2 |=
>   			(1 << COMPUTE_PGM_RSRC2__TRAP_PRESENT__SHIFT);
> -	}
>   
>   	if (mm->dev->kfd->cwsr_enabled && q->ctx_save_restore_area_address) {
>   		m->cp_hqd_persistent_state |=
> @@ -236,6 +235,11 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>   		m->cp_hqd_wg_state_offset = q->ctl_stack_size;
>   	}
>   
> +	mutex_lock(&mm->dev->kfd->profiler_lock);
> +	if (mm->dev->kfd->profiler_process != NULL)
> +		m->compute_perfcount_enable = 1;
> +	mutex_unlock(&mm->dev->kfd->profiler_lock);
> +
>   	*mqd = m;
>   	if (gart_addr)
>   		*gart_addr = addr;
> @@ -318,6 +322,13 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
>   	if (mm->dev->kfd->cwsr_enabled && q->ctx_save_restore_area_address)
>   		m->cp_hqd_ctx_save_control = 0;
>   
> +	if (minfo) {
> +		if (minfo->update_flag == UPDATE_FLAG_PERFCOUNT_ENABLE)
> +			m->compute_perfcount_enable = 1;
> +		else if (minfo->update_flag == UPDATE_FLAG_PERFCOUNT_DISABLE)
> +			m->compute_perfcount_enable = 0;
> +	}
> +
>   	if (KFD_GC_VERSION(mm->dev) != IP_VERSION(9, 4, 3) &&
>   	    KFD_GC_VERSION(mm->dev) != IP_VERSION(9, 4, 4) &&
>   	    KFD_GC_VERSION(mm->dev) != IP_VERSION(9, 5, 0))
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> index 09483f0862d4..e8967f5e3892 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> @@ -149,6 +149,11 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
>   		m->cp_hqd_wg_state_offset = q->ctl_stack_size;
>   	}
>   
> +	mutex_lock(&mm->dev->kfd->profiler_lock);
> +	if (mm->dev->kfd->profiler_process != NULL)
> +		m->compute_perfcount_enable = 1;
> +	mutex_unlock(&mm->dev->kfd->profiler_lock);
> +
>   	*mqd = m;
>   	if (gart_addr)
>   		*gart_addr = addr;
> @@ -231,6 +236,12 @@ static void __update_mqd(struct mqd_manager *mm, void *mqd,
>   		m->cp_hqd_ctx_save_control =
>   			atc_bit << CP_HQD_CTX_SAVE_CONTROL__ATC__SHIFT |
>   			mtype << CP_HQD_CTX_SAVE_CONTROL__MTYPE__SHIFT;
> +	if (minfo) {
> +		if (minfo->update_flag == UPDATE_FLAG_PERFCOUNT_ENABLE)
> +			m->compute_perfcount_enable = 1;
> +		else if (minfo->update_flag == UPDATE_FLAG_PERFCOUNT_DISABLE)
> +			m->compute_perfcount_enable = 0;
> +	}
>   
>   	update_cu_mask(mm, mqd, minfo);
>   	set_priority(m, q);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 9849b54f54ba..8983065645fa 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -384,6 +384,11 @@ struct kfd_dev {
>   	int kfd_dev_lock;
>   
>   	atomic_t kfd_processes_count;
> +
> +	/* Lock for profiler process */
> +	struct mutex profiler_lock;
> +	/* Process currently holding the lock */
> +	struct kfd_process *profiler_process;
>   };
>   
>   enum kfd_mempool {
> @@ -556,6 +561,8 @@ enum mqd_update_flag {
>   	UPDATE_FLAG_DBG_WA_ENABLE = 1,
>   	UPDATE_FLAG_DBG_WA_DISABLE = 2,
>   	UPDATE_FLAG_IS_GWS = 4, /* quirk for gfx9 IP */
> +	UPDATE_FLAG_PERFCOUNT_ENABLE = 5,
> +	UPDATE_FLAG_PERFCOUNT_DISABLE = 6,
>   };
>   
>   struct mqd_update_info {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 8511fbebf327..deca19b478d0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1110,6 +1110,16 @@ static void kfd_process_free_outstanding_kfd_bos(struct kfd_process *p)
>   		kfd_process_device_free_bos(p->pdds[i]);
>   }
>   
> +static void kfd_process_profiler_release(struct kfd_process *p, struct kfd_process_device *pdd)
> +{
> +	mutex_lock(&pdd->dev->kfd->profiler_lock);
> +	if (pdd->dev->kfd->profiler_process == p) {
> +		pdd->qpd.dqm->ops.set_perfcount(pdd->qpd.dqm, 0);
> +		pdd->dev->kfd->profiler_process = NULL;
> +	}
> +	mutex_unlock(&pdd->dev->kfd->profiler_lock);
> +}
> +
>   static void kfd_process_destroy_pdds(struct kfd_process *p)
>   {
>   	int i;
> @@ -1121,6 +1131,7 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
>   
>   		pr_debug("Releasing pdd (topology id %d, for pid %d)\n",
>   			pdd->dev->id, p->lead_thread->pid);
> +		kfd_process_profiler_release(p, pdd);
>   		kfd_process_device_destroy_cwsr_dgpu(pdd);
>   		kfd_process_device_destroy_ib_mem(pdd);
>   
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
> index e72359370857..abb526c915c3 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -1558,6 +1558,30 @@ struct kfd_ioctl_dbg_trap_args {
>   	};
>   };
>   
> +#define KFD_IOC_PROFILER_VERSION_NUM 1
> +enum kfd_profiler_ops {
> +	KFD_IOC_PROFILER_PMC = 0,
> +	KFD_IOC_PROFILER_PC_SAMPLE = 1,
[JZ] I think I haven't updtream PC Sampling features.
> +	KFD_IOC_PROFILER_VERSION = 2,
> +};
> +
> +/**
> + * Enables/Disables GPU Specific profiler settings
> + */
> +struct kfd_ioctl_pmc_settings {
> +	__u32 gpu_id;             /* This is the user_gpu_id */
> +	__u32 lock;               /* Lock GPU for Profiling */
> +	__u32 perfcount_enable;   /* Force Perfcount Enable for queues on GPU */
> +};
> +
> +struct kfd_ioctl_profiler_args {
> +	__u32 op;						/* kfd_profiler_op */
> +	union {
> +		struct kfd_ioctl_pmc_settings  pmc;
> +		__u32 version;				/* KFD_IOC_PROFILER_VERSION_NUM */
> +	};
> +};
> +
>   #define AMDKFD_IOCTL_BASE 'K'
>   #define AMDKFD_IO(nr)			_IO(AMDKFD_IOCTL_BASE, nr)
>   #define AMDKFD_IOR(nr, type)		_IOR(AMDKFD_IOCTL_BASE, nr, type)
> @@ -1684,4 +1708,10 @@ struct kfd_ioctl_dbg_trap_args {
>   #define AMDKFD_COMMAND_START		0x01
>   #define AMDKFD_COMMAND_END		0x28
>   
> +#define AMDKFD_IOC_PROFILER			\
> +		AMDKFD_IOWR(0x86, struct kfd_ioctl_profiler_args)
> +
> +#define AMDKFD_COMMAND_START_2		0x80
> +#define AMDKFD_COMMAND_END_2		0x87
> +
>   #endif

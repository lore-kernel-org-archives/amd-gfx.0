Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AF0D25B4E
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 12:30:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8666510E2A8;
	Wed, 28 Jan 2026 12:30:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nF2dqv0a";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D197A10E2A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 12:30:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFHKh9LLyHcSH4m2L9/leztUCXojONREP+StxCRsBs8fGEjqSXjuhpkfpZl8JrNwfWxluhbraGlRYFmg3o8ER/4We7tv0WwiexOABYdwMnnMrWNQYUWx9y5YfGqcCh4N6IydDN3WiBeBeOOw31eQHhUZIDvB+JG/O7LCuqLHORs6jUBbu9KgfxvgVETPu5mulVXefyIeC30VUFGdiALRm2XCA7Xu+vuS9BxiUOLBLQX+OF+boVW1Bjde1x1gxm47t3GRHmOIgwwZKb5n2sHJxxwwHq1XdzgfWkGjyR3aR2GFActzQgDa3JUbcCd/962sClW4xfefhtMIhjFH2yNIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alC6lLclf8By8IvnZtp3m6Xh9odjbSPfgfoVCvjHv/M=;
 b=rO7poHUIZU2SPlUYUpyP0ZdNzqLUhKBH/8ki7gvbYntjnqXChD8BKG3VBPmnYsy4Nxl95krwV1LYzEJ8ysJxRy0Xxt/NHCEsKmeMNHtDr7HnyXDzCFoby4BnAiNpCLUvc0iD2LaCcp7gl3DZoyQls6JObGOq8Y4zfwVsZt+nDrGPg9ng/Fe2FsGGRoutI4WL+S+OAd+4Gx+wGnnMiWd6P7jPF0ieb+MvIFvrYS9zk19/lqyh02hkh98RaGcoqdfv4kz0W24QL6GUMQqWJO989LYRylhKk78eBG4HEMFNUfER0xkPdsy8pPomG2Uy5M3NFkGPh1NuPGlq/cq4OZ5InA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alC6lLclf8By8IvnZtp3m6Xh9odjbSPfgfoVCvjHv/M=;
 b=nF2dqv0a+gFLH0L1rr7UGbIUoAMVtQ8BTASt2Sj+BhxMi51U67OZLLHly/e8UJvohDMpB1AHPq/4E5SDyo/3N0jlBrQD/zPt1o9OD2VA9Mt5YId5vYdBq5WgAXdX1HP5sJJgCdNNOBSjs0Glyrn1lQ9C3/YZUrg25C9N/ElMDxk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9)
 by DM6PR12MB4139.namprd12.prod.outlook.com (2603:10b6:5:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 12:30:24 +0000
Received: from CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::5a7a:2adf:1862:35c3]) by CH3PR12MB9079.namprd12.prod.outlook.com
 ([fe80::5a7a:2adf:1862:35c3%3]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 12:30:24 +0000
Message-ID: <a00342a1-951b-4909-9d5f-48141917a522@amd.com>
Date: Wed, 28 Jan 2026 12:30:15 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/11] drm/amdgpu: Add user save area params validation
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jesse.Zhang@amd.com,
 "Yat Sin, David" <David.YatSin@amd.com>, "Kim, Jonathan"
 <jonathan.kim@amd.com>, "Morichetti, Laurent" <Laurent.Morichetti@amd.com>
References: <20260122104118.1682154-1-lijo.lazar@amd.com>
 <20260122104118.1682154-5-lijo.lazar@amd.com>
 <CADnq5_N4SwVA_RXjPqQVV2ERsnOjCzGKXGfS-2xaHShNxee8=A@mail.gmail.com>
 <d7e73dbe-fa0d-42ed-8b16-fee352e8b662@amd.com>
 <CADnq5_P243kbtXDgv0JqgjmB9taA+2uMUbYtR90aVzPU4APXUw@mail.gmail.com>
 <2c920279-0245-4b66-9604-7333b00b9983@amd.com>
Content-Language: en-US
From: Lancelot SIX <Lancelot.Six@amd.com>
In-Reply-To: <2c920279-0245-4b66-9604-7333b00b9983@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::11) To CH3PR12MB9079.namprd12.prod.outlook.com
 (2603:10b6:610:1a1::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9079:EE_|DM6PR12MB4139:EE_
X-MS-Office365-Filtering-Correlation-Id: 41995b5b-8103-48f9-62f5-08de5e69026f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFZiZWlDa0R6SlZvQVRuTFErV095cVNSWGJ4bEN5N3dkT2VWN2ovZzc5N2do?=
 =?utf-8?B?elFaMWI4ZGczc3cwdWY5bkc5TFVUMExPNnovSGdJdmIzTHVBbmtMWjgwcXBU?=
 =?utf-8?B?OXNleUtEblRXcGZRYUdlTVFKa2h2VTlJQ2lCQ3g4YUxDM2lZY09obGJFaHBN?=
 =?utf-8?B?QzZjRTVidmIrYzc3V1dnRWlCZ3hoNGsvVk1xdXdXTDdxMnFFUkZlWHIyb2lz?=
 =?utf-8?B?M2x6SXVWYVJyTS9YQXp4SStCTzIreE90U2p4OUpEZXh5aDdqaStqc0VKazhH?=
 =?utf-8?B?dzJqWGZZbzNPZU0zZkJGaDMxOVk0STR5NHo1NXJqOWFNdGV4eGJqK0huQS9u?=
 =?utf-8?B?c1o4VEhrdFVrYTA0TXRFOFVXYWR0QXJKMUVML1Q4cmRwSnExc09qQUtpWlhD?=
 =?utf-8?B?L1ZlYXR3NmZ3cm1DbGUyUjlyOFdMaWEyYUFwMWR3WEVWNWVrZU1iMHlYSHlK?=
 =?utf-8?B?T242aGJucnFrYzM1aEhsaFpQdDdsbkpYYzgxRTdXbHRTVlVUeUdFWjk3ZUFK?=
 =?utf-8?B?ZU5ZZmFjQlFCQzFWN3BxdEVXN3h1NGxta3I1UmZ2b2l5RExuREx4MWs3cUlB?=
 =?utf-8?B?SzdjaWR2Wnl1MHdvcitiSlFKNnM5K3dlb2x6K2M0QlZnRHRZcjBoL1o2UHZQ?=
 =?utf-8?B?czdTSU1oZmRyaWpKS2EzZjhHOEowOTAxS1lUUW1Na2ZxUTJQQTFrSXRCNWl6?=
 =?utf-8?B?dHd6UnJLMFI4Sk5YOHYyTXJqdVB1RUM1dkIrNzRTQTZURnl6bVk1Y2xnQUFa?=
 =?utf-8?B?anV6RDBoQjBpdTdGc3VWQTI0WGJDTUp4aW1VNVpZaDNxY3JlVHRsa1I4QVN5?=
 =?utf-8?B?QnRLOHU3YXpHbk9tRDdsTDlEK29XdjhrdzhCOEZpZy9EckhRQmxlMlR1YkVh?=
 =?utf-8?B?TG44M1NFRUtISUFrWWlYUGlRclkwRE9ON3RsQ1ZRaUZPMnhONVlod2tWUFVn?=
 =?utf-8?B?U3V6NzNyYW8xWktZcmxhYldFZ2R4d0YxemdkM1poR2lyS1VWbmNIb216QzhI?=
 =?utf-8?B?aVRKZVl1a0xWY2JDQldwdTBvOUhRRjlYTWtEdFdJMTI0cXB0ZDM2bDVFd2hE?=
 =?utf-8?B?SHhQcDY4OG1Meit6bWJJRGtPcVVTM1VxSG02a0cwSW5FbXVodlVhWjdERmJY?=
 =?utf-8?B?TlVxaTFmbzRqQWZxeW9tOWNQOVFiMER3eUdDajQ4VkxYNXFUYlUzR2JqU3A1?=
 =?utf-8?B?SnczOTVFRXNuN0hQL2szempQNkpwYTRLMFNXTnR0aUhaWUlDQUdabE5yd2hj?=
 =?utf-8?B?bDErNVJFaGhweFJQd3pBZTZPUE5zRjNCQWhKZGlqWHRjRitxbEd5b0YrOFJV?=
 =?utf-8?B?SHk2eWNYL1Y2QlNZZmQ1UHVnb1VnSS91eDZwK1lDZmI5ZXJnakNFWWtremlZ?=
 =?utf-8?B?M1d3SUhSNHVOUlFpM3c4UmNjMWd1REsyYXYvTE14UGI2R2ljM3o3WGtsMngx?=
 =?utf-8?B?M21RaDRyL3h2c3UzN09ranNXcHo1U0U0UVk3NFlyUVNDNmppTk5BMEpvYkhO?=
 =?utf-8?B?ZHpQZkFSOUpqVkxyTUNDZHFkZDJjQmRNVGlQeTQrMCt0ZTdsZWtkV1U4ZUxU?=
 =?utf-8?B?S1ZHUEx6YkdkS1ErdDd6am0rRWRSNWp3Unlpd2J0c3VvMU1pR3FTb3k3MFkr?=
 =?utf-8?B?U1R1Z1Aza3hVeENyaW5XNXZZdlZwTlVYTzZ2Z1VqMHFFaWFXeTBaSWtXNXlW?=
 =?utf-8?B?a2VMaDFrTlJrMFU4b0RVSlIyZkp1TXh4U3BVMFRVTncyQ1dIb1J3OHhnYnFG?=
 =?utf-8?B?Ym52Nzl4REYvSU9KWk9rRVJJcFJZem1nZjFnSGVIeHJpR0ZCcFMycytWQXlp?=
 =?utf-8?B?VlZTcmNmbWR6cVlTSDdGVWoxN2diRk8yOWFkdmhJNEFJdlcwMTFycDRVOUd6?=
 =?utf-8?B?Q1g3VjkrTVhhSTJTWTRQVjBDcGdTaFVoL05vNHpUcFVXM3Y4dU1lU0ZxRDMx?=
 =?utf-8?B?SmdBa0tIOGsxcU1YeGxpNUhsOFBXZ3N6NER3bmhRWjlsZVREMnUwL3BDR2cw?=
 =?utf-8?B?ZFl0OGxuVU9sZmxXZGFRaVdDeTNNR3o4aWdmK3VaaUVBSXVDMndOS2hmUzRF?=
 =?utf-8?B?UkpUdUhIem5BVlZqcEsweGd5d1dTbXRzeld1dGNuZS96VDRmNGhQN2VKNTVB?=
 =?utf-8?Q?gVSM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9079.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3hRUStkR2QxWFFnYzZVSEdadHpLZnVqQUlvNkVhSGxvOU5WakdpSG8wV3U5?=
 =?utf-8?B?d1hIcEtzOXg4M1B2ZVU1SUNQSkQzTUEwajkxUDVRbXlxa0RpZmdBaktIazBk?=
 =?utf-8?B?bmxBK2drWFZINk5xU3JlVE0xQnpZb2JqdEQzeFQwNjFOd1FLeS92M2J2aGEv?=
 =?utf-8?B?RmlDSjNtWlJKeDlJeUhJYUQybFFjVzRSdTFGSUo0QU1jcnI5T2kzQmh2Q0Rz?=
 =?utf-8?B?WklLMGdHZyt6ckN1MWdpL0djY01UR0pVRzZBbzZtbThwbHg1aEtDNXNSc1J3?=
 =?utf-8?B?ak5DU1IyNHBGRFdtcFpDVHpzVnUzOXhFUlZKaGVVVWtzdFE5VGQ3ODA5RG1Q?=
 =?utf-8?B?cnhYU1dnYmJsK3AvaUZ6RXlzcG14bW5CazJzNHpDWG9kaFovYXNiWElnRHZp?=
 =?utf-8?B?UWJsaHE2WGtpcXBXZkNnVVJtRlI1a0xTK29YZTJNazQ2VUxuYTVXTGJnUEk2?=
 =?utf-8?B?TXF0U0FJcWJjQWZDaU5ocVJZSnd5UGp4ZzFZdjNVTjBTQlJrVkVYN21PSXhj?=
 =?utf-8?B?eXJ4cWdSQUZGcWFxRFplNlIwVnkwK1dmMVdjY1hSaVJqNGxFR1B6RVRmRlpO?=
 =?utf-8?B?YnpmVndkNlQ4dU42M0xGVENheG5ZU2xWM0VVbWVjTFJRblRUcEhFODBJYzcy?=
 =?utf-8?B?M0Q3MVdOMG5td0NFVll6TDU4UXQrVTZ5QktnRnN0aWFWMy8yN0NRbjZNWldi?=
 =?utf-8?B?Vk1PSDMrN2dJSWNseTA0aGxDWHZlaEFvcGRKWVJERzhES1IvV2NXYzJuU3py?=
 =?utf-8?B?NFVFWkxIK3cxYThLc1VuNUVCWEVFL05ORkVIZFh3UXVTaGw4TUkrM1B4U0JZ?=
 =?utf-8?B?cGpXcEsvZ3A2K3FyS1AxdXNxdzBDSUpibkJuRFpUVlJDZE5tNG9PZExVTkVx?=
 =?utf-8?B?TmN1QUEyb01ucWk4Z3EzOFhqVVQyUGc3amN6RVo4bUZYUWJGVitETHcxUnBi?=
 =?utf-8?B?eFl5SWlTY0I1eEVsV1ZnRnRaYnE1SUJWNUVwVXZ6TDVWdnVlKzlSSEs2Rk5X?=
 =?utf-8?B?OWpFRmxqSUtzbURmUEZUVTNkNFRtNEFydEdmSXdjNHhNQXkwUCtsUis2K0tB?=
 =?utf-8?B?Ukd6dlp1MEtXVDFuQ0d6TzJBbjl1SlVteDgyNkFpZlRCOGNJQ1ZKZm1GLzBX?=
 =?utf-8?B?UlIvMnh2cmIyd0dCaWVWZCs2Q0tMZjVPYXhtcm9mU3FIeE13MmV4dlZZZjh3?=
 =?utf-8?B?dFIvQkp4WUtrbFBYY1RqUFlnWVJ0QTR4YVNFOW1tZVhGenhiNkxTT2s5U3Vk?=
 =?utf-8?B?eFBsQUNYOHZCRi9xd1JFcnlJalpEb2orb1N0Vkp0eU1IeEhXT25mT1kvenh0?=
 =?utf-8?B?TVRQaGl0WTZYN0R5U3hyWElyWEwwZE1neVhjUWFFdktQTTBVcTkzRWs4MjNH?=
 =?utf-8?B?U29zR3dNQk1VTTlXNG4xaVovMkRoM0xoaDJxYWk0d01KSU1oT3MwY3BpZjNF?=
 =?utf-8?B?ZWRxQWo1SDdOVnBnS3NMTWJtdlhoM0o5aTBJeUZBNU9GOHFTRG4wVkY3N3Zt?=
 =?utf-8?B?SGRPVWM2TGxKWVQ0QWJUdlAyNkc2dzVQaDAvcXpHcG9TRnljUEFLQkJJQzYw?=
 =?utf-8?B?alJpSXkwRFd6TTllbERMQ01Ja09INklpbE5URnIyUzlLeTNiVFo5V29iRUts?=
 =?utf-8?B?bDhpOUM5dnBkMVRoT3FKS0JaRzVzZUZnVWx2REc0ZTN5SmZrdmJRbFJwUzB1?=
 =?utf-8?B?Wk1XVm9hZkR3YklveEZFYXpuWGEzVHlEcG9FS3JjY3Zhd0d0Q0NrV1lFUmNq?=
 =?utf-8?B?TFozbWZnbjZLbElSVGs2aVFEUFVXbnltMXRTUjB5RVNXUFFaZDlBa3I1MGRa?=
 =?utf-8?B?OVZvTjdPUTA0MEExTTZpUHhYblZRRUNlMHQ3MHcyZ2U0VnpQVmJ5K0RpcHZy?=
 =?utf-8?B?R2FlUW9sQXRHb3g0M1kreThNbVZiZzhwSDVyZm12enFqeVVReWVPOW5BUFlZ?=
 =?utf-8?B?ODZCVmc4U0hUbnVLUE5OQTNOYVZwQXM4dnVnYXVQVXp3bThCMzlQR1U2UTRM?=
 =?utf-8?B?Qjk1R1REU1FGWFlST05DNlZXUWl5d0pqamdFRmVIekIvc3QzQzdVSHhDN2pH?=
 =?utf-8?B?TGkyVGRtVHhnbyt3NFoxY0o1L2FjdkZwR1E4SEdyNnNVZHpsQ2ErRDZ6SnB6?=
 =?utf-8?B?eGRIcXBzU2dpMDNadXpTNW5hWjJUV2tpSDNCRTVPakhjQ0c4cnVpYzdoLzFv?=
 =?utf-8?B?Z05WbzZuNTlCR0J0MHlJYjB4SXVERFNOMnlueGJaTC9LWHdiSVZwYUpOTFlY?=
 =?utf-8?B?eFZsT2cvR3BFMVczL1FtQXNFc01WYktQTGpMMkVJSG1BTWFPbHFMejZDT2xX?=
 =?utf-8?Q?VIJfwmqbNLnNRZmzx2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41995b5b-8103-48f9-62f5-08de5e69026f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9079.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 12:30:24.0578 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jg/4HECoijwkOhbTskvSU4i0PBuEfTkBNQWCKD4bv8lWbUuS6vX6ItsmNvQ6Q94Sts/OjSV4Wj18Hbvjcqh9Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4139
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

>>>>> +       /*
>>>>> +        * Only control stack and save area size details checked. 
>>>>> Address validation needs to be
>>>>> +        * carried out separately.
>>>>> +        */
>>>>> +       if (cwsr_params->ctl_stack_sz !=
>>>>> +           (cwsr_info->xcc_ctl_stack_sz * num_xcc)) {
>>>>> +               dev_dbg(adev->dev,
>>>>> +                       "queue ctl stack size 0x%x not equal to 
>>>>> node ctl stack size 0x%x\n",
>>>>> +                       cwsr_params->ctl_stack_sz,
>>>>> +                       num_xcc * cwsr_info->xcc_ctl_stack_sz);
>>>>> +               return -EINVAL;
>>>>> +       }
>>>>> +
>>>>> +       if (cwsr_params->cwsr_sz < (cwsr_info->xcc_cwsr_sz * 
>>>>> num_xcc)) {
>>>>> +               dev_dbg(adev->dev,
>>>>> +                       "queue cwsr size 0x%x not equal to node 
>>>>> cwsr size 0x%x\n",
>>>>> +                       cwsr_params->cwsr_sz, num_xcc * cwsr_info- 
>>>>> >xcc_cwsr_sz);
>>>>> +               return -EINVAL;
>>>>> +       }
>>
>> cwsr_params->cwsr_sz has no upper bound check.  Can this cause an
>> overflow elsewhere?
>>
> 
> We could restrict to a max limit of 2 * cwsr size required. Adding 
> David/Lancelot as well.
> 
> Thanks,
> Lijo
> 

Hi,

The CWSR size should allow room for userspace to choose the amount 
allocated for use by the debugger.  I am not sure what limit would make 
sense, as I can't really predict what will be needed in the future, but 
I really don't see how we could need more than the cwsr size (which 
itself can contain the entire state of what is running on the queue).

Best,
Lancelot.

cc Jonathan/Laurent

>> Alex
>>
>>
>> Alex
>>
>>>>> +
>>>>> +       return 0;
>>>>> +}
>>>>> +
>>>>>    void amdgpu_cwsr_free(struct amdgpu_device *adev, struct 
>>>>> amdgpu_vm *vm,
>>>>>                         struct amdgpu_cwsr_trap_obj **trap_obj)
>>>>>    {
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h b/drivers/ 
>>>>> gpu/drm/amd/amdgpu/amdgpu_cwsr.h
>>>>> index 3c80d057bbed..96b03a8ed99b 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cwsr.h
>>>>> @@ -56,6 +56,13 @@ struct amdgpu_cwsr_info {
>>>>>           uint32_t xcc_cwsr_sz;
>>>>>    };
>>>>>
>>>>> +struct amdgpu_cwsr_params {
>>>>> +       uint64_t ctx_save_area_address;
>>>>> +       /* cwsr size info */
>>>>> +       uint32_t ctl_stack_sz;
>>>>> +       uint32_t cwsr_sz;
>>>>> +};
>>>>> +
>>>>>    int amdgpu_cwsr_init(struct amdgpu_device *adev);
>>>>>    void amdgpu_cwsr_fini(struct amdgpu_device *adev);
>>>>>
>>>>> @@ -68,4 +75,8 @@ static inline bool amdgpu_cwsr_is_enabled(struct 
>>>>> amdgpu_device *adev)
>>>>>           return adev->cwsr_info != NULL;
>>>>>    }
>>>>>
>>>>> +uint32_t amdgpu_cwsr_size_needed(struct amdgpu_device *adev, int 
>>>>> num_xcc);
>>>>> +int amdgpu_cwsr_validate_params(struct amdgpu_device *adev,
>>>>> +                               struct amdgpu_cwsr_params 
>>>>> *cwsr_params,
>>>>> +                               int num_xcc);
>>>>>    #endif
>>>>> -- 
>>>>> 2.49.0
>>>>>
>>>
> 


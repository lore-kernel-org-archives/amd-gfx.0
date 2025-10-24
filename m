Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE50CCD1AB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 07:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40E1710E179;
	Fri, 24 Oct 2025 07:24:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CqHuPcf4";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012065.outbound.protection.outlook.com [52.101.43.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CAB410E179
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 07:24:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBHSO74gYFxrPXxfN2tnrQBjsnaaGez0E5TM9/eOwb0SJA19N2NbJzElZao8DAAx6rp49JMCwtp95/CkH55p9iNlLKnkgJAx+ZIe07hYfUNHrHH8pX3QnUftkRXMyPEHQ6z/zRP9RxLvUJmfEZTNiWd2nAJszew7Acy7sxBkFDesXQ63O69CJUvFT6Gj0czq88BW77RWetbThxoOSvs6M09TTMvbqdDvtWmSt4w9/yJLCAzUJysdfDIDJe0DG3rlT4MS2BAf3k0q/Vi5gcl0YpXH3s1+eZdcb80HFVqByKENMCCnrTIwoVE+RwIM1MdS6ne0DtHXYZ7phfcGoeceMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCOW/zQ0nYdiQf4jYsFl0OrEhYjXg4szOL6ZBUnD0hI=;
 b=iSRRioxWhXo+GFVo5ijcCsZLMB4x9WV1ygEhN2kYZBYLvc8Io0ziP5snL1dU3Bx/T9a60SG7uhWl+/8dJQTzcxgkGekfwyuj5pV1ZTmg4MJfmNDigcHkeNyeamnfbFwLaM1pW1WXN7FcklfSJKPJ9R96mPStD0H02v5XdUBa2btYfQQOa3TtgObIO6SfLEHOvF/EGUfqsKkHTtawMTSbl0MGSDTGkJ1C8df+ib6vx1ZypjQ8dOV0okUcR7a94x9Qekwe1PxruybSi6sbnPvUt2WRgKOPAvUjLmm7aMa8xeWS9Ux0LxnJ5pm99JqnBOuV8kE38haIK35Gs3hfac5+pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCOW/zQ0nYdiQf4jYsFl0OrEhYjXg4szOL6ZBUnD0hI=;
 b=CqHuPcf4vusa4uaActx5Zux/kDbVkEpaSxUsjsjurP08sD+spsH3ihffBwt45zTtt3KA7ygwlKb88t4UFDIJYyCfq2RhbCXsHhkngSTO0LvtdNDKToGuIL6fuRIM+VPcErqt5XCe2NC7l7q0uMMXLHEwBgSy1Gyu/UIGVZc+9EM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:24:36 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:24:36 +0000
Message-ID: <06bbce9c-f5c2-41bb-b949-4ee89c945cfd@amd.com>
Date: Fri, 24 Oct 2025 12:54:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdkfd: Fix use-after-free of HMM range in
 svm_range_validate_and_map()
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Chen, Xiaogang" <Xiaogang.Chen@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <20251022142529.247778-1-srinivasan.shanmugam@amd.com>
 <20251023143443.277108-1-srinivasan.shanmugam@amd.com>
 <415952ac-b666-43d7-a8cc-c0081c8bc911@amd.com>
 <IA0PR12MB820824CE6FA3648E5047CA2590F1A@IA0PR12MB8208.namprd12.prod.outlook.com>
 <287d072a-3603-48d3-9e00-73274fdca3ed@amd.com>
 <IA0PR12MB8208E2BBBA8D41F85A86BDA990F1A@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <IA0PR12MB8208E2BBBA8D41F85A86BDA990F1A@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0199.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::9) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|PH7PR12MB6812:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f571be5-67e0-408e-84bd-08de12ce6259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTNNdVBveTlPUWoyM0JmdnVjU3J3TG9WZ2NqbnBveGRCK2lFcnQzbWpTd3V6?=
 =?utf-8?B?bWZ2N3V3QzJkWC9BaWtSZlJ4bjZmY3NrRVJOa3VydXZFczJQR0ZPOTBUWWtN?=
 =?utf-8?B?czBnSktMaDNnNEFvMFVXLzhoUU5kWmQyRmNiRERmelJNZzJwYnBHQkdhcCtE?=
 =?utf-8?B?cHRVZjRrZTZ6cW1tclVVQW84OGhENkhsYlhYcDVFbG9HWi9zUGdPTTBYelVR?=
 =?utf-8?B?OUZIeXhQazE5ck1JZHFVUElxdXowWmFJRlBFYnJQUFFSR05GWk1EZmpJZWow?=
 =?utf-8?B?eWdhVmFSR2Zzb2lUQTVaUHJybHhLTStaTWdSRkxGcWtDcHpUVlcyV09mU2tQ?=
 =?utf-8?B?RmN4L3Q3VU80UHVNUzlNRUZaZyt0SFU3ajlGYW1jS21NSXJ0dm9UcVVRMXFZ?=
 =?utf-8?B?OHZ5dzRSRXM1NXNIeXIrSWlkRzFPMzFWOGkzbU5DTWp5S1R0ekQrcENLMDl5?=
 =?utf-8?B?NmYvY0VZYXdObVBpRUZiSFkrcE5pTkdqVFlsenZwU05qaWcvV1V5SUtxRTFC?=
 =?utf-8?B?NnV5ZUxNaXQrNkJFZm94VGhlMnV6MjVQYkZnZitWQ2NkcFZYcFpIbS9CdUds?=
 =?utf-8?B?YnozUVdJMU1IYUwxb29BSjVnRk9MbFc2WHY0Y01rT1BNRDAyMS9oQUk2bklF?=
 =?utf-8?B?TFpzeDJkQkJ4emhzbmFabnlJa3VwTGFrMEp1U3U1WDY0eHhmazFCK1pqT2Jr?=
 =?utf-8?B?RWtUdkRzamhGbUFvZkl0cmJ1NXFpYVREK3puQUQ5M3pUOVJFYS9Qc1p6emJM?=
 =?utf-8?B?U200OGo4Q3hoZmFHYzlSRmdONWRTZm5XVytOMGhQaDViRlhjR2pvVWd1R2JB?=
 =?utf-8?B?QU9uWVdJb0JHUjBrRy82S0ZJK05ITld3Ly9mZWlxU0o4NXhrdGpjU2lpbm9q?=
 =?utf-8?B?L2ZhdEJsUGhGWDhURGp3c1piTStuT2xBZU9XV2xZeG5DMFMwT3NrVHk0c2pt?=
 =?utf-8?B?bXpyZHd2SlhrNWpiWm9Fblo1S0s3Zmh4Z1I4S0NQenNoVjgzR2lodTRQY2FZ?=
 =?utf-8?B?b3NVVlMvczdZcUxlUVRFVlJDMnNuSEtCODJhQXhMRytRdHJxaWJZNzkxMGN3?=
 =?utf-8?B?WHdVRjMwRGV1R3RqS2R5YmVLSGNSVHJlZnp3SGRpZGNTbHNUWmRPYXdkZlRM?=
 =?utf-8?B?ZkZSMTV2U3BGR2hKcW1tTm9paG9UeDJOQWNGb201SHBTZC9oZzNmSEtVRkwr?=
 =?utf-8?B?MHBSNUl0NFRlV1dWcVZFM2tPOG9FZ2RRWDNnNm9INlBFQVdhOGZVclhhNnpM?=
 =?utf-8?B?WTY3bDlMcFFqYnI4dEZqaDRzeWJMWkdPSHYrU0l5T05TckRQUmhUSE5oWCtC?=
 =?utf-8?B?RGpsUlh6MWdNTk16ZjgyaXgrL2pMRE1IaWw1aHBPa0NaalpLc0ZKN2x5b2pt?=
 =?utf-8?B?enFoNElhMWdBT0JReUlGOTZaMDBveWptUWVKTGhkOXhOTU5oS2hZNEVHNk9J?=
 =?utf-8?B?Rm5ZQ3YzOHVXZGdyVTU5aXFrVkl2LzFXS1pncklhWDdpQ0lzWWV5dW1QUUpi?=
 =?utf-8?B?bm9KTE9WNkxUWWVRK0xTbVY4U3RnaGZGYUlXSUliVWVlVDl0K25BTHF0d2pu?=
 =?utf-8?B?NkZ5RkhwbEc2OWdkM2JjYVJyY1dYZFlyYXRTbk85YkNtQlZBbEJaL3QrbzlQ?=
 =?utf-8?B?Wk9JYW5pWnNzdWx1bXZyVmhlZW5lSDF5UUJXbmo1Vks2MzZZMXg5dnRmYlpk?=
 =?utf-8?B?bmJJMStZZXNKWkFXc09tVlNDRUIyWkwvdU4zS1BzTlBIeXZhNzhoRklXbXI1?=
 =?utf-8?B?ZWlseGxqN01YRUF5ZGJEY1d2bSthMnIrOGdMeGdNQzJNRlBSYXViRnpEL3E0?=
 =?utf-8?B?WFRTa2RRREhEODNibGtqd1JQZGREQW95KzkwN01Hb0MwYmN5QVY0MHIyYjJR?=
 =?utf-8?B?U0tGNjhPdkY0TFIydWlkWmhkS1FzUUFOZzdHSVlJdUxUMTZpQ3dXbityZWNN?=
 =?utf-8?B?a0d4eTV6bWREbkxaeDMxM05LSmJYanFPcXM0NUFNK2VyeVlvbmhpNHk3Zm4y?=
 =?utf-8?B?S3dkY2UrRDZlRGZnQmV6cWoxRzlXL2hia0tENFh2bmpPOXVQa2cvVHZqOVBr?=
 =?utf-8?Q?8JllCX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2NjVXB6VTVhbnlDZ21jYUxsWDR5MlE3L1FPSW4xOEhRVW1KK1ZmWHJLckI1?=
 =?utf-8?B?UG5VZjhBZ1MrK0FOdklkbVVuZ3JIRXdSUlJya3JFYUNxanpUTDJtQzUvQ2Ri?=
 =?utf-8?B?MlhuVitQclFGdDdaUU5qVmlkZzRSZ2dCRWN5Q3Fxdit1akIyOENITExqSlBh?=
 =?utf-8?B?b2swM1R3c2dhTFRiTFBocUVEYmNtQlRiYWF5Rld2QkdzcmVmdDNkeDV1aUhH?=
 =?utf-8?B?OUFyNWp1VktZV25Udk9uS2NrcWtnV05hdUE2RlQ3RUZDbjd6cGtSMENTZ3FS?=
 =?utf-8?B?VVpzL3h5bmkzS09uWEFLVS9IdGUwQmYzejZlaEk1NUZNRTB5QWZDWW1palBH?=
 =?utf-8?B?SDlTbW56dzdhcmtYeW9pNWk3S1ZTM2habHJUbDFtaDBXSDlta0RHNjE3cEpw?=
 =?utf-8?B?bmNTVE5SR0lwQ3k5N3poK0lTNG5jeExLblV2WjgwbTBoMEFENEMzdW12bXli?=
 =?utf-8?B?Y3A1ZEdkOXhpQUV5QWYvV0UxZmJURUE3T0x3MUN4dzREd3lwcWlrU05GU3Ra?=
 =?utf-8?B?ZHBUVlozYWtZRWVrU3psdkx0VUpYOE01OXhKN2VKS3h0NjRyOU5nYzV2ZDdP?=
 =?utf-8?B?YzB5TCsrTWVYcHg4T2xlajlSVVJ4M1RoaWQ0UXgzbUtKcVZERjlhTEdmV2tN?=
 =?utf-8?B?ZGJzMDZNU0hQMHQ1K0VHRFFGUjE4YkJuZ3M3b2wybHp5RHYvaVhkaGZ1YVRL?=
 =?utf-8?B?OGo3Rmc0SC83U0F0TmtmUlg5YjZtVktaYnloRWRSYjFNdk1RanVocTBSZEtK?=
 =?utf-8?B?RHJwb0FwT1NEQkRYUHhvZUloNlRVc2RRd2Z0eDJKRzVZZnM3TUI1TlB0a3Zz?=
 =?utf-8?B?bWNic1FVOExSOTlRVFlrd2wwZnlVZlZQY0lyRkpyY3BHMjlHbHZ6TzNXdk5S?=
 =?utf-8?B?eFR6eVNQNUd6OThHM2pXb1JtOGxXeFhXdVFFMnFBSVFRRVY5bFBlUE94VGRR?=
 =?utf-8?B?cnd3aVlYQXNFRVoxVnRoOW9LckNMKzBaT2NOQmROWGxjQlorU3ZnL25kZXdO?=
 =?utf-8?B?aE9yOXVkdElmSktGUmY4SHYwTDlldk1KbDdJeURSNzJEREE1cXgvcmpGOVhW?=
 =?utf-8?B?d2w5R2ZXeG5nQ1RiZDZ2YVU3UnFDYVJZcGhJM3IwOW12UHpGK2xnQVJ4MUVX?=
 =?utf-8?B?NlhvdnlBK3ZSK2lEdHRyR3FhK2wrbXV1eHlTa2VhV0xDY0VScXFqTW5yMjVV?=
 =?utf-8?B?RnlCOHBFN0h1a2F4N3hCQzRBenBsRFpFQURNa09IeE5mRXBsM1BCd3RyOFdx?=
 =?utf-8?B?S0h4VUlmUStwdUdVZUVKQnBWQ1hyZnlpVWdGWVFFMGp0SGRiRXBBeDFCanJ0?=
 =?utf-8?B?SDVNb3pYbjFaUXlGbmNoK2huN2pSUlJtbG9GemRoTXg5UUN1UzE2NFpjanJn?=
 =?utf-8?B?VnY4aVl4a0ZGQjFxYmZQa3YzOUNGcDUrd2NoSndlaGhtY3NjZlhvY3EwejM3?=
 =?utf-8?B?ZW1ZUHkyUVlUTitTR3lyTTAyZ1Q0MWVGVDdEN0d3QjhhTnNDYVc2T2hzZE9K?=
 =?utf-8?B?MWtBZ3NENzQvMnZBRW12QktyYXZuWHVFbDNIWHJSalJ6WlhtRTh4dlpaa3Nm?=
 =?utf-8?B?YjBIc2Y0bnB0K1RTOFlOQ0NkTHBNNTArWm1IUmFpYTh4VjRXeEtCWWdtbk9l?=
 =?utf-8?B?TFpOTUZqeGZWVTFBRWl6VDF4dG5LbkovRW9UTjVCcXJGRWpYVjZtbFdHSStj?=
 =?utf-8?B?aWpGRHBCQkYxYlZhVzduYkJ3d3JKSmFma3JubnZhL0JZSDR5R09tNmFwOUYz?=
 =?utf-8?B?b2RQL1Y2RjExVjlrTmxMS2RtT0IxVHNkWUZ0SksyYW9tZGplSjJzZnJyZWpO?=
 =?utf-8?B?TmsxN1puYzJYMXV2b2hYZW5BWDU5MHZhSEpzdzlFYlJTdnR5c0VsNzY4cDUv?=
 =?utf-8?B?TnBZTzNlQk9uWEVraTFnWXo4cnVTazJVNUZ6dHdjNkxpOEgrSTdJR04zT1lF?=
 =?utf-8?B?cW05ZnM0aWNWQkdpb2o2cHg5UDBUQXMyeEo4VHZqQkozMkt5Y2RxbnlnYVAy?=
 =?utf-8?B?TVdjdU1xS0NpMkszRHd4Ri9XbVhuU2dIOUZHUUw0ZUJ1ZExQbzRjVVhnMUhx?=
 =?utf-8?B?a3pUZnN1aGFOQXpsQnZNRzlnK2E3d0svZk9MeVE4R0lzdG5EaWZrazMzbjdN?=
 =?utf-8?Q?SW1jWDgpj9bjC7WrXYFvWo/Aj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f571be5-67e0-408e-84bd-08de12ce6259
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:24:35.9514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzldIiSAInb0TIssdbO3AyHG0LuE/4ugdQ/xHGh1Zs1zA8ebrBnxhaIZNJ2vwZMt+OETZij/bd2ZN5affkKxHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6812
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


On 24-10-2025 11:44 am, SHANMUGAM, SRINIVASAN wrote:
> [Public]
>
>> -----Original Message-----
>> From: Khatri, Sunil <Sunil.Khatri@amd.com>
>> Sent: Friday, October 24, 2025 10:10 AM
>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Chen, Xiaogang <Xiaogang.Chen@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Yang, Philip <Philip.Yang@amd.com>; Khatri,
>> Sunil <Sunil.Khatri@amd.com>
>> Subject: Re: [PATCH v3] drm/amdkfd: Fix use-after-free of HMM range in
>> svm_range_validate_and_map()
>>
>>
>> On 24-10-2025 09:20 am, SHANMUGAM, SRINIVASAN wrote:
>>> [Public]
>>>
>>>> -----Original Message-----
>>>> From: Chen, Xiaogang <Xiaogang.Chen@amd.com>
>>>> Sent: Friday, October 24, 2025 3:15 AM
>>>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Koenig,
>>>> Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>>>> <Alexander.Deucher@amd.com>
>>>> Cc: amd-gfx@lists.freedesktop.org; Yang, Philip
>>>> <Philip.Yang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
>>>> Subject: Re: [PATCH v3] drm/amdkfd: Fix use-after-free of HMM range
>>>> in
>>>> svm_range_validate_and_map()
>>>>
>>>>
>>>> On 10/23/2025 9:34 AM, Srinivasan Shanmugam wrote:
>>>>> The function svm_range_validate_and_map() was freeing `range` when
>>>>> amdgpu_hmm_range_get_pages() failed. But later, the code still used
>>>>> the same `range` pointer and freed it again. This could cause a
>>>>> use-after-free and double-free issue.
>>>>>
>>>>> The fix sets `range = NULL` right after it is freed and checks for
>>>>> `range` before using or freeing it again.
>>>>>
>>>>> v2: Removed duplicate !r check in the condition for clarity.
>>>>>
>>>>> v3: In amdgpu_hmm_range_get_pages(), when hmm_range_fault() fails,
>>>>> we
>>>>> kvfree(pfns) but leave the pointer in hmm_range->hmm_pfns still
>>>>> pointing to freed memory. The caller (or
>>>>> amdgpu_hmm_range_free(range)) may try to free
>>>>> range->hmm_range.hmm_pfns again, causing a double free, Setting
>>>>> hmm_range->hmm_pfns = NULL immediately after
>>>>> kvfree(pfns) prevents both double free. (Philip)
>>>> what you fix is not "use-after-free", it is preventing double free, right?
>>>>> In svm_range_validate_and_map(), When r == 0, it means success →
>>>>> range is not NULL.  When r != 0, it means failure → already made range =
>> NULL.
>>>>> So checking both (!r && range) is unnecessary because the moment r
>>>>> == 0, we automatically know range exists and is safe to use.
>>>>> (Philip)
>>>>>
>>>>> Fixes: c5e357c924e5 ("drm/amdgpu: update the functions to use amdgpu
>>>>> version of hmm") Reported by: Dan Carpenter
>>>>> <dan.carpenter@linaro.org>
>>>>> Cc: Philip Yang <Philip.Yang@amd.com>
>>>>> Cc: Sunil Khatri <sunil.khatri@amd.com>
>>>>> Cc: Christian König <christian.koenig@amd.com>
>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 1 +
>>>>>     drivers/gpu/drm/amd/amdkfd/kfd_svm.c    | 6 ++++--
>>>>>     2 files changed, 5 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>> index d6f903a2d573..90d26d820bac 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>>> @@ -221,6 +221,7 @@ int amdgpu_hmm_range_get_pages(struct
>>>>> mmu_interval_notifier *notifier,
>>>>>
>>>>>     out_free_pfns:
>>>>>       kvfree(pfns);
>>>>> +   hmm_range->hmm_pfns = NULL;
>> hmm_range->hmm_pfns isnt set till a goto out_free_pfns is called, hence not
>> needed.
> Why?
>
> pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
> hmm_range->hmm_pfns = pfns;

Sorry i missed it being set in beginning as i see it being set in the 
end . Not sure if we need to set it two times, check that once if its 
needed again, i guess the second time setting it isnt needed.

Regards
Sunil Khatri

>
> for example, hmm_range_fault() fails), the code goes to the error path:
>
> out_free_pfns:
>      kvfree(pfns);   // free the buffer
>
> But after freeing, the pointer hmm_range->hmm_pfns is still pointing to the same (now freed) memory.
> It’s a “dangling pointer” — it points to memory that no longer belongs to us.
>
> Best,
> Srini
>
>>>>>     out_free_range:
>>>>>       if (r == -EBUSY)
>>>>>               r = -EAGAIN;
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> index f041643308ca..103acb925c2b 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>>>> @@ -1744,6 +1744,7 @@ static int svm_range_validate_and_map(struct
>>>> mm_struct *mm,
>>>>>                       WRITE_ONCE(p->svms.faulting_task, NULL);
>>>>>                       if (r) {
>>>>>                               amdgpu_hmm_range_free(range);
>>>>> +                           range = NULL;
>> Range is a local pointer and if it has been freed it should not be used again in same
>> function. The error condition should handle that.
>>>>>                               pr_debug("failed %d to get svm range pages\n", r);
>>>>>                       }
>>>>>               } else {
>>>>> @@ -1761,7 +1762,7 @@ static int svm_range_validate_and_map(struct
>>>> mm_struct *mm,
>>>>>               svm_range_lock(prange);
>>>>>
>>>>>               /* Free backing memory of hmm_range if it was initialized
>>>>> -            * Overrride return value to TRY AGAIN only if prior returns
>>>>> +            * Override return value to TRY AGAIN only if prior
>>>>> + returns
>>>>>                * were successful
>>>>>                */
>>>>>               if (range && !amdgpu_hmm_range_valid(range) && !r) { @@
>>>>> -1769,7
>>>>> +1770,8 @@ static int svm_range_validate_and_map(struct mm_struct
>>>>> +*mm,
>>>>>                       r = -EAGAIN;
>>>>>               }
>>>>>               /* Free the hmm range */
>>>>> -           amdgpu_hmm_range_free(range);
>> I guess we are setting up the error and that should be the criterion to call this
>> function. If there is already an error condition before we should not be calling this
>> again.
>>
>> regards
>> Sunil khatri
>>
>>>>> +           if (range)
>>>> Can just check if(!r) here and remove "range=NULL" above? if r is not
>>>> 0 range has been freed, if r is 0 free range here.
>>> But there are later spots where r becomes non-zero after get_pages() succeeded
>> and range is valid:
>>> svm_range_dma_map(...) can fail → sets r != 0.
>>> !amdgpu_hmm_range_valid(range) → you set r = -EAGAIN.
>>> !list_empty(&prange->child_list) → you set r = -EAGAIN.
>>> In all three cases, your new tail logic if (!r) amdgpu_hmm_range_free(range);
>> skips freeing because r != 0 now. Since you also removed range = NULL; after the
>> early free, nothing else frees it → memory leak.
>>> Regards,
>>> Srini
>>>
>>>> Regards
>>>>
>>>> Xiaogang
>>>>
>>>>> +                   amdgpu_hmm_range_free(range);
>>>>>
>>>>>
>>>>>               if (!r && !list_empty(&prange->child_list)) {

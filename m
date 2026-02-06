Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EF6EE2082
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 10:21:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B04710E00B;
	Fri,  6 Feb 2026 10:21:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="femEbyYr";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010065.outbound.protection.outlook.com
 [52.101.193.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17B7310E00B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 10:21:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSxFZxzIdGa6vzGsS9SsetRRBi8vZAxTYeOkJtMX2fF3BdrVRlbhK6bH/u39S+lB1eMC5GPSU+uJMySRyL7TC0ofl9w6+6QcmbjbcfmZ/+rE6S6kay5ZXA7SMHTis/PCJsZyWX2ixQOorGja1o6HFY1BOv1WKrmoAlSKuW0PK+v9Ul/Ija16HzaXvLUBgGK0HFuhUYDUz8llAAq4ktgryoSep8pubEa8h2WWl6gfimfGBr7jgar5eyDdGKSDg/Pe2BZdeuO0Ps3zbCCbDNvzLDMF21SOYNL/EuQXaa7psJBwfm9YHsk5jyOYZyaYDA8kG209FYLUXF4CkKwJKeGQHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9Eb3uE1xqPrrWIkflM2vP0uC69iwXgC8qSbvz6Ke6U=;
 b=KlOxH7lNsgB4YXFunvHU40aQFCvehCpz/gLIsUmk7SlljaBuEwYlEmknwYcOZ4jgU5njqyEYCLNnQEEAN//6ZBihijxz7THyTVzTEwOvY9rr1j+bZJMWH8PSzfHvsNNISA3Xg+Kotj/DRmwsC7hjEROxlP5zcO6N0rboCH9KxIPYC2yvUkByJTMHJmQSjLqrea5s2YAKmkfPab/RyeWXTpa5EIcTNhUwlL2Wr+P7Zy6FBu42/+dNQZHVucENI+2X6pUor03/s3JnCbCvsgSeoRX7FNdLxzqNFMJrnhZswZrX6gQRURTkxZYlBBG7Lri4rzzl+t+OeKY/2buK3ytpNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9Eb3uE1xqPrrWIkflM2vP0uC69iwXgC8qSbvz6Ke6U=;
 b=femEbyYr1cABiJWwZqFhOIbSPUpM+5hSUEELut1RrqLyM6qrk4I5hXTkvR+9lC4auMgAthquLJPRyobOfr4wGqVHiDIA9h48BIywRbS+VZwq1Y9ws8e1r0CZWkWhP9MlYvvpjS70QrMQV4nE/695Q2XMjOTKOn/etSvfwN1Q4M4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 10:21:49 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 10:21:47 +0000
Message-ID: <7b1af6c8-bf43-42e9-8ca5-37a12927dc18@amd.com>
Date: Fri, 6 Feb 2026 15:51:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] drm/amdgpu: lock both VM and BO in
 amdgpu_gem_object_open
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260202125149.2067-1-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260202125149.2067-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::8) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA0PPF9A76BB3A6:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf50e79-8a03-403b-a742-08de656988ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHlYQmc4Z2U5WlVsQXNIa2RkSGc3N0liNFVQYlBnQ2h1TVR2eU1LaC9QNEhS?=
 =?utf-8?B?R08zYnBEL0tKWE5GZGJZMFZKVEtqMzJtTVVyRHVmOWFsUmRRMVJaMEpBdi96?=
 =?utf-8?B?NW9lL1pFSkhvclhGdnFIYXZTV3Q3dktPRERhSW9YZ2hWZEJOMUc2Sjk3eDBr?=
 =?utf-8?B?ZTdxUDUrVXBQNUtDZEpxbXo3bml6NEZvRmMrK0NJeEhBempOdFZMRFBYeVox?=
 =?utf-8?B?aEhuRWkxZnlvVHNLNlg0TnBSR3I4Q1FQcGJ3RVZOSEN2OUQ4YkRmQkhwcUdT?=
 =?utf-8?B?ZXVFRGtoVGRpVTJmbGNzaXd5dGJQN2drUzg4WmgzUVB6ekZwdEovOVpvaVRJ?=
 =?utf-8?B?KzF4amNORXI2c0dHeW9kRTFrcGdBbnJOVXBJdEtYWURoMGoyRHU4czdZSmI5?=
 =?utf-8?B?ODczSkgyRDFjMlZjVUsyWm10SFRPSkE3LzNVWEpjMU9zNHhYREJSYjlGRWZ2?=
 =?utf-8?B?S0JIejh1aHlkVzBKT1kvUVprTFNtZUZ0ODM1Z3p2eWRsYzlDTWN1SDdJeFg1?=
 =?utf-8?B?TXkxdlBVa3poQk5FVFNPV2pNNEp3dXlmYkpIdWxVSVY4QmxjTXRnUU50N1pu?=
 =?utf-8?B?TzZEUHVEQjlmblVCRWFSSkNtU3VSRURaRXUyVFM2bklaNGUxNWZOOThmZ2xO?=
 =?utf-8?B?WnpXNkVncEgyN1BMdGJZb05KT2xvV1dqL2RMZXRlcmowZ3dsVlNZak5GVzhI?=
 =?utf-8?B?Ri85d2VZNHZETVNQMW9hVjB3UUdYT0dVTEdMaCtlU0lOcEdlczd5YUMzWnJY?=
 =?utf-8?B?VCtNc1VkWWN6SFBTOW40TEFZM3Zwdzh3RXNEWDFzb1l2MlVDU1A4NHRLcHhz?=
 =?utf-8?B?MGpzVUhYWnJ6ekMyaDdubG9WZ3dRZE1qVDFPNjFXb05FMnowdjZsczZSUFNh?=
 =?utf-8?B?TER3NXRmaXdWYTBqdW82d25nL0Zlb3NMUGdjeFdRY0hhN2s3ODBEaGFGYS9B?=
 =?utf-8?B?bjhkeFd6NndnT0N1ek5JQXdGUGoreVZ5czMxNkdyK0tZL1ZCKzZFZStPUWNF?=
 =?utf-8?B?QVZFT29RNXgwV3RERXBTVTAxd3VvbTRaQXphakY5aGNCZEgzbEEyRm1OdHBa?=
 =?utf-8?B?emo2YkVWRDloSWxSYkxOay9yN1c5QVZIalV5MVIvd1dzdlhoOVhwK2RUZGdZ?=
 =?utf-8?B?M1pLbVdUYUdUeFhjRXlZZEt5ZzlYbzZLb0JBN0xqOWdVYXZ3N2Nwb0g5RjlQ?=
 =?utf-8?B?TXZFa1dGdTFzL2NNZnIrajM2Y2RvR21zanRWSmN2RmJvVGhDblhPZmVTQTZ1?=
 =?utf-8?B?TjJ3bzZ6VE10b1FHNlNvbE5lVSs5L1FyYzIyb0pzU0hNSWtPeldKczQ5dklE?=
 =?utf-8?B?WDJ1bEp6dG00L3YrdlBmM3F4YWlGZkJVNjFIUGlxMTlXK2NnZFRIOEFVT252?=
 =?utf-8?B?T0JZbVdyb1BwdlVSU0lPZ1IzM3dNeWxsQStleVRvdkNwS3c5ZUdzTGF4QS9N?=
 =?utf-8?B?MUcvdW11bXpUMTYwdzhYUWpOUTZ3azF6bjhFa0U5b0ZjdnZKRVhNY3EvUm1V?=
 =?utf-8?B?YjUxVy90V3FySm42bHZMcm5MczNjYk42cmtacjZBc0p1VUdwcVczMkJGbW9Y?=
 =?utf-8?B?WUF3eTRRbDlpTFJYdW9RNTg0TytXUEZJOHdLRlU0Wkh4b04yUUhLdTBkb3M1?=
 =?utf-8?B?VzhtUHNkclhYVHZBK2ZJQ1RJRDB1WUtSaTY3WmJJSUk1cUdtUjJSMWVUWHZR?=
 =?utf-8?B?dExTOU5WZEI2cnpDTU9JdklPQXV4T2lmcVE5ZDh3TlRGZkdJcnRiN0pSWWZh?=
 =?utf-8?B?YWgzZ1pXWGtzR1hlWFdMTEJTMDRIOWRxektlYlBDT3lZWHBCS3ppOXlFV3dr?=
 =?utf-8?B?VTBnL01FYXplRDhHZUhWRDdJN3U3eGM1Nzl5Z1NwdHJBRUl0SUVXaG5mLzhW?=
 =?utf-8?B?Y284MW1PMWpKR1pRS1oxVDE5SXdLdEVJRXZRekJGNG52ck1GblhYaWFXSkIz?=
 =?utf-8?B?N2VUR3V4WG12MDNTTHJmeURyc2s5K0R0L0pnMFNLZDE4WkRSNWx0WWhoZVNp?=
 =?utf-8?B?RXpyUUdtUERTSXFGRk1yRVd0enpocngvRklPeEJ1eEdGMzgvTFRyenJjNHpM?=
 =?utf-8?B?SnBpbnp3Unl0UlFqTWRVblVXNTJRTzZ2OFVjUE83MnEvOW1VQXF0K3o1MVNl?=
 =?utf-8?Q?IYao=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkZGRmM5dVgxTHdBVDlWWnV3ZmVDLzlNRmVDbk9DYTlYTkdhL3FWTEFicUp5?=
 =?utf-8?B?VFpRa2JaR0N0NUpzTVhWRXcxOXJEdjd2R0VQdmk1R0JwbVRmdmFTamFOcG42?=
 =?utf-8?B?UDI3cVROc2htMk92YmVjeEc5MkVCRFZYSzcrQkIwd3d3N0M4QUdyclcyWVdY?=
 =?utf-8?B?dWJ2cHdwT283RExlSHErVXR5Y1BHT0NwL3pIbWgrVnh3RnV6MXJUek1oeG91?=
 =?utf-8?B?ZVBvMkdLUHI2dlFqcTVqUjlqWEZHQUM0a0tlZFdIaExNV3ExcjVCUG1YSlZ6?=
 =?utf-8?B?dnZiVHRZZlY1Z3JxQnllVlM3bmdCMVB0TFN0cEtEdktVOXVnZ2t3R21vZ0I5?=
 =?utf-8?B?b0NHSDJnak1sekdQcExiVnhVbXZ2d0J1SWJUUzdZMHk1dzZEUW5WTGNPK1FK?=
 =?utf-8?B?NHhLS1Q0dFBUTzFVYVJzOTdhdXVNVjhyZWNwc00yL1E1QlFCNllvbU8raVQx?=
 =?utf-8?B?NWR6NkNDWXgrQWhEelVSL09hNjc4OTY0QlZiRGZQbUpUUnhkTEJlWmIzY1Zm?=
 =?utf-8?B?ZkNtWDhOcDIyK1h3QjRIanlBb0V3RXJjalhsUVhVNm56cWZueGNKS1ZRYlJz?=
 =?utf-8?B?S0p0M3gxbFViOE8zMmRwa2xhYUg5NmVmOXNvUlBGMkZTSmtMRmsxcWRYZUw3?=
 =?utf-8?B?ZTJ3OUZFZHA3ZnJHaXl4QXZDZmk3M0ZteXBHK05WdGFYNFdvOTR2dzM0RVpM?=
 =?utf-8?B?NWY0dm1UcHBqRzUzQkJSeUQvRk5QMjJTNk1sVG1NeFdEL1pXOURJcE56Ukll?=
 =?utf-8?B?MUdRMUQxVFMzZElpWXlJb1Rlc3ZPZ1k3a2YrclpIcFFMV0FqQXR3Y0lZLzh0?=
 =?utf-8?B?RkZTd00za09WdWM1b1piRnVKTnpwcDNKdjl2ZzVjL0xYSkFYS0FVVG90LzFE?=
 =?utf-8?B?eEpoUk9yaWZ2cFBaUE1SL243cFdidk4wUVJYNkZ0SXJtbjV0WWpFR0NyUjR3?=
 =?utf-8?B?OERKNzZKOWcwcUlYZENpaFJZbENoQnpyVkhNM29oZ1BCYU9ZemJ4TGZobDRK?=
 =?utf-8?B?Q0hKZ1orNXlnb1p6SzF6MzdFL0JjYUhuREJJR1dHSGJZcTBFSU9xY0hwWk5r?=
 =?utf-8?B?OStERXVoVTEybjFtSUx3U056TkVlSHBuUHBlczAwallaRVhwZ2pqeVlwT0dM?=
 =?utf-8?B?NWRTb1ZBdmtOaTJiQ1M1SUpHWE1zeTRROFpkbm5ldFplbnluVEdnTENvenBx?=
 =?utf-8?B?b1Vwak9zSnU4Z1oyWFI0U0xkZ1JuQnNVdXM1RTdOOC9mQlRBS0xOUlN3RkdX?=
 =?utf-8?B?NFRFTHVNN3pxaCtSS2t2dGhUR0F4S1lJSDUrU2M3bUhSRmhYQjVaZG1QNG1N?=
 =?utf-8?B?Zi9CWWNVKzJkNHM5d2tnbzBUWXRhWnlRaTRVUTRkMTdzUEdOdDh6b1h2Y01t?=
 =?utf-8?B?RzNvU29RSjJHRVp1VGhBRjBGOW16RW1kbFpRQUkzei85YmFZQ0dZS1JMQ2t6?=
 =?utf-8?B?QjlLd05UQVZ3V0wwVXFyYUtiZmNlcE93UGlNcWtIejlqQXlLdk9IdnRHU1BV?=
 =?utf-8?B?dHdOZ25adVFRR0gybGxLbWR6V1o5LzFrTEY0K3NMY3FOVkJFZnExMmNzcHVK?=
 =?utf-8?B?WmljcDB2Tkl1dUFUMGJNZTlKNEpoSi82Uk5pK016Nk4zRGlUR0RDT1owb0p6?=
 =?utf-8?B?cE1aODE3Z2Q5ajI4ZUtPNWw4V1ZSMkxCN0FsUzh5eHg4Z3V4WnM0UFlDWGJQ?=
 =?utf-8?B?d05MYUtUaVFnZGh3VXhXcmVMdVNVdzd4bGEzVytRQ3UyZEV3aFY1RzZ3U01K?=
 =?utf-8?B?R3RVaklvWmdzei9GaWJVbWpMcGhVRFlKYWc1NUtINXhrYmxPQVhnSjc1b01V?=
 =?utf-8?B?N2JwK080ckJNMWRvK0VwLy9BK1dXODNJRVoyZFpFQjUxQmVWQjRrbExkQ2Fk?=
 =?utf-8?B?cFNDSUNOaFloQjFtNHhDY0JKRjV6NFk3a1NmdnQzMWNSTkcybFdaZEtTSG5J?=
 =?utf-8?B?SDVXMXkvaE92RGZSMFpaZk9MZkxvUkxzUldqb09aYXFGZ1RLODJwTE1qa2tI?=
 =?utf-8?B?QUdma1VqemFuT1FnRFFZRitJS0JKK000Qmdlb3VjTVA4RWU3cTZEWVJNM2V4?=
 =?utf-8?B?TEY0SUhFWVVTMk5yVllUb3ZxNjMrd2FReUVJaS9hUEtQMXpzZHBKbHJ0QW5M?=
 =?utf-8?B?eGhUQVcyc1hTOXVpd2dncEE5UUlFUmR0NTl4N0EzS05WK0hJSC9lYmlMVUY3?=
 =?utf-8?B?OXYwdHV1a2crSmI4NFk2UG9aeFpqbFhQaWcxT1J0UWlLUUxmbEpPV3dlVnlm?=
 =?utf-8?B?Qmc5anhQMStxTVA3QWhQZ2RKNTlIeFFKTStubFJ3Ymd0YjUrM2Q1WDArQUFO?=
 =?utf-8?B?VkE0THZscWJzMFYySENPOGM1RVE5RnIxa2hvaWJqdEEwSWViQW1tdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf50e79-8a03-403b-a742-08de656988ad
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 10:21:47.8134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+hk+DgPGJzba0CqWv91wxrJRooU9CR8XPQ+QrZbOsGCkw8VmL+iTgN4yyZFSU9FvoLbUJsldWWh9G5iWY3ZBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF9A76BB3A6
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


On 02-02-2026 06:21 pm, Christian König wrote:
> The VM was not locked in the past since we initially only cleared the
> linked list element and not added it to any VM state.
>
> But this has changed quite some time ago, we just never realized this
> problem because the VM state lock was masking it.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 19 +++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 22 ++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       | 10 +++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  2 ++
>   4 files changed, 42 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 768998c82b43..ec5130497743 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -878,6 +878,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   	struct amdgpu_bo *bo[2] = {NULL, NULL};
>   	struct amdgpu_bo_va *bo_va;
>   	bool same_hive = false;
> +	struct drm_exec exec;
>   	int i, ret;
>   
>   	if (!va) {
> @@ -958,19 +959,25 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
>   			goto unwind;
>   		}
>   
> -		/* Add BO to VM internal data structures */
> -		ret = amdgpu_bo_reserve(bo[i], false);
> -		if (ret) {
> -			pr_debug("Unable to reserve BO during memory attach");
> -			goto unwind;
> +		drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
> +		drm_exec_until_all_locked(&exec) {
> +			ret = amdgpu_vm_lock_pd(vm, &exec, 0);
> +			drm_exec_retry_on_contention(&exec);
> +			if (unlikely(ret))
> +				goto unwind;
> +			ret = drm_exec_lock_obj(&exec, &bo[i]->tbo.base);
> +			drm_exec_retry_on_contention(&exec);
> +			if (unlikely(ret))
> +				goto unwind;
>   		}
> +
>   		bo_va = amdgpu_vm_bo_find(vm, bo[i]);
>   		if (!bo_va)
>   			bo_va = amdgpu_vm_bo_add(adev, vm, bo[i]);
>   		else
>   			++bo_va->ref_count;
>   		attachment[i]->bo_va = bo_va;
> -		amdgpu_bo_unreserve(bo[i]);
> +		drm_exec_fini(&exec);
>   		if (unlikely(!attachment[i]->bo_va)) {
>   			ret = -ENOMEM;
>   			pr_err("Failed to add BO object to VM. ret == %d\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 5f9fa2140f09..5c90de58cc28 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -232,6 +232,7 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>   	struct amdgpu_vm *vm = &fpriv->vm;
>   	struct amdgpu_bo_va *bo_va;
>   	struct mm_struct *mm;
> +	struct drm_exec exec;
>   	int r;
>   
>   	mm = amdgpu_ttm_tt_get_usermm(abo->tbo.ttm);
> @@ -242,9 +243,18 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>   	    !amdgpu_vm_is_bo_always_valid(vm, abo))
>   		return -EPERM;
>   
> -	r = amdgpu_bo_reserve(abo, false);
> -	if (r)
> -		return r;
> +	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
> +	drm_exec_until_all_locked(&exec) {
> +		r = drm_exec_prepare_obj(&exec, &abo->tbo.base, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(r))
> +			goto out_unlock;
> +
> +		r = amdgpu_vm_lock_pd(vm, &exec, 0);
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(r))
> +			goto out_unlock;
> +	}
>   
>   	amdgpu_vm_bo_update_shared(abo);
>   	bo_va = amdgpu_vm_bo_find(vm, abo);
> @@ -260,8 +270,7 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>   		amdgpu_bo_unreserve(abo);
>   		return r;
>   	}
> -
> -	amdgpu_bo_unreserve(abo);
> +	drm_exec_fini(&exec);
>   
>   	/* Validate and add eviction fence to DMABuf imports with dynamic
>   	 * attachment in compute VMs. Re-validation will be done by
> @@ -294,7 +303,10 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>   		}
>   	}
>   	mutex_unlock(&vm->process_info->lock);
> +	return r;
>   
> +out_unlock:
> +	drm_exec_fini(&exec);
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 1878e0faa722..f69332eed051 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1445,6 +1445,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>   {
>   	struct amdgpu_device *adev = drm_to_adev(dev);
>   	struct amdgpu_fpriv *fpriv;
> +	struct drm_exec exec;
>   	int r, pasid;
>   
>   	/* Ensure IB tests are run on ring */
> @@ -1484,7 +1485,16 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>   	if (r)
>   		goto error_pasid;
>   
> +	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
> +	drm_exec_until_all_locked(&exec) {
> +		r = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 0);
Do we really need to do this here? We are in the process of creating a 
new VM and new PD so at this time, no one would be able to use the VM 
and PD till it returns from the function.

Looking at it with that understanding it feels we should be fine without 
locking the pd here

Regards
Sunil Khatri

> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(r))
> +			goto error_vm;
> +	}
> +
>   	fpriv->prt_va = amdgpu_vm_bo_add(adev, &fpriv->vm, NULL);
> +	drm_exec_fini(&exec);
>   	if (!fpriv->prt_va) {
>   		r = -ENOMEM;
>   		goto error_vm;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 6a2ea200d90c..b4bf1b7c214f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1735,6 +1735,8 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_bo_va *bo_va;
>   
> +	amdgpu_vm_assert_locked(vm);
> +
>   	bo_va = kzalloc(sizeof(struct amdgpu_bo_va), GFP_KERNEL);
>   	if (bo_va == NULL) {
>   		return NULL;

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2A7D2F000
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 11:47:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19BB810E084;
	Tue, 27 Jan 2026 11:47:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="plKYaGvD";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010019.outbound.protection.outlook.com [52.101.61.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06EE110E084
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 11:47:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQxWBlTV3zF3MCGBC6NeVi+wY+lUsPHBpRjdy6BcJ1ThrvPvvLOO2RvkB6ybMOq6QlqSObjipbxkWPQdrsC/xVkDuJiK2WqvTuSbilEDJ64gM9/4twDYeHCBSYprI4iRwcJtSbZ56Exhki+8k54u/6pae7MaXHncSAkW+UHxAWwowBqEjO1jwcRQTTnLD7/zHGg3F+xdPgRicvE0Buc0IlyI9Sttfn8aUH2wSjzhxLV6zRuiUrvo3cPW8LBDVxNWomA7aH8TzpVVJlNHgtU1iRd3Ma4/+lRzQe+IxFG9oCC2t7W0y8dByw5kaZXw+vxhuNNrKSkFEBpE3BpV5mU42w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mczo9jlNtYjnEYR8SsNpjL+dFbA305OWdlbYNAbQ3kc=;
 b=owLLXCubKeeYk2ERHBh8MHTtggD3Pw7vxae3+Ve5lDv32rQUQBONMhdQStvZGPEZAp3vb0CVQViZllbe49UtvPCYRzzgNaUqpyIfrfRfEfZRe12U/C3BKaJIzRnkAUyDqC1WCt4wmpzGYk+bXu3SVi0ZJSAvcchdyB/asATywIEbbOhSif6RTC6tjwcbdfPLIPd010ynbGbmn2ZhQJZo0dYgoUi4NCXFE2lRQKrfsgKbN3+3lorAKl8zr4Ycw9DPSU8/603DoG9S8gfNcAExTlqrd1zBM3LyIRPAB4oWARf+RoYTQNuB+XnGLv3Hgb7OKUF9ffoslETlHgw8U1z+BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mczo9jlNtYjnEYR8SsNpjL+dFbA305OWdlbYNAbQ3kc=;
 b=plKYaGvD57F5Gl8oBZG73GVgyE9Mb1s38C0GG6Hq9uBe+FdATOUkF6XKfV+a4JIy3brmtdy6GYf27f3xmjbioe2Zp7mEbZeFvu8dMmq9QXPDAn3aFPHI/DLP5UixGcJJ3kD1Vlh21uk/27yc1Sf0pIaWKZzjxO2GmGJY6K9XaTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6668.namprd12.prod.outlook.com (2603:10b6:510:1aa::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 11:47:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9542.009; Tue, 27 Jan 2026
 11:47:34 +0000
Message-ID: <547a73eb-edca-40c3-a22b-8403dba49a30@amd.com>
Date: Tue, 27 Jan 2026 12:47:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Avoid redundant allocate/free when reusing a
 bo_list handle
To: "Wang, Beyond" <Wang.Beyond@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Jin, Jason(Yong)" <JasonYong.Jin@amd.com>
References: <SJ0PR12MB69035C332189D35E4D5A81C6F797A@SJ0PR12MB6903.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SJ0PR12MB69035C332189D35E4D5A81C6F797A@SJ0PR12MB6903.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0420.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: de08f691-4d1e-4cef-1a3b-08de5d99dc99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NklacmdNTVBhekFSeHNTNDlzOTV1WjZNYXg5aVo1MllnaWpTd0ZETWVReDM3?=
 =?utf-8?B?ZFdqSlNnN2Y4VXJYclZCVE56TmpPaXZ1cGpkOTJGKzN6WXFCY0V4UjFBd1VT?=
 =?utf-8?B?Z2wyOXZZangveVdUVHFBTUpjUkhOWFc5T0sxSTcyc2hIeUZwUWN4MFVXaUh6?=
 =?utf-8?B?UGRXK1dOd1UyN1RXb3dnWllvSDJPS2JXc2NlRWFGbXZyMmk1ZDRhVjU4VG5W?=
 =?utf-8?B?NGo2Zlkvd1RmT0oyQmpuNnM4eGJMTzFOd1FTR3o5QnEySThEM0ZDZVZNVkdy?=
 =?utf-8?B?Qjc4TmJQM2NxTHdqTnNCYVpJSmxRS2cwT2RCVi9kbnhnU2NWc1paNDVPeUZP?=
 =?utf-8?B?eVd6emN0YTArSGpnOXk1OHNEVEp5Z1VLczJGcGRsQlE1cmRualBFWWE3aGpU?=
 =?utf-8?B?U1dCMUhHSVUvZCswL0l1WlpTY09FMjg4Unk4bEcvYlN4Q0JYQ0pYN1VpeENZ?=
 =?utf-8?B?eXBHYnNSTUtxYzZ2bE5Sam9Kb1Y5dmJJaHQxTWxDVkFrdThUbVhDM2N3dWQ0?=
 =?utf-8?B?UzRLbkh2VHBzcDBLaENWblN6OXpzWVd5aXkzdHpBYTcrajRMK0RLOHlyZTNa?=
 =?utf-8?B?aFk1Y3FyWU5FSVB6RTRjVHJTaEdjL2Z5ZUFUbmo4N3JqdGZOVGJEQnM0RTla?=
 =?utf-8?B?SllSYnlCZHZBLzRIUVVZeUVWMmRub2c4M2JWRTZBT3Zia2EyQ1QvTmI3SkZr?=
 =?utf-8?B?VEVpWGdPdzk4eUxSQUR0bVgvOWp5Y3pyL3c4Zlk5UXlNekNiRndmbTFNSTFI?=
 =?utf-8?B?Y2VNOVVnNDBGTU1KajFQbFpqRnpNQlVkeXlJNVJQLzNPdTR2eEtwL29lS0Nm?=
 =?utf-8?B?NkFBVDhESFZ6azFYYmxVSm51VUtRSys2VGlrWHJnUGZNQnNPRHdQdTNPZTlS?=
 =?utf-8?B?R3p4TjJCVlYxU0kzcDc0T2hMZVJSTEVxcS83TjArb3JLUUF2TGZmSkVCUEtX?=
 =?utf-8?B?VWY1SnVwSjVwNDRSVUhMNG1PdHdvZVZVM0tZaEt6TTByOExKQm9HUTdIT25C?=
 =?utf-8?B?OUl0K0o1cjZ0YW1KRW52RXRteURDVUJZeDB1MWpCSHBqd2MxUlpBZFl4eDMz?=
 =?utf-8?B?M2hnSWJRSjRUWFNOeGU0Mmh0YU9WcGtrdFlnYnAzT2RNVmZvUTVYT3RsaHBI?=
 =?utf-8?B?RUZ5eHNnWFAwNG93MWNrczRMV2E3VU9TTDRsclBrMm44OENucldnZkJzNE1Y?=
 =?utf-8?B?SkpDN0FGMVd6QURnTFVqbXlGR2ZaNGlGUTB2WkxBUFdLaWphTWxOQ1dDNmlL?=
 =?utf-8?B?b0swVFgzL1pFMlpnYW13cEdmSFdCKzJTYUVpOElSV05FUGVNdUlnNVk5RmtL?=
 =?utf-8?B?aStTTzBwa045bTJKZlpvMVdaOGNvNUtwR0dSa1NRdFRXd1lkdmNoUEUzRlF5?=
 =?utf-8?B?Qmp1dmpDN2NVMUJUSFNIbHZxdm5uTm1wc2dENEE1U0h1MzVxU0lvT2JtbTV0?=
 =?utf-8?B?NXp5OTBwMFk3cXZva0J6RW55SVhjcnRSZ3dnNmVQRW9TZ3FxamxzcjcwMDJx?=
 =?utf-8?B?WDZBclR4VWlmR0NySnQ3VGM1UDR4NG1NK3VabUFJVXBKT3NFUENiRUFRb3FO?=
 =?utf-8?B?MVNTK3J6UDJjQzlXcm9TeVZhbDJkZFdLZ2NZaXZMS1R0aEJUVUxHb0o5S3hn?=
 =?utf-8?B?T2p6MCtxTGpzK05xQjVNdEZkeXdkTnBzZFY0Yk54YStvbHMwaEFxcjBpV3FO?=
 =?utf-8?B?Yi8yNk1nTDlXcG5mSTJBU2t3aFQvRVdOWi9VdVl4QWJlWDdWajNUT3ZMaTkx?=
 =?utf-8?B?YjVybWdHSjA4MkdIRTZJdk8rblMvUnpGUWZWQ2dzbm9RNXBpMzBETGloOUNG?=
 =?utf-8?B?eVJCekpXbkltU2FVN1l4Sm9TcEEvUExJR1RDUDdnQU90clJWb1NUWlhRNkZp?=
 =?utf-8?B?RDU4aWhseDNzMGlWNmUzSXl2VU1KTHBmZm45SVZuNmtudUpUM0pIY0k5b1ln?=
 =?utf-8?B?TUtidHlwSURPSXlLQXQyMGZ3RjFVUUZ6Vmh4djhTLzNtSHRiZWs5d2tpWnpJ?=
 =?utf-8?B?b2ZvQitiQ0xrcnpYdU5yU2xiN0Q5anp4MDdqVnNLQ09vN2tSUTg2WGZpZ0dS?=
 =?utf-8?B?V1lCSklXTEwwblMvY0pFLzFrV25RTERuOVRXdXZyYnBiTjViMXdobU1zOHZp?=
 =?utf-8?Q?N2zE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWgwT3pHZDJCNnA1dU5pZ2JpQW5xdWdlVUliakMxMUlIWmVveEFuZlVqVXE5?=
 =?utf-8?B?ajdNMVNKKzkwK2pnNDdlVllrUU9Vemd4S0dCZU1vTW9WK3VFajArTFhoNElh?=
 =?utf-8?B?NlloYVpiczI3ZjhpT3N2aUs0akhQNFludmorUmszcUpCNFJPell1N0RSUDQz?=
 =?utf-8?B?RjFuMmZ2bHpIbnhZUm0rVE9iUVljYklELytzNDdFSUsxV2FBaUt1TGxydVRy?=
 =?utf-8?B?VmtmQjNnYTNzaDNPcm9CdGg4Y0NXWitlTmIzWXkwTkc4T21WNnEwRG1WMVBM?=
 =?utf-8?B?RUMxY1VnR3F0cERURnJXVFJqMlZnSFU0aS85eEpZVnBUZEQvbUxIWkNEcnBF?=
 =?utf-8?B?UEd6b1gzWm5Sd1M2VllpVm1FY0FkWThBc3dScnBMTThWblFuK3VkSitLZW5K?=
 =?utf-8?B?b3J0NnpZWWpGZ2xqV2ZjdTFrYlZzL2xxeEJvL0IydXBmSEErTWFQYm43bEov?=
 =?utf-8?B?V1FoUUk1REpBN1dOWjVpNnNVaWUwbFUrYmdOWUNLZllvS0NyYzJoenB3QXZX?=
 =?utf-8?B?UEMwdTNGTnRMcHNuSTNXK2Y0UlMyY2RKU0dSNkJOVy9rY0RlMDhQYW1nWmZ4?=
 =?utf-8?B?QjlDMXdOR291RUhUdTNIak8yZnN4aE9RU3IzRXROWVU2YWJFRjkxbjMxU0JJ?=
 =?utf-8?B?Uys1NEVkaUdDNVQvZmNzU0tkUjJoYjgxQWFmaWN6NHk1ekU4QmFiYzJPSVhT?=
 =?utf-8?B?ZVZQUkVXcTdld1B4K0I2c3M1ZHBZeXBiNTY1eEY2RllYVzdmMmkyTUEwMEdU?=
 =?utf-8?B?R0lwVTdRNHY4S080U0FpSUt3dDFUQWQrVDh2TlhRa3N6UzJUV2pNTkM5VXl1?=
 =?utf-8?B?MENQT2p1bEFma0hqSmtLNzZBejR3YkY3bnY0alFPSGJaMG1XdFlpUDJ4eXUy?=
 =?utf-8?B?YldVdEN3NHZvRERnMFJUQk10OW9DOEtBNmdGd3YrZWR1cUN1UlNSS3RGUDY5?=
 =?utf-8?B?MTk0VDJqbDZONFA1VlUzYitaRkNsZHpodTFjUzk2V0VqQmRPdHc4QnVzVCtK?=
 =?utf-8?B?b09aNmJWNWZna21xKzA4dk1zcFdxUEN2UmkzOUR4empWRnBhbkFjbVhjSUNt?=
 =?utf-8?B?aS82bFRneE9BN2lLclBZSzY5TGo4Wm1XbnVSN292MFFMNnk5dlE3a0YyV3lR?=
 =?utf-8?B?QTNsanFDclRUZzZiVWdYSXdBaW1MS2tOekp5a1VtV3lLOTFoVU50NUxwdTZ2?=
 =?utf-8?B?VnE4UGFJV3ZJU2FTYkh2YTNabmZLdDBQU21KeDdYMUpmaDVOd1hBMCtVVkNM?=
 =?utf-8?B?VEkyWnNkN3N4cG13aEt2ZGtNRVpkR1hjYnlqTEpMNk9HODU0K1JBeTJyaStU?=
 =?utf-8?B?dTVTeWRhU095QjUrZFl5eWw0bm4yU25hdWszcFg0SmNHQjdlQk5NVWVvQnNX?=
 =?utf-8?B?Rk5aTnJYMFBZTm92a2l5emdubGx1ZUN4NG04YXRMSHBBS2U1ZVpNWVR0SEE1?=
 =?utf-8?B?Vkg2eWxyc3I1UEJYY3gwQzVYNXBIazJUdDJiRkw4MmMvZWltUFJaVVp4TDhP?=
 =?utf-8?B?ZHArZE1ZMkhGZWtUaUlnM0tFYzllamZiVVpUK2N4SWNibXhhNGh0aUM3VklE?=
 =?utf-8?B?MTZyNlNkNTN4THBYREJxT3R5VmFINS8vNmlra3I0NU5Balk4SUJrdlhiR2hu?=
 =?utf-8?B?L1EvN3BiVDJvQkRyRTYrSHhuOEd4NjdHSmZ3RGtGdTI2aVllOWZQbWtJRXpJ?=
 =?utf-8?B?YTZUY2k5ajVKTzljMml4MEt5cm9naWZMQnluNGYvLzd0eGRVcGNnb0ViM2o4?=
 =?utf-8?B?dHVVUjdVdjlOV0ErOG52Wlh4VU1yakhPcTdvQXEwT0Y2N1dBaHJpOGRERlU3?=
 =?utf-8?B?NnBONVVwbWdZNkVXRkFrdUlRRXFIOVZHalQ0NTlyamUxaWM2d3lJcXYwbTNo?=
 =?utf-8?B?ZTBPelFYOURDb3JZSm5xN1NUTzBpbjN3andyL2hGMlVKVThZamFkSlpIQ3Nn?=
 =?utf-8?B?L3FhSEVKcStMR0txeGt1eTBqR0NmZnFtY1lmR3B4N2lvcUpMeHVERWRNb2Za?=
 =?utf-8?B?TTlkdXhlUzl3cHZ2bWJVZjR4dDBPcDZUMFAzZWEzbE5OQ3IreHZVbWxlMmp2?=
 =?utf-8?B?cG1XVXFQVWVXaUo4U3I1WUJ1eS96SjZQZlVlVUJ6SFZDZkNCOVRSMkJkZjNU?=
 =?utf-8?B?Ulo4bk54Si92QVFUamtmYU9seCt1Qi81WjhVYmwxTjVHZDBKN05VU3E2TG5C?=
 =?utf-8?B?VFVCNzEvcjJTZU8vSGdTU0JobWpUdDRONWRKTzhBYmJDRksrZE1pU2w2L1Vl?=
 =?utf-8?B?NlU0Mjl5a1ZGNHRtSUpsRFo4OXRpRWtrTHUwRFRPTDZHWjByMk40NmRKbUd2?=
 =?utf-8?Q?Xuhz8q11+5Dzn/xeZg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de08f691-4d1e-4cef-1a3b-08de5d99dc99
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 11:47:34.7235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vy/nC3pqSHWzRKWfwV1PVAz5OoKOUtKPon4FKOfYuEv/INXYrRYrUKdCahctowO7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6668
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

On 1/27/26 04:12, Wang, Beyond wrote:
> [Public]
> 
> 
> When a bo_list handle was reused across multi command submission, reusing
> of those allocated HMM range structure can avoid redundant allocate/free
> operations on each submission.
> Doing this way benefits the amdgpu_cs_parser_bos time, especially for
> large bo_list

And creates a massive security issue, so clear NAK to that.

That we have the HMM range in the BO list is extremely questionable to begin with but wasn't doable otherwise in the past.

Additional to that BO lists are not really used that much any more, OpenGL Mesa has completely dropped them IIRC and RADV isn't using them either.

Regards,
Christian.

> 
> Signed-off-by: Wang, Beyond <Wang.Beyond@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c |  4 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 16 +++++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c     | 19 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h     |  2 ++
>  4 files changed, 33 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> index 66fb37b64388..9c662369d292 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -51,8 +51,10 @@ static void amdgpu_bo_list_free(struct kref *ref)
>                            refcount);
>     struct amdgpu_bo_list_entry *e;
> 
> -   amdgpu_bo_list_for_each_entry(e, list)
> +   amdgpu_bo_list_for_each_entry(e, list) {
> +       amdgpu_hmm_range_free(e->range);
>         amdgpu_bo_unref(&e->bo);
> +   }
>     call_rcu(&list->rhead, amdgpu_bo_list_free_rcu);
>  }
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index ecdfe6cb36cc..fc195fa2c0c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -891,9 +891,13 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>         bool userpage_invalidated = false;
>         struct amdgpu_bo *bo = e->bo;
> 
> -       e->range = amdgpu_hmm_range_alloc(NULL);
> -       if (unlikely(!e->range))
> -           return -ENOMEM;
> +       if (!e->range) {
> +           e->range = amdgpu_hmm_range_alloc(NULL);
> +           if (unlikely(!e->range))
> +               return -ENOMEM;
> +       } else {
> +           amdgpu_hmm_range_reset(e->range);
> +       }
> 
>         r = amdgpu_ttm_tt_get_user_pages(bo, e->range);
>         if (r)
> @@ -995,8 +999,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
> 
>  out_free_user_pages:
>     amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
> -       amdgpu_hmm_range_free(e->range);
> -       e->range = NULL;
> +       amdgpu_hmm_range_reset(e->range);
>     }
>     mutex_unlock(&p->bo_list->bo_list_mutex);
>     return r;
> @@ -1327,8 +1330,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>     r = 0;
>     amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
>         r |= !amdgpu_hmm_range_valid(e->range);
> -       amdgpu_hmm_range_free(e->range);
> -       e->range = NULL;
> +       amdgpu_hmm_range_reset(e->range);
>     }
>     if (r) {
>         r = -EAGAIN;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index 90d26d820bac..5b72ea5a3db7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -273,6 +273,25 @@ struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct amdgpu_bo *bo)
>     return range;
>  }
> 
> +/**
> + * amdgpu_hmm_range_reset - reset an AMDGPU HMM range
> + * @range: pointer to the range object to reset
> + *
> + * Free the hmm_pfns associated with range, but keep the allocated struct range
> + * for reuse, in order to avoid repeated allocation/free overhead when the same
> + * bo_list handle reused across multiple command submissions.
> + *
> + * Return: void
> + */
> +void amdgpu_hmm_range_reset(struct amdgpu_hmm_range *range)
> +{
> +   if (!range)
> +       return;
> +
> +   kvfree(range->hmm_range.hmm_pfns);
> +   range->hmm_range.hmm_pfns = NULL;
> +}
> +
>  /**
>   * amdgpu_hmm_range_free - release an AMDGPU HMM range
>   * @range: pointer to the range object to free
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> index 140bc9cd57b4..558f3f22c617 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> @@ -44,6 +44,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>  #if defined(CONFIG_HMM_MIRROR)
>  bool amdgpu_hmm_range_valid(struct amdgpu_hmm_range *range);
>  struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct amdgpu_bo *bo);
> +void amdgpu_hmm_range_reset(struct amdgpu_hmm_range *range);
>  void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range);
>  int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr);
>  void amdgpu_hmm_unregister(struct amdgpu_bo *bo);
> @@ -67,6 +68,7 @@ static inline struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct amdgpu_bo *
>     return NULL;
>  }
> 
> +static inline void amdgpu_hmm_range_reset(struct amdgpu_hmm_range *range) {}
>  static inline void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range) {}
>  #endif
> 
> --
> 2.43.0


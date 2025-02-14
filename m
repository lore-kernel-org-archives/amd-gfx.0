Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FB4C02198
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 09:09:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E07010EC0F;
	Fri, 14 Feb 2025 09:09:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3XLaoWgt";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27DB710EC0E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 09:09:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPICNe5XlND7RpqLDfq3sF1WSKahEHs/KtswV/wa3ZMM+THym91Ut9KrYIcd/sahRF6g39yVKGlrfwkGY35l+PQvnZhz6xG03Pwf2ij9+ovLfWpzVHnWSyuAT5y/h79f31ruU1smjzMqZLvYmxIUqR7EduR3BudGTbUvQ2818ITqrhChhHoHYi31nMsbmGlpRDiEAwuB4maOC1QZCnPMvjUV4xIw9qFtJD0viHC3jZfzBcZzlLWB6s9LSE9gQgLKjdkqD1PBE97pmdmH9hXwZxsCsWpJ9Y0hD4giQMxJxlW65/cAP3SING3YwWF9fU1puzqVna82x0doKJuVXy5Vvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+WWkZaPw5xVPKXdxq8CHUPjpCCl82VY3LQp3ivMQfQ=;
 b=XwQ7LTgmUY4XD+nH24dBF0hDAw7cGAwzyifyd2N0J3tyaSGrBoG20dxcvv9P3kBgZojNtEFJP52y7TITYkNHcToq5YG8NfkbOLfNM2oQ6lB+gb3v1dYAAB0KLVHH66cxrWkbg0L5P+kJSLQ9Psl4/o5lCrHXBbv8vr6pT5CaX5Cfl77NX8l54UH+J/AjdrxCKDN0fJrFD4MigNsPA+FL6IluK/3FSUA1hOukh0u/uUbtkIV4eHghqhVos/itB4icafFe6O7kiBtkDDE75Dyv6hFtqWMP9vOv6JET5FDnFwBWloozh67OSt5kn+Il0rKeR2BM5VGIKU/9tmUHcBM7wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+WWkZaPw5xVPKXdxq8CHUPjpCCl82VY3LQp3ivMQfQ=;
 b=3XLaoWgtHrQJgCcBOXnyOuqyLRyO41fB+1DHNmjC4yAQKnzeksZYGiURXoMRGvkQD8R2RnpNUsEJp4ZIu302fSPqRt5iEmJZQic0n0y5mPWb3bClitnXa/O8q+Gc4JFerjUwsxIpVXCAxkLDNTBsHLjxv1Z8H3t7VShAdUkJoTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 09:09:46 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ec7a:dd71:9d6c:3062%5]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 09:09:45 +0000
Message-ID: <955a3d4f-06fa-4a4e-85f5-b7b1aadb30bf@amd.com>
Date: Fri, 14 Feb 2025 10:09:39 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Replace Mutex with Spinlock for RLCG register
 access to avoid Priority Inversion in SRIOV
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, lin cao <lin.cao@amd.com>,
 Jingwen Chen <Jingwen.Chen2@amd.com>,
 Victor Skvortsov <victor.skvortsov@amd.com>,
 Zhigang Luo <zhigang.luo@amd.com>
References: <20250214085755.662775-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250214085755.662775-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::6) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|MW3PR12MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: a8c3570d-b37e-4ffa-6cd4-08dd4cd75351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFZFaDJVbk9KUXJuMmFoNWlFZlNUdktUOFd4U0czVlBUQWFYWVdZaTJ3bjNu?=
 =?utf-8?B?MjRlWXk3MEtxUGtoeXFFNkFXMTR3RkRNQkJpWE0zSkFOa0lkVGV2bXJMbHM1?=
 =?utf-8?B?RnBuUXc1aVVaOExUOUsySGNicDlpSXo4T2E3RXZLdDBlZkIxVmY0RkZqZGp2?=
 =?utf-8?B?MG01VzljVWVkN2V1S1lZUk5TYUlvYUpqNE4rT21uOWhtR2FURlY5ZlBVNnE5?=
 =?utf-8?B?ZEtXeHF5VGsrUmx4M1JCdlFwbEhDcWd5TC80TXJ6UnB2V2hiclg2V2NaS1VR?=
 =?utf-8?B?bE1acU5tWlIwdExKN3dLRjl3OW1pZmZkZE5vRkNaQm1ITGJrOFhVZ0JDOXRp?=
 =?utf-8?B?c2pLdFloQ0o2eTFPZjBMUVIrRjFsaHBiSUZ6cmN5QUcvUFUyM21HQTZxR08w?=
 =?utf-8?B?dHdwNnNTMy81czRVMDdJanhhY3lRNG10Ukg0dlRuY3ZuWk9Fdlp1bUtQeENH?=
 =?utf-8?B?SkpDMlVKMTFZKzRKUU4rbVY1eDNIbGkvYkd5cTlVdVU3d1YyaWJHS2VuSGpm?=
 =?utf-8?B?Z0ExZy9XNi9Wc0Y4RCtiUXNCKzJQOFk5ZWlvTTlLQTlJbHlXb3c5UE93dnFS?=
 =?utf-8?B?a2UvS0dlQXZLRkxibzQ2bFc1VDhxWTdSZ1ZtazJMMVZOc2p0djYvYWZoUTYr?=
 =?utf-8?B?NWI2Wk9SWjlqaEpUU01zNm1ZaWRnb1JjeGJZU3ptclBRWHJBWVRBVGpNcW5h?=
 =?utf-8?B?YlNHTmhSWFpRVlZrZ3dqdnVESG84L3V3S0JSZjAxMFh0V2JNa1dDU1lVajhy?=
 =?utf-8?B?TERFOWlNblk2cVBHSVcwNW9jUTZhNEV1WXRkaXFKOEU4ZWl6TWp3alFwV3N4?=
 =?utf-8?B?ZHpoenNTSVBpcm9uUjEwN3dCeWUxSHdzYUh6ZWRRcnhXYjhKQVJ1dGlsOG1k?=
 =?utf-8?B?NnUySUFGTWhVYnNlZkIvTU5rQzVicS9LZk1Fc0xYOUw0eEZYWFRoMkx0YzBi?=
 =?utf-8?B?d2dUbWVNZnBmamExZE44T09Ra2VBRkNDL2NqN0R5K2dEeFIyTFBteFpsRUxP?=
 =?utf-8?B?RWV6Q1A4OG5lOHhibC9yTmduV3hWeEZ5T0U1eDZpbDMyeTF2eVdoRFh2MXhN?=
 =?utf-8?B?UDN0T2pxd0t3SUd4SG1haGcvRFVOdklPZXVLQ202K3JheFFFY2VhdjN6UWZD?=
 =?utf-8?B?aVpPQUlTSjJYVkJEaC9BMlNLZDlFMmluR3VFTHBzbXJVMEFUSklIeTJySjR6?=
 =?utf-8?B?b3Z3b3ZrOVBRSFFSUWlrazlvWlZGRHhsK0N0QS9rZlNVb1kyd1Qra1U2NDVY?=
 =?utf-8?B?ZmpySzhpRkpiTlJTQWVMYVBJZUZFRnJBVzBoQmROaG1LSXhJLzJiSHJtOWo2?=
 =?utf-8?B?c2VwZ2RzcXczVTlMdmE5RDE5NkdzN3NKbVlmbzdsQmN1cEFGMFdWVWRWZ1Vz?=
 =?utf-8?B?dEJBbjFzOS9Db25lb05Sb2F0alNPRjRGa29Ub1FPTzB5ZHg0RFA0T2dRZjZN?=
 =?utf-8?B?OW5NVmVDUTV4SlFSY0szWHNRKzNtbXMxRGJwS0hxWUpIaGFvcVJWN3hwRVN4?=
 =?utf-8?B?YzlNU0U0aTdDbDZoNXM3NE9lM1pNcENxQjJLV3pyY3pUYy9XdnBkQUdWUTlU?=
 =?utf-8?B?S0IwRDFlbTJSTHZpRzE4OERuMFRxTEttTmlrZGhKeHFXU2lwN1VlaTRmVE9y?=
 =?utf-8?B?cmdjQ242RlNjYndISzhMMmVVRmJEOGQweUd6eDVMeXFRZUlNVkVUb1FnQ2Qr?=
 =?utf-8?B?ZDVJT203aHUxbGRCNUVzSitZdWl2MndWVXozUDVyYmZUN2N0blVsWGMrdzcw?=
 =?utf-8?B?b3E2cEhVbmgrZTVnTW1ZRjZQc0J6cUorSmlCdUQvTzRJOHh0TXBhWi81aGRj?=
 =?utf-8?B?QWR0bGhOMXdMU2FEU2IxZHRrYk15U0MxeDdPR0FibHh2cmFLU0lKZ3o1TlJi?=
 =?utf-8?Q?FngWKDRaQOVUH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0tzK1l4c1BEc2IvOXJpUUI2Z1ppWU13YlJ2SVVUemtxczRndGNlM1VpWmtl?=
 =?utf-8?B?c2lGNWNCcW5CNzZPdFU4dE5EamNvMXBVcHpCZXJJREg1a3prTW1ZYXNadXFh?=
 =?utf-8?B?T2VaZzdLS1p6S0o1U3pBMTRpZWxhZ2xsRkk1bUlpQVpXME1wY21EMk5NT0M2?=
 =?utf-8?B?bXpYM2dtcTM2WWFSbXQvYnNsSE1mS2FYelB0WVlZTmdzd1hyTXhHcVFxakdm?=
 =?utf-8?B?cHQwM0lpYzlkSUJ0TW5iYVFTRUxuR1JKUlN5VDZiWTJzM3NJb3hsMjA0SDJk?=
 =?utf-8?B?ajhxRWdxWi9QL2tjOXZUMXNKY01JaEFSU2pOUEtBWWtiZXExNjRFOTBUMU96?=
 =?utf-8?B?aWdWcjhnWGoxTk1nQTNXTE1OZ0loQW5WRXNkVmtrV2NFZDVhUTI1SHp1TlMw?=
 =?utf-8?B?aldnTzJYbUg0K3R1OWJCK0t1WHU0dW9vdGdib3Y2eXl0VUFkaTM3d2wyYzc4?=
 =?utf-8?B?QzI4bGRCN0ZkRmJ3TDlwcVdjVERpNGlQbzFHclE1TGN1SnJ6RVAvbnF1MUlB?=
 =?utf-8?B?SExXVStNcHpDRVNlN2FJQVhXNG1RUW9Ra1RNT0pFbFVKZGR5Wkt2V1RCMERa?=
 =?utf-8?B?M3hJMVlXUWp1bVZuckxWSEduQkJpRWdDSE1Wbk5lTjRQK1NhNnIvQXRnSmxt?=
 =?utf-8?B?MWUrZHdWMUtDaWNBSlpsVS9DVlN0WlBRaDJieE9iQkhkQ3JnWXJSanMrTTJ3?=
 =?utf-8?B?clp3Q05qQnRyTWkySlg4VWNFY3lEL2FFZ1hFVHZzRkhLSkdJbmhGeklkdVls?=
 =?utf-8?B?MUw5TExmdDhiNGt2Y1ZwSzN0Wk16Q3A4eCt1dU9LM1lINUdIUXB5eTlLTGJJ?=
 =?utf-8?B?NVQ2ZnB1Nm1BQ1JhemswakpXQUlKazJ3b08raWJjSVNNb3Fad0RXNk5JZmRh?=
 =?utf-8?B?Q2xHK204WDM5TUZ1VUFKajBWNEtuM0ZlN1VhajBzaXFBaFZ6NFRYMXF0bjFX?=
 =?utf-8?B?NnJ4UWlReVBiRElVcGNGdmIweDhrVE1XdnR5bE1xdFhHdTZad1RTTlA4NzZC?=
 =?utf-8?B?K2pNWURKRENmaTF5QWZDTlJ0M1ZiTnVEamU1MDBXYTZFeTJnNzcvaEJnMFBF?=
 =?utf-8?B?RlhEYXhPQWhXMUQxWWlKQlkxODdVWHJkNG9FQUZpaUF4czN3blFQYzZyRnhZ?=
 =?utf-8?B?allYRWNSRklQRGFtL3JwTkcvZC9OakZyaDVxajR3dVVPakIrcjVkeFhRMGQ3?=
 =?utf-8?B?MHhLYUdjd1VpT2FhVnBQVWk3VWVFSlhKWFRuaEozdUM4MVdUQ0hBWHFXRWli?=
 =?utf-8?B?Nzk5M0lBV3YyTlcraUZrdXVPZWlqTEFTY2RGdHZ4bVdUWHZGNWJUaEMxcldY?=
 =?utf-8?B?U1lHeXpJcjZnZTBTVXRKVytSQnJVSjZjUkZheVFzNmNibVhHWHNRNDhjMlZK?=
 =?utf-8?B?emp4TG8zeExreDA0UkhKbUxSQXhUd1NLMXpPZFhtTkRMNnYzK011enpzTlhP?=
 =?utf-8?B?SkliMEJKUnN0d2J2Q0hZajl6TGpUUSs5V1pGTUE0U2t2K2hzaWNEcGNnM1RE?=
 =?utf-8?B?Y2dxY2xOSU1JMng3TG5CZVQvYUdEaXhrZ2lhYzRka3Z1LzUzRitzV3JPNXVP?=
 =?utf-8?B?T0NTNkJ0SjFsak83bXlHMVhrRmNGM1NhaTIwbDNKYTBPZjc1V1pOY3B0dit1?=
 =?utf-8?B?d2d1NlNEZ09xUVZEV09vOHdTMEVpTk1KWThpQlA0blVJMXBzdGlQWXJGWmhm?=
 =?utf-8?B?U0s4ckhaMi8wUjJiU0JtUDh0VE43TitBUmdBak9jMys4U2ZkZFJ2RlovTXJ3?=
 =?utf-8?B?S0N5WkJ5Tmd4NmZUTnhpVmtqZFpRU0tFNHpYNUhLMlRTZ1g4c01GcVhGV0J3?=
 =?utf-8?B?OStJSE1oNTAwVFlRTkJNWURFbEtGK2R6TDMvZ2ZqOHhSeCtiRnRXam5Ta2Jv?=
 =?utf-8?B?LzlUVWVZaTdJZTlSdlUxaUpma0lxU3VSZkZFZW83aTdSajUwWmhScFJRUkZv?=
 =?utf-8?B?S29yVHZxeW1sRXJremhSaG1JYTNYdUVaSTd4ZmYvN1dHWkROOUhLR05jcnBw?=
 =?utf-8?B?Zjd1bitxZTVtV28weHZYR0p0RER0R0g0Ulkrb2p6RHhYYkticG52RGxUbVpm?=
 =?utf-8?B?MXVWMHJuQjFMdHl1WThsV3paUlRrZTNJQ3g4YWNiR0s3UTVwNWRCL1dSYWpp?=
 =?utf-8?Q?+SpQD1d4AMBW7jhjsFeyXkQX6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8c3570d-b37e-4ffa-6cd4-08dd4cd75351
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 09:09:45.7005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yp48TqJ0gcUWbG0KW5OT+QwwyiAcC2TPsizBSt+jIPsMA/HPru9p55+6Fl8cqRv+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379
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

Am 14.02.25 um 09:57 schrieb Srinivasan Shanmugam:
> RLCG Register Access is a way for virtual functions to safely access GPU
> registers in a virtualized environment., including TLB flushes and
> register reads. When multiple threads or VFs try to access the same
> registers simultaneously, it can lead to race conditions. By using the
> RLCG interface, the driver can serialize access to the registers. This
> means that only one thread can access the registers at a time,
> preventing conflicts and ensuring that operations are performed
> correctly. Additionally, when a low-priority task holds a mutex that a
> high-priority task needs, ie., If a thread holding a spinlock tries to
> acquire a mutex, it can lead to priority inversion. register access in
> amdgpu_virt_rlcg_reg_rw especially in a fast code path is critical.
>
> The call stack shows that the function amdgpu_virt_rlcg_reg_rw is being
> called, which attempts to acquire the mutex. This function is invoked
> from amdgpu_sriov_wreg, which in turn is called from
> gmc_v11_0_flush_gpu_tlb.
>
> The warning [ BUG: Invalid wait context ] indicates that a thread is
> trying to acquire a mutex while it is in a context that does not allow
> it to sleep (like holding a spinlock).
>
> Fixes the below:
>
> [  253.013423] =============================
> [  253.013434] [ BUG: Invalid wait context ]
> [  253.013446] 6.12.0-amdstaging-drm-next-lol-050225 #14 Tainted: G     U     OE
> [  253.013464] -----------------------------
> [  253.013475] kworker/0:1/10 is trying to lock:
> [  253.013487] ffff9f30542e3cf8 (&adev->virt.rlcg_reg_lock){+.+.}-{3:3}, at: amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
> [  253.013815] other info that might help us debug this:
> [  253.013827] context-{4:4}
> [  253.013835] 3 locks held by kworker/0:1/10:
> [  253.013847]  #0: ffff9f3040050f58 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x3f5/0x680
> [  253.013877]  #1: ffffb789c008be40 ((work_completion)(&wfc.work)){+.+.}-{0:0}, at: process_one_work+0x1d6/0x680
> [  253.013905]  #2: ffff9f3054281838 (&adev->gmc.invalidate_lock){+.+.}-{2:2}, at: gmc_v11_0_flush_gpu_tlb+0x198/0x4f0 [amdgpu]
> [  253.014154] stack backtrace:
> [  253.014164] CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Tainted: G     U     OE      6.12.0-amdstaging-drm-next-lol-050225 #14
> [  253.014189] Tainted: [U]=USER, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [  253.014203] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 11/18/2024
> [  253.014224] Workqueue: events work_for_cpu_fn
> [  253.014241] Call Trace:
> [  253.014250]  <TASK>
> [  253.014260]  dump_stack_lvl+0x9b/0xf0
> [  253.014275]  dump_stack+0x10/0x20
> [  253.014287]  __lock_acquire+0xa47/0x2810
> [  253.014303]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  253.014321]  lock_acquire+0xd1/0x300
> [  253.014333]  ? amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
> [  253.014562]  ? __lock_acquire+0xa6b/0x2810
> [  253.014578]  __mutex_lock+0x85/0xe20
> [  253.014591]  ? amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
> [  253.014782]  ? sched_clock_noinstr+0x9/0x10
> [  253.014795]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  253.014808]  ? local_clock_noinstr+0xe/0xc0
> [  253.014822]  ? amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
> [  253.015012]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  253.015029]  mutex_lock_nested+0x1b/0x30
> [  253.015044]  ? mutex_lock_nested+0x1b/0x30
> [  253.015057]  amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
> [  253.015249]  amdgpu_sriov_wreg+0xc5/0xd0 [amdgpu]
> [  253.015435]  gmc_v11_0_flush_gpu_tlb+0x44b/0x4f0 [amdgpu]
> [  253.015667]  gfx_v11_0_hw_init+0x499/0x29c0 [amdgpu]
> [  253.015901]  ? __pfx_smu_v13_0_update_pcie_parameters+0x10/0x10 [amdgpu]
> [  253.016159]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  253.016173]  ? smu_hw_init+0x18d/0x300 [amdgpu]
> [  253.016403]  amdgpu_device_init+0x29ad/0x36a0 [amdgpu]
> [  253.016614]  amdgpu_driver_load_kms+0x1a/0xc0 [amdgpu]
> [  253.017057]  amdgpu_pci_probe+0x1c2/0x660 [amdgpu]
> [  253.017493]  local_pci_probe+0x4b/0xb0
> [  253.017746]  work_for_cpu_fn+0x1a/0x30
> [  253.017995]  process_one_work+0x21e/0x680
> [  253.018248]  worker_thread+0x190/0x330
> [  253.018500]  ? __pfx_worker_thread+0x10/0x10
> [  253.018746]  kthread+0xe7/0x120
> [  253.018988]  ? __pfx_kthread+0x10/0x10
> [  253.019231]  ret_from_fork+0x3c/0x60
> [  253.019468]  ? __pfx_kthread+0x10/0x10
> [  253.019701]  ret_from_fork_asm+0x1a/0x30
> [  253.019939]  </TASK>
>
> Fixes: e864180ee49b ("drm/amdgpu: Add lock around VF RLCG interface")
> Cc: lin cao <lin.cao@amd.com>
> Cc: Jingwen Chen <Jingwen.Chen2@amd.com>
> Cc: Victor Skvortsov <victor.skvortsov@amd.com>
> Cc: Zhigang Luo <zhigang.luo@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   | 3 ++-
>  3 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index eab530778fbd..14125cc3a937 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4251,7 +4251,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	mutex_init(&adev->grbm_idx_mutex);
>  	mutex_init(&adev->mn_lock);
>  	mutex_init(&adev->virt.vf_errors.lock);
> -	mutex_init(&adev->virt.rlcg_reg_lock);
>  	hash_init(adev->mn_hash);
>  	mutex_init(&adev->psp.mutex);
>  	mutex_init(&adev->notifier_lock);
> @@ -4277,6 +4276,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  	spin_lock_init(&adev->se_cac_idx_lock);
>  	spin_lock_init(&adev->audio_endpt_idx_lock);
>  	spin_lock_init(&adev->mm_stats.lock);
> +	spin_lock_init(&adev->virt.rlcg_reg_lock);
>  	spin_lock_init(&adev->wb.lock);
>  
>  	xa_init_flags(&adev->userq_xa, XA_FLAGS_LOCK_IRQ);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 2056efaf157d..073fc34e43eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -1038,7 +1038,11 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
>  	scratch_reg2 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg2;
>  	scratch_reg3 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg3;
>  
> -	mutex_lock(&adev->virt.rlcg_reg_lock);
> +	/* Try to acquire the lock without blocking */
> +	if (!spin_trylock(&adev->virt.rlcg_reg_lock)) {

That is clearly not going to work, you really need to block here.

> +		dev_err(adev->dev, "Failed to acquire rlcg_reg_lock, aborting register access!\n");
> +		return 0;
> +	}
>  
>  	if (reg_access_ctrl->spare_int)
>  		spare_int = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->spare_int;
> @@ -1097,7 +1101,8 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
>  
>  	ret = readl(scratch_reg0);
>  
> -	mutex_unlock(&adev->virt.rlcg_reg_lock);
> +	/* Unlock the spinlock after the critical section is complete */
> +	spin_unlock(&adev->virt.rlcg_reg_lock);

Please drop those comments. Never document what is done, but only why.

Question is can that be used from interrupt context as well? I think yes, so we even need to use the spinlock_irqsafe variant here.

Regards,
Christian.

>  
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 270a032e2d70..0f3ccae5c1ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -279,7 +279,8 @@ struct amdgpu_virt {
>  	/* the ucode id to signal the autoload */
>  	uint32_t autoload_ucode_id;
>  
> -	struct mutex rlcg_reg_lock;
> +	/* Spinlock to protect access to the RLCG register interface */
> +	spinlock_t rlcg_reg_lock;
>  
>  	union amd_sriov_ras_caps ras_en_caps;
>  	union amd_sriov_ras_caps ras_telemetry_en_caps;


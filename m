Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A221C87FD3
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 06:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9274410E33E;
	Mon,  4 Aug 2025 06:50:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FQhEciAs";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE9A510E33E
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 06:50:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QETQnsscowqhSmjlm61fJ+kIiNb0j6jm4n1yEq+M9G6nP92QYpRBXZJSHZ/+5oX7HQkx9gqb+ZlWbRaiE+ISvVn//3msvfTWumFH+LW5P7LGgGY4LqoRHPl0PxNGqjj/3CPCWAsCFfucdtU6pf5f9CLlQs7F3RtWOJrPQtvYcmF+YOsYfEovPGtlDb5dCoBQcN6MAfxxOvYG0jr3Zh20T3IFau9x27UqHpjevO3W5OhZ+S2tamy8tA8yEhHMrkzKgUtey7HGtjPumsBHjjWuwy0eY7FX45s3Qccrva+S0o35alx95lDEvX9WI/018tpW7iuodmXql+77Fyf+It+VEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7rW20bfrtGROfQKarSRHiWpVLhSBbFA7H/deulPQE0=;
 b=p9/UupTXr3UMXWvYq2BOqPD+F+9y8r2oJG8fJjrvvUYlG/zPIxu8IG5QAXx5aA7f+Cr8/DryYtS4DA76xyZU4mBVqJfKarh8s2erbrnznPQCxHY5VkOl3fs1SBKGRQd1xc73n01P2vCctf4YvpMqSUyo4nuqNRw1yENs+pNrjbJUEzxlr+vxYQLBCALhjUHGJoYRg7FKEDGqN06O3kYMo/ct9LsY2yY5U/ehtn3S62aMoiOsKgkWNFXjeSqjna6aVwEAuyDRMrt+IyToZuuB/V2kDKIEMo/UH3nsBVbWwekusGFQY4RzuSOXgIS6Q2TvnU4rAlX+m9WTKjMv64kUzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7rW20bfrtGROfQKarSRHiWpVLhSBbFA7H/deulPQE0=;
 b=FQhEciAsuLb74jW9t4K4cTXFy/E+rdwa8uGVlSby3iEn+TPZSD+F1gJKChDLo3dCCXNr6MDJl/wSHrGcdrWnrBrTnRuoFVckdsRNDHhae35OAF1aGtdBPqT5JXs/TgsD8eVxFvtOAEN+iNplluFa1gCIuutmsfg8v+Utoa2S77o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 by SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 06:50:11 +0000
Received: from SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8]) by SN7PR12MB7835.namprd12.prod.outlook.com
 ([fe80::ea3a:4720:99cb:32d8%7]) with mapi id 15.20.8989.017; Mon, 4 Aug 2025
 06:50:11 +0000
Content-Type: multipart/alternative;
 boundary="------------AGzR2FFc0jjcMJMD1X8b3lAq"
Message-ID: <49b66a41-d754-443d-8112-441c23361f45@amd.com>
Date: Mon, 4 Aug 2025 14:50:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 09/10] amdkfd: decommission kfd_get_process and remove
 DIQ support
To: Felix Kuehling <felix.kuehling@amd.com>, alexander.deucher@amd.com
Cc: ray.huang@amd.com, amd-gfx@lists.freedesktop.org
References: <20250801085556.8504-1-lingshan.zhu@amd.com>
 <20250801085556.8504-10-lingshan.zhu@amd.com>
 <d82d8f5b-f1d5-443b-a939-8e25717c6d62@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <d82d8f5b-f1d5-443b-a939-8e25717c6d62@amd.com>
X-ClientProxiedBy: SG3P274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::36)
 To SN7PR12MB7835.namprd12.prod.outlook.com
 (2603:10b6:806:328::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB7835:EE_|SA0PR12MB4495:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b459198-7459-4622-9f90-08ddd3232821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWJtWFBGVnNmWU9YbllmS2xyeE9VdE02bHJsYXhPY1J6VzB5UTBrd3dzZmdU?=
 =?utf-8?B?WUtTZzZKSVlONC84ZzZJUURYS2hUNVQ1RWRwcnBqR3JWd2cyUXkvekdZVmd3?=
 =?utf-8?B?RUNSRi9VVDFvVnZVOXNQKzVDRmVKSDVKZVdvZ0NFNWluckNtZHRuYVRhUXFP?=
 =?utf-8?B?a3o4K1RoeEhIbTdrQk04U1Q0eVVIRjJkNGNWTUExSXd4dVFMQllzUWhYdVJn?=
 =?utf-8?B?NjhLSjBsQkpNd1E4OVdJQ1dNcHlHbnl0QXlRSjEwdDBiZFFmWlhINTJjZjJX?=
 =?utf-8?B?MnY2aEpTMnpwZkxpWUVvb296NzFqTFVxVU51Q0xUMmpBVVNxUkZGR0trd1h4?=
 =?utf-8?B?R05Ua1dueldFck9TQmkvRUhybXBtTytGZENhYXdoM0xFU3lsVHFRZ1p4c2pK?=
 =?utf-8?B?eFIxdWdpakV4MDFzZUpEZ0s0VG5GZC96eGdRVVhCT3hVUnhXeVpCWGFhYTJV?=
 =?utf-8?B?M1paQ1V4RXc4OGNSQVZkczhNQlhuSzNYTi80ZER5Y3N6K3lwb3d1WDZGdXlS?=
 =?utf-8?B?clh1R2dGTTdkdTRnY3BTVVRhcm9DaDZBbUVGbFV2UjNsellIODNxc3pXT3Rl?=
 =?utf-8?B?RkJ3MmRoUGF1RzU0amZnTm1rS21YSUEzMnd2OVVmalNEV2RIVS9EejNoL21F?=
 =?utf-8?B?TWJUWS9lbUdoSG1BcjZET3pGYW52bWladGRQaGJiTGhvU2d4V01kSzJLd1pu?=
 =?utf-8?B?bm5mRUtmclhQcEVPV01hU2c2dGd5R0g1U0pQN1g2TDZHQUZQVUJVM0wwSWI2?=
 =?utf-8?B?UDBYNDBuVnJ5VzFURy84T2RaMzlzTlpYQ0FLN3NtTXlXRHllVEtLb1JhTHcz?=
 =?utf-8?B?R1JlbUthejJhU0pUd1ZoUThmVFdFREwzUkJGYkdickFnYVBKOFhEU2loUmla?=
 =?utf-8?B?QXZrUjdmaEhLUDVpa1lhdUFHMm1LNnptMGRXVkhIR28vME1JTWtubGpXTmZV?=
 =?utf-8?B?UmdiNHlYbkZCcGpFNVNxRTFPVmZDd1JPNHNXMUdjb0xpVE9RRDNINUszd2d6?=
 =?utf-8?B?M3A3K1hONjM5RlVmVjY5TkFiS0Rva29qSzkzNDNMS1ZBVENLRmh0ZUw4Q2w1?=
 =?utf-8?B?U0QwWHJ5a2owR28rR2ZTNUNWelhEcHAyZVhKUmxUTkhGRU9xTzZPanVlU21k?=
 =?utf-8?B?MTByQUFYMng5dDlOWHFKYnRuWjYvS3pRL1F3V3VCZ1ZORjZDZk5JRGxJYzJ0?=
 =?utf-8?B?cENBQ0FIb05samJZODB0TGZHSkVFRzJNWDVJM1dMSU9XYnE5YkI4TXo0TXA2?=
 =?utf-8?B?L1JMNVc1SFJmWTJodkp0YTFGOHNqTTJaY3BXL2xRRStLcVh1YUVHa0U5enhr?=
 =?utf-8?B?b2dvR0VGa1h3d3FKaXBtR25JejMveWw2WnZXcnFoSW1jbzdSb1poRmRmaGpI?=
 =?utf-8?B?Wk1vUjYrdXZOM2VveHN0RzZ3c25CcTBBYmo4RGJONVRFUWpQeHQzdW1ueFQ0?=
 =?utf-8?B?cGk5aS9GenozdU1LZjZuRVgwSnZOTnVucDNyVk94dWNPYTlaN01UekZ4RCtn?=
 =?utf-8?B?Nk5PcFgwNEErMXZTR0xsN2pxenAvTlJWbEFyRHBocFlibDd5OXk4eUxUbHpQ?=
 =?utf-8?B?RzlaNEZxSklHUXY4TXpzdnQ1U1ErTmNBYzZjWmdKKy9vMkVEam1pZkc0cjJn?=
 =?utf-8?B?VzYwZENBNXc2N3JlckorRXBQZ0tFN242Z2tmc0Q4eDYrMURSNDhScldLS1Bi?=
 =?utf-8?B?b2QrSWFKM3F2NWUzUDNmNlFWSTZlb3hxMXg3ZWw1NVFIY0lvOWozYWcwNC9v?=
 =?utf-8?B?SVYzQTZ5WUhRRlZ6eEczN1RzVDI4R2tOTkltUkdhOGtUMzlzYUNLZXBUV0Rv?=
 =?utf-8?B?TkNQMHZTUkRqUHVXTXNHcFZUYThuWEJyZGd5dm5jY3NuLy8wS0pxMFA4RGZQ?=
 =?utf-8?B?dExIL1B4UkVQSE0rbGlUeWVRSGxjclJZSFFGd1N4RkxxUU5YSWQyM0pPRVZn?=
 =?utf-8?Q?bMMDckmWRMA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB7835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3BOaVdLd3YwVHlRcVUvWTlhQ3dyVVdVNGN5aW9RaHMrdWpRcnd6a1JScnh2?=
 =?utf-8?B?c3NVaE1obDBEM3ZOS1lyVCtBcGJ2Z0Y4M3RLRjBteEVJSGQvc3NjYWkxQUJk?=
 =?utf-8?B?b254anBOWTExR1JLWWY1SUhLUkVPeG5JVm5DNGNTT09oSmZoMm9ZazVRYU5Y?=
 =?utf-8?B?d0pyNklvOURRWC9GUTJBbmFQMHFwVjZuSzJsQUc3b0NXdE0zOGJnYjNpeTBJ?=
 =?utf-8?B?bk1sRjFGTldvN0RXTTVFREF5VElPL3AzNm9oR3lUR3kxRkdPdTlNaHlsZXRn?=
 =?utf-8?B?N2ZPZHFXTEsycXVCS09wNTBlMHVNeXpLejl2QURtTlJHRVdVa0JZWGNZS05G?=
 =?utf-8?B?TVJSK1IxcFJtUnJKR1BCQUgxdnJTNHFQc0czbWVlOGRibWdRaVg2aHVoM2hH?=
 =?utf-8?B?YXVVTmhqbjdNK0NBb09KT1RCajJlNjllK1JMU0RnUE5TWFRLc0hNVDRKRnBm?=
 =?utf-8?B?OC9ZeXRqTzFrMmN0c0Z5bHcwZjh0dFZCMGJJR3pMWWM1K1B3VWlMR1Vmd0Z1?=
 =?utf-8?B?QXNKUjZaaXlUMDVhYndRZlZKSk9qREgwUktzVElQQW85UHE3ODNyRXp0eEp2?=
 =?utf-8?B?eHp1R21mV1hncHc5QkpXSEwvejMxcTE2Q3JaSlE3Z0FVY3Y0T3hXby9XUTJu?=
 =?utf-8?B?K1VTK2VPNzhCNWUxSEgxTnc1enpqUmhUV0trVW5UTlVSS21IU1l1TmIrUzNJ?=
 =?utf-8?B?bU5wRTJ0c0NZbS9vVk5yOGhWY01FZmxGNmxscG5aOUNheWhGa0RJYUxoamNi?=
 =?utf-8?B?bGJ4OXFER1BTRFFkeUx2QVpvditlL0xmU2lkR0lyK2ZvRzJEb1dySmZWbFl6?=
 =?utf-8?B?U00zZ0FGRXcxTlozWEFRRncyd2UxZ1B0YytoNWVUUVR0SWNCWHVVejJWSlpC?=
 =?utf-8?B?WW9Ic2xLUEIvd1pnQU05bGRyczFBT2d2NzJiamlXZ2NLWnNkNjV3VlVhTnhl?=
 =?utf-8?B?dndtZko2YzNtTXhBZkdBVFRDOXd0NXRoT1pZc2NYczJhRzhncVJHblhZcFFE?=
 =?utf-8?B?WXYrL2RDamJrc1h5dEZZY0MzOHZmYmdncnhENFZLbTZqeVlmM0F3ejdJbjBF?=
 =?utf-8?B?L2xSa3pleitCekRkc054UGJyL1NyOGhJVjU3bk5jbFh3S1JoaFR2Y0FwbTMr?=
 =?utf-8?B?K2RjYTQ4WXdCcFN6UFVONklkcW4rOWJZR1FkTmhGU0YrRHF4U2FxeVExalZa?=
 =?utf-8?B?OU5HUXJva2NFRmtaS3Z1NzdCajRCejhPUkdxV0hDbk45YkxQeENoQkh0cGRh?=
 =?utf-8?B?cVV0MUlCUC80MnMySVVTR2NPWXFlZmxiY3YvdnJLRjZWbkc0RE1VU1U0Qmd1?=
 =?utf-8?B?SW41VlM0bFp1aVpGWncwVjlBdW5KVndBNG9kSjBHU2hVNDJqb1NoeWc2b1ZQ?=
 =?utf-8?B?NkE4QnkvTjlDQlVPK1ZvSGVZMUhHUnp5d3B2TndVZnlIS241L3JUSHcwQzNI?=
 =?utf-8?B?Umc2TmVzMFhXSnpGL2FlV29jNXUxaFJPUXJrYnN5MTgwNko2bTlrdG5wMHJm?=
 =?utf-8?B?T21JazlIbkZBVEJSUjkrSk8xcTlpSVhFczZUUUlsSE91R3F3WlBQSGNiNHp5?=
 =?utf-8?B?TDVQeEhDMTZLbXJaWE4xelRVNGpTMHJJcXhSTkJmdUZvWEMwWDBBREZLRDA5?=
 =?utf-8?B?Z0NQOFRMdFlrdm9XRzlXRDE5ZWhZczA1Wmloc0hsM1dhM0VPOS8wYTBqKzBN?=
 =?utf-8?B?dW9ydGc3bEpNTmYvQnZFYnB2K2owK1gvMTZuWkxmcTIvUG9FSlNYMmtPVStD?=
 =?utf-8?B?WHdLUDdFK200NVIzeXZ6MW54by9vZEFVbS9pSWdnQjl3azQvdWczM2NyMGl2?=
 =?utf-8?B?dW5ZY3pnOHovTVc0Wm9CZXhYVklUNEtZQkI0OElWV2RYRTZUNzc3TUJxbW1i?=
 =?utf-8?B?NW1mU1EyVS81MWUwMkNhWUtsVDkrNzVNYXZNZWlyR1dzem50OFhoem5MYnZr?=
 =?utf-8?B?NHVuS2s1R1owWGdVdGZuTE00eXZsanFNaEFDc2hSNDQ3b0hOZDRZRTVtQnp6?=
 =?utf-8?B?Z3FkTDJKTElvLzBnbVExNW5BeFBUY0JvMVhjL3habDN3NHdxRFhmZCtxVTVt?=
 =?utf-8?B?cXNQL0FPbUNtNjNmU2hwZjJFQjkybTg1ZVhmR0ovcGRoclRQMjVTQ01yaW8v?=
 =?utf-8?Q?BjB6CK7mpCXD7sSL5qlCmRzp3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b459198-7459-4622-9f90-08ddd3232821
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 06:50:11.0636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sW1ma98tG9G303270ks4QbDj8NK+j3wvdm0kTLKuDXsTHYDLqfl9yyaSaD47OCzRMP/EIYDlpEMH5/tw1TDig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495
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

--------------AGzR2FFc0jjcMJMD1X8b3lAq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/2/2025 12:10 AM, Felix Kuehling wrote:

> On 2025-08-01 4:55, Zhu Lingshan wrote:
>> This commit decommissions the function kfd_get_process()
>> because it can not locate a specific kfd process among
>> mulitple contexts.
>>
>> This commit refactors the relevant code path accordingly:
>> - kmmap: retrieve the kfd_process from filep->private_data
>> - kq_initialize: queue->process for HIQ should be set to NULL
>> because it does not belong to any kfd_process. DIQ has been
>> decommissioned in this commit because it has been marked as
>> DEPRECATED since 2022 in commit 5bdd3eb2
>>
>> This commit removes test_kq() function becuse it has been
>> marked as unused since 2014 and no other functions calls it.
> Please split this into 3 commits:
>
>  1. Change how kfd_mmap looks up the process
>  2. Remove DIQ support
>  3. Remove test_kq

Will do!

> See one more comment inline.
>
>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 11 ++--
>>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 +-
>>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 60 ++-----------------
>>  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  4 --
>>  .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  4 --
>>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 -
>>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 18 ------
>>  .../amd/amdkfd/kfd_process_queue_manager.c    | 35 +----------
>>  8 files changed, 16 insertions(+), 123 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 5b22e1c47b2e..9e95acd23889 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -3408,16 +3408,19 @@ static int kfd_mmio_mmap(struct kfd_node *dev, struct kfd_process *process,
>>  }
>>  
>>  
>> -static int kfd_mmap(struct file *filp, struct vm_area_struct *vma)
>> +static int kfd_mmap(struct file *filep, struct vm_area_struct *vma)
>>  {
>>  	struct kfd_process *process;
>>  	struct kfd_node *dev = NULL;
>>  	unsigned long mmap_offset;
>>  	unsigned int gpu_id;
>>  
>> -	process = kfd_get_process(current);
>> -	if (IS_ERR(process))
>> -		return PTR_ERR(process);
>> +	process = filep->private_data;
>> +	if (!process)
>> +		return -ESRCH;
>> +
>> +	if (process->lead_thread != current->group_leader)
>> +		return -EBADF;
>>  
>>  	mmap_offset = vma->vm_pgoff << PAGE_SHIFT;
>>  	gpu_id = KFD_MMAP_GET_GPU_ID(mmap_offset);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> index 76359c6a3f3a..3f78e0bb2dae 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>> @@ -399,8 +399,7 @@ static void increment_queue_count(struct device_queue_manager *dqm,
>>  				  struct queue *q)
>>  {
>>  	dqm->active_queue_count++;
>> -	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
>> -	    q->properties.type == KFD_QUEUE_TYPE_DIQ)
>> +	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
>>  		dqm->active_cp_queue_count++;
>>  
>>  	if (q->properties.is_gws) {
>> @@ -414,8 +413,7 @@ static void decrement_queue_count(struct device_queue_manager *dqm,
>>  				  struct queue *q)
>>  {
>>  	dqm->active_queue_count--;
>> -	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
>> -	    q->properties.type == KFD_QUEUE_TYPE_DIQ)
>> +	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
>>  		dqm->active_cp_queue_count--;
>>  
>>  	if (q->properties.is_gws) {
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>> index 2b0a830f5b29..6aa8b0348bad 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
>> @@ -46,7 +46,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
>>  	int retval;
>>  	union PM4_MES_TYPE_3_HEADER nop;
>>  
>> -	if (WARN_ON(type != KFD_QUEUE_TYPE_DIQ && type != KFD_QUEUE_TYPE_HIQ))
>> +	if (WARN_ON(type != KFD_QUEUE_TYPE_HIQ))
>>  		return false;
>>  
>>  	pr_debug("Initializing queue type %d size %d\n", KFD_QUEUE_TYPE_HIQ,
>> @@ -61,14 +61,9 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
>>  
>>  	kq->dev = dev;
>>  	kq->nop_packet = nop.u32all;
>> -	switch (type) {
>> -	case KFD_QUEUE_TYPE_DIQ:
>> -		kq->mqd_mgr = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_DIQ];
>> -		break;
>> -	case KFD_QUEUE_TYPE_HIQ:
>> +	if (type == KFD_QUEUE_TYPE_HIQ)
>>  		kq->mqd_mgr = dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
>> -		break;
>> -	default:
>> +	else {
>>  		dev_err(dev->adev->dev, "Invalid queue type %d\n", type);
>>  		return false;
>>  	}
>> @@ -144,7 +139,8 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
>>  		goto err_init_queue;
>>  
>>  	kq->queue->device = dev;
>> -	kq->queue->process = kfd_get_process(current);
>> +	if (type == KFD_QUEUE_TYPE_HIQ)
>> +		kq->queue->process = NULL;
>>  
>>  	kq->queue->mqd_mem_obj = kq->mqd_mgr->allocate_mqd(kq->mqd_mgr->dev,
>>  					&kq->queue->properties);
>> @@ -162,24 +158,11 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
>>  		kq->mqd_mgr->load_mqd(kq->mqd_mgr, kq->queue->mqd,
>>  				kq->queue->pipe, kq->queue->queue,
>>  				&kq->queue->properties, NULL);
>> -	} else {
>> -		/* allocate fence for DIQ */
>> -
>> -		retval = kfd_gtt_sa_allocate(dev, sizeof(uint32_t),
>> -						&kq->fence_mem_obj);
>> -
>> -		if (retval != 0)
>> -			goto err_alloc_fence;
>> -
>> -		kq->fence_kernel_address = kq->fence_mem_obj->cpu_ptr;
>> -		kq->fence_gpu_addr = kq->fence_mem_obj->gpu_addr;
>>  	}
>>  
>>  	print_queue(kq->queue);
>>  
>>  	return true;
>> -err_alloc_fence:
>> -	kq->mqd_mgr->free_mqd(kq->mqd_mgr, kq->queue->mqd, kq->queue->mqd_mem_obj);
>>  err_allocate_mqd:
>>  	uninit_queue(kq->queue);
>>  err_init_queue:
>> @@ -209,8 +192,6 @@ static void kq_uninitialize(struct kernel_queue *kq)
>>  					kq->queue->queue);
>>  		up_read(&kq->dev->adev->reset_domain->sem);
>>  	}
>> -	else if (kq->queue->properties.type == KFD_QUEUE_TYPE_DIQ)
>> -		kfd_gtt_sa_free(kq->dev, kq->fence_mem_obj);
>>  
>>  	kq->mqd_mgr->free_mqd(kq->mqd_mgr, kq->queue->mqd,
>>  				kq->queue->mqd_mem_obj);
>> @@ -358,34 +339,3 @@ void kernel_queue_uninit(struct kernel_queue *kq)
>>  	kq_uninitialize(kq);
>>  	kfree(kq);
>>  }
>> -
>> -/* FIXME: Can this test be removed? */
>> -static __attribute__((unused)) void test_kq(struct kfd_node *dev)
>> -{
>> -	struct kernel_queue *kq;
>> -	uint32_t *buffer, i;
>> -	int retval;
>> -
>> -	dev_err(dev->adev->dev, "Starting kernel queue test\n");
>> -
>> -	kq = kernel_queue_init(dev, KFD_QUEUE_TYPE_HIQ);
>> -	if (unlikely(!kq)) {
>> -		dev_err(dev->adev->dev, "  Failed to initialize HIQ\n");
>> -		dev_err(dev->adev->dev, "Kernel queue test failed\n");
>> -		return;
>> -	}
>> -
>> -	retval = kq_acquire_packet_buffer(kq, 5, &buffer);
>> -	if (unlikely(retval != 0)) {
>> -		dev_err(dev->adev->dev, "  Failed to acquire packet buffer\n");
>> -		dev_err(dev->adev->dev, "Kernel queue test failed\n");
>> -		return;
>> -	}
>> -	for (i = 0; i < 5; i++)
>> -		buffer[i] = kq->nop_packet;
>> -	kq_submit_packet(kq);
>> -
>> -	dev_err(dev->adev->dev, "Ending kernel queue test\n");
>> -}
>> -
>> -
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> index 505036968a77..3d2375817c3e 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
>> @@ -252,10 +252,6 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
>>  			packet->bitfields2.queue_type =
>>  		queue_type__mes_map_queues__normal_latency_static_queue_vi;
>>  		break;
>> -	case KFD_QUEUE_TYPE_DIQ:
>> -		packet->bitfields2.queue_type =
>> -			queue_type__mes_map_queues__debug_interface_queue_vi;
>> -		break;
>>  	case KFD_QUEUE_TYPE_SDMA:
>>  	case KFD_QUEUE_TYPE_SDMA_XGMI:
>>  		if (q->properties.sdma_engine_id < 2 &&
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
>> index a1de5d7e173a..60086e7cc258 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
>> @@ -166,10 +166,6 @@ static int pm_map_queues_vi(struct packet_manager *pm, uint32_t *buffer,
>>  			packet->bitfields2.queue_type =
>>  		queue_type__mes_map_queues__normal_latency_static_queue_vi;
>>  		break;
>> -	case KFD_QUEUE_TYPE_DIQ:
>> -		packet->bitfields2.queue_type =
>> -			queue_type__mes_map_queues__debug_interface_queue_vi;
>> -		break;
>>  	case KFD_QUEUE_TYPE_SDMA:
>>  	case KFD_QUEUE_TYPE_SDMA_XGMI:
>>  		packet->bitfields2.engine_sel = q->properties.sdma_engine_id +
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index a6e12c705734..67ebdaa9995f 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -1047,7 +1047,6 @@ void kfd_process_destroy_wq(void);
>>  void kfd_cleanup_processes(void);
>>  struct kfd_process *kfd_create_process(struct task_struct *thread);
>>  int kfd_create_process_sysfs(struct kfd_process *process);
>> -struct kfd_process *kfd_get_process(const struct task_struct *task);
>>  struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
>>  						 struct kfd_process_device **pdd);
>>  struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> index 117e524f4fb3..2d01356627ef 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>> @@ -989,24 +989,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
>>  	return process;
>>  }
>>  
>> -struct kfd_process *kfd_get_process(const struct task_struct *thread)
>> -{
>> -	struct kfd_process *process;
>> -
>> -	if (!thread->mm)
>> -		return ERR_PTR(-EINVAL);
>> -
>> -	/* Only the pthreads threading model is supported. */
>> -	if (thread->group_leader->mm != thread->mm)
>> -		return ERR_PTR(-EINVAL);
>> -
>> -	process = find_process(thread, false);
>> -	if (!process)
>> -		return ERR_PTR(-EINVAL);
>> -
>> -	return process;
>> -}
>> -
>>  static struct kfd_process *find_process_by_mm(const struct mm_struct *mm)
>>  {
>>  	struct kfd_process *process;
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> index c643e0ccec52..287ac5de838a 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
>> @@ -345,7 +345,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>>  	 * If we are just about to create DIQ, the is_debug flag is not set yet
>>  	 * Hence we also check the type as well
>>  	 */
>> -	if ((pdd->qpd.is_debug) || (type == KFD_QUEUE_TYPE_DIQ))
>> +	if ((pdd->qpd.is_debug))
>>  		max_queues = dev->kfd->device_info.max_no_of_hqd/2;
>>  
>>  	if (pdd->qpd.queue_count >= max_queues)
>> @@ -426,22 +426,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>>  						    restore_mqd, restore_ctl_stack);
>>  		print_queue(q);
>>  		break;
>> -	case KFD_QUEUE_TYPE_DIQ:
>> -		kq = kernel_queue_init(dev, KFD_QUEUE_TYPE_DIQ);
>> -		if (!kq) {
>> -			retval = -ENOMEM;
>> -			goto err_create_queue;
>> -		}
>> -		kq->queue->properties.queue_id = *qid;
>> -		pqn->kq = kq;
>> -		pqn->q = NULL;
>> -		retval = kfd_process_drain_interrupts(pdd);
>> -		if (retval)
>> -			break;
>> -
>> -		retval = dev->dqm->ops.create_kernel_queue(dev->dqm,
>> -							kq, &pdd->qpd);
>> -		break;
>>  	default:
>>  		WARN(1, "Invalid queue type %d", type);
>>  		retval = -EINVAL;
>> @@ -1128,24 +1112,9 @@ int pqm_debugfs_mqds(struct seq_file *m, void *data)
>>  			mqd_mgr = q->device->dqm->mqd_mgrs[mqd_type];
>>  			size = mqd_mgr->mqd_stride(mqd_mgr,
>>  							&q->properties);
>> -		} else if (pqn->kq) {
>> -			q = pqn->kq->queue;
>> -			mqd_mgr = pqn->kq->mqd_mgr;
>> -			switch (q->properties.type) {
>> -			case KFD_QUEUE_TYPE_DIQ:
>> -				seq_printf(m, "  DIQ on device %x\n",
>> -					   pqn->kq->dev->id);
>> -				break;
>> -			default:
>> -				seq_printf(m,
>> -				"  Bad kernel queue type %d on device %x\n",
>> -					   q->properties.type,
>> -					   pqn->kq->dev->id);
>> -				continue;
>> -			}
>>  		} else {
>>  			seq_printf(m,
>> -		"  Weird: Queue node with neither kernel nor user queue\n");
>> +			"  Weird: Queue node with neither kernel nor user queue\n");
> This message is no longer accurate, since this function no longer handles kernel queues at all.

I will improve this message, drop kernel queue.

Thanks
Lingshan

>
> Regards,
>   Felix
>
>
>>  			continue;
>>  		}
>>  
--------------AGzR2FFc0jjcMJMD1X8b3lAq
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 8/2/2025 12:10 AM, Felix Kuehling wrote:</pre>
    <blockquote type="cite" cite="mid:d82d8f5b-f1d5-443b-a939-8e25717c6d62@amd.com">
      <pre wrap="" class="moz-quote-pre">On 2025-08-01 4:55, Zhu Lingshan wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">This commit decommissions the function kfd_get_process()
because it can not locate a specific kfd process among
mulitple contexts.

This commit refactors the relevant code path accordingly:
- kmmap: retrieve the kfd_process from filep-&gt;private_data
- kq_initialize: queue-&gt;process for HIQ should be set to NULL
because it does not belong to any kfd_process. DIQ has been
decommissioned in this commit because it has been marked as
DEPRECATED since 2022 in commit 5bdd3eb2

This commit removes test_kq() function becuse it has been
marked as unused since 2014 and no other functions calls it.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Please split this into 3 commits:

 1. Change how kfd_mmap looks up the process
 2. Remove DIQ support
 3. Remove test_kq
</pre>
    </blockquote>
    <pre>Will do!</pre>
    <blockquote type="cite" cite="mid:d82d8f5b-f1d5-443b-a939-8e25717c6d62@amd.com">
      <pre wrap="" class="moz-quote-pre">
See one more comment inline.


</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Signed-off-by: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 11 ++--
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 60 ++-----------------
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  4 --
 .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |  4 --
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 18 ------
 .../amd/amdkfd/kfd_process_queue_manager.c    | 35 +----------
 8 files changed, 16 insertions(+), 123 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 5b22e1c47b2e..9e95acd23889 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -3408,16 +3408,19 @@ static int kfd_mmio_mmap(struct kfd_node *dev, struct kfd_process *process,
 }
 
 
-static int kfd_mmap(struct file *filp, struct vm_area_struct *vma)
+static int kfd_mmap(struct file *filep, struct vm_area_struct *vma)
 {
 	struct kfd_process *process;
 	struct kfd_node *dev = NULL;
 	unsigned long mmap_offset;
 	unsigned int gpu_id;
 
-	process = kfd_get_process(current);
-	if (IS_ERR(process))
-		return PTR_ERR(process);
+	process = filep-&gt;private_data;
+	if (!process)
+		return -ESRCH;
+
+	if (process-&gt;lead_thread != current-&gt;group_leader)
+		return -EBADF;
 
 	mmap_offset = vma-&gt;vm_pgoff &lt;&lt; PAGE_SHIFT;
 	gpu_id = KFD_MMAP_GET_GPU_ID(mmap_offset);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 76359c6a3f3a..3f78e0bb2dae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -399,8 +399,7 @@ static void increment_queue_count(struct device_queue_manager *dqm,
 				  struct queue *q)
 {
 	dqm-&gt;active_queue_count++;
-	if (q-&gt;properties.type == KFD_QUEUE_TYPE_COMPUTE ||
-	    q-&gt;properties.type == KFD_QUEUE_TYPE_DIQ)
+	if (q-&gt;properties.type == KFD_QUEUE_TYPE_COMPUTE)
 		dqm-&gt;active_cp_queue_count++;
 
 	if (q-&gt;properties.is_gws) {
@@ -414,8 +413,7 @@ static void decrement_queue_count(struct device_queue_manager *dqm,
 				  struct queue *q)
 {
 	dqm-&gt;active_queue_count--;
-	if (q-&gt;properties.type == KFD_QUEUE_TYPE_COMPUTE ||
-	    q-&gt;properties.type == KFD_QUEUE_TYPE_DIQ)
+	if (q-&gt;properties.type == KFD_QUEUE_TYPE_COMPUTE)
 		dqm-&gt;active_cp_queue_count--;
 
 	if (q-&gt;properties.is_gws) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 2b0a830f5b29..6aa8b0348bad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -46,7 +46,7 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 	int retval;
 	union PM4_MES_TYPE_3_HEADER nop;
 
-	if (WARN_ON(type != KFD_QUEUE_TYPE_DIQ &amp;&amp; type != KFD_QUEUE_TYPE_HIQ))
+	if (WARN_ON(type != KFD_QUEUE_TYPE_HIQ))
 		return false;
 
 	pr_debug(&quot;Initializing queue type %d size %d\n&quot;, KFD_QUEUE_TYPE_HIQ,
@@ -61,14 +61,9 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 
 	kq-&gt;dev = dev;
 	kq-&gt;nop_packet = nop.u32all;
-	switch (type) {
-	case KFD_QUEUE_TYPE_DIQ:
-		kq-&gt;mqd_mgr = dev-&gt;dqm-&gt;mqd_mgrs[KFD_MQD_TYPE_DIQ];
-		break;
-	case KFD_QUEUE_TYPE_HIQ:
+	if (type == KFD_QUEUE_TYPE_HIQ)
 		kq-&gt;mqd_mgr = dev-&gt;dqm-&gt;mqd_mgrs[KFD_MQD_TYPE_HIQ];
-		break;
-	default:
+	else {
 		dev_err(dev-&gt;adev-&gt;dev, &quot;Invalid queue type %d\n&quot;, type);
 		return false;
 	}
@@ -144,7 +139,8 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 		goto err_init_queue;
 
 	kq-&gt;queue-&gt;device = dev;
-	kq-&gt;queue-&gt;process = kfd_get_process(current);
+	if (type == KFD_QUEUE_TYPE_HIQ)
+		kq-&gt;queue-&gt;process = NULL;
 
 	kq-&gt;queue-&gt;mqd_mem_obj = kq-&gt;mqd_mgr-&gt;allocate_mqd(kq-&gt;mqd_mgr-&gt;dev,
 					&amp;kq-&gt;queue-&gt;properties);
@@ -162,24 +158,11 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 		kq-&gt;mqd_mgr-&gt;load_mqd(kq-&gt;mqd_mgr, kq-&gt;queue-&gt;mqd,
 				kq-&gt;queue-&gt;pipe, kq-&gt;queue-&gt;queue,
 				&amp;kq-&gt;queue-&gt;properties, NULL);
-	} else {
-		/* allocate fence for DIQ */
-
-		retval = kfd_gtt_sa_allocate(dev, sizeof(uint32_t),
-						&amp;kq-&gt;fence_mem_obj);
-
-		if (retval != 0)
-			goto err_alloc_fence;
-
-		kq-&gt;fence_kernel_address = kq-&gt;fence_mem_obj-&gt;cpu_ptr;
-		kq-&gt;fence_gpu_addr = kq-&gt;fence_mem_obj-&gt;gpu_addr;
 	}
 
 	print_queue(kq-&gt;queue);
 
 	return true;
-err_alloc_fence:
-	kq-&gt;mqd_mgr-&gt;free_mqd(kq-&gt;mqd_mgr, kq-&gt;queue-&gt;mqd, kq-&gt;queue-&gt;mqd_mem_obj);
 err_allocate_mqd:
 	uninit_queue(kq-&gt;queue);
 err_init_queue:
@@ -209,8 +192,6 @@ static void kq_uninitialize(struct kernel_queue *kq)
 					kq-&gt;queue-&gt;queue);
 		up_read(&amp;kq-&gt;dev-&gt;adev-&gt;reset_domain-&gt;sem);
 	}
-	else if (kq-&gt;queue-&gt;properties.type == KFD_QUEUE_TYPE_DIQ)
-		kfd_gtt_sa_free(kq-&gt;dev, kq-&gt;fence_mem_obj);
 
 	kq-&gt;mqd_mgr-&gt;free_mqd(kq-&gt;mqd_mgr, kq-&gt;queue-&gt;mqd,
 				kq-&gt;queue-&gt;mqd_mem_obj);
@@ -358,34 +339,3 @@ void kernel_queue_uninit(struct kernel_queue *kq)
 	kq_uninitialize(kq);
 	kfree(kq);
 }
-
-/* FIXME: Can this test be removed? */
-static __attribute__((unused)) void test_kq(struct kfd_node *dev)
-{
-	struct kernel_queue *kq;
-	uint32_t *buffer, i;
-	int retval;
-
-	dev_err(dev-&gt;adev-&gt;dev, &quot;Starting kernel queue test\n&quot;);
-
-	kq = kernel_queue_init(dev, KFD_QUEUE_TYPE_HIQ);
-	if (unlikely(!kq)) {
-		dev_err(dev-&gt;adev-&gt;dev, &quot;  Failed to initialize HIQ\n&quot;);
-		dev_err(dev-&gt;adev-&gt;dev, &quot;Kernel queue test failed\n&quot;);
-		return;
-	}
-
-	retval = kq_acquire_packet_buffer(kq, 5, &amp;buffer);
-	if (unlikely(retval != 0)) {
-		dev_err(dev-&gt;adev-&gt;dev, &quot;  Failed to acquire packet buffer\n&quot;);
-		dev_err(dev-&gt;adev-&gt;dev, &quot;Kernel queue test failed\n&quot;);
-		return;
-	}
-	for (i = 0; i &lt; 5; i++)
-		buffer[i] = kq-&gt;nop_packet;
-	kq_submit_packet(kq);
-
-	dev_err(dev-&gt;adev-&gt;dev, &quot;Ending kernel queue test\n&quot;);
-}
-
-
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 505036968a77..3d2375817c3e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -252,10 +252,6 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 			packet-&gt;bitfields2.queue_type =
 		queue_type__mes_map_queues__normal_latency_static_queue_vi;
 		break;
-	case KFD_QUEUE_TYPE_DIQ:
-		packet-&gt;bitfields2.queue_type =
-			queue_type__mes_map_queues__debug_interface_queue_vi;
-		break;
 	case KFD_QUEUE_TYPE_SDMA:
 	case KFD_QUEUE_TYPE_SDMA_XGMI:
 		if (q-&gt;properties.sdma_engine_id &lt; 2 &amp;&amp;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
index a1de5d7e173a..60086e7cc258 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
@@ -166,10 +166,6 @@ static int pm_map_queues_vi(struct packet_manager *pm, uint32_t *buffer,
 			packet-&gt;bitfields2.queue_type =
 		queue_type__mes_map_queues__normal_latency_static_queue_vi;
 		break;
-	case KFD_QUEUE_TYPE_DIQ:
-		packet-&gt;bitfields2.queue_type =
-			queue_type__mes_map_queues__debug_interface_queue_vi;
-		break;
 	case KFD_QUEUE_TYPE_SDMA:
 	case KFD_QUEUE_TYPE_SDMA_XGMI:
 		packet-&gt;bitfields2.engine_sel = q-&gt;properties.sdma_engine_id +
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index a6e12c705734..67ebdaa9995f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1047,7 +1047,6 @@ void kfd_process_destroy_wq(void);
 void kfd_cleanup_processes(void);
 struct kfd_process *kfd_create_process(struct task_struct *thread);
 int kfd_create_process_sysfs(struct kfd_process *process);
-struct kfd_process *kfd_get_process(const struct task_struct *task);
 struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
 						 struct kfd_process_device **pdd);
 struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 117e524f4fb3..2d01356627ef 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -989,24 +989,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 	return process;
 }
 
-struct kfd_process *kfd_get_process(const struct task_struct *thread)
-{
-	struct kfd_process *process;
-
-	if (!thread-&gt;mm)
-		return ERR_PTR(-EINVAL);
-
-	/* Only the pthreads threading model is supported. */
-	if (thread-&gt;group_leader-&gt;mm != thread-&gt;mm)
-		return ERR_PTR(-EINVAL);
-
-	process = find_process(thread, false);
-	if (!process)
-		return ERR_PTR(-EINVAL);
-
-	return process;
-}
-
 static struct kfd_process *find_process_by_mm(const struct mm_struct *mm)
 {
 	struct kfd_process *process;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index c643e0ccec52..287ac5de838a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -345,7 +345,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	 * If we are just about to create DIQ, the is_debug flag is not set yet
 	 * Hence we also check the type as well
 	 */
-	if ((pdd-&gt;qpd.is_debug) || (type == KFD_QUEUE_TYPE_DIQ))
+	if ((pdd-&gt;qpd.is_debug))
 		max_queues = dev-&gt;kfd-&gt;device_info.max_no_of_hqd/2;
 
 	if (pdd-&gt;qpd.queue_count &gt;= max_queues)
@@ -426,22 +426,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 						    restore_mqd, restore_ctl_stack);
 		print_queue(q);
 		break;
-	case KFD_QUEUE_TYPE_DIQ:
-		kq = kernel_queue_init(dev, KFD_QUEUE_TYPE_DIQ);
-		if (!kq) {
-			retval = -ENOMEM;
-			goto err_create_queue;
-		}
-		kq-&gt;queue-&gt;properties.queue_id = *qid;
-		pqn-&gt;kq = kq;
-		pqn-&gt;q = NULL;
-		retval = kfd_process_drain_interrupts(pdd);
-		if (retval)
-			break;
-
-		retval = dev-&gt;dqm-&gt;ops.create_kernel_queue(dev-&gt;dqm,
-							kq, &amp;pdd-&gt;qpd);
-		break;
 	default:
 		WARN(1, &quot;Invalid queue type %d&quot;, type);
 		retval = -EINVAL;
@@ -1128,24 +1112,9 @@ int pqm_debugfs_mqds(struct seq_file *m, void *data)
 			mqd_mgr = q-&gt;device-&gt;dqm-&gt;mqd_mgrs[mqd_type];
 			size = mqd_mgr-&gt;mqd_stride(mqd_mgr,
 							&amp;q-&gt;properties);
-		} else if (pqn-&gt;kq) {
-			q = pqn-&gt;kq-&gt;queue;
-			mqd_mgr = pqn-&gt;kq-&gt;mqd_mgr;
-			switch (q-&gt;properties.type) {
-			case KFD_QUEUE_TYPE_DIQ:
-				seq_printf(m, &quot;  DIQ on device %x\n&quot;,
-					   pqn-&gt;kq-&gt;dev-&gt;id);
-				break;
-			default:
-				seq_printf(m,
-				&quot;  Bad kernel queue type %d on device %x\n&quot;,
-					   q-&gt;properties.type,
-					   pqn-&gt;kq-&gt;dev-&gt;id);
-				continue;
-			}
 		} else {
 			seq_printf(m,
-		&quot;  Weird: Queue node with neither kernel nor user queue\n&quot;);
+			&quot;  Weird: Queue node with neither kernel nor user queue\n&quot;);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This message is no longer accurate, since this function no longer handles kernel queues at all.</pre>
    </blockquote>
    <pre>I will improve this message, drop kernel queue.

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:d82d8f5b-f1d5-443b-a939-8e25717c6d62@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
&nbsp; Felix


</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 			continue;
 		}
 
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------AGzR2FFc0jjcMJMD1X8b3lAq--

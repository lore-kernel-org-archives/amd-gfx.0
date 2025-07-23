Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8C3C83F17
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 22:28:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C373890FE;
	Wed, 23 Jul 2025 22:28:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y4v+MnNb";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 295A510E048
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 22:28:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRH32+w1/0wBuPhXfaj851r7X6T3kMMTRJxeflYltgknN1cGnuWlBC4pifMgwjemzWa8aGEbRlcXoLkTwhzKOOUF+vlFh9ea4n07JSomcHO61MVJ8axJBXDlIL2nLZz48oVbtPk6puFhAuD0TefnI8ZAuY7+TQZUVWlvyU48CWccYHefebxJYY9gc/+RL+x/Wlzjsv+qHQAAdStmDXnnpuCmts924YKU8Bwgi9r4aQ0bAlSZFDsj3udOI6j2OkwHMbCcWWoq+Saxj4cRYqZMI9EtOVvrRrUPkai12qGmDZD9dqlEeBZEsYSeYja3pgYcm6JrNYgedIq6CiFproVTMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9/SW7iVaSjR5qgE0mOCiu4z9nexiOah+8xoOwTpAp8=;
 b=s6mACsqOqmhOzij4fdbA7xs39O9if0AOEd+suEWQcI2K2ba0a3bxd4v6xWimsjkHaQaQSLh4AXL3ES7bKN/+Ecdl88wkPCzpZF21DCZnvPCsjMfRj5XEPi4pvczcRjSl+ZyZV+CxiCr/4CRSw1+7TI/mAYZY2IOopQ9mnsOdpfe/atXCdT7yzNt965XTtLZU+jD624sQaiO5XLvCscoOZsyxpNR/wugEF/Hu5G4wXN4n02M9q6S/H3DDV50RcwON3ZkfPXupKp7ATUGsBI1B/imZzDmP2gqV6N2VJo+spGq1Ys9UtNSDxK3KM2VrQa1vtepBKaMmaOZXMFyKsLrE7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9/SW7iVaSjR5qgE0mOCiu4z9nexiOah+8xoOwTpAp8=;
 b=y4v+MnNb7uG8v7rj6GZDVpxZhDvUxRlAQFTiav9nN9otBgbn4COiXKE0KqnhbCuoN7ZPwVXkWuInyxK+VidhqV08hwvdMDe+C7Ln5i1LbvOpOSV8LRHYXTWPrB2HUaAEDWpbFAzBxJcRMoem6nO52KxqW2xnpLvtSue4Pf8rhjg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by CH3PR12MB8712.namprd12.prod.outlook.com (2603:10b6:610:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 22:28:32 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%6]) with mapi id 15.20.8964.021; Wed, 23 Jul 2025
 22:28:31 +0000
Message-ID: <9f062061-3d71-4d4d-b544-fea7b9428de5@amd.com>
Date: Wed, 23 Jul 2025 16:28:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix misuse of /** to /* in 'dce_i2c_hw.c'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alvin Lee <alvin.lee2@amd.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Roman Li <roman.li@amd.com>
References: <20250721132236.1292535-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20250721132236.1292535-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0251.namprd04.prod.outlook.com
 (2603:10b6:303:88::16) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|CH3PR12MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 65fe48e2-7f52-4d2a-d125-08ddca384119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGNMTytDbG1vY3pCdTFHYzdtaW9nTlRSUGJ2VTM2N3UycG0yT2JVRG8rY0Nn?=
 =?utf-8?B?UGNJaUVGWDVTb3UrdWpRakFOcDRnM1p3WDROcitPaVVidjJXNDZDakU3K3hU?=
 =?utf-8?B?SnBKMEZQeHZJR2o1R09GWk9XS1JhWUNOMjdIRjlGaG5MWlJJUmJDYmcvZkVl?=
 =?utf-8?B?am5BS2dHandvaThUeWVzbVo2ck5tVndSaGRvakNETGlwYlJGU2hzMEdQYWhp?=
 =?utf-8?B?WmJBcFRDQlJDdkNyYnU0UE0wc3R5cGJYTXEwUjlNZHFJSklpNDhiaWRLS2tj?=
 =?utf-8?B?MmZ2UjFJK2daN2NmbnYxbzAvS0FnVUFLcDJLMmNVamg3aklKaHFEVFM2bnFj?=
 =?utf-8?B?YlZGVVV5ZmxJNzlqYkRxay8yeWIwQVMxOUZwV3RtOHVXNVZSMU9BTWFXZGh4?=
 =?utf-8?B?ellnZU95SnJhSjJmcjJLV0M0UWlyS1BQWWtST3NHQ2JRazR6RkxXSHYwWWps?=
 =?utf-8?B?SmpBTm9jNTlkbXRxWFNpc0lrNkxYczQ1U0UwZXVTZXphMUFvMkxwNGN0dUlC?=
 =?utf-8?B?L09oMWoxaG1NelViN3hOWTE3WjFGWVg1UGhnRjhsdTdwU09PVC9UV3ZRUGlW?=
 =?utf-8?B?Rm41N0NObEIvc0dzd1lFc1c5VkdUemdPVjB0RXYzcDg3VDcrUXpoRWxOeEM0?=
 =?utf-8?B?b2Ntd1J5TDEzYTVnSjJZZHY5NzBSa2NnYWZwL3VKb1NqVWpNTkppTWhtRFVR?=
 =?utf-8?B?Nk9NaDJkT3N5N1Q4MUJyRHFrNTBQWVBYVXljQmIwSHBjQVd3SXB2eGIxbmxx?=
 =?utf-8?B?M091cVk2bC9sREY0YUZPelZ3aXNMNW5jeVoyUk9wSit5WTlHbmtSRUdjcGhC?=
 =?utf-8?B?T0JNbGltZjUySmZrUjNIMDBCSnBob0Z6Z3ZlazhReGtLdE5mZGx3S1dsQ1Rn?=
 =?utf-8?B?YkRmcGxtaGYxYml4Wk92cWlNVVgxaElxbFRLWFk0ZHBIczNkNUIxTTA1c0ht?=
 =?utf-8?B?NjlNSk4wcTQrODJNRzcwQmdpNDBKWktad2F2MHhqeGhYNXFkNlcwVllvclo0?=
 =?utf-8?B?aitsRGVIN2ZaYWh0aU5SaGFJcUlmR3RBWUJEM3VjZDFxc1VCbXNvcEZRZ3Fv?=
 =?utf-8?B?Y0s2ZjVZTnB3TlA3OUFZcEdZVWI1OExIT0tUQURORDd5VXNpMWlzY0ZCTGdk?=
 =?utf-8?B?VmJHWWJQc2JGKzg2NG9pNGtNRzkxbXlLOGQyc05pdTlESmwxQ1pUaHJwWkZt?=
 =?utf-8?B?VS93TGp4Mi93ZVdWLytIU1dQOFZZdVYvaTdNdloxOWZMV0Z3Z2FZbDBrUmpP?=
 =?utf-8?B?a3N5SVhObkFHeGtmbXF3bU1rV1IzSWxPL1hTRWI1TlhuSm9jQjhRUFZINkoz?=
 =?utf-8?B?T3RoZnY0OFBUNWdGTnNZVU9abnVveUpYYy94UVBYNmQwMXphU3BNQktLUUNW?=
 =?utf-8?B?czRZOVZHRVVqUS9qVmFYcmNHQTdIRkgwU0hoNGxaQWZTZDVoT3ZFclRub3Rt?=
 =?utf-8?B?Zkh6ZGtMWVpKdzVzcnhHYk0xMVg5ZFpZdEhzS1ZHR2xPNHkwTENrWHFUM3JR?=
 =?utf-8?B?WU1pbGRrTWwveFZhYnJYa0lnTmZVTVVLN08yM1ZTNTI1Y1NhZmxPQXBKU2Nx?=
 =?utf-8?B?dVdDUHB6Wjljd1pOeStyRXFObGdKYUxSM0FIT3VRQkZoc0lLZTBVanBXTDdm?=
 =?utf-8?B?dEl0Z1pHcXRkSTRIdWZ2NzVoR1pGTlVCODVZYVBxWjJuaE5JUzRoZTdIdUdH?=
 =?utf-8?B?RGVOSlg5OHN6MGxaT2xmZDlyRzlUaFdPd0hFZ3VkSmpobTVhcGJkL3Nobk5W?=
 =?utf-8?B?N0ZkMTZTTGZMMjg3S3NyUml3OVVtQ0pHTmloaWFGYXpsb1BzZllVemVQUFo0?=
 =?utf-8?B?K25Sd1Fpc1dKWlcyNVY3b0kyR0tUWkJoM2FlcGE0cTYzQllEVWw4dm5pZVFP?=
 =?utf-8?B?REo5VnpacVR6ZVorTDNGbDZDQ2NOS2p0Qzd4RThXdjFSZUZ4WHVhSzRadi9R?=
 =?utf-8?Q?ssIxiKGS/F4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE9zVlVrRWVHN1I0Wk1KQk4wY1M0ZFovRS9BN2xGWUp1NkxzaGY0eUsyMlNp?=
 =?utf-8?B?bm4yY08xZGV1d2R4cko2R1d4d0tHUXFaOHM5bDhqR3JuWHVhUmQ3emErSk9M?=
 =?utf-8?B?aUI4OUNoL2JwVEpzb0NYcElFa21aeVpIa0J3UlI0UGhpdVA1bGZLSDZPQ1pi?=
 =?utf-8?B?b210WTd3cG1YQjhqWU1DTXlUa0kwTi9pTDlqZEsrV1VpbDE0d3ZTOEtuSGZw?=
 =?utf-8?B?aXRqOFhEYUI3VUxRVm5mcEpzWnZlNW90YVdTMkZ0c2NKcGROODI2dlV4bmND?=
 =?utf-8?B?bWhJV2orbEoyeVhTV0J5N0lQNXZ0dHNXYUFjdkcrN2x0ZjJiU0M2M0N0dWMx?=
 =?utf-8?B?RHZwVnlNYjBPK01JclBxSjhKVjhhcGV4UmxEMzhEUHlXYyttRHpzZkxCa0Rt?=
 =?utf-8?B?NCtYYk5OZmV6czc0Q3BOeGVLeEZWZUdqZnpyMmI0aXpYMHdKMzRWaWV0aEsz?=
 =?utf-8?B?Z0pxRDZ0d2FjV2gzaHJXL29JZFlRSTlrMHoyUHhqaS8xc3R3czVFWGo4dmJo?=
 =?utf-8?B?L1JuUkpjNEoyVS85aERBRFFMNTQxVjUxYmJDQ1B6SzJUcDBnenRLRXF0cE0z?=
 =?utf-8?B?VHcwRElFV1owRyt4cE1mcUxWcGxjdVBjWjJBSlczSGhZeENuZ1RMSGJkNkI0?=
 =?utf-8?B?Z3BUOHJucUduVkVuZVZHVTczeGJoNC9JMWcrSVZXb3lFL0dUKytGQUdaUUJQ?=
 =?utf-8?B?bEhzZ3ZERENjdkQvSmV5NVJJYVZFVk1jeXN3QWxsR25OeDVrVGlqOFhuTEdq?=
 =?utf-8?B?YjFhbUhkWGRqVnNZcDNKMXBVSkdSamdLMmNGaXpJY0pGZjQrZ3lDLzkwT2dt?=
 =?utf-8?B?NjM1WHA4Q2N3SW9XL01yMnFOS3pzTk5JZ2dJV2h1OE5hSWJtenV4dmg2d1FI?=
 =?utf-8?B?UUJSQUFCd1dLOWV2VnBmY01jQ3dtWTV2UjVOM21Ca1hRQ3N5a0pFdnJMeTB4?=
 =?utf-8?B?SE9tSDhiOU0wSTdtbU4rckxiVU5tTXZTS25mRkFDQTFsSko2NitWOVZ3Q3Vn?=
 =?utf-8?B?SkkzN0NJMFE0UUtPdEZ0R2IxdWlkcEh3b1FQT3lHeHlpdkcvbVdiMFFhQ0JI?=
 =?utf-8?B?YXIxUUJCRGhQSUtBOEdsYmJKLzIzdWVHYkRrU2FjSFNweWdXWjhVcFNsV3Vu?=
 =?utf-8?B?TVFyR2xkTTdvUnd4OC9lZHFHQmpJZ01VQVMzUjE5NWhGUXBKRldjU0FxaGRK?=
 =?utf-8?B?MlJ6ZEFTZXZrOHgyeFl6c1lndGVERHIzWTh0NjJrM1dXRW9GUXIyNXVqYmZv?=
 =?utf-8?B?RFFmR2FCVkZiZVVDZnpKc2k1L1RNZ2hDb1crZG1MQkRiZjNOVHFvMkJLWFJ1?=
 =?utf-8?B?UjZMMm5nN2d6RlhDR3Z5dnVraDdYMnp6Unp1cWhXV1VMZ0hxK0NMdGJXMGJM?=
 =?utf-8?B?MTZGck1xdHNQSlB1Tmx1bmp3UUFPQk1XbVRSaWVieXR2aDd5RFoxVUdNdzJL?=
 =?utf-8?B?amhyZEZIMEFCa0dQNWxTMVVMM1J0K05kSDhzSUEwTHAxbXhiSzE2cEcrTW1U?=
 =?utf-8?B?WFBacUxSeUh5b2t3M3RxNFpFRmFKVXVvc3BWVGNCVEJCcEhhU1Ara2dmVG1x?=
 =?utf-8?B?bzYyRzBDZUVqM01HcnBBM2lZNWdyRFJoSDF5RjZndDBNWktXakFTLzNsUmRx?=
 =?utf-8?B?UnByZkhac0ZTQ25GZUNnN2REN1ZuWGJuSlpCbXFaMTdVaWoxL1NGNEI2bVBv?=
 =?utf-8?B?QXY5MlJ2bENtOW9wUmtsbDdIRFY1QTB6Uy9hOTNtMnBsYys2dzVKRzRQN1J6?=
 =?utf-8?B?emcyd0dJK1NjWElNelYvNzdTTzhiczJuZ2x5M2xxZTd4QW54eG1taVZxOWw3?=
 =?utf-8?B?U1RYeFdMZU10VHBDeUlWekl6UTNhaElJaWE3TEdHd0ZZNms2aXhQcklJb0NH?=
 =?utf-8?B?alNwNTl6dGF0U0dBYlA2YnZDOXpvREFHelQvMnRnZ3V5aFFGQmxRbWZIcUhZ?=
 =?utf-8?B?ZVYvekd0c3FHVk5MU0VocEUxc3pmNEZkaHpQbjNOZTlnQ0FQdnFodkJudWNS?=
 =?utf-8?B?dHhHUys4L3ByYUhwVEd1Mnh0Z1IyMm0vVEtQZnlERWhJZDQ3bS9lajBYaGx5?=
 =?utf-8?B?QWx4cjZXOEVVTkJsOXlscSt1UWpmcVZwRTUwcklBdnNBdWxla0JBZ3FxWTli?=
 =?utf-8?Q?5u+oHtoSpM8Dvwpd+QU8ADDWq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fe48e2-7f52-4d2a-d125-08ddca384119
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 22:28:31.8047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eSr05ddewTPw9nA9Ze+zgEyf+bpZWxksjXdcytPju/3Y56sJfWxmLlN86uOavKJtDFR4RPzyK7ljZJgXnosEnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8712
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 7/21/25 07:22, Srinivasan Shanmugam wrote:
> Fix the comment style before cntl_stuck_hw_workaround() by replacing
> '/**' with '/*' since it is not a kdoc comment.
> 
> Fixes the below with gcc W=1:
> display/dc/dce/dce_i2c_hw.c:380: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> * If we boot without an HDMI display, the I2C engine does not get
>    initialized
> 
> Fixes: c9130176a41e ("drm/amd/display: Workaround for stuck I2C arbitrage")
> Cc: Alvin Lee <alvin.lee2@amd.com>
> Cc: Dominik Kaszewski <dominik.kaszewski@amd.com>
> Cc: Ivan Lipski <ivan.lipski@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
> index 4e06468a6284..0421b267a0b5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c
> @@ -377,10 +377,16 @@ static bool setup_engine(
>   }
>   
>   /**
> + * cntl_stuck_hw_workaround - Workaround for I2C engine stuck state
> + * @dce_i2c_hw: Pointer to dce_i2c_hw structure
> + *
>    * If we boot without an HDMI display, the I2C engine does not get initialized
>    * correctly. One of its symptoms is that SW_USE_I2C does not get cleared after
> - * acquire, so that after setting SW_DONE_USING_I2C on release, the engine gets
> + * acquire. After setting SW_DONE_USING_I2C on release, the engine gets
>    * immediately reacquired by SW, preventing DMUB from using it.
> + *
> + * This function checks the I2C arbitration status and applies a release
> + * workaround if necessary.
>    */
>   static void cntl_stuck_hw_workaround(struct dce_i2c_hw *dce_i2c_hw)
>   {


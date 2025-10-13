Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8ABCCD185
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 07:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3E8B10E3D2;
	Mon, 13 Oct 2025 07:12:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GEyq79wx";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013062.outbound.protection.outlook.com
 [40.93.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51A5610E3D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 07:12:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXhr+nxW8kgJ57kmGMEyzuNzSBlxaOAhIOKqb8zZzMhMdt/KuFS7AiMIJFJCV/U6N5K26QNbO8Ov9W71FFOy6HB9+68FV6du4TiRTbIi+S9RwbQqreXJw9WQYo/3W+jtN/5h0AVlsjmBGPndT0T2JgN3UuXcIW3sne0f+T98l0BJ+7+X3qt28r4pS1t///7Ug7xaFyira1+oodO/vyVT0FYvJ1frnisgCZItQ0ovhqlbMj6avWLxtO4Zms9C8v9YG25WqDjJFarZVy2yiI87s+ewgkScrsxLO0bXTNww53aXNKOpcMcrzM3MluC58UlLR/NHSgXtARjSn8y6J5uhgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xt4bj3VWhgblsE8r4jibWVYJ1phsGtdWYu3F3dcmX+c=;
 b=yP76PHUgoKpi/QNUYTVfOmsxjrxMidBf20QEaUWq7sTDCVNIRDb4uJeYmxMdX6NyQNcZvY5em2p0zh5YFiScPdH8kcvxzEx0sVXvJNuaxgg4fIxl3X+za692BmXSx9BeseME3XxeVNKw5mlu7tmo2NQJtGKpkiJkjwx/LawZ4rl5Jeww/saShy51fHLxYceb9xKO/QrMCJVCWIMCpmlRCtUTvYP/qj+ROWfo2EP1WU0Jjpl0bmXjZ5BKG0Uec6bXecBmeK6i+BmmbBBG5kSzOcIH1JUgVQnUF9jhqctY5aUFGnrsrxekTRwkdp5qCyPd6kqY4aLI1Gk4XCOJJZR9Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xt4bj3VWhgblsE8r4jibWVYJ1phsGtdWYu3F3dcmX+c=;
 b=GEyq79wxDpjrOUq7JRa7L4bveAVB4sicxE+qGcTRACcpi4Gob7dbdwzgkD8V8SU8hPh9QXfthwnoyvu3sG6WxOycTPd/+3/iZbplyfRUWjcS5dZ59yp53BLRXF8v5TiPcGjtRehDWBY3bcv13DQLVVfOaIlJa7tlNM4Rz24VQcE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Mon, 13 Oct
 2025 07:12:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 07:12:25 +0000
Message-ID: <af6a5ced-07e7-400b-83c5-613ed7f06a30@amd.com>
Date: Mon, 13 Oct 2025 09:12:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 1/2] drm/amdgpu: update the functions to use amdgpu
 version of hmm
To: Sunil Khatri <sunil.khatri@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251010140712.3983709-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20251010140712.3983709-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea7dc30-b30d-46a2-57e9-08de0a27dc72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTlLbEJjanJYVEVtU1RBMStVUHhZUjBIbEFqMjRRZDlRdEx5bGpIV3MyTzBB?=
 =?utf-8?B?aDN2dE5leU8vYWZXaXlvQ1pHMi9VdHJSRmVUNVlEQnBkRUo5Tm5zSWhBOVcw?=
 =?utf-8?B?UFcwMDdEaEQzQnVZU1k2c2M4TFphQTVZdlB4bU9GekJlL0k2N296WWNjbXJr?=
 =?utf-8?B?MUZqOXZpdnJSNjIwWVg1cC94R1FXTnBpVldwK3N4a2l5MXF2OHVENVpzbTND?=
 =?utf-8?B?eUd4V1FNSGtFZXd5Tmc2M0Vvb2F4ZlN3UnpCekhuY3ZpZlErN3BZdjJ2SGNM?=
 =?utf-8?B?dnJsSGcrZVJZWHhzenFMR1V2ekt6VlFraEthdWJ5Y3dhU3FFYnphOGtSeWVJ?=
 =?utf-8?B?VldoUzVPemZlRDBza0dNbEpjTy9TZkxBV1BXNTk3Y25xV0Nud2IrS2Uwemx5?=
 =?utf-8?B?RXNWNUZac2xaY1RnQVpRM0Q3RUVsWWp2QUtXY0MrZTY3TVBNSTY4Q1N3U1ps?=
 =?utf-8?B?b1phQTVic05SUDNINTNZZUxwaW1JSXlkcXlmV3N2Rk1zS0hjSGJSMGc1ak1Y?=
 =?utf-8?B?K1ZqMXowN1NtdTFmdzRsYnJnTU5TTzBKMXNmWk12N20zOVhDVFlkWUVHSkZz?=
 =?utf-8?B?dE9wSXVOLzJNL1RQMmpDNGtXTUFLcnhWUVlrQllyb29BWTdkNSt1MWNSMWRU?=
 =?utf-8?B?RWxBMVRQSTQ3Ynd1b3RONXZPcUcxUG94dDVCcDM2bGkzOVB4TnA1RThHVFhZ?=
 =?utf-8?B?QzBXZmZPZUVzWWozVytsNnhMbzJOMlBUMHFvUGowUlV2YmtjRHRjcmtLMzJW?=
 =?utf-8?B?TXJNbHNCcnBEY0loU3pCcmJuK29BRU9kVkswN2R3U1Z4MGlCZXEraEJTNC9q?=
 =?utf-8?B?WTlTMlYwY1NzSFFxNC9pTCtMTDRyQml1Ly90c2lHa1dYdXpQY3VDZmxTU2xk?=
 =?utf-8?B?SkxZVEFlZHo2cFZmZjRIVG9CcC9ibFhGUXJQWE1PbXBMTkRBM09pclhtZmJr?=
 =?utf-8?B?Zno4Y3Arekhsdlh3bUNEcmFJNWptNHUvTGxjeW5tQ1BUcnZXOWR2ZnVQaXg5?=
 =?utf-8?B?NFhwV1NqWjVFemVYeXFqM0YrUVZ1dlp4RFpGUDNzQjVRdjV5UjVtMlNtQmZL?=
 =?utf-8?B?WHRYMHl5VzhZU3ptSGsvRVJma1RGUFBKdnFBUVdGeGRZK0JoZFhqR09EekVn?=
 =?utf-8?B?cytSSE94NzNsSE5sclBTMkhmS3hhZStweVpHbExtY1V2UHhvdzFDMHFQVlE3?=
 =?utf-8?B?V3dHUkRJUXc2TWZBZ0J0OElGa0gxOVA5cStramhoWURuYWl0SkxHL2wyVjJy?=
 =?utf-8?B?MVpZVzIvWGU1aDRUdmI3ZkpQUk9BTGRMekJ0OHhVUjBQeGRVNFNZc1dsemRr?=
 =?utf-8?B?N05CTGxFMmlOOXplUU5ETXd6V0VKNlI3dis5NVRuOWJzV0xPMlduTml2ZlBJ?=
 =?utf-8?B?NE4vWk9aV3BHTWE3NGZFNDhxQ0h5SzZCclE5K1o0dER3VVB5SXBNbzZtSERr?=
 =?utf-8?B?dWp4ZkpRUDFqZUgvVHRjTlQ2cTFmVWlSMmorSXZHY3ZFRUZOWEk3d2dSaStL?=
 =?utf-8?B?eWRuNU5LRzZiLzJNc0JhVlFKYjR3YmNtV1RBbDNSOWwrYit1cmhOM2c2WWJX?=
 =?utf-8?B?bEt4K2RSa1QvbDAzZnBDdFFhVklPOGtYQTNGeWEwaEprdk1FVVM3WmpCcHd5?=
 =?utf-8?B?L1Q1L21zR0dMb3I5eG8rRTlGbFpxSlBobHpnU2VqcHlmNE5BUW9LYWhrdjZR?=
 =?utf-8?B?TGdtSUpVMlRSZExWTWdjcnBvYmoxMjNsNCtmTkVXeURZeWlDc2Nid3RYa084?=
 =?utf-8?B?eUsyTXdscDZpbWpLV0JyMWhxbnJ6TitPRkxYcDU5NktqM3RDb3VBTUx3VDU3?=
 =?utf-8?B?REFwWGVsQkFvOTV5NjhRSWhEVXdWbGpYMUJFV29taFF1RDBZSTliMTMrU3Fo?=
 =?utf-8?B?b0lkek96T0FSYUdIZ0pNM1RxOW1kSGdmaGRuK0RQUS83R214U1Yvcm53QVNB?=
 =?utf-8?Q?NMFxYU7TVt5vijKZY5eRFw9GBnuKooed?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnJBV1ZQZ1RYb0g3Ykx6elB3Y0V3UndleGZLSnh2WjFnWG55N2hBc2VWRWdm?=
 =?utf-8?B?MkE5L0NnRG9BNTVWWEt6N1VZTjVJeFV5cFhYckpHTjZpWXFSemd3dGVtdE5I?=
 =?utf-8?B?VFUvYityM1U4bjdpVmNDM2R5Wk01UEpaY0Zxajg3TUNUN243MWVEUDBoQVRY?=
 =?utf-8?B?ZFhiK2k0RlV5dXlhY0c1NTFIL0draFNRYUc3eXNEMWtRNHZMczYvMFlNS2RJ?=
 =?utf-8?B?VWsrakluVldHSjh1L0VPTlQzY1Y4OElRTXNXa2JiVS9yODVEc3p4WFZEZzh5?=
 =?utf-8?B?ekhsa0tEV1FzOXJpZGcvOUFkRXlEUHlaejROM0d4cHF1VU4ya05WV3RrSGVH?=
 =?utf-8?B?R3lUbU12RUl0WnI0YnZTbndua1JIeUxvY1A1NlozMlVCU0V6dFdTdE0rMksz?=
 =?utf-8?B?Uk9aTHhKdzFmaEVNNDhOZXNCN0tZeTNCVmxGNjkzU3hEVFFvMnlLUTltbCts?=
 =?utf-8?B?QXBnVmIyQ1FWSmlzdmtKTHhBeUVmOGFRSHl1Qk9zaUpxVlQ3dVFWNzBEdU95?=
 =?utf-8?B?ZmNXZHh0cHZnQzhaZ29tMFpMdUJrVjlzNUJrNkQyRkdzOHd1SVdUVUU5RHFs?=
 =?utf-8?B?S1JJbFd1OW1nQVFyYlViSTgzTk1GQVNjTmRUVHpNd2pNNmRKZHZZRHVSYkVv?=
 =?utf-8?B?U0ZLbEIxdkFkZ2dXLzhvLzFJMUkvTGpGaU85TGQwUjNlVG5aS25rQ1lmMjln?=
 =?utf-8?B?WDI0VzhqcXVqK1NiUHlqVXZmUjF0d1pra2tTLzRwVFFSN08yN0w2K0JaZUlN?=
 =?utf-8?B?a1c1dmwwakNDZUtmeEdDdWgzMGUrcGVxVFllRnhXM0w4WlVaVklzRWxLdnA3?=
 =?utf-8?B?VjlCZGZ3ekgwaU9VZW1ETnZZM1BieTRoSXlIWVFsQS9mekN3aXpab0R5L1Qv?=
 =?utf-8?B?NFBTMFZlNFpQRDRSMW1ranlraVRMT01sNVRZekRqZG9KV3FKVW9XVFR3UkUr?=
 =?utf-8?B?VHRFVE5jUS8yTUIrR2xjQmF6cEwzcjR0R0FQZzJ6eS80Y2h3WU1aRXhNelFW?=
 =?utf-8?B?eWFLZi8zODE1cHFNZnloM3FWS0dkaUgydWhmUmxCRFVqV21jN0JQTUhaWXBG?=
 =?utf-8?B?OE5XRWdLaGU3NjNVTmZoUEtGcUZ2UytuUXV0cGtpWkJYWVh3Vy9paHlZSWQr?=
 =?utf-8?B?c2J0eWQwQ0E4Q2pzZEJRRThMUE9HWEpucmU4cGNmR2NvbW44YTZYUWhJR2ZY?=
 =?utf-8?B?eHh6MTFuSmQxY01NbDNaTnBTNXY0V3h2RWxFSFJmTUxyN0hlQTk1RjN6dUJs?=
 =?utf-8?B?Rjd0WTVSN2o2Sm1zQlZwR1p5WGRKSUJVTDBobEtuZUhKWEFYWlh0WnJTcUN3?=
 =?utf-8?B?SGVEVDBRM1BkeDBBN0FxY2FlOGwrVVc5NzZDSlhkYmVqdFpOVDNXQnpQY1Mw?=
 =?utf-8?B?eENPa3IzMW1OUERaTkE4Q3JqTHNIUS84bmlpcWcyR0FZTW1WeVE5TlZDVGVV?=
 =?utf-8?B?TllKbCtvNnBZS3NTbXpiT3MwSXE5WGQvcmd3WkNPaVI3UkJGMG5DOWw2YTNS?=
 =?utf-8?B?bEtKRWlqMUJUeUhrcmtmdEdOa0V1Yi9SRU9aVHJvalZoV1F0bUhHL3pCR1NF?=
 =?utf-8?B?TEJ1ck5UTTB3aE1XRkxSaVFlWUJDazM4RzdzUFJQV0tNNjRlRmFOUFFnZDNB?=
 =?utf-8?B?bEc5bWkraEN4L0FFS3l0WnhEaHZiaTlKdFZwZE1Sd1YxSENDOWQ5UkdRaDdQ?=
 =?utf-8?B?akE0SzRwSEdSempzaHJRMmVKVWtzZmFFSzZvNVcwWm5XQ3pocEZGUm1INGx0?=
 =?utf-8?B?QlpNaUt1R2F3Vlltc2w5b2h1Kzhwd3kzVWsyOE15WTdobW53eTRtTHpFUWV1?=
 =?utf-8?B?N0c1Zk9UUlRhZzNMK013bktDSWZFd1RFNE1xdHdBNElFZVpjWHVlbFAySzNp?=
 =?utf-8?B?UCtlWnpmSVNTOWdTQ0k5NFVjWmVNdmZqK3hQVHZQYmpHMnh2Z3pVNkZ6SDFl?=
 =?utf-8?B?WTh4YkNDYzA5cFFMUXdhWTNJNjdYaWZISEJoT2FWM3B2NWMzcjlVYVNmMytX?=
 =?utf-8?B?SGVra0I4U1o0dmFHZk1TTkVTcnRuNlBRVnBqNUt3UmpHZnBWVFkydDZNaExl?=
 =?utf-8?B?T0FoTEdoUjN0bjV3V242amVNTUtEMGpTWFpaT1JXb2V4ekVjRkpRTEM3U2RH?=
 =?utf-8?Q?Y0ABuK1Gn/A7DElAgYaEbrspa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea7dc30-b30d-46a2-57e9-08de0a27dc72
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 07:12:25.5798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pSFlnhunoV8FLOFXkXbnLmJtEg916CXZ+uF0fjXiLi5wDC39A6v1T3SnX0YSY704
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146
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

On 10.10.25 16:07, Sunil Khatri wrote:
> At times we need a bo reference for hmm and for that add
> a new struct amdgpu_hmm_range which will hold an optional
> bo member and hmm_range.
> 
> Use amdgpu_hmm_range instead of hmm_range and let the bo
> as an optional argument for the caller if they want to
> the bo reference to be taken or they want to handle that
> explicitly.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  6 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  6 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  4 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c       | 36 +++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h       | 19 ++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  6 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  7 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c      |  1 -
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.h      |  1 -
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 14 ++++----
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.h          |  1 -
>  13 files changed, 61 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 9e120c934cc1..8bdfcde2029b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -71,7 +71,7 @@ struct kgd_mem {
>  	struct mutex lock;
>  	struct amdgpu_bo *bo;
>  	struct dma_buf *dmabuf;
> -	struct hmm_range *range;
> +	struct amdgpu_hmm_range *range;
>  	struct list_head attachments;
>  	/* protected by amdkfd_process_info.lock */
>  	struct list_head validate_list;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 22c1bdc53d2e..56097fb6eecd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1057,7 +1057,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>  	struct amdkfd_process_info *process_info = mem->process_info;
>  	struct amdgpu_bo *bo = mem->bo;
>  	struct ttm_operation_ctx ctx = { true, false };
> -	struct hmm_range *range;
> +	struct amdgpu_hmm_range *range;
>  	int ret = 0;
>  
>  	mutex_lock(&process_info->lock);
> @@ -1089,7 +1089,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>  		return 0;
>  	}
>  
> -	range = amdgpu_hmm_range_alloc();
> +	range = amdgpu_hmm_range_alloc(NULL);
>  	if (unlikely(!range)) {
>  		ret = -ENOMEM;
>  		goto unregister_out;
> @@ -2574,7 +2574,7 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>  			}
>  		}
>  
> -		mem->range = amdgpu_hmm_range_alloc();
> +		mem->range = amdgpu_hmm_range_alloc(NULL);
>  		if (unlikely(!mem->range))
>  			return -ENOMEM;
>  		/* Get updated user pages */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> index a716c9886c74..2b5e7c46a39d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> @@ -38,7 +38,7 @@ struct amdgpu_bo_list_entry {
>  	struct amdgpu_bo		*bo;
>  	struct amdgpu_bo_va		*bo_va;
>  	uint32_t			priority;
> -	struct hmm_range		*range;
> +	struct amdgpu_hmm_range		*range;
>  	bool				user_invalidated;
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 087e5b5497e4..87872c0282e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -29,7 +29,6 @@
>  #include <linux/pagemap.h>
>  #include <linux/sync_file.h>
>  #include <linux/dma-buf.h>
> -#include <linux/hmm.h>
>  
>  #include <drm/amdgpu_drm.h>
>  #include <drm/drm_syncobj.h>
> @@ -886,7 +885,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  		bool userpage_invalidated = false;
>  		struct amdgpu_bo *bo = e->bo;
>  
> -		e->range = amdgpu_hmm_range_alloc();
> +		e->range = amdgpu_hmm_range_alloc(NULL);
>  		if (unlikely(!e->range))
>  			return -ENOMEM;
>  
> @@ -895,7 +894,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>  			goto out_free_user_pages;
>  
>  		for (i = 0; i < bo->tbo.ttm->num_pages; i++) {
> -			if (bo->tbo.ttm->pages[i] != hmm_pfn_to_page(e->range->hmm_pfns[i])) {
> +			if (bo->tbo.ttm->pages[i] !=
> +				hmm_pfn_to_page(e->range->hmm_range.hmm_pfns[i])) {
>  				userpage_invalidated = true;
>  				break;
>  			}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 82ddc8c22b64..ce073e894584 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -530,7 +530,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>  	struct drm_amdgpu_gem_userptr *args = data;
>  	struct amdgpu_fpriv *fpriv = filp->driver_priv;
>  	struct drm_gem_object *gobj;
> -	struct hmm_range *range;
> +	struct amdgpu_hmm_range *range;
>  	struct amdgpu_bo *bo;
>  	uint32_t handle;
>  	int r;
> @@ -571,7 +571,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>  		goto release_object;
>  
>  	if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
> -		range = amdgpu_hmm_range_alloc();
> +		range = amdgpu_hmm_range_alloc(NULL);
>  		if (unlikely(!range))
>  			return -ENOMEM;
>  		r = amdgpu_ttm_tt_get_user_pages(bo, range);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index b582fd217bd0..9da1c5c69632 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -168,12 +168,13 @@ void amdgpu_hmm_unregister(struct amdgpu_bo *bo)
>  int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>  			       uint64_t start, uint64_t npages, bool readonly,
>  			       void *owner,
> -			       struct hmm_range *hmm_range)
> +			       struct amdgpu_hmm_range *range)
>  {
>  	unsigned long end;
>  	unsigned long timeout;
>  	unsigned long *pfns;
>  	int r = 0;
> +	struct hmm_range *hmm_range = &range->hmm_range;
>  
>  	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
>  	if (unlikely(!pfns)) {
> @@ -226,25 +227,38 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>  	return r;
>  }
>  
> -bool amdgpu_hmm_range_valid(struct hmm_range *hmm_range)
> +bool amdgpu_hmm_range_valid(struct amdgpu_hmm_range *range)
>  {
> -	if (!hmm_range)
> +	if (!range)
>  		return false;
>  
> -	return !mmu_interval_read_retry(hmm_range->notifier,
> -					hmm_range->notifier_seq);
> +	return !mmu_interval_read_retry(range->hmm_range.notifier,
> +					range->hmm_range.notifier_seq);
>  }
>  
> -struct hmm_range *amdgpu_hmm_range_alloc(void)
> +struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct amdgpu_bo *bo)
>  {
> -	return kzalloc(sizeof(struct hmm_range), GFP_KERNEL);
> +	struct amdgpu_hmm_range *range;
> +
> +	range = kzalloc(sizeof(struct amdgpu_hmm_range), GFP_KERNEL);
> +	if (!range)
> +		return NULL;
> +
> +	if (bo)
> +		range->bo = amdgpu_bo_ref(bo);

The functions amdgpu_bo_ref() and ...

> +
> +	return range;
>  }
>  
> -void amdgpu_hmm_range_free(struct hmm_range *hmm_range)
> +void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range)
>  {
> -	if (!hmm_range)
> +	if (!range)
>  		return;
>  
> -	kvfree(hmm_range->hmm_pfns);
> -	kfree(hmm_range);
> +	kvfree(range->hmm_range.hmm_pfns);
> +
> +	if (range->bo)
> +		amdgpu_bo_unref(&range->bo);

... amdgpu_bo_unref() have intergrated NULL checks. So checking it here is superflous.

It would also be helpful to have some kerneldoc on amdgpu_hmm_range_alloc() and amdgpu_hmm_range_free(), but that is not a must have.

With that fixed the patch is Reviewed-by: Christian König <christian.koenig@amd.com>

Regards,
Christian.

> +
> +	kfree(range);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> index e85f912b8938..140bc9cd57b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
> @@ -31,15 +31,20 @@
>  #include <linux/interval_tree.h>
>  #include <linux/mmu_notifier.h>
>  
> +struct amdgpu_hmm_range {
> +	struct hmm_range hmm_range;
> +	struct amdgpu_bo *bo;
> +};
> +
>  int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>  			       uint64_t start, uint64_t npages, bool readonly,
>  			       void *owner,
> -			       struct hmm_range *hmm_range);
> +			       struct amdgpu_hmm_range *range);
>  
>  #if defined(CONFIG_HMM_MIRROR)
> -bool amdgpu_hmm_range_valid(struct hmm_range *hmm_range);
> -struct hmm_range *amdgpu_hmm_range_alloc(void);
> -void amdgpu_hmm_range_free(struct hmm_range *hmm_range);
> +bool amdgpu_hmm_range_valid(struct amdgpu_hmm_range *range);
> +struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct amdgpu_bo *bo);
> +void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range);
>  int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr);
>  void amdgpu_hmm_unregister(struct amdgpu_bo *bo);
>  #else
> @@ -52,17 +57,17 @@ static inline int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr)
>  
>  static inline void amdgpu_hmm_unregister(struct amdgpu_bo *bo) {}
>  
> -static inline bool amdgpu_hmm_range_valid(struct hmm_range *hmm_range)
> +static inline bool amdgpu_hmm_range_valid(struct amdgpu_hmm_range *range)
>  {
>  	return false;
>  }
>  
> -static inline struct hmm_range *amdgpu_hmm_range_alloc(void)
> +static inline struct amdgpu_hmm_range *amdgpu_hmm_range_alloc(struct amdgpu_bo *bo)
>  {
>  	return NULL;
>  }
>  
> -static inline void amdgpu_hmm_range_free(struct hmm_range *hmm_range) {}
> +static inline void amdgpu_hmm_range_free(struct amdgpu_hmm_range *range) {}
>  #endif
>  
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 96bd0185f936..fd00ec7c99a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -709,7 +709,7 @@ struct amdgpu_ttm_tt {
>   * that range is a valid memory and it is freed too.
>   */
>  int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
> -				 struct hmm_range *range)
> +				 struct amdgpu_hmm_range *range)
>  {
>  	struct ttm_tt *ttm = bo->tbo.ttm;
>  	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
> @@ -762,12 +762,12 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
>   * that backs user memory and will ultimately be mapped into the device
>   * address space.
>   */
> -void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct hmm_range *range)
> +void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct amdgpu_hmm_range *range)
>  {
>  	unsigned long i;
>  
>  	for (i = 0; i < ttm->num_pages; ++i)
> -		ttm->pages[i] = range ? hmm_pfn_to_page(range->hmm_pfns[i]) : NULL;
> +		ttm->pages[i] = range ? hmm_pfn_to_page(range->hmm_range.hmm_pfns[i]) : NULL;
>  }
>  
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 99c46821b961..0ebb99e8d792 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -28,6 +28,7 @@
>  #include <drm/gpu_scheduler.h>
>  #include <drm/ttm/ttm_placement.h>
>  #include "amdgpu_vram_mgr.h"
> +#include "amdgpu_hmm.h"
>  
>  #define AMDGPU_PL_GDS		(TTM_PL_PRIV + 0)
>  #define AMDGPU_PL_GWS		(TTM_PL_PRIV + 1)
> @@ -191,16 +192,16 @@ uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>  
>  #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
>  int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
> -				 struct hmm_range *range);
> +				 struct amdgpu_hmm_range *range);
>  #else
>  static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
> -					       struct hmm_range *range)
> +					       struct amdgpu_hmm_range *range)
>  {
>  	return -EPERM;
>  }
>  #endif
>  
> -void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct hmm_range *range);
> +void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct amdgpu_hmm_range *range);
>  int amdgpu_ttm_tt_get_userptr(const struct ttm_buffer_object *tbo,
>  			      uint64_t *user_addr);
>  int amdgpu_ttm_tt_set_userptr(struct ttm_buffer_object *bo,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index d10c6673f4de..3653c563ee9a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -21,7 +21,6 @@
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
>  #include <linux/types.h>
> -#include <linux/hmm.h>
>  #include <linux/dma-direction.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/migrate.h>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
> index 2eebf67f9c2c..2b7fd442d29c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
> @@ -31,7 +31,6 @@
>  #include <linux/list.h>
>  #include <linux/mutex.h>
>  #include <linux/sched/mm.h>
> -#include <linux/hmm.h>
>  #include "kfd_priv.h"
>  #include "kfd_svm.h"
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 91609dd5730f..f041643308ca 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1698,7 +1698,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>  	start = map_start << PAGE_SHIFT;
>  	end = (map_last + 1) << PAGE_SHIFT;
>  	for (addr = start; !r && addr < end; ) {
> -		struct hmm_range *hmm_range = NULL;
> +		struct amdgpu_hmm_range *range = NULL;
>  		unsigned long map_start_vma;
>  		unsigned long map_last_vma;
>  		struct vm_area_struct *vma;
> @@ -1737,13 +1737,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>  			}
>  
>  			WRITE_ONCE(p->svms.faulting_task, current);
> -			hmm_range = amdgpu_hmm_range_alloc();
> +			range = amdgpu_hmm_range_alloc(NULL);
>  			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
>  						       readonly, owner,
> -						       hmm_range);
> +						       range);
>  			WRITE_ONCE(p->svms.faulting_task, NULL);
>  			if (r) {
> -				amdgpu_hmm_range_free(hmm_range);
> +				amdgpu_hmm_range_free(range);
>  				pr_debug("failed %d to get svm range pages\n", r);
>  			}
>  		} else {
> @@ -1753,7 +1753,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>  		if (!r) {
>  			offset = (addr >> PAGE_SHIFT) - prange->start;
>  			r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
> -					      hmm_range->hmm_pfns);
> +					      range->hmm_range.hmm_pfns);
>  			if (r)
>  				pr_debug("failed %d to dma map range\n", r);
>  		}
> @@ -1764,12 +1764,12 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>  		 * Overrride return value to TRY AGAIN only if prior returns
>  		 * were successful
>  		 */
> -		if (hmm_range && !amdgpu_hmm_range_valid(hmm_range) && !r) {
> +		if (range && !amdgpu_hmm_range_valid(range) && !r) {
>  			pr_debug("hmm update the range, need validate again\n");
>  			r = -EAGAIN;
>  		}
>  		/* Free the hmm range */
> -		amdgpu_hmm_range_free(hmm_range);
> +		amdgpu_hmm_range_free(range);
>  
>  
>  		if (!r && !list_empty(&prange->child_list)) {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 01c7a4877904..a63dfc95b602 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -31,7 +31,6 @@
>  #include <linux/list.h>
>  #include <linux/mutex.h>
>  #include <linux/sched/mm.h>
> -#include <linux/hmm.h>
>  #include "amdgpu.h"
>  #include "kfd_priv.h"
>  


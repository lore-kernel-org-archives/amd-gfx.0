Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C80C369A2
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 13:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC96E10E477;
	Mon,  7 Apr 2025 13:58:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c51CLSoB";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22D7410E479
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 13:58:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHzx8izLDvkR+ivaNNUjSTjUcyGmj4RrAv8wvl21WF70h3WGHZxMdjUwLC/KCwYIR8Ezl73cqq2Dt5GWCgHD2IIjZhdBAxJApA+5nkZCMXJRX0l6Ow8S65x7QIuVzX7dBFTy33tgnsTY03XtXLLzFpz96SvuT31Y2bPlZqm5hLJNDNMMour2vY3eJkt5JiWJ88TqVw0Aidnn4y6mqXxuKpOIyWJoxwUu6CKgvGNtHUnq+GZeT1GasIqe2B5cEPYmY+yx3OA0+TIEqtHDd3XBL4NJ3PO4FWZ3jk2rjQdUkaOklGmXQqmiKogNnmHS4AOVu/XksI+iChPVjtYp0hAnJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHVsMLt3x3C8MMBfH69/aBy88udiropzOGZBNTW0IdM=;
 b=Km96ptfXTGTpHPTLJb3CZ1x5Okh0qgIy7oT9gMgu2gfUnrOcE1ai1ZvvACJDaDXSsxzm+qmEupEE67qRk4hj3rJkaLsAV79uYJ/UTAeU3yyGFyYJNhd0nLWtp/3AKNbSi/rPA/UriETO0JEwRnv7Jg2Qr3X8sLfK/RzUMF+VwmTE8x9qZMNELAnIhYeUox2WSIHaSqF75BCG9Ha3vZTBfgcQZm/3NZAMg+6QFkmvGLaLlh/p7YNYcoDsDE0GS4VT0qLwQJC6sQ+7aCK6QaVoUeA/4qdVBPcihMenKQ0AsbMYdMLrzrsGeSdRWajl8k9yyE/BlaXXCtP5VX4u0mvJTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHVsMLt3x3C8MMBfH69/aBy88udiropzOGZBNTW0IdM=;
 b=c51CLSoB7A03e3D8Wvy4rzDIOUDjsM9gcqPP0wdjSybO4VDYQGI4qXAwF4Hw7pHh6wcbnPoqXnY6piMrjyEvHUsx9xxwwPS55WL9hCteCmCWH4RaTbnJoWQipLoTJI5+CmuOYiDPBIwq2pMgJfDMtb1EbHcu/YKedKtCsWBcMK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by SN7PR12MB7203.namprd12.prod.outlook.com (2603:10b6:806:2aa::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 13:58:15 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%3]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 13:58:15 +0000
Message-ID: <fa6235d9-4d8f-4829-9cde-3455e4ec43fd@amd.com>
Date: Mon, 7 Apr 2025 19:28:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: cleanup amdgpu_vm_flush v3
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250404141607.1451-1-christian.koenig@amd.com>
 <20250404141607.1451-2-christian.koenig@amd.com>
 <5e33847e-de9a-4635-98cb-dbec36653042@amd.com>
 <e43dc724-0ede-4b3b-abd9-5654cf1ccb9d@gmail.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <e43dc724-0ede-4b3b-abd9-5654cf1ccb9d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::14) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|SN7PR12MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 2242d1ff-3581-4e9a-3f29-08dd75dc3ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGJmQVBVMzRVUS84akNlaTRpb0RNRXV4QVA1Um1XNlpEMWdGZmhxQkRWQ0lW?=
 =?utf-8?B?dEJ2Zk4rUFRTaW5nQXZLVHNpNHNSc0xEZ2JhbDdDdlNZcGtPRjBacENiLzNz?=
 =?utf-8?B?czJFYVdvTUVLaVVkek5raHFzeUlINEJQaUdPQWlieHEvQ2pFcUdqOGx1anlt?=
 =?utf-8?B?SzYvNGQ5TVVaNmpMVHZyWFVJT3Exd0tDeTVTaXZUY08yYmpwdkFxRzJKakZw?=
 =?utf-8?B?WTVrQkhZWmJVUitCSUtGa3ZiY1hVSnBRZis1aXZXUmVnclEvY0Q4VUhsRDdG?=
 =?utf-8?B?c2laeWVSOCtmOHhXWlFCcThoYkg1Sm43L0xFOFR4eEU0czRZSDVzUXNXOC8w?=
 =?utf-8?B?VXU2U1FyT2RPSk1LeHo0ZzNNRWhuYUFrc2VRTTVFbTk4V3BLdjlhTGxuS2tW?=
 =?utf-8?B?K2xvWDBDalZkVlRZZmpJN0pYTjRQbkVobzN1U2YzUTdZeFFIcm1odDM3Q1U5?=
 =?utf-8?B?b0lCSk5nTzVPQVl0TXFZcTNQYlVyMGhPTjhkMDJZOGREUng2bWRXSnBJdEJR?=
 =?utf-8?B?MU9QQnA3UXR3QlZKL1hXM0NObUY5VnN2K3NpNjY3YXdrMDFhV21BNldjN01V?=
 =?utf-8?B?bzYvaGNkK1VOWmFSbFAycUo2ZlFKT1d3MTgzY2JlaDAyeE12Mlp2bTd1dWJD?=
 =?utf-8?B?bkZVWmlHNFhkWmR6NjRieFZvMmFQVTkzQnN4QjJONHdJQWdUNmJxOEorcEFY?=
 =?utf-8?B?TXlONGRkalRaRHovS1p4WnVFU0JDbS95ZllIZFVGUExwR0pIbTV3UGU4Y3FL?=
 =?utf-8?B?MmhGSi9paXF5Y0w5Ynh3dW9lajBrd2tPcjJBOEFQMWdWYWtSNzRiUWNGVzZD?=
 =?utf-8?B?aE9CaGUyaG9rc2Y0M0V3RDlLbm5Eb285Y0p1VVRmWnBpa0pqbnAxVGdXUGdw?=
 =?utf-8?B?MWxwcDBXK3RrbWpwaGx0bTl5ZXRrVmhadUxlTEpMbWNiaXppN3dYKzYycEdy?=
 =?utf-8?B?WG80V2pTTC9zdjFVSmlpNWV5VWJUYXg1VHNkV0MvWXR6WUtOWDJjMDA1WXd3?=
 =?utf-8?B?dDBhTEMrWGZUNW1NKzFxa2dxMGVTV0FQQlAveVpiVDF2RWhqN0l5cVdRY3kz?=
 =?utf-8?B?ZEhPZXR3dEE2WWxadDcyc2UzN0dMUFlpbmxKQzFtUEtXay9xZm11c3NJc0xk?=
 =?utf-8?B?L3d4azZteDB3YnRlWGJDczVpU0l5b0xndE14OWI0aUZqNTRXcDF5b2dSTmVj?=
 =?utf-8?B?SDMwTzJROGRWUlVmUVV0WHRlZFVMbTNydTZ5TEl0WGRBVlNGaVpWNVlwbjYx?=
 =?utf-8?B?WWYzOUpLSk9qdzNLVnl0Q1NPUGJFUDhQLzlrTGc3N0dacWIxU3hLRFhwK3hP?=
 =?utf-8?B?RzlGRlNnVEdUZGNVd1NkZjNIR0tVbHhLWXpFUW8rUi9oZmdEd2VQa1NRNWdi?=
 =?utf-8?B?Mm53TStxaDNRZ0FXKzROY2RpemIrVndhN1hrbmhKdzFtNWkvTGR6dk40dEdt?=
 =?utf-8?B?aGJ3NWp2WjJrUnBFdU5Wc09QYWFnYk9ZamxQOHA2MXk1OENzL0hwbFhvaUhy?=
 =?utf-8?B?RTU1dU1tQlhHcFNKNndpTFkreENuVHRRYzExNHEyV1FYaG95eXdud1cvQ3FX?=
 =?utf-8?B?blg0R3k5UUNURjlLSHJnVjJpUmNUUEFvSXRMS0MxclhIOUlXU2pJbjNCMW9S?=
 =?utf-8?B?VldxZ2pxdEFib3ZJM3BvS2tFSkg5SlpwRTdyVjJZU0FOdTI0ZVQreFlsVC82?=
 =?utf-8?B?UTVuMEZ0NWFoWngvTmhWMk1IMHFSQXZicjg0cW96RkM3d3hBUy9IazU4RTJV?=
 =?utf-8?B?NnBlTE9waFd4TlNXRFdwY2Y0c1dGeXdiZEZBRVNqSXNmUEduVExOUXRKV1B6?=
 =?utf-8?B?Zi9iOFRaODQyZEJBVHpqRkMzZTFYdEt5RlJrTzdSYjBDRnF3WmJlR2p1MUlu?=
 =?utf-8?Q?kc1nMaW5sAd0t?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkJTN0JpYVhqTlhqVmZuMWJMZzNYWmtIMCtxamxhTFdWZVdaMDE0V0hJbkdH?=
 =?utf-8?B?dXZybHNUTW9VVFFJM2Z1Zm9JNkFyOG1WYlhaR1NsM1VXWXNTRTA1Slc2blRV?=
 =?utf-8?B?Y21icE1QeU5EZ3FVMVlTOUxBeUZrRlM4TmZMR1NZODRzSmJ3bVNUQWY4VlFE?=
 =?utf-8?B?ZGN2OVBUM1E5RzVFRGFyK3hwTXFyazBwb0JaRUFpSGNLdVlDa3NYODJnMGNs?=
 =?utf-8?B?dUlmVDNlYzJTR1ZkZlBMWHEyY2hhdldXRmhaQ2pJZHUrQzhZdDJadFNueFJR?=
 =?utf-8?B?em9pakhwcUhlUFlrTlpjSEhYc0J3bXpkS2cyTnJQWVV1cXBYYXlxOHVxU3hG?=
 =?utf-8?B?MUxBRWpja21YUlRXOGduaXFQaEhNeDg0c3hSSkcrcHJDdDJpeXVpZXVac1Zj?=
 =?utf-8?B?TkNRR2JvWldqT2ZmQ1hqUGI2Sk9jY2FjbVlxVG4vMVVYM3phSzJjSEVxODNk?=
 =?utf-8?B?TGxHWW1Pdk1nNXR6Smw5bHp5RndvWjc1eHFMTHhtK2tFL3R6TEtwczE2U01z?=
 =?utf-8?B?aGhKcVBXQ1NVMitMbXdxTVM2bVVKYzN4K1p5VFNJTFpOUTM1Z2JzNkV5WkFM?=
 =?utf-8?B?aVh4M042c2I1UFpLNHFEMW01TXpzQ0JXdUNGM1drSDZsMnJBelZvNDVQMlpr?=
 =?utf-8?B?ZzhrU0RwRk80allBd0NMeVZGZXc2QU1LRWswb2o1eXJlUllTOFFUNHRoUWVy?=
 =?utf-8?B?SUdjUmNPRkxqVzJScGlVUEdOS2l5Q1N3TEtUK2E3Z2RCRkk2cUtRNW53TUxl?=
 =?utf-8?B?R2ZhOG40aloxL0ZzNW1ld2EzTmJlUlkvUFJZQTFVU1JMb0NRcW1WKzVYUW5r?=
 =?utf-8?B?YWI2bDlpdmEyWFlJVXFwRXp1YzhOSlZ2QXluTWFNZUZHbk84N1dvdFkvL2p2?=
 =?utf-8?B?UEMxUnROeGpIY2J6cFNwczk5ZjlrRlZoZ0ROVHg1Nk96TTVUc3RZTjN0dmUx?=
 =?utf-8?B?UFFHbWd4TGg4MTB4QkFkSjVUNG5kYmxCbEtNeVNVQ2kyM0E4MW93bndEWTZr?=
 =?utf-8?B?OS9JY2RUSEZkSy9ucnhsbENaREZTVmZoRGhZZTFZYUxhWmhoRUJRQ1RiK0pv?=
 =?utf-8?B?KzZqbjl1YXZQZnFyTDgrWEJSRzRld2hPVjNkNmZMV2hsTFBjOEpxc3pXeTVl?=
 =?utf-8?B?YTRQaExSYU5mbmhPMHY4dUE0QXBKN3ViUUdwLy9pd3IrUmplWTdkYXJ2OEwr?=
 =?utf-8?B?ZDhKWUxxRlZ6RUdmRUFZL2ZBZUpKaWYzaVBZSVZPNnpVRGlDUmowWmxOVE5P?=
 =?utf-8?B?RldTZEJ1cVo5SERlQU84RVdGUmF6NXh2S2JsS1FZKzRDZzZEUHczT0JiMFZT?=
 =?utf-8?B?T1NHeHBhVE1lUmlYUkpLRzloU3UzN3pXZDlZbm5IRzV1WnJWM2NCRkw2aURS?=
 =?utf-8?B?SUppL0plVmEzdmE4SXlaQ3ZKWFRhS01rTmw1VmsyWjlwSXMzNHR0dUg1RXdi?=
 =?utf-8?B?MGVCQUJHRVptRm1vaG1YcU9rSmZSWUJRVllFTnZvU0dLb1hrSUp6bUZiZ1A5?=
 =?utf-8?B?OE5mdVVWQkQ1dUgyTnZiQjUvdmlCS0kyUHl4M1ZMZForRGFWSS9ESjM1S2Jo?=
 =?utf-8?B?K1lCbXFQSkxlZEtsc21wTTd0T09RNlA1cGQ5QXZYSGo3bnJJZ0Q5RHlqalFT?=
 =?utf-8?B?R2hMSndJRjlnZVJXSkg4S0JRZVphbndxblBvWWtIM0RwU1dVWnFhZndDSUxS?=
 =?utf-8?B?ZnFLelN4Z1c5RzJxSG1UMU4weDF5MEdNN1ZwcUl6czNHRXBYV3hWYlE0R0xy?=
 =?utf-8?B?WGt0cGJYSHlMMUNQb2hiZi95NkpIeEtlMU95VXNTUklrN3BTR3piaGp4VXV0?=
 =?utf-8?B?V1BZa0RPa0xHTCtCNFp3Q1Mwb0dYVDhQT0NGbnlvZkFkSUhMUkszem12K0tw?=
 =?utf-8?B?UDl2YjhWdjh3SGRQTjR0VnhrYTh4YlhwMHl4NFpZS210YnhtTDEzRGlGVHpX?=
 =?utf-8?B?bUZCb2ZkalpPK1pGRTlxcVM4U3pkQXhzU2kyN2hpR1ArS2JIQ3ZWYnR6ei9s?=
 =?utf-8?B?Y1RLejBteUc3WHpOd0dUWkRwYUFUVU5kdFNQMUNxOUZ2cVBnSysxWkRvenZT?=
 =?utf-8?B?bmoyT2Q4WGZKWmRFczAwK1A3aVpyaEZLd3YwN1JNMUFPR2lTeDhIRXFEbmZ1?=
 =?utf-8?Q?/rTk720fbMOa/my7l9alCPArs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2242d1ff-3581-4e9a-3f29-08dd75dc3ddd
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 13:58:15.2174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6VOat94t6KmlUuYBKo42YPwXiklE68cejzXM8gHuT0+LGTX+M+RNpabPK9HgWONSeRe2ZMAt/N6gfcHe0C3Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7203
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


On 4/7/2025 5:44 PM, Christian König wrote:
> Am 05.04.25 um 09:32 schrieb SRINIVASAN SHANMUGAM:
>> On 4/4/2025 7:46 PM, Christian König wrote:
>>> This reverts commit c2cc3648ba517a6c270500b5447d5a1efdad5936. Turned out
>>> that this has some negative consequences for some workloads. Instead check
>>> if the cleaner shader should run directly.
>>>
>>> While at it remove amdgpu_vm_need_pipeline_sync(), we also check again
>>> if the VMID has seen a GPU reset since last use and the gds switch
>>> setiing can be handled more simply as well.
>>>
>>> Also remove some duplicate checks and re-order and document the code.
>>>
>>> v2: restructure the while function
>>> v3: fix logic error pointed out by Srini
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |  3 +-
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 92 +++++++++-----------------
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  5 +-
>>>    3 files changed, 36 insertions(+), 64 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> index 802743efa3b3..ff2ca984279a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>>> @@ -191,8 +191,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>>>        need_ctx_switch = ring->current_ctx != fence_ctx;
>>>        if (ring->funcs->emit_pipeline_sync && job &&
>>>            ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
>>> -         need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
>>> -
>>> +         (amdgpu_sriov_vf(adev) && need_ctx_switch))) {
>>>            need_pipe_sync = true;
>>>              if (tmp)
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index b5ddfcbbc9fc..e6d7db8d40cd 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -596,37 +596,6 @@ void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev)
>>>        }
>>>    }
>>>    -/**
>>> - * amdgpu_vm_need_pipeline_sync - Check if pipe sync is needed for job.
>>> - *
>>> - * @ring: ring on which the job will be submitted
>>> - * @job: job to submit
>>> - *
>>> - * Returns:
>>> - * True if sync is needed.
>>> - */
>>> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>>> -                  struct amdgpu_job *job)
>>> -{
>>> -    struct amdgpu_device *adev = ring->adev;
>>> -    unsigned vmhub = ring->vm_hub;
>>> -    struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>>> -
>>> -    if (job->vmid == 0)
>>> -        return false;
>>> -
>>> -    if (job->vm_needs_flush || ring->has_compute_vm_bug)
>>> -        return true;
>>> -
>>> -    if (ring->funcs->emit_gds_switch && job->gds_switch_needed)
>>> -        return true;
>>> -
>>> -    if (amdgpu_vmid_had_gpu_reset(adev, &id_mgr->ids[job->vmid]))
>>> -        return true;
>>> -
>>> -    return false;
>>> -}
>>> -
>>>    /**
>>>     * amdgpu_vm_flush - hardware flush the vm
>>>     *
>>> @@ -647,29 +616,31 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>>        unsigned vmhub = ring->vm_hub;
>>>        struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>>>        struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
>>> -    bool spm_update_needed = job->spm_update_needed;
>>> -    bool gds_switch_needed = ring->funcs->emit_gds_switch &&
>>> -        job->gds_switch_needed;
>>> -    bool vm_flush_needed = job->vm_needs_flush;
>>> -    bool cleaner_shader_needed = false;
>>> -    bool pasid_mapping_needed = false;
>>> -    struct dma_fence *fence = NULL;
>>> +    bool gds_switch_needed, vm_flush_needed, spm_update_needed,
>>> +         cleaner_shader_needed, pasid_mapping_needed;
>>> +    struct dma_fence *fence;
>>>        unsigned int patch;
>>>        int r;
>>>    +    /* First of all figure out what needs to be done */
>>>        if (amdgpu_vmid_had_gpu_reset(adev, id)) {
>>> +        need_pipe_sync = true;
>>>            gds_switch_needed = true;
>>>            vm_flush_needed = true;
>>>            pasid_mapping_needed = true;
>>>            spm_update_needed = true;
>>> +    } else {
>>> +        need_pipe_sync |= ring->has_compute_vm_bug;
>>> +        gds_switch_needed = job->gds_switch_needed;
>>
>> *[1]:* Should we need to check along with "ring->funcs->emit_gds_switch"
>> ie., "ring->funcs->emit_gds_switch && job->gds_switch_needed;" here?
> No, see below.
>
>>
>>> +        vm_flush_needed = job->vm_needs_flush;
>>> +        mutex_lock(&id_mgr->lock);
>>> +        if (id->pasid != job->pasid || !id->pasid_mapping ||
>>> +            !dma_fence_is_signaled(id->pasid_mapping))
>>> +            pasid_mapping_needed = true;
>>> +        mutex_unlock(&id_mgr->lock);
>>> +        spm_update_needed = job->spm_update_needed;
>>>        }
>>>    -    mutex_lock(&id_mgr->lock);
>>> -    if (id->pasid != job->pasid || !id->pasid_mapping ||
>>> -        !dma_fence_is_signaled(id->pasid_mapping))
>>> -        pasid_mapping_needed = true;
>>> -    mutex_unlock(&id_mgr->lock);
>>> -
>>>        gds_switch_needed &= !!ring->funcs->emit_gds_switch;
> That check is here.
>
>>>        vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
>>>                job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
>>> @@ -681,15 +652,17 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>>            &job->base.s_fence->scheduled == isolation->spearhead;
>>>          if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
>>> -        !cleaner_shader_needed)
>>> +        !cleaner_shader_needed && !spm_update_needed)
>>>            return 0;
>>>    +    /* Then aktually prepare the submission frame */
>>
>> *[2]:* Could you pls correct the typo?
> Mhm, I thought I already did that.
>
> Ok, going to fix it now.
>
>>
>>>        amdgpu_ring_ib_begin(ring);
>>>        if (ring->funcs->init_cond_exec)
>>>            patch = amdgpu_ring_init_cond_exec(ring,
>>>                               ring->cond_exe_gpu_addr);
>>>    -    if (need_pipe_sync)
>>> +    if (need_pipe_sync || vm_flush_needed || cleaner_shader_needed ||
>>> +        gds_switch_needed)
>>
>> *[3]:* Can we check even for *spm_update_needed* alongside the other conditions, that might need Pipeline Sync here?, Cz in an environment where multiple jobs might be accessing or modifying shared data (especially in gang submissions), ensuring that all operations (including SPM updates) are completed before executing further commands, to prevent using stale or invalid data.
> No, the SPM update is intentionally left out here since those shouldn't interfere with the pipeline sync.
>
> Regards,
> Christian.
>
>>
>>>            amdgpu_ring_emit_pipeline_sync(ring);
>>>          if (cleaner_shader_needed)
>>> @@ -706,20 +679,31 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>>        if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
>>>            adev->gfx.rlc.funcs->update_spm_vmid(adev, ring, job->vmid);
>>>    -    if (ring->funcs->emit_gds_switch &&
>>> -        gds_switch_needed) {
>>> +    if (gds_switch_needed)
>>>            amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>>>                            job->gds_size, job->gws_base,
>>>                            job->gws_size, job->oa_base,
>>>                            job->oa_size);
>>> -    }
>>>          if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
>>>            r = amdgpu_fence_emit(ring, &fence, NULL, 0);
>>>            if (r)
>>>                return r;
>>> +    } else {
>>> +        fence = NULL;
>>> +    }
>>> +
>>> +    amdgpu_ring_patch_cond_exec(ring, patch);
>>> +
>>> +    /* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
>>> +    if (ring->funcs->emit_switch_buffer) {
>>> +        amdgpu_ring_emit_switch_buffer(ring);
>>> +        amdgpu_ring_emit_switch_buffer(ring);
>>>        }
>>>    +    amdgpu_ring_ib_end(ring);
>>> +
>>> +    /* And finally remember what the ring has executed */
>>>        if (vm_flush_needed) {
>>>            mutex_lock(&id_mgr->lock);
>>>            dma_fence_put(id->last_flush);
>>> @@ -749,16 +733,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>>            mutex_unlock(&adev->enforce_isolation_mutex);
>>>        }
>>>        dma_fence_put(fence);
>>> -
>>> -    amdgpu_ring_patch_cond_exec(ring, patch);
>>> -
>>> -    /* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
>>> -    if (ring->funcs->emit_switch_buffer) {
>>> -        amdgpu_ring_emit_switch_buffer(ring);
>>> -        amdgpu_ring_emit_switch_buffer(ring);
>>> -    }
>>> -
>>> -    amdgpu_ring_ib_end(ring);
>>>        return 0;
>>>    }
>>>    diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> index daa2f9b33620..e9ecdb96bafa 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>> @@ -493,7 +493,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>>                   struct ww_acquire_ctx *ticket,
>>>                   int (*callback)(void *p, struct amdgpu_bo *bo),
>>>                   void *param);
>>> -int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
>>> +int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>>> +            bool need_pipe_sync);
>>>    int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>>>                  struct amdgpu_vm *vm, bool immediate);
>>>    int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>>> @@ -550,8 +551,6 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
>>>                   uint32_t fragment_size_default, unsigned max_level,
>>>                   unsigned max_bits);
>>>    int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
>>> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>>> -                  struct amdgpu_job *job);
>>>    void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>>>      struct amdgpu_task_info *


Ok thanks for your feedbacks, based on this with that comment fixed, 
this patch is:

Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>



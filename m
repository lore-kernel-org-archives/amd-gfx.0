Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6561E8B39F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 06:29:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5240A10E2FD;
	Wed,  4 Feb 2026 06:29:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BkRsWHkr";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CB4710E2FD
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 06:29:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gbGQxfE6T8714gQPiF6rooKbIW06nyy5PwXrKqgPzsG5uDXhtE2uEwMqLPImLrkFFlpfKijfN5dC4pcs50hB67U+1eezfnPqWY53qYy6j/pSygdzkIXKECLDcop3vBmTRxGeUaB/90r4AUUNP/kpcSgO6/UZ8Km/KgiWU84tdYa39gXrbfdo5Ln4WlHtHacJFKHol0dL62vkHqxJ2zgr2QvovOoLHAYdjPuz8ZG5Nq8iu3QglseOsyKy7k+j48dIge3aEtOnjDMo7OaA4s1iYnrSlBjOx5n1tqNXcoCA11CoQvK2MF2wV0dZe9H6tWSnfPZjtjXaS7Fku6kleUv3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N57SCiO0pDl/tPbNkOatp4xezwGOXaC+OG/b5EolNcA=;
 b=lboyj3j428pn9IBbKWJq5gulB+AwkNt7u/6maCMcmkCn4eQPiQBhZGXnx5X77RNwsBj6un03iVpcCKor23thS88jmcEI6cRkU+aF9ZRW5CwRJOgv9yR0uwRPUjUJJPKa4eI8ilgxyTNdGDbOyXhoihXf698SzzetHgSqIFMa+zBxp1DQ14q6UIO7dWxssZ4K44gmY51xucgj3RZektOsTxUxCqPzQdRRV+JR9rQ21a6bAA3zah6+Y6vXIM9CGmoBG4eke3SB5Xh6Wfvq43aAb4jk7PPSdXf8DdTFq8kTz3Z2cT4xF7KI+TPeCPZnnxYaC6YAZBkeHHkFnZKKNl8mnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N57SCiO0pDl/tPbNkOatp4xezwGOXaC+OG/b5EolNcA=;
 b=BkRsWHkrHcudOXf8uF1l8YvvZu0PBG8uqaZHYjKckjcStlC0Zyhk7aw0BtunAwrswjkpYhr9r29lg82G1VD0U2J4v09kpMz9eby7lGMg1AmfBmYPsHLYJAXZIEPdG3USReYnJBXR5wXYWWqzv4WHahWmrn4Uu5GmsQ8WjQxpedM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 4 Feb
 2026 06:29:23 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 06:29:23 +0000
Message-ID: <d49d5962-e50a-4465-b91c-8702b0e8418c@amd.com>
Date: Wed, 4 Feb 2026 11:59:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: clean up the amdgpu_cs_parser_bos
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel test robot <lkp@intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20260204062401.2299187-1-sunil.khatri@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260204062401.2299187-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0001.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::11) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM6PR12MB4204:EE_
X-MS-Office365-Filtering-Correlation-Id: 84419920-070c-4a0f-bb13-08de63b6bcaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnJueDdLNUxhZVkvaFVFbkoxcW9CWDJlRXVLTzdkM1VRT3NYdEEvbDhCeFRY?=
 =?utf-8?B?dnBhcHhsQktKU3ptQ1VjL0o5SG16YlVobmlwbXdmbUpxSWg3QlUwR0dmem5Y?=
 =?utf-8?B?ellkVThpZkwvOGdtWFMyVWZTa2ZoVlY1alphakUvQkp5NnlrY2trVmhDUkps?=
 =?utf-8?B?V2NIM1M2TGlHYllqWTFheEdZU0h6QWp5eUcxZndHNHJjNyszMlB2RklyUDVC?=
 =?utf-8?B?WE96L2FTSnNIUWR2dktQVDhqTEM3aUJHeGY4ZjQzcnVHcytUUkx0TVpiT3dT?=
 =?utf-8?B?c1dUTk5FM21zaDV5MmlIakZYK3NCR1N6cFd3L2hCS2FybmZhTzA2MzcwMkx1?=
 =?utf-8?B?bXRMcmh5VHoxMkhnYVJSdk9MZXNLYjZYSENWK2txZk40bHBodXFWMzRhbEhX?=
 =?utf-8?B?Rld4UkRoVlhiTzg2K0ZEN2JFYmM5Y1RTU3BRNDVOc0tFaFIvMGhBMGFWZFBU?=
 =?utf-8?B?MXB4SGN1L2I1alg5RzE3b3Z4cEl0SlpOclBra3FESlQxMnQ0dk5UQWdocCtL?=
 =?utf-8?B?SlAwRjRGTCtobHM4RVR6SnRJMWpZL2FLcks4eFR4bGgzQzUxVHFBMFEwV2ov?=
 =?utf-8?B?cU9nUGF4bjI2aTU4cURpVGFWTjBRQnU0eVMxcjdlTks5cm5SMTR1NFU1ODgy?=
 =?utf-8?B?bGJPUjI3UTdTdTIxcHNtS0tkN3I5QkFpN25aRHpOWnV3eGtJZ2xxYnB3QWJ0?=
 =?utf-8?B?V0hWQ3hnbDM3clZzVzFoa1ZlSEpBZmRjMGJKYXpSMlkrSzJZbUxEOUlmUVl5?=
 =?utf-8?B?d0pueFZSYVRLaVdiSUF6YnJyT0t3Mlp1Z3FwR0Mzd3ZPVkU2NDBFRGpZY1Na?=
 =?utf-8?B?K3lFd0IvK3NBYjhiRnNyK2hMbjVwbGh4K0luUmNZN0prZDU5alRJNFk1eVo3?=
 =?utf-8?B?RXpRM3ZETXRlUklJNklvZFNydTl5THlnWkk5UUxuQ2l4ZWJWd0hxZW4yZzB4?=
 =?utf-8?B?RDhHSFRKdlA2WXEvcVdlR1RyQWVxVW5CRHdvK0NJM3U0OEl3bWF3OTltOVZX?=
 =?utf-8?B?OXJRYXZXbDROT1puUGFMdDl6ME5rMWhnZFNrNUVjeENEK1p5dEJJU2I1RXdG?=
 =?utf-8?B?NHVydXZLYk8wQ3BtRU1ieGhtTmg5L2ltaUNibmJ6dFVVRVRzQ3VQNWNDV1F5?=
 =?utf-8?B?ZTc3eGVKQStydENQMlFaelV2YUhIcDBCa1lmMzdlMkg5SXFoOHdvaFNwTlgy?=
 =?utf-8?B?MlAvdTlad2lzQjBvMWpBODdVaTRKK3E4NE5Id3JyOUR5S09ra2MwTi9tQnNt?=
 =?utf-8?B?ZG1PdEZNa05GVlVzUXduZ2tkVlRqUFM2NXpjMVU4VFVtTWRmRzdHdVhWblZO?=
 =?utf-8?B?c2JzMWViRkRDcytteU9DSFhkUzZKeFFLTTVRdkxYSkNMSFR5S1lMMEZlTXRh?=
 =?utf-8?B?NTZveHhZUW9GTHljbW92Z2R3N0NwQXJmU1ZEQTFZTG5SNjZzamdyRTFYNm1i?=
 =?utf-8?B?U2MyQlZ2S203QlIyUGRWRlVuTSs3d281TWVJdDNiNnhxQU5QM0hRQ3RzV3VV?=
 =?utf-8?B?L3dhemc2NUlMUTlaN1lMdFd1aXh1aGlXM0pjRVVmUllrdzNiMHRpTk4wWkJx?=
 =?utf-8?B?OFFhNWN6STRTb3hrcWp0ZG5PSXVselZ2Q1pFYWJ4ZnRxT2MvcWdnM01PaWto?=
 =?utf-8?B?cjM3K1hWdG1NbXNGUVBIMG9sWmRSN1NtQWZPaDY2STlmcmJLWjZSU3ExbE5L?=
 =?utf-8?B?VUtoVDRJNEZTSlRPQVk4SHJySFRqa0Z5VEhlS1NNS2JUQnZXNExVYmVPSzhn?=
 =?utf-8?B?UkhRc3JRRDgwWGtWQWVwS05nOTJreGFpa3Z6SVVCdlhTWjJha0FkM0RtYS9O?=
 =?utf-8?B?ZE5hanF6UzQ4YmczMGRabEEzazBKeXhyL1BjY3FuZDVCbVBtdUNTQmtZOW9Y?=
 =?utf-8?B?emw0ejd6WDJTQzE0ekxvazRIQ2p5YldOamFDRU5ZYVdGUUd6dWx0elhsZEpm?=
 =?utf-8?B?QzZtTXh4UUI1ZG5JMFN6SzRsNXJ5ZUtEQU81bmRONFRyTVlhMkRndkdTL0dT?=
 =?utf-8?B?bEhZR3ZLay9wanVKTWgvODNUaVBSWG9hY3IvZ1NSdG4yR1lXWFJLTGNyRUVJ?=
 =?utf-8?B?VWQ2RDFlRWsySDlxdUNnN3pUeSsxeFp5dDJxd0FsVmMrbnlPR0lYTTVUTndz?=
 =?utf-8?Q?uOtLpVACZQi3sYNxx0KUFvUcA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWxxWHN2V0VBL2Y2cW5oK2FwRTdRSWMxSGMyTkRkZnVHQXJWWXRmSVZ4ak5I?=
 =?utf-8?B?K21xNmNiWnlIK0pkWWoreFpPZjBRdW1WaGNmQm9ROWNXVVNYVnludkY0K0Rk?=
 =?utf-8?B?dUsvZi91WTZRc1hDckVvMmNNZExvSnVJMkZVWmtqaGk1Y3ovckdNK1VuclZ6?=
 =?utf-8?B?bnA1Y3dEeGxNWmIzRTlvbk16aldOOU1SbWMxREFYeVJId2RjUmJrbUhvT3Zn?=
 =?utf-8?B?aTNPU01ZZCt5bktVRGxKajBSVEI3MVY5cmpuR3BkT0NFc3ZCczhWNE1yS2N0?=
 =?utf-8?B?WDIrczJtc1FENlh1YzgvSk5CQnUyT2FXck00SVBLQ1RYSEZXTXlpY3Zmc2Nr?=
 =?utf-8?B?OUwrQkdvNkR2TUZ3WmRhc29nRFN5TFkxV2Vhc3FCbWJRN21UVFo5ekN6L2hF?=
 =?utf-8?B?dVpFRS84VjhPcXVKOHRWVVVLN1cyREpYTmNzc2w3YzFEUFNsaERiK1ZVRFR5?=
 =?utf-8?B?ckpqZ0k2cnZkS0pEbUNpWDNCaFNGYWs0Ynlud3hQRzh0SmR2Uk1JdktlSWV0?=
 =?utf-8?B?QmgyRWcxYmJuTlJvamF6QVJJRXoxVWx1WWtxL05XVVBYb01CZ2FncG9xQmNk?=
 =?utf-8?B?K3FHSitpblVtUVlvU0Mzc1dGRTUvM0pVWVE1THpxM09wRjBtZFRGZzNoWXB5?=
 =?utf-8?B?KytsMzBXcndGVFBnWTFkMmZNMUg1YXR4V0NLZ2RIeGFxQUZESlNVRFRYWlgz?=
 =?utf-8?B?Tlp5bzdNbnkvNFMxMlczUWRlYjVwQXdtTi9PNFRiRm93T0N1azdRWGpSSUkw?=
 =?utf-8?B?WWxuRW03L0hqTStwMUhqZmU0N2dVa3RiL3BVRDBCeTNXYzUzWWNYOHNoOCtw?=
 =?utf-8?B?WkRPZVVXamtwcTlaY3E3M3I5T3B6Q0lHdXFLY1pCTkJVSnVrL1FjVUZXSzJL?=
 =?utf-8?B?OXFrbFo2THg3bVFVTEVZVzQ0YjBEcXFybTVXRXhMTjBjZmNRYUcwLzNoUVB5?=
 =?utf-8?B?dHhTNjlyTzFFdmNLQUp0SDVNQXN2aDlqSFByMFNZNHVZOUhaZnZPckJpbHJW?=
 =?utf-8?B?KzlGTzE3dkdDOVoyTDluekV2MmxFaEdKbW9JTld2SHpkZEJoemZrYXFOOVly?=
 =?utf-8?B?eTZBQjRKRmZtTTNKK0VQaEF2ZW42Q1hpZlI2eWZGMWR4dE8xYTRhY0ZzSFh5?=
 =?utf-8?B?aFlabGpQRXZCUjBudHEzdHU3T0RKMzZjT1B5SHB1VUR1MjVzek1yZ1Q1VGRT?=
 =?utf-8?B?cktXbjB2dzVybVlPTWdiU09kaTRXT2crVkhwQldwRTRlRmdtMVMyb25aZFBK?=
 =?utf-8?B?NXNqUzl1ems2OXVKTitNbTZSRFhIeW4yUjN4N2VDZG4wV0VpNEpndFowdGZZ?=
 =?utf-8?B?RlFveUNBMFhPb2NQZGhyUDArZGcrV3ZVZERtcWRwVU9xL2x0OWJweFExNkNi?=
 =?utf-8?B?V0dNci9qendnVXY3UUJFdms2N3NQd1l1SU8vTmNqb2NxZjFwSVRZdWpDQllq?=
 =?utf-8?B?WXRwTE5wSmlzTHVDaTZRNGl2M0NHZGhKeXVJZ1ZqRDJrQUlsOG1WVW4xQmJq?=
 =?utf-8?B?QTlwcmNueEVQUUZtRHE5TjlnMnZFd0ppb0Y5eDFvdXh1UTc1WE5EYU1rWjU4?=
 =?utf-8?B?Q0pvbjBWRGN2UWZoL2NMaVdWcmRuTG1DaGkzRzhYWWZidTEzM3ErWEhNMEhk?=
 =?utf-8?B?NldVSHJXMW5aMEdIQi9lSGpXeUFJeTBSeG94VHJIM0x2dzY3VXFnbkpCZ2VZ?=
 =?utf-8?B?bjJrUjdLZW5qSDQyV2YrRFIrbFArT0dyZG5LbVJLRkEzTUFlZCt2YjY2NXNa?=
 =?utf-8?B?RWZESnNUUWhrUGozS2RTZkJtNERzVTZENy9pcStWd1k3TjhRbGtwOStucHpl?=
 =?utf-8?B?eUV5MzAzV1VyazU4TmZrREFsSjJkY2YvSDVUNTJtZ1paM3M5R2xJOTJNVHRw?=
 =?utf-8?B?c1Yxb1VPakpVdHNGbGdYNitFQzBRZ2ZpNTZ5djhjUjA3Y0x0ZXdROUYwSWpy?=
 =?utf-8?B?L016M1hkcWZXWG9WeituWVRwc2pZa3RnY01xMmlKQUwwSlhCbnB6eW1rN2xM?=
 =?utf-8?B?UGJ0VmhmZXE3MTBXNWZSZzFWV0JHYXlIZndyRmtYYXM5R0VwWHRuenhFN2pL?=
 =?utf-8?B?SXJaeTYzT0g4bEYzQ1ZUSjh0NjZ0OUJPRWZDS2RTcGIxOU9LdkFuQzBwbTZa?=
 =?utf-8?B?VSsyc2lzMWJQdjllZlBZbUFSR3BrZlVVOTBZWEkrWGZzMVB0SGk3L1pIR2th?=
 =?utf-8?B?d0tTNVFtRmxtNTBXb0ZlWUJRV2hVbmxnQ0dFVytNZFNIV3ZFSTl2YXdONjZV?=
 =?utf-8?B?cUdPczFtNUhvNzZmamdYMWhtc0t0TnV0SjNIMFNZb1JwaHk2YjMybElpL2xt?=
 =?utf-8?B?czJ6UWJJZ2l1MFJBNXZiZm5tTFFnWjZ3ODVjOWttUG1FWTNzKzl6UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84419920-070c-4a0f-bb13-08de63b6bcaf
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 06:29:23.7634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BW1l/k6wCqquuZiPz/nwgXGzQEFbenwV875AR7yjdCERLvPGyPMDBJASA12dxO1Avl3Zk3/2i1encduN+nlHAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204
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

Ignore this patch version as v4 is pushed.

Regards
Sunil Khatri

On 04-02-2026 11:54 am, Sunil Khatri wrote:
> In low memory conditions when kmalloc can fail and hence
> we need to clean up the bo list and unlock the mutex for
> clean exit.
>
> Fixes: 737da5363cc0 ("drm/amdgpu: update the functions to use amdgpu version of hmm")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202602030017.7E0xShmH-lkp@intel.com/
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index d591dce0f3b3..b166bccecee3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -892,8 +892,10 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   		struct amdgpu_bo *bo = e->bo;
>   
>   		e->range = amdgpu_hmm_range_alloc(NULL);
> -		if (unlikely(!e->range))
> -			return -ENOMEM;
> +		if (unlikely(!e->range)) {
> +			r = -ENOMEM;
> +			goto out_free_user_pages;
> +		}
>   
>   		r = amdgpu_ttm_tt_get_user_pages(bo, e->range);
>   		if (r)
> @@ -998,6 +1000,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   		amdgpu_hmm_range_free(e->range);
>   		e->range = NULL;
>   	}
> +
> +	amdgpu_bo_list_put(p->bo_list);
>   	mutex_unlock(&p->bo_list->bo_list_mutex);
>   	return r;
>   }

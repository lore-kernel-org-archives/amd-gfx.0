Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341B4C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 08:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C76F010E597;
	Mon, 13 Jul 2026 08:41:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mY4BdMji";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C65A10E597
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 08:41:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WoTFCGSNSafMahGQN5usZcVIw5xVj7sIogMi4UZkQ8CWwRGqp9Mc7AK6VKtWNtckan1qhsJ1CUl2AmjC+k3Qca8O/wJr12maoDqM26gMU7SFjWgQKJt0R4rmcUq1rM7GPg/mWGQyi70CI0YSgh553vY6yK/LfVQ8V8vHE28LhT4IkyjQGtVSkdqyQcHJqRFgivKMUnc4PXKd2kls6jqF2jukERStcH1gGl+9NhuS3xITqD6qUykaXCR4GIsd91RTOg65Q1Y3NIqc/YETsfSf/WdDUyyAQNmIwydov1AXf5RLnETKseHOkk8w4aJ1jfkJ1bBPQ3wC/vdJYNXVvsQvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EF4q38McfwGAFqSLXbGS11txGi7zwl1ixTu+jKPbGww=;
 b=TaWnXOZg8sU/fp2lEH4VM/kn6je2VhCiLwU0UYhj/f1v/SmpT+m39ECiWrQlHUG6/mhXJfYsnv4Gpn/pGxL4slW/g+zaAkw8WfbeQwPmClt8vxnDWuuKbG9KpRiBrfYg42aOvtVus6GQEzZCE/1qfsBsPEfOkw6LTSIOG94PKtZAWyczyP4U4xhHJZDqi1gVphzq6NSwUIEzZXbQyoBgv7oeo2oGjNrZKaI3Dpy5Hi31EjXyaEq0R9GMx8gT/CZQXMOQ9+I0q9tJ18A8MXNrYGpbyf9JRSwNXODRDjZEfyIwy3isqOEzBVRULy+9cIibar6JtzADZpCIRPdiRE3QYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EF4q38McfwGAFqSLXbGS11txGi7zwl1ixTu+jKPbGww=;
 b=mY4BdMji7UGfKsA305+R83gGnSWEkFQzqBm9K15V+lQuPpHyWXaITbjABZB3d4j72/wBcGUaktB1uC/2pJMJm2WXHa0c6jZDNLaeKmI9I2KSQCLkZUJP1yVJF7ompWswkCw3qvamf3OQAuWus9e+ndFpSSAx3eIwXITDlsTJIfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7602.namprd12.prod.outlook.com (2603:10b6:208:43a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 08:41:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 08:41:27 +0000
Message-ID: <29c5dfdf-fd34-4537-8404-4193ee01d754@amd.com>
Date: Mon, 13 Jul 2026 10:41:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu: Reserve space for IB contents in
 devcoredumps
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
References: <20260711112108.8980-1-timur.kristof@gmail.com>
 <20260711112108.8980-2-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260711112108.8980-2-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::20) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: e6560ca9-93ea-408f-a743-08dee0ba871c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|56012099006|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: 5WUSl1U3zucmOJ4jC1fsFQnyHjM5grvI5H1hzwxId48T+aD9PVTFuBvbt6hq87sVQG8sGlC/uoMqQXE6Pf/l+UYM8ezUBimmQLIVFYJbPcSkj7mc1Yjm6J8PgWuym98EXteF2+UizJnQ4CYOm63L6khEnAYPUfw3vL40a8uA8xrwmMKyzWiQwDU1puG30fX13RITLnilw30o07TvcQ8LdKkJ1Y6tstqzpSpBnWjpKFDc6UJvW8ncaVsm+OO/LN1H7VaNpGWmJPK2eKvqfvfhIIKgGYOpTKxEWkWwI1OWQn1I3add9WR7D9R+pzpgnDXIvrD1McC1VYit9Mg65w3ydNtd1SH9DKVXb4TPKF1ZH3IkLwy+sUZCs0XOX0JmymF0PpjuD8890/esZbPmO/326DhRleVslITyDOHZY7bEaI2U+KyZQey67k/0rwopYWxgNlMIEyHVMXxsz+YVUoyFdMxPkWQJr8F8Geu71LH0Ss52kvdVqQ5SzeOveljbi6Ky0SHmsagAZgBpYcrm3+MVoLe9Ih5TLw5QaIoGJYKYvPWWpmvNPimm4GV962HHVkSapmLBj4zmvDxlmRUj0Oz9XnHdLCOp19xIwqvFED1FatRXZXLHF0g/8IoCxs0DvKUyq8HpjGXF+GMEhad3a5O1AKfT3XaClqSfEPsHy/MIse0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0JzVWtsM0hqcWowN3lFWnZBdStUN081UGViUktFdlZEODl0Wkp5eVM0bmVa?=
 =?utf-8?B?OE83cXAxWFFxMFFUWkk0Nm9BOFk3ZDNvbG1jaFV6ZDU2Ykk1SG9JTFBVT3ZO?=
 =?utf-8?B?Mms5VStYQTBrMUxwc3BMNTgyU3QvUzl6aEZSai9MSjdIRFp5WnB0bjBUZjly?=
 =?utf-8?B?cWNFTXA3c21HY1Y1YUtBQXNzKzZaQjUwYzhiNGdFN1pBT0F3VHVuaXZCS0xH?=
 =?utf-8?B?N2UyNlRMc1FpQ2xrN0o5NUtOMGVkczdmMjJZZUpiU1dITGtVcUEzR2VUY2R0?=
 =?utf-8?B?a2RVaFhyaksvUVE3Qk9OZ3c2enNPQTJEbk9qeHgvWExUT0FaOG0xcnN1ZVRI?=
 =?utf-8?B?dW42aVN1WUowVFFQSDAyYjM5L01BZG4xZHloL3RPdjF6QVl2T0hWenMzMmFs?=
 =?utf-8?B?RmhpVEY1U1BoUDlqVkFiVWc3MVZyaGIwQ2U1bEI3dUtydTJ4YStFUHA0SGpL?=
 =?utf-8?B?Zllib1ZZaHpONGRaYU9aTzdtaUh1OGExYnZwTk5oUms4aExXblM0WUY4dnRV?=
 =?utf-8?B?bVQvSnEwTmx3UzB4WXdYR01oM3Fpc2tjeEJ5UzZrY1hIa2wrY1l5ZFJheFNr?=
 =?utf-8?B?Y3g2cEFEUTNsWG4zSmlMZ1dWQTcrL1ZkVkZRS2ZTQitGNUdMZFNwMlcrOFJM?=
 =?utf-8?B?RTNqaElyeCt3NEJOR2tZcjdDbSsrUi9YMHhySDZkTysvR09scGJoRkxKR2Qv?=
 =?utf-8?B?M251Vy8xbURLWVhTMGhQNmFrSDUrT0hhS2c4a1BURHhMUUMvb25VRGtwektC?=
 =?utf-8?B?QkdKakpWUlRueGJscjFkQUpqejBqcFVqU2IzNEp4aWJzVjdISGJsTWRpUU9x?=
 =?utf-8?B?WWpLakpBdVlkb1drTGNpWE5tSkpqTEMzT3pTSGRXRFJiUXQvZG9qYVVxZjlH?=
 =?utf-8?B?c2xzU0ZyY2l6V0NhTjhxL0NUUWFiOGN6QUFITXlQSUJORDFLQzlZNWlxTTFk?=
 =?utf-8?B?bjdVWEFqZC9XVWFrNEVUbzhQSlpCUFFINWdKblFqSThNeElGaG9XN1dyWWNa?=
 =?utf-8?B?UkU1bllmaUZzMGFVclJlaDJ1MCtmRllTTXhlcHVSSk5kNEdiaVJJRVZKeXgr?=
 =?utf-8?B?U2hmRzNrRCszcW84V2kvejNSUnZhazFlVDdxaUloNDZ3V0t2MXZrdzBiL0cw?=
 =?utf-8?B?NnFFUk4veEVrd21uREdyRkFxR3dKOXR1WVQrTnkrMHFmT094NUFUbXIwNXlH?=
 =?utf-8?B?TTA2elhlVlViRFVwQVQ1OTN1MG85S1RvbmtXRGFzdm1ZdVk3TlNlVCtJa0Ro?=
 =?utf-8?B?WklFZFhyWkUrNUZtcldtTXI2NUJqdXVyYkNBeFZPME5oM0JuTk1OcVUvMUtM?=
 =?utf-8?B?a3E1SFVjWE15ZnB2S01EVlhGbjdTcXJtT3JydmQ3dTdsMDNMbWx1UWlaSy8y?=
 =?utf-8?B?OUpvbjBnS3JoVzNUMGdtVUFUSERYUEh5TTd0UkRaampSODQ2Y1Fvb2VqWmVZ?=
 =?utf-8?B?MC9HUTZzbkthZThuWHRGaFhsOThVVVJyS2VrR2U5RTFUUy9tYVBnSzBQYm1s?=
 =?utf-8?B?bHhXbUR3S204VjdSOEExZjJvazlGRkZKamcrSE1lUVJGUndqaXZZOWdwd1k5?=
 =?utf-8?B?akt5aC9OalJGeHR3eDZvWUhLdHBmK2NCRUYzK3d4MkNiOHpKeTdzNEc5VHgy?=
 =?utf-8?B?V2ZtOEZ6WXk5N1lWUWNWMkdxWTVLSEdudVNBaFozc3VoRWN2MXRPZ0ExNUpD?=
 =?utf-8?B?allnbi9wdWdNMVhYK3E2SUI0a0JiUXY5aHlHd0ZGbTZXMkxBRk1tSWltWEdh?=
 =?utf-8?B?cnJudkJVMFZtV29YdkRXbG0xaVowcEVmYzczM1doOGtOODFvOFdmK3IyTXJp?=
 =?utf-8?B?YU1rYWdnWW1QaFBxUFpvUFhzcHpaaEdZZjkreVNrVFFld3c0bFVRUkdQZFpF?=
 =?utf-8?B?TURCVFRYZStDbjRhOVZXVUROOHJFbGZKZnJsdWFlUnVuMFVERFlRWGVOaUs2?=
 =?utf-8?B?Zlp3ZFR5MHRFOFdmSkxvdWRGMnowTWtudXp3aTRwN0lRM0NNOVVZNnU1MUhj?=
 =?utf-8?B?UERnN0ttYXZacEdRaUMyVkZqc3FuUWp2MmViQjlaMEc3UllNMWVEQm5DM3ZF?=
 =?utf-8?B?bnJXMVdyR1BlcUZBYllVRk1RaWd2WEYzODNQa2ZUVmVieDRNWXJBMldzZElI?=
 =?utf-8?B?dzhQR2hBL0hKZmlnVGE2SHJ3YklyRXJNcnF6NTBLaVkwdThVNEF2anJGcUZZ?=
 =?utf-8?B?RGc0czNJWVhoWER5WWdSMVhxdEVuSldnRnluZ0FWZVN5WVNKY3pXcXhSUFU0?=
 =?utf-8?B?Y0YxN2RpNm4vc3BmeDdTa1ZJVEZnY2R5V051SENkcmZIbkRLa2QxUjN3Wk5y?=
 =?utf-8?Q?738WWkxAjEQrbLGOFY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6560ca9-93ea-408f-a743-08dee0ba871c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 08:41:27.1260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcvaHW8bpzlozYk0liaRIMIl6wYKPmaHr2icUZPUefyeEh9UHvkcx8UqMsoJ6wfO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7602
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

On 7/11/26 13:21, Timur Kristóf wrote:
> Currently the contents of IBs are abruptly cut off and don't
> show the full contents. This patch makes sure to reserve
> space for those contents too so they may be printed.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index aaf091b7f9d0..39b2a4c0e011 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -235,6 +235,9 @@ amdgpu_devcoredump_print_ibs(struct drm_printer *p,
>  			drm_printf(p, "\nIB #%d 0x%llx %d dw\n", i,
>  				   coredump->ibs[i].gpu_addr,
>  				   coredump->ibs[i].ib_size_dw);
> +
> +			for (int j = 0; j < coredump->ibs[i].ib_size_dw; j++)
> +				drm_printf(p, "0xffffffff\n");
>  		}
>  		return;
>  	}


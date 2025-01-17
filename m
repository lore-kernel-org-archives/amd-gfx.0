Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9741C02183
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2025 05:03:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4903F10E2EE;
	Fri, 17 Jan 2025 05:03:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3IWMKQPW";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E308210E2EE
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2025 05:03:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZodcHi6w8gCt6wj9E2NCbz0n+sFhKInosb1J7hnAFVrlKPq6He9mEzH7IAN32cht+aQ3L0LtkHZLz8AzdVhGyl5d7rq6DD9URdvAv3+ljFFK6bRPna8B39Iqre7W5G0A3VJo6ib4n1GTp2mftQ1czhhIQHEBNGpqmhbXbGHTL07K2LHKJc1TGJNM+8q2UzODi0CvXken+GQV1wwjU2OJ6lk2qGyyLf0FKYAf3o5D8IuDYHsJ+RAzxRhGHOreN0OB9xtFe6UHgy0cxY6EfBzPDjg8AVyQOrI+qcn9EqIWXkUIuYaZfWM1M2IwFSLI5iGWfObXh3zE7H2/6K2Fx8kQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwDQrSmTvSRiaB5oTW8LSuXCXG78Yv6vAKfjB3CY1+w=;
 b=rmhTXGIJZH2zJiHyBFM+s0+3hKMZyckkNb191cazjZ386zmF8dTlzW7ckZ4iijbIwCf10L4aVC7zGZa9LgOSBbxuwWD1stSOOZbfNeb8+tzKI459agimXLN7QEfrFF6gZjkn4wQFjVvp8IHJhkDEfin0qV5Gjoz4z1V1wYLO0vVkoX9AstNalUAfRnv7mBlzYR5k1xXLlsmpk6tqyayMh/EpZGBajsBg9pMVCWgzjMS5co3q5R/rvfkcaUl98sxIblZ+DLbxChmL4xLlLPO7Ak143isSptY/hSWA8ARvYLWyICASfXveYoZZl653RrsLS1AWPzPaga3t6qcr5bkjUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwDQrSmTvSRiaB5oTW8LSuXCXG78Yv6vAKfjB3CY1+w=;
 b=3IWMKQPWxslq135fCQI2bx08aTAx8aIgZgWxURwj3HWcPC68ICMg2P9OKJlfK2fEdtLAfBkn6CsyZB10iL16X7hnsPPvl5TWNxU4G8MJE4VVYuAZVkd8VRjx603CeFKoOmX12PGVV7xMZXbmc3X1Rs+ZAZKfjdHA5mOW6vQNKrw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 SJ2PR12MB8110.namprd12.prod.outlook.com (2603:10b6:a03:4fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 05:03:41 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 05:03:40 +0000
Message-ID: <5b47219f-3ef1-4795-ae4d-ff04c88833c8@amd.com>
Date: Fri, 17 Jan 2025 10:33:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 01/15] drm/amdgpu: add helper functions to track status
 for ras manager
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, Hawking.Zhang@amd.com,
 mario.limonciello@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736732062.git.gerry@linux.alibaba.com>
 <789f547f5101fe763a9244d1bda560dd562cb604.1736732062.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <789f547f5101fe763a9244d1bda560dd562cb604.1736732062.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::54) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|SJ2PR12MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae57062-113f-4a88-ed34-08dd36b44efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXZkN1ZSdHQxbldzcmN3ZHg5K3VaTlE0VVplR0w2WDBHTkkvSWZIbDRoOUJv?=
 =?utf-8?B?b0wyM002ZFFDSXVEbHBacG1yMkk5Z1BzMEJRRnQ2TG9kT1QyQitPRmhYcm0x?=
 =?utf-8?B?R0ZHckxEMW16eERIRTArY2YyaXdWNDdRZjR6ejN6Q0Nqb2FoSjVpdm13R3FU?=
 =?utf-8?B?Vk9uYTNuWHZVWXV5bHo4M1A3Zko2Z0IxV1dDV1FhcnlqYmlPZUo2V0R3OHlZ?=
 =?utf-8?B?UlJZZzI0OElxOTM4MlQ4Z216Q3VGeFFaVTFGa1huai9Ya1poSk9TM0F6Q3Uy?=
 =?utf-8?B?eHNkUTg2YVR0eTduWXdmdEhDeE1FN3ZxVFlFcU1VdC8yb0NQOTJzYjBFSTlR?=
 =?utf-8?B?aFhkbE9CcFV5RG9naWpKWGpkZmZLaDRaUVBhWmt6ejhHWjRjSllmbXVTTjd0?=
 =?utf-8?B?NHc2VVJzR1hjbWU5RTlBV05YU0tFam0yK0lvc2N3QTBkK0E3c3dUSjMydGZh?=
 =?utf-8?B?VFlMcEZ2NEpjd1BreEpoTVNDNjJWV1RaaWw3RTJTbEV1K1dnakhPTGhPUnJo?=
 =?utf-8?B?UXZQVFlYcXVycGRSb3FxZWVUeHQrUi93ZmRrVlNJZTZJWHkyZGN1R0I5WUt4?=
 =?utf-8?B?VUQ2MFZla3gxM2V3RkcrWnVBdmxkYjlVSUhCd3ptT2ZwalM3Vk1NejFjUWUx?=
 =?utf-8?B?Y3d6ZXRxc1BxbFFJS0xkTTZRSzF0QzVKRzF5a29kcW1EU29vMzZyQTdxWm5k?=
 =?utf-8?B?TlpENjdHQjBuK3V6ZmRJb2tPWkEyQVdhbHJOTThlNU8rN3BrS0ZMWkFhNDE3?=
 =?utf-8?B?ZnRzdE1DMmU1NFgrb25wcE1vOUFEajJ5amhERmpOSzVmMVV6S3h6UldUOUN5?=
 =?utf-8?B?STlRL3pMbktlVjBFVHh5Y05oOGNTc1loUlIyTWIrNnVHZi95ejNQRW9ZWFk5?=
 =?utf-8?B?T3d6dnZGMFh4U25pNjFUY21OUFBpS3VaSzRQVnpXdGRIZUNpQUxuWHc5eldJ?=
 =?utf-8?B?d0E0N0dDUXY5VFpmZ1Z4TVBPVTV3NHU4NC9ybWhvTnVJcG4vVm05Wm9WS2la?=
 =?utf-8?B?cXpHRFgvcGR2N21Gcy8xK1NpeDhuVnc0UzB5bnBjT09BRW5PU1Uvc05SZFpp?=
 =?utf-8?B?Z1p1NGwrSVRQbVlJMXBOU1U4dDRxdUdkVndzcDFRRjRpTXhaZ1VWWTNrZU9y?=
 =?utf-8?B?dnRPSi9QN3J4NVk4clA2ZFc4UllYcnlhOHpnSGxqcGdTWWtOdkZnY2hoTS9X?=
 =?utf-8?B?aHlKZjdvb2czaDNNQmQ3bmJhQ0tVZkdXd2VUMFNLUUREeFVOeG8wTVNRVlZs?=
 =?utf-8?B?WnNRUXNJK2ZySi81Y0dNZWM3U1VKcnJUb3R2RTkwNHZHZmI1eWNOREZNNVNZ?=
 =?utf-8?B?d1Q3N0lIYVlIZDNDbU9aaFFNa0QyVmZQYnFJc3MvbzdhbDRkMXFwbnNvUDFH?=
 =?utf-8?B?bk03cDdiNGQ3Z3JyZmNqeWRFOHd5NmJob0djZWg2UGRpYnBvSHRmdGhjdHBu?=
 =?utf-8?B?L25meDVSNEtxd05oSWpQUlZEc3pFemFFV05pMlhQWVRvdVhHS2xVNTQ5SDVZ?=
 =?utf-8?B?WUhuWllPeG5NazNlVDRNTVJ6QnJUQm5jODJta3BvZVdENDFNSUlQUkEzMVF6?=
 =?utf-8?B?QlFTM0c3b3lxcDlMZk5iTW1GSkVLZ0JETGRZdEMrY2t3d3l0QzJGY3VaY05Z?=
 =?utf-8?B?K2kzTEN2L3lsWklSamo4V2hWTDh3Q3d5a0JpZUwweUEwVll3elB6MWZrZ25T?=
 =?utf-8?B?OUV3ODRscElzZHBJczQzSnNNSDhFQ2F0aHorbC9hM1BDTU9sdlJWc1NYUlZu?=
 =?utf-8?B?djJSQXdiaXlrT2tnL1hvYXM4STlKYlIvSm1nb1hlUFBXdnhRcEpMVm1yWVho?=
 =?utf-8?B?STJCdHFRNmJCL25kWkNTSlYyODB2TytXNjlRdkNSbHp1Mnc0TlowYlZOSzFX?=
 =?utf-8?B?elNqeHVYbFdqL1lLQmt1YmxYdjRqSldQb1QvTStFeEdUNGwwdFZTeXgwMG9s?=
 =?utf-8?Q?leCXa4FnKq8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(921020); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEZ1bkR3Qlhza3gwWlYwbHppcjJCQ0MzekFwNFBJUjU5Z3V6OU5EWVM2VGVk?=
 =?utf-8?B?RXhnUDF4dXdCVkhGUjk3dTlpaVNkRXdHaTdmNExvc2lvM2hlSlVJMnFnMlMv?=
 =?utf-8?B?OG5RZUQ3NUFuRGQzYWdqMmZSbmpSMC9jUEIva1ErVEhlZFZ2UlNCSHltajJh?=
 =?utf-8?B?NWQ2YnBpVGZFbzZyL2ozaGIzNGN5TTRRcGZGSnptRFRrVUcvdmQ3M1oyeWhW?=
 =?utf-8?B?MTFJem1wNUREelpsRWtpeFMyVUNBS1Z6NFFHdDVRb1dtdWFRVlNwY2xFdGZ1?=
 =?utf-8?B?MWNSQ0pnVnVBcWNXa2hvQm1rTG5iWnVFQ3N6YlhEMnhoL1c5ZlpKZFhmT2h3?=
 =?utf-8?B?blJBeCtRMitqTkVXcUIyQmozclh3NDZ3eklBSTNoT3o1ZHR0c1hjdlRHaTE4?=
 =?utf-8?B?Y2JuYkxtUnRlU1lLdWVDcGg4Mk9GejRiZmpBZmZqbjZsTDFpYldXdGF5ci9a?=
 =?utf-8?B?SS9iYUdLenN4OGt4YURzK2ZqSnF1SlZHRXlwRzhTMWcvZk5udC9KOENtWk9m?=
 =?utf-8?B?bUdIb0d1aFZiY2NrYldXL2FtQUtVMjBnVEVUNDRHYU5Id29qcmlRZU15YXZz?=
 =?utf-8?B?QVowTmJxOEZWcmZqeWFpemFMTHpXUWZhS2tTcUVpeE85MnlyYUpnMWsrS2Mr?=
 =?utf-8?B?aFB0TkJpMkkybXZrTXp3djV1VEtpN01mcEdUcERIYnVkOEM1MGFEbm5vRlM2?=
 =?utf-8?B?elI2cUZscy9POElFVGovQ2liYllEeG1JL3R6U1ArVXpMazFOc0g5OXVJajJP?=
 =?utf-8?B?Wng2cXd3WE53cXVCRUIxTm9KZGIrRGhFWDlleFdqZDNuelc2NldydFcxSHJN?=
 =?utf-8?B?cUQzRWcvcHRTMWpmdlA3aS9iTDI1RnVBQWZYSEtncUpjOXBhM2I2UE1OVTFZ?=
 =?utf-8?B?dDFQbnJ0SExjdXdjd1A5S2w3NlpnOXVGdWtMMW1ZYjh6VjB6cW5hZmUvcWVR?=
 =?utf-8?B?bXJodnQvWDlGZVdDKzdkY3ZhY1FvQk45MWEvQnM1RjJVNlg5d29vak8vSzAw?=
 =?utf-8?B?RzdYQitWNTFWdXMrblJEbTNobTNqMm4wWi9UM1VyR0swdEZtVFNMTWxzR3Uv?=
 =?utf-8?B?aElMZ2lTaFpvUmh1cGt6UjZ5SmxGNG95eDNOc2YzdzcvUGlFL2prNVIvZlZ1?=
 =?utf-8?B?Z3pMZjlSQkFObGNiRldVNDF6dmVUV01XSkJZT3N4S3VtekozUlQ0UlBxWmRS?=
 =?utf-8?B?bzBaTGxCNVFneXB5TUJoelpIVVkyNHd0UjFzbmFtM0VxNnNERi9Zeit2WGdh?=
 =?utf-8?B?eGNNMlZ4ZG94bjl0Nm9RQUNKcmhaMHZOb04vUk1GSjFGMTNSQzhSdWdKZDNi?=
 =?utf-8?B?cStpeHl1aW45cUhEdXpTemJ0YldNenRMc3B3Z2V1Q2xldStMaFFwN2V4ZFpt?=
 =?utf-8?B?QmRiVnRSVFJLUk1MT1BUOEhDME5OYWZSbFJiYXF4dnVlWFZBbHhWQ0lWOVBG?=
 =?utf-8?B?YW04blNORUhtNExpdVBGRC9ka3BuTTJYZEIzaGRZM09RVTZVekhQdnN3Zm1V?=
 =?utf-8?B?RHZmcHRMMC9sRjJpT20xd1FYdVpGcHN6THlXTHJIVXJSZUFrbjU1UUhtVy82?=
 =?utf-8?B?Z1dBd0FaNUY1N1dCbW9qeEU3UFZ3NDJMSkRjN1BoZ1VXQzdPbFJoOTNEZlVq?=
 =?utf-8?B?NWRZMWlGQ1I1aGNsS0tXd2hWRENQWHQ4MDcrc2FZTWllNzZ0ZmhibCs3U3ds?=
 =?utf-8?B?alBQa2tLUVdwWlJUMkhaYjlhNGt0NzUzMXBTU3o1bHNJWWhXQStvTmlzejh4?=
 =?utf-8?B?dUhkb2VMdTVFblRRS0xaUyswY2lhemhrRXlmQWFxNzdhZ3RwWUJwUEVod20z?=
 =?utf-8?B?cW5SNC9Jc1FyMEliYjExd0lFY29ybEl6Y0d4alJYU1ZEeVJLM0w5cDVuNE5B?=
 =?utf-8?B?V214V3NvTHE1cjFYWmoyMnd6dmpkZy9wak5RTk5Pb2RFZW83Z2NMRE5GcnNy?=
 =?utf-8?B?Vnowd0JJa1JhOU15eHpNZ3FDWkVuWTNYS0pDMW5mNmk0UktKRVJTaFZzaHFG?=
 =?utf-8?B?OVJNU25jRmNLeXVXTGJtdFo1eW9JUWVsTVZCaHVkeWZUb3B5OWkwVjFRdndB?=
 =?utf-8?B?WDJVcEtFRkI2bzBIMDUrcEQzemwxQ2kweC8rZzZNZGQyOHlQZlBISGpMT1Iz?=
 =?utf-8?Q?M9O2KCn2MxLS9gbIcPn9JFEO1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae57062-113f-4a88-ed34-08dd36b44efd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 05:03:40.7849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EZoX8e7wCI5/cmo8SSyDwvittHTCMWyc4+JYtwoEVHLs9xOW2enx0C5FaghBF1R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8110
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



On 1/13/2025 7:12 AM, Jiang Liu wrote:
> Add helper functions to track status for ras manager and ip blocks.
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 38 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 37 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 10 +++++++
>  3 files changed, 85 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5e55a44f9eef..f0f773659faf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -377,12 +377,28 @@ int amdgpu_ip_block_resume(struct amdgpu_ip_block *ip_block);
>  
>  #define AMDGPU_MAX_IP_NUM 16
>  
> +enum amdgpu_marker {
> +	// Markers for IRQs, used for both ip blocks and ras blocks.
> +	AMDGPU_MARKER_IRQ0 = 32,
> +	AMDGPU_MARKER_IRQ1,
> +	AMDGPU_MARKER_IRQ2,
> +	AMDGPU_MARKER_IRQ3,
> +	AMDGPU_MARKER_IRQ4,
> +	AMDGPU_MARKER_IRQ5,
> +	AMDGPU_MARKER_IRQ6,
> +	AMDGPU_MARKER_IRQ7,
> +	AMDGPU_MARKER_IRQ_MAX = 63,
> +};
> +
> +#define AMDGPU_MARKER_IRQ(idx)		(AMDGPU_MARKER_IRQ0 + (idx))
> +
>  struct amdgpu_ip_block_status {
>  	bool valid;
>  	bool sw;
>  	bool hw;
>  	bool late_initialized;
>  	bool hang;
> +	uint64_t markers;
>  };
>  

This fine grained levels maintained at IP layer doesn't look like a
proper solution. It's either IP or RAS block has the required IRQs
enabled or disabled. Unwinding them needs to be tracked at IRQ object
layer and not here.

Thanks,
Lijo

>  struct amdgpu_ip_block_version {
> @@ -410,6 +426,28 @@ amdgpu_device_ip_get_ip_block(struct amdgpu_device *adev,
>  int amdgpu_device_ip_block_add(struct amdgpu_device *adev,
>  			       const struct amdgpu_ip_block_version *ip_block_version);
>  
> +static inline void amdgpu_ip_block_set_marker(struct amdgpu_ip_block *ip_block,
> +					      enum amdgpu_marker marker)
> +{
> +	WARN_ON(marker > 63);
> +	WARN_ON(ip_block->status.markers & (0x1ull << marker));
> +	ip_block->status.markers |= 0x1ull << (int)marker;
> +}
> +
> +static inline bool amdgpu_ip_block_test_and_clear_marker(struct amdgpu_ip_block *ip_block,
> +							 enum amdgpu_marker marker)
> +{
> +	bool set = false;
> +	uint64_t value = 0x1ull << (int)marker;
> +
> +	if ((ip_block->status.markers & value) != 0) {
> +		ip_block->status.markers &= ~value;
> +		set = true;
> +	}
> +
> +	return set;
> +}
> +
>  /*
>   * BIOS.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index f0924aa3f4e4..5e19d820ab34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -5207,3 +5207,40 @@ bool amdgpu_ras_is_rma(struct amdgpu_device *adev)
>  
>  	return con->is_rma;
>  }
> +
> +bool amdgpu_ras_test_marker(struct amdgpu_device *adev,
> +			    struct ras_common_if *head, int marker)
> +{
> +	struct ras_manager *obj = amdgpu_ras_find_obj(adev, head);
> +
> +	if (obj && obj->markers & (0x1ull << marker))
> +		return true;
> +
> +	return false;
> +}
> +
> +void amdgpu_ras_set_marker(struct amdgpu_device *adev,
> +			   struct ras_common_if *head, int marker)
> +{
> +	struct ras_manager *obj = amdgpu_ras_find_obj(adev, head);
> +
> +	WARN_ON(marker > 63);
> +	WARN_ON(obj->markers & (0x1ull << marker));
> +	if (obj)
> +		obj->markers |= 0x1ull << marker;
> +}
> +
> +bool amdgpu_ras_test_and_clear_marker(struct amdgpu_device *adev,
> +				      struct ras_common_if *head, int marker)
> +{
> +	bool set = false;
> +	uint64_t value = 0x1ull << marker;
> +	struct ras_manager *obj = amdgpu_ras_find_obj(adev, head);
> +
> +	if (obj && (obj->markers & value) != 0) {
> +		obj->markers &= ~value;
> +		set = true;
> +	}
> +
> +	return set;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 82db986c36a0..35881087b17b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -634,6 +634,8 @@ struct ras_manager {
>  	struct ras_common_if head;
>  	/* reference count */
>  	int use;
> +	/* Flags for status tracking */
> +	uint64_t markers;
>  	/* ras block link */
>  	struct list_head node;
>  	/* the device */
> @@ -977,4 +979,12 @@ void amdgpu_ras_event_log_print(struct amdgpu_device *adev, u64 event_id,
>  				const char *fmt, ...);
>  
>  bool amdgpu_ras_is_rma(struct amdgpu_device *adev);
> +
> +bool amdgpu_ras_test_marker(struct amdgpu_device *adev,
> +			    struct ras_common_if *head, int marker);
> +void amdgpu_ras_set_marker(struct amdgpu_device *adev,
> +			   struct ras_common_if *head, int marker);
> +bool amdgpu_ras_test_and_clear_marker(struct amdgpu_device *adev,
> +				      struct ras_common_if *head,
> +				      int marker);
>  #endif


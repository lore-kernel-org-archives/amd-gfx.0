Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4563CC3ABC9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 May 2025 17:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3AE510EB51;
	Fri, 16 May 2025 17:45:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="32oc7gVg";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67D1A10EB51
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 17:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqcTP2Wsp+KrXeEBC3OGJOAIHKOvxLgior/FbKhPjug2fcsFv9Fg3LV9cOLfoxwPvGNYun0sqYhEg+ovfZwrvcPt+IMMlgSXV5ErPwnQYrfRwE2Ph9DJAAf2GMS6j65ThuVHIEWe8yIZXYcyzflOJYQTryEkJ0U36gTMLDNV59nanKVN0nYzBbVrBhIou0HCSBSUmwMmRV3z+whJOwNfwJBCmGGd9j09EfmcbG9xl61D+BCwj1XyvI8sG2u9fq+GgyM4iYn8hofN1GO5S7mOaC8N/6ulFLla2BuviZsdLD2A42jnb21K7In2AJpqIyphRNwd+J+PvbKnGmnl8Di0iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPUWv+HEiuIrEecdpG3rgqVy0PMr3cpbss5zoqUVcSU=;
 b=DIr7rNbPaFCu3QnX7YiAiaTxb18TDiGYmU6DFp0As22WSQbMc8jbFIkpawk3A+RpMtsElda+i8K9aP9riiohJFpAVN7jpsTmnPxAj5uO4OmrTKb2tji5NatoSy60a/KCzLyRfazK4Z7IxHk3LtnmvxkySo2AWyGOMGry7evKW/icEq4q3S2Z3BYc8iRY6lN9kwRLtRR+Sx9qHafRC/3qXvOZBhYzR38Z+mCkdLbaFMqxgTrhvFW9PozhE9p01QtW9IILbXmHLKT12XVy6c7guAqc5ffMW4Jmvgz4tRAGdqN7flmfaqq3M9LiMxGNlkCRnMaPujm+gLUSVkOc0FiX+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPUWv+HEiuIrEecdpG3rgqVy0PMr3cpbss5zoqUVcSU=;
 b=32oc7gVgJTdRvFdJMHMOW9PFC8XgqHpxlKX45WDfMWHtYgjwz46YPtFVeseMGz6zbfvi6B+77xGhmIsAFEx8Gn430hjNbHEKWeAg8z9/c38sNq8FMTxUcMqtvoP/M4P+sPTo9IJhiQboAl59a3FNFBNm2wWKMQ/PCqWRPAtWi98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Fri, 16 May
 2025 17:45:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 17:45:08 +0000
Message-ID: <0242ae98-0d56-42b2-a58c-2a5bfa3697ed@amd.com>
Date: Fri, 16 May 2025 19:45:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] drm/amdgpu: read back register after written
To: "Wu, David" <davidwu2@amd.com>, "David (Ming Qiang) Wu"
 <David.Wu3@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, leo.liu@amd.com, sonny.jiang@amd.com,
 ruijing.dong@amd.com
References: <20250515164102.808954-1-David.Wu3@amd.com>
 <20250515164102.808954-9-David.Wu3@amd.com>
 <b52390dc-05a3-463b-9bee-001c6cafb303@amd.com>
 <73dd9680-1aca-4e73-b43f-495fede147cb@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <73dd9680-1aca-4e73-b43f-495fede147cb@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: a019e16d-5ee7-438f-979b-08dd94a165d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWxkb0VCMWw0UGMxQitMcWRzY0dzQ3V3emVmSE5WY2lkUFJwc0ZIY2VONU9w?=
 =?utf-8?B?WG1EcDF4SEY3d0E3Z1NvWTgrWmNnem54aWhKZHJjdFFrdEg4SWJtb3hHMUpU?=
 =?utf-8?B?V1orUWRaQklxYlFEWG8vK3E1R1dnZEQwbmU2MHgyL3A5cSsxUlc2eGZCL25T?=
 =?utf-8?B?dDd2NUxVV2JyU1N6SzhmWFVsY28zbHRGY1hBQmVHWEhiWGQ5WHJrNjM3TFBI?=
 =?utf-8?B?VTJab1Izd2JEVituRzFrUkJkNURLOUJwTUltUlJ0MnY3L0R3YU4rQ3dNOGhy?=
 =?utf-8?B?UjBOM1J5dGRNeHZHQ056YmNWKy8yemVxd1BKbkxkWmI0VnpUY21MVVorZW1x?=
 =?utf-8?B?ZFJsYTJHbTBNZ1pLUUJnSUY2SmF4RHFrdlp4OGpCS0xLZ1FsVHM0K1Z5VDRr?=
 =?utf-8?B?ZVJVNW5aV2tiOWVQTWlONjhYTks2cXo4VkRLYXhvN2c2N2k3Ykh1aDByRkwv?=
 =?utf-8?B?YTQvQWVJZmJCam5mdC9KK1JuTjVtaFpxSzJpOC9raFdLbXNKcC9OeHp4SXpa?=
 =?utf-8?B?WS9PM2UzaU4xYk5rY3lUOEFsUVc4TVRMb3VDTkIvMzlTYXJRMUlrVHZvUitR?=
 =?utf-8?B?NzRhU01QT3lubWg3RGRLUHhBSm1WVFVUTlZZcFRTY0pnUVlUQkdSTXZDczIz?=
 =?utf-8?B?N3RxZXdaMG9iWEI3Nm96UjdCTlNlUWtNZXZPTExjazJsZ0NsNFBaT0FueDM2?=
 =?utf-8?B?WWtza015WFpuLzM0UXVsd0s3NlFuNGRJU0NoK2NFa29oUEc1RUN0VGlBSTlr?=
 =?utf-8?B?d0RvTlRqV3FWS094cFBINzlXQ2hJbm1DamlzRjJXZDgzeU5LMlVTUzdHL25t?=
 =?utf-8?B?TnI4REVWaWYwNXE3dE9ueUJxYjE3cG9CTWl1OERueFdzL1diY3JaU084bUVP?=
 =?utf-8?B?KzV5MnJqME9ZWkRFMWVjWHU2U21WZU41UmRBZ3V3dGNVQVphQ2RQZHd6R0xr?=
 =?utf-8?B?NE42QnJ6WTVqWTNFMHJWTUFaZHorckY3blBJZmxveWIwTmNHNy9OVGhjd21Y?=
 =?utf-8?B?aytDZ2c0N3pUQk8xM0hYTGFSVTFhZ2tSTzhtVzVmODFOYzlBT3RPOEJDamhx?=
 =?utf-8?B?MVNnRUk5bnB6bWFZM1cwRHFqWmtTWUdlZEszNmlydGJCeU9SWC9BQ1JSR0lr?=
 =?utf-8?B?SVhpUDlybTlkNFJHTWJtOWRCNmUyNVU3c1BmaFp0bmFGa25ucXd4RGVmdEVR?=
 =?utf-8?B?TDBaczBDZDY2NG1xYW8zM1BNR3BKUEFnZXhMVGhpazlnSEdwUXRvNFJ3bmp4?=
 =?utf-8?B?VzRib1RUcERBMDNWZ1lEMHJMQ3gxZWRlQWVLbER1b3p3RGNKRXliSCtBTXVp?=
 =?utf-8?B?UTd4TFZ6eUFTcWUxTmFPYVJWTU9xUm5tMjErMlhSVnpZdmxqYSszM25KZjBk?=
 =?utf-8?B?YVNRbUNGa0Jyc0QzaUJQQ09yRS9hOHhKRzNRT2o0aEFyQ1JRcGhmTXNkUGM5?=
 =?utf-8?B?TUpVQ3pybkNJOTlvSEJTcnZFQnE1aFdYTzg1R2h1NTU1M0txMzdBSi9MaVZp?=
 =?utf-8?B?Qk51dzR1UWw0R014UE1QemtZL2NFWVZTaUgvMXZwMmx1REdPVnN1T09HWmdZ?=
 =?utf-8?B?ZUFVaUlFUGszcGhpYk9VemZDL1I5b0F0dWZsODZQVHlhTlNWVERJaVg2NGp4?=
 =?utf-8?B?VERiaktkaWFsS1AvTldJWXNRcnB6Mm1idVJLcHhYemJwSEZXTjZzSkpLTys1?=
 =?utf-8?B?U25Pbko4YXI2amVmNGs1bUpUbjJuaFN2c2REb3lPWm1USmMwcUtqQ2hRTVJ1?=
 =?utf-8?B?eGVyRmRUTVpxbUQ4RWJpalorVmhtRCtoc1QyUFpzMUlHeVBKd2VnOXdXdXFQ?=
 =?utf-8?B?RWc4MUhwTEMyNHMxdzlzWkxoRzQ2V0M3RGZER1lvdWVDbW96dG5SdHdiTUo5?=
 =?utf-8?B?TFFEOXpTVXM4M1plakREenRhNVFsekdweTh4Uld0OHplOHJEUmI4M1diUEN4?=
 =?utf-8?Q?X3xZ52vP4Gk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkUxbTN0cXM0S1BSc3hSdkRTbVZpUkI4c1V4WjRhN0hyZnM4cldHWWJtbnF6?=
 =?utf-8?B?TFFZajRpTWlpY0NSUFJvL0ZJMHBOb0QvSXlaNWJxN005RTF1VGpPWFZiMCsr?=
 =?utf-8?B?RXZyOG5lUytRSW9FbDdqUUtaZFB4bnlHdXUvWCtxQzN6RHZXb0dEbzVVMHNX?=
 =?utf-8?B?dlY1LzNId0VVaWpuVEZGZGdmQ1FxZWYvK1dGRFZucjZtV0lMS3JISFVjaEtW?=
 =?utf-8?B?aHpMeklwbDZ5a0JYVGlvd3hwaEc3bjljWm85dXh2cEZsUE9NSFZZeVVSeGk2?=
 =?utf-8?B?cXBFTGF4ZkorZUpqbDVqOVc5MDA3UVdVM053MFNBL2F6ZGZMM3R5Q25ENFVl?=
 =?utf-8?B?WTBKcDZYSXU3NUtuS0VsUDhsQTNPWkxDeGJxTzZvWENDNVA1YmVrUi9mb0F1?=
 =?utf-8?B?M2NyMzZyWG8wRUtqUEhsaHVQcXpXeCtzdTZuYlFWNmE1RnZqNUNNRE5QcDVD?=
 =?utf-8?B?NTQ3bmowMzRNQU5JL1Z1R3krVmtXTTlZU3RRWngxSUxDejlNc1ljczZPRUZy?=
 =?utf-8?B?OEc5R2oyc29lVHJHZXRsRzNTQlVQVElnYXJWQi8xMm8zbkgrUi9vUzJCbURq?=
 =?utf-8?B?VVU1bFZnRjlqcldzQUh1c3BZcnRXdGd3a2w2WUV2bFJ2TzdoNldyRTNhZkV3?=
 =?utf-8?B?SnoraDBpT0dEWjRDbkZ3TlZJS01XUUs1MUYxcFVqU2RHakdIUkJhVVNRSURw?=
 =?utf-8?B?UmtUZTZYRVhGeW9XVnlVdXNvVTFFV3lkc0c4R1JaM0NJSEEzcVpNclNpYzB3?=
 =?utf-8?B?amZIa2lSM0RJcm1UVXU3TmUxbVphQVMxOG9veXU3a2N0WUFKN1dJVDFsSU5o?=
 =?utf-8?B?c3VpUWJhaDFoemYvbk5ab21IV2ZQa1dSWUJHRUNmeUU1OFpNNm9vdDU1WGdl?=
 =?utf-8?B?TnRPNElid0NOTVl2Z2FJRDQvc05zbnlWR20yeGx5NW9iRTlvQ2pHSjZlbWJB?=
 =?utf-8?B?TEl0WWVtVllMQ3ZTNXZiV3JFMmRJVXYyZWwrYUZHWWF2aCthd1dUc1VPTWRq?=
 =?utf-8?B?UW53S0ZIamFrVzZFMlBvOUcrYnE2c3JyNGovbENWRHZpbnZhamovNXNxRGJu?=
 =?utf-8?B?WHArdnJXMm5zUVRPUTRFOVJvSDFZNUxmRG5FdkkycWhBK2FrcmZxUndGQmsv?=
 =?utf-8?B?QjhkRStTS2NzaWFpcGhQd3k5ekNKcHdxaEF0SzhwUWgrYlBOZjRDNWFBa2FC?=
 =?utf-8?B?OFBnUzNIRGJpdWQ5YTF2M3pvVEk5Z043QnF0VFVRWHRNZEVrM3VqSUtSUWlH?=
 =?utf-8?B?S2tGRnFPb0lhZGVHOStYcTFnNUlRaUlsV1Z3VTBmbElDUFhuZ2Y2UTVvNmxw?=
 =?utf-8?B?bGFPVXR2TTI4V2hXNzVtRGJvc0tQRC93emVkdzZpTk9jcUozRGxjSU5uZkdK?=
 =?utf-8?B?WXlnSjF0ZytMaHlrMll0Vm1mRDZiUFdydUhZTmhOaTNwQU1EWFdCVGNYZHdp?=
 =?utf-8?B?NGZFd2doU3JsSEhOZTgxMXZEN0hPMUZsSldSb0JSdmJxbHlSTDRZVU9PTXhi?=
 =?utf-8?B?a2VCZTd1UHF0YVRuRHc3OStKRXo4L2hxTFJGWkdoUFJkRnlaOGpuUVpJclhm?=
 =?utf-8?B?WXd5eENEd0U5QnZpYS9Obm5xVjZnVk1VY0hJc245c2VJNlg2aVFnMjdIRExs?=
 =?utf-8?B?WmJ4VENRVlBMTkJCL2FIQzg2TzJaWVFiWFg4cTNGK3h6ZlFUU0txZWxnaGdW?=
 =?utf-8?B?NjNLMUdtQVJ2Qi9zKzgrOXNYZXdLTWFEb0IrLzZpQlJkTisySWMzTks0NTVP?=
 =?utf-8?B?WEh2R21qSFpicGZ0dElWNmtrUXJJV0VwQnRRR0xnRFphdm92M0ZTY3dZWlNP?=
 =?utf-8?B?Ympwb3c0Yitvbm12VlBuV1pVSHNXUDdKZ3ZOOGF2a2pQV0UxcWNtdTdOaUdG?=
 =?utf-8?B?dGNpNVJXUHZsZlhJQ2I1WGl3NTEyUVJwU0FjMHZNWjYrNmpZcm1HRWY5YXkw?=
 =?utf-8?B?SEg3bzR0VHAvenFxYmd2UUthbnF2U0E4WWc0RVNpakVoNWRIaHJJRkFSMTBv?=
 =?utf-8?B?RzNHaTdtYkl5aFJaZjJGNExxOFl3NjJ3S05MSGNyWTJuM0wxdytIM2RtNmxt?=
 =?utf-8?B?L1Y0d2VZbHA1U0RMMUxmSVpOZmhCMkNNNHhYb2xxVnZUK1NNeEF2Uk51V09o?=
 =?utf-8?Q?gf7BnS4OLMI+pQIwx5fANRy13?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a019e16d-5ee7-438f-979b-08dd94a165d6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 17:45:08.0141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUtqgnHSNN8nLa+Zm3AdPDZkQVben75/BPPbh7alwBUXzIlj7GUht1VM5cvzrwjD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7558
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

Well testing only falsifies things.

I agree that it should server the same purpose, but we don't have a guarantee for that and as far as I can see there is not need to switch to a different register.

So this change seems superfluous if not dangerous to me.

Regards,
Christian.

On 5/16/25 18:23, Wu, David wrote:
> Hi Christian,
> For this change on VCN5.0.1 I will leave it to Sonny for a test. Since the readback is for each VCN instance it should work for that clock domain. As Alex has pointed out that readback post all writes will let the writes hit hardware, using UVD_STATUS instead of VCN_RB1_DB_CTRL should serve the same purpose. I also tested it on STRIX VCN4.0.5 and it works ( using UVD_STATUS  instead of VCN_RB1_DB_CTRL ).
> 
> Sonny - Would you be able to test this simple change?
> 
> Thanks,
> David
> On 5/16/2025 3:07 AM, Christian König wrote:
>> On 5/15/25 18:41, David (Ming Qiang) Wu wrote:
>>> The addition of register read-back in VCN v5.0.1 is intended to prevent
>>> potential race conditions.
>>>
>>> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 22 ++++++++++++++++++++--
>>>  1 file changed, 20 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
>>> index 60ee6e02e6ac..79d36d48a6b6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
>>> @@ -657,8 +657,11 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
>>>  	WREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL,
>>>  		ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
>>>  		VCN_RB1_DB_CTRL__EN_MASK);
>>> -	/* Read DB_CTRL to flush the write DB_CTRL command. */
>>> -	RREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL);
>>> +
>>> +	/* Keeping one read-back to ensure all register writes are done,
>>> +	 * otherwise it may introduce race conditions.
>>> +	 */
>>> +	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
>> I'm not sure that this is a good idea.
>>
>> The read back from specific registers was usually to sync up with the clock driving those registers, e.g. the VCN_RB1_DB_CTRL register here.
>>
>> Could be that for VCN we only have one clock domain, but if you would do this for one of the old PLLs for example I can guarantee that it won't work.
>>
>> Regards,
>> Christian.
>>
>>
>>>  
>>>  	return 0;
>>>  }
>>> @@ -809,6 +812,11 @@ static int vcn_v5_0_1_start(struct amdgpu_vcn_inst *vinst)
>>>  	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
>>>  	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
>>>  
>>> +	/* Keeping one read-back to ensure all register writes are done,
>>> +	 * otherwise it may introduce race conditions.
>>> +	 */
>>> +	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
>>> +
>>>  	return 0;
>>>  }
>>>  
>>> @@ -843,6 +851,11 @@ static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
>>>  	/* disable dynamic power gating mode */
>>>  	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_POWER_STATUS), 0,
>>>  		~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
>>> +
>>> +	/* Keeping one read-back to ensure all register writes are done,
>>> +	 * otherwise it may introduce race conditions.
>>> +	 */
>>> +	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
>>>  }
>>>  
>>>  /**
>>> @@ -918,6 +931,11 @@ static int vcn_v5_0_1_stop(struct amdgpu_vcn_inst *vinst)
>>>  	/* clear status */
>>>  	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
>>>  
>>> +	/* Keeping one read-back to ensure all register writes are done,
>>> +	 * otherwise it may introduce race conditions.
>>> +	 */
>>> +	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
>>> +
>>>  	return 0;
>>>  }
>>>  
> 


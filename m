Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54F7CAC5A5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 11:18:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B2B310E2B1;
	Thu, 25 Sep 2025 11:18:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="obulBo7J";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013068.outbound.protection.outlook.com
 [40.107.201.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 034D410E2B1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 11:18:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igpEfP3ADYbQQQRspnGtaw2ygeHW/Cso5c4WCckFklZuwN7K0IkTBJtacMa84jNQqkWy3syjfoLqRL1TR+d6y1nHk5Tpwn5idH0G302xMK9rxCrYhrccZ3AGeyqGwabDUOlVdlGYOb3As70tMnAWMMszGO/kQUnm01GCxY13kvHjVSllgue9IUQEB3n3lhQV7sEjK8qPKMDmKYZ8kYyBLuHKoLCdLvhW9H/Qg71a6u0/NBPA9U8XeBUXIwQ9hVImBGUk9Vodtva1kOZoY3hKapESCtWZ8FPjP1UFG0WHQMaNF9lUrjSgY2OotcVeG/eAp4R5KyrxvRjWCz9ZWSHn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kDoGTavAQIz4lB9Ly6YZBe4J+7RwZNxtktzOBs2ZFo=;
 b=kE8QRxyY6vbtTCZhe58vG0mtWhPiu461HtdcuopF4v/MvuOkhaUpOZ5wrXTUjThPFDC0xGzmS+FJWBtS4L876RF6Gn4l7bHkrqNDz6lpe5M6yIVbi7DfWDmIEfNnVQueqg8pTG25DerHJTk7hYtbZh6xB6WqvetgEIgf+pB9M8U/cwnqpgIvrzw2pUiOZ4UO3gK4QwDihpTHbH+IiEZ/DGU4+zaUONuRQYzuFa3SqwvxxKwzMGAjgQ9IeCQSnJeGPYZ4e8ldp9mcJz0K0D4tZI0O4lasCDaRMN7iGClQoG4FGLUoBHUAVOiOoltA7zk8c9WDdpEVgyXnqMWJ/KK+vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kDoGTavAQIz4lB9Ly6YZBe4J+7RwZNxtktzOBs2ZFo=;
 b=obulBo7Jw5dz1MwI6Yjorzq9lfg2rreh6Eyc9nSuuKbBLkKHnA++sKwn4zuTHt9VBQKghybiIBnHfPSRUZDr0XJZhejEFpHwU/ivvF30FstnNg4+n65PR6/C47SQ39YETbhMmcAycJ0Dg5BAnm8XeeejCN/AhlI1esf6E7mLbV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB6836.namprd12.prod.outlook.com (2603:10b6:510:1b6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Thu, 25 Sep
 2025 11:17:56 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 11:17:55 +0000
Message-ID: <a2c48814-58c9-4d33-9360-d4aa7314c7ea@amd.com>
Date: Thu, 25 Sep 2025 13:17:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Merge amdgpu_vm_set_pasid into amdgpu_vm_init
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20250925103305.2897509-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250925103305.2897509-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0212.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f077b98-32ff-4cd2-6ad2-08ddfc252cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXVHYzVUMXBYL3lhbGNDOHFPZ0FVaUpqaS9xQnZDTGNvVk44RTBRNUx5NG1B?=
 =?utf-8?B?Rm5VcFlPT1Y1TDhPaHQrODJkSXZGYlNpQnFmdlg0RytsU1pJcjZjMUNZU2w4?=
 =?utf-8?B?Mlo1TmpMYzQ4eGhsMktwSEIrYWJYV3MxQk90c1FvVjJCWkxKTS9PeXFFSFFo?=
 =?utf-8?B?MFhIQjcyKzhGVWx5SnoybVNGd2xSc2xLZWprMUxLTGoySzI0ZWI4aGMwMzBB?=
 =?utf-8?B?bmF6MWd2YkQxR0xWSzV6ZEloTHhUSXpNK25yYVlibXdoZHNzdU5pQjRoeVlG?=
 =?utf-8?B?dHdxN0l2dy9WRHNaWTNoQnJoOGV6UG44ZDRGbDg3cXI4a1NySG9RY1hYdThz?=
 =?utf-8?B?YXg3NUY4MGpsbjlRYzRzcmx5bmtNTzlaOEcyaFpwbUJET3ZYNWtTS1hTZFl2?=
 =?utf-8?B?OFEzZzZSNCtlS25wTzJZZTBJZ1VRMjJBUXlXZFZtUG9vSENLY3FSWUVYcytE?=
 =?utf-8?B?YmdoY0RzcVNsbllsOXVRcEpGVE9VelZodUJtTHJWTTQ1RFU3UVU1WHBHN1Nn?=
 =?utf-8?B?eFJTRXlUZlJ3b0N6MUtvTHcxZUdTOThDbkd4emVkcHA1VWRxZG5JaG1JQUtH?=
 =?utf-8?B?ak42QlV4ZktsRHZTcUlQaTQwVzFSTEg0c1FHTVlXMWtBVldnamxyRUxBcXlj?=
 =?utf-8?B?Y3ozR3BBYi9rbC9qWWt6S1VRakJSL2cwT2Rwckdmd3hyQW54eng4Y3hRaTNZ?=
 =?utf-8?B?QmtNSXZ1cWE0UWhDdno1KzBRT3pmN2MzeVA0ZW1ld0xOK254UmhWRkNKY1Rn?=
 =?utf-8?B?U2VidmorM2JlNWwwOTY3WDdLTklaVzQyN1RBdi9QNEYxRHFnajh0OGUreGdH?=
 =?utf-8?B?Qlp5dEF6RmxYaU5TV2NvM1EvTnYrM0x6dG9CbWw2Vy8rVVlDZGIrSUxMSkpE?=
 =?utf-8?B?NHlwb1dYL1NmM080Rzl1c1R4VlgrVUIzcThoRHFKRjM5Ymx0TVVOb3NGdjY1?=
 =?utf-8?B?dDZlNDA2d3RJOHNaYnh3SklnM0JMOFdBNS9OaS9MbjFCUDZUTGVxZjNOc1px?=
 =?utf-8?B?RG9sV3FodkZ6OC92Sy80cFhRR2ZLLy84YXRyUUFoSlJicnFxZG1FbXFEb1pC?=
 =?utf-8?B?QzUxTEFrTWxFVEExd1ZSaUl5ZGEyZEdoRzhnN1JlK2FXTERtc2llSGJZQXdS?=
 =?utf-8?B?a01aV21Oekd1cnhwV0V2TFBUVjNDb2JPU0kwM3lxOHU4cUtQbnZNdm9JWnRU?=
 =?utf-8?B?Q2N2dHlHcmxwWmhQOGdhV1V1WENBYWx5NFRXRVM5S29MTDJmK0dWMnVSdlVB?=
 =?utf-8?B?QUZxcDBiTkJyM201WmVDSkdqZ0RZTEZIL3loN2sxakVqQnlmMkxjY3Z5Rld3?=
 =?utf-8?B?aXNSWkg2SG91dmE1OW13Zmw5WGtnZG1MOXc5MDJNNVpCVXQ5YURFZEEzVUhG?=
 =?utf-8?B?aUFtODIyR3JOeVhOS0NwUzZLQ0J2b1ZWQUhkZzZsUzZtRDE0ODF4b2NheXBr?=
 =?utf-8?B?RllYRmROMy9VeldORmozVXBBc3dqYytOdzJMaXFScDN2eGpjQ0pUMU5CcHhj?=
 =?utf-8?B?a1hmSmc1YVZrUURjby9iSW9LRTZlNEc0NXNFWFpXNkdnQWtGSmQ3RGlmVWdM?=
 =?utf-8?B?TnIwQWhYU1p5SDAyQ0IxSlNuU0JWeWZNNHZRUzlsMExxbzMrNGtlNWNKUkNU?=
 =?utf-8?B?SzVodmpxZlZKWlkxUFFSK2dyaXpvR29vT0hQdm5DM3l4MXlIRkZnaEllTklr?=
 =?utf-8?B?VlZiRG9uaVUrdGRteFRiY2dmSTZ6ZGQzRFJTS1FaL2pMWklUQlNTVWF6ZExF?=
 =?utf-8?B?SXgzR1Z3eW5zcUhFWkplQzU4UkIwMEg4YVFGL2hPVmQ3cExNbCtSN3pvblkr?=
 =?utf-8?B?cjRZc0xKNzZJYkVJMmtDUUlaSFlkM0RiZWI3OTBRWnBscTBHVnZZTXhBM25W?=
 =?utf-8?B?SFFFM0RCaTNpdjFnWWdwUitaR3JVTW9zTVN5WDdWM1NtTjBpOFhEckVHOU50?=
 =?utf-8?Q?FGNYdC6QGmU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3JKcWQ3TU4rNXpHUDNVbVU4M0FESU9OWUNYeTU3eHowS1VsTGNDZnFSdXFK?=
 =?utf-8?B?NmJIZEk4RUhoTUd6YUdXTWNjRUU2Q0QvREV6dzVsdUhPK1NEbWV1d0ZLOVBU?=
 =?utf-8?B?VWVKQWVQaHo1YWttV0FEVjA5TCtJeStiUkxuUW54b1haWVVFZUZ3djJPc0ow?=
 =?utf-8?B?eVMySHd1TVN6SFdxNDVmYkFHUzRLOTlmSExtMWxwU0ZPUXl1bUhQWlkwY3ZP?=
 =?utf-8?B?R2lTTHhkZVBPdU1oL1ZJaVdSS255b0Z4ZVFTVVJWTWFwRU15TkdCbndFVGky?=
 =?utf-8?B?MDdJUHl0bU41aUpyanRmQWpyaGFWTjU2Qzg4YmpEU0l1TGt6WEJaUmxrQUhX?=
 =?utf-8?B?Rld0aGRtQzZuSWxIeDIwdU95d0IySzdPTllEWnJ5ZmNJNmlXODFLSVhvak45?=
 =?utf-8?B?TzhBSi9qcEpGMHFoV0JVaWJhNU9LTnh0dDlhSzkvV3VnN29OY0VNVDl2NWxw?=
 =?utf-8?B?dXIrQ2w2VHVTcThGeTdKOFhqT0FwMWRvNlR0eEROSm00N1pRK2lraUFmbnhN?=
 =?utf-8?B?cHFxNFl4UXJxQThxQXUxZUM0L2phUGxTTXEvS2M2R1Z1clZlL2dEK1puV1FO?=
 =?utf-8?B?WVk5U0VvaUFxMlpDWEVYc3JGRjF0M1IxSkZLdmI3Q05LQmR0d1E2R2hERFhE?=
 =?utf-8?B?elZjaUlCZkdTQUtwV3BEd3VlaHo2WnFDSTNtV2pTSzMzSXovUnZleVEzazFR?=
 =?utf-8?B?cjdFRlBrdnF3MXI2bFVUTEFzV3BEZEp6SnBWaHUxcjhzM1FUM01hVDFCL2I3?=
 =?utf-8?B?cEE5cHptbm1VM1U5ditNcDR0Z1FNNEFiN0hVTitPQU1COG5VT3NTR2U5TGhZ?=
 =?utf-8?B?MGMyOS8xOHZCbjlzZ2M5endpT0VuSXdCQmVGdHBjR3IwUHBHK1h6ODA3T3hj?=
 =?utf-8?B?OVFLNWVCMlBaUzRiN2tXMGQ2VGhlNStLa05kRXpuSkFVdDhGS2lpU05aZmJ6?=
 =?utf-8?B?cEhpdWhlUTRDcWNHQWJtejlFRXJWK2FjdUY4eFVvdjAvSEZPTzJQL0IxeFlh?=
 =?utf-8?B?aCtwVkljcWR5MmpKbFl4b1BMWHJuOWlUUEpIc3BsanJBSmFXTHlhSFl5Yy9M?=
 =?utf-8?B?WnUxbTVFeWZYM2pmUWlWSEN3bk1TTDBMQStHR09qbzhLMWdUUHRudWpmNTJS?=
 =?utf-8?B?RXdubXRxai9jRjcvdkZES01KSU00Szk4Z0kyMTZHMzJ4YW5YQkcrOHN5Wmlv?=
 =?utf-8?B?WXhQYjVWNXozbmMxMTZLb21NaTB1dkNDdzE0bnRudUVFcVllRjJWZDBiN2N6?=
 =?utf-8?B?MXJ6eW41akJ6T0crUjNENEFYbVVFeXAxSE92R3dudUZhSW9HakYzMG1NTTd1?=
 =?utf-8?B?eVp5WVVFVEZXQkEwcTZZcWRpRFFpdmpiR2tud1Fhc1JzN1JNY3VES2xWWFk2?=
 =?utf-8?B?WEdlWXFIMjhhMFFUMXlHZmUxSk5oTFdRczZvTklmVEkvbHJ5RnJHaXp0V3Yw?=
 =?utf-8?B?NS9BU3daQWxKYThHQkdwcUo2b0ZjWHBONEtJN2x1UWQrd1JyWkpjOFRNeHlN?=
 =?utf-8?B?aGhLblVGRGI4ZWpEamE0am5VZEg5bXlBR0xrdG9hVjJNUERKYmF4dHRIdVRQ?=
 =?utf-8?B?WFdUWWtkMEovaDd2OXVRZVZ2NWZnUVYvNjRGV0RueXQrc2Z2eFZOc1pMSzdl?=
 =?utf-8?B?NTNlK2JuajJscVl0TzFnMEd0eGtLdTFTeXU4aVBEdm5PUm04R1lGemtmSVo1?=
 =?utf-8?B?RDZTVG0zNG1ERWMvTk9ZYi9jZXM0Vmx6REEyRFJxM3p2SU1MNjdiTkZVSlp5?=
 =?utf-8?B?clB5Nk5VdG1XS29zTkFGdzJBT2dHSlVtSFNMazA2WEVrSVV6c1hod2JYaFZF?=
 =?utf-8?B?cWRrUUkzUytPQlFiVWVZOHhyeldyNnh4ZXd3VUhrdHpkUXRkR3Nqc1k1dGNi?=
 =?utf-8?B?cjhZNGoxRmFBRHJpK3MvcFA3eWNqTGdLSEZqT0pHcmUxTlhybFkwT1VPSUtt?=
 =?utf-8?B?Ty9BY2hEY09ieFJjaEp3NndYWGhMeHNoTXcwSEtoQlBLL3FjYTNyQjhWeFNW?=
 =?utf-8?B?L1lkQ1kzTmRHeG94SS8yZXNlcm5lMWlXUllKMnM2anVQczZMaU1heVhEb0hR?=
 =?utf-8?B?UVZVVjZwb0RSeEhuREIranZCRTkrcVp0NHNieHhhWWRIeG9pWkYyT01oalJT?=
 =?utf-8?Q?hrK/yp1xMQ79pwzQWACYbCuZy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f077b98-32ff-4cd2-6ad2-08ddfc252cf7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 11:17:55.6549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHMMGO5k//e0QQc6pk37NY1oNoXXs2TUCtc5A5U0yqbGfxZxUhVgvzgYNXT1gmMy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6836
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

On 25.09.25 12:32, Jesse.Zhang wrote:
> As KFD no longer uses a separate PASID, the global amdgpu_vm_set_pasid()function is no longer necessary.
> Merge its functionality directly intoamdgpu_vm_init() to simplify code flow and eliminate redundant locking.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 10 ++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 30 +++++++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  5 +----
>  3 files changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 8676400834fc..a9327472c651 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1421,14 +1421,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  
>  	amdgpu_debugfs_vm_init(file_priv);
>  
> -	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id);
> +	r = amdgpu_vm_init(adev, &fpriv->vm, fpriv->xcp_id, pasid);
>  	if (r)
>  		goto error_pasid;
>  
> -	r = amdgpu_vm_set_pasid(adev, &fpriv->vm, pasid);
> -	if (r)
> -		goto error_vm;
> -
>  	fpriv->prt_va = amdgpu_vm_bo_add(adev, &fpriv->vm, NULL);
>  	if (!fpriv->prt_va) {
>  		r = -ENOMEM;
> @@ -1468,10 +1464,8 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>  	amdgpu_vm_fini(adev, &fpriv->vm);
>  
>  error_pasid:
> -	if (pasid) {
> +	if (pasid)
>  		amdgpu_pasid_free(pasid);
> -		amdgpu_vm_set_pasid(adev, &fpriv->vm, 0);
> -	}
>  
>  	kfree(fpriv);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 108d2a838ef0..6a4902c972cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -149,7 +149,7 @@ static void amdgpu_vm_assert_locked(struct amdgpu_vm *vm)
>   * pasid by passing in zero.
>   *
>   */
> -int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +static int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  			u32 pasid)
>  {
>  	int r;
> @@ -2552,6 +2552,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>   * @adev: amdgpu_device pointer
>   * @vm: requested vm
>   * @xcp_id: GPU partition selection id
> + * @pasid: the pasid the VM is using on this GPU
>   *
>   * Init @vm fields.
>   *
> @@ -2559,7 +2560,7 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>   * 0 for success, error for failure.
>   */
>  int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -		   int32_t xcp_id)
> +		   int32_t xcp_id, uint32_t pasid)
>  {
>  	struct amdgpu_bo *root_bo;
>  	struct amdgpu_bo_vm *root;
> @@ -2636,12 +2637,37 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	if (r)
>  		dev_dbg(adev->dev, "Failed to create task info for VM\n");
>  
> +	if (vm->pasid != pasid) {

That check is superflous and maybe even a bit dangerous.

When amdgpu_vm_init() is called the memory backing the VM is freshly allocated.

> +		/* Erase old PASID from XArray (if non-zero) */
> +		if (vm->pasid != 0) {
> +			r = xa_err(xa_erase_irq(&adev->vm_manager.pasids, vm->pasid));
> +			if (r < 0)
> +				goto error_free_root;
> +
> +			vm->pasid = 0;
> +		}
> +
> +		/* Store new PASID in XArray (if non-zero) */
> +		if (pasid != 0) {

> +			r = xa_err(xa_store_irq(&adev->vm_manager.pasids, pasid, vm, GFP_KERNEL));
> +			if (r < 0)
> +				goto error_free_root;
> +
> +			vm->pasid = pasid;

Just this chunk here is needed, maybe with the "if (pasid != 0) check around it.

You should probably also adjust amdgpu_vm_fini() and remove amdgpu_vm_set_pasid().

Apart from that looks good to me,
Christian.

> +		}
> +	}
> +
>  	amdgpu_bo_unreserve(vm->root.bo);
>  	amdgpu_bo_unref(&root_bo);
>  
>  	return 0;
>  
>  error_free_root:
> +	/* If PASID was partially set, erase it from XArray before failing */
> +	if (vm->pasid != 0) {
> +		xa_erase_irq(&adev->vm_manager.pasids, vm->pasid);
> +		vm->pasid = 0;
> +	}
>  	amdgpu_vm_pt_free_root(adev, vm);
>  	amdgpu_bo_unreserve(vm->root.bo);
>  	amdgpu_bo_unref(&root_bo);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 3b9d583358b0..556d0483c6bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -503,11 +503,8 @@ extern const struct amdgpu_vm_update_funcs amdgpu_vm_sdma_funcs;
>  void amdgpu_vm_manager_init(struct amdgpu_device *adev);
>  void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
>  
> -int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			u32 pasid);
> -
>  long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
> -int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id);
> +int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, int32_t xcp_id, uint32_t pasid);
>  int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>  void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>  int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,


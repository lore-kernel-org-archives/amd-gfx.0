Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C48DCE8D79
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 18:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D02C310E276;
	Fri, 14 Nov 2025 18:53:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fn9I2ZFz";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2D1D10E276
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 18:53:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wY1xvSYwrtMVqL52Q7wdjCjP5IPSVsVDQYgXpiIs8+bJfVhCmuvWdhzCD3Gqt2fVBJWhUmnqCUIRbuNMyHtNVh9Dpq/vyq63+tp10i6l4rC5xSUf03E8ATrNYUYyxBw59ZjkZ7zAeOoWixKZzgcn9vuM7JpfRGcZuwcwDWAni+gBeXnrXS6YHEl45MYSp6MkIN268+LyQs1ynpO6P1P/CzU6BSg2ZvTOKch/6vYR2phVwV1U9fKbRsILsmq/zDV139owDIPkVGFYesXWs4uaDVcyfrSz2OC/5XstiBh4I+XTf9STIoMFr6l8WMzWYzmhpxsrwIo2yDIYn1MgboZukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJk6UcDflKz3BP0t/ukncdwI1gIUD/ADqTmUYYY9wMc=;
 b=v7dp5cZ0WCMXtHXkYxCSFnSgfjabcT343019S9wGrMNrMKL8ACDtR7Oc8ne4RSnVnK2kIM/i+IrDruQk54yDUXHXoY/Ru9+b0gHowInihu5bdyAvePSPBiYBk/zNjRYhOcfl4yZKKvpIrzLfC6jpHl2igvGXm2tQ9Lg/cTGw9VFMDF49dG9qjvKrjdF4fV+GGQWIZvouWUspc2v8JkJorngTLBl2siHt6h+jccF0mK/4ROR26TyXB+YN3RGT6bAjFvlhSSES9ZRg5bJqLUncDx9B65HdNfQZvcibUrdzKwVAG3BJ1kxVYPHZfE+ksxmcE6otRe0CrmLCgAlejiNIWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJk6UcDflKz3BP0t/ukncdwI1gIUD/ADqTmUYYY9wMc=;
 b=Fn9I2ZFzbopDpI4a4reb547C0HCQfl9Zqx8AzUb7K94foexzvuaD64aMcI8owjLWplVUX+pNtj9Zbd9+eUQhoVSug+1KLbijVHpq1Qvyj2kWKvmUMNYDrq910C7X3Sa4jYNQw4TGWtVipG+outJg92bo/WM7/1IeDfOKB7Tpeco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 18:53:10 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%5]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 18:53:09 +0000
Message-ID: <34a397c8-bb8a-b7a4-372d-14d335c1e55e@amd.com>
Date: Fri, 14 Nov 2025 13:53:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] drm/amdkfd: Ignored various return code
To: Andrew Martin <andrew.martin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20251113183155.1120872-1-andrew.martin@amd.com>
Content-Language: en-US
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20251113183155.1120872-1-andrew.martin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::22) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: f56d5593-f4c3-44e0-af6c-08de23af0dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjRLb2JRQVY1YW5zRmV4NDZGL05EaWY0V1hCWU1mWk42VDBrN3pRS3I5QU0v?=
 =?utf-8?B?WHVPbllpcC91S2QzR1pEcWdHWjR2d2svUmJNQWRVU1RGbi84WU4wbnQ2Q1dE?=
 =?utf-8?B?VGhIUEQ1TUsxQlVvd0hmZTE3L0trcjA0L1k1UEdOZTBoUElmZk93amUzbitS?=
 =?utf-8?B?cHlKTDFrT0xGalZZNnEvQkFxbUVkQ1c4TStGUWZSM1o1TVArSzNkMjVoblhX?=
 =?utf-8?B?MzR1V0kzelNPTkVyMXI1YWNFTzQzV2NpNUpxazVaNkc3U0o2WlV3ZUtPRkF4?=
 =?utf-8?B?VzNFYjlzeGlpY2dKbDlZclNIL0JGNmxHR1l0NWl1TXlVODJKeHhlN2paWW1D?=
 =?utf-8?B?bHo1d1pBQk03WGhFTDB1aEc4cnVYaGxrQkxNWmZMeHJLVmxIUENOblZpR1Zs?=
 =?utf-8?B?N05TUVpmR2tQMnB1Q3BaNnM2MGh4WTVEM0R0aGQ3a2x0SVl0RTlKNERUUmQ3?=
 =?utf-8?B?OXArUmpqYk9RUHN0NHRtUDllOUNEbHl2S1lOSDgzK0hrcEtwbFp6clNsWnpB?=
 =?utf-8?B?ejlJb2ZRN1BybEV2U3pybGZiT0JZQW9LNHNYdmJpWmRpOUhJREJDOEZYMUtV?=
 =?utf-8?B?d1VDeUVKajllYUVuZldyNnpWM04xQm1LLzVIeXZYRzhVTlIxdE1DaGdRbWJa?=
 =?utf-8?B?YlZUSFg3alhDdEQ3aTNBVGNpamF1N1hGMWp4anBzREFmWmZna0pwOVhVc29G?=
 =?utf-8?B?cVpUR2gvcEVoSmNNZXAxRlZtWVJPcERkTEJoaTNJK3o3K2RJSWt4V29UM3pF?=
 =?utf-8?B?MkRRNGZUb2Q5a0pPaE1RRmNNNHJiejhldEd4ZjgzRFpwcDZ2YThxdE9IOE5V?=
 =?utf-8?B?Wnk1d0NwaEtIRmpOemk5YnBrNnFQNHllUjNMQjlvZSszMmN6ZzZUN3AxWm50?=
 =?utf-8?B?bU9QcVZiVkpxNDliaFRmeFkwcS9Kc3dZVTlvblFiYkNsRzhUVjJqR1JGb1pp?=
 =?utf-8?B?NTVhREt1Sm9IcjA4aHRzMHhRK2xTeCtCdDZ5Q05SMWRKcXE1cExFSmw2NFNF?=
 =?utf-8?B?Sm1FaFJyOGhESVFDMnJoR1NlcS9uK2ZWcVdpekdXcUhRZ2U5YnRRM1ZNODhR?=
 =?utf-8?B?WUdhdzBpUk8zUU5GQ2JjbmQvd1FIdGVFSWxKcEIzbGd1QUlOQkdQTVlHSmQ2?=
 =?utf-8?B?bVcyTmM3c0hpbTRSZXVBem1NWGFjbnRFLzVCdHFOVVFvTEEwSTdUQU1QT3Qx?=
 =?utf-8?B?VDhSV0k0SERZVVBlSm4rMWpYOVA1R0dGR2tBS3BqZWlSdzZqcXI0ZFFKMkZG?=
 =?utf-8?B?blZ5TitsQkdSZ21kNkYrck5PM3EwSEVTOUtDSDl5T3g1QTRRSTkrTnhUd1VW?=
 =?utf-8?B?M1dVaGkyK2tGaFpoSjhmWW94ZWJ2VmtEMUlOM1VodzRvcWpmZzQrZ3NmdmVu?=
 =?utf-8?B?TmZTaW5XT0IyTkcvaWVFeVAxd3dMZWxOZXEwQk5STjVlOUEwRnBTQ2N4aWJM?=
 =?utf-8?B?akdOejRZM2lJLytDWUFGblZ4YklQalpQL25sY3haRlMyS0d6VEt6eHdqSmpJ?=
 =?utf-8?B?ZDgxakQrb1orQlYrMTJIckVDWTNXdUtvRUovV1pTWGhyd0ZoTXA3WFRmekRs?=
 =?utf-8?B?U2JtSi91N1g0Mmg4TjhZdDhSWk5jNHdCREVuWStCLy94anpLc3dFVG9Pdjlq?=
 =?utf-8?B?RVNYdGs0WmR6aVN3dmNaOFdkWkpLQ0tyamhNUkhsSHE3M08vWTdMZWgwTFlt?=
 =?utf-8?B?bWJHWEI4Wi9LaXNkVWdibDVmVE9FRkE0cXBnM0oxOGFITjE0aEp6UnhMSDJI?=
 =?utf-8?B?SitGMEFaU2QrTDdvSnNrNFdBN2VxYmcybXgwVzVGclJaSlpBR2x4T3Y1bGp2?=
 =?utf-8?B?Y3hkeXpxN29YV0Q1YzFMMm5SMGk4a0xtdVVWRHp5OG1uaEhwYXZIM3FxbDNX?=
 =?utf-8?B?aWpjZnB1OHJmbFE0bGZWRFlBWXZiTUpqTWI0Q3J5OWw2Q1RwYTR3SjdrYTA3?=
 =?utf-8?Q?pZFb7eOFExiJZTeQnA2iN06q5dyBK5zQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE91MHFHODNPU1dNNzFzWlBtbmwxYlQ3MkYzTndGVnhmSzNETDFXWThFWE5U?=
 =?utf-8?B?YkpDaVlPczBSck1HZnNCUlRCSTR0cDVVQkl2TjF5dnp2VzhSYVE4SWhaRi8z?=
 =?utf-8?B?QUUwcldXMGlQZFhzWDNJODMrZ0llMTJwV1R4UG9pcW55OEZkb0tnZTYvY1Yz?=
 =?utf-8?B?TGluTHBXYUt4dFJqR043bGN6ZVRxSFZOa0k2cW9FRVg3V3JwaEJWUUtIbEcr?=
 =?utf-8?B?eEtYL0RsaGJDYnp1Mkx2YnlhVGpuNjdVeFMyWEl2T1lpd2JFL0xlZmVGZ2k5?=
 =?utf-8?B?M0RVblk2VU82UHRaUS8xY2NNNU4zcnVobzdVZlVIR1o5amY5aHBKYmRSTlBP?=
 =?utf-8?B?WmdjR3BXbjNxUysxQ3FVSXhFb3lrR0xxMjBCNjlaZHVleG0wSHVySEpLTm9n?=
 =?utf-8?B?bGl0WGR5T1JyenFUVFlwd0JUWGhKeU8vSVhQanBQWDB5S1JXbWRxVFB3aDEy?=
 =?utf-8?B?U0JsMmN0dmE3d2oySEpuVm5jQTZoYStHcjRxWENhVkpmUDcrOXVHaWdidU9j?=
 =?utf-8?B?VnBYWkJHOUkwbXRaUldTQTFVTjNNNmo3MFZFRDMxQ0JnSFlJdWVjNHpGTTJh?=
 =?utf-8?B?d3h5cWlRQmNlMytnam5JSi9oVDFWQzdJaE5jYytuZmN0dFhLTGthSlVicFNX?=
 =?utf-8?B?dFF3dWFPVG53cndWWnJrMDhaamlja1VxN1h3RTFXMW1IUmdyOWszWTZtVGRR?=
 =?utf-8?B?WjlQMnVtZk1sTCtScXdvNGllcU5UNjdVUGl6ckFjbVZuSlpiNjNSQ09VSXhT?=
 =?utf-8?B?TnVKSzRiNnpGRFU1bXJXWTVlUjVTbjFvYlRQT2xlNUsreGwzQUJ0dXdIQ0NZ?=
 =?utf-8?B?QndQZXRzQzFOaXJoL0VxUm5CakhQTWxReXdGdU8ybUFZLy9uSCtibGxoTSty?=
 =?utf-8?B?MU5qZmdEWi9RYzYyYkpZNXBmYkovMnJ0OWtiS3ludHN1bnlrYXBFWkNJR1k3?=
 =?utf-8?B?ZHJqMm42MHNSbXZsUytrbjJaY0RkNXB1VGNsTG1jZ29tVHhFR1l4enZVZDI4?=
 =?utf-8?B?Wk1YTUxHSHJ4L01BZzg2akdCcEJzRkN5NTJIQ3FCRlVQZ2NmL2F6VGxBWkxv?=
 =?utf-8?B?K21nQXpzWk9VS3l0M0Y2cHBOWDJ3LzBZYkMwaUs0U1g2N1prbFB1Y2dnMjRI?=
 =?utf-8?B?SW5mZ3lJc0ZKOUl4WDl2dTF4Q2dYcG5ZMmc1NW44S2VHZGduQ01OcDh6bm5k?=
 =?utf-8?B?Mmh6eVRNRVFka3A1TXJTOG5mU0wzQkZYTERXREpoc0lYNldVK1pySmJPUWZJ?=
 =?utf-8?B?a1QyWGFhZThwakxWTkJESzZlaW1SdkJmSGhsQ3NYK3BlNGxHM29HS1hmMGhi?=
 =?utf-8?B?cGhDVGRFdkZWdmlES0ozdFoyeHRSRld3MHVqWG8rZ0RpbitkWnlvTjNVTEUy?=
 =?utf-8?B?QzlzaTNjWEpocWVUOThxRXVTdTFJOHczODBZc1FhV2pQVGRBRml1TWJDOG12?=
 =?utf-8?B?MjY5cmJ4cmtmckxyQmttS0tQdG9vWlRxRTVrNUdPR0lLOGJYZk9iSkFTbWZy?=
 =?utf-8?B?cEl5TFNUY1hWR1NLVWxDOWZqMnJYYWpSK0RZbG1Galo2S1hqU2NGWkVzZjhn?=
 =?utf-8?B?c2R1WDdmcVBWR0dKQkJRd3dMT1ZBVSthY1BKUlJCZWlLbHpoMEhrbjRmSnph?=
 =?utf-8?B?dnEwVnNZbkpHQnQ3V0lSam0wMDlWQkt6V2ZNYzFYdStuTHFMUXFKd0N5TlRF?=
 =?utf-8?B?bVRFa0JzNy85ZEwwaTBqNzJialBVRFdCUnB4Z2pKRy9tdHY0VUtWakRlV1BX?=
 =?utf-8?B?by9wSHY4akZqVTZmVmdlQnNqTUVSRTlHc21Ba2dtOHk5WnNJV2ZQR0Z3aTYv?=
 =?utf-8?B?cjJvMGhub3dsRnl3S2E4dUJZeGtaUVNOODRvckFIL0htZXVXOEMvRGtlUDZz?=
 =?utf-8?B?d0syREswNkhzZzNkeVQzY1ZIcTQ4eUJiUHpnS1NNL2dhamRyVnEwTzdUWnZI?=
 =?utf-8?B?T2xJbmpqcFBYKzZ6eTNQY1hSa2k3TXNtdUVVaGlCWXE1OGo1SjA3bHRjcnhV?=
 =?utf-8?B?aUlkaS9UVE9icGhHS1oyaXpTMm5qUk1BemFiTzN5K3NvS21TdmROeHYwS1Zt?=
 =?utf-8?B?QkFXeHRUNE10WUt2K0tiOG9jTGQ2cnpLQ1pqS2dFUWczbHd6MGJUTFJKMUFk?=
 =?utf-8?Q?cfIA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56d5593-f4c3-44e0-af6c-08de23af0dd9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 18:53:09.3299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrR/8w6ZRh3jt7SPlZUohTqc9AH9blBfPYWhNcR6nlA4m+2ZyYR5WhhLtd0Cn0JF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
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


On 2025-11-13 13:31, Andrew Martin wrote:
> The return code of a non void function should not be ignored. In cases
> where we do not care, the code needs to suppress it.
>
> Signed-off-by: Andrew Martin <andrew.martin@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 13 ++++++++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   |  3 ++-
>   2 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 644f79f3c9af..e4438fca6283 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -313,8 +313,10 @@ int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev)
>   void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
>   {
>   	if (amdgpu_device_should_recover_gpu(adev))
> -		amdgpu_reset_domain_schedule(adev->reset_domain,
> -					     &adev->kfd.reset_work);
> +		WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
> +							&adev->kfd.reset_work),
> +							"Failed to queue work! at %s",
> +							 __func__);
amdgpu_reset_domain_schedule only return false if reset_work already 
exist in the workqueue, it is fine to ignore the return value, don't 
want WARN_ONCE for this.
>   }
>   
>   int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
> @@ -715,9 +717,10 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
>   		if (gfx_block != NULL)
>   			gfx_block->version->funcs->set_powergating_state((void *)gfx_block, state);
>   	}
> -	amdgpu_dpm_switch_power_profile(adev,
> -					PP_SMC_POWER_PROFILE_COMPUTE,
> -					!idle);
> +	WARN_ONCE(!amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_COMPUTE, !idle),
> +		  "(%s) failed to disable video power profile mode",
> +		  __func__);

amdgpu_dpm_switch_power_profile return false for SRIOV, 
pp_funcs->switch_power_profile may return false for many cases, like if 
(!hwmgr || !hwmgr->pm_en), I think we don't need WARN for those cases.

> +
>   }
>   
>   bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 22925df6a791..025609a4abcf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2780,7 +2780,8 @@ static int runtime_enable(struct kfd_process *p, uint64_t r_debug,
>   		 * saved in MES.
>   		 */
>   		if (pdd->dev->kfd->shared_resources.enable_mes)
> -			kfd_dbg_set_mes_debug_mode(pdd, !kfd_dbg_has_cwsr_workaround(pdd->dev));
> +			(void)kfd_dbg_set_mes_debug_mode(pdd,
> +							 !kfd_dbg_has_cwsr_workaround(pdd->dev));

This looks good. It is easier to review if one patch only fix one 
ignored return code issue.

Regards,

Philip

>   	}
>   
>   	p->runtime_info.runtime_state = DEBUG_RUNTIME_STATE_ENABLED;

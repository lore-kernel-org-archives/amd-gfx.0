Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7976C369B1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 17:56:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DED410EC49;
	Fri, 11 Apr 2025 17:56:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K9smDuYD";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D521D10EC49
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 17:56:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvmnfMc6Zl1Qzd60Qmw1xmFdF+QDdUCDUkuTxduVF2/SdUEnQoCby7tfyjter3tm5Acw5dM01DlPV0Jmn1BVkz5Q8t2Ik437/DoVwzGCRnBN3UJQ5z2gHgCZT4SFisfwuuA86gPRDWbuA1JJ7WYC9PKpf85BfO6ySfoJyJSzIEolcyqyIrS96rNNS5+nbj+CQ0jXsGiUhnQgKrnFQpbs4mMEAeSBc/VGX+kksLKuMfluCdkobrH2AQKUT0ghdH/WGphG5Ui0o4jbYPpkFx+EeCmZFCTCDAXRp3C336WrY5CGpreLIIbc2MKhM2QGA5G1zd6BZK6ubhhsin4a2N+8kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kT4OJMyNKzo9KzpQRqDoYJs4AOc77I40Kg6BryyCvrg=;
 b=QSaRNB6CZGmBU8hIZd4ilQiqIs9bBt6U5piegCIeix7eYawku6DskQxv8MBHuLeSjzCgyLEI9TEaxMIpNwAz6yhwo0hEnN2XI29KYE+JbAkJJKhLM48wR0VZRiS2x3Ejm9+rFF3wIUoKf1iROouqRndtM84wQ7ViPsGfGtzblgn8R3N6Hrc9XamLnuhsvbc465Al4Abs0VBf4hDGO5VeDy9y0qq7iizoQxSykan/fiDbLIAUsZ90kmsx+zbqRZ5QBhKkkQmbyu/tAI5WffO3acyCeG5ecG79w4HTrIaK5xfmr+ib4voeY4XCF0dR84pouJ795+IHiehd4B1M9n4pTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kT4OJMyNKzo9KzpQRqDoYJs4AOc77I40Kg6BryyCvrg=;
 b=K9smDuYDMo3BesXwg/+PYim8ymKtNr1CEzZCaIunPUk0wwu0RI4TWpx73jcuLsR5aNp8Epy2oNDf8Piis7Uy8pUVTfI2i52b4F9DD6QhqpsDi1i+qvKiRUgqjyj1DG6HVTP3z3EDWYuMTSr6e5oPOa9jftA5wLD+KT10nnr5k34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.25; Fri, 11 Apr
 2025 17:56:34 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::14af:1677:d840:8d2%3]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 17:56:34 +0000
Message-ID: <bbd0214b-33ee-4965-b5c3-a3b258f533f9@amd.com>
Date: Fri, 11 Apr 2025 23:26:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: cleanup amdgpu_vm_flush v6
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20250411135450.9264-1-christian.koenig@amd.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <20250411135450.9264-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::15) To IA0PR12MB8208.namprd12.prod.outlook.com
 (2603:10b6:208:409::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8208:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: ec1573dc-3cb9-48b9-9b2a-08dd79223274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVRudWFvdXRBQ2IyWFVGK3p2cGNYQ3hidWl2SVhRczJzZFFMVzBaYitSd3Nm?=
 =?utf-8?B?eFR5SzBkZEFZdCtKMWtONFg5NkdqaHpISHc1WDIweFZpYmRhekt1R2h0ajJE?=
 =?utf-8?B?eXdSWlFHSnRrZTlPMnFtcXpFQ3d6bFJEd2p3QTlHOHNiemR1OG9HKzVjQWc1?=
 =?utf-8?B?dU1xTWFBVm5UUC9rOXRMemF2MUk2M3RMZzk3Y3NQeU9FZ3laSHhVRW9xdjU1?=
 =?utf-8?B?UEw5cVI0UGNCUVVDNzdhZzE5K3BDaXVMNDhieVV4K2Zna2R3bnNZaVRWclQz?=
 =?utf-8?B?ODJMcjgyWm0xQkNSdWpiMEJlb0RwTUVzT3pBUzZXVjNzcy9RNUJnZC83N0lQ?=
 =?utf-8?B?K0t3aDB4Z2xBYXpRWjQyZy9jcjBTUHBoTUd2cHBxODllYWlUNXFWL21WNWZl?=
 =?utf-8?B?RS9IeFB5eGd3V0l5RENVNkpxQk1odk9IRCtGS2JyVTdqZS93WFB3T0VGY1Ju?=
 =?utf-8?B?eGliV2ZzVkdFcmJNcWU2NExNeitET2hUL0h6Y2ZDS3BEZ1ZrRFIzU0ltSmRs?=
 =?utf-8?B?d0FnUmZsN3M0b0FvbE1IRnZRNmRjSDdFTFgxRnhWUTN5V3lhUS8vdG9EdVF2?=
 =?utf-8?B?R0x2SzJyQTI5emltcmdEcGZDVE03Qi9ENEVEQndmSlp4OWxQcURoUW1icVlX?=
 =?utf-8?B?Q2lPTVM1VklwckNIeldGck1iUi80Nkk2bW9kNHdPNG1FaGw3NzBzb2lBZm9F?=
 =?utf-8?B?R3VvNG1EZUh4Rzl4ODJRTnNsamlObFNLQ0FRV0NFWDNyZ3Erc0RrYkRnajE3?=
 =?utf-8?B?QngxZm10cC9zd21aYnBLUDhPRXpLdGc2S1FxbUN1aGVpSTVSdVZvWjBTdVVH?=
 =?utf-8?B?N3gyV2crNTJSOXprbFR2WHR3QndIclZ6bTVQd3JSQ09Oekx5ZFJsYTc3dmpi?=
 =?utf-8?B?NWE1R1FwUllyaWNoRVlQUjVhWk94SHZiU0hPZ2ZVUG9aSC9ZckhzKzNTNDBr?=
 =?utf-8?B?c2dzbmtlUi9tbXd5YkJsVnF5b2lLWnl1ZG5qT1JpL3lzUlVFbGVlTklQeURn?=
 =?utf-8?B?cXNVZTczUXh0bFZqS1NoOThQV1lINGdUZnBhdWt4em4rcllQcG1FUmpnNzNQ?=
 =?utf-8?B?cFdrdnFqN2lEdnd1NFpCNG95eVduUng0NUJwazlSVnEwUFR4OVZWanVwdVZh?=
 =?utf-8?B?OUFra3RqajdpSnByZmUrTWdUSXJOVVVva01nSzVZQWtPdGdiQm9XTXcrSkdY?=
 =?utf-8?B?SDNjMmo2MWpHUWUvZXNCa29Ieno4d2Z4NW4wQUVvcG83Z0Rhc3dJSFpNd3VS?=
 =?utf-8?B?c05UQkNJZXpwYlJtSm10WGhZbERzRXNEWUhpb3pFSk9JR0VjUitNeSttZU5W?=
 =?utf-8?B?ajRDelA1VXBxNG1TR0tZMFJsNGdGcFJUcmsvYU05S1l0TnJhMTQ1dnFKVWR3?=
 =?utf-8?B?QmZvTFRSQ1pTbHlNcVo5WWFJWDF0ZHBPR0dJSlBNMHdHdWRKc2lnQ2VSR285?=
 =?utf-8?B?RU9NSXNCWG5oS1hFZms0NGMyVlpISFl2NVVMV3BvS1RoQVZHMjNYT3NOTkRv?=
 =?utf-8?B?aGZkOUlkSnlTc1ZYYURNWVJjZThVZ1kzUG1EMmZZQUpPWHFzVjhQM3lWRnZV?=
 =?utf-8?B?TnZZWFlRenRIVjZjRmNPZ3hLaWpBSmZCUGVWalA0RUk0YXIrZ2lZNTVjdUxF?=
 =?utf-8?B?RU9FbFdCWlFOeWs2eWk0MVdmVkIwRTNqOUZla2dyeHl5ak9TS29WamtYRGlV?=
 =?utf-8?B?SmJCWkRKb0VnbGorU0RJTmdNdmdZM0ozYlY0Z0Q1aUVLWlArL2k5RmhoNjZP?=
 =?utf-8?B?VE9NWmZzbStOQmdONlVGTDZQeHRWY3NPVm8rMi9ZSE9uWmNiT3lCNU9XYVZh?=
 =?utf-8?B?UUYrRlRHbUFOZ1ZVL240YVpIVUc2Q3IyV2I5N3RiY3hvY3lzRUxwTE9Pb0JB?=
 =?utf-8?B?M0NVSDA5aXljWi9RSXdESXJseU5IQVZPaWZvNWNrVVQrL3FiaXBoNWJWUmNm?=
 =?utf-8?Q?Q1y00phnnH4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2RuUG55STFFcFV2UjN4QjQzVDRtRk1BQ0NmS1FBbVVFcGVzOU9Mb2VBa2xK?=
 =?utf-8?B?RzhEMk0rTGpsTkdSWTVHNFNrdTNvTXVLY0lkUmk0cXhLejlCZC9yZWtLY0Y5?=
 =?utf-8?B?RmF4L0hQdXZoMFNPL09WcWNGTU9xeGpaOENNY1hzUE8vblllQWU2a1hOZ1dU?=
 =?utf-8?B?U3NhcnVsYmhiNU1iYldqWDE2TmdFa2R5NnJoRVhrOGMyS29ndURzaUR5eEZx?=
 =?utf-8?B?TmNUMHFVeDBQc01EWVdmcUcrbkRRbWJkYnNralQyY2tiRWxNSXZNNjhrbG5J?=
 =?utf-8?B?RFZULzNiekJEdVo2N3JSRWJ3bWxYQUcyM1N3RFhlZ2Q2NXpya2hUd3gxRXlx?=
 =?utf-8?B?bmdqeGErME9XcnNUMkU1Rnd0VUlIMG9KcCtkWjJnWmpWSjJnay9SdUQ5b1di?=
 =?utf-8?B?VHV5NzJqZjZCQ1lHVzh5ZjFEM0hxdHlhaCtOaTU2YnFGaXROTUVVV05ST1Yw?=
 =?utf-8?B?SVlmSTRpVStiSzBvcDhjcHVDd014N1hxbWRtUWJUeWsxVUVtQTBRSGRLTjZy?=
 =?utf-8?B?NElJNU9vZFBQWGcxUkRPNm9MVjgxc0kvbW1PY002WlhkamJWeUtRanArYVV3?=
 =?utf-8?B?bXBiNjZGRXRCdzBWOWdCZFBDYkIzWjhTSGoydFNvZnVMckREcHcyTVZvNHYz?=
 =?utf-8?B?T0EvMTVTL3l2WjNwZExQQ21EcDcybTRsSXpPK2c4bEt5cVFhb3lKQjFRL1Vw?=
 =?utf-8?B?THlkcEhnRkEybEVlNUUvVlUvaTlMbHhvOUYwZ0VRRk1QYW1Ydk5IWDZGcUdX?=
 =?utf-8?B?d1NhR2U4L3NZcFVlcmZWTUF4MHNSSlJkNG9qNkQrbjZxdEtEYkhLZ0U5bnlm?=
 =?utf-8?B?aFNFU3JrRXRPVDlKZ2pPb3ZVTVQ4U2Eyc1FEaXZuczk2STdPbThmTm5lcXM5?=
 =?utf-8?B?RGhrWXhFQXZ2OEp0dFkzdXQrcXE0YnQrTzZLNHRTMm13Ni82aXBab1lPVncx?=
 =?utf-8?B?TGYyR2xYaGtIR1FxOUhqcmRxditnTEtOYkRxVk5Qd0MycHJBTVk1WUsvOThR?=
 =?utf-8?B?dU9jZUl6VmE0M3JPbGtkZWE2cTJnb3IvZzJQVk1JS0wyY25HWTB1M21aSk0y?=
 =?utf-8?B?d3QyVTQ1L1BDR2dUUDFUbzFOTGpsTVBQdUlsTVRudE92Qktqa0Zxei9uTUFL?=
 =?utf-8?B?RmtNcEVoUmVFR3RSZHJSWnkvem0zNjV2SWhGdkw1Qk41UzlsWVhqWnVVd0lR?=
 =?utf-8?B?WGJqaVZlVVdqYm5zaVJJaHVndWcyRDQrRDcxQTVjT2N4YmxJSjBpcDRPWVNY?=
 =?utf-8?B?SlNGa045aEpSRlJEdll3YnpjUUthT1ZObnBXZDhwMk84TUhCOTZJakc4WFZC?=
 =?utf-8?B?WUx6ano4WGc5NGlwSjduamY0VTVGM3dWRjl6RWlMd3FaYjhzRlJzTFh1K095?=
 =?utf-8?B?UkVmVWxITFlPSFFwRUg4blR5RWVueEc0VGFJbWY4ZWo1WENnL1hjM2E1UXhy?=
 =?utf-8?B?NU5ZTTFEWVN4am9GQ2Q2WlBhV0R1NVZaTW41MU0xYUNzR1JhNDJhYVQ4Z0to?=
 =?utf-8?B?TkN2S3IwcnZUQ3U1c2YwU1F3aEluNXhoYVJEUzBwV2tNd0wwZWx0N29sQWRW?=
 =?utf-8?B?dHZ5aGNWOXNuL281SGxXWFNBRUpkMms2OXJtc3RtVUVLZEFzSFpZY2h5YXBL?=
 =?utf-8?B?RksralRwZHZIT1ZSVDZCTnlHNnRsOW9obFBOS0dLRFR1VXRiSHR0b1B5amxh?=
 =?utf-8?B?MFUyME1xMGNoemsvNTNFTkdBaEJiMExKamdvckt1dCs3d2txbFJ2RFFrUkVa?=
 =?utf-8?B?NTFtSlpFd2tiTno3aVFVaUUwVEl4dmpSMnlJYVdpSUNhZHNNREdQTVZIUHRn?=
 =?utf-8?B?Q1pqQXlaWkJrLzh6WFFzUFd5OEdXR0xGTzBQZ1dYdnBJeE1XU2pkV2pIUWNF?=
 =?utf-8?B?OVJmOCsrM3pBQXRobXJHYXdxZHFjRHZBU0lQSDJUVW9pSGUvVjBZV3ZjZWxB?=
 =?utf-8?B?Z2FUME5VWkdSbk9pRHltQ1VWZXY0UEdFdTEyWW9xdTNOc2ZDK0ZjcWdFSlFV?=
 =?utf-8?B?QTkyQ0xSRFhnV2xEdzVHcFV6RGwxZ3pRdjNnZ2dWVmJQS0ZQU2kvUmJOQXBx?=
 =?utf-8?B?L2VDRndBb1cyUXEzNXFUNWoxSGhxdGJGV1RHbzN4S3RzeHJkdW0zd3BtKzV3?=
 =?utf-8?Q?RzVFwKK47n5X8AzXKmpXULmQo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1573dc-3cb9-48b9-9b2a-08dd79223274
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 17:56:34.2788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFZL3UItjOsoIBWneBp8fRYeTt73qncIPNB5uXg+3uokvE55rk7Ej4QS0/bqYN+pU803q0bOXSk9RqJCqkhO7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671
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


On 4/11/2025 7:24 PM, Christian König wrote:
> This reverts commit c2cc3648ba517a6c270500b5447d5a1efdad5936. Turned out
> that this has some negative consequences for some workloads. Instead check
> if the cleaner shader should run directly.
>
> While at it remove amdgpu_vm_need_pipeline_sync(), we also check again
> if the VMID has seen a GPU reset since last use and the gds switch
> setiing can be handled more simply as well.
>
> Also remove some duplicate checks and re-order and document the code.
>
> v2: restructure the while function
> v3: fix logic error pointed out by Srini
> v4: fix typo in comment, fix crash caused by incorrect check
> v5: once more fix the logic
> v6: separate cleaner shader checks as suggested by Srini
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |   6 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 106 ++++++++++---------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   5 +-
>   3 files changed, 46 insertions(+), 71 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 802743efa3b3..30b58772598c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -189,10 +189,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>   	}
>   
>   	need_ctx_switch = ring->current_ctx != fence_ctx;
> -	if (ring->funcs->emit_pipeline_sync && job &&
> -	    ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
> -	     need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
> -
> +	if ((job && (tmp = amdgpu_sync_get_fence(&job->explicit_sync))) ||
> +	     (amdgpu_sriov_vf(adev) && need_ctx_switch)) {
>   		need_pipe_sync = true;
>   
>   		if (tmp)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index dadf6715b98b..a0e9ab1afe96 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -596,37 +596,6 @@ void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev)
>   	}
>   }
>   
> -/**
> - * amdgpu_vm_need_pipeline_sync - Check if pipe sync is needed for job.
> - *
> - * @ring: ring on which the job will be submitted
> - * @job: job to submit
> - *
> - * Returns:
> - * True if sync is needed.
> - */
> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
> -				  struct amdgpu_job *job)
> -{
> -	struct amdgpu_device *adev = ring->adev;
> -	unsigned vmhub = ring->vm_hub;
> -	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
> -
> -	if (job->vmid == 0)
> -		return false;
> -
> -	if (job->vm_needs_flush || ring->has_compute_vm_bug)
> -		return true;
> -
> -	if (ring->funcs->emit_gds_switch && job->gds_switch_needed)
> -		return true;
> -
> -	if (amdgpu_vmid_had_gpu_reset(adev, &id_mgr->ids[job->vmid]))
> -		return true;
> -
> -	return false;
> -}
> -
>   /**
>    * amdgpu_vm_flush - hardware flush the vm
>    *
> @@ -647,44 +616,52 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	unsigned vmhub = ring->vm_hub;
>   	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>   	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
> -	bool spm_update_needed = job->spm_update_needed;
> -	bool gds_switch_needed = ring->funcs->emit_gds_switch &&
> -		job->gds_switch_needed;
> -	bool vm_flush_needed = job->vm_needs_flush;
> -	bool cleaner_shader_needed = false;
> -	bool pasid_mapping_needed = false;
> -	struct dma_fence *fence = NULL;
> +	bool gds_switch_needed, vm_flush_needed, spm_update_needed,
> +	     cleaner_shader_needed, pasid_mapping_needed;
> +	struct dma_fence *fence;
>   	unsigned int patch;
>   	int r;
>   
> +	/* First of all figure out what needs to be done */
>   	if (amdgpu_vmid_had_gpu_reset(adev, id)) {
> +		need_pipe_sync = true;
>   		gds_switch_needed = true;
>   		vm_flush_needed = true;
>   		pasid_mapping_needed = true;
>   		spm_update_needed = true;
> +		cleaner_shader_needed = true;
> +	} else {
> +		gds_switch_needed = job->gds_switch_needed;
> +		vm_flush_needed = job->vm_needs_flush;
> +		mutex_lock(&id_mgr->lock);
> +		pasid_mapping_needed = id->pasid != job->pasid ||
> +			!id->pasid_mapping ||
> +			!dma_fence_is_signaled(id->pasid_mapping);
> +		mutex_unlock(&id_mgr->lock);
> +		spm_update_needed = job->spm_update_needed;
> +		need_pipe_sync |= ring->has_compute_vm_bug || vm_flush_needed ||
> +			cleaner_shader_needed || gds_switch_needed;

Hi Christian,

Here "cleaner_shader_needed" variable, would still remain uninitialized, 
could we please move this PipelineSync

"
+        need_pipe_sync |= ring->has_compute_vm_bug || vm_flush_needed ||
+            cleaner_shader_needed || gds_switch_needed;
"

after

+        cleaner_shader_needed = job->run_cleaner_shader &&
+            job->base.s_fence && &job->base.s_fence->scheduled ==
+            isolation->spearhead;

?

Best regards,
Srini


> +		cleaner_shader_needed = job->run_cleaner_shader &&
> +			job->base.s_fence && &job->base.s_fence->scheduled ==
> +			isolation->spearhead;
>   	}
>   
> -	mutex_lock(&id_mgr->lock);
> -	if (id->pasid != job->pasid || !id->pasid_mapping ||
> -	    !dma_fence_is_signaled(id->pasid_mapping))
> -		pasid_mapping_needed = true;
> -	mutex_unlock(&id_mgr->lock);
> -
> +	/* Then check the pre-requisites */
> +	need_pipe_sync &= !!ring->funcs->emit_pipeline_sync;
>   	gds_switch_needed &= !!ring->funcs->emit_gds_switch;
>   	vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
>   			job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
>   	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
>   		ring->funcs->emit_wreg;
> -
> -	cleaner_shader_needed = job->run_cleaner_shader &&
> -		adev->gfx.enable_cleaner_shader &&
> -		ring->funcs->emit_cleaner_shader && job->base.s_fence &&
> -		&job->base.s_fence->scheduled == isolation->spearhead;
> +	spm_update_needed &= !!adev->gfx.rlc.funcs->update_spm_vmid;
> +	cleaner_shader_needed &= adev->gfx.enable_cleaner_shader &&
> +		ring->funcs->emit_cleaner_shader;
>   
>   	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
> -	    !cleaner_shader_needed)
> +	    !cleaner_shader_needed && !spm_update_needed)
>   		return 0;
>   
> +	/* Then actually prepare the submission frame */
>   	amdgpu_ring_ib_begin(ring);
>   	if (ring->funcs->init_cond_exec)
>   		patch = amdgpu_ring_init_cond_exec(ring,
> @@ -704,23 +681,34 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   	if (pasid_mapping_needed)
>   		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
>   
> -	if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
> +	if (spm_update_needed)
>   		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring, job->vmid);
>   
> -	if (ring->funcs->emit_gds_switch &&
> -	    gds_switch_needed) {
> +	if (gds_switch_needed)
>   		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
>   					    job->gds_size, job->gws_base,
>   					    job->gws_size, job->oa_base,
>   					    job->oa_size);
> -	}
>   
>   	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
>   		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
>   		if (r)
>   			return r;
> +	} else {
> +		fence = NULL;
> +	}
> +
> +	amdgpu_ring_patch_cond_exec(ring, patch);
> +
> +	/* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
> +	if (ring->funcs->emit_switch_buffer) {
> +		amdgpu_ring_emit_switch_buffer(ring);
> +		amdgpu_ring_emit_switch_buffer(ring);
>   	}
>   
> +	amdgpu_ring_ib_end(ring);
> +
> +	/* And finally remember what the ring has executed */
>   	if (vm_flush_needed) {
>   		mutex_lock(&id_mgr->lock);
>   		dma_fence_put(id->last_flush);
> @@ -750,16 +738,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   		mutex_unlock(&adev->enforce_isolation_mutex);
>   	}
>   	dma_fence_put(fence);
> -
> -	amdgpu_ring_patch_cond_exec(ring, patch);
> -
> -	/* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
> -	if (ring->funcs->emit_switch_buffer) {
> -		amdgpu_ring_emit_switch_buffer(ring);
> -		amdgpu_ring_emit_switch_buffer(ring);
> -	}
> -
> -	amdgpu_ring_ib_end(ring);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index daa2f9b33620..e9ecdb96bafa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -493,7 +493,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		       struct ww_acquire_ctx *ticket,
>   		       int (*callback)(void *p, struct amdgpu_bo *bo),
>   		       void *param);
> -int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
> +int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
> +		    bool need_pipe_sync);
>   int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   			  struct amdgpu_vm *vm, bool immediate);
>   int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
> @@ -550,8 +551,6 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
>   			   uint32_t fragment_size_default, unsigned max_level,
>   			   unsigned max_bits);
>   int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
> -bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
> -				  struct amdgpu_job *job);
>   void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>   
>   struct amdgpu_task_info *

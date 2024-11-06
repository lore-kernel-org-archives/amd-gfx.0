Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5CBD59F6C
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 20:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DA6410E209;
	Wed,  6 Nov 2024 20:25:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="boSTzSqD";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EDF910E209
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2024 20:25:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpiA3M36kyY4aD8f4/oY6oYjKvRPnYCQNot79RfPCrNq2dtNGBQqUZFp1tPe9CbArYqGVrP9NrrUkE1IwWkIfCgoNT7qaAr0C7f2qFlTcu/8R4mhIb6/XIB/tM3vWl1aISDnZjiTE/hpF8HpmlKrPqVbeztnEogLl53ai+1DhEIg7aX5PcLF5I4p9J0jsGuoMK2yjLLxr1x1YEz8bBmf8cPjdyIsQ1yDaRVRuWUp3/2bn+z70Vnr8dCOxfDKjBEO7ek/iwk3QfdlSwq6m3FvrdjKSjNA/qCyIMyEel9m0BLam5fdqZYkv4a6+ZIqeMcRwWMaeVolJksyXZU0RRh6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avvK3QE+TheiLcTXaSp85lDVNFglqgPYqeALY5e4x/w=;
 b=Kn900cW5b3nbLYJn8GX9eZaUotPJXLzpBM96dKM9nDphL9sjyz9AZPZWaC9ef+JRJyBbsEd4k0hw52G/1weN2FjVcE9VuRDsol+vuLH9KIofY8d2QzmpHlOtM8bkLkWwpdUYkAHTMjt1SmpbsfFc8CCnOKySE2B0Gv4fVjW7bdXf2YBFY8KE2980PBUIM75AVLtX5g+cdkTZX4O818mnngKqLEOYo3xVUM7LTU+aFwbMBEPNqbEvTMYIUz7qLDTADE5txHMoDKEMldEVTu0DKDshBZrp05P2HmDli/L29EfWQpLaIzFaqQtCgC/8DXe3qNduKdiRdJRx8sc8vYyELA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avvK3QE+TheiLcTXaSp85lDVNFglqgPYqeALY5e4x/w=;
 b=boSTzSqDp+y1JxOZcROJtczhlSNj4uCK3Ih9/kUUcQeKeGl0CFr0ZGRBCC//7auVoyqx05H6M+sE4Ha9QukqOYjIHK7ZeMBKeHLn1jSQCJfaFcQdU7wTII5fIAW4uhyMBHOfsTOg4FsiiDVazQu8Pyoc3zwBKA1QJTwMx/6HnHA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 20:25:24 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 20:25:23 +0000
Message-ID: <698cdf3a-e9fa-4f90-9c06-ebd8c771fcfc@amd.com>
Date: Wed, 6 Nov 2024 14:25:21 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] drm/amd/display: Fix Panel Replay not update screen
 correctly
To: Hamza Mahfooz <hamza.mahfooz@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>,
 Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
References: <20241105202341.154036-1-hamza.mahfooz@amd.com>
 <20241105202341.154036-5-hamza.mahfooz@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241105202341.154036-5-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0149.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: be2deb8c-e30e-4f20-99e5-08dcfea1247e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkVGRUtIZWRKNUhaTlFHYVA1cTk5RlpJS2lvSXZkanlXWHd4MmVMWitjSE9z?=
 =?utf-8?B?cjhYSWRGMEJnR2V4Tk41Zk04Vk80UlFZM2h4ZnBhbllnT0F6TDBhTmhEUllm?=
 =?utf-8?B?SkkzZ003RlFZcXppcUJOK3lqYjZVM3Nzbk02RXBhbGh5bGlyZ3Z0bDJ5QnRD?=
 =?utf-8?B?SmJYUFY4NDBKZ0hjeFV2NXc2WjJaNnIyWjFCREtCNVVJSDFJVkhQeFVpSTFZ?=
 =?utf-8?B?dFFyUGVKeG4vckFCZjNEMDJQWGZTRFFiS2l4SWREbW1FQXVOcjErNWdiNU1i?=
 =?utf-8?B?R2NUNXowMENJSUFXL082MXp3UFBGNGJvcng3S1JwdEhLYXg3NVh6WmtZd3Vl?=
 =?utf-8?B?eEpGSllub1p1MVNyNURKMGtNSjBmYUZIcHNXWG83Mkh1a1diUm1vNkRpS2hX?=
 =?utf-8?B?UzJBM2JDRE9YOTBibkJGeVlPVDZrNno5L2h0emVVbjM1ZndQN2pDZ1F3Rkl2?=
 =?utf-8?B?RHEyMnhZelZwWk42YmhsOVpUOE9SUDA0SGpIdVJSZlRYdTJ3b3dwQnBQbGRM?=
 =?utf-8?B?QWRlOUlwazRqZmVxVXI2bllrbk5uT2c2cU41UDFxRWhSWGpaY0NiNGh3OHcy?=
 =?utf-8?B?VnNBcnRiOHJzeHRzU25mbGpOWmhVUTJ5aW8xVlZ0c3c1NHBEOW9DZHNCNFhn?=
 =?utf-8?B?ZVFxM2NiVFIrMDlKZHMrVE96MkpBajEyRlE2bEMwQmJCRXY3eU9LVFl1aWIr?=
 =?utf-8?B?OU1JQUptZUR1TFpXdFNucHVaanJUZVMybUlMaHNHeUcxSDdybHFMa1NGcGpj?=
 =?utf-8?B?RkJ6TjJwRjhES081TmtrRmwwaENKVENYclZ2dWNDNUZDMlRBUWo4U0hoMXow?=
 =?utf-8?B?VXFpVWxvVEx6K0MrMTJmRWVUU0pUVXhqb21OMnp3WVlrc3dVVzltVWpyd25x?=
 =?utf-8?B?SDhYMmxkVnhNNWJFVkZHVmJVWVIvdkxIN1o0aFQ3RHJib3J6c3Z0dUhtY25Z?=
 =?utf-8?B?ajloalhTazFZUzltQmVqdVRIUEN4RUcraUg3R0F6VHBDeUlLZ0plbTVhQzBa?=
 =?utf-8?B?Y0oxQlRlTk1yTGFkWk05Q0prV3paMlRmTE1LSmQ4ME9JTCs2bnNRR3B6TDNE?=
 =?utf-8?B?OW9KelVUMUlIZld4ZnlFbFdXMnZZZEdqemo4VzVQcHBlQndkT1lsMThZMXFB?=
 =?utf-8?B?VzR6M0ZBMmFxSEJNRWZjeFgzUDZXLzlZV21oZUJLdEM2WnkxckZVMkhZSm9N?=
 =?utf-8?B?eVd3UFdSWXFMMnVwdnZ0endpN1VQTkEzd1N4T2treklWdmdzOTZzOWVMY2hC?=
 =?utf-8?B?Mm1zWUwrMTFlRU9YMTJPVGlycGZzcnhZTGxObklsYWZYbDJOT25hNnpkSHNL?=
 =?utf-8?B?MFZ6NVJ3MzdDWWsyUloybDdJdmkxZldTbmRNN0djeXdiSnRRTktxVjc0aUlP?=
 =?utf-8?B?clhhVFRXNVg2SGQwRTVJZG5rTkI1UTkrdTE1elJ6aTI2c3RzOHVEYzVxSG95?=
 =?utf-8?B?L0NrWlpFRWtZTDNsTGx4MWpMOXJtTzBHMUU4UFlEMFVHdDdkV0JmVzBrWEp4?=
 =?utf-8?B?ak1qY3NOSVRSRUFGTTBkSFBmdVV0dFFlQzBEUXErMnBJWk83SHVJYnVsNHlR?=
 =?utf-8?B?UTBhWXZiZFJnckRBeXhpRDJXd2VlWmp1MWZTaUlnUlU3Vm5DQXliSHNYQWtK?=
 =?utf-8?B?L2dMZ2g0RU9yTEtsQlRJaHhmL0JTaXF4UVN1R2k5amU4QmZLNXN2WGZiVGl0?=
 =?utf-8?B?MFNGbjhGWU1tV3VzZERvOVhIMWJld1I3MVJEelZ2UjN0OStRL056bHNnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkU4Z0ZHaXM3ZnVXSDJieGFPTXpVYXhieFQ2VnBQUnVibFJPY1ZCN09mNTI0?=
 =?utf-8?B?Mjg4ZjdhR2dsaThQUFRjOUw3SU5IclpPcVAvS0dMdFJUbjVSTDF0SVZYWGZa?=
 =?utf-8?B?ZDhVUXFQYW9seFFmMyswNVVyZDNva0RZakRUUy9rZ2haeVpJKytiVVV2L0Q0?=
 =?utf-8?B?SjBhNzRPNGIvYjVQMjFreXYwcytqNCtkTExjUnlxQTA2ZjhkSkJnNVN2R2M4?=
 =?utf-8?B?cmUzUjJEL3d5VWJTd2RYSGliVHNockNPenplaVZwQnVjN3dKQmxnZW13Qi85?=
 =?utf-8?B?cU9jT0N3dWhDbDNmMzA0S1IrRGZtYWlTNVB4M3MrS0F4SFdyWXpNbGJiWURZ?=
 =?utf-8?B?cytVZ1Jybng5ckFzZjJSV1AxLzNxUDVCT0NqMVoyNHV2WFYxNEREWVZyK3BL?=
 =?utf-8?B?TzJWT3ZXdUU5WmxHaks4NzdFL29MQ0NMbkRDQVp1UFRyTTJqd003K1dzcE1r?=
 =?utf-8?B?WFVraTFLcWdxbXFKY0xnSjFYTDBuOXRTeHFtQ2hEUmF4Q0lsODUxYUpDZnJu?=
 =?utf-8?B?bm1qN1Y4QVZMOVRaUlhXVmUvVFRxdnVvWFV0bkJ0YXNFU0o3c1VBNm1ZcGR6?=
 =?utf-8?B?Q3AzRE1ZcEtGVjYycmFpbHZXU0Q2VFVkS3NsdTh1Z0w1cHJ1UVp4QmNxeU5w?=
 =?utf-8?B?UDRUL1V6WEVQMTV3YWRRSzhyWTByeU5Sc3AwSG1idE5aOVBxbVZrR0JxeXE5?=
 =?utf-8?B?K216Z3pmWEVlVW5UZVVaVkNLa0RDaGxPTktSbWNtVEI3RzlEbEhRTHBSdjdk?=
 =?utf-8?B?OXVpN25SQlBWMktJRkFzaTkrVWFuODYwUURYOWtVWTJuQUxuZGJJRExMaTNL?=
 =?utf-8?B?UitxU2J2SGVkYTd5aDNKM2s1aHZsdGVxVmFFVVpCMUZrbnlTeFlMRDNCUWVk?=
 =?utf-8?B?NkJZanZodWlqbi84a2UrK0YrNTdZY0RheFRZa1FCaDVvMDZWS1JDNjRsckFT?=
 =?utf-8?B?bDd1ZnFJcE9zUEdENlozTGZoeTVxR0ZXY3ZHUjFHVXNLVnovT3J5R3E3SWJm?=
 =?utf-8?B?VFZ1cExvRFBuaEg2Y0tFS2ZRYmt4NS9YaXBYM2NRZjN3TmIvdS8yMjBEZ3V3?=
 =?utf-8?B?L0Ezd1FuRjJrZVBJZ01LM0hvcFd3bWhORW5NTDJsUHRwbFZhNGlvcnNiRWU1?=
 =?utf-8?B?c2FTdDJMaFpERWx6L2JJRTRzb0ZHOHkxMU5UYmVzcmNpYlo4NVY5UGVnbUNn?=
 =?utf-8?B?dkUxNnNqNXJ1RVlvNlJzWXNERWlGclVBU2g3UmpqQmRXQVpkWnFNMHRUNHIx?=
 =?utf-8?B?OHN3ZFlOVlBLTXBJUEZPeDFHRmFROXZPYTBiQXdZa0pJNDFMR0NmZHVzODJp?=
 =?utf-8?B?OEpVSWZhZXA1b2N0OHNNNHZNSnVsZFJlYmZ4Y3J5TkNsVDdtdjgvamJISDBF?=
 =?utf-8?B?VGVodWUvYTFCSG52UDVyL08vRDZDUmF2aXJZbUJwMFBLU3BNdGN5OTlKOFlW?=
 =?utf-8?B?TlhUbFlvM0s0UTdHaU42UEVadi9GU25FQ1o5SVZpcVZRZ3FRS0lBMlFnK0lO?=
 =?utf-8?B?bDljZ3IycE1mcUlxN0xVS0VwTmJjRnBjdnRqQTg3THB6NFNPRTdzREhCSnp4?=
 =?utf-8?B?aWNpejFHTllSQ2tvMVRqcXdLcmZSREE4TjhZczNPMERVeGlJT2pRV0tabmFC?=
 =?utf-8?B?WE5JVCs1RFR5MHR1cGNvUTJSUjVsUFlBVlBCUnhEMzNJNlRyYWNPSHYrZ050?=
 =?utf-8?B?MDJEM1JxQ0ZCb1h2ZFlvekMycENqQWgxWmIvNG5oaGlhWG9ZRGZJRFJIa0x3?=
 =?utf-8?B?OFR3eUlZZ1hLUFZlV0d3S1dJclIxRmsrckRhcVluODBJMVV3ZWpEdlR6amVi?=
 =?utf-8?B?bG85TzRwZjdVV3dxL2QyZ01QeVFQUHRBTjVjdU91WWw2cE9xUDVEUTlaTWty?=
 =?utf-8?B?Qmppb01pcDZ1VzV4enU4ZkRoNDY2WXJmT3AxU2lWZERldS9IUUw2amJtSFI0?=
 =?utf-8?B?WHJqUGpxMUo5V1ptMjJUUnFRWXdnWFgxajd0MzhLU2lHZVQ5SzI1bnU3WktV?=
 =?utf-8?B?VVJQWjdIdTlxSllHb1FLblZEYlJ6VldVaWw5Nm5CY1VTaEhRbVh4SExwZEJN?=
 =?utf-8?B?QVdlcmY3VklvUzVXR1piSUZSLy9HR0pBaHQyN2lZdU9rZmVDRGpGV3o5OWo5?=
 =?utf-8?Q?B23RSU7/3ZrOrIlNG04IVDVDY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be2deb8c-e30e-4f20-99e5-08dcfea1247e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 20:25:23.7654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3QqjvQFTe+3gFiHcmp7fN55km9/+AkXsgCn/XDu5f/oa18RbR+c3sFuLy3sqf/ar6Msfkw5F1x4JTqVvIYbUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
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

On 11/5/2024 14:22, Hamza Mahfooz wrote:
> From: Tom Chung <chiahsuan.chung@amd.com>
> 
> [Why]
> In certain use case such as KDE login screen, there will be no atomic
> commit while do the frame update.
> If the Panel Replay enabled, it will cause the screen not updated and
> looks like system hang.
> 
> [How]
> Delay few atomic commits before enabled the Panel Replay just like PSR.
> 
> Reviewed-by: Leo Li <sunpeng.li@amd.com>
> Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

As this is an issue reported in the drm/amd tracker and we have panel 
replay in 6.11.y with active reports of this issue a few other tags that 
this should close and associate with.

Cc: stable@vger.kernel.org # 6.11+
Fixes: be64336307a6c ("drm/amd/display: Re-enable panel replay feature")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3686
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3682

> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 111 +++++++++---------
>   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   5 +-
>   2 files changed, 59 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 570640c25b4b..fdc1d2d1afd9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8863,6 +8863,56 @@ static void amdgpu_dm_update_cursor(struct drm_plane *plane,
>   	}
>   }
>   
> +static void amdgpu_dm_enable_self_refresh(struct amdgpu_crtc *acrtc_attach,
> +					  const struct dm_crtc_state *acrtc_state,
> +					  const u64 current_ts)
> +{
> +	struct psr_settings *psr = &acrtc_state->stream->link->psr_settings;
> +	struct replay_settings *pr = &acrtc_state->stream->link->replay_settings;
> +	struct amdgpu_dm_connector *aconn =
> +		(struct amdgpu_dm_connector *)acrtc_state->stream->dm_stream_context;
> +
> +	if (acrtc_state->update_type > UPDATE_TYPE_FAST) {
> +		if (pr->config.replay_supported && !pr->replay_feature_enabled)
> +			amdgpu_dm_link_setup_replay(acrtc_state->stream->link, aconn);
> +		else if (psr->psr_version != DC_PSR_VERSION_UNSUPPORTED &&
> +			     !psr->psr_feature_enabled)
> +			if (!aconn->disallow_edp_enter_psr)
> +				amdgpu_dm_link_setup_psr(acrtc_state->stream);
> +	}
> +
> +	/* Decrement skip count when SR is enabled and we're doing fast updates. */
> +	if (acrtc_state->update_type == UPDATE_TYPE_FAST &&
> +	    (psr->psr_feature_enabled || pr->config.replay_supported)) {
> +		if (aconn->sr_skip_count > 0)
> +			aconn->sr_skip_count--;
> +
> +		/* Allow SR when skip count is 0. */
> +		acrtc_attach->dm_irq_params.allow_sr_entry = !aconn->sr_skip_count;
> +
> +		/*
> +		 * If sink supports PSR SU/Panel Replay, there is no need to rely on
> +		 * a vblank event disable request to enable PSR/RP. PSR SU/RP
> +		 * can be enabled immediately once OS demonstrates an
> +		 * adequate number of fast atomic commits to notify KMD
> +		 * of update events. See `vblank_control_worker()`.
> +		 */
> +		if (acrtc_attach->dm_irq_params.allow_sr_entry &&
> +#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
> +		    !amdgpu_dm_crc_window_is_activated(acrtc_state->base.crtc) &&
> +#endif
> +		    (current_ts - psr->psr_dirty_rects_change_timestamp_ns) > 500000000) {
> +			if (pr->replay_feature_enabled && !pr->replay_allow_active)
> +				amdgpu_dm_replay_enable(acrtc_state->stream, true);
> +			if (psr->psr_version >= DC_PSR_VERSION_SU_1 &&
> +			    !psr->psr_allow_active && !aconn->disallow_edp_enter_psr)
> +				amdgpu_dm_psr_enable(acrtc_state->stream);
> +		}
> +	} else {
> +		acrtc_attach->dm_irq_params.allow_sr_entry = false;
> +	}
> +}
> +
>   static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>   				    struct drm_device *dev,
>   				    struct amdgpu_display_manager *dm,
> @@ -9191,9 +9241,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>   			bundle->stream_update.abm_level = &acrtc_state->abm_level;
>   
>   		mutex_lock(&dm->dc_lock);
> -		if ((acrtc_state->update_type > UPDATE_TYPE_FAST) &&
> -				acrtc_state->stream->link->psr_settings.psr_allow_active)
> -			amdgpu_dm_psr_disable(acrtc_state->stream);
> +		if (acrtc_state->update_type > UPDATE_TYPE_FAST) {
> +			if (acrtc_state->stream->link->replay_settings.replay_allow_active)
> +				amdgpu_dm_replay_disable(acrtc_state->stream);
> +			if (acrtc_state->stream->link->psr_settings.psr_allow_active)
> +				amdgpu_dm_psr_disable(acrtc_state->stream);
> +		}
>   		mutex_unlock(&dm->dc_lock);
>   
>   		/*
> @@ -9234,57 +9287,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>   			dm_update_pflip_irq_state(drm_to_adev(dev),
>   						  acrtc_attach);
>   
> -		if (acrtc_state->update_type > UPDATE_TYPE_FAST) {
> -			if (acrtc_state->stream->link->replay_settings.config.replay_supported &&
> -					!acrtc_state->stream->link->replay_settings.replay_feature_enabled) {
> -				struct amdgpu_dm_connector *aconn =
> -					(struct amdgpu_dm_connector *)acrtc_state->stream->dm_stream_context;
> -				amdgpu_dm_link_setup_replay(acrtc_state->stream->link, aconn);
> -			} else if (acrtc_state->stream->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED &&
> -					!acrtc_state->stream->link->psr_settings.psr_feature_enabled) {
> -
> -				struct amdgpu_dm_connector *aconn = (struct amdgpu_dm_connector *)
> -					acrtc_state->stream->dm_stream_context;
> -
> -				if (!aconn->disallow_edp_enter_psr)
> -					amdgpu_dm_link_setup_psr(acrtc_state->stream);
> -			}
> -		}
> -
> -		/* Decrement skip count when SR is enabled and we're doing fast updates. */
> -		if (acrtc_state->update_type == UPDATE_TYPE_FAST &&
> -		    acrtc_state->stream->link->psr_settings.psr_feature_enabled) {
> -			struct amdgpu_dm_connector *aconn =
> -				(struct amdgpu_dm_connector *)acrtc_state->stream->dm_stream_context;
> -
> -			if (aconn->sr_skip_count > 0)
> -				aconn->sr_skip_count--;
> -
> -			/* Allow SR when skip count is 0. */
> -			acrtc_attach->dm_irq_params.allow_sr_entry = !aconn->sr_skip_count;
> -
> -			/*
> -			 * If sink supports PSR SU/Panel Replay, there is no need to rely on
> -			 * a vblank event disable request to enable PSR/RP. PSR SU/RP
> -			 * can be enabled immediately once OS demonstrates an
> -			 * adequate number of fast atomic commits to notify KMD
> -			 * of update events. See `vblank_control_worker()`.
> -			 */
> -			if (acrtc_state->stream->link->psr_settings.psr_version >= DC_PSR_VERSION_SU_1 &&
> -			    acrtc_attach->dm_irq_params.allow_sr_entry &&
> -#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
> -			    !amdgpu_dm_crc_window_is_activated(acrtc_state->base.crtc) &&
> -#endif
> -			    !acrtc_state->stream->link->psr_settings.psr_allow_active &&
> -			    !aconn->disallow_edp_enter_psr &&
> -			    (timestamp_ns -
> -			    acrtc_state->stream->link->psr_settings.psr_dirty_rects_change_timestamp_ns) >
> -			    500000000)
> -				amdgpu_dm_psr_enable(acrtc_state->stream);
> -		} else {
> -			acrtc_attach->dm_irq_params.allow_sr_entry = false;
> -		}
> -
> +		amdgpu_dm_enable_self_refresh(acrtc_attach, acrtc_state, timestamp_ns);
>   		mutex_unlock(&dm->dc_lock);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 31441f0ec4b0..64a041c2af05 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -265,11 +265,10 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
>   	 * where the SU region is the full hactive*vactive region. See
>   	 * fill_dc_dirty_rects().
>   	 */
> -	if (vblank_work->stream && vblank_work->stream->link) {
> +	if (vblank_work->stream && vblank_work->stream->link && vblank_work->acrtc) {
>   		amdgpu_dm_crtc_set_panel_sr_feature(
>   			vblank_work, vblank_work->enable,
> -			vblank_work->acrtc->dm_irq_params.allow_sr_entry ||
> -			vblank_work->stream->link->replay_settings.replay_feature_enabled);
> +			vblank_work->acrtc->dm_irq_params.allow_sr_entry);
>   	}
>   
>   	if (dm->active_vblank_irq_count == 0)


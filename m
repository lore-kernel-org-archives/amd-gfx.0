Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A92DC02183
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 21:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C622410E9F6;
	Thu, 16 Jan 2025 21:02:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PmM+O0RZ";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74C0910E9F6
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 21:02:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DvxXx1DaaXNSAmxCFoycxDxziygYK0COO6YRnICugE8EXJ2AdsF4GSNqiWbtYzTo0g6oY445E2sz0gdvrUTsubyWaN0dmXEvy+zsfcoSvS+JuTE6IsXOB76DxjpwtHinr0Ufoim6AwdPTi+Gy1vmBRZQBDsHsbp6swDh62ms/mXAbgd/2Yz2DZ+DmyVRt5R42ZQWHxxnQiJ5Y/uvxOeU4fevl5gIzhnOemXKitLo4TAOsYsoI2XQ+4kTt3x8oX074b+KqbtUsqQZd1UDZlyl6aX2Bj/ctfN7eayf/tJy4za9kU0A10iEp03j7hk0PStr1Ep9WnsaxZIg/lmpi547HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrBu5Px+fxkmahLMyUl2GWooXvnb5mP4CRuxohPjilw=;
 b=tQGHMAivfQo27RlyfDOtVe6/asDJx1/x5PYNJDIJpOVyPc14GwDPzsry11ijgATCOcTQPliqK35BulguCUKcEAWhcAT3tyWMV25gPe34Qzg9IFbbKUMKCbt68UwP+wGS/MwCl0b6FROdmg7tvDBtPLuHKhqXhQ3/UAoYQJ+vcVVAW/4afMcS3yx2RDdF3eso1UA2GrwxsgkPrcGdI2h5Q39eIWYPCQCHrznxBu8JXgJc3DGdYWU529ZrFv1gGkeLUZj76vyeSRf1LvtBRmKf+7vVE7yVZIeS1TL8idqiRRtVgascO3FUPyHTSULL2yCL16td8R9FY7ucZ+EzeTL7xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrBu5Px+fxkmahLMyUl2GWooXvnb5mP4CRuxohPjilw=;
 b=PmM+O0RZmfcCVScNeJZZrMuB9XNQc8lti54YAtaJKNrZ0S6iO975ZlLzV/9hqNYwgKZtDvHIlYxj78sQC1ahQvd3kRr3QCDPAMfm2SFODU1+uhc3HJcPbeZm9bJvrhNzNmugU2SDfQoFfkiwoTF1n4CnxCwAhsQTsiasY27iZGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ1PR12MB6074.namprd12.prod.outlook.com (2603:10b6:a03:45f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 21:02:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.017; Thu, 16 Jan 2025
 21:02:42 +0000
Message-ID: <f2bfd02c-dc41-4e18-a59e-465b113e6288@amd.com>
Date: Thu, 16 Jan 2025 15:02:39 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 03/15] drm/amdgpu: free all resources on error recovery
 path of amdgpu_ras_init()
To: Jiang Liu <gerry@linux.alibaba.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, lijo.lazar@amd.com,
 Hawking.Zhang@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
References: <cover.1736732062.git.gerry@linux.alibaba.com>
 <fe7c662f67cb5f079cef7688d033bf93539db277.1736732062.git.gerry@linux.alibaba.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <fe7c662f67cb5f079cef7688d033bf93539db277.1736732062.git.gerry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0063.namprd05.prod.outlook.com
 (2603:10b6:803:41::40) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ1PR12MB6074:EE_
X-MS-Office365-Filtering-Correlation-Id: 887bd019-2ed6-4eef-fbcc-08dd36711deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bE5MYWdhNEp2MDhNMGlLWVRXYktHampNekxFc3diK2JsZTQxUjlaT2NIMUxC?=
 =?utf-8?B?bFdSTUdrZmJQN3owUytPS1RZMjFEaEptOGdaL2poMXJnZElZMEk1aGlKMlht?=
 =?utf-8?B?cnY5Q3pKTEhZVkNBNithZWxwNkt3R2toU3RvaytmdkVwNmVXSTVUaGJiWkUy?=
 =?utf-8?B?ZDJ6Y2FUWHBVSHlrdGRkYjhQbEY4aUtpcTlybllCREVOSi9FUE1jR2NiWEFx?=
 =?utf-8?B?OUJiSFY2c2ZUQlJWU1VKUE9kanZYQnVCbGtiM0NjRkw1Y3dPMm1lclRKQXZl?=
 =?utf-8?B?ZG4yc2ViRkVzT0xPQ1pNMVZwSUxBOEE3eE1GN29LakRBN0tJeGZkQjZkbmdX?=
 =?utf-8?B?R0pGUktvVDU5YzB1ZEhTSlMrRnNYdXRKajhOcmt1a2FiaFpBWFEvbHgrZDdJ?=
 =?utf-8?B?QjBTeEtDU0xTT0N5TSsvVFV5UThKTXRRcDg5QlZmTEs4V0N2MnJ6R2psN3JP?=
 =?utf-8?B?eGNuemYwTU9tWlEwY2pZNWxLM2IwVitTWkNIa0h0ekg0VEx5M2RwM3VnM0lY?=
 =?utf-8?B?R2N1VmxSU1Flak1qWEdpekZoNXF5SWtacnAyeUdoRTZFYUtSM1lQN0ZsZ1M1?=
 =?utf-8?B?Q3huVFlOdXQ4cnVTL0plVXhiU3lSVXZQRzNURDROOEJIUVVYVU02VzZZTHNa?=
 =?utf-8?B?R0QybG9pVTBQSnUrNmpqWExBY1F4RkNiVER2VW14UHZsVkJjSmZURUY1SU9M?=
 =?utf-8?B?NjRmNUsxZGVFalNHaW1ocW1GZi9hTnZ2OU02Q1c1OXM3MjdDSk9vd1VLdmNX?=
 =?utf-8?B?RE1DL2ZBTWx5dDdIVTlvM0crcEwrRXBmczYvZlVSYmE4eVlzTkR3MmJTNnR2?=
 =?utf-8?B?WTFPUXVlRlFlbEhTUStwd3I1VnhjQVBlQ0J2LzQvb0dHWXlVbWllZjFsazJ6?=
 =?utf-8?B?Z0hjK3g2S0xhQzZUdS81QlNSNEtYOThmOVVvMEozUlhuOEROd0RndHJ6RGpG?=
 =?utf-8?B?UUsxNFdnbm5HKzBycDE5NmxNcFZXMGpQRDJPVzk4UnJGWW1qNzZwbmN1QmUv?=
 =?utf-8?B?Ly90VFFVMmlqK05kRlEzTkxvQ29QZnpDV3psclJsQlBTMEJGS3g0ZVR2bm5S?=
 =?utf-8?B?eUVGL25PczMrUUFIRmEwWTN6OHlManBMbExORG9BbFRVNFlpc3d6NVpLUnpk?=
 =?utf-8?B?TmNjd1BsZHJuSjBpcFVheWpPTzQ2dDVPUmdQZlBRY3NBcmQ2Y0N1R1hPbkpr?=
 =?utf-8?B?YTJ4TENWSXg4ZHlaa2Y3YnFROThNcDdwK3JuL2tvOThxeXJYbzlESlFaK3ZQ?=
 =?utf-8?B?RjFEUGFxekJReUVSbjVITEc5MDFINGR0VkJ6RjZKdlZNcmswbnFpSkpncVBh?=
 =?utf-8?B?WjZ1VTFsL0ZGNkh3K3dsZDZKN1NyREtkVDRCK0tuUFhNUTNCaUJkdkVjeXA5?=
 =?utf-8?B?QWJDQWw1M2JtUkYyQlF5OVFBQ3RMb3FZdWgrNUMyKzZmSTVwZjRRQTlKVTli?=
 =?utf-8?B?cGo2NnpKMDI3STlTR3A1UlB1bitRWUp4UzFpZ2RiUjhtbXVBTXd3OStIR3dQ?=
 =?utf-8?B?c2h6Vmp0dFdMVGJNdjYwbXA3WlhsWVpkdkd1QnFHcG8wbUZYbVFMSEhPOTdB?=
 =?utf-8?B?MElhNGxGb3FHZHpBbnp4MFZTVm94U0ZFWlFmUklGRHpzVllINlp6MmRKZkJk?=
 =?utf-8?B?WTUvNlg5dytiNlc2c3Vaa21TTWw2M1JTT0tqWFdmUWtyVGEwZmc5anhtTlJt?=
 =?utf-8?B?ZW12V1hjU0VWaURwVGFiNWdIbkRzWmZPRnJ4dnBzaFExL2o3aTJScXFFSUh0?=
 =?utf-8?B?TWJiWnFTWTROMjdMOXFJcmgrMkloTG13cWp0OGN5RVovN0hyZGlQa2pzVVdQ?=
 =?utf-8?B?ZzVnUURseWs2VkxMSVV0S2VUTHhCeUdSVUhabENrSkhqWUxqalJqQ0wxeFVT?=
 =?utf-8?B?TGplUFkyR1RhVk9TVVBkWk9Rb1RmUlFCa1hvaFhRZDh2VWVaZDhTM0RQbEty?=
 =?utf-8?Q?G5eapvzMZCI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(921020)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWtaSnQrQy9vWkdjcXJ0ZkthYmtTWnBWeW5DLzhLZlpmamxGSG9LUkZiUmw3?=
 =?utf-8?B?TW0rVTV6MWxnWFF1blJVWTV4UHhmRng5cGg3UWpqdGZwMHB5blJPSlNkcTAr?=
 =?utf-8?B?ZmgxdEs3V3RQVk5IdjFDc1lnKzZyYnlIamFiOURBZ0lUcVlGdGRtc2RSSFA4?=
 =?utf-8?B?d2l4cXpwcWk1bWdVc0Vxd2p2dktmenpmY08yNHdmNDVkaXhLcThOV01veEMx?=
 =?utf-8?B?LzUwTkF0ZlB3Y3hGREp3bEhsVURxZHdkQnN6eW9wTWYxbVpjN1ZzZFlWMkJL?=
 =?utf-8?B?ZHYxVC91M0phVTA5aE5iM0RUSndyc0hZekRFRHNUYkF4QkFaN1dpQXlqcmxQ?=
 =?utf-8?B?MkJDRXE2QlNpeDdrcmQyeXpGRUIvRk1hbUU5RkxHRGxPNEoweC9GZUVpdk90?=
 =?utf-8?B?S3UyWm5XdVRWQjRRMWpOSjZlcm93RlJZVWVCcVBsNzlDWHh1UDUxVlhWR0gw?=
 =?utf-8?B?ZzJ5SkZIeGVMYXhTZEFkdEt1SXBCeUlSSHgwVjdWcE9ISUZIdzlBQzZucTBV?=
 =?utf-8?B?a1hXS0NERzlIYU0wL3YrZVZtMkhabEJvWVRyeVpNcmlmV3RLTVk0V3JrdFcy?=
 =?utf-8?B?dWhGWkRTbVBCQkVvbWhqcHpFeDNhekZvUUxFZ1Z4YXNja1hzOU14eXdUcVE5?=
 =?utf-8?B?Q0NiMjlDV3VCc0NpVDg4eXBMRjR0NnE1WlhaSHZuaHBsNVlTa1BiQXN2TmVC?=
 =?utf-8?B?cld4Q2txa21ZMjVvMzBBTnRsZ3EzSUVmS2I4WHI5c3Q0em0xdmxUbGF4YXJl?=
 =?utf-8?B?TU1sT1FSTm5pQ0ZVeEV0SDYvOHRrNm5rNFNtR0JTejUxZ2p5SDlPaVFLOGxa?=
 =?utf-8?B?bVlGQ2pMRHRSbjl4QTUzclhNc3lTeW9QcnUrWUk3anoyU1JKYmJXOC9WQ0Nu?=
 =?utf-8?B?RVJjNnI2WUVGTk9XQW14TEtWSWg2cWFEQVFaRVdDSEtsRERxdzdmODdaWXVZ?=
 =?utf-8?B?ekRMc2hHdDJiM24zcHZCandsVW5rQWpvRDE1YllsczE5ZmRXVGxsUCs3dGEz?=
 =?utf-8?B?L3VnZmszNEJva2lDTGFsQU9QY0VOOFY4eWIvZ1Q4a2RGRXdiSTRRQmhVeWY5?=
 =?utf-8?B?VEpCMWg3Sm5EaG5tZnBUZjJLaGZPbG96aXEzNDhWTjViNlBWNzdOeEg0U3U3?=
 =?utf-8?B?Q0hENXN5SU05cytvV0tlaUoyNkc1aThWMVFydlV1aDQvQ2NIbTZnbXEwMWdG?=
 =?utf-8?B?SlVmOEZ2cUE0Qm0vY2VzbmVjSCt3Sko1dWRGM1ozUk85MlRocXRHVEU2SXNI?=
 =?utf-8?B?MFYrRFlvQkY1QUFZMmVwNnU5WjAyNmYrbVViaW1xN25JSFBHMGZZRnpzU0VY?=
 =?utf-8?B?a2J3VDRycFl5ZkRCTVpBUkxOL3o1UTUrWFBuYjAwSnlmNjl2dGN3YWwxNjky?=
 =?utf-8?B?SS8wZExCU0tLVWFVYWZ6LzZnMlowUFUwY3JMaHhzZTRyRVhVZGpzUkVRc2ll?=
 =?utf-8?B?aVlhUWFUeXNwTU0zc0FQY0lQNnllUlRxMWtSa3QrL3BOMG14cldYRG1qOUs4?=
 =?utf-8?B?MzZWeTBRQmc5Vm9kUmhrMWFIK0VPWkI0RWFMWlBQQWkrT0FQRjlrUGpxbTZx?=
 =?utf-8?B?VWtLNllOcnN5R2NTK2VQL09ROTV6emt1NU9lSlpkL1F0Yk5rVjZPaHVjK1B5?=
 =?utf-8?B?VUdLSEdzTXZmNEd4RHRKd2JiVmYyNUd3ekt2bWtaWFNYTEsrRTBVNnZxVDRz?=
 =?utf-8?B?ZGYyNmIwaS9BcFpwdEgyMWFyOHpreVo5YjdsYmxBU3dhRmJVL3Fqb1VZSDI2?=
 =?utf-8?B?OUpuZlEzdXUzQ3JDN1F6QjhDYmdHWlo4cm95R1g1Kzh3YmhIU0tGZ3NZL1Bl?=
 =?utf-8?B?Q0RnQ3JHdjdzVzd3UENkbnRHRW9sREFjeVZPendQY2wvamtHTUE3QWRMdDhM?=
 =?utf-8?B?NlJ3SzUzZWUxTlVBWGhPVVA2am92WE9xMnlCak9nK09NVFVFUG1MbEUvbjAv?=
 =?utf-8?B?WU1HSlowVDdUVndnaWZmTkZvTGRGVmRwcGtjQ0pYcWVLRjM5UE42V3hyQk90?=
 =?utf-8?B?djMvTWM4VGl2ZGxhMEU2VHcydHJSNitiNSt1eHRiNEVsZlBzTEVGZHNiZWxD?=
 =?utf-8?B?SWhiVmpMazlRc0d0enUzS2dCSzdCeFVFVlJpalQ4dkNHNllub05UUzZMM1pI?=
 =?utf-8?Q?YSlWDJH1YH1qCNhHi15QI5RH1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 887bd019-2ed6-4eef-fbcc-08dd36711deb
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 21:02:41.9165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Bo2DBFo2JlElspXfuPMXNUcMjqmXzPY9tMlcPE6heezRhIqhwXJyYqaSj9FASw8UssJfSbEQT4EXHgKgKyN6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6074
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

On 1/12/2025 19:42, Jiang Liu wrote:
> Free all allocated resources on error recovery path in function
> amdgpu_ras_init().
> 
> Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index c10ea3fd3e16..6b508a9b1abe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3864,6 +3864,7 @@ static void amdgpu_ras_init_reserved_vram_size(struct amdgpu_device *adev)
>   int amdgpu_ras_init(struct amdgpu_device *adev)
>   {
>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> +	struct amdgpu_ras_block_list *ras_node, *tmp;
>   	int r;
>   
>   	if (con)
> @@ -3953,20 +3954,20 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>   	 * to handle fatal error */
>   	r = amdgpu_nbio_ras_sw_init(adev);
>   	if (r)
> -		return r;
> +		goto release_con;
>   
>   	if (adev->nbio.ras &&
>   	    adev->nbio.ras->init_ras_controller_interrupt) {
>   		r = adev->nbio.ras->init_ras_controller_interrupt(adev);
>   		if (r)
> -			goto release_con;
> +			goto free_blocks;
>   	}
>   
>   	if (adev->nbio.ras &&
>   	    adev->nbio.ras->init_ras_err_event_athub_interrupt) {
>   		r = adev->nbio.ras->init_ras_err_event_athub_interrupt(adev);
>   		if (r)
> -			goto release_con;
> +			goto free_blocks;
>   	}
>   
>   	/* Packed socket_id to ras feature mask bits[31:29] */
> @@ -3982,7 +3983,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>   
>   	if (amdgpu_ras_fs_init(adev)) {
>   		r = -EINVAL;
> -		goto release_con;
> +		goto free_blocks;

Reviewing this shows there is a mistake in amdgpu_ras_fs_init().  If 
sysfs fails to init there it still returns 0.

Please modify amdgpu_ras_fs_init() to 'return r' and then use that 
value.  IE:

r = amdgpu_ras_fs_init(adev);
if (r)
	goto free_blocks;

>   	}
>   
>   	if (amdgpu_ras_aca_is_supported(adev)) {
> @@ -3991,7 +3992,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>   		else
>   			r = amdgpu_mca_init(adev);
>   		if (r)
> -			goto release_con;
> +			goto clear_ras_fs;
>   	}
>   
>   	dev_info(adev->dev, "RAS INFO: ras initialized successfully, "
> @@ -3999,6 +4000,14 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
>   		 adev->ras_hw_enabled, adev->ras_enabled);
>   
>   	return 0;
> +
> +clear_ras_fs:
> +	amdgpu_ras_fs_fini(adev);
> +free_blocks:
> +	list_for_each_entry_safe(ras_node, tmp, &adev->ras_list, node) {
> +		list_del(&ras_node->node);
> +		kfree(ras_node);
> +	}
>   release_con:
>   	amdgpu_ras_set_context(adev, NULL);
>   	kfree(con);


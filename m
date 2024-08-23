Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F3BC52D7C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 13:44:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79EBF10E8B8;
	Fri, 23 Aug 2024 13:44:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3X9LX3oA";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C5E310E8B8
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 13:44:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1HbbQPwlbJPsUME9F8tNs4IRQMzydd7/jx0v5OmoXy9m++/xrs994lO95bUPkS9j1ZcitRFvQl1K0vzYVT1M6VxWeCWHCMkm26txvY6niCVxQg7OaqmoFlOiu528juhaXFaKlTo4xC6yE9iziE8iL+DYaFLrgningH7GQobJl4xq+HM4bhvHqPtDpotCIpIbLcVgVohitcjDGqUADslay8rj5iTjCUtoUMh5o+rEKAlGwJoPD7GKu2y/qAZlQMZ/ocZWmWtuxB9d95F2PHkBCo+ovAKyL3BtlqW8bFWmOyUBwgU9zOv5/Y/UyVNYt+I/2SJVQ0w4Nvxo+rv48X45w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUKANDILzrpB/jmSP9DTENi5kAaH4CRLIwjA19hS1pc=;
 b=Seol9zitwheAmgC3c8umySJwuRSbA8fThe/KFx6D3hSefw0+8eFruQTcr7o3csrFy+j0uqeFdV72+SdGP5JGghuS2Ck+E+4uOwYr/A3SdowPrmxRwdFHgeeGlYORzylWmj5UP32vM2uq9y9NdtBpWBqzRsouIWpZQGazUBMkRJZzr8DUyz/Ox+HUHaMzD4c7eo7Tv4UUoSI1WG6Pbc83V8kSMCwZQLlOTKvI54F+sikStEfU14Jh0HFi82h3zD8KznUFESYLAYTVkCM1TKDn1yS1/i+eZ9fEYPLfxO+VdPPjfWA36vSDTS4AJaRYJ59/s78k+Fprv2hRTDTLHOBSWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUKANDILzrpB/jmSP9DTENi5kAaH4CRLIwjA19hS1pc=;
 b=3X9LX3oAAFvpcws3mCGz3IPZJc1YHpxWdvYhvkJJ5S7veYD1SGG9hbyEYc1sZ8Am87prry6K0MzMWujzZbD/DBxYXzcjcc5noMdfLgHWvFIAc8ULR0Z+tBiibiFk9wD13jTy/4rn5KjWLCemSTPB2d9ohN3yKKoX3D0dwgXvjVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21)
 by DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 13:44:51 +0000
Received: from SN7PR12MB6839.namprd12.prod.outlook.com
 ([fe80::eaf3:6d41:3ac0:b5f4]) by SN7PR12MB6839.namprd12.prod.outlook.com
 ([fe80::eaf3:6d41:3ac0:b5f4%6]) with mapi id 15.20.7875.023; Fri, 23 Aug 2024
 13:44:51 +0000
Message-ID: <95874a48-3b75-44ef-9ee3-5b05d47982f3@amd.com>
Date: Fri, 23 Aug 2024 09:44:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Don't wake dGPUs while reading sensors
To: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
References: <20240820020435.472490-1-superm1@kernel.org>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20240820020435.472490-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::25) To SN7PR12MB6839.namprd12.prod.outlook.com
 (2603:10b6:806:265::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6839:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 9833acd1-4197-4b26-f511-08dcc379c32a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0JxM3hWbFlzWHptYSsycEt0M0JDS3Q3NGY0b2RDTDV2bDZiQWk5NWQ2dU9l?=
 =?utf-8?B?VEZDbjN1dXFQNHhmL0hvTWhZTTgyRFZheDdZNk1qcDcyOHQyaG5xMnJYK2tI?=
 =?utf-8?B?RUFJSm1jWlZ2MHJZWTVnQ1VNMysvYjVNb09VZDBxTmQ1V1RDRmthOURRS1A3?=
 =?utf-8?B?Tk9Cb2dQcitWSjByWGltQzRsUnJsd3BuU3lkMDNKMEt1UjFxM3dyaUZUL3FV?=
 =?utf-8?B?OHlJd1RwNmNpWC9EbEVOYnF3aFRMZnluMHlrUlFmcFk1STU1bm8vdm5QM3E3?=
 =?utf-8?B?cVovU2hXb05yOUdqbWx6K25MeXdYdlFuYjduYTR6b2RpbEQ0eURnL0NONDMx?=
 =?utf-8?B?N2dHbDhyVy9zVE8xM25sTWsvZkdRT1B2MjZEZVZSVjdsRGZhaTlsTXVLZmx3?=
 =?utf-8?B?S2pDVWgyUTU3NzlVOVJuNWdyMmFhSlU0WWJFbW90bjA4bFdzZzdFT2c1MGwy?=
 =?utf-8?B?VUlWT2lmdDdURTIvOUFhTkFYbHVJbGF1UnBQRE16dnFvOFlWcEFUcUcwVU92?=
 =?utf-8?B?dFB4THIrZFBvcDdVVFArM3FHbU1OQVFwK3RhNlVXTlk3b21aODZVZ1pEL1NJ?=
 =?utf-8?B?VVdmV2R2enFNWG1sNkdrN1piUmJZdVBwUEpSdDhwK0RCT0ozUzNqV3pYRlhp?=
 =?utf-8?B?Rnh5S2NnZ1ZxNFJ5dG85VVJIMnRmRnpRYjUvdWlpOW12Wm9kS1I2b3NVOEFG?=
 =?utf-8?B?YWlXZ0ptY2lUWHVwekxlREFtODBaNVZxUHpWS3dkY0VsNWlHOUhpMkFPTEZM?=
 =?utf-8?B?TDFZK1lmekkxcm16aFhKT282NnpXMGsvUUpROUc0QlRXSUVDUmx0U1lTVXht?=
 =?utf-8?B?NnRaK083L3pyT1BIK01zeDRtUTRiL3dqM2ZsTmNTdGwwNEpMUFhtQjNjSTdi?=
 =?utf-8?B?L1haUVp1bzgxQnFReHh6ZGFKMGFXNEl4bzU2YWZCSFVRU091aHZvaHkxeGUx?=
 =?utf-8?B?Wi9zTTJUVHJXRXluemZ3dTcwMDJKOHNZaUVuZ1RaNjArbTFoM21aa3dOUUxu?=
 =?utf-8?B?Y05WQnNUcWZBN3FXSUh0V08rVkkwQ3QzUXNoOFpvTWoxUUprWk55R0UwaWpI?=
 =?utf-8?B?QmIrUHhVZmhXanJzMzZVWjQ4aUR2Z09TQWlWOVpjTGJXT1R6eU1DSmJiTHl2?=
 =?utf-8?B?V25XRml0TlJyUUIwUENJQkFjeUNsTWtVZmtzd0FvMTJWeXFybkFrektacWpZ?=
 =?utf-8?B?cVB6VXZkSWw5emhZam5CQ2ZQeC9zWHZEdXZVN2R5V1ZHbUJFeWFXY01Ia2dF?=
 =?utf-8?B?TlNpZ0pSQVZjVGpObGlDV1BBaU0yNTRNMVNmSmJYbGY3K0FkZDZlSW9CQUlK?=
 =?utf-8?B?aFNtVVJyVk5IdjFvVWVmVkNUT1dKODFZTkgzQ1c5bVREV0w2bTFMQjBjckp1?=
 =?utf-8?B?Q1krVThvS3Z5Z0VncGhEakZFOGtqc2lwQ2xmZDMvaVBIeVdtcitHR1ZhMkRS?=
 =?utf-8?B?WWZNRlloNTNRSGxWclF0dFRaa3BLc2NIRFhNV2I0U3NXTG5YbDJSSGJaQVRU?=
 =?utf-8?B?TXdBS3JaWk84STJVSkVWaHN2TzVPSlNqa2UyYW9PWjF4MHpiWEY3TUxKMERo?=
 =?utf-8?B?bnRxaFh3VmJ5eWw4WGtLUzl4S3lxTFdLOWs0RWc0cW1tZjhOTTR3UzVKbXIz?=
 =?utf-8?B?TTl1ODJSNFAvZEVnNmZSemtZK2E1bmdpbXUwTkJpTERCTWZ1VVJtSTNQMUxG?=
 =?utf-8?B?bEJ3WldsMGNoL2hXS2tzaE51bWtycXY2WmFDRmgwV1plZGpTbGtyV0g4Szlx?=
 =?utf-8?B?enpDUlJVZElmSFZtTVJHdmdqd1ZhSkhvditoYU1NZjgvU3RFYlBFU296T3hK?=
 =?utf-8?B?dGpGV1dHcjM4UjVTamJ2dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB6839.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0FTM01yYVFlMUk1dHRUZ1ZGODhiRkIxYlBIN21uNkp3SUNKQVVqUUdGd000?=
 =?utf-8?B?VXNoWFY2cmdaZUVVam53aUdMbU1LQ21wTkdPMHJDeUdPbzVHS3NEdW9pNDJ2?=
 =?utf-8?B?ck1iOThrUG93SWtWbG4wWXltNjE3dkY1aFl3OVVid2ZjTFN1Y1oxRk16VUd2?=
 =?utf-8?B?WGpLVU5UNTA2azhJczk5eHMyYTgxVkNEdWtCSlZpQVdFNUJtMUY3eXRiYVoz?=
 =?utf-8?B?Sm1GYm5hQWtjYlVZQTA4TDdzelgxazdyOWZmTk00SHkxR1NUd2o1QlZrbVox?=
 =?utf-8?B?eFVXeHpNSU1PYVA4V1F6dXRFRTREOXkrbWVLbzJPMzZNMXhTbHM4R3Q5Rm5R?=
 =?utf-8?B?Wisvam9NZitTSmh0UU1ycTVkQ2dQZ1NYRXFadHJjSENhMDBIV2FrMTZrY1Nm?=
 =?utf-8?B?TTR1Wi9GUGJzdk1Qa29PaWY0am9NNmpmcVZlL3AwNlZyWWtMUkVodnhtMUxH?=
 =?utf-8?B?YTJLZWFBUWEvUGcvS2lvcyt5RVkrNFJ3V1AxTHE0UHRnNnV3VTVNTVFLZkRS?=
 =?utf-8?B?a0ZxOTJZOFhhdHJoSi8wdE45cDFOaEJUMDVSa1JwazJRSFROK2VyYUc1dXdZ?=
 =?utf-8?B?VFlhUFBEbDI3ZnJFM3ZLV2RyY0lGL0VsdExONkNGbFlud01YclNxQ01DSlJD?=
 =?utf-8?B?MHRkMEc4SjJoSi9rRWI4dzAxMXFPYnZKZldNZ1I4YXZZN1E1WTU2b3BpUVV4?=
 =?utf-8?B?Rzk1RFU2c1dKWkFDT25oS2xscFNmS1RGeVpmenFwS2RNTnhTQUdsem9ER2lR?=
 =?utf-8?B?cndTQzdLMzNCSzJEdVRrMjRsU0pyblFXeUJ4Uy95MnA2N2JXS0thSHY5a3ZT?=
 =?utf-8?B?WGlJYUViOVVoQU5IUHVlR3dGWWYvZ3VWb2pOd29Jd2JRRzRwY3ZjYVZUdVlE?=
 =?utf-8?B?SWdZMnV2TXJ0Q3NiQTlCM2tXaW9jSjF6ZE9JTXZFc2gwR2UyLzBOR2E4T3ZK?=
 =?utf-8?B?Ymx1eDdiTk1JclJHSUNBS01nVFNrN2prTXJEUU43Wk40Ry9YQm5ESUhxdm43?=
 =?utf-8?B?UzJZTFZxL1NTeklsVkZQTURSTm5oU0J5bDZTWUtDZzlaNFlTWlVwbFJQZjRB?=
 =?utf-8?B?SHU2dWMvM3E4QzFqbVVZcHdBdk1VbHhFR09pa3ZaVzluQUx1b29aLzdMbDBU?=
 =?utf-8?B?MzhSSEpGZGlCbVNJN2RTVW1ZN0hsSk9DSU1KRHc5c2pZWERUQUNPRTJuYTI4?=
 =?utf-8?B?bkgvYzFQRVErRTBaTFVWZDdhcFp4MlFnUzR1dDJKZmVmaHlDaThhSkRZbkQ1?=
 =?utf-8?B?bThKV1FQbHFOaHRjNVlPdFZDRWZ1ek9YQkUzRGZ4L2xKMXhMdVBVcmRVNWtR?=
 =?utf-8?B?MW9vMVJmMmdLR2xxeU9ScnhMTXVGV04yeS9WcGQzZ2YzRHBHY3pKRys2MFZ6?=
 =?utf-8?B?VytPUm04UTZZSERWMGZWOUxKNjErMzhDYW5nWCs3c3lCdzhKa3R4TlFURGQ5?=
 =?utf-8?B?d2dmR1NSVDJUR2JIeW1zSEhybTA5czhQNHlxanhsMi9WMldReUtLc1l5UFFS?=
 =?utf-8?B?K1J2WTNVSkJjMnVkN1E1RCtlYmZVMTVNNTlKYnJMN3BtS3VNT0ZTbXlycmpG?=
 =?utf-8?B?aVRJak52aGFmNm96TVk0eXVXODRkRjRYUzZXc3JYVVhVT3dVMTBPUGxNamF5?=
 =?utf-8?B?Mndud2Nqb2I3cXRLTVhwTEM3aVV2QlRJMFJ6N3V4WmF2UURxa3JrQ0R4b0g5?=
 =?utf-8?B?TXRWQ1pxUTk4Q1VvRHQyb1VnMzFnbFRCdTJ2WlJiYXJEMHduV3RsVm1wVWFz?=
 =?utf-8?B?TDl4Y2gzTGM5MnRnUnZzcDR4bUpNUVdYYjh6bHBpd0NTaWhURlRvWWFEK3Rh?=
 =?utf-8?B?RmxZdm1TVkhWM2NXNEdrRzRXUHI0eGlGbUR0UFNmQXVaMEZPNGQyRlZNOHox?=
 =?utf-8?B?STl3MmJsWHlkcUpwRGFLNzIxSGVDWDNLSWZRV2N4UmszTUcxS3ZMRUNXcG0y?=
 =?utf-8?B?VWtEQ2VJdVVYOUJyclgwL0YwMTgvVnFBak5kMTZ0TkMvVmVFOFVFVml3NWVl?=
 =?utf-8?B?aXFqdlFhcXY2Wi8wV3dqN2xVVmxvSUFlUGxSeElwemlQRmlSOFF1R0ZIZ1dv?=
 =?utf-8?B?bXR3NmM0czdqd1k5UmFBU05lcDRUeWtNMjg5dmdjSU5WUERqdU1OdVpvb2tY?=
 =?utf-8?Q?Sv4BdZRxHcxEZcldTeHgJTKnx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9833acd1-4197-4b26-f511-08dcc379c32a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6839.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 13:44:51.3321 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zNYzq6kj/MzbcqPtUT5HkhPhtMhRK/o7qk2XpaNKsAJWa6KyhqGp20XNDtbMocf1+Eq2KIOgkf7Q7f6vLv5/Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434
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

On 8/19/24 22:04, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> If the dGPU is off, then reading the sysfs files with a sensor monitoring
> application will wake it. Change the behavior to return an error when the
> dGPU is in D3cold.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 90 +++++++++++++++---------------
>   1 file changed, 45 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index c11952a4389bc..d6e38466fbb82 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -142,7 +142,7 @@ static ssize_t amdgpu_get_power_dpm_state(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)

Seems like this expression is used rather often, so it might be good to
have an inline function for it. Something like the following:

static inline bool amdgpu_is_d3cold(struct amdgpu_dev *adev)
{
	return adev->in_suspend || adev->in_runpm;
}

>   		return -EPERM;
>   
>   	ret = pm_runtime_get_sync(ddev->dev);
> @@ -173,7 +173,7 @@ static ssize_t amdgpu_set_power_dpm_state(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	if (strncmp("battery", buf, strlen("battery")) == 0)
> @@ -270,7 +270,7 @@ static ssize_t amdgpu_get_power_dpm_force_performance_level(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	ret = pm_runtime_get_sync(ddev->dev);
> @@ -309,7 +309,7 @@ static ssize_t amdgpu_set_power_dpm_force_performance_level(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	if (strncmp("low", buf, strlen("low")) == 0) {
> @@ -371,7 +371,7 @@ static ssize_t amdgpu_get_pp_num_states(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	ret = pm_runtime_get_sync(ddev->dev);
> @@ -409,7 +409,7 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	ret = pm_runtime_get_sync(ddev->dev);
> @@ -448,7 +448,7 @@ static ssize_t amdgpu_get_pp_force_state(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	if (adev->pm.pp_force_state_enabled)
> @@ -471,7 +471,7 @@ static ssize_t amdgpu_set_pp_force_state(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	adev->pm.pp_force_state_enabled = false;
> @@ -541,7 +541,7 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	ret = pm_runtime_get_sync(ddev->dev);
> @@ -577,7 +577,7 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	ret = pm_runtime_get_sync(ddev->dev);
> @@ -760,7 +760,7 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	if (count > 127 || count == 0)
> @@ -862,7 +862,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	ret = pm_runtime_get_sync(ddev->dev);
> @@ -922,7 +922,7 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	ret = kstrtou64(buf, 0, &featuremask);
> @@ -957,7 +957,7 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	ret = pm_runtime_get_sync(ddev->dev);
> @@ -1026,7 +1026,7 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	ret = pm_runtime_get_sync(ddev->dev);
> @@ -1095,7 +1095,7 @@ static ssize_t amdgpu_set_pp_dpm_clock(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	ret = amdgpu_read_mask(buf, count, &mask);
> @@ -1280,7 +1280,7 @@ static ssize_t amdgpu_get_pp_sclk_od(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	ret = pm_runtime_get_sync(ddev->dev);
> @@ -1309,7 +1309,7 @@ static ssize_t amdgpu_set_pp_sclk_od(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	ret = kstrtol(buf, 0, &value);
> @@ -1342,7 +1342,7 @@ static ssize_t amdgpu_get_pp_mclk_od(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	ret = pm_runtime_get_sync(ddev->dev);
> @@ -1371,7 +1371,7 @@ static ssize_t amdgpu_set_pp_mclk_od(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	ret = kstrtol(buf, 0, &value);
> @@ -1424,7 +1424,7 @@ static ssize_t amdgpu_get_pp_power_profile_mode(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	ret = pm_runtime_get_sync(ddev->dev);
> @@ -1463,7 +1463,7 @@ static ssize_t amdgpu_set_pp_power_profile_mode(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	tmp[0] = *(buf);
> @@ -1517,7 +1517,7 @@ static int amdgpu_hwmon_get_sensor_generic(struct amdgpu_device *adev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
> @@ -1630,7 +1630,7 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	if (adev->flags & AMD_IS_APU)
> @@ -1673,7 +1673,7 @@ static ssize_t amdgpu_get_unique_id(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	if (adev->unique_id)
> @@ -1846,7 +1846,7 @@ static ssize_t amdgpu_get_pm_metrics(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	ret = pm_runtime_get_sync(ddev->dev);
> @@ -1887,7 +1887,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	ret = pm_runtime_get_sync(ddev->dev);
> @@ -2005,7 +2005,7 @@ static ssize_t amdgpu_set_smartshift_bias(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	r = pm_runtime_get_sync(ddev->dev);
> @@ -2227,7 +2227,7 @@ static ssize_t amdgpu_get_xgmi_plpd_policy(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	mode = amdgpu_dpm_get_xgmi_plpd_mode(adev, &mode_desc);
> @@ -2250,7 +2250,7 @@ static ssize_t amdgpu_set_xgmi_plpd_policy(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	ret = kstrtos32(buf, 0, &mode);
> @@ -2652,7 +2652,7 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
> @@ -2684,7 +2684,7 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	err = kstrtoint(buf, 10, &value);
> @@ -2742,7 +2742,7 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	err = kstrtou32(buf, 10, &value);
> @@ -2787,7 +2787,7 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
> @@ -2817,7 +2817,7 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
> @@ -2881,7 +2881,7 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	err = pm_runtime_get_sync(adev_to_drm(adev)->dev);
> @@ -2912,7 +2912,7 @@ static ssize_t amdgpu_hwmon_set_fan1_target(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	err = kstrtou32(buf, 10, &value);
> @@ -2956,7 +2956,7 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	ret = pm_runtime_get_sync(adev_to_drm(adev)->dev);
> @@ -2988,7 +2988,7 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	err = kstrtoint(buf, 10, &value);
> @@ -3128,7 +3128,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_generic(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
> @@ -3209,7 +3209,7 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct device *dev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	if (amdgpu_sriov_vf(adev))
> @@ -3663,7 +3663,7 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	ret = pm_runtime_get_sync(adev->dev);
> @@ -3747,7 +3747,7 @@ amdgpu_distribute_custom_od_settings(struct amdgpu_device *adev,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	ret = parse_input_od_command_lines(in_buf,
> @@ -4626,7 +4626,7 @@ static int amdgpu_debugfs_pm_info_show(struct seq_file *m, void *unused)
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	r = pm_runtime_get_sync(dev->dev);
> @@ -4671,7 +4671,7 @@ static ssize_t amdgpu_pm_prv_buffer_read(struct file *f, char __user *buf,
>   
>   	if (amdgpu_in_reset(adev))
>   		return -EPERM;
> -	if (adev->in_suspend && !adev->in_runpm)
> +	if (adev->in_suspend || adev->in_runpm)
>   		return -EPERM;
>   
>   	ret = amdgpu_dpm_get_smu_prv_buf_details(adev, &smu_prv_buf, &smu_prv_buf_size);
-- 
Hamza


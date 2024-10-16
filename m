Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7119D2F7C0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Oct 2024 21:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A8C410E04B;
	Wed, 16 Oct 2024 21:05:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lM2XLLmE";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B817410E04B
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Oct 2024 21:05:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SQOJn6ne4pScs9sMc2d+TOIQpT7xeXghEStnA142QBoRSwzsUItnJm3qRTkSd5qk9rRFR1q9mCOP3/LmeOm6nnb1rokff0G15RzJo0tjL0WSBsnypVn+q13+50WhT63ARFytf2oFsWm0pwfp/1pv1XU1JZHK8Xfr6OXiMzG9eqNK33tFCfMIef0jvY6ZW46klXwR1cafoSyOAfKLON0It1i3553Y6k/jSF0Ldu/3FvBw0tr6lIjQAb0VyRad4Nlppy9wi0j9Ql0Iidc+ixSp8foR7fIQxaYp2vYzNGlTfFfa2I3PnCI3C8v8mlgFjO5Ew71PaqOP8auPo7U5PQ7bTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNrl6qJA2Yx8QsePFI4+HBKjxYHfv0sL3Otk+dQM8WE=;
 b=SRQwj5bj+dZZ8h0QbI+zx+E31zsG1QUh1StiG6/5M+nqzDU+XstJSR/0RUq+lFICNMTiYZiEldeWphFPeOav9HkSeJTHCojWa4xI8LTc6V2g8z8jJ6WE910LdrNfsHXLhmv4CA9X1QCJsye/KvXBR9GgFrGZ60Vg5aT+cSEQdQ6mhe+mkJBrob2jt1QEa3XnSwpurrP5OPzLcYsWjEeRlXXVV0XbAHmYFLcrGp5EE17GUNDbtp0W1c+9o+esu/v/Lw5lb4IZ/HozvJn299kJaM7WsdbZwBEfPDLfTX0rWo7jS01kOUdqxLgy0NKNO53hvtDuWk22JP9CTsNJbXQJyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNrl6qJA2Yx8QsePFI4+HBKjxYHfv0sL3Otk+dQM8WE=;
 b=lM2XLLmED+NZLmBJ79/Q2Ki6ikku25w7bNSg6Q97/loZ/jhAfPlkL0WtQ5bAG54e0mqB+1pytYoN8SWuXIgAQceH5dq1ql2AYsPuEPAHOB5EKK2MykDQDofJmQqY1HQYGfH4DDfR+AE2YTomOV+YoIe9TlRXaOYz1qQJ/Y0zwRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8)
 by DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 21:05:17 +0000
Received: from MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::71a6:a9da:c464:fa2e]) by MW6PR12MB8733.namprd12.prod.outlook.com
 ([fe80::71a6:a9da:c464:fa2e%4]) with mapi id 15.20.8048.017; Wed, 16 Oct 2024
 21:05:17 +0000
Message-ID: <005fb572-7111-4a2e-85e1-3f8b2f1a361e@amd.com>
Date: Wed, 16 Oct 2024 15:05:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add debug option to disable idle
 optimizations
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: hamza.mahfooz@amd.com, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20241015174109.238518-1-aurabindo.pillai@amd.com>
Content-Language: en-US
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20241015174109.238518-1-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:408:10a::20) To MW6PR12MB8733.namprd12.prod.outlook.com
 (2603:10b6:303:24c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8733:EE_|DS0PR12MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: 252e2ab5-e1b7-4058-f27d-08dcee263c68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MzJsZnhuTDc1NEpUalpnYXhqQnpwb2doNi8xK0pCMUtvcGRod1FBRkMwSGJM?=
 =?utf-8?B?YmU5MFA3WW12WkVpQTBGTVd2dWtGYXNoeW5OTnRvdWxleVM2WHZicjhaa0hH?=
 =?utf-8?B?bGx0SmtldFpQL3o2UURGSGtwMVBidVAyaFhTLzVlTWdRZ3ZMYmlpMzIyWFgy?=
 =?utf-8?B?NGUxRFdOTTVGYVVqRThSbVdMa0MxZHlmcVE2UDh2RXFDcjZxMStmcWRQNFhv?=
 =?utf-8?B?NlNMMFpDV1JpWXk1SEVBY1N1QVFOb0VQaTdCdkZtamRYR0dGU0ZvNnppSGV5?=
 =?utf-8?B?ZmVvLzBaWWlFZXkyQkpJZk53dnhNS21yZE5XdWRFK28zbUQ2OEs3SUd3UUhO?=
 =?utf-8?B?ZXlWK0RWbXBFcDUxa3I2RTArTXBZbnorNzlKbHhFMmpJUGNjNHNwUWczbHJq?=
 =?utf-8?B?SENKcUYrZTNWZko4dTB3U24yZzhoQ21kcFIrdUloWTVhVldLK1B3ektmTi9U?=
 =?utf-8?B?bUVCQUxxbWkwU3U5ZXpsdWpvMngyc2tRcUN0aURoSE53WitHU05SUUVKVFdJ?=
 =?utf-8?B?RGVnT0VYMWdFOElHYVBrQi9veG5QL3o1YUNTKzhQcWQ2dnludXc5MDJjZlJH?=
 =?utf-8?B?MjczSFBpWXJHNmhFQzFrbmF3QWxvZy9zcm9sNWRkWVBKZHFPNG9JRDZTR1JE?=
 =?utf-8?B?RXdUTGRxU3RnRldnMmUxTUFOc29qUHZlYzI1VUZDZ3NKb0FXK1M1WkZ6WWwy?=
 =?utf-8?B?N2hqem0wYzdSR1BIL0lFTTlTRGkyMGVHSDVCZFRhZW8remtqWUZDOUhlbElj?=
 =?utf-8?B?WURxS3h3SEEyU3R2NjhIREFpSlB3aUtTZTVvUkNZM0l6STRNeFhNQWN5bDlv?=
 =?utf-8?B?UytNUW42WGVQQ2hpZC9aT3Y5eG1tN3AvcDJibUdFQTBuc2k1RUd6N1hUVThJ?=
 =?utf-8?B?NEk1WGdFSkdtd2tSR1h1djlMb0R5VUc4U0IxQmtGcCs3TzBCWW5UcndGcEpB?=
 =?utf-8?B?SlZPTG8rZ3h4Vzk4SWNDcFo4eWJuaTRWYlFuU3hjMkhnc0pmSGxYUXk3QTI0?=
 =?utf-8?B?cG1jNDcrRldudCsyR1R2YlFzVmwvN2JLUzFGK1pleXlQOTNMMDB3cnhibCtH?=
 =?utf-8?B?ZVJUZFdxNi96b3B4UEhub2F4RVIwMHAvOXpsT1BYV21oR3QvWTUxaDhiNmJw?=
 =?utf-8?B?MjZqY21TR0cyc1BXN25kNDJlMXozNG5pS2Rhc2tPbVR1eGtuRGkrOEloUUxm?=
 =?utf-8?B?Y2d1MExUZTBvdjZTVEFkTUpmQW5TdHRYeDlWdXpDRkZHMTJoY0o0NjMydzQv?=
 =?utf-8?B?SVBBWlcwR1pRaVZvV0x0U1RsREZyT3QrWW9rRGd5MnlKbThzTUVpSjRTNzhh?=
 =?utf-8?B?c3l1QXZNYTc4Q3pBRis5ZE1hM2ErZlpmaVNlTmFtQVJZdmR1ZUt5NGxFZ1Bi?=
 =?utf-8?B?RENSd1NocEpZL010K1BsaGZhbUZKMS90UDU0TkI2SGFxdzVJalZhYjBOOHNC?=
 =?utf-8?B?NHozOXNDemdrbUxyNDQ4d2FzZmhGOXkxOGhhT0VhSmVNTFpobC85VXY1VVUx?=
 =?utf-8?B?dEZoMXlZSm1FeDNBc2RDTFpmdi80THpCS0s5S2hBWnRJRjNzcHdxRjRnV3k3?=
 =?utf-8?B?RE44MkVTN0VhOG95TGdQWDBhQ2tQU2MzQ2FJa1pTM2lSOXI5Y2diWmUwNEtU?=
 =?utf-8?B?V28xNTBoT0pEUnNtU1pVTy8wTXZVQndLMC94ZktlcUptZ080bWdZY3gyUjJa?=
 =?utf-8?B?L1lzUVJwdWlvS3hxYnZaRy9Na1JDQ0lXQ3E0WDVxRjNPU1ZRRk5iMVovcHVj?=
 =?utf-8?Q?7bJ3oLdhC8qeGT5vdM6rwr9J4AiSek7ZKCeUeBP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8733.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUNpUTBYdGpNVkNQc0pkYmdFQWtYZG53c29DNjBuTTd1VnJnS3J0cVBNMW1J?=
 =?utf-8?B?WWtpSXRQTkVOUGFpN0IvQm42VVQ1T3VIV2l5eTZVNlJ5Y1dLSi9OOGJpSXp2?=
 =?utf-8?B?aTJVYmk0cXBhcE82ZGJ1RkMvY2I1a1dLd3Ewcy9ZYVhBUk5DK0hZQTF1Z2o2?=
 =?utf-8?B?NCtmRlJnVUwwNWlXS0JiQk1wVTNZbDFOZnVrR2lwZDBQMFJKYnpQcUoxV0Ex?=
 =?utf-8?B?T1VGb1lQQlZqaVh3aVFyekp5aDA0Z29QL1RJNmYvQis3elhEdHg1eWlncjVj?=
 =?utf-8?B?UVA4dlNtVThIMXdsK0RhTThZZ3VHdmF5ZlZWZW9uWjVBWXZrV0NFSzJRdThR?=
 =?utf-8?B?azJRYnROUlk1OXRRanB0NzlnR1lxeHBMblVpSFdOeUR1Tk9IN0Y3YWVJOG1w?=
 =?utf-8?B?bSt4aFpVcVU0eTNpWDc5aUtHSXcvdVIya3N6MTQrWXJTRXBMaThWRWRFZGc1?=
 =?utf-8?B?cW9LeUplRUV5QkxUaXJEYXpVL2dMWCt2WlpZdTMvUVFlUjc0Z2ZoTkkvcjNE?=
 =?utf-8?B?WDRlaUxGV0J1OWtOOFo5Qm9sbHlKZDJSTU9XQ0RHWFVYT0hKcGJVRmVjaC9I?=
 =?utf-8?B?VUZCeHlFNHI3VUJQUlArTUFqdGVDbEFHVytBb0JPTTdabXc4bGVaeGtDVXVx?=
 =?utf-8?B?dExOM1d4aUVzRVN1aXVPb3d0dlpEamEzK3FsdzdYV3ArYUxpMnJmZExoQjNr?=
 =?utf-8?B?bWgrTzRVb0hpUWoyMjJoTFVnMVVCazNja0IxT3VzYmdaOUE5TnR6aklJSkhT?=
 =?utf-8?B?S1pVM21udnArUkx1TW94NS9ETmZIQzZoSS9jVHlBNnlvSWZLbHprczE1V2dC?=
 =?utf-8?B?K1RCNmY3QkFhT3c1bTd0SHpnYi90ZHdGQ2kyTjdqSGxRNWY1TVVRMmViTGw2?=
 =?utf-8?B?QjErOTNuclFxVENmb3NTTzR6R3lHTlI0UndBMms2YjAwOXorWUF2YnZoVFUx?=
 =?utf-8?B?NzkrYWtqdTMwSFJOWmdmVmVMcU1TbWdrcnQ4LzBBUVp0b3BQK1FDajZtYjJw?=
 =?utf-8?B?bS9oR3BldHpQSWZVNzdWQXVIWVhPWStBZlUwQ0szMkR4SjM1dU9wdDQyQjhv?=
 =?utf-8?B?Z3p0d0JubUNUZ3c4cjd6M0NrdmR6aGM1UERqdWlWOHUyV3ljUC9VM2JzQisw?=
 =?utf-8?B?SEhaVk5zUld1YUlhWXF4N2ZOeklQWFZrMDNXZXFaOXpjdTZUTXRBSVVDMEow?=
 =?utf-8?B?RGdGenFiRHBMVkM1OGl2dTFoVTcwNm5SSk82enQwL04rN3Zwc3Y0VnJoOU1V?=
 =?utf-8?B?K1JxbFpZMjR2Zjk0QW1Db0k3U2dWVmJIbk9qK0tuOVcrOUM0L2lNRzg3NGNF?=
 =?utf-8?B?ZXhUUFRRaER1aEtHWFBld3ZoT1BxVE8vVjBJUTdPZnBFMmZXSHAwSEVWMG9s?=
 =?utf-8?B?THBuaXJ0aHJnd3lmb2RBQ21BNFIxQW1BZ0tPc3Q2NWpSazBMWkdNSnVoVEFX?=
 =?utf-8?B?SWhmUktVQWV3Q2VHbXVJVXpja3RLdUQ1cmdvbFdtSTZlUVpZZmhmZG1nUklo?=
 =?utf-8?B?RVl4MXJteFExblJqZk10ZVRHcG45dklKaXZoNjFMMmRZdFo0ZW1oQm4yS05n?=
 =?utf-8?B?M01ZQ2p4RFpFZllzZEhSWXFqa25BOFZtZGRhakdsNkpXR0QvOXI2RWcvNWNt?=
 =?utf-8?B?VzR3ZjkxTTVEM3d1ZDF4N1lPUG9MM0N1RjZJYmc5NWhEUmNpTk1WYXpRUkJ0?=
 =?utf-8?B?cS9HOVZoSUYybU13RDJ6bWZpU2pLS2R1dWJwTis0WWxFZnlwKzBldVh6MFNz?=
 =?utf-8?B?cE42aFNQOHowdVRYbWxvNyttQkNudVlROVZzbU5UMk13VStMalFiV29LcGhv?=
 =?utf-8?B?cFRDdVlOdHBXZCtJZnUyNC9Ra1NGbWE5Mk5qaEcwaWFJYmZBaUFUdEtPbUht?=
 =?utf-8?B?ZzdEMVdYdk9KOThxOE5JUUVXR29RYWd2Sk82cXBYbVVpNzFJRzRoRmdNMnpI?=
 =?utf-8?B?VUhyUmxhZ05NSERwQTd4Uk1ZN0tqMWR0SlRpWmsxYWVFcWdDaytTMzA2eWlF?=
 =?utf-8?B?MmZCOGRFb3ZmZnVLeTRQbFQxSlhQdlppZDlnTXdmczgvUXJsd01qRXVsbWZB?=
 =?utf-8?B?dGs3cWVTdjA0bVNOV1RXQjluTEQySjBPN2ZwcFR4MGltN1QxbEltdnFBdXZ6?=
 =?utf-8?Q?sCdYA2e140H3THdj7fOJ1fVuf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252e2ab5-e1b7-4058-f27d-08dcee263c68
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 21:05:17.0900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNrKOT/2hZdY4WIxQkFpXrh9Ls/rjYdTGVUYm46HsZwcIzPBKRWnLVPif+bdBg3dPEGs0nI1kfTxmEBklLc7nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9038
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



On 10/15/24 11:41 AM, Aurabindo Pillai wrote:
> For debugging purposes, add a runtime override to disable display scanout
> from MALL cache (MALL Static Screen) by disallowing the driver from
> triggering the idle power optimizations when desktop is idle.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
>   drivers/gpu/drm/amd/include/amd_shared.h          | 5 +++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index c5487bb7c6b8..bb0e9deebcc5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2012,6 +2012,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   		adev->dm.dc->debug.using_dml21 = true;
>   	}
>   
> +	if (amdgpu_dc_debug_mask & DC_DISABLE_IDLE_POWER_OPTIMIZATIONS) {
> +		adev->dm.dc->debug.disable_idle_power_optimizations = true;
> +	}

Drop the braces around the single statement, with that change:

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

> +
>   	adev->dm.dc->debug.visual_confirm = amdgpu_dc_visual_confirm;
>   
>   	/* TODO: Remove after DP2 receiver gets proper support of Cable ID feature */
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 7eefcb0f5070..fba3f2f1327e 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -344,6 +344,11 @@ enum DC_DEBUG_MASK {
>   	 * eDP display from ACPI _DDC method.
>   	 */
>   	DC_DISABLE_ACPI_EDID = 0x8000,
> +	/**
> +	 * @DC_DISABLE_IDLE_POWER_OPTIMISATION: Disables certain power
> +	 * optimizations when desktop is in idle state
> +	 */
> +	DC_DISABLE_IDLE_POWER_OPTIMIZATIONS = 0x10000,
>   };
>   
>   enum amd_dpm_forced_level;


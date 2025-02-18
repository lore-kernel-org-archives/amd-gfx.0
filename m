Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9675DC021AA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 16:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 461C910E3EA;
	Tue, 18 Feb 2025 16:05:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yQF/JL6D";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D45110E3E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 16:05:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5DaXd+7H7y2XOZ4hijVwyewaJf4debTvFirFa5Z5VL0o1kNfY4lfkhpLy4q8AsOG0f1QwnqepxscHlMn7Rhgc4d8qecI40o/wNuwvc6QFmTPNq2ebMXqDQjz0lgGFYKQSHcszNFU59HEx1n5oadNVLkpoE/b/9yyx4PNZh7QKY35aYepEuViSJyldEcJDq1BTE+uGwISMvJxjMMDBrJnAzWzmt08Jfvb4vKmEn6VTonvZbyYtEX+rzj09SC2VBRnZ1TfOh+qQlY263AsntbLi3F1VDNo0oycDQeMnqJJnwsyCU+nI454Fwg1jPS2aju5AU/7rBAm+EU/9dwOLEcRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQSZce+1LNT94wkvDhEA7FtREmbOdApwnyvttl+EFnc=;
 b=tKKyE566jOeSigFHwDGtmtqyeC7HpWoe+Dvn6hbgmGJZGkpoQgtgYlggNxXn5IxNTbQHNJwbSkPQHc6AasoYSch7uRDTVyVUcSTLTXv69+ru2lji+MoS826nY4BMQP0Xo0WFRvnVmuNQ5utAhNQ9A3G4SKKv3YA5BUD1PYnTm/TjKDUr1de8KVg0kHxFdisXvkGOYoQe3A0jysaCKSvwbjzgdJGO4USbybaTuNKQ9xpBV446EI0NT2HKJ1AcwhkFv3DZORxuKmtu7opNMVzrGvmASKJ+R2nIncH5mC5PxPiXqfxlHS04wCfRO7cCF3vNHxlfO28wpsP2o4L5E795NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQSZce+1LNT94wkvDhEA7FtREmbOdApwnyvttl+EFnc=;
 b=yQF/JL6D+eK3Yluly3OrgDOklApGnTdECZYcmEoh7ZDUyJ7YCS1vowV7w/GEPtML0Xj25TpGycxA3zSULdcum1CfC2kvircln+txqLWAUBUTrc5vm/xBq4AcS0/yFd/kDPjuEk/jxQDzIuY/Y9mam21/f3Ws+KYQLl/4qe40lMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.20; Tue, 18 Feb 2025 16:05:53 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 16:05:53 +0000
Message-ID: <c3626b4c-ce7e-494d-8c56-6d55869524b2@amd.com>
Date: Tue, 18 Feb 2025 21:35:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: disable BAR resize on Dell G5 SE
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250218150829.2710795-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250218150829.2710795-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::10) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM6PR12MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cbb5e9c-0d31-485b-3a97-08dd50361e7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YW9UcDE3NEJnMzZ5L1ZMSGtsZm81RnBLcCtIYnc4ODZTQi9iVDl2Z25TN1Zh?=
 =?utf-8?B?T3dEMTE2RCtydW5JaDdUQlFIcWJ1SmFpNHFiYjZ2MDlyVzlqNXBKbkV3djJB?=
 =?utf-8?B?YVdoeEttb25hZk96NmwxSFA0K0NBNHFldUZ5K2QrcDN0RmxuditsUWttU1pL?=
 =?utf-8?B?RFdQenQ4UmJrcmlFUzNlMkRQRDBIdDJjTVVjclRieG1HK3RIZGMrbkZtWHE3?=
 =?utf-8?B?T1VUeDVaSUhqYnF6Z0NSMGJHNDE0VUZNcGJTUVorRm9sU3RJa0RUcHZHRTAz?=
 =?utf-8?B?TVRuWnVIT01oY2x0OFpiT1VCM1d6dEZuM1p2ZTc4SUhrT3k2eGRZdktoaEdn?=
 =?utf-8?B?cllXMjJCd3VyUGZIT3NyNm4wb2l2djg0M045UlhpNUo1UWhaSDR4djBveGRR?=
 =?utf-8?B?OFdFbm9Vc1poZktLUG9ocVBaTXJ5YUc1c1ZpYjBNMlV1bGg5dmI5WVNFRTc3?=
 =?utf-8?B?dnZROVJGQ29lbk1FUUpKNWhtSmlCd0hZbmFHbzZ3MllRdldzTFlWMlliZ3ZJ?=
 =?utf-8?B?aFBmQ2YxbGxOcmcvbkNjQXV3Qm9OYWlaWkhTMmhlK3V5VDJ0NXZ1bjE3QmVM?=
 =?utf-8?B?SkNsSHhVQ1MzM1VNaTdUcHUrUkFIc0tJQWxwUTlja2VacXBiRnVKcWRKSHRL?=
 =?utf-8?B?bC9acTdmWnIzWGp2NENoaVYwSGx3R3YwNzRzcVlmNXlqMEp6UXlKcmtHajNv?=
 =?utf-8?B?dDA0aCtyR2daN3JiYUQzSXQ0SnI0RUdmN3VmeG9hcHd3bGVFbm0xNDBYNFJp?=
 =?utf-8?B?Q2hwRmljNkJJKzdvcEhkbXZ5ZmY4WEc0dWZlVEdURTN3ZjhGdVJLeitwZWxl?=
 =?utf-8?B?TmhCU2VDSW80ckEzbE9BU3U1MWkxUzljdW95cjBFTGtZZHlienpMQ05uMTl2?=
 =?utf-8?B?MXVDbys4aVMza2IxWXRwSURHKzhocFhsTVdhQmZzbnlHV2R5bm9rYlpiSHoz?=
 =?utf-8?B?c0ZmSXFueE9hNUFWSEp3VFovZjJNY091d2g5b0haNzN2enhFaUcxZWZ5Uk9t?=
 =?utf-8?B?czV5U0FxS2ZzZ1lZenA0TVBpQ3lwSE4wazVUc25TbEFxbHM2M0tIQVUralJa?=
 =?utf-8?B?eXU3cU1hVjNTYUlRYi9qQWw5d3h3alJyNlNHMUdsVnZvU2VxLzlDQXpHc3Nn?=
 =?utf-8?B?eG52ek0vYnY1aGc2aUNVNW9RNUFvUEFzTVdVN1BzRitSdnNyb212NmtvN2M3?=
 =?utf-8?B?ODBTaXViaHlVMDcxVkFVZnpLendYWVNGcGI3TU9PZmNvNXhLSjg4K2k2Nkkw?=
 =?utf-8?B?Unc2OHAraWpFTEhXd3JSc3VFRG9tVDF5ZXBSTHRldXhtS21Zb2ptY1VrcGQ2?=
 =?utf-8?B?SUlCNGVoYUIzOEV5NjZia1QrZ2NWWHF0OFFsL295VE53WEd6eFRRTnVYeFpu?=
 =?utf-8?B?MVZ0VDhXZXAySHZOTUhGVWhGU3RhUVNvY0JhZU13dm16T1RlSjRONzlEdkJi?=
 =?utf-8?B?RldxeloyMmNFRER0U1BHNjgyNEZibVZyT3pBb2FRcmh6QXdCY2Fjc2NVdTF1?=
 =?utf-8?B?U1RrbG5JRUhFTHI2TFM4cGk1dnA3T2tPNHdTcU9pRWpzc25KaVhKY3dGeUFm?=
 =?utf-8?B?MVRBQm13cUZpVzdCTExoNXhrZWZXMWxRbVRIWGcrWnFuT1ozYkNBZE80U3BI?=
 =?utf-8?B?ZUQ0Qm00enFWcGtRNFpUVWxFSkxIMGRxYU9vUEFqUitkUXJNWnFDaFhlWEVL?=
 =?utf-8?B?S1A5Ymh4aTBDeU4rWHNHZUVvQzdEZ1JrR0xHVDF5U0VTS0d6NmRTOU84bzJY?=
 =?utf-8?B?MTZvVmUvb1E0Wm5HamxIYzQ3U0FpWXNra2pabmtxVzRLWVJrSXV6bWdrcnRD?=
 =?utf-8?B?Ni9hTVNzd0EwVGMrY0hqdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0x3Tk56SG5tbHBsSC80V21WREYzd1hPdklnejNCYTdFNWZVQlgyYkxpV3hr?=
 =?utf-8?B?ZmhUR1QyRElsVmZJVFB4NE9kWFpsRTFwOFRuNUtBNFU2VFkvcXJleUZydEVi?=
 =?utf-8?B?OVVXTlVkR01TbU1hNzQzczBTYm1XZU96TUtIeHQ2Uy9GQVFyd00rL1BXUDQr?=
 =?utf-8?B?WEc5LysvczZzb01vYUs2RFhmaDEzZ1pRRkhLaXRKckdTek91czZBZjF3ckJa?=
 =?utf-8?B?am5wMU8xUnczcitBRjZGWmRlQkNhMms0SEMxcnhrZ2RsN3ZQT1lkRHZKcy9C?=
 =?utf-8?B?TFhoTzVoSWw1a1poMTMyOFRGL05tZjErMnBpakxnOW5jUGd6MHAzbnZ4Q0ty?=
 =?utf-8?B?N3dXZndWKzlhb3BXY0w3VjlYRmFiZVRzNXhIaG1PVDJ2YjFBbFdzRnEzL2Ra?=
 =?utf-8?B?YXBQaGcrYmZsZWt1WWlua1owY29XeWlPNjA1N1ZxNEoyR2NLcXpBWXgrWEk0?=
 =?utf-8?B?QlNwODBkVmpXRGtWUXk4c2JkZDZodEc5YlJwNXRBaFl5cVFxcnM1em1zek5G?=
 =?utf-8?B?NkU5NHNuTUNNMXUyWDZCK0NKTHBRdWRCQVpzYklDYWxHL2lPQno4ZDhDckUx?=
 =?utf-8?B?d2JtSWNYb2JkMjVQM0Nha2dseURpcW04TWVoZkVFVUpuOXFoVjFodEdPV2Nl?=
 =?utf-8?B?d0swYVlFSm14VHZwUnp3ZncrcHJ1UDNCOXE5MzFPK0szeVNzaXVKUEJPa0RM?=
 =?utf-8?B?VVVmNngvQzA5eHZhbzNKZmR0MWdLYUdzTVMzYlNHSVByVm1Dd1Fiek5RSGU3?=
 =?utf-8?B?QWRjM3pCL1RKWUdVOGFGYlkyWkRBdnFGd3BQNmdVZ3VLRUdnVXh5UVZ6Y2dw?=
 =?utf-8?B?aFJNSWdNek1rOXUzbVEzOG9XRDRPU1JzL3lRMll3cTNWSHUyVlZEM2JzRnQ0?=
 =?utf-8?B?cWg5U0IrTGhKOFRhejErdnorbmsvemNnWWt1OWMzNU4wUlV3UnNHbWNITWpr?=
 =?utf-8?B?Mko0eVJiQXF0ZDBOSldkMlUxSC9CcEdzQmxNMjhqT1J3dStKa1FKWWVxTG5y?=
 =?utf-8?B?WEcxOXFDK0crd2p3QnpDT1NKdGRKYnJPRFRCS1hDcEMrTzRrWXpPRjlGblcr?=
 =?utf-8?B?Qnp3ZGlKYkx4NnVvdmwvaFc2OCsrbnRNNURRcGUrTDVpUXhJS0VzVG9hZno0?=
 =?utf-8?B?NkZiUnoxT01HUzN5eUJzZDdRV2dnNE9tWE00NVRJb1ZkRHRVUTUwSStsN1pI?=
 =?utf-8?B?V0ltUHNvbDJMdHJETEJxYkpiQkJGck45ejZqZkZFUkEvaWF5eDY0MlBUUzhQ?=
 =?utf-8?B?NGRuME44c3ZNeWFyRFg5RTg4MzlYTkpqVDZNS1FrVkt1NFpWQ3QwUjRHRG1t?=
 =?utf-8?B?dHRmdm5tUzFMOENKeW9WbE5wZlpZVDhOYW52UU5zak5pVERvZ2dXYUJob1p5?=
 =?utf-8?B?ZUIzbVBrcGcrRmpZYW5obmErYlh1WmpISGxTK2cyZXUvN3lyVmU1UDlzdXVE?=
 =?utf-8?B?VVZmb3lUZG4vb0h0TVVHM2R1d3pRbnFqOTA3U2RvdEs0cEVZTFdURmVIeEVz?=
 =?utf-8?B?ZDlOWE1UV043ekM2TE9BTWwwdHBlNHhJVWNuKzFpVHJ2NnFZODk4cHNjTjM0?=
 =?utf-8?B?ZjVUTkhISkhQTFJWeEluekcvSjk0RmhEczJ1WTVTRUFxeWNHeFNva2xWTEVa?=
 =?utf-8?B?N25ta2tHNFRabDE5elg4cWt1YVNnbElvdXBxWm1oc01IakF6d2NxTG82KzYv?=
 =?utf-8?B?aUFwN2g4M29oWlVHZU9FUWwrTVZvZDg5cHBXYmtOYm96Q1V6SkxNaFB0U21M?=
 =?utf-8?B?WkhjODMvQnBqWm1qTFZJMG80L3d1TjNwSW9ETU5VV1VRcHNwdHdGN1lIVE02?=
 =?utf-8?B?YitaclV2K0R4NnBSbnRwNmtrSzhYNXQyTi9odGdNK2FUNTV6cU4zMzFXbEtl?=
 =?utf-8?B?MUlmMG5GaGM2d2IxdnRxMXpXdW9MNUIxMHZoRndQV05oeFZlU2ZzQTlPbnpT?=
 =?utf-8?B?OGVOVGpaZTl0K0ZZRkZqa2tuOTZPeitTTE5ld1dxTmxHOE5rb1hsMjAvMEth?=
 =?utf-8?B?Vm1TQlE0dWxrUVNhc2N4ZWR5ZFFzNE5IWkVGWldUMDhZa1J6VmIvM05BMGJQ?=
 =?utf-8?B?UjFVdXRKVktMWDdPWkp6TTV1RlZGNml6YW4wSFpvL0JQNVdrc3drbk9BMXI5?=
 =?utf-8?Q?o77TL/5jnXBf7W9RxFjncbPtz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbb5e9c-0d31-485b-3a97-08dd50361e7a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 16:05:53.0121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xqsh/vKxwJS4tPyX8S+MMTn0htVMuKHbRxhjA2abOwJy4d9/8ShaoqLcuJE3DNSq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
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



On 2/18/2025 8:38 PM, Alex Deucher wrote:
> There was a quirk added to add a workaround for a Sapphire
> RX 5600 XT Pulse that didn't allow BAR resizing.  However,
> the quirk casused a regression on Dell laptops using those
> chips, rather than narrowing the scope of the resizing
> quirk, add a quirk to prevent amdgpu from resizing the BAR
> on those Dell platforms.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707
> Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 XT Pulse")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

As per the issue thread, issue happens when dGPU resumes from runpm. If
so, can't we disable runpm as the workaround (IMO, the current patch
also is a workaround)?

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 512e642477a7e..56fd874a22de8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1662,6 +1662,12 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>  	if (amdgpu_sriov_vf(adev))
>  		return 0;
>  
> +	/* skip resizing on Dell G5 SE platforms */
> +	if (adev->pdev->vendor == PCI_VENDOR_ID_ATI &&
> +	    adev->pdev->device == 0x731f &&
> +	    adev->pdev->subsystem_vendor == PCI_VENDOR_ID_DELL)
> +		return 0;
> +
>  	/* PCI_EXT_CAP_ID_VNDR extended capability is located at 0x100 */
>  	if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_VNDR))
>  		DRM_WARN("System can't access extended configuration space, please check!!\n");


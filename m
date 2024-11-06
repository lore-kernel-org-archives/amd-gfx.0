Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB583D59F75
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Nov 2024 21:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84AB410E77A;
	Wed,  6 Nov 2024 21:50:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jAxX5gFW";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB6E010E0F0
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Nov 2024 21:50:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exCHroG8jtm5uwoMGo4riQrvDMrIvN53a0sUbLXJ1IOJKvOKTGosWmQ3qcXXnIeHPV/8j1qHjIKxrz6quMF0tpBmryvFyjSNhzhDtW/Y3qp5yueJ4+r9393Hn7lYjQo8zMOnp5L/99hmNfBaDkGIKWTpSCmdAO2VxzLxdegH1bMwkSJ83kDlxEFT7JvNZE3yiABQw55zO6pnd4Nd/naBaeuABN72ISkayQ8tnAGOjrVz7s3uwBOHccOsQ9djgfzaA+3pdG8HNsREYRkblTTFqJIMiIAWisTCiTOd4nULCU0jStB/njq/fLAndRWWmJJfTQNYj6KzhsWPZSReRtPPhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9HhV7g30yJFI4etRiui4bvq7zFBqgE0RuuyXvzVN/Y=;
 b=TwBFGpKM/KmTpT4zfKLAUG3e71lGabSMxvf3b61Cy92eZqSlaURuwVDFXLmHr4m0wHF960zJ5IUUcggunEa7SpQvcEBD77TBRD5uyETZgZy+I/lRd+9nfTgZRF4FWCUkV/ce4t1uBehb0Hi2yQiKy6DHmFnkksLUm8w/Wj0OOpzWDBaTWE6BUSOSVLHtKPzBQOaQimuxtr+9v9IIgqBlCVy0r0rx9ihrfj+KBZVps3fFPXYQzbJNkk7NMz3N5IL9yilQiso5uJJyeIwzg0bDEkah/jo8+p2O/2zSP1B4+lKDntzI9Qa+wthnqzjp7u/r9deT9l77ANb4qeX+jLto0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9HhV7g30yJFI4etRiui4bvq7zFBqgE0RuuyXvzVN/Y=;
 b=jAxX5gFWbNBDI1Bu2FJkHhUp5kDvT06+6D+4qgQ7w2KRheDRlNPXxAQ3JFXS43FO8gVp/pD3n4L5GYuDJ6PaeVjL8LGRMfoedP3kKQxyAPV7D1mcOg0kwm30kSeLKjYpVYeI4CiOxSlfb8J+AXYl82Os9vu7XA4onhTlWG76ljk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB8919.namprd12.prod.outlook.com (2603:10b6:806:38e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 21:50:19 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9269:317f:e85:cf81%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 21:50:18 +0000
Message-ID: <ca008978-ce04-43df-855c-aea2aab320c8@amd.com>
Date: Wed, 6 Nov 2024 16:50:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Inform if PCIe based P2P links are not
 available
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241106011942.319058-1-Ramesh.Errabolu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20241106011942.319058-1-Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA1PR12MB8919:EE_
X-MS-Office365-Filtering-Correlation-Id: 61816e0c-f0b9-4ee9-1c79-08dcfead017a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3dsREpsUUZpSGQwNWcvbjBDS3BrSU90SkxSL0hBQ2FCVEFWOTVRMnhmbnBO?=
 =?utf-8?B?SFNlUWIyMFJaenRueEYzY0NPZEovY0NtWlVFdFRJVWoyMFhVVWkwam1TVDRC?=
 =?utf-8?B?aHNFNkpaMTJUUGFFd2NJdkhJMEl3dFROU0FnL2cxRVZtKzZ5bkxZTmxjUXNk?=
 =?utf-8?B?NDFZbkpvejk2NkFQMjQrUFpYOHl0MmV1V3pSQ3drd1JMdmlOTlhhM2x2Y1lz?=
 =?utf-8?B?cks2YkFpL1JlNUx2L3YyK3lmNFgyRzNDRjUzcDczajI1MERISGdHbHlWY1NT?=
 =?utf-8?B?NXF4Znh3ZVd4YnF4bU1TM2U1ME03OUZOb2R4d09qRzAveitIclcwT2JoVmN2?=
 =?utf-8?B?M0VJN1dMV3J1Q2V6eGZhRTJWK2s0TkpWSzQrZFFHaXE3UEwwTVNic08zMmtp?=
 =?utf-8?B?T0hjRzlxSHdRenI4bGhLczFodjdWQWd0TFJJWk5TcjlOSHlINDA3SUltRk81?=
 =?utf-8?B?VlRaSnpIUGRJaEZhTUtLL2tXWDc5NWpNc210U0xhNXlLZHBnUlFjK1NHSDBT?=
 =?utf-8?B?SExFR2lpbDVyV2F6KytKNmN3TTRNbkNHbWZsWkEzaXYzWkVvTGZHVTBGSDh3?=
 =?utf-8?B?Uks1M0lZcTNoRU9pUnAwS3ZCTVpBaE1XdGZSb3p6c0pHcVJ4U0s3SzNUbnNs?=
 =?utf-8?B?dXR1ekZjcTNhcmFpT1VxQUxPaEcxTWMvalA3VTRJM0tTSnVjUGVPK0I3SnVs?=
 =?utf-8?B?Z1hoTzRUQ3NycS9ZeXZVcXBFZE0zbEFxSm5GeWxKVDdER0hkTVoyTXlUbE1v?=
 =?utf-8?B?WlNqUGpsQ3FuWGpwOHRqUFB0b0gyejVyeHlNWXVkR2ZQVXBpSUd2bGVCdWJT?=
 =?utf-8?B?Q3pvZlFvNEkyKzM2WEgrTUlxZTFBYnNjaDQzaHVXOWFQdFl6NkNhUktTeEI5?=
 =?utf-8?B?T00rUjduaUNSVTBNa1hGTHFYQzk5MTdaT3JaQnhmVzdoN3dNNWVDRktPQ25B?=
 =?utf-8?B?ZE9nQzFPenlaWWQ1YVNzRlBXZ3V0Zkw1TUdkR00xWGdXYlQ2elVlUkVRcXQ0?=
 =?utf-8?B?UGFxUjhUVUNBR2F5SnA1ZXkyMkNjUldYaXVKRFRJRDJvZ3lSVWIyam5vdys2?=
 =?utf-8?B?SDN3ODN0OEtOdThRNStneFNPVXJkTCtDbG1uMFJZNmtNRzJiZy9zNE9yRkg2?=
 =?utf-8?B?RUZMVHZnQ1dmbWROTlVjMHg1UEVoTXBjNnowQm5lUG1Wd3Fvc1ZOZVZBS3lT?=
 =?utf-8?B?bkhac2RrcmMxUFdwMHcxVjJKZld1VWNQTjlZT3BPaDUzdHR4ZEhOajh5SHhr?=
 =?utf-8?B?N00xSWlkRWEzaDV3WVU1Vm04cEZFMElISi8zOFcxTW92UmNrWEpqakNiOUN6?=
 =?utf-8?B?S083TkE3cnBZYUNLYnVxdnM3U1FYY00xcE1EZjJvbnNIeFJBT3FPblhGUVp3?=
 =?utf-8?B?SlUzTGlVTVg0ZnZlekk4L0xwSkFieGZ5aEFMeGxCeUZuMTg4Z0p1REdVZ3FC?=
 =?utf-8?B?Uk4rYmxjRTEvU1o2WUM0TGVuU1NmekJ2eVVZM2ZaL1EwRmRlYVoydHBEeGhO?=
 =?utf-8?B?ZzIxU29va3NXdXBLb3FINm9sRkdkK2NBWFcyR09CcTE4M1JyMUpQQTZ4VElZ?=
 =?utf-8?B?czlyWjBkajdaa2pScHptcXBQU3pScGptMzRDN2NLS200OE95RmtTVGVuQ25z?=
 =?utf-8?B?bEJOVGNTSS9IbHVLa0RPS3ZnV055Q29NVk8rNVNJSXhyNHVNMWdyZlBxbW5q?=
 =?utf-8?B?eVM2azNuNCtDVDBHdm9XVUhGL3dKazdJTkI2dVVxWVU2Q1NPYkV1S2F3dkJN?=
 =?utf-8?Q?OdZEwYTUPrXcWjgwYpwg/KWgdbNFo20wtYkFBIx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YytqTnhVakZvSFNlUFFRQ2NLa2Z2T1hBUEc5SU4yalAxRWJQMkxaUzI4TlJY?=
 =?utf-8?B?cE9XUUhjVUFlclhzWm9PaitRN1R3M0JMM2kxaFo0WDhSY2lCbUhjamUya3Ft?=
 =?utf-8?B?VDBodVdIUmRsbmV1aFdCdXF6dXhuaHVpYUpKc1ZrL3ordlhQRjBmVWNkdEZo?=
 =?utf-8?B?cGN2V1M2U0RibkRuVFpKOGI4N1BtVTZ2d0FubW1tclhUNG9hRGM5Ym0xMHNB?=
 =?utf-8?B?cnYraHRyRFJja2VseUtMQ2VDeTRQTUc4cURDWmlsVjdvUlVZUzFPVVRXZjJQ?=
 =?utf-8?B?UFpxa3JIdzkwVEJva0FpSnByNEVYL3o5aVhkOUZQcHYrTXF3b1hvV0N6WmVa?=
 =?utf-8?B?RjdqbUZMZFRRUzlBTHV5Uk9pMW9hRTE0b3pDbjZqcFllY0ZDLzl4T2JhUzVI?=
 =?utf-8?B?bVkxN3NkMHNDM2ZXaWpKRUtKZFg5bXZHdDhxUHJKRGJoZ1Y1d0lKdkhST0pR?=
 =?utf-8?B?MGwvYkRGOWJLbnVTN21KclM2R21Wcm0xdStoWGFITVhZbEVHcER5V3hhNy83?=
 =?utf-8?B?WkUzbXRKRnQ0SDMwamR5cGpGazRLZUppYVdRWTYxUWlWaXM0SE5TZEVOaGJG?=
 =?utf-8?B?eUpJd0M2SWp1bEhRMVRiTy9Tb1MveUkxc0xJUEtOZ3ZCNzJxSjEyTGljN1BN?=
 =?utf-8?B?cGlJOGtNanI4Nkh5S1B6Ry9oWEplT01pZHJTZDRwVUxSUlFtR09SbjF4K0pQ?=
 =?utf-8?B?bXRURnFTcjdnVVUzS0I3M3UrQ0ZnMC9HM2RuQm1aVFZ3TExIRHFiMkxJbitz?=
 =?utf-8?B?U2t0VjNJaEpiT2QxaEhROGtWTFJCaUhKZUhoMk5rT3lveElWYzU3MVhUWnpR?=
 =?utf-8?B?OVhvQVc0dWxBaitPUHVNaGdqNENPNi9IZURhL3ZPdm1vaURjVWZvRTZkT21m?=
 =?utf-8?B?MWdvVERlNnlWZm9DWFdXcVBDcnZYekJhUDlpM28vRUhvaGhBbzBhRSszQkZt?=
 =?utf-8?B?UnljQ280YmlydWpYZGZ0S3VROFRxT0lKQ3FaTXExTXJlUlRHOFJSaGV1Q00x?=
 =?utf-8?B?eThJREMvT05oTFcvN2pwQzNlbmtoQnV1YkpNWHhnamFrNC9nREtFeTRaaGVO?=
 =?utf-8?B?ekNxTHdlRVFic2tLckRDaWpMS3RhWGVMR1FNZkFVeVorRTl2eEcyNkFDNldZ?=
 =?utf-8?B?OFpPcjhUTUZ4M1I1SlBGU3N3eitvZXF4OHV0d2Jmbnc2cGlnRDRUVkMyVDV5?=
 =?utf-8?B?TVJtbFlZcUttaEpiWGdOS3FvaUxyUTdhVWErS2l2S0VYRUxyNExGUm5qczFK?=
 =?utf-8?B?MmhCUkRLeXFNU1FMaXAvQVNUemtEVk5DeEI2amRBUkhVbXR5b0tGZlhaeGNa?=
 =?utf-8?B?bFFiVEJKMTM3UUdDZEppbDg0NUpMSUlGMUdiakx0R3F4ckFqbFRnYXZyZFVR?=
 =?utf-8?B?Z1pjUHdYUE5JVnIxN1NMcGtpaUp0d2RPalRZMlJwL25yZ0VFNGxpL2pZcXJG?=
 =?utf-8?B?bmdKOURSS3lJRFhvK2YveE1Va3QwdEUxR3ltR3dlQm9iVmVDSmZsTHVRbnJj?=
 =?utf-8?B?eExKL2YySWNSbUl1SU43N3lXWmdON05CVk94ajVoajV3UkF4anJKZ2l1Ylo4?=
 =?utf-8?B?VXdEb1MzUVhWODBxSDRlN1lmMzRyRTJERDJPVVNzQlE3ZHZlVitKa2g1YndY?=
 =?utf-8?B?a0xUd3F2dWlDL09JL3E0bVRmaHIydHJtOC82cVRiNHZBZmsvWENGMzR2dnhH?=
 =?utf-8?B?UlpMaVNVSU9XUDFWNzZhb1ByMFVuSnZVOWVMUzh5Nm5VL2p6azVsMXFmaEIr?=
 =?utf-8?B?KzhlN0E0SVc0OXJGRCtaNmlSejBUOWR0RkdPUTdNRWJkVFhjWmlyT2FGVGFO?=
 =?utf-8?B?MUNNMXR0UzR4VlZabXByNk9VTE9FM0ZGc1FyMEZYVzlZaWdaS0dnd3BoMlJP?=
 =?utf-8?B?YVJKUFNJazJKMTV1L0duSXdqN3VXOFN0enRZUUV5UlZ6SXVrU0Jha0RzRE1D?=
 =?utf-8?B?UmwwK1lqMTVVbHN5YVV0VUJPeHdGTzVjUStncjJ1Wmd1d09xRnk3Qk15S01V?=
 =?utf-8?B?OVIraGd2dTJlYnFGK3dSa0tXbklBQXhpNTROQWl3VU1NU2JDaGVmQmRNOU1D?=
 =?utf-8?B?dDVsVmQ3dmU5dHNtWG1saENSZTZVa2JQampmOXRDUk5kVUoyR3pNRlhsS0tp?=
 =?utf-8?Q?67KjX5q788lnaOS/Fyfxxhn+A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61816e0c-f0b9-4ee9-1c79-08dcfead017a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 21:50:18.8636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hu+nYhltU9isDAxfvLp/zXxBWhfS0QqySzCWGUzBZwlAG9yi00Dw1yis922UhIKmfnKMxBFXtgmGZoYEkaQ4fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8919
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


On 2024-11-05 20:19, Ramesh Errabolu wrote:
> Raise an info message in kernel log if PCIe root complex
> determines that a AMD GPU device D<i> cannot have P2P
> communication with another AMD GPU device D<j>
> 
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 230c24638a34..ab304a2c4aaf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6222,6 +6222,8 @@ bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
>  	bool p2p_access =
>  		!adev->gmc.xgmi.connected_to_cpu &&
>  		!(pci_p2pdma_distance(adev->pdev, peer_adev->dev, false) < 0);
> +	if (!p2p_access)
> +		pr_info("PCIe based P2P links are not available\n");

This message would be a lot more useful if it told you, which two devices are affected. You can use dev_info to have it print the PCIe BDF of adev. Then you only need to print additional information for peer_adev using pci_name(peer_adev->pdev).

Alternatively, you can just set the last parameter of pci_p2pdma_distance to "true". Although, that will produce more scary-looking warning messages. I believe Lijo disabled that at some point because of that reason.

Regards,
  Felix



>  
>  	bool is_large_bar = adev->gmc.visible_vram_size &&
>  		adev->gmc.real_vram_size == adev->gmc.visible_vram_size;

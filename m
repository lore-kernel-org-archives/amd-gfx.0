Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17207D3B9A8
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 22:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE29D10E220;
	Tue,  9 Dec 2025 22:13:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JtycHvhc";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B20910E220
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 22:13:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHgJn5AeF5VpKTOkQ9e3KVtkigX8Bwd7aoCW7cu5PyIuOZ4ymsf1Eix5XMhJ93xf3H3l39hA73d3LB8izQg/0yGSjqG1ruPzKWw2pacFAKftayuj3oXA7hQDD/HBzryspmWh1zovw3Bzqgi4qzJ2l8PXt/byauGGgScmL25jJmhbPS99D7TcUPUvSRdC6o+H0ySMeSk1E8GoP7G5auDwjs5cvU1KjMtVzja9mAfpM6NTxDa5N1Zn88PQc3DRtqOz3g/9YhwLcqTLzX9VYOGB9VNORu038H8Hwh9AI1xaGpOI49EcBG/UiGTOFP6Bk6xcNQnwZPRrQ+QEe6OLW0KhcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyhaNWuNFrATGr2PlSWHuthFW3kB+dITsjAPn+4MzPs=;
 b=q3v83P0shPLGARnXLCtj/Fpu1rzJ6uw+svoyEYzukvwztNvrh3t9ZCA0uTQwoMnAoJesGnD+slO6e/zFTMvIprvOJcQryAZ+rgjermxnDTOmg0Ks0zabgqq0hrdR2+/q5kf9+jxsJ9dOdYdcZM8fPQGMMcvrLpoVG0hwI56sFOIS6120IeUOsfnMIe51urVx8jAvbLsOAowToJm5LXFqB+xF4BXqg3wVYOEp/NOJtJobI5ul2+fKc+vcoSYNkojHgikilqYGec+1b9M7hy33Ow6/42DYU2NdlSdLMr6zeCn3iV6rBVWI4xMTFSx69/aiKHkEbT9Vc9Vx3W2hcstbyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyhaNWuNFrATGr2PlSWHuthFW3kB+dITsjAPn+4MzPs=;
 b=JtycHvhcnEo5F0KI0xbmt9fTbWDngGVWw7Tn7FSmp+AfTlCdZ9km6Fe6wFuGkiSk8fCYwgCsdu/qNDwPV67LSpnn4WixIH7xcieBAp5XFTEoPIf5l5ptXuFJFvM5xCWGK6CXS840x9YAkx9BgEab4X/GoBkCmy2hEEaYBREBh08=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6566.namprd12.prod.outlook.com (2603:10b6:8:8d::16) by
 DS4PR12MB999076.namprd12.prod.outlook.com (2603:10b6:8:2fa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 22:13:19 +0000
Received: from DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7]) by DM4PR12MB6566.namprd12.prod.outlook.com
 ([fe80::31b:5d31:8ba6:abd7%6]) with mapi id 15.20.9412.005; Tue, 9 Dec 2025
 22:13:18 +0000
Message-ID: <0e0acd6d-ab5d-42ff-8b6d-c531b708e2d8@amd.com>
Date: Tue, 9 Dec 2025 16:13:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Unreserve bo if queue update failed
To: amd-gfx@lists.freedesktop.org
References: <20251209203657.440714-1-Philip.Yang@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20251209203657.440714-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CP5P284CA0226.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:22b::10) To DM4PR12MB6566.namprd12.prod.outlook.com
 (2603:10b6:8:8d::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6566:EE_|DS4PR12MB999076:EE_
X-MS-Office365-Filtering-Correlation-Id: e756df14-751b-4b82-3bf3-08de3770284d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aFZRSkt3NGx0d09GelliVXJCcDYvd01mdGkrVy83VjBxVVYxS2MrVUtyZDNI?=
 =?utf-8?B?K3Y0SG1LR2pvNnhjRTRFamtkK1hvSlE1d3BLV1ZYa3RnTW1CSHRDa3pVUlF6?=
 =?utf-8?B?eEhaK055Wmx4WENHV1daNEwwMTVYTUtZZTBja2VoM0pYOWo4ZmZ5UXlRV2M4?=
 =?utf-8?B?Z0pjelAyaENBajJqQmVjS1NHUGlWM2FoQ3ZTMnF1SjRnV1E4NUkwKzFMNncr?=
 =?utf-8?B?NWNiUmJ2a29kR3RBbElSM3B1WjErbUVHM05FdTdXd29jTVgweU12ZldtSVRZ?=
 =?utf-8?B?QjZ3aVFYV2NGZE9MQ3ViT2pxM0pCMnJZTWt2N2hHeVJvT0NXMVd4WGYxU3RD?=
 =?utf-8?B?OTlHdDVyTkpUdCsxR1pMWXRXYW80Q3owemtvanhxay90MmdOdWhiakRIcG15?=
 =?utf-8?B?RXdxYTNJMkJRZzllblZnY2VSVWJUaU42Z0ZYSkc0ZCt6RmdabXpEckNFNXRu?=
 =?utf-8?B?enVoRmllbVRNS1l4dzJpRE84elhQRCtjQi95VCs2S1NoaGt3SVU1OXZseklz?=
 =?utf-8?B?NGVKYUI2UHcrM1RDaWFTanpRdkt3ekthRFoxSENhMDNnT3FleG9lMjhjRmJt?=
 =?utf-8?B?MVRLZGJNREw3TDFWQ29aenVORjlPazhrb0FBMkVpb3R6UnlFRUZ6UDNFTjhC?=
 =?utf-8?B?YTI1dkdnbWtxQTZ5OWo1TU5WZnFRSjROWHpidUcvQ25zT09ac3RlOHNvNUhs?=
 =?utf-8?B?c1NxU3FVa0Y4eU5VeEVHeVAyanVPZEk1eGdCYW80VFZCODEyMndocjl2UlRX?=
 =?utf-8?B?WUszVStqRndSakhiNWpMVExkZ3NNZnN6VU1wVE9ici9ZSDhLNkRPYjljZDY2?=
 =?utf-8?B?bVZTbzROQ1VoVWlYenUvMU1KWHJ5VE1MWWVUc0liZjVNRC9iMWtiS1NGTzJ4?=
 =?utf-8?B?SWx0WWgvK2V1TDd1YitDaUsyc3AzLzloOGN6dWM4Q0FEL2lEdERIdWI3V3JM?=
 =?utf-8?B?bDJzVVVmcHY0N1VTYlhkaGpxUFBTNE5CL2g3a3RPS0N2dFB2SXAxY1ZtUDYy?=
 =?utf-8?B?eHBzdFAyK1loY1BZWmJGby9CblN2SkhGYzV2U21iMldMODJhTlpNSklwZFNm?=
 =?utf-8?B?OGl2YWpUN2h5MThEVnY2dm1nc3pPR3NrY2lTR0VSM2I5QVJ2SkhmQ2VIb0N3?=
 =?utf-8?B?b1RqUmFxUGY3Y1UzQ25ObVcyQU5xSzM4NU1rMEVxRGFzeHVVQUpNK3VpMEpW?=
 =?utf-8?B?TTRrVXhVYlRsSDlKYlMvUm5iajlHb2U0WWJqTXc3Z1RJQjQ3Y25xN2V2cWV6?=
 =?utf-8?B?dkt2R3lCd2lxSEI4VGV0M3U3YTFsc0w5V1Zvc3RnK1FjeHlIYjAwTjAwOUp1?=
 =?utf-8?B?REU4NmxvRmVJNjFVdmpuaVQwYTI3dTVJWjNmWVo3aUV4WHA1MGR5aDBoNG8z?=
 =?utf-8?B?Nzd5dTVqWTF0Zk9WSW5PakI2MmRmcnpsRFBSRlZZcDBIZWNrZjFBVEJpelI5?=
 =?utf-8?B?ZStQT3BCOVV1K1llb0Q0NlArakhpRTlvMXZvT3VWbS9vcmJLK1k1VkgzZSt3?=
 =?utf-8?B?WmJhN3VxL0VUNmcrSHRmUm40MlNPNmZYTXlrYUErcURObUpsblNGT2lMa1RG?=
 =?utf-8?B?NVRYSGdHZXpVelB6TUdYd2pkTEwrREQ1VEFEWCs1RS9MRVN0bjNmaCtDM0Ux?=
 =?utf-8?B?amhtUWxYSWhWUm1nR3hWQTd1bGRGWXc0bmNrWjI3NzZjUzV2cVlrUlRBOENz?=
 =?utf-8?B?ZllxQVlsK21yZnRsa2JBZ3ZtWUlYRUNiUzhSZjFCUERsa05pNXoxUnlubjZE?=
 =?utf-8?B?bTJXeFFFTkZPbGFWT2ZrbTEwb01xRHVkblFYN21kUmNNUE1FTHBaWTJ4THNy?=
 =?utf-8?B?Y1VhZGhzNldjRHp6bDRNSngvWG9iNmZ2c2dZUURDOUxidEJtTlZNVmQ1R01R?=
 =?utf-8?B?NWV5b3d1OTBiWTdhZk1DR2dSQ2ZIeG5pWThZTXVmLyt6cGxpNDZTcXdJeG04?=
 =?utf-8?Q?3rz4e//gIQpVnxXwUn+jpxGigWf6IaDV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6566.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmRQZlFlQU8wRTBlTUlrSDRhR25rSHJnNDdTOUs5ZG1hZ3NzSTlXMlYvTktB?=
 =?utf-8?B?VDY4bFF5MTl0bklFNlJ6cHBjYWhSSVFDc2J0em1heXQrSjlPNnRVV2E0ZFNF?=
 =?utf-8?B?TUNCbUNUY0ZSajRJeTBjUFhPZ3NnZVZ1SWI0UEcva2FjQms1dDI3UkZMd2RV?=
 =?utf-8?B?azgvTVh4aC9VQVJPZUJpSDRHU3A5dXk3L0Y5S3BjWDZXMFBzZC9ZaTNsRzJX?=
 =?utf-8?B?YU1ic3JETUJmY09qYzh6RFFnRDJ0aWxUZXgyaXE0WlhrakczWWFFd3I2c1Fn?=
 =?utf-8?B?QUtnRHJXWWZhRzRnRlVCYXRlTHBrL1AzbWRZSlJjR3BOOWxZS1NicGRaaTdh?=
 =?utf-8?B?byt0ME00RmIxaG8vR08xamI0TzBZNE1lMlIzK3NaMDhXSGQzTndqdUlxU2Js?=
 =?utf-8?B?eUFiVUV4cWtOOXdxOGdHWUE1cGxvb0F0SExFYmZZdmkrb0xZRksvSlcyUjRn?=
 =?utf-8?B?cFUzM0taK0xQZS9sRjRaVWhaRjh0SmtXdHkrMU1tVDVLSW1pUmJEUHJtOExh?=
 =?utf-8?B?QVdhT0dMbU1rTUREdFhtZFl5eFJPUlhaQmk2Z3YxSTdmdGErUmRwaGZwU0tV?=
 =?utf-8?B?cVVnUVp1OUQyZHo1c0VQdEFJWG01WXFYNFFIWGQ0ZHdlSTBnVmNlUHBTb3ZG?=
 =?utf-8?B?ZDNIaWhNTkV6cS9hb3BHMGtodUZNK3UxUlNOVTZHZUxQMjBNaDRNOG5YTEM3?=
 =?utf-8?B?Z3diUktrL2E4anhwSkdkd2hLc1FVZXVxQXNTbGNwTXcrdXA3eGRIaUFOWWdS?=
 =?utf-8?B?a25MeUx3Y05nT0dqN0NZNWFSTWQrcGx3MnhuaFhiMDNUMDJXNUVWcXFYVUtI?=
 =?utf-8?B?dHRXckt5cXBMR24xVDNUQUVWVnlRTDc2UERqcWRtNmJvU20xdUpJWWhGL2hE?=
 =?utf-8?B?aEVaSnBjZjZGMm5HODZrZ294TnBKOXkxSjd4SXFCejZ1cmcxQnNRSFFRdksy?=
 =?utf-8?B?VHFlOHJFcVNpbTlVdDk5VitBTGZtTGdtZ1R1Z25CdE5sSnNKN1BreHB6N2VR?=
 =?utf-8?B?aEVyZ2QyRzEwbkxVZ0FRaVVJQWg1S3IvaWs2SzFTZjNOL1Mra3FoaDNlNVdr?=
 =?utf-8?B?NHJRL29BRzZSVGhZNVVlWUZLYUhVUUpaSWtEek9uVTZUYXRTTit1Rk42QWhR?=
 =?utf-8?B?aytxRW1qWGg4V003SVdvWVNoSThBcEJvOXN4dmtjTTl6SElhck96a1gzdVBN?=
 =?utf-8?B?djVCdGM4Ny9GOC9wbmt6b0xlcGp3ekZLTCtNUVg2aWcyN090dXZoazJOZ0Nl?=
 =?utf-8?B?NDl2VGJONUFwTDRtNjFvWEtXR2srUGhRTi91UU5GdmoyMURab1pKcGlNVnFq?=
 =?utf-8?B?bkdZbzd1SmdTcE5jWDFYaEVWQkNicmFzay9rb1dHZ3lPT0ZaUXNWV2ZkaDdM?=
 =?utf-8?B?UVVMcEU5cG1KQVBxYi90K3hkRVNnR0JaMVg0WkdkbkZ1TWRUdUoyNkkrSDVW?=
 =?utf-8?B?ZDFaYU04S2k4OFRtOGp6Mkp5Rmh5RGYxM0xpZ3p4M2krZkFPZUNHZnNCdXhY?=
 =?utf-8?B?QWlzSVBndm1VdElSRU0zVnlET2xMYStyTEoyVUZkand0dHQ0dmQ3Tk95T0NC?=
 =?utf-8?B?YzlOSzNTSERZdzdMeVl1SFBLOEhPeU43YVJWUm52ZDFZdXNPNlhqRWpwS09B?=
 =?utf-8?B?YVBTblVIcDVXTEZPUW9NT0FVZ1pkWmlRZldOVVZEazRsczFEaFZveEJrWXpa?=
 =?utf-8?B?ckR4OHFZaTVXZnMyM0lTRHpjbWlpclR1aGJ6SEtwRWFGWDhyR1h5NllqVFdZ?=
 =?utf-8?B?b3paZXhmWVl3a2V5ejNPU20xaktiZkpPUUF0by9zRmFTTWlmS3hoek96MWpm?=
 =?utf-8?B?MGFNakQzeHdCK3RDbDl5M1NsMnp2b0RVVUoxdmZ6VEd2K1paeUF4bkVSNFhU?=
 =?utf-8?B?bWN6amFCVWVxMVJiNzR2U0RyQWI2VU9vSXNnYUpseUFpMTNkMW1YOWhLeDNL?=
 =?utf-8?B?V1JhK2RKam9wRmNuWGhvdy9kQUYyeEJwS2xnTHc5U3A4S0Y5WmZVTHVFZ1Nk?=
 =?utf-8?B?THlmYnFINVNnUStqc2ZIcFJ5S1VMYTRxYTAzbDNnSFo3SGpyaGN6amNNUnVO?=
 =?utf-8?B?VWw2S3dtNGNmOTM2dWxTWVJJMVg4Z0ZkdElyQnM2dElncElBdjVLSWpqMURx?=
 =?utf-8?Q?QNZs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e756df14-751b-4b82-3bf3-08de3770284d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6566.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 22:13:18.7866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 340pajtPz87jzuA7G9XXs/hlyHAHRaxmWK8WyBVNC1qVK3co6iNi/vPHNIXvNfQO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999076
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


On 12/9/2025 2:36 PM, Philip Yang wrote:
> Error handling path should unreserve bo then return failed.
>
> Fixes: 305cd109b761 ("drm/amdkfd: Validate user queue update")
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 232103742712..6babdf025359 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -592,6 +592,7 @@ int pqm_update_queue_properties(struct process_queue_manager *pqm,
>   					 p->queue_size)) {
>   			pr_debug("ring buf 0x%llx size 0x%llx not mapped on GPU\n",
>   				 p->queue_address, p->queue_size);
> +			amdgpu_bo_unreserve(vm->root.bo);

but why need have amdgpu_bo_reserve before call kfd_queue_buffer_get? 
kfd_queue_buffer_get just check if mapping at addr exist, it adds bo_ref 
and mapping->bo_va->queue_refcount. Then after immediately call 
kfd_queue_unref_bo_va and kfd_queue_buffer_put.

Regards

Xiaogang


>   			return -EFAULT;
>   		}
>   

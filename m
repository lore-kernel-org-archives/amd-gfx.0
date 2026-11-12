Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EEE606A327
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qHuUSEEY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C6101120B5;
	Thu, 12 Nov 2026 12:46:39 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012050.outbound.protection.outlook.com [52.101.43.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6F4C1120B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 12:46:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rL/U4OMrNJregsfOLr65m6RtZ/ea7s/tYC09tUkKPsPMlJOD2LTM3Znl7SxzPw1GYrcHIYQESmHV/E5bnKa+Kr6rTg2S+RSZv/Cx43sqQyJJbYjaPudRkYtPkJfboMITuKJ18ZZ6nvhixSTBa39o6Qa9ebv7T8leGSWrRTr6l73paaB/UEzF46FU6NeFB5Lqg1BjBUPGki9bJTkmP7eQUuhxjEb8n86Y/AEYaVlzbqJMYcRmqHsHKoEs0HXF6Lw3/NfohOUSc2ZulEoFOOFj0wQANhc/QvvCil2QA5Rap6sJlFsQ7JkbMMeQ0hdFtKw9vOKvJ8dcW4SoyaC+zJ9jww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VU5S8M3mT6CiwdHw7xWlQFPhgWzugA6u4SSfXGTnSMs=;
 b=KTDzT4JxxrRFweSVH3tBKZ6oWYmuHDYgqxeiU43UzFTUktcK8NUFLqW9xlDau28zCWW/JLM2RO4mP3ftCs+h7vAQLXkEcTnbcGmeyML6Do7ZKGLulmcczvMFIaT7FEYKi6DzUIeDD0JOGUUZLvVAiicHujJpVMYxSL85plXSAgC8Sad1OeqA+3HrNtd5MgruD+T2BRfhClDWMBGGuH0z7aB8KywcW44Pa2dSVfSfgk0puPDr4HAdnWqYPi/f3lJKczt2H1u33EYKq4roTVPQxr02p7IwWgR0gVkUlPrQYLZ2uYpBjB64tcRD6DkNwDFdTqUU08cDtznogAbeUqiqmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VU5S8M3mT6CiwdHw7xWlQFPhgWzugA6u4SSfXGTnSMs=;
 b=qHuUSEEYkBbCv8Z+ZiW1twrwBWhcJoSDlIgNI7pTXDiJPX2KvVGb4r4Id0iQZfuk5zHMv8qWS6txOFEoM0HPl/MbmHdXjO+mf9dT7qAyEyF8lTgRlOvBsTQ7ni5G8uEBxWt0F+l8JEWhlgQmABZiBmBcvBV11o7tDcr88fwQStw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB9472.namprd12.prod.outlook.com (2603:10b6:806:45b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 12:46:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 12:46:28 +0000
Message-ID: <8e23fe2d-a28c-49fd-a15b-9e937038b132@amd.com>
Date: Thu, 12 Nov 2026 13:46:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amdgpu: keep the A+A VF VRAM base at the SRAT
 address
To: Zhigang Luo <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, Hawking.Zhang@amd.com, Lijo.Lazar@amd.com
References: <20261111192319.297456-1-Zhigang.Luo@amd.com>
 <20261111192319.297456-4-Zhigang.Luo@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261111192319.297456-4-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB9472:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ae3404c-ee86-4631-fb6f-08df40baf853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|5023799004|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261102123227099003|261028144727099003|261026121527099003|261026140227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OykVBREpKfgVeumPQcBxznj+DoOKI2gEYGRLF3xBhiiRueNd4kvouN+AgkxpRGRlDj+90xONhMgNiJc7cK4RVLWs/1wW3DTAQS9+COvftF+ZjZ/bHaqOeHeiwJb8zeCMIZlajmFWU9+0GVqoRwY3lcF8azClsg1B1KVQH7mgwpehRYIJQjNfvfAfFmOZ6fdeKNqaHRJ0LxQZjK0Y1FfcXY7mP+fNjYtUL1YcRg10hF52xnUdXUP0YB1FGbTNlXSv+ws4GAw2RA5X/B/LaxEmwRSyFzC5uV6fAEgdoiBr8CurcHHpRlj2W3WCXUxqoUtCkbNK75KV0R8D0GRCs8XK1Y8GDZ1fEcZuKwNSaNCc+fhA7yoNd6HDXMF38C3qwQzccRqVsaTgzqv4X2v/faE8kL7EXawiIElAtikUIdqLtLPOWgrwW96CF3dod01zngZSLXEWQTNVUc+3qHiXrKS8KaWSSzWLKA5LSblG0aWUmMQgUrMQhcGJyWTirQITzZT6RMY6CXYX8vIB9wRxbBwLn00pLCEJvqwkfOrfhy49qCqXyhgjIw6GIy5ad/+FjgiQ6SjJ+kFfx6TEbP4eUIadNgz1oQ3dhvMiEwM7g6DwrlrEGp2FoGkREG1CrBCPLs/xWK3040s3vqe5+HTo6ZvcOMyQifABhGcbhuDF66c+NQA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU9yd2R0K0ZCWnR3UlRSNEcvQ1o1RGZnZlpOVE5FT3hzWUQ3SmhvWC9ZUE50?=
 =?utf-8?B?VFBxRDgzb0JPUE9UK0NNamZJWUZlZEtHVDNRODh2VFZEN0RndkxKREsxdEsw?=
 =?utf-8?B?RDM5RmsxSkdieHArYjBQRUJTZnE3U0ZUVUtxMlRZMDlTZDdNclZrMnVVTjla?=
 =?utf-8?B?T3RwTnh4SmNPcjhOSXBjWHRhY3FXNlFMZU5GK2kwOFBXcnZLMVhHY0tMZkN6?=
 =?utf-8?B?Mm9Cc2txK1lsTWUyb1J3czN1NlVmTldPMGVBajAzSGorWHhNbUpLVlN6bUpI?=
 =?utf-8?B?K2V1MWtXYXdzWUU0SVdhMSt5Z0NmOFJtcUlPclI5cmtTaW9vL0RPYnM5ZjJ4?=
 =?utf-8?B?RGNDdGNiWnZuektjWCtIR1lDek1lc3pLdng2OE1BNXY0eGNxUmFLcGhyOTVJ?=
 =?utf-8?B?SlRhMkNac2YxWFBJZ3Z3bExmT2VONnhHMFlxM3kvSGhxUkw4NllkdVBnYkVF?=
 =?utf-8?B?Vzhvams4cXc5c0l3TGc3c0NiejRYazdxTjhjZW9EVmJxcnU2cjlVVVZBaE9j?=
 =?utf-8?B?OEowdG14Zzg5MXcvWnNPdXB2MFMyc3Z0RDI0Mis0dkEzeDVQZG5Yclo5cVQy?=
 =?utf-8?B?NlVvNTVwTTdmeWVVT0N5UzYwSUdzV0JSVXV1U1JrbWorMlRlcnhjelpkSFVk?=
 =?utf-8?B?VXFZdmxUM2Nqb1VCWEtva2ZJWktjcHJ6a0lOUlNzQWhEVFArM1dsb1Nud1Nj?=
 =?utf-8?B?QWJVcnI2V1c5TjE2VmdFOXlkNXViN1RQTy92Y01wY3BCYWU0WU0yMmZqOVVp?=
 =?utf-8?B?NGJpQm94UUJyRzNYT2YxbDNXb3cxem5lYitBKzFvcERJaFlKRkpxRnUrVTNZ?=
 =?utf-8?B?L2owU2V3YTBaendCbmZmY212Tkd4ZVpray8vOGZ5ditnemhKY3drbzV5VXQw?=
 =?utf-8?B?OUVaL2tZejlsdGYxeGJwbXAwYlEvSGx0Qy9JRlFYQ2VDTUNaK0ZQWFB3bWw1?=
 =?utf-8?B?UmdaOGVweTFhMHFFN09oWXRLVkU0T2ROT3ZZR0djOTRDVDk2bElFak91Kytz?=
 =?utf-8?B?ck5OTVNnOVhRTmRhUS8xdWJZMVhERUdnYnN0SjhwQVNScnMrSTZtTWd1cVpS?=
 =?utf-8?B?YUpPNXA2dm0rUlNkUjVaUm10ekpJTmNSMkxpYTR3ZDVaZ0VsSE10czZGb0V0?=
 =?utf-8?B?YmtNUVdueFdhSGxIcWk3aUZnVDEvU2ZtUVB0RkRqRjNWbzVWMmZiM3lMQ2tF?=
 =?utf-8?B?Zmh6ME9QaE1PSkh2dUZGaTRWM1hWSjhHenFVdFhRdlBZcE1NdDBnSUlkWmxm?=
 =?utf-8?B?Y0E5TGlOemRpWFphNmFCODVsd3Bhd01nemN6TGJDVmhmV0JBNmJkSlhKdHJk?=
 =?utf-8?B?MHFoYlFYTElIMDd6cWRMTDFwaEcvS3dNTCtWNkxSeC9ReTNGd0lUSUdqZzlB?=
 =?utf-8?B?UVJ1YVdHYkNhWkh3di9uVm9WQ2JrZUtyWEFyRUxQTVZKM0EvbEVOWEFVcVli?=
 =?utf-8?B?ZWFMZ3QwVDZOTUhJcklPOExSOSttT0I4MWVOZHBPRWd0c0hFUWQycklwYkM0?=
 =?utf-8?B?Q0VmRE5uK2EyQXk1a2ptd05QQmRvR0R3TkFqVG1Eb1FUSlZsaFZzY3MyT0V3?=
 =?utf-8?B?MnJNck9heTEvMXBwTlpCelUxeWUzbHF2R3M1YVJzc3NZVHMyNUVmQjM0Z1NX?=
 =?utf-8?B?T0ViTytuS0pZVVNMbEovamo2K1dnR1hBcHpVUks3dVZndmhGR2Y5allaWFdZ?=
 =?utf-8?B?WmhKbjJLQzNZZUZGUWlKTWxZNkZsZkp0Q0ZoT3l4TWNXTVMxdVgrWm1jMmJ5?=
 =?utf-8?B?OHBvSTB3eGtpNWRjbDZjOW5jajF5ZURFRTFyWHZ4M3hPWnZ3YWVpdnNHb0hk?=
 =?utf-8?B?UHFEcHB2V0lxQ0lkZmJWNS9lTDJCUlhRYzRQMWNWcitXTjQ1bktVYllDOSs2?=
 =?utf-8?B?ZmFYWEVVNFBRL2pJQUVqV3NvWUcyWU1pamJzT3M4enkzaEp1NEFMMjdiOGNN?=
 =?utf-8?B?eWRXQk1OSyswT3NzekxTcXI5R0xsNlc1SDRFeVNWTmt0aStJN21Jc0lGQlFY?=
 =?utf-8?B?aG1oRjQySnJETmJWZDExZWVrNzlndEc4SEowVXhjWUpGMnRhVXdiaXEvTURQ?=
 =?utf-8?B?LytsMGlvQk9pUmhCUTlUYk1jVmdTY0hDTk9UWnNxUSsxNlQxVUMwaUlHMDAx?=
 =?utf-8?B?K0NHUkN5bjZ6UFdqOXVWNnVvb0ozeGxlanJPMWRRWFR4YUZ4cW9CQ0hjSThw?=
 =?utf-8?B?NDZTZEJvM0pZVW1sM3ZKaTBYbStYUzA5UGorQzFTZVBHRHFHcWE3SFRYTzA1?=
 =?utf-8?B?RWZwNGJDMnVNRkp0N0Y1TDBMQ293SlpLTDI3aUIvZjJiT0ZONWFrTGk2YndV?=
 =?utf-8?Q?xHXq/0HZ4xVV1aokUM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae3404c-ee86-4631-fb6f-08df40baf853
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 12:46:28.7210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHufOlPjO0gSZELj1k4KaRCm7iTWxvEPXgFby7lSbR7WeJKU3p20vkqy1WDtD81z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9472
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/26 20:23, Zhigang Luo wrote:
> On the A+A VF the hypervisor reports each VF's VRAM address in the
> ACPI SRAT table, and that address is stored in aper_base. The XGMI
> LFB region and segment registers describe the physical GPU, not the
> VF, so physical_node_id * node_segment_size is not a valid VRAM
> starting address.
> 
> Report the VF as a single XGMI node from mmhub_v4_2_0_get_xgmi_info():
> one physical node, node id 0, and a segment covering the SRAT
> aperture. The existing node offset math then adds nothing, and
> node_segment_size * num_physical_nodes is the VF's local VRAM, so
> PDB0 is sized correctly without a special case.
> 
> Return aper_base from the GFX 12.1 gfxhub and mmhub
> get_mc_fb_offset() callbacks, the same way an APU uses the FB offset
> for aper_base, so vram_base_offset is computed by the common path.
> 
> Align GART to 8GB. That alignment is one PDB0 entry when
> vmid0_page_table_block_size is 12, and it applies to every PDB0
> placement.
> 
> v2:
> - Explain that the SRAT address is already the VF VRAM base and must
>   not be adjusted by the XGMI node segment.
> 
> v3:
> - Report the VF as XGMI node 0 of 1 instead of special-casing the
>   node offset and the PDB0 size.
> - Return the SRAT address from get_mc_fb_offset() instead of
>   special-casing amdgpu_virt_resume().
> 
> Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c   |  6 ++++--
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c    | 13 ++-----------
>  drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 20 ++++++++++++++++----
>  4 files changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 04cf02dd22ac..ac2664e1eb8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -42,6 +42,8 @@
>  #include <drm/ttm/ttm_tt.h>
>  
>  static const u64 four_gb = 0x100000000ULL;
> +/* PDB0 block size 12 covers one 8GB entry. */

That comment doesn't belong here.

> +static const u64 eight_gb = 0x200000000ULL;

Linux already had SZ_8G and SZ_4G as defines, so those here are actually completely superflous.

>  
>  bool amdgpu_gmc_is_pdb0_enabled(struct amdgpu_device *adev)
>  {
> @@ -261,8 +263,8 @@ void amdgpu_gmc_sysvm_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc
>  	u64 hive_vram_end = mc->xgmi.node_segment_size * mc->xgmi.num_physical_nodes - 1;
>  	mc->vram_start = mc->xgmi.node_segment_size * mc->xgmi.physical_node_id;
>  	mc->vram_end = mc->vram_start + mc->xgmi.node_segment_size - 1;
> -	/* node_segment_size may not 4GB aligned on SRIOV, align up is needed. */
> -	mc->gart_start = ALIGN(hive_vram_end + 1, four_gb);
> +	/* Round up to a PDB0 entry so GART starts on the page-table PDE. */
> +	mc->gart_start = ALIGN(hive_vram_end + 1, eight_gb);

Good catch, but that needs to be a separate patch and should most likely be backported as well.



>  	mc->gart_end = mc->gart_start + mc->gart_size - 1;
>  	if (amdgpu_virt_xgmi_migrate_enabled(adev)) {
>  		/* set mc->vram_start to 0 to switch the returned GPU address of
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> index b13967a1c8fb..13e29752e435 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> @@ -53,6 +53,10 @@ static u64 gfxhub_v12_1_get_fb_location(struct amdgpu_device *adev)
>  
>  static u64 gfxhub_v12_1_get_mc_fb_offset(struct amdgpu_device *adev)
>  {
> +	/* SPM VRAM starts at the system physical address from SRAT. */
> +	if (amdgpu_virt_vram_is_spm(adev))
> +		return adev->gmc.aper_base;

This is still upside down. Don't use aper_base for the fb_offset, instead use it the other way around

> +
>  	return (u64)(RREG32_SOC15(GC, GET_INST(GC, 0),
>  				  regGCMC_VM_FB_OFFSET) << 24);
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index cd276a138e10..1c7f3f0496cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -720,19 +720,10 @@ static void gmc_v12_0_vram_gtt_location(struct amdgpu_device *adev,
>  			amdgpu_gmc_agp_location(adev, mc);
>  	}
>  	/* base offset of vram pages */
> -	if (amdgpu_virt_vram_is_spm(adev)) {
> -		/*
> -		 * For SPM-backed VRAM, PDB0 entries use PTE_SYSTEM, so the
> -		 * address is a system physical address. vram_base_offset must
> -		 * be aper_base so PDB0 maps GPU address 0 onto the HBM system
> -		 * physical address.
> -		 */
> -		adev->vm_manager.vram_base_offset = adev->gmc.aper_base;

That stuff should have been reverted.

> -	} else if (amdgpu_sriov_vf(adev)) {
> +	if (amdgpu_sriov_vf(adev) && !amdgpu_virt_vram_is_spm(adev))
>  		adev->vm_manager.vram_base_offset = 0;
> -	} else {
> +	else
>  		adev->vm_manager.vram_base_offset = adev->mmhub.funcs->get_mc_fb_offset(adev);
> -	}
>  
>  	adev->vm_manager.vram_base_offset +=
>  		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
> index 4c0a2d671cfc..409d57a9045e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
> @@ -132,6 +132,17 @@ static int mmhub_v4_2_0_get_xgmi_info(struct amdgpu_device *adev)
>  	if (!adev->gmc.xgmi.connected_to_cpu)
>  		return 0;
>  
> +	/* The SRAT entry is the VF's whole VRAM. PF_LFB_REGION and the LFB
> +	 * segment describe the physical GPU, not the VF, so report a single
> +	 * node covering the SRAT aperture.
> +	 */
> +	if (amdgpu_virt_vram_is_spm(adev)) {
> +		adev->gmc.xgmi.num_physical_nodes = 1;
> +		adev->gmc.xgmi.physical_node_id = 0;
> +		adev->gmc.xgmi.node_segment_size = adev->gmc.aper_size;

Again, don't use aper_size here.

What you can do is to initialize aper_base and aper_size from fb_offset/size but not the other way around.

Apart from that having one XGMI node which covers everything sounds like a good idea to me.

We just need to document the multi use on the XGMI member decleration.

Regards,
Christian.

> +		return 0;
> +	}
> +
>  	xgmi_lfb_cntl = RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0),
>  				     regMMMC_VM_XGMI_LFB_CNTL);
>  	seg_size = REG_GET_FIELD(
> @@ -154,10 +165,7 @@ static int mmhub_v4_2_0_get_xgmi_info(struct amdgpu_device *adev)
>  	if (adev->gmc.xgmi.physical_node_id > max_physical_node_id)
>  		return -EINVAL;
>  
> -	if (amdgpu_virt_vram_is_spm(adev) && adev->gmc.aper_size)
> -		adev->gmc.xgmi.node_segment_size = adev->gmc.aper_size;
> -	else
> -		adev->gmc.xgmi.node_segment_size = seg_size;

That should also be reverted before this patch set.

Regards,
Christian.

> +	adev->gmc.xgmi.node_segment_size = seg_size;
>  
>  	return 0;
>  }
> @@ -180,6 +188,10 @@ static u64 mmhub_v4_2_0_get_fb_location(struct amdgpu_device *adev)
>  
>  static u64 mmhub_v4_2_0_get_mc_fb_offset(struct amdgpu_device *adev)
>  {
> +	/* SPM VRAM starts at the system physical address from SRAT. */
> +	if (amdgpu_virt_vram_is_spm(adev))
> +		return adev->gmc.aper_base;
> +
>  	return (u64)RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0),
>  			         regMMMC_VM_FB_OFFSET) << 24;
>  }


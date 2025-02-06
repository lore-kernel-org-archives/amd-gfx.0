Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D8DC02194
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2025 09:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 761EB10E832;
	Thu,  6 Feb 2025 09:11:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aqMuY+Ub";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32C8110E832
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2025 09:11:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qh4EeyeHsu2TLUIcK4uMQD7XpEWlnmyGcl2MdRh7gFhH1cQYlRjavY/Nbxj6R77xnVwiqsTgi1N/UNbKh3c5ZFoiOuNK1K3mVH3lkjYk6Nhkm3b10yZnfNwJT4YoeyHqQwxmS6qEo8IyrxHO8rtXLckq9IOYEhXbr4SUPr6bEU5R0LigB8RjksKOry0q1ZNB49rJyNavpT0hJuW/wNMYzzHR6gU03U3VtrJALaCE5GakKXlB9tQMrNBBqR86/73r8veQmyhHDvXzY0zYOBDWj6wTSUF/kPJ38ABpUELmPQepBT/TMfWFMovEOw7mLMEKwDrUquzUSaIRS2N/BjDoag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWUsKoP4mDhuBn9iOFbgoo22c8C9YxdRpKEyMmo8Yqg=;
 b=MO/FG1Chm1xTLYywh8mm+ppbcB2uS7LEnCEphLBeLGoQyfrKHscr2m26PQ/wxgZneSzIoyahkbb7X2MH+SiOZhHg4/NNV4wv6ZCfVZ5aWzAkKNxoVNc9+H7iIycxjSxcu2mHpUQ72RCRj+eghp2TkWfugKdxDbFO/R1TqRgEWP/AhZTMVlh+a65SoDI3ZcgDil+safv3KGyKjhrm72uci4cUempoq5FFy3QFOQwTj44G33EJ24V2P2Oj4NkRlP77/oEdkjfvBDffh21rrOarbKXtJJhqQ9sWF43jiG0bKKHGgiG1TnccBcgNptmi0GVJ9F2OLGGX80ZspMC9isdtqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWUsKoP4mDhuBn9iOFbgoo22c8C9YxdRpKEyMmo8Yqg=;
 b=aqMuY+Ub2Pb/A0iV5Ldm92gmNMI4Gp/2sNhgESsykrUTWK4+D1epFimSuETqDBU2r1FzFscU6xScai+40w19zdMucBmMJygAHw+3z34y6h/LJ1ZK0jkH8lLCuN6oHGMShekS2kWvLbqhjmadlAlOPh4qNK0a1Yv89W1qmgZL6WI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB6354.namprd12.prod.outlook.com (2603:10b6:208:3e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 09:11:45 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 09:11:45 +0000
Message-ID: <8edc7b6a-f844-4bad-a91e-5910a00d2893@amd.com>
Date: Thu, 6 Feb 2025 14:41:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: set CP_HQD_PQ_DOORBELL_CONTROL.DOORBELL_MODE
 to 1 for sriov multiple vf.
To: Emily Deng <Emily.Deng@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250206075652.1561999-1-Emily.Deng@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250206075652.1561999-1-Emily.Deng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0171.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::14) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 70c40ab9-6f9c-4264-b76d-08dd468e4730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a3dvWlR2SzdtR2pIVGFySUVwaTd0RzdZczFKcHhxdC82Tm9HSzM4am1zdHAr?=
 =?utf-8?B?bzhwVkR4VlJ3MENHUzlCVzZCVHJLTFd2UW1YTFJTR1ZiK1diZ3h5UHZpRzE0?=
 =?utf-8?B?RWpGVEFEV3lEdTdzSk9EZnZJUklhTHdjMGF5dldnOFlRY0V0QTVTTStMZmxn?=
 =?utf-8?B?OGhyZEp5bG9PUVpvWm5IRDNDbitQTThoY21jZkEzQnh4Tk9CUGJGLzJhNmor?=
 =?utf-8?B?MklVbXMzS2VkV0FGOGpzVnNXWHZhNzVMcTk2Z2hCNEtYRGZUcC95akd1b2Ry?=
 =?utf-8?B?UklnZ3AvWE95amM3U2tYVGZ4Nk04OVROanQvRDF1a1RldlVscEQ1Zjl3czd2?=
 =?utf-8?B?QzNOZjhVM0lFa2JvZG55SUp3RHJ0Nzd0VXRzRExCNkcvejNwTFdLVUZMenBj?=
 =?utf-8?B?clhxVlowbEprc0hZdU9uZFE0d1o5Wk1RNlFZalZUeWpraFI0cW8zWVJSVHRM?=
 =?utf-8?B?OUpmYzBUNE5adFZGeHhvNUROakNOR2MxWENOMHdRR0NucFJib0UzclYwZ1pz?=
 =?utf-8?B?YmRmNk9xSU1kVXFCVktTYnJQRjZaN0UrcU51WlZYZWhzNjFlMXNpWG9idzBP?=
 =?utf-8?B?MHN6ZGtjMm04enhKcW5pQUZ2ZU5LZWdFMVY3R3BCNE13SkZzY0ttd2dGR2dj?=
 =?utf-8?B?ZkwxSXVGV1ljdXBrbGo5eHF5QUwyVVBGVHYvSVlLckpDYm9uaUx5endCQkJs?=
 =?utf-8?B?YUVEQ2lUTHh5RFNBQlZFR0lUR1V6akgwR1RIVWw4eC9MRGRhSkM5RG1WQUhw?=
 =?utf-8?B?eDBBUE9rK0FZMW5udlRzUWRYTjNKQzNkY2hDanBSV21xVndzenIvbTlhZUNP?=
 =?utf-8?B?WCt1NlEydDBlVVkyUFExbmVlQ1ZUbGhiV0NYUUswWHR4MUZpd1FpWE1mL2ZW?=
 =?utf-8?B?akZFVUdWN3hPUUFBRFhhVlp2TnhRTmx2dm5NM3BUYitzMGk3WGhRTUtocHQ5?=
 =?utf-8?B?cEx5dkVZYzM0ZDNEKzFTNGloNDRDcW8rSFQ0MGU4K01KUUNrZnQyTEhoNVVK?=
 =?utf-8?B?QjVlZkk1c3Y1bWl0b3N3c0V2bzNLa0FMajN3RGFROXpTZXB2WHlvWGJ1K3dt?=
 =?utf-8?B?L3NVdE9vZjY1UEFhbE1wSXU3ZVhFYmhPNlBqMXJZU0F4OTc1VjdlbmFUT2Rs?=
 =?utf-8?B?MXNFdHIrZUdBWnFTL0FUVVAvKzVrVUxkemtabGNMeVRUTEpsMEZwUkVxZXll?=
 =?utf-8?B?SlB1R1U1elNsL3JjaVR1ZVdoTDZWZy9WbzVkRktjcFluTkFTRXNOandwSkV1?=
 =?utf-8?B?cC9DZ2dVdU0rdmQ3Y09ETWZwaHQ2NlBQUlQ1M1hnZ01uOFdQNmxpME52TE45?=
 =?utf-8?B?eGpBR3d5N0VONWNaOEljUFdXNzZTdjJEQkk3Um9EbC9FQXhUem84QkY2S3dx?=
 =?utf-8?B?eVRHWDdGNmNzeERsVnFrSFVMbHR1dDRNY0RzOE9PQkVSQmNuanNZSWdDNGJS?=
 =?utf-8?B?NFdyQVV2Wlgzc203TklXRE1sem9lM3M2UkJEcDVSeURXWEd1T09yRDloNVEv?=
 =?utf-8?B?VWxkeHNjVVVCV3lMVXZoazNLOFR0WWdFbUl6NmNCUGRBbWlkNW9IQ1hudFlo?=
 =?utf-8?B?TjdLZkwvWGV1V2JiRG0yUDdRQXFvMi9mMnh3eWFqWlorelVqejNoMUowSE9y?=
 =?utf-8?B?c29ua2dpR3NmY3EvSTB0b0VVemM2d29DRzNWTm50cFhmVFJMV0owektOSDBs?=
 =?utf-8?B?Uk9OQkowY3hneFBwZFZBaWhLbkdJUlFYUS9MZ0VRUGxjSnp4YVRaNGJ1aVFZ?=
 =?utf-8?B?Rzg2T05kc0xKNzVrNlhNYUxvSUpaV0pzVmQ2ZU9lQ0N3VTN4Z1VYRktORVdv?=
 =?utf-8?B?THljQ0UzTFRHTkdnMktsMHc5RUFObEZodGlpVjZpMHh4K09WYWU4cFZvM0ZI?=
 =?utf-8?Q?qmR6k+cBgcqfe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0lLdFpNZWQ3clV4UDdSM0J3WTdYTVhBRmxXRSt5SWVnS21Tc3lzMnFhR2pX?=
 =?utf-8?B?TVF3TmlmUFR6MnlDYVNOODhjTGl1L05pRndFaHFWRHJUWTNjTlpUbU1WOXAx?=
 =?utf-8?B?ZGRBeDFETVUybkxLdVVUaGwyNHdEditiZU1LQzZqOU5vdllTWEd0WTRXRE9K?=
 =?utf-8?B?NE1hcURhRjAxc0tYT3R3Mk5Sbm50M0lvS3B4UWxJYi8wRnRNT1RNelBBSXlw?=
 =?utf-8?B?b3ZVaTNFQmJIVlhnZmlyRS9UMllkSEZQWWYzYks4RHpzaEFkYjZkMzgrZ2po?=
 =?utf-8?B?L2ZmcE5PcHVpdFdub0dMNTBCaXMweW13TzRMMHZkRUxOempML0dSSkVtL214?=
 =?utf-8?B?Y2RTZG4zb09sMWlaR2YvWXVkcGVmS1VMS3JSZVA3bkRkRnkvekpIb1F1R2Yy?=
 =?utf-8?B?OHA5NURjS3RaYXhVQ05aUklraG9WTmZ1UVhsaUZHRnZUWEUvR2VnMGkxeWdN?=
 =?utf-8?B?Qmx1TG4xL3J5bGNycnNPVGd4WVFDNlJGMXFoUU5VcFhXaVVHckZIU3ZjRmU2?=
 =?utf-8?B?S0NhRDBRajlaTktNZTN5SVJwaVE0TWloQk9tbW93cFhMQ3dVa1l0a2s2T0dM?=
 =?utf-8?B?blB3aGtUWGdlT09zL0FmUDNqdXFBS0diaVZMYVFuM09JNGo4UjJpaGJtNFFx?=
 =?utf-8?B?NHFuN1kvNXFNOG5ZU2xNMHVnK2lPUFhtMGh5ZkhwdlBxWFpHMSs3ODJuWjd6?=
 =?utf-8?B?elBxNUR1cmxYVTFwSzNsN2dxMWVlOGxZWlhocjdtSkZTdE0wc1o2RVJYMmht?=
 =?utf-8?B?U3dQbkdEdDNmcjFwdWIvU0J5S3diakZYWmRjdm41b0Q4SDhkakxjWE83a3Ir?=
 =?utf-8?B?WWFYTndiOWRMYUVxYjVNQ0s2dWhwMVpBcFJoM1RVRkxOZzRPeGlhYjA4ZXdW?=
 =?utf-8?B?SlFQK241ZytiZ0JZV293K3ovZ2dHbS95Yi9lU3o0ZlZaWXBZSmcxdFRjcUpZ?=
 =?utf-8?B?T3FVTm0rMXR4RG5tOVpQR0lUbnoxa3ZocnJ0Rm5oQ29HOTAveWI4M0o4NVY0?=
 =?utf-8?B?NXZKY0VuWmN1aStHZ2JYQXRlK3RNYnhSbW9mUElBVFRJazRZcndaMW5qZVpp?=
 =?utf-8?B?ektJWkI4U2prSVRXWnRrelJiNGpabW1BNUg1L2FtVUpoTW9Kc2Q4M2dVeU5V?=
 =?utf-8?B?OUs4K2ZyV1hvSmFSY0IrYWI1YVpjMFNWenUweWcvOUFraEUraGtpcjFsYUMz?=
 =?utf-8?B?bExJaXE0MjZrUWRVMjBUMG15SzJoN2xWdkxzZGR3UTZFQnNVMzBjdEVPQWxu?=
 =?utf-8?B?N1c2OE9iRkRZeVQ5ZVZ2WGc4Zi8va25oNXFySUFhM2w5enRJMUVLa0NhWU9z?=
 =?utf-8?B?aGxUWDJYd3kyeEVFbmh3SXpRUnVESDV0TUFWZkQvdVRhdmJzVjJZdUNqa2Rm?=
 =?utf-8?B?VmE5TTB0VkFjbmdpYTlya3prOGZNWWtteFd2bXYzd2cvbnp1dnlNRWRURkxi?=
 =?utf-8?B?cWdFcDZWRWRoanh0U3psMjVYeXV0YktNQUwzZDdqV2hHaUNROGxTSGR0REV5?=
 =?utf-8?B?UUFpUndYY1N4QmRPMDU0VVBDaW9pSmorZGg3Z01MS01pZm1rMFFiWVJRTUtJ?=
 =?utf-8?B?VzVuT1d0U0UwVWI2dERiYW9lTkVKOUowZldQUm5Ba0pjbUJPY2FkSE5sTjV2?=
 =?utf-8?B?WkdIM05zeHd4NVJ2UVlQRDlnZDFWMUNkNTMwQnFKQ1RlOWs0bXpRRzdERTJR?=
 =?utf-8?B?Vkh5V1JJaHdFUVYvdEI3NXZOaVBSbzQvV0cyYzd6V2o0UWdSQ1lIZTE3bVdO?=
 =?utf-8?B?Slg3SHdaaXNTcWk5bndycVZHZThNTmxxOHNBLzVQZWdrVGlRcTIyaFN0WU9w?=
 =?utf-8?B?bURsQ25yaXJST3p0c3lPa0hqT1BMU2ExR1Vha2JtYk9wWW5iYjhWSVpCWXcw?=
 =?utf-8?B?aDJWb0dEdGJxZHJwNXRqaVNpbkdNMWhVcmYvcHhzTDFDdHBQY1c5UEpZTEtn?=
 =?utf-8?B?UitoVGlmWk43WUZUVTVKZmVwOWh5MlNMYjBJRDd6NmlNQVhjRUoyVllnL2t2?=
 =?utf-8?B?WXVDVEQ4QkJ2dlBDZ05Fak5aeDZZUUF2Y09rSnN1eVNsbE96bDdZWE1zVSth?=
 =?utf-8?B?eEl4NUFJaDBjTHZ4RG1zRGpocGNyZStrZmc5TUwwV3ZINlBnV244QW1yTzFC?=
 =?utf-8?Q?J4s042jUPxfK6gwAzjwm1cQHs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c40ab9-6f9c-4264-b76d-08dd468e4730
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 09:11:45.3937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOP2zaBJ2OSvQJS8jsecA7oym/tfUqSCMMsUSQn0rmGRjkmHmM4EOSJZAQyap8vF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6354
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



On 2/6/2025 1:26 PM, Emily Deng wrote:
> In sriov multiple vf, Set CP_HQD_PQ_DOORBELL_CONTROL.DOORBELL_MODE to 1 to read WPTR from MQD.
> 
> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  2 +-
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 25 +++++++++++++++++--
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index 2ba185875baa..479b790d0633 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1857,7 +1857,7 @@ static int gfx_v9_4_3_xcc_mqd_init(struct amdgpu_ring *ring, int xcc_id)
>  				    DOORBELL_SOURCE, 0);
>  		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
>  				    DOORBELL_HIT, 0);
> -		if (amdgpu_sriov_vf(adev))
> +		if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))

Would be useful if this is wrapped as amdgpu_sriov_multi_vf_mode(adev)

Thanks,
Lijo
>  			tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
>  					    DOORBELL_MODE, 1);
>  	} else {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index ff417d5361c4..c8b2d7a8bd0f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -551,7 +551,7 @@ static void init_mqd_hiq_v9_4_3(struct mqd_manager *mm, void **mqd,
>  		m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK |
>  					1 << CP_HQD_PQ_CONTROL__PRIV_STATE__SHIFT |
>  					1 << CP_HQD_PQ_CONTROL__KMD_QUEUE__SHIFT;
> -		if (amdgpu_sriov_vf(mm->dev->adev))
> +		if (amdgpu_sriov_vf(mm->dev->adev) && !amdgpu_sriov_is_pp_one_vf(mm->dev->adev))
>  			m->cp_hqd_pq_doorbell_control |= 1 <<
>  				CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
>  		m->cp_mqd_stride_size = kfd_hiq_mqd_stride(mm->dev);
> @@ -724,6 +724,10 @@ static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
>  		m = get_mqd(mqd + size * xcc);
>  		update_mqd(mm, m, q, minfo);
>  
> +		if (amdgpu_sriov_vf(mm->dev->adev) &&
> +			!amdgpu_sriov_is_pp_one_vf(mm->dev->adev))
> +				m->cp_hqd_pq_doorbell_control |= 1 <<
> +					CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
>  		update_cu_mask(mm, m, minfo, xcc);
>  
>  		if (q->format == KFD_QUEUE_FORMAT_AQL) {
> @@ -746,6 +750,22 @@ static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
>  	}
>  }
>  
> +static void restore_mqd_v9_4_3(struct mqd_manager *mm, void **mqd,
> +			struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_addr,
> +			struct queue_properties *qp,
> +			const void *mqd_src,
> +			const void *ctl_stack_src, u32 ctl_stack_size)
> +{
> +	restore_mqd(mm, mqd, mqd_mem_obj, gart_addr, qp, mqd_src, ctl_stack_src, ctl_stack_size);
> +	if (amdgpu_sriov_vf(mm->dev->adev) &&
> +		!amdgpu_sriov_is_pp_one_vf(mm->dev->adev)) {
> +		struct v9_mqd *m;
> +
> +		m = (struct v9_mqd *) mqd_mem_obj->cpu_ptr;
> +		m->cp_hqd_pq_doorbell_control |= 1 <<
> +				CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_MODE__SHIFT;
> +	}
> +}
>  static int destroy_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
>  		   enum kfd_preempt_type type, unsigned int timeout,
>  		   uint32_t pipe_id, uint32_t queue_id)
> @@ -880,7 +900,6 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
>  		mqd->is_occupied = kfd_is_occupied_cp;
>  		mqd->get_checkpoint_info = get_checkpoint_info;
>  		mqd->checkpoint_mqd = checkpoint_mqd;
> -		mqd->restore_mqd = restore_mqd;
>  		mqd->mqd_size = sizeof(struct v9_mqd);
>  		mqd->mqd_stride = mqd_stride_v9;
>  #if defined(CONFIG_DEBUG_FS)
> @@ -892,12 +911,14 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
>  			mqd->init_mqd = init_mqd_v9_4_3;
>  			mqd->load_mqd = load_mqd_v9_4_3;
>  			mqd->update_mqd = update_mqd_v9_4_3;
> +			mqd->restore_mqd = restore_mqd_v9_4_3;
>  			mqd->destroy_mqd = destroy_mqd_v9_4_3;
>  			mqd->get_wave_state = get_wave_state_v9_4_3;
>  		} else {
>  			mqd->init_mqd = init_mqd;
>  			mqd->load_mqd = load_mqd;
>  			mqd->update_mqd = update_mqd;
> +			mqd->restore_mqd = restore_mqd;
>  			mqd->destroy_mqd = kfd_destroy_mqd_cp;
>  			mqd->get_wave_state = get_wave_state;
>  		}


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C982CAC597
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 07:26:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37F2A10E65D;
	Thu, 18 Sep 2025 07:26:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C9DYLOTA";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012027.outbound.protection.outlook.com
 [40.93.195.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A48F10E65D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 07:26:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxuozxjZne5wLw8QFp9bBjtRJd0k69ieM+CRG3oPxCiUWPjs1rJ3nBmv3BC1ixwsESm1+XHFl/+BebDqt1dBUpbbvAwTwv+dP0MVpeh4ART84y56N+n/lGI8T4DYEYEPjvjB4+eIJ3H5VYuC9mXiI9im3WePfj2M3E/+/RfNBvU2ezymvF1H+QKmjUrBLxg4OEYTISVRJBiz5Vi/iskSCujyckVYqDNIECUfS90FKFjHmYI9F/SQDhBWnovHFwL8b5bs7iu2dI7OP/56p7L9oLnwApCJmAE00KR8xU7tWVD7rTubeQ11vAroSAdHPzOkc35FYZ6i9F205PdHiQ2+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7dVnwcNbAj07S3XLwCbPSzdG9U3apaU4Ua1PHcl1ms=;
 b=BREduf1D8Y+x01Oekk3izHjcZC/ur9ESPDcGydPihlpjVQsf8uKOIUcVeJJas2M4CCFpVqvwsP5dPwZ2OztEd6E/xHuJBvkW7r1CKogsOP9wD8bntfv7Te30vqTF7I3KR8esMPFonRLD+UTF8dG2no6i0eJHEJ/La8Av+nXUQmBCUBQdvttAcl0xHt6n2NyBBaLTbGz/7QisEfgYa6sAihbMkK/c2zURcMqhZPLm6ihSDBm27p6c+d9zBM4oOsi4t1QMHwGnA4gEvv9jDe+/Zq4Kcfpcj3OXQ17fDBWI08aP9WnSfCNKjEFIqAt4h47Mt9jmX4NDv0a6ryQU4sQ7TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7dVnwcNbAj07S3XLwCbPSzdG9U3apaU4Ua1PHcl1ms=;
 b=C9DYLOTAdvsyI5jB214elja600XM+kX/c7xE/5Z3Y+nMQqC69VtkQSO5pPyantEyxa70F/5Dti7e/xbm8smwRVDDBcWEmA9gna91BHqbOm6CLGQEkFmauQyAI//kjV1vOU/2DwN+1atE1PJRZ5C008j+qDSDuS168qVAcwjSlVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH0PR12MB8128.namprd12.prod.outlook.com (2603:10b6:510:294::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 07:26:15 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%4]) with mapi id 15.20.9115.020; Thu, 18 Sep 2025
 07:26:15 +0000
Message-ID: <01c43f72-977f-4af2-89f8-cc54be414c6b@amd.com>
Date: Thu, 18 Sep 2025 09:26:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add missing comment for the new argument
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: kernel test robot <lkp@intel.com>
References: <20250918040923.3902445-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250918040923.3902445-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0419.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH0PR12MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dfa5a59-0464-4e06-dcc8-08ddf684a692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGs0Qk95SzJuMXpCOWd4QWRYbHVsU1Yzc1ZzU3BHTW5yQm93bGIxS2hyUDlx?=
 =?utf-8?B?dVdrU0J2K2FXb1lzdjNha3IzYnZUMmpURUdDSEF2NExvUFRNL3c4WitPVjBC?=
 =?utf-8?B?MVVVYmMyZWYwL0wyQW04VURIak41cWgzc2ZLcnBidFF4bFkyaUdWR1NPaG5h?=
 =?utf-8?B?Y1VlVytOZFRkRzhpeXBydEhLRXVGY2lISm9QNDlVb3lzc1FBckhzRzJYem16?=
 =?utf-8?B?SGNpVmJ6N3RYRE04TW5KM2YzSVRYdk5nZFhjb3pwODFyZlRkVHV6U3lXaGF4?=
 =?utf-8?B?YS8vUVMrSW0wcEMvOS9XZWVsLzVjaWRlT3hBWUZyQmJZMWpEMFdCT0hmWmxK?=
 =?utf-8?B?QitoaDI2azIzcTJBSmVpM2Z6dE01TnloN0drVnpxd3RlZ1NPalFZRGVLeksr?=
 =?utf-8?B?NVp0Qjg1RmgxY29XaEJHbDE1QTQ1MkZLVXg2MjMxYkN5R3JiY09CMElDRExB?=
 =?utf-8?B?R2h4UDI3YVI0bVA0LytsUDMvRE1ZaEljNDVLZk55bWNlSDFZQyt4K1VHK1Av?=
 =?utf-8?B?M2YxWlg4T3BDdGNwQndUNCt3dDhSY0hQZjJKOFZpTFRnTlJRTmZTa2ExU1dT?=
 =?utf-8?B?dWM1TS9tWEpzbnR4WVI3N29tQzZvZE1ZWEV5ODNWOVVBalUxU296Ny9YN1d1?=
 =?utf-8?B?RnpDVjVwMzg4VXhtVCtOTEhSbVdSTWQzYlpkbXg5Y0ZtNElxYkJzM1RBZHds?=
 =?utf-8?B?QTRLTDgzTVBhejZvM0xwNFJvK1RGcVZscGF0NEluRktNYmRiZysvWEp4UmRv?=
 =?utf-8?B?d0NXTGc4Rkgvczc1UTk4UGxQd0hab2N2RnhQdGxoU2UyVEJIbUhjZnVXbW1a?=
 =?utf-8?B?S2Frdi9FbzB1OG1JTE1zN1VCTjJxKzhCR3lNSndvOEpuQTVlTjJUTWsyMGNt?=
 =?utf-8?B?NXE0OHA4bERHL0t2ZlIzNDg2ekRJaXBoSGtsejNoenJUOGNLMXFRWEx3Z0FQ?=
 =?utf-8?B?Mm0rSldBakNhWlVqbDFTWmcrWGJlbVYxL0tNWE1CWE5DN3FEVmZFRTZiWEpq?=
 =?utf-8?B?LzViME0wOTFxcTluaVNlaVk4cWVLYXVNRzQzRHZLdVdyc1RHUjl0bWNjMHZW?=
 =?utf-8?B?UjNBcmZPK0VOUTNlNlg5TnRYNVlPNVFQckllS3BLOXF1b0R1MzJhV3dTUmhh?=
 =?utf-8?B?d2tmNStIU2Rubm8rSTBOd1pLdjJST2R1Wnk2NHBSaHpvalY3d0NGejhmOTUv?=
 =?utf-8?B?L2ZOSlNmL0pCTzB2RjBEaEp4STRDTEdvUW45UklLdHplUEpwMVI2RUhvMTE1?=
 =?utf-8?B?Um00a1hvZ0tvNmd2NjBOcEVhOHJ6STZRMDNtNlNKWUFQM1U5TitJWGkvSFNz?=
 =?utf-8?B?emdqTU14TUFqa0tuS0JWNzJKdm04UnFpNFUraStGem9wbkRyMm44MHB5VktM?=
 =?utf-8?B?bWRYaU1WOVpya1hNK1publRTZjVScHkwT2JoTWVkNXJQVjlLR05BaWowOS9D?=
 =?utf-8?B?cG90QUpQcVBwcXdUc0pOU3hSdzdVMVg4V0ZkYXZIMWovampHWUloUVoxcTky?=
 =?utf-8?B?UzZKNi9oWU96d2g5dUdDaGVvUEZjM25OcE5YajVQZDd2WnIwdkM2VWNYbW9E?=
 =?utf-8?B?S0JScDlSN2h4eFRPZ3UxSnpQZUw2STZFSFI0ZENHZm1SMjlUcFJvYXdPVGNj?=
 =?utf-8?B?d0RDZHBNQ1BOaENzcS82Y0JYSEppRlVnMDJIbkZlc0FHcGJDTHZuVEVZYVdm?=
 =?utf-8?B?QXJxV0duMWpzbjJKOVUrdWRiUjFxbHpJdW1CM21WWnpaVHVPaWVwQmVTTk9y?=
 =?utf-8?B?RnlMUUxadHpzODRPQ1ZxYkxkaXJEK21lRGFqTzBhdEV0L0xyMFNubUpXaG9D?=
 =?utf-8?B?Rk1VdUJ2emJiRytpeEhQNVRjZ05MUXlscnBwd1dCcnJxeFIweGRFQUlnU2hC?=
 =?utf-8?B?a1FjTjMzRllmQVFjblVEc1hkZnJxa2pjd1pXQ3dpc3NMQ2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDErdExlMnQvcWg4ZUdOSlNpS2VBT1d5WkV3OXdGa2lTeWNsOWErWHpETjJ4?=
 =?utf-8?B?NWYvRWNXcFF4UzFWWW5hN0JwQ2J0SXQ5K3padTlDQ1VBdHVNblkycHMvZXY1?=
 =?utf-8?B?WldaZ1Z5aUdmck1teVhqbms0aVNKT2p2d3dCeWxuQjZuVE93ZFVnc1hBQW0z?=
 =?utf-8?B?N1NoNCtNbU1JUDZWb3AyUS9WNjI0OCs5MHBYK2VoWlNyY2t3QXFzN09qWVVK?=
 =?utf-8?B?Yk5CR3dVblFDTnVxc3FJOUZ2WWRWNjhtY2k0SzYxVk5ZZk93eTRXQ1RLYlZl?=
 =?utf-8?B?dVhrT1EwYy9ROVY4VTlBZDZieHdnMEJ2NU4rMDJTZW82RkRpb3I0OXhpNDQ1?=
 =?utf-8?B?YzdTUzBZMUJpSUlSY2pzRzVJRlgveDVBcWRxeXZoODA5YUlxNXp2WmdwVm9w?=
 =?utf-8?B?V1p2bTByRE0wbklpRlNrY3FYaktnUU83UHNFSXJ0T2NRdkFncElJVzRMLzlK?=
 =?utf-8?B?K0p3alBJeE11dStrMGVmUENtVjU2WGF2dzZFN0xhbEJOWFNpeWM1TThiTUpZ?=
 =?utf-8?B?MFlvbTJGZ28rVFRwSG9uM215bFF4U0o4a2w3Tk9UdExtYkszU3FMTU40Qisv?=
 =?utf-8?B?K29aaEF0bk84SS9jQ0wwZ2RRUSt3WGN0VzRJTW90K3dLSUlSM0tHQTJ3bDlO?=
 =?utf-8?B?QS9mUHNRZXpiMVV0ZFdIMmhFdzFpRFM1Z2VvTFJKR0RtQlJDKzdtKzE2OFlU?=
 =?utf-8?B?MzhYRzJLYWtQRzJwSFdxSTE5aXJUcEFFRXh6ZGI5MXl1WEc3eHJ2UzlMSFli?=
 =?utf-8?B?b0dJRnB6TEZZd21vNmU1LzM5UXM1NDQyTS8rQXVwT2tySzZYNHdYejNKT0h6?=
 =?utf-8?B?T2RiTURjUW9sRWplWGZCeUlYWi9lc29NS1piSzFxUVdUUnA4QmJ3WDVRTzVP?=
 =?utf-8?B?bG9TN3R6bFdSR0liOVREemhZajVOS3MwZUNyaDFCSGdiYnlYck10ZkNEb3pS?=
 =?utf-8?B?aGNxZllhTjVLNHNQVUtYT0ppWEtvUHZaM281bDI4UnVhUGZKNGd5N3VQU1g0?=
 =?utf-8?B?UDhqWkNhbklVMlpPR296c2JrTjRDL0ljSkJleHJTVjV0dUZpa2twc2swalRE?=
 =?utf-8?B?aTl3bGFPNUdCbWJrOWVvMkgvR0pOY0hVUEQ3YjEwY1RUYm9qUmxTbi8xSUZG?=
 =?utf-8?B?Si9oSlRLbzNycXBTUmlKeDdRWklYUm1oNVJrdHc0U2NnQitadnB5V2NKcVk3?=
 =?utf-8?B?am5UU1R2d2ptT2hPOTBieXoxYm1yYnFtNVNYUlBTVkJpZ2kzWHpBenZWSEhV?=
 =?utf-8?B?aVZWS3dEdEdtU2tJQ0NKY1dQN1E1TDBnTWt5M0JDSzMxM0xkbUFqSUJZMzRH?=
 =?utf-8?B?YU91WW1yOTVlLzNFTWRJK05UcDArNGdqU3l6NUlxeWpZRlJtajhyV2J0Rkxq?=
 =?utf-8?B?MW0zc0NsdTVSUUF2RjZ5d2x3NFJNODNWbTAzYmNRa0lGK1YyazBMcjVvME52?=
 =?utf-8?B?MGYxQmUrQ3NzdzRFVnR4WkVhVGdxWVBJbEFrMTZqKzRDRTN2Y2JwNFBOUERr?=
 =?utf-8?B?Z1NsdzNOV29DenBMSFJ6M2FjVWJJTmZCSDV0SGJIOXlzbHNYemtwUzcyTzJ1?=
 =?utf-8?B?YU03U01rTVk0cG1zK3RzZUthMkZTMmsvY2FWQkppczRhRDgwWVJkeFhZeCtV?=
 =?utf-8?B?cmxhakUvZkxmaGtyTVNmeU52MVdtbkdocTlJL0xIWm5MdkFscHdtQXhENXhs?=
 =?utf-8?B?WWhzQlcxSHBpODJnNkYzR2pWZEJFbEg0U3NUYU9aY1BCcTJ0c0lMYlJOZEk2?=
 =?utf-8?B?VitLcGQ5R3F5LzNFUm1NWTBabEFVRnFjeTN1aWNQeWJCTlkvVlMrUkFhZXRJ?=
 =?utf-8?B?QnUycklIS05PR3VkcS9nODM5QzlSUGdoNTZtODVQbkM4RW53bEwyVkFiNWx4?=
 =?utf-8?B?ZXh3UkRFdmxnanJXQzR6UklrQVFMbXpwMTdXOVUzRUlLYWRQR3NGTTQxTVM4?=
 =?utf-8?B?YWt1SS9DYS82eDRRdFYzb1ozcUNzaGd2amxpdVcrTHg5a3BHbmU3VERvYmp3?=
 =?utf-8?B?TGo5dlpKOUptdiswRGRFZUFXWVowcVZFbmk1WU1WN1JYK0xhVTRDbkJ3c1cz?=
 =?utf-8?B?aUFoV2pzUldpOVdsbnplNGRId1hsTXlxTGhGZHNSSHcxdjJkRHFremJQNXlK?=
 =?utf-8?Q?3bY0at4YKvZc5WeKRhsnmPQn+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfa5a59-0464-4e06-dcc8-08ddf684a692
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:26:15.1948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+pX9wxu1sbYVps1rsZOkUM1/MdYrdvDcCTKG4mihBV8XYh3Hkh4hfJxmCH8+id7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128
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

On 18.09.25 06:09, Sunil Khatri wrote:
> In function 'amdgpu_vm_lock_done_list' update the comment
> for the new argument 'vm'.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202509180211.UAqME0zj-lkp@intel.com/
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index d0c95fb0ef81..1ccd348bf48b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -486,6 +486,7 @@ int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
>  
>  /**
>   * amdgpu_vm_lock_done_list - lock all BOs on the done list
> + * @vm: vm providing the BOs
>   * @exec: drm execution context
>   * @num_fences: number of extra fences to reserve
>   *


Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B83606A31D
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=y1mCA253
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA2C010E70C;
	Tue, 20 Oct 2026 07:57:39 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010048.outbound.protection.outlook.com
 [52.101.193.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20A1910E70C
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 07:57:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZcUjXf/YCUZVal8IFtc5vyhlpgBJWIW2jcT025bME4F0tX3X1YOWX5/DTeXPl+jWc7rr+Uzm8WnHS+OdmAZu88hKk/2jUnb+f4ivS59KjW2iEcLHVh7nkBvmeAlfEIvqJNLBnQTGtrHxRlsidzxqb4d5iGghqMdXpVMssTq8D7WwrinT792siKi3aOuRmRTG7ko8Ep1eaF75aIZ1fqLwpkIZbjsiox2ZFClqaPKKr+Q0V1R4VgjHZR5Duc2CPIP6fLEGzGldeMRccx4jHx/ksugsXGKi+Hd+sPqYdcdwoTzmlDuP6H2HRU9F4VTiOGcu4pJ+af+TAtfn7n3kxF/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYx/9w3iqJj9E0tv2Gu2+nYu9l+g50gE0ZJkU6qBrAE=;
 b=WVsgrj79yIipm7ZzYPzbPCUftSlAobdgwnW5tNH23h+xDpcCnEQTxRB2DeWE3YPw+VGxKYfhkImuZ5dUXMna7s5N3EQyxENUNU30MaqT86+Rn5It0OUqvYdCXnyEiDCO3WJIr77PyUSEC/X88WMAF1joyBg0IMTrAygkSc6lGK615TPUG7GID8GwXJq4bRDAEKlgQPmXgy6kmLFlF4Zr9A/4LX2GI4xVnb4vG79eRVbyfZdRHjbj049MvV4HiKWFaEOfeIPNk60RAK/G5zfo/LbOTF0cZg9wUuD4ZpMggL1xk/QvZM8YQuhbxNiMCa8KIhZCreIhzF7/v+7lNwIaGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYx/9w3iqJj9E0tv2Gu2+nYu9l+g50gE0ZJkU6qBrAE=;
 b=y1mCA253oFoWk4Uz2jYCs6ppdPVUhaZ2QoJkCblto/oQD0+jaBK2RpZcoRsg4HaWxoWU6Zo9uprF1KpygV3iYei6QWWqZ4G2Zl3P11B1dYX7uyplt1WfpOQYIYuV423zAoBfPTemazGChc4UrCmbT0THAi6oVxO1L821oUzEgcw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV9PR12MB9784.namprd12.prod.outlook.com (2603:10b6:408:2ed::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 07:57:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 07:57:28 +0000
Message-ID: <d8c28fb8-eebf-430a-808a-adcb473f7307@amd.com>
Date: Tue, 20 Oct 2026 09:57:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] drm/amdgpu: stop GPU recovery wait for the JPEG/VCN
 idle work
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Lijo.Lazar@amd.com, Vitaly.Prosyak@amd.com
References: <20261019064838.2577746-1-Prike.Liang@amd.com>
 <20261019064838.2577746-7-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261019064838.2577746-7-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR10CA0023.namprd10.prod.outlook.com
 (2603:10b6:408:143::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV9PR12MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a4c2282-069a-4b94-e29b-08df2e7fc90b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|5023799004|11063799006|4143699003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261009223327099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: FUEf4dWmJxOzCFDMz41t463wgO9CbDusxokr7jqPWMvuUyDugtKjwXJ6sZWslJe0gtQZQ4hFcLx18RknGz2RvL2se4038zQL1m5MdVStaCfls9hdj3cNfxhrp1h7hMqr+Lr+shPRE23oDFcl3iLzvhCKPBTo43WM81Uld6pIn82+bLQdMNz6WLTKMYkEt+87Pv4U9ETq+dCGH4jl2l6V+UYu64HTpmJa81pUqGjO1e9GTkGoizVSe/yMrAcVX5YmxryOubKmZIm2UsUBbUbSdIN2o9qcvLONp0uNN23qJbKurU17TcQJghJwFPaBeSwQDDnucGj34oXfLw10MndW3Qnm5hrHQ8RTNOGRPgfQUza3dqyuYUq/8yuNa8pNg4IAd7mLvyKuepl/swf8k8XKEpTs3PGL5OyepnxvIRu6aZbxc4pTyW31qBdoJqEofSAjxf2mGqr0r2q8+39wbcMJmQ6eJAU2VLJDGGYlVH2UJKrxZFPU1Fy/8dKkI6pxoG7A02sf8lHegxP2B0u4mOtM+W/vIgL9ffU8g409m3dVerU73t6zOXuqaUa14R5v7GgEGSl2TBZStHpC2zOTZScVGCnQb8qR6iuMXnYXrf7e6Nk7eLEWmzUwnksav5AAoHwbzR+l6oGXLz/hyzm3KxPizGmPzr6Zl5n0RlJkDshcY9c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(5023799004)(11063799006)(4143699003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261009223327099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2c1YWhsZUNKSGZIS1ZRRjlYWXNDQlBneWRrdG5vdDJORXZGd2wwM1NPVENN?=
 =?utf-8?B?b2trZUJEV3dJMjJScmxjNDNQK0hKcGloQW81MUJzYlZJOFk4VVUvd0NVLzV4?=
 =?utf-8?B?cFBBc2ZWL1dDbHhzQ3BiQllrYTVkU0pabVhESEl2eFVic29heWtzOE5vbXpD?=
 =?utf-8?B?UHk3MTA0WkdCVHVWSGV4ZUw3TEhBaUxjSk43T2Rob3k4dTZaUm1sQkZNRGRT?=
 =?utf-8?B?TTJwK2ZKdU5EOXRXU2xQUVZKd0hzS294Z0lDT0hHcVp1dnlNWGdDU2ZtSmcz?=
 =?utf-8?B?cllRanY4ZTRjMFBLOUVObUpPUmFYTGRqSk80SUtFSUJMWWlkaitHZW9Eblpx?=
 =?utf-8?B?Q2RaK0hMRUFDb1h4VlJDNUxrdkVvV3dRaGN4ajhWRzA3dGd2TWtTallWcDl4?=
 =?utf-8?B?YjRpSjNlUzZ4Z01OSnJPVFd2LzVyQ2xPMlM5ZGMyLzV5Vnk3UFRPNnAzUkp3?=
 =?utf-8?B?M1BKSm96MVB0bEYvelQvVHV6dTZDb2RsQ29tTXVrNDhIY054T3hCdXgrb0NF?=
 =?utf-8?B?U2JNMm04elY5UFl6N21PNDZjOGhQa21pN2syQTQ0KytjZUplbGMzdzVZUlg1?=
 =?utf-8?B?cDJER2plQ0JWQklFMVlXRndoNlFwUFIybmRZNUwzQkhrUjR1SFZGUm5hUnVB?=
 =?utf-8?B?cE1MWlUzclkxSktEbWx1cGdCaTl4eVdTZDIwOXdWNFlmc0x0c3YzQnBZYjdk?=
 =?utf-8?B?TWNKd2ZaMm4zbmQzNkJoUnZTRklVOFFOemNWV0FnckxFZjdFUWY4WHJkVVdW?=
 =?utf-8?B?YzVRdDdweC9wSXhnb3RZaGFoQXJsVjlzTC9xTEZ4ZDM3YVg5Wmo1RU9DN3lJ?=
 =?utf-8?B?V3h6VEpVaFFBbTFFS1N2RDNwb2djWlhSMHVrRE5rNWtSbTJ1MWpTZitnTXdP?=
 =?utf-8?B?dXcrOVpETmNCVUFyUXAvK2J4WkJIQWl0WnpoRVFjaGN6eStlWVp6NWNvb0pw?=
 =?utf-8?B?cWIzYlNaTndWTnR3TmpQRHRHbmxOQXcrVEhLMGNZSmNHRzk2L044TXZNUXBM?=
 =?utf-8?B?V2ZiZGRwcjN0ekUwSmdEN2phaXA4M2dhendzQUVxZld1OGluYStxdWgzVVJW?=
 =?utf-8?B?ZDMwRHRxSGdGeUNnZk9hTTJrZW5jUDNUa3ZvV1ZTbFN5NnJLTkJBSTU2cWFZ?=
 =?utf-8?B?TStDdzI2THVSQVZ6WFExMk1aWkNDc20xNk04bkdXV1RUbERab2x0d1lkSVhp?=
 =?utf-8?B?ZnRRenI4Q25Dd0QwVHY3VkRpL0N5RnNmaG5pMnpXaHNSdjJqNGJDSEdFSk5w?=
 =?utf-8?B?WkExRU1jcURsT2xVa3hidkxRUGRNUjFoNC9palY3UU5pc2pIREEzbVF3ajNF?=
 =?utf-8?B?NmpzeWNvaXZ2MjJTc2dLVXgzc28wUG9Yc2lRSnliZ0haSkRXQWN3UU1uZVIx?=
 =?utf-8?B?Y3d0amk0YTF3MlhUSm12b2pzNmxESjF5MWhlYmJDOVZxK3F1MGhtZXUxTy8z?=
 =?utf-8?B?YUR1bUpaOU1vQS9JYnhIV2tVTmwxRzRmcVFhMzkvNFVxL2x4QWx2TWp4TkhK?=
 =?utf-8?B?Wm1zeTlsSUxkQ2Z6WlBReldPNGV2bEFzSk8xcXd3OXJHL3prWHZTemhocUdk?=
 =?utf-8?B?V3Z0Mm9vZVdWM0ZmcUhwWWkyYysrRFh1d1JpOXhFTkU2Rmc3TmxMUk5HMHc5?=
 =?utf-8?B?elF5Wmo3Wm9WZnhVTHBXanY1RzdnTjZLcmJkUGFrd09mRFVNZWhxN2dVYUJB?=
 =?utf-8?B?VXczU0x5YzgvQ1FtTTNOWlFPenBZei93RisrT01kZm11dnpuYkFkWmJPUmNX?=
 =?utf-8?B?ZXdqeC84d1ZLU0ZjOG1DT2c4MEJwWERXNm42bElRTUhNUFdqbEUwWTFuOWth?=
 =?utf-8?B?c2F4em8wUXYydWUrRWxROHZ4V2x1bkZyNG16S2lFRkVIeGVKZUZ5RElXQ0pT?=
 =?utf-8?B?dUNWOE9aMjBXZ1JPdDJzUEhmaERQTDdVY2M4TVZvL3JLam50VEk2eWF3NE0w?=
 =?utf-8?B?bkJQd2s1eW5KNVdQRU9WWEJQV01QSVFTU05iT1BQRjlXaS8yVkxtaEx3eVY3?=
 =?utf-8?B?REVuSUFYc2VYdzJnbEU3a2M0dUhXQy9qQ3VqNWFYQTRObEU1ZFdmSUVyNEpT?=
 =?utf-8?B?RzhBdzlubCtpQzVQWXRmbUhSMDRaS3Q4QXlaNlpPTzZZcThlVVhreHFxNHVo?=
 =?utf-8?B?QVFOcU42aGR3RUY0YkMxNmNLZ2pXQU9FWWszdnJUOVBqbHlqOFB4NEFEVW1r?=
 =?utf-8?B?L1NYeGRiTnpPSjhSSEoyNnJyRyt0ZDlhYXpHV2Jkc2pMN0d3MnRFV3RRWUxS?=
 =?utf-8?B?MmoxUjlmcEpObVJZRkJLNDhRMldXa2V2d3o5dnhPVnlja2JKQWxaYnFsK2pU?=
 =?utf-8?Q?GYR29MUGPB14SAjk3y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4c2282-069a-4b94-e29b-08df2e7fc90b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 07:57:28.0347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WtkxiOD9hOaG08siHncYDTT/O+eVCSOp7MUGOAcgg11HIrMS05CT2YPlXSBVRw4g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9784
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/26 08:48, Prike Liang wrote:
> The common JPEG and VCN idle workers program power gating and DPG pause,
> so they must not run while a GPU reset is in progress. Recovery must not
> wait for them either, since everything the workers depend on then
> becomes a dependency of GPU recovery.
> 
> Cancel the idle work without waiting in hw_fini/suspend and begin_use,
> which also run during recovery. A flag set under the power gating lock
> keeps the worker away from a block that has been shut down, until the
> next begin_use. The worker gates, drops the power profile and re-arms
> only under that lock, so nothing of a running worker can touch the
> block once the flag is set. Only sw_fini cancels synchronously, and it
> never runs with the reset semaphore held.

Yeah that is more than a bit hacky.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 36 +++++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 39 +++++++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h  |  3 ++
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  4 +--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  4 +--
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  |  2 +-
>  24 files changed, 88 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index 87f879a2e4f4..a8a529e8eb53 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -74,6 +74,8 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
>  {
>  	int i, j;
>  
> +	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +
>  	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>  		if (adev->jpeg.harvest_config & (1U << i))
>  			continue;
> @@ -97,7 +99,11 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
>  
>  int amdgpu_jpeg_suspend(struct amdgpu_device *adev)
>  {
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	/* Never wait for the idle work, this also runs in GPU recovery */
> +	cancel_delayed_work(&adev->jpeg.idle_work);
> +	mutex_lock(&adev->jpeg.jpeg_pg_lock);
> +	adev->jpeg.idle_disabled = true;
> +	mutex_unlock(&adev->jpeg.jpeg_pg_lock);
>  
>  	return 0;
>  }

That won't work like that, nothing prevents the idle worker to be scheduled and starting to run directly after the cancel_delayed_work().

I think what we should do here is just this

if (amdgpu_in_reset())
	cancel_delayed_work(&adev->jpeg.idle_work);
else
	cancel_delayed_work_sync(&adev->jpeg.idle_work);

That is save because amdgpu_jpeg_idle_work_handler() takes the read side of adev->reset_domain->sem and when we are inside the reset we already hold the write side of it so a running worker will block for the reset to complete.

Regards,
Christian.

> @@ -114,6 +120,17 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
>  	unsigned int fences = 0;
>  	unsigned int i, j;
>  
> +	/* Nothing holding the reset semaphore waits for this work */
> +	down_read(&adev->reset_domain->sem);
> +
> +	mutex_lock(&adev->jpeg.jpeg_pg_lock);
> +	if (adev->jpeg.idle_disabled)
> +		goto unlock;
> +
> +	/* Check submissions before fences so a concurrent end_use isn't missed */
> +	if (atomic_read_acquire(&adev->jpeg.total_submission_cnt))
> +		goto reschedule;
> +
>  	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>  		if (adev->jpeg.harvest_config & (1U << i))
>  			continue;
> @@ -122,13 +139,17 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
>  			fences += amdgpu_fence_count_emitted(&adev->jpeg.inst[i].ring_dec[j]);
>  	}
>  
> -	if (!fences && !atomic_read(&adev->jpeg.total_submission_cnt)) {
> -		mutex_lock(&adev->jpeg.jpeg_pg_lock);
> +	if (!fences) {
>  		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
>  						       AMD_PG_STATE_GATE);
> -		mutex_unlock(&adev->jpeg.jpeg_pg_lock);
> -	} else
> -		schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
> +		goto unlock;
> +	}
> +
> +reschedule:
> +	schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
> +unlock:
> +	mutex_unlock(&adev->jpeg.jpeg_pg_lock);
> +	up_read(&adev->reset_domain->sem);
>  }
>  
>  void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
> @@ -136,9 +157,10 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
>  	struct amdgpu_device *adev = ring->adev;
>  
>  	if (!atomic_fetch_inc(&adev->jpeg.total_submission_cnt))
> -		cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +		cancel_delayed_work(&adev->jpeg.idle_work);
>  
>  	mutex_lock(&adev->jpeg.jpeg_pg_lock);
> +	adev->jpeg.idle_disabled = false;
>  	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
>  						       AMD_PG_STATE_UNGATE);
>  	mutex_unlock(&adev->jpeg.jpeg_pg_lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> index 05d58e6bbfab..1dc86d8c9c8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
> @@ -137,6 +137,8 @@ struct amdgpu_jpeg {
>  	struct delayed_work idle_work;
>  	enum amd_powergating_state cur_state;
>  	struct mutex jpeg_pg_lock;
> +	/* the block is shut down, the idle work must not touch it */
> +	bool idle_disabled;
>  	atomic_t total_submission_cnt;
>  	struct ras_common_if	*ras_if;
>  	struct amdgpu_jpeg_ras	*ras;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 34e1242d66ea..1b8e1c456161 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -269,6 +269,8 @@ void amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i)
>  	if (adev->vcn.harvest_config & (1 << i))
>  		return;
>  
> +	cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +
>  	amdgpu_bo_free_kernel(
>  		&adev->vcn.inst[i].dpg_sram_bo,
>  		&adev->vcn.inst[i].dpg_sram_gpu_addr,
> @@ -459,6 +461,15 @@ void amdgpu_vcn_put_profile(struct amdgpu_device *adev)
>  	mutex_unlock(&adev->vcn.workload_profile_mutex);
>  }
>  
> +void amdgpu_vcn_stop_idle_work(struct amdgpu_vcn_inst *vcn_inst)
> +{
> +	/* Never wait for the idle work, this also runs in GPU recovery */
> +	cancel_delayed_work(&vcn_inst->idle_work);
> +	mutex_lock(&vcn_inst->vcn_pg_lock);
> +	vcn_inst->idle_disabled = true;
> +	mutex_unlock(&vcn_inst->vcn_pg_lock);
> +}
> +
>  static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>  {
>  	struct amdgpu_vcn_inst *vcn_inst =
> @@ -470,6 +481,17 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>  	if (adev->vcn.harvest_config & (1 << i))
>  		return;
>  
> +	/* Nothing holding the reset semaphore waits for this work */
> +	down_read(&adev->reset_domain->sem);
> +
> +	mutex_lock(&vcn_inst->vcn_pg_lock);
> +	if (vcn_inst->idle_disabled)
> +		goto unlock;
> +
> +	/* Check submissions before fences so a concurrent end_use isn't missed */
> +	if (atomic_read_acquire(&vcn_inst->total_submission_cnt))
> +		goto reschedule;
> +
>  	for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>  		fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>  
> @@ -490,15 +512,17 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>  	fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
>  	fences += fence[i];
>  
> -	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
> -		mutex_lock(&vcn_inst->vcn_pg_lock);
> +	if (!fences) {
>  		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
> -		mutex_unlock(&vcn_inst->vcn_pg_lock);
>  		amdgpu_vcn_put_profile(adev);
> -
> -	} else {
> -		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
> +		goto unlock;
>  	}
> +
> +reschedule:
> +	schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
> +unlock:
> +	mutex_unlock(&vcn_inst->vcn_pg_lock);
> +	up_read(&adev->reset_domain->sem);
>  }
>  
>  void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
> @@ -507,9 +531,10 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>  	struct amdgpu_vcn_inst *vcn_inst = &adev->vcn.inst[ring->me];
>  
>  	if (!atomic_fetch_inc(&vcn_inst->total_submission_cnt))
> -		cancel_delayed_work_sync(&vcn_inst->idle_work);
> +		cancel_delayed_work(&vcn_inst->idle_work);
>  
>  	mutex_lock(&vcn_inst->vcn_pg_lock);
> +	vcn_inst->idle_disabled = false;
>  	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
>  
>  	/* Only set DPG pause for VCN3 or below, VCN4 and above will be handled by FW */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index bea95307fd42..d4e7d3e27054 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -323,6 +323,8 @@ struct amdgpu_vcn_inst {
>  	uint32_t		vcn_codec_disable_mask;
>  	atomic_t		total_submission_cnt;
>  	struct mutex		vcn_pg_lock;
> +	/* the block is shut down, the idle work must not touch it */
> +	bool			idle_disabled;
>  	enum amd_powergating_state cur_state;
>  	struct delayed_work	idle_work;
>  	unsigned		fw_version;
> @@ -526,6 +528,7 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev, int i);
>  int amdgpu_vcn_resume(struct amdgpu_device *adev, int i);
>  void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
>  void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
> +void amdgpu_vcn_stop_idle_work(struct amdgpu_vcn_inst *vcn_inst);
>  
>  bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev,
>  				enum vcn_ring_type type, uint32_t vcn_instance);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index 72069b77f6f1..b048fd4b8b59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -177,7 +177,7 @@ static int jpeg_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>  
>  	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>  	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 2968256d4cd7..f6a9258ae3ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -239,7 +239,7 @@ static int jpeg_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int i;
>  
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>  
>  	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>  		if (adev->jpeg.harvest_config & (1 << i))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index 564e40899df2..922711aa06a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -192,7 +192,7 @@ static int jpeg_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>  
>  	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>  	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index b29ca3a49939..fe7ab9cb35bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -221,7 +221,7 @@ static int jpeg_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>  	if (!amdgpu_sriov_vf(adev)) {
>  		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>  			RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 0343a64595f2..f4896ad9d1de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -455,7 +455,7 @@ static int jpeg_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int ret = 0;
>  
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>  
>  	if (!amdgpu_sriov_vf(adev)) {
>  		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> index 4da3f9c995c1..87efc3c2b9e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -250,7 +250,7 @@ static int jpeg_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int i;
>  
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>  
>  	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>  		if (adev->jpeg.harvest_config & (1 << i))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> index dcdb089b4308..91968ad26f17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -189,7 +189,7 @@ static int jpeg_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>  
>  	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>  	      RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> index f2debf6b6bd0..27116d1e9e64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -326,7 +326,7 @@ static int jpeg_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int ret = 0;
>  
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>  
>  	if (!amdgpu_sriov_vf(adev)) {
>  		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> index dd0abce73687..7e068c2d4d6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> @@ -299,7 +299,7 @@ static int jpeg_v5_0_2_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	int ret = 0;
>  
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>  
>  	if (!amdgpu_sriov_vf(adev)) {
>  		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> index 8ddd12740a04..16daeb61114c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> @@ -172,7 +172,7 @@ static int jpeg_v5_3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  {
>  	struct amdgpu_device *adev = ip_block->adev;
>  
> -	cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +	amdgpu_jpeg_suspend(adev);
>  
>  	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
>  	      RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 76793a5caa70..470d8f110799 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -150,8 +150,8 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
>  	if (r)
>  		return r;
>  
> -	/* Override the work func */
> -	adev->vcn.inst[0].idle_work.work.func = vcn_v1_0_idle_work_handler;
> +	/* Own lockdep class, this work is still cancelled synchronously */
> +	INIT_DELAYED_WORK(&adev->vcn.inst[0].idle_work, vcn_v1_0_idle_work_handler);
>  
>  	amdgpu_vcn_setup_ucode(adev, 0);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 7d2b9e4b913a..cbc67fdee9ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -322,7 +322,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  	struct amdgpu_device *adev = ip_block->adev;
>  	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
>  
> -	cancel_delayed_work_sync(&vinst->idle_work);
> +	amdgpu_vcn_stop_idle_work(vinst);
>  
>  	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>  	    (vinst->cur_state != AMD_PG_STATE_GATE &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 10ef5616b2f5..9dd4c313cbe7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -304,8 +304,8 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
>  		if (r)
>  			return r;
>  
> -		/* Override the work func */
> -		adev->vcn.inst[j].idle_work.work.func = vcn_v2_5_idle_work_handler;
> +		/* Own lockdep class, this work is still cancelled synchronously */
> +		INIT_DELAYED_WORK(&adev->vcn.inst[j].idle_work, vcn_v2_5_idle_work_handler);
>  
>  		amdgpu_vcn_setup_ucode(adev, j);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 0f4f4d66e2e4..14a19d286db0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -449,7 +449,7 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  		if (adev->vcn.harvest_config & (1 << i))
>  			continue;
>  
> -		cancel_delayed_work_sync(&vinst->idle_work);
> +		amdgpu_vcn_stop_idle_work(vinst);
>  
>  		if (!amdgpu_sriov_vf(adev)) {
>  			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 4b7f7bbe18da..6543d1454be4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -374,7 +374,7 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  		if (adev->vcn.harvest_config & (1 << i))
>  			continue;
>  
> -		cancel_delayed_work_sync(&vinst->idle_work);
> +		amdgpu_vcn_stop_idle_work(vinst);
>  
>  		if (!amdgpu_sriov_vf(adev)) {
>  			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 3f39aa83c319..204504e10988 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -417,7 +417,7 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
>  	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>  		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
>  
> -		cancel_delayed_work_sync(&vinst->idle_work);
> +		amdgpu_vcn_stop_idle_work(vinst);
>  
>  		if (vinst->cur_state != AMD_PG_STATE_GATE)
>  			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index f30f80c1b07f..7823594e808a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -327,7 +327,7 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
>  		if (adev->vcn.harvest_config & (1 << i))
>  			continue;
>  
> -		cancel_delayed_work_sync(&vinst->idle_work);
> +		amdgpu_vcn_stop_idle_work(vinst);
>  
>  		if (!amdgpu_sriov_vf(adev)) {
>  			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 7b7c3bc9f046..c2b87b0783ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -291,7 +291,7 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
>  		if (adev->vcn.harvest_config & (1 << i))
>  			continue;
>  
> -		cancel_delayed_work_sync(&vinst->idle_work);
> +		amdgpu_vcn_stop_idle_work(vinst);
>  
>  		if (!amdgpu_sriov_vf(adev)) {
>  			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index c9e990ab297d..537e56f32aad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -364,7 +364,7 @@ static int vcn_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
>  	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>  		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
>  
> -		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +		amdgpu_vcn_stop_idle_work(&adev->vcn.inst[i]);
>  		if (vinst->cur_state != AMD_PG_STATE_GATE)
>  			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> index ed47ddd5b08c..dbda56c7c534 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> @@ -279,7 +279,7 @@ static int vcn_v5_0_2_hw_fini(struct amdgpu_ip_block *ip_block)
>  	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
>  		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
>  
> -		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +		amdgpu_vcn_stop_idle_work(&adev->vcn.inst[i]);
>  		if (vinst->cur_state != AMD_PG_STATE_GATE)
>  			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
>  	}


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D76C88CB4
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 15:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1C5110E1FF;
	Mon, 12 Jun 2023 15:08:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02DE410E1FF
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 15:08:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClMvJ6DYr1/VEw9COUkjdTREUTykkF0DxnQBkG67Y0FVUmrTuqVij6TpmL6ZlLsQcF8yMthcD5CYjPxyIcidkHD0GKRMs4S5Uv2eOaMq4s/wqJwfp0brT5B4eZ1JEickezfLUALe0hoSb9qGRwiuGMwIwQDOIuI6fKSVRro+L7YF7/6wT6P77rFHoBYDJvcM6qoydjZNG3rCcgd4tDSCGwd4+dfjfTzuiwomhV0hPlhu3J2SsN5XjqTi0kTy5qOBHIq6rXWBwPml4OJcbHgtTONiCw2UPEryoEM7KXkLWbjmmIW75fNdALPJesMGxSvc+lRQFeivX/qcZDuEUivMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCcK7jjhY2MaGDHQ3UndpM6jFJmtM0qXYiImKaNxmuA=;
 b=THPwb680bgrLNDnbfXvx+eylbjNDbqxKO4bc3ldFe2pv6k1xV2bdLrNB8i46XcocB/czihbdZf0+AS+76TcSDjacXhPH9LRdbKc3aAy6jZs4qEfjvTEGwS4gjt07lSBSSeOw6JGb0vfNN/AMdEj3GIoegLzTLeVU4QiAPggk7Q897zjrl0/SSI/7hEQ9N1Q5F7eh/JuEhnpOW1IPMsFbOxEKhMiCSjbdXnNEhM0n20+9hDUmrZ8ppAzjILg3UqFg+owyYhOQJ5LmY167F9lUYTKTsV00N/zAubkrN6jmfrx48xaXGvzRHGLzGTPIy8Fxfjk3fJJjLt4aJ7UeYRpezQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCcK7jjhY2MaGDHQ3UndpM6jFJmtM0qXYiImKaNxmuA=;
 b=wM3p7ZaAkJ0S3WQcFIF6EirRs2FD1JovnR0osGQ2ujWR6/6l1AP//lIjNnjMxR3SDGC7B5NdnTKRHUDq2nF/SHKJks2QwMuwZ+f6SgGTKfOWtlJeylrpwcnxhpt/zsc/FGgysLaDZ4W68UwZtUdEum0lF+ufAeW1vZH8lVjbgz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by PH8PR12MB6961.namprd12.prod.outlook.com (2603:10b6:510:1bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 15:08:40 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::4666:2db3:db1e:810c]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::4666:2db3:db1e:810c%7]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 15:08:40 +0000
Message-ID: <5e16bb94-8ae8-1284-eed7-80d06154fd07@amd.com>
Date: Mon, 12 Jun 2023 11:08:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/amd/display: don't free stolen console memory during
 suspend
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230612145512.752279-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20230612145512.752279-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::37) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|PH8PR12MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: 167fedf7-777a-46ff-a2cf-08db6b56e786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iyT6ViKYPwdULcnBzR1YncTnPcYgFUWaLPCLc4l+Pi5Rig6GqtJpCf0oeBgnuGXf3EPVu8TdKaucNsjqxEPgN+Mj0Zi5W43zWBu0NuVhUCRWnaPq8K8fAjoVoCgIZGUfaDlefWcTKPsp3OOi769r4l5mHN3Zj7bZwVGdxIxJ/bgDuK7btykqVuEo0Cb9Aclyft560+DtK8IjXj14ambMSfyEewCSAz9/HLSNx8MgzsCOQjhMcJjowFIw+UBy6kHUk50V/d2ma1eCk+lBycYAE6d+zBA2HKrKnj6GeUFbTE3mFTLb0HvAH3PIm+KVFepTpFA55Cbw6BnmNlmjj6XBkiO6M/o5wsNkX6BQJa4EuNAoB7mLoVgH2l4YZa5Qjae7yX2SjfdgAFT+xR4g8ZjwyIHJCnJrH04MZGZ8dhpIQBtgVjjwDf0aSxKDXZqj2nPzbNmWi81cu3QHF5FyWmxpj0N4JvdFhIOfOE8KJ09ivmh7JttmQJeOOrwch1BsnaHn8+ZrBr0VxKeRa0mHwjD/CRgNPm4uAQScwetLYmpupYBt+Pa/0KzUjTftpesQ62RyOkhijTOikqEhmb0IxWotZtjl9br70dXx8VvDdAM2vO4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(36756003)(31696002)(86362001)(2906002)(44832011)(15650500001)(31686004)(966005)(6666004)(6486002)(186003)(83380400001)(6512007)(6506007)(26005)(53546011)(66946007)(66556008)(66476007)(316002)(2616005)(38100700002)(478600001)(5660300002)(8676002)(41300700001)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2RYRS9BRFlpU2VCVnF3N3BvcHExWHJ5WEx1a09vRSsxOVlVaFJCdzdSRW1v?=
 =?utf-8?B?bERlLzhRNFk4UXVtNm5ITmNySUpwVHFHTjc4UkhyZXZXbzZKYjQ4VGk0dzZP?=
 =?utf-8?B?WHhVTHc2bjJ2OFJkMU1yZGhUR0xMcFZMblZRcW5jWnlFWTd0UU1CelZrYlVj?=
 =?utf-8?B?UUo5ME1Ec3JhZ055OC9YWThyd0RTSHNQYk95UFVpM0xmSlM2eXNFVzcwOXpV?=
 =?utf-8?B?SGcxRUdGWHVCYlpKKzRRaGZsM25BemdHaFFwR1FROEZsQ1FCZk9EZWFQb0ts?=
 =?utf-8?B?TWppT3dEQlVkdU9RRWZyTUY0aFRnUzRBbVZIcFJhdHVHdTlPNWhOU1JSL3lD?=
 =?utf-8?B?dmltaDBEdkkxKzZpZjcwV0hjMWpKbytwN0pkYXR0VFNnbGYvMzhKNHg4ZGpv?=
 =?utf-8?B?dVZBVGNxSTBBVVY3TGpRU2s0MTdEYXlLb3lnVng5TVF4VUw5d29SSHNUenVt?=
 =?utf-8?B?enZtZnQwM1Y3WXZoSXhGUm4zbjNhV2pWNGRHUlcxbm82NFo5Y2ZYMUFCTHdL?=
 =?utf-8?B?S2Y2ZTI4djJUeUJzUFJzTUY5bU10bUN3YlpFZG9TSHM5VDhnMGhYcVVRK0U0?=
 =?utf-8?B?MFZsNXRRMEc3aXJFUHRsclBtbXNnR1hvekNHUmNCWHdadkphRWM1TXROZEYy?=
 =?utf-8?B?dWNEaWxoK245aXA4VDhDeXFrSGxjejhxVzJKT1VhWmlXMjk4QnpjQzMwdnNR?=
 =?utf-8?B?dGwxeFlaWEdNZk9MdUdrNlVEWlBXWHVXbU8vaUhjcnpTWkM3L25Md1d5QlZs?=
 =?utf-8?B?MUxSVFhsWWN2RG9oOGliSy9VbDF2Vm9zRitzcE12U1pEZGtBL282cEFTVk1W?=
 =?utf-8?B?VUYvYVJ5ZEpDeVlMQmxQSVk2YWM2SHEyYmtwMi9ZMGd0ZEplOW5Ed21UTVBp?=
 =?utf-8?B?bmppZW5sNlJRZFdxZjJzTkJ6WVhWQzdDODRmWUdhOGxVSzFwbzRwZG9NNDls?=
 =?utf-8?B?VjUxU0doRVJBMVRXMU5qays3UHBDTXBhSlZKeElzMmY5a2puQUlNQ0ZUbGNi?=
 =?utf-8?B?RFZadDkxaFROQ0RuSzY2QXZuazU0eWhMR2hDN2hubE9HMHpFMG1qZnZYUitv?=
 =?utf-8?B?ZlVmU0JuV0lWM0dzN09UNzNYQzcxWmt3UzR0eExQZDByeXdOVW5GazUvVVBS?=
 =?utf-8?B?QjlFYnlVeXU4bnBpcU1HNUsxRmQzbHhSTktLdFdiZS9yN0ZxTEJOd0VTdWNw?=
 =?utf-8?B?aDNkcHpNUi9hOUpZN21tS1VTSVQvRG1qWE1ibEVWUC8vS1lFOTY4MDhzWEh6?=
 =?utf-8?B?cDdIamJJWTM0SWo1WnBRejJjbVNrRlVZdjZEUlpjZWpCRU9iSFp1K0VzSm42?=
 =?utf-8?B?UzN0ZGFFWjhKRVJJWFIyeGQ0Wk4vM1lxUFljZFdkOTUrd0tUN2pUWkRiN3BJ?=
 =?utf-8?B?S1hBWWRpUTBVVXBscHFVL3IybTMza0ZiaWZXcXh4YjRIcnFmMnZZektvbyt0?=
 =?utf-8?B?c0RvMGo0Z0RtT3F2M2x5SWc3TGYyb1JoV1lMb3IwQzAvS0t4bllFeUJqc24w?=
 =?utf-8?B?Y3lOZU10TlRiRFdSak9YSEFOSHdmTE1LcVBCY3duMUc2R2tjR3l4YU5RRTQ4?=
 =?utf-8?B?V0RSdnJnV0tCU2ZZNE5wNjJZaG53NUptRWF5Z2Zjc0hVOXBqd1psbEdoV2VC?=
 =?utf-8?B?TVQ5WVE4aVJwUlRUekEzVnR2ZHJHY3VQMkhEQkRyaGQvZllEMDZNMzQ1QVc0?=
 =?utf-8?B?a3EvWGlHcEVraHYrSXBxZng3QnpEaTNyNnhoY0Y0aEt4SUtMYnc0bGVDdzRN?=
 =?utf-8?B?K05RZWN3TkdCTnlkbGF0YnNwdHQ1djFQQ1NRc2NnUVdiN1VGYWVLU0FCNU5G?=
 =?utf-8?B?TFpiWUJ3YkVldXIxUU9Wd3RpUjh6NWR2L3UySm9mSkpXbHlxTHduY0JmaWhI?=
 =?utf-8?B?NmNhckprbmR4UCtQTHhvWk03TWlraThaZFZNdTE1N2xmRGNqZEk3SjMwcXds?=
 =?utf-8?B?SEdVWk9yUU1EVEN2dTJkNHJtSGQrSHQ4QXpGUU9NM3ZoUmRBNnlPaThHODRL?=
 =?utf-8?B?Z2lTR3dCY1ZUem1LL2F3RTNjTVdQWGZrMUY4RUlWZUhLU3ZrQlc4ZVdZZXVC?=
 =?utf-8?B?KzdGVCtPYlVlM0ZzNkR4MTBtNWRPTy9DaUR6VXVtbW5DQXdXZ0pPQXlSQisz?=
 =?utf-8?Q?G0CcbuGu/ABxaHXUVUs5ZWnON?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 167fedf7-777a-46ff-a2cf-08db6b56e786
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 15:08:40.0260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyIGhjLopPyMyguB4RuNPQz7DiX8OWgJ8ir293b1ChrF1t8z0l70vqeuuejZ0s7e9j8bwiX1hefYPs6kmUyFDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6961
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



On 6/12/23 10:55, Alex Deucher wrote:
> Don't free the memory if we are hitting this as part of suspend.
> This way we don't free any memory during suspend; see
> amdgpu_bo_free_kernel().  The memory will be freed in the first
> non-suspend modeset or when the driver is torn down.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2568
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 0454e94d5680..fc0dd31785cb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8963,10 +8963,17 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>  
>  	drm_atomic_helper_cleanup_planes(dev, state);
>  
> -	/* return the stolen vga memory back to VRAM */
> -	if (!adev->mman.keep_stolen_vga_memory)
> -		amdgpu_bo_free_kernel(&adev->mman.stolen_vga_memory, NULL, NULL);
> -	amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory, NULL, NULL);
> +	/* Don't free the memory if we are hitting this as part of suspend.
> +	 * This way we don't free any memory during suspend; see
> +	 * amdgpu_bo_free_kernel().  The memory will be freed in the first
> +	 * non-suspend modeset or when the driver is torn down.
> +	 */
> +	if (!adev->in_suspend) {
> +		/* return the stolen vga memory back to VRAM */
> +		if (!adev->mman.keep_stolen_vga_memory)
> +			amdgpu_bo_free_kernel(&adev->mman.stolen_vga_memory, NULL, NULL);
> +		amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory, NULL, NULL);
> +	}
>  
>  	/*
>  	 * Finally, drop a runtime PM reference for each newly disabled CRTC,


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3968EC369D3
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Apr 2025 07:31:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 144E210E1D7;
	Sat, 26 Apr 2025 07:31:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QwivOZsm";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1984B10E1D7
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Apr 2025 07:30:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezOaQRIQHTaBfXedtuTCL0QExkn4vURbWCohDpGo1fe7iheUAUdKRC4ibl0PD9kkxou4kFGhmf/DVbMe5hOH4XEnHZ5irxzGb+ClIZC/hgJ4glAKeLWKZfMxYSOt7kdUZEX8MbGJ/awvA4CuCotWZKoy4zU9Sz313HfdM0H2Eq1zHx1I9O8u4BNL5HuD4v59n1DDdJacvT9hrdVFFUUFbSI+ItZhQCpGBxGz+JubhkrZj86ujz3myylW1+6FFtXHinDlyGmcsp99JZ6a8u6mSyDB4/Fp0MeRettxQ6iCr40lX+wRSUQOkund+Z1O+5AyTt8Ak7xAwdHU/7hLn8c/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apzXvDCXKYmP1xt1qaWJNxPqSkNims1+UYipdkuI+/s=;
 b=mrvJl5KCPPv7ASRJ1eHSLR7Ejm1SWGw4lsYTowu2istB7Z5fMiQPmoUcDlfHCbJhEoTiYEmg7HQ3eIZAqqXh3ILSt7qeg4ZTxQEaYZByOrXkWr9umtoWsY4VJTW8j796ECooA1jujDoE1sp1FOUO9cBEhquxgDju9ovgb60kOIBzgFAhJ1+dM3iIm3S2Ps9uty6tt2Wz1uZmIPYzmdBevI+/9GOJMZ/HDi1z6hgfNgaWIIqod1urLuQ0GyrwC+pZcRZv0apQov5oXH1bw0VnnTvLlMhH8GvRkSnYuC9Uo2tZAjNFOsKlqTV5Tfi87wXBs4t3BZnhh7gfV8T1lMgtXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apzXvDCXKYmP1xt1qaWJNxPqSkNims1+UYipdkuI+/s=;
 b=QwivOZsmEJhmegPlPgsINfH9k/JFVGodRgWMWC11XyFid1o5ZEB0G/hDkHQ/Ehjba6NNtNJO0QV6a11MQ+MfJX4eqwPnKvIu3UoYlpjDc5Wr0+NPA/t30zxaSyexRdZW3NQmn0OcVyY42AmBGkeOyiHkpGU1WAi4teW0DH4z+Q0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Sat, 26 Apr
 2025 07:30:50 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%5]) with mapi id 15.20.8678.025; Sat, 26 Apr 2025
 07:30:50 +0000
Subject: Re: [PATCH 1/2] drm/amdgpu/userq: take the userq_mgr lock in
 suspend/resume
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250425183428.162862-1-alexander.deucher@amd.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <ed9d834c-dbe1-6d4d-6029-16ca3884b565@amd.com>
Date: Sat, 26 Apr 2025 13:00:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20250425183428.162862-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MAXP287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::34) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|PH7PR12MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: e94456d8-43d5-4b4f-270a-08dd84944479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1A2QmsvTnRCU0JhQUtWU2pkSUsvREZiT21qOUR5ODNabDBwVHdPSXV2MHBT?=
 =?utf-8?B?Z0JILzM2OGIxSG9KK09kWlUwZDFPZGJMNHNMUTlEdWhsMlNiWldydXkwWDh5?=
 =?utf-8?B?Zi8vNi9yS3VwK2NmcGZBUkdyY1Q5elpocks0dXJIcUk3cTAxZjF1MVVmZDNj?=
 =?utf-8?B?MmhSRWF1M21FQUpZTmxDSjBnN1pYQUtSSys1RWJIUVlHdG1tR0F0ZXE5cmFy?=
 =?utf-8?B?TUdrVWVkbzk5RlJoYXEyaVNwVmVtM3poblBRNThHZGRqVHhUblFjcXdZbEJp?=
 =?utf-8?B?Z2NVK1FLTkwzdGsva3N6NXN6MFlYdndzVlZ2VVBDdVdjZmFrV1lTaFhFRUhY?=
 =?utf-8?B?SkVMTzdiempMbXhtVDh1K1J0VFlSUGk2Qmk3WWpKOGNGS0xCaFJFSGhNSVRR?=
 =?utf-8?B?ZWJhMzNrYjViQWlkc0QvQzBTSGRNVVdTK3l3WUM5VkhxZzdBTlJkVUhMQTRU?=
 =?utf-8?B?MXYwbGp6MEN0bXBMRVI5SE1jbkJhcExITUVnTFhhL3E4K3JBOGxISjNudW1D?=
 =?utf-8?B?Y3F2WWxkeXNkY1FLZ3FDNVBObjNxQXJSTzdBVG4vclE4czZiQ00vdVRzNTJl?=
 =?utf-8?B?SXpIMVhLL3pGMmllUGw0NnJWNU5CVDFMRTdmS0xoUGhMUWZZMndsODNyMHEy?=
 =?utf-8?B?T1VxYWxCc3FybGhrZEo2b1ZRdEZncjgrNFB6RWdEdkJkdmpzTHpvS2RURDJl?=
 =?utf-8?B?OThGQ2U0WjN2YVZ0RXoySGN3Q0ZuNm5VUEF6Wm82MXZONSt4QVNnY3FFdE5P?=
 =?utf-8?B?VXN0dHVnOWR0VHpZUVA0dTBOYzZvQlJNeStHcElDWU4rZklWNWR6RkljZWVh?=
 =?utf-8?B?alJYQnBTYlVqdHp1OHhIdnBuVjJGT243YkMyT2ZZUjVHWGFRa00xNi9RY25m?=
 =?utf-8?B?OE5jR3l1Rmg0WTNUNE1DM0ZxNllGcGNpVmdWOWFVU3ZBNHZQQ0tidFZTWG4z?=
 =?utf-8?B?ZlB1blNHUWpQcndPRzJ4ZmhHeUdHTDNEY0R5OE9EL3RFSDJFZHByeVFQSlJ1?=
 =?utf-8?B?K0MvQzRCNDVwQUhud2hyTFV4M00zR0VFaXpjclFWejd0VVRTNVNlUXB6YktV?=
 =?utf-8?B?T2FPSnM2ZDJQQndUT2tFalZDbVRna3dyTkVRTkZYSnhGWTNWZStESjZIa1lL?=
 =?utf-8?B?ZE5OWXRaaEpTYnJqSklQQk5zMGp1YzREaVlUTmlVWWVxT1dXK2RXY0QwTFRQ?=
 =?utf-8?B?OGNlZHdrbTYrdlIxdG93WVQrMy9USmdNMHVDTi9BUjZrUUJtRmZhZW1neHVv?=
 =?utf-8?B?ZDRIejZUd3Jlc1p3ZGY1NFFQblY0WU5ON25wUjA0cDJ4NGVCVXI5MVdJdjlw?=
 =?utf-8?B?TlZFTlIvWWVGM3dNQjdvRXNpWG1DMlNJUk4rUzNLN3lUSENla3hBTVdMS0tG?=
 =?utf-8?B?OFhlUTh6cHo1Sjg1RjI3TmlhWGVGQjdBZDJ1eTFWV3JudUNocTBqTUhqT25I?=
 =?utf-8?B?RStpZkw4UUhyQmxIdmtnTmVXY09mTzhtZkJTZmdqbDYzdTdTZTlNbWU4SkZS?=
 =?utf-8?B?K1NBcWpPb3NNMG1SNVd3MWhYaHFLakl5YmNnYWk0OG1tR1FDUWYvRHRSRXo4?=
 =?utf-8?B?MlA0a01mbXoxQjhjaXZjVDQ2N213dy9vdmxsTk04UTd6OEV3dzczY1ZWdDR1?=
 =?utf-8?B?SDZWWkpyWGw5bmF1dnhPOXhtVzlkdzdoYWQvZkNVZWFKQWlzZ1BrZkxaOEpV?=
 =?utf-8?B?TVlQYnVmMkEyT0ExVnBVR1g0OUZCbUVuUWh1VTNmVUU4Z3hHT1BUcHZwV3Fh?=
 =?utf-8?B?UmpXQUVWWFUrVk5kU1ljaVZmQk94ZTFTdXRsVHFXRmowNnE0dGFsWGpmMEYr?=
 =?utf-8?B?enNoZWF5YnpBOXZFNFh5T1dadCt1VlRJOVdXM2l0Y2tnNXA1aUI2WUgzNE1h?=
 =?utf-8?B?NFhua3cwMFl0Z3JFZFRyd0NVR1h2d2h0OGRKWm1uMUFKYVJwYmlrZHdsK2cv?=
 =?utf-8?Q?lTgn2mivKsA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmpXRWZGL1hoa0VlcWwwN3A5cWdHT202YjQ4aEZZMmNHWUdRcUJjRU9VeXJP?=
 =?utf-8?B?eE5aMzVoMU1YMFVUMi9SVlhya2hSZ1g4WTJabHE0bWw1UXBXd2drbFE2Qy9x?=
 =?utf-8?B?ZlFQcDNMdExmbFlwUDlma1llVWlnN3doTmxzamRYUVJaT2U5YmFBWDVoWm5Z?=
 =?utf-8?B?MEUyM2N6MjYzbmd3d2M4TDhDM3d0RENuZ090dHJWb01PaWFFQmMwZUVhVVRj?=
 =?utf-8?B?MFlWTTExVXVBS211RVRZcVI3dHI0TnJzRS83Q3ZHT05iSmFBLy85ajc2QXlZ?=
 =?utf-8?B?TnkyeWhoUkxwcHFuM3dWTG9qSTRkOG9yb0EvMVA2ekhNTHN6UWVVeG9iUk5M?=
 =?utf-8?B?WTdKL0pyTFA0Ky9KcFBiUnhiUHEvbm9rR0MrUHMvLzVCVWNaV01LbVlFVmJM?=
 =?utf-8?B?REFreHJxbXRybkUyb3dGcWhjNldRZHlueWwrL2YxcWkzcUNHa2RDQisxRFcr?=
 =?utf-8?B?c1NjM285MU9GVUl4WWdVV3hEc3ZTajQ5V3RhUWRPQUhkUnBGdlFVWHNDd0xa?=
 =?utf-8?B?NWVqQU1HU0t3VCtsMHpXbWord0M4YjFBWDUyNHFZcy9BRnl1cStWRGVNMWwy?=
 =?utf-8?B?ZHBqdG96dEFIRmRuRlA1Tkwvc1U0VTJ1SE5wbzRwclA3UEIxVVlwOWdaUi9W?=
 =?utf-8?B?ZFBaMTI2MFovdXo3K1BwakhCV0g3YVlKNkhMVTVVUnY2YTFmaWQ1NUZYclVo?=
 =?utf-8?B?RTZxTzJTQ0tvU2l5RkRyaE9WU0UwNy9kOTFLV3NjYzlkSkJSUWh1M2pRSkI0?=
 =?utf-8?B?dGxOcFJzeWVoUUtXQnJUcFJibmVyTFBlQUhmamhyblpvS1pKSytBKzVZcUNp?=
 =?utf-8?B?OXI3WXd4bm8yeWQ5NzNxZUxiNHRNRVI4Vms0WlpGZzNsZmxMVnI0SDFaMWwx?=
 =?utf-8?B?SUpsUEIzNUNIUjJFb2N4L3pPcDk3SWg4L3FldVpuUzhsbjVrc0RVT1pURC9O?=
 =?utf-8?B?UFhYM0FYVGRHN01SQkJZMHoxL3BaMEllZE9ncVBPUXQzcGpJV1JjVmsveE1n?=
 =?utf-8?B?YUd4aS9lQ3NoUWRGV2EwSzk5ZTlFNmI3L1d2WXJiNkF2bmJwMUIxdmtEWFVz?=
 =?utf-8?B?cTZJeFB3UG5qMUh1TmVjSG8yK1ZPcDJtdXRXMjBhTGRaZThpRjVzVEF5ZWZj?=
 =?utf-8?B?UHc0dGE1elpKdlJVZWo5RXcrYmdnd3p2STZVVmI5c1NtWmhIdkxxQjZoVnBW?=
 =?utf-8?B?K3g0RThTWGkvQWpFT25EaUVqenB3NTN5T0ZYdWpQMi8wc3ZXWDh3dm8wMjVV?=
 =?utf-8?B?VjcrSk1WNEQrRXEzbDVjb1ptUFVzZ3RvK0F5YzVlV2t6cEJvcDBYUURsMWZq?=
 =?utf-8?B?dTVKbm85a0VFcTdzTVRQanlGYTNwajlGODZsVDhsdFphd1U5MG5JaVJTaFNR?=
 =?utf-8?B?eWtPYkVwVDFGRWt0cHkyektxTG1SOUw5NEtNdXV6ZzhETy8wUHVyd00wRmJN?=
 =?utf-8?B?YVl0SFQrWVZEQWRzVFNteWdiSnJRcWwrWEhuTzNpKytZOUdiRk5WR2F2S09o?=
 =?utf-8?B?ckNqM3VONG5uaWpnWjZhR003aDRsUk1ka2dGbGw3T1M2SCtvNTVac1NCcnhY?=
 =?utf-8?B?WlVvVkttb1RUUlptY1NGVDdlcUNINkxjZzJ2aUtZVGxXa1pERUFBSVNUclph?=
 =?utf-8?B?SGJ3RmVFL0VUdHVWSnZuM1lRSUZxZHBvcTJHWUZrbjhCZS9PWXFKOER1eVI5?=
 =?utf-8?B?RE1JeWJzck9BYWJBRFlKc3k0UVhpbGxrZHdzeGswV3NHNWh3SjhoLyszeTM2?=
 =?utf-8?B?dTZlZk0xWjZUQVgvZm1jaWlnWFFSTlhHRVRHQW1oS3dBOEhyZDh2cTdFQnd3?=
 =?utf-8?B?alNnZ0RudWJ1TDhCb3JWSmQ1SGdnSEFYSFNFVXJVcnVxaXFTVEE3ZEp3NUla?=
 =?utf-8?B?SjhwTDlYNFg4Q0tDNWdIdE9hOWtUN0IvbTlWQzlwb0M0MU5GZTh2UU84TTk2?=
 =?utf-8?B?dEVsRjU4Yk1sdTFjRDJkU0RGWFpKUm5RdHlkV211WFR6Z0pxVmhya2IwN3lF?=
 =?utf-8?B?Y3NEUlBKeFg3SkVWRC9jSEtnTWhkVEsxWGt5VHdwT2Y5ckF1Mlk4eDNHdUEz?=
 =?utf-8?B?UlVySndLb0d6OWhYY2FyWCthWXJZSjE5RU5ISWNlK2JOTy9LOGFRZy9uWDlS?=
 =?utf-8?Q?9zyS+CQmpNk3UuGgQqmzYXbBT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e94456d8-43d5-4b4f-270a-08dd84944479
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 07:30:49.9142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6C+ASt5naxPCyy1PETYFQVCNTZ3HUXColiBLeb4rzMcQRkDqG+IeUtt6eGL5ap6WXgPsow+cEUlDxg7iy+Y1AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594
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

Reviewed-by: Arvind Yadav <Arvind.Yadav@amd.com>

On 4/26/2025 12:04 AM, Alex Deucher wrote:
> Add the missing locking.
>
> Fixes: 73e12e98ec0c ("drm/amdgpu/userq: add suspend and resume helpers")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 451890ee3fb79..1fa9d2be87f39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -809,11 +809,13 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
>   	mutex_lock(&adev->userq_mutex);
>   	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>   		cancel_delayed_work_sync(&uqm->resume_work);
> +		mutex_lock(&uqm->userq_mutex);
>   		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>   			r = amdgpu_userq_unmap_helper(uqm, queue);
>   			if (r)
>   				ret = r;
>   		}
> +		mutex_unlock(&uqm->userq_mutex);
>   	}
>   	mutex_unlock(&adev->userq_mutex);
>   	return ret;
> @@ -832,11 +834,13 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
>   
>   	mutex_lock(&adev->userq_mutex);
>   	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +		mutex_lock(&uqm->userq_mutex);
>   		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>   			r = amdgpu_userq_map_helper(uqm, queue);
>   			if (r)
>   				ret = r;
>   		}
> +		mutex_unlock(&uqm->userq_mutex);
>   	}
>   	mutex_unlock(&adev->userq_mutex);
>   	return ret;

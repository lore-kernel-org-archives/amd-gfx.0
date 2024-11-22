Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE0FE65D2E
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 07:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA13110E049;
	Fri, 22 Nov 2024 07:50:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pw74sgmg";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD19B10E049
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 07:50:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JISjESsi6H3oKkNc2OYrrfRroaXk+xxD9BuEqueLRKrl7D88oYLEBuioWhfTfephaYHUZmuNxm9+CH2T7jiIPnpKc6vGlxLhl9lSi76MHFB4mAz18+hUWInFPN6ZG4/HR0Sylhm4LbkuqlQN1JQGJO70dCRKNgXZd/RBlZfgyHcHApKRD+zXoGXSNazH3AK3CFuLPqLmOMnrbEHIu6YyCPB0vIz0+fzdxYiNRDaOMJSsBhRL9J3u12A3FhZ02KEFKCO6vdS1zr0TOXmuvJnnxF79lGwmYogGaDEMnxAdnXds57qieOWkxS/t1y+i4zDo6AnqaQAwC0E2wmUFUg5q1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUKChQwBgZvAkqt2L3egMum/9y7Ztf9qbc8kdZoGFOw=;
 b=VX0PoRO/v51xDxj6qXd701+zqA8H0U3Z3QImp0aubUQaFmk1ZIZIF2wQanaUdnKY50vhgYHWtmK7Pgcxa/bkT7Urs5Gw0H1IlDThf+VIxp2i9Tru/xeRnNHVWqmVGtC26d+r3xRXfYeuop6PjeffMfcRSBJHYpMUf0vWIh4GSA9bKICwR3kx3KW4dQBc4/wlY4tynKU3XNR6+7Do6eQyMDUilGXZiiSVuR/PRgCb/vfnXvzmqmfpxTEejbGKP/sw5z/fV9T6mI0k7ak2zL3eDtjbQfx0flEJPuucTuZ0pV0doKwABAApxjOqxHBex0FVBRg/dWO2FyO3IFuaT0EUtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUKChQwBgZvAkqt2L3egMum/9y7Ztf9qbc8kdZoGFOw=;
 b=pw74sgmgeylLDx1jfBrO2r1r7NgCjBNRw4yq6qbWdLX4+pHaWspR3PpfOOU8o4C2Nw5A2W3CIz3fBf6L8W3M6JRj1hQiV0SI+DQVB8fVGlwJxaffmMrs+wk/Q/ctAQ4DWrIf4tcU3HsLVlIsFQm22pbsHcO7fDZZujtfH0oUoUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6686.namprd12.prod.outlook.com (2603:10b6:a03:479::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Fri, 22 Nov
 2024 07:50:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8158.019; Fri, 22 Nov 2024
 07:50:23 +0000
Message-ID: <0abe2992-b3bf-4114-92de-979cd060c044@amd.com>
Date: Fri, 22 Nov 2024 08:50:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu: fix the variable name in comments
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20241121173746.2690646-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20241121173746.2690646-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b43fe3-3731-4e49-4053-08dd0aca51e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDlrK3NGY2trSnYycEI1YWEyYzY4OEhNbWpJNVhIdE82dU9lNGdmN0ZPRzA5?=
 =?utf-8?B?L3VSbUp0NHNzMDdjaFBxZGRnRUg2anZ3dldicGk3RndNcnpnZ3VFQ0J1a1JG?=
 =?utf-8?B?TnRNYVJWaGVZTW5ZS0p4RWc5MTQzdHBwVmdKaDFFUmNSQ1ZtYmFVaTBjUXY3?=
 =?utf-8?B?VitqWGdUMzN6MDhwR2poajY5Ky95b24xRDAzYWRnUzU1TFg1dzF4bDlzUk1o?=
 =?utf-8?B?VVZCNks3ZVgwMkNFVkErb2JZcmt0encxamsyVjFqODFIcWh0NkhRT2tMVGJS?=
 =?utf-8?B?RVFpcFpTYTRFdnp3NVBYbys3TVBtVHNmekJvS1BqTGVxOG5xNFptbk5MdjRX?=
 =?utf-8?B?NmpYVHRTRUE2OUF3TWZZVVFNeFVaVDhkMnJSUWV1T2ErY21iY2RRU3Jsc1kx?=
 =?utf-8?B?cTE1VUFEdnJVTzNrZlNJOEdyRUgzSGZkdzZjQzhrenFqSUFiNTQwbGcrcEhn?=
 =?utf-8?B?RUxENEhxNWVNUjhUeWgzbXhmMDFaOHlvYzhhV3JsRlovTGVNRzRXNEI2cHBP?=
 =?utf-8?B?bUo2UHVDYWtmZ2x0OHpQQUh2RHBod2d3SkZwY3RIK0xPaDJSN3JveFZSenAy?=
 =?utf-8?B?NXNBMDdiTGN4RWFGNmhhK1hTZ0dUcEo5aC9rKzR4dmRYbzhJUndWaGhRUUxR?=
 =?utf-8?B?RHdDR3pjMnJqbkx4cVNFMnlIaTRjcStvNkxTWDNVSUFrOG40b1F4aDZyQ09F?=
 =?utf-8?B?b2NuV0pFU2l4ZTZtUkZnWjk3VHpBZW5YV2p1ckVVUlBzNWRnSlhEZEFGVmoy?=
 =?utf-8?B?WXhYK1NLblpGa01rTmZQK01xQ0tqais0dUhHSHIxOERJeUljOC8waWV5N21T?=
 =?utf-8?B?bEZuREhsSkNsM2crVml5RUhCcTZXbHNuVFFLRjd6TFpFTTBEV0NPMXVKUktK?=
 =?utf-8?B?R1FmMFdiU1pTa3owaWlSWE5sQUlQRWVCb29CWkRKZjU3NC9zNGhuVjVVMTBK?=
 =?utf-8?B?QmhKTmhrS0NINktyMUxDK3pCRk5wbEFoUDE5YVhFNzd3OWtrc25ZMTV6dGgv?=
 =?utf-8?B?NStHQ2NxMHFzMFB6RXlocVQ2NjFHdzBxZWg5Nzl3MUx1TlJuQ1VqMEFjZTZJ?=
 =?utf-8?B?UUY5N0JEUzg4TGJHQUl0T1d6aWl3Rm5JeVJaV0xydEtNeVg5anFMMXFtbkN6?=
 =?utf-8?B?UmtXaFdZeTAvbVYvTS85ZGV5VXdzNzNWZEZmdWMzVVplZUgrZElsNjNEc2lx?=
 =?utf-8?B?Zis3MFB4TkxXUHpEL2lnRFlQdG4yTWllSlB2S1ltdHBIWXByYmx2UytjTUc5?=
 =?utf-8?B?aExBSFlyeWZzVkl0NXd1b28xYXdGS2J6TG9vZHZjYWRDM2RNZ2dOK2pxNEM1?=
 =?utf-8?B?MlpkQnlHY1lidXB1TE83MTVUUWl6S1BUakZRTUJhRzRmSStDKzNYNlNHbGlL?=
 =?utf-8?B?VDVxeldFalJZeERiQWZSOTJ3blZZb2Q1bldRSUR3dVRXS3h1MHV0Sk1NbjRD?=
 =?utf-8?B?VE92K3F2MzJVSC9Ba3MwN05EOXpYdklWa0swcmRDREE0b20wY3d5Z29lS2xk?=
 =?utf-8?B?TC9qeFBnNGtzZGZmWkU4djZrNWx4dFV1NVZrK29lbWFTbi9mVU50dFd3S3Zs?=
 =?utf-8?B?ZVhtbm4yVzJzQTVybG4vNUs1T0ZhcjhLWmtSM2FKTldtV2pOM3ZXbnY3TDJC?=
 =?utf-8?B?VVZiVk4yYlpQYXBHeVRrc2xVdzMwRUYyZUJlL250U2VoUTNPSUs1ZmFJTXN1?=
 =?utf-8?B?cGZ4aTk3czZ2TWRBS0VMbGlUeWhJMmZURTBLVmNVU1pwQ01nK3dKN3FIM0NO?=
 =?utf-8?Q?dTeensZrB0YkJ94U+OOnSlWj7M6A5jzDaPamaWG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UThuNnM2cUFvU3dhVFBvbGhCNE9SMVA5L3M2YjRrYjVoQ29ncHBwbUF6UXZs?=
 =?utf-8?B?UnU1TUpxUFpTdWhmWkY0UjloZXFWejJVU0cwV2dPUk1lRXBHZWlldUZzUnBJ?=
 =?utf-8?B?TW12aitXRUxtMlBhT0xJbHh5TDNhMzJCQ3B3YUE3cWloYU0wMXU1RFV5dlNk?=
 =?utf-8?B?UWxYTTBGNlhtWkl0L2JpQ01RcW9VdnVRQmlORmtDajI4K0NCVnYweFJHcjFH?=
 =?utf-8?B?RW1SUkZ4MndmYzd0V20xbCtma2lYTTZINGIrU3lCT2R1QXI2WHRJRzI1bjVC?=
 =?utf-8?B?S0tEenpudVRxbFpTVVhFZFM5djBXKzRQazJqNEdCMkF2OTlOOW9aVURKenF5?=
 =?utf-8?B?RUh6Vk5rMXgyUitHNFoyTkRhM3FOcnhxaW1QWTF0WmJDa0ZYSHFnVGl4L2lS?=
 =?utf-8?B?RnJCcHkycU9zbitHM0Z5YU1CUW5pazhPY0RFK3haTEZ6VkpidlZnSytnWGFw?=
 =?utf-8?B?ckVZaTRJK0l6UDZOSWZMNDhFM0hEaXJvK08rT1ZvbDZRSHM2VityL0pRZWNV?=
 =?utf-8?B?M1pkdXFUWlU3L3FWdGVaWTgwWC9FbG5RTitTa2l4bjBMUWR0QkhseVp3TVp2?=
 =?utf-8?B?bmFQK0tXRktUWXhkZVBtRXVNM29reU9vMnI5ZUNXeFVpTW5yVlpqS1BRamZP?=
 =?utf-8?B?M1lCTERRLzZXVnFFS1VPcUVMV0FvK1JUeVpaQ0R1NHlFOE5abFgyTkovMW5h?=
 =?utf-8?B?K2VCeFBwUTU2SjU3ZW1QMitWQ0ZhSDNZQzZxZFRyS0M3d1ovcmRMbWVCVnB6?=
 =?utf-8?B?WUJrTStKN0RGUnAyYTc5Wk8zSTRkWW1YN1dkNktCRTB4YmlGd2wyc1lrd1Aw?=
 =?utf-8?B?WVZoUkRjR2Jab3lOZXoreXFqQ05IU1IxaStvMURTdWwwWExBRUhtYUlBWE1m?=
 =?utf-8?B?aE1HcTA5Mm1EckdoeEk1VWlKT2FaSjNBaUk4RUJxNEhKd09EZGJsTG1PUTh2?=
 =?utf-8?B?L0pxeksrUkg3K29EblhHUHAwQmIvK1NpWlk5dzEwQmQwSC94bXhHK0RwUHZJ?=
 =?utf-8?B?ZHkvOHAwdW1GTVBNRUl0TzdaQnJ5bHpabkRENndLeElsOXhhRlNLK2hrU2E4?=
 =?utf-8?B?bHA5eVBtOXBudjFlRWIyZXVWVmx5dW9FRVRqOEJVbzdqMitRWXBEZmJUbXZh?=
 =?utf-8?B?WWNOZlFsWTR5TGpnWVVsdnpmRUJlTmo1VkVCcjB2T2plalVtb0d0Mmd6L1p1?=
 =?utf-8?B?WHhld2F1bk05QzhDVmx6a3N6QkZrQ3JyU2lDeXh4TkE4NTNYMEgwckpqUUxC?=
 =?utf-8?B?aVRNcll3T0JsQ0I1bCtnR1YyczJES3d4TTFHU3N6eXd3WjBTTmx4OEV2d0cw?=
 =?utf-8?B?Smh6ejd5aW5QZzFvbFpFR01QVmlhMnc1TERZLyt4ZndWdVhjQVpOM3hxZTAy?=
 =?utf-8?B?b2NKTmllNjJhVEdJZ1JMK1NFbjRYSU50b0srS0V5Yzg4N0dNdUxDajgrU1FI?=
 =?utf-8?B?WnRrRHFWZzZhd0NGTGdIK2QyZjgyeDhralRuQVVLVnNtQW1XRUtoS09udVp3?=
 =?utf-8?B?ejRHV25ad2FXNW9WclVNaWxWb1l1TVc3NzVnMllicCtEK2dTU05EZjBPRW90?=
 =?utf-8?B?YnF0a1U0YVpzKzJRRDhldDN1cXVRK1cwQm4rTGp0alplbEdjNCtNVUVBNnRx?=
 =?utf-8?B?Vjduc0p2bEk3KzNvNXpadUszRVNhV3BrcS9ZRlkraXZPM2dvajhzN2krMnNQ?=
 =?utf-8?B?VGhMRHNqS0JlM21tRnFVL2Y3TTJZQk5JamdWbjVDb1N3ZEp6SzBkWThmTVJS?=
 =?utf-8?B?UzBWZEFhR2wyVEN0c0ZXcElSOWpnTzJKOVhMN1ZYUjFHUmVoTGxqNUNwa2pq?=
 =?utf-8?B?TVhzTmVmZVZDTlJmQzhvaWdGU0RQek1vbUppNmVhdDlSbWQydmRYM0xpaUh6?=
 =?utf-8?B?Y2lXT1orek5GUCswa2pmQjd3UFkvRTRKekpqUDl0NHJIMnE5SUNkVVhGMFk3?=
 =?utf-8?B?dU4xZ1ovUTU3Q3M4M0FhVkV0ZE5rVHRhZGRSdkJlQ3BmSjZDVmoreUR4R3Fp?=
 =?utf-8?B?cW40S08rdkdIQXp6QWIrOThsQUEvWkVTbDJ4UWg4RmtDL0dZNU5ZTWJsSmdG?=
 =?utf-8?B?Vml6VFp4WlhUNWx5NVJVeWJTTW1xcFZ5U2x0dGFIZWh3ZllzeEtYWWtURThH?=
 =?utf-8?Q?FPps2dYNsXzmaXVT8JBisFAEE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b43fe3-3731-4e49-4053-08dd0aca51e6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 07:50:23.3409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55e8n1rGTsacyrt4uqSU1oijlOWvvq6WqDymR+d079kxIlLNZEbkWoF2Y+1Gr92+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6686
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

Am 21.11.24 um 18:37 schrieb Sunil Khatri:
> Fix the variable name in comments to clean up the
> warning in amdgpu_bo_create_isp_user.
>
> warning: Function parameter or struct member 'dbuf' not described in 'amdgpu_bo_create_isp_user'
> warning: Excess function parameter 'dma_buf' description in 'amdgpu_bo_create_isp_user'

Mhm, I think I would rather prefer changing the variable name.

We used dma_buf basically everywhere else.

Christian.

>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 4e6d218839f9..89d84820e4b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -357,7 +357,7 @@ EXPORT_SYMBOL(amdgpu_bo_create_kernel);
>    * amdgpu_bo_create_isp_user - create user BO for isp
>    *
>    * @adev: amdgpu device object
> - * @dma_buf: DMABUF handle for isp buffer
> + * @dbuf: DMABUF handle for isp buffer
>    * @domain: where to place it
>    * @bo:  used to initialize BOs in structures
>    * @gpu_addr: GPU addr of the pinned BO


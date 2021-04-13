Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDF6C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 20:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4663361158
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 20:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4663361158
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0237A6E219;
	Tue, 13 Apr 2021 20:58:41 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2049.outbound.protection.outlook.com [40.107.100.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BDC76E219
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 20:58:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ed3xBQSFgQrfUkP2+pKLd+iHE5BgBKxmyOO6d5tnfnxfBPfmgOkhY5taAnDHLtXZFSnnroDQyevxFqVdKts6d59sHBCu/Zl26r6GsuwCP15HQOJ9JrBorW7NPrkADOCwmaJzUS37DeAC9J9pvXlph6WBly41hDpsAcR1YaW/5HlYzLOo16XBEszxqH6uZlm8TXobIKgP3NpHT8b8NyHBoFVHu75m0Hw05Auw6d6YfkgLZKGFxFyszimdbTBfLMLfpd9vl8p8N7bdR8a+Akg+gzOS0M2oOshTU/JjiaLeGXWae8/y3BaBkBnbkts4GL5N9+zbBp3XNoLuVhHumSYmVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpFT2k7vzOOveRFjIu2P/aJ6cc99QBcUx9UDK52QSTc=;
 b=N28e37Q//ZJoDSPkrf9GA/Q3GuXbgfm1nYAx+D7kVQif28Ld9aMSgoUgyS3RMUQgI/3sS3T+Lmml6e+DyDglKXS/HKZSeI9OSSKzo+6JtIUC+W8iDzYLTKgr90wq8e0VSOPdnjB4JnpXHHxl7V4xOMhOxZ1wf+havtk0ny66KcHgCbwrwnpcFpAmjjkidckwgxw1ddAMfFrimHmSowrXyqKPzjbXexWz8e49KHqrExBvsbIc5+yqFWZWAhZ8aHH5hTykdscmnVZZpAGatoaniOnteRsUeLISd7Vw27rLltp8Jp69zhwuNhXhrx0Wqrdh4n4Pekay1kLDv11vHFam6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpFT2k7vzOOveRFjIu2P/aJ6cc99QBcUx9UDK52QSTc=;
 b=iVeO+UdVjxjj00/Tj5mzbqS2zzmkjuA8EGhBo5u7YwBb/9gzMhTV7jd75K73HJbGog6CbGhbX3N7wgKbQ4nmq6NMccnoEgegyf9c0zuEmF2qjdMa+NRrfQWTVu1zrD1nnTfvWuoBs0ObuW7R/z3tjCSTaaU0mw6OQpDkQZH5+3Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1846.namprd12.prod.outlook.com (2603:10b6:903:11b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 20:58:38 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 20:58:38 +0000
Subject: Re: [PATCH v2] drm/amdgpu: use pre-calculated bo size
To: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
References: <20210413204213.6405-1-nirmoy.das@amd.com>
 <20210413205041.6355-1-nirmoy.das@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <f36f04d0-4013-82bc-1102-54c528ea6459@amd.com>
Date: Tue, 13 Apr 2021 22:58:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210413205041.6355-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.119.233]
X-ClientProxiedBy: PR0P264CA0099.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:19::15) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.119.233) by
 PR0P264CA0099.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:19::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 20:58:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e415e32-0a48-486a-3cfe-08d8febee8f7
X-MS-TrafficTypeDiagnostic: CY4PR12MB1846:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1846440965AC5789255BFE708B4F9@CY4PR12MB1846.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H5FieWJLctV0BpfjpXMI6HqCYAay0wytlI/Pup6xP2jTg2VvsMEzTnrkdPvTs00D/0nxizGSKSSvG+pLK7OSfPtMzncpV+PTMFMw+LKU3n3sYUjq2TMbNHB92TQZqKrDyqpfHgCo/N83nfL49zO6kYEjde7kxThROHsQBuDhJm9tXLflBrj9avygf1/xIzFtjEemoDbdemNLZDgMaS87A3DchHdtFXnEGtGE+AQ+KOBT84sm2Dz/+ijSnNR1I2ypr/+YrjMTA8kksYfppYsIAs87/AiGqOrV2BhKyjNDhP1OYo+h3Br+pognfnfo8nu2o3ndsoS26jA3qWrlhfpqVXy1ttN8u7igdM4TocTnVn7rW5PTFwKxPLScvIxs2+1QxTexPZPqqK/qMtu++qMyAH3bjZp1i6xDyidi8Ck11KSTlkGAvXziwUrg4dAhAY2ezu8lTi9ouwoVdQkQx3vi1j0DBEc6I9zcmaVBT4er+h963kYB3VU2mp2mx3T2VEj+IUBxUsB2rCW2HXAHRxb6KbSOhOr2+ZyuiNiivCfh2kNAHIoolosJXfdeWxz/vwrqKk56Wiam+uGvXVNtT2557L4C7W13B7M60+vNrcr59ZDywrI3rTTKtvFvIFOaJbE5LLYarC7oJY+sUwnCBFp03gni4g5c/LaE9uAIUiw/bCfOvppsgyExNtYrv0HneWuav+HgNIGpWyuAmBuaCL3o/RO46eB9T1RWCzXKku/k16Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(8676002)(66556008)(66476007)(36756003)(66946007)(38350700002)(186003)(956004)(6486002)(478600001)(2616005)(2906002)(5660300002)(16526019)(6636002)(31696002)(83380400001)(6666004)(8936002)(4326008)(53546011)(16576012)(316002)(26005)(38100700002)(31686004)(52116002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TnZTblJOVnFTQTZ6ekg4S2hBNU9QZWpyR04yYUtsK3pxeStaN3crTGVhckVl?=
 =?utf-8?B?cDZXdmNGYVhuZmRrSFVNTjVnbzE3Z2syNU1yTjJuOG9UMXB5aSsrME9QRzZ2?=
 =?utf-8?B?dnpCL0YweGJTRk5jeUxGb0VLUjgvWlliMm9FcmxYR2pwazl3UWJrdVVKTmNE?=
 =?utf-8?B?eUZCdnBVekVRZEY2andVTXpFalYvUGJQUFRMWUp0OHFCbFhvenlxeG1QNVgy?=
 =?utf-8?B?ZUhYYVdSOGF2SHlSenRmN1ZQOXRGRFM2a0JLWUZUdTlPZ1NRQVJrSk5WYk5O?=
 =?utf-8?B?YUU3R2NDODBxY295WkR5YnE1MXZlei9jczdTZ2VyZ0FiazFoR2s4R0VIRmh3?=
 =?utf-8?B?UVFhN25WQksxb2k4bXlOcUxFTjg5RlVuU2hFeiswOUpuTWxlWE5Hc0w0K0h5?=
 =?utf-8?B?aEY0Vm5VL09JdzYvU0k2WG1jdlFYOVNlMkNHNnF0WkpXWWNOZ1B0aE82aXlz?=
 =?utf-8?B?OW1Sd3N1M1gzaGNzKyszbG53aXBzK014VmsySFdWN0J3b0tKOTVOVm9sSjNO?=
 =?utf-8?B?bHVtYWJkdDl2cHc5TmJrVmQydEpaK0dpdXRMQTRtVFArRFhTZU9MSE1mYVpp?=
 =?utf-8?B?Z2QrNHBhVThvTFFKUWJCcWQrbE9raFB4MFRxMjBZNXZad1FnaU1FS1B3TXZE?=
 =?utf-8?B?VTJFcWg4OUlZTWE5NTdVdDdoaW4rRm1EWWpuYlgwOFhPS3pHRDI0dFBvRjZN?=
 =?utf-8?B?cE5YQUhtZXgwL0RKZ2lOczh1NkpZVHE5SVlsN3FYSWtEVDljZEIyekNOYVlK?=
 =?utf-8?B?NmpCdGtDWXY0Z1B4NU12aGMrKzZ3Z05YcmdNUnpINEE2bDBsVW5HUnBVenZQ?=
 =?utf-8?B?eHl2RktSTFpkQnM4dzQyKzNjMEI3ZXBZM3dEcUFxNDVXbkRWdmZvUmNYaVND?=
 =?utf-8?B?aXBSZ0V5dGk5Q2pSeXpjcEg5a29GWDZjUTJBbGdQODhMV0oyYXZiTTZwaGNt?=
 =?utf-8?B?SGk0VEtLbngyWEx2S0czU1RJSCtoRWExcW52dms3SVpVSkg4U1hoTlF0Wkdj?=
 =?utf-8?B?ZUs2dWxkTnZFOGNEa0lkc3ZqVXlpQjB0SG52Vk4xZ0xKc0RQd0dxVHprQlB5?=
 =?utf-8?B?eVBCVTdINDlvNDVKN0VhM0pMeVVVSGhPaEhyTVBudEZGeEFTZnR0TFQ0MWRI?=
 =?utf-8?B?NHRWelpHY0lxMVU5b1ZXK3FQd0hTTVdUOVdyWWpKeXBsUlpvUWpmQ3RyMW1n?=
 =?utf-8?B?eWo2TU9oY2V0a09YVURveEsvdCsvMkxYNkRIeUF6cm1ZK0tRNldKenVwbHov?=
 =?utf-8?B?NzVSdWM1cXdsWTd1NzJyY1M3bnhlREVYc2ZXNHRtbysxbDFOSW9UU0VMNGov?=
 =?utf-8?B?ZHJiMXZrTFovRy9mOWdPaHpjbnJ0QW9sTjAvTVdLc0Njdkt4K0M5U0EwZHdG?=
 =?utf-8?B?MkRMRGdYTmkyUDR6c0M1Z0RGQ0dDcE5EbXZ3RkswYUs2bkZoQjVkOFU0UmhG?=
 =?utf-8?B?U0tVOElqRXE2QWlNU1VYM3l4WmZ6Q3BaTFZ2djJJcGNub2dvN2czK2dyVHB2?=
 =?utf-8?B?RlVPT2VHNDN4U0U3S044QVZDMk9rclZveEdpczlWSk5KMDJ2clRhNnZBRlJQ?=
 =?utf-8?B?V3R2OFAxLzdkNktBQ2QwRUhLYmN3eGFvNGorOS9uRGN0dEFZSHZDbEtjeHAr?=
 =?utf-8?B?Uk5WRXFha2ZZRHhlTHA5UHFkbE5WMC93Nm9kWFo5YU5JQ1B5NWlwVjJNWlRN?=
 =?utf-8?B?NWJGd3JycmhUdHNKd3VFSmV1OVdLUjhVZ1JHeENSTHRxbklaRkljTjdaNEQw?=
 =?utf-8?Q?U9BTga9NFJqmw8G082M822MLcK0A2QBp34PKgVB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e415e32-0a48-486a-3cfe-08d8febee8f7
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 20:58:38.1792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V3PrGd4/lQt4epq6YiiplQ40q+RLJ8hQ/8RIEdI+/1K4tJs6jFxxcbqUU3Ai3VRY3b60VONLNZKqcVxkN2LfTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1846
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 4/13/21 10:50 PM, Nirmoy Das wrote:
> Use bo->tbo.base.size instead of bo->tbo.mem.num_pages << PAGE_SHIFT.


Ignore this please, pressed send-email too quick!


>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 1345f7eba011..74ecc0c1863f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1371,7 +1371,7 @@ vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo)
>   	if (bo->mem.mem_type != TTM_PL_VRAM)
>   		return 0;
>
> -	size = bo->mem.num_pages << PAGE_SHIFT;
> +	size = bo->base.size;
>   	offset = bo->mem.start << PAGE_SHIFT;
>   	if ((offset + size) <= adev->gmc.visible_vram_size)
>   		return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 936b3cfdde55..26deace78539 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2048,7 +2048,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>   			return r;
>   	}
>
> -	num_bytes = bo->tbo.mem.num_pages << PAGE_SHIFT;
> +	num_bytes = bo->tbo.base.size;
>   	num_loops = 0;
>
>   	amdgpu_res_first(&bo->tbo.mem, 0, num_bytes, &cursor);
> --
> 2.30.2
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

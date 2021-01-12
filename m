Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9932C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 16:20:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF6D22ADF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 16:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF6D22ADF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1F71892A7;
	Tue, 12 Jan 2021 16:20:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6710B892A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 16:20:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/othRnrz2RY4b35XZ5IBlpmbX5qoaOgsko5L+TIl16Mxh6J5KP8TQur2gCGBk4lgAET2YmpeG2M7AocBEXdOxlXX5JOhOTEUWCcrXeyyBRmNuzKAfUWp6WzPSuP1gdi9gMQ5BsKB8KqFs7pzI813GDOJPrBp33Swk63JEPpGAnWGh6RJrHOJbiVFXy3mITQzneqMxK0nMYXkLGspvZqta5X6VRDtKOF3398J3Y28+rmTJ7nYvY9DV3cYSXxIB6M4dW+7UwOq/d1HVZ8ee3BYbIxPQNIWp5XN2Suzm03NyLv5/+YZ1fa391cl7w5NI0V7cB8AZRL/5PQIOuupHceFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tll8MtREcH1QhZHwHdCd4b8jcsNb9P1Ao6ktkjjjKj0=;
 b=MssM64j/ovI1oSicVG2XI7Sx4a7pbyVl6g89++VBil7Q/ZfZ3wrXjMOuLY0Xe7Gc6ucs/UvWMakBTySLSMxCHtEOJobMcagwbxRb6DU5qjMQWkDp3EQVcRv2YmScD9mar72somMYURAbBMDQIO7pCE/RbYG/31Yi/DMuGWsLWsncQulJaUsf23U0H8bCTJvgC8DNPzMWDUGY3CcqeUBjfL2hidBRhMST+98DyPbKeLAShjVTpztj4EE8nQZ3u0nOiBRfexHVJVV/Uj1o/SFSZMZUIk4XDdzLzw3AasF93jDozptvstXP/eepTrY0+0em0tgdudaX+UsY05YaXBJYIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tll8MtREcH1QhZHwHdCd4b8jcsNb9P1Ao6ktkjjjKj0=;
 b=v5bDCCr19ibLS6Asw5uv/JBmVcBPrmRr6jQ3UeguhBkDj6s3UaHNmcMJfCKykdsyBv+389yhp7CIow1pbDguHVoTei8uCfhIb477E0aVwEMy+gRDbeop99gPRjX2gZ34xCmtD0oLipjtHoKbHQhqwzAhdXCUa+YzOAR8ay8/WB0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB2598.namprd12.prod.outlook.com (2603:10b6:a03:6a::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 16:20:55 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::d475:3e33:bb03:8471]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::d475:3e33:bb03:8471%3]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 16:20:55 +0000
Subject: Re: [PATCH] drm/amd/display: Fix deadlock during gpu reset v3
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Guchun.Chen@amd.com,
 alexander.deucher@amd.com
References: <MW3PR12MB455434CFD3336676DB64B077F9AA0@MW3PR12MB4554.namprd12.prod.outlook.com>
 <20210112161326.1159175-1-Bhawanpreet.Lakha@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <f1c18246-cb0e-bb6b-d69d-76f88852fa3c@amd.com>
Date: Tue, 12 Jan 2021 11:20:51 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20210112161326.1159175-1-Bhawanpreet.Lakha@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YTOPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::35) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTOPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Tue, 12 Jan 2021 16:20:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 811071a3-f1f4-4e81-d40f-08d8b71609a0
X-MS-TrafficTypeDiagnostic: BYAPR12MB2598:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2598C20C22EF84B6A88C668CECAA0@BYAPR12MB2598.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gqnx3f9WpaUWJXd6oxJ4vSz89COYJTPde0BvXb+5+oR9EoXvhKuu8t2UOcNV/4fA6e1DnqUZX+M4ER0OnQj3mQOfH5dTgcfAyLzj7QEcoR3Pee8pISV2eZwAd72pnhJDN/WGM8Nb5QD6h9YHw1vPk9ZFUnVd9ugMVowGuvHnU2KyiPxxoAcezwv9jbv16LT5ZIrpwu7FHy2T6HF+x6WFqXs2PxbmaEp7CnccHYCokB+EdxInYB7051DrWUh6LzAaaHUVFKqvVdkj7+phqQdW5JirDY01+yUv14uMFYhO3kIHPh8Xgx6HcB261DGuy4Q7MrFeiSMGD3DZrEeOa1vJ9yXxddx+P342I7Bl5WE2+1Xyo/yaA0c61WeSPfbKIvS3rPsR0XRu97bNjeSvd1+4yxclkGqeIKUCfsKp97hIppNSoGSEk2arbwtXu2yebXMFAopgNL/amtxpHgIykeM6ejToa3ZrxptTPK+beuCN89w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(16576012)(956004)(8676002)(316002)(36756003)(31696002)(16526019)(53546011)(52116002)(86362001)(6666004)(31686004)(2616005)(8936002)(186003)(478600001)(26005)(2906002)(4326008)(6636002)(6486002)(66556008)(66476007)(66946007)(83380400001)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WlhwQ2JZOXE0SUNhSjNJMEdjT09tKzhzYmlPU1I0aTJxS3RyNGJJV1pJV0JE?=
 =?utf-8?B?bGdhVlJLVWRzNFlnNi9HVUQ1SXM4U085UWdBU0Y5TEZLQWlIaXU1YXI2RkQr?=
 =?utf-8?B?dXpTcHNOOFNhbFhzck5QMDRTOW4xUGlyUm9FRkFTRUJ4Um5leEhCOGF5amY2?=
 =?utf-8?B?N0o4bnNFOTdDbkxrOTdvRjNsdFJETnpJdnN5L09GVFZ4MkZzNlBSdWsvMVNE?=
 =?utf-8?B?Nlc3MWp1MkIwMUxXeDQrQkluamExSXhBS3UvRFNpVFlWeC9tS1hHYmpVaHd3?=
 =?utf-8?B?aVJUeWR1OWtwV2VDNElyQkMxeERvQjlBdHNVU1ZDTVczTFNoaStSOVo0Snlm?=
 =?utf-8?B?YzVBaGpBQks1b1llc2ZyaHpiYTZtMXVicXNFZmdmdmRSc2R3RHpoQXBHMjBB?=
 =?utf-8?B?REltejBwQTBWUDdoQXowTFpNRDBEbDJZbjRndHo5UmRzZWtSQXZabE5mWnR4?=
 =?utf-8?B?YzRac1pYcHhlWmI1OFFoQVhtMS9sNjNXczJtbS9QVDYyTFVHZ28ycCtiN0NY?=
 =?utf-8?B?dzZDL0pVem1Bd3hWSzVnZlUrRzhtYTlaWWhtUXgvYS82azJMWnNQR3k5NHlz?=
 =?utf-8?B?RmNMV0NCTmo2ZGpILzlQUTJDMXRsODFkalpWNXI4akVXQUlRUnI3YU51d2Vt?=
 =?utf-8?B?MTBNY0lNZDNpL1QxTXpqejFoQTZhUGhHbE43bGpwQUV4MVUzWVBrOElkZVlv?=
 =?utf-8?B?OXRGOUxPY2dxZXRCMUpXRlRmaE1Ka0xoenhwNnl1aEJsM1NkQ0k0dUhxSXl2?=
 =?utf-8?B?dVJ5VmxWQUtVMzRTazljcXdWM0MvazNETkJXYXZnS3gzTFl3M3JTWXZ2S0xn?=
 =?utf-8?B?YmVVQXBoNmpoL3gvdmRVNWdZai9QT0VSVEJMTFV5aWw5Rk95S3B1RWtEdHdG?=
 =?utf-8?B?WGNQb2E3MFk2RU82aGt6MjB0NzdzQThlbU03NW9IUWxhNnJzTnhWdWptamlk?=
 =?utf-8?B?SzZCN1czSXhTNXpKTHprTi9NdkVFbW03U0NQYWJkeWE3enpteVo1b2ljUzRM?=
 =?utf-8?B?TmVpQjFSVis4c3pGRjFUTzNZd2VhbDV3ZEFpc2ZSdkFWWHhBVTM4WU9LVWRI?=
 =?utf-8?B?NUp2QnlESFdYSzdVaUxTOUV0ekY4WGhPOG9XeFlTT3ZWWGZVZ014TndxVUFD?=
 =?utf-8?B?Znl5WERoRUpBQ2trbmZ4VmR1VHFZMG5kbjhhUlBiU3l3c1pNSDZ1RXdjNjZw?=
 =?utf-8?B?T2d5STZDcCtVcmsvV215NGEyQWVyM2htSDNwTXVNSnJ1Zk1USEwvaXB0aFk2?=
 =?utf-8?B?Zm5NRmF6Zm1HQ1h3ZXhXUWxSQUhGSDZXZ25XTHA1aGN0ZDVWS0lXOG9IR0po?=
 =?utf-8?Q?98GDhaInB2YF2NHjy1ux7Abo9UaMQiu9w6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2021 16:20:55.0134 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 811071a3-f1f4-4e81-d40f-08d8b71609a0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2N6bqZLWbwJjdQXCG5ht8gg5gqoddIivwuY5CosO2k94sX87R1wX70FA7ggF0QWTdi4CUb5UTaaOzjx7y5l1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2598
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

On 2021-01-12 11:13 a.m., Bhawanpreet Lakha wrote:
> [Why]
> during idle optimizations we acquire the dc_lock, this lock is also
> acquired during gpu_reset so we end up hanging the system due to a
> deadlock
> 
> [How]
> If we are in gpu reset:
>   - disable idle optimizations and skip calls to the dc function
> 
> v2: skip idle optimizations calls
> v3: add guard for DCN
> 
> Fixes: 06d5652541c3 ("drm/amd/display: enable idle optimizations for linux (MALL stutter)")
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index de71b6c21590..82ceb0a8ba29 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1816,6 +1816,11 @@ static int dm_suspend(void *handle)
>   
>   	if (amdgpu_in_reset(adev)) {
>   		mutex_lock(&dm->dc_lock);
> +
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +		dc_allow_idle_optimizations(adev->dm.dc, false);
> +#endif
> +
>   		dm->cached_dc_state = dc_copy_state(dm->dc->current_state);
>   
>   		dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
> @@ -5556,6 +5561,10 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>   	if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
>   		return -EBUSY;
>   
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
> +	if (amdgpu_in_reset(adev))
> +		return 0;
> +
>   	mutex_lock(&dm->dc_lock);
>   
>   	if (enable)
> @@ -5572,6 +5581,7 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>   
>   	mutex_unlock(&dm->dc_lock);
>   
> +#endif
>   	return 0;
>   }
>   
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

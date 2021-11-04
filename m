Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48914C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 09:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB411611C4
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 09:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EB411611C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 827B06E2B6;
	Thu,  4 Nov 2021 09:53:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C78906E2B6
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 09:53:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jjb7LhXutM+aw13YZmGfQquJ8bnMZeJetdUToUd+2a9KVZcMGOflRbqw51cYSqajjCLxPYE4MzQaXONuyM+w6/BSdrKiDRPanrVyC6InHs8QMHmh8GT21bEZ+BiT1D0y81dk5E0GTMHNTHulCBjINe1L3jM1FJjK5MWd9AM3jvGsqkNXG0qyImwNSuoAFuj0bwoJrty92LmkFUedDIZRjmsB56hqenFjqmSopJJOBDCEqRZ1nhM18DicwCnxSGK4fONtoVdGqUSINVkB+PFqLZ1H2nv0hiQXD5vKVbQr+y9eUdftVrGrA1puXKKJFgHgC5itEyl4lRlnaeBIi4F5Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RA0iS+PWyNvQDgqu/7AS0D9X5FprKFVv2usgj2w7bow=;
 b=GBrQ62B3NoILy/YDUD8j/50Wetw1uzYPKD9z6nTbVv2pKOBye8SYpPpaA3Og8RIF2zxE0Q56NutSOHkkUIK+aIUDBIedRE0wWTikZyKCklVU6zfqK4ZnbwUxHYN1UsK7EXvq8EaCAFWOyLfCy84PMCO0y5gQGTUWQ4ysg0zCLkwnz6kmWBksWbodnTj+znKegOib0Nil2/anZkEqLZMRYlBB028juUS2JrvSSnWoUkDhwsJSbup2zJmF8Aq5z51Gp7B4GeZ5G5vcvp5+vzG4MIjxRphoLoz71nF4k0lnZW4lk07GG5w6APFs3IKhURc/wxiiM/GhXBMgpzJNceEf0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RA0iS+PWyNvQDgqu/7AS0D9X5FprKFVv2usgj2w7bow=;
 b=XVxe2cwisTLCBeUPHLRzpMYnSSK598nD1Mx3hroNgzkD40ypGMZoYO8b8icnlGGOTZX1kHHB9rP1EW4RRa8jxssT6oyKXj2sC9+WH9B5XR4FnxdD/xKeVCbNfb/OW0SbgpSHS5zDoYKZ+pyj54EUm/3dipCYGVb2CLa8XE0dT8Y=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MW3PR12MB4443.namprd12.prod.outlook.com
 (2603:10b6:303:2d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 4 Nov
 2021 09:53:53 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::2d02:26e7:a2d0:3769%5]) with mapi id 15.20.4649.020; Thu, 4 Nov 2021
 09:53:52 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: Fix csb.bo pin_count leak on gfx 9
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211104094021.1311552-1-YuBiao.Wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f4ca35ed-3d3b-3207-4c87-6eef7fc9364e@amd.com>
Date: Thu, 4 Nov 2021 10:53:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211104094021.1311552-1-YuBiao.Wang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0081.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::34) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [192.168.178.21] (91.14.161.181) by
 AM0PR10CA0081.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11 via Frontend Transport; Thu, 4 Nov 2021 09:53:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 095ad19c-b79c-4adb-ceda-08d99f790165
X-MS-TrafficTypeDiagnostic: MW3PR12MB4443:
X-Microsoft-Antispam-PRVS: <MW3PR12MB444352A2950866E98F496969838D9@MW3PR12MB4443.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uNY7QY+UOSh4YBEHdj2vdyvOF8OkP2bVhLPlBLW1g4X7Z2Jz00TBWwYOvC9O++wDdmGxyf/yBOHu5+Wa7yw7neJR9g8iyLLkzc3TbT7HChQTRxNA9JLDZz0ob2fHRSjNia7eZyuUU+scF9HT8HenRVpbgtehkXJHIBBe3LyGhEAt7ds1YBzuog2Lkm7ZtnJJcOnEROBZMFnNrZfGHWaE46RZLCSeglsWv27A93NTdfyIcyDtCaUUvoGY59noS7eTKSxffrKt3Ubk1UOlalpM3Vb6HaXvjJzoIlaQ5itf2ihx+qhs7jCUqUy1sk8CwDHVKEPcgydPeudAf0Me/pEmbqy5ojUFsWLlT8apLpzuAOsVJlTF5CpehIHiLzI+Y4jbU4iDmaIugybeCCK/ZviqtuMErWp67ksQREkoTl3GImFeiIiGSAhvl6RW6c9j/e9lAasOzk0Fw7Vlw0sTiy50zL4vqZb4Q5qQNmldEWBpdvGdR2kx0CfyN6uKKJrEBiDq1j5XKg3fMbtUNThwNtDQXbi6SBK5dKrtajqXZulscIoJbRxXhBO7KizSg9g7vWm3G26Rv+E/ULCK2UyhvFljwGDWctPbztqbWTaukJLPLjkVjRkLBvnnxvPFnS/e9rqP3NCIji4tDmAmPAgjqLqpo4oaYaAvdqFXYEmfcftzfRpl5oDxgJhnXz0czeg1/IRD4eNmgWBgnIdVMYD0WYLF2ZAbYOPmaoC1sp/NKJoio6NiSSYfSx9M6GHTIUMxm465
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(31686004)(5660300002)(26005)(8936002)(4326008)(31696002)(508600001)(6486002)(186003)(83380400001)(956004)(6666004)(86362001)(66556008)(66574015)(54906003)(2616005)(2906002)(36756003)(66946007)(66476007)(8676002)(16576012)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmdoUkNzR09Dczk2UnMyQ0tGV3BiamNhMU4wenFlSkJWalJ5WXRpTHdlN1hU?=
 =?utf-8?B?TXZLWDREdFdNRnp0bWJuTE40bjNFb0llRkM3cTlVVlduWEZoVUp3TFFjaVdQ?=
 =?utf-8?B?Z0s4eWwzdkNMaHF2WUNnVHFKZjdGMXpwNEQvZ3VNNHhISXU0RDJBM212QXYy?=
 =?utf-8?B?V1JCRGIzazM3NnZtSVUvU25NVEN4MVVxaGJPL1pMMDJrVTJ2VlN2cHVLZXk0?=
 =?utf-8?B?a085dHl6ZitDVVhKdUZ0WWN1WFZuSjRzYVFzRW54ZktaQUNjSjV2dDRjU3dp?=
 =?utf-8?B?dWRtQm4zOGh5TCt6OTB5bkxiWUVXb2Vwb0c0MC9adG83REVVMFhSL0xhUHhB?=
 =?utf-8?B?dDkyZnY3L2JvR0RZcUVnSjI2UjdFZTJrTE5reE5RK0pzbXowbkUrUWxpaUwx?=
 =?utf-8?B?QmtUWjEyeGF1aVlVZ0lWL0lJbFhRRzFsd3NJMVg1VDRFOG5xTnpESVp2dkEz?=
 =?utf-8?B?T1hKaDJoVEZsNEhKc1JmV2ZqYUIyZW1EVUV4NGRWZFB5ZlF2NDAweFF3eVB3?=
 =?utf-8?B?dDZwNExQZktQMk5tNnpwdjBhY3U0RFlKcnJ4REFpSUZhR3BnSGM1VWErR05E?=
 =?utf-8?B?KzhsOGtzT252azBTQmk1dnQxeUtMRzRzSW1xYjNHMWN5TlZxSkJOVUh2S3Br?=
 =?utf-8?B?T1Njd0RZRHdIMHRxY3N6NTVtUE13L3lFSVZZdU9qY2s4VVhubXlXSk82ajZV?=
 =?utf-8?B?ZG1RZVJhTXJDT2RYWU9sT1B6RWhVa2hJS080aWxjeVEzVmxjd2RjSXF3alJB?=
 =?utf-8?B?L0pqSzdyS1NoT2lGby92QjB6aFFPZGkrTE5aaElOcEFmQUx1emNmeWtObTZN?=
 =?utf-8?B?Q3ZnejRmTlVLMG12K0RvMHFPemh4MnY0T2xtZFJYTys4czZLNFNZWHlINndP?=
 =?utf-8?B?elUrNjY5NldBVk9tSlpyVSt0cG5GejNyOWVwUm9CZWVJazhPeDhTQnpMaXNk?=
 =?utf-8?B?UnVnbENVVmdtV0lwN2NFMkZPU1kxdy83RmRqaU5lTVNjRFJ2b1AxS3h1MEs5?=
 =?utf-8?B?aTQrRGJXTWYwQ2xWNG9mMXZsNU5KaC8vd1ZPT3FhdmdVSnlZajM5R3ZiWGR6?=
 =?utf-8?B?eW5iMUhvUGpGalFadzlnNzlhOUFXRmkvT2J5bjNsL0dhN3gxZnFqZ0pONnNW?=
 =?utf-8?B?QTNzaGVQTEtRaUxRT2d6cnFpbmt5ZFhsUWJUSDlZRTBWOHJwenFVUjdoME1z?=
 =?utf-8?B?dE9rR0M4SkpxdjV6dEVrR29IVFpTQjlQdm0rL0owekxZNFI0SVAvNXZXUmJZ?=
 =?utf-8?B?R0g5RlQweG45bkVXaXdUMklSSklhY0NjTUVrU21Gdml4dy8yQmxWY0Z6eHhX?=
 =?utf-8?B?cHQwYkpSb2o3SWpLRE1kTkJNdEN2U0NuMkJ0cWdib1p5S29zK3VSeEI4S1FM?=
 =?utf-8?B?SDMwMlZxbFc0Qk9wYTdNM3E0THBJMXZjM2U3QjNET3JhS3MrQW5uSnUyOXBB?=
 =?utf-8?B?UFVTRFJyNlgyWDVldWRSN1A1MzVzYkoxdmo5V0VYVjVsSTZlUjlDbDdaeUJT?=
 =?utf-8?B?SmFTdTk4cjVIcTE3VU9OMjRZTVlPNm5SRXN4SXRMODBOQTZZQVVTUGVXYksv?=
 =?utf-8?B?YTdtb0VndGgzeXlyL3JjekJ0Wk1NQU1oVjRFVktReGdnY05wTVlIMkJrNXQv?=
 =?utf-8?B?M3R3Z2xzaVdNaURwOEFJSXVXMHVaSGJYd3NZaWc3dFhUUnpUNisvYnIzcmJ2?=
 =?utf-8?B?YjdrWXlpaHhVU014NUJRcDRYa2RsMGVHU3QxM1ZTbWRKUnBZWnNncGd4a0Nl?=
 =?utf-8?B?RVo2R3ZOd0N6MlM3NGR2SmpZR2hxekNESDdsaTU2YXJQbFNOQVc5cUg0aXN2?=
 =?utf-8?B?SzhXS2pJUVpaazlFd1ZHQXIrVlFnMTk3YXdwMy93aGkxZmpQVDRQUzZEYlZ1?=
 =?utf-8?B?Zk4wMTNWcFVUVEl0NXplZ0lCREJ0bmFzVWFYYjFFUmhVK1phSGFsTllGc1gx?=
 =?utf-8?B?dzdxOFpiYkJuRDBUV3V5NFhVU2RCdndwZ2o5aWRhL2UwWkE5SURZNm5hbnZo?=
 =?utf-8?B?emdId0k0VzJNbXl5d0xERFhJVTlyS2pjeW1hTUVXUnp0bS8xcTZIR2QxR3Vv?=
 =?utf-8?B?dXpHS2MrcS8wY1RIWGQ4WS9wdi9sVHEwcXQzMVp0T2l0YVNXNGRWWURaV1B1?=
 =?utf-8?Q?g2/w=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095ad19c-b79c-4adb-ceda-08d99f790165
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 09:53:51.7932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLegyt1AH5J1Qn9nc/+h/sbGOb388X6XcQjkNiWHV+7NcZZyg0FaCspcmbI/f8qO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 Jingwen Chen <Jingwen.Chen2@amd.com>, Monk Liu <Monk.Liu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 04.11.21 um 10:40 schrieb YuBiao Wang:
> [Why]
> csb bo is not unpinned in gfx 9. It will lead to pin_count leak on
> driver unload.
>
> [How]
> Call bo_free_kernel corresponding to bo_create_kernel in
> gfx_rlc_init_csb. This will also unify the code path with other gfx
> versions.
>
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 7f944bb11298..be803ebd543c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2462,7 +2462,9 @@ static int gfx_v9_0_sw_fini(void *handle)
>   	amdgpu_gfx_kiq_fini(adev);
>   
>   	gfx_v9_0_mec_fini(adev);
> -	amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
> +	amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
> +				&adev->gfx.rlc.clear_state_gpu_addr,
> +				(void **)&adev->gfx.rlc.cs_ptr);
>   	if (adev->flags & AMD_IS_APU) {
>   		amdgpu_bo_free_kernel(&adev->gfx.rlc.cp_table_obj,
>   				&adev->gfx.rlc.cp_table_gpu_addr,


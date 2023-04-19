Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DAEC6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Apr 2023 10:45:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ACB210E930;
	Wed, 19 Apr 2023 10:45:49 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D2210E930
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Apr 2023 10:45:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkqx+w3RzS+3inJJlN2yVCieRlaTK5u8FjuzZAZm7BzvrU+yRhEwTsOOrEM9XSD49kzZ3f8Pzc/6NLk9LxkdmykSfInLdGHj4rcmL3E9B4EYpxbEztfe+mQQ6TfxyxaLrAHWQ8j6PhhNM/byBsaGNbek6+gF02Y0qcbmyZndH0ka8+4lV3Lgpjm33pposhXAKus5Mn5bXz/5+wysirsTrLNHpI0wEyqDprrOeMbANS6VhCcrkJmv05p/5C2fUULzoysHnxbKOhUP5VyHIcSheD0vkm2GyiAhP/mzcADANAUKjMkkFk4Cv+WgayHhEhU4X6uPZVoh13zgDgBnjXuNqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZp2ufQAaqYx6UaNQHI0BtCObhIUHN4q/j89yUqQ8oo=;
 b=DQRRavTj6OVJkMw/0F0ROK/MDiVk1tQ9s34nOLsXviKvNwtinaqdNzgAaN2upHveklsPNo9lmgd3m2znO46hYFyUDf2VNH4+3nTC+hw52vTSR+amqzFB/eibQ0+2TgdLMekF6SxL7MxCEz6GnRTTjb4vD+JRZZvmEEoxj4b+dpFJs8OeBZfViNMUuUz8rMyss4LEw3gqsFyaGaHrIdNUXcNfMjEG5xoaPc6oATTwLfiyo04NJjHwL/qEr0jdH8qgMOeUM64Ka585DOvOhFrpMIZZbiKIWn6sMg8CwN6+3yheVa/V69zcsNLZv4M+qdSvcR9bLCE3IFw0NaKCMT3sFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZp2ufQAaqYx6UaNQHI0BtCObhIUHN4q/j89yUqQ8oo=;
 b=09y/vvlj18QIEeAtu9feAROIBLPDASHqYjAxL25Tq0+QKhYbkPlvSP+96ERM5AfHoedAgN2OV2Q5oZjlNDBEoyC28kJgoWySICNQWITsAxC64I1Aw4v5eWAnGEz4ibxdptPHwEHhF1iy6xhefTSOQ1DWvMT/dtxMO+5Mmw6iwTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM4PR12MB7525.namprd12.prod.outlook.com (2603:10b6:8:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 19 Apr
 2023 10:45:43 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d2f8:7388:39c1:bbed%3]) with mapi id 15.20.6319.020; Wed, 19 Apr 2023
 10:45:43 +0000
Message-ID: <6b919e01-bf37-26de-ffcb-ad82c9dd23fd@amd.com>
Date: Wed, 19 Apr 2023 12:45:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amd/amdgpu: Fix spaces in array indexing and
 indentations in amdgpu_kms.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20230419093445.4168345-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230419093445.4168345-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM4PR12MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: db71e9b8-2ad3-4455-0217-08db40c3394e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xo2f2Ka5uz78oTJLDBd8zS4IaUefvmtBKQTaFDSpafQON5mRWKlvcV3OamlO6pcXoq7Lx2ttmMmbNBW6txugEWizfFv+FkOwibuorKk7Zhu/yy57RSU1cd3J2rtCqpekD4xpR+jpwuLZLbXafNUTYGECc7ETFZ2+k9W9jH8TpGvvMkrop10HzTOV58RfuhqykAb9CjY0Re2A9OSTlu4fYGUYWTTFMIQ1D33VA6VlzVWZCdHDND9d79rsWkJxUkUhOoGYmCZLSNufn8zREtwrnhNgqdmB0LFmM9/adL5SHzeORCHcY+WHd/9Q35vml8+q8qzLNFc6GYAkhZOqz13P9ErJEOGlLF1E4p65/5Kaqz//Z4JviDteFzIBIqZeRpGVKTRzTwpNBYDEfw4ozaft7WIUwwsyap4Ch+ftkLIYykGY7wNmsWUHOQm1uTt3fpQrMTgupdejhuNqDY8WlzdEasPhrVRnLxbztM6xaa+QNOI2KgZ2OXLdYjJyJvKBT3w/gVdBU4rhCu1gptcaioDLllNpVHofb3F4xlyOnK/wh7WBtTU2QffF/UnS5hVBrkbP2XVoo285yrBpGhJxHnIMLPu3mEj66JmnDStJAUDeYfNxDcqXP2eCuYh3ktJQJJ6jgrZsq8QGi7rhnwezFXittA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199021)(316002)(36756003)(66556008)(6512007)(66946007)(38100700002)(6666004)(6486002)(186003)(86362001)(31696002)(6506007)(2616005)(66476007)(110136005)(4326008)(6636002)(83380400001)(41300700001)(8936002)(5660300002)(8676002)(31686004)(2906002)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0dyaCtGMzJWVkt5V3dJQkEyaytITEtiRHB6Y0d6ckc4eldabjNIeDAwQ0xZ?=
 =?utf-8?B?WnJZRUUzZzFUaGRQb0d0QVM5SmtUbitJSHB6c0gvMjFST2JlY1dNeUk3Rjg5?=
 =?utf-8?B?RTRrcDZ3YngyYnk0SHBSMFE1d0ZkQjdoL0JIQTA3SHNDbkpIUXFlT3FYWTB3?=
 =?utf-8?B?S2dPSVpRSWg4UE96UG00K2QxREtMY293eU5yR0hUcVEzUGFGVDcwVXB0M3BT?=
 =?utf-8?B?a2llQ2luOVBPcUZwVU1yaFBsZmVQS1VwaEN6VTFlZEhCK29xcUNkUDBtVGo5?=
 =?utf-8?B?Ym5EZWU0NVJUSVBPMFJXbDRhcThRVXordVNkQm9uR3R0ODVWejNkeTEwRlVu?=
 =?utf-8?B?bFljUnliR0pkZitYT3ZjUll2aWc0RlMyY1U2WXFwTEJrblpXQjUrb1gzc3Fi?=
 =?utf-8?B?empzMGE5WkdwblNpQ2xqU2JxRUN4eVBVVW5yYVdxSXJFcWtRR2dITUxIWEt2?=
 =?utf-8?B?U3VIdUVZcUhRWjhKM3gxcTRnT0lCNnVacVlrOVJzSlc2aDBZdzVOU1pJMkNk?=
 =?utf-8?B?VVNpS3ZYS3VqanUvQS9FUTdYV2JJbWxkL2lndVN1dkxFT0JXeU9iRW9ZQXNN?=
 =?utf-8?B?S0pzWFJZK0FqUndHcnppSWR3QVZKNURxUFdjZVY3ak9jMU9DTFZnNkpkTkFE?=
 =?utf-8?B?ejliUlRyaDRlM1hIVWlBZUx2ZG5rY2h6UFBqOUdMaExCTWlpK283RGFvejJq?=
 =?utf-8?B?a2YvYjRyR2FaOUR5S2ZEb25jVHNhYk8xOW52K0xPSmUzWURGNW9OdmhuZ29u?=
 =?utf-8?B?eWgrcW13aGhNWXV3T3hLY09xM01aTHRiUzJzclNCSjRoRVZVOUZjV2dZMUhs?=
 =?utf-8?B?bFRzWHNheFh4emlwZUZ6MWgraENZVWhWTURyK3dQMTdubEZvSUx1cXJJUktX?=
 =?utf-8?B?QWtwcGQvcjJlM2t6QWx1ejhIUnZqUlVPL3p5cDdweHZBSVkzbFFIQXEyRUU1?=
 =?utf-8?B?SWdEUncyQVppL2ZGNE00YVJoaFZJbURiWmw5c3ZiUzNQazZhRlUwWEFSdUxn?=
 =?utf-8?B?ckhnOVpEekZ3UFRHSmdnWVF3VUM2NEF4cm1WRkRmMm5iVGhHcHVDQUlRTzVS?=
 =?utf-8?B?TDlmU0YyZDBKRDVKSW9ORDhnYXZ5cHdvZ0pBU1VwemZQcXUzUEJVZDhrc0Fa?=
 =?utf-8?B?TWlNSGJjTGxmbTBaZFd6YzE3WTRlcTh6U3pUdW5xTzNVYk5HZkN2ZnF6NmJr?=
 =?utf-8?B?SlF1NTFlOURJcG5VY29uTThXV01zSDhqT3k0Y0NBbDRnZ0dtWG9BNnpkVllO?=
 =?utf-8?B?NHdJUGFTM1dCaWZEWmtxTjMvMkc5blRjZUFkQkN6VXFGd3h3MS94MTMwUHA3?=
 =?utf-8?B?UGRCakpYd05TcGVDNzFkY3JLK0V6Z3dQbzN1M2RNd2RCS2FEVGt2KzZGQVRT?=
 =?utf-8?B?eG9YeFhTK1pyaWJYYXpiUUwranJjY21RVmpVd3Y2NXljL1htMnN3Rzh0S1BK?=
 =?utf-8?B?R2pIWWlFL3N4YzNGMnlHSVVuYlFUaUxPM1hIZTB3enl4N2hKRHNaNGJtSGJk?=
 =?utf-8?B?ajNKbjFLZkM4OE8vYW1FcWJkWEpxd21ldHFXb3hEekQ0MEJPSU4rVzMzdlJm?=
 =?utf-8?B?cmdNaUJ0QjdOaElvZU5kblVhTzlTSDhBRDVyMHVXOGllcENJdFBEQldDa0Q1?=
 =?utf-8?B?Vit0UnZsTlJwamZtOE9qYUlkdms5OXdmRHR2UHMvUVU4cDh6WGtUdk1kclNE?=
 =?utf-8?B?K3NWTFhEMFhuV0dOaEJjcmZvZ2R0VnZXcDhGYnFKbDVNQndFS1ArcDZQSVYw?=
 =?utf-8?B?djZHemxhbnIwZElWV3FQTVpTaTBoTGEzS2tkd3Rlc1I4N2FBZDNVdHMzUHVJ?=
 =?utf-8?B?T09LUGF4YlRhU1N4LzhUQjhLQUZzM1BBWDlZS1lZQnI0ck1ZbDZSMkpPSWZC?=
 =?utf-8?B?VWFmcHYwT24wN2djTDlscmtTYUc5SHFpbEZySEJOcGgwY0pNWlkzNndPaVZD?=
 =?utf-8?B?elBRMkM4allLNkpZRVU0MmpCdGpWZzF6M3U4bXJLMW54aDc1TGNISlNYODdH?=
 =?utf-8?B?SnVmNUpqSWM2N1FUWU9GV1AyMmhuOUhnYXQ2Ykd1NU4yODdSSFRsM2RDTHNU?=
 =?utf-8?B?Z0tkSlcrSnJsMUpGNENCWDJTRTJrcCtveVVOUXRNbVEzakR5SHFLUU1VRGZE?=
 =?utf-8?B?eHFHR2tITEtpM0dROXVNN3lKTXBva0Fidzd1V3VxQTFnejk0Mkl2b0l5cEJ4?=
 =?utf-8?Q?0jNQwX5yUCFK9vkcm2NPWs9s7OeaHb2btLWPTSwaV8lp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db71e9b8-2ad3-4455-0217-08db40c3394e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 10:45:43.0085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5YIETFqUH9prVfTFCNxB62oViNrsta0tBdHBVvnqKxTrWdspbM1lj7/H0u6vawM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7525
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 19.04.23 um 11:34 schrieb Srinivasan Shanmugam:
> Fix the following errors reported by checkpatch:
>
> ERROR: space prohibited before open square bracket '['
> +#define TA_FW_NAME(type) [TA_FW_TYPE_PSP_##type] = #type
>
> ERROR: code indent should use tabs where possible
> +        query_fw.fw_type = AMDGPU_INFO_FW_GFX_RLCV;$
>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 1a2e342af1c0..a5bae7eb993a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1458,7 +1458,7 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
>   	int ret, i;
>   
>   	static const char *ta_fw_name[TA_FW_TYPE_MAX_INDEX] = {
> -#define TA_FW_NAME(type) [TA_FW_TYPE_PSP_##type] = #type
> +#define TA_FW_NAME(type)[TA_FW_TYPE_PSP_##type] = #type
>   		TA_FW_NAME(XGMI),
>   		TA_FW_NAME(RAS),
>   		TA_FW_NAME(HDCP),
> @@ -1557,7 +1557,7 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
>   		   fw_info.feature, fw_info.ver);
>   
>   	/* RLCV */
> -        query_fw.fw_type = AMDGPU_INFO_FW_GFX_RLCV;
> +	query_fw.fw_type = AMDGPU_INFO_FW_GFX_RLCV;
>   	ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
>   	if (ret)
>   		return ret;


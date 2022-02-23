Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D9DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Feb 2022 15:23:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA0910EC1D;
	Wed, 23 Feb 2022 15:23:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DFE710EC1A
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Feb 2022 15:23:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCwpDMNpcpxS9zijWRiE0kTVwAG2RcXMOzNOVulJh4jbSU4E1MfxRIU1Cb91ONo+bIKSCp+ro1rGkz2cCN1EBgM9v3ge4kaon6xzAkFAroxC7L/J8/BmrpP8YVqBXlD1cJLxmGBeoTw3HUOfzfneDZgmp7FnqmkDpMd5E/uHwX4JONAbQxGaVYu0JvgPaHQmwAm593U8AI8Yui8aMChWLR915Qvops/pTYCOMhMKeEx6IXf4ETuUT42meOPO6J8dNZpaC+7JUAz25c2mKEZtyDSAZuZAEXWeOz5hFIPE+XFDd4jWeBW0BnYubsSlXWeA5U55rP8hD7s1zCaN6LkpiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5mdA8gS6s2UCSvgXUMvk+6PJ1zsDjcRw/tFyFQ690M=;
 b=CCLY0S1Me2jwp9JUD6SZzuK+CzaVSpF3OWHOMYs10Admzm1+JQ2TIdfaXGbtRhsE30UjYvKwiDMh8b3zCkIyzqWVgWVU2BAZETrSNFaYeKYLgkeGX8d+NZA1syq4Q/qKBnJOItKbGdmepHCZm9tLlAjvIwvhSvBtQq82/Ts/IzmCV5ReSz50MgSfAq3c3D+xm0KjvYJZjzWJyUwePK3Nm39c1dquYy44DrPP42Rj+4fv+xRRYfu7RtQEEDdQ1FqX8XPl9HEziMDJL6Mm+P7E9JaalYmWUcXGkQeLj3qpQp1TkrwB0yWzmZiZTLkYOu+OqzspGoHQ6Ss05sXLbehK5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5mdA8gS6s2UCSvgXUMvk+6PJ1zsDjcRw/tFyFQ690M=;
 b=3b1MsPGtlPvxLuqapq4NOOHzjmmJMkaG9kmO/kh6AANhpCqoCezKtVIFWOlnzDvRbxLO7gzqYwQw1KeyQKKGKYPmI6Z9MpDEWIBCAihV9rcQo/LMPC3f+InDvKYZjwL645lRk7HqKlrlh2b1wO3d+U/ZTE+5iyeYh36i3Ty0sB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by BYAPR12MB4695.namprd12.prod.outlook.com (2603:10b6:a03:a4::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 23 Feb
 2022 15:23:29 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::192:5346:4ece:7ca3]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::192:5346:4ece:7ca3%6]) with mapi id 15.20.5017.022; Wed, 23 Feb 2022
 15:23:29 +0000
Message-ID: <0f50a5a5-3878-4e9f-9b94-7b440be66a40@amd.com>
Date: Wed, 23 Feb 2022 10:23:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] Revert "drm/amd/display: Remove unused temp variable"
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220223022839.1645469-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220223022839.1645469-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::9) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b389601-a278-41a2-4ee4-08d9f6e071db
X-MS-TrafficTypeDiagnostic: BYAPR12MB4695:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB4695312E1C7502E0054187448C3C9@BYAPR12MB4695.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D9Z/nFlxcNPmghsHC6sO85YVTmZeZTZn/m0F5Q64X8TvbQcGinXLUoZtWhdQuW/DA5pVgXQPLpVJrQo5O1fUe/Ct0KLJ+yvDPcI2uDGX7RzgXFGU8S4z3aTApSj5pb+s+hEOMuMRARHP3EXrTr+SJw6uOA7+HcyhOWIx1xWyMFbtqBnRrLvh5HU3dr1yqhL1vQenKlgRXo8xvK+zaAoCTQgG7Wz4lrdU2ucO+wkA1hdFye5UxfXnYVZnnjL3Ky7UOOQtXtvraRa9wL5himCca9PZ0WHDrKJJs0ynK+mBQ4CKzAmnV2cSgJZXRJ7uvdt2Oej5vzmheaQ4SguRyEL1OgQrUKe5MGIAOEtJrRqd1WSnElLP6d74ERNtMyapaKSHvWfoHY3lIe4MYFKwlse1/5qwgTy9Jkf7srTn42ZoKm1OFgGhIs4Hr+0qVU5Nc9+3+tI6sEotk6mERaAjHKN9qT9jF9KQSiPceU/ocAoOKi31PwpvzDGRZ2Otet8Xgl7LPYJMUJlj8DajF4FebSpstt1NbZ15fhVHlX6a3mHXG/H29ShumwnUquVhO8eEevs+IcGPzU8l/0S2cejTE857WO5UVvTWBCfY/YID4zrJ/eslppCf1G3Zd3x40M7KDBogBhC7th0c/XJvAFK8C/vlinJNMame2sSvYhz6kz3WjwxBchm36ZO8AMgN2EJTW/q5N5jRaJhU5fFICJEvuxMmNzj7ju4/4gNRdloWO/NnhHFFpxN/RvksW9zYt0HRxnVW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(6506007)(86362001)(26005)(186003)(38100700002)(6666004)(2906002)(31686004)(53546011)(44832011)(66574015)(66556008)(508600001)(316002)(83380400001)(4326008)(966005)(31696002)(6512007)(8936002)(66476007)(2616005)(5660300002)(8676002)(6486002)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVVnMndMV3lNSldmSjBSU2RoWkFwc2tQY1MrOUFZNndWcXM4S3NNdFRhZXZY?=
 =?utf-8?B?TlUrL3pmTWxOVWplRlVMdTVrMXpuck9LSzdsNWU3U2JMTGhJT3B0SDFLWXg2?=
 =?utf-8?B?TXZZZEFzajBaU2lrb0VXRXB2Yi82KzcrRHZodm9qSmFQb2JWSkVrN2QrVGpz?=
 =?utf-8?B?VkRIbzBUcGZ2L1BSZHd1VHBYL3dLOEZhOEdESXpFTzNhRlJSNFJTeWFrbC9V?=
 =?utf-8?B?YyttbE1NVnEzY2wrWlZvc1dWWWw2N0MvdU5aN211UHE1VTZKSVdVbzRKeWVY?=
 =?utf-8?B?UEVkY0tzcXBKR2J0Q3FSRWRUVnU2eWZOekdEZDc5dEtVQmQyYTZBM0Q5QXJ0?=
 =?utf-8?B?NnZaem9VVDNUaHBwUDhCQ3I5aFJUK3hEUFFueS9taWkvbTFsNWVJZE96L2VH?=
 =?utf-8?B?aW9iRm5RanFKTXVEU0IwUisyandvMFcyV2g0OGRncDV3MzBCbHZocUpJVHhX?=
 =?utf-8?B?QnN1U1pRYVJrSElCb0JVbXFaY0w5UXVlanZYZzU2dTdNVnM0UFRGS20vRHR2?=
 =?utf-8?B?LzJNWWdoOWtLTFQ0aTArL1dVREJkOHZhVTZ0a2NXYW5RbWl4SjFiaWVJMDFW?=
 =?utf-8?B?UlpBTEN6Q0h2cXJEWFdybUV6YTc2cGc3c3V3M2RzQUZDclNLTDRCQ2YzanFQ?=
 =?utf-8?B?K1dwTDkyVWZUOEhsdmZxc09hdlNhK3JFTENRVFJtTTJOZDVueDVnbWZHVFgw?=
 =?utf-8?B?d0pyd01LR2FTSW1iQW9wU1k4SHA2VTJQQzI1amdsbEtxTlo1c1RwS2hSckRt?=
 =?utf-8?B?ZGpCb1dVMHlwL3FrOWplYzVvdWorclhHdjNRZjNXeFM1MzlFZjBEMnBaR0xV?=
 =?utf-8?B?dS9KOTBieWRDRFZMY2ZnVy9SQTloUC9SdVk3OHpOUGx3YVc5OVpsSFdSZTk5?=
 =?utf-8?B?c1NQVEdRY2Z3aGh4TTNLMHJBc25KaTZndDRXMnJBamtYWm9XTmZ1b0dwU3dX?=
 =?utf-8?B?VXI3WUVCdWZMdENHN2JzK2ZhWWlJUHdzbWxuQjNiK2dxZmlEMGdQSi8rMU1w?=
 =?utf-8?B?ZlZTV1N5YXU3eGJPRDVBSzgrZitFSURVZkRLc0JNTmNhTjhpdWg1cStVaVd6?=
 =?utf-8?B?UGI4K1NESDZUMDFRMmtKak1XYjdkWGxuL093bmpDVlBRY1lLM1RPUmswYm82?=
 =?utf-8?B?dG1WZ1ptYzJobEs0UlVKQ29FeHdtcGp2dG56c25TY3dZUDRWK2EwbXlTclRT?=
 =?utf-8?B?N0Z3SmNDbXJveFpVSGg5aEJ2UUV1UElQdC9Pcmp1dEFINEFUc1dTM3JQQUw3?=
 =?utf-8?B?dUhBSWNITnl4SHExZXJSK0RtYkVYR3lDandLZWZyM3FoOEsrditpNCs0WXZq?=
 =?utf-8?B?SGFuNk9XRzBIZ2xQTEU2amdwQi9MTCtpMzNqUWJYcENEd2lBUDZ0WmRVNVhU?=
 =?utf-8?B?QzMvb05RTGIxRVFMdW40N3NXQXl0bW1DbzBYMkdjYnFuaVJ4amR6Mi9mZEtj?=
 =?utf-8?B?U1hvOG1OQ3lveFN1NTBZR0dYZWVIRjlHTXZpNk1YaUhQTTZYaDRsUEdCSnBH?=
 =?utf-8?B?WVh3TjF1RktqYWFSYk41aFFYdm5IeHJwTVViYUF3dGtQZDA0MHNzaVREam1Z?=
 =?utf-8?B?R3RMRjMwc3lNYml0aXdGMy9qcnR3YUlGZlBqL0pBeENIdTF2b0liN0pkVW1Y?=
 =?utf-8?B?L1BBUnczU29saU9kZlhBS2RPZnZZT293a2krR2JGYUs0V1RjcXpBaGhyUDlC?=
 =?utf-8?B?UGRDZDBkajFUNnFtUE52dGFZQmQ5TXgwYXJaYURpMHpqZTFINWpxWTkyMisw?=
 =?utf-8?B?bnd6eXBZOFJORmlwcE15aGpkTEsxYzJsOURVVkc4alVkM2Zyanpod0tPT2VX?=
 =?utf-8?B?SFFMQXZTajlqUlJTYkFLdjJFRjVvSTBHZ2xobFByM2MrMm5ZdWtKRDgyUmNX?=
 =?utf-8?B?SUovWm92VDh5R3Q2NDFnUnluL2wwQXhiUG9USHBtMkJMSjJoeUlVUS9MeVpS?=
 =?utf-8?B?NlIrY01hSHRkR2QxSk13T2YrUVB4b2twNENuSUYvaktnWENWVUY2dFZwK2da?=
 =?utf-8?B?YlpMNmRoMkJ1R3FldFp6TmhYZDdVa0FROUl6RVNOaDNjVlUyaE15djJteEZP?=
 =?utf-8?B?aW9EcFEyTWszZG9RekxlTGVGUGIwL29QNTFYY3F1N3VrZzFKLzFFbzBEdHU3?=
 =?utf-8?B?azlqUzFrcDJXQXRybU9NNXpsWmcyT2l0dzc3NWJrWDlNRE1kVGw3dkphMVVS?=
 =?utf-8?Q?FFqKLDM0HBIww/9C6q1B2wI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b389601-a278-41a2-4ee4-08d9f6e071db
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 15:23:29.4659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrlOWoXhezdndNTaHGeER72J+gpMRFKLryqTaLSjPezlXrf7skSDONsZcr9TrFn1FQYB1nSXSxR1fmKUNmBoHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4695
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
Cc: =?UTF-8?Q?Ma=c3=adra_Canal?= <maira.canal@usp.br>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-02-22 21:28, Alex Deucher wrote:
> This reverts commit b1f0ab445ec609f9b58e0969c5d052b52d9a54e7.
> 
> This patch is not valid.  The driver needs to actually read the
> entries in the ring buffer.  Add a comment to make this clear.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1916>> Cc: Maíra Canal <maira.canal@usp.br>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> index d3088836d4e4..cb92ab4c8b98 100644
> --- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> +++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> @@ -2918,8 +2918,15 @@ static inline void dmub_rb_flush_pending(const struct dmub_rb *rb)
>  	while (rptr != wptr) {
>  		uint64_t volatile *data = (uint64_t volatile *)((uint8_t *)(rb->base_address) + rptr);
>  		//uint64_t volatile *p = (uint64_t volatile *)data;
> +		uint64_t temp;
> +		uint8_t i;
>  
> -		*data += DMUB_RB_CMD_SIZE / sizeof(uint64_t);
> +		/* Don't remove this.
> +		 * The contents need to actually be read from the ring buffer
> +		 * for this function to be effective.
> +		 */
> +		for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
> +			temp = *data++;
>  
>  		rptr += DMUB_RB_CMD_SIZE;
>  		if (rptr >= rb->capacity)


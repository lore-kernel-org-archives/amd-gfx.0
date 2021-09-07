Return-Path: <SRS0=wMah=N5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDD5C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 14:21:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDC356103D
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Sep 2021 14:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CDC356103D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 734C589F53;
	Tue,  7 Sep 2021 14:21:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F3E4897F0
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Sep 2021 14:21:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFYhKotKvi05YKDADWfrT8x3jWyy2pW72qFKbqpTBkKR0RwWpNOHyyYWmnemz/gcipFBzjw0AFu7n1rfnj8CVCtat21XcISWMPurXDYrRZ+dki336U9tZfdla11xDnBTwtM/SSd1QguxFCtEIzKf83IRSnD40Mrt8xiMFVwnhXH7mYTopy/imGPRjhDxBa/NyL0xRHCrx7TxxQUKmnUgAMp6er/6F+DjE+qRnKuRJxgA8Ps1Yk2hH11XE4vSUX80kLboGuZVBf6rR3uhvdYi3oMj22ZnL9KnWT0AwOTDBXHCwOPHVVvFuDv7ByEtTFWB/w8+h1k9mO4CxAePMJfm6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=X+HIqcWLV1Hiyf2iPlDvTtS2dC57R5Zx8PPSQKlCWo8=;
 b=TLQPfpK5Zneyx7/GRlSL+FMLhlLl25Yyh81hsqtuVO1RxWM0ChEgGhJj43yY1oKarsf/f4uYUziirqH/xWOtPqUi7hDoU5Etxv/kmTuw4ky6JvFTM0JP7bS6qHOJJAATt7WykLxVaCZMcC+Q1xOP6q5UUxR9ZHIlqXJZ+SMHqdSTneCRKPd5gBgvKg+TGXjw3HlTA4YJNF/2XZkc+0VbcvD2eHJFvJe8UoWjhDPbuvlTxdQQQLIZON0YVczNpF5m23CfySU0X/g6ddp7c+cv99r9ysDOmijQ6HxoYZCPZFhVsOaBXWL1ROOzh9SnqKr17hB0vOewG1jlcTZvzU3caw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+HIqcWLV1Hiyf2iPlDvTtS2dC57R5Zx8PPSQKlCWo8=;
 b=Lb6PZ6arY6yeOxMevCMpG3UC8uExwD3ncmVQskqcRE0SW8Edw9cXN/qxzkYMyCzEONlh1E4k0TAaHlCwhHTSrFPEjSnq2zOkZ595BDON52RgOzg5Yww/3SOOcjzn6LuCo+oAvmnJfxpMVePmPKiFFyvI1VDfyLUer7aBvvAMlTs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM8PR12MB5446.namprd12.prod.outlook.com (2603:10b6:8:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Tue, 7 Sep
 2021 14:21:53 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::55b7:27c8:7147:8222]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::55b7:27c8:7147:8222%3]) with mapi id 15.20.4500.014; Tue, 7 Sep 2021
 14:21:53 +0000
Subject: Re: [PATCH] amd/display: downgrade validation failure log level
To: Simon Ser <contact@emersion.fr>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>
References: <20210907141925.125177-1-contact@emersion.fr>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <bc35bf95-0eb2-a0d5-0f9d-f2ac5c02426c@amd.com>
Date: Tue, 7 Sep 2021 10:21:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210907141925.125177-1-contact@emersion.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::11) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
Received: from [172.31.16.161] (165.204.54.211) by
 YT1PR01CA0072.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.19 via Frontend Transport; Tue, 7 Sep 2021 14:21:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24b337d5-6eed-475d-ae41-08d9720ad6f5
X-MS-TrafficTypeDiagnostic: DM8PR12MB5446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB54468D1A1BEF38A5D36A6499ECD39@DM8PR12MB5446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: je4YoISk09nWEPVsryHVf+J2eRsFGSzYCtJ67tWPfBDyTDeVvdTQY8pELyGqIGUCtek55Gk+PBosZIrep6bUpQEm9Q9ogXj7YnA1juGvxf6IRkGBH+/ZLTZXUia3lYonMeCadmmmJNvrbEiQcRBab4BxhUtAIr3oMYcXP4K9fXqurHjYu/6Omx666dpTKBfJMZzc9ySJr2N5wsHE0hvavCuk5+tgsdBTZyZgp3rDHvK9XpLKI/Yr1IwEI00qI9UUqKChHeg2zHg52y2LIQfxpyApw8VhZZfEh0Y65MNZOhd79g1Y+1MbkUixtI9iAJTLAuZuC/XctRJdSLXhhVRLsYTskM/6V/KrerhQYrAhLjajX2YKYSS3PWW8Xu359oJSELv6O8gcNgGivsV/c21UwmG/3k56rXIDcpGSg2cXYoLfS8SeQM9xkGIjSEgx9J7keHp2LatDfx22uLYpXb2XiqnSblWqFNn9k+KFwxiS9MRFCieNKJIZCNx8OmdPW7/gSKds1J8xoJs4tubW1yi+MzVYHI/cg0BNlaVJZZVAFZCmOwT0DOaE1sQX4E1gjA8CDGH6E3nngd0+QwSCicIs2v+NHOIxRsT++WZviI25guMIsuzqGWozaddGa531I3h81dgfuMyqHtLRRFvcU8B/GTMuZ8E53o0FKvyekqnqoob28FQ6cLafi8HCGI7ADZVGC20MTAhw7+NjHPUX9y52PeM823Y6V6W0jGwHq1iaaJ+SNw1tgyDGntPb8cJ0mnX4g4f+Gxc9euTIh+w5EslPDe8/y+oFD4W0vuZB0DgAzongS0d/mGdqkLrOmW3wVz0SWmMmHpCA/rul2n7AU0MDFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(2906002)(8936002)(478600001)(8676002)(38100700002)(2616005)(31696002)(5660300002)(956004)(4326008)(86362001)(6486002)(31686004)(53546011)(66556008)(66946007)(83380400001)(186003)(66476007)(36756003)(54906003)(26005)(966005)(316002)(16576012)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUtadWhseE8wV05aYWtLOEdqTWNOZTZ1RHkybkpuMmdQMzEyQVBkWSs5ZTV2?=
 =?utf-8?B?Vmk4akVqcjFmdzM4ZzBKdlU3cjF5bzNYTmVCK0ZqUGZoVlI2UWtGQTNQaC9w?=
 =?utf-8?B?QlBwVkJxNE9LMENFWEQ0Rlc3dndwRkJPUVJ3T0VjRGhhK2pHSHlCa0p1SnNz?=
 =?utf-8?B?UTdXNHpDVDdTMVRGU2w4MkNHUThTV01Ucjl2bVVTay9laG1pamJabTNaY0lF?=
 =?utf-8?B?YU43NVQ0cml6NHdWMnVmTjhScWlpUXNaUzgrakNQc3cwZjlzK1JHQWs0S25Y?=
 =?utf-8?B?TmVhRHlucWM3OGFUeWtNZWdTY2FvYUVyVnhEQXoyUVpYN1dMM0xaeU5hd2lL?=
 =?utf-8?B?aW9rbU01TlUzaUV5M3J1djRTN3h3VXNDYU8wOUJoVUNUR2pOMnRWcmsxa1cz?=
 =?utf-8?B?RFJuZWdOLzZqVDlwS0k2TU5UelpnaDFFa2RqdFpFZGlJak5CSFQ0UkVWREdy?=
 =?utf-8?B?ZGZuUmg2enVXYkQwYVZvR20zSlJhWWhndWs1WFY5ZnZ4QWljQVBJS0hOOUlK?=
 =?utf-8?B?SWNnN0dsazEySVpKOXpCbmNzcjZpa2QwNGR0c01hSmp2YlkvZm9GcThENE54?=
 =?utf-8?B?TDNab0NCaElDMnBrSVhQUkUxUXhnbkR2cER1K1FJNUw0bWZYWldJOHFKcC9U?=
 =?utf-8?B?M2tEdXNTL1Y1amlabkZKd3UwbndLSDdySzZlRXJTQnB3ZnNZdzdJc0Q3dHpz?=
 =?utf-8?B?QWw0bGhHTjRFOHRiQ2piMWRWSXBTWmpCTUFuaUNycTVqWEwrNzREbjIxNFdL?=
 =?utf-8?B?L1JObmJDZjBZaHM1NTc2Sm9BZXpPbFVHNzI1bVhnREdweVYwTFpJek1MSjFD?=
 =?utf-8?B?aG9kS1lVTVNhYmprM0NUU1ZlUFpkVDJ1dnBoVEpUZndNa0lTdm1FdGsrd245?=
 =?utf-8?B?cUhmRXVGRk1NSGE5VjQ0QjIyV3lIbVJwNmNiYSttT3htL2pES1NCZWJLZHJR?=
 =?utf-8?B?eHNJSXVrZzN0emJyZUR1VjRZOFBxWTBEWFo2cEx0SWFyUDN3WVZ6RWNpcFBI?=
 =?utf-8?B?ZlhEY3hXclp1bnE4M1R1TnQzeGZid3pkZ0JXOVBRenE4K1VqRlkvTnNpeW1P?=
 =?utf-8?B?akRJU1k4U0xmRmorbHRzUU0rTWwvTjE4ZVdIZmcwcUJBMXQvZld6MXdBR1Jo?=
 =?utf-8?B?QkhEK0pzZmpPUE5lc1V1a0lwQ1lEbzhkSW8xY3lmWTZqRDg1L3BhQWFRUXh4?=
 =?utf-8?B?RkFjaWhEMHJISDdncHc0RzVDdi9hOTZ4WVArWkk0ZDJEQlQ3ZnJCUUtJdVpB?=
 =?utf-8?B?KzVCMXN3UlFJcjhnTWlEWDZ2TWp4LzN1RDh0ZjBUWkFnL0xFbGx6cFBJNm1F?=
 =?utf-8?B?WXNlNTRSbU4ydjhFZnVaMUtsRk80K1EwZnQwWC94dy9KUGlqMVpGVGl4RVFN?=
 =?utf-8?B?WDlzZjIxNlNJOVc5eGszb3MxMWxDSVhPQmdJY3d3RjIxMWFDT3FCdHNOOUFJ?=
 =?utf-8?B?TTl0TEd3VzE0ZjFkdG9INFlMaEZCQ0VOTDJTUmpFMXZtR292NUE3bVhIOWZs?=
 =?utf-8?B?MFJyYWhobWRpSEl6TDBmRkR0TEphd2l4bEZHdG9XbzBlWWtmVVk0UE5OaUpW?=
 =?utf-8?B?akkrUjhwQU1KNWw0MWRmdWViTUthclhZMk5mMC9CL2FCWitwZDJuejRNWmdy?=
 =?utf-8?B?c29qQXpaS0wvWlVueUdJRjg3SVhBekVHeU5EejNqVkNqZ1QzUCt6NUN0YUtu?=
 =?utf-8?B?Rk1xTWdKWjRncnVPWW1IRFN6K002R1p3OGZUMkQ5aG9BanphNkdXYkF4eDNY?=
 =?utf-8?Q?30Ba0aaxMsuqPulgwhLdgzHLhFyyv23ZES1H+i2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b337d5-6eed-475d-ae41-08d9720ad6f5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 14:21:53.2554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtMxgsqQyFzLjY816rNcCV5sqyzm47+SpYSsOnxqKwwPZEtUVribe4M8Cunz//sA2ysmWEVJlFk1z/n9A7ms/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5446
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

On 2021-09-07 10:19 a.m., Simon Ser wrote:
> In amdgpu_dm_atomic_check, dc_validate_global_state is called. On
> failure this logs a warning to the kernel journal. However warnings
> shouldn't be used for atomic test-only commit failures: user-space
> might be perfoming a lot of atomic test-only commits to find the
> best hardware configuration.
> 
> Downgrade the log to a regular DRM atomic message. While at it, use
> the new device-aware logging infrastructure.
> 
> This fixes error messages in the kernel when running gamescope [1].
> 
> [1]: https://github.com/Plagman/gamescope/issues/245
> 
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Makes sense since validation can fail. Thanks for the patch!

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 986c9d29d686..6f3b6f2a952c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10467,7 +10467,8 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   			goto fail;
>   		status = dc_validate_global_state(dc, dm_state->context, false);
>   		if (status != DC_OK) {
> -			DC_LOG_WARNING("DC global validation failure: %s (%d)",
> +			drm_dbg_atomic(dev,
> +				       "DC global validation failure: %s (%d)",
>   				       dc_status_to_str(status), status);
>   			ret = -EINVAL;
>   			goto fail;
> 


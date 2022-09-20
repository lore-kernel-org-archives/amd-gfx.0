Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A98C54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Sep 2022 12:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B84A110E665;
	Tue, 20 Sep 2022 12:41:39 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2051.outbound.protection.outlook.com [40.107.95.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DAEE10E665
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 12:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SULLQfy7wcobrAi+7NNbgfsXgMrjF3e1euKsYEtz32MnelRpW5ExZXAzVPRPXYCcAGqwldpFpOnj3i8EPynfAF7BwwaUM1HrtoRJ4f2tHe/r/zO48qerXLZlXubUfKfJX01NAAh35cqkRfo0ShJlJRfpUvzLDyTwPRAivkBOVY8M6koOLnD7TJT1Gf1DsItiqSqO8PvRsh1XCuOS+j/0sf3W+eSevDbLTt8V2vhl8oqi9P8oDFJhzY6inLkXSE5NdV+g2VRUr03II/mPwCNGgw+/RBp7Z9JKCqtgsrT7p5Nd3hrnwYV1IsAnzp1+/rEGEEsPQaZW/59NIJgdSsco8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtBbrc4wF2o3FTPvioLeoRZIqAACWVUihiibzsixBFQ=;
 b=fcjZHnwK9ZkSUNgnVKHbZGVNmWJ92kGRCLMqjOXXPdA+2f+crNW+p74pJtUzE3Exg/qbearItwRAKCAPzwxA7h1mQkNMq0SC5JuV1QJlYnuqiO7tyDYMLHNUa4FrmdgIsJqPDSePWxMuPSYO2hwW7BEJ3bLJAi1eih+5QcOQrncKLEQfBaeInO89Lmt8kpeBKHxQu85Cqla4D8i4pZIYPc5T3mY8+V+0173Bsj0f4dl+0NDTdFBHCKbgnH5QfhTbfwqtdhE8t2cz7CPUWyyrg3ugp2YEEkoaeudz4wuFGhZeSwtZHpcGu5sBUbpO7yj5eVbpcMn/GpI69yABfIj6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtBbrc4wF2o3FTPvioLeoRZIqAACWVUihiibzsixBFQ=;
 b=VUjB2g32a5S5B2VZKEYyJekpJGDaHYvzP3iYbstp0k+mEcmDvIpF+V7eh9EDZlQ4PB4RbmDdg1Xcv2LDt0Fv2Ka+egBVp4z4X2GP5DHIieumAfTdTxbz0LGSTo5KmmgDTClCXq4G4zPQSE4CkMJHcOgvpz1jvjlGhbS1jTmfkzA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BL0PR12MB4947.namprd12.prod.outlook.com (2603:10b6:208:17d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 12:41:32 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::653f:e59b:3f40:8fed%6]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 12:41:32 +0000
Message-ID: <47d703a5-c097-c0e2-db28-72f792b7173b@amd.com>
Date: Tue, 20 Sep 2022 14:41:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: properly initialize return value during CS
Content-Language: en-US
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220920121559.2815-1-christian.koenig@amd.com>
 <DM5PR12MB2469A6D648FA0CE21B7732E3F14C9@DM5PR12MB2469.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM5PR12MB2469A6D648FA0CE21B7732E3F14C9@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR08CA0013.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::25) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BL0PR12MB4947:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ca9a16-7b88-407c-664b-08da9b057221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FNYrHCoEWcIdbdUMXiqbI/zJvFWRVqz1h+yyDCKNWSCmyUChKdo2Ua7e7ZbuZiyZjLYPPt/oSo9q1dP+5bGJTm5wdYflbGivgYumpxFnZPpjiu7HlU5mQ4g5qCz3MOnajyyPasbGosOk3uQPEJLZGthvjVEaKkEGhiGvOVnPdVuvFwoH21tO9/aqjBIt6UTgg/g1WllSNxfKfC9N7yIJ/1dN/gF0xYRjtlvx+iMhGy4d+msHTTLTbT77xye2ZwLDtVWHzpCmsOtiUQJXwzApMhx849/8skYm45QM4PNK0WqIdRD5+7zW2SC0hDF9EYj8H2YQnKv+s34scxEAus0g7r+OJo1Xnucoo5n4TmPuts7egU64Knnrx9EsOp0O4NlfU7+YlLddvoZREFC16pVFYKgMv4T+lu3GesbldgwqHYr/7CFcOTUbY05K4K+0nBzftHIG/YuBhQwi1rmZxoX9dzovlq7d/0E6+jGnokcBlnikgyW70XGUWt+jY0hYNcV9vYMo9CkithPOdn+QgKPI/IUM5kSuPATOrXcjBlo7aDeewkep4yMlQV+yP+b9GnD6M0JMMHEfT5CHKarnCik8Wfoa6+04JCAVMAt/Vj8pt6x8KT/2P9l8XhRycGvI/yVUOHZXuwSjhFG6yWJ3XqvUwEoimbl6IeluRuMaIaiq7lEQWE5/FZ60HY/Uw06Z/tgPhnHjjPtVXTlaxhXHp1fPDrREVcrwKrZRFUtsOja2V/7QeuJ6aFsKuhLnMrhz/JL/NAhd54ZIyeQRGHrymSiqv+4KXj9HNa/Ak8Iu3KVGwM0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199015)(31686004)(38100700002)(6512007)(26005)(31696002)(6666004)(6506007)(8676002)(2906002)(2616005)(66946007)(53546011)(41300700001)(186003)(5660300002)(36756003)(478600001)(86362001)(8936002)(110136005)(66556008)(66476007)(83380400001)(6486002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG5kRUJJTFlmU295bE1pZW84OFVQbkNCYkwrd01pdnRJY3pySC8wa0hScklK?=
 =?utf-8?B?MTdxYWw3NHhuLzJ1R1BTMTVZL2dCQkFIS1Rpa1ZJV1l6MjNYUjY5a1dMaFNq?=
 =?utf-8?B?bnc2NlNKbXQrRllTNlFjc21pMHMxMWdQVWs0SVVlbjE0RGg0cTM2dzFwQXJP?=
 =?utf-8?B?ZXFEckw3b1lPTmhGNFowanFHYnY2cmY0V2Y1WUEreWs1aFQ1ZlNBSEFGcDBH?=
 =?utf-8?B?dkRYL0MvREFkTXVOckh0R0poMUV6eGg5ZGNiSXNVMFBEMmNISmwyM2o1Wm54?=
 =?utf-8?B?UStMMkVZRFM1QzQ1U2Jtd2ovKzMvaXRBeU5zb1FkUTZYMTdhM0U5T0ZpOE5n?=
 =?utf-8?B?ZllSOHVJYzYrZWw5TGpLTFFzbHdLRjhYQ0MzYzFMckJNMG5PeUhqWlZoaVVv?=
 =?utf-8?B?Z1Q4cmtGSEpJRGNwRnRyNTVjN1R6YlZxT2M2V0NsczF3bGFDSUFyeHNUbWUy?=
 =?utf-8?B?L2VoYlJ5UldzbkpGQVNtOUpUTnVkbFphQmU5N2E5Y3VXc0lhajNoTjNSQVRY?=
 =?utf-8?B?d3Zid1hSSFNIVUp2OW1QOHNsQmk1UCtoSFZxUVVpWHZ0RENzL2VpTXJWUFR3?=
 =?utf-8?B?eTR5bklTODB4VGRyR1RsS2diMjdoRUlwYWdtV1pwKy8zbmVpbUxkTnZ5M3lm?=
 =?utf-8?B?Nk9rb2p1SlN4aGhvNEV1WUZTbEFlVDZrVVNhYThoZzA4eGRJNGNHWDE3d3FE?=
 =?utf-8?B?REpaQzQ5ajRhVnhEV1NXVExVVEpOTG4yTmFZK1M1cE5xOGk4aWZac3N4VUIx?=
 =?utf-8?B?QlRjS21CS21BN3NoWmFubHBsZjhGTkFmbXZZeDF6c2NiNFBSeWg3ckFUZ0tK?=
 =?utf-8?B?Wk02ZDVsUit3RjRUb1E4TVBjWkc1MmROejE1OExCQjhOcVFhdUEvNWRkZFQ2?=
 =?utf-8?B?RlpDZXlGNmkyaXlrQzJ4ZlhqMDZoWVJGTldUVzJZbFlCS0RKdVpWMlgyRXh5?=
 =?utf-8?B?NUs5U3ZCanFKWGhpdENJd1V6YVNMU1d2QXFmQ2srWi9rREpGck5UN0FaYU56?=
 =?utf-8?B?TnFmSTl6Y3MvOWNzUGtUV3R5c3JYU1gvZEFRM3l5MHU2aEVDbHlld0tyRUlr?=
 =?utf-8?B?U2NGYkhDMzV3WjhCV2ZsZm0zOHdaa1htWExkNmMzejBSOTRhR05NcVVQZVRV?=
 =?utf-8?B?aTloTC9VTFhzbVVLTVgzNWNVZHFDaUpHbnRncEJVQTFzdkVaR3Z3dUhlT3l1?=
 =?utf-8?B?ZWU0L3VMTnNBcjQ0N1VNUytSWHhtTm9MVWRxK2lMU0pyQkJZSWJuMEdFeHZX?=
 =?utf-8?B?T2lPSkFlQjFGRHBDSFhHYXM1TGNFYWxpMy9mMm0xSU1JNS9vNHJXbjREa0xX?=
 =?utf-8?B?bEVCcCsremlPS2V0cjlEUi8rTWlyakhPVERQbWpFd0dYbmVNZUNWRE9tWDd4?=
 =?utf-8?B?eVZpRElFalRVQzBXdEJ5ekNLS3VtSHkyeXg3Ri9rRXBjSnU2MTloVjIwei9P?=
 =?utf-8?B?SG1zdTVsTUJXUHo3Ly9aVjBKaWJ4c1NZV0RBWTl5eVVWQVc4Z29KMG4ydEJQ?=
 =?utf-8?B?aUJMc21tc0JKWjlDVnJkNUxOT1diTnpoazJGQ21NQzhBK2QwL09ndEU2cGNE?=
 =?utf-8?B?MHFrN1NEY3FiV2FvWVgwUkV4M0U0U0l4S2E1bXdHbGZUQ0thLzAxWndlcm96?=
 =?utf-8?B?USs0K09takpoelpCVTZOdG96aHJudndjb2pqVmVBd2Q2ZDY5RzJrQnQ2cGpI?=
 =?utf-8?B?bU1qSFRkeGJ3TnpIQys2cFE0U1ZkV2dJeU1SQ1VYUkVWL2VyQ09jWU1ZR1Fp?=
 =?utf-8?B?aUhqd3UzY3NJRjdEQ1MxSXZDUlFxY1hnam9FVklwVFM0RGErYVdqRzZMYWRy?=
 =?utf-8?B?STk0bmdYL1JkYVZRdzNtMzlNS1Rsc2dKNlBjSmdkU0lqcko0Z0grak1IcC9P?=
 =?utf-8?B?bldhV1ZHODBjRmFHbzhnajNjanRWdGJ5NE9xV0x4ZG82TmlDU1ZyYWVFYWRz?=
 =?utf-8?B?Y2RaaFZlazNzdTNaTHdSU3R3VWJiYUVicVo5TXUxZWQ2K1RrQlV3ajhhTXJM?=
 =?utf-8?B?eUtPaTQ0ZW1BLzNZSlVuT29BYy9BaXBvZDNYcE92cmJ5VzY4RnFvNENrZE1C?=
 =?utf-8?B?SFZCWUlmN3pUZjhIQk95SUh6Y1ZkZU1SV1E0dXVYb1lDTWt5OEZmdTRNSitX?=
 =?utf-8?Q?8RPI3MfVUFoNBD8FzQgcagFwq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ca9a16-7b88-407c-664b-08da9b057221
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 12:41:32.0623 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OeAt8t2hNkZl+TP1EDadJ9FYWGAYac/DrZ4AEno6Znd9gpsz9eJuHgtsZA4bFjEP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4947
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

Am 20.09.22 um 14:38 schrieb Chen, Guchun:
> Looks using 'int r = 0;' is better?

No, local initialization is usually preferred in the kernel over 
initializing on declaration.

>   Anyway, this patch is: Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Thanks,
Christian.

>
> Regards,
> Guchun
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Christian König
> Sent: Tuesday, September 20, 2022 8:16 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>
> Subject: [PATCH] drm/amdgpu: properly initialize return value during CS
>
> The return value is no longer initialized before the loop because of moving code around.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Fixes: 1ce5d2d0c831 ("drm/amdgpu: move entity selection and job init earlier during CS")
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 58088c663125..e452350f462a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1184,6 +1184,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   	/* If userptr are invalidated after amdgpu_cs_parser_bos(), return
>   	 * -EAGAIN, drmIoctl in libdrm will restart the amdgpu_cs_ioctl.
>   	 */
> +	r = 0;
>   	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
>   		struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
>   
> --
> 2.25.1
>


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11886C77B7C
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Apr 2023 15:42:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD1BC10E41C;
	Mon, 17 Apr 2023 15:42:07 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFD5810E413
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Apr 2023 15:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7/adxyL6NnjkHGEB19la4Ot4MRpjTbhPal4vKTA5+GtVdyF3Z4uYbUL9lwHDDdmScGzatzZCexQbsXCCibr/UeGtMxP/iRBDqXkR54nf1RtwUi8jxNJlXe/2JNRY3d6n39VuUU+RuoLclbFX2FbOpNWpGzS+U3dxyfLwN7BawW2kBB9sQlr9E5XrjnrmpplnRX6ZDR1hTjqj7e5hRyD1BQJlWiq+TR24OKzgAnzmOnPUoUuqsrxWEdu1RizkBFUcb4sS1+bBPl+3v+NjO1W8Bd4CmjxrlZAZ8/BSBYjNIggtdjYBS+zC/Bm33M1cZol+SaCCs53WtrjBhXC/mASAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/8Q7YZpdwPl6KQVmvblLMZW4qeIeCzUhRMRX1A7XEQQ=;
 b=dJtr4ur8gMcIuoi8jcZoGjTOmFI10AD4HpY8gBX7Yq4pa89iBSC73Uv0k1mTNcOnZAn/DFRyMroQpyvmNjvWzzufG4nhYBLJEXLZflO7u/N/B8BeVW1dO/pw4b/Evp4TzH2ISFHinBG9vFYtIDEi250Xo/lBxBRmK3eWXPU9H0o5lbQkPEg+C9pUC64LpUmmFKluiLawL+9UAsFahts6Wc70s27eQ2+mndZvAoJwKNMhcXLEuWK64v2ugKNTN25LW8d+wxsdy8UfjL3zIqXrhnfxdDoF757M4sm7PwvzX77vKAoMi1BfzSQoot/EVAcj2L8iIUVDfabf8HabvRy4eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8Q7YZpdwPl6KQVmvblLMZW4qeIeCzUhRMRX1A7XEQQ=;
 b=M9+HooIr92pige4L0oHplxg5v1D7F4tk9gq2UDo+3XViF6vK+5M6RXe7QV9OPAvrVNf4iijaPIMYuWNG+SIMt3GOqxgg0rq2JA4yRz4V9R5sHvkn0jBK2romcQS8dRdykX2FoSWfqaXZZ8+DvG+xbjxhQUjLOgeFODOtrEphj70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by BL1PR12MB5875.namprd12.prod.outlook.com (2603:10b6:208:397::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 15:42:00 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::3e54:627b:ceee:ed2b]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::3e54:627b:ceee:ed2b%4]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 15:42:00 +0000
Message-ID: <f0153b72-92fa-abb1-c2af-f3802dd8c5e2@amd.com>
Date: Mon, 17 Apr 2023 11:41:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 62/66] drm/amd/display: Explicitly specify update type per
 plane info change
Content-Language: en-US
To: Qingqing Zhuo <Qingqing.Zhuo@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
 <20230414155330.5215-63-Qingqing.Zhuo@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20230414155330.5215-63-Qingqing.Zhuo@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YTBP288CA0034.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::47) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|BL1PR12MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: 32fcacc2-0437-4611-9489-08db3f5a48c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vr3viU5/d0mkWUTDxgArrTB1QOlcUyGKNsYw/pGoQFqgNhjQMR0lp+mmo6ZfE4AKu+Shza3lIUp3bSo9dmO/EcYYHMX3HD2zhsQhLc36Qp27Nsv1IxtU7Skn4fAvrqtrJaF1Xz2wB7Xm7aNuuGxvl8PedCCAJkLVEmsOQJUfd9Bk1JEXOJjppCUGFV6cBo6+RDNFX7eXkFJkv4xpo2npNAFzFKP3Dsw+FnAQMTcRertaCH/vRRyS7a21BTe1g8lEmtTse+wNHhW1TiIgV5nqGGi/yANb4TsPKD88qRymRfQxlTbD+3NjRceeZ/11xAauD8HCjh1XVrtvAqwY7+iFuoNtUE1i4VL9WtgmsW6+OZc8x7TamGWs1qMrE8GqE2PQr6P39rrq7/jVHQhrFo7WHzvi4L9S6Wzzz2KzQQmdYx24rRJsNRcXa2MpLhTmhCvY/5L4PSME+j4DPNJTojKzx/ZCY4OJadYqAPznjtwW6U/XjBhBPdYS//bLczmhdTwMJ39O/XrzCWTEQKKD+lr/xfnWc+7mfJTm7zwJzxLScAMTkaQP8XyPlPRrCll9SqHj1/OgYCau1Bf/jrGZjoWWp1EJVYrtkN7sVyrtBuxWo0GrRbzr2kuFMDbaUSkgadS9hLp+37auS5Yk3WEi7QvCDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199021)(66476007)(66556008)(4326008)(66946007)(2906002)(15650500001)(31686004)(2616005)(5660300002)(44832011)(86362001)(8936002)(41300700001)(36756003)(478600001)(316002)(6486002)(186003)(53546011)(26005)(6506007)(6512007)(31696002)(83380400001)(8676002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU1ITlFQQ0dIOWExU29SNjRkWUtPaGNWR0Z1My95MFFrNk80UnhjSG53M3dz?=
 =?utf-8?B?WTNvckg4cmZBaTJoVVJpV0NMOUpaZUYwYWR3Sjc2YjdnOWdWN2ZuUzhBcGpx?=
 =?utf-8?B?WXpTRm9KaEZDYUowYWpTQzVZOUd5eDlXV0VEUGdCVVBKZ05YbWZ4M1V6N1Zt?=
 =?utf-8?B?RU53UmZwZEo0ajhhcmJzWG5tOHJFSUxWTUQ5V1k2WGFvN2gxdi9tcGNuemxQ?=
 =?utf-8?B?T1RRWnNNbk5RcHJTb1VHV1FROWpneEo4SXlBMmFZUDR2NFQzU3IrLzVBVURU?=
 =?utf-8?B?MG1CRTA0NWhwUkh5Vy9PdjVjQnZTNVZFTld6YzYzNG90ZDQxck1yVHV4TUdS?=
 =?utf-8?B?ZHVHc0c2MXhJcFpUZnRJT2l0c2psUE1HLzIwM0JqNldMVG5FR3hMVkpNUW5V?=
 =?utf-8?B?M1RxRmpob0lVeXJSVGgycURhYTJiSEdReXFXNzdQcWZ3NjJTWStoNjh5akpw?=
 =?utf-8?B?dUN3bDVkbHBWTEkwMTZiVE4xbGdkcE9abHI1NWdrR1F6Q29BdldaaXNYNzgy?=
 =?utf-8?B?T3BYZDRvK0MrbjNkd2tyUUdiNXlQb0JrRDA1SWtOd0RxeGdna2xsUXJ5aWM2?=
 =?utf-8?B?WW5meFpYNUU4ZGxUb0Z2UTNSZjNCMHZRSnZRZHhNR0hPTXVjZ1ZFRVJSK1lt?=
 =?utf-8?B?OUxRcDMrd2NkWlN2dTRhRVRMcVlXQ0g5ZWlNall1c1FxMHRnbmd2SGR5QVlD?=
 =?utf-8?B?a3lYYU1QU1c1ODBLVHJQZytxYlNScC9FQnExZlc0SmxQdDFGRlp5MzU0NmlO?=
 =?utf-8?B?eW9LMDJrdGIybm9vTGZQQXhwSEhVNVMvcGIzYWJBdXNvMnlQVjV6bEJvNWM5?=
 =?utf-8?B?VXl5QXNZQWhHZXNNZFlua0NuaGc0cllZOWsyNHFxMDlzWFNDZnBDckMyL2dT?=
 =?utf-8?B?VGhHM2U5emg4NGF2dnAvQlk1MkFicWxObWRsa3BtWk1JRlpFZVNEeDlwWlY5?=
 =?utf-8?B?K1ZSTUJsaFpjSElmVFJhS2p6VzArWlFnOE02QTc2K2hCMUhsUzYvdUQxN0Ix?=
 =?utf-8?B?cVp6TUM3RXhYRlhpcUJzV3FtZ082TXVWaGJYMDlObGI5UmZMRDQra1R1UXNa?=
 =?utf-8?B?ZW5qYVBhaERXM002RlpYUWMreUs1eTVJbzNCTjhYUVpKM3lrY1hxNHc2YlR0?=
 =?utf-8?B?UzNEZWF5dHB3amRwb2s3NUovY2RWZ2dSQ25EbFVkaGtJTWl3d3NVM3Bad21M?=
 =?utf-8?B?YkZsM08vT3RMaEdWY2FiWHROeFNmdGJ4cWZuREcyZHNQVjhrS0QvQU5JWnc4?=
 =?utf-8?B?MTJ1a21zQzlxOHgramt0d3dSVXgxMGt5MnI1bjRhTDNoWUNWRjRQcEMxUUZN?=
 =?utf-8?B?TmRka0RBVTl4RFFuWEVYL0ZKdGh0aFBMOFZ2bklXMFBVNTRZS0xoT1NSK0xl?=
 =?utf-8?B?dGFHVHpKcWJDaDZsd1oycTZUajQvMjY4ZTdrUU9DUmVveUFwWjdxQ2dnNCtG?=
 =?utf-8?B?MHRPdStVTmVtQ2xMenlxYW02bWFtYmRnR1h4dk5DYU5yTzNrRmo0Y0tQVWQv?=
 =?utf-8?B?NTRlaGtpbzZJU1B1cmpKSkZ0bXIxMzc0Wlp6M1BidmJZdmYzOEF2SWtHVjVu?=
 =?utf-8?B?ZzJkN1VHOVVkL3g1WjFvL2pOaUNPQzJmMUdYSW5pSml1Mk9DM3Q2RDZWN0cy?=
 =?utf-8?B?cHZiWTNXb0lkbmhBRHg2NnpFK3d0VzVaNkEvdEs3UXp3eVJLYkxhUDByWFMy?=
 =?utf-8?B?dEtIM0dCQ3Q5ZHlLR0xtT1pRbzYxN1NGTkVRd0FHYW41b0hnUUdqSWhCZUNI?=
 =?utf-8?B?TzUwMnRIZUFiTk9obUNNQ0RDSHZ6U3hRQWRqRWp6U20yMGtsSHB0NXZJZnU2?=
 =?utf-8?B?dFBGL1liTXVua3Z5RjdoUkNLTXlQSGlsNXVNaE5wR1VmQW9kUytHSmp3QmZn?=
 =?utf-8?B?d2xvMVZiTkJ0STFKREZtQVV6S3NWVllJN3EwRitkRk9vQnA5RnlzbTVCanc4?=
 =?utf-8?B?L0pUVjRWRVIwZzRuaTZ1MlFxcENzNUYvcWg3N3U4QzRoN0hkeWNNdWVHd2kv?=
 =?utf-8?B?YnVmWWZ0cGx4eWRuNmhwV0x1T2Z5ZVB5ck04RW0ySDFBeENaNHN3T01VTGFh?=
 =?utf-8?B?OHpFNUtjOE5wZTBETXcxbmlqT21PWHgweTF3SU5ndjFOVVRkdE5EMnNueUcy?=
 =?utf-8?Q?wIXTa5TEdBbExWlnvZWBoghLo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fcacc2-0437-4611-9489-08db3f5a48c5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 15:42:00.5900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPnAmBKgau1hdz7JpURXq1AHVc1Fk+Lrg5kwaDmkGvUDRS5i+Z0saXhrfQnTJuJ41AV5XUxRzeo1PkDcYgl+yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5875
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

Please add:

Fixes: aa5fdb1ab5b6 ("drm/amd/display: Explicitly specify update type 
per plane info change")

On 4/14/23 11:53, Qingqing Zhuo wrote:
> From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> 
> [Why]
> The bit for flip addr is being set causing the determination for
> FAST vs MEDIUM to always return MEDIUM when plane info is provided
> as a surface update. This causes extreme stuttering for the typical
> atomic update path on Linux.
> 
> [How]
> Don't use update_flags->raw for determining FAST vs MEDIUM. It's too
> fragile to changes like this.
> 
> Explicitly specify the update type per update flag instead. It's not
> as clever as checking the bits itself but at least it's correct.
> 
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 238a13266ad8..e65ba87ee2c5 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -2482,9 +2482,6 @@ static enum surface_update_type det_surface_update(const struct dc *dc,
>   	enum surface_update_type overall_type = UPDATE_TYPE_FAST;
>   	union surface_update_flags *update_flags = &u->surface->update_flags;
>   
> -	if (u->flip_addr)
> -		update_flags->bits.addr_update = 1;
> -
>   	if (!is_surface_in_context(context, u->surface) || u->surface->force_full_update) {
>   		update_flags->raw = 0xFFFFFFFF;
>   		return UPDATE_TYPE_FULL;

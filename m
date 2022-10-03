Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C62C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Oct 2022 18:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C121810E456;
	Mon,  3 Oct 2022 18:03:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2EC810E47A
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Oct 2022 18:03:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkDasQLGeWS+BOoNnGcttfKY+aDm3UB0cG1Phr2zZwCvy4N8xjZsw5PYvGtmo307vRvJgxfFJov7pScrfXrJecshe/qf0KktbylRvG5sXYyMQw6qUFor9DGGsYI8/bbCVpZA5bTz88T6uNSC6pBn75wA4GffxO1M1Oa4BHVUGywCvrvRtSLqmpwC9tzWdM7U47pv5i35JBM/nl4rZ7+hnpLVtTUf9QzdcwoxZduqAixzPy4bd8WHByS8htCZiwc/jt7NqlGZsOZLC+e6zHt9IOfzbTfg3+9cjgEvXSAY4KvNBO/TlrMzspjzJbKCc7TqUmiT5bNNEFEFmjbSEiDTfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9P9SLxsBhmC6nkUUTVKGQcupKqu1jwFsN5oWonT5Wkc=;
 b=iGZ+28g7NEUca+t1NRtSVUbdZ0+WX9ZntkrvVUmRt9KKc9w5klwb+mcoOgz7ChiwH935H8AGxaZPlbPesVLWCQi9+kedTHCyaG0CenvT8FQcT7h0zNhPSrcfwz5wNCyGj6YjrU2LvHh8bowR8ZyAKp67Q+Umuhrqn9TcdIuBGVyI9ZXMM9Ss9cYsMgFNyeESY6Dv5IupBxNyKHV99JbVBSAXjzsd3ntbj8xIfKsq65iNr0/mRXjTOTG7i3mc2P0prZKTXrZMqbxVhSspvwOwuo8GkklxS8Nl5ASmOfYfdkkvuCwAOdDHcS3ze865Nno80Vv+qJJbYWG+VMM6gnYRSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P9SLxsBhmC6nkUUTVKGQcupKqu1jwFsN5oWonT5Wkc=;
 b=2/pJBgZMpsdYstnyPh4IF+igOh2Y1Hq9UJcbJ6cCA86vaSa98TypKwDOfgTdykAqjiRahgLxqTX9Dr48hhNCJ8AyADMq7TVkWTzfm5fDQTIaKgc8TPChOanOKg24PWt3Jpd5e1yuPVnClrPfnS/nEMkOzIHdAVRuLHKf4aKovpU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB6691.namprd12.prod.outlook.com (2603:10b6:806:271::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Mon, 3 Oct
 2022 18:03:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::76ec:6acf:dd4d:76a3%9]) with mapi id 15.20.5676.030; Mon, 3 Oct 2022
 18:03:49 +0000
Message-ID: <c0e34f75-2113-d4bf-e2f2-4c5c0d4a20ca@amd.com>
Date: Mon, 3 Oct 2022 13:03:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amd/display: Enable dpia support for dcn314
Content-Language: en-US
To: Roman.Li@amd.com, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, harry.wentland@amd.com
References: <20221003180048.26686-1-Roman.Li@amd.com>
From: "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <20221003180048.26686-1-Roman.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:610:38::40) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ffcea2a-58ee-45f7-f99b-08daa5699f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0ma7S1GTMVYv+oVfJKMNyCJu5En5q2EwTTap/cN0JN+YBR8kw4SdfNkwahip3F3HD6zumbzrzaV1gCrhEuBcpciGzq0c8B9bJDxOQk63d3WOqLiwXGD6VYiWS73cyXngYyROiKeuOG4PWxKbUUAx/G3H3DpPqClapBZUNJocipbDLB9FV3+zjZ/aN96x0ImvoAYH6C2imWr2ORLw6/wu9Vb27bZMnFXZ9WghvG0nGzvyEvZTYBjYK8z20hWt8Cls3Xp7CL19xRABT9iF+K+S+73gcUid3DLlBIKb6qlXRl+iMbHG0kJHR3QZruF6tE3I5kEMex0WkQLvSzNqasRI0roUCJhN00gcNqVVvv1WIXP8pmtHf3iIsJ9jQNTmJQSchx8CkEWkG1IE6e4Q2u8x8NBV/Vsl3hZGJKKvc2R6iUn9WK0AnUSZlqFFtJ8MviTcba4gBUFtO/NEHk03+trj4nOBMJ4OYzZNYg1mmnFTNSChcHhubncbdFcQ5Fq1iQw5Eae1KLmBaaq2foTFeyJVNqS7yewktvyJ5XC6+3+GiG37WwF1hWr2AIUEF+k88x+oBfS3YOfYw3ISHuLuZ0ct9SglLavTih0RUl0lOplmltisYfhny5KlICbl4pwRF5ji77q4dCJCVY0HNqBMxpUjqpn1fj9XJEnfBLVdDUiZdfEMbaz+Y9fhpp30WuyQc7YJEE5I7otUcCZ9vJ3OnySyOTKt1UdpuOFDSwG3WdlV9B8CetEQJnikDT/GuIyzjlg5TDYt0Mtwpdx8Clar/OOGo2PBG2lv8z3REe+d5HXE3g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199015)(31686004)(316002)(6636002)(5660300002)(26005)(53546011)(6506007)(31696002)(38100700002)(36756003)(66556008)(8676002)(66476007)(186003)(66946007)(478600001)(2906002)(2616005)(6486002)(6512007)(86362001)(41300700001)(8936002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODhEQkU3ZmdJOW9vaFVxOTV4bERXV1NTZ3VXd2gyMmhxcnI3K29KL3gwMVpl?=
 =?utf-8?B?a0JWaHdLREllNUxwWDRrSFRDU0FSN3VpeHRlVmdrV3JQQ1cyL3o5YXVxdGdD?=
 =?utf-8?B?R3FwaUhsQmtDNUU5a0M0bFB2QXQwZWNNZHNLNmt0QUtpdzBjZDNLYWVBTUNY?=
 =?utf-8?B?OHd2SDFNS3FNLzNIdGtwWTZyQnN6TVVkSDdpRkMwbTBhWFdjRUVjN1QxVThh?=
 =?utf-8?B?RHhhUXRXblZJZkxVR2pGRlV1ODRFY3hrUXgzelBFaFNwdXhBQWVRK3F5OUZi?=
 =?utf-8?B?R2ZXTlc3VEl4WWZjUFJOL25jWVg0UUxld1JsVWc1K2dLUG1URFkzK20xRUhJ?=
 =?utf-8?B?SW45TXFETllWYTk1SnJWalY3R3o5WmlYMXcvRjJiUDNrTHBQUmZheWpzWnVM?=
 =?utf-8?B?MzEzalQwWFNQd3dzUkp3QXRrNmhTajZEdkQ4N3hRN3U0Zkk0Wk84MWg1dzIv?=
 =?utf-8?B?SXdnc1hnSHhDcjUxWU13WWE2RzFIZkt0cDVuQi9LNldleHlNV3EvVzhoMDkx?=
 =?utf-8?B?bGNXQ3g0Z05qTnd6b05sZC9GYnY3YnUyQ0diaUVLc1M0TFVZRWdQb3B3SGdE?=
 =?utf-8?B?QmlyaEVyd2J0dTF2MzBkaklCSlYwRWorT25SWUFxYzN0OUxUQklhcjdHb1lm?=
 =?utf-8?B?SGhpK3Z0RWJUMk9odWxtS08xZlJneFRPUkJmanZGV2FmNDBBYjlCaUk3YUV4?=
 =?utf-8?B?ZTljL0s2RkFJV0ZiUjhYZU44UFdzbFlqUGN1UzBtWE8vZGJqWk9UOVd3TDlQ?=
 =?utf-8?B?SkJNVFZHYUs4WlZVZU1PYlVsY0twYVRrQ2IvWkE1bkxPOGNFeGVHNHVaZndV?=
 =?utf-8?B?aklmT2VUcG5kOVZJazFWSmc2VTJrOXFYV0swcHhLb0RyV3FFSXJFWHBmWWJH?=
 =?utf-8?B?OVBMbm5JSHh2bjFWSzRNNVljd2Zab3FsYlJCWXUwZTdRN2loc0NkdVE2Rksx?=
 =?utf-8?B?d01xK3Q4Q0pBRThva0xPcWJld1FBWVJCdnVCdW5SZVFuUjZlMDZ3bWhQYUVt?=
 =?utf-8?B?VURCeXh3N0crdW5jc2NHWnduYWxkRkJGNTZUVW9IZnI1UlZXWmZJOHhudFNt?=
 =?utf-8?B?SXl2RnpJYldyY1BWNjRuVWQyYkpRN0JvZmRtZmlmZnFGSFFtVWR2NzNVSUt3?=
 =?utf-8?B?QnYrYmZ3eU5IVzFaaVV6akNCRkQrZDRlVEJNbzRWL0J3NlFnL3IwUG54eVNj?=
 =?utf-8?B?cTkvR04yWE1qYm1hZ0lVYzA3bUZlODVsZ1hRQlVMblNRSEdFS25CZFZUcCtW?=
 =?utf-8?B?NkNyTmJvN1J3cVhJcDYzeDQ0RjVhS2FiK0NyQXNFOGFDL0pHL3R2T1dnZ1NS?=
 =?utf-8?B?SG1ra0dKVG1iR1RONFNMSHk5VUNoQ2NPYkRVM1orcS82TXM0bHgwRjhFVHB6?=
 =?utf-8?B?czlTZWNQSEY2ME54SnRwMXd5dDBVNWNsMlVXbEhxNVZ0RFZKTjdqN2p3dWRJ?=
 =?utf-8?B?Z3dReDVTY3FzNjMwZzlLTUV4bEFwY3Rxa0NQSU9wQTRmd1VPMVNGTmFPaTNC?=
 =?utf-8?B?SjkwV2ZRZDlhTVNqZldGYmM2UW9vOTJRSmV0Vy9CYks5MGYrdDhGVEN6TUpj?=
 =?utf-8?B?U0NnZFVSVzQyaUF1ajhCR1lGSDhKNnFaUWxrMW40VHhNYVJXU0NCYzdPR1pO?=
 =?utf-8?B?VFRaNG1QRlhwR0U0WHZtVVZPZHdGaTVIRzllby9lUGxsQnhZSjNoTU9IMWkr?=
 =?utf-8?B?ZmI5cUJlR0haOXhZUWlCV2RremxtZTc4TENMZGd2RmFmTjIrRFI4QUFsWndI?=
 =?utf-8?B?NkowRDF6K3Ewd1ZUSEpKeHhWRnI0enJQNHFTejNUYlh2SUhBT2hYRWRoK2kx?=
 =?utf-8?B?aENMSU9MalpBMWd4SHQ3eHVZU2I1Ny9DNEMvUzFYL2llMmd1OFdER3lBVVlU?=
 =?utf-8?B?N1A2cXJjQjhodzlkdVlneDZ0ajZVVlk1d0xLUTZmbGZtRjhYMjlZN2F1UndK?=
 =?utf-8?B?Q2tYZUQ3blhPTzU1QkptYUtpYjlGRHNJREUvZ3k0Y2pTVExaaUNIVjB2SWJk?=
 =?utf-8?B?dTB5TTlPTnRtNTlVdzVNWUVNUTFjbDN6U0oxWndVMHZHTDFicElhbGdaK2tI?=
 =?utf-8?B?dndGdUhoaDhZOGkybEd2WUtuSWFDOFZwVGhOTzJGZmIvQ2k5dGx1RVZIZW1Y?=
 =?utf-8?Q?RFTG/Tf93Q5tuEqCWg5X/EGdn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffcea2a-58ee-45f7-f99b-08daa5699f81
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2022 18:03:49.3840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwjI61nq4neifgmXiztB/7KiDLugRXeVgzckw1SbcH7VaU9T0kKctH5xvaQZ+aDxgTjbvli672TLqvBDu/J0Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6691
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

On 10/3/2022 13:00, Roman.Li@amd.com wrote:
> From: Roman Li <roman.li@amd.com>
> 
> [Why]
> DCN 3.1.4 supports DPIA.
> 
> [How]
>   - Set dpia_supported flag for dcn314 in dmub_hw_init()
>   - Remove comment that becomes irrelevant after this change.
> 
> Signed-off-by: Roman Li <roman.li@amd.com>
> Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>

FYI As this is just adding the ID, I think this is a good stable candidate.

Cc: stable@vger.kernel.org # 6.0
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index ece2003a74cc..8471c21496c9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1105,7 +1105,8 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
>   		hw_params.fb[i] = &fb_info->fb[i];
>   
>   	switch (adev->ip_versions[DCE_HWIP][0]) {
> -	case IP_VERSION(3, 1, 3): /* Only for this asic hw internal rev B0 */
> +	case IP_VERSION(3, 1, 3):
> +	case IP_VERSION(3, 1, 4):
>   		hw_params.dpia_supported = true;
>   		hw_params.disable_dpia = adev->dm.dc->debug.dpia_debug.bits.disable_dpia;
>   		break;


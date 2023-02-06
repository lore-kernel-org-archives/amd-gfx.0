Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE59C636D3
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 17:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13FCD10E425;
	Mon,  6 Feb 2023 17:20:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2C8910E425
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 17:20:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZYSo5uVlt6zaDVl0VjqTGXFEemLeXx8aulUoNkc7l6KXkAWURXQgtEQbMF/LJfV1TOsLQ3kmS50D30NyjTJyDxa/C5TLS4ZoTzlYQT2i7zrO5rE0bE29LU9GtFDh5srM4kOUdnEOwIjTbR18AMHF+8uVSna8+MIDy93clrwbnVdtnJg6OX5DzGWUO3MgkS4pXxesCOMykoltFOqZv1tCIvSaTdn8CsmZdLIFEGWWeBjfVkSf9KQPoMk4UnuPzJ/ejUpX5osAlVsGSJ/4OcEeCNA6aMN1c7D4kz64owh8PI2IvxeIABacerz59J4JjvNAGZ6WuhSbY9kwK8Y/mMk+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7tKpUvF6TY+P5cMOMKMKYQTKv7suPwT3h4n1L7Kujo=;
 b=VAmsGyBqtHBktVVR5evPGAHDcJsH2DWFlfuiebrNMrpyfBH8BLA0WrskAZmgNNzMNYzssn+pGyKiOK7eA1aNdVfolJ/zleRGhDUJLQNNt4zdBHxziIxWiKvn5CszeKdoJeFKbHGwLRweku/GykY4SoEOXrkcn8qcwLEu4VmtRMTMqWpQzpJcbEe5EdzzjXHcMjYWfZzCdKi1X6TQM0DZormkNdqEcBox89QuEBPSNM9EFxTJLDB820erzzNvl0ZFSdCfuz+jrRJK+PV5lU0me44wRj3jGgfs//lD14Pljr9LCXe5miUN7R/Psm7ZZfVaSX7wblhIhKRIDOAzFOgS8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7tKpUvF6TY+P5cMOMKMKYQTKv7suPwT3h4n1L7Kujo=;
 b=iRVJhHjxxL0gW6eaxWgDRuwRrd9jvGX76yg+J3AKZbP9m8xkPDr8t1NbN+Lgkxv6jaEfFOEjKFaguUKAMe4hN+a2e9JWRVwEfR7jZBgdXO5598xAGMJqpS09orbHdqXcvZt0Mzvtzk/3Mdnu7cSWhKKhJcl+LWufyKUMd7eDszI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 17:20:09 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aa28:9378:593:868a]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::aa28:9378:593:868a%9]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 17:20:09 +0000
Message-ID: <78f680dd-ec9e-4708-0bed-8dc0ef905324@amd.com>
Date: Mon, 6 Feb 2023 12:20:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amd/display: fix cursor offset on rotation 180
Content-Language: en-US
To: Melissa Wen <mwen@igalia.com>, sunpeng.li@amd.com,
 Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com
References: <20230131160546.150611-1-mwen@igalia.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20230131160546.150611-1-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::20) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|MN2PR12MB4471:EE_
X-MS-Office365-Filtering-Correlation-Id: 0153bef4-9e0a-4235-512c-08db0866657c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RhIJ8MJ85aFwMYbp0Uw4Zq9RMoM0lpil6gzftaiv9vsOyeDE21hE40v0ouoQlJzbkSUbpKCQZ7dTIeQB8btXCrqVFS9RFFOoYdvoJ3uTp51Niyu/pYKYI1R4MkvAgBgbF/hlu5MZPel5Xnft1uCCSNprZI1m/NCESN17UWBv1AmuYhhaZAVqUtCrjFhhYUnbUmpZxserxhtIN1+jJeRVh+yNpXypEH832ddPrH67npLi8LD7jiQ1+FVG85ywW8S6e1qJZYA1RSUFZXSHSsnmmT25WkV2mhLtPYHnvmtMAjtmETOTY3IpAXZl4mPU/U87kgGFWpPQzoZQo6XO+GRebBYY8n7QADZCS/fRtfmKT4KMqYxOLDLS/11ckqziMJgKwT+SZaMIO1fdJhbmPp8nLJRqznoMqRRoj4u0NVcMCYnkScEYi9t/g3MEbGBJw8nhT1eZqcChh6oIiFfOLUi0SSC5ed31sxfrCSTLPP0YgZLpRkLfaxaKLKlWtwfacZRC2b+7Nm6VLSzHIKsja07Nh9IMVBCRkPeHIssBrrktHr+OK2yqXAmcXWN/gLwewd4tkVGgroU7KXa0XZqGRChMssnA7W1cIqKcf03ssVjzpTCcFDx+zy27c7l/+Rkgx+d7ZcWe8sa9FHCyVq1xMQJqseqgCfMF5HE/GtCiybdq9d5UnfOpz5/tUBIHei396h5B+SePr7uwjOC6iMqK+nZ3fvXKnyao1e7zLyh7BtkvWi3by3wagzVADl1VsNQGepSdEsk1EeQxc2/4GJ7O9nlP8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199018)(31686004)(36756003)(41300700001)(83380400001)(31696002)(86362001)(6512007)(38100700002)(26005)(2616005)(186003)(53546011)(966005)(8676002)(6506007)(6636002)(478600001)(54906003)(6486002)(66946007)(6666004)(316002)(8936002)(4326008)(5660300002)(2906002)(66556008)(66476007)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmJ0MDltOFZPaWlDT2JsTVFYeUd4NXJEZUJRRDkrVjJZS2JEZXM5YUxrN1k1?=
 =?utf-8?B?NC9oOXFjSVkyMnpGSmJseHpWRTd1NEU3QlZucUl2VWJ4YjBuVmYwME5Xb2pi?=
 =?utf-8?B?NTlsOS9PMU9tY1EwMHVtZEd3alRQN3VlOXd0MWhHUHBZOUs4S3NOVVpIUmo2?=
 =?utf-8?B?aXh5ZWI1R1pYQmxvcEpBRm9JdGluZmZwNGhsZFlnU2c1UnBOVlBIOUhIZGZQ?=
 =?utf-8?B?UXVsbW9wRnh4QmZMSmlrRVdJendxUjl4czR5U1BzMDdxK2VOT1BEWDVGQk1P?=
 =?utf-8?B?UWxCWkxPL1MzdE9oOGFjdUVTSmVVNDBWYlAzdkNTaDFqR0NNaG5rWXZSVE5r?=
 =?utf-8?B?bGV1eGZZMVM1aENETDliUjdvQ1dnZ1dPMS9zQzRvMXh1WUVTdnpxNzJwM2hz?=
 =?utf-8?B?V2NNNmw1T0JpQzFhdVY5TkxhSGVOeXZyYWkvY2RoelU3dDBWOVpMbkFRRkRl?=
 =?utf-8?B?YnFQUFd6bVg3cHdnM2FHRWlYRk93dnI5QkJKMHFqRlZpOFdUWTZ1a3h2eDJ5?=
 =?utf-8?B?TUdOdTRMa1lSWENvNVFyMFlCUU1tMUVhbnQ3bXBnTzFveWhwNWwrUjNLb25C?=
 =?utf-8?B?Qnl1bmZ3K0lWWW5BZ3hTLzRwa0R2c3FaZlZVd2xTQnFwRlRXL1BWcWNkOVFr?=
 =?utf-8?B?UU1UZ2NyWmNZOWU2SHYxZjVQZUw0Mll6MWFXWWNUL09Oc0w5VUhyenYxeXU4?=
 =?utf-8?B?MXNkdGNxMERWbkswK0QwcTFPSUFMWUxNLzM1WGhpUWUxNzQ5WXJXRDRFcWdW?=
 =?utf-8?B?UzVoemtiMlBWVkdRczVBd3lwZjJxQTE5ZExPWDd1Ty9sTzRtNlN5UkxUYlFT?=
 =?utf-8?B?bk1NNm1FNlFRaWk5b2xvYlJ4eXAyMEh1WjFLK2Y4Rk16Z0FueFN3M01jNDdm?=
 =?utf-8?B?eHZuOHNpVFViYkdrWFQxbUFETlE1QmgxVEhOdWc2dWhRbmZ3YmJKTkRSbUs4?=
 =?utf-8?B?Q1B3a1RGNE43eklDNlZlUkFpZ085eitPbFFBNS8vWk5kUE1QbzI1ekNpbzNY?=
 =?utf-8?B?d0NTQmxBOEgwbllxbXdkQ1JtaVY1cE15cWw1Zml6T0FRVHNzTm9Qa25tK0FZ?=
 =?utf-8?B?cjRmZ05PaTJLV2ZhcUxEZG9mVmpWbGxzclZQS2NvZTdjeGZqeklPYXM3dXNy?=
 =?utf-8?B?SHN0RE9rODBaZjZYTGhHcWxLcGluL0x0OWY0dDU3UGVpKy9CODdjRUVGWkRa?=
 =?utf-8?B?VTdBdWExOUtJOTdoSjdjZDJjSkd6RlcvUTRkdHlLMjR6ajhzcFNUNkovSjJB?=
 =?utf-8?B?ZThUZ3JRTk1tUHNLQVFMSGcrNmI1eGJRZ1lGd2NlZnRHRmtzL00reHdrYjhu?=
 =?utf-8?B?MmE2ZE9CREtVaFQyeDEya0h0Y2NCWjN2TEhEZWNGbkRkd1BMMHFKZ1VybzJM?=
 =?utf-8?B?dUJ2RGt4NkhCME5pbzJ6dG56aE45R2xBUGZ6dHB5dHBlc2UxN0tkejNRZVdu?=
 =?utf-8?B?TGN2V2hoZGJiVFlLbm5BdXAzUmZRS0IzOWM4am9pWlFoYnZYM0R5dXlNMzhJ?=
 =?utf-8?B?N3EyTHBGQmJyRWRDTFZtakNZRmdqRmRiKzJvVDlPQ0NTczRWNDJVRWpNZU4x?=
 =?utf-8?B?WXpEUDdDOE5ISXpJamJPMkFmMG10NWQzRjlpa0ZkdE5PR2xseHFwWE4zOVhX?=
 =?utf-8?B?UmNML2x1cDRrWHJ6RHNCVTE5bjdCbmxJcVFTbjZxeExUNEZsV0JCbWpsbjNv?=
 =?utf-8?B?WnplYmh1WE9lLys5N3ZhbW4rQ0VwQnFOVXM1UG1acDBGQzdyeDBvbkNmbkta?=
 =?utf-8?B?T1FaKzVHSjBheHNEMytLenFZUG5pVlpoYncwOURjdkYrVUJrZVRpTk9ySlVT?=
 =?utf-8?B?K2VuR3lscFUvTzcwUTBuVS9xVkVOUmh5ajRIbWFDQTN1MDBPNHFNNlNLYkhl?=
 =?utf-8?B?NGszU0NHVFFsZkwxVU53NUxvMFl3T0txeXpwOC9URG5WY1pvb0dOTksrV3pZ?=
 =?utf-8?B?QlV6MWppbXc1WTZyRXlhQWlScWxmVVhjQ3JkcCsxQmpNSzZIT0hzcnRiakVB?=
 =?utf-8?B?elpMR21pMndGOVA4a1owazJkMEVDbjJuTzBvZUFEbzc1UmJZTERlVzZlREM5?=
 =?utf-8?B?M0l5UEEwdTNQRk1uVGtBdjRVU2RNRUE0T1h3MStlak1QRzlpeDNGby8zMElB?=
 =?utf-8?Q?vdLHm1b9WhY5aNQJUF8ZwPdKQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0153bef4-9e0a-4235-512c-08db0866657c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 17:20:09.1950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fj3dLKvXDNO51f6Y1+GJ8lElBQ94oVpgJe4KEWzqhelLmoVQl/05hcGmInmMSc8YWH0gxAErt6OKBOjJO4nbOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
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
Cc: Brian Chang <Brian.Chang@amd.com>, David Galiffi <David.Galiffi@amd.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, Martin Leung <Martin.Leung@amd.com>,
 Martin Tsai <martin.tsai@amd.com>, sungjoon.kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/31/23 11:05, Melissa Wen wrote:
> Cursor gets clipped off in the middle of the screen with hw rotation
> 180. Fix a miscalculation of cursor offset when it's placed near the
> edges in the pipe split case.
> 
> Cursor bugs with hw rotation were reported on AMD issue tracker:
> https://gitlab.freedesktop.org/drm/amd/-/issues/2247
> 
> The issues on rotation 270 was fixed by:
> https://lore.kernel.org/amd-gfx/20221118125935.4013669-22-Brian.Chang@amd.com/
> that partially addressed the rotation 180 too. So, this patch is the
> final bits for rotation 180.
> 
> Reported-by: Xaver Hugl <xaver.hugl@gmail.com>
> Fixes: 9d84c7ef8a87 ("drm/amd/display: Correct cursor position on horizontal mirror")
> Signed-off-by: Melissa Wen <mwen@igalia.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index bb155734ac93..480c0b3b51fc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -3624,7 +3624,7 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
>  						(int)hubp->curs_attr.width || pos_cpy.x
>  						<= (int)hubp->curs_attr.width +
>  						pipe_ctx->plane_state->src_rect.x) {
> -						pos_cpy.x = temp_x + viewport_width;
> +						pos_cpy.x = 2 * viewport_width - temp_x;
>  					}
>  				}
>  			} else {


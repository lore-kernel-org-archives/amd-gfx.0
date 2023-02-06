Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95576C636D3
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 17:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A98F10E432;
	Mon,  6 Feb 2023 17:30:14 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C827410E432
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 17:30:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z82Ajw35p+1alsH8EiA/Hm9RHiwYuqSYNXiNY8uHGTavIgI3jSTzpzDPLOsSnbHlkVSvBAWL/F0CJQzCsvLUpZQ3+ibh77bN7eeos9MS7CKrxrARcphUhq54wdjTqRPaYZLsZOf9XjZFU938BZn8upg/cJYcVpIWUfz7B6L5LtGbmdcWPd0lequlYiZPgTmAT6mQukTIUjG1oc/Fve8SYHEm9WfhXqXxLV8qORxLF9GGjvvDK7kzBDfYW/eN88th7LkBJsR7j9Ebibo4G8uknupnrjS26cTyPdysp8CyBu75UMzUjXyr8W9Rd3nrgrFsgDuyVmxIa9Sg3+JpzwkfWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETLDejGugvnWMvdCXNkOQYTsWYvyjXP/iSB9Xem0eJM=;
 b=Ejs3u758ZkDhAAYcPX9Fd8ahiikQmf3LTqaHWAYHPNDSBPSFpzhRbsG4HntpNMgKz9FDrW0MspTISG4Cy0GrRYuZFf70gL3i//NKlg2AAXjMLR1pbh+rbqkjLUOGsrNRbqTk7LHfG2Jsr3Sri7nQAKvv90Q1g99cdaCmdRJ5++laVzCbngCIw2RXbca1aMoXFkw4FMrxcvTTd8dwoyaCWBvd4oQ0huFRo6dmgaRdIWBsF82Q3BfvcK4iYONTAbuR770AdVdcntc1J+JqNg6v0R09VqXk4aG470UtNrNr4hNy0Py1zZg0qVHiNWeFS3Iw+cSSVFcPhw7yVUQ2+Cur6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETLDejGugvnWMvdCXNkOQYTsWYvyjXP/iSB9Xem0eJM=;
 b=ly/J0BJKS9qowoQoCZDS6gSclfAKVJrxBJxiv2fksJcaR6qlEO48v/D3iomyuRmlMlKcK/uLqV8FDJ7px3oJ+4BvHg7tI9csctD9bN4hf/TUnWC8h4T6w54UoX/tv6fOKq1/sNRHSOb/fa8mDMhyRJ5lc3akEc4E8Suz8ANGIt4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 CY8PR12MB7588.namprd12.prod.outlook.com (2603:10b6:930:9b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.27; Mon, 6 Feb 2023 17:30:09 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5935:7d8d:e955:6298]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5935:7d8d:e955:6298%9]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 17:30:09 +0000
Message-ID: <6135183e-b77c-a592-5a64-677aeb06ea3c@amd.com>
Date: Mon, 6 Feb 2023 12:31:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drm/amd/display: fix cursor offset on rotation 180
Content-Language: en-US
To: Melissa Wen <mwen@igalia.com>, harry.wentland@amd.com,
 sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com
References: <20230131160546.150611-1-mwen@igalia.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230131160546.150611-1-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: QB1P288CA0018.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::31) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|CY8PR12MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: b60337b7-89a3-4240-7dfc-08db0867cb80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vyuB5RBme6Zwaz0lW2OJlb1HIEDZX/jxbCnWKp6tXJC7NkQBm2kOezVBLxu0UqjQITdMW6NfE4KgV9wVDnmGmv/2BondGTTauQVA2kEfem2j6bQezs292ryovYP+qLGPqw0bwcOOJt8JxLlYrjmoEbxuVPpbDMQivURlfHBdRDBdxOggYi9ThPLIsfYS010UZ3RhK3iuWP86H0ij2WBO9TZqlTdG62OXhVP+hgZTYGXDILDq/j/x78uaE+d0xr94uxskuX/zgIOVqr1+aYWC43Wb6ymObpm2mhxgvFCgn3kKz18sooMa3Z5RpBE6cyaXNQ919+YI85rlz4jM/Znuhlf412cfQXve1+rAEKneOcqgfqWbD6/NYZsWwXxWDX2xrZVRRs8HD+qglbSMaHmVOzonM933xMdw2j3CNzz13MIo+A/N0QwwdgaXNxzQpPvkKksNx0NBdwN2A3ssyO+avsx6ON0lOF0s8+xEodWsO1yVROSUOehLP1N9HqUuoq7ufh2KwOb7jvXmwtBG6GB+O44KqIByo/HIGcs2nZ0eiUXvGtosT/j7u8WDDkNXHOmywlGogOm9UAZz4xBMm1HUlioUo11Xktw/XBVx0FBLGeIrwA0y3O6sbyoHpvuTX6JbMbnQ6xqRxG0DyR1eTNelR7k0dtW8jHAtTVWBjbgWRksJx9MWJRi4RFwLOO5LWuCyIi9AsFCoo0lT2x8hK4GauB+SaNf/u+hJEryst3fCqzCZZS2VNR0IhueNTCzaJ1GruYRoezU6hTNxEfQwqWGa3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199018)(36756003)(4326008)(5660300002)(478600001)(966005)(54906003)(44832011)(38100700002)(6636002)(316002)(8676002)(83380400001)(6512007)(6666004)(66946007)(186003)(26005)(2616005)(41300700001)(66476007)(6506007)(66556008)(6486002)(86362001)(31696002)(8936002)(53546011)(2906002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alpYaHQxZzR4L2tCc1l3bnZxK2lQNnpPNjdweHdBS25JQ3EzNUlUNkxlSGFw?=
 =?utf-8?B?VEZOWDJUUXgzRGJSd3NkM3pqaWwrdDZDek1VVktObUV2N2tISkhYa0RiQTQ0?=
 =?utf-8?B?M0JhQ3JNaTJiYUw4N2g0WWF6YTN1Qm5UK1BwOVBHNERYT0RaUFJhWkJWaDJZ?=
 =?utf-8?B?a2JNSWFYVTExeE1mKzRwRnV1T2pDNWdzMk9VLzlUenREUkdVUmVaQXh5bUpJ?=
 =?utf-8?B?emkreHlWWG5pN2tZMnJ1TnIxVWdHeDdQOG5KelZ3NHo2NW5OSm54UVZuY2lT?=
 =?utf-8?B?QUFYV0cveDF5Z2tpRmZRMWlqR2RidGdOSThmWCszc3UyKzBIUXZteFRLK2gx?=
 =?utf-8?B?Z2VqbDJxMGhHRXdYcWN1L1oyU3RyUDl1VW9uR1o1ZDhYSEZWOE9VRDRWN1NH?=
 =?utf-8?B?QVFEUWVCakR0akhLY0V4OXY4ZmwwbkhMRzFGQThEYm9xaDFqR0JVTHk4dXNx?=
 =?utf-8?B?TUdVNWprczBNZjlvWVdIcDhZVm9KblhXV2FDbGVDVG5VU1NVSHJacU9COVVZ?=
 =?utf-8?B?TjlTUXUrVmpZYjAvQlRFeWpxOTVJalhualpna2FkWjhveTYvOFg0d3F6dkJ3?=
 =?utf-8?B?VTlUU3JTZmQ2VnhFSk94UkVqOXA0TkNPeGdzclcvTzB2bEhLdk5vZElsaVJi?=
 =?utf-8?B?aVFSdnh6NWFidldtUjRYb3l1V0tGaTMzbG04RDFvRC9CVEdjTEM2a0F2Zks0?=
 =?utf-8?B?blhNTHBZMlFTaGEzejBoN2JuamhHUW1LbjRuWkFUdkIzMHFZbHRFSUtxUFlX?=
 =?utf-8?B?NEZ3MUFzYWp2MTdCRmppQWJ2eTVSOXp1QmgvTnQ4TzBaM2dzc2E5YnRBamx5?=
 =?utf-8?B?amZIWENFNFZ2NS9xM2NyL0d4WFplOE1JUmVEQldjWVF6K25yclJmR3VIM2xz?=
 =?utf-8?B?dTY5UlF4R0hmSGw3ME05d1Y5cUVueWQxOHV1SHdFSEsrUHNLTk9Gd3JkMFpw?=
 =?utf-8?B?Y1JNM0grbmo4dURVcndPWm8vek15YVNiUHpPNGJ0SW5BTDdQRy92T0NLclpU?=
 =?utf-8?B?SGcxZ2FrVVJpZnNFZWdHeC8vUFdrUEVQeHdaUDZkcWpzS0s4dkZwTU9TZHFI?=
 =?utf-8?B?aHl2eFFXcjhtbTBaZ0lMYXFrWXR6WkhucGFFdGNDR2QzcWozWCtNdldZV2dW?=
 =?utf-8?B?MVA3ZDNwZEhGMjRycnlVYjFQVlZIMDRKbTgrei9oUjJ5YnFvOW1zaEoycXJB?=
 =?utf-8?B?ZTVBanM1NSt6ellWbksrcXkrdEkzWGZ0cTAxTnFWbEo1cUpWVTFLT0o0V0Y3?=
 =?utf-8?B?dXI4U1RiRWprVDQwTjZHbUx4TzN4NTRPd2tGV2w5eHJkaWg2bWxBbGNyaDlE?=
 =?utf-8?B?YmF0Mnk0aUFJUDYweXBKdXhqejgxOGFKWDdwa0FTdDZEekxhenpKLy9wY2Zn?=
 =?utf-8?B?RGJjcDN4SWFhdndMa0JXamtlQ2xlRk5GaTQ2RDVIbjhkTklPMWlXUmszcTYv?=
 =?utf-8?B?TkpsUVZhRHgrM0srYWdtMkN3WTc0amNDeGx3WG50S3U1eEdXN0EvV2NuRms2?=
 =?utf-8?B?MDBacHE3bWd0QkhFNk4rcGs3K2pHU3N5bzYxTUpPRTFqa3pZT1FMSVdodDJQ?=
 =?utf-8?B?MXBnTk5nL1BjSmNTRWE5ME0vbWQvT1IyaFl3c0prQ0xaMkwzRDE5b2xSODhk?=
 =?utf-8?B?a2ZqOEF3c25jWTRtT1U1c3oyaHB6dlJCdGo2S3hBSEJiWmNUWkZtb1RmOEIv?=
 =?utf-8?B?TkdpbzNYSEkwZWo2VzRJS25lYmgydUlhcExSZVhCZDBMR2MvV3RIekcyWjFx?=
 =?utf-8?B?NnFxR0R2aTh3eEFLc3RDK0xqT2lMRTRJVXk2bEZUK1ZQcTU4ZllyTnhzU1gx?=
 =?utf-8?B?QUdsYzE1R3ErUXY0cUg3ZUFBUlBTNnJ4bDVyY0dVbG1nWVcwNkpzM1Rnektx?=
 =?utf-8?B?WXFacVBFZXhKbVA4YjV6QzVSM01yelVCemN5RXJRTHF6VTh0Z05EUllYVDY2?=
 =?utf-8?B?QVdWbHBHcnZXVWcwTDl6WTh6Z0lQVzdvcDI4K0NTblg5d1ArcVFoZkI1Y3pq?=
 =?utf-8?B?VzdiaGM0VWdnbW1ZQ2ZDNWY1c0gzZ1RIOUlFLzJTMkJEa0ZpdEMwTFZ1UWVp?=
 =?utf-8?B?UVNEZm1NNzlVS2loK1dHMkNlWVRjWWlxb05VbEkvRGt3K3JzcFVtN0tZTGFZ?=
 =?utf-8?Q?sf4HnF8CSLAiADzDtzFgdkqvv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60337b7-89a3-4240-7dfc-08db0867cb80
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 17:30:09.4406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kd9uD/JmN7I6x7kkuX5b4UQ7OK7haiMu75JNZ3Yz2jrz68EuwuCY1UDJ35nLUvuknjk7EtEKmfrRw/XewS5quQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7588
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

Applied, thanks!

> ---
>   drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index bb155734ac93..480c0b3b51fc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -3624,7 +3624,7 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
>   						(int)hubp->curs_attr.width || pos_cpy.x
>   						<= (int)hubp->curs_attr.width +
>   						pipe_ctx->plane_state->src_rect.x) {
> -						pos_cpy.x = temp_x + viewport_width;
> +						pos_cpy.x = 2 * viewport_width - temp_x;
>   					}
>   				}
>   			} else {

-- 
Hamza


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018F1CCA479
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jun 2022 17:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 878F410ED59;
	Mon, 20 Jun 2022 17:50:54 +0000 (UTC)
Received: from mail1.bemta31.messagelabs.com (mail1.bemta31.messagelabs.com
 [67.219.246.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D887110ED2F
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jun 2022 17:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com;
 s=Selector; t=1655747274; i=@lenovo.com;
 bh=7uGDgvCzSqFWrnC4ZprcXq/MbsjLGdjiESIxSv4jCjc=;
 h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
 In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=C0EdgWpcAcEGbaZzNYP32OSl6HKbfd56buUJhdUHmVeFXgvNRG4Bx1HbIIJTiUNQ8
 HumdQ3vRYRVNA28WDGGqzdedNmsv8QT+BACytdrR0cENpcQqCrI6AyFz73zeXOnWQ/
 7ADfCwENHfhJ2xIuq7EYbZtr1l5iSl8BUXn2aSWYGLRK8I4pqEW/ZTf0lTGzTwaEK5
 FhJ/XJjJyONhkORiCakdK/X2T2zdV6UAKmyOuIA63yJwXi/wsAv12NonVZPRXWeew7
 Ewhl2i6Y2yOWhwNLEUMfYPih1mNAtPtLj7l758rlEtwpQhiDkO7zYORYrM1+7Xohy5
 Csr4MFUWLApfg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGJsWRWlGSWpSXmKPExsWSoS+loXtq04Y
 kg7ezxS3+zzzHarF0fSO7A5PHrIZeNo/73ceZApiiWDPzkvIrElgzFk5fzl6wX7hi0RPhBsav
 /F2MnByMAkuZJT70hnYxcgHZi1glnrX9YYZw2pgkts27wwLiCAnMY5L48PcJK4RzmEni+/IOZ
 pB+CYHjjBLdq9whEp2MEru3/mCDcCYxSZxrXg7V/4RRYsWduQjOvemfGEH6eQVsJW7M7GEBsV
 kEVCXu/NwEFReUODnzCVhcVCBConf1C7C4sECyxIauE+wgNrOAuMStJ/OZQGwRgWCJv2uPs0H
 EVSWuXrkEVi8kYCfx6cRnsDibgLbEli2/wGxOAXuJbztXMkPUa0q0bv8NNVNeYvvbOcwQvcoS
 v/rPQ/2pKHFv+0dWCDtBonnKUUYIW1Li2s0L7BC2rMTRs3NYIGxfiR3bNwPZHEC2rsS+JaoQY
 RuJtze2MEOEcyTudgVPYNSbheThWUgem4XkuFlIjlvAyLKK0TKpKDM9oyQ3MTNH19DAQNfQ0E
 TXVNfCUi+xSjdRr7RYNzWxuETXUC+xvFgvtbhYr7gyNzknRS8vtWQTIzDppBSxRu5gnN3zU+8
 QoyQHk5IoL++0DUlCfEn5KZUZicUZ8UWlOanFhxhlODiUJHhNNgLlBItS01Mr0jJzgAkQJi3B
 waMkwrtkLVCat7ggMbc4Mx0idYrRlePKtr17mTkenDgJJK+tX7CPmWPq7H/7mTnmgUghlrz8v
 FQpcV5zkNkCIM0ZpXlwo2HJ+xKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYlYd4dG4Cm8GTmlc
 Bd8AroOCag454sBzuuJBEhJdXAJJ8Ylxxb7/9g8ZtGXe0mGz+pm9GL7AJ3Bstt+1LK89E59Bv
 bioctnQc8fexe/St9ukn/98z0hr+bs6Nu2577WvH3aur6otqvN29M+N37gDkp4nHdHsYs4f+m
 3el32buufs1STerya746iZuRr2gB66z5LqI6G28xrtC205lQMEn00qSZbClPjjh/c6h663yB4
 f2rp892N3xaL1AcEntvGpPPu+L76ksj1u1uaL3x7v1/IYnTjx8/y+FzjT3/9mvIErvPwiK9be
 /0XM3qNHoSA6scOJvX8ZiwHvY3fa5iZXuv/PLmFv2M/7o9Jp9vH9raq7NQP05VouJCSH99VLd
 2wEJO26WKXP4rDeQYvlkrsRRnJBpqMRcVJwIAsiCCpFkEAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-7.tower-706.messagelabs.com!1655747272!193761!2
X-Originating-IP: [104.47.26.40]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21455 invoked from network); 20 Jun 2022 17:47:54 -0000
Received: from mail-psaapc01lp2040.outbound.protection.outlook.com (HELO
 APC01-PSA-obe.outbound.protection.outlook.com) (104.47.26.40)
 by server-7.tower-706.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 20 Jun 2022 17:47:54 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AgszxGFh4j2nRlJrfYAiWkP1cmZ4vhFbIe/0it8i8f8MR2q+73+qhvwzp/zbgewr+WcyQJ2dSnkZIHfSH8OAH8apfaN8ENUc+1ksonySRIz/dr/+K/MtWC1qoVVa5eEgmw1HrT75ZS21hfoyXiF4ydLgUmZKP3jqGwETizJ83MY1EmN/LI7YHyKOYNTZ5uJb0kfPwDTDQuegNB9b+4ajXGsowFXxVAmPxdykBpR1nGsD/xw4k8yLdJZfZLo1Db7/7+uzb8pp+c6TQIcEwlRd3hsBDH5KMa89Ff09Vq4LjJWt052i01GmbHFZQPWa+KPGj4QDZgXQKeOWWLLIhxyM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uGDgvCzSqFWrnC4ZprcXq/MbsjLGdjiESIxSv4jCjc=;
 b=OjfzS2JFDUS26CoiptEf09im4hwpH4/KsxOzdhCXJorAmwaukUcE3iTBZ9gTZlwuUApHtAWPRVf26anVmSyVFUYBw3FD+STTKIXeAoQSOC9kYpiJWP3LvCZnZt+kIyywCXv2cS73IoRYnQMk63Bu7qHU9+noqW1uocf9VVbj6OlxACMC1wOu1Zr5DgF36zrFGsJDA6DgfsDRD+RY63Yr/2z8lzvD+lq6cfWOnfnc6EWzmRmPXX/zZDUDPbrWabx+QLRAnCkYw/kwCZq5zI0sx9v6xNNa9SgN/v4o1TlZMEQ7eilZIBmVulDV7c5pPbW5uAF4YTJnJHQQPxKGz0+WlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 104.232.225.6) smtp.rcpttodomain=amd.com smtp.mailfrom=lenovo.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=lenovo.com;
 dkim=none (message not signed); arc=none
Received: from TY2PR02CA0055.apcprd02.prod.outlook.com (2603:1096:404:e2::19)
 by PSAPR03MB5368.apcprd03.prod.outlook.com (2603:1096:301:48::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.10; Mon, 20 Jun
 2022 17:47:51 +0000
Received: from TYZAPC01FT012.eop-APC01.prod.protection.outlook.com
 (2603:1096:404:e2:cafe::db) by TY2PR02CA0055.outlook.office365.com
 (2603:1096:404:e2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22 via Frontend
 Transport; Mon, 20 Jun 2022 17:47:51 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 104.232.225.6) smtp.mailfrom=lenovo.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=lenovo.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 lenovo.com discourages use of 104.232.225.6 as permitted sender)
Received: from mail.lenovo.com (104.232.225.6) by
 TYZAPC01FT012.mail.protection.outlook.com (10.118.152.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14 via Frontend Transport; Mon, 20 Jun 2022 17:47:49 +0000
Received: from reswpmail01.lenovo.com (10.62.32.20) by mail.lenovo.com
 (10.62.123.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Mon, 20 Jun
 2022 13:47:48 -0400
Received: from [10.46.197.219] (10.46.197.219) by reswpmail01.lenovo.com
 (10.62.32.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Mon, 20 Jun
 2022 13:47:47 -0400
Message-ID: <4d95b373-1324-2224-fbfe-c8f8c576aedb@lenovo.com>
Date: Mon, 20 Jun 2022 13:47:47 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: drm/amd: Revert "drm/amd/display: keep eDP Vdd on when eDP stream
 is already enabled"
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 <amd-gfx@lists.freedesktop.org>
References: <20220615223005.11667-1-mario.limonciello@amd.com>
From: Mark Pearson <markpearson@lenovo.com>
In-Reply-To: <20220615223005.11667-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.46.197.219]
X-ClientProxiedBy: reswpmail01.lenovo.com (10.62.32.20) To
 reswpmail01.lenovo.com (10.62.32.20)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c0e9137-923a-4bde-e759-08da52e4feab
X-MS-TrafficTypeDiagnostic: PSAPR03MB5368:EE_
X-LD-Processed: 5c7d0b28-bdf8-410c-aa93-4df372b16203,ExtAddr
X-Microsoft-Antispam-PRVS: <PSAPR03MB536860B410FB8A3FA8BB7886C5B09@PSAPR03MB5368.apcprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y179sxlNUCEs1Je05mnIgfb82+1E4Fl6i9arvXXw5zgf7aIdBT/wj74nkAvguzM0J3qxQqrkevXL/I20rh0KI1WRc6CKgv6+sTjifgjsccX73cZJ5sHfvysNOTdVJF5i8RFB5wEW+fWewpCmpDg+pu1q+Rb3aNZdU/us0zt9Cl6WglYUTS5Sg2olkpSTOpgY9yWy6ivRd7n/xrEEbWU4yKsUugDD0qraQ8Z0Pgq4N9tzS/V/V2sfZ/9+S6SpgEOR/OKcQGMpL659xSaznRLyWQXmZfubzUlHG371ZgFLkOgnBSWUSA8H/vxtMmqiabK4n4/nygXOvKiMgiVXozEmvJEf26OjFGkgBjU54THiQkIYMBsbCGX3lb/BoJLBOpyXmNUfWKVPqV968wrJWWIJl8yVExGvW4x+9dXQxVXmCrRHgwXG8wDdzZM9SyxkKs7L8Fcn9Ks7pIlyoHne2hDfCCbocUXuWk7ucEa0GDGx1us8ljlKzauL7Mlips9aNHxUZ2YXhvo+pTSAFodK3FYZOdQxH6yD2GMLWIG6j6hBteWn5KS0Gp/K74d9Gy9Htrp8/V39kAdM/rDw0bX+55PhQh9Udn/GyUixuB5sZqgiTw1r3lUEPYfN1F4IOh6Fo70qjOh9pClk+XnCKa16LOCmeKWOD/UK/zffJtkQpKTlkLZzfUN+dbB2QyRwb72yKdBVVf/X+vx8vlpi9MOK3fPBCSIqxFxZIFkD1PxdxsYn0eTMN3Mu/0bHMPC6VUTkWM4IY5YpyKqwFqRvcqq3rKH7Z+imiXUfnSESO4Dr/cjKX2xt5LOzbu/VVPo+IEadAk9s
X-Forefront-Antispam-Report: CIP:104.232.225.6; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.lenovo.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(376002)(46966006)(36840700001)(40470700004)(36906005)(16526019)(83380400001)(2616005)(31696002)(8936002)(70586007)(4326008)(426003)(110136005)(8676002)(16576012)(316002)(86362001)(5660300002)(70206006)(40460700003)(336012)(186003)(36756003)(82960400001)(36860700001)(82310400005)(82740400003)(26005)(966005)(31686004)(356005)(40480700001)(2906002)(41300700001)(81166007)(53546011)(478600001)(47076005)(3940600001)(43740500002)(36900700001);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 17:47:49.6610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0e9137-923a-4bde-e759-08da52e4feab
X-MS-Exchange-CrossTenant-Id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5c7d0b28-bdf8-410c-aa93-4df372b16203; Ip=[104.232.225.6];
 Helo=[mail.lenovo.com]
X-MS-Exchange-CrossTenant-AuthSource: TYZAPC01FT012.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5368
X-Mailman-Approved-At: Mon, 20 Jun 2022 17:50:48 +0000
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
Cc: Aaron Ma <aaron.ma@canonical.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 6/15/22 18:30, Mario Limonciello wrote:
> A variety of Lenovo machines with Rembrandt APUs and OLED panels have
> stopped showing the display at login.  This behavior clears up after
> leaving it idle and moving the mouse or touching keyboard.
> 
> It was bisected to be caused by commit 559e2655220d ("drm/amd/display:
> keep eDP Vdd on when eDP stream is already enabled").  Revert this commit
> to fix the issue.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2047
> Reported-by: Aaron Ma <aaron.ma@canonical.com>
> Fixes: 559e2655220d ("drm/amd/display: keep eDP Vdd on when eDP stream is already enabled")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  .../display/dc/dce110/dce110_hw_sequencer.c   | 24 ++-----------------
>  1 file changed, 2 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> index 7eff7811769d..5f2afa5b4814 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> @@ -1766,29 +1766,9 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
>  				break;
>  			}
>  		}
> -
> -		/*
> -		 * TO-DO: So far the code logic below only addresses single eDP case.
> -		 * For dual eDP case, there are a few things that need to be
> -		 * implemented first:
> -		 *
> -		 * 1. Change the fastboot logic above, so eDP link[0 or 1]'s
> -		 * stream[0 or 1] will all be checked.
> -		 *
> -		 * 2. Change keep_edp_vdd_on to an array, and maintain keep_edp_vdd_on
> -		 * for each eDP.
> -		 *
> -		 * Once above 2 things are completed, we can then change the logic below
> -		 * correspondingly, so dual eDP case will be fully covered.
> -		 */
> -
> -		// We are trying to enable eDP, don't power down VDD if eDP stream is existing
> -		if ((edp_stream_num == 1 && edp_streams[0] != NULL) || can_apply_edp_fast_boot) {
> +		// We are trying to enable eDP, don't power down VDD
> +		if (can_apply_edp_fast_boot)
>  			keep_edp_vdd_on = true;
> -			DC_LOG_EVENT_LINK_TRAINING("Keep eDP Vdd on\n");
> -		} else {
> -			DC_LOG_EVENT_LINK_TRAINING("No eDP stream enabled, turn eDP Vdd off\n");
> -		}
>  	}
>  
>  	// Check seamless boot support

Verified this fixed the issue on my Lenovo Z13 (R5 Pro 6650U) when
applied to a build of 5.18 from Linus's tree
Thanks Mario!

Tested-by: markpearson@lenovo.com



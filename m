Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E60C001DC
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jul 2023 16:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE94C10E2C4;
	Mon, 31 Jul 2023 16:15:54 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E6F910E2C4
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jul 2023 16:15:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B54hGsAxAhb8ZGkHHYeHPqDVWPSKQOBebCRCbDZbBS2foM12EsmgSIPldCamLzyQ0D1w7t3GUseQ1jKpaaPIUJBghI1botiylTScu1ei71vFV1iljv8kJ87tdhhJKZxvR0rap0rxWHhoSKLGFlEFkh2aeYIKlMjqTRsDL8+YnZXY0mb92URefWBM28fqGuHceZjFRGdbanXbebER7Cnv2kQuZrMk0FsB8o1BIKcA5JiGqVRX7I+KFKVmCfkrbvu2uck7TdmT793oj9y3edSuaM/jpTH/eiwHDlLwwLkuAB/ByBBsmb48DYVB+BfU9OYH0RoOls3gk9nvzKqlROWKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTNJjXTi5zAJe7LEj7vzgYxf4EMWXnf4SRhGYFPhL3Q=;
 b=TQPC2+kDZC/MrbbyWUE934CgIRNk3pCyZ6prjiBVHe2zQ+hMMhJVpbp9MGO0Zk8sQVCookV8oh2EB8kbScmUc3Mb5lXjICDpkZSHcI0OxgQFqBrbptMkGRCp+MQSPUyLLEP6yNJuuU1HADdTmz6L3cFVeyYH0Qio/QB9FU30Je4NWaboTLWFwmr/leBe+hJvgUyRMC8lKbSRSfGJIyb6Z1DA5CQRsokofBgqYvQBvn7Sf0jebPcU9728TBTwa5tm0qi/hbW/FOS6QgnHPbM3TCLHiyQAij4/f36au8K7B/gMeSJj36KCpk9dq0nsOvk/S4thW7Bn214/Rgh0rHe0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTNJjXTi5zAJe7LEj7vzgYxf4EMWXnf4SRhGYFPhL3Q=;
 b=INXglFgGOORlqAX8/VIYFQ4Z3Zy2fmRBUJTmZCWemVvXsR6JFec8d3yOofjxpbCrbaORKbuwQY1nbV0Um4zvL3+7dM0HOqOceBpuru8qUaQayh6TwDze5s6Fmu6JsvKCQnyvWKJAJ6IYgOvghCIlET02vyLR+V3Y2jxObk9HXUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 BY5PR12MB4888.namprd12.prod.outlook.com (2603:10b6:a03:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 16:15:50 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::4196:c9c9:dfe9:8079]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::4196:c9c9:dfe9:8079%3]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 16:15:50 +0000
Message-ID: <cbfaff3f-6570-4ff7-8376-4824b52b35e1@amd.com>
Date: Mon, 31 Jul 2023 12:15:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Don't show stack trace for missing eDP
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230731160824.1992-1-mario.limonciello@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230731160824.1992-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0287.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::13) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|BY5PR12MB4888:EE_
X-MS-Office365-Filtering-Correlation-Id: 379866b9-d998-4bc2-093c-08db91e16820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UwdnToT7zPguDmodD9Ts/34TyttUQ4h0WXZiPbYCxyrlodrRREIqkVsvp0VZxsth9+00YtRq6L0jvlg8ay1UBp+qJWpjlA5pQcrtLHBu9+jehf5LzMBZe96qsVPnD5VsHo0To+epaA8dMTtRVU5oV0HrPlTkRW3Y5MJHu2ImgVNiQmtVn/YcqBW5ZmTkaR+zhs3UtFW83fhGOGeG8Z5XJiBWvN37A70d5g9KYDHrCHmawWhHk3nuMC8OMQgDnos6XY3WRoYwzv3ZMRNrqVoLK4A0sxTQPiCjy2pNAIAC1md7oGINYboRdXCPV0b3ey7gXZyzQrCSIfRDnW3eYwdkSLDxR3oQRVqFgtyt3d8YQWWrBdZLV9hJzR6wXRDkafy1pDinTsNWODzENCKKJVfBIvx5TAOH5mGTvOYp8weyb1nIq7Kyg6agCvrW0iXPfyEsWQAluZZ0IpkFxC/eL61DClrdcM/Fg6bnol7VfhGUO3fGe97f28TV91G6ZNs0cWxPxYBy8UOXytZzuJrDOyAeqXZrLuC4wxjD/5NBr07ZSSAIltZJmkA2K4EMC5we69OH0fjNPpDrm2tEh4cWleWj4YH7PHigmdXjf8x9krJPtzqwCnw4bsWyvp1vpnRat1WxvO462BkmMpaayNJOFPotz4eslbQtbqNh8awt/jMNcS//fdTq/MRyRDBUZqyhFOO9afCm0OVHUIhlqXsHlxHCDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199021)(4326008)(41300700001)(5660300002)(8676002)(66946007)(8936002)(31686004)(478600001)(44832011)(316002)(66556008)(66476007)(2906002)(31696002)(86362001)(6512007)(6666004)(6486002)(38100700002)(83380400001)(6506007)(53546011)(26005)(2616005)(36756003)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VC92QnBWL24zTytpNzBWbHR2OHJlTHlXTExCaTNEdi9FNUZ5RFdLTnVuT1R2?=
 =?utf-8?B?SG00VVIvcmRDdG4xY1hWVkdKYzNPbTQ3d1NLVWUyNnFSRC9walBRUnl2SCtw?=
 =?utf-8?B?bnRSMWdKeGhRMkt1QlpxN1FEUFBrMzBmSWZzWjI4T2pjSlZPUFpId3p2Z2l0?=
 =?utf-8?B?aisxNHQvbHplYmQ0R09QcEpSK3RpK3BIZHMyNWxMVnM0RTBNME5uLzI5aWdL?=
 =?utf-8?B?SlJYNEJleGNneUV4S0piRGhwc0NRZVJJYzc2TDFzRkdhTGNrOWFDMjFrbndB?=
 =?utf-8?B?Q3AwS2IxSWdETGxoTGhsNFhiWk1ETTM4ZUFqQnZ5Wmt6NVNONXQ3K2tQc3o4?=
 =?utf-8?B?Z21pYzRUQmRUem5HWmhpVDl0alg1TXpxRTJtZ1MvK2lNaUlnVkV3SFlDZlV1?=
 =?utf-8?B?ZG15U2NPaEdPSDBuOVhrY3d3VFdpWW5vSHFqaEQvR3hyNzRCT3BIZ1Exd2tm?=
 =?utf-8?B?aCtnWjR6RStsRmhxWlFSQkZHa0Y2Y0ZOVE05ZGQxN3UzRFdkYzl0NzFOdHlm?=
 =?utf-8?B?YWZmaGRSSkNPNG9EMGdMOWpkVmRtMWw3UnZoQUh6K0tvRjFSd2c2MzYxaW0v?=
 =?utf-8?B?aUtQb0RQdE9hQzJJQm1HRkF4a0Nhc2JYSml3N0gzVnVZc0tzWHc4Q2NpeVFX?=
 =?utf-8?B?bUtORkNIdVkrTnZTYU9XekdDMlRySjh1b2ZKcGJybXNTUmppVVRIZ0dSbG96?=
 =?utf-8?B?MnNsT0ZwMjRZNHZtTmtCQ003RTZVK2NBM2Q1NEYybnJ3STVVZk90R3RIRlZh?=
 =?utf-8?B?Y0pJWUUwMEtkbEVFRHdKRmxXRTJoSEl1ZDdjZTJ1OUxSTHkvYkI0d3JVcmZi?=
 =?utf-8?B?TkxvYnczeUlRRkxUK3l2bmlrdkFVbExHb1JISjBZNjB5R3VBZlMrejBuU0po?=
 =?utf-8?B?M0J3cEZZblYxSHhVaTB5emNRWnd3ZjZNZEs0Q2N4TW9TZTRFd0Z0emxmQkVK?=
 =?utf-8?B?ZUNwNW9hbnZuVi9HNkViMVFPOGJ6SG5wREUvSVFJWFlJTEdEZFBqR3hTbHJL?=
 =?utf-8?B?RjFmdytUS1JseDVVc2lwV2g4SU5CMlNSWGdPUTJaQ2ptNk1oNDNVdW9QRjhK?=
 =?utf-8?B?c0pLcmM3SjZFVlh2QjZpUjJoVTFKT2E2eUxCNFYyZVI3MDlOVERqTVl4NDJD?=
 =?utf-8?B?K3E2VmM4NkN1Z3F3aXVjcFFTb2loWjBWU1ZJdEVXZ2k4NGo2TllOdWtFNklY?=
 =?utf-8?B?aUtxZFVHQ2xtWFNkVWVoUEFDSlorMG1QVURYcjFBZm1CeGpGcmsvK2k4YUlR?=
 =?utf-8?B?NHliTW85ZnQ0VG5Ccm1JUkZUK0hCdDV3UjVoVG95VXZhejg1d3FLLzEzQ0dz?=
 =?utf-8?B?dFlycy9JR0JwdGoyMUJpck5hOTZHMU5pVVBWLzdUUVA4cDdzd0poNk9hYnl4?=
 =?utf-8?B?b256VUErZ1BCTitsRDNBbzI5S2RtUFROV2dremtMenpqY2k5UEcxV1RPR3Aw?=
 =?utf-8?B?TVEydnZrTzFmcy9CWlNYSlZ6czZrR0NlSkh2Wk1WOUcrSnViUWU2bS9UaEln?=
 =?utf-8?B?b1I2UVNBRTh6TWVWQWNWdVA2ZGdjQURTS0VsUXdtdEl3Tm0xYnBLSTFFMzZH?=
 =?utf-8?B?ZkMvaldBVGxvTjlydVJ4dExNSXZZS1ZNWGNwejBtdFhyUk85RXRBS2pORXEr?=
 =?utf-8?B?ME0xb1NMV0o0N1l5UExEUnBZLysrUGFjUlMvbTN2Mm9uZTVLTTBpTVFRRy95?=
 =?utf-8?B?K2xqb0pveXhucmRiZnFvVGtaS01pSDcrREdnRVRrcy8ybnRVeHd4aFhDdldY?=
 =?utf-8?B?aEg3Y2R4S0VOYVNnYk9PdG9jL3VvUEx6V1Rud3M5ZHRRV2dnQ0JSczRhREh0?=
 =?utf-8?B?NXljVEIyTEEwQ0JhOFVpSjZmRWRldm4wdmZBYmlqaXFSTGprUVp5UWVVREE2?=
 =?utf-8?B?Y2c1RFcvN3BhdXdFMU5aVDYwOE5EcmlJQVhpdCtNYWlwOFFXQWpGL3I0N2hS?=
 =?utf-8?B?UnFCcC9rYjlDcjYwZlk0ZGZMN3BxSnRXUGlsK29CbGJCS1M0VVVHSXRQMkxH?=
 =?utf-8?B?SGt6VktHanZPZ0VYbXM3cGRFOEs1cDZac2dWTWZJZ3JBeW5VcFNpVGZtR0I1?=
 =?utf-8?B?U3dBdlBWdzlUSXVWdnBOSHFaUXlkTmp1RnJKTUQyZmZ0ak9Pem5EWmNFZUZr?=
 =?utf-8?Q?UIH++k/T31Me3LxQwXTpIQJpj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 379866b9-d998-4bc2-093c-08db91e16820
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 16:15:50.5166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WETzQftdhb6PkohhgD151X8Dsktdmsh9APpeF4s3H1tMiml88s34lBGGF/cVsIXYuIb4oqi0eePXrwNKlQFkfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4888
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
Cc: Mastan.Katragadda@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 7/31/23 12:08, Mario Limonciello wrote:
> Some systems are only connected by HDMI or DP, so warning related to
> missing eDP is unnecessary.  Downgrade to debug instead.
> 
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Fixes: 6d9b6dceaa51 ("drm/amd/display: only warn once in dce110_edp_wait_for_hpd_ready()")
> Reported-and-tested-by: Mastan.Katragadda@amd.com
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> index 20d4d08a6a2f3..3ce3d3367b288 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
> @@ -777,7 +777,8 @@ void dce110_edp_wait_for_hpd_ready(
>   	dal_gpio_destroy_irq(&hpd);
>   
>   	/* ensure that the panel is detected */
> -	ASSERT(edp_hpd_high);
> +	if (!edp_hpd_high)
> +		BREAK_TO_DEBUGGER();

Can you print a message using DC_LOG_DC() here instead?

>   }
>   
>   void dce110_edp_power_control(
-- 
Hamza


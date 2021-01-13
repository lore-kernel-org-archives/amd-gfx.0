Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9A5C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 05:32:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 070EF23132
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 05:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 070EF23132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48D7C89C3F;
	Wed, 13 Jan 2021 05:32:01 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2078.outbound.protection.outlook.com [40.107.102.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF69D89C3F
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 05:31:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avbQlSsGCwx3iVneKt5pRrUXqHmmx6U6Tilw1lN+j2xO7j9m7yIDL+XnATpfGJqsUjNMLrlbH+9L3nlqSwD6bmxbRIOPEfdC6wR2IcUEnxSUjKlFGO4Wwj851ToINP7eXuiYFSODlyoBUEHR3iTwvPR1zxB0vtHgQPr46W/0X7FcbROTQilVnhd6D/mhes5LGgxfHHwVvEw7KK8GGvaFxjCCerDc4j9Hm5nxCu3nteAWIVjE4VKaUjMpSOUfHxLAsqZihjLktEGfTfVvTyzHlBNakBCXiVxt50oOK6ETRNInRiLBF/ynJpm5h2jzxPjaQLISiGAkc8LrNHRWDmOPog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKUKam1gibnUuOLPybaNrmZ3ITyeoTIupD+WZRLlkLA=;
 b=aMHr4hpreB5iaG3fWymcUpSdJG8cn67+tjirJmxwtNJEgQReaJBbm6ZBLOxshWeDk2EPQeuhupFjNfcFtrqUnmrppVSnMV7+/n8MJw4WrSqlLamnrIVJbDIPT7SnDzCsHC3gXxtu9j1mw2clI7VwkOXNifWIoopXzjgtwJN0Vk+11+Hx57Kqg0H3tSU7h9nNzJqlqEnFPM5bvDv1oXbwVe2Tly1j2qP+J3KMt9eN854OIdQmMVMYufAD4bfSX/ojQRT5N6frvRlYyqU9mRlwkyD8GW+MvdGcZClumKm2GYkYQo5mnZzl1Y7pC4I8AHbziQI114N6nLsYMnwOdZM6cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKUKam1gibnUuOLPybaNrmZ3ITyeoTIupD+WZRLlkLA=;
 b=ZBHJj7LzATGwFbzRdAuD5sBhO4lBWuTM15oqyido4yeU+jIkUWMglcEqDsGnIiKtK9V05vb7UvRqnWulVvJK8UfRS+Zwz7JwZm+2SDzbD5WCeLmmEA2j1g+lFscRSeCoy4Ga53OYz97tX2FcUxlFYecA6AqxxziE6IniQ9fCCTQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1663.namprd12.prod.outlook.com (2603:10b6:301:e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Wed, 13 Jan
 2021 05:31:58 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 05:31:58 +0000
Date: Wed, 13 Jan 2021 13:31:48 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>
Subject: Re: [PATCH] drm/amd/pm: add the workload map for vangogh
Message-ID: <20210113053148.GE135176@hr-amd>
References: <20210113050230.12252-1-Xiaojian.Du@amd.com>
Content-Disposition: inline
In-Reply-To: <20210113050230.12252-1-Xiaojian.Du@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0208.apcprd02.prod.outlook.com
 (2603:1096:201:20::20) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (180.167.199.189) by
 HK2PR02CA0208.apcprd02.prod.outlook.com (2603:1096:201:20::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.10 via Frontend Transport; Wed, 13 Jan 2021 05:31:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 771c0c5e-ad61-4bbd-4edc-08d8b7848bc4
X-MS-TrafficTypeDiagnostic: MWHPR12MB1663:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1663425EC62F271BFC0B234FECA90@MWHPR12MB1663.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: irREbF1YcmEtrxF2Rxp1VG8moRaZunagz5brfDAUdyvaHKC7esnQ1acggaYj3zpzEE37Onl3bvh4k5VN8mIzAq+31tyF3bMh4u7rR5xQ50tJY/1sqqsk25ss4jsM3cp5tU//418zFouO/5s36X2WsnzAVgprapMHyJZMBJQJl0KyTaVekl6sUW3MnboAddSS7d012Ck8dK83xAYqt1sPlKwGaa8J7kQ7HMTwIvWXG5dduAs1oJnF+cKTSuoqYl4QWT9SBoWPPrNND/OywnM/RjRYfeA8GADjEZkKPVuG/DQsXTWhk4bhtwc62ROszoKk20MW8vefv85r+CmZo/xrKRThNDPRiyc2wad8kSB5mwqt0inyWDkBJnwTNFS3S039bTir8U/h0VQ4H6N0QPRD8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(39860400002)(396003)(376002)(316002)(4326008)(1076003)(5660300002)(6636002)(86362001)(54906003)(16526019)(6496006)(2906002)(55016002)(66946007)(6666004)(33716001)(52116002)(186003)(83380400001)(33656002)(8936002)(4744005)(8676002)(956004)(6862004)(66476007)(26005)(66556008)(478600001)(9686003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fo6Hihrf/jTK6UqrKNP0jJxVcCUIZFra1OQl9gkNqA9GKrXpe+nHCcJlWb1/?=
 =?us-ascii?Q?hvA5nOprEiX8F84aaNDIUZ+fSHi4KU0kI18zwEYD+PWJvd9JxJqpBlN5BX+Q?=
 =?us-ascii?Q?pYpGNWBy9nFTRq7BAZBTHIzpfjvqypJPhoFg+vDbWINmPFEq7f2/qPHbPxmk?=
 =?us-ascii?Q?d9dXOHVTUl71q7pv8qBfmjBfEnWCbd39fD10DT98T3EAUs3LOwQQ+soKlCe7?=
 =?us-ascii?Q?ECAoIuEsCPJdRAW0bygf7XQcCbqprC6qK/X/bo2Pa683jp6Zjzoyp5aQjapa?=
 =?us-ascii?Q?DbIMl0hhWEinosFJ7sYKcNXn4a4A+6K7bZf7HeK4lkDf9vGjalLBQ/7pmak3?=
 =?us-ascii?Q?osODYnxNKu8PFOFxNcXhw+CzS9jS7lFUoNZYpfrPwMIGcKbuTUmlYnDh1GgG?=
 =?us-ascii?Q?+Ds/tm9fhThygnWOj+aX4e+zkOPjQtnTwKwEvlM0ewrunP67MXBIltEiFw10?=
 =?us-ascii?Q?Zjl4edpjLDHrYFK7sLRn3J3/dsY8yHUMcV9bztpovIC52BER93cHOaQn52DF?=
 =?us-ascii?Q?OBULjm7dLjdmNndmmo2+BzSLhM2OZdsi0GLx84FA3M4KCHciyJ0IFU+5FGzt?=
 =?us-ascii?Q?U0KW6UEYt66O9rJ+FTyUgtD6pzuODr+uDNDrR2waMLOn/ihp4/9Yi2GshtZm?=
 =?us-ascii?Q?2Ocm0H/aKi7gMns9twj/JYTsMpRyfDJirwmP68qhU4ByXtwdN5flwHIXI6+L?=
 =?us-ascii?Q?b8AoYaN6eh4WUt8J+PTP647G7brxhvAys7lFU6AhYEPiA4+I3ad5BSFnFdWF?=
 =?us-ascii?Q?T5ZOErvsPVt+FCrpnmsu9giBHEzfa3RFLBL+yH4wqwCB/qRqiOPsTrIlGjkX?=
 =?us-ascii?Q?1l6Uys1i5QSmM2aBaWAWjf33vFIbHoBz0AH/r4i08g/mRA3LtlW2PS0YpNN1?=
 =?us-ascii?Q?SZBTzhL4Jr9nzZ4zNQUJaccvAkfVYsmi7hpc9fdV7vSTGdhp245xKt/7wIDB?=
 =?us-ascii?Q?lila1q8LPAGk+g7Zke4bbzEP+o3ragvaIQb0bSN0MujxqTneikLFU/WKsjnO?=
 =?us-ascii?Q?tUMN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2021 05:31:58.0399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 771c0c5e-ad61-4bbd-4edc-08d8b7848bc4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sak0rYkMikDpbvcPMYolt0VkytbXqcgWKu22KxlGEcMlLkZIzQl0Gw5wXAylWQIUv6b7MqZaiHNl0yXnTAl6RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1663
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 13, 2021 at 01:02:30PM +0800, Du, Xiaojian wrote:
> From: Xiaojian Du <xiaojian.du@amd.com>
> 
> From: Xiaojian Du <Xiaojian.Du@amd.com>
> 
> This patch is to add the workload map for vangogh.
> 
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 8737562f990f..7f78a9378f07 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -1653,5 +1653,6 @@ void vangogh_set_ppt_funcs(struct smu_context *smu)
>  	smu->message_map = vangogh_message_map;
>  	smu->feature_map = vangogh_feature_mask_map;
>  	smu->table_map = vangogh_table_map;
> +	smu->workload_map = vangogh_workload_map;
>  	smu->is_apu = true;
>  }
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

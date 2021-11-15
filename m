Return-Path: <SRS0=ctnh=QC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FB2C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 16:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66A1161175
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Nov 2021 16:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 66A1161175
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F289A6E141;
	Mon, 15 Nov 2021 16:22:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF726E140
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Nov 2021 16:22:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkSErJ/2gCaqHcnABEkcEu1Iyos2r50ZFNvVRW4n3HeoJGV719ohWK1Ha4q/S7Bb9bo0QhgBnMiEWd6cUG3C+cLegHJq0Q5pmzKpg1Oe8WLax4io/PsVQQk0rODX/REKSOkqnVZulJPZXQtOFhBPgUwI1oU07Med0nGxQlR/IkfLjPpg8WczoYSSGMJEtmZOTlwazq+Tjfu9r+J2dhQJzAHaLdcpN2pphc5ROXH5L1IfPKJybFOqhe+MB7DEGfUFuZWBTSPDlvfpYKsFjCcjeIMT8NCAyY1mtprKWdbisk/uLPgrp71BcLDU8TXGGIumPOCb25SwdgHpf+bQduj6PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAyqAZEGAQzDX0ZBNwMRklV7UhLhfncxx1zxAh2+94o=;
 b=kxyXuBpj7L+aGwoWsktRF81IHbOVwywbejDjoLwzGAX6WfU57OCB0CeOOg+4ARW+rSig8OCZyRXLSmU/6r+vJA71MTUgDR/Hr/AAsH2stdEzWS+Mnc4MbY6TgDjTj29yJuHo6tQpo31X3pDwsx8gXURcjjOKQGWkXpXuHFyXoZzx4tf4CQqCvGWQnUo1E5g32zLlQD6OEBy0weyPRH6f2xhVlgOPrZ4hupY3gIpS23wAnauvXJgyYemXhoorx7xJNfYShagbFc7yWngHq4qXeVB0+WxR6jxugEcRLkseIjZHJ/GfOKJWdx1GNCr4yCUmLW+s/x1PE4ru2v2+t+1mrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAyqAZEGAQzDX0ZBNwMRklV7UhLhfncxx1zxAh2+94o=;
 b=gphNCtJA0yR8iXpHj4kjBq4FGaPQ90dU26XuGlC1HGIgwrzTCS9T7ruTj7Yr3PzDkPlrlTugpeCH2QhSNiqMQrRevq5gT3tJBy84z8l0HZqraxTBonK2dpTRXnC47jdsqLpU/2+UAIldbEWpvFdVTglKaup/r6BE23axa6ykCh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by BL1PR12MB5208.namprd12.prod.outlook.com (2603:10b6:208:311::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Mon, 15 Nov
 2021 16:22:17 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::b077:a0b3:ec59:19f3%3]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 16:22:17 +0000
Subject: Re: [PATCH] drm/amd/amdkfd: Fix kernel panic when reset failed and
 been triggered again
To: shaoyunl <shaoyun.liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211115162021.23856-1-shaoyun.liu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <660f6707-489a-6cdd-0a65-7cc259e64af8@amd.com>
Date: Mon, 15 Nov 2021 11:22:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211115162021.23856-1-shaoyun.liu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::29) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT3PR01CA0134.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:83::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.27 via Frontend Transport; Mon, 15 Nov 2021 16:22:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c1bd6b8-4d96-4271-1b7f-08d9a854177d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5208:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5208EFE473959853C9AF997B92989@BL1PR12MB5208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /sbZRtSN4/72iaHmK1GY1AB+2exTaXqCJaGidQ3129YnLedKA1gnKRIFxO8RXSfD8zETV7Lt+yBiA4Tc7ReV8V3+ykhr6n5au3uxX3PfYN4f6RwQ6zww2UtyH83CYJBvkIQsrL9UeNnlpFiu7ko2l/9LRTscgow6WCocHXvex2T/Jso2oYe3TIr7tmJJAIWiONv0mrBz/+hOBkV0z+/q7vA4dWOCGoPGix+6FsCzUM7MUP/Y7iaGpHgM1cQSzPKfkQbSwyNFIzyaj/u1ddbT1ylKJ5ueYRw1t1ncvt5xGkH//bhDOEIVg2z/4s6FbBDfcKOB/9c8XtoTaPnFE6GmFrCeae41Krtyi1owlD8fnJ6Jl6aOdrUpEuPKHQL0K35484X5AfLgnaCL52aQW+syfgLT+M7FBdDjDHBODT6aB0DMlOBQiEiULl456CS62sz7ztVDFOi4awhmGslTcIlZoHU+Q0qwdinochYFyWFfGdMyH9gOWRm/MIYmOwwxjeEn/I7euiXai4Ydw4uoVQlipGCKw+yLK3EcJvofUyGLco8SsjwN0ySllnDWARDnMUQg1O69XNHTxpLLFJxV+lhIPWaVxYdJGw7ueOwGx3t+4OrJasX3cP1y/2Ym46mV37isBD2m5mt2LWHReVd3PFJHuJRQp3PFOasvFZc62WWo1hExTPrHfK91xdmNpDQSuw/n+cAyB4gcCIKcISYPXRBuJb/B+t30sTLumyEaQE8xAohWdgDmdwKKVk9WMdO7u85B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(38100700002)(956004)(6486002)(44832011)(186003)(66556008)(36756003)(66946007)(8936002)(86362001)(26005)(2906002)(83380400001)(508600001)(2616005)(16576012)(31696002)(8676002)(31686004)(4001150100001)(66476007)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzJzQ25WZmd5OFVWZ1dOYVhRc2pEa1pLVVFVTVVidjlZZWpDUUV4dXJ4WEln?=
 =?utf-8?B?Y0VXZHE0dVRqcjQ2cGlFSmFpRGNKNmRDWFZpOUVybGF6YUtBNHpndFhVamRl?=
 =?utf-8?B?WmFFekp1UU1OYUZNcG5RS0Q4M0FpcnVuQWd6VjduOEpxSWF3TE1NNms1WWpU?=
 =?utf-8?B?d2dIa0dPRTNZZFlCRUgzekxDTDlVOWt5VnBIOVJkb25GdmtBQWN6cms0ejZC?=
 =?utf-8?B?MTAxQmx2eTR0c3JHcEdVTFFINW0zalBUQU5MN0YwNDl1cTV0THRvZU1MdEFK?=
 =?utf-8?B?dHAyMThxS2MvMndCd2w1NEFlbk5RTmFjaHU3SVhrK0dkWjRpQ2VIMENLdUZm?=
 =?utf-8?B?NjZGdHdrdlo0YmNpdXpYWUdSLzU2RW9SUjVBbkc4V3hPQktKQUpXUmNLQlZM?=
 =?utf-8?B?MjBBOWRiODl5S0tUU2R2alNMVXZpeUJBcndNbnFvVm5KSWUwalRWSGpKalcz?=
 =?utf-8?B?Yll2WFZzaXdGcXVzUlVtdWtlenBYa1lOZ3pNTTc2L09tV3RVZG5iaTV6VXND?=
 =?utf-8?B?cjJGcCtOVU9JODZGTEpta21lcDlROExYblRHYWZRTmJkNmdZbCtpRXpEcHN0?=
 =?utf-8?B?ZWt1Q0hENnE1dktTbVIyRzBwVWVKUi9UVXF5SStmUHNBQ001YmtTVTVSUmEx?=
 =?utf-8?B?T29PYzY2NTBnRUJEcXNFbERzM01PQkpVWHRGcEdKYURGVGpYS1gyVHA2ajlO?=
 =?utf-8?B?VzM3YUQ2ZGVBSzFoQjVydnR3T2RHeXlORzVjclRuUEZiYldxSXhkb1BZUzBq?=
 =?utf-8?B?RDdERXRtQ24vc3BEZSthb0s5R0FlUjlpUmJBR1l4Nk5McEZFWmkwUGhsT3dR?=
 =?utf-8?B?elVna3pwekRhbnNCd1FaeU1yZEQxdlhYSXFVL2Y2eHAwVzBtM1R6Qmh3dnd4?=
 =?utf-8?B?Z1pxcC9HZ3NuajNLUmVDcTEyb0cvNHlSb0dFOVFXc0JoY3dNTVJESDhXT2t4?=
 =?utf-8?B?NmVQWmR2cTJYK1hrWlZaLy93Q1lHekRnRzVwVGdTcmpRaDQyWURIN1VpUUFh?=
 =?utf-8?B?SnM5Ri85aTRWbWFuc3VSZnQ3U1hLUmJ2cEQ5VEJ6VnNFTWh2THJsY3F6c2di?=
 =?utf-8?B?dzlzVzByRUR6anJuaVhnc0pKbHI2aWNBemY0b21MSGV4cG1JM01aMmhoWTNq?=
 =?utf-8?B?aXBFNHVOdGtDZlpnaGIwS3l0NmMvUjRoWkRvNEh3blVaaUM3MEszQ242R1cx?=
 =?utf-8?B?TnZUK0Y1NzRxV3k4U1psK2pBMHZUVHVIQWJWcE5OUWZhSFB6cUZ0TzQ3U2Mx?=
 =?utf-8?B?TzlDU01SUTJUUUh3bk1VM3hVNHk4eFdHYUpOZmZUWmczcVdrbUd2R0dhUEpR?=
 =?utf-8?B?R3g2YkJkRy9oTk1heWQzRTF6alZ0d2FFZ0dSckpVWE9EUTBHbWkyTndtVDUw?=
 =?utf-8?B?RHJLU3ZsbVE1NkJkMDRTMlROdnF4WHZQSDIzR3NrbTlIQnJKUkJ4Tyt5aE0w?=
 =?utf-8?B?YjVva2dJRWlTQVgrNjk4R1VZTG1Ca0lQZEZjWkRNZWhqMHloSVJOZTNFTVNa?=
 =?utf-8?B?MHVQQlpneUlYQ0owbXh0eHM2S01QYXY0dUpOM1ZuZUk4MHphcEt1Mm5Rd3FD?=
 =?utf-8?B?T0k4cm9HY3lNNVJzWi9DQVZYWHZuMTJVbTdvbzVqaTZlL1ZWUDQyOGx4cVVj?=
 =?utf-8?B?TGFKVjVkOGpFdFowVTh0MFA0U2ZhTzVROWVSUTFMblB0QmVJUEVFSjNRRTlV?=
 =?utf-8?B?OHpJV2FHeWFPdmNRL2tKZUFhSjlZTFhyR3RWVndvSndER1lIZE5paTFQL3h6?=
 =?utf-8?B?cWlZQVVlMFFHME5OeVZSSjd3VVNvTmF4Rmo2Qlo5QlZMN2pkdkptR0VBUExr?=
 =?utf-8?B?T3pTaDFhbzdYcVhtOU9JRVZnSjcySlVoRm41ckJ2N3kxeE1QV3h2eThYYjUy?=
 =?utf-8?B?RTJHOHQxUVhuYmFWM1Zqdjlza05PaG9Hdmk1L1VRQnl0eDlYRVVjOFQ5RWdj?=
 =?utf-8?B?SGU2OWU2c0ExKzRudElPUzNRVEhqcEQxdktGR2VZSk80cmNyM0MvNFNseU5s?=
 =?utf-8?B?TmNYOTVTcUJ1RGxQOU1qVExFWWh4M0UySTYxQ1RzZzZHM3FpWWtvcnJBcDNG?=
 =?utf-8?B?R053Q0dyZG92S00yV21NV1h0QUdvUlZkcnkwUmVWY3FjMWR0Q2dOazUrQk5F?=
 =?utf-8?B?Ylg4ZC9wWTlyZlNyVnpaeGc5aVZMTFlaQ2l2anhBb29JcW9RUEhuOWRpSFN1?=
 =?utf-8?Q?0OV2eQjlNl1PMPeq90ECYxs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1bd6b8-4d96-4271-1b7f-08d9a854177d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 16:22:17.5346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDrS8/gLAWOIwkepQAnIVr9CRKdI8tI0iTJAvsc4uFa5oBjbNL+UE1Xg9pkx8MDa9cuQAPjevftumoAZMw8z6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5208
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

Am 2021-11-15 um 11:20 a.m. schrieb shaoyunl:
> In SRIOV configuration, the reset may failed to bring asic back to normal but stop cpsch
> already been called, the start_cpsch will not be called since there is no resume in this
> case.  When reset been triggered again, driver should avoid to do uninitialization again.
>
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 42b2cc999434..62fe28244a80 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1225,6 +1225,11 @@ static int stop_cpsch(struct device_queue_manager *dqm)
>  	bool hanging;
>  
>  	dqm_lock(dqm);
> +	if (!dqm->sched_running) {
> +		dqm_unlock(dqm);
> +		return 0;
> +	}
> +
>  	if (!dqm->is_hws_hang)
>  		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
>  	hanging = dqm->is_hws_hang || dqm->is_resetting;

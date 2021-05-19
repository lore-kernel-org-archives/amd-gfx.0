Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AF9C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 05:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33507611BF
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 05:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33507611BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1E6F6E14C;
	Wed, 19 May 2021 05:36:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 939516E14C
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 05:36:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEpGzRRQ3Ekkt/1q0q0qQze8Y3G774oeqw5D6eJ28HG3q1FmC/zZcjOOz8kysFi2Ix8q5fSUkbx0kvw2YqGHPAa5+7KlsW7ZLqQG7GkLzn3F3+w22p+XmMBvmhXpsBlD5XfaamUpw6LtWgSkQi9EUH92T/kHPL0Thoas7e/qcjjGvL6OL68sF85nnwCB9WdZ69mJcN27UG/HIE+UK6IJ9riuYHfXwjW3JoMDIJ4gPO5MP39ECkGs88wZlHBTvAt1ufYIHEkrOMd4wOaUcY3b4PHmuVwXDhYzNwcmx0CPP1vrmkG8pH02DaPe/qyuTAaq3WD+dUZslfgb+5LQLcIqqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJE6l/8UGlsgSaBsPcU+kwupP2xbFgQY11IibbwaniI=;
 b=oakAxYFhKS2D0m4jJqIuad3ThL6vc4Guokc9D7vD7PV0Fzny0f2wI4MvwwizWBBnU+neYXmFAy2ggJFafOH49u5vlRPZTqQcdpAJ17K5L8arxTtpWLsuuxddUXRb2xvM+PJHli9rjwxd8luOpzJ94cOPtDePYO595feWqJCQ2g6+H2gq64vzJlHhsqQDCZ0XcloC4BYGxloC3UJE1YsQzSZGEMNK4WAQVVQOhzgCt6xFfbnr+sSMInumlHSd6yd4xx8amgIcxw6V3rbbucuZDXWHAM/mlCDhfUK6gknm0igN3jBBpTd58Z8Jtl8b2MpUBnForjH8fpDARYGOqhzObA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJE6l/8UGlsgSaBsPcU+kwupP2xbFgQY11IibbwaniI=;
 b=eQxo3rAGXB6mcBZYtwfK+fjrv9V3n8pyFqRr6+rPIH1tourEyAxTkiVFeHKHRQLwKgEdszbD93Gwpbctp2uoV2Xe8GeJ5uttV0cYkrC/gTF13V/tPP8TlpzCp9hVN0Tweb/UM+m7BmwcysnpmRzL6xerzUS6jJMAIgiW8772zwA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5107.namprd12.prod.outlook.com (2603:10b6:610:be::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 05:36:36 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 05:36:36 +0000
Subject: Re: [PATCH 2/3] drm/amdgpu/pm: add new fields for Navi1x
To: David M Nieto <david.nieto@amd.com>, amd-gfx@lists.freedesktop.org
References: <CH0PR12MB534810EC2A9AB95FBF09E06B972D9@CH0PR12MB5348.namprd12.prod.outlook.com>
 <20210518040957.23266-1-david.nieto@amd.com>
 <20210518040957.23266-2-david.nieto@amd.com>
From: Lijo Lazar <lijo.lazar@amd.com>
Message-ID: <b03e3953-9a83-36b7-a7a3-3a2afa19c41a@amd.com>
Date: Wed, 19 May 2021 11:05:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210518040957.23266-2-david.nieto@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.158.249]
X-ClientProxiedBy: MA1PR0101CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::24) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.156.106] (165.204.158.249) by
 MA1PR0101CA0014.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend
 Transport; Wed, 19 May 2021 05:36:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46e20904-10d7-4bbe-f34e-08d91a881190
X-MS-TrafficTypeDiagnostic: CH0PR12MB5107:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB51075294375AD422EAA23F87972B9@CH0PR12MB5107.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+MlB/UIUoTFuRoYJ55RQ8SE3kekFu/dNvCFHxvpJCI1HjaFsJp2JnU3MwdRX3CsEN/v+v9LUZxOsEC1RveffLGNWas/GV0RIrP7PAKikIsM6IIPV5JpBXn+TRWb5fDGWAz86/mu8XYBLTRnFGrXW6B6YzJsUcZEPMfGBJTnadRRjH2E/thXLuOPavNMf2H1ptu3u7mqQFc4HjOCaqKndjXReNTPIWHrDwdaSwGVcaZnmrcKEYi+v7rNEa45Yy/W9Nnq64634/N1av0xoCLG+LdB3+O2wj66HRFXfqiN0qzh3T0kki2xaZezpltE2VX9A5eJKe8aFSezqE0xe5F56mxPwFIaDyCgneW4Btw4GuIliugZJHz5fgfPu2Y0JtM4kyGyeTR+zcFj72wESajFpfjFDiqCcby8lYeC+igrNW7KufO2C9I/Pu3wds/QOgCWxdXQfvqIjK0SEa8AjzsFqUUrgk7z3I4JEZYpMYGRJTRPvSEI+Ap3CdGTe0jBC/TBQVSv64nwzsaIF1hMCADELp3HO3VUndw0RwHa8HRmojJ6vNGwy2eGLHxjeLD5XSSSJl1G4dzJu6u42v2J6lRnrXiH9irNLvBFgvbOKOghXZT6k0lNSs6hFjGOlAOpBodBB2RLEpPnoFcJ7MFagEkByVxBM62j7oqXIsf/bTxO5/OMQnozdeYR1MWq7le5/WGBWZbuvJSvDJ5NnmrHm1jTtHhSc90MJKGlxRf0lMY6JY0Mkl3LK5EY/u8JVN+MIEne
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(6666004)(26005)(53546011)(86362001)(31696002)(66946007)(5660300002)(52116002)(8936002)(16576012)(186003)(19627235002)(83380400001)(316002)(36756003)(478600001)(31686004)(16526019)(8676002)(956004)(2616005)(38350700002)(38100700002)(66556008)(2906002)(6486002)(44832011)(66476007)(32563001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eldDeEZRdVhXMXBnTlE1SVpsVzBhOFRZZTUrRkFZbkIwRFJhMnV1V3pXeFVy?=
 =?utf-8?B?SVdaajJlNkNGUXdqUHlLWndlVFFKbkkvSkh1Vk5jcGtzekNmTmx6MGU4MGFw?=
 =?utf-8?B?czVnZDJJSEQyN2NTaUNqUUZ6M0ljQWtxMWkvK2pGcjJiNGpxRHpsMWkxMGlB?=
 =?utf-8?B?aHBWckpPY1I5YkhGNmhtRGxwY25LUEVXNTRRYkxBSnJSU1BWQ2llcGhoWDc0?=
 =?utf-8?B?bWN4NnNlTU5LM3JQQXBNQTA1STdDVE9UOHZvMmJPQSs3NjFZRWJ3Q2dwMG5o?=
 =?utf-8?B?TU5ZRFpLUUNtSEhybmJNOGkreU16akp0RTEwMlF4L2ZlREQ3OW5QT2ZUMHZy?=
 =?utf-8?B?ZFBmMnQybGlNN1pPZFljTjZPWWQra0w1RUZVSWpJVGtzUlE4L0QxcG8zRXlx?=
 =?utf-8?B?cGMzT3JzQ2pDb3NHRFhpTytyUkdTNTJ4RklsRi9pdDY2K08xOHhkdGFrQ3FD?=
 =?utf-8?B?NnhiclA5TnJSa01nVFN1cy9NMFJSQkdkcnVNRk05eUVhVHFWYlNSVFRFSGk0?=
 =?utf-8?B?eDhDNVV6d1E2RXp1N2RqeFdxOEhCbG9iK2VHb1JXWjN1QVBYclE5UlVoL3U2?=
 =?utf-8?B?b3FuV3JtazN3WVVJeXJTVXFGOU5IcHRpYWo2dUhXZHU0NDJ4ckErL1lIemVu?=
 =?utf-8?B?SzBUcldXS3AreldlT2JDTGpzWHJlVVBrMTA5NTFPcUxYeGJLYnUwRkd3dWU1?=
 =?utf-8?B?UndZcVpWekxFR0l1U0EyM21nSE15TTY3WmtvOHcvZy9PMncwMUxERVFpbHFR?=
 =?utf-8?B?VFZueGdod3JqYTFCb3ExKzYxS3hBOW9XTkpNQnMxalNmeGcrNUNtNW1PZ1dY?=
 =?utf-8?B?MnlFdXJCdTY1MVZRMFh1TWlEMlBGQ2hVSXJhL2VVbEQ5R3c1MFVSOGZzL0U5?=
 =?utf-8?B?QlUwVitteU5zbVBpVFNQMHJadG52K2s0VzdUcmp2bDZuT1FWVHUvM0g5RndI?=
 =?utf-8?B?S2JLaTByUDNiN0YvZ2tDUHRJR2t5WWVCV2RSRGdyM2FSb1FWSEQ0K3ZablZn?=
 =?utf-8?B?U2t3dTJTSlNIL1RlTmxuU1hsRm9SVzZhY2swRHlvODl1Wi9LYkxROU5iS3B0?=
 =?utf-8?B?TmhzaUVNVFNVazZnSXJpSWJwTytqR01rR3VBNko0RForSVE1Q2pSNkpNU09R?=
 =?utf-8?B?YTBnbTdvMXNlSHMzeTVjeGQvQ2F6RHNHQkFrTGx2T3JBN2pMZUdtSFJXZjhx?=
 =?utf-8?B?WjNUTUdyRFF4VXJqNmtMTGo3bFZRSVlxYUlNTmF0MVZ1S0VvTEpVOXkybjJT?=
 =?utf-8?B?ZHU5d1A1b1RDaXZ4TElBZUp5RkpRNzBuajZkaWxuWFJCUmlGVnlJUE5PQktL?=
 =?utf-8?B?WXFBeVFSUDhRd0Fjb1pXY21DU2pmb0RUSEM1N0NuSFQ4WmJXeXlvMjdvbUdw?=
 =?utf-8?B?ZGhGanloUUtXWmcrVkpDRTdwbTNJTXFNWWJPN2pUdWRqLzB5cXN6YkNSdnlF?=
 =?utf-8?B?SlVkL29tYmNqYzhVUis2STd4QzNpZWZHcTljeHVnWHhFZnpROFNxc205alFs?=
 =?utf-8?B?QktDMWs4TDVNKzBmU2xWL2w2RFZCQzREYUxlQmxjVVFPQXplRUw4Yk5ROHVO?=
 =?utf-8?B?NkpWbUJ2WnRZamw2U0NVeGI0Zi9qTGo1Rk1LdURPMGhaZU1yZzhHa0hWT3Zn?=
 =?utf-8?B?K2JqYStzbitLeU5jSnNwaEpEeDZxMmpaUmowWGd0dVU1RStscjY1d1VRRzYy?=
 =?utf-8?B?TURrMzFZZm9mYW8vN3Y1VzZWTnRhT0xkSjNVcjJtN3lxaHlKQkpxbWt2UG10?=
 =?utf-8?Q?yKBYp+za1ZEp4zvdRThbq5Q2VLzNTVMxuW+GdHB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e20904-10d7-4bbe-f34e-08d91a881190
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 05:36:36.4084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2w/zH0W+kxKV8nqZZsZMoQQ94xnbo16hANcboTI0WcPAmj9V8+HBBYz0PaE8oyl9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5107
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 5/18/2021 9:39 AM, David M Nieto wrote:
> Fill voltage fields in metrics table
> 
> Signed-off-by: David M Nieto <david.nieto@amd.com>
> ---
>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 62 ++++++++++++++-----
>   1 file changed, 45 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index ac13042672ea..9339fd24ae8c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -505,7 +505,7 @@ static int navi10_tables_init(struct smu_context *smu)
>   		goto err0_out;
>   	smu_table->metrics_time = 0;
>   
> -	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
> +	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_3);
>   	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
>   	if (!smu_table->gpu_metrics_table)
>   		goto err1_out;
> @@ -2627,10 +2627,11 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
>   					     void **table)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> -	struct gpu_metrics_v1_1 *gpu_metrics =
> -		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
> +	struct gpu_metrics_v1_3 *gpu_metrics =
> +		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
>   	SmuMetrics_legacy_t metrics;
>   	int ret = 0;
> +	int freq = 0, dpm = 0;

Variables added, seems unused in new code.

>   	mutex_lock(&smu->metrics_lock);
>   
> @@ -2646,7 +2647,7 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
>   
>   	mutex_unlock(&smu->metrics_lock);
>   
> -	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
> +	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>   
>   	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
>   	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
> @@ -2681,19 +2682,26 @@ static ssize_t navi10_get_legacy_gpu_metrics(struct smu_context *smu,
>   
>   	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>   
> +	gpu_metrics->voltage_gfx = (155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
> +	gpu_metrics->voltage_mem = (155000 - 625 * metrics.CurrMemVidOffset) / 100;
> +	gpu_metrics->voltage_soc = (155000 - 625 * metrics.CurrSocVoltageOffset) / 100;
> +

It's better to add a non-zero check for offset values. Having 0 as 
offset value is unlikely, otherwise it could show the wrong voltage if 
FW is not passing the data.

Same comments for below functions also.

Thanks,
Lijo

>   	*table = (void *)gpu_metrics;
>   
> -	return sizeof(struct gpu_metrics_v1_1);
> +	return sizeof(struct gpu_metrics_v1_3);
> +out:
> +	return ret;
>   }
>   
>   static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
>   				      void **table)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> -	struct gpu_metrics_v1_1 *gpu_metrics =
> -		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
> +	struct gpu_metrics_v1_3 *gpu_metrics =
> +		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
>   	SmuMetrics_t metrics;
>   	int ret = 0;
> +	int freq = 0, dpm = 0;
>   
>   	mutex_lock(&smu->metrics_lock);
>   
> @@ -2709,7 +2717,7 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
>   
>   	mutex_unlock(&smu->metrics_lock);
>   
> -	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
> +	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>   
>   	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
>   	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
> @@ -2746,19 +2754,26 @@ static ssize_t navi10_get_gpu_metrics(struct smu_context *smu,
>   
>   	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>   
> +	gpu_metrics->voltage_gfx = (155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
> +	gpu_metrics->voltage_mem = (155000 - 625 * metrics.CurrMemVidOffset) / 100;
> +	gpu_metrics->voltage_soc = (155000 - 625 * metrics.CurrSocVoltageOffset) / 100;
> +
>   	*table = (void *)gpu_metrics;
>   
> -	return sizeof(struct gpu_metrics_v1_1);
> +	return sizeof(struct gpu_metrics_v1_3);
> +out:
> +	return ret;
>   }
>   
>   static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
>   					     void **table)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> -	struct gpu_metrics_v1_1 *gpu_metrics =
> -		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
> +	struct gpu_metrics_v1_3 *gpu_metrics =
> +		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
>   	SmuMetrics_NV12_legacy_t metrics;
>   	int ret = 0;
> +	int freq = 0, dpm = 0;
>   
>   	mutex_lock(&smu->metrics_lock);
>   
> @@ -2774,7 +2789,7 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
>   
>   	mutex_unlock(&smu->metrics_lock);
>   
> -	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
> +	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>   
>   	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
>   	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
> @@ -2814,19 +2829,26 @@ static ssize_t navi12_get_legacy_gpu_metrics(struct smu_context *smu,
>   
>   	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>   
> +	gpu_metrics->voltage_gfx = (155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
> +	gpu_metrics->voltage_mem = (155000 - 625 * metrics.CurrMemVidOffset) / 100;
> +	gpu_metrics->voltage_soc = (155000 - 625 * metrics.CurrSocVoltageOffset) / 100;
> +
>   	*table = (void *)gpu_metrics;
>   
> -	return sizeof(struct gpu_metrics_v1_1);
> +	return sizeof(struct gpu_metrics_v1_3);
> +out:
> +	return ret;
>   }
>   
>   static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
>   				      void **table)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> -	struct gpu_metrics_v1_1 *gpu_metrics =
> -		(struct gpu_metrics_v1_1 *)smu_table->gpu_metrics_table;
> +	struct gpu_metrics_v1_3 *gpu_metrics =
> +		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
>   	SmuMetrics_NV12_t metrics;
>   	int ret = 0;
> +	int freq = 0, dpm = 0;
>   
>   	mutex_lock(&smu->metrics_lock);
>   
> @@ -2842,7 +2864,7 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
>   
>   	mutex_unlock(&smu->metrics_lock);
>   
> -	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 1);
> +	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
>   
>   	gpu_metrics->temperature_edge = metrics.TemperatureEdge;
>   	gpu_metrics->temperature_hotspot = metrics.TemperatureHotspot;
> @@ -2884,9 +2906,15 @@ static ssize_t navi12_get_gpu_metrics(struct smu_context *smu,
>   
>   	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>   
> +	gpu_metrics->voltage_gfx = (155000 - 625 * metrics.CurrGfxVoltageOffset) / 100;
> +	gpu_metrics->voltage_mem = (155000 - 625 * metrics.CurrMemVidOffset) / 100;
> +	gpu_metrics->voltage_soc = (155000 - 625 * metrics.CurrSocVoltageOffset) / 100;
> +
>   	*table = (void *)gpu_metrics;
>   
> -	return sizeof(struct gpu_metrics_v1_1);
> +	return sizeof(struct gpu_metrics_v1_3);
> +out:
> +	return ret;
>   }
>   
>   static ssize_t navi1x_get_gpu_metrics(struct smu_context *smu,
> 

-- 
Thanks,
Lijo
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

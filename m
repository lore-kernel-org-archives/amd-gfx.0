Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE49DEB64D7
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 22:02:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21B1910E3E3;
	Tue, 13 Jun 2023 22:02:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 943BD10E3E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 22:02:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALIPu7nFwq0qPcFR6U3WdVprYRGEOjbxgJjNrPdnSE/uf23WT+ctXGlsCks9lDNsxkQOGqMXczXrzvSdozNsEm1hO+inGBAOZC31UWKUof+H2px8YpEze6k5nIkRWfKvoFfB2O3CjkjKn6p3dv0RSLgfy+JIG7Rcjwj1Gwodp37RnDFWH+rUSBBBrv38QQyLKOaL6ifxPmLmxQZppxeac58i/Jb+ZZY3C+gUYhSOn6aQp4vOXgCdCn+1fbHjUBhEfUNuev1xQxIbdel0eDwPHEFL4B41iBAtkbyiOHWvoNC+m7ATIfWsZiOXCtZl2Vf8lv1acPTDtEh77exQ3yBN+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m20AZQmyJAEVML205OGO+QAR29CRPsyFgctRUkqjRJQ=;
 b=Vwy0bRj8kbRAqR+/xqx8YGYxifsS9cBqHj/09yp7S6f9XMiadkOUhRn3ASTZ+IbOmsXGnuqfxfZY/gjD2aM6GufqbOCuQ4MaJtCfDMSp+TELv2atDTgihrRQSgCZpYecYf4NjUQwMZHeDJ5vlnFVsmp7S12ltL860ee7xEXaA105+Fqy0zxXp91BMQQWUQwBrwlVRqbIPpZd0Ti8vb2SjPYhrubLjOBDzlOZWJVuXd9zI366Tiz8RUsojIexoJVjf6CpAvBxbBjh9cBQ/Xq4Wf3tkjn5j5/g3QxQJcSpteSP0yeLSkvBToR5B57FxqsQy6hyP7I/fkXCNH0pJve8KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m20AZQmyJAEVML205OGO+QAR29CRPsyFgctRUkqjRJQ=;
 b=2pZE4JINGFe3ef3YliPRehxWoRovixikxUz1Nz2Jj0LFxKm4KvqPnv/YZtwQqBrzow78NYUjBvZdpVZXYJr0fzU3L/BFybrrpgbgpvoyw4zZNHO2d356hVns3YY9xwUI2JRdRYBD0wbGXRUK1NLvC7iyaDD6q7iyk3ycavYjbF4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 22:02:03 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 22:02:02 +0000
Message-ID: <6c195626-b28d-6252-03d9-4cc77955be8a@amd.com>
Date: Tue, 13 Jun 2023 18:02:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: decrement queue count on mes queue destroy
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230613214837.3452334-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230613214837.3452334-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::43)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bfe395a-1901-4ebd-3292-08db6c59d192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6voYH1cWCfUoolXXc8coCgSmTUwjVANzw4YTWZEOLyvky9+aIssm5Y9AY3eNIKZu13uOXXQbtA6fZnC1zNT5Z0AFd6y9o3Q2zb2NNdIEDb3JEpeWpR8KDdGu3btcnSFb3zkaViHzjnfR3HmIcMHcN83DKMGw63J/aBv9bqi3yTismlJ0yHif+MI2fchQxqcUNL9aHi8MqxFVUqXthtJF7LHWELGKb8bBntQpbjzg8YJY+a+GUN1DKHOUJJqLFQzTkbX9SINM060llDQgf0EX+lBfVKkS29DzR94mcJB1GkO4/dM5XC1cMhw1x0/P83Kr5ayy3zpRXHiyWxYbUkOls/RIR0MOhhwuVVlzIJKCo1p1U+edWAt6WR1lTTnujPtetW3F6DWm/vwWLyXXRFy5oskDqogEaSWNPwQ4l9zv/XjNC+FSSbAO3Ja+SNOoV3KMNN6Hajt1VBx4HI7/aQVS1OilS+n1yKV0BqTDw+wzWTku9d2NFKtT1r+EugnwpplFfKOPKzWqD/Dg01IFt5kpLTUsGd+mttrxnynVVQJJqi6A80vEw2/o3k4gh93UUpo3dmB/zeDk1gtKmUpIILl5JkBwuqvvy/lOPuIqUhYzMTM6rJ4UqyJVmBDD55hqkcXxQlKh/rhc00QqrtfacRckhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199021)(31686004)(4326008)(66946007)(66476007)(66556008)(36756003)(186003)(478600001)(2616005)(2906002)(8676002)(316002)(41300700001)(31696002)(86362001)(36916002)(6486002)(6506007)(53546011)(44832011)(8936002)(5660300002)(26005)(83380400001)(38100700002)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVlMczQyTjF3aldzYVBkV0J2WHVrMWNsVGl1SGRRa0lwNjNpdFpSY1hBdklq?=
 =?utf-8?B?SXZwMDNRSjl2bGt1UkZFcDdmWE5pZG8xbHBIUElQWGxTTjdteXdxUTAweSt1?=
 =?utf-8?B?eUV0eFQvRXpEL2cyZzZkcnFBYVlmZHhranpDdVpadWcvTmExKzU4VThnRUhL?=
 =?utf-8?B?dWt0cTRyaXJZMDA0WlRkNWJSR2JOTyswVncySklTWm4yTWRRQkNEa3ladVdQ?=
 =?utf-8?B?M3BocnJVQ1VRLzYzbXFVYUVqM09YbVJQRUdnYVVsSUlUV2ZLSmx6aE1CaGNJ?=
 =?utf-8?B?ZFdhd2RHaUQ2NXlSaUlieUd3UzZ6M3Avb1NrbXB6N1JYb0psYnlQSThpVWs1?=
 =?utf-8?B?NkhDd2Q2VE1nSXNNaGNWeElMMVJkdk5jSHIxb3I5ZGcrOXkxZ2JBUFdTMHpr?=
 =?utf-8?B?czN6dUJGNGdRSTAyNEh1K0NKRDJvUDE4OVAvMk9ZWGptY2FjY2hKYW1PQkxk?=
 =?utf-8?B?dzMyeUtkYStFeDZKQmlBQk1DUkx5Z2RCbDlWeDFadnFNTkRhK21Qa0tWRFhp?=
 =?utf-8?B?TE11UEV6OFpMNjYrKzcrT1M0UjFsRGtDdTRJbGZPN3BqL1E1TVFiYStZY2Iw?=
 =?utf-8?B?TGxWL1c1Q0xaNE16anF4TmUwZStLVjFLZGU3bSt1ZnJKeUJJdXVsL2Iwb2lx?=
 =?utf-8?B?K2EyUkhCWkwyN2lUYXEvNnJHK2R4SlkwYWpMV21JOVI2ZjBSSGVxRG9LSThs?=
 =?utf-8?B?Y2tyaG1oRUZWeko0Y1I2MEIzclp5Nm93NkdnQkczL1pBUkFBN2E2KzJmWkI2?=
 =?utf-8?B?ZlVyc3JHaGluUGVMemQxSXJMamczaURwQXNwcTg0dVNJZDVxaGxySTJaZDZR?=
 =?utf-8?B?emVoTWtzVVRlZUlxb0EvTlZrM3dYMU1PMURJMmRGNk5yQkR0VWxWT08wVWY1?=
 =?utf-8?B?UVQ3QnRJWDVZRTlpQ1V0emRFODZZbkZhcnZNdFdmRXFpNkxQZ2tDNDhDbm9i?=
 =?utf-8?B?Q1B5dlFsSjBNcWllaWdLaUV4MzhyaU9NWndEUkFPWlY1V2EweXAzSjh3M3hY?=
 =?utf-8?B?NjZqK0VKQ29xenhHM2FYR1dneWdLZ1U4M0MzUnZiemNFcDVpcEd4dFNRZ2xJ?=
 =?utf-8?B?c1MzWXVNdkwrOHM0ZlQ5VjU0UDZXQ2NUU1FkVy92aTU0MlM5aVF0YndTRldD?=
 =?utf-8?B?aGg5cDRzU1BSUUZmQmhPVVZ1N3k0dDZtblBNejdBR0dxSlZRcjRLcCtkMGs3?=
 =?utf-8?B?RVBhVUZVTmQxNHRPaVhUWVVneTBpd0xubDAzeFRCZVFBdXhiSHdyeldaQkJL?=
 =?utf-8?B?N1FtMm90NkdsTG9RTm9SNXF2TzlmejdON1VnZHB4NGxENDVSQzBRei94d3Z5?=
 =?utf-8?B?WlFrZXljOHZ4MWF4U3VUT1UwdllsTjQvOExoK21jQnZjV2pNMENmN05wSDNh?=
 =?utf-8?B?OS91SUlWVEF6L01NeHYrY2V2TXBUR1c4djlVTlNMUHR3MFFING90eE5DTGRI?=
 =?utf-8?B?TG10UkFlS0Y2czY1bXVuSEpwa3dvbTdwNnZuOTBqYXA5YXl3MU03aC9rem1W?=
 =?utf-8?B?Y0hTaG4rbW5LWDdXd0JJdVJxWmV6WDQ1Ym1odTl2WVpJMStiQmt5Q0lWcGls?=
 =?utf-8?B?dTR5K1llenRBaEZtL2JtNDN4d01zSmNCRFY0bUM0K3BnZDJEZ0FRWUxuMnhr?=
 =?utf-8?B?bHNxa3Z2K0pkM0pGRnVPVjNlZjUwUG9Iam9JUWQ1MUt5M2dHc1Q5aEcrN3dQ?=
 =?utf-8?B?TmQvVno5UnQ1NTJqbGJsZEpKYWdGQzNiOGhsRllhcXIvT3N6am81UWo5YlY3?=
 =?utf-8?B?bHlFTUUzNlVDR2J0UitDdXVNQmJpdUhlUjdoc3FuVW1RTkIycU1ldUpTNU9C?=
 =?utf-8?B?R3RGWG1GaGlMQTRoVTEweUhjSkg1eDVpaVBHU29keVBwYmxBUjRvOXhFbVlh?=
 =?utf-8?B?bTUwZmJ2Zi9EVjBldW1kK1BYV0pkWllKeVlJcDY1bWVKYXlXM2hKTUltNmQ5?=
 =?utf-8?B?MEQzOEI1T05zSGM5ZklWSG5KUkVLRmE3dmVqTVlJVm1tTlkwY08zck53ckp1?=
 =?utf-8?B?M2pXamd4TXVyWFd5am9aN0FReC9CS2U0SUIvV0tqRTBzU2dQZVBxajB3N1ZM?=
 =?utf-8?B?d0pGK2Vrd0ppMTUrOWxjUDBOeWtsUU1Mb0NmZkNDaUNhK205Sk4ycWZQcWt4?=
 =?utf-8?Q?j6ixttKqCGVczh5SrbfwxH2pt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bfe395a-1901-4ebd-3292-08db6c59d192
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 22:02:02.8882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XilhEj0rRM2FTfWMxRj3sqfpmGzj7dOQsRTHnk4D0c0M1M2AQzKALmOaglb1Kv81v1EmOlybXiWlkt4j2S3IFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930
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
Cc: Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-06-13 17:48, Jonathan Kim wrote:
> Queue count should decrement on queue destruction regardless of HWS
> support type.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 8a39a9e0ed5a..f515cb8f30ca 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2089,8 +2089,8 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>   	list_del(&q->list);
>   	qpd->queue_count--;
>   	if (q->properties.is_active) {
> +		decrement_queue_count(dqm, qpd, q);
>   		if (!dqm->dev->kfd->shared_resources.enable_mes) {
> -			decrement_queue_count(dqm, qpd, q);
>   			retval = execute_queues_cpsch(dqm,
>   						      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
>   						      USE_DEFAULT_GRACE_PERIOD);

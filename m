Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1627C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 09:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63FE460FC4
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 09:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 63FE460FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4CE26E0FF;
	Wed, 11 Aug 2021 09:45:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E7926E0FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 09:45:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6RXbItIyjdlGW0kbrPjl1TTB7/01ZaVmQ6Z47uUeZo5LS6yrBHKYr+L5QIyV5CRmZ3vRibttlmMHXNTlv30WdDl9ogx0u5ml1CqMXx1aQ1xU9tZIkD253JizOR1HlJRpDxT0SJQE68onocfw0dg23YwtgY1lvmE3I6lKMqPIEIXqXilfRhSO1wWMXQ6LBurmtYjUohMJn4Ec0gD1WiXmjw6NQPR4kYJ1ygxejnDiuf2MBIsTWbZ6rnJRFF6NWaAhi3QhEjaSYjtkZl5YRmZSisuxNIPANPbn5z+LGtDNK4kkrEH04d9ePzuJybXiV5VlVq6Swth8E0ddkGdvIBGXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXSFqp+2uY3MhhCYvz8kGA0wnXcsDyHq3VA2tOCN9ZU=;
 b=mylp7MQKSJtm1LBvmUpCN/FITJaPQN2POXWxfHqQm63Ii2eOaCr/QaLpyrRL/7Tc5FXIlQf4GAFO2ajjkX0zHF40HnxE+gI0+YEKaWsIrEVyzFRomdd6e8hg9jUkYqhWOaShnWD1MGqOOwYCUmx1bww63CR4nwnkJX8A3YUq1b8qsGeKi1Gjhydz7dIApr5D+anoAV/fbRnNoPqgJfuerHULgTWKByTp0IOA84AI4yuFesvXIW0tkJ11croVw5syn6gxlB7mK600LVsx+7TyyvGO9wk8Lr1FlvrYIh+vSXa9ko2FbH8AP6pg757uA7wMoFE+gxaF3o7yvGMtnIqOOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXSFqp+2uY3MhhCYvz8kGA0wnXcsDyHq3VA2tOCN9ZU=;
 b=fs67HIe5hqhdN9zKrtU1EumrLJtmHMCF3Irt6d61tPBA7Pjye2GVOZuGHIiOVpxMLQTSZLZBqEJ1Znhf+v6gs+sAzQXKaHBXIvFzcP/76rEZFdL83NeE+W4l6ZJYKDVp+AFPNs7XCo7c7RRzDm1cETM1PI/3WSO7whvLq5PBGXc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5207.namprd12.prod.outlook.com (2603:10b6:208:318::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.20; Wed, 11 Aug
 2021 09:45:35 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 09:45:33 +0000
Subject: Re: [PATCH 4/5] drm/amd/pm: change return value in
 aldebaran_get_power_limit()
To: Kevin Wang <kevin1.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: kenneth.feng@amd.com, frank.min@amd.com, hawking.zhang@amd.com
References: <20210811083323.1084225-1-kevin1.wang@amd.com>
 <20210811083323.1084225-4-kevin1.wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <d854470c-65b5-3207-359d-405ccdb55ae0@amd.com>
Date: Wed, 11 Aug 2021 15:15:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210811083323.1084225-4-kevin1.wang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::18) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN2PR01CA0043.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:22::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.15 via Frontend Transport; Wed, 11 Aug 2021 09:45:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5b9c7e4-bb89-4587-9f09-08d95cacc36a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5207:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5207FDD54C19950F66B638BD97F89@BL1PR12MB5207.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8psLavWhRRsTCIY/iV7Z8Ub19IHrzEP4BltU5V/7zEI9OWcAOIPz8xCqJrwRA77iiDwrBxxctTIyT5e3TJp/iCKGm6NtBf398ReNyL3jXPbTAv3HNTsXeqgB+jCWUljXXj3ctL8clmadmETyQBm/2/C/ESgqWpK0uwFwo3+kTkYK5c5bzm5OLuC7SS7aImn4dYfeaowVX2RjsGBYX1qwZh6fxxMSnF4AIJpOeaqscu4HbThut5n8jYNl1YhiQ0loKPLFIRIEVw/WR1z2WZCaMyhHAmI1TKj7ofSWzojZZMgG2qhSlWcUSTm+XKy+PkHqzngNP5ALXKhQRg8NBiVEoiDk2aizh4QcraVPuOJsOr/67YFwzBmKD3MdLpfcJzRCAt6fdjAPxZaKh3P+2uAiUmgJhqW45qVJI5FugPBEHCep5weNzYH7ra0hycwPrY2P1qumTt2FWUb5thtSTpRAB5fTgYCAttf4Rxo5LtcUHW9qdrhbySF9Glut+Hj/CVwYOt/xIbIkIWk5CVdRDqkBJzpYdtydThqn0J21ax538Ye1Xrw3YOdbttIieSCcmMIood9kHt7Lb6dH8anyvLRLMQ2TjwA7Cylb96dqMwsd0QCGmTrziZ64BB1xuBfmVL2wUtVl6yZ1hBlpZ3mvQuY56D7iJys9XdZ7+pwNUTg/KoP9kX0zKYGQtoRqdLxp/lfg1VhjCTHjmShU5luHZvDNj/04oPq5HafPB0tQXHL2EWgFdJG+xhLgRyzbZ9gGpIr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(8936002)(6486002)(53546011)(316002)(5660300002)(478600001)(31696002)(16576012)(6666004)(8676002)(83380400001)(186003)(4326008)(66476007)(66946007)(26005)(31686004)(86362001)(956004)(2616005)(36756003)(66556008)(2906002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm1TRVE3SWxGQWtwQm1vK0F3bG5LY09jMHFCT1BaZWpoSWZpL2JFR0VnQzR3?=
 =?utf-8?B?VllNWVdJWjZ1V1B1WmplYmZmMjRPa2RHcVpmOHZsRUpKSWlSNjBmMHhiN0RB?=
 =?utf-8?B?b051SytaNXlYUmg5d29qVmYrUnpTNmJ6dWFsMEw1ZXkzNWtxc0dldnZobThW?=
 =?utf-8?B?bGJaMms5ZmtNTCs5cUhxU1hjWVZxei81NXFqNlA5dmpaSS95REQ2TDlETGtR?=
 =?utf-8?B?OWNzOEZURWN3ZjFMNk9zK3prZDExeTBFNXkvRkJiejlBa0RVendOeFR5T2h1?=
 =?utf-8?B?TDFWUHRqTWhhMnNhSDRIZ2xQN2VzVVZJNk0ydWhTdlR4dXdLeCtiVE1Uc3A1?=
 =?utf-8?B?YURJckh0Tzc3aVBFcG92Q2YxdDZtWVY4b0t1T3VJL3hySlhURCs2YXFVaEJD?=
 =?utf-8?B?aWhsZk1QWmhqdXlvZU5pSTVnTHdKanJEbDkrL0tpVTlpNnF6UWU5RFZVa3NZ?=
 =?utf-8?B?NExSbFJZUENqNzR3S1hEY0VUSzB6Z2o0NysyRmZJWElkcmdIWmk5akMrcjN2?=
 =?utf-8?B?MlorZ2ppQTVwTzRsVFNOUlhzOEphUWxEc24xWFdEdmJYL2VuY1ZSM0NxUzJ6?=
 =?utf-8?B?S2EwMFdha1ZGVFMxZFl1UnJyTlU2d2JMVDFwNDBBSmFsVGVhaHlwa2VBQnRm?=
 =?utf-8?B?dk0vcHNrUTNBdVVNU1BZMmFvZmNESmtFL1FVeWxhOVM5bjJibmtPRldqVnhH?=
 =?utf-8?B?aW1ZSmhjK1JyOGxHcEVVaWEvbmtnMjNGWHp0UTZ1YUtPdDRWMERKTzc0d2hl?=
 =?utf-8?B?Y1RJZmdMVUZSZTFiSHJOR2hJbHFRUW51VjhLNDlpMW44dHc4STVnWk9YbS9U?=
 =?utf-8?B?SGRmRHY2WEpZd1NHU2kvM1Z0QzZ3bjUwRmJIWDZkY3hxU2ZGRXN4aU83MEJ2?=
 =?utf-8?B?alNPTnpXNXQzYWJmd0hRb0dBS1E1VkIwVmRkVm1zYys3OHRBZk9GNzVLY0pF?=
 =?utf-8?B?bXZFWGY0ajlUVzlKeUNKMDVxaXg3aCs3NHZ5ZUZzT3ROeWlNeUdCWTNIUjlz?=
 =?utf-8?B?dzJnRkRvRmgxOWJhU2hYcVFoK2p5a2lrenVUY1dFRmVuMmlab3YvOEM5czFu?=
 =?utf-8?B?NHgvT3FWV3RDS3B6bklXOUVYNFpZYVJxYWRPOFFaS0tQYzJPWWJZZ1Y2ei9X?=
 =?utf-8?B?L2V2akJrbG4zSllFT0NBVnNPRnVjTU5KR1ZmYTZZWkVvbDFwNTNnL0pxd1FR?=
 =?utf-8?B?SWRaSTF2Y2tvRTNjNlNVeDUyTWVRNTYvYnVFRFpMY2Q5UXlRY0ZDbDRsdllO?=
 =?utf-8?B?MVhIV0IwMngxZENZR0d1Ymw0ZTFzNmdUbkVxdm9tSXdxMmRoMXl3ZzdUSThS?=
 =?utf-8?B?dklPRnh0LzlVRkh3em1vOHpuVDEwMlViVjFxUWZKRzFUNXNyT0xUOS9iTzRW?=
 =?utf-8?B?SFVlRWpMKzN0N3NlcTdoSFZNY3dDQ3dwRHlqWS8yMllwUXpKeVdoMENIeVEx?=
 =?utf-8?B?SFo2WTd5SzBUR0J2eWMvK1F0bGJnQ0R4bHRrRzJQRERPVGI2eHVqNjA2RlVa?=
 =?utf-8?B?a1ZsS3hTN2FEU083V1I0U2RuRHhtVTYrR1Z6SXRvTVIxaXZJdldxZlNPd2dX?=
 =?utf-8?B?SWpPMzVTNHdtMlJJR3ViZ05TR0FNRXdQUUdCR0xYd05nMStBOFg5NXlCNzIv?=
 =?utf-8?B?K3VOcEZUSnNUV2h2NGVSNXN2c3Z5L3JpU1hiMzFkTnN5QlQzbnZHZ285SDFB?=
 =?utf-8?B?VVplWFlzVUZMdkxZS3JWTElkUHJsQWNIUXE3bzgvNGl0UDJUbkY3MEwwSUha?=
 =?utf-8?Q?+RcFbEgZwbbirxC89x03p6WWHwnnWFPH4A/54yE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b9c7e4-bb89-4587-9f09-08d95cacc36a
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 09:45:33.4730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IcyuqqImr4sKX+wzBUczE+r+JVbtnuFiI3vRCNsunlObsgJsRK0gZO9HdmpK3JN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5207
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



On 8/11/2021 2:03 PM, Kevin Wang wrote:
> 1. change return value to avoid smu driver probe fails when FEATURE_PPT is
> not enabled.
> 2. if FEATURE_PPT is not enabled, set power limit value to 0.
> 
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---
>   .../gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index fd04391364ac..e00ac43515bb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1194,8 +1194,19 @@ static int aldebaran_get_power_limit(struct smu_context *smu,
>   	uint32_t power_limit = 0;
>   	int ret;
>   
> -	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT))
> -		return -EINVAL;
> +	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
> +		if (current_power_limit)
> +			*current_power_limit = 0;
> +		if (default_power_limit)
> +			*default_power_limit = 0;
> +		if (max_power_limit)
> +			*max_power_limit = 0;
> +
> +		dev_err(smu->adev->dev,
> +			"the PPT feature is not enabled, set power limit to 0");
> +

Maybe downgrade to dev_warn as it is not an error from driver 
perspective, it only limits the information available.

Thanks,
Lijo

> +		return 0;
> +	}
>   
>   	/* Valid power data is available only from primary die.
>   	 * For secondary die show the value as 0.
> 

Return-Path: <SRS0=IsfY=FN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CC1C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 10:06:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F8A823444
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Dec 2020 10:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8A823444
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E20B6E147;
	Wed,  9 Dec 2020 10:06:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D1316E147
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Dec 2020 10:06:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gz2IVarvAgms9oxvxQLHOUxqesQkM7dCtQjZMelmGaoBxWfvdp+MsrT05L3/PhRc8Lk3COPugeJlpa8y2t73UtmpyxBE4cpaY6LadFHNoZDMAbqxvK1Wa9bBrG5IshsBHeo0ih7UACDI7r5z85LG9ixwnXuUTy9lQR8J+RvFOP7UG0v4a66ZlAhmG2SH9PB73WHivTuWaDd06ocbGa59Br05AWe4Jh9dsYWjqP9X8LnmVgUMNxCfSaq2VFSr3z831kKLqXhtnHg9bBUA7HTMDnGnqV5LKfoM38Hn6G9+PVRhXU9qeXwiBYpJWZ5mNuOvlH7zLel3DbxBSOCkeVa8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Rhat+Tjprm0nVmqmG4tON8h5NRjWvN4rIM5NQSrJwo=;
 b=Zgbp/6+wd38QbhGBh5fQg7/nkdy33fQRZTRJLCf6hx9gEXZ+3fP/pQ74cYqPUBdrd0m12iHfrXxnElmDF6NthL1hxBZB8s6k5re+gGNZY+Ev/HuvcZxSleCIPY/6N62Uo09fPVAxtYz7nTGddtUkl5NLn9fxjAv6kuGqsFBpH7hQQhPy1/Nr0u5W5tEto7TGxcGmXIXVasjgQqvAaEdgQ9ZC1VEtCsop6ANugY1fcxUVWamjtwbEP9E4i2o5br8jTWJnwbTC+hfjmlHJWyHgxyPW26z38L4fEiGVJ74X9e8+mxIWOqcOSrdwwBnk16nc1GNWgWlzpmzuQRABeNRSVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Rhat+Tjprm0nVmqmG4tON8h5NRjWvN4rIM5NQSrJwo=;
 b=LocU4hGoHapgYRq0U+QZBAaGqka/pH1tq1dL/pDbv8ZoEdElJI2/8XpXBU3+rXJe3UcD1S7/1I34XrxOo1K/GidaKHcATIAQHT8JdLnTtGH+P6gZIC06Ist5L9EEvDpe1ZP4FXgn/01RCzN5eUdcg0KzNH8AxMO0FqcBAwow0UQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Wed, 9 Dec
 2020 10:06:32 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3654.012; Wed, 9 Dec 2020
 10:06:31 +0000
Subject: Re: [PATCH] drm/amdgpu: Return -EINVAL when whole gpu reset happened
To: Liu ChengZhe <ChengZhe.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201209094652.192633-1-ChengZhe.Liu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <75590f2b-019e-b6d3-7a8e-be11e3564f57@amd.com>
Date: Wed, 9 Dec 2020 11:06:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201209094652.192633-1-ChengZhe.Liu@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM8P189CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::12) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM8P189CA0007.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Wed, 9 Dec 2020 10:06:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b861cae-ff97-4415-aa49-08d89c2a1a77
X-MS-TrafficTypeDiagnostic: MN2PR12MB4518:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4518CD57C22DB1A3FAC3134B83CC0@MN2PR12MB4518.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ihYDW8Wjak64VuEvtQ7kca2tYlo4jkCpRoM+xQVwbfrMT6sKEgOxR1NFls1pASc2dW9CAjlIS7ZOePvO0IcZEIzrP9mRi3eE/F3jZmIuyx0jh6ZFMbJFxykI5+jNlRp1VhUgp3H2aYm+ivn3/9sO+3CVnmIYhG1UqAIGkgj69Ix6BTznrqZMpAzp86CXJk44PeZtyw0ty3chouFjiRJ1usWSCsXHNhdvJMNpLDNi4VKzUcfxU74F/wm2bW7KpfbpmlokgGq9CnHYuoLjeIEU8nVz4t09x1OkHprnKrsYUHhPxhAboCUq7/CPJhFgDrfvWQQVnPE5d6JnjJO1jNlg9AooDhDFtxrdP2OetyIeSGyzJh4NspJSLoeZdKfCoCTGcZInd9KEH6eikuQSPQVLUtMydFfiOEs0192n7Ri5kQAQF4YZ2hzKimEHtWrkIEhD
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(366004)(376002)(6486002)(83380400001)(52116002)(2906002)(54906003)(6666004)(16526019)(66476007)(66556008)(186003)(31686004)(4326008)(66946007)(36756003)(8676002)(5660300002)(31696002)(34490700003)(2616005)(86362001)(508600001)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cjY3Wk5IdmdQT1VGamNpRklXeWhZZGtZMTFrTUY0T1RXL1VybVlicWtnMDZW?=
 =?utf-8?B?aUUwZWVIWEN5dmhpNE1sUXRhcjlOMjdiS1htVlZyTFRWeCtCeS9DMmNodWJt?=
 =?utf-8?B?ZFlkSXlURm5lVDVFeG5ZWXdXMFZqSk1vd3Z4QkNDbG1TK3lmeWg1a2ZqQVRq?=
 =?utf-8?B?eHRscFFCNlJ3NGtQYXFOcld3cldMQVExNVZzdThRWGVwRGU5dUhXYmhDenAv?=
 =?utf-8?B?RG44U1F6ZGpMcW5PTjZmK1A5T29qT2N0UXVOQldua2dVZVRpdmhtb2NVd3Bj?=
 =?utf-8?B?c2xFMm85MUNnOGRJWjh0R3JVazdrdURZZWZZbk4vcUhKS0NJMHg2R3FTTllq?=
 =?utf-8?B?L2VSbklDUGEyTExXZW1kaStZVWFwNWRtTW5kK2luTDE3eHdWM21HWmpoTk1l?=
 =?utf-8?B?VDcxaStlNUJQbjRQS0lpdDBJS2VYR042dzk3UXI5YXdXbHJWMGtGUVNzZzJi?=
 =?utf-8?B?anVITW8vaGMwOXQ3S0pVUFFjWDk0ZDFGSENuS09Tblc5MHlLZmpFOWpYWmM1?=
 =?utf-8?B?ODczTkJTdjF0N3dqWDlOUUdGUXQzb2I0MWdEREpoSE13MXVsTmtaYkxhZmxx?=
 =?utf-8?B?MDFYSVRSQ2I0U2cydWl0cW9NclZNNmZFOWF2VDBYMWlJdkZLT2lZRGxkeU1t?=
 =?utf-8?B?Z0REY252azNwVko3a3JzaFVjYVY3V2k4YXI3QW1Ya0NXdys5cDhmUDNFeHdl?=
 =?utf-8?B?V1ZKZVpaK3dyWjdxQVo2bTlVR1h1NXpkTU5OQUxMZEQwNU41eFRYUWFDSHFz?=
 =?utf-8?B?OG1NdmVQckxCN0UxQ3hwVjdiRjE3ajJaM2JnbFlOTzdubm9tZmsrVGpUUDB0?=
 =?utf-8?B?NEpqemtPdWJVMTJ0L1pjK2xZYkFRc1FZZTR1cm41eWlsQWRnQTNYWlVmZjVP?=
 =?utf-8?B?UXVPSFlMRXpnNW1ITjhQVjdFMFc2VmRnUXk3cTB6UlpOQ3VVYi9mcndLSlI2?=
 =?utf-8?B?bThKNHozWjNqVld6Q0taMUNvNDAzVXBpTEY4cGljbFcvakYycW9PVlB2NU04?=
 =?utf-8?B?VnozYTl2MUJKemZHRnZnY2ovSEpCWmZQYzc0NmErODlMR0ZKcHZEcEVUczNz?=
 =?utf-8?B?ZVJ5Z0EwMWk4aGZrbzZTTENNWlR0RUQ5SXpxN29QWDNpSXpCUk4wRms0NlBP?=
 =?utf-8?B?c0l3Zmhpa1NJYlhZSVI1SXJITFdkczF1aXNHUWtPenA2WmNyRXBjeTcybDJE?=
 =?utf-8?B?cm10NmFmZlBrV2NYbzNnRzNWd1l4UHFYU0xxRVFELzdtQ0hyR3U5K25XZGRZ?=
 =?utf-8?B?akNkQ1orc1pkTFFLSW9MeXpvRHdxbkRNcnpmZ0F3b01IK3EwUy9jeHlYa2ZG?=
 =?utf-8?B?T2N4ci85bDB2MHYreDVOSzhYTFJEY1FQblZLTURFS3YxOVpPQVBXRGRyL0x5?=
 =?utf-8?B?V1g4ajBSSWp0YzdEeGNxYkVCeExvcytoOWdIMjliZXJBNHlYT0xuTWFsSzk1?=
 =?utf-8?Q?wWIJtoFN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 10:06:31.7785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b861cae-ff97-4415-aa49-08d89c2a1a77
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UmIb+CYSi+se7LUrCyCfEcE/owS49q92A7cLzBeEjYSjMXELqzSb7yPZ2cB3bpK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4518
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 09.12.20 um 10:46 schrieb Liu ChengZhe:
> If CS init return -ECANCELED, UMD will free and create new context.
> Job in this new context could conitnue exexcuting. In the case of
> BACO or mode 1, we can't allow this happpen. Because VRAM has lost
> after whole gpu reset, the job can't guarantee to succeed.

NAK, this is intentional.

When ECANCELED is returned UMD should create new context after a GPU 
reset to get back into an usable state and continue to submit jobs.

Regards,
Christian.

>
> Signed-off-by: Liu ChengZhe <ChengZhe.Liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 85e48c29a57c..2a98f58134ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -120,6 +120,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>   	uint64_t *chunk_array;
>   	unsigned size, num_ibs = 0;
>   	uint32_t uf_offset = 0;
> +	uint32_t vramlost_count = 0;
>   	int i;
>   	int ret;
>   
> @@ -140,7 +141,11 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>   
>   	/* skip guilty context job */
>   	if (atomic_read(&p->ctx->guilty) == 1) {
> -		ret = -ECANCELED;
> +		vramlost_count = atomic_read(&p->adev->vram_lost_counter);
> +		if (p->ctx->vram_lost_counter != vramlost_count)
> +			ret = -EINVAL;
> +		else
> +			ret = -ECANCELED;
>   		goto free_chunk;
>   	}
>   
> @@ -246,7 +251,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
>   		goto free_all_kdata;
>   
>   	if (p->ctx->vram_lost_counter != p->job->vram_lost_counter) {
> -		ret = -ECANCELED;
> +		ret = -EINVAL;
>   		goto free_all_kdata;
>   	}
>   

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

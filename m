Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11010C47094
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 14:53:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0A0060FE5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 14:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A0060FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FB146E8EC;
	Mon,  7 Jun 2021 14:53:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDCCF6E8EC
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 14:53:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZSM2Bdqh0ud+02ZNoG91EETz69azJT1I8GHXdNXDFRje3zjEz/9PNoWq30gA9oS5CUov4Kefr61dsTXYY4WOrFvJrBcaViYR1fzCaO8QZZ9hum7tMQeBwtOgq20hP0rT9bdaXAzQFDDfV2vpic/yIBHbCaZZ1no1kznR3oo7skvzDRSo3g3LnLAbc8vEkbv37wc1XlhtAOhDIpd2XlBQho4WMUmBrEASSWobDzQnhhe0XL1CLsagPlnRx7zY7KAfOoNv2NV2zUBK4fDpBKNI0e0ws846o8QAf8yfuIDyV3ao0t3A/dvknAXV6s+OVGV6tNIrglRSQFk1+PNfQUF5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1ap3N7PMAtCdGn5AqeaK2EE7sGyB5M64j8s9taL1Bg=;
 b=ahFt8578A9394F0HTQXi3r5DD1kf9pIeRIulHHcIdcbQE4vtuA/UShVu4kpcbkUoXtcZQd1EkSafipQpCpfa9Tg5rxekOtzjESgWJstTqgf9akTQJNGSsRc8u5W23Wnytb8db7dLp7hlLC+ZqFUCZtA7ECnJN+8XGuVphwyu9PJlIqdp+Tu8Ue7ZinC+Mntp3z7Mj3zAkOK9sgF1KCVwIqgoKYWutR31C1V6JD4MASVxAMvfFWtY8nJYDwQlVJLBnbhjrzOl+jvwE8qkDo1/ZmEX9OeJgNd3aV1083YUXyFwPEpzl8qNOFcrip9LwSbWn02+LsP55z84wP4oVhTEMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1ap3N7PMAtCdGn5AqeaK2EE7sGyB5M64j8s9taL1Bg=;
 b=RiaeLi3+d09m1usLQVuzMQknZLZl7g6k+p6dD1asWzMBEq1e03o2mh0EtfS/GL9dVds/SMwdm/ydQSB2WFfUSXXF/6+ei69lB+S3RD6M/wcoYSPiL/hJPqV10T3aO/OTZX+31GrLdQXYdTi6aEFTrnCVJ8hedV39ciuB9SwvtRg=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Mon, 7 Jun
 2021 14:53:24 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::5c8c:adff:ab42:9345%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 14:53:24 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v5 7/9] drm/amd/pm: Add vangogh throttler translation
Thread-Topic: [PATCH v5 7/9] drm/amd/pm: Add vangogh throttler translation
Thread-Index: AQHXW6NcsXeKXW1K4k+gBauJRTWsw6sInV4AgAADPzA=
Date: Mon, 7 Jun 2021 14:53:23 +0000
Message-ID: <DM6PR12MB30671D8EEC491B827B06E3D58A389@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20210607134439.28542-1-Graham.Sider@amd.com>
 <20210607134439.28542-7-Graham.Sider@amd.com>
 <26b9761c-eb4d-6c30-7817-18054efb6006@amd.com>
In-Reply-To: <26b9761c-eb4d-6c30-7817-18054efb6006@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:9880:1967:ffd9:5d34:9123:5c8:6e5d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 680c6946-36d6-422f-5a00-08d929c4004d
x-ms-traffictypediagnostic: DM6PR12MB4203:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4203AD22DD95E7EC5494B5198A389@DM6PR12MB4203.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q4k9X5LXYMlrpD0Pt8u3NRord/WuXUyecijn4cOvUmIwQJTGmM+X6JPohwmi8PZjGZDHg3elGyRD5hCTFKiKIKcxNmG9fi+SXNaH0BRiFr6WJS0GnmGDRvjClbof7wulvzCygzVasa1323lpZ15+tjRdiEqpLy5uw/i8wenKsDjIy6W/g47qhI6IpIqUC4rBrQs6g/OrqEMm/QRWrvozMOTDoBy9B+FoRziNP4eMB9L98DAMIA1DKdRG2RYah2BzrUKUSto3pvtixfkHb18jz1XoY+ksr0q0OjazboKHU66Wdj0vJf2oEnsALhkRHY4BrH/whdMRDMQl5XrwR6x9XB5oNuARYOT1TCa62jkmDUJFZiknfrTP2I9i/MXfZVJr55MG2ZMUgPaWKKQk7Q9EtuUve53ut2i8fKv3ZfGwyYmcMzMzUtjrbrySyVzqTzZN9Bu66IdiH2Y6yeKAWjlyi3MKIUAMusC6O2qQEanmqNVE3qT5EmB59mc8XBgoM1BwTz14yFI9XPPMdEX6ofELJNXnfgm98DCg1bSFaVKokJTGd4o/+Ld1XmjrV5t02mTzTxt07Tg1/4XPVOWvz0vLHmAw4O/EXwNfcy/yStwYY8E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(136003)(396003)(39860400002)(346002)(4326008)(55016002)(122000001)(8936002)(54906003)(9686003)(76116006)(38100700002)(66476007)(33656002)(66446008)(64756008)(71200400001)(66556008)(66946007)(86362001)(7696005)(8676002)(53546011)(478600001)(6506007)(5660300002)(2906002)(83380400001)(52536014)(110136005)(316002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?ODZ0cGRaQVFDcEExOTBZYi9kd2VqcExhZDJpMmpUWkhVb2I2QkM4Yk9NelpY?=
 =?utf-8?B?OXJtbnA5S2V2TkU2RDA4K3FSVW5uWEJ4SWRKcnZyUWlEUUZacXFzOTl3dG1k?=
 =?utf-8?B?NGZyS3RLTWtTU3p4OThVTDVEODNlTSs4c2lGNDRxRXNMOXMrS1dlWVNpYnNN?=
 =?utf-8?B?dWtXa2lKdHpTdW1OaTlaSDhLcWlRQ0trVTRlWWNta0o1RUJtZGFaR1JLTTkv?=
 =?utf-8?B?WC9vTk0wUllDZE0wZDd5WUl1aUR2YjJRb3Y5YU9oNkwvbStTSGtXVTNyOVBH?=
 =?utf-8?B?bHFpM0hVMjVoSWNQQmFIdGtpTStoQm1VYy9Fd1pLbGdMaHQ0REYzYXB3ZGJX?=
 =?utf-8?B?N3p0K0VkY0VNZGk3eWJNVkVXTm5MaVlFbURkQjRuMERoQmN1bHFWNlVwRXIv?=
 =?utf-8?B?Y1dWdmwyeDdVTTVnTjJsZTJsOUZtQjdoQWlWalZlZk1TVEROOWRvMmZzUUpT?=
 =?utf-8?B?WDZqR05IUFpqNW9mVUhUajNJa2ZRd2xJUTVuRnFwV3NIeGpWUzRwbHZtSFdN?=
 =?utf-8?B?N1J5ZlFXWlhoLzNuZ2xua3gzU2tUd1BZK3FJLzc1YzJkQzBaWkgwVXdycUZ3?=
 =?utf-8?B?K0hYeUVwcmxXNVVveGgrblFPSEJ6RHlTVTFhaXRWYlJTY1Q2SHQxUDhpdG9E?=
 =?utf-8?B?a1l1K3ZEUmFFSWJPTElPOEorOG5FQXRWOU82V25SZXpucmJCSE1Oc1dRZ2tv?=
 =?utf-8?B?Q0ZSakhWYjBXWEMrYXVJNHBRdnMzYm9KWkZSMytvMTBONnlzbGY2UkRIMmM0?=
 =?utf-8?B?QXVWczU4bE9YRWxTYnhsK1E3SDdTbDc0aUFSdmZEeU5Td0xDR04zOEhZUzJq?=
 =?utf-8?B?UGM4RSt2dnR3VUxVMC9EZzNIWFdHOEFTU0lzc3BPNDJkalZnMTVNeE1Kd3ZQ?=
 =?utf-8?B?OHo0cGJWS3BNRW95QmdjUlkvMnFWT3RhcVkwUzNkaWloVGxRdXFhMHFVTzBs?=
 =?utf-8?B?UUlITVdSYzN1WDMyOGhjbjQ5NVNES0VJUGZZOGV4akwvV1RxRTdlLythOS9j?=
 =?utf-8?B?Q0N3OUZFOFErOEJEQ2dnanR4ZkdzUTFuUEk1ZVdIdldnVFZmYThncHhIUXJ3?=
 =?utf-8?B?TDFqRFBOR3pjTy9pajZKcHg2K0RIQ3hyQ0pIbVZzakZkazVQeUpmNkdrNUNx?=
 =?utf-8?B?NUE0ZHc0VlkzQXN5a2E5WmZBYlZaTUg2TXhodEdQMW4wU1pXZHdEZ21nQlhD?=
 =?utf-8?B?TWpnTm95a1hxb3JFNml0UlZJUUdRYzhMdnBZY09HNE45eXB3MCtDMnAxbDY5?=
 =?utf-8?B?bFc5S25KQkdUckFMOTd2UVF0SkNoY2ZMZWxGMXE3NDhTM01COHRNM21tOHB0?=
 =?utf-8?B?Z1UvS0RVZDd3WDZwRjNISE9UdU1aWU1TSmE5aUZ5bEVlRHhYcHZqZXR1cGNk?=
 =?utf-8?B?MWpQRnNINi9HL0MyeEpMN2FjR1p5VkJqZG9EQjFoeWx5UDcySEVSZWk2MVoz?=
 =?utf-8?B?Nmt6V1RZcHN6aGtjR2g4bkU3dEJvVWtyWk81VnpLUFJQcEkwSXZoNkV3R09T?=
 =?utf-8?B?cDVVTzBuL1NXZ0pqUmIxNUxMc1gzWkZkMklWV3kxeWdhanZ6OW9LQU9zNTNp?=
 =?utf-8?B?aGdWeThGWXNoNnlPM09ZaWZQRHNGWndNU2JFcXlHb2ttTDlsMG5KZjR1Mm5E?=
 =?utf-8?B?cnBRN3ZVb2xuUUcxN2ZGOFVRRFdZNzg1MTV4UWNSZ1g4YWFBZCtqczRXcEV3?=
 =?utf-8?B?NUtHL3RrTTRlYzJmcDdLTGpCTHlDSWxvUlJTMXpFSmZnREMzZmErQjRScm1r?=
 =?utf-8?B?SHdPd3JCaU80bW5UNGhaZ3QwZkNhamJUM1Q5bDBYb0E3aXdMVXdLd1V2dFp5?=
 =?utf-8?B?Rk1xRXRlNk8zR0w5UDFDSVM2WUlnbFQxbXdKQUl5YitNVm81SDhKTDNpSjZB?=
 =?utf-8?Q?3DdDTYGT7TiuY?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 680c6946-36d6-422f-5a00-08d929c4004d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2021 14:53:23.5099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M4sni+Z6Mc7e2QOhwQHrDbXpjAmo20JX0/Kzq3ZF/Mg9TxhT252ZdV+0NMLRcIrszI3youTbbsy7T/JDb/rBVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203
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
Cc: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>, "Sakhnovitch, 
 Elena \(Elen\)" <Elena.Sakhnovitch@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Great, thanks for all the feedback Lijo. Out of the new bit definitions in amdgpu_smu.h are there any that currently exist that are more applicable for these mappings? *_THM_GFX and *_THM_SOC only exist in VanGogh and Renoir. With the expansion of the MEM and LIQUID bits there is not enough room in the temperature field to add two new definitions.

Best,
Graham

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com> 
Sent: Monday, June 7, 2021 10:35 AM
To: Sider, Graham <Graham.Sider@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Sakhnovitch, Elena (Elen) <Elena.Sakhnovitch@amd.com>
Subject: Re: [PATCH v5 7/9] drm/amd/pm: Add vangogh throttler translation



On 6/7/2021 7:14 PM, Graham Sider wrote:
> Perform dependent to independent throttle status translation for 
> vangogh.
> 
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 38 ++++++++++++++-----
>   1 file changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c 
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 77f532a49e37..589304367929 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -190,6 +190,20 @@ static struct cmn2asic_mapping vangogh_workload_map[PP_SMC_POWER_PROFILE_COUNT]
>   	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
>   };
>   
> +static const uint8_t vangogh_throttler_map[] = {
> +	[THROTTLER_STATUS_BIT_SPL]	= (SMU_THROTTLER_SPL_BIT),
> +	[THROTTLER_STATUS_BIT_FPPT]	= (SMU_THROTTLER_FPPT_BIT),
> +	[THROTTLER_STATUS_BIT_SPPT]	= (SMU_THROTTLER_SPPT_BIT),
> +	[THROTTLER_STATUS_BIT_SPPT_APU]	= (SMU_THROTTLER_SPPT_APU_BIT),
> +	[THROTTLER_STATUS_BIT_THM_CORE]	= (SMU_THROTTLER_TEMP_CORE_BIT),
> +	[THROTTLER_STATUS_BIT_THM_GFX]	= (SMU_THROTTLER_TEMP_VR_GFX_BIT),
> +	[THROTTLER_STATUS_BIT_THM_SOC]	= (SMU_THROTTLER_TEMP_VR_SOC_BIT),

Above two mappings don't look correct. They essentially mean throttling due to GFX/SOC domain temperatures in APU exceeding their limits, not the VR temperatures. Except those mappings, rest of the patch series looks good to me.

Thanks,
Lijo

> +	[THROTTLER_STATUS_BIT_TDC_VDD]	= (SMU_THROTTLER_TDC_VDD_BIT),
> +	[THROTTLER_STATUS_BIT_TDC_SOC]	= (SMU_THROTTLER_TDC_SOC_BIT),
> +	[THROTTLER_STATUS_BIT_TDC_GFX]	= (SMU_THROTTLER_TDC_GFX_BIT),
> +	[THROTTLER_STATUS_BIT_TDC_CVIP]	= (SMU_THROTTLER_TDC_CVIP_BIT),
> +};
> +
>   static int vangogh_tables_init(struct smu_context *smu)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table; @@ -226,7 
> +240,7 @@ static int vangogh_tables_init(struct smu_context *smu)
>   		goto err0_out;
>   	smu_table->metrics_time = 0;
>   
> -	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_1);
> +	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_2);
>   	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
>   	if (!smu_table->gpu_metrics_table)
>   		goto err1_out;
> @@ -1632,8 +1646,8 @@ static ssize_t vangogh_get_legacy_gpu_metrics(struct smu_context *smu,
>   				      void **table)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> -	struct gpu_metrics_v2_1 *gpu_metrics =
> -		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
> +	struct gpu_metrics_v2_2 *gpu_metrics =
> +		(struct gpu_metrics_v2_2 *)smu_table->gpu_metrics_table;
>   	SmuMetrics_legacy_t metrics;
>   	int ret = 0;
>   
> @@ -1641,7 +1655,7 @@ static ssize_t vangogh_get_legacy_gpu_metrics(struct smu_context *smu,
>   	if (ret)
>   		return ret;
>   
> -	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
> +	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 2);
>   
>   	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
>   	gpu_metrics->temperature_soc = metrics.SocTemperature; @@ -1674,20 
> +1688,23 @@ static ssize_t vangogh_get_legacy_gpu_metrics(struct smu_context *smu,
>   	gpu_metrics->current_l3clk[0] = metrics.L3Frequency[0];
>   
>   	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
> +	gpu_metrics->indep_throttle_status =
> +			smu_cmn_get_indep_throttler_status(metrics.ThrottlerStatus,
> +							   vangogh_throttler_map);
>   
>   	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>   
>   	*table = (void *)gpu_metrics;
>   
> -	return sizeof(struct gpu_metrics_v2_1);
> +	return sizeof(struct gpu_metrics_v2_2);
>   }
>   
>   static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
>   				      void **table)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> -	struct gpu_metrics_v2_1 *gpu_metrics =
> -		(struct gpu_metrics_v2_1 *)smu_table->gpu_metrics_table;
> +	struct gpu_metrics_v2_2 *gpu_metrics =
> +		(struct gpu_metrics_v2_2 *)smu_table->gpu_metrics_table;
>   	SmuMetrics_t metrics;
>   	int ret = 0;
>   
> @@ -1695,7 +1712,7 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
>   	if (ret)
>   		return ret;
>   
> -	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 1);
> +	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 2, 2);
>   
>   	gpu_metrics->temperature_gfx = metrics.Current.GfxTemperature;
>   	gpu_metrics->temperature_soc = metrics.Current.SocTemperature; @@ 
> -1735,12 +1752,15 @@ static ssize_t vangogh_get_gpu_metrics(struct smu_context *smu,
>   	gpu_metrics->current_l3clk[0] = metrics.Current.L3Frequency[0];
>   
>   	gpu_metrics->throttle_status = metrics.Current.ThrottlerStatus;
> +	gpu_metrics->indep_throttle_status =
> +			smu_cmn_get_indep_throttler_status(metrics.Current.ThrottlerStatus,
> +							   vangogh_throttler_map);
>   
>   	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
>   
>   	*table = (void *)gpu_metrics;
>   
> -	return sizeof(struct gpu_metrics_v2_1);
> +	return sizeof(struct gpu_metrics_v2_2);
>   }
>   
>   static ssize_t vangogh_common_get_gpu_metrics(struct smu_context 
> *smu,
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

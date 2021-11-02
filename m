Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4DFC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 08:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C92D60F56
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 08:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C92D60F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFC746E91C;
	Tue,  2 Nov 2021 08:17:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C69566E91C
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 08:17:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkiBVo3Mu3mCfDFGPGtNPBTnEukvwq1zxJb5pQWqYwqXlq1mP8zZ/2tbnEw4cGZa6KhF5SUJ9fN3hR+ueWK+q0dmd86a7ZHy71uRzIV1YlYPLJ/LEMvt3ASF9J0PWaAEeOjQOJ/nDaDCP8jP+0sYzaCv29D5aqf+AyRZvqLUlrQ7ELD3n6ErgslTfN5qr7OMnsNjhsHdoaFZlUP4fCyLEy5nqtnlTpAdRS7Scu42VaadIgy/5EkC378EcJpDBM4dlmozvxS2yTIElTqEunKlTGMy/gDHBQVvBwKAtDccAhzKSspBYpLFMz3VnphtvB1bY/y8oHiujRIzsC/Zs1d5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nufGBzmvs66K6ES7PuVY0rfPMUUZMTwyf32pokH8sFw=;
 b=UasFkVRuKA7jLtW7AVMKLEicdi3+y1m9u/rd5lLlYwAtHxgAJQN3cJV4Q1AiNNfnNZfDHBmlRaWmxc+Q4xxxZWCYKXi6UtyuqyWjbV4ELLnIQ+esMcEPEtpqQ5m8V2geMXN1lt4lGtCvQLr38/7nmHd5oktUHyjnktTt4KBiV2TD9ItnjkpTBFebT0DB8UJCxDW63cZfInIhkcFpe6CtsbE4ABtzN8z7X9TEZ2mci+zn4rH0qxFFWpCPMJCJ2gbTHPCOmzich4oqwN9ER2nhdjlUSYZPQ+6HxGnO7oQ0GT8j5PrCBgmYeLxpA4u0PkL6d2M5BgUZieGac0J1pMfVcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nufGBzmvs66K6ES7PuVY0rfPMUUZMTwyf32pokH8sFw=;
 b=znTW0vydb/SPUC6N+iaoM/YWrmDDJNynNeIJHA7726EeQdF81/PbhKUFH4IdQZE7DH0LFDzXUuIDIvdA5XemphEPNFH4tUPg5oJe3qSaeA+h4mZBlKD3nu59ZBguM0Tr2UnWDo095DU6tsdWZlpxpvQ8r3numRVr81Qu3ydo8Gc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4842.namprd12.prod.outlook.com (2603:10b6:5:1fe::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 08:17:45 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4649.019; Tue, 2 Nov 2021
 08:17:45 +0000
Message-ID: <fb34d02e-5988-5aaa-235b-b514aa3ab0d9@amd.com>
Date: Tue, 2 Nov 2021 13:47:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v3 3/3] drm/amdgpu/pm: Don't show pp_power_profile_mode
 for unsupported devices
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20211101212848.20449-1-mario.limonciello@amd.com>
 <20211101212848.20449-3-mario.limonciello@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211101212848.20449-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::13) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BMXPR01CA0003.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15 via Frontend Transport; Tue, 2 Nov 2021 08:17:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10e52677-d7f9-4582-ba4c-08d99dd93f67
X-MS-TrafficTypeDiagnostic: DM6PR12MB4842:
X-Microsoft-Antispam-PRVS: <DM6PR12MB48421C5B0B237038B9157691978B9@DM6PR12MB4842.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hkoJEAOcZzAVsX8f14qs/ito8dhxqasanjCpdKhKOcJ8E4v/j8/x5cYOCCznYaOp99Pf2lsoyw2XthJ4J6mGjbTgd8qyn4hgwFJHRbf4ub1b6klh/1Hs1UroyVi/x1Ru6DkEyYefx9TtchiUKNB/MgL18WWqRSKxaM5H03wf6z8u/zHZ5pDftoZO0CbDoFRUS2JO8gWall4Ouhy90xapFbUfjSvOFhMlVz6djiRpheIXH5S5t3zniiGCvvzf8gNqYzW+TYPMl/cwJyt72jMNnCxmTMFHybrAbiKSwGevyFaN8cQXtjaG6HcCUu3l1osIf7ewaZJt185oHD0mYLFiZ/4d4jAJGaWoT0LHlUEhCIdCLFXDw1IQ1xgiN1ny9KZ34/DO/Fzhd33DCqtEDGFKcjyYKWPZZFOvVUVFg0TFWBItIZkER72GxL2BFNVae5i4RgY1Cq79VJjLB5NY0Qpvpkhf8AmrJHTs8fy4VcbYYkEihvQq8aerJyJpedS0drfPh8S1dMSjgz78vDyBQ5SmlSjaLocfYZSY2d5JBFWcZB5cjZEfTUC8vhxFxXYMk+1LeDCJCGe6/4fnMkEc3PnmuinV1JzxfCoYbj+q0MLQ0pRi/I+1Os6MnYJUhKvWRRMib5SjT8yAgWwSQoWGI19baczyaubQd8Ys+5Md4KsCXN1yru9dlcz/mpYFjGkX633jH7kuVGFQ6GF69bPWqy7bLbIUZGYQX/zplp9rPbUtwW/gbtovGq2J/G4bAedKuVip
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(2906002)(26005)(36756003)(2616005)(5660300002)(31686004)(4326008)(31696002)(53546011)(86362001)(508600001)(956004)(16576012)(8936002)(8676002)(316002)(38100700002)(6666004)(6486002)(66556008)(83380400001)(66476007)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHR3eEVpTTNnUEZaeHVtMFZuQ1FQOXdURGd2eFJYU1FwVkpwejY3OXpiTEc1?=
 =?utf-8?B?SmxFcW5pNjl5R3dGSlU1Um5neC9DZlFycmZKWFVnZVNmNStUVk02RVhwdml2?=
 =?utf-8?B?U1ZGMU5TNk10N1JucEJnVHNOdFZLS1RWTFJ1ek9HK2txb1AzQk5vRkJaZUdF?=
 =?utf-8?B?S1dVOXJQVVhnWFk2V1FRcFZ0UWE4d1hQWUNlWWpLRWNnd1VBckJtYitleE9N?=
 =?utf-8?B?QWpodHRpZEo0ZzBYbXJ3eW9aUFQ4OW5LL3UyZ21uTUNFU21VRHphdUtJeGFx?=
 =?utf-8?B?VW1xc1VQSGRMTHE1UFJDd1dkZFVPVEYxa1F3dndjQnlXTkRTRnljNlJyMnZF?=
 =?utf-8?B?aDJzODAzVnQvbXpGTTBJZWxQdTN2RUdIMDNBcjluc1hzZEcvbDdXKzlpbWJ3?=
 =?utf-8?B?S3FrK0VRL1pKbnJ6UDBoSDg1YW10SXhSZjF4MGU2dVMyaEZuTXFsWkZhNWEw?=
 =?utf-8?B?RmtNSy9aakZvZGZ4S2hBdW1IUG9VV3N1UklvVUZOWElSM0V4dVVTQy9rVU1R?=
 =?utf-8?B?dWZkNXBvcGhxL2diOEliWEJwSFQvQkl3OXYreUZRaGhhaFpiQ3EwM0kvR1Iz?=
 =?utf-8?B?LzFiZXdPS1puL1FTOUk0aE5OdlZ6QTVyaWlqY3Mwanl1K2cxV3R4ODhRME9R?=
 =?utf-8?B?cFZYWlpEajNMN2x0aXBQd0ozQ3pnQ0YyWnZJeXVkdHZzWnZibllYVjlMejdR?=
 =?utf-8?B?citFc0toWE1zaEtTT0MxRHVncXlmT1hZM0ZocG9yc1VlbjhRSjVYQUplckFD?=
 =?utf-8?B?NGkrbnk4TmJacUQxajFtNDF2eThQWEtiS20vODFUZnFOVDBFSlc5UzZGRmJL?=
 =?utf-8?B?Qnl0cjNkeGxVZTRKWEJyaWJtU3I2VU5rY1EwcHhRZzJKbWx4Wm80ZkxUWU4w?=
 =?utf-8?B?QWIxTWRPei9SclZXcVZrWldNd3I3N0lieEx5R2pGWDZqTFN4UTRoSlZqby9C?=
 =?utf-8?B?WFp3djd0ekNJUFQwS0NGV0Y2NHluZTRjM0JCN0dlWDZ2MmgwOEZtK1R6dk52?=
 =?utf-8?B?M0xHYUNJbjRZaGY2ZWY0Wm40RVZrL1oxWGg2SmhIa29kaGhyODJkRjNCQlV3?=
 =?utf-8?B?bm9iN2dyRnU0ZVRkQThiTENxb3E0a256YXlxb1ZjN2lNQkFrN0JXNmoyc1V0?=
 =?utf-8?B?UXlReUFld1JOODNxdU5ZTUNMaVVIYmpVRkpoSThCZGJkUk5RWldQQ1E3Skpi?=
 =?utf-8?B?QTJ5TmcyNjJBODZXcTcrbTRxTFc0WGxCcFRYNGh0clE0OFZoRm9zNyt4OGpK?=
 =?utf-8?B?NjcwVWlsZEFZanFYdHRWelc0cDI0SmJHckNkdXBQb3VGT1phQXFxTWNaUGc1?=
 =?utf-8?B?MENhc0orcEtjcENacUxsQWR3MC8vK1Q2RjUrUlJRaURmNjBvR2IrRnNuNnRy?=
 =?utf-8?B?VXFnWVp6eG9HVjJLZnZ4U1pXT21qNWhudUNBZldKNXYrMHFvbFppUUZjMXc3?=
 =?utf-8?B?UEJGT3B3Q25jYnQwN1BEOXBQZ0dtRFpadTVvWkM1OVlLL3E3UUhZbEU5amdy?=
 =?utf-8?B?OE1TQlVIMDBuSUh6bXZpY0xTZTB0emJxeithakpwcFQzbVd4OFZ4M0J4QnNa?=
 =?utf-8?B?WDgrSzJGalRUVVU2TkFQRWVkdWVyOG1IWUNmdWxPTXJjbm9TMjdIYWkzam1N?=
 =?utf-8?B?bjBQV3pNRllTYm45ODRnM0svbjU2bmZsUDlhUUZMeGNPWlNES0JNZlhFMFk0?=
 =?utf-8?B?d2g4SDlSYjdYTmFDdldKeEZGV044cjFvRm15dVYwOVc0OXpyZG83M3BOV3F3?=
 =?utf-8?B?dFBLeWxwV1Y4NUlZMGRCemx5SFlUc3l1aFlpS0p5MWFTYVRPUkRlTEF4OWw3?=
 =?utf-8?B?OWZFNTdpcVZ5TEpWS2hJdHJ3S295c2YwdEhXQllVZ2pkaXhHcU10MmtBNURM?=
 =?utf-8?B?T3VOcTdVeUNvUzlYcFhaYXdWNmszMnJNMTA5K1ZINE1FRE14bndVSkNtK2c0?=
 =?utf-8?B?c3FsSlI4cWtIOTdrckg5ZnY2eEJuZVo5L3VsWmlsUDZPVkhOUUNFSmJnNUZM?=
 =?utf-8?B?SG1mZVh6OW5ycGpDMm9PNXFZU3NGL3BBaUhuQWJzendIckxJVUxSVlVBZXNY?=
 =?utf-8?B?a0tTRHdmODBvRWhBVlJrVEZyREhJTkhvOGMwUnVKZGhrdkJTWDR4TDcwWERE?=
 =?utf-8?Q?SgbM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e52677-d7f9-4582-ba4c-08d99dd93f67
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 08:17:45.0020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPsmmum+CF4igM0AKHGSFRUvhucnuzZEUTL84kqLCHoP0v1GJQKDwCTIbPNAROCX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4842
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/2/2021 2:58 AM, Mario Limonciello wrote:
> This command corresponding to this attribute was deprecated in the PMFW
> for YC so don't show a non-functional attribute.
> 

Now it's a generic patch, not specific to YC. Maybe a generic one like 
"for ASICs not supporting power profile mode, don't show the attribute".

Series is
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Verify that the function has been implemented by the subsystem.
> 
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Changes from v2->v3:
>   * Handle powerplay to return this as well
> 
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c               |  4 ++++
>   drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c | 14 ++------------
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 11 +++++++----
>   3 files changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 49fe4155c374..41472ed99253 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2094,6 +2094,10 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
>   	} else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
>   		if (!(asic_type == CHIP_VANGOGH || asic_type == CHIP_SIENNA_CICHLID))
>   			*states = ATTR_STATE_UNSUPPORTED;
> +	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
> +		if (!adev->powerplay.pp_funcs->get_power_profile_mode ||
> +		    amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
> +			*states = ATTR_STATE_UNSUPPORTED;
>   	}
>   
>   	switch (asic_type) {
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> index 79e565121206..8d796ed3b7d1 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -877,16 +877,11 @@ static int pp_get_power_profile_mode(void *handle, char *buf)
>   	struct pp_hwmgr *hwmgr = handle;
>   	int ret;
>   
> -	if (!hwmgr || !hwmgr->pm_en)
> +	if (!hwmgr || !hwmgr->pm_en || !hwmgr->hwmgr_func->get_power_profile_mode)
>   		return -EOPNOTSUPP;
>   	if (!buf)
>   		return -EINVAL;
>   
> -	if (hwmgr->hwmgr_func->get_power_profile_mode == NULL) {
> -		pr_info_ratelimited("%s was not implemented.\n", __func__);
> -		return snprintf(buf, PAGE_SIZE, "\n");
> -	}
> -
>   	mutex_lock(&hwmgr->smu_lock);
>   	ret = hwmgr->hwmgr_func->get_power_profile_mode(hwmgr, buf);
>   	mutex_unlock(&hwmgr->smu_lock);
> @@ -898,13 +893,8 @@ static int pp_set_power_profile_mode(void *handle, long *input, uint32_t size)
>   	struct pp_hwmgr *hwmgr = handle;
>   	int ret = -EOPNOTSUPP;
>   
> -	if (!hwmgr || !hwmgr->pm_en)
> -		return ret;
> -
> -	if (hwmgr->hwmgr_func->set_power_profile_mode == NULL) {
> -		pr_info_ratelimited("%s was not implemented.\n", __func__);
> +	if (!hwmgr || !hwmgr->pm_en || !hwmgr->hwmgr_func->set_power_profile_mode)
>   		return ret;
> -	}
>   
>   	if (hwmgr->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL) {
>   		pr_debug("power profile setting is for manual dpm mode only.\n");
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index b06c59dcc1b4..821ae6e78703 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2534,13 +2534,15 @@ static int smu_get_power_profile_mode(void *handle, char *buf)
>   	struct smu_context *smu = handle;
>   	int ret = 0;
>   
> -	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
> +	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
> +	    !smu->ppt_funcs->get_power_profile_mode)
>   		return -EOPNOTSUPP;
> +	if (!buf)
> +		return -EINVAL;
>   
>   	mutex_lock(&smu->mutex);
>   
> -	if (smu->ppt_funcs->get_power_profile_mode)
> -		ret = smu->ppt_funcs->get_power_profile_mode(smu, buf);
> +	ret = smu->ppt_funcs->get_power_profile_mode(smu, buf);
>   
>   	mutex_unlock(&smu->mutex);
>   
> @@ -2554,7 +2556,8 @@ static int smu_set_power_profile_mode(void *handle,
>   	struct smu_context *smu = handle;
>   	int ret = 0;
>   
> -	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
> +	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled ||
> +	    !smu->ppt_funcs->set_power_profile_mode)
>   		return -EOPNOTSUPP;
>   
>   	mutex_lock(&smu->mutex);
> 

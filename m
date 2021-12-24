Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FE8C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Dec 2021 04:43:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 329F310E3E8;
	Fri, 24 Dec 2021 04:43:57 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A58F110E3E8
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Dec 2021 04:43:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4zEfIPAPFlLdBIiGnEqcxlwhMi53Y9yRRvI/f74INvAGgPT2UpfK1vv2ddVF1aeOQCFGU/2BZikkuNMypk3kMSCenJTvao0VCqq/JXhN4fCmFENZJtLXAuwmmz5bsHObLj+owR7/3FcjhOu9eAHal88C8ejxUPgZApQdnmRCU2Bn7KHz1K7UpZXBjFEuHVWTskz0wOAcitQ9Nd0aWkwjKAQHmRlvMtjhHtCA+vZ9dexVeF/osQQlPESAylfHCYDRa8cZoFgJTtRXF39c2qtTkr97uoVnXeU9ZwDppNkpF/shjHaajHumdhvJv0rPc4T6xjc2bJHnqwSXFN6IEEw5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzJokcsPAL8u+dhgihkElMBFVXLvqeLxdXb3MktVgOY=;
 b=e/Ss2KJXC8yMT9uDUO+9ubD3Au7xVEUm/DRrFcf3WGTGoh0X2sPkCX7QaMoyaCzHJWIkLwoijZNW2aKeF1hbsa+XDaza1PgYYEhnFJQr3DUMo/3AIo5zGz6pHongnw0jqj/9sdmR50YL6jBhKmkfPw79u5yDQoxISay55sZKsfRYYw5qres536tOzymnZuWO9Iu3qjoIjtpgXAm7RWHw2XhfgpBZVgrtaJTvTAaEqKQySSz2+63/gT8jliaP/1sJm9vP2ypDl36LLw/1f0xJb7hRGd5DmipxBos5oTVHmiAb90c9RFwq8tIOVgGIwIBgbrRkNX8RFJuf/sk2vkkU0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzJokcsPAL8u+dhgihkElMBFVXLvqeLxdXb3MktVgOY=;
 b=Hhgvev9XrV65GlNOI7aCMfVZtdKoZyvvo+gYnsmemcR7tjdcpKYhtqH9vULIXo8baIUfNvpv5GNT18kEuJQS2m6WsCDdvK863zDekRJWqzji2N6FbjDCdDhgP5RZ1S3MIGggK6p+K7H2ofwxIPaU7D6d5hB18gG9dp1wyOmh83U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.16; Fri, 24 Dec
 2021 04:43:50 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4823.021; Fri, 24 Dec 2021
 04:43:50 +0000
Message-ID: <2de02d4d-3c68-d8cd-5685-81b1f29b170e@amd.com>
Date: Fri, 24 Dec 2021 10:13:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu: put SMU into proper state on runpm suspending
 for BOCO capable platform
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211224031644.2555373-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211224031644.2555373-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::26) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 066eb33f-3f9f-45b6-271c-08d9c697fb1a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4451:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB445149F9DE8EF04240AC2C96977F9@DM6PR12MB4451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rigR5U8fHI0YZyl70VelxyQXZjfdNCfs8Xk7l1fH8aB/fh8gK4I57FGZk1uSWZnGxYE15jssY6p1HFe51nRomNsQRnvWIOqvqNmoVJaioRn/kPIviRDWROkDM54vTAgG5SIQLFTHwCb1NVIKgFszsn3vRTbBp13O1lxlI18l9rpSGs2axk1UtKDH/KVweUQyIBBTRkKFlFdOv8kIq0kc8rYGJJjDNiUCoSoGqBB+GmqxmdAIs9NnOjIF0cgrxPGLi1GNNunLSisTvkFs1Hc6BUjog3vJTkiol58S53hBYFM2+RakFXDqokjCyhpQhio1AjW6URRsRohjwH6g1Vx+Nihss2oeY9VVmhwy8Xd8TgydOJe3M2xS5Pc3Gf2lgJ8J8O1hGYtoezj4KpQMlCyfrBb+HtmUrgbZTlPB/1HXfw6yCC2DqE+bfdUjsUPA7dMF/HAX7ZC5ExXGW0hiVRozU+FmoFHKYH7Ro1n42GyxTwqYJDl9qItqw0fkHa6+3KMz5XrcqW4sajZHCTdQ2Ijk41aAkBRSXJGfOwHzBPEfyzAJ55s1SFqLB/QvyTfDcKC02i2WWLqu/3FXBO2vRbIRlVJhpWBW88gsmSSSZiobfEFGmGSKVIfO3s2aaViilXgJvryOx9A++VWBHyGUhjmJtyDwtmTsZFQCE+rGXxK9U51k7hI9avRh1Q+9pbhhBvWFTGkx4nhTVG566PHCdvmoq+2ZuRe4mNdGarTcRY01pCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(83380400001)(38100700002)(66556008)(36756003)(6666004)(66476007)(6486002)(66946007)(2616005)(186003)(4326008)(8676002)(5660300002)(31686004)(31696002)(86362001)(6512007)(8936002)(2906002)(6506007)(53546011)(508600001)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1lTMEpVL3BTYzU4QzJCVnYyVU5KRHcvdWZmelZ3RHI5SFlUaU5meDJtU1RQ?=
 =?utf-8?B?cllZckxza2RGWkp6QkZVS2xubVQ2T3BPbzJuU1lQLzJQVnhPYVBRaXdQb0Jz?=
 =?utf-8?B?dUJEaVMxZUloaEZoTnJUb1lZOFZSeHRKNnZYYmRxYW5GOTJSdm1wR1BrM0dh?=
 =?utf-8?B?NWJiUzBFT1p2UTJWcmxXSmZrSXJtcjMrTXpSQmg3OHlBUUFXdU45VktFR2ZH?=
 =?utf-8?B?ZXVWWkg2Y3Q4cWtTajU1WkUveFBpQ1diWU84bk1mam0xaFJkQ0lacVZ0elJD?=
 =?utf-8?B?YWNwS3JRMnNSUVRDdGtHcmNDd2UrWDRvSjJYMWdJM29ad2hWSHJ6bXlRRDEw?=
 =?utf-8?B?U25Cd1JQc0RscjdOejlKZUNYbnFTM3VyVm9Jak1rVG9OblRxSHdLNXRwWnRt?=
 =?utf-8?B?SjlLb3FEQW1vTkl3cDROOGx6Mkw0T2Z5dDJpcERxZ3BEMlNKOVIzNGdqZWRo?=
 =?utf-8?B?YU9La2E3L3cxRTZlbFJScTVweVVZMndOZGlrUlUrZUk4U0U3b2RYNVRZa3JJ?=
 =?utf-8?B?Zk5xaVM3SEYvNmlxNm9xTVdpVWZmYnF5ODN4YjFubkhLMzJ4bi9XZDg0dG5H?=
 =?utf-8?B?ZFdWY1JtVW44MjQwOTFBdktSNmd5SlkwWndSWTRJYXVpZ2p1aFRBQk5ucDZj?=
 =?utf-8?B?aWoyeitkWkpHKzZDSXhCZGdkaVE0YmlVMjNlWXp3MnFVektYQTNRRVNibFV1?=
 =?utf-8?B?b0d0RkxKTlJqdFVnZVN2eUJKU2U3Y2JyK2MxQWx4S0R4cm5iTEJPc1ozSlc4?=
 =?utf-8?B?NnhwMHRyYURITXQyODBQMTNTdHpJRzAxUVpvTVd5WTNzalY3Tlp4a2Z6MDNs?=
 =?utf-8?B?dmRsNlNGV3JWNVNYVU9yYndjcUQzcE95NWdEVGtTVzZ4R2MvdDJ3L3R5alZh?=
 =?utf-8?B?TE41QWxuRWNEZm1Ea1JRdWIwRHNFdEY5RXZTYWgvR3ZncG1IVi9LV2VLM1E1?=
 =?utf-8?B?QkpaZkdwM1NYemVBdFVSRTZIaWZLdVExZHV1OVptRG9tVGZBRTJyakYwWmR0?=
 =?utf-8?B?UElYd3hOdFBndFhYckpnd3g4TkQvTWpCdnB1MzVyWHZVaHNWeFF2a3U3Vzla?=
 =?utf-8?B?OU5hUFZUbWJhQ1FpUnVxVk5CRENyNUhhWHV2eFAwODg3Y1V3OXIvTGZLOE9u?=
 =?utf-8?B?ZXdtcGVnYnFUWTVvaXRaTDFreFByeXBrWXcxV2ZPc2REd3E4blBnR3h4R1VW?=
 =?utf-8?B?YW5HZWRVNnVxQ0JxVXQ0cnlEb3pWanV2dmxlYzY4SEJWa25HRkxqZjVGZjBr?=
 =?utf-8?B?OVIzU0NSQ09vZmJ6K096bGJtbUNXNGhXRWVRRjRQa3pVQUVjSVNBTGtDVGlC?=
 =?utf-8?B?b1FNZ2ZTajdZUFduemtVTG9MaTFYMkxJbFRqSHdrZXY0a1lkNldTczVKVG5h?=
 =?utf-8?B?UklkL0JwL092d3RzQ3Z0U2xiVEg3aWp3NVFRdnRhTjdpZ2lLNVIrc0I5TlVE?=
 =?utf-8?B?bTFPVFVKQWZ6VWg4c2haRFRaN1ZmcTVNUzFEektxRytvR0dFWkVTc2lOR2JE?=
 =?utf-8?B?b2JLQWd2SkRlYUtzNXVHMS82YW1zalB6ZmNhZXNuMDhWZjROby91QjFUcnpN?=
 =?utf-8?B?ZjM3cHdta2cwOXkzeXhHckoyeERkWFRSYTF3eVJtTFZIRDd5aTJEYmlIelVF?=
 =?utf-8?B?ZXJRY3RNNWdaQjdzRnlKbmIxN1FveU1jRGZiVythaWg3bkNsSHkzTW5XMlRD?=
 =?utf-8?B?Q0RrUldnVzUxMk9TS3k2N3E2MGpFSXQ3QXVKVmNVUFdSRTNJVWhKeDZWN3dK?=
 =?utf-8?B?UjlaNlAxTTNhMXBQZkxoekREK2xmUFFIQjN3MzlqTlV3RDRjWTZ0b3dDQThB?=
 =?utf-8?B?d2o2cFBhVXh3L2owNms2UXkwWGd3dkZTTnlVc1IxVmVDcGVxUWEraHJWb1B1?=
 =?utf-8?B?cE1aQnVzYVpyMFdwU2svdDg4ZEZZN2lqWUh3OXlWMlpTWGtlRU9yc09Vbld3?=
 =?utf-8?B?d09qT1BsWW51K2N1TGh3cnN1eVVpdEd3N1pmRXFHRHRQZTJZcXZpbUx1a1Zy?=
 =?utf-8?B?cUZ6T2VpYlByb3l2UmFUZnJ2U2JJQkE0UEphQURNNGZxaUdMVUpMamY2eHpp?=
 =?utf-8?B?WlY2T3NWMTcxL0ErQkZGQkhYZUZnWGVUSW9XYzFlODF0aDRncWk2SmRhclpP?=
 =?utf-8?Q?b+h8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 066eb33f-3f9f-45b6-271c-08d9c697fb1a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 04:43:50.8590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZ33yNlvWBY+yqSuPWucOuDVnkV6D+G79XDGXITdp4lhsx3JkmNsuVA5gzJwzKAa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
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
Cc: Alexander.Deucher@amd.com, Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 12/24/2021 8:46 AM, Evan Quan wrote:
> By setting mp1_state as PP_MP1_STATE_UNLOAD, MP1 will do some proper cleanups and
> put itself into a state ready for PNP(which fits the scenario BOCO stands for).

"BOCO similar to PNP" is not correct. Mention this as a workaround. With 
that changed
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> That can address some random resuming failure observed on BOCO capable platforms.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I9804c4f04b6d2ef737b076cabf85d2880179efe2
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index e431c7f10755..ad8370b41e74 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2235,12 +2235,27 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>   	if (amdgpu_device_supports_px(drm_dev))
>   		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>   
> +	/*
> +	 * By setting mp1_state as PP_MP1_STATE_UNLOAD, MP1 will do some
> +	 * proper cleanups and put itself into a state ready for PNP. That
> +	 * can address some random resuming failure observed on BOCO capable
> +	 * platforms.
> +	 * TODO: this may be also needed for PX capable platform.
> +	 */
> +	if (amdgpu_device_supports_boco(drm_dev))
> +		adev->mp1_state = PP_MP1_STATE_UNLOAD;
> +
>   	ret = amdgpu_device_suspend(drm_dev, false);
>   	if (ret) {
>   		adev->in_runpm = false;
> +		if (amdgpu_device_supports_boco(drm_dev))
> +			adev->mp1_state = PP_MP1_STATE_NONE;
>   		return ret;
>   	}
>   
> +	if (amdgpu_device_supports_boco(drm_dev))
> +		adev->mp1_state = PP_MP1_STATE_NONE;
> +
>   	if (amdgpu_device_supports_px(drm_dev)) {
>   		/* Only need to handle PCI state in the driver for ATPX
>   		 * PCI core handles it for _PR3.
> 

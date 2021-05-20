Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA76AC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 08:33:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F51161244
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 08:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F51161244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DA216F38F;
	Thu, 20 May 2021 08:33:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB2596F38A
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 08:33:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzPtOWGqwyvcX0BkC1T7tWe3gq+iJ1J1Ul9L4RMhZa5AgBFf89NHq/IhyLLsYkZ9/ZAVNiVt+69V5M+ndgVQIxADja7btPE0hOJPEgHYk1eKVGnKaK17sY6ndjAS0bSkvyUSARc//FR5+oz7bSiHJQ1EPz62HVOyFjPSYvhuVNW93FW4bIhQSfCfsBd7uPGAxf3ylhvNM+Fg+uu+x7iXKZ9zrjzi4bR99dmmnzIpdB+gmz1nZ2Mp6L1LfjFl7OdLKMyKKuipTtLEZQF2Ap/ZgFTeUa3vhInKukyFPdX5Raqjqc6Q+KlPpP/DNzYWKBvoSF2NGQyLK4WJUlJVdQj1pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmtL6ack4IUte9mkr9KFOglU+CLGz7vHg5eUdKBivLA=;
 b=XAdQnoyu9FGEOW0b8IPT1Fr+vJr3K5ceWnKfkjeYtQdnYWT58P43GdyIwWOqKrGBosNyU6ouLVxXKXIJURHZVg2Jgs1v+/87X/h/JBT2RdXNVhSLsVkkuclV880wyw3ZhX5JGzK2rMI8OcZV2TUMV2L9/NhC4vMhCT+8aVXNw4o5GJNjgB+AfbA7RX1EEoXrGjWYU5hdowC/UqF3S4enQhNaGkidZ7aUJdKH7eKHAqH+3LQHsNkRlsVKsBHPK8czkj7kNZeMKEXqfC0lxesXN5mPGlRpCazTo26SdXxULiKSa/wJNBWsSWhLBcPBSwQQFTGY6+yclYTGxwRgSVILyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmtL6ack4IUte9mkr9KFOglU+CLGz7vHg5eUdKBivLA=;
 b=LQaj8wa0PO5rM+hXqDR6Sy2Vw0keBjMbyvLpTdwb7EMGBNeJttdmEeHX5HdwkbSiSWBAGaukulw3fZydsL1InB1gbfZNA/AbX45PMCeIcwZaPO0zUBsEU8cI2n7cvexKBswJUkxW4u8rvyKQLTJ6qvEwYx9XeR3E9Ky+2Hn5V8A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5105.namprd12.prod.outlook.com (2603:10b6:610:bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 20 May
 2021 08:32:56 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 08:32:56 +0000
Subject: Re: [PATCH 2/5] amdgpu/pm: simplify logic of smu_get_power_level
To: Darren Powell <darren.powell@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210520035722.4877-1-darren.powell@amd.com>
 <20210520035722.4877-3-darren.powell@amd.com>
From: Lijo Lazar <lijo.lazar@amd.com>
Message-ID: <b9dd5db1-78ba-4e0f-d107-43a75d5e1403@amd.com>
Date: Thu, 20 May 2021 14:02:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210520035722.4877-3-darren.powell@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: MA1PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::6) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.81.250] (165.204.159.242) by
 MA1PR01CA0183.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.33 via Frontend Transport; Thu, 20 May 2021 08:32:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88f037c6-1bff-4e60-483f-08d91b69ddc1
X-MS-TrafficTypeDiagnostic: CH0PR12MB5105:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB5105CFB478FE9E69AC9B0246972A9@CH0PR12MB5105.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:462;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BIRwGH9iz2yDdKwQ3hcy5d0GhXdTpSPzPHML1byTx3EKHLgI/toBQY60X3+qMAbiyRj6csEcF1EEzmDMaAbi0DYBUemnAY3ffUP+jW41kx7zR+ehYXTqfd4fUsBLXMfH0SViWyEjYkTtjNHQjp4UmlJimGHw9TjDigZrwUFkMbDtsc9HOI5ZVAU8ypnQeUpPrKW0U8yfEFIiVeuTFpTiGN2Aw0wNQGB/tbZKiqHHI5CyovpmWZzOjYdkMdvYVPH5OGQViyg6Zc2RDKEIe35Km9ZgmiNqDnsY0Jdgykj2re6StOTlWTX6RuV5s50XW6TKWB4vibURGH5TO274vlW2UHm3uidS+PG4AMGoAVPP1/BHeBN91ZJDBUrNLGsTsmrHyNBdjVOv+zqVIl+xEOBb/YFTp73/WY1r+aDhnsT77pjUTNnLPRwsx0hgPCH1xL1LNlHSB6mYiUuDImMKIuDkWeKBj6yOsD6u4gUonjEr7iMxfl7NDnVK5qnPWTaR7vT9sz+GJVrxZCMhz4ykqnANER20S274e3xln1en/VMjvec+IqhV94fRVPYKV6i5nLJ8kvF+ZV9rZGgXpaYWcBQng9br0T9/oS+8gyPHq6De8jQ4u6IaAmvnyVSQtU/UWYIattiTDcxOMWYPJBS1sE2XlH/LkDpZf57yGax3+FMaH6AeKAF0xCxqC0Ii5I/ExtvIP0ohux9MV6Qy+7V7zGHv5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(44832011)(5660300002)(38350700002)(31696002)(186003)(2906002)(316002)(8936002)(16526019)(956004)(86362001)(2616005)(31686004)(16576012)(26005)(478600001)(38100700002)(66476007)(66946007)(66556008)(6666004)(52116002)(83380400001)(36756003)(6486002)(53546011)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dmZuVGd3cFNVOW55ZzJvZHdKVXlBK2E2MkdiYVNpRnltajlkZzBBelFzSk5v?=
 =?utf-8?B?SjlUUFlQWmdCR0EweXNLaHhzUjBuL1o5QnhFUEhUSFAzbFd6aWVDZmFWUjRp?=
 =?utf-8?B?Ni9YWlFiUmFxU2UwczVLRWZqWU53aTk1cTF5WFFKc1p3U200K2M2YWtiRFNI?=
 =?utf-8?B?ZnRSVzRBL1J3VStNM0dPOUROdkp5bWpoZEswaENwWHVmdHZpK1hjbTZEUHow?=
 =?utf-8?B?SitEampvYXpxbjUzcmtZNzEwclBlUmVOalYzOE1EWkZocnYxV1pMUUNhMGNp?=
 =?utf-8?B?K3YrUWMxU1FaRENPazNVQUpxYklndlBtR2xpRFVYUGxycW5ycWdMeTJhdXJN?=
 =?utf-8?B?cy9hNlp1bDhSVi93UVQ0ampTekRPWlZ0MFU5NFo2WGlkWm5FNVlCRlJ3VlAz?=
 =?utf-8?B?cGRXN2xPb0R3YWhwQm94bnlZR3N3ZEkzM0E2anJkVTRzd1p0UHVFWnNvUnRv?=
 =?utf-8?B?d0hTM2NkNzJwdEwwUis4N0l1b3ViU085c0VZMHRkdHJSdXFSWGwrdUdoTmRn?=
 =?utf-8?B?TWFBeVgxaHd1M0RBckcxbDh0a1N2SVdNZHRNNWE5andOQzlyKzJmWmdVYU94?=
 =?utf-8?B?bUpCcm45Nkw3RmxOWnorNXc1eDhBUVdidTVsOU5oWVJJaENMc2dBbitaNEVw?=
 =?utf-8?B?a2FEQURQRnBjNFozYW9CYVdkWU5qcjZQRitrY2M2Y2lJL1grNXd4STB5dVRX?=
 =?utf-8?B?YmNRWXZLbmdpS28vR2I5bW1UK3EvbDlHakR3WkRsZzhJR3AvbXFIZGxweDQ1?=
 =?utf-8?B?MUJEbUNlU3F3Ty9VcWZ5cEE0MXlpUmRCaWwwYlNKalVORHdEeTJuQm1TT2JW?=
 =?utf-8?B?UUp3aElmc2RUd3JZN0Y1ME80eC8vVTUzNnptU2pyS0QvWG94STk5aTRLK2pW?=
 =?utf-8?B?K1p5VDQ4UGVVdkpBMkxyTFpYd1BCYWdJNXNnOGlDdzBWQnM5ZGZkYm5HclhR?=
 =?utf-8?B?cWFBS2xVUFZXTFk1UFVJWlpPb1JVS0x1eFRNdS8xRVhBN21pLzBkbnp5TGF4?=
 =?utf-8?B?Y0pUQVhvMkhGU1ovcnVGNmgyYjh2bCtJc0kzUkpEL29XREY4d2xlajFXVUNI?=
 =?utf-8?B?VFUxdmswU3lFTzJTcGlicTYvMjh3Wk5FSTFNQzdLVWpkOFlCdWVRTW8zME10?=
 =?utf-8?B?NGRnNEoyOCtGZTI2ZlROdERRSlJ5d0MyTkZhM0NzL2RhVktWaG5vNTYxWStK?=
 =?utf-8?B?RmwySG4wYjdCUWZGQmhRRUhPb1FBNFNVRGNwb3FzZWp2dUdkMDBKREhXQ3BC?=
 =?utf-8?B?aVRFbEVDWE1PY2p3SUZCbFFrZ0tqalpHdGVPU0g1RmtydG8vRVFFN1VnZmpm?=
 =?utf-8?B?cDE2OFpIKzNic2NXWEpPMHpOUytIRklXbTV1djBYc0R5SnZSbzhkQnFzYmhY?=
 =?utf-8?B?OXU2TmcrQU94R1YrZldyOW5zb3cyTzAvZUJFLzA3U3FkOHNUQVhmWGlHak5W?=
 =?utf-8?B?cnlJM1kzeHNjc3hCSVBjZXFCUVV0aEtOWk1La0hBeDBVMzh1MTUzdGtTME5s?=
 =?utf-8?B?T29DVGc4TlNGN09WdEwxT2pDWHA5QmNjZHFoTllBdlJGM09QK1dVRURhQS9Z?=
 =?utf-8?B?aFBlVDNNaUZXeHhIQmx3NE9kd3FCZ0JpTkx3NW9uc2RVc1M3b3o0STJ6M1RG?=
 =?utf-8?B?d1lyaFl3NmR4blM3UTQ3UlEvbEVsemFBOHlIdnZldFZVZG1YaWNkS0ZOSE1F?=
 =?utf-8?B?SlNONzUxaDYwWTZxMUovQytzWE5BUWR2TEZqRXE5dzh1K2xnc25sQWNFM1ZG?=
 =?utf-8?Q?vH4k3EV4FCAokcrMjwI0IYkrY98RGPPRfHGSGgd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f037c6-1bff-4e60-483f-08d91b69ddc1
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 08:32:55.9356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYhZWpROPgXSOQxRg1ESCPIBiYF6/piIacQVZjR85sf0QoNPHv1NFv15bSNOkXe0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5105
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



On 5/20/2021 9:27 AM, Darren Powell wrote:
>   new powerplay enumeration pp_power_limit_level
>   modify hwmon show_power functions to use pp_power_limit_level
>   remove insertion of byte field into smu_get_power_level output arg "limit"
>   modify smu_get_power_level to use pp_power_limit_level
>   simplify logic of smu_get_power_level
> 
> * Test
>   AMDGPU_PCI_ADDR=`lspci -nn | grep "VGA\|Display" | cut -d " " -f 1`
>   AMDGPU_HWMON=`ls -la /sys/class/hwmon | grep $AMDGPU_PCI_ADDR | cut -d " " -f 11`
>   HWMON_DIR=/sys/class/hwmon/${AMDGPU_HWMON}
> 
>   lspci -nn | grep "VGA\|Display" ; \
>   echo "=== power1 cap ===" ; cat $HWMON_DIR/power1_cap ;           \
>   echo "=== power1 cap max ===" ; cat $HWMON_DIR/power1_cap_max ;   \
>   echo "=== power1 cap def ===" ; cat $HWMON_DIR/power1_cap_default
> 
> * Test (VANGOGH only)
>   echo "=== power2 cap ===" ; cat $HWMON_DIR/power2_cap ;           \
>   echo "=== power2 cap max ===" ; cat $HWMON_DIR/power2_cap_max ;   \
>   echo "=== power2 cap def ===" ; cat $HWMON_DIR/power2_cap_default
> 
> Signed-off-by: Darren Powell <darren.powell@amd.com>
> ---
>   .../gpu/drm/amd/include/kgd_pp_interface.h    | 11 +++++
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 18 ++++---
>   drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  2 +-
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 47 ++++++++++++++-----
>   4 files changed, 59 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index e2d13131a432..cf98b9afb362 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -192,6 +192,17 @@ enum pp_df_cstate {
>   	DF_CSTATE_ALLOW,
>   };
>   
> +enum pp_power_limit_level
> +{
> +	PP_PWR_LIMIT_MIN = -1,
> +	PP_PWR_LIMIT_CURRENT,
> +	PP_PWR_LIMIT_DEFAULT,
> +	PP_PWR_LIMIT_MAX,
> +	PP_PWR_LIMIT_FAST_CURRENT,
> +	PP_PWR_LIMIT_FAST_DEFAULT,
> +	PP_PWR_LIMIT_FAST_MAX,
> +};
> +

Can't we keep the different limit types (DEFAULT/FAST/SLOW/SUSTAINED 
etc) and different levels(MIN/MAX/CURRENT) separate here also?

Thanks,
Lijo

>   #define PP_GROUP_MASK        0xF0000000
>   #define PP_GROUP_SHIFT       28
>   
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 13da377888d2..bd5af70ac739 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2718,7 +2718,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
>   	struct amdgpu_device *adev = dev_get_drvdata(dev);
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	int limit_type = to_sensor_dev_attr(attr)->index;
> -	uint32_t limit = limit_type << 24;
> +	uint32_t limit;
> +	enum pp_power_limit_level limit_level;
>   	uint32_t max_limit = 0;
>   	ssize_t size;
>   	int r;
> @@ -2734,8 +2735,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_max(struct device *dev,
>   		return r;
>   	}
>   
> +	limit_level = (limit_type) ? PP_PWR_LIMIT_FAST_MAX : PP_PWR_LIMIT_MAX;
>   	if (is_support_sw_smu(adev)) {
> -		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_MAX);
> +		smu_get_power_limit(&adev->smu, &limit, limit_level);
>   		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
>   	} else if (pp_funcs && pp_funcs->get_power_limit) {
>   		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
> @@ -2758,7 +2760,8 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
>   	struct amdgpu_device *adev = dev_get_drvdata(dev);
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	int limit_type = to_sensor_dev_attr(attr)->index;
> -	uint32_t limit = limit_type << 24;
> +	uint32_t limit;
> +	enum pp_power_limit_level limit_level;
>   	ssize_t size;
>   	int r;
>   
> @@ -2773,8 +2776,9 @@ static ssize_t amdgpu_hwmon_show_power_cap(struct device *dev,
>   		return r;
>   	}
>   
> +	limit_level = (limit_type) ? PP_PWR_LIMIT_FAST_CURRENT : PP_PWR_LIMIT_CURRENT;
>   	if (is_support_sw_smu(adev)) {
> -		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_CURRENT);
> +		smu_get_power_limit(&adev->smu, &limit, limit_level);
>   		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
>   	} else if (pp_funcs && pp_funcs->get_power_limit) {
>   		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
> @@ -2797,7 +2801,8 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
>   	struct amdgpu_device *adev = dev_get_drvdata(dev);
>   	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>   	int limit_type = to_sensor_dev_attr(attr)->index;
> -	uint32_t limit = limit_type << 24;
> +	uint32_t limit;
> +	enum pp_power_limit_level limit_level;
>   	ssize_t size;
>   	int r;
>   
> @@ -2812,8 +2817,9 @@ static ssize_t amdgpu_hwmon_show_power_cap_default(struct device *dev,
>   		return r;
>   	}
>   
> +	limit_level = (limit_type) ? PP_PWR_LIMIT_FAST_DEFAULT : PP_PWR_LIMIT_DEFAULT;
>   	if (is_support_sw_smu(adev)) {
> -		smu_get_power_limit(&adev->smu, &limit, SMU_PPT_LIMIT_DEFAULT);
> +		smu_get_power_limit(&adev->smu, &limit, limit_level);
>   		size = snprintf(buf, PAGE_SIZE, "%u\n", limit * 1000000);
>   	} else if (pp_funcs && pp_funcs->get_power_limit) {
>   		pp_funcs->get_power_limit(adev->powerplay.pp_handle,
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> index 523f9d2982e9..6bdd112d64cb 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
> @@ -1262,7 +1262,7 @@ enum smu_cmn2asic_mapping_type {
>   #if !defined(SWSMU_CODE_LAYER_L2) && !defined(SWSMU_CODE_LAYER_L3) && !defined(SWSMU_CODE_LAYER_L4)
>   int smu_get_power_limit(struct smu_context *smu,
>   			uint32_t *limit,
> -			enum smu_ppt_limit_level limit_level);
> +			enum pp_power_limit_level limit_level);
>   
>   bool smu_mode1_reset_is_support(struct smu_context *smu);
>   bool smu_mode2_reset_is_support(struct smu_context *smu);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 8aff67a667fa..e192192e99d0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2168,33 +2168,56 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed)
>   
>   int smu_get_power_limit(struct smu_context *smu,
>   			uint32_t *limit,
> -			enum smu_ppt_limit_level limit_level)
> +			enum pp_power_limit_level pwr_limit_level)
>   {
> -	uint32_t limit_type = *limit >> 24;
> -	int ret = 0;
> +	enum smu_ppt_limit_level limit_level;
> +	enum smu_ppt_limit_type limit_type;
> +	int ret = -EOPNOTSUPP;
>   
>   	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
>   		return -EOPNOTSUPP;
>   
>   	mutex_lock(&smu->mutex);
>   
> -	if (limit_type != SMU_DEFAULT_PPT_LIMIT) {
> -		if (smu->ppt_funcs->get_ppt_limit)
> -			ret = smu->ppt_funcs->get_ppt_limit(smu, limit, limit_type, limit_level);
> -	} else {
> -		switch (limit_level) {
> -		case SMU_PPT_LIMIT_CURRENT:
> +	switch (pwr_limit_level) {
> +		case PP_PWR_LIMIT_CURRENT:
>   			*limit = smu->current_power_limit;
> +			ret = 0;
>   			break;
> -		case SMU_PPT_LIMIT_DEFAULT:
> +		case PP_PWR_LIMIT_DEFAULT:
>   			*limit = smu->default_power_limit;
> +			ret = 0;
>   			break;
> -		case SMU_PPT_LIMIT_MAX:
> +		case PP_PWR_LIMIT_MAX:
>   			*limit = smu->max_power_limit;
> +			ret = 0;
> +			break;
> +		case PP_PWR_LIMIT_FAST_CURRENT:
> +			if (smu->ppt_funcs->get_ppt_limit) {
> +				limit_type = SMU_FAST_PPT_LIMIT;
> +				limit_level = SMU_PPT_LIMIT_CURRENT;
> +				ret = smu->ppt_funcs->get_ppt_limit(smu,
> +					limit, limit_type, limit_level);
> +			}
> +			break;
> +		case PP_PWR_LIMIT_FAST_DEFAULT:
> +			if (smu->ppt_funcs->get_ppt_limit) {
> +				limit_type = SMU_FAST_PPT_LIMIT;
> +				limit_level = SMU_PPT_LIMIT_DEFAULT;
> +				ret = smu->ppt_funcs->get_ppt_limit(smu,
> +					limit, limit_type, limit_level);
> +			}
> +			break;
> +		case PP_PWR_LIMIT_FAST_MAX:
> +			if (smu->ppt_funcs->get_ppt_limit) {
> +				limit_type = SMU_FAST_PPT_LIMIT;
> +				limit_level = SMU_PPT_LIMIT_MAX;
> +				ret = smu->ppt_funcs->get_ppt_limit(smu,
> +					limit, limit_type, limit_level);
> +			}
>   			break;
>   		default:
>   			break;
> -		}
>   	}
>   
>   	mutex_unlock(&smu->mutex);
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

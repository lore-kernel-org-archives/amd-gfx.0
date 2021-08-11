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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC81C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 09:43:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 719EB60F38
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 09:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 719EB60F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE62E6E0FC;
	Wed, 11 Aug 2021 09:43:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCD556E0FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Aug 2021 09:42:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6p0BxIQYX8i9KZ5Dlz3KtV22k5VudH6LuLIK5+aMEs2e10olxNdD4QGDNOHeUw082FwGgBCsV/PQA4pOtTN8Mf5mrU+OmQkl3AccBeLMAAHefTOuxcYg/3YjRn7jKF2sWgbWWPanIC4/N0oIimqMozk+n45fxT6Q0UXGsUwyjz6AWJVYWPSp/MZ5HePpjs7ZpOmeTPoOvI2YFvyTf96a3EXDPPE1kZqLUaVjddrxmUXS9EEnmzjpEGNtO32HNUeXqZYWcP5b7lzQYMORjI1KVhvGkrdrBWhNWKH2XL0fIkeIonM5JX0168r0Pplqj5J5CfHxrNB9NiZ3x5hW04h9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReUGp18s3/ge4aLx1VstU9+6CkJAdU/N5xrmgAdlnsg=;
 b=aCmOSnmqgU/e32fStjk8qeQdwfCu09Yf8kDZqykIWjNXa191Vz+12p+WhF2lLb1vwtImrDSrYQypkIGftVSdQOq4UIZ8RiRCDRs1cI4x5Oz1aEP/kbx1kCe5mTPQozREu9H5mxsmqvRw5lHJ7OCN3pPFrQq8Xrp+DRqxhTIAJie/JnxYn5jNDNYJ/BG4vHD0mXCMDhsO5hFuPgpckQ7n1eC8Oyp355VF542PD5mquhbN7gTsiZD5P7lgz57f2rTzOpJAbnHEvhI7KvwPTVjmBkuE9hbaWuSSn8iwuSJ4ybM3P9gn5bsn5rykSA3TIT3RHhbj4hnL305P/Yqjuf4vVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ReUGp18s3/ge4aLx1VstU9+6CkJAdU/N5xrmgAdlnsg=;
 b=3wG3uQwVHKQR5RgTw1+RSM3Dmwb+tVT6/L69amtVUSRfBQz1Q8lfewLHNcbd3O9tGHD1SpOAAZ5HYpRfx4Mh0f4pannchFU58wapMLO+dvdCcdOtrJ4kM9f2Gf9Vn1d6cI1tU+o1y+4adXkSctz3IcRk5E9OLgnf1CFlPYuvYiQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5352.namprd12.prod.outlook.com (2603:10b6:208:314::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Wed, 11 Aug
 2021 09:42:56 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 09:42:56 +0000
Subject: Re: [PATCH 2/5] drm/amd/pm: skip to load smu microcode on sriov for
 aldebaran
To: Kevin Wang <kevin1.wang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: kenneth.feng@amd.com, frank.min@amd.com, hawking.zhang@amd.com
References: <20210811083323.1084225-1-kevin1.wang@amd.com>
 <20210811083323.1084225-2-kevin1.wang@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <c45b4f5c-b24d-649d-f5d2-e6c3c9544c65@amd.com>
Date: Wed, 11 Aug 2021 15:12:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210811083323.1084225-2-kevin1.wang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0173.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::28) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by
 PN2PR01CA0173.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:26::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.17 via Frontend Transport; Wed, 11 Aug 2021 09:42:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d00d3349-0a26-4449-215f-08d95cac65d2
X-MS-TrafficTypeDiagnostic: BL1PR12MB5352:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5352EEAEAAC91214CA4E92C697F89@BL1PR12MB5352.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HR4xswQ98DK853BBN8xiIBm+ZpMWASURBq49/Uk9D3SVQ5NgHLaKGAEiRqO19PZjH+zNIsKC0t6QhSGVceoMnqag4v0CeJOL9wHELLmkc6A5IVeio7etb+N9HTRbqePJmeyeWtPjgQ4sp9+psa0aHpwR0M4q431ex1iNvrFl2eEitvrSTmhzOF6igKUaBZDhNdxs+GOeTo/iiIgDCG2Ya54f0F4all91naXzXEqTe+rXD7uvckJWa+9qOTgOqEjz1hIZ9Rv5tUYNmT8a6c6jWZoDC/KstNlKK8G3rluyBHJZ9lCwOSqzCo8ZHPDsOIfDBjO80pJL//a/4xrc+7ZazAJvGvYiBVfGB0zUXJYppkiiVBACCrGYAYb37nV4YC/SyditIVjyb64NXyIJJPnVXK+0SaZDIMSN9+D3g5diwTNkzQL8iIc62GPZKUgpTDubVUVrevFiaq6dEx78hItN3CB5UtHy4dQyZMKfoqqEBSr64w4qkYg9116KBXXPEv8KnbMdnylMxYw4aywPgqzTWhtNZANba7OKlONyDyTbk/ihYhljjkCfxKLrsaE+jaYM37c6psdeUWQxFcfPKwIYFtZ754+xKWq58J+4MOkmoFuXx+utI9hNwMRB9Tqgj1/Ibep/UFz4w0vqkg3KzS5ZHpxBvrHdFeTzv90gdEPi0VboH8C7E/xq/MuaIKpI4N3hayo4jrEBr/bcEsZa4i3Fbs2abXBH7GHkxYqS+tarrcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5349.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(478600001)(26005)(4326008)(316002)(16576012)(38100700002)(53546011)(6486002)(186003)(2906002)(5660300002)(83380400001)(31686004)(8936002)(31696002)(6666004)(66556008)(66946007)(8676002)(66476007)(956004)(2616005)(86362001)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a09CWEh4dndSQncyalBSMUV1TDBnOFVLcTNxYmJJNU8xcm0xc21mVUlzYjRH?=
 =?utf-8?B?TEJXZmk1MFZpOG9CNGF2RnBuQ3h4Si9BdWl5bXpvTlVmTVFnWEN4OEFYWXI1?=
 =?utf-8?B?cFY0VktTQUpCck1KVUthTmZiWVAxU3d4MWVMaUpDR3A4bU1kcVdUc1VHYXhs?=
 =?utf-8?B?R2ZHakFrOS9aZzRsLzdSbTAxNk9sMG9iLzBxT3NEL05DZzc4S0JwUzBnbitB?=
 =?utf-8?B?UTI3anduUXBpcjhEa0NwbmVPWWZvaGhHQWNhYmVpSGphQkFHbUMvaFMrOUhv?=
 =?utf-8?B?bHdVVVhTMDZJSWhGU1RyMk13RGVKekJpKytWVTQxSXpJT042ZW1DWG5SbjRK?=
 =?utf-8?B?NVNlVEtFMnYvM1JZSGJ6SUI1L0hjQ2pncWlXeWVkOU5XRzA0VGwzVy9odlV4?=
 =?utf-8?B?UW9DZzk0a0RlZ2cyblR1RXlRQWNET3k1aElNekViOXgyYXY1MHJwdERpaXZ1?=
 =?utf-8?B?cm1nKzVUTGVpZE45V0tTT1hUR1JlTmIwLzNXYkZzd2hNdkI0VzZkc21RNHRO?=
 =?utf-8?B?ekEwZ2VpUGNub2x3ZkFjUUNyN0d5SW9FZ2FOUm8vbDViMVRUWlVpMTcwWHRn?=
 =?utf-8?B?WGViVldWM2JtRy9ETjViQmV0MVVnMUZZM0Z3OTVtSkxIdmdabWZsbGpXSXNw?=
 =?utf-8?B?UmN4ZFgwVWpHclNQRllQZ2gwTkdsMU1rYVVKRzcyRFlhUnFIdHdNMFNvMS93?=
 =?utf-8?B?QUlMZVJwZmxwTXdyUVUwTEZiSnp6UHhDMlJZVDliTm8zMTdxU0Q2Sml1K3c1?=
 =?utf-8?B?Ym1tK1Z2aHd5Z09WczBVcVM1NEt0SVJSYmhhSm84ckI2c2VPTUVCYzZpaGZO?=
 =?utf-8?B?QjYxRkVQUVh0ejdJWVI5NitUalJIUWplMXJTTWxnYnJ2VHVzNmNqcVRTbDV0?=
 =?utf-8?B?R3BuU3FnRlhIM2lOWklrYVB3Yno5U0k5aEpHV1VUNXZBSmtRVnJPSlp1Tk1i?=
 =?utf-8?B?OEZUclJ3cjdyTHNDODBUMkVVVndudUNvamc0aXV4K25ud2w3V3lzNXlQUDRa?=
 =?utf-8?B?VFg4am0zeFNidFV2SXNhRWhpOERtTnkxTlEyb001R0JRS1ZUcE5GL0ZpWVFX?=
 =?utf-8?B?b2NSMm1mOEo0UjVBbEZScktpakdKK0J2dVgweVp0b21yaEovUWw3Sjc5Z3dh?=
 =?utf-8?B?OTBTaWc1ZG9LZ2JFV1dXNGhjOGU3MWFNZzNWS2ZaWlY5SVFNMG5TZ2FKNGVV?=
 =?utf-8?B?SGhTVjViT1J5cTlOUzBkTVJkL0FnbTNQRHJwRHdNbzQ1OHBMTTBtZTN1ekxk?=
 =?utf-8?B?ZklycHhHbld4Z1NKSE96dXBhUWh5eitadjZmcVlhelFteExjSFJ5cGx5c3hP?=
 =?utf-8?B?SXlJM2RPQjFDRyt4Q2pHaTE0UnJQNWNPSFptR2R0TENldGZtdnJlZDJrUXRa?=
 =?utf-8?B?V29tdzRKTDBlcVM4T3RqNjdkRTFydUFFSnd3OENZQ2k5RDdOb29RQmhQclpi?=
 =?utf-8?B?d3RTWHU0cTdVZFc4emxuc25ZVnFDOTRZNWtsdjRnZEswQ2VUekhQM3J6R2xW?=
 =?utf-8?B?RmFEZkwrOXRiNE1HaWtDdzVOVVdZZXFDallMcEJxUFZNMjhYWVFZSHJqOVFF?=
 =?utf-8?B?NXd2U05aNHBrRkt5L0lOOTRBYk5KdXE5SDBhdEt1NWI2TjcxSG1nckJJaDlK?=
 =?utf-8?B?T3FoZVlWaVllTDVhTmVMV3FzMkVqQy9UdlFwWURYL0Q2a2VkbTRLTnRkYVlh?=
 =?utf-8?B?WFhQdGY2TW9EcWYyYS9TeG9JR2oxVnlaTGJ4KzNVUm9Pb0pGckFzY2VRYXVY?=
 =?utf-8?Q?6CiLlawnXOikdAe7yBf1fppB/l2Tv96mm563up3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00d3349-0a26-4449-215f-08d95cac65d2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 09:42:56.5520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdqUlNNRUKx+B5kXbTNSFM76tmXpTX//WURGVWsoE98ZGBe1k7b4Zfm07gqgSW4m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5352
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
> 1. skip to load smu firmware in sriov mode for aldebaran chip
> 2. using vbios pptable if in sriov mode.
> 
> Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> ---
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 66 ++++++++++---------
>   1 file changed, 36 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index a421ba85bd6d..a0ca7e7a0903 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -85,6 +85,10 @@ int smu_v13_0_init_microcode(struct smu_context *smu)
>   	const struct common_firmware_header *header;
>   	struct amdgpu_firmware_info *ucode = NULL;
>   
> +	/* doesn't need to load smu firmware in IOV mode */
> +	if (amdgpu_sriov_vf(adev))
> +		return 0;
> +
>   	switch (adev->asic_type) {
>   	case CHIP_ALDEBARAN:
>   		chip_name = "aldebaran";
> @@ -279,41 +283,43 @@ int smu_v13_0_setup_pptable(struct smu_context *smu)
>   	void *table;
>   	uint16_t version_major, version_minor;
>   
> +	if (!amdgpu_sriov_vf(adev)) {
> +		if (amdgpu_smu_pptable_id >= 0) {
> +			smu->smu_table.boot_values.pp_table_id = amdgpu_smu_pptable_id;
> +			dev_info(adev->dev, "override pptable id %d\n", amdgpu_smu_pptable_id);
> +		}

Easier to read without goto if we keep like
	if (amdgpu_sriov_vf(dev))
		pptable_id = 0 ; // Force load from VBIOS
	else
		pptable_id = smu->smu_table.boot_values.pp_table_id;

Thanks,
Lijo

> -	if (amdgpu_smu_pptable_id >= 0) {
> -		smu->smu_table.boot_values.pp_table_id = amdgpu_smu_pptable_id;
> -		dev_info(adev->dev, "override pptable id %d\n", amdgpu_smu_pptable_id);
> -	}
> -
> -	hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
> -	version_major = le16_to_cpu(hdr->header.header_version_major);
> -	version_minor = le16_to_cpu(hdr->header.header_version_minor);
> -	if (version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) {
> -		dev_info(adev->dev, "use driver provided pptable %d\n", smu->smu_table.boot_values.pp_table_id);
> -		switch (version_minor) {
> -		case 1:
> -			ret = smu_v13_0_set_pptable_v2_1(smu, &table, &size,
> -							 smu->smu_table.boot_values.pp_table_id);
> -			break;
> -		default:
> -			ret = -EINVAL;
> -			break;
> +		hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
> +		version_major = le16_to_cpu(hdr->header.header_version_major);
> +		version_minor = le16_to_cpu(hdr->header.header_version_minor);
> +		if (version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) {
> +			dev_info(adev->dev, "use driver provided pptable %d\n", smu->smu_table.boot_values.pp_table_id);
> +			switch (version_minor) {
> +			case 1:
> +				ret = smu_v13_0_set_pptable_v2_1(smu, &table, &size,
> +								 smu->smu_table.boot_values.pp_table_id);
> +				break;
> +			default:
> +				ret = -EINVAL;
> +				break;
> +			}
> +			if (ret)
> +				return ret;
> +			goto out;
>   		}
> -		if (ret)
> -			return ret;
> +	}
>   
> -	} else {
> -		dev_info(adev->dev, "use vbios provided pptable\n");
> -		index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
> -						    powerplayinfo);
> +	dev_info(adev->dev, "use vbios provided pptable\n");
> +	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
> +					    powerplayinfo);
>   
> -		ret = amdgpu_atombios_get_data_table(adev, index, &atom_table_size, &frev, &crev,
> -						     (uint8_t **)&table);
> -		if (ret)
> -			return ret;
> -		size = atom_table_size;
> -	}
> +	ret = amdgpu_atombios_get_data_table(adev, index, &atom_table_size, &frev, &crev,
> +					     (uint8_t **)&table);
> +	if (ret)
> +		return ret;
>   
> +	size = atom_table_size;
> +out:
>   	if (!smu->smu_table.power_play_table)
>   		smu->smu_table.power_play_table = table;
>   	if (!smu->smu_table.power_play_table_size)
> 

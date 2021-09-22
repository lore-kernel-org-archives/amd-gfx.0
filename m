Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161E3C433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 07:32:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8AE61168
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 07:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F8AE61168
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 388C16EAC1;
	Wed, 22 Sep 2021 07:32:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F168D6EAC1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 07:32:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0DxrIX33G22oxySX4mWHOadXdiduTCHXupmcy8e08/2lJcyipydFHbKAeQRbtt0DuTO9Ke/Hhir4iIAvUQ+235Wj/Z5R6JElHsM/AYSUXsI+Gc7JQz7yRRKshbyBsUepjqm+lGQkhPpjh17OJr0t+YixaZM3iGPilQI8K6scldDtAfqWKnfGwM43wulQdIEsMLwx66wp2l9JhDpowf56CQOzjKBWUn0r66Ib0FvjnjtYy9YAN5BrSeeLVPSQkcvPK4+leooWz3JrBoKKF//pDlEKmkqpGLzG59pjWenzRmxGYiDMl3ZS2Wv6Zz3RgBeIxvuI4zmCm4PeawPzcVwjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=u9pP0TUyqgU6HCIfm11AJIUyg6hj0IspQ9d9rWITspk=;
 b=D+CCt0U0HNwqPok8oflmTi5YFGa1rcHmU7GSCoYRgYU+PtnobUf5GmrtE0s4sAozSmzNdJr4ibz8DO31LMLgrETOwAFtY1LH+YIuB9bS+uBZrxbex0d/3f3oFOdQ8BVwiW/Y03YsOGnrb9sTM4BjZOnSmFA9nr1JJJbt8kDgFqfXk8zyzEiowzqvdfDArohs9hxF937QtNKeQksYsLcNeacp0rv8y7EiwLROvxnOktiyg/RUjttDEsO1mUGz3z0izry7KYeSyj46X6TY3Gzsos7s975YN1f7OtGXGygzvx6gOnUeWd9jNxYCsWMqX4HKHNVQV89cYH8qnHAQ9/7N1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9pP0TUyqgU6HCIfm11AJIUyg6hj0IspQ9d9rWITspk=;
 b=RjdnYChbVn4rr3D9jet/RlZKJh069r8hCVKsxngJK7zdnLmvTbdsq3ihoASXC3kKPj/v2z6i6NGsuIpbZAtHCfo+yhaxBhe8GxRBH8xYBygZeWHkhElH3UrE3BTZ6O0pvDugVUhIpGHABF1RiHzSR+7kTfUVnyF+8kTdh05m1Iw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB3018.namprd12.prod.outlook.com (2603:10b6:5:118::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Wed, 22 Sep
 2021 07:32:53 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57%7]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 07:32:53 +0000
Subject: Re: [PATCH 23/66] drm/amdgpu/amdgpu_smu: convert to IP version
 checking
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-24-alexander.deucher@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <e82086c7-3740-2140-f23b-773e687aa85d@amd.com>
Date: Wed, 22 Sep 2021 13:02:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210921180725.1985552-24-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::13) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BMXPR01CA0003.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 07:32:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed99746c-ccda-46ef-de12-08d97d9b3006
X-MS-TrafficTypeDiagnostic: DM6PR12MB3018:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB30180D4A288A1F7EBE6B1D3A97A29@DM6PR12MB3018.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZkBZDOo8Aa09DhGzposgwsWFM2+oUmx+8jl9HQjSEIhYVmijjM4lh4LHfwSJLM3hnNz8VXafJ1N2hqmFXzoYxeyGyjd4MpOca8+qjArqrI3hGTRG0vdJbVFvEhXMQNh52uRCwrIPX6iziWpKiEKzRb8qs/Qxawu2PtIttpfRTNT4UKbfLbcxhB5QDdJesD5wyPSUy7XWN7WHkUaa9Sfm6t1MFEZPBGfdoIOjj4dFjRgG2lCwWiPuEtGkR3sBj4xAgRyYcUyI13lue6iZi5J3uJdJPeXkPPvMVEMRf6uvVajL2dui5IHiJaaj0gTx3w4kxQT1fqeOQKPajGtnAXxScHaGf3TQJhgsQd8IRqRrwR7657uhWvcDlN96tnS+yPg18/tnljN9/HnLt/KqEITkh+eXaSloFX9bSWINAjAyzAi0gvbrwOhNOD5qEXUh7BO7PWvo7u4B5TkUCEZxW1TG/eiQ/84dnknkmxftB15L1IV8C6eVGNdLfbJFRU70+ZQO8N7kcZrXV7Mt2rwSc3ojRong6vpGmlOG49LfzlQ0ZmXgvglFp1rF1vHXxXSRZC51UkTzWujUIdFhmPIdTJitkIfCpWne4G5Mo8Wd2Y5QNZyeF5V4U9KHlrkIrZEknYwScadQno2QaEwZTuosWDgwHkKt7rMB1rPYBarzgiGQdwA+RBysNoYFWAVYOoWaOg398M3EPm2kInW2fveMODzq/OSl5EI7mINNfewMuU7bk5M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(956004)(16576012)(8936002)(86362001)(66556008)(2906002)(66476007)(2616005)(66946007)(53546011)(36756003)(83380400001)(31696002)(26005)(31686004)(8676002)(508600001)(186003)(5660300002)(6486002)(6666004)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnl6bHpud1d3WFlHcHhGMDJZMWYyTlhMaDc4aVE5cGdHZHYzU0R0RndabzVG?=
 =?utf-8?B?TjVoQ0NRUUp1ZzV5SEZJQzBRbXh6dlJITWoveWJvaUt5eXduVm4yL0xvRk1k?=
 =?utf-8?B?N284cEpXME04ektSbWZDR2JOMUgzTXFtWVp0dkg1REFDZU5paTREQ0NRQXNB?=
 =?utf-8?B?SEd4ODJzV2N4UTJZN0lldi91YkJBZ29vYWpIbnVRV1VxUGVoSnp3Z3Rvb3dT?=
 =?utf-8?B?TVlhMHMvSE1zZ1FISGpGaytWckpxYnUxVkIrWlRTbmlaWGcwbk40SHRoQUhK?=
 =?utf-8?B?VFo1d2EwOWZRaXNPd3NpbFFVc2R1TU9xeCs2T0dtTWZTWkpGTHlzeE1Vd2RW?=
 =?utf-8?B?ZGtYamEyNitZTDBnUXFxZTFpYXdDQjBuM3lucmt6cmZmWTFIeVJCaGg1Kzcy?=
 =?utf-8?B?QmNGaEJCSGkrUXBEQkFUNUcvQm8wM1NqUnhSL2VaRjFMeXY0OHNTRm03YVA2?=
 =?utf-8?B?aUcvUmJ1dXFENWlqUlp0aHpyVUtGZWpFaFg1RzgxOUttRTdXZm5Ob2o2UGY1?=
 =?utf-8?B?ME9BelMzejFCdTVhTC9RZndteVpXREQrUUxNLy93b2wvcUZLeHlNT0hZaTB3?=
 =?utf-8?B?Rmtqc1k2TlpxbnZyZGc5SzU4Qnpnd2NBRFJHdlRjSlRzUzQwaU9IWWZvVU1v?=
 =?utf-8?B?LzU3NkJWeENwTVNwd3kycE1aUXl5NjkzbzhJVXdkTnc4amxqbjJLcXUrcUNk?=
 =?utf-8?B?a3B2dmR4bStETjlnL01YS1FSeXVoSGUzUXlOb2Q1dU5zL3orTy9ibytFemxm?=
 =?utf-8?B?UGxra09ySlh3cFlRaHdRc0FCWGRsTkN0NmFRUTJNQmhDOVlscDhrVC9ZbEc2?=
 =?utf-8?B?dm42ZC9Gbk91R3lsQVVZc2dybXJPTUwydlJEeGRzMGVyWEZYcnRnT0t6QjRh?=
 =?utf-8?B?OFBYMlFhNjdIekRESmtYNk94bzJuR2VEWjJYZHJ5Y3FhbkEzLzdIUkdIdUN3?=
 =?utf-8?B?elI2VG02Mnd0bmZhRWZySnZpc1hFcEdoQU1lbnZvZEdCVjR0dFdCdytWdUtY?=
 =?utf-8?B?UmNvc29peWNoM3NGbkJYNHpIL2hHSlpNWTdFdlFDdzZBaS92Ujk5TFRkdFdC?=
 =?utf-8?B?a29ya3hWVzdOWUp0VnRsTWlGK3V4WFFBNXd4NFZUTUZGVUhrSVU1d1ltM0R1?=
 =?utf-8?B?VW9pMkVEV25zUDFGQTQ3RklzMlNVTHR4M0RPSWFmcXR1aFZDMjRya0ZHb1dl?=
 =?utf-8?B?bHZMNDFtV0ttdThvOEFTelNDL2NRaUZjRXU4aUgvMDJ1Rm5pR0d3YUlnVlZn?=
 =?utf-8?B?emN1eUxlMXI3dE9YNzc1ekVjZkRQLzFSWGQvdHIrUzlLeVRDallZVVJoMDZn?=
 =?utf-8?B?eDdDY04rUDM5WUtlNWV1d0dwaS8xZGNJQk55ZGJIbTRyRENwcUpPOUNid21K?=
 =?utf-8?B?RXhCOXhCR1NQSUlaVnlLTjdDTUdqVGU4b2RqTE82UU5ycFJLV3ZxUFBvbGVx?=
 =?utf-8?B?dnUxa1R6V2UyaVU4dEhUNXdVOW1kSDJ2bVVCNzZKdmkyTG5jbUljK0RacDhk?=
 =?utf-8?B?bVJ3TDZEdXZYWVFhNlR5MSt4MkJNLzFiK2dJb2hXbGY2NWlMUGJoWExVR05w?=
 =?utf-8?B?N0N5OGdSYkxIeHdIQzIzSHBEMk8vOTVIOWtzVTc5Rnl4R3c3QWkwSEpDOHdG?=
 =?utf-8?B?ejZCS2k5WkJ0TDY2V0ZkSnV1aTVqdFN1N05UNVI1ak1ZWGdZeG5EMk0yaWRu?=
 =?utf-8?B?RE5rWno2MytBQnZtZmxBMktmQWcxeDd6aW1yczcyN2VpNTAvRjY5MmVaUEZp?=
 =?utf-8?Q?+z4fl9EDpChYYO3k53u4i3SmSZMBEitq9MYC+FN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed99746c-ccda-46ef-de12-08d97d9b3006
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 07:32:53.1683 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2sVPfvSknvMp7cv5Z9Ac52n5Ch3pDnBNEdNlr8n/11tO2M2wSrTTRb5PKYcKkShq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3018
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



On 9/21/2021 11:36 PM, Alex Deucher wrote:
> Use IP versions rather than asic_type to differentiate
> IP version specific features.
> 
> v2: rebase
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 94 +++++++++++++----------
>   1 file changed, 55 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 04863a797115..5f372d353d9d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -455,7 +455,8 @@ static int smu_get_power_num_states(void *handle,
>   
>   bool is_support_sw_smu(struct amdgpu_device *adev)
>   {
> -	if (adev->asic_type >= CHIP_ARCTURUS)
> +	if ((adev->asic_type >= CHIP_ARCTURUS) ||
> +	    (adev->ip_versions[MP1_HWIP] >= IP_VERSION(11, 0, 0)))
>   		return true;
>   
>   	return false;
> @@ -575,43 +576,47 @@ static int smu_set_funcs(struct amdgpu_device *adev)
>   	if (adev->pm.pp_feature & PP_OVERDRIVE_MASK)
>   		smu->od_enabled = true;
>   
> -	switch (adev->asic_type) {
> -	case CHIP_NAVI10:
> -	case CHIP_NAVI14:
> -	case CHIP_NAVI12:
> +	switch (adev->ip_versions[MP1_HWIP]) {
> +	case IP_VERSION(11, 0, 0):
> +	case IP_VERSION(11, 0, 5):
> +	case IP_VERSION(11, 0, 9):
>   		navi10_set_ppt_funcs(smu);
>   		break;
> -	case CHIP_ARCTURUS:
> -		adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
> -		arcturus_set_ppt_funcs(smu);
> -		/* OD is not supported on Arcturus */
> -		smu->od_enabled =false;
> -		break;
> -	case CHIP_SIENNA_CICHLID:
> -	case CHIP_NAVY_FLOUNDER:
> -	case CHIP_DIMGREY_CAVEFISH:
> -	case CHIP_BEIGE_GOBY:
> +	case IP_VERSION(11, 0, 7):
> +	case IP_VERSION(11, 0, 11):
> +	case IP_VERSION(11, 0, 12):
> +	case IP_VERSION(11, 0, 13):
>   		sienna_cichlid_set_ppt_funcs(smu);
>   		break;
> -	case CHIP_ALDEBARAN:
> -		aldebaran_set_ppt_funcs(smu);
> -		/* Enable pp_od_clk_voltage node */
> -		smu->od_enabled = true;
> -		break;
> -	case CHIP_RENOIR:
> +	case IP_VERSION(12, 0, 0):
>   		renoir_set_ppt_funcs(smu);
>   		break;
> -	case CHIP_VANGOGH:
> +	case IP_VERSION(11, 5, 0):
>   		vangogh_set_ppt_funcs(smu);
>   		break;
> -	case CHIP_YELLOW_CARP:
> +	case IP_VERSION(13, 0, 1):
>   		yellow_carp_set_ppt_funcs(smu);
>   		break;
> -	case CHIP_CYAN_SKILLFISH:
> +	case IP_VERSION(11, 0, 8):
>   		cyan_skillfish_set_ppt_funcs(smu);
>   		break;
>   	default:
> -		return -EINVAL;
> +		switch (adev->asic_type) {
> +		case CHIP_ARCTURUS:
> +			adev->pm.pp_feature &= ~PP_GFXOFF_MASK;
> +			arcturus_set_ppt_funcs(smu);
> +			/* OD is not supported on Arcturus */
> +			smu->od_enabled =false;
> +			break;
> +		case CHIP_ALDEBARAN:
> +			aldebaran_set_ppt_funcs(smu);
> +			/* Enable pp_od_clk_voltage node */
> +			smu->od_enabled = true;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
>   	}
>   
>   	return 0;
> @@ -694,7 +699,7 @@ static int smu_late_init(void *handle)
>   		return ret;
>   	}
>   
> -	if (adev->asic_type == CHIP_YELLOW_CARP)
> +	if (adev->ip_versions[MP1_HWIP] == IP_VERSION(13, 0, 1))
>   		return 0;
>   
>   	if (!amdgpu_sriov_vf(adev) || smu->od_enabled) {
> @@ -1140,8 +1145,10 @@ static int smu_smc_hw_setup(struct smu_context *smu)
>   	if (adev->in_suspend && smu_is_dpm_running(smu)) {
>   		dev_info(adev->dev, "dpm has been enabled\n");
>   		/* this is needed specifically */
> -		if ((adev->asic_type >= CHIP_SIENNA_CICHLID) &&
> -		    (adev->asic_type <= CHIP_DIMGREY_CAVEFISH))
> +		if ((adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 7)) ||
> +		    (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 11)) ||
> +		    (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 5, 0)) ||
> +		    (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 12)))

switch...case looks better here

>   			ret = smu_system_features_control(smu, true);
>   		return ret;
>   	}
> @@ -1284,7 +1291,7 @@ static int smu_start_smc_engine(struct smu_context *smu)
>   	int ret = 0;
>   
>   	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
> -		if (adev->asic_type < CHIP_NAVI10) {
> +		if (adev->ip_versions[MP1_HWIP] < IP_VERSION(11, 0, 0)) {
>   			if (smu->ppt_funcs->load_microcode) {
>   				ret = smu->ppt_funcs->load_microcode(smu);
>   				if (ret)
> @@ -1403,8 +1410,14 @@ static int smu_disable_dpms(struct smu_context *smu)
>   	 *     properly.
>   	 */
>   	if (smu->uploading_custom_pp_table &&
> -	    (adev->asic_type >= CHIP_NAVI10) &&
> -	    (adev->asic_type <= CHIP_BEIGE_GOBY))
> +	    ((adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 0)) ||
> +	     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 5)) ||
> +	     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 9)) ||
> +	     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 7)) ||
> +	     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 11)) ||
> +	     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 5, 0)) ||
> +	     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 12)) ||
> +	     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 13))))

Same - switch...case

>   		return smu_disable_all_features_with_exception(smu,
>   							       true,
>   							       SMU_FEATURE_COUNT);
> @@ -1413,9 +1426,11 @@ static int smu_disable_dpms(struct smu_context *smu)
>   	 * For Sienna_Cichlid, PMFW will handle the features disablement properly
>   	 * on BACO in. Driver involvement is unnecessary.
>   	 */
> -	if (((adev->asic_type == CHIP_SIENNA_CICHLID) ||
> -	     ((adev->asic_type >= CHIP_NAVI10) && (adev->asic_type <= CHIP_NAVI12))) &&
> -	     use_baco)
> +	if (((adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 7)) ||
> +	     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 0)) ||
> +	     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 5)) ||
> +	     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 9))) &&
> +	    use_baco)

Here as well.

Thanks,
Lijo

>   		return smu_disable_all_features_with_exception(smu,
>   							       true,
>   							       SMU_FEATURE_BACO_BIT);
> @@ -1436,7 +1451,7 @@ static int smu_disable_dpms(struct smu_context *smu)
>   			dev_err(adev->dev, "Failed to disable smu features.\n");
>   	}
>   
> -	if (adev->asic_type >= CHIP_NAVI10 &&
> +	if (adev->ip_versions[MP1_HWIP] >= IP_VERSION(11, 0, 0) &&
>   	    adev->gfx.rlc.funcs->stop)
>   		adev->gfx.rlc.funcs->stop(adev);
>   
> @@ -2229,6 +2244,7 @@ int smu_get_power_limit(void *handle,
>   			enum pp_power_type pp_power_type)
>   {
>   	struct smu_context *smu = handle;
> +	struct amdgpu_device *adev = smu->adev;
>   	enum smu_ppt_limit_level limit_level;
>   	uint32_t limit_type;
>   	int ret = 0;
> @@ -2273,10 +2289,10 @@ int smu_get_power_limit(void *handle,
>   		switch (limit_level) {
>   		case SMU_PPT_LIMIT_CURRENT:
>   			if ((smu->adev->asic_type == CHIP_ALDEBARAN) ||
> -			     (smu->adev->asic_type == CHIP_SIENNA_CICHLID) ||
> -			     (smu->adev->asic_type == CHIP_NAVY_FLOUNDER) ||
> -			     (smu->adev->asic_type == CHIP_DIMGREY_CAVEFISH) ||
> -			     (smu->adev->asic_type == CHIP_BEIGE_GOBY))
> +			     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 7)) ||
> +			     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 11)) ||
> +			     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 12)) ||
> +			     (adev->ip_versions[MP1_HWIP] == IP_VERSION(11, 0, 13)))
>   				ret = smu_get_asic_power_limits(smu,
>   								&smu->current_power_limit,
>   								NULL,
> 

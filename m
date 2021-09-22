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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1739CC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 08:18:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D11416113E
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 08:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D11416113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69F0B6EAD6;
	Wed, 22 Sep 2021 08:18:31 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 922F46EAD6
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 08:18:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/l8nQh8bA2qQCXLHnMwc6CQtNNwazQoauV2LOQM0JvH9VoqEh8ne1LHIyQFdMDGXTGD3Nw31iuSGGVmusrCob659VPZcgpX+OEJwmVjrOQmOZ7jzpqTJmpb3rPAM84TfqpRcwtK6azdgWLoacb1fYOHFRJTvZ1RaLPKzifFCn2YMoP0KxntAqbLEbWyM9KlEwAa3RmNifN6TvKlO6Qn9f9m58y1F1xcW92yQ/lrlHTZJrJEdxQbStMZ5rBiw6s/scOP+73tHm2pMkFBj1+WvA6FAsytyqCKZccWBiq/Ut/KMwKVk6uxBF4K6pbTqZvo+pl8LqzOlY0Q6Pdf6BP5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=lD/h+8DS1QHuSFQko1W5+ONyLn8p1GSaoXFNi+4kgEA=;
 b=GgrqULzWnyCOQyQBJN0Q5CmquvpTQ95AbJe33Ye2fQOjKJfR87PxzJnP2C9Oh+cSonhfmAICfz3++oZteSfqH04t1CoMjsMLkHwzzD3z4UkPQrbRS6NWYCjzRkMnX2BR66Vzn/rSFuzTRK6iLjJ6kOqJwLDjzRH6+2rhbe5rkzzKlQt9Fc5tVATh0CL112uu3mldKVKzlvKBKpFYXlegLOchkatBq17wX9aBKYmxDMAe1ryx5HKMl/hOyj3IffFZPFF9Wfr0cfZfNjg5kDOxAfx0+Xek22DHcI5xmdjs7ox/6IiXqhHI4HRKXPYjtJA3TiT+aEIGtqHRJZFDZB2FUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lD/h+8DS1QHuSFQko1W5+ONyLn8p1GSaoXFNi+4kgEA=;
 b=DWva4bN8A55poItWLxKvAGSRFmesJnkg6QiC5jGgnUS7wPLHu0uPRGf40n1kGiP5HBBn9u5Z9xpdsYK2JhrOl9CTkQ8lpdQQf9YCTyhEdJTpVvvgevGFRjy4y4u2GkqSKu+JoND7eE+Xnf1d5AX4K08w1z8EYcO4CQw9L1/Kvho=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR12MB2438.namprd12.prod.outlook.com (2603:10b6:4:b5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 08:18:29 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57%7]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 08:18:29 +0000
Subject: Re: [PATCH 45/66] drm/amdgpu/pm/smu_v13.0: convert IP version checking
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-46-alexander.deucher@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <e0d26fe6-e1d2-b716-e664-c11b5e20989e@amd.com>
Date: Wed, 22 Sep 2021 13:48:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210921180725.1985552-46-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::23) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN3PR01CA0114.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:96::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 08:18:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54bfa828-293c-497f-3cd9-08d97da18f00
X-MS-TrafficTypeDiagnostic: DM5PR12MB2438:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24389A3D92647F37E0F53B6B97A29@DM5PR12MB2438.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3rEIFqY4iXKr5XlLZxgcOgN4GDoOXq90K7o/u24vs9hYgXB7nA2Qvh139vrkHHytHACAQOMmMykVYs6f+1Rr8PvSWPc6NIM4Neoa3ayJ6pioop3frMwg1CgmaY3pEZ1SDpy5YqbtH6pJ9EEL5Z4gFV0Rm91/7N8i0ZpWv11FnxqINpq3RQdT75qWHwJUWVQMDZI+Qk6FYFObJqlCwERUv8YiU+VYpeUVTg3EPlxsrCJF0Vsjz9H5WVRG98VcD9mjVXzZ3ur5CXyS29lZBgT2AHUdVh/tJ/mTn6cZIQe259bKnPWRotDiT9SZ9D/KQ+CVCGiWEdNinYmg6hi0RjIjd7+qIgzzJyRemUxemUR54xjVhawOTfFyQkfRa3eeA5ImBNVJKOhp50Xw1yOrS/1eU5s7/39/Iz0xKFnYSvPUJM51zHwg4gbgHJy4mBe4UDcF7cdVOfASjng6iXZpki+x7edLgoj3liLCqlDzKqRM2sh15+AA9Aiju3+1cZV74FqN/HcSS/tmvKgFW6vvKeWKyWDLXg9Ts+Fo5kfDN4Q55Wj7cdN/TziErPALxFfbnB6AenewVAvJggIR1hEQh0BLCRZ8Dz439EJkSIaHBCSdiwCaDbB1Rq0fwxFJHO7VQMXV7pXWbWOFbawwiyM/b8LXppMcT7f/M2OgxxvW8wqpncgHrQVJZTrMTZGfyyFVU2GrfI84arNewDAIOdbYr0yKjwe72abdUgH/mAm8hCKefeQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(2616005)(53546011)(38100700002)(956004)(36756003)(6666004)(316002)(2906002)(16576012)(83380400001)(508600001)(6486002)(26005)(8936002)(31696002)(186003)(31686004)(8676002)(5660300002)(66946007)(66556008)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlRmWi9vbW4yTVVWc2h5ZENPQ1QvbjdxeVpHVVdjdGo5bmRmSXBibU1QOURx?=
 =?utf-8?B?TjdRd3Q2TkVoMTJxbG5mNURhWW1jVHAwTDQvZ0Q2S1NkR2R1ZTJUalhET0pV?=
 =?utf-8?B?UFM0OGJoaHYrM3NtcjRYM2R0RHlZTWpFTzJmQ244blM5RWZQQXRWdFhucUEv?=
 =?utf-8?B?R29XczJpNEo4cTNRUi9vVDRCYVFJVTVlOWIrV3R2enZFKzNCcmxzTXRUQ3RO?=
 =?utf-8?B?QW1ScE9JVlU3OFBKU2V3dlFvdW91UTVaWmxTZXhvRzl2a0NUNWxoMGdWeHRY?=
 =?utf-8?B?KzA1UDNmOEgvV1luZjZja1JweEs5T1IzdGZpRlZkN3YvK3VnTFhYRG43WUNO?=
 =?utf-8?B?YnBkSGVmZ21WTTdueTIyNWlnOHAwQUhMOTR0Z1RhbnRsanM1NlZIbi85eklB?=
 =?utf-8?B?ck5NY0VLdlhkbktlMXlXQlNxUUlvTEhKZzVNbCszY2c0LzBLSjVRWmtHZUJ0?=
 =?utf-8?B?eXgwT3RUbGE4Y1B4aDZHNTB1OHY0VEN0M0xvQ04yNktzcHB5UjVYOUZvZ0xu?=
 =?utf-8?B?MXYvdHF4UEFxN0x5K2JvRy9oMHlibHFMREJBbU9VTHBEQi9oclZiMkl6Vjgx?=
 =?utf-8?B?ZTNNTXozckoxcmJ5c1Bsb2wrSDc2MWVMSHZBbnJiV2h5M0xtVEE0TWR4b1dV?=
 =?utf-8?B?Nm9QL2FOM2FVUkQ4Mm05cncwN1VRMGVTczRHSW4xa1ovZTJrYWdXNnlIUG41?=
 =?utf-8?B?Wm40b3N1SDhRRXdYQUl1VHE1UXhObUdzWWlXTzlZVWZvU2ZaYzZJcTA2R09G?=
 =?utf-8?B?b1FkYnNweUNkR3pZSG9YU1RobUtUSExWVXM4aG8yK2p6MXFzZVcrLzRXTHNr?=
 =?utf-8?B?Q0Rqb2lHV3NYeU9ybHljbVlNMzVOOEFTMUFEc2lYZzdkS0JMUm11dE82aXVM?=
 =?utf-8?B?bzFLMERnN3hMWXhsMzVYS3luV1BQVi9xUDF3WngxNkkyQVVEZ1dZTWcyMVB6?=
 =?utf-8?B?QXVCaGZWd2wxb09DVXUwbnB1NG9XWHZUeW5YZEdoNTF0WHE2akd2SnRnYk9M?=
 =?utf-8?B?TFV2dW9Ybm5hZWtoQ0lZeVpqNnlHNFMvWGZhTGZSY2huN0p2M2dObHZGeXBU?=
 =?utf-8?B?Z09BTVhNQ3hudm1pZzJoV3p3aFlEbnhuNjhHeVk4NHZhY01MKzI3Z0VJU2N4?=
 =?utf-8?B?N1N2emlaRTUrUUVsU2V4YmFOTlIxTmdqVStMaVdNZHd1R0pkUERDOU1NTW5B?=
 =?utf-8?B?cnc0R3F2Um5hb2QyN2U4c0dSMDFRNFhKTUhHNmpnWDF4OGc2VWtwOFF2RFY3?=
 =?utf-8?B?bHlTaHpjVXpZK1AyZDVydFpac01iRXFNS0NKcG5tK1VUWVkwdVNyWjdzN0Ni?=
 =?utf-8?B?d3RmT01FRXQ5eHJ2MFhkNEl3WUhuMFlyY0xPUzhxWmdVYWNqcVNDa2RYNHZa?=
 =?utf-8?B?N24wdDlrTW9WVEhueFY4WHlIWHZBamYzSzdvczZjQzZBam50MjdFbWphQmJD?=
 =?utf-8?B?UGNsRllJUlpQWVZ0M3hzYXRXOGYvamtYQTJmZkozK0RBL2podUVGV3ppTUdX?=
 =?utf-8?B?VXZtNVF0bHhDRFRCQU4xMTlsNkJDQTFYZ1BFL21oVVkybThlSUdOa0NEQlY1?=
 =?utf-8?B?VTcyYTNrOFpodEZGK3ZUZVZSR2ZOR1UvUC9ma2l2ZzZQNytURnR1bURKOG5r?=
 =?utf-8?B?MmNwRmpGRVZvNGx4cGRzSkFZR0tjMXM4NDJSZDc2QTRSZHhBRXFZYkdqUnZI?=
 =?utf-8?B?UzVITHljMjV1RG9ML0hTT0hXejN2TVVhL3JpU0Nhc1Q4ZFVJMWpWaGVETmpl?=
 =?utf-8?Q?kiUmqoT8qnFHWMhir+yxQDEhac0jKDtexDL9mrp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bfa828-293c-497f-3cd9-08d97da18f00
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 08:18:29.3119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rya/ZCOuc0XvMAIstNiaZvN70yS35UZelcgfu+SBFzffMj2TzpyPU2tXF9XYOwj/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2438
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



On 9/21/2021 11:37 PM, Alex Deucher wrote:
> Use IP versions rather than asic_type to differentiate
> IP version specific features.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 22 +++++++++++--------
>   1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index a0e50f23b1dd..08f3cc809fc6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -89,12 +89,13 @@ int smu_v13_0_init_microcode(struct smu_context *smu)
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
>   
> -	switch (adev->asic_type) {
> -	case CHIP_ALDEBARAN:
> +	switch (adev->ip_versions[MP1_HWIP]) {
> +	case IP_VERSION(13, 0, 2):
>   		chip_name = "aldebaran";
>   		break;
>   	default:
> -		dev_err(adev->dev, "Unsupported ASIC type %d\n", adev->asic_type);
> +		dev_err(adev->dev, "Unsupported IP version 0x%x\n",
> +			adev->ip_versions[MP1_HWIP]);
>   		return -EINVAL;
>   	}
>   
> @@ -210,15 +211,17 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
>   	smu_minor = (smu_version >> 8) & 0xff;
>   	smu_debug = (smu_version >> 0) & 0xff;
>   
> -	switch (smu->adev->asic_type) {
> -	case CHIP_ALDEBARAN:
> +	switch (smu->adev->ip_versions[MP1_HWIP]) {
> +	case IP_VERSION(13, 0, 2):
>   		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_ALDE;
>   		break;
> -	case CHIP_YELLOW_CARP:
> +	case IP_VERSION(13, 0, 1):
> +	case IP_VERSION(13, 0, 3):
>   		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_YELLOW_CARP;
>   		break;

Ah, there are two versions. Commented about something similar in another 
patch. Please ignore.

Thanks,
Lijo

>   	default:
> -		dev_err(smu->adev->dev, "smu unsupported asic type:%d.\n", smu->adev->asic_type);
> +		dev_err(smu->adev->dev, "smu unsupported IP version: 0x%x.\n",
> +			smu->adev->ip_versions[MP1_HWIP]);
>   		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_INV;
>   		break;
>   	}
> @@ -740,8 +743,9 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu, bool enable)
>   	int ret = 0;
>   	struct amdgpu_device *adev = smu->adev;
>   
> -	switch (adev->asic_type) {
> -	case CHIP_YELLOW_CARP:
> +	switch (adev->ip_versions[MP1_HWIP]) {
> +	case IP_VERSION(13, 0, 1):
> +	case IP_VERSION(13, 0, 3):
>   		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
>   			return 0;
>   		if (enable)
> 

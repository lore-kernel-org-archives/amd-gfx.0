Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31185C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 12:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1E9D10E887;
	Fri, 28 Jan 2022 12:13:15 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47E7010E887
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 12:13:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dppf8VpmMoyrp2UraxN1eQKK1np/YSIgJMbsVrSm4h6CVx0pvPZ+X4BS1fYnOi8PZfHtcphJi77Hp0aj6ZNF9FTwfd7MzOLEmhzpF0y23jWYXXsQBbPOxBtVrvrIYtLiLyTstEuBqmE1p8HgvIK9d9t7OYfw22j86TRbRkCU4FmHMHlz99wA0cZTphh4JK1TqnEy61/nHsRj6RrQJpcjSUMpOPcM14Frlc1Ii3/hkiMOgi6kmfiqrdQIzT9eiUEjaxNQ+k3CZr4SiAmdDBQtHzBL1Xm6GFAZAJYzF0sJQnK1SZ8gsnc2J7x85lHNb20XrSeSwu8eMmEP8upwO9U0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byXtk49d5iwOaiKwvKxJwMLT9XHSBvAaaZwPblcazBo=;
 b=PNO8+MZXuBKrztM4F/qMwIPchS6UsSyh/nmITfoaANr4s+6NFeUFREl/3bEHTQxUwH3jv+FuZyZXB/dBK/ojGszR0N08lBiZ25m4hsVovNIrL4BQb+jbHi8G94Unx3KsfXkeq/gPzrsfq3z72DcMIRBSA7mdgvwtTj1u+mz/dY0qJAvFFyt4v8/pOEIOjbUjEHEN70R45pIAqUO1SmzB9+OhiHrDjryAo40eof45jxsDi5RFJLfcvA6F4iyg68g7fFzpIXCsAYIHf7DYcS5dyigi6AC4HyOdCVdTFvw9V4fyd+YCNSrrDF+6cMduYXh1tUwXlyjOdWEtaHmpAem5Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byXtk49d5iwOaiKwvKxJwMLT9XHSBvAaaZwPblcazBo=;
 b=egRbBtG0v8EhM7io8gynLCAUf9NLDTFz9QKDVhJCeepbj1+ypijW4cADlF1GLr2XisLWh8SdIXLZ3VeJYxOHh1nAyac9K1VLU+EjJk3cXtJXnyDRg37wujO2IXVQVMIuWUlexNkREd3EWipDzsp978BXUPGKQ08eY6O7Gcff7KQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN7PR12MB2772.namprd12.prod.outlook.com (2603:10b6:408:26::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18; Fri, 28 Jan
 2022 12:13:12 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b%4]) with mapi id 15.20.4909.017; Fri, 28 Jan 2022
 12:13:11 +0000
Message-ID: <42ccb281-36fd-9793-f6cc-99ae21d3a160@amd.com>
Date: Fri, 28 Jan 2022 17:42:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu: fix a potential GPU hang on cyan skillfish
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220128104323.1565796-1-Lang.Yu@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220128104323.1565796-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::22) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2de56848-1406-4b39-8c4d-08d9e2578d6b
X-MS-TrafficTypeDiagnostic: BN7PR12MB2772:EE_
X-Microsoft-Antispam-PRVS: <BN7PR12MB2772B6579FBCCF5761A15F5497229@BN7PR12MB2772.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AfCvdJtYbMLuhbGc3IzJmPuvJQfbr39MvtEhv6Osu3WOwpmUdMOG9JW1+dLhHUqwjJybkZGAd8BceaOBhMvEr4Ae3E8NvfPcOu9kSmSgBAKrvE+NhDZTmSXYLk4EY2FpoS2Lm+2Q8Ii8IRRv41mcgzwHK2EdkQI2N1AnlfaZouyZBEotbEj5X2fG8NhRMEyY7IGvt641MWReiqexoYCyNmRnRASDyY57wknJWa+o3JvWUIGi8BKoAkagy2Oqb/hDIBpShKZ3P+/n0ZpULq07EDPG6Dp3OJtUrRuQ2Zh9z5Bx3/QWeLKTS8Wl2/s2Jbvss2st3BLgqCpgzqiHB8RY5Ywt1bwTjGuJ1P7U4jGpYAwfqyh9oPqrtjEPMd5HI/erBfB5cTTYhJJHyBacx7SVynLmabR+1F6kVC2vXOUfFoWr2jNwtP8fFKGGnOhltreBbuOaQ0xrSgllM/0EvFvtu2S5xPEJbc/SXbfE8avRBbaXN9fmXmXOhTUGeh+apn0vXM0ZUtVtb3H2W4AhItzKUWlu25Tn8nAGqBfbSLCNroy1ejyD5AdroWAtErdnqvp4up5l890swiNFShitzZfA0ShQQJijPvBJQvlw9bB+VpN4AqMO8NNUJIvy74+dhLDQ4llEyFsSWS/MAr6G55LowN2wsm0vB2b7emFOvlVdc4sPtw0U/icCh4573r4n+HySdPsxrbUjtAYJqLmmHrHcWhgpO1fHKXcCucPCR53cMH7N0YIcLXcsRj/vLGyAx1YZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(66476007)(31696002)(66946007)(8936002)(4326008)(8676002)(86362001)(6512007)(5660300002)(53546011)(6506007)(26005)(186003)(6666004)(2906002)(2616005)(83380400001)(54906003)(508600001)(36756003)(38100700002)(31686004)(6486002)(316002)(43740500002)(45980500001)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWg2Yklib2RadHEzVGZKTlpuNXRoMU1uZ0lyTCt6bkhxZU9ETDZ3dDU5ZGQv?=
 =?utf-8?B?MzdsZXZZb0FzbHZpQk4rSXFCNlJYSklqS3RkNWZ2SzJVMmZHVzhXcWNjVTBX?=
 =?utf-8?B?cmNiRlcvV1dTU2tPZ0JMMGUycGVlT1dIR2tKYjZhNTdqc0JDVTBYMVRqWUZ0?=
 =?utf-8?B?OGphZGZWMmFmSWlyTFhzVlkvMHJxTHlHdnk3Mit6U1J5eWpjMGdmYUp5NXVW?=
 =?utf-8?B?aUk3ckYrYUcybmVlcy9zYmRiL0VOcGtQbUxZUDBKOTN5YU1QOEk0TTlpeFZN?=
 =?utf-8?B?bGcvTW9NRmRESkR0cUdNWU95MFE1djJxS1FzK2hFOFVSNkxmUWRJczd6Qnow?=
 =?utf-8?B?NFZncW5JV2pSbG1QTWd6MDgwbmxVMjhPbTlFajVKVktzS2hQWVRCRkx3NzFQ?=
 =?utf-8?B?ejRkWWNWSTRZT3hKRFFzQkhjd1JMV2ROd2FXSUdoQTJ4WEwrMXJFNUx5OWti?=
 =?utf-8?B?VFpKLzVSYjRFdERvSzgvRzIvbVo3SjhxRnNwOGQ2dEhhaHV4YmYvN3c0MEJD?=
 =?utf-8?B?MlhaT3JRa1ArbDQxZ0xNT1UycXl4SW0xN3NWd1JDVDJiOGg3Tk8zUGhwV1RN?=
 =?utf-8?B?c0NwUTFydUZzZ2txS3BqTDVBZVkxSldTVnc1d244MFVYQ05uRXM5eFc3dEpZ?=
 =?utf-8?B?ZXdWNFFySW1yNVVwWW0ySzBzRitKazk5SmlGb09pdE5uZ05NbGRrbmh6M25y?=
 =?utf-8?B?OExsUVJ3eTFhMVAya0xDMkR3NndYckhqcjNxcEgvS2lJdUdMUTR2S0ZiSnAy?=
 =?utf-8?B?SVZDU0ZIa0JGYU50NnNnNmdvd0FBVmM4RFltdFFDSVJHNWxGR2E5RzloZUFX?=
 =?utf-8?B?RXNMRys4ZWJ0blh2QmZwQTU1MVh3RFQyZk5WN1FkVlZkamNWVkwwN1hTTSs5?=
 =?utf-8?B?L0lReURGUld2Wm1FbkF5YlMxbjV3MmlrY1lIVjkwWWxaY3hHU000MEIxaG83?=
 =?utf-8?B?QnZkcThQaWQ5MTUzSXh4bFNRME1KZ2t4VXp5ZnYveE5MZ3JWaWExUExnb0Z4?=
 =?utf-8?B?L05GeXlWN0lRYjJOWWlrVHVYRkh0ZDRlKzFBQWVyMjUxT09JTmNYcWFvWSth?=
 =?utf-8?B?Ym1JSGo1OG1YV0V1S2VDSnRVRVpsTnRZRTRvYVlhbUJ3aWcya1lXcGpPcVZj?=
 =?utf-8?B?dkpLYTAza3RnMTlGcGpzTTV4U3RETkZINlI2S01RQlRwRDBLSkI2YVoyOUhz?=
 =?utf-8?B?Ry81MGR4Y1JjS256RzBwbEpWTGNrcG1mM05Wa2tzbW9hTUU3TnlXUlFNalZz?=
 =?utf-8?B?eC9JdWVMUjR3cUtqcmVKSTJ4cjdUQkhWeTVIYkpVaGs2dVBmVE8raG1IZXNx?=
 =?utf-8?B?KzVaZVQzZTZxSStweXhJWkhlZEdPQkZNR2VOWDVWbXdMaHFZSTZycUF2ckpF?=
 =?utf-8?B?b0lmcCt2V2loUkdNaDlHK3lsOVFGSVg0WmE3OC85SEtza2JpKzRUTm1TRVdB?=
 =?utf-8?B?dFpxQmM4djJOYVhzaW80SWhNMkorb283RzNtQWNGRmx2VlBFK0JvbGRhakhX?=
 =?utf-8?B?OFZNNVgrZVpCcGJWWWR5Ujc1Y3k0bktBclNpell4Z3IvcTBIdUpOdTBCTGFx?=
 =?utf-8?B?QjAyRGF6NjVKZ1V1UU84bFlFYlMxTm1iOGxYY0kwSTd6dW5SZDlvajlkTnFh?=
 =?utf-8?B?bUpsaVVYVkltOW1WTXlFQW15a1pSRE8wRmxtT2twZ1pqL3JxWG4rY3praXVj?=
 =?utf-8?B?bmh6bUVWSnVXdEtxVm9kYWpQazB0aVJCNi83bEM0MmF3NFhwNEVLN0V4eFVR?=
 =?utf-8?B?dDRCOGR6bGI4bXRGOVpwV3NWQzZrWTlVZGJSektHU2dPTHRwVFVOK0FQM2xZ?=
 =?utf-8?B?OFdDRnJ5dlJDNWFSaFVadzN1ZFdNVEFzMUQ4QndqSlVUbndJaEZGVFhJblNI?=
 =?utf-8?B?cXdCaXVjQ1JDTllreW1yN1hLUU95SVN5QnRIT2RlZ1NCYzNCVXI0cGVBb2Qv?=
 =?utf-8?B?UDkrNnQxNDB4dDBTekVWMzdWOThLNnNOU2d5Q0VMUmU3a01HMmRjang1dHIv?=
 =?utf-8?B?RFoxQ2p4UWJnZnhRZ1BqYXZSRnBxNHdnOVRMY1k3MTJhMFc4WHZCZm42S2Rx?=
 =?utf-8?B?b1NPTEZGZGplY2t5NjZwVDRyTm1HdHVIOWRsbXUyQUZiUkhhK29PV1YxR2p6?=
 =?utf-8?Q?ASaY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de56848-1406-4b39-8c4d-08d9e2578d6b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 12:13:11.7772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MR/ETHTKYKIYdUDbkezPzAasuoZoOnPcG7MvHXesjV6lxcVZ8Kx5HlF8uSdkYi0Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2772
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/28/2022 4:13 PM, Lang Yu wrote:
> We observed a GPU hang when querying GMC CG state(i.e.,
> cat amdgpu_pm_info) on cyan skillfish. Acctually, cyan
> skillfish doesn't support any CG features.
> 
> Just prevent cyan skillfish from accessing GMC CG registers.
> 
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 73ab0eebe4e2..bddaf2417344 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -1156,6 +1156,9 @@ static void gmc_v10_0_get_clockgating_state(void *handle, u32 *flags)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 3))
> +		return;
> +
>   	adev->mmhub.funcs->get_clockgating(adev, flags);
>   
>   	if (adev->ip_versions[ATHUB_HWIP][0] >= IP_VERSION(2, 1, 0))
> 

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31215CDB46E
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 03:35:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F3E910E3B7;
	Thu, 12 Oct 2023 03:35:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E8AA10E3B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 03:35:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmlXee92DWI9BDIJTI8MCbuBHd0rnJ7Vx7jCCX7v/MZiyQsndrrFTSSRKMtAdDQbJTbh1/pcPP0/ff9gieFgJyktiD4uvzV1ZgMF3T63ukdnwq4A3LI1iBTF/ZKI5J385B2qrrZpIM3jpgpar0xRCsSgkotbmpS/qmMsKe8ScHobSZ93uOxlsEllFHnN5Nv0N8NYls6R2AR9UOXi0EMQmvw7rD8aJdfiiKsXJ+KT/6PuOxzOaQTNwZ+NNrVNLfEnborgion23lHR2D40Ma4We4larzRziPBenY0/02aOD9aJU2+Qbc7TUZ+Ew0y8NLJsJO41SxzlcqV4sUB+X4FhPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiX49Q6NGm7qTVpaQEAg01iKgwAPxdFbQiu4p+gBaEs=;
 b=RXh31RBqfcyb4MkSM+z/4l1uCI6P0QkeuAwgAK4sb5ZawFYLsosTRu45h+X8FFLUtMf6LMqvrSS4upTNkniJlh+56y6o5AoTsWeOd0CwV2aDrjkSUm2wnerbH1u4qsvwtAyuUv+JaFkKfe4qzxB/CLeyT8StRCFnP49TzfL1oc552vFlMai0Y94bpVCnW9J7x1rSA/2TqBGmQSv5deK2rw/cUKLNJJ2CPqi8E4NRoSVOc13gAQqeBKZlxWRWZPjvZsdQu1tKSEFFphuwUKgQYde9pCZXfCsNzpXN+hDbfpJdpX6p5Or5g0kA/1yWd0mXrayx1jRv7kFIWpB7zd2rPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiX49Q6NGm7qTVpaQEAg01iKgwAPxdFbQiu4p+gBaEs=;
 b=QmB6/FdtgNcNY0UNRfSG+acpZcNnu3qLGHwnchnxuicba16fqj2xYPccgOQkl0B+jskaxTX9VFx14y9SqPRkLkUt49Oo9Y3AVq7YVyRxlIwIFlhsfnJMgxThVEBrqM5DzfDCm7W1XnDrqxZbk9qHMFDyMjRFnefeXHaqhURVCEI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 03:35:46 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d8f7:4906:d21e:f0ab%7]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 03:35:46 +0000
Message-ID: <a0ea7213-05d1-c49b-54d6-8780d8b16db2@amd.com>
Date: Thu, 12 Oct 2023 09:05:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 3/3] drm/amd/pm: Add P2S tables for SMU v13.0.6
Content-Language: en-US
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20231011153227.97424-1-lijo.lazar@amd.com>
 <20231011153227.97424-3-lijo.lazar@amd.com>
 <BN9PR12MB52578048DEC95E1862BC310BFCD3A@BN9PR12MB5257.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <BN9PR12MB52578048DEC95E1862BC310BFCD3A@BN9PR12MB5257.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::23) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DS7PR12MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: d527a698-6358-4328-5af0-08dbcad45155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qlVKzety6YI/VGP09lzjUlbuBnPIZ09O1oA/kHdRmooKO8bxEeGeJoYSNoMEXVmFgvi85hWCvKiAgOJwG30r30SgqQBcla4k3WF87xdTer8EpLe5c1x47jUyMclwQ5PW2ZNFWtfsC8asMVu+cFnYMbaf6NlcItJKU1lpqbcU1MTQyTCH6g6C8txsyIQRfWSVcMfNJ2oARlwgwZK6NY9uBRkVlh3KvGRjM2qjFhSUZqPJ8FL8Sdx00CQooh26CzB3DxfLWrnhYGNt+afwG9uDon1stvoGxkWLp4Pd0/jQvFiUj4eOIvyVq8PbKxHWmpSo/EQ8cCyLSPhiurL/Egn+ql/1wuQm8DkQA+/nu7Wks8Achf+omrxub8gTNwJ48w72KefXrWGKLdqr4I4DiMPzDSJNVegls3On6dTN8+vh/OjhgHE62OP+kfEUbU8MoaTi6usvFTemiw+KQdYk63/KcTdvbIigI5qq6DIi+JWVhgAuoHWUeQvyf2XaBXlWN1VxlI7uMQo3A9SIrvU77hM/ql1NBS82/KgAZy3fhDo0bG8ikbYZ2f6VHqKeFS6/wPFt+gM7q8wyo0qKMlZafp/u7jfVA8y2C650cENML6JMEgw4JtMy0Xr6Z3PCYhfXUeSCOJYJg9PIUbAS/NyuvERe3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2616005)(83380400001)(31686004)(26005)(6512007)(5660300002)(66556008)(66476007)(316002)(41300700001)(8676002)(8936002)(4326008)(6666004)(38100700002)(66946007)(110136005)(2906002)(478600001)(53546011)(6506007)(36756003)(31696002)(6486002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bC9FcWdwYnhnUG9ZcVlDamdOenJETUsrM1NCb2VTaEc5Vjd2VFl4cTh2Nk03?=
 =?utf-8?B?Mm5vZ0diUCtxcHQyQ20wcENmbTl3T3ZKSTlDb1lyRjk0Q2VWVm1oM1dRVUxS?=
 =?utf-8?B?SjNaUE5rN3ZrNXAzaGdVSU9JcmVPeExEdGJGVE4zeEorUmJjTUZpMlJBSWov?=
 =?utf-8?B?WW00RGgvam1aSVhDNm9MRWtFQmJkQjFnRXlNYTV1RzF2U1JDdy91bnRGdDVX?=
 =?utf-8?B?Q2E1b2tsbnJTZW1yOEozMGpVVE1ZNldrWHVrN2VSWHNZRHBVTzhwbloyeGVS?=
 =?utf-8?B?Uk56OW4zQktOSkVEdWxGbWRnTXhLc0RGeHR1SHRsS09yVGlURkEwbFczK3Yv?=
 =?utf-8?B?K2ttY2hjeDZJejRkWSt0eXRDS0dMNlZpRTU3eWh2dVNLRWl0ZHRNNkZZTi85?=
 =?utf-8?B?dEdqZmJSUWUzcUdYV0oyck9Sb0VsQ3VqMHFZMHJ5SXFlR1hMQ1dDZWZjV056?=
 =?utf-8?B?QTAzaXlpb3NTL0RKMmUrMFFUOG1Zb2ZaNkJHWWtoUjFiRnZiR0h6UVlwdXkz?=
 =?utf-8?B?ckV4MVVQaGRzSG1hMUYzRzd4ZG5OdGUxNVFyYlhrMFNmblFOMzlBMUZzeGpm?=
 =?utf-8?B?UGQ3MkU2TkY3RXMwd2NyS0IxUy9HSS9QTkRsNm5iY1hQMVlNK2ZjUTNYY3R1?=
 =?utf-8?B?UUF3ZlZUOWZwL1VnZTczd3R1TmhPUFhHSGZPVXR5VVhyNU1FeHRCSGI3OXo0?=
 =?utf-8?B?UlF1ckJXb25kWktHdDFidDZmYkNCelM5WlpiZ0lXcXBiVUtVYm9tRitDMmUx?=
 =?utf-8?B?cjNmckpyNVV3U0ZyaTUvSlNrd0llNGVTbU91NUgyWHpnaHBnTVpLR09CSi9x?=
 =?utf-8?B?dHZwTWJlRGF3R0czbW4rTlIyOWhacFppcExPZDN1Z0lGbk1PeTU2NlBOUmxG?=
 =?utf-8?B?MnppNUVjVDlJNEFwMXUzQXpheXhvL0pIVWJjdzJIR3Bzd1ZEaWhpY3RZMnd2?=
 =?utf-8?B?cjEySkFtQ1R6T0NEU3BsRXAvUk1ibWpFcldBTWo1cFp2K0xQc0lUcHBtV0FQ?=
 =?utf-8?B?WVZiQmNPTXQ4aGxvUWtaaFp4S0RsL2k4bWFsSjdUNlRHVW51QjNYaTVIWDVK?=
 =?utf-8?B?TlhqZEQ5UzE0S0pGTE1Jc3lmT0JBYWVDMmJlamFJYjdwbjFGaWgyQnNWRDZL?=
 =?utf-8?B?MldFdnZnaEY1Mk9wTEVyV3hjWkZ0aDJjeUh0MGxNakJ4M2Y1Q0ZlZ2xObGVE?=
 =?utf-8?B?YXd5Vjk2aCtrVmM2V3Q1dzErdlJ4TkpLUGV4R3NkbUJZNDFRZWk4U1F3Sk5y?=
 =?utf-8?B?WkdxMjdEZncxdEdNY3NBTHZlTlFlYVZCU0pQeTkzVHJJa0VlWEpMVXpZeWE0?=
 =?utf-8?B?ZHoza2pFc2haSTcvd2ZQU0J6UDVVdnhDdDUwUU9IOWF5ZUxqTTY3N2kraURM?=
 =?utf-8?B?RlE4dTh0SmZzdnREcTJCR21mWWtONmlGODRlZ245OWpwd0RkWjB1YXVOdnE0?=
 =?utf-8?B?Rjd6Qk9VVjBuOUNnV2s0bVlQL0U4Yk1zTDN2dURCRGVCbGtYaGExY3NkaFpn?=
 =?utf-8?B?UkJsY0xGMUhEdGpDWFlvMkE0bSsybDlZR05DU0FCSmIvUkliRnBBZGd0RSs4?=
 =?utf-8?B?TEg3L1JGMWkvVW4yRlBaN1dYcnpuZGpoL3VnVkdHTTdXN1UzcUV6KzQ5bndF?=
 =?utf-8?B?RjdNZnpkY2hnd240djZIZ09lbGJ0dU0xNUNVbnhGTEQyNkRRb0dnM1paRlRX?=
 =?utf-8?B?dHQwNTFPTkpsMnhrRDJzZTNjWml2SzhRNzlldW11L1I5c2VHcXNqMkRnVWdC?=
 =?utf-8?B?MGpIWkdQWjV6SWFHOW1hNkNEcGZxcXVlRlMrb1NaNlJ4WmpHb1ZWS2F3YklS?=
 =?utf-8?B?d1ZTbnVjTmJvYnZJZSswa2JPZktRK2pyVm1KWXBSTGFmN05zUnRzZTJBd1RX?=
 =?utf-8?B?QVhWZlYzVVF4L1FpU0xuYkJJbU5CbERKeGZnWkNBL3NYLzJvZjMrV1AyUW4x?=
 =?utf-8?B?QzZYVWxKTGNZQlVLamJycmlsUGFZWXFianovU2czVVZIK1RxT2Z5S1hqK1la?=
 =?utf-8?B?elRYaWlCMlhBZXJNemtaSjkzcWdrV3psZW1JMk1WNVd0bXdiUElOZ2ZRK1kz?=
 =?utf-8?B?L2t4bW9HcnQram9kZmt4TGxxU2s4ZFNRYU1DOThzOGdoM3J0L242YXBLTXpH?=
 =?utf-8?Q?EhchdjhsBJGoenKbem31KFxrK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d527a698-6358-4328-5af0-08dbcad45155
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 03:35:45.3284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1n2FJojBSjbFQejDjNzo55R2wfO60GRt5TFRV0JEqrJx9ROCk9iYCpR1wA7NyjFd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8201
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/12/2023 7:43 AM, Zhang, Hawking wrote:
> [AMD Official Use Only - General]
> 
> +       if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(11, 0, 6)) {
> 
> Typo? 11, 0, 6 -> 13, 0, 6
> 

Thanks for the catch. Will send a v2.

Thanks,
Lijo

> Regards,
> Hawking
> 
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, October 11, 2023 23:32
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 3/3] drm/amd/pm: Add P2S tables for SMU v13.0.6
> 
> Add P2S table load support on SMU v13.0.6 ASICs.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  7 ++
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 71 +++++++++++++++++++
>   2 files changed, 78 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index c41bd07f3f98..49e914ee6efe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2516,6 +2516,13 @@ static int psp_load_p2s_table(struct psp_context *psp)
>          if (adev->in_runpm && (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO))
>                  return 0;
> 
> +       if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(11, 0, 6)) {
> +               uint32_t supp_vers = adev->flags & AMD_IS_APU ? 0x0036013D :
> +                                                               0x0036003C;
> +               if (psp->sos.fw_version < supp_vers)
> +                       return 0;
> +       }
> +
>          if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
>                  return 0;
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 8220bdcbd927..a295403e2a09 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -65,6 +65,8 @@
>   #undef pr_info
>   #undef pr_debug
> 
> +MODULE_FIRMWARE("amdgpu/smu_13_0_6.bin");
> +
>   #define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
> 
>   #define SMU_13_0_6_FEA_MAP(smu_feature, smu_13_0_6_feature)                    \
> @@ -123,6 +125,9 @@ struct mca_ras_info {
>                               enum amdgpu_mca_error_type type, int idx, uint32_t *count);  };
> 
> +#define P2S_TABLE_ID_A 0x50325341
> +#define P2S_TABLE_ID_X 0x50325358
> +
>   static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COUNT] = {
>          MSG_MAP(TestMessage,                         PPSMC_MSG_TestMessage,                     0),
>          MSG_MAP(GetSmuVersion,                       PPSMC_MSG_GetSmuVersion,                   1),
> @@ -256,6 +261,70 @@ struct smu_v13_0_6_dpm_map {
>          uint32_t *freq_table;
>   };
> 
> +static int smu_v13_0_6_init_microcode(struct smu_context *smu) {
> +       const struct smc_firmware_header_v2_1 *v2_1;
> +       const struct smc_firmware_header_v1_0 *hdr;
> +       struct amdgpu_firmware_info *ucode = NULL;
> +       struct smc_soft_pptable_entry *entries;
> +       struct amdgpu_device *adev = smu->adev;
> +       uint32_t p2s_table_id = P2S_TABLE_ID_A;
> +       int ret = 0, i, p2stable_count;
> +       char ucode_prefix[30];
> +       char fw_name[30];
> +
> +       /* No need to load P2S tables in IOV mode */
> +       if (amdgpu_sriov_vf(adev))
> +               return 0;
> +
> +       if (!(adev->flags & AMD_IS_APU))
> +               p2s_table_id = P2S_TABLE_ID_X;
> +
> +       amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix,
> +                                      sizeof(ucode_prefix));
> +
> +       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s.bin", ucode_prefix);
> +
> +       ret = amdgpu_ucode_request(adev, &adev->pm.fw, fw_name);
> +       if (ret)
> +               goto out;
> +
> +       hdr = (const struct smc_firmware_header_v1_0 *)adev->pm.fw->data;
> +       amdgpu_ucode_print_smc_hdr(&hdr->header);
> +
> +       /* SMU v13.0.6 binary file doesn't carry pptables, instead the entries
> +        * are used to carry p2s tables.
> +        */
> +       v2_1 = (const struct smc_firmware_header_v2_1 *)adev->pm.fw->data;
> +       entries = (struct smc_soft_pptable_entry
> +                          *)((uint8_t *)v2_1 +
> +                             le32_to_cpu(v2_1->pptable_entry_offset));
> +       p2stable_count = le32_to_cpu(v2_1->pptable_count);
> +       for (i = 0; i < p2stable_count; i++) {
> +               if (le32_to_cpu(entries[i].id) == p2s_table_id) {
> +                       smu->pptable_firmware.data =
> +                               ((uint8_t *)v2_1 +
> +                                le32_to_cpu(entries[i].ppt_offset_bytes));
> +                       smu->pptable_firmware.size =
> +                               le32_to_cpu(entries[i].ppt_size_bytes);
> +                       break;
> +               }
> +       }
> +
> +       if (smu->pptable_firmware.data && smu->pptable_firmware.size) {
> +               ucode = &adev->firmware.ucode[AMDGPU_UCODE_ID_P2S_TABLE];
> +               ucode->ucode_id = AMDGPU_UCODE_ID_P2S_TABLE;
> +               ucode->fw = &smu->pptable_firmware;
> +               adev->firmware.fw_size += ALIGN(ucode->fw->size, PAGE_SIZE);
> +       }
> +
> +       return 0;
> +out:
> +       amdgpu_ucode_release(&adev->pm.fw);
> +
> +       return ret;
> +}
> +
>   static int smu_v13_0_6_tables_init(struct smu_context *smu)  {
>          struct smu_table_context *smu_table = &smu->smu_table; @@ -2787,6 +2856,8 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
>          .get_power_limit = smu_v13_0_6_get_power_limit,
>          .is_dpm_running = smu_v13_0_6_is_dpm_running,
>          .get_unique_id = smu_v13_0_6_get_unique_id,
> +       .init_microcode = smu_v13_0_6_init_microcode,
> +       .fini_microcode = smu_v13_0_fini_microcode,
>          .init_smc_tables = smu_v13_0_6_init_smc_tables,
>          .fini_smc_tables = smu_v13_0_fini_smc_tables,
>          .init_power = smu_v13_0_init_power,
> --
> 2.25.1
> 

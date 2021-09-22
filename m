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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59B9C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 05:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A0EB611B0
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 05:56:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5A0EB611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 774676EA2A;
	Wed, 22 Sep 2021 05:56:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1FF66EA2A
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 05:56:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaN+mqpwgE2jJmlhCtCbGUTo1AzxpEm+eZbu8QCqE2Z01c8p7UB2y7LgFJGS15Ctzmk1gS/HcB2qWeI8NqC8IlZBviDzSnusMHjQV4OC7VXM67xnp+3G+rERoO3/xbZrQ4E20bJpLBr3JnnIOT8RTcfxl/wDM7jf5N1bti09zsXfSCusQD9dEaD27Te9yNtsYHJUY015za2t6Te12899x0nTs83B0mymsC/xpc6+GqSPWyDPFZYccawdSZAEcX62f7no4A0kqmg42VCiciEdqGBWAOIc6WzBZyuymBMjb5YA9QcQzd1nkmNpBcygYR8HChBfmHGSOcA2RbFAzQx0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=H/I2bNCR4QnnlMI+S3r4+0BHmTCnZRbZpVFfOx5dWPg=;
 b=Sk1vxowc/F222PHPkiU1XwgJ5KeJmMfjLtmlBpsKJY/6vybqTEsJpWlB4T9TAaKj42UoMNHA+3nwfyfjDHLbDUYxG/nulQR5ktbuSuVkcAG9Dtjq8ap0vzR3u7wZN/67qkEcjOQlYpvM+o5LVV8jWuFJUM+IoVEHX92DPhitdTToVWLwTQt5OWtcKHxlMhlWrv+JYo69utek/STMTQF9eaZaixN7ZeqZJ/I4vLDANbfUGl3FHkQv6vW0bOPuTaAANUXnPiJ+WuuHJeJYYol+XDwhVpxqD/Fv/Hg7+85uGXJvQdLqu2XTX+oNCKfII15JcoFceBpt53qYQF6NeJe+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/I2bNCR4QnnlMI+S3r4+0BHmTCnZRbZpVFfOx5dWPg=;
 b=sfdtltSvSAYdVcShUEc6Qi2IvEB+sHR3PW0QbxysVOMG0IlCrDyn1KRWCyYOMKem1Yly/fak/JYi0nyCSAFTLuQuAlwRtwzxpEXHSK1ZBcpQX6F92LvQApmJMZmAGaVVcpXsM5cGoYVBSl4BlAcW1DlVPE93RdaN7my7aeS1wFk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Wed, 22 Sep
 2021 05:56:07 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::5879:5961:8a30:6a57%7]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 05:56:06 +0000
Subject: Re: [PATCH 09/66] drm/amdgpu/sdma5.2: convert to IP version checking
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-10-alexander.deucher@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <54ac4a03-2858-6289-6b32-128f65334073@amd.com>
Date: Wed, 22 Sep 2021 11:25:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210921180725.1985552-10-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::13) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BM1PR0101CA0051.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:19::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Wed, 22 Sep 2021 05:56:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bc55030-50a5-4e56-bc11-08d97d8dab4b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4265:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4265DCADB79DD3505CFF5B2F97A29@DM6PR12MB4265.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5g35c3mwYDlX49RnhQAzp35dUNq1buB3+EjJT8z8i9f4qlkYTP9NBfm9Z6fYB4FdHjKfyvJCB4NYLWktsU4m7JwFYIfdwO7hOX48B2XYaHDDGQ8tVNSaJikfq9jEc5ILWfHgHR+rNVmVqHFRIx6wNJKK9WSVNAShGoftrt+7o4OPHDfcedYdz3Xr6YJDhCHN0BR31gv9xUdoMpPaYWYqg4GvNquNs0mhPvbm14zEBbHDfkh1XYWsOrBfXHSHuTume/7MKC89564fa9k5jdJNJSH6R9R+MyJ7vxDB7gs+t0BtQ49XBHjV/Y5mspSGitR8UzaxG+RbH8qXRo0MacJt5uXpqVfVO5mSyES3+UZrYT8h4pi6bJnCroTvxqogYpZcSodsECQ0d/3UR1YxFdjwpVETLw+m3ADuIZliVwsIzSycNON1eV7uOPS8c3E7mTCb6/w8rDtNx9XOWq58W2FkpWvwF83rdxIqI7v9wgZ8MY111gYj+hrKt2MNvbWIg+tf4xFnPBM/84oUmQ+n+rWhKYD4fjGFLhh/mM8qgu3fTDr8vIG0/QT3U6n72vV2ZD+0JZlj5Nz/6hIa0X+q8htTpKPdn/PkN+qFX/uOOCdTVKx0uVAahTTOzeZMKwV0N1UKhOfD4wc1ShqhS09mw3IvE1qenJq/utslVb6I07ShLqtRuGsYte0tpDKE6qXrjLSYqhgtKETCT2a8mkAVfFJxof6WZ8g1OCh8Y0iBfHZWeUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(5660300002)(508600001)(83380400001)(16576012)(31696002)(6666004)(6486002)(53546011)(316002)(36756003)(2906002)(8676002)(38100700002)(186003)(2616005)(26005)(66946007)(66476007)(8936002)(66556008)(956004)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZCt1VStQY2p2YjNTM3FBeWlvK3hSMVNQekRuL21KOUJHNlRJazB1d2Z2dlRW?=
 =?utf-8?B?MURyNkhxdmg0OWZvNTl6SWJWZlJYNnVhZHNURUxRQXV0OUc1UlpvUHF2cDEz?=
 =?utf-8?B?K3RaWlluU21wWWtQV0xPUE4rRWovck9wNnVSMjRLVkEvOXRQNnVyZDQydU5H?=
 =?utf-8?B?Rm9QbzNlZ1NVNkY4cTljcTgxd0o3eXJPdDBRZ2V0RUluMWdSRFo0L0FpLzZB?=
 =?utf-8?B?dTIyMGpWZ3k0MWJCenF5aEZ1V0MrT3Jib3dnM2tJd2FHTVpvMXRpbmJ0TnNl?=
 =?utf-8?B?cG52L3gzcldlbVNTOVhKdGVpODJxVkRJYlNQWHA5bjV1aC95MHNPOUorZDEr?=
 =?utf-8?B?VHNWcXBLbDlZZjBOZm8yVDRCd1dWenhpZGVGUGplc0tHeU1OVWpDWWtONERS?=
 =?utf-8?B?Yi9DM2YwYW1TOUFuTzVLNlIvd2FmMXZjVDYvcTVneE9nOCtxOGx6WDU1eTM4?=
 =?utf-8?B?WkRQRkFMTkdyZlNyRlBET25nZ2NJaVRMKytKaEF3K2J2akRKVURJS2VHaWR1?=
 =?utf-8?B?TkwvMjdLSHRKRUE1UXNEc2djTklMdmM0cGNtMTFTSlVEc3JMUDFabVM1MXdv?=
 =?utf-8?B?RzkxQ1J5dys5Y3psV2RWOXpIRU9SeVZXcFdvZEJrSkwzb2paendVdjFpb3VH?=
 =?utf-8?B?bVk0dWhqMExoSkM3eDFTWFBXbkNCRk9LM2N2K0tPV1VwazFicWFrYWlYTXdH?=
 =?utf-8?B?cFp2M1YzdFRCaC9RZXRBM0ptTDlKRGMyMHNkNVExVG1XN0VVcTdwMDk0VE9N?=
 =?utf-8?B?c1pSVEpKRWVOc0t5VUVOcGNJS0ZNd0dXRXpUczVzV3lJYzFUSWpXNmdYUzVV?=
 =?utf-8?B?Sy9tOEwzeHB1WXdwMVpPZzRReGVDQW1ZN1VCdml1LzdVV2cxeXhSKzFBeXhJ?=
 =?utf-8?B?OFFTaUNreVZnQ1dDdDZiVzJGZkdHZEpMMWhrUjlsQ0Y1cno5WGRzWkZLNnRT?=
 =?utf-8?B?Ym0yYWxtcHFpajE0TEVxSEw1Rk1VUFBYUGZHQkl5cHJtYnQ4eVVxQ0t4Vkov?=
 =?utf-8?B?VnpJQ0g4NGJDVUFDaUU4ZnhDM2ozbVpYUk10Q2VoR3QrQ2xsQlM3TDdEcjlz?=
 =?utf-8?B?V3JQM0V1SnJ1UStKS041WnMwbnV4TDJuY1lxWStQNEtkWTAwUFZwSS9CK1ha?=
 =?utf-8?B?QTVRZ1A4NzZ4RVZHQlJPUi9sNWlQMnRENWFORmVhb1BLazZOMlZkUGtpdnJJ?=
 =?utf-8?B?N0NGcmk5T2ZzM3cxQzFra2xVQXcxTGpoTi82NFhHVEFUckVNN0VuNlcrQTVv?=
 =?utf-8?B?QWxnR3ZHR0tUUVIrdy9CVno1b2htTTdveXp4ZktiZWhPS0x6UnRJUzlkY2hK?=
 =?utf-8?B?L0lPNWdpaTQzcUR3T1I1UElpczZlTlBLSURrejQ2ZWR6VzNUYlpjZ1lGOGZw?=
 =?utf-8?B?WmtxeWFKU0xJaC9JQmZERFN0YWMxaks1NHRFR3JFOGVhVWl3T3JSMDUzU21M?=
 =?utf-8?B?NjdIUGEreEtEUXlNaEpTQ2taK0dTSTlwUnI5bU02dWZYUmlBZFM2MHFkSUdS?=
 =?utf-8?B?QVo0RXhETFRxemRBN1FiU0NmcENTZU1jeXV3U0J1ZldJQVA5V3ZMdks5ZExS?=
 =?utf-8?B?bXRRVTZVa2lONWh4bE04QUJDd1lIejUzYTlDNDRLTzNXbXZzMTNQT2JhalNU?=
 =?utf-8?B?dzhLYjF5VlZtalZldFZvUzc0VEE5dXF2S3RZR0FxdWU3S05qUkdqN3lJbzI0?=
 =?utf-8?B?S1FPaUdZN0xSZy8yWDVyeHJpakk3UjRRaGxTZ29FZU5VNEUyN0lhNzVRcVF6?=
 =?utf-8?Q?/Asux1nqVL0/80suocIhIiJWbyEki8j+ZSdx81S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc55030-50a5-4e56-bc11-08d97d8dab4b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 05:56:06.8413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pAABsakgqnWEfiJjmDIpl/g8mpLFaGHrwCF1gZtlHjUuIqdSvdP9UbwfK67uqpb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265
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
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 48 +++++++++++++-------------
>   1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index e4a96e7e386d..c5252f12eee9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -136,23 +136,23 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
>   
>   	DRM_DEBUG("\n");
>   
> -	switch (adev->asic_type) {
> -	case CHIP_SIENNA_CICHLID:
> +	switch (adev->ip_versions[SDMA0_HWIP]) {
> +	case IP_VERSION(5, 2, 0):
>   		chip_name = "sienna_cichlid";
>   		break;
> -	case CHIP_NAVY_FLOUNDER:
> +	case IP_VERSION(5, 2, 2):
>   		chip_name = "navy_flounder";
>   		break;
> -	case CHIP_VANGOGH:
> +	case IP_VERSION(5, 2, 1):
>   		chip_name = "vangogh";
>   		break;
> -	case CHIP_DIMGREY_CAVEFISH:
> +	case IP_VERSION(5, 2, 4):
>   		chip_name = "dimgrey_cavefish";
>   		break;
> -	case CHIP_BEIGE_GOBY:
> +	case IP_VERSION(5, 2, 5):
>   		chip_name = "beige_goby";
>   		break;
> -	case CHIP_YELLOW_CARP:
> +	case IP_VERSION(5, 2, 3):
>   		chip_name = "yellow_carp";
>   		break;
>   	default:
> @@ -174,7 +174,7 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
>   		       (void *)&adev->sdma.instance[0],
>   		       sizeof(struct amdgpu_sdma_instance));
>   
> -	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_SIENNA_CICHLID))
> +	if (amdgpu_sriov_vf(adev) && (adev->ip_versions[SDMA0_HWIP] == IP_VERSION(5, 2, 0)))
>   		return 0;
>   
>   	DRM_DEBUG("psp_load == '%s'\n",
> @@ -1209,17 +1209,17 @@ static int sdma_v5_2_early_init(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	switch (adev->asic_type) {
> -	case CHIP_SIENNA_CICHLID:
> +	switch (adev->ip_versions[SDMA0_HWIP]) {
> +	case IP_VERSION(5, 2, 0):
>   		adev->sdma.num_instances = 4;
>   		break;
Isn't the instance count also expected from discovery table?

Thanks,
Lijo

> -	case CHIP_NAVY_FLOUNDER:
> -	case CHIP_DIMGREY_CAVEFISH:
> +	case IP_VERSION(5, 2, 2):
> +	case IP_VERSION(5, 2, 4):
>   		adev->sdma.num_instances = 2;
>   		break;
> -	case CHIP_VANGOGH:
> -	case CHIP_BEIGE_GOBY:
> -	case CHIP_YELLOW_CARP:
> +	case IP_VERSION(5, 2, 1):
> +	case IP_VERSION(5, 2, 5):
> +	case IP_VERSION(5, 2, 3):
>   		adev->sdma.num_instances = 1;
>   		break;
>   	default:
> @@ -1547,7 +1547,7 @@ static void sdma_v5_2_update_medium_grain_clock_gating(struct amdgpu_device *ade
>   
>   	for (i = 0; i < adev->sdma.num_instances; i++) {
>   
> -		if (adev->sdma.instance[i].fw_version < 70 && adev->asic_type == CHIP_VANGOGH)
> +		if (adev->sdma.instance[i].fw_version < 70 && adev->ip_versions[SDMA0_HWIP] == IP_VERSION(5, 2, 1))
>   			adev->cg_flags &= ~AMD_CG_SUPPORT_SDMA_MGCG;
>   
>   		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_MGCG)) {
> @@ -1584,7 +1584,7 @@ static void sdma_v5_2_update_medium_grain_light_sleep(struct amdgpu_device *adev
>   
>   	for (i = 0; i < adev->sdma.num_instances; i++) {
>   
> -		if (adev->sdma.instance[i].fw_version < 70 && adev->asic_type == CHIP_VANGOGH)
> +		if (adev->sdma.instance[i].fw_version < 70 && adev->ip_versions[SDMA0_HWIP] == IP_VERSION(5, 2, 1))
>   			adev->cg_flags &= ~AMD_CG_SUPPORT_SDMA_LS;
>   
>   		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_SDMA_LS)) {
> @@ -1613,13 +1613,13 @@ static int sdma_v5_2_set_clockgating_state(void *handle,
>   	if (amdgpu_sriov_vf(adev))
>   		return 0;
>   
> -	switch (adev->asic_type) {
> -	case CHIP_SIENNA_CICHLID:
> -	case CHIP_NAVY_FLOUNDER:
> -	case CHIP_VANGOGH:
> -	case CHIP_DIMGREY_CAVEFISH:
> -	case CHIP_BEIGE_GOBY:
> -	case CHIP_YELLOW_CARP:
> +	switch (adev->ip_versions[SDMA0_HWIP]) {
> +	case IP_VERSION(5, 2, 0):
> +	case IP_VERSION(5, 2, 2):
> +	case IP_VERSION(5, 2, 1):
> +	case IP_VERSION(5, 2, 4):
> +	case IP_VERSION(5, 2, 5):
> +	case IP_VERSION(5, 2, 3):
>   		sdma_v5_2_update_medium_grain_clock_gating(adev,
>   				state == AMD_CG_STATE_GATE);
>   		sdma_v5_2_update_medium_grain_light_sleep(adev,
> 

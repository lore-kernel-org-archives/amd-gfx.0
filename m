Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA64C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 11:06:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12C6910E358;
	Wed, 21 Sep 2022 11:06:29 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2051810E358
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 11:06:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeyBuFUSZgOAOGJS3fcxexi51xLUzk81Nuihdbyiosrg5oshmqN84sFjQDmgscXhbkUX9HonTLD9Kh16sRBfPeJHCfZCc2oU2/4Hux/OXrvK6G3rNQU+u0/qTWJN9dfBB6ih28fKqCRTwHXftyJh6C/fFxK88VB83vj9sNmz35A9rBRnaCk4vQu90Wn9pR5qHpOOChg6TwnhxBXakAtQbiwIz57zcHWv9hJkdl9ytEmy6yUiMhL7cNIhBkg37hhqWQh/WLPs0R1nBOmcKJ7PTZg+JPcc3t0F5JhQ9XeCMVKplBWkxylGI0CqZ5GpLAhlsxn3luo7lEd61qxBV7DS4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+bezxt2IeASN0kdBU3xPE+SkoVodXXqXe8uCSFIcVg=;
 b=d2ZQB9oyShRf6PmStn7ZWztKv4TDGxCRxR2hW0Nex2hSUmnLRUmytcLOzZq7MRWlDx9r263gvbdXXOqIctAGHiApDSlB17c85xGXN3quZPyhHF8IThLDqSbEzdVfAy+KS19wrguiGRXmC43ovOCqx3E4IESb1x6OKxgjy7jSc1T1Uk2epJI5jSfZfjMxQMkB/eWgbfbibwieCtPT4ENLAt5eYHrg60P17voWTxhSvR6wnLDkQfjIyoQBd5xi0XKtn9qcdN7Fuoo9X/Cjv30+mwEtnQnHFgUbB6lxGoEASuNl7ckynWf666tH7iaUtYS4LPG6qpbrKbKt6iIbhtNPrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+bezxt2IeASN0kdBU3xPE+SkoVodXXqXe8uCSFIcVg=;
 b=i3NYNX80vl6AYalNtkqm2Wg69xsQvdB4cyS7fE09B5c6yoa/7N4h1qcOonMD0OlPKxt8w9mE16MfzRi3Igp2yateShshhR5Y3e9X0VXJY2WRI65jfAp33RkNrDx1bSQzYjAwXLBzz+XPXZ8Ard9Ebumz6SP1FqzA+sa2/pWK4qI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by SA0PR12MB4574.namprd12.prod.outlook.com (2603:10b6:806:94::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Wed, 21 Sep
 2022 11:06:22 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3054:3089:efbb:78c0]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::3054:3089:efbb:78c0%6]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 11:06:21 +0000
Message-ID: <ab8fe3a5-d166-3483-3133-b6d54fd19683@amd.com>
Date: Wed, 21 Sep 2022 16:36:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/3] drm/amdgpu: avoid gfx register accessing during gfxoff
Content-Language: en-US
To: Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220921045623.43401-1-evan.quan@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220921045623.43401-1-evan.quan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0074.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::18) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|SA0PR12MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f583577-e2c6-42e5-e2a6-08da9bc150ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mb6jxPR2lnYpcntMNXQZ7GPdgvvL3F4tt+8ve0RqJqO0av37KtHZ0sZXC1Ki/5kZdTvC8s36l/pDVl2joU0enKhEsDRuMHutmipIkZStvtNaBs48eU0xLiT3hMmG2RXHxKMRZTNDpsFgV9riwX6DnV8qoN8kGxu7bpEipMvjM4qPpiaU5QxAkQHOGGP5dyVKw66uwzgbRwrDJyrCpD/MTFSFE8C4T60ZEfJrorhcR7tjiPI7LKBRYRpYGwbz+jL1+nD3uNYrCFJgBxtHyOfMp44n92ZrpYFtieFTvPtUqNOrLbjZ9ZFwO/xhjWISgpWjes/t5T58EGQt4jZpRBigR1fVqi2r7BL+i1XS+ZN/jcflC29aLl97CidvdgCrWmAToKZH/vKHLyDPbHy4Rc3vqVakpTBQCspNss3rkLvz33JoJUx3UePQCINf141DjNQjSZq+KJZOEviPywrgp3sbWRS01EjZDjjLtj224FaxO5zFjAkwn0jweijKTqS1fHYvaeaT41lc9nK3LAYoTGoMmHtRS6vmuXZ4HwXbaRhVvQzcrv+cfBnOPxQFL8VEt6YHmmxTa2v2NsMaSCDVH3DLg4bvWcQCII5Zt+MAIc4cyhSmMGBrWUksv5jpItkVm9LG/x/qPr8Prurw9h+iwqH1m7b8T1Ytbsozbo6hBsbv5+RDe1KSJHFcO6VYCiqNGYqkvJMLixQAPKu+fpaOU4zB1aBwRb2oJ7l3K969KyPbkNDXS7EdSWOinQRFTSomRXpbl6T2ZXdFNeIZi4fpeEiYsSxKTTC1GpYI1Tva/i1aTHU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199015)(478600001)(86362001)(6666004)(41300700001)(8936002)(66476007)(316002)(8676002)(66556008)(4326008)(66946007)(5660300002)(31696002)(6486002)(38100700002)(2616005)(186003)(53546011)(6506007)(6512007)(26005)(83380400001)(2906002)(31686004)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1FKV2ZOY3ptaTNsbVB4elBSTXllM3NlUkwyOEZGK0J3Sm91OFlmT0ZSODVs?=
 =?utf-8?B?M1BpM0ZBS1BmWmxYNzJnSGdWS1FleFdyTDJuenR5aGlTWjdOaFJ2R3lnNnRV?=
 =?utf-8?B?eUJCYVJ1UjFMWVZPSEpWS25vUFBDckxYN3pFVExyT1dxQ2dNY3BpYmcvM3FG?=
 =?utf-8?B?TmV5NnpQc2FUMjE3U244bW0wb0pKTG8yanpKQ2VNSUwxUnVFY3NEQ3pJZjIw?=
 =?utf-8?B?cWVhdWgvS29iU1UzVmRRcDZjOVhaQmkrZUMyODhTM0J1dFZPOXlJSG8zZ3dz?=
 =?utf-8?B?L1ZhalN0b0x1Q3oxYUNBQkVZY2R4RjdjcGdqaEcxOE1GdnlsaWQ5Rk1CbHRz?=
 =?utf-8?B?K3ZuVG9HU0R1STdRY1M2NlN6UzVQN2tYbWl1cmlyTXlhMnZHV3FBQmp5dy9L?=
 =?utf-8?B?d29lR3ZSdHNzdjhOSitNb0Z5MWdXYW9sQTFWZXRReUtadW1DNEphSDI4WGVX?=
 =?utf-8?B?cGNQemFETUMySmhDTkVGTkplbWVqa0hMQVBtNkRFa0JCdWVPeUtsemdXdjNM?=
 =?utf-8?B?STVlL3puU0FsR3NoZE1SOXVibmVnQm9jVjBrTHU0UE1TbFBEV2F1aG5ZTk1w?=
 =?utf-8?B?bzFrdUJycitYcEExcXFRZTJMeHFTTzM1eFozYWZpb1IxdHZzUzVYRGV2bC9s?=
 =?utf-8?B?aW15VTcxK25aQWVYUkxGZ084R0JhOGNLOTFRSzBNazhhUUZseGV0Rno1WVlp?=
 =?utf-8?B?ZDVGZzZpczN0K0JmWUVGendlTEZ0MGM3cnVEOTc5bSswd1Mrdm84d2tmN1Q3?=
 =?utf-8?B?UXRBNnhvcVN1S29FbkZiczNRRlFBMnlHcXN6YmFzR2NiaXRRc3VhNEZWUklP?=
 =?utf-8?B?SXBhRmo1TVVSdTZsK0p0dkt3WVRLOEtPaVRsaXc4SlRwbWVrcjkwWEppVlNU?=
 =?utf-8?B?QjJkQWlDL2tiZnp1SnQyYXlxdTl5bCtFeWpMekk4SmU1c3JBRm9qZFBrV0FY?=
 =?utf-8?B?dThPSWJyTnQ0N3drTCtreFMxU0QwYlVNZGNrSytoYllEaVBlWWFzK0Z4aWNX?=
 =?utf-8?B?a2pEd2h1UEZWVHRISFhpaVNBY0RhMEhzdjc5QWI2aElGd0xTZ2RnaVJ0L1d2?=
 =?utf-8?B?RW05bzFzSUt2ZkdEczdPVU1NTVpzL2c3RGJZaWd5RXhiSk05a0xlUGVBMUtS?=
 =?utf-8?B?SzB3MzBMWWhDbUNJZFNCMnNibmRiMVNDc29Bb3A0b3F6SkxoT2xMWjRBdnZR?=
 =?utf-8?B?T2pjejhjM0JlL0krTGc2Y3RyOUwxaVVXUm5rNjQ1TkdNRVpkN3piU2Z0ZzdM?=
 =?utf-8?B?SG1hcCtLQzRHUVBTTnkwT0R3T1F4cytQRXN6aHRQckU1bVRwYUN4UnpreGs4?=
 =?utf-8?B?SmNEcVMrLzRNcDB4MFZHa2cxT1NRcER0MDA1cGxmWVM5Tnk4V01OeWhpdEVv?=
 =?utf-8?B?RythcXI0TmZHTmgvZ1hvOXl4ZlNHd09FZzFDRG94dFE0dXZIclQ5ZDNmOUdO?=
 =?utf-8?B?M0JxNFFNTEpyd2ZVaEV3TWltTEkwSkx6K2N6WEsvQzhCSVRNUkV6cm9yeUxn?=
 =?utf-8?B?a1VqbWJnUXpsMkdEUnNFdTRGOXZHSmtLS1ZzQi9xemZaeG5icXlsU2lUOTkz?=
 =?utf-8?B?cjNrT0F6emRWU1A5NTJ1cTg2OU1VV0c1ejhkMURzN1ZxMlBtWE5tdXcwSUlk?=
 =?utf-8?B?MEhJdENramxBZFJDNmNQdmE2WkdQQkY1N05kMmZZMDVKVmIxRThXMmhFSWY1?=
 =?utf-8?B?UGx2ZlFLWndxYXJiM0xOZTZSVVNDem1qQlcydnlQMWIydUFSd3pPQjVsQ2RE?=
 =?utf-8?B?S1kxbmhBbVlNYk1yZFdyZkNiUjZVV241NVN3RXdRNTBRYkJQQnlCQURoK1JV?=
 =?utf-8?B?K29zZkc2U1puRHlqQ1BLUXdaVHBoU3ZSdm00eGlFS3BHcThzMkdPYWl2YjRC?=
 =?utf-8?B?WjBtWEswT2c1Q0UxUmlGbUV0cXJDOTVyUnRmRUl3eFFYUWhZaE1FQnhnSTl5?=
 =?utf-8?B?dURoa285N3lnY2U4UTJPbnpTYXpjb1ErUmtBa00vM0NUaGRIWnltcWp6UkY2?=
 =?utf-8?B?VlVwN0lNSUlLV2dTd1l3SmRoMHNSNHFlZFNwUk5Ma2g1OVdmNDdEdUVETE80?=
 =?utf-8?B?RGg2MXM1MS9KMmpTQkl0ZkNDTEpnWVRJVlRrZGkrRmo1K3hrVnQ4ZE56VWJ4?=
 =?utf-8?Q?O9mFXEI+/lOjI615Szm9db8Zz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f583577-e2c6-42e5-e2a6-08da9bc150ac
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 11:06:21.6159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wbs5LP7bU6hnc3+GgdfZfL4Jjh93NVUK04L73mzDsIyiU+ZGb4SYU9KusO18p+tq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4574
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
Cc: Alexander.Deucher@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/21/2022 10:26 AM, Evan Quan wrote:
> Make sure gfxoff is disabled before gfx register accessing.
> 
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Series is -
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> Change-Id: Ia032869080f51cdefc6e6bad4f04405193ab0fec
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index ce8c792cef1a..710074682279 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5245,6 +5245,8 @@ static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
>   {
>   	u32 reg, data;
>   
> +	amdgpu_gfx_off_ctrl(adev, false);
> +
>   	reg = SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL);
>   	if (amdgpu_sriov_is_pp_one_vf(adev))
>   		data = RREG32_NO_KIQ(reg);
> @@ -5258,6 +5260,8 @@ static void gfx_v11_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
>   		WREG32_SOC15_NO_KIQ(GC, 0, regRLC_SPM_MC_CNTL, data);
>   	else
>   		WREG32_SOC15(GC, 0, regRLC_SPM_MC_CNTL, data);
> +
> +	amdgpu_gfx_off_ctrl(adev, true);
>   }
>   
>   static const struct amdgpu_rlc_funcs gfx_v11_0_rlc_funcs = {
> 

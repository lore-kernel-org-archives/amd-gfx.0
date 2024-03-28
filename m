Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E75FC54E64
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 03:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAA0710F19E;
	Thu, 28 Mar 2024 03:36:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R5Du9nXZ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F81B10F19E
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 03:36:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TGRjeuCxirI+TPBa3dt503FcB4ieaWyl6cE2WW2H+2HvFAwuwWGDj4+yofILiFolZziTbvf6Oq+6vAgTZeSs3gaGc6DDXVByF87yaTH02hDj6GbOcsJDc5cZW+LEgbtBXJeKI/PweywTpw7htWMl8/e8jzJxO8m4eeUnN4dqXnJuz7adsVtDY1qxawNxBwIWA9cwVkHs1mkO5RVW9y5HlkRNsNO37E9yQaiWfovbsuKSb21h1akmF6MUkG6xyxq8ZB1CaqeIvJo9PucZ9GI4Mq9v/aio/ruEf7m237iOnHvGQ0ktvi0KMdxuQsET/HyXE8RlyHnZWnLr7dsow5EjAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcCEuorQbr0AG21CbKi1eHQ1gWuogPCK8SwEG5uV0hA=;
 b=XbfYJ1hR7UtSkRWuWZROnkVV4xNSxeziJeIa4sluW5bbpOOnbvyyIixN4fHDhTpTVmxXpcR2e5UJrXChR4S1ggqcYkna6MaTTSQ+JniuDz1q3hBOACUTdGLmLCcHp0k8mN+Ur/FcZwMqIBJ3BuJt++7ufqDPjwrVngJnNwAbOft5MqSFgXMgxzqyJaPRi48c4+TI+Agr2A6C3WIU3+8TVMxKSM0x/UYXPVRoDmhQNgV5dGwh9+7ljxHE0z3IXiUs+15weEkLQSdyF54Zt4nEpGPX9vp3ApEtF5IHSWuhbGGTX+8u3zqc8Sb8qnHc5O2InChTZ39Zg7qBF9U5pEEfIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcCEuorQbr0AG21CbKi1eHQ1gWuogPCK8SwEG5uV0hA=;
 b=R5Du9nXZ1hgV2mhJVGR9SD1M5VpPW1U8nPbW3rYPE2SmoedE7YtR9J7oJOrjdRMouJk2QKaJ+uUV0d53hD91vzdfEKJLojcT7kzwlCZ6/oBKnXRMbq5QNR5bpP2H7FMVlRhqkS3diOplkUnvAAs2572bNteCE7N26MQzn4bYTgs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA0PR12MB8838.namprd12.prod.outlook.com (2603:10b6:208:483::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 03:36:14 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7409.028; Thu, 28 Mar 2024
 03:36:14 +0000
Message-ID: <6ba2977c-7459-4506-8a65-bac1688e1823@amd.com>
Date: Thu, 28 Mar 2024 09:06:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Reset dGPU if suspend got aborted
Content-Language: en-US
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20240328030629.820663-1-lijo.lazar@amd.com>
 <PH7PR12MB5997CB50A22EB9EA4999DDF0823B2@PH7PR12MB5997.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <PH7PR12MB5997CB50A22EB9EA4999DDF0823B2@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::8) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA0PR12MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: acc5481c-21ac-430c-7a64-08dc4ed83831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eovGbpMTwgmmSU7wKy++tY7y8at31dBAO4OWPjdTJCNUEqIvn+lvaIEBaaC4nQPxniHJg7MXysF+1BdR0sviUsWUzDD88xZiZstkdKinUSjs6CiWUlTtP+xX60RERHf6u6XikkcxBE1Kibx8JqZvqQGB771NZFykwyw5Rl4ngK/VbfrZRkqei3JFzu2dhfTzx25uxLfaNelVbGOQxkIZkbOZoc51vygV/n/82+jb4PAFCvR7DBqz34uHOwEtVm4CElsLwoeYIUlQCfbSp3xC6JrPmm2hBRYenwzmzW6OxKHVTm/Jc6kTieawBridpyl0+TLpSJJME1ABMHYCrEuZ5s5ydsgHJNMtq8UTIYJdGDxtDMiiFMl+d5K4yyUoc/6suwjB8zRNQb/0hR+rJxNTwI7W2rcnwudBCAszd5DGTI2NDkU/Epz+GnEPAQ7cDtcwLfEvGIPcYb7Z++1C3fVL1Z7JlsqmJcpcIIeBIFTolhrr5f8t+3qeLhwv2Bt3KqmW3hAxSYRNwip5V1dIKGERr5kU4+LcWoxLCP3OzIRaFgNkVWbvOmEnpT6ZGimmnlLmPqzb+ccCqCs0eYmwnBPzhpijpAbzR1Kl6gbdfvpztgYu6zypWgHWVIBfHB1goi5TGkvTDAngdmE3fNF1M5Ai+x1ydutfVBJrrpl/PXKX2As=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnZuTHFiWFpBQW1MN2hZS3dYb1ZRdmhDN0xNWmt6RkNmQWNnSGJvZ3F5Wkpj?=
 =?utf-8?B?MlJsS2lqdEd6eExDdkpjMTZPb3Fqc0xGTGpERUdqbkl1S3BlQ0tnOGlkd1Bv?=
 =?utf-8?B?a1BrTGZEaCtPeUhKRWpFR25GN1c5VHhoamVRU0xzLzZmblBUUUJTK3hKVTMr?=
 =?utf-8?B?Q1d3UXk1Qm5FSVVlbGRuVU8xY0NCRWpyTTBVdXJFOTlpN1pHMk51UnNkZ3F3?=
 =?utf-8?B?TjJmRUZwckFCRVlvTFNZMm5yWjMzOWJteW5zUmFvTDB3K2lqQ2hBZzdTV2Ri?=
 =?utf-8?B?UW1aS2lUdVVvMys5UGRjU25tZDVTcTVGVVhoMEJOWG9uaFd3bURFRWFQRjlO?=
 =?utf-8?B?TnRQQnlBbStNT0RoQm4weENCL0hPTjZaT3NsdDIxeTB2TzRPZWR6QXNNODRH?=
 =?utf-8?B?dzVrMHE5VlltTmNJM1NJV3hpTGZzckkwMkZKM2lVMDcyNE5KbEVmUU1yRnFz?=
 =?utf-8?B?Qjlid2tRMm5vdkpXL1gxclRGcTduSU5FUkZScmhuWExlanJUa2V1eHZkNkJi?=
 =?utf-8?B?Y3BubCtFZWYvQlVnckZCMkN6b0JnTjQ4SHJZaWZ0RU9DMXlOQzJQTkI4dHJY?=
 =?utf-8?B?eDZTd1pobGNKbzhHSlA1M01lUUFoMlJCWnBXdnhTcnFuZy9sRUc3TmwzZjdk?=
 =?utf-8?B?U2lvK1IydklkVmVyS2R1WWwyWkhNb1JUelV3d3BqZmd0Mk9PbS9nTk9MeXY2?=
 =?utf-8?B?TUp6VXJiT2xpZVJneWxUTFNFSEhxeWhqRnFqMGJ2cDVjQ3hBV3k3Y0dLUHVX?=
 =?utf-8?B?Rkl5aDdHWnFXMGFrc01BUFJOcjREbUtDanhsemlCQ24wZlh6OGtFa3lTTm4v?=
 =?utf-8?B?d0xaMGlFamdOa1VyTFZDUTc2dHZ0VjZvVDZ2b3pSbngwV2pOQXdUeHRyUlVa?=
 =?utf-8?B?SmdOOXRtdWZGQnZsZ3E0eUs0UnFsNlo5ZlJucHZ4VUg2VmxnWkcyOXNtU0Vm?=
 =?utf-8?B?Y29FM0JVNVd6K1NNUjh2a2ljUmg3dm9hNUdWb05yUjV3TkMvQ0ZRRGFLek1t?=
 =?utf-8?B?VDRxK0ppd2RDZEIyalVnV1BOdk05WUgwTmZCbElEbTk4UlZ3dUtwbHdUMjZT?=
 =?utf-8?B?UkdGNy9ieStYM21Dcy9tbkJ3b2Z0bzA2WUNlNXFVc1FtU0FrUXJNUFVTbDAy?=
 =?utf-8?B?TUtBWlQ0bnRPWklheGNWV0hZdURRUGdROWpGZ1ppK1ZqQldQV24zR2F5S3pY?=
 =?utf-8?B?YVh5QmgyM2h4c1JicDhIbk1TODFXU3RpTExVRFVXTWZDMC9SLzZsaWE5ZkhZ?=
 =?utf-8?B?MjhIMkg0bWNhQW5YUURTeFBDOFhWMlJiMDM5aFdFMlJoOWZJQ3BQVWg2Nmtl?=
 =?utf-8?B?SEQ3aW0rQ2Q3RUVoTlcralRIc2M0VER2dldYUGNSbjQwYldOVXM1UHk2RElx?=
 =?utf-8?B?L3lvUUNUbFBpL09mWDEyMTF2RVRNajh1Y21JN2JTN3UwaWJ2YXF6aDBodTJz?=
 =?utf-8?B?R1ptQkIxUVZwckYvMmFzbTM3TitIaFl5NExmVDRxWlpLTUhLN3FCVEdRT1Iz?=
 =?utf-8?B?VWNmSDhEZ2xXa0tLVnNoYTZZTXlENTBEZUJXWGlnWkVBQVpCNXVaRGU5ZnBM?=
 =?utf-8?B?RGdsaEVTL21xeWQ0UWVBRmNodlo1WWp4V3pybkRkaEszbnJhL09CQXB6bXBk?=
 =?utf-8?B?dGxEYzJFbk5VWGN1LzRIdGNNMVdCYVJYV1hsUWN6dXBaNExGaklDVCtBV0Fw?=
 =?utf-8?B?WnBBYWNCVGtsZVpWUW5zbGRXSnRpekllOXhCNnNvZStIWHk3Wmg2K1Y3UHF6?=
 =?utf-8?B?NDdJMytVbTRidUVPaHROcjdsTklEYlhqbmltODM2blJsdkxud0xMWW9oYmlS?=
 =?utf-8?B?VkpFZHBBZlBKa0t6QWljbHBNRDBFZ1Nqdi9wNmhVa3BNSmFVb1pKUlBmazRn?=
 =?utf-8?B?Tk51L1dmYklQc3VEOTc5KzNqS2NObUdLVlBVV0gxeGdYTnE3UG45N253U1o0?=
 =?utf-8?B?UGxxVTh6TUhMdTd1bnNCbWtZcnY3U09sQ3FHbjYvUWE0MGdYVU5vOFFqaklF?=
 =?utf-8?B?aERTbDdTM3ZWUmw1ZHZKQit3endwMEVlcGd4aW9ENDRpNitLM2M4cGF5Qllh?=
 =?utf-8?B?cFEvQkoyTjZnSEg3TTdGRUhONHlTcjdKWVpHd1l0c0hIRnBrYkZLK29TYW5v?=
 =?utf-8?Q?vGSe8Ba/LzITxxXHS1VERlIdp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc5481c-21ac-430c-7a64-08dc4ed83831
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 03:36:14.5812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TyRWCYw6jhvWE74dMfjKT7IaRPggxdTiTgPccRda51hUHyBF8popqcruOocVQxrE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8838
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



On 3/28/2024 8:49 AM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only - General]
> 
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Lazar
> Sent: Thursday, March 28, 2024 11:06 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: Reset dGPU if suspend got aborted
> 
> For SOC21 ASICs, there is an issue in re-enabling PM features if a suspend got aborted. In such cases, reset the device during resume phase. This is a workaround till a proper solution is finalized.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc21.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 8526282f4da1..a5305ce9b4bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -867,10 +867,37 @@ static int soc21_common_suspend(void *handle)
>         return soc21_common_hw_fini(adev);
>  }
> 
> +static bool soc21_need_reset_on_resume(struct amdgpu_device *adev) {
> +       u32 sol_reg1, sol_reg2;
> +       bool sos_alive;
> +
> +       sol_reg1 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
> +       msleep(100);
> +       sol_reg2 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
> +       sos_alive = (sol_reg1 != sol_reg2);
> +
> +       /* Will reset for the following suspend abort cases.
> +        * 1) Only reset dGPU side.
> +        * 2) S3 suspend abort and TOS already launched.
> +        */
> +       if (!(adev->flags & AMD_IS_APU) && adev->in_s3 &&
> +           !adev->suspend_complete && sos_alive)
> +               return true;
> 
> [kevin]:
> I think we can adjust the code order and only read registers when needed, thus saving function process time.
> 

Agree, will send a v2.

Thanks,
Lijo

> Best Regards,
> Kevin
> +
> +       return false;
> +}
> +
>  static int soc21_common_resume(void *handle)  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> 
> +       if (soc21_need_reset_on_resume(adev)) {
> +               dev_info(adev->dev,
> +                        "S3 suspend abort case, let's reset ASIC.\n");
> +               soc21_asic_reset(adev);
> +       }
> +
>         return soc21_common_hw_init(adev);
>  }
> 
> --
> 2.25.1
> 

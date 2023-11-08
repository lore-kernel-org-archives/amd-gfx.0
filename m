Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51457C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Nov 2023 09:59:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CCDE10E32F;
	Wed,  8 Nov 2023 09:59:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D69DE10E32F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Nov 2023 09:59:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFjuIujTmic9/l/KjtUUl/81CLOsT7N2AUPaurcaCfNlfXAuXTXyDpWbd/n2EL6A9AtHuISxptEBdtCedJejYrqGdUZtaSVnGWurQLUhQpoji692chJYu4wZFxE6YjhFwVUfQP8cgiJxkGByWOEc1YbZanXzlG5zb27nSDCO/HddTnGMKRum1VdM4Kw9VajIP7SRAmas/xMlf0Yg4Hk4y4sV0GqLBlQscUSS5t96ILg9FNDSjDWrKo8bm6ljAEInANHWTE5PE4A3Ckm6ZsDjFiTfkEq3OclvLcCj9u72ftJxP/9suuVjT89tA/j/k/6nhdJ46dfQaHAL61Sk4oWmWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzG+CG3oLdtOY7laNzWEGhqAq9qWKQVzjPhefDXbaMA=;
 b=HbKZHMe2tUBjugtIQ0SOGDG/fMZyT19rlxuJwcEYO5TjGNHZu/X7SBE2rI+jHPe/PAKaK8tbfw6TrNJrgj2GL/ehYndSXCqXgIFIVBbAtGZkPfMtmbz5fR1D/vL03JQgCbopuaH5e4pxCEzQzUn7SXNR0EuiYEtVNKBilQPBACaECcy6pJqFA+Ja2jl6zaj7UXP05XFhBW6kGyP3puy1COW/RRooB0OUcgiY3aOfYN01YiyEgsSy632WpDhR5+Itn+1U8nb/63yjHUAtr+rsvti5PHQUTBU75F0WlWHcJgOryrT2U3MNMUyR2ZQQMQ8i5kJXR/dYDmkXrz9l/8t3/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzG+CG3oLdtOY7laNzWEGhqAq9qWKQVzjPhefDXbaMA=;
 b=zn06IdBUcvcDgnqwAiT6t5SLxSTDlOfEvL8jengaw02W0yO2HceLWCqWHN/OHWYlW0QSxqZZvX3vxgKNfleL/0EdL1eKBTKifm5F/JIOCLnzdV/rjjfNt/CcLMNaCN6l1MtF+eKL13EQIBv9IK/EMDa4ZyytHq5m6iRY0o9q94A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by MN2PR12MB4552.namprd12.prod.outlook.com (2603:10b6:208:24f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 09:59:44 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::ce36:81fc:9c50:c892]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::ce36:81fc:9c50:c892%6]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 09:59:44 +0000
Message-ID: <27de2665-5694-d1d6-435d-0b5a7b00f7b9@amd.com>
Date: Wed, 8 Nov 2023 15:29:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/4] drm/amdgpu: Add flag to enable indirect RLCG access
 for gfx v9.4.3
Content-Language: en-US
To: Victor Lu <victorchengchi.lu@amd.com>, amd-gfx@lists.freedesktop.org
References: <513b2282-2f88-d837-ff37-6bd04641e833@amd.com>
 <20231103145654.2651-1-victorchengchi.lu@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20231103145654.2651-1-victorchengchi.lu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::6) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|MN2PR12MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c43176-dd2a-45ed-c26a-08dbe0416e90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YIJh4oLLmougpp9yvL3f7+mi/hiAt9ppzRA4uyJAEEtjt6HRG1WFalns1rGRBPqUZ4kKxl5wxNcwzzq+sTbPkXRv3hQ6k9HlqCSJS6Tiu0R4/mnPlLyCPABO9RzN2aZ5EUH+8uJHL4OKiS3wh9HXryEhkM32j001sqJmBRpKwuHvTZVjowX5qeL0QpH5y5/1vz0CWEeZX+ynoGqpVXu7n3BHl694rCAowjHPm3mPNviuaw3wAGvmy3K4lg/X5XjfTCP0hYoFZyz9OEAtW2AFei2j+2kuRAqicNKvS7mZJPyJ1aLZJJiLquFlY+UnAcTrmpWkK4Ean/l1ig4398EvjO322cKNV9AjCXWy7uZd+Prx7xeQmo9RAyZrY1f5AVideirQ9hOOCnrFxz3gXHxen6TCke3+YjGNoJqu2OcGWRs/1LKHvJrb0Cp8cLODohoLqvrWF7BeDTo1oG05cMSTp6BlmEwJIe2beZW+/YLXDD399YFbipf+X4AQcgQbsM6gv59WcpwI0aU0pPjZDnU9eJ2T/THysXdBCCdBQFHaBQ0RqvLZG1CyZ4jB82R/o+f1zla+TpmSLnixEb0RdEIw13SAA/O2WvlEBjyCBnuSZFF17n3oce1nEO5UWba5Mz+PaRqhIHVuJhaA3pEXLznUDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(5660300002)(53546011)(6506007)(6512007)(2616005)(6666004)(478600001)(6486002)(4744005)(41300700001)(2906002)(26005)(66556008)(66476007)(66946007)(8676002)(8936002)(316002)(4326008)(38100700002)(36756003)(86362001)(31696002)(83380400001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXhtZEVzWTNONGx0TkpJaDVVeWRnaW9EM2UzVGNPdmZhWHBia0VrZUtxVTlj?=
 =?utf-8?B?bFNGOVJzeERTQ0wrYzFBaDZLUU1kdnJKcWpYL3ZSeXdoWGtJVjVZUGF6Zkdw?=
 =?utf-8?B?VXJMMkZlbGxzV3JRZlF5YWxBQnI2ZlU3N0FIbVBRTTV6dFdLckFGY2lOUXo1?=
 =?utf-8?B?bE5EcEtsUHA5bzJhWHBTeWRnUFRWcWRSa3lQcDdtbGd5UjFaVVJoZjF3dG8x?=
 =?utf-8?B?SHlsZm4zWWlVTEFjU2NLbWtwUDdEbGZwb3ZOOGpUeHVGSHRTY3ZXRFZiRDZi?=
 =?utf-8?B?RjdkTmJtUlpLVTE3VVIwS0ptTzdhdU1WUnlYakErYUVxUFRxbGxaSzY5emxO?=
 =?utf-8?B?djBsaHNWeWx3Y1pMSUxVbUwvcWYwS3U3VGswM3dCaHhpVEx0Q1N6OThVcFJV?=
 =?utf-8?B?WGdCNzZoVFdPbEFHN1ZEV1pTcjZ5YkRoYi82RFQ1UldldGhDdjRyVzd3RVdy?=
 =?utf-8?B?eFR5Nis2bkdESnRKRitoY0VZWkFUdmxHOTFHMnFHTzRIRzEzVy91ekFlc0hC?=
 =?utf-8?B?WTFTVi80bFdsWCtJbUlQNzBrVSt5a1I5blVIZDdSSXpJOEVmZGNwNmNiZGht?=
 =?utf-8?B?RUtHek9GR2d2aW1zMlZoNy9wdklKZ21HRVYwS2NZanVuWDNKV2hVUXVUMitT?=
 =?utf-8?B?R1Y3NWRnbzdmc0laMXM2clk5S0tkUUNCYm1tVTZTVklRWURoMTN1WFYvTEFQ?=
 =?utf-8?B?eEdZQjQ4WWlGOFQ4VmxnSURpU1JWa29uTko4dFNjQTd1WTIyQ0lpZnJBbVNR?=
 =?utf-8?B?QlVUeTNqamtlMVMwSkpVWEFIY3dsWkZDd2Zydm1HR0hwU1gyTmJyN1Z4UXNE?=
 =?utf-8?B?SVFDTkI5ME9BWUt2Si82NmVxd1JZcU5wbXA2MEtrTGViUWp2Vmg0YVJGSkFs?=
 =?utf-8?B?SEdkKzF0Mmh5Qk0xbzB2aHlsV3Yzc1lqRmZDVGJiV1RQS25sNkFEdWRrWldt?=
 =?utf-8?B?aEVYTjVicHUzMVcrZE5iSk1YbFNmZXZubVIxekkrVG52anpWZkc5VXl5UUo0?=
 =?utf-8?B?RXhSR0QrY0ZZa0RkZTI4VW4rdnppaTJxYW5vZkdmZTNBRlVrb3drZUh5cWg2?=
 =?utf-8?B?NTQ1M25QcXN3cjZLOHhsek1UM1ZzSWtMc1FMRGJzVFZ3b0Z6TGQ1ZklMYm1X?=
 =?utf-8?B?Q3NYeW05R1FhOGh0YkpobU4xeVBVT0lFQU1pQi90T2NJZ3BQTERMY1ZySzNC?=
 =?utf-8?B?NGdibTBhRHBXMng1d3g1bnM3bUw3QjYya3h3Z2NVRkcyOXVGdXExKzdOT2Fw?=
 =?utf-8?B?d0ZBR3d3SVlkOFo0RmRSZ2FSSUxiRDg1eGZGNmU4QVJ4NVJJN0kxVy8zb0VD?=
 =?utf-8?B?Q3VRS1dCZG1Janp3R1B4YUtXKzhhOWxLMFpjelh3WExyMklCNzVjNDJ0QllR?=
 =?utf-8?B?V01hVHk0K25xRGM3cnUvbHRUYzBiNUxpOGprZEZZOUN5dVd1R1pvNW5pSVFW?=
 =?utf-8?B?di94UUZydmFMWmlDVGxZVU1SUzh3K3NVdlh2YXl1enBBNXNLUHZXVnRvQ3k1?=
 =?utf-8?B?YTZKNkdtdmE4NTE5TWM0Z1VFUmZWSU1PTjUzV05KTkxlUmVmdmlBUDAxTFBh?=
 =?utf-8?B?TlFobklCZzJreDAwdkZrbFF3SGtROTNuNEhzSGxlcGk1c0Z1N1ZrdGl0d0Fn?=
 =?utf-8?B?eG42dVdLVnBSNm1SbUo1VVpETlA0L3YxUERFbXBFK0EzZjdGMk40Nm1vZDQr?=
 =?utf-8?B?VlBmZ3pTWExVZW5SdGt4T0JxeUViVW5ZUUNEM1NqVzN1VWJLOUNCQTB4WWww?=
 =?utf-8?B?eFVQU2VXZ2JwZHB6VC9SQ2JhUmhzN0YzcFAxcW9aRVBzaFdzc3N5L0E3Q3U3?=
 =?utf-8?B?KzZVR3BralBTakk1aU1VV3lPd2huM3dGWlZIN2psUTlsQ25TSEJwbjB6a0Rr?=
 =?utf-8?B?SkdES25YeGdWdzYxNmI5R0ZiWXZOc0RhN2haOHZjclRuYlFlcFEyWkRUN1Yy?=
 =?utf-8?B?U1p1MzB0R0pHMktXdTJLYVNOWUFLc0RRR1JRcUFuTnRMbi9MNk81MlBJanRz?=
 =?utf-8?B?SmZHNUN3TGhLOWJiamxzajRxNFJ4ZXNFOFFtUHAvRHJqdmJ2VkN3c3pmYVlE?=
 =?utf-8?B?ZTRYdXkzSFlRQ25xTUpkbmIycHI1Zy8rTVNybUlDdkJyQ0ZFVHpkMlczRFBH?=
 =?utf-8?Q?a83QCRIefPNDE5eRagC0PySs1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c43176-dd2a-45ed-c26a-08dbe0416e90
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 09:59:43.9820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etKK4cyKIPcr97u6nwn/UtKCQTcEKOgEzIhtkeBj1KefhR+L9/tDY0HtZmLMmyu+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4552
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
Cc: davis.ming@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/3/2023 8:26 PM, Victor Lu wrote:
> The "rlcg_reg_access_supported" flag is missing. Add it back in.
> 
> Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>

Series is
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index a1c2c952d882..ce2a9876369e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -1101,6 +1101,7 @@ static void gfx_v9_4_3_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
>   		reg_access_ctrl->grbm_idx = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regGRBM_GFX_INDEX);
>   		reg_access_ctrl->spare_int = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPARE_INT);
>   	}
> +	adev->gfx.rlc.rlcg_reg_access_supported = true;
>   }
>   
>   static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)

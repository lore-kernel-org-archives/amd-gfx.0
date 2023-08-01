Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224DCC0015E
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Aug 2023 17:18:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C248010E138;
	Tue,  1 Aug 2023 17:18:16 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E1D010E138
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Aug 2023 17:18:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTh3J3pMB19iyrEzXeuIh9R9Usfm3SBHCBzkoFNM6v98tb3dMQBBiwtSfarJuB5RV2ABxkZZw6WGkEzXW+HoAID2jFypn7p/vNDXawTsbfKY9yCnUugC42D9fVcFQeSZFwmr6bYd3Ql411ciPY2HrU8DvsTxKUk1pCGtlhO1JQ4iDGL0rWdqJGMTq+Wzhkcx5HCAqczbg/Y/0Bxo0TL1VmHMJcVVk11VlhZRoCX8rRxA1SXLUuthtuzUGF3yr4QZlFjk55C7SjcN6Xpppvv7HdlIdf9DSrysxS6ZuY2VE4S1UZge0CJkvnjXiVMXoGBimCywiLQSD4GlMm7UAocs6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ofmv63u1/+j9s1FGvuR2xrjZf8vqk5aqcq/+LKMvS8=;
 b=C0D7Od637BmSRkHC0JdxMg9QuuKYc9ZrOqr3keupXOy+AYBA3Hslq81vnq4B5N3m96TcyKRUy1yGpP0iR+pxEJH4j7RUZInO0DdB2XPoQ0okfHCrepWx4RYNe6lvqvD1ksPMuLU09+z412w1JWuRrADTBV30yHVXnUJPvSSTnXhO23fN8u7q24H3gSb8gtY7NzdpVTx+qkpIAAL8KLoCzACXWumeW+LbggFBFFPCMTg4VnabS+dXPVqjiZpe54d9GXCCFlPqmVg3wP4AHzB/qdRfxacVlLOIcNquxTRkzmFXusor+OaF7X2ebK4rAy0KqTOFhgMcWv8oj5bZV6XUqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ofmv63u1/+j9s1FGvuR2xrjZf8vqk5aqcq/+LKMvS8=;
 b=TQuxDzn2orxi6i1XJIW3nWVjQNsMsW9+IokKdDdvJC+pBRVk478iImEgz4gv7sJ77dfGTVJ1fS5sGpfWr4Vwo5OANC38GqBnnEubDWbo3vvTRQpxCesSARpxdYV5W3kve3nJDh3LmEAXm7ADw3S6vA/2ulsX8/AnJGdgWTfsczI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.43; Tue, 1 Aug 2023 17:18:13 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8a67:3bbe:8309:4f87]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::8a67:3bbe:8309:4f87%3]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 17:18:13 +0000
Message-ID: <5a44c702-7a40-555a-fa9f-beaa6174c0b0@amd.com>
Date: Tue, 1 Aug 2023 13:18:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Prefer pr_err/_warn/_notice over printk in
 amdgpu_atpx_handler.c
Content-Language: en-CA, en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 Pan Xinhui <Xinhui.Pan@amd.com>
References: <20230731121815.2852832-1-srinivasan.shanmugam@amd.com>
 <20230801050146.2970696-1-srinivasan.shanmugam@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Autocrypt: addr=luben.tuikov@amd.com; keydata=
 xjMEY1i6jxYJKwYBBAHaRw8BAQdAhfD+Cc+P5t/fiF08Vw25EMLiwUuxULYRiDQAP6H50MTN
 I0x1YmVuIFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+wpkEExYKAEEWIQQyyR05VSHw
 x45E/SoppxulNG8HhgUCY1i6jwIbAwUJCWYBgAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIX
 gAAKCRAppxulNG8Hhk53AP4k4UY5xfcje0c5OF1k22pNv8tErxtVpgKKZgvfetA4xwD+OoAh
 vesLIYumBDxP0BoLiLN84udxdT15HwPFUGiDmwDOOARjWLqPEgorBgEEAZdVAQUBAQdAzSxY
 a2EtvvIwd09NckBLSTarSLNDkUthmqPnwolwiDYDAQgHwn4EGBYKACYWIQQyyR05VSHwx45E
 /SoppxulNG8HhgUCY1i6jwIbDAUJCWYBgAAKCRAppxulNG8HhnBLAP4yjSGpK6PE1mapKhrq
 8bSl9reo+F6EqdhE8X2TTHPycAEAt8EkTEstSiaOpM66gneU7r+xxzOYULo1b1XjXayGvwM=
In-Reply-To: <20230801050146.2970696-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0352.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::21) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 031b433f-100e-415a-2aa1-08db92b34940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H78dTYVf69BaFSiGh9U85mESkwdax84XfNRhRHdhQ+dwfVflFLdVQnA/vSshRwrIozK0Ka+pfA0hS3gW3jHCthXN+R8uE6Dg9OaL9ilgNoWZFAJrcJXvpsnrZNmX1nZqeb7VOFEB6Qy4ktUQFTSKyg/N2vqgV8xS05zVx0KrgfxQY7zTfFzxE2Mpa4AzuX7zp1yNQnEN6G+iV84UZKQbWO4I1zVBzvpd5sEOEUy9P5KT8RRBeheXSxlN8gEzo7wsMNV48AK4EMfF9G1qYWCQL8tdFgEfcAmGvQDsRHpNj/0SmCz51qBUMw00MLS5cmMSgE2IxqvXttWzG0bSx8BM89XVDCaA1CBvXR179kVFHdiBLQO/wbtlHjEc5yqwy4CIhRNG6a/p3hdFTLQCOEGUgOfDO9ASnUnitFmCvoedS/N/SyLUXz1U+EmRTBvHcxCryhOk5lplqcUEGmQCfx8wM+y/FBJrBEWrbIiZWRbgvvBVKWMflycvAl5X2oJkNpBt/TnA60DcJ4GsmdvLzU/qdaZt87rqyxNQGUI8WFTqNbw+MTIMxhRQHJB5pJ15twpS2WIllT2JzjTsDSS2ypOOo2UBA8G6XbZ4MQY2iHOfFyCyKyi+O99QKUJy118bLiA5Q1/gqvY0iB03ENPXsy6OaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(451199021)(478600001)(36756003)(38100700002)(86362001)(31696002)(6512007)(6486002)(2616005)(53546011)(186003)(8676002)(26005)(8936002)(6506007)(31686004)(5660300002)(44832011)(2906002)(6636002)(4326008)(110136005)(66556008)(66946007)(66476007)(41300700001)(316002)(66574015)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVdJQnZ1bEFKbTkwd0p3NURuOUlZaW9EaCtSNk9QVHpRdGsvNFpOcE56OGVO?=
 =?utf-8?B?OTZneTRRNzRpdlZlQ0xrcG52MlVMT1MramIrOS9TM1ZIb2c1eHFmWm1zbTNs?=
 =?utf-8?B?OGFzV3lxL1R0alhJL0NqSXVlbTFjUTVwc3BTYWYvNzFDZ2FML3c3TUlScC9D?=
 =?utf-8?B?YkphUFNTaVRxK0Iwd2tiL1FYeERSN05HVkdPQzdocngxNGRtRG01YmZCQXVj?=
 =?utf-8?B?SFg5dVQrYUsyUEcyRlVrT1dicmQrQ244bVFnbHhoT3lObWQ4UUJCSExZejVW?=
 =?utf-8?B?MHZVRkp1NXJJN1p6UmVaZ1JvTW1CQi9vckFVUkMwT3VIZldud1RHa094cjJt?=
 =?utf-8?B?M1U3WEdoWTJxOWtMS1YrN1hjR2RxRnZSaDdMMVViM0xMd1dXQkIzSTZleFZi?=
 =?utf-8?B?QUp2R1VhK0tUWWF0b2lnYW5qdFpZYmxaMStpWE9NQ0o4RmFuZUFPQVFMQjNk?=
 =?utf-8?B?b3R0MWwwbC9yTEtuMGpIQUpxS0VSZjZZV1B3clRUd3hXWGI3bmFVQ040dFB0?=
 =?utf-8?B?d0V6N0REVHRxdDBqM3d2azVRQWNhN0ZrODhkWVljZWIxV2lPSjIxa29CTWxZ?=
 =?utf-8?B?LzJVczl0YjJHNmx0T2pEQnhjSlhHZmFxRENtTGd1RDVJSHhRVkpIS29qbmdU?=
 =?utf-8?B?U0tvTGhvYnIzWGRHbENmRGtzL2l1akdOK0JlYngvZzJmaS9ob3N3OFpJeGN6?=
 =?utf-8?B?STc1QTBPSkh0dE5PdDU1R0swZG1jMFg3cUU1bll6TnR2N3dKdy9HaG5aNFU1?=
 =?utf-8?B?WVBmNE1ZM01NMGh6MHBiZGhucXQ5bTdyd1dabFQ2c0dMcVJRa2hlaUI3VVhp?=
 =?utf-8?B?MVJFaUFKQmZkN1NPdXd2S1YvZE1pTml4clV5ODE0N0lzb3ZVUzN2R2JUa2ts?=
 =?utf-8?B?eWNCZXl3S0NOVGMxUmZKWkh1bDduVlRFZ0RhZHZFN1VDRGxIa0ZqM2VFTEEx?=
 =?utf-8?B?b1U5UFJkY2wvY2t5Ulo1TFFhb1REeHpvTThua3FON3J2WnRMY3EwQXlpRzZX?=
 =?utf-8?B?Ris1WjA0TVZjeEJxaGdOYWxxSjNxYk1qcTIrOURrQVErazAva1FWVlE5NzBF?=
 =?utf-8?B?NHlGQlpJV2VMV1p1RWMxYi9oRmlyc2RPc1E5dS9yL2NWTnlJdUczbHpqYUli?=
 =?utf-8?B?VTZLMjV4c3NTb2J6bVpRNnR4NjBZeHREY21md1BCWWxueXZOaEkyODhWWUY2?=
 =?utf-8?B?UXlUTWxMaVpScGlrRW9YQ2lFL01xQ2lHUlcwem16Q3Z1OXpzQ3ltMG5xY0M2?=
 =?utf-8?B?UThOUy9zMUFTcjNIUG5jUjRGNXJWOTFoMGUvVTdNYWVQclZSRWFxL2JhSVAv?=
 =?utf-8?B?TUhlbUxNZ0ZCNTUweGtUQnpjQkdMRmgyeU16MDZWQVdqcVoyR2dzL2syNkk1?=
 =?utf-8?B?VUdvbDdNTVNIc1crQTkwbi85aG9pdldteU9VRjJ4emgyQ3lzMzNCNnJ3dnl3?=
 =?utf-8?B?TDdDSTFqVzdRalVvZDNHZTBmcHBxbmI5RGE5MDFXMHdJUDRPVkJDaE9qNUlX?=
 =?utf-8?B?WWdZSDlhTkhhVVFuOTZZVDZBbkhHYmZIVXd0ZS83cUg1YmIrL3NVb0ROeEVZ?=
 =?utf-8?B?bzNmcFA4N1ViUmVBTlltRGVKL293UWFGVTd2NXhBSjJnRlVEWmE5UFE0RDhu?=
 =?utf-8?B?VHN1Wm9WQ2pFM0RUcmgrTURwZWlUWXJiYWE4Wk1TYnJMSS8vODM5bXZ2L1Iz?=
 =?utf-8?B?MkpGV1JMWURjZXArVGxOV24rU2UxUkRjRXRyWHA5VWRVbWt1Yzd0NDFvK0s1?=
 =?utf-8?B?WXlReitqUFJray96WkNxalVXUzVYb2ZUV1NkRm1kL25WMGs4aTVNbzdIazR1?=
 =?utf-8?B?Z1dGSVZOOWRaakpRdlprNGdaS2JXTE16cFJvTlQrYjVhcWxHc3dqR2RuWkdx?=
 =?utf-8?B?VzBLeEdqYWN3RldFNnRuRE5vcDRnbXRvL0hoU2FjeVdqL3pRdm5qRmsvekNY?=
 =?utf-8?B?ZTg4UUQrNmJBWVZGMFBsdTgvQVlETzI5RHFPN29FQmJpQzJPd0lkeFdoZGZI?=
 =?utf-8?B?UU03dWMxeFMwazRmUk5RMXFPc3B1b3lsSi9lenZsTVEwNlpkSldZbTJqMWwx?=
 =?utf-8?B?TnhvZFdBeU9FS2hkTmNEYmVsa1N1VnI5TWRaUGRBOUZFalo2VVp6NUJNMUtm?=
 =?utf-8?Q?V9TCB38rilxBG7wypfgRXSAiK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031b433f-100e-415a-2aa1-08db92b34940
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 17:18:13.0826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GyPlxBk2TeLwOUOu6WaakCFEdOXCYoHkfVo1kKXnkR0jF083B76ObZ3IbN3HxWH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932
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
Cc: Bert Karwatzki <spasswolf@web.de>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-08-01 01:01, Srinivasan Shanmugam wrote:
> Fixes the following style issues:
> 
> ERROR: open brace '{' following function definitions go on the next line
> WARNING: printk() should include KERN_<LEVEL> facility level
> 
> Cc: Guchun Chen <guchun.chen@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Bert Karwatzki <spasswolf@web.de>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Cc: Luben Tuikov <luben.tuikov@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Yeah, looks good.

Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

> ---
> v2:
>  - Updated commit title as per log levels updated in this patch
>  - Updated with appropriate log levels (Luben)
> 
>  .../gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c  | 29 +++++++++++--------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> index d6d986be906a..375f02002579 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> @@ -74,24 +74,29 @@ struct atpx_mux {
>  	u16 mux;
>  } __packed;
>  
> -bool amdgpu_has_atpx(void) {
> +bool amdgpu_has_atpx(void)
> +{
>  	return amdgpu_atpx_priv.atpx_detected;
>  }
>  
> -bool amdgpu_has_atpx_dgpu_power_cntl(void) {
> +bool amdgpu_has_atpx_dgpu_power_cntl(void)
> +{
>  	return amdgpu_atpx_priv.atpx.functions.power_cntl;
>  }
>  
> -bool amdgpu_is_atpx_hybrid(void) {
> +bool amdgpu_is_atpx_hybrid(void)
> +{
>  	return amdgpu_atpx_priv.atpx.is_hybrid;
>  }
>  
> -bool amdgpu_atpx_dgpu_req_power_for_displays(void) {
> +bool amdgpu_atpx_dgpu_req_power_for_displays(void)
> +{
>  	return amdgpu_atpx_priv.atpx.dgpu_req_power_for_displays;
>  }
>  
>  #if defined(CONFIG_ACPI)
> -void *amdgpu_atpx_get_dhandle(void) {
> +void *amdgpu_atpx_get_dhandle(void)
> +{
>  	return amdgpu_atpx_priv.dhandle;
>  }
>  #endif
> @@ -134,7 +139,7 @@ static union acpi_object *amdgpu_atpx_call(acpi_handle handle, int function,
>  
>  	/* Fail only if calling the method fails and ATPX is supported */
>  	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
> -		printk("failed to evaluate ATPX got %s\n",
> +		pr_err("failed to evaluate ATPX got %s\n",
>  		       acpi_format_exception(status));
>  		kfree(buffer.pointer);
>  		return NULL;
> @@ -190,7 +195,7 @@ static int amdgpu_atpx_validate(struct amdgpu_atpx *atpx)
>  
>  		size = *(u16 *) info->buffer.pointer;
>  		if (size < 10) {
> -			printk("ATPX buffer is too small: %zu\n", size);
> +			pr_err("ATPX buffer is too small: %zu\n", size);
>  			kfree(info);
>  			return -EINVAL;
>  		}
> @@ -223,11 +228,11 @@ static int amdgpu_atpx_validate(struct amdgpu_atpx *atpx)
>  	atpx->is_hybrid = false;
>  	if (valid_bits & ATPX_MS_HYBRID_GFX_SUPPORTED) {
>  		if (amdgpu_atpx_priv.quirks & AMDGPU_PX_QUIRK_FORCE_ATPX) {
> -			printk("ATPX Hybrid Graphics, forcing to ATPX\n");
> +			pr_warn("ATPX Hybrid Graphics, forcing to ATPX\n");
>  			atpx->functions.power_cntl = true;
>  			atpx->is_hybrid = false;
>  		} else {
> -			printk("ATPX Hybrid Graphics\n");
> +			pr_notice("ATPX Hybrid Graphics\n");
>  			/*
>  			 * Disable legacy PM methods only when pcie port PM is usable,
>  			 * otherwise the device might fail to power off or power on.
> @@ -269,7 +274,7 @@ static int amdgpu_atpx_verify_interface(struct amdgpu_atpx *atpx)
>  
>  	size = *(u16 *) info->buffer.pointer;
>  	if (size < 8) {
> -		printk("ATPX buffer is too small: %zu\n", size);
> +		pr_err("ATPX buffer is too small: %zu\n", size);
>  		err = -EINVAL;
>  		goto out;
>  	}
> @@ -278,8 +283,8 @@ static int amdgpu_atpx_verify_interface(struct amdgpu_atpx *atpx)
>  	memcpy(&output, info->buffer.pointer, size);
>  
>  	/* TODO: check version? */
> -	printk("ATPX version %u, functions 0x%08x\n",
> -	       output.version, output.function_bits);
> +	pr_notice("ATPX version %u, functions 0x%08x\n",
> +		  output.version, output.function_bits);
>  
>  	amdgpu_atpx_parse_functions(&atpx->functions, output.function_bits);
>  

-- 
Regards,
Luben


Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5664AC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 15:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 197B460F0F
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 15:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 197B460F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A12246EDA8;
	Thu, 23 Sep 2021 15:58:48 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21E5E6ED91
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 15:58:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjkGNXMxiU9iNkN5LHu2kFvDgH8Fwr09K3e8XaobH4C2i21oVdzPSSClVodpo37VULXWciTxhjKSINCVTv7IAMDiy9+jTDIgqZa8mJ6mqoBywrk2EN3c3wlJWxR8W2rUNgt6euQOxkQH9tDmRvUDnBXk5RpY9C166D/+o2n4ef1tJHaniDHIp8h5lhfCdfxw1soP6Wy9xVwiVPV1+Aj7hke/Bn8c8Wac3Xv54QE5iV19+triEXGjupEMsZtvjxjEJdUYhF59hX3/KV+hxwnWOykBT4HMgCe7YgBcfHS5a7Ty5XY+oQ2PDbt/MEaFqSutCDUAxGps/eL6xhnCpV7nRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=24kqd2DHzo6BgY4u7XEbjSSe6Ly+/t8iHxIBUAqsu/k=;
 b=g+qgj2pwLiBshJImUuSY1fImv7HW3gJZIndH5HS6mgI0mwk9pPx+BRT6uNMA+bbtFJ0mToJyK3ocWvyN3Wruk2I6knlE0D/sVLoXx/YGBN2W2g2Pn1u3LFn65Cufvqr0PgBGqx7irUsTyiBTqJi//a3k0h4I3O9jvz1tsQ/LwtMyJU1V1WncNL/YL9Of2DZJkKJaVvQrebZUpO6yRqZgEC6FeA5n9u1KlXKjgYPTzQF3H3sYrsMYXbGD9JWA9RwtXSsG/0lV8WrLShP2CELrMV+k/0az2dl3CEv1K8/GwA3MpYsvUeHiCBULrYXPlhgwCgPAbU6bzdWQjtISTPQyJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24kqd2DHzo6BgY4u7XEbjSSe6Ly+/t8iHxIBUAqsu/k=;
 b=FEjMJXFFLaLqYuvRmD6CzcnUPJHJGC+0KIorHmXOftlwiROk4A9Yq8z+SlGh1tWxegOdmryegJSV6k/Djimx9twlCPIDUrYhjBaGGzXa2wmVCvrv7z23wVgDhq0pMfKibLzgNILVwJgPMIwsMoy/AbNhz8YKVRRTTKQxMdXhnBw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5475.namprd12.prod.outlook.com (2603:10b6:5:354::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Thu, 23 Sep
 2021 15:58:45 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%9]) with mapi id 15.20.4544.015; Thu, 23 Sep 2021
 15:58:45 +0000
Message-ID: <a958d99d-9633-bf94-086e-aa87cb3e781b@amd.com>
Date: Thu, 23 Sep 2021 11:58:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 36/66] drm/amdgpu: default to true in
 amdgpu_device_asic_has_dc_support
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210921180725.1985552-1-alexander.deucher@amd.com>
 <20210921180725.1985552-37-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20210921180725.1985552-37-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::34) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQBPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15 via Frontend Transport; Thu, 23 Sep 2021 15:58:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 922f1521-9b6c-4ecf-5eff-08d97eab0569
X-MS-TrafficTypeDiagnostic: CO6PR12MB5475:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB5475F2B8193C6D6CE989FCEA8CA39@CO6PR12MB5475.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nVIe2aNamE2s2urdF2v5oOgJZZ2nGlFIhW07ZWfmvj2ES8ue8YTOwCZ4sdXMpNDtv5SxxRjUN9cNVz6ykEwDxqBV4GpNOBy7/0nMn/N26ebDcsQiqaNItjIBPFqG9ielfBWVJz+wG5ZQtJ9hHBaNZPVmncOYtv9lphIn5kUR3KT/nL+vScpnoQzbOrCVnyVk6fS0VZ9tZCLqtMEr7VOZxpe5xJDFmCeT0ipdI1In9VP7/5vgVx5vbuBD/A2u8lUxAMngI9e1vU4iXzkkzTEaCnpi/JsobyjcN2lwqPFRJmVrJe2CPf+XOsfkwWES3r4/99VvhYjhE/AhiS5+n/pNO9IHctjth9xSV4M9+frkkYTef0CamLq0nUX+wgq8tHUczLrWoODjyHsXRtep/fzsmt6Yt7rNzf5zdAeQ78eoj0V8iDHHx1p7pMdb5xxTxrVL1ODMIFIgv7taxOTTEw2YSIiA0egi/3VJcaqtJ5oWsigpng9MiJkWtoCpcvLvR33dkGXhFPKNKbm6CY93NADOylmyTc6MlObBbMb78guql4VptYFC46zD2EP4FWFrTOwpmXYjRc+OQlSBfU9yQYCATLzOElfhAopWN9j0ups1gksfu3mj34cDn9NbJaeU3TmLsogGTq6GjrZuZzR2TmEhVlk9C/ANjJ4E5Bwyombb7WUtBaGrmB+SWXEwtnBlm0VsxeI6zATYmRWeh76J/3JA7/jQsKjcVdhQ2XulMOYcHF0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6666004)(956004)(31686004)(66556008)(8676002)(6486002)(8936002)(5660300002)(53546011)(2616005)(36756003)(186003)(66946007)(66476007)(508600001)(316002)(83380400001)(86362001)(26005)(38100700002)(31696002)(2906002)(16576012)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXk1aUhuWFVtVUhDME5OamN4T1RBb1JwY09xcmpCOVF2Ni9nNXJjMlRINnpj?=
 =?utf-8?B?N2J5WitXSjVxMTBtTC9YVmwrL0NYeHVWR3RRZFFYR25LTmFmdjhVSmZvTmVM?=
 =?utf-8?B?UkNleHQxVTNlME53aTZVRkpSeHRiZnFZRzhVTWkwZjkvbUkrUXVVSG9ReVEr?=
 =?utf-8?B?K3gyQW45WHNMa1VOM2taaW5nQUZOZEkxVk4yekxaZWNEcmtYbFdhcENkOFJn?=
 =?utf-8?B?ZCtrblBLV1lJWnd6SjZTOTRseUl0YnpGMFF3ZDJxVnNQRTI3c25PVmsyRGQv?=
 =?utf-8?B?MWNzVnNtaXJ0M1RIVkdsUENCaDlLVnRGeVZiTFNkNjRiL2t6aWZFMzZsTHU5?=
 =?utf-8?B?ZHc3QWRPUmZvdU9VWmVrL0FpWWZUd3NUbU9ucUVtOExBdzAvRFdQRnhHS1pt?=
 =?utf-8?B?ck1OWlRCNXQxc3ZRT1lqWjlDUlpFOE42T1FSTTNmalNxcmp4L01mYkR6S1Bt?=
 =?utf-8?B?YjNzN20xYisvMThiVzVHSGFMaVU1VkxoTlpKTUdKVG5BQ29WM0ZzNTYzQVA5?=
 =?utf-8?B?SmYvZFNXZUZ5LzgzRDEwRXhDU1JqZ1dQaGFLUzBTTjhWT0hSWlNSVnZqeGxi?=
 =?utf-8?B?emp1VkhOOGlKQnhjYlVUcHd4TnRhSGhrajliRjViZk9SdnRncXd1bXVEb0kx?=
 =?utf-8?B?dGM2Q0E4ekNMeUV2Zzd1TzRqSEpVYUVQTDlwL1RPUFNvak51TlR0dlRjeUJK?=
 =?utf-8?B?SExvQklqc3owY0c2aEw1b1ZDejB1ejNaSGNaNWZlakx0OWJPZm9hNEF5cDIx?=
 =?utf-8?B?NVU5d0M3RTgyMldjaGRXQ1NaaWxxcEhhM05idWFXYXY0ZzM1ODByTkJ1YjVW?=
 =?utf-8?B?MytMNGM3cDVCdVA0LzlqYlNYdldjTmVMQWhnWVdZVFdmWW5keXRORENoZHNP?=
 =?utf-8?B?Q2cyN0VVUVNwcXBNL2lKQ01uZ1d4SEFubUgrTGVidXlqNzVDc055MndOc2Rq?=
 =?utf-8?B?cGNEcmxMMHQ3eVV1SnNBbHUyM1lIb3g1NnB4VjRPSVgxRVVieDBKaDJwWFlX?=
 =?utf-8?B?eERFYXJBSi9iRUkydnBtRlp3TXIxZE92ZkNzL2dzYnFFVmFYYlpoUE1wNHBM?=
 =?utf-8?B?VjNGdVlsUXRYZWluU1hPN2dtUFJydkJFRVNwNlRNc09CUS84UG5iUVJLWTFT?=
 =?utf-8?B?UE54QU9KcHZ6a1ZxZS9tY0grSjNqY0pjUVlIdm02b3lIMS9mb2t5c0hCRWpt?=
 =?utf-8?B?NEYyVEQ5ZGF3Y0RpcFFZWVdqMFBCU1RMcGRtWllXa1NJckdCbFMrOXhrRjkx?=
 =?utf-8?B?cktNbE1XK2JhT29ZU3ZrQzZ5OTNPT0Jkd3ZZMnA0K3J3T0FTTWtuTlJQUTdX?=
 =?utf-8?B?Yk9PK1JncUZFQlp6dTJjTnBLcmFlQXpkTVdZRXF3emFSR1BGTUlXQ0RrNk5Z?=
 =?utf-8?B?RjlyVEw1R29NQnh5cDQ2QmNSNzhVV1F3VTExM1FsRXZHNUg0dm1lNkJURmYz?=
 =?utf-8?B?L2trNit3WmUxcXZ3TU5hNDJwb3lDWHhKOTBBQzd6d0FYaWREUDM0cUxRUkgy?=
 =?utf-8?B?NVhmOEFsVGdDcGZTQzFtcUNmVjJIUTU0aVA0SFdlMkg3d05zV3BQaXN0d2h6?=
 =?utf-8?B?dG8yUE54Q2RzL3hSME1CQjZuVFVlN1h4U0YxbWdvaUJtN2kxMlU4eVVJdDhH?=
 =?utf-8?B?WFg3d1VvZXhsdEkxbTFldHhFV0E1YUQ1Y2Z2U1NYdENSd3FJcTg4YUt5NnIz?=
 =?utf-8?B?a0FHYUtTZ3hYOXlxK00rQkJubDBONTVBL1hGNWk0dVJjSExLWE1MU1E5OXU0?=
 =?utf-8?Q?nurUGudNggXmm1b3n56fJeHa5GzhzSu7mb/zb+S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 922f1521-9b6c-4ecf-5eff-08d97eab0569
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 15:58:44.7314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OOKte4W6kID+oB/ty9dPNv5BfmU9exmmSxpwUhdxagoxOMfPaTNEC1/1GZnSJAd2TwW36T0emc4uVEjrpDKJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5475
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

On 2021-09-21 14:06, Alex Deucher wrote:
> We are not going to support any new chips with the old
> non-DC code so make it the default.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d64e5a209cf4..3f2686296f5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3212,13 +3212,15 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
>  	case CHIP_VANGOGH:
>  	case CHIP_YELLOW_CARP:
>  #endif
> +	default:
>  		return amdgpu_dc != 0;
> -#endif
> +#else
>  	default:
>  		if (amdgpu_dc > 0)
>  			DRM_INFO_ONCE("Display Core has been requested via kernel parameter "
>  					 "but isn't supported by ASIC, ignoring\n");
>  		return false;
> +#endif
>  	}
>  }
>  
> 


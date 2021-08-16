Return-Path: <SRS0=yGBf=NH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC71C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 20:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF01760EE4
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 20:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EF01760EE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 757BB89FDB;
	Mon, 16 Aug 2021 20:18:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F6BB89FD1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Aug 2021 20:18:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3KwJgCAMISrbwjZLEc1pK08RWvBTBw+eMyRKEDU4FJ/5jyiVd+aho96ukgRR63rmbs8sYIxCQIIzZ1t549PI3+3jyvPBI6mKaqqicZYdFP8oLDcne+hmRfneQrW9qKVB7ce3oX6kaYAwayBGRs//IlP7dKr5PLGvU6SKWCtRm9b9VJSt0wE2PK1ZPtP87SFrHktt421Z9fg9N7F0e62gAgqWpOq3ZYCwQtyO7gLte+A0t5YT7UNkbULtNIwyGtEzFTH8+Sfb5AuZF6BqhThRJPPA+xUtJ6qRt5+eeGMVsFPjaM75vilBIWGUcjFZVUG6fSunLg80K8eF7pwarbcNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mD5rph0KCX6sokcchnjh9XrLaHnDBmpt+9X1bU6vr/A=;
 b=VxJA3yngIWJThl2+vvUMmlwdwdreffEQ19utxIOZKsCvuvSZZQ0ySODccFtwRXb4++Pzd68VNtek3lfmjc9073cBKTIhZEZLkpLjYP0oc1HVIxyGWHpk4Xzt7BqnGv3f7/iUkf5ekd/Cd1tURhoyXBjbxk0+63AJIf03sod7R1aCF0jwjgUIaY62Hh6RI2oevsZCyTihLMMLD/9zzFWaXmMBKGhX/xk0i0qXaJvrqfATtuBnhIIwzozMnCMZmLJuh+D5Sjv1H8edVWQHqlz3+f42fIG6q48Z9Ww/fDDk4LzM5FpgkXBsjpQH0Ptw/6KH9wXFtJT5gquPKTwmOla74A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mD5rph0KCX6sokcchnjh9XrLaHnDBmpt+9X1bU6vr/A=;
 b=g4PuU2QNy9F2veoEj0zQHfxmEP6gYJUfOKs2jVLQDYh7RrOIaA8BvoFnTPj+dX+rks4F57Z1Ue7RSMIB58C2JoPdpeflcT04ijuaRI1errMgj/i+MuO2iXU0lgA5RXtLAqUkiar9uYNPu3fZY/I12j+aTUdx8/HOOR/V8IT+cXI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5460.namprd12.prod.outlook.com (2603:10b6:5:357::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Mon, 16 Aug
 2021 20:18:47 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e99e:c0a1:4e9d:322f]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::e99e:c0a1:4e9d:322f%7]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 20:18:47 +0000
Subject: Re: [PATCH] drm/amdgpu/display: fix leftover CONFIG_DRM_AMD_DC_DCN3_1
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210816201201.879662-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <3463abf5-213d-9320-743d-8b132dec9ddc@amd.com>
Date: Mon, 16 Aug 2021 16:18:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210816201201.879662-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::15) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.50.3] (209.195.106.179) by
 YQXPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:15::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Mon, 16 Aug 2021 20:18:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac51ced7-e18d-4b07-3b8b-08d960f30daf
X-MS-TrafficTypeDiagnostic: CO6PR12MB5460:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB54607E441A1EEF8ED42975AD8CFD9@CO6PR12MB5460.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6M9lcVD0UlU85c9N9rHVQGXk5LN1h3ePRY8BNqSGunVq9mRttgJeZaxUkPZ2a2h0t283MVSo2OWUnAOf8E9Yyl9APRyeYLje51Elxhnq3Lihht1+jiskeGcq1fNHxJd3p83cDWJ8CWvOUq2sx4Tw3/uEK8zQQ5LLSe0XBG1WE3lf9DptYmA1sW92+p2qbP9BH2V9lohPr/9Bmbj/09Oil5wwuh4P7DKhxD4I2nxK5lV/bgI3O/qmEQXMMhQTcoSIrLy09Ub3AAj4JJWl1IVTPkBDV3nS/zweJJlxlC+NH953A4tQCzzBEAhiYE2O9lwCZsBWVqnzB2Gndb7laPsHduH0sbt1hJfOzAUg3DREslFoBOEP5POQ8mWX6ThZrAixWahTNqXTeiklHLkjIRdcoVCf/PPZjp8fYGvfGnvms16L4J+hrA/MbwOlrIo520jSrten0ZaNQcGkK5H0BPvPBYk84TTw3evJB3UUCB5xxdlwAkKQU+Ty6iGqIvEnT3BvBfpF+8JsB0BIiElVTXn/HwKEoLaO28gvVXedUeRAcddWurHlEV/4VaHb+HDqTnSURofbDsMXEntTdP5X0+xCXscFET5a/D6PWmh/VSPVC2kQ76H+MrJBA+8NliilIz5mu3Z9kNmhp2EI4tLbRVPmowPvfWbH9kyJqJ2zjAjx2w/eD++AXQeXLFDIbSN6LP9zci3yAtSxBN1nS/M9lP618gu4QnrggbdQXU1V1/HMIvFltdB2iS6A7EGd+BSM6y7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(5660300002)(478600001)(53546011)(31686004)(66946007)(8936002)(8676002)(66476007)(66556008)(26005)(186003)(6486002)(44832011)(16576012)(2906002)(2616005)(36756003)(86362001)(956004)(38100700002)(316002)(83380400001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0QzUDM0SkdrVHQydHh6NjF2c0VGVlVIajRZQnRidUttbG1heGY3RGlsQ0FR?=
 =?utf-8?B?UWpLVnFvNzFvWnVuL3ZCTU52YlFOc0hzejNtYjhkMFlNVVI0bjdsSHZGUmhn?=
 =?utf-8?B?VEIvcm1hYlRET1R2UnJGVG1OS21uV2lmellCZzIvak9YQXZSYUI4VE9pNTFP?=
 =?utf-8?B?aEh5Q1NEYVB3VlVGQjhub1B3UEFVamJaZHpsdGpoOWxMcEgrUEU5VTZHaUlj?=
 =?utf-8?B?S2k1WC82U2JDdGg1M25lQUpEeWk4NkxyUzlQOFJHaEtwN2hQSGNaNFMveGVH?=
 =?utf-8?B?cTJzVmtVQ1VRdjRCUDRqRi9LQjlGNE9qenBQTmhMM0puQ2tBWSszbzVmTm9a?=
 =?utf-8?B?YVRDN21jN09pbTR0VVNUOEFwWXkyeHRuS2dGVWxPMjRXTmV3NC9sK1FiYlhP?=
 =?utf-8?B?TEJWQVZnZFo0enFuRGRyRkJjc0NRUTliVmZHMWh6dlFvcldJZVRENHJzV0xr?=
 =?utf-8?B?RC9qbHJZVm9kQ3o1V256cFRhRTROTDVUV0pJN1E0dzVHd25QaWdYd2VBTWRS?=
 =?utf-8?B?VmFsK2d2cktFdXUzWkJ1ei9Bb1ZxdDRiN3NGU2tzTlY5bHBGK2VlU2RzVG9Y?=
 =?utf-8?B?Z1VBUGdoWWltRG45RzBpbkRrMkpVSXVmakdGazNYV1JCSVRkZnNIRk5qZDh3?=
 =?utf-8?B?VjR1Y1FHUmRHV0FCbEZLZG1NeWU5aTQ4dm5mOXhxSDdTcDdZeU1kR0JURXlh?=
 =?utf-8?B?UEgxc3BkdWlJbDNmMUoraWQwblBZS0t2MTJRUEZIUVdLS0lJalgySnBpV0xH?=
 =?utf-8?B?cHhkbzViZ0RUU2Y5UVFGc1l6d0tyOFMzSzVGeHgzOTNHSFE3WTRLN2hjR1dp?=
 =?utf-8?B?N09iUjJkVHNOWWduS05LajdQUU9zQXJad0RBckRRS0RHbWJ2NUszUE9MRW9j?=
 =?utf-8?B?VzFya20rNTRXY3hBckdRUjdnT0JtdVFKYlJ1TUZIam5taVpqZHdzSXZXR0cr?=
 =?utf-8?B?dk9zZkZXd29ha2hZOVJmRmJITVU3emkzcXpxVXluenYraE8xRVg0b1hZVy9q?=
 =?utf-8?B?azI0T1Q0RWcxUUdocHVwZXBXdk5HMFQ5Z0k2UUkzcmg0UEQ0VCt4RkJOV0Nw?=
 =?utf-8?B?WnJzZE1rMXJZK2NIVlp6eVYvYmhSNHhKbHY3T3RLY2U5NnVOazhVMzNZOXBm?=
 =?utf-8?B?WG5MRERDeGdBTGE5V00rOWFoMHZXQStnYWdKVm1XUnF6TXVNaWdMTThZLzIv?=
 =?utf-8?B?QXh1UldoUkNyQzlFTEtVMWdXUUlQUGxNQ1ZsRHR1OHQxRE5rSllqc0hNbGNT?=
 =?utf-8?B?SWxlKzNYUDBUb2ZsVmVjM0Exa2FpNDY3b1N0eXZQT3pqMkZ0UCtCc1Z0UExn?=
 =?utf-8?B?NE9aWGx6NHQxdFgyWVo1NVdpdzhybHo2anpvdjBpZkFqc1VlYTVvRVNrblNV?=
 =?utf-8?B?QUVrY2JFNWFlSVRtNXRqWlVHSkJIV0pjRzZlVXlqb1ZHZHJPMjI0VGYxZk9p?=
 =?utf-8?B?bFhWODZnODhFZFIyK0hZRVJTWXdyeXpVRUVjV0JiaFZwNWp3WDRyM1dveEs3?=
 =?utf-8?B?V2Y5cjU5SnYrYjNlS1ZCTFYzSWt5dWMzaHpUUUhPR1hLS1kzaU1IZjJWNzRW?=
 =?utf-8?B?Nm03UkQva0lXamkvWUR5Z2JJQ1VidG5jMEpFbU9CcGJKNDV3UXpORDZuUmVV?=
 =?utf-8?B?MkZUc0J0RlhTVjlKSDFRWHlsR2xmNUkxL3JyNjcrY1BPRmd2YUpWL3NiSW5J?=
 =?utf-8?B?c3MxRGRIaXRxZUV2UW11Wi93NHRpY2tteTNKc3NzNXlrMmRDbytDb0xlSmR2?=
 =?utf-8?Q?1Tj7nI3S0PDrYqxdYhVmLmwUanvekzcUU8kwXrp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac51ced7-e18d-4b07-3b8b-08d960f30daf
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 20:18:47.5281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNY3OXxgZyRF5KLdB0S5vmHWgYI48Q9NTNRt6CxOu4R8vz66vFUL+WfnVMLiQfslFEW9kRMxqhvHPrTHfDP+Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5460
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

On 2021-08-16 4:12 p.m., Alex Deucher wrote:
> These were converted to CONFIG_DRM_AMD_DC_DCN, fix this case up.
> 
> Fixes: d7cecec64d07 ("drm/amd/display: Ensure DCN save after VM setup")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c b/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
> index 80c752ca4a5a..cde8ed2560b3 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_vm_helper.c
> @@ -47,7 +47,7 @@ int dc_setup_system_context(struct dc *dc, struct dc_phy_addr_space_config *pa_c
>  		 */
>  		memcpy(&dc->vm_pa_config, pa_config, sizeof(struct dc_phy_addr_space_config));
>  		dc->vm_pa_config.valid = true;
> -#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>  		dc_z10_save_init(dc);
>  #endif
>  	}
> 


Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015F9C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 20:59:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87FE96023B
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 20:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FE96023B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB676EE95;
	Wed, 19 May 2021 20:59:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A4576EE95
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 20:59:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRcvwbS0UlskB4Vpp2XOluTecyjajC/pBo72DH43EwppBwpQKsSecqC7+UunNSEQqfEGW3dzFfqCQmeUXGmIo7G+BeNinJCRJYdbIfzWycs2PW7yeKsmSsdB0W5Ud/1Xv78RwZ2uuJUe8QlN7GAQYtGLDkV9rB4nZ6Lfk5Iz1q8Epo+y5u9j0mVuH6Cq1xmjw6UK4AaEaOFXMIYRdgr++IZexFpekWT3A2JSqtri8TSnt9HvqR04mCNTA0N2Qgx8myCEMgiXV3kyvTcIQDaQ2rLW9RDEBPa4h6yUjOb8HnWBH/59xCFV+IqnIgH/8YcIYrYTBO7VgxcS1qc5HSPpfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd2GE+YnLKuwB5BkDUptAFAGVxddWo90cChf6GlPNUc=;
 b=MM/w7LQOUpROAt4ZhH5esCqtwRAv3yZxtrPr/77WXbEhIKpoC9jv6PRcCM1rgTZyosMNNXkIC6VmC9SWEq+9LfB461A3nsf693AQMztmd3A4hh/UOErS7lYmL5ANYbQb0Idw0yknwFLtaXVZjFHw7Jyhmxhpqetw06YC2G2tGMbWaFapq9T7gPBSNOtP7q2Z4qS4jRoOjpYEf/XBrFW4LDlMpH4/5/EQ5X7lVlhkRRsnWmzKoIIjxdnx88uEmOM8OF/otnhflFcaJ5hmivQqMoCFRcxvnosGFnxhVk6UKIHGnbPSweZ6INmMYtddKYc0tUlT5GV7ssTHzD3xPhzKMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd2GE+YnLKuwB5BkDUptAFAGVxddWo90cChf6GlPNUc=;
 b=Jyq2Tfi1sar9wkvh9sYE2OtzSNGxMk7hGBhoSjY89Y2A2HG2je3q/rjGoJPY2HsoAVrBXmbj3VtgbbP+vr1R4U5YmtsGrepQAEM8XyP3pGX5USY+G2m5d+waMSvXSvwIBre2gGob8IXLzELO6t6I1ama/9dW/AjSE2rVUUv+y+g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24)
 by DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 19 May
 2021 20:59:08 +0000
Received: from DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::acf3:1432:d128:3565]) by DM4PR12MB5182.namprd12.prod.outlook.com
 ([fe80::acf3:1432:d128:3565%3]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 20:59:08 +0000
Subject: Re: [PATCH] drm/amd/display: take dc_lock in short pulse handler only
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210519205505.622626-1-aurabindo.pillai@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <099e5aa6-dded-1d9b-a542-25524c5c6ebb@amd.com>
Date: Wed, 19 May 2021 16:59:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210519205505.622626-1-aurabindo.pillai@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YTXPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::44) To DM4PR12MB5182.namprd12.prod.outlook.com
 (2603:10b6:5:395::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.16.155] (165.204.54.211) by
 YTXPR0101CA0031.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::44) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Wed, 19 May 2021 20:59:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 015d4a9c-8249-4321-a6cd-08d91b08f1d2
X-MS-TrafficTypeDiagnostic: DM8PR12MB5400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5400D57FBC5FE9D76AD8EF26EC2B9@DM8PR12MB5400.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jLCiEKrG6QpnYG9EQ/Gy16NWKAvd/3zLBLmGIilrzYrmvQmNDX/UlwvJZweCyZFQuVPmKheKIJQwDuLcfcgEp5VUf5jEQpe+oUTUmwd5r6Rdi1eIpGFqGmITPaKl14IuiSdcrz8qfXIObVWj+vu/4h/rHZDQlBxY/7Ef49OpRsp0WOSPrGY6G9iXZZ8CD9d/MHfdiKf4jT4Nw9I80FR4aIW0E88SPz1OASfss2vdaWzfyFf2ec7VHEJbsGG7z/cEHVP5u8w0eU8cmMEtmyW96VDwYtX8+LgIEfx6TXmGOKwoWIDlUThwJYjJ2Cl7wcgMtW4EVG9NzNYCK9Y6xv8lXmWLi/fiTqCk+vKzoU34SMf7zH0UAlEa08tRzwUhwLx/YU2kTuw7aF2l0dYqeNOtPQ+7RfwOfeFpyIHbcru+nJPgLFA3DsrI3KcTLRGPF2RlFvuOrJgdPQP4QntL1LBUfGMlGOo2n/56q0fu2AOk0eEKiT0ZjtVp1jygLOxaeQhBMDBQdncxnXgU4ZMt3TievoiTahic2XLs6uDRvKayl8jO0FR69zCdFpd+Gf5MVERwnu+6R8R/FzpNpmz7nnv7No836O4Fvbs8wMKlLuHFLfnAIIkfRHkNL4W3OufnDQeBftEkcWWgf0Jz0aWDQhwRVDvgRhTeFd/8EVcM+pThdN/Ct+xZeO2OVD6v9MN8wk8C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5182.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(86362001)(53546011)(38100700002)(2906002)(31696002)(26005)(956004)(186003)(16526019)(2616005)(5660300002)(8676002)(6486002)(8936002)(16576012)(83380400001)(31686004)(316002)(66946007)(66476007)(66556008)(36756003)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?T0V1d2I1Q3h6aUEyeUxTLzFseEdiWXlSTDhHNGtObVJFQkl0cVdoNUIvY2Zj?=
 =?utf-8?B?dVFYeUxnaEhEdjdSaW9FNVNjT2dkOUw2TURrUmJpV0hTcDlOWnljaFVXSFJK?=
 =?utf-8?B?dExxU05UNUd2bVlyNWhDV1NVMUpSRTJOT252ZGlTZ2JXUTJkeHRhVTZDRXZk?=
 =?utf-8?B?M2RycG5kdmxWS2VyMWxXQmdTd3hFK2dHbzdIVTZRdDllQ3Jxd2ZuL3NKWEFv?=
 =?utf-8?B?REtMU21oZmxiSS9Dd1QvWTVkMXE3ekh6cFdXRU0xSjQzSHcyYVA2ZGVZTHVT?=
 =?utf-8?B?czFFVXcweGpJOThYNFlVaVJTWVJHQ2pwc3c2TTNXL0dUVHV6K3pDTTFOSWk5?=
 =?utf-8?B?OXEwVFFTYkRQdzNqeFNjekJlb015aDl3c3lXa2gvcWhmL3NNQU9FQ0g0ZDQ2?=
 =?utf-8?B?ZXdUSXBSZGQ5Vlg3Y3l0dXdNZG1KU0FXdVVMcXRWK3NjbUdaRUFlUUltY2dk?=
 =?utf-8?B?Y2V0Z25qckNKN3NOb0VrbFBueWtlM1ovZmNQaVphc0dYM0s3aFhwM0hNV3J3?=
 =?utf-8?B?Z3h6Wi96YnBWd0lsdDlWUDBoeXFQMVl1aWNXeGRwN0diVW9mTm5kclBIbUJu?=
 =?utf-8?B?Y2I2VW9yeTFBRGJZY0E2UElXQWx6YnV4aW1XU0dLZksxandSZkg4OXNqM25J?=
 =?utf-8?B?cUE2dC9UdE01TXQ4YU8rbW1Bc0dGeFRrVXRnUG5DdUwxMU4xNENWUWRDZVZh?=
 =?utf-8?B?MVJaR2RJUS9kOXk3Q2J0SVhIeUpWaTRNOWtBMXRoRjk3cU5uSkJTSXVvTlJv?=
 =?utf-8?B?SVBMTGIzVmNXRWhMdndnZ0ZUVTNpUUNWcmRJVlZpVW0zdGpjd2w1ZXFCamYr?=
 =?utf-8?B?TG5hT0ZGd1pQblMrallkSVI3cXZMcXF1ZHVQUk1iZHNWcGdPTUlxU00rSlYr?=
 =?utf-8?B?WitBL213VFN0VVg1K2gyRks2QkNxUS9EZUtkbFRkOHNSdWI3RTJlN0JNbVVn?=
 =?utf-8?B?RXVVemFkd1BaZUNQbDhUWGdFRGlUaFZBcFpjRmFHc1hvZkx5TlpjMG1vQkt1?=
 =?utf-8?B?TEdZMHlid2JYTFpsTEhQM29zVFc3d2xHbWJiNW03Rzk0YjJXbjBXOUtCbGFn?=
 =?utf-8?B?YmNYVjN5NldpYld5bHJ6MEoxRUlTeXViMG9zZzhSMEZWY0tnODBKZW5mYkdr?=
 =?utf-8?B?RkdaYnJ4eUptWE9peHY5dzNIZFJzWkNRY0psV1RQZTRCMDZmemh3Vkx0RFYx?=
 =?utf-8?B?T0ZqdXdjbWt1SlF0ZlZUZjNUVEg3eWtuSXEzS253aHlvREJ1alcxbG5GNDI3?=
 =?utf-8?B?TEE0UVg4dmhhb2FhMjBMVU5QYVdtTFBydHgvWnlhYTBlMG9SUWFSMkdabkF0?=
 =?utf-8?B?c09jbkVFNWlYeUN4YVptekJLbVoyMWwyZVh4UlBFdVJYWGxudDN5Uy9OdURU?=
 =?utf-8?B?SXY5eGFxcTlTaUVzTmk4QzRNbWNSak50TFcvUkdyeUc3SXBJNTNCSUxRY2V1?=
 =?utf-8?B?WmVEeFgyeHplTE1Dc0JTUTFBZDBTdHZjNkpXQ1BaS2lUYmN2V2JvZ3VYbGxp?=
 =?utf-8?B?cnY4dGFSS0lTR3plS0RHTHVBWDQ4amFVSko5a0RRTDVHU2xKODBrd1JMTFpx?=
 =?utf-8?B?bVZMa1RMdTN5Tk8zVUQyV2wvSTczbU52Ri9SWElTalcza1l5QmlKRGRETGVT?=
 =?utf-8?B?Qmx0U0NIR2dqT2NaVW1Wdm44VUJTNGJ2ak5uUkpuT2k1ODR5VndUTlpwUWRo?=
 =?utf-8?B?N3hHRlNVTDZYTVdheDByQzY3TThyL29NZXh1Nm11eXg5OUliVEkyREVTOHBl?=
 =?utf-8?Q?LxUJy2BmXYNsdyZEHRpVetX1qJmu9Zg5asHc2PY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 015d4a9c-8249-4321-a6cd-08d91b08f1d2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5182.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 20:59:08.1234 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpQlsv8w+gIMjJVs4y6nGHSWOVWlujeY5B3i05/QCjDJTH1BhgBButqSMrUsRR46kCRqZjUbfbQ28uFzHAZ+Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5400
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-05-19 4:55 p.m., Aurabindo Pillai wrote:
> [Why]
> Conditions that end up modifying the global dc state must be locked.
> However, during mst allocate payload sequence, lock is already taken.
> With StarTech 1.2 DP hub, we get an HPD RX interrupt for a reason other
> than to indicate down reply availability right after sending payload
> allocation. The handler again takes dc lock before calling the
> dc's HPD RX handler. Due to this contention, the DRM thread which waits
> for MST down reply never gets a chance to finish its waiting
> successfully and ends up timing out. Once the lock is released, the hpd
> rx handler fires and goes ahead to read from the MST HUB, but now its
> too late and the HUB doesnt lightup all displays since DRM lacks error
> handling when payload allocation fails.
> 
> [How]
> Take lock only if there is a change in link status or if automated test
> pattern bit is set. The latter fixes the null pointer dereference when
> running certain DP Link Layer Compliance test.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

Discussed this a bit offline and I'd *really* like the proper interface 
in sooner rather than later.

Conditional locking is almost always a sign of a bug, in this case we 
know it's OK but someone can change the function underneath later 
without understanding that we're duplicating some of the checking logic 
in the upper layer.

I don't think the code changes enough in this area for this to happen 
(as it's spec based), but please be mindful and consider splitting the 
checking logic (which is thread safe) out with the link loss logic (the 
functional bit, that isn't thread safe).

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++++++++--
>   .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  2 +-
>   .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  4 ++++
>   3 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e79910cc179c..2c9d099adfc2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -28,6 +28,7 @@
>   
>   #include "dm_services_types.h"
>   #include "dc.h"
> +#include "dc_link_dp.h"
>   #include "dc/inc/core_types.h"
>   #include "dal_asic_id.h"
>   #include "dmub/dmub_srv.h"
> @@ -2740,6 +2741,7 @@ static void handle_hpd_rx_irq(void *param)
>   	enum dc_connection_type new_connection_type = dc_connection_none;
>   	struct amdgpu_device *adev = drm_to_adev(dev);
>   	union hpd_irq_data hpd_irq_data;
> +	bool lock_flag = 0;
>   
>   	memset(&hpd_irq_data, 0, sizeof(hpd_irq_data));
>   
> @@ -2769,15 +2771,28 @@ static void handle_hpd_rx_irq(void *param)
>   		}
>   	}
>   
> -	if (!amdgpu_in_reset(adev)) {
> +	/*
> +	 * TODO: We need the lock to avoid touching DC state while it's being
> +	 * modified during automated compliance testing, or when link loss
> +	 * happens. While this should be split into subhandlers and proper
> +	 * interfaces to avoid having to conditionally lock like this in the
> +	 * outer layer, we need this workaround temporarily to allow MST
> +	 * lightup in some scenarios to avoid timeout.
> +	 */
> +	if (!amdgpu_in_reset(adev) &&
> +	    (hpd_rx_irq_check_link_loss_status(dc_link, &hpd_irq_data) ||
> +	     hpd_irq_data.bytes.device_service_irq.bits.AUTOMATED_TEST)) {
>   		mutex_lock(&adev->dm.dc_lock);
> +		lock_flag = 1;
> +	}
> +
>   #ifdef CONFIG_DRM_AMD_DC_HDCP
>   	result = dc_link_handle_hpd_rx_irq(dc_link, &hpd_irq_data, NULL);
>   #else
>   	result = dc_link_handle_hpd_rx_irq(dc_link, NULL, NULL);
>   #endif
> +	if (!amdgpu_in_reset(adev) && lock_flag)
>   		mutex_unlock(&adev->dm.dc_lock);
> -	}
>   
>   out:
>   	if (result && !is_mst_root_connector) {
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index 9e08410bfdfd..32fb9cdbd980 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -2070,7 +2070,7 @@ enum dc_status read_hpd_rx_irq_data(
>   	return retval;
>   }
>   
> -static bool hpd_rx_irq_check_link_loss_status(
> +bool hpd_rx_irq_check_link_loss_status(
>   	struct dc_link *link,
>   	union hpd_irq_data *hpd_irq_dpcd_data)
>   {
> diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
> index ffc3f2c63db8..7dd8bca542b9 100644
> --- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
> +++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h
> @@ -68,6 +68,10 @@ bool perform_link_training_with_retries(
>   	enum signal_type signal,
>   	bool do_fallback);
>   
> +bool hpd_rx_irq_check_link_loss_status(
> +	struct dc_link *link,
> +	union hpd_irq_data *hpd_irq_dpcd_data);
> +
>   bool is_mst_supported(struct dc_link *link);
>   
>   bool detect_dp_sink_caps(struct dc_link *link);
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

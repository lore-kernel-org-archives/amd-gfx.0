Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E665C54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Sep 2022 21:35:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FD1110E7AD;
	Tue, 20 Sep 2022 21:35:39 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C94E10E7AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 21:35:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNBT5SMYL27+aa2nMr1c5/Ps9ig9s6f4hsi/oXwHt0L0wg/lvT6wkhuC4vVY4JSoZ6EEtXMHSungCV0gOGH81HvYvvNJjBY1+SM8u16RYePXTpepVecJ+CIY9ZaAolv/dXeBPJ5Ctc8L8RBcNIYswNlq+WjwVcgMQdHO5F+A8j1iqBu6N6Vtik7FKQaHP/rKFKQjDbSPL2ZdB9aAxJ5FYFbUMCnjsGm0zs3uJlt1+RFLLwLGE7XJuVoZHTxPSuUP9uayfmEH5msgAxH5HehFn3fqolaIwSnayO9g77pHSIPxsVecyQXFWtS6M0BellqHFm+cjebb/1RyZNax+98hVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qAn4DFG9N/VTWWx8O1qsQrcgkA806IYm/Mrkc/s3XU=;
 b=PeHbwj8fxJk6x02eCjmo1xB80nsH8t0BOVU0zhUjEO9tbwB8ErIO6ik+013w0sed/jVbau6Kdr4/kg9UVxp6CH5xj8iaecsr7DO+mcypTNWY21LZsDYifFgu/9d2ZhFQ8nPd6I0ul/6saRFR7hAC5IOQC1RUaOinIXY29ERc6hn1czZ1WKdHYGwErQe1eRelUH7MG2UcdjKiPSfydwU8YsMwBMuXPuYOR1vXKBi3XSuaXSpGc6c3DPYu8vEvn08GM2Frh7X6vPo+p0Y4YawkrBM6fYCt5IHm/UyQc2ij0LYoiOtpURXDwVvzCTM2Ru3Rnayb7Puu4aEDbCYDtJgOKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qAn4DFG9N/VTWWx8O1qsQrcgkA806IYm/Mrkc/s3XU=;
 b=nglxjCeqk/ZwGYcOKWEelWuO4InjhYAUliNp6AE8shW8K9xdYMlJUJLB55DPc3uEel0Is3qzXScdjiGz24jooPAeCngschjO9ozYsX+mYvQZbDnFqEneXd+YxbyDF7gN/6byhN/pkKkLoBJT9Mgf2rvWU/jxabII4uXyNF3DsWs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 CY8PR12MB7564.namprd12.prod.outlook.com (2603:10b6:930:97::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.21; Tue, 20 Sep 2022 21:35:33 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::c549:82d4:60d9:2a8a]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::c549:82d4:60d9:2a8a%3]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 21:35:32 +0000
Message-ID: <43144c16-d58b-62b3-cef7-698c35a79b44@amd.com>
Date: Tue, 20 Sep 2022 17:35:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/4] drm/amdgpu: Add software ring callbacks for gfx9(v5)
Content-Language: en-CA
To: jiadong.zhu@amd.com, amd-gfx@lists.freedesktop.org
References: <20220915065038.865734-1-jiadong.zhu@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20220915065038.865734-1-jiadong.zhu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::25) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|CY8PR12MB7564:EE_
X-MS-Office365-Filtering-Correlation-Id: fb1b7f92-faf2-47c6-cf2c-08da9b500bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /qDchvwmss9w0lDftnCwmxAUfCMYBawD8L5i0XtLTi9/er39fufPECmGz+qoq58oARh3fIU4EoY6EbcVKd7aSrTXcAFUk0GiwO7fk82iG53esTqzGD70b6j8ZD9sWMgLXDffnyBeKXsSPJHUsKK7AbtETK0yFHuChSn/INvTEj0Eb0Ki5535QHvBQUdiGI3m4gx8D9KJFdUzX+tZkiscxFt45uPUssgxHl8GYrT62CwlNrbt41nFThxuDwJ1KeMIClacgyOJ05lTDGxbHov0xgd01N2A6VW+QCsoL802WH/0veVzdtwg6HAWg9L/GwkyeLT8gCUGNFUTbCo3qZ3jeayB8Lm2Fl5W6JScTsl+2o/zze7b8y/Q2k0U1qOGvIym69TuDoZ+4Tb10azZ7cwVqigriugNHiROxgL4PXkIIO+E9ohBiCMEmGJkvz5Tq0zh+2UBvJH44+2H+w92ec+CitnzMa8GdKEqpTg/KPSouWSIjZ7rxLz3hFvVNjrJ24Z9c7IxO5gvnjM3dR7n3REKQezdns2/TfqPVADpzkIb0JIe76lgAsD7r+jDVstM54fveLeCLwTLtkUijZa/Q6Up43SAfNiTVC+2Rj+W61vYYYcnAl+3yp7HIpyJf9ekl5ThYKvVR0opRlARZaoZMIyYNaqRWY+WSJEs0ei1x0lZyCp8Hx8ZrilqPPsZLIJemtevk/3KAl9N+lvRMDK0LhfjUoNMKplJANmH4dBs2v202ngpDjtEk5WaeLj5oVUDDOucm89yPafOPy+nu+HlKRh7y8HUxZ0JJvuttzQtXkYu2eQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199015)(26005)(6506007)(2616005)(53546011)(6512007)(31686004)(38100700002)(478600001)(6486002)(2906002)(44832011)(5660300002)(30864003)(66476007)(86362001)(36756003)(31696002)(186003)(6666004)(66556008)(41300700001)(83380400001)(66946007)(8936002)(4326008)(316002)(54906003)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHh0YTVlU1dYcWZMbmFNYmZ2SWtRRk9XNnJZdHZyYTIrc2JJMXdmMmlTZmJJ?=
 =?utf-8?B?emtiUXVNbk4vcEtOMEtLUzNvMEQ3Z1hKT1hvQ3JuNHB5MHZ6NmM1RVM0aWk2?=
 =?utf-8?B?WVRhZmtiMjI0UWlSQjMxbzROZ3VEMG15QzErbHJDTEdPYXo2cGpSaHVmYnRw?=
 =?utf-8?B?UnlvL25ZYVBaa3MydUlCOU1rRHg5OGhPa1Z0M2hldFZyWGdyWVhrSFFoOEFy?=
 =?utf-8?B?UkZXZ2I1dXp4U2lQTW1pK0NXeXR3RzZmZ1d3VU1jS1hxWHhYSjh2L2tZNnZn?=
 =?utf-8?B?SGNPK2lzUEFCTi9qMHJCNlplbGgvZmRveFBnc1NtZkh4RElpOWo4dE05R1Vm?=
 =?utf-8?B?TmtscjlZNCtkZ3NtTG9SQ3RjbDdQMThFR0l6NW8vaXBYUUg1OHp5NEFpZUJB?=
 =?utf-8?B?RG56SnNSdEdzanViTHBOb2ZrVVRmeGdIK2lINTZqdlE1bWtxWlVRV2c2MzJG?=
 =?utf-8?B?cTM5NEpuTks1aE5Fb0FUMzNzRTZidk5rR2hkRG8wRjVCYkZGOGhRU2dDU1hL?=
 =?utf-8?B?R3FIbDFGb3VwVUlnQ0t5cWJ6ekJYUmpSaFN4NmxSWFdPOTNRaGVwZmdDcEI0?=
 =?utf-8?B?OE1BYmxoVTE1dDZFeWRKaHQ0OGtWQTQxOTIvWU5kTE5NeDRsVm0xSW43dG45?=
 =?utf-8?B?dENBT0FHa3ZHSkxibUpVOEV1T1VVT2RFaTZxZCtHblJWajVlRlhGYjFtR0lm?=
 =?utf-8?B?UExWMjg0dHFvZkRpNUlqUldRc3NPMThWV1RBd1o4eTUwV3U0ZDZLamx3WkhX?=
 =?utf-8?B?SzUvT1J5dXVEVE1DalZaekpvTU5QNUtBK1JRYitrSHdZeWlvMjZlUFJzVXky?=
 =?utf-8?B?dXRZZ0RhRTFNM0l0QytnUlQ5eEpwaUk0SW9UUW5LWTNjTk1EQmlPb1VLS1lC?=
 =?utf-8?B?MEpzZTM5NDlRanVSZ0p6bDVmN1J0WGJVMVY5RGxMNW9NcjlSWlVUZ0pMNmxx?=
 =?utf-8?B?LzRPMmRxbDMvTlA2ZytlTXAxRk5VbGtPUzYrOVc5a0QrTWY3OUdKMGxxUlJV?=
 =?utf-8?B?YWZyTnVVeGlndkJQUVlEMzVzSHNMenVBajNRVndVUTVIWUo4QWhIWWFlbjdL?=
 =?utf-8?B?SzYyZmluNUVxV1JoRmFRaUVCb1VoaWZLaVRvZGNUMG0yTkFPekpNeksxd3gy?=
 =?utf-8?B?ckExdi9HL2pYTUNHZ2VrOUR4UjhlVStWYjU1c0tjZ0FxNDJjNFRNempTMlhN?=
 =?utf-8?B?NU1lTzkrVGdJYi9RdVZ1ODkwSks5SWkyb25NMzZrNUtZbDljMWwxTmxLOHd6?=
 =?utf-8?B?dE9FRVJNVTR3SkJwRWpMeUZLanBYMkdjLzcrT2NCaFUvbStialRKTXNObjF3?=
 =?utf-8?B?U0lpR3Jsblh2bW9Vd2pKUHUxSlZtREc3bGZCd3c0MFNlTGNpQkY5SS84ZlFO?=
 =?utf-8?B?TjdleGlSM0hoTTRQM0g0d2s2ei9GQ3JCVWxNREtxQlBKVzdocnhzZUd6Wmtu?=
 =?utf-8?B?eVR0d1p6NXlobEZsVnBvMkdrUXd1dDB2YW01V2dvUGFESmlpSGNLdjY3Z2Nh?=
 =?utf-8?B?WktHMjIraFo0QTdaNzFITDZScWMwVHhBMjFEWldYOVlTZ1g1OVNLR2xDNUc2?=
 =?utf-8?B?dDdpc1FoZ0EyWXpOemQ4a3k5OEExdEIzNmNEMzJvdkhYYnRXWEFnU0VNUzdY?=
 =?utf-8?B?NncvVHVZUi8zbWVNUDYxS3N3Z3hlTmU5UUpObmQzVDR2bENXNG51MkcyMXIy?=
 =?utf-8?B?Tk5mWG1KSTlqZGNwS1ZLTEtnVDNMSFhCckx0S0x4VlJnVXl1ZndrN3hkM0Fj?=
 =?utf-8?B?alNaejJ5emZZblFOUFQzeHFmZS9uYXg4RnZXWDhXbWZkaU5xeXBGWldBSVFN?=
 =?utf-8?B?QmRoQ2FNRXBlOVk1QVNMQk9YQ2c0bnU3K2E5TEpaaC9RZldGQnR3amY5dlNx?=
 =?utf-8?B?TjN2RkNvTTVKRGVhTkt4SWZkNjF4TjFYRzlsZjdVMHRmbUZGUHVBek15OHpp?=
 =?utf-8?B?M1NPcDFaQkpVNmRNU2JPaC85YzdxZDA3akpXZlRSc2ZYL01XSmR2a2Q0MHhT?=
 =?utf-8?B?NnB5NWhPYW1kdzFZVThhOWgvNkQ5VUJ1TVBCQmxpQlpZNDRTWnV3bkZEQVhn?=
 =?utf-8?B?ZTNHc0hnSEFhdUdXa0FsK1VEWEpBTTRlYkRoRGtmVysxQm0vRTRuWVl5UkVJ?=
 =?utf-8?Q?+XQF9qbRzNS+vV8Owz3HfXbm6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1b7f92-faf2-47c6-cf2c-08da9b500bf6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 21:35:32.8165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1f3ezU6/oyMrd8gDiQBCuejyzeddCHUBc8e0fMN8nUkrAn2bHpmtYtZrV+LJisTb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7564
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Luben Tuikov <luben.tuikov@amd.com>

Christian and Andrey should R-b or Ack it too.

This should be heavily tested.

Regards,
Luben

On 2022-09-15 02:50, jiadong.zhu@amd.com wrote:
> From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
> 
> Set ring functions with software ring callbacks on gfx9.
> 
> The software ring could be tested by debugfs_test_ib case.
> 
> v2: Set sw_ring 2 to enable software ring by default.
> v3: Remove the parameter for software ring enablement.
> v4: Use amdgpu_ring_init/fini for software rings.
> v5: Update for code format. Fix conflict.
> 
> Cc: Christian Koenig <Christian.Koenig@amd.com>
> Cc: Luben Tuikov <Luben.Tuikov@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
> Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |   7 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   3 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 117 +++++++++++++++++++++--
>  5 files changed, 120 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 96d058c4cd4b..525df0b4d55f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -207,6 +207,7 @@ extern bool amdgpu_ignore_bad_page_threshold;
>  extern struct amdgpu_watchdog_timer amdgpu_watchdog_timer;
>  extern int amdgpu_async_gfx_ring;
>  extern int amdgpu_mcbp;
> +extern int amdgpu_sw_ring;
>  extern int amdgpu_discovery;
>  extern int amdgpu_mes;
>  extern int amdgpu_mes_kiq;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 9996dadb39f7..93b25d9a87f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -348,6 +348,8 @@ struct amdgpu_gfx {
>  
>  	bool				is_poweron;
>  
> +	/* software ring */
> +	unsigned                        num_sw_gfx_rings;
>  	struct amdgpu_ring_mux          muxer;
>  };
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 13db99d653bd..4eaf3bd332f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -33,6 +33,7 @@
>  
>  #include <drm/amdgpu_drm.h>
>  #include "amdgpu.h"
> +#include "amdgpu_sw_ring.h"
>  #include "atom.h"
>  
>  /*
> @@ -121,6 +122,11 @@ void amdgpu_ring_commit(struct amdgpu_ring *ring)
>  {
>  	uint32_t count;
>  
> +	if (ring->is_sw_ring) {
> +		amdgpu_sw_ring_commit(ring);
> +		return;
> +	}
> +
>  	/* We pad to match fetch size */
>  	count = ring->funcs->align_mask + 1 -
>  		(ring->wptr & ring->funcs->align_mask);
> @@ -343,7 +349,6 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>   */
>  void amdgpu_ring_fini(struct amdgpu_ring *ring)
>  {
> -
>  	/* Not to finish a ring which is not initialized */
>  	if (!(ring->adev) ||
>  	    (!ring->is_mes_queue && !(ring->adev->rings[ring->idx])))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 40b1277b4f0c..275b885363c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -38,7 +38,8 @@ struct amdgpu_vm;
>  /* max number of rings */
>  #define AMDGPU_MAX_RINGS		28
>  #define AMDGPU_MAX_HWIP_RINGS		8
> -#define AMDGPU_MAX_GFX_RINGS		2
> +/*2 software ring and 1 real ring*/
> +#define AMDGPU_MAX_GFX_RINGS		3
>  #define AMDGPU_MAX_COMPUTE_RINGS	8
>  #define AMDGPU_MAX_VCE_RINGS		3
>  #define AMDGPU_MAX_UVD_ENC_RINGS	2
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 5349ca4d19e3..e85565b0e52a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -47,6 +47,7 @@
>  
>  #include "amdgpu_ras.h"
>  
> +#include "amdgpu_sw_ring.h"
>  #include "gfx_v9_4.h"
>  #include "gfx_v9_0.h"
>  #include "gfx_v9_4_2.h"
> @@ -55,7 +56,8 @@
>  #include "asic_reg/pwr/pwr_10_0_sh_mask.h"
>  #include "asic_reg/gc/gc_9_0_default.h"
>  
> -#define GFX9_NUM_GFX_RINGS     1
> +#define GFX9_NUM_GFX_RINGS     3
> +#define GFX9_NUM_SW_GFX_RINGS  2
>  #define GFX9_MEC_HPD_SIZE 4096
>  #define RLCG_UCODE_LOADING_START_ADDRESS 0x00002000L
>  #define RLC_SAVE_RESTORE_ADDR_STARTING_OFFSET 0x00000000L
> @@ -2270,6 +2272,7 @@ static int gfx_v9_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
>  static int gfx_v9_0_sw_init(void *handle)
>  {
>  	int i, j, k, r, ring_id;
> +	unsigned int hw_prio;
>  	struct amdgpu_ring *ring;
>  	struct amdgpu_kiq *kiq;
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> @@ -2356,13 +2359,41 @@ static int gfx_v9_0_sw_init(void *handle)
>  			sprintf(ring->name, "gfx_%d", i);
>  		ring->use_doorbell = true;
>  		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
> +		ring->is_sw_ring = (adev->gfx.num_sw_gfx_rings > 1) && (i > 0);
> +
> +		if (adev->gfx.num_sw_gfx_rings > 1 && i == 2)
> +			hw_prio = AMDGPU_RING_PRIO_2;
> +		else
> +			hw_prio = AMDGPU_RING_PRIO_DEFAULT;
> +		if (adev->gfx.num_sw_gfx_rings > 0 && i == 0)
> +			ring->no_scheduler = true;
> +
>  		r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq,
>  				     AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP,
> -				     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +				     hw_prio, NULL);
>  		if (r)
>  			return r;
> +
> +		if (ring->is_sw_ring)
> +			ring->wptr = 0;
>  	}
>  
> +	/*init the muxer and add sw rings */
> +	if (adev->gfx.num_sw_gfx_rings > 0) {
> +		r = amdgpu_ring_mux_init(&adev->gfx.muxer, &adev->gfx.gfx_ring[0],
> +				     adev->gfx.num_sw_gfx_rings);
> +		if (r) {
> +			DRM_ERROR("amdgpu_ring_mux_init failed(%d)\n", r);
> +			return r;
> +		}
> +		for (i = 1; i < adev->gfx.num_gfx_rings; i++) {
> +			r = amdgpu_ring_mux_add_sw_ring(&adev->gfx.muxer, &adev->gfx.gfx_ring[i]);
> +			if (r) {
> +				DRM_ERROR("amdgpu_ring_mux_add_sw_ring failed(%d)\n", r);
> +				return r;
> +			}
> +		}
> +	}
>  	/* set up the compute queues - allocate horizontally across pipes */
>  	ring_id = 0;
>  	for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
> @@ -2413,6 +2444,9 @@ static int gfx_v9_0_sw_fini(void *handle)
>  	int i;
>  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>  
> +	if (adev->gfx.num_sw_gfx_rings > 0)
> +		amdgpu_ring_mux_fini(&adev->gfx.muxer);
> +
>  	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
>  		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
>  	for (i = 0; i < adev->gfx.num_compute_rings; i++)
> @@ -4709,8 +4743,9 @@ static int gfx_v9_0_early_init(void *handle)
>  	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 1) ||
>  	    adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 2))
>  		adev->gfx.num_gfx_rings = 0;
> -	else
> -		adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
> +
> +	adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
> +	adev->gfx.num_sw_gfx_rings = GFX9_NUM_SW_GFX_RINGS;
>  	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
>  					  AMDGPU_MAX_COMPUTE_RINGS);
>  	gfx_v9_0_set_kiq_pm4_funcs(adev);
> @@ -5877,7 +5912,11 @@ static int gfx_v9_0_eop_irq(struct amdgpu_device *adev,
>  
>  	switch (me_id) {
>  	case 0:
> -		amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
> +		if (adev->gfx.num_sw_gfx_rings > 1) {
> +			for (i = 1; i <= adev->gfx.num_sw_gfx_rings; i++)
> +				amdgpu_fence_process(&adev->gfx.gfx_ring[i]);
> +		} else
> +			amdgpu_fence_process(&adev->gfx.gfx_ring[0]);
>  		break;
>  	case 1:
>  	case 2:
> @@ -6882,6 +6921,62 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
>  	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
>  };
>  
> +
> +static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
> +	.type = AMDGPU_RING_TYPE_GFX,
> +	.align_mask = 0xff,
> +	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
> +	.support_64bit_ptrs = true,
> +	.secure_submission_supported = true,
> +	.vmhub = AMDGPU_GFXHUB_0,
> +	.get_rptr = amdgpu_sw_ring_get_rptr_gfx,
> +	.get_wptr = amdgpu_sw_ring_get_wptr_gfx,
> +	.set_wptr = amdgpu_sw_ring_set_wptr_gfx,
> +	.emit_frame_size = /* totally 242 maximum if 16 IBs */
> +		5 +  /* COND_EXEC */
> +		7 +  /* PIPELINE_SYNC */
> +		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
> +		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
> +		2 + /* VM_FLUSH */
> +		8 +  /* FENCE for VM_FLUSH */
> +		20 + /* GDS switch */
> +		4 + /* double SWITCH_BUFFER,
> +		     * the first COND_EXEC jump to the place just
> +		     * prior to this double SWITCH_BUFFER
> +		     */
> +		5 + /* COND_EXEC */
> +		7 +	 /*	HDP_flush */
> +		4 +	 /*	VGT_flush */
> +		14 + /*	CE_META */
> +		31 + /*	DE_META */
> +		3 + /* CNTX_CTRL */
> +		5 + /* HDP_INVL */
> +		8 + 8 + /* FENCE x2 */
> +		2 + /* SWITCH_BUFFER */
> +		7, /* gfx_v9_0_emit_mem_sync */
> +	.emit_ib_size =	4, /* gfx_v9_0_ring_emit_ib_gfx */
> +	.emit_ib = gfx_v9_0_ring_emit_ib_gfx,
> +	.emit_fence = gfx_v9_0_ring_emit_fence,
> +	.emit_pipeline_sync = gfx_v9_0_ring_emit_pipeline_sync,
> +	.emit_vm_flush = gfx_v9_0_ring_emit_vm_flush,
> +	.emit_gds_switch = gfx_v9_0_ring_emit_gds_switch,
> +	.emit_hdp_flush = gfx_v9_0_ring_emit_hdp_flush,
> +	.test_ring = gfx_v9_0_ring_test_ring,
> +	.test_ib = gfx_v9_0_ring_test_ib,
> +	.insert_nop = amdgpu_ring_insert_nop,
> +	.pad_ib = amdgpu_ring_generic_pad_ib,
> +	.emit_switch_buffer = gfx_v9_ring_emit_sb,
> +	.emit_cntxcntl = gfx_v9_ring_emit_cntxcntl,
> +	.init_cond_exec = gfx_v9_0_ring_emit_init_cond_exec,
> +	.patch_cond_exec = gfx_v9_0_ring_emit_patch_cond_exec,
> +	.emit_frame_cntl = gfx_v9_0_ring_emit_frame_cntl,
> +	.emit_wreg = gfx_v9_0_ring_emit_wreg,
> +	.emit_reg_wait = gfx_v9_0_ring_emit_reg_wait,
> +	.emit_reg_write_reg_wait = gfx_v9_0_ring_emit_reg_write_reg_wait,
> +	.soft_recovery = gfx_v9_0_ring_soft_recovery,
> +	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
> +};
> +
>  static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
>  	.type = AMDGPU_RING_TYPE_COMPUTE,
>  	.align_mask = 0xff,
> @@ -6956,9 +7051,15 @@ static void gfx_v9_0_set_ring_funcs(struct amdgpu_device *adev)
>  
>  	adev->gfx.kiq.ring.funcs = &gfx_v9_0_ring_funcs_kiq;
>  
> -	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
> -		adev->gfx.gfx_ring[i].funcs = &gfx_v9_0_ring_funcs_gfx;
> -
> +	if (adev->gfx.num_sw_gfx_rings > 0) {
> +		//first one is the real ring
> +		adev->gfx.gfx_ring[0].funcs = &gfx_v9_0_ring_funcs_gfx;
> +		for (i = 1; i <= adev->gfx.num_sw_gfx_rings; i++)
> +			adev->gfx.gfx_ring[i].funcs = &gfx_v9_0_sw_ring_funcs_gfx;
> +	} else {
> +		for (i = 0; i < adev->gfx.num_gfx_rings; i++)
> +			adev->gfx.gfx_ring[i].funcs = &gfx_v9_0_ring_funcs_gfx;
> +	}
>  	for (i = 0; i < adev->gfx.num_compute_rings; i++)
>  		adev->gfx.compute_ring[i].funcs = &gfx_v9_0_ring_funcs_compute;
>  }

Regards,
-- 
Luben

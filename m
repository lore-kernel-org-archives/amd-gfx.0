Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BFBCA0FFA
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 18:48:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7B4110E422;
	Tue,  5 Sep 2023 18:48:56 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C08E10E422
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 18:48:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9pkCk5rzboBxGJZgFIsJzip4O+PeLnyPQdlSkOzafOKYLfQNpAHCOMlUeWfrRBhHK7n6EhL9mjgjlsvdpKC+f+cg1+9zGWpx758U6BocBtRVehrUmB2+l+klCgcZ3MMN5Um7m29cmGri65lLCVMAxocZlbO1iY2Tq6Pl4SkQVeFsjo/irKsH/NgIg45cfSQ6atX12oEZwgv4347oA2LErJ9DOdD6ngcIeVj9chnRmFTFI1yXg6uF7rN9Nc9QELheg+cKOv2iOoXHD+aBwSXbgU4D1NVYBfjadRbnZ72jQRAjVImGr602BafPmkw+58vASK8FAC8AiftcgguLxPsxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrW7EmTouPi1xRo5lQqUgeOqGZ77cekFies4VbYX8c0=;
 b=aG8FRaP0v+N5aJDpg9sbmGVFgP+/znMpivzDBpMde4+RLrvXmLccp81RMCkRrVMKAgpbQ8rkh1aamT2QbnUW2QXYQzE84CCxhmV3rGxlmcMckh0Lh17YDlwvCNJrUgc5ad1WGLdrfMtUl3qDm2YbT3tHDwp5k8W/pHdtsB6xW3xOBBT+yb7FDGiD2YSVU0PPFS9Y+OjKJvuIxeSpLN/CHoTlJ6TwhJ4ft3IcDqiRwckIxW8FGIBcH9GpqR0sEqUHDY3SzDXc1sdhJ9SntpSpCFV2Qm5w5/ohY7bt+FRJLGsg7iJjw+mCoauCcUBP3I6tFcE5+rhYODle1uWoVMoA0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrW7EmTouPi1xRo5lQqUgeOqGZ77cekFies4VbYX8c0=;
 b=HcBUyoaW18qGBZvvO+7GpoxEKt7j++esrHkcvqncFZj23x11Qbf0DB1BzZrbTAKg4zu06stFymTP3QAOEPzbNUp62zHXKnVYKR/Cf1Zpy8GAdQCWcFpj+Rxl4sAqscBAE9oQWpquhpQxuDT4JUNr6TqLHQnyHl1DFykOqQ6fbn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3048.namprd12.prod.outlook.com (2603:10b6:a03:ad::33)
 by CYXPR12MB9339.namprd12.prod.outlook.com (2603:10b6:930:d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 18:48:51 +0000
Received: from BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::1dd2:153c:f0bc:b80d]) by BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::1dd2:153c:f0bc:b80d%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 18:48:51 +0000
Message-ID: <75d0cea2-16ba-241e-4127-92e051132082@amd.com>
Date: Tue, 5 Sep 2023 12:48:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 08/18] drm/amd/display: Create amdgpu_dm_wb_connector
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20230816212626.987519-1-alex.hung@amd.com>
 <20230816212626.987519-9-alex.hung@amd.com>
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20230816212626.987519-9-alex.hung@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:303:6a::9) To BYAPR12MB3048.namprd12.prod.outlook.com
 (2603:10b6:a03:ad::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3048:EE_|CYXPR12MB9339:EE_
X-MS-Office365-Filtering-Correlation-Id: 035867ca-bfc6-46d8-99f1-08dbae40bf48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7aasjYj8s9k8siK2UfVPYzW0K+72IDc9y0EkdQ9guKlEmyhH6xCzOe4Xe6SBdTdGgbyBK8dJ1kyIWtvPrc0uk+0pvzQdinAJPXO9PmdVcmzb6DcHn0ydanDPEYM9iYOqT+Xvfxln281fPTWnkoRzSQhBa/Ver8TkYifJSNVyWnvmPsiAgRTA5POhcyAk5JTfNvR4l9rJLsPxkrGgCtVblKCWaRJW+mVM2IIckoY5CumlPcQtOxpQ6N0UM3fS/3+4c/zvMbXK9N/X4VQDp1+Obqur2oU957HlfE2oNtFTWh+GXFfd3E3n3c6J4TaUhJ+IkPa2aYzrGRJSYYPFR6pHZ7lHprTZZx4RIwVKFW+ENhWYHzpmDh8ne0JN1QMdOZj0ni+grX2Dv1Mb4A6gHIY3nOOTWO23/ky+KJV+HlB/TEMJQuzlZMwK6qLD6yu7Z8dtt75qcgi/DYLqRYEFxuVdCb9Ue3n+ryPWwy19MArvax6lRiEkKyA5JfH8UHCHfKyFKm05Db6CUwU/2ekfGkv2ySdpQfpGbmMYEneN5HmYmbqLfLZxIFwIGR/+jtJg2FxA+acCLYWXAuVTqK+vM0QdZFn1tSvEvNztzJnx8P+h2+MzSz7Ys9BpUOhFx3WIrGd8eXik3hdv6UFwcTPhZNHyjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(39860400002)(396003)(376002)(346002)(186009)(1800799009)(451199024)(38100700002)(83380400001)(86362001)(478600001)(31696002)(6916009)(26005)(316002)(6666004)(36756003)(6506007)(66556008)(66476007)(66946007)(4326008)(8936002)(8676002)(6486002)(53546011)(31686004)(44832011)(41300700001)(6512007)(5660300002)(2616005)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3BvWVRxNkRFeFZLUlFNVGJhSVVmdllOZ092clJlRmlZWU16SlpkNEl5UVZY?=
 =?utf-8?B?S05aKzFmMVUvL1pGYTQ0Sm94SWhoUnExci8wM1dweUZsSXM2WTVnLy8rc2dE?=
 =?utf-8?B?N0tsaFhWYnNsYVlYNkNTWkFZWDZET0tCN3lKU1MvMkxsYVJ2ZmF5R3hIaGxI?=
 =?utf-8?B?c3E1bThiYVNhaDlyTEdsN0YxdW0wWXZ1Q2Urdm5SeUc3NmlRcHljd0lCK1Vw?=
 =?utf-8?B?K29rODJtcEE5QWhpY1FKNlBzZmVUQnErQzBXQVE1QS9OdjNrcEMvVDltQkh4?=
 =?utf-8?B?b3JuQ1drTFZ5SGp4Q1NsWGEzc3BydXltc2VzZG9ZVSt5NUNQYXNTcWdtZjJK?=
 =?utf-8?B?N05FVzBIV3ZXc0p0WmUxbm5NOC9lZVQyZkZQSzkrMlBzK1dZTmxkVHNpSzZW?=
 =?utf-8?B?RG02SkNYQjlOWUZPSUtvWmEvTC9SVS8vRlVBN2x2eE9vdW1ibGFwVjNwZ2lk?=
 =?utf-8?B?QlJNR3pJUEM0UUluZXF2TlNxVjFZQU5oOFI2bitBNHAvQkFlSklLK0VMRTdK?=
 =?utf-8?B?TEFrYitxeUl2MnhZN0NyRkVYL0FzdWxKZURZWllLQ2tzejRvVWpxSGdHazk5?=
 =?utf-8?B?VFFzZ3IvY3lCakZpbnVMcks2ZXgvaURBNUY0YnJoWGExWVJWQmV4L2VaaDVQ?=
 =?utf-8?B?S2lnZzBkQXpkSXVRUDNhMUY2ajRseElQay9kKzV0aExTYU9rQWozTFlBRWps?=
 =?utf-8?B?UEJKQU1SLzVjb1hPSFdCQm1jM3JoVmJoclFoaWViaGlmY0dnbkI5K3NJQksw?=
 =?utf-8?B?Y2p1N1FrNmlaQW00a3VYWmwvRHFESC9tOG84bUdYM2dCMU12NnEvczlKTnp2?=
 =?utf-8?B?ZWdGTi9xS1lQL0RaT3Z6TXV2TThnT2QxQXErY3RnU3FpQzVqTnoxdUdJTWph?=
 =?utf-8?B?QnR1WUI0anQ1QWpGemtmR2lHVHkyMXk5YlptTXhjbkdCZFBtRzF5ejErTFRy?=
 =?utf-8?B?YzdDdEtIUkh6a0FpU1pEM2FSSHhjYzcvZWo4RGJoYzlZRHYwZ0VlUG5mRlQr?=
 =?utf-8?B?STl2R1owckNpZmdsT0tuUmRjbXlYcEp6aVdDWVVqY3c1S09WSWtydS9YSjZN?=
 =?utf-8?B?NEtKMDFqOGpmeG1nUVN3Z2hjRmpwOTlaS2wxR0Q3VzRoSHQ4d2FZM1h6aTFU?=
 =?utf-8?B?ZHpxeGpobGhlUTdERm5mNHpDYTcweTczRHJOVUFIREZhWi8xUklBdmE4dDVW?=
 =?utf-8?B?Y3hZUlFpZVVGUlRpWlJCd2ZKd1I5Z0d0WTVSNkRYVDQ4NjA5eU1XZTdKU3lu?=
 =?utf-8?B?VXRVWlA5VE96cWpOSzVub0xUMWRIOHlMZjhoTUtqa2IxUXpycXhKQUQ2UTlR?=
 =?utf-8?B?QUZid0pNVFZOMU1aQkxqRjdtb3hpbUJ6aFpVMmVBSHM1S1FxQlB5U2tZZEZE?=
 =?utf-8?B?d21iTjRKUkVITUNFNmtYQXJDQ2tCMExLaXlITWh0VjQ3N1RiWWpYMEtFMFRu?=
 =?utf-8?B?RTI5ZDJjUjc0TkZzb1QvMkp1dTlMa2Rac0F4QndTcVlIdFNFRW5KNEVjNTlY?=
 =?utf-8?B?RTJ4WWFKcnFJdUpnZVZIVjBVRGJpaktJSCswTjdxZ1lNajZ1WDdKMGUwOTk2?=
 =?utf-8?B?bWdGVGhEeENOcEk1MUFWcXhYdXZwRU0wNHdvbUZONDZ3aE4vUFZRcWpVMkZi?=
 =?utf-8?B?Qy9XNldhZzVrQ3ZoMEZCem1RT2NNd1NFeGZlaUhVRnBpY1k0M20ybUR5K0Nz?=
 =?utf-8?B?Q1hIMFpzdXp6elVWdVg5b2gwSXhOVkVjRlNVSWZsaXpEY3lvQkFNL2hDcEpz?=
 =?utf-8?B?RUcxU3ZVemU1bjBCN1ZJNHk0NnR0bnNUVFNBTEd3ZlNMNnhSMk9wZk8zR1hn?=
 =?utf-8?B?OHVvOWFQTnZnWkIrbDRuMENtNGZqRDdJQVVYemhKQi9OdmcwRTRJMmJFZVIz?=
 =?utf-8?B?aENjay92eWMxYVh4RUJYalBqU1I2b29ybUVUblRRdTI0WEUxd293dG9vU1M4?=
 =?utf-8?B?MWl1dkdKVkxLUGJFYVloRkpTUittU1h4VzZKcTg2NjJsSkdQTG4zZjYydmFR?=
 =?utf-8?B?Sk5DZVhKZm9wUnByaXlyOEtOUlVYdktmNmZsNm81cFY0T3BMTVBRclVuL3pt?=
 =?utf-8?B?c3JRT09JK2FMNzNXQS9vYlk5d3IwSUxZRVJFT0FsT3ZjdjlPS2NSaFlxdkEr?=
 =?utf-8?Q?/R+9Nkh+Hndv7ircSQtodSdM/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 035867ca-bfc6-46d8-99f1-08dbae40bf48
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 18:48:51.4831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcpXvs97FK0sBkmzVlMMulVRbYmKTAdRBQtzfsUzJXlkssySbH9JQmsG/PWb3d0DEPSNIdZDyfOy51t0xNfWWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9339
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
Cc: alexander.deucher@amd.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 2023-08-16 15:26, Alex Hung wrote:
> From: Harry Wentland <harry.wentland@amd.com>
> 
> [WHY]
> We need to track the dc_link and it would get confusing if
> re-using the amdgpu_dm_connector.
> 
> [HOW]
> Creating new amdgpu_dm_wb_connector.
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  5 +++--
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h    |  8 ++++++++
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c | 16 +++++++++++-----
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h |  3 ++-
>   4 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 33e7c463a0d0..b12e8393fef3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4416,14 +4416,14 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>   		link = dc_get_link_at_index(dm->dc, i);
>   
>   		if (link->connector_signal == SIGNAL_TYPE_VIRTUAL) {
> -			struct drm_writeback_connector *wbcon = kzalloc(sizeof(*wbcon), GFP_KERNEL);
> +			struct amdgpu_dm_wb_connector *wbcon = kzalloc(sizeof(*wbcon), GFP_KERNEL);
>   
>   			if (!wbcon) {
>   				DRM_ERROR("KMS: Failed to allocate writeback connector\n");
>   				continue;
>   			}
>   
> -			if (amdgpu_dm_wb_connector_init(dm, wbcon)) {
> +			if (amdgpu_dm_wb_connector_init(dm, wbcon, i)) {
>   				DRM_ERROR("KMS: Failed to initialize writeback connector\n");
>   				kfree(wbcon);
>   				continue;
> @@ -7487,6 +7487,7 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
>   	struct dc_link *link = dc_get_link_at_index(dc, link_index);
>   	struct amdgpu_i2c_adapter *i2c;
>   
> +	/* Not needed for writeback connector */
>   	link->priv = aconnector;
>   
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index a2d0ab881c44..46acf89e5a45 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -32,6 +32,7 @@
>   #include <drm/drm_crtc.h>
>   #include <drm/drm_plane.h>
>   #include "link_service_types.h"
> +#include <drm/drm_writeback.h>
>   
>   /*
>    * This file contains the definition for amdgpu_display_manager
> @@ -714,6 +715,13 @@ static inline void amdgpu_dm_set_mst_status(uint8_t *status,
>   
>   #define to_amdgpu_dm_connector(x) container_of(x, struct amdgpu_dm_connector, base)
>   
> +struct amdgpu_dm_wb_connector {
> +	struct drm_writeback_connector base;
> +	struct dc_link *link;
> +};
> +
> +#define to_amdgpu_dm_wb_connector(x) container_of(x, struct amdgpu_dm_wb_connector, base)
> +
>   extern const struct amdgpu_ip_block_version dm_ip_block;
>   
>   struct dm_plane_state {
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> index 74e656696d8e..b3e634b0f712 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> @@ -30,6 +30,7 @@
>   #include "amdgpu_dm.h"
>   #include "amdgpu_dm_wb.h"
>   #include "amdgpu_display.h"
> +#include "dc.h"
>   
>   #include <drm/drm_atomic_state_helper.h>
>   #include <drm/drm_modeset_helper_vtables.h>
> @@ -183,13 +184,18 @@ static const struct drm_connector_helper_funcs amdgpu_dm_wb_conn_helper_funcs =
>   };
>   
>   int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
> -				struct drm_writeback_connector *wbcon)
> +				struct amdgpu_dm_wb_connector *wbcon,
> +				uint32_t link_index)
>   {
> +	struct dc *dc = dm->dc;
> +	struct dc_link *link = dc_get_link_at_index(dc, link_index);
>   	int res = 0;
>   
> -	drm_connector_helper_add(&wbcon->base, &amdgpu_dm_wb_conn_helper_funcs);
> +	wbcon->link = link;
>   
> -	res = drm_writeback_connector_init(&dm->adev->ddev, wbcon,
> +	drm_connector_helper_add(&wbcon->base.base, &amdgpu_dm_wb_conn_helper_funcs);
> +
> +	res = drm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
>   					    &amdgpu_dm_wb_connector_funcs,
>   					    &amdgpu_dm_wb_encoder_helper_funcs,
>   					    amdgpu_dm_wb_formats,
> @@ -202,8 +208,8 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
>   	 * Some of the properties below require access to state, like bpc.
>   	 * Allocate some default initial connector state with our reset helper.
>   	 */
> -	if (wbcon->base.funcs->reset)
> -		wbcon->base.funcs->reset(&wbcon->base);
> +	if (wbcon->base.base.funcs->reset)
> +		wbcon->base.base.funcs->reset(&wbcon->base.base);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h
> index 0bc9df7e7ee1..13d31c857dee 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h
> @@ -30,6 +30,7 @@
>   #include <drm/drm_writeback.h>
>   
>   int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
> -				struct drm_writeback_connector *wbcon);
> +				struct amdgpu_dm_wb_connector *dm_wbcon,
> +				uint32_t link_index);
>   
>   #endif

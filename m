Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D98606A31B
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 23:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=hLOIzcSk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4030410F93F;
	Tue,  3 Nov 2026 23:15:15 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EED1410F931
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 23:15:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bn3cJk0T93nwLxZtDHk8ZhUgZi9WiHHG5iGAXc9GIhfoxUlFFveIfDVRs4uwrXynlMDsEnrT+OgHVnRgxrKDDJ8Wj40/Dzqeo789EbWEJLGaUyF0VEOtdl65/IHQaxrxB/nsnSD90FrbUS1IfW1XmeYXzHT6EFdEHxuELTy67OdL7tqBPobK8oMlgeWG4Lom6ns8DfyURwlJKqvS/pYB8MqPNqHo2J6fSZltVtI4/DYNFRqODPZorixTQ+3gO/ayJ3RUbhslU8zQCQ4rO0rddtfV3Auaq7GdnxxmSyMgi6yWiAOhFS0QZ7V+t0UjAlyKVBt4xC41BVdtbKt9P/dw2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Olfak4p5ax8LuKjrKSXQXemdjn5ruG+sxmTw4cTlHBc=;
 b=VZLH9xxHcv6wtVeGTmjFBpbAL9ni7V2MFij0X19cZlqQQdBvjmsvovEWBLqflSZSmjxzqiUL9AXSwGDMG/uNA3qGFKlMlRt8LzqOEVVOUSAVKePdb4/Xf23v62UtufLqoUWdt/g4OVG6tJHjt1XHRLYm+kHMnOY58lkaOxuuu8cWJnZYjPckAoTDEqZcSCq5RT/Uh3NqFkZ1Zn7txO+08Q0pq4PjmnKaH4LM/ivY1WdZOXo2WnP6V2TneBYVPAOLGdBCQ43p+n69w7MtKg82CmuAZjeVr8YuEqe2IKagK+vP6A5qCkllR65OVTtsnmrlmrIgbJ2YYBBvkEoGKj9l7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Olfak4p5ax8LuKjrKSXQXemdjn5ruG+sxmTw4cTlHBc=;
 b=hLOIzcSkw3j6gfT4kVu4M8xwHKMYEKRjessFfiDydodH/j5Bw7HYCRl2ossS305AdZWzXD2kVO9BBbtqUuY1BXelLN3OV5pXnQc07+Rsl+aLjyl4vRBzEuS8LeuxCuo0T0NHGuPzegGs9C4QAVZhkjsdmnBOtcHojFmRbYJAZpw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by CHBPR12MB443627.namprd12.prod.outlook.com
 (2603:10b6:610:36c::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 23:15:06 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::67a7:9feb:71ef:964a%8]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 23:15:06 +0000
Content-Type: multipart/alternative;
 boundary="------------G923vxvMVOB4Y9bJZIuvP9pd"
Message-ID: <01e74b6f-3eb4-4ddb-8288-fdabe4efd943@amd.com>
Date: Tue, 3 Nov 2026 18:15:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 5/8] drm/amdgpu: Set up UALink rings and metadata for
 loopback
To: Mukul Joshi <mukul.joshi@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harish.Kasiviswanathan@amd.com, philip.yang@amd.com
References: <20261102160125.2743750-1-mukul.joshi@amd.com>
 <20261102160125.2743750-6-mukul.joshi@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261102160125.2743750-6-mukul.joshi@amd.com>
X-ClientProxiedBy: YT4PR01CA0429.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::19) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|CHBPR12MB443627:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c38d481-32b6-4ec9-cfcb-08df3a004c64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|8096899003|22082099003|18002099003|10067099003|261102123227099003|11063799006|5023799004|4143699003|261021123027099003|261022105027099003|261026140227099003|261026121527099003|56012099006|261028144727099003|261009223027099003|261021121427099003|261102130727099003;
X-Microsoft-Antispam-Message-Info: QIV4bez65IvjZtX9Oi0lM/A4F5eYFpmtb+6pfyAdFU9KNh9LoFGPVnalFUowKF+QDO24N67M8KkfAVdlj27JClaSGgUCYX4ruyTAFR/j1BnEXshzgE4DBzKchnBjp1S7LYuT+a6ZAxQfDYLz4DgewqOq4FegodTLS9XrA8ePsk5se2g8fIOM8D7NsNw2EXMDAFh4cz6Z+QviUhjjmGxzxApOM33sCvEpfuaFxiZxzTTqpieCbov+r8MAym6xmuQQ0/WYaii74NrJkNumGKnwUh4nLt2s5Oq9RsGHYTrCBrQFS6IaDpkT5cFG9tdKizABAgKgWuh5Qjg2XT5TImusp9TwPZyzTb0PLUTAFkY/LL4gscefcbNow9pgILGYn2TwztH+ECvXFmGWGbP849qd6eNMSIgFiK6+SOHMkCOxVSNcQXEa6U/gHnJBC1/9fSCFus/JAquUKVDcEYwUEx28VhdfmLsfYUvg3mk9IpZPxt3smxxnaiDkXZkU8hqdVhWOhgICp4UPWSnsYm0qsWsW1YPqxLYlB4R707c0NHe8xem8OgKA7A+kjcZL0gjw+f/2LLCrNI7edUm4uIMPdV7y7Aaec3bMZH+dy0Mcv/TyaZNQmIb9WlVsH3W6yx2HC2u3UtK8co24XRDRjNQiv9Kio22g28ZNKs4rLtKBUzXpaiI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(8096899003)(22082099003)(18002099003)(10067099003)(261102123227099003)(11063799006)(5023799004)(4143699003)(261021123027099003)(261022105027099003)(261026140227099003)(261026121527099003)(56012099006)(261028144727099003)(261009223027099003)(261021121427099003)(261102130727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGN1Z0JSU0JhS3lzbWp0S2E1RXc4MitVWWdJN2hsOFRYa0d3UFpoSkRMMUJJ?=
 =?utf-8?B?cUJGUVpOT05mTWdCT3JFNW5LSTN0QitzejkxcmNDRXExZUpJWWdtcVNYYUdr?=
 =?utf-8?B?c2VuUjFzelNycXJCUlhid1BqUmlsWU9jWEcwNzZHQVR2T0JvN25kVUNnMmc4?=
 =?utf-8?B?cHVndmRyS1M2TnM0dGZZNmdSR2d0UlJRaU5uaTEvd3Rnd1RHMlZHVU1uZks0?=
 =?utf-8?B?U1M1QTgxVllLU2JEbFU3dHJYV3luUEROaTFnQlllNzBuQkFSSGpkSFNZSDVa?=
 =?utf-8?B?RlNLZFFaVWpIeVpOSURwZFRTeHZYUlpQZGJwMFJ4aEJUY1VTd29jWE9qZjZI?=
 =?utf-8?B?S1Y3TXlldUp0dXVXcm1pQ0lZdGdGQ1MySDhRWkd5RzVpZzdGQlMzZ1JaZU1D?=
 =?utf-8?B?TFUyUnlnZmYzbG92VExaVjc2VUpSRlBQRnRydmIxZTJEVjFVYUI2VkRQYzNC?=
 =?utf-8?B?UWRYYzRaQ3k5TlE0eFBMTGY1d2FDUmRYUVpnclNDMWUwOGN0bVFVV2h6NXhN?=
 =?utf-8?B?S3dvNW5qWlQzakZxT0oxVi9VdDVpYnhtK294aWRlSmd1eXFvbGRNTXNtK1lZ?=
 =?utf-8?B?R2VBVTB0UzJvVWJKNFBqdDY0SWhvcDdtaStLUC9GUm80d0daV2I5SmpmSzN5?=
 =?utf-8?B?UFcvM2tCMXZmVitaYlVvT24zN0xocFBROEdSV1dkZjRIdHpvSFlOK09SMTJ5?=
 =?utf-8?B?NjNGTXdvcDJKRDV1SXd1Rkh3NHA5bllVeU90NjRxdytBSTkwVHBxb0l4VXFD?=
 =?utf-8?B?NjJpdlJuR3laaGFnNWJDc0ZXNy9IUDl1S1YrMGU5b05NSHVNVmx2S0RaY0dC?=
 =?utf-8?B?VXNMUWh6NzN6U2MxRFpndTFuVFZ0OW9ERXh5WTArY3QzNHhXckxLTlMzV0dR?=
 =?utf-8?B?RVZPZ2lHZDdLNGZMbmROR1N0aGF4OFZ6S3FxSlZpc0l5R0M5YzVsRXBoRkJy?=
 =?utf-8?B?c0M0eE9MVE8zOGpLaWFheGFoMWJRRmVQTklLQXdCaTJNQW90c05LNWpXNkhi?=
 =?utf-8?B?OVQ1cFdhemhtT1lqNjB4M095MDhyb1c5TEdad2VCdHRueUdDaUFjTnVXeXVM?=
 =?utf-8?B?TklIblpRRTBxeSs1L01qU2hMK0hHUDk2QVRTMCtyYW45akJDWHlSUDc5aUN6?=
 =?utf-8?B?OXo0Wm1BeTNMbkN1OHdLUWRWZFZyVnlKeDlveU5POUJ6MHFwaFN5NTYzUzFa?=
 =?utf-8?B?QWVscytCanFhd2plbHZuNStUUlBmNk1VVkFmekprMGdLTXRFcTJrWDVONmlT?=
 =?utf-8?B?SHdoRmRSSXhiYllXU1VJMjlUUHlHYWRKUE9Bdk8vMC9QTFczemZKbEwyaUk1?=
 =?utf-8?B?bEV3ckwxMDZaME1wVDlBSUZvWnErUTlQL0FxUldGL3BURmJCUjBiTStaVVRV?=
 =?utf-8?B?TjdMTGFJRDJncWRiMVJ6Ty82SnBpeFREMVlIWGV6akdwVXF1OHlUMlo0czQ5?=
 =?utf-8?B?cmVqQnoza1hVcDIvb3F0eVg5SUQ3aGpXQ3dSRlhyREdlb09OTmNiQzl0ZmFV?=
 =?utf-8?B?V01GUkowYXhZRmxtL3VFN3JIcGpmK1RmUi96M1hLYndYYVVCVnllQW54UUtQ?=
 =?utf-8?B?R2JmbVZtYTd3cDF4d2paM2t2ekpGeS94b0tjMkhpUXNoUStYaDM5QXZBelRB?=
 =?utf-8?B?MGRZcnl6cXZvdzVvaHBCNG1kYnVZMEIwN1VuYlJ1VWxQTFNYVFlKQ0VwSkdn?=
 =?utf-8?B?RlNrWGloTDZJU1N1SmwyZ1V2c1ZWMm1PWGtlWlREd1c5SEd3R09ZYnl4WVVn?=
 =?utf-8?B?OHdVZytyY05ZQ3lYOE83c0lqT0UzLy9aMlVkYlA3MCs0VS9odzhHQVBQTU9M?=
 =?utf-8?B?U3FxVE9yYjdTWXRHbVdQYmFwTm5vNW5nM3JaZHpTZTNlSiszKzVNNThRVEhn?=
 =?utf-8?B?bkxUMHhjb1dhTTk5ZU1HU0sxRlY4OEtCRXJLaTBudERudlR5dldUTWZ1UW01?=
 =?utf-8?B?ai9ZZkFFd0lwbnp6bC8yOXdOYjlRR2VzMm1HYkFidWMxQmMveUt4Ti9UNDVs?=
 =?utf-8?B?SVZpYWFpbisxZWFyTC8xR25wS1p3RGVJUFhSMjlXTHpoSVplSmlWMHVoRU9P?=
 =?utf-8?B?a1dwaWpiQ21DcUsrcVhMWHkvRnJvWHhxclJCWk5WL05wMWRBTmkybmtGRHdX?=
 =?utf-8?B?WTN4c01XUzJyRldoYXR2aTZ6d3BNNE1BSmpyVlRrUENFVVhvYUVxTW9yWlFi?=
 =?utf-8?B?dmFKbmYrRWJhVnc2Tzh3RGpVYnNPdnhIRUJBRnRzYURFZ2I5eWZRVkQ2d1M2?=
 =?utf-8?B?K0I4b1l6ZGI2VDZ4ZHB2dGc5UjBWT0RQMlVDbmx5d0VJRUI4ZDk3eHFrdzk2?=
 =?utf-8?B?RjhqWENYK3RsV2RLU0ptdVYvWmJVL0lkWUhaOEl4cU9kNWRWb3JlZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c38d481-32b6-4ec9-cfcb-08df3a004c64
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 23:15:06.7122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5DrmmXqAkTf0huhu/s6pOmoxQf3fyOZ1Z0b/rFkhbJqX9P2029TUo39ZVFvJPeBumbT1/zEOnRD1AN8v7mtmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB443627
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--------------G923vxvMVOB4Y9bJZIuvP9pd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-11-02 10:47, Mukul Joshi wrote:
> In UALink loopback mode a single GPU acts as both the exporter and the
> importer, and the only path the HW serves is importer -> exporter.
> Adjust the per-peer setup accordingly:
>
> - The importer's doorbell reaches the MP nHT stamped with the GPU ID of
>    the exporter, and the FW looks up the metadata entry by that ID. So
>    publish the importer's rings and tail pointers in metadata[exporter].
>
> - Skip the ring pointer resync. Both ends of every ring are on this
>    GPU, so there is no remote peer that can reboot and leave the
>    pointers stale.
>
> - Do not take the local dma-buf shortcut on import. It would bypass
>    the NPA path that loopback is meant to exercise.
>
> Signed-off-by: Mukul Joshi<mukul.joshi@amd.com>
> ---
> v2->v3:
> - Move updating src_accel_id in peer_remote_init and fini to patch 1.
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 54 ++++++++++++++++------
>   1 file changed, 41 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> index 8558dc1a9e84..74bc8a907f5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -3976,7 +3976,13 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
>   		return -EINVAL;
>   	}
>   
> -	if (amdgpu_ualink_is_local_accel(adev, remote_acc_id))
> +	/* In loopback mode the exporter and importer are the same GPU, but the
> +	 * import must still go through the full cross-domain NPA path (the
> +	 * dma_buf shortcut in amdgpu_ualink_local_import() bypasses NPA). Only
> +	 * take the local shortcut for genuine same-pod local accelerators.
> +	 */
> +	if (!adev->ualink.loopback.enabled &&
> +	    amdgpu_ualink_is_local_accel(adev, remote_acc_id))
>   		return amdgpu_ualink_local_import(adev, remote_acc_id,
>   						  &handle, fd_out);
>   
> @@ -5452,11 +5458,28 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>   		wptr_gpu_addr = remote->rb_gpu_addr + rb_size * ualink_exp_accel_id(adev);
>   
>   	for_each_set_bit(accel_id, remote->active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
> +		struct amdgpu_ualink_metadata *md;
> +
>   		dev_dbg(adev->dev, "init for accel_id %u\n", accel_id);
>   
>   		if (accel_id == ualink_exp_accel_id(adev))
>   			continue;

I think you could drop the condition just below if you change this to

		if (accel_id == ualink_imp_accel_id(adev))
			continue;

It makes no difference if loopback is disabled. And with loopback 
enabled it's the more obvious way to only initialize the ring for the 
exporter ID. Then all the other changes in this function are unnecessary.

Regards,
   Felix


>   
> +		/* In loopback the single MP nHT services the exporter half:
> +		 * the only messages delivered over HW are importer -> exporter
> +		 * (source = importer accel_id), while the exporter -> importer
> +		 * direction is emulated in SW and never reaches the MP nHT.
> +		 *
> +		 * The importer's doorbell reaches the MP nHT stamped with the
> +		 * GPU ID of the single physical station, the exporter, so the
> +		 * FW looks up metadata[exporter]. Publish the importer's rings
> +		 * and tail pointers in that entry.
> +		 */
> +		if (adev->ualink.loopback.enabled)
> +			md = &metadata[ualink_exp_accel_id(adev)];
> +		else
> +			md = &metadata[accel_id];
> +
>   		rb_gpu_addr = remote->rb_gpu_addr + rb_size * accel_id;
>   
>   		if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT) {
> @@ -5464,27 +5487,26 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
>   			wptr_gpu_addr += wptr_size * accel_id;
>   		}
>   
> -		metadata[accel_id].header = AMDGPU_UALINK_METADATA_HEADER;
> -		metadata[accel_id].rb_size = fls(AMDGPU_UALINK_RB_SIZE / 64) - 1;
> +		md->header = AMDGPU_UALINK_METADATA_HEADER;
> +		md->rb_size = fls(AMDGPU_UALINK_RB_SIZE / 64) - 1;
>   
>   		/*
>   		 * remote shootdown type is 0, remote command type is 1
>   		 * with 2MB ring buffer mapping, remote shootdown ring NPA is before interrupt
>   		 */
> -		metadata[accel_id].ri_rb = rb_gpu_addr + AMDGPU_UALINK_RB_SIZE;
> -		metadata[accel_id].tlb_inv_rb = rb_gpu_addr;
> +		md->ri_rb = rb_gpu_addr + AMDGPU_UALINK_RB_SIZE;
> +		md->tlb_inv_rb = rb_gpu_addr;
>   
> -		metadata[accel_id].tailptr_ri = wptr_gpu_addr +
> -						ualink_wptr_offset(adev, accel_id);
> -		metadata[accel_id].tailptr_tlb_inv = wptr_gpu_addr +
> -						     ualink_tlb_wptr_offset(adev, accel_id);
> +		md->tailptr_ri = wptr_gpu_addr + ualink_wptr_offset(adev, accel_id);
> +		md->tailptr_tlb_inv = wptr_gpu_addr +
> +				      ualink_tlb_wptr_offset(adev, accel_id);
>   
> -		dev_dbg(adev->dev, "init from accel_id %u to accel_id %u, rb_size 0x%x\n",
> -			accel_id, ualink_exp_accel_id(adev), metadata[accel_id].rb_size);
> +		dev_dbg(adev->dev, "init from accel_id %u to accel_id %u, metadata entry %td, rb_size 0x%x\n",
> +			accel_id, ualink_exp_accel_id(adev), md - metadata, md->rb_size);
>   		dev_dbg(adev->dev, "rb 0x%llx tlb rb 0x%llx\n",
> -			metadata[accel_id].ri_rb, metadata[accel_id].tlb_inv_rb);
> +			md->ri_rb, md->tlb_inv_rb);
>   		dev_dbg(adev->dev, "rb wptr at 0x%llx tlb wptr at 0x%llx\n",
> -			metadata[accel_id].tailptr_ri, metadata[accel_id].tailptr_tlb_inv);
> +			md->tailptr_ri, md->tailptr_tlb_inv);
>   	}
>   
>   	r = adev->ualink.msg_ctl->send_metadata(adev,
> @@ -6069,6 +6091,12 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
>   	u64 int_wptr, tlb_wptr;
>   	int r;
>   
> +	/* UALink loopback: both ends of every ring live on this GPU, so there
> +	 * is no remote peer that can reboot and leave the pointers stale.
> +	 */
> +	if (adev->ualink.loopback.enabled)
> +		return 0;
> +
>   	/* ring->wptr and ring->rptr are owned by the send path. */
>   	guard(mutex)(&peer->lock);
>   
--------------G923vxvMVOB4Y9bJZIuvP9pd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2026-11-02 10:47, Mukul Joshi wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20261102160125.2743750-6-mukul.joshi@amd.com">
      <pre wrap="" class="moz-quote-pre">In UALink loopback mode a single GPU acts as both the exporter and the
importer, and the only path the HW serves is importer -&gt; exporter.
Adjust the per-peer setup accordingly:

- The importer's doorbell reaches the MP nHT stamped with the GPU ID of
  the exporter, and the FW looks up the metadata entry by that ID. So
  publish the importer's rings and tail pointers in metadata[exporter].

- Skip the ring pointer resync. Both ends of every ring are on this
  GPU, so there is no remote peer that can reboot and leave the
  pointers stale.

- Do not take the local dma-buf shortcut on import. It would bypass
  the NPA path that loopback is meant to exercise.

Signed-off-by: Mukul Joshi <a class="moz-txt-link-rfc2396E" href="mailto:mukul.joshi@amd.com">&lt;mukul.joshi@amd.com&gt;</a>
---
v2-&gt;v3:
- Move updating src_accel_id in peer_remote_init and fini to patch 1.

 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 54 ++++++++++++++++------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 8558dc1a9e84..74bc8a907f5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3976,7 +3976,13 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
 		return -EINVAL;
 	}
 
-	if (amdgpu_ualink_is_local_accel(adev, remote_acc_id))
+	/* In loopback mode the exporter and importer are the same GPU, but the
+	 * import must still go through the full cross-domain NPA path (the
+	 * dma_buf shortcut in amdgpu_ualink_local_import() bypasses NPA). Only
+	 * take the local shortcut for genuine same-pod local accelerators.
+	 */
+	if (!adev-&gt;ualink.loopback.enabled &amp;&amp;
+	    amdgpu_ualink_is_local_accel(adev, remote_acc_id))
 		return amdgpu_ualink_local_import(adev, remote_acc_id,
 						  &amp;handle, fd_out);
 
@@ -5452,11 +5458,28 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 		wptr_gpu_addr = remote-&gt;rb_gpu_addr + rb_size * ualink_exp_accel_id(adev);
 
 	for_each_set_bit(accel_id, remote-&gt;active_accel_bits, AMDGPU_UALINK_ACCEL_MAX) {
+		struct amdgpu_ualink_metadata *md;
+
 		dev_dbg(adev-&gt;dev, &quot;init for accel_id %u\n&quot;, accel_id);
 
 		if (accel_id == ualink_exp_accel_id(adev))
 			continue;</pre>
    </blockquote>
    <p>I think you could drop the condition just below if you change
      this to</p>
    <pre>		if (accel_id == ualink_imp_accel_id(adev))
			continue;
</pre>
    <p>It makes no difference if loopback is disabled. And with loopback
      enabled it's the more obvious way to only initialize the ring for
      the exporter ID. Then all the other changes in this function are
      unnecessary.</p>
    <p>Regards,<br>
      &nbsp; Felix</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20261102160125.2743750-6-mukul.joshi@amd.com">
      <pre wrap="" class="moz-quote-pre">
 
+		/* In loopback the single MP nHT services the exporter half:
+		 * the only messages delivered over HW are importer -&gt; exporter
+		 * (source = importer accel_id), while the exporter -&gt; importer
+		 * direction is emulated in SW and never reaches the MP nHT.
+		 *
+		 * The importer's doorbell reaches the MP nHT stamped with the
+		 * GPU ID of the single physical station, the exporter, so the
+		 * FW looks up metadata[exporter]. Publish the importer's rings
+		 * and tail pointers in that entry.
+		 */
+		if (adev-&gt;ualink.loopback.enabled)
+			md = &amp;metadata[ualink_exp_accel_id(adev)];
+		else
+			md = &amp;metadata[accel_id];
+
 		rb_gpu_addr = remote-&gt;rb_gpu_addr + rb_size * accel_id;
 
 		if (ualink_addr_mode(adev) == AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT) {
@@ -5464,27 +5487,26 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 			wptr_gpu_addr += wptr_size * accel_id;
 		}
 
-		metadata[accel_id].header = AMDGPU_UALINK_METADATA_HEADER;
-		metadata[accel_id].rb_size = fls(AMDGPU_UALINK_RB_SIZE / 64) - 1;
+		md-&gt;header = AMDGPU_UALINK_METADATA_HEADER;
+		md-&gt;rb_size = fls(AMDGPU_UALINK_RB_SIZE / 64) - 1;
 
 		/*
 		 * remote shootdown type is 0, remote command type is 1
 		 * with 2MB ring buffer mapping, remote shootdown ring NPA is before interrupt
 		 */
-		metadata[accel_id].ri_rb = rb_gpu_addr + AMDGPU_UALINK_RB_SIZE;
-		metadata[accel_id].tlb_inv_rb = rb_gpu_addr;
+		md-&gt;ri_rb = rb_gpu_addr + AMDGPU_UALINK_RB_SIZE;
+		md-&gt;tlb_inv_rb = rb_gpu_addr;
 
-		metadata[accel_id].tailptr_ri = wptr_gpu_addr +
-						ualink_wptr_offset(adev, accel_id);
-		metadata[accel_id].tailptr_tlb_inv = wptr_gpu_addr +
-						     ualink_tlb_wptr_offset(adev, accel_id);
+		md-&gt;tailptr_ri = wptr_gpu_addr + ualink_wptr_offset(adev, accel_id);
+		md-&gt;tailptr_tlb_inv = wptr_gpu_addr +
+				      ualink_tlb_wptr_offset(adev, accel_id);
 
-		dev_dbg(adev-&gt;dev, &quot;init from accel_id %u to accel_id %u, rb_size 0x%x\n&quot;,
-			accel_id, ualink_exp_accel_id(adev), metadata[accel_id].rb_size);
+		dev_dbg(adev-&gt;dev, &quot;init from accel_id %u to accel_id %u, metadata entry %td, rb_size 0x%x\n&quot;,
+			accel_id, ualink_exp_accel_id(adev), md - metadata, md-&gt;rb_size);
 		dev_dbg(adev-&gt;dev, &quot;rb 0x%llx tlb rb 0x%llx\n&quot;,
-			metadata[accel_id].ri_rb, metadata[accel_id].tlb_inv_rb);
+			md-&gt;ri_rb, md-&gt;tlb_inv_rb);
 		dev_dbg(adev-&gt;dev, &quot;rb wptr at 0x%llx tlb wptr at 0x%llx\n&quot;,
-			metadata[accel_id].tailptr_ri, metadata[accel_id].tailptr_tlb_inv);
+			md-&gt;tailptr_ri, md-&gt;tailptr_tlb_inv);
 	}
 
 	r = adev-&gt;ualink.msg_ctl-&gt;send_metadata(adev,
@@ -6069,6 +6091,12 @@ static int amdgpu_ualink_ring_resync_ptrs(struct amdgpu_device *adev,
 	u64 int_wptr, tlb_wptr;
 	int r;
 
+	/* UALink loopback: both ends of every ring live on this GPU, so there
+	 * is no remote peer that can reboot and leave the pointers stale.
+	 */
+	if (adev-&gt;ualink.loopback.enabled)
+		return 0;
+
 	/* ring-&gt;wptr and ring-&gt;rptr are owned by the send path. */
 	guard(mutex)(&amp;peer-&gt;lock);
 
</pre>
    </blockquote>
  </body>
</html>

--------------G923vxvMVOB4Y9bJZIuvP9pd--

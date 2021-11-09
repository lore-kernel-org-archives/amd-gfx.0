Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32328C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 13:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E015961205
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 13:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E015961205
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B1D76E864;
	Tue,  9 Nov 2021 13:55:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADA996E864
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Nov 2021 13:55:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrvMscgGaP5ynPEh82/otrDbp91IwchB+3nYF0pYhwBxvV0WkQ7L6ZUoj4V2F7bsNaYgO7Xad8kI+/OTCFIOVut7ZvznRgp7pEYObLLxl4+Nzz6ZE9NkpflyRFP21kJ+TkcWX/aeJinSZlPJsd+58S4mowglKO3RrrgBz9ErgScivrFKbQqZLjs1lPfUwtWof3z45vfHo6oRuoD+P3v0CeiHVeIpXvzag7An3Zcs5qEJ/ShFVOnaSrAtfKzhTI7182WujhFh2MC3k8o6aSrQ5S/R5QMn/fIYiEVN48oxXULsbVRmgS06I2ZhN9NN3/ul6Q2xsink5uy5tmvIdMEYHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RF14Vip0+zBfDYBkTw19mA0YbdMI2tmKB9wYT0hiD2U=;
 b=TUH9+VlYHesVCKqCHVc2Z9LtYrZS4QxW3k2HX1ehs22E6C993ZaVUmcxqrr02paeve8G8yP+uA16xj/xBuzzNx4ls0hDMZCQzQICWF2NZrtP0+Q80vwnvn3Cr8YhW4JtpB2TEzzxKkTrGs2D9+q+/2jPPc52rVLC1XwPrAHrr8UzQzM2CCbAqliLX3lanq3qDNIxvyKNcGDW4iu4kIns/kOJbztnLSQ4J/yL595wz41AV1drS5KO8Ud5dZzL2xwXbBsXOzybCR0ya28L+TUpeE2WGUdkcwbZ14XD8vIrj594+mPt9xk9sKpxafQ5r7OkqqMXaPb6TamOTMPRSNOIRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RF14Vip0+zBfDYBkTw19mA0YbdMI2tmKB9wYT0hiD2U=;
 b=nUoztVi6lBDzSC/RZCgVA6iCfQKc1UKvjXQRClYVBK9VAOLptL9Kg+n0MJyIkc5y4NnWzoy6i8Ja7x5NJekAxrSyJtkTTaHSg/BMDB9uJqrecNd67JVivH07Kj5f538k0JaXxc2U9UIg6ADlvPpajksThsciIOSRWbct35yjIaY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5490.namprd12.prod.outlook.com (2603:10b6:303:13d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 9 Nov
 2021 13:55:15 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d095:131a:b99a:9975]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d095:131a:b99a:9975%3]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 13:55:15 +0000
Message-ID: <ad47f5cd-7514-5f5e-edbc-659d7135e88f@amd.com>
Date: Tue, 9 Nov 2021 08:55:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amd/display: log amdgpu_dm_atomic_check() failure
 cause
Content-Language: en-US
To: Shirish S <shirish.s@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20211109051454.46574-1-shirish.s@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20211109051454.46574-1-shirish.s@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::18) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.4] (198.200.67.104) by
 YQBPR01CA0046.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.15 via Frontend Transport; Tue, 9 Nov 2021 13:55:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eca92fd1-acd9-4732-2b0f-08d9a3888e57
X-MS-TrafficTypeDiagnostic: CO6PR12MB5490:
X-Microsoft-Antispam-PRVS: <CO6PR12MB54901CF6192D6994FF774B4A8C929@CO6PR12MB5490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gk3wbvspF5T8T8xyuvfnUMhsWix2WYRKUnvgItB2UmJGfS382xwxNiPiE3gjDPpPGyyi0+neczNBUiphvRs8MzEcxPzKNYfHoIRBYebSLdJsso5i9Ftp4xXQs3QyUGJ9vpjmBJKhr9YZn21COMkQ8cwFu6TrS5yS9792goLPSred1lQwZ/42VNmbnpGfnUlZ4lgOWAds6gu0AgWBQnGhQtS5yakWcMgYswUsRwktKzgDvBRFgj4u+2I4LDe5fVeJVaJOCPfhnMdmF2JEbDALqg0Gv74nZxEvesKG7mDQsy2kp0ts5GlKs4ZkKc2k5eONtloQ2uyyKebKKFHYpyfidRnhiPCLq8ofIiWzG5mNknued88117Ypxu7i9/bcsVIV9/y9+JrUQkJuIAJvaDek1dArC2i7/fZk4ycm4kGBf+kEe77EqBdh1BAG2mJmn4OF9HE7OJRoMRYbiJrjhXudEfE/HPv98wf8BGbn43ewqlyHVtuwLnQ+akPRPytDTzq6kQC/VCe+/Wsu/A+MsAMU1qsL6Sp8afdAd3DKumrQp4kxolntJQpv1wUP1vkfDnwwK0B0JMZAFPyC4PFqvNFDt7DT1ADeL0aJzow5QKSzd9aL9J8zu/Nu0eKTo2YPxrbIam6gQukaYmcDhTf+BdbhwYu6Ei+L2Uyy4a2VRwaRHqBrlwBXIPn8HEj7Qv8gHx+SrP+5jTGVhrlYD9gV2W4YH1s5EKakOGm2FQjSrAqo2ug=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(66476007)(110136005)(6636002)(2906002)(2616005)(956004)(508600001)(44832011)(66556008)(66946007)(4326008)(53546011)(36756003)(26005)(186003)(31686004)(31696002)(38100700002)(8936002)(316002)(6666004)(83380400001)(86362001)(6486002)(16576012)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlZVZGs2b1pENC9nTFBsN0djeUs0dzA5UE9YZE0rcEJtdUU5OVdlUkd2akFN?=
 =?utf-8?B?THN5QjFKWFljZHhIcE0xZkhvdjZzU1lQR0NRUDhJZXJBcEdhQW1FZWFveG5C?=
 =?utf-8?B?dXRMS21FWG50N3FNNGwwUytHc3BkNmRjNlVOQlBqV3dtNFFCbWZMZWV4WUFn?=
 =?utf-8?B?WE9IeFdPN3BKaGlPYTNIbERUUlRTZmx6TU5BYVN3bHc1ZXBSeDUwdjNJMkg3?=
 =?utf-8?B?UU1Gbks3UWFJdm9wL3JMS3hzZ0tkd1FYRGMyZFBIZkJ5dk80TUNmaHZxL2R1?=
 =?utf-8?B?Q3EyT2J5bGgraU1HeVVPOHZ6V0N4Y2NidzFNdTdnRFZKaUJ0TnI2UDRTTkxJ?=
 =?utf-8?B?cUMvenlaRTdhSjlQU3BLU1h2Qy93MmhCUnF5QWFKTzBRaUNmUTNOVks3U0Rp?=
 =?utf-8?B?WEt4QlY0MUdLaTRXbkRoMGxwWVczMW5PV0ZpKzgvQUxVTm14aHRnY3Z1RUNK?=
 =?utf-8?B?WEZpU3NKN3lFYy8xU1M1cHBWeUxpeExvNFZoaS9FNDUzZG9yMHoxazloN2o5?=
 =?utf-8?B?azBSRThXV0Y2N2xiTnhMWXkwelR4K2ZwZnZzdFZQYTdMUFRSSjJOUy84a3hY?=
 =?utf-8?B?OTZRdkRzekswbUdoSnhXTVE5TjdXbUY1b2Y5TjhGbEVRN09xNFIrN29zWHVz?=
 =?utf-8?B?eU90S2h5amRwVjdFOGQ0VXg0NCtEQVdEMmt4NjNWRmhWb25QU3cxL1ZlZkox?=
 =?utf-8?B?ei93c0hueUJCSzhpQnpKZnlxNlNuU2M3aDJZTXJYQlpETXo5THEyTi9mUm15?=
 =?utf-8?B?d0lYdGQyTUFqSVh5M1B6Y012dGtDSXJNalBNY1d5TFJtbFBVdllxWUhCTGNS?=
 =?utf-8?B?VXRzaG5lWk5hcXhMUE03alJ4dkU3K2NwcnNqZFFjOEU0eHZ0QTZ1c1pab2RI?=
 =?utf-8?B?V3YyRldKTmtFRXBsNFNQVjJuREZXVlU2SE51MXUyQUl2RDJtbkpKd2lwS1do?=
 =?utf-8?B?dFJVTWx4RERFMDFqM0xNazZaWHh4TXF1dXV5cDRBR25zZnQ0UFhWRVh3QVoz?=
 =?utf-8?B?KzhLNTV6ZHJRTERFSDRLYlVlb01BaEVmZnY4YnA0eWExN2xXM29RVnpxSmpD?=
 =?utf-8?B?YUJoTVk2NktSUyt6YnlmaVNOY1FUOXRTak9iTURweXFxcEpyd2tKRlMrcnFm?=
 =?utf-8?B?OEYyVUdiYzVHSXlVb3RUT0t5akZ5Mi9SL3cwNklFWDg3SlIveFhqZUZaQ0lI?=
 =?utf-8?B?ZVVNeithVVdOU2p2NUpYUkNqRXdEK2VJa3V0KzNnYzRpallQK2tOMnoyb0RB?=
 =?utf-8?B?V0dITnRwWnpMNnZkTzZiWGl4THdndUVmL1A1dHhsc2VURHBjditlVEo3VHQ1?=
 =?utf-8?B?YlU0YndPOVE3WVFPd0Fsbk1zSkdPM1JpUnoxeHA3Mml0YjhUUSt3ZG0zR0F2?=
 =?utf-8?B?UWwyR1BPU3oxZUJMYVowcklEdkl4VVl3bEJNZkJFMzFOUEZDajVYQ0p2Mmpr?=
 =?utf-8?B?VWloRmV1QUJYdzYycUE4bnNFcnl1a3NSNGozMDlhd3V4bHAvSFJOc3VNSGJB?=
 =?utf-8?B?VEFEN29CTEtkSTFOb3lVOFNTeDlNenN2R3pyUk12YmV0ckd1LzJCMjUrdlZL?=
 =?utf-8?B?Wm4xVHhpVC8wQm1uekJUM21iSkFRejhsSnB6QWZqZGpkV3dhNzNuQmh2U25N?=
 =?utf-8?B?SXdDa2Z1ZGxJcldOT2xKaGljZU5PdnU0a1VnOGx6V3h5VWJGRGx3bU9PQzRE?=
 =?utf-8?B?dmxsT1NKeHcxL2g3M1Jlb1hZYk5FSnh4emViL1hQVHhtcTY2aGVuRnE2Tk5i?=
 =?utf-8?B?ckJjeG5oM1UwbXNzRWpFSnhoWlZsaDhBYzQwcHJZZEh3M1B0TTI1YjlxbnRZ?=
 =?utf-8?B?SXFKaGlva05NaUM4V3F6ODdwZnhKQ0lJL0p5ZlBuTkVvUjdRbjBUWkhxWkt5?=
 =?utf-8?B?UGNGZUtmNVhCbXhUcnFLSlBFM0x4WjFRYmRGWWhRc3Y4S0RMazZ6WmZ4L21L?=
 =?utf-8?B?UjFSS3RkNHpycmJtcHNqUTYzeVFIa3dwejd6bTI2dWk0ay84QWpWVUkzR2JO?=
 =?utf-8?B?anZxdlRweS8xT1pzb3ZGeS82QVgrSUlzRkZ0cjhyOUVmZXRQdFFMVnFVc0pM?=
 =?utf-8?B?blE5UmZlZDVEZFBNVDBxNmlUVlFWakg4ODFpdCswUThQVEdlVkRDNTBpQmJj?=
 =?utf-8?B?T21DVFdXdlBPelZqWjJBQ3J5NUlWb1FZNXhXY0RyYWhjWUJDTC94VDVvMGpB?=
 =?utf-8?Q?0iGAQPpbwin7ZBc87Ol4GZY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca92fd1-acd9-4732-2b0f-08d9a3888e57
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 13:55:15.2167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKZm2DIjz5YNlcO+Kr1KAoBWWum6ThZbZq9d7UDOSyjbjUQC3wgNd8IwcdRg/3NEoAj4auN5braH8g8GIqDnLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5490
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-11-09 00:14, Shirish S wrote:
> update developers with next level of info about unsupported
> display configuration query that led to atomic check failure.
> 
> Signed-off-by: Shirish S <shirish.s@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 69 ++++++++++++++-----
>  1 file changed, 51 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b1d9e89e5ae9..b7044c04a7c5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10755,8 +10755,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>  	trace_amdgpu_dm_atomic_check_begin(state);
>  
>  	ret = drm_atomic_helper_check_modeset(dev, state);
> -	if (ret)
> +	if (ret) {
> +		DRM_DEBUG_DRIVER("drm_atomic_helper_check_modeset() failed\n");
>  		goto fail;
> +	}
>  
>  	/* Check connector changes */
>  	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
> @@ -10772,6 +10774,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>  
>  		new_crtc_state = drm_atomic_get_crtc_state(state, new_con_state->crtc);
>  		if (IS_ERR(new_crtc_state)) {
> +			DRM_DEBUG_DRIVER("drm_atomic_get_crtc_state() failed\n");
>  			ret = PTR_ERR(new_crtc_state);
>  			goto fail;
>  		}
> @@ -10786,8 +10789,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>  		for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
>  			if (drm_atomic_crtc_needs_modeset(new_crtc_state)) {
>  				ret = add_affected_mst_dsc_crtcs(state, crtc);
> -				if (ret)
> +				if (ret) {
> +					DRM_DEBUG_DRIVER("add_affected_mst_dsc_crtcs() failed\n");
>  					goto fail;
> +				}
>  			}
>  		}
>  	}
> @@ -10802,19 +10807,25 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>  			continue;
>  
>  		ret = amdgpu_dm_verify_lut_sizes(new_crtc_state);
> -		if (ret)
> +		if (ret) {
> +			DRM_DEBUG_DRIVER("amdgpu_dm_verify_lut_sizes() failed\n");
>  			goto fail;
> +		}
>  
>  		if (!new_crtc_state->enable)
>  			continue;
>  
>  		ret = drm_atomic_add_affected_connectors(state, crtc);
> -		if (ret)
> +		if (ret) {
> +			DRM_DEBUG_DRIVER("drm_atomic_add_affected_connectors() failed\n");
>  			goto fail;
> +		}
>  
>  		ret = drm_atomic_add_affected_planes(state, crtc);
> -		if (ret)
> +		if (ret) {
> +			DRM_DEBUG_DRIVER("drm_atomic_add_affected_planes() failed\n");
>  			goto fail;
> +		}
>  
>  		if (dm_old_crtc_state->dsc_force_changed)
>  			new_crtc_state->mode_changed = true;
> @@ -10851,6 +10862,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>  
>  			if (IS_ERR(new_plane_state)) {
>  				ret = PTR_ERR(new_plane_state);
> +				DRM_DEBUG_DRIVER("new_plane_state is BAD\n");
>  				goto fail;
>  			}
>  		}
> @@ -10863,8 +10875,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>  					    new_plane_state,
>  					    false,
>  					    &lock_and_validation_needed);
> -		if (ret)
> +		if (ret) {
> +			DRM_DEBUG_DRIVER("dm_update_plane_state() failed\n");
>  			goto fail;
> +		}
>  	}
>  
>  	/* Disable all crtcs which require disable */
> @@ -10874,8 +10888,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>  					   new_crtc_state,
>  					   false,
>  					   &lock_and_validation_needed);
> -		if (ret)
> +		if (ret) {
> +			DRM_DEBUG_DRIVER("DISABLE: dm_update_crtc_state() failed\n");
>  			goto fail;
> +		}
>  	}
>  
>  	/* Enable all crtcs which require enable */
> @@ -10885,8 +10901,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>  					   new_crtc_state,
>  					   true,
>  					   &lock_and_validation_needed);
> -		if (ret)
> +		if (ret) {
> +			DRM_DEBUG_DRIVER("ENABLE: dm_update_crtc_state() failed\n");
>  			goto fail;
> +		}
>  	}
>  
>  	/* Add new/modified planes */
> @@ -10896,20 +10914,26 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>  					    new_plane_state,
>  					    true,
>  					    &lock_and_validation_needed);
> -		if (ret)
> +		if (ret) {
> +			DRM_DEBUG_DRIVER("dm_update_plane_state() failed\n");
>  			goto fail;
> +		}
>  	}
>  
>  	/* Run this here since we want to validate the streams we created */
>  	ret = drm_atomic_helper_check_planes(dev, state);
> -	if (ret)
> +	if (ret) {
> +		DRM_DEBUG_DRIVER("drm_atomic_helper_check_planes() failed\n");
>  		goto fail;
> +	}
>  
>  	/* Check cursor planes scaling */
>  	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
>  		ret = dm_check_crtc_cursor(state, crtc, new_crtc_state);
> -		if (ret)
> +		if (ret) {
> +			DRM_DEBUG_DRIVER("dm_check_crtc_cursor() failed\n");
>  			goto fail;
> +		}
>  	}
>  
>  	if (state->legacy_cursor_update) {
> @@ -10996,20 +11020,28 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>  	 */
>  	if (lock_and_validation_needed) {
>  		ret = dm_atomic_get_state(state, &dm_state);
> -		if (ret)
> +		if (ret) {
> +			DRM_DEBUG_DRIVER("dm_atomic_get_state() failed\n");
>  			goto fail;
> +		}
>  
>  		ret = do_aquire_global_lock(dev, state);
> -		if (ret)
> +		if (ret) {
> +			DRM_DEBUG_DRIVER("do_aquire_global_lock() failed\n");
>  			goto fail;
> +		}
>  
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
> -		if (!compute_mst_dsc_configs_for_state(state, dm_state->context, vars))
> +		if (!compute_mst_dsc_configs_for_state(state, dm_state->context, vars)) {
> +			DRM_DEBUG_DRIVER("compute_mst_dsc_configs_for_state() failed\n");
>  			goto fail;
> +		}
>  
>  		ret = dm_update_mst_vcpi_slots_for_dsc(state, dm_state->context, vars);
> -		if (ret)
> +		if (ret) {
> +			DRM_DEBUG_DRIVER("dm_update_mst_vcpi_slots_for_dsc() failed\n");
>  			goto fail;
> +		}
>  #endif
>  
>  		/*
> @@ -11019,12 +11051,13 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>  		 * to get stuck in an infinite loop and hang eventually.
>  		 */
>  		ret = drm_dp_mst_atomic_check(state);
> -		if (ret)
> +		if (ret) {
> +			DRM_DEBUG_DRIVER("drm_dp_mst_atomic_check() failed\n");
>  			goto fail;
> +		}
>  		status = dc_validate_global_state(dc, dm_state->context, false);
>  		if (status != DC_OK) {
> -			drm_dbg_atomic(dev,
> -				       "DC global validation failure: %s (%d)",
> +			DRM_DEBUG_DRIVER("DC global validation failure: %s (%d)",
>  				       dc_status_to_str(status), status);
>  			ret = -EINVAL;
>  			goto fail;
> 


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CDDC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 11:26:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2650112FF9;
	Tue, 11 Jan 2022 11:26:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE59F112FF9
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 11:26:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0s7T+9K1JVOi4dJs1lKOYGnxHcG8PKgsxvLfHC6Y7WKGmQCHJtOHApcRJuzCLp9OYkUn5hnvfeBk4tSwZzY+zvS/I0bBgkdvvf789qNJ6eVLonUsljA48wGdL45rJ58grUDKm8qYNkWUnA70LCXXFLtGQS5HabSESPrmzAh4f+uB+tl6mXwAveRlTR4tBzCEa1krgkYGyXhbQTyjAwpxhpYxURN37tDdiFvFUigjPD7dzIy57ropQV8itr0SPM1FU3F3F6t59fBZU1jsB8tCUV2JvGJpwF5sL8OmkihEHifmv/xWHV16YK/1D9HW7zKn7OhnlUK5ig5VF4J4qfZ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpk4m5gpbmtCblkhsqCW5v2o314IfvD2c2vGRNFPe7M=;
 b=FfjX4gsQrcKhTBzj3N9xYg4LjenwhW2UBRXgrAsLMjZBi3QlrRE1lwwi6FWEDtqnVLPni6uQmQsTfqM2UTTQ9XmTKAajNFpETg75UmNSrhkRVEZk3VbtSvhX9cki46NiEFHmPxXFzrbw/GCmrFglBHXiSQfCSoY8NCdIBXPgCUBE+tb0FyF7+VAbzGHOCDfTG7bmnaymgeYQCDHWqtsHg/v7Olc0mCsabtHcsQWJPEVrXj5iajLevvVdOmZsz6C5odYI17+ukGRAjy9/DS0YXpgEAmgIReMujZ+bYRAyIyRbMRD1z53DMvIEPXYmAYyNEEtTMYp+fXIgdy53tIOSnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpk4m5gpbmtCblkhsqCW5v2o314IfvD2c2vGRNFPe7M=;
 b=PFrjAp1vRX2qje82SPJ2DH8F7E1UGlnhddGXXsVgTpwRm8Xoy3QC09sM1NiSuF4NX1FqagzM67UcwhFZaN0GRxSxvoA862Qhu1bwj0obUt6Xu+Aam6qEm065tpIRWL//U3XMoli8XiRLL7BdVQBJVcMUt/3qPHiDr3pkUXGRJZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MW3PR12MB4458.namprd12.prod.outlook.com
 (2603:10b6:303:5d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 11:26:07 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::b4d6:f148:3798:6246%7]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 11:26:07 +0000
Subject: Re: [PATCH 3/3] drm/amdgpu: add AMDGPURESET uevent on AMD GPU reset
To: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220111071219.5638-1-Amaranath.Somalapuram@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1b35f6db-d101-519f-aac9-f30380fbcb34@amd.com>
Date: Tue, 11 Jan 2022 12:26:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220111071219.5638-1-Amaranath.Somalapuram@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0005.eurprd04.prod.outlook.com
 (2603:10a6:208:122::18) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cf478d1-8493-41e5-9b10-08d9d4f52941
X-MS-TrafficTypeDiagnostic: MW3PR12MB4458:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB44582FBEA4C240AE7C50486183519@MW3PR12MB4458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fgWhG8f6BYXMLLqBBvrqGTV68wMXpayY+UhPuQ1n9ZebtSSPy3zkyJUeyMCpjIRZ2N5Rwpmo8DceWObC73YqWzBen4OhLpUumMr9RsVfymGH+RXspGbgOrObYEcELVtrG6fP0EqDVR8ecyEpB0RQYN3AHWOvV/P+Zf9NThWK2WO5UQnZYm++d6Mh1ppbBtDC/8s0MEUryGciqAVa/ap8rjLtN4dEEQGVQ+mopnk3RyWTqI03k+E77SEeb8h477FSVWjXKpbdSIqoWJ0BOD/LEuWYg+FVlM91aPVuSzyGfFgaxXTeOrC9tOJEYswWUTJ29OB2oUIM2DlUr0MDnbbea86pYnDZh8vbfX6MHt0Pb5RMLvHCkIGviQ5KNFQipGvnVMW2btqYL/KFIiAqBSduP0mLr1z0IH6CsRRyH7ZFCONp09MIUAuP4l7P+hSLkiYZsaawfTdSQQ1j5U49Tzg9DlsyZwm1YuQWFRSuobKvyTs48XO1sPYRX6bOHTCue+IjjFNsPcHQX7jW+PsOgGNUdhxgIBzVyLJzDlbvpayHTs1mDkg2DRCexyDSQ6VzHZ1U/L4ROYHwiCN4n4MYmh49m6DFvtFlrO3SNzZTCDw/TbjQ2EOyODusUSfXalqOR+z/moUbyOdVPHefgmaepNJgHyvuE3ntmwgfWEI4/8Ev5SbyZex8IcT/e/DvxEH1tuqvYQo18h85e7lB9F+OO3vQonWkeh8LAAhVNkJH2tR7KqOKeGmjh/sCiinFHQM0YdQV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(508600001)(4326008)(31696002)(86362001)(36756003)(2906002)(8936002)(38100700002)(31686004)(2616005)(66556008)(6506007)(186003)(5660300002)(8676002)(6486002)(26005)(316002)(6666004)(66946007)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2Q0QkVlTjdZMnpxelVLeGR0TDlqcUJReGU0MFVZV0ZRNUx1Z0ZZUDdiZEF2?=
 =?utf-8?B?ZmRwZzBhOWxCNTNiRjhLQlpPT0NOM3dNaFJta3FxQlBmZE9qdWZSVUJ6Y2Fl?=
 =?utf-8?B?NHQzTjRyN0JQckNMRWo2K29td0ZYbzdXMXdMamJXTVhjY0g1VlNmMDllaEMz?=
 =?utf-8?B?bGROeUdrTHNUdm1lUXg0L1B0ekt3cFNyck1YMGkycS82UjAzbGZpMUx2eG1o?=
 =?utf-8?B?UldBNFlnSHBLdTMxaS9lbFFTM2JoZStQMSt2ZDQ4aStWYk5oeGhYRDkzc0tt?=
 =?utf-8?B?UjRYeXV2RmttOUpSTEMrTVdLUkpacWdEM0FQQ0ROekFVdzlvMmdlTTRRbkgy?=
 =?utf-8?B?d2FPTUJ0KzcrU0VNTFcvdVZDRkxXWEVIUVphekZrMU9aemNVY3VUQ1AxblRs?=
 =?utf-8?B?SEg4Q2hSejF6bDdNU0kxTFVHOUVXb3piYms2d3ZKN2dYWjRTSjUwcFlHU3I2?=
 =?utf-8?B?UXc2UjExMzhOdGJLVGxDcyt3WFQwaFRtZUJaYi9WN1Azd29KeGZ5VTloSHJp?=
 =?utf-8?B?ck5DYzBWWDhqcUJnUElWQytwdTk1a0MxQVpYZzdIdnhWSkJ6NFg3Ti9COERu?=
 =?utf-8?B?WlFTOC8zRU8xZU1MK1RXTC9RcFp6TnkxTVVpeWZkUXdBUzdZMkdsNE92Rmk0?=
 =?utf-8?B?SHMwUEZpajJPRnQ4TWUxNkhzR2F0UlpIM3RZNnBxSFZxaEtlMXBmYkZLZ1hj?=
 =?utf-8?B?YjlHYTI5Y2pRUHkwN3l2WFBYelRERGVaSmxsanlhSjhrNExzUENQalhzelFX?=
 =?utf-8?B?a1BWVDQyV3REVFkwTVhTN1h6RmpvWTN1cGtNZjUyeHQ3VUl3aXJRR0dmaGJK?=
 =?utf-8?B?OU1IRUwxYjNueVJjb3c5U2Fqdnp1dGZVUEpUbzlndlFlc0FjK2x6cUJnTFh2?=
 =?utf-8?B?RzdyOGpnWGUyZWN5TUduL0NOYlB2L29IdU00aVU4TjFHQ2xPZURKMEFpK3Zs?=
 =?utf-8?B?aFpHcit2UW1LV2kvMDl5WWVYWWJCeERpMVNuUE8rSURJbUN5RGp3WjVxakN3?=
 =?utf-8?B?UkVVeG5VQUhrbVkrS0laMGhVSS90REdMMVdkRGMxNm1wdFlYd1p6emQybzh4?=
 =?utf-8?B?YjlmalozdTVUSDQrMDUwN1crYVZTMTNhVG1wWUlSdlNHZjIrL01KUzI1L2F2?=
 =?utf-8?B?anBFdTF0akVGeFl3LzFlWVFJNUpWNzJ5bGhDSVkxOWRRZmwvWTNOZHVJaU4y?=
 =?utf-8?B?RWlyZUF2Vi9pYm9OWExHblo3RVJSN05CaGt0S1g4VS84WVVFVXNuR1R2UFB4?=
 =?utf-8?B?VjB2NE1hK3hPRHNuSGhjdEcxZEZDZWZhY2ZRS2MxWVd0enJCUWgyVWJwamRI?=
 =?utf-8?B?cnhWYnRYTkIyNlV2Y2IxeitEaXczblRZRmIrU3hBT29BckFJN0FSWjdVNmVF?=
 =?utf-8?B?VGtQSnZDTVIrMWc1SFp6RGs4NHVSY3JFWmRLYWh2ZW5sRHBUbUczQ3VvRDV2?=
 =?utf-8?B?UXBhdkJ3Mmd6eDlvdEZiR1BOWVVhajNrUnM3ajgvTlpoM2lHcWN1bmwxbC95?=
 =?utf-8?B?VlZHNkhaVEdBOGNVSmZKVHpldmhSWi9Na1U4Wkg3ZUFsTVpmMmVrQ1hnajN0?=
 =?utf-8?B?UC9SRklIdmV1VktJMVh5TWRSMTF2cFQ4bjhzY2ExU2ZBSHJyOTg1RlZnaE50?=
 =?utf-8?B?S0dIcFJkemE3cGtGaWdmZ2pyQW83bzA2U29ReGd4SXdHbjN1NWhkemFLZ0t2?=
 =?utf-8?B?VGNkRG8rRm1Ud1FqWWlDRmNzNytwaUxkRXk5OENDRm01aW1PU3Y1RGVpOEpC?=
 =?utf-8?B?MDE2Uys3Q3VSM3IxWXV0RnM2YythYXhZYnJ4MWpFNC9wUzJFUm05K0Nyc2Qx?=
 =?utf-8?B?UUIyWXFjV3kxcmx6WmV3MGlCNFdJY09iVzQvSmQ4RUU3NzVBdjFIYVluUGVm?=
 =?utf-8?B?Mko0K0VZeFJFS3paQUZZVTh3S2hjVWthcUZabGVMZlg0cEV6M3g5N1labXNC?=
 =?utf-8?B?WkpMREtxQTY1aytHU3RqVFhqQmFPbHJDUXVTQ2xZSGNpclovM3hLaWVESS82?=
 =?utf-8?B?eDhmV3ZSNTVKWmY1VEFWUVJIejVScTlrNXVmdWRDTG5SR2Q0NngrZjViaFhL?=
 =?utf-8?B?N3c0dVJFaEdYeHU1QkVMdTgzVHB4UHpTOVFqb0xZRFpuZEdYT0JkM0RHTTFP?=
 =?utf-8?Q?f6cE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf478d1-8493-41e5-9b10-08d9d4f52941
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 11:26:07.5439 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IlGdFDeUPuHFw6nwmRShh2eT1DmeykAx8+NYOm6BeTQG0mTZSWiOn4ID9i53wsqp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4458
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 11.01.22 um 08:12 schrieb Somalapuram Amaranath:
> AMDGPURESET uevent added to notify userspace,
> collect dump_stack and amdgpu_reset_reg_dumps
>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/nv.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 2ec1ffb36b1f..41a2c37e825f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -529,10 +529,41 @@ nv_asic_reset_method(struct amdgpu_device *adev)
>   	}
>   }
>   
> +/**
> + * drm_sysfs_reset_event - generate a DRM uevent
> + * @dev: DRM device
> + *
> + * Send a uevent for the DRM device specified by @dev.  Currently we only
> + * set AMDGPURESET=1 in the uevent environment, but this could be expanded to
> + * deal with other types of events.
> + *
> + * Any new uapi should be using the drm_sysfs_connector_status_event()
> + * for uevents on connector status change.
> + */
> +void drm_sysfs_reset_event(struct drm_device *dev)
> +{
> +	char *event_string = "AMDGPURESET=1";
> +	char *envp[2] = { event_string, NULL };
> +
> +	kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);

That won't work like this.

kobject_uevent_env() needs to allocate memory to send the event to 
userspace and that is not allowed while we do an reset. The Intel guys 
felt into the same trap already.

What we could maybe do is to teach kobject_uevent_env() gfp flags and 
make all allocations from the atomic pool.

Regards,
Christian.

> +}
> +
> +void amdgpu_reset_dumps(struct amdgpu_device *adev)
> +{
> +	struct drm_device *ddev = adev_to_drm(adev);
> +	/* original raven doesn't have full asic reset */
> +	if ((adev->apu_flags & AMD_APU_IS_RAVEN) &&
> +		!(adev->apu_flags & AMD_APU_IS_RAVEN2))
> +		return;
> +	drm_sysfs_reset_event(ddev);
> +	dump_stack();
> +}
> +
>   static int nv_asic_reset(struct amdgpu_device *adev)
>   {
>   	int ret = 0;
>   
> +	amdgpu_reset_dumps(adev);
>   	switch (nv_asic_reset_method(adev)) {
>   	case AMD_RESET_METHOD_PCI:
>   		dev_info(adev->dev, "PCI reset\n");


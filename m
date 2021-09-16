Return-Path: <SRS0=YYL8=OG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A441C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 08:21:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A2D6113E
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Sep 2021 08:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 17A2D6113E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEAA36EAD4;
	Thu, 16 Sep 2021 08:21:03 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35C116EAD4
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Sep 2021 08:21:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbrrgVf8vP+7jV7JO0N44OP3sMKh5nRbXKT3/Mu2mnEtno3TFxF9rm71iaMW2vTJFSAd8E2F1adXqDAzwS6tN15YhVCBjhcsIX8VxJWkttUx4eGI9JpJimY7zo8tDOOYICE79mwADV7JV8x7COLRv/xyu48uAztUg6Dcwsm3CSAFMixtUzQHfLwXpHqWigMG5VzMiagx48zcwxo0kpVzmMnosPBJw4ZaKKN2ZPx0bTsPY+Mk7sSo7b+TDxI3hMjA/6Ysb6LIbWfwHh5+eIo9irozVwYEGVkoQRyAEBVyvXD0ggjCmNOdjNXvIFRJCFLX3btDkgaC8h1N+I3UaBlALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=3HNZX4YET1OmaKKDKZM2VG5ZxRwynANAODRSjzaKbf8=;
 b=Wojv37ozBi9Ol2UUT4exYAdd/V8VIxSa5EqhApLh6qf/p9uLf/KoChs4N1WgUXj7qlCF23Dedw3rrzxKCy9VEDaIRqxpLJCE32CTgdIRSJ6eCwkS2KVWwDrBCfyipG8W1P+9q5gbecWZIe4VanzyCQxcBck2UJ1XisJn1ibqOTuLN3AiLqvj/mJVU2lP5/RNvvUEr++wNOhbriBPg6hDwcc9yGoCGYydBnaij4VmTz4ZGoZNza+lYA8xlIWciA4gPJwKtUU5NFkWAIsXdMrniULHXg3jhayVehExiBDCdgH/EtFiHmcddUotW+rA37PITQC/weUrHzYC/sRl1FdZZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HNZX4YET1OmaKKDKZM2VG5ZxRwynANAODRSjzaKbf8=;
 b=1Q8XvhXdJ8aGWluBbb4s/CFvvIdGvTWmpplWMc6t9KfABJS++mkpqCCMmnEYJBHno9JTuABzep2BLl1KwA3Tpwdi8gGKFcQzgKgsq2cY8EKisxoEqXp6ya38d2rH7wvDz315ostrCzJgba0w6JaF5e5LA1YRdF9/wvXPtYqptMs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5346.namprd12.prod.outlook.com (2603:10b6:610:d5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 16 Sep
 2021 08:21:01 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::a9b4:b52:63:7fc1]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::a9b4:b52:63:7fc1%9]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 08:21:01 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix crash on device remove/driver unload
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: evan.quan@amd.com, xinhui.pan@amd.com, alexander.deucher@amd.com
References: <20210915194153.455140-1-andrey.grodzovsky@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <e5f543f5-f2c3-294a-59f1-4c5ca99233ee@amd.com>
Date: Thu, 16 Sep 2021 13:50:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210915194153.455140-1-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::25) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
Received: from [172.31.157.114] (165.204.158.249) by
 PN1PR0101CA0015.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Thu, 16 Sep 2021 08:20:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bcffea3-42f6-4b6b-f638-08d978eaeadd
X-MS-TrafficTypeDiagnostic: CH0PR12MB5346:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB534656D6CA08D6EA0B80057B97DC9@CH0PR12MB5346.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vFF0LrEmiTeUSRH+IOWVQheH2AHfR+dtNYzJxdsCS+tSc2xKEVYNEX68ZcMOPVE1iS3VP1Splpt7Ewi0CzLJEMS5JTpmkidkSITCGGLCvEL/UsRgJUPOWfvSRybcPJ8I396SEcS9c19x6tIh2ewo20tm0keP0LW1jQC2NcJeKap5HExQ0jH6sG11ET+pHneu9Rb14KiXb2C9qRz3aidKvy+pkUcvrwLxjcpdkQFVeBQ+5Lb8jWWdf3kyzNDR55Eqcmna0KpWtHJAclpEpwiOaSioImjvr2HHEbs/SglBTp7xVaJa4cK0xu7Njs23XD5YFP6fCsEkpPq0/lVGoNn/POoLBqNpBg51g8yhBSRxhXG4d1vXwPf/zMD/9X1kvT7OpIzjmVamTfJYL4g755Kjj/uhghG/9hVIVlx03BZyNQ7b5931SX6X3nLdhDe8P8JYRjE04El/aKDQuCjA/KacP2USy2K8/o7kJckqlxiBO2lOpNPxQXtHa+fbZkxN8TBDLNqyzcrpOqsroA/hxCPChJN6JFtEIBSQHczYY92Q5wvRF4ELgmaOF1Jyy+za1RAF+5n6R0K1QGb12mnhyr/SCLgMCk8ccNm4CfBHHwm0XTepDKAjaElCh4uSukjN1R1U9kbAhCRctv6Tc36WMYHErgd8SK8kUp0BngPouKCN8JQVtlQNvEEXJQusZNUJl61WykWiVhID6znLVnmMPguf9ZP3V10WWOT9lbZYpAiLfS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(478600001)(53546011)(316002)(8676002)(31686004)(8936002)(2906002)(38100700002)(16576012)(4326008)(5660300002)(6486002)(66556008)(66476007)(36756003)(6666004)(66946007)(2616005)(956004)(31696002)(30864003)(26005)(186003)(86362001)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tmx6RWxGZUlaSTR5by8zVlB2RTNUa2dNM2pSNG9QenZEN1EzejFCMGlGQjBn?=
 =?utf-8?B?SVFvZk8zZE1zSVZBb0hndDFlWVBLR2tyK245eldWWUtway9zVERrdU9nQW9G?=
 =?utf-8?B?Q0plVVdiT2NsaE5sQjFjemN3cCtDajNqSzMwbG9ocWN2TmJkeE04ZTNYcm5j?=
 =?utf-8?B?OUhOOXo1eHkxalB5dlQ1a2hpUE1kNWQ2RG82WWZaWHd0WU5QYkJRbVI2VlpS?=
 =?utf-8?B?eVhmRUJEdjR4K3BGTEtoYzhPM21qZTRoYlAxTytsWUZ5aHkyK2lCNWVXSDhV?=
 =?utf-8?B?TnlsQXNmVnBZczFpUzhHdkJuN2cwOGhELzUrRzlDUy9sNVBXN09hSHV6TVVT?=
 =?utf-8?B?c1p5SDdYMzdsclBMSUJ2TGFHbDFxWkpiYUh6MjNzeDZRZXhkN2tNV0MwSzBp?=
 =?utf-8?B?YjlXemlYVnZYRUdNY1p0TTEzbVhnd3RFT01US2xnMkJDaW5PUkdKNTBqMWJ6?=
 =?utf-8?B?OWdvbmdCVjIrM0poejd3S0JzYUVDdUlZc0RjNWIzYjlkeTQrV0Y1ckFkUUxF?=
 =?utf-8?B?THQyOEd6NHViVkVjVGJ2emdIaG5RT2o2amNnaDVOZWR0NUxRMlUvSHUyYU9I?=
 =?utf-8?B?elcyTWI3NDRzb3JxYTRHZGJTYVBmbGI0NXdBTWpOd1ptYUxROThKb21nM3Fy?=
 =?utf-8?B?OC9jQ3dPY1QyVUo1QjdJZjVPM09rZ2JTN3BjaFRoVTdCYWdiUkdnTE8wdzR3?=
 =?utf-8?B?Z1lHdTYxWUNxN1Q4bVovNG5uVTJHM0VwK1V1T1AveGhNVEc4UTkzQTBOTlVP?=
 =?utf-8?B?S3NPczBWMnd6WXhUOHBwUVZFS2lZQ3U4YmtaOGt3NVF5N2RHbjBnZlFDNDhD?=
 =?utf-8?B?YmhlWVZVR0ZFcE83Zmg3NmxWVTNPeVdVWUZyU0R6MWdlNy8vVGZCNkJKbXEw?=
 =?utf-8?B?cHo5Y0VjTlBibitvaTM2RnRxVjgydDUxSTZRaG5WT3cybmJybGRucGZYNnhG?=
 =?utf-8?B?YU9QdTdpc3lIRGFnYjk1bE51VWR4Nk5qRjlmVlhBVFNvL0pJcWFYUkUwOFJ6?=
 =?utf-8?B?dDFCZW84U2RZRko0MTZka0oydFdXRlRxclUzV1pPbUZjcVpWMi9GT2MwcnQr?=
 =?utf-8?B?L3ZZdkZzQnNId2sxNFhMOFVEV1d4OSt4akxodDlBU2FXUFBrSmdwczljSW1x?=
 =?utf-8?B?UzZzN3VIZ1RONVhQYWtGS2dhLy9pSWo1NkdpY2trQXg4ekpHbTRmc1VUTWJ5?=
 =?utf-8?B?MXczNyt5cUJuY09INGdhb2dSRHZUWlNRSURIVkl6WjBDVDZna3ArekJUSGZF?=
 =?utf-8?B?blhETEZHRWE0Ym84aGhnSjJPaTE3dkZpckxrUDVDV3RDeUovMmJJSjZYanZq?=
 =?utf-8?B?K09Kay9TaHNhVk4vYlIybXVvRVJFTW5FYjU3RG9oWk1pQ0xvWUJFbXdJc3I1?=
 =?utf-8?B?b2hYVUNWOFVXcldZTHZMRklDWDU3Z3Y5bFNCaVhQOUxHTDNjekI1clcrdFRD?=
 =?utf-8?B?RXhsdFJNeitpcjBvZ1lHcFBVS1RaZ2FPQThKaUZubE8wQmk0M1NBN3R0Z2E4?=
 =?utf-8?B?RGpDWXFXbVFMNnJrMWV6eHdvei9GVmdybVYxcFczblZzK3lWYUhGTXltUTlY?=
 =?utf-8?B?MFo5aWJVbXR2N0xrd09GZE4zWVY2TnI4MXRNUlhnQTVVUXdqVnBEQ2ZlNzBp?=
 =?utf-8?B?N0Z0My8zcUpITTVvOWo0cFdHTmtwRi9uM09nRkhoMU5CVGwzNzZUWHlMUnE4?=
 =?utf-8?B?QjV1S0NmYys2K05UTE1xaGtlUUtNd0dDamk5SVB5K3VTa0pzc3M0WVFUa0ht?=
 =?utf-8?Q?WBjpejHx1cp3K6R+28cS+W7bTK7TjYNWkHm0Xe6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bcffea3-42f6-4b6b-f638-08d978eaeadd
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 08:21:00.9473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmaqVFDO3swJsinCzF46/r59eFawcCyDxbFV1Gih8VZYk1E8sFmNgbdASLSopSJG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5346
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

A minor comment below.

On 9/16/2021 1:11 AM, Andrey Grodzovsky wrote:
> Crash:
> BUG: unable to handle page fault for address: 00000000000010e1
> RIP: 0010:vega10_power_gate_vce+0x26/0x50 [amdgpu]
> Call Trace:
> pp_set_powergating_by_smu+0x16a/0x2b0 [amdgpu]
> amdgpu_dpm_set_powergating_by_smu+0x92/0xf0 [amdgpu]
> amdgpu_dpm_enable_vce+0x2e/0xc0 [amdgpu]
> vce_v4_0_hw_fini+0x95/0xa0 [amdgpu]
> amdgpu_device_fini_hw+0x232/0x30d [amdgpu]
> amdgpu_driver_unload_kms+0x5c/0x80 [amdgpu]
> amdgpu_pci_remove+0x27/0x40 [amdgpu]
> pci_device_remove+0x3e/0xb0
> device_release_driver_internal+0x103/0x1d0
> device_release_driver+0x12/0x20
> pci_stop_bus_device+0x79/0xa0
> pci_stop_and_remove_bus_device_locked+0x1b/0x30
> remove_store+0x7b/0x90
> dev_attr_store+0x17/0x30
> sysfs_kf_write+0x4b/0x60
> kernfs_fop_write_iter+0x151/0x1e0
> 
> Why:
> VCE/UVD had dependency on SMC block for their suspend but
> SMC block is the first to do HW fini due to some constraints
> 
> How:
> Since the original patch was dealing with suspend issues
> move the SMC block dependency back into suspend hooks as
> was done in V1 of the original patches.
> Keep flushing idle work both in suspend and HW fini seuqnces
> since it's essential in both cases.
> 
> Fixes:
> 2178d3c189b9 drm/amdgpu: add missing cleanups for more ASICs on UVD/VCE suspend
> ee6679aaa61c drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE on suspend
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c | 24 ++++++++-------
>   drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c | 24 ++++++++-------
>   drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c | 24 ++++++++-------
>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 32 ++++++++++---------
>   drivers/gpu/drm/amd/amdgpu/vce_v2_0.c | 19 +++++++-----
>   drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 28 +++++++++--------
>   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c | 44 ++++++++++++++-------------
>   7 files changed, 105 insertions(+), 90 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> index 7232241e3bfb..0fef925b6602 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
> @@ -698,6 +698,19 @@ static int uvd_v3_1_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	cancel_delayed_work_sync(&adev->uvd.idle_work);
> +
> +	if (RREG32(mmUVD_STATUS) != 0)
> +		uvd_v3_1_stop(adev);
> +
> +	return 0;
> +}
> +
> +static int uvd_v3_1_suspend(void *handle)
> +{
> +	int r;
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
>   	/*
>   	 * Proper cleanups before halting the HW engine:
>   	 *   - cancel the delayed idle work
> @@ -722,17 +735,6 @@ static int uvd_v3_1_hw_fini(void *handle)
>   						       AMD_CG_STATE_GATE);
>   	}
>   
> -	if (RREG32(mmUVD_STATUS) != 0)
> -		uvd_v3_1_stop(adev);
> -
> -	return 0;
> -}
> -
> -static int uvd_v3_1_suspend(void *handle)
> -{
> -	int r;
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -
>   	r = uvd_v3_1_hw_fini(adev);

"cosmetic change" comment - hw_fini is supposed to be the final tear 
down call. So instead of suspend calling hw_fini, perhaps it makes sense 
to read the other way - hw_fini just suspends the hardware?

Thanks,
Lijo

>   	if (r)
>   		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> index 52d6de969f46..c108b8381795 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
> @@ -212,6 +212,19 @@ static int uvd_v4_2_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	cancel_delayed_work_sync(&adev->uvd.idle_work);
> +
> +	if (RREG32(mmUVD_STATUS) != 0)
> +		uvd_v4_2_stop(adev);
> +
> +	return 0;
> +}
> +
> +static int uvd_v4_2_suspend(void *handle)
> +{
> +	int r;
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
>   	/*
>   	 * Proper cleanups before halting the HW engine:
>   	 *   - cancel the delayed idle work
> @@ -236,17 +249,6 @@ static int uvd_v4_2_hw_fini(void *handle)
>   						       AMD_CG_STATE_GATE);
>   	}
>   
> -	if (RREG32(mmUVD_STATUS) != 0)
> -		uvd_v4_2_stop(adev);
> -
> -	return 0;
> -}
> -
> -static int uvd_v4_2_suspend(void *handle)
> -{
> -	int r;
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -
>   	r = uvd_v4_2_hw_fini(adev);
>   	if (r)
>   		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> index db6d06758e4d..563493d1f830 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
> @@ -210,6 +210,19 @@ static int uvd_v5_0_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	cancel_delayed_work_sync(&adev->uvd.idle_work);
> +
> +	if (RREG32(mmUVD_STATUS) != 0)
> +		uvd_v5_0_stop(adev);
> +
> +	return 0;
> +}
> +
> +static int uvd_v5_0_suspend(void *handle)
> +{
> +	int r;
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
>   	/*
>   	 * Proper cleanups before halting the HW engine:
>   	 *   - cancel the delayed idle work
> @@ -234,17 +247,6 @@ static int uvd_v5_0_hw_fini(void *handle)
>   						       AMD_CG_STATE_GATE);
>   	}
>   
> -	if (RREG32(mmUVD_STATUS) != 0)
> -		uvd_v5_0_stop(adev);
> -
> -	return 0;
> -}
> -
> -static int uvd_v5_0_suspend(void *handle)
> -{
> -	int r;
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -
>   	r = uvd_v5_0_hw_fini(adev);
>   	if (r)
>   		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> index b6e82d75561f..1fd9ca21a091 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -606,6 +606,23 @@ static int uvd_v7_0_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	cancel_delayed_work_sync(&adev->uvd.idle_work);
> +
> +	if (!amdgpu_sriov_vf(adev))
> +		uvd_v7_0_stop(adev);
> +	else {
> +		/* full access mode, so don't touch any UVD register */
> +		DRM_DEBUG("For SRIOV client, shouldn't do anything.\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int uvd_v7_0_suspend(void *handle)
> +{
> +	int r;
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
>   	/*
>   	 * Proper cleanups before halting the HW engine:
>   	 *   - cancel the delayed idle work
> @@ -630,21 +647,6 @@ static int uvd_v7_0_hw_fini(void *handle)
>   						       AMD_CG_STATE_GATE);
>   	}
>   
> -	if (!amdgpu_sriov_vf(adev))
> -		uvd_v7_0_stop(adev);
> -	else {
> -		/* full access mode, so don't touch any UVD register */
> -		DRM_DEBUG("For SRIOV client, shouldn't do anything.\n");
> -	}
> -
> -	return 0;
> -}
> -
> -static int uvd_v7_0_suspend(void *handle)
> -{
> -	int r;
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -
>   	r = uvd_v7_0_hw_fini(adev);
>   	if (r)
>   		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> index 84e488f189f5..67eb01fef789 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
> @@ -481,6 +481,17 @@ static int vce_v2_0_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	cancel_delayed_work_sync(&adev->vce.idle_work);
> +
> +	return 0;
> +}
> +
> +static int vce_v2_0_suspend(void *handle)
> +{
> +	int r;
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
> +
>   	/*
>   	 * Proper cleanups before halting the HW engine:
>   	 *   - cancel the delayed idle work
> @@ -504,14 +515,6 @@ static int vce_v2_0_hw_fini(void *handle)
>   						       AMD_CG_STATE_GATE);
>   	}
>   
> -	return 0;
> -}
> -
> -static int vce_v2_0_suspend(void *handle)
> -{
> -	int r;
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -
>   	r = vce_v2_0_hw_fini(adev);
>   	if (r)
>   		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index 2a18c1e089fd..142e291983b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -492,6 +492,21 @@ static int vce_v3_0_hw_fini(void *handle)
>   	int r;
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> +	cancel_delayed_work_sync(&adev->vce.idle_work);
> +
> +	r = vce_v3_0_wait_for_idle(handle);
> +	if (r)
> +		return r;
> +
> +	vce_v3_0_stop(adev);
> +	return vce_v3_0_set_clockgating_state(adev, AMD_CG_STATE_GATE);
> +}
> +
> +static int vce_v3_0_suspend(void *handle)
> +{
> +	int r;
> +	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +
>   	/*
>   	 * Proper cleanups before halting the HW engine:
>   	 *   - cancel the delayed idle work
> @@ -515,19 +530,6 @@ static int vce_v3_0_hw_fini(void *handle)
>   						       AMD_CG_STATE_GATE);
>   	}
>   
> -	r = vce_v3_0_wait_for_idle(handle);
> -	if (r)
> -		return r;
> -
> -	vce_v3_0_stop(adev);
> -	return vce_v3_0_set_clockgating_state(adev, AMD_CG_STATE_GATE);
> -}
> -
> -static int vce_v3_0_suspend(void *handle)
> -{
> -	int r;
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -
>   	r = vce_v3_0_hw_fini(adev);
>   	if (r)
>   		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> index 044cf9d74b85..226b79254db8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -544,29 +544,8 @@ static int vce_v4_0_hw_fini(void *handle)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>   
> -	/*
> -	 * Proper cleanups before halting the HW engine:
> -	 *   - cancel the delayed idle work
> -	 *   - enable powergating
> -	 *   - enable clockgating
> -	 *   - disable dpm
> -	 *
> -	 * TODO: to align with the VCN implementation, move the
> -	 * jobs for clockgating/powergating/dpm setting to
> -	 * ->set_powergating_state().
> -	 */
>   	cancel_delayed_work_sync(&adev->vce.idle_work);
>   
> -	if (adev->pm.dpm_enabled) {
> -		amdgpu_dpm_enable_vce(adev, false);
> -	} else {
> -		amdgpu_asic_set_vce_clocks(adev, 0, 0);
> -		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> -						       AMD_PG_STATE_GATE);
> -		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> -						       AMD_CG_STATE_GATE);
> -	}
> -
>   	if (!amdgpu_sriov_vf(adev)) {
>   		/* vce_v4_0_wait_for_idle(handle); */
>   		vce_v4_0_stop(adev);
> @@ -596,6 +575,29 @@ static int vce_v4_0_suspend(void *handle)
>   		drm_dev_exit(idx);
>   	}
>   
> +	/*
> +	 * Proper cleanups before halting the HW engine:
> +	 *   - cancel the delayed idle work
> +	 *   - enable powergating
> +	 *   - enable clockgating
> +	 *   - disable dpm
> +	 *
> +	 * TODO: to align with the VCN implementation, move the
> +	 * jobs for clockgating/powergating/dpm setting to
> +	 * ->set_powergating_state().
> +	 */
> +	cancel_delayed_work_sync(&adev->vce.idle_work);
> +
> +	if (adev->pm.dpm_enabled) {
> +		amdgpu_dpm_enable_vce(adev, false);
> +	} else {
> +		amdgpu_asic_set_vce_clocks(adev, 0, 0);
> +		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> +						       AMD_PG_STATE_GATE);
> +		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
> +						       AMD_CG_STATE_GATE);
> +	}
> +
>   	r = vce_v4_0_hw_fini(adev);
>   	if (r)
>   		return r;
> 

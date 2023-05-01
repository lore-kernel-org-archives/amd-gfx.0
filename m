Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE76EC77B61
	for <amd-gfx@archiver.kernel.org>; Mon,  1 May 2023 15:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF4EB10E080;
	Mon,  1 May 2023 15:05:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 520F910E080
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 May 2023 15:05:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+gvwRXFf+F/8xy2CCQlyEPTuD5igasEnL2KsEhhLtb9/Ewx0arD/LWCVOUXMVZN+agwPZIuaYXs3s/X5x9LT/36qB4sjxFXnvLJ0dZtUp7q43DTVZ4+fWX62h3zALBIsnpK4I/le7qWtV2A9tGIK6t7KF/LsXmaV6D5eYfcJgOd4w4MSy1/uo37/IgvrfValxM5BxyvtnCEhG4hNM1Z/ihfYo+5TRPgwc24xNasH8JtvDgpvvi6tAa7o5RifFwJLHyVsJfilVks/ZxkIFEZPd8kO00sfRr7riKeFdaZ0aDTacdS/1bzn1jaQrzbs3gjeoq9o2yK9Q2dNivB/wl5Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evSGzC8V2SaTzfQm2jM1gJvbZCn2srRwHJXBtIYYLbI=;
 b=QsDf6fjb61pbRpSD+t0Mm9fk9Uq+9PWM5ngzDA1o0m4yjG/kRi1fR4QQZgn4HUhl5qE6MD5D/raommiFgt/De2cKTXGwF4Q9uZgO0EVDqFmxKEok/gmjaY3ft26/n/dI1u/hWKL04BNlDKhExcCohBgEEiFruvc8uzmqZcICVfITfNrkiC2FJET4GnXT16GweWSVdsKHvaS7s+7jizTy6cbxiHrd52iRHI4YdrORErrWqWXv3f60gRkzQ8TwQHHonYzptcQApLNgMtigdpg0Ng1cU5W4EwDkIQUX67cV0/L4ShatuQ1tIWRgwCFVwDd8eEJ8VOF4JaTtUy4UTMYVrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evSGzC8V2SaTzfQm2jM1gJvbZCn2srRwHJXBtIYYLbI=;
 b=Vg6SAapmpqGEeGOIztqJ9SHoT8U595UF5RzxHSp264pRPNDZ8iHhmBLperTDKPynpFzhkoFhqPmM0EbwTwZgLPpDXjsQ5zPMBU2EBF1wIKWmrspyQT/g/A0JNDQWuPThtBkYd3Eb5j8YUZh8ORYdQN18hJtsFCOdvECMeQGHL6U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 15:05:03 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6340.030; Mon, 1 May 2023
 15:05:03 +0000
Message-ID: <dbb4f869-62c2-4598-d239-f08cba255099@amd.com>
Date: Mon, 1 May 2023 11:05:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: set gfx9 onwards APU atomics support to be
 true
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230430020220.1266699-1-yifan1.zhang@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230430020220.1266699-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0277.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: a71f0b3b-a0ca-4c6e-a8aa-08db4a5570fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gxp1EOsKmA44BhFZChbKGvwuZAjGCPTv+DMgzoHg8/C+lz8F9oScheyE+77GEPBc4s+rswwW4XlnUgrhzbRdrb3yFWFDq+TQa++W48lGneI+GRQDW2E5QJM7vT1KKrKlTdmEcX6Rykjcu/5CguUw2KcsvmNKq01M4uCAg0kk51XeLNI1hiwcZVyfw5Cz5AXKlCa9im0Bz/gSfOXKUaH5odXJkP2ntPY68OyBloZINW7KCOTNC2da9bZYwoslSm9iBLhnqZye3VZG1h8Gt1ZCEbr6Chb/xJjFDe6Ive3fzOSkn7SpHfz8eMFIiLMwCsbZQ/OAS+dxqGJfO1qWvxf5soTj3dwBS7ZAMpVi4T0FG5L7DT6GWjqmpe3LU6Q+GlRxROD9iu3+7CW3tnob1cCX/lUHJZDtTdsCYFDoC/peOJ/DnXPikQEoEIt24q/8eVKNAF4K5tozffD5ECExvKtcqRNT37O5FSELYE1HdMSRwVywAbNc/6TirdzAS04+0TTtA2YxXGAqGO3I2M9rNhabYMPJj4ouRQXIFb0zTH70NkFdohkiA61q518M0OSkw0dCphPj0JDIlkGZvy6hrmKyDMCcq8M1WHuaTl8c68femD6LsgV8RSNY1AEXFwjX875CcQ3agT/Ef08UwM4LMx0RVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(36756003)(4326008)(6486002)(2616005)(6506007)(26005)(186003)(6512007)(44832011)(2906002)(5660300002)(38100700002)(66946007)(66556008)(66476007)(8936002)(41300700001)(8676002)(316002)(31696002)(86362001)(478600001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V29YaWd3aDdrTFFPV1N3RW9HUmtuL0YzenhMZ3dtMFNmRklQMkxyLzM4dzZN?=
 =?utf-8?B?d0xUYjNoSEtuZmYreGxWdjRwZE9tNzNKTENodk9KL3EycjJ2aWZkemZreWtu?=
 =?utf-8?B?T1ZtK2trWDcyRlhUL0hONWhrc0VITlR6SWwwemRuRnhjTm9YTTRpTzdvMlFF?=
 =?utf-8?B?TFAvZ0hyZDkyZXlsYUdLYTJVTUlVa0ZTOW5Hc09EN0ZHZFdLSTdEZVZJQTJ6?=
 =?utf-8?B?WWhKaGdhamYzeXhlNEUzTVZIWjBSVW85K3ltOGg1ZWpETTlaK0lQckpwSC9P?=
 =?utf-8?B?M1gvWFdTcUkrRnlqS3c3MEpRU1luR0FVeWc1aFk2ZDU4RnVuV3Z5NmZ6Z2dm?=
 =?utf-8?B?U1lEVlQvNTdIVHh1QnpaU1hhL1p0ZExUL2kxSzc5OWtVS05mbmFxR3YxYlNT?=
 =?utf-8?B?VzZGQWdCUEZ0ZFgzZ2JOMlhyQkpEZmNQa1dIV3ZVUytlU3BORE5XUU8wL3Rv?=
 =?utf-8?B?eXhicjdLVWVITDFJYzh6V2FLV0NFNWJmckpFTldOWU5xSEdLaHRiekwrcWt3?=
 =?utf-8?B?eXRVZUhnRkV2QytyZFhJUk42c00xVDNlTmNyMW5SRDlwd1ZUNER6endlUi9L?=
 =?utf-8?B?dzIwL0w5WkV5TmJiSHNIQWJ1VUFqcmQyRjhJZmI3bTNobFROUUJGUGRtK1lo?=
 =?utf-8?B?MnVYanFBU1Azb1k3cTNwVTRiQW0xYU8zZjFhZ0JqVktjWDdoWFVUWS9nMURz?=
 =?utf-8?B?TjZsTmFTemZ0WUdWTkxNQS82eU1PRkFrbVBwYjdybU84eVRXdjRGQ04yWVl5?=
 =?utf-8?B?Z1NnbFBhU3Y3MmIzZlpiKy9mb0RMYitydVptSk52clQ2SDFjcjVrMHpMU3Jy?=
 =?utf-8?B?R2picTYvWTdiTG00ZENzRDM2ZzVpR0Y3bkpPYlhqbmdGMkx3TW82WTVUREdR?=
 =?utf-8?B?blQyb0IzN3FyTVJiWlVUQkQ2SFBFMDNxRlVwT3pKQnBFK1E1NGRvUW5TL0JT?=
 =?utf-8?B?RmpPVjdGU3FOblVVc1ZIaHFwTFRMVVh5S0Y1elA1K2RUWVZSNXpRbmRIc1hG?=
 =?utf-8?B?MkFYVEltU3F0ckpZeVBia25FdEo2UGVGckE0bjFwc1IxS2d2UUFSamtLTkZN?=
 =?utf-8?B?cHd5TGNIUTh4dDBIOG9NdHdTZmpuTmVFc0VZVkVsSU1OdXZCWmRmbnVmcmFR?=
 =?utf-8?B?MmZFTXdiWmlpRWhWUjEydEFTeTBFNnVHcHhlNTI3QytXdkg0WjBQYTlHVlF5?=
 =?utf-8?B?NzI2dkpyRmh5WVQ5N0NKVlI5dGY0Z0V6NDNHY2RYMWF6c3pZR0xEQmpvRWR6?=
 =?utf-8?B?cDJBUHUvd3ZmNHJQNGhXcFdhblpEMnI4TFJmeE8zK3pQWkw0UU02RElPajc5?=
 =?utf-8?B?L2p0VWU5RzhpN21YNlQ3Vm9oRlg0NGg0TDhLM3R6MHBhUUppazZRTFZNQ0VT?=
 =?utf-8?B?MWUzZVRDU2x6TFlUYzgyYUlVZDQ0MGUxbm5adTVIek1TQW55K0QrMnZoaUQ4?=
 =?utf-8?B?bFl0TVllWTFNQUxLSU1wS1RkblZ5cFM5Mi9JZ1kzOHM1OE5lcGhlZ0hCU3Vp?=
 =?utf-8?B?Ri84VjI3KzNqZzBVRlVVUjBlM2pyVnVPb3h3QlRtZ2dENVRsWk1GcnlCemhw?=
 =?utf-8?B?d3pPZTFkZGFFOG1sbXM2Zng2R2RGYTVXSTBoR0xLVjdrMy9FdkJOMFBCSXFI?=
 =?utf-8?B?eW1WbjZCdFpQSndrK1dPbHhHcnpuaGU4d1RMS0lndkVudHc2MEYySWZVaDVU?=
 =?utf-8?B?cHMvVUhNNU9pS1NHSHhHSmlFY1kwVHdKS0VlL014UHNUN09nTnBjVVJCUHJt?=
 =?utf-8?B?OHpUTEh5Zi84ZTNHckI0c2JWMm9rak9nZDhwb2xpSThSSjBVbkRsanhBYXVy?=
 =?utf-8?B?eWViUXFydCsxVUVnNFo2ZFVPMHBUbis1ZzJvdHFhNWpwWFhjbWd5Uk1NREFB?=
 =?utf-8?B?RmRrVEh1YmYvcG1IVXJwWUZMbHo5TVF2TFFqTXhZSFk4VGd5NmNqaCsrekV5?=
 =?utf-8?B?dm9UV0h6bzdWSDVVWnU4TkNsNHJlUnBtRElSdFJaU3B3NXU0NGh0cVovYXhX?=
 =?utf-8?B?ZE9tSUFsNWNmUTlEMXRETGNJTTF2eVphaVN3dmY3dlNIeXJMdjUvSi9taUZE?=
 =?utf-8?B?RThRVzdYSlVoTTlBRFUvMmE5M2NqSERKNWR6bWsvOVZLN2FwQmR2YzBzclk4?=
 =?utf-8?Q?Eu0cIM0P9dfz6hZVI9ZhtxZCS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71f0b3b-a0ca-4c6e-a8aa-08db4a5570fa
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 15:05:03.3286 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6TLvlRKPpnFmIgHV76JdWtnV1ngtFm2Yvch0CJArLUpp0epFfIu6OhpaKADOpWIUkJhS8ookCcJ/MVvrAv77XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324
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
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2023-04-29 um 22:02 schrieb Yifan Zhang:
> APUs w/ gfx9 onwards doesn't reply on PCIe atomics, rather
> it is internal path w/ native atomic support. Set have_atomics_support
> to true.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b57e7776055b..750eaffa81ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3757,6 +3757,12 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   		adev->have_atomics_support = ((struct amd_sriov_msg_pf2vf_info *)
>   			adev->virt.fw_reserve.p_pf2vf)->pcie_atomic_ops_support_flags ==
>   			(PCI_EXP_DEVCAP2_ATOMIC_COMP32 | PCI_EXP_DEVCAP2_ATOMIC_COMP64);
> +	/* APUs w/ gfx9 onwards doesn't reply on PCIe atomics, rather it is a
> +	 * internal path natively support atomics, set have_atomics_support to true.
> +	 */
> +	else if ((adev->flags & AMD_IS_APU) &&
> +		(adev->ip_versions[GC_HWIP][0] > IP_VERSION(9, 0, 0)))
> +		adev->have_atomics_support = true;
>   	else
>   		adev->have_atomics_support =
>   			!pci_enable_atomic_ops_to_root(adev->pdev,

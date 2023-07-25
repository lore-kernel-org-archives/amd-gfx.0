Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6476DC001DE
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jul 2023 14:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8E4210E3D7;
	Tue, 25 Jul 2023 14:02:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDA8510E3D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jul 2023 14:02:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TU/fVr3MWmsks94doSIQ3VoYyWGj4RTn3ud23eI9b4H7e31NNObdtJZrDLaxw02aExmLpuSinrPzaPqpD6RmKDfj/EGjV/vH4ntMhk0D2+aTT8QY7aY6H7Gk80AjRnnZgA1laxJZK80PxnL80ImbAbVCRjkpSHrQYhyawLFe4OT1vhzZxLEBgf1rW++Hj9NuUbf6f+NgaVR47P11FPhL0ON5fxBV/olFtPqZJbrPrOAU7cG9OPLlla5UftzX6Jiam9WuaCeVOFtZp9keDvgyVXj95EsfyC/oQuoPvpupTIjNKNRJfYf2vAe7e55gNba6mkgJ+gjYBRYZdB4od/2CFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7fAg2+sdDW3jpH5MYfHpprtDpZjkFwR4DY6vf2rITE=;
 b=nVjakUgoyw11mSU5neJIS6FOqyW8/e3Ix7ooctdHy75P+GpYA8mhCINNtGrqs5jrWhInCcf70qDliQLDFoNnjaSheks18uQo+ZKoTU0+TdmZP+7WT/Z76IWUWUjDWbhWCU4kYO84ktYDvSslhsgAYRKnoLrSG+c+L9zotpoFjE3JSNKR5MvpCmc8z8v21kTSgZMjOvADDdBAJ6LN/Rne8Zlj/RW2agLlCaPfoNkXrWIayqiiukB6Cq2L3ssr7sXPxupj1nowHS7WuAncE5S3ITSTFG6Ehj54kEEEBaQqRRb6qrj1je/C5OJdClq0+jejZD/f2Xp+8SZ7HLca1ZpZPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7fAg2+sdDW3jpH5MYfHpprtDpZjkFwR4DY6vf2rITE=;
 b=4PZZGBRMcyxeW67tupL/IGNFDjLvwc+PTJShWZJujsn0lqO3DaBGiwMnwWYLxuhLSLIvAvaMnCVleAq/rKLjVa/fl57ZmNd9BJhAnlYiSdWoZvONjmY2wT3FxT7CxHf8YDU/K4RoUvmd4u1i5Y/LJQV8xtNdfQHewtNOvzZGIAY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by PH7PR12MB7284.namprd12.prod.outlook.com (2603:10b6:510:20b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 14:02:30 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bd4b:829f:c0b1:bad6]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::bd4b:829f:c0b1:bad6%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 14:02:30 +0000
Message-ID: <486becb0-4056-8fff-65aa-b2c784f53acb@amd.com>
Date: Tue, 25 Jul 2023 19:32:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: Fix ENOSYS means 'invalid syscall nr' in
 amdgpu_device.c
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230723061549.2017184-1-srinivasan.shanmugam@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230723061549.2017184-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0137.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::22) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|PH7PR12MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 567f3dd2-1c66-452c-6a1f-08db8d17c8ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GwN4HegFO1VvdfgB0dKuF23Cm9CMUwNxNqu1fJN1UWiahoig0dJid8ZEDFLQQ1ugj3wufXl8nRp0r+3zNRUkesj1w3LxvBwLfKevKoyLzro3pqEy1zstmQ/ArRgXfdJ23MtZBGmitpgYep/Uqa/T5W5Kwv8uDzFjhV3n+XlBkTYDXhAMhfH6nnh01bUTx2gQOocy+22elpXlOkEIlgsxiJwJsYvDGDPtm2IMBKPRvtu9/Jlb9Zb8ctSjmJV14hHcOr8J0M2o6lmfWvmpipp5cRA7Mc44bxQ4MeHR8jfB7WV8wHuRUvdCZlUpOS0dmAINyZ/tuEPGRGj+ITb9FQB/dMJe2PjzMDIWk8AaTkbd1LKCiG9qKATFMl8lm3R9y/iSCT6ny+EnKiZadrzX2XKEVKsR7HW+O0DDik5MF9RT43Djooo/84SDB3OBgFhzwmN8AioKc8euX0MioXHMYstP1Z+eyEfiepp2vkqABraw5jJ2V5uj1pzbc4nli4AcYBAc9BrDIzEaoR84sti0wqf7wo8mEjb2B984JcRjqJgjH2qGUkDNiXkJ75c9TNya3ZvTHU0w0gqGzGq3UJgizZK0yDBiRisw5uzig8bBeDJx5Q0cHBU8WSgYQDHAhY3eJ+tvOCGGo2OtGTGXf7ReFYPseQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199021)(66574015)(30864003)(83380400001)(86362001)(6512007)(478600001)(186003)(26005)(66556008)(6506007)(66476007)(53546011)(66946007)(41300700001)(31696002)(8936002)(4326008)(6636002)(6486002)(2906002)(5660300002)(316002)(8676002)(6666004)(38100700002)(36756003)(110136005)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1JzNFRPT1BTdkxUWlV6VmN6WkFoOXozYzZUUGlKYVN6TDV0MXhHcUNCVndV?=
 =?utf-8?B?cWNENTNneVZhY0pDVmhKTU5qeTdDVHVLTkFWZUdTKzc0bVVXeldNVWF0ZW9K?=
 =?utf-8?B?aWdHTnNvQnJGckMxNHQ3RVJBUE9ZR1V0cWpXNURDQ2o4QXZDamFJZmFFYjJN?=
 =?utf-8?B?L2J4dHArWGZiS1F1NEtMeEFucjczUU14c1NUQUdnUGE1dUJnT3E0a1d5SWZS?=
 =?utf-8?B?djVYRERIUGxCbUtBS3gvV0ovM0ZmVUV1S3dodEYxdEE3eWVlOEZQanowQnNR?=
 =?utf-8?B?L0g5UGV3ZTRNUHRwUjljd3lNODc0emNWbENZbndIc3JiOWN3Y0E2ckVIMFVx?=
 =?utf-8?B?K0sweUE1VGlIbzVTMGF5Y2U5Uk5HbXF3dUxoYWZnd3lqaDNJSUcxZ0M2bjk4?=
 =?utf-8?B?cnNXTkFXTExxaklBS0hiYVRvSVc0WVU4NHFKamYydHl2aldZdFlPY1JnR053?=
 =?utf-8?B?K1gwVlJwQlVFMFM1NU9YRkNaaFV4Skp5Vm9kSTM4OTZYQ1JOUVB0RjhMeSti?=
 =?utf-8?B?UVk4ZEVJbkFKdDJ1cDlFZVdLUjhlQXp5N0NaR2o2N0VFYWFSeFJZbDQ2SFZo?=
 =?utf-8?B?OGR5Y2lVK0l1RGJCaGthdTFicDB1WUZQUTFqMTdObDBDdnIzYzAwMFlPdVhI?=
 =?utf-8?B?anZsVkV4R25HUVpHTmdWaGkvMGoveDV0OWFPbHdLdGF0OUlKS2E0cDllQTBI?=
 =?utf-8?B?Z1FJV0tlWXNXcDBwc2ZkVmNJY0U5T1FyQ1Zxb1BSU2kyL1EzT1lmN1FIWE9C?=
 =?utf-8?B?RStzV3VTc3J0QXJLK2hWcFg3S3Y4Y2plbll4MmRoVExQL09URk85clFBQWE2?=
 =?utf-8?B?SXRONTJ0eEd5dk9MU0xLNzhDTWVqMTYvcGFsK1Fkb0dBaVNnTTRnOTFUdjYy?=
 =?utf-8?B?SG5GK1RaMjIvVjNzOTRidEJDQkVYSDVMaEJLVnhwTVR3L2dqUWtPdndQVElh?=
 =?utf-8?B?L0FBNWlsNFJHRkxNcFJaYVNkMUVwU1B0SnhJd05BZVkxMTgxak1US01uMVNp?=
 =?utf-8?B?bWlqdHNnRkw2U3BRcE5zZFRWT0VSd0JwSkdFc3pEdzhFU0hvTk5KdWIwYzc4?=
 =?utf-8?B?VC9VVzQ0aTVLRXlVcGUxYlhVbHM0YmI4Q0VtakFReEEvaG5uU2JOMEZCKzJP?=
 =?utf-8?B?MGFRbm5lMXdSTjhYN1ZXeEF1OVI5bnROMXRrUUFqZ054bFhoc2xZdUZha1Rq?=
 =?utf-8?B?RkJkYXg1bDRMeGYyTmxkK2NoQkdjamZDb0pRU1hkbVJ3UkUxbXRxbmd5K1dQ?=
 =?utf-8?B?QjN2VUMrUWxLRmMxMlB6S3ZBSHF0SnBpV1hPVEFyUFUrVUUydXk3Nm1Ka2NH?=
 =?utf-8?B?SHBObEd0SnJHYUdlblhlR2dORU5yUVNKNzFLb3lwTHN6b0NrR3ZYTDNNWlk4?=
 =?utf-8?B?em9aQ3UzQ2F2QXZZU1hXQjg3U25kNUZQK2E5SmJMUXhka2t3ajZRcktnM2JF?=
 =?utf-8?B?L0hDblFXbFkxSDBPUkhCK0U4MEVvOTl6UnJaSGs1Uk45Ni9OUnlQdHBXTmNU?=
 =?utf-8?B?K3IzaUVJRDZ1aXFBTGJRZkRkSHVZeEtHNU1IWEl1VWJJSEsyRzJCSEZHK2Rl?=
 =?utf-8?B?RVUxUkxNWmQ5Wk81N0hrK1VoUFV4a3BtVGtUVFlXV0JaYmpDc0graEIySW9s?=
 =?utf-8?B?MHB2SUpIMWNIblNWVUlqemxodjZrVFp2Qlg5TXlNaDhIalduSDJPcDlJaHpI?=
 =?utf-8?B?L3EzR09iZHVwbnJtSlhtMXdiNHp1STJZREdHdWh3bm5uTElsSTZrSWNSbFAx?=
 =?utf-8?B?NmF4cVpwalVJc0VBMDJmTjRsUm83MzB1alZjbnJncFZvWURrWTVHekNEQzBx?=
 =?utf-8?B?ZHZEcVJzNEJFaFNPTVR1eFNhRUZBRWNUMlg3TWxQRTVoY0Y5bkRuNEJ1MzQ2?=
 =?utf-8?B?b3pkMmRkWlJpZWNidmJpZ1pBckhGR0EwWEJZcmNGZ0tEMGRrc05qWFV5QVo2?=
 =?utf-8?B?OTF1VEN4YitzYUFtd055Ync1eStSTjZVSnpaa3laK1FvNTQ3akYxampSdTk5?=
 =?utf-8?B?dk5FYjB1K05IdnNNNXdiQW9OYlF2eGJkNG52d2JaVnpGWnlkd25vQWV5eCtj?=
 =?utf-8?B?Nlo2YkZlZHdGWmpHYlo2bkhpby9nK0kyREUrTTdVMnhCVS9ieU5ZZklQYUdV?=
 =?utf-8?Q?O4U1HP0/xpVxulrgGqapu+Ncd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 567f3dd2-1c66-452c-6a1f-08db8d17c8ff
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 14:02:30.2944 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NjHisgerGq5Hvu9pF6JOF31jluEo8MjKXmdZxKb1dXLb6dwXrvWOfLUMergPYLFd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7284
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



On 7/23/2023 11:45 AM, Srinivasan Shanmugam wrote:
> ENOSYS should be used for nonexistent syscalls only, replace ENOSYS with
> EINVAL & other style fixes
> 
> WARNING: ENOSYS means 'invalid syscall nr' and nothing else
> +       if (r == -ENOSYS)
> 
> WARNING: ENOSYS means 'invalid syscall nr' and nothing else
> +       if (r == -ENOSYS)
> 
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 60 +++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  |  4 +-
>   2 files changed, 33 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1c786190a84e..ec166c797b9a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -159,7 +159,7 @@ static ssize_t amdgpu_device_get_pcie_replay_count(struct device *dev,
>   	return sysfs_emit(buf, "%llu\n", cnt);
>   }
>   
> -static DEVICE_ATTR(pcie_replay_count, S_IRUGO,
> +static DEVICE_ATTR(pcie_replay_count, 0444,
>   		amdgpu_device_get_pcie_replay_count, NULL);
>   
>   static void amdgpu_device_get_pcie_info(struct amdgpu_device *adev);
> @@ -183,7 +183,7 @@ static ssize_t amdgpu_device_get_product_name(struct device *dev,
>   	return sysfs_emit(buf, "%s\n", adev->product_name);
>   }
>   
> -static DEVICE_ATTR(product_name, S_IRUGO,
> +static DEVICE_ATTR(product_name, 0444,
>   		amdgpu_device_get_product_name, NULL);
>   
>   /**
> @@ -205,7 +205,7 @@ static ssize_t amdgpu_device_get_product_number(struct device *dev,
>   	return sysfs_emit(buf, "%s\n", adev->product_number);
>   }
>   
> -static DEVICE_ATTR(product_number, S_IRUGO,
> +static DEVICE_ATTR(product_number, 0444,
>   		amdgpu_device_get_product_number, NULL);
>   
>   /**
> @@ -227,7 +227,7 @@ static ssize_t amdgpu_device_get_serial_number(struct device *dev,
>   	return sysfs_emit(buf, "%s\n", adev->serial);
>   }
>   
> -static DEVICE_ATTR(serial_number, S_IRUGO,
> +static DEVICE_ATTR(serial_number, 0444,
>   		amdgpu_device_get_serial_number, NULL);
>   
>   /**
> @@ -481,8 +481,7 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
>   /*
>    * MMIO register read with bytes helper functions
>    * @offset:bytes offset from MMIO start
> - *
> -*/
> + */
>   
>   /**
>    * amdgpu_mm_rreg8 - read a memory mapped IO register
> @@ -506,8 +505,8 @@ uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset)
>    * MMIO register write with bytes helper functions
>    * @offset:bytes offset from MMIO start
>    * @value: the value want to be written to the register
> - *
> -*/
> + */
> +
>   /**
>    * amdgpu_mm_wreg8 - read a memory mapped IO register
>    *
> @@ -991,7 +990,7 @@ static void amdgpu_device_mem_scratch_fini(struct amdgpu_device *adev)
>    * @registers: pointer to the register array
>    * @array_size: size of the register array
>    *
> - * Programs an array or registers with and and or masks.
> + * Programs an array or registers with and or masks.
>    * This is a helper for setting golden registers.
>    */
>   void amdgpu_device_program_register_sequence(struct amdgpu_device *adev,
> @@ -1157,7 +1156,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   	int rbar_size = pci_rebar_bytes_to_size(adev->gmc.real_vram_size);
>   	struct pci_bus *root;
>   	struct resource *res;
> -	unsigned i;
> +	unsigned int i;
>   	u16 cmd;
>   	int r;
>   
> @@ -1226,9 +1225,8 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>   
>   static bool amdgpu_device_read_bios(struct amdgpu_device *adev)
>   {
> -	if (hweight32(adev->aid_mask) && (adev->flags & AMD_IS_APU)) {
> +	if (hweight32(adev->aid_mask) && (adev->flags & AMD_IS_APU))
>   		return false;
> -	}
>   
>   	return true;
>   }
> @@ -1264,6 +1262,7 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
>   		if (adev->asic_type == CHIP_FIJI) {
>   			int err;
>   			uint32_t fw_ver;
> +
>   			err = request_firmware(&adev->pm.fw, "amdgpu/fiji_smc.bin", adev->dev);
>   			/* force vPost if error occured */
>   			if (err)
> @@ -1366,6 +1365,7 @@ static unsigned int amdgpu_device_vga_set_decode(struct pci_dev *pdev,
>   		bool state)
>   {
>   	struct amdgpu_device *adev = drm_to_adev(pci_get_drvdata(pdev));
> +
>   	amdgpu_asic_set_vga_state(adev, state);
>   	if (state)
>   		return VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM |
> @@ -1388,7 +1388,8 @@ static void amdgpu_device_check_block_size(struct amdgpu_device *adev)
>   {
>   	/* defines number of bits in page table versus page directory,
>   	 * a page is 4KB so we have 12 bits offset, minimum 9 bits in the
> -	 * page table and the remaining bits are in the page directory */
> +	 * page table and the remaining bits are in the page directory
> +	 */
>   	if (amdgpu_vm_block_size == -1)
>   		return;
>   
> @@ -1620,7 +1621,7 @@ static bool amdgpu_switcheroo_can_switch(struct pci_dev *pdev)
>   {
>   	struct drm_device *dev = pci_get_drvdata(pdev);
>   
> -	/*
> +       /*
>   	* FIXME: open_count is protected by drm_global_mutex but that would lead to
>   	* locking inversion with the driver load path. And the access here is
>   	* completely racy anyway. So don't bother with locking for now.
> @@ -3265,7 +3266,7 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
>    *
>    * Main resume function for hardware IPs.  The hardware IPs
>    * are split into two resume functions because they are
> - * are also used in in recovering from a GPU reset and some additional
> + * also used in recovering from a GPU reset and some additional
>    * steps need to be take between them.  In this case (S3/S4) they are
>    * run sequentially.
>    * Returns 0 on success, negative error code on failure.
> @@ -3367,8 +3368,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
>   #else
>   	default:
>   		if (amdgpu_dc > 0)
> -			DRM_INFO_ONCE("Display Core has been requested via kernel parameter "
> -					 "but isn't supported by ASIC, ignoring\n");
> +			DRM_INFO_ONCE("Display Core has been requested via kernel parameter but isn't supported by ASIC, ignoring\n");
>   		return false;
>   #endif
>   	}
> @@ -3616,7 +3616,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   		 pdev->subsystem_vendor, pdev->subsystem_device, pdev->revision);
>   
>   	/* mutex initialization are all done here so we
> -	 * can recall function without having locking issues */
> +	 * can recall function without having locking issues
> +	 */
>   	mutex_init(&adev->firmware.mutex);
>   	mutex_init(&adev->pm.mutex);
>   	mutex_init(&adev->gfx.gpu_clock_mutex);
> @@ -3693,11 +3694,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   		atomic_set(&adev->pm.pwr_state[i], POWER_STATE_UNKNOWN);
>   
>   	adev->rmmio = ioremap(adev->rmmio_base, adev->rmmio_size);
> -	if (adev->rmmio == NULL) {
> +	if (!adev->rmmio)
>   		return -ENOMEM;
> -	}
> +
>   	DRM_INFO("register mmio base: 0x%08X\n", (uint32_t)adev->rmmio_base);
> -	DRM_INFO("register mmio size: %u\n", (unsigned)adev->rmmio_size);
> +	DRM_INFO("register mmio size: %u\n", (unsigned int)adev->rmmio_size);
>   
>   	/*
>   	 * Reset domain needs to be present early, before XGMI hive discovered
> @@ -3951,7 +3952,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   
>   	/* if we have > 1 VGA cards, then disable the amdgpu VGA resources */
>   	/* this will fail for cards that aren't VGA class devices, just
> -	 * ignore it */
> +	 * ignore it
> +	 */
>   	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
>   		vga_client_register(adev->pdev, amdgpu_device_vga_set_decode);
>   
> @@ -4034,7 +4036,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>   
>   	/* make sure IB test finished before entering exclusive mode
>   	 * to avoid preemption on IB test
> -	 * */
> +	 */
>   	if (amdgpu_sriov_vf(adev)) {
>   		amdgpu_virt_request_full_gpu(adev, false);
>   		amdgpu_virt_fini_data_exchange(adev);
> @@ -4771,8 +4773,9 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   		if (!ring || !ring->sched.thread)
>   			continue;
>   
> -		/*clear job fence from fence drv to avoid force_completion
> -		 *leave NULL and vm flush fence in fence drv */
> +		/* Clear job fence from fence drv to avoid force_completion
> +		 * leave NULL and vm flush fence in fence drv
> +		 */
>   		amdgpu_fence_driver_clear_job_fences(ring);
>   
>   		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
> @@ -4786,7 +4789,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   
>   	r = amdgpu_reset_prepare_hwcontext(adev, reset_context);
>   	/* If reset handler not implemented, continue; otherwise return */
> -	if (r == -ENOSYS)
> +	if (r == -EINVAL)
ENOSYS is defined as /* Function not implemented */ on some platforms.

If not for ENOSYS, please use ENOTSUPP here instead.

>   		r = 0;
>   	else
>   		return r;
> @@ -4904,7 +4907,7 @@ int amdgpu_do_asic_reset(struct list_head *device_list_handle,
>   	reset_context->reset_device_list = device_list_handle;
>   	r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
>   	/* If reset handler not implemented, continue; otherwise return */
> -	if (r == -ENOSYS)
> +	if (r == -EINVAL)

Please use ENOTSUPP instead.

>   		r = 0;
>   	else
>   		return r;
> @@ -5393,9 +5396,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   		if (adev->enable_mes && adev->ip_versions[GC_HWIP][0] != IP_VERSION(11, 0, 3))
>   			amdgpu_mes_self_test(tmp_adev);
>   
> -		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled) {
> +		if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) && !job_signaled)
>   			drm_helper_resume_force_mode(adev_to_drm(tmp_adev));
> -		}
>   
>   		if (tmp_adev->asic_reset_res)
>   			r = tmp_adev->asic_reset_res;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index eec41ad30406..12515e40b693 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -87,7 +87,7 @@ int amdgpu_reset_prepare_hwcontext(struct amdgpu_device *adev,
>   		reset_handler = adev->reset_cntl->get_reset_handler(
>   			adev->reset_cntl, reset_context);
>   	if (!reset_handler)
> -		return -ENOSYS;
> +		return -EINVAL;

Please use ENOTSUPP instead.

>   
>   	return reset_handler->prepare_hwcontext(adev->reset_cntl,
>   						reset_context);
> @@ -103,7 +103,7 @@ int amdgpu_reset_perform_reset(struct amdgpu_device *adev,
>   		reset_handler = adev->reset_cntl->get_reset_handler(
>   			adev->reset_cntl, reset_context);
>   	if (!reset_handler)
> -		return -ENOSYS;
> +		return -EINVAL;

Please use ENOTSUPP instead.

Thanks,
Lijo
>   
>   	ret = reset_handler->perform_reset(adev->reset_cntl, reset_context);
>   	if (ret)

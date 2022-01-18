Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CB9C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jan 2022 13:37:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AF7F10E2DF;
	Tue, 18 Jan 2022 13:37:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 849E510E2DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jan 2022 13:37:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGazBIYVV7EzuBhXdwRVxBTriKXZKwyi5U2qXClJb3r0PvqxYOQ2QutQsmCnKvr2gqwP459gvuNAjQP7Dvk7qoI+ioS88Hvs1hNrHuqNim57wbS+FVi0RgFKLNKrpkv1Z7OayPUxrYM4HxZIBd8tRfI1sDH/oMBjl0vVm43vmzvo3s9Fv9Ze456USVorEJoQZ6cFn1HzYzwcnOmCDN9IXK2slHjzbYaneN0skY0dgoWifywKrYgVBPn77tcy0hbyAElvzgHoVXE57M2/c6VTozMEoOrjfpY4/lsED9N3MIizx1HkWXnVbLUznzpLRIqjdNJvsjSvT1QQZIMGaewOkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHnyn5VNu//43CYwV5lJuwfCBlR9KNkb4P0qDxa3xsA=;
 b=J1um85NZh7ZQs6A+500xje4FwzPrx9O20Z3IVeb0wDwJtksvUV07Il4WdPVeO/JTk+NNkqtx4N/aRmY5eM7rV8lboUwlHk9H64Z7L4EOL7IPx6dou4IVoTnvh/JTCHZvZNZDnhtsYA1Mi7mFL/RKJtAEG557K0Ld+VuD1Y49vJpFcdk4haqhdix1VkaxdpWH/NucfG70LTtmMZ03ssf/j4DlgZiT5Ec4Io86oNYhFncwG8A/u9dUjDHjwZbxJQL4WG6e6glNPhmgFjIClOpSDe+lINQ94x63t8HzhrmmvVaUaU1mp7kTwdAwruQ+VFhExJ0kChORwbNaQ5ZTlI9N/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHnyn5VNu//43CYwV5lJuwfCBlR9KNkb4P0qDxa3xsA=;
 b=POiT1xJ4kvwTBdl5VmT+CWgzo3mvHHe8Qdf45XO6kN8lPaz0l+JDYGudWQ8FkjKFFxHMgt4jTwMumKB658OnJK9p+B4CII8pViWTb7JJiK16uhOK1ZY289ZJf7ZjdOpkSh2b+xSdzaY2aY10GQCp5QrorDUqdSDT79hUA+Sr3aw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB4546.namprd12.prod.outlook.com (2603:10b6:5:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 18 Jan
 2022 13:37:12 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::9c25:ce1d:a478:adda%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 13:37:11 +0000
Message-ID: <381f44c6-97d6-7717-6063-6a2cd3d21174@amd.com>
Date: Tue, 18 Jan 2022 19:06:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amdgpu: modify a pair of functions for the pcie port
 wreg/rreg
Content-Language: en-US
To: Xiaojian Du <Xiaojian.Du@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220118112618.16000-1-Xiaojian.Du@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220118112618.16000-1-Xiaojian.Du@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0124.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::12) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86a76661-5679-42fe-bc4f-08d9da87a16c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4546:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB45466F5F7F81603C0463FDE297589@DM6PR12MB4546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NzaCU8omNttWO845on5U6D4WQHbJ4IBoI68Isab3F7B+11YfoKw30hGRBJeWgt0wNKYR80F39Q55BRnr+4sffhQinP5A4dvrHnfLygo2HjyNhImZdiZtlYGDOvjhTMsU/2qRpvpJDAF1tE2vRSf538kqpBD5DxOzLKxL3rXwzb36OK9ju2Nn8Uw5V2NFTI/OnQu3VSNoSzxivysDJ52eRjM8+sl/3GRx6Oh3SyvWhr/pj3j2JV+hNa+N8XUC5kyh8CzoV2uq8Jhra952Eyjv1l56o51MrPpnkrKIvjy2YBHaIDJY+15Wj7AkXF7ytfgMgjziYY1Og9tQkwCh04Kpdv+rUHkyDWcwyMeEyCewv2PmjdiUwom5OqaUvK/SstN8EA011D5lC24bV2XOT5SIUblh6i6rgLl7qZdPJfldDEXayRxN1Qd3JFwemEwBL4DzJizxEOzGkRCgGQWJ9jQSy5b09Tw1U7lokw8lnYFEgC4C516BX4pNRcix9LQjsierpVilW9EHEo0jTC4ZdFI3fzpEpxLTiLFhaP16RSQvUv9vjEHfAJ99lOvXybqGq4YGZBzF5tozXnJPuaGtu7HUx2mnCjwLbe2nlU31tv7OOoMP6Sv6gT94YulskEtku4WQx+Dw8L9vZJE34Nn6fJp9E0hKQlD90MNKZyyCCzGElqAYPyFdUgYM/1u0uLw7wmONPs6AwFF6V3D87sUI4JV0UCCdO7+K8V2LkmP7+ch87Io=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(31696002)(2906002)(6486002)(8936002)(186003)(66556008)(66476007)(66946007)(26005)(6506007)(86362001)(8676002)(6512007)(53546011)(5660300002)(316002)(38100700002)(6666004)(2616005)(36756003)(31686004)(508600001)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3lmYStTN2NYLy9md3ZOTHk2RUpOZ2R2MkQyZXIvWVpRa2xQaVJxY2tub3Vt?=
 =?utf-8?B?STdCT05wdmlXR2FzSG5VUUZnUU5XbFg5TEpPYWlXRnV1RSttRHlTeW9HWWRJ?=
 =?utf-8?B?d1dIMncrTVFhbWtpTDhmN3BjeHJpclZxZXUwRmZsZDhZOVpzVElkU0FzT1Ew?=
 =?utf-8?B?QytWTEw0dWZsWXRNUkpyMkI5blJ6T3ZyaCt6MG9MNGxQODc3WjBtNGdwQXF3?=
 =?utf-8?B?ZCtlcHZxUkgxRGJDdHJXSUo4VytkcmlGODl5N3VRQ2l6dHBpWml0UUpnREVC?=
 =?utf-8?B?Zzd5OXNHUmxTZzJmZHRkTllKWVJBWkFVSjkyUCtiTzBrMThMcmNES1JMMDM5?=
 =?utf-8?B?VjF5Q1NNbUtZN2laSlo2cktkbFc0RS91c2gxRTFVc0NZWlc3YlVvMVBFYUsx?=
 =?utf-8?B?Tk5xNk9DSk1sMDhXNERWbitQcSs1dElaWWVPL2szNUhjY1ZxOGIvN2N2T0tt?=
 =?utf-8?B?amlmb2xhZzdQTTdnRlZybmhjanhia1k0NEZjRWFucE5RNENaZHJhSkNRUFNK?=
 =?utf-8?B?aDNSbnRWWDFKcHE5dXMyWkZjL0FhOUl1cjNkYWF3azNpZmtKeDgyMUxIQlow?=
 =?utf-8?B?UlVLbHAzTEREVGwzQ0swRWhUZGx2OVpKTStiU1h4eVhyWGtPRFpXNm9nWG0w?=
 =?utf-8?B?VGRWcElBRk1Xc09hOG9ZOTJsSTlSQnU0TG5MOUZYOUZiMXo2ZXZZYWtZQTVh?=
 =?utf-8?B?ejhJZkpxUzRCWFZYZ2s5bENUOGpIOVB1V0xrWVJkUFRBRnV1cnF6Zm1oY1Bw?=
 =?utf-8?B?MlF3QkVuV0tZL2hvUExSTk9CdGptZU9pcnlMNGFBYjNJcXlESUhCTlJtMHll?=
 =?utf-8?B?bGNsZGU4a253K1dWQXl1SU5FVFpXaHR2dFdJSFlMazNtbGhuNG52Q29GSUpI?=
 =?utf-8?B?K1N6cE0vYlJsejRtR0t0Z3ZFWW9XS05GcXZKSitCQyt1QUZ3UnErdEtGcVhX?=
 =?utf-8?B?SGJSRTBPWHRoMnVQb1FKWXNzUkViS3dicW9CSnhvSVFvZHR4WHdOU3lxazFO?=
 =?utf-8?B?QStTR3h1WVdubWJkUTJHUTlkbjhnOXZLbnJYSmtIS1RPdFlrZk4xemM5NWpC?=
 =?utf-8?B?ZzI4OU9hMEJrVWdhQXl3SVlvZk9DQVBqODlmc2pVRWFCSytrWlQvdG01SER0?=
 =?utf-8?B?OW5vSUxxU3l1elYzb25vRk9IUk5sYjhkQklLUHF4SFB1TUFESFpyTThpZXJE?=
 =?utf-8?B?b1BPcmZ0TnQ3Uk1qZUNtRmY2d2xFdkJ6c09zS0o1dnUvelQxMkIzaWJuOWMv?=
 =?utf-8?B?S2JwVy9nR2R2d3B0eEc5aDRKb0pMdHNrZStlOUdVeFlMcHE2UTRlY3dGWmlD?=
 =?utf-8?B?MVQrVlhVc0RMZm5Vblg2MWMrelQzdzZNeGlnRHQ0b1hqOFpQL3pFQkVVclBa?=
 =?utf-8?B?TEJ3VTlhOTdFQit5ODVmbjhrNXBzRHVLbzI3eXNuUmgvaXo3ejJscDNFWE1i?=
 =?utf-8?B?OXdRRy9FaEVCc3Y2UDMwRHVmQ0MxTnVYYnprVEFkOEpYNitrejZBbHJPTERE?=
 =?utf-8?B?TjlEL3AvYVNnYTJZaWpGVFNXd3YwMnlPdzNqQkQ5VUU2SUlVTWwyOWxlNXBB?=
 =?utf-8?B?cGo2U0k2WVdjektZckIxU3doUCszTFJoSXY3WklBRGJjTEdsUDhIcmZyMTRM?=
 =?utf-8?B?Nk9oREFSenVvSTZZd0lUZmM5WWxCOStuRXdhTTFjd1lqNStEb21OdzkrM3RW?=
 =?utf-8?B?RklFQXdBZjZLZHJIVGRtRjBibmIyK3ByOXV3R0oybWh2Y3NMKzM3MXNVUTNW?=
 =?utf-8?B?N3haWmI4Wm9Pb1V6M0x3dzlTS2NxSjdVRU9LeDF3dHlVTnQ4cHNDVVhQdUJW?=
 =?utf-8?B?NDVwVi9YcExkWGpOUDNabGljS2gwNWkyYXZlcENKRnBNSEE5blp3aTBGU3Mr?=
 =?utf-8?B?MHJ3a1V3QmwvVnhIUXp3TDlyQXdxL3YvOEp2OEcraEs4cFljOXFBQ1VjbXhJ?=
 =?utf-8?B?dFNEU2FkYlN1OW9NS3pyV2pzYmhaaTNLdDE5SHcycm51NDNDeElOMFZYUW1M?=
 =?utf-8?B?NFBwZ3kxLzhGWUNEZytjaHZkZ1B6enFoajB2eUxNMVkwZVJRczJCQ1pRZlNV?=
 =?utf-8?B?TkpjZGM2L1JmRkZPMW5wM0ZpdWZVcENNNGVaa0ljQWJZY05MNWZXZlJucFZq?=
 =?utf-8?Q?M/HM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a76661-5679-42fe-bc4f-08d9da87a16c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 13:37:11.8020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmoWQau64p16LSZcbC6fg2lGFEPQcP4wGnebBHMyej+M+TcaGRWT9FKGx+soPvtI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4546
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
Cc: Alexander.Deucher@amd.com, ray.huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/18/2022 4:56 PM, Xiaojian Du wrote:
> This patch will modify a pair of functions for pcie port wreg/rreg.
> AMD GPU have had an independent NBIO block from SOC15 arch.
> If the dirver wants to read/write the address space of the pcie devices,
> it has to go through the NBIO block.
> This patch will move the pcie port wreg/rreg functions to
> "amdgpu_device.c", so that to make the functions can be used on the
> future GPU ASICs.
> 
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 33 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/nv.c            | 34 ++--------------------
>   3 files changed, 39 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index b2da840f4718..691d7868d64d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1421,6 +1421,10 @@ void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
>   		struct amdgpu_ring *ring);
>   
>   void amdgpu_device_halt(struct amdgpu_device *adev);
> +u32 amdgpu_device_pcie_port_rreg(struct amdgpu_device *adev,
> +				u32 reg);
> +void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
> +				u32 reg, u32 v);
>   
>   /* atpx handler */
>   #if defined(CONFIG_VGA_SWITCHEROO)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ff4cf0e2a01f..10f2b7cbb49d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6023,3 +6023,36 @@ void amdgpu_device_halt(struct amdgpu_device *adev)
>   	pci_disable_device(pdev);
>   	pci_wait_for_pending_transaction(pdev);
>   }
> +
> +u32 amdgpu_device_pcie_port_rreg(struct amdgpu_device *adev,
> +				u32 reg)
> +{
> +	unsigned long flags, address, data;
> +	u32 r;
> +
> +	address = adev->nbio.funcs->get_pcie_port_index_offset(adev);
> +	data = adev->nbio.funcs->get_pcie_port_data_offset(adev);
> +
> +	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
> +	WREG32(address, reg * 4);
> +	(void)RREG32(address);
> +	r = RREG32(data);
> +	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
> +	return r;
> +}
> +
> +void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
> +				u32 reg, u32 v)
> +{
> +	unsigned long flags, address, data;
> +
> +	address = adev->nbio.funcs->get_pcie_port_index_offset(adev);
> +	data = adev->nbio.funcs->get_pcie_port_data_offset(adev);
> +
> +	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
> +	WREG32(address, reg * 4);
> +	(void)RREG32(address);
> +	WREG32(data, v);
> +	(void)RREG32(data);
> +	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index e52d1114501c..17480c1eeae8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -256,21 +256,6 @@ static u64 nv_pcie_rreg64(struct amdgpu_device *adev, u32 reg)
>   	return amdgpu_device_indirect_rreg64(adev, address, data, reg);
>   }
>   
> -static u32 nv_pcie_port_rreg(struct amdgpu_device *adev, u32 reg)
> -{
> -	unsigned long flags, address, data;
> -	u32 r;
> -	address = adev->nbio.funcs->get_pcie_port_index_offset(adev);
> -	data = adev->nbio.funcs->get_pcie_port_data_offset(adev);
> -
> -	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
> -	WREG32(address, reg * 4);
> -	(void)RREG32(address);
> -	r = RREG32(data);
> -	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
> -	return r;
> -}
> -
>   static void nv_pcie_wreg64(struct amdgpu_device *adev, u32 reg, u64 v)
>   {
>   	unsigned long address, data;
> @@ -281,21 +266,6 @@ static void nv_pcie_wreg64(struct amdgpu_device *adev, u32 reg, u64 v)
>   	amdgpu_device_indirect_wreg64(adev, address, data, reg, v);
>   }
>   
> -static void nv_pcie_port_wreg(struct amdgpu_device *adev, u32 reg, u32 v)
> -{
> -	unsigned long flags, address, data;
> -
> -	address = adev->nbio.funcs->get_pcie_port_index_offset(adev);
> -	data = adev->nbio.funcs->get_pcie_port_data_offset(adev);
> -
> -	spin_lock_irqsave(&adev->pcie_idx_lock, flags);
> -	WREG32(address, reg * 4);
> -	(void)RREG32(address);
> -	WREG32(data, v);
> -	(void)RREG32(data);
> -	spin_unlock_irqrestore(&adev->pcie_idx_lock, flags);
> -}
> -
>   static u32 nv_didt_rreg(struct amdgpu_device *adev, u32 reg)
>   {
>   	unsigned long flags, address, data;
> @@ -709,8 +679,8 @@ static int nv_common_early_init(void *handle)
>   	adev->pcie_wreg = &nv_pcie_wreg;
>   	adev->pcie_rreg64 = &nv_pcie_rreg64;
>   	adev->pcie_wreg64 = &nv_pcie_wreg64;

Looks good, would be better if the above ones also are changed to common 
implementation.

Thanks,
Lijo

> -	adev->pciep_rreg = &nv_pcie_port_rreg;
> -	adev->pciep_wreg = &nv_pcie_port_wreg;
> +	adev->pciep_rreg = amdgpu_device_pcie_port_rreg;
> +	adev->pciep_wreg = amdgpu_device_pcie_port_wreg;
>   
>   	/* TODO: will add them during VCN v2 implementation */
>   	adev->uvd_ctx_rreg = NULL;
> 

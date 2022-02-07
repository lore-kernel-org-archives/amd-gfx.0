Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4A0C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 14:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78DAB10E228;
	Mon,  7 Feb 2022 14:36:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1645410E228
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 14:36:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lo0T8NTqBh1gQ7vHlKTcVSiGq1/uTRGoXf70we+CpN0JlmPYLao1R1ga1pERYlxdTbUUuXxmybPclvNPtmmwXiD3O3K7ExeYsaaF7KIKwzPZAuzWLBJGlxTEmibWIVtp3+B/gSMqIAZEMg+9nTGh9BYhDkr8Q/jNdneIgRJnnd3WM31Jp4t365AjfvzcxTWE78FzhRU0tSoEX5KJhI4DbkYgrA7Ot7fS09yKje3EVRA3BlI04fbmTkANl0MAxdZFYjGLeyuzIY2W3vxFwNWxfw+fTaDx0DD471KsHK3lHIEYvmv+vkhqTAHV8FIUKpKiDI+B3AHAqMgW+jFN+4qoSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LZz7wIhZW6oObBjRuUzq5wA6vjWx13D9pp+mGpghWdE=;
 b=QO4b/Ina1iE2tMwFmA0B75Bs7eayRgH+azgO20zVVsrF0qOiV+67igkSOtdr0Q5tOvrw297vqjlsAgBKT3KZcAbub0W0zfTuF47dkCInE4eacdP3bPk6yvbaFfm2wCXRvwXhX9q+xJylSmAg5DC3DtfCX/4Uw+J+m4948XtGyPt+KdfN85CqOMJPFyxhLF9qDbQAVSOMxWdI8VEIMFbvjQasrLfgTeloVXPS3U7jwJSFTeaetKh0AW5nur3UHaVr+0CPkGDXX+MmXKL1EEV5ttzTRyEgDLNlR4oM8g6TkpkSPStusozpxQOo8YLoshF053KLtIM44ZUrmiRcuxo0JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LZz7wIhZW6oObBjRuUzq5wA6vjWx13D9pp+mGpghWdE=;
 b=BLkhv56z9+pI+JZSdCunGaTW22VIrDk6EISpyeohOdMqJX0U+F2FPBlel3qu/Pg78pwvJiHWuIiLfFI1aY/Oou+LVMzNNdAnAvAi3I6nF7spraF9wTR84Wl2cfXQtkV/BvT76Ks06rKVZlBPU7L2YHsAGYoH6PBY6S5Qdk4K6F0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BY5PR12MB3874.namprd12.prod.outlook.com (2603:10b6:a03:1ad::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 7 Feb
 2022 14:36:43 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%8]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 14:36:43 +0000
Message-ID: <09c13def-2fc7-f984-5b4e-5d6e22efb180@amd.com>
Date: Mon, 7 Feb 2022 09:36:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu: reserve the pd while cleaning up PRTs
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 rajneesh.bhardwaj@amd.com, amd-gfx@lists.freedesktop.org
References: <20220207080745.1711-1-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220207080745.1711-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YTOPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffa12876-0780-46da-89af-08d9ea4742be
X-MS-TrafficTypeDiagnostic: BY5PR12MB3874:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB38746711B171FE395CEAD908922C9@BY5PR12MB3874.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rY99EoS1DwASb+joVKEgET2atBGNCevuaR/dI84xkfPF8d5CRnSalTMCd+Ap1/FdGOll68JoECh8GqfQo+qKGjQTLoS4EGAzX/KlbR0hgD6ASbFrrnfn2N2rS6ncY1I2UFFyyZpnQplA4/uguM8D+6Ik0kVVKXzPOJrsokDR/t9RC774YzWjjcQmiQeI0w10FyevIMUvNRUCY24H1ss7lnR4eegHEOf7t3/8fK4rupx/sMhAHCe2um8AEquBalH2Ms54w59G1sQBYOdLApih6j7BgU3mmUGTWTGmb3yvddhaOGruWEXVr3/EfjaWe4UYs6Gzc+40zlt2XGKJ/xBj+mMxWa06pZ7yst0xnEaRG+ilAyEtXlmlJCZ1su0o/PNa/5ZzyfrM32IjNdwGveZ1F+V4FV/IWb54XR98m9Tg2XhRJQqTetlow0ytRl4jjCQw575w50CO0stu/krpqDGDPDCKqMnZU/R/IQlqlw5LrSPs7Gvm/e1ya4gSLL72ui7uFKj6XYT77iq0vhuqFwwZcx+w4NVvbOdMUlHOZjyeOiT39DatkUUnrOP/lGeTDPtr9n88dRzXqW9zTGaQhvamHILzLNvlNapxl/cLFsWdlCyjCIu41OgBzdRcV36SaXRhw2lH0WEVg3Xaq3Q/5JBxQb0068Ubhw5QMSsOwR09vbSAXTs/SfdnaYX8fAyi+reXn+3NYj3sNzC5fi2vbAKnUCXE33lzrPMFW8DkBsRNe6maeuKRqoSJc07lNBx3Kg8EK6JLPzLE4HD9r/bmFBIMEy0BBUX5gQ0wOKW/apY4gNQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6486002)(6512007)(508600001)(186003)(83380400001)(38100700002)(31696002)(86362001)(6506007)(2906002)(66574015)(26005)(2616005)(316002)(36756003)(44832011)(31686004)(5660300002)(8936002)(66556008)(66476007)(66946007)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTd5T3Z3WXlwVnNYdDN5dlR6eWYvbVl3aWY4YUUvSVFxcElsbFR5SnNQRDBX?=
 =?utf-8?B?bkxCbkhMazdzdEluTTBxcUZsVEtabnFERUw2cjhqR3ZBemhPOGVINlA0c3pv?=
 =?utf-8?B?ZUlPMm1xOXZzdENvUXlqcXRTQmRiZEV4L3FVQXNEOVlKMDArbGVMcHhEVFFX?=
 =?utf-8?B?R2g1Qk15a0RJaDEvcmhtaFVJYllmdkJvU3FrZTB2NCtBK0FQZFgxamRaYUVi?=
 =?utf-8?B?MGlBUlBBQkZqQXgzWmpEMktHM1lGRjdETFRaeTNpOU1oUlhjZG5OWTljRTQw?=
 =?utf-8?B?aDl1cVd0SktjVDFFY1ZLS1FreTZxN1pYMU9GQ29LUjNJVlI2MU9OMURjalc2?=
 =?utf-8?B?dE5YTWJ0bDRhYjBTbWZqNUYwVjhzYmpxUlpoQ3FMc2laTWRjREpXU2swQXg3?=
 =?utf-8?B?L0l2VHR5UEpVblI0Qzlmc0pPUG9nWFdHVHZoVThidG5Da2lvUlJSZy9hVjNt?=
 =?utf-8?B?WTQ5eGFMS1lsT1pxeVFMUHMrNjNNL0ZBWFMvbmdPVytsaTM1YmJSYTJRbkxq?=
 =?utf-8?B?NCtjNzA2cW9qVEdzRGhNaitNYWl1eDFaZkxVWldSMHBJdUJQSVlrZzM1Tmhh?=
 =?utf-8?B?dFNMTndGY2ZEUEk3N2xNOWJKNEhicXZENFAwZS9sQjBsKzhBdHA3endod0R0?=
 =?utf-8?B?azNPclRRT2R2VFJndGZuTGlYcGZodkFBSGZBL09CRXFVajlWN09QbU5oOFRV?=
 =?utf-8?B?MUwrQ1dPbWNDV2xQcWVuTmVkaEpTWXR1dlgzUmdCa2crSG9GY0lDU3FLUkhH?=
 =?utf-8?B?VzMxUzEzWDVUQVRtdEt6SUZYUVBnMWZMMCtJemdhc2RJSWI0bXBxTkZkLytv?=
 =?utf-8?B?bmIweGlzZWdCNHJrZDRoMStEakVnTk9XY2hudDdIZmlzMytBOUZUeXEzb29K?=
 =?utf-8?B?ODFXYnAyU2o4MXJxMFhnZ3Q4RGcwY0Npa3BLaDJ4bW05TklmQmtiOUNJeDNw?=
 =?utf-8?B?V2tPUDhJalBpcy9JelVMV0xKNUlXNEozb2FnZ3VRQ3N1djd1azgvYWFpZE9a?=
 =?utf-8?B?QTVKbHdLWmdqamxTRDQxQ2Y1VGdiUUtZV0VyRUF4MWpQL0d1U09uSTliUUpj?=
 =?utf-8?B?cXkyUjd6YWxnK01DR1JQeGU0Rm55N2lMU0NBbk1RTlpCaFkrOTZOaEFnc3I2?=
 =?utf-8?B?SURWY2VxK1lzRStRMkVrU1IzNmd1RjY4MW9iYmNkdzVsb0VjWkRSWEV1ZFU0?=
 =?utf-8?B?Tk5ZaDNKcFRqNURKc2VMUlBmVGdRb3V0bEtWdUZwTW1PS1NzR2pOYWNMaXdW?=
 =?utf-8?B?V3NNQkFWQmV2UlBhaFBhSXhCVTVMaUw3MkI1Lzh6eDBHaXZzKy9SVGhUc0Fp?=
 =?utf-8?B?ZkpQTHdkMEFWb2lzVkFteTl3ZmpMc1BuenVKcG5tU3MvNlRwWjdVSlpMMmtO?=
 =?utf-8?B?bndMSnRHRFBkUjcrWEJMZmhJdjZOZXZyRXcwMFVac0llYm9EaXNYcXR2SnFO?=
 =?utf-8?B?bmFJSmhQWDZDeGVKaEFVdXRiOU1iR2pDaTYxZTJXK1dPQ25mQlhqN0FuMjla?=
 =?utf-8?B?eGZsWjh3RGdyeG10cFNBWmpXS3VuM3BRWkZ5YU53Y0d4VTdUcnl2c1BhSDlj?=
 =?utf-8?B?WnI3OFRLK25rdFhaemV2VGNwcncybzZ2UWF5bmc4U0pYRjBqK0V4c3p2U2Vn?=
 =?utf-8?B?ZDFsWW95ZEFaUkJSWkRsYmlaL0lLbVF1cU11a2ZaNkRLSXdidnIvVThVYWc1?=
 =?utf-8?B?bmZTWGNaZUtCbGNlUzZmQmFDekFtMjN1S2cwVk5hcG8rU2NWRnFjME9MZXB1?=
 =?utf-8?B?QnhMZ1FEMjJ1WUg2SlMrNTRuakFkeVVxSHVEWkNCYUNQK0IzN3RhMHN4dWJZ?=
 =?utf-8?B?S1FZLzFaTkJjeGhyT2xNZE5kY3c1WFMyK3JtazNMdDhrdEVlY3h2MFp3d2gr?=
 =?utf-8?B?am9GMVcxU3ZUVXorS21IWkEyd2FEOG50NGl4eVE3dVdsVWpaTDVja0cvYTBU?=
 =?utf-8?B?dDl2d29paFAzdzJOVHNBRWZORDVGZHhzdkszRnF0RTRSLzFib3NSdDNTUTN5?=
 =?utf-8?B?Z1JJQk95NVBpWlFsV1VoUCtTZHFBaTE4bGFNS2VDVEY2NkFST1RaZ21laEIx?=
 =?utf-8?B?ZkxKZTMzMXF5Y29zY1FzUjFnWDhzZWoySjZ4WnFab0NYbE54YW1uUWh0Z1VK?=
 =?utf-8?B?QjFycVlCa3NPTEVEUkRORlFQRHMvK1JFRFpYZUc2d1drMFVmeTFYZUN2Y0NY?=
 =?utf-8?Q?w9FcVtvAvNnPOYYlVNKrm8U=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa12876-0780-46da-89af-08d9ea4742be
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 14:36:43.4871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E469c+AExlbwTDbVZORIGIvke7lTUj10KXh5GOP+ADdvVT0R1LmEX9S4ngC3KNbwL5KDThPa4YrJsJe4Ysfwcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3874
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

Am 2022-02-07 um 03:07 schrieb Christian König:
> We want to have lockdep annotation here, so make sure that we reserve
> the PD while removing PRTs even if it isn't strictly necessary since the
> VM object is about to be destroyed anyway.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index efd13898c83e..9f985bd463be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1194,8 +1194,6 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>   	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCE) != NULL)
>   		amdgpu_vce_free_handles(adev, file_priv);
>   
> -	amdgpu_vm_bo_del(adev, fpriv->prt_va);
> -
>   	if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
>   		/* TODO: how to handle reserve failure */
>   		BUG_ON(amdgpu_bo_reserve(adev->virt.csa_obj, true));
> @@ -1206,6 +1204,10 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>   
>   	pasid = fpriv->vm.pasid;
>   	pd = amdgpu_bo_ref(fpriv->vm.root.bo);
> +	if (!WARN_ON(amdgpu_bo_reserve(pd, true))) {
> +		amdgpu_vm_bo_del(adev, fpriv->prt_va);
> +		amdgpu_bo_unreserve(pd);
> +	}
>   
>   	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>   	amdgpu_vm_fini(adev, &fpriv->vm);

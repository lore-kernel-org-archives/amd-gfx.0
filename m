Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E88F9937A
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 11:31:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F03A10EE66;
	Thu, 23 Apr 2026 11:31:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5DCJpCDB";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010035.outbound.protection.outlook.com
 [52.101.193.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B62B10EE66
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 11:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stJItk74zyIr6602AgaK1AV0iFswjQQ9TJiwn/A30evsotm6y/779nMYsSIEINb5zFJYTrltU7tG+BjOBCURnMIZD+/sI77wiM2czLwJC8OyMbf9V9oQZhb8eRuwjqcrs5497O45qvlmfCO8bfC4YKvkeQ/4/Ct5dmHxHb90PwOIXCjHdvxEJxfQy4X1ljO1D5OaikqKKRr6Ue32MiSDixOVrUVra5SE/XRa05MD9R0OxqYYKnb/ifJl+NVbdgJL0kJp7tnX5tkU0KrZZTAS5DVG6foTqYcvoJfvZfaHHBYi3PEs2huGJPSdS0gdZd31BErfLPR++b4DhCAzSpY2mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qez/1jfWRspNsYdTHSwPSsn8uftU2b/JX6Xvc8DhXic=;
 b=O+SAkoIg9khV23+Zm3zwmLI5N7jMduMS96lBfbLRwVMuFaPow3q9lkRl281FTVheM/hE0g7KzyLKqMEfM/p+o6Tf0C9SAO2pvorGuf35cDhnOyl+cD9UHpIcVBWjiR/SIWeJaZgs00cpZX4hhhc6itwj38F0shgM9R1lder4MMx/+fz6+6iNyaXXUC8IRvdSbylUP9tL7pZIBciWwAJEc6VRdREMiLDQXyHn9quraul2zTVQKxwjcOGh+09SZq1hRWTal2STg7wRxLEVzhxGj1jlQMrNwVHVW4RmWuXE/EH8Yb8Eb6f8k5CeQ0lY3/YH4nEvvegR+sA2by/Cw6hFiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qez/1jfWRspNsYdTHSwPSsn8uftU2b/JX6Xvc8DhXic=;
 b=5DCJpCDBSS3/iHOtl2EcUWiuTnn8aiHX6NxjMdssYcnXTjFCStT9Fq6fMOrMK+A0TbKA6lDfnDcCmnrdSYYfvxFw+ecbfRPhYu8cj1Dnp3M0mPWnDZrwlGLJD4dGlSZQjdqr3lN4cIxJUJbcnsupUFTGOpJVvC0kBURUvtrr0Bk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7346.namprd12.prod.outlook.com (2603:10b6:806:299::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 11:31:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 11:31:08 +0000
Message-ID: <4d9390ee-cfc3-42cb-bee3-df6b9539078b@amd.com>
Date: Thu, 23 Apr 2026 13:31:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] drm/amdgpu/vce4: Fix VCE 4 firmware size and offsets
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 John Olender <john.olender@gmail.com>, "Liu, Leo" <Leo.Liu@amd.com>
References: <20260423011614.309180-1-timur.kristof@gmail.com>
 <20260423011614.309180-12-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260423011614.309180-12-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: b716c944-b5a2-4194-5179-08dea12bd022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: SmfDNMy2I1HOf6pe2Unxz7+ItRbyxMPactC1dJFawx2dfF2D+FlnpGu9iZwf04Mb2b0mOpdK7s9qZ/fr2Kj1gsee3UOTeUNZ7QHc2+7qItFzsH9sCX049elf8DTaTVNwPjDK8gpTY8k9QxaHQvz9J/oXsUR2ERfhpTlEdL6RpuTh/Aurk/a5nLKmz4TQYkxdOAi8ho60SkkOzKKwe4p8YP4bC6A6Y6V8GATcCkFk1XrnE7JmY7SX+8B6rha3ZiKZgFEIup6c4yQ1MYDD+BK083vZUvVfigdlQgSQm141IBcer9eHbyqILHISzLA0NrZLQgbRPTUqhmD89MRotykU3fR3KuXChYNA46CWoaupqmzTGJ2Jko1AdUCBG7/mat2otP67/pEUHp2pi0WKwlKNQ+On8m9tS9dM07k3KIRk7vxhxtRisJRuJWOKETQdbECQ71Kx05WtGjWhB2+1lv+KcYMPycqAHpO+fc156eP59BCDHS8fyfiSd3iLMXxSMurrcvx4skvW/4wNGZI5jYAteV9GnlrDhGNgUl4akiALQxBpZ95cOLgTot+DN1xL7720AHuHpQLYlS+K0mIjU9vfYGjuyP/mgbdZ697YKuDibdjvy2CXPXLpvnuciSmqqxbdQVpz9cVQsksg3qY3Ea3AUeccLPLBxd3liIw37mnvcZf5Gd+CL8Ne6l8OJsxFgakseVswqFcC5Wm0FlJNZYbI+3y4l+X5wa5tcQkR40AY/nA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T084K1RPOGhmcVA2amRRT0NwVXEvV2lHQ2FMQ29HMFFuMVFCVWVDV1ZvVkNs?=
 =?utf-8?B?K3NNSUlUeENzSFArcWhCZmZjbWhZekF5UkNnMW4vV1FsNU4vYkl6VUl2dkNV?=
 =?utf-8?B?bU0xM3lEZld1MkdpZHVCSGF5YTBqb3VUMDdNdnJnNkFKSEtONWNMQVJML2ZI?=
 =?utf-8?B?eERBMHlVRlZZTW5zVE1zT2VydEhnU09pcXdOdlN2TG9nUjUyNFplMnpSTmlL?=
 =?utf-8?B?ODBrQURxNjg0M2FFdkZUaVFGV25OdzBXdmFsRDUwUmFTQ3ZwV3l0Q3RuN25q?=
 =?utf-8?B?OWxBbFJRbjVHdlpWdmxuN3l3akRxYjluTFArdExweS9rbUhNWGVwM21tRjJx?=
 =?utf-8?B?YkdYeUdOY3ZieGFGS0QvaUh1RUF5QloyUmdKeEUvakV2bVlDMGZwV3FxREN0?=
 =?utf-8?B?TkVlUTdJeWFNblBRdndtbWhYWjlBR2xrUFJaZWp2bzZpYmRoNDFzUmc3MG41?=
 =?utf-8?B?YTBaN2M0clM5UytUTXFLSG9Jck5LcmN0MmEwSU9abmIwcll3N082eVpDTWNH?=
 =?utf-8?B?SVd6UVc0Sm9kUnV1WGJMLytwejVveFNzV294NXdNNTVyQmlxclN2RWlUOVAz?=
 =?utf-8?B?ZzhLTWIzZU8zZHdPVUw1Q0V1ck5WRWtuY0RmVm5pbXhKY25Qd1JsT01xVDRG?=
 =?utf-8?B?MHovZ2k5V3lKYXVsOFJWaTYwQ3ZzdnFPQUFZamQ3UHk2QkF4TElNWk8yNFFn?=
 =?utf-8?B?c0ZPbTBpbFVlbG14MnJSNXVqK1BQSlFjNG5saHRGckpQaEZiRkxobWI2SUpI?=
 =?utf-8?B?bkpKSFR0T3k1WnVWYW5rSnllZFN5WVhFZ3lteWZaaHRRNmM5Q1IvSk9wUEVw?=
 =?utf-8?B?YnZoN0hEWVA4UDNBb2poeW5ZeEZhMEdmZjNFYmlKNlVVNklBYXNZQllkM0RD?=
 =?utf-8?B?cm5CNkZtVm44b29tcCs1aUVRSXBybnVqVVA5QTNEdWNRa2duYndub3lFSFdY?=
 =?utf-8?B?MU9QdzFWN1RvT0IrSXB3eEZLbGl2aWtSY0dnL1dBcXpkQVcxWTdhYm8yV0tx?=
 =?utf-8?B?Zk9XaGtNdDJMM0NaYzhaMHMyMzUzak5RbFJrcWdOTmxZTDlqaGJ1K2xOZW12?=
 =?utf-8?B?VzdvYnhkT1k3MXEybGJnWVZrWFQ5aTN4aTU5OGdCNzY4SUo1TjVsaTVLeTZ2?=
 =?utf-8?B?STNoWTl6M2hvRDJYVDdqMUhwY3VOZUdnYW9kenl1eEFER1FPSnRvSklDRXR2?=
 =?utf-8?B?VDVYTzBjSlZwU1NYOUJCTU1rVHpURGhheURoam4yNlMzUzhGbVU5bFZTMW1q?=
 =?utf-8?B?NFJ5a29nem01b3Z6TmxxWlNQa2RGUkxxR2ZWYVNzWmtXNllMazJPeERXRFpp?=
 =?utf-8?B?QmVEb2tIWnk5VitRS001Q2hWeE9Qd3cxUDhSME9QOWlWb0liVjBpTkhrUlFT?=
 =?utf-8?B?emRnQmpuK1liUS9JdERXbjhPTnYwZlVFK09nTjMya09Wcjg1U1h6ODVXbmlo?=
 =?utf-8?B?eXFXYUpndUVpUjlSU2tVS0ZHcTJnNnIremhsSXpQbVNNVlFDYXhHd3QwRVE1?=
 =?utf-8?B?NGRhOWtiTC9wQi8rUWRuSEppZWFVVzBCV3lLVTFrMm83THY4RExudG44WnlW?=
 =?utf-8?B?SmczM2t4T0pSb1VINndEaHR0WDNybU5mT25mK2k5eGkzYzE4RlJEVkZlbzgv?=
 =?utf-8?B?ZlJEZmJreXpOWkxZY1UwdDJ6MmplbXJ4bHRVQWlVL25tVkVTZjlUdTEyMmg1?=
 =?utf-8?B?bExtMHYrSkwxUkUzTnovRTZkRU8vRGV1VVIwS2Z4NjRKeWNjTXBVSGJOM0RO?=
 =?utf-8?B?Nmh3WkgraFlMVkNYMnNYT2RBalQrTkVWYnQwVnNncnB4eTAwVU05Z05YUjFi?=
 =?utf-8?B?M2E4WWF2OUV5emdwckpsbDFYRWJLcWRVeWRua2NGYnJLOGkyTFJoU0wyK0Y4?=
 =?utf-8?B?ZXg5dDltbVNMcnV1Mm14OTlDVW1EbFNqa3ZscUpGZjRCU2twYzlmSXBNelZv?=
 =?utf-8?B?bVNyMkZ4bEhCcllNblZEdHR0SXRsUkRJZnRyaE12OURBMGgrUkwwSHdpRkwr?=
 =?utf-8?B?cWx2cytHNVRWZ3grTUVkSVVLUXV0Y2FsNW5INkYrR01LSzhkNTErYjJZVDFB?=
 =?utf-8?B?Z3JjN2lqUWVxWDVTWHRNU0RSY2V0NkwyZGlDam1UVzVEM2pSN3ExTklMeXAx?=
 =?utf-8?B?WFgwWTI1Q242dVpLcHNKc2ZDdUJKbVcvU3NUV1lKRVk0NzBteHIweVdDR2U5?=
 =?utf-8?B?dHh3UjNGM0Vidjlpc3FBVEk2YlRvampWYjJ6a251NWwwTVNUQkJUN1RPR1l1?=
 =?utf-8?B?NUJFOGgwblFQSVI1bVBhclVrMXAvdm0vQmJMSXlZNm1ZVmJoZFc2ZEpySHdI?=
 =?utf-8?Q?oWD28bslCoR82LANxH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b716c944-b5a2-4194-5179-08dea12bd022
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 11:31:08.3805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCudZPux8fSu99WTHbqyVtAAfmMydkhCXsxuH+nurlrBxtyVzE9MTCa2Ul69Kn6e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7346
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



On 4/23/26 03:16, Timur Kristóf wrote:
> The VCPU BO contains the actual FW at an offset, but
> it was not calculated into the VCPU BO size.
> Subtract this from the FW size to make sure there is
> no out of bounds access.
> 
> This may fix VM faults when using VCE 4.
> 
> Cc: John Olender <john.olender@gmail.com>
> Fixes: c1dc356a116c ("drm/amdgpu: add initial vce 4.0 support for vega10")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Leo can you take a look at this? VCE4 doesn't use the classic VCE FW validation any more.

So I'm not sure we have nor need that here.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/vce_v4_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> index 3309e7b8f2a2e..eaa3e05a52e59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> @@ -281,7 +281,7 @@ static int vce_v4_0_sriov_start(struct amdgpu_device *adev)
>  						mmVCE_LMI_VCPU_CACHE_64BIT_BAR2),
>  						(adev->vce.gpu_addr >> 40) & 0xff);
>  
> -		size = VCE_V4_0_FW_SIZE;
> +		size = VCE_V4_0_FW_SIZE - AMDGPU_VCE_FIRMWARE_OFFSET;
>  		MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCE, 0, mmVCE_VCPU_CACHE_SIZE0), size);
>  
>  		offset = (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) ? offset + size : 0;


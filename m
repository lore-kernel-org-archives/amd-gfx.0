Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF885C369C2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 13:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A68710E5A7;
	Tue, 22 Apr 2025 13:27:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V3wrOUyn";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3687B10E5A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 13:27:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJwfY33n0ZgTXlr9ScjEqDa0DbuZjIB3P4b63Qji0SMLV5P2Ld/Nv8ArrCiVfQAM+7/m9DRv2i/hhQS3sUqIav6+WS/qzWsI1CyKSNoE9+SyAQ9KU70Oriqm3but15wh6sSGiUahx7/of9/HUVpazhbMr4eJJ6qtfxpiNZXrS6Aim7pUFwYSx+CPPeIwEkSxBRpW9q9kW+IP+640g3fJJlkJf4L1oIRtELo4K6AwsV15XFMIi4p0gyu3JDyPWcyjcFi7r+GhUNANu6ReWULDBRkvaWQElE/cG1j2/mHl0GUR5ulpiQ3F2EvpUHf08G1Xb3zu1qmpyOn/QShJJeIz+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y22mi+oJAcg+VlV5+gn/JuJ2i6MyMeVoF6WZSW4AWSA=;
 b=QxOf9dtmv/py1BIxNSBmqRbhBqfeg5hiU7JiomIum/HqcsCA+ZPV4+F+3QvQilevTI9i6ngGuI4NqvVjz6UQoNYWQW/nsK7vHjPdZ1L0Jw9ou9rVASQW4+f8DJ0OyKSwYDT8Y63f9Asi+Z+MsQgGa6ec3ixiIn+NvUtmtTgyh4nAcgmwFZCLCVSYFFd1Kdgj3GWt7wyRlwc+cIuC1c/iQZOW9UKU2//US8wWYjBVmgDkFMqeBl+UzXWq3eUtQn657GFkzel9odY9Y3ApOGHD+pB0mOdiU/jNCxhQbSEUhAJ4IITfreVUqYF2b8S18YUagWgRrThDQ5sfe26cvi67BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y22mi+oJAcg+VlV5+gn/JuJ2i6MyMeVoF6WZSW4AWSA=;
 b=V3wrOUynzmfvg+DWd6RDNOC/Y870rIqP6V125TbQydKSwmKTMBCI+hLZhreIkFXCkEielcC9b4U0uSHR+OpGfcsUja+VbM9gJZgejC4Byzr8L0U4+l5gdnH/5N7nrz9e//Fnp+3k7m1Z30eWRSCcEskEiyNNvDP4XNlUCUYuKPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by SJ2PR12MB8652.namprd12.prod.outlook.com (2603:10b6:a03:53a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Tue, 22 Apr
 2025 13:26:57 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::7714:4f80:f3e1:60cf%5]) with mapi id 15.20.8632.025; Tue, 22 Apr 2025
 13:26:57 +0000
Subject: Re: [PATCH 2/3] drm/amdgpu: set the evf name to identify the userq
 case
To: Prike Liang <Prike.Liang@amd.com>
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20250422132352.3988185-1-Prike.Liang@amd.com>
 <20250422132352.3988185-2-Prike.Liang@amd.com>
From: "Yadav, Arvind" <arvyadav@amd.com>
Message-ID: <693bafbe-5134-cf48-1e19-e47bb12ddd4f@amd.com>
Date: Tue, 22 Apr 2025 18:56:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20250422132352.3988185-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PN3PR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::9) To BN9PR12MB5052.namprd12.prod.outlook.com
 (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5052:EE_|SJ2PR12MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: 2499ae0a-3d6a-45be-078d-08dd81a15af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXpHTnFPSHZLSkc0MWJxQXo5OSs2SnZmbHFDRHBnRGVUeFk0cjQ3UEVDWFJJ?=
 =?utf-8?B?NHo0OTRDVHdwMEtheTdBV2taNXRKVHlQUmMvNms3TGRBZWRuYjZSZkdsUzdx?=
 =?utf-8?B?dUdjRXpDVlRNOUVEZENEQ3ZNMUNHV0dLSXFpRjFlcUhSMTBQTUFHS3M4dm1u?=
 =?utf-8?B?VWVqVjUveWVySWJiSGtHNlZBelVLK2RlZWpJZlZXNS91ckpXRkxlUURCTVZR?=
 =?utf-8?B?Q3ZBQ1hkVnNSeWp4VWpVTm52akZrdVVFT0MyNHIrVUI2c3BRSkZ0QmZEaWpS?=
 =?utf-8?B?SUwwSXpzUlhEa0lnSktHeDNVeGppa2FXd2F4NitrcU9obzFycU41TEhiTlpL?=
 =?utf-8?B?c2tXSno2RjVnWmpmWTloamR6UmpaWjFXbTdiMzlzdDNCOUY0U0wxejJ5WGM2?=
 =?utf-8?B?Z2tHRHowdEt2UXJIUVk3K0w5ODNBNy8xb01vNXlTT2pKWUxBeEZ1SXlURUU1?=
 =?utf-8?B?Qnprc0JYb1hSQ3J3OUlnZFEvYlpVVGxEQkUxMm9KTVdSVmJ0T1J2TExtNVIr?=
 =?utf-8?B?QWJTbXNjUEdRZjVzM3dHZGs5ZDhBQlVhQVgxSVhOQzFqV3NBSXBFSkk3aWNl?=
 =?utf-8?B?eGJhNnZkUWNlekJBdmMrbThQL1ZsUUZtdU42Ujdvd1ZvK1ZpWCs5aDIrZGVo?=
 =?utf-8?B?blFXd3EzeXB1VnhKZkpvdncrd2J2ZjhkTnMxMkpiczZqTzNGcFNFRUxpcXRM?=
 =?utf-8?B?b1cwUHowNTZnNG5JeWMwMjIyN213ZXBZTGdzckRpWGRHVGxCWVQ2Njdkend2?=
 =?utf-8?B?Q05hUU5rRHhMWk9OcksyZHRLM3hWSHBnaUlwNzFQOUVLQzlwVTlKMmkzTGpz?=
 =?utf-8?B?clRXTWk5eVkvK2hnV2ZKT2NsVHZ2cUNmdllyRld5MDRPcGRmYkVFWm9Hckgx?=
 =?utf-8?B?NUhmNUNwOUwwdmw3WENZYXMyR21SUStqRXZTTFNqUTNlSXBPUW5VMTAxcW9Z?=
 =?utf-8?B?dHArMCt5M1FNVEFINEpxZFdmVEYrcUVISW5SREdER0cya3ExbCtTSGhSU2ZX?=
 =?utf-8?B?VmhPczhabEgvNlVBd25jVE9pbm1jS0dCYVJpY1FESkRzdDJLZTJHSEYrWHU3?=
 =?utf-8?B?cDU4bVNibXUzb3pUSFpSSjJHZEJha1QwdzhKS041ZTA1ZmVJdEowbGQ5NlRD?=
 =?utf-8?B?RzJvT2paaXpGZTBJSUIreFh6VEVnTEFoYk1ObHVKa2tnN01LeVN4L01JM1E2?=
 =?utf-8?B?OXZYdnc1L09wYSs5MnhLdEhLYm5LUVJaUVBQTTFQUFJ0QWZ5SkNBV3FuRHJW?=
 =?utf-8?B?OFUwQmxzeld4YklEMUF5YWdMa0plRStESm00bDR3SGJZWU1zUUVnRUFCRDFW?=
 =?utf-8?B?TVUxWHJ1eGxKZ2RBZzhyWktlRFJHVlEyTFdhcUZBRUlMcmJQaUZ3dmp5VkN4?=
 =?utf-8?B?cUpFeEdCL3dkMXkxUityZDdkMUZrWkdFTmNncWh2TDJZcjVKS3gvb2JDMEVK?=
 =?utf-8?B?dGxFeDRVdTdUcGFhRWNzNmtKSXpFL2pFWWZWYzd2dkRhVGlmdE9PaUp3RHRw?=
 =?utf-8?B?cTgrWXdsdEhMMTJKTFR6QWlnZnR6eVVFQ0NJRDRqWklQdUhBYUFWbkN6Z1Nz?=
 =?utf-8?B?YThURDFqWVNva1ZJQ0lIUllRditpbFZVWktYdVFzeTE3cW83alRWL0IxMnZT?=
 =?utf-8?B?NERiQmZQTDAxaFAxQ2p1Zk1XMHgvYmxES2JMUlR4WVZqanA5QXB2REZDMHg3?=
 =?utf-8?B?ZHpTa1d1a3FUS2RxR0NzMGZva05SV0VvMGh5Yk5XdWplQU5WVUh6NVErV1ZR?=
 =?utf-8?B?UU11NzJYU0RqOGV4ZFJEQlhLU1JpNEw4WDhnY3dpbitHUjN1MXNncnY3eXVD?=
 =?utf-8?B?ZGh6VFcwS2N2c0tQdmNvTWI3dUJYVkVGOU1WbGYrWEtiOXdhL1lYbDlHK3Aw?=
 =?utf-8?B?SHZmWmVST3lzVldZMWRxcXJUZkVvRjk5bUhaa09OWGx1anhJYUlRUTlld2VD?=
 =?utf-8?Q?b754fPCarlU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5052.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFU2eFM3RVlrOWVVV0g0Tk1BT24yOVFrSmlVQ1EzdFpRZ09seUltcUlUeDBm?=
 =?utf-8?B?eFc5bW81dVJ4dmRDazJLSm1UZFNPeTMxZ3NjQ0x2Z093OFJLOVpYaHJpMEJy?=
 =?utf-8?B?Uk9xd0xNM2x4bjcyV1lrSk1CK3FmT3llRnY2ekEwZHpDUk0zUlhla0l6SU1t?=
 =?utf-8?B?TkRaa2FqY1ozSTVaaENMSnlQb1B6MGRaVmdpSHRwVVNzN0NqaE9TNjlUQmJr?=
 =?utf-8?B?WnNWWWczdFUwSFRWUG5FUmFhOFltTEd1T0U2MnY4NVpkeXBERUNLL3dzRTZK?=
 =?utf-8?B?TEpERFZYQ1M0blBHZU5tYkdKTFFGRWtSQU1vNllsRnVBWDFRbU41cnRvSE83?=
 =?utf-8?B?ZmgzMUNjTnFXMmZZWlVhVzR5Nlk5NHZ1L3ZzU3puN25hSGI5TGI0N1ZVaXcr?=
 =?utf-8?B?V3JRSWtycFVsRjUyVjZoWkVwQXVUWjJhbkxnUForcXp4SUJJN3pKMERKczB1?=
 =?utf-8?B?b3ZvR1RxM1FrRnFPMVNCbUZsUzRET2JoUm44ckxpUTdMZ1NOcVprN3hVY3lZ?=
 =?utf-8?B?NlkxVG9RVGN4UGdkMTlRV1NXR2pXQnNxVzEwc2VkU2c0UEszc0xvMEp3S3Fp?=
 =?utf-8?B?OVVuc20xbDRlOTlDWmRPdTFxTmFFRGdMc0ZGSkprQVBldldtQmdxUjhXUTdB?=
 =?utf-8?B?b2lLcktkejNpSzVINFdnZEhuU3RsNVVjYXFuUWxPLzNsQWNXSE03Z2NtVEw2?=
 =?utf-8?B?M0FUNC8va1J6bE1DRGlONTBTc2JBZVhkWExYSkVaaHd6N3lVVVBoTHo1US9l?=
 =?utf-8?B?VytJUk5CRGp1MllzVHJURHpaUjkxcC9hTUhGQlJ1MTN3M1pDVDlqVWVKNVlt?=
 =?utf-8?B?WFdINHdmS0lSNWN1Y1dwWDllTnE3QjErekRLQ280QzNaeWFzbENvSmZ2dVBr?=
 =?utf-8?B?K1M3VkNud01YQXpiWXRXakc5YnBYWUkyMlFpWGw1QkhZWHJ1b2RhcWJlUXhH?=
 =?utf-8?B?WDR6KzhCRXAzRXdtZGlDV3ZVblNMWmFXd1ZmRVlSajA2RENJbHA0UzFyMkI3?=
 =?utf-8?B?ekQ5dHl6YVEvYSt0YVV6cldnQ21LbWt5K0doa2lVV0owejFtYnFiMkgwb2FC?=
 =?utf-8?B?ZGU3QlhFdmEzb3BCeTNpQkw1cVJ3eGtnelhlUDhqZ0ErZmlBVDIxb2t2b3No?=
 =?utf-8?B?N3I1Y3ZUaWdURDZhQk04ZGtpbXI1ZzkyRDBKaXR3YXE1cktJQlBtZklwL2xX?=
 =?utf-8?B?NmxLTE9UOW1XdVJYd1I1VXJyNjFyRWUxRSt4a1B4QVczbHArTElKTVF5YnNO?=
 =?utf-8?B?aHVXeG9oZEtRSUp5STY4MG42YkZoU3d5RmY2clZVYndma2psdEZiazBFazBz?=
 =?utf-8?B?ZVVod2M1ZXJFZ0djTHRaVWgwWTk2Nm5Kemh6UHRiZXRsOVVLTnY4ZGI4OFB5?=
 =?utf-8?B?cjJvQzE1NHZ2cXU2UmtPK1NVaUFEQ05ZK0lxTTgvWVJCRzNVc2Y3ZnVuUWtV?=
 =?utf-8?B?bVFzc2RvT0RMTkd5MTJFN0svb1daTFhqb2hIaWNjV0N6SGtrYVpkeDkwZzh3?=
 =?utf-8?B?VWx2RE9JZ25qSE95WGtQcGxONDhueGEyQmt1OTVMVFh3S1doTlJKb0g0aCs4?=
 =?utf-8?B?NEEyZ29NWHY3VHJDL3RDVUxWR2F0OHVmZi81Qi9hVG1HRGtScC9IcldYRHhz?=
 =?utf-8?B?blhtYU1CM25HNnBhTG5uQjNRcEg5a2pWMFhBQ0pTQzVJTTNMdkt3cmNRYmN3?=
 =?utf-8?B?dngxNnVMT01mVmgrSXIzWjJvZHYyUXVkTWdVSEdaT0kxOTJVbFNOVnFuSXNE?=
 =?utf-8?B?K3VUSDJ2VGpaWThNVTY3YTFUOElhVUNxV01LbjJsQ0J4UDd4Sk9lY3loK3p6?=
 =?utf-8?B?ZzI5S0VSaGMrU3VzbVZaK3FPYUFjVzhOYkcrekVJci9GckdqY2dMbmN5RXdU?=
 =?utf-8?B?dFlRbGhmS28xSlNSZG9weDVCelBHRjZ2bTlnZ0F3ZVA0SmFiZk04V05XeC9S?=
 =?utf-8?B?WGx4em5OSzVmOFVoYjNzbTNGYmdoRHByRGorOTZaSngvMGIwRWRwWktxSTZU?=
 =?utf-8?B?am9xMmFHNkwxclpmNmttS2w3U1hJa09hQkY0SWJZNHFBZlM3OWxaU2tFNVI2?=
 =?utf-8?B?WEVlbUFGYW94dWpobHBiWm5nQnFvcGI5TENBM3BTVmc4K3NXRFI5djdRSmtE?=
 =?utf-8?Q?h6gHiU4JcQTgq/C2LOLCkK2d5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2499ae0a-3d6a-45be-078d-08dd81a15af5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 13:26:57.3529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtxoacYckzDxAFqxxxb+8wrVh0HADM4Rw7+0YDVMHhao/8PhAmqyFyMMU2UBE/vOjkc4ry7F/iwhGUGjqpnFTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8652
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

Reviewed-by: Arvind Yadav <Arvind.Yadav@amd.com>

On 4/22/2025 6:53 PM, Prike Liang wrote:
> The evf fence name can clearly identify the userq usage.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 0075469550b0..610f447ede9b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -31,7 +31,7 @@
>   static const char *
>   amdgpu_eviction_fence_get_driver_name(struct dma_fence *fence)
>   {
> -	return "amdgpu";
> +	return "amdgpu_eviction_fence";
>   }
>   
>   static const char *

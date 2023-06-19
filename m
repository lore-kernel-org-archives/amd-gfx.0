Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9CEEB64D9
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jun 2023 22:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A14E710E15D;
	Mon, 19 Jun 2023 22:28:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 536C210E15D
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jun 2023 22:28:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhaDOCzQSoylA5zPhLZXRd5KCb4m+YQYI3gaCVw2bEpk66htzo2ti3EPoCzcDABDRPjmFneNiRyuecruuFhbFkldncGDEKFPdadaSXfQaFvvEMQwQLjW01dkah3iD1we6AzJQXCakBn8yi8PMXXY3XeIHy1g1ad1cH2fAm4/IByd0FZXd8mTj4Y0qRQ3wfzWWLpD23p9YBBC4caKWrCvUMaBFbvIXdlAxN2wi2bhKeQV5UBlrIP20NC5BaOJo1Sqj/fpZbEVdW0IgdpZEwKKJr2kHex5bRNt+nYxnsBVPe92lbtfPbBv12lJJo1OqpwhL4DC5i7fqYbslt2aZOpRMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/n5p6Pp9JWJhitN3uQixo3ZtgldGvuPpSUTVpCT1szc=;
 b=U/fxEf/MjFG5++e9wa/5dJOQfLTSUm5A/+DUpJP1fXz68YxekKvodrbs+4OJ1OSTostTyOIa1581iC4GlmbGiIQYaz9/hFtwZtBaFNMJ8CmUU8k8HTzVs2lOeHIliU/RbUA3tke/LNzNIuOWS3yNNTHLZIJdr0tfdcH/iGCwILYO2HbAQj2YRfT/Bx2UX4CIMkY5BG8FEIP1mcjoL6VXaHEarGus/tTki1GonH3RgeGWXtdIJ9zdmHjirHTSubOFeXSJZigQMVBOUfI7x3RSPEgqS6dGgUZ92/z31OFr+jzQfMyL2lm9R9l4XWbR4ccIG02nJ4berwoPexIdMNLr+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/n5p6Pp9JWJhitN3uQixo3ZtgldGvuPpSUTVpCT1szc=;
 b=duCsHlEkKPPYZeX4KBfBoK0+VHXa/dl5A3f682SJ1MFllpMBF/k97gd8Nm5iV7tAdy3SGMfOtGgkIOu8ZYFEUtr5Oaaiq0zDsWJQBAEVMHoSIm+7cliD+orzYbdEVlZjcUs3J9yGOrQ923wL0lZ8WeQdKKEh2YUF8ZEuqn/g9cI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 22:28:17 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 22:28:17 +0000
Message-ID: <5da84961-fae0-0f3f-3912-f8bc7cb62319@amd.com>
Date: Mon, 19 Jun 2023 18:28:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: remove vm sanity check from
 amdgpu_vm_make_compute
Content-Language: en-US
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230619212827.54893-1-xiaogang.chen@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230619212827.54893-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0092.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::25) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH0PR12MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: 450d7ef5-bbe3-4b7c-da9c-08db71147a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hHZVEvPBosLCzhV+dPrqoep2AH+GN2tP9pG8Nj/fBEpsDCfsiLKnGB4+pgHMpW+qQP6uHflq5pNqQaMUGHESuVQki/PAJDDvUf8rv7sqwpR8EWki5RgTbxavyULYrRfWzIMh4/ceGnJsJ2XFtWZTQmJV37RhXikBlzWeI5SfmA/qjKGgvus3Cf4ZF38qckHvL/izOXpKTXpHT9JwmcHdfxwDPqVxNLgV4lK0E3mPcWXSoqCdmtFyQ6AEiAZXC+FWGeiMjStFVdHeYQHzaj8v931t7qeKGO8s264LgBfUa66X6FjK8pqHrGTTJUbvaowP/v0fRQELb6PXiv0JuvHzEQPGA3WCPP0PI+D83xxXoQ+4QD7AGa74qDeodRPuzzMXmNI3vvfCr02MVKRlXSKdsOXRxWX0UMFtdowzgPPm4NygGNfreqv5H3KZ1FI7l8/InhHjfVytE8brrvXzFWjjncKFcFpkcV4tycGN7e6C4nrjRiAOunrEoF9y8yTT6lzSOWai/YGkR4Sz4OgA2ydX6QpkTq3Y46JPddKYPKo5yhKnAGxRGoinKyKhAuxsU/ju9GxBkxjE1VXogX9M/nrSZui23R7F4/O+eVTj3QRrQRbA+Cxb3A1UZGDD9PDBNjRF+fdc9ExKCFlCrpXJPKVAlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199021)(186003)(478600001)(36916002)(6486002)(31696002)(86362001)(53546011)(6506007)(6512007)(26005)(31686004)(2616005)(316002)(38100700002)(83380400001)(66946007)(66556008)(66476007)(8676002)(8936002)(5660300002)(44832011)(2906002)(41300700001)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXZFTTFMNGU1ekFkYzI5elpNTkdCRWp3S2FNTHlHbHNZV2NhaklnQVhNMEFj?=
 =?utf-8?B?VVgremt4U1plcHVBRm5CWm5WSFFURGY0UnhoQ3RGUDJKN3B5ckNDOGlpbDlt?=
 =?utf-8?B?OHRaemQrU0NPeXlyeU1xTnBJbWpNOHFRSmlJVFU3RkhJTDRaMGNlOHFaSHRk?=
 =?utf-8?B?TUowbmFNSzg1UlFkbGZSYWVGdmlyRmF4dVd4ajBkZ1U3NGVmR3pGSnFFMkVq?=
 =?utf-8?B?eDFJcU82clFBdzlvelpCaFBiNlQxaHIrOGRCVXM2UVJSTXU3TlF2T0pXYXRI?=
 =?utf-8?B?RFo5bFAxc2NpdzBVU29UZFpnMk5tZy9ZZ29tY1FqZ0tyYVBSUXp4TWlJWDU0?=
 =?utf-8?B?eGJYaU55akkzeGR5T3NoVWdiTWg2WWkySHozcyt1SXpVUUJybEFZUTJQVUJo?=
 =?utf-8?B?L0hzZUpLM3Z4MHBCQTVZRkZFaGlGRENEV3orOXVuRTBmbzVZK2gwQXRjalpD?=
 =?utf-8?B?KzlwRk9aNGFlbGR4ZXQ3c2pXS2lZZWdsYU5ySW96Mmo2Rmwydy96TU8xVTN2?=
 =?utf-8?B?cCtwcERYazI2VmtjT0dmMC9pd3dwS29SVnBqNGVuMWJTbUxNQ3VkdURvdHlS?=
 =?utf-8?B?ekNEQWVncmZQRzg2WHVvQVhwZkFadFE5UXdWbjB5R05JajF4N21rZXVvMnQ5?=
 =?utf-8?B?YW94VDlyNGhXLzRRWkYvOGtDZXRoRVRsZUQyd2tnYVp2YkErVU9qa1VXWXYw?=
 =?utf-8?B?c1VBd0FyUXFqR1cwWHpJbUFvQjMxUjl6T0ZvRDlSTW9BU2NtRXNIcEhtLzQ3?=
 =?utf-8?B?bFRzZm1PWVprOVA3UmJjRVhIak1ESzc5WDNnbStxanN5SFI4T1lUU0dtTE8v?=
 =?utf-8?B?TzVPbnkyTTJWekZpVWYzQnplV0d1dlF5SGhVU3dOa0R2WDF0aE5XUisxK2wy?=
 =?utf-8?B?SVF1T25LSkt3U0R1MWdJM1VZR05ybElHR3BRSGh5dGg3eHJyTG9xRWsraHQx?=
 =?utf-8?B?QmRKNVNNVUlvUTdUUTBHWjhEMVZjVTlyS3k4K3JBY1NGcjd5ODBobzV3MlhT?=
 =?utf-8?B?eW9mbVVqTGZkbDQ0QXNQS3ppNnFPMnlpVGV4MTYzQ2QwV0FvZkE1R0tOaXNa?=
 =?utf-8?B?RUwxYUsrRWx6MGEwUjVxcHZmaktkN1dHRnJSY25DTHl4V3BJckNyendkSktr?=
 =?utf-8?B?dFBVOGg1ZXdlcHN1QnhXWk9RWHAvUzdET2x5Rm10bERGdXdiSUoxRFBRUjdk?=
 =?utf-8?B?cnZOWkRHRzZ6RDhlNVYyUmxNNGFwb2dJcHFsYkh1NzJCRWNHalQyOFRWb1kr?=
 =?utf-8?B?UXNlbUpqRVBUT1ZvS1d1bjVrMGlJQm1uQnZRdFJtTVNHaTAyOHFQRkhJb2wr?=
 =?utf-8?B?WmZSYTBGVG5OWnNobGpaOTdxZ0dZQ3A2ZTlQUUIyNzhYV3ZzY2tGSElyV1dj?=
 =?utf-8?B?eVhBdmVpTXpFYnhGd3BISGhPQTNOZ2VmTDdTZEw1eFpYaUcxQXhDTVV2MEtT?=
 =?utf-8?B?RGdzVEJzVFpzTkxlZzdMY3Y3R2N6NmpsRnRYYUpsamhSWjVLSmlzREpuMUJJ?=
 =?utf-8?B?UWN5TEFNNVZzN3NlWWhaRnYxNWFFZ1lyOGlGdDM5b0NyVkMybndPbTNMNUhr?=
 =?utf-8?B?Y3FpbzBiU1ZOSU5WTWY3bHhDd1ZySmNMR29kOUdnSWxsT2lvb3VmQkFXaHlL?=
 =?utf-8?B?K3dTdERyN1RtcCtRV0k0Y2lhb0hxSkcwUjlmYnVkcFloWERSQ0orTi9kWDRO?=
 =?utf-8?B?a2JsK2x5OVdKTFUxV2NudWYwWXdwVlI5ckQ3L1phM0NZaDVoaTZlZm9PM1Ix?=
 =?utf-8?B?NmZtaFk3VjNFRGFra3V2OC96ZXlDZnNkV1l2ZlZQcHFJRnQxK1FwREtxRTdp?=
 =?utf-8?B?Ukwyc3VRcW1wUXFpS0JlOVpCOHBDZVRXTWtuWHk2TFRGbGozeTExMWgvVVBQ?=
 =?utf-8?B?bzh5WE04SXIwam9nTk5QTXIvQlNpRGh2eFpzNyttWlVMUExUUzcxS0J6UE5w?=
 =?utf-8?B?bjdYajlxcDZPUGRkZVhRdmF6LzhjekkxRVZWbStkNk90LzlyeGthU28waThS?=
 =?utf-8?B?VGY1aFhFZWc5eFRDd2VYR05iWnFSODZKRnBsN3dySVIvOGxWL1dIMURzbjJR?=
 =?utf-8?B?R2hrUlEyQWlGWms4QWpuRjB1S0JubTlET0IrU1hrYTRBQW05V011cU9Cc1dm?=
 =?utf-8?Q?hi0CQhpXjrUaM+Z8J78nU7fhC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450d7ef5-bbe3-4b7c-da9c-08db71147a87
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 22:28:17.3504 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BMImx6Krvjim0p1NHHcEJeHdfbXUT1+QniW2TeehzYFftYvQ1WyY+EFwcswZ4yOMj9P4QgV2r84+akItDYX5IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5156
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

On 2023-06-19 17:28, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> Since we allow kfd and graphic operate on same GPU VM to have interoperation
> between them GPU VM may have been used by graphic vm operations before kfd turns
> a GPU VM into a compute VM. Remove vm clean checking at amdgpu_vm_make_compute.
>
> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

As discussed, we can follow this up with a change that enables ATS for 
graphics VMs as well, so we don't need to enable ATS in 
amdgpu_vm_make_compute. This would improve interop for Raven. We only 
enable ATS for the lower half of the address space, so it should not 
affect graphics client that use the upper half.

Thanks,
   Felix


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index eff73c428b12..291977b93b1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2245,16 +2245,16 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>   	if (r)
>   		return r;
>   
> -	/* Sanity checks */
> -	if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {
> -		r = -EINVAL;
> -		goto unreserve_bo;
> -	}
> -
>   	/* Check if PD needs to be reinitialized and do it before
>   	 * changing any other state, in case it fails.
>   	 */
>   	if (pte_support_ats != vm->pte_support_ats) {
> +		/* Sanity checks */
> +		if (!amdgpu_vm_pt_is_root_clean(adev, vm)) {
> +			r = -EINVAL;
> +			goto unreserve_bo;
> +		}
> +
>   		vm->pte_support_ats = pte_support_ats;
>   		r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo),
>   				       false);

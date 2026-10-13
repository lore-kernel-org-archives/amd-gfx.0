Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4657DCC6B0E
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 14:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFEEC10E896;
	Tue, 13 Oct 2026 14:58:43 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010017.outbound.protection.outlook.com
 [52.101.193.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E546A10E896
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 14:58:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6ofYPIK1O2GQRixb3LT6r/Ty971T38kSIRtFEMMjqWw7Lr+G15cmlyCuKll6nF988YDLVlTnwWAh1DgC89ABDIROjdkYqnAHPR5vOmXppXvVjbBO2sXH+I4/JydnzLXYJPJFh9OhkFoeObsFHr2QPyUwFGc/yaR9jKgdc9r0TVcgo4tFAurt0gjg7mckEEmmvK8CcBSWpnb3xy5njjCWbFHgI0UW5PqEAxfaz3p2DGTbSzmh/L3SDtf0JHNzw6pzyP7vyB+l+hw54yw3nS1pPeyP6DuzmnH2mt0elGT5bevXTMRQDp2r8zYlDGTrKn1OK+MfKmup0ORl1Iub2K8oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtGBhJLgl65xdS6LLL7Fe0sG+PU1TFknNcdVXaNdw88=;
 b=NcaoWg2m+jY9qnU0+OjEVb3gEB0ZjLF1GTLoeN6fvCHBT5cWmmGvuT/qoHLKBhjw8CNRWgVn2LD+BY+rlEqHCgw1KM+pOY6jDVRXvVMXcK1kz6VmyxS549rhuGrorRHfN3RmEnY32BZXNXOwbDPZsfD2hX46Do/P3o5HoHCMAl9+678AZBFYdvFqevBb2K2ACy3h7Sv5zQ4iC0M6MmELOE2IIKxaj4hVZ/rh9zYOPcY3dDXBLCBtIryQk8j6kwXAY0S7jPPDmMfm1uFnqZbuQxwKKIBYY7vZuBr8qcm+ynSf9+9M41H0LvN/4Ui/r3It91UeYmTNw+XDH+8EuAY2iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtGBhJLgl65xdS6LLL7Fe0sG+PU1TFknNcdVXaNdw88=;
 b=Vn6n/OU7K4ptCWIMKMV5MRz3xQ1vYOLNmBdpk1yFtfijNSsVBn+NjnLi2GHpzf9ykJeoJWbIrE1QtqMtKqbSV82C2/h3hZiXWQPlZK6/AP4MxMRWgMvRwNt6X5+PIYA4igE9jklg5khkLTkLK1qNwPc7j7deR24tRMrd42ZSwu0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 14:58:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 14:58:28 +0000
Message-ID: <2d2129a2-dd7e-42d1-abd9-dd63faa6efc8@amd.com>
Date: Tue, 13 Oct 2026 16:58:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/evf: skip BOs no longer in the VM
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
References: <20261013141357.1907194-1-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261013141357.1907194-1-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:208:23d::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA0PR12MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: 10bad218-9cdc-4e47-57ab-08df293a70c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: uqD/kfRdr3Tf9cMmV1in30z2vVlfyAm18uN3BF6u8hvQsMCAr1O0aIlXr/FoH/iXs0ZmDykj5sKGpxUaDGo8kdb7ZrnVUnXy6yZNwU6MEsieGxqabFC+neM/YHf7vlfiU1tlqn12fQM+OiknMZ3Zye3araxfbH7/XBlDXH0gGlegYOkElt89DYRCFB+Nr8rQyk4VSLlNtGD53R58e04hWr6PaQ/ieQNAKpNbes2pYgz5dRT+4l34yJm53rZbMREGp6gPwL0+c1Y8s309Imn8Nrv7mqFSEgZZFoVbwDQF/VKmHn2GO9+Zk7eyYYpguhwoYvun/zJ9B0CnztMNOgkEtDFCKCU4m58WfJKsgcgFzSA46wdN+oKde/VgLEty3h4ocwzCkrMlUkvGN+nZQiv0id2mPUDYh+goyI6gIemy3JNDwWr7ii5cBVNuQnJ9VbE5SmQGIjINohKUty05DMqe2CXrpc70W09xLZwhtvmsd7NFQt6Gx2b7LA6pV840/pjUJKnSf8IHDlx0FXHtDbk3v2+WSn22gEs84JOLPGb58C314KawjceaZ37ZHzziFuPsrav7tj/c0amlyL/eR7Zgd4zXw/WsBPxziKFCnbJY8lCC4jbFBq2ayTfICNBlea874SsPXaZYZSucOqHiMo2F78ZX/3Ggg5mf19u4SYCQhzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekd2a1ZXMTBnaEdkbDgwNEhwR1JkTnFyRGZNQzBST3ZjVW1ZMDE2VXF5cHBY?=
 =?utf-8?B?YlplU25UWUFEcTRrR0ZVQjhCNEhNK0tiZ2FVQ2lBNlZRdllhbUxsVFlzYzkz?=
 =?utf-8?B?V3hyU1pSM1ZOclUrWitkY0VDcjBXZ3MrNisxRkdROXpDVUJoV1FENjBzUE1G?=
 =?utf-8?B?MUQwVDU1TXhYdUFLckxzWTd1VFFOOHRHMHFlWjMycXhJeEtJaG5zcjZPbVZP?=
 =?utf-8?B?dVY3NlB6cFlzb0JnMzBJOWJacTVCQkJiSmpROXc5VU5JdHZWZnhOVDBZL1JT?=
 =?utf-8?B?TGFhZ2pWQ3FQNUJNS3JwV3cvMU1SR2tqVHJIelhxaktucmVqYkxNd3F5WUI3?=
 =?utf-8?B?MEdLU09VQkh3disxNjFaNnBwb2pCY1VOUzBpak9jdGl0OHFjc2UxaitHeXQw?=
 =?utf-8?B?endobHM1ckt5cnlvcXVjcC9DTmp6NFgzUEs4SHFwRzA3NlVYbHM0YVJFR3JG?=
 =?utf-8?B?Yi9wZjhUSDB2OU5hWkpVZGFOUmtoK0pPYm5ITDB5Y2JNMU1xdEdlUiszWXY4?=
 =?utf-8?B?MzA5S2JSWmM2eHZWdTFHelk4V0JmMllFc2xVd2pIYnRkbUlZYS9KVUVTTWkz?=
 =?utf-8?B?VkVVZ1RlVTIrTTVhMFQyTWVhZUVkSnpFMDMvdVNRdFhNakpHbnEwOHdaa1Vu?=
 =?utf-8?B?T21tTlBSbjRCTE1OdW4xbXBjaFdNWmZLRHJzTmFHMVJGak4zK01RM04wTFhE?=
 =?utf-8?B?ejNLYUxwMVRYY281N2hwd0xTZjhUeGY0MHNMSmFabFRhRldVREVyUmNaYlMw?=
 =?utf-8?B?ckF4c0FYcm5ZNURpT3JRKzdtd1pxRy9haHYrMkhOTlhwUmFPOTB1ZW5OUGE5?=
 =?utf-8?B?ZUQ3bDVmbWc0K1RjbThVdGRxNWNmRUxWVzU4OWpVQ1VlUzhMSGlBWWI5RFlT?=
 =?utf-8?B?M0FrYXRXVlpmLzdmV2Z2MmRXUUhXOVoyeFp0RXVWeGtvRm5uV25jVi9KWWg4?=
 =?utf-8?B?Y2doQTZmUHNPZFNzUjBGbGVDdHVZc2R6Z2k4RmNpbHR2bCthSGdwS3ZlNHdJ?=
 =?utf-8?B?bittNkh6M0tVTE9pUGJnb0NYODRFK0dYbGdVbXdaTUt0OE1FeDJ4QUVDQzdp?=
 =?utf-8?B?V2NwQXVlQ3lpUHVGWEdIZ2lPSEMyZTl5SjRkVW00ZzdGYVl2Z2oyZXM3N1Yw?=
 =?utf-8?B?d01OdEc3RHhmZ3pKTmJJQUlseEhpa1JRWHhiY2tIRGN6MmZlM0Rva2FBMmFi?=
 =?utf-8?B?RkNHMkV3TVJYRjBGcFNNNGNGUDFvcGZaalNFcVlXSFdJKzlQMVB5VzhiTE9q?=
 =?utf-8?B?cjdaMy9BQzBMc0lndGF4RzA0RnUxYXVFSE1xdE1lUTNFcS9jTisxQS9ZNDc3?=
 =?utf-8?B?WmUzUkQ2UFNmK0NseWIvNElMaWdISlVRRGhlM2Z3MzdxblI0L1hlczlsQUo2?=
 =?utf-8?B?eFMzV1ZZWWZCTFZyY1B0bmhtTi9JRWhlM0N2OERWNDJSQ2NZRkxnRlNiU0Fh?=
 =?utf-8?B?YXI4bTcvcnZ0UEwvaUZpR2thYzVZTlJmK0t3d0tQbENhNmNMVmhNQnN3Qll4?=
 =?utf-8?B?SlJWVStJMXBpUmdDc3liVlJkN1krQmxXakphVzlwQ0dCUjgxMDhFcDVJZVQz?=
 =?utf-8?B?azFHSGtkaG1LVGVtZDRhNk12bjNiTGlycDZ6RUpKUUxOcG1HMWUrdklDcUdx?=
 =?utf-8?B?VUllVlVZL0xWK04yMzFIN2pRY2x4TldhSHNmM3VRZ2dzdWNPRjRhZDlnN2pU?=
 =?utf-8?B?Zm1tbmJxWUtZc3ozTDdwT2RDVDZnTlppZktXKzY0RE00UEVtOGQ0cVltTDMw?=
 =?utf-8?B?aVRJVUtXekgzU04rS0J6R01DNnZNcUpCZ0lIVWtEL05NVGQwS0kwREFxaVFh?=
 =?utf-8?B?WUxiSFZPRUE4RXJBdWoxS3RXNzAwb3NoZDM1MFpSZE5wRVVObXdPQVVEZmFG?=
 =?utf-8?B?STNib1FReS9KdHVoYlBGMlZCM2F4RkdRdEdEaFB5eStKYWdrTEUrRkVJRlBH?=
 =?utf-8?B?dzNCKzYwR1BqNEs0azhTdW5hWEtZTDl0WEIreFNmbTgrZnM5RGdQS2RkSzdh?=
 =?utf-8?B?TVJXYkhQTUwyOWVzeGJCOE9ybm80amQrZlJVRUhCYWdxNWNSUEU0QkxYRXc1?=
 =?utf-8?B?NkpicDQvYVR0Q3FGc0NaeXBBaktsbmdMNXdsQzBVSkhrRGJwbkQ1NGp6Rkps?=
 =?utf-8?B?MW5pdlhkbGRTdTZKVnVoazNJMmNsN2xFMHNUdElkYUwzR3FpQXE5ZVhSc1lY?=
 =?utf-8?B?WlR4YUc0VWtQZ0dlbHlMeWZhS2JkK2Mya3lRL3NaRHBpT2k4c1ZhWFEzQ3dT?=
 =?utf-8?B?ajdYYnlwWW8wN3pucUsvRS9vdXpBajdyZ2ZuN1Myd2krY1VidTc0R28vWUhV?=
 =?utf-8?Q?iGFhShvoi/HqSrmzvx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10bad218-9cdc-4e47-57ab-08df293a70c0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 14:58:28.8497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPhiSOSuchEyq8SDDGgbkIxDZVAaIFCUdSswTaFT7GsGxlNqf1RupWLVygQBbAfs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7650
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

On 10/13/26 16:13, Benjamin Cheng wrote:
> If the eviction fence restore gets triggered while a BO unmap is
> happening, the attempt to lock the BO for restore will fail. On retry,
> drm_exec locks the contended BO first, but it is not actually required
> to be locked, and the eviction fence should not be attached to such a
> BO.
> 
> If the BO was freed, this extra lock will cause BUG_ON to fire in
> dma_resv_add_fence, since the gem object and its resv lists are freed
> already.
> 
> drm_exec::prelocked remains set only if the object was locked on retry
> but not actually requested to be locked, so use that to detect this
> case and skip it.

Vitaly and I already found the real root cause for this and I'm about to push the fix to amd-staging-drm-next.

Regards,
Christian.

> 
> Fixes: 2cd7284ba54b ("drm/amdgpu: completely rework eviction fence handling v2")
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index a0802012de49..1e119173564b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -145,6 +145,10 @@ int amdgpu_evf_mgr_rearm(struct amdgpu_eviction_fence_mgr *evf_mgr,
>  	/* And add it to all existing BOs */
>  	drm_exec_for_each_locked_object(exec, index, obj) {
>  		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
> +		/* A BO may be locked after it has been dropped from the VM due
> +		 * to how drm_exec treats contention. */
> +		if (obj == exec->prelocked)
> +			continue;
>  
>  		amdgpu_evf_mgr_attach_fence(evf_mgr, bo);
>  	}


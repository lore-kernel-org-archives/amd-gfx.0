Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CDA606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=agLsNwns
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 869F610E10C;
	Mon, 26 Oct 2026 17:00:26 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6634D10E1DF
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 17:00:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsBEtStiVuzF7BKNRrB6jSbGwVCr3zTpZQksOPsAYE9O3YqpO0g5WTGEN5rsPrrByZdGq4+ofzEuYEV+AY3dY0lC2MQzmm45XgNZ9pQxtlOvl6/dcP24H71wGSNEZDblvSdvV2Jq2AL42v4hhr+JAjMtQJDwLJYSTEv3NWqUMLgzJxIWpiZ+KfbM5NcIW16Rjv/taYMSy3rmFRIJVBzCEcRBIvgo1pf0rZGEjRKU2AlPJmSiNjseb6RhmADF8Jqco1dX+RgPFbXOlDSYWuhQ0JOCozQ/2+iqmgAF3a4gk9fYwfD+OKaeU06Rjqj3rFreGZbhj0Yb5Kzz7SEnszL1Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zNLW7EjmQnym0zPEf+dyxyHadTU/cGxPaacVQkOJ8E=;
 b=QdxQlTvvcIHqBGiDPLqmYYufumzvcbC5GyXr/Xp9uEyDZIxgjTCXI7w6Th3qFOFaM9TybV5cNM+C9aBiusNKbDXT4trrVC0jRVPyZxbVsDI25DFtm7E7i3rnJI98JJ7hzklAmK2B01PhHCnk/zEGa7upFDvkIPAldDCi9uYdZ+eF0EvkDcUoL1EEFL3ltTEMvysawiwKP5740SaYyDMsNVWE5Khnu1TdMRb2qhe/SGYdMcznxxA+JdXWc8ODi7gK53AmHo7qrMBOQHoPuLYRRySta4VJ7keS7n1p9lIULUUYY16jl5WEKYEt0wJdiHnmJaUQFqzr5n4wgbxBIsHtcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zNLW7EjmQnym0zPEf+dyxyHadTU/cGxPaacVQkOJ8E=;
 b=agLsNwns0EWYRUqxIBwa1jzVx9fx1kimu3T5aahkphRcIccO5/JqmyXCCmnbL0L3VX3gPNYJkHAJ7nhd2DhRLkms6W5nWYimp1gIB5PTu3yoNl+uR28BYAWCk6GLESWH/3nz5iZZrAV3oPCWB6oPXO5BNlmXDYKOKoSyWG6KIbM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB9174.namprd12.prod.outlook.com (2603:10b6:510:2ed::9)
 by SA5PPFCAFD069B8.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 17:00:17 +0000
Received: from PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc]) by PH7PR12MB9174.namprd12.prod.outlook.com
 ([fe80::eaaa:b430:ba9:5dc%7]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 17:00:15 +0000
Message-ID: <65de1f6f-df69-417d-b31e-8e1731c12ca8@amd.com>
Date: Mon, 26 Oct 2026 12:00:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Ensure that harvest information gets set
Content-Language: en-US
To: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com
References: <20261022215738.3248641-1-kent.russell@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20261022215738.3248641-1-kent.russell@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::30) To PH7PR12MB9174.namprd12.prod.outlook.com
 (2603:10b6:510:2ed::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB9174:EE_|SA5PPFCAFD069B8:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c49d17-b275-4909-289d-08df33829b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|22082099003|18002099003|261026140227099003|56012099006|10067099003|261021123027099003|261022105027099003|261009223027099003|261022113327099003|261021121427099003|261026121527099003|11063799006;
X-Microsoft-Antispam-Message-Info: QZ38ulpTa5nibJEwY/J9Phdx0b5D7lWOGJKMTAuOINTnLDY6OuISodStpENTZEldG1mh071gYkRLOGd/cSAAAUoBjnpVSeCF0coGHjhLVQjEPU5EtPjWkuOTEbXaw1Hg94cEaWx3P7qwrRkWKXkJ093XzvJaA0f27BYvpG/RtIjiEiY3JTIXeRqKa4Gb/aZzjJyTHJMuuD+vMlTr2MFWVJdUSbiKAfQHpmSBxLMUilBPDzSqZUfqQAQGwGhKFToifw1af+74VMw7i7z/roUAwS1+oOcv0XwgPNH6lLVAqqkyK06yCly2Wqfy2VXhR5q2erLu07PbpPs6R8iG5UNGqKBtr/tO/NSA3lrMuPFvDig3f32RGK4ndiqmktCKngaTXwyd58fzwjyzpSsdNWW7fjyhj2gIQiN/nHG2muP6cDgWmzGJfEPMWIFtjeD9lX2wl966qo8kOaDLvevtn7bn6K4ytFdhmNqO09gvRTj108ahYDxoJMVSqmj9z4azKDhYBCblGWItGNFRbZtBB6MQnTeH+n3cL/0b9sCMizZK3SY3B18MW57isncyZDFSg/p+tQWp1Ik0wnAPwV4fD/Dp/tDrADzznMkr/Ebr0RrpWPuhP4cqnGackBmvaRGxBhgoZf0+8/MN6dSNpX/JST6lKWGt1TvrpHPUCdfjsEjrFh8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB9174.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(261026140227099003)(56012099006)(10067099003)(261021123027099003)(261022105027099003)(261009223027099003)(261022113327099003)(261021121427099003)(261026121527099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEkvM08zL1NOUHpDWmtpMjU1WGZVUHZKMVlDR0ZaMXBxN0NEbFcrNXovRHIw?=
 =?utf-8?B?S2ZGU0pNTlZUeHVpSjFmdENCdWovSUYwMDRRV1dkMW4vMjBTcUdheVdVeU9q?=
 =?utf-8?B?OW5rODF5RWhKSU96WGZ2S3pzSmtCNjRMT3d4QzU1SERJOERCSFZPYVFsYTRT?=
 =?utf-8?B?UmhTbjJGUTRSNERVcEVTRFVSK08rSXZydjFKWjhhRExMM3pBZENkQlBUZm9F?=
 =?utf-8?B?RFQrSDJNcjYrMHhVRmtIQ2RlbHRlQ3VKMjJnSEp3aFBqcnBmTjMzUWQ5VS8w?=
 =?utf-8?B?cUhQTm4xeE5FYy9uZ1pRdU5aWlp1Sy9NQ1pEZC9QN2xlZGwzallxMWVUMDJS?=
 =?utf-8?B?TWpyUzdKOWh5QzBVZWZKdG1MR3M5QmNJR0laWGJqQVpXVlk1enRXUzY1dU81?=
 =?utf-8?B?WlNNdGVGczM5cTB2N01tQnM0d3ROMi8vOE1VOEpQUDJqaVMvdkx5dlB6M0FR?=
 =?utf-8?B?YzdBbGpGOUZZUkRnMFhSbS9QOFp4RkNKYzIraGJob3A3WHpteDFiRFVIc1Rp?=
 =?utf-8?B?Ni9CalR1UkgzN1VtNEFTKzF3bzl1aEsyTS91enIyWGNraXh4cjV4WHUxMmxn?=
 =?utf-8?B?YWhXR21KSHFRUVluLzl4dTFOdGNFb0toUlZPTXBxL1A0cjY2bFhrb0gvMDMr?=
 =?utf-8?B?WUFiWVZVVk1wMytOYW9nSmtvM0JJYVlSYzY3VEU2VXJJc1VJWjN0L1VSY1Bq?=
 =?utf-8?B?NGpFV1R0YWZIRnlrbVRxc09ia1hwMzAvN1AvbUhiTThTK2UwZGZ4WGlSSDlS?=
 =?utf-8?B?TndIcXgvbFkzMDZJeDVIa0htL3BsTHdqQkhsY2MwR0Fldm9sMVUrZEFPZzR4?=
 =?utf-8?B?TEkxM1NaSkVONS9nc1NkYjJ0TUQ5TTJhUEJ2SU9aTXN2dkV2RXV2UlYzOWwx?=
 =?utf-8?B?ZGZLbjcydVJTTFFQQiszYk0xTHhLcW45ZFQrcW5ONmFhVFpTL2kyYXZOTllP?=
 =?utf-8?B?N0ZmdVE3Qm9LaTdlTkNMYSt1OU5NR1hGTkh1aU10bVc3R21yQWxCT0dHeHVW?=
 =?utf-8?B?OEQ0b0NJb0Z1cnhCZjJBd3N4WWJDKzRoVUtjSS9CTGVwcVRUTWkzU2kzTWVk?=
 =?utf-8?B?d01mUEVMMExmRFJBS3BzaUc1VGYyWkFZVCtCOW4vdml0OFRWMFdjbnNMUko1?=
 =?utf-8?B?aGpXbnUySEVNS09BQVlaSnE2RCtITWxxcEZqUWs0b2RENUhsSEtiMHlWRzhE?=
 =?utf-8?B?ZkNISjFLMVNTK3BqTWpCcWFzeENXYkNVRzJXT2krMm5RSHBiODhmbEt1M0FW?=
 =?utf-8?B?eUxneldSQlg2NE9kK2RNY3NrL0pIcjdwMklPVldYS3BPeHlTc25taGNPbVBh?=
 =?utf-8?B?aWRpbk1CQ0FKcXdvbnQvSG9iWllkcWtlMjBkWGQ5dXhDYTgvU2lzOXJyVkNa?=
 =?utf-8?B?TnJHNzBzS0EvVHFveDRpdDRrempyR1l2U3lCVkNYS3RXNjZKT1VMb2RESTV2?=
 =?utf-8?B?RnJjREdqZDVnR3U4Nm91TElsODhIUlIxbDR3bVZUUXg1d3U4MW5PRzlhVnJm?=
 =?utf-8?B?ZlcrcEN0TDg5QWtPV08vcGJEbjcranRCWG5CUTZHV1duZ2VlbWZBZFNybGtW?=
 =?utf-8?B?UlkrVS9kSEtrRUhBSFY0SHd4SlZ2OVZUSmdUdnlwZ01QajVxSEh0TW9UdW9m?=
 =?utf-8?B?ck83SWVkNHVqR1U3a0dKeGZCdjN6Z1VkaGtQVjZrR2hPQWdEaU1QWUV0YWda?=
 =?utf-8?B?c215ZVVTeVJGL1pUWWZwaUZQZGZzMTFNQjFxOHBLUmlLVFFSR2RjQ0wzWGVk?=
 =?utf-8?B?cng5ZGxHQXFEU3k4TisrZy90clpMczRrRytiQzlhbU5Ib3BxWjFRd1NURkNI?=
 =?utf-8?B?Yy94R1NscitCK2dKUmRsTHloeGlyb3Z0RzlBeGRKUkI4RjB1OThzd0Z3ajJ2?=
 =?utf-8?B?L0h6eVgvQldMNFpCVngzMTE2ajFnUHZRZnluOGZtOFhYSkJoa1MyeGphTE9q?=
 =?utf-8?B?eVNLYmg4NnhBMThuaEluQ24wYURBdTVJUU44TUFEd2wrRXUwK0o5UlhPeFhD?=
 =?utf-8?B?OEFWZk5PRjFKZ0dVeUVZaVBPcEdZaHU5a3BqOUZvODlObUtUNm83K0NGYjlE?=
 =?utf-8?B?VWRVZzVVdmtKSndUeERKTGhMVGxIaS9HTW5HZkFmZU1NVEprS0VVRUwzUFUz?=
 =?utf-8?B?a3pXTTBwb0JucVRKV2JZYktMaXJJcTVjNW5ONmFhNmtaSkxkckVmaDJHU3BQ?=
 =?utf-8?B?WEdCY3AzNkYvM200RlVNRktzSzVKempQUzJLTzlmYnV4VzdxQU12MVg2NmJX?=
 =?utf-8?B?cjZqakFjUnROVzdiU1ErSXR2aFVxNjA2WVVITklBc2N6QUpCaERiRUs5UGdj?=
 =?utf-8?B?UEZmdzYwTE9oNkhSQ1RUQUZxSFgrdWtlREU3UC9uaXZpTy8wamNFUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c49d17-b275-4909-289d-08df33829b52
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB9174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 17:00:15.6660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2GUf6p2u7J8oLHYYr/KZ7Dzo4p7L2k8aAEDLyFOy6xRPnmsPESjFPJBdqCNyM4igQdStLxlfhBnnm2TGBj9qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCAFD069B8
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/22/26 16:57, Kent Russell wrote:
> After the earlier patch export IP discovery on probe failure, there was
> an unexpected consequence where harvest info was not populated. The
> early-exit in amdgpu_discovery_sysfs_init meant that we never called
> amdgpu_discovery_get_harvest_info, which is where we set the actual
> harvest value. The first time we call amdgpu_discovery_sysfs_recurse
> with NULL instead of adev, most values can get set. The 2nd time
> amdgpu_discovery_sysfs_recurse is called, we bail early.
> 
> To keep the logic of the first patch intact, ensuring that older kernels
> can still discover the IP blocks, add a separate call in the early-exit
> section that sets the harvest information. This should be the only
> functionality that is missed in this flow, the rest of the calls either
> work fine with adev=NULL, or use the discovery_bin directly.
> 
> Fixes: 3ee1065e9830 ("drm/amdgpu: Export ip_discovery sysfs on probe failure")
> Assisted-by: Claude:claude-opus-4

This should be

Assisted-by: LLM

> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 45 +++++++++++++++++--
>   1 file changed, 41 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 16e3129db6a1..342edbd02880 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1469,6 +1469,41 @@ static int amdgpu_discovery_sysfs_recurse(struct amdgpu_device *adev,
>   	return 0;
>   }
>   
> +#define list_to_kobj(el) container_of(el, struct kobject, entry)
> +
> +static void amdgpu_discovery_sysfs_update_harvest(struct amdgpu_device *adev)
> +{
> +	struct ip_discovery_top *ip_top = adev->discovery.ip_top;
> +	struct ip_die_entry *ip_die_entry;
> +	struct list_head *el_die, *el_hw_id, *el_hw_inst;
> +	struct ip_hw_id *hw_id;
> +	struct kset *die_kset;
> +	struct ip_hw_instance *ip_inst;
> +
> +	if (!ip_top)
> +		return;
> +
> +	die_kset = &ip_top->die_kset;
> +
> +	spin_lock(&die_kset->list_lock);

Can you use this here:

guard(spinlock)(&die_kset->list_lock);

Then you don't need the explicit cleanup one at the end.

> +	list_for_each(el_die, &die_kset->list) {
> +		ip_die_entry = to_ip_die_entry(list_to_kobj(el_die));
> +
> +		list_for_each(el_hw_id, &ip_die_entry->ip_kset.list) {
> +			hw_id = to_ip_hw_id(list_to_kobj(el_hw_id));
> +
> +			list_for_each(el_hw_inst, &hw_id->hw_id_kset.list) {
> +				ip_inst = to_ip_hw_instance(list_to_kobj(el_hw_inst));
> +				ip_inst->harvest =
> +					amdgpu_discovery_get_harvest_info(
> +						adev, ip_inst->hw_id,
> +						ip_inst->num_instance);
> +			}
> +		}
> +	}
> +	spin_unlock(&die_kset->list_lock);
> +}
> +
>   static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
>   {
>   	uint8_t *discovery_bin = adev->discovery.bin;
> @@ -1479,9 +1514,13 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
>   	if (!discovery_bin)
>   		return -EINVAL;
>   
> -	/* If early init already created sysfs in standalone mode, skip normal init */
> -	if (adev->discovery.ip_top && adev->discovery.ip_top->standalone_mode)
> +	/* If early init already created sysfs in standalone mode, update harvest info
> +	 * now that adev is fully initialized, then skip the rest of normal init.
> +	 */
> +	if (adev->discovery.ip_top && adev->discovery.ip_top->standalone_mode) {
> +		amdgpu_discovery_sysfs_update_harvest(adev);
>   		return 0;
> +	}
>   
>   	ip_top = kzalloc_obj(*ip_top);
>   	if (!ip_top)
> @@ -1536,8 +1575,6 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
>   
>   /* -------------------------------------------------- */
>   
> -#define list_to_kobj(el) container_of(el, struct kobject, entry)
> -
>   static void amdgpu_discovery_sysfs_ip_hw_free(struct ip_hw_id *ip_hw_id)
>   {
>   	struct list_head *el, *tmp;


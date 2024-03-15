Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFADC54E58
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 06:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 215D810FC1D;
	Fri, 15 Mar 2024 06:55:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jqbrM0aV";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53CCF10FC1D
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 06:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0xd6obWZm+Bqdpi3kVNVNP8sMbvgIqWf8MrFKICPiV4TLoGPwKRziOYk9Oo4tFIhKGxqUXVXSpR0Kk+/Xm6Qio2IPm5MzjgiX5n0nakNB8HFom9xqET7lAnxRItfqQispEJnuhiD6UWcPEKBHnTIiILjWm+ug+XtXFf6Llx9KFkqjvWJykWX0L9VakZOmgbPISlES7EOibWrkOvah+kZEDEncED/hP68Q0EpmNt+7XpG7MgxMZbCw5KWnk1s0eU79QMU5uCRWMNiEnyi9Wm66+mSqmeCNWa1FHjHc0whsgoO9Krp5Nw79QUqZ3SQRLb/G4g3JZGeSJHgREQOrS4pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O82u+wzu37RmSqXNi9wCF3KVpE7xrOMfHe5iglhOM0I=;
 b=ViE6RJ3xHZzChhIlcrWtMBuuIkslLdgWaNrN+dfX9LE4J1kUoQIu8jpblrqa7jqu4dQnt1GFmzUgajcbBYGqtZt3GXAEUHkCVsPpQt01EqdmA3RLX11UUNfNZVl9u6dy2VwXExYrhTcy/LbFsfq+tDkiVmreuxGSDcRXSqXs6Y5v4ee7iq4vRMjBi9ksye/U+aW6uwVTNFPC3Lus9devy6j+Fsbfyopul4KhcbbWFZyrxq99w4OrWfJDKzCSyCXbsE2IskDbUGJ48TMdT16pNKL+kriWj/eh5vptCUNpuxd/OUByzduXTC3EJFIXoipfFsSqn+sDZxISi67+S1e3BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O82u+wzu37RmSqXNi9wCF3KVpE7xrOMfHe5iglhOM0I=;
 b=jqbrM0aVo6sCwk7Fc+/tB36WyEk+dt2Z+JgmLksOvCXrFYbpkOiL1m1Zor23Dd4Nx5vOD5TwWxDQsQy5lSc20BYpZ6+abcvghC0WFppKyh3gQb8ObydACwBopXuGPRrqawfmFKgYJaYOxWKee6WlyOW2CdKCONekz7xGLxGqd0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Fri, 15 Mar
 2024 06:55:17 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 06:55:17 +0000
Message-ID: <5fd938dd-3df4-42bf-9dbe-f7c77f40e34d@amd.com>
Date: Fri, 15 Mar 2024 12:25:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/pm: Use metric table for pcie speed/width
Content-Language: en-US
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org
Cc: hawking.zhang@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 donald.cheung@amd.com, sepehr.khatir@amd.com, daniel.oliveira@amd.com,
 charis.poag@amd.com
References: <20240315054149.3259906-1-asad.kamal@amd.com>
 <20240315054149.3259906-2-asad.kamal@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240315054149.3259906-2-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0118.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::19) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: a8fd0678-95ea-402a-7f0d-08dc44bcdf42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +cAad+36mYZG/0d4nexIgwJ0MrR2Bdrz7gP3iqjHduB3J0fvPNcnVNModpbsgVcYTHtzBV2r7S+gIBO9XzoqzBKHxzAbJ0qUW29OWLEdtwmBA+JwKwJirheuU/PUVK++JAmk4+R0919MJwOD7YrBXv9t702bVmKcJM50xqRnh35ZZQPq5+cVg0KmvKSTLBGF30PULdko+rnsdUk90jACItZLggfvfWVphBc2mjp+Jam3NFj3VcHRUi1FwtVlfVcZTjwewe9MQ9eDqeo641joQpNkk3yRu5FK/w4IzHK7WS5Cl7HTHOG1yIEPrwlfrjOtndKho3wnw6qBMHAdfSLpc0AE6wdCKlJn6j1lfJrNDlWpqDBfeXFOrkJTmVDuI+6KpZDURY0Cd6pBdbPiI1k6gf6ZeFUVbXB5bS6ylC8TzasGYcM0XM96yjMlwHXVhacPHk36L3+zm1zthNt/4IOkPQXy3VAjW0BLFJJKknUUoy2PZZLW4JKQ51V1nZO2L+ckAnkq7TTgdpw1qyHnEE6t7IZ3iIL7G2BtU0D6TeBEd/79dDuTEn6pwEqVRQdclMQoeO4mx4CGLIK317EIWH0pP9dBt2OzT9kSOQ8s7o4kwz3wF3A85bufDm7Jk071ZYSS7ks9a17lwHxCh8GkodJ0lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHFSWU8vd1l3V2h5QSs0SG5nKzJqWHV0SjZOL3J2YjZLREFpRHA2RUIxTnJ1?=
 =?utf-8?B?SCs4THg3U3RnU251QlJFZ2tNOVNZYlJCQ2s2dVQyMHdlZkxNbTE1WEVHK2I1?=
 =?utf-8?B?NTRxeEUvWnR1S3FoMVhVSFJMR21NSjZhb1JYYnBOV1VXbWhDeklubngyNVFn?=
 =?utf-8?B?SUl2dUx0US96bHN5dVJGdjZ3Uk42TVQ4ajNyQldWdUphN1I0S01IRkl4cHY4?=
 =?utf-8?B?b1RlU1I4MFJaMlBmSG5ub0pjRlR2MEpCYnBiaEZqYUhpeXFkaTJrU1VKUWZC?=
 =?utf-8?B?OEFWVm1laHUrbHdzTWtRNTVwRUFXaVpTdGd3SDJpdG03Z1p5WkEyK1BPN1NI?=
 =?utf-8?B?UUFFL2VwVzJlOTBNSmdIa2FObm1sVlV3VFFtK0FUMGdGM3NMVG4vNGpvT1FW?=
 =?utf-8?B?eERqeVBDRzJlVHlsQmpEbmE2UE41VUNrU1hQNXZHSFN6MmZkNXphTFJDTGpV?=
 =?utf-8?B?NkR6ODBTdnA4dnNHcHoyVTBtRDM4Z2c1bEdZazdaeTVNMVQxaEJBYW1zZWpI?=
 =?utf-8?B?VktiOERha1Q0YkRzOGJkU2I2L3FjY3h6bUJxQ29oWDByZEJaSTl3dTZBRXhW?=
 =?utf-8?B?VmtxYXRhL0FQWVNJWTE2amZCQVVqSVpRN0ZucVZ4WDVPbDM0d2F0UHFQZ3pB?=
 =?utf-8?B?V2tUSHhIRTYrai8vZFlKR1JlVTRYRmZ3S3Z4eHMyTnJUQlMyQzM2bEcxNmVp?=
 =?utf-8?B?K0x5dFRvSS93VmlhOTFFVXR6RTlBdWxKLzRGOVVFKzZFZ25MbHphKzVGTDhq?=
 =?utf-8?B?TDg1cnBSNlBZQnNSKytzMkJNS0xPMmJWVVdPMmM0dStYSW0rc2dpR3JhRGE5?=
 =?utf-8?B?ekljNk9OdVkyWEZzYjB1VjlCMEplbjhBeCsySDdyQzB2eWRyQ21MSGtSaHpK?=
 =?utf-8?B?Ny9pSnlweFJoQkNwcFJRcnJzK2xVTHZGbm0wT0NkUllCbXZiR1hZTlNtOWFh?=
 =?utf-8?B?K3Bzd3hUeTVMcjNQUVpTa3Nrcnp1clA3TGV1YzlDMVZTczY2RjZBMktDcGFC?=
 =?utf-8?B?VU01VVoxMDhmZ0gzK2huT09ZcWExbWd0VUxuUGJYTkxkejRuNnRMc3B3Wmti?=
 =?utf-8?B?VjJXZStqRTd5YkNMMnBxUGViWDZVc1BEd0hsU1RFWEJ5QURadU1La000NmVB?=
 =?utf-8?B?eEVjU096VXl2dEkxNzh1bkxQQ2xyeFA3M2JtLzR4bXZUNUxRRllvN1o3SEFm?=
 =?utf-8?B?RWJpRk1ma0RoZGxsVW9wcWh1NzhjdWxmcmtXWVkzRTVncWd2ODFDeU1KZ3F6?=
 =?utf-8?B?dmpQK0xSbXlaUUFSSVpZSHI5VDFSRS9xYVR2U1BtY1hDY3RoNzR4VGN4OHUx?=
 =?utf-8?B?c1BNbDZEWUJXSG5USWpBeEwvT2lGczQrUm43WE4zRk5FVWVDWnVzbEQwdTR3?=
 =?utf-8?B?VE9XdGFveHdORHAwaUVWaUp3L2ZCc1R0TGE2c2t2VHZTVHFJTHQvTEZvOU43?=
 =?utf-8?B?YnlkdUp2U0w0L3JTTHhNZGdjRFMrZTF6TWUrdEcyU2JUQVQrVzdJaStDakV1?=
 =?utf-8?B?RnJWajc1cFpTaXc5UDZQUjhPM0JzUStuTnhjbHRIeGNydUR4Z2FYa3haa0Zo?=
 =?utf-8?B?UnpscTJMTFlWTEx0K0tUbVc2SmtLYTArU3FmU0ZqTHE1d0JJYUZ1aGhFc24v?=
 =?utf-8?B?RmxrRE53OEpucTFhYi9iQzhyU3cyb0IxUEZtaGR5Q05DVXZDcWk2ZmxxUWtw?=
 =?utf-8?B?V2NRb3lyQS9lNHBJUlpOaG9oQ04rQVdTTURqdGpRdmRLZThvSUduSTB1Mnl2?=
 =?utf-8?B?a2lEUnI4QjVURm80WGNZZWRHZFBHZmVidm5idmVTTUdqTWkzU0lKTCtzMC8z?=
 =?utf-8?B?SCtWTXB2ZXliNFhWSGlyeWRYZVdVOUdReGxyWFM0azJua1VQMTZLNG5aYzBy?=
 =?utf-8?B?Rk5jU3gwTmp3WFhrSmd2UmNndVM0RURVQVRSL3FZNXV4ZXplaUJwMnptMzNx?=
 =?utf-8?B?QXZmN0JGVm1xRHg1aUFxcit3bkZlSW5CcUZONE10RkdGeGhkd29XbkR2TlBs?=
 =?utf-8?B?K1VoU3EycDVUb3NwOG4wd2MrWndPNmw4anFiMS9DaDNPaU9aL3BHRXN5QTE4?=
 =?utf-8?B?OEdxdVpoWWRWR2lkcGxoVXJZNENtcmx5aGRTTkJwODFHZ0NlVGx2QmpDRVA3?=
 =?utf-8?Q?gvXdKlzBwZ7C1gI9HuXmXu1k9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8fd0678-95ea-402a-7f0d-08dc44bcdf42
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 06:55:17.3990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BUUJTmqmuL2FGDvAKHTXGiMVykdYqI3nELB/JvlNMEAohsaM177ddbIScB+avjJ+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691
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



On 3/15/2024 11:11 AM, Asad Kamal wrote:
> Report pcie link speed/width using metric table in case
> of one vf & if pmfw support is available, else report directly from
> registers in case of pf. Skip reporting it for other cases.
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 744c84f3029f..2a934864b5eb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2167,6 +2167,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>  		(struct gpu_metrics_v1_5 *)smu_table->gpu_metrics_table;
>  	struct amdgpu_device *adev = smu->adev;
>  	int ret = 0, xcc_id, inst, i, j;
> +	enum amdgpu_sriov_vf_mode mode;
>  	MetricsTableX_t *metrics_x;
>  	MetricsTableA_t *metrics_a;
>  	u16 link_width_level;
> @@ -2229,7 +2230,17 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>  	gpu_metrics->gfxclk_lock_status = GET_METRIC_FIELD(GfxLockXCDMak) >> GET_INST(GC, 0);
>  
>  	if (!(adev->flags & AMD_IS_APU)) {
> -		if (!amdgpu_sriov_vf(adev)) {
> +		/*Check smu version, PCIE link speed and width will be reported from pmfw metric
> +		 * table for both pf & one vf for smu version 85.99.0 or higher else report only
> +		 * for pf from registers
> +		 */
> +		mode = amdgpu_virt_get_sriov_vf_mode(adev);
> +		if (smu->smc_fw_version >= 0x556300 &&
> +		    mode != SRIOV_VF_MODE_MULTI_VF) {

gpu_metrics is only available in one-VF mode, so there is no need to do
this extra check there.

Thanks,
Lijo

> +			gpu_metrics->pcie_link_width = metrics_x->PCIeLinkWidth;
> +			gpu_metrics->pcie_link_speed =
> +				pcie_gen_to_speed(metrics_x->PCIeLinkSpeed);
> +		} else if (!amdgpu_sriov_vf(adev)) {
>  			link_width_level = smu_v13_0_6_get_current_pcie_link_width_level(smu);
>  			if (link_width_level > MAX_LINK_WIDTH)
>  				link_width_level = 0;
> @@ -2239,6 +2250,7 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
>  			gpu_metrics->pcie_link_speed =
>  				smu_v13_0_6_get_current_pcie_link_speed(smu);
>  		}
> +
>  		gpu_metrics->pcie_bandwidth_acc =
>  				SMUQ10_ROUND(metrics_x->PcieBandwidthAcc[0]);
>  		gpu_metrics->pcie_bandwidth_inst =

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1F2CAC5B0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Oct 2025 15:03:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A901F10E938;
	Fri,  3 Oct 2025 15:03:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HE66V9np";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4433110E938
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Oct 2025 15:03:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tA49TYFM/bIMwk/qz34lUPFt9YKDU4YsPr9iovSEU+Ud8fFI705Gi+z+PdzVoKuIbT/mgicdJwLC93nkx7LwZkVJfky+rdKSErelqOvIZK/RhTdVEynwFsTaXMTRs4rY9ozm9+zy2uGGqCxUAYvL16GmfAXHf+Wdu9QCZWZuetbBKdW8jEHEn4/TicQ30X8Oc9nk30QbB+AugVnLpJUwnN58pNPRJdXsIHM5Fmcdeohk+x+BfbJkQAWUx6onZvFVaMUBkS6TLU22DjduBCI4MwSxRhO7oe7EDmNBTf716BpPTo576e1zptLjS7hiqxpHj+k7DEIG8srPuJZxzhJa8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MGBrOMmFGF2WXJRyux6Wu8beFDbHVV0ATv6Yn7ElSo=;
 b=ucgv1ty1SwRgxI9XkCbkGUxlO3WllplIka5G8VKQmmZlbjlcbn1veTSMkP4g++/E1UPhO3fj/AaW/618N0F4Le50SgdFSXxC6VdLr73hoAQ2rYvV/Qh2Hh9UdYyCnj3vaMh1Kct6UJJ9F7P2c2iXj45DHgxKLIOY9ZCiI1gEoWtcJacfxe3JEfGNt/zuRjmEWSI94Uj/8ItJejEOj6Dl3G1dCLc5uAWMlhZCivQbvLPgsUf2c4JHo8Ep2jSscMrOgTroKP13JAT+DJdaSVILF6S3A4WSX3IfLT/Tz6JvFjBHc+ultzKVUsHn4jMpJATnD3lA06Lzp7mThh113eHwsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MGBrOMmFGF2WXJRyux6Wu8beFDbHVV0ATv6Yn7ElSo=;
 b=HE66V9npnxh2OjNFvt8jMAz1YjG8MxDhNSAD+lnOVBkDAZUps/yajq3SfzI7XL5vSvYWJunRlA5DMFHil+HnIylYNu+l+NaBtqc/CZ0LHKYUPY/TLr4J0jWi3G2POUNJSqIK8zmSAerqwja691prS3sCqgu9DoKcExE068Utt3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by CY1PR12MB9649.namprd12.prod.outlook.com (2603:10b6:930:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 3 Oct
 2025 15:03:16 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%4]) with mapi id 15.20.9160.015; Fri, 3 Oct 2025
 15:03:16 +0000
Message-ID: <7f23e178-8ba5-5e12-3708-42dc249e2fad@amd.com>
Date: Fri, 3 Oct 2025 11:03:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] drm/amdkfd: svm unmap use page aligned address
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, harish.kasiviswanathan@amd.com
References: <20251002174307.10583-1-Philip.Yang@amd.com>
 <20251002174307.10583-2-Philip.Yang@amd.com>
 <75531fd4-74fa-424a-abed-3f5f03d7717d@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <75531fd4-74fa-424a-abed-3f5f03d7717d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::28) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|CY1PR12MB9649:EE_
X-MS-Office365-Filtering-Correlation-Id: 742dd1e4-ad46-48ea-3bd0-08de028dfae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWd1V0dIQnpOUzNLa3o1MEpkZHpGQWF3d1pqcVlCZURReXN3S05nbDFMcGFR?=
 =?utf-8?B?TjJQbUFpTklobytueFRoSEttblFBL0NyQkNlQWFUSUJ3azFJU3VvcTBBYlln?=
 =?utf-8?B?LytOQ2ltMEVCTFhyd2VvcW9YRXh6bkhVZTFXZGppV0gxeTdkVU5ScEdWdnUx?=
 =?utf-8?B?Yjh5TXRnYm5tb0d6Z09rT29RbWJ2UERJaVZvdHYxa3pQcHZPdVM4dzJUUTRM?=
 =?utf-8?B?a2M2cStXMUFIRWhNVHhvUnFuSDdVMDZwRWRKUXByUEZUTXhkN3hlSVJmY2I5?=
 =?utf-8?B?dE1mYkZ3UUVaQWg0WXRaVTNTK1ZpZWxtbldyMjRUS0JKVHN5b1kwL0NCY2tE?=
 =?utf-8?B?Q3FIRXlSc0o0bEt2RlBXQW04QlozaklqZlZpQlRWWmp3Uks2WGNkTEk1OHZU?=
 =?utf-8?B?dSsydXVWZkwvSmhYYlN4R3BJRDBvcnhyY3FBdlJVV0xueGcxS3BJU2pEYStM?=
 =?utf-8?B?LzdTNVNKMFMzTmlZMmR4eDlqZXhScUgzT2wzdEpMTkwrUkxsOXdhdW9jdmxF?=
 =?utf-8?B?K09pNmxPZnJZQWRoelRDMFpwQVJnWlBTbGJTOHh0MERrcklURWIrVUdpa0ZQ?=
 =?utf-8?B?S3UvQXNoc2tGM0d6Q096ZENROWZYL3JxT0Ezc3M5TEhhaEtPcWV0eTlJdUs0?=
 =?utf-8?B?YUVJcGNMSDhNV1dnZEFXbFBtM1d6clA1SjhPSjRSOFk0VWVZQmo5UGxJc2Zr?=
 =?utf-8?B?WlZ1SjFJMFZPZkpZU2M0aUxoaldXaFVLbWt0akY4UlZDSVRTdHJHQWlxYUMr?=
 =?utf-8?B?UTl3cXQ2ZURyT2phd1BmdHN2enB1TVFRUEN6clphbThwSUtsUFg3M2lxU0xs?=
 =?utf-8?B?eit4ZTRwMEE3SHc2emRvdXA5TUVTS2NvSFo2NjVYV1h2eWRXN1VGaHNQM2kr?=
 =?utf-8?B?S2JjK0FyZGg1anVJU09HWTBicE10VlB2dS9mRlV1WVNNek4wNEsxaUJRYVUr?=
 =?utf-8?B?c0E4bVZ4eFFLcXhhc0dCeTRMSFhjQjJOTjlOVTRmWXZ3cW9XRWRIaksvczVj?=
 =?utf-8?B?eXdxaTVMSUp2RlpHQU1tU0xwU040VkxqdTV3cHdzbHp5cXg3SVNGZXhTK29C?=
 =?utf-8?B?KzYvNTVRUmxkaWVCMUxPOGc4c0k0NjBNUVJYWVNGc3NXczliZHJoaDhITUlt?=
 =?utf-8?B?QUJsQ2M5MVZOY2J0TExEQVFGR08wYU9RNzY4OEZYWmpVVzJqQ3ordnlhUmFq?=
 =?utf-8?B?UlZEVGVEVmdOaW1wSkJyWHBtcVFZa1NCL1p2QWhNYWVId1JpNk42U04wdWs0?=
 =?utf-8?B?MFpzQ1ZFeG8vZVc0NzQ2RndmOTVqa29QUm5UQUEzUGg2Z0pEOWJTd2w5V2Z2?=
 =?utf-8?B?anBNRTBiR2UrVVZHbmx4UlhDQjNsR25lLytOelZNTjJZc1VQdWhpUjB3WjJY?=
 =?utf-8?B?bnpZR2M3a0VCZEQwTjdubDA4alAxUjVmY1dXcERZZWliS09IdlEyOThsWVhE?=
 =?utf-8?B?SUE1dzF2dXhMN3o1Y2J0azdsU3d4c1lXRFRtMDYzbXg3V0Q2WEg1U1BLS1pJ?=
 =?utf-8?B?NS9BTmJWYlMzWERWRS91MGNoMno5MlArbWM5Y0FJVHlURlpPSDNaa1o2L2Jj?=
 =?utf-8?B?S0g2VElUTWdtd29mTG9hdkdSMkgwTFFyRit2K2ZaRGpkemxNcU14c24yYVNv?=
 =?utf-8?B?ZVdPWVhQanIvTis4RGFwUzd1T3paZmpnMy9TeG9qWHhtdXM3aTAvczdkNzZD?=
 =?utf-8?B?UElFNDQvZGNGUFY3YlVOY0VudkpyL210OURBaTFzNTdaem8ySTZrWmc4Zk9s?=
 =?utf-8?B?ZVozNVhqbVpFbmRoMEhIV3Z3ZjhCZjJOcm5QY1dJRnRHMlRUS2V5Mlp6SC96?=
 =?utf-8?B?QzBhZFVyWDM1bWtSYkRQMjlQUkhNdzlJQlcxWUNGTy9jMUR1dmV2anUxRlRN?=
 =?utf-8?B?ZU5zWjhxYVQwYTJ6cGs3U1BzcVlWUGJOZ3NwbHJQYyt3Tk54c0NHdjNFTzhq?=
 =?utf-8?Q?5m+56NmQoPQP4YMcHbtPCVXJ1CTvvg3c?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1FMYmZuUmpCbVNyZ3Y1VkxGaVYrTENLOWtaVitHUzJKaUVQRE95Zm9Ra0s4?=
 =?utf-8?B?d2drbllaUDlRZHptUUtES2NLRnM4K1M2WmU0akJkelFmbDZqUytpVTBwVGI2?=
 =?utf-8?B?NkxoamlKYmRPSFlvNkkrbWtJWHdvTTF3bVZLdjZaaG1Lc1NEZzZaWWd2OEJS?=
 =?utf-8?B?N29wVmdWd0ZnTlFxSWRKQjFoOWNDZmsraGtOYVlIekJwZkloNm5xOURkYXZx?=
 =?utf-8?B?L1MvbXdWcHZ4Zm5MYlh1OU1hY3VzWnhjaDl0VExDNDMxZitrTnFZeWwya3JS?=
 =?utf-8?B?WTQ1MHYvaWNEc2FKTjBpWUVTNitDbEZTQ0NqbmVYcTNGc3NBaW9sN1E0SSs2?=
 =?utf-8?B?R1dpZnhVT2pPUFQyZ3BmTFZST004M1l0S3h2UEJvaC9Xa0owRk1QcnM0Q0o2?=
 =?utf-8?B?RkZJSit4Yk9tVjQyb1Z6QTUyNE5DWnZYaVRQNDZhTWY1YzZYU1NzVnluRnh0?=
 =?utf-8?B?T0N6bVhEUlo4STR0M1JoV1k3MEZhWFZMK1F3MFA5VFpXTUVBUzkxNCtYc1hn?=
 =?utf-8?B?c25vcUJzWHJOMlNmdXRodUcwZHpST0xlZ25TTnVQWXExK3JzVTlmRC9GSk4v?=
 =?utf-8?B?aXMyOWdJeVBUcXFBMkk4U2hvbVdCSEhFcXpsU0NNU2YzTTFRSmk3WWJNR0Er?=
 =?utf-8?B?YlJDclRWNDNIcWlMaXJlMEhmb29EWTZHZ2F3dS9ZRDh1dUIwR2Uxb21mTUZU?=
 =?utf-8?B?VmNWMzBiUUNQTVVOZXRhV0RGY1V6QUZtOXhSOFduOWUvVnZuRmczRjRTMnlz?=
 =?utf-8?B?ckVOcTloVnNzMVF4a1VWS2Z5bURFUHpxaUJhdmVXZHVDR1VsUjF5Z1BMYWNy?=
 =?utf-8?B?OUhKUlNZQ0Z2aTVyNDVwVmlhcDlobytjQ2F6TUlONjFuK0Z5eHhvdjJjL2h6?=
 =?utf-8?B?dFd3OWNic1E3NUVtMjFtcStCT0xDd3orOWdTMFhHT3l0NG1WUWhIaFNCemt0?=
 =?utf-8?B?OExNdmsyTUJ4K1dySTh3NlhSZGx6SlVtenBGdzQyUlBOREV4amFOODFxMHEy?=
 =?utf-8?B?bm5DTHdkemtpZWFvTUNoQWFmTDRJVW9IZzlXTUp1ZFZHNU1LcmZUTjFnWHFD?=
 =?utf-8?B?TjhXL2k4eko1N2xneGl1V084OW02YVhMN3FxYTVBNjJqSXc4UXN2L0dGZkxz?=
 =?utf-8?B?cS92cTNseG1TODN0SkJIdTJzYlgyeCtZV3U1N3diN0RwTHFQVWZ5TC93dlJV?=
 =?utf-8?B?YWRRR2ExeXFzVDlYYnE5aTR1WnNoSk1OaTdnNTBtREJjNTZsck1MYkNsdzBy?=
 =?utf-8?B?NWtjNHFKd3ZJTGNrbjk3eDEvcHc1RnFLcmlFcXlqR20xSmlDRE9rMVdlTTV2?=
 =?utf-8?B?L09yUlR3NElpNE9jNi92VFlSa255NE9Xc3lBMVR3VWNOUGNWOXZEY2Z3VDB4?=
 =?utf-8?B?Vmd5ZkpFdDNPY2p3YnNyRTJSVW5MTUluNFFOZWtNNmMzL2lQV0loM2hmMW0y?=
 =?utf-8?B?c1NWQWRiSVBzSkladGpERW80TnVGOTAxdVE5cE44NWZhSTB4Ty8wTk00MFQx?=
 =?utf-8?B?OUlJeWRhbjF3S3dudFNLQmtMeE1iZjZ4Uy9BNkhiT0IwQlVrYTJNUTdkUVFy?=
 =?utf-8?B?a0VrY1BUMXBoMWtpdXlkbVJQc2o5elpJU2I3Y0xPdlU3WTdPZnZ6UlpwenEr?=
 =?utf-8?B?ZUIwdFUrUWo1UStFOUNZZXpneGRNWDgvbng5dVNveG1WUUhaTzJiTGUzVmxz?=
 =?utf-8?B?bXRNdDNsZjc3emdkekVVcmdDWTZHS1h5MFZEUDRacEhBbTJCMitZNGsxaFJ6?=
 =?utf-8?B?dkFQRTVvM0RpYVd0VnBvRGJianRCenV1UHEveDN4V085TDNrbHBVSGFzL2dE?=
 =?utf-8?B?eURxVzY3eTBmSTV6dUZaUUtpRm5JUkpLVVRRTisyMnpRanN1cW45YUY3WEg3?=
 =?utf-8?B?dkM5OTVjZDRNK1NlQ3RwTGkzZzJ1eFhxenp4NEtTZ1Z1Y1BIUnlITlhxSEJP?=
 =?utf-8?B?SWlUQlpIaS9aNlZjZzV5Z1ZZWjBsaU5wTmt0WjhsMXBmQUIyOG1Fc0xTZGZZ?=
 =?utf-8?B?aGl6WmdkRUdJY2g3dmZMdUdGcFN3VUd3UGdXdUJta2FnMFJxMkZPUDVZVmR5?=
 =?utf-8?B?SVFzaFVDL2hQaEU3UFRCL0lNYUdBeFVxV3lvK2NOTVRBNTZZM1k0UUhaUjVq?=
 =?utf-8?Q?woTI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 742dd1e4-ad46-48ea-3bd0-08de028dfae0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 15:03:15.8811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKzqPVsaB9UTOXYAAO9xxcIK9oiIj0q5Je+gMr5N8c8E1QMOR5X10/LsPR/QpD2W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9649
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


On 2025-10-02 18:04, Chen, Xiaogang wrote:
>
> On 10/2/2025 12:43 PM, Philip Yang wrote:
>> svm_range_unmap_from_gpus uses page aligned start, end address, the end
>> address is inclusive.
>>
>> Fixes: 38c55f6719f7 ("drm/amdkfd: Handle lack of READ permissions in 
>> SVM mapping")
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index e8a15751c125..742c28833650 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -1723,8 +1723,8 @@ static int svm_range_validate_and_map(struct 
>> mm_struct *mm,
>>                   svm_range_lock(prange);
>>                   if (vma->vm_flags & VM_WRITE)
>>                       pr_debug("VM_WRITE without VM_READ is not 
>> supported");
>> -                s = max(start, prange->start);
>> -                e = min(end, prange->last);
>> +                s = max(start >> PAGE_SHIFT, prange->start);
>> +                e = min((end - 1) >> PAGE_SHIFT, prange->last);
>
> I think the problem is more than that. Here "end" is the last place 
> for prange gpu mapping and the handling here is for a vma. Should use 
> end of the vma range to get "e".

You are right, end should use next - 1 instead, I will refactor the 
patch series, send out v2.

regards,

Philip

>
> Regards
>
> Xiaogang
>
>>                   if (e >= s)
>>                       r = svm_range_unmap_from_gpus(prange, s, e,
>> KFD_SVM_UNMAP_TRIGGER_UNMAP_FROM_CPU);

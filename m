Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8A8C3600B
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Mar 2025 12:06:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 304F310E3E4;
	Mon, 31 Mar 2025 12:06:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gZkDO2T5";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79DF710E3E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 12:06:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZl7nsAN9IEX4XtkMlM/Aqk/kR8xgrQaDW2w2W8xoJyvrxshvGhNYw1n7W4jNdK5fcmgJC2a+00WwZB0Pe4+ldC4ZclWhuzgAJ+npZiXgcPcvjd22G+lixehqqsYuIhVp4UO06MCwUfNfFsvBHKJPdFrN9BLgOTrc7LelbphU7xWUIHpHTzpg5tMIZjvwHLU97M8uYCAEt1WyAprzfgJZpMHTqSx808V2z3pHge2AZf9peRZvpKmEP8MxahLerFIzywRiDl3eihkdj03jGQ4J6a3yNzoc1UEoOXGA/y7oEib8TdM9nmz3Pc7dHOu/JcTTXLUYmPzImBXPaDB2697Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ab6ZmyT8W1NNmFs0qntpuLwXwBIJpjYl4KklQs2/6r0=;
 b=C+pawGau3x14znkJLXgYMvSwk2s8Zn/hiBGPnjcYJCxrutu2+BYWxfW4r+B8azQwObybSRNygfH72Ou+fkXibmNxKmWE1Qa3y8vzAWzp8D1EyBmpFwrVhYCFMJ4DVAevCan4mscB5zv9ycbroCDgL2Bd/IQAxx1jgWd2CRPRX+5xkk6QtQctFJKFgjtL/+Ixg4KHNbPPz9SW5HBNb26eNDxN1z2O/lwDhMVBCJryjYGY8an4qmBuhT8XaLz7QCf1Wh/9Vnz2TMfCx/o9SbdP4J0PTf8IvRdjRcnFdsTxCwtqhOoV6pHseSKdaxwBF2uEqiMr/8n2CLA+DFfj7IzKCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ab6ZmyT8W1NNmFs0qntpuLwXwBIJpjYl4KklQs2/6r0=;
 b=gZkDO2T5PTLCAmWNuRQnDSkcuh/QpqeDKjLzHM9I+7jhstOocXeb3PkUpW7YLKNlqMSaoWW3moi21617sOtjoX7BUEov/3QuvjJYm4767mA4YazqQXf57Jrx8o1tfiojRO7y4Otm9PJUg/dboErXE5/QEGto6jJFXy7SH3+8zGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8921.namprd12.prod.outlook.com (2603:10b6:930:c7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Mon, 31 Mar
 2025 12:06:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%5]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 12:06:35 +0000
Message-ID: <64dcfc76-a973-40c8-b664-4191e9e8d266@amd.com>
Date: Mon, 31 Mar 2025 14:06:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix warning of drm_mm_clean
To: ZhenGuo Yin <zhenguo.yin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: shashank.sharma@amd.com, alexander.deucher@amd.com
References: <20250331112634.81008-1-zhenguo.yin@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250331112634.81008-1-zhenguo.yin@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8921:EE_
X-MS-Office365-Filtering-Correlation-Id: 256de7fc-6127-4890-ceba-08dd704c7b66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXo2MW1FS0lha0JJcXA2bHR4RVVPWDdubFRoaDdSTklUZ2hkZnV6blArUEo1?=
 =?utf-8?B?bVc2anNqUHRWd1hTVS84b3dheEh0TzU2UjNTUTREUFd0d2E0bHVpdGI2TE1F?=
 =?utf-8?B?NWVqN2R4R3ZGaUdPbUIwRHhUME92VWdHd2I3M05BVjVEbU9HVUQ5a2x0L1E3?=
 =?utf-8?B?RVQ0ZVZQQmMzWjQxZUg0QjB3NlRSbUF2U3RTMlpHRzJxS2FGV0lybzVodXVM?=
 =?utf-8?B?L0tRVGxrMExvcHkvTTZ0dm8zL1FEcUpyaG8vVlJHUUJLdzJHNG5lVVVpaE5J?=
 =?utf-8?B?VTYzcHZJZGR0U3Y1dnZOY2NhVGpvZXpQc0dwMTU3SjdnWHF4MGlCT1pMNlhy?=
 =?utf-8?B?TUtZaGRCd240T1U5N1F4TG1xaXJTcnVURzZxaWZkbEFPdFlLbUJMUnRGR1JX?=
 =?utf-8?B?OUhaK0dhKzUzWkxKQ2k2WFpxQ0sxblpHU2ppVlduSlkxN0dFM1RMTDM0ekNk?=
 =?utf-8?B?MkJQSFJTdDRrMkdHL0VRQjI0REI3TGNjajZPc2U4ZHF0SDNtVGtTRW1Nemlr?=
 =?utf-8?B?b2V6YVVmdXZ3S3ZtVWRvZXoxWFVtb04vU1dHYlRJQWJaWU5RNk1xQ2hnSkF0?=
 =?utf-8?B?OWFSNlJhVlVGdVZyWnJKMTA5VTVnUWFxWlNkOGhtaCttK0VSMGZKbDhzMCsz?=
 =?utf-8?B?bUxubUhYenlGbk1lSVhoRGRQYXl0QTFWQm1RZXdGengrM3RpTjVPNFBLYVVH?=
 =?utf-8?B?dTB6V3BWR3dTOFpYeDdyTnBQZDRidUtZQ2tJWjg4bWNQSzlHaUFBMS9MYkJC?=
 =?utf-8?B?cHpjb3J6b1BiQjN1cjUrWERpOXlRUDN4RnNwcFZEb0NCN1ZGR1hObFNwTVQ4?=
 =?utf-8?B?N25VaDR1RDBqNzVZTWp0TUdSSzhLZklrWTJVVFp3dlpkNTdGMUw0dzBOM0wx?=
 =?utf-8?B?MCtzVUNUV0Iwby9NMGN5TEZ6MW5JejR1cE9iNTNQQVZraldJNUhuNkZWMWR0?=
 =?utf-8?B?aS9IQXdyaXdHbmxtR0FCMEtuY3lta3dCZmFwZFlJYVhaZG9sTGJrYW9hZGtE?=
 =?utf-8?B?ZnFWR1gvZFZLdE83eHU2OW5oakZud3ZTVnZIeFd6WjNKTU9MajcrTGlXemFJ?=
 =?utf-8?B?NFZqZGI0QU14M01GbGhTL2Q2VktZUVpnaWxSRE1Da1pwdDRhMG5teTZsOEdO?=
 =?utf-8?B?VXNQcFlVYzJPeDUyMzJXVXoxazJoZjlGdXVWY3hSdmh3dFNJSm43T0NRMVJG?=
 =?utf-8?B?bnM3dktuODRWekd3TlpwNHV2dW81UGZDSzc1MU0wcnVzV2llNnQ3cTJsRDVQ?=
 =?utf-8?B?dlNrTFpzc1F0YjJtYk1UdExCUExHZzIvVUZ0amRIdUhXQVpjMVdsbGFzZW5Q?=
 =?utf-8?B?WHUxMTVMMDVWbnBobkNCT05pbGRWU3F5MGdBWFdCVyt5VmZiaXk5MUx4SlVo?=
 =?utf-8?B?bmYzaEVUM0dGb0pVQVY5VVppVCtibGZub1ZoYTBSbDh4SlpCZ1lsc2xHd2lS?=
 =?utf-8?B?NWgzWkxEbFBVbXU5ZWFqSThjclo1Wlk0b08rYWRDUDJBeWZ5WmVRNExrUW83?=
 =?utf-8?B?ZUhHaGFPaXVHMm1wOTFyaEU4aDdSYXZQc21CRlZVcmZobjhSTTJnSWxNaEIr?=
 =?utf-8?B?SjM3UjZuQ0p5VWY1V00vQzl5dkJNVHBmU3I2QURrQkdDSDNleFpFbDhHSTdm?=
 =?utf-8?B?MUU5U0ptVmU2eXdEV1Z0cTlTK3l5dWlYZzF2eDhvR1FndlRhUVFNYjNNa2Q3?=
 =?utf-8?B?UTl0M09ZTXQ4R25ENE83Rkk2eGZzTkl0aDl1Z21Zb3Vtd2E3bmRWU1Z5YlpE?=
 =?utf-8?B?M0d6emxScUgrbGlQdFJUUWZWRFFsTDJwaDN4ZTFFYlVzZE5GSTJHeFFpUVpZ?=
 =?utf-8?B?UGVwRG9ibDVYUGowc3lzanIwMmE0SVBLQWJBSFdncFYvQ0o1bzlFN1pmVk1R?=
 =?utf-8?Q?WBDgHvLQYHdfX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE83N1ZyY0trNEg0dEZQZGVUaENlTEQrZC95ZUt4TTMxQVR3YU54ZURXdmFC?=
 =?utf-8?B?WWVqb1d3cWdwZEhHYi9NQ09QRGczb1JMZkdwNURkZXBDamVaVGswQTRsSmxZ?=
 =?utf-8?B?c0tVdFUzam5vNVo1YWU1U2pEVWtZRTZZZTNpTmNob2psem04L2VydzdTL2JM?=
 =?utf-8?B?UmhpOVFMSUgzYzdxbXNJcWh3dE9aR2VLVHJCZmN1Q01vODR4c2MzQ0w1UG1p?=
 =?utf-8?B?aFI1a0lTSVg4ZHRFZVdUNGVWRWdOSi9Nb1JCYWpMaExkOUZjWFUwM1pRVE1O?=
 =?utf-8?B?R0Y1SldjVmo2RUl3KzNYM3cvRHFvMVMreTNtQ0pjUEdPUVRoZVBmdkNWcjlJ?=
 =?utf-8?B?U0FrQW5vaXBWcWErd2FmTWIzckY2U1JnKyt2YmsvS2U2NWUzWnExb3A3d09l?=
 =?utf-8?B?Z3pESU53eng2ZFpWMnlEenUvbkJmZHpuMmZtQTg1aEE0ZzN5YjdWYlpVVlEy?=
 =?utf-8?B?d29vai9QSU05Ykc1RDBhN3hNaTd5R1JRUmNiQ0tXNnE3TVlwV3BNdXY2VGNR?=
 =?utf-8?B?azNQUFBucVhJZllCVzFlODR1Z3d4bnZlRUZqaUtEcHljam0xQjcrSlNLdzJO?=
 =?utf-8?B?WkFCQUprUjg3Qm9ZQW1IR2FiU2dwdkFjMHlVa2pkRGVJR3A5SlU1RW9LRFYz?=
 =?utf-8?B?NmQvSCtMbmxzaXpPZS9vTVoybGV4MVNBNWhsY3ptN0J2Q3hLbG03dWsxLzFx?=
 =?utf-8?B?eXNqWUJzT1oxV2FYekdxdHhZaFBKQVBjS2cyVGkzTkFoaWtVelFEeThOVWlj?=
 =?utf-8?B?UkQydXJXWWl3dTYwNkVHZ1FmcCtIN2ZPTG1ZWnVROEpia0JteFFoSXVyOUR0?=
 =?utf-8?B?RGg0SS80VG9LcVlQMFowaUxydzlTdnZPOERFNkRPakYydjNudGtNZURrRmlu?=
 =?utf-8?B?RUpQSWN4cENwaG0vNWRMVU1MR3FaSERIQ3ZhM1NCVjRiZ2tUZjU3cHJ3ZkRR?=
 =?utf-8?B?WTZlTXNUaXJGNEN5RDdvdGdsejk3eFJva3c1SDdROGhIa1c1dkxqaDZmZTR6?=
 =?utf-8?B?U3BTWFFOekw4alVzV0dGR0J4dThDdjVMTDl2N3BTNTAyY3R4RXJKMEFwODND?=
 =?utf-8?B?djQyWDFKMzhwK2I1UlorOUpGcXBPOFNYYUpyTmQyMWdUNHBYSU9NWmZ5dWNJ?=
 =?utf-8?B?elIxeGc0STBoU0dTby95WEFtdWZWUVBxeTBaM0V3bzZwMGE4aVk4TjN0NFNE?=
 =?utf-8?B?SWgzL1J2SllRUi91Wmc3Q01UaUZxQWNLbFFJMndyUVZXdHdsVzZKTzVzY0Fk?=
 =?utf-8?B?Y1Azc3pmMzNuK2hTbFBMLzluRVQrTXpacU5CN2JFNXdYdkpRVkRvVDZwakg0?=
 =?utf-8?B?R0xQTDh6UlgxVmkyOExiSjV0K09RNVVRVkhFRklqTy9UNEtDVFljRmNHRDAr?=
 =?utf-8?B?RTltL2tySG12M1FyazRpR0hydlM1OVl4M0VJc3N5QlYrdlZNZi9lM29ZUkpW?=
 =?utf-8?B?RXZENUxZcmtxVkpkWm00YWUyVzZMRTY2YngxZHpFeXRDUkI3ZnRMazRNQVN0?=
 =?utf-8?B?ODBVNHI4UVJjbVIwK3lRNGh3ZThpcWxkOTJtVVpmNzF1ZkhFSzhIS3h3TURC?=
 =?utf-8?B?RWhpZ0FDOC8rcjRRVE5VcDNkMnVjNDdwK0NFVUlScDNWTHU1M2E0eWFjT3Zx?=
 =?utf-8?B?cnZ0ZUozK25ISlN5K042ejgxNll1VEtPelVsUUxHQ3ovWTVFTEtqYTJHZkFO?=
 =?utf-8?B?a2ZWNWpiWDdRa2FZZCtRMGlEaXlOalNmbk9QNXRKYmF3b3RzbVg4SlR1N28z?=
 =?utf-8?B?bU9RMFVMSE0rSkhXV051eGFQbmZURWd5NktKTTh0NVYrQ056dDhsVm5ENE96?=
 =?utf-8?B?UmwxU2l6UEl1UzRQeVpJU2kvRXRBbzl0c2NIVmgyeGUyWXh5TkFxK1QyQnNE?=
 =?utf-8?B?aWYzcCtGb0xxK1ZETW0yTHRWNFlWTmFlcmpGZGFYMWg2azkwdWFkeWhnQWtU?=
 =?utf-8?B?MG5mazJyUXVXRUFJVk5aKzRpWVJtSFRMOU1LbUVQSHNmVnM2WlNnTno3aXRL?=
 =?utf-8?B?Z3NOd1diYnVtY2UvMzhOazZjQ1Vrayt2ek5mVk1kSmlwVGlrc1FNaEE5QU5t?=
 =?utf-8?B?SHRFcUkvNEU5VDlna2U5dUt1dzhUSnZJTmpqWXRNRGxNakM3S1pJUTBEYkl4?=
 =?utf-8?Q?CAsHyXtLwxlnK8sqitQO9+owD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256de7fc-6127-4890-ceba-08dd704c7b66
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 12:06:34.9516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+MdUal10drPKIUQ45kev8viLh+z9Eh+N0mkzaa5IX4s9XSri+/JqJ6q3nzs6514
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8921
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

Am 31.03.25 um 13:26 schrieb ZhenGuo Yin:
> Kernel doorbell BOs needs to be freed before ttm_fini.

Good catch, but does anybody remember why we have the drm_dev_enter()/drm_dev_exit() here?

It's clearly for hotplug, but it doesn't make sense to have the amdgpu_doorbell_fini() under it as far as I can see.

Regards,
Christian.

>
> Fixes: 54c30d2a8def ("drm/amdgpu: create kernel doorbell pages")
> Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index d4b01ef00025..b49604ade6c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4807,6 +4807,13 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>  	int i, idx;
>  	bool px;
>  
> +	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> +		iounmap(adev->rmmio);
> +		adev->rmmio = NULL;
> +		amdgpu_doorbell_fini(adev);
> +		drm_dev_exit(idx);
> +	}
> +
>  	amdgpu_device_ip_fini(adev);
>  	amdgpu_fence_driver_sw_fini(adev);
>  	amdgpu_ucode_release(&adev->firmware.gpu_info_fw);
> @@ -4847,14 +4854,6 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>  	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
>  		vga_client_unregister(adev->pdev);
>  
> -	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
> -
> -		iounmap(adev->rmmio);
> -		adev->rmmio = NULL;
> -		amdgpu_doorbell_fini(adev);
> -		drm_dev_exit(idx);
> -	}
> -
>  	if (IS_ENABLED(CONFIG_PERF_EVENTS))
>  		amdgpu_pmu_fini(adev);
>  	if (adev->mman.discovery_bin)


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFED4EB64DE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Sep 2024 13:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D17E10E80B;
	Tue, 10 Sep 2024 13:58:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zb4sUhKd";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5349D10E80B
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Sep 2024 13:58:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKvba6DZIcixH0adl2Izq9ZwzORQ11HSfm6MOLsmPDLagW2HFje7Zyxfordl/+SjplG/MYnRrFvUh/dHdaiuWzlgf4eBVsTjo0UJeUS4jFVsYto/LxKifzLsEv5da/bm3f60NztIAyX0mmBQTX4VfnEhm6VWYGNFEAQybh2Td+uRNRXJhbfrI6PIGD5ec27nah6iaEiJt39T/pGmwno5HArkvGxx3vz3LI0uL3ZaP6SgdFxEywfEsy7noSr5AemfnT0jL9qOZ3duquyfDtOa2mhxBJw1sX/9k4xtLjToXcUuYjSQy+vfMx6Jb4e9JsLQWLMSOFOMAuG84YEDy9+5Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8m69RTBRTqb3iXhXV4O6VXThBI/3pHuMQ0QEUes+638=;
 b=gv1gsmZaPeaIrSKYa6WQS15khftOuWiAosCxmh6PNVYR5qrQjZaNPmOSYH1JrcciXH3ik967FCQqzLPgC2mRxLSjJszHNzJUKFqeLCos84tmjYkgQecdPpRXnz5lGwzJgDdGHfXSP1qQiY+mMp+hEZX4xeDIEYB/kMg/46Mj2VTBUKcjLP1h228XadgFfZzbSbwly2g8wDMIkC4UHp8y+8BDitTFcGakJVcP24G5jZ49X/a3bDSJAuGZoJs6tKDOZG7TIa9YvmQD0KMmRmBSCuoHN9T0r0Eo7OEwqtD4ez8fXUFIqahr7YAvJDBk4vvoB13E8sJyW8pZetqlHsPPVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8m69RTBRTqb3iXhXV4O6VXThBI/3pHuMQ0QEUes+638=;
 b=zb4sUhKdem1SG7af4RQLkDnEZK96hA82XyjYlKIcwdVDu5gH4FwFZeiAwEBuBCbBUm9BttWj8G2m6KZrYqBQldaGc7z7QRiJaeCtgbN6xatVRGh+muKZNqTUNp0CI4MH2ONudE75x0bRoPPHzcTvlduQM9G0UFIbIC2iQBvO5IM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.22; Tue, 10 Sep
 2024 13:58:38 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 13:58:38 +0000
Message-ID: <62c226ab-8006-406d-94ce-31df183e435e@amd.com>
Date: Tue, 10 Sep 2024 19:28:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: disable GPU RAS bad page feature for specific
 ASIC
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
References: <20240910083739.20813-1-tao.zhou1@amd.com>
 <dd38b339-06d5-40d5-8013-523bf4ea9c48@amd.com>
Content-Language: en-US
In-Reply-To: <dd38b339-06d5-40d5-8013-523bf4ea9c48@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::20)
 To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: c542b479-452a-4fe9-2de1-08dcd1a0ab72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QW1NMWZ3RVltaGlwdzA1TG5SaW9YZTNUeDhTQVFVckJGVzJRYU9VQmVMaVhz?=
 =?utf-8?B?QzhGNjYyRFZ0Y0dUVzhiRm4wZjhCVDVRbCtLL1JqbFkrVlZ0RzViWXVsN1k3?=
 =?utf-8?B?OTVuWWhCUFlJQWplcmoyOE5zaGwzMXBBWWxYYklCUDBBUHBxSE4vVTVzM01W?=
 =?utf-8?B?cWRob29seEJzL2lrajc0UlAydkF3VEFlQkNLSjdCK09QQjgrMFdWUmUxNEVw?=
 =?utf-8?B?WTRDNU5JelR4VDVZVXN4bGJreDhSSVA0bTJWTFJ3ck9lNStOdVhrTE1pQkNj?=
 =?utf-8?B?VHFUTHFHdEZGZkJHS0VEV3hncjRDUHp1ZGhBNHk0ZStEWUlVcXVSK3BLU1Fi?=
 =?utf-8?B?STJXRnJKWk5lZjlNWDI2RVpHMHZ1S1RWSzFMaEYyR3l3aXFqZUxBaHoxZFAw?=
 =?utf-8?B?TVRUQm0ySVUzSytJWjVpVHJ3dzdJMEFsemxsc3dRRUZFM2ZpRkNXSk9HK1ln?=
 =?utf-8?B?OWxnZXpvbWZqOHk1aXNCQ1YvUXhKdW5tMnAzc1RheS9PVDJVNWNia29XWVd6?=
 =?utf-8?B?MVB0RFIvVWpIK1ZlcU1ubXFZdU5TTnNlUmdvaHFGOU9vQW5oL1ZHRGE5VFl0?=
 =?utf-8?B?dU8yTXNHd044UCtYdlMvZng1ckwzSHQ2UW5CSXJoUmpaNjh2NFNPOEN2L3Qv?=
 =?utf-8?B?YWpvazc3Vm8xbUV6TWNSRjFjTWJNVlhMY2o0TGZEdThSVktJd0pOUzV1bFp0?=
 =?utf-8?B?SGNFNGZieUs5U2ZTcmlTRkIrZ0prK2Y4Z0c3QkFMWWdwN2Nldis3c1NERXc1?=
 =?utf-8?B?WGUvZzBDYWtDZG1pQ1N5Qy84UFo0VVN6L1BlUnhtOE5CTi8wM3BKRGEzNlZB?=
 =?utf-8?B?ZlA0aEtiejZ4Yko3K2NaNHFwdkM0MTdLeUlDN3p5VWxtSVpOazNFU1g3YWxu?=
 =?utf-8?B?RUNnTzh4YW5xQVhObnVkdW15MzdWUDVQYlJZZUVMMkRUVVNrcHY3cWwrbkdK?=
 =?utf-8?B?UzY0TWpUR0ZtV0VyUTVtVnAvT1llcUZmTDA0R0dqWGgrbEZLU3prVDhzZjcy?=
 =?utf-8?B?eDVZemwvcUx4WFJWNVdHeXNUZCtvUXc2OUNPYVFNWU1LaTJrSlhyN2pWcWVY?=
 =?utf-8?B?dTdEc0RXM21RbmJWLzk4QW1DcVlrdDBLUUZFRmNtc2ZHc2YzdjMxQ1RhaVV3?=
 =?utf-8?B?Y09yOW5oZXRmNHhrMllJaUVNYjdXaUg0UEtaZTN2YThJQ29yS3djYUkycktj?=
 =?utf-8?B?MS9iNFRoNFprMGpqdjNXKzdoYnRlbmU2V0l1WmY2YjhoRzN5SjZlYy9hNFhm?=
 =?utf-8?B?ZGRURUNWQUNyVWZvaFRLSTlqRHk1dGxpV2lUSjhpWDVnVzRDOGxCNDI4YU9I?=
 =?utf-8?B?TWdnbFd6YkZaa2R6K1M2NjNMV29kbWV4M3lxZkxOTzMrbUxiQnNmcFplMEpp?=
 =?utf-8?B?SlVtNmdmSk1lV3pPSFVYaWNKL2dvQ0d5Q0lqeVlObHl1T212TDVaUjJCN2xy?=
 =?utf-8?B?TGVJMUwvOUpjU0VaS0ZEUVBIWUhaYm9Zd1BvVSt6UWhBak5iMWUydWNiL1RS?=
 =?utf-8?B?SzFnMGxtaDlIUmtMNGNPakhiTVVLcXNmVkQ1OGR6RU1GMWhjbm9pTUlWSHVz?=
 =?utf-8?B?a3pIOC9IMUZvT3NGdHlJdEgxblVRQkxuVHpRVStlcFJvZXVmMGtaSzNvZVRa?=
 =?utf-8?B?NGQ0NTg1TlpXV2dURC9HNFluOHUweHhiK1lTbmw4Y2x5SVgzYVI2c21tWnNI?=
 =?utf-8?B?dWQrb00vWFlPaTQ0aVFRUTg1RXErMXpaeE9mbVpXREpBdmpuQUpyOU00bExQ?=
 =?utf-8?B?U0NOVHQzQVBCOTExSnR5NDZtdkpKNUUxS1piM05hZkVlOFBZWnZxaUlOZE5S?=
 =?utf-8?B?NVdnTVkvMVlJcTNQTVFpUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnhBenhPc29SNTNlcEMvOGpGb2I3bEpoRHNRL0ZtV3FkbS9BV3YwR0U2L2I1?=
 =?utf-8?B?dkd5dVA4cHFwSXNZUmp1Y0VJcC9rTXJjblRHekw1WHZxK01EcnZtb3dPbmhw?=
 =?utf-8?B?ZTBZc1ZtL2tvaHlNS0RVa2lFTHFYWFdGRWRNbGpocUl1NlF1N1AzMUdKelBY?=
 =?utf-8?B?enk3dGZ3VzgrTUR1bklMS0o2K2RtSmdNNSs3Yk9PVFFqaEhQa2Y2Sy9MSmQ0?=
 =?utf-8?B?Nmk2QkpnMmVsMWc2dVZRc1FjV25EaWZ2eDBoNHVDRDNsUjFKVUs5NUt4eEp4?=
 =?utf-8?B?WHYwQnZtSDBHRzZ2bncrYStBUXA5UHI1UjhlNTR1NDFQSzNqMldkdS9SbWZ3?=
 =?utf-8?B?RzNYM1AwTy80c0xUbnFncmRJZHJoQmxqYlQ3bW1FOFRBd1NadkJvQ1pyd25S?=
 =?utf-8?B?UXROemFLMHo1TnpHN0JMcS8zQzAvbGNPTXQ3ZHdsR000U1VsUTVFQ1JyS2lS?=
 =?utf-8?B?K3pMYU5maGd2RHVScC9sVEV3VGR5Q0JmYWE2TEhtRFFiL1RUdXdYQXhUYTFF?=
 =?utf-8?B?azFGVUlmcTZQQktWMXBqOUs0akRUdGQ4SlZGeVgyYTdYUU1Ta1dwd1kyOFNJ?=
 =?utf-8?B?NGFvd2dQb1d0WW80VW04S0Rja2Y1c04vQjNnbzczWG5zNVNBZXdRb1d2QWgv?=
 =?utf-8?B?TGRtVDRTcms1WksvSHVXWTdNVlJ6R3BvVlFkc2xNRTBKcjh6Y2pmMkROQ3Bn?=
 =?utf-8?B?YUlmbGtSSEdoanpxRDJFZkd6ZnJpM0ZnNTdCL011UTFIY2xLRGtTNkF5Rlgv?=
 =?utf-8?B?QzByMHAvS3U2bFJFRXA3U3pGNWlTOHkreklxak5Eekp5MkJ5WkZXSStZZDdj?=
 =?utf-8?B?SS9JSldLNHZ5akdxRkg5QUJwSWVGb1puQ2NyN0hDcCtvMFdzRkFoemgybjdz?=
 =?utf-8?B?WUNvK2tMMFQ0eVBJTjJuZlBtUE9UcWsrVmdlUWxicnZpeXhtY1NJK0dnamFT?=
 =?utf-8?B?Y2F6QnFhNDYvZGR3aWVsY2ZEM3ZraExrbWpXRE9nUzErY0orT2gxa2wvU09v?=
 =?utf-8?B?VEV1bkplZUwvWU1ZaHlDM1Y3Yi9xUjRWR1BiZHVUcFdBTUlHR2NaRncxQXFC?=
 =?utf-8?B?R0FkR3UwUjJRZ0V6aWI2YWVVSWRoYWxPNk9jbmtjTk5wKzIrNmJ6b096MG5z?=
 =?utf-8?B?TnlQMVRvT25WdFdDYmZZK041RXBVSm9HcGZlWWY3dkZ3djBmNnVsOThrYnpi?=
 =?utf-8?B?NVdpWG9ZQi9YNkJGSXo1eEd0RzkyaXlFeXRzbDU4cUY1Z3c3R1U0cDBxbjdD?=
 =?utf-8?B?bDJxWndiSVkvZXp0YzRGKzdqVWd0R0JjQStidDJWNU4vYWRyRy8xb1ppcHM2?=
 =?utf-8?B?dTF2bnhuY3FoczRXbkVGa3pIb0s1T2FvR2tsbkJFek5RT3ExZHNHT2QrTXVR?=
 =?utf-8?B?ay9CZEo1S21FK3B0QVhTM2k3Qzk4ZUhMMTh3WlNXWlNrQnNQOFh4eTYzdzRs?=
 =?utf-8?B?eFhnR1YxZmtjUXNuQTBKdlNhYjJNWldlc1FWRVdwTmVXRURKU2Z6QVhjTXF4?=
 =?utf-8?B?SHYvaGdSNHhuaU9YaWxXSlF0VzBHRjYzc3pHVjY3VFJSeXpJTTh6R1JNYmxZ?=
 =?utf-8?B?UTEyNlU3RUN1MDZvdzdLdlpPYU9yU2JXMkNaOC9jR3ZMbUlubDF3a3YzZmk5?=
 =?utf-8?B?b3FqSk1JUE5jZ0JQTVFqVkJDalNBR0w5VzVJRms5M1ZyYnNpR0JFdnFocUg5?=
 =?utf-8?B?YnpQODgvLytFaCtQTDlBMWZlSjFueGZFbVJPYno3MDRYaWtQM3NiZ3FTNGFo?=
 =?utf-8?B?UFhUYUkyVmVvVEJBVkVtcGFxa1FVTW9pc25DQjJUK1B1eWpJVHE3NC8xRWd4?=
 =?utf-8?B?Z1dpS2Exb3Nya1hWUzFpSTFab3NQYmFEamtHZEEyaTcrNHFFbnEyd0hGTFly?=
 =?utf-8?B?Ry9IOGtPNmdvMjh6M0tQay9NM0w4dS81ZnptL3hBZDNUN3A4cEwyMFYwU29J?=
 =?utf-8?B?WXlVZUlGbHZUZkVoaGl6NjlxdGtBclZuUG04K09ZVzVDaURJbFFJZ0o2UVly?=
 =?utf-8?B?Z1d0UVAvZE1lYkJTTUlEZUZiNWdvUXZFbi9pcjV1NklPVHBPcUVJdUpQd0gx?=
 =?utf-8?B?T3JuRTVGSU1PQzVJTTNFWkhUQXU3K09CeEhiUGxCVkEranFSMU53WGFQTjBj?=
 =?utf-8?Q?mlWa0RTNkejx6RJVENgmzrAU/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c542b479-452a-4fe9-2de1-08dcd1a0ab72
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 13:58:38.4297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dSVs2O5xHr0LJBI6tb89kd+DSRL3ahw5BxAjymAaKIawNjkVmNy5upIRM2k3sGk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710
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


On a second thought, this may be made more generic by just checking APU
flag - holds true for any APU in general.

Thanks,
Lijo

On 9/10/2024 7:24 PM, Lazar, Lijo wrote:
> 
> 
> On 9/10/2024 2:07 PM, Tao Zhou wrote:
>> The feature is not applicable to specific app platform.
>>
>> v2: update the disablement condition and commit description
>> v3: move the setting to amdgpu_ras_check_supported
>>
>> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
>> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> 
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> 
> Thanks,
> Lijo
> 
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> index dbfc41ddc3c7..ebe3e8f01fe2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>> @@ -3483,6 +3483,11 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
>>  
>>  	/* aca is disabled by default */
>>  	adev->aca.is_enabled = false;
>> +
>> +	/* bad page feature is not applicable to specific app platform */
>> +	if (adev->gmc.is_app_apu &&
>> +	    amdgpu_ip_version(adev, UMC_HWIP, 0) == IP_VERSION(12, 0, 0))
>> +		amdgpu_bad_page_threshold = 0;
>>  }
>>  
>>  static void amdgpu_ras_counte_dw(struct work_struct *work)

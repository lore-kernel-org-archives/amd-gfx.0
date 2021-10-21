Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04614C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 13:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C17226121E
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 13:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C17226121E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 654E16EC77;
	Thu, 21 Oct 2021 13:40:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6C3A6EC75
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 13:40:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlJwd5ct2yJLDOdXMIN/zmdd4G50v30gBmlTWwJpJxwfS51WsE5Z83DkIT+fu6mG/gXnKvFWkeR2uR1dLyCpOTs0EjRoMfEA/MGNKPxOVUJsEznSROWjQwZGgsi7kEqFgEsa+wrwHUTveo71779D+b88hA3RHP4r4jUzvYSvhx7lkaVnjotVAtnAG/dmELThSGOAPB+ZY+b3wqDMm2JkBqXafhCY8y1QILHBHxeq9ahQ9ehWr+Izf0KNWq4lYucARHcLcaa9+443XXiQu7PNC5wlOc6qW2V8oqcCa/wizPIUSj+74SL69BpmOYBhFJg0SRzdWaJ7K0A20jRuxSAkOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5rpDY40fnFQYMu8V5Jn3Qun3F8p0D2YfegF1FaapeU=;
 b=dCddZMFH2Xo9Lha/yKaz29pqsWXzfa9vWYFvvLoFsjko8Y69cbkKerxL9LzKePrdZdrGaCog1m79WomX/TiV37oX///MuR5Pc8k3wuYxghvwkGnCfITJrD/JiutwVRssdzsccJFe2ovEn6BcjetekjHFYuqQQRaqYUL7C8FKEoUApW0THlrrPtZNTuCiz9lUkLupEdcY8khMPJMq5UQNQxgHe7XDIadPFDzQSCcJ1sDn8csyRP841rzuomg1N3I94Pvkq5BoRV4T5dmAQcdqNotyIHtAMDQjJmKbXpk1m1rKCIYeGKQWn2cJQbT74od8QnWmzmpRqCbvFlGjYYGaTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5rpDY40fnFQYMu8V5Jn3Qun3F8p0D2YfegF1FaapeU=;
 b=S1NZqhO1/3uu+Sp3FdbPJJrSUNcPYEQhAlNT+OVA4UV23q7W8MqftIpEsjcLaySF4dlVnI4Z2qQdUonnvWCfrIrHM/87DEv2SVPUE8jcdiaaAFsvLF013XeK88iCBJQ2AQhzqpMMAjp6A9qchxqVLoGFhmJCfXEFLp01DV87wSE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 DM4PR12MB5230.namprd12.prod.outlook.com (2603:10b6:5:399::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Thu, 21 Oct 2021 13:40:13 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::601a:855c:7c9e:220b]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::601a:855c:7c9e:220b%6]) with mapi id 15.20.4628.018; Thu, 21 Oct 2021
 13:40:13 +0000
Subject: Re: [PATCH 4/4] drm/amdgpu/vcn3.0: remove intermediate variable
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211019201044.426871-1-alexander.deucher@amd.com>
 <20211019201044.426871-4-alexander.deucher@amd.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <a08abdba-acdb-98b0-72e1-0799849e19bb@amd.com>
Date: Thu, 21 Oct 2021 09:40:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211019201044.426871-4-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::17) To DM8PR12MB5399.namprd12.prod.outlook.com
 (2603:10b6:8:34::5)
MIME-Version: 1.0
Received: from [192.168.68.78] (173.35.226.30) by
 YT3PR01CA0106.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:85::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 13:40:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19036d0e-3969-4b22-d622-08d994984ed9
X-MS-TrafficTypeDiagnostic: DM4PR12MB5230:
X-Microsoft-Antispam-PRVS: <DM4PR12MB52300F73F121D9D0C0D8D4BDE5BF9@DM4PR12MB5230.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O7taMlQGZPPjJ2POvs8Jog9h19OzFNxUK13WyfoRttnkaXRx1HuNmw1e67oUISUmC0fxX8p1SVcZ2mWPKRJhD6xCum2qe7Z91oJGYJskllfbjpYTeA27gx9+2TqS1yVjtpyb3Qwm/IGE8glo99DRTIkXHDagamRH4MqUv9XsrKScNG060rKXM6VYS6c70/6GdIBEEey1UmTGkz+t7tMuO9T4vVP2UiogmmHWA06o+vL1X+AXJVSX6KwTN4i+h9uveell+q6HIXhRKHCyIltIQHAIGE2Ao3GJ7YNqGMXWE9M2BdoB+4mIDodgOzWYBz6tEnMuA9M1acgw2g6YO81iVQXmZzL+PWYCkM/018WX3ne9+rwosJ0kJ8/iPA65t0VU36O7acOz0a/CrlDNYBlk5oFIkNzcZz2/HDTDS1bHpOhP2G2V0XQAqhL2cnc9vLtAdei4Y672/h7c9qBF/syjyqR5SmBGeRMQNRDUGhAac2bwYg6NxJHsU5mFNrSKIf/DKpinwrcQWSeKlQwfmIigUwsSZczbXqiZR9L6Eg0DV6No+AFToDGiCGnK3KRX9DDQNricQf9dzBGiCNRf/4zszRjG+FW8p2rZD8kyrLX9w8Z43NHkHyID66P9KD75pQuSHsjElLfa22mtTAngF/eQOZzQczZYrij/LwWhc8uoELx8lx7hAuuAijFlSPIXJSkAsbmVuK3ryFk8qLQ/DI9G5MaQqjeTSqluvLIGXxdZKMpFJeq+4eEAZ2xmIolRNJ8/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(66556008)(66946007)(6486002)(2906002)(2616005)(956004)(8936002)(186003)(4001150100001)(26005)(508600001)(16576012)(5660300002)(8676002)(316002)(53546011)(31686004)(31696002)(86362001)(83380400001)(38100700002)(36756003)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGt4cS9PVEVBOUs3UEZiWFMwU1NaQTFQTS9ieHorRTFxVzRwWGJ3RFJoQ1dM?=
 =?utf-8?B?MnVqWEdzdWdWcFdWajVPM0VsYm5OTUFoVkg1Z2JJZDVOSlZNbEVUc09vbTB2?=
 =?utf-8?B?ckxXajUrcjBUVzZuN1l3L0Q4MnV3NTczWStGSHdiUFR3YUdGK2FGSkFqcENn?=
 =?utf-8?B?Zzd3R3FTSlVtVjMvQkJiaVQ1WGQ1NWVGck90UHpsLzhJZGdwbmRiR0pCbWJm?=
 =?utf-8?B?U2VZaDdtTXNRaWF0WFFrbWlhYkl0Q2QxOW5KV25SUkMwNXVEdndHL25wYzFm?=
 =?utf-8?B?SHIzNVczd0JQaktLZ0hJSC92MHliYUdaMHlFckFKc0QvdGp3UjltTFoyVXNr?=
 =?utf-8?B?VzZnSXZLNzNBUHI2bW5QdG9pcXJ4TTcvZ042S1hnSHhBTVRGK3ovbEFUQnhl?=
 =?utf-8?B?WkxMaVkzQXJqN2Y2MTN5Q0JzRnFpaGgwMlRoVHVwdW9VN3RNVG5wL3JUUkg4?=
 =?utf-8?B?cGxQOGtmdE1hckZkWU42UGlYVldteHZlY1kzQTY3SSswRHNmUHJiNGY5K2FN?=
 =?utf-8?B?NStHOExNeDZhMGdkRnd1eHc0NHZrNTlwc0hhS3BkT2Q2aEFSYlM2My95b3cw?=
 =?utf-8?B?OGRJMXROQis3eUlXbkY1anhDdjNkYjZiZVRsTXpWbWhqeXBnb1VmbHg3aE5M?=
 =?utf-8?B?RGd1czBicGpWN1hBbmtuMEsxTFprV0orWWxvU3NHb2hiVStSbGpHUlg5cWFD?=
 =?utf-8?B?NUdoZk44SlE0ZkRmMnR1bFpMQ2NEanRsdXZEZ1NJTVNNTGs0cit0ZGZZVWcr?=
 =?utf-8?B?bkpKT2hOMnlLRXJpb0xKSUI2cTZSZCtxZFRNNzkzSk5WMUFKcVZDa1Uva0Qr?=
 =?utf-8?B?MWovOVF4Wm40Qi81aUc0bnRhaUoydWZ6RVI3S2J4K2lJZEovdDhvbjI4MUJu?=
 =?utf-8?B?NVdNQzBHSGc4LzMxOFhtb2dtMEN2ZThjTkxCb0dicVNFYnJXOVRoNW1NZ2lW?=
 =?utf-8?B?djBsWm1CUXZrZlVZTDJmZU45eUNEQ3BaeDI1U3ovQ1krc2RGakVHeHpPSVlC?=
 =?utf-8?B?bjFxWWwrbmJxbitGODRCc01uS0Q0a3lDRWdWUk8waHgyUGFsM2pCNHRYdjZN?=
 =?utf-8?B?RzI0cDRuR1hhemVmZWN0SUw3WFhYTElYQzV2a1I1MmF1WnUxb2tKUXBYdWZF?=
 =?utf-8?B?N003aVp0dk5FU1NvcDJMU3ZyZnNTTnhybXpYeTJvbmljUllEd1ZCNzIxNHNp?=
 =?utf-8?B?TytqdVJlM24zTEJ0RVNRd2NGdXc5YVA1MlhSS3FPR2hwRm9xdTh3R1ZGaEFk?=
 =?utf-8?B?RGxxbFVibDFxMVdabUFlT203RGhKM0VmYW85NlJ3TnA1ZnFkazNlNjFKMHR4?=
 =?utf-8?B?Y1N4MjhxM08wdEQzT1Z6dlpRTGc4RE1LWWxsaFJBWU5tVFBuRTVZY244STNr?=
 =?utf-8?B?OHc4bkR2NU83bUNtWldoRjN4OTdHSm51ZzlhZWluQzd4eUhzTVM3T2ExcitV?=
 =?utf-8?B?QmttSjVobkZ2L0VnNTRzc1NRNVYrUCt3bmUwTHd0bStxNjdMRUVJRmU3NzZh?=
 =?utf-8?B?RmNXSnpkV1habFNBYU8xVkxLT0Nyb0QxQ1VqbnRIRk5IMWdmUzZvVFFSekY4?=
 =?utf-8?B?RUQzRERiTXVLSkJBUEM3bTU0QkFOZ1lmdTFIT1hMdW5FWXBWZkZpNndpN2VJ?=
 =?utf-8?B?aEhTaVVJU3p1M2FycXAzSUJWczNlUFpGWnNBVUFSN3NLcjBVVU1TRUtHdi9R?=
 =?utf-8?B?M2ZQbWI2QVJZVklOcmE1NW5yd0ZnTWhSNkRJa1YvU0dLQmlnVVZaRWM5OS9E?=
 =?utf-8?B?ZExVKytMdGFGcDBDays0Mml1dElBeEpRV2cwYVlIRVgyMWVEa0xYcWZDRWY0?=
 =?utf-8?B?THlZYWJvT2VkWnoxbXErVFV2ekc4b1JXNjdrbWVrRHYvMGI1K29ibk9uQlZp?=
 =?utf-8?B?WkFhQzJJT3BQN1pFYlpMVk1UNEpJejJpcFZkVXprK0tYZEwzOGcwMHJVTWFH?=
 =?utf-8?Q?7PZ4OIyY6HU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19036d0e-3969-4b22-d622-08d994984ed9
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 13:40:13.1162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: leoliu@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5230
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

The series are:

Reviewed-by: Leo Liu <leo.liu@amd.com>

On 2021-10-19 4:10 p.m., Alex Deucher wrote:
> No need to use the id variable, just use the constant
> plus instance offset directly.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 57b62fb04750..da11ceba0698 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -60,11 +60,6 @@ static int amdgpu_ih_clientid_vcns[] = {
>   	SOC15_IH_CLIENTID_VCN1
>   };
>   
> -static int amdgpu_ucode_id_vcns[] = {
> -	AMDGPU_UCODE_ID_VCN,
> -	AMDGPU_UCODE_ID_VCN1
> -};
> -
>   static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
>   static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
>   static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
> @@ -1278,7 +1273,6 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
>   	uint32_t param, resp, expected;
>   	uint32_t offset, cache_size;
>   	uint32_t tmp, timeout;
> -	uint32_t id;
>   
>   	struct amdgpu_mm_table *table = &adev->virt.mm_table;
>   	uint32_t *table_loc;
> @@ -1322,13 +1316,12 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
>   		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
>   
>   		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
> -			id = amdgpu_ucode_id_vcns[i];
>   			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
>   				mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
> -				adev->firmware.ucode[id].tmr_mc_addr_lo);
> +				adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_lo);
>   			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
>   				mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
> -				adev->firmware.ucode[id].tmr_mc_addr_hi);
> +				adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_hi);
>   			offset = 0;
>   			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
>   				mmUVD_VCPU_CACHE_OFFSET0),

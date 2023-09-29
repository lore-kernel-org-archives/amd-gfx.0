Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A925E71D4F
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 15:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A681B10E10B;
	Fri, 29 Sep 2023 15:23:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F3C810E10B
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 15:23:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6++chh6ZCeb8iNYAVazozKuxr//BYQ8+IulyHLyU/Xmw4qwB7vkluLGmYEMAnqx65hcdwoERbNu5M7d+A4JbynkuvIEgDGlM+RKz95JriK/V36yL59lKvdz+jFVhYyulvJh6+RzCQtT6BlW8y1kf/AclP48McxIAM2cvImEZgJdBb+HjqvPQpj47OeYZq7VcqyfAliuSFbiNAuc6ZFQwONGfu9i23DGQcunoQCGYmIubiGwNH92uYjtWuG+cCix30++fGIUfE4xmc+YY84/E1Tgg5b2jsSCJbu3xOxkX6kY3/IMsixzl8NRWoH8l28HWUPoi+5FuRDSfGFTxq+cdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uSIc4ylU6X61BSz5GSuf7VClyD0KqkBGuD6s5ijrcy8=;
 b=Kij0M3xsbgBYWvIi5vQ2Ft1/TuVFsbaIci5P7GExcVrOMW8D7F4qfbPabLVqgJ9bhnLq/G2oPIlcu2XkH6hoJJhJu3eFd/qWTTswS5HnFTDF+H6SjDOW55ol34wgVo5xZ7PAK4gtPuUYFgkVuF8vN1WQIS77VEJcbYzuVl4D7DADdDyNHs4ItY+GCPfshscu5WZzNBxnQzhHelWIhi1YWf/nMDpwQ3RjXS9vnIeM4zvjv3f+VqUFuVrb9MJmrUpr8OkKE9lDE8iP0lCMbg77b+jC8bw4UzvYpRbHefUp7u1q7xM1QPWHvuhjwd3dQb3QZEk7aBdovSBgRn6ROfYPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uSIc4ylU6X61BSz5GSuf7VClyD0KqkBGuD6s5ijrcy8=;
 b=vOFeJu4PZjvvU/GqpxUDmlmj8zal1xlKlstlXT8O+65EdaRl444oDt1TxeN+pfHj0VhjHJ1Ho6VHvay+QfXxOPK58NfWKoduZ0hl12tDaZTv5DbegfplP86OkJ+tFkoaUV7KvkBxhvtGecHkHZKyZEOsJz8J3J7hiUrzPgY845Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.21; Fri, 29 Sep 2023 15:23:18 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5aa2:3605:1718:3332]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::5aa2:3605:1718:3332%7]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 15:23:18 +0000
Message-ID: <2bf271de-c020-4d95-96bf-7d488d5d14c9@amd.com>
Date: Fri, 29 Sep 2023 11:23:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd: Fix logic error in
 sienna_cichlid_update_pcie_parameters()
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230927020743.387802-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230927020743.387802-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::38) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|DM6PR12MB4579:EE_
X-MS-Office365-Filtering-Correlation-Id: a468fb9a-2ab5-4265-5c6b-08dbc10001e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n/DDCmoLJyeChaZjoHq1Za/oSQma8KoHNnFdnak1actyaT7QSCqtyTeK8ecurHQUVkDNXmdE034PRvUYRvcKUptX5AAr/7xzfMLA/QSy8TbeqWnLfgZa+6uOuj6bhvGwKChkGyjVBDd30EN6DHC4DMiMmS8VXvxH7AYjsPLZEG+66yxjENUNbdmp1aQ0GGKv64UpXFV2zaRMXdtPJTcFnGrZKqZCPosDD8YRlmWEr4kH67ezejlgqMfm6hvLfFobEhYpBuDSD4TmVRXjO4nYlJSBZsaHYBB2p2eT5ZcYX1RNYifMWttH6nzWNS3aQthGIQQeNweVBrNjX3be7+q7mBDC3ucjvmD9NtSIeuFtdvxldNvVapKLK7wViazp23rAeObzUYvH9K7W1jDbmYDE+IIedcxXbwoiw2aRF7jSFsDZeG4v8eOaZ7VucPiQzoah2RjB4ZJY0lf6nLww0fFtPLkfoWFutZPhp6ZveEGP8sVI5T3jQb6GV4JRFHBpdus9kVMhkwpvqefQHb81TNHrG/lsmP7jztc6aPXqD+g/pyo+c1qB8KwtH0HfkJPpTFOWRr67SZrWaGvuqVZNjqO1N4MvysX8SDEbe3eHx88j46sTf8jRjAvo0FNIlm2eoSPj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(346002)(396003)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(66476007)(66946007)(66556008)(316002)(41300700001)(478600001)(6666004)(966005)(31696002)(38100700002)(86362001)(2906002)(36756003)(8936002)(5660300002)(44832011)(8676002)(26005)(4326008)(83380400001)(2616005)(31686004)(6486002)(6506007)(53546011)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NndiMDc2a3FvajV6Q0l2WlROeUlxamNoeE1jdWhOSlhZUzFHdUpwY3Byb3FZ?=
 =?utf-8?B?OHNrd3lIanRicHBIelg1ckRpb2N5b2ZWcFcxN1ZueDV0WXpsRFRodm5BMzRH?=
 =?utf-8?B?bDN1bHltV3FvN0o3ejBXRm00clQ5akkxMXNsWmhNdGZGWi8wdVFVcnplc3V3?=
 =?utf-8?B?VkNsTkpPMVVnNGZpVHYrcjNtL3BjMUhkbnk3ZzNKOXRBNTVZeGhKcUpLazB2?=
 =?utf-8?B?WE0ranVIYVdwaVNsRTRhYnhmY1pFcmpYNjBNckt5Y3d4L29pNE9WSk40bXlp?=
 =?utf-8?B?SkFUVVJhY0w0R1hpbkhpanc4NDYvblMzdHp3UnJXbjdxdmdGcWpTUWUzMHNC?=
 =?utf-8?B?azdsN1hESmFyUG5VK2trVHN4RVljZ1Fyeks1cUlib0o2bkc4OXgrOFJFcjNq?=
 =?utf-8?B?bTVRQW1jbWZmQXlRWVoxdTVwWWNtMTQrMmk1NWM2am1LL2JiTEk0NU4yNHdE?=
 =?utf-8?B?WHhxdUFMWGZFdmZNUGdQbnRYVmtnWnZDZzFmY3ZubnRBYjE0cDhXL085ZWQx?=
 =?utf-8?B?aWtJaThYQlpjTG02TzlJNElyRXZCaVRqU213MDBROThpc1NrQk9uN3k4TnVG?=
 =?utf-8?B?S0o1aVA4d25qaWh4V1U1U3ZNRHljblBQZEZVWUNJQmdCY2RBNFdZL2ZTYWR1?=
 =?utf-8?B?L2xudTVBdDZVZ1lRaGZNOUlvMEtFQnhCUHZlTzlFNUp0WGFpbm9nZEMweGxW?=
 =?utf-8?B?K2taT2YvQWJDenBPTlFkaDhiSzRsU2RMa293cVZNM2lic0xZUjYvc3dBYUc4?=
 =?utf-8?B?WitsN3FKNmt3MzhoTlNpQTdGd2oyOU1zcUlqUFhnUXhCZktrellLOVhuZW9m?=
 =?utf-8?B?Mm5RUzBuRUNPT041WXM4Nys1VkJ6cG5zby9xalhYRXBVQ2phVlZEd3gzandH?=
 =?utf-8?B?YmVGUjFoUEdZbVdGRjBjcE1RNjBsRmF5a2RkbmVhQ1dUd2xleWVJbEpQRXRE?=
 =?utf-8?B?Ymw4WDFkN3d5NkczeGRZS29VVTJ2dWN5a0tEVmc1Mk95WDRlQy9XUTJEdzVn?=
 =?utf-8?B?K093NStkd3Q5WmRzZWRpc2tsaFl2RFVpbFJudjdXWEdxWTF2UkZlWklIU0h1?=
 =?utf-8?B?VkdKQ1ZGdUxYUG1jb2k4UE42MHE1UlZ5cEFKWDdmaDBHYktpSDJYSEs2K1BJ?=
 =?utf-8?B?NC85eU5zUHMzNHFjQTl6cXFUNTRuOUl4dUFzUUdsYnhteUtRSXNUcFZTenRx?=
 =?utf-8?B?TU1uNExZNkFIbEo3bzI0LzhIbjh2ZitiRU83UWJpZC9ha1lwTUdYb1RqRmVM?=
 =?utf-8?B?ZXhWSDlPeGNqZnppaGZIYllObndHRHRMY25SNTFZQ3RjaHlYVVRhZnRNdnZp?=
 =?utf-8?B?bXRFa3VBRk9uZkpTQ3RKWktYaEp4RDhabHMrZGVTa25yd1lWOFhUeDZJbnQ4?=
 =?utf-8?B?ODZ1dVVwbktrTXBPSDVPRzB0dkZET0plbzlBQkhMRWhPbjhVTjZkWU5Jd3lS?=
 =?utf-8?B?N1ZNRDJERWZMSDA4MWpHQVo4SStVUllEWU5CVE14WHM5SDVwZm1jRDRkeDBV?=
 =?utf-8?B?bHN1Z2dyRWxES2FRVnNzUTY5dTA3UFpRaVlKWVVVZWd6KzlMdUVKSnVHN0M1?=
 =?utf-8?B?Vys0dnpKNUtEQ0owSTloaEh3aXhzVGxQbHJtSURHNERZYUY1ODY2YlJydnk4?=
 =?utf-8?B?Qjd3amNXZEhCQVBPSEF0VndnNHUzemswTzRENFZSemhVMHd2bWNsd29veDRN?=
 =?utf-8?B?STBTcGNYZEtyTnhJbURzc2Evb08zRWpCKzlFZFF3MXhSM2ZJaFE0SWdKYWZK?=
 =?utf-8?B?OWlQM1dja01DSEVsc0VHK0laOStLVWhkdnhMbmIyNHh3ZncyK3MrTzdvSmJN?=
 =?utf-8?B?ZXZZQWsxZ0dGVEFKOVFvcm1YY3FLN3FKUHBCL05kdG12VzFIZnA1OWNuS05Y?=
 =?utf-8?B?TTdNOW13OUxPNHNpRlM5WElLcXRkbmViVDk2bmZ5dDVtbDN3NGxadm51Z0FC?=
 =?utf-8?B?V3A4YUxMNDR0VENkS0V1SlBpQ1FYbEhsMC9vUHZ5SHY4V0lyY3ZUQW9lY2pV?=
 =?utf-8?B?b1UwWmk5aUJNQTRORE9RTFNrTUFuVFJzRW1DOVF0aGZYS2g3ajB1ZU43V2dV?=
 =?utf-8?B?cnlPZmthNEVrZGhLL3dMQTY3djc3ZFpwRXcyMWhUenozeXk2bUpHZ2RPUjR5?=
 =?utf-8?Q?8ZMekgP44dfbGW5NzgqJrYELA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a468fb9a-2ab5-4265-5c6b-08dbc10001e0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 15:23:18.0012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IutZgULTPEQ8AEij9pMb9cVARSWWK0UScJK2V7s5TNy+2UuR9ztMQt4/y1SAhQnhsbMKI7s2XNuLupLhTp3D3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4579
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
Cc: coelacanth_dream@protonmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 9/26/23 22:07, Mario Limonciello wrote:
> While aligning SMU11 with SMU13 implementation an assumption was made that
> `dpm_context->dpm_tables.pcie_table` was populated in dpm table initialization
> like in SMU13 but it isn't.
> 
> So restore some of the original logic and instead just check for
> amdgpu_device_pcie_dynamic_switching_supported() to decide whether to hardcode
> values; erring on the side of performance.
> 
> Cc: stable@vger.kernel.org # 6.1+
> Reported-and-tested-by: Umio Yasuno <coelacanth_dream@protonmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1447#note_2101382
> Fixes: e701156ccc6c ("drm/amd: Align SMU11 SMU_MSG_OverridePcieParameters implementation with SMU13")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 41 +++++++++++--------
>   1 file changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index f0800c0c5168..9119b0df2419 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -2081,36 +2081,41 @@ static int sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
>   	return ret;
>   }
>   
> +#define MAX(a, b)	((a) > (b) ? (a) : (b))

Is there a reason why you can't use the max() defined in linux/minmax.h
instead?

> +
>   static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
>   					 uint32_t pcie_gen_cap,
>   					 uint32_t pcie_width_cap)
>   {
>   	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
>   	struct smu_11_0_pcie_table *pcie_table = &dpm_context->dpm_tables.pcie_table;
> -	u32 smu_pcie_arg;
> +	uint8_t *table_member1, *table_member2;
> +	uint32_t min_gen_speed, max_gen_speed;
> +	uint32_t min_lane_width, max_lane_width;
> +	uint32_t smu_pcie_arg;
>   	int ret, i;
>   
> -	/* PCIE gen speed and lane width override */
> -	if (!amdgpu_device_pcie_dynamic_switching_supported()) {
> -		if (pcie_table->pcie_gen[NUM_LINK_LEVELS - 1] < pcie_gen_cap)
> -			pcie_gen_cap = pcie_table->pcie_gen[NUM_LINK_LEVELS - 1];
> +	GET_PPTABLE_MEMBER(PcieGenSpeed, &table_member1);
> +	GET_PPTABLE_MEMBER(PcieLaneCount, &table_member2);
>   
> -		if (pcie_table->pcie_lane[NUM_LINK_LEVELS - 1] < pcie_width_cap)
> -			pcie_width_cap = pcie_table->pcie_lane[NUM_LINK_LEVELS - 1];
> +	min_gen_speed = MAX(0, table_member1[0]);
> +	max_gen_speed = MIN(pcie_gen_cap, table_member1[1]);
> +	min_gen_speed = min_gen_speed > max_gen_speed ?
> +			max_gen_speed : min_gen_speed;
> +	min_lane_width = MAX(1, table_member2[0]);
> +	max_lane_width = MIN(pcie_width_cap, table_member2[1]);
> +	min_lane_width = min_lane_width > max_lane_width ?
> +			 max_lane_width : min_lane_width;
>   
> -		/* Force all levels to use the same settings */
> -		for (i = 0; i < NUM_LINK_LEVELS; i++) {
> -			pcie_table->pcie_gen[i] = pcie_gen_cap;
> -			pcie_table->pcie_lane[i] = pcie_width_cap;
> -		}
> +	if (!amdgpu_device_pcie_dynamic_switching_supported()) {
> +		pcie_table->pcie_gen[0] = max_gen_speed;
> +		pcie_table->pcie_lane[0] = max_lane_width;
>   	} else {
> -		for (i = 0; i < NUM_LINK_LEVELS; i++) {
> -			if (pcie_table->pcie_gen[i] > pcie_gen_cap)
> -				pcie_table->pcie_gen[i] = pcie_gen_cap;
> -			if (pcie_table->pcie_lane[i] > pcie_width_cap)
> -				pcie_table->pcie_lane[i] = pcie_width_cap;
> -		}
> +		pcie_table->pcie_gen[0] = min_gen_speed;
> +		pcie_table->pcie_lane[0] = min_lane_width;
>   	}
> +	pcie_table->pcie_gen[1] = max_gen_speed;
> +	pcie_table->pcie_lane[1] = max_lane_width;
>   
>   	for (i = 0; i < NUM_LINK_LEVELS; i++) {
>   		smu_pcie_arg = (i << 16 |
-- 
Hamza


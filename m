Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACABAC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 15:08:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3924C10E413;
	Wed, 14 Dec 2022 15:08:29 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2044.outbound.protection.outlook.com [40.107.95.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 033FD10E414
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 15:08:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExlHfVE7MgFzrMEH9NmZDylpPE7EoltHHzCI/YdBKrzP0C+NghnAUdXdZv7bHsCgKSRsKVDsZQq86ieNNyID3X526oW8Y9dnr4Ag9jskC4BUKb3UCqbVYW2ZyS3swSn7mtHnQNJSG5jlfXIr2ywDoFqIiwpdbRIe3d0dzJMQxHnuf5SLy9BRqmksYo30Yd0haPQ8l1sS2kwYJRBl35K7MDYnMcJ4Pitb34wMNMs7tTIgbsFSCog0mr5Swy4VgEqvL48pA4pv3fbxibTKqAAH8tyII0sE5iHWySCx8KAYL0NQ5N0hYY1dLVkqnS63z7TiGrcOynIANNBLYb6wsFZMrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsCMPCn1QArR/d92cG63bKzvwRO3i0L1ka14+ZQnCZY=;
 b=Ou2OvoWaJB7Id58DRaj3GhQb3eT4jwc+E2SmnhCMlbUZK3ZGTrb2FkYcLF1YNSi2S3PagDj90AHAfQvPMUx7sFoX1T/eiR9IB59/eoTCbKjfUCxxcChWOqBauNA5uDsk81eAiP14EKhUx0mQD1wRR6J2opaqG12u6wfCy4Qjr/cwc3rRnDpZNzcdPvAgneaNymCbC9xUkRiYH/IIxv8rCpRzyD6Q1WIyRVW9OtDEVIErIwyxoQ0wCNb1+1hKBTye9trRE2zPfgyot2517t2/WEKrUdUKNmFiWa+s9lqzCdTBbyXw+uR3kZgLtN9jcZAnvoxQuyq5TMOgPBJQzvCDKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsCMPCn1QArR/d92cG63bKzvwRO3i0L1ka14+ZQnCZY=;
 b=RQW3848Jc+Asphi/Cp+7k+hpFG8Vp2ZatI9DA+5R3Tb2anx44reOn5XGD1yfn6nCfpk0hiSOBi7mkIcOfq5Axfx/9qI8a88OwMlupP9GTl1+LcwGkMjK8M8fa0Nv7yZkPMwZXGzVLANmiTJLSnmyqp7fQWuQY/xu+m9xVOV69x8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SN7PR12MB7787.namprd12.prod.outlook.com (2603:10b6:806:347::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 15:08:20 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::2d6a:70d0:eb90:9dca]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::2d6a:70d0:eb90:9dca%9]) with mapi id 15.20.5880.019; Wed, 14 Dec 2022
 15:08:20 +0000
Message-ID: <5418f51b-6b15-8efa-d1ef-362576c6e637@amd.com>
Date: Wed, 14 Dec 2022 10:08:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] drm/amd/display: fix some coding style issues
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>
References: <20221026114850.3559949-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20221026114850.3559949-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::32) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SN7PR12MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: 870576ce-32f9-42c6-1974-08dadde5098f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RKataRid1iyfylM6WZV9KGV79Ea5Q0RKa73LNirtqEHy3aCg6304k3bodDswg9iR7Q+DAgqtXN8zYayk267IIrMOIHub2LVI1CnCzgg7deYx1KndswrrEgkxFsk3VDpx3VDhloMQQ2vsyXWACXFRigg8Tld1LFxmTLuFpFscgajFF1YoUpcIsIFzHEh0/KhVKBdviMccnvL9atpiYpV4uxWV5tgxsPxmvVC3NDnHbM2L1+FPiCQUw8Y8ZUpTGqrl4F6fepQxlA4k/gbQ/7adGf9xJx/HUX+Hmgprv8FvHrpxaOsOJwYP5T7HM8Mop4Wg6LdmidPGlhQ/QEIYOHUmA5Vpgy1myNkmHn7QVYV4VXQzMP7bDWKDP4dt7aHAjyQx1CvFLo6Jfe2XrrhYinqUP/9ew1yErrPMRHKMocRKPUrAxsUhLIH8Y3B2pRygRehYNwpGS6sNZyIDyMN0xO+5vTVVMvF/aotl/wsumMbvNGrI/3b+9dMwtirvXRl8PXpLWvTBkZa1VvhcFjkuGv2RiWR2aNQCyw2Hmu2wkWHzr2fuhpAgBcohSI/amGglTXs0krlsJGVASbVJZRCh5ckmXk/hiNnMFvY0cvepgMZGq5Ytxs2V9Y4Uo0fGYrOT70aQmjCXbic/dGsnJp3WLSudB16308Vew7L5ylB6IStPb7kzrex5/BSsB6m/TLXpgLvcV7+gi8go/ht0/58j9H71asV4UbcVm1Sz+MwsCpflI+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199015)(478600001)(31686004)(6666004)(6486002)(26005)(186003)(6506007)(53546011)(6512007)(6636002)(316002)(5660300002)(2906002)(83380400001)(36756003)(4326008)(30864003)(110136005)(66476007)(8676002)(66946007)(2616005)(66556008)(86362001)(44832011)(31696002)(8936002)(41300700001)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVBrNHFMNGJHMldqWW9tMC9LZVQ1dks3TEI4bFArNGNhTlh4dVZ0VFJUU2ZY?=
 =?utf-8?B?dUhKTEYyRG03dWp5TDdaM29Ta1RvemQwZWNleE11YzJPWWRid05TL3ZQMEVj?=
 =?utf-8?B?aXBnYzVBS3plY3QrZkZyK0lnV1pkRnRjMzB3MkhuZUJkcnl6ZWtVSmp0cHdl?=
 =?utf-8?B?M3kzSU05VGtvQjlBNDFvNUh0TDRsUkhVOFNvZThvZWRpT1pFOUVBcjJqQ3E0?=
 =?utf-8?B?dHc2SnVueDVMUUdzM3VKTHNZR3pXMmtwWmJBSTMvZ0k4aXRLeEEyYzd3eFRz?=
 =?utf-8?B?QnhiSzYzM3VzamxPdGhJUjc4LzloTExTdktCTGZDaFg4Wnk5WVlWNVA1dWht?=
 =?utf-8?B?MG5GblAxOG84UG1aUmJSWHZlSHZJRGZ2WjFWN1BRSTg4MnJydU4rVXpqSm9z?=
 =?utf-8?B?UEYxS1B6aEl4ZGoxU3JmN0I0V2xpQXk0b3J5V3BsMDI4aGs2dHpOZFBNY0tN?=
 =?utf-8?B?MTl5T1Z1Y2M5VGE4Q1JCOStaMUI2UmxZVjA2L0k2dXNhcmtrYmlFNDd6WUY3?=
 =?utf-8?B?RU9lY01QcERsUUMrZ0ZqRjJGeDM2TldoNVJpK0lNa1Z4b1F2Mnk2MUJHdVNa?=
 =?utf-8?B?MDd3ODRoSVY4ZmtBbmJlM0p4aWtPaVVWZTdqejdvSENPeVhEdXhENjF5NXBX?=
 =?utf-8?B?SllETFV4V3hQaFVZay9iR0JaS3FsRTFmak1CUE15Q0p1K3NBWGx6SVQ1ek1E?=
 =?utf-8?B?RjgxZXhVYThGYUxnU1UzdlN6UktZMy85MTRLT3NxNjFtUWJFUEhiUkNjTklh?=
 =?utf-8?B?UnF0TU14SHNRNzlhcFRpdVNBTEFqakZacW55Q2J1WDRQZFRwdUp2cjc5cXNB?=
 =?utf-8?B?ZDJaRC9MWmFrR0Q2bXhVcndFK0RPbytXVzlTRHRCT1d3N2UrdU5PWVZmLzlu?=
 =?utf-8?B?RDU0eHpqRzlETjlvaiswdko3QWd0VmkzNDVrVXQ3Q3d4d3c4K3hKdjgrRGdn?=
 =?utf-8?B?Y2tXa0l1RWRYNWd6c254VXV0dzdGN0RmQWhuRytuOVMxQ0dwOUFuR3BEaG1G?=
 =?utf-8?B?UU8wUGlhdzZBL2NadlFOWGk3VTRBMXpHWmJQQmxsUWx6Rk1PdDRNbUJuQWRO?=
 =?utf-8?B?b09jc2cvazdwZUJMVnNhUVJMQ0lqY3ZrekFKcHJLV2xhbDNOd1dMbTRCMklz?=
 =?utf-8?B?KzNtMkxINUt6bzhFSXNlRDJrNXBjaGNKdFRibG8vaDRZOElaSFovczhscHZs?=
 =?utf-8?B?UjM2cXpsUER4VENkSk5OVlpLME03M0d5MXpKZ2M2MUdPN0VHOGRzSFVvYnJP?=
 =?utf-8?B?SWlNM095ejNzL0prQWdsdis0dW4yelZ6UmVteHVqRmFpWVJGMlp1VTJOc3A3?=
 =?utf-8?B?K3hFeFF6MjJVVHFpSCs0WmNlK20zQVE4eHgvRU5SdDJJYTk5ZVZ1RFM2eGVM?=
 =?utf-8?B?azV0bHQ2WXVudFpLWGhsQ1ppc09QR3BDYkpFeUtzek5NTHptQlBSVEJsVE02?=
 =?utf-8?B?eWEzdE1Xa0llbU9KZ3JSVzRNTVRGcWJjS1F3TlUwUENiSENaeG4wMEc4amhJ?=
 =?utf-8?B?eGdHNkpSR3RKUTVHTXBXQUJ2SDg2SjM1Yk1nSVpQQ1J0V0FndmpOMUh2Qnlj?=
 =?utf-8?B?eUJQRWRFNWdOem5GZlFzd1JjOGpBVzZHZ28vWXlSbkhWMVlKYklWY2ZmbUZ1?=
 =?utf-8?B?QTVEdnlZR0p6Unp5YnZRQVpuYmVsK2d3QWt0dFdBSW5tWTZ3L05TNXpHMGo3?=
 =?utf-8?B?dEVCQ2FYek40TVBmY1NZcjF3bWZiMFl4RDlzRnBZQlRHYjdQNnhNWk5WZnBP?=
 =?utf-8?B?RWFKTU03ZHNTMG1WUlIxZ2xkdUY5SjZTYnZaWHpFKzZXNW1xN0RsYkN0aDJr?=
 =?utf-8?B?OEVaQjJPTVlmTjR5dERReUpsdjl2OG1aZFpMNHZjMGcyNHRETFdlYUFPU09I?=
 =?utf-8?B?T0FSbGNHa0pRN29pWkNQTTExU1Nudmdpb3VRNkhhb1pwMVd1ZTBsdU9nVDFU?=
 =?utf-8?B?UXVGTXNHanZ1VUpQc25DSkx5UTQ4WWgybHI0SUxId2FETVhuenZKWWpDQXdQ?=
 =?utf-8?B?Q2o4am5MTkVFUnlIblBvVXJsMTk3L1FoY1ZKT2wxSUZ0U3JhTmVpeEJ3ZHUr?=
 =?utf-8?B?dmF2YWFkbHBkOUFiZWxNSjN4SGpFY0tRb01DV0krZWdaY25RVldhSXlPUi82?=
 =?utf-8?Q?PkeZDG1hBapw88k1MmjaYMktB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870576ce-32f9-42c6-1974-08dadde5098f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 15:08:20.7414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujSMbS+wMBRUCYgvv+gchYySXli7FHUqrZVvwIo3dg1YsZTw5FuYRwW4mJNraJT0RhmkwV4M4vaetYPTjDpO5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7787
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/26/22 07:48, Srinivasan Shanmugam wrote:
> Fix the following checkpatch checks in amdgpu_dm.c
> 
> CHECK: Prefer kernel type 'u8' over 'uint8_t'
> CHECK: Prefer kernel type 'u32' over 'uint32_t'
> CHECK: Prefer kernel type 'u64' over 'uint64_t'
> CHECK: Prefer kernel type 's32' over 'int32_t'
> 
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Please make sure this is still sane after a rebase.

Harry

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 90 +++++++++----------
>  1 file changed, 45 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e733042531a6..1ee31c7290ac 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -258,7 +258,7 @@ static u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
>  static int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
>  				  u32 *vbl, u32 *position)
>  {
> -	uint32_t v_blank_start, v_blank_end, h_position, v_position;
> +	u32 v_blank_start, v_blank_end, h_position, v_position;
>  
>  	if ((crtc < 0) || (crtc >= adev->mode_info.num_crtc))
>  		return -EINVAL;
> @@ -357,7 +357,7 @@ static void dm_pflip_high_irq(void *interrupt_params)
>  	struct amdgpu_device *adev = irq_params->adev;
>  	unsigned long flags;
>  	struct drm_pending_vblank_event *e;
> -	uint32_t vpos, hpos, v_blank_start, v_blank_end;
> +	u32 vpos, hpos, v_blank_start, v_blank_end;
>  	bool vrr_active;
>  
>  	amdgpu_crtc = get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_PFLIP);
> @@ -644,7 +644,7 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
>  	struct drm_connector *connector;
>  	struct drm_connector_list_iter iter;
>  	struct dc_link *link;
> -	uint8_t link_index = 0;
> +	u8 link_index = 0;
>  	struct drm_device *dev;
>  
>  	if (adev == NULL)
> @@ -745,7 +745,7 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
>  	struct amdgpu_device *adev = irq_params->adev;
>  	struct amdgpu_display_manager *dm = &adev->dm;
>  	struct dmcub_trace_buf_entry entry = { 0 };
> -	uint32_t count = 0;
> +	u32 count = 0;
>  	struct dmub_hpd_work *dmub_hpd_wrk;
>  	struct dc_link *plink = NULL;
>  
> @@ -1011,7 +1011,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
>  	struct dmub_srv_hw_params hw_params;
>  	enum dmub_status status;
>  	const unsigned char *fw_inst_const, *fw_bss_data;
> -	uint32_t i, fw_inst_const_size, fw_bss_data_size;
> +	u32 i, fw_inst_const_size, fw_bss_data_size;
>  	bool has_hw_support;
>  
>  	if (!dmub_srv)
> @@ -1172,10 +1172,10 @@ static void dm_dmub_hw_resume(struct amdgpu_device *adev)
>  
>  static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_addr_space_config *pa_config)
>  {
> -	uint64_t pt_base;
> -	uint32_t logical_addr_low;
> -	uint32_t logical_addr_high;
> -	uint32_t agp_base, agp_bot, agp_top;
> +	u64 pt_base;
> +	u32 logical_addr_low;
> +	u32 logical_addr_high;
> +	u32 agp_base, agp_bot, agp_top;
>  	PHYSICAL_ADDRESS_LOC page_table_start, page_table_end, page_table_base;
>  
>  	memset(pa_config, 0, sizeof(*pa_config));
> @@ -2443,7 +2443,7 @@ struct amdgpu_dm_connector *
>  amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_state *state,
>  					     struct drm_crtc *crtc)
>  {
> -	uint32_t i;
> +	u32 i;
>  	struct drm_connector_state *new_con_state;
>  	struct drm_connector *connector;
>  	struct drm_crtc *crtc_from_state;
> @@ -3101,8 +3101,8 @@ static void handle_hpd_irq(void *param)
>  
>  static void dm_handle_mst_sideband_msg(struct amdgpu_dm_connector *aconnector)
>  {
> -	uint8_t esi[DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI] = { 0 };
> -	uint8_t dret;
> +	u8 esi[DP_PSR_ERROR_STATUS - DP_SINK_COUNT_ESI] = { 0 };
> +	u8 dret;
>  	bool new_irq_handled = false;
>  	int dpcd_addr;
>  	int dpcd_bytes_to_read;
> @@ -3130,7 +3130,7 @@ static void dm_handle_mst_sideband_msg(struct amdgpu_dm_connector *aconnector)
>  
>  	while (dret == dpcd_bytes_to_read &&
>  		process_count < max_process_count) {
> -		uint8_t retry;
> +		u8 retry;
>  		dret = 0;
>  
>  		process_count++;
> @@ -3149,7 +3149,7 @@ static void dm_handle_mst_sideband_msg(struct amdgpu_dm_connector *aconnector)
>  				dpcd_bytes_to_read - 1;
>  
>  			for (retry = 0; retry < 3; retry++) {
> -				uint8_t wret;
> +				u8 wret;
>  
>  				wret = drm_dp_dpcd_write(
>  					&aconnector->dm_dp_aux.aux,
> @@ -4158,12 +4158,12 @@ static void amdgpu_set_panel_orientation(struct drm_connector *connector);
>  static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>  {
>  	struct amdgpu_display_manager *dm = &adev->dm;
> -	int32_t i;
> +	s32 i;
>  	struct amdgpu_dm_connector *aconnector = NULL;
>  	struct amdgpu_encoder *aencoder = NULL;
>  	struct amdgpu_mode_info *mode_info = &adev->mode_info;
> -	uint32_t link_cnt;
> -	int32_t primary_planes;
> +	u32 link_cnt;
> +	s32 primary_planes;
>  	enum dc_connection_type new_connection_type = dc_connection_none;
>  	const struct dc_plane_cap *plane;
>  	bool psr_feature_enabled = false;
> @@ -4675,7 +4675,7 @@ fill_plane_color_attributes(const struct drm_plane_state *plane_state,
>  static int
>  fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
>  			    const struct drm_plane_state *plane_state,
> -			    const uint64_t tiling_flags,
> +			    const u64 tiling_flags,
>  			    struct dc_plane_info *plane_info,
>  			    struct dc_plane_address *address,
>  			    bool tmz_surface,
> @@ -4881,10 +4881,10 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
>  {
>  	struct dm_crtc_state *dm_crtc_state = to_dm_crtc_state(crtc_state);
>  	struct rect *dirty_rects = flip_addrs->dirty_rects;
> -	uint32_t num_clips;
> +	u32 num_clips;
>  	bool bb_changed;
>  	bool fb_changed;
> -	uint32_t i = 0;
> +	u32 i = 0;
>  
>  	flip_addrs->dirty_rect_count = 0;
>  
> @@ -5018,7 +5018,7 @@ static enum dc_color_depth
>  convert_color_depth_from_display_info(const struct drm_connector *connector,
>  				      bool is_y420, int requested_bpc)
>  {
> -	uint8_t bpc;
> +	u8 bpc;
>  
>  	if (is_y420) {
>  		bpc = 8;
> @@ -5562,8 +5562,8 @@ static void apply_dsc_policy_for_edp(struct amdgpu_dm_connector *aconnector,
>  				    uint32_t max_dsc_target_bpp_limit_override)
>  {
>  	const struct dc_link_settings *verified_link_cap = NULL;
> -	uint32_t link_bw_in_kbps;
> -	uint32_t edp_min_bpp_x16, edp_max_bpp_x16;
> +	u32 link_bw_in_kbps;
> +	u32 edp_min_bpp_x16, edp_max_bpp_x16;
>  	struct dc *dc = sink->ctx->dc;
>  	struct dc_dsc_bw_range bw_range = {0};
>  	struct dc_dsc_config dsc_cfg = {0};
> @@ -5620,11 +5620,11 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
>  					struct dsc_dec_dpcd_caps *dsc_caps)
>  {
>  	struct drm_connector *drm_connector = &aconnector->base;
> -	uint32_t link_bandwidth_kbps;
> -	uint32_t max_dsc_target_bpp_limit_override = 0;
> +	u32 link_bandwidth_kbps;
> +	u32 max_dsc_target_bpp_limit_override = 0;
>  	struct dc *dc = sink->ctx->dc;
> -	uint32_t max_supported_bw_in_kbps, timing_bw_in_kbps;
> -	uint32_t dsc_max_supported_bw_in_kbps;
> +	u32 max_supported_bw_in_kbps, timing_bw_in_kbps;
> +	u32 dsc_max_supported_bw_in_kbps;
>  
>  	link_bandwidth_kbps = dc_link_bandwidth_kbps(aconnector->dc_link,
>  							dc_link_get_link_cap(aconnector->dc_link));
> @@ -6838,7 +6838,7 @@ static uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
>  	const struct drm_display_mode *m;
>  	struct drm_display_mode *new_mode;
>  	uint i;
> -	uint32_t new_modes_count = 0;
> +	u32 new_modes_count = 0;
>  
>  	/* Standard FPS values
>  	 *
> @@ -6852,7 +6852,7 @@ static uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
>  	 * 60 	        - Commonly used
>  	 * 48,72,96,120 - Multiples of 24
>  	 */
> -	static const uint32_t common_rates[] = {
> +	static const u32 common_rates[] = {
>  		23976, 24000, 25000, 29970, 30000,
>  		48000, 50000, 60000, 72000, 96000, 120000
>  	};
> @@ -6868,8 +6868,8 @@ static uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
>  		return 0;
>  
>  	for (i = 0; i < ARRAY_SIZE(common_rates); i++) {
> -		uint64_t target_vtotal, target_vtotal_diff;
> -		uint64_t num, den;
> +		u64 target_vtotal, target_vtotal_diff;
> +		u64 num, den;
>  
>  		if (drm_mode_vrefresh(m) * 1000 < common_rates[i])
>  			continue;
> @@ -7111,7 +7111,7 @@ create_i2c(struct ddc_service *ddc_service,
>   */
>  static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
>  				    struct amdgpu_dm_connector *aconnector,
> -				    uint32_t link_index,
> +				    u32 link_index,
>  				    struct amdgpu_encoder *aencoder)
>  {
>  	int res = 0;
> @@ -7595,8 +7595,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>  				    struct drm_crtc *pcrtc,
>  				    bool wait_for_vblank)
>  {
> -	uint32_t i;
> -	uint64_t timestamp_ns;
> +	u32 i;
> +	u64 timestamp_ns;
>  	struct drm_plane *plane;
>  	struct drm_plane_state *old_plane_state, *new_plane_state;
>  	struct amdgpu_crtc *acrtc_attach = to_amdgpu_crtc(pcrtc);
> @@ -7609,7 +7609,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>  	long r;
>  	unsigned long flags;
>  	struct amdgpu_bo *abo;
> -	uint32_t target_vblank, last_flip_vblank;
> +	u32 target_vblank, last_flip_vblank;
>  	bool vrr_active = amdgpu_dm_vrr_active(acrtc_state);
>  	bool cursor_update = false;
>  	bool pflip_present = false;
> @@ -8059,7 +8059,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>  	struct amdgpu_display_manager *dm = &adev->dm;
>  	struct dm_atomic_state *dm_state;
>  	struct dc_state *dc_state = NULL, *dc_state_temp = NULL;
> -	uint32_t i, j;
> +	u32 i, j;
>  	struct drm_crtc *crtc;
>  	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
>  	unsigned long flags;
> @@ -8685,7 +8685,7 @@ is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
>  }
>  
>  static void set_freesync_fixed_config(struct dm_crtc_state *dm_new_crtc_state) {
> -	uint64_t num, den, res;
> +	u64 num, den, res;
>  	struct drm_crtc_state *new_crtc_state = &dm_new_crtc_state->base;
>  
>  	dm_new_crtc_state->freesync_config.state = VRR_STATE_ACTIVE_FIXED;
> @@ -9851,7 +9851,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>  static bool is_dp_capable_without_timing_msa(struct dc *dc,
>  					     struct amdgpu_dm_connector *amdgpu_dm_connector)
>  {
> -	uint8_t dpcd_data;
> +	u8 dpcd_data;
>  	bool capable = false;
>  
>  	if (amdgpu_dm_connector->dc_link &&
> @@ -9870,7 +9870,7 @@ static bool is_dp_capable_without_timing_msa(struct dc *dc,
>  static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
>  		unsigned int offset,
>  		unsigned int total_length,
> -		uint8_t *data,
> +		u8 *data,
>  		unsigned int length,
>  		struct amdgpu_hdmi_vsdb_info *vsdb)
>  {
> @@ -9925,7 +9925,7 @@ static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
>  }
>  
>  static bool parse_edid_cea_dmcu(struct amdgpu_display_manager *dm,
> -		uint8_t *edid_ext, int len,
> +		u8 *edid_ext, int len,
>  		struct amdgpu_hdmi_vsdb_info *vsdb_info)
>  {
>  	int i;
> @@ -9966,7 +9966,7 @@ static bool parse_edid_cea_dmcu(struct amdgpu_display_manager *dm,
>  }
>  
>  static bool parse_edid_cea_dmub(struct amdgpu_display_manager *dm,
> -		uint8_t *edid_ext, int len,
> +		u8 *edid_ext, int len,
>  		struct amdgpu_hdmi_vsdb_info *vsdb_info)
>  {
>  	int i;
> @@ -9996,7 +9996,7 @@ static bool parse_edid_cea(struct amdgpu_dm_connector *aconnector,
>  static int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
>  		struct edid *edid, struct amdgpu_hdmi_vsdb_info *vsdb_info)
>  {
> -	uint8_t *edid_ext = NULL;
> +	u8 *edid_ext = NULL;
>  	int i;
>  	bool valid_vsdb_found = false;
>  
> @@ -10172,7 +10172,7 @@ void amdgpu_dm_trigger_timing_sync(struct drm_device *dev)
>  }
>  
>  void dm_write_reg_func(const struct dc_context *ctx, uint32_t address,
> -		       uint32_t value, const char *func_name)
> +		       u32 value, const char *func_name)
>  {
>  #ifdef DM_CHECK_ADDR_0
>  	if (address == 0) {
> @@ -10187,7 +10187,7 @@ void dm_write_reg_func(const struct dc_context *ctx, uint32_t address,
>  uint32_t dm_read_reg_func(const struct dc_context *ctx, uint32_t address,
>  			  const char *func_name)
>  {
> -	uint32_t value;
> +	u32 value;
>  #ifdef DM_CHECK_ADDR_0
>  	if (address == 0) {
>  		DC_ERR("invalid register read; address = 0\n");
> @@ -10211,7 +10211,7 @@ uint32_t dm_read_reg_func(const struct dc_context *ctx, uint32_t address,
>  
>  static int amdgpu_dm_set_dmub_async_sync_status(bool is_cmd_aux,
>  						struct dc_context *ctx,
> -						uint8_t status_type,
> +						u8 status_type,
>  						uint32_t *operation_result)
>  {
>  	struct amdgpu_device *adev = ctx->driver_context;


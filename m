Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A682C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 05:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF8E510E388;
	Tue, 22 Nov 2022 05:57:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E397910E388
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 05:57:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+u6uHdsy+oIi3AA0oVH5jaTBdmvC+5TT2iouqJvHCzuLqvKv1b7JsYNIZOjiY334caayXabsys2C3liGHT3ZUzcPTVx7Txd5L/zerMUOMJBU4P4hFEFaTAVvUlxTezJjzHk5vYb0C81XhIOIbE4QAR9daXlspxvOGH1bgnWxSpPllWhv0zOID8XZ6j8FsLjUd3ZEzP1IeBPhAQK23jQfYUz9ddXB5Yyl2aTtA3yyYiEkk4pG6n64FQ5Vn7Q/tilyuOgAXZP+QgRzPWgh5g9K3usTz+Z8EEVCJEkxBh0/0PbmHdU9Ah5sujc5raD5Gec41PtRivP9EjVgjPu7R3+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzCMJvZlZswi/rNwSHo+cBq7WAxvE2N6Lp/oeZkfSeQ=;
 b=lbzTKP+d6nUXP+MIheUI6GoEheeLX2CNCnyC19mYw93sIqchsDAa33B3tz3nHarnsF4vB+OhaqGkDq604JCjdkUkSL/PgUln84SDjhMI2PX4sf7C7wG6mqmIPZmskQWBj5faNiASPjkz4a4Qx7ODk8mvra+ZZ/iqPXUlQP5NmG/GRRzC6X2ZG+bIdwyvGCNnTuDTBBs8rhJtbxpTYTF5MVcxhA+tCrNIB4zf+GwPW9mCZIvhWFVjh1s8JUv8LfLfb8rXEW/M6j/vs/YJRQzOEvPHnDzNY4LD/xmv7+8daOXgONTmSAyS/ZTEpSw77d8d0//DZ66aXcJR4Rh+Ica7OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzCMJvZlZswi/rNwSHo+cBq7WAxvE2N6Lp/oeZkfSeQ=;
 b=AU5DWo7JRfeygIKJBGcU51WdoZpKQUYQVnZzyE8ckWPANoSMlVzZZhmAOnUGkGJw6lphJIp79LJmUhVUAvKx8Jj2dtcxOCMHJdxI6G6aJw9WXCYXw0eJQCcIEKSpAay0yfRIqeLs8RsK5mwkFWIognH0fPrWyNvb59OjqJJ+EBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 MN2PR12MB4504.namprd12.prod.outlook.com (2603:10b6:208:24f::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Tue, 22 Nov 2022 05:57:45 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5834.009; Tue, 22 Nov 2022
 05:57:45 +0000
Message-ID: <c4fd2b35-8b5f-55f2-963d-be9d7c715e10@amd.com>
Date: Tue, 22 Nov 2022 00:57:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] drm/amdgpu: add drv_vram_usage_va for virt data exchange
Content-Language: en-CA
To: Tong Liu01 <Tong.Liu01@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221122055202.5110-1-Tong.Liu01@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <20221122055202.5110-1-Tong.Liu01@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0024.namprd17.prod.outlook.com
 (2603:10b6:610:53::34) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|MN2PR12MB4504:EE_
X-MS-Office365-Filtering-Correlation-Id: c82edea6-416f-4c3d-4c42-08dacc4e7a01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cNN/JGRJy3xmHiWAnf+1hGkNW8gzG1s6K5hnZbmCtCt/aUq+rHP1y2K6CKQDJQ6uZJTapGV4k41lQjvgGfNWhf2I6fCoRYVqoKlOmYDynjNIh6wrgQdxIiXHscxTeopBolWH7w6JZ4avb5XGrWB9OWow42N30zSLT/yidNsAJmP6sSeYh6G2PgkIgYPoinuLUJOMR+Q6+E8R/iMi0Zpu/rbSVKleFrwRsZee0Yg+NzBrfawxswm2Sj7z5rEwKoGe/hJ96Qq4+JdgrE3s6b89TwCKaGiwwzdmMTE3mYGFrFsXIwbVjEzFXpbdCWLtymq8MTGshlOm/V39ukPG2/ghaxTNyD4wDNLMwqGB0DqPn015z/2fzc9jUdQ4PhMT6DP/jIiqDpmCiGTAXVln5RZ+RnvPkYppxtFZg1uTmCaPsm5f07C6ThEZo6PyIpQnqOYbU1QfGxBtDCHXQk2O5Q05bayeynnf4hAsHEX9KemjdYOK3dqlaNW3F97m8J7WlsGipHhtE9VDeBFGb0dY32ijy+bwer1kAa7pVIoMCJZHeJy5sfP6ZkyAAGXAikc/8LC5azPmvG2b4USkxNR52OtMlkSHuMFshVq28edR10NjU6S1QROVwUG6iGby6dlDRrlZA2vA5KxmEwf6rxE5sFpZbKpyCx4WUusJT+vnHFRBXlHpuT543Y50c8/dVg6ZvUeePjq+m2DBaq/KRclkXO8pJl7GOPCtka3KeGkQkYwxP/k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199015)(36756003)(31686004)(38100700002)(41300700001)(44832011)(4001150100001)(2906002)(31696002)(86362001)(83380400001)(66476007)(6486002)(316002)(66946007)(66556008)(8676002)(4326008)(6512007)(186003)(26005)(54906003)(8936002)(5660300002)(478600001)(6506007)(2616005)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjdZMmZ4eXo5d2ZlenBWRDhTalhzcW9kU3pPQ1FvL0p3U1Q2ZEJHclNndjVD?=
 =?utf-8?B?TTZ6YkdRVjFDa3B1SS9RYUFONGNwN25QNm5pMDVhTkQ5RklVSW1qODU0aERJ?=
 =?utf-8?B?em9aVkVWckNmZms5Mld4U1BBYUVFWUlvV1B0dm9NeE8vTmR6cllYTnUrUFlF?=
 =?utf-8?B?U2hPa3NSKzY5MEtxRWZhQy8xNGV3MGZrMWRhSXpKbVNEV3d0d0V4c0lWWXRm?=
 =?utf-8?B?ZjZmekJBU29RSm9YUDdvdEhva0huZkd6WlFaTk1aNXdIRjg2aDFpOFFJSkVR?=
 =?utf-8?B?R3lZcUpNOFFmT0svenBqVVc3Wk4xT05YVEQwQ002QjMvSnVSR01LaTlOdFBW?=
 =?utf-8?B?aDA3VUJYR3l0UmJqdDhxN0ZrN3pPdS84RTFZbkRwcE1RUHdUTFQxMnUyVWdW?=
 =?utf-8?B?MDJTeXhWRENuT1k1aXFsTTNHRzFBUkVXa25ZeWNaWnRqTVBFNTVlU2RQSFIz?=
 =?utf-8?B?b2dGWWt0b2UzOXFJNklCS0phUFhXUnh2THZzcmhaTURuSDVFUjdnN2hJZGNK?=
 =?utf-8?B?M1dJNEUxL1MrZjlNc0RhRkN0SmhTQXcyTzNyVUlLbXZCMHY2NDZnOGgxb05F?=
 =?utf-8?B?cVAwblV4UFdFSU81dGpEbHpXUjR3M2t1QVlRZTN2a3RITENMWnI1dzZMWWpx?=
 =?utf-8?B?dS9DU3plYkI4NUYwSE9SSjRNbDRUbFhKbjdHK1JDY0xtdEo0Y2w0a21LZHVr?=
 =?utf-8?B?cit4NHBRcENVM3BMU2sxenZVdXdtbHNFcHFWcWdjZjRjV2IwZXhzemRWRm5m?=
 =?utf-8?B?WXhRK1JYUlVocFF0VkV6ajVOTkNtcWFNVUJ1MzJjdllOWHdiNUZ0eVJqSkR5?=
 =?utf-8?B?VlNUVldIbmovWmhmN2FZMm9iQk4zYUJCY21vY2xKYktXTTZ5N2lwd3FwanI1?=
 =?utf-8?B?ZHVUZ3pSRTltdk96ZldvcE51dHlqcEpJNll1cTRVVm5FRWx0MkNISkZ1TWFC?=
 =?utf-8?B?UU1SMzBGaWRnVXBpQVpMc1VkMkVWWWJKMzdpeUdlSi9rNjNsNzNhSzd3ZjBH?=
 =?utf-8?B?UTlpKzhPMWlCUytZTWpueWdtejI1a1hYZ3lrOGd1dzl1Y3BwQXRPR3pESkNv?=
 =?utf-8?B?RWY4eDdzQWFjOVRwNmJNemJ0R3VFYU14M05FeGZGRWxFSzJ4VnhnTy9iUWxP?=
 =?utf-8?B?YlBWNEpLS1dRak5sTC9HNWxKa295RmV0VmsxU0M1aGY2N0lIQlYwT3dOT1po?=
 =?utf-8?B?NlJ4QmF1aWMwT2dXSC9UcnMwSnZRcm5Fb3MxUlhjODhlaUw0ZUI3SVNpNTBT?=
 =?utf-8?B?bytOaGgxOFZsOEdWTjJiVEpKcjU3ZkRNcXk2M0ZuK0pKSlY5cUNaVzZhUHJE?=
 =?utf-8?B?T1A1akFyWWFQNHBydXF4U1g2ZjhjMW9zMUErMFF5c294azlrbXhKdjllYWlN?=
 =?utf-8?B?MW85c01MTnFCSXplSGJ2blFoZXllZXlJRjZON25SYlZsMk4zMUptaXpVamJa?=
 =?utf-8?B?Qm5DYStEU2RHMlFaNFNUZEp3amV4UlA4cnhjYUt4MC9XL29wSXN3QXQwWWc5?=
 =?utf-8?B?VG5LSUpObEloS3ppanMxMlFQaEE0MHBSSklCTDE5Z3N0WFpvcGRBc0xQUFNi?=
 =?utf-8?B?VlRaYU1mQkV3SFB2bnZKWGRYQVhmVENUYWRXVmQ2blRmckxPcU1yaHlVL3VE?=
 =?utf-8?B?YlExVEZnTEx3Y0xNVWdiZHpDaFNNb0dCZjJUNWowZWJ2VVpxazNEc3AyUkFR?=
 =?utf-8?B?TnlNRWhnSXRKUzFhNFJCWUhrT1ZtTHkvR3Y1bFdreW5nU2pXOFoxck9EMnJK?=
 =?utf-8?B?SXpiNFQ3a1dyY295cjRnWGIwSGNYQVFraDVYU0lPMzJPckdYSkVEK1VvSTJT?=
 =?utf-8?B?OXJaQy92cERNZE5xTWlmRCt1Vi83ZGF2R1hYM1JEVnNXWVNFbkJJb1FzdFVB?=
 =?utf-8?B?Z2F5ZmFEcXJNNUFwbUlCVnhYSmxwdXdXOEhHT05HMmNUV0puZ1lWNHJSQTRr?=
 =?utf-8?B?cGxodm1ZaTJMOHdvQ0NGZDh5cEtXck9QSmROd3RGS21QdktXa0tmQTVtVmFM?=
 =?utf-8?B?Nko3RVB3VklNN2prTXVraFFVNkllTklZTVZpNGdjNmQ0UUQrRys5NVhTbk04?=
 =?utf-8?B?c1RTd1YxQXZkY3B5NnF1UVVlQis1UEZaUUxJRGFwekdMcUJVM01RbWtSR1F0?=
 =?utf-8?Q?UefZz0o0QdiVg1Rpb0Las1Q0e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c82edea6-416f-4c3d-4c42-08dacc4e7a01
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:57:45.4329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fUzSBHpZTnmRmgxgdAqlbrpFWSqFsFsJOCLv7zVpckEjJDEehIupnAR65XiUJsMr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4504
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
Cc: Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, yifan.zha@amd.com,
 Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-11-22 00:52, Tong Liu01 wrote:
> For vram_usagebyfirmware_v2_2, fw_vram_reserve is not used. So
> fw_vram_usage_va is NULL, and cannot do virt data exchange
> anymore. Should add drv_vram_usage_va to do virt data exchange
> in vram_usagebyfirmware_v2_2 case. And refine some code style
> checks in pre add vram reservation logic patch
> 
> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 16 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  9 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 54 ++++++++++++-------
>  4 files changed, 50 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index 9b97fa39d47a..e40df72c138a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -104,7 +104,7 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev)
>  static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
>  	struct vram_usagebyfirmware_v2_1 *fw_usage, int *usage_bytes)
>  {
> -	uint32_t start_addr, fw_size, drv_size;
> +	u32 start_addr, fw_size, drv_size;
>  
>  	start_addr = le32_to_cpu(fw_usage->start_address_in_kb);
>  	fw_size = le16_to_cpu(fw_usage->used_by_firmware_in_kb);
> @@ -116,7 +116,7 @@ static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
>  			  drv_size);
>  
>  	if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
> -		(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
> +		(u32)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
>  		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
>  		/* Firmware request VRAM reservation for SR-IOV */
>  		adev->mman.fw_vram_usage_start_offset = (start_addr &
> @@ -133,7 +133,7 @@ static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
>  static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
>  		struct vram_usagebyfirmware_v2_2 *fw_usage, int *usage_bytes)
>  {
> -	uint32_t fw_start_addr, fw_size, drv_start_addr, drv_size;
> +	u32 fw_start_addr, fw_size, drv_start_addr, drv_size;
>  
>  	fw_start_addr = le32_to_cpu(fw_usage->fw_region_start_address_in_kb);
>  	fw_size = le16_to_cpu(fw_usage->used_by_firmware_in_kb);
> @@ -147,14 +147,16 @@ static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
>  			  drv_start_addr,
>  			  drv_size);
>  
> -	if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
> +	if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION <<
> +		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) == 0) {
>  		/* Firmware request VRAM reservation for SR-IOV */
>  		adev->mman.fw_vram_usage_start_offset = (fw_start_addr &
>  			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>  		adev->mman.fw_vram_usage_size = fw_size << 10;
>  	}
>  
> -	if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
> +	if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION <<
> +		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) == 0) {
>  		/* driver request VRAM reservation for SR-IOV */
>  		adev->mman.drv_vram_usage_start_offset = (drv_start_addr &
>  			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> @@ -172,8 +174,8 @@ int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)
>  						vram_usagebyfirmware);
>  	struct vram_usagebyfirmware_v2_1 *fw_usage_v2_1;
>  	struct vram_usagebyfirmware_v2_2 *fw_usage_v2_2;
> -	uint16_t data_offset;
> -	uint8_t frev, crev;
> +	u16 data_offset;
> +	u8 frev, crev;
>  	int usage_bytes = 0;
>  
>  	if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 52f2282411cb..5922f94241a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1569,8 +1569,8 @@ static void amdgpu_ttm_fw_reserve_vram_fini(struct amdgpu_device *adev)
>  static void amdgpu_ttm_drv_reserve_vram_fini(struct amdgpu_device *adev)
>  {
>  	amdgpu_bo_free_kernel(&adev->mman.drv_vram_usage_reserved_bo,
> -						  NULL,
> -						  NULL);
> +						 NULL,
> +						 &adev->mman.drv_vram_usage_va);
>  }

This should be aligned according to C mode, under the &.
(Use a good editor with C mode and it'll do it for you. Emacs, perhaps... :-) )

With this fixed, this patch is
Acked-by: Luben Tuikov <luben.tuikov@amd.com>

Regards,
Luben

>  
>  /**
> @@ -1608,8 +1608,9 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
>   */
>  static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
>  {
> -	uint64_t vram_size = adev->gmc.visible_vram_size;
> +	u64 vram_size = adev->gmc.visible_vram_size;
>  
> +	adev->mman.drv_vram_usage_va = NULL;
>  	adev->mman.drv_vram_usage_reserved_bo = NULL;
>  
>  	if (adev->mman.drv_vram_usage_size == 0 ||
> @@ -1621,7 +1622,7 @@ static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
>  					  adev->mman.drv_vram_usage_size,
>  					  AMDGPU_GEM_DOMAIN_VRAM,
>  					  &adev->mman.drv_vram_usage_reserved_bo,
> -					  NULL);
> +					  &adev->mman.drv_vram_usage_va);
>  }
>  
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index b391c8d076ff..b4d8ba2789f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -90,6 +90,7 @@ struct amdgpu_mman {
>  	u64		drv_vram_usage_start_offset;
>  	u64		drv_vram_usage_size;
>  	struct amdgpu_bo	*drv_vram_usage_reserved_bo;
> +	void		*drv_vram_usage_va;
>  
>  	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>  	struct amdgpu_bo	*sdma_access_bo;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index a226a6c48fb7..15544f262ec1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -428,11 +428,17 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *adev,
>  	struct eeprom_table_record bp;
>  	uint64_t retired_page;
>  	uint32_t bp_idx, bp_cnt;
> +	void *vram_usage_va = NULL;
> +
> +	if (adev->mman.fw_vram_usage_va)
> +		vram_usage_va = adev->mman.fw_vram_usage_va;
> +	else
> +		vram_usage_va = adev->mman.drv_vram_usage_va;
>  
>  	if (bp_block_size) {
>  		bp_cnt = bp_block_size / sizeof(uint64_t);
>  		for (bp_idx = 0; bp_idx < bp_cnt; bp_idx++) {
> -			retired_page = *(uint64_t *)(adev->mman.fw_vram_usage_va +
> +			retired_page = *(uint64_t *)(vram_usage_va +
>  					bp_block_offset + bp_idx * sizeof(uint64_t));
>  			bp.retired_page = retired_page;
>  
> @@ -643,7 +649,9 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
>  	adev->virt.fw_reserve.p_vf2pf = NULL;
>  	adev->virt.vf2pf_update_interval_ms = 0;
>  
> -	if (adev->mman.fw_vram_usage_va != NULL) {
> +	if (adev->mman.fw_vram_usage_va && adev->mman.drv_vram_usage_va) {
> +		DRM_WARN("Currently fw_vram and drv_vram should not have values at the same time!");
> +	} else if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usage_va) {
>  		/* go through this logic in ip_init and reset to init workqueue*/
>  		amdgpu_virt_exchange_data(adev);
>  
> @@ -666,32 +674,40 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
>  	uint32_t bp_block_size = 0;
>  	struct amd_sriov_msg_pf2vf_info *pf2vf_v2 = NULL;
>  
> -	if (adev->mman.fw_vram_usage_va != NULL) {
> -
> -		adev->virt.fw_reserve.p_pf2vf =
> -			(struct amd_sriov_msg_pf2vf_info_header *)
> -			(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
> -		adev->virt.fw_reserve.p_vf2pf =
> -			(struct amd_sriov_msg_vf2pf_info_header *)
> -			(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
> +	if (adev->mman.fw_vram_usage_va || adev->mman.drv_vram_usage_va) {
> +		if (adev->mman.fw_vram_usage_va) {
> +			adev->virt.fw_reserve.p_pf2vf =
> +				(struct amd_sriov_msg_pf2vf_info_header *)
> +				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
> +			adev->virt.fw_reserve.p_vf2pf =
> +				(struct amd_sriov_msg_vf2pf_info_header *)
> +				(adev->mman.fw_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
> +		} else if (adev->mman.drv_vram_usage_va) {
> +			adev->virt.fw_reserve.p_pf2vf =
> +				(struct amd_sriov_msg_pf2vf_info_header *)
> +				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_PF2VF_OFFSET_KB << 10));
> +			adev->virt.fw_reserve.p_vf2pf =
> +				(struct amd_sriov_msg_vf2pf_info_header *)
> +				(adev->mman.drv_vram_usage_va + (AMD_SRIOV_MSG_VF2PF_OFFSET_KB << 10));
> +		}
>  
>  		amdgpu_virt_read_pf2vf_data(adev);
>  		amdgpu_virt_write_vf2pf_data(adev);
>  
>  		/* bad page handling for version 2 */
>  		if (adev->virt.fw_reserve.p_pf2vf->version == 2) {
> -				pf2vf_v2 = (struct amd_sriov_msg_pf2vf_info *)adev->virt.fw_reserve.p_pf2vf;
> +			pf2vf_v2 = (struct amd_sriov_msg_pf2vf_info *)adev->virt.fw_reserve.p_pf2vf;
>  
> -				bp_block_offset = ((uint64_t)pf2vf_v2->bp_block_offset_low & 0xFFFFFFFF) |
> -						((((uint64_t)pf2vf_v2->bp_block_offset_high) << 32) & 0xFFFFFFFF00000000);
> -				bp_block_size = pf2vf_v2->bp_block_size;
> +			bp_block_offset = ((uint64_t)pf2vf_v2->bp_block_offset_low & 0xFFFFFFFF) |
> +				((((uint64_t)pf2vf_v2->bp_block_offset_high) << 32) & 0xFFFFFFFF00000000);
> +			bp_block_size = pf2vf_v2->bp_block_size;
>  
> -				if (bp_block_size && !adev->virt.ras_init_done)
> -					amdgpu_virt_init_ras_err_handler_data(adev);
> +			if (bp_block_size && !adev->virt.ras_init_done)
> +				amdgpu_virt_init_ras_err_handler_data(adev);
>  
> -				if (adev->virt.ras_init_done)
> -					amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
> -			}
> +			if (adev->virt.ras_init_done)
> +				amdgpu_virt_add_bad_page(adev, bp_block_offset, bp_block_size);
> +		}
>  	}
>  }
>  


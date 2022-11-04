Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB76C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Nov 2022 09:09:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A9D910E718;
	Fri,  4 Nov 2022 09:09:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F6B410E70B
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Nov 2022 09:09:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQHHJLNDGyp3gp2ki1zR4YiouGAgEeT/LzOxFCdtU3luukWfIoNJXTw2LCajs7xjfLlb6abg76i1K8xV/KLGyqufY/ww9mk8UmGHQJClGfUnoxgB0PKsB8HP/159lpBIj+oJkDXzFNDYKNrwOIjoJqkLygD4RXdVbHVeA0FO0EbZ6TywjG3xcxl5VQwV6ECBQqgj+BWfy3TC+C9uuAChGcMURxrjlkx+6d1NgJGu0YhRpB4XV5Dusf5Ya0N0lSbEOfqBY6fAfFvmhuioz1qkRy8rT9dfMhMSOREtEFwti5SznOgpbLmpsEuljZ+hhnFS3QCYNP6eUz8aUIGAEgGuCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zx/wa+U9sNZsxZP6F1vnVoLyTf2BY/T5J9iEicuKBwU=;
 b=nlhh9vMdlDuj4zhaEjHaK8Y/n2AIVmUEcwUkHjo4l9TXaXl5VRBEi8sLXpXXE6VAP/6CdHOsBqcN2EqhAm2VcgVDiYwc+NdaO0lZz/nqBSReJAuH+bdid5Zcj9SRzGXJdHC5Byh2wWy8CnPYSh9oFkwNc64txkR2BHgtykTz/rjgYaiEiEiInDPhSrs+9P4p0pYbta/XgIVBuO2u0aqliWyDCT5SRoiwem0Y7af4sTZnfwcwCqt5dXZ4thx6ZaK6zdjAy+Rdwrp3h8Op7U5bLKZXIZy8jRrMph7paABsr1fcgWqbO9519fcFabxn7vLQGzc+SvFeTwjozKJxAAeFKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx/wa+U9sNZsxZP6F1vnVoLyTf2BY/T5J9iEicuKBwU=;
 b=fxFxq37cMvBO4AbmOyN2I35FLDNW0+LEzSltLWxlwPZ6xz3LpvRhtYG4I4LfuSohqM/+pFbuLgKq0iBzPDiYcHOeKCbV0RbT4hW3a4OW2uoMtXr8kxAIPrHCNwgk11U3kcd8A2Aw6fSR9Qy0d5WtXYYXYLG1L074036CBCUQWVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3589.namprd12.prod.outlook.com (2603:10b6:a03:df::29)
 by BN9PR12MB5196.namprd12.prod.outlook.com (2603:10b6:408:11d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 09:09:17 +0000
Received: from BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::e6a5:94b4:d855:14b3]) by BYAPR12MB3589.namprd12.prod.outlook.com
 ([fe80::e6a5:94b4:d855:14b3%7]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 09:09:16 +0000
Message-ID: <655df54e-43ce-4b6a-f88a-580c605abf58@amd.com>
Date: Fri, 4 Nov 2022 10:09:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdgpu: add vram reservation logic based on
 vram_usagebyfirmware_v2_2
Content-Language: en-US
To: Tong Liu01 <Tong.Liu01@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221104085242.11071-1-Tong.Liu01@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221104085242.11071-1-Tong.Liu01@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0351.eurprd06.prod.outlook.com
 (2603:10a6:20b:466::17) To BYAPR12MB3589.namprd12.prod.outlook.com
 (2603:10b6:a03:df::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3589:EE_|BN9PR12MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a824d2d-f0ab-472f-d1b3-08dabe443fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hImj9z+h1yeOTjF0lJOZPCy3YTlInjuRWnlbdyJSWoBXrEs5y23hvQDU1IVe/TxiZVfUUXG3rzmuiwsymWuOBe/O0LOYDsSLl66QBTvaItXm4v3/o3eA3I+RvAy37e7J/1ywjdy6iZXRidJEQPsiUYVJ/FuanmUxUJ98zhwoo4nWkwePNne/fLA1oYgB4vZlyV2R0yqRwxSIPP75XQpeS7W+8vqy04ywTIoSKluGXNYBTuFuABpXifsCK8D6WjuGqpA2XtsjqSk6f6Qwzb19YcddQGpBDv4EtYEzjm6yfF636aassAWDQ/cECMWqTqir+yIG87TAQNEHF02pC7gV4hQVSPaWNK7jw/vxkAEciVTz1fRqc3G0flFuhgcMbQSYpXS32omt8QcGRgVyc7NkAZ7SVgWzTB+wWxm58wzvO1s9r/5eNneIAQUSup76IupRYMPA2g3xQdgY+gLqhDYsHfsSQZ5PxVs/Mwu8CPKrqM/iMVmiwlDCFAhaNtI9Ex5HlCuF4Rn/71omCD3JC6WAqaXdAdB750SJ/LlPT5o/82iNRKXT4B9UnAjYg85bJ5k+SgfCTdnUrzkszFcTCjf6cOvZyKpUNzrpnZEePsSoVAACL5t83dYwfgAYn9m7JNoJli4cd7yuMrTeMxRELZUNUPHQ5OD6NO+oxBbO6MqysnTnfUTYoYBJcxcI+wHuJgb137ypPJUNiIBQ1G2YXd/F5HviYU6RpT3r98uuZlE+SJhJT1511YJusHJvlL5LFrmBzWr/k3ZMIi5cwnLTTt+04IL3XosefzpGM/x8335gclk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3589.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199015)(66556008)(86362001)(31696002)(36756003)(41300700001)(6512007)(66476007)(4326008)(66946007)(8676002)(54906003)(5660300002)(8936002)(30864003)(186003)(6506007)(6486002)(478600001)(316002)(6666004)(2616005)(38100700002)(2906002)(83380400001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekRremdNVDRxZ3N6ektyWkJ4NEJoTnd3WjByRlMvZnZZKzVITFc3YTIzV1Bt?=
 =?utf-8?B?MVgwd2R5akVtbG5nWGhjUW8zM3VxTEQ0TUhBdE5DQzAxWmJib1UrbHhaN3Ri?=
 =?utf-8?B?SG9iM3pIZXlaZjhHUktpWHhmcG01TG85RUsvMllHV2p6Zk81cnhLd3F3TDdz?=
 =?utf-8?B?cVoxMElqcVlLZGJvQjRBWUREbU5RUjRaMnA4Rk5hemZVNEdudEQ1NG05WWlJ?=
 =?utf-8?B?Wit5cnI1eWpUQWZlSnUyQWl5Tm5MQW94NU40QUF2OHJ1ZlZCNzN2enJUV3Jp?=
 =?utf-8?B?ejM2NDVwbHRSZ29VSkVwdTZVV0Q0ZEM4WWF6MnBvTWliZnpCSnZaaUw1c3k2?=
 =?utf-8?B?REhGRFd2OU1BdHVKMG8wZG1tYWZuWUlnSXZYSGNsSG5vK1pmT3NzMGtCUnZN?=
 =?utf-8?B?a1FwNFYxbXZGY2dGSGFCUW1nWm56WXhWTEdzTnV4Q1F1Q2hXWktxVUJzcERl?=
 =?utf-8?B?aTh2TEpBWVNRTFRnRTlZQ3hLblJBU1pzdlVTM1BxN0xUUVc3UG5qWjdmaTcz?=
 =?utf-8?B?NnlMRG1MQk0wRGx3QVFYRFpxTE9TSjRoNCtBRDZTUUcvNVVKWWhNNDZmUk9X?=
 =?utf-8?B?NlpYcVZEa05XbDNjdWpXZUdFbFFkQVY1VU9jdlVTajJkQkJ0eW9rRk16YmRR?=
 =?utf-8?B?RFlvenRjd01JQXVnS2FaWlF0akxkVnZFOUhzMjZsUWlEd2JqVkU5a3pXU0xz?=
 =?utf-8?B?UklNK2dVdkpueDNERStoL2JyMEJmeGNIei8xTHU1U3h2QWxyUjFSbnV5eElq?=
 =?utf-8?B?L2ZDNy9FL29hZWFtbW9ZVWhXRWIvNmx0VW9SVHdmZ3duSFkxaEhFUmtSNkVV?=
 =?utf-8?B?MGEraHB4VHhEejVDZE9LT09PRmJ1TFlLcFB2TW1vMnIrZHEzbDl1NnN3RUpE?=
 =?utf-8?B?ZTd5SVlkdk1Xa0ZIeWd5NlM0cEhTSCtPL0pSQTZLdVd5aFFCMnhzS2ZtN0wz?=
 =?utf-8?B?eTU1TjdQckVWbGMzZHowUGRJS2NadFl6SjRHNmQ0cE50TEVuM3d5Q0E0ZGFt?=
 =?utf-8?B?VTR5WEZYRzEveVIyK3FzMTVud3NEVjdHaERPbllkSzY2VmhNekE2V2tucTRl?=
 =?utf-8?B?YzZlK2ZyR1B0QjFhMEp3ZXBYYWtsVHI0bTFMUm9SRmdISjMyT0pFTHBxdVVG?=
 =?utf-8?B?TDVCQWh1MWNyQXNhSzUyYzRKNlp1UnllQkpHUjQ1RnR4VTQzcFFxblMxaGxt?=
 =?utf-8?B?b0hRb0RXYmlpTXVZVHhoQWV0U24weVJZZENDY0FDS2JtalpXUWpPR05OaWFy?=
 =?utf-8?B?YjJVVzBvSmQ3dWtXSDNFdG1kTGFUa09wTWRoSUlEaTRyUVZyTUdoR1RjdjQ0?=
 =?utf-8?B?Q0ljMXg3WFNWRjBkcE9uYW9KbmcremlETWw1R2RVQ0RCYWpVOWNKQk1OTUxR?=
 =?utf-8?B?aG5jK1l1Tk1xdnJJM2xDYWZhYXczYTNTWWxiYnRoYjE5bnVIRnE5Rkk3ZVc5?=
 =?utf-8?B?U3hmdFpuNVZvcGVOSW40cndwTnA2ejhqV2NCNFcrS2x5S29xcVRva0lldmtL?=
 =?utf-8?B?bUlEMzU4aHVDSTNLUGU4L09Ib2dYd3krQ0d5UzV2djBwa09lWU9aZHEwcEhM?=
 =?utf-8?B?aWlJVlk3YlI2OUZvVncwaUU5ZlpCK0pLSE5HQ0gwMFR6ZW16RjVoWEwzcGhI?=
 =?utf-8?B?VExYYmozNzAzVHZXT0cyelQ1RG52cXVBemZvYXByODh3U0ord3RVRWJhekdW?=
 =?utf-8?B?ZEZxNkU1T09aOXVMT2JFeTFXUTNmQm5EUGo2Q0NvZ1YxS1pmR3BOQ2JLSHAz?=
 =?utf-8?B?U3BPYzBWYXNuR0hlcEVBS1VjYldIWUZ4MnNGR0M4V0NkQkt6R09DZ2ZjckNX?=
 =?utf-8?B?TklHM0dJazlhVnNMZWZoeTZmMnlVVmUxYjF6WkpwT3ExK0hzZnNndnZONXNa?=
 =?utf-8?B?UG5qTFNBTGg2TVNUWFo4TGphTkQ4M3NHcmFrM0NPeTRkdThSakZrK1ozRHUv?=
 =?utf-8?B?amJBM0JNRGpndlRhZGo3VVY0UG5rQkpvMmROc2VSYUlTVlBMMm9OOFkrdlo0?=
 =?utf-8?B?UUlyNDVpaGxJM1VqUHJLTGp2cHc5STIrM0FTS0o4RytlaDBkTWJoUzVCVU1s?=
 =?utf-8?B?V2tCVHlSYS9SYlI2NFU1eTdTVSs3UjJKbE5OemhxZXJlN2dZMUp4T0ZYYmRO?=
 =?utf-8?B?VDNadWMzZU93TWxOamc2M1JObUxSWEtVbW1DK3pGQzNTZmQwai9idm9Kd3l4?=
 =?utf-8?Q?o+YmbZQp4HzX3BU2kWupRR29UNPQ8eFLdYjrCD24GAxD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a824d2d-f0ab-472f-d1b3-08dabe443fc4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3589.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 09:09:16.5919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYuCpOsVUrZOhwFDvLURX4UkDSyriQ+S5HCIP4GtzY+DCTyG5YEKxQnx2FhVA14E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5196
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 04.11.22 um 09:52 schrieb Tong Liu01:
> Move TMR region from top of FB to 2MB for FFBM, so we need to reserve TMR region
> firstly to make sure TMR can be allocated at 2MB

If I understand it correctly the two methods are mutual exclusive. So I 
think you can just extend the existing function in the amdgpu TTM code 
instead of adding a new one.

>
> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 84 ++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 52 ++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  6 ++
>   drivers/gpu/drm/amd/include/atomfirmware.h    | 56 +++++++++++--
>   4 files changed, 171 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index b81b77a9efa6..f577b1d151d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -106,34 +106,74 @@ int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)
>   	struct atom_context *ctx = adev->mode_info.atom_context;
>   	int index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>   						vram_usagebyfirmware);
> -	struct vram_usagebyfirmware_v2_1 *firmware_usage;
> -	uint32_t start_addr, size;
> +	struct vram_usagebyfirmware_v2_1 *firmware_usage_v2_1;
> +	struct vram_usagebyfirmware_v2_2 *firmware_usage_v2_2;
> +	uint32_t start_addr, size, fw_start_addr, fw_size, drv_addr, drv_size;
>   	uint16_t data_offset;
> +	uint8_t frev, crev;
>   	int usage_bytes = 0;
>   
> -	if (amdgpu_atom_parse_data_header(ctx, index, NULL, NULL, NULL, &data_offset)) {
> -		firmware_usage = (struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
> -		DRM_DEBUG("atom firmware requested %08x %dkb fw %dkb drv\n",
> -			  le32_to_cpu(firmware_usage->start_address_in_kb),
> -			  le16_to_cpu(firmware_usage->used_by_firmware_in_kb),
> -			  le16_to_cpu(firmware_usage->used_by_driver_in_kb));
> -
> -		start_addr = le32_to_cpu(firmware_usage->start_address_in_kb);
> -		size = le16_to_cpu(firmware_usage->used_by_firmware_in_kb);
> -
> -		if ((uint32_t)(start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
> -			(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
> -			ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
> -			/* Firmware request VRAM reservation for SR-IOV */
> -			adev->mman.fw_vram_usage_start_offset = (start_addr &
> -				(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> -			adev->mman.fw_vram_usage_size = size << 10;
> -			/* Use the default scratch size */
> +	if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
> +		if (frev == 2 && crev == 1) {
> +			firmware_usage_v2_1 =
> +				(struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
> +			DRM_DEBUG("atom firmware v2_1 requested %08x %dkb fw %dkb drv\n",
> +			  le32_to_cpu(firmware_usage_v2_1->start_address_in_kb),
> +			  le16_to_cpu(firmware_usage_v2_1->used_by_firmware_in_kb),
> +			  le16_to_cpu(firmware_usage_v2_1->used_by_driver_in_kb));
> +
> +			start_addr = le32_to_cpu(firmware_usage_v2_1->start_address_in_kb);
> +			size = le16_to_cpu(firmware_usage_v2_1->used_by_firmware_in_kb);
> +
> +			if ((uint32_t)(start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
> +				(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
> +				ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
> +				/* Firmware request VRAM reservation for SR-IOV */
> +				adev->mman.fw_vram_usage_start_offset = (start_addr &
> +					(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> +				adev->mman.fw_vram_usage_size = size << 10;
> +				/* Use the default scratch size */
> +				usage_bytes = 0;
> +			} else {
> +				usage_bytes =
> +					le16_to_cpu(firmware_usage_v2_1->used_by_driver_in_kb) << 10;
> +			}

That should probably be put into separate functions.

Regards,
Christian.

> +		} else if (frev >= 2 && crev >= 2) {
> +			firmware_usage_v2_2 =
> +				(struct vram_usagebyfirmware_v2_2 *)(ctx->bios + data_offset);
> +			DRM_DEBUG("atom requested fw start at %08x %dkb and drv start at %08x %dkb\n",
> +			  le32_to_cpu(firmware_usage_v2_2->fw_region_start_address_in_kb),
> +			  le16_to_cpu(firmware_usage_v2_2->used_by_firmware_in_kb),
> +			  le32_to_cpu(firmware_usage_v2_2->driver_region0_start_address_in_kb),
> +			  le32_to_cpu(firmware_usage_v2_2->used_by_driver_region0_in_kb));
> +
> +			if ((uint32_t)((le32_to_cpu(firmware_usage_v2_2->fw_region_start_address_in_kb))
> +				& (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
> +				fw_start_addr = (le32_to_cpu(firmware_usage_v2_2->fw_region_start_address_in_kb))
> +					& (~ATOM_VRAM_OPERATION_FLAGS_MASK);
> +				fw_size = le16_to_cpu(firmware_usage_v2_2->used_by_firmware_in_kb);
> +
> +				/* Firmware request VRAM reservation for SR-IOV */
> +				adev->mman.fw_vram_usage_start_offset = fw_start_addr << 10;
> +				adev->mman.fw_vram_usage_size = fw_size << 10;
> +			}
> +
> +			if ((uint32_t)((ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)
> +				& (le32_to_cpu(firmware_usage_v2_2->driver_region0_start_address_in_kb))) == 0) {
> +				drv_addr = (le32_to_cpu(firmware_usage_v2_2->driver_region0_start_address_in_kb))
> +					& (~ATOM_VRAM_OPERATION_FLAGS_MASK);
> +				drv_size = le32_to_cpu(firmware_usage_v2_2->used_by_driver_region0_in_kb);
> +
> +				/* driver request VRAM reservation for SR-IOV */
> +				adev->mman.drv_vram_usage_start_offset = drv_addr << 10;
> +				adev->mman.drv_vram_usage_size = drv_size << 10;
> +			}
> +
>   			usage_bytes = 0;
> -		} else {
> -			usage_bytes = le16_to_cpu(firmware_usage->used_by_driver_in_kb) << 10;
> +
>   		}
>   	}
> +
>   	ctx->scratch_size_bytes = 0;
>   	if (usage_bytes == 0)
>   		usage_bytes = 20 * 1024;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 585460ab8dfd..099605380b06 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1578,6 +1578,22 @@ static void amdgpu_ttm_fw_reserve_vram_fini(struct amdgpu_device *adev)
>   		NULL, &adev->mman.fw_vram_usage_va);
>   }
>   
> +/*
> + * Driver Reservation functions
> + */
> +/**
> + * amdgpu_ttm_drv_reserve_vram_fini - free drv reserved vram
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * free drv reserved vram if it has been reserved.
> + */
> +static void amdgpu_ttm_drv_reserve_vram_fini(struct amdgpu_device *adev)
> +{
> +	amdgpu_bo_free_kernel(&adev->mman.drv_vram_usage_reserved_bo,
> +		NULL, &adev->mman.drv_vram_usage_va);
> +}
> +
>   /**
>    * amdgpu_ttm_fw_reserve_vram_init - create bo vram reservation from fw
>    *
> @@ -1604,6 +1620,32 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
>   					  &adev->mman.fw_vram_usage_va);
>   }
>   
> +/**
> + * amdgpu_ttm_drv_reserve_vram_init - create bo vram reservation from driver
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * create bo vram reservation from drv.
> + */
> +static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
> +{
> +	uint64_t vram_size = adev->gmc.visible_vram_size;
> +
> +	adev->mman.drv_vram_usage_va = NULL;
> +	adev->mman.drv_vram_usage_reserved_bo = NULL;
> +
> +	if (adev->mman.drv_vram_usage_size == 0 ||
> +	    adev->mman.drv_vram_usage_size > vram_size)
> +		return 0;
> +
> +	return amdgpu_bo_create_kernel_at(adev,
> +					  adev->mman.drv_vram_usage_start_offset,
> +					  adev->mman.drv_vram_usage_size,
> +					  AMDGPU_GEM_DOMAIN_VRAM,
> +					  &adev->mman.drv_vram_usage_reserved_bo,
> +					  &adev->mman.drv_vram_usage_va);
> +}
> +
>   /*
>    * Memoy training reservation functions
>    */
> @@ -1771,6 +1813,15 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   		return r;
>   	}
>   
> +	/*
> +	 *The reserved vram for driver must be pinned to the specified
> +	 *place on the VRAM, so reserve it early.
> +	 */
> +	r = amdgpu_ttm_drv_reserve_vram_init(adev);
> +	if (r) {
> +		return r;
> +	}
> +
>   	/*
>   	 * only NAVI10 and onwards ASIC support for IP discovery.
>   	 * If IP discovery enabled, a block of memory should be
> @@ -1896,6 +1947,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>   					&adev->mman.sdma_access_ptr);
>   	amdgpu_ttm_fw_reserve_vram_fini(adev);
> +	amdgpu_ttm_drv_reserve_vram_fini(adev);
>   
>   	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 9120ae80ef52..c60246f32f98 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -92,6 +92,12 @@ struct amdgpu_mman {
>   	struct amdgpu_bo	*fw_vram_usage_reserved_bo;
>   	void		*fw_vram_usage_va;
>   
> +	/* driver VRAM reservation */
> +	u64		drv_vram_usage_start_offset;
> +	u64		drv_vram_usage_size;
> +	struct amdgpu_bo	*drv_vram_usage_reserved_bo;
> +	void		*drv_vram_usage_va;
> +
>   	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>   	struct amdgpu_bo	*sdma_access_bo;
>   	void			*sdma_access_ptr;
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
> index ff855cb21d3f..9f8761407099 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -705,10 +705,47 @@ struct atom_gpio_pin_lut_v2_1
>   };
>   
>   
> -/*
> -  ***************************************************************************
> -    Data Table vram_usagebyfirmware  structure
> -  ***************************************************************************
> +/*
> +  VBIOS/PRE-OS always reserve a FB region at the top of frame buffer. driver should not write access that region.
> +  driver can allocate their own reservation region as long as it does not overlap firwmare's reservation region.
> +  if( atom data table firmwareInfoTable version < 3.3) { //( pre-NV1X )
> +    in this case, atom data table vram_usagebyfirmwareTable version always <= 2.1
> +    if( VBIOS/UEFI GOP is posted ) {
> +      VBIOS/UEFIGOP update used_by_firmware_in_kb = total reserved size by VBIOS
> +      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10)
> +      driver can allocate driver reservation region under firmware reservation,
> +      used_by_driver_in_kb = driver reservation size
> +      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
> +    Comment1[hchan]: There is only one reservation at the beginning of the FB reserved by Host driver.
> +    Host driver would overwrite the table with the following
> +    used_by_firmware_in_kb = total reserved size for pf-vf info exchange and
> +    set SRIOV_MSG_SHARE_RESERVATION mask start_address_in_kb = 0
> +    } else {
> +      there is no VBIOS reservation region
> +      driver must allocate driver reservation region at top of FB.
> +      driver set used_by_driver_in_kb = driver reservation size
> +      driver reservation start address =  (total_mem_size_in_kb - used_by_driver_in_kb)
> +      same as Comment1
> +    }
> +  } else { //( NV1X and after)
> +    if( VBIOS/UEFI GOP is posted ) {
> +      VBIOS/UEFIGOP update used_by_firmware_in_kb = atom_firmware_Info_v3_3.fw_reserved_size_in_kb;
> +      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10  )
> +    }
> +    if( vram_usagebyfirmwareTable version <= 2.1 ) {
> +      driver can allocate driver reservation region under firmware reservation,
> +      driver set used_by_driver_in_kb = driver reservation size
> +      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
> +      same as Comment1
> +    } else {
> +      dirver can allocate it reservation any place as long as it does overlap pre-OS FW reservation area
> +      driver set used_by_driver_region0_in_kb = driver reservation size
> +      driver set driver_region0_start_address_in_kb =  driver reservation region start address
> +      Comment2[hchan]: Host driver can set used_by_firmware_in_kb and start_address_in_kb to zero
> +      as the reservation for VF as it doesn’t exist.  And Host driver should also
> +      update atom_firmware_Info table to remove the same VBIOS reservation as well.
> +    }
> +  }
>   */
>   
>   struct vram_usagebyfirmware_v2_1
> @@ -716,9 +753,18 @@ struct vram_usagebyfirmware_v2_1
>     struct  atom_common_table_header  table_header;
>     uint32_t  start_address_in_kb;
>     uint16_t  used_by_firmware_in_kb;
> -  uint16_t  used_by_driver_in_kb;
> +  uint16_t  used_by_driver_in_kb;
>   };
>   
> +struct vram_usagebyfirmware_v2_2{
> +  struct  atom_common_table_header  table_header;
> +  uint32_t  fw_region_start_address_in_kb;
> +  uint16_t  used_by_firmware_in_kb;
> +  uint16_t  reserved;
> +  uint32_t  driver_region0_start_address_in_kb;
> +  uint32_t  used_by_driver_region0_in_kb;
> +  uint32_t  reserved32[7];
> +};
>   
>   /*
>     ***************************************************************************


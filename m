Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBE3C3ABD8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 May 2025 07:08:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89AC110E9BC;
	Fri, 16 May 2025 07:08:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5mH5A7h0";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30F0A10E9BC
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 07:08:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBv2vh+K7httI/YRMElEgRnvNuG2f1unl3w+sONENoZPq4OeW/XYCZRAvHB9jf/DQmLt+W9bWmWrdIxW59StoEx6ADNp03WHNT8+hAmoPZANCihPM4Q3a6eehGJ7Zv808OJnh8g6dLzSKD47GMXBHKTa3i7zsd9vdCOfkh9fns9A5fY7GL33MAo32UvogRZWxqPvbFkqRLmW8JxtuALNMm2l1pxGow06sCWl0KZYEvXnzKD9zY7VGmgtdyNh28Uq0Chss0MkVd2MWeZjJb2YltFlp3gAyc6Vc+6EB9TyI6Lf8hu3GrUHigkqHL/eJH2P1ey+Mpim4rk0PQuKQQTbmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORbQsfnVmXvORJAHIUhxWgiGtVXNE+0J0CHP3bHQq9w=;
 b=pEwCRvUK8lsVfbgilGrExz4Ex/FiBagvSt+IfwQV7YyPglJQLa8p+s0XrMK7607sUR5iLxgVsAsRD5cdkSLEW3EDsW5igOlBrYAILvqs73L4bVcOpxFYRpP7VvCzk9ER2iYnzNx2elf0AY9f8FVw79Hj7dfxh0P8H6fMHbeE/bdFApXPgL75ajZBrwSEu2bLtgrffkN4yHZe46kOhCNRi95Cj8xYwGwXu6areWjsNtSA1hqGnzYrtruw/CBWVKQthfSm4ZYJeKF2KUW90/rGTTNYCmNEM8QupwyqPURA6d2HFgdNPycIdjmmJfDCgyDo4sNwHFDDXKrxoQA7F0gsqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORbQsfnVmXvORJAHIUhxWgiGtVXNE+0J0CHP3bHQq9w=;
 b=5mH5A7h0F4/kO8oQ3d9EshA44Q97MMK7QdIyQmtiuN+CcHCms1mon2+fveiQ85Ezd88is3p70UAj3Jp53azm7h2uoNUhiOdzMglizAmJyMFCMusUC3tCyq+t3nz2DUDIlwWQRrKaKVHUYAsEsBHC4v/+zrwyfA06yTuT/HEdFKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6686.namprd12.prod.outlook.com (2603:10b6:a03:479::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 07:08:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%7]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 07:08:01 +0000
Message-ID: <b52390dc-05a3-463b-9bee-001c6cafb303@amd.com>
Date: Fri, 16 May 2025 09:07:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] drm/amdgpu: read back register after written
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, leo.liu@amd.com, sonny.jiang@amd.com,
 ruijing.dong@amd.com
References: <20250515164102.808954-1-David.Wu3@amd.com>
 <20250515164102.808954-9-David.Wu3@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20250515164102.808954-9-David.Wu3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6686:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3fff6d-0eed-450d-f9b8-08dd944864a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ci8vRlpUek95SzMweU5kdE1IWTJuWHU5WDFBVi9ibUNHNTFSVmRQTnpYdEhQ?=
 =?utf-8?B?ZFdpZXNqNGxTM29RbjJjbXlEY0duYStVdm9zRmdzNk53bjlnU2ZOY2FUMENV?=
 =?utf-8?B?OVRZVjE2STdrRThzeTFaeFlXbWtzbjgvRm1iSy9OZ1RRSHpxdTZZL3E1RGtJ?=
 =?utf-8?B?bnJ3SEw3V3FtSyswNVduak1jU1VUOExPQXJ1ZTc4U2xHQjJnTnlnS0xPYXM0?=
 =?utf-8?B?SmxlazI5ckhVUjBtMFFVK1NyNFpnT243RjhuWXlQd011ZGlBNEdibHJjbGlt?=
 =?utf-8?B?VDdGQ2EwbEVudjNoV0JsWUVzRXVjR0E0L2tyYkxxU0NaUDlpNjFWOWpvWG5G?=
 =?utf-8?B?N005MzBNWW9FZ0tUSTExbEgvbTlzSGowTUJMZjZPdktvMDJPZ1ZOM0VpTzBl?=
 =?utf-8?B?SElTODBiakFKbTNnYi93YnVNV2Y0TW85U2t0akNuT0I0K1k0TTVrRjdOdFJi?=
 =?utf-8?B?NW43c09OS1JIN25VbC8xdFdVNDlvNmJNZHU1Q0E4M3pYbVdwV1NwWUgzV2wr?=
 =?utf-8?B?NkdoWWp3VW1iVWZxcStSTTBxOEFEdEhaYzV2UnZONlFSWjZubXZYcDU3dk45?=
 =?utf-8?B?MThob0JXVStuOU9pUmw3NEp4YWdKcmZwWVBVUW9LNG11U2lqQVZBTE9TRXBQ?=
 =?utf-8?B?QURHL01kV01WYjJ2NXh3dFJFYitFWnQ0bzJ6MDRrcENtZFNqdEk5by9VWlA2?=
 =?utf-8?B?ejZVcy83SElpRmFGcW01aGFLVE5MRDJPbWNHWmZlMmxQck5LWTdNZitiVjFv?=
 =?utf-8?B?UkZhSGVGVDh0SWlNWDNxRGRxYk8vR1dqTjBmS3h4Q2NRRHkwVGhjMHVqU0hL?=
 =?utf-8?B?YkhOZ3RvY2JsaDVFU294aFQ1OU5lcEZFa0hyclpXTG5OWkxYU2JxU2c1VCtt?=
 =?utf-8?B?SVp3SEtKUGU5WXVPb24ySGFpaHRycVB5ZUFJcE1GcTgrQjZwcFVNWEJabG1C?=
 =?utf-8?B?cEcwN2JSTGRSdDJmejduMjVuNERoaHBqUlE5M3grbHNwUC9CZGozYmYxMDBU?=
 =?utf-8?B?RUNyYVY4K2JDZW5lWlRuWnpzQ0VQWFROcUtxTGZ4MW50OXMwL3lYMmE0d21z?=
 =?utf-8?B?aUlMZkpWdkhZVXFrMW5HdURjTHBBM2FDMS9CQlFncEFKamp6UHIyRUJBWlpD?=
 =?utf-8?B?M2YrVFQ1a0hkTVV1ZzdjN2hIMmo4VGVNYlF3WXV1ZjFsUDl6Ui85VDNna1Nh?=
 =?utf-8?B?N05pL0xEUXptc2krTU5aSmJhNUlxeEdqc2xGMHBDK21LbVVEdjUxdU9heGRi?=
 =?utf-8?B?UVJiNy9UVjVEY2ZSMmxoVDMrZkxCb1RCTnAvamw0dzlTSXRMc25BSUJmby9I?=
 =?utf-8?B?bWNteS80WE56aHNoS1JlQnpUcUU2NStuRHo0YlJOOGFBOHVIMnNjb2lld0hG?=
 =?utf-8?B?R3RsKytsaHJZVVcyZkkrSkRWQ3o4UDdCaUg1aERJcGpyK0ZJYkh5SmVTTUtT?=
 =?utf-8?B?YXA1dFNjNjZQbEtzYy9HOGNtTmdjVnpwb2pGZnp1NnVMRFVSTjJZRFJ2N2tw?=
 =?utf-8?B?cHlGMWlJNUNDOGw4QXhleitLQnd1cXR2R0t0ZkRQaDBaNGR1NEd2K1plV284?=
 =?utf-8?B?L1c5K28wMkhJd2c1dkFYOU9VMkQyRW9nR1Y3RWpyL1VreTl4OUo0UklyVk9S?=
 =?utf-8?B?bVlmdVpCbFdmSU1ld0d2S1ZNU1pZMGc5RkRsbmNFN0JjTDZmMWRIcFFDWTJL?=
 =?utf-8?B?S1RLVzZVSUJyQklzYTVsMFRFaUJyWGRIMndqTWZjMWF0cDVISWVnOC9PQlBS?=
 =?utf-8?B?TXJDUHZCUGhiOFpLaFBGQ0xscnF4c1h1UnNzckhsOVFLVkR0cklWZVhlRFdK?=
 =?utf-8?B?ejJudFc3RDRzTGFPRVl0b2N0RVVXS25WaHBsQnNhNytPanpwdmk1bVpydkhj?=
 =?utf-8?B?d2txUjZ2NVJLUlBBSHFGMHdSSVprODd5MExpMmc4QTdaN3BNN2hncHpGSm5s?=
 =?utf-8?Q?bJEz/HUfBrE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVphTTBJMHZJV2RkaUtxUG4xZFc2MzRRa1hPT1hrWk1iV1VPWTQxQTZqMlk5?=
 =?utf-8?B?eDUxdlRmZVZ4SnkxSDVyem9YVk8va0lBdVVlWlJzcGpzZFJjZVFZNkpETmI1?=
 =?utf-8?B?TEVjS0lwM3hFcTFoUndqRjVZd29UTlhNc2xXa2Z1UVIwTCtOdHRBdmtEWXJo?=
 =?utf-8?B?ZklxYlUwcE1ESEIwaGp1ZmZSVkFLSVRLcEQydkhyVmc2TnRVMysvRDZieHBi?=
 =?utf-8?B?OXYwUy9xTThPTXJCdVhHMm1LR1FRa1hUOUFDUU1yT0t3NFVGMUF6MXJLT25p?=
 =?utf-8?B?b3VzVlpOQzJRR2I2cG9URHZOY0QvbDY5Rkh1Y1BNR0lGMlAvUG5zN01mckQ5?=
 =?utf-8?B?am9iYW45RHlFcVVXbTlTdkM3NDlyeTNtODU3eTVJeXQzODRab2QwaXJ0MWV4?=
 =?utf-8?B?TzdCM21CWUJDODY2Vmw2QjJlVzB6SURDQjZPNkM1dDZVdldzMmJ3OWl2b3RR?=
 =?utf-8?B?YVpaNVFzSjR3Y3hzN2ZVbVJHTFI2aUVweHFjZ2lER2xpdzhLMzFtbllaNkND?=
 =?utf-8?B?bnIrc3dsMHlnT3JBaTdDRWZKUFpSR3BvUTQ5d1VUS1NseFZYZGZsbyt1TGpW?=
 =?utf-8?B?SzhiNVhlTDNYeGNqQ1FGd3NseXI0d3JDMjMvL1BwYVE0VjFuMGlEUEdPVXN2?=
 =?utf-8?B?QzFJWTdrVDhKa2F1N3RLcGhsUnNoRGJUNmgxa2RQQ3owQTNGQnA1S1ovazVm?=
 =?utf-8?B?MWFKVnA1b1ZFUmNqdVFnRGtaVVRENzJNWlBZS2xDZjhqTUpqcnM1MWlvNmV2?=
 =?utf-8?B?OW9tVlFBd01WTkpjZmRpbnhNeDlNbkV0Z1hQNUp4OVk3QzIwMmtkVGV0WUtj?=
 =?utf-8?B?ZlY3akthVmFjVGxOVjM0ejZqdXVUM2NjMVlicy9wbVNwYjFmQXk3Z1hESHV4?=
 =?utf-8?B?Vjh5WUxBWjZWeVR2UEd2cC82dTFFNWd3SHA2djFpRWZkeVhpT2lPUDFsNGQv?=
 =?utf-8?B?Nk9PUU00SzN2MGUzMlNTODJWWWt3c2paM1R3V1JLbnpjcjZTZUp3NElKNHBP?=
 =?utf-8?B?M1prU1lRRWt2bUYxYkhhS3BJdzRMMjFnTVZaSnhPekc5WmZZOUo3Z2xDOXlB?=
 =?utf-8?B?Q05CK1h2MmJDRlU4UXF3SUU2bko1dmIrRUdnNjVBdzhrS0J0SHJrdEpJaC9n?=
 =?utf-8?B?VGIxK1JZRkE4U3VuYU1MakNvYSt3R1FTa295MUk1WFJHM3cxd054b25EdWhU?=
 =?utf-8?B?cGZHRDFYQStOczZhOCtBUDhTaWJ1bXV2NXFMMXg0V00zQ1RBQUhwWTJEeVk3?=
 =?utf-8?B?QktSS2QzTFplYm4yWVRKL0xYeFpLeThHejd0SzVvTTU1c1psNUxGNWJkVkha?=
 =?utf-8?B?aUl6eldFU3NVRGdNQnVzUHljQXE2SUFNci82TmZWdjU5Mmo1VWRzUktNZDFR?=
 =?utf-8?B?eXlqZ0w3MGVIZC82Zk1FRDQwR3JFSU03dWVYUlZhc0lQN05UME5EYWwwSEtj?=
 =?utf-8?B?akQ4QUdTbndGUmNDZjl0YWVVZG9MTm1XNmNMYzRJRlB6RGFSa2VvMjNidUs5?=
 =?utf-8?B?RzYveERYNXJnWU4xN3RLQTJBS3hqMnQzczFDeDVYZFczcXo2Q0xkNzI0eGJE?=
 =?utf-8?B?U2RuSE9FcWJVUEhkbDZuVVFIdHBsSWlTa0NlYVVDVGU2NWMvcVY4QzJYWlBL?=
 =?utf-8?B?ZzBPVEFoNk1hak44Tm5VanZiTTdPdVBTc1FIS3Z6dk85RUtWTFJkUnRXaUcy?=
 =?utf-8?B?YkZsMGRtbkppcVJPZE1YZmpCaSt2RENLM2dna1JpWU4xTVphZUQ3Vk9xUHIz?=
 =?utf-8?B?MGZ4RzhtcTdKVHpkbE81bWhxQ0ZndDgxelRIa2tkRmFFU2VPUVE3dytYL2lZ?=
 =?utf-8?B?ZFVMSExHSWs4Skl1V0RyZk1kNkhtbWxRRHhnS0x5cktnY2lqZ2dYNXVLNmFH?=
 =?utf-8?B?ZkVxY2Nxd1NhQUwyRE1LWENldVh2Tlh5dWNmcHM2Q1EybFR5TGZFaVFxSjJo?=
 =?utf-8?B?aW5CandpVFVpNU0zNHhkbDVaYXg1R3pZSXB5bHp2aWNxR1kzS0lZOGg0d2tZ?=
 =?utf-8?B?Y2FXYjRvUGlxMytBeDNZT0lCR0x3bFkxaGFjYkk3UmxPTlVNaFZ3OGp1SEFV?=
 =?utf-8?B?QTBWOHVDejQwWk9HWmhCMnJ4ZzhIcVVYV0N4K21DU05BRVNQTUZ3Q3B1UEVI?=
 =?utf-8?Q?K5omClejeirwJkRjenkdZAxSO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3fff6d-0eed-450d-f9b8-08dd944864a8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 07:08:01.7821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LIfLYdaVERlOn+TNvPPKP3dubd6xJSXGnnPiV9bhq5IJu81mpP+MOhAfmZysma+J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6686
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

On 5/15/25 18:41, David (Ming Qiang) Wu wrote:
> The addition of register read-back in VCN v5.0.1 is intended to prevent
> potential race conditions.
> 
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index 60ee6e02e6ac..79d36d48a6b6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -657,8 +657,11 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
>  	WREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL,
>  		ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
>  		VCN_RB1_DB_CTRL__EN_MASK);
> -	/* Read DB_CTRL to flush the write DB_CTRL command. */
> -	RREG32_SOC15(VCN, vcn_inst, regVCN_RB1_DB_CTRL);
> +
> +	/* Keeping one read-back to ensure all register writes are done,
> +	 * otherwise it may introduce race conditions.
> +	 */
> +	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);

I'm not sure that this is a good idea.

The read back from specific registers was usually to sync up with the clock driving those registers, e.g. the VCN_RB1_DB_CTRL register here.

Could be that for VCN we only have one clock domain, but if you would do this for one of the old PLLs for example I can guarantee that it won't work.

Regards,
Christian.


>  
>  	return 0;
>  }
> @@ -809,6 +812,11 @@ static int vcn_v5_0_1_start(struct amdgpu_vcn_inst *vinst)
>  	WREG32_SOC15(VCN, vcn_inst, regVCN_RB_ENABLE, tmp);
>  	fw_shared->sq.queue_mode &= ~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF);
>  
> +	/* Keeping one read-back to ensure all register writes are done,
> +	 * otherwise it may introduce race conditions.
> +	 */
> +	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
> +
>  	return 0;
>  }
>  
> @@ -843,6 +851,11 @@ static void vcn_v5_0_1_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
>  	/* disable dynamic power gating mode */
>  	WREG32_P(SOC15_REG_OFFSET(VCN, vcn_inst, regUVD_POWER_STATUS), 0,
>  		~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
> +
> +	/* Keeping one read-back to ensure all register writes are done,
> +	 * otherwise it may introduce race conditions.
> +	 */
> +	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
>  }
>  
>  /**
> @@ -918,6 +931,11 @@ static int vcn_v5_0_1_stop(struct amdgpu_vcn_inst *vinst)
>  	/* clear status */
>  	WREG32_SOC15(VCN, vcn_inst, regUVD_STATUS, 0);
>  
> +	/* Keeping one read-back to ensure all register writes are done,
> +	 * otherwise it may introduce race conditions.
> +	 */
> +	RREG32_SOC15(VCN, vcn_inst, regUVD_STATUS);
> +
>  	return 0;
>  }
>  


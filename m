Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4838C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Oct 2022 10:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A84AD10E0CB;
	Thu, 13 Oct 2022 10:27:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EEB810E7BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Oct 2022 10:27:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gS9dYrLUXdxjGu+ANX0YH+uFwsDzd35M9iFdRSIVXpRsL1cV9/NYsu0Mdz/qzYazjGghV4Kel99acHJG7cDlA4MZpj8I+aMbPX3hmYXmTI01x/MUeCly8/P3AHXuMYe9ZGXaxkX83XlW76C8EaXkTjTM4V1uW4hS8GsoBtrhXISiHpYKRHfjJB5yonVMhXUGbgoWNZgWFoyYtYeaCMjPipTCH7rQfA/a90boHRkmU4o2DLsTpcIP73ztBR2U63fbiwLtj438gDdiCFPZFUoelJtE5K0Dtna1kkUA6bFXEwot8dcSesnS8zbB/HEUskShXBsb/wSNw7daI7cAvxFCOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onyaO6pXhD6lGCkeQuUXfet/EUPZX6dZeocgwuWF8hI=;
 b=njNi6cKYTqtxcaRcojzdqIVRoLctA7clgrlBh4xYrmOkrN0Z3ULxeE9r33ByIiiLgiQO0xTsmJLeieh8Cgg3/l8bP1uBxJKD0lMYFLqQqGFLo9f0gZ20yUDJnwN/JBVvgFNrF0fsg+FccDQeSKWZKI5cR7Q2IqOEBQReol3vEG2zBa9DChlfLAcaaBXHloD8LGmqCQHtTJ8ONRDp4xTjkzV4QEkiLZR1ma0EaW9tW6zCUst+7bQQg7+0OolvXFbNG5J3IWl8Q9ewi+PaTSwVNCfT5K+qLN35xs6IBVGXcwDt3Z3h1oaKqDDGYuNJGzx2CnAT0gIu5ucPENIBnRFbTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onyaO6pXhD6lGCkeQuUXfet/EUPZX6dZeocgwuWF8hI=;
 b=tn0NVloIH5qh9bMVTD4KKD+PaUhBdyN/nc8c9XKYNmYq+rBLv4OZgkFjYQl4CnIfCT8CzVcplLjLH5aS7Sb08xHAAUu887aI2AQ5Fxj+eA57csb3BQOBWfuyAoMwf+mlKY6UD6FDvHOQ5Eg0+sP1RuW6HF+X53kKFdL6FJjqQsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS0PR12MB7512.namprd12.prod.outlook.com (2603:10b6:8:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.35; Thu, 13 Oct
 2022 10:27:26 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::60f0:f1d8:6b87:3821]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::60f0:f1d8:6b87:3821%6]) with mapi id 15.20.5676.030; Thu, 13 Oct 2022
 10:27:26 +0000
Message-ID: <59b89250-4352-a1cc-6d7b-67c0d782838b@amd.com>
Date: Thu, 13 Oct 2022 15:57:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/3] Revert "drm/amdgpu: add debugfs amdgpu_reset_level"
Content-Language: en-US
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221013082745.46143-1-Victor.Zhao@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20221013082745.46143-1-Victor.Zhao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0138.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::10) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DS0PR12MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ab58680-7cc6-41b6-c036-08daad058604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+tiH5S2aGzfPz9Cs9xiwqsZSeEI9Iy/cTR9ua3b9JBNbibZLi+OmgM3xVLNokXtAbM1CHd2XgqVMsOOYIZ09wv2dePKeyJvaGJicAfbwmFqSkO5i4oEbdPDcf0aGyWtYxFA4qICllgZUUA1y/ALGll8DcOF/fWJT3hPAvrqCKfPgtdD1VpG0MM3bMgRtywqgDInogAfpHbe7fcb7rv3gFqHtzPjdHuZVVFZy0X5Nvwc09TyvipFkkOJgBAyAxG3mBd7d7T1PkplemIy5/bemk4yYvJkilgbjBPW305hl60g6RvwXQfP0huawjjxCVAt51VYEzUCXkxUmjRtB3OBy6HLsCy29BWqgbpllyehXYy5ek9Fvs0J/etg5ov0GtUpsC9wKokQaH7E/pouZtZ4HqlYU34yACSY64b6gEWXYrO0fpzjWGMzKPt8KhQWMhoubqHD0LlkAVnjxT0qbSDKnJN2XBPWQW1MYiTRkC8xbNib3LoQWYfILh79aF0unJS9yQO8lfUOCOCwzhcu8LzO3dK1JB+uLmU2kl5hcieYb4+f6iHTgjE5kHY4UGM46vi2rTsaugracMqtniThHTMWh6CBNdVdd5c/+U/zysKEgXkLDgn1qsCqDfLMROTjcqDoeVlmffU2+Sr5xF/2ilFxE1ZwfbX07xNfTXfiTauOO7Dgl3ucGti/nsQ1Tj2Ft4dNkd2hAPj6PEv7EsUKvtlBbXRvVOehtvIj7mmX7CqtuBTDbEAj0m/2ar/kN93+dyzsoSB7Av0jYe1mjrn36JmAWo8qTe/4zy2NmLqgy1Iiwgo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199015)(83380400001)(6512007)(26005)(31686004)(186003)(316002)(31696002)(38100700002)(6486002)(478600001)(36756003)(86362001)(8676002)(6666004)(2616005)(6506007)(5660300002)(8936002)(66556008)(66476007)(4326008)(66946007)(41300700001)(2906002)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2NJV2hyRDFzcyt0eEsxcFBsWElqN3RsL0RIMFdDa0Nicy9sOGpnYzJBQnNH?=
 =?utf-8?B?OTM3WVIxSHdQcjEwZ0pzaEs2QThkRFJVS3pENGpzTVptQWx5MHI2UWJXcjZS?=
 =?utf-8?B?WFZQRWxYWXQralFqYitQZmFSc0Rqazd5MG1UcFVzdm11bW1FdGVwbzJxeUxV?=
 =?utf-8?B?MHBWcExnaXdKU0gzMkFlZTJmeVFmWnhpOERjUmNIN1JxLzlrUWpsUGxqZFpZ?=
 =?utf-8?B?OXVyNHZvWC9aaiswUTkvTWpaUzhPLzdmbU41cmI1Z2Rud3FIWmdaY05XczNO?=
 =?utf-8?B?WVFpYzNyQ1A4eDJwQjNjQVhsQit5TXdPdmhVMGlXSUtPTTUxMFRBbWtnQTJs?=
 =?utf-8?B?Z2JuamRac0M4eUlXUjMzRVhwMTEzVXIrekNxcHhxVEo2R1ZYbzh2ekVJU3dG?=
 =?utf-8?B?S0o2UlByRmY1K281N0d2aTlWT21tQlFKanN1VW0zRGN6VlY4c2JHbmZITWlp?=
 =?utf-8?B?SVV4MjFoNkRvemU1MnpZS3BVNVdOSzFQbXVHSXdJbEhUaWVCMTUvMUJGWWNL?=
 =?utf-8?B?cDFqcE5hV0ViMi9DcnJjZ2NCbGFTWkR1eXhLczBnckQwZzZVSDlXY0pRczNR?=
 =?utf-8?B?a3kzSE9WSmMyd29xK25heVJKQjllbW5rVU8xUThrOFVWWVVHcDg2bFY0KzA2?=
 =?utf-8?B?ZlpzbVVUb3NFWktCTXU0dm9ZbXpGU3lTTmlaU0M4RW90WjNjY1FpVFRmdVZh?=
 =?utf-8?B?N1NnVVo0SE5lL0U5S1NoNFJObk9sQXk2NzEzOE5YZkU0Z1BPMTFsazE3Qmdl?=
 =?utf-8?B?bTdlSXZFU1IwMFREQlB2bzBnSmxLcUcwRmppQU05YlByWkg5USs2TFd3QXgr?=
 =?utf-8?B?dHh5eDZQZ1RYcEJaaXR6c2xXN1BHb0NmVHlBS1EvcVQ2azkwQW9wUmxTdFpx?=
 =?utf-8?B?N3lqeGlRbG1WM0diVzBmOXhZYXlMclJvWlYwbnR5L2ZQU1kvK0xBeElTU1FZ?=
 =?utf-8?B?bmRGdWg5a01JbzEwTTZDc3RRMGZRdzRvbzBZVmNWUlhnOFFZQUFUb1ZNaDZn?=
 =?utf-8?B?NWJWcXhGOVlNaVJIa053LzlKa24zVXdGVy9LdXJWMUdwSVpQTWJXTytKZzRX?=
 =?utf-8?B?dGR5L29QRzRkVXRZSU12NktZNlM5enJwbXpYMnRYUnhzZWQxTkJTcWxvSndH?=
 =?utf-8?B?Mk0xd2tTQTUvMDIvUnkwazFCUFRJWHRyN0l3d3NBUEltRXM0WnFNZmN0RHo1?=
 =?utf-8?B?VSsvazV0Q0pKZ1JyMTFiNlIrV3A0UHBqNDk1cUo3RWFUcFhjZ0lEL2xMWVNn?=
 =?utf-8?B?WDkrTnh2WEgrRzBCUnRTaTZrbVhmN2hTUW5VVHltSTdIcUpEUUZkNDUwb29v?=
 =?utf-8?B?K3VoMnRsWXUzS0dZMnZqOG8vU2Z6MzhuUElnWnQxUy93T1VqYlp3QzZ3S1BJ?=
 =?utf-8?B?L05hdkFnVXZMcGpjNk9mMFpDZ0xIV2ZSUWF0TGFPRUVqcnN2N3JoWEhWZHpI?=
 =?utf-8?B?TFpMYkJhclF5YnlXWHN1WlRDaW50UStuVDBnVjRqd2hhNExXRXhUTkV2ZFRQ?=
 =?utf-8?B?Q3Z1dFY1MTlDejQ5L0cvNHlTa2M4THRuZkRBVGVRTk5WeUJ5eFRlWWtOSTNL?=
 =?utf-8?B?eDJhcWV4MEpmcHZ1QUF0Zm5PazUxdFN2UUZIQ3J5bVpaRitONkhaUG1sYW5E?=
 =?utf-8?B?MkJVZjg5OFVJU3VYWlJpWHR2MDZjZUVnajZEcFdzcSs2SHV2VjVYRkVRdW1k?=
 =?utf-8?B?SWljd2ZmQXVuMG4zZ3JuSGd1YTg2cmNuNHpzczlWeis3M0NDNmRnTGYycFBm?=
 =?utf-8?B?Y2c0c3kwSGY5N1YzMXcxUzJpcUlrRm90VVJwN2UxczVjM0RaOHJrS2g5TXNv?=
 =?utf-8?B?SndaVXdoUEdKaVlLeDZLUU5IdWJnaCsvQzMvcVhnM2RmK0lOOGEyc3RSNys1?=
 =?utf-8?B?NWhEYUZTcGRHTUdjNmROckJTOFpqeVFoN1FTUEpDY3pQR2pOcExzaWVqcTVJ?=
 =?utf-8?B?ZUZ3a2czbzFDcjVsWHM4cTQrVUphWitWa0hhOHFPSjl6RnJVQm1LckpVUldn?=
 =?utf-8?B?Wms5TldiUXBqVHVoMGV0TWtDMWNhakxGWWlsVlNzVkdFS1Y1TmNvTSs1aDNG?=
 =?utf-8?B?cWtsdS9MRWZKMEN2THpYbDFidEtVYTdDNzg0S2VxK1QwSnk1NEY1NVlYVnBr?=
 =?utf-8?Q?YcVUa8cUOjK8GiIXifq887knR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab58680-7cc6-41b6-c036-08daad058604
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 10:27:26.6089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BltL7Rubh5kSplCAzlt901faWyFEVgEaubL0gkB7F1hOkQv5j0MokOkimvZj07p0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7512
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
Cc: Andrey.Grodzovsky@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/13/2022 1:57 PM, Victor Zhao wrote:
> This reverts commit 3ae992d5e1194a16e3d977076eb5722fa6e410d8.
> 
> This commit breaks the reset logic for aldebaran, revert it for now.
> Will move the mask inside the reset handler.

Thanks for reverting. Please cc me also for refactored patches for SMU 
11.0.7.

Series is
	Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 4 ----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 2 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   | 8 --------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    | 3 ---
>   4 files changed, 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 3ce91f660c3f..0e6ddf05c23c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -274,9 +274,6 @@ extern int amdgpu_vcnfw_log;
>   #define AMDGPU_RESET_VCE			(1 << 13)
>   #define AMDGPU_RESET_VCE1			(1 << 14)
>   
> -#define AMDGPU_RESET_LEVEL_SOFT_RECOVERY (1 << 0)
> -#define AMDGPU_RESET_LEVEL_MODE2 (1 << 1)
> -
>   /* max cursor sizes (in pixels) */
>   #define CIK_CURSOR_WIDTH 128
>   #define CIK_CURSOR_HEIGHT 128
> @@ -1065,7 +1062,6 @@ struct amdgpu_device {
>   
>   	struct work_struct		reset_work;
>   
> -	uint32_t						amdgpu_reset_level_mask;
>   	bool                            job_hang;
>   };
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 6066aebf491c..de61a85c4b02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1954,8 +1954,6 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   		return PTR_ERR(ent);
>   	}
>   
> -	debugfs_create_u32("amdgpu_reset_level", 0600, root, &adev->amdgpu_reset_level_mask);
> -
>   	/* Register debugfs entries for amdgpu_ttm */
>   	amdgpu_ttm_debugfs_init(adev);
>   	amdgpu_debugfs_pm_init(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index 9da5ead50c90..831fb222139c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -37,8 +37,6 @@ int amdgpu_reset_init(struct amdgpu_device *adev)
>   {
>   	int ret = 0;
>   
> -	adev->amdgpu_reset_level_mask = 0x1;
> -
>   	switch (adev->ip_versions[MP1_HWIP][0]) {
>   	case IP_VERSION(13, 0, 2):
>   		ret = aldebaran_reset_init(adev);
> @@ -76,9 +74,6 @@ int amdgpu_reset_prepare_hwcontext(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_reset_handler *reset_handler = NULL;
>   
> -	if (!(adev->amdgpu_reset_level_mask & AMDGPU_RESET_LEVEL_MODE2))
> -		return -ENOSYS;
> -
>   	if (test_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags))
>   		return -ENOSYS;
>   
> @@ -98,9 +93,6 @@ int amdgpu_reset_perform_reset(struct amdgpu_device *adev,
>   	int ret;
>   	struct amdgpu_reset_handler *reset_handler = NULL;
>   
> -	if (!(adev->amdgpu_reset_level_mask & AMDGPU_RESET_LEVEL_MODE2))
> -		return -ENOSYS;
> -
>   	if (test_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags))
>   		return -ENOSYS;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 3e316b013fd9..d3558c34d406 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -405,9 +405,6 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
>   {
>   	ktime_t deadline = ktime_add_us(ktime_get(), 10000);
>   
> -	if (!(ring->adev->amdgpu_reset_level_mask & AMDGPU_RESET_LEVEL_SOFT_RECOVERY))
> -		return false;
> -
>   	if (amdgpu_sriov_vf(ring->adev) || !ring->funcs->soft_recovery || !fence)
>   		return false;
>   

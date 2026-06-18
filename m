Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D6BCD98ED
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 12:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5E9D10F2AB;
	Thu, 18 Jun 2026 12:09:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a+ClvHDl";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013022.outbound.protection.outlook.com
 [40.93.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A86D310F2AB
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 12:09:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4FZapOvoPcJ3RovRG5jFf1sT0hsFehSxKHY3CdLccCv0ptzjkBDPrMmt2R6ie5zq3tnforAtJQn7cScT6GhG/XstgNomcws5Fkhhn1PVl9o5ePU0J0BFVXSMHJcgTbea+QLsGqstRu2aZl9r1p62A6b5Qi8JZMm1aBBQOlOZEL6h+l6w7/bP8aUTAXzpPJyAGALHNYgiwqS+kmbshJ4BsKVSk9gVpQTGP/gCos0/farqdXvohDe9Bwt/vZi07wTwTdeUtBjZByJxXb7sr0LX489QsDSQVk2BmYdC2USJcf7IJf1TFFWQOWPAZsm+MGtTkzaEDh7iHsDZYdHXHSdhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ds9gkE4nsxcRuBOf7OEjg1iAKCkVDstl77MVAkps70=;
 b=VpveS3ow8cSnSPspoNKt6scLzNXX19DiH3L4WYgxACWaFtFC5T8KcB2m6/+QThRZHG5J40NSRQ8uZvH8mb+CA2i9P7ztGOrweKBQMx7J53jeblZGZKjqB5020AC2Os7Z6RSzwfUmBLkmkd8ligekPeGkXkYDeQYBHPR9nfv31Y0Uzc96X+UvgPnzg0MGqn1jMeUPWZv97y+rddAs3kTR9wcx2BA8NCB5vZIH70rgEQRuvP7dd+uYU8evOnaXHqmOu5VHyIxBKGV2vmnOhHSCYIJfImzL2fXIm9YbbGpVknw7wS44jnMzYDMif0JAUc+2aMdSwkf2TKr+crpqgVqduQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ds9gkE4nsxcRuBOf7OEjg1iAKCkVDstl77MVAkps70=;
 b=a+ClvHDlTgBbT8YnKr1y/v4/jjKFzCacC1zaRm2b1iGbin2n2MEpNzguYI4O9YlJRqjfbVU4NerlYDWNP9c3YEOaeo0Ok9j4RxRU0pmOlsDGvvZvEYkZjNbrhxKlrnEoF5+tb2hLE9jHucc/cN8lOFKuuzNvDquVaQoq/ERf4+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7482.namprd12.prod.outlook.com (2603:10b6:303:212::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 12:09:44 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 12:09:44 +0000
Message-ID: <7c1f4cd3-b455-453b-99d3-82a7cb6dc2f3@amd.com>
Date: Thu, 18 Jun 2026 14:09:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] drm/amdgpu: Delete soft reset code from legacy
 display driver
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>, =?UTF-8?B?TWFyZWsgT2zFocOh?=
 =?UTF-8?Q?k?= <maraeo@gmail.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>, Lazar Lijo <lijo.lazar@amd.com>,
 Martin Roukala <martin.roukala@mupuf.org>
References: <20260617191428.1784083-1-timur.kristof@gmail.com>
 <20260617191428.1784083-5-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260617191428.1784083-5-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0637.namprd03.prod.outlook.com
 (2603:10b6:408:13b::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: e012f159-5d89-4dac-399a-08decd327bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZHqxgUIXFVCUhGy5hoNqvYFjfG+2PEtw9R9SO4JahvsgYB5fctRHan0FJUtQv5K9kfQxTEz90TjKfrnNBjI/0iysBX7WnK0xwMZbZW3/+ozssuZkq3I+tsrsRCw1ylviwb9ef+T62jwbNhdpDmdRRr+SKu5QjDMy91RRXMLquf1XSPdn4HsXaJxjub6fy/DoDVwVQk+AxalMEL5hWIzff85ssGgJSG/XpXCeDioLdo3DXizNOCo7DIia6AXAQmdnGyFgFsFaFnZG5wDbHhVIQ5QXitiFOhLN/msfLyFVazFNq8KN7lukR2QB9PMwU+bValX556Zl2LoyLVEOvfUuczFuosSrnLl+mrKPGEGCJh2aknVLOBuMZggI1TOug45lJdcxcX3BUmaYJSFeU2P32AEdYDQK+y2+4aDfY27fio0xfx2GWBB/BJlqoRGqscvrFzg4ZILC3dHUKiDWXr+orHnNgxA4Xp6dlXkGHxULUngBpr7ky4zLreWUQLk7PaQ35FTYcawwaVEg+n+KXCDvxjIaV/L2jYzY/SaMYT0IYB5ywrjEPBHye7AGQUqQwB4XIjmR5jJEIVl81U4u4sV07A6OtiAkWyYquHl0X0daO9CILQ+5oN1g3xyE/ZkD+oQhI2Pit4CK07SlXhXZF1Zrjxrm7xGeW4JbhUE8/pdgZxPddEjTOrmepyQfeZ5V/Btm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2FpejFsdFVORHJNTmY3S3B0dzlHeHQ5T1FjbUw5ZFdGekU1YUFTOGJwamNY?=
 =?utf-8?B?UHRmamg2N1pPbjlROG9VaGJGZlR1YjRvT2x4UVJtN1JvTndjZTRPTzQxWmxv?=
 =?utf-8?B?TVJDd2xWaDQ1UUJmQitsQksxdlM3YVZiZFhpQktNQnZvcHNPUkd6czFPSXRN?=
 =?utf-8?B?OUJHdlFRbTBRUDUxYmptbW90Qklrd2ZoZ2lRRU04Qnh5allhRzQ1N2ptd0Rw?=
 =?utf-8?B?V0lRS1QrTTBTandhYnFFQnRyTzZ6a3loWFpPSjR2cHk0WnBZZXhTYUluZSt2?=
 =?utf-8?B?Q2FmMlo3YmVZamJVUkJTd2UzTnF1SGQ3K1FoWHVsOWtJbitOYzNxTk5HclFu?=
 =?utf-8?B?MnUwajdVei84bEFvaE1kWG1RYkxUanFmbHd3akZ6L2tiNFdkNExkRjdtOTh0?=
 =?utf-8?B?MVdRMkdiakVUZHBKaVJoQkNCN3dlSzRwRzV4QU9xSE95TWVVWjU5YjU4ZzE0?=
 =?utf-8?B?OGwrUjdoVk9XWERubW9UMmxTY05jTExGelczZ01Vc1NKT1Vpa0c4TmU2MWpO?=
 =?utf-8?B?LzNsWERUMWl1aGRZVmllWlZSSjhBVHVEYXFmeSt6cnoyQm5RVnBSQ21IdU5G?=
 =?utf-8?B?TUtVU3gyK3JVeG9aNnArT08xa0hONFo1MmlKclJXVCtnNWxaT3ZBM0FVcjBr?=
 =?utf-8?B?SUZHREgvRWU4MjMrVUFsSUlQQjJqTkJMNFRPSmJxcU5LK3BjU3J4OHkrZmow?=
 =?utf-8?B?b1hzM01jUk5NTEcvbjlaSUN2UWhHK2kyVllsTUUxOUI5bHhVYTBzcWF3ZmNU?=
 =?utf-8?B?b1hWSmk1eWdaMUpZNzhreEl2dERsZ29VV3JYMm1wTDlRWUsydk1JYU9GMHMw?=
 =?utf-8?B?MEdlcWRhWXAyREcwb0dqN205UlJUWWI4OXVZTEdkWDRHWWxmK25IT1FkMEs5?=
 =?utf-8?B?azk0ajJjZUluV1d0N0RGNFJreEVwbW5GSnYwYTFIYUhjaHMxWFJTcXQwZThw?=
 =?utf-8?B?Zk5FcDMrR1lWVlVmeTF4cFA3dVBQWVFBaDdueTRFb2NwRHdBMFl6NVh3SGV2?=
 =?utf-8?B?M0o2YU5pMUZHRmg4WktWanhlKzU0SFAzeUJhcUs0KzFTS0xnMFN6R1NIM0th?=
 =?utf-8?B?VTZneHlpbzlOdUpURDl6aVUxMDJZbFZZdXQ0VjY0VDVuZXVpYm5XL3JMdTdB?=
 =?utf-8?B?cXVjVXY5NjhXYng3RFIzMWpqcVhrWUlsWGpwQTcxTWI2Z0o5Vmhzc0NYOGhB?=
 =?utf-8?B?TjlLcnREbEFxbmxzMXY4d3VBQVJPRFp2aGVkY0l0SlBVZTlJeDB2WXk5ekdL?=
 =?utf-8?B?SXVXK0dpanJMSWRJVy9vTnU0T2FCaVo1SVBuQ0lOajFkZTNlNVlRMEgyNnBI?=
 =?utf-8?B?anpsUEpacnB3VDI1Y0FpcFJJMUluMnBsZVBFSDMxejhjb0FOUzF6NzV2M09C?=
 =?utf-8?B?eUlteFpKUXFmL1JpSEtzY21aN2dqU096ZzNzKzZpbU4zQkhGd3JzT21oRHZU?=
 =?utf-8?B?aTZ4L1ZDSTdPTTlTL0RZNmRqTEhlaTRJTW92OWdCVUZZY1BGVi9TMngwT2Mv?=
 =?utf-8?B?UEEvT0hTUFlkSzVjeG9RTFhnellqZzBLWWlPa2NwMXlWamRoODNyeEJSYUJ5?=
 =?utf-8?B?V01jKzNPZ3FyUEJFRlAya2MvZnRWY2Zrb2UwYlZ0V3I2dGhWUGRLZ240Y3c1?=
 =?utf-8?B?KytqN0lsL2FvMG95a095WlppdHlQOW02d2lCWlRJa2ZCYU5RUzN0T3YyWWVX?=
 =?utf-8?B?Y29iQlMzMDBCcHZ5ZmkxcWQ3dkkxVGdnc1FDTXlUTTZSL3hmNHl6STlNTGVN?=
 =?utf-8?B?SWxKdnJaSGxmUGJHNGhlSXB1NjlBenZ5RkgxSmZKY0Rzcjh0Z3kyVWFrbmpL?=
 =?utf-8?B?cEppWE5ZSEJCUDBlamRYeU11czlrSXBMMzd5VnBRK1ZEUDYwOU5GRTFXUUFQ?=
 =?utf-8?B?ODlIdmlHczFoVGoxZ3RoQkpMTG5PZGwydXBPZ0F6UHlzRzAwd1Z3RnkySjNB?=
 =?utf-8?B?UlpjVkwxZEhXZ1IwOWNuYnY1S3l3cUFyVkJSYURKc2UzT1Y1YVpiK2tDNVBX?=
 =?utf-8?B?alV3SWhjZ25IeXRxcTRVc3JHQ29sQ0w4dVFjbFNTeFFFdTNGZ2lSYkFSZEJV?=
 =?utf-8?B?NSsyZXhDSzFROTdmaVdHWUpDOVpLQVR2eXA0NUh1YTczc1U4cDc1UEhjZXZO?=
 =?utf-8?B?UHpERkZGbFl3MlVjQ0ZQTjl6dHRESy9EK00rdFpGTTdnaWVkRnBsTXV1cFNa?=
 =?utf-8?B?Z1dFdldDK0tMNUx1OGtEY1M2OENQY01yQ1gzOWI0STFFWlJSN213VnhzUkcy?=
 =?utf-8?B?R3pzb1lIdUlEZzhtYUc3TVVJNVloTXNjUWJRc3RNeklSdi9LQTd4aU1kOVpT?=
 =?utf-8?Q?EG/BxNST3Q6MzHgXUt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e012f159-5d89-4dac-399a-08decd327bbb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 12:09:44.4100 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fiLaPRKfZ6InaraNCRVl97esdccFMea9trcgPOU2iootwoQFaSWl1v9OUqRB8DOp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7482
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

On 6/17/26 21:14, Timur Kristóf wrote:
> This was basically dead code, not used or called from anywhere.
> 
> Now that DC is the default display driver for all ASICs,
> it is unlikely that anyone wants to develop this further.
> Display hang related work should be focused on DC.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 66 --------------------------
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 57 ----------------------
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 57 ----------------------
>  3 files changed, 180 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> index 055ec8196f90..20071c24edd5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -410,36 +410,6 @@ static u32 dce_v10_0_hpd_get_gpio_reg(struct amdgpu_device *adev)
>  	return mmDC_GPIO_HPD_A;
>  }
>  
> -static bool dce_v10_0_is_display_hung(struct amdgpu_device *adev)
> -{
> -	u32 crtc_hung = 0;
> -	u32 crtc_status[6];
> -	u32 i, j, tmp;
> -
> -	for (i = 0; i < adev->mode_info.num_crtc; i++) {
> -		tmp = RREG32(mmCRTC_CONTROL + crtc_offsets[i]);
> -		if (REG_GET_FIELD(tmp, CRTC_CONTROL, CRTC_MASTER_EN)) {
> -			crtc_status[i] = RREG32(mmCRTC_STATUS_HV_COUNT + crtc_offsets[i]);
> -			crtc_hung |= (1 << i);
> -		}
> -	}
> -
> -	for (j = 0; j < 10; j++) {
> -		for (i = 0; i < adev->mode_info.num_crtc; i++) {
> -			if (crtc_hung & (1 << i)) {
> -				tmp = RREG32(mmCRTC_STATUS_HV_COUNT + crtc_offsets[i]);
> -				if (tmp != crtc_status[i])
> -					crtc_hung &= ~(1 << i);
> -			}
> -		}
> -		if (crtc_hung == 0)
> -			return false;
> -		udelay(100);
> -	}
> -
> -	return true;
> -}
> -
>  static void dce_v10_0_set_vga_render_state(struct amdgpu_device *adev,
>  					   bool render)
>  {
> @@ -2956,40 +2926,6 @@ static bool dce_v10_0_is_idle(struct amdgpu_ip_block *ip_block)
>  	return true;
>  }
>  
> -static bool dce_v10_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	struct amdgpu_device *adev = ip_block->adev;
> -
> -	return dce_v10_0_is_display_hung(adev);
> -}
> -
> -static int dce_v10_0_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	u32 srbm_soft_reset = 0, tmp;
> -	struct amdgpu_device *adev = ip_block->adev;
> -
> -	if (dce_v10_0_is_display_hung(adev))
> -		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_DC_MASK;
> -
> -	if (srbm_soft_reset) {
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -		tmp |= srbm_soft_reset;
> -		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
> -		WREG32(mmSRBM_SOFT_RESET, tmp);
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -
> -		udelay(50);
> -
> -		tmp &= ~srbm_soft_reset;
> -		WREG32(mmSRBM_SOFT_RESET, tmp);
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -
> -		/* Wait a little for things to settle down */
> -		udelay(50);
> -	}
> -	return 0;
> -}
> -
>  static void dce_v10_0_set_crtc_vblank_interrupt_state(struct amdgpu_device *adev,
>  						     int crtc,
>  						     enum amdgpu_interrupt_state state)
> @@ -3332,8 +3268,6 @@ static const struct amd_ip_funcs dce_v10_0_ip_funcs = {
>  	.suspend = dce_v10_0_suspend,
>  	.resume = dce_v10_0_resume,
>  	.is_idle = dce_v10_0_is_idle,
> -	.check_soft_reset = dce_v10_0_check_soft_reset,
> -	.soft_reset = dce_v10_0_soft_reset,
>  	.set_clockgating_state = dce_v10_0_set_clockgating_state,
>  	.set_powergating_state = dce_v10_0_set_powergating_state,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> index 0f47044bab5d..0eae0cca39ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -378,35 +378,6 @@ static u32 dce_v6_0_hpd_get_gpio_reg(struct amdgpu_device *adev)
>  	return mmDC_GPIO_HPD_A;
>  }
>  
> -static bool dce_v6_0_is_display_hung(struct amdgpu_device *adev)
> -{
> -	u32 crtc_hung = 0;
> -	u32 crtc_status[6];
> -	u32 i, j, tmp;
> -
> -	for (i = 0; i < adev->mode_info.num_crtc; i++) {
> -		if (RREG32(mmCRTC_CONTROL + crtc_offsets[i]) & CRTC_CONTROL__CRTC_MASTER_EN_MASK) {
> -			crtc_status[i] = RREG32(mmCRTC_STATUS_HV_COUNT + crtc_offsets[i]);
> -			crtc_hung |= (1 << i);
> -		}
> -	}
> -
> -	for (j = 0; j < 10; j++) {
> -		for (i = 0; i < adev->mode_info.num_crtc; i++) {
> -			if (crtc_hung & (1 << i)) {
> -				tmp = RREG32(mmCRTC_STATUS_HV_COUNT + crtc_offsets[i]);
> -				if (tmp != crtc_status[i])
> -					crtc_hung &= ~(1 << i);
> -			}
> -		}
> -		if (crtc_hung == 0)
> -			return false;
> -		udelay(100);
> -	}
> -
> -	return true;
> -}
> -
>  static void dce_v6_0_set_vga_render_state(struct amdgpu_device *adev,
>  					  bool render)
>  {
> @@ -2901,33 +2872,6 @@ static bool dce_v6_0_is_idle(struct amdgpu_ip_block *ip_block)
>  	return true;
>  }
>  
> -static int dce_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	u32 srbm_soft_reset = 0, tmp;
> -	struct amdgpu_device *adev = ip_block->adev;
> -
> -	if (dce_v6_0_is_display_hung(adev))
> -		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_DC_MASK;
> -
> -	if (srbm_soft_reset) {
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -		tmp |= srbm_soft_reset;
> -		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
> -		WREG32(mmSRBM_SOFT_RESET, tmp);
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -
> -		udelay(50);
> -
> -		tmp &= ~srbm_soft_reset;
> -		WREG32(mmSRBM_SOFT_RESET, tmp);
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -
> -		/* Wait a little for things to settle down */
> -		udelay(50);
> -	}
> -	return 0;
> -}
> -
>  static void dce_v6_0_set_crtc_vblank_interrupt_state(struct amdgpu_device *adev,
>  						     int crtc,
>  						     enum amdgpu_interrupt_state state)
> @@ -3224,7 +3168,6 @@ static const struct amd_ip_funcs dce_v6_0_ip_funcs = {
>  	.suspend = dce_v6_0_suspend,
>  	.resume = dce_v6_0_resume,
>  	.is_idle = dce_v6_0_is_idle,
> -	.soft_reset = dce_v6_0_soft_reset,
>  	.set_clockgating_state = dce_v6_0_set_clockgating_state,
>  	.set_powergating_state = dce_v6_0_set_powergating_state,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> index a885e8d47f70..c02b1345d9c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -362,35 +362,6 @@ static u32 dce_v8_0_hpd_get_gpio_reg(struct amdgpu_device *adev)
>  	return mmDC_GPIO_HPD_A;
>  }
>  
> -static bool dce_v8_0_is_display_hung(struct amdgpu_device *adev)
> -{
> -	u32 crtc_hung = 0;
> -	u32 crtc_status[6];
> -	u32 i, j, tmp;
> -
> -	for (i = 0; i < adev->mode_info.num_crtc; i++) {
> -		if (RREG32(mmCRTC_CONTROL + crtc_offsets[i]) & CRTC_CONTROL__CRTC_MASTER_EN_MASK) {
> -			crtc_status[i] = RREG32(mmCRTC_STATUS_HV_COUNT + crtc_offsets[i]);
> -			crtc_hung |= (1 << i);
> -		}
> -	}
> -
> -	for (j = 0; j < 10; j++) {
> -		for (i = 0; i < adev->mode_info.num_crtc; i++) {
> -			if (crtc_hung & (1 << i)) {
> -				tmp = RREG32(mmCRTC_STATUS_HV_COUNT + crtc_offsets[i]);
> -				if (tmp != crtc_status[i])
> -					crtc_hung &= ~(1 << i);
> -			}
> -		}
> -		if (crtc_hung == 0)
> -			return false;
> -		udelay(100);
> -	}
> -
> -	return true;
> -}
> -
>  static void dce_v8_0_set_vga_render_state(struct amdgpu_device *adev,
>  					  bool render)
>  {
> @@ -2873,33 +2844,6 @@ static bool dce_v8_0_is_idle(struct amdgpu_ip_block *ip_block)
>  	return true;
>  }
>  
> -static int dce_v8_0_soft_reset(struct amdgpu_ip_block *ip_block)
> -{
> -	u32 srbm_soft_reset = 0, tmp;
> -	struct amdgpu_device *adev = ip_block->adev;
> -
> -	if (dce_v8_0_is_display_hung(adev))
> -		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_DC_MASK;
> -
> -	if (srbm_soft_reset) {
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -		tmp |= srbm_soft_reset;
> -		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
> -		WREG32(mmSRBM_SOFT_RESET, tmp);
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -
> -		udelay(50);
> -
> -		tmp &= ~srbm_soft_reset;
> -		WREG32(mmSRBM_SOFT_RESET, tmp);
> -		tmp = RREG32(mmSRBM_SOFT_RESET);
> -
> -		/* Wait a little for things to settle down */
> -		udelay(50);
> -	}
> -	return 0;
> -}
> -
>  static void dce_v8_0_set_crtc_vblank_interrupt_state(struct amdgpu_device *adev,
>  						     int crtc,
>  						     enum amdgpu_interrupt_state state)
> @@ -3241,7 +3185,6 @@ static const struct amd_ip_funcs dce_v8_0_ip_funcs = {
>  	.suspend = dce_v8_0_suspend,
>  	.resume = dce_v8_0_resume,
>  	.is_idle = dce_v8_0_is_idle,
> -	.soft_reset = dce_v8_0_soft_reset,
>  	.set_clockgating_state = dce_v8_0_set_clockgating_state,
>  	.set_powergating_state = dce_v8_0_set_powergating_state,
>  };


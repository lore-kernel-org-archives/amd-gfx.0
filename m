Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B44C369A2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 17:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D27D10E251;
	Mon, 14 Apr 2025 17:42:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jFO1IvPB";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE4AB10E251
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 17:42:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZhc6TIm2zIabwEEFkJeHPiKuOqZp3wZFHh0Vyh6hhZfGc1NURYKnkF+2nTBBJts9qx5mDXLhSre2kNbQfer2uMdOscXmctp69Yf5spn4GiOxOP1F1ZkE8kmdVcbFzAwx/wjihhNxKyAKAlrM8o6hlkO4OlpsSD+GnRQSD6Mjt+RUST5Bto0aNWGJk/7sITS6KLc+cxyEAlRMqtdNa0K7k4cc637WemZEbulRw9/9AgSBHM1Yd2M34LZiN9m8Zy9hzVF/CfwmM7j2kq3h1DCVqlGp6xTpYXcB486QLnrk5QdzzUxgl6pWXNvh/OfAHcrzHahVORQFaoaYhbcaiBwnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5/N1Nhpp3SYsWpHLRM4i//XfDoLYPM3muYrqnV+fuE=;
 b=J2T7KoLTMBgwZlc+dFg083RmcmsGc5iVZVwHeR7mbWA4tm5453ze5aUoRCIgGoL4vP10fwp7wpZw8hwyXHQxrBr6muy+mb3KI5FM4VIu1TPGlVzuIPru5vkerkONerIPsR+G9GZQk0OvuGLsI3aoTSgPYsUh8iRj3597uhrqftnQ6j2xt0lDYBKD1v0oY7PJqbZCqjy3tDmmXo1UEqhysxe/9iqt/4aiZ89mjicnRza1Hn4sx0ahC8ZcnslffdY8i2RXvXMILX/u4Ed+0cx/n/lDvMfD+JCRCBgnmKwhWOXf7WPVBqNxrVlXuIRRBYjzRPfd7+kf38Sy5nns1nkq6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5/N1Nhpp3SYsWpHLRM4i//XfDoLYPM3muYrqnV+fuE=;
 b=jFO1IvPBt4xdDaISsq9c9HOzcPr85LR0W8MQqhP+6AoHw4GXysWAV1SJJCPh/9n6K0+y0XI3V5SaXhYIbLa2dT7e84JyD+oJPJ314snFZblmzynaZHTmSzvK1oiGQdU//cJaU2vwxuWCrtXLcgYPzZXSCmCbDbYKZF+RFUAE09I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 17:42:40 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 17:42:40 +0000
Message-ID: <5125c3ef-552b-412d-9cc6-50baab26da8a@amd.com>
Date: Mon, 14 Apr 2025 23:12:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/amdgpu/gfx11: properly reference EOP interrupts
 for userqs
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250413160608.2198429-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20250413160608.2198429-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::6) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c105a87-468c-467a-0b9b-08dd7b7bc086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUtyVjB3QnBjd1h6bTVaZzJ4T3gyQ2UwUzhqQ0psUDllSXhQNGkwZFFpbEtu?=
 =?utf-8?B?MmhKY2NEb2lZZUZxZ3pvTVBGcEo5VEVKTEdVaHV0VWhZVkpraVJBMk1sR1U2?=
 =?utf-8?B?Q1NheS93WnNGblV3WVI1YXFuYmpOSDlRUFlIOTVVamE4TXExMXFkOXp4RzBX?=
 =?utf-8?B?bHA2ZjVWcUVTcTM5S0RSMXlFSU9TQnpwRmFKL1c4RlFnQW45aVhNNXd2TVI1?=
 =?utf-8?B?YzdCK0tnQTRnSVFCYjU0bFpUSDEvZkNvclVsRThXTWVSaXVGc0tBbEN1OEVR?=
 =?utf-8?B?Rk5SZlpWTHZYREp2bnZidG1lV2NNTUhacXFWYlBWUEUxR3N0MStOZmlNNzBi?=
 =?utf-8?B?T2FUaXF1MEwxNDZsMmxMQ1NSZVFWd0JvWEtvUkU5ZDAxeG84RWtVcTU4N1Bm?=
 =?utf-8?B?dGlCY3Q5Nk5FbTlOQXRJbCtiTXBhRmJ4Q3hSSDNlbHBQOU50dUd4VGVyUzlK?=
 =?utf-8?B?YkpPRGcwOWZhVHFNVlo5ZXNkY3YrZklaUjBnN28rK1dmdkg2NjJUODBna0tH?=
 =?utf-8?B?Ly9UZ3pFZE52M2hOQlMwQVlJVWJUSVArc2EzOUtvSjFGUTJnZ3R3VVBqVndv?=
 =?utf-8?B?OUNEbDVaRFl1cEJnb3BGdTVaMit2YlN5NXh6bGVRQVJ1OS9BZXF1LzBGT3li?=
 =?utf-8?B?TlN3SGx4NjFjTHNWRjFwU0tGVmNRRkNyZjhldEZJTjdlYkMwQytqS1BWWklU?=
 =?utf-8?B?aDQyeXFwNGo2RFp5YU9Xa2x3VFBmWllqQ3V4WlduTkcvemE4TXdFbUtvZGIr?=
 =?utf-8?B?V1JibE5Wak5BZnFTdGt5d3pyYmZGZWJETnpqeTJtbkJPVEdkSG81eWxlMUpN?=
 =?utf-8?B?SE9QTEdaV014RGNJOEZ6Zi9OTEJ5U2oxaFpBS1UrNDRKaXY4MU9TbzdabDF2?=
 =?utf-8?B?T0VLQzZwaDdscUxPV0lIRDJyRGxITzQ0WFc5VlZuK2IxR011WUNBMFVDeVdZ?=
 =?utf-8?B?NEliZ0o5VkFsV1dyVzI4TEt2OERjcWFremFrYWVVbEJtM1h4bHBZOWk5VjJu?=
 =?utf-8?B?TnVKR3daMHRlOUxsQVN5VUVLUlgwQWRNbHVCOUdDTnlFNmpFTnd2YUxjWFhY?=
 =?utf-8?B?RHgzc1M0V0NkcGtaeGRlck9wcE05VFJjcnRZNHN2VEJNRGQvV2UwbGYrYUJU?=
 =?utf-8?B?OEh2TUpYQm0vVGthK3puVGlJdVlLaDdKNThJd1VPcmMrZERMSGVuS002OUJ3?=
 =?utf-8?B?QURBeXJ0V1dxY3Nodis4VjdrLy9ZaGNqNVZpTjZjNm5udUcxMUxvazJSdXh2?=
 =?utf-8?B?V1pVVVUreHdvYVVZMzcxdFBDbmtQbXdiQmZNTno2NEZnVXdtWHRybWppOUpN?=
 =?utf-8?B?UUtSYU5yTGl5Y2QycHV1RGU1SkxvUjhEanhUSUl4L2RIUHhqQ2FsQmJYR0tS?=
 =?utf-8?B?TnNUT3lPMlZVUGxGNWtXV1dZeVlKVEJjRXNUUVVMZm8zWEswRk5mVnZYcGx3?=
 =?utf-8?B?ZzMzMTR0U3p0UTBqS2pKM0tFWnVnbGxob1VWUHF6UzBjVENSbmp1Sm5WQmVp?=
 =?utf-8?B?VW9Dck9pdnpYcU5PVTM5bDR4bHpueVN0Y1lxU1cwVnV5eUUvMkJncFpybk54?=
 =?utf-8?B?NUJRR0Q2bzNPMllncW43ak9QRG1ORG9Lb3VZZXQ5cjFGNmZvdnV5dFkreVhu?=
 =?utf-8?B?dWFUZEhMb3c5Y1NBTVlRYlU5Q2ZSOGxqWEJLaWZ5dWpUMEhkU0tRMnQrVFNR?=
 =?utf-8?B?N29wK0t1OThoVEFIZVMwampOa2p2ZzNWdG9vZ2U3TlFmUmJZWk1KK2dEZnZO?=
 =?utf-8?B?eTIyeXVSaCtxZFdXRDhrcm4wcEZOaXUwV0xVQjREcUh2ck5taCtxVkJ1a0wz?=
 =?utf-8?B?NUQwcXpReFZ2L0FaRlAxc2IxenRoR05SczdXS3ZqWlYxNG5KaUFFUE1SV0hu?=
 =?utf-8?B?NHdMU3BYRjA2MDJiSFQzWFNzQjRXVEcyN3pYY0R5R3ZXbGZPTDJwSkxEZ2pI?=
 =?utf-8?Q?t68cEpA3zoc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1RBdFVPdTUzRHdCSDRlQ2QzTVZNQmZwa000SkJtNjhQZHpUNGtnZnlqY0hT?=
 =?utf-8?B?V1NmYzh1Mkp3ek43U1dQQW1TeENLQ1FzZTY0RUU2RFFHdEpQRWFpeUtFZ01M?=
 =?utf-8?B?ZmNyZVkwUHVBMkhDTkhYM1FTOVJnMmxXcHNOYXdEbkhEL2tEL1Fra3dNdnVL?=
 =?utf-8?B?cHpOLzM3NG13eUduajMxUzZmekhleWhCc2VwVVFxK09TNzdLOTBZMVd0YVh6?=
 =?utf-8?B?K0F0c2pFWUVuaFZtL2l3THBOSVhBMnQ2Z1ZQcURzSU9IaUg4Mm5wQStJcnVC?=
 =?utf-8?B?cWJhMDE3WlhPV3NEcnVkRTJhV3cyVkowLy9QTENTL21NVW40Z1VlVmFTUGJ5?=
 =?utf-8?B?SmdyTVJDUC9haHFqOElZMEM3UGhEaVk2QXA4WDVmM1k0KzBJZkJmZGV5djVG?=
 =?utf-8?B?bEVMc3RDV3YwOWdrWjF6S1MyMUQwQ3QwNmREU2VKMnJxWDRjK1Z5czQ3c3ZO?=
 =?utf-8?B?bzNxbnhVNzU5Sk5PNEZ0RzQ3NmliSjN1aXhNeDdMbmpnZTlDMFBjdGFCZGdV?=
 =?utf-8?B?L2ZIZ2V0VzJwQVJ5MU5hbENRdlNlb0N5N1ZiRko0WlpvV0J1VGZXY2k0Y2Vp?=
 =?utf-8?B?ck5uZkRyd1R6Z2RCcGp2V0E1NG82MVZDL3NkY3MvUjJoTFdOZ29RMXFxU2t4?=
 =?utf-8?B?NUU3Q3A1cGprcHN5UFUwWjdJdkEvQVJZaUdBY2J1YVBrNUtRa0dYS3dKSVYv?=
 =?utf-8?B?L0NzSlhqZGd4N1o2N3V5bGY1aTNwQWF5bHcwMEpBN0FBdmxvZmdOSC9DdzdZ?=
 =?utf-8?B?VEo0dFN1RlRGMVF1RmlJQzVnajhWcWU2U29BVHNFTlR5TEh2SUdWR25LQ2Vv?=
 =?utf-8?B?VWZnajgwVmRJbkpLeUJHQnZIK0VsSkYvQytiVkRuTnVZU0I2R2RhL2hyd2hw?=
 =?utf-8?B?MzU3Q1NSK0pBWjJKVEx2WXBPemtVZEtkbytWR3YrTjc3bGtaZGsyeXFrd0VE?=
 =?utf-8?B?ZUtUWU93U0hnQUZZWU9HN1lJaW9VSzE1RVJlUndNRGpLekpyc3pmNndKeEdX?=
 =?utf-8?B?SzhvbHFlaFBHRHVBWXFQSDMwaGM3bVlsQUpmWTlvOFVrd3ZDU3JYZ1RmbVBT?=
 =?utf-8?B?Zk9halNzeVdFTzZTdzRSNmRLVW1BeE43Vjl4bmQ3ZW5DaHIrdy84dm5md1Vk?=
 =?utf-8?B?clNQSHhwK1V4T0tnbUc2RWdtZmtRcHJBUmV0WExTdjlrYXZ4RmV6TFUraG9E?=
 =?utf-8?B?cms0RDBTYS9vekpYQkdHeVlzNVMyNUxHUGlZQkhDMzRtMFVNcWNnRy9BSG1W?=
 =?utf-8?B?QkdLN1JjMmJoR3h3bzd1K004QzhueWk1M0J4SUhodkV0YUVxVmNTYXNPYmox?=
 =?utf-8?B?YjhIOTlodDYzSTVCMXlrQ2ZPMHpOVTl6YjZiRktWYXNyVGhvd3dGYThDQWZi?=
 =?utf-8?B?anA1Zm9jNWVzSVV3MGNZRWJhTjRKTmFxaTh1Z210Nkh0dGh2enRrZlZlaDh5?=
 =?utf-8?B?ZHI4NWZURXp6WEgvU2IrWWl3MWdPV3VrWVNCUXFrWmRvWWpMTGpFZjJ2a0lW?=
 =?utf-8?B?blJBYis0Y0hKY2d1QzdCd01YdHBFdW5xaGdZRDZxRW1PQW9yemkySmRQbitI?=
 =?utf-8?B?ZnVsQW5JdmhRQ25HeUpPaUsyUDh2TWZVaS81N1lNWURNd3l3TlFySm45V3M4?=
 =?utf-8?B?YXE4d24xSHlGaG1IUy9NSnBVYVV1SURWbVBrZGhzSjAzenM4bmpnRkVaSDc0?=
 =?utf-8?B?dGVuOElDTjFLWkdPZ0N5bmJBbjI2OGROVWFHSHFIU0JORlJsV1ZyM3h3b2RU?=
 =?utf-8?B?VEI2WVgwT1R5bDZRNzJsRTdrd0xPZFlsZi9EY2hUaFdia3BEeGIxMlo4aENT?=
 =?utf-8?B?YTN2QWMwbzhVMDN4cm84bFViSGJBNVdNcTlzVWd2LzF4UjZnN29UV0xDWCtP?=
 =?utf-8?B?c01ZczhmWU5CeEtUcWJBaytJcWJkZ1l5NmxyTGZSMldHR2MzMnVRS0pYMTRI?=
 =?utf-8?B?R3RVUnpxMEdPYlJwTDBjVUZuU2VFNER4RFhiVE1vbFZKOXlFQ2ZLUWcwalVn?=
 =?utf-8?B?UWcydnVWdkFmaVJ4RzRuQ0RmWXZUeW14QTBHTmZyZnkydDdLb3ZFb3RHY2Zu?=
 =?utf-8?B?RkVHenBSdm0zUTQrNm5BWU5JZUdTVFowbWhHeGNBVHhKSWZTNVZMUk9iMlhG?=
 =?utf-8?Q?JBXoKueIAYKIYt2RbIL/lSh64?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c105a87-468c-467a-0b9b-08dd7b7bc086
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 17:42:40.1036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZcrlJmFaCug45BIEK9sfPdnjn4us1vspg0UH6UirP1kAiDX/M71+u3vOh0kGTMSfY8AhwrNRIoGftOu0RUlbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896
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

Series is Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

On 4/13/2025 9:36 PM, Alex Deucher wrote:
> Regardless of whether we disable kernel queues, we need
> to take an extra reference to the pipe interrupts for
> user queues to make sure they stay enabled in case we
> disable them for kernel queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 7274334ecd6fa..40d3c05326c02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4836,10 +4836,10 @@ static int gfx_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
>   static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
>   					      bool enable)
>   {
> -	if (adev->gfx.disable_kq) {
> -		unsigned int irq_type;
> -		int m, p, r;
> +	unsigned int irq_type;
> +	int m, p, r;
>   
> +	if (adev->userq_funcs[AMDGPU_HW_IP_GFX]) {
>   		for (m = 0; m < adev->gfx.me.num_me; m++) {
>   			for (p = 0; p < adev->gfx.me.num_pipe_per_me; p++) {
>   				irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
> @@ -4853,7 +4853,9 @@ static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
>   					return r;
>   			}
>   		}
> +	}
>   
> +	if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]) {
>   		for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
>   			for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
>   				irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
> @@ -4870,6 +4872,7 @@ static int gfx_v11_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
>   			}
>   		}
>   	}
> +
>   	return 0;
>   }
>   

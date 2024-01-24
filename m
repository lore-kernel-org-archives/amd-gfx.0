Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F29C47E49
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 17:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C633710F7AA;
	Wed, 24 Jan 2024 17:15:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8B1010F7A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 17:15:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHjomir46rLfJjp8MEdn9PVP2Vhkzs4rPvUXlbXmTKRVk+68rCJluXknDl5JFDPR6P7yssNw2GCoMSuv5A+o5ms1BZmk4v4lOTzfc37/A3N+fRA1pNX6aYguT/XVDKTeAmqjwL/7x4m2wuwlQ9CEYj5KPBYDByXmXWnzFsHWsU3YTJsOV7q/xr7/dwZi2Vgb46KyO3MGyafJXe0rR2yFSLtrh9/gX5stf2Cd6xKcrj7KGYvxoIS5dP94nUQ2pTuaAuiB6qyAzBS6n/pQ+Wk37DtTcgiJJ3i34XEq0kT+h/7/t18iTh18pKRlPmDgWuhf8bwLwkQL6ScWsTzR5x5oMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoXW2ycBzfEC0LhISW9kOW+viVvKXu+LTwAHhKLvYkQ=;
 b=XL6S0lTZfsqBQBiPh2+ZnzGBTAwAvNAzM45MDVjiQtZTzSNDg4uT862OsULbDIck0lGome6L/JNabfPtw4W6JYlYk8XArZUHQ0W3A708ZR4LclNS3efe0TFLz6/pK52sqHSO3RQ75RSfvfArycQ04+e2RH4y3KwypGE2ZajltnUFslUBzIbH33a+2dLgo5kZqHtRlbnFvUubpqjI+0yna/YdBNQ16I9ARAgPu7Q+BJUf+W/zRUUGUu1wUNPjFWS97P7bS5M3nQDEEUSM36xZ5ZhQATuQovz8UTP2esuQBxlBDdH3BwlHRjYKAtKoYX9DUH6maeYAKqVCDWQnP3yD0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoXW2ycBzfEC0LhISW9kOW+viVvKXu+LTwAHhKLvYkQ=;
 b=rf4MTG835A2EoBCAoCJzC8fsuQgurGByUC8jTVwHNzY87ZXbgb3I6BQIhPVlvtgcvrrHaoMqDHHBDOsl8kgiWjRD273ug8w8+Ucp0A1dGF0drIzXOcuYCGxTqQU7KK4wUYEkSoP8gEHeoeXNA+QlSt7bYgd3UvkZWMlkbFOlvr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 17:15:39 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba%4]) with mapi id 15.20.7202.039; Wed, 24 Jan 2024
 17:15:39 +0000
Message-ID: <1b08cda4-d28c-4a64-9b8e-a0c6f5c3487a@amd.com>
Date: Wed, 24 Jan 2024 11:15:38 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amd/display: "Enable IPS by default"
Content-Language: en-US
To: Roman.Li@amd.com, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Aurabindo.Pillai@amd.com, li.ma@amd.com
References: <20240124170906.901841-1-Roman.Li@amd.com>
 <20240124170906.901841-3-Roman.Li@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240124170906.901841-3-Roman.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0032.namprd11.prod.outlook.com
 (2603:10b6:806:d0::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f69e82-4ba8-44c4-2df5-08dc1d00168d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QqZ7s21Zyf+10JlcXEF6zGpXcTrdn5jag4uw1wC7gYaxXIyT5pIUO23BmIzrd2zPBzGaBqHj6BKJDt1KIvCYJ14NamYqJmaifZ2OOV4ZlfPAHzNeskHSwm/yw27fs+zIzEx7gzDjrpNLIYvxHsf5jWH0KcDo6B9uNAeyyIpdoFP12r1U3BIlpG7+Jau/9KSSkF2aAnq6MvOGq3+aRk+/NeGuq9y9ufq0sRaehDjzIOx9vCXTdzX91fF1piUv4lbwIZ9oK/tUYyrDM1Clx4q2GbHKO8miiFizPMIjF8FzjhpxNocM4XQjnzcolxt5BPtrmKBoZd5uzCeRQh3O9LEKsKUxyi9ksa5C9NViqHbhIEU5oLnjlwCf7bf2rehYwDq42dxjOkxlfRaqgS9hfRlh9X2L7cKfCM2jLIzeNWKf06LSryZjYmSY4TSaXkOKcNJxyGOIpD+xpV5GICNQRJ7OERgtEoQsqZvEZDEwO+EmZU3k99vK8uAv+Cw3tvZ5bA9F9ZBgcDnoc89pxKC7jF6cP6e60x4suIiokuoqKJ5QZZEFta9sJcoNPsJGok7uglz4EsBG6LXTTI4FbPLwJjk90Z7k2KeJh/8cUvdV8RSO5vEkFtE6wrMzc76Vg5Rh+DZMgPZMS/qoJTv51qePopkyWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(478600001)(8676002)(53546011)(6512007)(41300700001)(6506007)(36756003)(2616005)(66476007)(66946007)(5660300002)(6636002)(66556008)(316002)(4326008)(2906002)(44832011)(31696002)(38100700002)(86362001)(8936002)(83380400001)(6486002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUpGd0ZTeHY4RVArYmJHK05GK004Q3I1YWVvWnNOdllSS2hGL2NaMnprMTdV?=
 =?utf-8?B?Q1hERFpHQVFKNDg5SXFlbmtGeGNyWHh0bS9MSDYwbHF4OTBNd3M4K2xFRUJw?=
 =?utf-8?B?WWFid0p1RXA4V0d2MnRDQzBpd2diQXpIaDR5cC9ZVlUvaEc0ODc1NG1GNldl?=
 =?utf-8?B?R2x0ODQwNFBKZ0JzYUdsRUJzdmhpc240YllCam1qYXBKbEVUWFRYd2FHSlJI?=
 =?utf-8?B?WCtMMy91SGlHZkNHSHF2MSszNEtZcWxtd1VWcTJUSy9NTmx0bU1Dblh6TmNy?=
 =?utf-8?B?bGNjekUxZTFDWDdkc1NZTWxBZWFQSFRWUjBINE9leHRVU0xHN3RLSWNxNmR5?=
 =?utf-8?B?Z1g0WnZsVHpiSkxZRzNiMmhXQmw1Ym9CUDI2V3ZNSlMxeFFKaXlnRk0zU2sv?=
 =?utf-8?B?Y3BwTXNZS2YvOHN2amhMQkdIaTloUW9pSDhSaWVDb0hTSFR5bjUveUYrbGt6?=
 =?utf-8?B?S2tUamszdlhkUS9ObzFtOGt5bmlpRUtiVXhEbGxwRFhqaSsxU2oxUkRzMWx2?=
 =?utf-8?B?VFB1ZERUbGJlaUErUXhYOFh6RXdPSmxSK0dnSlNFc0dIZjkwRFg1N0xLNzRQ?=
 =?utf-8?B?VldleGNZdFZQWDYrT3JRc0F0TXN3eDJQYi8xWGQzWk9wZnhiQ2FDaHVUdWha?=
 =?utf-8?B?YjZYM3QzbnpydDBBTXBSdlZhVTRpdEt0Q3VJbm9ZRXFtM1VxaE5Gd1l6S0ZB?=
 =?utf-8?B?LzVIM1Z6YjlYNldFUUZvaS9lRGpVMEUvM3BJenFiTTNFbG1nOWpOSG85cS9r?=
 =?utf-8?B?b2h2VjdKbEdIMThqTVVYRVlZTnVTS3Y5SitrZ0gzREUrUUF3ZHhRZ1o1N2lQ?=
 =?utf-8?B?MXdwNVVMU21hTmtNWTFab1RlZGlPR1hXZ0prOTdNUlM5aUZ6K0lQOWxMWG5V?=
 =?utf-8?B?Z2pibFBMV0NBRzI3VmZjUEVYdXBsZnptTDBWeElid2twZW1FK0NISDdXMFhy?=
 =?utf-8?B?dXl1c3VMQ3BLNkZJT1dMV0ZVdGQ4ZDQ5Si9vTVh6ZXE4cUNzVWd0NGRMMUo2?=
 =?utf-8?B?L2VxeTkxSTNYamxOYVY4ckthelFMYUROcTJQQ3E2cVovQzBUSXRNZVRiYk95?=
 =?utf-8?B?dlE0bm9ZYWdVQ09UaEExalVNYVVNWVF0OGQ2RGhBVUNvQlpHb1dWcHphQW1p?=
 =?utf-8?B?UW5wZWVPMEN2V1JlZjVGbEhYV2pjV1dIY1lrOVA0ZzhybkgxaHlJdHYxYUFR?=
 =?utf-8?B?cWRvMHFBeTJtQUx2MnU0dzgvaGlXVXdBN3hORi9DMzBDTXJVS0p2Tk5NSEwx?=
 =?utf-8?B?b2ZJMVJvbmt5U1BqRnlmTERDYUxLYmtjS1ppMlI3MDB6VDZSVy80U2dDWkVi?=
 =?utf-8?B?OFJRSUVhb1dWMHVmelM4bjI5eHFIaTM2aWpkUDNQZldXbFhZMm1UWkdHbHBE?=
 =?utf-8?B?K3c0eFhBc1FDeTdpMlRRL093T29UVk91TXVxcm12bDFDZXRMSThwc1dkMEd2?=
 =?utf-8?B?MHQ2RndYTkFyWi9iTHJML253cmNuamdOTWRYSGd6OS9nWXVkNkd3K2dLdklI?=
 =?utf-8?B?TUtBNFBCUmdmMHlBdEIzSEJ3OEVhLytRQ3lwelRUNFE0TzVZanp5YWwreGNR?=
 =?utf-8?B?YkdKZDFjemttYUhkaW9XUzlVbFEwaHZXZnZnYkR3SHViTjlCY25udldVcjV5?=
 =?utf-8?B?Zkp3QlZ0a1FXaEFScGsxZyt5SkRuekJkb1A4VzY5OFIxL0JhaXZ1VVg5Zml3?=
 =?utf-8?B?VzErZXR5QS9nTlZhMXFPeGoyai9uNU91TnA5aWVqVnlzdVlULzBEWk0rVldC?=
 =?utf-8?B?MUl0T0RmdEE4L28wbkZpWk42UzRKaTJRalRwY0hIQnNUekhzUUEvdy93Qllo?=
 =?utf-8?B?TTJiTnNhRU5nK1AzdytSUktaRXZWdEVxTnBFZUthMkF4WnNJUTRIRGxJZU1R?=
 =?utf-8?B?dHhkcnpVNXFvdGRZbENPWlp2L2ZGSUw0VkV3Z25pMnRHZ1NUdlJDRjNJay9x?=
 =?utf-8?B?ME9vQytVNTEzNVlva2xtTEcrZ05jMXphTmZHVThKQ0lYZWU1cHZaQXFEblNN?=
 =?utf-8?B?R0lVV3h3V1hTUTNERVo5N0dQa1lTWG1XR2cvaTQwZDZJQ25hRjBkdUJhYnlF?=
 =?utf-8?B?MHltQU94NGRBYU5rVEt1YWFHS1piN1A0QUg4aElwQlE3cm5adGllWWpVZGlY?=
 =?utf-8?Q?aHGkxW4v+kruy0rwJrfcuYe1O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f69e82-4ba8-44c4-2df5-08dc1d00168d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 17:15:39.7635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUpQc3fhKxyyUg+YGReB0jCqcyQdDbs0kAVhs64/Ka1u3PbadPAM6elQbexZuI32jmSw+Zr0CKq8Ml3dwlEdXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656
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
Cc: Mark Broadworth <mark.broadworth@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, jerry.zuo@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/24/2024 11:09, Roman.Li@amd.com wrote:
> From: Roman Li <Roman.Li@amd.com>
> 
> [Why]
> IPS was temporary disabled due to instability.
> It was fixed in dmub firmware and with:
> - "drm/amd/display: Add IPS checks before dcn register access"
> - "drm/amd/display: Disable ips before dc interrupt setting"
> 
> [How]
> Enable IPS by default.
> Disable IPS if 0x800 bit set in amdgpu.dcdebugmask module params
> 
> Signed-off-by: Roman Li <Roman.Li@amd.com>
> Tested-by: Mark Broadworth <mark.broadworth@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 41994a60e2cd..9d909c09a14f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1719,7 +1719,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   	init_data.nbio_reg_offsets = adev->reg_offset[NBIO_HWIP][0];
>   	init_data.clk_reg_offsets = adev->reg_offset[CLK_HWIP][0];
>   
> -	init_data.flags.disable_ips = DMUB_IPS_DISABLE_ALL;
> +        if (amdgpu_dc_debug_mask & DC_DISABLE_IPS)
> +		init_data.flags.disable_ips = DMUB_IPS_DISABLE_ALL;
>   
>   	init_data.flags.disable_ips_in_vpb = 1;
>   


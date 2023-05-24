Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD4DC77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 18:06:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3733310E094;
	Wed, 24 May 2023 18:06:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5999510E087
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 18:06:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heXK31LdEmbqtCnJfXjOdqfZRqmBDVKHF1k/4dXR1ODSiruyEr6V9r7mlKd8KCvW6Mn7UB0ymhBMrl22zrO0BC/LzpgnkSLf7YCQMh3Hkbd27wuhEKXwndz2ecgFspndOguCGojowp3LyAd3nnWlbaSagn1kXh0Fiz2CnRON+rGRxc7z5qri1DrIVdIme9eYSxGJPTJ9rlP8caHWzHpfZv9lU2J7t1xblljGaB51mvBsKetlpPl3beahFmUM1t1dLTyTWWounuUtMUt9NENX6dh+RtjOoQrBvTOQwptW9jgsEg/CCFC4Ruh3SlKtqb5xupyAq2NomMLsfow2JxOPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QodC8yHP7f4Z+NgvqR3ch7019a85OufbVputqV4sbdc=;
 b=l0y8pV+JiiA/eR5hA1YuHi2P0MgrOENV77IYEHJijEg0UdYNDhk6Q6RBCHOJJlU/hH9ONpJDsBGL/9c19ttkGx7oCASkYk3JswwxaBZ6tv6hUbJ46TBZcx0swntPriwFl8g4NmsxXmMje4PyPA+ivuztKvfFZ+8r1RIfnRCqFYHR01GRM9AL7+ZWU9lPF7MhAStM4ITx8jN85lvMp1OnKIkw6J7ZYPOW3Pgn27H4CelPBIpIM5BiZ/OJA6IpVuKAgSGtqPCc4t/ltudAE9Ug8/TkdiB486i0DFJUFZ03ozMASW/DpqmO5T2WcXqFXKiPnBVT6jGLN38ClMA8jrLiuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QodC8yHP7f4Z+NgvqR3ch7019a85OufbVputqV4sbdc=;
 b=s+aOguTZdjRS6ri1Z1jcgctfTH2ZzH4Lw8Dye7YP0E5NkyiKky9UHxPmKsHWiAGD+KxeRF/eLAw/gQ2WoTFNvqhaMtSoUvrJRuXsJ9oDKVGLEnJTmb5y5GAuQbcx66EzOEmmX8hitv/OvG0vxIZe2mYZ8m9BjT2AHN9SQnkHi/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by SA3PR12MB9198.namprd12.prod.outlook.com (2603:10b6:806:39f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 18:06:00 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::4666:2db3:db1e:810c]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::4666:2db3:db1e:810c%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 18:05:59 +0000
Message-ID: <1775faa2-1164-f895-eb14-4e7b15e1e60e@amd.com>
Date: Wed, 24 May 2023 14:05:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd: Drop debugfs access to the DPCD
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230524175845.16580-1-mario.limonciello@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20230524175845.16580-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::26) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5427:EE_|SA3PR12MB9198:EE_
X-MS-Office365-Filtering-Correlation-Id: bf5871ee-7042-44bf-ffe5-08db5c81877d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pKy+MjvTVq97cCh/VDAs5Z6BQfOs6psJd75osAK2OV0G8TeNeQhvtgbuKCI5dATXAYrIW3i661Dit8RYM53CBGovZMW4wFc9mh+XOWwDJ+Ol1h+16ZkFdUIH6t05mM3RQs6Hc1juJXBzVd+S7PRnzT/CrxoS6LmAb6e8cgPe898th3ezcbBhq/J8sWLK/LoyWn7nSZySvYQrVYI0etqVnD2/X4Bv12SOneTbEmaLC6lmdN76o3G8Dp8gLE0YTM6Q7IPoiN46tNTg1Lptr3/JEbK/vVYwyIjbCDxbYqng2ia7t5l1oaw0IYImZ5KcBvhyR7N8NceSWCDkziqJhOF2osevH2S9TxbPAzNyrw5E0lYz5crd05MBlRth+PDAgQHlIa+B/X3Bi9wfcp+9DWEZSWtUULCmMrIy4rG6RmZEpZJpko3PwFj9DJ33/h3InoztfbdoOP/3jhPHlJD+WoQphE4TO5XCwg5Ec2IRe7JVafWTZlgtIaIy1fHLd644/KiY+6aQ+GxOab1UU0M8983S4OV87280y+zzNkH+PJS4VPkQEP3aV74OyRx6Fcqdg5DLF5Z66B2ITsWiG/Z1cJP+Y3MZ7sSzXrskdnjf4DVUsuGej8+O+hG4qTxTrZSJZ8M4l+HsImkl00Pz/Tk1qdHtKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199021)(66946007)(66556008)(31686004)(66476007)(478600001)(86362001)(31696002)(6666004)(41300700001)(6486002)(316002)(5660300002)(8676002)(8936002)(44832011)(38100700002)(6506007)(186003)(26005)(53546011)(6512007)(2906002)(36756003)(83380400001)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ay9tVm1FTjlKdnFXaWZ1TVhxNVhicDNzSjZjUnArUWJhWS9IN0FJTHhpNTA3?=
 =?utf-8?B?SHlrRWNwTzJ0am00Z1pyYkxsQS9ZSk9Kb1dsWFh4ZTA3UHVGL2IwWTVER2JN?=
 =?utf-8?B?c2x2djBDRmlGOFV1cGJOYS9Ld1FXdGV0VWprUU8rY0VIQVJ1LzhPTEJLbnhp?=
 =?utf-8?B?ZTFxVTE0NHhYL0FtNDRuWnV3TDRBOGNHVjVyWGhBMFZpUTZsbjBjd2llNUpV?=
 =?utf-8?B?RmJhTEFFdWE3UHd1c1NpeGxsVHY4SVAzcVd1OHovQStoRVM0aEh6SDZqSU1i?=
 =?utf-8?B?MDhFN3E5VTJIQUdsYklFcWpxM3VzLzRzenYvbmhzeFhoTXp1ei9mWUdYcERq?=
 =?utf-8?B?akJjcWI0UDd3emtqUUVXOEJSNmptREx5SGhma0hDODVJdUE5YXNMc3NTSGt0?=
 =?utf-8?B?TTZmRHRtZ2IrazBxMHBIQXJhVE1jaEJONFNxcW1tRUxNOTNhekxNUGlYSGRJ?=
 =?utf-8?B?QkZEeXRzUjRCbTJEekdpSWltZGVZRThSWHZoNmhSclhEN0V6Ni85VWhIcmZZ?=
 =?utf-8?B?NzZDRnVURnNteTVDQ3FPVjU2M1FCZzdINndBQU9WZCtvZXV1RmxWR2F2b1JM?=
 =?utf-8?B?OWY3QzZjMDYveEN0V1N5SzV3NUo2VUZCMGhTcmZEV2NXV0ozWTNUZ05wNklU?=
 =?utf-8?B?UmlDeTI0ZHUrejJHZjRpYWdJMGNzT3prdHdpMldoZDZDQ3Y3MFYxTHVyR0ox?=
 =?utf-8?B?RDcxMy95MkZIZm1xZUdYb3AzR212MVYrUVl0ajlVRWZBZ0oxWitsd05LZ0ZX?=
 =?utf-8?B?ZDQvZW5iZzhXWUpFQk5BZHF0YnRaMUM4dldaSzZoZHB2MWh6Und2aERDcXoz?=
 =?utf-8?B?aVRwaUtXQlRHL1l5T0RUSGV2T0plNWhwMGplQTFoNi93MVdZQ3pCaGRsSEVj?=
 =?utf-8?B?Yit6QkRnb0dPMHdwb2FuU0p5UE9odEtoWmpCOHNQMHlGRHpsM0F4c01xZ3cr?=
 =?utf-8?B?OVMvT1lIWlQyYlVYMmZpcUdSK05nRkhkLzR4NnlUZFlkTWRvenlGRnhwMDhx?=
 =?utf-8?B?dWlFY1g4c3ZCQ2tHWlVBTXE2Y3p1d28xUlZSUEV0L3FQanhRNXdZWVI3clZG?=
 =?utf-8?B?Ly81Z1gyM2lqV3VyVVhaOFV1bWdVd1hSK2VnS3lBc1kyWlFjUGoyV1d1QlY4?=
 =?utf-8?B?aUJmd1VwWjM0dEFtRVI1VlV4YURMV1NjdklrNEF6UWxzbk5sNWFob3c0eXFk?=
 =?utf-8?B?UVhBTXdYbTlDNC9kd01GWjFPSU5RcjhyUE83Qlk3UEM1Tk8wZGgydDhqZGRO?=
 =?utf-8?B?YXlNZGV3d0NYVnk5VXlLWWp3MkYvVEpkUkY5aEtTN1VYUkl1V2IvczJDMGlq?=
 =?utf-8?B?WlU0Sy9pVFRmQlUxS0hyd0p2MkNCSitmdUhncGY2MUl6Vmd0cjNpZTA2dDli?=
 =?utf-8?B?VS93d0xSZkhxWlRmUHJRWlhMWHNVTTlXTHdNR1FZVzcxdEg5SnEyWXRGRVYx?=
 =?utf-8?B?TmlIclp3bUMwNldmOVB1VFRRK3RRNEszTi9PNU5STlI0RC9vT1MyekRqcTRN?=
 =?utf-8?B?T3lBVzRWZlJhcUFMa1B2MnZCVDIyb2lTcjJHVFFuY2UzWWF0UC9sc0l2N2Jq?=
 =?utf-8?B?cHdLbUVRTjhGU0xIbU1UK2p3NEJ1SnJDYm52Zm1nWFV2cVlGRVZzNk1oaHp0?=
 =?utf-8?B?NVFwR3JydXhGV3kxdkhnc1pVaDRFYzFWamJGN1RsT21jWkw1ZkdnZHBnQk5o?=
 =?utf-8?B?RkhtMjdTM2Jud0tGNm4wK3FlY3U5SUtXSmNJalVNSzJUMW94QmEyamNBMldC?=
 =?utf-8?B?OXk4VkJJaCtENlY4d1c2WEN4UVd4L0tlQVVJQnJaeHYweFdZQXYyQStzQk9H?=
 =?utf-8?B?TWc4c3BmYjV2Tm5nNFdHODlSUkZhckMvb1BJVTlFT1NQaGtXZE0wT2F3clp4?=
 =?utf-8?B?WmdiNnZYWktJRm9JellZbGNnd1hZdzlvV3RpZzNYZHJ5d05ZbjdnUHl4UFE5?=
 =?utf-8?B?Yk53RWV5UlFmQXJJUjFYMDlpV251MGFuNHBwb0w0MjZWOU9wU3hMZUROb2xk?=
 =?utf-8?B?QzNZUHBjbFBQOHlJRWJOclk0U2kwRnlBV2FqWm5aZ0NCMmhRNCtsN2xzTFF5?=
 =?utf-8?B?aks5T1d1QkVxMXpFWEFWOXZlL2dxYWF4TnJZQnFDUnM1SWJ1dnB5VDlFL2FD?=
 =?utf-8?Q?+tH3kiNW+mxZLds6anaWFYeKt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5871ee-7042-44bf-ffe5-08db5c81877d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 18:05:59.8752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l03zClyU6h6qTerUVAePTgREJCAmuyvuPnalTNAAhHRxqhVY/9Iw47w8TsPPbXPU324kOBeNp8ajX1t9X4R8KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9198
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



On 5/24/23 13:58, Mario Limonciello wrote:
> There is already access to the DPCD from userspace through
> `CONFIG_DRM_DP_AUX_CHARDEV`, so it's unnecessary to reinvent the wheel
> with a set of extra debugfs nodes specific to amdgpu.
> 
> The character device interface behaves more like you would expect in that
> you can seek/read/write all from the same file.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   4 -
>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 107 ------------------
>  2 files changed, 111 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 2e2413fd73a4..4561f55afa99 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -661,10 +661,6 @@ struct amdgpu_dm_connector {
>  	struct mutex hpd_lock;
>  
>  	bool fake_enable;
> -#ifdef CONFIG_DEBUG_FS
> -	uint32_t debugfs_dpcd_address;
> -	uint32_t debugfs_dpcd_size;
> -#endif
>  	bool force_yuv420_output;
>  	struct dsc_preferred_settings dsc_settings;
>  	union dp_downstream_port_present mst_downstream_port_present;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 827fcb4fb3b3..82234397dd44 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -1039,88 +1039,6 @@ static ssize_t dp_sdp_message_debugfs_write(struct file *f, const char __user *b
>  	return write_size;
>  }
>  
> -static ssize_t dp_dpcd_address_write(struct file *f, const char __user *buf,
> -				 size_t size, loff_t *pos)
> -{
> -	int r;
> -	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
> -
> -	if (size < sizeof(connector->debugfs_dpcd_address))
> -		return -EINVAL;
> -
> -	r = copy_from_user(&connector->debugfs_dpcd_address,
> -			buf, sizeof(connector->debugfs_dpcd_address));
> -
> -	return size - r;
> -}
> -
> -static ssize_t dp_dpcd_size_write(struct file *f, const char __user *buf,
> -				 size_t size, loff_t *pos)
> -{
> -	int r;
> -	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
> -
> -	if (size < sizeof(connector->debugfs_dpcd_size))
> -		return -EINVAL;
> -
> -	r = copy_from_user(&connector->debugfs_dpcd_size,
> -			buf, sizeof(connector->debugfs_dpcd_size));
> -
> -	if (connector->debugfs_dpcd_size > 256)
> -		connector->debugfs_dpcd_size = 0;
> -
> -	return size - r;
> -}
> -
> -static ssize_t dp_dpcd_data_write(struct file *f, const char __user *buf,
> -				 size_t size, loff_t *pos)
> -{
> -	int r;
> -	char *data;
> -	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
> -	struct dc_link *link = connector->dc_link;
> -	uint32_t write_size = connector->debugfs_dpcd_size;
> -
> -	if (!write_size || size < write_size)
> -		return -EINVAL;
> -
> -	data = kzalloc(write_size, GFP_KERNEL);
> -	if (!data)
> -		return 0;
> -
> -	r = copy_from_user(data, buf, write_size);
> -
> -	dm_helpers_dp_write_dpcd(link->ctx, link,
> -			connector->debugfs_dpcd_address, data, write_size - r);
> -	kfree(data);
> -	return write_size - r;
> -}
> -
> -static ssize_t dp_dpcd_data_read(struct file *f, char __user *buf,
> -				 size_t size, loff_t *pos)
> -{
> -	int r;
> -	char *data;
> -	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
> -	struct dc_link *link = connector->dc_link;
> -	uint32_t read_size = connector->debugfs_dpcd_size;
> -
> -	if (!read_size || size < read_size)
> -		return 0;
> -
> -	data = kzalloc(read_size, GFP_KERNEL);
> -	if (!data)
> -		return 0;
> -
> -	dm_helpers_dp_read_dpcd(link->ctx, link,
> -			connector->debugfs_dpcd_address, data, read_size);
> -
> -	r = copy_to_user(buf, data, read_size);
> -
> -	kfree(data);
> -	return read_size - r;
> -}
> -
>  /* function: Read link's DSC & FEC capabilities
>   *
>   *
> @@ -2682,25 +2600,6 @@ static const struct file_operations sdp_message_fops = {
>  	.llseek = default_llseek
>  };
>  
> -static const struct file_operations dp_dpcd_address_debugfs_fops = {
> -	.owner = THIS_MODULE,
> -	.write = dp_dpcd_address_write,
> -	.llseek = default_llseek
> -};
> -
> -static const struct file_operations dp_dpcd_size_debugfs_fops = {
> -	.owner = THIS_MODULE,
> -	.write = dp_dpcd_size_write,
> -	.llseek = default_llseek
> -};
> -
> -static const struct file_operations dp_dpcd_data_debugfs_fops = {
> -	.owner = THIS_MODULE,
> -	.read = dp_dpcd_data_read,
> -	.write = dp_dpcd_data_write,
> -	.llseek = default_llseek
> -};
> -
>  static const struct file_operations dp_max_bpc_debugfs_fops = {
>  	.owner = THIS_MODULE,
>  	.read = dp_max_bpc_read,
> @@ -2724,9 +2623,6 @@ static const struct {
>  		{"test_pattern", &dp_phy_test_pattern_fops},
>  		{"hdcp_sink_capability", &hdcp_sink_capability_fops},
>  		{"sdp_message", &sdp_message_fops},
> -		{"aux_dpcd_address", &dp_dpcd_address_debugfs_fops},
> -		{"aux_dpcd_size", &dp_dpcd_size_debugfs_fops},
> -		{"aux_dpcd_data", &dp_dpcd_data_debugfs_fops},
>  		{"dsc_clock_en", &dp_dsc_clock_en_debugfs_fops},
>  		{"dsc_slice_width", &dp_dsc_slice_width_debugfs_fops},
>  		{"dsc_slice_height", &dp_dsc_slice_height_debugfs_fops},
> @@ -3025,9 +2921,6 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
>  				    connector_debugfs_entries[i].fops);
>  	}
>  
> -	connector->debugfs_dpcd_address = 0;
> -	connector->debugfs_dpcd_size = 0;
> -
>  	if (connector->base.connector_type == DRM_MODE_CONNECTOR_HDMIA) {
>  		for (i = 0; i < ARRAY_SIZE(hdmi_debugfs_entries); i++) {
>  			debugfs_create_file(hdmi_debugfs_entries[i].name,


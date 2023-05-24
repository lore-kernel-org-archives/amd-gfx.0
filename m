Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7119DC77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 18:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ADA310E040;
	Wed, 24 May 2023 18:05:27 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FFAF10E040
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 18:05:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZ9jmVhW9MiAMsUF4MoX5NoKnfxrkwgz031oaS4CGXEQBBJvqjWxWZj+BObIDodTzX3xMAJS8+FKmbqOG7V8RyYbVcPrxE2RWkYosL5pKCRtV9yZhJf7Dfzpy+mgqQx+/kmZR7SJ27G/dwYy2C6lgIwlTX7TfZSU7eKGzLSzSRdCY3dHQtLnH75EHSeqFZypg24XEpOEltbw4E2Iwj4pREfIG4bbk/ZbZexSMXVj48cKiXEfwDSRNR2Lt8TW1p0X9boB2ZTURN6LQ8wv9cuZhGOB+UIBCcx5pII769zO6LGQaQ7DzmYvFN56L4BVUL2tFDvLasxdoltTjz98hJe70w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGwrMLfr7yEQhnU5zItikJOd5aXRmxeZdeOrFolz90Q=;
 b=UX+9V1WgqsrO8TvFWK/Qv4ZPzaepXuDp3XOyrxAEbVJd0TZoDkTW7Ua+wnA+rszMt6RsBsoL1ZshWFu8q7XkcedtkFktTzseE704tP2TWNCBg2BtgnqIo3UIhka6Wz785AqasZJqKFJEiCiDQ0fhg4p4iEMp+6TTC9WVHTIPup2gV5AGZSZsSbomB5mf7GpLy5Qs9zRGjD8twkLJShTbjIY1xXoskMLCLNykRN1POwNvAiCdpjAW+Ce/IuTY/E5EDlyzyoKdOJKI++fNSZ0W4/d3Qg3995DQzehfPCOvhirjAorXCj0kkehPsNDhFg+nH+sMBhQvrH5FPQNG4b4bLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGwrMLfr7yEQhnU5zItikJOd5aXRmxeZdeOrFolz90Q=;
 b=Sunr5yQPCDuZnb22G5+p1oLHTFG9yvKNKuGQAr6xdyzJ80YfJFz9XyaCsuAhoCZ3zMBJ1v0WbAAkbXkK7rPNMBcPSV80NFBxTOr26z46Q0PyInV8yKNp6QAyH5BU+sWLw/3f8ay18BgjFtAIoGH1GgtuS049a94iMdLRjBFjLwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 PH7PR12MB5808.namprd12.prod.outlook.com (2603:10b6:510:1d4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 18:05:21 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 18:05:21 +0000
Message-ID: <9e1af9ba-1928-e3a7-aa18-2364df3af97d@amd.com>
Date: Wed, 24 May 2023 14:05:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd: Drop debugfs access to the DPCD
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230524175845.16580-1-mario.limonciello@amd.com>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230524175845.16580-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::25)
 To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|PH7PR12MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: c70817ed-b9c2-4a0a-7f97-08db5c81705b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFlJRPuKztKTSU3EjLkNX1GBJA/5mABHOorIQxS9Kcz5WjSboMyQ256/5eGs8ZcSyWk3vDgyAQwN9Q3du2Qt7tECGzV3UAsEzAS/1PV7Q5pwuhWwGU3dTNO5KKjgrSI9nuh553veprU0FCgZCVC8PG+S7hEm3nKH6LSRHCwap/Ijsl2wrABS81piS49TB+OAhb+3XKFWMePwsBqGfaic9dms90RmRP+E37J6w8QGOT0Ebmte7i5cotdo2tYV0iu4czx49px8eJt+vZbZq4X9ldrIplmZloKmhGm6fpW5ld34QDEVstLV+URHKuSugrkXraAYn2yBwpNh5XImyhlwlT+UVImDsOF9hdhhDrNSvZbPrNSsnfxBvVJWhYmtf2s3UmE+9tRLuVg1J7tNohqdm8U9BnOMxEJ62q9nawTmt1WN/lLxkMCo7Rb6FqmYa33E/3zVkrMTFvjJjZJQOlMgONTA9RmDAm1dSG3FQciBnQTksI/vmvoPKF1AEVOH6AoaH3xja+DBPZiHWnr+qFE34KCxfHwir1j++8CawQZ6/m+5ygwrZfB3r79LdkDi1VBRI9XZWwHvTr6zCTCrrl2QT2OHKqdzNifLUGGgMnKbYm8WrOETtM1F3m4Npz+PwVJM1ovzBKDLzdHK5vJwU+EuPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199021)(26005)(53546011)(38100700002)(6512007)(186003)(6506007)(44832011)(2616005)(36756003)(2906002)(83380400001)(41300700001)(6486002)(316002)(6666004)(31686004)(31696002)(478600001)(66556008)(66946007)(66476007)(86362001)(8936002)(5660300002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0NiSE5wMFNKd0Yxd0M0bitKSnpEdHI5b3QrWmpZWko0cHRoOGxIMGJCTmky?=
 =?utf-8?B?ZGkrL084bWwwWEJUQXpmWjgwMEZ2TS9QU1pMZjlGYnZtNHpNbXdTem1tQW5C?=
 =?utf-8?B?Y0ZEZXFUL01WRklqNEl6bGdmOTJuY1R1TnJCejJ0MFdzQWl3MnJiRkh6bXRO?=
 =?utf-8?B?dklPTExxRHFTVzZ3UmU5VkluMTBqT0hDdWZZMFFqSVpzRWZNUk5YZWs3STkr?=
 =?utf-8?B?d1dMOEpvYkxKYXZYVHBkd1VpWEd6MEdSOG01Umg4MjNWNWVENjQ0WElLRjBV?=
 =?utf-8?B?TGdGREpQdnZKcDBiR0FXTCsvcEpEcCtoSmo0Y0ZTSnZYa2p5UXpjYlNLMWJo?=
 =?utf-8?B?KzMzU1krK0M1TThmNnQxTDNVeTYxTDJiYTVLOWpvOENsS09nQ1NpdVAxallH?=
 =?utf-8?B?N2lKWG9wSEY3SWUzWG9GQXgxd2RmdDBRNGNTUVNTVSsrcTg3NHpXb1lLNS9T?=
 =?utf-8?B?T2lwTy9jRDFhRWcxMzZHMWZJcERkb1Z1eDQ3T28xUGZMeVYrUFU5MERKNkdI?=
 =?utf-8?B?NUpFbFgyZ2hKekx6d0hWSkxwRnF6YUZmaTYyeG9LTHlEY29rS3lsaUo0Wmg5?=
 =?utf-8?B?ZlljMlZiQlJqTjNOK0oyWTBCdktYbmFlM1UzQmRBUWthSy80QmZDYnFQaGRV?=
 =?utf-8?B?RFhaOGZLZ0psOXU3T2ZGZEtvZDBQd2JqL3B5dnl2TXBPU0l0S1lISC90L3hJ?=
 =?utf-8?B?aGIwNERsMnQwamhWY1ZoYVN1QjdQaSswUlpiUjhMMVdURGhuTThiVEEzMlY2?=
 =?utf-8?B?cUk5aERQRklDdGx4OXZnOHJSNFZBRmZLVjFFV3lTL3lQSi9Xc2FQc0F2dnJG?=
 =?utf-8?B?QXhaTURWcjdEU0xOT2ZGY2NpN29VeGpWTXA4UG1BeTlURFdXRmFtalhaY1Nt?=
 =?utf-8?B?ajdkTjRneFZibjBPVEZKWkRiTjFPVzdOaXIzWi9SWXNBdStNZTFpSlVDTXYv?=
 =?utf-8?B?U3lrRDEzeWtSb3lsRHZadXpUMlFTdzg4aDJzazY5N1FaMFBZSUZDTWVzak5M?=
 =?utf-8?B?SG1ySVhKQWFWbHFaWnFxaG5UcHhabTdtZ3RkZDkydkRYdjB4YTRpZisvdlR2?=
 =?utf-8?B?TjkxWFZ1TDBzQXYyUXk0cExEdjNhYUJZZS9QQnduUkVVM3J5bDlZdER1TTYr?=
 =?utf-8?B?V3FuWGJzNk5aK1JmZWZhR09RYmpFaTI4dU5Pb3FENEhzTFRLNTUybGJ4MEJ5?=
 =?utf-8?B?ZU81dXI1a2pYUDB1d2FMUzd5NlVhcFJFdDRuNlJtUERNQzdyZmtJWXF1RnFp?=
 =?utf-8?B?R2F4d1ltY1YybVlyb0hZZFlVbU93NXZZaE8wNGJaSElkTFRDaTVVdXhxOVVO?=
 =?utf-8?B?eVdSdXArTlF0c3VpY21LSTFLOXc1SXVhN2ZocXpsMUV3UEpQS01TM1kzbVpT?=
 =?utf-8?B?S29PZXJOY2U1UkpUdHlIZVJ5QWFsNVFaMGM0dWlNV1FsUDRRenF2bERaYVBj?=
 =?utf-8?B?Nkw4ZzFYT0xUTmFpOWtJMjBNMWJ2V1YvcXZERWJIVUR3WG1qa2xKWkI1SjVW?=
 =?utf-8?B?aytuZDFOd0xYNVVnOS9IdVdNNTI0VUFrUUtpYW51ZnF1YlhUL2ZocTU1d2lW?=
 =?utf-8?B?WmNUVWRWVFZFUzQ3di9PMk1zejNpb3hrdHcrWFNqWVZqV1o0UkwrQjQyQTJ2?=
 =?utf-8?B?TXNtNHB3TC85KzE3TktINU5DNDNyM2N0bW1NbHdBbXRJUElHWk9pK0dTR2ZH?=
 =?utf-8?B?YVNjMDNsT0J1a0ZpS095Q1h4VDlaWm1CdDVxSE9scDFFcHFka3FzK1NMZ1Nz?=
 =?utf-8?B?ckVURGNYb3gvSWI1cnlFSWRjak1XTHdGVzN1MGRzR1YybXNXSlBxYSthZTNh?=
 =?utf-8?B?YXowSTFZZWQvWVA2YlRsbXBURzExNjJuajdFM1NOcUVrdE9TdklDYVhwUGoz?=
 =?utf-8?B?c0dNcVRVUnYwRGpBV0RZdGdsaHlJdXM4cXpjNUgxR1JVVkloTjdHM2QvaHUz?=
 =?utf-8?B?M3l4eTFaeDRaSk10M1VJUE9BQUkvZmVEUVY0WFBLbUs4K3JwbjY4Y0dkWGJj?=
 =?utf-8?B?ZjhxS0pJRHc5T2NRbjh0amJocnEwSkQzZldNNEF3MUl6RitaNUJ1a0xwUk42?=
 =?utf-8?B?R1JGVjMwbjl1RlMxeitJcEkzbkJRMlVLRjJpQlhyRTlrQ1Q4OFVKTC9sWHN2?=
 =?utf-8?Q?wgczBKfaO3aB8tBANyu/z3CUm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70817ed-b9c2-4a0a-7f97-08db5c81705b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 18:05:21.0558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4GN7LfjNQD8dPbKNworywzJyO3IkHrWW11PEziXXgX9MIOdVEsRmiW3j7Uhvf3rdC9GC7y4RnconxNLZsIv+jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5808
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

Reviewed-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   4 -
>   .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 107 ------------------
>   2 files changed, 111 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 2e2413fd73a4..4561f55afa99 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -661,10 +661,6 @@ struct amdgpu_dm_connector {
>   	struct mutex hpd_lock;
>   
>   	bool fake_enable;
> -#ifdef CONFIG_DEBUG_FS
> -	uint32_t debugfs_dpcd_address;
> -	uint32_t debugfs_dpcd_size;
> -#endif
>   	bool force_yuv420_output;
>   	struct dsc_preferred_settings dsc_settings;
>   	union dp_downstream_port_present mst_downstream_port_present;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 827fcb4fb3b3..82234397dd44 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -1039,88 +1039,6 @@ static ssize_t dp_sdp_message_debugfs_write(struct file *f, const char __user *b
>   	return write_size;
>   }
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
>   /* function: Read link's DSC & FEC capabilities
>    *
>    *
> @@ -2682,25 +2600,6 @@ static const struct file_operations sdp_message_fops = {
>   	.llseek = default_llseek
>   };
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
>   static const struct file_operations dp_max_bpc_debugfs_fops = {
>   	.owner = THIS_MODULE,
>   	.read = dp_max_bpc_read,
> @@ -2724,9 +2623,6 @@ static const struct {
>   		{"test_pattern", &dp_phy_test_pattern_fops},
>   		{"hdcp_sink_capability", &hdcp_sink_capability_fops},
>   		{"sdp_message", &sdp_message_fops},
> -		{"aux_dpcd_address", &dp_dpcd_address_debugfs_fops},
> -		{"aux_dpcd_size", &dp_dpcd_size_debugfs_fops},
> -		{"aux_dpcd_data", &dp_dpcd_data_debugfs_fops},
>   		{"dsc_clock_en", &dp_dsc_clock_en_debugfs_fops},
>   		{"dsc_slice_width", &dp_dsc_slice_width_debugfs_fops},
>   		{"dsc_slice_height", &dp_dsc_slice_height_debugfs_fops},
> @@ -3025,9 +2921,6 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
>   				    connector_debugfs_entries[i].fops);
>   	}
>   
> -	connector->debugfs_dpcd_address = 0;
> -	connector->debugfs_dpcd_size = 0;
> -
>   	if (connector->base.connector_type == DRM_MODE_CONNECTOR_HDMIA) {
>   		for (i = 0; i < ARRAY_SIZE(hdmi_debugfs_entries); i++) {
>   			debugfs_create_file(hdmi_debugfs_entries[i].name,
-- 
Hamza


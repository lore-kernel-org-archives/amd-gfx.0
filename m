Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ACCDC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 05:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C32576E4FF;
	Wed,  1 Dec 2021 05:14:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78C126E4FF
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 05:14:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Csi1RoFcngB3eBZ/q+8G9oFpeRZozpqtGRtHcwznVVqVZRudu848qh/ZRdfdCtxMM1gLeJbG54Md5REwgHaoYs/EkB4BzTVrWtagSkX8TGB8G8KDIXH33Z57H1GSU5ijvd1X/XTMCJAV8iZXT7ztoqdUJMTePWZe9CcePmEz9dk6p4hY6wcDF5Gu/1M1smu65PTk7KRWFt+HprUYr695QLbXWFs0yu7P0r9asJCIcOYp/TWMuiPvRSXt75Q4fBKkTIvmQZ23y+CryL6pq3hkzOXYxbuPqEaQ9Y/pKxrx9HQvYH21y1TIyAMl33JdUL15MFiykjO0ZznpKHBsj4zieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLY7fbfXdbqTibax32egzqEaxjPzEXdVyADOcEqBIX8=;
 b=FCWppne2a/lZCj0tE0qNnt3xv7SaKnF1ebgaEM2U3BRzopxL02oYpqMaqJ3lR34VPav26bW1WsDdL82c2Z5vrsJCvK4H+fLov15RKCuf/7hQMXhwb+giuFtyr1jox2KIb/bozbAQeTpW+p15prINmofPXdMOnWL9JZU9438iPJJK9OnTpM5SsINdt2VdxoKkDhJyRghU2Gjq481yWo4k3dx7kZrbCC9Ol6Is1rSyWYmIOzVY6b//2DiVChB05LVHLnoyBiyWmjApsTw5/c7xWQcPXZi2rSST14EpOzlEQNttF2S5BtspAWcsRtGdc7eMxI5RON1tDu5P11Ff2FK6bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLY7fbfXdbqTibax32egzqEaxjPzEXdVyADOcEqBIX8=;
 b=Lu91K+VXY1yn7Ul5QyJhiHYohAFsvHq0WyzB82BE/XD/Z34si0BnBUasCzskbPqPjOEk+EpmBpo0vGd7WGGGVbBAFGr6GbaIaNXfDJiG/zBWLNGTrgv6ocCDPhj1UqikLoFVCzKsMpEY09zP3tHuVWJiuemImrS7SddNviDv6Oc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB2859.namprd12.prod.outlook.com (2603:10b6:5:15d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Wed, 1 Dec
 2021 05:14:35 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::41ea:d7dc:f041:633c%5]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 05:14:35 +0000
Message-ID: <53f6a9da-9197-3cfd-3d9c-586dbad4584c@amd.com>
Date: Wed, 1 Dec 2021 10:44:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] drm/amdgpu: add SMU debug option support
Content-Language: en-US
To: Lang Yu <lang.yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211130051721.3192979-1-lang.yu@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211130051721.3192979-1-lang.yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::15) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 PN3PR01CA0103.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11 via Frontend Transport; Wed, 1 Dec 2021 05:14:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7054085-372b-487e-a83b-08d9b48976e9
X-MS-TrafficTypeDiagnostic: DM6PR12MB2859:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28597A486BD58F0789DA8FD497689@DM6PR12MB2859.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8lAQ46sY+XAPnNm0OpGcVuPeV0vlA1DY+tKtvWXnRhJvCyV5C1BZsf3sWdOyYRtM045VQMkdySpbYaNp6uZYwvRfpwyU2aYL+4ZoBRbdFuQriqnPuUHFvzJBhWS76gosAMF85aDG4Fg9sUtwDI10lxAbV5uicfB78vZNWk3WKrbxs33cP3yJiONcjJUfSjTPFprkoqLXKNI7qWPVQyS2sk3D1N3mDmaBTwO7C2Nkd4S9yYJ1G2Tp2YQW0OOlyCc75NqqAj2Z2SXrKFpLKgdhlHUSAXIcqOnFvhyBGBVCHpX4Nve7tHD9Mn9oWrkLcud9osiWLrB75G6avSlvULkXjR8LTspSqidFMqObRHEtYO0jsHJy0D7l/qxD35cBr3bXnbtAKwIGbrymu3SplHfzSpjMXLqNGkJkn7LZvJw/jg5ex+GrQlfsfXERNfwD44OyjZlgspFxok8n9EJ5oeJImIXEBvfAaX/3tHPNM9fgVbQFnxZJr6XoMh5/ASbAmACkjz5pWTykZH1bBe7qo8vs5KHLIcbS1ojoaxA2Et++WI6075jLvNTOMaN1r+4VyLb6ONzr2l4Yhae1mta+gtvBC9ydupzhv+7t8XkcRiSL5Nos/FUsxgT7rXpkfXr0MSx+4gremUZFWhwY5dOaP2A140lsN5ELgBAes3b29DN2MYZVB+jVzeB9uCbSSeGIyiTXE+M8wn23vZpG1XIsYQ7s51WMZKGve78rC4aUc68t2WpHB9eMSJhLXMdsekanQHpu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(6486002)(36756003)(8676002)(31696002)(83380400001)(53546011)(508600001)(66556008)(8936002)(31686004)(956004)(6666004)(2616005)(2906002)(16576012)(26005)(5660300002)(38100700002)(186003)(316002)(54906003)(66946007)(66476007)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWhrdks3SzNPWUhKUjBkcG9rdEg1RlVDT2RvdVBjYmd1RXI2amp6KzJsc0RH?=
 =?utf-8?B?bm42RVFZQWhaNnE1NDBidktxOU1pY3Q1RTEvNmNGV3ZQc1JPY3pnU2lmNklh?=
 =?utf-8?B?bTNWOVlFYUQwdWw5RzZBU01Kd25wOHhhUk9lUWNGcGdtQWY2U3dCZFFxazBY?=
 =?utf-8?B?SGVsYVA1NDhJMG5USHk0WUJIQ1YwRXRSZEdxZzkxNGx3bmlLeUo3RXRFcURs?=
 =?utf-8?B?cVRsYWIvd29JK3NoaDk2dlBGVmEvQVgzZ0M3N1BHT1JueURrNC8rc0Z3ZDBU?=
 =?utf-8?B?QVViemJEUENmYk4wQmtCclN5WUhYMDYyTUR1OVhjenpoNGhTV0lsQVkyV2dJ?=
 =?utf-8?B?dndjWi9nV243aFZXdzJvRXBiUnY1bXBzdVZBdFh3aU9WRzNYK1RtUkJWM1Bk?=
 =?utf-8?B?U0pzOXFYYlBkRUNMblRlcVgzQm5ZbytENHFhc2Rhd1kySDh2d2trV21JdlFT?=
 =?utf-8?B?ZllWdHNYMTN4Rk4rdWNwU0djZEl1MWdoVEI3Wm90SHZaY1JoUlczYis2M3ky?=
 =?utf-8?B?c01rcFNyakFPbGRVKzhtUEoxK3hnd0dOVmk1bUNta01DdUpDc1NyOFowSStU?=
 =?utf-8?B?alJnL0JqOFZQRkplM3FhbUZXY1daT1VSQ21GSERsQzBISXBvUnBFRmVMemtI?=
 =?utf-8?B?MDUxa0kxVlRQSnRkbm5wd3NOd0VZYnl3d3l1N3JlTkJ3eXdBUzQvMlI4Zk9w?=
 =?utf-8?B?d3dKcUc4SllpcTdGOHJ5Z1BySDA3bUs3YjV3c2hYNGhiYTVkNC80a2VvTDRh?=
 =?utf-8?B?djRoTmg1RDdNKzhsT0t3MktBTG02UzUwL1VDNUVpSitQU2hKM092OGpYd1Bt?=
 =?utf-8?B?dDE0eGx3ZzY5dnhEbHA5R1NScjVtMm8xMERYcXlCMk0rTk9yTERaUTYySitj?=
 =?utf-8?B?TXRmSWd4VTR1VVc1dHpvN1dHUGJGWWdJRjFWL3RDRDlObjRkNlRDaDJlVmNR?=
 =?utf-8?B?VG1Db1RaWUZFUWJaK1JJK0VaeE5Xdy9tdm83ckFLU3ZCZVBNWUJlVHNqRDFs?=
 =?utf-8?B?djZOaER4VEc0SzRPZkRhKzVjZDJJbWpsYjVFb3h0UFdTa0JoTE5RcjR0dDhx?=
 =?utf-8?B?enZEQXJMWkhqdlhzb2ZZRkhkQUFwc2FpczNPTFRzT2pGdlpHU21UVEQyaEsw?=
 =?utf-8?B?L1BHcDgxTUpIUzVSWGpDU3N5YU1NdWxKV2ZoTHpxLzU2QllXaUdlVDU0b2l4?=
 =?utf-8?B?U09FaHhOYUpHOHo5OXg5RklUajBKeEpya0hMZEI2aEY2N1Y1NTVFcmlRY3pT?=
 =?utf-8?B?NndmakFzOTdrZWdiV1NZRmdXRUNOeXl4VFE5SUxPeitLMERYaisvWFd4UWNW?=
 =?utf-8?B?U2hHMDYzcHhkaStmOGpUOEsrYTZoelcvdzEyVmo0T1FZM2FyakRHS0FzSDVw?=
 =?utf-8?B?VkpkWkpFUkhtWFNVWXZYbisySE53NTdPSVp0SnRMaU1vK0tpQ0t2Vi96UkFK?=
 =?utf-8?B?U2JWM3VOeG82bEl1ZEhaL2hxOGp1YnkvbmcxZEUxQ3BwZGpCOVhsYmo4dUR4?=
 =?utf-8?B?R2JwZHIzc1NyYk9DSTY3VWRndHpIMENlTW9GNHdQN3c5Y1I2Slg4RW5tcnJu?=
 =?utf-8?B?Y2t2djdYemlWUUE2emgyYlRhOHV2TEJULy9WaVJxc01LdlV5NFhBOW5rWDVV?=
 =?utf-8?B?anl3U2RoN0V4SW9TcCtrY1dyaGtIOG90Q290SjRTdlJtMEdvYUtFYzNtb3BX?=
 =?utf-8?B?a2hEK3Q0THc5dnJXSy95b0dzM0dKOXJHdHFpRXJodHFFRmZhVTYzbFR5Vk53?=
 =?utf-8?B?dXEzUW94QXd5ejIzeFc0TVk0cVJTdGZLYnhveVJLd3Y2UjhlKy91V0VneStw?=
 =?utf-8?B?T3liWGduU0JVN05pODFrYVhZb3JzRDI2YnRPK0VWRk15NDJCNFhOMStRUTBm?=
 =?utf-8?B?aUhCRkpDanZRanZrZEd2MXlzVnFDZ25mSXdkUFNXWlhTblJGMDhXOFpWK3dD?=
 =?utf-8?B?eW9nUUQwc0lGbHRFZWZ2RzFjQmk2UHNSdkxES3pwa0Rod0pRbGxYN3F4KzlJ?=
 =?utf-8?B?SEtsSnB0eWlXOUdvck8zdS8rd0lxV1RzNUVpa20vNkRMZ3drK0xqRHZqd1RJ?=
 =?utf-8?B?U2FoMmlhYlhzWDRpd1E1RlF1b1ByNUhYOFpTRzVjaVRWQ0RVeU01Uk1QVmM3?=
 =?utf-8?Q?BKUA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7054085-372b-487e-a83b-08d9b48976e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 05:14:35.5025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iu4dKLj/ngWu4m2EUadnBv9oEjp2UfveemJqutsdtGeW3BKw/8TE5hTLoWPSxLjD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2859
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/30/2021 10:47 AM, Lang Yu wrote:
> To maintain system error state when SMU errors occurred,
> which will aid in debugging SMU firmware issues,
> add SMU debug option support.
> 
> It can be enabled or disabled via amdgpu_smu_debug
> debugfs file. When enabled, it makes SMU errors fatal.
> It is disabled by default.
> 
> == Command Guide ==
> 
> 1, enable SMU debug option
> 
>   # echo 1 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
> 
> 2, disable SMU debug option
> 
>   # echo 0 > /sys/kernel/debug/dri/0/amdgpu_smu_debug
> 
> v2:
>   - Resend command when timeout.(Lijo)
>   - Use debugfs file instead of module parameter.
> 
> Signed-off-by: Lang Yu <lang.yu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 32 +++++++++++++++++
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c      | 39 +++++++++++++++++++--
>   2 files changed, 69 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 164d6a9e9fbb..f9412de86599 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -39,6 +39,8 @@
>   
>   #if defined(CONFIG_DEBUG_FS)
>   
> +extern int amdgpu_smu_debug;
> +
>   /**
>    * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
>    *
> @@ -1152,6 +1154,8 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
>   	return result;
>   }
>   
> +
> +
>   static const struct file_operations amdgpu_debugfs_regs2_fops = {
>   	.owner = THIS_MODULE,
>   	.unlocked_ioctl = amdgpu_debugfs_regs2_ioctl,
> @@ -1609,6 +1613,26 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
>   DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
>   			amdgpu_debugfs_sclk_set, "%llu\n");
>   
> +static int amdgpu_debugfs_smu_debug_get(void *data, u64 *val)
> +{
> +	*val = amdgpu_smu_debug;
> +	return 0;
> +}
> +
> +static int amdgpu_debugfs_smu_debug_set(void *data, u64 val)
> +{
> +	if (val != 0 && val != 1)
> +		return -EINVAL;
> +
> +	amdgpu_smu_debug = val;
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_smu_debug,
> +			 amdgpu_debugfs_smu_debug_get,
> +			 amdgpu_debugfs_smu_debug_set,
> +			 "%llu\n");
> +
>   int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   {
>   	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
> @@ -1632,6 +1656,14 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>   		return PTR_ERR(ent);
>   	}
>   
> +	ent = debugfs_create_file("amdgpu_smu_debug", 0600, root, adev,
> +				  &fops_smu_debug);
> +	if (IS_ERR(ent)) {
> +		DRM_ERROR("unable to create amdgpu_smu_debug debugsfs file\n");
> +		return PTR_ERR(ent);
> +	}
> +
> +
>   	/* Register debugfs entries for amdgpu_ttm */
>   	amdgpu_ttm_debugfs_init(adev);
>   	amdgpu_debugfs_pm_init(adev);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 048ca1673863..b3969d7933d3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -55,6 +55,14 @@
>   
>   #undef __SMU_DUMMY_MAP
>   #define __SMU_DUMMY_MAP(type)	#type
> +
> +/*
> + * Used to enable SMU debug option. When enabled, it makes SMU errors fatal.
> + * This will aid in debugging SMU firmware issues.
> + * (0 = disabled (default), 1 = enabled)
> + */
> +int amdgpu_smu_debug;
> +
>   static const char * const __smu_message_names[] = {
>   	SMU_MESSAGE_TYPES
>   };
> @@ -272,6 +280,11 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>   	__smu_cmn_send_msg(smu, msg_index, param);
>   	res = 0;
>   Out:
> +	if (unlikely(amdgpu_smu_debug == 1) && res) {
> +		mutex_unlock(&smu->message_lock);
> +		BUG();
> +	}
> +
>   	return res;
>   }
>   
> @@ -288,9 +301,17 @@ int smu_cmn_send_msg_without_waiting(struct smu_context *smu,
>   int smu_cmn_wait_for_response(struct smu_context *smu)
>   {
>   	u32 reg;
> +	int res;
>   
>   	reg = __smu_cmn_poll_stat(smu);
> -	return __smu_cmn_reg2errno(smu, reg);
> +	res = __smu_cmn_reg2errno(smu, reg);
> +
> +	if (unlikely(amdgpu_smu_debug == 1) && res) {
> +		mutex_unlock(&smu->message_lock);
> +		BUG();
> +	}
> +
> +	return res;
>   }
>   
>   /**
> @@ -328,6 +349,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>   				    uint32_t param,
>   				    uint32_t *read_arg)
>   {
> +	int retry_count = 0;
>   	int res, index;
>   	u32 reg;
>   
> @@ -349,15 +371,28 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
>   		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
>   		goto Out;
>   	}
> +retry:
>   	__smu_cmn_send_msg(smu, (uint16_t) index, param);
>   	reg = __smu_cmn_poll_stat(smu);
>   	res = __smu_cmn_reg2errno(smu, reg);
> -	if (res != 0)
> +	if (res != 0) {
>   		__smu_cmn_reg_print_error(smu, reg, index, param, msg);
> +		if ((res == -ETIME) && (retry_count++ < 1)) {
> +			usleep_range(500, 1000);
> +			dev_err(smu->adev->dev,
> +				"SMU: resend command: index:%d param:0x%08X message:%s",
> +				index, param, smu_get_message_name(smu, msg));
> +			goto retry;
> +		}
> +		goto Out;
> +	}

Sorry, what I meant is to have an extended wait time in debug mode. 
Something like below, not a 'full retry' as in sending the message again.


+#define MAX_DBG_WAIT_CNT 3
+
  /**
   * __smu_cmn_poll_stat -- poll for a status from the SMU
   * smu: a pointer to SMU context
@@ -115,17 +117,24 @@ static void smu_cmn_read_arg(struct smu_context *smu,
  static u32 __smu_cmn_poll_stat(struct smu_context *smu)
  {
         struct amdgpu_device *adev = smu->adev;
-       int timeout = adev->usec_timeout * 20;
+       int timeout;
         u32 reg;
+       int extended_wait = smu_debug_mode ? MAX_DBG_WAIT_CNT : 0;

-       for ( ; timeout > 0; timeout--) {
-               reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
-               if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
-                       break;
+       do {
+               timeout = adev->usec_timeout * 20;
+               for (; timeout > 0; timeout--) {
+                       reg = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_90);
+                       if ((reg & MP1_C2PMSG_90__CONTENT_MASK) != 0)
+                               break;

-               udelay(1);
-       }
+                       udelay(1);
+               }
+       } while (extended_wait-- >= 0);

+       if (extended_wait != MAX_DBG_WAIT_CNT && reg != SMU_RESP_NONE)
+               dev_err(adev->dev,
+                       "SMU: Unexpected extended wait for response");
         return reg;
  }

Thanks,
Lijo

>   	if (read_arg)
>   		smu_cmn_read_arg(smu, read_arg);
>   Out:
>   	mutex_unlock(&smu->message_lock);
> +
> +	BUG_ON(unlikely(amdgpu_smu_debug == 1) && res);
> +
>   	return res;
>   }
>   
> 

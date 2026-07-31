Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29432C55174
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 20:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A61FF10E238;
	Fri, 31 Jul 2026 20:14:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VTlEhqQ+";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010012.outbound.protection.outlook.com
 [40.93.198.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CEEA10E238
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 20:14:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=metGJ6szRUZwHkzolAl72ukbsPs6+op4jNHEKSNwy1We+LCYQvQmQRPUjnCSZTVOubIsm57XA4hVP09q8aOuWhMGtXWky5feEQwer00VqNL0c4Ra/nUgcPdQ0g0fpWazGNxLdcRPtSeUZKrtF3bt3iC05f3uycWGcEG+s9n5BnMUpJMEktTGOzdDbBv81043NumPOMeM8R5TSrHz/HsXmVlx7DTTZnoRUwKPBHXai6ekChQnXRpTR+Q6fL4Y9XsiatHYk9Iwc5AR1oPneRHmG3/8MzFzncJmKtfRp7sLm64UC7NDRlDSjXHneVsBTHjCZUqe5FPhXApDxwyB3UJFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dlnZkU2jI2VFID4UQl2w7bRTVtS/q5JzjK4bq1Gpec=;
 b=qJ/XuVqjE/tZ2Kkl6UZOtca4m+wmXrw/DQbBNDAROvTogfWOD/H47LhEn42tiNtaO1oUJo/+r/ZyvUx2HeYqt3b0NPzfsLZJFiTCqrZnBZ/cgvBNthOTJCssygFSrTvmB8IbqFsZsbJv/qQ3TUkXl300o/htxHovW3ZkgP1YSj+EcEBUn2LDdsNkXHet3m4lwlTPeaWuIK83oglGO4bVS9CNIf1ypWtoAy5InhGjrOuOGcISWG8zuKs6IOSfGikP/3aiE+FeOkdEAveHC7zfCyEYbCs4lE+bceJC6hiPNef5VNPt8nX/MnBx+QlOd53JmFw294KyhsUEig4Rv6o1Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dlnZkU2jI2VFID4UQl2w7bRTVtS/q5JzjK4bq1Gpec=;
 b=VTlEhqQ+in1ESnmYc3gdJQQ78/YhTVtYD6ZRs68a3rt5cnxDNgAVIpZ03Uuw9jZg7umUqi33dhFmRcHZQs8WD2/e68eAdwVNmq03V0+wkJRtdIiKIiCn4OzSwKk93vXVZxNcTMMLR48nHwHxf5YCVSfiLNyBJfZ0BIeovPDzLu4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 20:14:52 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 20:14:52 +0000
Message-ID: <fe4e0dba-e1c4-4e9e-bf56-3a2f83129659@amd.com>
Date: Fri, 31 Jul 2026 16:14:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Simplify hdmi_automation debugfs with
 debugfs_create_bool
To: Fangzhi Zuo <jerry.zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 nicolas.frattaroli@collabora.com, krzk@kernel.org
References: <20260730184103.916125-1-jerry.zuo@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260730184103.916125-1-jerry.zuo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::25) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|CH2PR12MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9c9525-b2a5-4db3-2305-08deef40610f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 00kLZsSSGc8fR4s7tuyKDso2QTDzwJXcNsH+taQd7ljyue6ae9H5hSnriCWOY6YEVO2CPJadZCBURNoBmhk9/v/pxrymDleQrBeoomZexv7kwBDPpLUoSUpr2LBHMcgO/LwN5wQDopZgKHMbL/sc9NVPl3YVQz3jI8U+wKDP7sRv0HUdYTH4alnLYAH6s1YT9xhpQ2PZq13HpPwYrYdzCRaM8VcqXYlBuI9uqI2hy03slXpCaxOHRCyEmQhj72cV/GWAbu44hAmTUZWCk1rnE6hl3eYEU0g23ijFl5S6yYVvAGjTPRdgWzhqtZQ19d7wn6z3L0ucuSUe3AXiFc2te38h7lxz0s7QBqod1HBpChOsc1V82pHcLr3NYzhcLyXMKM/thZtVMlYAFCilOfy7u59/Zj69VY6/90xZbzfspE1RWaMO8bTGTaTXxOGRYmSjJF2p4g8HVq5jLn3gEXyjYHSSDUH1sp3vN3puxQGStcpeQ/U+hoTw5WhVqu9MbX1WWcdPDvWRqyD6VCK+cLrAFR06+AOzXeDA5NI1LifpLU0jHP7BCq0QiTw0FMLNUNdY4PLMd0QEXYVyB4XgMA+AtEmOAdYi18AD+osgyCmn2FyYvDT45cDGMxZidF/lasrC3T2VIF/XECc32bXQGdXaIOPe0JSSvjYJ9x8jz+/uZs8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHd5SkhrMnRBZnc0STZIdUVKckpmQS9EYy82Y3h3eXdUREFteXhyNWdTWkJ0?=
 =?utf-8?B?ZkQ4SWFhMHhQbE9TL1RyWnMyZzVnOFZ4Nmx6QWhCZG16OGJzWENsbTcvdExR?=
 =?utf-8?B?Wm1jSi9BdDFNMC8xdmFlUWpQcVYvU0NtZWhKaGJmdmIyNkt4RjI5aTBJS2dl?=
 =?utf-8?B?eFpOdWo1Zzh1cktyTEVpRVM4VVNER3JtRFZnYmovRnRQeURhZ1NLbHNEdUI1?=
 =?utf-8?B?VStlTzJuNXZhY0lOZjFPdnp5VTlNeUo5YXN6WjNzWEcraENFMnU4MXBoZkRy?=
 =?utf-8?B?c2ZOTngyQVNDUlRHcmVzSVN0ZW9wOG85TkpuSjFKS29KY3JlNjFicHh4N2pt?=
 =?utf-8?B?WXpIbkU5akhlV3IvNkZUZjRGak91MTVoTnBoVlBGdUJBN2FHaTQ2UEpZSW8x?=
 =?utf-8?B?UTB0bG5hNG5yNk5qRXV0VzRKYkxndlN3RWprSUZadDJOaFo3cCszaDNmNVFs?=
 =?utf-8?B?Rm8wN2tXaW1USDFDTUFuUEVxbmdSZERYWlA2d1FMRlFER1lmOWFlUkxScFBt?=
 =?utf-8?B?NUxTdHhMdkpMNUR3aXc2NTAwem82ZndJcnpaRWVLWXlHM1JkN2ZyalJXalF3?=
 =?utf-8?B?TW5DZlhUdk1ZSjBwTVJMVkl5MExKOWE2S3ZXV1Z0MWJmNG5QVHQ3b2h6U2xM?=
 =?utf-8?B?THV2Q2YwU1VVN3grSjVmWjVaQjlEc1d6bXlia3JuN1h5NkNzbDV5ME8zby94?=
 =?utf-8?B?d2RyRDRkeS9UZFZZZ2dWZGljaklBSUxCUzd5K2MxbXdSVjhqamNOaHhVdGFx?=
 =?utf-8?B?eGVvQnlOM3JWc2tUUlQ5ZnZoQzFoL2xsSTlXOEJnRkZBUWsvZnVEVXFvYmJr?=
 =?utf-8?B?OUxPNkN0emtwSCtQNXJxRjc3UHNyYTNNMWhhQVJLLzQ4Rlpsekp4VmQ4NWJM?=
 =?utf-8?B?WVhrR2ZXU2tncWZxT2ZVekRBM1JhVCtnZktxOWpmWWJUK1FaT09rQldsTjJW?=
 =?utf-8?B?V2hZL0Q1U1Ivd3FjWG1aQXFOUFVUUXg4bEtDckRGWHVIMzgva2ZvREVEbnlZ?=
 =?utf-8?B?L1hURzFEZHVPMlRIVGVJTE5TQzYvT2duSXpwdm1GYmZhSnZwaUZPbG1FaHli?=
 =?utf-8?B?K3JCVXpaNHNaaDlHSjhsdjNtTHJKOEpjc1BtakE1OUlyaFpzaTkzNXV4YURN?=
 =?utf-8?B?aXRoUUx6TStWTk5xbnpXMklwdDZVVGVnSnI2WXA5a2xiVzdnOGJXYlhpZnhM?=
 =?utf-8?B?ajV5aVpHNk0vS3BVVHE0cDduWHVWSExwMVgxdVRGSldDWkNOYS8wZWRKbEF4?=
 =?utf-8?B?djl6a3ozNnh1amNsN25JOGVZVFg1bExTa2hpRXduWVJvbXhOaWRYRGIyY1p5?=
 =?utf-8?B?ci9WNUl6WEM0YUxMbVdlOEttMUtNVFFibXBEUXBQaFdodStFb1ZnVndFVm91?=
 =?utf-8?B?TGd0L3NZUDhkcFNNbmhxb3BleVkvanhFWWVSK0lWTnVvbENybzM3aGhyUGMx?=
 =?utf-8?B?bFAvbFVpZFVneEE0WTRFTEQxbGduYWlxNUFaQldPa1JMalBNTmtqV0VQd2o5?=
 =?utf-8?B?TFhXdUl0VGhKYjZUS2dNUkFCMXJSV2xocTZpbEhxdFhPOHBiL1pGK2N1ZjNM?=
 =?utf-8?B?SjVmWk1TUXZJRUs3UFN0YVFJMHRxcFN0bW5ZVDZQNlZDR0lCc04vMUlkY3ht?=
 =?utf-8?B?YlVhYmZyV0dEWk1mVGwrU3B5dkQrQy9iQTFZRFd1YnhjWDhGWGsySVpIRGFw?=
 =?utf-8?B?VW00c0ttd2hZQUNGT0hBZUNxcjFjRlBYUHZObjBYQzM4OHFNR2ZCQ2liM1hk?=
 =?utf-8?B?K1ZHeHd5WTBsUjUvYzljUVRTZkRXNnhXaXI1S2RIcVRuSjd0Q2VQcmFNLzZ5?=
 =?utf-8?B?K2gzdmRLUVBQbGhGMml2azZpWkJvZlROZ0ZsVDZvYTUrTDMzYWZtU01YaVNk?=
 =?utf-8?B?TEp3SG5KeHNQLzc2VkNTSCtremx5NERUcEFmU1NBUVFQTGZXTmlETUFZYkNu?=
 =?utf-8?B?eDJ6VFVMM1BsaENVaGREN2MyOWQ3NU1ldk9jQWVZVCs3STdaRkd2TXMrbTdw?=
 =?utf-8?B?Ym1SWGNtRStoNWpwZTQvZzhaZ0lLcGIvbFZ3Z1RINXA4TXJ5N0FVNkUyNWJP?=
 =?utf-8?B?Q1pCaVdxYkY5ZFNaUEh2U2pSdHlnMC9KSzdkS2EycVVLTWx6OFhnZlVOeGo3?=
 =?utf-8?B?VDY0a2J1OEtCTCswWFZoajFmUkpaaGtCUlJsRHNvNHd1N1FhVGRUUFNmZW9B?=
 =?utf-8?B?bWhWV0FsZGdiQldaTEFVS0RSSnhrTDJHWEptZEtvOEtlMElickwzTXhDRmdW?=
 =?utf-8?B?SGw2VzhyTWdNcE51MXE4KzdubGJNMjRyLzhIVWR3b05UNjBvWFNPYnpGa0ty?=
 =?utf-8?B?OXpUVHBGb09sRVovQWhWUlArOEc4aUtPUlZsZHA0N3pHYmJ1SjJNUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9c9525-b2a5-4db3-2305-08deef40610f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 20:14:52.0979 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJyTHhuvJ/lgtuPNQ2q5Wr0wJrkOLzZOQOCSWuOU76L2DZ01CuT6cVnnwBiXajje1ZRSF0STTIeyImqHX5LP0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261
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



On 2026-07-30 14:41, Fangzhi Zuo wrote:
> Follow-up fix for commit 442b2e9dc9e9 ("drm/amd/display: Add Support for
> HDMI Compliance Automation"), whose hdmi_automation debugfs entry
> hand-rolled the boolean parsing (scratch buffer,
> parse_write_buffer_into_params(), a switch and kfree) that the debugfs
> core already provides.
> 
> hdmi_comp_auto is a plain bool, so bind it directly with
> debugfs_create_bool() and drop the custom write handler, its
> file_operations and the hdmi_debugfs_entries[] row.
> 
> Fixes: 442b2e9dc9e9 ("drm/amd/display: Add Support for HDMI Compliance Automation")
> Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 69 +------------------
>  1 file changed, 3 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 830cf8da06b4..45249bebe9fb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -2981,64 +2981,6 @@ static ssize_t hdmi_cec_state_write(struct file *f, const char __user *buf,
>  	return size;
>  }
>  
> -/**
> - * hdmi_automation_enable - Enable/Disable HDMI automation feature
> - * @f: file structure.
> - * @buf: userspace buffer. set to '1' to enable; '0' to disable automation feature.
> - * @size: size of buffer from userpsace.
> - * @pos: unused.
> - *
> - * Return size on success, error code on failure
> - */
> -static ssize_t hdmi_automation_enable(struct file *f, const char __user *buf,
> -	size_t size, loff_t *pos)
> -{
> -	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
> -	char *wr_buf = NULL;
> -	const uint32_t wr_buf_size = 40;
> -	int max_param_num = 1;
> -	uint8_t param_nums = 0;
> -	long param[2];
> -	bool hdmi_comp_auto;
> -
> -	if (size == 0)
> -		return -EINVAL;
> -
> -	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
> -	if (!wr_buf)
> -		return -ENOSPC;
> -
> -	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> -					   (long *)param, buf,
> -					   max_param_num,
> -					   &param_nums)) {
> -		kfree(wr_buf);
> -		return -EINVAL;
> -	}
> -
> -	if (param_nums <= 0) {
> -		kfree(wr_buf);
> -		DRM_DEBUG_DRIVER("user data not be read\n");
> -		return -EINVAL;
> -	}
> -
> -	switch (param[0]) {
> -	case 0:
> -		hdmi_comp_auto = false;
> -		break;
> -	case 1:
> -	default:
> -		hdmi_comp_auto = true;
> -		break;
> -	}
> -
> -	/* Persist setting across sink re-detection/hotplug. */
> -	aconnector->hdmi_comp_auto = hdmi_comp_auto;
> -
> -	kfree(wr_buf);
> -	return size;
> -}
> -
>  DEFINE_SHOW_ATTRIBUTE(dp_dsc_fec_support);
>  DEFINE_SHOW_ATTRIBUTE(dmub_fw_state);
>  DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
> @@ -3156,12 +3098,6 @@ static const struct file_operations dp_mst_link_settings_debugfs_fops = {
>  	.llseek = default_llseek
>  };
>  
> -static const struct file_operations hdmi_automation_debugfs_fops = {
> -	.owner = THIS_MODULE,
> -	.write = hdmi_automation_enable,
> -	.llseek = default_llseek
> -};
> -
>  static const struct {
>  	char *name;
>  	const struct file_operations *fops;
> @@ -3194,8 +3130,7 @@ static const struct {
>  	const struct file_operations *fops;
>  } hdmi_debugfs_entries[] = {
>  		{"hdcp_sink_capability", &hdcp_sink_capability_fops},
> -		{"hdmi_cec_state", &hdmi_cec_state_fops},
> -		{"hdmi_automation", &hdmi_automation_debugfs_fops}
> +		{"hdmi_cec_state", &hdmi_cec_state_fops}
>  };
>  
>  /*
> @@ -3908,6 +3843,8 @@ void connector_debugfs_init(struct amdgpu_dm_connector *connector)
>  					    0644, dir, connector,
>  					    hdmi_debugfs_entries[i].fops);
>  		}
> +
> +		debugfs_create_bool("hdmi_automation", 0644, dir, &connector->hdmi_comp_auto);
>  	}
>  }
>  


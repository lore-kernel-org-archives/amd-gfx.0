Return-Path: <SRS0=nko/=C3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A872C43464
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 15:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6CE12084C
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 15:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1aNFfgLH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CE12084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A3746E029;
	Fri, 18 Sep 2020 15:41:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15A166E029
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 15:41:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlnVwr7/hWNjHKp6RE9PuRnP5QQUi5ZYlrhxUT16cdo18E3IdF36ZSYOudAM5kJ/hdIO8FT+kMecsXbbCesZ2F1NJ8dbCtNLOGtH1I+nPsOlgXkRH9u5/9vO9zM1ChvnewkBlU8C4GxFBKywts6E93/EXI85WmRnDF6bOmJBe/k/76Rb81DLVNJ1Hx6oBbRM3CfBFd4foK86wpc/bMEFPR/F/I2eaYLy5CzymawNqkJizw8SaWbuWzw2/jM0vAC+GHc7sR1/oCrvGZZWDRWBxG2kIf1/lH0QgLyqymxwmO5ocKUm/bXw6tdNgwQbtIS5cGy/rDIQx204wWsLRpHvfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5E9phP/PRk/6KBAWspFloJFzdVH9PRsQD9/GClmgr4=;
 b=HsS62JrzDxuWnOfT1359OpV64dQn9Srr2WFfgp67XeWFe1Y56mRMAnWTUriW7XklENK4hL/pGwKPxnCtOIz5wyNPrmfoFD7FrQMtNsOpM3FW9DBLjkvnsIpQBL8+qPGJxVosFkapq0Kl3mAYtSD6w6Hxmh1v+3zdw/hQWGMDCdbsyJRtAivCIZvyYx1m5QJ2hiOzb+xaSSW1uNJ6pQQETz41iCrWqv5Y29xwbejz0UOs1S+vtpRZLiEMaxdILAgdEMWt5RyB/0EW6em6O1NSGooELlLllFCSybiiiJbyFocva09YG3bOa5aIpepDP4qaQ97HwqGGrBT/ktsER284ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5E9phP/PRk/6KBAWspFloJFzdVH9PRsQD9/GClmgr4=;
 b=1aNFfgLHk6YwxHsKIpJVUAKKqx15tEjT307XF4gZmxCWlBUh0KUbz3kSE0VJFghLfiM2kqdih197pFkOD9o/Q22zFTJOuMaAFdIWZ8Nh++sX+oUPQ2aV4Uq5OzE2eHRm+qmB2c0xGR/HUEj2cJYugpH7gN/czXPc6cmwW/71prk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 18 Sep
 2020 15:41:36 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::5dc0:bafc:6040:a8fe]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::5dc0:bafc:6040:a8fe%2]) with mapi id 15.20.3370.019; Fri, 18 Sep 2020
 15:41:36 +0000
Subject: Re: [PATCH] drm/amd/display: fix crash/reboot while accessing sysfs
 files
To: Shirish S <shirish.s@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20200917085418.64517-1-shirish.s@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <f8869c01-c073-ceec-cf0e-eea6eb7fd108@amd.com>
Date: Fri, 18 Sep 2020 11:41:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200917085418.64517-1-shirish.s@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::46) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.29.235.206] (165.204.55.250) by
 YTBPR01CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Fri, 18 Sep 2020 15:41:35 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 04ffe21c-5109-4e34-664b-08d85be95353
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB455361D81642ED4C3D51F0B28C3F0@MW3PR12MB4553.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cklnb2X5lmzYe0QQGyzql505vVHXx791Dt9jipwkEc68IkfCa/ZXrKdnH6iaJneBG+khj7AgP9LAgL1f8y1NZAOFcuvFWwDPHYnvlm/yD5cAemklb4JIcBma2yAuRBJZH31Sb2VxDcA2OdL5oDPcQx5RugvqSeZRArhUxvaumwu7cdNzjFDvymM3tc9QRpvPYthL+XBns3CNm94GCzMzJJQo/2EUwodgBVuXBMP44hKdmKZn6WHpTVNg+kTq1vaeBXcKdSMV1BsxLul2cWLOL3n+trjEz6fh0rTbdSU/kEwQm01YnOFy+p/sYfKlS1ErWoiDyoaNmQxed4X23CnXkSfKve294m10TcW7zFaL3G6t44OQw3O37agYnTEmnenSl7pFScdxf1aFq7AJye9arseZDYaT0nEkj5pBrhb9Y9L++/W8lf9obFi3pA1OEnFt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(36756003)(110136005)(2906002)(186003)(52116002)(26005)(6636002)(8676002)(16526019)(44832011)(31696002)(31686004)(956004)(86362001)(2616005)(4326008)(53546011)(5660300002)(478600001)(83380400001)(6486002)(66476007)(66946007)(316002)(8936002)(66556008)(16576012)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: u4LOBk8QIMN1JpKLHe+3OJcFI0cqv2+jhrEqWA3TVDNOCuNLQxFHwWCCDtUcoHLD4WWjXygv7NH/ROFrtuNScAOEBEdzOBAy1INNTQl4L2CXiSX/DRlbcmdY4Zrg2EX7jRFEkQkQpjAHZmn0maQMI1qcj2FJaxA1w6ijijc8coMAHKV/BdvAmPkUEYjrAGAGMCKm086uk+jKZ1kUH75yrJXvIZVgZAURKH2PZyWHTKqqez44zh3aUD0e1kMdmn27019k1xR5J/rfooV282dP9anV8CFhmU0tNomnfrwILjN0K8Rm043kxp/MtlFNAF1PbdK1JHnqIFpsL5cfbXhUQ1bzZw1GOjRNpvpW4eOeWYor1+BqrUg96wWbFp0gZ+MCSXf8gwKVg4o7Df6Pa/9Ol4xU2Q31wHrDk016tgK8ZFkVQNsasaxttgUE5NmDxaJNdfvj1c8DudHq9x5p0GgfVm60Op21wdsQtrBwjy8q62809KIXAITYpNri27sHrHfvGA5Db41t89MRewTn4shMsQPeheKBcS7RI45UkXokyjIIGXF8bViV6zpEiumBShPF34TKGaVfvYWW4SdGOc1gtdHM2wxdp5pL8vzUf1424pvjtAlO3S0jQ0ncF5s00CzUkTU3CP72XzbrTLY7r6gQPg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ffe21c-5109-4e34-664b-08d85be95353
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 15:41:35.8712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8TQ11Z/8x4qQmANGfdHF3hoHSsYpB9qXz+uUs7IaTyPGzyvXKnjgsdwxgVx/r8re7PvNBj6++a/4flCHmD2tUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4553
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
Cc: amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-09-17 4:54 a.m., Shirish S wrote:
> read/writes to aux_dpcd_* sysfs entries leads to system
> reboot or hang.
> Hence fix the handling of input data and reporting of errors
> appropriately to the user space.
> 
> Signed-off-by: Shirish S <shirish.s@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 004cd8d38214..8cd646eef096 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -908,7 +908,7 @@ static ssize_t dp_dpcd_address_write(struct file *f, const char __user *buf,
>   	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
>   
>   	if (size < sizeof(connector->debugfs_dpcd_address))
> -		return 0;
> +		return -EINVAL;
>   
>   	r = copy_from_user(&connector->debugfs_dpcd_address,
>   			buf, sizeof(connector->debugfs_dpcd_address));
> @@ -923,7 +923,7 @@ static ssize_t dp_dpcd_size_write(struct file *f, const char __user *buf,
>   	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
>   
>   	if (size < sizeof(connector->debugfs_dpcd_size))
> -		return 0;
> +		return -EINVAL;
>   
>   	r = copy_from_user(&connector->debugfs_dpcd_size,
>   			buf, sizeof(connector->debugfs_dpcd_size));
> @@ -943,8 +943,8 @@ static ssize_t dp_dpcd_data_write(struct file *f, const char __user *buf,
>   	struct dc_link *link = connector->dc_link;
>   	uint32_t write_size = connector->debugfs_dpcd_size;
>   
> -	if (size < write_size)
> -		return 0;
> +	if (!write_size || size < write_size)
> +		return -EINVAL;
>   
>   	data = kzalloc(write_size, GFP_KERNEL);
>   	if (!data)
> @@ -967,7 +967,7 @@ static ssize_t dp_dpcd_data_read(struct file *f, char __user *buf,
>   	struct dc_link *link = connector->dc_link;
>   	uint32_t read_size = connector->debugfs_dpcd_size;
>   
> -	if (size < read_size)
> +	if (!read_size || size < read_size)
>   		return 0;
>   
>   	data = kzalloc(read_size, GFP_KERNEL);
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

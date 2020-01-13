Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD30C33CA9
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 16:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BBFC2080D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 16:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gRkVJJvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BBFC2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED8D08928B;
	Mon, 13 Jan 2020 16:20:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FF9A8928B
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 16:20:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hl0n+lWVk1WBlmVybtm1Vx4eiF1RYh4Bgmsh8+WLYOSeW4PHQ9CtoUxIaDHSBcRaf+PbogvrxEtE8WXHA/w97mIVwE2d++L4wwWpdFLwGfXE2Os8hEzcwRrPrG/tYmwxh6bp0fAsnzSK8ja3uyOOrfvGkn5nSh+47FubXpGLl7rQI/d7ekQTWLrkewYHXJxYoTNoqOxs3pmj1RTtuYdEQSzEX889kGOd+WtOVl279XVfJeEtIDyBgMGibONSS3wCCKIcIHQq1mbSFkJ71lkU4qffYTPBhI+9on5T5jbE7N8e3Gbu8NoOyJIizIFfqyS7uZ9kLFv84FUQjS11pnKdbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5HHiZcmawYNFydPt/6q71dg5Tw+ucs3O3XUYyu1Epk=;
 b=mWFgiptNp/YC7VJ46GT7eXOA6vWhuzpDxsRe4MxzD3Eg1v9+9TRCtS9at3t0242/Y5y+x0RdoyHD5CtBOIeAKQ9hWKR5sf8CfZ5NoDjd+xPFsfkSRAg1Y1t2g2CcWlY5qOOKP5Guj+U7/uS8wHwya1mTsJKpuslpEoCKbvwYumVrIf9CVS4v8D3tkEm+nDsg6Lr6eFo72OSrZFHcP47Q9nCS1LnxkZ4O+AIefxOkB+22vhlkWjVh/rsl91MYpOAr4UTUAXPZu/1tyIy5c5UVxdZ8Nutj+NPP8TTIQro0i1c7KRuIjk1GZbLZwAqEEK8rP65Fu8h8blmsyNeZqulOPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5HHiZcmawYNFydPt/6q71dg5Tw+ucs3O3XUYyu1Epk=;
 b=gRkVJJvPWMm4TWG5pZUq9Ec4/AesXCFx5Ro9lnDSPoQKliyjUtA2TISHbL9Sik7puMToBMuW2WoPfFeBJ0SBp75tYAEUL66ZZmURcRB/iSNC+SN3OxjD9CpHYdcLtiX0b0o8WipPBpyy7BbVhwdUZAvfJDVhI8tBf3bqq3pvo6w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Shaoyun.Liu@amd.com; 
Received: from DM6PR12MB3241.namprd12.prod.outlook.com (20.179.105.153) by
 DM6PR12MB3802.namprd12.prod.outlook.com (10.255.173.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Mon, 13 Jan 2020 16:20:09 +0000
Received: from DM6PR12MB3241.namprd12.prod.outlook.com
 ([fe80::e9a0:2dda:d7b9:9a10]) by DM6PR12MB3241.namprd12.prod.outlook.com
 ([fe80::e9a0:2dda:d7b9:9a10%5]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 16:20:09 +0000
Subject: Re: [PATCH] drm/amdgpu: check rlc_g firmware pointer is valid before
 using it
To: amd-gfx@lists.freedesktop.org
References: <1578681221-11093-1-git-send-email-shaoyun.liu@amd.com>
From: shaoyunl <shaoyun.liu@amd.com>
Message-ID: <977f2a89-9595-2ec3-f8f8-ceb3f7375983@amd.com>
Date: Mon, 13 Jan 2020 11:20:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <1578681221-11093-1-git-send-email-shaoyun.liu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::21) To DM6PR12MB3241.namprd12.prod.outlook.com
 (2603:10b6:5:186::25)
MIME-Version: 1.0
Received: from [10.1.38.28] (165.204.55.250) by
 YTOPR0101CA0044.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.8 via Frontend
 Transport; Mon, 13 Jan 2020 16:20:09 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2fa00528-631e-4d71-d3b3-08d798447594
X-MS-TrafficTypeDiagnostic: DM6PR12MB3802:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3802DCDD4AAED11A77C2F1F5F4350@DM6PR12MB3802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-Forefront-PRVS: 028166BF91
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(189003)(199004)(8676002)(2616005)(81156014)(956004)(31686004)(86362001)(2906002)(81166006)(31696002)(53546011)(52116002)(6916009)(498600001)(16526019)(66476007)(66946007)(66556008)(6486002)(36756003)(5660300002)(186003)(8936002)(26005)(16576012)(43062003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3802;
 H:DM6PR12MB3241.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tmH0k7uAVBXJuJTuBtwI+paWueq0HC425C/tKEkCjtEWfzk/Pt0XJ57wh+j2hAymamQuPOxEzuCxr+TelR/9gwxvdzdYcb9pVL29+cXtvI3jmvYq5G6tj3jhhTcp1zH2UmHkMF6VlWxQ5UswwluqTEvcbkfbga/4Al/8lFI6KRr1qewUwUlQJvnb35x3hkScpVbkQBTTuboDz7hTAhP5FBKnLTAkcj2VjQGGusGkqKOv12CpaPiUz+In3eBBGZf1epxGVTcuDvjPTQGeHYc240vHYSesXXhsO6Y1ruOofUHKvWBch1s3GZb3taFTm+qzZ1zX12EEQkg1Nz243rGQNCbkC/uWQ9c47cnKjxR2xy4hFoRABX3bP8WvMnhJ0o+GUlW9RIe2UhWAgCHTtsPb8H0TCVrt7KTIlvuYdwFfFi//QGfRBfub8WIp00fmXwNchcRgM3xrRvX6j6p9N3naXtbaNFES3BR0wYXDKuCWnDk=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa00528-631e-4d71-d3b3-08d798447594
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 16:20:09.5369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XO22dyfC+Mc997dtM85RAVC1Z9ktz4Eg0XDunToTNC0H+ge41a7Z/6fnk41WO7lHuDPl/5Ddr9NLCkxkxNZOQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3802
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ping.


On 2020-01-10 1:33 p.m., shaoyunl wrote:
> In SRIOV, rlc_g firmware is loaded by host, guest driver won't load it which will
> cause the rlc_fw pointer is null
>
> Change-Id: Id16f65171dd427d623af4c5bc75f674019e63dec
> Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 379e46c..07e22f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -808,10 +808,11 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
>   		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_RLC_G];
>   		info->ucode_id = AMDGPU_UCODE_ID_RLC_G;
>   		info->fw = adev->gfx.rlc_fw;
> -		header = (const struct common_firmware_header *)info->fw->data;
> -		adev->firmware.fw_size +=
> -			ALIGN(le32_to_cpu(header->ucode_size_bytes), PAGE_SIZE);
> -
> +		if (info->fw) {
> +			header = (const struct common_firmware_header *)info->fw->data;
> +			adev->firmware.fw_size +=
> +				ALIGN(le32_to_cpu(header->ucode_size_bytes), PAGE_SIZE);
> +		}
>   		if (adev->gfx.rlc.is_rlc_v2_1 &&
>   		    adev->gfx.rlc.save_restore_list_cntl_size_bytes &&
>   		    adev->gfx.rlc.save_restore_list_gpm_size_bytes &&
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

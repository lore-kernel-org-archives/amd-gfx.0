Return-Path: <SRS0=75wA=7W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95DDC433E1
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 10:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB05B207C3
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2020 10:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IMaA7U/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB05B207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6154C6E053;
	Tue,  9 Jun 2020 10:01:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 042036E053
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2020 10:01:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HB6vejguDvQXPS8C8xW5PcSxF/6vtH5JA3SfSS8tbJImFTnl7/2WqlE1FMCVFbPW5esCd44+XRT9kja302EgMe6Re+Bpy9PBAX5kj/w7CkONmxX1yjwE8lJ7L1fUBH3Ocq6Ifh6llAHl4W+6xfz1CKXu10TeVppQ/L2Om45cAgh7vyzQpKj0FbE3goF2HweLCqG5dMf9xtNu/3e2PDWC4jV+HgZkkpSI+4w1LW4On6kMksWhFixTyhxw3Ybx11COlBST1MkkVSVhlx1oSY35XqBDmi1Gb/Lfd7zYJkRiNUESNCw/QiLMAIaHVBKytKJI6J8gZPmIgK6VL2NdHoFUGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTipDfKMPWOJNGNCaBtwtEaLd1EGWXVojPyShOISfH0=;
 b=EFyHZ8ue+IuAFaWEM/4+9B+Jqzsl0AOmnujMTXvxAIS91VBuk6rH4jqqwsp6gwPJKKOaDuN0K8OPHbQVr7A43b1p1KETRWLB8UAcJS+rX2TlP5V89gdbV+crtR62stq1c4VUXev3IAIZT5NK1wINYIgxZZdrz9KMBsm922PZMoZBEls8lAYT6mHPbj27XXl1pcTZMz1c1EQFb76v4DSmnGATbdSIkKaEBPqPD9XL1XYPmxo83T9kQMDgMGX2FyazK6VmbtRIkjTbZraIeCIi36stHOjl2NSkqQhqwzdbKdK7bcoC7iR6U2OO0vMegrZfx6KuI8FSlAd2oQWdaQ/pOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTipDfKMPWOJNGNCaBtwtEaLd1EGWXVojPyShOISfH0=;
 b=IMaA7U/jHqMFhPLA35kU5MHfcQaUuh+8u0JQftqmrFoNpIyFeawOut7OlJ43T6PLqZn7eARj1f1ivQeFMPZwnWkPxnLxZN6st5ZywElm/S6Mt1D1Ubl+JpkryCCCGBOKxAQvq6qJ1nqaATEtvDhlpOC1Hg4cwu5x8e0wjHR7VmU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3872.namprd12.prod.outlook.com (2603:10b6:208:168::17)
 by MN2PR12MB3103.namprd12.prod.outlook.com (2603:10b6:208:c5::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 10:01:28 +0000
Received: from MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::8843:c094:fb2a:d60a]) by MN2PR12MB3872.namprd12.prod.outlook.com
 ([fe80::8843:c094:fb2a:d60a%7]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 10:01:28 +0000
Subject: Re: [PATCH] drm/amd/amdgpu: handle return value of
 amdgpu_driver_load_kms
To: amd-gfx@lists.freedesktop.org
References: <20200609092017.578945-1-ChengZhe.Liu@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <7ebe0663-3625-2592-3733-d671c35d7786@amd.com>
Date: Tue, 9 Jun 2020 12:02:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <20200609092017.578945-1-ChengZhe.Liu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR05CA0036.eurprd05.prod.outlook.com (2603:10a6:205::49)
 To MN2PR12MB3872.namprd12.prod.outlook.com
 (2603:10b6:208:168::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2003:c5:8f24:1c00:ac5:fe9d:2e5c:bb1e) by
 AM4PR05CA0036.eurprd05.prod.outlook.com (2603:10a6:205::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.19 via Frontend Transport; Tue, 9 Jun 2020 10:01:28 +0000
X-Originating-IP: [2003:c5:8f24:1c00:ac5:fe9d:2e5c:bb1e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9719146a-6ec7-4a59-5dfd-08d80c5c13eb
X-MS-TrafficTypeDiagnostic: MN2PR12MB3103:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3103C2A71E0A605077E14E7B8B820@MN2PR12MB3103.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-Forefront-PRVS: 042957ACD7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DRV4PdeqjvNfxP9uVB4tgdP5A6D8J33+rRAp2lULW6jTDlH45WKcN0/5i9nOpbztFhOE0Zu370iAVx1PICdXIFVGuW7O5c+JAgztIh0silY8QRZ1/Coth9yfL1rwCzBGLlc5oPWLFTvxps0BeMLzfgJMONbEluA7l9wCEw+El+R1IvQ7ajHzf/OcbRJ+kXkHjCPrtMYzYJkeOEdYj70SUQAHdfYRMwgkSwseFQ2m9Je3gfsXFuUfwPyXuPs5aKwgp0QhpeMIJ8Z45zl0ze/bM+J2kMS6fxRh30PDMqmhQwFbswpJHvFIuN5h2gdCQhpgoDBoyF5LR/uI+t3rmDhliQat5bV4iAMUQAJ4QsSQptQ8JkW8yEjpDkk2qq52Rr1K
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3872.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(83380400001)(31696002)(2616005)(478600001)(8676002)(52116002)(8936002)(186003)(6512007)(5660300002)(6506007)(31686004)(316002)(66556008)(6666004)(53546011)(6486002)(6916009)(2906002)(16526019)(36756003)(66946007)(66476007)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ta103kNxX1UNHjAhqi9SPxn74bq6AHy3CrL/B/EMBHjKthQ+wCtAjh0R419VDWQpcb7F912KMYYag3qRgb/SU8Ysy/6mqkQj1oOOqb2UzVQfnob98i1kubbk+utLDEJcmWe/+HSzmAgV7l/S/yQoirOLujDt7HplUKzpR777OwqLQ+Dh3U64C5nCgf91X5TyBzzemeclCVTeo469ehTo5RoygEMB6CKFY4IRFXbrc2DAAxWi0jQHOfs/4X6fNtsB5MBf14onlrUJGVsHLHjWCr7YBAa4fTdOhiBgnoztjH351Qnz7JeLYXmyKFb3+Ia4hsMFn+1IyNchQ/w1HdJr1coUskCaiAvnBNs/63kcTFjtQHPEuBSZvPP9KdD7hebvJHI/SmkNTXvVU3AXFM+QPvpxEDNK/fZcnRowmFc3RgSEiASF7rCkGa5IWMuIXVEpuJhfhDu6XAaA1PXRlDPHCLP6s2XDYKxfBs/zGmwt4DHszU/+50Ws7rQpJwM8LM0ZIsWFc9+247d7OTBR4MXZbBsMbW2okKk9KpGlk9yK6DI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9719146a-6ec7-4a59-5dfd-08d80c5c13eb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2020 10:01:28.5460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cy34fEvXyfgZnHTQelFXi2ngwMlivF8xlPKn4pZGQY4vJ2EEz33yjX8AF4r84awmqZxdASTffxzuR2G1MNdzFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3103
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

Acked-by: Nirmoy Das <nirmoy.das@amd.com>

On 6/9/20 11:20 AM, Liu ChengZhe wrote:
> if guest driver failed to enter full GPU access, amdgpu_driver_load_kms
> will unload kms and free dev->dev_private, drm_dev_register would access
> null pointer. Driver will enter an error state and can't be unloaded.
>
> Signed-off-by: Liu ChengZhe <ChengZhe.Liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 667aad1f15c0..9c81a3d0b546 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1165,7 +1165,9 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>   
>   	pci_set_drvdata(pdev, dev);
>   
> -	amdgpu_driver_load_kms(dev, ent->driver_data);
> +	ret = amdgpu_driver_load_kms(dev, ent->driver_data);
> +	if (ret)
> +		goto err_pci;
>   
>   retry_init:
>   	ret = drm_dev_register(dev, ent->driver_data);
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

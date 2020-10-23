Return-Path: <SRS0=vRkk=D6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0F6C388F9
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 08:28:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EBBF2192A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2020 08:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AlSPlak/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBBF2192A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A5016E4DE;
	Fri, 23 Oct 2020 08:28:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B96236E4DE
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2020 08:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSWnZgDD7a22s+p+XAGeer9dHUeyyPDQuP+/J0e+ej+KME4uSqCiMuGXQiRw/7+zBeCG4TBMT6hCa/6WDCwkWj9F7K8/R340BNVaZfRFod89oYj4f4nQTb3NnUdn3LOroiVqVoTIrjsrDQRsPPnnha6+fVJvpBUD5UK2oXSp7lHPVQPtSdPNMzS0vrLPF94LUfZPvRhwLOVaLLr/dZ9aHMah38JzMffgaNd9qot7IJKqDYdUhgmaBZwXSkrdgjVTH4aCDwz7fxtancc2sJcKoh5ARjSDQDhvSBskXt0r8guYRxzEpyWWoSX1zOT71TbId0hW3ycp91lpT7FMGkpNGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Udk5QpCZaoTqrCUVSm2WiBI4ORBX49Ncs4EeO6Sl3ts=;
 b=V6XLnm2Km3FxXSKLhukurgT1rA3Y7cNwWDCR36G6YkR3aBUyk8mzvtetD/y6srxQa5jslTadaemD6NzZ0Y2pUd7kWZGMizEHIubvj+zkbUIyZwQ9kTcLTAvO35YBWSyL7rgTLA8bIQYlUuc8fC9/gwa18vxgAet4vNzqBl61uo/qyRtaM7Fxw/jxuuuDtq8+55sOMKI4vzCNNVTaGbRM1YzRCyzBLDWUDmeJF8WkzmoicJpIWZnBVwFFdg6Mbbzc4pPS3QweGZJGBsrDXQxcWRzAi/ftt5npkaUzoQNqsV4ScySGql5pM3dN3egZvKXVpeVfDlvMkd/MM1jdBnvbew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Udk5QpCZaoTqrCUVSm2WiBI4ORBX49Ncs4EeO6Sl3ts=;
 b=AlSPlak/Cp+oduecKTNfk5VHJqXnxtQuw6q0sTlcn30dP+Pkp0ZWRLlde6LT4zIVLfC3o/cpf/Fkr0KxA764f3RbWATTCAy1ioiwY7LE7Cke1Bkv0udaYyVB8uCguhc8Mx+EHOJW6kzfHblqmOVIDrCCZP1tvEB87H7URxQHDYs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR1201MB0128.namprd12.prod.outlook.com (2603:10b6:301:56::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Fri, 23 Oct
 2020 08:28:55 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::b885:8b56:a460:4624%11]) with mapi id 15.20.3499.018; Fri, 23 Oct
 2020 08:28:54 +0000
Date: Fri, 23 Oct 2020 16:28:31 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Hou, Xiaomeng (Matthew)" <Xiaomeng.Hou@amd.com>
Subject: Re: [PATCH] Revert "drm/amdgpu: IP discovery table is not ready yet
 for VG"
Message-ID: <20201023082831.GA1424760@hr-amd>
References: <20201023082115.13573-1-Xiaomeng.Hou@amd.com>
Content-Disposition: inline
In-Reply-To: <20201023082115.13573-1-Xiaomeng.Hou@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR02CA0164.apcprd02.prod.outlook.com
 (2603:1096:201:1f::24) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by
 HK2PR02CA0164.apcprd02.prod.outlook.com (2603:1096:201:1f::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 08:28:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ccd65203-3727-4801-e3be-08d8772dad7f
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0128:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01281FDE3C3D2C9EDBE09A2FEC1A0@MWHPR1201MB0128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gWuVepp/Zq19nvhF4Qf8MF1Kh/F0xYSsGLNeY1DhcmGlCAEkj2c73F9RQ+NMtbsUfFnkKichPKF4ZqE+xme7nyMOsUNda7PdCANjkgbv+Y76WgBcUyruTuZT72uKeLKd6LXujfepOw5dUa6WsLtDtqb4wN6LLBjJrvjv4WMr+zoJfug+c85+DtQQMXYLyR42w3TOH5d7BLqMlBOSemBwlCNgd/CIICs5X5PIiacGFNH1LFygGX53QZpoTq7gtZdi7G7Z2zb1pyALvwtGsSz5OAa1VdKpnvV1tlyQ9pOrpxyzNzOdCuTn2PQTeQwaqXSp7zs0gIQgQCjtCKVem84xbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(2906002)(66946007)(4326008)(26005)(86362001)(66556008)(16526019)(1076003)(33716001)(55016002)(66476007)(5660300002)(186003)(6666004)(54906003)(33656002)(83380400001)(8676002)(9686003)(8936002)(478600001)(316002)(6636002)(6496006)(52116002)(956004)(6862004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: h1YqGto2FO+bX6C73GYmk474+8tZOPoQJoIGwjuPjje9T/mSMrwDmzfNUvU/jwPmlA+KO8yT4cedw2+9QdBG5m/bmB3xSkA4kfQgRqzh0LlISLnRCzjiVN6u7eWxJp8COc7z1lX4jiKcj7V0XfJM53TfkA9lyXNsXlkX1/7U9o8+JtwzxrWJG7emUZ/xdKfr+hb+/E5T3ndYZFLv0mswbjyC3KUjdApdVHTWWprRzzr7icNZpnxGywDx8jG4cfM224IJYRhynaJt9SwAKGCSSW7nusQfGVOkVpmlVOI+8d5dZYujNlImkAwDhPulJs/9fUBf99jI0SHO7JiJiofmbErf/O1t81txIRa1XgcHpX+juAY97YJxmgZ7+IDYyJuditFIDSr6XzRHOUSbWZBw016SNEz/8Gs3m80rs2FHVT/CtcEF4/IxH4k2VULtWdxglEDIDqHZ1EMK9spXg++3Jq+xUnPVvCL2W4tq6XkFVzNaSnm2rcTAaS8JXVwCFuRiYdwYF6pjBRhFE0+ZIo4qTLM+cFZJ48MMXMRyx+KNW+ZtuER47QJjxCCKNRw/BmLti+zNai0ZjfWCs3Z871NoJOewDThxUyX05vPl1FkLdkW11rLa6JjvUUcwOIAIhXbJRQw7xMxjx2hbCpqMNmA5Gw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd65203-3727-4801-e3be-08d8772dad7f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 08:28:54.6546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kbb8KYmovK1BP2+eXSzOHC9BDKad35xqSu2JQRabuZgoHnWcCjfeUAc7mdjXCheIo8ZXq9/GpQHtHg1TVJ4L4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0128
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 23, 2020 at 04:21:15PM +0800, Hou, Xiaomeng (Matthew) wrote:
> This reverts commit ba502322c9f216552485cea967aeb8adbaf03a02.

I suggest you didn't highlight to revert a patch. Becasue previous commit
was good before, because it's the gap that firmware/sbios support.

Just modify the subject as "drm/amdgpu: enable IP discovery for vangogh",
that's enough.

With that fixed, patch is Reviewed-by: Huang Rui <ray.huang@amd.com> 

> 
> IP discovery table has been verified on vangogh.
> 
> Signed-off-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 72435e0eb8b9..30ec826c8760 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -449,10 +449,6 @@ static int nv_reg_base_init(struct amdgpu_device *adev)
>  {
>  	int r;
>  
> -	/* IP discovery table is not available yet */
> -	if (adev->asic_type == CHIP_VANGOGH)
> -		goto legacy_init;
> -
>  	if (amdgpu_discovery) {
>  		r = amdgpu_discovery_reg_base_init(adev);
>  		if (r) {
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

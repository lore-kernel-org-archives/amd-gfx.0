Return-Path: <SRS0=+8vs=BO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA1DC433DF
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 03:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A19C206F6
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2020 03:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MDea01YC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A19C206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 799E06E419;
	Tue,  4 Aug 2020 03:59:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6B846E419
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2020 03:59:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JXn8IaQPQtVR3EA7lTFozOQmp4XbtyjIOMaopwaaP0PiSmM/6zpa4PmaC6VAdLfPuRMUu6Ois0k1g7S1XlYEQhgziA5e5lRAMNH5nXAnVOfUFMoJN5CcyuyElLmMa/YUA8vnEXnjssgnpKom1Tr+4VixAIfZmj8eKB0i50LnSOcSpPkLLJPsWrrhimMaX4SIhGxrwoXod0XMrdHM2kS8xbWly0v/80qYpxpgVH8omqrw19OIWxd2liLkTk0Fy7GMV3+5HrfF00FhX+bZdMTeDbHefl0DumJp5q6kjVhjmibq1ocWRCJbrm02OrklTFbhAdFcqXEeCvm4KxdIyMZ/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQO5pnN4Q6Xs0mWuKQR+/4+L6qBIXAClIs7uYuIgvCI=;
 b=NzFkFyeAQb4kyvdk2g79VaYtEyK1ttgcoYyAbz8JAIceU+xRB7Mk288rLQf09S1mcW+3kAgsr6HYpQ7tO8Enz6jbpPERSq8EmUrpcIyeUzuOa9TZSxAxvB9KCq4N87bqh2I8InLuOEYKkl/L2aOp1/aKCUb5yYIIRcZoeQJs+2jZvQlo90gkg1A1KO9U7BDMJlSDZBZP6dOtICsT+5WfKzNimmAOgq7tAd2vghZ1bCF8tt5X4EnED4RBFd33yjmXWkeDShgFlpQ75ixGffbOKBKQK+l5oxJkRo/KB5rtfey/jL95APGiwyZDLDk3RGniHYk5rQ1gG3MtTNRiHocSSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQO5pnN4Q6Xs0mWuKQR+/4+L6qBIXAClIs7uYuIgvCI=;
 b=MDea01YCVEmGDi8CcLDchF5WW9Hbzavs6czN0PcfcOoTz/54tgrGNXaP7HMn4bD+o8dK66NNghR78ptnXegadx/VHlCMxQQCX7L85blkS03gdlHnYheATRyDT3VMGI3ZALO3wzKyKFPkFfewZ1LQLw49kGg/Pbbkh53DcO2lv+4=
Received: from CH2PR12MB3766.namprd12.prod.outlook.com (2603:10b6:610:16::21)
 by CH2PR12MB4311.namprd12.prod.outlook.com (2603:10b6:610:a8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Tue, 4 Aug
 2020 03:59:02 +0000
Received: from CH2PR12MB3766.namprd12.prod.outlook.com
 ([fe80::9117:2aae:1acf:dec6]) by CH2PR12MB3766.namprd12.prod.outlook.com
 ([fe80::9117:2aae:1acf:dec6%7]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 03:59:02 +0000
From: "Lin, Wayne" <Wayne.Lin@amd.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/mst: clean DP main link status only when unplug
 mst 1st link
Thread-Topic: [PATCH] drm/amd/mst: clean DP main link status only when unplug
 mst 1st link
Thread-Index: AQHWahDPQZxOlx1fYEWHFcgeU8GZ0KknUo7w
Date: Tue, 4 Aug 2020 03:59:02 +0000
Message-ID: <CH2PR12MB37662374F70AF9B560C2A770FC4A0@CH2PR12MB3766.namprd12.prod.outlook.com>
References: <20200804033631.32733-1-Wayne.Lin@amd.com>
In-Reply-To: <20200804033631.32733-1-Wayne.Lin@amd.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-04T03:57:27Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=59e47996-d848-41f9-bd06-e26499d41354;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.135.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f356006-4a22-4924-812c-08d8382ab969
x-ms-traffictypediagnostic: CH2PR12MB4311:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB43110F8767283FF4FDC35AC5FC4A0@CH2PR12MB4311.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:160;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bhhVOQCVfTjLm17b59yLU8RvuFIos3pYp3LYNnYaz7W1TgA+C8A67taxclKo4jeaweHvRCEGOokteM4TfTRwnk7OfpOw7EHJbd/ti6FY226PnXNJZtfWCDShWqQHYbq9S0WpRX/PSXMqKKVVihssmZZ3t5C0paDxZfoXSppdrLhwY0Qy43ouxOMA6vdRKwPqZrLqvqxZKr0BEQCCvnnAAbr8V16zKmBNyGhiuro1qeU+XIufKkX5pcDk2ni/piUc/P5C741IY4lWl9mt0OPcgH+NwRZ3vwLUvNV87/8f63ub2kI2eVJ0N7bHGf4cE76t2Hlh0UfImkWCld1zdv4oZw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3766.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(55016002)(9686003)(4326008)(52536014)(478600001)(2906002)(5660300002)(316002)(8936002)(86362001)(54906003)(110136005)(76116006)(71200400001)(33656002)(66476007)(66556008)(66446008)(66946007)(64756008)(6506007)(53546011)(7696005)(26005)(186003)(83380400001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: E+iTA4FDE/AKCdsyCMwgg2djmdJEEy1SfMyVKC0OPJZ74DtemxYjMFwT7bAXvIExKRIVPy6jDxaVJ0XRJPql9oqHFX3oD1emEaPR6wSy1hrPe9j9K4+FUHGLYcfYzMU97FlpivyhqwBGFWUpb/UQzNVHYX/zJJM7livoN/tAT6BR4X44NuFbww1m28T+TZqpuooB9gcc5QvaiSQDP/OxYFwgQ091bgAjxoElvmQxCxtIx4eGOt5MsEzwRv1sekYWHgv/+B55I4f4EU8HjT96pvbC+vn9HQv1mV1DSXZxqFHm8aey/FrHT9TsQj33E8NW8RhAxKwZis4zXlOADN1/fLzR2ZCwTm7ZB53oU6XvEB9GrDQDR49zBvmpqTwuaQqBynNqoZ/w+x9d7b8VgIanRMIiX+NGa8auXSJjdJ/HQNMP4DSJkEU5Hh9JgYrkIRAomPx383LGN90inPcJvELItUg6Ql8CGrnlaz1U7F7vN/FQPyp9y52j/EncpJCUjwHkUbjvFAruy5K93HtJsqhauKsG8SIxXWF0yEmZj8C9rho9TVepX+TYUeuDcJyeKcNi0/AWJBkHUbjkeqtwbgaV/xEDbOq85aLxqwfaZVVJiiy3+6ZzIEI8UPm2hxqnwW9f4XBRhOatks82UloVc1bNFg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f356006-4a22-4924-812c-08d8382ab969
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2020 03:59:02.2167 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: or37qFHVNK5lJEOazlkcfyWOiN6cM4vP3i8G6NY/W15q2tZA+ykU3qq4KyBNwCt6bk/vYMkxqHjSKft4tmIWkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4311
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
Cc: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>, "Zuo,
 Jerry" <Jerry.Zuo@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Wu, Hersen" <hersenxs.wu@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Sorry for spamming. 
It's a duplicate one and should be ignored.

> -----Original Message-----
> From: Wayne Lin <Wayne.Lin@amd.com>
> Sent: Tuesday, August 4, 2020 11:37 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Wu, Hersen
> <hersenxs.wu@amd.com>; Kazlauskas, Nicholas
> <Nicholas.Kazlauskas@amd.com>; Siqueira, Rodrigo
> <Rodrigo.Siqueira@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Lin, Wayne
> <Wayne.Lin@amd.com>
> Subject: [PATCH] drm/amd/mst: clean DP main link status only when unplug
> mst 1st link
> 
> [Why]
> Under DP daisy chain scenario as below:
> 
> 	Src - Monitor_1 - Monitor_2
> 
> If unplug 2nd Monitor_2 and plug in again, observe that Monitor_1 doesn't
> light up.
> 
> When unplug 2nd monitor, we clear the
> dc_link->cur_link_settings.lane_count in dm_dp_destroy_mst_connector().
> However this link status is a shared data structure by all connected mst
> monitors. Although the 2nd monitor is gone, this link status should still be
> retained for other connected mst monitors. Otherwise, when we plug the 2nd
> monitor in again, we find out that main link is not trained and do link training
> again. Payload ID Table for Monitor_1 is ruined and we don't reallocate it.
> 
> [How]
> In dm_dp_destroy_mst_connector(), only clean the cur_link_settings when we
> no longer do mst mode.
> 
> Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 5
> ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git
> a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 2c10352fa514..526f29598403 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -415,7 +415,10 @@ static void dm_dp_destroy_mst_connector(struct
> drm_dp_mst_topology_mgr *mgr,
>  					   aconnector->dc_sink);
>  		dc_sink_release(aconnector->dc_sink);
>  		aconnector->dc_sink = NULL;
> -		aconnector->dc_link->cur_link_settings.lane_count = 0;
> +		mutex_lock(&mgr->lock);
> +		if (!mgr->mst_state)
> +			aconnector->dc_link->cur_link_settings.lane_count = 0;
> +		mutex_unlock(&mgr->lock);
>  	}
> 
>  	drm_connector_unregister(connector);
> --
> 2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

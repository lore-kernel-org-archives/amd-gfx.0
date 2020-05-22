Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87DCC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 08:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A722207FB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 08:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ykwTXVl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A722207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 488B36E3EC;
	Fri, 22 May 2020 08:30:49 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750052.outbound.protection.outlook.com [40.107.75.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 407186E3EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 08:30:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9ZjgtZuZsC18lcKCMs6LBThlat7PYw+vf2Rf8Hg2c0kkV3IGhhc7ihcgUQU21IkRidmUj8gvpM/VfR6MUWGYrmWvVpFwYBuq2aeWqgxdgpDUqAYYWfRsGRwd5hrNx27T3NPXxyymq1O0v4hxKDldA4T6pVwHBV6DTi4rzTTWGxdSOU6P4728IIdbZKlTYaGCGqwD/GfxY0zdrXkWd81sdf/6bfTu3kDwXtu24ebcGuo+C+2jPb2Hn8djqY+qVnx5Cn8X/GXogmHJrChKRqJ4T6r2LTE+yn/06IgKr+ExmCKeXa1wyUlB5kV3JYYXMsUNaE5Jc0+xs0cZTQkHEhFpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksMgz3FRibbwyFsyD5hj7CwkDLRTK5Yho3z2tMcMZQM=;
 b=eF8JnaMN2vL+BpR7YISo/3q7bUoEe0LpXXhcOAdIN2GGsiDzRlpP0DYWCiKkvnb+NbY5O1sCHKPH8IEq8mZRTL9ZFkXlM9aBpAgyyqmOyu93ZM+3arlEo3hLxnagqITNB1o5h3zSdQaUY+kjoNwelBdAnxyVkCQgYWmWBNAeVMTYBmYZdJHiyGbskuy4UEYuYJyfXgHbKFd+aPTohvTYLi/SBgYDNjqvv0jtoEHZGaEFXfrdhVgUD07dMB0vgyBR0riAWot5yM15xHF0fJXeDF+Yf7q0C2VZHeATQEi714KgTEOIGYRIckA53u/5wO/jnR0yKHcm77sYiDR9SZHYmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksMgz3FRibbwyFsyD5hj7CwkDLRTK5Yho3z2tMcMZQM=;
 b=ykwTXVl2DSufsswASJ70E8yJypnA5+W83uHzAu7mPfqx7bmkoLofgQmqegPFOGpMDit+RWyIaSzx5KIBPVCMg0kh85FZTnx/qsEQ5rpT92uQCKnOknA6yDrTwdc1QLB7Bi/eL27xSomU3BeSxketSTz8fvIA0bXDPY2OXCF/Ghc=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR12MB1846.namprd12.prod.outlook.com (2603:10b6:903:11b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Fri, 22 May
 2020 08:30:44 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc%8]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 08:30:44 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Clements, John" <John.Clements@amd.com>, "Li, Dennis" <Dennis.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: print warning when input address is invalid
Thread-Topic: [PATCH] drm/amdgpu: print warning when input address is invalid
Thread-Index: AQHWMA4TRn3s7jd+rkGNxbO9m1trTaizwNgAgAADp9A=
Date: Fri, 22 May 2020 08:30:44 +0000
Message-ID: <CY4PR12MB1287F8AC265664C6227826C6F1B40@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20200522075304.22231-1-guchun.chen@amd.com>
 <BYAPR12MB2888E86B6A5017E5D55A5DFAB0B40@BYAPR12MB2888.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB2888E86B6A5017E5D55A5DFAB0B40@BYAPR12MB2888.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-05-22T08:23:49Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=1a5bba39-b210-47a7-a48b-0000c15207cf;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-05-22T08:30:41Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 4f0bc5f0-ac25-4193-8f58-0000a6a418a6
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9b5af260-16f1-416f-5822-08d7fe2a6bdb
x-ms-traffictypediagnostic: CY4PR12MB1846:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1846F2ACC32708AD51FF1ABBF1B40@CY4PR12MB1846.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:159;
x-forefront-prvs: 04111BAC64
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dn0rKfr/VqCqK+hiuL39eftIdFNusezeOtnKBNSBiugp0W/KsEDrDBALIzfAhbbDORFmjpjtnJubIC9AAXOJY9BaM9McdEcFDBz+psjUZlXb+nrbaBBcr806CYyeHqNlcRT8lN1iMqy0o27g4mbj0DGa3RsJH/j0pCjVDK0YqfEQBW1vd/nxBEaQEzWR5uJAL1UoqWvHGQMfoDccCruxvTvLlFuehRe9TX67GPOOKWl1g1eUwr7kJE5vbviRKtlV9S+VJC/D+BtXv97r7Y97crZZJi0sbksEGYLbCqnqlO0ZgrXkVCvBBIq4FssxygQZpR5sC2rjO3ocb+dVLzaEnOCbg5SK6PTw8MZ5GK/y1vQpyk9TfVt2LV64EKqHUPXTQjAItTn3RwpYYtkkBz7PZvk5bHZezAUKBbxQqt5LNNHB0zDB+aQdLR9nymcNaUBw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(26005)(2906002)(5660300002)(53546011)(8676002)(110136005)(6506007)(8936002)(66476007)(66946007)(6636002)(71200400001)(9686003)(7696005)(76116006)(66556008)(66446008)(55016002)(186003)(64756008)(33656002)(498600001)(52536014)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: uk/CLPVhtBomakKDVTggQHF8oFw5dpOxRwWJuYPMEqEgSyDEoSMfr+EyGzBSzKNUBc1mAxVEPR6+YrR2W3lwpzGJsq8raBQPcfpc2VIRkEMCXs1boNIZUxTDNmmZtGTJZHJubnlpe1oYuRPFR9FcqZ8cxjuRuQgohKFTEaeEuZ4pE489Xvrr5szET4D3tiefxT2B6ZKgqwCf9ttZTzbiaM9FEol4kSelg1BKP+e7aprQKHbs/F4cmYZiwLARn/DQgS8ibN+9bE2Fl5knHlc3B2zWipIWZ7MRErl5i18zEE0L/XxQZz1ehW52znj99hGTPAb+ujwW8OBVkAdkgF8T4Vhgyi2j9oyCI4KAI/olkXeGckAd4rSm5vFOrB1ASvuIuwp3ruILhp8bntjRINlE4SOWjTL1F4YUT10K7m4pNy9f8Mj3A0IE+/U43zbIpYHBkQHpEgMWlnqOAW1M+jnlEEbDrGkqC7WxfmXQ1XDYMipiEx50DKGxshgf1IgMAJaH
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5af260-16f1-416f-5822-08d7fe2a6bdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2020 08:30:44.6573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v0RAcqdY5Sk7hajihJhCAcJ+3mHnyhDOfQlo7ODp52J5YCtvNA11x/sHdxAjqz/B+b+EDh22cqd7v8JSTo3YpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1846
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
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi Tao,

Please see my response inline.

Regards,
Guchun

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com> 
Sent: Friday, May 22, 2020 4:11 PM
To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John <John.Clements@amd.com>; Li, Dennis <Dennis.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: print warning when input address is invalid

[AMD Official Use Only - Internal Distribution Only]



> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: 2020年5月22日 15:53
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking 
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, 
> John <John.Clements@amd.com>; Li, Dennis <Dennis.Li@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu: print warning when input address is 
> invalid
> 
> This will assist debug.
> 
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 6e911ca97038..5c73f444eaef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -318,6 +318,8 @@ static ssize_t 
> amdgpu_ras_debugfs_ctrl_write(struct
> file *f, const char __user *
>  	case 2:
>  		if ((data.inject.address >= adev->gmc.mc_vram_size) ||
>  		    (data.inject.address >= RAS_UMC_INJECT_ADDR_LIMIT)) {
> +			dev_warn(adev->dev, "Input address 0x%llx is
> invalid.",
> +					data.inject.address);

[Tao] How about this way:
dev_warn(adev->dev, "RAS injection address 0x%llx exceeds limit 0x%llx.",
				data.inject.address, RAS_UMC_INJECT_ADDR_LIMIT);
[Guchun]There are two cases for invalid input address, one is limited by board vram size, and one is by RAS_UMC_INJECT_ADDR_LIMIT.
So it's not necessary to distinguish here, just print warning to let user knows the input address is not correct, and this error injection is blocked.
 
>  			ret = -EINVAL;
>  			break;
>  		}
> --
> 2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

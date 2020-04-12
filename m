Return-Path: <SRS0=jv7P=54=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCFDC2D0EC
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Apr 2020 03:49:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D3C2075E
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Apr 2020 03:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uKK0EgYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D3C2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 916746E101;
	Sun, 12 Apr 2020 03:49:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 621346E101
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Apr 2020 03:49:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwqaeIFVHSBQRsX2SpQHeKj3D+KGAjYLw9GxPRFHLGPbW4DR3vMcxu9N9nPK4+eWZa+qEaI0G/cphRfo8pJO5ga6Zjaw9z1Sd2Xi3PNFyaAutuvuyaLTcCgqdp6rd9tX8rab9+xO/vdCcTkYppVUBRQl6/HjKndJf6jEKZzMJe3SToU70tBrkG9ktN5Nm3pxPI+9Qi0GctPoX7Zs2DNJwbpnKnITDikbXpdkcaLIMKWrYISCcQHMbpjGhkkVbLtczooWetRTqlOYSbW8aZlE5c7xH5IhATCtwjB0O4dKlXtjJmlTtdTSU3GvvXODEYdS0wKp6tZsaQs+8DKFu+MPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVMVgROznoxxEWqHmfo0yKRwr2xK08sf3YzjLdAxpVw=;
 b=ErAtElclcs0+wBLxoldZmiRUHiyEJJIcX0H8LGg2fd8yWVgSHbIun/Pz4ZUCBaZtgEM4peG33AqTaT64JESf/iAABkk9tYJb6a66zgmerd6VHWqgt9p1v0TX5fK/OeoVVsMbi4gGW1wfsSBmZc93hy9XtIgiW5x/VGjDnsPpMubnvubn5NfjYRft8Z1hvkCReoLiq7bcPJN2D+doXDlTRuHiG+PSTxynhUPPMymlMa6J3UIZSdoh6YiSyt0z7brzceIjIcMypU9NicpPye3+q2PthN3sTfnmZm4eHkA2MvK3cJVqBP5iCZtTGAIEFblCzhAa6/8FHYUDSIMCQPUu3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVMVgROznoxxEWqHmfo0yKRwr2xK08sf3YzjLdAxpVw=;
 b=uKK0EgYAEPKb+zTlSu+r8RYT7/sF8vTmKp0GQcLw09ayWhkvvxB/Gulqv+jImG/mUmrl4P4qjk5mZNci6mGBSPhpmUJeFceuQj07R+EtPViD7zserI5p/EUuxEylzi/aKRJU5NlOYbQLxCz8kwSVuIP12lgU7O0Cj7Z1QLzOwPA=
Received: from BY5PR12MB4307.namprd12.prod.outlook.com (2603:10b6:a03:20c::16)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Sun, 12 Apr
 2020 03:49:40 +0000
Received: from BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::c8:8aec:d08e:8bca]) by BY5PR12MB4307.namprd12.prod.outlook.com
 ([fe80::c8:8aec:d08e:8bca%4]) with mapi id 15.20.2878.027; Sun, 12 Apr 2020
 03:49:39 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Johannes Hirte <johannes.hirte@datenkhaos.de>
Subject: RE: [PATCH v2] drm/amdgpu: fix gfx hang during suspend with video
 playback (v2)
Thread-Topic: [PATCH v2] drm/amdgpu: fix gfx hang during suspend with video
 playback (v2)
Thread-Index: AQHWDN52o48DXgwBp0mMZR3JAwJ8m6h0n6QAgABAR8A=
Date: Sun, 12 Apr 2020 03:49:39 +0000
Message-ID: <BY5PR12MB4307451314528C7285E49C60FBDC0@BY5PR12MB4307.namprd12.prod.outlook.com>
References: <1586265256-8824-1-git-send-email-Prike.Liang@amd.com>
 <20200411235534.GA1930@latitude>
In-Reply-To: <20200411235534.GA1930@latitude>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=f01a108e-dc45-4ceb-ba74-0000e90ea2f8;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-12T03:45:38Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Prike.Liang@amd.com; 
x-originating-ip: [139.226.16.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6f2375c0-cfdc-4a73-4521-08d7de94871a
x-ms-traffictypediagnostic: BY5PR12MB4052:|BY5PR12MB4052:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB40520A9886709A9038604B3EFBDC0@BY5PR12MB4052.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 0371762FE7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4307.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(6916009)(4326008)(6506007)(71200400001)(33656002)(15650500001)(9686003)(186003)(26005)(53546011)(86362001)(7696005)(66556008)(81156014)(5660300002)(2906002)(52536014)(8936002)(66446008)(64756008)(66476007)(316002)(54906003)(66946007)(76116006)(55016002)(8676002)(478600001);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w3NvVmAMhoIM5Bee5HNpaGHzXOCwMM+eYnP5oi9EkzsnHwvBZzoeQgDb+zz1B2BQnnuynMPf9nr7tsnQ3cLKaBkk0yYSWBoebx1bl2A4ZGgpTWg6RXHAUH2sHFsBPhmr6WLwPauiiOPN351aPUjPeeI7lY2dVuKx7sIhn9KeNOAaIxJ57YdzgIrM/LzSHXmrL00F4BcyRkgMhUr2izoxhtpGW/GUsZl/1Py5brkIZc9+q0MB3z8HOUF4c6OBhAfQIOgm2F8iAyJ+0h0Xuy5OB23k2mjU3i65Ro4eBPFDauLKdqsa1K/r1GphtIaLKIU45D/xKMmTBt7Ea2x8dF8iaRYVGky4Z5SAYgTyo3hgSOGh0OTCTFibztUXbFjM9va5/bVslV9nst8gw2ME5KmPQtLHtVZ3z2rYPu0WRn8SJjFt5OALdttxoCxF/PHl8UnH
x-ms-exchange-antispam-messagedata: OfkvGAPehTaBIjI6jDhuxOH2A+a47e8jRDnloZDqYjsVxqXkdbnLkvdWrFyEYInTkh0UI0m0rn+FRTn6euAxQSdI8+qYd2TEEY4KbVE9AFIKPCsqruBdyhgfb+87hjkLSxLhHSZ8EkoEe29RuTAvKg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2375c0-cfdc-4a73-4521-08d7de94871a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2020 03:49:39.6877 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ym4BbcF/FevR+D96FNNzEbCGh55zXpUXhcsC6o49tXzpxkB0ytJHg83HUJH7CExY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
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
Cc: "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks update and verify. Could you give more detail information and error log message   
about you observed issue? 

Thanks,
Prike
> -----Original Message-----
> From: Johannes Hirte <johannes.hirte@datenkhaos.de>
> Sent: Sunday, April 12, 2020 7:56 AM
> To: Liang, Prike <Prike.Liang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@amd.com>;
> Quan, Evan <Evan.Quan@amd.com>
> Subject: Re: [PATCH v2] drm/amdgpu: fix gfx hang during suspend with video
> playback (v2)
> 
> On 2020 Apr 07, Prike Liang wrote:
> > The system will be hang up during S3 suspend because of SMU is pending
> > for GC not respose the register CP_HQD_ACTIVE access request.This
> > issue root cause of accessing the GC register under enter GFX CGGPG
> > and can be fixed by disable GFX CGPG before perform suspend.
> >
> > v2: Use disable the GFX CGPG instead of RLC safe mode guard.
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > Tested-by: Mengbing Wang <Mengbing.Wang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 2e1f955..bf8735b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2440,8 +2440,6 @@ static int
> > amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)  {
> >  	int i, r;
> >
> > -	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> > -	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> >
> >  	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
> >  		if (!adev->ip_blocks[i].status.valid)
> > @@ -3470,6 +3468,9 @@ int amdgpu_device_suspend(struct drm_device
> *dev, bool fbcon)
> >  		}
> >  	}
> >
> > +	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> > +	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> > +
> >  	amdgpu_amdkfd_suspend(adev, !fbcon);
> >
> >  	amdgpu_ras_suspend(adev);
> 
> 
> This breaks shutdown/reboot on my system (Dell latitude 5495).
> 
> --
> Regards,
>   Johannes Hirte

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

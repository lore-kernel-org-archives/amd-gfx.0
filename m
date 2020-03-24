Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE80C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 02:53:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A72F206F9
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 02:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Cj/nDFwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A72F206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCB316E0A6;
	Tue, 24 Mar 2020 02:53:12 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680077.outbound.protection.outlook.com [40.107.68.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59E106E0A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 02:53:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nq8yvA4Ip9uWcdC23moi+ec+EpWLykm++VTbcZpt89BEjmvv13KzCBM73PrjdtEUl75jjcrh34+JCA43icwrMFpqf7g4xioc2oxW5bKGivYUO2rHKZ0xKxJg/JAHPS37bRiDzjeIW+CM7n8X65nDg5b5BlBGV2wLubMT9jcnCnADSKRk+sD4u/wx8pNnRXJYfdDqksNCUhsO2CyyLS5zXYzEfWal376w0xVYdwu4Z/IZe1E2JlLIlaTApb+P6jfPrMwFqzfGxf8huKJ3kbXdDixvDPsDpti9eZ/dz/3gzVbk0/cjmE+zAuX9Uu9vfox+KnK3I0HWr/qodzLiJdzcrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KN+oLUpjMEdclOV2DbaYhKHN/R5No7Q2/hbMYgq3N4s=;
 b=NvrLwRx4pzKcx2X0jXbBa/jbl8wLSGWJcqr1u6woct1V4C+ZCtD44NibxRBPESef06ofZfneM+nVWl5aQqoAWIQ2qTcC+Rg5XC1u6EICvwjn+6UiytaH4q19k0plZ2kQsORWjbJ0EKbHbZKqVWc11XPAfsjxzJdhTWeCifvo+C2LmOlcOjzLhZEB+TEGlSQOmDdgcII+IeBL1npDvu0395g7OSdc+iA6QhsVaQr+SIAvHCeSIbG9Tniy9nIrnD3Sub2BOEthw6W7YBUx61iOh0U5Edu77qD9RfYldn8Pg+AOUTfarTmfaZpMoG+fJpmFKAm6N/+tEEUCgwGKt7VKLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KN+oLUpjMEdclOV2DbaYhKHN/R5No7Q2/hbMYgq3N4s=;
 b=Cj/nDFwdA4oP6JlFT0sgJzpkT8TWb6vUa2YnXvHGITtTMxs2zQRau0OPg96PJ1vQiZVTa3FtkWSXwG2mOynpgOgv/IYQLNcwLOQtqOjGHBfnCCE2Cm3QDTWRbvCMf4C2Jjj+VdBhRX2flpt/rY/npuVr1+TPV9ozdCl7rCipJl0=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB3263.namprd12.prod.outlook.com (2603:10b6:208:ab::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Tue, 24 Mar
 2020 02:53:10 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 02:53:10 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH 8/8] drm/amdgpu/smu11: add support for SMU AC/DC interrupts
Thread-Topic: [PATCH 8/8] drm/amdgpu/smu11: add support for SMU AC/DC
 interrupts
Thread-Index: AQHV/uVQMVz7hXmtnkqZ0cgC6mMsy6hVj2QQgAC2i4CAAMn3IA==
Date: Tue, 24 Mar 2020 02:53:10 +0000
Message-ID: <MN2PR12MB33448FC38E33BB46ACB043D7E4F10@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200320182727.3805-1-alexander.deucher@amd.com>
 <20200320182727.3805-8-alexander.deucher@amd.com>
 <MN2PR12MB33446A1ACAAFB466670B417AE4F00@MN2PR12MB3344.namprd12.prod.outlook.com>
 <CADnq5_OhhLSfWD5XRkdxbTtOhhCg6a7sSt9m_ON_bocNNs9GTA@mail.gmail.com>
In-Reply-To: <CADnq5_OhhLSfWD5XRkdxbTtOhhCg6a7sSt9m_ON_bocNNs9GTA@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=42c0b9c9-7b8a-42de-a274-00008f839503;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-03-24T02:49:33Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ca7179e6-3bd8-4dca-28e4-08d7cf9e7d0a
x-ms-traffictypediagnostic: MN2PR12MB3263:|MN2PR12MB3263:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB326375865C5F1C922354B527E4F10@MN2PR12MB3263.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 03524FBD26
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(52536014)(55016002)(33656002)(71200400001)(66946007)(6916009)(45080400002)(64756008)(66476007)(66446008)(478600001)(66556008)(76116006)(86362001)(54906003)(6506007)(2906002)(5660300002)(966005)(26005)(9686003)(53546011)(7696005)(316002)(4326008)(186003)(8936002)(8676002)(81156014)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3263;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KWa3L//GIyWmVJ76p8rTv/wSzN6pNFpxtTrQamzetGxjLzR9aNCA2GMf5SwCjhM9SkRh/+wHROmRo98XQEm61BxguukOor6IuSLl/2q3u8SyzueazX15gYsP15JhskezkTyevy0DbQTCKf8xMFwAM8dSUbD0FvvRXuDIPdmNYTjKHkhV3m0mw+D6l/u5ohF6h7/6tiDADp2E0pW94yAseD3wgCp61Xq89vvbIvSVYv+DD8Gys2Bheuo9TMcol8GeJf4jK/06YZfXze4R2Fzw2uVzd8mK/969e65y5x7+BZj2XIl9JKuhbhRXbJ8q1Cz1W6NVLRqJziPwqOTuqzkRw/3WN5GbNJ/6OEUIZ7GKfTBltSIzZp40p/2SBjEx12BotSTM+qBJJoLTlbiaaoTlWq3SwdWxYf4pOls7g8MEskJPUrQliEWVbFXkEc+rXh2X6wdgjbwGDIZNprviHSYbereWhoaP2WNzOnf7VleLoJlqyZX6O5GLLXjCt1ICwiIV
x-ms-exchange-antispam-messagedata: KjDQ3Gi/mlYfJiKLD+dttZM/jQCzb9l+tJmruh5Vjtbh6L2IbAeZ6tM+ejF/aZ/6aWeqMaFMNsr0RNGKF70CefGwK7EWsHzX2pEHw/zCmLE7tkCMzdxZ1tEnRVoG61ulBkm2og5g2Fmnp5Ef/ewWZg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7179e6-3bd8-4dca-28e4-08d7cf9e7d0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2020 02:53:10.3496 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Szr3mYPiBMy5TnwYpSZ8ZOO8pjc/3C4uqsnM7WefW4elM1YQuA/+KRVlRjTLj5lf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3263
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
 "mcoffin13@gmail.com" <mcoffin13@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I have no target to verify that. The only nv10 board on my hand has no dc/ac automatic switch support.
But it should be correct as windows uses the same client and source id per my confirmation.

Regards,
Evan
-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Monday, March 23, 2020 10:47 PM
To: Quan, Evan <Evan.Quan@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; mcoffin13@gmail.com
Subject: Re: [PATCH 8/8] drm/amdgpu/smu11: add support for SMU AC/DC interrupts

On Sun, Mar 22, 2020 at 11:54 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> Thanks Alex. The series is reviewed-by: Evan Quan <evan.quan@amd.com>

Thanks Evan.  Can you verify that the client and source id are correct for the interrupt?  I wasn't able to find them.

Alex

>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of 
> Alex Deucher
> Sent: Saturday, March 21, 2020 2:27 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; 
> mcoffin13@gmail.com
> Subject: [PATCH 8/8] drm/amdgpu/smu11: add support for SMU AC/DC 
> interrupts
>
> Driver needs to send the ack message when it receives the AC/DC interrupt from the SMU.
>
> TODO: verify the client and src ids.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c 
> b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 20174bed11ce..d19e1d0d56c0 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1525,6 +1525,13 @@ int smu_v11_0_set_xgmi_pstate(struct smu_context *smu,
>         return ret;
>  }
>
> +static int smu_v11_0_ack_ac_dc_interrupt(struct smu_context *smu) {
> +       return smu_send_smc_msg(smu,
> +                               SMU_MSG_ReenableAcDcInterrupt,
> +                               NULL); }
> +
>  #define THM_11_0__SRCID__THM_DIG_THERM_L2H             0               /* ASIC_TEMP > CG_THERMAL_INT.DIG_THERM_INTH  */
>  #define THM_11_0__SRCID__THM_DIG_THERM_H2L             1               /* ASIC_TEMP < CG_THERMAL_INT.DIG_THERM_INTL  */
>
> @@ -1558,6 +1565,9 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>                 break;
>
>                 }
> +       } else if (client_id == SOC15_IH_CLIENTID_MP1) {
> +               if (src_id == 0xfe)
> +                       smu_v11_0_ack_ac_dc_interrupt(&adev->smu);
>         }
>
>         return 0;
> @@ -1597,6 +1607,12 @@ int smu_v11_0_register_irq_handler(struct smu_context *smu)
>         if (ret)
>                 return ret;
>
> +       ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
> +                               0xfe,
> +                               irq_src);
> +       if (ret)
> +               return ret;
> +
>         return ret;
>  }
>
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CEv
> an.Quan%40amd.com%7C0738875d4cae44f1574908d7cf3907c6%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637205716159695922&amp;sdata=Yct4d%2ByJkHL
> TXhL9ihK1jr65V8k2CJLlQrDGI4hjJx0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

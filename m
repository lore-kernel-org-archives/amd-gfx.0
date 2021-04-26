Return-Path: <SRS0=K+jV=JX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B584AC433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 06:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D578611CC
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 06:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D578611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B41D89FC9;
	Mon, 26 Apr 2021 06:09:50 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D403589FC9
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Apr 2021 06:09:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZKNItrOW9+SiNIyjQhFf7Ztywa/wpPqiXeCvzfI1nxI9Y8vkVnhnJ1U+yA8C5dGyz6TyfKyEctc3D/bSjLAAjcHGMM0bdFik0qEgEMn9TSWSgE5hxUhvRuckupM+2k5n6IJUGeFxWTiZKBEtQDHxC8TTePleo6VdlG8ujx1ZgODIEr8iggabbUYo9tV3TTt95rqDJ7Qr73b2Z2keYJB78kCd/WwR4FQLd53qjk2lsY8UlOaW9udD1l2wkiLEUli3NA6T2Ln4YbpgoMN0r3sYb0EprpripLqcVDkmKbDguIRugh1IIPvOCkDEgsD6I1hRutADX3D//Q5HGxsDogkpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2GKtI9+yHu8ABpRU1fVzJcg2SMXNXEEdpidia4eQXE=;
 b=ERjFzRiPs2dPl6O8bvRhx2omJHV4gry4xdaDt984L0ftWnB67N8uOa9nobtlo0VH6FkxZiEgKVYqmrzRGKe+UmXAtt6kkMqbD3Szx4k34FVIw6kZGPta9+OzDSxtqmiwz7/jPS79JxIXQYfXZy7BuzSP6DKiIueNsCblfIy/Lqs1HVMPl66EzDOh7KmczyZPeCgrkf3N/ccVnHVGyIDbm3XqMWs2VqSWjvbC63A1mEFJAHh1CkwlwcS1BJHchklmu3GbjP45q2MUlvmY08uLcCGB5yiuBjWCmXrqAVgQ7OEliuOIqbWZu4YoKRLGHcu8ffo1OZqu1UvPdRjNKXsMBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2GKtI9+yHu8ABpRU1fVzJcg2SMXNXEEdpidia4eQXE=;
 b=Pg5c1+QuLoQpKxY8Krka25xuy6tTb8WCf7T50QuSCmdGyE0uQVrVZoHxJQPdJMZV16sslbjqSKulelEXRiwxKmRizuFpURAEV2eAykCWriP2QDlSoOikqxvQdfm1JUvjchN/fWwj2pV4ju3ePQc/MCxy3kzduHIcar7643zeMoQ=
Received: from BY5PR12MB4115.namprd12.prod.outlook.com (2603:10b6:a03:20f::20)
 by BYAPR12MB4630.namprd12.prod.outlook.com (2603:10b6:a03:107::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Mon, 26 Apr
 2021 06:09:45 +0000
Received: from BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1c65:648b:7597:388e]) by BY5PR12MB4115.namprd12.prod.outlook.com
 ([fe80::1c65:648b:7597:388e%2]) with mapi id 15.20.4065.026; Mon, 26 Apr 2021
 06:09:45 +0000
From: "Deng, Emily" <Emily.Deng@amd.com>
To: "Zhao, Victor" <Victor.Zhao@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/sriov: Remove clear vf fw support
Thread-Topic: [PATCH] drm/amdgpu/sriov: Remove clear vf fw support
Thread-Index: AQHXN16XKvw0txBma0eMapWxSJrNCKrGVpGw
Date: Mon, 26 Apr 2021 06:09:45 +0000
Message-ID: <BY5PR12MB411501D0DF3C03B5ED42C4938F429@BY5PR12MB4115.namprd12.prod.outlook.com>
References: <20210422100153.57655-1-Victor.Zhao@amd.com>
In-Reply-To: <20210422100153.57655-1-Victor.Zhao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=5bb880de-3a73-4297-a919-e3e118ac7f39;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-26T06:09:02Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7ef1b69-d2e0-4fd0-32ae-08d90879e409
x-ms-traffictypediagnostic: BYAPR12MB4630:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB4630C5568D3346A1F928816C8F429@BYAPR12MB4630.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ik8myp5pN8WHi3JAMgH+u30BE73uqP+18Ty+SSpOb3jhCJJhWmqIiqzuSQWMGTHdlYNGpCnTmX/6hPpKlrMzBl0nwFWUVtt3SelNTEU2pQN0vPJY1S7I5ezGGGawOfPI4QErJmEB4wSD42WMVNadYOjPdoT1I3qUUbZBC7XB2ZraiUBduPLqlq20JNwue2WGGxdHDC3II0IxsR9tGPfct44b+41YfJMvC5n+wkupayFgsjryl6lpUyf7XdY9Lx8NrGuQF6lmZMDrgSL4MoJkvhNsaRVlV8XtzbW44NqIZdEc3KV2XOfQUsp2uH3NNhVDu0PVtpTSBA7Kp6DWPmWg759Wpo/8fY2DIQUtbA9KUuhz5G32aNSraJ4IMT07DPezOg/GZIoSgxF9Z2tKvAr80NvZCOkM148DlmIPrCDm9ANrE3xE3BzpAb1gDbVum0s+zCDMshYic684P3dmmmrSrk0zEbTX/rLVUXvzVJvScCJMGfw0+qKyYC5mPeeljO3BruQZ3TfciLjetJZbtypnQfu96gis3Zw6IKB+mf/emTQ72HRCJkuqS/lQZzCo21VCzpPr81AvqhxL4eJ+jdQ06ohVnLtqAurTx9C/2ermV8A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(110136005)(83380400001)(76116006)(66946007)(122000001)(55016002)(5660300002)(186003)(8936002)(26005)(7696005)(478600001)(8676002)(6506007)(33656002)(38100700002)(86362001)(52536014)(64756008)(66556008)(66476007)(66446008)(316002)(71200400001)(9686003)(4326008)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?syImEg/pAExRxrWubXrzAdymgnR/IQ391TKP5f7/NmZQfsS5/N3bALp+RoZs?=
 =?us-ascii?Q?Y4AuYzviQ5sBvAaweLCK93+Du/mHG21Q+Gfbef6ZLRl1/bUes52TW1UVtw1L?=
 =?us-ascii?Q?4DbJgD14DbSoXo0dNY6j3mXeGp7whVJBd1mPGW5yLQ5kCvZdEchthI1CfBmY?=
 =?us-ascii?Q?IdqWKdNG2EjFJlCTQ+rxlw/mpnQy7qb9D3fHkjMl9mrOTpAR2FFWLHlLowtM?=
 =?us-ascii?Q?H119uNKAUTh+Sn40rmMAyrrlYPZZctk3VVjJDvnUyK+ealrYX9ExhBXM+dXL?=
 =?us-ascii?Q?hEPTwxDJp5SZLS9wdCfF1q5CjA4uMEeJTV6NmYLqUvvyf/6rjI7ycmYAi6Wn?=
 =?us-ascii?Q?5f0cLqDr1ZxEoOkneC8rAwrhqLV8n6zvInMjyHrSLIsHFiOUxjsvoIumXk8j?=
 =?us-ascii?Q?667K05d2OZLzVNqd0a8eT4j/6cklHkSNQjOSruxXBATMUlqNoSqi9y83oW7T?=
 =?us-ascii?Q?qqFCsE0mjTTkPzCEjGjsT+2MXkPV0WbmTS2+7Dl1FMrmm4W522cuSeOv5t2p?=
 =?us-ascii?Q?K0sYdOauSyPdvHg7qM+ChBPKD2kQkw6QF5hC13V4gN9MBNKxfbay05MCpTP9?=
 =?us-ascii?Q?jxxEaUSuGvdglRdMDjDrxHAAnaHPacnV+doMbqg7EPbIl3gpdYJcvY0s2aDP?=
 =?us-ascii?Q?96X1puNc2xV1JNG9Hj8waOmAyQJzX2ECzHC7sf4n1vCUkWslF65/WI9az8HM?=
 =?us-ascii?Q?LPEswpZunwYFYznbElOOMq0TosCInBwLwTcL/eCrEpZFrH77MuKiM9qflUDG?=
 =?us-ascii?Q?rc3cXhqIzP3PU63V6DkdP0JKipFDMAKRkrpJ6bOKs/E8MZPDqKH2zPaE6h/j?=
 =?us-ascii?Q?nIoZtHy2pM3/IBjUmr2HeWNZMZuf/DZu23MvByYpLjcxfkjBykcYdtJq+9U2?=
 =?us-ascii?Q?L0IgI/i33bek3Vw5C7AOW3ZBmnBspDPdw5cSsuBuGk6trrHobrFfoW4KKnhO?=
 =?us-ascii?Q?8QxseWKNGY6A563S7F5eeYS4On1JvUupxh2u7eHWBtC5tYObwBIB8k3+tFo7?=
 =?us-ascii?Q?A07VyphZuggToDOmbp0Ovm7wrYLINLor8lw131AIq2OJoZmgw7ihC5EYTGiy?=
 =?us-ascii?Q?xMOOn5Mbe5bdrQmxhLJjak5PJLNSM/DEZGjnZEf5FD8YxqPu5gOKEac5CNkZ?=
 =?us-ascii?Q?KuUMeLI8DKl2pKwfhzdOs9EidMLHA7tQYjTsjIs9eVgxc40X8OKkGAwScDpk?=
 =?us-ascii?Q?h7yMlmdnfyD7VxfyJOcea2DQObt9eFiKbvB4+kRTecIle63peqyXCa6Ct1W6?=
 =?us-ascii?Q?kvpPOPPJnZXdgwtmil+oYINBL7v5sS2kh/Pr9KbXv/Gp+aqhhZxb4IHJqrTB?=
 =?us-ascii?Q?r4AZfVA+tut93sPMALRcK6tu?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ef1b69-d2e0-4fd0-32ae-08d90879e409
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 06:09:45.8871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leaN5wxXazn+2vOHvCTJGL0mE2KqHYHdOA4h2NqNb4FpFa/701AhXOxwyU5iLXLv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4630
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
Cc: "Zhao, Victor" <Victor.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Emily Deng <Emily.Deng@amd.com>

>-----Original Message-----
>From: Victor Zhao <Victor.Zhao@amd.com>
>Sent: Thursday, April 22, 2021 6:02 PM
>To: amd-gfx@lists.freedesktop.org; Deng, Emily <Emily.Deng@amd.com>
>Cc: Zhao, Victor <Victor.Zhao@amd.com>
>Subject: [PATCH] drm/amdgpu/sriov: Remove clear vf fw support
>
>PSP clear_vf_fw feature is outdated and has been removed.
>Remove the related functions.
>
>Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 32 -------------------------
>drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h |  1 -
> 2 files changed, 33 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>index 9311dcc94cb6..623044414bb5 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>@@ -417,26 +417,6 @@ static int psp_tmr_init(struct psp_context *psp)
> return ret;
> }
>
>-static int psp_clear_vf_fw(struct psp_context *psp) -{
>-int ret;
>-struct psp_gfx_cmd_resp *cmd;
>-
>-if (!amdgpu_sriov_vf(psp->adev) || psp->adev->asic_type !=
>CHIP_NAVI12)
>-return 0;
>-
>-cmd = kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
>-if (!cmd)
>-return -ENOMEM;
>-
>-cmd->cmd_id = GFX_CMD_ID_CLEAR_VF_FW;
>-
>-ret = psp_cmd_submit_buf(psp, NULL, cmd, psp-
>>fence_buf_mc_addr);
>-kfree(cmd);
>-
>-return ret;
>-}
>-
> static bool psp_skip_tmr(struct psp_context *psp)  {
> switch (psp->adev->asic_type) {
>@@ -1925,12 +1905,6 @@ static int psp_hw_start(struct psp_context *psp)
> return ret;
> }
>
>-ret = psp_clear_vf_fw(psp);
>-if (ret) {
>-DRM_ERROR("PSP clear vf fw!\n");
>-return ret;
>-}
>-
> ret = psp_boot_config_set(adev);
> if (ret) {
> DRM_WARN("PSP set boot config@\n");
>@@ -2439,7 +2413,6 @@ static int psp_hw_fini(void *handle)  {
> struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> struct psp_context *psp = &adev->psp;
>-int ret;
>
> if (psp->adev->psp.ta_fw) {
> psp_ras_terminate(psp);
>@@ -2450,11 +2423,6 @@ static int psp_hw_fini(void *handle)
> }
>
> psp_asd_unload(psp);
>-ret = psp_clear_vf_fw(psp);
>-if (ret) {
>-DRM_ERROR("PSP clear vf fw!\n");
>-return ret;
>-}
>
> psp_tmr_terminate(psp);
> psp_ring_destroy(psp, PSP_RING_TYPE__KM); diff --git
>a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
>b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
>index 96064c343163..f6d3180febc4 100644
>--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
>+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
>@@ -97,7 +97,6 @@ enum psp_gfx_cmd_id
>     GFX_CMD_ID_SETUP_VMR          = 0x00000009,   /* setup VMR region */
>     GFX_CMD_ID_DESTROY_VMR        = 0x0000000A,   /* destroy VMR region
>*/
>     GFX_CMD_ID_PROG_REG           = 0x0000000B,   /* program regs */
>-    GFX_CMD_ID_CLEAR_VF_FW        = 0x0000000D,   /* Clear VF FW, to be
>used on VF shutdown. */
>     GFX_CMD_ID_GET_FW_ATTESTATION = 0x0000000F,   /* Query GPUVA of
>the Fw Attestation DB */
>     /* IDs upto 0x1F are reserved for older programs (Raven, Vega 10/12/20)
>*/
>     GFX_CMD_ID_LOAD_TOC           = 0x00000020,   /* Load TOC and obtain
>TMR size */
>--
>2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

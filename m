Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1481C4743C
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 01:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B10F61040
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 01:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B10F61040
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F0316E046;
	Tue, 22 Jun 2021 01:31:02 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2078.outbound.protection.outlook.com [40.107.96.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D17F6E046
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 01:31:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYihnFtaVopCgdLt6qbJ6JsWtSpB1IdDFAIDOfuELJK2Hf/RsJ1wTD1Vmj2TJq0rtzRi9GBqrnBnEVUrPWtnmFCT+VafWTncnRkdY+UCUaJ5GWlczKJNW+YMV37WM3aviPn4B5Zndr+SDBf53jUPEGwBL8eJzwOVKRGa0UEh+NV/4c4G0RILtT0dpHp95RNdIFtJ4NJtKGXcleDj81BnaIoA97mwJAP8aCiREbSr58qMWwmqpoWEp9q2KHk8ortgvGZ9tNG15wlMYh82eGEGHd2HvUnMvlK3XA4KV2ePoMEtbwpEwnN6TrSKVyNJmVc7sNeMD7KmRGeibgwVMkxckg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOP1Op9We+O6IMyeeUu5xx5Eog5jbb31/td9JdV8h5A=;
 b=PvHmm9Pi2eTlT1vy3BeIZrVPUcTrd0RVnV9LqpA21W6G3rsGewJEegbnMUdpTK9YaYI06YUndDKuGj5jCFfhxx+B8wBEUlShRGnWTetqKwx8eOIgrm7mXU3U31CH3RBl6I/Z2QHU0AnKIQ5IbJkYyhASPKnO1N7e0N25ZvgXC3ghNTEc9e0s1eSWXgrKC9YNjOcZG9eyz4oh+BT282OCzvQLF84mtjVsJNabFFEK7boK9Rlq8m7NAFV/93qmrjNOdi1XpdevRkd/MqWBZpQwePptQQ7GmeGWrHODbAXnGXDrZc6mCMD8GNLWMe0s/kZw72YZtOt7ADOq6VRuUJq42A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOP1Op9We+O6IMyeeUu5xx5Eog5jbb31/td9JdV8h5A=;
 b=MuA3JYJsmD/BmTSxHo+mrBf18tDFlSZfxBQsxVBRYDxsFC/SGTzPgP3evh2Gq3mHWWrIBvb8ytBHhx9BDbsLZuJ1/9ysEqGC/nZpcwtHz89NV0CfloFg72C67hegdSG/VQF/KtDsBMDbo+LM0HNLhYSx7J0bEXJzQCEIig5qKik=
Received: from DM5PR12MB4679.namprd12.prod.outlook.com (2603:10b6:4:a2::37) by
 DM5PR1201MB2507.namprd12.prod.outlook.com (2603:10b6:3:e9::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.21; Tue, 22 Jun 2021 01:30:58 +0000
Received: from DM5PR12MB4679.namprd12.prod.outlook.com
 ([fe80::b5bc:c121:c4e9:d4ea]) by DM5PR12MB4679.namprd12.prod.outlook.com
 ([fe80::b5bc:c121:c4e9:d4ea%6]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 01:30:58 +0000
From: "Cornij, Nikola" <Nikola.Cornij@amd.com>
To: "Liu, Zhan" <Zhan.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Enabling eDP no power sequencing with
 DAL feature mask
Thread-Topic: [PATCH] drm/amd/display: Enabling eDP no power sequencing with
 DAL feature mask
Thread-Index: AddnA9EwMkD2iF5JRRSEtqinE3pAmwAAhUdm
Date: Tue, 22 Jun 2021 01:30:58 +0000
Message-ID: <DM5PR12MB46796EC7A35F94A3BF752420EE099@DM5PR12MB4679.namprd12.prod.outlook.com>
References: <DM4PR12MB521425D1F9F673AE63ECFC789E099@DM4PR12MB5214.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB521425D1F9F673AE63ECFC789E099@DM4PR12MB5214.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-22T01:30:57.648Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13969cd2-a64c-44db-4bf5-08d9351d6361
x-ms-traffictypediagnostic: DM5PR1201MB2507:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB2507B90F1BF555DE4FA1778DEE099@DM5PR1201MB2507.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UtHoEHa2h6fXZebekLuQObVzQUXibu/XRQy9B+UJ49kUqEfSE3fcLnjlfJVK99j1/3o0SHBpvqRWw/EioMkhbw+UJ4XLKBGUiGVAJ6pl+fWBf+ws3UXbQ/7xwr9CHJ3wXEFMD8PaG2l0eqwOR6RvRsJtZSxmcI4qIE2L9dT+daCCCsjgs45c49BzvHvtac+6u6k3ymSu4GNtPIkANF3AILo3I8gqswxPC1H5OPFYDu0qV7roiwFPwNbVxim5PNke612Ry+OlVGd/4Ar1VML12YiJWjXFkCKQ/IC8xCbo7ZFgz4Td4w+ynVvyrt1Lx+/1iLfKUJa6hcXcwm2M5W80yYF6FOnisp3sSWl/oHklAjWP6ZcibJuCsu/m+vFIT9tJki8uYUNewUyQG5QF91zjKqYn6A+/Od9dk1J4uMHw+U8XmC63vxAzWEGGxlCTVd2L0OrFHcEfsbSrSleJ0aQx1DBc0WWwsSF1NNS/YvQ7c5OCCcjzUI/sMXPUcJDjsG3hMkchtXkSCELJmOmnPvwKp84E87RD67R4jXoFSnqS1RLnE6l8RW9l7AlVfAokkpb4cQuXBeDHZntNy2R9OOHhxBqfHc/oyQliAxb9vr1XPIk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4679.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(55016002)(110136005)(186003)(38100700002)(66556008)(64756008)(6506007)(19627405001)(66446008)(91956017)(66476007)(5660300002)(8936002)(66946007)(122000001)(76116006)(33656002)(52536014)(478600001)(26005)(83380400001)(7696005)(71200400001)(316002)(9686003)(8676002)(86362001)(2906002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/HPBGR4nGKsQfatIuYiuk5zgsm0oTb8cwJnRlojQGsxDvKhFUY8xrMgi0W?=
 =?iso-8859-1?Q?+cGXw8kEV6b+ZMtE3BJOllD311oRywwsjwpEaIiLQfp/FIMKrFge8AQT6i?=
 =?iso-8859-1?Q?Xx+j5YWFiG2Lr3KDEG+6ijzngyyUflcPXZxsbWRt6EUobvvYEZnKcGXMw9?=
 =?iso-8859-1?Q?zS2LnYd0/WGL30DeAT9CdvYMZ6QKbmCXYsI60OP63duOd1pT3fZpaZJxb8?=
 =?iso-8859-1?Q?N9JboaPxkQsIV6EbXc+eigK89LIlrenVySbNnnpbWUki3Vx592OVT2J9/e?=
 =?iso-8859-1?Q?KGzlqhq88lbbbw1fyyRsaSsE9HySyjuB0B/hg5bLXJoNT2x5XB8N+SngkU?=
 =?iso-8859-1?Q?xSD1N1dkBsuTGT5Slj6FHC7V0SY1hZUzr51nuSh6jeVde5c4omGjG3rJJ0?=
 =?iso-8859-1?Q?5mywBGz/DKCDDl6uxz1X1ZGvzzr+7BY7vURMjH0nHa1xE+ZOZVt7yxDPAb?=
 =?iso-8859-1?Q?2f7K4sjogxKbDwfZA0mTF6BGboJI3OK1+xEzM74Sy9pwMDbrZKb113I4mY?=
 =?iso-8859-1?Q?A5CeFwgv7DUSKLIDlNi8Zh5kRPokde+RXIAqHyq1PsAkRUFhHqwdAeMroG?=
 =?iso-8859-1?Q?UL+YWMJZWywAZ+9a8fzxVCy1cyOdZ3R9OvR91yfnqfnTkaCJWNPbDHljyM?=
 =?iso-8859-1?Q?hvxu8tDJEE5k58KHciFxHARCEN9uC33yT8WD8Z057FUDtGyVPlWJlH/AN+?=
 =?iso-8859-1?Q?3AjxTOYB7r7yTU3+//o1h4L6jzByu04V/6QSlkrGxMPcXNeK76aC6sy2y4?=
 =?iso-8859-1?Q?XwLRi6rn+QNTF4EHGz5aKyMw2A3W3U9RkB+3JyrRkIRlw3fkrTkuwNFI2i?=
 =?iso-8859-1?Q?XorwuMy8NiVitvLl8jFnoraCAc9B0KptMeJ68blg2aYo3PxC0NOAWSrABN?=
 =?iso-8859-1?Q?8RgBPvY0C7PnWP0pCuoZoscvc5A9kWYgjKQCbfsMtWweEBjdngADflTWYq?=
 =?iso-8859-1?Q?pJpPOtNVgSuHK8+rtdKRNpBB36i3PGGbGDrSi/7MBRzT5XX4rXweVElX39?=
 =?iso-8859-1?Q?NAWbUV+83svdaK+bfxMtC+G1B9OCo1TiYcl1rxZt9ZfnYnCy814SfeUDIW?=
 =?iso-8859-1?Q?P3Yh5GUQXIr3T4xq/hZ8BaJFGze1Ve4RnLdbLp7DNCjNUh7UFB/Z84WYRB?=
 =?iso-8859-1?Q?X7c01hAMiuOPMYJ/JdGP29+n4xOBW9FAuk4mQDXZrl9yKOf0Vl+9isOlTr?=
 =?iso-8859-1?Q?lCiBaKL1bWm6FJ7FYYhczAuEeeY6Op5nHzP4KOM6RKraunQoessKTuOJhQ?=
 =?iso-8859-1?Q?3NFcZe7QFrYhsxcRFC7VzmFqRc1mIqLxkC/uLsUdN6X9a+5t8L64GoC5ZC?=
 =?iso-8859-1?Q?MTecVu9ksnWW2i6yGxKMCF/MwdRu6sfgSVkM7cpdupakZPU=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4679.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13969cd2-a64c-44db-4bf5-08d9351d6361
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 01:30:58.6350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DD2LwS9Yz46yCK4islYfXHvRUbxQ0s6uUMFwQNUmBWgZxQbKGDt5IPauiEycAmRgQ4uolUIrKeAfy/ZXusD3kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2507
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
Cc: "Liu, Charlene" <Charlene.Liu@amd.com>
Content-Type: multipart/mixed; boundary="===============1831760629=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1831760629==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB46796EC7A35F94A3BF752420EE099DM5PR12MB4679namp_"

--_000_DM5PR12MB46796EC7A35F94A3BF752420EE099DM5PR12MB4679namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]



>From: Liu, Zhan <Zhan.Liu@amd.com>
>Sent: Monday, June 21, 2021 9:13 PM
>To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Cornij,=
 Nikola <Nikola.Cornij@amd.com>
>Cc: Liu, Charlene <Charlene.Liu@amd.com>
>Subject: [PATCH] drm/amd/display: Enabling eDP no power sequencing with DA=
L feature mask
>
>[Public]
>
>[Why]
>Sometimes, DP receiver chip power-controlled externally by an
>Embedded Controller could be treated and used as eDP,
>if it drives mobile display. In this case,
>we shouldn't be doing power-sequencing, hence we can skip
>waiting for T7-ready and T9-ready."
>
>[How]
>Added a feature mask to enable eDP no power sequencing feature.
>
>To enable this, set 0x10 flag in amdgpu.dcfeaturemask on
>Linux command line.
>
>Signed-off-by: Zhan Liu <zhan.liu@amd.com>
Reviewed-by: Nikola Cornij <Nikola.Cornij@amd.com>
>Change-Id: I15e8fb2979fe3ff5491ccf1ee384693d4dce787c
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
> .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 ++
> drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
> .../display/dc/dce110/dce110_hw_sequencer.c   | 31 ++++++++++++++++---
> drivers/gpu/drm/amd/include/amd_shared.h      | 10 +++---
> 5 files changed, 38 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_drv.c
>index 3de1accb060e..b588cf4398db 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>@@ -159,6 +159,7 @@ int amdgpu_smu_pptable_id =3D -1;
>  *     highest. That helps saving some idle power.
>  * DISABLE_FRACTIONAL_PWM (bit 2) disabled by default
>  * PSR (bit 3) disabled by default
>+ * EDP NO POWER SEQUENCING (bit 4) disabled by default
>  */
> uint amdgpu_dc_feature_mask =3D 2;
> uint amdgpu_dc_debug_mask;
>diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/g=
pu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>index c0a3119982b0..abba26c8f20a 100644
>--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>@@ -1174,6 +1174,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev=
)
>        if (amdgpu_dc_feature_mask & DC_DISABLE_FRACTIONAL_PWM_MASK)
>                init_data.flags.disable_fractional_pwm =3D true;
>
>+       if (amdgpu_dc_feature_mask & DC_EDP_NO_POWER_SEQUENCING)
>+               init_data.flags.edp_no_power_sequencing =3D true;
>+
>        init_data.flags.power_down_display_on_boot =3D true;
>
>        INIT_LIST_HEAD(&adev->dm.da_list);
>diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/dis=
play/dc/dc.h
>index a70697898025..7f1d2d6f9de8 100644
>--- a/drivers/gpu/drm/amd/display/dc/dc.h
>+++ b/drivers/gpu/drm/amd/display/dc/dc.h
>@@ -297,6 +297,7 @@ struct dc_config {
>        bool allow_seamless_boot_optimization;
>        bool power_down_display_on_boot;
>        bool edp_not_connected;
>+       bool edp_no_power_sequencing;
>        bool force_enum_edp;
>        bool forced_clocks;
>        bool allow_lttpr_non_transparent_mode;
>diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b=
/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>index 53dd305fa6b0..013d94c9506a 100644
>--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>@@ -1023,8 +1023,20 @@ void dce110_edp_backlight_control(
>        /* dc_service_sleep_in_milliseconds(50); */
>                /*edp 1.2*/
>        panel_instance =3D link->panel_cntl->inst;
>-       if (cntl.action =3D=3D TRANSMITTER_CONTROL_BACKLIGHT_ON)
>-               edp_receiver_ready_T7(link);
>+
>+       if (cntl.action =3D=3D TRANSMITTER_CONTROL_BACKLIGHT_ON) {
>+               if (!link->dc->config.edp_no_power_sequencing)
>+               /*
>+                * Sometimes, DP receiver chip power-controlled externally=
 by an
>+                * Embedded Controller could be treated and used as eDP,
>+                * if it drives mobile display. In this case,
>+                * we shouldn't be doing power-sequencing, hence we can sk=
ip
>+                * waiting for T7-ready.
>+                */
>+                       edp_receiver_ready_T7(link);
>+               else
>+                       DC_LOG_DC("edp_receiver_ready_T7 skipped\n");
>+       }
>
>        if (ctx->dc->ctx->dmub_srv &&
>                        ctx->dc->debug.dmub_command_table) {
>@@ -1049,8 +1061,19 @@ void dce110_edp_backlight_control(
>                dc_link_backlight_enable_aux(link, enable);
>
>        /*edp 1.2*/
>-       if (cntl.action =3D=3D TRANSMITTER_CONTROL_BACKLIGHT_OFF)
>-               edp_add_delay_for_T9(link);
>+       if (cntl.action =3D=3D TRANSMITTER_CONTROL_BACKLIGHT_OFF) {
>+               if (!link->dc->config.edp_no_power_sequencing)
>+               /*
>+                * Sometimes, DP receiver chip power-controlled externally=
 by an
>+                * Embedded Controller could be treated and used as eDP,
>+                * if it drives mobile display. In this case,
>+                * we shouldn't be doing power-sequencing, hence we can sk=
ip
>+                * waiting for T9-ready.
>+                */
>+                       edp_add_delay_for_T9(link);
>+               else
>+                       DC_LOG_DC("edp_receiver_ready_T9 skipped\n");
>+       }
>
>        if (!enable && link->dpcd_sink_ext_caps.bits.oled)
>                msleep(OLED_PRE_T11_DELAY);
>diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/am=
d/include/amd_shared.h
>index 9ab706cd07ff..d326339cb3cd 100644
>--- a/drivers/gpu/drm/amd/include/amd_shared.h
>+++ b/drivers/gpu/drm/amd/include/amd_shared.h
>@@ -223,10 +223,12 @@ enum amd_harvest_ip_mask {
> };
>
> enum DC_FEATURE_MASK {
>-       DC_FBC_MASK =3D 0x1,
>-       DC_MULTI_MON_PP_MCLK_SWITCH_MASK =3D 0x2,
>-       DC_DISABLE_FRACTIONAL_PWM_MASK =3D 0x4,
>-       DC_PSR_MASK =3D 0x8,
>+       //Default value can be found at "uint amdgpu_dc_feature_mask"
>+       DC_FBC_MASK =3D (1 << 0), //0x1, disabled by default
>+       DC_MULTI_MON_PP_MCLK_SWITCH_MASK =3D (1 << 1), //0x2, enabled by d=
efault
>+       DC_DISABLE_FRACTIONAL_PWM_MASK =3D (1 << 2), //0x4, disabled by de=
fault
>+       DC_PSR_MASK =3D (1 << 3), //0x8, disabled by default
>+       DC_EDP_NO_POWER_SEQUENCING =3D (1 << 4), //0x10, disabled by defau=
lt
> };
>
> enum DC_DEBUG_MASK {
>--
>2.25.1


--_000_DM5PR12MB46796EC7A35F94A3BF752420EE099DM5PR12MB4679namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
</div>
<div><br>
</div>
<div><br>
</div>
<div>&gt;From: Liu, Zhan &lt;Zhan.Liu@amd.com&gt;</div>
<div>&gt;Sent: Monday, June 21, 2021 9:13 PM</div>
<div>&gt;To: amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.or=
g&gt;; Cornij, Nikola &lt;Nikola.Cornij@amd.com&gt;</div>
<div>&gt;Cc: Liu, Charlene &lt;Charlene.Liu@amd.com&gt;</div>
<div>&gt;Subject: [PATCH] drm/amd/display: Enabling eDP no power sequencing=
 with DAL feature mask</div>
<div>&gt; </div>
<div>&gt;[Public]</div>
<div>&gt;</div>
<div>&gt;[Why]</div>
<div>&gt;Sometimes, DP receiver chip power-controlled externally by an</div=
>
<div>&gt;Embedded Controller could be treated and used as eDP,</div>
<div>&gt;if it drives mobile display. In this case,</div>
<div>&gt;we shouldn't be doing power-sequencing, hence we can skip</div>
<div>&gt;waiting for T7-ready and T9-ready.&quot;</div>
<div>&gt;</div>
<div>&gt;[How]</div>
<div>&gt;Added a feature mask to enable eDP no power sequencing feature.</d=
iv>
<div>&gt;</div>
<div>&gt;To enable this, set 0x10 flag in amdgpu.dcfeaturemask on</div>
<div>&gt;Linux command line.</div>
<div>&gt;</div>
<div>&gt;Signed-off-by: Zhan Liu &lt;zhan.liu@amd.com&gt;</div>
<div>Reviewed-by: Nikola Cornij &lt;Nikola.Cornij@amd.com&gt;</div>
<div>&gt;Change-Id: I15e8fb2979fe3ff5491ccf1ee384693d4dce787c</div>
<div>&gt;---</div>
<div>&gt; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c &nbsp; &nbsp; &nbsp; | &n=
bsp;1 +</div>
<div>&gt; .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | &nbsp;3 ++</div>
<div>&gt; drivers/gpu/drm/amd/display/dc/dc.h &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; | &nbsp;1 +</div>
<div>&gt; .../display/dc/dce110/dce110_hw_sequencer.c &nbsp; | 31 +++++++++=
+++++++---</div>
<div>&gt; drivers/gpu/drm/amd/include/amd_shared.h &nbsp; &nbsp; &nbsp;| 10=
 +++---</div>
<div>&gt; 5 files changed, 38 insertions(+), 8 deletions(-)</div>
<div>&gt;</div>
<div>&gt;diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_drv.c</div>
<div>&gt;index 3de1accb060e..b588cf4398db 100644</div>
<div>&gt;--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c</div>
<div>&gt;+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c</div>
<div>&gt;@@ -159,6 +159,7 @@ int amdgpu_smu_pptable_id =3D -1;</div>
<div>&gt; &nbsp;* &nbsp; &nbsp; highest. That helps saving some idle power.=
</div>
<div>&gt; &nbsp;* DISABLE_FRACTIONAL_PWM (bit 2) disabled by default</div>
<div>&gt; &nbsp;* PSR (bit 3) disabled by default</div>
<div>&gt;+ * EDP NO POWER SEQUENCING (bit 4) disabled by default</div>
<div>&gt; &nbsp;*/</div>
<div>&gt; uint amdgpu_dc_feature_mask =3D 2;</div>
<div>&gt; uint amdgpu_dc_debug_mask;</div>
<div>&gt;diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c</div>
<div>&gt;index c0a3119982b0..abba26c8f20a 100644</div>
<div>&gt;--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c</div>
<div>&gt;+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c</div>
<div>&gt;@@ -1174,6 +1174,9 @@ static int amdgpu_dm_init(struct amdgpu_devi=
ce *adev)</div>
<div>&gt; &nbsp; &nbsp; &nbsp; &nbsp;if (amdgpu_dc_feature_mask &amp; DC_DI=
SABLE_FRACTIONAL_PWM_MASK)</div>
<div>&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;init_data.=
flags.disable_fractional_pwm =3D true;</div>
<div>&gt;</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; if (amdgpu_dc_feature_mask &amp; DC_EDP_NO_=
POWER_SEQUENCING)</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; init_data.flags=
.edp_no_power_sequencing =3D true;</div>
<div>&gt;+</div>
<div>&gt; &nbsp; &nbsp; &nbsp; &nbsp;init_data.flags.power_down_display_on_=
boot =3D true;</div>
<div>&gt;</div>
<div>&gt; &nbsp; &nbsp; &nbsp; &nbsp;INIT_LIST_HEAD(&amp;adev-&gt;dm.da_lis=
t);</div>
<div>&gt;diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm=
/amd/display/dc/dc.h</div>
<div>&gt;index a70697898025..7f1d2d6f9de8 100644</div>
<div>&gt;--- a/drivers/gpu/drm/amd/display/dc/dc.h</div>
<div>&gt;+++ b/drivers/gpu/drm/amd/display/dc/dc.h</div>
<div>&gt;@@ -297,6 +297,7 @@ struct dc_config {</div>
<div>&gt; &nbsp; &nbsp; &nbsp; &nbsp;bool allow_seamless_boot_optimization;=
</div>
<div>&gt; &nbsp; &nbsp; &nbsp; &nbsp;bool power_down_display_on_boot;</div>
<div>&gt; &nbsp; &nbsp; &nbsp; &nbsp;bool edp_not_connected;</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; bool edp_no_power_sequencing;</div>
<div>&gt; &nbsp; &nbsp; &nbsp; &nbsp;bool force_enum_edp;</div>
<div>&gt; &nbsp; &nbsp; &nbsp; &nbsp;bool forced_clocks;</div>
<div>&gt; &nbsp; &nbsp; &nbsp; &nbsp;bool allow_lttpr_non_transparent_mode;=
</div>
<div>&gt;diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_seque=
ncer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c</div>
<div>&gt;index 53dd305fa6b0..013d94c9506a 100644</div>
<div>&gt;--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c<=
/div>
<div>&gt;+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c<=
/div>
<div>&gt;@@ -1023,8 +1023,20 @@ void dce110_edp_backlight_control(</div>
<div>&gt; &nbsp; &nbsp; &nbsp; &nbsp;/* dc_service_sleep_in_milliseconds(50=
); */</div>
<div>&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/*edp 1.2*=
/</div>
<div>&gt; &nbsp; &nbsp; &nbsp; &nbsp;panel_instance =3D link-&gt;panel_cntl=
-&gt;inst;</div>
<div>&gt;- &nbsp; &nbsp; &nbsp; if (cntl.action =3D=3D TRANSMITTER_CONTROL_=
BACKLIGHT_ON)</div>
<div>&gt;- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; edp_receiver_re=
ady_T7(link);</div>
<div>&gt;+</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; if (cntl.action =3D=3D TRANSMITTER_CONTROL_=
BACKLIGHT_ON) {</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (!link-&gt;d=
c-&gt;config.edp_no_power_sequencing)</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* Sometim=
es, DP receiver chip power-controlled externally by an</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* Embedde=
d Controller could be treated and used as eDP,</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* if it d=
rives mobile display. In this case,</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* we shou=
ldn't be doing power-sequencing, hence we can skip</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* waiting=
 for T7-ready.</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; edp_receiver_ready_T7(link);</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; else</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; DC_LOG_DC(&quot;edp_receiver_ready_T7 skipped\n&quot;);</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; }</div>
<div>&gt;</div>
<div>&gt; &nbsp; &nbsp; &nbsp; &nbsp;if (ctx-&gt;dc-&gt;ctx-&gt;dmub_srv &a=
mp;&amp;</div>
<div>&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp;ctx-&gt;dc-&gt;debug.dmub_command_table) {</div>
<div>&gt;@@ -1049,8 +1061,19 @@ void dce110_edp_backlight_control(</div>
<div>&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;dc_link_ba=
cklight_enable_aux(link, enable);</div>
<div>&gt;</div>
<div>&gt; &nbsp; &nbsp; &nbsp; &nbsp;/*edp 1.2*/</div>
<div>&gt;- &nbsp; &nbsp; &nbsp; if (cntl.action =3D=3D TRANSMITTER_CONTROL_=
BACKLIGHT_OFF)</div>
<div>&gt;- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; edp_add_delay_f=
or_T9(link);</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; if (cntl.action =3D=3D TRANSMITTER_CONTROL_=
BACKLIGHT_OFF) {</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (!link-&gt;d=
c-&gt;config.edp_no_power_sequencing)</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; /*</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* Sometim=
es, DP receiver chip power-controlled externally by an</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* Embedde=
d Controller could be treated and used as eDP,</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* if it d=
rives mobile display. In this case,</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* we shou=
ldn't be doing power-sequencing, hence we can skip</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* waiting=
 for T9-ready.</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; edp_add_delay_for_T9(link);</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; else</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; DC_LOG_DC(&quot;edp_receiver_ready_T9 skipped\n&quot;);</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; }</div>
<div>&gt;</div>
<div>&gt; &nbsp; &nbsp; &nbsp; &nbsp;if (!enable &amp;&amp; link-&gt;dpcd_s=
ink_ext_caps.bits.oled)</div>
<div>&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;msleep(OLE=
D_PRE_T11_DELAY);</div>
<div>&gt;diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gp=
u/drm/amd/include/amd_shared.h</div>
<div>&gt;index 9ab706cd07ff..d326339cb3cd 100644</div>
<div>&gt;--- a/drivers/gpu/drm/amd/include/amd_shared.h</div>
<div>&gt;+++ b/drivers/gpu/drm/amd/include/amd_shared.h</div>
<div>&gt;@@ -223,10 +223,12 @@ enum amd_harvest_ip_mask {</div>
<div>&gt; };</div>
<div>&gt;</div>
<div>&gt; enum DC_FEATURE_MASK {</div>
<div>&gt;- &nbsp; &nbsp; &nbsp; DC_FBC_MASK =3D 0x1,</div>
<div>&gt;- &nbsp; &nbsp; &nbsp; DC_MULTI_MON_PP_MCLK_SWITCH_MASK =3D 0x2,</=
div>
<div>&gt;- &nbsp; &nbsp; &nbsp; DC_DISABLE_FRACTIONAL_PWM_MASK =3D 0x4,</di=
v>
<div>&gt;- &nbsp; &nbsp; &nbsp; DC_PSR_MASK =3D 0x8,</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; //Default value can be found at &quot;uint =
amdgpu_dc_feature_mask&quot;</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; DC_FBC_MASK =3D (1 &lt;&lt; 0), //0x1, disa=
bled by default</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; DC_MULTI_MON_PP_MCLK_SWITCH_MASK =3D (1 &lt=
;&lt; 1), //0x2, enabled by default</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; DC_DISABLE_FRACTIONAL_PWM_MASK =3D (1 &lt;&=
lt; 2), //0x4, disabled by default</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; DC_PSR_MASK =3D (1 &lt;&lt; 3), //0x8, disa=
bled by default</div>
<div>&gt;+ &nbsp; &nbsp; &nbsp; DC_EDP_NO_POWER_SEQUENCING =3D (1 &lt;&lt; =
4), //0x10, disabled by default</div>
<div>&gt; };</div>
<div>&gt;</div>
<div>&gt; enum DC_DEBUG_MASK {</div>
<div>&gt;--</div>
&gt;2.25.1
<div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt">
<div><font size=3D"2"><span style=3D"font-size:11pt"><br>
</span></font></div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB46796EC7A35F94A3BF752420EE099DM5PR12MB4679namp_--

--===============1831760629==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1831760629==--

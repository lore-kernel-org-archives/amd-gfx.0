Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF78C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 02:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C588210E0F2;
	Mon, 28 Mar 2022 02:22:31 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2075.outbound.protection.outlook.com [40.107.102.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEC3710E0F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 02:22:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXuLEpeAe5EoSRvQCS7PgJw1ZWoJxGDqhRXCqPhIOkiqrE25mBUhoG4hzL84hldY3m95Rz3br6kznDgHo6cLDHs2j8ciJFDf5cHclJcEnGVfma7pDZCMMLPt8WcnyIrVqLitOnofHeDWlZBtkUq4/IvDBZGglu8mqst13V52qOF+g8e/wm3j8YfUMIgr1OOAsS89I97VHRdXOfBF1Rh9200B79OwPtmKfOKgZCJdKar8V/0Al/6ZuGBVRtpmcSqzIG8p8QKqrcMKk6whLwLsSYstOT4/We84bOokkXyciECh1sy0rZJcMyQjoFyzT+ZNaIB1eyhiQwxT9VVz7Pc4kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFHlwtMUXs8aP6XXfBbfn/brMUhAmHadi/F9U7Zfjec=;
 b=WykOV0mW7bTrKmi3NqC5jPKvJOrSC16561QcrH+PByLEzgphQJtKFasRzhVJn0DE8wewbLprx14FmtSxmLXET4mjJToe43lj73l/qFbOQLIOboq4Eb3lNcM3WxRftuFEOGzayvBjW/jMs8OiSLJbtbFDcppODvfVXldA5BRVC+kZs8jIbvJbf/ZgOfZBjpeGg+3MO0Hz0FkE3bPWIMexetrAn0pX7hjZt2Z3M+U29h3nFYlAdSOQJRWFjP/vGGHPxFXqmyp66qA5fOWSpWCgn6L6GTTwljdTh0sYno36sbs6OonKw2MRNO8F54c/bRd6+At05lnQcfQ9ZErnt2UqSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFHlwtMUXs8aP6XXfBbfn/brMUhAmHadi/F9U7Zfjec=;
 b=Y2seQbJDSOsles5Whu04BJSw5+g2sXC9lAZmgthebFS1WdOZHchCoaFLMAUPtS/aewIzhJi6BBksZfOolf32qNTEFJKmie5PpjqzA7Mb+p7ivwiBoIopLR21yfmeAJLjLHmvNLezuzQjUP2noXp5h0/IEC+3LcQ+MC0c4yRt/Nk=
Received: from DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15)
 by BN6PR12MB1731.namprd12.prod.outlook.com (2603:10b6:404:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 02:22:28 +0000
Received: from DM4PR12MB5294.namprd12.prod.outlook.com
 ([fe80::f941:9dfe:5e3e:853c]) by DM4PR12MB5294.namprd12.prod.outlook.com
 ([fe80::f941:9dfe:5e3e:853c%4]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 02:22:27 +0000
From: "Yin, Tianci (Rico)" <Tianci.Yin@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0
Thread-Topic: [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0
Thread-Index: AQHYQcx5kAspmLeO7UCx68wx8Sn0zqzUAe6AgAAOa4CAAAB+Fw==
Date: Mon, 28 Mar 2022 02:22:27 +0000
Message-ID: <DM4PR12MB5294485E930EAE1E23F13C85951D9@DM4PR12MB5294.namprd12.prod.outlook.com>
References: <20220327111857.1372675-1-tianci.yin@amd.com>
 <DM5PR12MB2469F8E803B628080BD1A247F11D9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <DM5PR12MB2469B027D59B5151A41075EDF11D9@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469B027D59B5151A41075EDF11D9@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-28T02:22:27.980Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: 4647b3a5-70db-5857-af6e-3b18831034a8
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7dbc53d2-ee5c-45bb-80c7-08da1061cdf9
x-ms-traffictypediagnostic: BN6PR12MB1731:EE_
x-microsoft-antispam-prvs: <BN6PR12MB173126B0924E87938911DD44951D9@BN6PR12MB1731.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lKLn4T8rd9ilag+vuQy0DX+IyHNmnNxe5prXOIuVDjikQKvUUT9fMfXUuDTX16eQish2EVV4n41WiostbNX29MtUIPGAsGEh7+iq6hzl5wGPBFYd4xDFFrNIJ9HjzhNlg8TJveEZ0pXfG6/pc6yPh5gKiL4oJ6YOorLZlJEwM5S7oRxzQ7n1T9cBSVa3jSZpC/GTIb4uPpjvp5Fx6vQRV2CqNiHWXHCfk2SJ61FNKfP4RIs2WQwu4j8Cu6f60fEMl/BujarRgSUoBw2ppaot8CSChlOE0JJ7y22/m53GVwoJu9+4TAPaR/RM8PRVqbeCRfnR62dyFyVx4Cus47f3hISuDt0IhvPm+wsoxMouJ88oRmfMn9em8PFsr50YggFjqOXxGrx2kA3iBu6mV/v3WYWwjxQo/NoTHVIviaB4vwS7QcewENUjMbee8jMvPIYsuJI7Qj4TnbL5tfsouyc7zjSW07a/ZyIlrXBEDVa7Z+zRLX7oCwls0dI6ORh/b0qOEtb7dzoIvPnODhVz1s+JUhnVLW371TNjJ5Nq86qjMFBBGaGdh5dEy69Fnn4wpxOXlDLBc8dguKnNvbzQnTPRsaRh0Vlg7QuMMwe8wQV/4zQ53ak6v+fZsA595AJuXLLjrYH574HrTAgGEImhS2wFE5ADD6prhYrIZJekdir6zKdbDPOxWZ1g5f9OWXLt6NxBKFV3/qhH/izGuLz5V1vthQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5294.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(52536014)(91956017)(5660300002)(6506007)(33656002)(2906002)(66556008)(66446008)(76116006)(64756008)(4326008)(83380400001)(55016003)(53546011)(122000001)(66476007)(26005)(86362001)(7696005)(8936002)(66946007)(9686003)(316002)(186003)(71200400001)(38100700002)(508600001)(19627405001)(38070700005)(110136005)(8676002)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3kILs7K70avZsVdHWcTCQbfyKWV3dtiDw/xWPVYcOJkWGnTgRtpHM/z1Vi+v?=
 =?us-ascii?Q?d4ikLPIeZLOCXdF8UryFgBAE2JBp1oJQ1p+6BaDcmyA/tU32diQS8FyKyAok?=
 =?us-ascii?Q?9kzgPTJNkr3g31mE1sUZMaB02Pu7VXbIX9CkAPm54MpAdjgoXCaAwABfArwU?=
 =?us-ascii?Q?cemFNc0EauO4LL2YjOqhSlll1vCDMM84BTQt2q34s7MLZfMxd5nygOXGR+cM?=
 =?us-ascii?Q?Fmkwjta18ORs1VctUWosg14Yyk2LCcAnpZJKeXZfrYKLGUERuoFM7BIZlnKg?=
 =?us-ascii?Q?hcLSyCO5Xo9Nvapn5Zpy4JKP2rJRrAGSjveYKtjmMhK4Ce3Zn1dudtGcyB5O?=
 =?us-ascii?Q?hx2dx3+gbW5Pf6Zuqu41ssBXKiR0+6Qz/dak7jSmBrVDCbf+A3q6rgQhU6Ds?=
 =?us-ascii?Q?5D9hh7fcbcdeEcUxLRme/bfl2V2WP+2CAqtTBiN90RRKb1dH3RGiWMvflSSf?=
 =?us-ascii?Q?Qho4lRceEuskiGTRM44DnGmGZTnapxgexUpaLnYSof7njClHB6VydLb3ZT5H?=
 =?us-ascii?Q?b0nz/nr/qFWAuYNuwQH/CmUfRqRX/mAxcsnmoSkuU+l3xoJ71a8OUQBcM/tO?=
 =?us-ascii?Q?8RDEaX9JR/zcBHBYREdyGPn3IMvQct8PiBX5fnHfD+fyF1wvBIZOmXDoeLuL?=
 =?us-ascii?Q?NhrlbD9oeA+C56DnhHPAqjQFBi+IlbKhjZTMhDZoT/VgyJGmRxKmhDhntb9l?=
 =?us-ascii?Q?rmom4FwcGzmAtA/b3KkFhTtEVZGadGMube2kioOFBihOiI2M3ZUOLLa6adOx?=
 =?us-ascii?Q?3BvUWtTt5J9aHsGXN+sq3RIO1Wox13wpvUDTiuT/1L+Xpayp2htiNgjERpDp?=
 =?us-ascii?Q?J2EwzhDv+TFZGo4rlDRdXsjDQPJuVs8InrGOt00Fd7FXMhNwNb0NXEOT9WzC?=
 =?us-ascii?Q?ZXESExAQGPjL7NbnC0zuKlHiXtxawAfoixQAwoobEjK0bFdC75VZVtLtNBDe?=
 =?us-ascii?Q?OReQkohtX+uBknq13BAPBEPFeT5XV2vcWr9YKCIGcxZa4VIm9VOSCP0aKr1B?=
 =?us-ascii?Q?rJvKE9F/zRM7uxQlqoI6L3FWMzTSqhNHcMCYHsofYYoH9O7YswNhvZfhfZx4?=
 =?us-ascii?Q?TmxmnAU1ZHkRnJspceHWPiV8Xn5JkOsikicIfvM1OF4OP0EmNy301RQyTjlF?=
 =?us-ascii?Q?KcSajlSnsYalM2WlO0xUfOu/71NP6oqvIgD9eC16Ikee3MQGeM6LWHtb4yTR?=
 =?us-ascii?Q?hewsUDs29FCImvBeQUhPNoIRtm40YxfFR80IJBOc1m6XdoMM4euFdC4jTj/q?=
 =?us-ascii?Q?I4c9YtwfquwiehLdcLJjsDqqKqgw1ZxQXWMKFVo4WVE7cIWvJMWLvxmPiP3o?=
 =?us-ascii?Q?tl3ygAt2SF5dZjAyScg0/5543XYcGx02EDOndjiQl5e8cbWtp0SMmTRaONBi?=
 =?us-ascii?Q?JEYy7q4/0k+GZsk4O3vWnBGR5K7LhIZzgsrKKQ4bO9rtJEoKhPey6v4L0vyL?=
 =?us-ascii?Q?NvNvXjEzRm8dgRnnfzK/Ibto9CwMYTgAAbEuWcD3n8PI3/BNinlNEDsx+AUz?=
 =?us-ascii?Q?ZHETwqNTiwBw2z+2xLWqT600mrR5TkXmJvRS0pQx2rkW5TQgrro3T/tLDERI?=
 =?us-ascii?Q?+cW27/lgTIGCGpaw5/463vkMzupW5bNfVTcH/UA0oHK9SuxdnaykyPJ94MQ7?=
 =?us-ascii?Q?WZu1u6WHHF9HuifTpmTqtIDBVCKQ9AC8IwQBVGzQQAan1jGU5r4Vz0jfmYK+?=
 =?us-ascii?Q?aGsWuk3nlaYhVwOGcLuAnkwaglCr5qH76bstr9CUZDiUBKvlt65WaaTdgd08?=
 =?us-ascii?Q?3wRqO5chfg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5294485E930EAE1E23F13C85951D9DM4PR12MB5294namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5294.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbc53d2-ee5c-45bb-80c7-08da1061cdf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 02:22:27.8515 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bLmPrwbNmjwsZSqORGlbquK4Na6f/SukQoSDia1vYJGMoS9PvCDdOjoxJ+tMMvdlAAMm9GeJ3T/jPY0U0j947w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1731
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
Cc: "Wang, Yu \(Charlie\)" <Yu.Wang4@amd.com>, "Zhu, James" <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB5294485E930EAE1E23F13C85951D9DM4PR12MB5294namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Thank you very much for your suggestion, but I have already submitted.

Regards,
Rico
________________________________
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Monday, March 28, 2022 10:17
To: Chen, Guchun <Guchun.Chen@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.=
com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wang, Yu (Charlie) <Yu.Wang4@amd.com>; Zhu, James <James.Zhu@amd.com>; =
Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: RE: [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0

Hi Tianci,

I think we shall improve the subject a bit like "drm/amdgpu: fix incorrect =
instance id passing when stopping dpg mode". How do you think?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chen, Gu=
chun
Sent: Monday, March 28, 2022 9:26 AM
To: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Wang, Yu (Charlie) <Yu.Wang4@amd.com>; Zhu, James <James.Zhu@amd.com>; =
Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: RE: [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: Tianci Yin <tianci.yin@amd.com>
Sent: Sunday, March 27, 2022 7:19 PM
To: amd-gfx@lists.freedesktop.org
Cc: Chen, Guchun <Guchun.Chen@amd.com>; Zhu, James <James.Zhu@amd.com>; Wan=
g, Yu (Charlie) <Yu.Wang4@amd.com>; Yin, Tianci (Rico) <Tianci.Yin@amd.com>
Subject: [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0

From: tiancyin <tianci.yin@amd.com>

Some video card has more than one vcn instance, passing 0 to vcn_v3_0_pause=
_dpg_mode is incorrect.

Error msg:
Register(1) [mmUVD_POWER_STATUS] failed to reach value
0x00000001 !=3D 0x00000002

Signed-off-by: tiancyin <tianci.yin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c
index e1cca0a10653..cb5f0a12333f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1488,7 +1488,7 @@ static int vcn_v3_0_stop_dpg_mode(struct amdgpu_devic=
e *adev, int inst_idx)
         struct dpg_pause_state state =3D {.fw_based =3D VCN_DPG_STATE__UNP=
AUSE};
         uint32_t tmp;

-       vcn_v3_0_pause_dpg_mode(adev, 0, &state);
+       vcn_v3_0_pause_dpg_mode(adev, inst_idx, &state);

         /* Wait for power status to be 1 */
         SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
--
2.25.1


--_000_DM4PR12MB5294485E930EAE1E23F13C85951D9DM4PR12MB5294namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thank you very much for your suggestion, but I have already submitted.</div=
>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Rico</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chen, Guchun &lt;Guch=
un.Chen@amd.com&gt;<br>
<b>Sent:</b> Monday, March 28, 2022 10:17<br>
<b>To:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Yin, Tianci (Rico) &lt=
;Tianci.Yin@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.fr=
eedesktop.org&gt;<br>
<b>Cc:</b> Wang, Yu (Charlie) &lt;Yu.Wang4@amd.com&gt;; Zhu, James &lt;Jame=
s.Zhu@amd.com&gt;; Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Tianci,<br>
<br>
I think we shall improve the subject a bit like &quot;drm/amdgpu: fix incor=
rect instance id passing when stopping dpg mode&quot;. How do you think?<br=
>
<br>
Regards,<br>
Guchun<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Ch=
en, Guchun<br>
Sent: Monday, March 28, 2022 9:26 AM<br>
To: Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org<br>
Cc: Wang, Yu (Charlie) &lt;Yu.Wang4@amd.com&gt;; Zhu, James &lt;James.Zhu@a=
md.com&gt;; Yin, Tianci (Rico) &lt;Tianci.Yin@amd.com&gt;<br>
Subject: RE: [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0<br>
<br>
Reviewed-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
<br>
Regards,<br>
Guchun<br>
<br>
-----Original Message-----<br>
From: Tianci Yin &lt;tianci.yin@amd.com&gt; <br>
Sent: Sunday, March 27, 2022 7:19 PM<br>
To: amd-gfx@lists.freedesktop.org<br>
Cc: Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Zhu, James &lt;James.Zhu@amd.=
com&gt;; Wang, Yu (Charlie) &lt;Yu.Wang4@amd.com&gt;; Yin, Tianci (Rico) &l=
t;Tianci.Yin@amd.com&gt;<br>
Subject: [PATCH] drm/amd/vcn: fix an error msg on vcn 3.0<br>
<br>
From: tiancyin &lt;tianci.yin@amd.com&gt;<br>
<br>
Some video card has more than one vcn instance, passing 0 to vcn_v3_0_pause=
_dpg_mode is incorrect.<br>
<br>
Error msg:<br>
Register(1) [mmUVD_POWER_STATUS] failed to reach value<br>
0x00000001 !=3D 0x00000002<br>
<br>
Signed-off-by: tiancyin &lt;tianci.yin@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c<br>
index e1cca0a10653..cb5f0a12333f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
@@ -1488,7 +1488,7 @@ static int vcn_v3_0_stop_dpg_mode(struct amdgpu_devic=
e *adev, int inst_idx)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dpg_pause_state sta=
te =3D {.fw_based =3D VCN_DPG_STATE__UNPAUSE};<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_v3_0_pause_dpg_mode(adev, 0, &amp=
;state);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_v3_0_pause_dpg_mode(adev, inst_id=
x, &amp;state);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Wait for power status t=
o be 1 */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_WAIT_ON_RREG(VCN, in=
st_idx, mmUVD_POWER_STATUS, 1,<br>
--<br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM4PR12MB5294485E930EAE1E23F13C85951D9DM4PR12MB5294namp_--

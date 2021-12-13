Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037A2C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 15:18:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C91310E721;
	Mon, 13 Dec 2021 15:18:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73B4610E721
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 15:18:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7oIOZY/pIJYHu7PrLwO4h6IgWyiiqIrfv+2z3FjsCQTCa/ODKYn+YFLc9Vk9Rxos1wocp8DIe8zxqvgxL2I8tTHa4z3IuUCsd53fQLnIqRud1nZnZIejmoeEsPEvbvMrfW1BFJSsuuDAzB5eW9DyEasc50MRONK5uFsW9T4hCfy0hdOahMlQ2hOI50eVMEp09JcY3OmX8wxyqytmr5wiw5gfJmTTMm6laSVMqhH07HiD6LvYm60bnOtQwmCY4PQX4MKg4sPGSWa3rI749M8tHoFi28fHhWkftS3l34yblJQoW3ZdXksJ4ka8SoxYsS7q/w0tnvHsv1f2VwncTXaKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/fWk6q1IZmJyuFVYVJims8c7UZTLG4uPUX8y6jQVZw=;
 b=PC7jkhGGFHsG6qQqGL5pZskcMXE4yPpiuZ/NT9SotIY/vEYm5+HraS9FSU3LelfD4rJIE7bDtaL6Gb8fGGIYsgGtWFN8SBxskGHp5tflswCvXUb3tY19aNWa7g8HDO19Oi5jUSfBFKv2vaEdbWobYgc95VbOPDuHx7tHXsVbjpUmIUqU4A4rysVQ3KYZlm4/Bht6FghwwJbgnTHYFZdpxiEBrht1ZIqmr8McVzeMrHrnPSw9x+VKyW5tms2CfJNwBBsYWgbfk7gi8aD3BUaSy6f4rpJ9lPs1AU9qhnaQB22kiUQZDhGaRRFLDlL/McVC2yT7NNc6o29tHii84CmcLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/fWk6q1IZmJyuFVYVJims8c7UZTLG4uPUX8y6jQVZw=;
 b=5pz1Y++MOTmS3aiFUIDCEChnlAiN1xL3uXhQRu60K/KOh/wEge9YcDKxRHJvE1a3fKCxCsmkU0HRmUuRHbAB4fZIKzUj9xOzj5irRRniabPsrThGIZ5GbdGwo0UYLQsagFwU4EhrhMb3VjSXt+8aRu1b0oIRYoEyNzFFgYRs4fA=
Received: from MN2PR12MB3072.namprd12.prod.outlook.com (2603:10b6:208:c5::23)
 by MN2PR12MB3136.namprd12.prod.outlook.com (2603:10b6:208:d1::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 15:18:38 +0000
Received: from MN2PR12MB3072.namprd12.prod.outlook.com
 ([fe80::9c27:c1fb:8942:30df]) by MN2PR12MB3072.namprd12.prod.outlook.com
 ([fe80::9c27:c1fb:8942:30df%5]) with mapi id 15.20.4755.021; Mon, 13 Dec 2021
 15:18:38 +0000
From: "Choi, Nicholas" <Nicholas.Choi@amd.com>
To: "Zuo, Jerry" <Jerry.Zuo@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix Compile Error for DCE
Thread-Topic: [PATCH] drm/amd/display: Fix Compile Error for DCE
Thread-Index: AQHX8DSzkOpbUns75E2Ga1DIYSJiHw==
Date: Mon, 13 Dec 2021 15:18:37 +0000
Message-ID: <MN2PR12MB30726C8591DFD374A89FBFA0E3749@MN2PR12MB3072.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-13T15:18:37.560Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: d8172329-ac47-a3a8-e027-bd29ea4f2112
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c84a0c2-5d32-45ba-9bf2-08d9be4bd6af
x-ms-traffictypediagnostic: MN2PR12MB3136:EE_
x-microsoft-antispam-prvs: <MN2PR12MB3136AB1D9ADF110C0260A4B8E3749@MN2PR12MB3136.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j5H8R929GckjAburE7Ds82QZq2C2qFCIbjoqanWm7WZCyLHhsJHsrhG5r4vey11J2QTARTQLUBuUeNdvKWPwTJTOBlJh/vsA8KnY7k+7kic+adxeqY5gGT13/qbjTZGAklJFAGHKcGUSxeyeph4K6skeFTanZU6u3F/Fpw+PJqZrRoIWDamiRI9yCZiYLWQTNX3J7Yb0efP7iC6HesxxJwlfzUqsZZb2osXBrPkhhutanr5fDRle/Y6XKMrC4gSb8mUbDgm/2geUk4ef7BJD5D5EOE2OLw4tkJLO8ejrvMGAAZGLYfuA8l27EO4hqx1xFnq8RDJU+CQxyEshI0W3BkoXQz5NiL3zhjK3NSgwgxTSrz3py7hDUEW3a2ymCB8WmlMZyqnVlE1MITJSDEYu1itdVM9VsxQzM2VmIkZT2q7UiOGRhWc6ONiknoleInBa6IGym4XedlOQ5HK/05zItfJZCJ5F6J3DwBkS1sToawGi+I8++AN4xPEcSS9pNbeWL3FzbyYrqQv12ILh1HruVHRMp39jJHKldFPkxyLRxqCa7P1Zk8YoOTkllWtSH5Q8FLO6+9I5CfLlZYWl6ZcxAtVmjxukiP1EZQc3/kPSfXP9GY2cVqTHbpb+STyFU0bqc9UnTcfH6+8qPpc9oIPWWdds7bOVDWMRYuQzunaa2jskbeZS/CI5vRUOjsbDZOVlruEU6oHqe1SQ2WDHmMz+oQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(66556008)(8936002)(316002)(66476007)(9686003)(64756008)(91956017)(83380400001)(26005)(76116006)(54906003)(33656002)(6862004)(55016003)(4326008)(19627405001)(8676002)(66946007)(508600001)(122000001)(71200400001)(53546011)(6506007)(86362001)(38100700002)(2906002)(186003)(5660300002)(52536014)(6636002)(7696005)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?P+IsR2x+5X4IH8TD//rrpzuaLgSj13uqjoTrctVrp6bs9IgGqGfiYUNepY?=
 =?iso-8859-1?Q?i0y+EpUoy32aMJpzjnWhhlyXbDzZZXynaJjAswOv1okTIUg4w/dvc6verR?=
 =?iso-8859-1?Q?WKB/sblAnZY31FQpMUGV60+E8hsiaRZBUb5g4eJZ6rPnGZp9ctHbMuHJ3B?=
 =?iso-8859-1?Q?okXUnNymRWRCIULiFee9kzC/izKawwdtK0t6EGn/WISCbbAT5e0rPEMhek?=
 =?iso-8859-1?Q?iSutdely53S3ouMhFq8t28O2FqXXSxMpBlmNf8gBE37dlqckfOMDIpCB23?=
 =?iso-8859-1?Q?IbL55VVqNzeBuLy/rSk/pqxh7m0bQIMAqnQBkKfWELijAcLNJTc/jg6fp7?=
 =?iso-8859-1?Q?KkrIY+FZrab1PlQq87yYrybKtfiTrjvMp/ml0ftDrCQ5t1g+eJQQzwMzrE?=
 =?iso-8859-1?Q?dA/W9zEJfMmrOuWfud4K/5Gv70vZUvD/3rfe3bofGCnVGkN6+UNgMcy5yn?=
 =?iso-8859-1?Q?E/GYhGqIZifX8NoerWB322RLTG4keF71hkMSBIdwVoMv8SFmdRZ2dn/Gfp?=
 =?iso-8859-1?Q?5LFcGvGP+KXqBWrYM5KS+JSwuQnGLIzVFNuM4QlGUrdA9x8t/+T7WJg/j9?=
 =?iso-8859-1?Q?a4/TF+fvqUZmfFuiaWKP8G4ePOXqvZEdgZt+ZlQ0yt6Nb3RTekSt8/9SLM?=
 =?iso-8859-1?Q?dkEQnF7bixefR9kRSJex2QMp0cLDTn1VAyGQ2BEqYNuzBltGLbXQpW/uW5?=
 =?iso-8859-1?Q?/qQUzr9wNAQ67Cp5wpOkFOAp9l8carc+WR3QlkFKeYoHjNf8KtGHBHGEng?=
 =?iso-8859-1?Q?PtazIaXVWyuqnN6xNztFvYrkFMS1T7GRmen6n8rIRHsUAXXVi7ZShIf6Fa?=
 =?iso-8859-1?Q?89A3Vk3v1AfHMgUa5s29HqfkvegovV4GpE5I809UnywW6h9SoaqnY/dXiI?=
 =?iso-8859-1?Q?v/8wDz1U53p2/LeAFsLaVYRf/0vd1G10RI11O3nbLp5IeP1yMl+n+vfql2?=
 =?iso-8859-1?Q?9dpIHRCU7/BuAV95/uWrdUcjNtyqLILQ2e+lMXfq/Z7Z07AiKSGLd5MTpN?=
 =?iso-8859-1?Q?o+DK+uz+8KPyyAJj3JoX+MnDeU6JUESDb2tMLhrc4z/dRrFVTclOsMLtfN?=
 =?iso-8859-1?Q?MA8E2dvYvyR0Ro9zaGvQ6ZA+0G7t/FnfdFYTlSjF9xeoTptOLuliwXZT1Q?=
 =?iso-8859-1?Q?z339q9YeAn0X8e7s6rm9gcQjaCiAqOmdkp/qK2dqdN1Pe4GBlmdb98Ucj2?=
 =?iso-8859-1?Q?hv08k8efD2Vp6fL0Opyd4Nx3YvusB4ef5BZXWoYKvPJjaAKmOWNpaD43g6?=
 =?iso-8859-1?Q?uN7AgEyu20695P08XbAipODfzIQE8nxEwrgAIBzwB1i/MLA++LZCIOugUd?=
 =?iso-8859-1?Q?a6soEQqP7yLbRIseAJKQjPncQpgp+/nSgMU/J5XwhbaWgHzI1UQFAVW4Jn?=
 =?iso-8859-1?Q?KHT4p4Fw7prCuVQbRGRJPy9AbQzIO8Xz/jVxkqT1xMHar9AWM4Pgto6iXX?=
 =?iso-8859-1?Q?I1EF/e+YfdZvJB21VMMKWu/rBR3CK3CUtaB9J75WpogKrKV7C67n/ZzgDI?=
 =?iso-8859-1?Q?SwPqcljKSQ71XHz2uUSeskwuJuuXPKCFwNLdglcJkRXc6uZ4+TkzIQpQur?=
 =?iso-8859-1?Q?H20nkxnGWAeaFjwEobit4t1lyFstzMDM8GAcWbSobWk0kVprJQNLIsqM4o?=
 =?iso-8859-1?Q?p+NHMwYVXW6nSiuWTyi+0PUCTXhjfoJseHhpi8Kfd7vlAodKq4S7PTfg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_MN2PR12MB30726C8591DFD374A89FBFA0E3749MN2PR12MB3072namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c84a0c2-5d32-45ba-9bf2-08d9be4bd6af
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 15:18:38.0425 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dbip3oR0jg/efcNgb9/4S0Dpejw4T0zJkW6Dk6SNVRWyelrVZwmpmt26Pn0/rZcj3cKJGWUDzz0LoSx3JLgvEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3136
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_MN2PR12MB30726C8591DFD374A89FBFA0E3749MN2PR12MB3072namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

The following patch has been

Reviewed-by: Nicholas Choi <Nicholas.Choi@amd.com>

Thanks,

Nicholas
________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Saturday, December 11, 2021 9:08 AM
To: Zuo, Jerry <Jerry.Zuo@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Choi, Nicholas <Nicholas.=
Choi@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix Compile Error for DCE

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Dec 10, 2021 at 9:42 PM Fangzhi Zuo <Jerry.Zuo@amd.com> wrote:
>
> Follow-up fix for:
> drm/amd/display: Add Debugfs Entry to Force in SST Sequence
>
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> index 1779c7daaf72..dc55a736e198 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> @@ -3237,8 +3237,9 @@ static int disable_hpd_get(void *data, u64 *val)
>  DEFINE_DEBUGFS_ATTRIBUTE(disable_hpd_ops, disable_hpd_get,
>                          disable_hpd_set, "%llu\n");
>
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>  /*
> - * Force sst sequence in mst capable receiver.
> + * Temporary w/a to force sst sequence in M42D DP2 mst receiver
>   * Example usage: echo 1 > /sys/kernel/debug/dri/0/amdgpu_dm_dp_set_mst_=
en_for_sst
>   */
>  static int dp_force_sst_set(void *data, u64 val)
> @@ -3260,6 +3261,7 @@ static int dp_force_sst_get(void *data, u64 *val)
>  }
>  DEFINE_DEBUGFS_ATTRIBUTE(dp_set_mst_en_for_sst_ops, dp_force_sst_get,
>                          dp_force_sst_set, "%llu\n");
> +#endif
>
>  /*
>   * Sets the DC visual confirm debug option from the given string.
> @@ -3370,8 +3372,10 @@ void dtn_debugfs_init(struct amdgpu_device *adev)
>                             adev, &mst_topo_fops);
>         debugfs_create_file("amdgpu_dm_dtn_log", 0644, root, adev,
>                             &dtn_log_fops);
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>         debugfs_create_file("amdgpu_dm_dp_set_mst_en_for_sst", 0644, root=
, adev,
>                                 &dp_set_mst_en_for_sst_ops);
> +#endif
>
>         debugfs_create_file_unsafe("amdgpu_dm_visual_confirm", 0644, root=
, adev,
>                                    &visual_confirm_fops);
> --
> 2.25.1
>

--_000_MN2PR12MB30726C8591DFD374A89FBFA0E3749MN2PR12MB3072namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt">The following patch has bee=
n<br>
</span></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt"><br>
<span data-markjs=3D"true" class=3D"mark9e0x2s9vd" data-ogac=3D"" data-ogab=
=3D"" data-ogsc=3D"" data-ogsb=3D"">Reviewed-by</span>: Nicholas Choi &lt;N=
icholas.Choi@amd.com&gt;<br>
<br>
Thanks,</span></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt"><br>
</span></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt">Nicholas</span></font><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher@gmail.com&gt;<br>
<b>Sent:</b> Saturday, December 11, 2021 9:08 AM<br>
<b>To:</b> Zuo, Jerry &lt;Jerry.Zuo@amd.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Choi, Nichol=
as &lt;Nicholas.Choi@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: Fix Compile Error for DCE</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Acked-by: Alex Deucher &lt;alexander.deucher@amd.c=
om&gt;<br>
<br>
On Fri, Dec 10, 2021 at 9:42 PM Fangzhi Zuo &lt;Jerry.Zuo@amd.com&gt; wrote=
:<br>
&gt;<br>
&gt; Follow-up fix for:<br>
&gt; drm/amd/display: Add Debugfs Entry to Force in SST Sequence<br>
&gt;<br>
&gt; Signed-off-by: Fangzhi Zuo &lt;Jerry.Zuo@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 6 ++=
+++-<br>
&gt;&nbsp; 1 file changed, 5 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c=
 b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c<br>
&gt; index 1779c7daaf72..dc55a736e198 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c<br>
&gt; @@ -3237,8 +3237,9 @@ static int disable_hpd_get(void *data, u64 *val)=
<br>
&gt;&nbsp; DEFINE_DEBUGFS_ATTRIBUTE(disable_hpd_ops, disable_hpd_get,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; disable_hpd_set, &quot;%llu\n&quot;);<br>
&gt;<br>
&gt; +#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&gt;&nbsp; /*<br>
&gt; - * Force sst sequence in mst capable receiver.<br>
&gt; + * Temporary w/a to force sst sequence in M42D DP2 mst receiver<br>
&gt;&nbsp;&nbsp; * Example usage: echo 1 &gt; /sys/kernel/debug/dri/0/amdgp=
u_dm_dp_set_mst_en_for_sst<br>
&gt;&nbsp;&nbsp; */<br>
&gt;&nbsp; static int dp_force_sst_set(void *data, u64 val)<br>
&gt; @@ -3260,6 +3261,7 @@ static int dp_force_sst_get(void *data, u64 *val=
)<br>
&gt;&nbsp; }<br>
&gt;&nbsp; DEFINE_DEBUGFS_ATTRIBUTE(dp_set_mst_en_for_sst_ops, dp_force_sst=
_get,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; dp_force_sst_set, &quot;%llu\n&quot;);<br>
&gt; +#endif<br>
&gt;<br>
&gt;&nbsp; /*<br>
&gt;&nbsp;&nbsp; * Sets the DC visual confirm debug option from the given s=
tring.<br>
&gt; @@ -3370,8 +3372,10 @@ void dtn_debugfs_init(struct amdgpu_device *ade=
v)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; adev, &amp;mst_topo_fops);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_file(&q=
uot;amdgpu_dm_dtn_log&quot;, 0644, root, adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; &amp;dtn_log_fops);<br>
&gt; +#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_file(&q=
uot;amdgpu_dm_dp_set_mst_en_for_sst&quot;, 0644, root, adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;dp_set_mst_en_for_sst_o=
ps);<br>
&gt; +#endif<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_file_un=
safe(&quot;amdgpu_dm_visual_confirm&quot;, 0644, root, adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;visua=
l_confirm_fops);<br>
&gt; --<br>
&gt; 2.25.1<br>
&gt;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB30726C8591DFD374A89FBFA0E3749MN2PR12MB3072namp_--

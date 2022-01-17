Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A749FC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 17:26:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FC2310F462;
	Mon, 17 Jan 2022 17:26:10 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BD1F10F462
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 17:26:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B03dgm50Funu2Z/ezW94SWW2JIisLYiFMY0VhNWTgo4yat1wctvYMGCjNICNOQvPDzmhmWJ5xqN9+OmErW6wdudR6s+NbqDu15SUYgb9oZXdHWM17CdUi9BKlD6G8asY0u1mHYpxXAaT/cCue7qXrXVwSaAUle+IbGJaq7kX3jejd8rJLejQOxx+A5hyH4th9x0SIGuwTdnN9W7zlVUNAjKbCP7/8wgnDo7hn/5lvzF6XpRqRpO5eA2g+xp5AjtMr+HOHBk+9hrMAMCa6Q50BTMVyJEgVBu7MHMc6tX/PbNx5Ldq3jphtYIBZ3iKwEnS6XDdf6UT17jTKxCLDal8uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giyNbfVlwc/CvmJJ0E5c0E/ABbWp+HlE2bceIYpsmDQ=;
 b=Ks6aGFCAQFzRXoMMa+TwZ/ikvetQFyXubgXaqR8QyZ2iMq0sB8P+85fMfGoYB7t4s+BNdQWUUp/3LB2GSSDHCC1tama28mKJAVmfaX40pP5Llqf1sQRLm67P/USZJWzWu2CedlBtTx4V4zQUYOm3VORFYUqXLpfJx+9i70WbkjEYA4p/Tr7heF/bPVVrDuJUpOw2yWfLnriyr6+Jleoet3fl5pOyy7XLz9Sx8nzpimXLLsq0S97CeOjEg4zMu9rQkXnvaWxwXP3ZEY8lSlaZWKQmtsA3t+uBo8MbxtV6OM4u33UruiPHT1ExKjKGxQJ4sp2LK4PEM5qUJrpuuJWZIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giyNbfVlwc/CvmJJ0E5c0E/ABbWp+HlE2bceIYpsmDQ=;
 b=CBjOPf9Cr8Fm0tOdA7Sw+GEbhK72/4bMpwRE9AWT6ezWmzpinehbBJVWe6fVkmR5Mn55pSapLi14jG0PObjdH6khHzglexojf3OuMVNvsRj76NPbmKu0JEFfuB1OuSwxGmy7jjvrbIzTEZ226oXJXAUTxp6kxcl+ro4uWNzYfbY=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by BN6PR12MB1604.namprd12.prod.outlook.com (2603:10b6:405:c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Mon, 17 Jan
 2022 17:26:07 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 17:26:07 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd: Warn users about potential s0ix problems
Thread-Topic: [PATCH v2] drm/amd: Warn users about potential s0ix problems
Thread-Index: AQHYByXifc5BzR5/BUKp3P/SNW4846xnfToQgAABRQCAAAFLkA==
Date: Mon, 17 Jan 2022 17:26:07 +0000
Message-ID: <BL1PR12MB51576008119B2DDC0ED29904E2579@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220111200026.15855-1-mario.limonciello@amd.com>
 <BL1PR12MB5157190D878C197F8EBEAE78E2579@BL1PR12MB5157.namprd12.prod.outlook.com>
 <BYAPR12MB4614363B37C7FCEB7150C29E97579@BYAPR12MB4614.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB4614363B37C7FCEB7150C29E97579@BYAPR12MB4614.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-17T17:15:10.0000000Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0; MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-17T17:26:05Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 81e66031-eb10-41c6-a3c8-1296d3ac54ae
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5dc7f391-dc5a-434e-ec0e-08d9d9de7261
x-ms-traffictypediagnostic: BN6PR12MB1604:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1604F5CC5D6CCE84CD483679E2579@BN6PR12MB1604.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nfWS+K9GsWEwx18pnSBUc5aUaTJZyu4a7oKCyywKSPkMprWF66PsIAnZkTItY/548Yo7aCeWKCQ1jJTilnXWuPLKbTMrUp9UOtDRG9elAl8/Raezn3m3EV0oeJRw/pJBGJ+anMMVrLw00ltQruMx7zSmfeuKPZmJQ9O7z3iMupTsBZo7SjRIjJ4dxWCnd2G9EaKirMw/KZnh2cqIZ5gFB64IoTJ1fYfr9aw16UegvNGPuYTZtqN0VjQ1nyW2FaShXtrEX6crY5f+OGFlM24BUR4c4LdCKjBJRsOp2pQvDrQ3QrsWSF662kifQY+2CgF0YXHtoPU9vkdTf3LtH4kkt8dUQd246JTbYJOakrc/fKcaw1p+27gokd4WykK5BW30qEVXGPCp5jJI8NnG9RpsE0tHTjsbfHwyEhpU0wXeECN5kJhEAL7R7XoZKvOTXCnIcWsyFCU/BquVI04Tk2f9g1SfPSROrKgyDzZt8aTsdKeHpecFGGjs+3yItt1vlZunDtJVjvp7Az/6lLN7jPUPPvMLS3z781Cy01wQeq9isle6AgeblqfRxs2TffKWaGxl22H7mUy9JKd2PrFkEMT4SKx7R1INiuHWM7YJJ9X7xdM6EiRxDnD60aSM5JQwzRzsyg/B+aSM8/JyBzj7mv5G37dew1ku/e6325xoItUmrJrREbHrWq2qIaVgebHkZhU56/6VTgT1I5zheaIVLl/DsDRaSeB1aLBitco1vE60V4o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(110136005)(38070700005)(86362001)(7696005)(38100700002)(66946007)(9686003)(122000001)(8676002)(316002)(166002)(8936002)(53546011)(71200400001)(966005)(186003)(5660300002)(33656002)(4326008)(6506007)(66446008)(52536014)(26005)(66476007)(66556008)(508600001)(64756008)(55016003)(76116006)(2906002)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u1ho1wS1v4VAjkCMd86CNPiiIK3+u1NuN2fDckLGVPzVxtLebiOZm3qWCI4Z?=
 =?us-ascii?Q?GnpH0wPB6fPHbdZVl14EYreL4JAMVpfD6Y7BsqxgD9JD1kmUwtbX6SKrlRmO?=
 =?us-ascii?Q?lkegI7Q6ckBca3SWzRyvlu+eAd+ZfPc5ntpzZ3d7A+A1Sl7PiJ08PLhxdL3d?=
 =?us-ascii?Q?gnmVuGKkBNBaKpG/ouVo/jVhZ4lZylnWckrMArrP5COoJKOmDlx/uo1KFy2h?=
 =?us-ascii?Q?MSX5yXfNJR1lQiKtn3vMjH5j0vSJQOyvPiaDlzVG3wE7RJi/seDZJJ2X0MBA?=
 =?us-ascii?Q?ALqF7xhK98K5PyUcYvUJJUzEPkeGjgASquhOZyIdcbJJeerHHe2nibJ3WVKj?=
 =?us-ascii?Q?MjIsIvsaZsa3HTKfYdGsOcjpIPPbEKsk8QHYn+CNSFPVSG6cWnBXYLw9+NvM?=
 =?us-ascii?Q?/uFZ5kfBcFhSkvpJsyVINYBl7wYWeuAQo368K/1JLPYnQuvBqtGg23w0+Lc+?=
 =?us-ascii?Q?tGsJeuJjS4rxO6w41G87A56ZDpi+7pUuZ6rDiBmyVZ5b9AF+B3Wavpuncpsu?=
 =?us-ascii?Q?5r0+gC+i18DIBqG6f4bogTLhPwCPJRjRedSks3R9TyHITgJDjvtp8H4N/9py?=
 =?us-ascii?Q?U40rT0i1c4qD4Pji6CTpkSOMBXyQVu/SNcLPN1LogxyenjOeFtkfdAtWeabV?=
 =?us-ascii?Q?xv6sPRsPTnPGhtNFZ+oZYf3rC7bpvwTq0O2Mhard8t9Fntozm9O24Dknp0+D?=
 =?us-ascii?Q?30pBX5prEnpvJKSukTAvTpf3x5zeXUw+Fim/IPMrdJqn+v4sXleMZN6jp/6f?=
 =?us-ascii?Q?g13rhdWLXvdP+Tp6qOoIJuqjalE7MlEsRH3XbZyHbvBD4eD2itxSSTnQBfiL?=
 =?us-ascii?Q?Pst1qjw8CDF1D0rxsDxlYlvIvNBAWrIHKkbBh60R9aeW3dhUseNlO6WNdKI6?=
 =?us-ascii?Q?HxnAvFjQjUscazgR6P18/9Do5C7o4mF99jZgyE8vCc2bh8Yqkxb1gB+QfMZe?=
 =?us-ascii?Q?/9shXxaQE5NMWopU4jLZ5Gm49W0K8XJUSZBijDs0ZkCeSM6rC6l/+nMAmy4y?=
 =?us-ascii?Q?jUxWIWTLeEcJoOTSlc1U0doIDJRaeB33aK3zAErNFQ/Ka/znaY5IW7oa5u4q?=
 =?us-ascii?Q?Cj3gGquzARt0qyiTeg5sFRssAGEk9MGrlEpybFIoYkBCE8N9dOPgd2SYxuCM?=
 =?us-ascii?Q?rgnawzdvPxkSnReW4gDMzQ1jmYkxuAQH2I0QneaDxeSMdyrkP1Kb2Gq36NJp?=
 =?us-ascii?Q?/4EOIgxKN2qwDe1h8I3BxL5I4S2xdxY9KMA3oHS1HF+nDpMORQ216KgEue+M?=
 =?us-ascii?Q?hPiN0Hdu7f+ItvtKf2SyAu7obyMH2FgTwLCpgdNY+26iDkIptQ7XoLpeR59x?=
 =?us-ascii?Q?Wkj3UMPhYbHAhi77zZ2uO0QGGjw3Lq0fEVp4ddmL3FovpuP5x5ovYA+ybCdS?=
 =?us-ascii?Q?NctgKjkrBGpwzkJfLRqJdhV1AwbnwOwoB7bUlSaCc0dy8lwEbqPVkZ6O54/m?=
 =?us-ascii?Q?v0NUXVqDvnZ11eLOkIkLrreBGGqHCuyQghpXdGs8iFynTvridXr/7kCUULeZ?=
 =?us-ascii?Q?acm/Dggyvuiqnc9slfykLRPn271wa6JUU473blNCbeHXEA9segFBUZKyCQYU?=
 =?us-ascii?Q?zY7pApPky0uaBE63NwP9kbhI6/ig7CmdvtUuepO0vMdQmb+14i9pGoV3ddpy?=
 =?us-ascii?Q?DA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51576008119B2DDC0ED29904E2579BL1PR12MB5157namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc7f391-dc5a-434e-ec0e-08d9d9de7261
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 17:26:07.3373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LB9rjxK0QKTDTCAKXuIYnrjeZMiNGb4GIvdbDc5LjZbywdj3kLUWavHrQ69eVmlyFIq1WSNTYgOfWLOvUbQmKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1604
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
Cc: Bjoren Dasse <bjoern.daase@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51576008119B2DDC0ED29904E2579BL1PR12MB5157namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Yes, that's part of why I want to make sure there are explicit warnings to =
users about using this flow.
When not enabled in ACPI then also the LPS0 device is not exported and AMD_=
PMC won't load or be used.

I think from amdgpu perspective it should behave relatively similar to an a=
borted suspend.

From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Monday, January 17, 2022 11:20
To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-gfx@lists.freedeskt=
op.org
Cc: Bjoren Dasse <bjoern.daase@gmail.com>
Subject: Re: [PATCH v2] drm/amd: Warn users about potential s0ix problems

Any problem with PMFW sequence in the way Linux handles s2idle when it's no=
t enabled in ACPI?

Thanks,
Lijo
________________________________
From: Limonciello, Mario <Mario.Limonciello@amd.com<mailto:Mario.Limonciell=
o@amd.com>>
Sent: Monday, January 17, 2022 10:45:44 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; Lazar, =
Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Cc: Bjoren Dasse <bjoern.daase@gmail.com<mailto:bjoern.daase@gmail.com>>
Subject: RE: [PATCH v2] drm/amd: Warn users about potential s0ix problems

[Public]

This has been sitting a week or so.
Bump on review for this patch.

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com<mailto:Mario.Limoncie=
llo@amd.com>>
> Sent: Tuesday, January 11, 2022 14:00
> To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com<mailto:Mario.Limonciell=
o@amd.com>>; Bjoren Dasse
> <bjoern.daase@gmail.com<mailto:bjoern.daase@gmail.com>>
> Subject: [PATCH v2] drm/amd: Warn users about potential s0ix problems
>
> On some OEM setups users can configure the BIOS for S3 or S2idle.
> When configured to S3 users can still choose 's2idle' in the kernel by
> using `/sys/power/mem_sleep`.  Before commit 6dc8265f9803
> ("drm/amdgpu:
> always reset the asic in suspend (v2)"), the GPU would crash.  Now when
> configured this way, the system should resume but will use more power.
>
> As such, adjust the `amdpu_acpi_is_s0ix function` to warn users about
> potential power consumption issues during their first attempt at
> suspending.
>
> Reported-by: Bjoren Dasse <bjoern.daase@gmail.com<mailto:bjoern.daase@gma=
il.com>>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1824
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com<mailto:mario.=
limonciello@amd.com>>
> ---
> v1->v2:
>  * Only show messages in s2idle cases
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 4811b0faafd9..1295de6d6c30 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1040,11 +1040,15 @@ void amdgpu_acpi_detect(void)
>   */
>  bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
>  {
> -#if IS_ENABLED(CONFIG_AMD_PMC) && IS_ENABLED(CONFIG_SUSPEND)
> -     if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
> -             if (adev->flags & AMD_IS_APU)
> -                     return pm_suspend_target_state =3D=3D
> PM_SUSPEND_TO_IDLE;
> -     }
> +     if (!(adev->flags & AMD_IS_APU) ||
> +         pm_suspend_target_state !=3D PM_SUSPEND_TO_IDLE)
> +             return false;
> +     if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
> +             dev_warn_once(adev->dev,
> +                           "BIOS is not configured for suspend-to-idle, =
power
> consumption will be higher\n");
> +#if !IS_ENABLED(CONFIG_AMD_PMC)
> +     dev_warn_once(adev->dev,
> +                   "amd-pmc is not enabled in the kernel, power
> consumption will be higher\n");
>  #endif
> -     return false;
> +     return true;
>  }
> --
> 2.25.1

--_000_BL1PR12MB51576008119B2DDC0ED29904E2579BL1PR12MB5157namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheaderc10f11a2, li.msipheaderc10f11a2, div.msipheaderc10f11a2
	{mso-style-name:msipheaderc10f11a2;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Yes, that&#8217;s part of why I want to make sure th=
ere are explicit warnings to users about using this flow.<o:p></o:p></p>
<p class=3D"MsoNormal">When not enabled in ACPI then also the LPS0 device i=
s not exported and AMD_PMC won&#8217;t load or be used.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I think from amdgpu perspective it should behave rel=
atively similar to an aborted suspend.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt; =
<br>
<b>Sent:</b> Monday, January 17, 2022 11:20<br>
<b>To:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org<br>
<b>Cc:</b> Bjoren Dasse &lt;bjoern.daase@gmail.com&gt;<br>
<b>Subject:</b> Re: [PATCH v2] drm/amd: Warn users about potential s0ix pro=
blems<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">Any problem with PMFW sequence in the way Linux handles s2idle when it=
's not enabled in ACPI?<o:p></o:p></span></p>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<p class=3D"MsoNormal">Thanks,<br>
Lijo<o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Limonciello, Mario &lt;<a href=3D"mailto:Mario.Limo=
nciello@amd.com">Mario.Limonciello@amd.com</a>&gt;<br>
<b>Sent:</b> Monday, January 17, 2022 10:45:44 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;; Lazar, Lijo &lt;<a href=3D"mailto:Lijo.=
Lazar@amd.com">Lijo.Lazar@amd.com</a>&gt;<br>
<b>Cc:</b> Bjoren Dasse &lt;<a href=3D"mailto:bjoern.daase@gmail.com">bjoer=
n.daase@gmail.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH v2] drm/amd: Warn users about potential s0ix pro=
blems</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[Public]<br>
<br>
This has been sitting a week or so.<br>
Bump on review for this patch.<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Limonciello, Mario &lt;<a href=3D"mailto:Mario.Limonciello@amd.c=
om">Mario.Limonciello@amd.com</a>&gt;<br>
&gt; Sent: Tuesday, January 11, 2022 14:00<br>
&gt; To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.fre=
edesktop.org</a><br>
&gt; Cc: Limonciello, Mario &lt;<a href=3D"mailto:Mario.Limonciello@amd.com=
">Mario.Limonciello@amd.com</a>&gt;; Bjoren Dasse<br>
&gt; &lt;<a href=3D"mailto:bjoern.daase@gmail.com">bjoern.daase@gmail.com</=
a>&gt;<br>
&gt; Subject: [PATCH v2] drm/amd: Warn users about potential s0ix problems<=
br>
&gt; <br>
&gt; On some OEM setups users can configure the BIOS for S3 or S2idle.<br>
&gt; When configured to S3 users can still choose 's2idle' in the kernel by=
<br>
&gt; using `/sys/power/mem_sleep`.&nbsp; Before commit 6dc8265f9803<br>
&gt; (&quot;drm/amdgpu:<br>
&gt; always reset the asic in suspend (v2)&quot;), the GPU would crash.&nbs=
p; Now when<br>
&gt; configured this way, the system should resume but will use more power.=
<br>
&gt; <br>
&gt; As such, adjust the `amdpu_acpi_is_s0ix function` to warn users about<=
br>
&gt; potential power consumption issues during their first attempt at<br>
&gt; suspending.<br>
&gt; <br>
&gt; Reported-by: Bjoren Dasse &lt;<a href=3D"mailto:bjoern.daase@gmail.com=
">bjoern.daase@gmail.com</a>&gt;<br>
&gt; Link: <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/1824"=
>https://gitlab.freedesktop.org/drm/amd/-/issues/1824</a><br>
&gt; Signed-off-by: Mario Limonciello &lt;<a href=3D"mailto:mario.limonciel=
lo@amd.com">mario.limonciello@amd.com</a>&gt;<br>
&gt; ---<br>
&gt; v1-&gt;v2:<br>
&gt;&nbsp; * Only show messages in s2idle cases<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 16 ++++++++++------<b=
r>
&gt;&nbsp; 1 file changed, 10 insertions(+), 6 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
&gt; index 4811b0faafd9..1295de6d6c30 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c<br>
&gt; @@ -1040,11 +1040,15 @@ void amdgpu_acpi_detect(void)<br>
&gt;&nbsp;&nbsp; */<br>
&gt;&nbsp; bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)<br>
&gt;&nbsp; {<br>
&gt; -#if IS_ENABLED(CONFIG_AMD_PMC) &amp;&amp; IS_ENABLED(CONFIG_SUSPEND)<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (acpi_gbl_FADT.flags &amp; ACPI_FADT_LOW_=
POWER_S0) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;flags &amp; AMD_IS_APU)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return pm_suspend_targe=
t_state =3D=3D<br>
&gt; PM_SUSPEND_TO_IDLE;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;flags &amp; AMD_IS_APU) ||<br=
>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_suspend_target_st=
ate !=3D PM_SUSPEND_TO_IDLE)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (!(acpi_gbl_FADT.flags &amp; ACPI_FADT_LO=
W_POWER_S0))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_warn_once(adev-&gt;dev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &quot;BIOS is not configured for suspend-to-idle, power<br>
&gt; consumption will be higher\n&quot;);<br>
&gt; +#if !IS_ENABLED(CONFIG_AMD_PMC)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; dev_warn_once(adev-&gt;dev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;amd-pmc is not enabled in the=
 kernel, power<br>
&gt; consumption will be higher\n&quot;);<br>
&gt;&nbsp; #endif<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt;&nbsp; }<br>
&gt; --<br>
&gt; 2.25.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB51576008119B2DDC0ED29904E2579BL1PR12MB5157namp_--

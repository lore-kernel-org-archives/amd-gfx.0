Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C67C05027
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jan 2023 16:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7461310E374;
	Fri, 20 Jan 2023 16:38:48 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA13610E373
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jan 2023 16:38:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUTCJTZdM+Xmtj9qv33qxsbMbSDDFcLJJ9N9OyIE4Nob4/xKKQiL42ZqlN8z9UcRDZvIFeQhvyvyEA+VCaS3A8wKCkXzzI5w5p75Ue112a8DHHKa+WHGXeUMj6EkWU3Nu0dGx443MwUPabXl5HEH7CogjH6XewDhE9S5LsVJCVyqC0BoWthjMl+iQoGwG5jkRDf2GI01KiQC+FBSGhzP9WEUoxaT9XX/Fj8DO4npI5DbpR2JwtKYC56y9XhHEz1cRdcmkVz/Y9TRX2fmViGOao1YsFSeOiENpCkRUHMmoV9cLoyF/wfx/IOsYQSDnmyrcyUS5HgevX29Ix5eDEZcGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfPWSDoMvFkH7EO9VRTVMyHKPHuHq5r7aCzJtmS8BzQ=;
 b=au/i4smZvDCs0Vg8sCjBg6plBPxrAVqTt+SJjNPvS0vh201g8gLfoy2CwPrvUOd/0LrpiZcEWenwuImojVovU5vVNbxB698Xs3/4wtB0Ah0Ft8HJsVlGDC5ACQyMfZTetGOLUOrXGPD2Q5/dkgVm/8rRPn5kgT1F5BAbh/NROuLyUA7IvW+hwyNni1ztLVIR+gzL0Up0nqO7eTiYWYoZ9PVxBaj0i911yA1xzCybhcNBDfntWUP87c9WrgwPu0BNOe4RyxLNVOllD3Oq+xtgvaHd/RS1YDM/o7abRza8g+2nQH31QFXf/9Av5uhFPQo8U6U/1cezsa4iJ/FsmXvEMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfPWSDoMvFkH7EO9VRTVMyHKPHuHq5r7aCzJtmS8BzQ=;
 b=1ZgfuflV3mYDKploqBaBzwJdUvdN4wG1h9wb1MTavY0azWUtiEGUF26Lr6J6gnnEd/8/KlBAySwaeaREQJIXvgLFKF0vIJ1vrjBc07+oaVklf+XSb3lM04gUs80837zG3AI48Z7H0OQP4P6G1CnK4xUuBbD8siDq2TEOf2ayYrs=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4893.namprd12.prod.outlook.com (2603:10b6:5:1bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.26; Fri, 20 Jan
 2023 16:38:42 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%5]) with mapi id 15.20.6002.025; Fri, 20 Jan 2023
 16:38:42 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: skip psp suspend for IMU enabled ASICs
 mode2 reset
Thread-Topic: [PATCH 1/2] drm/amdgpu: skip psp suspend for IMU enabled ASICs
 mode2 reset
Thread-Index: AQHZLOxnxauWLwIvy0S6TTgCA4/o9q6ngU3g
Date: Fri, 20 Jan 2023 16:38:42 +0000
Message-ID: <MN0PR12MB6101433C103500AE969F98C7E2C59@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230120162858.1580755-1-tim.huang@amd.com>
In-Reply-To: <20230120162858.1580755-1-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-01-20T16:38:41Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=2df9ac99-47c7-46f7-937a-30b808536fb1;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-01-20T16:38:41Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 22a45372-9aaa-4a16-8294-fee510fc2371
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|DM6PR12MB4893:EE_
x-ms-office365-filtering-correlation-id: dbb3d4df-b3cf-431e-e711-08dafb04cada
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 38M57OEMTWmN8c5s+XXBQcTWegkPM6rO0cA9UAY0l0FcuE+vHeQaNsnBWnZUNSv5d3xQPcadqqJ6y/oB3dUNmhsGVTHy96rELt+MZDslc3RgWF8pJKeyVY7PA5Ya6CngYnz2scLjYWKm2EtfGR2euUxwC+Onb++Ngzz6m2S2QK3pJAJF8Mc8L3etxyQmvDRe0zTevJZvkNMW+j58ZPbVdTrs6sPxp0KODnXTIyTAq+lfKJsx0o7FASjWKGtk2p4KvfouqexQM79ce+BN2D+/cIlhtAL4l7y4x7mf1qpKwrcEez2N8h1v2vgR7JDw4DB74KzvXYdZa5rjSihDcCMk5onPfzhu2ggUT4iOORdPdin1kjfo25XBkWVDpc8deVprlXDuEzdoaaqzgabhe20osk0w3Ufv+phNOf6kMb9o6YSM+vDDRORw+r2BjIy1krnLsLYYceclARDMHCY5xg3dufW0YL4azyEb5SZSVjfinhk6ByS2XFwR2puZtTGM+xR6jwI2LatdlLf7TWPVAw5hfoJSmElCjqBWkyOutuVSHG+k4vKXv4gv4vOtyBsaHApxagoCHLUJTeLj0fRoCVuVmRPtQROD0bMnRlEkBf3qY6EN+TkvQqxzmvWHO8A29m1LgbJsVCXnMS8mMmPZoBO0/mFjhtIFDP5e9elfoXN1/EisAa6mQx5A+yUNNM67AZZEGfWe5ehFfasY68fLtQ8F6PvSy0lvPPs9lcFtoLpaBKQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199015)(122000001)(38100700002)(83380400001)(86362001)(38070700005)(33656002)(66946007)(55016003)(76116006)(66476007)(8676002)(4326008)(66556008)(66446008)(41300700001)(110136005)(64756008)(54906003)(316002)(15650500001)(2906002)(52536014)(478600001)(186003)(5660300002)(9686003)(26005)(8936002)(53546011)(6506007)(71200400001)(7696005)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9+OhDzV3aYSxgYFmL4sEc1FY5faKNvbM+g641DEHJEZuP8kFFfi2FpcJjKuE?=
 =?us-ascii?Q?no5FDQDshY872UqDppwW3z2BVs1k7W96jmd66sj4oyI1GVRsiYsYoCFar8Gt?=
 =?us-ascii?Q?dtlD4Z7t7xJPhfpAMvsYLCvkt3Nwj8jN7OodTqEp3LE2nXaedsGCH7VSoRpP?=
 =?us-ascii?Q?KdtjGQK8mcH6PZ3PsPZ9+4K4Bn1fAMF0NVIlmMz+/key5IN9MCsJjQukrl2m?=
 =?us-ascii?Q?+cvk7CKiZaWYcN5HEsecdN6CJuWIzgyZBf3xguLfgWv1+8CxVxmENwJXujBW?=
 =?us-ascii?Q?61pFDLeyGl1Pfg4xnaDFeOAEn5vwJ9lS8ScX0ICOK90fCI9DB2UAt+bTLbTW?=
 =?us-ascii?Q?PpcFN8WjbCNQZ1pT9AqR7m6fOT9lmfH887mz0ye4ysX5DB7ruyisX3MTGpcK?=
 =?us-ascii?Q?MIg+U4xAyYfue8Wt+HSzv/1AXIWIAfuyS1rmdkWjfsgQedbMtxb0NSWSw5Hr?=
 =?us-ascii?Q?oiVNx8nlLoqaCzjwycNcwEeO0kPKINCQk7/yLw8bzQueBEfly8z+JNUyoxaj?=
 =?us-ascii?Q?CtxrqtmZ5NygOmyWZNAt9haCDK1VE4oCsFBwi0TD6y5X4GVXZX/w1ChCu8J8?=
 =?us-ascii?Q?+xwfuG7LgA+2oVIR+uKsXEgRWXZbfuO8QoxmP5sRTlbopqsiv87K5ZEVn0wq?=
 =?us-ascii?Q?VN/t8R9Uxo5Zf6D3bdLysxWulf+lqF3lxkjp/owIOM6LGP2LKNCToNQ/An6X?=
 =?us-ascii?Q?SETbJIvvHrDwfp0D/tejRF/v6d4PnA/tubpYAfmJlytTfmrYcMAsiIKQLz2s?=
 =?us-ascii?Q?WfvYAskCcxrMU9ZC+EtXfGggxebV6musS/Tcn6Br82tROvWKuQ7NGKLGmOQA?=
 =?us-ascii?Q?nFDUj0EwKnl+0wK/xfIUGnUD2FQ51YS9GUzcACQR0gatbTQ3EIR+V337fc1w?=
 =?us-ascii?Q?eIZiAKD0vIm1B5egdM105g3nT8/a4uW/JPZX61UVPY9W+ri8vWj5d1o5WzeP?=
 =?us-ascii?Q?NpeByCiSyZJu8Q+Ii31lu+nIOOrOBBY9kFCY7Mlx4Y4YpWN/keYvwyPXHNRO?=
 =?us-ascii?Q?Vh1WseOCEnL+U8be2nNx+YMyMeWTz/ZWWAeFLlTgQgB9TivZpuqcA3ONza9f?=
 =?us-ascii?Q?G1tjsXojjj2+H5hzS57ToKrXA84DmcrT79j017T2PIJnuZS85+0+50etNFEi?=
 =?us-ascii?Q?pLT7DNg60Gal0J+6h8hRaXSpM4OA+KEdn305ao7iF+Y53tQFutRbPQrQRhDi?=
 =?us-ascii?Q?7DX+La+JB8l/EBemXTglglrlaFQ52Nfm2j78YuoDalbjyY18ePNVWoTu4sEY?=
 =?us-ascii?Q?hE38jSwtukro1AA+cbQTpQGURQMy7Ux3DMFS1Eg5W4TlyMtmTlxxawIwTmng?=
 =?us-ascii?Q?EO1igK239GnzeIEF6bXvNfg/06HMbATPSy7H2HNX2oDMbo3mGVKrwr2VqWRK?=
 =?us-ascii?Q?8V+J9ccYmngFefDWkqsXPEpp8e2u0custZx2tbt8+aKu8O/9BtTiRL4PibV7?=
 =?us-ascii?Q?5UNIzO18AI7+Y8YU5pXt2HLpdKP/wkQyKCOqYnetsXuvuHdGeKK3vKN7Izg6?=
 =?us-ascii?Q?1jEhA7OdYtz2EYhFQ4xDowVw6lwFJLSAP7758O0lutzKwNvNBjnHrwdyMGtd?=
 =?us-ascii?Q?1dTjQn8f/euFFjIzJ5g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb3d4df-b3cf-431e-e711-08dafb04cada
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 16:38:42.7506 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yc1y+V9HywiZal4gDXdwVMTJqoQVBYC7kw4VVwu7UkNFYGV7QWCzc87R40EybKW9yYjBOSk5OaBV5mlxihBQog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4893
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, "Ma, Li" <Li.Ma@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]



> -----Original Message-----
> From: Huang, Tim <Tim.Huang@amd.com>
> Sent: Friday, January 20, 2023 10:29
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Ma, Li
> <Li.Ma@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>;
> Huang, Tim <Tim.Huang@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: skip psp suspend for IMU enabled ASICs
> mode2 reset
>=20
> The psp suspend & resume should be skipped to avoid destroy
> the TMR and reload FWs again for IMU enabled APU ASICs.
>=20
> Signed-off-by: Tim Huang <tim.huang@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Please also for this one
Cc: stable@vger.kernel.org # 6.1=20

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index efd4f8226120..0f9a5b12c3a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3036,6 +3036,18 @@ static int
> amdgpu_device_ip_suspend_phase2(struct amdgpu_device *adev)
>  		    (adev->ip_blocks[i].version->type =3D=3D
> AMD_IP_BLOCK_TYPE_SDMA))
>  			continue;
>=20
> +		/* Once swPSP provides the IMU, RLC FW binaries to TOS
> during cold-boot.
> +		 * These are in TMR, hence are expected to be reused by
> PSP-TOS to reload
> +		 * from this location and RLC Autoload automatically also gets
> loaded
> +		 * from here based on PMFW -> PSP message during re-init
> sequence.
> +		 * Therefore, the psp suspend & resume should be skipped
> to avoid destroy
> +		 * the TMR and reload FWs again for IMU enabled APU ASICs.
> +		 */
> +		if (amdgpu_in_reset(adev) &&
> +		    (adev->flags & AMD_IS_APU) && adev->gfx.imu.funcs &&
> +		    adev->ip_blocks[i].version->type =3D=3D
> AMD_IP_BLOCK_TYPE_PSP)
> +			continue;
> +
>  		/* XXX handle errors */
>  		r =3D adev->ip_blocks[i].version->funcs->suspend(adev);
>  		/* XXX handle errors */
> --
> 2.25.1

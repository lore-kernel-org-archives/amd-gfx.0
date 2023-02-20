Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861B1C05027
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Feb 2023 16:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2056A10E1D1;
	Mon, 20 Feb 2023 16:56:46 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1981F10E1D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Feb 2023 16:56:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4j1ueU0h9cm44cqJ3K5/NTmkNYFS4VY25DdWcf10EXP8SUNuY8jDpu9DZ7HCTLGQ4o+TW49Q2ecGabXoi94rUSdSxdXHGh7o/EP3IUZO2tXzfR3qzI6LWOIMfJ66Wo33A9rzr4F9/5iXRBXFXPCl4MNcSU+A1UIjgCbJ+QeinNpwclSFoPWCM5tBfv9qAUqy3zv0Feh8nni3EuPo8+q85gnyisNhJ5fGNMh2foUU4LsL8yfGuD0o85Nwp6hcx6Plo90tFGqi0d6/ZRdDoxNwIsY7wyq9cVSduuR29+Jb+r8if89Vk6oQComuErEo5pRP/q5aTEZa7rZpnL/mOOQKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZDUuYsniHaYsjILG03FFKnP1azHAaQGd40nalBlMrU=;
 b=isEwF4Y7VBCzH8kVaBOf8mxoYxdNRasvVx65JW69wKuYPQf2SK2vXxfk9REn0iFHZEEQxfRMA/r25X1bdqDX5wzpIaWaL1I40ihrsFRetRbn+RHt+eTaKCd/crm3iLSU0mnSK+Kd4F/n1Hc0aF1qffGECp1jlX+KsME3CynDxzz2oq/rYe8MWMkIpj0dHk4WDlMDT3FQilGTMTv02et/IkxJp+gtbTlYB1UbUowk10g2vBb3FdwCIu3fY+C0L3BT8vD07/R84iKJtLguyeu1DHeU4s4ZtiYVziiN+7C135FWs9KooMNZmC0y/2XPhjOMmi+6811MK1rKSDGQ0j1H6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZDUuYsniHaYsjILG03FFKnP1azHAaQGd40nalBlMrU=;
 b=uVbZTMX0E5fsg7OMwgPljk0xejkjcxV0ljNWV0mK+1aHy+3UxoPmq68hOZpul2f9s3qk14T+o+2Qju1QCBnW1+1HKuqyd3AKhNOZxbfIn0Lt3Z8FqQDcj0c7LvSGY56NT8KR93wZ/We7Vacf+vE/LHVqL/aaNW1Y3ykoJ+QLBS4=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 16:56:40 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a59e:bafb:f202:313c%7]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 16:56:40 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd: Don't allow s0ix on APUs older than Raven
Thread-Topic: [PATCH v2] drm/amd: Don't allow s0ix on APUs older than Raven
Thread-Index: AQHZP++iqTyuv8QiVk+K3qmgTaIHEq7YGIWg
Date: Mon, 20 Feb 2023 16:56:40 +0000
Message-ID: <MN0PR12MB6101412F199DB12681D0D565E2A49@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230213211030.5295-1-mario.limonciello@amd.com>
In-Reply-To: <20230213211030.5295-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-02-20T16:56:38Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=97b4bc72-fde6-4460-a9a6-b9a550b1c2b7;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-02-20T16:56:38Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: c9cdeebb-5885-4bfa-8c86-dc70bcfcdeb9
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|MW6PR12MB8705:EE_
x-ms-office365-filtering-correlation-id: 98e31301-0d1c-4feb-f3db-08db13636fee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nDT/rqAmDb0Vcz/R9kmekcMCb4mM/DiHsTgqz+T2p7Vq9gkXc18HSIFCJ57+IiVBpp0LEbXskgYZlyfJmOfKwtB74Qn+BFzo6Y9rai9Y45ia7jVwKpl7Qut9144La4MMas9jCMkNzKFR8Vp6a5DONkaN6+ZENXQkPu1szV12KKHAOobPGWIXzW/GLGg+SzkFHliKmim9YxTl4lOkTRQF4bdjeeAFrZ/gRiwzXBDC3YK+o9PekcHNqMMi1KY8HKwM/z+TLMYxlcshef+bUv7l/BuPCW9GdSvw9PCwTSpcFLIDxmt1CJHhAvv17FeIKLpot7/Os+yqLl66VAY0anKcPDpJ6w/ZLqLJ48PUiYPwBxy5Dmaj563w4VSJH+/T3OD6wourJKxmjne/0KKuCORw5/umJrjI5pR4LjoJTyLW06s+xpuv9GB3Tv3/DPNn8FxkpOjE2g4rdQ/uZnJ8mCepTMvfshbhJONKkO/drD+S2nXmA3ut110x+6vWoHsjQv3xvSyuMb+bbFioqb3J2eJNtHV1dkpvoefzhw7Rv/czUzCSP01476Ei1Mr8DzpUrtQiXUYA6zx3y/YryTsFEBzbotajSVHSgqWO9U+zivwl+c8uTDsAqKjmFzX13+xnnwWnylXRGMvN0viR/fmzK6gZm+GatdpPFx86jPIPDXhv1Jluf4Yaf+mnY/wY92+RLSIfcvFDEeIu2Et89qfskiLGLpPHPfIfAxsqMw8p3I/WXBI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199018)(5660300002)(86362001)(33656002)(2906002)(122000001)(38100700002)(71200400001)(7696005)(478600001)(186003)(9686003)(53546011)(26005)(55016003)(38070700005)(66946007)(316002)(41300700001)(76116006)(64756008)(6506007)(4326008)(6916009)(66446008)(66556008)(52536014)(66476007)(83380400001)(8676002)(8936002)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JDSVM/WW1LC/ANh8F55QbLiU4UkFLIF8/XGXMjrxJGcyCp8ioEC7ikKNH+dB?=
 =?us-ascii?Q?eeVRuqtJqJBMa3+to+DfkCAc5tSRiKu8hVpb1Z80QD5OgCKXEmKXwvb3Gnfk?=
 =?us-ascii?Q?OnPwdHTEHFG5TB2V3Rps+wz/xPYot+aQmwk/ULAXC5pxK59bL622hMjx8Hre?=
 =?us-ascii?Q?OkYW45kOuTKI/DfGekKfj6oHgeS6cpRbGdb6rTW6fl+0CnqAKr6+yl0vvUkG?=
 =?us-ascii?Q?s+XN8V01SKDq3kE8fDwi+u8Oz7MvaP7R4FfPncd97o0AUXcKPgKxsNEjO8dr?=
 =?us-ascii?Q?j3M8Nj3jEvExFy8uakSID367Y0PAFmkkdrq1UfzCCUl+pAebPxp+7wmEniiI?=
 =?us-ascii?Q?Rb7TuTPxC8OhMpZXgi5cn3yAN8GEqyjfXUoeP5yobhH9bwXo4vQCvV1Gm0IU?=
 =?us-ascii?Q?Qi6y5IRNfw+e2qfTPoNzOgdiTx8Q4yJ+wkh4hSBwOiUEkuRmNavy/2IYip+7?=
 =?us-ascii?Q?tmIxcHCKzWgP9b80UpeKSfBbahCI24fPYiDPQnWdNksaKrLccIvRPbM18SFJ?=
 =?us-ascii?Q?n5LHzXSbFURB47ei3xhS4AkYuPGGLAwyQEiY6TiqeXI3A59mHwdft/lDjFqU?=
 =?us-ascii?Q?fPhAZBiuy217gfTGbRnNkMlTsS4GHo1v0AN4rC/wZTgRd00ayg3SUP9iscjW?=
 =?us-ascii?Q?YJLLFlEX8k5Ih8MR01Gy9D/UR3kV74zZ5+7JQTwbozUBGbfKBNroJ320Jcn1?=
 =?us-ascii?Q?6a+nItJsSZ3zOH2hSkHVm7OvjKs27Cfs1ZxffiHGzuMxnssF8NTiB0ZxjqUC?=
 =?us-ascii?Q?YMm1oIYXxEJD0n8RuobtsC0+2Qd4isMAIO78gdiBCFXolcujvo+R7JEy4x4d?=
 =?us-ascii?Q?pgS22Zi2XyOPD0clkGv05/gtKomcp0ai+nyTfuMLC1KbTZcMWi+vXoI8Ya/5?=
 =?us-ascii?Q?D0sK3ZENdK4wWbpmIKH81m9UG1FA7tOrKgA+vJG/CWJWUD54gfatmhz8BMJ/?=
 =?us-ascii?Q?wuOIv82iF9GgoaOYB3q1Sbw56p6bkoehVVGDbc7Aja554OkhIwrzg0rszYPK?=
 =?us-ascii?Q?LK0qJlFZ51pueUFuKeBpDpShh3H1jG4+GIm7KCxcdaWAFQQKZ+n2zCLYE1id?=
 =?us-ascii?Q?dz3HtVoyEbpHnmpOZxCeGWeWq4vx4JOzV1Te13/NfDSzar7atnYw0R0B3PJd?=
 =?us-ascii?Q?DWdx9g3NoBsqs5y1mQ144kWq50miq6RH1XGNwUt5fCeDre0U8r6nflgFy/zY?=
 =?us-ascii?Q?FJuDkr4jSg6ODK40FaDYqK59ZKpK0JlbZazmueC9PVYku4zo7e8WpzCfIHLb?=
 =?us-ascii?Q?YghgmDYGr/XB++6GFToUFlX4ri/bPjdYDAZhS4zXZHzKLPLTPPej7ecDuLTn?=
 =?us-ascii?Q?o9RGSn3Nwwo3SYYuBrVv3M0v/rY5qoO+4kvb5QJldNs29zY8p9ndvMsgN3+y?=
 =?us-ascii?Q?gZtv/h/gEt02UxKbLYfWsr3Er4hJ6/4kH0rhrbdSLGRUEGztpT8CdNvBePkI?=
 =?us-ascii?Q?AhjOY6CYrxF1tmZoetJD6WFHgPX87Jvk3GHMbY/GBDU9BFEbf5DzRxOv/14Y?=
 =?us-ascii?Q?GQcQSExjulQ0HPSV9hgAB1RWyAp7xhGK0dtfytor4O3hW7XVQu5LHfMnqPpF?=
 =?us-ascii?Q?EBytM9sHIhzTTQ0J9+c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e31301-0d1c-4feb-f3db-08db13636fee
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 16:56:40.3365 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vBdeVEUs6LJjEW9dIzi1DWqIlfHWVLCuynjeeYckuYyKiiueg2M1mLK9Xd5TXZOOazqqLg3tt1+yCNreYcSAWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8705
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]



> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Monday, February 13, 2023 15:11
> To: amd-gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: [PATCH v2] drm/amd: Don't allow s0ix on APUs older than Raven
>=20
> APUs before Raven didn't support s0ix.  As we just relieved some
> of the safety checks for s0ix to improve power consumption on
> APUs that support it but that are missing BIOS support a new
> blind spot was introduced that a user could "try" to run s0ix.
>=20
> Plug this hole so that if users try to run s0ix on anything older
> than Raven it will just skip suspend of the GPU.
>=20
> Fixes: cf488dcd0ab7 ("drm/amd: Allow s0ix without BIOS support")
> Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Don't run any suspend code or resume code in this case

Any feedback for this patch?

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 7 ++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index fa7375b97fd47..25e902077caf6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1073,6 +1073,9 @@ bool amdgpu_acpi_is_s0ix_active(struct
> amdgpu_device *adev)
>  	    (pm_suspend_target_state !=3D PM_SUSPEND_TO_IDLE))
>  		return false;
>=20
> +	if (adev->asic_type < CHIP_RAVEN)
> +		return false;
> +
>  	/*
>  	 * If ACPI_FADT_LOW_POWER_S0 is not set in the FADT, it is
> generally
>  	 * risky to do any special firmware-related preparations for entering
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 6c2fe50b528e0..1f6d93dc3d72b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2414,8 +2414,10 @@ static int amdgpu_pmops_suspend(struct device
> *dev)
>=20
>  	if (amdgpu_acpi_is_s0ix_active(adev))
>  		adev->in_s0ix =3D true;
> -	else
> +	else if (amdgpu_acpi_is_s3_active(adev))
>  		adev->in_s3 =3D true;
> +	if (!adev->in_s0ix && !adev->in_s3)
> +		return 0;
>  	return amdgpu_device_suspend(drm_dev, true);
>  }
>=20
> @@ -2436,6 +2438,9 @@ static int amdgpu_pmops_resume(struct device
> *dev)
>  	struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
>  	int r;
>=20
> +	if (!adev->in_s0ix && !adev->in_s3)
> +		return 0;
> +
>  	/* Avoids registers access if device is physically gone */
>  	if (!pci_device_is_present(adev->pdev))
>  		adev->no_hw_access =3D true;
> --
> 2.25.1

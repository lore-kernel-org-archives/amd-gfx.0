Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B761C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 17:15:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6177710F3C4;
	Mon, 17 Jan 2022 17:15:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7918910F3C6
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 17:15:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MV/pVhQVRWmBdD3l3EIW4eGuz6nWvuGnxA6aBiEmTDRvRwwJm9qKXxXID8P1R+k+kfIuTlbTF8OH/SSSg/4VpFAUQ93kVw0dxOpCz4MN/CvKCA2WBh+Tk2iF0f8dbH4jrr1FgRKUH/AewdBP52sVUIBPvQmxFpjKB8c9pwaDZaeXAULKVIn5QX86tPvDA0r2zJlrd6QM73QB321gY9HcW+SfdZQ7aPvcAk07FQ5TAMLQP68jo7z7K4SqqFnasHGfA6zyObKJBbU7WzDJbduxuddyWAxNDHy1j3ITE0cWMZumvqZF1R3+dLxhjzZavGi0d4+CeJYyYOe1LolV7knvlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDiEs0FihQdbAMi82GSEr6MvARSbJPa8vBA8KIbc/+0=;
 b=eR63v3GWXVEbpIcQbf1DVOuX7nLshVqORjova+d+7z0Uun2aR+DZnsuMN6U6b9mStOQJ50o2JHC8xU5/8ZaoBCki2d4/1D7k7Cc8MVn+PN2B13XYjNzW9Jlr3AZNz6jOizowlnNNDwDIumNwf2wF0SKxWHWQDVHUB0lOVxs8gorriwxOlaTjPIUvFc5UwV5XZdvua8DuTOaJeZ6hXH4MGcDWsdYZiAbxR5vtETGf+uhUCYncFFgtph20fwRoxy2imuXnni7aeHREXWxmPO7NTNzN+UiXbQiMxXrFPfm1Ai6FKeLH9Wjdaei6uJfc6ZdxdExTURPMSXwfsfBr3KPhEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDiEs0FihQdbAMi82GSEr6MvARSbJPa8vBA8KIbc/+0=;
 b=nBvdlS6TI+ub5+utDb7ittmDMSE6Zedm3AYDE/om0Ia81Bg88WTR7BGhyr8MLmEOKkHkDtWDToXXDrusJrNv3YRXGj0XnhMuUBVkntNDpfpLVqkw98pPLbQcoCQNch7+/f+B8K3TAPNXX1B6wTvQVkA/Az7YHfGb8HLdSciG3VQ=
Received: from BL1PR12MB5157.namprd12.prod.outlook.com (2603:10b6:208:308::15)
 by MN2PR12MB4485.namprd12.prod.outlook.com (2603:10b6:208:269::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Mon, 17 Jan
 2022 17:15:44 +0000
Received: from BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f]) by BL1PR12MB5157.namprd12.prod.outlook.com
 ([fe80::42f:534d:e82:b59f%4]) with mapi id 15.20.4888.014; Mon, 17 Jan 2022
 17:15:44 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH v2] drm/amd: Warn users about potential s0ix problems
Thread-Topic: [PATCH v2] drm/amd: Warn users about potential s0ix problems
Thread-Index: AQHYByXifc5BzR5/BUKp3P/SNW4846xnfToQ
Date: Mon, 17 Jan 2022 17:15:44 +0000
Message-ID: <BL1PR12MB5157190D878C197F8EBEAE78E2579@BL1PR12MB5157.namprd12.prod.outlook.com>
References: <20220111200026.15855-1-mario.limonciello@amd.com>
In-Reply-To: <20220111200026.15855-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-17T17:15:10Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=21f8effe-188d-4b7c-91cb-66d27b68d8ab;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-17T17:15:42Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: aea79ec5-4104-4b85-a640-a86b6d8b864b
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24baedea-1069-4f6b-022e-08d9d9dcfee8
x-ms-traffictypediagnostic: MN2PR12MB4485:EE_
x-microsoft-antispam-prvs: <MN2PR12MB4485B8920F3DD79A06D75E69E2579@MN2PR12MB4485.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tH6ibnY1N1WXNl/efuOCEaDFCqcsdOh3eoSuG532s7xyDG4kHEaJnt5tnPOH+SPHfdW6qx3bo+3aROFkydqkoeOWVjFgHT6fJ+3FZfjkokd8tF4xYHySVbe6gpy45ethFgPrQ5XPb+aiHvl++scWWJy3WtsTd9eW4sSKKq9mzmfaWGMii31f6hAtEZJ4sK7+lJDkrXvU1IHWeoEBTgoiMeez2bPYz3g9FCdtfTB27v5GoDmAZHk1wVkXiwTrxKpCai2gNgojIaMuf5LbSywbBgQrEhQ0p8ORTHpLAqQzI4cjKi3w24fOiu8Pj/yNJz/6gVATxQAiz1BVmRuKFrc8JrIyiNuOICF9u9vx+3RmeFQLfdGA6fysXlhtBJjuDlqO9HXxREHZcgnZYqw6yDvkqdwRgoBoXbI4gPEzhFeFoDuaQI/G12iV2NZq6A6ZTSxv5oFIHlX11hxJKYn1hrM0XftYiwpl1R6nqak1p9M0B9LmhDeJcfQsyoHTIHSUdfckp5NXBgfU3RfYLWj6BXmy8liMNpELYtZ2ID5Ar57MQOgktPHVuabnb1hi7ONGYBBUM//0ILHqiF50BjOkAIHuwD2GM93U4sFl21puv9BUEaI+iHtdum/J1W8b9Fk4VQUjXVx0Z24ZHb7eGRJ+5BA3OpQfxpVyyb0WQirI+bF0C5bs1G05eolGvX3NyZpACkNVBGtfuL4+uuUrmo56X+TILu9EQTYP8fq1F/gH7QqYBy4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5157.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(8936002)(38100700002)(122000001)(86362001)(186003)(55016003)(33656002)(8676002)(71200400001)(966005)(508600001)(26005)(83380400001)(66946007)(316002)(76116006)(66446008)(2906002)(38070700005)(110136005)(66476007)(66556008)(7696005)(4326008)(52536014)(64756008)(5660300002)(6636002)(6506007)(53546011)(32563001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hK5k9m/Zkxmb+ug7s+zGrHrp8NXkQp8VP9Zx4OiozIuNOaCP47qNSZZSz+jM?=
 =?us-ascii?Q?Q+6ZSXTF+nbUtIRlHZrDUHQwWo0MkIyXihoq27cnW7gjk5sEo7Imz5Yesz13?=
 =?us-ascii?Q?QwuyhHVwv4BxY9wi5fEi/Mbh/UBBT0vFnALgnMZlGltXQjOj5Gy/sRNhTG6y?=
 =?us-ascii?Q?542eX9zeR1hPyIikvJtEctVhsbEv7Y8yPUMTAn0pUqgo3GNOo+Zs+VyrNVZT?=
 =?us-ascii?Q?M7jG6Mx5x0U8FRu53zW0awaw+H9PTXLRcfsjKPYFMUWBlCdIssKalza6WbL0?=
 =?us-ascii?Q?Xij4hqDy47SubGcKeW1aw0OQLDhsXINLFMdqfoqNzDEHWsAaZyL6kZHVKlil?=
 =?us-ascii?Q?4tLRYnvKR1OE5Q/ih3F5kA1obvGQEjjVETvRaZEv3fwA/RUIxrszBIgWUO//?=
 =?us-ascii?Q?2V2t8yA5JKaTHoCHxDZ7KpdeopSFBx/eq03znT4TX3zqGp3lqDTP0ghLI+B0?=
 =?us-ascii?Q?ML7LA1qJztryoTcPmMyOiPVFU2QP9qYBDfXOqKndsBoclyFgHGZnjZEDNdpB?=
 =?us-ascii?Q?svgU1X7jQvW/HGzNcpzNklCmUuDmAjO4POkuOF6hvI9BEHTdHDbI/cSgTHWW?=
 =?us-ascii?Q?udLnzFVP5+jg1osxI2Xzf1UtEBoLCB/gblVBDXLu3YKlZ+owi2e1c0wRHJt1?=
 =?us-ascii?Q?166Bw7TKZsn0p8XFZ9RtsWbcnWNUlpjw0W+SD074ba1UvnrA7xO7oyVtgnfK?=
 =?us-ascii?Q?garPWI7PuR3U9iPaIIsEP3LgrwqYsKvgT32qu5F6nJJj9oDZk0uoSzyIqGcg?=
 =?us-ascii?Q?M26ZXtrl1D/aLJkmzg614hactVuOfpM9uM5mQ1Q5P5ciqoiGVDjDpz1BB1Qi?=
 =?us-ascii?Q?Z2EMqb472cEuiQe+FwoTAz6yEbBVLJOvYiA3VyF5QXVnS38JjZy0L3rj2MKN?=
 =?us-ascii?Q?9nvccmmjcsMCSEiBpdAMcCwzio30IU4dbnGWPcOeb9k+EHphCNmgP3Lg3zIx?=
 =?us-ascii?Q?nkOzWDTF8Iwbvw3ey2U2EWOFtnJHecuLld3oxScqlix6uLMG/u0S/Q4zA4am?=
 =?us-ascii?Q?2fyFtt2Lr3PXS/oIZ8OEHrARBVQ2bdaZWASHQESHslD4Fbu1iflxinjdSWVA?=
 =?us-ascii?Q?ICGUSMq+M7lr09RNhq8ph5sTx57U6Fe4VCsnPDz/28UPuk4bksLeHBz510Do?=
 =?us-ascii?Q?lKeBfLrJb/RTkmIwqwQbEox7LWeEe+4acg3d1fiw9oSduYDGZkAcI/LUYUKc?=
 =?us-ascii?Q?+NvCaczEx75mjIo7JyyxEMzWBat9sunpZ1ayP5uR64qw9JbWdQACJVDy/aMN?=
 =?us-ascii?Q?L0Y3PyHMgqQZh9wNOB+E2Kj9Pmtq+zB0DCORAOXPKDSI2b2+EA2TCH708Nk9?=
 =?us-ascii?Q?A8lKh8subKd7ESbQ56tQorMtSk5rLXvxq9aHfVFovbacNhIxHNBLOVmAMpOc?=
 =?us-ascii?Q?k4cBO2tF0y8MYP5l5xLdHmaTE4F2e87J2lmm5aeRvYmv7QGsGLgvrnNrpr4r?=
 =?us-ascii?Q?PGCEq6EGkRNMWArKJPJN9vxjTVznUSu8J+39L0xNnttTmNsOpdVDypHRhC/z?=
 =?us-ascii?Q?8YOLvoAsS5I6p4FEXirtqlEbySBgoOon5RYSA42lW0O6s9wUVb/B38kVHhB9?=
 =?us-ascii?Q?ivpb0RBzyAnmbZiwwOgKIz4ID4N8qiGkFu0bZ0+NcJG2TAE657RUDoDVOXJO?=
 =?us-ascii?Q?Bg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5157.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24baedea-1069-4f6b-022e-08d9d9dcfee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2022 17:15:44.0880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8pAU4roqubu0SOr+gN5492SBV0Kq9Y2AM+y0O+/+sMw733c2X5vwbJPCIBCDnOXSOjpu78G8bXSy40dDQzO+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4485
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

[Public]

This has been sitting a week or so.
Bump on review for this patch.

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Tuesday, January 11, 2022 14:00
> To: amd-gfx@lists.freedesktop.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Bjoren Dasse
> <bjoern.daase@gmail.com>
> Subject: [PATCH v2] drm/amd: Warn users about potential s0ix problems
>=20
> On some OEM setups users can configure the BIOS for S3 or S2idle.
> When configured to S3 users can still choose 's2idle' in the kernel by
> using `/sys/power/mem_sleep`.  Before commit 6dc8265f9803
> ("drm/amdgpu:
> always reset the asic in suspend (v2)"), the GPU would crash.  Now when
> configured this way, the system should resume but will use more power.
>=20
> As such, adjust the `amdpu_acpi_is_s0ix function` to warn users about
> potential power consumption issues during their first attempt at
> suspending.
>=20
> Reported-by: Bjoren Dasse <bjoern.daase@gmail.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1824
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * Only show messages in s2idle cases
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>=20
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
> -	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
> -		if (adev->flags & AMD_IS_APU)
> -			return pm_suspend_target_state =3D=3D
> PM_SUSPEND_TO_IDLE;
> -	}
> +	if (!(adev->flags & AMD_IS_APU) ||
> +	    pm_suspend_target_state !=3D PM_SUSPEND_TO_IDLE)
> +		return false;
> +	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
> +		dev_warn_once(adev->dev,
> +			      "BIOS is not configured for suspend-to-idle, power
> consumption will be higher\n");
> +#if !IS_ENABLED(CONFIG_AMD_PMC)
> +	dev_warn_once(adev->dev,
> +		      "amd-pmc is not enabled in the kernel, power
> consumption will be higher\n");
>  #endif
> -	return false;
> +	return true;
>  }
> --
> 2.25.1

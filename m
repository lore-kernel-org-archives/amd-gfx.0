Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D61C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 02:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E230C10E10D;
	Mon, 21 Nov 2022 02:21:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85E5810E113
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 02:21:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPbjyzWZvQSuAI+fuuPYaGUXbqmDBI5vEdHyOjRVLPVN4R0VkXuUeltGSg1Om+Fz/DjFItysxzX1q4UttY/i9bxo3sdPg1RPOIK18sF50izXgJnxUYtVRH43b2+Z50oZNh5umDYqgB51qRUDZcOvjMUfAhsIl7zbxfs0RsJydxae/s4uYo2UHtJaNDZtM8RqLwDHncyQSi2/uU2nESHYk+gAFuZOEICoKPxKRgfvsow81Q4dRkJ5uZ9Rf8Cz5GfMZTVUT78Dh4XD2x2ujt1Q5HBeiUJL9Cegv9n3+dZtsdM0pNlz2yG/wazbuG6JAbB9pwNhZNqq2QqUVfvNsxL07g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=In2QT+c2RVH1WhArtCxvReOCgCP78Zn53ncWfyt8v/s=;
 b=OYmKqrJ5Gxc0kv66PSpcffBdZMzX2q/nIXxnrSnN4qUMqzhEteVTgYvZwdEiRbW/7tSbf7eO+O1EArCCfa+knePSdqGSvrCnGxwOX2DSUjgLGd7SDIxjn5kTEodMMWRJtvkHUNHtjjhNm71itANfsG0VAR1x24gPg0sszX5h/wnECfdHTCGl+xR8RyqzRePLkpxFQaubd9aaCUQmCojvZ4eM5iUTVcb20+O1JegxOnOe8TWoaLaE6Les9mxRANcz+Q9zirxJTkUPFPZ7CU2fWcvaOpTi8HEvQt6JvfcBQFsVBqFAyvd4UT7bi1qnq4Eo0y64P96r4oSu6GVHlMyP1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=In2QT+c2RVH1WhArtCxvReOCgCP78Zn53ncWfyt8v/s=;
 b=p6plpF4yQC/s+tMUPgfOrZ+C5VuSHp24a7joO1Dma1qNliN26Fpfwu6NHlSWn9me6miDhUNbLd/Qo9sFZe5xIHRIk8vRyDkbIka+gpNW4wfpVqXpRTcmMq1LeMYntY9l1ua6iaskKC335ljt6uaM4zM815mOS+2ZxTHtj6F7MPM=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 02:21:45 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::9440:1b9b:2878:832a]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::9440:1b9b:2878:832a%3]) with mapi id 15.20.5834.011; Mon, 21 Nov 2022
 02:21:44 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: poll BACO status after RPM BACO exits
Thread-Topic: [PATCH 2/2] drm/amdgpu: poll BACO status after RPM BACO exits
Thread-Index: AQHY/UHCjBcEPxSBdU2lz64uG9LCaq5IpLQQ
Date: Mon, 21 Nov 2022 02:21:44 +0000
Message-ID: <DM6PR12MB261999E51C1BE24AD3B4F56DE40A9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20221121003929.3296266-1-guchun.chen@amd.com>
In-Reply-To: <20221121003929.3296266-1-guchun.chen@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-21T02:21:41Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=681b7b4c-b919-4527-877a-32e39fdb70e6;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|SN7PR12MB7226:EE_
x-ms-office365-filtering-correlation-id: 8ab96bca-ae41-4e43-fc08-08dacb67225d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BZ1IXfIO9vZ+CeIjFWn3/oVcxl8CUsZlsTMWhaZyBR15g48is0UgILGBu15niHkSdWL8GM3XGLFWQYqFpDQVmpBziyM/yfa8clDFxsC8h5mnygGbkirqQXPhpZj/8ye/4N6aTjgKnUEb8O5xJJdlgADc1uiG6a66Xej3bZCUkTRHv7WQFEc/nPmTLG6O91eJT/RgZ8pJlGXalyUPB7DeJi6lmTdS6+3gqaaKq6zD+mVf98qyNrNbzdgVSah/D7FdY8wBXzD63fHL2711i+ztRg3yknlOt0g++s2iuPdAsUgLFkdJrBciI8lxnAQQJFczyVnCOcJk9YeGN6Y9LF5gnk7es6BEu/wZWo8yvUzEnYnM8drM3JavBbOTcURD38nN4uLWKKWr3xs3AjjgaocjlwMb4xoioiONdWI2q2toymwSK8QXOQDjYi43JSjmCDhL8IGAJxM3gPRnZbZsmSe+Bx9fsflUeboWkJt2KpUmPGmshklY1BJNTU/YjzEfKzSN0ytWTvcWoxms0Mu5Ojt2pSC086uc27dxI5F8XKDyEk85zhrk1fSGflV5h0hPIL1ElwRj9DOp6GLyLHr2PPw87VPdGPTIALF6wCDOMPCdyPC7jhmAPlV4yVBbdyBdDKX+s6WzxRghI6YpCEPvjjuFIQaJH2yIthc54zmpv5Lpc2+Ag1okjroTxjd4z2W5y4XpG+TbzvjApaBEamyjWS6ljA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199015)(83380400001)(33656002)(8936002)(5660300002)(55016003)(86362001)(478600001)(38100700002)(26005)(9686003)(122000001)(38070700005)(71200400001)(52536014)(41300700001)(186003)(2906002)(7696005)(6506007)(8676002)(64756008)(66446008)(66476007)(66946007)(76116006)(66556008)(53546011)(6636002)(316002)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7+KNKGG452hwWJjEi/MxZMGxPeOfeXduwA0dzySH+xnR2Wqk0xYuY3a5WjWl?=
 =?us-ascii?Q?DB2UQCe4zIiEDHP6KcWiACgGW1UsvIxZ9bsNolQrw6k/z9Wb3UF1lrf31D3X?=
 =?us-ascii?Q?HJjH9ZMEPD0QZ1X0GfP7iYqipQlDyuvR8Ub9M30XDxrNgfR3vet7pqw+TI+6?=
 =?us-ascii?Q?CJLc5Phn0/kuabuXrvNIlQLpLyo2pHn6FM505h1OrPLPPldyCW5W7UDIhrlS?=
 =?us-ascii?Q?ieQuW5b036MpijN70k2aqvSWMHnU/D2lvlEEyM/XGuazmfVovf3VeI/iSsuc?=
 =?us-ascii?Q?9SbpruCu+vV2BUSZ1KmEWDCleEapZkO3DEoDVHPDFhLFH4xachTQBgLNdFYo?=
 =?us-ascii?Q?e0SEPOMxjDTMq4XvZ1Cb6PKvby9hWHPBPCtCr2puhp3FSiVhmY7G6LrId55D?=
 =?us-ascii?Q?mXp6mk3Y5ozwfh5i2WSZzpeZt+i/B0BOXKAgWdXY8dscrIc+m99546SnNwAk?=
 =?us-ascii?Q?13AXiQTVAs70tJNfYve68hiD0v0in5kzNs3c1Pw4EJBf6DdqJ4tvwdfnIV0U?=
 =?us-ascii?Q?Og+WsLzoQZj3hCFACSqqGhslH4W9J/Yzr/IPabPJRS0HdvYvXHp3hTs55KK6?=
 =?us-ascii?Q?pVFqRHcNRSMcVbMum/Hfmq6o2AHe747uF3MZud/JiKNlq6m34foHBZiFJ14Y?=
 =?us-ascii?Q?jGWt95PA17yZ+T7Ay5xJupugqOg6BvTs4kVA108v6w9QOuwRKFBnHMdE35Fi?=
 =?us-ascii?Q?vKd5a0B4fpgVjSZb1depPWGBz+qmpOxC3t2raRf+UvLHg2kt1OlaO2mSKdlk?=
 =?us-ascii?Q?s4/2wA9qIJTnu+m6XU6DqwEusglqLy/VNM4nL0aZzZvImUDMg70S6GXSQnG5?=
 =?us-ascii?Q?DWBoB90olyWxnseWT4NbCLWY8o0D3ywbL55nFSTafp4DyY8T9hlo1lxd51kB?=
 =?us-ascii?Q?+meP25/W/3A4O48yLX8/+dzWiMnQxp0mx4LkZNpcPPZEJ48EC2Zd/71tC/ZJ?=
 =?us-ascii?Q?FfX9V62C311nchLUy0aEgSVQv0pZpTM3bZmzg1dbF03W8pP/OudsMR728WRZ?=
 =?us-ascii?Q?V6iOu5gwqdaU6vINWTrpRjvc80JIw+NW58of1FM3fVGZX37RsY2ZCe9PoEOC?=
 =?us-ascii?Q?7SN8QBpGQlhitMvuLK0z7ncBZ9WhQiP9pqJ5cfet/eF3aX4M1ddfuVbmBjYL?=
 =?us-ascii?Q?T9J5Cz38ApnPGg718KZuT3hUNndh97CakfbVIWC6HggQrlFxxBCuh/SIKzFc?=
 =?us-ascii?Q?3e4KMJfq2jWJu/nto4aY7kG94tmsJunIVeHPn22oybFWHJ+UZkhuIa5XmcUR?=
 =?us-ascii?Q?2lPM5ZXrj9474dX27DQ1aBo8ZuFvra6vCEGEN0T4kpXKn7Z0G9rs3KK3ysED?=
 =?us-ascii?Q?z/a6vhTHL/w/e1myU5ZVJZq7+jvhpJ6yyGtOL2MwIXnmzPa8BCwASDoh56E8?=
 =?us-ascii?Q?6Z5QDpdij7x7FP/xOkvj18JuEN2fAKyJ8Dnx4lqqpklUBnVi8z1wHgkKbLy2?=
 =?us-ascii?Q?/spB2a0VB0birN0ObwhvInzJgbXJs8PYcw5uwkfX8JrjgrUYbFnHcghaOvLf?=
 =?us-ascii?Q?jgEokm/m1uvP+edSdAQ++rS0FXbeeXtLbUmqaKTB+dmsW1XoTZaR12kahM7U?=
 =?us-ascii?Q?YHf/txoz+VpLZUXgbYA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab96bca-ae41-4e43-fc08-08dacb67225d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 02:21:44.4532 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4tD4CojVT0s4a9/47xoFUlAi/aCtqoXss8f58Nh3kMH21fDYkIpj7PUQv+Hj2/vS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7226
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]



> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Monday, November 21, 2022 8:39 AM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: poll BACO status after RPM BACO exits
>=20
> After executing BACO exit, driver needs to poll the status
> to ensure FW has completed BACO exit sequence to prevent
> timing issue.
>=20
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 23
> ++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index dccbd9f70723..796c8179bfbf 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -79,6 +79,16 @@
> MODULE_FIRMWARE("amdgpu/beige_goby_smc.bin");
>  #define mmTHM_BACO_CNTL_ARCT			0xA7
>  #define mmTHM_BACO_CNTL_ARCT_BASE_IDX		0
>=20
> +static void smu_v11_0_poll_baco_exit(struct smu_context *smu)
> +{
> +	uint32_t data, loop =3D 0;
> +
> +	do {
> +		msleep(1);
> +		data =3D RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL);
> +	} while ((data & 0x100) && (++loop < 100));
> +}
[Quan, Evan] Better to update the msleep with udelay. Otherwise, you might =
hit some checkpatch.pl errors.
Other than that, the series is Reviewed-by: Evan Quan <evan.quan@amd.com>

Evan
> +
>  int smu_v11_0_init_microcode(struct smu_context *smu)
>  {
>  	struct amdgpu_device *adev =3D smu->adev;
> @@ -1685,7 +1695,18 @@ int smu_v11_0_baco_enter(struct smu_context
> *smu)
>=20
>  int smu_v11_0_baco_exit(struct smu_context *smu)
>  {
> -	return smu_v11_0_baco_set_state(smu, SMU_BACO_STATE_EXIT);
> +	int ret =3D 0;
> +
> +	ret =3D smu_v11_0_baco_set_state(smu, SMU_BACO_STATE_EXIT);
> +	if (!ret) {
> +		/*
> +		 * Poll BACO exit status to ensure FW has completed
> +		 * BACO exit process to avoid timing issues.
> +		 */
> +		smu_v11_0_poll_baco_exit(smu);
> +	}
> +
> +	return ret;
>  }
>=20
>  int smu_v11_0_mode1_reset(struct smu_context *smu)
> --
> 2.25.1

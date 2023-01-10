Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F5BC54EBE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 06:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 103D310E0C9;
	Tue, 10 Jan 2023 06:48:52 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 695B810E0C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 06:48:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlalOcjPGubrbb1+YszQtQlBtNK5dp+ribcPY/FxlOwcPo6fmGkXD/XOhAPseyH5Uy8/5IgvkB7lPa7CJ5fBjddPJYATs9G3dIhvfL2gj6DxtNYEywlpuStVYy85UF1heDqhsh1bPV95ssTyHjEe7HEazdsQe34kaZCtuTDPEtIRfUKGWoojTe36vahQcUgJsOyLLWNnZ3aZHeN2JEICjOpQF78qK2AtAmdLN11+5Di+8chb+xq6JFWWLeM6HyyZkBtVO2lh+TjqCkkNs9RSL8WZUPlJVwyc84wEuB84Opr0ND4ryV0G+wK7EeHxC8gL67/xx16IUguNsBECJ1E4nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nT3/8tZTIc0qxjn2lrMdqUnrn8vU3zezUG1oFIAGEok=;
 b=e6V06SAm0kqW92OsYV2rMtUqE+kPbLF988gljAnPX9MYve6sdNblGOTUneAP4Qu5jlfj77Cm40xu/hyYsE5jZRt5BqCpB1WCF3Cm6+6nwNvFYTPMBlRf0QM4HJ7lpCkaIAjn/e58Gjtw/5p+oW2DdLKQTnmgXATAnfi9XUzfrkNBs+Fq1+4yHMJT1En2aNxKgBBopER7Ic8pu/fG4/dnoZXeavEBrjDFKaHfNhqzRLK47lR6XAMihay0KCgD3GDEiVnJSwPI0z/lPtG2HlB9ONCf1oLR8Phy3OFrX30fz9JSO63z3dVmUZmQBkuhOKu2sXj62pi2nwtHi554nu+03g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nT3/8tZTIc0qxjn2lrMdqUnrn8vU3zezUG1oFIAGEok=;
 b=CyB8tOOgsT49E0IvOCW7m/1lA7QGx9jwuqnHFE7iJy/BsUBxFAl59tgUsQRqDTD9waNYINAbZYcgI+hAnw8jsMBEjWJL9YqWbypXsCdIHPEMTgW0EL0LZ/mPyuY3/60hzPqs3Mj8jkiob/Vt4OAjScnfTDckZGIJIYioadAai/g=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Tue, 10 Jan 2023 06:48:47 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5dc8:98e2:7b6e:a9db]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5dc8:98e2:7b6e:a9db%5]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 06:48:47 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 8/8] drm/amd/pm: drop the support for manual fan speed
 setting on SMU13.0.7
Thread-Topic: [PATCH 8/8] drm/amd/pm: drop the support for manual fan speed
 setting on SMU13.0.7
Thread-Index: AQHZILUVoTOA57zzmEKoUzm3sYBq1a6XPS7g
Date: Tue, 10 Jan 2023 06:48:47 +0000
Message-ID: <DM6PR12MB26191B413EDC7BD52A9D0532E4FF9@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20230105032259.2032789-1-evan.quan@amd.com>
 <20230105032259.2032789-8-evan.quan@amd.com>
In-Reply-To: <20230105032259.2032789-8-evan.quan@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-10T06:48:44Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=02ed5909-f565-43b6-bf75-23adb4b0a9c1;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2619:EE_|DM6PR12MB4250:EE_
x-ms-office365-filtering-correlation-id: a396f16b-7471-46c4-e658-08daf2d6b958
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1VE4xhvHTAqMsMqPhd8MNmtV2ioey989MIblWWj84RmS6Iq+XKtF8TfmT6K89HSRob3SIWLTDe/QaJjaJePI/hQFkjFfx7uXkyih32r6dm3UvoyPu0/pB+UKEuVyHnJ82rhNTLwto21T9BRscH9KlVtWf4vphqRXMMcl3odMgb0r7ZJ9NXdn167dSb0FTP2D4ImqHECYe+jmIw/xBPicRTGMeW1Cm43B8kJAuoUpiqVbIyHQ3N/DoKyhw+oj9l8v+wub0kpEjeYfvSh6VLLrtsb2Q+tWgq+CinjBExGLuGs4A5/aiFXoeEuwziNNWOZr1HaxSplc9SClG5WbB1p3yHhn3FIvLbA62YtVTOySZgAmu1hjFkYeuVvQp+EiyFEXNFLpZ5/fNUwgq008ycGmMuKhK6WCxijDfPfpPCkyY7HAvgosf4BBfsay/RW6zhgYehJhcoYLbubzO49R9ko153b+bo+9anhfWPq+b4FJ5LPKRJ9HP0lWwybmH+A2rflwAfjve5jscj8Q+eIJvTCvenhiM/Xdz78AOlkFYGlVyhWlA1tQaQr6yY/dOEqmg/z8liKGC9CmziBiSOA6SDX0vkcvpuzGZ0dPn+fnVhtX7IrnfockM7n8XA2e28dyx6xGbvDlW6EWhyQDn4drcQZNGZ3yTZPevxo8kuVKMIPyB6+T8rMPTTyWZeBBsZTaLHqZS1pIloV8pRzJXo5H/5GhIhQI3es6NPrzDFBrR2RiwgbmGfx2Wric78sP1CaFM5kc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199015)(2906002)(83380400001)(9686003)(55016003)(66476007)(64756008)(66446008)(66556008)(33656002)(5660300002)(7696005)(66946007)(53546011)(122000001)(52536014)(26005)(8936002)(6636002)(186003)(6506007)(478600001)(76116006)(38100700002)(110136005)(8676002)(41300700001)(38070700005)(86362001)(316002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JMjYiac1Y9WA9po3Jo1/0hlkfejFzLcYETXZ2KpB8TNoBUV6ZZdGU1RwhFIZ?=
 =?us-ascii?Q?EydBeUJ4zf+QQ/15VCR2VKknaBKFvE+MD8SzwrEOP92EDBVHbCbEsjbaSkzz?=
 =?us-ascii?Q?w5Chiz4tAnxCqPWsAR/JIwJp/N6lqJ2ParSf0PCQwTqUWiy1XU/Q65PA1yVJ?=
 =?us-ascii?Q?7v9qFl7GodbPoqj+xQTob+d5m/RZGD11vrkWPaFAckgCAhYC4BJWk9ostzwD?=
 =?us-ascii?Q?Sq3qDx0ubupEqrbvCdC3D8eZI2QfEHhwMgZuzYtz1aCBqJyjMDVSEAufXsjz?=
 =?us-ascii?Q?yYP4W14KDGV87pgB3kseQ/veKaXE9bq0AvUGTAUmTGAtbaic4kt3EoG0Tl/g?=
 =?us-ascii?Q?w4qfpIvFoPWT1kvi3qvuxtRGEisZlvPFCVdNZokaX8dm+hdhbNtx5QELEb3+?=
 =?us-ascii?Q?GRox9hIG++19nYxAT7gD6KYYsMyAV+L5vqT/9pJ7PpX6NNWhxeifDxsHfaHa?=
 =?us-ascii?Q?RAHf06gRZVijRJ4o22g3c8ep+43e/vNLyytgcW25v7RaOonrqvA1f6fHTup4?=
 =?us-ascii?Q?iRinjucHT+apHsFsqiiHnucwO+LPJmw5/NRpdDl369hTCwEMxbcboq7GiYrj?=
 =?us-ascii?Q?BYhoOB/zVjP7A9UBHW5Avdao6sn0qXVgnYvc/rOo9lm0Qq7oHMlW4rc5LQ88?=
 =?us-ascii?Q?SVE38cy391wS3DjJIWUZLmRZRMNf81igngh7JHe5kt4kPdT0Un5VTY9Vldil?=
 =?us-ascii?Q?FTQot7dhgKgo9q2p1B6BwFdHAqv6G6gBzqIZ6eBw+cOalEW4ozBbmniGGDjP?=
 =?us-ascii?Q?5OvjFvEJiQVW1V5vyl17PecsnQLPxRICSCda//oGuVODr5vcAqIhp6yIcBdm?=
 =?us-ascii?Q?27LMoxQEqAfaBjl8vhAeFz4IF/K408z0xGgYQvwiBQOV5ycps4tlWYq3V7qC?=
 =?us-ascii?Q?bhwFEYgL0Shgk+YyIRy6aNFKlaHwYs7rHsIZqfYavuoX+pMBjmW2/Xh+pF8k?=
 =?us-ascii?Q?5FGtwUC/2kKqvMFCf9e6mtdwGfcp/KDQfui5d+7vU7jEivCwnkSv+MEKO/Jp?=
 =?us-ascii?Q?X4g95rnhal80VicUdlbdcwCiYJlkRJKiGEqyBqGWckb/1TyxLD+TOKb/LGxl?=
 =?us-ascii?Q?ORWcsRPD4GK+BKC5schhj5ede9+hquDwV+AYmeTlDEK7LWwRGGc+BEQrgRsK?=
 =?us-ascii?Q?OOctSg4nh0F6M5aycnjjXrCZhnBCWTUwiFSFBTicJknmaRfzfwE8TkOUWcw7?=
 =?us-ascii?Q?jly81LuXiVEcUYXfQOw7YSvDDFZv3w0hs84VWtvqy9MZo0vOuRhjWxS1ADTH?=
 =?us-ascii?Q?7xPgljoUIpIMei04LidS108A50VJz6hdljqt5zMT6qV9arGYUQ/bJK/WLpOL?=
 =?us-ascii?Q?n4rTd15hmy396htydkDa8ryM64+mfAApXrTwWD6xj5qUPLbRoKsPVvcpII4s?=
 =?us-ascii?Q?mCpVw1wsoU02Tk6nXYq4ijQriyoFEtiQS2GgIm1ID2ffPAhlJiIvPSbczjMn?=
 =?us-ascii?Q?k0hjJBKWpoPssZ9KzDgPTyh8fzpADP7i8/j3NOd6fXF+rwK0qxreeiDvj2ZH?=
 =?us-ascii?Q?cRAzpytr5iMe7B8hRpxNOl0YsQ1kXa71wJl/F4BEV44PKDPCmSW87wSQrFXK?=
 =?us-ascii?Q?w/vRF5j2i20fTPH6YYs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a396f16b-7471-46c4-e658-08daf2d6b958
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 06:48:47.2411 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fI0U6eCP2bs8jsMfkcXMsIL/Bz5deaax4tC6biw8B+pxzmYT38FScggYmq6pxZcd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
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

Anyone else can help to review this patch series?
We need these to address the fan speed setting failure reported for the new=
 SMU13 asics.
@Deucher, Alexander ?

Evan
> -----Original Message-----
> From: Quan, Evan <Evan.Quan@amd.com>
> Sent: Thursday, January 5, 2023 11:23 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan
> <Evan.Quan@amd.com>
> Subject: [PATCH 8/8] drm/amd/pm: drop the support for manual fan speed
> setting on SMU13.0.7
>=20
> Due to lack of support from PMFW.
>=20
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Change-Id: I8439e72b95ad2fdf8cfdf1edc4d9c8af58109dc3
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 3608540f2034..c7fa203ec7e8 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -1736,4 +1736,9 @@ void smu_v13_0_7_set_ppt_funcs(struct
> smu_context *smu)
>=20
> BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT) |
>=20
> BIT_ULL(AMD_SYSFS_IF_PP_SCLK_OD_BIT) |
>=20
> BIT_ULL(AMD_SYSFS_IF_PP_MCLK_OD_BIT));
> +	/* Drop the support for manual fan speed(RPM and PWM) setting */
> +	smu->adev-
> >pm.hwmon_if_attr_mode[AMD_HWMON_IF_PWM1_ENABLE_BIT] &=3D
> ~S_IWUSR;
> +	smu->adev-
> >pm.hwmon_if_attr_mode[AMD_HWMON_IF_PWM1_BIT] &=3D ~S_IWUSR;
> +	smu->adev-
> >pm.hwmon_if_attr_mode[AMD_HWMON_IF_FAN1_ENABLE_BIT] &=3D
> ~S_IWUSR;
> +	smu->adev-
> >pm.hwmon_if_attr_mode[AMD_HWMON_IF_FAN1_TARGET_BIT] &=3D
> ~S_IWUSR;
>  }
> --
> 2.34.1

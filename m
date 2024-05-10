Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301F4C25B10
	for <amd-gfx@archiver.kernel.org>; Fri, 10 May 2024 07:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A542510E5AA;
	Fri, 10 May 2024 07:21:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZIqyW/qy";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7050410E5AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 May 2024 07:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DayfTOpdbhFK6Sn8j0SGZqWiIJaXjJ9awPBZn3MCB74MxlC4dSXnVPO2zTlFUmk3nw0sTTzUBWK65/l6Th2OVJrmvo48WZb1vdCfhM/wTr9ThY5wBCFUaS23/RkGt883/y72V5oH50eqgw5+wltXA7YI2OCX9WgWEoliwHS9Mb0reyE3Wr9+JNQMULq95QgQg5ihLzWtguKnwejrJnnLC4SiPAq7zC8erD1RGY2FqtZ5bS+JxU9CzwXanqqQZh3CX9OqFGpcSJQHPEMeuqJLCu2PjdP/Zg1hu/NXWkLDacbrKMxsA2DgOo+uEtsLl+fmzyMpCtPQ1V8G1PhttIB1zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ykx4cxGaqo0c/EQmmv3gtRIS+MwZIk0tcKC/dfdTh9E=;
 b=dbEaWbjsZXuT4cAvphPs01umbUC9ruKH73APRnavrkZhRiF2nTwpmNVKl3Jmvg1qtkdDGV1SFKY8FWFrOaW5c/gbRtuT7VIrQ1cWgpAS9SNmsGSECPQBPxdcBHHDvkmtGoyvazPSW33ghtsBXFrwFkHnB7jIkXwc5rr4MlHOSv2xl0e/m/WDxze2EjMKOM8+ghHEadvSEs34uve0UcnrpVofIK0ue4ZtgG7KUZ8bPTbCo9Gdyh/4EKGZxcJyNwC/Pvih8cfFlFGtkmg9GaAb3f6X4V53FnJcxllT+jO8ZqT+D5Lh6yFVSEbGiKR976gaKyfNqLQ6jw590aDiBfLOTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ykx4cxGaqo0c/EQmmv3gtRIS+MwZIk0tcKC/dfdTh9E=;
 b=ZIqyW/qy7tB3WClmuuiWi3ZCXpCG86TBz4jImFYW1smCYt1vx0v1qG5AhYLQcElh8T++TItsCQSXnAmv4WIRvmGzzB4uqSKd/HZeA8X0B4vrg2TmbBP+eVZsOT7KitLE22NIyDbS16NjSy/ePvkYxtE8VosE0+QCltjtc/Vyj6Q=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 07:21:31 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7544.047; Fri, 10 May 2024
 07:21:31 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 09/22 V2] drm/amd/pm: check specific index for smu13
Thread-Topic: [PATCH 09/22 V2] drm/amd/pm: check specific index for smu13
Thread-Index: AQHaoqi8e57idY0KF0mvfnqsBYY977GQBBWQ
Date: Fri, 10 May 2024 07:21:31 +0000
Message-ID: <CH3PR12MB807483981019C2D11BED9C80F6E72@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240510070717.3496839-1-jesse.zhang@amd.com>
In-Reply-To: <20240510070717.3496839-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ff34802b-cb01-4323-a0df-2ba5df303d3d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-05-10T06:38:42Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|DM4PR12MB6328:EE_
x-ms-office365-filtering-correlation-id: c33d49f9-b8c3-4efb-b504-08dc70c1d09b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?P6aaFYxk2XQELXQLcVj7YemmlaW3JaGz4upKLSN9x3/dn3iIAX8M8WaRKm?=
 =?iso-8859-1?Q?veyDn9OxLZKh6Buqh6K4JwjV187Qx5tdkRMjiIe+lS4LcH809a03a44QEa?=
 =?iso-8859-1?Q?Kk7SH48Lfg5Cw7Rx1m2BIiMFb6mgliPZ6ymDuPO3b/WB7Q0UsSuiAgM1PT?=
 =?iso-8859-1?Q?aOrJ2MPtNmDAa0DS9R/+B3BET1NaypIUVoZkCwrK5OPtNkcY0/jymqOvHf?=
 =?iso-8859-1?Q?2xesMKy9QR2t6P/GSy0HAtr30sDaKHUTQPuaLc+fTjf5HFz1Hu0vaUA8eJ?=
 =?iso-8859-1?Q?13/alLZZ+2WY1Mco0+W/OWnminP2bJpgzjUU2fiJw8vlZElV8zwIDZJtHP?=
 =?iso-8859-1?Q?crJMJtLfvDici4Y8pohR2a9CxxAGSLPlDjLs442FwjQ90jxbEtMZhHpbR/?=
 =?iso-8859-1?Q?VO+7vIwWgOSPJ7+Lg/Y6fd0sWLaeNDDYvE7wnZ9XVinia6EIVrjU0Hcf/L?=
 =?iso-8859-1?Q?5uxajHBzxhjKaQizjHy4w8RinZiNF5asBi7Jbq4uf/TRgK/y1XTiQkgVWG?=
 =?iso-8859-1?Q?C8TjfNoCEIc56yjXSRibEH8ZOAjHQE9n4jVAbm/lRQ84FVIIcKr6EsQsai?=
 =?iso-8859-1?Q?aNe5BWjJC1Of6qUx71B63F4aenLXUTrjwE1PPlMqPdju/RCQdQzU/k5m+y?=
 =?iso-8859-1?Q?efW0rOkfCxuIL1RtOneUewy6YvSaE9dvLlVn1QKlCGYsCoZc2pPryjxBb6?=
 =?iso-8859-1?Q?JoPdYclOCwLbTg9bxBOLPreV4ihPSmwMI0/zffeimjQP0WvlLtInSo/NPp?=
 =?iso-8859-1?Q?f+EcHGWraKZchNKLP2Qwh0HzxHICYogP1ORqjeIRCmq2mts6x1wW4NvD9D?=
 =?iso-8859-1?Q?O9vIWEyoP2s70iQR9A0Vnb+X8yTipXxihwR27fDQD0F+uws01EjHCvSNnc?=
 =?iso-8859-1?Q?Zoof/0kbeNLbcA8U8YY6maRz42CH2ujgOkXuZFIMIEg7Z8wwRgatL6zOq+?=
 =?iso-8859-1?Q?ffyHoAkovFhUS9Hpry2RBeaXyOpCMDStGKOSSDERwHkXWj29Exp/8/KHqr?=
 =?iso-8859-1?Q?PSWXDZBQT93zCXKtZKx5WRl9oydlXCJp9FCuMGnSEoUl+YfDYCUtetQ5wC?=
 =?iso-8859-1?Q?9ax6kdI3OnIqbF4Wh8svKH8kQX6jXx/F0KamCDQtCZO0HALlLY5FLq+4Rl?=
 =?iso-8859-1?Q?usykp3eNLeK/3lNWXMYSgm6pwmbUj66ygi1iPEyN1JwbdSM7ichINHYEy/?=
 =?iso-8859-1?Q?byHI+5BaCpoH/GepHyLXHN+PtBkySLxezO0ruLOXW2FKir3ZQ8v1JYAyf5?=
 =?iso-8859-1?Q?Q2hxrcqzsfaSqOAr1QLrjlvN5KNodgwYtDprhHcKMQfu9vHctoICUceT0n?=
 =?iso-8859-1?Q?YNTvmrd6VD6o882U/rfl4Mh2+CYGo/ujG7SeUI6MmQce8gSXPOwn8CCuKZ?=
 =?iso-8859-1?Q?XTqDbGZoR7IFZRZxxQ1N5hyYs0ykCScg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?y8ZEnTTibdAAl3+1tXOiItfevTIefeGJc9Ca0QyVolu9yB4nu9jNRT3C1H?=
 =?iso-8859-1?Q?LIj7w9gp9oXFaDdJLoX7P8uNuQKJOoMYCOgxoZNtLvVvLOwuPzRVZekWTp?=
 =?iso-8859-1?Q?fNt09nPb3SNBuquwR29sS59l/NMJiW2oC/4TXw1eaLERx9OwkHPdbJGEn5?=
 =?iso-8859-1?Q?jC4sjQMSJQCFwCehkL3I71/fds0y9yPuiOju2lKejxnsCLx806BTD7QH6S?=
 =?iso-8859-1?Q?w6qBFCNI/VQsCd0tm/uXysRN6BDpJ7f67jfvs8F1Be5x6t2dpOcy1IdYCB?=
 =?iso-8859-1?Q?onaGtSYbo+dEbGtUSh+1MvojFBmUdeF5SC+0zb6FPyupj1faxrvikRKfQb?=
 =?iso-8859-1?Q?F9lLU8izFIT9QRiNGOoLQpIaDZR1IdnGu7lFQYnKN9C8Dnf9wWbaa1fADY?=
 =?iso-8859-1?Q?xyOovo5KyOHafEJ/A7Q/AxnsjNMsjRhuGQjsijOOW4PzyeD0GkSWPd84VK?=
 =?iso-8859-1?Q?4OkHzl2b4m6XyhXyDE1RYNd6Fnyj4WYRTGGrViwD8E4EPiDABsQs08NnR0?=
 =?iso-8859-1?Q?6BTd+sCo4M5ofVe9vGBiNTpy/QCCcadfDkPUkNG+HDHY2ixlXb+GIo41x6?=
 =?iso-8859-1?Q?c9V46/jpU5WYTTMiTqSF0EP0HblHLBk7UKa2qijqQm4FipSxZ3YmqXZGKL?=
 =?iso-8859-1?Q?wh7lDlcZ8hJ+t6IpIQewBJWa9G+24rLDAKsgEW79vCjIif3Rhv7+8j5eaY?=
 =?iso-8859-1?Q?cgpFDyGGTLe7ET+mwNXeH5BO6n1VZuJ4uOD02+L/jBbYokZ9L4OkWGE+lW?=
 =?iso-8859-1?Q?7BGQvPIrRhSQTzmm/u/m/B00Ds0k4n+TlXnaoQYSWTFmLROFbsvSzOAcb9?=
 =?iso-8859-1?Q?IXbbCATV087aArhToW79ddMNARukyonP3xD1BmbmAAGRDzqg90OeF/BBUI?=
 =?iso-8859-1?Q?/mKzH+juovpX08VJ0ODFey6Vs+nLV8ApluqcVH4EBuUSocy0pACCHJVx5Q?=
 =?iso-8859-1?Q?YHUAzVvaPQnUUBXyf5DRj8Jocg27TFW7Q++hg2DBXXXl8ORPqRS5+STrZ7?=
 =?iso-8859-1?Q?Puormd5Gqa3y4pg0s6PhlIGdnezP0JAiarRD4ipFgrqKNsTwxEl3T/0mye?=
 =?iso-8859-1?Q?2e+9k/4e8o2d89KIxVCTDJQNTLYViIPJmMz2yi16o/kJ+p0e2AmY4IAnyV?=
 =?iso-8859-1?Q?3Bk/4nhRx8R2Axd7g1ixfGM69Q+bPlcqiOHTbwQES8l2AHE7lZ+vkohRfN?=
 =?iso-8859-1?Q?dM+g7clEBvTGamGOD2OcSx75o60tRcm5b943b4VyC4T7J6lmCjfHJw/Epc?=
 =?iso-8859-1?Q?3PMvXW41WID4txUnobgKk7stsRXQI6lxFoGqN5UQQDp1AE7uYHzqvQQVtE?=
 =?iso-8859-1?Q?qAYaP9XbLnCJGNzmacUcsn4DQNqeGe21bjOtHzXDiHrHSfgcUHEErXIY/7?=
 =?iso-8859-1?Q?xc8ookTYOoVkCnDNrjN3mPSNnH9aMknHcOIhpHx2GWzKH7gQ33BbdDeF3s?=
 =?iso-8859-1?Q?Xyb8Yzm6C1kmATt6MINb/s5/GZyzYDuEStTIHBdtPkLKJJQPSsKZeivqEw?=
 =?iso-8859-1?Q?Nd0a9yK4vRhc4cShC5PAbRka6cKU9iSM0Eegz2I69u7F8pG3ntdXhze5zV?=
 =?iso-8859-1?Q?+v6LLvDu8i3I40FpmNbq8f+oJBs871biQRPxcB7ax3M9f6XOd5yucNql6J?=
 =?iso-8859-1?Q?4tksa11mHrX36c6yjf8c7fi6dPMWQiIH04?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33d49f9-b8c3-4efb-b504-08dc70c1d09b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 07:21:31.0311 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lCrC8wk1cWybNectxuiehjkyNzUh8lLNVBy2nrta7vVnu1DZ+jMyRlYbvyhWpan6OdiEzS7IoHMqxiVsxCmWkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6328
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

This patch is,

Reviewed-by: Tim Huang <Tim.Huang@amd.com>



> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Friday, May 10, 2024 3:07 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 09/22 V2] drm/amd/pm: check specific index for smu13
>
> Check for specific indexes that may be invalid values.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Suggested-by: Tim Huang <Tim.Huang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 051092f1b1b4..7c343dd12a7f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2336,6 +2336,8 @@ static int smu_v13_0_6_mode2_reset(struct
> smu_context *smu)
>
>       index =3D smu_cmn_to_asic_specific_index(smu,
> CMN2ASIC_MAPPING_MSG,
>                                              SMU_MSG_GfxDeviceDriverReset=
);
> +     if (index < 0)
> +             return index;
>
>       mutex_lock(&smu->message_lock);
>
> --
> 2.25.1


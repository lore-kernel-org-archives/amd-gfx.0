Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DDBC2BBCA
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jun 2024 09:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B0F210E1C0;
	Fri, 28 Jun 2024 09:18:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rmPnIyCX";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44A5310E1C0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jun 2024 09:18:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3oRhM0OYjwvm2g758UIQXvrYqOzRGRNIn2ubGekMf2AO+tcibjVuQc/eMwYyT0fgbr8TOq/W3V8yJWXZt9euXg5JS+3FgOfoU/3EoqKHDmYMtjM0ZzXyJn7ZZ1D3J5U4aal/yj5/buUDftpHQ6s0drpj8wgaI3eTsZ6dnREpziaU7NeN7Il6v3AvBqaXwH1+OUj2NVZITcqmP5++dLg0ldWgJH9DGADkXXZ9pHec2XjSPgLq3pnkyJSlFHTVcc4orIuNjcS/E7iYPRggZaYJ5rgEfB49uvMF1eOa65meXbQRLysGUvN0bx4OCbjEgsqtBjfN4V9A/pOgLjZAPWOBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6PDPh5LYkbpO/0xnbnbFHxvU7VxBbdwNNe2QF8Q3yw=;
 b=UZjjTgjKMAx3eN4R+YyAEUChAw/5MnVWS34712C+gWkU5T1cZT/52pWJV3E0qOVuZkOtHvrCcTdddZcO+5zuOesG+JcN4zQNt2xMtf2y8cGudM+KWWYfUasF6ghbfiQ/NUrf61RV56Yt0n88hbO0Qp3+4m1Y+7shQehrQBdutZQh/F3tWIdyjE2/kSVay10IFPC972JgyQO704vB5mmWVH+wpi7te9AEQh+5o+2CL4ak5C1Q0aB3RVeEiCazNuTfQ0d++N6v2cxsXFcjSviPETSjpe+5nybnUM/PMZ4gznDLYcQJ4ofJzqPfTg+H9F2klBF4AZy0KCR7aAtE9POglA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6PDPh5LYkbpO/0xnbnbFHxvU7VxBbdwNNe2QF8Q3yw=;
 b=rmPnIyCX9v7AgNkPkDGPAYOBr8T+lDSiO7Tr5YT15ulJID6KguFN3FJuPeuCvthFQOMir3/ODykIJf8iqOniitqEJHv6qpvEBVJubwF8dXSL0pEXvBFiYx8t0QoHo8vQ6jDV7M6YLO3wXrgGjewjLNBU7WE3fmcpH1hVVg/+W20=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SJ0PR12MB7067.namprd12.prod.outlook.com (2603:10b6:a03:4ae::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 09:18:13 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%5]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 09:18:13 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Correct register used to clear fault status
Thread-Topic: [PATCH] drm/amdgpu: Correct register used to clear fault status
Thread-Index: AQHayTosz03HwZIDpEaGw3zWuhT06LHc5aHw
Date: Fri, 28 Jun 2024 09:18:13 +0000
Message-ID: <PH7PR12MB8796EF30CC2C942AC490E7B0B0D02@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240628090413.6621-1-Hawking.Zhang@amd.com>
In-Reply-To: <20240628090413.6621-1-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=1b656dfc-6d50-49e4-82dc-690743a5b061;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-28T09:17:48Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SJ0PR12MB7067:EE_
x-ms-office365-filtering-correlation-id: 6962b5c8-87bd-4543-cd5d-08dc97533c6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?C7JCan0FIZPOIqG/DPJ0M/do0BSuPobE5WUBWKpXPXgeGW104xYE6Bd+odj7?=
 =?us-ascii?Q?+Hnlbfksrs38eL+DOEvTI/HX+g4Du2DaRL7jQkaAEXkf+N8IXl04fvR7RT1K?=
 =?us-ascii?Q?EHig8os7QtAqrffnFu/7CmtJ6TsPZC1BBZlE8OWrciRskZz2KV5mz8fkBde/?=
 =?us-ascii?Q?+6y7ZDuMUd6/icdNmGUj+lCgUFvTwvRaRnc+fBNFEPkeKSqYxFK+gWS9jFd+?=
 =?us-ascii?Q?/TqvnyAGPKJ59fbKdCi5YVBcmdacB2bZshNToB6qS6C5lzBlrGagfr7kOuJm?=
 =?us-ascii?Q?ExecjdEYgyGfaJK/PQQeAiaW4yoKgKvFI/Eekbo3+uzsXkf0BUSsxM81L6/h?=
 =?us-ascii?Q?QPHoDwnX8uR2/TG8/QZ7BR/M+RktckwCa6ZkCoGDgLUkykp55khVhEdEYBHH?=
 =?us-ascii?Q?JeKRtVxD0LRt7fuwACDlMH0eRPb6vAG2eE9e0FL0Pcb+u1lT2Jm/VOmk4Eoe?=
 =?us-ascii?Q?fgT8tYjfR8LNJe0pQ2WPOJgZo+EAdq65jEMLXAVS8AnjTFf6B0qH4UvMyWTJ?=
 =?us-ascii?Q?eAS/mXAAHk1U4WC620A2BSFPJSu1TH00D8UEtCYD5oRYQcQNn+Ua1lyc5ulq?=
 =?us-ascii?Q?SPjYS1gdae9gvZT7xhRgWFuiRJLf0QW8ZCueA7GiPUV+TzNkw4Eko1ly4elW?=
 =?us-ascii?Q?HN27ChKMLVKtTjnuLxXYlM2Y1NpOdVwSHFWY2ctKWNyaO6g6OSDughZV6j/1?=
 =?us-ascii?Q?mpNJyUrTuSGcSjBdRN/rBICi5L7J3cTUMSfdCurc+oqIbpQv7DyLYsoMkoXQ?=
 =?us-ascii?Q?J1ZSngeWozZ7Ai5hCQpMFd+C2qah9UyqBx/ALGVH/jloLyRbsuVZm1NrUFxn?=
 =?us-ascii?Q?pdsUpEk89cjIlURttnEgBTlUB/2q9MT3jtt4bpNZ23/Qm+6yVwnaI+CNEQEF?=
 =?us-ascii?Q?Fea6Jn4ylNXbwKfbJKwo6ZrqJUnGTq7XhNrm1SjflEm5R1k9Gr5M7DYJV/eh?=
 =?us-ascii?Q?FnDncmpqDpjoI14Xtm/T7Y8QDCrNl8qKnX5zm+dzY/Bqa40XwrhYFA2U2ZyI?=
 =?us-ascii?Q?2onhgcZE+VfNeMgmeTx+tdVvc47qo7wnvF9dv0pZoenltZSmv+PnVAvt4TAZ?=
 =?us-ascii?Q?yU0cml9Iv0HI05BtLsQOdVO2PIAnmLuHdJMuKwIEWI/gPrhS1Cjs9eyTp3SB?=
 =?us-ascii?Q?+RczpA6WZItpjsrRwdwdjQrlYVbBusgv+pvqiLYpnpghn5D/RhEmvLToxJTx?=
 =?us-ascii?Q?r8+Dn2FhBUdkQpV3BXLYbFg98x0xVpHmpie0WX9P8ylnBtrMsgvhjf9Npt+5?=
 =?us-ascii?Q?tNbpmkmLmcjlTh5oIqOq0L2TigyIYjMJzER9nI1a9gH7Y789prkX6KfsJzrd?=
 =?us-ascii?Q?qvmfw/E+DYX8lAB4ED0+92c0l0NNBDVv6L72yLglbldDmC/fzjyNKnG70LMW?=
 =?us-ascii?Q?UJn3a0faHYytuyHIPnzVHeE7tKE468DIvmm+OMDT+HvxXMYWlQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nFDRXB1w3JOJAlIY2tysguqObnUNEr4D/QoeEbO+xNZe8dfD701kA9/9MhVZ?=
 =?us-ascii?Q?UKkehAT889aWPejkJ+W5CgR7r3CuVZIetpWv2KWKn2CHNbs6tE8xyu7Or+tW?=
 =?us-ascii?Q?cG1fMYFKQ+hEas6KqPi2zvDeBSftB3955HWuy1LQ9f4+uxDnT+vJRs2I6LOf?=
 =?us-ascii?Q?z+9U7t4jtrkJFOKQ7TU3omIwuzbm65SCUNP3ozpv1Q/5AssRTMacy0hLgLOy?=
 =?us-ascii?Q?jD5ABSqnj7ex8VN5bNGFfThqaOJBP0h1gmEe34YpIF6+evYkObb7n2HzGDV5?=
 =?us-ascii?Q?4oK4kSUjg9hsHgbsiibXvIb6XdMmRiNE8r4elH1QbOw0vR3EvLDoSXzh9GwB?=
 =?us-ascii?Q?xMUDvaIy3QwwjY4xwK1xP1rY9jedRckliDw3EoJC8p/BLwIjILwDWBD0sJwH?=
 =?us-ascii?Q?nzrBOX/TQOloP3Zua5qnsQAaXK4pTT4DuGH7NRTI5T2ClEUqZ8MZ+TZPh/IY?=
 =?us-ascii?Q?0gnz2sLx7msq/BeGA+KIqJ1eKindG3GEsekcuBDNhLcEJOJcB37ltA4PSSJT?=
 =?us-ascii?Q?Tcq4dqWua08UMdOzoAMGyJUxBewqVKfyBS2dcYXaCmdQqsp8FGwgt53iicTp?=
 =?us-ascii?Q?d3jlKRHqJqdlsQjUQGAME5oTc4kmf8qphrTbPtd222ST+6PKX9NIezha6UFQ?=
 =?us-ascii?Q?bhITedYcxLHM6R4SOHU1LyBuUqcP62zLb/bxvT5RV0uYnShTXh3x1pYt9jq0?=
 =?us-ascii?Q?C1aL8gRFb5Fnpe2+Qxp8UdGIgaM8Q1fDXJvJkTKibz705aKC4DMVLge3r57f?=
 =?us-ascii?Q?EuKkw4h778Q4Y1nLiMRHU4g54JZcoDBiLcHhvHqVkXp/JDVdRn2Iw+6daM0N?=
 =?us-ascii?Q?Zpiou5lgXH0yuWn86wdf1JVcdRa9fCXAuRw3RpI/arwnZ9ud8gBVL5BqW5Zy?=
 =?us-ascii?Q?L1l68W7fuGiZOl3/yIfYJQ+Zjjh5yug7e3bcql41HLLgfk6dXr9CXH3oybB/?=
 =?us-ascii?Q?u3y0mT6zlrjLCBuYbL5Eqq1pGevdECyVB/cdKuHlLU/ircYY5vqE4aylWRgy?=
 =?us-ascii?Q?AAlBTYED+5VXs/eU95/YfvzGsBMoNnntzG3zrUVpXC3KnkAEq3xgsTAoOLjB?=
 =?us-ascii?Q?B3SUUaUnA5QZRsRBhU9c0kQSUxviCam4XUGXCyjozjc+mXitKwzM/Xfa5+zM?=
 =?us-ascii?Q?RhCndsSugt3JXHzZpUvW9QT1TzTLQRiDv7FC4ADTM3sPO4AsBPXd+qbOwEbk?=
 =?us-ascii?Q?N2yGI3K4sHu+5WIP7xVvV8IRRcwAA0UajSO2Zj8h9XPRBaiQFxWf1xi3ycpT?=
 =?us-ascii?Q?MzAsgUX06RF2w3NGMfGGoi1t07DYiW48RbefGovOoG+u6EeWmGFqOzIDe/ab?=
 =?us-ascii?Q?pYxLha+EQFsyTCvRz0Um7jkRuLTFNVPFuW96ZiT7zJeQQ5NnjbCfKL+n3CIw?=
 =?us-ascii?Q?CBR58SD+Z0GAw50bws/10UoPjRaCAhJaLIfC2No1hEsDQFjrbqXR5OZ+VIw9?=
 =?us-ascii?Q?M3cZrjXfW1osXjHhDetGdSEYnYtC/axoYo7PdDLI3pIhkJUaEhdY2KI55o4G?=
 =?us-ascii?Q?oBXOhXWteB1Yqzrr3GJuKDAa4BuvkSnz+iTf65s1nRfuLqfJka+0drThHPdl?=
 =?us-ascii?Q?J9MRWXShic+/f+IO5DE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6962b5c8-87bd-4543-cd5d-08dc97533c6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 09:18:13.1108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SbnieXJXgwlHD5XCzsOvFubo1SNUSyA2lsXTcPzChR1olfu48ZqYI0gKbd9tOem+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7067
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Hawking Zhang <Hawking.Zhang@amd.com>
> Sent: Friday, June 28, 2024 5:04 PM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu: Correct register used to clear fault status
>
> Driver should write to fault_cntl registers to do one-shot address/status=
 clear.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> index 8d7267a013d2..621761a17ac7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
> @@ -569,7 +569,7 @@ static bool
> mmhub_v1_8_query_utcl2_poison_status(struct amdgpu_device *adev,
>       if (!amdgpu_sriov_vf(adev)) {
>               /* clear page fault status and address */
>               WREG32_P(SOC15_REG_OFFSET(MMHUB, hub_inst,
> -                      regVM_L2_PROTECTION_FAULT_STATUS), 1, ~1);
> +                      regVM_L2_PROTECTION_FAULT_CNTL), 1, ~1);
>       }
>
>       return fed;
> --
> 2.17.1


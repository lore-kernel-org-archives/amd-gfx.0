Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC587EA3F18
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 08:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36F3A10E387;
	Tue, 10 Feb 2026 08:05:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RTTmKJmJ";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012002.outbound.protection.outlook.com
 [40.93.195.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A67C710E387
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 08:05:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgETf0kmoIKOd6CqCDlwG1u0bzu+n3XJKPri2HWbGN2zTS/AjT8ZUkNoCq4tNMWtDj2mjNyJqC1v41Scq+XfwFG7YprN6xw6GUffiWT6eanJk5vncLlLbK1Sw6yr4bKxJyRssTtCPQufBI9AR8weFEJzyiA3x2zlxKUTQpe0m2Bc8m5FbZc6naYIEKo6hLGezou8iZbnlQxw0gqQ/7qIfuMnjhKteEewky32vxtIRF4zKB1Ub4ItJf1jAVNlWt+wXmp+UEPXd3QuSmoWjdgZiicE9id2eSTgcphnm/ANf0pjtkKGN9le+TnO2GciVL+VSO4OMMWVUiaGS68VjEarzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIG4tBCsqWDLiaJvwgO7GC1KGJgLzr8AaMPT1pK/4so=;
 b=K7RO/bktWPwAm94GZ+K5CXJU8ErpVWlvDsQEKFTTDkp/vB51ZnfRXzhujKPUG7ryOVSFddltCOiUJqmvSneWc6Nlq685NaWGyJgVruvaJqyrSbXd5qYSCCnLKIsNlfNBYyqkYyOVUJkGIuW9TE9BN/p2W0XoROWq9QULP4+5ebx1JtIcoMm6qC7MeOdsQIhPhqMc21jaj6rtEO2oslWwAZsu8WxS0lq08sLtRvwC0JJqKbeno20m1olQfeqQfEzE+EmMYI2ZgdoHkAd+vgggKR9Spx+XZCwSR/Q1eRHQxM/8V70E0q95l3twEPm+a1klDPp6mQzA1DT6zzysE0jEPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIG4tBCsqWDLiaJvwgO7GC1KGJgLzr8AaMPT1pK/4so=;
 b=RTTmKJmJDNPUb01mwILrVTY7+F4WpwK9WXlMTQbQL62uJjqcgXQc+8YCKgAkYmViTHaWb6rdA3/qGQnt2cF053lGingxvi5J/SxsSrUGRJWyLa7B1nbtaKvM/MxRwlSt2yS49IA1CTDenewKR2xpmLPD50zs1fRyDEhN8RPEA4U=
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6)
 by SJ1PR12MB6124.namprd12.prod.outlook.com (2603:10b6:a03:459::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 08:05:31 +0000
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::9e49:aeba:9265:f46e]) by SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::9e49:aeba:9265:f46e%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 08:05:31 +0000
From: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: Re: [PATCH] amdgpu/psp: Adjust usleep_range in fence wait
Thread-Topic: [PATCH] amdgpu/psp: Adjust usleep_range in fence wait
Thread-Index: AQHcmmJHbs9Y8vlojkiVzgfhAHTvsrV7kwtC
Date: Tue, 10 Feb 2026 08:05:31 +0000
Message-ID: <SJ0PR12MB69676B4B8B07CBC47FEA40B39D62A@SJ0PR12MB6967.namprd12.prod.outlook.com>
References: <20260210075248.3017892-1-cesun102@amd.com>
In-Reply-To: <20260210075248.3017892-1-cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-10T08:05:30.221Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6967:EE_|SJ1PR12MB6124:EE_
x-ms-office365-filtering-correlation-id: c22effa2-9938-4f97-ede8-08de687b28f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|8096899003|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?I6EQjXJmfCf52ZpB9d7HONdYf4CwgVG/nWGEd8su4hak6wrNHSoyHt6cdx2W?=
 =?us-ascii?Q?dZvvx1ZX4mkz9mFkK7E59+YrKafNIbveQa6xEJME+Us9cQSs1cuofTx9iQ2h?=
 =?us-ascii?Q?ktX4zZxVkRFGnFf/3cr4PsWXHCEsSdpwcA2b+aSl2Os1buE18ZjXEOkvHNLT?=
 =?us-ascii?Q?5VsUeltQAbWUztFHTNb1o5+0g78qlEK1wkhqo7FJOSqGq/K9a+lPcz9hEE+9?=
 =?us-ascii?Q?FizwynXyUVJo29RRW4Enje8s5cebsoNLv0ceJ/ERLko2T/w6HW7Nn6Bd8Bfl?=
 =?us-ascii?Q?pznrhYiK6ZyyLugri1gpVJq3tDBxe7+4Dj7WU3PQAwjKFDK68RLC5j8/scf5?=
 =?us-ascii?Q?Dr0U2OaZqs13qfcWG0wPmXjEPHkx2X8/Sv7qLGMoDYBr7AdOEtRoVHjI85rZ?=
 =?us-ascii?Q?gRAialJyNoIz62KfM8LzXuJ4aIVddar0IG1ioNikgW8X5qkF9fFTqDM5O5EW?=
 =?us-ascii?Q?ZLjjcWI2cx0jddW8nbbWjDIQg1udzF25jZruvQ6MFVm7WiNNU/r1skVbEy4N?=
 =?us-ascii?Q?heXEewj4YNtFFrCjUlbFfTKp6f4kaNRnUfd+CWUlQn6NGsSff442ZcpUTUl9?=
 =?us-ascii?Q?8jv0PGiApJFVoj563nvBkJntWTJUEtTb9fbGJH8Clvj9p2F3Nqhd+qHHeTUz?=
 =?us-ascii?Q?7WDxBcrGsLsNRA0c5EVUKVXSGwuWyKw+7TNMObRHLFTsXms1oY47Z+I5wB+k?=
 =?us-ascii?Q?sCFLsbA6Eqr64MHkjwfzmiwOt7gaJcS+dGlB5r6jvSl/2zT3f3Qz/jO9E9o6?=
 =?us-ascii?Q?t5MOPSV0UaSxxOU+pDUMlaD/mbykwpt9QEI5XLaoLqMKDM9LbOPzNKZiaLi2?=
 =?us-ascii?Q?X6GY8Nq4vY5edtmS0ODt5Vq6VKwScWz5XJ5uQ88Rhe8dL8y/gd0skbZIztYN?=
 =?us-ascii?Q?Iga9by1mLW4S0xSh4eRQR6UigpiSOKe8XCD1A/9fpl1FZHx2xlRXrk8axnLv?=
 =?us-ascii?Q?rB4BoI4ks/UgxjS6bgkjMUmKCyAwoAeJaXQwtoMWQS5h5QbU3sDNkURJiXFV?=
 =?us-ascii?Q?RINzQsJwm/JYkj/ozMHlnWeOg5zy488QjSUzhj0G1UHB2UoEsZP1/Q4Nh30B?=
 =?us-ascii?Q?AGidN46b0AFYeyxqwgob5p/Vqp5rafsPmLmqpdeeypd/5UyWhG8+D+x/7vmY?=
 =?us-ascii?Q?sZEJQJvhjV72a9dAA9teHeAoIbQaex3kYE+RX2vpeCoWWFYLSoXHeMui7Zew?=
 =?us-ascii?Q?f4vDfQgSr5nebgm8RVj6CjgdE5GC8EMEIm6lWfw4bfCB3RmK2zL6OuvVeoJ3?=
 =?us-ascii?Q?aJMta/8zGXM3q9CPu0VipPAisSRJUhkDdEL5iDJ5AerW05JL9eJjfqW+wMkt?=
 =?us-ascii?Q?N3JcVMt4MqxaUwcH2VFXg+OmOBsSdPbkyTxc4eW5XUeNWb12XfYLJGYFD8Gr?=
 =?us-ascii?Q?hw0O7ju9aRNHla9Jk3uLZwIG170f7GRmFEi22GLqlsgXs/KIg25JRpJWhalu?=
 =?us-ascii?Q?td8fRrJzFGaUW7CfPe3hgwIf5MESJnu6fCBfeUdV2fHeFl+1N2Bs+wURiRdy?=
 =?us-ascii?Q?Cs3AQCPFnaALbdOUCnsApMV++MieohEqhkqF31isUPsnUHJhxVBg+2Q28JpX?=
 =?us-ascii?Q?9ZpzolQSHzdYKO3RhKjqiRjK9wqraEZUq3hAecy4+T1I8Q3c1UXcdZgKZ1gc?=
 =?us-ascii?Q?MYPJ1+9kVL3hwpq3XmeR3lg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6967.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?paKRhjLPaPQIAkfeHUQdeQMEVOLrki2FHu7HcIwG+0VOGLTV1uLCEqBgCPAZ?=
 =?us-ascii?Q?WAjEKTSRDN7frqJFQZm0uCZNTMKOU4+L4VfIfeCKoVb71bk8wd7JIOg3ZvDO?=
 =?us-ascii?Q?KAH9+/868X5+40vQ56eGbnYQU6FtRMmu8XCbwiOLhMLHZ39buOTkpaGtqav4?=
 =?us-ascii?Q?fkiYC+yNpkNBHUVeT5j7WmPb0JUq+6pnbhuR9UW6MDZcegKuWO7OLSYQiKDh?=
 =?us-ascii?Q?XPAVtLLY7/RKNiZO4vywb0b6lbfZkU1H4rfu9O/qP/GeAxlfBmpRvpE0D3kb?=
 =?us-ascii?Q?LPmtYYhYAi5Ue8yGiHkipRdOq0n3SHhkJJU+ClTCcj5/QpL0qDJZnggREGGJ?=
 =?us-ascii?Q?6wLzz1H8lY9NL7pCFseV9eshK8SRGDmGgjaRK2ve8YHOmEoKMJ3ULDOh+TgS?=
 =?us-ascii?Q?M1y9nJUxmb3J9QuO/WFm3EQYrEvh6AfutnLmQK+nwK1n7czb2960U1pAisMH?=
 =?us-ascii?Q?+p31AKjq/co2dryUsMrATR6Gq6ReASLyocs84TsbEdkCXaIMlgWxV/+37h0Y?=
 =?us-ascii?Q?BeEu9pVu4V7sEMYsDvWk02vjvEhx+O8jrpxG+yKAgyPJG3CHw0TCUhx5gSV0?=
 =?us-ascii?Q?BeY/cH6mv2wVPNnMYG/fZtlT9NpB3OG+qHOgLLI8d3YNaD1XWKg70Faq3Wwg?=
 =?us-ascii?Q?HORXmW2ZDtIzTf4L9MdkxEaIdX/wBRDQXx9GVIddLxgWQPtxSSZ0wxMhD0BI?=
 =?us-ascii?Q?EgV8llz+uu4R0TbAre7dm+arkcfhhUm+UlnjYqv5LEYaFZ8vLVWDCgLTrQmQ?=
 =?us-ascii?Q?eRZJC20Da2gbMWI5gBX/xzPiyqR756M3WgXB48BpORAeet2pvQ8Sh1sC2HQv?=
 =?us-ascii?Q?KGGy8Moc41nE2MARZRPZCpwsXKl3iFQcnZIKLRLXX82zyqQ7DyqOuwazuT75?=
 =?us-ascii?Q?6G1JW+avZbui9sdPjGaz2bMKO3xvsrFzwwj/dWLJj5yoPyrBgdbYe17LZ03u?=
 =?us-ascii?Q?bhux6jeS2RnQHwOI4nqicvUxB0T62QmbRuOmsL/fF2AfudrlUVzjxhrzHN3a?=
 =?us-ascii?Q?P4kViy3Aygx6yHfyf23fxYJUUFOeVHbE3Jr5ELAwc8F6LHyQyzI6vEuviteI?=
 =?us-ascii?Q?Wpt+X/Io5mxd88BWK7dOME8/NYMCoNAmu7EO5FJRGp9m8cz1vNtmELJZ1OZQ?=
 =?us-ascii?Q?lCxZTaP8jy4/VTjLd5mZEo7INBi62KE4o2WSUqb/UmUY9IiL1+6yTyZHlfdz?=
 =?us-ascii?Q?i38ScZgPITJ0OuUBUmoY3paEPJuWk/9auUi1a3GM3QAlhwo3+DWOPL16YdLP?=
 =?us-ascii?Q?BX9m8iHBtsZzIGsK55QsvriCjjKnZo9nZ5Y4A/hWnBOVvR2NS9ZawX0cMQWX?=
 =?us-ascii?Q?8jYqrzYGWzmkKzgZqzfc/Jk2Kp94HcJmh6jMlgrCcog2x2DrOXeG+rjAN5iY?=
 =?us-ascii?Q?ME23/ZLPujTlT/canaLXYLQOX7decZI733hdkfmk4cp8WPCQB/9+oThx8lF4?=
 =?us-ascii?Q?ZxMGXIyeu+r5n/6C5TODnlO3NEjFwG9lQKSfPkNxD761G9LllqwmUCAQLhZy?=
 =?us-ascii?Q?YM7YXgEIvezSPYsi0cUpHomJ80LsSWF5+pY/wZeMnFbwMM4XX3jg580r+1jW?=
 =?us-ascii?Q?/+VNYfhA4OeyDVGvW1lLLv57Ay8IOQ3S0cJFVlOUYZ1RNhTeqk8sU4jE4yjI?=
 =?us-ascii?Q?OhaFBt6L0vCBZ2EMh4MkG49T8euti/TUS7SUWh/hKEjn6ngSPyzUQ97N6wFY?=
 =?us-ascii?Q?+u15FdXU2prlqFFJM73lDta4sN5JTxJRynDX04y6Q7laOJFh?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB69676B4B8B07CBC47FEA40B39D62ASJ0PR12MB6967namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6967.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22effa2-9938-4f97-ede8-08de687b28f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 08:05:31.0244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UekLh8SDM3greXJMbLsE1uDS9xE4bLzJeuwcZXi9xzJO6E0CrV6Hup4+wjBRLraw7ApMf26hHQzaBTj9sm24SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6124
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

--_000_SJ0PR12MB69676B4B8B07CBC47FEA40B39D62ASJ0PR12MB6967namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Ignore this, I will send the next one.
________________________________
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Tuesday, February 10, 2026 3:52 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH] amdgpu/psp: Adjust usleep_range in fence wait

Tune the sleep interval in the PSP fence wait loop from 10-100us to 30-100u=
s.
This adjustment results in an overall wait window of 600ms (30us * 20000 it=
erations)
to 2 seconds (100us * 20000 iterations), which guarantees that we can retri=
eve
the correct fence value

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index b0540b009e84..b08a57a07331 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -735,7 +735,7 @@ psp_cmd_submit_buf(struct psp_context *psp,
                 ras_intr =3D amdgpu_ras_intr_triggered();
                 if (ras_intr)
                         break;
-               usleep_range(10, 100);
+               usleep_range(30, 100);
                 amdgpu_device_invalidate_hdp(psp->adev, NULL);
         }

--
2.34.1


--_000_SJ0PR12MB69676B4B8B07CBC47FEA40B39D62ASJ0PR12MB6967namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
[AMD Official Use Only - AMD Internal Distribution Only]</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Ignore this,&nbsp;I will send the next one.</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Sun, Ce(Overlord) &lt=
;Ce.Sun@amd.com&gt;<br>
<b>Sent:</b> Tuesday, February 10, 2026 3:52 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Sun, Ce(Overlord) &lt;Ce=
.Sun@amd.com&gt;<br>
<b>Subject:</b> [PATCH] amdgpu/psp: Adjust usleep_range in fence wait</font=
>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Tune the sleep interval in the PSP fence wait loop=
 from 10-100us to 30-100us.<br>
This adjustment results in an overall wait window of 600ms (30us * 20000 it=
erations)<br>
to 2 seconds (100us * 20000 iterations), which guarantees that we can retri=
eve<br>
the correct fence value<br>
<br>
Signed-off-by: Ce Sun &lt;cesun102@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index b0540b009e84..b08a57a07331 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -735,7 +735,7 @@ psp_cmd_submit_buf(struct psp_context *psp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ras_intr =3D amdgpu_ras_intr_triggered();<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ras_intr)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; usleep_range(10, 100);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; usleep_range(30, 100);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_device_invalidate_hdp(psp-&gt;adev, NULL);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ0PR12MB69676B4B8B07CBC47FEA40B39D62ASJ0PR12MB6967namp_--

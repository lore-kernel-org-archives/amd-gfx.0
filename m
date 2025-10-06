Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A20CCA471
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Oct 2025 07:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6CA910E325;
	Mon,  6 Oct 2025 07:53:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jp6n96TZ";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013000.outbound.protection.outlook.com
 [40.93.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF4EB10E15A
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 07:53:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGEW50RhkHl4vxpETTN5vCLkzF2nns9rZiLM/BXOzGmZAcqmmGHD/BQegqCJKniLzNjLeMR/w0sZ+VWBdjyQGxp06ixHpLxGRWPknNhFT9FK1Z7TGW5SrgX1mJR24aDPJQ/WlT2V0WLF8CsxPoXVpJeQbNtMYGihzrJ0mDsp0F+5ajMQQLd1emliYke9YNgTl9Hzi3O/z/vG3QtVDBrqKx1LnfXQv527d5rmejgAUcnWZZFjbagUlfUH48rL7YckEDYMdV4w+cTuufoTSyLF7+uBcae1VOkmBWz++XQ/SEft93BMhwlOFGCF47ySXfqIohX5Khjkc8NOzvxe9ytgGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSHwZzNDaqOgjXgyhI7Es58vfuW9t77T7PsHcwGB4Go=;
 b=HEfG6KChVqXy86S3vdaJLRrgC4fv5uY9wpSum8voCgX0GSwgmPoH/P+7jeojcXMzywCY/fYgKaa7g2Z7mjPJ/7bAEkHOFDICie2G8Q2BbNi6dDDxJ7r7124pDt4tqgwxmJyOorytGOLphdMgsh+py0blawPjb/DBr7dYN9Dg2wltBD/8cbwy1DJyeYMMD+C4rRcgKyHQYjMb9xxtlwEZK2SekRxHvADjegKk3ukUe9NZQ4HsSQwzXUh/O/b6Xa3u0/+PmmwzzfdNV/QG36NXMec2htLzbY8UuNlSKBQ5xY71AN1Tny57IHRJzFZcJQr/rFZjT1Ol3uPgEfO3PrjrfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XSHwZzNDaqOgjXgyhI7Es58vfuW9t77T7PsHcwGB4Go=;
 b=jp6n96TZsaJm1/RVVcCLOfFV9K3A8Yqb0NyC5A42YQKfdNgk97eXz37ZbXYuzSYcc9p/5c/qcOPFDKGV13VH/JcFPmKemN3Idrfpe0rV/0+OO8SbWjOz/3nBDvDYqGr1RMc2XGyeCsE2OH56il1DiNDLHSGEp/WrxdVRMEg7uTo=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 07:53:19 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::e71b:4ec9:237f:24ea%5]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 07:53:19 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Disable VCN queue reset on SMU v13.0.6 due to
 regression
Thread-Topic: [PATCH] drm/amd/pm: Disable VCN queue reset on SMU v13.0.6 due
 to regression
Thread-Index: AQHcNZg7xGHnW0ahg0WufsAVFf4TFrS0wRdQ
Date: Mon, 6 Oct 2025 07:53:18 +0000
Message-ID: <DS0PR12MB78047344291871962A26D84C97E3A@DS0PR12MB7804.namprd12.prod.outlook.com>
References: <20251005013434.3801595-1-Jesse.Zhang@amd.com>
In-Reply-To: <20251005013434.3801595-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-06T07:52:31.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7804:EE_|PH8PR12MB7279:EE_
x-ms-office365-filtering-correlation-id: 858a915d-d628-47c4-ba11-08de04ad6a29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?n8WjG8zSVbftInXiVprgucyVr3g+j+qxuEHRrt/la+qQopuLWcwP1jdHf/KH?=
 =?us-ascii?Q?gV2JAf4J0TxFmGbGscSn5AmRlNTKSJUXNCK+y8ih4hNoTio1xubBnXc6o89n?=
 =?us-ascii?Q?nZmJayAsWS63gTsQIcmfG0WC5VcajSw56ZBfAzJXBWb8nFzR2j4zaL14y7Zr?=
 =?us-ascii?Q?/3GIDqvpWGkjfIdzPiC0qL/ExRAE21EhRFv33e3VfSlq7BVxh3zY14+LzwCU?=
 =?us-ascii?Q?8vgK8Kbc/vw/KtoytZ74hem51c61RweZW71uYW6gIzK3Z5qgjG+h+/CmNfLQ?=
 =?us-ascii?Q?ESY+Bwj/49z3cblxaHAaSM+UyeYb3dGR0FR12Av+XsRqhPBK9OhMTB1DUG1G?=
 =?us-ascii?Q?wDRWImO/kyg8/v2cU6Pcr6DKJqvQ2o/WPKKXRo/4nyXVO3RRZd2u8rgVDOcw?=
 =?us-ascii?Q?fXRySpaxaCqpNRblpdceJMZtY4IiC5LgTIhqTL0A1mq1mYEQ6jEanFN/+PYR?=
 =?us-ascii?Q?ZvTYPBiNzBbfjUAmwBc/Rxl0WzhXgM5EKp/1BGY7wtmxaNm/J9Ob337oTRQY?=
 =?us-ascii?Q?5XEWlfH4qpzQt8cjlePxA3WR/hAVv/uWIO0eSWt/xsWhZCdsbeXlVd2RwDRK?=
 =?us-ascii?Q?LLNW49C4mz7MRiV7Lm1q32YsqIH4/xZRMzek70em4fuVTI1Dh8ayPuQpPYhP?=
 =?us-ascii?Q?rgkMWUhC/LaQVVcVanRa6UfzAIchQtAapFB9WzGhKJIU7IRHfuKHdwihMp8k?=
 =?us-ascii?Q?9bowjDftpzfopwaAQVq5F4QHUVQvgu+6hUXBSZ+9tU3zdANuAtnOP9R1SFAR?=
 =?us-ascii?Q?IZ1iIWhwdgVnf6X+Sp6HtB5dZajEYUC3pwHmwJBRdWZc7cYcYyeszUT0QWbQ?=
 =?us-ascii?Q?PGyiGk37MWuwy2mqHkeem8zPvXxeShIX8w2cEEmLDQ/eilpQ0XNR1aHrdxX8?=
 =?us-ascii?Q?Ey11C/4653fnD2GXLl6/Le0XAr0CKk06WYmYnk1RcHFhDEZiJigJUZnnL97l?=
 =?us-ascii?Q?pANSHPfaLgAhk5cjK6mkWBHF+EIobGUCbq+AJ3Z2KUilJJbkMQIlZWceulpb?=
 =?us-ascii?Q?RIMys9ZZB2Cvf3wqkcVqCYN6qFIUOT4UxXGng3xniKiyhvpZfYej/wY1mg4v?=
 =?us-ascii?Q?VOXnEXpgBaAfJq/f6jqMLzZgUe9pSp1JwsivaprzU30spnVYitx2fcqE8ygi?=
 =?us-ascii?Q?EV8glKhHgJ4b/wzbPyLnAcZ6Bd/y9N5DRjdOxvlgriaxgmZAx4CjEmbslQTp?=
 =?us-ascii?Q?zIryxUnRR80j0RTnPHKuDuTMBonuy8YaCzZskI+XfL6hfQOUvmyZMjTdoWMn?=
 =?us-ascii?Q?RvkSeFLy0qMn86rpbBVU77QhYd8QSmAHMO0RAcnsdxcbIy0hCAwrs81pRiVv?=
 =?us-ascii?Q?+FPIpWyaXZwjrIO8CcT+w9YCBYu9X3VlCk7fBPNBGL4sI2KNhYKoHn0ehjdx?=
 =?us-ascii?Q?nz9avYeiE+gfdb2C/npTvsS0xMmUt9u3mRYZQXI6XA8DmC9BL4CU74logF7F?=
 =?us-ascii?Q?lxuq+fE+quouFwmOGwKVlEg4QrQjt9SX6SrS56pPP1jphkITt7G9BjlgBk2e?=
 =?us-ascii?Q?+FRlOeaIUCihZ81Ff9udJ264c9Od2SVjogzq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5HmOAv+3JU/5Y/KVLUZE1Nels0iWHB1BG07Ekmmmeh9c5H3bGa48h6KpPglo?=
 =?us-ascii?Q?dnDyyguxNmT+jMhHyOfLpo83iiZTRx8O06SA+coPMpiU/diJ3gGrzV/0gKhK?=
 =?us-ascii?Q?r7GUzUpuJaTnWmrJmCWRGgyRXWkLj/tL+BV2/LlfGKjj+BEieQwbu14l2r9w?=
 =?us-ascii?Q?g5w0ZLGAWMU7FL3FjWfETrvNFSaQvwYwnKFTHJ8KkDpiBJWxRZ7gn1tjxdWX?=
 =?us-ascii?Q?9CjUDlT0CM1UduNZ70tYEWDIAXAvXeDGHHQ3kQBEujanI7av5v6vxzlIH8jO?=
 =?us-ascii?Q?D/KwpkN++QFswr4WTOh7VeCa/AueoE7GpXZ28H+rmYhdayLly0vf54PkEpc8?=
 =?us-ascii?Q?xtQIE5/DI2/0S7jLQeKX8Ui4m7L9XzOsFwoqQgOm8plCuFVmXC5RPbbL954Z?=
 =?us-ascii?Q?jILCgY8oZJjY1B/ZHEFF+XPb8UkUIKgwqFwTMrRTqAyJfq6hqr/jkehEFSJu?=
 =?us-ascii?Q?weeoQJMJEMZbHPPpumk2eObLM2mpZZ5V3vcg7sl2WXeEk4bWF9rRJGIMuJiZ?=
 =?us-ascii?Q?z/R2fiMNxu/9X/WgoFIAWzn2g5ZQV/bEM1yLHJpPeRDfzgglB6xa3VEizKA0?=
 =?us-ascii?Q?JWBiCHOj5DOcrcT0TI7nR+QkDNTr/rlKy1c4g/XFJMT0aii7LNiHVnNuNXai?=
 =?us-ascii?Q?6TAVAo+HINo6xZDw2ng3fGL2Dchhz7PCw3e9POiD6QPpn0Zele+GVsb8mQjL?=
 =?us-ascii?Q?MLiNlgDsuxcIUqYE8sEMbg7AYf9Mq1XhpB5qyle5OO6qpVcLL9kXr1Vin3xP?=
 =?us-ascii?Q?p90eAXNXXu51XTsdOhG5/hO8x8BAjd24Erw/P0vM5kBfi7+V67UJ8x0zG/Rb?=
 =?us-ascii?Q?mt+jqc7S11PCYPpDzdS91jRVVHoXOPcR8nzWBfLX8qAs5ftkvgK80K7TmQJT?=
 =?us-ascii?Q?IczcUx1MNDY7/qHpOWxVAZM7AK54WR8+7V8atXhtIwMxJtzfkLW/zZTZ/sJP?=
 =?us-ascii?Q?zwyROv/3Mf/QoyHyceSwR+HUfiywj9kfrBhshH6ePgTXrgGdV0OKU2NgcvtT?=
 =?us-ascii?Q?UbbTL++GNnZLJTwRk3f03Z3AtWSwGy0S3MT+slb10VAc8fqQrSDiOvgBXjfC?=
 =?us-ascii?Q?jS9bxaKehLw9TVQ5QlEd4lkTGulmO4MXRfjEyxd//KpwTHbmEQMkdiOy0CeP?=
 =?us-ascii?Q?4IKdThutysNsoMBY99XT7OL3BL4JyWveD9iARtDgdw4dCCgfHWJowd3G6P+N?=
 =?us-ascii?Q?2ujqstHY407rVr4CWURbZJ49/OwMUrZPuK5h8BvMuRZZ9a3/lwSQ7Ou2zT00?=
 =?us-ascii?Q?MmwJo1O8bh3yIQ15/ReYzNV4+RDFB7hlgfyBRJrRfAfcc1Kme7w7OEBsxb0Z?=
 =?us-ascii?Q?db1qDF4YAgn0bdaNl6+UX024xv7ySg5zRci87KCMGJBLFW8oG+OEYDAEeTWZ?=
 =?us-ascii?Q?Ue8pJ4rR45OG5UZ7Zrfy1eFzs3X8iOSQOhG1CadRojj/3YI1iJHoOW3BkvC/?=
 =?us-ascii?Q?HroNYDTFnKBtRsuUey3QG03Vk8K0mK04XJiqy4nGyK2+Vg6KNqofFuUdpOU/?=
 =?us-ascii?Q?yPcppviWp8jc5yjauUhKWhnbrfS80D4ptorfQDXP9MIDAvC3mDx3DYY3tdZW?=
 =?us-ascii?Q?UbPr8zO12kHVzspGzvg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 858a915d-d628-47c4-ba11-08de04ad6a29
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 07:53:18.9870 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Qt0QUpzGQX3Qtou+NuU0kS2i0A6uB4LjLGYKj8bsrXqlAm++4Q7rJzdI0oCAc3E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7279
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

[Public]

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo
-----Original Message-----
From: Jesse.Zhang <Jesse.Zhang@amd.com>
Sent: Sunday, October 5, 2025 7:04 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Jesse(Jie) =
<Jesse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: Disable VCN queue reset on SMU v13.0.6 due to =
regression

Disable VCN reset capability for the program 4 as it's causing regressions.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 72ca6302da63..285cf7979693 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -450,8 +450,7 @@ static void smu_v13_0_6_init_caps(struct smu_context *s=
mu)
            ((pgm =3D=3D 4) && (fw_ver >=3D 0x4557000)))
                smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));

-       if (((pgm =3D=3D 0) && (fw_ver >=3D 0x00558200)) ||
-           ((pgm =3D=3D 4) && (fw_ver >=3D 0x04557100)))
+       if ((pgm =3D=3D 0) && (fw_ver >=3D 0x00558200))
                smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));  }

--
2.49.0


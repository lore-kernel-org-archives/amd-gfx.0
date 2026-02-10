Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64B4E94626
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 02:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5717D10E49E;
	Tue, 10 Feb 2026 02:29:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3W0K3IDH";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5E1B10E13B
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 02:29:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxpGIymnKdeleIo1QlVWrvx3QlDn+qTiHhPbEr7qKw3Crxyykz8Ifah+8Lo9K/9gEwtXGzoHClZSiUYekaic8mqMHPtrc7mqdI0rjsZpnBrUUvrIw50hEYUKu2/ays9s35V+QU2HZIb/SFD2jC6YonlrwbKKZHootfWDbBiFSJTjqd0Cd/EgHPdM92WhVdF1KAbt22oknLRkvhiMAh4/D8otVfQgS8RzEzcJzKwDV0L8w1qpm94qmilFwRi5gISatlKRJuBf7teJOBJtwUgvqmLd+npZeC/IEOcrvvYf4bCDINLidri1x/2faMlk6X7XuC7dB2gcJfVMAatOHDHqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cirGLSftU/0njuweMW9oXT8GHEHivGPIyDpAapFxR8A=;
 b=x/+tuXr5nLqj9bF7m3WkVdHg6OaJg1EjLM1jR17RQCj7gD0Qv9aKQLPVPRBmwz5e4PJoyV2Bl+g0ubHUbnHZ+mJU6PC+qLy4kuUe1i3x5x390zvV8dCOEAwO9bJcTiz3lq+gu8YUJEgPNDUbDSL0SBZEJSm2g3EsKvfjxTECWyKN/AnrwmU3gWDIx9GtQNVbDPX37NMEB2LIys8IrC/ck++bHSjIZ+HA1ZYJEeME0iNmONUdvVpnN+nJ7/1bZcOH0vgfhCfnT5G+dKfoVUMUtd7jwSBaEiOLaoiiLfl/fYpdDT0TtmreLoVeXAkCM+Bm/egBClwKLjev/iNy+3qpnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cirGLSftU/0njuweMW9oXT8GHEHivGPIyDpAapFxR8A=;
 b=3W0K3IDHc9nWUW05iLCDOTCUJXqzjlkId47NfOQMIbRntAVUVQcJD8FxggZqZ1d6VHIQPdp0a8QVcxbumiLLRfv9LApFFujuESobqfVirFAox5AmQ286FFzDMY7xL09kr12LstQHdQdREPkkHLxYNDyBUhdC+QsPdYvuBfZz8PQ=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SJ5PPF1394451C7.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 10 Feb
 2026 02:29:04 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%6]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 02:29:04 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: return when ras table checksum is error
Thread-Topic: [PATCH] drm/amdgpu: return when ras table checksum is error
Thread-Index: AQHcmaeA5Ktyw5ToBkudNn7t1XISeLV7NrRQ
Date: Tue, 10 Feb 2026 02:29:04 +0000
Message-ID: <PH7PR12MB8796CC48A723479B767F63D6B062A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260209093543.1341791-1-ganglxie@amd.com>
In-Reply-To: <20260209093543.1341791-1-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-10T02:28:56.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SJ5PPF1394451C7:EE_
x-ms-office365-filtering-correlation-id: 0ba46b56-1b85-4103-e396-08de684c28f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?P+wqjDaEdISytGQp/3Q2rDUCWkBS8S3OIRV/EYaKf13twaMUlwX+WfESku8M?=
 =?us-ascii?Q?5zbAo6j3y8XEd9c/EBPwarZS2t8mO/WSK/R0GNNn6XzxieiqrfFlN55eaQSI?=
 =?us-ascii?Q?NrtK9Twzru/ZHEA1bQQpbpWXiEy5ZX1/TtsW6DP7R5efZj8isUsf1I0NIjOa?=
 =?us-ascii?Q?8xj9WxV85ooUq2/o2VTKapyiZ5eDDusjm2p05jWlTa/2E/oOdJy+dClApFyt?=
 =?us-ascii?Q?cChuK4aZXbPhztCYeAZ7FI/nJ/hI8dnyxnsJtWUXh9mfdV8sPZzGwohot/7r?=
 =?us-ascii?Q?JtLlON4SmaNQk/hB0o7PVoLiWHOlPe3NKUiaSDRrGMDpbPWQFHaLzxv1kxq4?=
 =?us-ascii?Q?CeDyFFqq+X4P2efYcnzZeN4v4prhd9Cla7lpNB6nxdy4lrNNdPzh8NAPlZSq?=
 =?us-ascii?Q?dre8cBkPiKxDih8hhDXZ6Mgf/a5d11rGwDVVWvpl5GJ769DfpR+pS45wfeyx?=
 =?us-ascii?Q?BXlxZZ/p4aU5y2qOx+MY4PxsG/UYZ2mnCjfgXvx2967Fen0OWhVRR2bHsjUE?=
 =?us-ascii?Q?kZQU+AHY+L3u67rFqztOU5KilQJNVjitA2YixEONOBFRC0cldlhPXSNljlhc?=
 =?us-ascii?Q?rpp3RncMmKz3vmVLkvC9VJDYOhfmuiS1p7wirOe4XKqVRpBGun/HN0BmmWuP?=
 =?us-ascii?Q?OWoTVvOl0AH9u9A0NuJ/rU9zDbLOefKaQAIod96q+5i7/Tv664RYCwLeD8AO?=
 =?us-ascii?Q?hPPvKYEfw64PJPusdLmWWy7KuXi5ilLJSyUVaJ0HHE44S09x3oucLzH1Ly49?=
 =?us-ascii?Q?rJpfndjrTSaWUQfY9DmbPKvNe4befLd4IPABkMyLzfOIM2Nh8dIjKgwd2nJB?=
 =?us-ascii?Q?Z8VpvRRxwoaTDYYQK3acQHAAJwDKuGbd6AHrMPbFulf8UpcSJCYy8XUagNdx?=
 =?us-ascii?Q?mfP/BCuxeBUmmha//9vEYjdneweTm2Vrirn4MpWQxfXhbT3Kp11arViIJpKy?=
 =?us-ascii?Q?ybhc9+8+DtEVEIfJg97UcywCgBrgcW1W6n2AQEGb2aHf7T/gLlHYbYydoY7d?=
 =?us-ascii?Q?PGrnKt9u9ZI2Yo/wapjhxW8T8us10LNxD3ronORAkuISH3KNagwUVP0qNdQM?=
 =?us-ascii?Q?/8J5Mq97y1zjEUvfId+NFinWldxK0aivjlPEeUntThx+Zi6FIacapeS4FySp?=
 =?us-ascii?Q?lANHCKvsmpsW8OtrFYJwnOKY+FuSvUxqw0jZOdWKHUnI734HFNm01ER1Qu49?=
 =?us-ascii?Q?txwN0qdyuCuqlhxCNP08OWCtNH6IUABMrPzmNK4vOweFmdChmqovs0TlU6O4?=
 =?us-ascii?Q?Mivb1EXZv96DRdJ6KoTewJnBSUUNG3WSBIkOzd7lHDHNnJMz9Aijj6e3n9Yh?=
 =?us-ascii?Q?06TW0j804IPh4A//mOH0UBg4tJyRt3TaVVzuR99+wYfV4QU7MQIwmG75qeD4?=
 =?us-ascii?Q?I/kl7niTcy2fvvivMWJz08FAjgC+8BXvAxGefBv2JMN7cUahNXOVNRgHxmfl?=
 =?us-ascii?Q?ExKIG8FPpCbYuMuYjpvLsXgA5Bcd9IagtYUwDWLHrdF4PQeUlYlXytWjXJCl?=
 =?us-ascii?Q?f4AhfPEL+fJS1EW1uAlACp4aEvZsz1jcnpNeZZWODFsJ5Z1nCJHx6iMGjVaB?=
 =?us-ascii?Q?2mXWaNVEe5mXX9Ya7p3LXjZJUcHmIiaGH5XPLhbLiKvYnN0E8prHeXAKlpPn?=
 =?us-ascii?Q?TF9CqiiTBCN7hV55mhGfHkE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tv1/YPIwiF5ckrLc6npfUNye3TipnrBNLJNJMSr3yuk3ZEwgiHyqWEQkkcti?=
 =?us-ascii?Q?zeT//Grq+rcaWsebLyOArSlBwHn0e+KmlYx2AzqLa+s0C/Gq8LPIJiRkiabj?=
 =?us-ascii?Q?n3r6ejfCuXYz7z1sAnup91lFv05whDIjoYaFI4SQLEFV3g679NWcWuNU4wDU?=
 =?us-ascii?Q?umhJtsMZV77wdsjRxS4VQJjjfH0kbfD7jAlzkWl6UmAgumsrFM/1tpjhQv4B?=
 =?us-ascii?Q?zA4pkPRiA+GvWzzyEkQwvwovSEkFPsGdXefO6eJcWCs0CsERAfb355EQRLs0?=
 =?us-ascii?Q?mQR+kIQ2F3h02HWgyf9s9IgcMtzX7Diu7XSqGgMD/JWhPtzSKfFOcn61tF58?=
 =?us-ascii?Q?YkxxEu6dwyoVRkypTzJDhxMWBveqEHhQmBI7/mslRSq+RmA7EXoIVbe/R+vy?=
 =?us-ascii?Q?00vZu2p16kgMx+6pzL2kjjROzPoLqi+lj7KYjfcf+C2d3/YS1lxvpI7Z5Pn3?=
 =?us-ascii?Q?r8HMd0AqRHrfRPqsZmMFgzB7DfvGpAU09+A57lfAZOtvO6cgjy8KgaiSxzPl?=
 =?us-ascii?Q?srNQGSPnvOD3sL5tI2SSOtwuzdiJF75VxBnb+AxI5vuw8mBhFQvGH7OANzOb?=
 =?us-ascii?Q?o4Hzdn0EpKEbwsQmugu5FdXymni/gl3JDDBOMWUXPS4aCW9GrRhzlvbLgrPa?=
 =?us-ascii?Q?refnrS9N/34VAFnWRaGdSRd1W0xx3/JU5phjySzRi1BzrYgXFMyDzYqqUiwL?=
 =?us-ascii?Q?XGFtyQe6AEks0SZRR7HvjoVgqps+JBVuuHsNc6hTpM38vJtBOEwooEGGg/95?=
 =?us-ascii?Q?5W9YuKeH5x9f++UUzbK93VSjAR7eyTsUu1c8oPjk8sue/QSNALD++0MCBdVN?=
 =?us-ascii?Q?JqV5vI8KEgs7GgEqWxYn9rk+jEuIUjz7aWe3lNSxaaFh78qqsZZPp7VCMqXi?=
 =?us-ascii?Q?dGb42cbn+tYwBMGxeHLaTXyawhhQdOe4th52ZUJzaXAd7ROOAInRnQ1jVpSK?=
 =?us-ascii?Q?1pxX/MFRuk7cjuZPEdNMhwhn9EfbpWQnj7hJQfZ3J7EQn7Uc3lRgv90479qN?=
 =?us-ascii?Q?cdTIAaYk9wBobnUjmXaOGPBOtqL33hztG233MFXlkGrTgV77DBgZjSlpl4ev?=
 =?us-ascii?Q?bkgFVr0o11FpR9S5fqP6P4W80eoqkZAnksk6H/MaH37TP9Oe6KpMKkCR8Uu9?=
 =?us-ascii?Q?cp1sEVd5RpykUSNuevOsNBySHFrtzoj7wsUaFuqwQfCx3Sl+aO9EUDc58zMa?=
 =?us-ascii?Q?oG2HPyKV+Io91pNDf3n9aWOfbCsfSOLhywX9bcd9mvzCj6CtGtBiIjBvQ4t+?=
 =?us-ascii?Q?t+bmX7l4kmuxemwVIf75WpoYCPUFQItximW5siC1C0a4973qN1O1DBDwjPfm?=
 =?us-ascii?Q?nnZ9aEhQgsX82NhwVRN5n6J25jK6jqw6Tm8HYSNzyM/dazyXPXl/OLC+9BEa?=
 =?us-ascii?Q?mqxPXw7P+Z2lavQbRu6zVw+vH8rEIc55U/ZeM9r9Fsw6QBojZcaSDJDTHUQW?=
 =?us-ascii?Q?mdERVxHmEQm6TqZvlYa0o0iGr2yCxVR1M/jIpfLtIbOzY+5RcizhY8nCt5i0?=
 =?us-ascii?Q?7ba9cY9linw9OX5UVCyz4A4JI8a0DTF4PdC9SArZcGCV2uRQVRcBGwCJAhq1?=
 =?us-ascii?Q?LLQMHVGhQDelikv8vDpvyNVLkhPlsITdOX4AT4Vfg1UgcRT316yu6IQyx/ZX?=
 =?us-ascii?Q?ZdJKQn4mr1ARC9twfjSTYqUATCrsbdCyVHMp8DEpON5l/LKR/bmgBO6h8wog?=
 =?us-ascii?Q?1NnSWqUOeyaGBb6tk29lAlLfY1zeSRM76xiYuMTlowm8+vvj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba46b56-1b85-4103-e396-08de684c28f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 02:29:04.6664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tmdoBpjVC/9GCE7gu7pWopmjA75nczfdr0g7Q4dYL/M698+n0GbuNg9ocE7snGFK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1394451C7
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
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Monday, February 9, 2026 5:36 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH] drm/amdgpu: return when ras table checksum is error
>
> end the function flow when ras table checksum is error
>
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 2c5d7f87e593..6fba9d5b29ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1701,10 +1701,12 @@ int amdgpu_ras_eeprom_check(struct
> amdgpu_ras_eeprom_control *control)
>               }
>
>               res =3D __verify_ras_table_checksum(control);
> -             if (res)
> +             if (res) {
>                       dev_err(adev->dev,
>                               "RAS table incorrect checksum or error:%d\n=
",
>                               res);
> +                     return -EINVAL;
> +             }
>
>               /* Warn if we are at 90% of the threshold or above
>                */
> --
> 2.34.1


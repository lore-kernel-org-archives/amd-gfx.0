Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF7CC35FF1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 06:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E363E10E28D;
	Wed, 19 Mar 2025 06:12:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q2DaZFFJ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 970A610E28D
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 06:12:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1yRsdIeIJT7cTgiw7w7AN2R2bJnYU4XpaBsZq9gXlEIL5ljjB/Ha+Gnksbr2HtuskGMam/ItVcYqnOy3GJuzkbz4ioTWWNFXy+/9pOvLHpmRyQNWF74U2PpPbVTZa8rcz9sltAJsGyxI4Kjariloo2qVZeScKEjPUW54gde077Hvdt4mZoAyvt8MKT5m6vPpyuw0qxt06RGcTNVVo+oJnoua/eHGeaTDSt1Gjs7UjCFM5PA20IXDCHuC00oLnqDKaYfLEFZpWN92ui0lk4PRxa1I2X/3ljSIIy2W3QfG/2t41OJOEwtujW39giXhcHmoA+QBW9yNdsrQw5gDjzCTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tK4617weF8jKnlkKn+pjXM9eH+oN4mqt7wHpp/NXORw=;
 b=dMo56jXRH3Txc13unDA+YXbpko27nTENUq3I8rna+jbal3WU9XOK1QWJdv1PTB7bAZ8Y/Asa93K3GRgY3SgG4U0+6fY8h1806h8hJDW/OiRYBzeHAmV/cbQqBbro78RZrOQbjTTEudMRkWkW/d+DcuaRsjqgPoxvd0RnjXJjp122CfEfFhq2I+XOkESyK3prs3oPgQMPJBAZC8SF3TwRI2pi4w214VZnCZadJ8NPy2b6ncmCBSDBsZutqbsqgjdjc2HiSAM0zV+oXCPYqouHZt4QA07/kMNtlvrD4WOrGERGTlu3102vhJYbUQoRMiuPnjT2e/+G502LuOSVIN071A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tK4617weF8jKnlkKn+pjXM9eH+oN4mqt7wHpp/NXORw=;
 b=Q2DaZFFJ7hl1Zy1wxUfSlL6GaBt8P5KXS8s4GMl9PtTuL/MzHQL5m3Scdtu81itAXyeUPlW8rwMU9C3N+4GmODlXjZnr2rUX5n53G7Wn13CoKK9gVKb0Oovt9SGkOCFWOPMDxZXvjxkEd+jNA6/QvWajKBFdZR7r85M3mnp4iPY=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 PH7PR12MB7940.namprd12.prod.outlook.com (2603:10b6:510:275::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 06:12:08 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 06:12:08 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>
Subject: RE: [PATCH 04/11] drm/amdgpu/mes: centralize gfx_hqd mask management
Thread-Topic: [PATCH 04/11] drm/amdgpu/mes: centralize gfx_hqd mask management
Thread-Index: AQHblCYX70MPzgsadEOPvucc4JBHwrN6AWEw
Date: Wed, 19 Mar 2025 06:12:07 +0000
Message-ID: <DS7PR12MB6005D659588057084A2A1097FBD92@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
 <20250313144136.1117072-5-alexander.deucher@amd.com>
In-Reply-To: <20250313144136.1117072-5-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=30397649-b58e-4bb4-ae7a-289f9a3c3935;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-19T06:05:09Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|PH7PR12MB7940:EE_
x-ms-office365-filtering-correlation-id: abe1b957-a713-4243-a508-08dd66acfa85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Za+Ipwrq2j7oZRmNyNskIYrUGrCerVRtbMROr+qQ0GphFygyJ+gvK5vIvtSe?=
 =?us-ascii?Q?Rq0uQqLSEUE22R9Gp+1UrAEhmRKRLQwQuANgPOraOixDadMSn2sq6U4z4nin?=
 =?us-ascii?Q?o3oFoTE4NH7yuqZToqWXW6XIlD/EUGAS9KX1pBL/Nu36zWla/Wr6zWd2nNVe?=
 =?us-ascii?Q?fUZLtq32ycgF3dY81ALiQ0rFKMYnPJSbJaUXg21YK5s4f/7lZY2nJ5C2gpW/?=
 =?us-ascii?Q?Bxw+2/ip8dq4tLikGTJT9O873tR/yCTl0nshMk4mdTdC1Asz238HO61I5fSQ?=
 =?us-ascii?Q?8owNSlL9BzkdZHdySsPt52uf929wpJ2NHg4K1ARbp3kr9J/Q+yZS/+GPjpC9?=
 =?us-ascii?Q?rjvZLIgr5ps7QrLWWBvDPBv/erjCkC2PK1Rq/+X5xDhrW5cYOXIU+nVY8GOR?=
 =?us-ascii?Q?gJW1WTM8jdsl6VxxFCZuZ0W0KI9Yll4th7dY9DdJXQmjH8fUqJ2G2HdyOg1q?=
 =?us-ascii?Q?k/sZHFjuGR/dz2/j9sakMRXNlKjSVajK7Z/vMIbZw3yE6nnHv4xM+Eh7mKut?=
 =?us-ascii?Q?NYOJXSlVkKDhlIgWcwMEtYQlilFKj0Bq92+LuBJXKRWf1kRjbUEgOOwcNqLU?=
 =?us-ascii?Q?BELaKXtXWuY2LdemWqRERPsmDNbZag1YBYVCsx8RrDCWzqE3DxZkBDq1ZZo0?=
 =?us-ascii?Q?WRSpx0AqgyBq5YWiye7EBM1zm+y3JN49Iba8uEkGCWrhnAPVTiYfJmXzdvdq?=
 =?us-ascii?Q?ZAh/PNHvioZGrGCb8WrNOZ/ELWWF/XwXiDI9r2+Wl1bbdJR8j1awqPFm8e2g?=
 =?us-ascii?Q?3mfsStbCwQuMDkHlFNjMad3D+s8TdLUhe/j60vK95DMlfj1sgGZ0UEA0f674?=
 =?us-ascii?Q?tinBmrV1YG0qbCRmOJh/Mo9apCrn5YezrRBAhapBsTxd8d9//uf59NXoX6yq?=
 =?us-ascii?Q?uFJl3UKVJxuiYJm/rorR6iGw6OGd4FLyyV77QEM9R174O5mRt7kF3q6sLPZ3?=
 =?us-ascii?Q?OG2aMpq67WsoccEl81UpGYLBsQFA7AWdXTi/MhcQ85MX+QLJmwcrtpJSK5fx?=
 =?us-ascii?Q?0eMVKysGVXregN6pY7Ce52I3/E1P0MHYm/FdP+ipXec3z4o0fJ2vyM9If7G3?=
 =?us-ascii?Q?6G+IqePpzLQBWkug5Y+v27k4L+1VWMpIT6dVr60od49PIMEe6RsaaTe9BaBD?=
 =?us-ascii?Q?nPFvvnEu364p04wRDHhijPj+UOGAcIZD2+mamPsacnsphHumBhEjsjIxhEAT?=
 =?us-ascii?Q?Hi44zPzfPpZ3PFLPSun+8jS5+k130E30uXLDXGx+gueNfAN4x49Gh9hjbzo0?=
 =?us-ascii?Q?XFPuOmd7Pf3TuF1rUgty7mxEiP7cpEuTNqairLEA3rLA2+bX9zuKOBFmdU8M?=
 =?us-ascii?Q?UpRkPoXMaNMw52W0nmgHqOJDhGGf/VvMSWlt+04OwK609PHI3IPIibW8H3oe?=
 =?us-ascii?Q?Dn4t+J2CctcpBCUHhYed79bz3xb/JMDeoQJ6xfh/1ECvlZEqK9HgQvQdhxIo?=
 =?us-ascii?Q?FA2BvtTdZtfzPKBKt758igvEn3xao7qP?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wXiGzXiQTsetq5GfoCf/Jxwz+GMmfU/L2BIysK4Niz4ITAvHF/nkDza16Vet?=
 =?us-ascii?Q?pkE8lpcepeRXMPBLwwXnlHV19gZ3RaPaHDiYOGR4vzJ6cQW4aCG9oXb4oVxQ?=
 =?us-ascii?Q?yooKQHR6tEGGH4VTT2gqpeDqQMaSmAFIGPN2TOE6ZsizGrGymBknUrczCF5c?=
 =?us-ascii?Q?s1PFZpDU6cKC52sF4gnSvBI+3bpLUc1wm2OwBz+VG+dm5qYysfnNJAE94ejv?=
 =?us-ascii?Q?Io6GoU+9iOR06ez5yIMR7dWHxPbiTIXnHWR4JD2Hu9/0llm6RSbLMC2B97mJ?=
 =?us-ascii?Q?p7vQGddiB7p6U97s4K1Mmnv7/N9Sivq4XTLdOy9qzYQQqIGgNSC582iozsdd?=
 =?us-ascii?Q?ISzDDHhKak7M6GtH6U4EYEvDDYQOtQJZtLfBgwz4lGYnNhYGeTc6Q2jlXTgh?=
 =?us-ascii?Q?HBKKKFSmOL4pXsyLhv4aBEjYwkGrblp/4mKxbQih5FNiLCjUTCDx2De5UESV?=
 =?us-ascii?Q?KANeBxFlKC9NJ7p0pArnfey9dkv/lgNiupQsoN5wWkhETKnj5D3RZ/eYZLNJ?=
 =?us-ascii?Q?O0npJq/nItTqOf+fY/u0pmsYB4fwYiqeEH2pOFNrnn07ekE6UaZxxz0A6Tt+?=
 =?us-ascii?Q?cru4n7DjVYdMy1ACeil2TckLu9tfYlp3VIMh4UqDsZu25/queEsp7PwftHlz?=
 =?us-ascii?Q?lml9O9KXDDmjQmAQKZms66arklG8rN6jk5TqXaAQB/Y1TelXJbFeshlrpd5l?=
 =?us-ascii?Q?AtH75iINWXM+gDAh5hCLabLr+uKSva1s+nJQVuHPjC4Ftp5kUhkH+emkDl8+?=
 =?us-ascii?Q?unuT+G50OKoRMIwk1sL9UgYH1IvN+qxzTlU/ghFmjNB3MhOXFOPb/TjLHVss?=
 =?us-ascii?Q?tSTObWKzGGiCWNdglDdNXrHO2gO5w21JTaLoUqdyU14Nx0dztSUMHYE0VPv2?=
 =?us-ascii?Q?r3VDOr6CTdOzZNCkzJLckWLY0PDFA9LuGJOIodt7aiIEchH2fFEoaFvm1dl0?=
 =?us-ascii?Q?LZxrsa1xSyd19eZW2VAjvIABq8vQPZEczh6M7UsLxC3XaUykjV0DAS0ZzIVj?=
 =?us-ascii?Q?BnJrI9A36T6CEXctfK9IKcjTwj8S1Ao7yUXbf9Ur6JER3sY0speaC3aM+Sru?=
 =?us-ascii?Q?jqgcLZKQdV3Koaw+gDuuPhpq8yCPZ5LMXAH6UJF5XkYMehvAgMdtdhyFtx+G?=
 =?us-ascii?Q?35WeVhKGuILKHXNGx9L2UDFbwqpqH1ekDmq6BwgU1r8zVLBuTSCEzjV75B89?=
 =?us-ascii?Q?UPxsvL6zP9ZHEkC5pmGa+0LHdapdUuW1nHB5aIN6PgP8RI7eeKTu3LY5PWYK?=
 =?us-ascii?Q?C/V6ZWNHOXqzapwKakQA5X88+VO315kW3fe4qMogybWOC0YIq8RsXcLC4jNR?=
 =?us-ascii?Q?FzjNQSJyyDg5PhOPhqcHME8nFq8ZsbCWvA/h+Ksys1XAC80WoRSdaSzjYPgm?=
 =?us-ascii?Q?X5a6z2qr60+k97TkIwpqzADme1S/tZzaWo0yml8cd4IZujVsPrkklEVTDkGw?=
 =?us-ascii?Q?uSSK+9S49KWnM6faMp2dtfzuSbIGcMFjQ+2X7yMFs9AINDrRj/IdYjspw5uH?=
 =?us-ascii?Q?nvvtY+uwuC7R0muWnM52vcgXgeKzG0T/iroWMzgT0uVLTxZ9Ad0Vn8q/vcez?=
 =?us-ascii?Q?dgtZg844jOvWUlKGOmI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe1b957-a713-4243-a508-08dd66acfa85
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 06:12:07.9490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2v8R+pUG3T/eB9nFRsjAFvIixgaAJYeoTYsU3KgmkEmO1lG66MoXCRR5uoA5lPUt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7940
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

> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, March 13, 2025 10:41 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil
> <Sunil.Khatri@amd.com>
> Subject: [PATCH 04/11] drm/amdgpu/mes: centralize gfx_hqd mask management
>
> Move it to amdgpu_mes to align with the compute and sdma hqd masks. No
> functional change.
>
> v2: rebase on new changes
>
> Reviewed-by: Sunil Khatri<sunil.khatri@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 22 ++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 16 +++-------------
> drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 15 +++------------
>  3 files changed, 28 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 6f5e272d7ded3..5abc1ca0fee98 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -108,6 +108,28 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>       adev->mes.vmid_mask_mmhub =3D 0xffffff00;
>       adev->mes.vmid_mask_gfxhub =3D 0xffffff00;
>
> +     for (i =3D 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++) {
> +             /* use only 1st ME pipe */
> +             if (i >=3D adev->gfx.me.num_pipe_per_me)
> +                     continue;
If only requires setting the 1st pipe MES mask here, it seems unnecessary t=
o continue the rest setting loop.
Other than that, the patch is Reviewed-by: Prike Liang <Prike.Liang@amd.com=
>.

Thanks,
Prike
> +             if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D
> +                 IP_VERSION(12, 0, 0))
> +                     /*
> +                      * GFX V12 has only one GFX pipe, but 8 queues in i=
t.
> +                      * GFX pipe 0 queue 0 is being used by Kernel queue=
.
> +                      * Set GFX pipe 0 queue 1-7 for MES scheduling
> +                      * mask =3D 1111 1110b
> +                      */
> +                     adev->mes.gfx_hqd_mask[i] =3D 0xFE;
> +             else
> +                     /*
> +                      * GFX pipe 0 queue 0 is being used by Kernel queue=
.
> +                      * Set GFX pipe 0 queue 1 for MES scheduling
> +                      * mask =3D 10b
> +                      */
> +                     adev->mes.gfx_hqd_mask[i] =3D 0x2;
> +     }
> +
>       for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
>               /* use only 1st MEC pipes */
>               if (i >=3D adev->gfx.mec.num_pipe_per_mec) diff --git
> a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index a569d09a1a748..39b45d8b5f049 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -669,18 +669,6 @@ static int mes_v11_0_misc_op(struct amdgpu_mes
> *mes,
>                       offsetof(union MESAPI__MISC, api_status));  }
>
> -static void mes_v11_0_set_gfx_hqd_mask(union
> MESAPI_SET_HW_RESOURCES *pkt) -{
> -     /*
> -      * GFX pipe 0 queue 0 is being used by Kernel queue.
> -      * Set GFX pipe 0 queue 1 for MES scheduling
> -      * mask =3D 10b
> -      * GFX pipe 1 can't be used for MES due to HW limitation.
> -      */
> -     pkt->gfx_hqd_mask[0] =3D 0x2;
> -     pkt->gfx_hqd_mask[1] =3D 0;
> -}
> -
>  static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)  {
>       int i;
> @@ -705,7 +693,9 @@ static int mes_v11_0_set_hw_resources(struct
> amdgpu_mes *mes)
>               mes_set_hw_res_pkt.compute_hqd_mask[i] =3D
>                       mes->compute_hqd_mask[i];
>
> -     mes_v11_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
> +     for (i =3D 0; i < MAX_GFX_PIPES; i++)
> +             mes_set_hw_res_pkt.gfx_hqd_mask[i] =3D
> +                     mes->gfx_hqd_mask[i];
>
>       for (i =3D 0; i < MAX_SDMA_PIPES; i++)
>               mes_set_hw_res_pkt.sdma_hqd_mask[i] =3D mes-
> >sdma_hqd_mask[i]; diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> index 96336652d14c5..519f054bec60d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -694,17 +694,6 @@ static int mes_v12_0_set_hw_resources_1(struct
> amdgpu_mes *mes, int pipe)
>                       offsetof(union MESAPI_SET_HW_RESOURCES_1,
> api_status));  }
>
> -static void mes_v12_0_set_gfx_hqd_mask(union
> MESAPI_SET_HW_RESOURCES *pkt) -{
> -     /*
> -      * GFX V12 has only one GFX pipe, but 8 queues in it.
> -      * GFX pipe 0 queue 0 is being used by Kernel queue.
> -      * Set GFX pipe 0 queue 1-7 for MES scheduling
> -      * mask =3D 1111 1110b
> -      */
> -     pkt->gfx_hqd_mask[0] =3D 0xFE;
> -}
> -
>  static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe) =
 {
>       int i;
> @@ -727,7 +716,9 @@ static int mes_v12_0_set_hw_resources(struct
> amdgpu_mes *mes, int pipe)
>                       mes_set_hw_res_pkt.compute_hqd_mask[i] =3D
>                               mes->compute_hqd_mask[i];
>
> -             mes_v12_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
> +             for (i =3D 0; i < MAX_GFX_PIPES; i++)
> +                     mes_set_hw_res_pkt.gfx_hqd_mask[i] =3D
> +                             mes->gfx_hqd_mask[i];
>
>               for (i =3D 0; i < MAX_SDMA_PIPES; i++)
>                       mes_set_hw_res_pkt.sdma_hqd_mask[i] =3D
> --
> 2.48.1


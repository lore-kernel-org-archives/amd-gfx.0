Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58D0C77B7F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 10:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61AA210E19E;
	Fri, 27 Jun 2025 10:23:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="admDMArD";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B780E10E19E
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 10:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAZBmOKtRXM9oFjr8+sfirDskV9a4l9xSXM45U9hrgatwdf3J2+/lxXwfUfdy6ZpBRKkd4S1aXEzmSQ4hyBgAZTNPNBVquYeVyK8UUTM7zndJYfabyWbHgqXwDfDpYu9RsyBArmyzopMejMl2r7nYEBSVnAIlpVXTMONRNPiDCdas+apo3awoiDupWMgYM7QlIpV+Vx14/9hUv+TYe2cBJqk+2CcEGzsEV0WbJQi7LnYOW+BimzRzrn1hb+xdjAUa3SkkU2Gi3yN6Wq2CKODH8Ed0nfkHGDNFAYneIH8wMtbTo78y1tS8rUX0VAKCSaZlpY9sNhfwaQuZOnthgvVpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uqfG/xQlmoiZV8y8LoMV/1gfMHmjR/ia3S+97FZm4I=;
 b=ZyJJ7rWzp45FdpV5k8S8O+o577of0DCgrB8ivT3Z1hDr6xUi74Jv0H2mWIwLJ4/RVGM0EAIxi0s4htZ/0WhT/uxkIlv3fmaenFOQDBSSEZDjFlHyF7VbdrTRvQdCTEGX9Cy4ixVUXi9jXnGtC4chTDSZTmKTFle4ThjMGTgEH92XxtCKv0RPo5qCVH6cvE397dqY+tJTumHuffVcKjT8IJ4VAV6OwwwjjFzxQmqFsG1ECxIG8p/H3fe2PbdEq2Sne2DWbabLY/0TpXFfSCbqiTPIG+FvyNA907S+YAJcxz5HGxSWV3KX99K4b2PSwwZLSIpm/SQDH24yv8TEXtFjvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uqfG/xQlmoiZV8y8LoMV/1gfMHmjR/ia3S+97FZm4I=;
 b=admDMArDfuWUgLp04/8cn/OD/loo512vWG1EIpUZpajrlJwX3Ua7w5khpHf1tSu5xedA1wMtt0VsoLOtFEN4az39RlZ9yJbUSk7jzlHkODiQOaHWJlycn7AcT3A5SAr/r8P0aCaqQTPMkZNz19LfHX7VGD9wxRFVOUzluYOpnmU=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by MW4PR12MB6974.namprd12.prod.outlook.com (2603:10b6:303:207::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Fri, 27 Jun
 2025 10:23:23 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 10:23:23 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: refine ras error injection when eeprom
 initialization failed
Thread-Topic: [PATCH] drm/amdgpu: refine ras error injection when eeprom
 initialization failed
Thread-Index: AQHb50cng13wjLEiYEW9VlzJkc0EA7QWy9Aw
Date: Fri, 27 Jun 2025 10:23:23 +0000
Message-ID: <PH7PR12MB8796C3BE05880D376EF3F360B045A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250627093631.252367-1-ganglxie@amd.com>
In-Reply-To: <20250627093631.252367-1-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-27T10:21:03.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|MW4PR12MB6974:EE_
x-ms-office365-filtering-correlation-id: 767a250c-a160-4e93-37f3-08ddb564a5a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?RKqJmJgPdqSX6AXvz82HKsCl4PtBmRXDcHXaCrvfo7b9UsDWGwnHFneDEmuw?=
 =?us-ascii?Q?t1bfbJEo4IRUkFkI+PK8v/tEkba1CZ3yLjw7osmnbku5oSpQ8xTTf4qG9SKT?=
 =?us-ascii?Q?KouopxylHeHjD98TkP+3QttS3xNJYvWp5HdFCskehokLdOPgROI3590K2+1Y?=
 =?us-ascii?Q?cohr0IrGAsQeT7JjeR/Ria2AQ1U+HwzLLuyn4ajdImbjXsaULYW6VGyzACVC?=
 =?us-ascii?Q?kbic/HNrCe8ZCgiDPU/euEEFFUygZzvpJSwClpxvH1bAae9XnfhVO4q/ZCPQ?=
 =?us-ascii?Q?KZcc95rfIlQUEav20KofHbbrLM6mBNYffHlcGPCi1RrP9UTF/iukVJsMAKAq?=
 =?us-ascii?Q?O2Yqu8N8i7MG8X9A3WVWvG/yx8hD1gQAoITLQGUIGteDpG9QLHhQJZcaexzG?=
 =?us-ascii?Q?wSfqYueaqkK2ME2BEckgkuVn401IoHZxysNfjl/8cBegzY2+vVPLIsxuYejV?=
 =?us-ascii?Q?Wn18eTbu77eMsG0TY12zPyJp8OEzx0cskvzKwwa9/jRZHoOIXfcas7ay5X/l?=
 =?us-ascii?Q?L/eiJsuq0n95FkH8OX1+p7f3LSLo/NgkiNXL2ZFoVQVomwCoDQgUISl5xCht?=
 =?us-ascii?Q?ACvy6KaoEx0Zo/EcysMXi5XICvbQvC47PfrvcCBXvcqjnY7bxEzlIQUB/0/C?=
 =?us-ascii?Q?44HD+Aylc6nLgT0NFP3vBGrRhyDIoP3xVINTiUbEKOqYqzgUYcXzxcP5B2yb?=
 =?us-ascii?Q?RBHEK43Htuk1UK0jubx8ZvzdVbr2R7T3TB6c6pFkqpqbkLnzBHP4ysdZDhE/?=
 =?us-ascii?Q?R3X3nCo20Bj+rTGzQcI+gTtNgkIyLDjaAZzD4gIRQV4pnOq8O66+S8dZ+gwF?=
 =?us-ascii?Q?6lM7vYcsbKimTtgQV63g/ao8doaagCpmDkSDotGBSpM+Tg/O5vbtPARz0xGt?=
 =?us-ascii?Q?2sxvUdEioX5D6cv2a5F6US0RkYdBHZyw71bRpvjxkERzhZgSgJOcupEWrZZY?=
 =?us-ascii?Q?ESasJl+vCk//twJ5RktjlEP5As5QDHyE+UpEoBAL8Ckw5U5LBlYIgBKhtYgr?=
 =?us-ascii?Q?NRr5Gs0zK7yNxgGwhzLV9VyCtMajHH+EWQVL+YInvIZa/t79nuNJlVqIuaFh?=
 =?us-ascii?Q?Cpc8oB7lAUrs7+6DyJpzWN4FnzGtwoSIxhKZYHLpBsV8ZphfagKUPzQ7Yf2q?=
 =?us-ascii?Q?f2V0T5llY0vK6AjnLbQq+Geu1rJdwKICldwmk0BdjLKri0eE9EbkUHM8ReR2?=
 =?us-ascii?Q?/rTisDzSy58CljXRdkOs3IA7v8qo/8JBk8aK2XFBaRAtqyvu4+sT7zsse8PQ?=
 =?us-ascii?Q?i1P0RFCGWYw1AJ+OH9r4PwHfmu7KXVDEViuyPpQxnwgQ4iIqNqWzabKHAV9Z?=
 =?us-ascii?Q?/Ytqno6XqdW/tbPDeA4ZwYTzogspZQ8XZL2TBD6OQ3qxiIIvixFTB4zhC+lK?=
 =?us-ascii?Q?32tOrlXts9S+FtyvLYZzuqhDmXkPNzei4c1PesLQahPv3fF3siy2S7FGMG79?=
 =?us-ascii?Q?KS+AqwkKTf1sZH+I4cZlLBxiv7LrPuIBfsTRU0SdMV1widej4rSG9UEoLTzP?=
 =?us-ascii?Q?30qM8/DgI2hsz4w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/YE+LLvq8ANYJ7bdA8+FMaduklnZGtEITl0iZa9remZ9ehN19qb7HG9CJzi0?=
 =?us-ascii?Q?AAnQ6kIYAd5I8dMgfO+a2temCidzea75+yxRGVJ8x3ybinzUqMzCz79pA/ia?=
 =?us-ascii?Q?KgrQx/Od40z1JKibvh2xmF9NC9URdPB7W6Z8B7YCkx399WftTiuVdi0q6+CN?=
 =?us-ascii?Q?fQ4G9V7vqB200F39vUXPKbAkj3s2b28gYlU/THC+lOjPcPJwumwmtaFgUyJA?=
 =?us-ascii?Q?3EVKJhB0rasK6FwM+JgVpAp8ppV+rzwAIXOtAM7+kBZqQ6wsmviAzoVl7Q36?=
 =?us-ascii?Q?OWQowxqDdmhGhMS1BGVVHfMkEtNAYKVPaGz3av8+++cBEAI5lCMJjBHjrEKN?=
 =?us-ascii?Q?S4QnN2MetgTZugNzQBKazzeAMFQxywjafOHmreCJ+KGBXcxBqcEQ1bku6le9?=
 =?us-ascii?Q?9Fv9LHyrNjt99eZwr6PeSJa6KRePujLayGotmkYdSeCqljN4fLgSugfhFNtD?=
 =?us-ascii?Q?y10mk41s+C4oTtFMvzCATbDzOGQFvJe63MKPtXlzX9YkgvfYCcMd1CjRWitK?=
 =?us-ascii?Q?szk13Fa9xCn2dG5D3bDeFjeku5Jp8xgO18H7qK/CvUw9lQLxNliEvlsgP7ya?=
 =?us-ascii?Q?jRwfdLgRUZqcmiCh8ibZDvZWuUty6jlqaaYDLYJi3weHExhVgUSvrg/Tu0pr?=
 =?us-ascii?Q?63NsJYzER4lDIjpHFdVGYuz/rT+6muHRMidc9PCK+M4g79GIGYvmhdOFChxS?=
 =?us-ascii?Q?DuwDM2jV50e90rQllfWz5YAIHCv3EnnOXtmHkfIwDkXUi+7qYOfst9p9DX8H?=
 =?us-ascii?Q?9JLbDpgK6Q5aKq9N+e8hiw/tADKVBq7e1969zIknTR2FcoTCV/bitjXmmXtS?=
 =?us-ascii?Q?VelwxZSOImGmPdZTn3P4e0DN47Iqk7RK5QSIUVuG4ygkT8/HntMi3vGIIsTN?=
 =?us-ascii?Q?QqQi9tKZhhisw5lDFm3MySEgwjCckPMIdrmPYe+yLdPCgz2zFWNL2rqloqti?=
 =?us-ascii?Q?AYEZpxoJnFiVUv0tBR8cj4yoGzOf2ETNXFsarSZKGYyRkxG+6h4Zuboa5gIN?=
 =?us-ascii?Q?gAxu2MWKmiUZlzM6NRNb+FohR+u/pW6Kf2lwHulEgFnYDs07c32g0ip+UFpJ?=
 =?us-ascii?Q?K7zpnl2Nzx4uEROyLzjwDW9A9jaZSvQEDZi2njVIn0keEHDmR0g+aGMdSHao?=
 =?us-ascii?Q?YWLaar1vDTbFVooM4ak425d6T6IAknWFiq54Xw4eeYVFQ+35G7wp5thFJpy7?=
 =?us-ascii?Q?XQ5dDxdGsbiNlkGHBV4rDr2jx925qerG35A1jZy2+rJwoYVpocsK5yPWpjfq?=
 =?us-ascii?Q?crMhh4Ozoq5mfLn1Fm2jA4NqfzjuBwIuKl32iiKs/EDkAd6Q9YSmtW4ZOUHZ?=
 =?us-ascii?Q?7RYL5ISMQrSLUydGDNrf+f4tUF5ejeQjxyEVBz4suK51scuWs6WZRV1XY3YG?=
 =?us-ascii?Q?qtXH3uY9rRP0iBygB9lRYccP2fX0YE4hkDj8tKu+WV35yvZrvDnf1C2hTy+a?=
 =?us-ascii?Q?Mw9teALE35trSjbHPBsDRHQP3vsr6uJMB39QPXfSmq6YHUh31uEH7sh2ySAa?=
 =?us-ascii?Q?38A9NpHHkQBb6uqtxlw350wXu25SODZSbMUUwmRQuTApHaFsHpaUkeV18l4u?=
 =?us-ascii?Q?/rL0KgzaH9WaVTmxOT4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767a250c-a160-4e93-37f3-08ddb564a5a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 10:23:23.6382 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QunUntDBrrIlDMcSSA+66oLIt20IrGgeq4PHGCRu+zEAzFIOO3dDdAYyYDlmxNnp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6974
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

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Friday, June 27, 2025 5:37 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH] drm/amdgpu: refine ras error injection when eeprom initi=
alization
> failed
>
> when eeprom initialization failed, we still support ras error injection, =
and reserve bad
> pages, but do not save bad pages to eeprom
>
> Signed-off-by: ganglxie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       | 22 ++++++++++++++-----
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 ++
>  2 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 514b56e5d8ba..d24567787f9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3009,6 +3009,15 @@ int amdgpu_ras_save_bad_pages(struct
> amdgpu_device *adev,
>               return 0;
>       }
>
> +     if (!con->eeprom_control.is_eeprom_valid) {
> +             dev_err(adev->dev,

[Tao] since we return 0 here, it's better to use dev_warn, other than this,=
 the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> +                     "Failed to save EEPROM table data because of EEPROM
> data corruption!");
> +             if (new_cnt)
> +                     *new_cnt =3D 0;
> +
> +             return 0;
> +     }
> +
>       mutex_lock(&con->recovery_lock);
>       control =3D &con->eeprom_control;
>       data =3D con->eh_data;
> @@ -3502,8 +3511,7 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_devi=
ce
> *adev)
>
>       control =3D &con->eeprom_control;
>       ret =3D amdgpu_ras_eeprom_init(control);
> -     if (ret)
> -             return ret;
> +     control->is_eeprom_valid =3D !ret;
>
>       if (!adev->umc.ras || !adev->umc.ras->convert_ras_err_addr)
>               control->ras_num_pa_recs =3D control->ras_num_recs; @@ -351=
2,10
> +3520,12 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_device *adev)
>           adev->umc.ras->get_retire_flip_bits)
>               adev->umc.ras->get_retire_flip_bits(adev);
>
> -     if (control->ras_num_recs) {
> +     if (control->ras_num_recs && control->is_eeprom_valid) {
>               ret =3D amdgpu_ras_load_bad_pages(adev);
> -             if (ret)
> -                     return ret;
> +             if (ret) {
> +                     control->is_eeprom_valid =3D false;
> +                     return 0;
> +             }
>
>               amdgpu_dpm_send_hbm_bad_pages_num(
>                       adev, control->ras_num_bad_pages);
> @@ -3534,7 +3544,7 @@ int amdgpu_ras_init_badpage_info(struct amdgpu_devi=
ce
> *adev)
>                                       dev_warn(adev->dev, "Failed to form=
at RAS
> EEPROM data in V3 version!\n");
>       }
>
> -     return ret;
> +     return 0;
>  }
>
>  int amdgpu_ras_recovery_init(struct amdgpu_device *adev, bool init_bp_in=
fo) diff --
> git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index ec6d7ea37ad0..35c69ac3dbeb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -114,6 +114,8 @@ struct amdgpu_ras_eeprom_control {
>       /* Record channel info which occurred bad pages
>        */
>       u32 bad_channel_bitmap;
> +
> +     bool is_eeprom_valid;
>  };
>
>  /*
> --
> 2.34.1


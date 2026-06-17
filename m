Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79656CD98E2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 10:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D45E10E9B2;
	Wed, 17 Jun 2026 10:22:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r7KF4GMQ";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAB0D10E9B2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 10:22:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFVzXBArQw/WnP2141FzOJRUOsw2hKbn/30t9ySRownPXVQ5ybwcWAicTPDS3t3IGXiZIqLaQsW+NjYJ8H6RLRMpQ/LsuGf/XSSU5NNu/eYWuf3cGyKIeT5meIth02CNVJbN9DV3IjuRmfuASsLGzxw/2802uvl4Ox2TE/Q7vJLNjeRkOlcY77/qAngtNBCDObWPnTYi4kXToBzxZG4ZwafScxdiV1I4oK/dz7Zj8AZY4LGt8zoMRWZh2s5fm71o1GHbSZC3tN0g8z9tVANjJ92s05mI2yHAVI0ClnI4wHckdk5n3/w85IX92U+HHqNzXHo5ZkiF31diazKWtazSNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjTjSv4asBPBHE1UnwowDu4GiRuOw9Fqnb9UjRt/fYQ=;
 b=i/7yqKTIbWMz9pq0AIzB0OLmnPCOjObycW3O3NSRS6iyNBRc4PWEXZmCC+JOY3Qj6tHIXSgLF/ZBHnJMkzOLwGkVxoBxoTJtq1pX2uDb/Pw4xj+YG0PanpLVwW4ybw/z36oinKoZws0eDdCUMMJeRfhMDRDB7FCC6ti6Iiu1Sov4bnXGS+CYOEfrwVEqb4f4E88hjpjfnDNNDbWd3hjwieOhsyJW6m4qCHzK4NsPbZy+to4/LzRxDe2K7BT1OdgVOc0sUrjX2J9ZD+VwxgRuxyr+yKY/Z8j2yETWSkDMTx31If1Scs4WgN6MCRsB0wIvWYNKLbyKxq3nF1+Buk8qHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjTjSv4asBPBHE1UnwowDu4GiRuOw9Fqnb9UjRt/fYQ=;
 b=r7KF4GMQAc0raoylXgQQ5YqnpWk4LRcEbWGwmF8QRrfiFAsk2TZVng5V9ZBJik4lC1xP0mFiKsQ8rnHfa/4ZsGHPiidnkAU6o6POfSIwxsAwPDlzdUXwd0E1yOgNlA7L/3wvU8qfH8ItAKUZzld4V7eCIze5KX/s8uwb/rlZql8=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 10:22:50 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::716d:8670:35b1:27a9%5]) with mapi id 15.21.0139.011; Wed, 17 Jun 2026
 10:22:50 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: dump RAS EEPROM table via debugfs
Thread-Topic: [PATCH] drm/amdgpu: dump RAS EEPROM table via debugfs
Thread-Index: AQHc/kAy+kDd9x0bOkOmNFkfE3Fy6rZCiakw
Date: Wed, 17 Jun 2026 10:22:49 +0000
Message-ID: <PH7PR12MB8796C348D48EF8EA2B63B6ABB0E42@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20260617100034.1811588-1-xiang.liu@amd.com>
In-Reply-To: <20260617100034.1811588-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-17T10:21:38.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|LV8PR12MB9155:EE_
x-ms-office365-filtering-correlation-id: c083f10e-de75-48b2-38a1-08decc5a6246
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|6133799003|3023799007|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: A/V6bNFbTMAktGqaI/2W43j3idCwZoDFxHgQ30HyQeCezaFaNkop1ccpXw0kXL6ZcCsuwyNpu2uJniMef2eZW711koymllkUJm50IaP8oBG0JD7Q4h58TGCg2IcUZBIvac57oFHZiDpyK8ch6i0tx/ZC6l/A4AqoX03kAQYzlQwyNpCKh7sQXkPKVO7oZOeyvrslrlcLoGWGT1BfRleCy6YlM8Ag/zA0EBV1mrmcwMps+461IQSNGuRokkFtgvGNP9P6lJhYfhS5qcg/6p2qjiiPNw1cxDS+6borVksF4HI5l1kpLfeySiUyAcdW3MHzY+oQPU43RURM8GRt04i7tnopwa6ZbuY6H+eZUTuNnmz0dOZDVbNw44wYnBnge3toEPPir3pUd6qVLL4LiezzaCqG5Xhlg+U70IJhfTYtg3Ip0+KjUS/ybo+oX1UKWfdBrAjoy/Nk1M/gjlVXB+ifSJnB2Ye3v2uieOG/hdIT0E1tQ0He5CAyQNN4TOc7zPPwawZ9IWl5EpGZ6h9hNVuKtEnAyKH2JONLOL1MQ3LYRHzVFnIAQccv+KqbG7vjR0s4OA9mIhfyKBQqoWeWFbKfC6gLLH8CDuwnk6joCWPf3hHr6S8+foD6zb3TxoBFkHalseGjIO5n8OSAzBgZf6ji+EXLIvoOFcWPs3EGLYNy+h+Ue6nYASKW2IV2NQka5lgahN+nee7nesakF7wEsZiyA7zG6sf1RXVFKLscYoHZOTljXbmyX+/ziPKbrmAfZHbP
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(6133799003)(3023799007)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HWCfErcr0Wwsfxz7eE70lgt1KturiB9TsR/B35i12wIWQj2cmAcFT0rJ32xj?=
 =?us-ascii?Q?9QvDGF6DqCzX4qCUl1bIbDryeq96Eic6fb7Q2wCmTt1TQ3/mIs9tgKELfU/L?=
 =?us-ascii?Q?PNQi/Cnrq/zeCYzfPQ3/C4cg8qagi6BKDPeu3fszaLyT+WAIOQPiwh4AjkIY?=
 =?us-ascii?Q?EK+kgpV6OLWZePt73QjYxNDl7P61j/7mgGtelkPvRgbE+RGf/2usWW/q6Tlt?=
 =?us-ascii?Q?k1yNTeFcZZ+AQtv5bjvf32sPqiM9Av47KUoUHW/JUB8LK/L47jOsS0WKztF5?=
 =?us-ascii?Q?vTCkAtubzxEE4tWkC1V8aFNtYEN/ZlMWMIHaU1rN3rgC51XCjk8OR7Ax6+R5?=
 =?us-ascii?Q?MrER/U/wx42DcfKIdQGHKEg/HkOe1wvNdyHDDcfnZoQyGKQ7qvaSJ0SwooWn?=
 =?us-ascii?Q?4lHffdBPyTV5wr0qnja3ExLblL29LCyIKRnhkIP7mSozeUUsadU9f33sGfMb?=
 =?us-ascii?Q?4uEZaMuy/zUgLqJN2exrNEihBBIOySnRReRa0C6Ej62cwsOsfBmUIDgS1I4N?=
 =?us-ascii?Q?IlhJLyqYLO4GLtSh5+8Oo264kEbqBIwKcjFtRs5902ZGAmIZ/mJaYgNwnzG8?=
 =?us-ascii?Q?qn1NXqDpBM61h9UAe+RCX1FO93wAGXhG7w0TEmKXRSjLRsfjNlR2w2qVkByc?=
 =?us-ascii?Q?Us0N2fUQa4J/AKHB6YAwPsbnVJa81VkhJ9kH3sxcoN6kBc+8XCTluiZJaC4L?=
 =?us-ascii?Q?x2S9Wvjgi09FR4UyK1D/toV/2Yl7ulYc0i/4yVsP3h93OL41IIk72Is/b7Ac?=
 =?us-ascii?Q?d3p+z5OluIk6rHQKmWqaRC1XMeboD7gHjwDHKoZHUGAzwdiTN23icoGov0vR?=
 =?us-ascii?Q?vcGulS8Jxedmq7MRW/LDy0tRXN866Yu2hBTFqYwVLn+bplRnQHwbqsQzqtWz?=
 =?us-ascii?Q?wetJB7XroSFOqIjnen9wiJEqWpcBfnmSyavjmnCUxrCtTAbOtrNfpetVNU6z?=
 =?us-ascii?Q?EjxZ/T+bwl8adjaW+FHx3PkEHGethUUt2iWm2bgITvfW8qOf2ENPaBToV7wD?=
 =?us-ascii?Q?qGv5TpAZ6GjRWlqKwsU3vEuwmBZ2G5XJNvyF+PNOEt1KoYt/2bvsVFIHR/0H?=
 =?us-ascii?Q?qOhCMcrr3dpv0oOinSMFFAf4rZoPHfW9JppNbQSjgiDXAQVQBG7OS/XFmruM?=
 =?us-ascii?Q?YBIOtoc0/8byg7bPIEWGUY2D6EN4OHVPaW0wgpRxQ1XGreobTpPMWIHcqJ/J?=
 =?us-ascii?Q?SyHeqgODHA3YCzdjRNfMzMTq/aViIoQmymQO24Wku4gFZh5OcxrMztgDfhGS?=
 =?us-ascii?Q?tA3BD0eaGeY0/Co5xM/jlI2kfvVs70vnk1i8+spDb2dPXR1HRES4Qgvank35?=
 =?us-ascii?Q?yEdZNe68zzDMmxyBDWaVK+KBiDctq3n9ZyIfNbgmHyf2z+uLIUdbnxWbn9m7?=
 =?us-ascii?Q?wCAysQW4Xqd2Zy7Df9HtL81F1++9+yGWnQpqxiqPfFPpE0gk2fPijlLQGQMA?=
 =?us-ascii?Q?HkJfKC06BlegbwEJ7ac5AQ745dd7rsIr0GPWRsD7nT2pT1uTygn/Qg1KrDgf?=
 =?us-ascii?Q?/QadctuCsllFGtTElRH7VjiZXdaQ/mgnnuP+8K0FqJP5KJctjWo2lXB8IH4o?=
 =?us-ascii?Q?y6NN30VNTlkExCGTsVERp5Xf+5sGEFpvPxsCAKnZ707Is0Z4o4z1h8QOMBh0?=
 =?us-ascii?Q?4e2zObnFEcVFDaE5lujIIX3VFtVlIMj8+yQsAbC/AJKCo9ixyMf5rzgKDchq?=
 =?us-ascii?Q?EiwbHJDrCIamJ3jgHb7iHr9XXnN79Smb47Ys+tVE089MqQWn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c083f10e-de75-48b2-38a1-08decc5a6246
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 10:22:49.9933 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YiKQaWo1MC+tV3MNMRKCz2HDUKdXv5kYA7V3O4pTF4V6vGXlEINgRQtHJiLNh+Zw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155
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

AMD General

amdgpu_ras_smu_eeprom_supported check should be added, with that fixed, the=
 patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Sent: Wednesday, June 17, 2026 6:01 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Subject: [PATCH] drm/amdgpu: dump RAS EEPROM table via debugfs
>
> When the RAS core manages the EEPROM, the eeprom_control is never initial=
ized
> (amdgpu_ras_init_badpage_info() returns early), so reading ras/ras_eeprom=
_table in
> debugfs printed only a zeroed header and no records, even though bad-page=
 records
> exist in the RAS core EEPROM.
>
> Source the table header and records from the RAS core EEPROM
> (ras_core->ras_eeprom) in that case, reusing the existing output layout s=
o the
> debugfs node keeps the same format.
>
> Signed-off-by: Xiang Liu <xiang.liu@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index fca2b49bc13b..cc8e13084063 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1398,6 +1398,82 @@ static ssize_t amdgpu_ras_debugfs_table_read(struc=
t
> file *f, char __user *buf,
>       return res < 0 ? res : orig_size - size;  }
>
> +static ssize_t
> +amdgpu_ras_debugfs_table_read_uniras(struct amdgpu_device *adev,
> +                                  char __user *buf,
> +                                  size_t size, loff_t *pos)
> +{
> +     struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(adev)=
;
> +     struct ras_core_context *ras_core =3D ras_mgr ? ras_mgr->ras_core :=
 NULL;
> +     struct eeprom_umc_record *records =3D NULL;
> +     struct ras_eeprom_control *control;
> +     size_t bufsz, len =3D 0;
> +     u32 num_recs;
> +     char *kbuf;
> +     ssize_t res;
> +     int i;
> +
> +     if (!ras_core)
> +             return 0;
> +
> +     control =3D &ras_core->ras_eeprom;
> +     num_recs =3D ras_eeprom_get_record_count(ras_core);
> +
> +     bufsz =3D strlen(tbl_hdr_str) + tbl_hdr_fmt_size +
> +             strlen(rec_hdr_str) + (size_t)rec_hdr_fmt_size * num_recs +=
 1;
> +
> +     kbuf =3D kvmalloc(bufsz, GFP_KERNEL);
> +     if (!kbuf)
> +             return -ENOMEM;
> +
> +     if (num_recs) {
> +             records =3D kvcalloc(num_recs, sizeof(*records), GFP_KERNEL=
);
> +             if (!records) {
> +                     res =3D -ENOMEM;
> +                     goto out;
> +             }
> +
> +             res =3D ras_eeprom_read(ras_core, records, num_recs);
> +             if (res)
> +                     goto out;
> +     }
> +
> +     len +=3D scnprintf(kbuf + len, bufsz - len, "%s", tbl_hdr_str);
> +     len +=3D scnprintf(kbuf + len, bufsz - len, tbl_hdr_fmt,
> +                              control->tbl_hdr.header,
> +                              control->tbl_hdr.version,
> +                              control->tbl_hdr.first_rec_offset,
> +                              control->tbl_hdr.tbl_size,
> +                              control->tbl_hdr.checksum);
> +     len +=3D scnprintf(kbuf + len, bufsz - len, "%s", rec_hdr_str);
> +
> +     for (i =3D 0; i < num_recs; i++) {
> +             u32 ai =3D RAS_RI_TO_AI(control, i);
> +             int et =3D records[i].err_type;
> +             const char *ets =3D (et >=3D 0 && et <
> AMDGPU_RAS_EEPROM_ERR_COUNT) ?
> +                               record_err_type_str[et] : "na";
> +
> +             len +=3D scnprintf(kbuf + len, bufsz - len, rec_hdr_fmt,
> +                              i,
> +                              RAS_INDEX_TO_OFFSET(control, ai),
> +                              ets,
> +                              records[i].bank,
> +                              records[i].ts,
> +                              records[i].offset,
> +                              records[i].mem_channel,
> +                              records[i].mcumc_id,
> +                              records[i].retired_row_pfn);
> +     }
> +
> +     res =3D simple_read_from_buffer(buf, size, pos, kbuf, len);
> +
> +out:
> +     kvfree(records);
> +     kvfree(kbuf);
> +
> +     return res;
> +}
> +
>  static ssize_t
>  amdgpu_ras_debugfs_eeprom_table_read(struct file *f, char __user *buf,
>                                    size_t size, loff_t *pos)
> @@ -1411,6 +1487,10 @@ amdgpu_ras_debugfs_eeprom_table_read(struct file *=
f,
> char __user *buf,
>       if (!size)
>               return size;
>
> +     if (amdgpu_uniras_enabled(adev))
> +             return amdgpu_ras_debugfs_table_read_uniras(adev, buf,
> +                                                 size, pos);
> +
>       if (!ras || !control) {
>               res =3D snprintf(data, sizeof(data), "Not supported\n");
>               if (*pos >=3D res)
> --
> 2.34.1


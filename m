Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB25FCD1288
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 07:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFEDE10E2C2;
	Fri, 29 Mar 2024 07:32:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KhywTjeh";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2126.outbound.protection.outlook.com [40.107.94.126])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB43B1124E3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 07:32:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DY7NpdNDj1dVDSe8GKzlU9OchlIuKaQMEEocP86PTLOCWusYF8gjB3xnA1sjxbWA2jW0DLbzYF7tkmv8isJT4MTUiJeBnwCWZyy0ryQ9FuYl4MLqc/eLhvnb9HRQ9mhdvqamVsdHGTguMrR16F63/k1aYnzLu6GBgeGqXYLsqsvTaMxTwG+Mz3m2pJo1j5ikYZO8IcQDGQzwFLOG+9VeQoKc832LQLegM1BUI8IU+Izyto/bROiI+XXzXpgvZf3vtlFERkD2XAh0rclrwHRCtQZTJaPpwhUtnJbz4Pehn4Fs4pqU8Osm4iMkvZxHbolQPEK8VqtNg7zR5fNlXs6zyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6/M9OtDJRNjbWE0ZSQwP6FCWG40J6ReJBaHLbF+Xvk=;
 b=nTFs2/uN+D65A+6qrLkSDeMIXg/S2AdKOQdh6Q1ZKdqZlR27Y/MTIzRS7+WZgs23fX/q9WD9lKwj8Pi10jvKQy1/Jh8j69xtp6nqQkd6x5C4iC2MbMJ0b4bOGC7yc+/FjdJhDbKYu2eVOLLBO3utjiB/MB3PghKOi+8pVmxmAsT3SXomsLCzvY8J/9tfmHe1hy7ZpvsYWJocACO0G15loMOwvfNgFGxPzAReeuXDR+8LC8MhLC8+A82WgIdq3IBF3KCsZiaLMF1vKjf+iM8W6eVNjNyiG6VZ9Pn/go3Y6o7gCqvCuEnkeuerrFx8lfbEpG3tkIt2PTQqzzc3YyPKpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6/M9OtDJRNjbWE0ZSQwP6FCWG40J6ReJBaHLbF+Xvk=;
 b=KhywTjehOOxCnHhjbexaIJAbXLFe3CVPB6R1fqZlf9radeRSdGXEaow6BhBJYEVwtrjHHHdykeAEPQopiwI4DY2SmaGdLYQZZAnrmEebp/4Dxk7OOOiBQykWVQ6ltWhdlL0G13d06B7L8Eo+UHTdFxQ0tjSH1jOsO1pXT6haBe4=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SJ2PR12MB7800.namprd12.prod.outlook.com (2603:10b6:a03:4c1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38; Fri, 29 Mar
 2024 07:32:16 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::2c3d:b3d4:f995:915b]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::2c3d:b3d4:f995:915b%6]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 07:32:16 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Update EEPROM RAS table for mismatched table
 version
Thread-Topic: [PATCH] drm/amdgpu: Update EEPROM RAS table for mismatched table
 version
Thread-Index: AQHagA5NHXdwDUOyjEepaVe4owyt+LFOVQCg
Date: Fri, 29 Mar 2024 07:32:16 +0000
Message-ID: <PH7PR12MB8796BE4264B68147F0AC7D86B03A2@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240327061544.1115433-1-candice.li@amd.com>
In-Reply-To: <20240327061544.1115433-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=6a64652e-837b-4854-8a5d-8f68d7f359b5;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-29T07:27:29Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SJ2PR12MB7800:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aNuw+7XZzhlmaQFSWjQZ2zBpREVM9Tx2lZBWvmDepskZgRDkcE8Rp2SgPBe/GTRZONdr8ZNhN5K7vSZHzgXxXRop1MbiYzCm+Bz3xnnJL6998h9JIE5GxuubkeU0jE+O4DWr5Jd/3G3ZK26qyDUmwUpxx3fK9wh+px4BCKhHb2gKPDtCEvCpa2y6yL+4Dwls5tgG4bq3DRR7vlZEssy47uHjeKTvj/RA1PxhU93X48PiYx54p+nQv9G/GSgHQ2+eqvQayoJId9F/VysU2+6chBpDLdQ69OPL5c3ak+Fm1PAvBYXFbQh2ldxgDdsrla0xGRZFOY+8HG6x3aXo1xOsMMk28aW2VSLP2fkCSYDJAH47muge4eq3S2sHFSm0HPYOWHLsLamhUFjmyt+9AoOx9oGEl9psjcW4a3eeuU4pKeQHm/jk/rd2Irgmeh5sRL5RU326U4RFpoz/BKa4mxibCtIp/guYpnSjB5/aXAwBwUhSOdoK351HN7dME+kFPaBLCr6IjLxZG9pFbe5hNGL/BxCBoMdysZ1CSNpP7wRZ2eO4tdIhW+j8NuAaBWvSbn1G8Mg1HJYTGh/pCSBKoxXIISmiNrHLM6ZlRYFXjW2MojixLuWSoUPxBGQFwShMrIYCSKfHSKwVVJJ3czSjqvQ5u+FSaBC0dMroud1dx76RG5s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PYmUtWw9j2hPuQVldYWjGbDoE1yk15JhtwflpBxxk/aWl09bki2KVrOe89O+?=
 =?us-ascii?Q?wapYPMQuP45jSUa5SlGyouImrEuDbohIeZwlgtSmIg0H6l1kikqTrb2kFIAY?=
 =?us-ascii?Q?UqwJCORagxWUPMm+Jwh670r8YEvLLs6hcJ4Ukx7w/qxl/eZh5D5Yhasx4s5J?=
 =?us-ascii?Q?A+kL+4cSWJWMe0lMs9RfZ/yXs9o58wGZGgf8OsaEpcbpVdKh86DgJnYbN2//?=
 =?us-ascii?Q?tqEFAql1JMql3zpNWhFJJYC7++zueRIvGP8Nhqf1KwZ9NFVOeGLQ9+2DQ7V+?=
 =?us-ascii?Q?6jwNVDNZioTZs0NaaFnuotTfKZ7FCk5ivgEPkIcGJQWMpVwzB9kM/P3s8n8T?=
 =?us-ascii?Q?jBpsXMDJOZ2X3hN04a5zYIbDmtq+f3IlnUsOAwIbbDVtHetoNG6989afcxsr?=
 =?us-ascii?Q?ShdpqCjn7MAdAUEz5iswHAVpzhlzZ3W5ILH/N0qp7KxALV5cWJcf8KOSLCP+?=
 =?us-ascii?Q?IZTTBnXwey3YU1F54QVDMx+HN1Zljz65dxXQeuFAheq0pLh1hRNFvhfWtptX?=
 =?us-ascii?Q?t9edG8tForDtP8MCJbnXm9jrVfQggcjlAoyReDDDr3ITxIBB4xOPg+r16dOp?=
 =?us-ascii?Q?YWpDyF3JTQ5a+oFdU4UGE36vVLBp49IkDilCJFlJKrIYt7yiTWSnF5DbYzPz?=
 =?us-ascii?Q?k3RitHKBgzeCI8NbvAUH0JlYV/2lbZ+1wN2HtqenXn920SsVUVH35ujXVohD?=
 =?us-ascii?Q?9Npda+9hNzP5LCMEsCqzgN+gAkaR0fLKcXQXrKLh5oNUqiBr8YXgEpdGjEzr?=
 =?us-ascii?Q?hqeDBJk81yo8WC7IoKzF/nAJBTgZuupaeGS+Ml1z+M4v7HTYOx9HRong7xM+?=
 =?us-ascii?Q?fpgKAF5EZYtoTKYvL32/RKvmdOsv6nH9mqflZ9C1mBndFgxOAG/Wf9J++K63?=
 =?us-ascii?Q?DaKv9IS8/KM/P3KcoTVUKBBWm6pmuEgsgJwU6AsZa6ipF/D/mk7+o5ytZB6f?=
 =?us-ascii?Q?DUGzKoROJRGVXQFH6MN7Vr+zsNnzHPrdstLvuXnbbgG/85h3R6NpYCp7pfsa?=
 =?us-ascii?Q?pJ74Qp2Q38YnpPEyz0yTqIttkWABSkT3dkwmHOaATuPLjLcd3RdHpPBDKJrb?=
 =?us-ascii?Q?bYvQBqO4gtLIxM9oyolqmlAIa99/6E91SxBJL/Cq25LSIFTSGzDz48sj34UY?=
 =?us-ascii?Q?zH1VlzxjN/W22lHDUHHGmjuWvirqw/HrpmpfR6+iqqfHLDq7hhBUQWZx/sc6?=
 =?us-ascii?Q?7PYbVe2D8ZqR3wFm4h1S3x2lM/krAMUXrWocmqjdc+rplPO/S/CAfEb4VL7V?=
 =?us-ascii?Q?OC+QtaA8gfKBdxarMjPYTUeIZTRcZGrCVvadLdFIsQFFLaTKCj144Gc87vsy?=
 =?us-ascii?Q?mXA5ZgvDaeNh1EN6Py23TCXsAHRPzPr/nfs9k0OypDvFSPIqe8TIH/vn3Zq4?=
 =?us-ascii?Q?kxpuMf/65WjX3mTNl07wck1gYteQPH38uw1ap8xqYahmusl+Vr95/JaDvtO5?=
 =?us-ascii?Q?V+EJNQP2TBGvFyYFmGF6m32KX/KL4RYkykEffBh1BAebtwW0aDlheMpH0CQi?=
 =?us-ascii?Q?3TT+PjpyYL87/LuBoK0ukuag4tfs5LLsnd7ckUC3LA06bbv1Kc1AwRnEKnfY?=
 =?us-ascii?Q?p+iCk0sC3VVhHtrfrfk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2223039-2e9a-4800-874d-08dc4fc25bff
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 07:32:16.5297 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mg84Rbrcs9NDzMZcBA5de5kg5/osXIl+NwONg1C57BMd1HqJ4ezwQCEKJWGs1vjU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7800
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candic=
e Li
> Sent: Wednesday, March 27, 2024 2:16 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Li, Candice <Candice.Li@amd.com>
> Subject: [PATCH] drm/amdgpu: Update EEPROM RAS table for mismatched table
> version
>
> Update table version and restore bad page records to EEPROM RAS table for
> mismatched table version case. Otherwise force to reset the table.
>
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 88 ++++++++++++++++---
>  1 file changed, 78 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 06a62a8a992e9b..42d0ef2f512474 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1319,6 +1319,37 @@ static int __read_table_ras_info(struct
> amdgpu_ras_eeprom_control *control)
>       return res =3D=3D RAS_TABLE_V2_1_INFO_SIZE ? 0 : res;  }
>
> +static bool amdgpu_ras_eeprom_table_version_validate(struct
> +amdgpu_ras_eeprom_control *control) {
> +     struct amdgpu_device *adev =3D to_amdgpu_device(control);
> +     struct amdgpu_ras_eeprom_table_header *hdr =3D &control->tbl_hdr;
> +
> +     switch (amdgpu_ip_version(adev, UMC_HWIP, 0)) {
> +     case IP_VERSION(8, 10, 0):
> +     case IP_VERSION(12, 0, 0):
> +             return hdr->version =3D=3D RAS_TABLE_VER_V2_1;
> +     default:
> +             return hdr->version =3D=3D RAS_TABLE_VER_V1;
> +     }
> +}
> +
> +static void amdgpu_ras_update_eeprom_control(struct
> +amdgpu_ras_eeprom_table_header *hdr) {
> +     struct amdgpu_ras_eeprom_control *control =3D
> +             container_of(hdr, struct amdgpu_ras_eeprom_control, tbl_hdr=
);
> +
> +     if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
> +             control->ras_num_recs =3D RAS_NUM_RECS_V2_1(hdr);
> +             control->ras_record_offset =3D RAS_RECORD_START_V2_1;
> +             control->ras_max_record_count =3D
> RAS_MAX_RECORD_COUNT_V2_1;
> +     } else {
> +             control->ras_num_recs =3D RAS_NUM_RECS(hdr);
> +             control->ras_record_offset =3D RAS_RECORD_START;
> +             control->ras_max_record_count =3D RAS_MAX_RECORD_COUNT;
> +     }
> +     control->ras_fri =3D RAS_OFFSET_TO_INDEX(control,
> +hdr->first_rec_offset); }
> +
>  int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control,
>                          bool *exceed_err_limit)
>  {
> @@ -1326,7 +1357,9 @@ int amdgpu_ras_eeprom_init(struct
> amdgpu_ras_eeprom_control *control,
>       unsigned char buf[RAS_TABLE_HEADER_SIZE] =3D { 0 };
>       struct amdgpu_ras_eeprom_table_header *hdr =3D &control->tbl_hdr;
>       struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> -     int res;
> +     int res, res1;
> +     struct eeprom_table_record *bps;
> +     u32 num_recs;
>
>       *exceed_err_limit =3D false;
>
> @@ -1355,16 +1388,51 @@ int amdgpu_ras_eeprom_init(struct
> amdgpu_ras_eeprom_control *control,
>
>       __decode_table_header_from_buf(hdr, buf);
>
> -     if (hdr->version =3D=3D RAS_TABLE_VER_V2_1) {
> -             control->ras_num_recs =3D RAS_NUM_RECS_V2_1(hdr);
> -             control->ras_record_offset =3D RAS_RECORD_START_V2_1;
> -             control->ras_max_record_count =3D
> RAS_MAX_RECORD_COUNT_V2_1;
> -     } else {
> -             control->ras_num_recs =3D RAS_NUM_RECS(hdr);
> -             control->ras_record_offset =3D RAS_RECORD_START;
> -             control->ras_max_record_count =3D RAS_MAX_RECORD_COUNT;
> +     amdgpu_ras_update_eeprom_control(hdr);
> +
> +     if (!amdgpu_ras_eeprom_table_version_validate(control)) {
> +             num_recs =3D control->ras_num_recs;
> +             if (num_recs && amdgpu_bad_page_threshold) {
> +                     /* Save bad page records existed in EEPROM */
> +                     bps =3D kcalloc(num_recs, sizeof(*bps), GFP_KERNEL)=
;
> +                     if (!bps)
> +                             return -ENOMEM;
> +
> +                     res1 =3D amdgpu_ras_eeprom_read(control, bps,
> num_recs);
> +                     if (res1)
> +                             dev_warn(adev->dev, "Fail to load EEPROM
> table, force to reset
> +it.");
> +
> +                     res =3D amdgpu_ras_eeprom_reset_table(control);
> +                     if (res) {
> +                             dev_err(adev->dev, "Failed to create a new
> EEPROM table.");
> +                             kfree(bps);
> +                             return res < 0 ? res : 0;
> +                     }
> +
> +                     if (!res1) {
> +                             /* Update the EEPROM table with correct tab=
le
> version and
> +                              * original bad page records
> +                              */
> +                             amdgpu_ras_update_eeprom_control(hdr);
> +                             res =3D amdgpu_ras_eeprom_append(control, b=
ps,
> num_recs);
> +
> +                             if (res) {
> +                                     dev_warn(adev->dev, "Fail to update
> EEPROM table, force to reset it.");
> +                                     res =3D
> amdgpu_ras_eeprom_reset_table(control);

[Tao] I think the reset here can be dropped, apart from this, the patch is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

It's better to get Stanley's Reviewed-by.

> +                             }
> +                     }
> +
> +                     kfree(bps);
> +             } else
> +                     res =3D amdgpu_ras_eeprom_reset_table(control);
> +
> +             if (res) {
> +                     dev_err(adev->dev, "Failed to reset EEPROM table.")=
;
> +                     return res < 0 ? res : 0;
> +             }
> +
> +             amdgpu_ras_update_eeprom_control(hdr);
>       }
> -     control->ras_fri =3D RAS_OFFSET_TO_INDEX(control, hdr->first_rec_of=
fset);
>
>       if (hdr->header =3D=3D RAS_TABLE_HDR_VAL) {
>               DRM_DEBUG_DRIVER("Found existing EEPROM table with %d
> records",
> --
> 2.25.1


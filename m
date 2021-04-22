Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24235C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 13:18:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A52BC61425
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 13:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A52BC61425
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D401E6EA83;
	Thu, 22 Apr 2021 13:18:22 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 512006EA83
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 13:18:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lU+6gAFXS7Udv4xXS1nJAwmsjycMMclhQhucYC6pCnz7HdjAOfzLVVvemVGEjuJ71q868btYttwHqv5ihIDkeeFLyJVpDeqO4IA6WeDVGI43OAVUINgNym6+g2qx9rTFNtnV1pfmLZrGvX2MR9X/JmvvWbHua3hKqj96RazZ6UKz4XPhVbBss83igeSxJoentaLoLbsPOBPZ2zSzXLKaRYv9zAqRseQqQv4TfV3qu2iK0cK1ic6/qjwWKre8SzSjUiMYlxf03KWg2xFKjyLx7UDNFbiKUmz3RxRb2TOIqG3TXq0zUqXszIq14k8ivVLY/EZ4XgxyBIZa9ECM/+ccRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aM++jWF1lOXV7QgG4+NUDEyCH2r2HKAFE0hJSq8AGKk=;
 b=glitGllRdivAUQN4L4gIjYRu7gttzsDC3h6v6Z40SuBy8GmM38ldMUOuDduJQzlcLDQWSs9FkPvP+5a2OlcZPfKywH4E8D+GrsdjrOWmOc6voAIWA32//8mKPuHlSypuQmhl5xKqr3lp8Pog8dctb4oC2o/xlULt7QWXIdGg34tMzV7Bu6E4C8GrvlPcF+gfT6HYe3ClEXyC4wIv6ha0wgTcbPACoCFKL50Aatxj6tf3LMdSuScgxMd2+xcBuqd+KHk7OzV/U0JnvPfvhZ7R32fRz/H1xNyUeSQCNUjLaNpI8sup1Dyw0lfXxd3Sgvd6zj0vpl4CxVdLC9lzu02UKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aM++jWF1lOXV7QgG4+NUDEyCH2r2HKAFE0hJSq8AGKk=;
 b=Y0UZGdVii244X2hWvmuaNv8SMJCLF+sd9FmKa+pwYfDkRbqk8E9M4HRqkIRWxbi8RYUJHhbWcGcu2hxifbgLzB9XKvdYsvXdRlxK0X0X9MWJRbW96y3FrYTwunOFqwhkK60Aoxcf1C82BTonRutbWmA50V//6GDRFITyu/79uOg=
Received: from DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20)
 by DM5PR12MB2423.namprd12.prod.outlook.com (2603:10b6:4:b3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 22 Apr
 2021 13:18:16 +0000
Received: from DM6PR12MB4170.namprd12.prod.outlook.com
 ([fe80::34da:800b:41ca:19ba]) by DM6PR12MB4170.namprd12.prod.outlook.com
 ([fe80::34da:800b:41ca:19ba%9]) with mapi id 15.20.4065.023; Thu, 22 Apr 2021
 13:18:16 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface
Thread-Topic: [PATCH] drm/amdgpu: Add vbios info ioctl interface
Thread-Index: AQHXNyAZxU02AtWA5k2SdU2Ic9ArhqrAgz4AgAACZoA=
Date: Thu, 22 Apr 2021 13:18:16 +0000
Message-ID: <F593F9B0-C6CB-4245-BC82-0B63F65DF33F@amd.com>
References: <20210422023448.24689-1-Jiawei.Gu@amd.com>
 <BE86C24E-8E22-47C8-B737-E7F58F8B9326@amd.com>
In-Reply-To: <BE86C24E-8E22-47C8-B737-E7F58F8B9326@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.182]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d2923b8-32e9-441c-086b-08d905911741
x-ms-traffictypediagnostic: DM5PR12MB2423:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB24233E1B34A6DC700E65B0DEF8469@DM5PR12MB2423.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WWHtlBAQmDmntiQVpmqlWv0Y/MRLSFeFgniNJz220wZgs1b8s9vXYT5YpvGETjfjQWJtO1db8DddIT/0AGeLhaQSyJLFy2TofcscL/W6a/V+O5kg1OvdeIX/BUDRSJe0qmpUF9M5j9pVO7G9MwSaL7L49AkgfMP7H5Of3AA8eiaL2NnVWHhDPkS/F7iWuL3d/Rum8AmiA1OH9TcL21bd7+eIPubQOx1wCYvtRec6thEJWv6NYVM9aEOooCY5k3EyAZBXpmy/fevnDMua+DfakGloRb+JEcRiopGdzK9Ywp9LOpnUKUIXaCNNZcl3OtpC8UdDj99/9N0nk2x3u13eMse5daMVKXOMNbOV8BTEG3na024Kn2timOLvyXTh/CvnzfLeJ683oj49fheN+U5sAB5rKccxEpRh+QuqGvpDnfbX9Nzo++M5pHuoI+liMwINHNLPdRNYsGsRKPf4mPzn3whbjWKWhblZnSteuXpA2pYA2dWaVpRPTka9E6P+8lx+3GHIeKYnn1f6+2YeXi7EMS0fK4SWfr01i33UZ89GR1dWeVGPJigyKNX90vRxEj0ZHy+E+Nt+7apdtmRMUpUxapEYh5TN0OcduFvReArD2HAbeM37b2XL9raVVmKV10upiCYQGhuSaWUqlUrnkCj9wYA7uTqG8HTAr+d1PQzbJUk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4170.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39850400004)(83380400001)(4326008)(316002)(54906003)(53546011)(71200400001)(6512007)(6916009)(33656002)(8676002)(76116006)(99936003)(86362001)(186003)(30864003)(66556008)(91956017)(6486002)(26005)(2616005)(122000001)(5660300002)(38100700002)(2906002)(66946007)(66616009)(8936002)(66446008)(64756008)(66476007)(36756003)(6506007)(478600001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yrqNEeextmnNc3XKGtCaMuPSHCnDQLik42DcPVL+UGI4ROpNgCCzYaosL40z?=
 =?us-ascii?Q?vM7PmHHjJR950bVGrhUkMaGDyESNwVn3Hxt14C2JX8xInxWfiENv6hfDNOrm?=
 =?us-ascii?Q?ei4SDot8ANvAXyk9pj3JlvL8TMfVxEZ59wl+YxgLAOZJMtZWrXIXXob30Xfg?=
 =?us-ascii?Q?P3znkOe9YGQFbuNczpRjiFlRRJc9OI+wp0uDrjs1yOcWPBMkdfQhKj8aCJvS?=
 =?us-ascii?Q?p/L3HE7CktpADf9RY8fs099Mj2GOn5EoO5Z4dzSCrDNNdUe5r9roMSZzdV3u?=
 =?us-ascii?Q?ASp4enUt9uqNwHFUjj8m0iJtZhaFszKZGzfxcjUXw4Jhme0uwTKQmVopDtG6?=
 =?us-ascii?Q?ej7CBJN96AoYZMP1gfM+m3QkeiEp9YGpne0kPECT8UtjVfJIg+IVJMZHQJT0?=
 =?us-ascii?Q?sEJnX4Q2g+YyeWHJ/OP3TJ4VD40m96vckXEEdxqMDKeGc9Y4Zvf+hPq5Ew6I?=
 =?us-ascii?Q?WVFHaXnDh4a25x+xatDLbOVXBGRp9Y1z+tKanmNHGJ+wHQ9DmCopLjUPzLMd?=
 =?us-ascii?Q?jVAlnQjZz0DqX0I8KyTXUSL+vnHIhCCBVnAh+fuC8NuzNTecyOQ7TIG0YJxD?=
 =?us-ascii?Q?BK6CscVsOzFinq0vrpRMWqgAuXmkighNZu/n5Kb8YmwwLbgf3R8RSawUY9ZB?=
 =?us-ascii?Q?+P1+eLOy8MCwfm1AKukjVSOxPwTjc9jHn3A8Ps7HDrSSaYZC7H9J6JON2sH+?=
 =?us-ascii?Q?Sri0wABGY/4xZ3l/LlYXDS/CfwCVzgTj6wpzrIOfUOuY6t7+Kb+aCIdnJNxm?=
 =?us-ascii?Q?6hMmmArMpaRmX0WQZbS3KON3yNQ2iav8yl0MKWDV7DDyI6FNyhJoPK11Za+0?=
 =?us-ascii?Q?ZTjSmer9Tk+dT31s41Rr6XBmM4XYIZQppIxljmEmR0Txj2KPeK/Akv8QMDFx?=
 =?us-ascii?Q?0Dxvf5dwrzZvN/SKiwX/YSK8gL71ny9mHUrBhAGSDG/HkaSw7emZducxUCUX?=
 =?us-ascii?Q?snKzVo2XGQhpejlWqKWR0UXSrVNUvS90w0f4GnCkWEEC0cVT1n2cCkmS0e7S?=
 =?us-ascii?Q?HnCXvGob7tkcLPVaBw0oL36KN98z/Q9vwEw5Cq6c7nGJSAbrE0BQABabaBIJ?=
 =?us-ascii?Q?w0COPgdM9dUKvUipeaAbNJZFP3TtxaMH1CiesOd9za7XBU56OkyM2T3znmi2?=
 =?us-ascii?Q?Tv2405YlVZhkGIjybC9fnYKR4xJSktAiS+16Jg/f4T6v5zSyVMuQYordpz7a?=
 =?us-ascii?Q?YV6ki2vkrDfGVwiLDl3SUIb39/mAPzSc10SXBl5hCZF52DeysubKV39Oz0Hy?=
 =?us-ascii?Q?vHrcgCyKEq+Vz9r8DyXl37FI9Gv625892uTQwhT/6AdZcQG3pVwivMwUNwcC?=
 =?us-ascii?Q?MZA4dWxYXeOZtOl1lgTefZBDLhpAhoRUfOTZfJvDn5E32Q=3D=3D?=
Content-Type: multipart/mixed;
 boundary="_002_F593F9B0C6CB4245BC820B63F65DF33Famdcom_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4170.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2923b8-32e9-441c-086b-08d905911741
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 13:18:16.6488 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KF0xI18TeUuKFSH3rVyThwkTG/XAJj7SqxQL1m+n+w9MQslNWbnuT/KWkSkUuPRJ/VYf+NkDHBz7JNF4EnN1qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2423
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "StDenis,
 Tom" <Tom.StDenis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_002_F593F9B0C6CB4245BC820B63F65DF33Famdcom_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <151F188CFB4B214088A774BCD35D3F36@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable


CC Tom.

> On Apr 22, 2021, at 21:09, Gu, JiaWei (Will) <JiaWei.Gu@amd.com> wrote:
>=20
> <[v2][umr]add-vbios-info-query.patch>
> UMR patch which calls this new IOCTL attached.
>=20
> Best regards,
> Jiawei
>=20
>> On Apr 22, 2021, at 10:34, Jiawei Gu <JiaWei.Gu@amd.com> wrote:
>>=20
>> Add AMDGPU_INFO_VBIOS_INFO subquery id for detailed vbios info.
>>=20
>> Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
>> ---
>> drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  19 +++
>> drivers/gpu/drm/amd/amdgpu/atom.c          | 158 +++++++++++++++++++++
>> drivers/gpu/drm/amd/amdgpu/atom.h          |  11 ++
>> drivers/gpu/drm/amd/include/atomfirmware.h |  16 ++-
>> include/uapi/drm/amdgpu_drm.h              |  15 ++
>> 5 files changed, 213 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_kms.c
>> index 39ee88d29cca..a20b016b05ab 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -861,6 +861,25 @@ int amdgpu_info_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
>> 					    min((size_t)size, (size_t)(bios_size - bios_offset)))
>> 					? -EFAULT : 0;
>> 		}
>> +		case AMDGPU_INFO_VBIOS_INFO: {
>> +			struct drm_amdgpu_info_vbios vbios_info =3D {};
>> +			struct atom_context *atom_context;
>> +
>> +			atom_context =3D adev->mode_info.atom_context;
>> +			memcpy(vbios_info.name, atom_context->name, sizeof(atom_context->nam=
e));
>> +			vbios_info.dbdf =3D PCI_DEVID(adev->pdev->bus->number, adev->pdev->d=
evfn);
>> +			memcpy(vbios_info.vbios_pn, atom_context->vbios_pn, sizeof(atom_cont=
ext->vbios_pn));
>> +			vbios_info.version =3D atom_context->version;
>> +			memcpy(vbios_info.date, atom_context->date, sizeof(atom_context->dat=
e));
>> +			memcpy(vbios_info.serial, adev->serial, sizeof(adev->serial));
>> +			vbios_info.dev_id =3D adev->pdev->device;
>> +			vbios_info.rev_id =3D adev->pdev->revision;
>> +			vbios_info.sub_dev_id =3D atom_context->sub_dev_id;
>> +			vbios_info.sub_ved_id =3D atom_context->sub_ved_id;
>> +
>> +			return copy_to_user(out, &vbios_info,
>> +						min((size_t)size, sizeof(vbios_info))) ? -EFAULT : 0;
>> +		}
>> 		default:
>> 			DRM_DEBUG_KMS("Invalid request %d\n",
>> 					info->vbios_info.type);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amd=
gpu/atom.c
>> index 3dcb8b32f48b..0e2f0ea13b40 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
>> @@ -31,6 +31,7 @@
>>=20
>> #define ATOM_DEBUG
>>=20
>> +#include "atomfirmware.h"
>> #include "atom.h"
>> #include "atom-names.h"
>> #include "atom-bits.h"
>> @@ -1299,12 +1300,153 @@ static void atom_index_iio(struct atom_context =
*ctx, int base)
>> 	}
>> }
>>=20
>> +static void atom_get_vbios_name(struct atom_context *ctx)
>> +{
>> +	unsigned char *p_rom;
>> +	unsigned char str_num;
>> +	unsigned short off_to_vbios_str;
>> +	unsigned char *c_ptr;
>> +	int name_size;
>> +	int i;
>> +
>> +	const char *na =3D "--N/A--";
>> +	char *back;
>> +
>> +	p_rom =3D ctx->bios;
>> +
>> +	str_num =3D *(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS);
>> +	if (str_num !=3D 0) {
>> +		off_to_vbios_str =3D
>> +			*(unsigned short *)(p_rom + OFFSET_TO_GET_ATOMBIOS_STRING_START);
>> +
>> +		c_ptr =3D (unsigned char *)(p_rom + off_to_vbios_str);
>> +	} else {
>> +		/* do not know where to find name */
>> +		memcpy(ctx->name, na, 7);
>> +		ctx->name[7] =3D 0;
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * skip the atombios strings, usually 4
>> +	 * 1st is P/N, 2nd is ASIC, 3rd is PCI type, 4th is Memory type
>> +	 */
>> +	for (i =3D 0; i < str_num; i++) {
>> +		while (*c_ptr !=3D 0)
>> +			c_ptr++;
>> +		c_ptr++;
>> +	}
>> +
>> +	/* skip the following 2 chars: 0x0D 0x0A */
>> +	c_ptr +=3D 2;
>> +
>> +	name_size =3D strnlen(c_ptr, STRLEN_LONG - 1);
>> +	memcpy(ctx->name, c_ptr, name_size);
>> +	back =3D ctx->name + name_size;
>> +	while ((*--back) =3D=3D ' ')
>> +		;
>> +	*(back + 1) =3D '\0';
>> +}
>> +
>> +static void atom_get_vbios_date(struct atom_context *ctx)
>> +{
>> +	unsigned char *p_rom;
>> +	unsigned char *date_in_rom;
>> +
>> +	p_rom =3D ctx->bios;
>> +
>> +	date_in_rom =3D p_rom + OFFSET_TO_VBIOS_DATE;
>> +
>> +	ctx->date[0] =3D '2';
>> +	ctx->date[1] =3D '0';
>> +	ctx->date[2] =3D date_in_rom[6];
>> +	ctx->date[3] =3D date_in_rom[7];
>> +	ctx->date[4] =3D '/';
>> +	ctx->date[5] =3D date_in_rom[0];
>> +	ctx->date[6] =3D date_in_rom[1];
>> +	ctx->date[7] =3D '/';
>> +	ctx->date[8] =3D date_in_rom[3];
>> +	ctx->date[9] =3D date_in_rom[4];
>> +	ctx->date[10] =3D ' ';
>> +	ctx->date[11] =3D date_in_rom[9];
>> +	ctx->date[12] =3D date_in_rom[10];
>> +	ctx->date[13] =3D date_in_rom[11];
>> +	ctx->date[14] =3D date_in_rom[12];
>> +	ctx->date[15] =3D date_in_rom[13];
>> +	ctx->date[16] =3D '\0';
>> +}
>> +
>> +static unsigned char *atom_find_str_in_rom(struct atom_context *ctx, ch=
ar *str, int start,
>> +					   int end, int maxlen)
>> +{
>> +	unsigned long str_off;
>> +	unsigned char *p_rom;
>> +	unsigned short str_len;
>> +
>> +	str_off =3D 0;
>> +	str_len =3D strnlen(str, maxlen);
>> +	p_rom =3D ctx->bios;
>> +
>> +	for (; start <=3D end; ++start) {
>> +		for (str_off =3D 0; str_off < str_len; ++str_off) {
>> +			if (str[str_off] !=3D *(p_rom + start + str_off))
>> +				break;
>> +		}
>> +
>> +		if (str_off =3D=3D str_len || str[str_off] =3D=3D 0)
>> +			return p_rom + start;
>> +	}
>> +	return NULL;
>> +}
>> +
>> +static void atom_get_vbios_pn(struct atom_context *ctx)
>> +{
>> +	unsigned char *p_rom;
>> +	unsigned short off_to_vbios_str;
>> +	unsigned char *vbios_str;
>> +	int count;
>> +
>> +	off_to_vbios_str =3D 0;
>> +	p_rom =3D ctx->bios;
>> +
>> +	if (*(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS) !=3D 0) {
>> +		off_to_vbios_str =3D
>> +			*(unsigned short *)(p_rom + OFFSET_TO_GET_ATOMBIOS_STRING_START);
>> +
>> +		vbios_str =3D (unsigned char *)(p_rom + off_to_vbios_str);
>> +	} else {
>> +		vbios_str =3D p_rom + OFFSET_TO_VBIOS_PART_NUMBER;
>> +	}
>> +
>> +	if (*vbios_str =3D=3D 0) {
>> +		vbios_str =3D atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX, 3, 1024, 64=
);
>> +		if (vbios_str =3D=3D NULL)
>> +			vbios_str +=3D sizeof(BIOS_ATOM_PREFIX) - 1;
>> +	}
>> +	if (vbios_str !=3D NULL && *vbios_str =3D=3D 0)
>> +		vbios_str++;
>> +
>> +	if (vbios_str !=3D NULL) {
>> +		count =3D 0;
>> +		while ((count < BIOS_STRING_LENGTH) && vbios_str[count] >=3D ' ' &&
>> +		       vbios_str[count] <=3D 'z') {
>> +			ctx->vbios_pn[count] =3D vbios_str[count];
>> +			count++;
>> +		}
>> +
>> +		ctx->vbios_pn[count] =3D 0;
>> +	}
>> +}
>> +
>> struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bio=
s)
>> {
>> 	int base;
>> 	struct atom_context *ctx =3D
>> 	    kzalloc(sizeof(struct atom_context), GFP_KERNEL);
>> 	char *str;
>> +	struct _ATOM_ROM_HEADER *atom_rom_header;
>> +	struct _ATOM_MASTER_DATA_TABLE *master_table;
>> +	struct _ATOM_FIRMWARE_INFO *atom_fw_info;
>> 	u16 idx;
>>=20
>> 	if (!ctx)
>> @@ -1353,6 +1495,22 @@ struct atom_context *amdgpu_atom_parse(struct car=
d_info *card, void *bios)
>> 		strlcpy(ctx->vbios_version, str, sizeof(ctx->vbios_version));
>> 	}
>>=20
>> +	atom_rom_header =3D (struct _ATOM_ROM_HEADER *)CSTR(base);
>> +	ctx->sub_dev_id =3D atom_rom_header->usSubsystemVendorID;
>> +	ctx->sub_ved_id =3D atom_rom_header->usSubsystemID;
>> +	if (atom_rom_header->usMasterDataTableOffset !=3D 0) {
>> +		master_table =3D (struct _ATOM_MASTER_DATA_TABLE *)
>> +				CSTR(atom_rom_header->usMasterDataTableOffset);
>> +		if (master_table->ListOfDataTables.FirmwareInfo !=3D 0) {
>> +			atom_fw_info =3D (struct _ATOM_FIRMWARE_INFO *)
>> +					CSTR(master_table->ListOfDataTables.FirmwareInfo);
>> +			ctx->version =3D atom_fw_info->ulFirmwareRevision;
>> +		}
>> +	}
>> +
>> +	atom_get_vbios_name(ctx);
>> +	atom_get_vbios_pn(ctx);
>> +	atom_get_vbios_date(ctx);
>>=20
>> 	return ctx;
>> }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amd=
gpu/atom.h
>> index d279759cab47..c729f7ceba4f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/atom.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/atom.h
>> @@ -112,6 +112,10 @@ struct drm_device;
>> #define ATOM_IO_SYSIO		2
>> #define ATOM_IO_IIO		0x80
>>=20
>> +#define STRLEN_NORMAL		32
>> +#define STRLEN_LONG		64
>> +#define STRLEN_VERYLONG		254
>> +
>> struct card_info {
>> 	struct drm_device *dev;
>> 	void (* reg_write)(struct card_info *, uint32_t, uint32_t);   /*  fille=
d by driver */
>> @@ -140,6 +144,13 @@ struct atom_context {
>> 	uint32_t *scratch;
>> 	int scratch_size_bytes;
>> 	char vbios_version[20];
>> +
>> +	uint8_t name[STRLEN_LONG];
>> +	uint8_t vbios_pn[STRLEN_LONG];
>> +	uint32_t version;
>> +	uint8_t date[STRLEN_NORMAL];
>> +	uint32_t sub_dev_id;
>> +	uint32_t sub_ved_id;
>> };
>>=20
>> extern int amdgpu_atom_debug;
>> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/dr=
m/amd/include/atomfirmware.h
>> index c77ed38c20fb..3a8e404099b0 100644
>> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
>> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
>> @@ -197,6 +197,8 @@ enum atom_dp_vs_preemph_def{
>>  DP_VS_LEVEL0_PREEMPH_LEVEL3 =3D 0x18,
>> };
>>=20
>> +#define BIOS_ATOM_PREFIX   "ATOMBIOS"
>> +#define BIOS_STRING_LENGTH 43
>>=20
>> /*
>> enum atom_string_def{
>> @@ -209,12 +211,14 @@ atom_bios_string          =3D "ATOM"
>> #pragma pack(1)                          /* BIOS data must use byte alig=
ment*/
>>=20
>> enum atombios_image_offset{
>> -OFFSET_TO_ATOM_ROM_HEADER_POINTER          =3D0x00000048,
>> -OFFSET_TO_ATOM_ROM_IMAGE_SIZE              =3D0x00000002,
>> -OFFSET_TO_ATOMBIOS_ASIC_BUS_MEM_TYPE       =3D0x94,
>> -MAXSIZE_OF_ATOMBIOS_ASIC_BUS_MEM_TYPE      =3D20,  /*including the term=
inator 0x0!*/
>> -OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS   =3D0x2f,
>> -OFFSET_TO_GET_ATOMBIOS_STRING_START        =3D0x6e,
>> +  OFFSET_TO_ATOM_ROM_HEADER_POINTER          =3D 0x00000048,
>> +  OFFSET_TO_ATOM_ROM_IMAGE_SIZE              =3D 0x00000002,
>> +  OFFSET_TO_ATOMBIOS_ASIC_BUS_MEM_TYPE       =3D 0x94,
>> +  MAXSIZE_OF_ATOMBIOS_ASIC_BUS_MEM_TYPE      =3D 20,  /*including the t=
erminator 0x0!*/
>> +  OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS   =3D 0x2f,
>> +  OFFSET_TO_GET_ATOMBIOS_STRING_START        =3D 0x6e,
>> +  OFFSET_TO_VBIOS_PART_NUMBER                =3D 0x80,
>> +  OFFSET_TO_VBIOS_DATE                       =3D 0x50,
>> };
>>=20
>> /***********************************************************************=
*****  =20
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm=
.h
>> index 8b832f7458f2..77980445d486 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -758,6 +758,8 @@ struct drm_amdgpu_cs_chunk_data {
>> 	#define AMDGPU_INFO_VBIOS_SIZE		0x1
>> 	/* Subquery id: Query vbios image */
>> 	#define AMDGPU_INFO_VBIOS_IMAGE		0x2
>> +	/* Subquery id: Query vbios info */
>> +	#define AMDGPU_INFO_VBIOS_INFO		0x3
>> /* Query UVD handles */
>> #define AMDGPU_INFO_NUM_HANDLES			0x1C
>> /* Query sensor related information */
>> @@ -951,6 +953,19 @@ struct drm_amdgpu_info_firmware {
>> 	__u32 feature;
>> };
>>=20
>> +struct drm_amdgpu_info_vbios {
>> +	__u8 name[64];
>> +	__u32 dbdf;
>> +	__u8 vbios_pn[64];
>> +	__u32 version;
>> +	__u8 date[32];
>> +	__u8 serial[16];
>> +	__u32 dev_id;
>> +	__u32 rev_id;
>> +	__u32 sub_dev_id;
>> +	__u32 sub_ved_id;
>> +};
>> +
>> #define AMDGPU_VRAM_TYPE_UNKNOWN 0
>> #define AMDGPU_VRAM_TYPE_GDDR1 1
>> #define AMDGPU_VRAM_TYPE_DDR2  2
>> --=20
>> 2.17.1
>>=20
>=20


--_002_F593F9B0C6CB4245BC820B63F65DF33Famdcom_
Content-Type: application/octet-stream;
	name="[v2][umr]add-vbios-info-query.patch"
Content-Description: [v2][umr]add-vbios-info-query.patch
Content-Disposition: attachment;
	filename="[v2][umr]add-vbios-info-query.patch"; size=6968;
	creation-date="Thu, 22 Apr 2021 13:18:16 GMT";
	modification-date="Thu, 22 Apr 2021 13:18:16 GMT"
Content-ID: <CC8D4F2592154E4A997954598A80C22E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSBjYTVmOWMyMTg2OTMxN2FjOGM4ZGY3NTJiOGM4ZTE3ZDE1ZWJiODAzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKaWF3ZWkgR3UgPEppYXdlaS5HdUBhbWQuY29tPgpEYXRlOiBU
dWUsIDIwIEFwciAyMDIxIDE2OjM5OjQyICswODAwClN1YmplY3Q6IFtQQVRDSF0gYWRkIHZiaW9z
IGluZm8gcXVlcnkKClNpZ25lZC1vZmYtYnk6IEppYXdlaSBHdSA8Smlhd2VpLkd1QGFtZC5jb20+
Ci0tLQogc3JjL2FwcC9DTWFrZUxpc3RzLnR4dCAgICAgICAgICAgICB8ICAxICsKIHNyYy9hcHAv
bWFpbi5jICAgICAgICAgICAgICAgICAgICAgfCAgOCArKysrKwogc3JjL2FwcC92Ymlvcy5jICAg
ICAgICAgICAgICAgICAgICB8IDU4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogc3Jj
L2xpYi9sb3dsZXZlbC9saW51eC9xdWVyeV9kcm0uYyB8IDExICsrKysrKwogc3JjL3Vtci5oICAg
ICAgICAgICAgICAgICAgICAgICAgICB8IDE1ICsrKysrKysrCiBzcmMvdW1yYXBwLmggICAgICAg
ICAgICAgICAgICAgICAgIHwgIDEgKwogNiBmaWxlcyBjaGFuZ2VkLCA5NCBpbnNlcnRpb25zKCsp
CiBjcmVhdGUgbW9kZSAxMDA2NDQgc3JjL2FwcC92Ymlvcy5jCgpkaWZmIC0tZ2l0IGEvc3JjL2Fw
cC9DTWFrZUxpc3RzLnR4dCBiL3NyYy9hcHAvQ01ha2VMaXN0cy50eHQKaW5kZXggY2E3ZDQ2Yi4u
NDYyZTRmYyAxMDA2NDQKLS0tIGEvc3JjL2FwcC9DTWFrZUxpc3RzLnR4dAorKysgYi9zcmMvYXBw
L0NNYWtlTGlzdHMudHh0CkBAIC0zNSw2ICszNSw3IEBAIGFkZF9saWJyYXJ5KHVtcmFwcCBTVEFU
SUMKICAgcHBfdGFibGUuYwogICBuYXZpMTBfcHB0LmMKICAgcmVhZF9tZXRyaWNzLmMKKyAgdmJp
b3MuYwogICAke0dVSV9TT1VSQ0V9CiApCiAKZGlmZiAtLWdpdCBhL3NyYy9hcHAvbWFpbi5jIGIv
c3JjL2FwcC9tYWluLmMKaW5kZXggNTY5MmY2YS4uODZjNGQ2NyAxMDA2NDQKLS0tIGEvc3JjL2Fw
cC9tYWluLmMKKysrIGIvc3JjL2FwcC9tYWluLmMKQEAgLTgyNSw2ICs4MjUsMTEgQEAgaW50IG1h
aW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogCQkJCWFzaWMgPSBnZXRfYXNpYygpOwogCQkJaWhf
c2VsZl90ZXN0KGFzaWMpOwogI2VuZGlmCisJCX0gZWxzZSBpZiAoIXN0cmNtcChhcmd2W2ldLCAi
LS12Ymlvc19pbmZvIikgfHwgIXN0cmNtcChhcmd2W2ldLCAiLXZpIikpIHsKKwkJCWlmICghYXNp
YykKKwkJCQlhc2ljID0gZ2V0X2FzaWMoKTsKKwkJCWlmICh1bXJfcHJpbnRfdmJpb3NfaW5mbyhh
c2ljKSAhPSAwKQorCQkJCWZwcmludGYoc3RkZXJyLCAiW0VSUk9SXTogQ2Fubm90IHByaW50IHZi
aW9zIGluZm8uXG4iKTsKIAkJfSBlbHNlIGlmICghc3RyY21wKGFyZ3ZbaV0sICItLWhlbHAiKSB8
fCAhc3RyY21wKGFyZ3ZbaV0sICItaCIpKSB7CiAJCQlwcmludGYoIlVzZXIgTW9kZSBSZWdpc3Rl
ciBkZWJ1Z2dlciB2JXMgZm9yIEFNREdQVSBkZXZpY2VzIChidWlsZDogJXMgWyVzXSksIENvcHly
aWdodCAoYykgMjAyMSwgQU1EIEluYy5cbiIKICJcbioqKiBEZXZpY2UgU2VsZWN0aW9uICoqKlxu
IgpAQCAtOTUxLDYgKzk1Niw5IEBAIHByaW50ZigKIAkiXG5cdFx0UHJpbnQgdGhlIEdQVSBtZXRy
aWNzIHRhYmxlIGZvciB0aGUgZGV2aWNlLiIKICJcblx0LS1wb3dlciwgLXAgXG5cdFx0UmVhZCB0
aGUgY29uZXRlbnQgb2YgY2xvY2tzLCB0ZW1wZXJhdHVyZSwgZ3B1IGxvYWRpbmcgYXQgcnVudGlt
ZSIKIAkiXG5cdFx0b3B0aW9ucyAndXNlX2NvbG91cicgdG8gY29sb3VyaXplIG91dHB1dCBcbiIp
OworcHJpbnRmKAorIlxuKioqIFZpZGVvIEJJT1MgSW5mb3JtYXRpb24gKioqXG4iCisiXG5cdC0t
dmJpb3NfaW5mbywgLXZpIFxuXHRcdFByaW50IFZpZGVvIEJJT1MgaW5mb3JtYXRpb25cbiIpOwog
CiAjaWYgVU1SX0dVSQogcHJpbnRmKApkaWZmIC0tZ2l0IGEvc3JjL2FwcC92Ymlvcy5jIGIvc3Jj
L2FwcC92Ymlvcy5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLmIyZTY1ZTQK
LS0tIC9kZXYvbnVsbAorKysgYi9zcmMvYXBwL3ZiaW9zLmMKQEAgLTAsMCArMSw1OCBAQAorLyoK
KyAqIENvcHlyaWdodCAyMDIxIEFkdmFuY2VkIE1pY3JvIERldmljZXMsIEluYy4KKyAqCisgKiBQ
ZXJtaXNzaW9uIGlzIGhlcmVieSBncmFudGVkLCBmcmVlIG9mIGNoYXJnZSwgdG8gYW55IHBlcnNv
biBvYnRhaW5pbmcgYQorICogY29weSBvZiB0aGlzIHNvZnR3YXJlIGFuZCBhc3NvY2lhdGVkIGRv
Y3VtZW50YXRpb24gZmlsZXMgKHRoZSAiU29mdHdhcmUiKSwKKyAqIHRvIGRlYWwgaW4gdGhlIFNv
ZnR3YXJlIHdpdGhvdXQgcmVzdHJpY3Rpb24sIGluY2x1ZGluZyB3aXRob3V0IGxpbWl0YXRpb24K
KyAqIHRoZSByaWdodHMgdG8gdXNlLCBjb3B5LCBtb2RpZnksIG1lcmdlLCBwdWJsaXNoLCBkaXN0
cmlidXRlLCBzdWJsaWNlbnNlLAorICogYW5kL29yIHNlbGwgY29waWVzIG9mIHRoZSBTb2Z0d2Fy
ZSwgYW5kIHRvIHBlcm1pdCBwZXJzb25zIHRvIHdob20gdGhlCisgKiBTb2Z0d2FyZSBpcyBmdXJu
aXNoZWQgdG8gZG8gc28sIHN1YmplY3QgdG8gdGhlIGZvbGxvd2luZyBjb25kaXRpb25zOgorICoK
KyAqIFRoZSBhYm92ZSBjb3B5cmlnaHQgbm90aWNlIGFuZCB0aGlzIHBlcm1pc3Npb24gbm90aWNl
IHNoYWxsIGJlIGluY2x1ZGVkIGluCisgKiBhbGwgY29waWVzIG9yIHN1YnN0YW50aWFsIHBvcnRp
b25zIG9mIHRoZSBTb2Z0d2FyZS4KKyAqCisgKiBUSEUgU09GVFdBUkUgSVMgUFJPVklERUQgIkFT
IElTIiwgV0lUSE9VVCBXQVJSQU5UWSBPRiBBTlkgS0lORCwgRVhQUkVTUyBPUgorICogSU1QTElF
RCwgSU5DTFVESU5HIEJVVCBOT1QgTElNSVRFRCBUTyBUSEUgV0FSUkFOVElFUyBPRiBNRVJDSEFO
VEFCSUxJVFksCisgKiBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRSBBTkQgTk9OSU5G
UklOR0VNRU5ULiAgSU4gTk8gRVZFTlQgU0hBTEwKKyAqIFRIRSBDT1BZUklHSFQgSE9MREVSKFMp
IE9SIEFVVEhPUihTKSBCRSBMSUFCTEUgRk9SIEFOWSBDTEFJTSwgREFNQUdFUyBPUgorICogT1RI
RVIgTElBQklMSVRZLCBXSEVUSEVSIElOIEFOIEFDVElPTiBPRiBDT05UUkFDVCwgVE9SVCBPUiBP
VEhFUldJU0UsCisgKiBBUklTSU5HIEZST00sIE9VVCBPRiBPUiBJTiBDT05ORUNUSU9OIFdJVEgg
VEhFIFNPRlRXQVJFIE9SIFRIRSBVU0UgT1IKKyAqIE9USEVSIERFQUxJTkdTIElOIFRIRSBTT0ZU
V0FSRS4KKyAqCisgKiBBdXRob3JzOiBUb20gU3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+
CisgKgorICovCisjaW5jbHVkZSAidW1yYXBwLmgiCisKKyNkZWZpbmUgQU1ER1BVX0lORk9fVkJJ
T1MJCQkweDFCCisjZGVmaW5lIEFNREdQVV9JTkZPX1ZCSU9TX0lORk8JCQkweDMKK2ludCB1bXJf
cHJpbnRfdmJpb3NfaW5mbyhzdHJ1Y3QgdW1yX2FzaWMgKmFzaWMpCit7CisJY2hhciBmbmFtZVs2
NF07CisJaW50IHI7CisJc3RydWN0IHVtcl92Ymlvc19pbmZvIHZiaW9zX2luZm87CisKKwlpZiAo
YXNpYy0+ZmQuZHJtIDwgMCkgeworCQlzbnByaW50ZihmbmFtZSwgc2l6ZW9mKGZuYW1lKS0xLCAi
L2Rldi9kcmkvY2FyZCVkIiwgYXNpYy0+aW5zdGFuY2UpOworCQlhc2ljLT5mZC5kcm0gPSBvcGVu
KGZuYW1lLCBPX1JEV1IpOworCX0KKworCXIgPSB1bXJfcXVlcnlfZHJtX3ZiaW9zKGFzaWMsIEFN
REdQVV9JTkZPX1ZCSU9TLCBBTURHUFVfSU5GT19WQklPU19JTkZPLAorCQkJJnZiaW9zX2luZm8s
IHNpemVvZih2Ymlvc19pbmZvKSk7CisJaWYgKHIpCisJCXJldHVybiByOworCisJcHJpbnRmKCJ2
YmlvcyBuYW1lICAgICAgICAgIDogJXNcbiIsIHZiaW9zX2luZm8ubmFtZSk7CisJcHJpbnRmKCJ2
YmlvcyBkYmRmICAgICAgICAgIDogMHgleFxuIiwgdmJpb3NfaW5mby5kYmRmKTsKKwlwcmludGYo
InZiaW9zIHBuICAgICAgICAgICAgOiAlc1xuIiwgdmJpb3NfaW5mby52Ymlvc19wbik7CisJcHJp
bnRmKCJ2YmlvcyB2ZXJzaW9uICAgICAgIDogJWRcbiIsIHZiaW9zX2luZm8udmVyc2lvbik7CisJ
cHJpbnRmKCJ2YmlvcyBkYXRlICAgICAgICAgIDogJXNcbiIsIHZiaW9zX2luZm8uZGF0ZSk7CisJ
cHJpbnRmKCJ2YmlvcyBzZXJpYWwgICAgICAgIDogJXNcbiIsIHZiaW9zX2luZm8uc2VyaWFsKTsK
KwlwcmludGYoInZiaW9zIGRldl9pZCAgICAgICAgOiAweCV4XG4iLCB2Ymlvc19pbmZvLmRldl9p
ZCk7CisJcHJpbnRmKCJ2YmlvcyByZXZfaWQgICAgICAgIDogMHgleFxuIiwgdmJpb3NfaW5mby5y
ZXZfaWQpOworCXByaW50ZigidmJpb3Mgc3ViX2Rldl9pZCAgICA6IDB4JXhcbiIsIHZiaW9zX2lu
Zm8uc3ViX2Rldl9pZCk7CisJcHJpbnRmKCJ2YmlvcyBzdWJfdmVkX2lkICAgIDogMHgleFxuIiwg
dmJpb3NfaW5mby5zdWJfdmVkX2lkKTsKKworCWNsb3NlKGFzaWMtPmZkLmRybSk7CisJcmV0dXJu
IDA7Cit9ClwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQpkaWZmIC0tZ2l0IGEvc3JjL2xpYi9s
b3dsZXZlbC9saW51eC9xdWVyeV9kcm0uYyBiL3NyYy9saWIvbG93bGV2ZWwvbGludXgvcXVlcnlf
ZHJtLmMKaW5kZXggZDBjODJkNC4uZjRhYjcwOSAxMDA2NDQKLS0tIGEvc3JjL2xpYi9sb3dsZXZl
bC9saW51eC9xdWVyeV9kcm0uYworKysgYi9zcmMvbGliL2xvd2xldmVsL2xpbnV4L3F1ZXJ5X2Ry
bS5jCkBAIC00OSw3ICs0OSwxOCBAQCBpbnQgdW1yX3F1ZXJ5X2RybShzdHJ1Y3QgdW1yX2FzaWMg
KmFzaWMsIGludCBmaWVsZCwgdm9pZCAqcmV0LCBpbnQgc2l6ZSkKIAlpbmYucmV0dXJuX3NpemUg
PSBzaXplOwogCWluZi5xdWVyeSA9IGZpZWxkOwogCXJldHVybiBpb2N0bChhc2ljLT5mZC5kcm0s
IERSTV9JT0MoRFJNX0lPQ19XUklURSwgRFJNX0lPQ1RMX0JBU0UsIERSTV9DT01NQU5EX0JBU0Ug
KyBEUk1fQU1ER1BVX0lORk8sIHNpemVvZihpbmYpKSwgJmluZik7Cit9CiAKK2ludCB1bXJfcXVl
cnlfZHJtX3ZiaW9zKHN0cnVjdCB1bXJfYXNpYyAqYXNpYywgaW50IGZpZWxkLCBpbnQgdHlwZSwg
dm9pZCAqcmV0LCBpbnQgc2l6ZSkKK3sKKwlzdHJ1Y3QgZHJtX2FtZGdwdV9pbmZvIGluZjsKKwor
CW1lbXNldCgmaW5mLCAwLCBzaXplb2YgaW5mKTsKKwlpbmYucmV0dXJuX3BvaW50ZXIgPSAodWlu
dHB0cl90KXJldDsKKwlpbmYucmV0dXJuX3NpemUgPSBzaXplOworCWluZi5xdWVyeSA9IGZpZWxk
OworCWluZi52Ymlvc19pbmZvLnR5cGUgPSB0eXBlOworCXJldHVybiBpb2N0bChhc2ljLT5mZC5k
cm0sIERSTV9JT0MoRFJNX0lPQ19XUklURSwgRFJNX0lPQ1RMX0JBU0UsIERSTV9DT01NQU5EX0JB
U0UgKyBEUk1fQU1ER1BVX0lORk8sIHNpemVvZihpbmYpKSwgJmluZik7CiB9CiAKICNlbHNlCmRp
ZmYgLS1naXQgYS9zcmMvdW1yLmggYi9zcmMvdW1yLmgKaW5kZXggMDI2ZjQ2Ni4uNjI1ZjkzZSAx
MDA2NDQKLS0tIGEvc3JjL3Vtci5oCisrKyBiL3NyYy91bXIuaApAQCAtOTczLDYgKzk3Myw3IEBA
IHZvaWQgdW1yX2ZyZWVfYXNpYyhzdHJ1Y3QgdW1yX2FzaWMgKmFzaWMpOwogdm9pZCB1bXJfZnJl
ZV9tYXBzKHN0cnVjdCB1bXJfYXNpYyAqYXNpYyk7CiB2b2lkIHVtcl9jbG9zZV9hc2ljKHN0cnVj
dCB1bXJfYXNpYyAqYXNpYyk7IC8vIGNhbGwgdGhpcyB0byBjbG9zZSBhIGZ1bGx5IG9wZW4gYXNp
YwogaW50IHVtcl9xdWVyeV9kcm0oc3RydWN0IHVtcl9hc2ljICphc2ljLCBpbnQgZmllbGQsIHZv
aWQgKnJldCwgaW50IHNpemUpOworaW50IHVtcl9xdWVyeV9kcm1fdmJpb3Moc3RydWN0IHVtcl9h
c2ljICphc2ljLCBpbnQgZmllbGQsIGludCB0eXBlLCB2b2lkICpyZXQsIGludCBzaXplKTsKIHZv
aWQgdW1yX2VudW1lcmF0ZV9kZXZpY2VzKHZvaWQpOwogaW50IHVtcl91cGRhdGUoc3RydWN0IHVt
cl9hc2ljICphc2ljLCBjaGFyICpzY3JpcHQpOwogaW50IHVtcl91cGRhdGVfc3RyaW5nKHN0cnVj
dCB1bXJfYXNpYyAqYXNpYywgY2hhciAqc2RhdGEpOwpAQCAtMTMzNyw2ICsxMzM4LDIwIEBAIHN0
cnVjdCB1bXJfc29jMTVfZGF0YWJhc2UgewogCXN0cnVjdCB1bXJfc29jMTVfZGF0YWJhc2UgKm5l
eHQ7CiB9OwogCisvLyB2Ymlvcworc3RydWN0IHVtcl92Ymlvc19pbmZvIHsKKwl1aW50OF90IG5h
bWVbNjRdOworCXVpbnQzMl90IGRiZGY7CisJdWludDhfdCB2Ymlvc19wbls2NF07CisJdWludDMy
X3QgdmVyc2lvbjsKKwl1aW50OF90IGRhdGVbMzJdOworCXVpbnQ4X3Qgc2VyaWFsWzE2XTsKKwl1
aW50MzJfdCBkZXZfaWQ7CisJdWludDMyX3QgcmV2X2lkOworCXVpbnQzMl90IHN1Yl9kZXZfaWQ7
CisJdWludDMyX3Qgc3ViX3ZlZF9pZDsKK307CisKIEZJTEUgKnVtcl9kYXRhYmFzZV9vcGVuKGNo
YXIgKnBhdGgsIGNoYXIgKmZpbGVuYW1lKTsKIHN0cnVjdCB1bXJfc29jMTVfZGF0YWJhc2UgKnVt
cl9kYXRhYmFzZV9yZWFkX3NvYzE1KGNoYXIgKnBhdGgsIGNoYXIgKmZpbGVuYW1lKTsKIHZvaWQg
dW1yX2RhdGFiYXNlX2ZyZWVfc29jMTUoc3RydWN0IHVtcl9zb2MxNV9kYXRhYmFzZSAqc29jMTUp
OwpkaWZmIC0tZ2l0IGEvc3JjL3VtcmFwcC5oIGIvc3JjL3VtcmFwcC5oCmluZGV4IDE0NDU3ZmUu
LjEzMzZlMDcgMTAwNjQ0Ci0tLSBhL3NyYy91bXJhcHAuaAorKysgYi9zcmMvdW1yYXBwLmgKQEAg
LTU3LDUgKzU3LDYgQEAgdm9pZCB1bXJfY2xvY2tfc2NhbihzdHJ1Y3QgdW1yX2FzaWMgKmFzaWMs
IGNvbnN0IGNoYXIqIGNsb2NrX25hbWUpOwogdm9pZCB1bXJfY2xvY2tfbWFudWFsKHN0cnVjdCB1
bXJfYXNpYyAqYXNpYywgY29uc3QgY2hhciogY2xvY2tfbmFtZSwgdm9pZCogdmFsdWUpOwogaW50
IHVtcl9wcmludF9wcF90YWJsZShzdHJ1Y3QgdW1yX2FzaWMgKmFzaWMsIGNvbnN0IGNoYXIqIHBh
cmFtKTsKIGludCB1bXJfcHJpbnRfZ3B1X21ldHJpY3Moc3RydWN0IHVtcl9hc2ljICphc2ljKTsK
K2ludCB1bXJfcHJpbnRfdmJpb3NfaW5mbyhzdHJ1Y3QgdW1yX2FzaWMgKmFzaWMpOwogCiB2b2lk
IHJ1bl9zZXJ2ZXJfbG9vcChjb25zdCBjaGFyICp1cmwsIHN0cnVjdCB1bXJfYXNpYyAqIGFzaWMp
OwotLSAKMi4xNy4xCgo=

--_002_F593F9B0C6CB4245BC820B63F65DF33Famdcom_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_002_F593F9B0C6CB4245BC820B63F65DF33Famdcom_--

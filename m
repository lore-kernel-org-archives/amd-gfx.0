Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D86CE9D7B
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 16:48:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 725B310E519;
	Tue,  6 Jan 2026 16:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h6+kgeNv";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011039.outbound.protection.outlook.com
 [40.93.194.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D54B10E519
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 16:48:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnk2Wp43dr3L+VbtTf0WokuJrIEJXMft6cmapS9TYlngBOnX9FIYimbBFCHqofD3kaOWsXUD/wmoXyXqMNL+Iq8cfHfidNS5xvSxoFOL1Fqg7Q60pqnp5W128fsebyUOVH0jCoEfS/2cKA2+djZQgbXyh9lKDCcVkXpHXB8E7QZc2bIGM9fELOWF+jhBpZk2H/XeBLQgW5CuDVNr8bNoUtqvDLe7n1gkCoPr4jfPiEe3fchxsG/r5TANkZE6ZWbdWcyy/9J+TJwUEPQjJzamCeHXYipyUfmPb2A+e9/EShPOTSl7v14yUOGVEbVrQnrZBnqJ6cicr7u2OyGVKF0eMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHrHZ6T/ISb9TJIbHbJC0b90X01zMlABQer/HiKUNvU=;
 b=EfFXUVLPWuBYU8W5E3fL7Qxzk+g0pKXjTj12IQWb+CXNzEe6UwMgV/WRok/U/VZNNDi8KgXqZ3vKtwOWIw3j+HySEZbnzp2mG4GXp8LnEbiOhaSyRjGSstdoyvjKO3D0UhJaYsSpiZ17/MxejWjA2lOWiIGEN2QGJEPEOARpqqSWaLPB4JiJ88CmvmUcJUzyt8JfDU5Ob3vd2rdijxrsVEzYA8vhYNGrYl6CQmi4j0ieZlPCLmRvZFWgPeb4kd4El/7f5kH5iRghwii1iKsFlrJsDA6tyckERtx108e+6cjNNtMz5JGTvp6ShiiCs/jiT/G/NFxkBEsq+U4iTzqlnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHrHZ6T/ISb9TJIbHbJC0b90X01zMlABQer/HiKUNvU=;
 b=h6+kgeNvK6jigcOBDJLq0RQ/JLA7hoP1+64CWZigO7G20dhMF8wCFlqlvc8oDMxIeyNWtbGdHn5jA3NPBn6NGmp2iCVhMiQKmwZPJsCSMHcvn5iCXf+FNdbOwHyGwFrDYW6eZx3EJYKgpA4PlNv2bHlX12wPOQOWXKKQ/A9mYbQ=
Received: from MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10)
 by LV0PR12MB999067.namprd12.prod.outlook.com (2603:10b6:408:32d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 16:48:10 +0000
Received: from MW4PR12MB7168.namprd12.prod.outlook.com
 ([fe80::a7af:b209:66ff:7833]) by MW4PR12MB7168.namprd12.prod.outlook.com
 ([fe80::a7af:b209:66ff:7833%5]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 16:48:10 +0000
From: "Wan, Gavin" <Gavin.Wan@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wang,
 YuBiao" <YuBiao.Wang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Skip loading SDMA_RS64 in VF
Thread-Topic: [PATCH] drm/amdgpu: Skip loading SDMA_RS64 in VF
Thread-Index: AQHceNAxEVynpLtVfk6bbDwHiLcihLVFZhBw
Date: Tue, 6 Jan 2026 16:48:09 +0000
Message-ID: <MW4PR12MB716811EC38CCB88F32793EA9FC87A@MW4PR12MB7168.namprd12.prod.outlook.com>
References: <20251229143341.276909-1-victor.skvortsov@amd.com>
In-Reply-To: <20251229143341.276909-1-victor.skvortsov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-06T16:45:20.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB7168:EE_|LV0PR12MB999067:EE_
x-ms-office365-filtering-correlation-id: 06aeb9c3-e1d3-4856-2e40-08de4d435fee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?xfdbor7iUD7VGX2ukb9naWuEHBtnnMwjlwtlk1tVOVMkh/fv8EhiWWVqzCbq?=
 =?us-ascii?Q?UKxU7TzmhMnd9+dAm7kw/Kutw1BdQUdEwXm1jtMAPLGv3dIR4KhlbZo+/LEq?=
 =?us-ascii?Q?ObDB2HbRn9FvgDUp1t8XZWUNKblDopYFmOakzRqQtJb1pMNWqSSxVpA/O4Ns?=
 =?us-ascii?Q?UEvLI/+yXNkgvTX1wfrZUEaiwaWjW4QTeOsFa+h5GK6WQ93Ad6KExXClcx3+?=
 =?us-ascii?Q?TbjJ6eJ6Mf2S3JCyaoa5v5H3g+TPyHh2e8ZumYZm3C6VzypaX/SuNlS3Iy2S?=
 =?us-ascii?Q?mCjzjZJdJ/cumUr8j31p8bgvOsaqUFVZD0DdVMUns1c3rv1tq6LmjYqhTXN0?=
 =?us-ascii?Q?mAhHE3OhEckEjCruiyWhlN/HWEoa8c99yLY2C7WcdNe4JylaPW8WB0PC/lQH?=
 =?us-ascii?Q?Ugnsvf1/ZhaVVFIaR38Eg68YI2cIJZMRdcOx36+jSggbv56SBV9wbCuoRoT3?=
 =?us-ascii?Q?V0zTNMkAdcp4itNtjS2eYbKhznSmlbRuqc4PmHU1ubJy/pTymDBaUTqRjTG5?=
 =?us-ascii?Q?jnv0hNADB+ki8G9yNCmKeIbKApBCYZbX06XwnrMwlXRs0NAPxA6nQs3dPFlP?=
 =?us-ascii?Q?Ciw9ptFpXX+tfP0O+al7k98zT8jdN0vQFfza3AuB1ijp/JO47pJqOzxHjdaI?=
 =?us-ascii?Q?ir4LRBWLxDO6/IHZ69ANcayV0sKGc5xGiyKp2T26yfT61mpy2td9UwOoE0HC?=
 =?us-ascii?Q?9c6V1ZuSqC8VbMkvqRcS0BmOZ9SVWcljE2c1DL3vnM86V/nDQNjZVZqp8O4K?=
 =?us-ascii?Q?tzJz2hFZtvxBc2nNOkporTjCRYzkIpBiLLtZBi5Zi8zAx49lTYhnGtTsL5a5?=
 =?us-ascii?Q?inoUVLs56sVph2Gv0mj8rmHdNews57GusudxezB1aSL71jRbzscmjghMvPea?=
 =?us-ascii?Q?ida7tm6DHP/ZTOSave+B4uy4LnR/fdVkfLkKY73fzCkankmp2j/lNCRD/S5F?=
 =?us-ascii?Q?3w5BvOelOtQrfFHpeMAsZolFu/yqLwK5fwnil0rhKs0qahb3Z4A5KqGK+IAO?=
 =?us-ascii?Q?MwF1L7kKXP8tzfg3OH0D6b82UJiKzj8I4OPOXvl4VCEoKZYNaJkPfRoMmYPg?=
 =?us-ascii?Q?cWD+n8nm3ofeUNVopPu3rqoQsPr1hAg2yMIBJRrJhOhKEGRMt/OxiJdMUOt3?=
 =?us-ascii?Q?ZsAZuBKmg+InKRAdZoLmqqAEXIU5pUUn8qSbqRrw0O1JcV3qDVt8n6qFc1x8?=
 =?us-ascii?Q?bK/X5BCbQUGr7WQNeGA5f4D4LalVUVluMUg6MSZavCnZrd8ollKoDfuJbNT5?=
 =?us-ascii?Q?yIlSdkxjLWaaKY5FnUmB7SAYVrd3ly/LgUvDcZ0h4KigOFej3HVn9OA90q9v?=
 =?us-ascii?Q?s0W4+Y5F5Xqk8Wm4AAE8vt9JiIb+78hZWvuXUKDCLKo9eodAnPgPTQCqHjvR?=
 =?us-ascii?Q?/EcxPWaX87EmXdyHURGmED/plJ4i1G1uCKD+sD9XtrbmeI2rwDTKlsO4a3aA?=
 =?us-ascii?Q?+xZ/eL8m9LVpxHxtZr/LnD1vdq9lpN3DfE7oQ1FatJICmQA0WRNMPU2l80yo?=
 =?us-ascii?Q?jZNt/0BPKZ7PLxdgcgfiWd7avRmNXGyEAusU?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB7168.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mhdudSjkksJvBqCjxDH0giFY+0FwRxjU2sDLvuwZ1K9EOzTQ2iy6pxUT3cLw?=
 =?us-ascii?Q?ccwhhYFrjrSeJjDqNLkNi6qUaK0xwVvYF5U5+mVyGfCdulhevWx7VQMHB9zu?=
 =?us-ascii?Q?3ajvyoS5o+STD2AYz5gMEm7YnmO5+JuI/HuF5h5eGDRhtS+DOpgsCqLwF6rP?=
 =?us-ascii?Q?8/+1VtOqMCQfAEEwz8wY/JcuH1Oxb8cIl7T7ihjASolEHB9wlxEpU34wrf6M?=
 =?us-ascii?Q?mG8S34rV2KmfPX2+UaMTxFBJUu8IwF272hMPmOUVxP2sRTT5fqtkoO+3bM2u?=
 =?us-ascii?Q?vjynvjdDXZc3cVswfhwzwBqW3YHAqNQeoOzmpNdTCi93VUeAlFCg385eVxKX?=
 =?us-ascii?Q?mPS8OKSPNnAmSuW9MA+FUL1HtsBI7YaZUt57IH3tA4oZm4Gbrj7y58a0lr6q?=
 =?us-ascii?Q?hBmosWPCkQXru0DQjAV/+AZTykUqPdkEt3gvIcLJrbf7HmPdokAYtMigxEJ/?=
 =?us-ascii?Q?LYmCimolRfcU3iXgruqwMBZLlvV900fNyfmgZYvhOG0aPJws3HV1p+kFMNNS?=
 =?us-ascii?Q?BgNTIee4OE83JhLB3rlzopwSgo9PqJC++wQT/KRe151LXzICnP2CWvH+QFeI?=
 =?us-ascii?Q?GpdadaR6xlG7jRh7C3HU5Gs+hDklxEOE892yBMqXG/uqmTfBz2N2viV3dSmB?=
 =?us-ascii?Q?8V1DcAPqSxDxDGp4PDkbLl2wYmllyh2NWpq9eMfFNInal0BcK7w6LgCUoMyj?=
 =?us-ascii?Q?B6mbkzW2L0zJJ8qxuhFwoMp63QN3sxlh4140p78c3ChWxBnaF3+22j8aibAC?=
 =?us-ascii?Q?k4gTvLwlMyQLf0F/tIflFgYBWcI1DzYSgxZATb+0QTJiDw13zs466cPJoWDK?=
 =?us-ascii?Q?M4LtAiIPkXeFu/PtZ1j+VG7a2kDyYdehMpOfIS+DlJp0jWoQ+kS7915PWXex?=
 =?us-ascii?Q?xebsTX44690XxPOFqvgw+W73mzlE0RCMaMtD2O7QKAURN8aX1FHa6L2+vo27?=
 =?us-ascii?Q?dNoigxvk4oVXO1oiBIVxzarOuZVLMbm3gmC+ht2SQIgPybndvoTEhzQ7aq6H?=
 =?us-ascii?Q?sd28opLKu0h9mfjP0waBG7DudSt+pSsBD+3GbwkUI+eLkrD0Wii7fIAyzDqv?=
 =?us-ascii?Q?7q6/d3FgGhimf845wr1JbD0bciwXJv7HkucLUNN5SGefQTvD1ju/anLUi3no?=
 =?us-ascii?Q?WrQUyy0pFMQ/8SOwAjpek6yvpmJtdwj9XpapWOPacuhvakDijE36CFh+9NRV?=
 =?us-ascii?Q?lHhFUSzB7/E7cDdUGXxNtHp6yQNCQ5uVgjmdm1VvuLdvCV0jKjAgGMMnCg6U?=
 =?us-ascii?Q?nvGqbldhRMt+gxBSxharPXiM9I2nRutPLgacq0H4RnuWqGi73urlFDngsiGX?=
 =?us-ascii?Q?zi0CzOX6ExzMFmQSHj5Z6xaPQ/wwwwKkYrQ1hjcz67ecVN3f9N79RHyAqijQ?=
 =?us-ascii?Q?yd66vJFpksYIVntD7dxWZqgzmNasOGttzkdyTHTXHJixO5s6m3HTBr0zYsaq?=
 =?us-ascii?Q?UZgevxx+QSyf5m87f05TsdLalcitvXstIdg+1/TDJq6Ojku5jqUbHqFwKfY4?=
 =?us-ascii?Q?KsmrtvS0u/RfMIV8AEJUaQ686GW27WN58bWnuAY2H2kacJEQTgv7BSIhVdi9?=
 =?us-ascii?Q?f7j3aaF0E5TUXMUbbW6ImVwcMOVX1LO2R7WKmv4VOMW4XdlLg+Y7J6AkvFBp?=
 =?us-ascii?Q?+buYijI1yMQ2iTprFdL4/vmrpwURHLJYxBwXxz6DDwP3L2C478aByPYTYl1x?=
 =?us-ascii?Q?1bl+ByzVkfsLBmoa3J4XFuoRtAS7BNt4wfkXdLnpQ+akbUDr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7168.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06aeb9c3-e1d3-4856-2e40-08de4d435fee
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 16:48:10.0462 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gnv9ZFVxy/OGhvYETEXIgWwe4I5tINUVR/1q+B1k78z7rAufyrB/dB9RuGr+s9g5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999067
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

Looks Good.

Reviewed-by: Gavin Wan <gavin.wan@amd.com>

-----Original Message-----
From: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Sent: Monday, December 29, 2025 9:34 AM
To: amd-gfx@lists.freedesktop.org; Wan, Gavin <Gavin.Wan@amd.com>; Wang, Yu=
Biao <YuBiao.Wang@amd.com>
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: Skip loading SDMA_RS64 in VF

From: YuBiao Wang <YuBiao.Wang@amd.com>

VFs use the PF SDMA ucode and are unable to load SDMA_RS64.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
Signed-off-by: Victor Skvortsov <Victor.Skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index f8eac92a2b36..f01f38509108 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1262,6 +1262,7 @@ bool amdgpu_virt_fw_load_skip_check(struct amdgpu_dev=
ice *adev, uint32_t ucode_i
                    || ucode_id =3D=3D AMDGPU_UCODE_ID_SDMA5
                    || ucode_id =3D=3D AMDGPU_UCODE_ID_SDMA6
                    || ucode_id =3D=3D AMDGPU_UCODE_ID_SDMA7
+                   || ucode_id =3D=3D AMDGPU_UCODE_ID_SDMA_RS64
                    || ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_G
                    || ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNT=
L
                    || ucode_id =3D=3D AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM=
_MEM
--
2.34.1


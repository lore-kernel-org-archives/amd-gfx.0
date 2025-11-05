Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17945CCFA04
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 03:18:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 890E510E6A9;
	Wed,  5 Nov 2025 03:18:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mEyHy2am";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D85510E6A9
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 03:18:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNysYeeEjiqjABnclrfvIHMpkBEJWJ98StzMy+PCLg0IjgDquqX0UxT3Ot8RpKbucR5LDQDjSQaasGYMcVRixYu3C33gNnc6WyoHgDVhIFYFRU1veXtYrtxLoFty71uoT4sxCvEtFVFg2GLdAdxoqSq9c61j1loBlHH7wQl+itb809qX/c3bfmFvyQMLFycsKTfbdAXR0RDsKl4/zvMSABiAEGwOsUPdvL8KP/iGd6At3Hld9WDEPqEfZEsp8DoDwtAwk6O2uuxsUSo0IpT8pD1rhGUSMMv/dhZoqRHXIydwYmKDUHy2eX+n6UUuu8KkWX+js1u6gvfX+RCXLlYqxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PhgWNO350Q4dBYnARfL3A3EwVQctnrBvujgYUmKNfg=;
 b=urYtnrSX+YT0Dqx02dyJ/BnIISaONXs2QJxPbZKJAiO3Uh9itY++AXIfzLgCeTT+fTQVbFUS5PrJt4k6XiShu/n24tLCEZ5UFqdLay3RkBmZCMZUzvikjqdcohkJM8kK0/jwZhag4nIqhXqRvgOg3TOMfcXPCOQQxeBEa9Bc91ddTmCxDAaeUyWV36GYdLLO4/ZVNMEb82h5M7pDdSPMpvtdORRL+FxmCpdVVONmrn25an7JQdcp5voLZ2y7U5FL5Hbz/4m8LFDdn5WYJ2ERg/1cC5z3IId4n36OAR3JE+E9C3wwm3q348z4PV9uA5r44OXT4PsVifMS97/1iwJHSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PhgWNO350Q4dBYnARfL3A3EwVQctnrBvujgYUmKNfg=;
 b=mEyHy2amAxpyi5pOF4netUkKg+wmi5A11rvIylz2p8HBZ74QXzMJROYydZDsZxwTiVHJxRx0bZGKv9BaKmF01fzklgT7DJDG1UkfOZQiM6/EUygMshlcaOVqfAGHp4hnuqoIFQIkAzIKY1eSd/I8Ja4PpP6r2XUVaHSMon2FZV0=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by IA0PR12MB9010.namprd12.prod.outlook.com (2603:10b6:208:48e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 03:18:16 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9275.013; Wed, 5 Nov 2025
 03:18:16 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 2/8] drm/amdgpu: add ras_eeprom_read_idx interface
Thread-Topic: [PATCH 2/8] drm/amdgpu: add ras_eeprom_read_idx interface
Thread-Index: AQHcTfie6nUbVZ9qiU+748jnKp+yHLTjaIJg
Date: Wed, 5 Nov 2025 03:18:16 +0000
Message-ID: <PH7PR12MB599720B798D3B16BACF3218E82C5A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20251105020445.1423034-1-tao.zhou1@amd.com>
 <20251105020445.1423034-2-tao.zhou1@amd.com>
In-Reply-To: <20251105020445.1423034-2-tao.zhou1@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-05T03:13:58.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|IA0PR12MB9010:EE_
x-ms-office365-filtering-correlation-id: 05230ce4-72fe-4fe5-3c5e-08de1c19f61b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?gRVVi3gdYQwaHvTnbJhKixRoYS/3TGpiSRNNUQ2KWac7V83gh+ajZYCyIsha?=
 =?us-ascii?Q?QA7tSnwPcjr6U8M4AoAIfimNmovvmu4U/ZjWmcmfqazzxig9H3Q2gZcewj95?=
 =?us-ascii?Q?dt2ZFp2jInIdVE/TXNerRGJr4lia+IOi0wCBzoslv1jkdVarsFGEnhXOtXT9?=
 =?us-ascii?Q?A/Vy4IRj8ssVODpJfSspW4p2dpa+CIyx+6s1RAa6PzyGGv+lYpyK3fINDGzp?=
 =?us-ascii?Q?SkDArY/vBJV2gSSHMrF3mBd7ptg+z7D9gd1TCg6Mx0kw0yw+kSM7zy0x+kVQ?=
 =?us-ascii?Q?CkgMoVurLYbKGwJTubUMzJNEjRhRKdEcjkdv2gDvEnohQFQftMjuSO254Xr5?=
 =?us-ascii?Q?nf1TZYLvBkf60iMdLse8dGk55YmZwAvlQa7SFrOCs4RNItxJAJ7QHnib4CbX?=
 =?us-ascii?Q?IRfkcrKE7RltYjDd4Yc/BopTttoSyJeZfWAN5qQvlCFa2BhfJpfrzs3Cg/iU?=
 =?us-ascii?Q?CDWcHSlUjvlyOGJG21egkEQVYBJSKVtEhuCb0dcEK6BTX04fJq2tYzxl7Ttj?=
 =?us-ascii?Q?h9U0io20cYkIhOLx+4rHWQBPnTKoK0ePieTnqHzbzqntLQxlowU+/X7nYxLG?=
 =?us-ascii?Q?dyNpQFYn4UqtUkmvdride1AOMTIV2Y4+Rx6WofjkFTJyQSZZbCesccbO9M6i?=
 =?us-ascii?Q?MC0no0C2ICvLr+0ywg9UTFdm8GjobhM5rqiMIfcf565niKlyqaaZpdE9QTcB?=
 =?us-ascii?Q?5gJ9pgPPmcSLeB9Np9/crRt/+nDArVtgf8cVKPEsuCT+eJdfW4OH9lMF4M3m?=
 =?us-ascii?Q?f+cCVS7QBqihW6MBD5q6NH8GpmfHM8dJGrqHfLUJZhB8LPKJPv5BlosC3P4T?=
 =?us-ascii?Q?FTBqWt9c04uYSrU6j516K9OnLxkPkWgpo6cyHHaYGCnCGiMBJOE4SqIUgFmb?=
 =?us-ascii?Q?kcOk8Jtc/OQ0P6DqXE1Z1/ijIecs79vpYF99Vm6bHpGA7ZSJIZs9kihdMU00?=
 =?us-ascii?Q?tNSbAk/t72m2Ox2i2msvQ1vmgC3YijngM4T6O0ZUzZ93wiu4alN8iRp3Zsds?=
 =?us-ascii?Q?TJclYEzAe/enbZfk6dNfe+mcKDghhXGQGbx2Sne0QNgSNvorf7OEdyI9IvxG?=
 =?us-ascii?Q?s9BadwlIvLG1rG6j8iHGdnfADbxkhBb+Ou5p/lfGGjeL3by58c0pnkEmRJyX?=
 =?us-ascii?Q?zWxPznGgmNt+zuYcHFVnW1Df+YSTIjcX0VK3y+pGZ+k/AY7ViVrg1BGKuss6?=
 =?us-ascii?Q?Zm2GYrKhbQvBeReVhxQNga7zUY5N9aBho15yJHpfsRqgmkM09Hgya2D4BoMn?=
 =?us-ascii?Q?rounIAi6P/nEQjPX5kewWfJwbFnS0MZPajF+8Sw/+rCqB0Y9MmwVCGM66kXZ?=
 =?us-ascii?Q?pqt6602y9GXuQz6dqvhIXTPR3QFAIwP0jH6ICNxA++OtrBIf9ZkfcIfVAaUk?=
 =?us-ascii?Q?IMYFnJclG9AEIVTBihkAVanfL8aW05s9ImjS1XAZ5t5x+hu/EU7+VbDc+zOO?=
 =?us-ascii?Q?aKcjxE3wSy0FWSAlz8eIrhCcOyFLqVloDPkmahgHYL9KV99m6Wj6z7Ep7eTv?=
 =?us-ascii?Q?XcgwpEsPo6cY8PJPHUTfvYh7VaXwzJCk/+tt?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9++vtaNDCyihwSq1+DM23q9ClVVa5Yt3CZR8+V7C65h/TeiVwfOvfR1AYSWn?=
 =?us-ascii?Q?SEGdPz8MuD/Z5VNH4SaujwCEi7vUMrJqzS+mUNauor69z93HqbrPyVpGnX+w?=
 =?us-ascii?Q?LcWvOmXyLQrjcJdDEWiORahwkaw+TtA+XlyIedjJSdw5Mvh1zgpZ291aOicC?=
 =?us-ascii?Q?sWl2xnYEVeBG1g+jA+72LqCsgTpIxzFepTzPtwmviWXrzvr53Kbr/vAm6IcO?=
 =?us-ascii?Q?nbHlHgHvwm8Bumk9cj4o3ONqM+dpfBGYRFv5ZQF2aeDdAeQmaD061kwJKkDc?=
 =?us-ascii?Q?abB8rfSpBiKUE3EVIzumxGlKJLQmH6tWESIz45+gySXJGb//SXCXzLJltOY4?=
 =?us-ascii?Q?ESFMVJnMeJZeqRvO7ppsV2rFGrDqz68V27aKvTWaDgsvGUGE5l2eD/wyDLbk?=
 =?us-ascii?Q?KTQhHQG5XEdtIgMOscUXF7JA9AQf+Xli5U0I+VtE5XbFn7diIlkpXDvlskRh?=
 =?us-ascii?Q?+IzgVntRemyfwT37VDway/EQSojKHpLmtPU5QPGpRjpjxHklhUq357UBvLNB?=
 =?us-ascii?Q?pKXCpsr1nnk9Cu+6cGou8n0zr8wb6hiP0oVrLoSPz90SkEpLFZ4ZWhZ+hDvh?=
 =?us-ascii?Q?eN8UpUfAgbOzxrt0s+GLw58+bRg69FmOTK6pNr2ripqT6gF/wy8xbUniVTIf?=
 =?us-ascii?Q?pOv+odZmNNufFgR+XKgtCfG8DjEKZE0CGm7jYprIQwbajyUfESVE7HBobUCt?=
 =?us-ascii?Q?2yJZH9PmWzwPrhAMEb+eFnG/HpZtKRuoVNj8CduhOB2/FLUmeYd+sXe6pvOA?=
 =?us-ascii?Q?Omn326AwNj9N49ZPEVgmH98GRZsz2aSFQylkIt0wx0MLhQqgAp61FUU0+jrl?=
 =?us-ascii?Q?ybFVGYcoIAQnu+tpRL1FbfJpWm6tv/a5Vugnz1FhJ5DehiT8N1mxMqDAeX3g?=
 =?us-ascii?Q?WhV6vdMbaC5fKvcVsaQjXv3rT2tBTOxPgQxXYMdPP4gVZ572mQSprj6jhobM?=
 =?us-ascii?Q?ca8/Lt9VzcnC5KeUCE3eZy/cLcGGC/lBoYKtMcpCiE/YE4fWKbFD07YBL60h?=
 =?us-ascii?Q?lqigp7Wc6wVsq0AmX/52ezHGTVmwfLgAIx6RwYxmzT114LHSgpnKs+BzROL4?=
 =?us-ascii?Q?/vjYIcrF1deqnY1RD/cBDx6j91RGQzZzNdI4672NlU1CYQsmWut7iRf8kmmP?=
 =?us-ascii?Q?IpVTvYEzsIZS2FPa2DrTbBZCe0uS5TONJ7lUEpgUWvVRGVnEZ+GqCBQ5H3Wa?=
 =?us-ascii?Q?E6+JNWXP6O1VK1Rrg978Or0l0HMDYrY6bBwFQUC7o5CvjEgBiTT0W0LHCUIV?=
 =?us-ascii?Q?1E8cjLj92nqK19srSnAYTMjZiay4xQDoNcIeuApoxwER/UdyoUfJNxh4PXzS?=
 =?us-ascii?Q?h8sjXtUm83IqSKX+dkpyhWvQ4ny6mJvOMWdQwq+vfMA/hgQ9UykjRBBi8OEf?=
 =?us-ascii?Q?KwZ1WR++RAZsmEfiyrNY6z0iJVlTCbyprs7h3Fg2/Tvz8jo3mj9nCXxrcT0m?=
 =?us-ascii?Q?az4iT99lSA/1dICzGwnzOufLqZiRrxQzVlQy42KaMaErZazHEB4U//HEmagz?=
 =?us-ascii?Q?hzRWKvzE0sxtDOgIzpGUc1EmLKubPlUo2rqG8QLQjmgLf0Zav7Cs5Vz7//Cj?=
 =?us-ascii?Q?fzO/QA9bK+AvKW5kCOU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05230ce4-72fe-4fe5-3c5e-08de1c19f61b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 03:18:16.1702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i80Q3naOpspyjdn+7bbklTPeNiaunrw1JpOQ5LthyAPwlK9OYAD1B3OysD5rOU/Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9010
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

+               if (adev->umc.ras->mca_ipid_parse)
+                       adev->umc.ras->mca_ipid_parse(adev, ipid, NULL,
+                               (uint32_t *)&(record[i - rec_idx].mem_chann=
el),
+                               (uint32_t *)&(record[i - rec_idx].mcumc_id)=
, NULL);
+               else
+                       return -EOPNOTSUPP;


It is better to remove the null pointer check from the loop and perform thi=
s check in the early stages to avoid unnecessary operations
With that fixed, the patch is

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Wednesday, November 5, 2025 10:05
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 2/8] drm/amdgpu: add ras_eeprom_read_idx interface

PMFW will manage RAS eeprom data by itself, add new interface to read eepro=
m data via PMFW, we can read part of records by setting index.

v2: use IPID parse interface.
    pa is not used and set it to a fixed value.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 51 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  4 ++
 2 files changed, 55 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index d7e2a81bc274..47f292557a0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -970,6 +970,50 @@ static int __amdgpu_ras_eeprom_read(struct amdgpu_ras_=
eeprom_control *control,
        return res;
 }

+int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control,
+                       struct eeprom_table_record *record, u32 rec_idx,
+                       const u32 num)
+{
+       struct amdgpu_device *adev =3D to_amdgpu_device(control);
+       uint64_t ts, end_idx;
+       int i, ret;
+       u64 mca, ipid;
+
+       if (!amdgpu_ras_smu_eeprom_supported(adev))
+               return 0;
+
+       end_idx =3D rec_idx + num;
+       for (i =3D rec_idx; i < end_idx; i++) {
+               ret =3D amdgpu_ras_smu_get_badpage_mca_addr(adev, i, &mca);
+               if (ret)
+                       return ret;
+
+               ret =3D amdgpu_ras_smu_get_badpage_ipid(adev, i, &ipid);
+               if (ret)
+                       return ret;
+
+               ret =3D amdgpu_ras_smu_get_timestamp(adev, i, &ts);
+               if (ret)
+                       return ret;
+
+               record[i - rec_idx].address =3D mca;
+               /* retired_page (pa) is unused now */
+               record[i - rec_idx].retired_page =3D 0x1ULL;
+               record[i - rec_idx].ts =3D ts;
+               record[i - rec_idx].err_type =3D AMDGPU_RAS_EEPROM_ERR_NON_=
RECOVERABLE;
+               record[i - rec_idx].cu =3D 0;
+
+               if (adev->umc.ras->mca_ipid_parse)
+                       adev->umc.ras->mca_ipid_parse(adev, ipid, NULL,
+                               (uint32_t *)&(record[i - rec_idx].mem_chann=
el),
+                               (uint32_t *)&(record[i - rec_idx].mcumc_id)=
, NULL);
+               else
+                       return -EOPNOTSUPP;
+       }
+
+       return 0;
+}
+
 /**
  * amdgpu_ras_eeprom_read -- read EEPROM
  * @control: pointer to control structure @@ -991,6 +1035,9 @@ int amdgpu_=
ras_eeprom_read(struct amdgpu_ras_eeprom_control *control,
        u8 *buf, *pp;
        u32 g0, g1;

+       if (amdgpu_ras_smu_eeprom_supported(adev))
+               return amdgpu_ras_eeprom_read_idx(control, record, 0, num);
+
        if (!__is_ras_eeprom_supported(adev))
                return 0;

@@ -1162,6 +1209,10 @@ static ssize_t amdgpu_ras_debugfs_table_read(struct =
file *f, char __user *buf,
        int res =3D -EFAULT;
        size_t data_len;

+       /* pmfw manages eeprom data by itself */
+       if (amdgpu_ras_smu_eeprom_supported(adev))
+               return 0;
+
        mutex_lock(&control->ras_tbl_mutex);

        /* We want *pos - data_len > 0, which means there's diff --git a/dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/a=
mdgpu_ras_eeprom.h
index cfbd402ddea2..e881007f715b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
@@ -186,6 +186,10 @@ int amdgpu_ras_smu_get_badpage_ipid(struct amdgpu_devi=
ce *adev,  int amdgpu_ras_smu_erase_ras_table(struct amdgpu_device *adev,
                                                                        uin=
t32_t *result);

+int amdgpu_ras_eeprom_read_idx(struct amdgpu_ras_eeprom_control *control,
+                       struct eeprom_table_record *record, u32 rec_idx,
+                       const u32 num);
+
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
 extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;

--
2.34.1


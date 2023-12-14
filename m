Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BDBC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 03:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E435410E8AE;
	Thu, 14 Dec 2023 03:23:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFD8A10E8AE
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 03:23:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nge+u9lencS3ZwIG6TOHAKZAgd/ra8eekFeGZZjux//a8WUMIHxnezc0NKh8MNKsXG4pKw7ne3WR2idvHq5ySktR9YzuwLLbkMf98QhRYTyERO/ENuwi8HXoNtjfYsR452gxAzPm+89rNFKyKJCD7B2H4Vsl0I88eDlazGzVc519OTHOoLqqTSCeIz7YURw8Jp05dD4I4xdO7n/fkwQWWAYX8RgZrRsINYON9LwWeeRD7hIREzO0L7Jr8JyhYFI3drAfF8v7aBWxScjXyG77L4QO6rSfz1oDy7sZIV7xMjE4FAUMDQRlVygCnbbmbaHmuyutYIj9/FeSJhpihG65KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfKhugEETQKZQ2WXV0EUSopKApoFGua4ohkrkWIDpNk=;
 b=ANkLayyOKItQY37EFbnyQiKtA/OGrjsXOVm+hpi95ZNztyAsCQEdEufR9bDijP+geiEl96NETFSgl7aII4SWwgov/cn27fyalNSNrEmVwxNuzKBxbK/xCqVKcNqqz3AUw0uPw7NazICkfXuWi67Tc99I4Ss8adLZEelFd9mfPtROqD1DHWKM2jahbyaveFO64n/VXw2vRlnjN2G3Zha4gYPIFIwzWZJHaUcKfZS28rT361AQkwQl98EOaq52rkDSQHYsA3b723IjBPOJOxi8VWVDUxBxFAKuMtWebbZW4MR6CHZl744w69/+Mmjgwo0HVkqJJXqQg/c63Cvv+oMS8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfKhugEETQKZQ2WXV0EUSopKApoFGua4ohkrkWIDpNk=;
 b=3d2xUKjMGCACMVwq+uKb4QDF7bCmqsGgJSP1BzbNX+Q6a1K8tC6WlCS6gxr/Gd6Jp4rNiWPSPSAWiTpMTcV+A0QJTgaukqk0p9f/AeE227GtjPMCJDzl2xImSoEFlNgG5XT3L5it/a++p/LH/+9uFkKHSfVS/kEuCcSXpeWEs/M=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by CY8PR12MB7194.namprd12.prod.outlook.com (2603:10b6:930:5a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 03:23:03 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::c177:cba4:d291:749a]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::c177:cba4:d291:749a%4]) with mapi id 15.20.7091.022; Thu, 14 Dec 2023
 03:23:03 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: add power save mode workload for smu 13.0.10
Thread-Topic: [PATCH] drm/amd/pm: add power save mode workload for smu 13.0.10
Thread-Index: AQHaLZJK/1y6zvKPwkSO1Soh4J9ArrCoHkZw
Date: Thu, 14 Dec 2023 03:23:03 +0000
Message-ID: <DM4PR12MB5181A8C1CDD1E33DB111F426EF8CA@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20231213070157.972391-1-kenneth.feng@amd.com>
In-Reply-To: <20231213070157.972391-1-kenneth.feng@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=dd8e1cbd-efeb-4f15-bbf9-db734aa13746;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-12-14T03:22:03Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|CY8PR12MB7194:EE_
x-ms-office365-filtering-correlation-id: 2031da76-c613-4d63-48a1-08dbfc53fb78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JJZOFtO27l0TkmznT7717onV/F5VszmFo3J9mTzpVlWnis67cEGPHvu6tLpc8NHDv1J8eQzu+zXtOnr/FoDWbv2b6VIOaP1t1nSMw3zJJ2pgyC2pey1ajAhNbN4GbYxsp0nd3OEDUTJCH+6SrpTog8v6/+fYo8BFfxHuqnXjg1ybx1Xr8Qcuu88zzsGPhLZA/X+Clx0o6pt8kTMI8SIqg6UVi57OsW2i877/gl7njZf8QPRsvsiSnn+svdQYUO9AhXaLAK5Gk06qP3+S/zALC04JD0WazjpRaZnQ2j2cHNo+em0ZVyBdX4Zk4RGEHdNDvbNuRWeyVrFIPGW+km2Xhu0RX9MevlDUy3UWG/JA3c9+gVYDA49DmG3UkmxNvqXUUBNf9HGJX9/f4HtUTZmzHOYUG+3hoRDRlA2ZcDBG8kR+PT1nxJoST8dyTepugZdgxaz6pY0DhlzVJXL7hwloUD1BO6MhDW8B+T7PyE1KGfNGCnpCizwZpl0jMTvaIL6UqSFt1WswdcAWFm9DQRno40ZCQbkMrbR/JZi5XMTxWwxTktc41kPg1/w1erqaAkMtV7bwat3PDCSkiNZ2OUd6p+oRshPpqZhNPWbuq48fAUDmjagNQMEkTUsHSpiUp0UM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(26005)(83380400001)(53546011)(6506007)(9686003)(122000001)(38100700002)(8936002)(8676002)(7696005)(5660300002)(4326008)(52536014)(41300700001)(2906002)(478600001)(71200400001)(316002)(110136005)(66446008)(66476007)(64756008)(66556008)(76116006)(66946007)(33656002)(86362001)(38070700009)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s+Nf8tTYmJfffz326xJY4UZSspFQRKuysAXrCwUQ/yK+n6v8ghqBwrH7cGCO?=
 =?us-ascii?Q?kXilv1GRHKxrl/XpmApjJPm3QaMr4WBuP/F0zAkVcJ/Iy2RJth+UKZnADbF4?=
 =?us-ascii?Q?dBLxHooSXnJOsnM7+LDwql3qAYqweVoX5p1yNopMUnhT+wR3hPkhDbv8ciaw?=
 =?us-ascii?Q?y7gg4RIt5TdC2ygDt1Biz8MryLRt3Ff+6EdRqNhjZXUwlUlWoeelaVE/k0GA?=
 =?us-ascii?Q?zqC7zEykugo5lPJzZsPEQ89y1qsR2nWe3q7W4BtKjzUiUzLsw84kWUTpJZaX?=
 =?us-ascii?Q?jQ9XhOl7P4LxfU1pJYsA0TYxSBqQ7n4yEIfeaxi/VoAr092l+uEkWqzeusNm?=
 =?us-ascii?Q?dx8JKsKb70aKxiitAXkc/K7H1w7eZ5v29TMhg24vYP1d/bkZSSOOlwS702vA?=
 =?us-ascii?Q?mTRQLMvw1J5jZf5rGrgw0a+L/2ENpAAnNRztvenHWCEjW4wbxCdzdKy3eSIj?=
 =?us-ascii?Q?QiJB450vhSS/VkVDO0wC0EjbW99bw0+3uz76QpBIN+OjVtSUl7DeYCCNIyg9?=
 =?us-ascii?Q?vERxGZSQkXiPpg8JlhXh16RA/uq/JYfuHv+WXOB3oPOMQZJ5P4rZBLLkd8iY?=
 =?us-ascii?Q?L3sJzFej5MbLAxOj/PupSskIyElE0HAZ+4nxP7LNZyaG6MLJebUvHggw6zi/?=
 =?us-ascii?Q?6iNpVaUmlon+GzrsD63PK2WsB35z7uXP6fBaIO6f4DDIrqY1Ff4SpmiEGGZx?=
 =?us-ascii?Q?uFzYRjzRtUByiafEwRhN4miJkAStDJ9WfWKEYYo2rRGvv/u+NaZ0GefkFE2p?=
 =?us-ascii?Q?z5NGO+WX5nnV+OH8kUbB8FbQyBAB5MluSxmQFdNJlWz+Ib7kH4Nva6Lum/jL?=
 =?us-ascii?Q?fG2uoUrAWOstdBKpmdTZQMU890jKYxO0Ywv1ElfTFKIMB+c453lCmSm8tHU6?=
 =?us-ascii?Q?3LV6o8gD60rm7Th5r/WrRLTEr3sYhSSe0LgMGDdrdnZEIDOH7SOz3kM8z88Q?=
 =?us-ascii?Q?AJaNF/9ztT76eVyIISfvr4IxA5qV5zbJcE5pspmrDNt+2m/A1Pz8VMuqeFtu?=
 =?us-ascii?Q?JxJcaGH4ACZSDv7Jz6CP5HVW+2C86ab7MoAo9LC6FjQ7N4lFY8UsW09U7xF7?=
 =?us-ascii?Q?16TALHwcKac+GUhAJYM4bVV10xxqPMzlz8qTQFIGn7f5IIGXMFm8WdPxFYrQ?=
 =?us-ascii?Q?GzljaSX74rIFJQe0Yxdt22/W3NfzSXqsm4lZzDgcaasd+SWw9Banfmi7awg9?=
 =?us-ascii?Q?Ij+THngYRGj7tbuIiGw0bkp6Hyg2BsHF/iemjFzCXcDvI2bBzuRmTW6hSPwb?=
 =?us-ascii?Q?jZpZeFgyHwIR/kGfU+WkME3sJFvTgo3QTYR5T4fdt2A4ofQlVylgjTrRBl+f?=
 =?us-ascii?Q?ho4h5KTw0008tC1ofG2VGftZD343PnCALYgpK9sk4Sj8kx/ABlQL1msW4Yi1?=
 =?us-ascii?Q?qT8ovGRxFt8kvdy7MxlR6rI4CkJSTn4l4IIJPMX0Dp/RkMn0mpoD2OqZsCgS?=
 =?us-ascii?Q?GjVqLILfLqbedW9lrZiMp45snmGAReBXu299gozC/PCc0BrRpJx74eCTthKu?=
 =?us-ascii?Q?YRqygPQyNSlP49sQJ5SbitfelFy7K06zeYqidr5CaS16tWn8wwwORMK+IvNq?=
 =?us-ascii?Q?G8SMgfD+zi/rc+qkkz8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2031da76-c613-4d63-48a1-08dbfc53fb78
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 03:23:03.4391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gLqb2z17Wf8Vfie5o37YN+gV0YvZRp8bEs41fgRqwSXelRfYh8/NUUgt4h3DS0R8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7194
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

This patch is
Reviewed-by: Likun Gao <Likun.Gao@amd.com>.

Regards,
Likun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kenneth =
Feng
Sent: Wednesday, December 13, 2023 3:02 PM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: add power save mode workload for smu 13.0.10

add power save mode workload for smu 13.0.10, so that in compute mode, pmfw=
 will add 35mv voltage margin since some applications requres higher voltag=
es.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 23 +++++++++++--------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index a24aa886c636..231122622a9c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2545,16 +2545,19 @@ static int smu_v13_0_0_set_power_profile_mode(struc=
t smu_context *smu,

        workload_mask =3D 1 << workload_type;

-       /* Add optimizations for SMU13.0.0.  Reuse the power saving profile=
 */
-       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE &&
-           (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VERSION(13=
, 0, 0)) &&
-           ((smu->adev->pm.fw_version =3D=3D 0x004e6601) ||
-            (smu->adev->pm.fw_version >=3D 0x004e7400))) {
-               workload_type =3D smu_cmn_to_asic_specific_index(smu,
-                                                              CMN2ASIC_MAP=
PING_WORKLOAD,
-                                                              PP_SMC_POWER=
_PROFILE_POWERSAVING);
-               if (workload_type >=3D 0)
-                       workload_mask |=3D 1 << workload_type;
+       /* Add optimizations for SMU13.0.0/10.  Reuse the power saving prof=
ile */
+       if (smu->power_profile_mode =3D=3D PP_SMC_POWER_PROFILE_COMPUTE) {
+               if ((amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_VE=
RSION(13, 0, 0) &&
+                       ((smu->adev->pm.fw_version =3D=3D 0x004e6601) ||
+                       (smu->adev->pm.fw_version >=3D 0x004e7300))) ||
+                       (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D I=
P_VERSION(13, 0, 10) &&
+                        smu->adev->pm.fw_version >=3D 0x00504500)) {
+                       workload_type =3D smu_cmn_to_asic_specific_index(sm=
u,
+                                                                          =
                                        CMN2ASIC_MAPPING_WORKLOAD,
+                                                                          =
                                        PP_SMC_POWER_PROFILE_POWERSAVING);
+                       if (workload_type >=3D 0)
+                               workload_mask |=3D 1 << workload_type;
+               }
        }

        return smu_cmn_send_smc_msg_with_param(smu,
--
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF99C021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 14:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6140110E6E9;
	Tue, 25 Feb 2025 14:41:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="02w8jrjI";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65ADF10E6E9
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 14:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjrhiP5pLKLPNg//Vs2EuY9vvR4j9JFnKK6bU+9j4aK94apfkg/MmK5NrRiXS76UQYO1D4bWk8iGoIt6QEGYUsrLt7J6tuzwwrXbRpgd1aNkklLpVSmmGzOpT7bGyPc/yFMTFzfxiTi7OMOJC988mgjoQ0XWaCBekqyR2l5+E0Erq025OOMGVdYs6APRSyvd8ku9iWxGTyfMk1rxf5kWJBlS8hLEcawcWyqDw4j/95tJB/3BKOBFdEZttgzOz934AArXj9LGS/r3DXAHiHX1mxBB1HqdC3k1uNLNZTdJdKLm63GZA4PN3UL+ILr/HQE9w084gzWsA+RfAtVLxKpZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIwm0M/yL1NgLCI0ycQuRcstgWMJv4f8PrZP3yHsQWc=;
 b=s0+o85kbkbhTtuX+XXH6ii8EJ+eMGU7Il8LpVkmbGRYFre/7hUZIxaqh329RmNfXqBlmcuDxzLsARlusjXyfI0rnyMsbitW46NbXL6Pv2/zajhRB33iCtOzMIYnnQfhy8nHJoDxsKxWjcOrZgjBpgjKbdzJXhx9AFQLWYhxbzEYfHliGcBVSu5H73XTCQQWLaOK7CjS1BNzrWU+VpRm6o4j50y+NtUxTRQocjSLQHUgyLbHHpPoqhzS6wbBLMaCKWEswsRXu4xANNIMWnF028iaRlMlO9gu1rizMOQYWv15yichrVejAPYb7kQvj7gsbl+UnRpXcYarmPYLn4ajH3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIwm0M/yL1NgLCI0ycQuRcstgWMJv4f8PrZP3yHsQWc=;
 b=02w8jrjIgphod10acPhgJHviJ5+bzjKl0g26v9wyH4H+VKJHKysYqu9o1nzJeGZSzCP7vVNZpgsn4/iWz8ZrQHaNtbGCvfVy9t/jD5XFe8IEqn3hqvusWqoyjyV8nphwDIs1hROuJVFqhLuyVlUlTlR6Qh4ltGJH9ax2/Wr0AeM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ2PR12MB8062.namprd12.prod.outlook.com (2603:10b6:a03:4c8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 14:41:10 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 14:41:10 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Liu, Leo"
 <Leo.Liu@amd.com>, "Sundararaju, Sathishkumar"
 <Sathishkumar.Sundararaju@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Initialize RRMT status on JPEG v5.0.1
Thread-Topic: [PATCH 1/2] drm/amdgpu: Initialize RRMT status on JPEG v5.0.1
Thread-Index: AQHbhHR6xdyiAAlTH0ie1OKVGP9167NYHZlQ
Date: Tue, 25 Feb 2025 14:41:10 +0000
Message-ID: <BN9PR12MB5257C58B3A7204EA6AF2886CFCC32@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250221152234.67294-1-lijo.lazar@amd.com>
In-Reply-To: <20250221152234.67294-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ac4e6b26-a389-4477-a24a-b6032aa7d33e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-25T14:40:46Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ2PR12MB8062:EE_
x-ms-office365-filtering-correlation-id: 481467d1-fd52-400a-bbd8-08dd55aa71fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?cWOXhzdYpD4QQQBc/uDuhAJryYtwT+l4yIQVDYu1+Fb0sLe5NawbETCrpC1/?=
 =?us-ascii?Q?Fc3X35YNFotnDfa0CrI/fbuKIzTsm+wy5DT2XX4GyHXHMll26I791H1Ul6Wg?=
 =?us-ascii?Q?DkImkoDwrFgu0+0lsFswo0Hxvvquxf+uKbXxNCCsS7zSxIwQW2bCPv3oybmp?=
 =?us-ascii?Q?tQ4UrIswGjnx8iX1YRk84zNitroDDVZMjPZTJXu+0QkukPotl06gxH1/EkfE?=
 =?us-ascii?Q?VeppWAuRi54XGDqORl2fmtDLuzWvem1sJm6HCFn+hQrTlXhJi5Y0UM4FL436?=
 =?us-ascii?Q?PJ44BECGRQe+ZRtnkSsycGxvRUdQWo8m59ImRhehBPpNm7qTVUQv+6iB8e9E?=
 =?us-ascii?Q?ppXYQIzZbbQu34zraEwRkflN9Ay1PLfeSdHiY4UMEWsd7Y6zpnNvX03JJTrh?=
 =?us-ascii?Q?WEZQyVnGr1FZkHzAo4dYJssaDXm3gGOGsZ604NXFOMQSqN/vwXCOUDt2fcmQ?=
 =?us-ascii?Q?gWa9HFy7/Th3dSh2FmY1GWUA/17Ub0+QDsrCFoNuezvfx/nZhwSnBnqoPkYI?=
 =?us-ascii?Q?pcFUkFIjTidAV1Ih3veo8jp79hX/f7Xt/3wckWLJWiprx3mXISME7yB1g+vm?=
 =?us-ascii?Q?ciz4DuNOXnhHvwvhulEHkHsqi7/Zu22Cl6DzumdrZKOPjFh+Nt4FglI7Q53B?=
 =?us-ascii?Q?Q4kpPh02Gq5Qv1FFXoF+U+cJt2g5FHcOzz6BtMcza7amo/ulCChodegTAavQ?=
 =?us-ascii?Q?Yo87bj9n0BDllIozn8Xmw9WXqdujqI9sTm9RoktjOCONHF8PBSb9HtHaqgRV?=
 =?us-ascii?Q?iUtVBDSVuGGYGjRilitR0Q3Ipp1I6LZlubF9Z1FG1vXXQYM5gs/mU+PXisWm?=
 =?us-ascii?Q?U48RfAaJgPKVIC5eLMXyl+HXUQVh/CXa7xCY4piQg38w7zB1ID+YrN8e/CXm?=
 =?us-ascii?Q?+W7N6Ol+3K1cZuPqkKfY0WDO1PTb9WXpcIXSeyUW0OcyirxdmP1brN89mz9P?=
 =?us-ascii?Q?ALoW9XXdBqv99NxbT9nfd6p9C6lTgdLX9UzTMu5K/X1cVM0mwU3txFaHwu7/?=
 =?us-ascii?Q?2Pj/3o7E0nIVL4NAMKKHkRoosMvF5WdtcXIu2pwZiEYaZ76jB7X4gktiO7mi?=
 =?us-ascii?Q?gZHBZ2TyTA57cwig3razk+73LsuxU6mTODs2pJmXCRlOWymeBOBjnuSXthLR?=
 =?us-ascii?Q?GMBEYjhcVwz89pcZZJ6ZIK7EsQ79YhGpEsp1v2+EOeWLjz7GU90ITZhtqrol?=
 =?us-ascii?Q?inkDS6obA731laNZtrAzkgzbVFFqo142PFEzL0+Rb+ixQ0fIM3xXkFaXiduj?=
 =?us-ascii?Q?GcWpCdVuIdlH65pO5n+/C9sKOVjwyKdTMDTogeiKTMuup2FrrOjfvsMR/UQm?=
 =?us-ascii?Q?ykJIE+s5HgJglA2aMtwqTVzB7OfURlrZVtVYNI5j9Ks9w2Vsd9gu/z9lfN9p?=
 =?us-ascii?Q?DiEwsf6Aur0boIhLW0sAdUUY0cVfproUDJfiea8ECgLg1w3EzTvZyLjx8XG3?=
 =?us-ascii?Q?G4DP8pD8aB/X2Uk61oTsOMTglavwprWE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DRvxRFnJy9XNhGm2nsy9FJnfIEYGDGfwXbcMb8c5eW+IZBIZDF6oBxdsF2Ss?=
 =?us-ascii?Q?bTKFyYVlXDGXylleKL52rbBYbZYmIbBIVYKa0AN1jEjdwvJv1hDlG4XN/OvF?=
 =?us-ascii?Q?IPidA6zC5cOeBNYsXbHRe95XDNPrPEE92XzRKEaiKWV6vmpIDLd70Y//qIF+?=
 =?us-ascii?Q?VAmHJck9iVIDgm341AsGZwGY+42H1RdnRvrByCQ+ZHy2nZVe2TJBnislgVwb?=
 =?us-ascii?Q?XnnGMPC2eJz7HLoGd4DXh2D+Me3RMquj2aJxjVS8ae1yfYcTwN5b/LzfDgSO?=
 =?us-ascii?Q?O33W2Nini2++YsUdKmMFZvvURMMhw62FCqO3z9AAUr+PGXoLjF222jnO4p6A?=
 =?us-ascii?Q?QaZR33peQYcKZSi1qxhmGITPUaHKuR992D2b5kosuKZZ2RGoL1PyAFIEcWaD?=
 =?us-ascii?Q?Y7TKcOkVFNacLtxwzahv/RpjPPnP5nrPXc0hL1XFws3ZD8n+3dxF1nI/D0nO?=
 =?us-ascii?Q?Clq0tDIjv4T9kMSiFku4x027oPaWiatYH84rHd9vmtcpVAJ+Ev20XLQh8Tj6?=
 =?us-ascii?Q?Wp82gQ3tVZCMjssFB47hqZ6yHQtrqjwNlp4V9AJbHjKiCqczd2rGKUL23fNi?=
 =?us-ascii?Q?Reqmdd/Qdj1zaNgUdO0FFkkpTnTPlDCvMtq5ijeyi68HneNHNTHdTb1aeoaq?=
 =?us-ascii?Q?A7aw5Ys6yngjzoOJxJ9x2EwKPIo0nsUINyjOGeMjVLvMozhZUhhu6TIfMJMp?=
 =?us-ascii?Q?vdXf9XH7oREsuDjohsTQoN+wdsmf5ASkA/DIq9pw3Q1Cc18zP1T9UVZy/sZ6?=
 =?us-ascii?Q?0UcELj7fjzSQqh/yGLee0qyPAEd+GOKOxs+rIlP+zMdLRJqul6LGzpgvidEC?=
 =?us-ascii?Q?TTxx+TEda8dDQ17SLcrAAyBbkAD1b12AtqxT91/lN44YYrDodL6ypf1XEaAk?=
 =?us-ascii?Q?YxddummSLtgPgZNJ73ICn0bReIqZuyewNTq6gDMeIJ88UfWH7Bw3SIKjgroi?=
 =?us-ascii?Q?HTk90wBEJ437W6o+FssdRTCcU3Vca0KUD4wFp6DOvP+P99nW1/xx6SlYwieb?=
 =?us-ascii?Q?rlSQwvNnTADndkriyfbBiUlkAt7adn2dlDHxpwNy5yXkI8orbs//oQHApZKs?=
 =?us-ascii?Q?woQGEdVu+Gp4dUzxLSCjHhVaMM2Vqd3veIeYUDudQ3LbLcYzMUjyIlS0M5r0?=
 =?us-ascii?Q?lyRdwwk3Dsy9swNuB1Sh8PXLiIy7mETGdJjrGLPTBtl/DI3TDm2U5i0OAZ+O?=
 =?us-ascii?Q?JNi9oDIVSXiDVWzEbwR7dQqN5HgcqxNunIrfa96tBzmDPGm/hk4Wz+ypQQWr?=
 =?us-ascii?Q?bwy/8J8oyzy841eeekOk5/K4qQ+pScAAYKX0pSPcgLQ9FfT5BKOx1o9SKWHL?=
 =?us-ascii?Q?n1l0/pov9hVYnYuW7bc4xBObGlE0OHXqMegJl7hbZR06lqp8ewkkQxSVNDi6?=
 =?us-ascii?Q?1NR1vcAeKRZpBGnXCLIcMEouVLrJIQmSfyh30OpjHOEohX3l6Uo/wbjd7nbg?=
 =?us-ascii?Q?h3yrJwpc1bQAuuSHTzTk9zITdKbUSqXBlKR77SEBCVTmYp5ozg3gaDofXPqi?=
 =?us-ascii?Q?2LFsMhWJXIVy7B1+YsMy278qJmZcFGiwGVzi509LjIIG6JlfcGmk9iVT9eXU?=
 =?us-ascii?Q?7Wauc+fo0ATRFapr54o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 481467d1-fd52-400a-bbd8-08dd55aa71fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 14:41:10.0993 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+u5Rn0/67VPw7qgVAKd9bN/34inJACKTqNMkDG+EyF0VfshOMfgwGrUz0E+9azW5B/QJCA+ioP9qSC+6vWUMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8062
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, February 21, 2025 23:23
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Sundararaju, Sathishkumar <Sat=
hishkumar.Sundararaju@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Initialize RRMT status on JPEG v5.0.1

Initialize RRMT enablement status from register.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 3 +++  drivers/gpu/drm/amd/amdg=
pu/jpeg_v5_0_1.h | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v5_0_1.c
index 5d4e2a09acca..0d63af6ac68e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -239,6 +239,9 @@ static int jpeg_v5_0_1_hw_init(struct amdgpu_ip_block *=
ip_block)
                }
                return 0;
        }
+       if (RREG32_SOC15(VCN, GET_INST(VCN, 0), regVCN_RRMT_CNTL) & 0x100)
+               adev->jpeg.caps |=3D AMDGPU_JPEG_CAPS(RRMT_ENABLED);
+
        for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
                jpeg_inst =3D GET_INST(JPEG, i);
                ring =3D adev->jpeg.inst[i].ring_dec;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v5_0_1.h
index 9de3272ef47f..ea1105b11705 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
@@ -87,4 +87,7 @@ extern const struct amdgpu_ip_block_version jpeg_v5_0_1_i=
p_block;
 #define regUVD_JRBC9_UVD_JRBC_RB_RPTR             0x044a
 #define regUVD_JRBC9_UVD_JRBC_RB_RPTR_BASE_IDX    1

-#endif /* __JPEG_V5_0_0_H__ */
+#define regVCN_RRMT_CNTL                          0x0940
+#define regVCN_RRMT_CNTL_BASE_IDX                 1
+
+#endif /* __JPEG_V5_0_1_H__ */
--
2.25.1


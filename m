Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6351C47072
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 02:28:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F71510E381;
	Wed, 15 Nov 2023 02:28:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4431110E381
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 02:28:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NY7bdlYCVjg6yRMJ8g7zwgHDyVtRlqbU5FMmFs5P1BUcp2KloLlcIWzmh9TM+vACOlYEl5pHoUfYJ85DkCuDP429cK1wxOFg9KbVmjq1CLLTOu28Yd/LW+ZOvgLaWXqhChNBnXWz/gdTPqh/dJVc7vWJjxbYqvq4kSulyGQg5GresNZbHjY8t+M+sR79khhRrp95i+lNN8fbtp6BFn6it10eE7zUQz8CTzZ5X5w2yX6MtGTnELUwkfOb1LhrzZUXgWi3+z40JFMSw2udzl5dXPyMRgNHesU2gt+PxIGaRgBL2yuNu6cGkra1Y5MDsNocmwu73EDUDyQaAvTIDcfyCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXl+uLGCR4q4hPVjKyRDOxJwpmxsdCPPgr76wHq2Mgg=;
 b=evOJCjvmRAmdWzsyYS1JjOU918XP7vpPL7utiRjOCcwz/JNYto8SY653Mps63MolrHaguWA/Nc72UhE2KSsHxI3ziOCCvLU5w9KRO14MvTeXNlVZxCdzoCyJs+yydkhE0mMK+AS5AQ7VPfHSOcxOltg5N8AvgP0fEbZQ/aRNipvmdbU4GdVYa8MqLzMgp0r+3kg54ePZxlSKIwbI2vEg8w3ot4C6fpK4WJti1j8pn/ppk3qAz0drOl8VD94kG8yI3ELwpqbLo2kkDEcwFXWsAaVNqblceovNIu7pGcP8Po1SbXpF8Lem5TppDRtzh1Wnuq1z5mlOHeHsxm5MvSbUYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXl+uLGCR4q4hPVjKyRDOxJwpmxsdCPPgr76wHq2Mgg=;
 b=V0zvwpbX5Q+FaSNcTC8ZpWkRrVPc+04Oc7keQCW2jHvgfJ6sQRa2uv8zo62PKdGhNUGRgC0YZHLMHiHlwAdRGii6K+Upxfmska4n54etFgjYdLesPL46qr4taCPHIhOEFePvcJXjdpVzpPRIpRASQQ5OR2Vz1aeuDKxWbM6lp3E=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SN7PR12MB6767.namprd12.prod.outlook.com (2603:10b6:806:269::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.26; Wed, 15 Nov
 2023 02:27:56 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::f0fa:4908:b418:96d2%7]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 02:27:56 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix mca ipid socketid decode issue
Thread-Topic: [PATCH] drm/amdgpu: fix mca ipid socketid decode issue
Thread-Index: AQHaF1aLtQMP8IFRL0a1ocyvIV1yJLB6p9Yw
Date: Wed, 15 Nov 2023 02:27:55 +0000
Message-ID: <BN9PR12MB52576DA94E5D25467055D04FFCB1A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20231114235837.2262938-1-kevinyang.wang@amd.com>
In-Reply-To: <20231114235837.2262938-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=c17c78fa-1dec-48d4-8b7e-604c50eff9d9;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-11-15T02:27:19Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SN7PR12MB6767:EE_
x-ms-office365-filtering-correlation-id: 9fd9e828-d634-4ad2-89ca-08dbe5827a16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mPnOaQw4hoi5EOmpM3HMBHViA62KdiUDYAuswKlAk/uwr/bgZNF4KbWrn4+3ri1V7ROcHQ10qlnwPmicdU0Na5qI8WOXZbd/uKgJfAFw/9SXn7KP2vhcSq4TvkbI5kWP2od2usuenidV4HYja8U69iDmeHVF8sObv1sAySNrG3oWlb4jnsczfrXEGmegQwj2lZlSOAKNvwGa6UpTE/sSE0Y9H+e6UFrCtrmIEgS5wVuZt/Am0CZHQkoo6A1Rk+CZN2WxR4h94y1pvKEYJVYnOhfGI+T6y+YpgB6pJhcH09p0tep2QC5hNlVYdi7M7qfJHKHbhR/PQ2jleLtBOidlC5QA8I/VRFj2jaauNE9dhe2h3Eua/vdZq0iZJpGBdT9n78dUcMRTk7I7oqYWk3mUqs2TC3hHOQTC1lA+7W6TNf5e9mmHvrBpY8jPMzjzheE6lY/swnUyqMaGN2ae/L1Y04QSy3xR9O0YmP+4PclP2Do9zXlQb4P8hSPKkv8bPdXvh5tWrLhNErL5Uzxb+ic+2Pr74e+xa3i/Xzdn59UivCEWPd/bdNjuCkGOYu1v89Nutfmp3xxsnrVj9tY5N5Lv1Fv3yDRSFH8bSYxt3cCFUa1Qm8IQtlpiMwwn9YmFDKnO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(39860400002)(366004)(136003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(55016003)(66556008)(66476007)(76116006)(110136005)(66946007)(66446008)(64756008)(38070700009)(86362001)(33656002)(38100700002)(122000001)(9686003)(83380400001)(71200400001)(7696005)(6506007)(53546011)(2906002)(316002)(478600001)(5660300002)(8936002)(8676002)(52536014)(41300700001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oEonmD3Nz3o/u7tLGzojc7sbVWjr9FdvvJLMUL20Ul7avqF0WGj8fgDPzCxn?=
 =?us-ascii?Q?bKjVhk02xbxMWMO1VzCLEJFi6jFwoyOU1lma9Q5a9y5/z/I7qBU1Z90moW6Z?=
 =?us-ascii?Q?DtNDrqnoWJBDggOGtA0L6acR18CyZRb5Vo2UWzCEWSTh5CkQRynx0d6+XijK?=
 =?us-ascii?Q?63E4apP+i3+/c12FTWlvbFhB5NsO/E5Y8r2swSkyy75vL45lIrtdtV7jdUge?=
 =?us-ascii?Q?J3Ix5OmgDz6Vo5ynB7TXIktuqv+DAT/zX01faHkobCkFhS8VG+U8zoD4Ari8?=
 =?us-ascii?Q?SQStANiGd6+w7C1vm9rk+nXBkmzIRTNE41EIMfp02dfhZHyGBDkJyQV/T+hg?=
 =?us-ascii?Q?PBAyp9xeYHNiTyESxWVSBFR1uIxMHKQo+vWnNbQT+T92lH4p0qe9Z2GAGTo2?=
 =?us-ascii?Q?b7P1c/UPFsOZiRJpR0Q4UM147d49jCOmP6OBSBW6D+a8iy8xasJ7NMgGGF8o?=
 =?us-ascii?Q?lYswz9zhqFu8Ro0XB+fbz3i4OBkGBabERPEKJ2mDA7QGcLKjbsQKE/jHZ96y?=
 =?us-ascii?Q?ZUAZrt1IAkzXIOuUg68IjfAHKeFXcEd0C6jluN7KHZ9TJUFZcTtBDIj1yttX?=
 =?us-ascii?Q?S6Upv0d1hDECy9kSU7H0L5izD+bPXUbD51x0Ya0/83tTYVvC8uz8NL2Cmta8?=
 =?us-ascii?Q?iZN9KkEvn4W1YeVtJIEZgPeVPpvBV39AQQya5JiEF7eY5AAHYRs1famlNkbL?=
 =?us-ascii?Q?Hmw2MrBVHxNfTNOY+A9HyEeydQvW61yx0778s9KhgfdD8OvmgwK4UtNXZszs?=
 =?us-ascii?Q?glwaEg9Jjv68bfWjZntNgx1kIvcN6w/zMHKTTH3016+FSz5D0ujKaF0FSJXa?=
 =?us-ascii?Q?GZWNcE1I3nz5/UDWWAmYkI0AYORfpQpv6PmfrJ8YpYuBuq3vBbFSSiNaYKs8?=
 =?us-ascii?Q?9UgwFGZ+l51kkW87ejUZmjEYnuJZKYuy7K8OXnafJ2Z2tR/H4mV/EQ+I3kT+?=
 =?us-ascii?Q?ayjEtJ1DC9aaiIduo3wvr/vSYbxFtZADSrt4bVnmIhTT2A0TuAG4lDd2AF39?=
 =?us-ascii?Q?fAgPadjZfbYC0Jo1lCdf3RXyGMS0mjatclZkqzV9TIyzjGa2ZPI3HNUmeR7A?=
 =?us-ascii?Q?uIposV6FmikOjLeypiIB8YI3ymbisI2ir5MYcKBlylAe0wrknIWw50A8hVNt?=
 =?us-ascii?Q?/3CXT4mddSrThihdv9ugSqEL50qvWvXONikbZLImloGxt28GWswyH3g5WVaQ?=
 =?us-ascii?Q?tVIuBV19nQfV36owyXXZyvs1EDDStu6XgHjtItL9WJdbl8S1iQGv7yy66Qq3?=
 =?us-ascii?Q?hJ/Ay2YZwEZjV5RDRqBH9IvC2sL1T8SpARB8gfc9wV9B2Kxwt6ueJCEnsDix?=
 =?us-ascii?Q?e2XhK4CwewwcFKvXHC4jPQil1MR0RLLSl58uyP4D5NfmDwt82baZ2xGzCMjM?=
 =?us-ascii?Q?N/NwyRVfeDI+itZ5sCRL4cahnRDJxBZzFs/JIPR/wsl8stnsQhIcXQjt31re?=
 =?us-ascii?Q?X/uZS4wmFaHKNZfqMH9fnOplRHyS0QL/ul6rnepz6bwUE8ez9GLs1z1RCrhc?=
 =?us-ascii?Q?Vq35RGWm9svWkNUDVf/NtBBbArOKy/zXrLp1dLPWFkpnF+xYw0M7+9jq0MPW?=
 =?us-ascii?Q?rJzwI/FO+1EwKxp6o0U0HGqr9br9Zl1MS/zLiNTi?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fd9e828-d634-4ad2-89ca-08dbe5827a16
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 02:27:55.9732 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DkMrj36Olc/ew7p9FVNlMazE6eMMaRWjsk1DSW9CjmhK8YKE5/9+ol47zzV1V3z06VqmoJI4Cu802k+extQi4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6767
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, November 15, 2023 07:59
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Yang(Kevin) <KevinYang.Wa=
ng@amd.com>
Subject: [PATCH] drm/amdgpu: fix mca ipid socketid decode issue

Fix mca ipid socket id decode issue

Fixes: 610259215805 ("drm/amdgpu: correct mca ipid die/socket/addr decode")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 6daa8ee49035..d4e312003181 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2410,7 +2410,7 @@ static void mca_bank_entry_info_decode(struct mca_ban=
k_entry *entry, struct mca_
        instidhi =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi);
        instid =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo);
        info->aid =3D ((instidhi >> 2) & 0x03);
-       info->socket_id =3D ((instid & 0x1) << 4) | (instidhi & 0x03);
+       info->socket_id =3D ((instid & 0x1) << 2) | (instidhi & 0x03);
 }

 static int mca_bank_read_reg(struct amdgpu_device *adev, enum amdgpu_mca_e=
rror_type type,
--
2.34.1


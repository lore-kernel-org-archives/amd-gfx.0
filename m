Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDA5CDB479
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 04:59:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 644AD10F100;
	Thu, 25 Jun 2026 04:59:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ke1Ou7QL";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013010.outbound.protection.outlook.com
 [40.107.201.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F16F210F10B
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 04:59:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UoLVlCk+SYNe46waF193h8rO6DCJ/FGQASxvLAIy4VTnJkhbnWJL9sK2HYPcdCAOxBGKnh0C1TgVIvmupmzbjxlmK9RX4aUFHZidoJWvPxffPQfykeUG8FCWgEiCbrVUWQJnfiXPfyUq41+r8rjXKEfY0ZnD2/XdNcVVfgPADHK5KyG92O7xsSEW0Xn+pChgU1EoJgeCR3g+mijHoRLxbDq58yZh8Om4FkFxt0HQNZaPt15Ci9gvvxIfPgBY+do7+8z6tvQ7IdV0DT/w7GyxQatuv957VY1kmg6cYP1IyBARs0GyHpUaA1ImUbMC++Z9M1xeqaOdka/QX4MNJRvJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMTnsd35fWupZI1mlHF4D2nNNsxuQHczelgXWTR65bk=;
 b=cz+RYNp16DhiSljawYusiuco1zHlOh/20tN4K5MK767JYCUxfoBUgT66bkNJ7p9FrENhFdFccIGUSfpNvj2huusEk1WztxUyXK7qGXa/caw8c7WkgNVd5Emkl1HdY4pgWH3SD1eEEOuJisItjunhx67yKOeb8u9wfs8RKs+QZpGinoHZus/8VploiSwE0EnviS2D0QJA2VU1eYeU+DSaRYYtXFsMer02++Sg+ssiumvIAs8ZBnx/kKejYSwz9S06qu2JORZmanY0ceJhVH5+S1cGoNs06aIeb7jM/YcjX4HftXUdhvQEXn+OszMXYm830q+RFMFiFwnzHkfQLv+eQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMTnsd35fWupZI1mlHF4D2nNNsxuQHczelgXWTR65bk=;
 b=ke1Ou7QLpO5UN5FM0YLCL0Wos57xxP5KhvaWg9haJeHK3dOLoLSOcYHOaxCb1NMrWlr0OxvUkIuOEOPZ+KDlNriQaFKRwwJEq798EPWfyc1aPcznQ9sTma5ERKwg1GDJoftGw18AD4NvxaqRmoacHRDaUi0UUFEtYWJOEuI3FdM=
Received: from DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) by
 MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.16; Thu, 25 Jun 2026 04:59:45 +0000
Received: from DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e]) by DM6PR12MB2972.namprd12.prod.outlook.com
 ([fe80::574d:7c2d:4d0a:855e%6]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 04:59:44 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/powerplay: Align get_tonga_state_array()
 header with prototype
Thread-Topic: [PATCH] drm/amdgpu/powerplay: Align get_tonga_state_array()
 header with prototype
Thread-Index: AQHdBF9A7mUoWKZlxEeVvm4ixoBUPbZOtgmQ
Date: Thu, 25 Jun 2026 04:59:44 +0000
Message-ID: <DM6PR12MB2972959F6C9874A8A4239E6982EC2@DM6PR12MB2972.namprd12.prod.outlook.com>
References: <20260625045737.3063698-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260625045737.3063698-1-srinivasan.shanmugam@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-25T04:59:23.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB2972:EE_|MW3PR12MB4409:EE_
x-ms-office365-filtering-correlation-id: 83d4d2b1-63e5-4b48-8fc3-08ded2769304
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|3023799007|18002099003|22082099003|11063799006|56012099006|6133799003;
x-microsoft-antispam-message-info: TdcEanP/dPQQ+5gCayugfe8kCZO8p1tyf8oXQg0Evf8JZZjvhfv/MRM+5VvJ3OruhGG//F7vsZUR/RoRFvsU6SGQ3uF9xLqeOppnE7Ay/E7aYmTcfkOmCIhbkeIrcSygUR7uj16/u2lRMkIUiI5+TLOO6KauonfJgdXa72gp5NngWdXBNvPOSq65NGEO/JQV/GArFD+PNCgt5czFd6tQQe4lwRb17OiWt+moiRXLhgg1Zpxp5q9eLr67EKNehxp2HTjP8CYurPGnnnMamlhg7jCR4U2yewweJz4/ZdGs84Qq5v5brp7MJH4jkka1ao8Xtz+SDux/hfgTBuW6aqy7Lj6de04/Fw/PAL8O1LqloIy4M+EIaJTkXT59LomOJnMY2yV+jjEdfTjblxhQYenbLSiExeVU+KpDBs3GlElUX84ZjIOE6OnTG6TuV/rvNFB/Se3wt+xivBaaNPMrYJFGK4JdOJ6A+TmxcPu7up9dA/39mMMWvX7qm3CoXTU7wSVnwMzeGA1S3Xix1zY26z5hGQenTET+8G3NTVXxRQhAwJgBZ2q7ohrwD3EGs5sYXinei02mu6SnItFVFB2cMSKHTeKstXErxLN4pH1Mik06FyvZ9cnoG7oaXQ4uC5i3+0a7gHYzxZNq9yuvxjQuFViJ9IyhlkHtBjsnYpa5+CbbgFnEpVULaPGg7UNCugRP0hxmmc0s0WBSEY1mk1OpKHlgWIun6B7f19FlZv5XagpFXW0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2972.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YBykGQ48FvAKuI74Qe8GOUHgArKi281cHYzv2utCOghmcjKksOSEr5wPEIhq?=
 =?us-ascii?Q?gagcbhj9FRzWQ8PIL2zp+Sa3tHymGVnXqZzEB7THq+ipjrUM8rg50Y6DIpT1?=
 =?us-ascii?Q?PXycdp12oy99RmM6TElprVZVroEHYwB/ovyw1CJ0RmeLPu5UbpEXVOnBfcLo?=
 =?us-ascii?Q?PUJ4v1YUVYNz0dhnSSjC47pWRDtKGWgeawHEqeALIrb1EY+B8A3xJ9lpfq2A?=
 =?us-ascii?Q?Ft5gbv1pnLdQIseDAgx1d7tYqUqQNXqMJk9AJiQToFw7Jp/ZYLjd1Av2w0lz?=
 =?us-ascii?Q?zkUOhapEJg3YeCJ6WNKZVJa30rzXDfo1rHh4Y2PJQrqz02qRaib55VDs4TAn?=
 =?us-ascii?Q?FIP96op+qtG1NKGKALICZvEQOGtvGzCavxCBXdNOvHSSTck7xe4VKUySRUYK?=
 =?us-ascii?Q?xD8Mokvsy3Vatu2DhdqO5bDOi6DlVCZBhqbjZsaQhe+XFDaPURf5JiNXlMw7?=
 =?us-ascii?Q?oY6DKF7C6A6u27hLzScWjSgSATXZyZyujk13w8nf6ftpWm8BPvgTN0JI+sUR?=
 =?us-ascii?Q?XNLCNb6sr1S6G3JC+iMl7bqr0sHW1mj4z7+066mooJkh2VtXVRjrLVVZ81XB?=
 =?us-ascii?Q?KZOJBOARPPShaF0GS5rScPh91BcGBymGA7nw5VGQdlkTkwq0VDH1dOeQZULe?=
 =?us-ascii?Q?xeZYe1L8LpvQ59AHzQ6g9D7lVCfOh/sQoZ2lgbIJKZaBWyiiyfMeFGCPSxoG?=
 =?us-ascii?Q?YkfTktI58gOSqTqL+S5n58g+hLYN+biq0BLS55oGsSPCLg48JmvTLpc+kkCr?=
 =?us-ascii?Q?wU8H9xWC6RdWIy7s/lQil7P2XxcwW8Yug/+Jlc/0U+Jgwo+FAFTT5Qqli+ON?=
 =?us-ascii?Q?+6VeqqqRy+ps9ZaG2dbiWOs6c7qCry0j4wU+xqXKxaQ31Sa3vngdiRMGhsC0?=
 =?us-ascii?Q?tjtNfV2WInut2xOe7s1QmvEtbwi1OFDB37hbkuGRUa+RniAC907Zdq714ldF?=
 =?us-ascii?Q?KkdPkVoyIKX6xYi3wn5gjIYFHwnLFj3BNONOw++3Dl2rp2KmjpmhlN4sNRhQ?=
 =?us-ascii?Q?hGqeJsabEcQJUhSyAcLHELDikc6y2/xjtCphk80ipetGdT9Qd6yF+KfbY4bi?=
 =?us-ascii?Q?FGW7ol85GWmP3FhBqVjjWgEPE3rPYwpRGBFx2WR5KJ9ahioy2WhZWg5oAs7T?=
 =?us-ascii?Q?t9AtzxjmWIO0+KuxXCjAE2U/Z4YPqWM7HMHmIiXn188EN4BeusVnUE6VNGl9?=
 =?us-ascii?Q?YBkjI9cl5oY0Og4ZA6W6jUu5ioN+ltniNKQ/zt87t3c9N8yJw1Tgsn3DylFx?=
 =?us-ascii?Q?l2i7ug6PH05XrYnXoKDnYX9j6K4VTcVgLYCdo4limvlWHcbAaaLzpgIpMeXr?=
 =?us-ascii?Q?Uw19W6pCeLC7I0KGe1CACJ0zd0qpMpmYhorBs70QF7mLkAc2cYMoK5eesM1H?=
 =?us-ascii?Q?XqCczZXLB2J29xW3omAffojp2DSewz+E2NvuPfutiGS/R+GfUYVaeLhpw7lc?=
 =?us-ascii?Q?AxceRElSjG6KN3L/kuT4aEgICHe03BIMknDq7iaqTMeQ22oI15IZ7G47GdHM?=
 =?us-ascii?Q?vYc07WHYCBsYiO77tC34qCh7qgxY7xsLAD41swGEz1wVRunyZZResU5eTo7d?=
 =?us-ascii?Q?yWrlF5SoPeUwbXycQJ2jPVO3EgHMG5LCetSLE0z0gtuC8GbZXHuyn4wpAjJk?=
 =?us-ascii?Q?T0t0LUkRiI7UH+aUMCoyYpGsgDGdgNK4U0nu71L2FCcJ3SQNyJ25MsXHKuj8?=
 =?us-ascii?Q?WqTk7fW4etRmOgZ/z/IV6WAxe4qRCPLzwepkd3HPhhuoM5++?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2972.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d4d2b1-63e5-4b48-8fc3-08ded2769304
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 04:59:44.7158 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NSkxNyKGbrszIRPjBcP9NFBh9ouNPdglrfyA+D2BcJaFl0xzizURw3owKEqASTkg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4409
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

Reviewed-by: Yang Wang <lkevinyang.wang@amd.com>

Best Regards,
Kevin

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Sriniv=
asan
> Shanmugam
> Sent: Thursday, June 25, 2026 12:58
> To: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu/powerplay: Align get_tonga_state_array() head=
er with
> prototype
>
> The function header above get_tonga_state_array() still refers to
> check_powerplay_tables() and does not describe all of the function parame=
ters.
>
> Update it to match the current function prototype and include the missing=
 parameter
> description.
>
> Fixes: 8c8c4544cc43 ("drm/amd/pm: Validate Tonga PowerPlay state array bo=
unds")
> Cc: Yang Wang <kevinyang.wang@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  .../gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0=
.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
> index 17d5bb62e3db..0d6d711b4995 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
> @@ -1546,11 +1546,12 @@ static int init_thermal_controller(  }
>
>  /**
> - * check_powerplay_tables - Private Function used during initialization.
> - * Inspect the PowerPlay table for obvious signs of corruption.
> + * get_tonga_state_array - Get the Tonga state array from the PowerPlay =
table.
>   * @hwmgr: Pointer to the hardware manager.
>   * @powerplay_table: Pointer to the PowerPlay Table.
> - * Exception:  2 if the powerplay table is incorrect.
> + * @state_array: Pointer to the returned Tonga state array.
> + *
> + * Return: 0 on success, negative error code on failure.
>   */
>  static int get_tonga_state_array(struct pp_hwmgr *hwmgr,
>       const ATOM_Tonga_POWERPLAYTABLE *powerplay_table,
> --
> 2.34.1


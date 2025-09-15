Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E799CAC587
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 02:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58C5610E28C;
	Mon, 15 Sep 2025 02:13:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WLkRNAxo";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C18010E28C
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 02:13:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YALUHjrK6HJOAL1E1eSuzriADXEDkVcyUW1ifQ8/A0O0sxP5dABi4SOZWSepKJDmqhOAiIRbcz1v8TrOySc0utw0TmmOud3PRNcreoaJ/GGxescTRIM2pBBv8iATny/Ml1Wva5oXNEkK9bWra0uyfJthgbkZt1EiGtvADw4LabHn1y2zOvpVhxipOb1+iM/JeqA4Om7Z3Mb1DubCMfFgAw7S+MF5PvBR2c1p5Wq4PlHgyyDYPVYm/eRhwbcNT+PUQNyzbv5hUVyn+73ZauEk8wHxAA5JIpsWxBm24hdPqvdJCv6NqHm8d02pYjOZhWF77h1dQioUbsNLcD7Al4ekVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkbYXKjZCA9kmZ8xXrlVyYPo22G0N577fpZwB755khc=;
 b=rPD0UvNfeORKd1aoWwRLFnFjlDkQ6kMBeEr60jEoxtTFtWR+UhmaLFlPOX9K48ndMlCAqD9l3XCH2xp5c7dqsmZTm9Bjr3yriYcy0z2fXys3f9V/YyRII4YqB22nNK+p3x0NTHl4LwxrExMHkLOgX5fUZkoii1fn2wXB/F0pmefo1QRjp3u/WPGTOGtKwaucGk9hfs9vk3eWIgYTK7CO4vIuItCLY2tpDx0fNZJtqLGqHS0yQ5SYmICwHIVPY8ZdKywfKxEs7gV6eJFOb/kB66Q5FOnK0vyGyQ5kMz1bZQJ8PDod9qfyV2Id5tWVztpufMswTxlgwuerBJ94yeVepw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkbYXKjZCA9kmZ8xXrlVyYPo22G0N577fpZwB755khc=;
 b=WLkRNAxo7uC1Wo8w6LUHAU4lJ5B5dC8b51n7D8dEEQyp9spHSGEMjesS1k4+GU3GKxNW3IFHy8b1FqCdGeU+qBiviu9d149F/U01HIuvQUCjbI5Ci1Go5p8yZJEGPPgu3/RO7AHrO4SnzHilbkRenvuwqdnlo5F/V0aVT4OsA8M=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by MW4PR12MB6922.namprd12.prod.outlook.com (2603:10b6:303:207::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 02:13:37 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 02:13:36 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd: Drop unnecessary calls to
 smu_dpm_set_vpe_enable()
Thread-Topic: [PATCH] drm/amd: Drop unnecessary calls to
 smu_dpm_set_vpe_enable()
Thread-Index: AQHcJA8LMS4fv1Lm0UGcVWEAt6TPHrSThH6A
Date: Mon, 15 Sep 2025 02:13:36 +0000
Message-ID: <PH7PR12MB59975C8172DEC844E31B4D9F8215A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250912175933.917146-1-superm1@kernel.org>
In-Reply-To: <20250912175933.917146-1-superm1@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-15T02:13:19.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|MW4PR12MB6922:EE_
x-ms-office365-filtering-correlation-id: 70beb1ac-611d-4602-ad1b-08ddf3fd7abc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?zih2fzdDYjDTmMlTsDShLTBdktHveLBxtiLHXhTCgzu9sqa3fFEblBFALAPh?=
 =?us-ascii?Q?dZkYcfwS/KeOdg1XTDtzg7eCMWT2n3GB82z+EqvCTy3qlqvBzA1JTEd6OIi3?=
 =?us-ascii?Q?HPz2KOPWxBKRr+IHOVWeETSpO9PfeiREHjZVzuIMiYS1hWui1L6RP5wWqCDF?=
 =?us-ascii?Q?gqBOI8J0Hx1gsfj+I1pjCYcT8QTvoiFGTgTgEnT4xlbz//TsxMWx5US7ykhJ?=
 =?us-ascii?Q?QnqEdN0INsV3BFUseYn8zqX17lAYEALMjScGYg5UnxFZ1fSlMlxTtiZy8Gij?=
 =?us-ascii?Q?LIdE2JXkUwWpnVIXxL+eFFYGj9gTdSFtm28j08+QjOvnWbwGjoFyZEiVxxaa?=
 =?us-ascii?Q?WY89qOWOxU1eoGiMoR44n2qDmpikuIWcbNc+qs2D9Ly26K2aBmAzH/kXibx0?=
 =?us-ascii?Q?qa21K0G2TlHUMjk06ivEbKB339v3quKj8e53Uo7E+c4KlNAs8Orv/RpeKVki?=
 =?us-ascii?Q?pv1myyQLnqbVEI2Ga70vkuMHzOX32e3YU3C5ApYD0TatqYXBQavWhtqI6GUe?=
 =?us-ascii?Q?fO/pjAHPimnDERbphDI9Nb5+tFO0mR1S+RSGwya1N4RKBAzHgZjSDPvD8m9h?=
 =?us-ascii?Q?qgPV91mF2egv9pAXV2qoA2jRpZYokGhp9Lg97SPPUk09jMNPox2CSG3ms9cv?=
 =?us-ascii?Q?u2GELWz6R3Sd9OO9Olak3jVXbyO68ov8YCR9EalYdRrkCerVfI9eL9brM+kn?=
 =?us-ascii?Q?rkKjyXqDXEZD6jHsFXhX8UhEJTOsn/kKG789yWHHNqhzkBhDBHer5D/qGiTy?=
 =?us-ascii?Q?g/gj5kJX2QwhC5F/QzZeEz+AHHU9G1HcPEa1fYAFVJ6yDro0GPPAWFkn7q/4?=
 =?us-ascii?Q?QKwgPDqqrvJHnQq/2eIrcLphaskW9DNJXN/DxdHufPFlEqEZp+roWjh2OVw4?=
 =?us-ascii?Q?C4DIvmoqC82Zj9cF71649O8LIeJah4bV+g89obKRClaip+WW/41eoTL5+2pZ?=
 =?us-ascii?Q?YU5XH+e1xgkw5DxdzO7rBNAWowrnFkGjGcBR9A1sC7yJRgzBGSBBX1KVMW+I?=
 =?us-ascii?Q?XMtnh7D5hnaE9gbPzHqPytpSVoSGkWHqZPfYQKI7zLaF0jRa81MuGF21zsXP?=
 =?us-ascii?Q?dhR8JGli8sdPd8bTc9ro2oJ/Na2uy3oV6QKIs3Vvj6VZZEIBuuPvGzUZ6sDC?=
 =?us-ascii?Q?aSBG3BWPf+BaSgS9GP8R5OiSR2aRXGwxGfi+if4A9IQt1r/mQO9WHg0y7hyX?=
 =?us-ascii?Q?e+Y9MMGPskrRqNy6uliDZI9Btf3oZKX7fetKSdn4WTqxLIrE7fIA0/PD7C3S?=
 =?us-ascii?Q?x0ADBHsIGoPYxxBjiNFp2bWsfcT10aepiHy1b0Au5GNNKYdEX5jvzrQazRZK?=
 =?us-ascii?Q?kkR/jb2MPdtIcP5xR+N4wywOTelzc94mXTqpAgaWPj9csMyU8YbNyMfjr3Z5?=
 =?us-ascii?Q?qRqKBPHQpTorp3CBpDsE1PofbTkPVaa4i7hxHutMf+ah0EnTfh7xVPPS+r2z?=
 =?us-ascii?Q?ktqJtfasYDnBLNyolhLnaqw7A1A2PvUCFSlCmUvlu4jaMpL0AfFwNw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tKZMgbDjaF6uZS7EZR1ux2ZWEDiCKfy3mXUm/Z9CbCT9YEbMSRRUoCQAohQ9?=
 =?us-ascii?Q?cbbruyvohG71VJmM8JpUUjjgPonJmOIWPsMavrmFDlZm87WA1NCRAUXjW3Yd?=
 =?us-ascii?Q?N6Tgpw/2BMjBb2vk6Ri64zlGQh/P0x+UDrWu/3aHTR0uLOcMSjtntUvwE8u6?=
 =?us-ascii?Q?LbNJYec960OgRhiHlM/6gRlhfhvYpv2K/IgLRUt31mrLuMlM11oiIW17tOqY?=
 =?us-ascii?Q?JXTmS8MgMdE4KXjwYa9zX0pAva1+j41+2U7vR2Qc+hOWVMUjljpsSUjzPFiR?=
 =?us-ascii?Q?2k+te1xjs5n5RXEzDPCWoYgTuUaqnUqgk1vht6AmNsjI19TP/SlWqc5A9eO9?=
 =?us-ascii?Q?P3Fh5HL0kOKyizSpeLO3bBwsx4lCMcim+Whr8UZv5ZwMH2iKcmESZAauUASU?=
 =?us-ascii?Q?JhVScvXo10E0a2B2PMlsq4Jpnnmz0merffGYbb2+KEZG9x7GRasFIgHxiWTc?=
 =?us-ascii?Q?6e8UbagxTL9T0n6div9KlMhIEWGLgmstekUxlwbtTpgk4vIox2UF9vnqnPtw?=
 =?us-ascii?Q?fEEcuuGh7UVQyrGZzGE/ScluxlnS7Is+Kwrt74PDH3bqD+GXD+/FPlHjDzfv?=
 =?us-ascii?Q?CJPR8NtZupQaNY/QAYmPR89bKq6Rrc6q0EguKiZt1zS4GtxFLCRWGZnfdBWQ?=
 =?us-ascii?Q?y+Sv8L5pFqcqvnFzgEfskXVfvEbz3fzQL3XR0E9UEDYZbX5oi5HPxDTQ5oTO?=
 =?us-ascii?Q?2QgW0Va0dwZ4/kz77xw8q/Vxk6+N2J+zAE86c6CYvT1dYecwxagW608vgBI5?=
 =?us-ascii?Q?odS2UI1i0Qq4mjPVZfzEpVQ8bX1Wx8gHcRD7JSGdxiO1x2Tv7fv1asadCbny?=
 =?us-ascii?Q?9qdwO9i3GMnzEBA4CsQoyeCEaYsliyOx6qwXEHD/ezWYflIJ8ZNr1rvziQms?=
 =?us-ascii?Q?bKJn3U36SJ7lQQXOoO4XanzerCCTdVOWKwlWFYsUXwF3IJeCqBSOwHQ53Wbg?=
 =?us-ascii?Q?aQ6MhoKR3BY2f27fYKwwEvVEaAhJazv2XwOGS8ea6hpEQy5a3gD2lGqP4+43?=
 =?us-ascii?Q?Uc2VzY2ueIainxCb2ADdx2KyScyDqhnvkqwENyFeZwDrk6vnZBw3+FidW6+Z?=
 =?us-ascii?Q?2y8kB4sy9KpmgEzONgPtw6ueO1KNyb8Cnztwq7xzScNJcyiFkfCge/tdEPxn?=
 =?us-ascii?Q?94MlfzmkzzM4XTdoWlY67gTf61yb3ZfRQ/gA0RpqVZVSN9UX422kxOqhjKMW?=
 =?us-ascii?Q?0wFT1O/5N9einn+VRTBlmoocbk0FeX8PSdK/0/2BD+LK1sDccP+6k3dev4S/?=
 =?us-ascii?Q?Kyg0bd9TooYc89WZgYnxr9emXkrMe+xZ0T9jL5ToaNtyw/eYZTkzTJbi3WZc?=
 =?us-ascii?Q?oebvNXREMhjJklnE8sX25Eth17Cd+qT3cTVJL6STinviKxI2RtG2IPkJqsaF?=
 =?us-ascii?Q?gcMrkmnDmH1mKUwqW24cLB1irHZMeXbQZzDnwQFVMdoCkJ9cM6zEplXjhnb1?=
 =?us-ascii?Q?Q95ddTXryTgTtoDIRYdXf9HW9ZbnQ0gw9b+O50/WWsyK4Jgy4G0cjkJZLAYW?=
 =?us-ascii?Q?n754FHJ3QqF6U1zZvrajXJA2pCrCBnTlWbmTn2d2JgUlr4g6RfUkqBhCsLFB?=
 =?us-ascii?Q?MBKLKU3TlXBMy8iAXio=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70beb1ac-611d-4602-ad1b-08ddf3fd7abc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 02:13:36.7051 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2LJh0GtCQud35m5iCnwz3stXT/uCb0rX32t0XLJc7ft2PNNTE9jizphPZLrVAIB3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6922
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

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario Li=
monciello (AMD)
Sent: Saturday, September 13, 2025 02:00
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello (AMD) <superm1@kernel.org>
Subject: [PATCH] drm/amd: Drop unnecessary calls to smu_dpm_set_vpe_enable(=
)

smu_hw_init() and smu_hw_fini() call smu_dpm_set_vpe_enable() for APUs as p=
art of startup and teardown.  These calls however are not necessary because=
 vpe_hw_init()/vpe_hw_fini() will call at
init/fini:

```
vpe_hw_init() / vpe_hw_fini()
  amdgpu_device_ip_set_powergating_state()
    vpe_set_powergating_state()
      amdgpu_dpm_enable_vpe()
        amdgpu_dpm_set_powergating_by_smu()
          smu_dpm_set_power_gate()
            smu_dpm_set_vpe_enable()
```

Drop the extra calls.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index b47cb4a5f4887..49e6a2266136b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1896,7 +1896,6 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_blo=
ck)
                for (i =3D 0; i < adev->vcn.num_vcn_inst; i++)
                        smu_dpm_set_vcn_enable(smu, true, i);
                smu_dpm_set_jpeg_enable(smu, true);
-               smu_dpm_set_vpe_enable(smu, true);
                smu_dpm_set_umsch_mm_enable(smu, true);
                smu_set_mall_enable(smu);
                smu_set_gfx_cgpg(smu, true);
@@ -2104,7 +2103,6 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_blo=
ck)
        }
        smu_dpm_set_jpeg_enable(smu, false);
        adev->jpeg.cur_state =3D AMD_PG_STATE_GATE;
-       smu_dpm_set_vpe_enable(smu, false);
        smu_dpm_set_umsch_mm_enable(smu, false);

        if (!smu->pm_enabled)
--
2.43.0


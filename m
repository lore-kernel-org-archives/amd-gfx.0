Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126EFEB64DD
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Aug 2023 05:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE51889EB1;
	Thu,  3 Aug 2023 05:32:11 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0D4889EB1
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Aug 2023 05:32:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDlm2vM2HqNp79RHXUhiX6Inry6HEh/pU6QIzkIzsTgwHpdLirwmaUS03G1BjHaVMptoe9WxEf915fTA/1n6TwFsu+1/YbzsvTVKv9Q00lRVoFznK26opvYM0k/n1Pbo8DEhE7WMOH6+GvbLavS+ssqub7R22IvUnMFsq8lE8vLk1aRs8e+ZWIXL7p68+qsEQyG0dTs48kmUpLnn4YeUkOYeguZlc5mBHT/0161NzIbOuRNQi2NgOvRTo29ZRbjxA5DlzgREJyICo2xSBlxUIr150AZqjTZgrOpcos6w8Qub8t/AtSJj0qsOUh7/uRomCWY5aDQoMGtrhXA6vhj+8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiY09wnjZ1T0GZBao88Df/8Xe0okshCqH9mN/g94/oM=;
 b=CX4eRC0u8Co4tOLEaZ6rBvBnsLyY91SyChTpTowlkrWZlbyCHvbMVVy+mZKEXS6Eo1T/FV7Vl9pT6Uwy2i+zmcdew9Z2lYjEblCt86ZQzVyuad4uffQ9IWaeHhaGTDOeksaAca4fYUOpiHBAQ+BhFPCist8Q6ojWoseys4uHwoYQtzyc07FWgUz+NNfmX7iZ1ffF1hGnttkDMYs59fvTjGxIsXxNP/gib/nbEpbi1BwiynE4uN3kooSQaqVM4ig3i36dArRcTr1vOlPY+vpg9ISklhUL+Cm2+Rt6XTXIQ3LYkix/hXNHewALsAeVTS/7lsFrOvq05OPttEZQV7NSOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiY09wnjZ1T0GZBao88Df/8Xe0okshCqH9mN/g94/oM=;
 b=zYEzWtNIpp21tu5QKu7x3opho7SO8kn0tt5W75tjHRgnyMcG3aBJzqk5m3sAVcvFzd12ydB+XAs6w+W3CXhuhCODiJLXquJTU8tjsM+iyzSfy75gy7Mdo7ENs8f/bKu2bcZwehT3hFoX6xWrIn7GgbO5zKHSJWSDIjmU4GiPtE8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB9276.namprd12.prod.outlook.com (2603:10b6:8:1a0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 05:32:07 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::4d17:c920:ea2e:3b2d%4]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 05:32:07 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Fix SMU v13.0.6 energy reporting
Thread-Topic: [PATCH] drm/amd/pm: Fix SMU v13.0.6 energy reporting
Thread-Index: AQHZxP25PArlZjcg+kCL/9xxCchJb6/YDXUg
Date: Thu, 3 Aug 2023 05:32:07 +0000
Message-ID: <BN9PR12MB52575A9BBE7A79AA67816A93FC08A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20230802045617.238049-1-lijo.lazar@amd.com>
In-Reply-To: <20230802045617.238049-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=a97d3204-4c69-4716-bb8d-759b6b27b307;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-08-03T05:31:14Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB9276:EE_
x-ms-office365-filtering-correlation-id: ddb58f59-f21d-4112-c218-08db93e2fa6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vCy++0lrAA3nPxvPIje//ufAtA9JZw64ulTM/ssgEXb/rbWXaQzgDVjoyAPVSJByOLooAnQiJGdFW6Zfc93MFhcqFYALgE0ft7GnSZl2bifNqwplCPMA/Xk5/cXDrEv7bGdDcEmz8FBPOmDhWfozPxRmGEFKl3QmBkze1wx5Q7ct4MdgRpRs2IwP/863GyzrhvVsPtGZY3Azndku+XiOyuXszfG/eFn/JLsNfwzpibYqnw02uKMvW2z0X6TPRKi+ZuxvjsxqwwH0ec77ohUQKLddf4YVYTnPhVpnDUtj5o2CzcCKMfJi8vbyN8GNgnQEBAS+aEsODNGX7hHtiG208ngv36SX3prR63aA31xhETzTmaLFVBKHeo46GX/8X6Zi9Q0rVIB/8UUY0AnoUMu3R+gl8BLtou9F+AxdTUYI0hnDMLZQq7nC/9T3ankQuR3V8ulmgGOdxh+EFU+kyVPeC1t2rKkW/aURVUkIuBsu+2S+TWE0HVd+B5GlXOZotkK/TXksm+kfdxWbQpd4YxA0EWoMz04+fzCjUA0AxG8Ra2kWDpE4CqBO0Xvc3Y3IWmVnFsHHM1E57Nzcn7Zj7ql68OwUlIqiGxhbzbD16uS8bzniaqFKAdKUwaSO+gg227z1ixBhFZWZ6sd/qO4tFj+Vbw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199021)(53546011)(6506007)(26005)(186003)(83380400001)(316002)(76116006)(2906002)(66946007)(4326008)(64756008)(66446008)(66476007)(66556008)(5660300002)(52536014)(41300700001)(8676002)(8936002)(7696005)(71200400001)(9686003)(478600001)(110136005)(54906003)(55016003)(38100700002)(122000001)(33656002)(86362001)(38070700005)(197533005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kpXaYImXW3mcwO/xOz+mnJGP3QTwfFFsleM6DUYX4msWsQzvnKkzHMR0XI+W?=
 =?us-ascii?Q?ryKcZxwelkd0Sfk8qj5IYCUgin1a+f08vEz6tx/r7hg6Pij1y2e6y/1un1pi?=
 =?us-ascii?Q?l2Z0HOj4UMC8R6qb4y1UzQDREMp6pBSaa3p3sE5ru8RxjwaT2yiso77tnvJE?=
 =?us-ascii?Q?PULy2nEczvbrAGH60DMdDO9zaEOvp/krNCK2nDVyS2C3/5FIrugzjSQLIiS4?=
 =?us-ascii?Q?/UtWBHBPj2ImLNBYWXIpvQooYKwyLImztKWA40skivk2yjxr6KxY4C3GmNSD?=
 =?us-ascii?Q?gHbH67fJG3rNtzxVCWeCVipXy659XSqcLNMrcM8kAikiisfgYqp1lPMjyZoQ?=
 =?us-ascii?Q?cW1WletB8wBD2HmJhenpFE6I9rzqcVsuxRa4Hu05BoFLwrUl21I7nzMmWgc/?=
 =?us-ascii?Q?O6kIyL6Izpm+M135qH8XvCMsrGTBwc+v2e9fDLpQS1HePD20HTTtIyLjUkm6?=
 =?us-ascii?Q?uCuGSKlcGzNma9PRdsTZn6TtUJE0ROGxs2YYTBi2a/4FVdT2EG3r9U/YJPw9?=
 =?us-ascii?Q?Jt5WyK0MSc+t4scA5K3GHQd+/UQvVgwadIKOznX1e4fcU6PLZeIp7WWxNSDp?=
 =?us-ascii?Q?UtHc/7hUEzJwOCJXUV0aZ4JhKOk3hYDzx8TGA8JypY0gXOlfMWOSU4mJG352?=
 =?us-ascii?Q?qVJp5OcAGxNZOljTj9LS2/a5T5YO1FATICjQ3jnyPLxf4wcTup7nlN2AFIai?=
 =?us-ascii?Q?YXwIiCd1cN3IXGBFKH3/9W+R65ZSnNKjDTEyfpViOUkTdIsSt003AcYNyWKT?=
 =?us-ascii?Q?5DXLrBSSXgBsP+xjjRIWT6zZ0A/5daaZR0axdbJLor8XIVDVTAEhUdMvvDly?=
 =?us-ascii?Q?cR0twvz9HU8I1vc+1RMXk3IWjwJwCBctoL8JqrGinFpS2CdB0HsigG1joetC?=
 =?us-ascii?Q?b/H2/bCf4kZr2fusXyfdsBb+/P4vc78Hqk1pDc7UOVeXu7yQdvM8yNF14o2j?=
 =?us-ascii?Q?t93xP/ga5XMytZ6GQV7pXExihG2IoN7KFDckmLbzKnZ0uUd8x/IGCnoGA8Ki?=
 =?us-ascii?Q?2kCBy41FetW/YUBc5D22xDFGBGr6M3utR0WXDJFqAMiqf4EaHGNmwd8ga6N5?=
 =?us-ascii?Q?b1fqXgjQoipPu0STrHrjUOrCkmMCG8VGr0afbeD3HRegwjEdHqgmYeTP3z4U?=
 =?us-ascii?Q?+i9J255YIxAYnJDqI+qII/fcSN95gn6NH5z+dE2hVvVgsmYrMATb0JEE1f+f?=
 =?us-ascii?Q?Z4iPt4C/+cHeZGIjrr9F5y86f9bkyg37JROMJtyYr/Zpei573PDD+1HEsgME?=
 =?us-ascii?Q?y5L2YcQHY4px0BZ0OZUnjraNCeqHYlRPofSE/DCVOajWIWdPJAyGNSySkhrh?=
 =?us-ascii?Q?A5EOM38cWHF80LYwGg3z3gWc3sXtwc3WMyrbCWeR/VZmK95l8s7Q4zvrXfyS?=
 =?us-ascii?Q?AJyaeGpvPmisYzWaAr2DuJlZMpndYzGnLPvORN0RGQYQHdPElPVRWznGrW2r?=
 =?us-ascii?Q?jfwRcJIfJGxp+MBXoY/Ea7K2De1XsEcGqknGW7yfkOM9g5d4vPl70J4hSyj8?=
 =?us-ascii?Q?Slhx20ZxIXdM0u3E/drHHhJv3FkdKoRyIUhJ1V1qEqSo/97i3thK2IqICICc?=
 =?us-ascii?Q?xAWaBiBNb5O3FplnKNk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb58f59-f21d-4112-c218-08db93e2fa6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 05:32:07.5964 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZg40kvLZl+GMvtaVs4X2NUrw8cqAHBTuuANdhDfSS/3ayVp8s73w02CADdC2NG0tXpqbbTBIhF3gXiaAhl/Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9276
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Wednesday, August 2, 2023 12:56
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amd/pm: Fix SMU v13.0.6 energy reporting

Energy counter should be reported in units of 15.259 uJ. Don't apply any co=
nversion.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 00eba3f950c6..90e003fbca81 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1965,9 +1965,8 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu=
_context *smu, void **table

        gpu_metrics->average_socket_power =3D
                SMUQ10_TO_UINT(metrics->SocketPower);
-       /* Energy is reported in 15.625mJ units */
-       gpu_metrics->energy_accumulator =3D
-               SMUQ10_TO_UINT(metrics->SocketEnergyAcc);
+       /* Energy counter reported in 15.259uJ (2^-16) units */
+       gpu_metrics->energy_accumulator =3D metrics->SocketEnergyAcc;

        gpu_metrics->current_gfxclk =3D
                SMUQ10_TO_UINT(metrics->GfxclkFrequency[xcc0]);
--
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E953C4345F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Apr 2024 00:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C60110F921;
	Sun, 28 Apr 2024 00:44:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N9mnMRSt";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D4C410F921
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 00:44:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kR58rCZyIAasmwpkjE0aM29Oq8ICIBCQpOQDAAOcRI+wwu2SIvojbH0SnLBL8zYEF+6w44+X7c1qG8/2YAcmZk48MlXAlMU9KdEvAJaTpMPbEjTDxSgxcjtJWuGbeZlWUtDNTEyNhdLh3O7neBMJ0QN51z9KpC60vBUFPusz9IEySDv3fVB8F86WWhPLtRUcJvGYCYrbVxw3r74bDm6Ky5zczRiBuGYQyqX8mlQoXv0GX4So/HL1AXJ1+cIW06N66rMNzjcVPimnqAoK3EeB6FYKtwezc0n6B3HLKkiNQQESf9vJEK/kxt655ey3q13iIPlOB9mgywzyekXDjyW8eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yP2IJWDbV7wrnzLdFsz73CnurOdXn0wUEoH7yJscBpc=;
 b=aaNSe93ufBv6Azx7D0fojzVtMTqgonR1YAM5SNCaGoy4pG0TdIXdKTMWq3XYhwtjaQvXAbPp2WArrdrUstbZ2TTmIn7tz0Vv11XEhSUClnDCqX8jzWYt1yKFJd5XJfhqkoOIcMPR8IxA9C/vchUA0cD7iJyEfHBTE5zfW1K3lxA6nhhznXqoWQ4Synfybum2+NxMmBTtG/x9cmZCu7W/qIVM6LS60qcQyk1OLOV/iUiruDlUbRIOd7TmT3XgHT9ODMxrJD/qawjrGZs255hdkvEY6APKtf+VO8MYRq1JilLRpDut9cQ+MUIOwCEPXjkH6oum15rXibV2fL4fDMFyww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP2IJWDbV7wrnzLdFsz73CnurOdXn0wUEoH7yJscBpc=;
 b=N9mnMRStBsWle42nSxJ+OMmGFLFkpZgQ9Z2OMu6rd3LyNZioDzSYMQrZ6pmcK6tTsnE776N+cEgKHmH4hEmebEzeudV487gr5nY/nDCR5PADin1lNUE612dVifNeIaOyzYJEJ/VXTwIyEvGGpDhZHLmu2kSoOKCTnpEowcOkEWw=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 00:44:07 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7519.030; Sun, 28 Apr 2024
 00:44:07 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
CC: "Ma, Jun" <Jun.Ma2@amd.com>
Subject: RE: [PATCH] drm/amdgpu/pm: Check the return value of
 smum_send_msg_to_smc
Thread-Topic: [PATCH] drm/amdgpu/pm: Check the return value of
 smum_send_msg_to_smc
Thread-Index: AQHal71nEW3pt6NBEEKoHtLZiCjnSLF82icg
Date: Sun, 28 Apr 2024 00:44:07 +0000
Message-ID: <CH3PR12MB8074D9EDCFCC4D288C436ED5F6142@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240426093724.21682-1-Jun.Ma2@amd.com>
In-Reply-To: <20240426093724.21682-1-Jun.Ma2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e3621983-5773-43e0-955b-ba6f0d9e7433;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-28T00:42:10Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|DS0PR12MB7702:EE_
x-ms-office365-filtering-correlation-id: e24ce8dc-3182-43be-59df-08dc671c4fbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?KBf+6dkvT4q3TPA2dlh3mspFR3RbTe5RAsqUyf2JcwwSk/ELA6ivs4MmvK?=
 =?iso-8859-1?Q?/6E9JRv0SdwdwFdM6pawpRxZH75h/v+N9VolOZUTSwb13DnoBxAsab4UzU?=
 =?iso-8859-1?Q?T+Jim1h88D9nRwuqWQpj31gkekf/v+Q9q72oagydR06KVaqfE18vGw1U/e?=
 =?iso-8859-1?Q?FlGPLDX8xdIWrHk94fVFUFErBhYtbYT5+Q4fPDcLu/MENIfAv03DT7CgFs?=
 =?iso-8859-1?Q?0rDQRzd7GeoLlV/ZEjgX8G4sWbGgYHLi/rV11BGkBwe0nbFS4kKrQ3SOR7?=
 =?iso-8859-1?Q?nIz5wdBsXOhvr2PacmVtAQtVStkc1o0kHYmSy0bdpVz/pisnfXqe3da3dC?=
 =?iso-8859-1?Q?3xYnxPhrH+onDmqy/5EbudZCSEDgBp5IAWI/Xm9YQ5HSrDrd2wdQf+Cabv?=
 =?iso-8859-1?Q?wYX2YzL8iUr91OkAHTyQQzzkxmLKa3LQSRICm+zlEuTuTMi8tti84jAdGB?=
 =?iso-8859-1?Q?z6LVGrvU+IuuRtxhKVqMkmVMIg3ZK001cexM2Su6UiWA9spQjj0vy0UvXU?=
 =?iso-8859-1?Q?sDkHp/UNR584BUgEAehNRnt6Pwobfa9chuk9npAqrictqn/T/DAtC7BRkj?=
 =?iso-8859-1?Q?zdPRHLQEL4r33Q4eXEiw3bn8nTxyoa/dAER3l1l98D9v1mL54Z4ckbR8C1?=
 =?iso-8859-1?Q?SSPsbAM15a65hZXADp9ZmR0l4mqJyGzTc5lLvzO0RKv+Jd3ClH2x+45Vmt?=
 =?iso-8859-1?Q?PkgexEzOoaMI5Agi3QRHgouV/luKeed5XyBP1eSuC4tJBmx2lg7g3wCCPQ?=
 =?iso-8859-1?Q?7S5q4ix7nIW0GUFhLtQDDs0jIoxjl3LmUeXhLD9s/Rlv7d3e3jY7UXtc7v?=
 =?iso-8859-1?Q?oEJVKGXPEw9Aw4uO19pgvON3jApjffzzDYoABuQKn5+XcTNCKW4lO3Cn/r?=
 =?iso-8859-1?Q?81pvXl7SCen7hjhHjONGzW94xHP5Vt9/CLg7i9SEVW7uGCSV49WZL+vXWY?=
 =?iso-8859-1?Q?6q/ZHKIVEH6Fk9JBHEkzdZdq8ddICgf1ISRqhHkBo4sHR/HsjoAMkUSDYH?=
 =?iso-8859-1?Q?VwNik54v+RpB9TU9kt0I88nCtSKMqythkQYecsdsHfmRkVkVgbdFK/Ok4X?=
 =?iso-8859-1?Q?DBPnu4rdaFWPl25B0GBYj/touLQbQ/CyEf3QQAwTXdd95y65mNFXWX3qit?=
 =?iso-8859-1?Q?j4/jg749C1+ER9gaMhhrqeLPio8QZWaJwMwPnsMrw8aSgr7/AhEauPL3vg?=
 =?iso-8859-1?Q?g7aseGz/K89Ekh/bdObGQ0SEgiePgNAuH4L/3y1ro8TWH0zgQrtMrUr4M3?=
 =?iso-8859-1?Q?QHsQHB2xOwFTSSmx1mDDVidOXoeJjChvxji8cxeBhuP211ksqm/W9c+m6t?=
 =?iso-8859-1?Q?egNx+3du76DlUIc/gPXNX+avYmQvaxvmQo5xPw+R3X9YUHbUlEhKXUERBr?=
 =?iso-8859-1?Q?aVYTmdID9JI267tXeZK1ZoJvPJ192AKQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kzdQVM8zGcwu0DNKH14eMWO0F9JMMLreRJ9NXt4VnXJ0NgywrQ7Bp/XYbD?=
 =?iso-8859-1?Q?ZTgMnQ43JClOdy/pSq7PDJI950X7E2ZoTbbFQayLSyFSeGkIgNDqwQObUu?=
 =?iso-8859-1?Q?cQKqUO90xLmOqj0kSfvo7F9mwdId5BR8ktlOuvhgvQjeshLWhaOregMI/K?=
 =?iso-8859-1?Q?XpT0DaFdXQfHgDM4x56sNloKPl+UICrZ9cAoI6MNpEPALzt3ykTskhkebd?=
 =?iso-8859-1?Q?7TMfChMlgo7uRstQo58dgxejCKeTsQR5yt2Z9R88eAKbggG975X5JMaLaX?=
 =?iso-8859-1?Q?gCDR95xRLl77E5LKGEouV2u2L5orpAZiLCdJcaITyArnP8WwJ75IeFdpaQ?=
 =?iso-8859-1?Q?qgwGfjM9pVMPEXTsCWuWK+PEXRyZTNcAlsrnVzAYhKHM8wDtGg9pxE0H5h?=
 =?iso-8859-1?Q?ta/sUsNGFUj6zTeirLjNoxyMtXehsl0udiEvX5pwfGxEzYwwe+gcZN8wr+?=
 =?iso-8859-1?Q?YXH0YWOQ4d7+riLItaRdrY6hlpukKN7nEv9UooBujRI+Z6rFn8zJ3SxwZ2?=
 =?iso-8859-1?Q?5LFR++0Co2DuJy+3rhekNa0+2aayTi0kckEDNRM6gp910Alyk4P9/dZGh7?=
 =?iso-8859-1?Q?47d9w4Jp2Bm00ypaLuJRqmMaNFJ0K3ujPddHdU2q/sXiWJntCNRYFGNV1x?=
 =?iso-8859-1?Q?gjQqNm/ePWK4JTmEUJwHsCMxUDEnh8UIHiA6isp7smLQv84X/Pu5Tjcs86?=
 =?iso-8859-1?Q?zLXCuLV6TYmp5QJKNekVnoElqQSr/ZFHqgLxa5ccmsO4k8ThNTsaZqAutO?=
 =?iso-8859-1?Q?mtImjtM5TBebgoX+nncUacMZaB2z4RxFDG+NZF/rgYsa3KywDvip6Di1WH?=
 =?iso-8859-1?Q?B6HwwijJ/yxCJjA/nmw1mBOSky5LHHMANWgzA5TzavoW+EW8yF6v1EassW?=
 =?iso-8859-1?Q?CadXC2kPaX7BJJemXIBiJovfAbrP0v7hgNGn2cbnMn6z+YdRrlhlTyPQ05?=
 =?iso-8859-1?Q?MtLKO07C8ZoYZR3zYhSBzl7IbWsD2fqElTWP5hApDz1dTwIKpf67CIpu3U?=
 =?iso-8859-1?Q?bm22K30vhEirrWsG1bbQ8jz8dD2YXPs9ly/Ohw1G5aELwRon5zHd7rE/R4?=
 =?iso-8859-1?Q?6p2wSI0P5b0WVb76lYAyrHGXaILzEm2VlzBknMhq0pbccKuvxVAD9OiKAP?=
 =?iso-8859-1?Q?fRajBrE+b/n6q2LyUTFhEW8Uc+WI26WbGINzfWWzHCdawW1dNnfrrgyJsx?=
 =?iso-8859-1?Q?6g2rD4zWxQ6YZsvZruMUKrkSLWjwjikOnHfku/CyzNZDDgUE9MitZfBh9E?=
 =?iso-8859-1?Q?IBwYQQjN0qtuX2Li7iMQ/Xn95Hu9EbeI5wCWF+8tu5sdTSokj6QxIGNias?=
 =?iso-8859-1?Q?qi8oShJ3tgNeao1lG8NnLi0u59mV/bz8KGjGlk4Jayw2GkDKki4yJ9R9X6?=
 =?iso-8859-1?Q?hDnIVbA4xE1EhaE1PMF0I7ZqNscWJjqS8lV5TIuhlsdjijCNVve7IHHtEB?=
 =?iso-8859-1?Q?Y78PgHAPAKAJGmXBHZyWXZm5INpYP8J4VluGbVMAqFYwS7y5pzlNg65aa+?=
 =?iso-8859-1?Q?rhlVb0LllkNaH/gTnXCwlFNvgm3QK7s6EHyIIpAmTEBNzBitVSankce5jN?=
 =?iso-8859-1?Q?40XL3ktAgxB6gPQJ5usH2N6oeUkP4HJnPC505tbzeMy9Zs9ILUOsOC7LFU?=
 =?iso-8859-1?Q?5m4RUFt1RTI/4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24ce8dc-3182-43be-59df-08dc671c4fbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2024 00:44:07.3977 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qMC0KFTiM6HjOxbmgtjYBYxGASUMIZn1AqM4tLc6YQVfngtK2x3YvlXnc2GIlAadc78HK5Ku6A60I6JmM5rKVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
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

[Public]

This patch is,

Reviewed-by: Tim Huang <Tim.Huang@amd.com>


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ma Jun
Sent: Friday, April 26, 2024 5:37 PM
To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.=
com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Ma, Jun <Jun.Ma2@amd.com>
Subject: [PATCH] drm/amdgpu/pm: Check the return value of smum_send_msg_to_=
smc

Check the return value of smum_send_msg_to_smc, otherwise we might use an u=
ninitialized variable "now"

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers=
/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 02ba68d7c654..0b181bc8931c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -1036,7 +1036,9 @@ static int smu10_print_clock_levels(struct pp_hwmgr *=
hwmgr,

        switch (type) {
        case PP_SCLK:
-               smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetGfxclkFrequency, &=
now);
+               ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetGfxclkFreq=
uency, &now);
+               if (ret)
+                       return ret;

        /* driver only know min/max gfx_clk, Add level 1 for all other gfx =
clks */
                if (now =3D=3D data->gfx_max_freq_limit/100) @@ -1057,7 +10=
59,9 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
                                        i =3D=3D 2 ? "*" : "");
                break;
        case PP_MCLK:
-               smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetFclkFrequency, &no=
w);
+               ret =3D smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetFclkFreque=
ncy, &now);
+               if (ret)
+                       return ret;

                for (i =3D 0; i < mclk_table->count; i++)
                        size +=3D sprintf(buf + size, "%d: %uMhz %s\n",
--
2.34.1


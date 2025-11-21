Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A95ACFC50F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Nov 2025 22:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B67F10E916;
	Fri, 21 Nov 2025 22:48:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ho+OFvl5";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2445F10E916
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Nov 2025 22:48:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lI+gpMxOFbsLAXxMxxdcN0EfJBBnCtXZQ92nD4KfXdeUG2mKpxF1yLnRcbP7O07CSyYw8IOZK0LMxjC9x2VdtjxbAEtoifz3FP+2nD7DvXQ4Nm/ugFWqdPn5O7OpFzaVDM9qAvswwiGBVcXZPIkf0hXAxhwqJS4RWo9eX9Tmu+ogTawa636Ktmv/I11QzA5SpyGn79wxLhNw4nAzI69WeU2y7yytO1U+AZ7zoYPSILnGUPf6M0HQ0Jp046Xfnig+YbvJocdy4NWSrxG7oojyxJp+Jz9y8o2IarL5P+RBkWRLQx8XAxAmnf3e/5dxJYiU/YNoWp9zJJ3AZW7uOHMTfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pM/OEZ4jDUn6zhCw79/gh7yrOwfv3fyn7Hd67jrVC5E=;
 b=N8/HqpEhIf6uugpQe+2Kn051f3omlP1IR7DrPkzhzKbEjKPXZJwSDHiOKfPcPjeVG05F0Zo495nN4+456Iu58WT5Wqwy8z/XY+Aw9mgdniDJv3TKz+c84kqwgdd69zvgFqYFn9rJ5LZag2vABcQyeusDWKt8Ekx2Ift+k68wI9wbJCqk28oyWW+v0/di0n/PrQBLHJEbNSzpnJuLsP5NpQKg7K9l5lU2m0LbOONWbK+nxcUMQUrAfgQSSs/vp7gcni5qUEo793zqtClmo0v6bMxX7AMpk+pSWcgoQmHIVL13e8yFytOHNRYhjuEIyvTZ69/wZY9Ci94NRgUZJSx/Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pM/OEZ4jDUn6zhCw79/gh7yrOwfv3fyn7Hd67jrVC5E=;
 b=Ho+OFvl5f/hYuFiNStxHgwaH56x3+GUGFjWAyOzyiiODTRU2iNe+yXfDj3L2n9fIjTFuTfM5jI/5tJVndSBnTdNiFAWdOWEWejsf6nV0cISHFqKr8KCzOmN7B1FPen3V9LQUJ7NAwbLXyLfH0knawW6StCeZQ5N/2bIhqzD6wo4=
Received: from IA0PR12MB7675.namprd12.prod.outlook.com (2603:10b6:208:433::9)
 by CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Fri, 21 Nov
 2025 22:48:00 +0000
Received: from IA0PR12MB7675.namprd12.prod.outlook.com
 ([fe80::b2f4:4979:b048:3060]) by IA0PR12MB7675.namprd12.prod.outlook.com
 ([fe80::b2f4:4979:b048:3060%6]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 22:48:00 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: assign AID to uuid in topology for SPX mode
Thread-Topic: [PATCH] drm/amdkfd: assign AID to uuid in topology for SPX mode
Thread-Index: AQHcWZlfDjsl+/s9YUSlyQAkRiFNLbT9vH4B
Date: Fri, 21 Nov 2025 22:48:00 +0000
Message-ID: <IA0PR12MB76756021068F6EA7917069538CD5A@IA0PR12MB7675.namprd12.prod.outlook.com>
References: <20251119211307.195615-1-jinhuieric.huang@amd.com>
In-Reply-To: <20251119211307.195615-1-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-11-21T22:48:00.119Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=1;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7675:EE_|CH2PR12MB4181:EE_
x-ms-office365-filtering-correlation-id: af446c38-d10c-41d1-38e6-08de295005d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?RUdvxO4vKBrz01+VPJ/M/vSS5MLGbwF9znOAaKAcKRnPewUe0FlH0smeJC?=
 =?iso-8859-1?Q?07XEHALIgof7DJ0g1lqL1u+auBKX5FrEvuECUN1Ho5HJNUpmzzfeUYw/iI?=
 =?iso-8859-1?Q?RHwIi28tbB+Xg9SS7yYO1VfAdfQB60KPugwIctWbk/K/B8u8SCnvU46lea?=
 =?iso-8859-1?Q?ygf7DXP1tdSw/TtRIWY8ycaTyV95DkrdwOkqqMBzCYouEYbcQjnnEQzez9?=
 =?iso-8859-1?Q?UAwkpgHjbpKXKJRsHq/5RdwTcfHbXw2zINkNP1e7tiIJbRoi5O/vOWVVI/?=
 =?iso-8859-1?Q?y7XdAsWCwlcJBMsL9L+HMrN2ktD2jdCcuwCbSvzJwLUvdYaYTfhhh+nHow?=
 =?iso-8859-1?Q?uTtBXLG5g9FvQIogtbjaSeQT4L234XWYndecRxfRsR0Qlh3plzOguWPb6d?=
 =?iso-8859-1?Q?25B7yqzwAD9O8HqqQbOpCes3nQHzB0k/mW38vJjQBHYJurfuWquEB+Ghla?=
 =?iso-8859-1?Q?iP4JuCc6E3bLVdVo/RcruVvECQB0yy2cBzXR6+CESaU8w+6CtOzVWxkwON?=
 =?iso-8859-1?Q?66YD3eW78oupR8X3bnljcjgavfA/EDh1ORsSioFVWfDTe7bD3R3UyXMmDg?=
 =?iso-8859-1?Q?/k6JBnx+abuYWvzeakrhesNOkDOdv0aLPi7cEMzumSPP6uBNXM3Aa6WXdt?=
 =?iso-8859-1?Q?0reKgawO0Lh1HMYwBAvzl4CDOwRnLvOXjAy7DWf+SMHg5a533gbH2GmQwh?=
 =?iso-8859-1?Q?CDInNwabZoFfmmMzW7c+L+K6L8Logv0s2Qw1IlLHa/nEX+2vWv7Xmsya2K?=
 =?iso-8859-1?Q?0mh5zm/iYbZ9ATmPNpDbTiy9Eab1/qOKXKEjk4Oa0NDbk4pfJL0zrGSauH?=
 =?iso-8859-1?Q?xWHwp+RyN1pFK0IywEfSsp70W+eCunmNYvoYIMIKZpZDREs8QMx6g3t4PQ?=
 =?iso-8859-1?Q?Xtlz3tTcPrzM/2/tuIMNJ8MwhT+3F7a4fsZua+/95/cTFN/6zB6xJST7En?=
 =?iso-8859-1?Q?2070WvoGJe+gY/Akc7AedFiqoIi2Lg2pG3BaAl3itS61keKOlXZeS+n4Gs?=
 =?iso-8859-1?Q?sEFVDWajbmaZk7imFGQGj12HoMfGFGgozeU8ORW+t4+7fnPoTvXFjfsgOF?=
 =?iso-8859-1?Q?yYbjb3jF4doodRmEFEbDpFwFYm43/3+qbAs54y5SaG47um2pDe/ESQvsz5?=
 =?iso-8859-1?Q?tXLZmqzkaRox+2Tk+8eg8LXyq63Y7MboDKf7mVPQ5eW171OugzEf7QPP3N?=
 =?iso-8859-1?Q?Zx1Hp7k9+9wJbj8u0Oe9XP+aZNHCAsoY9i3WqkuFuCl/fR91bsB3hSYdYL?=
 =?iso-8859-1?Q?Db2sJhZz1KhApWcAo7cQwturOTGrAaogXaDbmDlIF8ScouFnbh4BhW69y8?=
 =?iso-8859-1?Q?ndbSbS+IPDNoBJOPLCWae1ZpjBP1fTKA+gnj5K6iQTXDUP7nSyOex0pPIg?=
 =?iso-8859-1?Q?aUfB3IIwi9BYidif18dvnOzE2JxqG+NH2QjjYvTcV++4y0bnFGXJ7V2SKN?=
 =?iso-8859-1?Q?GEnUW7YH8f9WA0sy+E6dK0aVSjyvNN0FssDqPELYvRtsgndGrEeGz8IHfK?=
 =?iso-8859-1?Q?tkRbIxOqbLmvGTK1NRtrO8g8TFIP2LRVyddgGglHnK+WngK0NmVguG07wV?=
 =?iso-8859-1?Q?4Prr5byv64DtJZQVaEy7Y/LEeJOX?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB7675.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BUpvi8v1haTr7vtRYqLYRwXktzi4mKICy2zqZKx1XAjjqjuhXCvuCy8wUV?=
 =?iso-8859-1?Q?XbXGwZ6DmkYe3oFL+lKSZmrsXADXdmNLs/qd3oQqAmFPv0r7RFnl5DuiIR?=
 =?iso-8859-1?Q?y50igz4dZuSjpoXD1apaxf7n7xGyw9TYitmkn2ETFLb/35CdozIr0v2AGM?=
 =?iso-8859-1?Q?Q6nQ55ds76jAfVUnn7gipHxIFDJY9c/kvQ5zbCLhgQsgt64ydkEHNeplb9?=
 =?iso-8859-1?Q?jNzhVoIU1kRajqwadKyTBnTrO3Yd87znzwMq3i7x9elMYX+XOxTi3pHjw9?=
 =?iso-8859-1?Q?pEf97wWreUpPzKG+iBm6TcnWTPgC6xfjJtInHo2kj5yqlnGz21Qf+QNKpS?=
 =?iso-8859-1?Q?FWxopqKsfeXJubQehD2EuH5RdNAzzitGoAigEVVaGul/g2iwKWVWQ1RV4z?=
 =?iso-8859-1?Q?n8IjbIjWyKW6z2VTdDC5NXnA4grX0ffSagEv1vsXAJSGQZWVf4tDVF3cwg?=
 =?iso-8859-1?Q?LMLKpllRw56wJYvRytJpImndP0xaXUTfunNvs6u/rmQ64FBd/rVLIHe8P7?=
 =?iso-8859-1?Q?8a1Ob4gDHriyCoVHsjPohM9p2Q02P1mOno8LeTalxkqmwCp2164cuqc61c?=
 =?iso-8859-1?Q?1am0geVaoAVCFrFkKDk5CIEeVS0XkSHjU2U8/6pglKB6rVyhhFwBhgVHy4?=
 =?iso-8859-1?Q?VChBjiuUG5ke19TJKrcIlrJ2xHjI0RQM4Z+hEQLoxGK3/ymQ09p/22zveb?=
 =?iso-8859-1?Q?1+cKOY57CuP1p0e8nCL2v3PitPASuL8LmI4XbRAFO0ZCbF7fFMuachW+or?=
 =?iso-8859-1?Q?hv7AMepJmiKAn7/ZKPBL02DSqnV0OmQLY8lXak29oMgFegq2yyjezdC2NZ?=
 =?iso-8859-1?Q?APpDCVunYoJueOwaJH25WPbxhhUxZ7xSriH4MAEamkDVeFW0penCisCfRm?=
 =?iso-8859-1?Q?8hDuA1RA0QZ1SjEbLLeZrtShHr9QqbL6QqmwU1bib2eI+Dd8vFuBZAuWgP?=
 =?iso-8859-1?Q?inzGP/eXawbtBtMWEpmQ+g1JV8+HYbS1c/y/ZCl7qoR7xrxNXlwzjSe6rI?=
 =?iso-8859-1?Q?X7Buv6agoDa/IGy9slYVM3t6eah1yGazaDuTobJi5NpUKrjHfIWTyRxfgw?=
 =?iso-8859-1?Q?R/HOVaWD0DAQhsiMYcFCSGO2/GN0Itl9WdjbQcw1ZGr1s5/6E0qq9xOwR8?=
 =?iso-8859-1?Q?AEGjAmEqn0vGq96Ch4l+eibjjrRLuEgb/heLs1u9s/kSqs/r3iO11HMO9g?=
 =?iso-8859-1?Q?+wksUe1DZLIEDIQy6HdKCocvzcTUrofuTXvnyaI5R8ua68FQmhYHIqTIo+?=
 =?iso-8859-1?Q?5HiNcA3T8R2Y7AfZtuGpwUR8r2YeuzFvJFeVfxOLkyjVBX37SQ8FZhtltL?=
 =?iso-8859-1?Q?+gbQbp+0oE7ce5z4Y52ccLdSeTXZ+x0zR7feipcbexxFxxCehfuxP1WCHl?=
 =?iso-8859-1?Q?UKozGjH9iMatttDMLVzNSd7pKVtoK2SJJbkk4r2dHu6udnSDmgimVQwF4x?=
 =?iso-8859-1?Q?2vw5KP9SuxZArDKlasaoFG24Vn1qiiQtsKGUs1SlQq0OY8RHgOjEE5ZgrW?=
 =?iso-8859-1?Q?UeRhCLVKrrxJvzbS7r2Q6bn9czplHbSQGuDtoYE89wdD+364tYTt3CpEPr?=
 =?iso-8859-1?Q?lqZHFJMpGwcU2ihIbaIcA/dhWgw02NsSZsoe7vkr71sUUpxP1805e8kdmQ?=
 =?iso-8859-1?Q?OkOZgzvpg2kYQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7675.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af446c38-d10c-41d1-38e6-08de295005d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 22:48:00.5079 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ft0RfHkrzVjKE+kqFh2sw4KCSZoq0WdkRz4aOzWNpdl9a88HCGjmYs77q4+5aRDIM+9Xf8ONjmqT03gj5BNToA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181
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

This needs a fixes tag. One comment below. With these both addressed, this =
patch is Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.co=
m>=0A=
=0A=
________________________________________=0A=
From:=A0amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Eric H=
uang <JinHuiEric.Huang@amd.com>=0A=
Sent:=A0Wednesday, November 19, 2025 4:13 PM=0A=
To:=A0amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>=0A=
Cc:=A0Huang, JinHuiEric <JinHuiEric.Huang@amd.com>=0A=
Subject:=A0[PATCH] drm/amdkfd: assign AID to uuid in topology for SPX mode=
=0A=
=0A=
=0A=
XCD id is assigned to uuid, which causes some performance=0A=
=0A=
drop in SPX mode, assigning AID back will resolve the=0A=
=0A=
issue.=0A=
=0A=
=0A=
=0A=
Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>=0A=
=0A=
---=0A=
=0A=
=A0drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-=0A=
=0A=
=A01 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c=0A=
=0A=
index 5c98746eb72d..525e70e45353 100644=0A=
=0A=
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c=0A=
=0A=
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c=0A=
=0A=
@@ -530,7 +530,7 @@ static ssize_t node_show(struct kobject *kobj, struct a=
ttribute *attr,=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sysfs_show_32bit_prop(buff=
er, offs, "sdma_fw_version",=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev->gpu->kfd->sdma_fw_version);=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sysfs_show_64bit_prop(buff=
er, offs, "unique_id",=0A=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev->gpu->xcp ?=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev->gpu->xcp && dev->gpu->xcp->xcp_mg=
r->mode ?=0A=
=0A=
[HK]: It is safer to (dev->gpu->xcp->xcp_mgr->mode =3D=3D AMDGPU_SPX_PARTIT=
ION_MODE). Otherwise, it hinges on AMDGPU_SPX_PARTITION_MODE being 0=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev->gpu->xcp->unique_id :=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev->gpu->adev->unique_id);=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sysfs_show_32bit_prop(buff=
er, offs, "num_xcc",=0A=
=0A=
--=0A=
=0A=
2.34.1=0A=
=0A=
=0A=
=0A=

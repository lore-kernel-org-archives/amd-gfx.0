Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE5FC02181
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 14:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 931CC10E05F;
	Mon, 20 Jan 2025 14:03:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cd7tFgJr";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E5F910E05F
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 14:03:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OI4TxZXL2ZdNOiq8lbRtmv/n2mVzdLKBZN5JE/U3RH4FVjoPv12Rtjdd2USu24aQThhDz/2XdYO0MHAfAuRflja72v4oBwrE3ffGw6xgfRGI1HzOlVnL0q59p+JczHSjbZST8klIIjeXGRqLxQWQZX9teErImlGbHP7fYUtA3PEDofmrbNxpDD7/sbQY1F2sSghaI7iyMXFlCJQaSeue6I6HYjcGSs9VQqac1PZPt2gQ1A4+qvhGJldosJW0Md9pHVpSxFETQZGqJO7sduI4rdHC3oO1Pu4BBzsyZli5BxCWypF+m8IQbxfKqlWT7dXQmpicn840bE+vG1ROXUwOlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BlrYQLyuRZXe3lHdkVZIqL3KONaQo4K/KQ9UFPoTxc=;
 b=JTM1KV4v9Y2iSmeFOrrFllXLauYXbmXRBjXEXW1AC0nz4GIpjAPCASPg361M/EGsIdoQjOnBQpvLZjL/IcntNbgeMuDPXkPIyukgGLxn/Jz26lJGao/M8rZexZvx+rogc/onEhC6cyXdfwbm4z07Sc1ZKbmgwguJOCGhFMjY/wP3A8smOtIX7idvYF3uD10ulukLEkeTQIeOwChoHZl6ycLl/26EJob8aHOzRuFQkfnwjCaV819HuPkNYA3So3drtfzap3JoUWvoGQGiLH0ckXBb/GZ5TLXa24KlpgG5yoN8pPq1wvwigxf0l/Z9CapWPCh2eb5AbkySh4U3n/WeAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BlrYQLyuRZXe3lHdkVZIqL3KONaQo4K/KQ9UFPoTxc=;
 b=Cd7tFgJrjHGAV3kwMUiakB1oGQFOi6EIWFwrTkgZ8Olg7YuUwc5G7SO137XbOIaNTXdhQpIUqqjyl2kr8y15uq9/rz3RvIKUI9Vo9GzNkhymwtMLwoszDwDI2JhmWRiSxUO0AXH90FHsfP7o6dTTrHdrw7svo7A/9GgeVLlHQHc=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Mon, 20 Jan
 2025 14:03:33 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%5]) with mapi id 15.20.8356.017; Mon, 20 Jan 2025
 14:03:33 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung, ChiaHsuan
 (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Mohamed, 
 Zaeem" <Zaeem.Mohamed@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>, "Lin, 
 Wayne" <Wayne.Lin@amd.com>
Subject: RE: [PATCH 00/11] DC Patches Jan  20 2025
Thread-Topic: [PATCH 00/11] DC Patches Jan  20 2025
Thread-Index: AQHbZilhK2TNKgZxDkCeyN5LbCBXn7Mfugrg
Date: Mon, 20 Jan 2025 14:03:33 +0000
Message-ID: <DS0PR12MB65343A9C06134F05B94DA4D59CE72@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250114020900.3804152-1-Wayne.Lin@amd.com>
In-Reply-To: <20250114020900.3804152-1-Wayne.Lin@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=9b98247c-4e8a-45af-894a-f60ce2f4dc26;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-01-20T14:03:28Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|PH8PR12MB7110:EE_
x-ms-office365-filtering-correlation-id: 1862fa18-13f2-4119-9d24-08dd395b3a17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?UgGE/kkOmqdD1dBLhGzSsKWzzkUE1ia+co4cTYuPb73jh1jfXDY/NKI1lz?=
 =?iso-8859-1?Q?12c7NJHPzADCAHmIrxPuFiNliT7jlGG9fybrbycxuAXqzSnqm9nfktYZY4?=
 =?iso-8859-1?Q?g3b/h3r0KShkcD/t+HaiVsktc4evqwxTwwJJi4q1NlumGTMkMtXJ18Xb7y?=
 =?iso-8859-1?Q?3pnOlENr6lZCqqx1RkwfsVKZlRxaIveXcE433ISZkKZ0MbuC+zMdmDBZEt?=
 =?iso-8859-1?Q?2BKBHvJ+8Zxf3W+Gt70wpnDAUth3eY8aprc6HEugFrLNnLPR46XlRUpkI4?=
 =?iso-8859-1?Q?Q2eOxIFqHkBDYs8+APld8shueD5spEt0VsVo5Uim90bGi1iMrgHXvccCkg?=
 =?iso-8859-1?Q?Y00g6Zb31aD0/kzHO1CkZ2/IJYa2w62lN30m7oJj5+13OaAzLscpmb08mB?=
 =?iso-8859-1?Q?sW+9178If2j9PFv1ZCGTbysYlsA7iV/tYiZUeLuJShsN5LvTAXbNGBbd0p?=
 =?iso-8859-1?Q?2rkJ71rjnvbwpAd9sQrpbeUQV6Wgc5b7hQsFUoHBmK3RdTDx4+qyH/xqPK?=
 =?iso-8859-1?Q?G7ai8dNsZZtXy3Mbna/zviida0H9V3JtXB0SDjL4JM7JaSTtZJn3ReHQOf?=
 =?iso-8859-1?Q?6roSl25uWhTUjaOWhXVYV6R5gGP820EvtagcMFtvxhrcAF2XYxluvLhBt0?=
 =?iso-8859-1?Q?w40rIXW1FCEytjZ89BA+zOihEDCtum9oKoC44m1ZumIw4YwMZry7HRwmFM?=
 =?iso-8859-1?Q?MZSHnk4IYjoB32GjfVSfZhBAZko0nfCxyK16DJPoKe5zeD/fqF+uSpo16+?=
 =?iso-8859-1?Q?blyMuH6kXuHgO8OigaZub9IfL28E2Y8BcjNT7mz/nqgy2ZXjM/TNTJ8gQg?=
 =?iso-8859-1?Q?1zgnJPuyiU04F82ezPeDtYLxc5JOXCkhw/pMPfWdYTqmx0U6UTrp7iXbgx?=
 =?iso-8859-1?Q?qiQKplKOhqIFfEgDOp0F3closj6a0UhygEPeklkApUVa76OSapuu6thmZ5?=
 =?iso-8859-1?Q?e63dV/QiF8pFg1pd/+XNdNCN7g7ovGNdZvigNPuxuT0/7XFtta+0vhcSy5?=
 =?iso-8859-1?Q?91kY4U1FEOjcwfJ2mS+mqmUK4i4IRWexs4E54wxq01umFjNwhsquqRXmwG?=
 =?iso-8859-1?Q?EJrPw1rw5A4ZYhz2Cbztv+BI6egclnpyzorYcSD8iaqICQn37IWol0kITS?=
 =?iso-8859-1?Q?Y5kIrP1DW0t9D+bKZUWAjbNGYN3Ti8PbAbCDx6rY6cJfBVBIrvQ34tpd8S?=
 =?iso-8859-1?Q?lG9cKchBOONkAqHMcltumt73nzm/e+MDzKyauA+qVNiOycyh+paL++Rgy0?=
 =?iso-8859-1?Q?iuf79HOPXLwJzALo5AY/j1jcDwYP+oF4nzAUXTcnSAs7raHeS3x31UxSeD?=
 =?iso-8859-1?Q?LKrgRZJkoHoYb6pZ+JP93k2kogUscKfRcRdQLdVFyYutnllZUqdlyU3NPd?=
 =?iso-8859-1?Q?xPS/dadRe1lkSk/O78C6czGsbWe1YpSRA6Bpu6z8lMbwkF/svFDqJr4C7G?=
 =?iso-8859-1?Q?zOL1I3/AZf56aR+a59ZPVrhEB4+GTwcaqYuCQjiyuNZA6pVOgoMpDTh9QP?=
 =?iso-8859-1?Q?LbwufIb6R25nbMHMF/b0gu?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BUjIXn7/tgjjEnexJzWTY9yLf9Do5JJboP4tM2v3No6sii9VZV+kSkTvia?=
 =?iso-8859-1?Q?0oyg9OAH7oq2ZlpWg4TgjWTTs6c2GRxg0GggS7cB8eIUwjHIETnsAPgxTk?=
 =?iso-8859-1?Q?5IiypXPnnrnFiEf7I45rq1Ei23DTnfQ+4XdECAQpUQldgPCrvsvIvaSSJ/?=
 =?iso-8859-1?Q?1YelA4YlgpkbnWh5liWWOhc8N3e3YBfmxPVODqV68N1QOZM30Ub4CKO8fQ?=
 =?iso-8859-1?Q?ChnAilBT7TksPGQTpgT+EVAVOh7ST/rgx614cfYbwem5XZ4zG1oN71vt5K?=
 =?iso-8859-1?Q?ZDbmjY0liz2PmkpHr6fFJ4MdLazeVvn5xobawsR9qi9fD4CAPyFfH8Uag2?=
 =?iso-8859-1?Q?eL3xbcMvmUf/bKhYqBB7O9PCTrFo+zmdjV0gabubCnVwnWe7x7Pp43s66e?=
 =?iso-8859-1?Q?HwThPvjZZOfHxwTH7lWz0za5qLgdVTI6CQBSWjtlInex1MOa24AtI+LPV1?=
 =?iso-8859-1?Q?KrhBNf6htxCsrXGRgEGDOZbWFD8UO1dzBiXZt2lBTiONY0YTWpR3IQWhE1?=
 =?iso-8859-1?Q?9ngBWK4WNKvTD3LW33WxrdRC98Z0Bpa9thR0P+Zzjl6v80J+LLhQq09UVS?=
 =?iso-8859-1?Q?W/rKciuGJOBYLXzlSZOnbGb7e20dxR4xGyiizauAncpudjUCl+AuK2vxrW?=
 =?iso-8859-1?Q?urj/Yx3jLbo8e/yzOjOu40f19Wqj6HCKOQuGEZMmiV4Yk/jOTKB7wQGkYO?=
 =?iso-8859-1?Q?LOfoRF1eWogBaDWrzA4OGUIUbyAHi/sV5wXubdG+VGKusoh/iQddgcJ9f1?=
 =?iso-8859-1?Q?drXL41zofWCFAirClf6OStMta9xrZnO0bb3T1L1gPZQgPDo3rM7L16YiNW?=
 =?iso-8859-1?Q?bFlQEpbsOo6W5B0P3G1W1ieAU/uWn6cd/Ffhp0rPZkXf+gLB+lBisKFWIM?=
 =?iso-8859-1?Q?ik7tpfG2aLaGWTa7LO9d5luFp2bU5CSsWnVHmY7GCP6OnMCp60DUXVui29?=
 =?iso-8859-1?Q?kqfZAKlxzy93y9rupLwiqbUpkD1XhO9oxas/w99xbDSOReD1EBYdlvkV3F?=
 =?iso-8859-1?Q?dDodmemF6r0P1IdGLxGa1MWkiTEboqROHumg+Ok6ekVjxu8iiRZBFU+q1l?=
 =?iso-8859-1?Q?2LLn+/eGSTUMugz27cNwhRaV6fc8iknoA6VSVIpK1B0KnbxNRFeTjWfKyE?=
 =?iso-8859-1?Q?9UFBaFpvFjGkaH2+KIWT3TbJJwHRdAG1f83uxdXnXx5Yw9fBH6vqfC5BVp?=
 =?iso-8859-1?Q?x6d1RjGrT1Kc/yp8Ded7KyCczqUEmttJQJBAhdHrr6VYsvP93e5/8tAK2e?=
 =?iso-8859-1?Q?OS9MHai6wnGjLt3A+Z5bHcQR0hP7UNbiOr5roS5UXu4r/g4+pkqI1Jpmzh?=
 =?iso-8859-1?Q?aEj4urSLZ89Dombi1VDCg7S76bm1mVn6AW74Jl9P1Wfts0V7JNMBAn30Bh?=
 =?iso-8859-1?Q?PinralaPD/PxqCuWt5Tp7BVF4SNdoUmGUI2NaIlzU3VT/Jq/2wI93UXr+R?=
 =?iso-8859-1?Q?Fq2blnm+eB1ZHK73PKlT5I6Vsy7aSuSpQwchB/5gXuLFM+iB2h+8mPZA41?=
 =?iso-8859-1?Q?5aAzaitdND1+AKkOO/IDImWfS/BDBErVUaG3K5tWoKfWT80ZQl4NR9DkiU?=
 =?iso-8859-1?Q?PCr8r8LnHMzQ/qsT0p7SO9w1klpG2FdZ3XEmqZyAhNtCSN7mkTRLrXINNO?=
 =?iso-8859-1?Q?MAubI2N40LvKA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1862fa18-13f2-4119-9d24-08dd395b3a17
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 14:03:33.5713 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0kyAmM230T1fSjz9v1E2avM+zeYwjGKI2XIaXPOXcIc3BvvtlFRMKnOLX7b5ebZPErA5Az1CGNX716gNQkLLtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7110
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

Hi all,

This week this patchset was tested on 4 systems, two dGPU and two APU based=
, and tested across multiple display and connection types.

APU
        * Single Display eDP -> 1080p 60hz, 2560x1600 120hz, 1920x1200 165h=
z
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multi display -> eDP + DP/HDMI/USB-C -> 1080p 60hz eDP + 4k 144hz=
, 4k 240hz (Includes USB-C to DP/HDMI adapters)
        * Thunderbolt -> LG Ultrafine 5k
        * MST DSC -> Cable Matters 101075 (DP to 3x DP) with 3x 4k60hz disp=
lays, HP Hook G2 with 2x 4k60hz displays
        * USB 4 -> HP Hook G4, Lenovo Thunderbolt Dock, both with 2x 4k60hz=
 DP and 1x 4k60hz HDMI displays
        * SST PCON -> Club3D CAC-1085 + 1x 4k 144hz, FRL3, at a max resolut=
ion supported by the dongle of 4k 120hz YUV420 12bpc.
        * MST PCON -> 1x 4k 144hz, FRL3, at a max resolution supported by t=
he adapter of 4k 120hz RGB 8bpc.

DGPU
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multiple Display DP -> 4k240hz + 4k144hz
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60hz displays)
        * MST DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60hz d=
isplays)

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to)
        * Changing display configurations and settings
        * Video/Audio playback
        * Benchmark testing
        * Suspend/Resume testing
        * Feature testing (Freesync, HDCP, etc.)

Automated testing includes (but is not limited to)
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The testing is mainly tested on the following displays, but occasionally th=
ere are tests with other displays
        * Samsung G8 Neo 4k240hz
        * Samsung QN55QN95B 4k 120hz
        * Acer XV322QKKV 4k144hz
        * HP U27 4k Wireless 4k60hz
        * LG 27UD58B 4k60hz
        * LG 32UN650WA 4k60hz
        * LG Ultrafine 5k 5k60hz
        * AU Optronics B140HAN01.1 1080p 60hz eDP
        * AU Optronics B160UAN01.J 1920x1200 165hz eDP
        * AU Optronics B160QAN02.L 2560x1600 120hz eDP

The patchset consists of the amd-staging-drm-next branch (Head commit - 1b7=
feb62fa52857c6afc4d61b830b5a7660cda9c -> drm/amd/display/dm: drop extra par=
ameters to create_i2c()) with new patches added on top of it.

Tested on Ubuntu 24.04.1, on Wayland and X11, using KDE Plasma and Gnome.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>


Thank you,

Dan Wheeler
Sr. Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook |  Twitter |  amd.com


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Wayne Li=
n
Sent: Monday, January 13, 2025 9:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Zuo, Jerr=
y <Jerry.Zuo@amd.com>; Mohamed, Zaeem <Zaeem.Mohamed@amd.com>; Chiu, Solomo=
n <Solomon.Chiu@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>; Lin, Wa=
yne <Wayne.Lin@amd.com>
Subject: [PATCH 00/11] DC Patches Jan 20 2025

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

- Reverse the visual confirm recouts
- Exclude clkoffset and ips setting for dcn351 specific
- Fix cursor programming problems
- Increase block_sequence array size
- Use Nominal vBlank to determine vstartup if Provided
- Fix clock frequencies incorrect problems for dcn401
- Add SDP programming for UHBR link as well
- Support "Broadcast RGB" drm property

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

---

Aric Cyr (3):
  drm/amd/display: Optimize cursor position updates
  drm/amd/display: Add hubp cache reset when powergating
  drm/amd/display: 3.2.317

Austin Zheng (1):
  drm/amd/display: Use Nominal vBlank If Provided Instead Of Capping It

Charlene Liu (1):
  drm/amd/display: Exclude clkoffset and ips setting for dcn351 specific

Dillon Varone (1):
  drm/amd/display: Populate register address for dentist for dcn401

Ian Chen (1):
  drm/amd/display: Add AS SDP programming for UHBR link rate.

Joshua Aberback (1):
  drm/amd/display: Increase block_sequence array size

Josip Pavic (1):
  drm/amd/display: log destination of vertical interrupt

Peterson Guo (1):
  drm/amd/display: Reverse the visual confirm recouts

Yan Li (1):
  drm/amd/display: Support "Broadcast RGB" drm property

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 +++++-  .../display/dc/=
clk_mgr/dcn35/dcn35_clk_mgr.c  |  4 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  2 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  5 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 67 +++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 50 +------------
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |  7 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  5 +-
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c  | 10 ++-  .../amd/display/dc=
/dpp/dcn401/dcn401_dpp_cm.c |  6 +-
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    | 10 ++-
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    |  2 +
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |  9 ++-
 .../amd/display/dc/hubp/dcn201/dcn201_hubp.c  |  1 +
 .../amd/display/dc/hubp/dcn21/dcn21_hubp.c    |  3 +
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |  3 +
 .../amd/display/dc/hubp/dcn31/dcn31_hubp.c    |  1 +
 .../amd/display/dc/hubp/dcn32/dcn32_hubp.c    |  1 +
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |  1 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  | 13 ++--
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 53 ++------------
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  5 ++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  2 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 48 +------------
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 +-
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  1 +  drivers/gpu/drm/amd/=
display/dc/inc/hw/hubp.h  |  2 +  drivers/gpu/drm/amd/display/dc/inc/hw/opt=
c.h  | 30 +-------  .../amd/display/dc/inc/hw/timing_generator.h  | 30 ++++=
++++  drivers/gpu/drm/amd/display/dc/inc/resource.h |  2 +
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    |  7 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |  2 +
 .../amd/display/dc/optc/dcn20/dcn20_optc.c    |  1 +
 .../amd/display/dc/optc/dcn201/dcn201_optc.c  |  1 +
 .../amd/display/dc/optc/dcn30/dcn30_optc.c    |  1 +
 .../amd/display/dc/optc/dcn301/dcn301_optc.c  |  1 +
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    | 71 +++++++++++++++++++
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    |  7 +-
 .../amd/display/dc/optc/dcn314/dcn314_optc.c  |  1 +  .../amd/display/dc/o=
ptc/dcn314/dcn314_optc.h  |  4 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |  1 +
 .../amd/display/dc/optc/dcn32/dcn32_optc.h    |  3 +-
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |  1 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.h    |  3 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |  1 +  .../amd/display/dc/o=
ptc/dcn401/dcn401_optc.h  |  3 +-
 .../dc/resource/dcn32/dcn32_resource.h        |  3 +-
 .../dc/resource/dcn35/dcn35_resource.h        |  3 +-
 .../dc/resource/dcn401/dcn401_resource.h      |  3 +-
 50 files changed, 308 insertions(+), 208 deletions(-)

--
2.37.3


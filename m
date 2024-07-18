Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39F7C3DA60
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 01:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C30F10E136;
	Thu, 18 Jul 2024 01:42:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hUcxU5z1";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B11A10E136
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 01:41:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvbCAl2sDzJ7FWbV0J+BedxjIDgi5nA6G/dyEg/I6wg6rMvjTeOOUSGbU+/N0S8cXFMt8w1l0+NQ8sAj45eMz4NrorHUlnHl6zSPJW/r1rZYEiJ9fmDT8NQy4ph5wvCgWhJVr9/EUBFablRVk98yEGtFIkHm+ALmtHi5BY4/S0SXmzPON9QtuDesx4hXoPmL+b1272JMEqxunKXfyvUfc0i8jttiPkb9tyxqNBp1gy0CPblyg9+FCU63syz3q2z6yP1Mbgh/9PuuUwhi+mjwENk7RK0mZ4IgVylj4FQKpJLFQL5uUHvvotkAUmfeP7cBfKxwMQNwm6Uk+C2W80LKYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53G6VQLc3ruJImyrM3TESTSv+/39+ILjqFMRXUC+P4U=;
 b=KCEKi7LTKKzpXIwviAZCaYeCe26oimHGG40zz614wiqLnmRiNA2Ybe9jeuT9y64yD3NGj2OjEPPvTzl12Kn2Wd9uyZH8Ja8QnwKwl6sNylSfCK7GB7I/hDn9+RP5fJjto1Ek8md4KO7dB7d5XL12UAisZyt4dDHNFN9Gl5qYVLoEV/AOku652a/zYzhVVzr5VW8Af3KT5uY6r6QA2ShVIUHEiXogvYCj20B0akpba7h52oe1m2u0GtdeROoTcIoBbO5BB1dnXJ2ws8Y3QEd8QvCy1RTAjAjErWCXTVk5hYMx4QxZvDeFZJtEbHHMn4QJC427XN8Rgj9gKwFg5aFx+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53G6VQLc3ruJImyrM3TESTSv+/39+ILjqFMRXUC+P4U=;
 b=hUcxU5z1Vaustip/gH5aijhDepUlfsmNnjlyU5Q3XwLNSUikSNW1s1wkxufU68iUZIWN2csqt+zBxw0lEhyfbN303ZAgOpAObWfgIFVTuMZxgOALJb+1RLCF3S39PHQZOrnD5Jc5Tp6fzWzbBUAdxHlbhaLZSfE1l5eZIpqbnKs=
Received: from BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8)
 by CY5PR12MB6084.namprd12.prod.outlook.com (2603:10b6:930:28::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Thu, 18 Jul
 2024 01:41:54 +0000
Received: from BY5PR12MB4212.namprd12.prod.outlook.com
 ([fe80::c03b:dbbb:7472:fb15]) by BY5PR12MB4212.namprd12.prod.outlook.com
 ([fe80::c03b:dbbb:7472:fb15%5]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 01:41:54 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: optimize umc v12 address conversion
 function
Thread-Topic: [PATCH 1/3] drm/amdgpu: optimize umc v12 address conversion
 function
Thread-Index: AQHa2CGXX7DIO5W8SkeRbrpn8BAzHLH64j8AgADUwIA=
Date: Thu, 18 Jul 2024 01:41:54 +0000
Message-ID: <BY5PR12MB42123968E9D2F4D82D18A0C3FCAC2@BY5PR12MB4212.namprd12.prod.outlook.com>
References: <20240717081547.224193-1-YiPeng.Chai@amd.com>
 <BN9PR12MB5257E2AE24DC4B4752F824D2FCA32@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257E2AE24DC4B4752F824D2FCA32@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=18f224b2-018c-4847-b15c-035a006b5afe;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-17T12:55:41Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4212:EE_|CY5PR12MB6084:EE_
x-ms-office365-filtering-correlation-id: 47e2aa93-3f07-4964-117a-08dca6cacdce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?cWquXpvnqly6osxIkspr88lnpatl8R+IZ+25p3FDaCj5FveRnT8WRCFMwauT?=
 =?us-ascii?Q?AOuc+JbJPvEL5eRS+4zXiJynpZahQG2fQRes9GHGD/GmYLWu6SBEMY3oe9Uz?=
 =?us-ascii?Q?Sq+GkDlO2c2CFno3vt6/jNB5kfPZOkq1iG/5Jq5F3yq9Dp8HTNrhWt2Dm01O?=
 =?us-ascii?Q?asDA5e6KqK1axhzjz3jzYXv9U8OIuP2rHOt33efIMmsPkeZZufTroBhXyo3j?=
 =?us-ascii?Q?CGUpHwqXuwZW9pnznmEr/TxlX3EWX0LiEfGF/Rm5tz17z2PFCkERjm+EYzuC?=
 =?us-ascii?Q?cpnYb9M73DC7K04iSDOICdGDNYjyP/Ln1WGn09Ixy3+4aVmPu8snBh2abJAH?=
 =?us-ascii?Q?anwl/OCikjA+COda8Yv7nMu9jJWtcJd7VxzUpVLbG8SsobLpszQMUKvA0pS4?=
 =?us-ascii?Q?6fVX1PkOcsXZAbGu13G9a3zSJUTqmbMCQWz9almEFxh1rGVQ8t8Voeydkpiz?=
 =?us-ascii?Q?Qu7hoIJYbiDpv8VDnS3YD5CPoJFQ3PaeKqW2MONRb+9MhBNLdRSAdqpUtOsV?=
 =?us-ascii?Q?/SOXBr7qGL5go8EaS+2HE5kNcNM3FOeCcv50Npx1TBP19BMLXabreEfm8Vmy?=
 =?us-ascii?Q?T0L3zNra31FzPJG1mGJa1rl1Q6g3kfelkfD1rKbxnXln57rT0BCP4/39mVg+?=
 =?us-ascii?Q?BuMk1yfHd0fr/PPyCgoY5u9pIC642bURbrxIkTCiyjDlCepdXR14UB8w/tY6?=
 =?us-ascii?Q?92UXGEmc9J39xxYbZipPPEOq0kDxBu6RKtenVsOLS+agdklIxgFknuRRbuAd?=
 =?us-ascii?Q?JIkUTaontP8XGRY4mw7o+JCQ9NSGU8S22fXXKzzERU+xXwKlL9mGR4Sn3mAJ?=
 =?us-ascii?Q?1Cn0Krya0xNvtC5I2AngaUkCH05EcI0vQwiCG8yRUTGp6lh6aYmmtLUZSGwk?=
 =?us-ascii?Q?3SPVtPh5Hnek8qERFIZzMONrT0sxxxIRrZeF3VPSH88p+3eNUU1EQqpXZbTo?=
 =?us-ascii?Q?RVyxa9yI3pZlCCLQsVhqzDW8ls2UNszgHO+t30S12UGZgkqdi82ez9u9xrPz?=
 =?us-ascii?Q?MBHMg0AaKH5Ynsykm4yNMNJCtl/Kezw8trPEcBlCK9KIr9nZVkQUF24oAvba?=
 =?us-ascii?Q?6TBCOoJqfLXdZh1MKYY+o9klUZFW/IwNpMNEr8txEWvd4gZM0cgCE+Gtyu3t?=
 =?us-ascii?Q?FcYnqWRHmEq0GYJnNQ9qvxdStfOwFED404NgbHUwiC3aYHE6JICrBU7+yVrf?=
 =?us-ascii?Q?ZpNdbgHJPgdbystBxGAEkqJ0m4f5svY6Tb/TsDJz3xso3KzhhOpPGUrnX5r1?=
 =?us-ascii?Q?zihKUHQYUaSNzR6vnpR0gNFi5D9dljsMLmva3D9JsOi9NPxMxDpk2k8+k6YK?=
 =?us-ascii?Q?xxq/iWPeq11LrYx3uu8yQLF+d51od4MZRvHjEbJk8luLFSOFrtn4+TusPTNk?=
 =?us-ascii?Q?3TBnTZRf9YErcwIdgeyYwJ9VY2/RCTbh/7JFIvx/dBb3eR/tjQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB4212.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SfrbzsbTwjFsfTeOMvPJGgP+M6SaL+8gI37jQFARugKx3v67xc/8KVnIrUHs?=
 =?us-ascii?Q?RTUNucoYF4oUBV6MGeno63CEsMXey9AIPyTFxo3oNPe40Qt+GW9aYjE8Wcnt?=
 =?us-ascii?Q?i4znjxpMZRHBuNIgk5UeM3C6Yw0unPEbu+Mi1OYI11ZM+TYVA2D/uhrwABFq?=
 =?us-ascii?Q?2F4rV4mtlxyUWqQ3hn6zf7dmMOo4OHF75JudpkQbIG7P3FkJ4lep6Q6F4Mtf?=
 =?us-ascii?Q?TKoKJVgJW7e1EjWr5RZZNItjKa3PvH4x44sDDBzcsPhQW+FHZ5nTgL6dOciV?=
 =?us-ascii?Q?xkWNUxGjPxS+UVKhM4bpd+r1w/+bFyv+EvUNWSLa9w6MnW9xcbTmGwmv6Ah2?=
 =?us-ascii?Q?hndUbFGiXaoxtwsYa2Rbeu2g22Wf2XPtIhe71sg05oHjB1hTC2nT6BevvRiG?=
 =?us-ascii?Q?EyDmgyY1xT/W6nlOfUvq1VvUsUWsyv34bGvr4khtdhhE4umNuiQh3cU1k3dS?=
 =?us-ascii?Q?dObJtgHn8m20reCWcKWD7RExtR7+4rD9bj1kqqk0sjDWfyDblwA1QOa9ZCZ2?=
 =?us-ascii?Q?cguH82NrRutKdDefzi08A2dw5VFuGFYQdayQDyTns+y5GWqoKOYp6oXGsEQ2?=
 =?us-ascii?Q?YB0JxTo60Aa4H/JLFlMYrGegCYIdtvMFs/lx7kb2US3tulMLIEMRi9pO1+Ym?=
 =?us-ascii?Q?whHz2BWreV/EOSIeTx4DoAPIefNmCvjYrqjNVP8dzjgtdsAfvrqQk1vX/4cf?=
 =?us-ascii?Q?/aJ/qGh6FGgQPvdwW2tcGcGGQ+/MhO3Kbhbv1GOAjbMkFSkXyuqXOkXPxzT/?=
 =?us-ascii?Q?FFJLKEPimPihCPyvMp55rjjHsOlBjy2wqZXugP+ztXPtoW7Wp+LaaJydDSQN?=
 =?us-ascii?Q?IYsBwVASEDCjzeNAKc8+ziWhR0Aoby2faS7KdB+McREPejIxdqWVjEpKcDSi?=
 =?us-ascii?Q?3r5L6z2YwHwD+12LE6zJueLiDwGWQa8dbLt7zjcEFyfyPIoRdWNKinYpO08Q?=
 =?us-ascii?Q?9HIPkOtvgfubLhNEtYaX4i8o1Wy/vuo/OTadlLYeZeIwJE9vwVF7lHLEy6ir?=
 =?us-ascii?Q?MCy/KjGT6UoyvXQMcGmHUI5y9Wu2eL7CHqXlbduJ4xu/7myExw5Pbwz36ssc?=
 =?us-ascii?Q?tgjsBH2jx2porgU31+lTSPjvsMD53MX49SYvMk7DuGqwKfe+YvQLDuKJayef?=
 =?us-ascii?Q?3OVzoEgrKOfnxutP8iL76+NCyNp8s/5eyaUGyQNO7TRlt5jMxWXKoPS/lHH/?=
 =?us-ascii?Q?lF4aFqLXMj6xt0gan6XZbsudRhUN1nWvrDVnG7N36bP9lnOsfUHV0fwbcGZU?=
 =?us-ascii?Q?+S05723n3sVL9zwdxiFl518GgjmA3VNZ3ebiXbTdID/JihG7s0H+RgssoAGG?=
 =?us-ascii?Q?9/426kmRFUSGGICqltyCqqTSAhZ/icmLCNyVx4ipYL7Ib1ZGL8VohxsQLCUL?=
 =?us-ascii?Q?aOnpTNFiwnc4vP+/sAULcYwZCFKGbnW9RNsGiLdEHOnzexPx8o6Uc7liyUgV?=
 =?us-ascii?Q?rEBMMSwNWrYsFP7Sn0/4GqSIyA+pKHH6PuDToitArTHBv/d2SPrj3xu/JGrX?=
 =?us-ascii?Q?p8yQVXUn4dwLCINP2RSZwOhzVc7VO5kzXySGd1n6WyLQh6aDXja9/Elpzua/?=
 =?us-ascii?Q?NRWT7BKyIDS+FrqRXho=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4212.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e2aa93-3f07-4964-117a-08dca6cacdce
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 01:41:54.6153 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: liytgxryQG6ntUrfXgppriuRvo6nCrdwp1j1fNvWHuvf8f6iUWLJ1bW+I2WTV/q30Zd1jQjIJWir15s26jMPew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6084
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

OK


-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Wednesday, July 17, 2024 9:00 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang,=
 Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: RE: [PATCH 1/3] drm/amdgpu: optimize umc v12 address conversion fu=
nction

[AMD Official Use Only - AMD Internal Distribution Only]

+static int umc_v12_0_expand_addr_to_bad_pages(struct amdgpu_device *adev,
+                       uint64_t pa_addr, uint64_t *pfns, int len)

I would call this function as lookup_bad_pages_in_a_row, or something like =
that.

Anyway, the series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Wednesday, July 17, 2024 16:16
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com=
>
Subject: [PATCH 1/3] drm/amdgpu: optimize umc v12 address conversion functi=
on

Split into 3 parts:
1. Convert soc physical address via ras ta.
2. Expand bad pages from soc physical address.
3. Dump bad address info.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 116 ++++++++++++++++---------
 1 file changed, 77 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/a=
mdgpu/umc_v12_0.c
index 9dbb13adb661..eca5ac6a0532 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -225,26 +225,16 @@ static void umc_v12_0_convert_error_address(struct am=
dgpu_device *adev,
        }
 }

-static int umc_v12_0_convert_err_addr(struct amdgpu_device *adev,
-                               struct ta_ras_query_address_input *addr_in,
-                               uint64_t *pfns, int len)
+static void umc_v12_0_dump_addr_info(struct amdgpu_device *adev,
+                               struct ta_ras_query_address_output *addr_ou=
t,
+                               uint64_t err_addr)
 {
        uint32_t col, row, row_xor, bank, channel_index;
-       uint64_t soc_pa, retired_page, column, err_addr;
-       struct ta_ras_query_address_output addr_out;
-       uint32_t pos =3D 0;
-
-       err_addr =3D addr_in->ma.err_addr;
-       addr_in->addr_type =3D TA_RAS_MCA_TO_PA;
-       if (psp_ras_query_address(&adev->psp, addr_in, &addr_out)) {
-               dev_warn(adev->dev, "Failed to query RAS physical address f=
or 0x%llx",
-                       err_addr);
-               return 0;
-       }
+       uint64_t soc_pa, retired_page, column;

-       soc_pa =3D addr_out.pa.pa;
-       bank =3D addr_out.pa.bank;
-       channel_index =3D addr_out.pa.channel_idx;
+       soc_pa =3D addr_out->pa.pa;
+       bank =3D addr_out->pa.bank;
+       channel_index =3D addr_out->pa.channel_idx;

        col =3D (err_addr >> 1) & 0x1fULL;
        row =3D (err_addr >> 10) & 0x3fffULL; @@ -258,11 +248,6 @@ static i=
nt umc_v12_0_convert_err_addr(struct amdgpu_device *adev,
        for (column =3D 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
                retired_page =3D soc_pa | ((column & 0x3) << UMC_V12_0_PA_C=
2_BIT);
                retired_page |=3D (((column & 0x4) >> 2) << UMC_V12_0_PA_C4=
_BIT);
-
-               if (pos >=3D len)
-                       return 0;
-               pfns[pos++] =3D retired_page >> AMDGPU_GPU_PAGE_SHIFT;
-
                /* include column bit 0 and 1 */
                col &=3D 0x3;
                col |=3D (column << 2);
@@ -270,6 +255,35 @@ static int umc_v12_0_convert_err_addr(struct amdgpu_de=
vice *adev,
                        "Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x =
Bank:0x%x Channel:0x%x\n",
                        retired_page, row, col, bank, channel_index);

+               /* shift R13 bit */
+               retired_page ^=3D (0x1ULL << UMC_V12_0_PA_R13_BIT);
+               dev_info(adev->dev,
+                       "Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x =
Bank:0x%x Channel:0x%x\n",
+                       retired_page, row_xor, col, bank, channel_index);
+       }
+}
+
+static int umc_v12_0_expand_addr_to_bad_pages(struct amdgpu_device *adev,
+                       uint64_t pa_addr, uint64_t *pfns, int len) {
+       uint64_t soc_pa, retired_page, column;
+       uint32_t pos =3D 0;
+
+       soc_pa =3D pa_addr;
+       /* clear [C3 C2] in soc physical address */
+       soc_pa &=3D ~(0x3ULL << UMC_V12_0_PA_C2_BIT);
+       /* clear [C4] in soc physical address */
+       soc_pa &=3D ~(0x1ULL << UMC_V12_0_PA_C4_BIT);
+
+       /* loop for all possibilities of [C4 C3 C2] */
+       for (column =3D 0; column < UMC_V12_0_NA_MAP_PA_NUM; column++) {
+               retired_page =3D soc_pa | ((column & 0x3) << UMC_V12_0_PA_C=
2_BIT);
+               retired_page |=3D (((column & 0x4) >> 2) <<
+ UMC_V12_0_PA_C4_BIT);
+
+               if (pos >=3D len)
+                       return 0;
+               pfns[pos++] =3D retired_page >> AMDGPU_GPU_PAGE_SHIFT;
+
                /* shift R13 bit */
                retired_page ^=3D (0x1ULL << UMC_V12_0_PA_R13_BIT);

@@ -277,14 +291,40 @@ static int umc_v12_0_convert_err_addr(struct amdgpu_d=
evice *adev,
                        return 0;
                pfns[pos++] =3D retired_page >> AMDGPU_GPU_PAGE_SHIFT;

-               dev_info(adev->dev,
-                       "Error Address(PA):0x%-10llx Row:0x%-4x Col:0x%-2x =
Bank:0x%x Channel:0x%x\n",
-                       retired_page, row_xor, col, bank, channel_index);
        }

        return pos;
 }

+static int umc_v12_0_convert_mca_to_addr(struct amdgpu_device *adev,
+                       uint64_t err_addr, uint32_t ch, uint32_t umc,
+                       uint32_t node, uint32_t socket,
+                       uint64_t *addr, bool dump_addr) {
+       struct ta_ras_query_address_input addr_in;
+       struct ta_ras_query_address_output addr_out;
+
+       memset(&addr_in, 0, sizeof(addr_in));
+       addr_in.ma.err_addr =3D err_addr;
+       addr_in.ma.ch_inst =3D ch;
+       addr_in.ma.umc_inst =3D umc;
+       addr_in.ma.node_inst =3D node;
+       addr_in.ma.socket_id =3D socket;
+       addr_in.addr_type =3D TA_RAS_MCA_TO_PA;
+       if (psp_ras_query_address(&adev->psp, &addr_in, &addr_out)) {
+               dev_warn(adev->dev, "Failed to query RAS physical address f=
or 0x%llx",
+                       err_addr);
+               return -EINVAL;
+       }
+
+       if (dump_addr)
+               umc_v12_0_dump_addr_info(adev, &addr_out, err_addr);
+
+       *addr =3D addr_out.pa.pa;
+
+       return 0;
+}
+
 static int umc_v12_0_query_error_address(struct amdgpu_device *adev,
                                        uint32_t node_inst, uint32_t umc_in=
st,
                                        uint32_t ch_inst, void *data) @@ -4=
83,12 +523,10 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_devic=
e *adev,  {
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
        uint16_t hwid, mcatype;
-       struct ta_ras_query_address_input addr_in;
        uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
-       uint64_t err_addr, hash_val =3D 0;
+       uint64_t err_addr, hash_val =3D 0, pa_addr =3D 0;
        struct ras_ecc_err *ecc_err;
-       int count;
-       int ret;
+       int count, ret;

        hwid =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
        mcatype =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType); @@ -514,17 =
+552,17 @@ static int umc_v12_0_update_ecc_status(struct amdgpu_device *ade=
v,
                MCA_IPID_2_UMC_CH(ipid),
                err_addr);

-       memset(page_pfn, 0, sizeof(page_pfn));
-
-       memset(&addr_in, 0, sizeof(addr_in));
-       addr_in.ma.err_addr =3D err_addr;
-       addr_in.ma.ch_inst =3D MCA_IPID_2_UMC_CH(ipid);
-       addr_in.ma.umc_inst =3D MCA_IPID_2_UMC_INST(ipid);
-       addr_in.ma.node_inst =3D MCA_IPID_2_DIE_ID(ipid);
-       addr_in.ma.socket_id =3D MCA_IPID_2_SOCKET_ID(ipid);
+       ret =3D umc_v12_0_convert_mca_to_addr(adev,
+                       err_addr, MCA_IPID_2_UMC_CH(ipid),
+                       MCA_IPID_2_UMC_INST(ipid), MCA_IPID_2_DIE_ID(ipid),
+                       MCA_IPID_2_SOCKET_ID(ipid), &pa_addr, true);
+       if (ret)
+               return ret;

-       count =3D umc_v12_0_convert_err_addr(adev,
-                               &addr_in, page_pfn, ARRAY_SIZE(page_pfn));
+       memset(page_pfn, 0, sizeof(page_pfn));
+       count =3D umc_v12_0_expand_addr_to_bad_pages(adev,
+                               pa_addr,
+                               page_pfn, ARRAY_SIZE(page_pfn));
        if (count <=3D 0) {
                dev_warn(adev->dev, "Fail to convert error address! count:%=
d\n", count);
                return 0;
--
2.34.1



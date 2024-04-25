Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0909C10F1A
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 03:35:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BD4711A043;
	Thu, 25 Apr 2024 03:35:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XtMrTV3i";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82BDC11A043
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 03:35:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XW7CfyMdfaRWBppTwwFj8wiUDLiZ0K5j/LxzuWMC4Hwpu/GQVUS983iNy9hx0t8VoPlAdZ+m8PktZ4cebCARxYfn+FoPUvrzs/ve/n/twAgkjLb4o+Dbh+0Wh39NoV2Vk9X0x/60empUfwB3nGRZ7UViydg5AotxD7DVyci1LvVaI0KwJyJEynxCHY0FQH9YKUtelmB7F4rctSDleG179LZFUrM7o+cwAmQLnfYDlhWOlYZUpzG7ohruCz/fc6z0a69AqzHs/LYXP4ijRGwTTesb/WgwpgEc/r3xAWJVZV8NXYEwvgQAF8byMF9Kj0ZXzNY+IqAAdlWXr5j7a5DtXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXkGjlgDTIuXzNosrdn9zyZzAp1qg8CtJc+COsbrHDw=;
 b=iEAM7vQziNKDSLmcFbWr68aZ2S+poxj6iMiEQZZXjsKwIR8S/SpM24WvDVMgt8q/UpbVLDUz/CDJtbckFxsYrLOFVUVe1AN/tXNCtANFoe4l1keRHWcW9NopRMtPALsj/Lvcq/95lnAciRk0+e5WQDJQqoPFsaZ9zFfcLuVGhpDUOd88BWGLE8BgEp+WOfR/LYkPGT7ZuvXJQfPYBzVqxLw+vjZ4eejBbIFscaVDKaodTFC69+NajjAuR1vGMxXMyscNgdgXTeZfaVhF2rIuUdLN+Vd3cXa0Kz3iKSdtk915INvt6D6JgJIfbUGja+H6NLBdoDUPDzX+EL5Y5A1Prw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXkGjlgDTIuXzNosrdn9zyZzAp1qg8CtJc+COsbrHDw=;
 b=XtMrTV3ig4FjWYvA9J/z3AowvBxY5wA65oUJWgEe40ia5wvFgtW/XLqyr1z37Xe1dSG9H4BbfDq7LsH5Q6FONp0yhCdabXv0YIuLizHqWoKMQvS4Ppfvtz9UU6jp7bzyTfJkQdrWORMi9Jir+I+2LRAiC9TaHZDeayPBBOfrMGs=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by BL1PR12MB5900.namprd12.prod.outlook.com (2603:10b6:208:398::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 03:35:34 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%4]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 03:35:34 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH 04/15] drm/amdgpu: add poison creation handler
Thread-Topic: [PATCH 04/15] drm/amdgpu: add poison creation handler
Thread-Index: AQHakTy7efJUlogrSEKSLFjBb7+Th7F4TzWAgAARDUA=
Date: Thu, 25 Apr 2024 03:35:34 +0000
Message-ID: <CH2PR12MB4215F61DFAC9F4C128FCB8A7FC172@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240418025836.170106-1-YiPeng.Chai@amd.com>
 <20240418025836.170106-4-YiPeng.Chai@amd.com>
 <BN9PR12MB5257DA7DEFE1AE7A17C9140EFC172@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257DA7DEFE1AE7A17C9140EFC172@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3ef226f6-0f84-4afb-9c9e-bff40311e5be;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-25T02:27:36Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|BL1PR12MB5900:EE_
x-ms-office365-filtering-correlation-id: 01eafea8-7368-4e2b-4054-08dc64d8c409
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?G3aSRdCjZS9ufswHV/69JSIcXfD3vHTRBIoZJguCHmOp2tkcb3Jd6vI0+rOb?=
 =?us-ascii?Q?gV8gVS2qMjZoa1RV3yDwhyNeDevbuS/5NWbFfhAMv3Ij/InL38PUOsI5ukIZ?=
 =?us-ascii?Q?Fa558S6sxJRy22v5AfeLdh+N68c6qF9NX4MO2U7RkzMsmYXF49qYbjY55cAE?=
 =?us-ascii?Q?RXA8nUNjYRj07lKBtKWM41FNh7yzuwVJBgEa8P+PHqdA9Iulgrp0yvE4JA14?=
 =?us-ascii?Q?jdVJGO3mg68vlgFHdCFPg9OtYTNt/UnsvC5t7D2R+XOuTvBRyCHhrl+zU0fK?=
 =?us-ascii?Q?a052a39zMuxN+ttYAD0FDpyeQ2l+YlhP1aDg1Q1/f1Lbtj9dOtPD2t4TTeE4?=
 =?us-ascii?Q?4Fqa3W4D7DWNvzf0pcwxBN1YYmdVAXUJkvfyztEwFtgVdykXLGwx++mGWyda?=
 =?us-ascii?Q?PSNPDiZakE27HgEwJQ4gcnqcdbSj5YJhey/+PknEumWBDBm6itN9SiwNgfZh?=
 =?us-ascii?Q?FpztDEHzpGUIEHbWGnjyL2SWAZlNmy96DX2r1NHW6Jba/3lSj20OeTG7iePu?=
 =?us-ascii?Q?/IX5oDmWGIo2hNRlEaT8jPz72IYzD+6P/MrQAKzNzBN32XMByOYUJ9G3Za6S?=
 =?us-ascii?Q?errlTDZGfkgnICvCV9eIagaY+NJkMB5rVj8X1sq+ckC1ThR+29zvXPEJDYLe?=
 =?us-ascii?Q?eEIZap+tnDRet9yJsPWUdSqM/HSmUKTX1hSJsPrQLQT3MqMaqQvECVvMmaal?=
 =?us-ascii?Q?kl0PdS3Vrq6MtFRvYdAhAo97qeWwCH+8DtbyTeEnUvM8WDQAlXj3IdTJLUVb?=
 =?us-ascii?Q?urMUNmt6HXFHLv/QZf6lZOU8R5SMTDQiqBwLUv8Zcc0DJvKlTRevqvub9jhT?=
 =?us-ascii?Q?nb8+5t97PbZwECrK0e6XSjHXb2QNIYyp15GhgmQ6TaSx4EM+eqQ1AhmtTJDZ?=
 =?us-ascii?Q?PzGQ3F4XcTmmKdV8AVeQZL2vVi3hT5tZCvRKResYnCJw4Y542nxapt0BYFuN?=
 =?us-ascii?Q?rDK16oE+WSReC2Eq5FiUYCmu41AFlQNHvevgq0EFv6D89HcJzQkE0Dqhm8Z7?=
 =?us-ascii?Q?Bn06K3tiOvxccfsfU5mQKVCxSagUE3rv/q86FsoBl2nRwUEnqMJDeBIWKgpr?=
 =?us-ascii?Q?7/J0yJjmSRVA0KIdUFMKUwGd4XxE1tmLVI3XBdC2Ogrud/yZx8Xq4rEd4G/S?=
 =?us-ascii?Q?MTf3QP8Aq2g6vUv/VRjbztbK8yD4NVK24Z8JLeNr0yaDQw2Huhd3CxE1NMkT?=
 =?us-ascii?Q?ZKSqagLgTu6Y4NOvf1s/87e8/qlc9LmS5dupHNAjV+QyBRezAcRMMMyg6pJs?=
 =?us-ascii?Q?CPSuVfTTWirm4USiUuwKNNUechDLTfcfIDHCUYKmBpQvyNg/9NI9fcVADJF9?=
 =?us-ascii?Q?EFr7bf9xcNcuPY56c8PGKSTGMA4V1RmQTYK/AyVj+wd+1g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fnR+c3aTE3RM3pBcMSHBpYO56ijOux/Srq5O+9bqEokAjJ+NkABCfD3CjtAP?=
 =?us-ascii?Q?S9d7n9YLlqjlc3VWbhKHrQVYEKJ4LJG+I9Fh4nu/F7cfoTsduUCk+9KfLj/X?=
 =?us-ascii?Q?Cxq2xRunalpC20YHtOVS2+Zde2f+YPZc0ir8c003JysbXr5/kIrgdKgH0ifd?=
 =?us-ascii?Q?AXHABPJm6RHjdTUMpbaRkKgV9xGHJLZ18mXP6JLOzQK+JL6RrlMFJxdad2qw?=
 =?us-ascii?Q?KTr9ndJh57wi0dwVGUzW0Q9gsUtr48kEms+bntR9aDxzYy+LlHrJ/xDkEidw?=
 =?us-ascii?Q?2BUuRzUiVDg0N+WVJpGBs88WDQfX2433ZZNZgeM9qY/tzYqhDNjIgR8CyMEE?=
 =?us-ascii?Q?C/Knmn7KGFjQMzFFZo74S8MaunRRiIv9dvOhe2pzPJKH8vPzvXOr1FWOVfDI?=
 =?us-ascii?Q?HVIB1s/g+T6WPq4tUegXlJQhUOUHRz2L+bmuKDEXpY7AxF8ohsGaxoX3p6gn?=
 =?us-ascii?Q?eJKhfJmrWJGWA2x/INKYoMgoRI4bNjvtbbgUy0MrzYuz3ojEdyeKKZi3uWtf?=
 =?us-ascii?Q?E336khiBMgUeKIRRzRC4aOU8QW9g+ar+iTGhO3bUmfW7RKLjKAPat3rX01gd?=
 =?us-ascii?Q?BNewYgxoPrYAqZfOU7XQtB7YLB8XjZFeYlD2hZXD3sbi4/7LhNb5bBjYvi8G?=
 =?us-ascii?Q?Hw+XUrlpXhRU1Dn8vLgmDNFBqK/irEOQHh+fHsuW5FrgdV4SCFEBLfqqyENW?=
 =?us-ascii?Q?j4Z0lUcfJ9EhcxDzCFBhQXHZpgdlpQh9zby9u9bSsQACbWbSCfiHjtMN6lOn?=
 =?us-ascii?Q?WONpos3XyArmOeSFd7fvxevaHzbgzMkD2gPs6LxVEMvjApxGMG29gz9Qfn14?=
 =?us-ascii?Q?tZKZsG38YnjCagMN9LYERyjYggefTzyUXd2XY7k1BovY3OKatuoT2pbbHhKe?=
 =?us-ascii?Q?WkWrXa5KF4ffNyky3CXQC4aF0hSTRKU6AqWh/YFC3SYd6aIoP7mE/FZAigue?=
 =?us-ascii?Q?TVOgpbMqfi4lx+ZCXDG8iDWVQxjnuieuenu1Pod9su2R6jsBqqUJs8YAsAHU?=
 =?us-ascii?Q?vFE99HV5O4pOiudRA7OyzIW+PSTSahpMHJACybSuaXp61SyKWFaaSHlf1nmC?=
 =?us-ascii?Q?tdsWlRvo5Pl7dMLT55eIfne5tTiFLayqN0dy/2ES3VLPfmLjGTQ9Q+s+kQNd?=
 =?us-ascii?Q?TJKSAi8KTKISvaBR/FSDx1Ij+ralYCtfz3fZUGhWtlcZk1sgXhy18+qSvpyl?=
 =?us-ascii?Q?OHynDjVLF5QgkhFDVUr4sgcmcXcAGKxcm+76HRJEjIk5Jh6sIk6BHafztxg7?=
 =?us-ascii?Q?XBvvW6s1pgbXkkAlCo8LgmXtquhF0focFURJIF+qanYdemOD3hu+bpl7YB7/?=
 =?us-ascii?Q?usHlEcfNaAo56qS+4fxVGj/BzOIjSt6Hr4xqRfZUiSIshpytYRSnZRFb04Eq?=
 =?us-ascii?Q?JTvLiKX1niN6EyUxWRL7+F82gXYcaI/G629iNrBz+0uap/051KzJ4NHLegyx?=
 =?us-ascii?Q?WjymDFI/nQ98n8biPVqs0/QiwKS0Iq+S6D5ZaKBDiB3GROi3mR9J27O+8YAf?=
 =?us-ascii?Q?PHPy/ElJPE1lY7HUqEi+UQ0b06F4xWhpJEU6+wbzfxl6nw/yFlgwTClB61eS?=
 =?us-ascii?Q?bkkcajY2Q7ytqWnSRkc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01eafea8-7368-4e2b-4054-08dc64d8c409
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 03:35:34.4151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uK7rv+HqOGA9G0HKJIKTtiKec8ogVumaEgoq1Paqrps5xaoNVhEPUDVbI2JyiH440yqww+t9CWzYFL1SqJ68Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5900
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

OK, I will do this.


-----------------
Best Regards,
Thomas

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Thursday, April 25, 2024 10:33 AM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li,=
 Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 04/15] drm/amdgpu: add poison creation handler

[AMD Official Use Only - General]

Is it okay to drop below static function and just implement the logic in po=
ison creation handler leveraging the ras query api: amdgpu_ras_query_error_=
status.

It seems to me the static function may not be able to be used for other IP =
blocks.

Regards,
Hawking

+ static int amdgpu_ras_query_ecc_status(struct amdgpu_device *adev,
+                       enum amdgpu_ras_block ras_block, uint32_t timeout_m=
s) {
+       int ret =3D 0;
+       struct ras_ecc_log_info *ecc_log;
+       struct ras_query_if info;
+       uint32_t timeout =3D timeout_ms;
+       struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
+
+       memset(&info, 0, sizeof(info));
+       info.head.block =3D ras_block;
+
+       ecc_log =3D &ras->umc_ecc_log;
+       ecc_log->de_updated =3D false;
+       do {
+               ret =3D amdgpu_ras_query_error_status(adev, &info);
+               if (ret) {
+                       dev_err(adev->dev, "Failed to query ras error! ret:=
%d\n", ret);
+                       return ret;
+               }
+
+               if (timeout && !ecc_log->de_updated) {
+                       msleep(1);
+                       timeout--;
+               }
+       } while (timeout && !ecc_log->de_updated);
+
+       if (timeout_ms && !timeout) {
+               dev_warn(adev->dev, "Can't find deferred error\n");
+               return -ETIMEDOUT;
+       }
+
+       return 0;
+}
+
+static void amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
+                                       uint32_t timeout) {
+       amdgpu_ras_query_ecc_status(adev, AMDGPU_RAS_BLOCK__UMC,
+timeout); }
+

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of YiPeng C=
hai
Sent: Thursday, April 18, 2024 10:58
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang=
, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH 04/15] drm/amdgpu: add poison creation handler

Add poison creation handler.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 74 +++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 64e6e20c6de7..126616eaeec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2080,6 +2080,17 @@ static void amdgpu_ras_interrupt_poison_creation_han=
dler(struct ras_manager *obj  {
        dev_info(obj->adev->dev,
                "Poison is created\n");
+
+       if (amdgpu_ip_version(obj->adev, UMC_HWIP, 0) >=3D IP_VERSION(12, 0=
, 0)) {
+               struct amdgpu_ras *con =3D
+ amdgpu_ras_get_context(obj->adev);
+
+               amdgpu_ras_put_poison_req(obj->adev,
+                       AMDGPU_RAS_BLOCK__UMC, 0, NULL, NULL, false);
+
+               atomic_inc(&con->page_retirement_req_cnt);
+
+               wake_up(&con->page_retirement_wq);
+       }
 }

 static void amdgpu_ras_interrupt_umc_handler(struct ras_manager *obj, @@ -=
2754,10 +2765,54 @@ static void amdgpu_ras_ecc_log_fini(struct ras_ecc_log_=
info *ecc_log)
        mutex_destroy(&ecc_log->lock);
        ecc_log->de_updated =3D false;
 }
+
+static int amdgpu_ras_query_ecc_status(struct amdgpu_device *adev,
+                       enum amdgpu_ras_block ras_block, uint32_t timeout_m=
s) {
+       int ret =3D 0;
+       struct ras_ecc_log_info *ecc_log;
+       struct ras_query_if info;
+       uint32_t timeout =3D timeout_ms;
+       struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
+
+       memset(&info, 0, sizeof(info));
+       info.head.block =3D ras_block;
+
+       ecc_log =3D &ras->umc_ecc_log;
+       ecc_log->de_updated =3D false;
+       do {
+               ret =3D amdgpu_ras_query_error_status(adev, &info);
+               if (ret) {
+                       dev_err(adev->dev, "Failed to query ras error! ret:=
%d\n", ret);
+                       return ret;
+               }
+
+               if (timeout && !ecc_log->de_updated) {
+                       msleep(1);
+                       timeout--;
+               }
+       } while (timeout && !ecc_log->de_updated);
+
+       if (timeout_ms && !timeout) {
+               dev_warn(adev->dev, "Can't find deferred error\n");
+               return -ETIMEDOUT;
+       }
+
+       return 0;
+}
+
+static void amdgpu_ras_poison_creation_handler(struct amdgpu_device *adev,
+                                       uint32_t timeout) {
+       amdgpu_ras_query_ecc_status(adev, AMDGPU_RAS_BLOCK__UMC,
+timeout); }
+
 static int amdgpu_ras_page_retirement_thread(void *param)  {
        struct amdgpu_device *adev =3D (struct amdgpu_device *)param;
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+       struct ras_poison_msg poison_msg;
+       enum amdgpu_ras_block ras_block;

        while (!kthread_should_stop()) {

@@ -2768,13 +2823,22 @@ static int amdgpu_ras_page_retirement_thread(void *=
param)
                if (kthread_should_stop())
                        break;

-               dev_info(adev->dev, "Start processing page retirement. requ=
est:%d\n",
-                       atomic_read(&con->page_retirement_req_cnt));
-
                atomic_dec(&con->page_retirement_req_cnt);

-               amdgpu_umc_bad_page_polling_timeout(adev,
-                               0, MAX_UMC_POISON_POLLING_TIME_ASYNC);
+               if (!amdgpu_ras_get_poison_req(adev, &poison_msg))
+                       continue;
+
+               ras_block =3D poison_msg.block;
+
+               dev_info(adev->dev, "Start processing ras block %s(%d)\n",
+                               ras_block_str(ras_block), ras_block);
+
+               if (ras_block =3D=3D AMDGPU_RAS_BLOCK__UMC)
+                       amdgpu_ras_poison_creation_handler(adev,
+                               MAX_UMC_POISON_POLLING_TIME_ASYNC);
+               else
+                       amdgpu_umc_bad_page_polling_timeout(adev,
+                               false,
+ MAX_UMC_POISON_POLLING_TIME_ASYNC);
        }

        return 0;
--
2.34.1



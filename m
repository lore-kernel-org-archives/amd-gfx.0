Return-Path: <SRS0=fVrT=PO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF96C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 09:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0CD61039
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Oct 2021 09:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BF0CD61039
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 240616E422;
	Tue, 26 Oct 2021 09:51:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4CE16E422
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Oct 2021 09:51:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6R1aHGQp87JxNnnUI+4FaRNXWlG3LIhL+TMftt8qC6UAblj3nKbiEbWgLrodmQStBtHNeg26QcTgUEdZoTo+ySvvVj4hUV49mWkPSF21L8EtouL064y7vTx8ilAK4zbTjvDpBM261V6Bqmpx++xuREVxI3ODWwa1Um/hTjCrkBFUz8ciYuZkMO6mD/ZE3R/Zo4dMFZijDw81tHdARb6iWn8X4VknMdcwS1U66n/dQZdAv5lStXAl9lpgN/aoD6LviEo6t1pTQk3/7gR+6+a1+m38jeh07VOMkTTuhZPJW5QmVAK5is6A6WWZ/n2TNJFrgFxPT/BfflAaAvYC7iFZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8VB+/QzuL70SQksoMZOS8Rvld46WOY9WLmJ3zivH2g=;
 b=cddWnj0igXTMS2D4ELqoCsOJG/qwz2702jwuXjvNRD0Avi3GtTLmAhs2kGPRg1U0Hagw/axRPlhgFztKuW0kHcBszbvAniDMP9J3Lo9Nqxdf5AJ1wT1+57PwAKDDFyxYarz5dXxg/KmhFmKTtGD0dkvB9xRc7zd+mHEdYP4zR9VlIcA3xKBeh+U3/7XBlRl3LMHmY8Uq3MRnLgZBYcSdp/Rh/gqkDzJ+BNbhTd5mCAS7ptuOVRaiEJHnnrHdzYwwY9FA3TAWLE3Q7KfDt297hLW7g1i0pojT5aNmPKBbZmwGgxXatphy3I3C7hlZ2n+hZQpzaHFkRIBRvoAfp8TizA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8VB+/QzuL70SQksoMZOS8Rvld46WOY9WLmJ3zivH2g=;
 b=Va2rLpsCCYAdSqFJii3w2fjZHWA6vqxNFXpwPFl7BRBiYtbOekHNVHKTSFVTCk/D+o9U7eT9O+FxTp+ylwOyJ8Y5TSdD32FjtqkTi1PTzbMPQA0qbKzkhogma6xijTyz/Y677MSeGgJLc/MGxz1Sl2VrekjIyo7SFfHPDlOnn68=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5292.namprd12.prod.outlook.com (2603:10b6:408:105::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Tue, 26 Oct
 2021 09:51:12 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::49b2:d5a0:7a71:eb8e]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::49b2:d5a0:7a71:eb8e%4]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 09:51:12 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: remove GPRs init for ALDEBARAN
Thread-Topic: [PATCH] drm/amdgpu: remove GPRs init for ALDEBARAN
Thread-Index: AQHXykunxfP3TQOpBkOc4S6yKh/FBKvlCEfQ
Date: Tue, 26 Oct 2021 09:51:11 +0000
Message-ID: <BN9PR12MB52576801A07500817A97C77BFC849@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20211026092658.16891-1-tao.zhou1@amd.com>
In-Reply-To: <20211026092658.16891-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-26T09:51:08Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=30cd8c32-d683-4267-b96f-671cb657fd1b;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b650e1b-ca97-4d0b-3f4c-08d9986624d9
x-ms-traffictypediagnostic: BN9PR12MB5292:
x-microsoft-antispam-prvs: <BN9PR12MB52929401079E82543AC59D6CFC849@BN9PR12MB5292.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4kSp7JHJn77zyCKXl8FBGktDvvuKMSaXDD9Qd4iHZh0yEe6XwfCN0WexTVnqTLjRNI9Th2uCw9dPv0alj6E3Xy5WOsgSwdEmTxk0YCTpj+O/BZB0YNYotllyPKgomyp/KzJZZu1VI7UVG6V30MSb2oZhoqwQIlwL25DCh54Ek5WH46tf2w6NkrRubOPRb1e33vp/FeDvoTNsBQMx0h0a+EaMXpjoO/W+lvKI128TUMeV6lNFPpD/Ge2fyEEo9EJ5iUVJXob7dfPRoqlSf5GVQS6slr5DCt4jPhSVjBGXuvU32v51Y+x9tfMOztFGnWFrXA9ZhtK+5NLwhU/ErEOOvvpwFVZyYu3vaAD8A7tu5mdj+ZKk0JdvBWvrWbS16yVr4HYFCejbmjxrx9AZOVq1SD2fUkX9Vcs5+FdUlrGhSJnxqVn63S85WEwBbk9AC3D9hKdJXF8tytL+m3LSC+6bTg8b1LyemSgDz0OFIZN7K5q23vq3FiZIF9pJbEEO5Pp7kqXXBCyqRMSOK3KbadiTtkCBgsEKMkjX9ZfnJlCo10Z3hgw5S9TuLQLgXiAe0J9xTBePXzDuV0qlvI+ih2eM+FsqgTQEh6ZZ5CfSZsdjLGcA8cmeAlAyrsMLjOGkQ33i9YyifWMiSiUrdX7Cn0Lj8jlJFUNO5GqA7q0qeBTsMLeM2Ru6ER/9NwvLFGqpJIZfO1GNEaY4z6rCJmytQ4JIMw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(26005)(55016002)(7696005)(8676002)(8936002)(316002)(122000001)(76116006)(66946007)(53546011)(52536014)(508600001)(6506007)(38100700002)(64756008)(66476007)(66446008)(2906002)(33656002)(186003)(38070700005)(86362001)(9686003)(83380400001)(66556008)(5660300002)(71200400001)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3hXsBO/2rMqxw3FnArcf/gtovtw3z4FKscgwsEGxUOE+Ioc9PrYyI+tL3xq2?=
 =?us-ascii?Q?7Q/jQAvpLc66R0lu3cjAUMeJfHNloWoQ0RbVePGGQNZ2wSwIfpFPzJ2TwD8p?=
 =?us-ascii?Q?wgUH0wqZ6TJ8mNBmGWvrqM+czswx54FfkOKbcIEKSPbbJd6l+vlaVucuHJaX?=
 =?us-ascii?Q?a/b6LfdOf9crFv13itBrLtk7h/Xn4gPREIS8EKMr1Ng+XhV18X/X2JOk1wz0?=
 =?us-ascii?Q?FYse6ImfU4v2+O7QP3DL8YudU7XlovI5pLrot1+9gK2zcUmDB/R+VUXVsa3B?=
 =?us-ascii?Q?nygJIUXuaeEgy+wQr4hynE2tWEhwzzarC4iEXht3THvZihQoTz3+9WjzDL3h?=
 =?us-ascii?Q?VEAbpl3NOuseezKqV99vgaskdwbqoT2JkvhTgqJvUCmBaOF0xA/60bdownrP?=
 =?us-ascii?Q?jdZqNHB4bxtTykTryNHaomfspj9b698mgKvEL7tXSxqPNsOPN0E7GFLGJvfr?=
 =?us-ascii?Q?oFIA6j4NW8ueXNs6jAMIEOUgbyxMXEkHuxR10L5RmmyoicJcQcyDKvi/dbLe?=
 =?us-ascii?Q?0mChuP3k7AK1hNUH8RH3Z1O+t6y4IkVFbKTBtf3834qBqKsUIF2tCYmopirW?=
 =?us-ascii?Q?KNY/4sTbxXRdmmrxE61mMy/9bgmzPco8ofdw4NFL4a/V4UDjEpbw5pe4ZAnP?=
 =?us-ascii?Q?uDI4ij0GhiTKDzviN4bsj8CgYUr0kedFd2/qLy3mP/Oeiv8fiCFWEEu3GaON?=
 =?us-ascii?Q?jQkAVVHpC+6w8EMN7a0q0Fyvz3qcbgKuGQE2lrI/mwkglHUsIzB4Hg1zO01f?=
 =?us-ascii?Q?Hs07jVVTR4MzKkPAPpzcU5nA2dxMbzTBMDNT+WNcZoPK+z0da2jb83Rm3prV?=
 =?us-ascii?Q?SJ9HZZiLki7Ub4nB6OmPiJOc2rSYOAFAsSIpyOYbTrJpLGIlhUH6IJt7fKeN?=
 =?us-ascii?Q?rqtzpr1Nqwr4Dt0W/JDI/s1Z7RujrtxlfLBZZRrB9tXKHd4TSMwV0gaIQt8B?=
 =?us-ascii?Q?RBWJblldRuFXIg3MtpwY8jkl5HNOhMgFYSb3QC5jH0lb4JO+69/28d4t48iJ?=
 =?us-ascii?Q?LUVDZlQKo6j7vMDF4eqpU3X8K1Os4fhxK+P+S+z4vyQCe8F2izltV8eEm7Fl?=
 =?us-ascii?Q?h4ey9uqM7cFnENOdqyCn3w5ZclaZU2igLi4WcKBWGbx0Bb9gz0JIhf+942ju?=
 =?us-ascii?Q?lS8zGSdH6i+/EHbwOmtBsSr4Z/4prOUFGYEiFSriuETBexNa3UJs/N2RW3iT?=
 =?us-ascii?Q?h930zi5kyRe4BOBYUz7pfgYaClVGp5gqUs9VmINVeKUmPZuCOxHS63zk0Iwl?=
 =?us-ascii?Q?Iv7GpO3Ay10VqNfQPvthOsZIwpuiPuLwCLJXGZbPZTvUwuSuS6QG5Aj1SeXX?=
 =?us-ascii?Q?ezlW7rELVUzMLeaWzJJut7BCI334Fb5rO8FHKpZ2d/Y4pVuIXcqODE5giR/Y?=
 =?us-ascii?Q?SZt1L2GxbM77nceBpxj9T7GdGv0Kp772Qq1MIiM+gpGcTLGD+VJXXGOauwT5?=
 =?us-ascii?Q?C7tsuHBM1veMm+bw6dIUpjpn2w+Z4XThJHhY5wpq4ba9tFvwZ52IeXM7wLSx?=
 =?us-ascii?Q?Ct5ZwYW1HVZWHJhz03qLPZVuVzW20nl7aALsM10jwmyttGzvnmZMJqT2WdA3?=
 =?us-ascii?Q?bSWb9pGuJKVTE93OF/k7VkmSVeyG1IpYN7WGmuhBvQKucUMSKLR9SwPJyW+y?=
 =?us-ascii?Q?rt+pW8gQr6yJVbMsVyeRDKQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b650e1b-ca97-4d0b-3f4c-08d9986624d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 09:51:11.9629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 419J9Myvu2FVREhw+BfCpa6clljoWCRzOPpbIOgdG5541DBe14voewYYF7ENyaH45vcQOM+AFFqccXTxsiQKCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5292
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

[AMD Official Use Only]

The change breaks initialization as well. shall we check in_gpu_reset to ex=
clude reset case?

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Tuesday, October 26, 2021 17:27
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: remove GPRs init for ALDEBARAN

Remove GPRs init for ALDEBARAN temporarily, will add the init once the algo=
rithm is stable.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_4_2.c
index 24852a24cc58..c85bad4f1394 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -706,10 +706,9 @@ int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_de=
vice *adev)
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
 		return 0;
=20
-	/* Workaround for some CU settings, skip GPRs init.
-	   Will remove it once GPRs init algorithm works for all CU settings */
-	if (adev->gfx.cu_info.bitmap[1][1] =3D=3D 0x3f7f)
-		return 0;
+	/* Workaround for ALDEBARAN, skip GPRs init.
+	   Will remove it once GPRs init algorithm works for all CU settings. */
+	return 0;
=20
 	gfx_v9_4_2_do_sgprs_init(adev);
=20
--
2.17.1

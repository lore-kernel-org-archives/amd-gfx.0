Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB14EC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 11:42:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74BAE60F26
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 11:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 74BAE60F26
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A5CB6EB84;
	Wed, 22 Sep 2021 11:42:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 236796EB84
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 11:42:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOWCYau4S8lFRU6dEdciLB1VgmFLDmqMz7wsfwHMjedM/A8H70bWTkA2cxHHzdL9nLQvZx0+voyUA5z/PTx0g1DhPchC7ag1tpB4Vy1T0yQVLqNH3CitHRsYKSo0GNJskq4bpDv1lZsotihPMk7PRKh02yUQ9FGG55KE+iY2k4VFIHo1Sd+bOlG7SPmiPm62M25k8EfxeC8eusQwR07uGmt4Kvzpa02N9NKP6wr7m9TvAQcCpoZ6auk+EyGd72UJfxdOqDBUSvCb8OW1hle7XIU4eCq6kte2LY8B1D5rLvVQQL+H37hsKIHtnD9SVP9LEoRMmUwv/Z7qrAycPg2ccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=tLpaAF4rKCpoRw75//urB+Xq8hhxDgBunBADtb4AKAM=;
 b=aLLi0WwWJ6QpBh9n7+/LXRbnxXhg03qLzxvVcukfcIswR/fgfNGRXOUA0q2bdKjS/ngoiIKR9b66rJHYNIIeKGMWR0vvkjj07qcRhg2r2tWVWTKg4VazrJxq+wl7vNx0w0fGQVxTV3EMiIrqxqoNlXI0HmvlAETJz2t+9iRGXSk1jvy2ANFwi09w38bNVLlgQTDqJEbI4oEWnPcg9N2aS4wnRDN+Yjg0QF+6NcRXbvmIQvakySpsEPd05ojLX7xcHJ1Zx88QK8lLefqHY4ke5EgNn9PPvK+2aeRVB4GulwdqEDH4Fuv1OF+sZb5yF1oTOY1LKZH+WysABUrW2TybqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLpaAF4rKCpoRw75//urB+Xq8hhxDgBunBADtb4AKAM=;
 b=R1UfQe6+Iqrs2ZZv+8Dy5yWNXU1lawRI7a9NkB1vdYEjj1O3rmB22QSQb0cSfM9me79cpIaAw//YhFCe0WES9W3QWPIAZBGlqXGjdU4tZS3ISytfXu0IgsajKqSGXtO9vgqEQa2SnjLfDp2ZCZVB6qvcEiEp4HyskX2fVCNX9TI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5292.namprd12.prod.outlook.com (2603:10b6:408:105::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 11:42:03 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4%7]) with mapi id 15.20.4523.020; Wed, 22 Sep 2021
 11:42:03 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: set poison supported flag for RAS (v2)
Thread-Topic: [PATCH 2/3] drm/amdgpu: set poison supported flag for RAS (v2)
Thread-Index: AQHXr506+tvDU5KtHU2PGGpsic52lKuv7I7Q
Date: Wed, 22 Sep 2021 11:42:03 +0000
Message-ID: <BN9PR12MB5257D4F3EDD47F846776B234FCA29@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20210922103248.2401-1-tao.zhou1@amd.com>
 <20210922103248.2401-2-tao.zhou1@amd.com>
In-Reply-To: <20210922103248.2401-2-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-22T11:42:00Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=06c0ed7d-8509-4d41-90d7-14deb2e59d7f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13c3356c-3b72-4b31-f67a-08d97dbdff2b
x-ms-traffictypediagnostic: BN9PR12MB5292:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5292865A11681FD5C54BA91AFCA29@BN9PR12MB5292.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:446;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y+LuwNA4MKjrSK/a7/pgLvf0uHO0qfZ0VKo7qkzueL/MtrCDurojHLKXxNzwubOJ5UdyjZoiTcEVzxgOjK2oXIEQm0aCAFNtnZsqhUuLTMgrD6kgtRzFV835BG4a3ndR85TkelE6EdOl06GZaPm0WI4nyALMMn1oaxaw19hMdIK3oNia8uAbrNcvzVUpv0EZ24nRpt8ZN7oMFZ1lq6Qjcyq7FZ+K+4FJVwHym1qZEzx70Z8monp+Yc5bLT1UdT8fKq2Mb0ZmSmKkqzwTg4JUX0yscMoOeLbfHyqOIzY8pUFJlKlLLKOl3o6Hae4uRSDP05sj5WFzbTNOJKDMOr8cbUkP4vrHhbowfCe4/kUa3i9GwcLZX/F9tEgfaAEgJdiKt8mU48T4APt27sjMRHjeB3jvykhgfuFuaiXW77UnC75e/SW8Hj9xgIoN2o/k/zieZe+2PXtiH5FPvt+vWfJ6iZpMuVAxwTXJH4H6duyOAqJtk1kbBXNo77hIHJxVVHqmzZMqWw+PfQROOOdlgs8yCM5izvCKwpubN19lS6rYGj/uNdaY7o1y9F+ouFVVXSRuvKSliQoZDxEjBcwMPdU1qxBVBPMXdZ4DacsGXhAm8QYnoFbLEKthIwDz/SaxKH3oKNI8ECpn7QlCyFOXNF4Rao3cbh8CxN0ggSJiG/xQ9rEDaPpmwAHD57SjomwzebgxvjjsgjOsbHz0o9d2PkXCTA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(6506007)(66476007)(26005)(2906002)(5660300002)(7696005)(53546011)(9686003)(71200400001)(110136005)(33656002)(316002)(6636002)(66946007)(76116006)(55016002)(64756008)(66446008)(52536014)(38100700002)(122000001)(8936002)(83380400001)(8676002)(66556008)(86362001)(508600001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cnrB+t8qIrysqIZPMnVAAoUNV49tYnCdqrPSBwwsmKIHxmLs+qTK0r131FA6?=
 =?us-ascii?Q?i6KzjxvH/sT+XyWk2aqdzv/DtOYsTVqjkua9Ccms3GnCA1svCL3HWXMzcj7M?=
 =?us-ascii?Q?9fHU0EjlZy8JcHvPeKflSlHt9+w3E5iysLAZYowK1GYXB9HVw0HAgFNKl1rC?=
 =?us-ascii?Q?fuPPCA/zfxOy4VNubkUoOtdTafz0Wm/XbXcTw5ic5GRzz6pe5ug/bi/Jgqvf?=
 =?us-ascii?Q?rxSFp49+srmu7oYMIdLkfdw1nT0HPIbpJ2y90um3Ouk8YWj0wRa4Ufm0yUn9?=
 =?us-ascii?Q?1feByS1BugN7kho/VUZh3NEX3nsyhg15CRW0Sj0EBuAI/5zted2bEI7/RPrO?=
 =?us-ascii?Q?OSoVkZoenwa0X6VsaoD8ZCRJ0zk+WAx7RyJ5D6iXgxpnfYmzVhc9YADBwsT3?=
 =?us-ascii?Q?uUnTaiuo2ID6Wv5mFjc97EOlmcYnKnwJwbRKRUIpll2NYVNH9hlcoBCgjgAI?=
 =?us-ascii?Q?2g8aCQxFAEUOjwklWS5K4ibHHdcU0Qb2uxdpvB7auw7+PCOtwmFwrCJgBfcz?=
 =?us-ascii?Q?a5Ua92o/1jJfxILLROf1T+JImI5Uf/nvlkGABbgGMMxW4Ref0fuQuntXRm0I?=
 =?us-ascii?Q?PNlyxs/SU/8X7l1gGwvL813LhmcZ2ZGtn1e3eBYhurz7C0Lf7F3Bq8Il8WLz?=
 =?us-ascii?Q?FNe2EM+XZJ8kAJRbyKztMKotfAAbINvqBet5HD/mC/qBdXVxm7S4tsqXCbnu?=
 =?us-ascii?Q?3VMKinRn2OBP5Jkh0EDqzxJfgL1jq8mOV79INFSkmolswvvpRvCBr5YbLtpq?=
 =?us-ascii?Q?85GCVSMwJX3pSbpq+JIUUp1TCfl31d+sYsHCZ7YmJJcUIV0LPSy+HwxKFALV?=
 =?us-ascii?Q?ZBXceCwsSS6T1x46M8qH1e6CCMdiHgD0HC/fhjrqkeVNNBvVFoTeOeAwqsU9?=
 =?us-ascii?Q?2pR0T3sLyZzJBKChE5mBMr8oXkdOhOHS3YECWsYs/Fmpj4nYXFilu/atrD8a?=
 =?us-ascii?Q?PDZooX2fHAX85pOvdKgj3CvvabcOOQgq9ZcNF92gFZDvJji/mNRZ0h8UBugx?=
 =?us-ascii?Q?c3ANDzt6BdNduy0DfqnmOnoTB9TPW1oTkPpJf5gE/LVnDMbTKdRBoykxL5xj?=
 =?us-ascii?Q?gWK1pJci0GhKgAmikyts8T70szKTcL3k2pzDHwLP+vuuL253mvLEQ+u/cTyz?=
 =?us-ascii?Q?8p0R0vhE1QMTtTak97x7YtRQpff5Wd4PW49K/jSgEot7LBH5rFQNC3CXmI+f?=
 =?us-ascii?Q?pflaEs6XLKbh13KenUwWNFMpV772QXoXzn3sukt5mBMBSiLmt72+ONksxW6M?=
 =?us-ascii?Q?iuOP1EY/oHqfjJZqWukqcdFhnTVyZNGEAQYJcmU587WoD5RedtFx1vBTFXFc?=
 =?us-ascii?Q?gWanHUWOyLnGSS+CZoRqAUdj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c3356c-3b72-4b31-f67a-08d97dbdff2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 11:42:03.1982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BUEWyUkL7T9NPIvXsPhYvFKdD0oFR3iTVYcfTldYAARY3+6SvMEQqYRUtVSzaf+bwqLDr67Sa6oT0BK/5lGFfA==
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

Might be better call the function is_poison_mode_supported. Other than that=
 the series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Wednesday, September 22, 2021 18:33
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Clements, John <John.Clements@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: set poison supported flag for RAS (v2)

Add RAS poison supported flag and tell PSP RAS TA about the info.

v2: rename poison_mode to poison_supported, we can also disable poison mode=
 even we support it.
    print poison_supported value if ras feature enablement fails.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  4 ++--  drivers/gpu/drm/amd/amd=
gpu/amdgpu_ras.c | 32 +++++++++++++++++++++++--  drivers/gpu/drm/amd/amdgpu=
/amdgpu_ras.h |  5 ++++
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 7d09b28889af..c5cf84829ea8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1442,9 +1442,9 @@ static int psp_ras_initialize(struct psp_context *psp=
)
 	ras_cmd =3D (struct ta_ras_shared_memory *)psp->ras_context.context.mem_c=
ontext.shared_buf;
 	memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
=20
-	if (psp->adev->gmc.xgmi.connected_to_cpu)
+	if (amdgpu_ras_is_poison_supported(adev))
 		ras_cmd->ras_in_message.init_flags.poison_mode_en =3D 1;
-	else
+	if (!adev->gmc.xgmi.connected_to_cpu)
 		ras_cmd->ras_in_message.init_flags.dgpu_mode =3D 1;
=20
 	ret =3D psp_ras_load(psp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 912ea1f9fd04..5b362e944541 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -710,10 +710,10 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *a=
dev,
 	if (!amdgpu_ras_intr_triggered()) {
 		ret =3D psp_ras_enable_features(&adev->psp, info, enable);
 		if (ret) {
-			dev_err(adev->dev, "ras %s %s failed %d\n",
+			dev_err(adev->dev, "ras %s %s failed poison:%d ret:%d\n",
 				enable ? "enable":"disable",
 				get_ras_block_str(head),
-				ret);
+				amdgpu_ras_is_poison_supported(adev), ret);
 			goto out;
 		}
 	}
@@ -2251,6 +2251,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)  {
 	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
 	int r;
+	bool df_poison, umc_poison;
=20
 	if (con)
 		return 0;
@@ -2321,6 +2322,23 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 			goto release_con;
 	}
=20
+	/* Init poison supported flag, the default value is false */
+	if (adev->df.funcs &&
+	    adev->df.funcs->query_ras_poison_mode &&
+	    adev->umc.ras_funcs &&
+	    adev->umc.ras_funcs->query_ras_poison_mode) {
+		df_poison =3D
+			adev->df.funcs->query_ras_poison_mode(adev);
+		umc_poison =3D
+			adev->umc.ras_funcs->query_ras_poison_mode(adev);
+		/* Only poison is set in both DF and UMC, we can support it */
+		if (df_poison && umc_poison)
+			con->poison_supported =3D true;
+		else if (df_poison !=3D umc_poison)
+			dev_warn(adev->dev, "Poison setting is inconsistent in DF/UMC(%d:%d)!\n=
",
+					df_poison, umc_poison);
+	}
+
 	if (amdgpu_ras_fs_init(adev)) {
 		r =3D -EINVAL;
 		goto release_con;
@@ -2364,6 +2382,16 @@ static int amdgpu_persistent_edc_harvesting(struct a=
mdgpu_device *adev,
 	return 0;
 }
=20
+bool amdgpu_ras_is_poison_supported(struct amdgpu_device *adev) {
+       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+
+       if (!con)
+               return false;
+
+       return con->poison_supported;
+}
+
 /* helper function to handle common stuff in ip late init phase */  int am=
dgpu_ras_late_init(struct amdgpu_device *adev,
 			 struct ras_common_if *ras_block,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index ec42e9873aaa..d6377e1ad20a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -352,6 +352,9 @@ struct amdgpu_ras {
 	/* disable ras error count harvest in recovery */
 	bool disable_ras_err_cnt_harvest;
=20
+	/* is poison mode supported */
+	bool poison_supported;
+
 	/* RAS count errors delayed work */
 	struct delayed_work ras_counte_delay_work;
 	atomic_t ras_ue_count;
@@ -649,4 +652,6 @@ int amdgpu_persistent_edc_harvesting_supported(struct a=
mdgpu_device *adev);
=20
 const char *get_ras_block_str(struct ras_common_if *ras_block);
=20
+bool amdgpu_ras_is_poison_supported(struct amdgpu_device *adev);
+
 #endif
--
2.17.1

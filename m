Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF81C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jan 2022 07:31:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9895F896B5;
	Tue,  4 Jan 2022 07:31:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36DAD896B5
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jan 2022 07:31:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoqgXp2J819UJfEsMATq6EI5+YqVw7tFsc/R1m4Js0vH9IZ5VgimjP/Nwp/rmIpJ3/h50vivLJJYEKiCHXpfvoOu6qULevQy0MPUuJuYrIpLBbt87V5eHDE+at2dC1bnx/hVEY0rZaRcUmrHI0I0AJihF8IrYTj8uvgn96QvJ7xayH53wR74M3wJA3hhPlggEu+MRtJoq1PmR/k05uk4R2p0qcuqk/R8KV8K8KKwznYaf6+516cJ2Dt9O5bMh21wEuGoW/ChcuncL3C4I5hrrpbGG3h/4Eg4RhXj2lCgWemdPJmVxVt+5tzli79bjJQKRvZ2ejGsAv8hRNgapEuEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6CWdW/Hs8hpQHNK9NUCg3iwstg7R5jcfECHQ1mN73g=;
 b=ocbKFm0b/tSKLffjCpQBpz9C3zH7pyE/CIJ00JLVE/GIax9/okF9zt4vAoEqCgXkH1TPB5kQTgaxYFXmrElPeGHulnaepqQifGf++MwI0pOx6SCeyT6WyxomH7YgcomCNAx+DiAMAVZqM7Cxdybj9v15q5pex85BA9PaIdQrQ7PvmI6zKNYN1jVsffIS6w4IUuP4vrsasBGlqjeo/grJZ7bXDxT+BFEGH9kOfU7HhhJMeoEG4qJEuUmXeWJnBDYe5B5oBONjoFj99aBDp7qhQOTKCfKnBdsePAH04YH0RoLTnnbaRTN02l+PpbMe6+gyuwZL0/JmtUdEpicSDkmToA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6CWdW/Hs8hpQHNK9NUCg3iwstg7R5jcfECHQ1mN73g=;
 b=urL9BfvNQycJZ/ljxGEIexMDs6Okhu4JuyanaBoXp1N5+eX4BD5asNYUwlVP55JYlIA1c6QfbS4IJRD5wCh9X8gmdoy3TKR5oAIarddM0AKZ3vSPvOJ1HtkjWhhOU/m7e/2iTwWpz+wzS6su1sMyFr8r3fNrPOS5gwmsEdLKuOQ=
Received: from BN8PR12MB3523.namprd12.prod.outlook.com (2603:10b6:408:69::22)
 by BN6PR1201MB2530.namprd12.prod.outlook.com (2603:10b6:404:b0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 07:31:39 +0000
Received: from BN8PR12MB3523.namprd12.prod.outlook.com
 ([fe80::14e3:d2d4:3ad4:81d5]) by BN8PR12MB3523.namprd12.prod.outlook.com
 ([fe80::14e3:d2d4:3ad4:81d5%2]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 07:31:39 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH V3 12/12] drm/amdgpu: Removed redundant ras code
Thread-Topic: [PATCH V3 12/12] drm/amdgpu: Removed redundant ras code
Thread-Index: AQHX/H37l9r9ptOBv02o1tjrwGDiM6xJGc8AgAlnKnA=
Date: Tue, 4 Jan 2022 07:31:38 +0000
Message-ID: <BN8PR12MB35230EBD9F1BD14D41B38CABFB4A9@BN8PR12MB3523.namprd12.prod.outlook.com>
References: <20211229063211.43840-1-YiPeng.Chai@amd.com>
 <20211229063211.43840-12-YiPeng.Chai@amd.com>
 <BN9PR12MB5257CB71A765B613DEF6F728FC449@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257CB71A765B613DEF6F728FC449@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-04T07:31:35Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=e546ec42-e9a1-4d75-94a4-68de4fa4df92;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-04T07:31:35Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 21531637-6111-444b-8467-1573659c4bf7
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac99636c-c207-45ad-b6fd-08d9cf543f03
x-ms-traffictypediagnostic: BN6PR1201MB2530:EE_
x-microsoft-antispam-prvs: <BN6PR1201MB2530296C0C40D6BA13F73831FB4A9@BN6PR1201MB2530.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:327;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 587DZwDcK5ovq/wpFgLRmMbB4ssz82fGivTf1yFOEk1j4RXHAzZuR+oxXM1m6zqMTycc4jZq4WTs/x7fBO8x0uOY4uZXSs94gIsfLm0QGLPGc65HCTWGTaeoxeOEYer0T7IbuRgdXfsyZ/4xf5vA9LnIJaLpZeJUaCOe9hVG5wKtd2KX7/+0CswRnJIJt46egAweX1rUBwHPYDXZ/fBcWNorZpNiwqd8tyWd1UtcCZLijbegC7dxWJH3gNoSve6IO8kqkHe51eQkRhRCCk4czej4+zDrf2wa7QIlq3UxtWgROo6QIXYoPRRZUCFv3W1Ee/cQSgqMpZv5sms7cmUxnS5luI6D+7wvsum+HIVGKS4bAvOe4TEo9ksdMU3tYJ513O24iEOTCgkz/vL7VEUFyUw1QWao/MS+sVQYvb35UA7IQOPlpwgjPnBAioWifixon9ixAOoZtpqbAlSr7Wcwo6foZv3Yy70oVJpXYBHFS2DpBzNz0b9ZULPvQVQoP9TIQSoIzQL5irFnVc7F5wnopUapWdY3xFA2m9uklG9OD1iVlbbAeCnb0HCoD8VbxTqr4O8qmcTaBKEdR62X5A1iGCq2zPxEzVBbrWL+jWXo6ycqHojGLipAQyjV0pDyAIlc0SMmB6VVTsfNVUHTCmBc232R+0HJKUSCREUZSD3CUggV/peR1/E7hLxrKu4dMc2DVZVtvE8fWNA7qbHMsQHZCA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3523.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(64756008)(5660300002)(66476007)(52536014)(54906003)(186003)(9686003)(83380400001)(55016003)(110136005)(316002)(26005)(8936002)(66446008)(38100700002)(33656002)(122000001)(71200400001)(86362001)(53546011)(2906002)(7696005)(508600001)(4326008)(8676002)(38070700005)(6506007)(76116006)(66946007)(66556008)(6636002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AZfRSg4GsOa8pMT3xkgLmT8D0fOa6NVuHngxw5kfuQfYGlqcVoGenmzlaQDB?=
 =?us-ascii?Q?IbePW8HWAJVpDS6Tk8dkzVPrpsM8zX9BeCdzX4FejzvTtgd3hclBm0+85+eC?=
 =?us-ascii?Q?AuNg6Z7HBZCz/3FTM6qJsDg73VBJaRGQ/Nhepijl0V0QJjtVqpmJ1xe3n0wO?=
 =?us-ascii?Q?GvywFK9Qi9w8l27vdzdyWI6v520QIvavZWkr8PwALprToqaQUGNoutUrvnDg?=
 =?us-ascii?Q?n5zEfjQndrTy1680SVjIFljv70S4fg98LjcmAFMnqU4FoINkvoiw/u23Kcp/?=
 =?us-ascii?Q?MWi8auSEngObbSCPW89ApGkScp+EhhSFTcl20hwci1vNZkTgI4a5uMJ4KPZR?=
 =?us-ascii?Q?xuAFyOQgmDjbaIoPFDujNeMlyEDyBR4Z9DAWvVX6ATkkPhSzEl5v6B6CDP24?=
 =?us-ascii?Q?Q2emphZlnfGntsWJ+OfSO5gfuIozxyn/QLIUep+AXyjQiLNAL3NKycz+OLc2?=
 =?us-ascii?Q?RZgxGgm1No0PzyH852811CGEajFM9e96VXymafrZIKHG7fOlZqeTy8X9vjl+?=
 =?us-ascii?Q?YP3uotU2zoLfSOIiNeBKzVVsE8ZjOdPoZUa9EeupxGkl4YP3spgrMhe0uBIN?=
 =?us-ascii?Q?Fg0VXiiGSy1xPJwzfIxF0fGVrZZZVULu5wJKDXxrqHJoBcng1VI/KpF20Je5?=
 =?us-ascii?Q?zEIGP/vxD9etHxafxgLJGIXshwJrl1MqpbG8ibbs7vPnX4qmdUkYdctUtpbl?=
 =?us-ascii?Q?dTmzpV4eLImFgdJPGT94DoDC8KekyiIgpXHMIFKuW8K+r8PP+kk5BV5oqBWH?=
 =?us-ascii?Q?9BSxt6TsBpWnP5CZq3slLCxlS2127j51GGX5JGqb7eKIzSLnVO9FbhJ1OCwQ?=
 =?us-ascii?Q?JbcNj2eaD/PebEE1UGXI0u9L8ibzzSUmyxL91YQr8hLMNiaFrvqp6yF8QvLD?=
 =?us-ascii?Q?MUrL++rXxtSgVRqfEfkWi8OhPFNzh93bJujBxRcZYU8xD14za9cZK5hWF344?=
 =?us-ascii?Q?ZGe4WoynUcmN2/yaRA8Z0zILJDJJI1dujiEejIW1hwxiWgs6HM+dzsAIaUrl?=
 =?us-ascii?Q?308g1h1RMo0HB0aqAtQAXolPT9ztwrZYRbgX31UCokrt3xgMD2icBeBt9gvr?=
 =?us-ascii?Q?jCFR5xMPFNGy10jR3vTryBqEaU1/ggLt3vKtYPIpW6z/sSzM9GltDnA1FL9I?=
 =?us-ascii?Q?OM0Dcz4/SRlGUrgZJsPTOP+tD1JogR0OlWjQLk1UAjDLCaEqEQxGDoGoJn6D?=
 =?us-ascii?Q?fyijbV33Ya8sypD1XTPnHfPDuOIX9aT9fr/OKokUDk1/9c70QflFifaKxhEg?=
 =?us-ascii?Q?8wFpZqivzfj08d+zPLnuW7fIkF7mYW5JD4WZ/iJP63LspAYcz/ty3+/xyMiM?=
 =?us-ascii?Q?4AV4GxoVUlKLAxPjQXstZmQkz0o/l62meQYlxtmKH4fbc1PD0ZauPghJtrIB?=
 =?us-ascii?Q?pjoPap3btwygicGXZznUwcKYUsZlRG5gF6G8g8JhL5OjQSaPiwLrhKy8y5iz?=
 =?us-ascii?Q?xBGawv8GNJKSrfgCUG2aNngGSLtX68aImTCB0eX7BXqUAPM9rIWZIhexZpMl?=
 =?us-ascii?Q?jo13k5msZ1D5ffZNeEsKZjzZ0VDkw2n/1FvGLOmrzAzVo3ahw3N3fVbPW6vc?=
 =?us-ascii?Q?OvA9psvbV8ezb+Blg+ZnultrZHDNEtsu5ZZVP2nftGXa9PDXYTtebKwIyvF1?=
 =?us-ascii?Q?/7EqFliUdrQ9L6Nn7GaI1h8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3523.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac99636c-c207-45ad-b6fd-08d9cf543f03
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 07:31:38.9326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T1XyM30oMc3HD0qR56zwQKBIdR0ldCOZTGm7bE2Gay/XgKg14ivvV5QfydNxjKYVbhpKx3QvFZIOxeMLZ4OzaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2530
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Thank you Thomas,

This series looks good to me too.

Reviewed-by: John Clements <john.clements@amd.com>

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>=20
Sent: Wednesday, December 29, 2021 3:55 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org; Zhou=
1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>; Yang, S=
tanley <Stanley.Yang@amd.com>
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH V3 12/12] drm/amdgpu: Removed redundant ras code

[AMD Official Use Only]

Thank you Thomas. V3 looks good to me. @Zhou1, Tao/@Clements, John/@Yang, S=
tanley please also take a look and raise concern if any.

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of yipechai
Sent: Wednesday, December 29, 2021 14:32
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>;=
 Clements, John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>=
; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH V3 12/12] drm/amdgpu: Removed redundant ras code

Removed redundant ras code.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 82 ++++++-------------------
 1 file changed, 20 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 21765e05b003..17de79be6d8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -910,51 +910,23 @@ int amdgpu_ras_query_error_status(struct amdgpu_devic=
e *adev,
                return -EINVAL;

        block_obj =3D amdgpu_ras_get_ras_block(adev, info->head.block, 0);
+       if (!block_obj || !block_obj->hw_ops)   {
+               dev_info(adev->dev, "%s doesn't config ras function \n",
+                       get_ras_block_str(&info->head));
+               return -EINVAL;
+       }

-       switch (info->head.block) {
-       case AMDGPU_RAS_BLOCK__UMC:
-               if (!block_obj || !block_obj->hw_ops)   {
-                       dev_info(adev->dev, "%s doesn't config ras function=
 \n",
-                               get_ras_block_str(&info->head));
-                       return -EINVAL;
-               }
+       if (block_obj->hw_ops->query_ras_error_count)
+               block_obj->hw_ops->query_ras_error_count(adev, &err_data);

-               if (block_obj->hw_ops->query_ras_error_count)
-                       block_obj->hw_ops->query_ras_error_count(adev, &err=
_data);
-               /* umc query_ras_error_address is also responsible for clea=
ring
-                * error status
-                */
-               if (block_obj->hw_ops->query_ras_error_address)
-                       block_obj->hw_ops->query_ras_error_address(adev, &e=
rr_data);
-               break;
-       case AMDGPU_RAS_BLOCK__SDMA:
-       case AMDGPU_RAS_BLOCK__GFX:
-       case AMDGPU_RAS_BLOCK__MMHUB:
-               if (!block_obj || !block_obj->hw_ops)   {
-                       dev_info(adev->dev, "%s doesn't config ras function=
 \n",
-                                               get_ras_block_str(&info->he=
ad));
-                       return -EINVAL;
-               }
-               if (block_obj->hw_ops->query_ras_error_count)
-                       block_obj->hw_ops->query_ras_error_count(adev, &err=
_data);
+       if (info->head.block =3D=3D AMDGPU_RAS_BLOCK__UMC)
+               block_obj->hw_ops->query_ras_error_address(adev, &err_data)=
;

+       if ((info->head.block =3D=3D AMDGPU_RAS_BLOCK__SDMA) ||
+           (info->head.block =3D=3D AMDGPU_RAS_BLOCK__GFX) ||
+           (info->head.block =3D=3D AMDGPU_RAS_BLOCK__MMHUB)) {
                if (block_obj->hw_ops->query_ras_error_status)
                        block_obj->hw_ops->query_ras_error_status(adev);
-               break;
-       case AMDGPU_RAS_BLOCK__PCIE_BIF:
-       case AMDGPU_RAS_BLOCK__XGMI_WAFL:
-       case AMDGPU_RAS_BLOCK__HDP:
-       case AMDGPU_RAS_BLOCK__MCA:
-               if (!block_obj || !block_obj->hw_ops)   {
-                       dev_info(adev->dev, "%s doesn't config ras function=
 \n",
-                               get_ras_block_str(&info->head));
-                       return -EINVAL;
-               }
-               if (block_obj->hw_ops->query_ras_error_count)
-                       block_obj->hw_ops->query_ras_error_count(adev, &err=
_data);
-               break;
-       default:
-               break;
        }

        obj->err_data.ue_count +=3D err_data.ue_count; @@ -1016,32 +988,18 =
@@ int amdgpu_ras_reset_error_status(struct amdgpu_device *adev,
        if (!amdgpu_ras_is_supported(adev, block))
                return -EINVAL;

-       switch (block) {
-       case AMDGPU_RAS_BLOCK__GFX:
-       case AMDGPU_RAS_BLOCK__MMHUB:
-               if (!block_obj || !block_obj->hw_ops)   {
-                       dev_info(adev->dev, "%s doesn't config ras function=
 \n", ras_block_str(block));
-                       return -EINVAL;
-               }
+       if (!block_obj || !block_obj->hw_ops)   {
+               dev_info(adev->dev, "%s doesn't config ras function \n", ra=
s_block_str(block));
+               return -EINVAL;
+       }

-               if (block_obj->hw_ops->reset_ras_error_count)
-                       block_obj->hw_ops->reset_ras_error_count(adev);
+       if (block_obj->hw_ops->reset_ras_error_count)
+               block_obj->hw_ops->reset_ras_error_count(adev);

+       if ((block =3D=3D AMDGPU_RAS_BLOCK__GFX) ||
+           (block =3D=3D AMDGPU_RAS_BLOCK__MMHUB)) {
                if (block_obj->hw_ops->reset_ras_error_status)
                        block_obj->hw_ops->reset_ras_error_status(adev);
-               break;
-       case AMDGPU_RAS_BLOCK__SDMA:
-       case AMDGPU_RAS_BLOCK__HDP:
-               if (!block_obj || !block_obj->hw_ops)   {
-                       dev_info(adev->dev, "%s doesn't config ras function=
 \n", ras_block_str(block));
-                       return -EINVAL;
-               }
-
-               if (block_obj->hw_ops->reset_ras_error_count)
-                       block_obj->hw_ops->reset_ras_error_count(adev);
-               break;
-       default:
-               break;
        }

        return 0;
--
2.25.1


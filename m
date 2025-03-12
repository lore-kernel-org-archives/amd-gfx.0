Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A176C28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 04:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEF0E10E089;
	Wed, 12 Mar 2025 04:13:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I/2oDWBj";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADE9610E089
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 04:13:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tuc45/mf7eLZwVrGSeiq5KopNfBHvHcRH3QyyDvOE6+Bhn9DY7nOPKTOoMwyhYh4C9fRz8QX8bgFzu3ZQwCunOOW27xj4Ub9VKlUMuYD84o0eytjfqfxcenh47TA0a3/eDsYzXo5iEnP4L2bhCp4tgAFlv7K3bzL47Xnmq3FjsEvSTTnoCuHk2ZQ7CYZgSYdXL+l7DJbeQ8+T+pfnRwnfbO65nX9XfS0dfT8Z+RciVjoBiQNUBIIwVUC0VjRZwpZaG4UZpmtetcDyZxXcni48WxkKGzzkyCo0UYP8J+XC8RFyQX6rBt9w3azLmq7wKdl6lgGH+4oY7cBSzzs2IwyVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6doElye59IfnuNONcbE8j702FQnLcR9TboxWZO7ezQU=;
 b=Al5o8+IOcq8c/W0tmK1gh10zCvw8KU+XA/Hli6Ed7oDp3CFcmCdB2oLdNBm/ix0xn1qYOH5hx9c7cxWwRkUwUMAuPdYH8/snq+99STA2Q8JdsY5mgOKOyplCJS5FFOkHkrJiRyunVQmSn1svnUKAE3SKbPjvOdESHsiVU3bB45iQQ78FXJa6RcCHVRx1gOntrhwNqEcCIqVpLXNezzEHYhS4kytrOcSSN3JIsdxzaBugGPJaT4tioJ6VVI9HLrIrmJHkITJsesKIVGSeRbSZ8efqJ3homb2M6UztYlyGVGG/d98bBxqCFsYann4gz8eVOfiPXPfHrhSIMrjel23D2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6doElye59IfnuNONcbE8j702FQnLcR9TboxWZO7ezQU=;
 b=I/2oDWBjBCKgVAWIFWZMt4OsFx1+TrBSh+gI+iCTwqGe1w0Gb6WjWcfjjFPaJjZP7WX3HS9TrcTT26PXeoQlmssYdoqhBYl3ou/1R/rca6XwXvJ53hDycVUvjJVskU7plFxtv0E1w9mANmHG/HZkEhrYCanhd48/cp+B44U0w9M=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by MW4PR12MB6852.namprd12.prod.outlook.com (2603:10b6:303:207::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 04:13:36 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 04:13:36 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable ras ta if module param
 amdgpu_ras_enable = 0
Thread-Topic: [PATCH] drm/amdgpu: disable ras ta if module param
 amdgpu_ras_enable = 0
Thread-Index: AQHbkvEwjQiz44p4fE+Irje5ijpN8bNu3/YAgAAEBzA=
Date: Wed, 12 Mar 2025 04:13:36 +0000
Message-ID: <PH7PR12MB5997B11C1E77B1AC72711D9382D02@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250312015018.1547060-1-kevinyang.wang@amd.com>
 <BN9PR12MB52572622A634B082BCE746BEFCD02@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB52572622A634B082BCE746BEFCD02@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8e73100e-2e1d-44a8-a6f8-9163caadfcbf;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-12T03:56:03Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|MW4PR12MB6852:EE_
x-ms-office365-filtering-correlation-id: 15a670aa-ee6a-4fc1-512b-08dd611c42ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?5ax/vQbUYTb0eF0fMY1yUf1Y9eUuB/6rqQUKjn4gCRm2Xn4HMwkuKXw6IbLP?=
 =?us-ascii?Q?NKO6M53a6ifpjMLsWlKpUkGZbb4/GQCvjwN2q0FdP602BzWFU6AJKyjQ5Anr?=
 =?us-ascii?Q?89Mj2rgtHj1D/E68co7HsXr3pAy6VVgJrq8BghcCfntgJZT+HSw7ptoGKV9h?=
 =?us-ascii?Q?EPOJXajvSfdgPPDAgBmHgTJF6RyLXRYDG/FPUAKBQTAESuKrur7/2a6FhSfB?=
 =?us-ascii?Q?A724aMzwwTXpBeNGZQk+/bOVoj13yi7uCeng6Z8wRrIlMjotPWMmzv7V/kQe?=
 =?us-ascii?Q?o/9p00Q2syP8le+QzOLnGXYVjN+vXB8CGzwwWmhiAuZFa8x9D8nICZ0Ah9I6?=
 =?us-ascii?Q?6S54aGR+bBdn5JaAirGXMNc7AFXbLJOXJ7eTL2o+s3eX3TMPBGu2bCO4jzaT?=
 =?us-ascii?Q?zeyhi+kU6Umika5mbwPpO9hIpI8823PW7h4FzUdSzBXkSUold5nDOTpoKfzL?=
 =?us-ascii?Q?2JS2xk0FZ+VkUdodVsfaeG2lIbTWx70TXc3PIqnDhpnWeEzfPLwRhbyeMmds?=
 =?us-ascii?Q?945Inb8yW3HzIx3GlLMCFnZOBFLxhKFKY1nJOU4/+VPew2St+rRrXsTUX6ND?=
 =?us-ascii?Q?FYtfnEtORUTbRG0aChNPbL/xDUrIva8UHVX6sOtyDBHxTzFxAWj5+bpOANZN?=
 =?us-ascii?Q?2ttifxv1X5KHglCU2rU9BaxBnhtbA62BQGj6c373J9p/meS/2D/lKNnP6hbC?=
 =?us-ascii?Q?tRiqDMAxfnZ0E0r8faI0gatPLvxKuz0D2Sna40LaBkNrPACO8xayDFCorRxk?=
 =?us-ascii?Q?oiDHuw6v1abTlIZv5nvHzC3FAz7ixmKWs6h/FxB9zM9WPwMy2cmwcn7mhdYj?=
 =?us-ascii?Q?suVYOZboMgT08yFLRE8U8bRzKZkYSQIUIDywGYBS/k7PCE8gjgOdQ3LfDWb0?=
 =?us-ascii?Q?fKiUhEhB3wqcPedDIUx58y4EYrb0B6t4o/4Y3t2s4D32qzo9hPtDl8JDrntS?=
 =?us-ascii?Q?X+a+Nv3PhUrmV4KteTo0z12cRfasm8MSg6XTEZo7Se8QKuNzx7miX4F9jQLa?=
 =?us-ascii?Q?LHcAJQ3v8uV0YX5noAGaGISdMrxaBr83kEOIAY9FCTVso830qZ4NQCmYqSAU?=
 =?us-ascii?Q?W2jBJUBpgN86hhoAZVpJ0/86KoxzlVMIIOAfrOTVhqgbROS2okii1vrFamZB?=
 =?us-ascii?Q?nZfTzkl7K/3k+Fl8WJcyfVAmc8I95zXcFiF1EKEHAbWwsGJRLFaTRAAAc5vY?=
 =?us-ascii?Q?89lZNbzzGsT95BF/SCRA2K947i0U+G+9kXez3wtzhaqDhnKtY9yH+JzqefVH?=
 =?us-ascii?Q?JSY07YXrch7Int7wTzHnCB+6J2MZrLvlXd3GzM7kwa8INndRln0QrQ9n0NHY?=
 =?us-ascii?Q?zmZPDMvLpOGseO0V+H//6e83PzzJ55AdB7xcitg2ddVab1JsrpOLitM52/4P?=
 =?us-ascii?Q?VQgmiygp3/3WgWdd8kGBqn8AA/+dczNS/VP2X4FR03BDVAsFl64MQw2dhJ7w?=
 =?us-ascii?Q?vZYTYicSUfc/psGhub0oOuAM1YA0u+u+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?snUPBl4XN5Bl87mqCC2wiwUNyxCMzuxAgExWdXjsLTNxf0IZBk3UBOqNSMfS?=
 =?us-ascii?Q?SVN5ob1cZUiA2GOa47ziwszOUDj3/LCu0VGgYCJY21+A7R5X3dQckkkOwq3G?=
 =?us-ascii?Q?zyYhldUSEuCoV7O0UBLqrpijdwJJHMz7d2A29mpJpOZVMxECpI0C+V/WUr4y?=
 =?us-ascii?Q?V584ku5pbxqOOfwBl9AQC3m+KgE5R2jUk4eP8Us8ohy0ap2H1Kfemioy69TJ?=
 =?us-ascii?Q?Xk8ClXgFkFtQhvJi85h6N8EJHvDdy/192/KKwxZWrqZdxg0lbPI4mco95hHe?=
 =?us-ascii?Q?tSE+NRJJG9D4qLoPGP7i5NpFb3zVC0XJ6FU4Sw7Fm0xxrnQBcq66JL79ADK/?=
 =?us-ascii?Q?iam6h3xI4Sw88XurQryuFsOy5tL9VPlarw0FX/XC1NC0QZWQ9bcGPLnJX9yq?=
 =?us-ascii?Q?dK1ZlzYd0oAYBzXcAoYoCb6FLlYo8WVXdlGT7iqCelZwyTQHDt8Ce4UTJGC0?=
 =?us-ascii?Q?v/tSCzF1uBYLelp7SUq82kfL5wi6Cdlvw5N5XZzzu6GJdTo4aWbe38jcKvZ2?=
 =?us-ascii?Q?m2SgYsjicxnZSJGiNIWv1FMGDqUtctj4SQmcwS8JuQHwIR5Xkwo7UgR88CtX?=
 =?us-ascii?Q?Hi9nGULty5uLQFyhm+jk8trOpV1ZmAiQBwbpz9v4/VII+nvEBrnxqVexl1qi?=
 =?us-ascii?Q?O6K4itBjWVH5JmhFrI/bnnJl4vC+eVxDjgYYulHRXnYc3wlpzqh9CVD1Bcji?=
 =?us-ascii?Q?DpGS65uAQRowxSSqVGbnYlQQVxA4oF/LjzT3sCLRP2x5i6JgCF/vVXXcSY5X?=
 =?us-ascii?Q?rcOfXA/6XCI+IGO1/2TZk9bOrDKIXLeEIoTPovx0o7mC8ZgA8gW0t6e5Fdj5?=
 =?us-ascii?Q?Z3BD2r6sLX2z8yXREz2qyM7hXJNSOd7M9mMkEMgzqrP8fMhlpUh7cZjolfC/?=
 =?us-ascii?Q?b1iRLxxLtqli6xW40Ig5beVJozzLXkmhTHp7bx9Kosr0rlwMtY2NPGaIiIgk?=
 =?us-ascii?Q?lGfN1P4HkMEvBaByqp6WkYIKObM1xaDwlWCnYtaoKetLXnkTDic3jhG9cNP8?=
 =?us-ascii?Q?BPpUy4g4pqlXaoESqzIlum0cxCEDrfci3/rI5xIc+eWzqmH/bc1mwfoSk99f?=
 =?us-ascii?Q?ihsCyqJeNW+xBDeKirl/Oh/LGCc5BnIjW4pV0nL6vcXMcqEVCe3uX/WFGlNP?=
 =?us-ascii?Q?lHTFxuICAa7ylClId0FebGm0LOGoQ+qZd29+C7I39dCbxfZDs3ayCFvDnQGA?=
 =?us-ascii?Q?HJjXI/gOMJGregDbA199kgbIs/owOsnUjdUDBd2K6h2FUJSXXDHCi1wIUbgg?=
 =?us-ascii?Q?onFQsC0uT85PVJUWgSX84sxYU8kWyDy5KF9f6hHJGC19AFm0XHvCj6+9HPe2?=
 =?us-ascii?Q?ZXuVEpshPCqvQTfhMGjxww1ZoXNfdWN08aHxWmgjSw5wZpOeuuLbHNAK/lff?=
 =?us-ascii?Q?XRqIL6bLePacR2+jZ4mWXbc3wAZH6QATf6tz5rcDpmhqy0Oa/TCmpOadz3sc?=
 =?us-ascii?Q?jDUn4DlUDxFW1oTFcmHTxKMxJzihegyibnK1QNtKWZ82dn/072tNc898yggG?=
 =?us-ascii?Q?lyBH5WtyKGAr9fExTujuQsrr1wnvMS/RDa6jeUoV2nJRAZQUT+5ajWZhfXgU?=
 =?us-ascii?Q?BjysBKng/2PuGFGmoCY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a670aa-ee6a-4fc1-512b-08dd611c42ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 04:13:36.1775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0SwgzhV+MfGl6VA7/mTQ04Uh75ycYGl+sGR1gCNmhDF3kdCClelzPzjW+FktCNMz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6852
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

It is ok, thank you for your explanation.

Best Regards,
Kevin

-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Wednesday, March 12, 2025 11:58
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: RE: [PATCH] drm/amdgpu: disable ras ta if module param amdgpu_ras_=
enable =3D 0

[AMD Official Use Only - AMD Internal Distribution Only]

Let's not do that. Ras ta should still be functioning to forward disable fe=
ature command even software ras is disabled by ras_enable.

Regards,
Hawking

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Wednesday, March 12, 2025 09:50
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdgpu: disable ras ta if module param amdgpu_ras_enab=
le =3D 0

remove unnecessary ra ta laods if the module parameter is specified.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 79dad75bd0e7..f4309e79b85c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1752,7 +1752,7 @@ int psp_ras_terminate(struct psp_context *psp)
        /*
         * TODO: bypass the terminate in sriov for now
         */
-       if (amdgpu_sriov_vf(psp->adev))
+       if (amdgpu_sriov_vf(psp->adev) || !amdgpu_ras_enable)
                return 0;

        if (!psp->ras_context.context.initialized)
@@ -1777,7 +1777,7 @@ int psp_ras_initialize(struct psp_context *psp)
        /*
         * TODO: bypass the initialize in sriov for now
         */
-       if (amdgpu_sriov_vf(adev))
+       if (amdgpu_sriov_vf(adev) || !amdgpu_ras_enable)
                return 0;

        if (!adev->psp.ras_context.context.bin_desc.size_bytes ||
--
2.34.1



Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB21C88E45
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Sep 2026 06:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83B2A10E445;
	Sat, 12 Sep 2026 06:18:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hzROVWCy";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013027.outbound.protection.outlook.com
 [40.93.196.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2FF710E445
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Sep 2026 06:18:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxITak/60xADPI3bpS46GHBFWDDCEObHMh1jNRPp00u5EM3V9xJi7MHelh959XkzwUvj4ct2JFebMrJLXFdyX6WKz2VfUPtqRPXs4yyYHJRXTDR34476RYkoUzqjTzVFKG/3or0rqEvHx0IZnZNaNcUGhDNvYLR28OmIM9wgFLzYiFnRM42h2FQOsdEdwrv9igRONLxJAChA63MOOolF8t/CsU3jY88SfTqp1jkU0QPUYxi1r0qh05wvDvdKGevF3fDORqG3Rws1RnrbCLOGGc0+aEqUJtulD8XV2yklvEOjfBNbjF5MyLA7zWkmeuYfo6ngJRJRjHEhUCpkWpvZbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tENMYFqfYSoMrnA1zaQ3SoQfAXNXSFVlX+Y8famRxFU=;
 b=ZCpPMK6aF56eHZa8Qa4yeWuOLJ8wEvCesKeLUq10EYVgQhXHO9gDbI6fim/JRLNCWLipkuCq4Wbihf9Whv5l+SFWLkig/waPfBlZd4RLRmaV96oAVGwuTO6SbsfxuHfW7HYaRVw4Y2feJBGs++BtkMGOWLq5BBWtJaQAkwcM9GhhjZOhPg5jxh4Lcwub+bb2Cqa5+Tsk8BkFc/c/5o1hRRTxPi3zGv7c7/g6xeId+VWzKO4y+R0ptfnunmfSMTRE+kTykWuLLg6hRCxbP/Tc0YqAwz4WsdR2LpQRm0k2FraFhMj4LMsLa+jZCqD0h8QEmePlJ/I4LSj+YLc0HsnZdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tENMYFqfYSoMrnA1zaQ3SoQfAXNXSFVlX+Y8famRxFU=;
 b=hzROVWCyqyYA4eOUMkDXel4aU7bKjLGAYqJQbU+mYh7JBUagLWgsC5GXQ5exuycrxY7d+j1oaZ0ureAiVdS8+fVQrLnY6Dim4cMNha8r7UDdKK9wvTnp6ABFELxCZcj5KLEx2+i9VSA3iBsZK7AZTCeDNpyB/xI6Ow1yjOLm19w=
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6eb) by CH3PR12MB9454.namprd12.prod.outlook.com
 (2603:10b6:610:1c7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Sat, 12 Sep
 2026 06:18:27 +0000
Received: from BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6]) by BN7PPFFF39339DD.namprd12.prod.outlook.com
 ([fe80::9e62:eec6:fa38:a6a6%4]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 06:18:27 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amd/ras: apply the MCA debug mode where RAS comes up
Thread-Topic: [PATCH] drm/amd/ras: apply the MCA debug mode where RAS comes up
Thread-Index: AQHdQMi8diPSxiVyBk2YeHhXpQ7mEbbKe2OQ
Date: Sat, 12 Sep 2026 06:18:27 +0000
Message-ID: <BN7PPFFF39339DD5E82D7AEF28776A42C58FCBD2@BN7PPFFF39339DD.namprd12.prod.outlook.com>
References: <20260910020358.1541432-1-xiang.liu@amd.com>
In-Reply-To: <20260910020358.1541432-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-12T06:18:08.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PPFFF39339DD:EE_|CH3PR12MB9454:EE_
x-ms-office365-filtering-correlation-id: 1fb5c444-219b-4859-d2b5-08df1095a86b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|11063799006|5023799004|56012099006|6133799003|38070700021|10086099003|18002099003|18092099006|22082099003;
x-microsoft-antispam-message-info: b2uBTaD4n3MRdF7wuZvXRKHXqXPtGraqUAPHzjX8YhJVoDMgKjEhqyw/HtUQBP3Rqe7uf9q2lhZarBbRytAYict672BbY19YKPMFriFW2XXE6dbaEecgEo+25bW0Dq7ztxC1KggQYb0Hg7Pxk/qZYRJpiRexA3TSNDKxGQjQPS4FSuASRZbGLYaFnxLq0yUV4kWmEZ1LC/wIhAeNe5FMxYVcRwDRoYWuC2eoQB9uORpWQuSm18vqI5BVc5MtjgEqWu/GRKl0z3u1cxZcIJAD5IQryviKa/pPtXFmmXVQS9R4okddiFhL74Mta0EIA7bYzeGETSi25RH2kRSRrQBvNUXiYmJ7sswzYymUkxNn73cdVxqHdwRcEbfqdC1xfQnRcNgetDIdQkAha9ZOZVnqk6k1bJl5Qkc54/5VlNQ5bK9Px/WZ557o9QCXIM0xJqAFd+3JbMeohygqL5IhhVANHdc64zU001vVBgpmBeK7qz8JvYfoGd9xdRdsC8uHGbC3gPiNYjYDcuTnkN5RLQDXH8ZQeui0d65kJ09wHbHzTORMgylju8uwBDb63ioVWICPdmNyLvvT4KqYUNRu2tkUR9Te3lOLCz8RVMJ+50+kXF/HEZo5i1o2ynbAQtUY8yByIwd2RL4YTw01RMA+h/Ok3gmBxqj1S9lL1z8QllgVl4JrOUkU42110xgFrXu7nAts5CXRQT6p8e/+C5FpoxjpIGp1db1mwKE4OejxjJ4IPUQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPFFF39339DD.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(11063799006)(5023799004)(56012099006)(6133799003)(38070700021)(10086099003)(18002099003)(18092099006)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ulYW4YHH573f6i5ciEXA80oaLv1yNVlw+tW4084FuD/+1b/CNbqHY117J8eR?=
 =?us-ascii?Q?FyHnatEdBMnAaJNA0BMORd6ehegAzk0a+mvqY2W+m6+sMs4Y3jIR4DnVPpAk?=
 =?us-ascii?Q?aj6cZD9en+8VI1Ebty2/J/48WiNrVuWAtAh+mTqeFA0AJT5nGvDIUTAjYDai?=
 =?us-ascii?Q?euPoPaV+fajkqe25dD80NeEEGF/2wpjbewajgaawluyLW4EKRDJUVAWjSFcU?=
 =?us-ascii?Q?AleJHO/6aAYZx41NUgRCqk6LLbey8cnkOlv+DE/t9egKxCYmFt6zDLcTgiE3?=
 =?us-ascii?Q?DFOt+xDOsjOYENRtrwLL2rw1mfIseUOScig5H00OAPb8kicHdn90nvGos20n?=
 =?us-ascii?Q?zT7ikRhrmqOX6aL14VsvX7haeFIdlahKR+u9Ew6+zX8pD1UtrhrBrBI/TTQh?=
 =?us-ascii?Q?LbQb/g9gSTP2q9MYY9huI5cWW8MNv1pMXo5YIidFWy4r1jbCo/ufKsPNBhok?=
 =?us-ascii?Q?oH52krDW2K3kwtosmMVfoCTnHBMDaPdmXAlAn6KecYEioHXgGnEzoOxdrm6q?=
 =?us-ascii?Q?0ennnY838/IVoEST+FAMCjxuAle27C3chAtwnA1TseVNBTSy724CtXkUp6fB?=
 =?us-ascii?Q?2avMXFqhvmywCtdZdi6i/in7zEGPgkov5NelYvLT7J7nxdjjjcQ1+nwYxnYe?=
 =?us-ascii?Q?eKqNmoWYabMxwJLI89iEjFAWvGZ/ceuXyySfNMZ7C5d4aWj8oRn0+e1tchIE?=
 =?us-ascii?Q?YRQkcn7GJGN3EP+F11l/RVVswsQuv4mbAxs5OcXVlf6HcbzNUOTnzizwQizw?=
 =?us-ascii?Q?EFFzy/NfrJhc5P0800gEtX63IPoojLhIWM2tHieHHnJSebNdL7VZPLL2/8Gc?=
 =?us-ascii?Q?fA5GYmswOPBW7q/co4e44SGalWzL554F3G/JIq6R9f+D7dnBrCfg6nxanUes?=
 =?us-ascii?Q?5d+BAyZqOBKMUMFnF+lJnbEejOLKaes14j9wGdUJAZu2OR8t18dJ2iTfm7ua?=
 =?us-ascii?Q?frOcpnAyfLBmAGSV2iXHRK9JXC9OfusC6fGfDhoY16OFF/2t5dTFiMCY1/wh?=
 =?us-ascii?Q?kFC4Tqi+NU+smjXel7FB6yL4RbAR2uRQoLh5dYn7qzkAbmuNPrBgL8ZS/0HP?=
 =?us-ascii?Q?m28GxBZKnaHNkYMk6o0nk4KasqhaSScf4KM6v22VKxdMk+lWwlQymwiz8Vxv?=
 =?us-ascii?Q?cmkEFmYJEzugaGZQUz7+KPuOTEfEhSgZx497DJhT4R0SLjet7wSGmYvewMbB?=
 =?us-ascii?Q?yZYysnxbLunofm7Qxmjtb8M00NwUDdVYHzLGmPzWk0DSJWEc9784M6oPmwLq?=
 =?us-ascii?Q?r6sipKfaXt41Zg841Cjh6TqD3IFff+m/VDVbAwKtObr+YgNmuSrB7GdXDCHI?=
 =?us-ascii?Q?egbQwSo0EyXxiqM5aqPWEVnWpDH32vmZkRof1xlfJXc3SkhyAP3y5gasQ1fO?=
 =?us-ascii?Q?dRwryQ0MltNGq02Vr+ytg6k5Uchfju403vFq3JLaVsE6uctsnfObRwdzewVe?=
 =?us-ascii?Q?nIowCIrG70BwcV56RkZ1Uo5uRKZSLJXvoHYT1BJQGkM+CXsoLymalSXDBeoA?=
 =?us-ascii?Q?tAuTsG8BCdqpZsFiW6vhdOL+FuaMOddW4T1ks586gc+ACBRNDI4u6I8HUoaa?=
 =?us-ascii?Q?db1wH8cBlYcHS9S8GWwsujUmrp1+r6ZiniXqJVjOIebWBXZKnXms1xmkwXB1?=
 =?us-ascii?Q?c4oOBq2FD42g+kGgJOKJAZ93aTIdTIMoO5wqVG4EqyzmYLSdKd8WV3hQ1M9l?=
 =?us-ascii?Q?TgrQfdrpEVSEC7JF3eD2RdDnv5kD/63qYEmYjN6js9dMi1K1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PPFFF39339DD.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb5c444-219b-4859-d2b5-08df1095a86b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2026 06:18:27.1253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ddj+/XO1MkpScu5nemZ9ZVR06fY90hGT+jYucVrzK8YACgeO/ZXWzl4wvWoZVzxja9v3lAxN5ujOV5hul8I39Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9454
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

AMD General

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Thursday, September 10, 2026 10:04 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH] drm/amd/ras: apply the MCA debug mode where RAS comes up

amdgpu_ras_late_init() sends the MCA configuration to PMFW, but it runs bef=
ore RAS is ready on a device that still needs a hive reset, so the request =
is dropped and CE polling stays disabled. A reset loses the setting too, si=
nce PMFW is reloaded and nothing programs it again.

Apply it from amdgpu_ras_mgr_hw_init(), which covers modprobe and the defer=
red bring up, and from amdgpu_ras_resume(), which covers GPU reset and resu=
me from suspend. Drop it from amdgpu_ras_late_init().

The control is absent on some parts, so its result must not fail hw_init.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c          | 7 ++++---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 3 +++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index becad704113c..9ba48eef1349 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3897,6 +3897,7 @@ static void amdgpu_ras_block_late_fini_default(struct=
 amdgpu_device *adev,  void amdgpu_ras_resume(struct amdgpu_device *adev)  =
{
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+       struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(adev)=
;
        struct ras_manager *obj, *tmp;

        if (!adev->ras_enabled || !con) {
@@ -3906,6 +3907,9 @@ void amdgpu_ras_resume(struct amdgpu_device *adev)
                return;
        }

+       if (ras_mgr)
+               amdgpu_ras_mgr_set_debug_mode(adev, ras_mgr->is_debug_mode)=
;
+
        if (con->flags & AMDGPU_RAS_FLAG_INIT_BY_VBIOS) {
                /* Set up all other IPs which are not implemented. There is=
 a
                 * tricky thing that IP's actual ras error type should be @=
@ -3966,9 +3970,6 @@ int amdgpu_ras_late_init(struct amdgpu_device *adev)
        if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_ras_telemetry_en(adev))
                return 0;

-       if (amdgpu_uniras_enabled(adev))
-               amdgpu_ras_mgr_set_debug_mode(adev, false);
-
        list_for_each_entry_safe(node, tmp, &adev->ras_list, node) {
                obj =3D node->ras_obj;
                if (!obj) {
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index a02167397ce2..a10d8991d131 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -448,6 +448,9 @@ static int amdgpu_ras_mgr_hw_init(struct amdgpu_ip_bloc=
k *ip_block)

        ras_mgr->ras_is_ready =3D true;

+       /* the control is absent on some parts, so it must not fail hw_init=
 */
+       amdgpu_ras_mgr_set_debug_mode(adev, ras_mgr->is_debug_mode);
+
        amdgpu_enable_uniras(adev, true);

        RAS_DEV_INFO(adev, "AMDGPU RAS Is Ready.\n");
--
2.34.1


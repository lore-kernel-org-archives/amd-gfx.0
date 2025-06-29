Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FBCC7EE30
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Jun 2025 07:44:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E837010E16F;
	Sun, 29 Jun 2025 07:43:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g6T+F3WE";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E18D610E16F
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Jun 2025 07:43:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ex25Uiit5Oifig8hpwhOeCta2Q0b5QPsoW8UUKpSg3fwYZzT226qBR8iffacSywdw2iJNdJbWLmnQsMm0C0Ot4pc3EALDgqTj3d6Pis9qmKMgZvg834q02DMkhuWrHmwmVwt1oOkrUj/PMvhTPnfRSYgflrxhCPfHkyxA58msDiXJwn7n3+PvrrUyrC666WC+oWBrpWhCYdoNP4+8c2TNWsias+w64ueNOsPKgY7ZTyqjyigNKFFSz1EjgCPHPGWndRp27P5IWSh4KWGb4/jSO7zAsAKFWOA0Z4LenjiP9HKdxkQCqE1Ok6r9tATSuiloVEdvyq2jTjHqZTyC9RZ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FB1Od2+Rgzkok3NECHQx8hvx69gZqfrAL7kewvkypZs=;
 b=jMjtKHyUeEU+beOgBdq3VDfEftgcmbJo0vLTogKUlW6CZQs4Dfuk3jqKRshSSvapkfSU8NEzcOrvkoIQVhMq84sxjqTUNw+G457p8Lkun2BJeWuSoRfwslDa/f+l6fp2ktBwzPhCXPNYfgVvlgjAL6wFJXKQXK8m3nI9Wxdlq7AimzvhNa5XWJCs2EzV+Be3XC+kb8rhYe0JkQ7BDYPiw9/4YM7dwlPX4EIGkTRN3N1VprEazYcug8SCfOTQMbWfg1vWMta8E4BZVcPPD85YzSbuwOyn/aSadyC05QVjwEH8R6Z20oHJ68XAAqXM8yDBExHDb0gvfHdqgIG3DzdRCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FB1Od2+Rgzkok3NECHQx8hvx69gZqfrAL7kewvkypZs=;
 b=g6T+F3WEcxdLiZZjDB7LrQ54fSqDgM0Jns7og+pd4pOOm8L/7vkhQoWIWRrbBqvCTKIrtdYKQJTqldqiQ8o1drw5QtmD6G2sBlyMoFwWIFnt0fG8hBtOoK0Fk9rCmSmwlQJb1k1cCLHBAq6a8EBz+UJiSrvRoXem+IQdVmG//lA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS7PR12MB6238.namprd12.prod.outlook.com (2603:10b6:8:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Sun, 29 Jun
 2025 07:43:43 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.8880.021; Sun, 29 Jun 2025
 07:43:42 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Use correct severity for BP threshold exceed
 event
Thread-Topic: [PATCH] drm/amdgpu: Use correct severity for BP threshold exceed
 event
Thread-Index: AQHb6Asp+r0sMn0f1EyKuRWmOluFZrQZwurw
Date: Sun, 29 Jun 2025 07:43:42 +0000
Message-ID: <BN9PR12MB5257254505E7D46FE5EDC692FC47A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250628090018.327806-1-xiang.liu@amd.com>
In-Reply-To: <20250628090018.327806-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-29T07:43:27.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS7PR12MB6238:EE_
x-ms-office365-filtering-correlation-id: 557c257f-a640-4afe-97ab-08ddb6e0abcb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?RQskx8vFrbn6XlaOhbaIK1DNfq5ahxj/au5IurBzIWcuA1y9+jbTm0WysTGq?=
 =?us-ascii?Q?YPNf/NiP4ySw1Dg+DJKrrXNEg39wQHpgRiRtJ7+VZM5o75NJu4QtSWnGETAW?=
 =?us-ascii?Q?hHAwi9tbNvfqed2zWxe2gf4N/nEGELIP9R4BCpU1976I0v2JlV95XloRn+4U?=
 =?us-ascii?Q?wl9FApOZJVfwgb3OI0ugteLe5Chcv0sICVfUJSa2WpWYJLMz+QsxstpTIUDh?=
 =?us-ascii?Q?OPz5S0qbrMVKc3xBelytbescWIPqNEzX2d8NlwEm7HwKUNkRvrI2mT4OWyCY?=
 =?us-ascii?Q?phRCofuH9Lw2BO6vnx2I+g5VnavZcuCLAncILhDMhTF4CFF6yZ9wJlqulCQ1?=
 =?us-ascii?Q?v/iDfd5cXScpQ7/ByINRrr5ui9dSLtbiddVtkREC/PbtnOrKht+0085Bd/oS?=
 =?us-ascii?Q?Ydj4KQ+5Ibbrm72QPdotcum4dkgBp6OMQQuckeVqjzoQ+MCvaH5Go/H0xm4J?=
 =?us-ascii?Q?FkXVbnYAc2dQ0V2Ir7Od302q2sxdJBFsK+OhGibH/dQMF0xuol5BQXPW1KMp?=
 =?us-ascii?Q?0algn19zIrI5+3WO82f3mpfk0jVhLOfJvOueVGleeYxn26wim66QUZIdog6e?=
 =?us-ascii?Q?g7mK34/4S1wpQO1xLvy6Et4XB9mnj701oALCz+zn0PQnKGjp/9MCyuwhCsP8?=
 =?us-ascii?Q?kJL9XoNIy16b24/bYEqlIKMlIjENhbJ1OyY78tzFVKmpjwV07K0TGhO0LA1J?=
 =?us-ascii?Q?CR0tT1DCRFidLHwlZzOohiuLiPFrizb0vqOIRNyw+zGtJA66deG/s8YZbF7p?=
 =?us-ascii?Q?TfKnkVgepi5HvpBVyfIQU6+Un8LTsyc3HGfjCsLnX4lkq7lzS7eXfk/MmOYZ?=
 =?us-ascii?Q?aWptUmT+uLKcFtpZ47LKXWPC2CUWAbApYYRpyqbJq2Am6VGQEeerCCT6CmSk?=
 =?us-ascii?Q?vzw5iabAqPdr2A+jXfaL8shm/1u9IWWYA1fTOdJwILyu8DIsIMnkih3ZAEn+?=
 =?us-ascii?Q?kRmc55p4aIX0jVcRXG3eGRDbvCDB+NJcf1ZAIf0Ei0YvhK6KCAeBB1uhdGEi?=
 =?us-ascii?Q?6302rXPLq82U4K/Hww5eOwLLT1eOEr5NzS5GB/46CBD2Obr3ZNVVOEuDRgjX?=
 =?us-ascii?Q?a8WCQL921cy/LkBr1E+EeeV25WDDNI03UWq16MjDsJNipfCWrKfTZqPRSSGX?=
 =?us-ascii?Q?Q1rUW4c4Dej75kuln5Ro+qEsJ6qsVlKb/1ZuVmHKTrP2UVvu3vrbfnHFBdn+?=
 =?us-ascii?Q?aHvPmi89M3Qs6P55OEKgi5X1IhrbahmDsVq8SlXOfmRSvAzTEZvYg6ZZ8iWj?=
 =?us-ascii?Q?h+f2v3Wb6QFNBfDyJ0lhLCdmSkIHd38F0FoZzT6IHBPmpHZZyQQySdWOCZ4r?=
 =?us-ascii?Q?Cosl+Oo1j7CECdN55m1igFqMUC9HpXMJAWEvosbiRkR2SqNjj0lwJ0eyDWih?=
 =?us-ascii?Q?mmTdCAnQZLwtTdkr8HSCVSrV8o05Pq8s8kVlJGceoi6koEjNu7elW0/ZjFhf?=
 =?us-ascii?Q?1NMiagB74jca2KPcbozH7TYuSF1wC5LjlxrGD7aj219ZbeSi6pgbHw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xZaqiP4nxL2e1EHrLIw1fUooH2sTWg0Zz+mvlJcWII3Vt19+4fRiL7SmiyrY?=
 =?us-ascii?Q?bmXXGmQi4HGW6ryImP6CSA7IaSyap5r2SNNXc7y1/TmOhjg8TWTOoEYkTiV5?=
 =?us-ascii?Q?XEA+5j7/lYzGVE/dNdvtzjLVKbFp6leCLBARZPu4JwqqKwFo/DdfCrL17Q+R?=
 =?us-ascii?Q?sQJtJaM0bhxJKg5OD0KZULAkYiiqoGF9pyOztts1UxTsWKrx/D5DCXAKI9OX?=
 =?us-ascii?Q?Kg47ZB5OGYqPcLmQx75+VTonWK6Vw0+VPj4vMex2oS5rdHojoJ92kzzUyym0?=
 =?us-ascii?Q?XLkYbApT2jwmdv2jlHHEAgtY4LRwXt8YioYUUnMSk9PfwNh7SJb/Mk9elzlN?=
 =?us-ascii?Q?y0xB0zEfoBCevHdomOv6yCzDiF/oXzqJ+P/HpGkA42sNVqmiJfiFxgHo75bT?=
 =?us-ascii?Q?tq37K5kSmO8+G2wudK504pZcLwQ168QiOOA6U9t/2zeueyvWBJ3H/5JgXEFc?=
 =?us-ascii?Q?hP0J+HZGPH4SIf/TAkdHt3lEr7DpxwPp51kFHMmk01a2Kn1cUO3nj5Qd2QNG?=
 =?us-ascii?Q?KLlcG+CyxChnX46c0dNQbPS0TfCb4wixCX/X/fhh32akaHCjGVZZ8sVx34ze?=
 =?us-ascii?Q?Y1T4BWLQHEd//85HFgrRRqxczNZtUymAbKeJ3h2aCmbGbKSE/kVJhYOq0Pvz?=
 =?us-ascii?Q?VPYgv5Sw/ajsk9L0kACVqSM/dYNDP0YlVy4tPCOMVK2auBw/DfDu8NXKy47b?=
 =?us-ascii?Q?LkQVLijE7velvWn2oxs0NLGRyXJaaODDL2YbR8tXHDeayF+D2uabkWgrCsgG?=
 =?us-ascii?Q?NtD8u+/BNwE/1EDXT2pZhu7aU2rAluI8InW6Dc4D8sU8m3AQ8dexZsi53KLA?=
 =?us-ascii?Q?/LXlBTNPGrMkF3nRhzKuAq5LQ/S6GUf+ZKvrXSSV1yexQUR9U8Xxsk1UvP78?=
 =?us-ascii?Q?Vd4VP7HgX9avJOG3gZwfThly5xnuyo3GgsX4WUpAhsA45ccKPkEPYwoVz78T?=
 =?us-ascii?Q?xntKLHH7a4vFrqkkvbr1i2n0UMwfqkxJDr51vzC5nEk+KxBzfcI7Gxyb+a6u?=
 =?us-ascii?Q?zCqEsdnRRr3xfNKutzz7T7waSOd6uGEOTG5B92IGcHmZrY7LpZhs5AGq/LF8?=
 =?us-ascii?Q?7J+I49a7UtUlLnqMFm2bDzfb/Vqfrb7JAaMmrqldbQHqJlsSmdOic7CNU2um?=
 =?us-ascii?Q?NkZQgeLtayPvL8buhZFTbRogoRKhY1HB20nLvVcnmK9zB0yXo+JHZwGfPs2g?=
 =?us-ascii?Q?YsBhwuwWfCDzEDBxxrHhjrVToN85nI1BfpU/s/m6TqN9iEMC5UfsI5/DADye?=
 =?us-ascii?Q?ZEGdBTq9bxP6Gxw+9IeTY9IpiNxwhdb/NuvjIzDWf1mN/vi7/Ouum0JeFzWQ?=
 =?us-ascii?Q?5sFiFAH+JWU28VPnaZOfOp7a0Zy39NKCbdEZNBs+czWZW8ch/pCygkhSjqU6?=
 =?us-ascii?Q?zPiZbnrKW3mhlSidodoqCNti4/MGupRxg3myRSnPFf2ExGrbBuxFjcELAB11?=
 =?us-ascii?Q?8V+6zPES9S+nBAsYebTZYlIcESYRqlVmRO9tPWznnqwr7lMan0Xgi3Et1KG5?=
 =?us-ascii?Q?Zv+2ieQUA84rQfCAZvJ2kzEwQvN08L0Je2il9WV/DKuUMJ5BAEHh/oUsjsEc?=
 =?us-ascii?Q?awLftSr7qzbBnAqnStE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 557c257f-a640-4afe-97ab-08ddb6e0abcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2025 07:43:42.7263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3f2kknjn3qOt2BheFswyxh0H49b9YbgNttkNonBLTwIBGz0DxjU/tXniWqxVtK1HBUUGm1D7ByBQemQp/6iQWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6238
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Saturday, June 28, 2025 17:00
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Xiang(Dean) <Xiang.Liu@amd=
.com>
Subject: [PATCH] drm/amdgpu: Use correct severity for BP threshold exceed e=
vent

The severity of CPER for BP threshold exceed event should be set as CPER_SE=
V_FATAL to match the OOB implementation.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cper.c
index 2f15d654bea2..8efaf7492fa0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -212,7 +212,7 @@ int amdgpu_cper_entry_fill_bad_page_threshold_section(s=
truct amdgpu_device *adev
                   NONSTD_SEC_OFFSET(hdr->sec_cnt, idx));

        amdgpu_cper_entry_fill_section_desc(adev, section_desc, true, false=
,
-                                           CPER_SEV_NUM, RUNTIME, NONSTD_S=
EC_LEN,
+                                           CPER_SEV_FATAL, RUNTIME, NONSTD=
_SEC_LEN,
                                            NONSTD_SEC_OFFSET(hdr->sec_cnt,=
 idx));

        section->hdr.valid_bits.err_info_cnt =3D 1; @@ -325,7 +325,9 @@ int=
 amdgpu_cper_generate_bp_threshold_record(struct amdgpu_device *adev)
                return -ENOMEM;
        }

-       amdgpu_cper_entry_fill_hdr(adev, bp_threshold, AMDGPU_CPER_TYPE_BP_=
THRESHOLD, CPER_SEV_NUM);
+       amdgpu_cper_entry_fill_hdr(adev, bp_threshold,
+                                  AMDGPU_CPER_TYPE_BP_THRESHOLD,
+                                  CPER_SEV_FATAL);
        ret =3D amdgpu_cper_entry_fill_bad_page_threshold_section(adev, bp_=
threshold, 0);
        if (ret)
                return ret;
--
2.34.1


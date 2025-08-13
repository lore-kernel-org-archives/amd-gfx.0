Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29208CA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 03:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B704710E694;
	Wed, 13 Aug 2025 03:08:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VSoiMrsp";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC0C010E694
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 03:08:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEDRnbIq0GrpFVW0FHs3swbdfuT4bIFUuvjOYX3g5Ll9z0YpnkBEFUBl3j0kQ7ctlmQG852lJRE69GwdtaqwYTMQIqpZ0j+5L/tv3nI53DOvbkprX6WWdK52tnOAQJXxxFZ255GHc/NNkbda2A61XWnemVLnSB0DwcgMXEAnR2fXCfuMR74NNE6tBIYrSZiyo69SC25WC0xT5JdLk72rGa6Jga9nc5ahcb/Mac3T//4/6HONeXy6JrCl1cPMX+fFvmQ3aiFjuRG0LZGsfpzEtnxPlNWQ7ds+xEryY1HrUz2E5X7l4rfPESFPJ7odENbXQTZEF+c5aQ8a75slKykDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cMrtO44PF5sa209YgX2gaZeYhSRXYhKPR1l31O5oDv8=;
 b=ehuESjUT9trb7CnbZC72E7UZQczYDsHYFHOzJ5URhxvxdXe+dQaP6+jHDUVGKqsea1TS3/XZ+7oijac0cVW99BTXSy8SYMFLcBw37sa9+5ar4fvtjb8ESPgZ0wDhRw9D66ENJzfaQndVA2J9OyMYieK+ZTuEfNdjg93JGg6e9kCD7/u5Mv9WQJVJawkrVtMYN8QxOjYVpZZ4d7fxuyPK4MvCA6q2BPzJaECiow55Iho4AQr9ZlSJC3vbWC5yeUs1Gynae5dHNGW0xNMN+bFaE7aF4s8eUFGLiQKItLeVF2ero7t3cQOoOKo0uxodqkE9vzGa0/Pid88VnOrPOfxkLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMrtO44PF5sa209YgX2gaZeYhSRXYhKPR1l31O5oDv8=;
 b=VSoiMrspDSyaU6SnnAgvr3p2BuwL0CyRuX2yrpXWnzzK57myUx+oFSiiZkx3H3Gg55olJgtAdXWwYlOrlu1IgzhOgbvnN8xcEzBJFI3DgOrDyDz3me1IDGs+09+sDWE7SSKKiN7ngr7XKTGkuO++QPoDcREvJFrf0bKYVla6DEY=
Received: from CY8PR12MB7657.namprd12.prod.outlook.com (2603:10b6:930:9d::14)
 by PH7PR12MB5952.namprd12.prod.outlook.com (2603:10b6:510:1db::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Wed, 13 Aug
 2025 03:08:26 +0000
Received: from CY8PR12MB7657.namprd12.prod.outlook.com
 ([fe80::dc50:9698:ac9a:b44b]) by CY8PR12MB7657.namprd12.prod.outlook.com
 ([fe80::dc50:9698:ac9a:b44b%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 03:08:26 +0000
From: "Gande, Shravan kumar" <Shravankumar.Gande@amd.com>
To: "Xie, Chenglei" <Chenglei.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Pan, Ellen" <Yunru.Pan@amd.com>
Subject: RE: [PATCH] drm/amdgpu: refactor bad_page_work for corner case
 handling
Thread-Topic: [PATCH] drm/amdgpu: refactor bad_page_work for corner case
 handling
Thread-Index: AQHcCHBHwG4P64B0B0iCUVUTjjQhI7Rf7gng
Date: Wed, 13 Aug 2025 03:08:26 +0000
Message-ID: <CY8PR12MB7657754E244DF3B3B0AFE11E8B2AA@CY8PR12MB7657.namprd12.prod.outlook.com>
References: <20250808142447.2280-1-Chenglei.Xie@amd.com>
In-Reply-To: <20250808142447.2280-1-Chenglei.Xie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-13T03:07:52.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7657:EE_|PH7PR12MB5952:EE_
x-ms-office365-filtering-correlation-id: 03f72550-8d9a-49fc-82ef-08ddda16abcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?xeGaz6hVaoWGH9uxAxO82qma8CMrM9klh69LVMD5HVDllO3QVyDavAp9s98S?=
 =?us-ascii?Q?H4JC7uKYY3jZU6kcN+7rgmzUS2eYLgtqVqWFCKSLokEwB6zMg55c8QhxRm1N?=
 =?us-ascii?Q?juY6CSzMHwXN9Gwx8d+x6UYl41b9TWPsrWcZtyY3f31hmQFRVKZ9l9vEUEne?=
 =?us-ascii?Q?Qt5Wwlw6lhQ+EGT7qdYFzWk6LS7cOg/FFmG5LRsHlY8ZNzM1E5SEl9jEH0lW?=
 =?us-ascii?Q?XTd60A7CeqnpYDjo3smDGqJNtyBK0Vh2e1VoG3yGWffZINJBF8M5GeS4UT92?=
 =?us-ascii?Q?6uZvs/e+HBjlN3yZur+NRpB1LyNzClS7pnNd/XOr9oM3/WqHOibSTH0ZvJFs?=
 =?us-ascii?Q?VuAwnWg7FIsD32HL1UtuQXiCSEsCJpa+uXE4erdoeq7N60M2FklPCTzD6JAY?=
 =?us-ascii?Q?wevIR++/yE0awqlEYGyQNavYkEks3JDVSpsQLbXqDr53vmLnOiNdJedagpsr?=
 =?us-ascii?Q?Y30RHpcSubLgOZTjv9zzXwFOdP+a+WyLTzL7KjKi0z4t/XldziT4PekdDQtA?=
 =?us-ascii?Q?Spxvi0CcfcUzK41GByTCcuFuXrNB+dXeqfsuD5OIJA/NJQzxcLcuMK3mBoLE?=
 =?us-ascii?Q?tkOHvbuA7QMIaxHMzghtd+UGlysuxyomxIU+6+r6lDG+JHDdVNIphqiD6yXb?=
 =?us-ascii?Q?WqSdjBx+oAqfXlrtKUgFyK7CtjSidaSzh7vmUftuVyavaBCVbGnhRUeUsjUk?=
 =?us-ascii?Q?IRmrTTML+csAQEBZV5avY7lQhHtCcjwQE4XqOm0rGl9/cnkwX362Wqdv1lF+?=
 =?us-ascii?Q?x12SL7KQKV29Bfr9vIB6R9YhvMl2q/o9LNaE/2iclNNOeCbeYFa92lWSPKtl?=
 =?us-ascii?Q?RIL0HE5RzhLfSlLBtdft6rysZEEZx7ePgsbPhKiQtG+tnpybn9CPm0FBpryT?=
 =?us-ascii?Q?iDcgw/pOmz9mq9ugcm3uWDwwyL6oYgmvfmqgVyQrsI46MLLjPhMcnN3R4ixx?=
 =?us-ascii?Q?B8IInri4MyZfIbuphzhm78hHMeJWlTM0QOZcM9wgylT+8h7M4RqeCH7DUeEO?=
 =?us-ascii?Q?AgP3wkPTmglc3r/utSAswZBYWU4ZCEw1FO63fYTVfI8tTCZEO+aix0EUYAPY?=
 =?us-ascii?Q?RTHDFP9YckFRvoudo6PL5z52qino5aPVxnFddwj3nctV7+Djia7vQr1L4/W8?=
 =?us-ascii?Q?Q1aQnWFNHqCAm69YrDq7iERsKLn0ZfCWWAFhmEbPbNQncYuwMWlmb2jXLEOt?=
 =?us-ascii?Q?kzBHwIAEeHPiFlkfjhERvEojmdoYDFY2ts9MhNcRfppp0yIfU2/9ePEcsxV+?=
 =?us-ascii?Q?BXhxmggMA082yDhuhgyEpnqfscqoz0WapW+j7oiJY1u0fOG0kgga25DgYyfy?=
 =?us-ascii?Q?Ft/3n2ljyS439SR197EwYugoHoGglP+bOJWW7DCGSc8fEIvBzer7VFzH4KIn?=
 =?us-ascii?Q?J2xExEK2AYgRT94c+ng59Ii1DsxluMEX6Ys6vlNXIfZiBPF86bV/2phGDyre?=
 =?us-ascii?Q?FGwQklgG1v56Ptdowf29DCuIU5sz8AKvoKBeJIhleK5GUgNIdXnLCg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7657.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W69IUDJZWT/UuELM30Z2app0iT22BB4+mka29kmdiv1/eNogHZyMOMoffyug?=
 =?us-ascii?Q?hR/2l8g8EASQAQqdMFj2W7DxC9P8dITqP0Fg1/ZCPmfpaUnsm8BUQJ+4a1my?=
 =?us-ascii?Q?QOLRNlMZeV3h8HMgj6RDgQumywbjr8oOjYhsfxQNCSJKj3a1JKelx7ECfQ8k?=
 =?us-ascii?Q?DJ8FEvl7MkN1cvQotjRYNd/fEk78MPl/UG6dgNngY7kHs8Cj78jXKiJuBGRr?=
 =?us-ascii?Q?JxikNRP1uq6OmZZb1slxMu0GNtzy6RFtoK+P23n6chJYlu+nmdIscAPXA9lf?=
 =?us-ascii?Q?5bSuvFHpeCrp3LSA4PqdJXMlc3wyeOCWmCwaBsUCOrV6OoG/luj977zO0iTF?=
 =?us-ascii?Q?HjPO0fHSwFpit3fv53LHC+2mHm+r/e/mB4MKZ0BTOOq7t7wgOSqsAUu8YSVs?=
 =?us-ascii?Q?qHxALZAMxTRwecXULN15m2lzhQIbuDF7n3XDzU35FOgBz9j+oHPGQQyYYoJF?=
 =?us-ascii?Q?f6ZsV957OeBK/W1KkT3fe+htqrwDjW5Wjsr16bGONHvK3JBL6yJ9IcuH+mAG?=
 =?us-ascii?Q?sQ56Z2ee5FwsMRYd0T0I2yzKcY0YsI5JD3w8bXE5LHwMGBss4KPOssk/hF7B?=
 =?us-ascii?Q?BqszNTmaFb/lXez6Pf44GP+LHQ0WxmFzYPY2eNQtrKUQreWK2ibtdZMYMjBj?=
 =?us-ascii?Q?UmzDHYP6qJhQIt/6XiGI04QRU0uRcoxDmEbiWB37DjNaOZhTMa3Y5D0RwdIA?=
 =?us-ascii?Q?vY1l3MlyrnmJWNbel+kzPVz4q/cd9NWLiSicVEPIXWyQRAAz1Gd4k/kXNqGy?=
 =?us-ascii?Q?HTSoyBjzJ4FD1vDe4ci9uB6I88bpXRR9fXs+BCDxGFwNSfumF2N7payXcWjm?=
 =?us-ascii?Q?g9e4rE82NkDeH93CzGTngRcXpB6API0c+ozAwiRn67a4jtRG1myk6GUolQh7?=
 =?us-ascii?Q?eZzEm6/i+aS3uttetd2jqWF3XLJCibw6ms6tMOkjR9Rp/4IEs8JO+CttO3iQ?=
 =?us-ascii?Q?EM/6IWPzL1WpdO1f50YNXBICgrsWL+XcbfdS9q0QB9Exzgv5Lb9WhZZf+0It?=
 =?us-ascii?Q?qPax7E8FPOA3+lJ70J0xs2nNcV/RR+3CkBQHvwGfyJMRuWG6tw2lMDDk64Oh?=
 =?us-ascii?Q?PICHED6lsMRfujWEINfr57pMQk1zyPmPTar4hh+UgpsDpvla6jetwVBehjK6?=
 =?us-ascii?Q?zRHpVvcuKNrdUvfcKTkMLIMk43CEOUsIW2ti1DGnG5ISNz/AAvTzllD3O1Vy?=
 =?us-ascii?Q?f9bis/MVm7izf5zbW5ieGctD+UDsTYp6dEnmttqUjZSNIPFaI7K6Cko9dXQq?=
 =?us-ascii?Q?tSGjM3tqBB8qpI5QkkH7LEQzVm+Fm1S7SDZlq2ueSTzLWAXM3J/CX82oJ0C8?=
 =?us-ascii?Q?jZ6ccblBB4FGMMwDUqIhDEi0n9YEKMsccVVTPQydySUg6VPDrnjohxgMGNOO?=
 =?us-ascii?Q?A5twnSaCuDwihTGGrWYWDvyv45aqfWEAZsJ2PkCjk3mwi7x0E2PVE7c4WWel?=
 =?us-ascii?Q?/3UBTgJ4rL3yk85PWNeXsFDjpqX6FT9ggyJDbV3qMtzUAuOFhOp15NeFTJmb?=
 =?us-ascii?Q?cnloK7Bb4DlrhV0i7mUrpiIYaAc2SjXYds8LJ8UdhQw6sZWfRIsjnrkIiujA?=
 =?us-ascii?Q?94fBSYFSk5rBJAGVUbQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f72550-8d9a-49fc-82ef-08ddda16abcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 03:08:26.2943 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VjJ2A7A6ePX45pfTb7EoUStCU691DaQnAD7Su/UbKJg2YPBf+9ft12qsaYTSOQTK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5952
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

Looks good.

Reviewed-by: Shravan Kumar Gande <Shravankumar.Gande@amd.com>

Thanks,
Shravan

-----Original Message-----
From: Xie, Chenglei <Chenglei.Xie@amd.com>
Sent: Friday, August 8, 2025 10:25 AM
To: amd-gfx@lists.freedesktop.org
Cc: Pan, Ellen <Yunru.Pan@amd.com>; Gande, Shravan kumar <Shravankumar.Gand=
e@amd.com>; Xie, Chenglei <Chenglei.Xie@amd.com>
Subject: [PATCH] drm/amdgpu: refactor bad_page_work for corner case handlin=
g

When a poison is consumed on the guest before the guest receives the host's=
 poison creation msg, a corner case may occur to have poison_handler comple=
te processing earlier than it should to cause the guest to hang waiting for=
 the req_bad_pages reply during a VF FLR, resulting in the VM becoming inac=
cessible in stress tests.

To fix this issue, this patch refactored the mailbox sequence by seperating=
 the bad_page_work into two parts req_bad_pages_work and handle_bad_pages_w=
ork.
Old sequence:
  1.Stop data exchange work
  2.Guest sends MB_REQ_RAS_BAD_PAGES to host and keep polling for IDH_RAS_B=
AD_PAGES_READY
  3.If the IDH_RAS_BAD_PAGES_READY arrives within timeout limit, re-init th=
e data exchange region for updated bad page info
    else timeout with error message
New sequence:
req_bad_pages_work:
  1.Stop data exhange work
  2.Guest sends MB_REQ_RAS_BAD_PAGES to host Once Guest receives IDH_RAS_BA=
D_PAGES_READY event
handle_bad_pages_work:
  3.re-init the data exchange region for updated bad page info

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Change-Id: I053524bde337ff42987e0730dc92c53e2de3a152
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  3 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c    | 32 +++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c    | 35 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/soc15.c       |  1 -
 4 files changed, 58 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h
index 3da3ebb1d9a1..58accf2259b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -267,7 +267,8 @@ struct amdgpu_virt {
        struct amdgpu_irq_src           rcv_irq;

        struct work_struct              flr_work;
-       struct work_struct              bad_pages_work;
+       struct work_struct              req_bad_pages_work;
+       struct work_struct              handle_bad_pages_work;

        struct amdgpu_mm_table          mm_table;
        const struct amdgpu_virt_ops    *ops;
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.c
index 48101a34e049..9a40107a0869 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -292,14 +292,32 @@ static void xgpu_ai_mailbox_flr_work(struct work_stru=
ct *work)
        }
 }

-static void xgpu_ai_mailbox_bad_pages_work(struct work_struct *work)
+static void xgpu_ai_mailbox_req_bad_pages_work(struct work_struct
+*work)
 {
-       struct amdgpu_virt *virt =3D container_of(work, struct amdgpu_virt,=
 bad_pages_work);
+       struct amdgpu_virt *virt =3D container_of(work, struct amdgpu_virt,
+req_bad_pages_work);
        struct amdgpu_device *adev =3D container_of(virt, struct amdgpu_dev=
ice, virt);

        if (down_read_trylock(&adev->reset_domain->sem)) {
                amdgpu_virt_fini_data_exchange(adev);
                amdgpu_virt_request_bad_pages(adev);
+               up_read(&adev->reset_domain->sem);
+       }
+}
+
+/**
+ * xgpu_ai_mailbox_handle_bad_pages_work - Reinitialize the data
+exchange region to get fresh bad page information
+ * @work: pointer to the work_struct
+ *
+ * This work handler is triggered when bad pages are ready, and it
+reinitializes
+ * the data exchange region to retrieve updated bad page information from =
the host.
+ */
+static void xgpu_ai_mailbox_handle_bad_pages_work(struct work_struct
+*work) {
+       struct amdgpu_virt *virt =3D container_of(work, struct amdgpu_virt,=
 handle_bad_pages_work);
+       struct amdgpu_device *adev =3D container_of(virt, struct amdgpu_dev=
ice,
+virt);
+
+       if (down_read_trylock(&adev->reset_domain->sem)) {
+               amdgpu_virt_fini_data_exchange(adev);
                amdgpu_virt_init_data_exchange(adev);
                up_read(&adev->reset_domain->sem);
        }
@@ -327,10 +345,15 @@ static int xgpu_ai_mailbox_rcv_irq(struct amdgpu_devi=
ce *adev,
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);

        switch (event) {
+       case IDH_RAS_BAD_PAGES_READY:
+               xgpu_ai_mailbox_send_ack(adev);
+               if (amdgpu_sriov_runtime(adev))
+                       schedule_work(&adev->virt.handle_bad_pages_work);
+               break;
        case IDH_RAS_BAD_PAGES_NOTIFICATION:
                xgpu_ai_mailbox_send_ack(adev);
                if (amdgpu_sriov_runtime(adev))
-                       schedule_work(&adev->virt.bad_pages_work);
+                       schedule_work(&adev->virt.req_bad_pages_work);
                break;
        case IDH_UNRECOV_ERR_NOTIFICATION:
                xgpu_ai_mailbox_send_ack(adev);
@@ -415,7 +438,8 @@ int xgpu_ai_mailbox_get_irq(struct amdgpu_device *adev)
        }

        INIT_WORK(&adev->virt.flr_work, xgpu_ai_mailbox_flr_work);
-       INIT_WORK(&adev->virt.bad_pages_work, xgpu_ai_mailbox_bad_pages_wor=
k);
+       INIT_WORK(&adev->virt.req_bad_pages_work, xgpu_ai_mailbox_req_bad_p=
ages_work);
+       INIT_WORK(&adev->virt.handle_bad_pages_work,
+xgpu_ai_mailbox_handle_bad_pages_work);

        return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.c
index f6d8597452ed..457972aa5632 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -202,9 +202,6 @@ static int xgpu_nv_send_access_requests_with_param(stru=
ct amdgpu_device *adev,
        case IDH_REQ_RAS_CPER_DUMP:
                event =3D IDH_RAS_CPER_DUMP_READY;
                break;
-       case IDH_REQ_RAS_BAD_PAGES:
-               event =3D IDH_RAS_BAD_PAGES_READY;
-               break;
        default:
                break;
        }
@@ -359,14 +356,32 @@ static void xgpu_nv_mailbox_flr_work(struct work_stru=
ct *work)
        }
 }

-static void xgpu_nv_mailbox_bad_pages_work(struct work_struct *work)
+static void xgpu_nv_mailbox_req_bad_pages_work(struct work_struct
+*work)
 {
-       struct amdgpu_virt *virt =3D container_of(work, struct amdgpu_virt,=
 bad_pages_work);
+       struct amdgpu_virt *virt =3D container_of(work, struct amdgpu_virt,
+req_bad_pages_work);
        struct amdgpu_device *adev =3D container_of(virt, struct amdgpu_dev=
ice, virt);

        if (down_read_trylock(&adev->reset_domain->sem)) {
                amdgpu_virt_fini_data_exchange(adev);
                amdgpu_virt_request_bad_pages(adev);
+               up_read(&adev->reset_domain->sem);
+       }
+}
+
+/**
+ * xgpu_nv_mailbox_handle_bad_pages_work - Reinitialize the data
+exchange region to get fresh bad page information
+ * @work: pointer to the work_struct
+ *
+ * This work handler is triggered when bad pages are ready, and it
+reinitializes
+ * the data exchange region to retrieve updated bad page information from =
the host.
+ */
+static void xgpu_nv_mailbox_handle_bad_pages_work(struct work_struct
+*work) {
+       struct amdgpu_virt *virt =3D container_of(work, struct amdgpu_virt,=
 handle_bad_pages_work);
+       struct amdgpu_device *adev =3D container_of(virt, struct amdgpu_dev=
ice,
+virt);
+
+       if (down_read_trylock(&adev->reset_domain->sem)) {
+               amdgpu_virt_fini_data_exchange(adev);
                amdgpu_virt_init_data_exchange(adev);
                up_read(&adev->reset_domain->sem);
        }
@@ -397,10 +412,15 @@ static int xgpu_nv_mailbox_rcv_irq(struct amdgpu_devi=
ce *adev,
        struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);

        switch (event) {
+       case IDH_RAS_BAD_PAGES_READY:
+               xgpu_nv_mailbox_send_ack(adev);
+               if (amdgpu_sriov_runtime(adev))
+                       schedule_work(&adev->virt.handle_bad_pages_work);
+               break;
        case IDH_RAS_BAD_PAGES_NOTIFICATION:
                xgpu_nv_mailbox_send_ack(adev);
                if (amdgpu_sriov_runtime(adev))
-                       schedule_work(&adev->virt.bad_pages_work);
+                       schedule_work(&adev->virt.req_bad_pages_work);
                break;
        case IDH_UNRECOV_ERR_NOTIFICATION:
                xgpu_nv_mailbox_send_ack(adev);
@@ -485,7 +505,8 @@ int xgpu_nv_mailbox_get_irq(struct amdgpu_device *adev)
        }

        INIT_WORK(&adev->virt.flr_work, xgpu_nv_mailbox_flr_work);
-       INIT_WORK(&adev->virt.bad_pages_work, xgpu_nv_mailbox_bad_pages_wor=
k);
+       INIT_WORK(&adev->virt.req_bad_pages_work, xgpu_nv_mailbox_req_bad_p=
ages_work);
+       INIT_WORK(&adev->virt.handle_bad_pages_work,
+xgpu_nv_mailbox_handle_bad_pages_work);

        return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c
index 9e74c9822e62..9785fada4fa7 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -741,7 +741,6 @@ static void soc15_reg_base_init(struct amdgpu_device *a=
dev)  void soc15_set_virt_ops(struct amdgpu_device *adev)  {
        adev->virt.ops =3D &xgpu_ai_virt_ops;
-
        /* init soc15 reg base early enough so we can
         * request request full access for sriov before
         * set_ip_blocks. */
--
2.34.1


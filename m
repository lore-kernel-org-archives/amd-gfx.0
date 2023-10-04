Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2C3E7C4ED
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 18:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B214210E3B0;
	Wed,  4 Oct 2023 18:21:16 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A6710E3B0
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 18:21:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q25Fa4B+xe0ssY5foP/mJqVK3JOShr2tToWONZVhj67vlz3EiYdBrYElWVIzWRteVH8WlxOX5yqaJEFKwsDYhNHvhUm+etaC3xW5wVikWwNlIy/dDN33IzBj2FfsclrhVyQOamIaruJYQc9MqwSNswd5wM9jGimYXskEdvqBrnSMzVANJGDdJvtHm0CauDKOOO5Xo3a+boR+GxqUtJiTeYIacTYe0qTGQncaGuVw+TCo0DZsdl3AblpImdVA6svS8VJVCqUz4A4I2JKk4TatlzeN2V/fhKIYSgiez3AWfa03IF5Vfe8ZyPQ/gt/UT0j51os74H5mHsALzJgcjn+rRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9imqPiCMvjbW1V6FoUsTfIm2X7eYUvHNWQqfiRxHYU=;
 b=fH/otJkoTfViER+FqK218nAf7//xq1+TLw8GVuE4op0u6U2EX2oNkbzy08bNLfXrBwkmAiDxTaowZRBWXY7/oJglufjMzSlZtYutUjxKgNdq+yCaVTSAwaoOWzG2O0Uuh+lxQFo1BVaqvCPZr0qfffs7eVddCT9zwebHYsAeJDMeQp1XHfn37F30bvsNujHmTFrA+qi5bjNP/yv3xqBmIOOihYcUOaH79ZN0CTIjplD62fz837+r/73bAMlB8//U/sJVi0qSrxhTn613xBlXxDHMVFdVSRcvlVaKFUsXZvcunBLNoFgjxEUd2gXvJHqabQBsa2OaafTjg3GmU40/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9imqPiCMvjbW1V6FoUsTfIm2X7eYUvHNWQqfiRxHYU=;
 b=ycOs1prCQIbKKhjVx9Pv5DtdMfs3eM7BPA943xAQEXrsEbll4B/uniAyiotPoUX36i1WLMPy+J7IZPF+0Q+BuIntoiOh9orgyny+sH8EJ4iG+HgzciQ1+LywboWDL61QFyffKDTH5d+vwWFkNzbO2iGIlJ8McNFn5/o102y/icQ=
Received: from MN2PR12MB2909.namprd12.prod.outlook.com (2603:10b6:208:103::13)
 by IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 18:21:12 +0000
Received: from MN2PR12MB2909.namprd12.prod.outlook.com
 ([fe80::5759:e108:636a:f417]) by MN2PR12MB2909.namprd12.prod.outlook.com
 ([fe80::5759:e108:636a:f417%4]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 18:21:11 +0000
From: "Francis, David" <David.Francis@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amdkfd: Fix EXT_COHERENT memory allocation crash
Thread-Topic: [PATCH v2] drm/amdkfd: Fix EXT_COHERENT memory allocation crash
Thread-Index: AQHZ9jtWAJk9uAtN+06ucGdPDVwnILA4lxMAgAEYV4A=
Date: Wed, 4 Oct 2023 18:21:11 +0000
Message-ID: <e0052e58-3c17-4015-b6fb-f458cfcaca30@amd.com>
References: <20231003205029.4764-1-Philip.Yang@amd.com>
 <995b4966-3902-dbdb-1991-b30e158e991b@amd.com>
In-Reply-To: <995b4966-3902-dbdb-1991-b30e158e991b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-04T18:21:11.087Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
x-ms-exchange-imapappendstamp: MN2PR12MB2909.namprd12.prod.outlook.com
 (15.20.6838.030)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB2909:EE_|IA0PR12MB7627:EE_
x-ms-office365-filtering-correlation-id: 84ba0c09-f511-4a52-f965-08dbc506b02e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: neB4iLW7oM+8FlHtYc9pUp903qoLO1MF1WOUnkOaiACCu+N2NJmptBVu0qXmIszfSaoV1SuWZWBbIPdQyVkdY5f+aL+adyICJjrDdSuI5jRol9UqTIi0M3jFYmPWI7m2E48WZ0mJgmN+uoAX7RQG3VRygV5Nmsdh75QoUzAmdJGKj7DHNHjojUk/99lEZtAnBHr5RwLw01CKGfjQFNzRgCr/mhF6Zo3W6YvpW8UAeMUQkUU3pE7/nONTDlS+RGW4S53w/Zwjsj/bnxfKqS3nOfIYtVQ+Wumde2kzz8UOoo/v0BEgryNC+rTHWKoUom4RcbSaqOoSVoYC3aGbaSqNvaoqXvr846JpAI+eARxX98riFKfttuy0ELIdDB9lPUeWz10dbbn0XbFD3miQOvd3pLcVUVc2YTomaAvmVi2DQYEbS4GeSvnEP09kZO0tDS8Eo0JFw3as4Qw7147A4pQRMyY8zGmOtu/jrHzcYyjut1oRvv2wTrcq0OLbhFj4zBr8yAcQqg6KvCx26jIGKcOeYQiy3m+t5wPDAlEnztTP/GSbi6Td6IKKudgKPxI2rX1spfoHitZm8kKbvWVWFKLynHhIGDvA+HrPAkKbx5jAOalNGD4dAcTlFl/IpNa08zk8vfeoD+JpsvFS+8NB5135Ig==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2909.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(41300700001)(110136005)(6506007)(478600001)(6486002)(2616005)(91956017)(66446008)(53546011)(76116006)(66476007)(316002)(6512007)(66556008)(64756008)(66946007)(8676002)(8936002)(5660300002)(26005)(71200400001)(19627405001)(31686004)(83380400001)(2906002)(38070700005)(36756003)(38100700002)(122000001)(86362001)(31696002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2RBdCwoILpqEUy8OUeocQJKbQEGFkq1RUchFlUo4wXEsx5IBfAt6d/W3ds?=
 =?iso-8859-1?Q?v2flHc3cYyDC/9waFyE5x4jIXd7LRrMq+P3mKlU+4s4AQlDvXPQ3pXV1PH?=
 =?iso-8859-1?Q?nzPsaIsK6P2XmIAl9NL4VlD0gEKGuMPJpsW0tlrG7tJK9vNWPSZn/dGnNL?=
 =?iso-8859-1?Q?UFnXgbzjIYTSQldKSnkEAyq+dbJfgxxmuTVHye0z8aPN3uS9j1PNvjlzW9?=
 =?iso-8859-1?Q?Ctv5J1ojDD1xKNnwEzVQ9sUJvFT1n8+FhuMCKCZH4P7vFnnTmKb14EnhwG?=
 =?iso-8859-1?Q?lzTXzcEuTNKHEmecsFeJK0kQumYHwC2r5cUghcUSvQh5o44pJKA1Jfn4nc?=
 =?iso-8859-1?Q?QkxFewoeFdj+zNTGX/Z6EM4qWeyJTQagwDQj/mBoSFo8HD3EpTfv8CTD4G?=
 =?iso-8859-1?Q?e1bSJjZW4ERZg5zEcj7C2NQe9lAC+JMspAhJE9QREH+Du56HF5ZujrphAD?=
 =?iso-8859-1?Q?QySD/vRe9HsL59WiLFq2MHHzpN6hlVrJU8UuYga3FgHf7EjcWvJv50jrw9?=
 =?iso-8859-1?Q?D/hubzmtJQRwQixyT6YtkdyFaXAcKmQMupWn4hs0IwgG31Z8TkbXxFgEPm?=
 =?iso-8859-1?Q?pyqO4w0Pf2Edqx7NCi7f8onQvwOD5Px6La/7x6p5NblBuUceBnrnTctQEE?=
 =?iso-8859-1?Q?b8RXRcM52Qs5SEcWtDQLgSxaJCZYtdMwUTol02BV9VbpI0m5x5raAalwyv?=
 =?iso-8859-1?Q?uDt0RoSxtFMMuSS/yFbuPAmJTJwzaphH0yZ036TPzMXvZY/HTHPbudQttO?=
 =?iso-8859-1?Q?0yHSZX37UURvN8/bLTi/Ld0iGxNkUAsDCG4yqJR3KRT3KVVmo5vkqb6i/a?=
 =?iso-8859-1?Q?DXpBoasqxDrfrn3921DF4V8HQozzpS+mhFb7kXZDS6L513QbC+KGR6lipO?=
 =?iso-8859-1?Q?i1gZcobBOnkvHkkvdU1A4KJavUrxHET7SqX9YzeFiXYpvHDDvbVU+SeyHY?=
 =?iso-8859-1?Q?9Nc3I/w1NamU2cr+WeHvswQSIc1UnvrrPMeIECfkjGeobYTCzSQYP2NZrt?=
 =?iso-8859-1?Q?PmviwV+lKig2R/HthLxnP/pMoBsUWnaIVHwhI+O1vYSYt0cGiCHK2mK9eW?=
 =?iso-8859-1?Q?ye6X0CVGYxhvinLFXqawUBWHeIc7X4tYOBn3YOvetdwvQhempz3i5Fp0Xz?=
 =?iso-8859-1?Q?QzhYuvZZeJ6MxnvIm1YEL6odhUmsZoLjKQzKu6u2WnjWymyoSL8+fh0+zW?=
 =?iso-8859-1?Q?BsZYKSmxyMFrhJzNL3eqcXCJe+EwxH8kK6OnLGZ14IXxItXdKFeHWsPbI0?=
 =?iso-8859-1?Q?5c768uBIeFdQHvPadiBVSMDqdkAeGK1MpyOx3r+ZFJs3JI1Wd3V4rALKSI?=
 =?iso-8859-1?Q?0ZdrXA8505r7ULh11X/dP3/3nNNHOUobdZDz4/9rN5jbidWrSL6vl7YnDx?=
 =?iso-8859-1?Q?Lb1aMI6735xCTsL34DOXx5/j+VWAfFluxiukiiAenqTkmATuOVaWpNkrl7?=
 =?iso-8859-1?Q?xhVbwqDHMl7LKgQEbMdNXKsjLE+CzNR5Qq76O/wUtIbZYLVpPfXBiGc/13?=
 =?iso-8859-1?Q?91ZUWeut+kC2bvayNyR6ikP1eGWXxKL22/40ygmC5TzpH0mMapM8xZv+oK?=
 =?iso-8859-1?Q?NqxcbDNE08lxEsaL3bMYweaMeYFM6wFxSLnTNKH46ylvxmSG73XDQjsXlZ?=
 =?iso-8859-1?Q?2HvlVPuCQpIJk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_e0052e583c174015b6fbf458cfcaca30amdcom_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ba0c09-f511-4a52-f965-08dbc506b02e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 18:21:11.9344 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IJexB+8INA0cXts5h5D2IQ0JkGcnfn9iTAO5HfPKfsXrPeIMNpMtyZVv3h/YJy9T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627
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

--_000_e0052e583c174015b6fbf458cfcaca30amdcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]



On 2023-10-03 17:37, Felix Kuehling wrote:
On 2023-10-03 16:50, Philip Yang wrote:
If there is no VRAM domain, bo_node is NULL and this causes crash.
Refactor the change, and use the module parameter as higher privilege.

Need another patch to support override PTE flag on APU.

Fixes: 55d7e2001c7e ("drm/amdgpu: Add EXT_COHERENT memory allocation flags"=
)
Signed-off-by: Philip Yang <Philip.Yang@amd.com><mailto:Philip.Yang@amd.com=
>
---
  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 18 +++++++-----------
  1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
index 0d88698ae33f..305b2c54edfa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1248,26 +1248,22 @@ svm_range_get_pte_flags(struct kfd_node *node,
              break;
      case IP_VERSION(9, 4, 3):
              mtype_local =3D amdgpu_mtype_local =3D=3D 1 ? AMDGPU_VM_MTYPE=
_NC :
-                          (amdgpu_mtype_local =3D=3D 2 ? AMDGPU_VM_MTYPE_C=
C : AMDGPU_VM_MTYPE_RW);
+                           (amdgpu_mtype_local =3D=3D 2 || ext_coherent ?
+                                     AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_=
RW);

We had some offline discussion where I thought that MTYPE_NC should
become MTYPE_UC when ext_coherent is enabled to get the desired memory
semantics. With that idea in mind, this would become a bit more messy,
but here it goes, as clean as I can make it:

-               mtype_local =3D amdgpu_mtype_local =3D=3D 1 ? AMDGPU_VM_MTY=
PE_NC :
-                            (amdgpu_mtype_local =3D=3D 2 ? AMDGPU_VM_MTYPE=
_CC : AMDGPU_VM_MTYPE_RW);
+               mtype_local =3D amdgpu_mtype_local =3D=3D 1 && !ext_coheren=
t ? AMDGPU_VM_MTYPE_NC :
+                            (amdgpu_mtype_local =3D=3D 1 &&  ext_coherent =
? AMDGPU_VM_MTYPE_UC :
+                            (amdgpu_mtype_local =3D=3D 2 ||  ext_coherent =
? AMDGPU_VM_MTYPE_CC :
+                                                                        AM=
DGPU_VM_MTYPE_RW));


That ternary looks fairly gnarly. I think it would be worth the extra ink t=
o write

                   mtype_local =3D amdgpu_mtype_local =3D=3D 1 ? AMDGPU_VM_=
MTYPE_NC :
                            (amdgpu_mtype_local =3D=3D 2 ? AMDGPU_VM_MTYPE_=
CC : AMDGPU_VM_MTYPE_RW);

                if (ext_coherent) {
                    if (amdgpu_mtype_local =3D 1)
                        mtype_local =3D AMDGPU_VM_MTYPE_UC;
                    else
                        mtype_local =3D AMDGPU_VM_MTYPE_CC;
                }

But maybe that could be fixed up in a follow up patch. Either way, for
the purpose of fixing the crash, this patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com><mailto:Felix.Kuehling@=
amd.com>


              snoop =3D true;
              if (uncached) {
                      mapping_flags |=3D AMDGPU_VM_MTYPE_UC;
-             } else if (ext_coherent) {
-                     /* local HBM region close to partition */
-                     if (bo_node->adev =3D=3D node->adev &&
-                         (!bo_node->xcp || !node->xcp || bo_node->xcp->mem=
_id =3D=3D node->xcp->mem_id))
-                             mapping_flags |=3D AMDGPU_VM_MTYPE_CC;
-                     else
-                             mapping_flags |=3D AMDGPU_VM_MTYPE_UC;
              } else if (domain =3D=3D SVM_RANGE_VRAM_DOMAIN) {
                      /* local HBM region close to partition */
                      if (bo_node->adev =3D=3D node->adev &&
                          (!bo_node->xcp || !node->xcp || bo_node->xcp->mem=
_id =3D=3D node->xcp->mem_id))
                              mapping_flags |=3D mtype_local;
-                     /* local HBM region far from partition or remote XGMI=
 GPU */
-                     else if (svm_nodes_in_same_hive(bo_node, node))
+                     /* local HBM region far from partition or remote XGMI=
 GPU
+                      * with regular system scope coherence
+                      */
+                     else if (svm_nodes_in_same_hive(bo_node, node) && !ex=
t_coherent)
                              mapping_flags |=3D AMDGPU_VM_MTYPE_NC;
-                     /* PCIe P2P */
+                     /* PCIe P2P or extended system scope coherence */
                      else
                              mapping_flags |=3D AMDGPU_VM_MTYPE_UC;

Would probably clearer if these two branches were swapped so the first was

(!svm_nodes_in_same_hive(bo_node, node) || ext_coherent)

Not a required change, though.

              /* system memory accessed by the APU */

This patch as written causes ext_coherent to no longer affect gfx9.4.3 APU =
devices, which it should.

The following (or equivalent) needs to be added just below this hunk

            if (num_possible_nodes() <=3D 1)
                mapping_flags |=3D mtype_local;
            else
-                 mapping_flags |=3D AMDGPU_VM_MTYPE_NC;
+                mapping_flags |=3D ext_coherent ? AMDGPU_VM_MTYPE_UC : AMD=
GPU_VM_MTYPE_NC;

--_000_e0052e583c174015b6fbf458cfcaca30amdcom_
Content-Type: text/html; charset="iso-8859-1"
Content-ID: <23BF93A1D22B5B429D077173748FE1C0@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<p style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Ca=
libri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</p>
<div class=3D"moz-cite-prefix">On 2023-10-03 17:37, Felix Kuehling wrote:<b=
r>
</div>
<blockquote type=3D"cite">On 2023-10-03 16:50, Philip Yang wrote: <br>
<blockquote type=3D"cite" style=3D"color: rgb(0, 124, 255);">If there is no=
 VRAM domain, bo_node is NULL and this causes crash.
<br>
Refactor the change, and use the module parameter as higher privilege. <br>
<br>
Need another patch to support override PTE flag on APU. <br>
<br>
Fixes: 55d7e2001c7e (&quot;drm/amdgpu: Add EXT_COHERENT memory allocation f=
lags&quot;) <br>
Signed-off-by: Philip Yang <a href=3D"mailto:Philip.Yang@amd.com" class=3D"=
moz-txt-link-rfc2396E OWAAutoLink" data-loopstyle=3D"linkonly" id=3D"OWA555=
1543b-0498-5b81-127d-578773d2e4b2">
&lt;Philip.Yang@amd.com&gt;</a> <br>
--- <br>
&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 18 +++++++----------- <br>
&nbsp; 1 file changed, 7 insertions(+), 11 deletions(-) <br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amd=
kfd/kfd_svm.c
<br>
index 0d88698ae33f..305b2c54edfa 100644 <br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c <br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c <br>
@@ -1248,26 +1248,22 @@ svm_range_get_pte_flags(struct kfd_node *node, <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(9, 4, 3): <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mtype_local =3D amdgpu_mtype_local =3D=3D 1 ? AMDGPU_VM_MTYPE_NC : <br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; (amdgpu_mtype_local =3D=3D 2 ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW);
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; (amdgpu_mtype_local =3D=3D 2 || ext_coherent ? <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_=
VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW); <br>
</blockquote>
<br>
We had some offline discussion where I thought that MTYPE_NC should <br>
become MTYPE_UC when ext_coherent is enabled to get the desired memory <br>
semantics. With that idea in mind, this would become a bit more messy, <br>
but here it goes, as clean as I can make it: <br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mtype_local =3D amdgpu_mtype_local =3D=3D 1 ? AMDGPU_VM_MTYPE_NC=
 : <br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; (amdgpu_mtype_local =3D=3D 2 ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM=
_MTYPE_RW);
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mtype_local =3D amdgpu_mtype_local =3D=3D 1 &amp;&amp; !ext_cohe=
rent ? AMDGPU_VM_MTYPE_NC :
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; (amdgpu_mtype_local =3D=3D 1 &amp;&amp;&nbsp; ext_coherent ? =
AMDGPU_VM_MTYPE_UC :
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; (amdgpu_mtype_local =3D=3D 2 ||&nbsp; ext_coherent ? AMDGPU_V=
M_MTYPE_CC :
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VM_MTYPE_RW));
<br>
<br>
</blockquote>
<p>That ternary looks fairly gnarly. I think it would be worth the extra in=
k to write&nbsp;&nbsp;&nbsp;
<br>
</p>
<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; mtype_local =3D amdgpu_mtype_local =3D=3D 1=
 ? AMDGPU_VM_MTYPE_NC :<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; (amdgpu_mtype_local =3D=3D 2 ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_=
MTYPE_RW);<br>
<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 if (ext_coherent) {<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; if (amdgpu_mtype_local =3D 1)<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; mtype_local =3D AMDGPU_VM_MTYPE_UC;<=
br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; else<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; mtype_local =3D AMDGPU_VM_MTYPE_CC;<=
br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 }<br>
</p>
<blockquote type=3D"cite">But maybe that could be fixed up in a follow up p=
atch. Either way, for
<br>
the purpose of fixing the crash, this patch is <br>
<br>
Reviewed-by: Felix Kuehling <a href=3D"mailto:Felix.Kuehling@amd.com" class=
=3D"moz-txt-link-rfc2396E OWAAutoLink" data-loopstyle=3D"linkonly" id=3D"OW=
A0fb4eb3e-e5a8-e7ad-ed11-bf5f07139e99">
&lt;Felix.Kuehling@amd.com&gt;</a> <br>
<br>
<br>
<blockquote type=3D"cite" style=3D"color: rgb(0, 124, 255);">&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snoop =3D =
true;
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (uncached) { <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping_flags |=3D AMDG=
PU_VM_MTYPE_UC; <br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }=
 else if (ext_coherent) { <br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* local HBM region close to=
 partition */ <br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo_node-&gt;adev =3D=3D =
node-&gt;adev &amp;&amp; <br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (!bo=
_node-&gt;xcp || !node-&gt;xcp || bo_node-&gt;xcp-&gt;mem_id =3D=3D node-&g=
t;xcp-&gt;mem_id))
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mapping_flags |=3D AMDGPU_VM_MTYPE_CC; <br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else <br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; mapping_flags |=3D AMDGPU_VM_MTYPE_UC; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else if (domain =3D=3D SVM_RANGE_VRAM_DOMAIN) { <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* local HBM region clo=
se to partition */ <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo_node-&gt;adev =
=3D=3D node-&gt;adev &amp;&amp; <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 (!bo_node-&gt;xcp || !node-&gt;xcp || bo_node-&gt;xcp-&gt;mem_id =3D=3D no=
de-&gt;xcp-&gt;mem_id))
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; mapping_flags |=3D mtype_local; <br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* local HBM region far from=
 partition or remote XGMI GPU */
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (svm_nodes_in_same_h=
ive(bo_node, node)) <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* local HBM region far from=
 partition or remote XGMI GPU <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * with regular system =
scope coherence <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */ <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (svm_nodes_in_same_h=
ive(bo_node, node) &amp;&amp; !ext_coherent)
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; mapping_flags |=3D AMDGPU_VM_MTYPE_NC; <br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* PCIe P2P */ <br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* PCIe P2P or extended syst=
em scope coherence */ <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; mapping_flags |=3D AMDGPU_VM_MTYPE_UC; <br>
</blockquote>
</blockquote>
<p>Would probably clearer if these two branches were swapped so the first w=
as <br>
</p>
<p>(!svm_nodes_in_same_hive(bo_node, node) || ext_coherent)</p>
<p>Not a required change, though.<br>
</p>
<blockquote type=3D"cite">
<blockquote type=3D"cite" style=3D"color: rgb(0, 124, 255);">&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* system =
memory accessed by the APU */
</blockquote>
</blockquote>
<p>This patch as written causes ext_coherent to no longer affect gfx9.4.3 A=
PU devices, which it should.</p>
<p>The following (or equivalent) needs to be added just below this hunk<br>
</p>
<p>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (num_possibl=
e_nodes() &lt;=3D 1)<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 mapping_flags |=3D mtype_local;<br>
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; mapping_flags |=3D AMDGPU_VM_MTYPE_NC;<br>
+&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; mapping_flags |=3D ext_coherent ? AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC=
;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
<br>
</p>
</div>
</body>
</html>

--_000_e0052e583c174015b6fbf458cfcaca30amdcom_--

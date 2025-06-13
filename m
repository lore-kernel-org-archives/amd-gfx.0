Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7881C71135
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 04:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA74D10E42B;
	Fri, 13 Jun 2025 04:19:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z7PrgswV";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE5F10E42B
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 04:19:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vf4vuhKOpJQuHRLLgwNaYh7lziZsJIsx7zgO9zPmrnYOgP0Bs6KoXBG+dewYTTmI4zM543Xz34ppkSAysgwB7YszbvDNUuEYLF46q+UUpV96WTlhHcM0S7AJKkvnBX0t+ZUOhiobduiJ+2qyQk0uNK1O/MIUEpDGcMCvFwew8uafKXWZbNKle4uZD6KZhVe4pz4Tl5tPvU+M5IsWtIGFlpphciWkbyG9nL1wNzQQf7BBT6uwJBR7L1HAm1KRFsSvfHc62vGe1HcqyIk5hJLEpfFQyWd/z0oRijdIgY/k0QTBa5I16aQGjc8wydR/jqyMNdSEw1YXJq+EAMmymd723g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7qXun4m6Q3EIPcKx7CZILO4Qi927Bz2G6RDvmgrQho=;
 b=fzEWxypMWMVayddjhMO/A7qLrXyZ2zNxeFnGz7YdaYrvYFpvL4dmOvhxbXR7TthPMTWKyeTVi70ZiUSsJTcf4oOyjL3zy0UZYp+CGECJAKpnSn9VUW4IZttWtbvPSQ+c7BvG9q1lqXyy3yU4RLYtQkQbqpTb2aABAbdt6ycZGXAYJk3yHZC3vXx6KzzPOTga4pSF52Kr8DlYqGo978/GjbsBIJE5xe9KYNoV/VFn61mDERF+lKK/2x0t85HiIXGuc2ayvWldnnagCaNd6Z/ReDqi5mCBDkBSXud3ESeptxHreU2+gDV3zuWQURffePh9+06Dsh3mvdWqzb4dG1vVRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7qXun4m6Q3EIPcKx7CZILO4Qi927Bz2G6RDvmgrQho=;
 b=z7PrgswVjDhKlqgUg4TEYdFh+dE55MECkwf+J6QeHycno6T9L4keps+LqqhcDIlCHk6KSxGfbAYe5jVJdiag3PCn2vWFW+jqO4er20s4mOhVjO9IqTXDz1VltP3BU3Ag2kqqOOE5IEn4PpEKRnyVIjKFUYXU5zWNWbFAV71HLkc=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by SJ5PPF0529573EF.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::987) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Fri, 13 Jun
 2025 04:19:19 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%3]) with mapi id 15.20.8835.023; Fri, 13 Jun 2025
 04:19:19 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Xie, Patrick" <Gangliang.Xie@amd.com>
Subject: Re: [PATCH] drm/amdgpu: refine usage of amdgpu_bad_page_threshold
Thread-Topic: [PATCH] drm/amdgpu: refine usage of amdgpu_bad_page_threshold
Thread-Index: AQHb3Bgn50SyEVUp0EWi+WrQSVdWv7QAfDcU
Date: Fri, 13 Jun 2025 04:19:19 +0000
Message-ID: <BN9PR12MB5257AF65CF510224D6A3260CFC77A@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20250613040313.188841-1-ganglxie@amd.com>
In-Reply-To: <20250613040313.188841-1-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-13T04:18:23.1255328Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|SJ5PPF0529573EF:EE_
x-ms-office365-filtering-correlation-id: 2472f538-a77c-462c-3f03-08ddaa31779d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|8096899003|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?lsPGqlBwdicBFrsmH3RZblSuSgtb7e5hvf+0uCt5rCfwz9UAUR6VirEiaj/k?=
 =?us-ascii?Q?Ye10MPhSVtNrkGSJsEid6U2Fe1JeckYJF3UHUfKUIlR3xUwLxGGXmt0gt3QQ?=
 =?us-ascii?Q?i8NTipfn+sI+MTYUloVHQmCMaW0Bi+AWwM5TXe8zDDw62Mh1z2tK7fh0UlBS?=
 =?us-ascii?Q?pOqZ5dn8VfM3p3tn3B9rqvsnZ4iidIMhi1zTdRSpuvj+LptFPpm2/PW06Hlq?=
 =?us-ascii?Q?O1Ll6dFQSUl2fUx/bmnUv6inwad3pCy7IHBM5DR6FHmLnZk5StbzHGlSofpA?=
 =?us-ascii?Q?lWgqKM8RD+iOHCoIppkXD+a5CvCn5niR/aMN6b0u/atpVl961Hsm5+lccUtN?=
 =?us-ascii?Q?u1vHsPVhSFkdI5prknQ3ydCRJd0DwfXFo09ao0d5G0GnqrvEnjw0Fljn/GNH?=
 =?us-ascii?Q?xm70/YNB9MPSonFhvAoi2RbyKmHB/BTMsZSz+iUj7oGrhMoS+N463AHCNKIP?=
 =?us-ascii?Q?UadxgH73QnOlYOJoTO10VFkhv6Y4WEEUeH+seifr7VxRQaacFw/HfLybE+E+?=
 =?us-ascii?Q?6S9/mWnvN59e5c3GZRyC4vp6DedjVx4BZEJx9DHjTvI457yhAd7Ge52W7uST?=
 =?us-ascii?Q?BWU+ccF1pLMqMJLE+miaoGZkj7+j02c6VqOUZHr4qh9YUupQyQFf2BhRBib7?=
 =?us-ascii?Q?jz0Gw4CZNmWE6gNMwlk9PLTtomJpHc+BsepfAYlZnusPggK2bmi+1Tbb4xIo?=
 =?us-ascii?Q?hfbbtBJvBBW5RW9XcoP1E30DERlQUfbtDrgL4QouJMSsDv+ZR4+pwb9Vk/Cq?=
 =?us-ascii?Q?WPKzbvuxnOXiQxgmtCw1cbQ60FlYy7VNx4sbYajGhVRyN7oUYy2BIa/X6jsN?=
 =?us-ascii?Q?ohQd6dEtAIvKZ4woOR8RLNSt4gifDMsMuwckMV9kzzCg8CzAhL5Sf1aEdbHf?=
 =?us-ascii?Q?jjyhizV4bw1f3yCKuXgDwt4J9LvFL+fCj5CPLENAH6ssFRQ9QhAg3s8nDbPt?=
 =?us-ascii?Q?AjwX7z5mgTvsI+TOmSeYxzRFvMlxGtg9APulcaoMJqbS2mXRI4CUGlj4S3sg?=
 =?us-ascii?Q?bOZLUhHwKZD+vqjp07QEZnZxSSZ2ybpehgUBDN77JYb85up/5rXF8kKi1G7Z?=
 =?us-ascii?Q?4G2bru08wz4B9FFb4SzUG1GA0nKEHHaTv+tcSyOHlDldCId+0Eo+0JbatfEJ?=
 =?us-ascii?Q?WdHTAGUgT2GYQbzmmz5BmPL6q5Mx16114sUueiTm9kUYg+Kb42sUfdb6fjNa?=
 =?us-ascii?Q?ZITThT9twC9Xx+NZI8d+Pe+/BY/ToW6XcPQ/2eh3AXs/doPNmeG16+DwOnVv?=
 =?us-ascii?Q?0QZm0Ns4Y/H1OO35ieEhvQWhpvaSPGEB34TH0a1gJpfzqXLT2SrUJEnF+n1x?=
 =?us-ascii?Q?dvFoxXM7b8b7N2bl/eJtERBL/2JHDZU2jqNZ3PFCKFF+B5NIBnosVxQABEJI?=
 =?us-ascii?Q?48xusV0//mDz41jkDRQKebd1ukjisSU7FccJ9mX+PdPfdFMPluS8sjXR+GLX?=
 =?us-ascii?Q?t6zQUshuABkOpoyGM3Yi7WuWMNT39Me4mvLi9sd49c8rCOeTYno4WEOQCthG?=
 =?us-ascii?Q?wWdBl1jE5iA8/oY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(8096899003)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FSLfWu7rqH0LhpDlkVxK8xWSGHNyEtUSf72FV7/J4BGB0UVKVVSNFQYDBxz7?=
 =?us-ascii?Q?s2BzDqVrqv9MvgwY0tFazMvn4yGnxv7/skWKo75unVJXwVg5SOgvjwrhbIi8?=
 =?us-ascii?Q?99XURcHFU4zxSa+31dY9Zq+ToNe+ACXSMgHNOoHKX2GFtPR17FzlaG+kii9K?=
 =?us-ascii?Q?gS6ZJaUdfF/rnRfHVeAOjB49qkzoO+Sk1ntJW09VW/5K+P5vvCxOBV5R3ie1?=
 =?us-ascii?Q?PNCecDh/zF6QuozlxVkkGzn4hU6wvzoL4F2D2B4/iInVdUoYWyzchxu3VPu6?=
 =?us-ascii?Q?nCLHgZ6wlJzXCHOs2j5eLJCfTsmEr3mMtV/WCoIMbkXKgRBOHnrlbacCtdhf?=
 =?us-ascii?Q?b6jzMCMGqbIafMPzQQt3uBoNd7y5A8YvTWoSPfssVH3Htz6FBXauakqvad7g?=
 =?us-ascii?Q?3kweINdV2+ffRoHPsTftSX7BMeQcs1zPJjU0EXOAYya28dCgqvgcXg1Afz2p?=
 =?us-ascii?Q?opO5Ug8A4zPqG7CC/Yfqp0jmxDWPtzeYBqkT/X3cpkNhh6WdUDki7tGdiGZ7?=
 =?us-ascii?Q?xI3D+N1HVjTodMWfuaCBnOQ3//6zj+/fhy1hhwiGpj67LmpnU5FE5ivSH7Pu?=
 =?us-ascii?Q?gA7x/Pt41R98oi6xASsHk7ANhENmJPgOncQpWQ+cf8C+ZD1qNHf/3Q/hZDMt?=
 =?us-ascii?Q?eIpXtuvnETh/NRtNJB8iJ1QB5E60YITDbvCrNEzuHEm7VGD+h/XEjs/UQdtb?=
 =?us-ascii?Q?5hXig+2tn5TzjDyVmtH4okMt6bhQmKBVVuSPsHkcVOlpk81U11TY07Zh9spD?=
 =?us-ascii?Q?pNmv1trXfKdLt7CkiHImjG9vjwvbsUGDcA7NVvolQMFqmlS7KAfi9WwmqZsR?=
 =?us-ascii?Q?ox8nzkCKfqnA+HIlPnKwuGT93EmiSlPAiguuF1u3DMiS5k+voerWV2qdfycD?=
 =?us-ascii?Q?8nyqNgsR311Bu64dRvmSbL2kGXo6aJnnugmdpg0/b7Kq5lm08SklbppYq2At?=
 =?us-ascii?Q?LmWe6Lp8zA5tTSDcpFEvmXZyrqamjIvrTZjwWfukD3qJeDmE22ehKSt6Hksq?=
 =?us-ascii?Q?cdul/TkeOk1xcVUg6uPubkSxXBxXONfsF56rf/wjTf5wk/1xftMDGLxjeFpV?=
 =?us-ascii?Q?pe9wQugcnp4YQVdMyQps6x/Lyz+r7ioQ54TV4TQgbPO5HVTHRNWutUiUGUEd?=
 =?us-ascii?Q?nlKNwH+f5iCSkdgO1bVMdGTegJ3OyWrNSGsrrABjSSrtw9n5xrkzPNcAjIQH?=
 =?us-ascii?Q?yh7VOTceO7gBw27OCx+ieytFbT3feKDHMO5jloVg3Lbhdyo1HCZg6mgdUkK1?=
 =?us-ascii?Q?lOW/WJ7nXuG95fXg92RAQdJl2LCcj1rKWh+ZlbWZFlBlUhgPDI8zExg73m89?=
 =?us-ascii?Q?NvyS5JWe0uurx2YKmatWhTByTXJAPXRYz0LaOX77kCbQCi0jRnrGRB9yGyHd?=
 =?us-ascii?Q?XtjIr4CIJ+y0DGPzdb1gUpuf8abVrZLTNq+cF14uVYGFJ5vVt1s82kPR3G1C?=
 =?us-ascii?Q?Z8guPTDYfQ/niraLWTkE3rwKLkCrLao1RT/rnUtqXqcB0jZ8DzecjVfwr4G6?=
 =?us-ascii?Q?riAUMXyCGz12YwVUwkrJwHda7x2TPHjL11DBaMMFJDb5UBpVsDB+1TByMPBi?=
 =?us-ascii?Q?dBYPEcaoNe6aqNjHS+FmYLAsEZRMimO5f1ryprQDqgQVimLYY6SwBNmh1edi?=
 =?us-ascii?Q?nQ=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5257AF65CF510224D6A3260CFC77ABN9PR12MB5257namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2472f538-a77c-462c-3f03-08ddaa31779d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2025 04:19:19.2831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +eJxOnEI4o9es8XlswbH/+HLOdKj96mSy5vQYcdit8QvvN4Sa7lwcxy8gYVBVfvyiNzDo5FTzDe6jtsd+eOSoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0529573EF
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

--_000_BN9PR12MB5257AF65CF510224D6A3260CFC77ABN9PR12MB5257namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
From: Xie, Patrick <Gangliang.Xie@amd.com>
Date: Friday, June 13, 2025 at 12:03
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>, Zhou1, Tao <Tao.Zhou1@amd.com>,=
 Xie, Patrick <Gangliang.Xie@amd.com>
Subject: [PATCH] drm/amdgpu: refine usage of amdgpu_bad_page_threshold
when amdgpu_bad_page_threshold =3D=3D -1 or -2, driver will issue a warning
message when threshold is reached and continue runtime services.

Signed-off-by: ganglxie <ganglxie@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index 2ddedf476542..2af14c369bb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -763,18 +763,17 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eep=
rom_control *control)
                 dev_warn(adev->dev,
                         "Saved bad pages %d reaches threshold value %d\n",
                         control->ras_num_bad_pages, ras->bad_page_cnt_thre=
shold);
-               control->tbl_hdr.header =3D RAS_TABLE_HDR_BAD;
-               if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1) {
-                       control->tbl_rai.rma_status =3D GPU_RETIRED__ECC_RE=
ACH_THRESHOLD;
-                       control->tbl_rai.health_percent =3D 0;
-               }
-
                 if ((amdgpu_bad_page_threshold !=3D -1) &&
-                   (amdgpu_bad_page_threshold !=3D -2))
+                   (amdgpu_bad_page_threshold !=3D -2)) {
+                       control->tbl_hdr.header =3D RAS_TABLE_HDR_BAD;
+                       if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_=
1) {
+                               control->tbl_rai.rma_status =3D GPU_RETIRED=
__ECC_REACH_THRESHOLD;
+                               control->tbl_rai.health_percent =3D 0;
+                       }
                         ras->is_rma =3D true;
-
-               /* ignore the -ENOTSUPP return value */
-               amdgpu_dpm_send_rma_reason(adev);
+                       /* ignore the -ENOTSUPP return value */
+                       amdgpu_dpm_send_rma_reason(adev);
+               }
         }

         if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1)
--
2.34.1

--_000_BN9PR12MB5257AF65CF510224D6A3260CFC77ABN9PR12MB5257namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;
	panose-1:2 11 0 4 2 2 2 2 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:10.0pt;
	font-family:"Aptos",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"en-CN" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif">Reviewed-by: Hawking Zhang &lt;Hawki=
ng.Zhang@amd.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif">Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US" style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif">Hawking<o:p></o:p></span></p>
<div id=3D"mail-editor-reference-message-container">
<div>
<div>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">Xie, Patrick &lt;Ga=
ngliang.Xie@amd.com&gt;<br>
<b>Date: </b>Friday, June 13, 2025 at 12:03<br>
<b>To: </b>amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc: </b>Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;, Zhou1, Tao &lt;Tao=
.Zhou1@amd.com&gt;, Xie, Patrick &lt;Gangliang.Xie@amd.com&gt;<br>
<b>Subject: </b>[PATCH] drm/amdgpu: refine usage of amdgpu_bad_page_thresho=
ld<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">when amdgpu_bad_page_threshold =3D=3D -1 or -2, driver will iss=
ue a warning<br>
message when threshold is reached and continue runtime services.<br>
<br>
Signed-off-by: ganglxie &lt;ganglxie@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c&nbsp;&nbsp;&nbsp; | 19 +++=
++++++----------<br>
&nbsp;1 file changed, 9 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
index 2ddedf476542..2af14c369bb9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c<br>
@@ -763,18 +763,17 @@ amdgpu_ras_eeprom_update_header(struct amdgpu_ras_eep=
rom_control *control)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot=
;Saved bad pages %d reaches threshold value %d\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; contr=
ol-&gt;ras_num_bad_pages, ras-&gt;bad_page_cnt_threshold);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; control-&gt;tbl_hdr.header =3D RAS_TABLE_HDR_BAD;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (control-&gt;tbl_hdr.version &gt;=3D RAS_TABLE_VER_V2_1) {<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;tbl_=
rai.rma_status =3D GPU_RETIRED__ECC_REACH_THRESHOLD;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;tbl_=
rai.health_percent =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if ((amdgpu_bad_page_threshold !=3D -1) &amp;&amp;<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_bad_page_threshold !=3D -2))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_bad_page_threshold !=3D -2)) {<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;tbl_=
hdr.header =3D RAS_TABLE_HDR_BAD;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (control-&gt;=
tbl_hdr.version &gt;=3D RAS_TABLE_VER_V2_1) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;tbl_rai.rma_status =3D GPU_RETI=
RED__ECC_REACH_THRESHOLD;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; control-&gt;tbl_rai.health_percent =3D 0;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras-&=
gt;is_rma =3D true;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* ignore the -ENOTSUPP return value */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_dpm_send_rma_reason(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ignore the -E=
NOTSUPP return value */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_send_=
rma_reason(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (control-&gt;tbl_hdr.ve=
rsion &gt;=3D RAS_TABLE_VER_V2_1)<br>
-- <br>
2.34.1<o:p></o:p></span></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB5257AF65CF510224D6A3260CFC77ABN9PR12MB5257namp_--

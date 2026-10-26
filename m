Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5456B606A31F
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fu56yZzV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E505610E310;
	Mon, 26 Oct 2026 18:12:36 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4800510E344
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 18:12:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4x8mg3DnaHXbGE54UvtSIM9Erz7oJt1yQchW0UuWRlTHdyJpZQkH2kdy/H5ZTCARE0VJxV64djUlMOdhCatk+dT0EQrfw1w/223tzH//zHh50aroa3KnqmIERcL9j/EyCfMrfXgWL36825vktNYFmHa2ptZ9nL8Gj69Om2WpDV6G04O5UvfGogjtpGPx+w2++WLyhhFEtyMPw7mIHYUshXGRxQPEBJXc3Chl1KaTaxwucq3+3jwlkRsISCL7EwVd+yD+WSELzKsZ8Hq5ewu4mB+3eYYrzMxyv/XyhppJBadqRLZSHsMz90FEbvOk3TQP5cF59m7hbvS0/guxtkqOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4N9vnCIcl6XTEGJ2U2BI7CWOmx2jtUDsX+J4pPSg70E=;
 b=e/VgikPGcAJYFVW3QE19PpDaf/JWuQWliV0nVciy5KFRlwlTCzAPIuSll1Zo+5PB4oubksip8mH2PpvGnqJoRHsVO5wn+bZ+YGa69RH32wP9EGOSTQbLMJXX+duUX3GxnLEheOnEyNaXrWAFwHqq7WrVgEp3oK5l4U4dBEWnGHARyULC4k6HAa9+kDntDQTx4o5RmPtgbOpgYcnf7uaRi9AnJSRFnDXqwed9m5ImwZVyaXkyEti2sQ4iD1zTEtVhjSfcsZQpCKWOkdDpPaBgJZXt/Aj/VyV1k2SAv2MThvHOZEPAC3WjaVQA9A5MltQRqQnGrSgXFEcwDfAEtoj7HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4N9vnCIcl6XTEGJ2U2BI7CWOmx2jtUDsX+J4pPSg70E=;
 b=fu56yZzV8xDqbJP1jKizSGwbeMJUTEsEjBgDVzzeksf7QSmFOc5mePvwb36v88+QvnlamGKHn/S9CKCN/cI9RAFWQQvJ4QCoH0Dv7BNDhg/dq+gY0g4JRRHQDCqBi+UURhT4MzjRCKQZ+/6pCJczT6ilRy35e0KvoZrA/1pUxzs=
Received: from PH9PR12MB135921.namprd12.prod.outlook.com
 (2603:10b6:510:412::21) by CH2PR12MB9543.namprd12.prod.outlook.com
 (2603:10b6:610:27f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 18:12:25 +0000
Received: from PH9PR12MB135921.namprd12.prod.outlook.com
 ([fe80::c664:eb28:f692:d534]) by PH9PR12MB135921.namprd12.prod.outlook.com
 ([fe80::c664:eb28:f692:d534%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 18:12:25 +0000
From: "Mishra, Apurv" <Apurv.Mishra@amd.com>
To: "Chen, Xiaogang" <Xiaogang.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sierra Guiza, Alejandro
 (Alex)" <Alex.Sierra@amd.com>, "Kasiviswanathan, Harish"
 <Harish.Kasiviswanathan@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that is still
 referenced
Thread-Topic: [PATCH] drm/amdkfd: Don't reuse a VRAM page that is still
 referenced
Thread-Index: AQHdYxJuefxdddE59kKcoif+U7qLSbcP54OAgAA0TxY=
Date: Mon, 26 Oct 2026 18:12:25 +0000
Message-ID: <PH9PR12MB135921453E146E0DA733B16DE99F612@PH9PR12MB135921.namprd12.prod.outlook.com>
References: <20261023171722.46301-1-Apurv.Mishra@amd.com>
 <53899e72-b727-42ab-81ee-8587a10f16b7@amd.com>
In-Reply-To: <53899e72-b727-42ab-81ee-8587a10f16b7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Xiaogang.Chen@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-26T18:12:11.726Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH9PR12MB135921:EE_|CH2PR12MB9543:EE_
x-ms-office365-filtering-correlation-id: 4fffb49f-bce1-45ad-904c-08df338cb03a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|8096899003|22082099003|18002099003|261026140227099003|3023799007|10067099003|11063799006|56012099006|4143699003|261021121427099003|261009223027099003|261022075727099003|261021123027099003|261022105027099003|261021135927099003|261026121527099003|38070700021;
x-microsoft-antispam-message-info: 0KeQraOoq2LYJTYisgn3HNfwnnKvE6dmTB/GN1IrHihEksDaqfbVukyEMJXwc2N39SnsTjTZZLcfAB204BP6VLJ2sp//dkfLWhkd+GKnx1f7pKhUiGNaogIvR7Wyca2UCsn2hfzdnfBr4MD32u/GK3zfwhGS2xsGpa+rRjIhhkKL7gx6tSVqlJo1AWqMx03nBGaII3XMeCyJeq5hH0cgISVU+Y/2BIySJfmwpmNkxR/ds3xVeThjLuq9zK1LQYuCuYxaM4NZozYsMSjAilwoWgcWj9gDCGApJCJ20PM+ZvqStW+UeK8OqCL/uF5Uv0XGTS8QX/cy/kbg8Q2ZlckfMgDWn8n3aVYtim2pxYEflCtmaW1plcauTXXQKk4f4bmsuZxUWgz7qLT5PhFj7s+R1EkCsBhXl5gFK98LTFzXtDlDjtj7ze3EeATuvH4VdoXWQfnvsihLObIvXN80lmZe4LwZ4uiCdChIyGQIcIjdT7vSwt2IE9ERJoHn2o9uzBxbTpXLIHVgqLsvukXISOfodDPSBWWbLH21MhsydTvZ40ol3E8ajM5E0kR8tECwhNJGfPzvfjkk87ERcKvz8X3cHYS/pyC3/+SVZKHgacWG6qFDIWUBV4rib+/vlWEqiLPY6Sa/BR77jE/TQE7sjSg9g7BqroLIzX1XXFMLBKOYU6EwgQnnFOYXsx1Hlx+3cebzLKinfiqPMyAzYoxeYLhk2J9nJi4QBFcMMIWw2kBqHMw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH9PR12MB135921.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(8096899003)(22082099003)(18002099003)(261026140227099003)(3023799007)(10067099003)(11063799006)(56012099006)(4143699003)(261021121427099003)(261009223027099003)(261022075727099003)(261021123027099003)(261022105027099003)(261021135927099003)(261026121527099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yuDGEfrK/0M+Kr04hte9PdOS2hQffMAEmXUzfzt2xCBatRurzHsEWfvLmN?=
 =?iso-8859-1?Q?LaGmzL/o9r2vxyGQxL4oQm7YbS2VHaBdXEaI/hsC4H9xy86/lEc26l08lm?=
 =?iso-8859-1?Q?w1GgFl8lWubPp09qsQYhJYzyvmNP/xxP0zly4E/asu+AaLrK3yNIATo0M4?=
 =?iso-8859-1?Q?zUUV3ZxSR6SFO8w6d6UstJGGxQUwqh7rw3dJ8h5xk1ODXmYo4vnX5Nq0KI?=
 =?iso-8859-1?Q?9OCO5WXft5HbJoruJhAchBXxYUDWrKfbado6Ta6w822rS0dvpKOZLqU3SB?=
 =?iso-8859-1?Q?b3+mxee9bmiIh4D//Hw6YVN8DjVGeJ758RsBVs5qVAy+IytRLFS/fbbtuG?=
 =?iso-8859-1?Q?mjYe0PVfPIzBaM4UVVziXp3Ru1NKN1OWXWfxa8R5CXCAegcmVFke13y7U7?=
 =?iso-8859-1?Q?gzC6SH6zy5DynRoIh1TaWjQRBbzX2eKqh5B5z3nqtVVGHxUDYurNOWVErf?=
 =?iso-8859-1?Q?NUCmOcdaFMUfQP5CjnGbeJr/5YzxtXWx+8ZqHaLFNJ/LOigGfqjhJSV5OB?=
 =?iso-8859-1?Q?ptl3p6bD+q490yfM+jOOJQ2AW12Nu4ZAqL6Q3FxrRXHylVZToOlkpBUMzp?=
 =?iso-8859-1?Q?swxcY11xmR+utm+bafn/THR0yJSq9d/a0pp1mxSCa1RqSNtRjD3Dvn2zMo?=
 =?iso-8859-1?Q?YnwXkfSM91hSJ+vDlUOeaCxSKs9fYl14CnwvugypBdQ1uyaUGm3ccbzYRg?=
 =?iso-8859-1?Q?NyonFUXiWz2dOfMHsi0PzorMFy+sntuymTgJIqHbZmKVIOcP5vFFLOJqiq?=
 =?iso-8859-1?Q?H0h3sYir3iGrtbmUn6MzmAW+oovQdXqTOpaNf9KxMJnbOyrxjiIKyBCiPH?=
 =?iso-8859-1?Q?GBAmv1J+1Zb19j1FGCWAyoDcn1Y0F9Er6HILvLfR2JBXYFwlFM/07/yPwK?=
 =?iso-8859-1?Q?7/Toq1r+xkpDcNVixzsqvs3PGTRSwhwFGF8ETsCXT4tHt1hsl6CAeBiZ7l?=
 =?iso-8859-1?Q?ZiDHc18uzVVgFLHUM8aBMyJ8C7HeUE1MtqGp+MllGUH65ZK4Dy2FDJ4ow5?=
 =?iso-8859-1?Q?YPpOXHsgbYWceSqcy2Bys5lEpEyqRvlcT0k2oixTn2owM3O8bRgsHfWAkV?=
 =?iso-8859-1?Q?gUy0X2LHXu++yJ2xFstLBJj1qMqraBOxkM+nEPiOXBgi7mXfF441OPWoRn?=
 =?iso-8859-1?Q?rPeLQNufE1ReH4qpykROU+XvQ7HGHMRQFI5YkrL9EXo9obS17+SpxDtlve?=
 =?iso-8859-1?Q?tuL0QfWOAcU+MJBXBSWXi/7JexkVsPV5H7SiDi1hSq+I9lKNwKmYogjbMU?=
 =?iso-8859-1?Q?au3TDLvqRPUeH+rp8B+Zh0xwhhCxDtynTb0UDmv82lW84AzjWDP+xnQ3cA?=
 =?iso-8859-1?Q?L+CxtbKYwuRkVLykJIRocgOUjJIk6Ro2JrRS3AueeEMccBRLHmwIIti3Gh?=
 =?iso-8859-1?Q?GLqWSoTy7p+/2OXpyFIOj1xI6p07me+E5vTu5brfeSKOWha0/7Vv9rKijB?=
 =?iso-8859-1?Q?wCFi4lXdWauL0gJfQLxewINGqCsqEaMQ4HZuGN10opi2dE2WU6+XdwuilN?=
 =?iso-8859-1?Q?7DOnthxBgNiKhsq8vpp+lf9Ig4XJ8FH1pvPBlZNZNMINAEsqSB5knn2z6H?=
 =?iso-8859-1?Q?y0g5vfWwzFNyi8MzwElnKjhUm6V+G/206bI4/wQu7nuwpG+YRLQyDxyqvX?=
 =?iso-8859-1?Q?Xaev1Yv67QzhJFxIe7NpO3hM3nxOpV/pp1YvoyovhDCeenQp0d3NFsP6H0?=
 =?iso-8859-1?Q?7yg1lNPTs/Wj78ke3olhSjpuGolVFo33WKlsjjxuHy2fToPE0Fm3BWbXeQ?=
 =?iso-8859-1?Q?OiPu1rcGO3g+wY415L10kC/DU40fbLXQCnpOa1x5tA27sE?=
Content-Type: multipart/alternative;
 boundary="_000_PH9PR12MB135921453E146E0DA733B16DE99F612PH9PR12MB135921_"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH9PR12MB135921.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fffb49f-bce1-45ad-904c-08df338cb03a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 18:12:25.4050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J3llK5GRpQ50rW9MvZtEHsOr5ArsIleNPA3d895bdB4hyHybFaepH/t9iyPLEpsLKIQvKOpB5PwNhP3I6YZbdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9543
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--_000_PH9PR12MB135921453E146E0DA733B16DE99F612PH9PR12MB135921_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AMD General

Hi, @Chen, Xiaogang<mailto:Xiaogang.Chen@amd.com>, thank you for the review=
.


The two migrations don't overlap on that address; they run back-to-back. Wh=
at overlaps is the lifetime of the VRAM page. This was reproduced with ASan=
 and XNACK, which make concurrent CPU and GPU faults on the same ranges fre=
quently. As per the logs (ROCM-31012<https://amd-hub.atlassian.net/browse/R=
OCM-31012>):

  *   A CPU fault enters do_swap_page(), takes a reference on VRAM page P, =
and svm_migrate_to_ram() moves the data to system page S. The PTE now point=
s to S, but do_swap_page() still holds P until migrate_to_ram() returns.

  *   About 66 =B5s later, a GPU retry fault migrates the range back to VRA=
M. src =3D S with MIGRATE_PFN_MIGRATE set is correct here, because the data=
 really is in system RAM.

  *   KFD reuses the svm_bo, which P keeps alive, and gets P again as the d=
estination. zone_device_page_init(P) runs with ref=3D1 (traced) and overwri=
tes the refcount.

  *   The CPU fault's put_page(P) frees P mid-migration and clears its mapp=
ing. migrate_vma_finalize() misses that PTE (263 of 264 restored), and it's=
 left pointing at S. S is freed, and the next hmm_range_fault hits the BUG_=
ON in swapops.h:504.

The trace and the panic registers match this page and S exactly. With the f=
ix, the refcount check skipped a busy page 705 times on the repro host with=
 no panic.


Regards,

Apurv


________________________________
From: Chen, Xiaogang <Xiaogang.Chen@amd.com>
Sent: Monday, October 26, 2026 10:32 AM
To: Mishra, Apurv <Apurv.Mishra@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Sierra Guiza, Alejandro=
 (Alex) <Alex.Sierra@amd.com>; Kasiviswanathan, Harish <Harish.Kasiviswanat=
han@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that is still refe=
renced



On 10/23/2026 12:17 PM, Apurv Mishra wrote:

In svm_migrate_copy_to_vram(), skip VRAM pages with a non-zero refcount
and leave those pages in system memory for this migration.

When an svm_bo is reused, a VRAM page can still be held by an in-flight
CPU fault (do_swap_page -> svm_migrate_to_ram). Migrating to VRAM then
re-initializes the page via zone_device_page_init(), resetting its
refcount. The fault's late put_page() frees the page mid-migration, so
migrate_vma_finalize() never restores that PTE. It is left pointing at a
freed system page and hmm_range_fault() hits BUG_ON in
pfn_swap_entry_to_page() (swapops.h).

If there is cpu fault the data is in vram page. If at same time driver is m=
igrating data from sys->vram  migrate->src[i] & MIGRATE_PFN_MIGRATE should =
be false since the data is already at device side.

Then if you got a  MIGRATE_PFN_MIGRAT sys ram page at svm_migrate_copy_to_v=
ram after migrate_vma_setup, but cpu page fault also happened on same page =
there is a contradict.

So, I do not see this scenario can happen or the real cause is revealed.

Regards

Xiaogang

Signed-off-by: Apurv Mishra <Apurv.Mishra@amd.com><mailto:Apurv.Mishra@amd.=
com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_migrate.c
index 8b96e1fe741a..1eb92ac6eb05 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -297,16 +297,26 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struc=
t svm_range *prange,
        amdgpu_res_first(prange->ttm_res, ttm_res_offset,
                         npages << PAGE_SHIFT, &cursor);
        for (i =3D j =3D 0; (i < npages) && (mpages < migrate->cpages); i++=
) {
-               struct page *spage;
+               struct page *spage =3D migrate_pfn_to_page(migrate->src[i])=
;

                if (migrate->src[i] & MIGRATE_PFN_MIGRATE) {
                        dst[i] =3D cursor.start + (j << PAGE_SHIFT);
                        migrate->dst[i] =3D svm_migrate_addr_to_pfn(adev, d=
st[i]);
-                       svm_migrate_get_vram_page(prange, migrate->dst[i]);
-                       migrate->dst[i] =3D migrate_pfn(migrate->dst[i]);
-                       mpages++;
+                       /*
+                        * A reused svm_bo page may still be held by a CPU =
fault.
+                        * Reinitializing it would free it under this migra=
tion,
+                        * so leave this page in system memory.
+                        */
+                       if (page_ref_count(pfn_to_page(migrate->dst[i]))) {
+                               dst[i] =3D 0;
+                               migrate->dst[i] =3D 0;
+                               spage =3D NULL;
+                       } else {
+                               svm_migrate_get_vram_page(prange, migrate->=
dst[i]);
+                               migrate->dst[i] =3D migrate_pfn(migrate->ds=
t[i]);
+                               mpages++;
+                       }
                }
-               spage =3D migrate_pfn_to_page(migrate->src[i]);
                if (spage && !is_zone_device_page(spage)) {
                        src[i] =3D dma_map_page(dev, spage, 0, PAGE_SIZE,
                                              DMA_BIDIRECTIONAL);


--_000_PH9PR12MB135921453E146E0DA733B16DE99F612PH9PR12MB135921_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 1.38; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
Hi, <a href=3D"mailto:Xiaogang.Chen@amd.com" id=3D"OWAAM456027" class=3D"tW=
KOu mention ms-bgc-nlr ms-fcl-b">
@Chen, Xiaogang</a>, thank you for the review.</div>
<div class=3D"elementToProof" style=3D"line-height: 1.38; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<p class=3D"elementToProof" style=3D"line-height: 1.38; margin-top: 0px; ma=
rgin-bottom: 8pt;">
<span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService,=
 Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">The=
 two migrations don't overlap on that address; they run back-to-back. What =
overlaps is the lifetime of the VRAM
 page. This was reproduced with ASan and XNACK, which make concurrent CPU a=
nd GPU faults on the same ranges frequently. As per the logs (<a href=3D"ht=
tps://amd-hub.atlassian.net/browse/ROCM-31012" title=3D"https://amd-hub.atl=
assian.net/browse/ROCM-31012" style=3D"margin-top: 0px; margin-bottom: 0px;=
">ROCM-31012</a>):</span></p>
<ul data-editing-info=3D"{&quot;applyListStyleFromLevel&quot;:true}" style=
=3D"margin-top: 0px; margin-bottom: 0px; list-style-type: disc;">
<li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); margin=
-top: 0px; margin-bottom: 0px;">
<p class=3D"elementToProof" role=3D"presentation" style=3D"line-height: 1.3=
8; margin-top: 0px; margin-bottom: 0px;">
A CPU fault enters <i>do_swap_page()</i>, takes a reference on VRAM page P,=
 and <i>
svm_migrate_to_ram</i>() moves the data to system page S. The PTE now point=
s to S, but
<i>do_swap_page</i>() still holds P until <i>migrate_to_ram</i>() returns.<=
/p>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); m=
argin-top: 0px; margin-bottom: 0px;">
<p role=3D"presentation" style=3D"line-height: 1.38; margin-top: 0px; margi=
n-bottom: 0px;">
About 66 =B5s later, a GPU retry fault migrates the range back to VRAM. src=
 =3D S with
<i>MIGRATE_PFN_MIGRATE </i>set is correct here, because the data really is =
in system RAM.</p>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); m=
argin-top: 0px; margin-bottom: 0px;">
<p role=3D"presentation" style=3D"line-height: 1.38; margin-top: 0px; margi=
n-bottom: 0px;">
KFD reuses the <i>svm_bo</i>, which P keeps alive, and gets P again as the =
destination.
<i>zone_device_page_init</i>(P) runs with ref=3D1 (traced) and overwrites t=
he refcount.</p>
</li><li style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); m=
argin-top: 0px; margin-bottom: 0px;">
<p role=3D"presentation" style=3D"line-height: 1.38; margin-top: 0px; margi=
n-bottom: 8pt;">
The CPU fault's <i>put_page</i>(P) frees P mid-migration and clears its map=
ping. <i>
migrate_vma_finalize</i>() misses that PTE (263 of 264 restored), and it's =
left pointing at S. S is freed, and the next
<i>hmm_range_fault </i>hits the BUG_ON in <i>swapops.h:504</i>.</p>
</li></ul>
<p class=3D"elementToProof" style=3D"line-height: 1.38; margin-top: 0px; ma=
rgin-bottom: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
The trace and the panic registers match this page and S exactly. With the f=
ix, the
<i>refcount </i>check skipped a busy page 705 times on the repro host with =
no panic.</p>
<p class=3D"elementToProof" style=3D"line-height: 1.38; margin-top: 0px; ma=
rgin-bottom: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</p>
<p class=3D"elementToProof" style=3D"line-height: 1.38; margin-top: 0px; ma=
rgin-bottom: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Regards,</p>
<p class=3D"elementToProof" style=3D"line-height: 1.38; margin-top: 0px; ma=
rgin-bottom: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServi=
ce, Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Apurv</p>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b> Chen, Xiaogang &lt;Xiaogang.Chen@amd.com&gt;<br>
<b>Sent:</b> Monday, October 26, 2026 10:32 AM<br>
<b>To:</b> Mishra, Apurv &lt;Apurv.Mishra@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Sierra Gui=
za, Alejandro (Alex) &lt;Alex.Sierra@amd.com&gt;; Kasiviswanathan, Harish &=
lt;Harish.Kasiviswanathan@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdkfd: Don't reuse a VRAM page that is sti=
ll referenced
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<p style=3D"margin-top: 1em; margin-bottom: 1em;"><br>
</p>
<div>On 10/23/2026 12:17 PM, Apurv Mishra wrote:</div>
<blockquote>
<pre><div>In svm_migrate_copy_to_vram(), skip VRAM pages with a non-zero re=
fcount=0A=
and leave those pages in system memory for this migration.=0A=
=0A=
When an svm_bo is reused, a VRAM page can still be held by an in-flight=0A=
CPU fault (do_swap_page -&gt; svm_migrate_to_ram). Migrating to VRAM then=
=0A=
re-initializes the page via zone_device_page_init(), resetting its=0A=
refcount. The fault's late put_page() frees the page mid-migration, so=0A=
migrate_vma_finalize() never restores that PTE. It is left pointing at a=0A=
freed system page and hmm_range_fault() hits BUG_ON in=0A=
pfn_swap_entry_to_page() (swapops.h).</div></pre>
</blockquote>
<p style=3D"margin-top: 1em; margin-bottom: 1em;">If there is cpu fault the=
 data is in vram page. If at same time driver is migrating data from sys-&g=
t;vram&nbsp; migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE should be false s=
ince the data is already at device side.</p>
<p style=3D"margin-top: 1em; margin-bottom: 1em;">Then if you got a&nbsp; M=
IGRATE_PFN_MIGRAT sys ram page at svm_migrate_copy_to_vram after migrate_vm=
a_setup, but cpu page fault also happened on same page there is a contradic=
t.</p>
<p style=3D"margin-top: 1em; margin-bottom: 1em;">So, I do not see this sce=
nario can happen or the real cause is revealed.</p>
<p style=3D"margin-top: 1em; margin-bottom: 1em;">Regards</p>
<p style=3D"margin-top: 1em; margin-bottom: 1em;">Xiaogang</p>
<blockquote>
<pre><div>Signed-off-by: Apurv Mishra <a href=3D"mailto:Apurv.Mishra@amd.co=
m" id=3D"OWA844c86a9-b5b6-3110-df77-1127e3c41911" class=3D"x_moz-txt-link-r=
fc2396E OWAAutoLink">&lt;Apurv.Mishra@amd.com&gt;</a>=0A=
---=0A=
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 20 +++++++++++++++-----=0A=
 1 file changed, 15 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_migrate.c=0A=
index 8b96e1fe741a..1eb92ac6eb05 100644=0A=
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c=0A=
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c=0A=
@@ -297,16 +297,26 @@ svm_migrate_copy_to_vram(struct kfd_node *node, struc=
t svm_range *prange,=0A=
 	amdgpu_res_first(prange-&gt;ttm_res, ttm_res_offset,=0A=
 			 npages &lt;&lt; PAGE_SHIFT, &amp;cursor);=0A=
 	for (i =3D j =3D 0; (i &lt; npages) &amp;&amp; (mpages &lt; migrate-&gt;c=
pages); i++) {=0A=
-		struct page *spage;=0A=
+		struct page *spage =3D migrate_pfn_to_page(migrate-&gt;src[i]);=0A=
 =0A=
 		if (migrate-&gt;src[i] &amp; MIGRATE_PFN_MIGRATE) {=0A=
 			dst[i] =3D cursor.start + (j &lt;&lt; PAGE_SHIFT);=0A=
 			migrate-&gt;dst[i] =3D svm_migrate_addr_to_pfn(adev, dst[i]);=0A=
-			svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);=0A=
-			migrate-&gt;dst[i] =3D migrate_pfn(migrate-&gt;dst[i]);=0A=
-			mpages++;=0A=
+			/*=0A=
+			 * A reused svm_bo page may still be held by a CPU fault.=0A=
+			 * Reinitializing it would free it under this migration,=0A=
+			 * so leave this page in system memory.=0A=
+			 */=0A=
+			if (page_ref_count(pfn_to_page(migrate-&gt;dst[i]))) {=0A=
+				dst[i] =3D 0;=0A=
+				migrate-&gt;dst[i] =3D 0;=0A=
+				spage =3D NULL;=0A=
+			} else {=0A=
+				svm_migrate_get_vram_page(prange, migrate-&gt;dst[i]);=0A=
+				migrate-&gt;dst[i] =3D migrate_pfn(migrate-&gt;dst[i]);=0A=
+				mpages++;=0A=
+			}=0A=
 		}=0A=
-		spage =3D migrate_pfn_to_page(migrate-&gt;src[i]);=0A=
 		if (spage &amp;&amp; !is_zone_device_page(spage)) {=0A=
 			src[i] =3D dma_map_page(dev, spage, 0, PAGE_SIZE,=0A=
 					 &nbsp; &nbsp; &nbsp;DMA_BIDIRECTIONAL);=0A=
</div></pre>
</blockquote>
</body>
</html>

--_000_PH9PR12MB135921453E146E0DA733B16DE99F612PH9PR12MB135921_--

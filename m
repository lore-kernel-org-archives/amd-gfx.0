Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B69C61DA4
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Mar 2023 02:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44E7B10E05C;
	Thu, 16 Mar 2023 02:09:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54CB910E05C
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Mar 2023 02:09:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2xutJd6fuhbm8Bsrxc567N6fpwdHKANQihg8KAs6tdEVyPMP/BTLtJ0+lrYPUKCWrgs5NsfudvBpPv0qD8q/Z27lRdBzuQXJ690ELx4wY5za+GrPOwS/T+Vb+hBr6M0OPGRbeXnqDlLJsET+xt5MoOMDiH+lYFq0aRg0pG9QTosLZkVL4+vwQsvqgUH8r8CEe3L3zKuD9EFg0zhdJO7mDpPtZ04vKcy23d5mF95ELPRWqQU0eidpA4I15wrArYxDTJNt/5V/zAmYdYeeSgJFREZM+jz/EAnqhu5BZ8R8MjNoHD5yDFDFBcOc2TspllarnkYXujFL43PvUn+zBbijA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxeAmJxcxnjqmCzSS0L0at+ciJnTgCOlXF25nUaZ+XM=;
 b=EHg2+I1mjtC//Nmo0a0eJCYz8h6c3E6SwZFVr/MEcaZmVJ/Yn0NmZ+nJrhBZIngIEll3AOEX0TwNbSWTjrlqPYYepGvZWoHJjivECBwC1HY08sLkbQ4AwoJvhJIUpNVgZWVzrxnKSTWsVIcgGR7pbWVhZl4lq1fSZW/8mLmCLXhOD70vhTu8GFDAef30M6nk4P6OeVIOui7x6YtF3Y6H2lIjwMzQDiTp6sNY6HAkV7KhNpmWdCDaBrzRG+0skidmOqCeZkDIlkE02GbWvn8ybaHaDm0wqGxsIcEr6PZs9p+yhCCizzos/PAqiQi6pVRogQtLwLuNtQrZdsK1EAg3bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxeAmJxcxnjqmCzSS0L0at+ciJnTgCOlXF25nUaZ+XM=;
 b=CHi7fwZui1neVnokADH/RY7EPHqaIeF4oa5RGsbkhL0Gj0oNCi+cNJYO+XitWUTCykBAWC6fUrx6yqLYcHgC1l5XNmt6lsl8nlQathpEa9Cd33U1S1CjLydJ/i7s3v1iKxtXqXo+jc5NQPb4w6J29tyjnn55GzvWljfE4OIXR1A=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Thu, 16 Mar
 2023 02:09:18 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::e4c7:294b:cbb7:3c60]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::e4c7:294b:cbb7:3c60%3]) with mapi id 15.20.6178.029; Thu, 16 Mar 2023
 02:09:18 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: drop the extra sign extension
Thread-Topic: [PATCH] drm/amdgpu: drop the extra sign extension
Thread-Index: AQHZV2cf/AzQRBfSHki0ZcCzDvJ6dq78qbBw
Date: Thu, 16 Mar 2023 02:09:18 +0000
Message-ID: <PH7PR12MB5997B3B4A1639F00FC2D2BAC82BC9@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20230315175329.3774178-1-alexander.deucher@amd.com>
In-Reply-To: <20230315175329.3774178-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ec42d141-51c5-481b-a8ec-0488ab331613;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-16T02:08:49Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|BL0PR12MB5506:EE_
x-ms-office365-filtering-correlation-id: 3aa3806b-e27d-4084-1253-08db25c3732f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +VvsPOwgBXGvwL52a/3c3NsnPI26P7rGRNNp540Zoz4fTVb/i6BryTBlji34llUWemA9WeRMFoo1IGl5+s2qfDkVu/HaBhIYG4SINotTXhk2mX6ayB24V02oxGa4VZvvFmybeFfM95Yc5385BUQmsG+Umin+hLt0Nj+lKO/IqeaWgsG9DhOwOe5zM6CWD8Tx+mWX4F7Enx1zdyrwdvlUFZq+wHRkAZ94cLwaY03Ows7AviL5O+oQn/rks9Gic32m3twipNNoRy3Lq8Ln1FbIAacBO3f044ATfbZJ966RIvnjWj4QJb2/gVB3/zY+0i62FZF5Hl8QV5jmTPSaxMmCjmwx9olyuro6+Kln5lFPT6IKEGZYxkb4a2PgVpjUNHpHpfoSxS/7MVHFQo+yLgayg3P0Pm4469w6LSPcyh2EvwpIKf7xKTWJlFRB+1xllVj8KIS1zfZWt6VrUQ1KhpgB+JaivDqZy9apEAxcdPr1sjgUr6qkjtiX4DoacXw97gn9AdFdfU3VO17pExywmUjIMQACVdAV6mD4peVOdmvYX/R4sFfKg1v/TY8iVH8YavuG+gnxiSFOEiOWepxoUytUj1RCoCD7bfhXVHzr521k8EOuzwkTIm7L1moTxyOYfF9ZD+LukEvtmY1cwvrsPuPi0TcNxGXp2FYVRhKwC2HHRDNw8Is20MCo23gDC9IWLRhX6HtvLalHEtcDEbu/GsjEgA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199018)(38100700002)(86362001)(38070700005)(122000001)(33656002)(2906002)(41300700001)(5660300002)(52536014)(8936002)(55016003)(4326008)(6506007)(9686003)(26005)(186003)(53546011)(316002)(83380400001)(110136005)(64756008)(66446008)(66476007)(66556008)(8676002)(478600001)(66946007)(71200400001)(7696005)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8hQ79m265CfJ+6uJmRB01wKwULcPEMCfqoMW8mPELfQzxjSqtJB57///4ZmO?=
 =?us-ascii?Q?uTqCfpGgCpFXSlvsxFxAD77/MJiSplWqTDnKnVDHcc2kDB4LdnLszxoVy7on?=
 =?us-ascii?Q?A3gpSGJD7Z84rn7iuAMCzQGyjAQNYPmbBIwpNerCK1nePSEf81VDLg9ERtN8?=
 =?us-ascii?Q?R61IhsOjKaCNnCuF8DvL9Sj9ypdC8ojcWma7SFYZl0wYZn93mdvDxeJuzZtf?=
 =?us-ascii?Q?9EoXXvn1Tphjxw3zgrNGng4IvuiaUumNA6qyoQS0ub+xxPHwCPiEY1ligo9A?=
 =?us-ascii?Q?sZuBm6m6tZz9qkrV9gciNJ9XeuGQlYojA/tQQVcWac/CBPIT3qOGlAa7nCJp?=
 =?us-ascii?Q?PWEib3Os7vj9dOtbXZJ5VCOEhG560ICoWuWfhMJt07eMZ9QDYtdLUbC3KBPK?=
 =?us-ascii?Q?xW0mDMkFZUs7h+CLQPGy6S/3ny2N8/09qNtl5itst74VBNiImQH3Tt/vNJnx?=
 =?us-ascii?Q?iweeAqSG1ikmm+wg2KqbSjtLjCeBVute6Wyzo3ZM21Ql+I3wS9tBHGVzoPTA?=
 =?us-ascii?Q?fDnL/PC8yao9YZ0QH5sZCecV6w6a+1h8TuzcDpZ7P/JZnYcVNcARlOz3jRVg?=
 =?us-ascii?Q?VW+hOrf0WMEpphWrBWdV250NSButnCtG3yzrLE1zHpXpzP/osJFPuZEolpSp?=
 =?us-ascii?Q?eXLJvn86jW//u/ihh0q+gJoAKzWWju3oJ29etZuHcBPifB05rhI4Zo5rLejT?=
 =?us-ascii?Q?uEzF9lfNiD1rRhBMSQNiueLi++YMth74Lu2EIxI5yz8nM0kSJKp5RACyU7lC?=
 =?us-ascii?Q?Ry6XECnXKz1BRxGxVLrcVeElLiSn2U3teZtHFze8jlwRE3OhUDG8fdFHcogG?=
 =?us-ascii?Q?VvipM35W9V4mksGJTqEZSwRZxwFhf4PbyRvo/cZ3EYtS0xDSHa0VaDuH+NJM?=
 =?us-ascii?Q?DDhR4Po/NrGPR+qUPUg4zLUPxqsyoYZz/OEPNfqPlaMj73W3pWYh1+FwEvPL?=
 =?us-ascii?Q?gOWWYNCmUhj8VdsR6aVBUXHCfrkuUFFmUkrqysiomYk/PMXhZ9Y0gTsuayfn?=
 =?us-ascii?Q?we78b0P6O+peQFgMKpwdzjb3vmj7OPt2DCVJy/oUxVYTbPy8HEQsBPnbLKyM?=
 =?us-ascii?Q?T6sNdY+B6jXKA0QFkOE2oSwq6URLWdQvpLIDlmyZXA9Jmc8Wfz9AKhdD46YM?=
 =?us-ascii?Q?QMl+Y0bCmSqlEwvA7cW+jRred6ccFJXe33049NaWUEQn+5HPT3+fWDUzgFHJ?=
 =?us-ascii?Q?Ku6Asw7d0jTeyN8LJ6CU078z7Nzq5fh26w3zjXyuOWK5g5HeSJH2BtpR9yyj?=
 =?us-ascii?Q?jZdendmjsqMbCdYPDgNf75OHXUEI5qdiKASYe0DpqdJyeltsQIAH4W58ROxg?=
 =?us-ascii?Q?wMoblumV9ogwHKDI5GM8VXhTXPzmTeMZe+ItNkMFK1bwJUkqdWEiz57yzif6?=
 =?us-ascii?Q?qDBKUfarUaEJPVwG0UcyCGpWLgvGi3b4Hsu81xiFkyvF8imZ5/hxayUsQ1Z1?=
 =?us-ascii?Q?w098khpQT/7xWSStfYsYgsDA/XMyjPZ9vkjtpcE1iPpIgRvtSmez3EWUDXwE?=
 =?us-ascii?Q?b5X3gRkwJr5xiuMf0GdnZ2RTx+IuXizwuvqG4ljEaIMNbaIEGZSgMNvJyVEn?=
 =?us-ascii?Q?uu5MI9khLkx+RnQuxdo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa3806b-e27d-4084-1253-08db25c3732f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 02:09:18.4216 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EJLhLdetst3t9+NKiwfLQ+DoKdlV820noianFtUvq0Rt72X9OB/aH9x6/5VF2qgR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5506
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Thursday, March 16, 2023 1:53 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: drop the extra sign extension

amdgpu_bo_gpu_offset_no_check() already calls
amdgpu_gmc_sign_extend() so no need to call it twice.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm_sdma.c
index 69e105fa41f6..ce2afd7e775b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -152,7 +152,7 @@ static void amdgpu_vm_sdma_copy_ptes(struct amdgpu_vm_u=
pdate_params *p,

        src +=3D p->num_dw_left * 4;

-       pe +=3D amdgpu_gmc_sign_extend(amdgpu_bo_gpu_offset_no_check(bo));
+       pe +=3D amdgpu_bo_gpu_offset_no_check(bo);
        trace_amdgpu_vm_copy_ptes(pe, src, count, p->immediate);

        amdgpu_vm_copy_pte(p->adev, ib, pe, src, count); @@ -179,7 +179,7 @=
@ static void amdgpu_vm_sdma_set_ptes(struct amdgpu_vm_update_params *p,  {
        struct amdgpu_ib *ib =3D p->job->ibs;

-       pe +=3D amdgpu_gmc_sign_extend(amdgpu_bo_gpu_offset_no_check(bo));
+       pe +=3D amdgpu_bo_gpu_offset_no_check(bo);
        trace_amdgpu_vm_set_ptes(pe, addr, count, incr, flags, p->immediate=
);
        if (count < 3) {
                amdgpu_vm_write_pte(p->adev, ib, pe, addr | flags,
--
2.39.2


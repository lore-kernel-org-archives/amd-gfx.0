Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C719EE0213
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 15:27:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7829310EA33;
	Wed, 11 Sep 2024 15:27:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f8uEN1zA";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9279210EA33
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 15:27:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3wuVFCO4surCt20kCuFHP5SOMaJyY9MHVTbZ0EjQLUMCfiXH4Pv+9j7lFE6V8ZW2DJnSebLgOGz6+8BOHqZRfMAsNJd9wYLLNYVK6GcnqTZ5nAHMoEpmou/qBY4imTQvBOma0zptHxFtvKmuX9quSuBcugnaLKZlYYfTYqtHFUcbw6zAm1QOlsFYY/sbLDhwAKOyF4dlhaY8OJ2R3NjjfGqUynmkJrTf7jn22nZeBveaAZkzOLjagv6qCWW6TU1QUlzKQSpbWwguI9c+a+iQLS5yu/Fm+KQl5SsLC3ZlIacOx/UAx9H4V3KcfOhCasHDtJVGGaCoUMN3u2ynH5L1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BteDGcfIt5YfzFDr1s0jb5c2CPBrTTz/7HUgNvFywd8=;
 b=uXDy0pazYc8rl/LKv+SfzgbYfX1Q7YckzFFtlQf5YwjGo5qBka9PDKd85JH4WYXZ5b40QL+i8SRcThopFcKgAwP36jnJM9TUJjRsVLFkFqVpeODUWaOY3SsnzTOyu+iNq/spC7Wa7ienM0UshngTbdf0omTNW7nXtZfa0hWPrG5QsqV71+IustV+/f1Dr0NG0+uDnF9rSgOoz+jCWMXfqUP7bYJkcj1b5hKPzYnPa9ZNSFk6VRvbpDuRnFvNjbafgtYUOl7s9VNxJwvtQgQsvRWSyEvL9UVo+MZb9naDFZlRtXkqZbay08rm/cfMh55thaNni6lZ6HONCmMp/nOWow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BteDGcfIt5YfzFDr1s0jb5c2CPBrTTz/7HUgNvFywd8=;
 b=f8uEN1zAZN33Qp+ShYEUgiSuvDvj/0CMP56H998MPGpLX2GtRK/w4LUbScnXpsrNaXZuydeARt1LwCYWizoXk+2CcuKMdpVAjPmDT2NRo6r9aSo4/2nkA5aP4W2zDyRir9JvhI2RO6bXb4/tI6X31+QbIB/2j8BUNfGjYFByXV8=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SN7PR12MB6765.namprd12.prod.outlook.com (2603:10b6:806:26b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 15:27:18 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%4]) with mapi id 15.20.7939.022; Wed, 11 Sep 2024
 15:27:17 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Russell, Kent" <Kent.Russell@amd.com>
Subject: RE: [PATCH 1/2] drm/amdkfd: Move queue fs deletion after destroy check
Thread-Topic: [PATCH 1/2] drm/amdkfd: Move queue fs deletion after destroy
 check
Thread-Index: AQHbA4aTxe+wVo7HL0ic+W8Z7/pZ+LJStjwg
Date: Wed, 11 Sep 2024 15:27:17 +0000
Message-ID: <CY8PR12MB74357453DD76A0AC07550670859B2@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20240910133703.430803-1-kent.russell@amd.com>
In-Reply-To: <20240910133703.430803-1-kent.russell@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=fe008b53-85f4-4f83-9e11-ae7695525cb7;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-09-11T15:24:31Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SN7PR12MB6765:EE_
x-ms-office365-filtering-correlation-id: aa5858b8-8249-4578-3477-08dcd2763840
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?2A37h7Y9AyRizIVxVdMFeVpPcedg3JjRLDdBilWrSwb1uZb9bdMTMZtAWQ8A?=
 =?us-ascii?Q?rIv/7S6b2iy+ScQjhjkmYvp+NlBGlK0PqvzYl9zyfCbYfSZTJP3UYRh+msXe?=
 =?us-ascii?Q?yd0dsglyUVZlxxyUGxIDYMJEZ/ASOQYvideonfdDtUPmi2v93Eo/+gel36Z6?=
 =?us-ascii?Q?E+PkwlpulBUvV/F80ZOTKcOi4TQnXJvQaDH+Qvlf9CK7XNppY20l5swsEn+N?=
 =?us-ascii?Q?EBFxWQ2B1ADjSFBGyaYsFqSuaX4/5sHnpKVBP0/BAtoy39WYvxkLZ1Da4ulg?=
 =?us-ascii?Q?I2dlFwGLimSYVJlXJxz6trLGYru7Vc3sKYr71m4pEzokwa0IWp4kzmTa7eGT?=
 =?us-ascii?Q?t0amQEsX3Nbq8mLwQuWxxT+n03NPUAGMGFJBVBawKC7frmldc8fb73n2LB8M?=
 =?us-ascii?Q?2T8hgDqG1pcUKjuqwftYmqK+3KnTIvZInASpCzEiauMIWY7cAX9R6Ncf1r0A?=
 =?us-ascii?Q?yzQJ384nzi3hkQM6ulYpEnRe4k4+B3LUwDCJJkiR6rHzEsotlWzhww8GOhCc?=
 =?us-ascii?Q?79qZiQMHkq2iFJ3JVfhTrOuTSZ7hwZAAzhYlhWzs4VoYqsvwfX0CHRlGIOpE?=
 =?us-ascii?Q?8S6vrE7iGLSx2DX0a+IRwSFNt4ZO9h+d0OSSBtO8cic8YG2F0KhUqyP++kjZ?=
 =?us-ascii?Q?rjfueecWqSxJegqNkJ0FSY/1mICTAbM1Bvzs6N7Yu0pe/evv11iXJl3X5BaD?=
 =?us-ascii?Q?RyGGKSXf1RdG0768KzX7U2PXBGjf00YY6WB3uOBR+QBEJ7RPZWW1kCCpJGhG?=
 =?us-ascii?Q?t7VNbV2Ix93GPe6mWnbReHGqYbsdHjnVlDDtFhOTFW8N7pPVGswkBmDcrLlm?=
 =?us-ascii?Q?Jg6/8Ku+GP4+LeiLT56QYTfrS1zb5aViQxNZzJX7m+ezGdolg8bKwPuVyT9N?=
 =?us-ascii?Q?1N2/gfKEnCTFJ5KB0cTxz1x8k0bBIN8m6v8IEe9ZsvZqVfCghFoGWh/gWomK?=
 =?us-ascii?Q?khh/NLVx6EGyVl7bDMmbeDBPpxcbJWDb8KIfaxIfa9UDxpZkfIeBDLGyF6r5?=
 =?us-ascii?Q?C7aHOnC9jD/uXyV5EnebRJo5aw8UXLU+owg9bniu0fKEBbGYzqjKUO0OUFFB?=
 =?us-ascii?Q?dQHkxuSYYifEzecH5YKW2ACK1EyEntkUqIdh2tpz1bH3+XENazjWSqFu8il2?=
 =?us-ascii?Q?gYU2imZ93oyPdTJ83QNV18HPg0Cn/HwjFLsJbcXg74IdZNp+c/PBtwCp7prn?=
 =?us-ascii?Q?dMVV7x3y2bHNYMQ17S2GwnswnILAgPZ6D83J1NMQJ2uyqlWdXbYsznaPJKqL?=
 =?us-ascii?Q?fe3m2/rmPRs4peZQw/d/uzOeuEOYbt6lRpFv9X7/7QIWUDnQVGGoFnRBL2hH?=
 =?us-ascii?Q?ohGxgorLJRkCC25Ijy5Jsl9ndQi54dPGj+sPXQg4bHw6aqHRZtattXh+HaPr?=
 =?us-ascii?Q?OMfEvpIC5N3m30ttpFGEGgVc3+HTuQk1FnndhQjCQMz+Sva+kQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ChfOvaNMcSrJbKRi11SRHx6TYkLKYLTbfEhjgyTFGmOzQ4L+YUKmzOuSMJwq?=
 =?us-ascii?Q?9RBczEaThEnDuLGLJEODqYwzdM1iAGBi2EC55QbBugJsMuP3iFyfRZYQep8A?=
 =?us-ascii?Q?zETI6DSeq8oy6yFB0yyGUwFkxp3Z2sd4x5vgMW9g1hLq82HSl6VQK3joh/FS?=
 =?us-ascii?Q?Wl2yHNPD5+zMeivknLcN+oe+A3c8bv2NScre+PMlVLO3RkpKhvQLmeXQNoJF?=
 =?us-ascii?Q?UB+Vju3SrZD3bYUR11F5kK9JImsifAsE1ECjb+4KuiESZHM7kzRYFEUT6VMF?=
 =?us-ascii?Q?6MM/ePj2Mttquzdrzz2RvjK+MEHxdh4d2q/zXPf+uEBfzs8OxF6tXt9TWNb2?=
 =?us-ascii?Q?jUKM9PGcyB1vGW7RGFrwBOcN5ScMQkOw69uyi+G/2C7uV14H8Sir/uRsvlkg?=
 =?us-ascii?Q?3wU3Dj+pkL0++7p4gFeCagRfxw7Ts9Uj5vKTdIpN2xv7NEcu9Q6AfaVwNdUZ?=
 =?us-ascii?Q?vTg4fS4xkAHkX13ztUzPLWuVH7SViyLohtT9HxnYHfpouOACYhlopbNnDVK+?=
 =?us-ascii?Q?ne9C7lxdtjtNu0kQEpsYnN5V2iRHxXCq+EyhOmcVnOJfi6k+wr1uLThsh39P?=
 =?us-ascii?Q?2Kjghf1DGXHDdGL2h+aLIOrQQZ26mo2afJcoKVc7XRWWU2pr1aXLG9I2xsR4?=
 =?us-ascii?Q?uYcgQ4TQL0TsqE2N8St0qwfB/uG41S1Mjp15EeHXrMUsVnf1F5lwbOV1JexY?=
 =?us-ascii?Q?19SFZb8/u4n8xnMB3i85WlwkoZvU6rlJ95fJESL/7TAyoz5TzFtz/ngvH1o0?=
 =?us-ascii?Q?2ld7mSEvC2tgFv5eRgfjqeF4+Mj3uXmzxKPssGHRSv3D0oEYOGoReIk0wBQV?=
 =?us-ascii?Q?XQWqHFl80v65aQ8iXExFleWBFPidJ7Kg5pRYfgoDWFb5353nkEEOhRmhO/1K?=
 =?us-ascii?Q?5+aaXa6BlLC5UPjISSPq14ij68WWSkZiJqs9jiYjX4A+cuAwlSyGpAtDNR/U?=
 =?us-ascii?Q?1LniSzUK4Ei2NvSA6y1zTpgPbwjju4V+LEWFyuZSsgT/G9T4mD0pIBa9eqJ5?=
 =?us-ascii?Q?CxLMZQSTZW2prwXWD7N+7cdoTNP/D1jbBB66F0VJcwhhOPZPzk65U/4dGQje?=
 =?us-ascii?Q?7hPSQKj46ZLtDdlXmUhcOBR79s9Me5JTJXi7DSTwgdv40Z8D1tYhZrZ6KDTX?=
 =?us-ascii?Q?y5C12TwqSn5hlxe/nSvhQtz/Z3neATczqf4kF2d01KEYAZzxHwk6tByWT3cG?=
 =?us-ascii?Q?YqB2UPXRQ+k9Z9AI6XsVYIHinlz7u3efBuJ1FKioJCpUHwXur/ZdCCupU5SL?=
 =?us-ascii?Q?HTVq1p3liqBx58vWu0/6J3Em4AbSNArFxTooMoGUK5DP8ANj5aO+jGXdJ67S?=
 =?us-ascii?Q?fhVlDmHtgMvyOB7b+j+G52ZYKOY0Xs2RGa4bxDbb5Wb8ex481pn2IoCPpaNh?=
 =?us-ascii?Q?x4btf7Vxo6W1yIuvtwsrj2wct7Ejayr0bQPC9VDG/DaHO+8lAdLfOYqSxfzl?=
 =?us-ascii?Q?qUixesBs0DWwXB+oDALV+t9RN67tQkfCtPDXpe/zSHUlPkwOT8mCtjb9vVob?=
 =?us-ascii?Q?TEmUyeKbh9jZ5VXU5f8kdApeWjISsXCr/JnBVhyN5ZV1u7CD1KjLm/SsF3ku?=
 =?us-ascii?Q?DnzQN0ObS152UNKPF6A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa5858b8-8249-4578-3477-08dcd2763840
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2024 15:27:17.1365 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0sgWXZ0aP87+i36akAiGCpcJedr5VUisQ6s48KAODim8JX8ooHAw3ZUX8nr7oTXy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6765
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

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kent
> Russell
> Sent: Tuesday, September 10, 2024 9:37 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Russell, Kent <Kent.Russell@amd.com>
> Subject: [PATCH 1/2] drm/amdkfd: Move queue fs deletion after destroy che=
ck
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> We were removing the kernfs entry for queue info before checking if the
> queue could be destroyed. If it failed to get destroyed (e.g. during
> some GPU resets), then we would try to delete it later during pqm
> teardown, but the file was already removed. This led to a kernel WARN
> trying to remove size, gpuid and type. Move the remove to after the
> destroy check.
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>

This patch is:
Reviewed-by: Jonathan Kim <jonathan.kim@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index b439d4d0bd84..01b960b15274 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -517,7 +517,6 @@ int pqm_destroy_queue(struct process_queue_manager
> *pqm, unsigned int qid)
>                 if (retval)
>                         goto err_destroy_queue;
>
> -               kfd_procfs_del_queue(pqn->q);
>                 dqm =3D pqn->q->device->dqm;
>                 retval =3D dqm->ops.destroy_queue(dqm, &pdd->qpd, pqn->q)=
;
>                 if (retval) {
> @@ -527,6 +526,7 @@ int pqm_destroy_queue(struct process_queue_manager
> *pqm, unsigned int qid)
>                         if (retval !=3D -ETIME)
>                                 goto err_destroy_queue;
>                 }
> +               kfd_procfs_del_queue(pqn->q);
>                 kfd_queue_release_buffers(pdd, &pqn->q->properties);
>                 pqm_clean_queue_resource(pqm, pqn);
>                 uninit_queue(pqn->q);
> --
> 2.34.1


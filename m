Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CECC55182
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 13:42:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 591A610E669;
	Mon,  3 Aug 2026 13:42:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3f7p6Am7";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010033.outbound.protection.outlook.com [52.101.85.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAB4D10E669
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 13:42:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hgtby11/PjknvFXMwyshpetz/iuh6PTBnpMATwwKYeb3Wch887wackVSYaBaSlGAtDWWKtMLcxkQWkiZaOp9bL188S9m20zvvdDpdGIbXpwjmfQLqghoX9OUgfqMr0cUgXr0MNF4Ll9mes8yU3V8M3X2233bUif8J/NYujPCXk+J9Bhc8hwhZ4gN44ivBAEVazMAqfXjzbMNcFMx/FM2XFszSKNcBCkPgxhZyWl07gKcNUOy8tpM9EWJB72qH6cz4Au4v7BxrtyhBofeZYEc7//Q/MvCuOt47dm6exYo3ymsRavH2NGcNzgrwT4pI96X9vtydWUuUnzgcc28hEIC2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8sU16n+VwAjCedF7DtKJ+xa9J4hpIRGFetf8OuCCk0=;
 b=VmxKPcRvVQi3Kn5NVtjqfjNQFZ5HbJctmQIeEvA5OuFudssDIrUqo0i3z50UXgPwyz6Hdy8Npr+zTLID4tVtdbHTT5LQ2LndMIECrKiojgUxU04e3adysd8EJVZv8kYETz30e1FhdChs3qKOcL50FSpqzPx5iFEzop0UkY53Eyjiu/LmsTbce1Ffsn3GaQYwHbbeYvzYWnn4zu+DQJm+E6QQGs0ny8hzCEhenMhHbPDhJ/0EShc8Eyh8AVwn181KWyldA8YwkkTi3uGIcjN6FbqIOQ7OOZFHTOAhD7pENIBICaAMTLQjq1e+/NNXxDCbdH5psE/XMPb4eau6vlV/Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8sU16n+VwAjCedF7DtKJ+xa9J4hpIRGFetf8OuCCk0=;
 b=3f7p6Am73pWH2Y2AJd6LyZ4BUxhOdPDiv1Yuhf09ZGYb8xxqc1UyyS++arhPj11veJceC9jdarfFAuOaA8jV11uNGTuqSacKC+M4wcUzjnZOdn3XyaKxTOWTzcbwhRUnvpOq4wk7tOZcjoNeMcyMWMjlYqncoJMK9MftaTQsYCk=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 BN7PPFCEE68E7BF.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e2)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 13:42:47 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%3]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 13:42:47 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/userq: serialize queue map against GPU reset
Thread-Topic: [PATCH] drm/amdgpu/userq: serialize queue map against GPU reset
Thread-Index: AQHdIyu03BEuvT2JD0GwJ/m++EcPDraMVCzg
Date: Mon, 3 Aug 2026 13:42:47 +0000
Message-ID: <DS7PR12MB6005938B3A515CD6A9CC504AFBD52@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260803093713.1904533-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260803093713.1904533-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-03T13:37:41.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|BN7PPFCEE68E7BF:EE_
x-ms-office365-filtering-correlation-id: ab05cc27-b558-46ef-3003-08def1651a81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|38070700021|56012099006|11063799006|10067099003;
x-microsoft-antispam-message-info: FAk62b8pSg1LA4+Tqn7OmamhGkdGD+rAENVLFm5oC1+S6O7lSp8BQee5h2+tkxjJ98uTaLWIgu3N/reZGQEpCkGmBV2IzVBPVdamgZ1h2EbAcekRVoHE8XwhV0YExCokcsRHVbAMG4jzg1YO0E4B7VR+dDCu7citb+EEqNF5m67wxECgGzEMve5eB3WbI1j8ToJLabjAEsoXIIehSD8A//ledyt6CDFlXmSv2b4DC17/opQNF8vqmDP8rrQlyaJ3RtU3S9/ylLVUTtiXUAitcjx2bYEiepAwiRqJeROLmyN6/2tlsOFCYPzIHD0K35Hn4/n4PD9a7DomTS1q4/jkQCUNXErgZaT05hcR0WL93RMRdLBsJQWl8hCR8q3TCdIVw8m3mUqwa0wfZtAuNBUwlfDfbkNRaPrYKnbsGTQFxpkgT09jg8FTH1DNRFu4r1q7CFD2KWtj1VamIqhIOiIw/RsaN/IBP3GKYVXxNBDz6PW5dixAbYoDqvqoyEhB/VAHSFV2WGjb5q13UxJ+e+Z1Kn3no3eVXN4CFM7Ujj6ugy8lTRnDmcrvMhuZh+Bi/fTqL4ZLHnqnG+E/HRM+dusZsNjj+0/fzcmfqgKp3ZrlBNHfePa6InfpueVYqjFbvrzLHwqexfpOQz7gPKjiv5D4/sb+rVhQ5DxY6Egp2PeLtO/k9mo+7New2P3klzwGkqluFgVbCt1yixUBDh5y/uvzaClXHoNRaFEI0vdHt/fN6C4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(38070700021)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lOMTZIjhXZsKHxPLD4GgVJYinLeuVE93Fpa4GddlMTjHzeg0dbHp/Tiu27l4?=
 =?us-ascii?Q?4hpQmeMcErDREo+cXNqSP2Z4X5YbUVmRR6vbviBe8frEFIZtH8FW/iIS3Asw?=
 =?us-ascii?Q?trqLUOmNFxhxzPw86U9f1ybmHoC9SOMbd3yE0MXrvbnUTDkaSI74lml5q3r5?=
 =?us-ascii?Q?OMgk/Eg9+lj6fnsRERsuXAGGZN6r3aOLTU3fuBHXIpRVSq0+93bnEtK1ZV8x?=
 =?us-ascii?Q?0me9rFYGxXSQvgMwOONwZvieNmAxVxJPaajyeFAEtN54T0Ex1BXU3vZpYNIb?=
 =?us-ascii?Q?G4iZzl/Zr1VTr6/DrME+MoZ1NuHgPpQLQXoVUZUT1TchAuSRlKvqnMarzVWO?=
 =?us-ascii?Q?pZgZfjrupPcRT3I12SxUMNm2DdXU8mTEU9ngWrvmTW7coOnKnmLyhcb8Su6D?=
 =?us-ascii?Q?HnVd49bgClL5PRuW6MUAC30gCJa5UV01V6RrrCTWhah2GcvSn2YEHbyCMj+i?=
 =?us-ascii?Q?71UigOyPTMFzM8F/1CAywht8TEJsnUgtGJLxxQUqaxPEutSKS3xiey9NVjd0?=
 =?us-ascii?Q?gJJ+E4WYTI5BqxIpLfKg0vYSdNCBP+Sa6L16Kyn6EBLfx5SnbVAl6XI/gEdl?=
 =?us-ascii?Q?9UBCRNNf1sVdjQUbL05lSUrBxrPLOIyAaV9pvAW2ilc1MVvbpJbaaB6yeK7F?=
 =?us-ascii?Q?yKzOMal+rMoVDO6OKTNu8g2I8RbeqXqaI+t4N5zkAXoR6J5WcqH0cGOFDC+b?=
 =?us-ascii?Q?u8odMy+zr0PdUtHwFHWY7aG6d5+4BSqgSXu8CVX686XytWXSNht2sHL7R/Q3?=
 =?us-ascii?Q?XsMeUsmt7VFFlK2HWRs4Xz8msQgXEQo6LCkgMzFbjuIhLnvKk4sgg1i+4KFD?=
 =?us-ascii?Q?+Eo0VEt8LWvFUDQZNN2UdIAN6r0gUJ6Tf/y2sx9nRtPGOdhycA/tPpz9mz2i?=
 =?us-ascii?Q?SWEbtKl2QSetwbDux1fMyu1ctd1I14XoavKry6kx2e9CoyiGkJrk9l0Knp7n?=
 =?us-ascii?Q?QrAfttaUVzacZNruFu/Bzbeg3BsQIy70GoW0/8L5uDgLbPg+jzsK4I+lFF0u?=
 =?us-ascii?Q?KEyRHxq7fIWQLQWEIQSwp05G6Lv35NBPCwdqzhSJyEnvOlAHySxuOQOJFf6d?=
 =?us-ascii?Q?zfTpHNHxwKgVQuQQE9m0Sw1T8C7zYuF7SR2W6Z4eyHGOUOKG4QLTfi6RxB7n?=
 =?us-ascii?Q?jk26Pc6NmQ9IFrBd0e4hIaT6eOmbe8+JUYdiXv9h+8nVbZtZJJgz92Qw1/6D?=
 =?us-ascii?Q?wbaHyA7H7F4brvROMFky8KGBXyHc/VqffukVRdbciNw8bLRQbYV0EzNYui3x?=
 =?us-ascii?Q?+8YQ+HImsF3GXXa1UDfb/IBLlDhiS8ie+qdR5GKdO3gMOc/7UfP6UiNVFJkW?=
 =?us-ascii?Q?E9aphASXPWkVw0Uuati90BHQ5B/HV9strd5yJKbOgeml1BwuaLlYbwxPU8UF?=
 =?us-ascii?Q?dymAWEXI4M/UGh9O53ExQ05t1GCG31RO/lcOrQV2k+9fr239tcQZcBWTeh+N?=
 =?us-ascii?Q?iXdEXKVdm1BP36rUgnyzE48WkDZzb+d+bW/eu9sBI260XGQx7HkswgoPMm1u?=
 =?us-ascii?Q?uYGqJAcu66TeD676Il7uPCnD35nptWFQr2wWn9T3BCYUg9MZT142vhFvsBWO?=
 =?us-ascii?Q?FS4RoniGjkbCcafmsYiH49CXuCOHGTuk1YmBJgHEkAn1jfoLpKHM5r4z7zgQ?=
 =?us-ascii?Q?WN+xe9i5ezFCdTOKY5f+xuPnQJ27Pe5bdxUeRBmpjQ+GWKJQY/GaC8et0v6F?=
 =?us-ascii?Q?HQi3xx3OaRw24pmOvMVXSTuyEg9DT5hfqNC5z8MwJe9apGzj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab05cc27-b558-46ef-3003-08def1651a81
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 13:42:47.1707 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JlZd1ENyQbX7a9+yt2de4GjD/IKaFbCTHK5ScTirJ6pd1qn1EC5hkvXERYYdCc6c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFCEE68E7BF
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

We may need to ensure some other MES HW accessing without the GPU reset is =
kicked in concurrently. I'm working on the userq eviction case and figure o=
ut how to handle such issue in a general way.

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jesse
> Zhang
> Sent: Monday, August 3, 2026 5:36 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH] drm/amdgpu/userq: serialize queue map against GPU reset
>
> Creating a user queue can race with a GPU reset. While recovery holds
> reset_domain->sem for write, MES is unresponsive, so the ADD_QUEUE from
> amdgpu_userq_map_helper() times out (-110) and an otherwise valid queue c=
reate
> fails:
>
>   amdgpu: MES(0) failed to respond to msg=3DADD_QUEUE
>   [drm:mes_userq_map [amdgpu]] *ERROR* Failed to map queue in HW, err (-1=
10)
>   amdgpu: [drm] *ERROR* ... Failed to map Queue
>   amdgpu: [drm] *ERROR* ... Failed to create usermode queue
>
> Take reset_domain->sem for read around the map so it runs only once MES i=
s back
> up. This mirrors amdgpu_userq_cleanup() and honors the userq_mutex ->
> reset_domain->sem order; the reset path never takes userq_mutex, so there=
 is no
> deadlock.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 652599f08990..770635ab5298 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -745,7 +745,12 @@ amdgpu_userq_create(struct drm_file *filp, union
> drm_amdgpu_userq *args)
>       if (!adev->userq_halt_for_enforce_isolation ||
>           ((queue->queue_type !=3D AMDGPU_HW_IP_GFX) &&
>            (queue->queue_type !=3D AMDGPU_HW_IP_COMPUTE))) {
> +             /* Serialize the map against an in-progress GPU reset (MES =
is
> +              * unresponsive during recovery), matching amdgpu_userq_cle=
anup().
> +              */
> +             down_read(&adev->reset_domain->sem);
>               r =3D amdgpu_userq_map_helper(queue);
> +             up_read(&adev->reset_domain->sem);
>               if (r) {
>                       drm_file_err(uq_mgr->file, "Failed to map Queue\n")=
;
>                       trace_amdgpu_userq_create_end(queue, r);
> --
> 2.49.0


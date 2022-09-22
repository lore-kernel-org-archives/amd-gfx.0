Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F9CECAAD8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 19:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8712810E06C;
	Thu, 22 Sep 2022 19:07:34 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10BEA10E06C
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 19:07:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkMkUJKMJPBRnYTROmV33Ayf2TF9bCsTPdHT2tK2Vu4csV9576gkQ4KT0GHKhETP/tY+YgfyaT6vdCbHbJh3FIqYnPHhqYnImPM5eGUtC+KLk2fNhYbFp7THUqBgxnYm1XW9GiwCVrdK3+s0y++YKk2/Z68Q33OnCZ0Zkae25x37dXko1cGxuAPzje3P4hgUJq7B6Qq7tiyqPZV5qdIjE3VuOu4nKT3JPKqtL8NYomHB51wAuAdJGGAb/HVyV7jjJMy+p5eOTh//cLovoZGRUSxHv1qqXlmLQkotKwMLqXVSsOFs2+CZ8y2uMtXTbSMmClOSTd9KBdS1GZD8XmAcog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTiuVZ0NdDcbr/Y7HAm8aZG4nvPsZXiN2bPjkskmLfU=;
 b=E//e6ww9yVSLFjbRT61hjoIPXvlO73tFqITLVSaSx05eS/b4gptuNZtl8Um6elVLJk9Sb7mx5sVnBBd/1xm/qvv1AqhuwuPgGpUGKVENiN7mM69K76YQ0Cd9iR1L4PzS/tSGSl2UMSde3HKVHSEyTB08jkRXPXKegTaUfiUpLxwx3FRIyNFw70EkgWF5AeIknGhohRD82ina0y+Tg5CQxYvKW0kbBLF5fh0CRsgOhxz5YgfzkqmQMFUHA86iO7SXCNvRm7hEjTnj2q4VJzlG6bcyyph3tnVzFmLF9t/N61f3z8KIRxuvWskpOQK+mGI5CZP6laeUM2DxODvNhhSTCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTiuVZ0NdDcbr/Y7HAm8aZG4nvPsZXiN2bPjkskmLfU=;
 b=XHMtt7eLAq3va+eq9ymP78FFxDRJ/txg970UViMZML5JVaGWf0As2zzCfpkL4x75fOWHqyypAFen3MkD5qdiZ7p2z5e5A03kpiFF0y6CXx2jj7j6y2590iG3K8tNNuJdGZI56SmFueGN6OiKy1Yhce4zFnS3dGusKdMs00h4Dew=
Received: from DM6PR12MB3067.namprd12.prod.outlook.com (2603:10b6:5:115::10)
 by DM4PR12MB5916.namprd12.prod.outlook.com (2603:10b6:8:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 19:07:25 +0000
Received: from DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::3c76:8e77:b067:49ea]) by DM6PR12MB3067.namprd12.prod.outlook.com
 ([fe80::3c76:8e77:b067:49ea%5]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 19:07:25 +0000
From: "Sider, Graham" <Graham.Sider@amd.com>
To: "Belanger, David" <David.Belanger@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Enable SA software trap.
Thread-Topic: [PATCH] drm/amdgpu: Enable SA software trap.
Thread-Index: AQHYzp7+6sRPfTKw7E6GpKL2Udng4q3rumcwgAAQU4CAAATZoA==
Date: Thu, 22 Sep 2022 19:07:25 +0000
Message-ID: <DM6PR12MB306785B59CB09F097F140D098A4E9@DM6PR12MB3067.namprd12.prod.outlook.com>
References: <20220922161703.916705-1-david.belanger@amd.com>
 <DM6PR12MB306708116CB46624BBA566B38A4E9@DM6PR12MB3067.namprd12.prod.outlook.com>
 <DM6PR12MB482884F3383BA6AB68162FF9994E9@DM6PR12MB4828.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB482884F3383BA6AB68162FF9994E9@DM6PR12MB4828.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-22T17:50:44Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=1b478eac-f379-4180-a6db-9140f63fb29e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-09-22T19:07:23Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 3e02bc31-837f-46ac-8c3c-e5544b6e6663
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB3067:EE_|DM4PR12MB5916:EE_
x-ms-office365-filtering-correlation-id: 530a5aae-a3bc-4c75-ffba-08da9ccdafa6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eRHQTLqE5wa6I+iSWL0lb5kVibOxRKvsfnrVhtAxwnNPEWVJTnzd/bpFlXpeo26jjohFRTff9CEhvBz3JPFjSPQ1t6egwnmT22ZhWEF+wbPIy2q6WOIsCVnWL2BhhG5oAUF2fnwW+FGcqiXMtpuUehVk6gR+Qok1y01xLF/PJ9mL/wc3lx/yPXA4yIV5aetZiGZ7GC+SdaS5f73cbIevwnlarwPfXNFHaJN5bzGfThD89DA6Q7v2YSctDIQcc5It3rEm1WRZi1/l8ngE2VQC9jmwuRQek5WUT+sWlj0OFmawdcoGaWoX0ggc/gyzbullT7FUm2Y6+ArBLfDPTuAW1GcQp5m3sJ0NTwkWWoRuZUg5bvjDate3l9JQS2bxsZplyOoe1ierKKdFSvJsZZ+SubKHXny0EseW80J33r+GjbmMG+1PFFpa4b5ZLpeHYKkOgKOwD6udDNfJ+0o0xOt+YebxwcKB+6ykK6FzzKK7Jr+b04LwRTYrI0pT3MtEEXi9IVSYS/HQLqg7EOh8jPmXc6N6TYmreMuBSCF6Bb4Hf6cynV6xFaEtOxlBdlO9mWsGgDsdwx1gyMNoVITF0G0Y1QEOGAK212QFTsEwpdlnngqtgSqTciqVY7XF+fScLf6v2QlJhE8FU4rCLAODj0Aosko6wiXP+6fRECOkaAU/D1OHweT2uvlpt2tw9NwQyL9y5bjlj7B6gg9Iz0f2f1RGRzpW75ndUhtHzsUT04xM3HmxJzeHQXx9nh3tyQSbB+5iRXqbePN7V4I0k3oHL+gbOw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3067.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199015)(5660300002)(8936002)(30864003)(41300700001)(52536014)(2906002)(33656002)(38070700005)(66946007)(71200400001)(4326008)(76116006)(64756008)(66476007)(66446008)(54906003)(55016003)(110136005)(478600001)(66556008)(6506007)(8676002)(7696005)(186003)(26005)(316002)(83380400001)(122000001)(38100700002)(53546011)(86362001)(9686003)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pUXG2ggWgUrA3EHsIQZh5zgzeAwoFYKQf8OoWT9oa+MBtR9mH+JUsdZ1BTsl?=
 =?us-ascii?Q?q7ON0YV6e6gzGKDi5yUR8rWAFKbJFOilDuEIyyKQMQc4w/vYxCZR+KuoSrtI?=
 =?us-ascii?Q?JMixzXxN5iBczhCZl4O+cBkqxAGCxOyWr7pNi/dhBwkaLWvqSoimNrn0G158?=
 =?us-ascii?Q?EM6WflZEM+BZ26j2zph0Okpfg/C61pTQ7ZKnBkws0OSWCtVjdcRpiL6VRZ05?=
 =?us-ascii?Q?ALMRkfAO0GUrlBe/Sy8VNq/UahZOT7MEFCBim6Hgfo3LytOzYqkdh/e4O9mJ?=
 =?us-ascii?Q?RSo940VRBEIvPBXzCv6c/lUPPJwhEBq7CoiWFqdevRjXxMdJcHVdkId/jqVw?=
 =?us-ascii?Q?tI3edf4c942OllISmfiTrAI+UdC0PQZg0FO8hCci120u3dDnFz/ubzXdw1BO?=
 =?us-ascii?Q?ehNqcSKuSyAPzZq6qmPF3h8DxXjadj2x+MNgVeIatyUh1L2PskYsOhI9XnsK?=
 =?us-ascii?Q?54FnSMWljIlCZeO7aD+i+8Ae7Ln2cc3HT0/yiCNnVl7TKqd/O1tLz4QUHkw1?=
 =?us-ascii?Q?7lQcKHMntPBYXRkozJlAGsaaizgz6nxvtmO55HkubDRd6NWuYHwHk7jYOFLi?=
 =?us-ascii?Q?7T023n+y1sQUpCmU1Id7kjaHEgtsao6r5uHAqwCf/p9WCYbeeWlVD++tHUB7?=
 =?us-ascii?Q?kwDu3pA9okT4JDWtFc/G1pRjw9emKsSYlPjuuuQseRp9Ogd3iBTPMqlMyeNG?=
 =?us-ascii?Q?elrPrJEsex2PL86CgtSLasQmK4dg+rwarAtD1aWxk5d2T8dNxeJ9ixefo4zS?=
 =?us-ascii?Q?Nl/oJ6upDQbfUMVsJoy6igqXEXuGrck96sQeSelB9laRGZ6ZchFvgIC7pnoi?=
 =?us-ascii?Q?uo3hLoSjSPw1L+pW36BIe8UJgj9mADU6G9TNecohUiO0mgzoD9oynMaSsQEq?=
 =?us-ascii?Q?KWJtZKW/e8r/RUlr1+8JeJaIKh5Kr+T96F7olI+VaQFk9nm0GAILi4ElmWF5?=
 =?us-ascii?Q?+slKycnZjWe3YW4eqbW3Jp230+RAB77fBvbOKxuQ/gdANn1zzmowFVI+QGU9?=
 =?us-ascii?Q?5RWUsL8hu36QsPMl8m6m7QIeIKxpdi11uRzTtlUN1quYhHqNgCeuOXbG5guA?=
 =?us-ascii?Q?pwu41OP5M1E1Z/Tj0X0wyV8+xBi9esfXSOh34M0gvoXqsDmvHCOo0J5Kcuuc?=
 =?us-ascii?Q?BtjYLzglf9GZdXuVwhA/+GgBhf8avlKT+flQ79d4hOp57F7PzQ7h0Ld6W4JR?=
 =?us-ascii?Q?ooBDaS1jTwBLCoGHr0PVZx0MftRaH6UMnB4mYNCiGYbtpaXz4MMQ6k74sb2K?=
 =?us-ascii?Q?6dJYHU0q/5OalE/dVmrVCRn3CEjaHs36rZoMaAnjnbOa2encAUMjwKDs4I0r?=
 =?us-ascii?Q?4Z7jcRhB7+ZU/dWjgwjZ5etUIo6Y9VOMXGRjfNx+jOo1BcLUoU48w7cLznbk?=
 =?us-ascii?Q?kYxG22NZcjJa/NPZ5k2inw4tpInAiEQIaKJDihDQFfdVUt1qelzQCMrooL1/?=
 =?us-ascii?Q?aBAiLexwMnI4PY9tkJy08c4jGRyrpykZnWNe4Da0XhKdFZiNfL/8UZJzaRLZ?=
 =?us-ascii?Q?m2mD2A0T02aweU2t2C9xt38h7hiqTjWZ6q2tu34/yCoFCopeFWvoPwKAyMau?=
 =?us-ascii?Q?YSE7SMcsqN66KtFNbu4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3067.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530a5aae-a3bc-4c75-ffba-08da9ccdafa6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 19:07:25.5376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ym9yDKoywLpxD+SP8io482KFMJGUgUik+ZI3HMhBCIZpmkaukLS7fSkdcZTJ6lSWFoiuVYpa9xPIfOWj89YozA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5916
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Cornwall,
 Jay" <Jay.Cornwall@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]



> -----Original Message-----
> From: Belanger, David <David.Belanger@amd.com>
> Sent: Thursday, September 22, 2022 2:49 PM
> To: Sider, Graham <Graham.Sider@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Cornwall, Jay <Jay.Cornwall@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: Enable SA software trap.
>=20
> [Public]
>=20
>=20
>=20
> > -----Original Message-----
> > From: Sider, Graham <Graham.Sider@amd.com>
> > Sent: Thursday, September 22, 2022 1:56 PM
> > To: Belanger, David <David.Belanger@amd.com>; amd-
> > gfx@lists.freedesktop.org
> > Cc: Cornwall, Jay <Jay.Cornwall@amd.com>; Kuehling, Felix
> > <Felix.Kuehling@amd.com>; Belanger, David <David.Belanger@amd.com>
> > Subject: RE: [PATCH] drm/amdgpu: Enable SA software trap.
> >
> > [Public]
> >
> > > -----Original Message-----
> > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> > > David Belanger
> > > Sent: Thursday, September 22, 2022 12:17 PM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Cornwall, Jay <Jay.Cornwall@amd.com>; Kuehling, Felix
> > > <Felix.Kuehling@amd.com>; Belanger, David
> <David.Belanger@amd.com>
> > > Subject: [PATCH] drm/amdgpu: Enable SA software trap.
> > >
> > > Caution: This message originated from an External Source. Use proper
> > > caution when opening attachments, clicking links, or responding.
> > >
> > >
> > > Enables support for software trap for MES >=3D 4.
> > > Adapted from implementation from Jay Cornwall.
> > >
> > > v2: Add IP version check in conditions.
> > >
> > > Signed-off-by: Jay Cornwall <Jay.Cornwall@amd.com>
> > > Signed-off-by: David Belanger <david.belanger@amd.com>
> > > Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |   6 +-
> > >  .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 771 +++++++++-------
> --
> > >  .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    |  21 +
> > >  .../gpu/drm/amd/amdkfd/kfd_int_process_v11.c  |  26 +-
> > >  4 files changed, 437 insertions(+), 387 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > > index b64cd46a159a..cbc506b958b1 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > > @@ -185,7 +185,11 @@ static int mes_v11_0_add_hw_queue(struct
> > > amdgpu_mes *mes,
> > >         mes_add_queue_pkt.trap_handler_addr =3D input->tba_addr;
> > >         mes_add_queue_pkt.tma_addr =3D input->tma_addr;
> > >         mes_add_queue_pkt.is_kfd_process =3D input->is_kfd_process;
> > > -       mes_add_queue_pkt.trap_en =3D 1;
> > > +
> > > +       if (!(((adev->mes.sched_version &
> AMDGPU_MES_VERSION_MASK)
> > > + >=3D
> > > 4) &&
> > > +                 (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(11, =
0, 0)) &&
> > > +                 (adev->ip_versions[GC_HWIP][0] <=3D IP_VERSION(11, =
0, 3))))
> > > +               mes_add_queue_pkt.trap_en =3D 1;
> >
> > I think the value for trap_en here is backwards. It should be set to 0
> > for this condition and default to 1 otherwise.
> >
> > Best,
> > Graham
>=20
> Note that the condition is reversed with the "!" operator.
>=20
> David B.
>=20

Ah, I read it too quickly. Looks good.

Best,
Graham

> >
> > >
> > >         return mes_v11_0_submit_pkt_and_poll_completion(mes,
> > >                         &mes_add_queue_pkt,
> > > sizeof(mes_add_queue_pkt), diff --git
> > > a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> > > b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> > > index 60a81649cf12..c7118843db05 100644
> > > --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> > > +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> > > @@ -742,7 +742,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] =3D {
> > >         0xbf88fffe, 0x877aff7f,
> > >         0x04000000, 0x8f7a857a,
> > >         0x886d7a6d, 0xb97b02dc,
> > > -       0x8f7b997b, 0xb97a2a05,
> > > +       0x8f7b997b, 0xb97a3a05,
> > >         0x807a817a, 0xbf0d997b,
> > >         0xbf850002, 0x8f7a897a,
> > >         0xbf820001, 0x8f7a8a7a,
> > > @@ -819,7 +819,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] =3D {
> > >         0xbefe037c, 0xbefc0370,
> > >         0xf4611c7a, 0xf8000000,
> > >         0x80708470, 0xbefc037e,
> > > -       0xb9702a05, 0x80708170,
> > > +       0xb9703a05, 0x80708170,
> > >         0xbf0d9973, 0xbf850002,
> > >         0x8f708970, 0xbf820001,
> > >         0x8f708a70, 0xb97a1e06,
> > > @@ -1069,7 +1069,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] =3D =
{
> > >         0xb9f9f816, 0x876f7bff,
> > >         0xfffff800, 0x906f8b6f,
> > >         0xb9efa2c3, 0xb9f3f801,
> > > -       0xb96e2a05, 0x806e816e,
> > > +       0xb96e3a05, 0x806e816e,
> > >         0xbf0d9972, 0xbf850002,
> > >         0x8f6e896e, 0xbf820001,
> > >         0x8f6e8a6e, 0xb96f1e06,
> > > @@ -2114,7 +2114,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] =3D=
 {
> > >         0x007a0000, 0x7e000280,
> > >         0xbefe037a, 0xbeff037b,
> > >         0xb97b02dc, 0x8f7b997b,
> > > -       0xb97a2a05, 0x807a817a,
> > > +       0xb97a3a05, 0x807a817a,
> > >         0xbf0d997b, 0xbf850002,
> > >         0x8f7a897a, 0xbf820001,
> > >         0x8f7a8a7a, 0xb97b1e06,
> > > @@ -2157,7 +2157,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] =3D=
 {
> > >         0x01000000, 0xe0704100,
> > >         0x705d0100, 0xe0704200,
> > >         0x705d0200, 0xe0704300,
> > > -       0x705d0300, 0xb9702a05,
> > > +       0x705d0300, 0xb9703a05,
> > >         0x80708170, 0xbf0d9973,
> > >         0xbf850002, 0x8f708970,
> > >         0xbf820001, 0x8f708a70,
> > > @@ -2189,7 +2189,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] =3D=
 {
> > >         0xbefe03ff, 0x0000ffff,
> > >         0xbeff0380, 0xe0704000,
> > >         0x705d0200, 0xbefe03c1,
> > > -       0xb9702a05, 0x80708170,
> > > +       0xb9703a05, 0x80708170,
> > >         0xbf0d9973, 0xbf850002,
> > >         0x8f708970, 0xbf820001,
> > >         0x8f708a70, 0xb97a1e06,
> > > @@ -2475,7 +2475,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] =3D=
 {
> > >         0xb9ef4803, 0x876f7bff,
> > >         0xfffff800, 0x906f8b6f,
> > >         0xb9efa2c3, 0xb9f3f801,
> > > -       0xb96e2a05, 0x806e816e,
> > > +       0xb96e3a05, 0x806e816e,
> > >         0xbf0d9972, 0xbf850002,
> > >         0x8f6e896e, 0xbf820001,
> > >         0x8f6e8a6e, 0xb96f1e06,
> > > @@ -2494,438 +2494,441 @@ static const uint32_t
> > > cwsr_trap_gfx10_hex[]
> > =3D {
> > >         0xbf9f0000, 0xbf9f0000,
> > >         0xbf9f0000, 0x00000000,
> > >  };
> > > -
> > >  static const uint32_t cwsr_trap_gfx11_hex[] =3D {
> > > -       0xbfa00001, 0xbfa0021b,
> > > +       0xbfa00001, 0xbfa0021e,
> > >         0xb0804006, 0xb8f8f802,
> > > -       0x91788678, 0xb8fbf803,
> > > -       0x8b6eff78, 0x00002000,
> > > -       0xbfa10009, 0x8b6eff6d,
> > > -       0x00ff0000, 0xbfa2001e,
> > > -       0x8b6eff7b, 0x00000400,
> > > -       0xbfa20041, 0xbf830010,
> > > -       0xb8fbf803, 0xbfa0fffa,
> > > -       0x8b6eff7b, 0x00000900,
> > > -       0xbfa20015, 0x8b6eff7b,
> > > -       0x000071ff, 0xbfa10008,
> > > -       0x8b6fff7b, 0x00007080,
> > > -       0xbfa10001, 0xbeee1287,
> > > -       0xb8eff801, 0x846e8c6e,
> > > -       0x8b6e6f6e, 0xbfa2000a,
> > > +       0x9178ff78, 0x00020006,
> > > +       0xb8fbf803, 0xbf0d9f6d,
> > > +       0xbfa20006, 0x8b6eff78,
> > > +       0x00002000, 0xbfa10009,
> > >         0x8b6eff6d, 0x00ff0000,
> > > -       0xbfa20007, 0xb8eef801,
> > > -       0x8b6eff6e, 0x00000800,
> > > -       0xbfa20003, 0x8b6eff7b,
> > > -       0x00000400, 0xbfa20026,
> > > -       0xbefa4d82, 0xbf89fc07,
> > > -       0x84fa887a, 0xf4005bbd,
> > > -       0xf8000010, 0xbf89fc07,
> > > -       0x846e976e, 0x9177ff77,
> > > -       0x00800000, 0x8c776e77,
> > > -       0xf4045bbd, 0xf8000000,
> > > -       0xbf89fc07, 0xf4045ebd,
> > > -       0xf8000008, 0xbf89fc07,
> > > -       0x8bee6e6e, 0xbfa10001,
> > > -       0xbe80486e, 0x8b6eff6d,
> > > -       0x01ff0000, 0xbfa20005,
> > > -       0x8c78ff78, 0x00002000,
> > > -       0x80ec886c, 0x82ed806d,
> > > -       0xbfa00005, 0x8b6eff6d,
> > > -       0x01000000, 0xbfa20002,
> > > -       0x806c846c, 0x826d806d,
> > > -       0x8b6dff6d, 0x0000ffff,
> > > -       0x8bfe7e7e, 0x8bea6a6a,
> > > -       0xb978f802, 0xbe804a6c,
> > > -       0x8b6dff6d, 0x0000ffff,
> > > -       0xbefa0080, 0xb97a0283,
> > > -       0xbeee007e, 0xbeef007f,
> > > -       0xbefe0180, 0xbefe4d84,
> > > -       0xbf89fc07, 0x8b7aff7f,
> > > -       0x04000000, 0x847a857a,
> > > -       0x8c6d7a6d, 0xbefa007e,
> > > -       0x8b7bff7f, 0x0000ffff,
> > > -       0xbefe00c1, 0xbeff00c1,
> > > -       0xdca6c000, 0x007a0000,
> > > -       0x7e000280, 0xbefe007a,
> > > -       0xbeff007b, 0xb8fb02dc,
> > > -       0x847b997b, 0xb8fa3b05,
> > > -       0x807a817a, 0xbf0d997b,
> > > -       0xbfa20002, 0x847a897a,
> > > -       0xbfa00001, 0x847a8a7a,
> > > -       0xb8fb1e06, 0x847b8a7b,
> > > -       0x807a7b7a, 0x8b7bff7f,
> > > -       0x0000ffff, 0x807aff7a,
> > > -       0x00000200, 0x807a7e7a,
> > > -       0x827b807b, 0xd7610000,
> > > -       0x00010870, 0xd7610000,
> > > -       0x00010a71, 0xd7610000,
> > > -       0x00010c72, 0xd7610000,
> > > -       0x00010e73, 0xd7610000,
> > > -       0x00011074, 0xd7610000,
> > > -       0x00011275, 0xd7610000,
> > > -       0x00011476, 0xd7610000,
> > > -       0x00011677, 0xd7610000,
> > > -       0x00011a79, 0xd7610000,
> > > -       0x00011c7e, 0xd7610000,
> > > -       0x00011e7f, 0xbefe00ff,
> > > -       0x00003fff, 0xbeff0080,
> > > -       0xdca6c040, 0x007a0000,
> > > -       0xd760007a, 0x00011d00,
> > > -       0xd760007b, 0x00011f00,
> > > +       0xbfa2001e, 0x8b6eff7b,
> > > +       0x00000400, 0xbfa20041,
> > > +       0xbf830010, 0xb8fbf803,
> > > +       0xbfa0fffa, 0x8b6eff7b,
> > > +       0x00000900, 0xbfa20015,
> > > +       0x8b6eff7b, 0x000071ff,
> > > +       0xbfa10008, 0x8b6fff7b,
> > > +       0x00007080, 0xbfa10001,
> > > +       0xbeee1287, 0xb8eff801,
> > > +       0x846e8c6e, 0x8b6e6f6e,
> > > +       0xbfa2000a, 0x8b6eff6d,
> > > +       0x00ff0000, 0xbfa20007,
> > > +       0xb8eef801, 0x8b6eff6e,
> > > +       0x00000800, 0xbfa20003,
> > > +       0x8b6eff7b, 0x00000400,
> > > +       0xbfa20026, 0xbefa4d82,
> > > +       0xbf89fc07, 0x84fa887a,
> > > +       0xf4005bbd, 0xf8000010,
> > > +       0xbf89fc07, 0x846e976e,
> > > +       0x9177ff77, 0x00800000,
> > > +       0x8c776e77, 0xf4045bbd,
> > > +       0xf8000000, 0xbf89fc07,
> > > +       0xf4045ebd, 0xf8000008,
> > > +       0xbf89fc07, 0x8bee6e6e,
> > > +       0xbfa10001, 0xbe80486e,
> > > +       0x8b6eff6d, 0x01ff0000,
> > > +       0xbfa20005, 0x8c78ff78,
> > > +       0x00002000, 0x80ec886c,
> > > +       0x82ed806d, 0xbfa00005,
> > > +       0x8b6eff6d, 0x01000000,
> > > +       0xbfa20002, 0x806c846c,
> > > +       0x826d806d, 0x8b6dff6d,
> > > +       0x0000ffff, 0x8bfe7e7e,
> > > +       0x8bea6a6a, 0xb978f802,
> > > +       0xbe804a6c, 0x8b6dff6d,
> > > +       0x0000ffff, 0xbefa0080,
> > > +       0xb97a0283, 0xbeee007e,
> > > +       0xbeef007f, 0xbefe0180,
> > > +       0xbefe4d84, 0xbf89fc07,
> > > +       0x8b7aff7f, 0x04000000,
> > > +       0x847a857a, 0x8c6d7a6d,
> > > +       0xbefa007e, 0x8b7bff7f,
> > > +       0x0000ffff, 0xbefe00c1,
> > > +       0xbeff00c1, 0xdca6c000,
> > > +       0x007a0000, 0x7e000280,
> > >         0xbefe007a, 0xbeff007b,
> > > -       0xbef4007e, 0x8b75ff7f,
> > > -       0x0000ffff, 0x8c75ff75,
> > > -       0x00040000, 0xbef60080,
> > > -       0xbef700ff, 0x10807fac,
> > > -       0xbef1007d, 0xbef00080,
> > > -       0xb8f302dc, 0x84739973,
> > > -       0xbefe00c1, 0x857d9973,
> > > -       0x8b7d817d, 0xbf06817d,
> > > -       0xbfa20002, 0xbeff0080,
> > > -       0xbfa00002, 0xbeff00c1,
> > > -       0xbfa00009, 0xbef600ff,
> > > -       0x01000000, 0xe0685080,
> > > -       0x701d0100, 0xe0685100,
> > > -       0x701d0200, 0xe0685180,
> > > -       0x701d0300, 0xbfa00008,
> > > +       0xb8fb02dc, 0x847b997b,
> > > +       0xb8fa3b05, 0x807a817a,
> > > +       0xbf0d997b, 0xbfa20002,
> > > +       0x847a897a, 0xbfa00001,
> > > +       0x847a8a7a, 0xb8fb1e06,
> > > +       0x847b8a7b, 0x807a7b7a,
> > > +       0x8b7bff7f, 0x0000ffff,
> > > +       0x807aff7a, 0x00000200,
> > > +       0x807a7e7a, 0x827b807b,
> > > +       0xd7610000, 0x00010870,
> > > +       0xd7610000, 0x00010a71,
> > > +       0xd7610000, 0x00010c72,
> > > +       0xd7610000, 0x00010e73,
> > > +       0xd7610000, 0x00011074,
> > > +       0xd7610000, 0x00011275,
> > > +       0xd7610000, 0x00011476,
> > > +       0xd7610000, 0x00011677,
> > > +       0xd7610000, 0x00011a79,
> > > +       0xd7610000, 0x00011c7e,
> > > +       0xd7610000, 0x00011e7f,
> > > +       0xbefe00ff, 0x00003fff,
> > > +       0xbeff0080, 0xdca6c040,
> > > +       0x007a0000, 0xd760007a,
> > > +       0x00011d00, 0xd760007b,
> > > +       0x00011f00, 0xbefe007a,
> > > +       0xbeff007b, 0xbef4007e,
> > > +       0x8b75ff7f, 0x0000ffff,
> > > +       0x8c75ff75, 0x00040000,
> > > +       0xbef60080, 0xbef700ff,
> > > +       0x10807fac, 0xbef1007d,
> > > +       0xbef00080, 0xb8f302dc,
> > > +       0x84739973, 0xbefe00c1,
> > > +       0x857d9973, 0x8b7d817d,
> > > +       0xbf06817d, 0xbfa20002,
> > > +       0xbeff0080, 0xbfa00002,
> > > +       0xbeff00c1, 0xbfa00009,
> > >         0xbef600ff, 0x01000000,
> > > -       0xe0685100, 0x701d0100,
> > > -       0xe0685200, 0x701d0200,
> > > -       0xe0685300, 0x701d0300,
> > > +       0xe0685080, 0x701d0100,
> > > +       0xe0685100, 0x701d0200,
> > > +       0xe0685180, 0x701d0300,
> > > +       0xbfa00008, 0xbef600ff,
> > > +       0x01000000, 0xe0685100,
> > > +       0x701d0100, 0xe0685200,
> > > +       0x701d0200, 0xe0685300,
> > > +       0x701d0300, 0xb8f03b05,
> > > +       0x80708170, 0xbf0d9973,
> > > +       0xbfa20002, 0x84708970,
> > > +       0xbfa00001, 0x84708a70,
> > > +       0xb8fa1e06, 0x847a8a7a,
> > > +       0x80707a70, 0x8070ff70,
> > > +       0x00000200, 0xbef600ff,
> > > +       0x01000000, 0x7e000280,
> > > +       0x7e020280, 0x7e040280,
> > > +       0xbefd0080, 0xd7610002,
> > > +       0x0000fa71, 0x807d817d,
> > > +       0xd7610002, 0x0000fa6c,
> > > +       0x807d817d, 0x917aff6d,
> > > +       0x80000000, 0xd7610002,
> > > +       0x0000fa7a, 0x807d817d,
> > > +       0xd7610002, 0x0000fa6e,
> > > +       0x807d817d, 0xd7610002,
> > > +       0x0000fa6f, 0x807d817d,
> > > +       0xd7610002, 0x0000fa78,
> > > +       0x807d817d, 0xb8faf803,
> > > +       0xd7610002, 0x0000fa7a,
> > > +       0x807d817d, 0xd7610002,
> > > +       0x0000fa7b, 0x807d817d,
> > > +       0xb8f1f801, 0xd7610002,
> > > +       0x0000fa71, 0x807d817d,
> > > +       0xb8f1f814, 0xd7610002,
> > > +       0x0000fa71, 0x807d817d,
> > > +       0xb8f1f815, 0xd7610002,
> > > +       0x0000fa71, 0x807d817d,
> > > +       0xbefe00ff, 0x0000ffff,
> > > +       0xbeff0080, 0xe0685000,
> > > +       0x701d0200, 0xbefe00c1,
> > >         0xb8f03b05, 0x80708170,
> > >         0xbf0d9973, 0xbfa20002,
> > >         0x84708970, 0xbfa00001,
> > >         0x84708a70, 0xb8fa1e06,
> > >         0x847a8a7a, 0x80707a70,
> > > -       0x8070ff70, 0x00000200,
> > >         0xbef600ff, 0x01000000,
> > > -       0x7e000280, 0x7e020280,
> > > -       0x7e040280, 0xbefd0080,
> > > -       0xd7610002, 0x0000fa71,
> > > -       0x807d817d, 0xd7610002,
> > > -       0x0000fa6c, 0x807d817d,
> > > -       0x917aff6d, 0x80000000,
> > > -       0xd7610002, 0x0000fa7a,
> > > -       0x807d817d, 0xd7610002,
> > > -       0x0000fa6e, 0x807d817d,
> > > -       0xd7610002, 0x0000fa6f,
> > > -       0x807d817d, 0xd7610002,
> > > -       0x0000fa78, 0x807d817d,
> > > -       0xb8faf803, 0xd7610002,
> > > -       0x0000fa7a, 0x807d817d,
> > > -       0xd7610002, 0x0000fa7b,
> > > -       0x807d817d, 0xb8f1f801,
> > > -       0xd7610002, 0x0000fa71,
> > > -       0x807d817d, 0xb8f1f814,
> > > -       0xd7610002, 0x0000fa71,
> > > -       0x807d817d, 0xb8f1f815,
> > > -       0xd7610002, 0x0000fa71,
> > > -       0x807d817d, 0xbefe00ff,
> > > -       0x0000ffff, 0xbeff0080,
> > > -       0xe0685000, 0x701d0200,
> > > -       0xbefe00c1, 0xb8f03b05,
> > > -       0x80708170, 0xbf0d9973,
> > > -       0xbfa20002, 0x84708970,
> > > -       0xbfa00001, 0x84708a70,
> > > -       0xb8fa1e06, 0x847a8a7a,
> > > -       0x80707a70, 0xbef600ff,
> > > -       0x01000000, 0xbef90080,
> > > -       0xbefd0080, 0xbf800000,
> > > -       0xbe804100, 0xbe824102,
> > > -       0xbe844104, 0xbe864106,
> > > -       0xbe884108, 0xbe8a410a,
> > > -       0xbe8c410c, 0xbe8e410e,
> > > -       0xd7610002, 0x0000f200,
> > > -       0x80798179, 0xd7610002,
> > > -       0x0000f201, 0x80798179,
> > > -       0xd7610002, 0x0000f202,
> > > -       0x80798179, 0xd7610002,
> > > -       0x0000f203, 0x80798179,
> > > -       0xd7610002, 0x0000f204,
> > > +       0xbef90080, 0xbefd0080,
> > > +       0xbf800000, 0xbe804100,
> > > +       0xbe824102, 0xbe844104,
> > > +       0xbe864106, 0xbe884108,
> > > +       0xbe8a410a, 0xbe8c410c,
> > > +       0xbe8e410e, 0xd7610002,
> > > +       0x0000f200, 0x80798179,
> > > +       0xd7610002, 0x0000f201,
> > >         0x80798179, 0xd7610002,
> > > -       0x0000f205, 0x80798179,
> > > -       0xd7610002, 0x0000f206,
> > > +       0x0000f202, 0x80798179,
> > > +       0xd7610002, 0x0000f203,
> > >         0x80798179, 0xd7610002,
> > > -       0x0000f207, 0x80798179,
> > > -       0xd7610002, 0x0000f208,
> > > +       0x0000f204, 0x80798179,
> > > +       0xd7610002, 0x0000f205,
> > >         0x80798179, 0xd7610002,
> > > -       0x0000f209, 0x80798179,
> > > -       0xd7610002, 0x0000f20a,
> > > +       0x0000f206, 0x80798179,
> > > +       0xd7610002, 0x0000f207,
> > >         0x80798179, 0xd7610002,
> > > -       0x0000f20b, 0x80798179,
> > > -       0xd7610002, 0x0000f20c,
> > > +       0x0000f208, 0x80798179,
> > > +       0xd7610002, 0x0000f209,
> > >         0x80798179, 0xd7610002,
> > > -       0x0000f20d, 0x80798179,
> > > -       0xd7610002, 0x0000f20e,
> > > +       0x0000f20a, 0x80798179,
> > > +       0xd7610002, 0x0000f20b,
> > >         0x80798179, 0xd7610002,
> > > -       0x0000f20f, 0x80798179,
> > > -       0xbf06a079, 0xbfa10006,
> > > -       0xe0685000, 0x701d0200,
> > > -       0x8070ff70, 0x00000080,
> > > -       0xbef90080, 0x7e040280,
> > > -       0x807d907d, 0xbf0aff7d,
> > > -       0x00000060, 0xbfa2ffbc,
> > > -       0xbe804100, 0xbe824102,
> > > -       0xbe844104, 0xbe864106,
> > > -       0xbe884108, 0xbe8a410a,
> > > -       0xd7610002, 0x0000f200,
> > > +       0x0000f20c, 0x80798179,
> > > +       0xd7610002, 0x0000f20d,
> > >         0x80798179, 0xd7610002,
> > > -       0x0000f201, 0x80798179,
> > > -       0xd7610002, 0x0000f202,
> > > +       0x0000f20e, 0x80798179,
> > > +       0xd7610002, 0x0000f20f,
> > > +       0x80798179, 0xbf06a079,
> > > +       0xbfa10006, 0xe0685000,
> > > +       0x701d0200, 0x8070ff70,
> > > +       0x00000080, 0xbef90080,
> > > +       0x7e040280, 0x807d907d,
> > > +       0xbf0aff7d, 0x00000060,
> > > +       0xbfa2ffbc, 0xbe804100,
> > > +       0xbe824102, 0xbe844104,
> > > +       0xbe864106, 0xbe884108,
> > > +       0xbe8a410a, 0xd7610002,
> > > +       0x0000f200, 0x80798179,
> > > +       0xd7610002, 0x0000f201,
> > >         0x80798179, 0xd7610002,
> > > -       0x0000f203, 0x80798179,
> > > -       0xd7610002, 0x0000f204,
> > > +       0x0000f202, 0x80798179,
> > > +       0xd7610002, 0x0000f203,
> > >         0x80798179, 0xd7610002,
> > > -       0x0000f205, 0x80798179,
> > > -       0xd7610002, 0x0000f206,
> > > +       0x0000f204, 0x80798179,
> > > +       0xd7610002, 0x0000f205,
> > >         0x80798179, 0xd7610002,
> > > -       0x0000f207, 0x80798179,
> > > -       0xd7610002, 0x0000f208,
> > > +       0x0000f206, 0x80798179,
> > > +       0xd7610002, 0x0000f207,
> > >         0x80798179, 0xd7610002,
> > > -       0x0000f209, 0x80798179,
> > > -       0xd7610002, 0x0000f20a,
> > > +       0x0000f208, 0x80798179,
> > > +       0xd7610002, 0x0000f209,
> > >         0x80798179, 0xd7610002,
> > > -       0x0000f20b, 0x80798179,
> > > -       0xe0685000, 0x701d0200,
> > > +       0x0000f20a, 0x80798179,
> > > +       0xd7610002, 0x0000f20b,
> > > +       0x80798179, 0xe0685000,
> > > +       0x701d0200, 0xbefe00c1,
> > > +       0x857d9973, 0x8b7d817d,
> > > +       0xbf06817d, 0xbfa20002,
> > > +       0xbeff0080, 0xbfa00001,
> > > +       0xbeff00c1, 0xb8fb4306,
> > > +       0x8b7bc17b, 0xbfa10044,
> > > +       0xbfbd0000, 0x8b7aff6d,
> > > +       0x80000000, 0xbfa10040,
> > > +       0x847b867b, 0x847b827b,
> > > +       0xbef6007b, 0xb8f03b05,
> > > +       0x80708170, 0xbf0d9973,
> > > +       0xbfa20002, 0x84708970,
> > > +       0xbfa00001, 0x84708a70,
> > > +       0xb8fa1e06, 0x847a8a7a,
> > > +       0x80707a70, 0x8070ff70,
> > > +       0x00000200, 0x8070ff70,
> > > +       0x00000080, 0xbef600ff,
> > > +       0x01000000, 0xd71f0000,
> > > +       0x000100c1, 0xd7200000,
> > > +       0x000200c1, 0x16000084,
> > > +       0x857d9973, 0x8b7d817d,
> > > +       0xbf06817d, 0xbefd0080,
> > > +       0xbfa20012, 0xbe8300ff,
> > > +       0x00000080, 0xbf800000,
> > > +       0xbf800000, 0xbf800000,
> > > +       0xd8d80000, 0x01000000,
> > > +       0xbf890000, 0xe0685000,
> > > +       0x701d0100, 0x807d037d,
> > > +       0x80700370, 0xd5250000,
> > > +       0x0001ff00, 0x00000080,
> > > +       0xbf0a7b7d, 0xbfa2fff4,
> > > +       0xbfa00011, 0xbe8300ff,
> > > +       0x00000100, 0xbf800000,
> > > +       0xbf800000, 0xbf800000,
> > > +       0xd8d80000, 0x01000000,
> > > +       0xbf890000, 0xe0685000,
> > > +       0x701d0100, 0x807d037d,
> > > +       0x80700370, 0xd5250000,
> > > +       0x0001ff00, 0x00000100,
> > > +       0xbf0a7b7d, 0xbfa2fff4,
> > >         0xbefe00c1, 0x857d9973,
> > >         0x8b7d817d, 0xbf06817d,
> > > -       0xbfa20002, 0xbeff0080,
> > > -       0xbfa00001, 0xbeff00c1,
> > > -       0xb8fb4306, 0x8b7bc17b,
> > > -       0xbfa10044, 0xbfbd0000,
> > > -       0x8b7aff6d, 0x80000000,
> > > -       0xbfa10040, 0x847b867b,
> > > -       0x847b827b, 0xbef6007b,
> > > -       0xb8f03b05, 0x80708170,
> > > -       0xbf0d9973, 0xbfa20002,
> > > -       0x84708970, 0xbfa00001,
> > > -       0x84708a70, 0xb8fa1e06,
> > > -       0x847a8a7a, 0x80707a70,
> > > -       0x8070ff70, 0x00000200,
> > > -       0x8070ff70, 0x00000080,
> > > -       0xbef600ff, 0x01000000,
> > > -       0xd71f0000, 0x000100c1,
> > > -       0xd7200000, 0x000200c1,
> > > -       0x16000084, 0x857d9973,
> > > +       0xbfa20004, 0xbef000ff,
> > > +       0x00000200, 0xbeff0080,
> > > +       0xbfa00003, 0xbef000ff,
> > > +       0x00000400, 0xbeff00c1,
> > > +       0xb8fb3b05, 0x807b817b,
> > > +       0x847b827b, 0x857d9973,
> > >         0x8b7d817d, 0xbf06817d,
> > > -       0xbefd0080, 0xbfa20012,
> > > -       0xbe8300ff, 0x00000080,
> > > -       0xbf800000, 0xbf800000,
> > > -       0xbf800000, 0xd8d80000,
> > > -       0x01000000, 0xbf890000,
> > > -       0xe0685000, 0x701d0100,
> > > -       0x807d037d, 0x80700370,
> > > -       0xd5250000, 0x0001ff00,
> > > -       0x00000080, 0xbf0a7b7d,
> > > -       0xbfa2fff4, 0xbfa00011,
> > > -       0xbe8300ff, 0x00000100,
> > > -       0xbf800000, 0xbf800000,
> > > -       0xbf800000, 0xd8d80000,
> > > -       0x01000000, 0xbf890000,
> > > -       0xe0685000, 0x701d0100,
> > > -       0x807d037d, 0x80700370,
> > > -       0xd5250000, 0x0001ff00,
> > > -       0x00000100, 0xbf0a7b7d,
> > > -       0xbfa2fff4, 0xbefe00c1,
> > > -       0x857d9973, 0x8b7d817d,
> > > -       0xbf06817d, 0xbfa20004,
> > > -       0xbef000ff, 0x00000200,
> > > -       0xbeff0080, 0xbfa00003,
> > > -       0xbef000ff, 0x00000400,
> > > -       0xbeff00c1, 0xb8fb3b05,
> > > -       0x807b817b, 0x847b827b,
> > > -       0x857d9973, 0x8b7d817d,
> > > -       0xbf06817d, 0xbfa20017,
> > > +       0xbfa20017, 0xbef600ff,
> > > +       0x01000000, 0xbefd0084,
> > > +       0xbf0a7b7d, 0xbfa10037,
> > > +       0x7e008700, 0x7e028701,
> > > +       0x7e048702, 0x7e068703,
> > > +       0xe0685000, 0x701d0000,
> > > +       0xe0685080, 0x701d0100,
> > > +       0xe0685100, 0x701d0200,
> > > +       0xe0685180, 0x701d0300,
> > > +       0x807d847d, 0x8070ff70,
> > > +       0x00000200, 0xbf0a7b7d,
> > > +       0xbfa2ffef, 0xbfa00025,
> > >         0xbef600ff, 0x01000000,
> > >         0xbefd0084, 0xbf0a7b7d,
> > > -       0xbfa10037, 0x7e008700,
> > > +       0xbfa10011, 0x7e008700,
> > >         0x7e028701, 0x7e048702,
> > >         0x7e068703, 0xe0685000,
> > > -       0x701d0000, 0xe0685080,
> > > -       0x701d0100, 0xe0685100,
> > > -       0x701d0200, 0xe0685180,
> > > +       0x701d0000, 0xe0685100,
> > > +       0x701d0100, 0xe0685200,
> > > +       0x701d0200, 0xe0685300,
> > >         0x701d0300, 0x807d847d,
> > > -       0x8070ff70, 0x00000200,
> > > +       0x8070ff70, 0x00000400,
> > >         0xbf0a7b7d, 0xbfa2ffef,
> > > -       0xbfa00025, 0xbef600ff,
> > > -       0x01000000, 0xbefd0084,
> > > -       0xbf0a7b7d, 0xbfa10011,
> > > -       0x7e008700, 0x7e028701,
> > > -       0x7e048702, 0x7e068703,
> > > +       0xb8fb1e06, 0x8b7bc17b,
> > > +       0xbfa1000c, 0x847b837b,
> > > +       0x807b7d7b, 0xbefe00c1,
> > > +       0xbeff0080, 0x7e008700,
> > >         0xe0685000, 0x701d0000,
> > > -       0xe0685100, 0x701d0100,
> > > -       0xe0685200, 0x701d0200,
> > > -       0xe0685300, 0x701d0300,
> > > -       0x807d847d, 0x8070ff70,
> > > -       0x00000400, 0xbf0a7b7d,
> > > -       0xbfa2ffef, 0xb8fb1e06,
> > > -       0x8b7bc17b, 0xbfa1000c,
> > > -       0x847b837b, 0x807b7d7b,
> > > -       0xbefe00c1, 0xbeff0080,
> > > -       0x7e008700, 0xe0685000,
> > > -       0x701d0000, 0x807d817d,
> > > -       0x8070ff70, 0x00000080,
> > > -       0xbf0a7b7d, 0xbfa2fff8,
> > > -       0xbfa00141, 0xbef4007e,
> > > -       0x8b75ff7f, 0x0000ffff,
> > > -       0x8c75ff75, 0x00040000,
> > > -       0xbef60080, 0xbef700ff,
> > > -       0x10807fac, 0xb8f202dc,
> > > -       0x84729972, 0x8b6eff7f,
> > > -       0x04000000, 0xbfa1003a,
> > > +       0x807d817d, 0x8070ff70,
> > > +       0x00000080, 0xbf0a7b7d,
> > > +       0xbfa2fff8, 0xbfa00146,
> > > +       0xbef4007e, 0x8b75ff7f,
> > > +       0x0000ffff, 0x8c75ff75,
> > > +       0x00040000, 0xbef60080,
> > > +       0xbef700ff, 0x10807fac,
> > > +       0xb8f202dc, 0x84729972,
> > > +       0x8b6eff7f, 0x04000000,
> > > +       0xbfa1003a, 0xbefe00c1,
> > > +       0x857d9972, 0x8b7d817d,
> > > +       0xbf06817d, 0xbfa20002,
> > > +       0xbeff0080, 0xbfa00001,
> > > +       0xbeff00c1, 0xb8ef4306,
> > > +       0x8b6fc16f, 0xbfa1002f,
> > > +       0x846f866f, 0x846f826f,
> > > +       0xbef6006f, 0xb8f83b05,
> > > +       0x80788178, 0xbf0d9972,
> > > +       0xbfa20002, 0x84788978,
> > > +       0xbfa00001, 0x84788a78,
> > > +       0xb8ee1e06, 0x846e8a6e,
> > > +       0x80786e78, 0x8078ff78,
> > > +       0x00000200, 0x8078ff78,
> > > +       0x00000080, 0xbef600ff,
> > > +       0x01000000, 0x857d9972,
> > > +       0x8b7d817d, 0xbf06817d,
> > > +       0xbefd0080, 0xbfa2000c,
> > > +       0xe0500000, 0x781d0000,
> > > +       0xbf8903f7, 0xdac00000,
> > > +       0x00000000, 0x807dff7d,
> > > +       0x00000080, 0x8078ff78,
> > > +       0x00000080, 0xbf0a6f7d,
> > > +       0xbfa2fff5, 0xbfa0000b,
> > > +       0xe0500000, 0x781d0000,
> > > +       0xbf8903f7, 0xdac00000,
> > > +       0x00000000, 0x807dff7d,
> > > +       0x00000100, 0x8078ff78,
> > > +       0x00000100, 0xbf0a6f7d,
> > > +       0xbfa2fff5, 0xbef80080,
> > >         0xbefe00c1, 0x857d9972,
> > >         0x8b7d817d, 0xbf06817d,
> > >         0xbfa20002, 0xbeff0080,
> > >         0xbfa00001, 0xbeff00c1,
> > > -       0xb8ef4306, 0x8b6fc16f,
> > > -       0xbfa1002f, 0x846f866f,
> > > -       0x846f826f, 0xbef6006f,
> > > -       0xb8f83b05, 0x80788178,
> > > -       0xbf0d9972, 0xbfa20002,
> > > -       0x84788978, 0xbfa00001,
> > > -       0x84788a78, 0xb8ee1e06,
> > > -       0x846e8a6e, 0x80786e78,
> > > +       0xb8ef3b05, 0x806f816f,
> > > +       0x846f826f, 0x857d9972,
> > > +       0x8b7d817d, 0xbf06817d,
> > > +       0xbfa20024, 0xbef600ff,
> > > +       0x01000000, 0xbeee0078,
> > >         0x8078ff78, 0x00000200,
> > > -       0x8078ff78, 0x00000080,
> > > -       0xbef600ff, 0x01000000,
> > > -       0x857d9972, 0x8b7d817d,
> > > -       0xbf06817d, 0xbefd0080,
> > > -       0xbfa2000c, 0xe0500000,
> > > -       0x781d0000, 0xbf8903f7,
> > > -       0xdac00000, 0x00000000,
> > > -       0x807dff7d, 0x00000080,
> > > -       0x8078ff78, 0x00000080,
> > > -       0xbf0a6f7d, 0xbfa2fff5,
> > > -       0xbfa0000b, 0xe0500000,
> > > -       0x781d0000, 0xbf8903f7,
> > > -       0xdac00000, 0x00000000,
> > > -       0x807dff7d, 0x00000100,
> > > -       0x8078ff78, 0x00000100,
> > > -       0xbf0a6f7d, 0xbfa2fff5,
> > > -       0xbef80080, 0xbefe00c1,
> > > -       0x857d9972, 0x8b7d817d,
> > > -       0xbf06817d, 0xbfa20002,
> > > -       0xbeff0080, 0xbfa00001,
> > > -       0xbeff00c1, 0xb8ef3b05,
> > > -       0x806f816f, 0x846f826f,
> > > -       0x857d9972, 0x8b7d817d,
> > > -       0xbf06817d, 0xbfa20024,
> > > -       0xbef600ff, 0x01000000,
> > > -       0xbeee0078, 0x8078ff78,
> > > -       0x00000200, 0xbefd0084,
> > > -       0xbf0a6f7d, 0xbfa10050,
> > > +       0xbefd0084, 0xbf0a6f7d,
> > > +       0xbfa10050, 0xe0505000,
> > > +       0x781d0000, 0xe0505080,
> > > +       0x781d0100, 0xe0505100,
> > > +       0x781d0200, 0xe0505180,
> > > +       0x781d0300, 0xbf8903f7,
> > > +       0x7e008500, 0x7e028501,
> > > +       0x7e048502, 0x7e068503,
> > > +       0x807d847d, 0x8078ff78,
> > > +       0x00000200, 0xbf0a6f7d,
> > > +       0xbfa2ffee, 0xe0505000,
> > > +       0x6e1d0000, 0xe0505080,
> > > +       0x6e1d0100, 0xe0505100,
> > > +       0x6e1d0200, 0xe0505180,
> > > +       0x6e1d0300, 0xbf8903f7,
> > > +       0xbfa00034, 0xbef600ff,
> > > +       0x01000000, 0xbeee0078,
> > > +       0x8078ff78, 0x00000400,
> > > +       0xbefd0084, 0xbf0a6f7d,
> > > +       0xbfa10012, 0xe0505000,
> > > +       0x781d0000, 0xe0505100,
> > > +       0x781d0100, 0xe0505200,
> > > +       0x781d0200, 0xe0505300,
> > > +       0x781d0300, 0xbf8903f7,
> > > +       0x7e008500, 0x7e028501,
> > > +       0x7e048502, 0x7e068503,
> > > +       0x807d847d, 0x8078ff78,
> > > +       0x00000400, 0xbf0a6f7d,
> > > +       0xbfa2ffee, 0xb8ef1e06,
> > > +       0x8b6fc16f, 0xbfa1000e,
> > > +       0x846f836f, 0x806f7d6f,
> > > +       0xbefe00c1, 0xbeff0080,
> > >         0xe0505000, 0x781d0000,
> > > -       0xe0505080, 0x781d0100,
> > > -       0xe0505100, 0x781d0200,
> > > -       0xe0505180, 0x781d0300,
> > >         0xbf8903f7, 0x7e008500,
> > > -       0x7e028501, 0x7e048502,
> > > -       0x7e068503, 0x807d847d,
> > > -       0x8078ff78, 0x00000200,
> > > -       0xbf0a6f7d, 0xbfa2ffee,
> > > +       0x807d817d, 0x8078ff78,
> > > +       0x00000080, 0xbf0a6f7d,
> > > +       0xbfa2fff7, 0xbeff00c1,
> > >         0xe0505000, 0x6e1d0000,
> > > -       0xe0505080, 0x6e1d0100,
> > > -       0xe0505100, 0x6e1d0200,
> > > -       0xe0505180, 0x6e1d0300,
> > > -       0xbf8903f7, 0xbfa00034,
> > > -       0xbef600ff, 0x01000000,
> > > -       0xbeee0078, 0x8078ff78,
> > > -       0x00000400, 0xbefd0084,
> > > -       0xbf0a6f7d, 0xbfa10012,
> > > -       0xe0505000, 0x781d0000,
> > > -       0xe0505100, 0x781d0100,
> > > -       0xe0505200, 0x781d0200,
> > > -       0xe0505300, 0x781d0300,
> > > -       0xbf8903f7, 0x7e008500,
> > > -       0x7e028501, 0x7e048502,
> > > -       0x7e068503, 0x807d847d,
> > > -       0x8078ff78, 0x00000400,
> > > -       0xbf0a6f7d, 0xbfa2ffee,
> > > -       0xb8ef1e06, 0x8b6fc16f,
> > > -       0xbfa1000e, 0x846f836f,
> > > -       0x806f7d6f, 0xbefe00c1,
> > > -       0xbeff0080, 0xe0505000,
> > > -       0x781d0000, 0xbf8903f7,
> > > -       0x7e008500, 0x807d817d,
> > > -       0x8078ff78, 0x00000080,
> > > -       0xbf0a6f7d, 0xbfa2fff7,
> > > -       0xbeff00c1, 0xe0505000,
> > > -       0x6e1d0000, 0xe0505100,
> > > -       0x6e1d0100, 0xe0505200,
> > > -       0x6e1d0200, 0xe0505300,
> > > -       0x6e1d0300, 0xbf8903f7,
> > > +       0xe0505100, 0x6e1d0100,
> > > +       0xe0505200, 0x6e1d0200,
> > > +       0xe0505300, 0x6e1d0300,
> > > +       0xbf8903f7, 0xb8f83b05,
> > > +       0x80788178, 0xbf0d9972,
> > > +       0xbfa20002, 0x84788978,
> > > +       0xbfa00001, 0x84788a78,
> > > +       0xb8ee1e06, 0x846e8a6e,
> > > +       0x80786e78, 0x8078ff78,
> > > +       0x00000200, 0x80f8ff78,
> > > +       0x00000050, 0xbef600ff,
> > > +       0x01000000, 0xbefd00ff,
> > > +       0x0000006c, 0x80f89078,
> > > +       0xf428403a, 0xf0000000,
> > > +       0xbf89fc07, 0x80fd847d,
> > > +       0xbf800000, 0xbe804300,
> > > +       0xbe824302, 0x80f8a078,
> > > +       0xf42c403a, 0xf0000000,
> > > +       0xbf89fc07, 0x80fd887d,
> > > +       0xbf800000, 0xbe804300,
> > > +       0xbe824302, 0xbe844304,
> > > +       0xbe864306, 0x80f8c078,
> > > +       0xf430403a, 0xf0000000,
> > > +       0xbf89fc07, 0x80fd907d,
> > > +       0xbf800000, 0xbe804300,
> > > +       0xbe824302, 0xbe844304,
> > > +       0xbe864306, 0xbe884308,
> > > +       0xbe8a430a, 0xbe8c430c,
> > > +       0xbe8e430e, 0xbf06807d,
> > > +       0xbfa1fff0, 0xb980f801,
> > > +       0x00000000, 0xbfbd0000,
> > >         0xb8f83b05, 0x80788178,
> > >         0xbf0d9972, 0xbfa20002,
> > >         0x84788978, 0xbfa00001,
> > >         0x84788a78, 0xb8ee1e06,
> > >         0x846e8a6e, 0x80786e78,
> > >         0x8078ff78, 0x00000200,
> > > -       0x80f8ff78, 0x00000050,
> > >         0xbef600ff, 0x01000000,
> > > -       0xbefd00ff, 0x0000006c,
> > > -       0x80f89078, 0xf428403a,
> > > -       0xf0000000, 0xbf89fc07,
> > > -       0x80fd847d, 0xbf800000,
> > > -       0xbe804300, 0xbe824302,
> > > -       0x80f8a078, 0xf42c403a,
> > > -       0xf0000000, 0xbf89fc07,
> > > -       0x80fd887d, 0xbf800000,
> > > -       0xbe804300, 0xbe824302,
> > > -       0xbe844304, 0xbe864306,
> > > -       0x80f8c078, 0xf430403a,
> > > -       0xf0000000, 0xbf89fc07,
> > > -       0x80fd907d, 0xbf800000,
> > > -       0xbe804300, 0xbe824302,
> > > -       0xbe844304, 0xbe864306,
> > > -       0xbe884308, 0xbe8a430a,
> > > -       0xbe8c430c, 0xbe8e430e,
> > > -       0xbf06807d, 0xbfa1fff0,
> > > -       0xb980f801, 0x00000000,
> > > -       0xbfbd0000, 0xb8f83b05,
> > > -       0x80788178, 0xbf0d9972,
> > > -       0xbfa20002, 0x84788978,
> > > -       0xbfa00001, 0x84788a78,
> > > -       0xb8ee1e06, 0x846e8a6e,
> > > -       0x80786e78, 0x8078ff78,
> > > -       0x00000200, 0xbef600ff,
> > > -       0x01000000, 0xf4205bfa,
> > > +       0xf4205bfa, 0xf0000000,
> > > +       0x80788478, 0xf4205b3a,
> > >         0xf0000000, 0x80788478,
> > > -       0xf4205b3a, 0xf0000000,
> > > -       0x80788478, 0xf4205b7a,
> > > +       0xf4205b7a, 0xf0000000,
> > > +       0x80788478, 0xf4205c3a,
> > >         0xf0000000, 0x80788478,
> > > -       0xf4205c3a, 0xf0000000,
> > > -       0x80788478, 0xf4205c7a,
> > > +       0xf4205c7a, 0xf0000000,
> > > +       0x80788478, 0xf4205eba,
> > >         0xf0000000, 0x80788478,
> > > -       0xf4205eba, 0xf0000000,
> > > -       0x80788478, 0xf4205efa,
> > > +       0xf4205efa, 0xf0000000,
> > > +       0x80788478, 0xf4205e7a,
> > >         0xf0000000, 0x80788478,
> > > -       0xf4205e7a, 0xf0000000,
> > > -       0x80788478, 0xf4205cfa,
> > > +       0xf4205cfa, 0xf0000000,
> > > +       0x80788478, 0xf4205bba,
> > >         0xf0000000, 0x80788478,
> > > +       0xbf89fc07, 0xb96ef814,
> > >         0xf4205bba, 0xf0000000,
> > >         0x80788478, 0xbf89fc07,
> > > -       0xb96ef814, 0xf4205bba,
> > > -       0xf0000000, 0x80788478,
> > > -       0xbf89fc07, 0xb96ef815,
> > > -       0xbefd006f, 0xbefe0070,
> > > -       0xbeff0071, 0x8b6f7bff,
> > > -       0x000003ff, 0xb96f4803,
> > > -       0x8b6f7bff, 0xfffff800,
> > > -       0x856f8b6f, 0xb96fa2c3,
> > > -       0xb973f801, 0xb8ee3b05,
> > > -       0x806e816e, 0xbf0d9972,
> > > -       0xbfa20002, 0x846e896e,
> > > -       0xbfa00001, 0x846e8a6e,
> > > -       0xb8ef1e06, 0x846f8a6f,
> > > -       0x806e6f6e, 0x806eff6e,
> > > -       0x00000200, 0x806e746e,
> > > -       0x826f8075, 0x8b6fff6f,
> > > -       0x0000ffff, 0xf4085c37,
> > > -       0xf8000050, 0xf4085d37,
> > > -       0xf8000060, 0xf4005e77,
> > > -       0xf8000074, 0xbf89fc07,
> > > -       0x8b6dff6d, 0x0000ffff,
> > > -       0x8bfe7e7e, 0x8bea6a6a,
> > > +       0xb96ef815, 0xbefd006f,
> > > +       0xbefe0070, 0xbeff0071,
> > > +       0x8b6f7bff, 0x000003ff,
> > > +       0xb96f4803, 0x8b6f7bff,
> > > +       0xfffff800, 0x856f8b6f,
> > > +       0xb96fa2c3, 0xb973f801,
> > > +       0xb8ee3b05, 0x806e816e,
> > > +       0xbf0d9972, 0xbfa20002,
> > > +       0x846e896e, 0xbfa00001,
> > > +       0x846e8a6e, 0xb8ef1e06,
> > > +       0x846f8a6f, 0x806e6f6e,
> > > +       0x806eff6e, 0x00000200,
> > > +       0x806e746e, 0x826f8075,
> > > +       0x8b6fff6f, 0x0000ffff,
> > > +       0xf4085c37, 0xf8000050,
> > > +       0xf4085d37, 0xf8000060,
> > > +       0xf4005e77, 0xf8000074,
> > > +       0xbf89fc07, 0x8b6dff6d,
> > > +       0x0000ffff, 0x8bfe7e7e,
> > > +       0x8bea6a6a, 0xb8eef802,
> > > +       0xbf0d866e, 0xbfa20002,
> > > +       0xb97af802, 0xbe80486c,
> > >         0xb97af802, 0xbe804a6c,
> > >         0xbfb00000, 0xbf9f0000,
> > >         0xbf9f0000, 0xbf9f0000,
> > > diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> > > b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> > > index 250ab007399b..0f81670f6f9c 100644
> > > --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> > > +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> > > @@ -43,12 +43,14 @@
> > >  #define HAVE_XNACK (ASIC_FAMILY < CHIP_SIENNA_CICHLID)  #define
> > > HAVE_SENDMSG_RTN (ASIC_FAMILY >=3D CHIP_PLUM_BONITO)  #define
> > > HAVE_BUFFER_LDS_LOAD (ASIC_FAMILY < CHIP_PLUM_BONITO)
> > > +#define SW_SA_TRAP (ASIC_FAMILY >=3D CHIP_PLUM_BONITO)
> > >
> > >  var SINGLE_STEP_MISSED_WORKAROUND              =3D 1     //workaroun=
d for
> > > lost MODE.DEBUG_EN exception when SAVECTX raised
> > >
> > >  var SQ_WAVE_STATUS_SPI_PRIO_MASK               =3D 0x00000006
> > >  var SQ_WAVE_STATUS_HALT_MASK                   =3D 0x2000
> > >  var SQ_WAVE_STATUS_ECC_ERR_MASK                        =3D 0x20000
> > > +var SQ_WAVE_STATUS_TRAP_EN_SHIFT               =3D 6
> > >
> > >  var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SHIFT           =3D 12
> > >  var SQ_WAVE_LDS_ALLOC_LDS_SIZE_SIZE            =3D 9
> > > @@ -183,6 +185,13 @@ L_SKIP_RESTORE:
> > >
> > >         s_getreg_b32    s_save_trapsts, hwreg(HW_REG_TRAPSTS)
> > >
> > > +#if SW_SA_TRAP
> > > +       // If ttmp1[31] is set then trap may occur early.
> > > +       // Spin wait until SAVECTX exception is raised.
> > > +       s_bitcmp1_b32   s_save_pc_hi, 31
> > > +       s_cbranch_scc1  L_CHECK_SAVE #endif
> > > +
> > >         s_and_b32       ttmp2, s_save_status,
> SQ_WAVE_STATUS_HALT_MASK
> > >         s_cbranch_scc0  L_NOT_HALTED
> > >
> > > @@ -1061,8 +1070,20 @@ L_RESTORE_HWREG:
> > >         s_and_b32       s_restore_pc_hi, s_restore_pc_hi, 0x0000ffff
> > > //pc[47:32] //Do it here in order not to affect STATUS
> > >         s_and_b64       exec, exec, exec                             =
           // Restore
> > > STATUS.EXECZ, not writable by s_setreg_b32
> > >         s_and_b64       vcc, vcc, vcc                                =
           // Restore
> > STATUS.VCCZ,
> > > not writable by s_setreg_b32
> > > +
> > > +#if SW_SA_TRAP
> > > +       // If traps are enabled then return to the shader with PRIV=
=3D0.
> > > +       // Otherwise retain PRIV=3D1 for subsequent context save requ=
ests.
> > > +       s_getreg_b32    s_restore_tmp, hwreg(HW_REG_STATUS)
> > > +       s_bitcmp1_b32   s_restore_tmp,
> SQ_WAVE_STATUS_TRAP_EN_SHIFT
> > > +       s_cbranch_scc1  L_RETURN_WITHOUT_PRIV
> > > +
> > >         s_setreg_b32    hwreg(HW_REG_STATUS), s_restore_status
> //
> > > SCC is included, which is changed by previous salu
> > > +       s_setpc_b64     [s_restore_pc_lo, s_restore_pc_hi]
> > > +L_RETURN_WITHOUT_PRIV:
> > > +#endif
> > >
> > > +       s_setreg_b32    hwreg(HW_REG_STATUS), s_restore_status
> > //
> > > SCC is included, which is changed by previous salu
> > >         s_rfe_b64       s_restore_pc_lo                              =
           //Return to the
> > main
> > > shader program and resume execution
> > >
> > >  L_END_PGM:
> > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> > > b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> > > index a6fcbeeb7428..4e03d19e9333 100644
> > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
> > > @@ -358,13 +358,35 @@ static void event_interrupt_wq_v11(struct
> > > kfd_dev *dev,
> > >                                 break;
> > >                         case SQ_INTERRUPT_WORD_ENCODING_ERROR:
> > >
> > > print_sq_intr_info_error(context_id0,
> > > context_id1);
> > > +                               sq_int_priv =3D
> > > + REG_GET_FIELD(context_id0,
> > > +
> > > + SQ_INTERRUPT_WORD_WAVE_CTXID0, PRIV);
> > >                                 sq_int_errtype =3D REG_GET_FIELD(cont=
ext_id0,
> > >                                                 SQ_INTERRUPT_WORD_ERR=
OR_CTXID0, TYPE);
> > > -                               if (sq_int_errtype !=3D
> > > SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
> > > -                                   sq_int_errtype !=3D
> > > SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
> > > +
> > > +                               switch (sq_int_errtype) {
> > > +                               case SQ_INTERRUPT_ERROR_TYPE_EDC_FUE:
> > > +                               case SQ_INTERRUPT_ERROR_TYPE_EDC_FED:
> > >                                         event_interrupt_poison_consum=
ption_v11(
> > >                                                         dev, pasid, s=
ource_id);
> > >                                         return;
> > > +                               case SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_=
INST:
> > > +                                       /*if
> > > + (!(((adev->mes.sched_version &
> > > AMDGPU_MES_VERSION_MASK) >=3D 4) &&
> > > +
> > > + (adev->ip_versions[GC_HWIP][0] >=3D
> > > IP_VERSION(11, 0, 0)) &&
> > > +
> > > + (adev->ip_versions[GC_HWIP][0] <=3D
> > > IP_VERSION(11, 0, 3)))
> > > +                                               && sq_int_priv)
> > > +
> > > + kfd_set_dbg_ev_from_interrupt(dev, pasid, -1,
> > > +
> > > KFD_EC_MASK(EC_QUEUE_WAVE_ILLEGAL_INSTRUCTION),
> > > +                                                       NULL, 0);*/
> > > +                                       return;
> > > +                               case SQ_INTERRUPT_ERROR_TYPE_MEMVIOL:
> > > +                                       /*if
> > > + (!(((adev->mes.sched_version &
> > > AMDGPU_MES_VERSION_MASK) >=3D 4) &&
> > > +
> > > + (adev->ip_versions[GC_HWIP][0] >=3D
> > > IP_VERSION(11, 0, 0)) &&
> > > +
> > > + (adev->ip_versions[GC_HWIP][0] <=3D
> > > IP_VERSION(11, 0, 3)))
> > > +                                               && sq_int_priv)
> > > +
> > > + kfd_set_dbg_ev_from_interrupt(dev, pasid, -1,
> > > +
> > > KFD_EC_MASK(EC_QUEUE_WAVE_MEMORY_VIOLATION),
> > > +                                                       NULL, 0);*/
> > > +                                       return;
> > >                                 }
> > >                                 break;
> > >                         default:
> > > --
> > > 2.36.1

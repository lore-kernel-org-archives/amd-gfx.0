Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BFBCAC5AE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 14:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 623B710EA6E;
	Fri, 26 Sep 2025 14:33:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nK77n1NF";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEA8210EA6E
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 14:33:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGXiXZKbMMWiLtLymIelR0QPM5u0jL9sT2ZfEiMtkrO2R6g7WBR7n92RyUatgv/ns/cobxrssQAsNBppQkrF136sN8wFkmMgFm7goSzIVaeyYsWioKZN/tFcYIcGpneAnMIyQs9SaDY0GGNrCOXkfPHOELl5uk7cP+OB+XbVBHWHpzrRMDXEj3VGrhXsQIvk+b1TOUtJKmhyUI5ffD0gGJJ2e+QL0dsHAq4R6gRh3Nc/dQyttnCMeRo49cCi2xzi+AnTYId1UDqClztfzBwtX4mckeMoFYIS1drkRMtJGVRz8WkTo2Eu1jXvF6/j8RtciLJbaoQh6eetydjSJbJ+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1Npyu+j/DcSWxd5TZSPxCkgAzmUAFXs4E5043DD/YE=;
 b=cSG2MAvLYawpaKlulRcSpwdIgWFn8bDRie3OcaS1GfnSxZJwvZYQzCezi9mem6lbuMyp5z/52cNfIGckO3WOdBpdaNWY5Zhk57JL3FThzfyyaiFEBU5Vr0x68zZRi6S6KrGquHzxR1yiZOdpwxnbDkgigvBtqUObfVY5tjhJ1aa5AbfmEouKdoZxfo/1sd/j55lKzBA/LqqL9CCyvGTBSw2Gh6kAhv+wcGJd3qZHwRp8kvw8jb2YYKAxtuEDljQA8SmSd8pqLj+VM39Ck6iRy9LqNs6mgpgPi2oH/D0BK7FjL2yS+1frhz8OJc6ZUXjwW2A8R2PltuSHim6B/JDwUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1Npyu+j/DcSWxd5TZSPxCkgAzmUAFXs4E5043DD/YE=;
 b=nK77n1NFecRmVhnTvNLI2ImQSnmnRGWlszT/Aay22Hl17CPJC0FCg8McpPHiI5gOZ0PhPEnYfDDtT6yhGvIheZ3h2iMWt3YYXkhnN0KaukP04UDM/M1yFZv+AJhUUi456Q6laRRLtcnLhc7OH9eh1KIkTbvanfOBhjBAZH/HrEw=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by PH7PR12MB9223.namprd12.prod.outlook.com (2603:10b6:510:2f2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 14:33:13 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 14:33:13 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v4 1/2] amd/amdkfd: resolve a race in
 amdgpu_amdkfd_device_fini_sw
Thread-Topic: [PATCH v4 1/2] amd/amdkfd: resolve a race in
 amdgpu_amdkfd_device_fini_sw
Thread-Index: AQHcLWgTnPLagjuNFECF58wZePJndLSi7+WAgAB93wCAAAFusIAACZwAgAACGgCAAB/uwIABbd4AgAB/Z74=
Date: Fri, 26 Sep 2025 14:33:13 +0000
Message-ID: <CY5PR12MB63697295FA82372B5759A1CFC11EA@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20250924152929.2234747-1-yifan1.zhang@amd.com>
 <ccc729b8-640e-6e71-3522-7208413990f0@amd.com>
 <DS0PR12MB7804DBACD17E1583644F9430971FA@DS0PR12MB7804.namprd12.prod.outlook.com>
 <CY5PR12MB6369FE21B3A3079D6E658701C11FA@CY5PR12MB6369.namprd12.prod.outlook.com>
 <DS0PR12MB7804B2A1338FC3E91E37F1D9971FA@DS0PR12MB7804.namprd12.prod.outlook.com>
 <DS0PR12MB7804A33F5341A416484C66EC971FA@DS0PR12MB7804.namprd12.prod.outlook.com>
 <CY5PR12MB6369DC6E20631567D14F9DD0C11FA@CY5PR12MB6369.namprd12.prod.outlook.com>
 <DS0PR12MB780409C0BBADEE1F73A64B07971EA@DS0PR12MB7804.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB780409C0BBADEE1F73A64B07971EA@DS0PR12MB7804.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-26T14:33:12.571Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=1;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|PH7PR12MB9223:EE_
x-ms-office365-filtering-correlation-id: f17f1eea-5c6b-4a4b-2853-08ddfd099fe6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|8096899003; 
x-microsoft-antispam-message-info: =?us-ascii?Q?qmSN1cmCCLJAG5j0td26deLscI76gGNlhZ6xYyrvoJF4WRPDCI02MKyX6/nc?=
 =?us-ascii?Q?kTholGm9GtxRx9H6YuX4b3Wz64Vo8aPmYqO/Orju9XZWgXZQrb9ezwhIhORm?=
 =?us-ascii?Q?4uNRCZhjrjvqgtbPt1H0dz5olNTt4fbfNjN4kSDqXzE+5C+u6LUubpX0q50q?=
 =?us-ascii?Q?kwzeyJzj4pYZpaYT2lDrUEiB1K21b4H4PFLkoMtzr/GHQrziNkS0x7XmzbUN?=
 =?us-ascii?Q?1xP3ca5Vi9pw3Wda3JLJhXkSTx15jICdrM4LxF0KCoC+5mza9ZkswWAJEDn6?=
 =?us-ascii?Q?tyth8cfJ8Apa1qtCtT9h53fz3ZBHPgGHh+R/vU6YWQu2dnT8nvzvvH488xdw?=
 =?us-ascii?Q?xBOz/wFjZv8/qBzijcrWXas6v35BKQ8zCiqlGN8K98XGJD/0RXNSE21iSjCV?=
 =?us-ascii?Q?cBARQqEXqGmnSbUhIM2WC5TRPM+dze62yph3EBv9wEj1LtvC7htFJaWfRi+9?=
 =?us-ascii?Q?mLxA4EQEy+eqFv5w93RaSCONwVrlMJM1nbOU6q7/783Rdsljode7K4fxc2aM?=
 =?us-ascii?Q?UO/5UOv/xjaznOT2Gk/bmoa+DHdhx0GoMOEHG1RDxAA7pIobTDjA4DexI2xY?=
 =?us-ascii?Q?+6UO7Xy8ffz+m5TGfmNfbyzu9DgHf/n0Corl/KSS6aVihX+SQJsh/oy7o9Gw?=
 =?us-ascii?Q?XVkOf08IKKrE4KmX2T5LCGfGLQWk9THmLZjJQUG1vVnK8dirtWS15BYEY+yV?=
 =?us-ascii?Q?Dh4IaMMR7CK/dB/t4ChvRTVLnrFC0hRGQMfcbHg3hSCYaMzZ2P4GtR9nMYBD?=
 =?us-ascii?Q?Ux3ZiZeeSA84AcBYOOkiH5KDP52ORM/ks1FCEkrUi5x7GafYKl2iamWSsbP1?=
 =?us-ascii?Q?z+p0HWm86ge2XEinlmIbJfC3JUqSl2254LtP/0ERGJJ5EmmoI4Pncxh+SUUa?=
 =?us-ascii?Q?hjyeKuv02sVu/BQsEMTcteDAG/FNXIQPKXixRvg/aE/WSEzBhX7ZLvMkJXVk?=
 =?us-ascii?Q?ZOEeSqbXqi4H6wLa7xILa1ie0nMBNBBoAjN10lm1lLTrw1Go8FvbPd+yMBBf?=
 =?us-ascii?Q?2JTyjc+SgW9cR+AU5y/rlYdxhypghFllbX+c0eM2qZFWgGHO52t+6bT0rDzx?=
 =?us-ascii?Q?BOp3eXDpk3W0BSAU00nRIxr9giZBlcbJKYpV6/me7FO2Z/66j74JKscblpS4?=
 =?us-ascii?Q?kg1Bx64egaumIQDiLCrdmPzwxR0qRIyhyruEehDu2FCAIZwvHi6mNJpAeeMJ?=
 =?us-ascii?Q?vT9FvFjo4GBgu9MJu8v24DXD5YdcQAD1Tr7OH3tuJThZT2REOYY2LkSgvuDm?=
 =?us-ascii?Q?Twp4CZJefZpTF7UOD4JMOQtpfYwnkYx1t05mqypXPdZZFtyfSXcKSTgYBm10?=
 =?us-ascii?Q?zCb4Z8wSVUcMF5PRD2GNj8AKDPyWNOR+5By/Oxrtw5t3vB+xoystf24ELiLL?=
 =?us-ascii?Q?xe8EMw7vvsFsfM6Tv7TOaGkAyMunlFa3hLCapcS4C54dNLtTwnXhfeEv+lsr?=
 =?us-ascii?Q?TpytpEcPsqnYDpd+WNuKJwXbSFP5bwuOHrTCTK4NFVadRBV/PFPSNtcaiRJH?=
 =?us-ascii?Q?tuhHb20SL4yXSFc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(8096899003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eUePOw736JNBx+oc307SPCfBkKDxFDaMg+hoBOdmaNYX2g5pLaB49cm6s3dw?=
 =?us-ascii?Q?4LI2Elxk5CODGDPzcYTljqSwp76FRiijdiN7tNF1umk3dkT83bcU/oxjGadJ?=
 =?us-ascii?Q?BEHnzxlM4CvH+E7p5iVeyTMd7/9DJTDWgHN4K13MLbAJfHNFMuo16Wwi7z2m?=
 =?us-ascii?Q?6F2avMy+Q7nP7sVpB0w/hXCWDsGiML7nbAPMZjp4uFtwsy4MZs9xcGL0LKxf?=
 =?us-ascii?Q?UCAbxT1WqaZsPPMRo/uk4bAHBv2qBwRSuijFu+++/KdVSnm0xn6WI7XRnLZr?=
 =?us-ascii?Q?AfJympRs/tgQJvFgw3ClPBINPs9LToRqA/2mBxpB/528EJHiiYSjFUxsrKR9?=
 =?us-ascii?Q?S5+mhv3s7YhrIL688uZ+udzuQqjVNN7+lcx6dhShBunuAOFPlW+PJ4YqyL8X?=
 =?us-ascii?Q?870bO0mZwNYsj3XQl9dwWtpHiC8c/fy45f2fGzjqaNT+xXwu4nQKU37q+2yR?=
 =?us-ascii?Q?OFhaUNCXkoaWXn+DOop7WTiCE1FN+MjYXiRcsnA/CCr+Mx3OMbJBKDS1j3Xj?=
 =?us-ascii?Q?QgpHre5mVJZm5mHZN0lKoQADu0nO+pWkGlRe39gp9fjjUWpv9YW24xlWROWa?=
 =?us-ascii?Q?l5cE2wqKQb73RswRHQiOK6iJno71aRwXUjmKgpOhd4Et38n0YYLQvjbyhEEw?=
 =?us-ascii?Q?XKmbftahosdwGdGfu9wjYlNxpA7A27RjxBadAxHTOFIxLeTrtxnM81EIXSaq?=
 =?us-ascii?Q?SyMOSGmdOD8PCP52Sv6WpmdAipTWieRdN+x5yGVsHMRzsLhJw3Ll6wk6ZdOH?=
 =?us-ascii?Q?WLPQn8bAow5leYzw7Ib3E42zMnkCHHGvcYR4Pg/DbCKSnpAPTvvUoCRgi9gz?=
 =?us-ascii?Q?ciMlOumUchS0JHzIPMN6Z5o7ZG/OCrmSYIBvdl656mOFLwwrPPkST5NVqTpm?=
 =?us-ascii?Q?e0torBJSKCtOH1oh5ppLarWxLDcGjOgBM1WY9pFLRiWiQ+ngH5HPzAw+fp9k?=
 =?us-ascii?Q?4r9sxtnTP+DpNAZBiEicZd5CegtMYYnw7T+9YIwN2RstDzULeUn9ADXws6Pe?=
 =?us-ascii?Q?cnOvRvyZszGJokcDmltRCewRliPla1P35oWNU/T3Z8ES4m92MtC8YUxwixQd?=
 =?us-ascii?Q?Xzu7yLMKtHNl29OCHzcK3YoajybiKcmsp4lPqjO8Brwek3sxin7aczJaoHqA?=
 =?us-ascii?Q?TdtzGuuSMVkvEdGSZnJo74WumVHpkoDrV69ZTBa5qpvRoF4+faW8rCKmW3XQ?=
 =?us-ascii?Q?tCRWNO0nwsa7dSuHG9SQvtBsIpMYMRY7Q1eS5giOW2EJ8SLhw3tW5Bt1Wr7B?=
 =?us-ascii?Q?jSWoAN6ooknM9f9cAbGxYJ4nSVxPDLorv2Fvs2I9hLxiqI9Eyp48CzQ9J8ZR?=
 =?us-ascii?Q?5gpkyOZhCQDmzCamrCNL52OT+98t0im+mhHMZxWLGu+vRftGIzmP4GCjeOZe?=
 =?us-ascii?Q?SBxy04bB6BqVAcnYsqNyxvWIjFRVpSBSE245PdjG0wnuPHqjFnzzwtan9G3e?=
 =?us-ascii?Q?cQxjM9YvRVETI0jUzUILrLPUEVJcpTsmuwLQQ1+98vQeN1L7QTELi5m6OV0G?=
 =?us-ascii?Q?HHLVz4/ev3G31W/xB0lbCYkGZzzYLIM9o1qoqEvnmquoI5Cz/zy8EWNqayad?=
 =?us-ascii?Q?SJpzoMcDLQPiu130uJQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB63697295FA82372B5759A1CFC11EACY5PR12MB6369namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17f1eea-5c6b-4a4b-2853-08ddfd099fe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 14:33:13.5404 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g398vroRalXWKeA5WFoZmy/E5tgdD/qBGmY8Jq0e6/OVJEvQUa0AJ6IlrIqJ3xu4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9223
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

--_000_CY5PR12MB63697295FA82372B5759A1CFC11EACY5PR12MB6369namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

  kfd_interrupt_exit needs to break to two parts, because knode->ih_fifo is=
 still needed by flush ih_wq.  Change like this:

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index e9cfb80bd436..270459826147 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -655,19 +655,33 @@ static void kfd_cleanup_nodes(struct kfd_dev *kfd, un=
signed int num_nodes)
 {
        struct kfd_node *knode;
        unsigned int i;
+       unsigned long flags;

        /*
         * flush_work ensures that there are no outstanding
         * work-queue items that will access interrupt_ring. New work items
         * can't be created because we stopped interrupt handling above.
         */
+       for (i =3D 0; i < num_nodes; i++) {
+               knode =3D kfd->nodes[i];
+               spin_lock_irqsave(&knode->interrupt_lock, flags);
+               knode->interrupts_active =3D false;
+               spin_unlock_irqrestore(&knode->interrupt_lock, flags);
+       }
+
        flush_workqueue(kfd->ih_wq);
        destroy_workqueue(kfd->ih_wq);

+       for (i =3D 0; i < num_nodes; i++) {
+               spin_lock_irqsave(&knode->interrupt_lock, flags);
+               knode->kfd->ih_wq =3D NULL;
+               spin_unlock_irqrestore(&knode->interrupt_lock, flags);
+               kfifo_free(&knode->ih_fifo);
+       }
+
        for (i =3D 0; i < num_nodes; i++) {
                knode =3D kfd->nodes[i];
                device_queue_manager_uninit(knode->dqm);
-               kfd_interrupt_exit(knode);
                kfd_topology_remove_device(knode);
                if (knode->gws)
                        amdgpu_amdkfd_free_gws(knode->adev, knode->gws);
@@ -1125,7 +1139,8 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const voi=
d *ih_ring_entry)
        unsigned long flags;
        struct kfd_node *node;

-       if (!kfd->init_complete)
+       if (!kfd->init_complete || !kfd->ih_wq)
                return;

        if (kfd->device_info.ih_ring_entry_size > sizeof(patched_ihre)) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_interrupt.c
index 783c2f5a04e4..be10c0a9d391 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
@@ -87,21 +87,6 @@ int kfd_interrupt_init(struct kfd_node *node)
        return 0;
 }

-void kfd_interrupt_exit(struct kfd_node *node)
-{
-       /*
-        * Stop the interrupt handler from writing to the ring and scheduli=
ng
-        * workqueue items. The spinlock ensures that any interrupt running
-        * after we have unlocked sees interrupts_active =3D false.
-        */
-       unsigned long flags;
-
-       spin_lock_irqsave(&node->interrupt_lock, flags);
-       node->interrupts_active =3D false;
-       spin_unlock_irqrestore(&node->interrupt_lock, flags);
-       kfifo_free(&node->ih_fifo);
-}
-




________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, September 26, 2025 2:49 PM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Yang, Philip <Philip.Yang@amd.com>=
; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>
Subject: RE: [PATCH v4 1/2] amd/amdkfd: resolve a race in amdgpu_amdkfd_dev=
ice_fini_sw

[Public]

The intention is to let kgd2kfd_interrupt thread know that KFD is done with=
 interrupt handling and exit at the earliest (that is even without going th=
rough kfd node loop). I was thinking of checking ih_wq NULL value, but sinc=
e that value is not under lock, it's not necessary that kgd2kfd_interrupt t=
hread sees the NULL value immediately.

> if (!kfd->init_complete && !kfd->ih_wq)

I think this should be  if (!kfd->ih_wq || !kfd->init_complete)

For this - kfd_interrupt_exit(knode) - it's better to keep it before flush_=
workqueue. That indicates no more queueing is allowed from any node.

Thanks,
Lijo

-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Thursday, September 25, 2025 3:25 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Yang, Philip <Philip.Yang@amd.com>; a=
md-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>
Subject: RE: [PATCH v4 1/2] amd/amdkfd: resolve a race in amdgpu_amdkfd_dev=
ice_fini_sw

[Public]

Hi Lijo, Do you mean a change like below ? Besides readability, is there fu=
nctional improvement ?

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index e9cfb80bd436..86676acd9cbe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -663,6 +663,7 @@ static void kfd_cleanup_nodes(struct kfd_dev *kfd, unsi=
gned int num_nodes)
         */
        flush_workqueue(kfd->ih_wq);
        destroy_workqueue(kfd->ih_wq);
+       kfd->ih_wq =3D NULL;

        for (i =3D 0; i < num_nodes; i++) {
                knode =3D kfd->nodes[i];
@@ -1125,7 +1126,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const voi=
d *ih_ring_entry)
        unsigned long flags;
        struct kfd_node *node;

-       if (!kfd->init_complete)
+       if (!kfd->init_complete && !kfd->ih_wq)
                return;

        if (kfd->device_info.ih_ring_entry_size > sizeof(patched_ihre)) {


Regarding the destroy_workqueue(kfd->ih_wq) and queue_work(node->kfd->ih_wq=
, &node->interrupt_work) sync, it looks like another issue, should set node=
->interrupts_active =3D false before  destroy_workqueue(kfd->ih_wq) is call=
ed. I think something like below:

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c
index e9cfb80bd436..92d9fa99e954 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -662,6 +662,9 @@ static void kfd_cleanup_nodes(struct kfd_dev *kfd, unsi=
gned int num_nodes)
         * can't be created because we stopped interrupt handling above.
         */
        flush_workqueue(kfd->ih_wq);
+       for (i =3D 0; i < num_nodes; i++) {
+               kfd_interrupt_exit(knode);
+       }
        destroy_workqueue(kfd->ih_wq);

        for (i =3D 0; i < num_nodes; i++) {


-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, September 25, 2025 3:06 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; =
Yang, Philip <Philip.Yang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>
Subject: RE: [PATCH v4 1/2] amd/amdkfd: resolve a race in amdgpu_amdkfd_dev=
ice_fini_sw

[Public]

On a second thought, probably this will require some locking. For ex: it's =
quite possible that destroy_workqueue(kfd->ih_wq) and queue_work(node->kfd-=
>ih_wq, &node->interrupt_work) could be happening back-to-back. Node is not=
 yet deleted.

Thanks,
Lijo
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lazar, L=
ijo
Sent: Thursday, September 25, 2025 12:29 PM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Yang, Philip <Philip.Yang@amd.com>=
; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>
Subject: RE: [PATCH v4 1/2] amd/amdkfd: resolve a race in amdgpu_amdkfd_dev=
ice_fini_sw

[Public]

I meant something like this.

destroy_workqueue(kfd->ih_wq);
kfd->ih_wq =3D NULL;

Then check for NULL at the beginning of kgd2kfd_interrupt. If there is no I=
H workqueue, then there is no interrupt handling capability.

May also be within the loop. Not sure if that is really required; if some w=
ork is already scheduled previously, it should be inside flush_workqueue() =
of cleanup_nodes.

        for (i =3D 0; kfd->ih_wq && i < kfd->num_nodes; i++)

Thanks,
Lijo

-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Thursday, September 25, 2025 12:11 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Yang, Philip <Philip.Yang@amd.com>; a=
md-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>
Subject: RE: [PATCH v4 1/2] amd/amdkfd: resolve a race in amdgpu_amdkfd_dev=
ice_fini_sw

[Public]

The interrupts are from KGD, still active after flush ih_wq and kfd_dev is =
freed. And after knode is freed, node->interrupts_active is also inaccessib=
le. The race condition is as below:

Interrupt handling                                              switch part=
ition process
                                                        |
                                                                |       flu=
sh_workqueue(kfd->ih_wq);
                                                                |       des=
troy_workqueue(kfd->ih_wq);
amdgpu_irq_dispatch                                                |
amdgpu_amdkfd_interrupt                         |
kgd2kfd_interrupt                                       |
                                                        |       kfd_cleanup=
_nodes
                                                        |       kfree(knode=
);
spin_lock_irqsave(&node->interrupt_lock, flags);        |
//NULL Pointer


-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, September 25, 2025 2:19 PM
To: Yang, Philip <Philip.Yang@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>=
; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>
Subject: RE: [PATCH v4 1/2] amd/amdkfd: resolve a race in amdgpu_amdkfd_dev=
ice_fini_sw

[Public]

> Race if another thread in b/w kfd_cleanup_nodes

This code is there before cleanup of nodes.
        flush_workqueue(kfd->ih_wq);
        destroy_workqueue(kfd->ih_wq);

Shouldn't the interrupt handling code check if interrupt handling is enable=
d rather than checking individual node NULL pointers?

Thanks,
Lijo

-----Original Message-----
From: Yang, Philip <Philip.Yang@amd.com>
Sent: Thursday, September 25, 2025 4:19 AM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.=
Kuehling@amd.com>; Yang, Philip <Philip.Yang@amd.com>; Lazar, Lijo <Lijo.La=
zar@amd.com>
Subject: Re: [PATCH v4 1/2] amd/amdkfd: resolve a race in amdgpu_amdkfd_dev=
ice_fini_sw


On 2025-09-24 11:29, Yifan Zhang wrote:
> There is race in amdgpu_amdkfd_device_fini_sw and interrupt.
> if amdgpu_amdkfd_device_fini_sw run in b/w kfd_cleanup_nodes and
>    kfree(kfd), and KGD interrupt generated.
>
> kernel panic log:
>
> BUG: kernel NULL pointer dereference, address: 0000000000000098 amdgpu
> 0000:c8:00.0: amdgpu: Requesting 4 partitions through PSP
>
> PGD d78c68067 P4D d78c68067
>
> kfd kfd: amdgpu: Allocated 3969056 bytes on gart
>
> PUD 1465b8067 PMD @
>
> Oops: @002 [#1] SMP NOPTI
>
> kfd kfd: amdgpu: Total number of KFD nodes to be created: 4
> CPU: 115 PID: @ Comm: swapper/115 Kdump: loaded Tainted: G S W OE K
>
> RIP: 0010:_raw_spin_lock_irqsave+0x12/0x40
>
> Code: 89 e@ 41 5c c3 cc cc cc cc 66 66 2e Of 1f 84 00 00 00 00 00 OF
> 1f 40 00 Of 1f 44% 00 00 41 54 9c 41 5c fa 31 cO ba 01 00 00 00 <fO>
> OF b1 17 75 Ba 4c 89 e@ 41 Sc
>
> 89 c6 e8 07 38 5d
>
> RSP: 0018: ffffc90@1a6b0e28 EFLAGS: 00010046
>
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000018
> 0000000000000001 RSI: ffff8883bb623e00 RDI: 0000000000000098
> ffff8883bb000000 RO8: ffff888100055020 ROO: ffff888100055020
> 0000000000000000 R11: 0000000000000000 R12: 0900000000000002
> ffff888F2b97da0@ R14: @000000000000098 R15: ffff8883babdfo00
>
> CS: 010 DS: 0000 ES: 0000 CRO: 0000000080050033
>
> CR2: 0000000000000098 CR3: 0000000e7cae2006 CR4: 0000000002770ce0
> 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 0000000000000000 DR6: 00000000fffeO7FO DR7: 0000000000000400
>
> PKRU: 55555554
>
> Call Trace:
>
> <IRQ>
>
> kgd2kfd_interrupt+@x6b/0x1f@ [amdgpu]
>
> ? amdgpu_fence_process+0xa4/0x150 [amdgpu]
>
> kfd kfd: amdgpu: Node: 0, interrupt_bitmap: 3 YcpxFl Rant tErace
>
> amdgpu_irq_dispatch+0x165/0x210 [amdgpu]
>
> amdgpu_ih_process+0x80/0x100 [amdgpu]
>
> amdgpu: Virtual CRAT table created for GPU
>
> amdgpu_irq_handler+0x1f/@x60 [amdgpu]
>
> __handle_irq_event_percpu+0x3d/0x170
>
> amdgpu: Topology: Add dGPU node [0x74a2:0x1002]
>
> handle_irq_event+0x5a/@xcO
>
> handle_edge_irq+0x93/0x240
>
> kfd kfd: amdgpu: KFD node 1 partition @ size 49148M
>
> asm_call_irq_on_stack+0xf/@x20
>
> </IRQ>
>
> common_interrupt+0xb3/0x130
>
> asm_common_interrupt+0x1le/0x40
>
> 5.10.134-010.a1i5000.a18.x86_64 #1
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Philip Yang<Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 349c351e242b..051a00152b08 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1133,7 +1133,15 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const =
void *ih_ring_entry)
>       }
>
>       for (i =3D 0; i < kfd->num_nodes; i++) {
> -             node =3D kfd->nodes[i];
> +             /* Race if another thread in b/w
> +              * kfd_cleanup_nodes and kfree(kfd),
> +              * when kfd->nodes[i] =3D NULL
> +              */
> +             if (kfd->nodes[i])
> +                     node =3D kfd->nodes[i];
> +             else
> +                     return;
> +
>               spin_lock_irqsave(&node->interrupt_lock, flags);
>
>               if (node->interrupts_active





--_000_CY5PR12MB63697295FA82372B5759A1CFC11EACY5PR12MB6369namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 128, 0)=
; margin-left: 5pt; font-size: 10pt;">
[Public]</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; kfd_interrupt_exit needs to break to two parts, because knode-&gt;ih=
_fifo is still needed by flush ih_wq.&nbsp; Change like this:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
index e9cfb80bd436..270459826147 100644</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
@@ -655,19 +655,33 @@ static void kfd_cleanup_nodes(struct kfd_dev *kfd, un=
signed int num_nodes)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;{</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; struct kfd_node *knode;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; unsigned int i;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; unsigned long flags;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; /*</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* flush_work ensures that there are no ou=
tstanding</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* work-queue items that will access inter=
rupt_ring. New work items</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* can't be created because we stopped int=
errupt handling above.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;*/</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; for (i =3D 0; i &lt; num_nodes; i++) {</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; knode =3D kfd-&gt;nodes[=
i];</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; spin_lock_irqsave(&amp;k=
node-&gt;interrupt_lock, flags);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; knode-&gt;interrupts_act=
ive =3D false;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; spin_unlock_irqrestore(&=
amp;knode-&gt;interrupt_lock, flags);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; }</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; flush_workqueue(kfd-&gt;ih_wq);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; destroy_workqueue(kfd-&gt;ih_wq);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; for (i =3D 0; i &lt; num_nodes; i++) {</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; spin_lock_irqsave(&amp;k=
node-&gt;interrupt_lock, flags);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; knode-&gt;kfd-&gt;ih_wq =
=3D NULL;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; spin_unlock_irqrestore(&=
amp;knode-&gt;interrupt_lock, flags);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; kfifo_free(&amp;knode-&g=
t;ih_fifo);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; }</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; for (i =3D 0; i &lt; num_nodes; i++) {</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; knode =3D kfd-&gt;n=
odes[i];</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; device_queue_manage=
r_uninit(knode-&gt;dqm);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; kfd_interrupt_exit(knode=
);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; kfd_topology_remove=
_device(knode);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (knode-&gt;gws)<=
/div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; amdgpu_amdkfd_free_gws(knode-&gt;adev, knode-&gt;gws);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
@@ -1125,7 +1139,8 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const voi=
d *ih_ring_entry)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; unsigned long flags;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; struct kfd_node *node;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- &nbsp; &nbsp; &nbsp; if (!kfd-&gt;init_complete)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+ &nbsp; &nbsp; &nbsp; if (!kfd-&gt;init_complete || !kfd-&gt;ih_wq)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; if (kfd-&gt;device_info.ih_ring_entry_size &gt;=
 sizeof(patched_ihre)) {</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_interrupt.c</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
index 783c2f5a04e4..be10c0a9d391 100644</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
--- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
@@ -87,21 +87,6 @@ int kfd_interrupt_init(struct kfd_node *node)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp; &nbsp; &nbsp; &nbsp; return 0;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
&nbsp;}</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
-void kfd_interrupt_exit(struct kfd_node *node)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
-{</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- &nbsp; &nbsp; &nbsp; /*</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- &nbsp; &nbsp; &nbsp; &nbsp;* Stop the interrupt handler from writing to t=
he ring and scheduling</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- &nbsp; &nbsp; &nbsp; &nbsp;* workqueue items. The spinlock ensures that a=
ny interrupt running</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- &nbsp; &nbsp; &nbsp; &nbsp;* after we have unlocked sees interrupts_activ=
e =3D false.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- &nbsp; &nbsp; &nbsp; &nbsp;*/</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- &nbsp; &nbsp; &nbsp; unsigned long flags;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
-</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- &nbsp; &nbsp; &nbsp; spin_lock_irqsave(&amp;node-&gt;interrupt_lock, flag=
s);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- &nbsp; &nbsp; &nbsp; node-&gt;interrupts_active =3D false;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- &nbsp; &nbsp; &nbsp; spin_unlock_irqrestore(&amp;node-&gt;interrupt_lock,=
 flags);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- &nbsp; &nbsp; &nbsp; kfifo_free(&amp;node-&gt;ih_fifo);</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
-}</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
-</div>
<div id=3D"Signature">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<p style=3D"margin-top: 1em; margin-bottom: 1em;">&nbsp;</p>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Lazar, Lijo &lt;Lijo.=
Lazar@amd.com&gt;<br>
<b>Sent:</b> Friday, September 26, 2025 2:49 PM<br>
<b>To:</b> Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;; Yang, Philip &lt;Phil=
ip.Yang@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freede=
sktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kuehling, =
Felix &lt;Felix.Kuehling@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH v4 1/2] amd/amdkfd: resolve a race in amdgpu_amd=
kfd_device_fini_sw</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font face=3D"Times New Roman" size=3D"3"><span=
 style=3D"font-size:12pt;"><a name=3D"BM_BEGIN"></a>
<div><font size=3D"2"><span style=3D"font-size:11pt;">[Public]<br>
<br>
The intention is to let kgd2kfd_interrupt thread know that KFD is done with=
 interrupt handling and exit at the earliest (that is even without going th=
rough kfd node loop). I was thinking of checking ih_wq NULL value, but sinc=
e that value is not under lock,
 it's not necessary that kgd2kfd_interrupt thread sees the NULL value immed=
iately.<br>
<br>
&gt; if (!kfd-&gt;init_complete &amp;&amp; !kfd-&gt;ih_wq)<br>
<br>
I think this should be&nbsp; if (!kfd-&gt;ih_wq || !kfd-&gt;init_complete)<=
br>
<br>
For this - kfd_interrupt_exit(knode) - it's better to keep it before flush_=
workqueue. That indicates no more queueing is allowed from any node.<br>
<br>
Thanks,<br>
Lijo<br>
<br>
-----Original Message-----<br>
From: Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;<br>
Sent: Thursday, September 25, 2025 3:25 PM<br>
To: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Yang, Philip &lt;Philip.Yang@am=
d.com&gt;; amd-gfx@lists.freedesktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kuehling, Felix &=
lt;Felix.Kuehling@amd.com&gt;<br>
Subject: RE: [PATCH v4 1/2] amd/amdkfd: resolve a race in amdgpu_amdkfd_dev=
ice_fini_sw<br>
<br>
[Public]<br>
<br>
Hi Lijo, Do you mean a change like below ? Besides readability, is there fu=
nctional improvement ?<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c<br>
index e9cfb80bd436..86676acd9cbe 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
@@ -663,6 +663,7 @@ static void kfd_cleanup_nodes(struct kfd_dev *kfd, unsi=
gned int num_nodes)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_workqueue(kfd-&gt;ih_wq);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; destroy_workqueue(kfd-&gt;ih_wq)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd-&gt;ih_wq =3D NULL;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; num_nodes; =
i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; knode =3D kfd-&gt;nodes[i];<br>
@@ -1125,7 +1126,7 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, const voi=
d *ih_ring_entry)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long flags;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_node *node;<br>
<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!kfd-&gt;init_complete)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!kfd-&gt;init_complete &amp;&amp;=
 !kfd-&gt;ih_wq)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (kfd-&gt;device_info.ih_ring_=
entry_size &gt; sizeof(patched_ihre)) {<br>
<br>
<br>
Regarding the destroy_workqueue(kfd-&gt;ih_wq) and queue_work(node-&gt;kfd-=
&gt;ih_wq, &amp;node-&gt;interrupt_work) sync, it looks like another issue,=
 should set node-&gt;interrupts_active =3D false before&nbsp; destroy_workq=
ueue(kfd-&gt;ih_wq) is called. I think something like below:<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/=
amdkfd/kfd_device.c<br>
index e9cfb80bd436..92d9fa99e954 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
@@ -662,6 +662,9 @@ static void kfd_cleanup_nodes(struct kfd_dev *kfd, unsi=
gned int num_nodes)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * can't be created because=
 we stopped interrupt handling above.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_workqueue(kfd-&gt;ih_wq);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; num_nodes; i++) =
{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfd_interrupt_exit(knode);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; destroy_workqueue(kfd-&gt;ih_wq)=
;<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; num_nodes; =
i++) {<br>
<br>
<br>
-----Original Message-----<br>
From: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
Sent: Thursday, September 25, 2025 3:06 PM<br>
To: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Zhang, Yifan &lt;Yifan1.Zhang@a=
md.com&gt;; Yang, Philip &lt;Philip.Yang@amd.com&gt;; amd-gfx@lists.freedes=
ktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kuehling, Felix &=
lt;Felix.Kuehling@amd.com&gt;<br>
Subject: RE: [PATCH v4 1/2] amd/amdkfd: resolve a race in amdgpu_amdkfd_dev=
ice_fini_sw<br>
<br>
[Public]<br>
<br>
On a second thought, probably this will require some locking. For ex: it's =
quite possible that destroy_workqueue(kfd-&gt;ih_wq) and queue_work(node-&g=
t;kfd-&gt;ih_wq, &amp;node-&gt;interrupt_work) could be happening back-to-b=
ack. Node is not yet deleted.<br>
<br>
Thanks,<br>
Lijo<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of La=
zar, Lijo<br>
Sent: Thursday, September 25, 2025 12:29 PM<br>
To: Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;; Yang, Philip &lt;Philip.Yang=
@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kuehling, Felix &=
lt;Felix.Kuehling@amd.com&gt;<br>
Subject: RE: [PATCH v4 1/2] amd/amdkfd: resolve a race in amdgpu_amdkfd_dev=
ice_fini_sw<br>
<br>
[Public]<br>
<br>
I meant something like this.<br>
<br>
destroy_workqueue(kfd-&gt;ih_wq);<br>
kfd-&gt;ih_wq =3D NULL;<br>
<br>
Then check for NULL at the beginning of kgd2kfd_interrupt. If there is no I=
H workqueue, then there is no interrupt handling capability.<br>
<br>
May also be within the loop. Not sure if that is really required; if some w=
ork is already scheduled previously, it should be inside flush_workqueue() =
of cleanup_nodes.<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; kfd-&gt;ih_wq &amp=
;&amp; i &lt; kfd-&gt;num_nodes; i++)<br>
<br>
Thanks,<br>
Lijo<br>
<br>
-----Original Message-----<br>
From: Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;<br>
Sent: Thursday, September 25, 2025 12:11 PM<br>
To: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Yang, Philip &lt;Philip.Yang@am=
d.com&gt;; amd-gfx@lists.freedesktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kuehling, Felix &=
lt;Felix.Kuehling@amd.com&gt;<br>
Subject: RE: [PATCH v4 1/2] amd/amdkfd: resolve a race in amdgpu_amdkfd_dev=
ice_fini_sw<br>
<br>
[Public]<br>
<br>
The interrupts are from KGD, still active after flush ih_wq and kfd_dev is =
freed. And after knode is freed, node-&gt;interrupts_active is also inacces=
sible. The race condition is as below:<br>
<br>
Interrupt handling&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch part=
ition process<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_workqueue(kfd-&gt;ih_wq);<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; destroy_workqueue(kfd-&gt;ih_wq);=
<br>
amdgpu_irq_dispatch&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; |<br>
amdgpu_amdkfd_interrupt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; |<br>
kgd2kfd_interrupt&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_cl=
eanup_nodes<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(=
knode);<br>
spin_lock_irqsave(&amp;node-&gt;interrupt_lock, flags);&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; |<br>
//NULL Pointer<br>
<br>
<br>
-----Original Message-----<br>
From: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
Sent: Thursday, September 25, 2025 2:19 PM<br>
To: Yang, Philip &lt;Philip.Yang@amd.com&gt;; Zhang, Yifan &lt;Yifan1.Zhang=
@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kuehling, Felix &=
lt;Felix.Kuehling@amd.com&gt;<br>
Subject: RE: [PATCH v4 1/2] amd/amdkfd: resolve a race in amdgpu_amdkfd_dev=
ice_fini_sw<br>
<br>
[Public]<br>
<br>
&gt; Race if another thread in b/w kfd_cleanup_nodes<br>
<br>
This code is there before cleanup of nodes.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; flush_workqueue(kfd-&gt;ih_wq);<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; destroy_workqueue(kfd-&gt;ih_wq)=
;<br>
<br>
Shouldn't the interrupt handling code check if interrupt handling is enable=
d rather than checking individual node NULL pointers?<br>
<br>
Thanks,<br>
Lijo<br>
<br>
-----Original Message-----<br>
From: Yang, Philip &lt;Philip.Yang@amd.com&gt;<br>
Sent: Thursday, September 25, 2025 4:19 AM<br>
To: Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;; amd-gfx@lists.freedesktop.or=
g<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Kuehling, Felix &=
lt;Felix.Kuehling@amd.com&gt;; Yang, Philip &lt;Philip.Yang@amd.com&gt;; La=
zar, Lijo &lt;Lijo.Lazar@amd.com&gt;<br>
Subject: Re: [PATCH v4 1/2] amd/amdkfd: resolve a race in amdgpu_amdkfd_dev=
ice_fini_sw<br>
<br>
<br>
On 2025-09-24 11:29, Yifan Zhang wrote:<br>
&gt; There is race in amdgpu_amdkfd_device_fini_sw and interrupt.<br>
&gt; if amdgpu_amdkfd_device_fini_sw run in b/w kfd_cleanup_nodes and<br>
&gt;&nbsp;&nbsp;&nbsp; kfree(kfd), and KGD interrupt generated.<br>
&gt;<br>
&gt; kernel panic log:<br>
&gt;<br>
&gt; BUG: kernel NULL pointer dereference, address: 0000000000000098 amdgpu=
<br>
&gt; 0000:c8:00.0: amdgpu: Requesting 4 partitions through PSP<br>
&gt;<br>
&gt; PGD d78c68067 P4D d78c68067<br>
&gt;<br>
&gt; kfd kfd: amdgpu: Allocated 3969056 bytes on gart<br>
&gt;<br>
&gt; PUD 1465b8067 PMD @<br>
&gt;<br>
&gt; Oops: @002 [#1] SMP NOPTI<br>
&gt;<br>
&gt; kfd kfd: amdgpu: Total number of KFD nodes to be created: 4<br>
&gt; CPU: 115 PID: @ Comm: swapper/115 Kdump: loaded Tainted: G S W OE K<br=
>
&gt;<br>
&gt; RIP: 0010:_raw_spin_lock_irqsave+0x12/0x40<br>
&gt;<br>
&gt; Code: 89 e@ 41 5c c3 cc cc cc cc 66 66 2e Of 1f 84 00 00 00 00 00 OF<b=
r>
&gt; 1f 40 00 Of 1f 44% 00 00 41 54 9c 41 5c fa 31 cO ba 01 00 00 00 &lt;fO=
&gt;<br>
&gt; OF b1 17 75 Ba 4c 89 e@ 41 Sc<br>
&gt;<br>
&gt; 89 c6 e8 07 38 5d<br>
&gt;<br>
&gt; RSP: 0018: ffffc90@1a6b0e28 EFLAGS: 00010046<br>
&gt;<br>
&gt; RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000018<br>
&gt; 0000000000000001 RSI: ffff8883bb623e00 RDI: 0000000000000098<br>
&gt; ffff8883bb000000 RO8: ffff888100055020 ROO: ffff888100055020<br>
&gt; 0000000000000000 R11: 0000000000000000 R12: 0900000000000002<br>
&gt; ffff888F2b97da0@ R14: @000000000000098 R15: ffff8883babdfo00<br>
&gt;<br>
&gt; CS: 010 DS: 0000 ES: 0000 CRO: 0000000080050033<br>
&gt;<br>
&gt; CR2: 0000000000000098 CR3: 0000000e7cae2006 CR4: 0000000002770ce0<br>
&gt; 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000<br>
&gt; 0000000000000000 DR6: 00000000fffeO7FO DR7: 0000000000000400<br>
&gt;<br>
&gt; PKRU: 55555554<br>
&gt;<br>
&gt; Call Trace:<br>
&gt;<br>
&gt; &lt;IRQ&gt;<br>
&gt;<br>
&gt; kgd2kfd_interrupt+@x6b/0x1f@ [amdgpu]<br>
&gt;<br>
&gt; ? amdgpu_fence_process+0xa4/0x150 [amdgpu]<br>
&gt;<br>
&gt; kfd kfd: amdgpu: Node: 0, interrupt_bitmap: 3 YcpxFl Rant tErace<br>
&gt;<br>
&gt; amdgpu_irq_dispatch+0x165/0x210 [amdgpu]<br>
&gt;<br>
&gt; amdgpu_ih_process+0x80/0x100 [amdgpu]<br>
&gt;<br>
&gt; amdgpu: Virtual CRAT table created for GPU<br>
&gt;<br>
&gt; amdgpu_irq_handler+0x1f/@x60 [amdgpu]<br>
&gt;<br>
&gt; __handle_irq_event_percpu+0x3d/0x170<br>
&gt;<br>
&gt; amdgpu: Topology: Add dGPU node [0x74a2:0x1002]<br>
&gt;<br>
&gt; handle_irq_event+0x5a/@xcO<br>
&gt;<br>
&gt; handle_edge_irq+0x93/0x240<br>
&gt;<br>
&gt; kfd kfd: amdgpu: KFD node 1 partition @ size 49148M<br>
&gt;<br>
&gt; asm_call_irq_on_stack+0xf/@x20<br>
&gt;<br>
&gt; &lt;/IRQ&gt;<br>
&gt;<br>
&gt; common_interrupt+0xb3/0x130<br>
&gt;<br>
&gt; asm_common_interrupt+0x1le/0x40<br>
&gt;<br>
&gt; 5.10.134-010.a1i5000.a18.x86_64 #1<br>
&gt;<br>
&gt; Signed-off-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
Reviewed-by: Philip Yang&lt;Philip.Yang@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_device.c | 10 +++++++++-<br=
>
&gt;&nbsp;&nbsp; 1 file changed, 9 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&gt; b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&gt; index 349c351e242b..051a00152b08 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c<br>
&gt; @@ -1133,7 +1133,15 @@ void kgd2kfd_interrupt(struct kfd_dev *kfd, con=
st void *ih_ring_entry)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; kfd-&gt;num_n=
odes; i++) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; node =3D kfd-&gt;nodes[i];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Race if another thread in b/w<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * kfd_cleanup_nodes and kfree(kfd),<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * when kfd-&gt;nodes[i] =3D NULL<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (kfd-&gt;nodes[i])<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node =3D kfd-&gt;nodes[=
i];<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; spin_lock_irqsave(&amp;node-&gt;interrupt_lock, flags);<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; if (node-&gt;interrupts_active<br>
<br>
<br>
<br>
<br>
</span></font></div>
</span></font></div>
</body>
</html>

--_000_CY5PR12MB63697295FA82372B5759A1CFC11EACY5PR12MB6369namp_--

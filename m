Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A63BC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Mar 2022 08:47:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19C9010E2B9;
	Mon, 21 Mar 2022 08:47:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C30A10E2B1
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Mar 2022 08:47:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hu7X/IUbAq/YBF8OwLP1xv2xFw/HPxsuwkQRFR877UVtgZ5YGxyHZAvUGbNv+bgvOaD+XgnOCSR0GHtIWgE6IBlo+qivxDmKECEZ8GepQe2abunSSdm29dh2oYPsAxjfIJOP8dmdlWBMNrloC4s7peEVmafPFV0DnoZFrB/so6App30eTxTb3UuLy8rHwkdurY93+qaZoZ5KXp5CNU4R0UvIhooTlpe0K/lXI+mRsgdTtjIeCKU0Dwcl4ULmnKAEus50xRdtWBxdlfMP2JPagTI274HYQ/JNA6cwqPZPyso6amNURGkhHEzXPC/y+Nmaw5hGHa31O/6BGQCEOQVOyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l0BwfwZiZ16cToY/k/d5V6m2aHASddgc+80nwla1HZE=;
 b=EEAvqWR3ZX0t9JyPP2abt/eZuqopFthh0Wfm9WfI0v6OEvyr+gQ1ZaNFIRdjmYHQmsTWj5gcA2QwAd0UZlItb6pNpc/SKIhomZLhW40XmVnnqn5ciIp1Ck2NPTU3lIUK8zTLd/sMCqFAcjSwhzpb7ALMCuDELT+7JUEw3r2CcwQFKgFeQBP+zYBA7NG7AwRW1y6oHoUTwha7DPAoLr82IbKnDSWk09a2QllRyXGzVbQJXf8x/ZUPJSTCUH9L1GgQ9rwT5hqs+a+BzqcpHF71ijV/Oc+w30AympBLTxG+p6NoD2+oayVKMBOFRT+zbLe0m2rt7HOL602+GwGDBpz8UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l0BwfwZiZ16cToY/k/d5V6m2aHASddgc+80nwla1HZE=;
 b=G/lxaHPkaEeeJvvKYWal3QbJkJaYiIMbEQAeKttxYP5nP+8mmy900NpTBx3D3+zsv5f/AcavIllXyDnGuBZzQnUjNi742otJeY3376Kzyc73TOvJpYwEJy8Hg/vlviQutDsqHzb2bvxaCDB/d8EOZRMUvdWELAhgOTKi5miSo08=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CY4PR12MB1639.namprd12.prod.outlook.com (2603:10b6:910:f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Mon, 21 Mar
 2022 08:47:53 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d%5]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 08:47:51 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdkfd: print unmap queue status for RAS poison
 consumption
Thread-Topic: [PATCH] drm/amdkfd: print unmap queue status for RAS poison
 consumption
Thread-Index: AQHYPPypaZLV2SSh2EOC0CO1EfAmqqzJhhSA
Date: Mon, 21 Mar 2022 08:47:51 +0000
Message-ID: <BN9PR12MB5257001E0AB74F75882F757EFC169@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220321082059.22573-1-tao.zhou1@amd.com>
In-Reply-To: <20220321082059.22573-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b4ee0b1f-46a6-4d3d-8a5b-78e1740a29d1;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-21T08:45:33Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a982877b-8c08-4c71-de88-08da0b177be7
x-ms-traffictypediagnostic: CY4PR12MB1639:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1639725510E7A692FDE3610CFC169@CY4PR12MB1639.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2EUI1/ri57dv2SZldTUKsGtMEh1VyzemuNmPmlQkMQg62MwVscLVoNDmoBmRnaDns3vpFLa5MqV+pR3DKAULNaRfFBozCgpKyXvTx6R+6C0C6+IRuENpIYPQuXwDIifUQRJ5mt14T2ePciIB01HSzd1uAuP1YgOLLsZnGKXOw9kPe7mqb7eoBmBYOGSsjSZFN7VS6U8Gki14YjRJTAkNokyFHFoBEaSTTe4mWr5Sgq0m8iZ8X1soa5KucYk3XlN3yL7H2o6/Z/KQw+nKpBQqWm9CHMLTBS2/xcHVm6hcYAaNgq59ujf3TQUE/DepFw4qSy5LsoryskMg7PBFO0Wd9XX6yIKIhQycG8CSaQqC3Vr9w3CKt8pZi/KK5PXJQkmeG680R2uSt8ZFZmarpi+usFS8N1YriGzmla4qSxJvkGnkhTZ6KmOCj759KdEQIuk2NwoLCo2Q7RJyG58jhdsoYP+KABchIZfLdhYNkZa3LwjgJN84BTxwgea0vX0VHPJZ9eSqw8zZ3mZfs/WHYfF0Ii2FZ/DUZX3wmEBXBZIswyOFaLOXyik2nvSXlHHosHgt7v7R/QCZYlIyY/Rc/6TWIidQY2YYgzsdyjVkYyrs7x+0HHpnXW2V4s//oED6Vk0n+0K4ivpQYwKMJnAKAj5i4yrSEu4/dwHiDFDsOku3bbNeakJYHbfMuWEOZJIWSc88Z9jfB7VB04N/FXaVBozxHg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66446008)(66476007)(66556008)(64756008)(76116006)(66946007)(83380400001)(122000001)(316002)(8676002)(53546011)(71200400001)(38070700005)(508600001)(7696005)(9686003)(6506007)(110136005)(38100700002)(186003)(26005)(6636002)(52536014)(86362001)(33656002)(2906002)(5660300002)(55016003)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mrom1GJGIqzzX93I8w1ST4oPaGAupVFCkr/OL8UsaWSdXNBtyCuVnqlpl6/D?=
 =?us-ascii?Q?ll/WExL1FKwmezUTo5g8i3Z1xmGcXmCdabZnNSNkfTDD95/0JpKBIHFnKEIl?=
 =?us-ascii?Q?35P8uDalhD24DIsKi1RHd4QwcpNcoV6G/UDPLhkLlwPndPXcZ5ShsIY9pAhB?=
 =?us-ascii?Q?AUypF71c1OrzVnEiUE1dk+MomBi5O/P2Ur6XkIZxwyrzqdDFIF45tY3v4xT4?=
 =?us-ascii?Q?K5HZFUxArXTzhxDJ7Fj2X/stywuILFiA/JZ4SuzK9sszsv0VpbCbWxaAtQDG?=
 =?us-ascii?Q?BmWFIGRhaswTnyvfVVMsbWN+9zgBPpwOCxtVsgu4Y+zumnZZK88LlDADH6lo?=
 =?us-ascii?Q?xrgbpVlbTFSQ7RYx2tHx7r37wrXvRJsKmgbgS+Tsh8xfHstTrF6A8mvsy1/x?=
 =?us-ascii?Q?ABBpIbq+9g9WWpoUQsHbksUq2K928Hz75MgYmtM13kKGcmEev1fXRXQECb01?=
 =?us-ascii?Q?ay3juQ5BKj78NPxM7unMaASKJBiUWk2xGjxene3uUJQVsuiMBWci6oTgCPVU?=
 =?us-ascii?Q?9SVtKF2e4EkF9h6ZqrCGEGfk/pV7tViGfoitAaY/A4wYLecfI0ysBht50dVF?=
 =?us-ascii?Q?6LRNJU9jqEJxKaVRe95BnN4MJ4dPXASQ788gra2O/Pd/M4i1Yk5NKAmav0se?=
 =?us-ascii?Q?Rvk8SeQv7AmPdWxpEa8RXHxFiHX/Gr942EzmZRH3QnVzAhPKsJwDtZLZnxDd?=
 =?us-ascii?Q?huHcKOZL9hR5EhIOwRTf+czJLUZow0ZtSEHP+yJ7O7U5w1rLf3ex6e0a8+Wt?=
 =?us-ascii?Q?ftgGQfVh37mGNiFPf2FFjIQD0Hyb+SI46JYYMfjXi46jYT0jsMLCrA1absoG?=
 =?us-ascii?Q?hd3foeWVBQPhNzevriLQaGHZ8i8mE3N3QdkUB9UqausUIJnmPMvwlZdvxZox?=
 =?us-ascii?Q?JACmdV7pb8tMk1waFdlB2WOQ2lEfxWzK2fmlZ4rDIdcTjfJ7Qb9BUMFj+XJN?=
 =?us-ascii?Q?vuWlQnAgTWHMGZpETcjVVd70kMszOVnqaLgZtXcaeBuhrh7Cs9pa3rapp7LZ?=
 =?us-ascii?Q?CIT43WO7hmOUuwsBn/YGawCvdYbA7Tm3BlOdU4HF52l4Ak2AmqH966GaZ87C?=
 =?us-ascii?Q?erysLcuI15sD9wxABiFb9g1xu6FvUXg9l1SEEgKSo46vtNcLK7Ad6lWREX3C?=
 =?us-ascii?Q?4mfcc1sgaNzCi5thzws/w5wACAOsnIU0TfLlRLDfe0q+k3kXNJaMY6FaqevP?=
 =?us-ascii?Q?05rTuwbvsYzTw/mg1qhX9eGfuEDAjeQ1sX97NYafUqnvUHJY6ZVzzZ2LACkB?=
 =?us-ascii?Q?dY0Ysp5ITsVH7T+aOhDvaNKLU8LzFHoTOwRCIFFucgTga1a440Yjh1ay+MLl?=
 =?us-ascii?Q?mWn/t4xZ0We98tHHSPilEyrHX96RIUsOFM9oYn/AXHvt7FNCAgNhqEjSbGZI?=
 =?us-ascii?Q?oxdTwdXoXqcYoXxq+FNO43nPqsTrRYpZgLLCwGqV7gt8NgdYtQLcjH/5a+1m?=
 =?us-ascii?Q?N9xya+PdEKudxcUZBa8dcBlB6SNYcY/1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a982877b-8c08-4c71-de88-08da0b177be7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2022 08:47:51.6355 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MwdvJPTcdoJMNQjY9hYtzl6bs/O1GrwRb3Dc96VawWhPVVPsyTlP84CEFhDoJXXGw+4pCPNgpL6ZTo3Btziklg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1639
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

[AMD Official Use Only]

Let's explicitly call out

RAS poison consumption, unmap queue flow succeed: client id %d\n

And

RAS poison consumption, fallback to gpu reset flow: client id %d\n

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Monday, March 21, 2022 16:21
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Kuehling, Felix <Felix.Kuehling@amd.com>; Yang, Stanley <Stanley.Yang@amd.c=
om>; Chai, Thomas <YiPeng.Chai@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH] drm/amdkfd: print unmap queue status for RAS poison consum=
ption

Print the status out when it passes, gpu reset message can be observed when=
 unmap queue fails.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c
index 56902b5bb7b6..c2560f468a04 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -105,8 +105,6 @@ static void event_interrupt_poison_consumption(struct k=
fd_dev *dev,
        if (old_poison)
                return;

-       pr_warn("RAS poison consumption handling: client id %d\n", client_i=
d);
-
        switch (client_id) {
        case SOC15_IH_CLIENTID_SE0SH:
        case SOC15_IH_CLIENTID_SE1SH:
@@ -130,10 +128,14 @@ static void event_interrupt_poison_consumption(struct=
 kfd_dev *dev,
        /* resetting queue passes, do page retirement without gpu reset
         * resetting queue fails, fallback to gpu reset solution
         */
-       if (!ret)
+       if (!ret) {
+               pr_warn("RAS poison consumption, unmap queue passes: client=
 id %d\n",
+                               client_id);
                amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, fal=
se);
-       else
+       } else {
+               pr_warn("RAS poison consumption: client id %d\n", client_id=
);
                amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, tru=
e);
+       }
 }

 static bool event_interrupt_isr_v9(struct kfd_dev *dev,
--
2.35.1


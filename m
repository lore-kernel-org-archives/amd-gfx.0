Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A1CC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Mar 2022 13:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E050810E5C5;
	Wed, 16 Mar 2022 13:48:53 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2081.outbound.protection.outlook.com [40.107.212.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF64910E5C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Mar 2022 13:48:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EK+VGp1SFIJIF6rF8TRetIyrGwqEiOvCkXz2bmmcY5uvUsjQalVCJO19Qny8TE1dWvKDdLK3EV+ppcCKtXjrUv7fDsEdn0c9IL/Akk7+auEg+TAPLKVktY14Y+3ElfPnaV5vtWKh2bgEd8xZw1jVgVwefpzXrqlrEFupPrZFmfiY9TWZDQRG7kS78P2cj7j3g3Zr4/On5dtgS8ZNQcdjB1Q5aeMnau+17VFrQQa/ouOaxE3KAod0mjdaLifqlzK9KMbsISLP22O0nDXfZW58b/5W/ug7597begK9vuV0jVvjn+3FNREEKg0g3DaiBV7zXQKUnbshdkyNioBMZ/7VOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bILxTn6Nffo6qolRlbC7iOBfM+PboH/7toSaDEgowio=;
 b=AeiNRmmiBYXYKMacsBe8vrsQeHbBQ8Tjb6rheOCBX9W6pIgUAEbbSv5lrsrrD6BlxEEtqoO8iNlIRhdihokKhHfuL9L+X/keE14aDoJaxwqQpFpiSc/WDaQ689uanOjW7CGf9E0D8h7TtccZtsp7jpPHXzliGHG8D0HgnwJsbiM5n3+r3a5MT2YS5OvjSNqELADFmJvJZWsAfu8B7ftMX3Xz7TAqDEMnuRamlmz6nmtuzUXVA8FGI5sBppmY4ghevb3N2j0EORGcw7UNKWR6/S76Ra8mSOWEJUxDB873MRewehzfVkL2q6bEj/ZZsHvrSll77d6IZzc4NEe47vAXeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bILxTn6Nffo6qolRlbC7iOBfM+PboH/7toSaDEgowio=;
 b=BoXI3yVbueQ5T6zYlV3qCz3+eXZCGxnY/tmg0PYEbm2ZVUn/QRVx2cJCyco8MThrTtbSp7WDOq60wxyvAt+rExVXc830bAPAhG9I8nTqY3BdkaUt6wTVtD9JAiXi/Pq5Cb49m7PYyLcc66EQEtPMe10YTQEI36T4gr0NRoaCkIU=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM6PR12MB2636.namprd12.prod.outlook.com (2603:10b6:5:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Wed, 16 Mar
 2022 13:48:48 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d%5]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 13:48:48 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 1/4] drm/amdkfd: refine event_interrupt_poison_consumption
Thread-Topic: [PATCH 1/4] drm/amdkfd: refine event_interrupt_poison_consumption
Thread-Index: AQHYORfxgvEzL4NrJEKMra7bojheAKzCBmDA
Date: Wed, 16 Mar 2022 13:48:48 +0000
Message-ID: <BN9PR12MB52570BD45B672A97C2AD6B3EFC119@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220316092627.17359-1-tao.zhou1@amd.com>
In-Reply-To: <20220316092627.17359-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=bb9d2b11-f295-4724-b35e-d9f89e75a8cf;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-16T13:46:47Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44ff220b-d778-44ec-5a61-08da0753b277
x-ms-traffictypediagnostic: DM6PR12MB2636:EE_
x-microsoft-antispam-prvs: <DM6PR12MB2636FF4C626DA29993110D68FC119@DM6PR12MB2636.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2NuxZYnGzWxiD4DbvYXAc4MldU5hTtPXFIuWWKM9vs1ZoyXeObEnGzOIz783BEFCbFPpOfNPGp0A0786D5PjD3mz4pgioONGy3HxK5AvCCb2V3AqIH24VBnyNlH+blRyxkfFVdbMlOnnGXHIc0bODrmgT0oip6fbmomx8ov+ODUo1fD4qvS60VkO2XCHU/YQS4Qg/fjapEtUm7DYbRunHWHr6mJ2qTfPZd3em4nD90RNWy2TzChLqakqwySnLxxi2MX8ASWCjPan4oDeYeuQ1jbJFw+b7UGT/1NVFU/QwQ8ihJAIJ8mnjDd8cHeO7o7gAXWGag//l1DA1GDJdiq5+B+WAd3SXPWdtEkY26Y67KLFyMq80OPCiv7rb/tLFn+bGM8S5g1B1yj0z7HGKk+4rzIEdJqC4JFRwPYCE+OOVNX0DW6jp+oSvQIwl2BQQNvkUiG7GPhFLT7VOk/AMjCZkMDuWyLRec/W0IGqGuXAjFYFTlXVuLp5XumfZcuy15PJq3IQmCNj8U0cyqhK12JrnCeRc0kfnDtCIVeqNfX9gfFezoDyZRpNo2H1MwRDTliMbAH/xK7mkaxdBD+sKsWOT2/HFMRBrIzU92iiYHCT6no/bGvfbq7kWaRvPKvWsdI7haNFBxVhHLlHgh3zGxxXlx60a1aVEO3rQ9pvuXqKk5fj5K2MXk2FPLpeuATbGtsHuezuWDoHZGw8oureN4VtWA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(9686003)(6506007)(508600001)(76116006)(110136005)(55016003)(7696005)(66446008)(33656002)(83380400001)(66476007)(64756008)(66556008)(66946007)(6636002)(8676002)(38070700005)(5660300002)(122000001)(2906002)(71200400001)(86362001)(8936002)(53546011)(52536014)(38100700002)(186003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UhFOZNazCBBIAifmafGezQU39fZMFeu7UGtZdLXGUXb4GoI+eocVNzqTW86j?=
 =?us-ascii?Q?z6K4fEpjZKcC2S0Vd22Y1q2vQuvTJddeLCfvpvds7NWnxiLMu4Ljzs0UDkQ/?=
 =?us-ascii?Q?d3oCqyw1o9GHYlcHazryXUbJ/YGuu91k0A1xJ6MocTLouC+wcW93QERoUXB1?=
 =?us-ascii?Q?eQYGR8RUfJiGngW/knR4WoM5D/0jENpJLfpHbdfThYQ30BL82hBFXo3r1jPk?=
 =?us-ascii?Q?8/q5oIPSJrcgthfSWnW5jhGiMlBMcUBR0oKtP5jticchmpzyNYgS0DqSJE4x?=
 =?us-ascii?Q?/BWpbvf5sWdNBWBWCCMCsh48AWebQIy5nEFNBriMJOIiCt3M8ILfHhxQgjcR?=
 =?us-ascii?Q?SRdmlc5K8BfZaxjWZmb7sLRwtXhLXcEyOMBWeRSQAT1gsQayaLsLS2PVwRFJ?=
 =?us-ascii?Q?5qdDctfh8niu+u9xJImAUVvV2NufsShpCzW1aQOoAdVSnXfksy4xje7wvRsN?=
 =?us-ascii?Q?i8uyJCfCbf2DXvBfbMDHHwJAobdE9n7/AF4j7MvJzdzmSZrDcHck0Ycu80Jj?=
 =?us-ascii?Q?kk+O8Ou1d1uG/e9UJm/wq+DVwaqkx8M3e3q3c/blAn2F8mxbkv8aJghSvg3m?=
 =?us-ascii?Q?7FyeSSVfqYeiLl4TViD/vlN54J45ZuElIgzP0UgwlQBBaLOrNDB3+XpR37eS?=
 =?us-ascii?Q?bBJxQV+y1hOnp8gzlFOiTCFyhiH/9aNPx9Ijui7NbrHXTwUILgiSqZOcAy9G?=
 =?us-ascii?Q?wg/dvZF9CPr/FtZl1/yZ6pTCRPR4xIyLzTWbutKmi73RD8YXZYTehaKvNIlj?=
 =?us-ascii?Q?Tq41VYAQ0uwK8CqscZFN802nGKCNUrPACwgjGHfYb59zEhmj+0qb/Z5SHaSM?=
 =?us-ascii?Q?vgSQSm5EGpHRRqK5sRQ/P0QAC/zdgMhrJomB3V65onFEn0cZnJl3SkN9t27y?=
 =?us-ascii?Q?YFNykoKGcE9JRfspTab6/BeZF40jwg1OQwDOGs5SYnRGM3DazCwEbGo+IVGj?=
 =?us-ascii?Q?Spt+08VJmjB3AkmntUP4SQb14jQpevvmS0RrdtMkAvevOdiT671qKPTUeWjV?=
 =?us-ascii?Q?DAZi5zv3eVhAmJy0KDlhGYR0nqpVnetZ3GGeYQgjcjqW6KX4SiK31tU0lEJc?=
 =?us-ascii?Q?Ikf+3pSOh76mRmmBrw+pPsrt6bHa+NtXZBlEZf1f/LiWbvTWtMsyBoACljOf?=
 =?us-ascii?Q?CVJyrR/vK/KlZspJmijz6TRd5ij6Mv+YAg5AVeSwVokLD/4/fCZVWFz8RP68?=
 =?us-ascii?Q?xestLArt5o/ByAbfdGeM1s/KlpQZgwksDVICNC5I8gjrd0+7p4P/BpQ8zxQQ?=
 =?us-ascii?Q?OGJdGAwCY2CiqR5gx/jcZXC51rOJS5ZXDNipM6qVgPnImL/mOlZlI3KPOW1Y?=
 =?us-ascii?Q?6pSIQbqVzbA+NA4kIbfJ4D2qxIml0HthHSBJN9r7KLqJcOt2UQXS/JQnt6t1?=
 =?us-ascii?Q?t0SloPhRPQYcuZuo8Ui4sttkzZkpEXO6AWnHE9Pl1+LihoRahWgmQc82LP7n?=
 =?us-ascii?Q?APpg6bJJIh7Z9/jiBgHAE7v8JmvYk6PE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ff220b-d778-44ec-5a61-08da0753b277
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 13:48:48.1693 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mpsrdaG7wOXqJWbcnTlFMixf1n7FpIXH5n+8+clDuBQv+q/7syv4p90d/5m5aFhLkNGiDYIK2WqA2/FpaLZFHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2636
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

+       pr_warn("RAS poison consumption handling\n");

Given you already print out this, might be better add some more information=
 to help identify which blocks issued this poison consumption interrupt. e.=
g. add client_id or source_id

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Wednesday, March 16, 2022 17:26
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Kuehling, Felix <Felix.Kuehling@amd.com>; Yang, Stanley <Stanley.Yang@amd.c=
om>; Chai, Thomas <YiPeng.Chai@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 1/4] drm/amdkfd: refine event_interrupt_poison_consumption

Combine reading and setting poison flag as one atomic operation and add pri=
nt message for the function.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_int_process_v9.c
index 7eedbcd14828..a992798ff8b6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -93,20 +93,19 @@ enum SQ_INTERRUPT_ERROR_TYPE {  static void event_inter=
rupt_poison_consumption(struct kfd_dev *dev,
                                uint16_t pasid, uint16_t source_id)  {
-       int ret =3D -EINVAL;
+       int old_poison, ret =3D -EINVAL;
        struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);

        if (!p)
                return;

        /* all queues of a process will be unmapped in one time */
-       if (atomic_read(&p->poison)) {
-               kfd_unref_process(p);
+       old_poison =3D atomic_cmpxchg(&p->poison, 0, 1);
+       kfd_unref_process(p);
+       if (old_poison)
                return;
-       }

-       atomic_set(&p->poison, 1);
-       kfd_unref_process(p);
+       pr_warn("RAS poison consumption handling\n");

        switch (source_id) {
        case SOC15_INTSRC_SQ_INTERRUPT_MSG:
--
2.35.1


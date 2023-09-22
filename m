Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD95E6FE3D
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Sep 2023 14:37:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4C7D10E680;
	Fri, 22 Sep 2023 14:37:12 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E5EB10E68A
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Sep 2023 14:37:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFiuC6op/zkNdPRpvL4SKhoH+buoknTaEEM1OqkjqHgptqdNQp2BKXwvoo7jFl9IHrxuKGFbM4X6hN4INxK1zixz/w9+bKsseLCKu4TRbS4Q6zlYfGTuL/khIlYjuGsSsTvScH3d9H4yJ3EVYFOopz0A5t+Ue1poHWI3YnQIjDCqBVBjjGWClDJfLHyjRc5MCgROKgEdHVoQVjwY99/BjzzDfGQtv5GUj41Ezks3gVOo/AXNxB7SJ1rMXSkTiTz/wblMOWwSdJqTe4JSB0I0We1cPrPJoBOYq1B23WvZd8MYyghLsnABsa1xkbCpKK1WAy4a++D0GHwDW4LVp7fE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+oo0oZorsf2OCEimZ/S4XMCEBWHEQTmS1c7qG7nnU4=;
 b=iv+rYqOe4Vtv8xvM1fRll+zesw1uFlHhKVACcUYCFffHWaDaogMVNy/gzWs1g5BP3YtUqAIPoxOVgTN8i/G/ngURi+o21yTGrXK2hS5Rw/7HeoJ7yQXLBNRuNqUs5jSQbccjMtBuphIxxP3kQMt8t2HufgKqJ3/RCqU7DWLiXPBVENFsjc9HkkwaSu3b3/0pPN7QXvkZBYOTeSNJk5Uh9d4Zgcnik3Ly+cCkz5Rt9UP1UV7jKs1xLf/f3pvbxHyIEhXCn/DxAumpg1BVRmTLwwcSaEzjmHPj/8/dYRyxFIqy/qG2lHsUn86Vk5ErxN2IYiOoDiyKAxvU1s2VmnPMxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+oo0oZorsf2OCEimZ/S4XMCEBWHEQTmS1c7qG7nnU4=;
 b=XDbim3BJyzMg57AZBCdcB7+cwnpvS5A/Dxk1rrYFUhL9WX2Ft8iBJHbBJIvSWDs6d0lLZVdAWPU1N9HuuxPEWDhAhBhCeNidvmURE4dn55QtBC6o7Dixm3t/lfmz9QCXCbnNC+ZAW6xe6PAiKRqwmfSyeBWyjePy0co3Vp0mndI=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 14:37:02 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::6017:888c:bd65:cc08]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::6017:888c:bd65:cc08%4]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 14:37:01 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Wu, David" <David.Wu3@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: not to save bo in the case of RAS
 err_event_athub
Thread-Topic: [PATCH] drm/amdgpu: not to save bo in the case of RAS
 err_event_athub
Thread-Index: AQHZ7MBzDAcr/plcqE2MFkht51RBv7Am6tbw
Date: Fri, 22 Sep 2023 14:37:01 +0000
Message-ID: <DM8PR12MB5399E5B5DD9EA827EE32AE67E5FFA@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20230921191825.528262-1-David.Wu3@amd.com>
In-Reply-To: <20230921191825.528262-1-David.Wu3@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ef43b5e5-4e8d-4654-8ddf-c96eb1474fac;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-22T14:36:27Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|SN7PR12MB7321:EE_
x-ms-office365-filtering-correlation-id: 2deb3ba1-da52-47b8-2687-08dbbb796252
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1oDOer7RpapZqkO1RlzMSsLvY9RDy0fpHwmL2wK5p7aBs/XTqqKBbq0034BvdmeEnEzqi/wzAu57EPh3+m5Ym3lo6LwaDBEWRYVNOa/5l+Vfj7/gaoFXaH6xHQZkYv8r1u/l2PZ0WCf0K+0uI2df13sDxx4+NXt+hmEGDidcqOSmrlNqqw7qDrCsIqY1xKIn2/AXR3d8uygQRkuRRss/HZ3on/1tHZwBHtehurPdV3HcDWpvWhPT9GpMaRYJZwFx1YOP5QAYVkNAAN6kaoNichWd5WXbpRxoyoh6miMIOWJpKxalW371kbvVAs5jT5tF/cj8cYuSUp+Ml75NXXIUYkpnc6RAdTBNZt+hwHNOsEGySJSvSwn2OEmGEGkUT/OokhXJtQyD7WR39FryVpxNdVTcJk+nygYafRtil0VWQGLGsSGJY46AC6T5n5toXNEPbzERLyJTmQ1kEH6FItTbTlZSyIWWvN8ICViumEtXPebq1pTo4SByvrzZh8JOkAMP38tcdqHiSODWkoiTfvePk9fupOd7GG9MgaP/XhJlHZBxJEKU0C4utvgC12gxCnzp1g6+7k4+2+HiiLXrwlGvybHk8iO8vC5ww0Lioh6GWGkDoGOKjCIRP0VkZKiXxvcg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(186009)(451199024)(1800799009)(55016003)(478600001)(33656002)(86362001)(41300700001)(5660300002)(110136005)(52536014)(38100700002)(8676002)(38070700005)(2906002)(8936002)(4326008)(76116006)(64756008)(54906003)(66946007)(66556008)(66446008)(316002)(66476007)(71200400001)(122000001)(83380400001)(53546011)(7696005)(26005)(6506007)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jK3b4AFxfl6dopZOwEFX7ZOv0bG9xZrGiStsG5TIz5Vy/JZNYq5VwJovEJtI?=
 =?us-ascii?Q?IhMJ8z3gnIpsfqoLfRwkhxMsTnp9rRsZT1DCW4KrpZTxiQlR0/kThuIMSFUe?=
 =?us-ascii?Q?fFoF8/L0xko2VXYAfQlmxMNgbC7yPvPdNaxSPpGxCKMr8IB7VApPzpz/DTwv?=
 =?us-ascii?Q?NErjbaa+gEdJLbzd/xcOsvOZeNlOG2SiAH6GYjFWeXaQNUxABjD1md4Fz8tM?=
 =?us-ascii?Q?bWMVluQlvARh1GYweLLFV+D/USCEqbxTuONSaODLaqSPBewxKBy80ujyAEsa?=
 =?us-ascii?Q?lq5vZsFLD+ZGiXSwOBpFwzlKU+sk07QeDiVKLwaVKtfZLaDSyXpZFFeRJqzM?=
 =?us-ascii?Q?2VP5JX0FXpQrJ4Z4I/qO96/L+0RSh54J9pdKRnFJNyqmtbbiOnV00pM1wCe1?=
 =?us-ascii?Q?hbhxmYvuaUNdxEIQmPkbGIq1pi8dxmmNqlHBp+xdwujWrvZmpxFmTCm8CB61?=
 =?us-ascii?Q?iZs6cT7Gf2XyYZz8M8mkZxFUrRvWOTxzmgpaV4LFRGO2jqy+2SuR/Wh+agA+?=
 =?us-ascii?Q?lH2uocn/1HNq4ZL/Cy3c5RNkfm4FCNF7pUKEj/WJE8gbo1FTe51lQ/RTUKjd?=
 =?us-ascii?Q?h9oy3WipuH7BXTbKId6Vm3xq5OrOn2papH54KmFrujWzOCrdgpGdKjqYktTm?=
 =?us-ascii?Q?PHDmuGrFJnbTMOm3ODHN9yiuvT+O9vaKk3tVkxPviEiOrOBPv6psSsiGcFJU?=
 =?us-ascii?Q?NInRmNdcLteuPPFgjBALMyOFSpWl4b8W8r1hZQwgGd0WbhdIP7Nz55kboW9D?=
 =?us-ascii?Q?PUhstskOyDT9l+B8F6fDq1ZtB2h16RRRKI5j8XzddvxWTmxdQcmpNAXtQsud?=
 =?us-ascii?Q?rtD25SpTSBl+RFw6Pk6Kc/zPyLBA+rr7w7rMzHmLbDQmNSx5uGmEqLZLf9sH?=
 =?us-ascii?Q?PMbNfnRM96Hu3jrX2tG/K/NWzjfa866hlMCHrSJThZoKsIsJ4npsOfloPwBd?=
 =?us-ascii?Q?66PgEE1EcJVGpcGwMZ/zl5OwvxuV6rlLT7lIz3ep2/2hi59mDQl++q9bk5fT?=
 =?us-ascii?Q?ShiEjDvy9g6NY4/c8ln0SIrPHFeFW0vVTBo3jwMoYpmSXCGpslzzpemyuMHH?=
 =?us-ascii?Q?rDZkimAGNQC+5mF81CE0b1ku23Y1/PFvUqLK9rUtS81hYSl+dSW6TXvzZvMi?=
 =?us-ascii?Q?qK6cGvAowwXMl3f5AUskrpePsXsNjwXsyaZXgaYU4RsMi0z9IRIECIh6xfoR?=
 =?us-ascii?Q?PVeF7paXdrDTUxy7f1cT402MHMrfambjW4YqZZKjqggiSNvbNPOghIZzRLw2?=
 =?us-ascii?Q?SAMprE48ZrDbTNasb9CQZSQnzRO1ZJpEGsKWaM7WS066VpT5KFrP7JF6Ph5P?=
 =?us-ascii?Q?dF2RmMSrbeyFGzyN8L3gueUQjP2LDmrhy0s6CgSy9zD6/46KMNaUKPdFz6t0?=
 =?us-ascii?Q?iw+o4k1668Kozo4ULQsf+ZWfnZDnrDXmTCSE9fGwOM6WMtYt9eT4z35NH/pb?=
 =?us-ascii?Q?4ruKcANRYJO3PjphMilhtzqD9/G9Jh/lLFp4f6R2wUhLeKtVCjAP+KP5boRw?=
 =?us-ascii?Q?nwKboZPJQh/39gEA7f3j8RsWWWApUcLwWPkHbQZ78Zb4La+jq0NyPG22904h?=
 =?us-ascii?Q?blUB2aHPQdOAEG/tmDs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2deb3ba1-da52-47b8-2687-08dbbb796252
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 14:37:01.7879 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: szRulbHonw80M6ntBbsMjLTRAXKkXYLjeGyZsF6kzmWvq0RgwsG8CA2pz6qH8/h3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7321
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Acked-by: Leo Liu <leo.liu@amd.com>

-----Original Message-----
From: Wu, David <David.Wu3@amd.com>
Sent: Thursday, September 21, 2023 3:18 PM
To: amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>; Liu, Leo <Leo.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: not to save bo in the case of RAS err_event_at=
hub

err_event_athub will corrupt VCPU buffer and not good to be restored in amd=
gpu_vcn_resume() and in this case the VCPU buffer needs to be cleared for V=
CN firmware to work properly.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.c
index c93f3a4c0e31..f4963330c772 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -294,8 +294,15 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
        void *ptr;
        int i, idx;

+       bool in_ras_intr =3D amdgpu_ras_intr_triggered();
+
        cancel_delayed_work_sync(&adev->vcn.idle_work);

+       /* err_event_athub will corrupt VCPU buffer, so we need to
+        * restore fw data and clear buffer in amdgpu_vcn_resume() */
+       if (in_ras_intr)
+               return 0;
+
        for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
                if (adev->vcn.harvest_config & (1 << i))
                        continue;
--
2.34.1


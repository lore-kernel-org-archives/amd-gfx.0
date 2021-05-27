Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B15C4707F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 08:13:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8457161077
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 08:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8457161077
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 175696EE35;
	Thu, 27 May 2021 08:13:27 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2065.outbound.protection.outlook.com [40.107.100.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5314C6EE35
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 08:13:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXbZ4PknnX5gMULW6vdTtJsF6EDULaCTpUPSz+N7RH1IAhqOPMgFdTvBQtv+x2sNmjpFOKWKaHaKg/zO3qA8UBmde8KjVgIky7E2ckeqZ4OF1bhySrECsyZsks9IqETjBzjcSaGuiBZKSTASV045mtgN2TMY8V3E+fMcG+jR/dg2ll3leVtM+IWT4LFCPv81gWRsguB2OSu4b6Z8NZMaFB21kyf25UqbPNgnJkpkaoNeMarWb3HLu3gVT5f8udVMDPf+IlhUGYMGdTlNyldKWDImIOHBS2NTBDmLOJRRyB6e+goZ+9YiR/8N1l1CT7L4SF6JlOQkrHDa+gX5npvR+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSouySPjwhcm5gdYVpZFionhvYEMrJO5AFQWebNom/k=;
 b=aTYoA/U5oQFQRrZehCIh1IzT8IKagICF0qBZCP8aq5hVqOYG7WItbXEHfZNp8nVzOQguFLjO+VwDqh8yfvx5iG5w38slg6NVy7tzXV/npswgzqGl5KpD4gF74hzSMJug6oh1t16zmyRhbfGVlHb2qi3z1x0WxvnAmUrOFiFNDr/yGTUU8VyHLkB6sLe3AnpnDNCBiqWzhWhHC7wLsR/ovUdl5YToFq08PexY0XRlnWI0Gf2gJmWuPdNpHJ59Dy4YuCAf+mzdIFfQ60IrEGbHmXEQlGYxjLAC4PQEvLQOXdaRwU6QBjPCjNXkoc1QPlfW0jMujROlL0TURpyRzQwJSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSouySPjwhcm5gdYVpZFionhvYEMrJO5AFQWebNom/k=;
 b=4+FrrTrkhYhdP/8o7fkXnRGftRXhHFix8+YHVJ7/vwZ5hvr0p8q+Eo9RgEs+o6KiDpJa3YY5frz+Joi18pajup8+Md0Cezi0WK07F6s5vrvQmkVpqpEzFY1RZ889f+fSDBIzu1zDs+BQWGBs+HX/US2tJQl8KfcnjACWoydQfb4=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by BL1PR12MB5141.namprd12.prod.outlook.com (2603:10b6:208:309::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 27 May
 2021 08:13:22 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::5887:386c:6b8c:ca8e]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::5887:386c:6b8c:ca8e%6]) with mapi id 15.20.4173.022; Thu, 27 May 2021
 08:13:22 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCHv2] drm/amd/amdgpu:save psp ring wptr to avoid attack
Thread-Topic: [PATCHv2] drm/amd/amdgpu:save psp ring wptr to avoid attack
Thread-Index: AQHXUgKytfwKUCIxPUava/Cl764I46r2/DNw
Date: Thu, 27 May 2021 08:13:22 +0000
Message-ID: <BL1PR12MB5269791759922580A38FA0B484239@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <20210526074055.30733-1-Jingwen.Chen2@amd.com>
In-Reply-To: <20210526074055.30733-1-Jingwen.Chen2@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-27T08:13:20Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=501a1ec4-b853-4e06-b3f3-6da11eb09c55;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbd4c3c9-b28b-47bd-bf5b-08d920e74bb3
x-ms-traffictypediagnostic: BL1PR12MB5141:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5141A632387F3C871805706C84239@BL1PR12MB5141.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7zz86QH7COjMaiR3Z2C7S4WBR/a7TqDnCAK77Js84e5SlifxJ0Q3x3fFJ+9ZKkrQT+Ci3dWsaXkxfbonvKSkntg1Y8TqfCdthwBTpC60vj9Q9nONExIzr8+I2KX4pbqErOKGd5poqBRXqYKjkVsQCD75bmsI5blRUZ6iC0AAkk18GdvdenNm2wPytldz6SAK5mLDggePsCHu2PcT3C5grSBgUkWmw8dA/xnnzbMA9QNPRhBgd8XUVqlviYhuOfCtJ1Mhtlgg0zmdT++vaqA2KrhGCH6MwJ5wfN8wB4/C+0JDwg0vrWtsNY2TvQWEN4fKDgwWQDVJoOu+Md0+sccNUMhTWr5N8BSgBy7ONMJErdy2TY60E2xMUPd5f6LCvv3b1yclZJApPsqu0S72G6GAjRP4iPJcHMLd4McecdnFfaFsXLOnkn8RgWuY7DQZDIa8xCmpdsLoYOl+gmqAdE0GJLaWTXihUy5nfZaSoPO50zAdJ+T8ynVDFMC8buk7ckn/8B1Ae3HH8bgEKKOQhjmY0mnslD/n7g2KIoL++hILC26XiwPQievon2cizB+BEsj0D70PuQBlF76a4rgs8G1hD4wVBDK8iwRx4603G9jsiGs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(26005)(8676002)(8936002)(7696005)(122000001)(38100700002)(478600001)(9686003)(86362001)(54906003)(33656002)(316002)(4326008)(55016002)(66556008)(71200400001)(83380400001)(2906002)(64756008)(53546011)(52536014)(6506007)(186003)(5660300002)(66446008)(66476007)(76116006)(110136005)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?KzIjcvJptbzZuQKPjvFolJE/eC+Ao//jUpKBwKfPt0vF0Q34JQeIAHlaM3FT?=
 =?us-ascii?Q?3EIADcxgRgR21I5RWpx3LvyIItQbp/578FB2W+EMVRXTS6igxTGzhD4L8El/?=
 =?us-ascii?Q?Mdm2pWpmwApdzbcmkrH4yFj32Zz0l46G7N5yt0Ao644osyL+PpofmZ4oX+ZU?=
 =?us-ascii?Q?c58zzX9h9Tdcbf/y38WjN5A1npXLA13hsOSgCMJY6DfiPRcMzqPGG1qf27GM?=
 =?us-ascii?Q?+xAmzSVpn8ba90EnPx2ywXRlc8dOXgnuU5z7dT62HyfLzlPKj/ixOSar777d?=
 =?us-ascii?Q?rpoI3iw7rf8T4Zq2aBGZzv7pcFw1sLL0S6TiLiQhhmmrTXjOlVyteclm/GGn?=
 =?us-ascii?Q?ROrCl28zluBr+74tBbIFkBubHHla/4XieS/5bAVg8tJs3NeUOpBBmrPGdtL/?=
 =?us-ascii?Q?qgSY4S6BfMiRMfXl/LAPmGEf25Eed61FjTY7N6bNLOaiBsefuWLXpwrOcs8I?=
 =?us-ascii?Q?wPn9YsuJ4CFQ9w0NoZGpSllNvS6XqrU78xRmpdOCh6C4q1q6bbhURfROFsUm?=
 =?us-ascii?Q?L4JubpjrJJdjsTHauSDS7iK6sXo3iNdfTcCNmgw0D/b8alKQ2cbTYpOb6wj2?=
 =?us-ascii?Q?spEbfJ3woiL2QubbxqX4J94Aw7E7g5/Di6gQ93cQPtMWon505WexbNppjyAc?=
 =?us-ascii?Q?Ln6mRn2oSCKOv9Ht8pTXEHUH9NFIagUTkJ3ZYWojIbCBPqs1Z1K5eaJmhZXd?=
 =?us-ascii?Q?cMDVmWgrw340mX+PgCMJo7YQqnUg28+T1XpdOUp3rY+ZhVwgRAs85litOBiM?=
 =?us-ascii?Q?55qOFwzLeFfkwKvZRracQxIji/h0GjHQZkXzyYk7qWUtfmEH4vEH78jheEgb?=
 =?us-ascii?Q?40OnDgKNCj4ddU/sGW47jAKtwEQWxHH+/o9lMyMDWlxkZ7ZjRMUY6Yqzu4C9?=
 =?us-ascii?Q?tsF8Iqp2mmLEnMOa1ViXxtdaGj3yZGfYntgC0CsHbeXTosCXRufKSy0/7d65?=
 =?us-ascii?Q?2w591hkGAk4+ygMIIfsKxVwPoLb0EBN7DVmsp7nJUkoVOrsNSG3aSOH3PAoC?=
 =?us-ascii?Q?FFvpJe0bXcglByOZCqraX/HWeQMki9sC82YSIF0nrcayyU3fx1w+ZS79kgOQ?=
 =?us-ascii?Q?/gSLZwK0pD8QNdwkiAxTr9LzkEpMI7Ix+HtHBTqW6gGN8j2e9zBRS56FByWG?=
 =?us-ascii?Q?JV39PRXbR+aihBh/WRAy5KhQ05bhrv7zyv+4nJk4AKKLNYfizs9v4XPFrVBw?=
 =?us-ascii?Q?/Dg98rIbBmjKw2YDkBC+kebo7MhGp2ATMNburMpKFF8WCuuRqS2oTeMF7QSo?=
 =?us-ascii?Q?MAsSHkUPEKl02r99XRHgA3C9oGTO+erNWBocUVK9rTOtkZvKVnjFUt1R004F?=
 =?us-ascii?Q?RZ209LtfNcCo79f9eI2cytiP?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd4c3c9-b28b-47bd-bf5b-08d920e74bb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 08:13:22.8773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0cs0NFMJVJ896sCjxQEu89LvkTP+yZ5Qkbku4yUTgarF2i976m/PJJxMMMFBApFn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5141
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
Cc: "Chen, JingWen" <JingWen.Chen2@amd.com>, "Zhao,
 Victor" <Victor.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Monk Liu <monk.liu@amd.com>

Thanks 

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: Jingwen Chen <Jingwen.Chen2@amd.com> 
Sent: Wednesday, May 26, 2021 3:41 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>
Subject: [PATCHv2] drm/amd/amdgpu:save psp ring wptr to avoid attack

From: Victor Zhao <Victor.Zhao@amd.com>

[Why]
When some tools performing psp mailbox attack, the readback value of register can be a random value which may break psp.

[How]
Use a psp wptr cache machanism to aovid the change made by attack.

v2: unify change and add detailed reason

Change-Id: Idee78e8c1c781463048f2f6311fdc70488ef05b2
Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 1 +  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 3 ++-
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c   | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 46a5328e00e0..60aa99a39a74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -76,6 +76,7 @@ struct psp_ring
 	uint64_t			ring_mem_mc_addr;
 	void				*ring_mem_handle;
 	uint32_t			ring_size;
+	uint32_t			ring_wptr;
 };
 
 /* More registers may will be supported */ diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 1f2e7e35c91e..0fd1ed918627 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -733,7 +733,7 @@ static uint32_t psp_v11_0_ring_get_wptr(struct psp_context *psp)
 	struct amdgpu_device *adev = psp->adev;
 
 	if (amdgpu_sriov_vf(adev))
-		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102);
+		data = psp->km_ring.ring_wptr;
 	else
 		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67);
 
@@ -747,6 +747,7 @@ static void psp_v11_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
 	if (amdgpu_sriov_vf(adev)) {
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102, value);
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_101, GFX_CTRL_CMD_ID_CONSUME_CMD);
+		psp->km_ring.ring_wptr = value;
 	} else
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67, value);  } diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
index f2e725f72d2f..908664a5774b 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -379,7 +379,7 @@ static uint32_t psp_v3_1_ring_get_wptr(struct psp_context *psp)
 	struct amdgpu_device *adev = psp->adev;
 
 	if (amdgpu_sriov_vf(adev))
-		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102);
+		data = psp->km_ring.ring_wptr;
 	else
 		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67);
 	return data;
@@ -394,6 +394,7 @@ static void psp_v3_1_ring_set_wptr(struct psp_context *psp, uint32_t value)
 		/* send interrupt to PSP for SRIOV ring write pointer update */
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_101,
 			GFX_CTRL_CMD_ID_CONSUME_CMD);
+		psp->km_ring.ring_wptr = value;
 	} else
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67, value);  }
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

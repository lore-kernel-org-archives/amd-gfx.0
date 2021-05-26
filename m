Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28576C2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 07:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDBEE61429
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 07:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDBEE61429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86B2B6EC1D;
	Wed, 26 May 2021 07:43:48 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E4CD6EC1D
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 07:43:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wq6KSaN6mO8P/PdTNDDm6U+5JBh5U6Gn/Hi5Ytpfershevvq1s+Ruj4iBFoPdQLoXN7oQMCC4Cr1z6GDOyzwAjasbvBDnwSb7HFZHkSytiO36tsTQLpKGZfUjDH3anFdbjytE2+yQiEB/RZaQPrOyD1CGxv0QrMSf/CmGNSnLX5jr4yie1Qowmgsu21kjilpU6xdvlt7lGEoFy8xWwnFreI39qD0YQBDoeSVFPCyrREosVGadkn3JBEiUVy4tx+dNEPoGNTQrIJoci7XBISj3wJPFj17mKpep/9fkt3tMNSCqKN9YSrgye7Ffi96NHHv0rvKPQxHFcGmfsjhFwbd1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkJgRS/BTfnWJJ///yLfPVFth4lvbtDo5LY4J5zRazg=;
 b=aE7KfjGbO4ieTLDzq2ZMWnLO7ug3GWIQvNBoNJHIgnL402O4TkqSZiOA0X9UiemLp6fydZMbYkYtB3bOjwzMJH2N4Ntbjv8oTJKBg4QoDxTQx58S6QrX7RyJKOymcur4gBWbJ0KIF2GlIwCylIWV8g/jRtdOrsSOK0AnsodQ/gr7o0P1y/kHl5Nn0WIG8F291YPcX+5bCwi6uDr1F+9JVoMTzYKygw0U6kxXalEasqrX0RPEEPav7+BeCWC1vOwnGjdk3b3rP0Ce+/roWZqM9FNHFtF9wfX7rJxowAkdrsO5W619d6mIVjF6RbloGUs/BdN4gsrsEWv+SHnoHwPlmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkJgRS/BTfnWJJ///yLfPVFth4lvbtDo5LY4J5zRazg=;
 b=pExbfTdln/rVLHlylag9c7K7g1FuG4KPDAg3SuQnSbLEG9r/FOny8I5WqcwgyxaxkrMg84MOLAa5ws2i87QgwgHLnLwmzaGj7fq2phRLjUAv0Q96zhvKL3mQN4+68+O3coKFyonM5IHh20pdOxw3DIfLNgbdQ2DJVeH+ITUrFnU=
Received: from BN6PR12MB1267.namprd12.prod.outlook.com (2603:10b6:404:17::13)
 by BN6PR12MB1716.namprd12.prod.outlook.com (2603:10b6:404:104::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Wed, 26 May
 2021 07:43:43 +0000
Received: from BN6PR12MB1267.namprd12.prod.outlook.com
 ([fe80::64a7:42d4:a452:807]) by BN6PR12MB1267.namprd12.prod.outlook.com
 ([fe80::64a7:42d4:a452:807%12]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 07:43:43 +0000
From: "Chen, JingWen" <JingWen.Chen2@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu:save psp ring wptr in SRIOV to avoid attack
Thread-Topic: [PATCH] drm/amd/amdgpu:save psp ring wptr in SRIOV to avoid
 attack
Thread-Index: AQHXUfwYjbSp9NwqHESEgt7dtHflGar1XDsAgAAFR8A=
Date: Wed, 26 May 2021 07:43:43 +0000
Message-ID: <BN6PR12MB1267FC3EC1B7B92BFBBEED3CB7249@BN6PR12MB1267.namprd12.prod.outlook.com>
References: <20210526065459.26368-1-Jingwen.Chen2@amd.com>
 <BL1PR12MB52699DD281EF5DF4A1BB066884249@BL1PR12MB5269.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB52699DD281EF5DF4A1BB066884249@BL1PR12MB5269.namprd12.prod.outlook.com>
Accept-Language: en-150, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-26T07:24:00Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=8cd4f70b-726f-4252-b46d-b5286f3aab5f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8838628b-ae0f-4945-f304-08d92019fc8e
x-ms-traffictypediagnostic: BN6PR12MB1716:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB17169F36B1B50A5D5BE4A565B7249@BN6PR12MB1716.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m5PbtSsIdHdESE1pOtM/D1unRfdRljrx3qmHDFG9RwdGA+XV3fVuxZoNJLHhqUEACFZh4vuiTxKbVXQ86rtKArIcigCrkdaHdHMaxttwseqNMS13T9X17AyiLXCnTCy27sRi0E7F2IHmgXWzWyj0GPx/Zv72vyn34xG+wd7LDv9pWqLsDr5CNV26iruu9uvQ+YKvKtkiJcreAdd0HU9qNyMFezLb5RtCv29jbXkVG90mbpaf9R+8fjzyOpWx7FV8STePd3/9ZZ4UE9lxyWQsFp57XHSluu3XF3daq6banrRMRlpJiOXPetf8zukzP2ZqRkXvEOEuBXL6BCcjgXpaSB5TWTL2QPKdcPxEPIY7aBkRmIzBYr5MmoXt9X9/nnLZGmVInx1UrsAptbVMXjH9w5jZskh3F1FqM5miZB3EC1NWYD/AAO3xhOEMJyfZsol0rh5bnXYjxJy03a7jLqHklNWbx1dNvzlckPk/D8POsjWZFwXnb651rKHG5Nvqbc6tNo2jG6bm9ZT5pl4QoLIIwKHxu93hAujuVZqGocwzIfBJ5pDz1b0VjSgCsREm1jfoT9ZNqlcv45gRbIs3LxlNB0Wm6PGkQZ0D+rh0wBmYL7o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1267.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(71200400001)(6506007)(53546011)(316002)(4326008)(110136005)(122000001)(478600001)(8676002)(26005)(9686003)(5660300002)(83380400001)(55016002)(2906002)(8936002)(86362001)(76116006)(66476007)(66446008)(66556008)(64756008)(33656002)(52536014)(38100700002)(7696005)(66946007)(186003)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?c0Y+Mr/wAvHzxEv8aVhDnyOsaH26l4gkYPmRvrFo+kDBRiAY21hv1Q0/B76p?=
 =?us-ascii?Q?CyCia9HQxTroEhCageC4/KaISUW+cAoTtAHcvCTPy0Yqjg0kYst/ID54YY9o?=
 =?us-ascii?Q?XoyUMGCdgWQmhFAnVBJDZu7hhehPRIU+f9K23fS4mtGvVJt9Gv8oaF7DlEP2?=
 =?us-ascii?Q?jgGgPfMO98XdVj5jL+qb4QAgtuLoyZvOpIOb7B+FS0qQSt9LwQCbs003sPDT?=
 =?us-ascii?Q?TY1k1BfAOKJqsO5dYLJ6w6O4afFag7aukDV0vP/HVCMNWh1Geh+Oo8kzi7v2?=
 =?us-ascii?Q?cFKUA/iVF60jvMXcxjHsyGyp9ncWEiYkNrJoucZH8PMbDM7nHk95OI6+jbcy?=
 =?us-ascii?Q?As3eH1t0F6BZFYbMnXeTFVrWEJtB2tJ/X31LQMOZa/knAjuDsE2TMGdzAuW4?=
 =?us-ascii?Q?8gR8m9S8V0sCcLFaTSCWgRnVSzLJgmtjh88kW/ESWa4EoXes8vmCj4Kixu0D?=
 =?us-ascii?Q?3bmaUbpq9/b6rHb8lMFZWfucY2CLjPT6j8rNx95wwlW2fiWI6e9yjxqIFjGM?=
 =?us-ascii?Q?TBDr2J1sKh5uzrXZ2Vb73MN2H1h10Ly71Q6SN45bJUBjRVPFL4Bo2BUhLoY/?=
 =?us-ascii?Q?yt2YUrU0L3Pj+KDyzqVmQLDAQMcI+tbpn94cS7jO6M/sZdS6/h4zoYpOYL6i?=
 =?us-ascii?Q?QTa7ZnVtl7Vwdw4qXF2Tu9tALE5KrcxFB8PCcuPniOzIWPNshr+fTEoAZePc?=
 =?us-ascii?Q?CSarlX872bY55QwPDmyIXLHBVh3l9APSe/vsskMRvv/EqdjTcfJ7Zg8Yaysm?=
 =?us-ascii?Q?1Go+eajvSNKNB/pFaZEW9yglDvnZfLak23w6FZF6adi2iyYooeXULgpnJHoc?=
 =?us-ascii?Q?hob+1YB+emilbri1bGqSu9varS2FJnetCnUter/p9bszia6crSG5XsusFZ9f?=
 =?us-ascii?Q?tyiZI6agztswra11He2ZyJvk44n6lkZ+vjO0SjCXrs5W+cyeXfl9LwD936jC?=
 =?us-ascii?Q?2B1AvnJDtIaPotxYvaOFnhlyBW/ehT4dnAz5P/cJ5sQ158Y1/UDyl63ZupON?=
 =?us-ascii?Q?iqtKCn7+YVETv98jjVIkT0IgNpFkezekOdMV1vs57sbJbShYZFWIvrjZEyEk?=
 =?us-ascii?Q?i3Bba1W+lmN1xfNOXH0JdkroPkwtILHNz70jBuoa0QaJuWr6tzNHjNNpAg6n?=
 =?us-ascii?Q?eouUfnn1uUgkANwT0+X+a6wZEE+KN5NHESOyjuUVqU36xrQtMWcbJXiNlLIq?=
 =?us-ascii?Q?w64Zh5++qB2f5aUuJu4FrC0roLyr2H4o+iWx1K/pzRfxkVXItMotIhPf4bfq?=
 =?us-ascii?Q?2NLLf5x8a2fqpTF2ohejsDAlMlNalS/YeAE+7T43fmN0u1d3O8KyEKkVBBd5?=
 =?us-ascii?Q?B/EtBlr3ST7cpg2vVyFyC85D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1267.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8838628b-ae0f-4945-f304-08d92019fc8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 07:43:43.1154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M4xU/U14Q6qQuOZFvs5hEaqB8EDsp4HQLAKd1vZX0bDmYik4wS5MnkxvtIrUVWQI7t3YNceADisBIK3E04t+Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1716
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>, "Zhao, Victor" <Victor.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Monk,

New patch submitted according to your suggestion

Best Regards,
JingWen Chen

-----Original Message-----
From: Liu, Monk <Monk.Liu@amd.com> 
Sent: Wednesday, May 26, 2021 3:24 PM
To: Chen, JingWen <JingWen.Chen2@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhao, Victor <Victor.Zhao@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>
Subject: RE: [PATCH] drm/amd/amdgpu:save psp ring wptr in SRIOV to avoid attack

[AMD Official Use Only]

>>+	ring->ring_wptr = psp_write_ptr_reg;

Put the cache mechanism into the callbacks please

>>+		ring->ring_wptr = 0;

It is not needed

At last, try to put more details in the comment to let people know why we need this PSP WPTR cache mechanism 


Thanks 

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: Jingwen Chen <Jingwen.Chen2@amd.com> 
Sent: Wednesday, May 26, 2021 2:55 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>; Zhao, Victor <Victor.Zhao@amd.com>; Chen, JingWen <JingWen.Chen2@amd.com>
Subject: [PATCH] drm/amd/amdgpu:save psp ring wptr in SRIOV to avoid attack

From: Victor Zhao <Victor.Zhao@amd.com>

save psp ring wptr in SRIOV to avoid attack to avoid extra changes to
MP0_SMN_C2PMSG_102 reg

Change-Id: Idee78e8c1c781463048f2f6311fdc70488ef05b2
Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 1 +  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 1 +  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 3 ++-
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c   | 3 ++-
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 55378c6b9722..20e06b3ec686 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2701,6 +2701,7 @@ int psp_ring_cmd_submit(struct psp_context *psp,
 	/* Update the write Pointer in DWORDs */
 	psp_write_ptr_reg = (psp_write_ptr_reg + rb_frame_size_dw) % ring_size_dw;
 	psp_ring_set_wptr(psp, psp_write_ptr_reg);
+	ring->ring_wptr = psp_write_ptr_reg;
 	return 0;
 }
 
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
index 1f2e7e35c91e..4a32b0c84ef4 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -474,6 +474,7 @@ static int psp_v11_0_ring_create(struct psp_context *psp,
 			return ret;
 		}
 
+		ring->ring_wptr = 0;
 		/* Write low address of the ring to C2PMSG_102 */
 		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102, psp_ring_reg); @@ -733,7 +734,7 @@ static uint32_t psp_v11_0_ring_get_wptr(struct psp_context *psp)
 	struct amdgpu_device *adev = psp->adev;
 
 	if (amdgpu_sriov_vf(adev))
-		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102);
+		data = psp->km_ring.ring_wptr;
 	else
 		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
index f2e725f72d2f..160f78eb6403 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -237,6 +237,7 @@ static int psp_v3_1_ring_create(struct psp_context *psp,
 			return ret;
 		}
 
+		ring->ring_wptr = 0;
 		/* Write low address of the ring to C2PMSG_102 */
 		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102, psp_ring_reg); @@ -379,7 +380,7 @@ static uint32_t psp_v3_1_ring_get_wptr(struct psp_context *psp)
 	struct amdgpu_device *adev = psp->adev;
 
 	if (amdgpu_sriov_vf(adev))
-		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102);
+		data = psp->km_ring.ring_wptr;
 	else
 		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67);
 	return data;
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

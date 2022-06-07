Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFDFC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 14:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DFC010EDA1;
	Tue,  7 Jun 2022 14:36:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5896F10E3A1
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 14:36:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRSiZtHIIGLTpk+t6uB+ufd8aGA13MycH2qY96zFSe6mgLSE2+drIOFN/1wiNYJLi8gO3bzRD0FUsVTMV6QsmmhTCh4m52KVXS5SixlGz1CV2fe8kn2op1/xNlmIRSRi0U67DsitatAZsKwg/U19UMhkTN5hZW7jcAPjRsMfYUosD5G5Uj47gI3nLc4K4uzD7eQbtbJbjoQALfxxvfU0vpuGyg5QdSWzqtxCXDJb7oB7aI2zZuntB45cHoZ3y3OUlP6dkNHKI1gs3UmZi3JP2AAG8XSB+27CpHeLemyZo7rXTcg0tzv+EskueQVU9XUcqMBrWJojA8ZlJSlxgn41vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/MIt9YrW7RcLbQXwG/8Xv8KM4tVqR6ss+63QWGdJkM=;
 b=dkVXgm0EHMfl0FchfYYs4xe6yucC/k+SgEJcbYxA+snQisMczVL7E91AJ8i/0ZH62Nl3/JFyQpMRUqnk9361ucQ5K7GEolBOnhem8R4SL/zIeZN5s14HbO4rzEBa1rX0RIPzldoAFCHubQlgOxPm2+vxE2QwwgsBJJMmeItYuo6E1Zbe4ULITmUZGQ2a9bCu5HxLIWKe6aAZSRCYppc8WnLNX+JfjjaMZIM5KnlcpfQsALBEnFrzMCo53n0QkBPtAFTOwhaGKa9iq4Uk/FZfQS3CYXILzn0Z/SEdF0rPaIs5SD/PiBw8qDRsYytl+85HzP48Mmdgl30mgOKyd5ISCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/MIt9YrW7RcLbQXwG/8Xv8KM4tVqR6ss+63QWGdJkM=;
 b=TvktxWR1R9ehdclioBOkMEKmOTnhg0qLsug/+jH8LZzqkQSye02DiQRjktSccd1WUC68VO6BYkDUUX17MB6dDICWdwOgmHXSX/O23s377TphcdxDNSC9KUZIG0njWD+xN9jtir1BAggAgTcvGT939LuHbJG8lvmq8i8qQCO3iLw=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SN6PR12MB2607.namprd12.prod.outlook.com (2603:10b6:805:6d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Tue, 7 Jun
 2022 14:36:31 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::5a7:435c:485:6658]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::5a7:435c:485:6658%8]) with mapi id 15.20.5314.018; Tue, 7 Jun 2022
 14:36:30 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/mes: only invalid/prime icache after finish
 loading both pipe MES FWs.
Thread-Topic: [PATCH] drm/amdgpu/mes: only invalid/prime icache after finish
 loading both pipe MES FWs.
Thread-Index: AQHYeZIHa2viF0YrWE+h3BMoDZQIPa1EBGOg
Date: Tue, 7 Jun 2022 14:36:30 +0000
Message-ID: <CY5PR12MB6369D69C432A2052DF49B587C1A59@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20220606104007.3801900-1-yifan1.zhang@amd.com>
In-Reply-To: <20220606104007.3801900-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-07T14:35:15Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9bc84cba-3eee-4862-a1a0-8c29d3f8ba39;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-06-07T14:35:41Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 891c9b47-c623-4340-9411-7955207cd2bf
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1854440b-d0f6-480b-a709-08da48931cbb
x-ms-traffictypediagnostic: SN6PR12MB2607:EE_
x-microsoft-antispam-prvs: <SN6PR12MB2607BE89BB88A22C54C989AAC1A59@SN6PR12MB2607.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nGwO/+suiTs0K0zAx5jSi7lhCy5ZrituhWJclXbLEPpv0dEVBFA5oPnQtX0WYgg+paTzFzPpAtqgKXB17iW3KE2S+ve4KnHzPeGOgCIQf+5ZAoXMrRN2tYEzZZ6MjEm2DV5dMcQGniWJiTlcccY7Cv+f/2lK3q4lB4jYsniHk8T6SSA1FBYXXB5V9IfR6xfrtphYVVT4LFDeU9JVkWPgFVfq/V3DZ+JT24LnMts5eNvo6btJoZFKU/HHHVDN3+R7sw+ZJ9kUOWGsl3Fze531OPO80D5KPWbaK2Y7CdyXXn2PypBJL0Fgyc2+2aj/4/bD9t/OfG7wQsrs73G1O/hg1gP7dYx30QWfmUKxAoykfkcTkmryPr8CEEyJoVNNAiE/nbqrK6IWPskIs30Apeb/Q/bwHODB1ojmBQ+vNl8DwxGl6omWBmycgBw+DwBFV52vS6kgAHja1IAa/7oEPphOucMV9VrSI/GsZsdHDQSnJJhdek1wj/DONu3KOahJZvWXb56oDnVJItxPgfSkTA4n/4spstQecTNqC44C18zmiMC7QC31N7peEfCK5WQdDRYE4QBqq4dkBQ9Bpprd/2HYYzPFs7jqqYg+qbrA9HYjiKeE2SgoIKaoYxE2BSwnflG+igzOLoi7uqF2OT5f/4ectoNvSPDCBGwdG3sT3wb8Gi0dPJVyngVujrJRbwjJDIy+AAGXkvbOtW5Y08fapr6nlQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(66946007)(66556008)(64756008)(66446008)(66476007)(76116006)(508600001)(8676002)(5660300002)(186003)(9686003)(53546011)(7696005)(110136005)(54906003)(2906002)(55016003)(316002)(26005)(86362001)(52536014)(6506007)(83380400001)(71200400001)(38100700002)(33656002)(8936002)(122000001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Rygc/Oe3IOj7xcMhvX897ojgKXQL1N7nrRd0Loe8IkyzMtLKQ/kEicGbVYnH?=
 =?us-ascii?Q?y6cilFdeHEAHKHjF/QCMvw+1uhw9uBk7gFKB8Z5CKpdHwXHpNTmHDMpTIm+0?=
 =?us-ascii?Q?oYfalvM/xJZPtCof2pzgC0+AZNfXeJCp9Brw8cTV9n6RMXgOjeqvTRHSStWK?=
 =?us-ascii?Q?C/SE0qAkXABkl/4AY1wD5W7LW7aAxDn7HgyiQ4t3JcIQsRb3ui2sx/EdwgN0?=
 =?us-ascii?Q?Aa2CbDxjrcc6x4ly8ic95s50eOGy8/Ipp3cI75MrIDGtPXvD3Ve0i3YjNA/y?=
 =?us-ascii?Q?4atdtRqUT45g2Lk1yfUtBP96I8PjjbERAYDQRIHF5tBWru/QFz7iJO5eA4EA?=
 =?us-ascii?Q?zVmNyo6yoSvFPFpU8E99rrSAcCHdCIg21BlNPVQwy5j8q9vlQgPI8STmvdxm?=
 =?us-ascii?Q?sEsg4sC9RdUOdc/fLTFAP40C0vYupxTJNvFJhnlQ3KubhkwMH9qwwF84d780?=
 =?us-ascii?Q?rB3mrBt5UDIw4GQUlwIg/WvhJH+p7dAWy1ZpaTtCdVNlsvdVT4nRSEqi3YLN?=
 =?us-ascii?Q?wKrVXsaz2jKPQGpX0n+XmvkcT4Jij1zn3r0rebXmMIdpJ3XHgqMOkSETiicb?=
 =?us-ascii?Q?j/93QiQRle/svZS6xLP3NFnHOO8haI9Qy/ygkVErEjksqXCDmiEtFSGu24hj?=
 =?us-ascii?Q?VaJ0rE1dbewUu7fGwyLLYTniLdBysPmCU8w+AqpYUM3L7hNjG2qkuVBNEvyz?=
 =?us-ascii?Q?KuPYCSeksMTtpfXSt1ZAGEEu3q/kNPzikXxvIEaqMspjmNElloeVAfL+2VZq?=
 =?us-ascii?Q?kSpJ0gn9MLQS38feJAJGpa+mrs5J75IpG44qRyU6866XxNdFEk2Qoky5fvq2?=
 =?us-ascii?Q?9U5eUoAPuoyVDhkUaMsUyJWf7Dd4ucEDbGXSa8AZERpS/hrEP4fegWY8tHoU?=
 =?us-ascii?Q?q/mUcsQOc2KGj0huvog0RfWHdzntsO5a7TVj4kPodI7rm0Uxade01uvicupI?=
 =?us-ascii?Q?CIL4RRsSWrJPqoO7Sd0Xv53s2wEvMCfvbDb7eSN176vP3zfNfFvNo0iJ/6me?=
 =?us-ascii?Q?VdMqA/9S7YZsawlaxvO/5zi7WoOXpRLy4asZkwJJxMKzFfk4+n66z56/HKIZ?=
 =?us-ascii?Q?9qnEbiG+ShPlZ27FaL9E+xvNfjrxFSRvtKSJA1wTpWJjgIQK+skEOr2zIIBF?=
 =?us-ascii?Q?lmEc+PN1AIIokvHOSjJ47ySHedcUzwoIVYpLHirnw2/b8uo6V66lrxJurRVX?=
 =?us-ascii?Q?5fr5qWy2q2gQd4HL7LVS1JvLPoqKxMW0bzRgSNxAt+XPX2w58pWsxugiPq4G?=
 =?us-ascii?Q?4OTRkveS8ObDnAbAogiAU13IlD9Jve9oIJlAntCsokjOIM8mcErD6W14UN2P?=
 =?us-ascii?Q?S+SGaQnqj45LEsdGqeT+FjHB/0gztAehrU576SI8kD2sMFysXemW5MPCXPg/?=
 =?us-ascii?Q?Bqq6qZ8GBE47HZzLYDKiya5bvlpNwq0ddRB3ThSlkRQhgESqy9Ng6Q+yXvGB?=
 =?us-ascii?Q?nOGMX4omOG0uz1Td7Xy8yEIMZ8c+362RIe6sPenFNehjjxvKLPqablyl11I9?=
 =?us-ascii?Q?Yd32sSXbEXP4mWkO4Q4dcX6lS4AMgxfqC10Tan5W3kmJX/DbwOQRitEHJFgD?=
 =?us-ascii?Q?VFfpx4s93RQ5HDUXHBPQR15b6zPWXpAjsZBTemkl+aWVfZuM27oln12f9Md9?=
 =?us-ascii?Q?+vHfcRuaozkLTUt1aqKsTjHfcJ4sjq0ji/Sxcd18NCXrDcvGmTm89WMux+eT?=
 =?us-ascii?Q?yyO27NonqWLf5BdQ81olV/kuJN/nDcrUAjXWeDYk/33DqGh4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1854440b-d0f6-480b-a709-08da48931cbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 14:36:30.5486 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gZPo2r0wR9y5+JcncrnWt+1ouVzcWKw7JhkLXg8D2p3XNx98mAtFWWCkgyD7dInd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2607
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Tim" <Tim.Huang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Ping

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan Zh=
ang
Sent: Monday, June 6, 2022 6:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH] drm/amdgpu/mes: only invalid/prime icache after finish loa=
ding both pipe MES FWs.

invalid/prime icahce operation takes effect on both pipes cuconrrently, the=
refore CP_MES_IC_BASE_LO/HI and CP_MES_MDBASE_LO/HI have to be both set bef=
ore prime icache. Otherwise MES hardware gets garbage data in above regster=
s and causes page fault

[  470.873200] amdgpu 0000:33:00.0: amdgpu: [gfxhub] page fault (src_id:0 r=
ing:217 vmid:0 pasid:0, for process  pid 0 thread  pid 0)
[  470.873222] amdgpu 0000:33:00.0: amdgpu:   in page starting at address 0=
x000092cb89b00000 from client 10
[  470.873234] amdgpu 0000:33:00.0: amdgpu: GCVM_L2_PROTECTION_FAULT_STATUS=
:0x00000BB3
[  470.873242] amdgpu 0000:33:00.0: amdgpu:      Faulty UTCL2 client ID: CP=
C (0x5)
[  470.873247] amdgpu 0000:33:00.0: amdgpu:      MORE_FAULTS: 0x1
[  470.873251] amdgpu 0000:33:00.0: amdgpu:      WALKER_ERROR: 0x1
[  470.873256] amdgpu 0000:33:00.0: amdgpu:      PERMISSION_FAULTS: 0xb
[  470.873260] amdgpu 0000:33:00.0: amdgpu:      MAPPING_ERROR: 0x1
[  470.873264] amdgpu 0000:33:00.0: amdgpu:      RW: 0x0

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 32 +++++++++++++++-----------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index fcf51947bb18..9741b7ff4224 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -541,7 +541,7 @@ static void mes_v11_0_enable(struct amdgpu_device *adev=
, bool enable)
=20
 /* This function is for backdoor MES firmware */  static int mes_v11_0_loa=
d_microcode(struct amdgpu_device *adev,
-				    enum admgpu_mes_pipe pipe)
+				    enum admgpu_mes_pipe pipe, bool prime_icache)
 {
 	int r;
 	uint32_t data;
@@ -593,16 +593,18 @@ static int mes_v11_0_load_microcode(struct amdgpu_dev=
ice *adev,
 	/* Set 0x3FFFF (256K-1) to CP_MES_MDBOUND_LO */
 	WREG32_SOC15(GC, 0, regCP_MES_MDBOUND_LO, 0x3FFFF);
=20
-	/* invalidate ICACHE */
-	data =3D RREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL);
-	data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 0);
-	data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, INVALIDATE_CACHE, 1);
-	WREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL, data);
-
-	/* prime the ICACHE. */
-	data =3D RREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL);
-	data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 1);
-	WREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL, data);
+	if (prime_icache) {
+		/* invalidate ICACHE */
+		data =3D RREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL);
+		data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 0);
+		data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, INVALIDATE_CACHE, 1);
+		WREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL, data);
+
+		/* prime the ICACHE. */
+		data =3D RREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL);
+		data =3D REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 1);
+		WREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL, data);
+	}
=20
 	soc21_grbm_select(adev, 0, 0, 0, 0);
 	mutex_unlock(&adev->srbm_mutex);
@@ -1044,17 +1046,19 @@ static int mes_v11_0_kiq_hw_init(struct amdgpu_devi=
ce *adev)
 	int r =3D 0;
=20
 	if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) {
-		r =3D mes_v11_0_load_microcode(adev, AMDGPU_MES_KIQ_PIPE);
+
+		r =3D mes_v11_0_load_microcode(adev, AMDGPU_MES_KIQ_PIPE, true);
 		if (r) {
 			DRM_ERROR("failed to load MES kiq fw, r=3D%d\n", r);
 			return r;
 		}
=20
-		r =3D mes_v11_0_load_microcode(adev, AMDGPU_MES_SCHED_PIPE);
+		r =3D mes_v11_0_load_microcode(adev, AMDGPU_MES_SCHED_PIPE, false);
 		if (r) {
 			DRM_ERROR("failed to load MES fw, r=3D%d\n", r);
 			return r;
 		}
+
 	}
=20
 	mes_v11_0_enable(adev, true);
@@ -1086,7 +1090,7 @@ static int mes_v11_0_hw_init(void *handle)
 	if (!adev->enable_mes_kiq) {
 		if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_DIRECT) {
 			r =3D mes_v11_0_load_microcode(adev,
-					     AMDGPU_MES_SCHED_PIPE);
+					     AMDGPU_MES_SCHED_PIPE, true);
 			if (r) {
 				DRM_ERROR("failed to MES fw, r=3D%d\n", r);
 				return r;
--
2.35.1

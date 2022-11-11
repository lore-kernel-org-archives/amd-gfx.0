Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0A6C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Nov 2022 09:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25A1B10E7AC;
	Fri, 11 Nov 2022 09:11:12 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BE2E10E7AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Nov 2022 09:11:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqHzBIz92xyyHB+0PBAfDcFbVXLS/JhaKvUg4XZNZkUtAvmr34zbdWjrlry8f3cxrJz7uxv9vNOvvHpajXchzjuldjb6jxauHEVtsQDZQsyIcxVH8sNQ1QVmisKs+e19mAzqRawFOdktVistkESs9vz0O277bp4Kn+cqQjToMAdV7qF9WV/1YHau2bZfgzI5vQYiPLwSOxvdJcGRX3WaR1zHjEw6V5OHll3AftjRf7cvJDU+uGFTsntNsVSWC47hfKVuUlx8T3CgVUp1ztadX2RZBly9f5f059f5LFAvI2SfYemYZ0nS3ux+Tq5kQKFNccvnib+ArQZGrdUh5N3CkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTNkf/IPjWqRb8zLMWS6ond7lNxqUMeKKRshHpn4/4o=;
 b=JMwWJiHe67xt8boFNpYf7TiM76WajS8CkaIWFvkqiYe7ulGh9tBaOaU4IH+YEf6xFsQ4/H23He7/zIxei0w8+qKVCn6pusXqUiMeHRVSiGGu0fKWHS9YFGM94htbtORc98pcKim08Sg7KM0diWTOM004Ptst2L+bGpiwB6QhR3UnywBbJXufP4NJcLqS8JaPkp3DQu1sB5YqVWzQ4ux5gBfs00lxYAAQT0kt2JVqit5ygGuIvdoJYnYj5as4Z0+ZwF8PP8CRkrk6ORd/TRJdg1o0CE/1w4Ff6+2ucs18GqenISW8R2FPidufXmvbGH/F/h1X/1CViHUeJZW5JUrRFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTNkf/IPjWqRb8zLMWS6ond7lNxqUMeKKRshHpn4/4o=;
 b=Lb2iRK37qWAJCwKieGuaRoJ/Z/dj+Hzb3aHh2IzjEtSTDu+giAxwAx7+EtdFp+tanSirs8YoOjYvAT2vW/vNTIissWkDc+23KgWyWVKPWdetI0V4s+tZpL0ac9/OV19/3l9weGaGOG/tDpVDujre99bAXeJShtlCrd62itKoqYI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5180.namprd12.prod.outlook.com (2603:10b6:408:11d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Fri, 11 Nov
 2022 09:11:07 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8bd7:b65c:13f4:9b]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::8bd7:b65c:13f4:9b%8]) with mapi id 15.20.5791.027; Fri, 11 Nov 2022
 09:11:07 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zha, YiFan(Even)" <Yifan.Zha@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Remove programming GCMC_VM_FB_LOCATION* on
 gfxhub_v3_0_3 in VF
Thread-Topic: [PATCH] drm/amdgpu: Remove programming GCMC_VM_FB_LOCATION* on
 gfxhub_v3_0_3 in VF
Thread-Index: AQHY9Z+yUNCVLJfiBUSDOsM/fY5gV645b6yw
Date: Fri, 11 Nov 2022 09:11:06 +0000
Message-ID: <BN9PR12MB5257CDC8FC2A11536E03CDBEFC009@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221111073050.3469773-1-Yifan.Zha@amd.com>
In-Reply-To: <20221111073050.3469773-1-Yifan.Zha@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-11T09:11:04Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=28b8bbe4-ddfc-43ce-a4b4-b904e56a5c21;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BN9PR12MB5180:EE_
x-ms-office365-filtering-correlation-id: 63bfe1be-3164-4dce-fe11-08dac3c4aaa2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oGF490iDP5jS0HJ9aWbtmohG5lksHnyYZNvd5XZu/xFhVjgNLtbQLx4EUQUqG+X6j7/s84Ef3HhXht/gYQvlI9VzMTnWC3bPRy1h5oEWRzJ3jU0d9asl/QzVExyVntIAYllCcKmSRMvCRIRScvAdjRXVPZIQAPtfaSuTHS/Mc+mjmtaqrrS+eq0S8uEPWSx7AkO9v/kvDLsRdny1P62X9KsV8p2AIHc78CVaeme6uBJNkj5By/9ZJu1lnxDlRnr8geI1VMep1KEUeLHN0dOezqKHCwfVdlXSJXo5t4yrKzxapogA4FWpe+MoMdhQ8ZEjGHXe0BN6ecJggeY+CZVW1VJugDqKV1+zCA+9CCdy0BwgeOhUJxL5iiRsB1SuPi3Edwdh/VmB39Yyf/searhx/ll/o81ox+iJ6PdUqvm/GvxEhn9YY+y8Z2uJIRcPADAwC/KVUbCCqhXgCbtlpw1PAxhK0qKcJmNtL6hUn3rV8GgWmREnf5MQoCZlX3C4IXET0T5ocXJdSbHODox/BPd7Mbqh79IgSGFQIVo+3k1+813tE24u5Ne7xcFndIwgQ8sl9vvYacSNudrlf2JKRCicw+8tLXOIA/4Qhfq0QQCUBcxZbeGjR4b5HeH5Xch1XH8IDaO0ALRk/hN5j97URML8a63EdS6XaNBAoEOHr0KBIaZsI6pegzNRa9KNIF2+Ds/Y2cFG2pfNEfGfsCxz3KDpzQS2Gj068ucjDovlyuMt8rlD1RhAMMpvjJixnExo+AjujIKshavV3sQrRwIturrRxA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199015)(26005)(9686003)(53546011)(33656002)(38070700005)(76116006)(38100700002)(122000001)(5660300002)(2906002)(186003)(7696005)(83380400001)(86362001)(6506007)(110136005)(66476007)(52536014)(41300700001)(8936002)(8676002)(66446008)(66556008)(66946007)(4326008)(64756008)(478600001)(54906003)(6636002)(316002)(71200400001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Myl87K+eQY/El9amcyo0K7FM3eKNzg4nRf74mAI8CHtrK4+4NVGN8dXAGhqY?=
 =?us-ascii?Q?/aB2vl8jXr572lcp/tECYnXB25yuUsTN77x4x71sNrvheoTPB/qf8NknGveY?=
 =?us-ascii?Q?apnG3u+w74DlDoOObUCVFOlADEnP/pcSRenU6KSPGM8aHW0ByX3gjPPqFxtE?=
 =?us-ascii?Q?dPEBMoSdLaxP7xZKTQHzTdJkfayuhej6KNM/vjrF/jaJdDcqPtaXmBdSOE96?=
 =?us-ascii?Q?788I1DRCNkOdA4DY1UHb7W/STAEGD0SSaLVJbyxWNYbdYy3kR4fsOwk4dlTy?=
 =?us-ascii?Q?FSkXt8U6/hP87aL3ARQ6J7vLJt7zGWeo6duN94m9mOY2gqwDUYYj1Qo0vSyc?=
 =?us-ascii?Q?d35VwBp9bVql1MyFfSp5dbINCI3Wi3LVHDfsbHo0xt65HjbMYIIIwy0XGHQY?=
 =?us-ascii?Q?aiZS2R+ci7katnyMnCz/Cnccok4aCJSEOC3XqUuZ9zmmZDIPbK3NSUGqDvxx?=
 =?us-ascii?Q?ByfguZMIBWulojMv6aWAJD3yMuV5Qh6XuFx+r9Fdi14kK2ccayPc/gNJum8w?=
 =?us-ascii?Q?I5G2aUNXjHN7C4iP9Bu/lnNbMQZcqoAre1skTqwofFxutgvyFLEicCAdQAIP?=
 =?us-ascii?Q?1fJnmfjynuEKViqK2z2RL/H7G/1EeCVJxKh0uZbaNqGUMGI/XqojRQv+Ntqm?=
 =?us-ascii?Q?n9T8ElxX2WMpOxIYIsper07GqhonKnv8j3BalcaBQ1Dlr6bCcCZ+Taho4AEz?=
 =?us-ascii?Q?+lSeQPSF7u86OnTge4Ty6IpkWDlXPb+jf1BpSIxrwQGVSarxVr81PvYO45VO?=
 =?us-ascii?Q?GRMiLb+9aREGe3EIWoZd/RallBIWUg69Qv+bVW7B4gYjn2vxmNQ8UyhY2UFh?=
 =?us-ascii?Q?YdzK3xb0U7YwIbUAFritObqHztKZ81e04EDXuvnJpqg9SAoiuJIrnsFScqf4?=
 =?us-ascii?Q?C56MBez8Ng6RBM5FYKGzlSsTEFZmsIPfn/qYqa5xXK1QzawO3qiFWdszSDk3?=
 =?us-ascii?Q?og52KioXGgyz2QZE6crEG2R57sq3+DOGc3zUvKfMgCVvb8fNmHoLw/0bo9j8?=
 =?us-ascii?Q?+5ASAjytRak7nP9LOE9p8UmfjfynRmr683HA38IciBA1dyX6F2D/AjkVt2uC?=
 =?us-ascii?Q?U7g/6vlk8J25nRIh12+6kGUDSdjHZ6CufQfkDv5mqa6RDuADiBZDdIdATeMt?=
 =?us-ascii?Q?BlTqa4NJGzwL/2bcwIqFjrivD7RelqKthkZlW2GFXsQCHdkBQxs02fsQbXgB?=
 =?us-ascii?Q?jI1abNy7d1aKqqvC4xfn0SDP4U5wvgCYqJBCEbdplk3L7kkUx/jHJoZkNRnb?=
 =?us-ascii?Q?QA3pWDCPKtC0y16QGL2CGEIiCbjFOsJOtKcs1eCvmT/JdkeQsjzR6pDmIa+R?=
 =?us-ascii?Q?wM7HP5CGsgJ/hx2ql62MjW4Zpw332Q+8jxm9qD1TO3+cigGqfZWm/SiiklGp?=
 =?us-ascii?Q?xYovim1DnbvZ/MYVb34TreavlKgW/GfUeAh669HtlesqIzJTiNJVhT94o+gK?=
 =?us-ascii?Q?ZGlpNwhmVwZFT4T+53JpwYYifxw3ihGArpwier7UIH66TevxvD4tyM3kSbkR?=
 =?us-ascii?Q?bJNC5I9H84cJcfhuNI1NRsDZpB4ef4bly6MsjuIu5PWBZtAmj7Yt5w5nibdu?=
 =?us-ascii?Q?C08VZ7+4bRSSM2WOE3bpyFbq1AailfEuQdKEgYd1?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63bfe1be-3164-4dce-fe11-08dac3c4aaa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2022 09:11:06.9692 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hdeOvYjDO7bGImHvAsXM5aMK5NEHi8JIlcF/Rf5YAPm46TblXiibYtMgn4igtrlV/AgpkiQGtnsUJ5fQk+RChA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5180
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
Cc: "Chen, Horace" <Horace.Chen@amd.com>, "Zha,
 YiFan\(Even\)" <Yifan.Zha@amd.com>, "Chang, HaiJun" <HaiJun.Chang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Yifan Zha <Yifan.Zha@amd.com>=20
Sent: Friday, November 11, 2022 15:31
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@am=
d.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: Chen, Horace <Horace.Chen@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com=
>; Zha, YiFan(Even) <Yifan.Zha@amd.com>
Subject: [PATCH] drm/amdgpu: Remove programming GCMC_VM_FB_LOCATION* on gfx=
hub_v3_0_3 in VF

[Why]
GCMC_VM related registers should be programmed by PSP on host side.
L1 and RLCG will block these regisers on VF.

[How]
Remove programming GCMC_VM_FB_LOCATION_BASE/TOP on gfxhub_v3_0_3 under SRIO=
V VF.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/a=
md/amdgpu/gfxhub_v3_0_3.c
index 716ae6f2aefe..080ff11ca305 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
@@ -357,18 +357,6 @@ static void gfxhub_v3_0_3_program_invalidation(struct =
amdgpu_device *adev)
=20
 static int gfxhub_v3_0_3_gart_enable(struct amdgpu_device *adev)  {
-	if (amdgpu_sriov_vf(adev)) {
-		/*
-		 * GCMC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
-		 * VF copy registers so vbios post doesn't program them, for
-		 * SRIOV driver need to program them
-		 */
-		WREG32_SOC15(GC, 0, regGCMC_VM_FB_LOCATION_BASE,
-			     adev->gmc.vram_start >> 24);
-		WREG32_SOC15(GC, 0, regGCMC_VM_FB_LOCATION_TOP,
-			     adev->gmc.vram_end >> 24);
-	}
-
 	/* GART Enable. */
 	gfxhub_v3_0_3_init_gart_aperture_regs(adev);
 	gfxhub_v3_0_3_init_system_aperture_regs(adev);
--
2.25.1

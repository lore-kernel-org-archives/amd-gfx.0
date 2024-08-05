Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3C04C3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Aug 2024 03:37:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FC4110E111;
	Mon,  5 Aug 2024 03:37:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1k90YOh1";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1BB410E111
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Aug 2024 03:37:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hMBPoT83ySmQxqe4ghSNHBS6P6PCrS5R0+qd4ElP7VqxqEBKiVaW55NJd2tEr57zKMUUJlPZnFDg9vJR/ZNs7rQW6EA7kjm06syk4nJLyHajiKVLr+tyrhCj0bxaQwsWj2ZpkchrDi36jTTVCNBfPQu5mo0txKnuQOg41Qp7JkMmdKJzbxDtN/AWpxx3VUwq/tGltHPXNiNNSAS29l8Di4AcmIRntG7mm/H7nfRTcOohMJ7DzJlQCGZUUxTw+T1Llt1M1CGig+NuJ0JMKvAZpw50g/FNJxOeJ0fsDFn+nTU6E7VcIBCTLCNpwZRr5JNWx21TYwD7liz8JoGRy67NBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQjLNq04e7SJIILw0FbztFNG8WuQKHsyiV47nYIGf24=;
 b=vrMyhYzeU30OLF8LUBK3wBoubGXc9I1MLcvVJuLT3kFvbIaVrkKUCQfG3XSZpm7u+whrcaGrH9JRHs9sAA4WYwQGOY+bvTYxvySK5pupxL0/PhCuWEQVSqfmxy7W/LzXA9ceOtLwlAwoY3jWTMUPrpoKx2/OHemo3DeHcOpP7vjSAFAz8PwEySEuzxtz05bL0iik0vuDRjraR3mqMf5e19G0n1w+A0Ik9e8pgQVarYuTDDOoTXt4Eo+F592Ado/9fY4EcL8s0koi7ISYbkBrADIp3hRbDZxOTwS6L+Mu4G8JlOvFKD9+2aMjQovhG1XtS9jRmhS8TPKZzoWZdBbHVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQjLNq04e7SJIILw0FbztFNG8WuQKHsyiV47nYIGf24=;
 b=1k90YOh1s1H8JUsoRTAF8AIZtUA3CcC4e3gY0b2JcvIgh5YuCistTi01HecDIPwj2G2rPsj4BT0t52QqNJGPwyMwhk37f8BVPzRipuWv5D1b8UM0wV+zRpd7HGQoyzVz0i8Dzu8S7OluwYz9RWc4etj3wFmZ3brnfhnPLpD/WMI=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DM4PR12MB7525.namprd12.prod.outlook.com (2603:10b6:8:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 03:37:35 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%3]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 03:37:35 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhou, Bob" <Bob.Zhou@amd.com>
Subject: RE: [PATCH 4/4] drm/amdgpu: check return for setting engine dram
 timings
Thread-Topic: [PATCH 4/4] drm/amdgpu: check return for setting engine dram
 timings
Thread-Index: AQHa4+EeQF01qwEHT0+hgpxkO04YNbIYCb2g
Date: Mon, 5 Aug 2024 03:37:35 +0000
Message-ID: <DM4PR12MB515285AB8B3A03FDD69197CFE3BE2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20240801070333.423881-1-tim.huang@amd.com>
 <20240801070333.423881-4-tim.huang@amd.com>
In-Reply-To: <20240801070333.423881-4-tim.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=37105cc1-8769-4998-8107-c59c37f5b24f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-05T03:37:08Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DM4PR12MB7525:EE_
x-ms-office365-filtering-correlation-id: 27bff79a-9b78-4480-7976-08dcb4fff236
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?GtCk6T0nvp2oeJojB2rhqMqB/RbbucknMqRzhpcbL78coZ/tOvLAjt/SFFv/?=
 =?us-ascii?Q?1trAeHgcssvnQ6jG+K6VsiLq4/NB9NDD13y46UK6fEg1H208+ZZKxUYsZZXS?=
 =?us-ascii?Q?UWAYfBzXFz696/2wvSeoH4WcL+x/Bg5mfrwWVUqWaKmRF0InsFPoS5/x8Zy8?=
 =?us-ascii?Q?xn2Qa2pVJhYXK/iiKF1IxyAWv5AcUxtxoNLnKCb40P6nzEsWC2RV0g23jTiR?=
 =?us-ascii?Q?WWHYinAI0/WyI+O6BuAzBPc022ITf+ZNhUbM1YK/3/4UcBw/dAdQKn428rUy?=
 =?us-ascii?Q?p1SRD0fGO/meQ7Vh+RLLT4WCf6gaiHKCs4lSBtNRdh8oLm4polu1nHg9XCEF?=
 =?us-ascii?Q?iv/bWZ6uXV7SpgJ2Lhur9TFyRzbyaMZFCVH9BLjcqZ+sCK+g0XsBKbDq21Wg?=
 =?us-ascii?Q?RX4j2OX2MxIdvF93vc7+iG0ehD8H2P74VPWbHGJiabmC5IWCRiaP56qdWud8?=
 =?us-ascii?Q?kv0qMxMkbUOfa2oYEcPPmvrIxZPU6kavqaPnoFn3TIeeQqdVdqQzGDocyR8l?=
 =?us-ascii?Q?w41zrmTVRmIeiTyISisircbCveO2zTSvrar/20YDew55hcwfGyGKQlCP1EDx?=
 =?us-ascii?Q?LTQpXujaUa5Im4pxNtlCrf5fYC2ZBcUwDC4oQb/tRUHnf4DGSRiViZk+UhuW?=
 =?us-ascii?Q?DI7Kb1G4q7LLFfQN0fi19Nx2q5hCg3GjOMbtDf1NeosTpAIZxyhkaylUh882?=
 =?us-ascii?Q?rexRf2BvDuWki+b9IFMiHFXko3UGbdO+sXGhF9rlPP4MR7C4sidRXnl39KQC?=
 =?us-ascii?Q?shtr5s1W1iGvZLnKCIkQWbedro9WWV/oafXaKja8WjqlJ04eqHZyOOtqULpI?=
 =?us-ascii?Q?MEIVr/6ehRJN4/ZWh6b2zJSR+O64ZzhSwBvSw9A9C7QdUSaOaxCtHFsk/Mrg?=
 =?us-ascii?Q?MHdUIV53Vd7BWU3bipOrYmntGnH+JEUN2A6pJ7/uig/fkl8NLkUK+pFd6SmJ?=
 =?us-ascii?Q?3RUI5GNEPsBJuZDGV/kKWhBNtLcR1VRUg+BBhsxbgG3EWFSLTg0MBleFaONA?=
 =?us-ascii?Q?8lCVEzi65eM/dDqXHdsr3J+x/NjPn6roVDM9wdFtu+iTbdiS+5iFnbdTPWuH?=
 =?us-ascii?Q?Um06iOh3EWT1N65HJzGNasXjoj/KSBd3UeUhZYkChSrnn7MW59CdG20QIDOy?=
 =?us-ascii?Q?pvVVWsfT+J/E15JL16/bk85yQTJWJnywzdTCCfz8X4MM45k0vugpevYssDvq?=
 =?us-ascii?Q?dgaZXTzu9s7v5uFwuPuBYfHuIdM+qwQ9rLBPGgMpI8ulImEDJgJCCXWGWX4v?=
 =?us-ascii?Q?T/dQJI50D3eGWFG/S8LJgTUXnDJloRHGtIAykygyxyBWj3oBqRk0NGTRSEe8?=
 =?us-ascii?Q?NPzJru8VTqTvQRryc9nh/y9PZiR2+wUHqSRwkqZLS+B3A9bmHL/RnSZTC36T?=
 =?us-ascii?Q?lplH/K4NWf4TR/v0r3z4KURnhm12ACoij1UXebAs4FKlqZdBwQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r9wzW+RELiZ4uKG7f+PpV0ZuL8qCEp+eOvj2OX+xexZBoeC8d2O4Lr98UOLB?=
 =?us-ascii?Q?3UMo7i5hx8ew700xTtxhMswXqdsx9mDyyRDmwdHOeFhghpYr9QtVV8psrArV?=
 =?us-ascii?Q?5hN/8SRxRCb41YrsjlmDrZEnl5xyFbMqmrD+jrKrDzkbwVhgaDmvybuqHdVs?=
 =?us-ascii?Q?MQIGWFen6wPpy58nyR9KkQjP1/y/z/TNr6rORWZSUzAV4KFhScsIU+DfttJq?=
 =?us-ascii?Q?wH9VvwzkouxTnLwytGbXwM2QSAN8GZskEg0iqsUUc7vygrsI7cICeRmONVYZ?=
 =?us-ascii?Q?xw2O0OvjEEKDj1GH4ys8eO/quJyAV3P6VyAOJoFeW6FEXX5/Z2FIMyEBgjkS?=
 =?us-ascii?Q?Ie7hEQndWsUCOslvwhtw9MM19Bu13gHp+TwDP8lSmrRFhEkRMQc/FmX1qoS9?=
 =?us-ascii?Q?+f1JQ1ozfFbwCsLsyC2Jj5rXPFMQ0peuktWLo89ev5lKJ5XnV5cCFEqEMBzR?=
 =?us-ascii?Q?6FFnMOKFnJ7J6XGtV+WnU+o5hcrElIVQMjnRIg8kSXo0jkpkD2Z5s0LWxdKR?=
 =?us-ascii?Q?qxRWmO7fYSCQi/pjnMTn1kU94+9VZiVKMnnEvrTXtB7LK8XzXVXA6XrmXOQM?=
 =?us-ascii?Q?wcOQxBVxoP8KCcohUGOnfRRgdS0pOugf9rJxo280ziCjI4eGyFOVB+W74VAr?=
 =?us-ascii?Q?akOyXwnpz2OT/HyX0FoVj3Jg67wy0qdpewhIUYAQC5OUNkiHVWkD7sYvJAnR?=
 =?us-ascii?Q?fWkjHxVDdvcX68bmHPzrNZl1yDmgc4No4/5K9Qfc8kOD1E9qQ2mCLPVKB4JC?=
 =?us-ascii?Q?T7vL92afKDOKDRz/rsHEpVN9JGVUrsJ2yKGTpk48z1bc7uZ7KMxWgnL127vJ?=
 =?us-ascii?Q?W01efn8x7xuUONzlpY5vxY3MxZ72hmMSXU6Q9HKQXe9PQnXMdylpfVK8PwQL?=
 =?us-ascii?Q?+gYm+HdKGQ5x3s5LzJ0UthLTnSNB7Laorhod5Ot4h2LLzoKVqF+YjrSaWUwJ?=
 =?us-ascii?Q?nXmHepvaeZVd8XH0zNDcyvP4MFrHDLqhKpAG5+eAWA3/41J1p9VSDlf8eN9N?=
 =?us-ascii?Q?r9D596cRuuGm1S6JoBOyCxh0ydeO8p5aOkWbqlmbL0cOkMjK2by+NQczCyir?=
 =?us-ascii?Q?Y32ojKE4Lk9jwIw90ADcGZURo029T/i70tdwChxSv1Lb1JBUjwZtXL3CVpJB?=
 =?us-ascii?Q?kbDCtUvnTA862hlBEe8Yml8l7J22kjAlQQyl6c3DLg9LUKW+eY97hAlq6Fh9?=
 =?us-ascii?Q?ROtzn5oJEcSfz8PCOSeI1Luv5qPHhVdCc1H5d9J8vU1S4VdcJGpa/VIAmtmF?=
 =?us-ascii?Q?u9Y9wfBgz0ZbrgzpehYRyJwBHHCx4BL5AvPijt7jbUIa3x9Yic2mukG8Z3qJ?=
 =?us-ascii?Q?V92g3d7rpNYY/dETLZP782h46vPKZ8x6DlLH93lTxGiTSfwxRN62iQGQQn/n?=
 =?us-ascii?Q?vW97i38AEDBTQJ0mg6O0yp/AB3j2iTKKnqwSpynxJhApKHLBxjdEtRNjtywT?=
 =?us-ascii?Q?sOpOa0NG7UkQSzH8pLecxUN8NZPo+cdEJk+hM+4Uvlq9eewCMxlxlPvaGjkI?=
 =?us-ascii?Q?HCmamtCn2m2M04nmXrC+sc39kwpvVZfbC5P1CxikX6BCi9SZRHx9mcaV8+y/?=
 =?us-ascii?Q?neaTh0M9f8ooewq2GDQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bff79a-9b78-4480-7976-08dcb4fff236
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 03:37:35.2726 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RoHLuTcWasr2OfIdeOT6Cvh9xQO1o6OApgqqA4BibAncYpQfbhsSzEz85FKvlXLZc721aCm9VaB7f8OIbUuOnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7525
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

[AMD Official Use Only - AMD Internal Distribution Only]

Series is:
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Thursday, August 1, 2024 3:04 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhou, Bob <=
Bob.Zhou@amd.com>; Huang, Tim <Tim.Huang@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: check return for setting engine dram timin=
gs

This resolves the unchecded return value warning reported by Coverity.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 8 ++++----  drivers/gpu/drm=
/amd/amdgpu/amdgpu_atombios.h | 4 ++--
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c   | 8 +++++---
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_atombios.c
index 0c8975ac5af9..093141ad6ed0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1145,8 +1145,8 @@ int amdgpu_atombios_get_memory_pll_dividers(struct am=
dgpu_device *adev,
        return 0;
 }

-void amdgpu_atombios_set_engine_dram_timings(struct amdgpu_device *adev,
-                                            u32 eng_clock, u32 mem_clock)
+int amdgpu_atombios_set_engine_dram_timings(struct amdgpu_device *adev,
+                                           u32 eng_clock, u32 mem_clock)
 {
        SET_ENGINE_CLOCK_PS_ALLOCATION args;
        int index =3D GetIndexIntoMasterTable(COMMAND, DynamicMemorySetting=
s); @@ -1161,8 +1161,8 @@ void amdgpu_atombios_set_engine_dram_timings(stru=
ct amdgpu_device *adev,
        if (mem_clock)
                args.sReserved.ulClock =3D cpu_to_le32(mem_clock & SET_CLOC=
K_FREQ_MASK);

-       amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uin=
t32_t *)&args,
-               sizeof(args));
+       return amdgpu_atom_execute_table(adev->mode_info.atom_context, inde=
x,
+                                        (uint32_t *)&args, sizeof(args));
 }

 void amdgpu_atombios_get_default_voltages(struct amdgpu_device *adev, diff=
 --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_atombios.h
index 0811474e8fd3..0e16432d9a72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
@@ -163,8 +163,8 @@ int amdgpu_atombios_get_memory_pll_dividers(struct amdg=
pu_device *adev,
                                            bool strobe_mode,
                                            struct atom_mpll_param *mpll_pa=
ram);

-void amdgpu_atombios_set_engine_dram_timings(struct amdgpu_device *adev,
-                                            u32 eng_clock, u32 mem_clock);
+int amdgpu_atombios_set_engine_dram_timings(struct amdgpu_device *adev,
+                                           u32 eng_clock, u32 mem_clock);

 bool
 amdgpu_atombios_is_voltage_gpio(struct amdgpu_device *adev, diff --git a/d=
rivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-d=
pm/si_dpm.c
index a1baa13ab2c2..43028e776c93 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -4755,13 +4755,15 @@ static int si_populate_memory_timing_parameters(str=
uct amdgpu_device *adev,
        u32 dram_timing;
        u32 dram_timing2;
        u32 burst_time;
+       int ret;

        arb_regs->mc_arb_rfsh_rate =3D
                (u8)si_calculate_memory_refresh_rate(adev, pl->sclk);

-       amdgpu_atombios_set_engine_dram_timings(adev,
-                                           pl->sclk,
-                                           pl->mclk);
+       ret =3D amdgpu_atombios_set_engine_dram_timings(adev, pl->sclk,
+                                                     pl->mclk);
+       if (ret)
+               return ret;

        dram_timing  =3D RREG32(MC_ARB_DRAM_TIMING);
        dram_timing2 =3D RREG32(MC_ARB_DRAM_TIMING2);
--
2.43.0


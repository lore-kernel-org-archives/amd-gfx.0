Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D835C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 08:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D19110E215;
	Mon,  7 Mar 2022 08:40:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 929BF10E215
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 08:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gj0yKf3+9jVruIZkYPqCmNHYGb3dPBagX8K63FHdt+tBlqBYytoBNCFMsBmXLiMyoV8mF9cbT2HMi8yhYIk3KL61S2zUyNgEeR8F4pfHXmj4YxASBpaAXVocKxVA+wRVTQ1Xr5YrpPFWTe3KcN34FI/cAnml9tpjoJ+PBkx4lrQNSZxBTJpG3sLIXdgs6pVpBComHjVEbKp+H1YZ4On/h0TrpSj/stXWmAJS5yaRnlb0EiWFSA40WD6JeFEkbi9NBeEdYSQ9VpgwozgvayH7FxbZaPvvsDZCzV7jHGO2b3WWJ+APlcXXW5657zppsddQgRbLZ1GPGQiBRHKpjFiYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ng1Qsu3jq7qMSNoz1LlST7AzfM4rs0lCsrA3c2+bavw=;
 b=L5FQGbkYZFu8ixab3NnXEb0FJf8Fjr4GoeqAByRz6Pkk3dNV13WbaO19HQ7gaM3krSI0pUgS0cVkjClOBCT+p4ogY/gHpCJRpsfWX2O41uBUzdJiYpxjDj7KIiM3L5ZzkdgFOCpZ03GiE2XSr8hpGq7cwqVWizgYWHX2XQRsbZAMb1vktJADvSCOjowQ0dQ56jSuAlepTy5mQfkMoGtvER8we5EisIQnEoqUsBsslbMcTkocNj5RP2ALFnU4iPkdZD7SVftM/nUtopVjw84a6THjwlOZg8or+vr5+X5cbmYj02Wv6fY01+ph2uew48QqRAIQfx6xG5KgsZVOiA5rtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ng1Qsu3jq7qMSNoz1LlST7AzfM4rs0lCsrA3c2+bavw=;
 b=wOjqtX9pmn2aUS0vBif78Kepc41rjtHaTeJ6IEkpq3TJQ6oGO8XauK/wdCjx4P5epQAnDLdWe6toJCwsvTBzzg/r93AQdqFlzuHqfpiDZOeCoaZrRuYciYUX+tN8VtAHZxt1p6JqJ22Mu0VieSWqMsgNSo/Q55QucEfb9Rd8978=
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 LV2PR12MB5895.namprd12.prod.outlook.com (2603:10b6:408:173::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 08:40:17 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8d40:da47:7312:64b8]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::8d40:da47:7312:64b8%6]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 08:40:16 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: change registers in error checking for
 smu 13.0.5
Thread-Topic: [PATCH 1/2] drm/amdgpu: change registers in error checking for
 smu 13.0.5
Thread-Index: AQHYMfievH8lljto9UCmEZofzeDfTayzmeuw
Date: Mon, 7 Mar 2022 08:40:16 +0000
Message-ID: <DM5PR12MB250471A88DC59B6D63740185EC089@DM5PR12MB2504.namprd12.prod.outlook.com>
References: <20220307075412.1984581-1-yifan1.zhang@amd.com>
In-Reply-To: <20220307075412.1984581-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-07T08:40:00Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=4a6d8e92-47dd-4d9f-8358-8ad7b6af2df5;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-03-07T08:40:14Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: ac22ec20-1b39-4f55-94a3-95eea3ad082b
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55c521d0-3b6a-4c54-f5cf-08da00161b06
x-ms-traffictypediagnostic: LV2PR12MB5895:EE_
x-microsoft-antispam-prvs: <LV2PR12MB589530FEB85DFDA8B5A9104EEC089@LV2PR12MB5895.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M7XAl8wL/ild+UqqsL9MNo5/G5Iw8oABftT1VRsm7DET+mGcZ0nS0PPQust7/+IwU5OJejDoi9/DaeB+MenqpUQLoar4sVK7w20HScCwqvL8H2yMIl8JqnyaTtvFtRKcKqNywZlyV76GU+IlLav2IpZbeODBMGw5pfdd3AFbiGyEEUtFO3St4mBPy7w1BRYAG8sVXWqUOX+HYnmTaTitJ9T5TJzHT4D9LTyI+bHJVuUlrUp5U3ORtC2h2rOhZmGvIHWWXg+7V5Y6YiRbejed/cSZq3ZAaE9anSkZUuJvQngJjPgfBSInKvIG6uxQRHdOn/VH6+Av64QMqsKPb6BsSdKlu9QQCF6Vb1vi8nh65aACgUGuuwBwHkaugFUs07YcUA1hWZCkvO9t/29fTnN9BZSxDc7wGLn9iu1cQzIpfR2keCzC3IBZX7Pe4QCxM6hmNGmCtRlRViKPCzjB0d3vczgT6JdGDkqXZhYpynI2FYU9Qn7s869PIcfk0qDruAlm8Qr2UyMsU55QK6Z2aW0EhW17Z9qAqSyroHUlCLRlo+Bi8j5CBSRS0QS2qQwOHCAQGIfxDKdwHNW3jvfuuhcHh6DF0WOmIqjF3GeLxKrRC/aHGEiW2RZdN03xlxCvtM5DGzWSEcVQ+PMpUCWyFMpkRaP7PuF6EHyLhZMEvxe7+e3plukiJcOY/m+lqFMwvfssb3TrHkf3duq3Ovb75QdGFA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2504.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(186003)(66476007)(38100700002)(66446008)(86362001)(9686003)(71200400001)(316002)(122000001)(55016003)(2906002)(83380400001)(64756008)(66556008)(33656002)(8676002)(4326008)(7696005)(52536014)(76116006)(6506007)(66946007)(53546011)(8936002)(110136005)(5660300002)(508600001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wIZntpO5pqycFKzl42ZiaEpTu+dxp2Zuaf/YR15cJkLyWt5fBkUCz0dgZmmf?=
 =?us-ascii?Q?dZB7BFCXiEmv/MgdFcPBfbx8FLCVyL3imjNUh1Nkv6fEvo+Sa/Y4zDA1WdRm?=
 =?us-ascii?Q?ByOZUdtF5ADDJhGV1aEUN6rBjbSBLygY8DOsyTtIFB8gLze0ZHIO6Y+70RYB?=
 =?us-ascii?Q?Mj/ruVTSQgz3J8XoLZQqCeXRLyPVY7ioDrBfYvPdbY3KYH9NZRJpgzwTl/IK?=
 =?us-ascii?Q?h26VBOse0EnfUSfizDl2t8LNZPvPpFqKw8jHj6p65NVGbFCKE4BQ85pvgR2G?=
 =?us-ascii?Q?vbn+uHkDItOP5O9I56cmCzcB7X1AfIvKcjG9My/GpnhalG93n3KVF9Qkxtkg?=
 =?us-ascii?Q?ZrID5Mnjppb8wW58HcG4ytENDlYLRKl9JihdenS1ebQj3v/ogjNKPfW1MZpa?=
 =?us-ascii?Q?0WRsej+bT142qHwKLg60a+2wdVEAeRVCM4N3eRR3JdNRjCaAYWgah2Gh0bGu?=
 =?us-ascii?Q?7e1YWePT4Nu6wCSk8KkOPzXfcfzL+OtrPQK+3u928GHMXilcxokOs9sVzk73?=
 =?us-ascii?Q?6bz81nZxbbrJKaANGOmZSI6la7SFn0OA68kILUVt1mzMCmjlW663CA/vHjbs?=
 =?us-ascii?Q?h12deSQNzWRfLERiYPL1Cl4ealZkL9lF45HmpiTwPrmgn+JHrha7Da22xMgV?=
 =?us-ascii?Q?f9KRHxLlhfC2fnvrIyHjjLtnRM705J0rLc+o+gqz1oKw8QJV3J6X4z7ufzWL?=
 =?us-ascii?Q?q2d5Jo2jnfTwbRf5UcIjiN6zGnmpgYCoQV3K0AjIg9iAx1ULFmRfv0HpyVVz?=
 =?us-ascii?Q?WdiD86eiU52yoX8QEhz8RJIUyhM6Fv1gm0snFsnXJ48AWXvRex8rC68ffR0r?=
 =?us-ascii?Q?RqNOdTbuUnN5RJeTv5ZDIaZR3j2T1ni/JegGN3rMf3j/BaN5/mOTeglOrF+z?=
 =?us-ascii?Q?AHGu4a6P7RKqMrcxCrGO0h98YaR1uhnclRNMt/Jpikq5N93sGR33epu0hlQO?=
 =?us-ascii?Q?iHxkmZh25HX0QueVIrttBtXKHpKvO0i6e8MLXdgnHR0Uz4lRHsBbdOcj76QS?=
 =?us-ascii?Q?HS0A5/hdHixQcmJfSiNzlb8Vhh1wXbN4dNsL7fFUkvQJxT5xxYDgCv8SxrKY?=
 =?us-ascii?Q?2FsptuQV6xp9pm2AzO/uGBR559VNV94Q76GIcD4hDI1fujZ7eh6HXRKQhlbT?=
 =?us-ascii?Q?HGhhO6xXmV7IUg5nzlFNUneZpvFFbvkzER1xrzM0jTMTMRC8IKeOICmydF+q?=
 =?us-ascii?Q?EdciEdNLUWqHnjVR4aDvmcTztHKjSD/W8mhhQTw3141O1IZDATP28GqwpHjj?=
 =?us-ascii?Q?2rPolnRK2xpOHBcuPsTMH9sX3HQeTGSgodCweAlcnyCEfiMCYifiM+EHjY+K?=
 =?us-ascii?Q?XTJ2advPI30x0cWOaPR/CXRu9sdciD9QcbAJ7IuR0Qxd7N8mOAAQHPFr4IG+?=
 =?us-ascii?Q?AswgaCsT9KKSMJjOVcqPIFLYD3+NuhgK/X2GzxfiJrrfaQmQSbQoPp4gqD1r?=
 =?us-ascii?Q?U5bt5QifTt7xhGqwzdyq0F7m7aKqpnLKcs84YaB59NSCwerLTw1oqcCZA0S+?=
 =?us-ascii?Q?2HUxa+J9y4m2HSe4s/jtn/vG2SZUJUIlDv3vPEF+AIOQ7prew5n9DUck+Hve?=
 =?us-ascii?Q?XX53qI6xlInh6iFHZw3oE4CJF9bhTTNrMQsUQ5qpcaMrxIqQpaa+Wy8A0Iwj?=
 =?us-ascii?Q?YGeVi3GcBNteEAPE9s5yJwo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c521d0-3b6a-4c54-f5cf-08da00161b06
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 08:40:16.7193 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LbJQhD6t+iMlopEiHbaYCULNRSaqeNjPfKRwZzCkAfY2mdFUPs3gKUXc7KMTP1bXVFnj7PEX5PQ0GK3UvfKHpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5895
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Huang Rui <ray.huang@amd.com>

-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>=20
Sent: Monday, March 7, 2022 3:54 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@a=
md.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: change registers in error checking for smu=
 13.0.5

smu 13.0.5 use new registers for smu msg and param.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/p=
m/swsmu/smu_cmn.c
index 590a6ed12d54..89b22b261066 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -160,11 +160,17 @@ static void __smu_cmn_reg_print_error(struct smu_cont=
ext *smu,  {
 	struct amdgpu_device *adev =3D smu->adev;
 	const char *message =3D smu_get_message_name(smu, msg);
+	u32 msg_idx, prm;
=20
 	switch (reg_c2pmsg_90) {
 	case SMU_RESP_NONE: {
-		u32 msg_idx =3D RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66);
-		u32 prm     =3D RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
+	if (adev->ip_versions[MP1_HWIP][0] =3D=3D IP_VERSION(13, 0, 5)) {
+		msg_idx =3D RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_2);
+		prm     =3D RREG32_SOC15(MP1, 0, mmMP1_C2PMSG_34);
+	} else {
+		msg_idx =3D RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66);
+		prm     =3D RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
+	}
 		dev_err_ratelimited(adev->dev,
 				    "SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x%08=
X SMN_C2PMSG_82:0x%08X",
 				    msg_idx, prm);
--
2.25.1

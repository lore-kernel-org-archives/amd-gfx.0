Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9912AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 18:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E6FE10E227;
	Thu,  9 Dec 2021 18:43:04 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2051.outbound.protection.outlook.com [40.107.102.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C50C010E227
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 18:43:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6op8qLfXzTEO8Rp4gJl2mdaY5rGBtdPHSMCHO3OCX3tt81erTWzOZAOE4bP4J4EwIcwtqspaNIcZpMBZCr6uwjyIsbxCFQvdFbeVNoAn4KvFILLqvVeYy//Zd8Yer0IG/zDbTaP7im11N1Fmp6F/4he+qbPQmtoe1h8AE5tUO9VdOD8B2YoXfDqcIsbMfrS75NKVtWO3nkO77GSzkL+9cOz08IlzfEUDui8lIkGuEdJwwCIU1wv/HevZanXZNaN9PEYBhzzL2jaPANRZ4Xhll2e6T7RQpDSFVkpAMkpKXFffjueqdqCY8O3KvPUFyLQPOIT+df55b+S6w9bvBNbjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9mkv0WbKLlYLmQXC5v6yD0/anOrgVdTOh3+DQRK9jw=;
 b=VbOI2ZOreqVcJYpZKYK/JsA4QFEHi4d1hGbjrq8JOx8ymOHnlPKutnTyH3+RoJT+yTfXiJiQz4WbvRhaBWKrKcqk0c5QoWdd9zkbCJEWx/sxy1f7yEIGLPxNs2JFvApQjZ698HT7Jny4EsgRkx+SLqkUF3UQvdIzhefSZITqIQABtGZXnEeHsAe4SthmxF1dlQQETitvepatwaNonAv1BDxTIEqQXepcfqQGFeXvytrS/EUP7SXTDqsQCfnVwEDt5POTOblDDs20N7nxTVST+KX/+sntxD1LVBTLvOAvbsKcUt5oU6gG2r3Cts7T+ObRZ3osAp+kmfI6c7j9LDOePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9mkv0WbKLlYLmQXC5v6yD0/anOrgVdTOh3+DQRK9jw=;
 b=eS1Yo1Zd881fg8Ow6T873GG7w2j44HhJjDqJw6JC/YVwg43EM6+4emLMh3K+JK6upZpmulx/vCTmA9jbGxOUoFydozKPs3/g31SK57Zr9fYBeOj/COSkVlg4ILNmuFxp0Wy1MUOXpb6y2SV3In/MiOOw8h5iQFLRIoH42jYA/E8=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CH0PR12MB5027.namprd12.prod.outlook.com (2603:10b6:610:e2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Thu, 9 Dec
 2021 18:43:01 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563%8]) with mapi id 15.20.4755.025; Thu, 9 Dec 2021
 18:43:01 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: SRIOV flr_work should use down_write
Thread-Topic: [PATCH] drm/amdgpu: SRIOV flr_work should use down_write
Thread-Index: AQHX7R7hXj2Pd4he+Uu7uB76uGwGwqwqeV9AgAAC5QCAAAHwUA==
Date: Thu, 9 Dec 2021 18:43:00 +0000
Message-ID: <CH0PR12MB5372CD5E3B82B166A23A15D6F4709@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20211209170211.506360-1-victor.skvortsov@amd.com>
 <CH0PR12MB5372496C3CA42E7A5BC63414F4709@CH0PR12MB5372.namprd12.prod.outlook.com>
 <DM8PR12MB546195424B06B64F504A490C8B709@DM8PR12MB5461.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB546195424B06B64F504A490C8B709@DM8PR12MB5461.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-09T18:25:01Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=0a0f3486-0151-47b3-8aa0-82723eeafd8f;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-09T18:42:57Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 0e99cca9-cef1-42bd-8d3e-700416935ca3
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3978c244-253b-42b9-1144-08d9bb43ba28
x-ms-traffictypediagnostic: CH0PR12MB5027:EE_
x-microsoft-antispam-prvs: <CH0PR12MB5027A885251568F158A0FFE7F4709@CH0PR12MB5027.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O9b1ewzyU7oFX8fHCknIzJg17GhVtPQxXdpjAlhQqlKKLAFL2EmDQfOcf7fjhDAGDa86aZfyiWHB67M6MlMTO+0HaGs7fyBXFg84o2a/qNPT1RJYVqYLor2/xTaZIlVDXY+Yqy0lg4+TZ/F7Evnlamm05POsqOk50Lec+Wh0D1Idh/JZgPEB/HUkvZTeZI9ev4MGlagRu9WrGFBGLKeQBtAvkp/HO3+MV0ng5+V5C6m13Tp79PrdRnT7hCfuODTGTca/1U5RDdbW/rW7pWltRkyX2/MNNhyH4B6UDl7a3eJIdFUw3pDns8lQCGpfXWJxaiO83dsT/eF3610kEGV4TlzCVogu/NRanoCq10GPJPvAJmIWdZAzgOuJU0ojc4cr1d+MT4nD1pFcWaG/g6e/pJSkA6FxnmXsPBa2ahGnANGc7iFyETSHTSEo2okCRaynwgxXDbdUIegnK0bDtQ1Xwh+yPLeI8NRK0RmB3IC6nxd6wmAKWqoteh2+BmEn71TYim9kWM47TrGic3WBxu+3nDxhh1nWs7i+Eo3z05tzFelUrCKZHXY55r18Q+E47BvqFkcJvRYtdMioT4jxIyUWJiTNY2Z59ntn69kSJKVQhUBR5sVI5KTmfyTNAtX5bXnbns+PraJQ0BetXgQPp1d7etOipFaeZiwhHugV6Tw2jlRtl9IPj39IJob3N1ApD4wj4WRW1uRbWHNn6dNGgLJgGA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(38100700002)(66476007)(55016003)(71200400001)(8936002)(8676002)(26005)(52536014)(38070700005)(5660300002)(6506007)(7696005)(186003)(64756008)(66946007)(2906002)(33656002)(66556008)(76116006)(86362001)(66446008)(53546011)(316002)(110136005)(508600001)(9686003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nKe+kJ7BMy1fNu60hB0ME2e92MB/bHtDSZUqxIpyXuQg6VWAriOGuy+QKtRR?=
 =?us-ascii?Q?00ybQ43HlObDmdKvLVOzsIgtBddtd9lpcFBNnF2xcdz55T1d4DJE5o7ydG6V?=
 =?us-ascii?Q?sA5bohfC/5Lt2aXlefirpP+PkVkh8zxcBCDdt3zWEVGDOQ+tvMLJlQvig2/J?=
 =?us-ascii?Q?QpTpHFek9eVI3xlHUdtJd5jGZq2/7AA4S+dc9xaXO1rSZkAEafV3eEy1TzaP?=
 =?us-ascii?Q?2jO1GqSIT3xa1orNqSFuAMiBsnUS2iFsV+16C1qkZio7VrndZEDe5T5URr9S?=
 =?us-ascii?Q?UcvwSwo8uuUHsgfTC79etlsREe/xeOAIAL2d4cI8GC2j3+pcvePs0UenBbn6?=
 =?us-ascii?Q?Sk0Hd8vG+n0767V33DNunlgKZOG+Y/K4swB2XAnUvv7xKM02YAJMrrrv3XyM?=
 =?us-ascii?Q?V+QoMmBGbWPdhuzGZpGNWFdTNTz4iHKuA4MjLeCGSsIKpSXjrqcTRQg9UIcV?=
 =?us-ascii?Q?Cu4jh/1K9QW5BnKaVo9bm5Fej3/Qwj9Fd9odlrSkKq/G6QwyuaSbBuOpzpG7?=
 =?us-ascii?Q?tzKjm68lgBMbwiwFx5/FlA40ijD4Kvd0KujWDAB18CffEpT+MmFSQJlKzkFM?=
 =?us-ascii?Q?jEFEl0M7hrGchp1EhhVgEHuWIOqyDnd07NFfFvYD61EGCbJNWxcPp3JbUiJU?=
 =?us-ascii?Q?QobwnWH7ZyW0vMQQFFrA4EwoXgEMfW9EtTcZmdwWfKz5e42ctGOrTVD4t9Uy?=
 =?us-ascii?Q?J0GBWoDTGXjn/niHRyz9/mYOFgxTxUnGw9wH2UE1rk4A10heAu3I2KLEY7GI?=
 =?us-ascii?Q?fdPfOsW5+iINrWDXZnUYAo8HPBVknpRNx/Y0dgThTCo8OeRMtyc66nHNnTmf?=
 =?us-ascii?Q?vFVKfYyUygvQSckJNuPu1B3Nkp2fBQBlvej/Dzwdmlamw6JfLEGHxDv3rmtQ?=
 =?us-ascii?Q?za7dlX48Jr38AcfScL9y4Jn3TlgXVAyPlxQx4day2FCDx+ln4ERdGCY4YTf2?=
 =?us-ascii?Q?x1fSHNMRwbD79CyWLElQIkPCWVjUsSG5xw9JYrAcLhPRAfTrwZpqq8GYO1gU?=
 =?us-ascii?Q?r0077W2P3h+aOq7lQGrXgcLjRRLW2EpebVhl+eVCUdgrHCpj/twD8ICWiWiz?=
 =?us-ascii?Q?FR5b/s0v/bwrIRcTr1TCuYLfmKrBqmEkovmmYCG0NtujmT9N76gdnkPd360Y?=
 =?us-ascii?Q?23HNMmP9v6MwPQWaDISH33EinicWFva8yLujNQSHbklPI58RVBKEotEk2YJD?=
 =?us-ascii?Q?YBpXW+W5flRGLXoNWVbQfCeaMr+y9Hij5SJYjL2NiZOdrEuAPSZeOoWQVV6K?=
 =?us-ascii?Q?UtEI1IX4SI94im91+0dkZKIsV9ca2FsHBriRldVKSdr5sVGBGph7En9l6foL?=
 =?us-ascii?Q?6kPGvUJz+e5GC/3kCMRTm/m0IzDsn40xbX2Ew+FnmtPD7ibZWdw3udFdjbIL?=
 =?us-ascii?Q?gZCWR9eMVXnr1K7BK6ZWKBVnBczXSVClo4+A8JVAHRdLHMBkCm9szEz0qgVS?=
 =?us-ascii?Q?SMciWRJWQaN5dEjnaXk6EMjNmlk4qJKFgt5CieQWyaAa1qK70i+MebsCDHS/?=
 =?us-ascii?Q?ZkdeInlXIWDDLxD2G2UtjmNhmvIbH3qszwiWX1gHUU3U87MpSGYBWDmGTMas?=
 =?us-ascii?Q?IWnFNYyKPwmwDeJTKyxUi8fvExd/CJr7NugArctxIK8hA7+Xi3/QpFkjJ1v3?=
 =?us-ascii?Q?iQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3978c244-253b-42b9-1144-08d9bb43ba28
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 18:43:00.8782 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: addEZUwi4y2G58IDwiRVTDLxOfpnhwdSmUPItxrq7FLzrU5Q/78snitgWqA/zAKJJEcIGHmxwjdYZ88bVB7UTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5027
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

Sounds reasonable.=20
 This patch is Reviewed by : Shaoyun.liu <Shaoyun.liu@amd.com>

Regards
Shaoyun.liu

-----Original Message-----
From: Skvortsov, Victor <Victor.Skvortsov@amd.com>=20
Sent: Thursday, December 9, 2021 1:33 PM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amdgpu: SRIOV flr_work should use down_write

[AMD Official Use Only]

I wanted to keep the order the same as in amdgpu_device_lock_adev() (Set fl=
ag then acquire lock) to prevent any weird race conditions.

Thanks,
Victor

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Sent: Thursday, December 9, 2021 1:25 PM
To: Skvortsov, Victor <Victor.Skvortsov@amd.com>; amd-gfx@lists.freedesktop=
.org
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: RE: [PATCH] drm/amdgpu: SRIOV flr_work should use down_write

[AMD Official Use Only]

I think it's a good catch for reset_sem, any reason to change the  adev->in=
_gpu_reset ? =20

Regards
Shaoyun.liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Victor S=
kvortsov
Sent: Thursday, December 9, 2021 12:02 PM
To: amd-gfx@lists.freedesktop.org
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: SRIOV flr_work should use down_write

Host initiated VF FLR may fail if someone else is already holding a read_lo=
ck. Change from down_write_trylock to down_write to guarantee the reset goe=
s through.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 5 +++--  drivers/gpu/drm/amd/amdgp=
u/mxgpu_nv.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_ai.c
index cd2719bc0139..e4365c97adaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -252,11 +252,12 @@ static void xgpu_ai_mailbox_flr_work(struct work_stru=
ct *work)
 	 * otherwise the mailbox msg will be ruined/reseted by
 	 * the VF FLR.
 	 */
-	if (!down_write_trylock(&adev->reset_sem))
+	if (atomic_cmpxchg(&adev->in_gpu_reset, 0, 1) !=3D 0)
 		return;
=20
+	down_write(&adev->reset_sem);
+
 	amdgpu_virt_fini_vf2pf_work_item(adev);
-	atomic_set(&adev->in_gpu_reset, 1);
=20
 	xgpu_ai_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.c
index 2bc93808469a..1cde70c72e54 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -281,11 +281,12 @@ static void xgpu_nv_mailbox_flr_work(struct work_stru=
ct *work)
 	 * otherwise the mailbox msg will be ruined/reseted by
 	 * the VF FLR.
 	 */
-	if (!down_write_trylock(&adev->reset_sem))
+	if (atomic_cmpxchg(&adev->in_gpu_reset, 0, 1) !=3D 0)
 		return;
=20
+	down_write(&adev->reset_sem);
+
 	amdgpu_virt_fini_vf2pf_work_item(adev);
-	atomic_set(&adev->in_gpu_reset, 1);
=20
 	xgpu_nv_mailbox_trans_msg(adev, IDH_READY_TO_RESET, 0, 0, 0);
=20
--
2.25.1

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D15C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 18:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C733910E202;
	Thu,  9 Dec 2021 18:25:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D8B710E201
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 18:25:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6gb6I15QpY4vTdT2zw82PMFQyyD9AFs9HXz+sgGlQKJ0yFiQdIdqMzxo/M73Wg/7FXbX6a7AGt4nkXfGwoHhWjL/rUOsNcD1wwDSrW5RdHYV+BdFBrayV1Zcee/LbcI50aAAIJv3JUbvT+pih69OtdGvVd1JKBGpehT9st453T/BMgt7Y/4cVkeBZpdPgUNCVwc5EzmvWkkBAChUF7/OUkqdz+dbixtMixl2t+eGUp4lnnvJ9Sb19JgnKJWVGeohswRJdEQxUN7tG1c+kcmZu0/cLcnhI5a7cRaquZaILejYe2CR+Cb4i0+Wc0zvbzVTozwXFhpLZnnfwDyjNELpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAvMhYgswqEk0Jxi/8KNXyHEHvvLn4xfa6xcZkXRZlk=;
 b=IEIauymVJjvWzO5n+DvM1+XR3K/dzg33yOGJlvVzNb97h+ertxOv7otR6zlAzKBJUG5sgtyox+kjoo7voELnqCeUJJaEKFIRb5VOWtJoNffIKeq1fvCbA7oUoxsVPnAo4xGFKaPLQe2qfW3Qd4BUK6Lkp1eXSGrd1VRLZcld62boC5a6ol4RdzwJCXJWHJT5HPEb1jCQlBR4EVxtk/0t5WS8t2YiL73CZGE7TlDn5CNsqtX6yQeguMaAqrYsPNvVNCpJ8vOHUwMjgVnZbb+nQZeuJQwXqyQHP3t4oDwZFdEZ/zldTF5uATMIU0Zdy7j/KZjowq5DJsc7ScEetkq9jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAvMhYgswqEk0Jxi/8KNXyHEHvvLn4xfa6xcZkXRZlk=;
 b=W9ZQu2od3HMCaV1l2HOGHFE+mhxVzElbXR0Gf7jsl4Qx/ftd8isFO82wH85G4GWxrBSq5XTSuADywr9Sk2w+hvEh1XBekqZ0/AeRalLRxxR1trIi7vB5DEbi8+kQlQUvttUt2SZTvvPWlIYm4XVEozSj2FQfYtf3sNhcf1XldXA=
Received: from CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10)
 by CH0PR12MB5233.namprd12.prod.outlook.com (2603:10b6:610:d0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Thu, 9 Dec
 2021 18:25:03 +0000
Received: from CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563]) by CH0PR12MB5372.namprd12.prod.outlook.com
 ([fe80::31b4:ebc:1707:f563%8]) with mapi id 15.20.4755.025; Thu, 9 Dec 2021
 18:25:03 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: SRIOV flr_work should use down_write
Thread-Topic: [PATCH] drm/amdgpu: SRIOV flr_work should use down_write
Thread-Index: AQHX7R7hXj2Pd4he+Uu7uB76uGwGwqwqeV9A
Date: Thu, 9 Dec 2021 18:25:03 +0000
Message-ID: <CH0PR12MB5372496C3CA42E7A5BC63414F4709@CH0PR12MB5372.namprd12.prod.outlook.com>
References: <20211209170211.506360-1-victor.skvortsov@amd.com>
In-Reply-To: <20211209170211.506360-1-victor.skvortsov@amd.com>
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
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-09T18:25:01Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 59695d9c-8fad-467f-8f7d-efb0c858c0f2
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 803c30bb-27b9-4f63-4740-08d9bb41381b
x-ms-traffictypediagnostic: CH0PR12MB5233:EE_
x-microsoft-antispam-prvs: <CH0PR12MB5233F8C9CF3801B42CB32E79F4709@CH0PR12MB5233.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hs5iIMW160Yc43BfUXM73Hfe0vP2CmEz1iOhOlkLEYORU0YwPl24vPTDXesgdcixS9X607fncIUp+jh+0z0OtabOyRBbZ/GpiZDEsJX9j01OKa0VtkWz9YdP3SPSGSVgQi54JV6Sg7R726k/UA3c8DQTX/IEyftZqrPhP+E4iydhMnu7P6/oq72MmE+HqX0BM3pl0Z3OLuRKmvPkJPVJnbdJSWYykib7lhFjpi2EEeiEFYsXLAyKycQd6d/Rx192GXN5Flb7zyLAk/l9U6417lNbMWcVUUJNk46jbUn+aP+jsh3++TLpCH3OdemSTR4Cgj46X3iw8VgpY9VeNyjRY3qKAQvlz3rPmC0+pPGMMWok8m4aoJ8EXkxldMymXXSfDz0pB1I6ac8SgPQ/QnDGA2NsjScXo4HSeA560elLMjHPXHbO1eZMV9z3DGlDquzZGpp8x92BCs3aho575F7eNqrmJubBIWbgOd20t1b8u83jgCERfPHkULqZDekWsJiwSVU20x4feJAheX5RSadV34GNV1Jdcb9Roci4SbMKlKT5hN6Iq1Ndz+po2BVMT+L+dntKVZPfRqcUDoO7ogXT5Yr+5Nk1unMKs+/E3LF/aELRGE8+haeFLONnynjL9oY6Lr6d7OeAz3oWv1tN+RF/nplYkH0AW9QCVa03CLrTxA1F+nzKymdzeE+upoCbWmROhjTes1p85EjDFsF8if5TBtC7YWv2F9h53LdrUT5JWdpA/VZlTnHkzxc8nI5gUb+5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5372.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(38100700002)(122000001)(38070700005)(26005)(9686003)(33656002)(53546011)(8676002)(83380400001)(2906002)(8936002)(508600001)(71200400001)(4326008)(186003)(55016003)(7696005)(66446008)(66556008)(66946007)(64756008)(66476007)(76116006)(110136005)(5660300002)(6506007)(52536014)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H8TcZVrC3waSh/3L2P8eo8I2GIkzomcitM23mWVHKYHJ+ep+mJkyRBAdqv5c?=
 =?us-ascii?Q?hKM6eXW1tUrNThzNP0FynCFPwowPMV4MkeoZxWYlD8swDpOVBWN/SnmoV9s7?=
 =?us-ascii?Q?fGAcb2lw0MjFGPtkGnEQCUd41DE9tseaLWIMWpSh30gSF0bcIUUVYTBn1Bpt?=
 =?us-ascii?Q?be+Wo+RWk18ow9uJ2FJ25b+zDie+oMScqMoDoS2c+1JZR0yNbZeVWFb2MPFU?=
 =?us-ascii?Q?OL76NckKG1el04J7L+rhv/+zByqy1aigevASugC9QCDWSpTf0WJ21WSJCeON?=
 =?us-ascii?Q?R2c1nUN4q4eU+W00VtUXyF1gIVPy/GKNWJk2YK1F9uws51rxjJHgyjRRvUCT?=
 =?us-ascii?Q?JHfwO2tTwuiEhvH/dXqWxPTPxuBjII5CSTu4dV5PArvmnaWCrYOQNtzmwteY?=
 =?us-ascii?Q?la5JRp7csALozOU639mhGlCb2g/XEmvq6RxmgTNqnAuPB2BXJQarzDbZQN2z?=
 =?us-ascii?Q?hMKs5EmKqMijWaXWgAKQutE7yf0OimAitw800TgVwKFACGffrgskXOWtwAjc?=
 =?us-ascii?Q?Ixn9asMOoHn+bS424QQSZR5X/HsacdZgZkvikajtVgdZ2kp84QECVe1SghOT?=
 =?us-ascii?Q?OMY3Jb+SAhZp+8aDn5POl2hpWj+o5O3DvBGL+V/XHc3XLWvOq0FZVR/zxlg9?=
 =?us-ascii?Q?5WFxKfCF9B9bkeSMAu7OH+15Y0xh5uVVJ/r94CXKBMfovTI46CzxXMuBVmjn?=
 =?us-ascii?Q?2XFMxhQLpG49xL7SfQ5YRE0MJDvYv5fLO2zuwakM7ZvmyDeqgamFGDFkNtnk?=
 =?us-ascii?Q?fh/bIs5pAErJpO/wNa+z+gxj2T8dVsZevh5//c8POl5LMcFtjZAP2P+CwVs7?=
 =?us-ascii?Q?zD42gokA4bC8sPvgqBRbQJn/+vuJJG9RBLuV+6G3wYUqzU5TWCQAgpRwIqSn?=
 =?us-ascii?Q?dE38BQ+NO1480HoH96ezt/osYyOy8RHsKQ/a83RhUsXglZPrBOfxGDa+5b14?=
 =?us-ascii?Q?ZSK5ebTTHQW46fG3z3o5dPCjUbHjjX+n94u6gunDiF9agGAJnC58O2b6Lv85?=
 =?us-ascii?Q?gztUS3Od9m4a7rfZP6u2VmRBeGr3wq/eHye3KI7ddv6FukooJmClIog6THts?=
 =?us-ascii?Q?4fLiHo+fYxK2KZImUfLEuBMRO7J/QyQwP6sWOlh377rzGowr1+s93QsP3/+Z?=
 =?us-ascii?Q?wIsGCRWhOvR+Ck2rziliffnov9jmQGnLatialD2tOf3p3HzbD5omjEe7k8o1?=
 =?us-ascii?Q?vUTSd24/0KuZ3Lub51Rb8P80eVGbORNEXkc9iqxSS+pYDyZqhBapsGvRh2X0?=
 =?us-ascii?Q?AvnTX0chA1tA+mVkgUUIAIN8bIqCjVmZhgKQXciq6RkqHwE7LUWEFixj+0c/?=
 =?us-ascii?Q?JU1rVsTxtfGnIT4nts3vktoPf+up1P4yuanqISOBYbNq0CMguzmdfHWKkKS0?=
 =?us-ascii?Q?/phOBTk16KpOos5nO57jIRr9NfBdADZQSryipS5UOlXD/zYRcFFYcsaXXiuy?=
 =?us-ascii?Q?D3X2jt0BzxcKRE5o6w7CuivNAZnRlBlaAFH6ae1ok8z6uNTxRBI6Ac9xuZFr?=
 =?us-ascii?Q?MrDvabt6mEI+tkjofBODUOagswkEFGVoOOCd9e06K9qyHqNY6VzQv4gt4al+?=
 =?us-ascii?Q?F4a/L9H0AY36Tb+aRFZJ2aC7CRuwN8/mDx/ybilRtP7Dl6z6hQ+Hd3Y2XYpx?=
 =?us-ascii?Q?og=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5372.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 803c30bb-27b9-4f63-4740-08d9bb41381b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 18:25:03.7260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pAwCiTEv08XlZ4vgBbrSxFh/3cVFS2AqmhHgjeAxZ3y50XkhkkEJo+LptMkKqyX7sXWbMSyxIGyqLJEt/0jwlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5233
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
Cc: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

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

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACFBC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Dec 2021 18:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC09710E12D;
	Thu,  9 Dec 2021 18:33:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE4110E12D
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Dec 2021 18:33:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvcQ9g7fm8Q/z6Yzf+932ZbMXWMvoKoK6DpH9XeU9vXQFLIcbnCDFLFjSNXkiLM5pGQM/2+Wu/prc5nVpklBsAgiITtpESnuqfy6bhm+aDaUFEp3iy73ZHtrqhdUFVDGfQavY4QAdPEUE+rhen0IO7b+PaEQzam5arAiM3HOxTLYKyQSjlSaXooH69ZnI0YDolNAtQg8be5Vm7bmTFbstH3KLf/tRGvczOwFJDOgW6l5FQ4e0IfPi7/WfgypkycSEKx9ZNIP8Op2+dllbGQ3z8W8IwWp+6zgb4pxePobBCoOG9nAXZuUGvbk+I/HKCGWMi5KWn+zAMoawSWMr7EJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EY2YzWXocbwl7t6vIvrp0SlXvmjs5TQYn2wC9hM9clQ=;
 b=NkXmjiXFBeRgUBqRT+t+VKGjrl9RhQA/PoCtszcGFx/2JFc07fgwnT5GPpjFvp7/lEo/jqsRB8W0pnMlPn2E2huUrCIAZN1qusKQNsp+HR0M0qEylPiw4Bz6X/Rki7TZutLpxT+w/8W5/DwuHLg5p2k/93VyGYm7PPFgtE+NfxGwZjgzzSQ1/v4SslX6lt14ET5nr3oY8O8Y/CyXtmDmd4/rAhx8c7kcjs9Qhflhq7O6fpXgxD1tdCZmr6xcDtNGgjKxRLpggtqGeLHgzxUK85Qc7xift6F665jTTD+SZOjT/g56sU3x4ZFN4w2xMG15R3C8CXxEc+4QORxCIv3c+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EY2YzWXocbwl7t6vIvrp0SlXvmjs5TQYn2wC9hM9clQ=;
 b=2/wACpCE2VLGerUmY9EVtH2/vmlDGUk56vuZLWp9nMSVLMQGmeLFOKsrvCMsVT6JnNZIAqZr6+eqrNpFclnUPIVzGnfQtxP/VeiG6ecGtG6RfVI9Z6Rw5GMxEejS+2E6oCL53uWR6q+cZ1OIr+ssf+Da4iNbKEWPAPj5KKQY5v4=
Received: from DM8PR12MB5461.namprd12.prod.outlook.com (2603:10b6:8:3a::19) by
 DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:38a::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11; Thu, 9 Dec 2021 18:33:26 +0000
Received: from DM8PR12MB5461.namprd12.prod.outlook.com
 ([fe80::3596:f291:fd5c:de6]) by DM8PR12MB5461.namprd12.prod.outlook.com
 ([fe80::3596:f291:fd5c:de6%3]) with mapi id 15.20.4755.019; Thu, 9 Dec 2021
 18:33:26 +0000
From: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: SRIOV flr_work should use down_write
Thread-Topic: [PATCH] drm/amdgpu: SRIOV flr_work should use down_write
Thread-Index: AQHX7R6M/7tDobqU60i7xXfbvyKgF6wqee2AgAABIrA=
Date: Thu, 9 Dec 2021 18:33:26 +0000
Message-ID: <DM8PR12MB546195424B06B64F504A490C8B709@DM8PR12MB5461.namprd12.prod.outlook.com>
References: <20211209170211.506360-1-victor.skvortsov@amd.com>
 <CH0PR12MB5372496C3CA42E7A5BC63414F4709@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5372496C3CA42E7A5BC63414F4709@CH0PR12MB5372.namprd12.prod.outlook.com>
Accept-Language: en-US
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
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-12-09T18:33:24Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 9bb5dbfa-be11-4c9b-ae4c-f0a0a6f96721
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccc17dfe-e13a-4cb8-491e-08d9bb42638d
x-ms-traffictypediagnostic: DM4PR12MB5055:EE_
x-microsoft-antispam-prvs: <DM4PR12MB5055CF0C04E931D52A95C3E18B709@DM4PR12MB5055.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9DdWvMu0sXTEHNcOG/UDwMNDaZvB0ZiEAzt+QSH7UxJ0RdI+tIbrG4+gkoc+jnBnThTF/ifj2rBh3GqW/utVjm2MMDslkWTFU5ixnNZiwp5WpAJmlQ7nlaLYl7DB5ADfWZV9bm4WTdFTQZCCWmi1hucEUkQiE26oFmzqzw+bbhk1gmvrM9V/lgrM7T1k7Cr9FKydTmndqjm0Wi763V7sH/maDtbSOTzQAz4T9CeS5hgZH6PvTumMZyTtP0cwmm/3ojBAAa1HUanaLKmakO/ig3jrSeFs3eC2idISHlh7/FCHBJZQ8WZtEmGap5TCj5AW9+DkUpy3IKxycrd/Q6tPmOQXfftbj769kSl7QOW2CPLFoBCDhaex1vwXzO1s+Y+Gt3ZNlByk+HrsFFwgP4CxNq/gFH7ZlSbl52QTqSXhj7Qr/Ii/LWuwTLsREWnuIpUbsceARj3LjoKotAe3NMu/BdNF81rKhtkVPk8QjMHd1Hv9I57qnHRmvHzJH5Ciw2ZYc9bhB6uPxb8W5MQQPtScfNP/o8T2piyCJDtPDq2kCHOPDRj3Idal0HaLHpEjYPcM2sJm+XKJT/+hzRSIIZaNCKwv7Q7ExQ16uP6/64IzuN4PAfbiOWcJdrbptUfTU4RYsObvChpMQA+yXYWny2h92XqMSVSibboWQaJ8jFfJOWlY9mLlfWJ+WWh4mHqhMlolqcpbuK9OUiDC/uKuyxs73Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5461.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(52536014)(9686003)(122000001)(2906002)(83380400001)(38070700005)(66946007)(316002)(26005)(7696005)(38100700002)(66476007)(64756008)(86362001)(71200400001)(55016003)(6506007)(110136005)(66556008)(66446008)(53546011)(186003)(76116006)(8936002)(33656002)(8676002)(508600001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oUhsk+VEN2q+ELjjcLk9gYa4zS31ptQuMZNA2SuLQ3+mj2tf8LQlXf/HrvQV?=
 =?us-ascii?Q?GMd8PS01VZ2X3EEfkQTMlObKlcuz1YsPiyK4XOqeIsLjbb1UGiYOKKWNEZTs?=
 =?us-ascii?Q?ppBMA5qOi0oz4Clm2LRXPjxGSGYoZcO9zQ3CkDsUkfh3JK1qvpjhxlo+mNK1?=
 =?us-ascii?Q?BTU+ZnOttLZ4AILqcBDdbILIQ+YxWHDQ5dXzsLuEmVOzyxpFfmUb8sEwyw4g?=
 =?us-ascii?Q?JbGsD1c4tUBHoimggsQ85nSVp+dEJGlhNqrVZ6xcKKaznCI0JXIvw0hfldN7?=
 =?us-ascii?Q?lTFkaA3gepRbWZRdEcDriyhLP94km7ux/QKIXMh3kpkj8vdjI77bitbobYLY?=
 =?us-ascii?Q?4pyPNWFf9shLJhu0i53CtsdXWt5wmhlB9r9uAbDq9ab2iBvPs8KNDey+8X9Z?=
 =?us-ascii?Q?TTdq/xsIW1AtTvAmhBHBPSbOGplvudqUK7ank+A2V62nbFP4HHruyfZY5yyr?=
 =?us-ascii?Q?OOaYEOOMeF9KZlb34Rq2NcuDznn9z68NND7iUKtMZKZaEmdqmkGC1tapX3BF?=
 =?us-ascii?Q?5uA2QWFKl3z6Odod8CMDF4XQI9W0o4GPtpkafdXZKpx4ftV03Mg9mWds1q9J?=
 =?us-ascii?Q?F5nOEHJzCw+/e4mO7Bv7vHUZDp9uU/Nm4vIFc1l8cw2vGSUQWmaKwI8Wmsv1?=
 =?us-ascii?Q?ymCNbIb7iKRiPc3nlTfwDHv9loOFR7pEUwlWTHtyR+UX2ii/mWZHQ06Ln3m+?=
 =?us-ascii?Q?4NvV+ncsbYCxOOTrDvLVlZf1AiuWZKv0CBd4IDgzhq1rexG/3LPdJyy7H4c4?=
 =?us-ascii?Q?gvWyqi4sjSylICOm6C2YaEr8cocBF5klw5548/z8Af7G5vxZRB9Nin//ZzkF?=
 =?us-ascii?Q?Uqiy5B1VWTDXbEmIx4oXxosUDQp69MROtwzvMn0FGwNaZ9Rwet0c9m6npmzE?=
 =?us-ascii?Q?2dI/CtX3kSG7uJqvob5uaPBfc5CatFr+WvBlz7SVmkdN9iBz9c9lU8e0DDhf?=
 =?us-ascii?Q?OJnezkTsPEGoVnPjU6s9Wk/QUP+spKHv/gkGSUuzMsODpS2fU/CQgcjcnhiH?=
 =?us-ascii?Q?YL752+nmscQ0LT4aE1LcdUTl72A3qzIQhri5bEAeGMYPTcpUvqcl8gWktrwi?=
 =?us-ascii?Q?XM3ZDw7hunaLsjP4zrW5GCGEzkjh/lUgnS9DITlvmlTSU5zH+NGmg8xF3Tlw?=
 =?us-ascii?Q?RZuuioozTd/Mla0IenLSB1ENMtsEZohNReiRJ9imhYL42o/4I/7nvJWLJAAW?=
 =?us-ascii?Q?KMjSpcyKp/29Wj5oqNzMTW1xdfjWzyL2hK+YeVkR4Jkkvtdt1ugpMLIgNUTz?=
 =?us-ascii?Q?Gaf+KJ1FXluLbJcvGx6wrBRN7r7l/gyd9k02Y7caQayag6fdcVpP9zb/74Xg?=
 =?us-ascii?Q?ThbrDsyp0WRp1o+xSG03XkJakliGbDJEn16yopl8ddtHKdQOmcEJLy5445PW?=
 =?us-ascii?Q?tTVGwIH/qZ/L95+ukSjMWVJNot4tlnUHbF5tRC5KhXyZuwirvQg3Qgy6UiBU?=
 =?us-ascii?Q?pySi8tCEY+0jTOpiWVreh6A6jv3//YrFrswenILVdYvB2ERuXREzQRHyZaYx?=
 =?us-ascii?Q?WqXKq71tMn4xrT3fMMTJtj1QtBeLfaqMcsYufPixlu1Pzb2bVzG5YwIr27uG?=
 =?us-ascii?Q?1v44BqBuTDGJACT4m1N+BvChtDmcZvxt8ISOQJshEKkzB4vrJwt8JcZZyrAy?=
 =?us-ascii?Q?uMFnMjVuR6gqVfcctVaEwCc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5461.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc17dfe-e13a-4cb8-491e-08d9bb42638d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 18:33:26.0750 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oLx+ZV+qtWfLiANrbGhzQ4jDLhkLHjvaN4TP8EE8/HO8V/vMTozQ/qx65Jg7l3hhOi3/JSYoKL7S2czDJO5kbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5055
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

I wanted to keep the order the same as in amdgpu_device_lock_adev()=20
(Set flag then acquire lock) to prevent any weird race conditions.

Thanks,
Victor

-----Original Message-----
From: Liu, Shaoyun <Shaoyun.Liu@amd.com>=20
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

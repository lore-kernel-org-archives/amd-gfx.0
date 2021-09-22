Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A09C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 11:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C14B960FA0
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 11:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C14B960FA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EB786E530;
	Wed, 22 Sep 2021 11:41:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCB5A6EB83
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 11:41:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQXDgiBVFsEC2S5CvOGJ11cxsclKqy41ktMJqjQjNKJfb/XcMCabn+5Bx6hMHEjnWGcIY8AevUYLhg+IXjzSHZ/qGvMliOWO2UFEbFgf0pLr0mNfiW3d/zbkjjKitQwhUIP40ZNqqy8zlGR7aayNn5cTM7w0C6JqiP3LGQFc9VAG90qiX55++7+6CfJ1f3V+ySLMU6hSl7Rj8A3X9NlpAI9yby4oDHTHfXOF0urzfwcg052RMSXSYZu9AdlV5Ol4sGV8wK4L5IJKPbNQLjlyw7WKPX2eGwDGo4Mz9ciBrxpJSVTDs5/ufaI9HLkvzYlQy/Kq2w97Q2i8DWnT+l1JLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=kfMc3WxXDzxKyyXqMypZu/oQRsOWPRR67+miunWQ5+A=;
 b=RYsExEzt3oLl+ZAwM2NzEJWv7cnjGMsD3EAEUOqsou2A5TEAf1fdj/xzfv9f5BdX6q4qUQXiw3rmPRr0n39i6MhuytaEuqIsw6avqJ+Z/dtZe82CGKQYDV0rsUVg1cepIpIqMnPYMR0ERbq2DuvU4OX4OV2djPehfg2xpJdsdR93+PjGemMlBa1HudpwnAV/KplniXiMs+jzBVzwViEk1OlJwvB2ZuqYgpiykQUCp0kyCrdQfM6pVT+4sVwrZV1bGVi2tAHHq6Z+xe463T0SokSybEn3zCRC969/tUM3Jt9SLSXQN5TnwWlRxxtw/6BGCH2XNTruxYVIhlSCZm8d9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfMc3WxXDzxKyyXqMypZu/oQRsOWPRR67+miunWQ5+A=;
 b=ZeGMul+jLrHR1q2WhZ4GNQr7BQtDLPZZlUoBEo7B+/JWO/ti1JSAcNH/uIiuFnyWhcLu5iEhF1RApcmRdYvjWj4o8O4icZXAoC26Hlh/n5PTkryKZnIV1ZLrY27WErZN/urIVmJPCibVtyTiPn7qJyW+W0Mgz/gguOMYGrLzxqY=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BN9PR12MB5292.namprd12.prod.outlook.com (2603:10b6:408:105::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 11:41:36 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::5101:db26:96eb:2ce4%7]) with mapi id 15.20.4523.020; Wed, 22 Sep 2021
 11:41:36 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: skip umc ras irq handling in poison mode
 (v2)
Thread-Topic: [PATCH 3/3] drm/amdgpu: skip umc ras irq handling in poison mode
 (v2)
Thread-Index: AQHXr507IkX6RjDfnk6VKf8pi7nLOquv7bxg
Date: Wed, 22 Sep 2021 11:41:35 +0000
Message-ID: <BN9PR12MB5257013CD64B28F0C05D8685FCA29@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20210922103248.2401-1-tao.zhou1@amd.com>
 <20210922103248.2401-3-tao.zhou1@amd.com>
In-Reply-To: <20210922103248.2401-3-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-22T11:41:33Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=0eeedcd9-a8ad-46dd-bcac-5faced340f44;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c876b6b0-17a1-4425-a681-08d97dbdeef7
x-ms-traffictypediagnostic: BN9PR12MB5292:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB52921156388601086DF4A325FCA29@BN9PR12MB5292.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jv+UI8tug3xNdbFpms6JiCXex3ACSHuSVIUDCfw5abvRQK+XPqOrZrEf/GGJj1fSUFqLaR2oOJ3ghPOYZ8Rl6oBbkM89jzTfK0z92dDkoKd4LMfqLOwmmrrfikGnPzHN5WxC52bIiS1IVyIM9YjCAaeqJB8HurLC0lfKprU+4o+k+dnhCqgGy1PmfsIm5a8qsJAuzMXS/XuN6ICHd+QRLcSEkOFtNij29VG6BKl1LujLFCH1SQQBx6Y2nbGA7/UZmkSLgbMvEOmLG1MUuM+ljt6fgZ13hmolt/7u0BdIErvlAGDW7ibGRQcpH0iselzJjk+6n2FFmjEWnxgLPYG4dnHdWM1X6PBxX+kiS9R5GTms2FixwEUG0afI0En1g5CClJ/dmMwOTjOIqLAMVrP8Z94uPcYoPZ4xAq8v2t71kVHAY2JLIUeEabDAJdECTcQ4rRFZ8o7+4p75J1K683LVTaylb8W5OU5QrZJVnghc+bY+enJFQU9SHWnqwZKDwkQsNl7J2z0yzX5k/pUhQTNOhHWH5nejaQY99EofYUAtpODrvV+9m09cVAOHJ1UrBngebDWyBto5RZAsG6N09yNdUFn7oJjgFdaphNmOJ0r55gXNStGFevMAkV7XmIAxnz+utRTJMWVwHTVdTFlvz51f9sYJbSpYeElQ1IlFIedqpkhBwGJiwcLOMB9czq99gBDlYDdheJMoxclRlYPbNjtCBA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(6506007)(66476007)(26005)(2906002)(5660300002)(7696005)(53546011)(9686003)(71200400001)(110136005)(33656002)(316002)(6636002)(66946007)(76116006)(55016002)(64756008)(66446008)(52536014)(38100700002)(122000001)(8936002)(83380400001)(8676002)(66556008)(86362001)(508600001)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QXksafZQVm1gjiHBPvtxfj371NCnYmxnymsEwRvhHh6e7o8PKUkQtBf9CpC4?=
 =?us-ascii?Q?mPLkK5CVcPj5FWJz0u+8cAXHzdPtKgQcgm9XrCvgi120sfiDxpEbJSS5X6le?=
 =?us-ascii?Q?OT3fJBXpGt/54tpye+5MlPIqU1+ML2gOaa3gTm1Rw5xyGnPc34GrxuIpFCUD?=
 =?us-ascii?Q?Y4R9PkzrwRUXWg/kgi7oAc5nkuN19wCt0TWHv6XI6p1AwxiUw5wI8htU/4hO?=
 =?us-ascii?Q?sI+0ns1d2szKx7v3jWYPBFct2o1MFfM01lOb7LfSMFPiVTeVDc58ieRnqYlo?=
 =?us-ascii?Q?RR81YDX2cTzGebq2EeZJUVzsN4JFd2FTM/u2RP9zZbOJ23lGgdmP+W0fwU7R?=
 =?us-ascii?Q?ndy6/GTB+ALrooxpTlG8Z8G35HRWUQ+4L2FRm/EPwk+fegtPK6TwFFI3av9i?=
 =?us-ascii?Q?gM+IRZsXJV1y5ht5znzzVlkKhx++FdWhUqyMgylJaC8yMVuPMfwORgCE7N1M?=
 =?us-ascii?Q?LKqJwL8gZeJip+B2RMCtzVLvKpvTf/+CJHn+MyYjsnzMAd6zi5AwZTmBsj2c?=
 =?us-ascii?Q?DV5UXearPAFbFMHtij0XGTRrDKvPqPxud9KUeuzRfbTJarhKG8iirr3KXXo2?=
 =?us-ascii?Q?Y0UD6F274O0/MhJGWCl1pKpQfElEOol/yeShEvlbhkAitY4NyP/dSb8VjeBq?=
 =?us-ascii?Q?KNXxzsRM5mTl+6VaH5lKFo4DbhJaZ/9WXBuXM3BD1om+KnvsDJ3u8pLm/5PT?=
 =?us-ascii?Q?kaPd0ZA4q/DIDAT/anr6l7vY79S49L18r787mpDaQcxpKrPU59jDn0gWNqfH?=
 =?us-ascii?Q?WH8/gFbNoDAH2H7MTmD/BgLy6gT2P9ZljpPtdNAf8XV6O9byJhEOApAO57Hc?=
 =?us-ascii?Q?P7xuDwmIN6elfA/DnDNo6JqEo+4e9cuhnzPoKUG9r5fArBVZfjjQkElFCJtA?=
 =?us-ascii?Q?KcJvFtzDpXdU/5oSm+SjpY+0ma7P2JET8Ee4edwMthNODLwOP97JmmKlIDbE?=
 =?us-ascii?Q?G4iP4ovdV2dasBi2pyI7XUnhcHpNHGXc2kVwiW+gZ6ka4B9j5z7G1/pXYvTq?=
 =?us-ascii?Q?ddC13nXUumeS+iYHs9Kv0cSs3oEItF5+CW9VIpHhxFXA4tslD9YhnIRLmlS2?=
 =?us-ascii?Q?dFt/qhSwO1PvnmHKKOkJXVZUlKDDo4l+Q8YKpN16WfJ8NnQtSwHChB6UKXVX?=
 =?us-ascii?Q?otxVwXcQd9j0ME7RS2TpyW//nA88FiZADYdyKSNYKMmD3mOLdjmjnjk+gCt8?=
 =?us-ascii?Q?7yV+My2DzVlvsTvor6aI3kiUxL5xGESrUMMu5M7e4+Fw5Bw9ew3sCdPM53h7?=
 =?us-ascii?Q?adASZvFGhpdJDzrrh4FfwICesNEj/VlYFlptfXwxjz38RqnxrAtz93RX8AWO?=
 =?us-ascii?Q?uLtftNFDcUoM7ppOUK4jWYoq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c876b6b0-17a1-4425-a681-08d97dbdeef7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2021 11:41:35.9780 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ezxt5+0t3B9X46C16vqA1LrbJQbLaR0cHwvZ16IQc1BsrkCbIneSbqYEwXgd8n1IP7LuuLk/P7B+q2P1swYwWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5292
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

Let's replace " RAS poison mode " with "poison is created, no user action i=
s needed" other than that, the patch is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Wednesday, September 22, 2021 18:33
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Clements, John <John.Clements@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: skip umc ras irq handling in poison mode (=
v2)

In ras poison mode, umc uncorrectable error will be ignored until the corru=
pted data consumed by another ras module (such as gfx, sdma).

v2: simplify the debug message and replace dev_warn with dev_info.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 33 ++++++++++++++-----------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 5b362e944541..6fad3e1b8c94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1544,22 +1544,27 @@ static void amdgpu_ras_interrupt_handler(struct ras=
_manager *obj)
 		data->rptr =3D (data->aligned_element_size +
 				data->rptr) % data->ring_size;
=20
-		/* Let IP handle its data, maybe we need get the output
-		 * from the callback to udpate the error type/count, etc
-		 */
 		if (data->cb) {
-			ret =3D data->cb(obj->adev, &err_data, &entry);
-			/* ue will trigger an interrupt, and in that case
-			 * we need do a reset to recovery the whole system.
-			 * But leave IP do that recovery, here we just dispatch
-			 * the error.
-			 */
-			if (ret =3D=3D AMDGPU_RAS_SUCCESS) {
-				/* these counts could be left as 0 if
-				 * some blocks do not count error number
+			if (amdgpu_ras_is_poison_supported(obj->adev) &&
+			    obj->head.block =3D=3D AMDGPU_RAS_BLOCK__UMC)
+				dev_info(obj->adev->dev, "RAS poison mode\n");
+			else {
+				/* Let IP handle its data, maybe we need get the output
+				 * from the callback to udpate the error type/count, etc
+				 */
+				ret =3D data->cb(obj->adev, &err_data, &entry);
+				/* ue will trigger an interrupt, and in that case
+				 * we need do a reset to recovery the whole system.
+				 * But leave IP do that recovery, here we just dispatch
+				 * the error.
 				 */
-				obj->err_data.ue_count +=3D err_data.ue_count;
-				obj->err_data.ce_count +=3D err_data.ce_count;
+				if (ret =3D=3D AMDGPU_RAS_SUCCESS) {
+					/* these counts could be left as 0 if
+					 * some blocks do not count error number
+					 */
+					obj->err_data.ue_count +=3D err_data.ue_count;
+					obj->err_data.ce_count +=3D err_data.ce_count;
+				}
 			}
 		}
 	}
--
2.17.1

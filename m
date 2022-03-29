Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E00C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Mar 2022 08:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8678410E7B1;
	Tue, 29 Mar 2022 08:33:26 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 381C910E7B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Mar 2022 08:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1LNrLNcPfp+YboqJHs5rs8TUsHQ78vi01b8hJ3qpFqBwEGVcKhG82L75ypl12ElcP8xV7PO0aqD+blrdJbO9Rd9IFdLB4t/99L/t5N/4o/pIuuZX1b3gqk1UM1ExBlINr/vgytvp0iv3UWJCK8ds6qNp9hQ95sI9qQRWUMgcU9Y4bUOo3QY2U+sY7FlKFn52QuqOzjufQqyO0waAsBtKS15NajlSzwq4HzuQP2Jwv0jBrJVXpaU++wyx+KdbkRCjmPN5KpD37qNH84bs8Z8HQeN/AJ4ZXX7GuxVgCoC04UIE96Q8VZRV6El1wujuYe5O8Da+seWFVKP8IG78pZ2Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDbUqDxqgn3ypw2un71nAnJ/xj9nDWXzY+q23DJaAjI=;
 b=Vu5YHIe7I1KTskWkb7XfDFzR/NbltfGdHausvbSt5A14Kn1NDIz+rSCUD9UHLZ5fZ0OjDbssr8L8E0ndYr0aoXYkKwdHSbmAOqQQ70vd3KVathAmwl5zXmKQswtyZuY2ar3jGXQXj4fTcb2PwxrGlwH4OB49S5drZb5PGyOMzNCVqqkxt95zBroIoVhAnffOi/xr6rr7jQX/WY4YNkUFDEmSnBs4qCkkt1563kZCwKXwLOXDF0V2L5wupjdFWoV1YomfghygZsuVu3cXV3G1J5fpUi/Vq7wiHlDmRhIv7gDkBVb0rI6N5fPEMemE2V2CRUF5VksBu9N7T77xhODZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDbUqDxqgn3ypw2un71nAnJ/xj9nDWXzY+q23DJaAjI=;
 b=N1HRWYRfvxYfyrLJYnBi97f7RWCfuqWRpC0Gf/7KMjc4EWFx8oduPRMkVEn8KtOAH7JS8dZu+1M0eP93HBsUy4eWnBILmcK7MLj9xw5ya0ah4U1D+0BeFBg3N9+8s19FDu1x2knbPiKmcJDWShyC0J6GduMvEg3tJW1UT6Hd97I=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW2PR12MB2569.namprd12.prod.outlook.com (2603:10b6:907:11::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 29 Mar
 2022 08:33:21 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c1c8:b797:3144:571d%7]) with mapi id 15.20.5102.023; Tue, 29 Mar 2022
 08:33:21 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Support AMDGPU RAS debugfs poll interface
Thread-Topic: [PATCH] drm/amdgpu: Support AMDGPU RAS debugfs poll interface
Thread-Index: AQHYQ0AXuzabdbffykq6c8ZkvZXaVqzWBbsQ
Date: Tue, 29 Mar 2022 08:33:21 +0000
Message-ID: <BN9PR12MB5257F539B80934D112D1D481FC1E9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20220329073843.772795-1-YiPeng.Chai@amd.com>
In-Reply-To: <20220329073843.772795-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-03-29T08:33:11Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=537175dc-1329-4ae4-a9b2-f75868310e33;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72578f8d-33d9-448f-5760-08da115ec84f
x-ms-traffictypediagnostic: MW2PR12MB2569:EE_
x-microsoft-antispam-prvs: <MW2PR12MB25697669CDAA2B236BDC9279FC1E9@MW2PR12MB2569.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nXBVUZDF4hPZGXmvshFfUvb9EUrP5DILYuen98WcnHPJOJrbKYiJITCDnI5p+aKUcoMCtQquNrh4+qK9F2XPwzMj2j6Lhp8gx62xfba7dKy2b9iDfjdwXxeW33WKchdfQwVev8LbmRrSFVfuJYQLpiEvXFKtgdMll7OWT61bJTPiiq4Q/Ah8bRae96RXKvyB1eOyfiWkPf4ZEEztcnTFIJexZkDvFs48gN5pZtgOAwl3rUOLfXXWb9NEKp9lt9WMwPmx2xDVu/TJ2A+4mHNBpfpvJwCcvwGc2ViM6yoVmsqPdnf+K2BxWMrxzddtEVDlPnVWEE1InxxZPeKpBXZne5GfX0VLOLgILDBwEYLqn7/zOUFHGYkERtoohTCPLxDxEdI+9M0xXufPUpryT+Jv8fqKQoi75/SEdDSp/XB+plHXjNMhkCiMESHY/3fR2TGlDGLqA5bMNCPZw3mYqxm+pyNVJrqnmQWAPDoflWb+99gEPbrK4sPHqHZMJktrUXpdAfpCoTNn5UW7ypPk+xblm2YYhZ73yy9zvz67ELgcLKIPPYLbSk6VqTXCLgCQAx+XE6vwN9HzsbwcCxOs9whPNPLVvCKNrJ8/WeREH3K+DexDLYWgTkBf7AYtw7tc8MYHC0hWUSnStAeZrB8cc+AVd9hiTgTTXpY/c25ftknX7pjeV5RapbredRqfEHJaiaFKvHtQ0YL71O45RiAiuTVojw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(8936002)(6506007)(86362001)(52536014)(33656002)(7696005)(8676002)(4326008)(76116006)(66446008)(66556008)(53546011)(64756008)(66946007)(316002)(71200400001)(508600001)(9686003)(66476007)(5660300002)(55016003)(110136005)(26005)(83380400001)(186003)(54906003)(38100700002)(38070700005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9DlVenPNZKR7eK/RVyhumvG/tA0MeJmO7cDs94FKR2/woZZUQJtTAXCygFEZ?=
 =?us-ascii?Q?1GUghYv82ID39WoxdeoW/a6OXBTWrHLMmKEG3pQyXycRaw+Ql6LOChr7Akpo?=
 =?us-ascii?Q?RlXOlGFbyeB+zzjG5POuUhXoqmBjnlrVA5XcKMZ0guq11vksF5cnkWeP7Zmc?=
 =?us-ascii?Q?EqRWtiNaAA5U3WuMpvGbLINxEkzlzyVb4TdK2X80SuPal76P3LFvKdI0Cqyg?=
 =?us-ascii?Q?Saa4aKurjF7oBCEr5PqNKCPdquim52XsL8sDzOHaAPgvQOehatHiRYy5zjuB?=
 =?us-ascii?Q?qofui4OnwkBqahliSwFu6XO+QfjqwIjAWyslPe5KCZ1G8d5TfIfcDfLpILt9?=
 =?us-ascii?Q?AkGZOs5GGoJs6pHLop5ENwzgLXhWEtOiz+vaum+1+KqZ6NGChdqxhEyPf7Lb?=
 =?us-ascii?Q?fQeDjaMV2maZs3yPqQbkhhXdeQuxVxF8cuEjoIzJ9W6zQDZ7cukMFkK0F/Yj?=
 =?us-ascii?Q?1gu66aDkYomUgbkPenMtjabb+JW1dVxOtMeFUZv7KCz4NPJoySdvSriF7YQm?=
 =?us-ascii?Q?7AdC4vvamLEyRh2nWJ9UBpVuegQgvihtHguQ9OW0MAY+KXdIq9eC2XwVwU4a?=
 =?us-ascii?Q?6+JOm0F1x6nornxnf82IF1SJKAjiRuKyA/9hpD47pmq1UJP15EyjWRluz4F2?=
 =?us-ascii?Q?fhVHvhPo02rStZOb3IMuHngDL2AMaAJ6D1wSWjM7aBd8Zq3zG75IVQ6Mm/rP?=
 =?us-ascii?Q?VYIkmRv8PDhus3y1BgWwDBrT+z1y9IaZDWjdIUj1EBC1e+8nxaLMFt5exf/T?=
 =?us-ascii?Q?ql1/uPNNubjO54os4CbbZztccjJHVklM8TAzFWJG+S3faqKo7S0AXNn5UPgI?=
 =?us-ascii?Q?XA/U0Bfl0XFndRTbwKCEePJrXlyg+oU4OgIeCT39+Tk7eiB3KU1wfmrQaryd?=
 =?us-ascii?Q?Lua/AShly3NjRR7TV0xHSDKSCwgyIpXlVo2r2Eof7JOpYaZgEMYuvlx5OjET?=
 =?us-ascii?Q?GQvR4az26v+3+jZmzzKtPFSElx4hNzLDrS7TlOqgcLIKSOjF3y7VmfWoMmEH?=
 =?us-ascii?Q?pDO4dc+EIUY8+O6A0GkuIMTW5DHoxFtnbkE686U7BWuo/pe2U/eZLMeG+5Nm?=
 =?us-ascii?Q?CF0VdsLeSFD7f2w5dIRXC9T/NnSyiL43fOuOJ8ebDuOW+SZ+5O8ss3RrPjm4?=
 =?us-ascii?Q?5lsBIsonBd3T/pA2qbwrIV9InUrnOxsAE+/x1E46gTEmTKEQdTeD7oAxB/Uo?=
 =?us-ascii?Q?jnCByXFJCaXfTuIEcc/7bidThY0u/2YUiCzvuzx6Sdlw184JXFC/526/CEHg?=
 =?us-ascii?Q?0lAKSzOxCfD1LL3kU68D79JTpJJx0BrwrqCwnnJZmCqq+uDiAUK3Zv0+cjd0?=
 =?us-ascii?Q?xt+3R+jBe/F2tzrI+AldCw7HhGXG7kBCbTGqn1ErpL5gLHwZRwjj8MhNSuIM?=
 =?us-ascii?Q?F7G7nfhC5zRMG3Tmi2bHVgNg+YCvvXMvDp6WuYK9KkTVCiRJsItXunmXZnyS?=
 =?us-ascii?Q?Eu8Ih49aTmRYhhUu25qFgNZfkQustBPBJB3n1a8ug/w1zXJjLN9rqUYQ8Pnj?=
 =?us-ascii?Q?SOMOFd23z780ATy0QSb2xg3ZTiA2Ktj/QenkRhdB9R9mZRKVC8n1Yt8e89RP?=
 =?us-ascii?Q?CqXVGk5hQmcWM1IF61bFKLheZGWaqOXdNm17Y2fxo2A+8QELWK2UQRXLVBXn?=
 =?us-ascii?Q?sS2qVSp7ScbMRWyD9jv15dgJE7I91ZgI1lbPHuQkI2zCgY7bAIHg8PQuIBQA?=
 =?us-ascii?Q?JwETy57ygopoXqIjeUB4lzi+vCB83oROInCLyiv/5hq+h8zPSj7OqeyDE1zo?=
 =?us-ascii?Q?pZusKiOtqg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72578f8d-33d9-448f-5760-08da115ec84f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2022 08:33:21.0493 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: unBtjYcD64cVCgX2D/zs+jo8AcQc96UJFUWbUCRRlq/tiYwlSL8aVuaPcOT7cugn4BkgCLKLj2cY0x8Tm02WRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2569
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
Cc: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Clements, John" <John.Clements@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

I'm not sure I understand the fix correctly - It seems to me it is trying t=
o stop user/test cases that initiate error injection request back-to-back? =
But anyway, we shouldn't make the change or leverage debugfs for that purpo=
se, and there is no guarantee test scripts/applications will follow the rul=
e as well.=20

I guess we need to identify the root cause case by case and stop the invali=
d request in kernel driver.

Regards,
Hawking

-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>=20
Sent: Tuesday, March 29, 2022 15:39
To: amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>=
; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: Support AMDGPU RAS debugfs poll interface

Some AMDGPU RAS debugfs operations like UE injection can cause gpu reset. B=
efore doing the next debugfs operation, the application should call poll to=
 check if the gpu has finished recovering.

Signed-off-by: yipechai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 38 ++++++++++++++++++++++++-  dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  6 ++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 4bbed76b79c8..337e3e247a45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -452,6 +452,12 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct fi=
le *f,
=20
 		/* data.inject.address is offset instead of absolute gpu address */
 		ret =3D amdgpu_ras_error_inject(adev, &data.inject);
+
+		if (!ret && (data.head.type =3D=3D AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE=
)) {
+			struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+
+			con->ras_ue_injected =3D 1;
+		}
 		break;
 	default:
 		ret =3D -EINVAL;
@@ -464,6 +470,30 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct fi=
le *f,
 	return size;
 }
=20
+/**
+ * DOC: Support AMDGPU RAS debugfs poll interface
+ *
+ * Some AMDGPU RAS debugfs operations like UE injection
+ * can cause gpu reset. Before doing the next debugfs
+ * operation, the application should call poll to check
+ * if gpu is in recovering status.
+ */
+static __poll_t amdgpu_ras_debugfs_ctrl_poll(struct file *f, struct=20
+poll_table_struct *wait) {
+	struct amdgpu_device *adev =3D (struct amdgpu_device *)file_inode(f)->i_p=
rivate;
+	struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+	__poll_t mask =3D 0;
+
+	/* For UE injection, wait for gpu to finish recovery */
+	if (con->ras_ue_injected)
+		poll_wait(f, &con->gpu_ready_wait_wq, wait);
+
+	if (!atomic_read(&con->in_recovery))
+		mask =3D EPOLLIN | EPOLLRDNORM;
+
+	return mask;
+}
+
 /**
  * DOC: AMDGPU RAS debugfs EEPROM table reset interface
  *
@@ -503,6 +533,7 @@ static ssize_t amdgpu_ras_debugfs_eeprom_write(struct f=
ile *f,
=20
 static const struct file_operations amdgpu_ras_debugfs_ctrl_ops =3D {
 	.owner =3D THIS_MODULE,
+	.poll =3D amdgpu_ras_debugfs_ctrl_poll,
 	.read =3D NULL,
 	.write =3D amdgpu_ras_debugfs_ctrl_write,
 	.llseek =3D default_llseek
@@ -1837,6 +1868,11 @@ static void amdgpu_ras_do_recovery(struct work_struc=
t *work)
 	if (amdgpu_device_should_recover_gpu(ras->adev))
 		amdgpu_device_gpu_recover(ras->adev, NULL);
 	atomic_set(&ras->in_recovery, 0);
+
+	if (ras->ras_ue_injected) {
+		ras->ras_ue_injected =3D 0;
+		wake_up_all(&ras->gpu_ready_wait_wq);
+	}
 }
=20
 /* alloc/realloc bps array */
@@ -2279,7 +2315,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	INIT_DELAYED_WORK(&con->ras_counte_delay_work, amdgpu_ras_counte_dw);
 	atomic_set(&con->ras_ce_count, 0);
 	atomic_set(&con->ras_ue_count, 0);
-
+	init_waitqueue_head(&con->gpu_ready_wait_wq);
 	con->objs =3D (struct ras_manager *)(con + 1);
=20
 	amdgpu_ras_set_context(adev, con);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 606df8869b89..aea6bbb71501 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -379,6 +379,12 @@ struct amdgpu_ras {
=20
 	/* Indicates smu whether need update bad channel info */
 	bool update_channel_flag;
+
+	/* UE injection flag */
+	uint32_t  ras_ue_injected;
+
+	/* Waiting for gpu ready work queue */
+	wait_queue_head_t gpu_ready_wait_wq;
 };
=20
 struct ras_fs_data {
--
2.25.1

Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E1BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 06:38:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E771360F48
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 06:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E771360F48
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91CB06EDEF;
	Fri, 24 Sep 2021 06:38:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF0F26EDEF
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 06:38:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnysRZZ6klz8qefwWl0zzjk8JH1vaVE5ZONtMqAfK/vmK5xzHYrLzh99JUOK7d8S+m7AshccLMz4xv93lT7WBpuJV2JFUgQQueJ3yE4+rYBjXweRq1TWzziGKv/2zo3aDyr2zySeYMPGWglSu9kHv31q0IUbkbSLA7JWMPyed0xcL+qm+vhkh4qNoilfL5j86bBcaBRbtPHuWHw5R6Ek3M/JRL8K5ORyrs3rnnk9my6uiwKIjjSfh+yVR00GhQcoEAgoxnCEM8p2q+qL09G7GZxJw+iV3cqKtt8gid70h32ULpHf8QSGfL4xC72af6Yxq1/I1ijQ/JQ6iijRMR3BvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=mgaz0usRmGV95oxolFVsWqjQfo1SHZvdUrMfEnQSRIk=;
 b=cVKIcj6IEzfkAgj5icQekSEAG0luLk2e7rVKVnt5IJYbjB8/+YhaKhoZhsU8NLxiitA1aRlwWhaManZES/33QIb6ti2mzP/a6MGRkVOuqFQQeyBwEE8FLW+oNRFbRkmvvRxX5614sGsCwdPVQoSzdsVQB9uUWUgDSZBdPin48ypemIrMTwSzYVN5VmBXEs7bZ5lF32lQ9vsX7+GTqHsq57r4rdILVaU53Gbrie9LK/tJMuvIDXLpgybESiC7jGOro2sG9CBeVuENwkSo3bTEJRWdR4O0bnUfzlGmiDs3mYTCX0UUXLkPMCCb4Pi+3QkN6m8q5B7SQ2dqDj17VW2uAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mgaz0usRmGV95oxolFVsWqjQfo1SHZvdUrMfEnQSRIk=;
 b=4ksT4efWZOrWPd3KNyySKR5RL2svn26u9G4wOFyfH85kPsvZ7B7ySUe9r+9oV7DLdw/Oq2NsX8r1xp5WPYdPG8oRB5uUosJxce/nAMtTvmYLTtfFCcM7OHXYZM4D4f25Py/2INhi+u0lRfAxfla1u3JPFGAd3aYgJM9S/zmbVn0=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 24 Sep
 2021 06:38:07 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e%3]) with mapi id 15.20.4544.015; Fri, 24 Sep 2021
 06:38:07 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Update PSP TA Invoke to use common TA context
 as input
Thread-Topic: [PATCH] drm/amdgpu: Update PSP TA Invoke to use common TA
 context as input
Thread-Index: AQHXsQ3jCl1bmbpQqUK34NUHmxQm86uyu0Tg
Date: Fri, 24 Sep 2021 06:38:06 +0000
Message-ID: <BN9PR12MB52267A9AC934194DDBEE9246FBA49@BN9PR12MB5226.namprd12.prod.outlook.com>
References: <20210924063144.31230-1-candice.li@amd.com>
In-Reply-To: <20210924063144.31230-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-24T06:38:04Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f19a4c25-f106-4e1f-9baa-01c3451e85bd;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42bef5b9-1eba-4dc6-b6ce-08d97f25de5b
x-ms-traffictypediagnostic: BN9PR12MB5356:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB535670B6C7E621406BAABE1DFBA49@BN9PR12MB5356.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:336;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EKjejfwMex9jFW/j/6cC5CQp9OihUjg1w3nGsSr2EaMqUWs23wpyss5YbidigB0By1wtsh2nLUdwz2/dX2+UHOWsTgGXumf3RJYWlVWiKlDyDGH7HQf25GXKJd9eZNSGYFOmw8EKLcZciTqacbrp17v0wc/6dS4eax1PoQtItNwfQNc8GwzgN/LyxHcN+452Gwz64lOmA69vvGcJhqoJ3KM2t7JDA5vgWW423sV8B2EveWJIF4hm/IYo1vw68g1hPb2kMLQxi7uBjdSisRrtsDxXYXAk4pKWfvgnziUnozjVL+MTQI6JRDhOrV3W0JchEpBl8bkAWTbjUtUo0RED6XibIY4MYj3PG6SKzPCD9tKE1QrKXy80Ots9vklgEl1KWYCiUPROUDe4LjveavKph8IjkkGp3VC/s5vteryd/PoJwgnh9reSCsVqcBTBGE7IYUrcBdSrffVmRRaaNhC187apz/qAUaJZWKeGKUao5UR7BcSKzaQ+avKYUQJrLOUTjjJMSbBxAw7sjs8tAyGFmdO0frda7yMTb9Q5ZikGm0Aok1Wu1S2s+0ykfshP6EZ5UtcXF3j4P8ZaeesqXYkj9hrZ3S3sHcKUWv0IYKdU3+J3WeVpYFtPGqDYe2Ra6HjbUKNWzl5E9ZmCy1tVp2vz5VGKFXXD2K1TZaBpOzUq39sw+kPBUhFIXrPWXZLW2fqZmjoIm2R+SUIQkLkBWfgp0g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(52536014)(15650500001)(508600001)(66476007)(110136005)(71200400001)(38100700002)(66946007)(9686003)(38070700005)(26005)(86362001)(186003)(7696005)(83380400001)(64756008)(76116006)(5660300002)(8936002)(33656002)(66556008)(55016002)(53546011)(316002)(2906002)(6506007)(122000001)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fITXiRTrzfTJz0Hex+BW7uUaCLStFL5hsH1FeIIwZCeWzy1p1A6NDMSYmPSg?=
 =?us-ascii?Q?HybpkeFs8V1MWJRpCviHn4rNuud3kTl8zMzPYxYOrqSpawLrs4wq0hTmJuFL?=
 =?us-ascii?Q?mmPRGF4Ps/81NSszmffVuWTp8gt7P+2luohjGBnjo+g9PqBwk1pMnfDj+IM6?=
 =?us-ascii?Q?A5xfHRPAHD6f2Zq8euE/RwioLCnwiObFTx/J/JNRtcRAyHRZWQIbNPDs4IeR?=
 =?us-ascii?Q?oZ+phQQ8Evky6yevXUpVYzqeEjF7qDfsZS/7bF9AaK+6JWuveS/yABF0kE1F?=
 =?us-ascii?Q?8esOL1a+WSO0fDpG0TlLjslROGhh92Tvecz5KmVpOaxkLoN7Bw8ap8Sfr65r?=
 =?us-ascii?Q?NRXNqb3EpY7DCGruTU+ceWrurZ+NXWDUVjnGiwMxgelQF1/FUXIIB++uhwJO?=
 =?us-ascii?Q?3EhX+gQqQ0gz8Ogo+6ft2ShKp4zmAKamI6lGxHEv84gsaGdcRe6UyrHjS/M+?=
 =?us-ascii?Q?i4HveVsCkkpjfisaF5uRYeC3oLreTFHuCsKFVm0WGFVnDmelr2E+NIu9mMUF?=
 =?us-ascii?Q?fy2FXdv6ahG9fRkSQSO2riuM2QGNop+ESo9WJPdauxsqfqYyzpcwlD5PTcl2?=
 =?us-ascii?Q?Cwa01XT9QQIX7Xla6lIYYG7ynVY44Wozq5h7qplu5shD/bigVybseNHlc/2O?=
 =?us-ascii?Q?MHHD0wYLdU58zoeo10dwJbqJqbvrD75RxqURoHH1R9AxQz/tejW0UCY2zZJ+?=
 =?us-ascii?Q?jEmvEQyQLstgqtUeBZ7HpnyDD0Hv2f1jbOONTlFcFTtPX4lWXnrzqH8L1PxD?=
 =?us-ascii?Q?xznIX1KDkiqUHV2wjzxkt5ZtZyQQnRpW53X2i5ComFQMAHWL4P1F8Oll3md1?=
 =?us-ascii?Q?kp738erZUkWaOUo18+fvIVBW6zbEdaloKddjzg3NdSZ65Mr5J2Dy+X0L6qFA?=
 =?us-ascii?Q?dhJcdbrAAFxDXiwOHPUqbROSe69LDoRdUzdpjzOv9m+lzKRPSpX7VuwltIsF?=
 =?us-ascii?Q?LBr59lw68KQw6q8Rrv641p6trDnC62R4veBdF3ZAhVno3edoZJZ+Cd+APz00?=
 =?us-ascii?Q?URqHwNRP/Ddg47fyWkhUGB8a87cHqRD00+bkMwQ0XKhNRGCoQQHkzlwsOh5q?=
 =?us-ascii?Q?WDE1aINB0jfneK3GP/y1Nlg2u3dxhs1XZCqJMHZMoBCiTw+JHWU8om7770tx?=
 =?us-ascii?Q?ZlK/zdsA9rXb2cqAsettLy2eZcTf9L0ScYc6QPpj5eD59dQNZH6DY/RDzl2M?=
 =?us-ascii?Q?4us/OYUCEpgHM00DxoAc9U9kNRSzCMTZUsbI4sPrlZYqZz3Z6diqmxE5B3qq?=
 =?us-ascii?Q?W287TAEWTNOfTLWY5L2CfWvfRVVktb3iDqBEFXpgF/CMH94PCcWkrk4ImYnr?=
 =?us-ascii?Q?Paxk8D2nMZpDgvEYQWUz7ZFY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bef5b9-1eba-4dc6-b6ce-08d97f25de5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 06:38:06.9202 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HaiNngp+8GzsN9yGGv0cTiIgZrM8xd1XpwL/e21FCa79psFRJE7gXWobtLAc4pHuoF0s/Tct/MQwGxeg3a71uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5356
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

Reviewe-by: John Clements <john.clements@amd.com>

-----Original Message-----
From: Li, Candice <Candice.Li@amd.com>=20
Sent: Friday, September 24, 2021 2:32 PM
To: amd-gfx@lists.freedesktop.org
Cc: Clements, John <John.Clements@amd.com>; Li, Candice <Candice.Li@amd.com=
>
Subject: [PATCH] drm/amdgpu: Update PSP TA Invoke to use common TA context =
as input

Updated invoke to use new common TA structure similarily to load/unload.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 55ffc3da89ced2..17d09771be3ee0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -938,12 +938,12 @@ static void psp_prep_ta_invoke_cmd_buf(struct psp_gfx=
_cmd_resp *cmd,
=20
 static int psp_ta_invoke(struct psp_context *psp,
 		  uint32_t ta_cmd_id,
-		  uint32_t session_id)
+		  struct ta_context *context)
 {
 	int ret;
 	struct psp_gfx_cmd_resp *cmd =3D acquire_psp_cmd_buf(psp);
=20
-	psp_prep_ta_invoke_cmd_buf(cmd, ta_cmd_id, session_id);
+	psp_prep_ta_invoke_cmd_buf(cmd, ta_cmd_id, context->session_id);
=20
 	ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
 				 psp->fence_buf_mc_addr);
@@ -989,7 +989,7 @@ static int psp_xgmi_unload(struct psp_context *psp)
=20
 int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id)  {
-	return psp_ta_invoke(psp, ta_cmd_id, psp->xgmi_context.context.session_id=
);
+	return psp_ta_invoke(psp, ta_cmd_id, &psp->xgmi_context.context);
 }
=20
 int psp_xgmi_terminate(struct psp_context *psp) @@ -1291,7 +1291,7 @@ int =
psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
=20
-	ret =3D psp_ta_invoke(psp, ta_cmd_id, psp->ras_context.context.session_id=
);
+	ret =3D psp_ta_invoke(psp, ta_cmd_id, &psp->ras_context.context);
=20
 	if (amdgpu_ras_intr_triggered())
 		return ret;
@@ -1551,7 +1551,7 @@ int psp_hdcp_invoke(struct psp_context *psp, uint32_t=
 ta_cmd_id)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
=20
-	return psp_ta_invoke(psp, ta_cmd_id, psp->hdcp_context.context.session_id=
);
+	return psp_ta_invoke(psp, ta_cmd_id, &psp->hdcp_context.context);
 }
=20
 static int psp_hdcp_terminate(struct psp_context *psp) @@ -1643,7 +1643,7 =
@@ int psp_dtm_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
=20
-	return psp_ta_invoke(psp, ta_cmd_id, psp->dtm_context.context.session_id)=
;
+	return psp_ta_invoke(psp, ta_cmd_id, &psp->dtm_context.context);
 }
=20
 static int psp_dtm_terminate(struct psp_context *psp) @@ -1777,7 +1777,7 @=
@ int psp_rap_invoke(struct psp_context *psp, uint32_t ta_cmd_id, enum ta_r=
ap_stat
 	rap_cmd->cmd_id =3D ta_cmd_id;
 	rap_cmd->validation_method_id =3D METHOD_A;
=20
-	ret =3D psp_ta_invoke(psp, rap_cmd->cmd_id, psp->rap_context.context.sess=
ion_id);
+	ret =3D psp_ta_invoke(psp, rap_cmd->cmd_id, &psp->rap_context.context);
 	if (ret)
 		goto out_unlock;
=20
@@ -1899,7 +1899,7 @@ int psp_securedisplay_invoke(struct psp_context *psp,=
 uint32_t ta_cmd_id)
=20
 	mutex_lock(&psp->securedisplay_context.mutex);
=20
-	ret =3D psp_ta_invoke(psp, ta_cmd_id, psp->securedisplay_context.context.=
session_id);
+	ret =3D psp_ta_invoke(psp, ta_cmd_id,=20
+&psp->securedisplay_context.context);
=20
 	mutex_unlock(&psp->securedisplay_context.mutex);
=20
--
2.17.1

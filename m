Return-Path: <SRS0=i1uT=OE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BD2C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 13:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E02B610A6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Sep 2021 13:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6E02B610A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 216A389C3F;
	Tue, 14 Sep 2021 13:13:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5772489C3F
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Sep 2021 13:13:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PrmU5tZW07pKpsgZKuX4ppZhIynALvm3zyrKYzU5ggVr1/QEIieJRSBBkKq6ieK9Xknu2cUL/falJYW2fF28BV23dfBF+Hm5Mh472rIso8X4++NOU/SQpw70dAKrd8gglkYHtitHZVKu3vvsGQIKsxzLtid0t15HrDJxyRP2LvWxGqFqdbjJLmOvyVL/DPWDI1roLws/A2vedZAwz1wrdnubt/0KmIqQOT39jm0mZiZzboRwqlXhjuC9kzU9zAqFyRnJM9BoufpS1+OKuF3W2eLLydy7salv6jJoPaPFsuVgaE+Kf39U73cXxeeFb7hzpQA5Vzsiv7akP4BeuoUe4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=/4YuoePY0eiDKciu1T+3dFjDvqjyD9AYLEBw8xs2Tlo=;
 b=O1dPuQkigaaUX0dNE1conQHXazAZXN5X6Mf10Hxx0RVTcBiOlQ6vTrppdZnEf+r94U5gtpczXLEsHnuu3x1TQpRDPFmz5ZMK/Fi6CNEjXitxiIfhpnuQ/PHGQP2zmxX3uMaXHPcxxOGyH076uigMLDgJ/Aixn2HXeJUmcLN+E+frVikSx/dAl/DY3f/U0e+FcuBjG/E6hz6bD6kCWIjKeMANO+GC1tdxiRxuEzzrRCdGqCfGSB+J212Nw2dopzNSflLUTwVNHB4oVlyBfq3c6iw4JFjMfU51Y+4HqzsDWGy49an7Io4sBOADeGvc6bbSWrhXjmE2FIgGmHd4EWKZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4YuoePY0eiDKciu1T+3dFjDvqjyD9AYLEBw8xs2Tlo=;
 b=23pDcEZwGwtp42Xdfq/FC8/UuZqEOKcM5ZhY7UUV1w8bKVO3N2Tam+seQbgdyXjJXBF9wz3m6x18PDeSZ0F5YVM9F0TUu1HcYIly8iBIxbEEWc46UgS7jSGHvOCSRZRGsr2wt/p1bZB6MmIIeS+JWeTyALT2m0Zkwj2d2eeMC7M=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5114.namprd12.prod.outlook.com (2603:10b6:408:137::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Tue, 14 Sep
 2021 13:13:49 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::a3:7688:bffe:880e%3]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 13:13:49 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Update PSP TA unload function
Thread-Topic: [PATCH] drm/amdgpu: Update PSP TA unload function
Thread-Index: AQHXqHTRRZiHcP+RykecoXsj7O/g6qujg8XB
Date: Tue, 14 Sep 2021 13:13:49 +0000
Message-ID: <BN9PR12MB52260829B945E56A3EF1B36FFBDA9@BN9PR12MB5226.namprd12.prod.outlook.com>
References: <20210913075551.24045-1-candice.li@amd.com>
In-Reply-To: <20210913075551.24045-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-14T13:13:47.988Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: ef150f42-e4da-ebbe-1837-7dcf944cda91
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a94cf078-50e1-471f-2549-08d977817dcd
x-ms-traffictypediagnostic: BN9PR12MB5114:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB51149FAC98730B41B439C4F4FBDA9@BN9PR12MB5114.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:428;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y7sWbcLrx0qnMTVR0bME06A/WHCZKg9Gse2DGZuW5PLWnZw2SFNocJ7SlB9CVcMejGU6w+jAhLBS318J1oMe0FFT/u2IC9PRC2a3ckUAPRZRHdpEFNhkDiHfIJ+/POR6mTUh5vi6nxDffQ6I2dG2TANlfyy/jmSxKgj+RXkdhFvAuvN4UoShnKpugQ2PPJWdwYWlnSthJ04FJ8yO1PVcjUep/wsL+aWuQ0DpF+S/FZ7Hn0PX3uMNk4dGNxgOnGPhvIZpmk2A+mJY9ApvJJTSqlq+zf9Xjrqay8wI7SgTBR0LTJm6NMzgn1OWI2mbJC0ka1Gf5nRtuDryawZC6EW6zgDFT6bkTaI8oAY2yGC9K9O0MxVgABvXWASenGSf0S/vvpHuVG5cY5AseStz3OHVhu8m19STc/m5H4xnWK9iMLvDHHQVfPt4vsUrzfUQPKTA8PV8ZZNIJ9SCsI6tTQHBEr3H8thYxFxUN7XfHjtUntPYteE91aEgAki1q9oosYnwPdtHzJSHji6xpu/mO+h7aZkbX6H8sABntbKdlf67rvroC3VQjKE0c0DkXbQXBNShhPTiKyIhU3D8Li9HLWuzvmcb8LyG55cZWqZlLxG3W/5jE/A3jEn8tlnW58YmBGsIj9WoGja3XFG4E6M9R9ICt3P1DrWIy+jGtEwu8lH+YPyszKkc86yqM1LIYsOGcRV0CgpBcc7Z6FKFwrO/Thq54A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(76116006)(52536014)(38070700005)(83380400001)(66556008)(38100700002)(19627405001)(15650500001)(66476007)(8676002)(66946007)(64756008)(122000001)(66446008)(86362001)(91956017)(478600001)(7696005)(55016002)(33656002)(53546011)(6506007)(5660300002)(110136005)(8936002)(186003)(316002)(2906002)(9686003)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?v6Pnb/Aru4Ykpy5NDlvNmxNVfOnzU6f5V9XtosqcRi3+TGs1gVZ0JviNty?=
 =?iso-8859-1?Q?BZw/e1eVw+ssdZvdwYOuBsVYzn8D4hxd4dZ9sRMtVGLYVy+hGzEaEWNlZS?=
 =?iso-8859-1?Q?xtxdzX9WEk3gIbfFWWVJkUQHub/AA0D3WwikuVO2EPafJ0ryMRYOgW/YRd?=
 =?iso-8859-1?Q?EfbqOt9y1XRgdCz28JOtZyWudNe7+OFjDwcXNzcH8Bp0O3J4DyD4AGNcBZ?=
 =?iso-8859-1?Q?aim47XnlUR2C0A5Hpj6nQCsXzfLeBM0PzYPjucAiekE3ra4OZKiAGvC+Fq?=
 =?iso-8859-1?Q?m5pj9TlgCIyWwBYjHHX/ATIsiRRRbbxMEHoGR3P7PnfU2e3YJPOO2K1u7e?=
 =?iso-8859-1?Q?vY9SznA6FcTRTzuFCNrxya/RusRKCGSbC9GqR2FE4W3BNex6mRa6nVs5BB?=
 =?iso-8859-1?Q?T+cNtxcVbXu4JBBjPnw8z0c64rLGv0DLWPFTwiY3019pUFEK9lgY7y7jn2?=
 =?iso-8859-1?Q?IJtRa22/7eFlsjcg6dlsJZx6Mefe0D0xT3/dtQxwKGLl0qoVVl4m9WKCwf?=
 =?iso-8859-1?Q?BlUaEWoLr/06F7EGGTqOUKNjpTFNDT0+m7kDJmZaLmObTEQJTHVGqz9QsR?=
 =?iso-8859-1?Q?zhFkrbjv9BzktHqLyWEynX9DIg++s5oqS7KXRWAWJBXfe4aqbootK/hDtV?=
 =?iso-8859-1?Q?lqy/AJJXCfNzznTE86p6B8haG3Zk0DjTfHToagN9jJ13c9Cq0TOeeT9Kca?=
 =?iso-8859-1?Q?aUxQ7vLlTh8tDoddWc4eMFCdBc1879jGsG1ZdwfMnV0nIhJ9PUzepY0vv6?=
 =?iso-8859-1?Q?Wq3R3Vdk1uoIP7x8UGw6vXPtjttuF0Y9JsYT0m1xtUi8eA6cEfh+avLu6S?=
 =?iso-8859-1?Q?CD4nzPyolyg/j9Kh8crtT3ArNKGKO0WpdRzvnwJRBKRJmkN+db6aGtx9Ku?=
 =?iso-8859-1?Q?iKDFGlvrwxS9xKIfK883ws6JqUwcE+uMJlas8ozUq4ZufjFbGZN4xgKRew?=
 =?iso-8859-1?Q?DY9lB8l1+XmLnybRfbDDYVj5Jvacha+dgSuh689mfZO6BRfsPyN/ohEk1P?=
 =?iso-8859-1?Q?RAOReH51ScWIEuttypbVrHZAFGk00nuXd6hL5Iqqjk+tloQX/7zV/EoV3n?=
 =?iso-8859-1?Q?1t0s6gJFhRyBtFAfqSoDddAcrwUoaBlbZbtgf5FlT5RQBVXGoqRcLEBiVS?=
 =?iso-8859-1?Q?/FTo7jntXq+0kg6d3Mcn7RwbWCg8cJL5JbBwn5ldvu3dYoOdFfLBx+0A+g?=
 =?iso-8859-1?Q?FN2X2CgphMZ2WUkl8XJytQNP3+l06XjJbzoItuP07VQzgoYbPFgH46NOMu?=
 =?iso-8859-1?Q?VN4aKydLXy7u9RK5bNFU8qkkRYIbLSl1DDi8GG9+bDHTGtS4UzBC9UWI6H?=
 =?iso-8859-1?Q?r/ACpuKxUmlDw0ECxFV1nP4gLOEbgHhD2ZMiFKtMlaDxmFqZk115ih2ul/?=
 =?iso-8859-1?Q?96JGDvAUIq2TKh1B6vbWguU28BnyWF0MDc8Rx9X/Mi+Uqi0tMuPtEb8/cf?=
 =?iso-8859-1?Q?b7JeYj6PD8waKl/Y?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB52260829B945E56A3EF1B36FFBDA9BN9PR12MB5226namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94cf078-50e1-471f-2549-08d977817dcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2021 13:13:49.3135 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +p74BaLPQ5DfI3LtKTPKvIHwtI0lvLFjg10K3PmXQ2jiQKI/n/KWFs5zXERLZ7lCAVfLd0TXjULlTSmW5cfXXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5114
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

--_000_BN9PR12MB52260829B945E56A3EF1B36FFBDA9BN9PR12MB5226namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: John Clements <john.clements@amd.com>

________________________________
From: Li, Candice <Candice.Li@amd.com>
Sent: Monday, September 13, 2021 3:55 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Clements, John <John.Clements@amd.com>; Li, Candice <Candice.Li@amd.com=
>
Subject: [PATCH] drm/amdgpu: Update PSP TA unload function

Update PSP TA unload function to use PSP TA context as input argument.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index bc861f2fe0ecf6..7d09b28889afef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -46,7 +46,7 @@ static int psp_sysfs_init(struct amdgpu_device *adev);
 static void psp_sysfs_fini(struct amdgpu_device *adev);

 static int psp_load_smu_fw(struct psp_context *psp);
-static int psp_ta_unload(struct psp_context *psp, uint32_t session_id);
+static int psp_ta_unload(struct psp_context *psp, struct ta_context *conte=
xt);
 static int psp_ta_load(struct psp_context *psp, struct ta_context *context=
);
 static int psp_rap_terminate(struct psp_context *psp);
 static int psp_securedisplay_terminate(struct psp_context *psp);
@@ -816,12 +816,12 @@ static void psp_prep_ta_unload_cmd_buf(struct psp_gfx=
_cmd_resp *cmd,
         cmd->cmd.cmd_unload_ta.session_id =3D session_id;
 }

-static int psp_ta_unload(struct psp_context *psp, uint32_t session_id)
+static int psp_ta_unload(struct psp_context *psp, struct ta_context *conte=
xt)
 {
         int ret;
         struct psp_gfx_cmd_resp *cmd =3D acquire_psp_cmd_buf(psp);

-       psp_prep_ta_unload_cmd_buf(cmd, session_id);
+       psp_prep_ta_unload_cmd_buf(cmd, context->session_id);

         ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr)=
;

@@ -832,7 +832,7 @@ static int psp_ta_unload(struct psp_context *psp, uint3=
2_t session_id)

 static int psp_asd_unload(struct psp_context *psp)
 {
-       return psp_ta_unload(psp, psp->asd_context.session_id);
+       return psp_ta_unload(psp, &psp->asd_context);
 }

 static int psp_asd_terminate(struct psp_context *psp)
@@ -984,7 +984,7 @@ static int psp_xgmi_load(struct psp_context *psp)

 static int psp_xgmi_unload(struct psp_context *psp)
 {
-       return psp_ta_unload(psp, psp->xgmi_context.context.session_id);
+       return psp_ta_unload(psp, &psp->xgmi_context.context);
 }

 int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
@@ -1275,7 +1275,7 @@ static int psp_ras_load(struct psp_context *psp)

 static int psp_ras_unload(struct psp_context *psp)
 {
-       return psp_ta_unload(psp, psp->ras_context.context.session_id);
+       return psp_ta_unload(psp, &psp->ras_context.context);
 }

 int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
@@ -1540,7 +1540,7 @@ static int psp_hdcp_initialize(struct psp_context *ps=
p)

 static int psp_hdcp_unload(struct psp_context *psp)
 {
-       return psp_ta_unload(psp, psp->hdcp_context.context.session_id);
+       return psp_ta_unload(psp, &psp->hdcp_context.context);
 }

 int psp_hdcp_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
@@ -1632,7 +1632,7 @@ static int psp_dtm_initialize(struct psp_context *psp=
)

 static int psp_dtm_unload(struct psp_context *psp)
 {
-       return psp_ta_unload(psp, psp->dtm_context.context.session_id);
+       return psp_ta_unload(psp, &psp->dtm_context.context);
 }

 int psp_dtm_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
@@ -1690,7 +1690,7 @@ static int psp_rap_load(struct psp_context *psp)

 static int psp_rap_unload(struct psp_context *psp)
 {
-       return psp_ta_unload(psp, psp->rap_context.context.session_id);
+       return psp_ta_unload(psp, &psp->rap_context.context);
 }

 static int psp_rap_initialize(struct psp_context *psp)
@@ -1805,7 +1805,7 @@ static int psp_securedisplay_load(struct psp_context =
*psp)

 static int psp_securedisplay_unload(struct psp_context *psp)
 {
-       return psp_ta_unload(psp, psp->securedisplay_context.context.sessio=
n_id);
+       return psp_ta_unload(psp, &psp->securedisplay_context.context);
 }

 static int psp_securedisplay_initialize(struct psp_context *psp)
--
2.17.1


--_000_BN9PR12MB52260829B945E56A3EF1B36FFBDA9BN9PR12MB5226namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<font size=3D"2"><span style=3D"font-size:11pt">Reviewed-by: John Clements =
&lt;john.clements@amd.com&gt;</span></font><br>
</div>
<div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size: 11pt;" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Li, Candice &lt;Can=
dice.Li@amd.com&gt;<br>
<b>Sent:</b> Monday, September 13, 2021 3:55 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Clements, John &lt;John.Clements@amd.com&gt;; Li, Candice &lt;Ca=
ndice.Li@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Update PSP TA unload function</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Update PSP TA unload function to use PSP TA contex=
t as input argument.<br>
<br>
Signed-off-by: Candice Li &lt;candice.li@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 20 ++++++++++----------<br>
&nbsp;1 file changed, 10 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index bc861f2fe0ecf6..7d09b28889afef 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -46,7 +46,7 @@ static int psp_sysfs_init(struct amdgpu_device *adev);<br=
>
&nbsp;static void psp_sysfs_fini(struct amdgpu_device *adev);<br>
&nbsp;<br>
&nbsp;static int psp_load_smu_fw(struct psp_context *psp);<br>
-static int psp_ta_unload(struct psp_context *psp, uint32_t session_id);<br=
>
+static int psp_ta_unload(struct psp_context *psp, struct ta_context *conte=
xt);<br>
&nbsp;static int psp_ta_load(struct psp_context *psp, struct ta_context *co=
ntext);<br>
&nbsp;static int psp_rap_terminate(struct psp_context *psp);<br>
&nbsp;static int psp_securedisplay_terminate(struct psp_context *psp);<br>
@@ -816,12 +816,12 @@ static void psp_prep_ta_unload_cmd_buf(struct psp_gfx=
_cmd_resp *cmd,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd-&gt;cmd.cmd_unload_ta.=
session_id =3D session_id;<br>
&nbsp;}<br>
&nbsp;<br>
-static int psp_ta_unload(struct psp_context *psp, uint32_t session_id)<br>
+static int psp_ta_unload(struct psp_context *psp, struct ta_context *conte=
xt)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *c=
md =3D acquire_psp_cmd_buf(psp);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_prep_ta_unload_cmd_buf(cmd, sessi=
on_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_prep_ta_unload_cmd_buf(cmd, conte=
xt-&gt;session_id);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_cmd_submit_buf=
(psp, NULL, cmd, psp-&gt;fence_buf_mc_addr);<br>
&nbsp;<br>
@@ -832,7 +832,7 @@ static int psp_ta_unload(struct psp_context *psp, uint3=
2_t session_id)<br>
&nbsp;<br>
&nbsp;static int psp_asd_unload(struct psp_context *psp)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_ta_unload(psp, psp-&gt;asd=
_context.session_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_ta_unload(psp, &amp;psp-&g=
t;asd_context);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int psp_asd_terminate(struct psp_context *psp)<br>
@@ -984,7 +984,7 @@ static int psp_xgmi_load(struct psp_context *psp)<br>
&nbsp;<br>
&nbsp;static int psp_xgmi_unload(struct psp_context *psp)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_ta_unload(psp, psp-&gt;xgm=
i_context.context.session_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_ta_unload(psp, &amp;psp-&g=
t;xgmi_context.context);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id)<br>
@@ -1275,7 +1275,7 @@ static int psp_ras_load(struct psp_context *psp)<br>
&nbsp;<br>
&nbsp;static int psp_ras_unload(struct psp_context *psp)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_ta_unload(psp, psp-&gt;ras=
_context.context.session_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_ta_unload(psp, &amp;psp-&g=
t;ras_context.context);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id)<br>
@@ -1540,7 +1540,7 @@ static int psp_hdcp_initialize(struct psp_context *ps=
p)<br>
&nbsp;<br>
&nbsp;static int psp_hdcp_unload(struct psp_context *psp)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_ta_unload(psp, psp-&gt;hdc=
p_context.context.session_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_ta_unload(psp, &amp;psp-&g=
t;hdcp_context.context);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int psp_hdcp_invoke(struct psp_context *psp, uint32_t ta_cmd_id)<br>
@@ -1632,7 +1632,7 @@ static int psp_dtm_initialize(struct psp_context *psp=
)<br>
&nbsp;<br>
&nbsp;static int psp_dtm_unload(struct psp_context *psp)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_ta_unload(psp, psp-&gt;dtm=
_context.context.session_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_ta_unload(psp, &amp;psp-&g=
t;dtm_context.context);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;int psp_dtm_invoke(struct psp_context *psp, uint32_t ta_cmd_id)<br>
@@ -1690,7 +1690,7 @@ static int psp_rap_load(struct psp_context *psp)<br>
&nbsp;<br>
&nbsp;static int psp_rap_unload(struct psp_context *psp)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_ta_unload(psp, psp-&gt;rap=
_context.context.session_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_ta_unload(psp, &amp;psp-&g=
t;rap_context.context);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int psp_rap_initialize(struct psp_context *psp)<br>
@@ -1805,7 +1805,7 @@ static int psp_securedisplay_load(struct psp_context =
*psp)<br>
&nbsp;<br>
&nbsp;static int psp_securedisplay_unload(struct psp_context *psp)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_ta_unload(psp, psp-&gt;sec=
uredisplay_context.context.session_id);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return psp_ta_unload(psp, &amp;psp-&g=
t;securedisplay_context.context);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static int psp_securedisplay_initialize(struct psp_context *psp)<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN9PR12MB52260829B945E56A3EF1B36FFBDA9BN9PR12MB5226namp_--

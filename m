Return-Path: <SRS0=nf5+=NA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E42C4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 05:35:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF21B60EE4
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Aug 2021 05:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DF21B60EE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FF5789B68;
	Mon,  9 Aug 2021 05:35:10 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1571189B68
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Aug 2021 05:35:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8ek8ZuTJmHdg16cSHMKRRTp/m8Ugh/vhFrlPepN4/wGgHVHAnU2TRkOPbu8fCGII0TKxvPavrEK9ZOAmqD5gYlOW+lB+A6+J9AWZ0AZfeWpU1P7AGUXMCOp/1LWHZsfmWXUkBWEgfgkoHOJovrVFGpSJsznHtgYtPtHMIo2mE5wFh8erRVhi9prK53Ub8wRyWFQdzqEk39+aqv4tUNxY4CJqE9BROKce/xhbHagD3YEEgUsvdetByH0qDM+fY3SZAqTiCufCtnTRroqEr+NXwQt486MigX3tluUwESJQyuIUfQt4osLv9rmpwfBVg7Qr8ZlFZr0l/N9WzdK8E2iKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uB17WQYpoditdYTxVn4UuOHcvEilzZ//xSU9zF/P3Ww=;
 b=B9MJjmUezh4wMfF17st1eNTuJ/JZi/zZ0aNcpPK4LP31xv4b1WoaX35HGDjQuG1sAW4K3bdPu09XV3bHje7/Hh5zqHq3zMBo8FtvvGCchfWRL2/VvnLGHUjFCiZzysjPwspVJnFjlhP9MlSJxvRT+KLVvmRXraAUP9E/B1q6hCkV5JgO8Tv5TRWjN5U3zlFEnDMdXyyvT0rXw+WrHPOP2seKlu/ZDp5WjzjxUX6OB/6IqKGAWIp9UVhKeY/Raez0DatRPG3c7qxx/BvKfyF6Ps06QywakGV3dhEeu6MhP+3ynkObJA8zU4D038IF9LDIspKpfssEr5uPJ0STynwf6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uB17WQYpoditdYTxVn4UuOHcvEilzZ//xSU9zF/P3Ww=;
 b=PsGLQ2nmSp7yKyYGdyjBe2YPSV5uK3RSLaSd0HeEDv5m3bxcq1tacRgL0wRMnOaSEw4ECxVpMde2GfKWoWNMXKs3Xf4Nw7Q6VEYIa4WS30TtGkli52XxRuSFhrgbSrPEBOgOjpzvQXaU1FIdTukpcgPmHSG89zEmd8BJh0kA9KU=
Received: from DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) by
 DM5PR12MB1514.namprd12.prod.outlook.com (2603:10b6:4:f::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.19; Mon, 9 Aug 2021 05:35:07 +0000
Received: from DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::b5af:a40b:e96f:d83]) by DM6PR12MB4340.namprd12.prod.outlook.com
 ([fe80::b5af:a40b:e96f:d83%7]) with mapi id 15.20.4394.022; Mon, 9 Aug 2021
 05:35:07 +0000
From: "Zhao, Victor" <Victor.Zhao@amd.com>
To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Extend full access wait time in guest
Thread-Topic: [PATCH v2] drm/amdgpu: Extend full access wait time in guest
Thread-Index: AQHXjN/MmY6AAMkomEO0pl9EKuAouqtqpnTA
Date: Mon, 9 Aug 2021 05:35:07 +0000
Message-ID: <DM6PR12MB4340B432F54750A277EE1DB9FAF69@DM6PR12MB4340.namprd12.prod.outlook.com>
References: <20210809053112.3652-1-PengJu.Zhou@amd.com>
In-Reply-To: <20210809053112.3652-1-PengJu.Zhou@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-09T05:35:02Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=000c6d37-dc74-440c-b8c6-6e11f2671306;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a23c49c-6e1d-41ea-1c8b-08d95af7725d
x-ms-traffictypediagnostic: DM5PR12MB1514:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB15141123536FC59E76E55423FAF69@DM5PR12MB1514.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m1ciupu2p1isd/5StkD+4ZE5XuF7yrOVLUyXwhqwThSSZ9QXj09FARiEVad262TS8FHEwL51jSLBL75C2QrZe3KT4gH1rJDgx4Z1EvQyuTUwar6C3vYV8gwLJZgvoFgBCjFdY/JoiwQ35lhiMJnog4pRe7WFZs8cn1OxckXyw2qmJ1EAjKhKlOzcT6bcUsVZBPIXCaozC/rdcr/tg5/GF/PEOk4jPU2QZffkqgmnS+8zpX57HjfLXWjQGDe2Sklf50ogrbwa/k1G10CDcn61Xxaso75itKaOmZVsE1a7j4Jv5IXagThNKWqwvky6Pie9WrsAIKndY3vZ7hphwu3x/ChLQt8sL772HDxj6Qe92C2VaRXFFdFYAYM7HH+L3fgelB+I1K7wkFePIYAPf0QBPHr4XgvdVnMWP54KPaWn/1zAQem01Agz61jypp/fbo3Ejh6Sn9Gj2uusem69ADWtf4sQI9FJLWqaxq79geB705d29TMsTbohH+MIEASubX2p1rJ+IUfNUeePPgAYsAeKRh2WM6Cj8zJLKPM/InQhcnnDM9nHPx9NV77nunJD7s97bIneQUOs31k1XbD2SLjA6Jio618W+xoSSwLoQ3w3ZovU+MTv+mJZGjt9gmjHYwgx5+c9ugvo6L1SCVOh06Ljmclf+EjDpyjgvEHIwqZsNAwJEzTq614lqAfaBKqzBBTLuH+mlAZDVlYW5Ag9HKLmKQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4340.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(83380400001)(55016002)(478600001)(186003)(38100700002)(4326008)(71200400001)(38070700005)(110136005)(122000001)(316002)(76116006)(33656002)(66446008)(8936002)(66556008)(66946007)(66476007)(64756008)(86362001)(9686003)(7696005)(26005)(5660300002)(53546011)(8676002)(6506007)(52536014)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qXSbPS3zR+2VfC51MuAECC44JZ+bTWpdGT4AMdN8E/FRb1rnAPeUEqm7VlmW?=
 =?us-ascii?Q?LEOot65GlzUSEMiDVNR+2noaaD45j1kw2eUt3FVetJbmB7PBDaKgkPXfRE3r?=
 =?us-ascii?Q?BwvC3+ChVV0k/scw2xzp5ko1Xk9IVZz57/z9ySAkqPj9c0lGf/45ZvGKG8QA?=
 =?us-ascii?Q?ZWeezmOAVScFEGrfS6/zt2FuvaSwllviUKP9YOHJ3zrwU4b1GbWZKYUDJs/5?=
 =?us-ascii?Q?zfUkLQXwgtFoc6qNC/K2Fkn1o+4r9Vpf/KehSgHF3BNEvaN2qV4vitPJOhUG?=
 =?us-ascii?Q?ftM3I6FS1Llm4tXMr+7nzfrl2nV9bpsOW6OhjKZDW2C+1Tguyyhkr1itHyGt?=
 =?us-ascii?Q?wec3/MD2pha38ALSIldNQLSYZJIetztbQJzva/4nhvmIjV+cOfbfheFbeU6M?=
 =?us-ascii?Q?EqfIwsvk5sUphUpZZ1A24d51Rb11XBukPqVQr6MIa3AMOem0+PBVS4Ka7uwF?=
 =?us-ascii?Q?NP7zWGNXfLcBVfhWJytvwgVLfWTbGnB14r3GOJjTiTeoqxFfHpM1qY8C4+ye?=
 =?us-ascii?Q?HnQUlo9bVzayGC8z8pulPaVY1fBXiTyiXUVTqK7p1zb0ET1lCMALC/ZeKNAM?=
 =?us-ascii?Q?T+8gUc7XB87UceQDoRUq2i5hR6kCTYJmC/LMvXV0763kLMJKdYmVWXoXrxJ2?=
 =?us-ascii?Q?vnAGi+VT0wk5r57Ty+2JSGdO5+N92Bl9FA02afs6phaDSV/ibTLeKfRjoDBC?=
 =?us-ascii?Q?4UFBBewktg+2iDK/53yOKpv9PCyqjguyPVDRDAQ++omLP2iUJ2xHziKJ4Ud2?=
 =?us-ascii?Q?hHQwnGy1v6GIR4k+yK6UVhn0gTtBO20rFzL0gCAlCHyE282r80F6RZOPWd/B?=
 =?us-ascii?Q?HLwCoaI3TpeD0Mwi3ToR2vm6dBbdPaqC3yzUcP+77vYI0l5BYVmG7xSaXiQ9?=
 =?us-ascii?Q?f5XW53LcsYKb7cSv0XODOaBL9ReqRHG6V9CiAv7J2c0pPoM6vQCe0TD0Y2Xl?=
 =?us-ascii?Q?dmyhjNG+vy900ae4sRJ5rg/aMmb09l8MWUngwK6/VK/fbroUZvvEbTfoTpYu?=
 =?us-ascii?Q?MO9zc4BpsMomOXXiBRMPK0uz6NmSKMfanMoTpG7njiASbNwPo8GD1aTYFWjh?=
 =?us-ascii?Q?8yxlzQD6gvvirrLAIwLMOmFB5IJZSI1s6gCim27yCFasFCiwoL57GffoKcqE?=
 =?us-ascii?Q?QSjjRKpBDeNieHXyUJdiaYFO1GsgTOPuBd7/cf/2WNF3Dg8VFf74/fse/C+M?=
 =?us-ascii?Q?dIp4IO7lOGPlHUtusacA41g0ogWnHs7NXxN0duOwZ9STUcnAq5F3DcU23Ojn?=
 =?us-ascii?Q?lU3BHnkqT2Knmli9NDSC/I92oIUMlpCH2qbyYpmF3byxCbc/n224J4pcpvdu?=
 =?us-ascii?Q?dk4qfkUWFvUHv5bGFXpLZUkK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4340.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a23c49c-6e1d-41ea-1c8b-08d95af7725d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 05:35:07.0657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jvF3LL2EimqyC7kL/Sk9MpTI4NFK2bUW6QxNbNEdpm+RBOJ0vGSotzzS4T7rYbx6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1514
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

Reviewed-by: Victor Zhao <Victor.Zhao@amd.com>

-----Original Message-----
From: Peng Ju Zhou <PengJu.Zhou@amd.com>=20
Sent: Monday, August 9, 2021 1:31 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhao, Victor <Victor.Zhao@amd.com>; Zhou, Peng Ju <PengJu.Zhou@amd.com>
Subject: [PATCH v2] drm/amdgpu: Extend full access wait time in guest

From: Victor Zhao <Victor.Zhao@amd.com>

- Extend wait time and add retry, currently 6s * 2times
- Change timing algorithm

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/am=
dgpu/mxgpu_nv.c
index 9f7aac435d69..b48e68f46a5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -96,7 +96,11 @@ static int xgpu_nv_poll_ack(struct amdgpu_device *adev)
=20
 static int xgpu_nv_poll_msg(struct amdgpu_device *adev, enum idh_event eve=
nt)  {
-	int r, timeout =3D NV_MAILBOX_POLL_MSG_TIMEDOUT;
+	int r;
+	uint64_t timeout, now;
+
+	now =3D (uint64_t)ktime_to_ms(ktime_get());
+	timeout =3D now + NV_MAILBOX_POLL_MSG_TIMEDOUT;
=20
 	do {
 		r =3D xgpu_nv_mailbox_rcv_msg(adev, event); @@ -104,8 +108,8 @@ static i=
nt xgpu_nv_poll_msg(struct amdgpu_device *adev, enum idh_event event)
 			return 0;
=20
 		msleep(10);
-		timeout -=3D 10;
-	} while (timeout > 1);
+		now =3D (uint64_t)ktime_to_ms(ktime_get());
+	} while (timeout > now);
=20
=20
 	return -ETIME;
@@ -149,9 +153,10 @@ static void xgpu_nv_mailbox_trans_msg (struct amdgpu_d=
evice *adev,  static int xgpu_nv_send_access_requests(struct amdgpu_device =
*adev,
 					enum idh_request req)
 {
-	int r;
+	int r, retry =3D 1;
 	enum idh_event event =3D -1;
=20
+send_request:
 	xgpu_nv_mailbox_trans_msg(adev, req, 0, 0, 0);
=20
 	switch (req) {
@@ -170,6 +175,9 @@ static int xgpu_nv_send_access_requests(struct amdgpu_d=
evice *adev,
 	if (event !=3D -1) {
 		r =3D xgpu_nv_poll_msg(adev, event);
 		if (r) {
+			if (retry++ < 2)
+				goto send_request;
+
 			if (req !=3D IDH_REQ_GPU_INIT_DATA) {
 				pr_err("Doesn't get msg:%d from pf, error=3D%d\n", event, r);
 				return r;
--
2.17.1

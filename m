Return-Path: <SRS0=biE/=M3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B665CC4338F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 02:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE1C60F46
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 02:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6DE1C60F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8D496E9AA;
	Wed,  4 Aug 2021 02:43:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE1366E9AA
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Aug 2021 02:43:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQ2sL7j7QwtuNBbxtOE7VxrISg/CbDn406Z1UOQw/6s6N6FydVF81baQ2zbk4i7+NySdz1ZeHjnViXBhYkZzIw7mAx05SNT6ak6HuxppRFRcp8+iHUeq4OdsYj6IYm9YXZrmVJoKbAIpnQ03PRi8Q8eQtfNFVzr6S4ODcpP57D/xPx10DNPX3QnjzdfPVw13mAxZlUTkdDRbV4SVCRGHj36gUUaHQxkx5yAgWcfQ7YpLL5lZhtkgAxe9DrxRl7xrDDynq0YdKPoyJuOi/IdP5KLrjjRtnf0HAw1wjMWsNetkdtnBAeOI0FVER/OUULY3/L4xKxcxmoD7Xf2aB5NRKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZtI279joZr9KmGLi7m41s0pZUqtRc0WKVDGbLEitSo=;
 b=RlK/r8AG0Bc0B8z87EbQCBOCe+rYTSal3sZ5uYWZn+ZxzVfNXygmHCzZPvE9UP8w51k12iAaEoX5B9ecBa9BV3vjuiDxKIgbOQUL5r4i362/XDo3c3L7KD7rlHkmszZXSgC7GPWmLt/EigOQDrg71rci4eITRQ95vX1Aqq20sd8Jb98Zhx4OwrMIRn8CHgzgPuAzhlkn8RTC6hhggX3Hqz+pFOg0wJePCe9H64tHu3tCJ+3+BButwBkwsutGqYyxawMH6AfbHDjofi8iOQoTsx9w8U2VVNBg15zfiol6U4lzODPJfw5LZvaiGqPHD8Xl5KJzw6cbK6bRN59ArAtqbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZtI279joZr9KmGLi7m41s0pZUqtRc0WKVDGbLEitSo=;
 b=x8M2H7yz1Pzcaa/2INvAdhunXGerhc927KyBzJFyBHr+lZewYtkoVGAxHw1Wr7P2Rc7YG69wnKmEjWOK6vphDSUjITgrcRNes8JHzkGIGWH7ueYK1nGEEf3iUqVhw3RqadzQBV9kM81TD+/QHVMKNQ7veJe88chUlKR8iPkkqeg=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.19; Wed, 4 Aug 2021 02:43:39 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::453c:6ded:8973:744e%4]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 02:43:39 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Gui, Jack" <Jack.Gui@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add DID for beige goby
Thread-Topic: [PATCH] drm/amdgpu: add DID for beige goby
Thread-Index: AQHXiJ9YxqFhHECIQEStOg4oQROek6tio5FQ
Date: Wed, 4 Aug 2021 02:43:39 +0000
Message-ID: <DM5PR12MB2469D1CB5C53A12CB87CA070F1F19@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20210803193929.2496812-1-alexander.deucher@amd.com>
In-Reply-To: <20210803193929.2496812-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-08-04T02:43:36Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=bf28d4c5-fee9-47e6-817a-94c52d85c1a3;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eda516e7-286f-415b-c1fb-08d956f1aa61
x-ms-traffictypediagnostic: DM6PR12MB3962:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB39625FB0D13393BE657C3F85F1F19@DM6PR12MB3962.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:398;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V/MSo64VcyHJsYu0k/0FIHiav9NS7EoSzO1MKlSsIPYSm/D2qkEfVyeC8ZRCp9HPiGJLJ1n1SK+qGBPFwPrT3z5MTfmDhjsd9cIVWH4JQckDmN3jEuVCpS0mjniPkkqndxZ4TwPDnkzvRapjkTSfxAZctXvUQcR8gDj4/TsU4z3Nd5LUvlrFVUOnJNY/R58HgbjT3Ma6xkVKeBvwnsnARJX98AT80I+BKlmf+Nu1pRE4qmfaYpMUzxdFY6xvYOzvc55OAQYHc50G7lW34p1cV1fmhpNGoCsQ0OPy2WI0oqdudsn2b2tNxRlp6YFMdCM6Ej/UFZ3wbln53mNua8SSCZEryktapPzzvraU/yuHWLWVv7W4PTHa9nOc/f1PTn8nmq/gj5vY2Yht80Dha5sFWG5UbrWRy4rs96kuIb37lOJAxS/IvvA4ki36ny9buy4ApM9ZimXupanPwaa/9NVidbQv/wyB5XaH1latoqBNqzy2kI0t4sU81Bnyi1ZY1kRuf0MvNZKpacxcSOQ1B+q/5s0OLCcyQIaYp+gXGbsPDUqCBRnuwCLmzYV5J/IENF1A2iD0/tmerEyh0OwPHQ/ACNwbNmpxKGVGexutcsapH5lcdi6O6TjTTEemCDz6hyu+8wOmQjZ3QhkzPquKFOmPuf4FrBs75Okerbzo33yrJt1wdAFCFd2k3KFKIiqIAxVZQ6Unw/Oqb3aakQiIccv7tw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(38100700002)(122000001)(2906002)(33656002)(54906003)(8936002)(83380400001)(110136005)(38070700005)(52536014)(4326008)(7696005)(76116006)(26005)(5660300002)(71200400001)(6506007)(8676002)(55016002)(66556008)(53546011)(66476007)(478600001)(316002)(66946007)(64756008)(186003)(9686003)(66446008)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r3ydqFLKifDWHF0VFWLWLjh+3EbXaoeJietDED2cQtsIkyeUTkXOTxTTYCNf?=
 =?us-ascii?Q?JMJKq8pNlHk31eWF9Zp1zIr0SqUfVB41+9cHi/B8SBACioNhxnOknmJ48Tbt?=
 =?us-ascii?Q?AbHr//eQ2yPXkQhA/YQgxT3db0DeWvffxLS4PUS6UBz42FeGEvsU4Ama9i7+?=
 =?us-ascii?Q?Y+H6x6wwLv/7YnKvyFZZM32Cm2uilrQDpMZIQvQpgEqwFZJN6zE3Lz4sGxIK?=
 =?us-ascii?Q?/H0v8DnJ2GonxsKA8hSgsd0OvHol+YjE1yi4LQIkRuge56xGxYVVGifSAYh4?=
 =?us-ascii?Q?hqbnUuGFclgs2hQknxzeG3Z1bVPpZMMES0gPrwF9EAero14dQNTkm6eKHX63?=
 =?us-ascii?Q?RAL7ZKLqQoAflz8z71ut1/vGbHa24SV0ph/YImx3fZXsKlqsgMvwMYRUZRaj?=
 =?us-ascii?Q?GxMAelRcZ0V8QToHQ9jduIZujZjOECWyQivlgN9AyNoyvmegumJDGBg2yc4Z?=
 =?us-ascii?Q?yHxBpU0Ub23sGmydr5IF5Nc5Ppw5qd9sVIVBMW3TBgNAHKV6Uvb2e7wmPoeR?=
 =?us-ascii?Q?IitWat5hXFSMrUbt9i6WhnnKfvmwZf/tF6FlotX3EO8Ie+cqP27jRp+vbpdL?=
 =?us-ascii?Q?6GvzYKTTy9elOn5JOmSr5cA7BZz1TjgZpXhzpDGega6lrw3lCZrmzNW7eOI+?=
 =?us-ascii?Q?dQbOZTNHsrnspNkIlZF1SmGVfuH0VoXZuwenN7wUsWav1bbxHOVl7I034KvR?=
 =?us-ascii?Q?TK5w7UdJBKqTaHCkNfX/SzoluOWCPhW+zh3ovok5iUl0wEzITu5Vv4FFf5mS?=
 =?us-ascii?Q?0ZTUsFNxVmin0/qxteivIAuoUMB/S90b4/jAH7L/HioNZlM6AekcfU5Fmky3?=
 =?us-ascii?Q?7l5DF2lPFWgpXFmj/JdfI2qRpwoxSXFZ61RHTbxeVQPGui9EVftSOo+xfhTy?=
 =?us-ascii?Q?SCwwvmmqs9UXyiy7E5n2GW5C3xmrJ1lJ+kxlz7/qoPfHeuEf2NRHf1OPGPal?=
 =?us-ascii?Q?vEOSsWfrXjLQyMvksq99lZjhSj6Zj7V+jkd8GZ7Wuowlz/VjrGV08GZ7h/aS?=
 =?us-ascii?Q?TAMcksyf3eDogWxY+71kO9NLLKKbup8lp7u82uO/MQI/no6LrP1K0HIS+xCa?=
 =?us-ascii?Q?SsGqrM0gQwEbQb0Eq2h1vlIUm0OteCz+fJqqhmhZqByoUcD3pAI/ET9PQGXS?=
 =?us-ascii?Q?I4ZdEIE0uRGxEZpHhAQ/rgJzGsSV3GLrgxYJdt5NaPBJZgOhZlSivoHO4izh?=
 =?us-ascii?Q?g3Jkd05I/B0Rr+blChUcD75P0th6jW/B/Tw50z8AVN6myBbJtqs9tQ1Bblvk?=
 =?us-ascii?Q?JGryIIargZmuy6M5/pf28Xd5+YO5lTm5tEEBr7bUMIoyoDemUaI6mnLmD5yz?=
 =?us-ascii?Q?Lsc2dF36yi/FyOABAYdYCGQj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda516e7-286f-415b-c1fb-08d956f1aa61
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 02:43:39.4286 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wEnNDhJ2UXhtGNLGxgRShBGtlZWEdo95MzBV1w+7sXdhUnu7tQkFZif/pbT79nnTw03lCf1e3FAo+EN7Sz6tjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3962
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

[Public]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Wednesday, August 4, 2021 3:39 AM
To: amd-gfx@lists.freedesktop.org
Cc: Gui, Jack <Jack.Gui@amd.com>; Deucher, Alexander <Alexander.Deucher@amd=
.com>
Subject: [PATCH] drm/amdgpu: add DID for beige goby

From: Chengming Gui <Jack.Gui@amd.com>

Add device ids.

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_drv.c
index 91a5ed96bfbe..b02c87ae4245 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1215,6 +1215,13 @@ static const struct pci_device_id pciidlist[] =3D {
 	/* CYAN_SKILLFISH */
 	{0x1002, 0x13FE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_CYAN_SKILLFISH|AMD_IS=
_APU},
=20
+	/* BEIGE_GOBY */
+	{0x1002, 0x7420, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
+	{0x1002, 0x7421, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
+	{0x1002, 0x7422, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
+	{0x1002, 0x7423, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
+	{0x1002, 0x743F, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_BEIGE_GOBY},
+
 	{0, 0, 0}
 };
=20
--=20
2.31.1

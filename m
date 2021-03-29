Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1772CC433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 08:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D4961601
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 08:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D4961601
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7262489FA0;
	Mon, 29 Mar 2021 08:22:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 471BC89FC8
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Mar 2021 08:22:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkccmCZwDemVrSsj668mf3LJ6JDpfpv3xlgfLeW21eqatp/GYxlifWI79Sa6TWVkvLnEmgDxEIDbXiKf38SB5eRh4LTvlg0cHRba2gmYNitIMGDLL4sdW2HUa5FcWToRpAo7XR6jBOSh/WkbePrJhQLOhZ2PuQ9thVAKSQbcWJ3s10pWRyb5lHTXdosjTEMd876uEuxmn27eUbjNPuvoXpP+Jj3MrjVOhy7hz6InZYE++S7ogRBkqB2d/cJoH5uzBw9E1sQ5ZwfTXWMj2Wp8umtTEKOpzompaXo8Bmfzu0OZW64DnhePi4WzcmAxUy6TV78RK54zP2mKHyGgPn+cew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dE9D/+3CKWi4hX9mDMiwBkvCfJLz9BpfiksMgIApQ8M=;
 b=n916whWRduefRpssofejGHyGU0qwXljb8xnuwK+hLx6y7nfeZskQfdsXsrugEn339uXzLkkMqrtL3iNZ9pWbc/rnEc8qUfiDRyMnFfxfo/rDuXFBFcCsypzvqx1k8aZzy3Koz8Hufz5f3aVMivCT9KUJpF3tp0+APk/eLG9S5bHkwGsIuZ2xayL4n/aDW+LBUBR9jGLO8AcyQlmY+VX++ynGOOPjTmZNn5g58dPoVwW2N6ko4DL3Uylfj/lkXyiZ1/xGSEYE3Lig+1ENi1LMv5ukWU2kkHN5PkH9Em4OcncGKtk8Qajo17ep/HjTCoUhchDCRy6GVr3QB/FfrYwm8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dE9D/+3CKWi4hX9mDMiwBkvCfJLz9BpfiksMgIApQ8M=;
 b=wMBs6dvzfVoAXweDyFAXkQJPIeszqNEYVnzSONPajbfFPtsP11YTgrFmt515GOXpnaoAqFx0BkY965ROSo8FTlUAtsZ1OnsAGsg2QRarCX2pCNxSVkcg745BykkQhMLF1IALj52f+Hadp/so1jV+3fdPmQYVVDWaEKCK9sV5F5o=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by BL0PR12MB2514.namprd12.prod.outlook.com (2603:10b6:207:43::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Mon, 29 Mar
 2021 08:22:33 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::bc9f:d045:c79b:cc20]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::bc9f:d045:c79b:cc20%4]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 08:22:33 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: skip PP_MP1_STATE_UNLOAD on aldebaran
Thread-Topic: [PATCH] drm/amdgpu: skip PP_MP1_STATE_UNLOAD on aldebaran
Thread-Index: AQHXJHGol5aijwQoBk+NlT7SjrOyb6qaoDIA
Date: Mon, 29 Mar 2021 08:22:33 +0000
Message-ID: <MN2PR12MB45490C2F19110D800391567B977E9@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210329080049.1954813-1-Feifei.Xu@amd.com>
In-Reply-To: <20210329080049.1954813-1-Feifei.Xu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-29T08:22:31Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=842e83ce-2d43-4bca-8d1c-c9564e11aeb2;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.197.80]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c346dd86-0a07-4886-2719-08d8f28bcd59
x-ms-traffictypediagnostic: BL0PR12MB2514:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2514135B33085AA7B935AA23977E9@BL0PR12MB2514.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 21L9kUD+YCngB8ioA4/UyJSzqTiceSYxYu241vjIWgZq/9E8idPlxmmbymt0y5c5ZI24noW5hW19AU2S9H3VVlExOE38YyAeGAEozf2c8o7UWsTp02GujCwNyOot4jvkA+12UoLVmYkkXmVByDsTV+MHRDm74bklWV8F1eYQWVEgZHekTYaf7XeWbTgQZw+ky4Xe1tz278V6dyMBKZUXr9EU9CEFkBUjTu/wqrgtV6R/w1OQlASiBNCGI+eAJfkvOOID2AkQmupmlqXfZjwWCJTHAhVZWfUCMZo3b5ODKOXAVBOyOid0cQQkUxpeq/JrjyH6EgW+Q6n2f3mwE4H1NMR8OGAsOTaKnEa6KP2E5Z1C6KHWh5aslLmy5GRW+Zu2+YKG6ZbGbslFtYRb1ftQzRYPrFEdMotg45Qm7koLr1iR7BaoDIBOOJ02cmJyEdqDBQctY+TG+af5MeiQ7IMcgiHS+AEW4aWI7pC6Y6IVtyQJTxyBpK5LuoVVCuxXgr1msVZKV94d5B9LYXC5m+i2a14VFmXCHWrvCI9mGwuk4g516UfRY1tJfCH5phDdTYk/yMlN3HYX9mzGJAwKZ7fs4u7dhJH3P9wkten1ZMUYiLcYJQq5P26siMPEsoFB97m1lJIqKQyjCOG8xDE2rioCFCpx4Iy3tOSiU5DjDH4xN7aQCcfRBg3zX4EEcQT80ePk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(5660300002)(71200400001)(478600001)(4326008)(45080400002)(9686003)(55016002)(53546011)(83380400001)(8676002)(55236004)(38100700001)(7696005)(8936002)(2906002)(6506007)(186003)(76116006)(66476007)(66946007)(316002)(66556008)(26005)(64756008)(110136005)(86362001)(33656002)(66446008)(52536014)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Xq5qZ7dmBuveoruGQUFRae89g0RYYqIEA39BlXrfIlzOhoBP3ZFxU3cAZIfM?=
 =?us-ascii?Q?RYwUUDJb3Ln81RW/CZOALJgH+puenHKr24ED0DfIbUUd2SmxWlnOPJmXlSBJ?=
 =?us-ascii?Q?pE5cKyCZbRQGStbn1Qxq6Mep+wOUm0Bur14g0yOM+Xmha+NW02NtL0neX/Z1?=
 =?us-ascii?Q?sVPWorushIs/AEjOGdFcAPccH6cogFKwqRlwThITW/QUscpxkkU08fgtt2NV?=
 =?us-ascii?Q?GklPNaddo5KupkL2hXKhDkPC2kjN21cxWeH5m7fASTL/NTgV+67Q9+io62Hi?=
 =?us-ascii?Q?WkWaRwKCXwDK3SO+iud/mrehQ7LmoBXbwkIb/6eds2VoMa0KrhXBW2PdK77k?=
 =?us-ascii?Q?OYymHNVJpl5mCNlk7Z+hpAVaqweO3ippJV3AiEGem+MtXVmbXI6bMH2iQqho?=
 =?us-ascii?Q?kSmfvGD7sgnO/TCadc41rX77IhYWZc/6h1nUqT4xuf//bo+W1PkBhjJ/6iwT?=
 =?us-ascii?Q?hk1mkBDPoDGqSfYmeb2Az5LDBeJ2IxWwCNGqcJsaoZhb7gBMdOQBnj/7jFZN?=
 =?us-ascii?Q?UfQ663km1UAApJ1CfAN8CDAPjy3TCNzOpgBGc9XaQc6GUq5D3EnNo/IcvS9Y?=
 =?us-ascii?Q?72nV09LZcu2agpeDYlr44XOthAlOQ3o1NDuz0Rte84qtXNZ6mlomB+hgtc/v?=
 =?us-ascii?Q?w/IUppzFRPK3T0h/wVNGmXg1xfUEP6xKFKn31zimNqIqau9WC0wmrFRUzbFl?=
 =?us-ascii?Q?8CVA4w6fMbAnVgzf7gcCH+AbY7VgWvxvHA8JYpnJtfYj8GSZi4uNjhqBz1lx?=
 =?us-ascii?Q?tbqwC9UG4uZrAID9SduNWSm2to2dxadSSwV91IQlHiePweWyArjgrc9DCeJU?=
 =?us-ascii?Q?9Py+Ie1SbueF5jwJs4Gjcm9LKUh9l5YelwgePANWmgMP1urVB9h00pXlK0sZ?=
 =?us-ascii?Q?g817p779GkDoPAdZxB6lE5J69Vs2RFfSxgDA0Pl2vyYBvB6ZBXSF5q5VRbva?=
 =?us-ascii?Q?y+DmmporNce/RRdO47L9QJh1+w0ZefdfD4IDRA4gRouQsCV6KZYUf8VuHod2?=
 =?us-ascii?Q?7exBEvhV8KGBL3XZnfJqAz68WyNM0bGE+CQeLM0cTGprjNlABMcJNtVc/D2v?=
 =?us-ascii?Q?3g/M2LZKD+mDymISZaoqjXPfc0UDTul7fTGmcwtat29KitKV6KWh4fqIAxob?=
 =?us-ascii?Q?vGTvzzc5z+y8TtSVVL77vXvYF923RjfFaXHH849g088gNeCG/QTiwaBlW83+?=
 =?us-ascii?Q?AhKoqK/7f4AJ3NPevf1P3aXdiIEalYV8JtjiJgCU7vyv3rlSDU0zzd4TPGH3?=
 =?us-ascii?Q?eFygoRk6SL3YqKsi8ONtCp9zsp80OX8EKiJzkBp8UrWT4551h09qarlcmbes?=
 =?us-ascii?Q?tlvYLPwbWXT3z0QpP5FI8fVp?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c346dd86-0a07-4886-2719-08d8f28bcd59
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 08:22:33.1009 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lZ6M8Zj33qPbw4QZwHnaQlZZk9ou2+2BFVWKRQfG8uiu8DAThcNRKDLuuYkYtDIO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2514
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Feifei Xu
Sent: Monday, March 29, 2021 1:31 PM
To: amd-gfx@lists.freedesktop.org
Cc: Xu, Feifei <Feifei.Xu@amd.com>
Subject: [PATCH] drm/amdgpu: skip PP_MP1_STATE_UNLOAD on aldebaran

This message is not needed on Aldebaran.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 389730a38e19..9e769cf6095b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2172,8 +2172,7 @@ static int psp_load_smu_fw(struct psp_context *psp)
 	if ((amdgpu_in_reset(adev) &&
 	     ras && ras->supported &&
 	     (adev->asic_type == CHIP_ARCTURUS ||
-	      adev->asic_type == CHIP_VEGA20 ||
-	      adev->asic_type == CHIP_ALDEBARAN)) ||
+	      adev->asic_type == CHIP_VEGA20)) ||
 	     (adev->in_runpm &&
 	      adev->asic_type >= CHIP_NAVI10 &&
 	      adev->asic_type <= CHIP_NAVI12)) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C23fa3ce75c6f468866cd08d8f288c8e7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637526016608801916%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=P%2F9wglE2vsOtD7DVjG6gtmpOKrXcmLt1b2Dt5VWI%2FTs%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

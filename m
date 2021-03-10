Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B294C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 16:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C36F464FC9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 16:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C36F464FC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AF006EA36;
	Wed, 10 Mar 2021 16:33:31 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85F396EA36
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 16:33:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9mUwg1nzbQS41T6y5rujoycIYrui0il5PxGvsEOCbkN454rse0xeNxpqveR6Lmc4umYquqCa6rcsEBlnF8owDONU6JyYElpy5S757EzTnUd2zuPXkS9idq1Hzu/1p0wURXRIlNGMntgkrHUMPtvt4u8SDSMfGz78QhoQ7O1CNo3poNF4wPYCG8mdsPiPddQQDdFceccDSpTextWFn2s1igRc2vX5jihuFn8rOXCEzCw9fP25LvWNGYo4eagFHvtJ8E0yo1EPzrlffdn7eegOkNqlRfRdVXYBUu2g6zydRIzzvv0VUAPL3DYfjv6SvTyFEdOzAjN8tRbAk1ln6mh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTAu/CaV/hAhU5yDxwsZvZJYFZzunGVQI8mHcQG8oxI=;
 b=bHxYnBnMmoYnZGtN+u63LusgYzIBIR6dTDasg21KqVmNpy1azD4wkl4DZ/OxrRl+mEcg+2c2pbrXfP9IMrpvpM5eEkfKrR6V7tCwQRIeqNzoU2Q0rSgzxb3ked7j5OrTXKlqYbdNAOq35B4Ufhfeiijox43zNQzkj914Nj120faUjtYX4p9AS43aTYvn4PwTF6si/dwMXw+vYp5NNPmES+Wyoe5bsGkCJCSFtq8LEFyD2LaUNoIc4uGdIJqFTXmhBOUxPKfKlnaJUdiqVEjXsdzzxwuhGfFenne7/nw3OagCMu3UGV2/OlBjfgzCaK9ueuFZMF3vpZ6tbU8CFxgXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTAu/CaV/hAhU5yDxwsZvZJYFZzunGVQI8mHcQG8oxI=;
 b=bq/oDRzEqJuIPfQa7drdbJ9+Ez4BizZDL2CQtEkXZNrvzAlh4a9UtoUhrGJwtF8ZghVh/6mhMrOk0COT0MiOJZvTuyBAvuP3CVIQ8movcv4UeXo9g7OL66OC2PvJwSVlgdMy1RJ4C1kbsCBn8mPRcUDtbSjSx7WlY/cgzOB78EM=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 10 Mar
 2021 16:33:29 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%3]) with mapi id 15.20.3912.030; Wed, 10 Mar 2021
 16:33:29 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Xu, Feifei" <Feifei.Xu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu:disable XGMI TA unload for A+A aldebaran
Thread-Topic: [PATCH] drm/amdgpu:disable XGMI TA unload for A+A aldebaran
Thread-Index: AQHXFbkwoGM76KNBL0aG6TrO57tSgqp9aZ1w
Date: Wed, 10 Mar 2021 16:33:29 +0000
Message-ID: <MN2PR12MB4549221A05C28043AA57294297919@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210310142509.2252166-1-Feifei.Xu@amd.com>
In-Reply-To: <20210310142509.2252166-1-Feifei.Xu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-10T16:33:26Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=baf8094f-854f-45f8-aeb1-5daff00089ec;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.201.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7bd5035a-2ef2-4175-c976-08d8e3e23c9d
x-ms-traffictypediagnostic: MN2PR12MB4126:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4126581F5B49AC2D89D751D897919@MN2PR12MB4126.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oGePVMU+ZlaQ/6zfYQUNzx17o5Edr1uH44vTReo4JCNOMjptfhIJOhpMFqpMXCZuxqiF12Pu40wl57isgf+lMc02Uo+wZTu/8lWxTkDeJIzR6fQeYhvboskkbC2MLAE2RujfNQnMaxP2y4yMcTn0c6v1wgwBakmfj5jfuOLDd6gS08H/vRrx6InFKlO3L8nHvV0O0m0R2UZF5zx4tAthj4FhSm20oYPLZz7umyqVq1yeeXbMxTm/HwGPFJHjacb1EhJBXpjOvMy7ChWLTjT8i78UxRPqcqyGresz//YfXLLSg80IfNN1gNV24hwzzYhnq0eZ3SYAXSTRzijUrb0bwdfw/kLnb3b5sXy8i0FvKCqzgYDpIjarWmcLM0XJoBAn4T0L+WEu1lpwMuH0z1CMcvKrEgW1811TWNLsnFtAUGVE+M8wHHDoPjxwbMHNNwO3rs1DxwtBBeTjWDjQ4tFKqGxLLYqLAtYTdB7hD8KKRKRl/aGp7X+8Mmozmu7igY1vovbIUPH3cggfHO+Xc0V9KQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(110136005)(54906003)(83380400001)(55236004)(5660300002)(7696005)(71200400001)(2906002)(9686003)(33656002)(8676002)(8936002)(26005)(64756008)(66476007)(55016002)(86362001)(66946007)(316002)(66556008)(478600001)(52536014)(6506007)(53546011)(186003)(4326008)(66446008)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6sAVjUX865RTp7lcue8dTvt0TlGsc2l8tf4slpulvDaSPHzoJbod7MzYwBI/?=
 =?us-ascii?Q?KRwrxwAxi+I8ZVDGU4yOiobW7SYturQVeF2eVQMp31hEV4+/YeGDeFBe5ajp?=
 =?us-ascii?Q?KxL33cnYJH9eJHUCtWRtaPt7fsxAed3VAMLg3VmDE3JvNj509BuL9IqtluKR?=
 =?us-ascii?Q?jMRj8ON9gDU1IJdvsiIsmsYRm3Uug6Vtwnb3BxYhKWRFpKQK01pXXHbyYi0N?=
 =?us-ascii?Q?QyTv+VufCwVgrtfOi1k7gtB2dwwbfViz796KiNDgj4LbemeoiGDNdwKjpw8s?=
 =?us-ascii?Q?n5Mo6LAVbiCXdsJV0M/nHgczQOEz/GEUqP1WXQcRcjdyvy872MMK02DTzZbQ?=
 =?us-ascii?Q?yeWvmVpVzOCYu/rinog/D1BpA9VqLOJI0jlA+CT6fFz4IBn6xN49nIxl4sXQ?=
 =?us-ascii?Q?GGZg3xJ6S4CO+RGo0tSxyiwcWubAw0WvdXxoBjOVzszbnhrQ01L+OXiF0kpC?=
 =?us-ascii?Q?lJxdb1/NNdVF3q4oBpA9qlOiv074E5XWEafZCW+kQ2pGVCrAWD3xJBlj89aL?=
 =?us-ascii?Q?Mh12evYjusaRTC1MkFqdoHr49Kh6lIYOl7tLjXvIZdxlNrb3toIj4GI4AnTv?=
 =?us-ascii?Q?690tl0chRWcJKKpB+THQxXfk/5/plnoMioSko7mwJa3KcQAo+Wb+wkapH+QF?=
 =?us-ascii?Q?VKjXFxLTitJNw+VR+tGnmSmUnsejgP5JVFUbb5P4n7fHx2gMS8LkWTHqoCyL?=
 =?us-ascii?Q?EVs3I/cp9nx7VgeoZ0nXXaN6NKlOuvVLKGi9m+ZrzAEn1WEVwcNCMCZfyQFC?=
 =?us-ascii?Q?KApiuM581f1OSIqbYKJ/pfC41liyJiAzpcc7a3hXaoiWM2158AdVUk0fUvQ+?=
 =?us-ascii?Q?tD9nsckEdKbcY6HkFgRhsVBhQSzsCpRcvZxk2qp1kTgodVy+ubCe6i5xZbPn?=
 =?us-ascii?Q?BkctuKEb/1HU1/PDMJpP803N+64yxqQIsh5QsBRcpPm5bHDTOAwZMy3AG5f8?=
 =?us-ascii?Q?jCFv+0aaPpqyzwGdMKJlaPzovbNKsVJpf67EWcCPZovZRfrG1DKg+t0IUWh5?=
 =?us-ascii?Q?t58gcO/No/DkS709jbxyU8s1V1ON4BUVAmtMy5hCptBIkj2dhOvF6nXM6k2Y?=
 =?us-ascii?Q?Rn7tiLWWJvpG5uQ7u76vrlP7W8B5D0pWd0i8KMcCUQQi3O7ouvtKuPsCWwoj?=
 =?us-ascii?Q?6D+jyvOIhYfPSyFm8lr6fsymoD3qmNGGuikEvi/oiKcrMs984GlY+O2gzpyd?=
 =?us-ascii?Q?ecgcRP7IyE37J/FW4+hhgjp1q0s3IBiPZaD67Qn2vIYoNGM0KHF/ETibPBV7?=
 =?us-ascii?Q?3dnQ8AfXa3IskVbyNEFk+RiGtq8v5mrvS5unM288mDuodk/6z/4mXx6E58hh?=
 =?us-ascii?Q?bT0+9+R42zLfA+UsEgl06JGz?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd5035a-2ef2-4175-c976-08d8e3e23c9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2021 16:33:29.1604 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ozs4Ne04R90ijQezwBOvgqdJ821+YOPlf0V1WJn7HQOzi8C/TtzTD6ZnwqBuVij5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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
Cc: "Xu, Feifei" <Feifei.Xu@amd.com>, "Clements, John" <John.Clements@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: Feifei Xu <Feifei.Xu@amd.com> 
Sent: Wednesday, March 10, 2021 7:55 PM
To: amd-gfx@lists.freedesktop.org
Cc: Lazar, Lijo <Lijo.Lazar@amd.com>; Clements, John <John.Clements@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>
Subject: [PATCH] drm/amdgpu:disable XGMI TA unload for A+A aldebaran

In gpu reset, XGMI TA unload will cause gpu hang.
Skip it on A+A aldebaran.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 80a4dc51951e..bae304b0d67a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -791,8 +791,9 @@ static int psp_xgmi_unload(struct psp_context *psp)
 	struct psp_gfx_cmd_resp *cmd;
 	struct amdgpu_device *adev = psp->adev;
 
-	/* XGMI TA unload currently is not supported on Arcturus */
-	if (adev->asic_type == CHIP_ARCTURUS)
+	/* XGMI TA unload currently is not supported on Arcturus/Aldebaran A+A */
+	if (adev->asic_type == CHIP_ARCTURUS ||
+		(adev->asic_type == CHIP_ALDEBARAN && adev->gmc.xgmi.connected_to_cpu))
 		return 0;
 
 	/*
-- 
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

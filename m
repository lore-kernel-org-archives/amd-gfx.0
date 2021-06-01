Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45229C4708F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 06:16:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E71BC61376
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 06:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71BC61376
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 732A26E1A7;
	Tue,  1 Jun 2021 06:16:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BDD16E1A7
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 06:16:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V12E4MCjLknw8okuTKRtZIwpDTSUeIdYkf7UDvInKpqOFnJp/AYSVmsZ687c/YBALjEZ5JtHM/JX9ww+DS/JYvCaArEFUSbiQs69+5SsV404uUBpVFOEBfFcK+N4DMWoWWoVZPw6HDaD9GaB1W4Dwj26+BtFDzcMQiKNI9pj0C1dG2oT0NB8SGBx7ozH6VYNLr87N/OE4C2/YhGw2NJKgZo4naezi6zf0GdItO7sdBfVMs4zAaFJ1FmuXoj81nLs6r4hs1ckZ/cXEhGq4hQruVDgPYeB0C3mMqXx7UOx+u7XxEXQ3cioFp/TyEhIRO6t1KSMXkrEXoCmBQKLIPkayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pc2yvpVoMZbhgmjcqCzeXSeIw919aHvdQPyH5tn+dE=;
 b=j6UmFhDTNbF1DLirc6kzjyencKemEiFJ1P1GkvIxcGiqKEd0pmlw2fJ1obusNQC82nDCRt+QCLEcLZivgvFnrz/xv/fAgPDbaQ++YCUeceVEyY2i4x4y01U7k9SdB7X9xbFBZ7wAEwTG214bryOyT8lSKq/fgOTcVpgfAwbrJwa/Dpu9W8Uc7ydC+b+xFMV/mEeGPTw5ZTMpvVUT3tP35PFjiYl2dc/v1pzKqIxEznBiKszl/Pze9oxOQGihYF8+0G+ggEgg7EmRqdzIHxBknlquhS19ig0ZofkknvLZiAE69p/BZ9FHRxKSTwRTe5crv0kos158LNWR2gIJ2P+geg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pc2yvpVoMZbhgmjcqCzeXSeIw919aHvdQPyH5tn+dE=;
 b=iGl6sB1+IFIU0PP0+HkWiUrySZiiGRDn6sI4WTCpc/tudWsBTdUML1U7Q6vKZULyfzOJlwCCkCBwT2oQg64/AFl5EJAwrtXhrW0+x2C0cdvtxYMPl6692ADlh+vI3cbOjuPT7i8SkZUIDw46GOdkZ9WYS7p+1+aVm859eHGsIBA=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH2PR12MB5531.namprd12.prod.outlook.com (2603:10b6:610:34::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Tue, 1 Jun
 2021 06:16:07 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::9c3:508d:5340:8efd%6]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 06:16:07 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: optimize code about format string in
 gfx_v10_0_init_microcode()
Thread-Topic: [PATCH] drm/amdgpu: optimize code about format string in
 gfx_v10_0_init_microcode()
Thread-Index: AQHXVfvnPr5JO/4CtEWRxHtGheLWOar+ruxw
Date: Tue, 1 Jun 2021 06:16:07 +0000
Message-ID: <CH0PR12MB5348C905FA1350FB87C3E95C973E9@CH0PR12MB5348.namprd12.prod.outlook.com>
References: <20210531090337.35153-1-kevin1.wang@amd.com>
In-Reply-To: <20210531090337.35153-1-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-01T06:16:04Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=17c95910-a30c-4c04-b6da-2df68d975dd3;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.159.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76f95d05-ad1a-4988-43f5-08d924c4be7d
x-ms-traffictypediagnostic: CH2PR12MB5531:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB5531D689A9E3C1CA3C3763CF973E9@CH2PR12MB5531.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bIqwi8cE9nIMSAkYm8GfM+GsLSvcV7nNqBWlEteWJNjrLlwsuo5+1tGvHkX9BmApW7w0ppyHiqlxopJSqV8Q/7xL8j9EoCZrO/f62kVFQuu1nRCl85hgHKP9ebmb0glfqCWZ1CXsEHlNJew1bTCd1JzrXBQg+Shd4BxEwuAdVqNY5cYweH1BwWLI48mKlo8yqR03QVgtv8kg4qWDvGPuP6M4MhgEUfJreAWAUosa6VkIA4WRfZ19m4+DrY7UbxmkX1AcWJxoPBFhUdxt7r78s8HDJDwh2Ssvf1XGbrj7tjV6G3lZJUuS4g8g2OenO7wTuAIvVum4ZwWAXrzGV2ZL/UP7EwZdmFcyyAico0exVckZQSErG8OLMIuc9R4XQu+78QOR5IJcHwZornzYXfz1wNTzk27WPUKlHrBFqt2NsoYMzOfr4s9AwRwoHr4ST646srgnbjUNVh5Uxi2WQiOYyLgL/RVcX2Zq1iw2Ss0fuUbIQKWQKbcbNYDxrR+lpRzjFtIkg/fE/B/ilLTco5Si6N0dLtUyPp/VEJlF/31tRJ2weDCBwsSelY38FnJ0wh4/ZoChFT8u7NYUPna+aJKTXah/kY5+0lE0wrr0HKxWk1Z8UGlAwNYycOfmQyPCfPrSsThA9WKsBdTir2xdTNiyVQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(316002)(54906003)(76116006)(8676002)(38100700002)(478600001)(45080400002)(33656002)(122000001)(66476007)(66556008)(4326008)(9686003)(186003)(110136005)(55016002)(66946007)(52536014)(966005)(53546011)(26005)(6506007)(71200400001)(83380400001)(66446008)(86362001)(2906002)(8936002)(7696005)(64756008)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EXfnUzmwfS1g0iCZMuTQ5WsJakiBusWkDcMNnbWIuDropKUQmGSE1sUyVC4i?=
 =?us-ascii?Q?yiTwQIh5Zb608h/Bjfs7SJkLHYfdEDUYcffH3BycLwSHNpZCoxcABdHj1lrX?=
 =?us-ascii?Q?6CSiinPdE10ZuA5xI4vvvPQREDtQaDxXs5QL7sqLwyFOAIkjowRN2dNxHIBx?=
 =?us-ascii?Q?HsKh29n/fVdvizIzIpq76S9nfBMXyowkF3F/x6zdR4IvOIG5Ba2zaYYeNIU1?=
 =?us-ascii?Q?OONzTCuG/zxyxVH06nqsY0Io5HixEBeJse+K4smcNofbbBU8ZMQsG+zaRC6g?=
 =?us-ascii?Q?N/5rCnkNIMqyr1T2e4DPaub/hVcNqKeGKWM9ZOcT5vYjCdhpQxSdeIapfdQo?=
 =?us-ascii?Q?7QX2oXF0oC1F9t46XOkZLGWVrDfb3wx1knCcQIJpfKwn/ge8otbVkB4dJlX9?=
 =?us-ascii?Q?nXGxwY+30WAQQxQS3EjDDdWfbYwxm997fpmDBHVzMqVb1xLAEktdAiLUDKKM?=
 =?us-ascii?Q?zAGG5CeUdkk5UKKnZN6DrxasA3f+MvEI1Q0QDOMWVWwqyVynFqdac3F3CneN?=
 =?us-ascii?Q?Z9Ae1dpn4Lmm3oaWkpsOVkGX7tRnUlV0kjZqmBr/c1rriGbAyUYTgblbckCN?=
 =?us-ascii?Q?w+9LDXFmN/ifv1WHQYPhEhch8eEqFW8aCuslOsF0d7wojs9dEaarySSh691e?=
 =?us-ascii?Q?irDMzCvJYYi4812ziQ+Jwlpu/tIkx1cA0QB/Kd85BcDCnXXXMxW1zB3tJmYX?=
 =?us-ascii?Q?uGTRL0dihHEbHNijcvGHwlhiWdJkb1AY+WY0WXSb9oMVBn0uy+O4WVQOwtwD?=
 =?us-ascii?Q?iLfG8tar21/gZQGubTlVOb3JAzcdftrGXA72sx/kvCE/pHvVE60FIy/MvoiC?=
 =?us-ascii?Q?+1x8Wd1lmXze7rFMAvYJIGLO4iLtJlUgigpn8x5jDYb86ATkD49Df2kfhhMh?=
 =?us-ascii?Q?3qgklPlY1ezuK5skMDmyDH6la48MzyrgsbATs72WT38JBEwFtqR+Hv6tmrHk?=
 =?us-ascii?Q?XIcsVmsunus/1HNJMGvz0yxf728R115VduWJchU+FJlxb7/iJCefaqen3Nlm?=
 =?us-ascii?Q?BjJU9QFleY6MGx3z+ENI6Q/5jA5Kg92scBIHFvXHjsl7hFG+FC/kg8BmvuJq?=
 =?us-ascii?Q?8suFV+dMu1rpSUs2+9Iz+ts7ziCMP/ZdEeqHlHj9BuILBQAyo1GLWpsqe4Q7?=
 =?us-ascii?Q?bYkcXTdGN71uUMVg6XpSKQyjr0+xjA1LMpznSPVwG7U76rQ3AFWrg0QcygBM?=
 =?us-ascii?Q?nt1gAh7b6s6smIwJadPLSBDTKRg0kcJn1TxlFBl1z3+5Ty4no9OoAmWQl4DD?=
 =?us-ascii?Q?PmzwY9ErKv04kS73RJ/0Yum7wEisLqY04WuvoWvHoCdCq+YmF51l6LHAJUa6?=
 =?us-ascii?Q?96TJV3WFLhVN0Hex6Wvu9XUr?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f95d05-ad1a-4988-43f5-08d924c4be7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 06:16:07.6740 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oD9tHwrUEu1igzF2GaQU4AYlTK84bRiNitPlC6LM69HfDRAAMSEr5BBma2P7jaqw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5531
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
Cc: "Yin, Tianci \(Rico\)" <Tianci.Yin@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kevin Wang
Sent: Monday, May 31, 2021 2:34 PM
To: amd-gfx@lists.freedesktop.org
Cc: Yin, Tianci (Rico) <Tianci.Yin@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amdgpu: optimize code about format string in gfx_v10_0_init_microcode()

the memset() and snprintf() is not necessary.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 80729ea8416a..11a64ca8a5ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3935,7 +3935,7 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)  {
 	const char *chip_name;
 	char fw_name[40];
-	char wks[10];
+	char *wks = "";
 	int err;
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL; @@ -3948,7 +3948,6 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 
 	DRM_DEBUG("\n");
 
-	memset(wks, 0, sizeof(wks));
 	switch (adev->asic_type) {
 	case CHIP_NAVI10:
 		chip_name = "navi10";
@@ -3957,7 +3956,7 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 		chip_name = "navi14";
 		if (!(adev->pdev->device == 0x7340 &&
 		      adev->pdev->revision != 0x00))
-			snprintf(wks, sizeof(wks), "_wks");
+			wks = "_wks";
 		break;
 	case CHIP_NAVI12:
 		chip_name = "navi12";
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7Cb0b99aeb763143b01d3508d92413082d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637580486435468121%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=PLuexS%2BPtDaRwqU7VougmHPyCX84Kb1M%2FsJI29AOI34%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

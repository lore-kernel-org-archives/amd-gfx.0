Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E63C47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 04:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E5E6124C
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 04:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E5E6124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FABA6E064;
	Tue,  8 Jun 2021 04:49:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C35686E064
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 04:49:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaGsricYUymOf5kfJbMHc8D3F7xhJzuSDQ0NhxNAH8pZoYC9vH5hKJPmZIHPigMW9wAFgf+YLgvpl/cG6M7hW/A2DUXIuuLI+QaMn/4wXcy2U8lmXKpaiCCJlLOiAeIOxkfAwGPkP21Vpl2fh/7cNFOGyer8XIS6VoHQ0+X9EicyaMhbydNvVHyhHVlO5tN8BRlG3CfPrLBSUmkGGzpb/VrYDoXqQ3B9AHNWBDZuZV66mtFWdB1P7QTHGP/C5kowPBs7SPGv+2VSNu0AApq1DPkq8NdPQkKBihlavniC/UgKLfyboXwN+Gulg5NTW4mm6q6XHHPGV5YSoeKv0vMz6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHbUgBi14z5PgpX1d/CrWsQ+aDpvdGiiqPQgsIMmEzA=;
 b=BeTajHahC99Q4/6P4ar65KTRYnP7O1TFljXk7tLCsiGC99G56xuRzj1gQwSI2YjTyfB6Te69mJRSKCXvsuJouTPKZ1KGEg8fP2SaGskee2zmIRdn873nKVlAmkot/Rnr7X0LV8dBOUMvgbs8UolmAxmE3dfdKF1Lp910mQalgp3p13/NJv/pVrUifl1uVF2GbTl5Lkszyu7J1NaPFlB07/+pYLhATm+cU9fv22jaGWBHMuWRfvEP4swKKK13i379UVLpGTL1FKvNI8AxWoIlVL1O4jUkR1QE258XJrUwp5JtZ6E2DWerTopkQRh75XWpfmHSJu4TKT4/M3GU+TpgLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHbUgBi14z5PgpX1d/CrWsQ+aDpvdGiiqPQgsIMmEzA=;
 b=jDSra4h7pDy8B0iGUT9mo7tCXada0KooAi82f1WJELsbzqKwTKLoM6cgEoUCCIjHizSbOYJVCeb8SLacNmReG58waKqZSg0F6s1o5hSS1tiV4A9xiL8qmNURNn1Rlc1zmyhXEviZhj3WOg/HMlnZUrkX8xtE/ohMRtKugsI6VKU=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5228.namprd12.prod.outlook.com (2603:10b6:408:101::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Tue, 8 Jun
 2021 04:49:44 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 04:49:43 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/5] drm/amdgpu: add psp ta microcode init for aldebaran
 sriov vf
Thread-Topic: [PATCH 4/5] drm/amdgpu: add psp ta microcode init for aldebaran
 sriov vf
Thread-Index: AQHXW9KqMZ6t6y4nH0qzBUOHbQgIpKsJisnA
Date: Tue, 8 Jun 2021 04:49:42 +0000
Message-ID: <BN9PR12MB536850996EB131CF4EA1A29DFC379@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <20210607192248.21969-1-zhigang.luo@amd.com>
In-Reply-To: <20210607192248.21969-1-zhigang.luo@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-08T04:49:40Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=4006bdbd-a4d6-4027-9dad-fcddc28126c4;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7554d20c-3862-4a0d-a980-08d92a38d51b
x-ms-traffictypediagnostic: BN9PR12MB5228:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5228F9CA674192CB4C6A03BAFC379@BN9PR12MB5228.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eBIVUHQqJ7xD0Ub4XipyCj3PwoibvujxpjzkuphkRkQnNTwsLStskOJEfwaoshCNJb+qkMVYt2zJGzKfViBrHOYag/cy7uLy1s/FLKBL2CgCqqcEn6UtfbBx+h6J+wmVLVjsijyQO6NlsHroCEohUpycBObV10+b9+Pr0U8NPWTF4RVA5a2lEytPthLNe3q3tb2efwkQrcgJWW/WMsze8AKiFC5Ow8lEMRThnqYhNfUt1v/OEomRARjrv4+RORbr03qdakgxRki9XE6UGJ+sMWgyYAd5HkHW1Chz2kusYC/XX3J0Gvk1aHnqi9thb9xn/K2D0uHw1xGyN373yi0uE+RNyEbdvR4UMJIle8ocbwq+phUxgllU8yQm5oQzh3uaV3FSeEImJmm5NLuGeD/YZH5JFYliHlalH2zGuOYetyKaSkKAZscV8Kbk86mujRF7aJtMJfnB1DUJ3ENhigX6GFDwt/zwbNF/vio0ZiEVDAfZLD5ZMLmCIi7h0W0CrXVZws8K8Engci1sAkyN7fJKEOP4pzEznx8mKphvDg50baw6Wq0BMpHXTVVreLb7ctLOeS6KBQ+kK2y/ngwCFcumgMOjdYn28seoMcAilMKeGuU1RdQMoU2IGSIVYHNi6fTRtLFPJAwq7JxOKXwpsAADsA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(2906002)(71200400001)(5660300002)(186003)(26005)(33656002)(9686003)(8936002)(316002)(55016002)(86362001)(110136005)(8676002)(53546011)(83380400001)(6506007)(66476007)(7696005)(4326008)(122000001)(66946007)(38100700002)(66556008)(64756008)(66446008)(76116006)(478600001)(52536014)(45080400002)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?agCiWFR0GonQqhCVgATOQ5ZNbXRYmV9PMs9dBujS6XlkAak+ZcUKKV3Pgjbo?=
 =?us-ascii?Q?KANLKqJn8Pu5jpyDYBPctXmsr3T+LonBooYwzxLX/GcEe0T5YSPUOGeao5aO?=
 =?us-ascii?Q?9X21+dBwo1hCrxwg8xIzuGlPKC/cR/P+UWULnD0WKxbXXadZ+g5o5l4NLJoN?=
 =?us-ascii?Q?s336be5aNVMLsJbLJLWNi/L7wTSaW1N7xfgcHPPNQSHdXhLWwupsoRyDn3zp?=
 =?us-ascii?Q?VukcuzKd7s0i4yXDIvIde39wnWb0l9vdYrCeJQ3PsQcOstIncGcy/pFapifh?=
 =?us-ascii?Q?salM+saQY5XIFm2/ALfkc7QdYXxaAqfhq4PhqRQgHrQvrv+OqDHSgYuT25Vh?=
 =?us-ascii?Q?p/QAT6nwz1T8LDvg9yHOvy1rLbgOcAhJYFV6XeewBkBtUDD97rBgvZX+ER2J?=
 =?us-ascii?Q?BGYvgZEjfwXzIh9uT4JbBKqVWr40fjRc3ZCNKbrLzPd+Il9uxGCjhwl+DP+8?=
 =?us-ascii?Q?e//7fBUt3y1ZIBfwfti428eRGBwEYGpEWjF59U5uM3o9aNdosxLkNj86FBqZ?=
 =?us-ascii?Q?fRRoAXIRdHBdYUVF8VWj3w0XoK66QHT+i7yTcmp+WdJ/FiR4If8eX6Ij1EGj?=
 =?us-ascii?Q?2wihxNiA0dN5m+J72SmSdUknrNds10VHktaaDISM7Z8IwkoCs0dpWM6Ozlne?=
 =?us-ascii?Q?CpG/m1eS9RE9vEPSkrrQ9fL1LDuPWJJYd2Gvded5kjTfn24zO3S1w4IjPbnn?=
 =?us-ascii?Q?Uq3F2rQyPfRQ8DFwJim4V5DNgov7ZgR5G8l4KB13lIcNuZLe+HVeCa0gu0xP?=
 =?us-ascii?Q?htyhlVa0gpo/ld+tW94xaYlWcM5ibJzRGM+wKGTpJULjbvLTwD3XUuScv6iU?=
 =?us-ascii?Q?LxDgSiGp7YjS2TYkVA7JuG9HjH0PNjCn7wNsmFHKzBzEwtmnqgMChgFbXWhQ?=
 =?us-ascii?Q?6VdFdjocM3kfUwXXEqUuT7ngvVGG3UXLAZsTys1nfMkE03PDag1AztipHoXR?=
 =?us-ascii?Q?WnqHFt7sQUpO/TuO2wgWP1XQ+Xb0N9h3qTRrX6PoLppzgtzyqirR1My50vxX?=
 =?us-ascii?Q?BSQUcj2Xc2TJ9dsXCd1PhFGe6PKMKQScksglqqoQOl/aguzAgwp/yZKSYJ4b?=
 =?us-ascii?Q?kCCzv+5350ODmZ4rteapyp5LMj9wASueu4pz+D4wymu5RO2GSpyOeHMIeQlP?=
 =?us-ascii?Q?Kouv52Am9lOQA+xpyf0ZaYH/tyW++L+/tRZAHvgMISwQbyCMoG1ld9XhkyL5?=
 =?us-ascii?Q?3a4nEjZizkQuo06YQxiK5vCDvIiwBLh/tkoKlK+rmewBdx0P0pGwg2nDgg3C?=
 =?us-ascii?Q?Ao/pwf0c2GPiPbTZ34iQ9K051bzTrVjh5w8YbRRrLkZS39dNT+B1rQ/VWr6Y?=
 =?us-ascii?Q?xrBcpnxIEE9d80nySD4xJyNL?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7554d20c-3862-4a0d-a980-08d92a38d51b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2021 04:49:42.9898 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gqDkpc8IYWgBTgAIDo6nL9eK8jUw4EJ6t5k9Jx/vdnfJlkpv5jTYh90ZmGZ1eqN6yQUDv80l5CRUFI60kqSkFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5228
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
Cc: "Luo, Zhigang" <Zhigang.Luo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhigang Luo
Sent: Tuesday, June 8, 2021 03:23
To: amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: add psp ta microcode init for aldebaran sriov vf

need to load xgmi ta for aldebaran sriov vf.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 47ceb783e2a5..29c365160043 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -180,6 +180,12 @@ static int psp_sw_init(void *handle)
 			DRM_ERROR("Failed to load psp firmware!\n");
 			return ret;
 		}
+	} else if (amdgpu_sriov_vf(adev) && adev->asic_type == CHIP_ALDEBARAN) {
+		ret = psp_init_ta_microcode(psp, "aldebaran");
+		if (ret) {
+			DRM_ERROR("Failed to initialize ta microcode!\n");
+			return ret;
+		}
 	}
 
 	ret = psp_memory_training_init(psp);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7C8cbe6723fa4747ba07d408d929e9b239%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637586906401459821%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Y8c2UrpX0irS1Ob1rWKc3%2Fi24jTklgItFLq6HZ4kQgQ%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

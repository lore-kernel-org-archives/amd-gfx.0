Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957C2C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 10:30:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4411C61244
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 10:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4411C61244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D566ED0A;
	Wed, 19 May 2021 10:30:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BD326ED0A
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 10:30:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4mvS6i6vNcSVtS4FhMxiJqghKpRPpkFrcKwAqhb1hf2rPC23QeS69eNdvbK+uC7KhFSjAgiXDg2oAzO2pM2E3QOZ4WTHe95ZlWw2qw4atAPGUK9iovpZTVn2Zj8S/+AIOmf8pw1ithlz8cQQ6KDMjZrWcM5IptE/Beq8OjSG5j/oOte4UUL+U/J/41oXlqA2zXQxyE8VXMuq7JgaI4rT5MKEoqJ4A7aCqT3cFgtSAzU6QDvMTBzHSoBoFEgRVJge5wA4jDnGM/Q8fGabF/hbwIlmHG3eh7oMMMHt4s++KWFxshz/XbiSa9TRabVWXRdEWJA70haE+ctxJKg+bes3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cb5za/TbagwKQuEqggjr8lRRml4o4L2YJiOaAoBk6Ps=;
 b=imP4l/7vxVIeOxLruXdxLXa+7nFY15m5vGZCTQTDOCsbkV0ymzxYjI1+Ee+ekgyYBNESZKOVXfQZdVTh2L+3g+VMFcJpjWQ7bb6pIAdiR9EC9VkQ8d0vf1kKP1wEZRjnQ+3h3SyRJl82pbsETj48DcwW111OI+A9ps6eHJDInP8eB8breUlKCufKLUhqwdVw/sQHWSQ+bMDUQJ/KeO+dHA/tffDVYrU8c4Yo48mR6kHx9vELFfviajFcYuIusCVwy3bx0Z5ln51qqRHZ63d5snOy013YaRDvJKXdinXUjnlAh7PnBXBVorgmM7whPd2WWzI59nZa6ulFyEDMLXhZfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cb5za/TbagwKQuEqggjr8lRRml4o4L2YJiOaAoBk6Ps=;
 b=JCJ5tyiS5HEvaO4WMqL+VaqClWHW3OftZXCM0Y2HhjoLIIVshl90xVAPYacyExoeNsUj1ksgN4xqyoukt8gE1/CPmYfG0qj5hfYrUQVhRMsV3cwW47BzIrEsYj7dehEyeTUJ/8mgXpcdQCaUHbZsU8Ktly3FUW6aHq4R/+jwm0I=
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1598.namprd12.prod.outlook.com (2603:10b6:301:4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 19 May
 2021 10:30:43 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::f07c:dc0f:e7e8:416c]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::f07c:dc0f:e7e8:416c%4]) with mapi id 15.20.4129.032; Wed, 19 May 2021
 10:30:43 +0000
From: "Huang, Ray" <Ray.Huang@amd.com>
To: "Liu, Aaron" <Aaron.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: modify system reference clock source for
 navi+ (V2)
Thread-Topic: [PATCH] drm/amdgpu: modify system reference clock source for
 navi+ (V2)
Thread-Index: AQHXS/BfT/AxYdOZr0S9jizOea0/JarqnBgQ
Date: Wed, 19 May 2021 10:30:42 +0000
Message-ID: <MWHPR12MB12488ABF5729F74CBA3BCE8BEC2B9@MWHPR12MB1248.namprd12.prod.outlook.com>
References: <20210518141559.1360041-1-aaron.liu@amd.com>
In-Reply-To: <20210518141559.1360041-1-aaron.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-19T10:30:40Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=2891d157-7a2d-4820-b68f-7aa20a384419;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa4a61bf-29da-4e8d-0839-08d91ab127e2
x-ms-traffictypediagnostic: MWHPR12MB1598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1598D54BC89F3B01784BA82FEC2B9@MWHPR12MB1598.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ejYVg2/bU1d2rDjLYgNCge3VW5JlcOnXilZh8KqI9ylw+CtMRLuoY4nV2Rv5aBcU2O6qDqTsu8hNuZTmpt7H+HwcfklkQMNHSe/dqygHm8kGLr1jNiCDT5IXj8w+jUTQ5h6+RRTk4dBmgZP2R89OgKVsvDsqEpS0SPyRQGgH2nbHc3GR0cyWVYiWf0gI8tcjswNA+rxI6sSX/YSsBhrxZ9Z/tf6YRzlHnnIjZPOJNdcPmfKLPipSIvSI7eTirTd5jZmRDRjK/d+JD3+j5mtR5P7JXPl+5XoahGWgfX+Kiu9Lxz9Ruj6udmdSNyNUd5c9uDgC1YGKFw8XSMc2EXz/ME+I3BK8ylPl+X7sglnzw2BZa57EKeC1X22Ep4Dfc/XL3/SmS5nH908Ra0B6z44WWSpFk0nrRODsikyqoiVjhbcLIdz21hrMu4w/U0aFWPYj09qzfXH6fXlb0/b8lJ9eyn6Iu0kpVyAHWF+0C2UX9onA9CRq7etCktZGdy+W2+efRohHDaqZdkRW1YQEoNglTjk5HyBICCEytBIsak/f23sKMcmCZYBGtXAVvd6ZyK68YqsnxBoIst/48tQYZh5yTl+wEW8gSP4r4OL3A/3Ey0s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(55016002)(9686003)(54906003)(122000001)(64756008)(7696005)(52536014)(186003)(66476007)(66556008)(66446008)(86362001)(53546011)(71200400001)(316002)(26005)(110136005)(2906002)(38100700002)(33656002)(83380400001)(8676002)(4326008)(6506007)(5660300002)(8936002)(478600001)(66946007)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EqJ1yNt1R7FBNc6TIZQn9kP+ORjB8EOi0Va5VlwFH7COVDw29JKahVjqt5wq?=
 =?us-ascii?Q?xKV/BXzdhoNy/L03H3jonbFY+YBjsPmyx6B1HrUcSBS+vLZkqS6hG7qZeSRN?=
 =?us-ascii?Q?wIQu1jYwikWzME2e4zcHnoYXaldL1ks9rlvpP/OCmiCjbTuO/abPEtwfH5Bc?=
 =?us-ascii?Q?2/2F4IYWEhWJ7rhha6IO/39om64v4H28IS6tqOjuYN6xz7TUUV1Jdgt8g4BY?=
 =?us-ascii?Q?ArZEwNrUocIhe481hIfYSGRPJcJF+XdUsZYLCuXUDGcpsPdn4q3aaU48AKxB?=
 =?us-ascii?Q?qEVmdb/+jl7G8SzvJf2ggeztKrognhrPufaKwJO0RBfGvIZKcBvLBGpyfNgr?=
 =?us-ascii?Q?VBz03T59IIbl9LFQ8yu/SXftSc1e470Ktxahhb56lqpDn3pzlaKixROcsbAT?=
 =?us-ascii?Q?xAEsyoXmGGKbJV/pKV8SvP2YTc6Q3+ofZTa7ZjOs9AZD9l4cbu+/iEUTCRN7?=
 =?us-ascii?Q?0S7DvCsr9yK7MM69HX+611HrZzgIpIwj4/YJjgVUmlmUCnb6UZNjZFXUii21?=
 =?us-ascii?Q?Iu0kSXIrGOoBC22EorjL0GoPBV6EYh2mlG/Z3H5zvKxjpWQinpddWTEUDkHU?=
 =?us-ascii?Q?bUtZ7CLJzryAmNJNnKYg/ysRw0Ib5O5+QLPY8wPyC9hJzCtbsfsM4VLBeNoc?=
 =?us-ascii?Q?FbCgqqjncBhdZzhvMTvLeIrVshZUqqGEWHUj7u/mhjrIF/Tb0hNRVIvaw4sw?=
 =?us-ascii?Q?3T/Qw6tQ2h1pF1lA2nXGPDPNg4P/du2N4gVf7WbMfhZxvX0u/kwmST864ZeK?=
 =?us-ascii?Q?fxU4vggXkRKTIvwbelRyt+hdMzVUVzElF3hpAYTRo0LDtE9SgE6IXrem7rjb?=
 =?us-ascii?Q?yuO2hgyebOFKWCmhN5g7JV8Hpbh7Z0wObQBbw6bHxSS/fRRIpA9EFxzJ6HrC?=
 =?us-ascii?Q?ikLBWZe/Fiu+63YEDuefF4jfEFaRYp4BlkCh5DbEMyjmhdMzOPTLU9VxXZCZ?=
 =?us-ascii?Q?uxOd72UzTH+gLt7vo+pKGJF2HquLbioO4es5wWjiyrkY6/5rYv976TJZDbNC?=
 =?us-ascii?Q?++0qkYWgUY3MPaU+vjLS/smJCJU1MyB2gFq9KOMAIhaZkSiWaD4SIVWHrOow?=
 =?us-ascii?Q?nVcIyr64cK9dypjFix7S4huMnVBDXLnaRk3OIixO7MplbPPg2apIdbXqtaJp?=
 =?us-ascii?Q?EfmteUhQcQQfvZ1pUyKx2vW0qIQBm5f1MFvhId4xzpn4dBk00vqw4TQ3xiHA?=
 =?us-ascii?Q?jvd/10vFIHesfkk32649CsG3ojssEHtoTC+UUZ/RuQqC93JFAQk/Yq5u47lz?=
 =?us-ascii?Q?zS4FfoXqpQUB4IxpsSk35Y14Cp3U+YNuAvaiknLHP1bY/TxDXkQ1VjYomPqG?=
 =?us-ascii?Q?yC4ESEtEDZTRddq9qzEDK355?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa4a61bf-29da-4e8d-0839-08d91ab127e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 10:30:42.8254 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 07sBOG7J//ZbgzSaUn5sg0UKWhvfjAVRo9/N4MzTzvWgDRwvuwDT0F4tn8hdGgphJIRQ1/UDAMi293KvFqBGTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1598
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Huang Rui <ray.huang@amd.com>

-----Original Message-----
From: Liu, Aaron <Aaron.Liu@amd.com> 
Sent: Tuesday, May 18, 2021 10:16 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: modify system reference clock source for navi+ (V2)

Starting from Navi+, the rlc reference clock is used for system clock from vbios gfx_info table. It is incorrect to use core_refclk_10khz of vbios smu_info table as system clock.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 8c417014ca89..3b5d13189073 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -546,6 +546,21 @@ int amdgpu_atomfirmware_get_clock_info(struct amdgpu_device *adev)
 		ret = 0;
 	}
 
+	/* if asic is Navi+, the rlc reference clock is used for system clock
+	 * from vbios gfx_info table */
+	if (adev->asic_type >= CHIP_NAVI10) {
+		index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
+						   gfx_info);
+		if (amdgpu_atom_parse_data_header(mode_info->atom_context, index, NULL,
+					  &frev, &crev, &data_offset)) {
+			struct atom_gfx_info_v2_2 *gfx_info = (struct atom_gfx_info_v2_2*)
+				(mode_info->atom_context->bios + data_offset);
+			if ((frev == 2) && (crev >= 2))
+				spll->reference_freq = le32_to_cpu(gfx_info->rlc_gpu_timer_refclk);
+			ret = 0;
+		}
+	}
+
 	return ret;
 }
 
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

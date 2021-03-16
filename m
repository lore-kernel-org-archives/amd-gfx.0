Return-Path: <SRS0=fEJB=IO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016FBC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 05:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B235C64F37
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 05:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B235C64F37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A12589D30;
	Tue, 16 Mar 2021 05:03:46 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 412DE89D30
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Mar 2021 05:03:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3gONimmcl2A4nTVLvWZf+9BiDrkkjpzhD1Dz8s/03AW1thjPw1Wwape20AGcGgxXZuT0/AdA5q+YZg3DkHtaI1OdnKxDeX48GRXwuZhLJ+9Vk6naBmdduz55Q/mDYDtyjSO4ih45Zh/tGRtLzgCrqGGDcfyegXs8gxRPLao7Ya+bCTuTzI6i87od9TUpG2Py4xBv0EoFMx7g1N7pfmlP+Dn7fMYf1bPP9YeOqQt+AnWcRmWuvcnOi6nvVfqt7Ewdkq+xLXg+v7S1iMro3eJUGMqby/6b2oV9JUTJjp1BTwEgCRYTsdmQnBrhiL8cAX0IROo7Jy99HZzuCRIZQW7fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6H3oBcLmfTAH0ozSkrOKuYTpd7S0tafL1Eik7yOyoOs=;
 b=Zu7j4Pnypt3CoRtuvqt6HVSDEN6T7zKfP4xy3F9AjJBsDCwRzeWZv/UXF960hxGDqt+6EOeRa6lJhWTw8yrMTAuvd+vmW4quDxKYgjryLXW8ZHBOU/PEC4DoisubLr4eELqUs1K97JPduhuJ4j8alrEMV4+YQKCxCTvd5yjokw0TJYiMBPEv8LwZu9e6eAY5ZC5Q8WgRLd5l6nthp6g3XSjmJMI/Kbg4+okIFXlEIvYP165uYkXDiT4knqetZo8NE2yCvJbsXD1NihK3a1HAsPpfRRfiJclVIG6tui/oKbmJxySBVMwarmef2KkjtRoJOxcSpBSrd/HPZo0mQyGGmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6H3oBcLmfTAH0ozSkrOKuYTpd7S0tafL1Eik7yOyoOs=;
 b=iy/bDuN3SfSVjiWVfGbfcgEb+4Py/G7DQ4XouapXy2//z9of9q+q/ywS7dAiOICMsVTKvENzLNkAUR2As2NJPB4ZAJGcVR3HucYBUFn6xbGtJgTRliLtLbRjToR6QbwBUfdNkjlxee4IuCQFvbyWmsDYAEvPgUoSpk5PZuWdWTo=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM5PR1201MB2505.namprd12.prod.outlook.com (2603:10b6:3:ea::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Tue, 16 Mar 2021 05:03:42 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53%5]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 05:03:42 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amd/pm: Use BACO reset arg 0 on XGMI configuration
Thread-Topic: [PATCH 2/2] drm/amd/pm: Use BACO reset arg 0 on XGMI
 configuration
Thread-Index: AQHXGbRx/1LlRbacSESqfgww/ILfdaqGD+oA
Date: Tue, 16 Mar 2021 05:03:42 +0000
Message-ID: <DM6PR12MB40757F991FC80845664CAAAAFC6B9@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210315160059.27937-1-shaoyun.liu@amd.com>
In-Reply-To: <20210315160059.27937-1-shaoyun.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-16T05:03:40Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=6a6e5add-d86d-4fa6-b1c3-b034ecf25824;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8b965444-97a1-4626-756c-08d8e838deac
x-ms-traffictypediagnostic: DM5PR1201MB2505:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB2505B5C305A9094B030548CCFC6B9@DM5PR1201MB2505.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2rp5QvC6/v8eJtQI8w4QPT9qEntAaFWnOGjWmjPTV1peq5j07BHUTWy5cIYI92z/WxYxjUxOPIlbOiPnZEZ7pFYUjmlUpcY8muboLRmuTtksYd3xXk8jBm5dAu+eBz/Fp2rpPADC0U/+YamvbYpyYoxdL8oHxF/Wswl63Ywo+CjYH+Z0bHSVQ1UGrYPlwkr56vbwFqhtseP4MqPQb9jSCDcLRAbxpAF44vD5E2Ag9mIhJtwuMH9Ag4cjp0yGzJx6qyn4JVVncdoM863tB9sWYV5gPP8gubh88Q6MMHRI9luM4NXofIsntACK7iTEWyVoAX3UQnApqvpChg/9aXKm7sGuEI6QMcrY7N4EFp/9evQC0sYPbf8bz08A2FkXjz320cGHR7nCJ7LzIM4H8fWF6g3q1aC2Wu+jaHlZFtypLLIlaxcBObnfv77pK5XXsxZoVhC7gLPum+f8emCGK+okEaCDdi/CKwUf1YwMidPL1Did99Hi/Tnv/tQy1uku0AzxUIGOKFJRuMeFkPxpAfWn8fkvJ88jd8GDfEoq8SQjH4wTa0PUKGZCKgKL39MChch83/jl8i9SVTiddLNhTtAT2FjEL932KF68/akVv35EwTA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(66946007)(110136005)(83380400001)(64756008)(33656002)(4326008)(66556008)(66446008)(478600001)(316002)(26005)(66476007)(76116006)(5660300002)(9686003)(55016002)(8936002)(966005)(8676002)(45080400002)(186003)(6506007)(86362001)(7696005)(2906002)(71200400001)(52536014)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TphlLfahgBC2JfEdD3AagNNfFy6J2ZOUNqmE5gNgHsujl03QYiNLw0hTlv1b?=
 =?us-ascii?Q?OeH6YRlVeEBkjMUisAZn7r6LjlnvNwpegV/QmMtCALTosY44rcq79vXfuHRz?=
 =?us-ascii?Q?4S2yw2+zpuxjIY3ZbaPR23iOn3l/U4PdvhmlTr8LtqMJpi3yEAXIimONafOp?=
 =?us-ascii?Q?w3XNPIjKvnQ7gpV9vkEoj8eCnGtS+6weJOlWNWi4i1aEQ+PjfISjpE4biEdG?=
 =?us-ascii?Q?pAe/QdIM/QIxc7tKPZPSXYtlNPVbDTPfLB2EGx7nOZAZRTm8PilmdO4rwus8?=
 =?us-ascii?Q?GnOVRcdYCsTZ7D2FscOQKXqECQqtUpAqp/mRAhijMU4UJbvPr7g3ZuIeXU3B?=
 =?us-ascii?Q?zk9/DHl3p6XgYWh9e3HX5BOxiQDG6IYBBL5bivjJRBZiirjE7oNXI/r1mcSL?=
 =?us-ascii?Q?3IMlyDQW7HU2bmMtTtEGhCdY9UMC0+qdoZ0YSeJic28qa0raoixAQurK20gI?=
 =?us-ascii?Q?aC7MhtiLSY4yMa+dWWgr6ITvVvpZ9UvAynhrPt+hbU/lW97DpBlCOmEzqMvT?=
 =?us-ascii?Q?M9Q7dS9dE7MlGiMj5E7kQApZait7rOrfeRpEGwCyuqXNm7rh+RewzZlaLdmV?=
 =?us-ascii?Q?gA+DdkgPVCYsHpLTcwLF+8lX1IcKgsBp3zJcwjSmle0LDcdILS+9mhE8rbST?=
 =?us-ascii?Q?OCz1LDW3JJd4q3UnbRNQq6pdF7qq5epL5THDFAdad38ceaFPmlMVRJhZ3cU2?=
 =?us-ascii?Q?5xUuN5LHJEMK1oKfcZibic373rAn6WVKMM6kpAezxwCtAJnyhbmEMNumBTig?=
 =?us-ascii?Q?IDFSbtSYjFrjVFIXt4jL1oUGjO4NpuRA8ocaUre83pfGZlfDILOfzDB8DEe7?=
 =?us-ascii?Q?GkMlyFxAIc8EUc8yiXXatw436HNm7WzUZ63BU7gSvXuSql/uztrJyXOtMc81?=
 =?us-ascii?Q?DtWqQ8UFR8O1PNxQIen3t3DzwJwOyCijBVpJzXrtE/0dpqHrVce1jaK7xgsU?=
 =?us-ascii?Q?KDZUW3RmRjfuIYdUpZob/ULR94DjOSl6xCqgBHuSnsgKmRFYKoQKzNGJ0fy2?=
 =?us-ascii?Q?aX37QLgOIQlEzNoxRDlsYVHAz7tG56YZAt+xZlhprwtyylONzpRORnRdXJA6?=
 =?us-ascii?Q?aqarQyUG0kLlyr5GzxARkIHG7ysIZx3xekOuMlO0o0cJp/EpsxZ8Yz5LpT/d?=
 =?us-ascii?Q?3nC4n2CRzIKxWt+/R5hsDCrU+zBn0yBzmzMXHJnzisOjwclcVx3dZOlYiUix?=
 =?us-ascii?Q?+awt4WmbsUq55y6E68Yl2ONNDuRqdabjJsLAUceCdpiE26ADO8ha9EnSq2Ma?=
 =?us-ascii?Q?EZcm5uRT/M0rPrW6O/pOD9y1wnE5yz/XYu+985pZao4o0UiPK6zQ8wc5cFXj?=
 =?us-ascii?Q?GPMsOfq6DVxcvVoaCMWupx9v?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b965444-97a1-4626-756c-08d8e838deac
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 05:03:42.2929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yhAbUl14TdC07YjH7m4ujXAB2wudMdq8CKmGH6jBWDP9bI38U5VeGa82FqqvGavk8x6cgBCDKcRcuUek3HKp3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2505
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
Cc: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of shaoyunl
Sent: Tuesday, March 16, 2021 00:01
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: Use BACO reset arg 0 on XGMI configuration

With arg 1 BACO reset, it will try to reload the SMU FW after reset.
This might failed if driver already in a pending reset status during probe period.
Arg 0 reset will bring  asic back to a clean state and driver will re-init everythign including SMU FW

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
Change-Id: I6df90d963e259dcf1df8fe3716cdf52681202162
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 635bd5da2133..0d137af1a78a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1530,7 +1530,7 @@ int smu_v11_0_baco_set_state(struct smu_context *smu, enum smu_baco_state state)
 								      NULL);
 			break;
 		default:
-			if (!ras || !ras->supported) {
+			if (!ras || !ras->supported || adev->gmc.xgmi.pending_reset) {
 				if (adev->asic_type == CHIP_ARCTURUS) {
 					data = RREG32_SOC15(THM, 0, mmTHM_BACO_CNTL_ARCT);
 					data |= 0x80000000;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Chawking.zhang%40amd.com%7C7fc1a8b6a8ad4558d66608d8e7cb9004%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637514208814705008%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=lUx4TxuP7UonfSP%2FafxYIr%2BT1zEiqohMOpM2HlPIENE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

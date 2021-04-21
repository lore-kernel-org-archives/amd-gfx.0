Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6003C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 05:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A90A61405
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 05:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A90A61405
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D3D36E94A;
	Wed, 21 Apr 2021 05:59:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 389FF6E94A
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 05:59:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkpLKLvp/6Z4oPiUgKR6LfV5wZAeDFec9eGm/En7X3SQopjzISZHL5YdjVcrRMKRq5kHOxYyBrgI1g3wCLyg+VNaNp8pjjsCWvEK5Yy3gn5J5uE86bvReVIHNOWVwYbV+qbiGBqrncrgyxZt476ajeYEKX6ERyvYaMhuXbr2S2lBLjdboi9SMbxUI04cjdY5tbi/gjXMeNLmrmvs7G72xkfhyt/au+Phrt/Sc24BuNUjhOfM6QeqCGYzO8MOFhRJoa+Q4UzTljD7SXqZVKdz7hBav/S1KlOR1U5HByEIn/1uMDC8RhdvxXusx4iQDUnr9tZYQzJmvRgrWPjW66W6IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmXdCVagsrWG2p4qBzl8bTlye+AB/NQNgzyhcJ8pFaQ=;
 b=BgiddZp6OcedApPqCcitCD64zIFZzwzF7sPU5cr4oEQPKcWQ5VA+w0/pVb+402J3OJy/Drg44rrESTrcZ7RM9eo/F27K4RMjR8x6KkX7EFz2Mbp3faFj8/Q5MQwC1dvMZSqauLVpE4A2UMmHypDvebjHAiW8Dv1jm8SUVZWVQB5VeoiBHPfZbSvocRe9uAbYtiqobL4m3tK/X1m6klTHhEt3QIxL0fysu+e2yDpBs/ELicOwoilKduimHphHyU6nbBTR+EqSxtlBEsbZRsTvmmerGVSJ7SOGP8yvYJS01hzW1lsx6ai9yjzjrXhOIyr7QYcbMnDENCI50sxspdWjmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmXdCVagsrWG2p4qBzl8bTlye+AB/NQNgzyhcJ8pFaQ=;
 b=J66HZsVjsMuHKnlZeWhwYZScyVKd/DhoOx6AYZi4Igjaf8Fgto9Eyp2vLyrg5Cf7KKJsUz/ZWzh6jqlFPkDxapZFNwkYgF1nHA6UE7UTeD0NtmIM7hbriTjSGgMgENRIzyon2/V4mWqUOXsYCbty9yx9VgIPDLZ3jG9SjRSNiUg=
Received: from BN9PR12MB5368.namprd12.prod.outlook.com (2603:10b6:408:105::24)
 by BN9PR12MB5366.namprd12.prod.outlook.com (2603:10b6:408:103::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 21 Apr
 2021 05:59:19 +0000
Received: from BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85]) by BN9PR12MB5368.namprd12.prod.outlook.com
 ([fe80::245d:c14d:fd99:be85%6]) with mapi id 15.20.4065.021; Wed, 21 Apr 2021
 05:59:19 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Li, Dennis" <Dennis.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: refine gprs init shaders to check coverage
Thread-Topic: [PATCH] drm/amdgpu: refine gprs init shaders to check coverage
Thread-Index: AQHXNnJJMLwE0WAI60KKCJTtwslCp6q+ebqw
Date: Wed, 21 Apr 2021 05:59:19 +0000
Message-ID: <BN9PR12MB536835E49DD19E1BF64CA9FFFC479@BN9PR12MB5368.namprd12.prod.outlook.com>
References: <20210421055037.17849-1-Dennis.Li@amd.com>
In-Reply-To: <20210421055037.17849-1-Dennis.Li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-21T05:59:17Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=e3ea9ad7-3a68-404b-ad02-3cd7aca94b13;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e9ce710-687c-4b2d-3e52-08d9048a9ad5
x-ms-traffictypediagnostic: BN9PR12MB5366:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB536699784E0058CCEC069EF9FC479@BN9PR12MB5366.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: acjaVaGPWYm/W7wS9UDNr7d51uKprbFoq9KBh/eedbk9Myw4MDLbp5s5uHABvYTa8Jopfp60FB4LSX+UW0fwj8KtvkYNNi/HHCaCB/66VzonHJ/JpwmlOayEliFHGFXOhi6mdb8buaTkWaf2HPA+Ja09u6fnWjLYWnQN5b3eTg3VzqxAFIxswoH/CHrO/L6YfOldJhdPT7uJErKGIOdq5/9Bb9dxNXFbaGS4D4eseU62XLTtJTLys0uz5H4+ag1tq++9KFMWDpnHMa4IUVsW/miLkjMn0B1IkVi8/y9u2hZPVqnRKTODCpz0YFhnRXRp0dvrS/mr9f1tNQa1rqgIuh96KK+4Or/U0fu/MDmNRhc84IqZb2IyKZUGob8/Rh7V8S2V7SV7xFyaluNARnwVWbjRfq9stjwaow4Sz7pj7ZINEXa2euExI7pXfQ6yz3fDFhMz11P06+jzYaH7KVHIBd7Z/gOvXqzG9IPjtRTbDiX43Wx20y8xNQbUOmDKl7TnAWApQnlVKLgKdoMU9WXIleTC6ydzgp5RhhVBGPh2fVDwV9OXTjzOp1IHgSwt4OB1a4NKyiDO/+Obl6KzMAsF9ZsP2tp+k+7rhqzyNWwsnc0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(83380400001)(38100700002)(122000001)(52536014)(8936002)(71200400001)(6636002)(66556008)(66476007)(76116006)(66946007)(66446008)(64756008)(55016002)(9686003)(86362001)(7696005)(5660300002)(6506007)(53546011)(316002)(33656002)(8676002)(110136005)(4326008)(30864003)(26005)(478600001)(186003)(2906002)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GIhlRQ5jhrMpR7IDot7Q8gQjbDHi6pM2inkUq83Jkj7J/9HmNJ7Zer8Dse4r?=
 =?us-ascii?Q?anwZzJtOvdk7ADi2hKxePL/fN+EGB4pkYSXVRrSiRglmSacs4n2hdq9eyfCy?=
 =?us-ascii?Q?uoFZOzv+udiRxpeRgL0wgGyFR2dahju9LDCUSw0MdHtxBcHMzwCgTO43XD+/?=
 =?us-ascii?Q?Ub6uKo9k6lFV+qNIlLLEd/i4BANyfl6kGBP+kQ5wtBpGOZ5VeFXkmcX/H3KW?=
 =?us-ascii?Q?hQMUp48IgHNM4mHkvvelwFHPK3V2+ibKX7WUesX2k/lqjE3RgXGVm4x8wa/G?=
 =?us-ascii?Q?6B7SozYU6yZ0CywDSmMInZxvhJZ20FYsxHQLzjVfNbRqpKgBVq4Lh8gYLCYN?=
 =?us-ascii?Q?nCniFEyfhKkLzkNtSeVm5PCNv77sJAD94cgLhSICdVzlrOpFeCk+hBOg7GvC?=
 =?us-ascii?Q?wGQFkAtDDIxJzslrmyIm2iJAVacW7w/N6YO5fvEUqr1zUlcCv8kj0RF/cP1s?=
 =?us-ascii?Q?H80Seipsp+R2kvtzRzotzogxG9fNVJVGVey2ApMd8JJfRQxK6nNhuy4l+E/k?=
 =?us-ascii?Q?95QxwENsBVb72B4UBp4MYLixJ8aFGfTPjAykUv70k2ysYhoaFJFr9YV0jr5k?=
 =?us-ascii?Q?ccbZhiab9XYGpEbRDlp6jlb1/VG1Q9bCSeiQymqxQoaq+hid9KHe17FNGGY6?=
 =?us-ascii?Q?5QkwfuzkjddO+hMQaPbyoT0TQth0XIeJhE3cWJQ4Z3/Hcux6ozPewztsaBm0?=
 =?us-ascii?Q?QJ66kfwaH8O/96cuwcEIZHqsnacoF9BLnAPPrfL648/W3W+Jq0AgUJdy6zyf?=
 =?us-ascii?Q?0Ry+qolm/w7byy4mXMTUsiwCd4C8cVhjKvY75Zn7J8Nd/67TremRBkvG9SLI?=
 =?us-ascii?Q?yk68rRpT6SecslUcPTeLAWdTKlYBKy+0lnJOxZi3yQqxd5UwyRGHNkji4Knz?=
 =?us-ascii?Q?cXKqJuuvhBlQhignP0A95cZ8utHNZiSzb9doNWTQwkoa+DOPDb21fEAePz+Q?=
 =?us-ascii?Q?yANuwjejmMqCOG5WQDr3G7vGoJ50gYNoB63TiNkspByKkJC7vQeLp9dATJAa?=
 =?us-ascii?Q?3GZRjss2VnM/8lypjvRuaBI5vzC4++41GYlW/MBzuNo2FEL7eZ+ZYN/rE/Tt?=
 =?us-ascii?Q?p9oE9PXhBYNLB0hFFkJ9PdqAz3jbTSbejopGRn0AQDy1o2D2oy/3ma6zMS7O?=
 =?us-ascii?Q?uDWZLOdbiZOxH7YzqAgiXl69GT9zeB6UGU6muSBUQYQKSaY3O7mFppcU0cXU?=
 =?us-ascii?Q?+Wg2Ig0qKSy3w+IylKVyjjeoaW7cXwQu5Vrf/IabmJwEBE0+JVXcILZMWiM9?=
 =?us-ascii?Q?kvOJFmB74T1vVk0JnAGbbqO5fly2UqpRhWfK7TbQTV6blsbVOON2J2ZcosPW?=
 =?us-ascii?Q?Fyodd65fKRWERoPPoB2cFQwy?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9ce710-687c-4b2d-3e52-08d9048a9ad5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 05:59:19.8354 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GOhSgJlZ17I320ahMmm52hs54jcEQI7bjMHMNO0xbEOQuSXTMtvBZ6jMoE1aq8wAIMQls5Z2cd4aKas3shichA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5366
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
Cc: "Li, Dennis" <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Dennis Li <Dennis.Li@amd.com> 
Sent: Wednesday, April 21, 2021 13:51
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Cc: Li, Dennis <Dennis.Li@amd.com>
Subject: [PATCH] drm/amdgpu: refine gprs init shaders to check coverage

Add codes to check whether all SIMDs are covered, make sure that all GPRs are initialized.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 9889bd495ba5..9e629f239288 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4656,8 +4656,7 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	if (!ring->sched.ready)
 		return 0;
 
-	if (adev->asic_type == CHIP_ARCTURUS ||
-	    adev->asic_type == CHIP_ALDEBARAN) {
+	if (adev->asic_type == CHIP_ARCTURUS) {
 		vgpr_init_shader_ptr = vgpr_init_compute_shader_arcturus;
 		vgpr_init_shader_size = sizeof(vgpr_init_compute_shader_arcturus);
 		vgpr_init_regs_ptr = vgpr_init_regs_arcturus; @@ -4924,7 +4923,11 @@ static int gfx_v9_0_ecc_late_init(void *handle)
 	}
 
 	/* requires IBs so do in late init after IB pool is initialized */
-	r = gfx_v9_0_do_edc_gpr_workarounds(adev);
+	if (adev->asic_type == CHIP_ALDEBARAN)
+		r = gfx_v9_4_2_do_edc_gpr_workarounds(adev);
+	else
+		r = gfx_v9_0_do_edc_gpr_workarounds(adev);
+
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 9ca76a3ac38c..798c0e178201 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -22,6 +22,7 @@
  */
 #include "amdgpu.h"
 #include "soc15.h"
+#include "soc15d.h"
 
 #include "gc/gc_9_4_2_offset.h"
 #include "gc/gc_9_4_2_sh_mask.h"
@@ -79,6 +80,377 @@ static const struct soc15_reg_golden golden_settings_gc_9_4_2_alde[] = {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, regTCI_CNTL_3, 0xff, 0x20),  };
 
+static const u32 vgpr_init_compute_shader_aldebaran[] = {
+	0xb8840904, 0xb8851a04, 0xb8861344, 0x9207c006, 0x92088405, 0x81070807,
+	0x81070407, 0x8e078207, 0xbe88008f, 0xc0410200, 0x00000007, 0xd3d94000,
+	0x18000080, 0xd3d94001, 0x18000080, 0xd3d94002, 0x18000080, 0xd3d94003,
+	0x18000080, 0xd3d94004, 0x18000080, 0xd3d94005, 0x18000080, 0xd3d94006,
+	0x18000080, 0xd3d94007, 0x18000080, 0xd3d94008, 0x18000080, 0xd3d94009,
+	0x18000080, 0xd3d9400a, 0x18000080, 0xd3d9400b, 0x18000080, 0xd3d9400c,
+	0x18000080, 0xd3d9400d, 0x18000080, 0xd3d9400e, 0x18000080, 0xd3d9400f,
+	0x18000080, 0xd3d94010, 0x18000080, 0xd3d94011, 0x18000080, 0xd3d94012,
+	0x18000080, 0xd3d94013, 0x18000080, 0xd3d94014, 0x18000080, 0xd3d94015,
+	0x18000080, 0xd3d94016, 0x18000080, 0xd3d94017, 0x18000080, 0xd3d94018,
+	0x18000080, 0xd3d94019, 0x18000080, 0xd3d9401a, 0x18000080, 0xd3d9401b,
+	0x18000080, 0xd3d9401c, 0x18000080, 0xd3d9401d, 0x18000080, 0xd3d9401e,
+	0x18000080, 0xd3d9401f, 0x18000080, 0xd3d94020, 0x18000080, 0xd3d94021,
+	0x18000080, 0xd3d94022, 0x18000080, 0xd3d94023, 0x18000080, 0xd3d94024,
+	0x18000080, 0xd3d94025, 0x18000080, 0xd3d94026, 0x18000080, 0xd3d94027,
+	0x18000080, 0xd3d94028, 0x18000080, 0xd3d94029, 0x18000080, 0xd3d9402a,
+	0x18000080, 0xd3d9402b, 0x18000080, 0xd3d9402c, 0x18000080, 0xd3d9402d,
+	0x18000080, 0xd3d9402e, 0x18000080, 0xd3d9402f, 0x18000080, 0xd3d94030,
+	0x18000080, 0xd3d94031, 0x18000080, 0xd3d94032, 0x18000080, 0xd3d94033,
+	0x18000080, 0xd3d94034, 0x18000080, 0xd3d94035, 0x18000080, 0xd3d94036,
+	0x18000080, 0xd3d94037, 0x18000080, 0xd3d94038, 0x18000080, 0xd3d94039,
+	0x18000080, 0xd3d9403a, 0x18000080, 0xd3d9403b, 0x18000080, 0xd3d9403c,
+	0x18000080, 0xd3d9403d, 0x18000080, 0xd3d9403e, 0x18000080, 0xd3d9403f,
+	0x18000080, 0xd3d94040, 0x18000080, 0xd3d94041, 0x18000080, 0xd3d94042,
+	0x18000080, 0xd3d94043, 0x18000080, 0xd3d94044, 0x18000080, 0xd3d94045,
+	0x18000080, 0xd3d94046, 0x18000080, 0xd3d94047, 0x18000080, 0xd3d94048,
+	0x18000080, 0xd3d94049, 0x18000080, 0xd3d9404a, 0x18000080, 0xd3d9404b,
+	0x18000080, 0xd3d9404c, 0x18000080, 0xd3d9404d, 0x18000080, 0xd3d9404e,
+	0x18000080, 0xd3d9404f, 0x18000080, 0xd3d94050, 0x18000080, 0xd3d94051,
+	0x18000080, 0xd3d94052, 0x18000080, 0xd3d94053, 0x18000080, 0xd3d94054,
+	0x18000080, 0xd3d94055, 0x18000080, 0xd3d94056, 0x18000080, 0xd3d94057,
+	0x18000080, 0xd3d94058, 0x18000080, 0xd3d94059, 0x18000080, 0xd3d9405a,
+	0x18000080, 0xd3d9405b, 0x18000080, 0xd3d9405c, 0x18000080, 0xd3d9405d,
+	0x18000080, 0xd3d9405e, 0x18000080, 0xd3d9405f, 0x18000080, 0xd3d94060,
+	0x18000080, 0xd3d94061, 0x18000080, 0xd3d94062, 0x18000080, 0xd3d94063,
+	0x18000080, 0xd3d94064, 0x18000080, 0xd3d94065, 0x18000080, 0xd3d94066,
+	0x18000080, 0xd3d94067, 0x18000080, 0xd3d94068, 0x18000080, 0xd3d94069,
+	0x18000080, 0xd3d9406a, 0x18000080, 0xd3d9406b, 0x18000080, 0xd3d9406c,
+	0x18000080, 0xd3d9406d, 0x18000080, 0xd3d9406e, 0x18000080, 0xd3d9406f,
+	0x18000080, 0xd3d94070, 0x18000080, 0xd3d94071, 0x18000080, 0xd3d94072,
+	0x18000080, 0xd3d94073, 0x18000080, 0xd3d94074, 0x18000080, 0xd3d94075,
+	0x18000080, 0xd3d94076, 0x18000080, 0xd3d94077, 0x18000080, 0xd3d94078,
+	0x18000080, 0xd3d94079, 0x18000080, 0xd3d9407a, 0x18000080, 0xd3d9407b,
+	0x18000080, 0xd3d9407c, 0x18000080, 0xd3d9407d, 0x18000080, 0xd3d9407e,
+	0x18000080, 0xd3d9407f, 0x18000080, 0xd3d94080, 0x18000080, 0xd3d94081,
+	0x18000080, 0xd3d94082, 0x18000080, 0xd3d94083, 0x18000080, 0xd3d94084,
+	0x18000080, 0xd3d94085, 0x18000080, 0xd3d94086, 0x18000080, 0xd3d94087,
+	0x18000080, 0xd3d94088, 0x18000080, 0xd3d94089, 0x18000080, 0xd3d9408a,
+	0x18000080, 0xd3d9408b, 0x18000080, 0xd3d9408c, 0x18000080, 0xd3d9408d,
+	0x18000080, 0xd3d9408e, 0x18000080, 0xd3d9408f, 0x18000080, 0xd3d94090,
+	0x18000080, 0xd3d94091, 0x18000080, 0xd3d94092, 0x18000080, 0xd3d94093,
+	0x18000080, 0xd3d94094, 0x18000080, 0xd3d94095, 0x18000080, 0xd3d94096,
+	0x18000080, 0xd3d94097, 0x18000080, 0xd3d94098, 0x18000080, 0xd3d94099,
+	0x18000080, 0xd3d9409a, 0x18000080, 0xd3d9409b, 0x18000080, 0xd3d9409c,
+	0x18000080, 0xd3d9409d, 0x18000080, 0xd3d9409e, 0x18000080, 0xd3d9409f,
+	0x18000080, 0xd3d940a0, 0x18000080, 0xd3d940a1, 0x18000080, 0xd3d940a2,
+	0x18000080, 0xd3d940a3, 0x18000080, 0xd3d940a4, 0x18000080, 0xd3d940a5,
+	0x18000080, 0xd3d940a6, 0x18000080, 0xd3d940a7, 0x18000080, 0xd3d940a8,
+	0x18000080, 0xd3d940a9, 0x18000080, 0xd3d940aa, 0x18000080, 0xd3d940ab,
+	0x18000080, 0xd3d940ac, 0x18000080, 0xd3d940ad, 0x18000080, 0xd3d940ae,
+	0x18000080, 0xd3d940af, 0x18000080, 0xd3d940b0, 0x18000080, 0xd3d940b1,
+	0x18000080, 0xd3d940b2, 0x18000080, 0xd3d940b3, 0x18000080, 0xd3d940b4,
+	0x18000080, 0xd3d940b5, 0x18000080, 0xd3d940b6, 0x18000080, 0xd3d940b7,
+	0x18000080, 0xd3d940b8, 0x18000080, 0xd3d940b9, 0x18000080, 0xd3d940ba,
+	0x18000080, 0xd3d940bb, 0x18000080, 0xd3d940bc, 0x18000080, 0xd3d940bd,
+	0x18000080, 0xd3d940be, 0x18000080, 0xd3d940bf, 0x18000080, 0xd3d940c0,
+	0x18000080, 0xd3d940c1, 0x18000080, 0xd3d940c2, 0x18000080, 0xd3d940c3,
+	0x18000080, 0xd3d940c4, 0x18000080, 0xd3d940c5, 0x18000080, 0xd3d940c6,
+	0x18000080, 0xd3d940c7, 0x18000080, 0xd3d940c8, 0x18000080, 0xd3d940c9,
+	0x18000080, 0xd3d940ca, 0x18000080, 0xd3d940cb, 0x18000080, 0xd3d940cc,
+	0x18000080, 0xd3d940cd, 0x18000080, 0xd3d940ce, 0x18000080, 0xd3d940cf,
+	0x18000080, 0xd3d940d0, 0x18000080, 0xd3d940d1, 0x18000080, 0xd3d940d2,
+	0x18000080, 0xd3d940d3, 0x18000080, 0xd3d940d4, 0x18000080, 0xd3d940d5,
+	0x18000080, 0xd3d940d6, 0x18000080, 0xd3d940d7, 0x18000080, 0xd3d940d8,
+	0x18000080, 0xd3d940d9, 0x18000080, 0xd3d940da, 0x18000080, 0xd3d940db,
+	0x18000080, 0xd3d940dc, 0x18000080, 0xd3d940dd, 0x18000080, 0xd3d940de,
+	0x18000080, 0xd3d940df, 0x18000080, 0xd3d940e0, 0x18000080, 0xd3d940e1,
+	0x18000080, 0xd3d940e2, 0x18000080, 0xd3d940e3, 0x18000080, 0xd3d940e4,
+	0x18000080, 0xd3d940e5, 0x18000080, 0xd3d940e6, 0x18000080, 0xd3d940e7,
+	0x18000080, 0xd3d940e8, 0x18000080, 0xd3d940e9, 0x18000080, 0xd3d940ea,
+	0x18000080, 0xd3d940eb, 0x18000080, 0xd3d940ec, 0x18000080, 0xd3d940ed,
+	0x18000080, 0xd3d940ee, 0x18000080, 0xd3d940ef, 0x18000080, 0xd3d940f0,
+	0x18000080, 0xd3d940f1, 0x18000080, 0xd3d940f2, 0x18000080, 0xd3d940f3,
+	0x18000080, 0xd3d940f4, 0x18000080, 0xd3d940f5, 0x18000080, 0xd3d940f6,
+	0x18000080, 0xd3d940f7, 0x18000080, 0xd3d940f8, 0x18000080, 0xd3d940f9,
+	0x18000080, 0xd3d940fa, 0x18000080, 0xd3d940fb, 0x18000080, 0xd3d940fc,
+	0x18000080, 0xd3d940fd, 0x18000080, 0xd3d940fe, 0x18000080, 0xd3d940ff,
+	0x18000080, 0xb07c0000, 0xbe8a00ff, 0x000000f8, 0xbf11080a, 0x7e000280,
+	0x7e020280, 0x7e040280, 0x7e060280, 0x7e080280, 0x7e0a0280, 0x7e0c0280,
+	0x7e0e0280, 0x808a880a, 0xbe80320a, 0xbf84fff5, 0xbf9c0000, 0xd28c0001,
+	0x0001007f, 0xd28d0001, 0x0002027e, 0x10020288, 0xb88b0904, 0xb78b4000,
+	0xd1196a01, 0x00001701, 0xbe8a0087, 0xbefc00c1, 0xd89c4000, 0x00020201,
+	0xd89cc080, 0x00040401, 0x320202ff, 0x00000800, 0x808a810a, 0xbf84fff8,
+	0xbf810000,
+};
+
+const struct soc15_reg_entry vgpr_init_regs_aldebaran[] = {
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_RESOURCE_LIMITS), 0x0000000 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_X), 0x40 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 4 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0xbf },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x400004 },  /* 64KB LDS */
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x3F }, /*  63 - accum-offset = 256 */
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE4), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE5), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE6), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE7), 
+0xffffffff }, };
+
+static const u32 sgpr_init_compute_shader_aldebaran[] = {
+	0xb8840904, 0xb8851a04, 0xb8861344, 0x9207c006, 0x92088405, 0x81070807,
+	0x81070407, 0x8e078207, 0xbefc0006, 0xbf800000, 0xbf900001, 0xbe88008f,
+	0xc0410200, 0x00000007, 0xb07c0000, 0xbe8000ff, 0x0000005f, 0xbee50080,
+	0xbe812c65, 0xbe822c65, 0xbe832c65, 0xbe842c65, 0xbe852c65, 0xb77c0005,
+	0x80808500, 0xbf84fff8, 0xbe800080, 0xbf810000, };
+
+static const struct soc15_reg_entry sgpr1_init_regs_aldebaran[] = {
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_RESOURCE_LIMITS), 0x0000000 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_X), 0x40 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 8 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x240 }, /* (80 GPRS): SGPRS[9:6] VGPRS[5:0] */
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x4 }, /* USER_SGPR[5:1]*/
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x3F }, /*  63 - accum-offset = 256 */
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0x000000ff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0x000000ff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0x000000ff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0x000000ff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE4), 0x000000ff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE5), 0x000000ff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE6), 0x000000ff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE7), 
+0x000000ff }, };
+
+static const struct soc15_reg_entry sgpr2_init_regs_aldebaran[] = {
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_RESOURCE_LIMITS), 0x0000000 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_X), 0x40 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 8 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0x240 }, /* (80 GPRS) */
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0x4 }, /* USER_SGPR[5:1]*/
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0x3F }, /*  63 - accum-offset = 256 */
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0x0000ff00 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0x0000ff00 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0x0000ff00 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0x0000ff00 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE4), 0x0000ff00 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE5), 0x0000ff00 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE6), 0x0000ff00 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE7), 
+0x0000ff00 }, };
+
+static int gfx_v9_4_2_check_gprs_init_coverage(struct amdgpu_device *adev,
+					       uint32_t *wb)
+{
+	uint32_t se_id, cu_id, simd_id;
+	uint32_t simd_cnt = 0;
+	uint32_t se_offset, cu_offset, data;
+
+	for (se_id = 0; se_id < adev->gfx.config.max_shader_engines; se_id++) {
+		se_offset = se_id * 16 * 4;
+		for (cu_id = 0; cu_id < 16; cu_id++) {
+			cu_offset = cu_id * 4;
+			for (simd_id = 0; simd_id < 4; simd_id++) {
+				data = wb[se_offset + cu_offset + simd_id];
+				if (data == 0xF)
+					simd_cnt++;
+			}
+		}
+	}
+
+	if (adev->gfx.cu_info.number * 4 == simd_cnt)
+		return 0;
+
+	dev_warn(adev->dev, "SIMD Count: %d, %d\n",
+		 adev->gfx.cu_info.number * 4, simd_cnt);
+
+	for (se_id = 0; se_id < adev->gfx.config.max_shader_engines; se_id++) {
+		se_offset = se_id * 16 * 4;
+		for (cu_id = 0; cu_id < 16; cu_id++) {
+			cu_offset = cu_id * 4;
+			for (simd_id = 0; simd_id < 4; simd_id++) {
+				data = wb[se_offset + cu_offset + simd_id];
+				if (data != 0xF)
+					dev_warn(adev->dev, "SE[%d]CU[%d]SIMD[%d]: isn't inited\n",
+						se_id, cu_id, simd_id);
+			}
+		}
+	}
+
+	return -EFAULT;
+}
+
+static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
+				 const uint32_t *shader_ptr, uint32_t shader_size,
+				 const struct soc15_reg_entry *init_regs, uint32_t regs_size,
+				 uint32_t compute_dim_x, u64 wb_gpu_addr) {
+	struct amdgpu_ring *ring = &adev->gfx.compute_ring[0];
+	struct amdgpu_ib ib;
+	struct dma_fence *f = NULL;
+	int r, i;
+	uint32_t total_size, shader_offset;
+	u64 gpu_addr;
+
+	total_size = (regs_size * 3 + 4 + 4 + 5 + 2) * 4;
+	total_size = ALIGN(total_size, 256);
+	shader_offset = total_size;
+	total_size += ALIGN(shader_size, 256);
+
+	/* allocate an indirect buffer to put the commands in */
+	memset(&ib, 0, sizeof(ib));
+	r = amdgpu_ib_get(adev, NULL, total_size,
+					AMDGPU_IB_POOL_DIRECT, &ib);
+	if (r) {
+		DRM_ERROR("amdgpu: failed to get ib (%d).\n", r);
+		return r;
+	}
+
+	/* load the compute shaders */
+	for (i = 0; i < shader_size/sizeof(u32); i++)
+		ib.ptr[i + (shader_offset / 4)] = shader_ptr[i];
+
+	/* init the ib length to 0 */
+	ib.length_dw = 0;
+
+	/* write the register state for the compute dispatch */
+	for (i = 0; i < regs_size; i++) {
+		ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 1);
+		ib.ptr[ib.length_dw++] = SOC15_REG_ENTRY_OFFSET(init_regs[i])
+								- PACKET3_SET_SH_REG_START;
+		ib.ptr[ib.length_dw++] = init_regs[i].reg_value;
+	}
+
+	/* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PGM_HI */
+	gpu_addr = (ib.gpu_addr + (u64)shader_offset) >> 8;
+	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
+	ib.ptr[ib.length_dw++] = SOC15_REG_OFFSET(GC, 0, regCOMPUTE_PGM_LO)
+							- PACKET3_SET_SH_REG_START;
+	ib.ptr[ib.length_dw++] = lower_32_bits(gpu_addr);
+	ib.ptr[ib.length_dw++] = upper_32_bits(gpu_addr);
+
+	/* write the wb buffer address */
+	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_SET_SH_REG, 2);
+	ib.ptr[ib.length_dw++] = SOC15_REG_OFFSET(GC, 0, regCOMPUTE_USER_DATA_0)
+							- PACKET3_SET_SH_REG_START;
+	ib.ptr[ib.length_dw++] = lower_32_bits(wb_gpu_addr);
+	ib.ptr[ib.length_dw++] = upper_32_bits(wb_gpu_addr);
+
+	/* write dispatch packet */
+	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_DISPATCH_DIRECT, 3);
+	ib.ptr[ib.length_dw++] = compute_dim_x; /* x */
+	ib.ptr[ib.length_dw++] = 1; /* y */
+	ib.ptr[ib.length_dw++] = 1; /* z */
+	ib.ptr[ib.length_dw++] =
+		REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHADER_EN, 1);
+
+	/* write CS partial flush packet */
+	ib.ptr[ib.length_dw++] = PACKET3(PACKET3_EVENT_WRITE, 0);
+	ib.ptr[ib.length_dw++] = EVENT_TYPE(7) | EVENT_INDEX(4);
+
+	/* shedule the ib on the ring */
+	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
+	if (r) {
+		DRM_ERROR("amdgpu: ib submit failed (%d).\n", r);
+		goto fail;
+	}
+
+	/* wait for the GPU to finish processing the IB */
+	r = dma_fence_wait(f, false);
+	if (r) {
+		DRM_ERROR("amdgpu: fence wait failed (%d).\n", r);
+		goto fail;
+	}
+fail:
+	amdgpu_ib_free(adev, &ib, NULL);
+	dma_fence_put(f);
+
+	return r;
+}
+
+int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev) {
+	struct amdgpu_ring *ring = &adev->gfx.compute_ring[0];
+	int r;
+	int compute_dim_x = adev->gfx.config.max_shader_engines *
+			    adev->gfx.config.max_cu_per_sh *
+			    adev->gfx.config.max_sh_per_se;
+	int sgpr_work_group_size = 5;
+	/* CU_ID: 0~15, SIMD_ID: 0~3 */
+	int wb_size = adev->gfx.config.max_shader_engines * 16 * 4;
+	struct amdgpu_ib ib;
+
+	/* only support when RAS is enabled */
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
+		return 0;
+
+	/* bail if the compute ring is not ready */
+	if (!ring->sched.ready)
+		return 0;
+
+	/* allocate an indirect buffer to put the commands in */
+	memset(&ib, 0, sizeof(ib));
+	r = amdgpu_ib_get(adev, NULL, wb_size * sizeof(uint32_t),
+			  AMDGPU_IB_POOL_DIRECT, &ib);
+	if (r) {
+		DRM_ERROR("amdgpu: failed to get ib (%d).\n", r);
+		return r;
+	}
+
+	memset(ib.ptr, 0, wb_size * sizeof(uint32_t));
+	r = gfx_v9_4_2_run_shader(adev, vgpr_init_compute_shader_aldebaran,
+				  sizeof(vgpr_init_compute_shader_aldebaran),
+				  vgpr_init_regs_aldebaran,
+				  ARRAY_SIZE(vgpr_init_regs_aldebaran),
+				  compute_dim_x * 2, ib.gpu_addr);
+	if (r) {
+		dev_err(adev->dev, "Init VGPRS: failed to run shader\n");
+		goto failed;
+	}
+
+	r = gfx_v9_4_2_check_gprs_init_coverage(adev, ib.ptr);
+	if (r) {
+		dev_err(adev->dev, "Init VGPRS: failed to cover all CUs\n");
+		goto failed;
+	} else {
+		dev_info(adev->dev, "Init VGPRS Successfully\n");
+	}
+
+	memset(ib.ptr, 0, wb_size * sizeof(uint32_t));
+	r = gfx_v9_4_2_run_shader(adev, sgpr_init_compute_shader_aldebaran,
+				  sizeof(sgpr_init_compute_shader_aldebaran),
+				  sgpr1_init_regs_aldebaran,
+				  ARRAY_SIZE(sgpr1_init_regs_aldebaran),
+				  compute_dim_x / 2 * sgpr_work_group_size,
+				  ib.gpu_addr);
+	if (r) {
+		dev_err(adev->dev, "Init SGPRS Part1: failed to run shader\n");
+		goto failed;
+	}
+
+	r = gfx_v9_4_2_run_shader(adev, sgpr_init_compute_shader_aldebaran,
+				  sizeof(sgpr_init_compute_shader_aldebaran),
+				  sgpr2_init_regs_aldebaran,
+				  ARRAY_SIZE(sgpr2_init_regs_aldebaran),
+				  compute_dim_x / 2 * sgpr_work_group_size,
+				  ib.gpu_addr);
+	if (r) {
+		dev_err(adev->dev, "Init SGPRS Part2: failed to run shader\n");
+		goto failed;
+	}
+
+	r = gfx_v9_4_2_check_gprs_init_coverage(adev, ib.ptr);
+	if (r)
+		dev_err(adev->dev,
+			"Init SGPRS Part2: failed to cover all CUs\n");
+	else
+		dev_info(adev->dev, "Init SGPRS Successfully\n");
+
+failed:
+	amdgpu_ib_free(adev, &ib, NULL);
+	return r;
+}
+
 static void gfx_v9_4_2_query_sq_timeout_status(struct amdgpu_device *adev);  static void gfx_v9_4_2_reset_sq_timeout_status(struct amdgpu_device *adev);
 
@@ -808,8 +1180,9 @@ static struct gfx_v9_4_2_utc_block gfx_v9_4_2_utc_blocks[] = {
 	  REG_SET_FIELD(0, ATC_L2_CACHE_4K_DSM_CNTL, WRITE_COUNTERS, 1) },  };
 
-static const struct soc15_reg_entry gfx_v9_4_2_rdrsp_status_regs =
-	{ SOC15_REG_ENTRY(GC, 0, regGCEA_ERR_STATUS), 0, 1, 16 };
+static const struct soc15_reg_entry gfx_v9_4_2_rdrsp_status_regs = {
+	SOC15_REG_ENTRY(GC, 0, regGCEA_ERR_STATUS), 0, 1, 16 };
 
 static int gfx_v9_4_2_get_reg_error_count(struct amdgpu_device *adev,
 					  const struct soc15_reg_entry *reg, diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
index 81c5833b6b9f..6db1f88509af 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
@@ -29,6 +29,7 @@ void gfx_v9_4_2_debug_trap_config_init(struct amdgpu_device *adev,  void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
 				      uint32_t die_id);
 void gfx_v9_4_2_set_power_brake_sequence(struct amdgpu_device *adev);
+int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev);
 
 extern const struct amdgpu_gfx_ras_funcs gfx_v9_4_2_ras_funcs;
 
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

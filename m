Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738A2C11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 10:38:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D39F61DA7
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 10:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D39F61DA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2E5B89E63;
	Tue, 29 Jun 2021 10:38:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 779CC89E63
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 10:38:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZ/MTvz6kZuKHx/t08Zue6N0cZDinEQQ0oaPezMf+P2MZQYpr9D+hICfPPIVwJWH9Y6i8XUSU2bcpz/P1AGniDEdBfJigcek6ZxiA+fkN3sdmqeBgAy+cm5ltDzaLKDnP84yyhKNDW2cu/cNkvHXex3VepGZ9EigvJB7Sa8FwJ3ZP9ZNW7cHG99vgaLSk5obJD/x5bdWZEDl++vjFU2oBwvbU+YuCkA9kT9iecrwi4qLyrRC6ZanyAADGJVpwIUNDa2XyMK3cVqQ04kYdKGLK54Cwe4gRYW3BLN/75r3kTJZwdvwvfZGBzhYfvxfTPatqwSRbT5KWSNR0JEfhGQZSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lnP+F/929Y2MDJ8+i/BTLzIaRQnfOiH+WClmwGxhP0=;
 b=Nz+vePfIhRX21Dw2G/2FQyPc3dAS3m4YbkVo7psVQAhFIRsYcxxhXAsV40SjAhesumC27Zs3Fb8gk8oecZZWjM/Usa0erM6a5J83aF1oc8+0gI/PCK0yGSmXYyZ4ENe22zai5qaEJIiOgnBxrhhqQawNy6pf8jq5Aw573gRXCEbEPXhMUYSIkecpz9d3qTe2cE3ZHw/ThuQN8M9gJSq8AirIGCOt2SUcrkg0lVCQLeXCDISWuooEiXSKhf7OgtKTQxSBaROu5Aks+cwQaY23mNOc3xIBeXinmzlwNHrQ7tPvA7Lcv1YQNr+W9K+kEH7ofQ7a9q97cKilvfoHKY85LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lnP+F/929Y2MDJ8+i/BTLzIaRQnfOiH+WClmwGxhP0=;
 b=U3puj4POuts8Z3qOjMfsm5WWQZIAtMeM5k+fBENQya0iQ0s8PkKKlS62eeRGTC0178C7bVEfTS3aCAoKLwER2jRUL2s7/n6wEJFKKGLF1pdAPukN3tW3QDRXGlK32ncY2yFMIG+cXb/50nngosPQSbq029XRgvzH+Z7E4O8YNm0=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by BL1PR12MB5352.namprd12.prod.outlook.com (2603:10b6:208:314::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 29 Jun
 2021 10:38:34 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::d9d7:2d92:acc3:e3c3]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::d9d7:2d92:acc3:e3c3%3]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 10:38:34 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Wang, YuBiao" <YuBiao.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: Read clock counter via MMIO to reduce
 delay
Thread-Topic: [PATCH 1/1] drm/amdgpu: Read clock counter via MMIO to reduce
 delay
Thread-Index: AQHXbM3BQcP6UMUkmkKZ31dmYrnNvKsqzARw
Date: Tue, 29 Jun 2021 10:38:34 +0000
Message-ID: <BL1PR12MB52698525298FA46A94604DFD84029@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <20210629100129.1913032-1-YuBiao.Wang@amd.com>
In-Reply-To: <20210629100129.1913032-1-YuBiao.Wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-29T10:38:33Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=a01b6aef-6b92-4052-bfcd-2b0158690e79;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32d5eb44-9bd1-462e-19f6-08d93aea0c0b
x-ms-traffictypediagnostic: BL1PR12MB5352:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL1PR12MB5352FCA53CC942B8D77390E084029@BL1PR12MB5352.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BXiV4T+sIY9yLs6nPvWFY9OJcHlTYREtj5/9wXNJDKZeSqH2660Vtn3fEVfLBhf4EdqJEodCOZCIPiFC6W8Kj8awEZ9CP8+pTiR9nuNWvgZNvyA7W4CKRCBU0TlOul2aaJlLmFz39OUc/LtcfSgx782uvn40Oe2xFImYbGZg7sVNg1iKHUA7ts31fioMn1NG78qub1Wev70UtkZbNMo2kMoKMS5bNAYv/OisGCtHQgu7mBBp2E8OS3YRzqY9FcUIlZQ73rp9VNwsiWaTCy99uI920xtUBOzdCD5eNTrQGMBFvMUPED9CK0HfNu36XoUZmLGVZ87dHmg2Y57VJIawod+ZEP4usmgSLngNuWjgK4fvwTkjDbjT8ZdxuuPBVhnS5m/2+utUnpBUMa6df5cg19cm1aFwGRGXoAhJszEiY9ClW9Eu7AioCmU+mIZfRDsh09FuENdToE77rpnq78xNoo1Jr62cKiaIK27sXodEn/uW/RuvW4cvg+UEnBwZxvtNWS3e9hYWyuCOmQIyCibxg9jx2/+2kDaXmvLfNOXZPVUP4D7c22C+Qkn3NNg3N4tB0h7RqAstyMRLvq2L6FfG/JL9tlKCd+VL+YlpcKhD4b9m9bslf6paXvzOrpCKjVKS2JZjy4TKaFwL8Ezwyjqtog==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(9686003)(33656002)(86362001)(8936002)(186003)(4326008)(83380400001)(55016002)(26005)(71200400001)(8676002)(53546011)(6506007)(66946007)(2906002)(5660300002)(64756008)(66446008)(38100700002)(66556008)(110136005)(478600001)(52536014)(54906003)(7696005)(66476007)(122000001)(76116006)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UmwEnHWkGZmhv6MKA3up8VbbzsXZZSSlWOOzRUxNMwDtdJBg6eQGfPfZia7y?=
 =?us-ascii?Q?iNvq5O4U4+ou4wpwVOvyZu4QDNyO3CFYJ9Kc8QJubLBQMlbozhg2UPtsuETz?=
 =?us-ascii?Q?H863+uXiHBu6pm8e6m8Tdpu1Bwh/YqTTzAvYrzHrYDgOVW4hB2TtTv28ZwFI?=
 =?us-ascii?Q?XjTb6uTk7siIVdVm14b4PuqL/shmGyExBLnaTE3+XKFIjmwMCXayux9Nnja6?=
 =?us-ascii?Q?gb8KolPyJUk4u8Rxy+0paA+1/OlI0I1ms8WX8TsOrIuMTVoCb7IC1mWwJm+F?=
 =?us-ascii?Q?JKqaiE8qI8SeWr6vDVG4ib8yJkwvFujNXRn0I8V1rrOETxVHAaIsoDoKSVTJ?=
 =?us-ascii?Q?8onSuU1njdJtfGyHaCdqZQl/v72sA16Uk0Ounf/a+/jZooEWjThi3mI4ScT0?=
 =?us-ascii?Q?ddXVAznBFOhKNbywFCqy6xmucsm9rCD4FBbF63yOaUq5olqSpg9oa5SJIleQ?=
 =?us-ascii?Q?BJKIwx9A1JZx0XsKszPingyYjKEAEp9FdC7f7bJJu0hlnjCRUXHTD6c3xtwD?=
 =?us-ascii?Q?Z7roy0H5q2UUWn9pu99YdzSlhpkHzqd75R06Oel8feaJTZtaXgotg6tNZ/cz?=
 =?us-ascii?Q?G1hoIwc7XCISudl+nJSKq+TUqF5Yi2Izv1n4Hb/TlmuH5dLuIRyrmez6JfLy?=
 =?us-ascii?Q?tolaBG/LgaqWID9PqxZNjjLCjKEjUvcuc0c50VrglUyqfjxuxaY8URQf2uw+?=
 =?us-ascii?Q?r4U6ZIZnGr1NpJ10Egq/1jVSDFUmzb2F1cWfqIu+Ga9WCJ8nw0bTAlNul5nj?=
 =?us-ascii?Q?h116TVyP80lLQaFR2Bzsf8OmQVF8mr1RYcGWCmUFFW4svaAU4vqvutG/C5F+?=
 =?us-ascii?Q?QKN8wQ07O/GJ5O5PLoLkDfoKx6VXiE7YdrZN+bCsSKJgHX58YGVTViGu4DXi?=
 =?us-ascii?Q?pcr0F8b9Fcv942kxgVACXETi3iKcn5w3JLibHcK7n/nw5nQXOk/Lf8Y9YLni?=
 =?us-ascii?Q?vcZITFKdXLxilZ3lbc3tI1TQJfsVDIfQu0aSq8gPUD3xSiy6oR7ulg0FJwv8?=
 =?us-ascii?Q?j1lvXDm0SCNnls+aDFuHGRkEMPvXPjcicJZys3VoQKUuuNx22QFJsUKscyT/?=
 =?us-ascii?Q?kxBK6PTEcGntIw84MBvhW+Wlb5ofyN3wC85T3BmzjkeIBzXnsR67y2HEsxHK?=
 =?us-ascii?Q?Z6Ze5fDaXSbTUUz0xLh/Mnhsu3oOeN0qR3snmJh2mscs9zL56MOMJqv7+NBx?=
 =?us-ascii?Q?KPVLsq+ywsRZ+pICyQ3cdcqNgzXwKVNC1CY6g2OrQjo0bSp+IR3/l7KLNd/J?=
 =?us-ascii?Q?WHpUOnhtESy+nREAnI8E/6WgkfulX1QldFGcb+Uz9B6fWr82hVb0EdUUv/6I?=
 =?us-ascii?Q?skMjqzp1DBDlewqIammoMmwH?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d5eb44-9bd1-462e-19f6-08d93aea0c0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 10:38:34.6954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ILjfxg8/M0lgJR8+hc/Zf2fpRzuxWhde30n44tgHPilQ+sW0x+ehzuAN/PAGaIH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5352
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
Cc: "Wang,
 YuBiao" <YuBiao.Wang@amd.com>, "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "Xiao, Jack" <Jack.Xiao@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>, "Chen,
 Horace" <Horace.Chen@amd.com>, "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Please do not use "//" in linux kernel patch , use "/*   */" instead

After this part fixed the patch is : Reviewed-by: Monk Liu <monk.liu@amd.com>

Thanks 

------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: YuBiao Wang <YuBiao.Wang@amd.com> 
Sent: Tuesday, June 29, 2021 6:01 PM
To: amd-gfx@lists.freedesktop.org
Cc: Grodzovsky, Andrey <Andrey.Grodzovsky@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Wang, YuBiao <YuBiao.Wang@amd.com>
Subject: [PATCH 1/1] drm/amdgpu: Read clock counter via MMIO to reduce delay

[Why]
GPU timing counters are read via KIQ under sriov, which will introduce a delay.

[How]
It could be directly read by MMIO.

v2: Add additional check to prevent carryover issue.
v3: Only check for carryover for once to prevent performance issue.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
Acked-by: Horace Chen <horace.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index ff7e9f49040e..82a5b7ab8dc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7610,6 +7610,7 @@ static int gfx_v10_0_soft_reset(void *handle)  static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)  {
 	uint64_t clock;
+	uint64_t clock_lo, clock_hi, hi_check;
 
 	amdgpu_gfx_off_ctrl(adev, false);
 	mutex_lock(&adev->gfx.gpu_clock_mutex);
@@ -7620,8 +7621,15 @@ static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER_Vangogh) << 32ULL);
 		break;
 	default:
-		clock = (uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER) |
-			((uint64_t)RREG32_SOC15(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER) << 32ULL);
+		clock_hi = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER);
+		clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER);
+		hi_check = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_UPPER);
+		// If carryover happens, update lower count again.
+		if (hi_check != clock_hi) {
+			clock_lo = RREG32_SOC15_NO_KIQ(SMUIO, 0, mmGOLDEN_TSC_COUNT_LOWER);
+			clock_hi = hi_check;
+		}
+		clock = (uint64_t)clock_lo | ((uint64_t)clock_hi << 32ULL);
 		break;
 	}
 	mutex_unlock(&adev->gfx.gpu_clock_mutex);
--
2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
